-module(timer_dist).
-export([dispatch/4]).

-include("global2.hrl").

apply_func(sys_log_svr, Method, Args) ->
        ?TRY_CATCH_WITH_KERNEL(apply(sys_log_svr, Method, Args), _ErrReason);

apply_func(Module, Method, Args) ->
        ?TRY_CATCH(apply(Module, Method, Args)).

dispatch(Info, State, Module, HandleMethod) ->
        case Info of
                %timer消息到达
                {Type, TimerID, Interval, RepeatCount, CurrCount, CallModule, CallMethod, CallArgs, ErrCallModule, ErrCallMethod} ->
                        {ok, State2} = simple_timer:timer_arrive({Type, TimerID, Interval, RepeatCount, CurrCount, CallModule, CallMethod, CallArgs, State, ErrCallModule, ErrCallMethod});
                %其他消息到达
                Other ->
                        case State of 
                                none ->
                                        apply_func(Module, HandleMethod, [Other]),
                                        
                                        State2 = State;
                                _Other ->
                                        State2 = 
                                        case apply_func(Module, HandleMethod, [Other, State]) of
                                                {ok, State3} ->
                                                        State3;
                                                _Other2 ->
                                                        State
                                        end
                        end
        end,
        
        State2.