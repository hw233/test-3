-module(sm_third).
-export([start/2]).

-include("global2.hrl").
-include("framework.hrl").
-include("access_queue.hrl").

start(Sup, AppName) ->
        nosql:new(system),

        nosql:set(system, app, AppName),

        nosql:new(daemon),

        nosql:new(access_queue),

        nosql:new(sock_user_map),
        
        nosql:new(sock_writer_map),
        
        mod_timer:start(),
        
        simple_timer:init(),

        web_svr:init(),
        
        start_daemon(Sup),

        start_log(Sup),

        start_access_queue(Sup),

        start_ibrowse(Sup),
        
        start_admin().

start_daemon(Sup) ->
        supervisor:start_child(Sup,
                               {
                                        daemon_sup,
                                        {daemon_sup, start_link,[]},
                                        ?SUP_HOW_RESTART, 
                                        infinity, 
                                        supervisor, 
                                        [daemon_sup]
                               }).

start_log(Sup) ->
        supervisor:start_child(Sup,
                               {
                                        log_sup,
                                        {log_sup, start_link, []},
                                        ?SUP_HOW_RESTART, 
                                        infinity, 
                                        supervisor, 
                                        [log_sup]
                               }).

start_access_queue(Sup) ->
        ?ASSERT(?MAX_PLAY_OL_NUM >= ?MIN_PLAY_OL_NUM),
        
        supervisor:start_child(Sup,
                               {
                                        access_queue_sup,
                                        {access_queue_sup, start_link, []},
                                        ?SUP_HOW_RESTART, 
                                        infinity, 
                                        supervisor, 
                                        [access_queue_sup]
                               }).

start_ibrowse(Sup) ->
        supervisor:start_child(Sup,
                               {
                                        ibrowse_sup,
                                        {ibrowse_sup, start_link, []},
                                        ?SUP_HOW_RESTART, 
                                        infinity, 
                                        supervisor, 
                                        [ibrowse_sup]
                               }).    

start_admin() ->
        ServerName = atom_to_list(?APP_SERVER),

        web_svr:add_esi(ServerName, sm_admin),

        web_svr:start(config:get_adm_port_to_listen(?APP_SERVER), ServerName).