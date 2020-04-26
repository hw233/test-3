%%%-----------------------------------
%%% @Module  : pt_62
%%% @Author  : LDS
%%% @Email   : 
%%% @Created : 2014.1
%%% @Description: 爬塔
%%%-----------------------------------
-module(pt_62).
-compile(export_all).
-include("common.hrl").
%%
%%客户端 -> 服务端 ----------------------------
%%
read(62001, _Data) ->
    {ok, []};

read(62002, _Data) ->
    {ok, []};

read(62003, <<TowerNo:32, Floor:16, State>>) ->
    {ok, [TowerNo, Floor, State]};

read(62004, _Data) ->
    {ok, []};

read(62005, <<Flag:8>>) ->
    {ok, [Flag]};

read(_Cmd, _Data) ->
    ?ASSERT(false, [_Cmd]),
    error.



%%
%%服务端 -> 客户端 ----------------------------
%%

write(62001, [TowerNo, Floor, MaxFloor, LeftTimes, BestFloor]) ->
    {ok, pt:pack(62001, <<TowerNo:32, Floor:16, MaxFloor:16, LeftTimes:8, BestFloor:16>>)};

write(62002, [TowerNo, Floor, BossTimes, MaxBossTimes, BuyTimes, MaxBuyTimes]) ->
    {ok, pt:pack(62002, <<TowerNo:32, Floor:16, BossTimes:8, MaxBossTimes:8, BuyTimes:8, MaxBuyTimes:8>>)};

write(62003, [Flag]) ->
    {ok, pt:pack(62003, <<Flag:8>>)};

write(62004, [Flag, Times]) ->
    {ok, pt:pack(62004, <<Flag:8, Times:8>>)};

write(62006, []) ->
    {ok, pt:pack(62006, <<>>)};

write(62007, [List]) ->
    Len = erlang:length(List),
    BinData = list_to_binary([<<Id:64, No:32, Num:32, Qua:8, Bind:8>> || {Id, No, Num, Qua, Bind} <- List]),
    {ok, pt:pack(62007, <<Len:16, BinData/binary>>)};

write(62008, _) ->
    {ok, pt:pack(62008, <<>>)};

write(_Cmd, _) ->
    ?ASSERT(false, [_Cmd]),
    error.