-module(lib_event).
-include("common.hrl").
-include("record.hrl").
-include("event.hrl").
-export([event/3]).

event(EventType, Args, Status) ->
    % 已接任务处理
    lib_task:accept_handle(EventType, Args, Status),
    mod_dungeon:notify_event(EventType, Args, Status),
%%    lib_tower:notify_event(EventType, Args, Status),
    lib_hardtower:notify_event(EventType, Args, Status),
    handle_sys_open(EventType, Args, Status),
    on_event(EventType, Args, Status).


% on_event(kill, [TargetId, Num], Status) ->
    
%     redo.

on_event(_, _, _) ->
    skip.


handle_sys_open(EventType, _Args, Status) when EventType =:= ?TASK_ACCEPTED_EVENT orelse EventType =:= ?TASK_SUBMIT_EVENT ->
    ply_sys_open:check_and_handle_sys_open(Status);
handle_sys_open(_, _, _) -> skip.