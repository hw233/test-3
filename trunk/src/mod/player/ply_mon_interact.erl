%%%--------------------------------------
%%% @Module  : ply_mon_interact
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2013.11.6
%%% @Description: 玩家与明雷怪交互的相关接口
%%%--------------------------------------
-module(ply_mon_interact).
-export([
		check_trigger_mf_conditions/2,
		check_trigger_mf_conditions/3
    ]).

-include("common.hrl").
-include("pt_32.hrl").
-include("prompt_msg_code.hrl").




%% 检测通过对话明雷怪触发战斗的条件
%% @return: ok | {fail, Reason} | {fail, Reason, ExtraInfoList}
check_trigger_mf_conditions(PS, MonObj) ->
	check_trigger_mf_conditions(PS, MonObj, 1).


check_trigger_mf_conditions(PS, MonObj, Difficulty) ->
	ConditionList = mod_mon:get_trigger_battle_condi(MonObj),
	?ASSERT(is_list(ConditionList), MonObj),
	check_trigger_mf_conditions__(PS, MonObj, Difficulty,ConditionList).




check_trigger_mf_conditions__(PS, MonObj, Difficulty,[Condition | T]) ->
	case check_one_trigger_battle_condi(PS, MonObj, Difficulty,Condition) of
		ok ->
			check_trigger_mf_conditions__(PS, MonObj, Difficulty,T);
		{fail, Reason} ->
			{fail, Reason};
		{fail, Reason, ExtraInfoList} ->
			{fail, Reason, ExtraInfoList}
	end;
check_trigger_mf_conditions__(_PS, _MonObj, _Difficulty,[]) ->
	ok.




check_one_trigger_battle_condi(PS, _MonObj, Difficulty,{lv, NeedLv}) ->
	case player:get_lv(PS) >= NeedLv of
		true ->
			ok;
		false ->
			{fail, ?TTM_FAIL_LV_LIMIT, [NeedLv]}
	end;


check_one_trigger_battle_condi(PS, _MonObj, Difficulty,{has_task, TaskId}) ->
	case lib_task:publ_is_accepted(TaskId, PS) of
		true ->
			ok;
		false ->
			{fail, ?TTM_FAIL_HAS_NOT_TASK, [TaskId]}
	end;


check_one_trigger_battle_condi(PS, _MonObj, Difficulty,{has_one_of_tasks, TaskIdList}) ->  % 是否接取了其中的任意一个任务
	?ASSERT(is_list(TaskIdList), _MonObj),
	L = [lib_task:publ_is_accepted(X, PS) || X <- TaskIdList],
	case lists:member(true, L) of
		true ->
			ok;
		false ->
			{fail, ?TTM_FAIL_HAS_NOT_ONE_OF_TASKS, [TaskIdList]}
	end;


check_one_trigger_battle_condi(PS, _MonObj, Difficulty,not_in_team) -> % 是否不在队伍中
	case player:is_in_team(PS) of
		true ->
			{fail, ?TTM_FAIL_IS_IN_TEAM};
		false ->
			ok
	end;

check_one_trigger_battle_condi(PS, _MonObj, Difficulty,{not_in_team, {lv_between, Lv1, Lv2}}) -> % 不在队伍中，并且等级在指定的等级范围内
	case player:is_in_team(PS) of
		true ->
			{fail, ?TTM_FAIL_IS_IN_TEAM};
		false ->
			Lv = player:get_lv(PS),
			case Lv1 =< Lv andalso Lv =< Lv2 of
				true ->
					ok;
				false ->
					{fail, ?TTM_FAIL_LV_NOT_FIT, [Lv1, Lv2]}
			end
	end;

check_one_trigger_battle_condi(PS, _MonObj, Difficulty,{in_team, {least_non_tmp_leave_mb_count, Count}}) ->  % 在队伍中（非暂离），并且队伍中非暂离的人数不少于Count个
	?ASSERT(util:is_positive_int(Count), Count),
	case player:is_in_team_and_not_tmp_leave(PS) of
		false ->
			{fail, ?TTM_FAIL_IS_NOT_IN_TEAM};
		true ->
			TeamId = player:get_team_id(PS),
			case mod_team:get_normal_member_count(TeamId) < Count of
				true ->
					?TRACE("check_one_trigger_battle_condi(), in_team, least_non_tmp_leave_mb_count,  failed!!!~n"),
					{fail, ?TTM_FAIL_NON_TMP_LEAVE_MEMBER_COUNT_NOT_ENOUGH, [Count]};
				false ->
					ok
			end
	end;


check_one_trigger_battle_condi(PS, _MonObj, Difficulty,{in_team, {all_has_unfinished_task, TaskId}}) ->  % 在队伍中（非暂离），并且队伍中所有非暂离的队员都有未完成的指定id的任务
	?ASSERT(util:is_positive_int(TaskId), TaskId),
	case player:is_in_team_and_not_tmp_leave(PS) of
		false ->
			{fail, ?TTM_FAIL_IS_NOT_IN_TEAM};
		true ->
			TeamId = player:get_team_id(PS),
			L = mod_team:get_normal_member_id_list(TeamId),
			case are_all_has_unfinished_task(L, TaskId) of
				true ->
					ok;
				false ->
					?TRACE("check_one_trigger_battle_condi(), in_team, all_has_unfinished_task,  failed!!!~n"),
					{fail, ?TTM_FAIL_NOT_ALL_HAS_UNFINISHED_TASK, [TaskId]}
			end
	end;

check_one_trigger_battle_condi(PS, _MonObj, Difficulty,{in_team, {has_unfinished_task, TaskId}, {least_count, Count}}) ->  % 在队伍中（非暂离），并且队伍中至少有Count个非暂离的队员有未完成的指定id的任务
	?ASSERT(util:is_positive_int(TaskId), TaskId),
	?ASSERT(util:is_positive_int(Count), Count),
	case player:is_in_team_and_not_tmp_leave(PS) of
		false ->
			{fail, ?TTM_FAIL_IS_NOT_IN_TEAM};
		true ->
			TeamId = player:get_team_id(PS),
			L = mod_team:get_normal_member_id_list(TeamId),
			% 判断是否跨服
			Fun = 
				case lib_cross:check_is_mirror() of
					?true ->
						fun(TaskIdF,MemberIdF,MemberPSF) ->
								sm_cross_server:rpc_call(player:get_server_id(MemberPSF), lib_task, publ_is_accepted, [TaskIdF, MemberIdF]) == {ok, true} andalso
									sm_cross_server:rpc_call(player:get_server_id(MemberPSF), lib_task, publ_is_completed, [TaskIdF, MemberIdF]) == {ok, false}
						end;
					?false ->
						fun(TaskIdF,_MemberIdF,MemberPSF) ->
								lib_task:publ_is_accepted(TaskIdF, MemberPSF) andalso (not lib_task:publ_is_completed(TaskIdF, MemberPSF))
						end
				end,
			F = fun(MemberId) ->
					case player:get_PS(MemberId) of
						null -> false;
						MemberPS ->
							Fun(TaskId, MemberId, MemberPS)
%% 							lib_task:publ_is_accepted(TaskId, MemberPS) andalso (not lib_task:publ_is_completed(TaskId, MemberPS))
%% 							sm_cross_server:rpc_call(player:get_server_id(MemberPS), lib_task, publ_is_accepted, [TaskId, MemberId]) == {ok, true} andalso
%% 								sm_cross_server:rpc_call(player:get_server_id(MemberPS), lib_task, publ_is_completed, [TaskId, MemberId]) == {ok, false}
					end
				end,

			L2 = [dummy || X <- L, F(X)],
			?TRACE("check_one_trigger_battle_condi(), in_team, has_unfinished_task, least_count, L2: ~p, LeastCount:~p~n", [L2, Count]),

			case length(L2) < Count of
				true ->
					{fail, ?TTM_FAIL_HAS_UNFINISHED_TASK_MEMBER_COUNT_NOT_ENOUGH, [TaskId, Count]};
				false ->
					ok 
			end
	end;

check_one_trigger_battle_condi(PS, _MonObj, Difficulty,{single_or_in_team, Condi}) when erlang:element(1, Condi) == lv_all_between -> % 单人或者在队伍中（非暂离），如果是单人，则等级需介于Lv1和Lv2之间（含），如果在队伍中（非暂离），则队伍所有非暂离的队员的等级需介于Lv1和Lv2之间（含）
	%% Lv2这里直接取最后一个数字作为上限 2020.01.15 zjy
	{Lv1, Lv2} = {element(Difficulty + 1, Condi), element(tuple_size(Condi), Condi)},
	?ASSERT(util:is_nonnegative_int(Lv1), Lv1),
	?ASSERT(util:is_nonnegative_int(Lv2), Lv2),
	?ASSERT(Lv1 =< Lv2),
	case player:is_in_team_and_not_tmp_leave(PS) of
		false ->
			Lv = player:get_lv(PS),
			case Lv1 =< Lv andalso Lv =< Lv2 of
				true ->  ok;
				false -> {fail, ?TTM_FAIL_LV_NOT_FIT, [Lv1, Lv2]}
			end;
		true ->
			TeamId = player:get_team_id(PS),
			L = mod_team:get_normal_member_id_list(TeamId),
			F = fun(MemberId) ->
					case player:get_PS(MemberId) of
						null ->
							pass;
						MemberPS ->
							Lv = player:get_lv(MemberPS),
							case Lv1 =< Lv andalso Lv =< Lv2 of
								true ->  pass;
								false -> not_pass
							end
					end
				end,
			L2 = [dummy || X <- L, F(X) == not_pass],
			?TRACE("check_one_trigger_battle_condi(), single_or_in_team, lv_all_between, not pass:~p~n", [L2]),

			case L2 of
				[] -> ok;
				_ -> {fail, ?TTM_FAIL_MEMBER_LV_NOT_FIT, [Lv1, Lv2]}
			end
	end;

check_one_trigger_battle_condi(_PS, _MonObj, Difficulty,_Condition) ->
	?ASSERT(false, _Condition),
	{fail, ?TTM_FAIL_UNKNOWN}. 






are_all_has_unfinished_task([], _TaskId) ->
	ok;
are_all_has_unfinished_task([PlayerId | T], TaskId) ->
	case player:get_PS(PlayerId) of
		null ->
			are_all_has_unfinished_task(T, TaskId);
		PS ->
			case lib_task:publ_is_accepted(TaskId, PS)
			andalso (not lib_task:publ_is_completed(TaskId, PS)) of
				true ->
					are_all_has_unfinished_task(T, TaskId);
				false ->
					false
			end
	end.

	


