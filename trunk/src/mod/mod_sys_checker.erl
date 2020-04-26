%%% -------------------------------------------------------------------
%%% Author  : Lzz
%%% Description : 进程检查器
%%%
%%% Created : 2013年8月16日
%%% -------------------------------------------------------------------
-module(mod_sys_checker).

-behaviour(gen_server).
%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------
-include("common.hrl").
-include_lib("runtime_tools/include/observer_backend.hrl").
%% --------------------------------------------------------------------
%% External exports
-export([get_warn/0,
         add_alert/1,
         del_alert/1,
         get_alerts/0,
         clear_alerts/0]).

%% gen_server callbacks
-export([start/0, start_link/0, init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-record(state, {warn        = [],
                collector   = undefined, %% 收集者的Pid
                alerts      = []}).

-define(MAX_MSG_LENGTH, 300). % 最大消息队列长度
-define(MAX_RED_PER_MS, 2000). % 每毫秒redution上限
-define(SYS_CHECK_INTERVAL, 100000). % 检查间隔(毫秒)
-define(COLLECT_TIMEOUT, 2000). % 进程检查超时时间(毫秒)

-define(HASH_MAX, 4294967295).

%% 收集的进程信息, 把不要的注释掉
-define(PROC_INFO, [
                    % binary,
                    % catchlevel,
                    % current_function,
                    % current_location,
                    current_stacktrace,
                    % dictionary,
                    % error_handler,
                    % garbage_collection,
                    % group_leader,
                    % heap_size,
                    % initial_call,
                    % links,
                    % last_calls,
                    memory,
                    message_queue_len,
                    % messages,
                    % min_heap_size,
                    % min_bin_vheap_size,
                    % monitored_by,
                    % monitors,
                    % priority,
                    reductions,
                    registered_name
                    % sequential_trace_token,
                    % stack_size,
                    % status,
                    % suspending,
                    % total_heap_size,
                    % trace,
                    % trap_exit
                    ]).

-define(KEY_PROC, [
                access_queue_sup,
                access_queue_svr,
                access_queue_svr_bdist,

                act_log_svr,

                broadcast_process,
                mod_ply_hb_mgr,

                dungeon_manage,

                guild_process,

                ibrowse,
                ibrowse_sup,

                log_sup,
                mark_process,

                mod_activity,
                mod_battle_mgr,
                mod_cruise,
                mod_disperse,

                mod_kernel,
                mod_lginout_TSL,

                mod_mon_mgr,

                mod_npc_mgr,
                mod_ply_asyn,
                mod_ply_jobsch,
                mod_rank,

                mod_scene_mgr,
                mod_sys_jobsch,
                mod_timer,

                mysql_dispatcher,

                offline_arena_manage,

                ply_tmplogout_cache,
                public_db_proc,

                relation_process,

                shop_process,
                sm_sup,
                sm_tcp_acceptor_sup,
                sm_tcp_client_sup,
				sm_cross_client_sup,
				
                svr_clock,
                sys_log_svr,

                team_process
    ]).


get_warn() ->
    gen_server:call(?MODULE, get_warn).

add_alert(Alert) ->
    gen_server:call(?MODULE, {add_alert, Alert}).

del_alert(Uid) ->
    gen_server:call(?MODULE, {del_alert, Uid}).

get_alerts() ->
    gen_server:call(?MODULE, get_alerts).

clear_alerts() ->
    gen_server:call(?MODULE, clear_alerts).

%% ====================================================================
%% External functions
%% ====================================================================
start() ->
    case erlang:whereis(?MODULE) of
        undefined ->
            case supervisor:start_child(
               sm_sup,
               {?MODULE,
                {?MODULE, start_link, []},
                 permanent, 10000, worker, [?MODULE]}) of
            {ok, Pid} ->
                Pid;
            {error, R} ->
                ?WARNING_MSG("start error:~p~n", [R]),
                undefined
            end;
        Pid ->
            Pid
    end.

start_link() ->
    gen_server:start_link({local,?MODULE}, ?MODULE, [], []).

%% ====================================================================
%% Server functions
%% ====================================================================

%% --------------------------------------------------------------------
%% Function: init/1
%% Description: Initiates the server
%% Returns: {ok, State}          |
%%          {ok, State, Timeout} |
%%          ignore               |
%%          {stop, Reason}
%% --------------------------------------------------------------------
init([]) ->
    mod_timer:reg_loop_msg(self(), ?SYS_CHECK_INTERVAL),
    {ok, #state{}}.

%% --------------------------------------------------------------------
%% Function: handle_call/3
%% Description: Handling call messages
%% Returns: {reply, Reply, State}          |
%%          {reply, Reply, State, Timeout} |
%%          {noreply, State}               |
%%          {noreply, State, Timeout}      |
%%          {stop, Reason, Reply, State}   | (terminate/2 is called)
%%          {stop, Reason, State}            (terminate/2 is called)
%% --------------------------------------------------------------------
handle_call(Request, From, State) ->
    try
        do_call(Request, From, State)
    catch
        Err:Reason->
            ?WARNING_MSG("ERR:~p,Reason:~p",[Err,Reason]),
             {reply, error, State}
    end.

%% --------------------------------------------------------------------
%% Function: handle_cast/2
%% Description: Handling cast messages
%% Returns: {noreply, State}          |
%%          {noreply, State, Timeout} |
%%          {stop, Reason, State}            (terminate/2 is called)
%% --------------------------------------------------------------------

% handle_cast({add_pid, Pid},#state{pids=Pids}=State) ->
%     Pids1 =
%         case lists:member(Pid, Pids) of
%             ?false ->
%                 [Pid|Pids];
%             _ ->
%                 Pids
%         end,
%     {noreply, State#state{pids=Pids1}};

handle_cast(Msg, State) ->
    ?WARNING_MSG("handle cast is not match : ~p",[Msg]),
    {noreply, State}.

%% --------------------------------------------------------------------
%% Function: handle_info/2
%% Description: Handling all non call/cast messages
%% Returns: {noreply, State}          |
%%          {noreply, State, Timeout} |
%%          {stop, Reason, State}            (terminate/2 is called)
%% --------------------------------------------------------------------
handle_info(Request, State) ->
    try
        do_info(Request, State)
    catch
        Err:Reason->
            ?WARNING_MSG("ERR:~p,Reason:~p",[Err,Reason]),
             {noreply, State}
    end.

%% --------------------------------------------------------------------
%% Function: terminate/2
%% Description: Shutdown the server
%% Returns: any (ignored by gen_server)
%% --------------------------------------------------------------------
terminate(_Reason, _State) ->
    ok.

%% --------------------------------------------------------------------
%% Func: code_change/3
%% Purpose: Convert process state when code is changed
%% Returns: {ok, NewState}
%% --------------------------------------------------------------------
code_change(_, State, _) ->
    {ok, State}.

%% --------------------------------------------------------------------
%%% Internal functions
%% --------------------------------------------------------------------

do_call(get_warn, _From, #state{warn=Warn}=State) ->
    Reply = Warn,
    {reply, Reply, State};

do_call({add_alert, Alert = {ErrCode, Content}}, _From, State = #state{alerts = Alerts}) ->
    Uid = erlang:phash2(Alert, ?HASH_MAX),

    case lists:keyfind(Uid, 1, Alerts) of
        false ->
            {reply, Uid, State#state{alerts = [{Uid, ErrCode, Content} | Alerts]}};
        _ ->
            {reply, Uid, State}
    end;

do_call({del_alert, Uid}, _From, State = #state{alerts = Alerts}) ->
    {reply, ok, State#state{alerts = lists:keydelete(Uid, 1, Alerts)}};

do_call(get_alerts, _From, #state{alerts=Alerts}=State) ->
    {reply, Alerts, State};

do_call(clear_alerts, _From, State) ->
    {reply, ok, State#state{alerts = []}};

do_call(_Msg, _From, State) ->
    ?WARNING_MSG("unhandle call ~w", [_Msg]),
    {reply, error, State}.

do_info(doloop, State) ->
    State1 = case lib_comm:is_now_nearby_midnight() of
                true ->  % 午夜0点左右，业务逻辑处理比较多，为了避免给服务器更大的压力，故此段时间内不做etop
                    State;
                false ->
                    start_collect(State)
            end,
    {noreply, State1};

do_info({collect_timeout, Pid}, #state{collector=Pid}=State) -> % 采集信息超时
    erlang:exit(Pid, kill),
    State1 = warn_msg(critical, [system_buzy], State),
    {noreply, State1#state{collector=?undefined}};
do_info({collect_timeout, _}, State) ->
    {noreply, State};


do_info({_Pid, #etop_info{}=EInfo}, State) ->
    State1 = check(EInfo, State),
    gc(),
    State2 = State1#state{collector=?undefined},
    {noreply, State2};

do_info(_Msg, State) ->
    ?WARNING_MSG("unhandle info ~w", [_Msg]),
    {noreply, State}.


start_collect(#state{alerts = Alerts, collector=?undefined}) ->
    Pid = spawn(observer_backend,etop_collect,[self()]),
    erlang:send_after(?COLLECT_TIMEOUT, self(), {collect_timeout, Pid}),
    #state{alerts=Alerts, collector=Pid}; %% 清除旧记录
start_collect(State) ->
    State.


check(#etop_info{procinfo=ProcInfos}, State) ->
    State1 = check_proc_miss(State),
    State2 = lists:foldl(fun check_proc/2, State1, ProcInfos),
    State2.

check_proc_miss(State) ->
    Miss = [Name || Name <- ?KEY_PROC, whereis(Name) =:= ?undefined],
    warn_msg(miss, Miss, State).

check_proc(EtopProcInfo, State) ->
    State1 = check_msgq(EtopProcInfo, State),
    State2 = check_reds(EtopProcInfo, State1),
    State2.

check_msgq(#etop_proc_info{pid=Pid, mq=MQ}, State) when (MQ > ?MAX_MSG_LENGTH) ->
    warn_proc(msgq, Pid, State);
check_msgq(_, State) ->
    State.

check_reds(#etop_proc_info{pid=Pid, reds=Reds}, State) ->
    OldReds = erlang:get({reds, Pid}),
    OldReds1 = ?IF(OldReds =:= ?undefined, 0, OldReds),
    erlang:put({reds, Pid}, Reds),
    Limit = ?SYS_CHECK_INTERVAL * ?MAX_RED_PER_MS,
    case Reds - OldReds1 of
        RedsDiff when RedsDiff > Limit ->
            RPS = RedsDiff * 1000 div ?SYS_CHECK_INTERVAL,
            warn_proc(reds, Pid, [{reds_per_second, RPS}], State);
        _ ->
            State
    end.

gc() ->
    [erlang:erase({reds, Pid}) ||
        {{reds, Pid}, _} <- erlang:get(), not erlang:is_process_alive(Pid)],
    ok.

warn_msg(_Type, [], State) ->
    State;
warn_msg(Type, Msg, #state{warn=Warns}=State) ->
    Warns1 = [{Type, Msg}|Warns],
    State#state{warn=Warns1}.

warn_proc(Warn, Pid, #state{warn=Warns}=State) ->
    warn_proc(Warn, Pid, [], #state{warn=Warns}=State).

warn_proc(Warn, Pid, ExtInfo, #state{warn=Warns}=State) ->
    case process_info(Pid, ?PROC_INFO) of
        ?undefined ->
            State;
        Info ->
            Info1 = ExtInfo ++ Info,
            Warns1 = [{Warn, Info1}|Warns],
            State#state{warn=Warns1}
    end.



%%
%% Tests
%%
-ifdef(debug).
-include_lib("eunit/include/eunit.hrl").

msgq_test() ->
    Pid = spawn(fun() -> timer:sleep(600000) end),
    [Pid ! hello || _ <- lists:duplicate(?MAX_MSG_LENGTH + 1, dummy)],
    ok.

dead_loop_test() ->
    F = fun(X) -> X(X) end,
    P = spawn(fun() -> register(dead_loop_test, self()), F(F) end),
    timer:apply_after(120000, erlang, exit, [P, kill]),
    P.

reds_test() ->
    N = ?SYS_CHECK_INTERVAL * ?MAX_RED_PER_MS + 100,
    P = spawn(fun() -> reds_loop(N, ?SYS_CHECK_INTERVAL) end),
    timer:apply_after(300000, erlang, exit, [P, kill]),
    P.

kill_bdist_test() ->
    erlang:exit(whereis(access_queue_svr_bdist), kill).

reds_loop(N, Sleep) ->
    reds_loop(N),
    timer:sleep(Sleep),
    reds_loop(N, Sleep).

reds_loop(N) when N =<0 ->
    ok;
reds_loop(N) ->
    reds_loop(N-1).

-endif.
