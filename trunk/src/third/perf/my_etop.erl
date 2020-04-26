-module(my_etop).
-export([init/0, 
         stop/0,
         sample/3, 
         start/3]).

-include("global2.hrl").
-include("log2.hrl").
-include("pt_61.hrl").

-define(INTERVAL, 5).
-define(VALID_SORTS, [{runtime}, {reductions}, {memory}, {msg_q}]).

init() ->
        nosql:new(my_etop).

stop() ->
        pass.

sample(Time, Lines, Sort) ->
        Repc = 
        case Time div ?INTERVAL of
                0 ->
                        1;
                Other ->
                        Other
        end,

        start(Repc, Lines, Sort).

start(Repc, Lines, Sort) ->
        case nosql:exists(my_etop, running) of
                true ->
                        false;
                false ->
                        case Lines > 0 of
                                true ->
                                        case lists:keyfind(Sort, 1, ?VALID_SORTS) of
                                                false ->
                                                        false;
                                                _Other ->
                                                        spawn(fun() -> 
                                                                nosql:set(my_etop, running, true),

                                                                monitor:trace("start etop...", []),

                                                                FileName = nosql:get(system, app) ++ "-etop-" ++ 
                                                                           atom_to_list(Sort) ++ "-" ++ time:date_str() ++ ".log",

                                                                FullFileName = ?LOG_PERF_PATH ++ FileName,

                                                                etop2:start([{output, text}, 
                                                                             {outfile, FullFileName},
                                                                             {interval, ?INTERVAL}, 
                                                                             {repc, Repc},
                                                                             {lines, Lines},
                                                                             {tracing, off}, 
                                                                             {sort, Sort}]),

                                                                monitor:trace("end etop. (~p)", [FullFileName]),
                                                                monitor:send_msg(?PT_MONITOR_ETOP_SAMPLE, FileName),

                                                                nosql:del(my_etop, running)
                                                              end),

                                                        true          
                                        end;
                                false ->
                                        false                  
                        end
        end.