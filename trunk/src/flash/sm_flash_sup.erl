%%%-----------------------------------
%%% @Module  : sm_flash_sup
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2011.04.15
%%% @Description: 监控树
%%%-----------------------------------
-module(sm_flash_sup).
-behaviour(supervisor).
-export([start_link/1]).
-export([init/1]).
-include("common.hrl").

start_link([Port]) ->
	supervisor:start_link({local,?MODULE}, ?MODULE, [Port]).

init([Port]) ->
    {ok,
        {
            {one_for_one, 3, 10},
            [
                {
                    sm_flash,
                    {sm_flash, start_link, [Port]},
                    permanent,
                    10000,
                    supervisor,
                    [sm_flash]
                }
            ]
        }
    }.
