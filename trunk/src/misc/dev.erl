%%----------------------------------------------------
%% 开发工具
%%
%% @author hmy 
%%----------------------------------------------------
-module(dev).
-export([
        info/0
        ,pinfo/1
        ,top/1
        ,top/3
    ]
).
-include_lib("kernel/include/file.hrl").
-include("common.hrl").
-include("node.hrl").

%% @spec info() -> ok
%% @doc 查看系统当前的综合信息
info() ->
    SchedId      = erlang:system_info(scheduler_id),
    SchedNum     = erlang:system_info(schedulers),
    ProcCount    = erlang:system_info(process_count),
    ProcLimit    = erlang:system_info(process_limit),
    ProcMemUsed  = erlang:memory(processes_used),
    ProcMemAlloc = erlang:memory(processes),
    MemTot       = erlang:memory(total),
    RoleNum      = ets:info(role_online, size),
%    RoleNumTotal = sys_node_mgr:role_num(all),
    io:format(
        "   Scheduler id:                         ~p~n"
        "   Num scheduler:                        ~p~n"
        "   Memory used by erlang processes:      ~p~n"
        "   Memory allocated by erlang processes: ~p~n"
        "   The total amount of memory allocated: ~p~n"
        "   can create process num:               ~p~n"
        "   process num:                          ~p~n"
%        "   总在线角色数:                         ~p~n"
        "   cur node player num:                  ~p~n"
        ,[SchedId
            ,SchedNum
            ,ProcMemUsed
            ,ProcMemAlloc
            ,MemTot
            ,ProcLimit
            ,ProcCount
%            ,RoleNumTotal
            ,RoleNum]),
    ok.

%% @spec top(Type) -> ok
%% @doc 显示资源占最多的进程列表
%% 参数说明见{@link adm:top/1}
top(Type) ->
    top(Type, 1, 10).

%% @spec top(Type, Start, Len) -> ok
%% @doc 显示资源占最多的进程列表
%% 参数说明见{@link adm:top/3}
top(Type, Start, Len) ->
    L = adm:top(Type, Start, Len),
    ?TRACE_W(
        "~20s ~24s ~36s ~12s ~12s ~12s~n"
        , ["Pid", "registered_name", "initial_call", "memory", "reductions", "msg_len"]
    ),
    print_top(lists:reverse(L)).

%% @spec pinfo(Options) -> ok
%% @doc 打印进程信息
pinfo({global, Name}) ->
    case global:whereis_name(Name) of
        undefined -> undefined;
        P -> pinfo(P)
    end;
pinfo(Name) when is_atom(Name) ->
    case erlang:whereis(Name) of
        undefined -> undefined;
        P -> pinfo(P)
    end;
pinfo(P) when is_list(P) ->
    pinfo(list_to_pid(P));
pinfo(P) when node(P) == node() ->
    io:format("~p~n", [erlang:process_info(P)]),
    io:format("----------------------------------------------------~n");
pinfo(P) when is_pid(P) ->
    Info = case rpc:call(node(P), erlang, process_info, [P]) of
        {badrpc, _} -> undefined;
        X -> X
    end,
    io:format("~p~n", [Info]),
    io:format("----------------------------------------------------~n").

%% ----------------------------------------------------
%% 私有函数
%% ----------------------------------------------------

%% 格式化打钱top信息
print_top([]) -> ok;
print_top([H | T]) ->
    io:format("~20w ~24w ~36w ~12w ~12w ~12w~n", H),
    print_top(T).
