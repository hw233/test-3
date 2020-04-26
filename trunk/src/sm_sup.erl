%%%-----------------------------------
%%% @Module  : sm_sup
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2011.04.15
%%% @Description: 监控树
%%%-----------------------------------
-module(sm_sup).
-behaviour(supervisor).
-export([start_link/0, init/1]).

start_link() ->
	supervisor:start_link({local,?MODULE}, ?MODULE, []).

%% start_child(Mod) ->
%%     start_child(Mod, []).
%% 
%% start_child(Mod, Args) ->
%%     {ok, _} = supervisor:start_child(?MODULE,
%%                                      {Mod, {Mod, start_link, Args},
%%                                       transient, 100, worker, [Mod]}),
%%     ok.

init([]) -> 
	%gen_event:swap_handler(alarm_handler, {alarm_handler, swap}, {sm_alarm_handler, sm_server}),
	{ok, {   
            {one_for_one, 10, 1},   
            []         
	}}. 
