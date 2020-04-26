%%%------------------------------------
%%% @author liufang <529132738@qq.com>
%%% @copyright UCweb 2014.01.07
%%% @doc 新年年夜宴会管理器.
%%% @end
%%%------------------------------------

-module(mod_newyear_banquet).
-behaviour(gen_server).
-export([start/0,stop/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-export([start_link/0,
		 check_newyear_banquet_activity_data/1    % 解析后台传过来的数据格式函数
        ,newyear_banquet_open/2                   % 年夜宴会开启    
        ,newyear_banquet_close/2                  % 年夜宴会关闭
		 ,del_ets_time_limit_from_ets/1,get_ets_time_limit_from_ets/1,
		 add_time_limit_from_ets/1

    ]).
-compile(export_all).


-include("prompt_msg_code.hrl").
-include("ets_name.hrl").
-include("debug.hrl").
-include("common.hrl").
-include("log.hrl").
-include("record.hrl").
-include("newyear_banquet.hrl").
-include("pt_36.hrl").
-include("buff.hrl").
-include("ernie.hrl").

-define(NEWYEAR_BANQUET_BUFF_TIME, 15000).   %ms  %TODO  15000 ms = 15秒
-define(NEWYEAR_BANQUET_REFRESH_LIMIT_TIMES, 1000 * 60 * 15).    %15分钟
%%=========================================================================
%% 接口函数
%%=========================================================================

%% 解析后台传过来的数据格式函数。 %TODO
%% Return : {true, NewData} | false
check_newyear_banquet_activity_data(JosonData) ->
    case rfc4627:decode(JosonData) of
        {ok, _Data, _} ->
            {true, []};
        _Any ->
            false
    end.
% 新年年夜宴会开启
newyear_banquet_open(_ActId, ActData) ->
    gen_server:cast(?MODULE, {newyear_banquet_open, ActData}),
    ok.
% 新年年夜关闭
newyear_banquet_close(_ActId, ActData) ->
    gen_server:cast(?MODULE, {newyear_banquet_close, ActData}),
    ok.

% 获取新年年夜状态信息
get_newyear_banquet_state() ->
    gen_server:call(?MODULE, 'get_newyear_banquet_state').

% 加菜 DishNo:1粗茶淡饭 2大鱼大肉 3鲍参翅肚， Num:次数 
newyear_banquet_add_dish(PS, DishNo, Num) ->
    gen_server:cast(?MODULE, {newyear_banquet_add_dish, [player:id(PS), DishNo, Num]}),
    ok.

% 设置加菜次数 用于测试
set_newyear_banquet_times(PS, DishNo, NewValue) ->
    gen_server:cast(?MODULE, {set_newyear_banquet_times, [player:id(PS), DishNo, NewValue]}),
    ok.

% 重置玩家所有加菜次数
set_newyear_banquet_all_times() ->
    gen_server:cast(?MODULE, {set_newyear_banquet_all_times}),
    ok.

% 设置当前宴会经值
set_newyear_banquet_exp(Value) ->
    gen_server:cast(?MODULE, {set_newyear_banquet_exp, [Value]}),
    ok.

start() ->
    gen_server:start({local, ?MODULE}, ?MODULE, [], []).
stop() ->
    gen_server:call(?MODULE, stop).

start_link() ->
	 gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

%%=========================================================================
%% 回调函数
%%=========================================================================
init([]) ->
    process_flag(trap_exit, true),
	start_timer(),
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

terminate(_Reason, State) ->
    ?ylh_Debug("mod_newyear_banquet terminate ~p~n", [_Reason]),
    ?TRY_CATCH(db:replace(newyear_banquet, [{id, 0}
                                            ,{banquet_lv,State#newyear_banquet_state.banquet_lv}
                                            ,{banquet_exp, State#newyear_banquet_state.banquet_exp}
                                            ,{data, util:term_to_bitstring(State#newyear_banquet_state.add_dish_players)}
                                            ,{create_time, util:unixtime()}])),
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.


do_call('get_newyear_banquet_state', _From, State) ->
    {reply, State, State};
do_call(_Request, _From, State) ->
    throw({no_match, do_call, _Request}),
	{reply, ok, State}.

% handle_cast
% 年夜宴会开启
do_cast({newyear_banquet_open, _ActData}, _State) ->
    %设置活动开启
    ?ylh_Debug("newyear_banquet_open ~p~n", [{date(), time()}]),
    lib_newyear_banquet:put_newyear_banquet_open(1),
    State1 = case db:select_row(newyear_banquet, "banquet_lv, banquet_exp, data, create_time", [{id, 0}]) of
        [] -> 
            #newyear_banquet_state{status=?BANQUET_STATUS_OPEN, refresh_time = util:unixtime()};
        [BanquetLv, BanquetExp, Data, CreateTime] -> 
            %判断时间是否是同一天,同一天的话从数据表中初始化数据,活动中途有停服
            case util:is_timestamp_same_day(CreateTime, util:unixtime()) of
                true ->
                    #newyear_banquet_state{
                    status = ?BANQUET_STATUS_OPEN
                    ,banquet_lv = BanquetLv
                    ,banquet_exp = BanquetExp
                    ,refresh_time = util:unixtime()
                    ,add_dish_players = util:bitstring_to_term(Data)
                    };
                false ->
                    #newyear_banquet_state{status=?BANQUET_STATUS_OPEN,refresh_time = util:unixtime()}
            end
    end,
    ply_tips:send_sys_tips(null, {newyear_banquet_open, []}),
    SceneStatus = lib_newyear_banquet:get_newyear_banquet_scene_status(),
    SceneId = SceneStatus#ets_newyear_banquet_scene_status.scene_id,
    {NpcNo, X, Y} = lib_newyear_banquet:get_cfg_banquet_npc(1),
    case mod_scene:spawn_dynamic_npc_to_scene_WNC(NpcNo, SceneId, X, Y) of
        fail ->
            ?ASSERT(false),
            ?ERROR_MSG("newyear_banquet_open error!~n", []);
        {ok, NewDynamicNpcId} ->
            SceneStatus1 = SceneStatus#ets_newyear_banquet_scene_status{
            dishes_npc = [NewDynamicNpcId] %%++ SceneStatus#ets_newyear_banquet_scene_status.dishes_npc
            },
            ets:insert(?ETS_NEWYEAR_BANQUET_SCENE_STATUS, SceneStatus1)
    end,
    %每隔15秒给宴会场景中所有玩家增加一次buff
    send_event_after_newyear_bangquet(?NEWYEAR_BANQUET_BUFF_TIME, 'newyear_banquet_buff_time'),
    %每隔10分钟刷新一次
    send_event_after_newyear_bangquet(?NEWYEAR_BANQUET_REFRESH_LIMIT_TIMES, 'newyear_banquet_refresh_limit_times'),
    {noreply, State1};

% 年夜宴会关闭
do_cast({newyear_banquet_close, _ActData}, State) ->
    ?ylh_Debug("newyear_banquet_close ~p~n", [{date(), time()}]),
    lib_newyear_banquet:put_newyear_banquet_open(0),
    State1 = State#newyear_banquet_state{status=?BANQUET_STATUS_CLOSE},
    {noreply, State1};

% 年夜加菜（注意一个玩家只能投一次，故玩家Id定为key）
do_cast({newyear_banquet_add_dish, [PlayerId, DishNo, Num]}, State) ->
    case State#newyear_banquet_state.status =:= ?BANQUET_STATUS_OPEN of
        true ->
            {Name, Dish1_num, Dish2_num, Dish3_num,_Time} = case dict:find(PlayerId, State#newyear_banquet_state.add_dish_players) of
                {ok, Value} ->
                    Value;
                error ->
                    {player:get_name(PlayerId), 0, 0, 0, 0}
            end,
            Value1 = if 
                DishNo =:= ?DISH_1 ->  {Name, Dish1_num + Num, Dish2_num, Dish3_num, util:unixtime()};
                DishNo =:= ?DISH_2 ->  {Name, Dish1_num, Dish2_num + Num, Dish3_num, util:unixtime()};
                DishNo =:= ?DISH_3 ->  {Name, Dish1_num, Dish2_num, Dish3_num + Num, util:unixtime()}
            end,
            %只有当玩家使用金子时才写入记录
            State1 = case DishNo =:= ?DISH_3 orelse DishNo =:= ?DISH_2 of
                    true ->
                        State#newyear_banquet_state{add_dish_logs = [{PlayerId, player:get_name(PlayerId), DishNo} | State#newyear_banquet_state.add_dish_logs]};
                    false ->
                        State
            end,
            %增加宴会的经验
            BanquetExp = State1#newyear_banquet_state.banquet_exp,
            BanquetExp1 = if 
                DishNo =:= ?DISH_1 -> BanquetExp + lib_newyear_banquet:get_cfg_exp_add(?DISH_1) * Num;
                DishNo =:= ?DISH_2 -> BanquetExp + lib_newyear_banquet:get_cfg_exp_add(?DISH_2) * Num;
                DishNo =:= ?DISH_3 -> BanquetExp + lib_newyear_banquet:get_cfg_exp_add(?DISH_3) * Num
            end,

            %计算当前档次
            BanquetLv = State1#newyear_banquet_state.banquet_lv,

            %判断系统是否需要增加经验
            BanquetSysExp = case lib_newyear_banquet:get_cfg_banquet_exp_limit(BanquetLv) of
                {ExpLimit, DishType, DishNum} ->
                    case BanquetExp < ExpLimit andalso ExpLimit =< BanquetExp1 of
                        true ->
                            ExpSysAdd = lib_newyear_banquet:get_cfg_exp_add(DishType) * DishNum,
                            DishName = lib_newyear_banquet:get_cfg_dish_name(DishType),
                            ply_tips:send_sys_tips(null, {newyear_banquet_sys, [DishNum, DishName]}),
                            ExpSysAdd;
                        false ->
                            0
                    end;
                0 ->
                    0
            end,

            BanquetExp2 = BanquetExp1 + BanquetSysExp, 

            %计算下一个等级
            BanquetLv1 = lib_newyear_banquet:get_banquet_lv_by_exp(BanquetExp2),
            %判断档次是否有提升
            {BanquetExp3, BanquetLv2} = case BanquetLv < BanquetLv1 of
                true ->
                    SceneStatus = lib_newyear_banquet:get_newyear_banquet_scene_status(),
                    SceneId = SceneStatus#ets_newyear_banquet_scene_status.scene_id,
                    {NpcNo, X, Y} = lib_newyear_banquet:get_cfg_banquet_npc(BanquetLv1),
                    [mod_scene:clear_dynamic_npc_from_scene_WNC(NpcId) || NpcId <- SceneStatus#ets_newyear_banquet_scene_status.dishes_npc],
                    case mod_scene:spawn_dynamic_npc_to_scene_WNC(NpcNo, SceneId, X, Y) of
                        fail ->
                            ?ASSERT(false),
                            ?ERROR_MSG("newyear_banquet_add_dish error!~n", []);
                        {ok, NewDynamicNpcId} ->
                            SceneStatus1 = SceneStatus#ets_newyear_banquet_scene_status{
                            dishes_npc = [NewDynamicNpcId] %%++ SceneStatus#ets_newyear_banquet_scene_status.dishes_npc
                            },
                        ets:insert(?ETS_NEWYEAR_BANQUET_SCENE_STATUS, SceneStatus1)
                    end,
                    %全服广播
                    TipsNo = 135+BanquetLv1,
                    ply_tips:send_sys_tips(null, TipsNo, []),
                    {BanquetExp2, BanquetLv1};
                false ->
                    {BanquetExp2, BanquetLv}
            end,
            %增加当前时间段总的加菜次数
            DishValue = case dict:find(DishNo, State1#newyear_banquet_state.add_limit_times) of
                            {ok, Value2} ->
                                Value2;
                            error ->
                                0
                        end,
            DishValue1 = DishValue + 1,
            State2 = State1#newyear_banquet_state{banquet_exp = BanquetExp3, banquet_lv = BanquetLv2
                                                    ,add_limit_times = dict:store(DishNo, DishValue1, State1#newyear_banquet_state.add_limit_times)},
            NewState = State2#newyear_banquet_state{add_dish_players = dict:store(PlayerId, Value1, State2#newyear_banquet_state.add_dish_players)}, 
            {noreply, NewState};
        false ->
            {noreply, State}
    end;


% 重置玩家加菜次数
do_cast({set_newyear_banquet_times, [PlayerId, DishNo, NewValue]}, State) ->
    ?ylh_Debug("set_newyear_banquet_time =~p~n", [NewValue]),
    case State#newyear_banquet_state.status =:= ?BANQUET_STATUS_OPEN of
        true ->
            {Name, Dish1_num, Dish2_num, Dish3_num,_Time} = case dict:find(PlayerId, State#newyear_banquet_state.add_dish_players) of
                {ok, Value} ->
                    Value;
                error ->
                    {player:get_name(PlayerId), 0, 0, 0, 0}
            end,
            Value1 = if 
                DishNo == ?DISH_1 ->  {Name, NewValue, Dish2_num, Dish3_num, util:unixtime()};
                DishNo == ?DISH_2 ->  {Name, Dish1_num, NewValue, Dish3_num, util:unixtime()};
                DishNo == ?DISH_3 ->  {Name, Dish1_num, Dish2_num, NewValue, util:unixtime()}
            end,
            NewState = State#newyear_banquet_state{add_dish_players = dict:store(PlayerId, Value1, State#newyear_banquet_state.add_dish_players)}, 
            {noreply, NewState};
        false ->
            {noreply, State}
    end;

%  重置玩家所有次数
do_cast({set_newyear_banquet_all_times}, State) ->
    ?ylh_Debug("set_newyear_banquet_all_times curtime=~p~n", [util:unixtime()]),
    NewState = State#newyear_banquet_state{banquet_exp = 0, banquet_lv = 1, add_limit_times=dict:new(), add_dish_players = dict:new(),add_dish_logs = []},
    {noreply, NewState};

% 设置当前宴会经验
do_cast({set_newyear_banquet_exp, [Value]}, State) ->
    NewState = State#newyear_banquet_state{banquet_exp = Value},
    {noreply, NewState};

do_cast(_Request, State) ->
    throw({no_match, do_cast, _Request}),
	{noreply, State}.

% handle_info
% 每15秒给玩家一次经验和伙伴奖励
do_info('newyear_banquet_buff_time', State) ->
    %当前宴会场景的所有玩家增加BUFF
    case State#newyear_banquet_state.status =:= ?BANQUET_STATUS_OPEN of
        false -> skip;
        true ->
            spawn(fun() -> player_newyear_banquet_add_buff(State) end ),
            send_event_after_newyear_bangquet(?NEWYEAR_BANQUET_BUFF_TIME, 'newyear_banquet_buff_time')
    end,
    {noreply, State};

do_info({timeout, _TimerRef, timer}, State) ->
	start_timer(),
	TimeLimitData = case get_ets_time_limit_from_ets(time_limit_rank) of
						null ->
							lib_newyear_banquet:set_time_limit_rank(),
							get_ets_time_limit_from_ets(time_limit_rank);
						R -> R
					end,
						
							
	IsDirty = TimeLimitData#ets_time_limit_rank.dirty,
	
	case IsDirty =:= 1 of
		true ->	
			lib_newyear_banquet:set_time_limit_rank();
		false -> skip
	end,
    
	{noreply, State};

% 每隔10分钟重置玩家可以加菜的次数
do_info('newyear_banquet_refresh_limit_times', State) ->
    State1 = case State#newyear_banquet_state.status =:= ?BANQUET_STATUS_OPEN of
        false -> State;
        true ->
            {ok, BinData} = pt_36:write(?PT_NEWYEAR_BANQUET_REFRESH_ADD_DISH, []),
            lib_send:send_to_all(BinData),
            State#newyear_banquet_state{add_limit_times = dict:new(), refresh_time = util:unixtime()}
    end,

    send_event_after_newyear_bangquet(?NEWYEAR_BANQUET_REFRESH_LIMIT_TIMES, 'newyear_banquet_refresh_limit_times'),
    {noreply, State1};

do_info(_Request, State) ->
    throw({no_match, do_info, _Request}),
	{noreply, State}.


%%=========================================================================
%% 私有函数
%%=========================================================================
%%发送定时器
send_event_after_newyear_bangquet(Time, Event) ->
    % 取消之前的定时器
    catch erlang:cancel_timer(erlang:get({timer_newyear_ref,Event})),
    % 延迟发送消息
    erlang:put({timer_newyear_ref,Event}, erlang:send_after(Time, self(), Event)).

%%给每一个玩家增加Buff
player_newyear_banquet_add_buff(State) ->
    %得到场景id
    SceneId = case lib_newyear_banquet:get_newyear_banquet_scene_status() of
                null -> 0;
                SceneStatus ->
                    SceneStatus#ets_newyear_banquet_scene_status.scene_id
              end,
    %得到当前场景的所有玩家
    PlayerIds = lib_scene:get_scene_player_ids(SceneId),
  
    F1 = fun(X) ->
        case player:get_PS(X) of
            null -> skip;
            PS ->
                {MoneyBase, ExpBase} = 
                    case data_newyear_banquet:config(State#newyear_banquet_state.banquet_lv) of
                        null -> {0, 0};
                        Cfg ->
                            TMoneyBase = Cfg#newyear_banquet_lv.banquet_player_gamemoney,
                            TExpBase = Cfg#newyear_banquet_lv.banquet_player_exp,
                            {TMoneyBase, TExpBase}
                    end,
                PlayerLv = player:get_lv(PS),
                
                BuffPara = case mod_buff:has_buff(player, player:id(PS), ?BFN_ADD_EXP_BIND_GAMEMONEY) of
                    false -> 1;
                    true ->
                        BuffPara1 = mod_buff:get_buff_para_by_name(player, player:id(PS), ?BFN_ADD_EXP_BIND_GAMEMONEY),
                        ?ASSERT(BuffPara1 =/= null),
                        BuffPara1
                end,
                MoneyAdd = util:ceil(600 * MoneyBase/100 * BuffPara),
                ExpAdd = util:ceil(ExpBase/100 * 15 * PlayerLv * BuffPara),
                % ?ylh_Debug("MoneyAdd=~p, ExpAdd=~p~n", [MoneyAdd, ExpAdd]),
                player:add_all_exp(PS, ExpAdd, [?LOG_NEWYEAR_BANGQUET, "newyear_banquet"]),
                player:add_bind_gamemoney(PS, MoneyAdd, [?LOG_NEWYEAR_BANGQUET, "newyear_banquet"])
        end
    end,
    [F1(X) || X <- PlayerIds],
    deal_players_reward(PlayerIds, State#newyear_banquet_state.banquet_lv).

% 随机出一名玩家发放奖励
calc_lucky_reward_player(PlayerIds) ->
    Size = length(PlayerIds),
    case Size=:=0 of
        true -> 0;
        false ->
            Nth = util:rand(1, Size),
            PlayerId = lists:nth(Nth, PlayerIds),
            PlayerId
    end.

% 随机出一个物品奖励
cacl_player_items(Lv) ->
    List = lib_newyear_banquet:get_cfg_banquet_items(Lv),
    {Items, _, BindState} = util:rand_by_weight(List, 2),
    {Items,BindState}.

% 随机出发放的人数
cacl_player_num(Lv) ->
    List = lib_newyear_banquet:get_cfg_banquet_even(Lv), 
    {Num, _} = util:rand_by_weight(List, 2), 
    Num.

del_ets_time_limit_from_ets(time_limit_rank) ->
    ets:delete(?ETS_TIME_LIMIT_RANK, time_limit_rank).

get_ets_time_limit_from_ets(time_limit_rank) ->
    case ets:lookup(?ETS_TIME_LIMIT_RANK, time_limit_rank) of
        [] -> 
            null;
        [R] ->
            R
    end.

add_time_limit_from_ets(TimeLimitRankEts) when is_record(TimeLimitRankEts, ets_time_limit_rank) ->
    ets:insert(?ETS_TIME_LIMIT_RANK, TimeLimitRankEts).

start_timer() ->
	erlang:start_timer(10* 1000, self(), timer).



% 处理发放玩家奖励
deal_players_reward(PlayerIds, Lv) ->
    %计算当前场景的人数
    Players = length(PlayerIds),
    %计算当前场景奖励物品需要发放的人数
    RewardPlayers = cacl_player_num(Lv), 
    %统计当前宴会参与人数及当前档次和获奖人数
    lib_log:statis_role_action(sys, [], "newyear_banquet", "newyear_banquet_join_info", [Players, Lv, RewardPlayers]),
    if 
        %如果当前人数为0，不发放奖励
        RewardPlayers == 0 -> skip;
        %发放的人数多于场景人数，则每一个发放
        RewardPlayers >= Players -> 
            F = fun(X) ->
                case player:get_PS(X) of
                    null -> skip;
                    PS ->
                        {GoodsNo,BindState} = cacl_player_items(Lv),
                        mod_inv:batch_smart_add_new_goods(player:id(PS), [{GoodsNo, 1}], [{bind_state, BindState}], [?LOG_NEWYEAR_BANGQUET, GoodsNo]),
                        ply_tips:send_sys_tips(PS, {newyear_banquet_reward, [player:get_name(PS),player:get_id(PS), GoodsNo, lib_goods:get_quality(lib_goods:get_tpl_data(GoodsNo)), 1]})
                end
            end,
            [F(X) || X <- PlayerIds];
        RewardPlayers < Players ->
            deal_players_reward_ex(RewardPlayers, PlayerIds, Lv);
        true ->
            skip
    end.

deal_players_reward_ex(Num, _PlayerIds, _Lv) when Num == 0 -> skip;
deal_players_reward_ex(Num, PlayerIds, Lv) ->
    {GoodsNo, BindState} = cacl_player_items(Lv), 
    PlayerId = calc_lucky_reward_player(PlayerIds), 
    mod_inv:batch_smart_add_new_goods(PlayerId, [{GoodsNo, 1}], [{bind_state, BindState}], [?LOG_NEWYEAR_BANGQUET, GoodsNo]),
    ply_tips:send_sys_tips(player:get_PS(PlayerId), {newyear_banquet_reward, [player:get_name(PlayerId), PlayerId, GoodsNo, lib_goods:get_quality(lib_goods:get_tpl_data(GoodsNo)), 1]}),
    deal_players_reward_ex(Num-1, PlayerIds, Lv).
 
deal_player_lottery_reward(PS, Step, RewardList) ->
    PlayerId = player:get_id(PS),
    StepList = lib_newyear_banquet:get_player_reward(PS),
    Token = lib_newyear_banquet:get_player_token(PS),

    case Token >= Step of
        true ->
            case lists:member(Step, StepList) of
                true ->
                    skip;
                false ->

                    F = fun({ToStep, GoodsNo, _, GoodsNum, _}, Acc) ->
                            case Step =:= ToStep of
                                true ->
                                    [{GoodsNo, GoodsNum}] ++ Acc;
                                false ->
                                    Acc
                            end
                        end,
                    RewardListBrief = lists:foldl(F, [], RewardList),

                    case mod_inv:check_batch_add_goods(PlayerId, RewardListBrief) of
                        ok ->

                            mod_inv:batch_smart_add_new_goods(PlayerId,
                                RewardListBrief, [{bind_state, 1}], [?LOG_LOTTERY, "lottery box"]),
                            NewReward = [Step | StepList],
                            ets:update_element(?ETS_PLAYER_LOTTERY_INFO, PlayerId, [{#player_lottery_info.reward, NewReward}]),
                            db:update(lottery, [{reward, util:term_to_bitstring(NewReward)}], [{player_id, PlayerId}]),
                            {ok, BinData} = pt_36:write(?PT_GET_LOTTERY_REWARD, [?RES_OK]),
                            lib_send:send_to_sock(PS, BinData);
                        _ ->
                            lib_send:send_prompt_msg(PlayerId, ?PM_US_BAG_FULL)
                    end
            end;
        false ->
            skip
    end.



                          