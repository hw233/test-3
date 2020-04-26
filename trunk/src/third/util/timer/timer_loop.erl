-module(timer_loop).
-export([run/5,run/4]).

-include("global2.hrl").

run(Module, State, HandleMethod, StopMethod, StopArgs) ->
        receive
                Info ->
                        Ret = timer_dist:dispatch(Info, State, Module, HandleMethod)
        end,

        case Ret of 
                stop ->
                        simple_timer:clear_timer_refs(?TIMER_TYPE_MP),
                        simple_timer:clear_timer_refs(?TIMER_TYPE_SP),

                        simple_timer:clear_seeds(?TIMER_TYPE_MP),
                        simple_timer:clear_seeds(?TIMER_TYPE_SP),
                        
                        apply(Module, StopMethod, StopArgs);
                _Other ->
                        run(Module, HandleMethod, StopMethod, StopArgs)
        end.

run(Module, HandleMethod, StopMethod, StopArgs) ->
        run(Module, none, HandleMethod, StopMethod, StopArgs).