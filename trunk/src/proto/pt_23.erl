%%%-----------------------------------
%%% @Module  : mod_offline_arena
%%% @Author  : lds
%%% @Email   :
%%% @Created : 2013.12
%%% @Description: 离线竞技场
%%%-----------------------------------
-module (pt_23).

-include("common.hrl").
-include("record.hrl").
-include("offline_arena.hrl").

-export([write/2, read/2]).


read(23000, _) ->
    {ok, []};

read(23001, _) ->
    {ok, []};

read(23002, _) ->
    {ok, []};

read(23003, _) ->
    {ok, []};

read(23004, _) ->
    {ok, []};

read(23005, _) ->
    {ok, []};

read(23006, <<Group:8>>) ->
    {ok, [Group]};

read(23007, <<Type:8, Id:32>>) ->
    {ok, [Type, Id]};

read(23008, _) ->
    {ok, []};

read(23009, _) ->
    {ok, []};

read(23010, <<RoleId:64, Rank:32>>) ->
    {ok, [RoleId, Rank]};

read(23012, _) ->
    {ok, []};

read(23013, _) ->
    {ok, []};

read(_Cmd, _) ->
    ?ASSERT(false, [_Cmd]),
    error.


write(23000, [Flag]) ->
    {ok, pt:pack(23000, <<Flag:8>>)};

write(23001, [Group, Rank, Max_Chal, Cur_chal, WinStreak, WsNo, RefreshStamp, RwdFlag, ChalCd, ChalTimes, CTno, HisWs, HisGroup, HisRank]) ->
    {ok, pt:pack(23001, <<Group:8, Rank:32, Max_Chal:8, Cur_chal:8, WinStreak:8, WsNo:8, RefreshStamp:32, RwdFlag:8, ChalCd:32, ChalTimes:32, CTno:16, HisWs:16, HisGroup:8, HisRank:32>>)};

write(23002, [BHList]) ->
    F = fun(BH) ->
            BinName = tool:to_binary(BH#battle_history.challenger),
            Len = byte_size(BinName),
            <<(BH#battle_history.timestamp):32, Len:16, BinName/binary, (BH#battle_history.combat_type):8,
                (BH#battle_history.result):8, (BH#battle_history.state):8, (BH#battle_history.rank):32, (BH#battle_history.feat):32,
                (BH#battle_history.group):8, (BH#battle_history.id):64, (BH#battle_history.except):8>>
        end,

    Len1 = erlang:length(BHList),

    BinData = list_to_binary([F(Data) || Data <- BHList, is_record(Data, battle_history)]),
    {ok, pt:pack(23002, <<Len1:16, BinData/binary>>)};

write(23003, [BH]) ->
    BinName = tool:to_binary(BH#battle_history.challenger),
    Len = byte_size(BinName),
    {ok, pt:pack(23003, <<(BH#battle_history.timestamp):32, Len:16, BinName/binary, (BH#battle_history.combat_type):8,
                (BH#battle_history.result):8, (BH#battle_history.state):8, (BH#battle_history.rank):32, (BH#battle_history.feat):32,
                (BH#battle_history.group):8, (BH#battle_history.id):64, (BH#battle_history.except):8>>)};


write(23004, [Cd, Times]) ->
    {ok, pt:pack(23004, <<Cd:32, Times:8>>)};

write(23005, [List]) ->
    F = fun(Info) ->
            BinName = tool:to_binary(Info#offline_arena_role_info.name),
            Len = byte_size(BinName),
            <<(Info#offline_arena_role_info.rank):32, (Info#offline_arena_role_info.id):64, Len:16, BinName/binary,
              (Info#offline_arena_role_info.race):8, (Info#offline_arena_role_info.lv):16, (Info#offline_arena_role_info.faction):8,
              (Info#offline_arena_role_info.battle_power):32, (Info#offline_arena_role_info.vip_lv):8, (Info#offline_arena_role_info.peak_lv):16>>
        end,
    Len = erlang:length(List),
    BinData = list_to_binary([F(Data) || Data <- List]),
    {ok, pt:pack(23005, <<Len:16, BinData/binary>>)};

write(23006, [List]) ->
    F = fun(Info) ->
            BinName = tool:to_binary(Info#offline_arena_role_info.name),
            Len = byte_size(BinName),
            <<(Info#offline_arena_role_info.rank):32, (Info#offline_arena_role_info.id):64, Len:16, BinName/binary,
              (Info#offline_arena_role_info.race):8, (Info#offline_arena_role_info.lv):16, (Info#offline_arena_role_info.faction):8,
              (Info#offline_arena_role_info.battle_power):32, (Info#offline_arena_role_info.vip_lv):8, (Info#offline_arena_role_info.peak_lv):16>>
        end,
    Len = erlang:length(List),
    BinData = list_to_binary([F(Data) || Data <- List]),
    {ok, pt:pack(23006, <<Len:16, BinData/binary>>)};

write(23007, [Type, Flag, Ws, Times]) ->
    {ok, pt:pack(23007, <<Type:8, Flag:8, Ws:8, Times:8>>)};

write(23008, [Flag, Times, TimeStamp]) ->
    {ok, pt:pack(23008, <<Flag:8, Times:8, TimeStamp:32>>)};

write(23009, [Cd]) ->
    {ok, pt:pack(23009, <<Cd:32>>)};

write(23010, [Flag]) ->
    {ok, pt:pack(23010, <<Flag:8>>)};

write(23011, [InivRank, NewInivRank, PasiRank, NewPasiRank]) ->
    {ok, pt:pack(23011, <<InivRank:32, NewInivRank:32, PasiRank:32, NewPasiRank:32>>)};

write(_Cmd, _) ->
    ?ASSERT(false, [_Cmd]),
    error.