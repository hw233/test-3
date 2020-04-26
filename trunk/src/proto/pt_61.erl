-module(pt_61).
-export([read/2, write/2]).

-include("common.hrl").
-include("pt_61.hrl").

read(?PT_MONITOR_COME, <<>>) ->
        {ok, ?PT_MONITOR_COME, null};

read(?PT_MONITOR_PROCESS_COUNT, <<>>) ->
        {ok, ?PT_MONITOR_PROCESS_COUNT, null};

read(?PT_MONITOR_PROCESSES, <<>>) ->
        {ok, ?PT_MONITOR_PROCESSES, null};

read(?PT_MONITOR_PROCESS_INFO, <<_Len:16, BPid/binary>>) ->
        {ok, ?PT_MONITOR_PROCESS_INFO, binary_to_list(BPid)};

read(?PT_MONITOR_MEMORY, <<>>) ->
        {ok, ?PT_MONITOR_MEMORY, null};

read(?PT_MONITOR_MANUAL_GC, <<_Len:16, BPid/binary>>) ->
        {ok, ?PT_MONITOR_MANUAL_GC, binary_to_list(BPid)};

read(?PT_MONITOR_PROF_SAMPLE, <<Time:16, _Len:16, BPid/binary>>) ->
        {ok, ?PT_MONITOR_PROF_SAMPLE, [Time, binary_to_list(BPid)]};

read(?PT_MONITOR_ETOP_SAMPLE, <<Time:16, Lines:16, _Len:16, BSort/binary>>) ->
        {ok, ?PT_MONITOR_ETOP_SAMPLE, [Time, Lines, binary_to_list(BSort)]};

read(?PT_ACC_QUEUE_QUERY_INDEX, <<>>) ->
        {ok, ?PT_ACC_QUEUE_QUERY_INDEX, null};

read(?PT_ACC_QUEUE_SET_MAX_POL, <<MaxPol:16>>) ->
        {ok, ?PT_ACC_QUEUE_SET_MAX_POL, MaxPol};

read(?PT_ACC_QUEUE_GET_OL_INFO, <<>>) ->
        {ok, ?PT_ACC_QUEUE_GET_OL_INFO, null};

read(?PT_CROSS_CONNECT_NETWORK, <<ServerId:32, BinData/binary>>) ->
	{Auth, _} = pt:read_string(BinData),
	{ok, ?PT_CROSS_CONNECT_NETWORK, [ServerId, Auth]};


read(_PtID, _Content) ->
        pass.

write(?PT_MONITOR_PROCESS_COUNT, Content) ->
        {ok, pt:pack(?PT_MONITOR_PROCESS_COUNT, <<Content:16>>)};

write(?PT_ACC_QUEUE_START_WAIT, [Index, PlayOlNum]) ->
        {ok, pt:pack(?PT_ACC_QUEUE_START_WAIT, <<Index:16, PlayOlNum:16>>)};

write(?PT_ACC_QUEUE_QUERY_INDEX, [Index, PlayOlNum]) ->
        {ok, pt:pack(?PT_ACC_QUEUE_QUERY_INDEX, <<Index:16, PlayOlNum:16>>)};
        
write(?PT_ACC_QUEUE_SERVER_FULL, null) ->
        {ok, pt:pack(?PT_ACC_QUEUE_SERVER_FULL, <<>>)};

write(?PT_ACC_QUEUE_GET_OL_INFO, [PlayOlNum, MaxPlayOlNum, WaitOlNum, MaxWaitOlNum]) ->
        {ok, pt:pack(?PT_ACC_QUEUE_GET_OL_INFO, <<PlayOlNum:16, MaxPlayOlNum:16, WaitOlNum:16, MaxWaitOlNum:16>>)};
        
write(PtID, Content) ->
        {ok, pt:pack(PtID, my_eapi:string_to_binary(Content))}.