-module(access_queue_sup).
-behaviour(supervisor).

-export([start_link/0, 
         init/1]).

-include("global2.hrl").

start_link() ->
        supervisor:start_link({local, ?MODULE}, ?MODULE, dummy).
        
init(_Dummy) ->
        {ok,
                {
                        {one_for_one, ?SUP_MAX, ?SUP_WITHIN}, 
                        [
                                {
                                        access_queue_svr, 
                                        {access_queue_svr, start_link, []}, 
                                        ?SUP_HOW_RESTART, 
                                        5000, 
                                        worker, 
                                        [access_queue_svr]
                               }
                        ]
                }
        }.