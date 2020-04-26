-module(profiler).
-export([init/0, stop/0, 
         sample/1, sample/2, sample/3]).

-include("global2.hrl").
-include("pt_61.hrl").

init() ->
        nosql:new(profiler).

stop() ->
        pass.

%%采样
sample(Time) ->
        sample(self(), Time, "").

sample(Pid, Time) ->
        sample(Pid, Time, "").

sample(Pid, Time, Alias) ->
        AppName = nosql:get(system, app),

        case Alias of 
                "" ->
                        StrPid = pid_to_list(Pid),

                        TracePrefix = AppName ++ "-prof-proc-" ++ lists:sublist(StrPid, 2, length(StrPid) - 2),

                        FullTracePrefix = ?LOG_PERF_PATH ++ TracePrefix;
                _Other ->
                        TracePrefix = AppName ++ "-prof-" ++ Alias,
                        
                        FullTracePrefix = ?LOG_PERF_PATH ++ TracePrefix
        end,

        case nosql:exists(profiler, Pid) of 
                true ->
                        pass;
                false ->
                        spawn(fun() -> 
                                start_fprof(Pid, FullTracePrefix),
                                
                                timer:sleep(Time * 1000), 

                                stop_fprof(Pid, FullTracePrefix, TracePrefix) 
                              end)
        end,

        ok.

%%启动profile跟踪
start_fprof(Pid, FullTracePrefix) ->
        nosql:set(profiler, Pid, 0),

        fprof:trace([start, {file, FullTracePrefix ++ ".log"}, {procs, Pid}]),

        monitor:trace("~p start tracing...", [Pid]).

%%停止profile跟踪
stop_fprof(Pid, FullTracePrefix, TracePrefix) ->
        fprof:trace(stop),

        TraceFile = FullTracePrefix ++ ".log",

        fprof:profile({file, TraceFile}),

        file:delete(TraceFile),

        Analyse = TracePrefix ++ "-" ++ time:date_str() ++ ".log",

        FullAnalyse = FullTracePrefix ++ "-" ++ time:date_str() ++ ".log",

        fprof:analyse([{dest, FullAnalyse}, {details, true}, {totals, true}, {sort, own}]),

        nosql:del(profiler, Pid),

        monitor:trace("~p end tracing. (~p)", [Pid, FullAnalyse]),
        monitor:send_msg(?PT_MONITOR_PROF_SAMPLE, Analyse).