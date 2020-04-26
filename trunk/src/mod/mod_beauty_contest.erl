%%%------------------------------------
%%% @author 严利宏 <542430172@qq.com>
%%% @copyright UCweb 2014.10.13
%%% @doc 女妖选美 抽奖活动 统计器.
%%% @end
%%%------------------------------------

-module(mod_beauty_contest).
-behaviour(gen_server).
-export([start_link/0,stop/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-export([beauty_contest_open/2      % 活动开启初始化（由活动管理器调用）
        ,beauty_contest_close/2     % 活动关闭（由活动管理器调用）
        ,beauty_contest_counter/4   % 抽奖统计
        ,get_next_big_reward_time/0 % 获取下次发大奖时间
    ]).

-include("prompt_msg_code.hrl").
-include("ets_name.hrl").
-include("debug.hrl").
-include("common.hrl").
-include("log.hrl").
-include("record.hrl").
-include("beauty_contest.hrl").

-define(WRITE_DATA_TO_DB_INTERVAL, 300). % 每300秒持续化一次数据


%%=========================================================================
%% 接口函数
%%=========================================================================

%% 抽奖统计
beauty_contest_counter(ActId, PS, Goods, AddCount) ->
    gen_server:cast(?MODULE, {gamble_counter, ActId, PS, Goods, AddCount}).

%% 活动开启初始化（由活动管理器调用）
beauty_contest_open(ActId, ActData) ->
    gen_server:cast(?MODULE, {beauty_contest_open, ActId, ActData}),
    ok.

%% 活动关闭（由活动管理器调用）
beauty_contest_close(ActId, ActData) ->
    gen_server:cast(?MODULE, {beauty_contest_close, ActId, ActData}),
    ok.

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).
stop() ->
    gen_server:call(?MODULE, stop).

%%=========================================================================
%% 回调函数
%%=========================================================================
init([]) ->
    process_flag(trap_exit, true),
    % 初始化状态ets
    ets:new(?ETS_BEAUTY_CONTEST_STATUS, [{keypos, #ets_beauty_contest_status.id}, named_table, public, set]),
    % 女妖选美玩家缓存
    ets:new(?ETS_BEAUTY_CONTEST_CACHE, [{keypos, 1}, named_table, public, set]),
    {ok, none}.

handle_call(stop, _From, State) ->
    {stop, normal, stopped, State};
handle_call(Request, _From, State) -> 
    try 
		do_call(Request, _From, State)
    catch
        _Err:_Reason ->
            ?ERROR_MSG("handle_call *** [~p:~p] ~p ***~n", [_Err, _Reason, erlang:get_stacktrace()]),
            {reply, error, State}
    end.

do_call(_Request, _From, State) ->
    throw({no_match, do_call, _Request}),
	{reply, ok, State}.


handle_cast(Request, State)-> 
	try 
		do_cast(Request, State)
    catch
        _Err:_Reason ->
            ?ERROR_MSG("handle_cast *** [~p:~p] ~p ***~n", [_Err, _Reason, erlang:get_stacktrace()]),
            {noreply, State}
    end.

%% 活动开启初始化
do_cast({beauty_contest_open, ActId, ActData}, State) ->
    % 加载统计数据
    CounterDict = case db:kv_lookup(beauty_contest_counter, ActId) of []->dict:new(); [_D|_]->_D end,
    put(?COUNTER(ActId), CounterDict),
    % 加载重要物品记录
    GoodsRecord = case db:kv_lookup(beauty_contest_goods_record, ActId) of []->[]; [_G|_]->_G end,
    % 记录活动状态到ets
    [[BigRewardGoods, LuckyRewardGoods], EmailContent, EmailTitle] = ActData,
    ets:insert(?ETS_BEAUTY_CONTEST_STATUS, #ets_beauty_contest_status{id=ActId
                                                                     ,open_status=1
                                                                     ,import_goods_record = GoodsRecord
                                                                     ,big_reward_goods = BigRewardGoods
                                                                     ,lucky_reward_goods = LuckyRewardGoods
                                                                     ,email_content = EmailContent
                                                                     ,email_title = EmailTitle
                                                                 }),
    % 每隔5分钟持久化一次数据
    erlang:send_after(?WRITE_DATA_TO_DB_INTERVAL*1000, self(), {write_beauty_contest_data_to_db, ActId}),
    % 凌晨0小时结算超级大奖 
    catch erlang:cancel_timer(erlang:get({timer_ref, ActId})), % 防止外部多次开启活动后开多个定时器
    NextBigRewardTime = get_next_big_reward_time(),
    TRef = erlang:send_after(NextBigRewardTime*1000, self(), {big_reward_time, ActId}),
    erlang:put({timer_ref, ActId}, TRef),
    {noreply, State};
%% 活动关闭
do_cast({beauty_contest_close, ActId, _ActData}, State) ->
    case ets:lookup(?ETS_BEAUTY_CONTEST_STATUS, ActId) of
        [] -> skip;
        [BCStatus] when is_record(BCStatus, ets_beauty_contest_status) ->
            ets:insert(?ETS_BEAUTY_CONTEST_STATUS, BCStatus#ets_beauty_contest_status{open_status=0})
    end,
    {noreply, State};
%% 玩家抽奖统计数据（统计的是消耗数量，而不是抽奖次数）
do_cast({gamble_counter, ActId, PS, Goods, AddCount}, State) ->
    % 抽奖统计
    case get(?COUNTER(ActId)) of
        undefined -> 
            put(?COUNTER(ActId), dict:update_counter(player:id(PS), AddCount, dict:new()));
        CounterDict ->
            put(?COUNTER(ActId), dict:update_counter(player:id(PS), AddCount, CounterDict))
    end,
    % 重要物品记录
    case Goods#beauty_contest_goods.quality > 3 of
        false -> skip;
        true ->
            case ets:lookup(?ETS_BEAUTY_CONTEST_STATUS, ActId) of
                [] -> 
                    ?ASSERT(false, {ActId, Goods}), 
                    skip;
                [BCStatus] when is_record(BCStatus, ets_beauty_contest_status) ->
                    RecordItem = {player:get_name(PS)
                                 ,Goods#beauty_contest_goods.goods_id
                                 ,Goods#beauty_contest_goods.quality
                                 ,Goods#beauty_contest_goods.num
                             },
                    NewImpGoodsRecord = lists:sublist([RecordItem|BCStatus#ets_beauty_contest_status.import_goods_record], 1, 10),
                    ets:insert(?ETS_BEAUTY_CONTEST_STATUS, BCStatus#ets_beauty_contest_status{import_goods_record=NewImpGoodsRecord}),
                    % 公告
                    case Goods#beauty_contest_goods.quality >= 5 of
                        false -> skip;
                        true -> 
                            mod_broadcast:send_sys_broadcast(111, [player:get_name(PS)
                                                                  ,player:id(PS)
                                                                  ,Goods#beauty_contest_goods.goods_id
                                                                  ,Goods#beauty_contest_goods.quality
                                                                  ,Goods#beauty_contest_goods.num
                                                              ]) 
                    end,
                    ok
            end
    end,
    {noreply, State};
do_cast(_Request, State) ->
    throw({no_match, do_cast, _Request}),
	{noreply, State}.


handle_info(Request, State)->  
    try 
		do_info(Request, State)
    catch
        _Err:_Reason ->
            ?ERROR_MSG("handle_info *** [~p:~p] ~p ***~n", [_Err, _Reason, erlang:get_stacktrace()]),
            {noreply, State}
    end.

%% 超级大奖时间
do_info({big_reward_time, ActId}, State) ->
    case ets:lookup(?ETS_BEAUTY_CONTEST_STATUS, ActId) of
        [] -> skip;
        [BCStatus] when is_record(BCStatus, ets_beauty_contest_status) ->
                % 发放奖励
                send_big_reward_email(ActId, BCStatus),
                % 清空数据
                db:kv_insert(beauty_contest_counter, ActId, dict:new()),
                put(?COUNTER(ActId), dict:new()),
                ok
    end,
    % 开启下次发放奖励定时器
    catch erlang:cancel_timer(erlang:get({timer_ref, ActId})),
    NextBigRewardTime = get_next_big_reward_time(),
    TRef = erlang:send_after(NextBigRewardTime*1000, self(), {big_reward_time, ActId}),
    erlang:put({timer_ref, ActId}, TRef),
    {noreply, State};
do_info({write_beauty_contest_data_to_db, ActId}, State) ->
    write_beauty_contest_data_to_db(ActId),
    erlang:send_after(?WRITE_DATA_TO_DB_INTERVAL*1000, self(), {write_beauty_contest_data_to_db, ActId}),
    {noreply, State};
do_info(_Request, State) ->
    throw({no_match, do_info, _Request}),
	{noreply, State}.

terminate(_Reason, _State) ->
    ?TRY_CATCH(write_all_beauty_contest_data_to_db()),
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.


%%=========================================================================
%% 私有函数
%%=========================================================================
% 持续化所有数据到数据库
write_all_beauty_contest_data_to_db() ->
    AllStatus = ets:tab2list(?ETS_BEAUTY_CONTEST_STATUS),
    [write_beauty_contest_data_to_db(ActId) || #ets_beauty_contest_status{id=ActId} <- AllStatus].

% 持续化数据到数据库
write_beauty_contest_data_to_db(ActId) ->
    % 持久化统计数据
    case get(?COUNTER(ActId)) of
        undefined -> skip;
        CounterDict ->
            db:kv_insert(beauty_contest_counter, ActId, CounterDict)
    end,
    % 持久化重要物品记录
    case ets:lookup(?ETS_BEAUTY_CONTEST_STATUS, ActId) of
        [] -> skip;
        [BCStatus] when is_record(BCStatus, ets_beauty_contest_status) ->
            db:kv_insert(beauty_contest_goods_record, ActId, BCStatus#ets_beauty_contest_status.import_goods_record)
    end,
    ok.

% 计算送心最多玩家
calc_big_reward_player(CounterDict) ->
    F = fun(PlayerId, Val, {AccPlayerId, AccVal}) ->
            case Val >= AccVal of
                true -> {PlayerId, Val};
                false ->{AccPlayerId, AccVal}
            end
    end,
    {RetPlayerId, _} = dict:fold(F, {0, 0}, CounterDict),
    RetPlayerId.

% 随机出超级幸运玩家 
calc_lucky_reward_player(CounterDict) ->
    Size = dict:size(CounterDict),
    case Size=:=0 of
        true -> 0;
        false ->
            Nth = util:rand(1, Size),
            {PlayerId, _} = lists:nth(Nth, dict:to_list(CounterDict)),
            PlayerId
    end.

% 发放大奖奖励（邮件发送）
send_big_reward_email(ActId, BCStatus) ->
    case get(?COUNTER(ActId)) of
        undefined -> 
            skip;
        CounterDict ->
            % 送心最多玩家
            BigRewardPlayerId = calc_big_reward_player(CounterDict),
            lib_mail:send_sys_mail(BigRewardPlayerId, 
                                   BCStatus#ets_beauty_contest_status.email_title, 
                                   BCStatus#ets_beauty_contest_status.email_content, 
                                   [BCStatus#ets_beauty_contest_status.big_reward_goods],
                                   [?LOG_BEAUTY_CONTEST, "super_prize"]
                               ),
            % 超级幸运玩家
            LuckyRewardPlayerId = calc_lucky_reward_player(CounterDict),
            lib_mail:send_sys_mail(LuckyRewardPlayerId, 
                                   BCStatus#ets_beauty_contest_status.email_title, 
                                   BCStatus#ets_beauty_contest_status.email_content, 
                                   [BCStatus#ets_beauty_contest_status.lucky_reward_goods],
                                   [?LOG_BEAUTY_CONTEST, "lucky_prize"]
                               ),
            ok
    end.

% 获取下次发放大奖时间
get_next_big_reward_time() ->
    Now = util:unixtime(), 
    % 当天0点时间戳
    TodayDawnT = util:get_day_dawn_timestamp(Now),
    % 当天0点到现在的秒数
    TodaySecond = Now - TodayDawnT,
    % 发奖时间点
    BeautyContestBigRewardTime = ?BEAUTY_CONTEST_BIG_REWARD_TIME,
    case BeautyContestBigRewardTime > TodaySecond of
        true -> % 发奖时间还没到
            BeautyContestBigRewardTime - TodaySecond;
        false -> % 发奖时间过了
            ?ONE_DAY_SECONDS - (TodaySecond - BeautyContestBigRewardTime)
    end.
    






