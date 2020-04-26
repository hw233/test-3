%%%------------------------------------
%%% @author 严利宏 <542430172@qq.com>
%%% @copyright UCweb 2014.11.27
%%% @doc 悬赏任务管理器.
%%% @end
%%%------------------------------------

-module(mod_xs_task).
-behaviour(gen_server).
-export([start_link/0,stop/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-export([get_issue_task_list/0      % 获取悬赏任务列表
        ,get_issue_task/1           % 获取悬赏任务信息
        ,issue_task/1               % 发布悬赏任务
        ,receive_task/2             % 接取悬赏任务
        ,feedback_xs_task_finish/2  % 完成任务反馈
    ]).


-include("prompt_msg_code.hrl").
-include("debug.hrl").
-include("common.hrl").
-include("log.hrl").
-include("record.hrl").
-include("xs_task.hrl").

%%=========================================================================
%% 接口函数
%%=========================================================================

% 获取悬赏任务列表
get_issue_task_list() ->
    gen_server:call(?MODULE, 'get_issue_task_list').

% 获取悬赏任务信息
get_issue_task(IssueId) ->
    gen_server:call(?MODULE, {'get_issue_task', IssueId}).

% 发布悬赏任务
issue_task(IssueTask) ->
    gen_server:cast(?MODULE, {'issue_task', IssueTask}),
    ok.

% 接取悬赏任务
receive_task(IssueId, ReceiveRoleId) ->
    gen_server:cast(?MODULE, {'receive_task', IssueId, ReceiveRoleId}),
    ok.

% 完成任务反馈
feedback_xs_task_finish(TaskId, RoleId) ->
    gen_server:cast(?MODULE, {feedback_xs_task_finish, TaskId, RoleId}),
    ok.

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).
stop() ->
    gen_server:call(?MODULE, stop).

%%=========================================================
%% 合服私有函数
%%=========================================================
init_data(Count, Data) when Count > 0 ->
    Data1 = case db:select_one(xs_task, "data", [{id, Count-1}]) of null->[]; _D->util:bitstring_to_term(_D) end,
    Data2 = Data ++ Data1,
    init_data(Count-1, Data2);
init_data(_Count, Data) ->
    Data.

%%=========================================================================
%% 回调函数
%%=========================================================================
init([]) ->
    process_flag(trap_exit, true),
    % 加载悬赏任务信息 
    % Data = case db:select_one(xs_task, "data", [{id, 0}]) of null->[]; _D->util:bitstring_to_term(_D) end,
    Count = db:select_count(xs_task),
    Data = init_data(Count, []),
    % 初始化悬赏数据 -- 重新生成唯一id
    {NewData, NextId} = init_issue_data(Data),
    % 启动检查定时器
    mod_timer:reg_loop_msg(self(), ?XS_TASK_MATCH_PERIOD * 1000),
    {ok, #issue_state{next_id=NextId, task_list=NewData}}.

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
    ?TRY_CATCH(db:replace(xs_task, [{id, 0}, {data, util:term_to_bitstring(State#issue_state.task_list)}])),
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.


% handle_call
% 获取悬赏任务列表
do_call('get_issue_task_list', _From, State) ->
    Ret = State#issue_state.task_list,
    {reply, Ret, State};
% 获取悬赏任务信息
do_call({'get_issue_task', IssueId}, _From, State) ->
    Ret = lists:keyfind(IssueId, #issue_task.id, State#issue_state.task_list),
    {reply, Ret, State};
do_call(_Request, _From, State) ->
    throw({no_match, do_call, _Request}),
	{reply, ok, State}.

%handle_cast
% 发布悬赏任务
do_cast({'issue_task', IssueTask}, State) ->
    NextId          = State#issue_state.next_id,
    NewIssueTask    = IssueTask#issue_task{id = NextId},
    OldTaskList     = State#issue_state.task_list,
    NewState        = State#issue_state{task_list = [NewIssueTask|OldTaskList]
                                        ,next_id = NextId + 1
                                    },
    %轮询满足新任务的玩家
    spawn(fun() -> 
            foreach_check_is_can_recieve(NewIssueTask)
          end),

    {noreply, NewState};
% 领取悬赏任务
do_cast({'receive_task', IssueId, ReceiveRoleId}, State) ->
    TaskList = State#issue_state.task_list,
    case lists:keyfind(IssueId, #issue_task.id, TaskList) of
        false -> {noreply, State};
        IssueTask ->
            NewIssueTask = IssueTask#issue_task{issue_num = IssueTask#issue_task.issue_num - 1
                                                ,role_receive = [{util:unixtime(), ReceiveRoleId} |IssueTask#issue_task.role_receive]
                                            },
            NewTaskList = lists:keyreplace(IssueId, #issue_task.id, TaskList, NewIssueTask),
            {noreply, State#issue_state{task_list=NewTaskList}}
    end;
% 完成任务反馈
do_cast({feedback_xs_task_finish, TaskId, RoleId}, State) ->
    NewState = lib_xs_task:feedback_xs_task_finish(State, TaskId, RoleId),    
    {noreply, NewState};

do_cast(_Request, State) ->
    throw({no_match, do_cast, _Request}),
	{noreply, State}.

% handle_info
do_info(doloop, State) ->
    NewState = lib_xs_task:xs_task_doloop(State),
%    ?ylh_Debug("doloop ~p~n", [NewState]),
	{noreply, NewState};
do_info(_Request, State) ->
    throw({no_match, do_info, _Request}),
	{noreply, State}.



%%=========================================================================
%% 私有函数
%%=========================================================================
% 初始化悬赏任务数据
init_issue_data(Data) ->
    init_issue_data__(Data, 1, []).

init_issue_data__([], NextId, AccDList) -> {AccDList, NextId};
init_issue_data__([D|DList], NextId, AccDList) when is_record(D, issue_task) ->
    init_issue_data__(DList, NextId+1, [D#issue_task{id=NextId}|AccDList]);
init_issue_data__([_|DList], NextId, AccDList) ->
    init_issue_data__(DList, NextId, AccDList).


foreach_check_is_can_recieve(IssueTask) ->
    PlayerIdList = mod_svr_mgr:get_all_online_player_ids(),

    F = fun(PlayerId) ->
            ?TRY_CATCH(do_check_is_can_receive(PlayerId, IssueTask),  ErrReason_xs_task)
        end,
    [F(X) || X <- PlayerIdList],
    ok.

do_check_is_can_receive(PlayerId, IssueTask) ->
    case player:get_PS(PlayerId) of
        null -> skip;
        PS ->
            case lib_xs_task:do_check_receive_task(PS, IssueTask) of
                {error, _ErrCode} -> 
                    skip;
                {ok, _TaskId} -> 
                    ?ylh_Debug("do_check_is_can_receive~n"),
                    {ok, BinData} = pt_30:write(30104, [0]),
                    lib_send:send_to_sock(PS, BinData)
            end 
    end.


    