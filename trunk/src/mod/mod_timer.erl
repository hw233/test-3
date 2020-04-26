%%% -------------------------------------------------------------------
%%% Author  : Eric
%%% Description :
%%%
%%% Created : 2012-6-20
%%% -------------------------------------------------------------------
-module(mod_timer).

-behaviour(gen_server).
%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------
-include("common.hrl").
%% --------------------------------------------------------------------
%% External exports
-export([reg_loop_msg/2]).

%% gen_server callbacks
-export([start/0, start_link/0, init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-record(state, {loop_list=[]}).

%% ====================================================================
%% External functions
%% ====================================================================
reg_loop_msg(Pid, Time) ->
	gen_server:cast(?MODULE, {add_timer, Pid, Time}),
	ok.

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
    {ok, #state{loop_list=dict:new()}}.

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
handle_call(_Request, _From, State) ->
    Reply = ok,
    {reply, Reply, State}.

%% --------------------------------------------------------------------
%% Function: handle_cast/2
%% Description: Handling cast messages
%% Returns: {noreply, State}          |
%%          {noreply, State, Timeout} |
%%          {stop, Reason, State}            (terminate/2 is called)
%% --------------------------------------------------------------------
handle_cast({add_timer, Pid, Time},State) ->
	case get({timer,Time}) of
		undefined->
			put({timer,Time},[Pid]),
			erlang:send_after(Time, self(), {loop,Time});
		L->
			case lists:member(Pid, L) of
				true->skip;
				false->put({timer,Time},[Pid|L])
			end
	end,
    {noreply, State};

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
handle_info({loop,Time},State) ->
	erlang:send_after(Time, self(),{loop,Time}),
	Pids=get({timer,Time}),
	NewPids=[begin Pid!doloop,Pid end||Pid<-Pids,erlang:is_process_alive(Pid)],
	put({timer,Time},NewPids),
    {noreply, State};

handle_info(Info,State) ->
	?WARNING_MSG("~p not handle.",[Info]),
    {noreply, State}.
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
