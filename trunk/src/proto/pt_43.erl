-module(pt_43).
-include("common.hrl").
-include("transport.hrl").
-include("protocol/pt_43.hrl").
-include("pvp.hrl").

-export([read/2, write/2]).
-compile(export_all).

read(?PT_CROSS_SERVER, <<Type:8>>) ->
    {ok, [Type]};

read(?PT_PVP_CROSS_PLAYER_RANK, <<Type:8, Page:8>>) ->
    {ok, [Type, Page]};

read(?PT_CROSS_PVP_OTHERS_DATA, <<PlayerId:64>>) ->
    {ok, [PlayerId]};

read(?PT_PVP_3V3_INVITE_TEAMATES, <<ObjPlayerId:64>>) ->
    {ok, [ObjPlayerId]};

read(?PT_MINE_PVP_DATA, <<>>) ->
    {ok, []};

read(?PT_PVP_CROSS_ROOMS, <<Page:8>>) ->
    {ok, [Page]};

read(?PT_PVP_CREATE_ROOM, <<>>) ->
    {ok, []};

read(?PT_APPLY_JOIN_IN_ROOM, <<CaptainId:64>>) ->
    {ok, [CaptainId]};

read(?PT_PVP_QRY_APPLY_LIST, <<>>) ->
    {ok, []};

read(?PT_ALLOW_JOIN_IN_ROOM, <<PlayerId:64, ServerId:32>>) ->
    {ok, [PlayerId, ServerId]};

read(?PT_REJECT_JOIN_IN_ROOM, <<PlayerId:64>>) ->
    {ok, [PlayerId]};

read(?PT_TM_NOTIFY_TEAMATE_OUT_ROOM, <<>>) ->
    {ok, []};

read(?PT_PVP_KICK_OUT_TM, <<ObjPlayerId:64>>) ->
    {ok, [ObjPlayerId]};

read(?PT_PVP_PROMOTE_TEAMATE_FOR_CAPTAIN, <<ObjPlayerId:64>>) ->
    {ok, [ObjPlayerId]};

read(?PT_PVP_HANDLE_PROMOTE_PVP_CAPTAIN, <<Action:8, CaptainId:64>>) ->
    {ok, [Action, CaptainId]};

read(?PT_PVP_CAPTAIN_USE_ZF, <<No:32>>) ->
    {ok, [No]};

read(?PT_PVP_MATCHING, <<Type:8>>) ->
    {ok, [Type]};

read(?PT_PVP_CANCLE_MATCHING, <<Type:8>>) ->
    {ok, [Type]};

read(?PT_PVP_3V3_HANDLE_INVITE, <<Action:8, CaptainId:64>>) ->
    {ok, [Action, CaptainId]};

read(?PT_ROOM_CHAT, <<CaptainId:64, Bin/binary>>) ->
    {ok, [CaptainId, Bin]};

read(?PT_3V3_PVP_GET_DAYREWARD, <<Type:8>>) ->
    {ok, [Type]};

read(?PT_PVP_3V3_INVITE_TEAMATES, <<ObjPlayerId:64>>) ->
    {ok, [ObjPlayerId]};

read(?PT_CLOSE_CROSS_3V3_RESULT, <<Type:8>>) ->
    {ok, [Type]};

read(?PT_PVP_CROSS_GET_ONLINE_RELA_PLAYERS, <<PageSize:8, PageIndex:16>>) ->
    {ok, [PageSize, PageIndex]};

read(?PT_PVP_CROSS_ACCEPT_INVITE, <<CaptainId:64>>) ->
    {ok, [CaptainId]};

read(?PT_PVP_CROSS_REFUSE_INVITE, <<CaptainId:64>>) ->
    {ok, [CaptainId]};

read(?PT_PVP_CROSS_UPDATE_TEAM, <<CaptainId:64>>) ->
    {ok, [CaptainId]};

read(?PT_PVP_CROSS_REMOVE_INVITE_LIMIT, <<CaptainId:64>>) ->
    {ok, [CaptainId]};

read(?PT_PVP_CROSS_PLAYER_PREPARE, <<Type:8>>) ->
    {ok, [Type]};

read(_Cmd, _) ->
    ?ASSERT(false, [_Cmd]),
    not_match.



write(?PT_CROSS_SERVER, [Type]) ->
    Data = <<Type:8>>,
	{ok, pt:pack(?PT_CROSS_SERVER, Data)};

write(?PT_TM_PROMOTE_YOU_FOR_CAPTAIN, [CaptainId]) ->
    Data = <<CaptainId:64>>,
    {ok, pt:pack(?PT_TM_PROMOTE_YOU_FOR_CAPTAIN, Data)};

write(?PT_PVP_PROMOTE_TEAMATE_FOR_CAPTAIN, [RetCode]) ->
    Data = <<RetCode:8>>,
    {ok, pt:pack(?PT_PVP_PROMOTE_TEAMATE_FOR_CAPTAIN, Data)};

write(?PT_PVP_CROSS_PLAYER_RANK,[RankList]) ->
    Len = length(RankList),
    Bin = list_to_binary([<<PlayerId:64, Rank:32,(byte_size(Name)):16,Name/binary,Dan:8,Score:32>> ||
        {PlayerId, Name, _ServerId, Rank, Dan, Score} <-RankList]),
    BinData = <<Len:16,Bin/binary>>,
    {ok, pt:pack(?PT_PVP_CROSS_PLAYER_RANK, BinData)};

write(?PT_PVP_CROSS_ROOMS, [RoomList]) ->
    Len = length(RoomList),
    F = fun(Room, Acc) ->
            CaptainId = Room#room.captain,
            case sm_cross_server:rpc_call(lib_pvp, get_pvp_cross_player_info, [CaptainId]) of
                {ok, null} ->
                    Acc;
                {ok, PvpplyInfo} ->
                    [{CaptainId, PvpplyInfo#pvp_cross_player_data.faction, PvpplyInfo#pvp_cross_player_data.sex, PvpplyInfo#pvp_cross_player_data.race,
                        PvpplyInfo#pvp_cross_player_data.player_name, PvpplyInfo#pvp_cross_player_data.dan, Room#room.counters} | Acc]
            end
        end,
    List = lists:foldl(F, [], RoomList),
    Len = length(List),
    Bin = list_to_binary([<<CaptainId:64, Faction:8, Sex:8, Race:8, (byte_size(PlayerName)):16,PlayerName/binary, Dan:8, Counters:8>> ||
        {CaptainId, Faction, Sex, Race, PlayerName, Dan, Counters} <-List]),
    BinData = <<Len:16,Bin/binary>>,
    {ok, pt:pack(?PT_PVP_CROSS_ROOMS, BinData)};

write(?PT_MINE_PVP_DATA, [PvpPlyData]) ->
    Win = PvpPlyData#pvp_cross_player_data.win,
    Lose = PvpPlyData#pvp_cross_player_data.lose,
    Escape = PvpPlyData#pvp_cross_player_data.escape,
    Dan = PvpPlyData#pvp_cross_player_data.dan,
    Score = PvpPlyData#pvp_cross_player_data.score,
    Rank = PvpPlyData#pvp_cross_player_data.rank,
    Daytimes = PvpPlyData#pvp_cross_player_data.daytimes,
    DayReward = PvpPlyData#pvp_cross_player_data.dayreward,
    Reward = PvpPlyData#pvp_cross_player_data.reward,
    F = fun(Reward, Count) ->
            Sum =
                case Reward of
                    ?ONE_PARTICPATE ->
                        1;
                    ?FIVE_PARTICPATE ->
                        2;
                    ?TEN_PARTICPATE ->
                        4;
                    _ ->
                        0
                end,
            Sum + Count
        end,
    Acc = lists:foldl(F, 0, DayReward),
    case length(Reward) > 0 of
        false ->
            Data = <<Win:32, Lose:32, Escape:32, Dan:8, Score:32, Rank:32, Daytimes:8, Acc:8, 0:8>>,
            {ok, pt:pack(?PT_MINE_PVP_DATA, Data)};

        true ->
            Reward2 = lists:sort(Reward),
            No = lists:last(Reward2),
            Data = <<Win:32, Lose:32, Escape:32, Dan:8, Score:32, Rank:32, Daytimes:8, Acc:8, No:8>>,
            {ok, pt:pack(?PT_MINE_PVP_DATA, Data)}
    end;

	

write(?PT_CROSS_PVP_OTHERS_DATA, [PvpPlyData]) ->
    PlayerId = PvpPlyData#pvp_cross_player_data.player_id,
    Faction = PvpPlyData#pvp_cross_player_data.faction,
    Sex = PvpPlyData#pvp_cross_player_data.sex,
    Race = PvpPlyData#pvp_cross_player_data.race,
    Name = PvpPlyData#pvp_cross_player_data.player_name,
    NameLen = byte_size(Name),
    Win = PvpPlyData#pvp_cross_player_data.win,
    Lose = PvpPlyData#pvp_cross_player_data.lose,
    Escape = PvpPlyData#pvp_cross_player_data.escape,
    ServerId = PvpPlyData#pvp_cross_player_data.server_id,
    Dan = PvpPlyData#pvp_cross_player_data.dan,
    Score = PvpPlyData#pvp_cross_player_data.score,
    Data = <<
        PlayerId:64,
        Faction:8,
        Sex:8,
        Race:8,
        NameLen: 16,
        Name /binary,
        Win:32,
        Lose:32,
        Escape:32,
        ServerId:32,
        Dan:8,
        Score:32
    >>,
    {ok, pt:pack(?PT_CROSS_PVP_OTHERS_DATA, Data)};

write(?PT_PVP_CREATE_ROOM, [Room, List]) ->
    CaptainId = Room#room.captain,
    Troop = Room#room.cur_troop,
    InfoList = pack_member(List),
    Len = length(InfoList),
    Bin = list_to_binary([<<PlayerId:64, (byte_size(PlayerName)):16,PlayerName/binary,
                            Faction:8, Sex:8, Lv:16, Race:8, Weapon:32, BackWear:32,
                            StrenLv:8, Headwear:32, Clothes:32, MagicKey:32, Dan:8>> ||
        {
            PlayerId,
            PlayerName,
            Faction,
            Sex,
            Lv,
            Race,
            Weapon,
            BackWear,
            StrenLv,
            Headwear,
            Clothes,
            MagicKey,
            Dan
        } <-InfoList]),

    Data = <<CaptainId:64, Len:16, Bin/binary, Troop:32>>,
    {ok, pt:pack(?PT_PVP_CREATE_ROOM, Data)};

write(?PT_APPLY_JOIN_IN_ROOM, [RetCode]) ->
    Data = <<RetCode:8>>,
    {ok, pt:pack(?PT_APPLY_JOIN_IN_ROOM, Data)};

write(?PT_PVP_QRY_APPLY_LIST, [ApplyList]) ->
    ApplyCount = length(ApplyList),
    Bin = list_to_binary([<<PlayerId:64, (byte_size(Name)):16, Name/binary, Dan:8, ServerId:32>> ||
        {PlayerId, Name, Dan, ServerId} <-ApplyList]),
    Data = <<ApplyCount:16, Bin/binary>>,
    {ok, pt:pack(?PT_PVP_QRY_APPLY_LIST, Data)};

write(?PT_TM_NOTIFY_TEAMATE_OUT_ROOM, [ObjPlayerId]) ->
    Data = <<ObjPlayerId:64>>,
    {ok, pt:pack(?PT_TM_NOTIFY_TEAMATE_OUT_ROOM, Data)};

write(?PT_PVP_KICK_OUT_TM, [ObjPlayerId]) ->
    Data = <<ObjPlayerId:64>>,
    {ok, pt:pack(?PT_PVP_KICK_OUT_TM, Data)};

%%邀请他人加入队伍
write(?PT_PVP_3V3_INVITE_TEAMATES, [RetCode, ObjPlayerId])->
    Data = <<RetCode:8, ObjPlayerId:64>>,
    {ok, pt:pack(?PT_PVP_3V3_INVITE_TEAMATES, Data)};

write(?PT_PVP_3V3_TEAMATES_GOT_INVITE, [FromPlayerId, FromPlayerName, FromPlayerLv]) ->
    Data = <<FromPlayerId:64, (byte_size(FromPlayerName)):16, FromPlayerName/binary, FromPlayerLv:16>>,
    {ok, pt:pack(?PT_PVP_3V3_TEAMATES_GOT_INVITE, Data)};



%%write(?PT_PLAYER_PVP_DATA, [Type]) ->
%%    Data = <<Type:8>>,
%%    {ok, pt:pack(?PT_CROSS_SERVER, Data)};


write(?PT_READY_CROSS_3V3, [MyselfInfo, OpponentInfo]) ->
	MyselfInfoLen = length(MyselfInfo),	
	F = fun(X) ->
				 {Name, School, Sex, Dan, PartnerNo, Partnerlv} = X,
				 << 
				   (byte_size(Name)):16,
				   Name/binary,
				   School:8,
				   Sex:8,
				   Dan:8,
				   PartnerNo:32,
				   Partnerlv:16         
				   >>
		 end,
	Bin = list_to_binary([ F(X) || X <- MyselfInfo]),

	OpponentInfoLen = length(OpponentInfo), 
	F2 = fun(X) ->
		  {School,Sex} = X,
         
		  << 
			School:8,
            Sex:8
          >>
        end,
	
	Bin2 = list_to_binary([F2(X)|| X <-OpponentInfo]),
	
	BinData = <<MyselfInfoLen:16, Bin/binary, OpponentInfoLen:16, Bin2/binary>>,
    {ok, pt:pack(?PT_READY_CROSS_3V3, BinData)};

write(?PT_CROSS_3V3_RESULT, [Sing, Score, Dan]) ->
    Data = <<Sing:8 , Score:8 , Dan:8>>,
    {ok, pt:pack(?PT_CROSS_3V3_RESULT, Data)};

write(?PT_PVP_NOTIFY_CAPTAIN_CHANGED, [NewLeaderId]) ->
    Data = <<NewLeaderId:64>>,
    {ok, pt:pack(?PT_PVP_NOTIFY_CAPTAIN_CHANGED, Data)};

write(?PT_PVP_NOTIFY_CAPTAIN_RESULT, [Result, PlayerName]) ->
    Data = <<Result:8, (byte_size(PlayerName)):16, PlayerName/binary>>,
    {ok, pt:pack(?PT_PVP_NOTIFY_CAPTAIN_RESULT, Data)};

write(?PT_PVP_CAPTAIN_USE_ZF, [No]) ->
    {ok, pt:pack(?PT_PVP_CAPTAIN_USE_ZF, <<No:32>>)};

write(?PT_PVP_3V3_HANDLE_INVITE, [RetCode, CaptainId]) ->
    Data = <<RetCode:8, CaptainId:64>>,
    {ok, pt:pack(?PT_PVP_3V3_HANDLE_INVITE, Data)};

write(?PT_PVP_NOTIFY_CAPTAIN_INVITE_RESULT, [Result, PlayerName]) ->
    Data = <<Result:8, (byte_size(PlayerName)):16, PlayerName/binary>>,
    {ok, pt:pack(?PT_PVP_NOTIFY_CAPTAIN_INVITE_RESULT, Data)};

write(?PT_PVP_MATCHING, [RetCode]) ->
    Data = <<RetCode:8>>,
    {ok, pt:pack(?PT_PVP_MATCHING, Data)};

write(?PT_REJECT_JOIN_IN_ROOM, [PlayerName]) ->
    Data = <<(byte_size(PlayerName)):16, PlayerName/binary>>,
    {ok, pt:pack(?PT_REJECT_JOIN_IN_ROOM, Data)};

write(?PT_PVP_CANCLE_MATCHING, [RetCode]) ->
    Data = <<RetCode:8>>,
    {ok, pt:pack(?PT_PVP_CANCLE_MATCHING, Data)};

write(?PT_ROOM_CHAT, [Id, Msg, Identify, Name, Race, Sex, ServerId, Dan]) ->
    BinName = pt:string_to_binary(Name),
    BinData = <<Id:64, Msg/binary, Identify:8, BinName/binary, Race:8, Sex:8, ServerId:32, Dan:8>>,
    {ok, pt:pack(?PT_ROOM_CHAT, BinData)};

write(?PT_3V3_PVP_GET_DAYREWARD, [RetCode]) ->
    Data = <<RetCode:64>>,
    {ok, pt:pack(?PT_3V3_PVP_GET_DAYREWARD, Data)};

write(?PT_CLOSE_CROSS_3V3_RESULT, [RetCode]) ->
    Data = <<RetCode:8>>,
    {ok, pt:pack(?PT_CLOSE_CROSS_3V3_RESULT, Data)};

write(?PT_PVP_CROSS_GET_ONLINE_RELA_PLAYERS, [TotalPage, PageIndex, RetList, ListFriend, _ListGuildMb]) ->
    F = fun(PS) ->
            Rela =
                case lists:member(PS, ListFriend) of
                    true -> 1;
                    false -> 2
                end,
            Name = player:get_name(PS),
            PlyDan =
                case sm_cross_server:rpc_call(lib_pvp, query_pvp_3v3_player_dan, [player:id(PS)]) of
                    {ok, null} ->
                        0;
                    {ok, Dan} ->
                        Dan
                end,
            <<
                (player:id(PS)) : 64,
                (player:get_race(PS)) : 8,
                (player:get_sex(PS)) : 8,
                (player:get_faction(PS)) : 8,
                Rela : 8,
                (byte_size(Name)) : 16,
                Name /binary,
                (player:get_lv(PS)) : 16,
                PlyDan : 8
            >>
        end,
    Bin = list_to_binary([F(X) || X <- RetList]),
    Len = length(RetList),
    {ok, pt:pack(?PT_PVP_CROSS_GET_ONLINE_RELA_PLAYERS, <<TotalPage:16, PageIndex:16, Len:16, Bin/binary>>)};

write(?PT_PVP_3V3_INVITE_TEAMATES, [RetCode, ObjPlayerId]) ->
    Data = <<RetCode:8, ObjPlayerId:64>>,
    {ok, pt:pack(?PT_PVP_3V3_INVITE_TEAMATES, Data)};

write(?PT_PVP_3V3_TEAMATES_GOT_INVITE, [FromPlayerId, FromPlayerName, FromPlayerLv]) ->
    Data = <<FromPlayerId:64, (byte_size(FromPlayerName)):16, FromPlayerName/binary, FromPlayerLv:8>>,
    {ok, pt:pack(?PT_PVP_3V3_TEAMATES_GOT_INVITE, Data)};

write(?PT_PVP_CROSS_REFUSE_INVITE, [PlayerName, RetCode]) ->
    Data = <<(byte_size(PlayerName)):16, PlayerName/binary, RetCode:8>>,
    {ok, pt:pack(?PT_PVP_CROSS_REFUSE_INVITE, Data)};

write(?PT_PVP_CROSS_PLAYER_PREPARE, [List]) ->
    PrepareCount = length(List),
    Bin = list_to_binary([<<PlayerId:64,  Action:8>> ||
        {PlayerId, Action} <- List]),
    Data = <<PrepareCount:16, Bin/binary>>,
    {ok, pt:pack(?PT_PVP_CROSS_PLAYER_PREPARE, Data)};

write(?PT_PVP_CROSS_ACCEPT_INVITE, [RetCode]) ->
    Data = <<RetCode:8>>,
    {ok, pt:pack(?PT_PVP_CROSS_ACCEPT_INVITE, Data)};

write(_Cmd, _) ->
    % ?ASSERT(false, [_Cmd]),
    not_match.

pack_member(TeammateList) when is_list(TeammateList) ->
    F = fun({PlayerId, PlayerName, Faction, Sex, Lv, Race, ShowEquips, Dan}, Acc) ->
            [
                {PlayerId, PlayerName, Faction, Sex, Lv, Race,
                    ShowEquips#showing_equip.weapon, ShowEquips#showing_equip.backwear,
                    ShowEquips#showing_equip.suit_no, ShowEquips#showing_equip.headwear,
                    ShowEquips#showing_equip.clothes, ShowEquips#showing_equip.magic_key,
                    Dan} | Acc
            ]
        end,
    lists:foldl(F, [], TeammateList).