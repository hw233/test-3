-module(system_info).
-export([convert_pid/1,
         process_count/0, 
         proceses/0,
         process_info/1,
         memory/0, 
         gc/1]).

convert_pid(StrPid) ->
        case StrPid of
                "" ->
                        self();
                _Other ->
                        list_to_pid(StrPid)
        end.
        
process_count() ->
        erlang:system_info(process_count).

proceses() ->
        Processes = erlang:processes(),
        
        my_eapi:sprintf("~p", [Processes]).

process_info(StrPid) ->
        Pid = convert_pid(StrPid),

        ProcessInfo = erlang:process_info(Pid),

        ProcessInfo2 = lists:delete(lists:keyfind(messages, 1, ProcessInfo), ProcessInfo),

        F = fun(Ident, ProcessInfo3) ->
                {Ident, Idents} = lists:keyfind(Ident, 1, ProcessInfo3),

                ProcessInfo4 = lists:delete({Ident, Idents}, ProcessInfo3),

                lists:append(ProcessInfo4, [{Ident, length(Idents)}])
            end,

        ProcessInfo5 = F(links, ProcessInfo2),
        ProcessInfo6 = F(dictionary, ProcessInfo5),
        ProcessInfo7 = F(suspending, ProcessInfo6),

        my_eapi:sprintf("~p", [ProcessInfo7]).
        
memory() ->
        Memory = erlang:memory(),

        my_eapi:sprintf("~p", [Memory]).

gc(StrPid) ->
        Pid = convert_pid(StrPid),

        erlang:garbage_collect(Pid),

        ProcessInfo = erlang:process_info(Pid),

        GcInfo = lists:keyfind(garbage_collection, 1, ProcessInfo),

        my_eapi:sprintf("~p", [GcInfo]).