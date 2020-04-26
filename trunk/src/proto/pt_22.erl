%%%-----------------------------------
%%% @Module  : pt_22
%%% @Author  : liuzhongzheng2012@gmail.com
%%% @Email   :
%%% @Created : 2014.4
%%% @Description: 排行榜
%%%-----------------------------------
-module(pt_22).
-export([read/2, write/2]).
-include("common.hrl").
-include("rank.hrl").
-include("pt_22.hrl").
-include("pt.hrl").


%%
%%客户端 -> 服务端 ----------------------------
%%
%% 玩家榜
%% 女妖榜
%% 装备榜
%% 竞技场榜
read(Proto, <<RankId:16, Page:8>>) when Proto > 22000 andalso Proto < 22010 ->
    {ok, [RankId, Page]};

%% 装备详情
read(?PT_RANK_EQUIP_DETAIL, <<GoodsID:64>>) ->
    {ok, [GoodsID]};

read(_Cmd, _Data) ->
    ?ASSERT(false, {_Cmd}),
    {error, not_match}.



%%
%%服务端 -> 客户端 ----------------------------
%%
%% 排行榜类型对应协议号: 即 1xxx对应 22001, 2xxx对应22002, 类推!

%% 玩家榜
write(PT, [RankId, MyRank, DataCurrent, TotalLen, RankList])
  when PT == ?PT_RANK_ROLE orelse PT == ?PT_RANK_HOME_DEGREE->
    Bin = list_to_binary([<<Rank:16,
                            PlayId:64,
                            ?P_BITSTR(Name),
                            Sex:8,
                            Faction:8,
                            Info:64,
                            VipLv:16>>
                    || #ranker{rank = Rank,
                                  player_id = PlayId,
                                  player_name = Name,
                                  p1 = Sex,
                                  p2 = Faction,
                                  info = Info,
                                  viplv = VipLv} <- RankList]),
    Bin2 = <<(length(RankList)):16, Bin/binary>>,
	
    {ok, pt:pack(PT, <<RankId:16, MyRank:16, DataCurrent:64, TotalLen:16, Bin2/binary>>)};

%% 帮派副本
write(PT, [RankId, MyRank, DataCurrent, TotalLen, RankList])
  when PT == ?PT_RANK_GUILD_DUNGEON  ->
	Bin = list_to_binary([	
						  guild_rank(Rank,PlayId,Name,Sex,Info,VipLv)
							|| #ranker{rank = Rank,
									   player_id = PlayId,
									   player_name = Name,
									   p1 = Sex,
									   p2 = _Faction,
									   info = Info,
									   viplv = VipLv} <- RankList]),
	Bin2 = <<(length(RankList)):16, Bin/binary>>,
	
    {ok, pt:pack(PT, <<RankId:16, MyRank:16, DataCurrent:64, TotalLen:16, Bin2/binary>>)};

%% 女妖榜
write(?PT_RANK_PARTNER, [RankId, MyRank, DataCurrent, TotalLen, RankList]) ->
    Bin = list_to_binary([<<Rank:16,
                          PartnerId:64,
                          ?P_BITSTR(PartnerName),
                          ?P_BITSTR(PlayerName),
                          Info:32,
                          PlayId:64,
                          VipLv:8
                          >>
        || #ranker{rank = Rank,
                         player_id = PlayId,
                         p1 = PartnerId,
                         p2 = PartnerName,
                         player_name = PlayerName,
                         info = Info,
                         viplv = VipLv} <- RankList]),

    Bin2 = <<(length(RankList)):16, Bin/binary>>,
    
    {ok, pt:pack(?PT_RANK_PARTNER, <<RankId:16, MyRank:16, DataCurrent:64, TotalLen:16, Bin2/binary>>)};

%% 装备榜
write(?PT_RANK_EQUIP, [RankId, MyRank, DataCurrent, TotalLen, RankList]) ->
    F = fun(#ranker{ rank = Rank,
                        player_id = PlayId,
                        p1 = GoodsId,
                        p2 = GoodsName,
                        player_name = PlayerName,
                        info = Info,
                        viplv = VipLv,
                        ext = EXT},
            BinAcc) ->
            Quality = ?IF(is_list(EXT), proplists:get_value(quality, EXT, 0), 0),
            << BinAcc/binary,
               Rank:16,
               GoodsId:64,
               ?P_BITSTR(GoodsName),
               Info:32,
               ?P_BITSTR(PlayerName),
               PlayId:64,
               Quality:8,
               VipLv:8
              >>
          end,
    Bin = lists:foldl(F, <<>>, RankList),
    Bin2 = <<(length(RankList)):16, Bin/binary>>,
    
    {ok, pt:pack(?PT_RANK_EQUIP, <<RankId:16, MyRank:16, DataCurrent:64, TotalLen:16, Bin2/binary>>)};

%% 竞技场榜
write(?PT_RANK_ARENA, [RankId, MyRank, DataCurrent, TotalLen, RankList]) ->
    Bin = list_to_binary([<<Rank:16,
                            PlayId:64,
                            ?P_BITSTR(Name),
                            Wins:16,
                            WinRate:32,
                            VipLv:8>>
                    || #ranker{rank = Rank,
                                  player_id = PlayId,
                                  player_name = Name,
                                  info = {Wins, WinRate},
                                  viplv = VipLv} <- RankList]),
    Bin2 = <<(length(RankList)):16, Bin/binary>>,
    
    {ok, pt:pack(?PT_RANK_ARENA, <<RankId:16, MyRank:16, DataCurrent:64, TotalLen:16, Bin2/binary>>)};

%%比武大会3v3
%% 竞技场榜
write(?PT_RANK_ARENA_3v3, [RankId, MyRank, DataCurrent, TotalLen, RankList]) ->
    Bin = list_to_binary([<<Rank:16,
                            PlayId:64,
                            ?P_BITSTR(Name),
                            Wins:16,
                            Lose:16,
                            VipLv:8>>
                    || #ranker{rank = Rank,
                                  player_id = PlayId,
                                  player_name = Name,
                                  info = {Wins, Lose},
                                  viplv = VipLv} <- RankList]),
    Bin2 = <<(length(RankList)):16, Bin/binary>>,
    
    {ok, pt:pack(?PT_RANK_ARENA_3v3, <<RankId:16, MyRank:16, DataCurrent:64, TotalLen:16, Bin2/binary>>)};

%% 通用榜
write(?PT_RANK_COMMON, [RankId, MyRank, DataCurrent, TotalLen, RankList]) ->
    Bin = list_to_binary([<<Rank:16,
                            PlayId:64,
                            ?P_BITSTR(Name),
                            Info:32,
                            ?P_BITSTR(P1),
                            ?P_BITSTR(P2),
                            P3:64,
                            VipLv:32>>
                    || #ranker{rank = Rank,
                               player_id = PlayId,
                               player_name = Name,
                               info = Info,
                               p1 = P1,
                               p2 = P2,
                               p3 = P3,
                               viplv = VipLv} <- RankList]),
    Bin2 = <<(length(RankList)):16, Bin/binary>>,
    
    {ok, pt:pack(?PT_RANK_COMMON, <<RankId:16, MyRank:16, DataCurrent:64, TotalLen:16, Bin2/binary>>)};

%% 坐骑榜
write(?PT_RANK_MOUNT, [RankId, MyRank, DataCurrent, TotalLen, RankList]) ->
    Bin = list_to_binary([<<Rank:16,
                          MountId:64,
                          ?P_BITSTR(MountName),
                          ?P_BITSTR(PlayerName),
                          Info:32,
                          PlayId:64,
                          VipLv:8
                          >>
        || #ranker{rank = Rank,
                         player_id = PlayId,
                         p1 = MountId,
                         p2 = MountName,
                         player_name = PlayerName,
                         info = Info,
                         viplv = VipLv} <- RankList]),

    Bin2 = <<(length(RankList)):16, Bin/binary>>,
    
    {ok, pt:pack(?PT_RANK_MOUNT, <<RankId:16, MyRank:16, DataCurrent:64, TotalLen:16, Bin2/binary>>)};


write(?PT_RANK_EQUIP_DETAIL, [GoodsID]) ->
    {ok, pt:pack(?PT_RANK_EQUIP_DETAIL, <<GoodsID:64>>)};

write(_Cmd, _) ->
    ?ASSERT(false, {_Cmd}),
    {error, not_match}.


guild_rank(Rank,PlayId,Name,Sex,Info,VipLv) ->
	GuildName = mod_guild:get_guild_name_by_playerid(PlayId),
	<<Rank:16,
	  PlayId:64,
	  ?P_BITSTR(Name),
	  Sex:8,	
	  ?P_BITSTR( GuildName ),
	  Info:64,
	  VipLv:8>>
.