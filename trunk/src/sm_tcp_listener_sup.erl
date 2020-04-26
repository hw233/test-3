%%%-----------------------------------
%%% @Module  : sm_tcp_listener_sup
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2011.06.01
%%% @Description: tcp listerner 监控树
%%%-----------------------------------

-module(sm_tcp_listener_sup).

-behaviour(supervisor).

-export([start_link/1]).

-export([init/1]).

start_link(Port) ->
    supervisor:start_link(?MODULE, {10, Port}).

init({AcceptorCount, Port}) ->
    {ok,
        {{one_for_all, 10, 10},
            [
                {
                    sm_tcp_acceptor_sup,
                    {sm_tcp_acceptor_sup, start_link, []},
                    transient,
                    infinity,
                    supervisor,
                    [sm_tcp_acceptor_sup]
                },
                {
                    sm_tcp_listener,
                    {sm_tcp_listener, start_link, [AcceptorCount, Port]},
                    transient,
                    100,
                    worker,
                    [sm_tcp_listener]
                }
            ]
        }
    }.
