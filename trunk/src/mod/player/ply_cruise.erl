%%%--------------------------------------
%%% @Module  : ply_cruise
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2014.5.27
%%% @Description: 玩家与巡游活动（跟随npc）相关的业务逻辑
%%%--------------------------------------
-module(ply_cruise).
-export([
		req_join_cruise/1,
		stop_cruise/2,
		c2s_notify_quiz_pass/1,

		on_player_tmp_logout/1,

		mark_waiting_to_start_cruise/1,
        mark_cruising/1,
        is_waiting_to_start_cruise/1,
        is_cruising/1,

        get_max_join_times_per_day/0,
        get_already_join_times/1,
        incr_join_times/1,
        has_join_times/1,

        daily_reset/1,

        notify_cli_req_join_success/2,
        notify_cli_stop_cruise_success/1,
        notify_cli_inst_finish/1,
        notify_cli_event_triggered/2,
        notify_cli_npc_talk_event_triggered/3
    ]).

-include("common.hrl").
-include("record.hrl").
-include("char.hrl").
-include("cruise_activity.hrl").
-include("pt_13.hrl").
-include("activity_degree_sys.hrl").




%% 报名参加巡游活动
req_join_cruise(PS) ->
	mod_cruise:player_req_join_cruise(PS).



%% 中断巡游
%% @para: Reason => 中断的原因：stop_by_player（玩家主动中断）| logout（因下线而中断）
stop_cruise(PS, Reason) ->
	mod_cruise:player_stop_cruise(PS, Reason).




%% 客户端通知服务端：玩家答题正确
c2s_notify_quiz_pass(PS) ->
	mod_cruise:c2s_notify_player_pass_quiz(PS).

	



on_player_tmp_logout(PS) ->
	case is_waiting_to_start_cruise(PS) orelse is_cruising(PS) of
		true ->
			stop_cruise(PS, logout);  %%%mod_cruise:on_player_tmp_logout(PS);
		false ->
			skip
	end.



%% 标记为正在等待开始巡游
mark_waiting_to_start_cruise(PS) ->
	player:set_cur_bhv_state(PS, ?BHV_WAITING_TO_START_CRUISE),
	ply_scene:notify_bhv_state_changed_to_aoi( player:id(PS), ?BHV_WAITING_TO_START_CRUISE). % 顺带通知aoi


%% 标记为正在巡游中
mark_cruising(PS) ->
	player:set_cur_bhv_state(PS, ?BHV_CRUISING),
	ply_scene:notify_bhv_state_changed_to_aoi( player:id(PS), ?BHV_CRUISING). % 顺带通知aoi


%% 是否正在等待开始巡游？
is_waiting_to_start_cruise(PS) ->
	player:get_cur_bhv_state(PS) == ?BHV_WAITING_TO_START_CRUISE.

%% 是否正在巡游中？
is_cruising(PS) ->
	player:get_cur_bhv_state(PS) == ?BHV_CRUISING.



get_max_join_times_per_day() ->
	?MAX_JOIN_TIMES_PER_DAY.




%% 获取当天已参加巡游活动的次数
get_already_join_times(PS) ->
	case get_cruise_activity_data(PS) of
		null ->
			0;
		Data ->
			Data#ply_cruise.join_times
	end.


%% 递增当天已参加巡游活动的次数
incr_join_times(PS) ->
    lib_activity_degree:publ_add_sys_activity_times(?AD_CRUISE, PS),
	Data2 = case get_cruise_activity_data(PS) of
				null ->
					#ply_cruise{join_times = 1};
				Data ->
					OldTimes = Data#ply_cruise.join_times,
					Data#ply_cruise{join_times = OldTimes + 1}
			end,
	set_cruise_activity_data(PS, Data2).



%% 当天是否还有参加巡游活动的次数？
has_join_times(PS) ->
	?TRACE("has_join_times(), PlayerId:~p, already join times: ~p~n", [player:id(PS), get_already_join_times(PS)]),
	get_already_join_times(PS) < ?MAX_JOIN_TIMES_PER_DAY.
		





%% @return: null | ply_cruise结构体
get_cruise_activity_data(PS) ->
	PlayerId = player:id(PS),
	ply_activity:get(PlayerId, ?AD_CRUISE).

set_cruise_activity_data(PS, Data) when is_record(Data, ply_cruise) ->
	PlayerId = player:id(PS),
	ply_activity:set(PlayerId, ?AD_CRUISE, Data).




%% 每日重置（重置活动次数等）
daily_reset(PS) ->
    case get_cruise_activity_data(PS) of
    	null ->
            skip;
        Data ->
            Data2 = Data#ply_cruise{join_times = 0},
            set_cruise_activity_data(PS, Data2)
    end.





notify_cli_req_join_success(PS, [DiffTime]) ->
	{ok, Bin} = pt_13:write(?PT_PLYR_REQ_JOIN_CRUISE, [?RES_OK, DiffTime]),
	lib_send:send_to_sock(PS, Bin).




notify_cli_stop_cruise_success(PS) ->
	{ok, Bin} = pt_13:write(?PT_PLYR_STOP_CRUISE, [?RES_OK]),
	lib_send:send_to_sock(PS, Bin).


notify_cli_inst_finish(PS) ->
	{ok, Bin} = pt_13:write(?PT_PLYR_NOTIFY_CRUISE_FINISH, []),
	lib_send:send_to_sock(PS, Bin).
    

% notify_cli_event_triggered(PlayerId, [NpcId, EventNo]) ->
% 	?ASSERT(is_integer(PlayerId), PlayerId),
% 	notify_cli_event_triggered(PlayerId, [NpcId, EventNo, ?INVALID_QUESTION_NO]);
	
notify_cli_event_triggered(PlayerId, [NpcId, EventNo, QuestionNo, Pos]) ->
	?ASSERT(is_integer(PlayerId), PlayerId),
	X = Pos#coord.x,
	Y = Pos#coord.y,
	{ok, Bin} = pt_13:write(?PT_PLYR_NOTIFY_CRUISE_EVENT_TRIGGERED, [NpcId, EventNo, QuestionNo, X, Y]),
	lib_send:send_to_uid(PlayerId, Bin).

	


notify_cli_npc_talk_event_triggered(NpcObj, EventNo, Pos) ->
	NpcId = mod_npc:get_id(NpcObj),
	SceneId = mod_npc:get_scene_id(NpcObj),
	X = Pos#coord.x,
	Y = Pos#coord.y,
	{ok, Bin} = pt_13:write(?PT_PLYR_NOTIFY_CRUISE_EVENT_TRIGGERED, [NpcId, EventNo, ?INVALID_QUESTION_NO, X, Y]),
	lib_send:send_to_AOI({SceneId, X, Y}, Bin).





% join_cruise(PS) ->
% 	player:mark_cruising(PS),
% 	mod_cruise_activity:player_join_cruise(PS).







% stop_cruise() ->
% 	todo_here.
% 	