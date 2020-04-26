-module(daemon_svr).
-behaviour(gen_server).
-export([start_link/0, init/1, 
         handle_call/3, handle_cast/2, 
         handle_info/2, terminate/2, code_change/3,
         new_timer_seed/1, del_timer_seeds/2, 
         gen_rand_seed/1]).

-record(state, {timer_seed, rand_seed}).

-include("global2.hrl").

start_link() ->
        {ok, Pid} = gen_server:start_link(?MODULE, dummy, []),

        nosql:set(system, daemon, Pid),

        {ok, Pid}.

init(_Dummy) ->
        case nosql:exists(daemon, free_timer_seeds) of
                true ->
                        pass;
                false ->
                        nosql:set(daemon, free_timer_seeds, [])
        end,

        TimerSeed = 
        case nosql:get(daemon, timer_seed) of 
                undef ->
                        nosql:set(daemon, timer_seed, 0),

                        0;
                Other ->
                        Other
        end,

        RandSeed = 
        case nosql:get(daemon, rand_seed) of
                undef ->
                        DefaultSeed = erlang:now(),

                        nosql:set(daemon, rand_seed, DefaultSeed),

                        DefaultSeed;
                Other2 ->
                        Other2
        end,

        {ok, #state{timer_seed = TimerSeed, 
                    rand_seed  = RandSeed}}.

handle_call({apply, Module, Method, Args}, _From, State) ->
        {Reply, State2} = ?TRY_CATCH(apply(Module, Method, lists:append(Args, [State]))),
        
        {reply, Reply, State2};

handle_call(_Request, _From, State) -> 
        {reply, ok, State}.

handle_cast(Msg, State) ->
        {reply, _Reply, State2} = handle_call(Msg, unknown, State),

        {noreply, State2}.

handle_info(_Info, State) ->
        {noreply, State}.

terminate(_Reason, _State) ->
        ok.

code_change(_OldVsn, State, _Extra) ->
        {ok, State}.

%%生成定时器种子
new_timer_seed(State) ->
        FreeTimerSeeds = nosql:get(daemon, free_timer_seeds),

        case length(FreeTimerSeeds) of
                0 ->
                        NewTimerSeed = State#state.timer_seed,

                        NextTimerSeed = NewTimerSeed + ?TIMER_ID_RANGE,

                        nosql:set(daemon, timer_seed, NextTimerSeed);
                _Other ->
                        NewTimerSeed = lists:nth(1, FreeTimerSeeds),

                        nosql:set(daemon, free_timer_seeds, lists:delete(NewTimerSeed, FreeTimerSeeds)),

                        NextTimerSeed = State#state.timer_seed
        end,

        {NewTimerSeed, State#state{timer_seed = NextTimerSeed}}.

%%删除定时器种子
del_timer_seeds(TimerSeeds, State) ->
        FreeTimerSeeds = nosql:get(daemon, free_timer_seeds),

        nosql:set(daemon, free_timer_seeds, lists:append(FreeTimerSeeds, TimerSeeds)),

        {ok, State}.

%%生成随机种子
gen_rand_seed(State) ->
        random:seed(State#state.rand_seed),

        Seed = {random:uniform(99999), random:uniform(999999), random:uniform(999999)},

        nosql:set(daemon, rand_seed, Seed),

        {Seed, State#state{rand_seed = Seed}}.