-module(timer_svr).
-behaviour(gen_server).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-record(state, {state2, 
                module, 
                handle_info_method, 
                terminate_method}).

-include("global2.hrl").

%%需重载
state() ->
        null.

info_handler() ->
        null.

terminator() ->
        null.

init(_Dummy) ->
         {ok, #state{state2 = state(),
                     module = ?MODULE, 
                     handle_info_method = info_handler(),
                     terminate_method = terminator()}}.

handle_call(_Request, _From, State) -> 
        {reply, ok, State}.

handle_cast(_Msg, State) ->
        {noreply, State}.
        
handle_info(Info, State) ->
        State2 = timer_dist:dispatch(Info, State#state.state2, State#state.module, State#state.handle_info_method),

        {noreply, State#state{state2 = State2}}.
        
terminate(Reason, State) ->
        apply(State#state.module, State#state.terminate_method, [Reason, State#state.state2]),

        simple_timer:clear_timer_refs(?TIMER_TYPE_MP),
        simple_timer:clear_timer_refs(?TIMER_TYPE_SP),

        simple_timer:clear_seeds(?TIMER_TYPE_MP),
        simple_timer:clear_seeds(?TIMER_TYPE_SP),
                        
        ok.

code_change(_OldVsn, State, _Extra) ->
        {ok, State}.