%%auto generated by extends make
-module(sys_log_svr).
-export([start_link/0,state/0,info_handler/0,terminator/0,handle_info2/2,terminate2/2,new_day_come/1,init/1,handle_call/3,handle_cast/2,handle_info/2,terminate/2,code_change/3]).
-record(state2, {fd}).
-record(state, {state2,module,handle_info_method,terminate_method}).
-behaviour(gen_server).
-include("global2.hrl").
-include("global2.hrl").
-include("log2.hrl").

%<source: timer_svr.erl:1>%
code_change(_OldVsn,State,_Extra)->
        %<source: timer_svr.erl:51>%
        {ok, State}.

handle_info2(fix, State = #state2{fd = Fd})->
        file:close(Fd),

        {ok, Fd2} = file:open(gen_log_filename(), [append, raw]),

        {noreply, State#state2{fd = Fd2}};

%<source: sys_log_svr.erl:1>%
handle_info2({write_log,Msg},State)->
        %<source: sys_log_svr.erl:33>%
        case log_io:write_event(State#state2.fd, Msg) of
                ok ->
                        {ok, State};
                {error, _} ->
                        case file:open(gen_log_filename(), [append, raw]) of
                                {ok, Fd} ->
                                        log_io:write_event(Fd, Msg),

                                        {ok, State#state2{fd = Fd}};
                                {error, Reason} ->
                                        error_logger:error_msg("sys_log_svr: error occur, reason:~p", [Reason]),

                                        gen_server:cast(self(), {stop, Reason}),

                                        {error, Reason}
                        end
        end;

%<source: sys_log_svr.erl:37>%
handle_info2(_Info, State) ->
        %<source: sys_log_svr.erl:38>%
        {ok, State}.

%<source: sys_log_svr.erl:1>%
state()->
        %<source: sys_log_svr.erl:24>%
        #state2{fd = init_log_file()}.

%<source: sys_log_svr.erl:1>%
start_link()->
        %<source: sys_log_svr.erl:17>%
        {ok, Pid} = gen_server:start_link({local, ?MODULE}, ?MODULE, dummy, []),
        %<source: sys_log_svr.erl:19>%
        set_log_svr_pid(Pid),
        %<source: sys_log_svr.erl:21>%
        {ok, Pid}.

%<source: sys_log_svr.erl:1>%
gen_log_filename()->
        %<source: sys_log_svr.erl:55>%
        AppName = nosql:get(system, app),
        %<source: sys_log_svr.erl:57>%
        ?LOG_PATH ++ AppName ++ "-" ++ get_log_file_prefix() ++ time:date_day_str() ++ ".log".

%<source: timer_svr.erl:1>%
handle_call(_Request,_From,State)->
        %<source: timer_svr.erl:29>%
        {reply, ok, State}.

%<source: sys_log_svr.erl:1>%
set_log_svr_pid(Pid)->
        %<source: sys_log_svr.erl:49>%
        nosql:set(log, sys_log_svr, Pid).

%<source: timer_svr.erl:1>%
handle_info(Info,State)->
        %<source: timer_svr.erl:35>%
        State2 = timer_dist:dispatch(Info, State#state.state2, State#state.module, State#state.handle_info_method),
        %<source: timer_svr.erl:37>%
        {noreply, State#state{state2 = State2}}.

%<source: timer_svr.erl:1>%
init(_Dummy)->
         %<source: timer_svr.erl:23>%
         {ok, #state{state2 = state(),
                     %<source: timer_svr.erl:24>%
                     module = ?MODULE,
                     %<source: timer_svr.erl:25>%
                     handle_info_method = info_handler(),
                     %<source: timer_svr.erl:26>%
                     terminate_method = terminator()}}.

%<source: sys_log_svr.erl:1>%
new_day_come(State)->
        %<source: sys_log_svr.erl:44>%
        file:close(State#state2.fd),
        %<source: sys_log_svr.erl:46>%
        {ok, State#state2{fd = init_log_file()}}.

handle_cast({stop, Reason},State)->
        {stop, Reason, State};

handle_cast(_Msg,State)->
        %<source: timer_svr.erl:32>%
        {noreply, State}.

%<source: sys_log_svr.erl:1>%
terminate2(_Reason,State)->
        %<source: sys_log_svr.erl:41>%
        file:close(State#state2.fd).

%<source: sys_log_svr.erl:1>%
get_log_file_prefix()->
        %<source: sys_log_svr.erl:52>%
        "sys-".

%<source: timer_svr.erl:1>%
terminate(Reason,State)->
        %<source: timer_svr.erl:40>%
        apply(State#state.module, State#state.terminate_method, [Reason, State#state.state2]),
        %<source: timer_svr.erl:42>%
        simple_timer:clear_timer_refs(?TIMER_TYPE_MP),
        %<source: timer_svr.erl:43>%
        simple_timer:clear_timer_refs(?TIMER_TYPE_SP),
        %<source: timer_svr.erl:45>%
        simple_timer:clear_seeds(?TIMER_TYPE_MP),
        %<source: timer_svr.erl:46>%
        simple_timer:clear_seeds(?TIMER_TYPE_SP),
        %<source: timer_svr.erl:48>%
        ok.

%<source: sys_log_svr.erl:1>%
init_log_file()->
        %<source: sys_log_svr.erl:60>%
        FileName = gen_log_filename(),
        %<source: sys_log_svr.erl:62>%
        {ok, Fd} = file:open(FileName, [append, raw]),
        %<source: sys_log_svr.erl:64>%
        simple_timer:set_timer(time:newday_countdown() * 1000, 1,  ?MODULE, new_day_come, []),
        %<source: sys_log_svr.erl:66>%
        Fd.

%<source: sys_log_svr.erl:1>%
terminator()->
        %<source: sys_log_svr.erl:30>%
        terminate2.

%<source: sys_log_svr.erl:1>%
info_handler()->
        %<source: sys_log_svr.erl:27>%
        handle_info2.

