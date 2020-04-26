%%%--------------------------------------
%%% @Module  : ply_npc_interact
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2013.12.6
%%% @Description: 玩家与NPC交互的相关业务逻辑
%%%--------------------------------------
-module(ply_npc_interact).
-export([
		check_trigger_mf_conditions/2
    ]).


-include("common.hrl").





%% 检测玩家是否满足通过对话npc直接去打怪的条件
%% @return: ok | fail
check_trigger_mf_conditions(_PS, []) ->
	ok;
check_trigger_mf_conditions(PS, [Condition | T]) ->
    case check_one_trigger_mf_condition(PS, Condition) of
        ok ->
            check_trigger_mf_conditions(PS, T);
        fail ->
            fail
    end.




check_one_trigger_mf_condition(PS, Condition) ->
    case Condition of
        {has_task, TaskId} ->
            ?ASSERT(is_integer(TaskId), TaskId),
            case ply_task:has_task(PS, TaskId) of
                true -> ok;
                false -> fail
            end;

        {has_unfinished_task, TaskId} ->
            ?ASSERT(is_integer(TaskId), TaskId),
            case ply_task:has_unfinished_task(PS, TaskId) of
                true -> ok;
                false -> fail
            end;

        {has_one_of_unfinished_task, TaskIdList} ->
            ?ASSERT(util:is_integer_list(TaskIdList), TaskIdList),
            case ply_task:has_one_of_unfinished_task(PS, TaskIdList) of
                true -> ok;
                false -> fail
            end;
            
        _ ->
            ?ASSERT(false, Condition),
            fail
    end.




