-module(proc_logger).
-export([init/0,
         stop/0,
         add_reader/1,
         add_recver/2,
         add_sender/2,
         add_player/3,
         del_player/1,
         del_reader/1]).

init() ->
        nosql:new(accounts),
        nosql:new(procs_reader),
        nosql:new(procs_recver),
        nosql:new(procs_sender),
        nosql:new(procs_player).

stop() ->
        pass.
        
add_reader(ReaderPid) ->
        gen_server:cast(nosql:get(log, proc_log_svr), {add_reader, ReaderPid}).

add_recver(ReaderPid, RecverPid) ->
        gen_server:cast(nosql:get(log, proc_log_svr), {add_recver, ReaderPid, RecverPid}).

add_sender(ReaderPid, SenderPid) ->
        gen_server:cast(nosql:get(log, proc_log_svr), {add_sender, ReaderPid, SenderPid}).

add_player(ReaderPid, PlayerPid, AccName) ->
        gen_server:cast(nosql:get(log, proc_log_svr), {add_player, ReaderPid, PlayerPid, AccName}).

del_player(PlayerPid) ->
        gen_server:cast(nosql:get(log, proc_log_svr), {del_player, PlayerPid}).

del_reader(ReaderPid) ->
        gen_server:cast(nosql:get(log, proc_log_svr), {del_reader, ReaderPid}).