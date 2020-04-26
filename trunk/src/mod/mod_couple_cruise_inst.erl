%%%------------------------------------
%%% @Module  : mod_couple_cruise_inst (inst: instance)
%%% @Author  : zhangwq
%%% @Email   : 
%%% @Created : 2014.12.19
%%% @Description: 花车巡游活动的实例
%%%------------------------------------
-module(mod_couple_cruise_inst).
-behaviour(gen_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([
        start/2,
        on_player_login/1,
        tst_stop/0,
		get_type/0
        ]).

-include("debug.hrl").
-include("relation.hrl").
-include("char.hrl").
-include("abbreviate.hrl").
-include("log.hrl").
-include("pt_33.hrl").
-include("common.hrl").
-include("record.hrl").
-include("goods.hrl").
-include("prompt_msg_code.hrl").

-record(state, {
    stop = false,
	type = 1
    }).

-record(aoi_info, {
        title_no = 0,
        player_name_1 = <<>>,
        player_name_2 = <<>>
    }).

-define(NPC_MOVE_INTERVAL_MS, 3000).    % npc移动的时间间隔（单位：毫秒）
-define(REWARD_PLAYER_INTERVAL_MS, 15000).    % 奖励玩家的时间间隔（单位：毫秒）
-define(MAX_INST_LASTING_TIME_MS, (60 * 60 * 1000)).  % 活动实例的最长持续时间（单位：毫秒），暂时设为60分钟
-define(TIME_FOR_CLIENT_MOVE_NPC_EACH_STEP_MS, 2000). % 客户端移动npc每一步所需的时间（单位：毫秒）

%% 进程字典的key名
-define(PDKN_NPC_ID, pdkn_npc_id).
-define(PDKN_NPC_STEP_COUNT, pdkn_npc_step_count).
-define(PDKN_JOINING_PLAYER_LIST, pdkn_joining_player_list). % 当前正参与活动的玩家列表（目前是玩家id列表）
-define(PDKN_OWNER_PLAYER_LIST, pdkn_owner_player_list).     % 当前正参与活动的主人玩家列表（目前是玩家id列表）
-define(PDKN_NPC_NEXT_MOVE_ON_TIME, pdkn_npc_next_move_on_time). % npc下次可前移的时间点
-define(PDKN_NPC_TYPE, pdkn_npc_type).	% npc类型即:婚车类别: 普通,豪华,奢华
-define(PDKN_LEFT_MONEY, pdkn_left_money).	%% 剩余产出金钱 格式:{金钱类型,数量} 金钱类型 1).        银子 2).        金子 3).     绑定的银子 4).     绑定的金子
-define(PDKN_AOI_INFO, pdkn_aoi_info).      %% 婚车aoi信息 保存aoi_info记录体

%% 开启巡游活动的一个实例
start(Type, ReqJoinPlayerList) ->
    gen_server:start({local, ?COUPLE_CRUISE_PROCESS}, ?MODULE, [Type, ReqJoinPlayerList], []).


tst_stop() ->
    gen_server:cast(?COUPLE_CRUISE_PROCESS, {'tst_stop_cruise'}).    


on_player_login(PS) ->
    case erlang:whereis(?COUPLE_CRUISE_PROCESS) of
        undefined -> try_mark_idle(PS);
        _Pid -> gen_server:cast(?COUPLE_CRUISE_PROCESS, {'on_player_login', PS})
    end.

get_type() ->
	gen_server:call(?COUPLE_CRUISE_PROCESS, get_type).

%% ===================================================================================================
    
init([Type, ReqJoinPlayerList]) ->
    process_flag(trap_exit, true),
    
    do_init_jobs(Type, ReqJoinPlayerList),

    ?DEBUG_MSG("[mod_couple_cruise_inst] init ok~n", []),
    
    State = #state{stop = false, type = Type},
    {ok, State}.




handle_cast(Request, State) ->
    try
        handle_cast_2(Request, State)
    catch
        Err:Reason ->
            ?ERROR_MSG("ERR:~p,Reason:~p, ~w",[Err, Reason, erlang:get_stacktrace()]),
            {noreply, State}
    end.


handle_cast_2({'fireworks', PS}, State) ->
    case lists:member(player:id(PS), get_owner_player_list()) of
        false -> skip;
        true ->
            Type = 
                case data_couple:get(cruise, get_wedding_car_type()) of
                    null -> 0;
                    Data -> Data#couple_cfg.fire_no
                end,
            SceneId = player:get_scene_id(PS),
            {X, Y} = player:get_xy(PS),
            lib_couple:show_fireworks({SceneId, X, Y}, Type)
    end,

    {noreply, State};    


handle_cast_2({'req_join_couple_cruise', PS}, State) ->
    case State#state.stop =:= true of
        true -> lib_send:send_prompt_msg(PS, ?PM_COUPLE_CRUISE_FINISHED);
        false ->
            case lists:member(player:id(PS), get_joining_player_list()) of
                true -> skip;
                false ->
                    set_joining_player_list([player:id(PS) | get_joining_player_list()])
            end,

            Npc = get_npc_obj(),
            SceneId = mod_npc:get_scene_id(Npc),
            {X, Y} = mod_npc:get_xy(Npc),

            do_single_teleport(PS, SceneId, X, Y),
            mark_couple_cruising(PS),

            {ok, Bin} = pt_33:write(?PT_COUPLE_REQ_JOIN_CRUISE, [?RES_OK]),
            lib_send:send_to_sock(PS, Bin)
    end,

    {noreply, State};

handle_cast_2({'req_stop_couple_cruise', PS}, State) ->
    case lists:member(player:id(PS), get_joining_player_list()) of
        false -> skip;
        true ->
            set_joining_player_list(get_joining_player_list() -- [player:id(PS)])
    end,

    mark_stop_couple_cruising(PS),

    {ok, Bin} = pt_33:write(?PT_COUPLE_REQ_STOP_CRUISE, [?RES_OK, 1]),
    lib_send:send_to_sock(PS, Bin),
        
    {noreply, State};


handle_cast_2({'tst_stop_cruise'}, State) ->
    inst_finish(State),
    {noreply, State};         


handle_cast_2({'req_cruise_car_pos', PS}, State) ->
    case get_npc_obj() of
        null -> skip;
        Npc ->
            NpcId = mod_npc:get_id(Npc),
            SceneId = mod_npc:get_scene_id(Npc),
            {X, Y} = mod_npc:get_xy(Npc),

            {ok, Bin} = pt_33:write(?PT_COUPLE_CAR_POS, [NpcId, SceneId, X, Y]),
            lib_send:send_to_sock(PS, Bin)
    end,
    {noreply, State};             


handle_cast_2({'on_player_login', PS}, State) ->
    case lists:member(player:id(PS), get_owner_player_list()) of
        false -> 
            case lists:member(player:id(PS), get_joining_player_list()) of
                false -> skip;
                true ->
                    set_joining_player_list(get_joining_player_list() -- [player:id(PS)])
            end;
        true -> 
            lib_couple:notify_cruising_state(PS),

            Npc = get_npc_obj(),
            SceneId = mod_npc:get_scene_id(Npc),
            {X, Y} = mod_npc:get_xy(Npc),

            do_single_teleport(PS, SceneId, X, Y),
            mark_player_cruising_hide(PS)
    end,

    {noreply, State};                 


handle_cast_2(_R, State) ->
    ?ASSERT(false, _R),
    {noreply, State}.


handle_call(Request, From, State) ->
    try
        handle_call_2(Request, From, State)
    catch
        Err:Reason ->
            ?ERROR_MSG("ERR:~p,Reason:~p, ~w",[Err, Reason, erlang:get_stacktrace()]),
             {reply, error, State}
    end.

handle_call_2(get_type, _From, State) ->
	{reply, State#state.type, State};

handle_call_2(_R, _From, State) ->
    ?ASSERT(false, _R),
    {reply, ok, State}.


handle_info(Request, State) ->
    try
        handle_info_2(Request, State)
    catch
        Err:Reason->
            ?ERROR_MSG("ERR:~p,Reason:~p, ~w~n",[Err,Reason,erlang:get_stacktrace()]),
             {noreply, State}
    end.

%% npc前移
handle_info_2('npc_move_on', State) ->
    % ?DEBUG_MSG("mod_couple_cruise_inst: try move...~n", []),
    NewState = 
    	case can_move_on() of
    		true ->
                % ?DEBUG_MSG("mod_couple_cruise_inst: can move~n", []),
    			npc_move_on(State);
    		false ->
    			?DEBUG_MSG("mod_couple_cruise_inst: can not move on, NpcId:~p, TimeNow:~p, NextMoveOnTime:~p", [get_npc_id(), util:unixtime(), get_npc_next_move_on_time()]),
    			State
    	end,
    schedule_npc_move_on(), % 排定下一个前移
    {noreply, NewState};


handle_info_2('regular_reward_player', State) ->
    regular_reward_player(),
    schedule_regular_reward_player(), % 排定下一个定时奖励
    {noreply, State};


%% 终止进程自身
handle_info_2({'stop_myself', Reason}, State) ->
    {stop, Reason, State};


handle_info_2(_R, State) ->
    {noreply, State}.

terminate(Reason, _State) ->
	case Reason of
		inst_lasting_for_too_long_time ->
			?ERROR_MSG("[mod_couple_cruise_inst] error!!! terminate for reason: inst_lasting_for_too_long_time! NpcId:~p", [get_npc_id()]);
		_ ->
			?DEBUG_MSG("[mod_couple_cruise_inst] terminate for reason: ~w", [Reason])
	end,
    ok.

code_change(_OldVsn, State, _Extra)->
	{ok, State}.


do_init_jobs(Type, ReqJoinPlayerList) ->
    [PlayerId_1 | T] = ReqJoinPlayerList,
    [PlayerId_2 | _T] = T,
    F = fun(Id, Acc) ->
        case ply_title:find_title(PlayerId_1, Id) of
            false -> Acc;
            _ -> Id
        end
    end,

    TitleNoL = data_couple:get_title_no_list_by_key(marry),
    PlayerName1 = player:get_name(PlayerId_1),
    PlayerName2 = player:get_name(PlayerId_2),

    AoiInfo = 
        #aoi_info{
            title_no = lists:foldl(F, lists:last(TitleNoL), TitleNoL),
            player_name_1 = PlayerName1,
            player_name_2 = PlayerName2
        },

    set_aoi_info(AoiInfo),

	set_wedding_car_type(Type),

    DataCfg = data_couple:get(cruise, Type),

	{MoneyList, _LvLimit} = 
		case DataCfg =:= null of
			true -> {[], 1};
			false -> {DataCfg#couple_cfg.output_money, DataCfg#couple_cfg.lv_limit}
		end,

	set_left_money(MoneyList),

	init_joining_player_list(ReqJoinPlayerList),
    set_owner_player_list(ReqJoinPlayerList),

	{X, Y} = data_couple_cruise_path:get(0),
	try_trigger_event({X, Y}),

    {ok, BinData} = pt_33:write(?PT_COUPLE_NOTIFY_CRUISE_BEGIN, [Type, get_npc_id()]),
    [lib_send:send_to_uid(Id, BinData) || Id <- ReqJoinPlayerList],

    mark_player_cruising_hide(ReqJoinPlayerList),

	init_npc_step_count(),

	schedule_stop_myself(),

	schedule_regular_reward_player(),

	let_npc_start_moving(),

    spawn(fun() -> broadcast_to_all(PlayerName1, PlayerName2, ReqJoinPlayerList, ?RELA_JOIN_COUPLE_LV) end).

			




%% 获取活动实例对应的npc id
get_npc_id() ->
	erlang:get(?PDKN_NPC_ID).

%% 设置活动实例对应的npc id
set_npc_id(NpcId) ->
	erlang:put(?PDKN_NPC_ID, NpcId).

get_wedding_car_type() ->
	erlang:get(?PDKN_NPC_TYPE).

set_wedding_car_type(Type) ->
	erlang:put(?PDKN_NPC_TYPE, Type).


get_aoi_info() ->
    erlang:get(?PDKN_AOI_INFO).

set_aoi_info(R) ->
    erlang:put(?PDKN_AOI_INFO, R).    

get_left_money() ->
	erlang:get(?PDKN_LEFT_MONEY).

set_left_money(MoneyList) ->
	erlang:put(?PDKN_LEFT_MONEY, MoneyList).

%% 获取活动实例对应的npc对象
get_npc_obj() ->
	NpcId = get_npc_id(),
	mod_npc:get_obj(NpcId).
	

init_npc_step_count() ->
	set_npc_step_count(0).

incr_npc_step_count() ->
	OldStepCount = get_npc_step_count(),
	set_npc_step_count(OldStepCount + 1).

get_npc_step_count() ->
	erlang:get(?PDKN_NPC_STEP_COUNT).

set_npc_step_count(Count) ->
	erlang:put(?PDKN_NPC_STEP_COUNT, Count).

    

init_joining_player_list(PlayerList) ->
	set_joining_player_list(PlayerList).


get_joining_player_list() ->
	RetList = erlang:get(?PDKN_JOINING_PLAYER_LIST),
	?ASSERT(is_list(RetList), RetList),
	RetList.

set_joining_player_list(PlayerList) ->
	erlang:put(?PDKN_JOINING_PLAYER_LIST, PlayerList).


get_owner_player_list() ->
    RetList = erlang:get(?PDKN_OWNER_PLAYER_LIST),
    ?ASSERT(is_list(RetList), RetList),
    RetList.

set_owner_player_list(PlayerList) ->
    erlang:put(?PDKN_OWNER_PLAYER_LIST, PlayerList).


let_npc_start_moving() ->
	self() ! 'npc_move_on'.


schedule_npc_move_on() ->
	erlang:send_after(?NPC_MOVE_INTERVAL_MS, self(), 'npc_move_on').


%% 一定时间后终止进程自身，以避免出bug后进程一直残余
schedule_stop_myself() ->	
	erlang:send_after(?MAX_INST_LASTING_TIME_MS, self(), {'stop_myself', inst_lasting_for_too_long_time}).


schedule_regular_reward_player() ->
	erlang:send_after(?REWARD_PLAYER_INTERVAL_MS, self(), 'regular_reward_player').


%% npc是否可以前移？
can_move_on() ->
	TimeNow = util:unixtime(),
	TimeNow >= get_npc_next_move_on_time().


get_npc_next_move_on_time() ->
	case erlang:get(?PDKN_NPC_NEXT_MOVE_ON_TIME) of
		undefined ->
			0;
		Timestamp ->
			Timestamp
	end.

set_npc_next_move_on_time(Timestamp) ->
	erlang:put(?PDKN_NPC_NEXT_MOVE_ON_TIME, Timestamp).


npc_move_on(State) ->
	NpcObj = get_npc_obj(),
	OldStepCount = get_npc_step_count(),

	NewStepCount = OldStepCount + 1,

	case data_couple_cruise_path:get(NewStepCount) of
		the_end ->
			% ?DEBUG_MSG("npc_move_on(), NpcId:~p, OldStepCount:~p, NewStepCount:~p, the end!!", [get_npc_id(), OldStepCount, NewStepCount]),
			inst_finish(State);
		{NewX, NewY} ->
			% ?DEBUG_MSG("npc_move_on(), NpcId:~p, OldStepCount:~p, NewStepCount:~p, NewX:~p, NewY:~p", [get_npc_id(), OldStepCount, NewStepCount, NewX, NewY]),
			incr_npc_step_count(),

			mod_npc:set_xy(NpcObj, {NewX, NewY}),

			SceneId = mod_npc:get_scene_id(NpcObj),
			{OldX, OldY} = mod_npc:get_xy(NpcObj),
			OldPos = lib_comm:to_coord({OldX, OldY}),
			NewPos = lib_comm:to_coord({NewX, NewY}),
			mod_go:npc_move(NpcObj, SceneId, OldPos, NewPos),

			try_trigger_event({NewX, NewY}),
            State
	end.


try_trigger_event({X, Y}) ->
	EventsL = 
		case data_couple_cruise_event:get({X, Y}) of
			null ->
				[];
			Data ->
				Data#couple_cru_event.events
		end,
	try_trigger_event(EventsL, {X, Y}).


try_trigger_event([], _) ->
	skip;
try_trigger_event([H | T], {X, Y}) ->
	case H of
		{spawn, SceneNo, NpcNoList} ->
			NpcNo = 
				case length(NpcNoList) < 3 of
					true -> lists:nth(1, NpcNoList);
					false -> lists:nth(get_wedding_car_type(), NpcNoList)
				end,
            AoiInfo = get_aoi_info(),
			{ok, NpcId} = mod_scene:spawn_dynamic_npc_to_scene_WNC(NpcNo, SceneNo, X, Y, 
                [{bhv_state, ?BHV_IDLE}, {title_no, AoiInfo#aoi_info.title_no}, {string_1, AoiInfo#aoi_info.player_name_1}, {string_2, AoiInfo#aoi_info.player_name_2}]),
			set_npc_id(NpcId);
		{stay, Timestamp} ->
			TimeNow = util:unixtime(),
			NpcNextMoveOnTime = get_npc_next_move_on_time(),
			case NpcNextMoveOnTime > TimeNow of
				true ->  
					set_npc_next_move_on_time(NpcNextMoveOnTime + Timestamp);  % 累加停留时间
				false ->
					set_npc_next_move_on_time(TimeNow + Timestamp)
			end;
		{fireworks} ->
            Type = 
                case data_couple:get(cruise, get_wedding_car_type()) of
                    null -> 0;
                    Data -> Data#couple_cfg.fireworks
                end,
            SceneId = mod_npc:get_scene_id(get_npc_obj()),
            lib_couple:show_fireworks({SceneId, X, Y}, Type);
		{broadcast, BNo} ->
            List = get_owner_player_list(),
            ?DEBUG_MSG("mod_couple_cruise_inst:owner:~w~n", [get_owner_player_list()]),
			PlayerId1 = lists:nth(1, List),
			PlayerId2 = lists:nth(2, List),
			mod_broadcast:send_sys_broadcast(BNo, [player:get_name(PlayerId1), PlayerId1, player:get_name(PlayerId2), PlayerId2]);
		true -> skip
	end,
	try_trigger_event(T, {X, Y}).


%% 定时奖励玩家
regular_reward_player() ->
	L = get_joining_player_list(),
	F = fun(PlayerId) ->
			regular_reward_one_player(PlayerId)
		end,
	lists:foreach(F, L).


regular_reward_one_player(PlayerId) ->
	case player:get_PS(PlayerId) of
		null ->
			skip;
		PS ->
			Lv = player:get_lv(PS),
			% 0.07*(等级^2) - 1.3*等级 + 95
			AddVal = util:ceil(0.14 * (Lv * Lv) - 2.6 * Lv + 190),
			AddVal2 = util:ceil(AddVal),
			% 给玩家和宠物加经验 现在策划调整：副宠获得经验与主宠是1:1 即都与人物一样
			player:add_all_exp(PS, AddVal2, [?LOG_COUPLE, "cruise"]),

			%% 给钱
			Money = (data_couple:get(cruise, get_wedding_car_type()))#couple_cfg.per_money,
			F = fun({MoneyType, MoneyCount}) ->
				case lists:keyfind(MoneyType, 1, get_left_money()) of
					false -> skip;
					{_, LeftCount} ->
						case LeftCount < MoneyCount of
							true -> skip;
							false -> 
								player:add_money(PS, MoneyType, MoneyCount, [?LOG_COUPLE, "cruise"]),
								NewMoneyList = lists:keyreplace(MoneyType, 1, get_left_money(), {MoneyType, LeftCount-MoneyCount}),
								set_left_money(NewMoneyList)
						end
				end
			end,
			[F(X) || X <- Money]
	end.


inst_finish(State) ->
	timer:sleep(?TIME_FOR_CLIENT_MOVE_NPC_EACH_STEP_MS),  % 等待客户端把npc移动到终点
	
	JoiningPlayerList = get_joining_player_list(),
	F = fun(PlayerId) ->
            case player:get_PS(PlayerId) of
                null -> skip;
                PS ->
                    notify_cli_inst_finish(PS)
            end
        end,

    lists:foreach(F, JoiningPlayerList),

	% 删除npc对象
    mod_scene:clear_dynamic_npc_from_scene_WNC(get_npc_id()),

	mod_relation:on_cruise_finish(),

    %% 记录行为日志
    List = get_owner_player_list(),
    lib_log:statis_role_action(sys, [], ?LOG_COUPLE, "cruise", [lists:nth(1, List), lists:nth(2, List), get_wedding_car_type(),
            util:term_to_string(mk_output_money()), length(get_joining_player_list())]),

	stop_myself({shutdown, inst_finish}),
    State#state{stop = true}.


stop_myself(Reason) ->
	self() ! {'stop_myself', Reason}.


notify_cli_inst_finish(PS) ->
    mark_stop_couple_cruising(PS),

	{ok, Bin} = pt_33:write(?PT_COUPLE_REQ_STOP_CRUISE, [?RES_OK, 2]),
	lib_send:send_to_sock(PS, Bin).



broadcast_to_all(PlayerName1, PlayerName2, ExceptPlayerList, LvLimit) ->
    List = mod_svr_mgr:get_all_online_player_ids(),
    RetList = List -- ExceptPlayerList,
    F = fun(Id) ->
        case player:get_PS(Id) of
            null ->
                skip;
            PS ->
                case player:get_lv(PS) < LvLimit of
                    true ->
                        skip;
                    false ->
                        case player:is_in_dungeon(PS) of
                            {true, _DungeonPid} ->
                                skip;
                            false ->
                                {ok, Bin} = pt_33:write(?PT_COUPLE_BROADCAST_CRUISE_BEGIN, [PlayerName1, PlayerName2]),
                                lib_send:send_to_sock(PS, Bin)
                        end
                end
        end
    end,
    [F(X) || X <- RetList].


mark_couple_cruising(PS) ->
    case player:get_pid(PS) of
        null -> skip;
        Pid -> gen_server:cast(Pid, {'set_cur_bhv_state', ?BHV_COUPLE_CRUISING})
    end.

mark_stop_couple_cruising(PS) ->
    player:mark_idle(PS),
    ply_scene:notify_bhv_state_changed_to_aoi(player:id(PS), ?BHV_IDLE).

%% 标记玩家为巡游中
mark_player_cruising_hide(ReqJoinPlayerList) when is_list(ReqJoinPlayerList) ->
    F = fun(PlayerId) ->
            case player:get_PS(PlayerId) of
                null ->
                    skip;
                PS ->
                    mark_player_cruising_hide(PS)
            end
        end,
    lists:foreach(F, ReqJoinPlayerList);


mark_player_cruising_hide(PS) ->
    case player:get_pid(PS) of
        null -> skip;
        Pid -> gen_server:cast(Pid, {'set_cur_bhv_state', ?BHV_COUPLE_HIDE})
    end.


try_mark_idle(PS) ->
    case player:get_cur_bhv_state(PS) =:= ?BHV_COUPLE_HIDE of
        true -> player:mark_idle(PS);
        false -> skip
    end.

do_single_teleport(PS, SceneId, X, Y) ->
    case player:get_pid(PS) of
        null -> skip;
        Pid -> gen_server:cast(Pid, {'do_single_teleport', SceneId, X, Y})
    end.

% return [{GoodsNo, MoneyCount},...]
mk_output_money() ->
    MoneyList = (data_couple:get(cruise, get_wedding_car_type()))#couple_cfg.output_money,
    LeftList = get_left_money(),
    F = fun({MoneyType, MoneyCount}, Acc) ->
        case lists:keyfind(MoneyType, 1, LeftList) of
            false -> Acc;
            {_, LeftCount} -> 
                GoodsNo = 
                    case MoneyType of
                        ?MNY_T_GAMEMONEY -> ?VGOODS_GAMEMONEY;
                        ?MNY_T_YUANBAO -> ?VGOODS_YB;
                        ?MNY_T_BIND_GAMEMONEY -> ?VGOODS_BIND_GAMEMONEY;
                        ?MNY_T_BIND_YUANBAO -> ?VGOODS_BIND_YB
                    end,
                [{GoodsNo, MoneyCount - LeftCount} | Acc]
        end
    end,
    lists:foldl(F, [], MoneyList).