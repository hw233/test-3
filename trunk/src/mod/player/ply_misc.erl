%%%--------------------------------------
%%% @Module  : ply_misc
%%% @Author  : zhangwq
%%% @Email   : 
%%% @Created : 2014.4.16
%%% @Description: 玩家杂项相关的接口
%%%--------------------------------------
-module(ply_misc).
-export([
        get_player_misc/0,
        get_player_misc/1,
        update_player_misc/1,
        db_save_player_misc/1,
    
        del_player_misc_from_ets/1
    ]).

-include("common.hrl").
-include("record.hrl").
-include("ets_name.hrl").
-include("player.hrl").


%% @doc 仅限玩家进程内部调用
get_player_misc() ->
    ply_misc:get_player_misc(get(?PDKN_PLAYER_ID)).


%% return null | player_misc 结构体
get_player_misc(PlayerId) ->
    case ets:lookup(?ETS_PLAYER_MISC, PlayerId) of
        [] -> 
            db_load_player_misc(PlayerId);
        [R] ->
            R
    end.


update_player_misc(PlayerMisc) ->
    ?ASSERT(is_record(PlayerMisc, player_misc), PlayerMisc),
    ets:insert(?ETS_PLAYER_MISC, PlayerMisc#player_misc{is_dirty = true}).


db_save_player_misc(PlayerId) ->
    case ets:lookup(?ETS_PLAYER_MISC, PlayerId) of
        [] -> skip;
        [R] ->
            case R#player_misc.is_dirty of
                false -> skip;
                true -> 
                    BuyGoodsNpc_BS = util:term_to_bitstring(R#player_misc.buy_goods_from_npc),
                    BuyGoodsShop_BS = util:term_to_bitstring(R#player_misc.buy_goods_from_shop),
                    BuyGoodsOpShop_BS = util:term_to_bitstring(R#player_misc.buy_goods_from_op_shop),
                    UseGoods_BS = util:term_to_bitstring(R#player_misc.use_goods),
                    GrowFund_BS = util:term_to_bitstring(R#player_misc.grow_fund),
                    Monopoly = util:term_to_bitstring(R#player_misc.monopoly),
                    MijingRecord = util:term_to_bitstring(R#player_misc.mijing_record),
                    HuanjingRecord = util:term_to_bitstring(R#player_misc.huanjing_record),
                    Unlock = util:term_to_bitstring(R#player_misc.unlock),
                    FabaoSpecial = util:term_to_bitstring(R#player_misc.fabao_special),
                    StrengthenInfo = util:term_to_bitstring(R#player_misc.strengthen_info),
					RankDataCurrent = util:term_to_bitstring(R#player_misc.rank_data_current),
                    LvTrain = util:term_to_bitstring(R#player_misc.lv_train),
                    LiangongBag = util:term_to_bitstring(R#player_misc.liangong_bag),

					FieldValues = [{player_id, 				PlayerId}, 
								   {buy_goods_from_npc, 	BuyGoodsNpc_BS}, 
								   {use_goods, 				UseGoods_BS}, 
								   {grow_fund, 				GrowFund_BS},
								   {buy_goods_from_shop, 	BuyGoodsShop_BS}, 
								   {buy_goods_from_op_shop, BuyGoodsOpShop_BS}, 
								   {guild_dungeon_time, 	R#player_misc.guild_dungeon_time}, 
								   {guild_dungeon_id, 		R#player_misc.guild_dungeon_id}, 
								   {guild_war_id, 			R#player_misc.guild_war_id}, 
								   {guild_war_turn, 		R#player_misc.guild_war_turn},
								   {free_stren_cnt, 		R#player_misc.free_stren_cnt}, 
								   {lv_train, 				LvTrain},
								   {reset_time, 			R#player_misc.reset_time}, 
								   {lilian, 				R#player_misc.lilian},
								   {monopoly, 				Monopoly}, 
								   {monopoly_reset_time, 	R#player_misc.monopoly_reset_time}, 
								   {mijing, 				R#player_misc.mijing}, 
								   {huanjing, 				R#player_misc.huanjing},
								   {mijing_record, 			MijingRecord}, 
								   {huanjing_record, 		HuanjingRecord}, 
								   {lockno, 				Unlock}, 
								   {mystery_reset_time, 	R#player_misc.mystery_reset_time},
								   {fabao_special, 			FabaoSpecial},
								   {fabao_displayer, 		R#player_misc.fabao_displayer}, 
								   {fabao_degree, 			R#player_misc.fabao_degree},
								   {strengthen_info,		StrengthenInfo},
								   {create_role_reward, 	R#player_misc.create_role_reward},
								   {recharge_accumulated, 	util:term_to_bitstring(R#player_misc.recharge_accumulated)},
                  				   {dungeon_reward_time, util:term_to_bitstring(R#player_misc.dungeon_reward_time)},
								   {rank_data_current,    RankDataCurrent},
                                    {liangong_bag,    LiangongBag}
								  ],

                    db:replace(PlayerId, player_misc, FieldValues)
            end
    end.


del_player_misc_from_ets(PlayerId) ->
    ets:delete(?ETS_PLAYER_MISC, PlayerId).


%% return null | player_misc结构体
db_load_player_misc(PlayerId) ->
    case db:select_row(player_misc, "buy_goods_from_npc, use_goods, grow_fund , buy_goods_from_shop, buy_goods_from_op_shop,
    guild_dungeon_id, guild_dungeon_time, guild_war_id, guild_war_turn, free_stren_cnt, lv_train, reset_time, lilian, monopoly, monopoly_reset_time, mijing, mijing_record, huanjing, huanjing_record,
    lockno, mystery_reset_time, fabao_special, fabao_displayer, fabao_degree,strengthen_info, create_role_reward, recharge_accumulated, dungeon_reward_time, rank_data_current,
    liangong_bag",
        [{player_id, PlayerId}], [], [1]) of
        [] ->
            PlayerMisc = #player_misc{player_id = PlayerId, free_stren_cnt = 1, lv_train = [1], reset_time = util:unixtime()},
            ets:insert(?ETS_PLAYER_MISC, PlayerMisc),
            update_player_misc(PlayerMisc),
            PlayerMisc;
        [BuyGoodsNpc_BS, UseGoods_BS,GrowFund_BS, BuyGoodsShop_BS, BuyGoodsOpShop_BS, GuildDungeonId,
        GuildDungeonTime, GuildWarId, GuildWarTurn, FreeStrenCnt, LvTrain0, ResetTime, Lilian, Monopoly, MonopolyResetTime, Mijing, MijingRecord, Huanjing, HuanjingRecord,
            Unlock, MysteryResetTime, FabaoSpecial,  FabaoDisplayer, FabaoDegree,StrengthenInfo, CreateRoleReward, RechargeAccumulated_BS,DungeonRewardTime,RankDataCurrent_BS,
            LiangongBat0] ->


            LiangongBag =
                case util:bitstring_to_term(LiangongBat0) of
                    undefined -> [];   % 容错
                    LiangongBat1 when is_list(LiangongBat1) -> LiangongBat1;
                    _Any01 -> ?ASSERT(false, {_Any01, LiangongBat0}), []  % 容错，
                end,


            LvTrain =
                case util:bitstring_to_term(LvTrain0) of
                    undefined -> [];   % 容错
                    LvTrain1 when is_list(LvTrain1) -> LvTrain1;
                    _Any0 -> ?ASSERT(false, {_Any0, LvTrain0}), []  % 容错，
                end,
            BuyGoodsNpc =
                case util:bitstring_to_term(BuyGoodsNpc_BS) of
                    undefined -> [];   % 容错
                    BuyTupList0 when is_list(BuyTupList0) -> BuyTupList0;
                    _Any1 -> ?ASSERT(false, {_Any1, BuyGoodsNpc_BS}), []  % 容错，
                end,

            BuyGoodsShop = 
                case util:bitstring_to_term(BuyGoodsShop_BS) of
                    undefined -> [];   % 容错
                    BuyTupList1 when is_list(BuyTupList1) -> BuyTupList1;
                    _Any2 -> ?ASSERT(false, {_Any2, BuyGoodsShop_BS}), []  % 容错，
                end,

            BuyGoodsOpShop = 
                case util:bitstring_to_term(BuyGoodsOpShop_BS) of
                    undefined -> [];   % 容错
                    BuyTupList2 when is_list(BuyTupList2) -> BuyTupList2;
                    _Any3 -> ?ASSERT(false, {_Any3, BuyGoodsOpShop_BS}), []  % 容错，
                end,

            UseGoods = 
                case util:bitstring_to_term(UseGoods_BS) of
                    undefined -> [];   % 容错
                    UseTupList when is_list(UseTupList) -> UseTupList;
                    _Any4 -> ?ASSERT(false, {_Any4, UseGoods_BS}), []  % 容错，
                end,
			
			GrowFund = 
				case util:bitstring_to_term(GrowFund_BS) of 
                    undefined -> [];   % 容错
                    UseTupList5 when is_list(UseTupList5) -> UseTupList5;
                    _Any5 -> ?ASSERT(false, {_Any5, GrowFund_BS}), []  % 容错，
                end,
			
			RechargeAccumulated = 
				case util:bitstring_to_term(RechargeAccumulated_BS) of
                    undefined -> [];   % 容错
                    UseTupList6 when is_list(UseTupList6) -> UseTupList6;
                    _Any6 -> ?ASSERT(false, {_Any6, RechargeAccumulated_BS}), []  % 容错，
                end,

			RankDataCurrent =
				case util:bitstring_to_term(RankDataCurrent_BS) of
                    undefined -> [];   % 容错
                    UseTupList7 when is_list(UseTupList7) -> UseTupList7;
                    _Any7 -> ?ASSERT(false, {_Any7, RankDataCurrent_BS}), []  % 容错，
                end,


            PlayerMisc = #player_misc{
                player_id = PlayerId,
                buy_goods_from_npc = BuyGoodsNpc,
                buy_goods_from_shop = BuyGoodsShop,
                buy_goods_from_op_shop = BuyGoodsOpShop,
                use_goods = UseGoods,
				grow_fund = GrowFund,
                guild_dungeon_id = GuildDungeonId,
                guild_dungeon_time = GuildDungeonTime,
                guild_war_id = GuildWarId,
                guild_war_turn = GuildWarTurn,
                free_stren_cnt = FreeStrenCnt,
                lv_train = LvTrain,
                reset_time = ResetTime,
                lilian = Lilian,
                monopoly = util:bitstring_to_term(Monopoly),
                monopoly_reset_time = MonopolyResetTime,
                mijing = Mijing,
                mijing_record = util:bitstring_to_term(MijingRecord),
                huanjing = Huanjing,
                huanjing_record = util:bitstring_to_term(HuanjingRecord),
                unlock = util:bitstring_to_term(Unlock),
                mystery_reset_time = MysteryResetTime,
                fabao_special  =  util:bitstring_to_term(FabaoSpecial),
                fabao_displayer = FabaoDisplayer,
                fabao_degree =FabaoDegree,
                strengthen_info = util:bitstring_to_term(StrengthenInfo),
				create_role_reward = CreateRoleReward,
				recharge_accumulated = RechargeAccumulated,
                dungeon_reward_time = util:bitstring_to_term(DungeonRewardTime),
				rank_data_current = RankDataCurrent,
                liangong_bag = LiangongBag
            },

            ets:insert(?ETS_PLAYER_MISC, PlayerMisc),
            PlayerMisc
    end.