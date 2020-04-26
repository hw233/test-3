%%%-----------------------------------
%%% @Module  : pt_57
%%% @Author  : 
%%% @Email   :
%%% @Created : 2011.11
%%% @Description: 副本信息
%%%-----------------------------------
-module(pt_57).
-compile(export_all).
-include("common.hrl").
%%
%%客户端 -> 服务端 ----------------------------
%%

read(57001, <<No:32>>) ->
    {ok, [No]};

read(57002, _Data) ->
    {ok, []};

read(57003, Bin) ->
    <<Len:16, Left/binary>> = Bin,
    List = read_array(Len, Left),
    {ok, [List]};

read(57004, <<Flag:8>>) ->
    {ok, [Flag]};

read(57006, _) ->
    {ok, []};

read(57008, _) ->
    {ok, []};

read(57009, <<Group:16>>) ->
    {ok, [Group]};

read(57011, <<>>) ->
    {ok, []};

read(57013, _) ->
    {ok, []};

read(57101, _) ->
    {ok, []};

read(57102, _) ->
    {ok, []};

read(57103, _) ->
    {ok, []};

read(_Cmd, _Data) ->
    ?ASSERT(false, [_Cmd]).


write(57001, [DunNo, List]) ->
    Len = erlang:length(List),
    Bin = tool:to_binary([<<Id:64, Code:8>> || {Id, Code} <- List, is_integer(Id)]),
    {ok, pt:pack(57001, <<DunNo:32, Len:16, Bin/binary>>)};

write(57002, [State]) ->
    {ok, pt:pack(57002, <<State:8>>)};

write(57003, [CountList]) ->
    List = [<<DunId:32, State:8, Times:16, RewardTimes:16,Pass:8>> || {DunId, State, Times,RewardTimes,Pass} <- CountList],
    Bin = tool:to_binary(List),
    Len = erlang:length(List),
    {ok, pt:pack(57003, <<Len:16, Bin/binary>>)};

write(57004, [Flag, List]) ->
    Len = erlang:length(List),
    Bin = tool:to_binary([<<Id:64, State:8>> || {Id, State} <- List, is_integer(Id)]),
    {ok, pt:pack(57004, <<Flag:8, Len:16, Bin/binary>>)};


write(57005, [No, State]) ->
    {ok, pt:pack(57005, <<No:32, State:8>>)};

write(57006, [No, Time]) ->
    {ok, pt:pack(57006, <<No:32, Time:32>>)};

write(57007, [Lv, Bouts, BoutPoints, Deads, DeadPoints]) ->
    {ok, pt:pack(57007, <<Lv:8, Bouts:16, BoutPoints:32, Deads:16, DeadPoints:32>>)};

write(57008, [State, Quality]) ->
    % Len = erlang:length(List),
    % Bin = tool:to_binary([<<ItemNo:32, Num:16>> || {ItemNo, Num} <- List]),
    {ok, pt:pack(57008, <<State:8, Quality:8>>)};

write(57009, [Group, LeftTime]) ->
    {ok, pt:pack(57009, <<Group:16, LeftTime:16>>)};

write(57010, []) ->
    {ok, pt:pack(57010, <<>>)};

write(57012, []) ->
    {ok, pt:pack(57012, <<>>)};

write(57013, [List]) ->
    Len = erlang:length(List),
    Bin = tool:to_binary([<<ItemNo:32, Num:16, Qua:8, Id:64, Bind:8>> || {ItemNo, Num, Qua, Id, Bind} <- List]),
    {ok, pt:pack(57013, <<Len:16, Bin/binary>>)};

write(57101, [BossNo, MaxHp, CurHp]) ->
    {ok, pt:pack(57101, <<BossNo:32, MaxHp:32, CurHp:32>>)};

write(57102, [Num]) ->
    {ok, pt:pack(57102, <<Num:32>>)};

write(57103, [Damage, List]) ->
    Len = erlang:length(List),
    F = fun({RoleId, Name, Dam}) -> 
        BinName = tool:to_binary(Name),
        Size = byte_size(BinName),
        <<RoleId:64, Size:16, BinName/binary, Dam:32>>
    end,
    BinData = tool:to_binary([F(X) || X <- List]),
    {ok, pt:pack(57103, <<Damage:32, Len:16, BinData/binary>>)};

write(_Cmd, _) ->
    ?ASSERT(false, [_Cmd]).


read_array(1, <<Id:32, _/binary>>) -> [Id];
read_array(Len, <<Id:32, Left/binary>>) ->
    [Id | read_array(Len - 1, Left)].