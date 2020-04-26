%%%-----------------------------------
%%% @Module  : pt_49
%%% @Author  : LDS
%%% @Email   : 
%%% @Created : 2014.1
%%% @Description: 爬塔
%%%-----------------------------------
-module(pt_49).
-compile(export_all).
-include("common.hrl").
%%
%%客户端 -> 服务端 ----------------------------
%%
read(49001, _Data) ->
    {ok, []};

read(49002, _Data) ->
    {ok, []};

read(49003, <<Type:8, Floor:16>>) ->
    {ok, [Type, Floor]};

read(49004, _Data) ->
    {ok, []};

read(49005, <<Flag:8>>) ->
    {ok, [Flag]};

read(49020, <<>>) ->
	{ok, []};

read(49021, <<Floor:16>>) ->
	{ok, [Floor]};

read(_Cmd, _Data) ->
    ?ASSERT(false, [_Cmd]),
    error.



%%
%%服务端 -> 客户端 ----------------------------
%%

write(49001, [Floor, MaxFloor, LeftTimes, BestFloor,HaveJump]) ->
    {ok, pt:pack(49001, <<Floor:16, MaxFloor:16, LeftTimes:8, BestFloor:16,HaveJump:8>>)};

write(49002, [Floor, BossTimes, MaxBossTimes, BuyTimes, MaxBuyTimes]) ->
    {ok, pt:pack(49002, <<Floor:16, BossTimes:8, MaxBossTimes:8, BuyTimes:8, MaxBuyTimes:8>>)};

% array(
%     GoodsId     u64
%     GoodsNo     u32
%     GoodsNum    u32
%     GoodsQua    u8
%     bind        u8          绑定状态
%     )
write( 49003, [List]) ->
    Len = erlang:length(List),
    BinData = list_to_binary([<<No:32, Num:32>> || { No, Num} <- List]),
    {ok, pt:pack(49003, <<Len:16, BinData/binary>>)};

write(49004, [Flag, Times]) ->
    {ok, pt:pack(49004, <<Flag:8, Times:8>>)};

write(49006, []) ->
    {ok, pt:pack(49006, <<>>)};

write(49007, [List]) ->
    Len = erlang:length(List),
    BinData = list_to_binary([<<Id:64, No:32, Num:32, Qua:8, Bind:8>> || {Id, No, Num, Qua, Bind} <- List]),
    {ok, pt:pack(49007, <<Len:16, BinData/binary>>)};

write(49008, _) ->
    {ok, pt:pack(49008, <<>>)};

write(49020, [Floor, Times, LastTimeRestore]) ->
	{ok, pt:pack(49020, <<Floor:16, Times:16, LastTimeRestore:32>>)};

write(_Cmd, _) ->
    ?ASSERT(false, [_Cmd]),
    error.