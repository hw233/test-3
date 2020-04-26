%%%-----------------------------------
%%% @Module  : sm_gateway_sup
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2011.04.15
%%% @Description: 监控树
%%%-----------------------------------
-module(sm_gateway_sup).
-behaviour(supervisor).
-export([start_link/1]).
-export([init/1]).
-include("common.hrl").

start_link([Ip, Port, Sid]) ->
	supervisor:start_link({local,?MODULE}, ?MODULE, [Ip, Port, Sid]).

init([Ip, Port, Sid]) ->
    {ok,
        {
            {one_for_one, 3, 10},
            [
                {
                    sm_gateway,
                    {sm_gateway, start_link, [Port]},
                    permanent,
                    10000,
                    supervisor,
                    [sm_gateway]
                },
                {
                    mod_disperse,
                    {mod_disperse, start_link,[Ip, Port, Sid]},
                    permanent,
                    10000,
                    supervisor,
                    [mod_disperse]
                }
            ]
        }
    }.
