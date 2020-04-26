%%%-------------------------------------- 
%%% @Module: lib_bt_plot
%%% @Author: huangjf
%%% @Created: 2014.8.9
%%% @Description: 剧情战斗的剧情
%%%-------------------------------------- 

-module(lib_bt_plot).
-export([
		handle_plot/0
    ]).
    
-import(lib_bt_comm, [
			get_bo_by_id/1
			]).
    
    
-include("common.hrl").
-include("battle.hrl").
-include("record/battle_record.hrl").
-include("bt_plot.hrl").



handle_plot() ->
	State = lib_bt_comm:get_battle_state(),
	case need_handle_plot(State) of
		false ->
			skip;
		true ->
			PlotNo = lib_bt_comm:get_plot_no(State),
			EventNoList = get_plot_event_list(PlotNo),
			try_trigger_events(EventNoList)
	end.


get_plot_event_list(PlotNo) ->
	data_bt_plot_event:get_event_no_list_by_plot(PlotNo).


need_handle_plot(State) ->
	 lib_bt_comm:get_plot_no(State) /= ?INVALID_NO.
	

try_trigger_events([]) ->
	done;
try_trigger_events([EventNo | T]) ->
	try_trigger_one_event(EventNo),
	try_trigger_events(T).


try_trigger_one_event(EventNo) ->
	case data_bt_plot_event:get(EventNo) of
		null ->
			?ASSERT(false, EventNo),
			?ERROR_MSG("battle plot event not exists!! EventNo:~p", [EventNo]),
			skip;
		Event ->
			case check_trigger_one_event(Event) of
				fail ->
					skip;
				ok ->
					do_trigger_one_event(Event)
			end
	end.


check_trigger_one_event(Event) ->
	CondNoList = Event#bt_plot_event.condition_list,
	check_event_conditions(CondNoList).

check_event_conditions([]) ->
	ok;
check_event_conditions([CondNo | T]) ->
	% 复用lib_bt_AI:check_one_condition()做判断
	case lib_bt_AI:check_one_condition(dummy_bo, CondNo) of
		ok ->
			check_event_conditions(T);
		fail ->
			fail
	end.



do_trigger_one_event(Event) ->
	do_trigger_one_event(Event#bt_plot_event.content, Event).


do_trigger_one_event({spawn_mon, FromBMonNo, Side, Pos, CanBeCtrledFlag}, _Event) ->
	?ASSERT(is_integer(FromBMonNo), _Event),
	?ASSERT(Side == host_side orelse Side == guest_side, _Event),
	?ASSERT(is_integer(Pos), _Event),
	?ASSERT(Pos == ?INVALID_BATTLE_POS
			orelse (Pos >= ?MIN_BATTLE_POS andalso Pos =< ?MAX_BATTLE_POS_PER_SIDE), _Event),
	?ASSERT(CanBeCtrledFlag == can_be_ctrled orelse CanBeCtrledFlag == cannot_be_ctrled, _Event),

	Side2 = case Side of
				host_side -> ?HOST_SIDE;
				guest_side -> ?GUEST_SIDE
			end,
	Pos2 = lib_bt_misc:cfg_pos_to_server_logic_pos(Pos),
	CanBeCtrled = case CanBeCtrledFlag of
					  can_be_ctrled -> true;
					  cannot_be_ctrled -> false
				  end,
	spawn_bo(FromBMonNo, Side2, Pos2, CanBeCtrled);
	
do_trigger_one_event(_, Event) ->
	?ASSERT(false, Event),
	?ERROR_MSG("unknown battle plot event content!! Event:~w", [Event]),
	skip.




%% 刷出剧情bo
spawn_bo(FromBMonNo, Side, Pos, CanBeCtrled) ->
	?ASSERT(is_boolean(CanBeCtrled)),
	ExtraInfo = [{is_plot_bo, true}, {can_be_ctrled, CanBeCtrled}],
	case lib_bt_misc:add_one_monster(FromBMonNo, Side, Pos, ExtraInfo) of
		fail ->
			skip;
		{ok, NewBo} ->
			?BT_LOG(io_lib:format("spawn plot bo at round ~p, NewBo:~w~n", [lib_bt_comm:get_cur_round(), NewBo])),

			NewBo2 = lib_bo:init_tmp_rand_act_speed( lib_bo:id(NewBo) ),  % 初始化乱敏
			?ASSERT(lib_bt_comm:is_battle_obj_rd(NewBo2)),

			case lib_bt_comm:get_cur_round() of
				1 ->  % 在战斗开始时刷出，不主动通知客户端
					skip;
				_ ->
					lib_bt_send:notify_cli_new_bo_spawned(NewBo2)
			end
	end.
