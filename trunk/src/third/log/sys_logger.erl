-module(sys_logger).
-export([write_log/5,
         write_log_for_web/6,
         fix/0]).

-include("global2.hrl").
-include("log2.hrl").

%%获取级别标志
get_level_flag(Level) ->
        {_Level, _Type, _Type2, Flag} = lists:keyfind(Level, 1, get_log_levels()),

        Flag.

%%获取级别类型
get_level_type2(Level) ->
        {_Level, _Type, Type2, _Flag} = lists:keyfind(Level, 1, get_log_levels()),

        Type2.

%%获取类型级别
get_type_level(Type) ->
        {Level, _Type, _Type2, _Flag} = lists:keyfind(Type, 2, get_log_levels()),

        Level.

%%获取日志级别
get_log_level() ->
        ?SYS_LOG_LEVEL.

get_log_levels() ->
        ?SYS_LOG_LEVELS.

%%获取日志服务
get_log_svr_pids() ->
        [nosql:get(log, sys_log_svr)].

%%写日志
write_log(Type, Module, Line, Format, Args) ->
        Level = get_type_level(Type),

        case Level < get_log_level() + 1 of
                true ->
                        Type2    = get_level_type2(Level),
                        Format2  = get_level_flag(Level) ++ "(~p:~p:~p): " ++ Format ++ "~n",
                        Args2    = [self(), Module, Line] ++ Args,

                        Msg = {erlang:localtime(), {Type2, group_leader(), {self(), Format2, Args2}}},

                        ?TRACE_LOG(Msg),

                        Pids = get_log_svr_pids(),

                        lists:foreach(fun(Pid) -> Pid ! {write_log, Msg} end, Pids);
                false ->
                        pass
        end.

write_log_for_web(Env, Type, Module, Line, Format, Args) ->
        {_, ScriptName} = lists:keyfind(script_name, 1, Env),

        write_log(Type, Module, Line, "~s: " ++ Format, lists:append([ScriptName], Args)).

fix() ->
        Pids = get_log_svr_pids(),

        lists:foreach(fun(Pid) -> Pid ! fix end, Pids).