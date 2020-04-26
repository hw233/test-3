-module(simple_timer).
-export([init/0, stop/0, 
         clear_seeds/1,
         clear_timer_refs/1,
         set_timer/9, set_timer/6, set_timer/5, 
         kill_timer/2, kill_timer/1, 
         timer_arrive/1]).

-include("global2.hrl").

init() ->
        nosql:new(timer).

stop() ->
        pass.

%%初始化定时器ID
init_id(?TIMER_TYPE_MP) ->
        DaemonPid = nosql:get(system, daemon),

        TimerSeed = gen_server:call(DaemonPid, {apply, daemon_svr, new_timer_seed, []}, ?CALL_DAEMON_TIMEOUT),

        put(timer_id,    TimerSeed + 1),
        put(timer_seed,  TimerSeed),

        case get(timer_seeds) of 
                undefined ->
                        put(timer_seeds, [TimerSeed]);
                TimerSeeds ->
                        put(timer_seeds, lists:append(TimerSeeds, [TimerSeed]))
        end,

        TimerSeed;

init_id(?TIMER_TYPE_SP) ->
        put(timer_id, 1),

        0.

%%多进程定时器获取ID
gen_id(?TIMER_TYPE_MP) ->
        case get(timer_id) of 
                undefined ->
                        init_id(?TIMER_TYPE_MP);
                TimerID2 ->
                        case TimerID2 < get(timer_seed) + ?TIMER_ID_RANGE of
                                true ->
                                        put(timer_id, TimerID2 + 1),

                                        TimerID2;
                                false ->
                                        init_id(?TIMER_TYPE_MP)
                        end
        end;

%%单进程定时器获取ID
gen_id(?TIMER_TYPE_SP) ->
        case get(timer_id) of
                undefined ->
                        init_id(?TIMER_TYPE_SP);
                TimerID ->
                        put(timer_id, TimerID + 1),

                        TimerID
        end.

%%清除定时器种子
clear_seeds(?TIMER_TYPE_MP) ->
        DaemonPid = nosql:get(system, daemon),

        case get(timer_seeds) of 
                undefined ->
                        pass;
                TimerSeeds ->
                        gen_server:cast(DaemonPid, {apply, daemon_svr, del_timer_seeds, TimerSeeds})
        end;

clear_seeds(?TIMER_TYPE_SP) ->
        pass.

add_activer_timer_rd(Key, TimerID) ->
        case get(Key) of
                undefined ->
                        put(Key, [TimerID]);
                ActiveTimers ->
                        put(Key, lists:append(ActiveTimers, [TimerID]))
        end.

del_active_timer_rd(Key, TimerID) ->
        case get(Key) of
                undefined ->
                        pass;
                ActiveTimers ->
                        put(Key, lists:delete(TimerID, ActiveTimers))
        end.

get_active_timer_rd(Key) ->
        case get(Key) of
                undefined ->
                        [];
                ActiveTimers ->
                        ActiveTimers
        end.

%%设置定时器引用
set_timer_ref(?TIMER_TYPE_MP, TimerID, TimerRef) ->
        nosql:set(timer, TimerID, TimerRef),

        add_activer_timer_rd(mp_active_timers, TimerID);

set_timer_ref(?TIMER_TYPE_SP, TimerID, TimerRef) ->
        put("timer_" ++ integer_to_list(TimerID), TimerRef),

        add_activer_timer_rd(sp_active_timers, TimerID).

%%删除定时器引用
del_timer_ref(?TIMER_TYPE_MP, TimerID) ->
        TimerRef = nosql:get(timer, TimerID),

        case TimerRef of 
                undef ->
                        pass;
                _Other ->
                        erlang:cancel_timer(TimerRef),

                        nosql:del(timer, TimerID)
        end,

        del_active_timer_rd(mp_active_timers, TimerID);
        
del_timer_ref(?TIMER_TYPE_SP, TimerID) ->
        TimerIDKey = "timer_" ++ integer_to_list(TimerID),

        TimerRef = get(TimerIDKey),

        case TimerRef of 
                undefined ->
                        pass;
                _Other ->
                        erlang:cancel_timer(TimerRef),

                        erase(TimerIDKey)
        end,

        del_active_timer_rd(sp_active_timers, TimerID).

clear_timer_refs(?TIMER_TYPE_MP) ->
        lists:foreach(fun(TimerID) -> del_timer_ref(?TIMER_TYPE_MP, TimerID) end, get_active_timer_rd(mp_active_timers));

clear_timer_refs(?TIMER_TYPE_SP) ->
        lists:foreach(fun(TimerID) -> del_timer_ref(?TIMER_TYPE_SP, TimerID) end, get_active_timer_rd(sp_active_timers)).

%%重复timer，需生成唯一id进行抽象处理
set_timer(Type, Interval, RepeatCount, CallPid, CallModule, CallMethod, CallArgs, ErrCallModule, ErrCallMethod) ->
        TimerID = gen_id(Type),

        TimerRef = erlang:send_after(Interval, CallPid, {Type, TimerID, Interval, RepeatCount, 0, CallModule, CallMethod, CallArgs, ErrCallModule, ErrCallMethod}),

        set_timer_ref(Type, TimerID, TimerRef),

        TimerID.

set_timer(Type, Interval, RepeatCount, CallModule, CallMethod, CallArgs) ->
        set_timer(Type, Interval, RepeatCount, self(), CallModule, CallMethod, CallArgs, sys_logger, write_log).

set_timer(Interval, RepeatCount, CallModule, CallMethod, CallArgs) ->
        set_timer(?TIMER_TYPE_SP, Interval, RepeatCount, self(), CallModule, CallMethod, CallArgs, sys_logger, write_log).

%%杀死timer
kill_timer(Type, TimerID) ->
        del_timer_ref(Type, TimerID).

kill_timer(TimerID) ->
        kill_timer(?TIMER_TYPE_SP, TimerID).

%%timer到达
timer_arrive({Type, TimerID, Interval, RepeatCount, CurrCount, 
              CallModule, CallMethod, CallArgs, State, ErrCallModule, ErrCallMethod}) ->
        StateArgs = 
        case State of 
                none ->
                        [];
                _Other ->
                        [State]
        end,

        State2 = 
        case ?TRY_CATCH_WITH_CALL(apply(CallModule, CallMethod, lists:append(CallArgs, StateArgs)), ErrCallModule, ErrCallMethod) of 
                {ok, State3} ->
                        State3;
                _Other2 ->
                        State
        end,
        
        NextCount = CurrCount + 1,

        case RepeatCount of 
                0 ->
                        TimerRef2 = erlang:send_after(Interval, self(), {Type, TimerID, Interval, 0, NextCount, CallModule, CallMethod, CallArgs, ErrCallModule, ErrCallMethod}),

                        set_timer_ref(Type, TimerID, TimerRef2);
                1 ->
                        del_timer_ref(Type, TimerID);
                _Other3 ->
                        TimerRef2 = erlang:send_after(Interval, self(), {Type, TimerID, Interval, RepeatCount - 1, NextCount, CallModule, CallMethod, CallArgs, ErrCallModule, ErrCallMethod}),

                        set_timer_ref(Type, TimerID, TimerRef2)
        end,

        {ok, State2}.