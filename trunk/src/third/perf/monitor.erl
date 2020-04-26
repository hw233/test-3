-module(monitor).
-export([handle_msg/3, send_msg/2, trace/2, trace/1]).

-include("global2.hrl").
-include("pt_61.hrl").

handle_msg(Sock, ?PT_MONITOR_COME, _Content) ->
        nosql:new(monitor),

        nosql:set(monitor, sock, Sock),

        profiler:init(),

        my_etop:init();

handle_msg(_Sock, ?PT_MONITOR_PROCESS_COUNT, _Content) ->
        send_msg(?PT_MONITOR_PROCESS_COUNT, system_info:process_count());

handle_msg(_Sock, ?PT_MONITOR_PROCESSES, _Content) ->
        send_msg(?PT_MONITOR_PROCESSES, system_info:proceses());

handle_msg(_Sock, ?PT_MONITOR_PROCESS_INFO, Content) ->
        send_msg(?PT_MONITOR_PROCESS_INFO, system_info:process_info(Content));

handle_msg(_Sock, ?PT_MONITOR_MEMORY, _Content) ->
        send_msg(?PT_MONITOR_MEMORY, system_info:memory());

handle_msg(_Sock, ?PT_MONITOR_MANUAL_GC, Content) ->
        send_msg(?PT_MONITOR_MANUAL_GC, system_info:gc(Content));

handle_msg(_Sock, ?PT_MONITOR_PROF_SAMPLE, Content) ->
        [Time, StrPid] = Content,

        Pid = system_info:convert_pid(StrPid),

        profiler:sample(Pid, Time);

handle_msg(_Sock, ?PT_MONITOR_ETOP_SAMPLE, Content) ->
        [Time, Lines, Sort] = Content,
        
        my_etop:sample(Time, Lines, list_to_atom(Sort));
        
handle_msg(_Sock, _PtID, _Content) ->
        undef.

send_msg(PtID, Content) ->
        Sock = nosql:get(monitor, sock),

        {ok, Data} = pt_61:write(PtID, Content),

        case nosql:get(sock_writer_map, Sock) of
                undef ->
                        pass;
                SendPid ->
                        SendPid ! {send, Data}
        end.

trace(Format, Args) ->
        send_msg(?PT_MONITOR_TRACE, my_eapi:sprintf(Format, Args)).

trace(Content) ->
        trace(Content, []).