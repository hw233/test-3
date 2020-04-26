-module(daemon_sup).
-behaviour(supervisor).
-export([start_link/0, init/1]).

-include("global2.hrl").

start_link() ->
        supervisor:start_link(?MODULE, dummy).

init(_Dummy) ->
        {ok,
                {
                        {one_for_one, ?SUP_MAX, ?SUP_WITHIN},
                        [
                                {
                                        daemon_svr,
                                        {daemon_svr, start_link, []},
                                        ?SUP_HOW_RESTART,
                                        infinity,
                                        supervisor,
                                        [daemon_svr]
                                }
                        ]
                }
        }.