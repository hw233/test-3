%%%------------------------------------
%%% @author 严利宏 <542430172@qq.com>
%%% @copyright UCweb 2014.12.3
%%% @doc 赛马场管理器.
%%% @end
%%%------------------------------------

-module(mod_horse_race).
-behaviour(gen_server).
-export([start_link/0,stop/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-export([check_horse_race_activity_data/1    % 解析后台传过来的数据格式函数
        ,horse_race_open/2                   % 跑马场开启    
        ,horse_race_close/2                  % 跑马场关闭

    ]).
-compile(export_all).


-include("prompt_msg_code.hrl").
-include("ets_name.hrl").
-include("debug.hrl").
-include("common.hrl").
-include("log.hrl").
-include("record.hrl").
-include("horse_race.hrl").
-include("pt_29.hrl").

-define(GAMBLE_TIME, 300000).   %ms  %TODO  300000 ms = 5分钟
-define(ROUND_TIME, 120000).   %ms         120000 ms = 2分钟   
-define(MAX_ROUND, 5).

%%=========================================================================
%% 接口函数
%%=========================================================================

%% 解析后台传过来的数据格式函数。 %TODO
%% Return : {true, NewData} | false
check_horse_race_activity_data(JosonData) ->
    case rfc4627:decode(JosonData) of
        {ok, _Data, _} ->
            {true, []};
        _Any ->
            false
    end.
% 跑马场开启
horse_race_open(_ActId, ActData) ->
    gen_server:cast(?MODULE, {horse_race_open, ActData}),
    ok.
% 跑马场关闭
horse_race_close(_ActId, ActData) ->
    gen_server:cast(?MODULE, {horse_race_close, ActData}),
    ok.

% 获取跑马场状态信息
get_horse_race_state() ->
    gen_server:call(?MODULE, 'get_horse_race_state').

% 竞猜
horse_race_gamble(PS, HorseNo, Num) ->
    gen_server:cast(?MODULE, {horse_race_gamble, [player:id(PS), HorseNo, Num]}),
    ok.

% 使用道具
horse_race_use_prop(PS, HorseNo, PropType, Num) ->
    gen_server:cast(?MODULE, {horse_race_use_prop, [player:id(PS), HorseNo, PropType, Num]}),
    ok.

% 领取奖励
horse_race_get_reward(PS) ->
    gen_server:cast(?MODULE, {horse_race_get_reward, player:id(PS)}),
    ok.

% 重置竞猜次数
set_horse_gamble_time(PS, NewValue) ->
    gen_server:cast(?MODULE, {set_horse_gamble_time, [player:id(PS), NewValue]}),
    ok.

% 重置玩家所有竞猜次数
new_day_comes() ->
    gen_server:cast(?MODULE, {new_day_comes}),
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
    % 创建比赛信息ets
    ets:new(?ETS_HORSE_RACE, [{keypos, #ets_horse_race.id}, named_table, public, set]),
    {ok, #horse_race_state{}}.

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

handle_cast(Request, State)-> 
	try  
		do_cast(Request, State)
    catch
        _Err:_Reason ->
            ?ERROR_MSG("handle_cast *** [~p:~p] ~p ***~n", [_Err, _Reason, erlang:get_stacktrace()]),
            {noreply, State}
    end.

handle_info(Request, State)->  
    try 
		do_info(Request, State)
    catch
        _Err:_Reason ->
            ?ERROR_MSG("handle_info *** [~p:~p] ~p ***~n", [_Err, _Reason, erlang:get_stacktrace()]),
            {noreply, State}
    end.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.


do_call('get_horse_race_state', _From, State) ->
    {reply, State, State};
do_call(_Request, _From, State) ->
    throw({no_match, do_call, _Request}),
	{reply, ok, State}.

% handle_cast
% 跑马场开启
do_cast({horse_race_open, _ActData}, _State) ->
    % 初始化比赛信息ets
    ?ylh_Debug("horse_race_open ~p~n", [{date(), time()}]),
    ets:insert(?ETS_HORSE_RACE, reset_ets_horse_race(?STATUS_GAMBLE)),
    % 启动竞猜结束（比赛开始）定时器
    send_event_after(?GAMBLE_TIME, 'gamble_end'),
    {noreply, #horse_race_state{}};
% 跑马场关闭
do_cast({horse_race_close, _ActData}, State) ->
    ?ylh_Debug("horse_race_close ~p~n", [{date(), time()}]),
    case lib_horse_race:get_ets_horse_race() of
        H=#ets_horse_race{} -> 
            % 设置比赛结束状态（此时比赛继续进行，完了不开启下一场）
            ets:insert(?ETS_HORSE_RACE, H#ets_horse_race{status=?STATUS_CLOSE});
        _ -> skip
    end,
    {noreply, State};
% 加入竞猜（注意一个玩家只能投一次，故玩家Id定为key）
do_cast({horse_race_gamble, [PlayerId, HorseNo, Num]}, State) ->
    case lib_horse_race:get_ets_horse_race() of
        #ets_horse_race{status=?STATUS_GAMBLE} ->
            % GambleTimes = case dict:find(PlayerId, State#horse_race_state.player_gamble_times) of
            %     {ok, Value} ->
            %         Value;
            %     error ->
            %         0
            % end,
            % ?ylh_Debug("horse_race_gamble ~p ~n", [{HorseNo, Num, GambleTimes}]),
            % GambleTimes1 = GambleTimes + 1,
            NewState = State#horse_race_state{race_players = dict:store(PlayerId, {HorseNo,Num}, State#horse_race_state.race_players)}, 
                                              %,player_gamble_times = dict:store(PlayerId, GambleTimes1, State#horse_race_state.player_gamble_times)},
            {noreply, NewState};
        _ ->
            % GambleTimes = case dict:find(PlayerId, State#horse_race_state.player_gamble_times) of
            %     {ok, Value} ->
            %         Value;
            %     error ->
            %         0
            % end,
            % ?ylh_Debug("horse_race_gamble ~p ~n", [{HorseNo, Num, GambleTimes}]),
            % GambleTimes1 = GambleTimes + 1,
            NewState = State#horse_race_state{next_race_players = dict:store(PlayerId, {HorseNo,Num}, State#horse_race_state.next_race_players)},
                                            % ,player_gamble_times = dict:store(PlayerId, GambleTimes1, State#horse_race_state.player_gamble_times)},
            {noreply, NewState}
    end;
% 使用道具
do_cast({horse_race_use_prop, [PlayerId, HorseNo, PropType, Num]}, State) ->
    case PropType of
        ?HORSE_PROP_GOOD ->
            UsePropTime = util:unixtime(),
            State1 = State#horse_race_state{use_prop_time = dict:store(PlayerId, UsePropTime, State#horse_race_state.use_prop_time)},
            NewState = State1#horse_race_state{race_props_good = dict:update_counter(HorseNo, Num, State1#horse_race_state.race_props_good)},
            {noreply, NewState};
        ?HORSE_PROP_BAD ->
            UsePropTime = util:unixtime(),
            State1 = State#horse_race_state{use_prop_time = dict:store(PlayerId, UsePropTime, State#horse_race_state.use_prop_time)},
            NewState = State1#horse_race_state{race_props_bad = dict:update_counter(HorseNo, Num, State1#horse_race_state.race_props_bad)},
            {noreply, NewState};
        _ ->
            {noreply, State}
    end;
% 领取奖励
do_cast({horse_race_get_reward, PlayerId}, State) ->
    NewState = State#horse_race_state{reward_players = dict:erase(PlayerId, State#horse_race_state.reward_players)},
    {noreply, NewState}; 

% 重置玩家次数
do_cast({set_horse_gamble_time, [_PlayerId, _NewValue]}, State) ->
    ?ylh_Debug("set_horse_gamble_time =~p~n", [_NewValue]),
    % NewState = State#horse_race_state{player_gamble_times = dict:store(PlayerId, NewValue, State#horse_race_state.player_gamble_times)},
    {noreply, State};

%  重置玩家所有次数
do_cast({new_day_comes}, State) ->
    ?ylh_Debug("new_day_comes curtime=~p~n", [util:unixtime()]),
    % NewState = State#horse_race_state{player_gamble_times = dict:new()},
    {noreply, State};

do_cast(_Request, State) ->
    throw({no_match, do_cast, _Request}),
	{noreply, State}.

% handle_info
% 竞猜结束
do_info('gamble_end', State) ->
    % 计算获取比赛结果
    {NewState, RankType, EventList} = lib_horse_race:get_horse_race_result(State),
    ets:insert(?ETS_HORSE_RACE, reset_ets_horse_race(?STATUS_RACE, RankType, EventList)),
    ?ylh_Debug("gamble_end ~p~n", [{time(), RankType, EventList}]),
    % 启动轮次结束定时器
    send_event_after(?ROUND_TIME, 'round_end'),
    {noreply, NewState};
% 比赛轮次结束（一场比赛一共5轮）
do_info('round_end', State) ->
    case catch lib_horse_race:get_ets_horse_race() of
        % 比赛结束，且轮次已满，则不再进行下一场了
        H=#ets_horse_race{round=?MAX_ROUND,status=?STATUS_CLOSE} ->
            ?ylh_Debug("race over ~p~n", [{ time(), H}]),
            % 比赛结束处理
            NewState = lib_horse_race:horse_race_end(?STATUS_CLOSE, State, H),
            {noreply, reset_horse_race_state(NewState)};
        % 轮次已满，进行下一场
        H=#ets_horse_race{round=?MAX_ROUND, status=?STATUS_RACE} ->
            % 结算奖励
            NewState = lib_horse_race:horse_race_end(?STATUS_RACE, State, H),
            ?ylh_Debug("~n~nnext race begin ~p~n", [{ time(), H,lib_horse_race:get_first_horse_by_rank_type(H#ets_horse_race.rank_type)}]),
            ets:insert(?ETS_HORSE_RACE, reset_ets_horse_race(?STATUS_GAMBLE,H#ets_horse_race.rank_type,[])),
            % 启动竞猜结束（比赛开始）定时器
            send_event_after(?GAMBLE_TIME, 'gamble_end'),
            {noreply, reset_horse_race_state(NewState)};
        % 轮次未满，进行下一轮
        H=#ets_horse_race{round=Round} ->
            ?ylh_Debug("round_end ~p~n", [{time(), Round, H}]),
            {NewState, RankType, EventList} = lib_horse_race:get_horse_race_result(State),
            ets:insert(?ETS_HORSE_RACE, H#ets_horse_race{round=Round+1
                                                        ,rank_type = RankType
                                                        ,event_list=EventList
                                                    }),
            % 启动轮次结束定时器
            send_event_after(?ROUND_TIME, 'round_end'),
            {noreply, NewState};
        % 其他都属于不合法情况!!!
        _E ->
            ?ylh_Debug("round_end4 ~p~n", [{ time(), _E}]),
            ?ASSERT(false, {_E}),
            ?ERROR_MSG("round_end error ~p!!!", [_E]),
            {noreply, State}
    end;
do_info(_Request, State) ->
    throw({no_match, do_info, _Request}),
	{noreply, State}.


%%=========================================================================
%% 私有函数
%%=========================================================================
%%发送定时器
send_event_after(Time, Event) ->
    % 取消之前的定时器
    catch erlang:cancel_timer(erlang:get(timer_ref)),
    % 延迟发送消息
    erlang:put(timer_ref, erlang:send_after(Time, self(), Event)).

% 重置跑马场信息
reset_ets_horse_race(Status) ->
    #ets_horse_race{
        round       = 1
        ,status     = Status
        ,time       = util:unixtime()
        ,rank_type  = 0
        ,event_list = []
    }.
reset_ets_horse_race(Status, RankType, EventList) ->
    #ets_horse_race{
        round       = 1
        ,status     = Status
        ,time       = util:unixtime()
        ,rank_type  = RankType
        ,event_list = EventList
    }.

% 重置竞猜信息
reset_horse_race_state(State) ->
    State#horse_race_state{race_players = State#horse_race_state.next_race_players
                          ,next_race_players = dict:new()
                          ,race_props_good = dict:new()      
                          ,race_props_bad = dict:new()
                      }.


% 调试用！！ 
dbg() -> 
    case lib_horse_race:get_ets_horse_race() of
        _H=#ets_horse_race{} ->
            ?ylh_Debug("dbg : ~p~n", [util:r2p(_H, record_info(fields, ets_horse_race))]);
        _ ->
            ?ylh_Debug("none")
    end.

