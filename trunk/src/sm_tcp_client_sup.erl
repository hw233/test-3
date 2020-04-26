%%%-----------------------------------
%%% @Module  : sm_tcp_client_sup
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2011.06.01
%%% @Description: 客户端服务监控树
%%%-----------------------------------
-module(sm_tcp_client_sup).
-behaviour(supervisor).
-export([start_link/0]).
-export([init/1]).
start_link() ->
    supervisor:start_link({local,?MODULE}, ?MODULE, []).

init([]) ->
    {ok, {{simple_one_for_one, 10, 10},
          [{sm_reader, {sm_reader,start_link,[]},
            temporary, brutal_kill, worker, [sm_reader]}]}}.
