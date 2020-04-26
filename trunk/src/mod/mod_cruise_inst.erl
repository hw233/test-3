%%%------------------------------------
%%% @Module  : mod_cruise_inst (inst: instance)
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2014.5.28
%%% @Description: npc巡游活动的实例
%%%------------------------------------
-module(mod_cruise_inst).
-behaviour(gen_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([
        start/2,
        player_stop_cruise/2,
        c2s_notify_player_pass_quiz/2
        ]).

-include("debug.hrl").
-include("cruise_activity.hrl").
-include("abbreviate.hrl").
-include("log.hrl").


-record(state, {}).


-define(NPC_MOVE_INTERVAL_MS, 3000).    % npc移动的时间间隔（单位：毫秒）
-define(REWARD_PLAYER_INTERVAL_MS, 4000).    % 奖励玩家的时间间隔（单位：毫秒）
-define(MAX_INST_LASTING_TIME_MS, (40 * 60 * 1000)).  % 活动实例的最长持续时间（单位：毫秒），暂时设为40分钟
-define(TIME_FOR_CLIENT_MOVE_NPC_EACH_STEP_MS, 2000). % 客户端移动npc每一步所需的时间（单位：毫秒）

%% 进程字典的key名
-define(PDKN_NPC_ID, pdkn_npc_id).
-define(PDKN_NPC_STEP_COUNT, pdkn_npc_step_count).
-define(PDKN_JOINING_PLAYER_LIST, pdkn_joining_player_list). % 当前正参与活动的玩家列表（目前是玩家id列表）
-define(PDKN_NPC_NEXT_MOVE_ON_TIME, pdkn_npc_next_move_on_time). % npc下次可前移的时间点
-define(PDKN_NPC_QUIZING_INFO, pdkn_npc_quizing_info).   % npc互动答题的信息，对应的值为：{npc当前是否在互动答题中(true|false), 当前所触发的互动答题事件的编号}
-define(PDKN_ALREADY_GET_QUIZ_REWARD_PLAYER_LIST, pdkn_already_get_quiz_reward_player_list). % 已经领取过当前互动答题奖励的玩家列表

%% 开启巡游活动的一个实例
start(NpcObj, ReqJoinPlayerList) ->
	NpcId = mod_npc:get_id(NpcObj),
	ProcName = to_inst_proc_name(NpcId),
    gen_server:start({local, ProcName}, ?MODULE, [NpcObj, ReqJoinPlayerList], []).


to_inst_proc_name(NpcId) ->
    list_to_atom("mod_cruise_inst_" ++ integer_to_list(NpcId)).



player_stop_cruise(InstPid, PlayerId) ->
	gen_server:cast(InstPid, {'player_stop_cruise', PlayerId}).


c2s_notify_player_pass_quiz(InstPid, PS) ->
	gen_server:cast(InstPid, {'c2s_notify_player_pass_quiz', PS}).
	


%% ===================================================================================================
    
init([NpcObj, ReqJoinPlayerList]) ->
    process_flag(trap_exit, true),
    % ?DEBUG_MSG("[mod_cruise_inst] init(), NpcId:~p", [mod_npc:get_id(NpcObj)]),
    do_init_jobs(NpcObj, ReqJoinPlayerList),
    State = #state{}, 
    {ok, State}.







handle_cast({'player_stop_cruise', PlayerId}, State) ->
    player_stop_cruise__(PlayerId),
    {noreply, State};


handle_cast({'c2s_notify_player_pass_quiz', PS}, State) ->
    handle_c2s_notify_player_pass_quiz__(PS),
    {noreply, State};


handle_cast(_R, State) ->
    ?ASSERT(false, _R),
    {noreply, State}.


handle_call(_R, _From, State) ->
    ?ASSERT(false, _R),
    {reply, ok, State}.




%% npc前移
handle_info('npc_move_on', State) ->
	case can_move_on() of
		true ->
			npc_move_on();
		false ->
			% ?DEBUG_MSG("can not move on, NpcId:~p, TimeNow:~p, NextMoveOnTime:~p", [get_npc_id(), util:unixtime(), get_npc_next_move_on_time()]),
			skip
	end,
    schedule_npc_move_on(), % 排定下一个前移
    {noreply, State};


handle_info('regular_reward_player', State) ->
    regular_reward_player(),
    schedule_regular_reward_player(), % 排定下一个定时奖励
    {noreply, State};


handle_info({'reward_player_for_event_triggered', Event}, State) ->
    do_reward_player_for_event_triggered(Event),
    {noreply, State};


handle_info('mark_npc_not_quizing', State) ->
	mark_npc_not_quizing(),
    {noreply, State};



%% 终止进程自身
handle_info({'stop_myself', Reason}, State) ->
    {stop, Reason, State};


handle_info(_R, State) ->
    {noreply, State}.

terminate(Reason, _State) ->
	case Reason of
		inst_lasting_for_too_long_time ->
			?ERROR_MSG("[mod_cruise_inst] error!!! terminate for reason: inst_lasting_for_too_long_time! NpcId:~p", [get_npc_id()]);
		_ ->
			?DEBUG_MSG("[mod_cruise_inst] terminate for reason: ~w", [Reason])
	end,
    ok.

code_change(_OldVsn, State, _Extra)->
	{ok, State}.

















do_init_jobs(NpcObj, ReqJoinPlayerList) ->
	NpcId = mod_npc:get_id(NpcObj),
	set_npc_id(NpcId),

	init_npc_step_count(),

	init_joining_player_list(ReqJoinPlayerList),

	schedule_stop_myself(),

	schedule_regular_reward_player(),

	let_npc_start_moving().

			




%% 获取活动实例对应的npc id
get_npc_id() ->
	erlang:get(?PDKN_NPC_ID).

%% 设置活动实例对应的npc id
set_npc_id(NpcId) ->
	erlang:put(?PDKN_NPC_ID, NpcId).

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
	
del_from_joining_player_list(PlayerId) ->
	OldList = get_joining_player_list(),
	?ASSERT(lists:member(PlayerId, OldList), {PlayerId, OldList}),
	NewList = OldList -- [PlayerId],
	set_joining_player_list(NewList).








let_npc_start_moving() ->
	self() ! 'npc_move_on'.


schedule_npc_move_on() ->
	erlang:send_after(?NPC_MOVE_INTERVAL_MS, self(), 'npc_move_on').


%% 一定时间后终止进程自身，以避免出bug后进程一直残余
schedule_stop_myself() ->	
	erlang:send_after(?MAX_INST_LASTING_TIME_MS, self(), {'stop_myself', inst_lasting_for_too_long_time}).


schedule_regular_reward_player() ->
	erlang:send_after(?REWARD_PLAYER_INTERVAL_MS, self(), 'regular_reward_player').


schedule_mark_npc_not_quizing() ->
	% 考虑到玩家可能出现网络延迟的情况，故额外加4秒的延迟
	erlang:send_after(?ONE_QUIZ_LASTING_TIME_MS + 4000, self(), 'mark_npc_not_quizing').



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

	


npc_move_on() ->
	NpcObj = get_npc_obj(),
	OldStepCount = get_npc_step_count(),

	?Ifc (OldStepCount == 0) % 尝试触发起点事件
		{InitX, InitY} = mod_npc:get_xy(NpcObj),
		% ?DEBUG_MSG("InitX:~p, InitY:~p", [InitX, InitY]),
		try_trigger_event({InitX, InitY})
	?End,

	NewStepCount = OldStepCount + 1,

	case data_npc_cruise_path:get(NewStepCount) of
		the_end ->
			% ?DEBUG_MSG("npc_move_on(), NpcId:~p, OldStepCount:~p, NewStepCount:~p, the end!!", [get_npc_id(), OldStepCount, NewStepCount]),
			inst_finish();
		{NewX, NewY} ->
			% ?DEBUG_MSG("npc_move_on(), NpcId:~p, OldStepCount:~p, NewStepCount:~p, NewX:~p, NewY:~p", [get_npc_id(), OldStepCount, NewStepCount, NewX, NewY]),
			incr_npc_step_count(),

			mod_npc:set_xy(NpcObj, {NewX, NewY}),

			SceneId = mod_npc:get_scene_id(NpcObj),
			{OldX, OldY} = mod_npc:get_xy(NpcObj),
			OldPos = lib_comm:to_coord({OldX, OldY}),
			NewPos = lib_comm:to_coord({NewX, NewY}),
			mod_go:npc_move(NpcObj, SceneId, OldPos, NewPos),

			try_trigger_event({NewX, NewY})
	end.




try_trigger_event({NewX, NewY}) ->
	case data_trigger_cruise_event:get({NewX, NewY}) of
		null ->
			skip;
		TriEvent ->
			Events = TriEvent#tri_cru_event.events,
			Pos = lib_comm:to_coord({NewX, NewY}),
			try_trigger_event_2(Events, Pos)
	end.



try_trigger_event_2([], _Pos) ->
	done;
try_trigger_event_2([EventInfo | T], Pos) ->
	{TriggerProba, EventNoList_ForProbaSuccess, EventNoList_ForProbaFail} = EventInfo,
	case util:decide_proba_once(TriggerProba) of
		success ->
			do_trigger_event(EventNoList_ForProbaSuccess, Pos);
		fail ->
			% ?DEBUG_MSG("try_trigger_event_2() fail for proba!! EventInfo:~w", [EventInfo]),
			do_trigger_event(EventNoList_ForProbaFail, Pos)
	end,
	try_trigger_event_2(T, Pos).



do_trigger_event([], _Pos) ->
	done;
do_trigger_event([EventNo | T], Pos) ->
	do_trigger_one_event(EventNo, Pos),
	do_trigger_event(T, Pos).



do_trigger_one_event(EventNo, Pos) ->
	case data_cruise_event:get(EventNo) of
		null ->
			?ASSERT(false, EventNo),
			skip;
		CruEvent ->
			% ?DEBUG_MSG("NpcId:~p, do_trigger_one_event:~w", [get_npc_id(), CruEvent]),
			do_trigger_one_event(CruEvent#cru_event.type, CruEvent, Pos)
	end.


do_trigger_one_event(?CRU_EVENT_T_STAY, CruEvent, _Pos) ->
	?ASSERT(CruEvent#cru_event.stay_time > 0, CruEvent),
	StayTime = CruEvent#cru_event.stay_time + 1,  % 加上客户端移动npc到下一个地点所需的时间（假设约等于1秒）
	TimeNow = util:unixtime(),
	NpcNextMoveOnTime = get_npc_next_move_on_time(),
	case NpcNextMoveOnTime > TimeNow of
		true ->  
			set_npc_next_move_on_time(NpcNextMoveOnTime + StayTime);  % 累加停留时间
		false ->
			set_npc_next_move_on_time(TimeNow + StayTime)
	end,
	try_reward_player_for_event_triggered(CruEvent);

do_trigger_one_event(?CRU_EVENT_T_TALK, CruEvent, Pos) ->
	NpcObj = get_npc_obj(),
	% NpcId = get_npc_id(),
	EventNo = CruEvent#cru_event.no,
	% F = fun(PlayerId) ->
			% ?DEBUG_MSG("notify_cli_event_triggered, NpcId:~p, PlayerId:~p, EventNo:~p", [NpcId, PlayerId, EventNo]),
			ply_cruise:notify_cli_npc_talk_event_triggered(NpcObj, EventNo, Pos),
			try_reward_player_for_event_triggered(CruEvent);
		% end,
	% L = get_joining_player_list(),
	% lists:foreach(F, L);
			
do_trigger_one_event(?CRU_EVENT_T_QUIZ, CruEvent, Pos) ->
	NpcId = get_npc_id(),
	EventNo = CruEvent#cru_event.no,
	QuestionPool = CruEvent#cru_event.question_pool,
	?ASSERT(is_list(QuestionPool), CruEvent),
	case QuestionPool == [] of
		true ->
			?ASSERT(false, CruEvent),
			skip;
		false ->
			mark_npc_quizing(EventNo),
			schedule_mark_npc_not_quizing(),

			QuestionNo = list_util:rand_pick_one(QuestionPool),
			F = fun(PlayerId) ->
					% ?DEBUG_MSG("notify_cli_event_triggered, NpcId:~p, PlayerId:~p, EventNo:~p, QuestionNo:~p", [NpcId, PlayerId, EventNo, QuestionNo]),
					ply_cruise:notify_cli_event_triggered(PlayerId, [NpcId, EventNo, QuestionNo, Pos])
				end,
			L = get_joining_player_list(),
			lists:foreach(F, L)
	end;	

do_trigger_one_event(_Type, _CruEvent, _Pos) ->
	?ASSERT(false, _CruEvent),
	skip.




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
% 			%% @doc 查询服务器相关系统的奖励倍率
% %% @Sys : 策划在节日活动表中配置的节日活动对应系统的No
% %% @return : integer()
% mod_svr_mgr:get_server_reward_multi(Sys)

% 全民追女Sys 固定是 16

			Lv = player:get_lv(PS),
			% 0.14*(等级^2) - 2.6*等级 + 190
			AddVal = util:ceil(0.14 * (Lv * Lv) - 2.6 * Lv + 190),

			AddVal2 = util:ceil(AddVal * mod_svr_mgr:get_server_reward_multi(16)),

			% 给玩家和宠物加经验 现在策划调整：副宠获得经验与主宠是1:1 即都与人物一样
			player:add_all_exp(PS, AddVal2, [?LOG_CRUISE, "continuity"])

			% % 给玩家的宠物加经验
			% case player:get_partner_id_list(PS) of
			% 	[] ->
			% 		skip;
			% 	_ ->
			% 		player:add_exp_to_main_par(PS, AddVal, [?LOG_CRUISE, "continuity"]),

			% 		AddValForDeputyPar = util:ceil(AddVal * 0.7),
			% 		player:add_exp_to_fighting_deputy_pars(PS, AddValForDeputyPar, [?LOG_CRUISE, "continuity"])
			% end
	end.

			


try_reward_player_for_event_triggered(Event) ->
	case Event#cru_event.reward of
		null ->
			skip;
		_ ->
			% 不立即奖励，而是等客户端做完npc移动的表现后再奖励
			schedule_reward_player_for_event_triggered(Event)
	end.


schedule_reward_player_for_event_triggered(Event) ->
	erlang:send_after(?TIME_FOR_CLIENT_MOVE_NPC_EACH_STEP_MS, self(), {'reward_player_for_event_triggered', Event}).


do_reward_player_for_event_triggered(Event) ->
	?ASSERT(Event#cru_event.reward /= null, Event),

	RewardPkgNo = Event#cru_event.reward,
	?ASSERT(is_integer(RewardPkgNo), Event),
	F = fun(PlayerId) ->
			case player:get_pid(PlayerId) of
				null -> skip;
				Pid -> gen_server:cast(Pid, {'reward_player', RewardPkgNo, [?LOG_CRUISE, "over"], mod_svr_mgr:get_server_reward_multi(16)})
			end
		end,
	L = get_joining_player_list(),
	lists:foreach(F, L).




player_stop_cruise__(PlayerId) ->
	del_from_joining_player_list(PlayerId).
	% todo: 其他处理？？。。



handle_c2s_notify_player_pass_quiz__(PS) ->
	case is_npc_quizing() of
		false ->
			?DEBUG_MSG("handle_c2s_notify_player_pass_quiz__(), npc not quizing!!!", []),
			skip;
		true ->
			%%% player:add_exp(PS, 400)
			PlayerId = player:id(PS),
			case is_already_get_quiz_reward(PlayerId) of
				true ->
					skip;
				false ->
					% 根据互动答题事件的编号，给予对应的奖励
					case get_cur_quiz_event_no() of
						?INVALID_QUIZ_EVENT_NO ->
							skip;
						QuizEventNo ->
							reward_player_for_pass_quiz(PS, QuizEventNo)
					end,

					mark_already_get_quiz_reward(PlayerId)
			end	
	end.

	
%% 玩家答题正确后给予对应的奖励
reward_player_for_pass_quiz(PS, QuizEventNo) ->
	CruEvent = data_cruise_event:get(QuizEventNo),
	case CruEvent#cru_event.reward of
		null ->
			skip;
		RewardPkgNo ->
			gen_server:cast(player:get_pid(PS), {'reward_player', RewardPkgNo, [?LOG_CRUISE, "answer"]})
	end.



is_already_get_quiz_reward(PlayerId) ->
	L = get_already_get_quiz_reward_player_list(),
	lists:member(PlayerId, L).


mark_already_get_quiz_reward(PlayerId) ->
	add_to_already_get_quiz_reward_player_list(PlayerId).


get_already_get_quiz_reward_player_list() ->
	case erlang:get(?PDKN_ALREADY_GET_QUIZ_REWARD_PLAYER_LIST) of
		undefined -> [];
		L -> L
	end.

set_already_get_quiz_reward_player_list(L) when is_list(L) ->
	erlang:put(?PDKN_ALREADY_GET_QUIZ_REWARD_PLAYER_LIST, L).


clear_already_get_quiz_reward_player_list() ->
	erlang:put(?PDKN_ALREADY_GET_QUIZ_REWARD_PLAYER_LIST, []).



add_to_already_get_quiz_reward_player_list(PlayerId) ->
	OldList = get_already_get_quiz_reward_player_list(),
	NewList = [PlayerId | OldList],
	set_already_get_quiz_reward_player_list(NewList).




get_cur_quiz_event_no() ->
	case erlang:get(?PDKN_NPC_QUIZING_INFO) of
		undefined ->
			?INVALID_QUIZ_EVENT_NO;
		{_IsQuizing, CurQuizEventNo} ->
			CurQuizEventNo
	end.

		
is_npc_quizing() ->
	case erlang:get(?PDKN_NPC_QUIZING_INFO) of
		undefined ->
			false;
		{IsQuizing, _CurQuizEventNo} ->
			IsQuizing
	end.

mark_npc_quizing(CurQuizEventNo) ->
	?ASSERT(CurQuizEventNo /= ?INVALID_QUIZ_EVENT_NO),
	erlang:put(?PDKN_NPC_QUIZING_INFO, {true, CurQuizEventNo}).


mark_npc_not_quizing() ->
	erlang:put(?PDKN_NPC_QUIZING_INFO, {false, ?INVALID_QUIZ_EVENT_NO}),
	clear_already_get_quiz_reward_player_list().


% set_npc_quizing(true, QuizEventNo) ->
% 	erlang:put(?PDKN_NPC_QUIZING_INFO, {true, QuizEventNo}).

% set_npc_quizing(false) ->
% 	erlang:put(?PDKN_NPC_QUIZING_INFO, false).





inst_finish() ->
	% ?DEBUG_MSG("[mod_cruise_inst] inst_finish, NpcId:~p", [get_npc_id()]),

	timer:sleep(?TIME_FOR_CLIENT_MOVE_NPC_EACH_STEP_MS),  % 等待客户端把npc移动到终点

	NpcObj = get_npc_obj(),
	JoiningPlayerList = get_joining_player_list(),
	mod_cruise:on_inst_finish(NpcObj, self(), JoiningPlayerList),
	stop_myself({shutdown, inst_finish}).



stop_myself(Reason) ->
	self() ! {'stop_myself', Reason}.

