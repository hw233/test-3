%%%-----------------------------------
%%% @Module  : sm_tcp_acceptor_sup
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2011.06.01
%%% @Description: tcp acceptor 监控树
%%%-----------------------------------
-module(sm_tcp_acceptor_sup).
-behaviour(supervisor).
-export([start_link/0, init/1]).

start_link() ->
    supervisor:start_link({local,?MODULE}, ?MODULE, []).

init([]) ->
    {ok, {{simple_one_for_one, 10, 10},
          [{sm_tcp_acceptor, {sm_tcp_acceptor, start_link, []},
            transient, brutal_kill, worker, [sm_tcp_acceptor]}]}}.
