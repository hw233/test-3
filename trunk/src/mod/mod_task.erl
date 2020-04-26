%%%------------------------------------
%%% @Module  : mod_task
%%% @Author  : lds
%%% @Email   : 
%%% @Created : 2013.11
%%% @Description: 
%%%------------------------------------
-module(mod_task).
-behaviour(gen_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-include("common.hrl").

-record(state, {}).

-define(KEY(RoleId, TaskId), {RoleId, TaskId}).

init([]) ->
    process_flag('trap_exit', true),
    {ok, #state{}}.

handle_cast({'add_mon', _RoleId, _TaskId, _MonBatNo}, State) ->
    redo,
    {noreply, State};


handle_cast(_, State) ->
    {noreply, State}.

handle_call(_Request, _From, State) ->
    {reply, ok, State}.


handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.


