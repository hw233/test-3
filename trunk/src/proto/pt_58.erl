%%%-----------------------------------
%%% @Module  : pt_58
%%% @Author  : LDS
%%% @Email   : 
%%% @Created : 2014.2
%%% @Description: 系统活跃度
%%%-----------------------------------
-module(pt_58).
-compile(export_all).
-include("common.hrl").
-include("protocol/pt_58.hrl").
%%
%%客户端 -> 服务端 ----------------------------
%%
read(58001, _Data) ->
    {ok, []};

read(58002, _Data) ->
    {ok, []};

read(58003, <<Index:16>>) ->
    {ok, [Index]};

read(58005, _Data) ->
    {ok, []};

read(?PT_ACT_JINGYAN, _Data) ->
    {ok, []};

read(?PT_ACT_JINGYAN_AWARD, <<No:8,Type:8>>) ->
    {ok, [No,Type]};

read(?PT_ACT_JINGYAN_RESET, _) ->
    {ok, []};

read(_Cmd, _Arg) ->
    ?ASSERT(false, [_Cmd, _Arg]),
    error.

%%
%%服务端 -> 客户端 ----------------------------
%%
write(58001, [List]) ->
    Len = erlang:length(List),
    Bin = tool:to_binary([<<Sys:16, ActTimes:16, CurNum:16, MaxNum:16, State:8>> || {Sys, ActTimes, CurNum, MaxNum, State} <- List]),
    {ok, pt:pack(58001, <<Len:16, Bin/binary>>)};

write(58002, [List]) ->
    Len = erlang:length(List),
    Bin = tool:to_binary([<<Index:16, Id:32, Point:16, State:8>> || {Index, Id, Point, State} <- List]),
    {ok, pt:pack(58002, <<Len:16, Bin/binary>>)};

write(58004, [Sys, TotalNum, CurNum]) ->
    {ok, pt:pack(58004, <<Sys:16, TotalNum:16, CurNum:16>>)};

write(58005, [SysList]) ->
    Len = erlang:length(SysList),
    Bin = << <<Sys:16, State:8, Type:8>> || {Sys, State, Type} <- SysList >>,
    % ?LDS_DEBUG(58005, [SysList, Bin]),
    {ok, pt:pack(58005, <<Len:16, Bin/binary>>)};

write(?PT_ACT_JINGYAN, [SysList]) ->
    Bin = pt:pack_array(SysList, [u8,u16,[u32,u32]]),
    {ok, pt:pack(?PT_ACT_JINGYAN, <<Bin/binary>>)};

write(?PT_ACT_JINGYAN_AWARD, [List,No]) ->
    Bin = pt:pack_array(List,[u8,u8]),
    {ok, pt:pack(?PT_ACT_JINGYAN_AWARD, <<Bin/binary, No:8>>)};

write(?PT_ACT_JINGYAN_RESET, [Flag]) ->
    {ok, pt:pack(?PT_ACT_JINGYAN_RESET, <<Flag:8>>)};

write(_Cmd, _Arg) ->
    ?ASSERT(false, [_Cmd, _Arg]),
    error.