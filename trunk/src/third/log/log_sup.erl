-module(log_sup).
-behaviour(supervisor).

-export([start_link/0, init/1,
         start_sys_log/0,
         start_act_log/0]).

-include("global2.hrl").

start_link() ->
        nosql:new(log),

        proc_logger:init(),

        supervisor:start_link({local, ?MODULE}, ?MODULE, dummy).

init(_Dummy) ->
        {ok,
                {
                        {one_for_one, ?SUP_MAX, ?SUP_WITHIN},
                        [
                                % {
                                %         proc_log_svr,
                                %         {proc_log_svr, start_link, []},
                                %         ?SUP_HOW_RESTART,
                                %         5000,
                                %         worker,
                                %         [proc_log_svr]
                                % }
                        ]
                }
        }.

start_sys_log() ->
        supervisor:start_child(?MODULE,
                               {
                                        sys_log_svr,
                                        {sys_log_svr, start_link, []},
                                        temporary,
                                        5000,
                                        worker,
                                        [sys_log_svr]
                               }).

start_act_log() ->
        supervisor:start_child(?MODULE,
                               {
                                        act_log_svr,
                                        {act_log_svr, start_link, []},
                                        temporary,
                                        5000,
                                        worker,
                                        [act_log_svr]
                               }).