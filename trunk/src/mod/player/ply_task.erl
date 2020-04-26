%%%--------------------------------------
%%% @Module  : ply_task
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2014.2.13
%%% @Description: 玩家与任务系统相关的业务逻辑
%%%--------------------------------------
-module(ply_task).
-export([
        has_task/2,
        has_unfinished_task/2,
		has_one_of_unfinished_task/2
    ]).


-include("common.hrl").




%% 判断玩家是否有指定id的任务
has_task(PS, TaskId) ->
	case lib_cross:check_is_mirror() of
		?true ->%% 当前是跨服镜像进程，向原服查询
			ServerId = player:get_server_id(PS),
			PlayerId = player:get_id(PS),
			sm_cross_server:rpc_call(ServerId, lib_task, publ_is_accepted, [TaskId, PlayerId]) == {ok, true};
		?false ->
			lib_task:publ_is_accepted(TaskId, PS)
	end.



%% 判断玩家是否有指定id的未完成的任务
has_unfinished_task(PS, TaskId) ->
	case lib_cross:check_is_mirror() of
		?true ->%% 当前是跨服镜像进程，向原服查询
			ServerId = player:get_server_id(PS),
			PlayerId = player:get_id(PS),
			sm_cross_server:rpc_call(ServerId, lib_task, publ_is_accepted, [TaskId, PlayerId]) == {ok, true} andalso
				sm_cross_server:rpc_call(ServerId, lib_task, publ_is_completed, [TaskId, PlayerId]) == {ok, false};
		?false ->
			lib_task:publ_is_accepted(TaskId, PS) 
				andalso (not lib_task:publ_is_completed(TaskId, PS))
	end.
        

%% 判断玩家是否有其中一个未完成的任务
has_one_of_unfinished_task(PlayerId, TaskIdList) when is_integer(PlayerId) ->
	case player:get_PS(PlayerId) of
		PS when is_tuple(PS) -> has_one_of_unfinished_task(PS, TaskIdList);
		_ -> false
	end;
	
has_one_of_unfinished_task(PS, TaskIdList) when is_tuple(PS) ->
	case lib_cross:check_is_mirror() of
		?true ->%% 当前是跨服镜像进程，向原服查询
			ServerId = player:get_server_id(PS),
			PlayerId = player:get_id(PS),
			sm_cross_server:rpc_call(ServerId, lib_cross, player_apply_call, [PlayerId, ?MODULE, has_one_of_unfinished_task, [PlayerId, TaskIdList]]) == {ok, true};
		?false ->
			has_one_of_unfinished_task2(PS, TaskIdList)
	end.

has_one_of_unfinished_task2(PS, [TaskId | T]) ->
    case has_unfinished_task(PS, TaskId) of
        true ->
            true;
        false ->
            has_one_of_unfinished_task(PS, T)
    end;
has_one_of_unfinished_task2(_PS, []) ->
    false.


    