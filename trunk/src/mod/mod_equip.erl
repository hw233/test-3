%%%--------------------------------------
%%% @Module  : mod_equip
%%% @Author  : zhangwq
%%% @Email   :
%%% @Created : 2013.6.13
%%% @Description : 玩家的装备栏
%%%
%%%--------------------------------------
-module(mod_equip).

-include("debug.hrl").
-include("inventory.hrl").
-include("goods.hrl").
-include("record.hrl").
-include("prompt_msg_code.hrl").
-include("record/goods_record.hrl").
-include("abbreviate.hrl").
-include("obj_info_code.hrl").
-include("log.hrl").
-include("equip.hrl").
-include("num_limits.hrl").
-include("sys_code.hrl").

-export([
        build_player_showing_equips/1,
        build_partner_showing_equips/2,
        get_player_equip_by_pos/2,
        get_partner_equip_by_pos/3,
		puton_equip/3,
        puton_equip/4,
        takeoff_equip/3,
        takeoff_equip/4,
        compose_goods/4,
        goods_smelt/2,
        change_goods/3,
        equip_decompose/2,
        open_gemstone_hole/3,
        inlay_gemstone/4,
        unload_gemstone/4,
        stren_trs/3,
        upgrade_quality/2,
        upgrade_lv/2,
        recast/3,

        recast_new/3,
        recast_new1/4,

        refine/4,
		
		eff_refresh/3,

        notify_achi/1,

        equip_build/3, %装备打造

        equip_transmogrify/4, %装备幻化
        equip_transmogrify_save/2,

        get_player_equip_gem_list/1, % 获取穿在身上的装备的宝石编号列表
        get_partner_equip_gem_list/2, % 获取宠物宝石
        is_equip_put_on/2,
        is_equip_put_on_par/2,
        get_magic_key/1,            % 获取穿上的法宝对象
        tst_add_magic_key_skill/2,
        decide_player_suit_no/1,    % 获取玩家当前符合的套装，没有则返回0
        get_player_equip_list/1,    % 获取玩家的装备栏的物品列表
        get_partner_equip_list/2    % 获取宠物的装备栏的物品列表
		]
	).



build_player_showing_equips(PlayerId) ->
    #showing_equip{
        weapon = case get_player_equip_by_pos(PlayerId, ?EQP_POS_WEAPON) of null -> ?INVALID_NO; Goods -> lib_goods:get_no(Goods) end,
        headwear = case get_player_equip_by_pos(PlayerId, ?EQP_POS_HEADWEAR) of null -> ?INVALID_NO; Goods -> lib_goods:get_no(Goods) end,
        clothes = case get_player_equip_by_pos(PlayerId, ?EQP_POS_CLOTHES) of null -> ?INVALID_NO; Goods -> lib_goods:get_no(Goods) end,
        backwear = case get_player_equip_by_pos(PlayerId, ?EQP_POS_BACKWEAR) of null -> ?INVALID_NO; Goods -> lib_goods:get_no(Goods) end,
        magic_key = case get_player_equip_by_pos(PlayerId, ?EQP_POS_MAGIC_KEY) of null -> ?INVALID_NO; Goods -> lib_goods:get_no(Goods) end
        }.


build_partner_showing_equips(PlayerId, PartnerId) ->
    #showing_equip{  %% 这里有待根据策划需求调整
        weapon = case get_partner_equip_by_pos(PlayerId, PartnerId, ?EQP_POS_WEAPON) of null -> ?INVALID_NO; Goods -> lib_goods:get_no(Goods) end,
        headwear = case get_partner_equip_by_pos(PlayerId, PartnerId, ?EQP_POS_HEADWEAR) of null -> ?INVALID_NO; Goods -> lib_goods:get_no(Goods) end,
        clothes = case get_partner_equip_by_pos(PlayerId, PartnerId, ?PEQP_POS_SKIN) of null -> ?INVALID_NO; Goods -> lib_goods:get_no(Goods) end,
        backwear = case get_partner_equip_by_pos(PlayerId, PartnerId, ?EQP_POS_BACKWEAR) of null -> ?INVALID_NO; Goods -> lib_goods:get_no(Goods) end
    }.

%% 玩家穿装备
%% @return {fail Reason} | ok
puton_equip(for_player, PS, GoodsId) ->
    case check_player_puton_equip(PS, GoodsId) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, Goods} ->
            do_player_puton_equip(PS, Goods)
    end.

%%  武将穿装备
%% @para: PartnerId => 武将唯一id
%% @return {fail Reason} | ok
puton_equip(for_partner, PS, PartnerId, GoodsId) ->
    case check_partner_puton_equip(PS, PartnerId, GoodsId) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, Goods} ->
            do_partner_puton_equip(PS, PartnerId, Goods)
    end.


check_player_puton_equip(PS, GoodsId) ->
    try check_player_puton_equip__(PS, GoodsId) of
        {ok, Goods} ->
            {ok, Goods}
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.


%% @return: {ok, Goods} | throw失败原因（由上层去catch）
check_player_puton_equip__(PS, GoodsId) ->
    PlayerId = player:get_id(PS),
    case mod_inv:get_bag_goods_by_id(PlayerId, GoodsId, ?LOC_BAG_EQ) of
        null ->
            throw(?PM_GOODS_NOT_EXISTS);
        Goods ->
            ?ASSERT(lib_goods:get_owner_id(Goods) == PlayerId),

            % 物品是否可装备？
            ?Ifc (not lib_goods:is_can_equiped(Goods))
                throw(?PM_GOODS_CANT_EQUIPED)
            ?End,

            lib_inv:common_check_use_goods(PS, Goods),

            ?Ifc (lib_goods:get_type(Goods) =/= ?GOODS_T_EQUIP)
                throw(?PM_PARA_ERROR)
            ?End,

            ?Ifc (lib_goods:is_magic_key(Goods) andalso player:get_contri(PS) < lib_goods:get_contri_need_when_puton(Goods))
                throw(?PM_ROLE_CONTRI_LIMIT)
            ?End,

            % 判断是否在有效期
            ?Ifc (lib_goods:is_in_timekeeping(Goods) andalso lib_goods:is_expired(Goods))
                throw(?PM_GOODS_INVALID)
            ?End,

            ?Ifc (lib_goods:get_faction(Goods) =/= 0 andalso lib_goods:get_faction(Goods) =/= player:get_faction(PS))
                throw(?PM_FACTION_LIMIT)
            ?End,

            % TODO：
            % 其他条件判断
            % 。。。

            {ok, Goods}
    end.





check_partner_puton_equip(PS, PartnerId, GoodsId) ->
    PlayerId = player:get_id(PS),
    case mod_inv:get_bag_goods_by_id(PlayerId, GoodsId, ?LOC_BAG_EQ) of
        null ->
            {fail, ?PM_GOODS_NOT_EXISTS};
        Goods ->
            %case lib_goods:get_type(Goods) =:= ?GOODS_T_PAR_EQUIP of
            %    false -> {fail, ?PM_PARA_ERROR};
            %    true ->

                    case lib_partner:get_partner(PartnerId) of
                        null -> {fail, ?PM_PAR_NOT_EXISTS};
                        Partner ->
                            % GoodsType = lib_goods:get_type(Goods),
                            GoodsLv = lib_goods:get_lv(Goods),
                            ?DEBUG_MSG("GoodsLv = ~p",[GoodsLv]),
                            ParLv = lib_partner:get_lv(Partner),

                            case (lib_goods:is_in_timekeeping(Goods) andalso lib_goods:is_expired(Goods)) of
                                true ->
                                    {fail, ?PM_GOODS_INVALID};
                                false ->

                                    if
                                        % 等级不够
                                        ParLv < GoodsLv ->
                                            {fail, ?PM_PAR_LV_LIMIT};
                                        %GoodsType =/= ?GOODS_T_PAR_EQUIP ->
                                        %    {fail, ?PM_GOODS_CANT_USE_ON_PARTNER};
                                        true ->
                                            {ok, Goods}
                                    end
                            end
                    end
           % end
    end.

%return ok
do_player_puton_equip(PS, Goods1) ->
    % 需要装备在玩家身上的位置
    Goods = mod_inv:extra_handle_for_timging_goods_when_use_it(Goods1),
    EquipPos = lib_goods:get_equip_pos(Goods),

    ShowEquips = player:get_showing_equips(PS),
    lib_inv:notify_cli_goods_destroyed(player:id(PS), lib_goods:get_id(Goods), ?LOC_BAG_EQ),
    case get_player_equip_by_pos(PS#player_status.id, EquipPos) of
        null ->
            mod_inv:remove_goods_from_bag(player:id(PS), Goods),
            {ok, NewGoods, Change} = add_player_equip_change_attr(PS, Goods, EquipPos),
            ShowEquips1 =
                case EquipPos of
                    ?EQP_POS_WEAPON ->
                        lib_scene:notify_int_info_change_to_aoi(player, player:get_id(PS), [{?OI_CODE_WEAPON, lib_goods:get_no(Goods)}]),
                        ShowEquips#showing_equip{weapon = lib_goods:get_no(Goods)};
                    ?EQP_POS_HEADWEAR ->
                        case ply_setting:is_headwear_hide(player:id(PS)) of
                            true -> skip;
                            false ->
                                lib_scene:notify_int_info_change_to_aoi(player, player:get_id(PS), [{?OI_CODE_HEADWEAR, lib_goods:get_no(Goods)}])
                        end,
                        ShowEquips#showing_equip{headwear = lib_goods:get_no(Goods)};
                    ?EQP_POS_CLOTHES ->
                        case ply_setting:is_clothes_hide(player:id(PS)) of
                            true -> skip;
                            false ->
                                lib_scene:notify_int_info_change_to_aoi(player, player:get_id(PS), [{?OI_CODE_CLOTHES, lib_goods:get_no(Goods)}])
                        end,
                        ShowEquips#showing_equip{clothes = lib_goods:get_no(Goods)};
                    ?EQP_POS_BACKWEAR ->
                        case ply_setting:is_backwear_hide(player:id(PS)) of
                            true -> skip;
                            false ->
                                lib_scene:notify_int_info_change_to_aoi(player, player:get_id(PS), [{?OI_CODE_BACKWEAR, lib_goods:get_no(Goods)}])
                        end,
                        ShowEquips#showing_equip{backwear = lib_goods:get_no(Goods)};
                    ?EQP_POS_MAGIC_KEY ->
                        lib_scene:notify_int_info_change_to_aoi(player, player:get_id(PS), [{?OI_CODE_MAGIC_KEY, lib_goods:get_no(Goods)}]),
                        ShowEquips#showing_equip{magic_key = lib_goods:get_no(Goods)};
                    _Any -> ShowEquips
                end,

            player:set_showing_equips(PS, ShowEquips1),
            notify_achi(PS),
            mod_rank:equip_battle_power(NewGoods),
            {ok, NewGoods, Change};
        _OldEquipingGoods ->
            mod_inv:remove_goods_from_bag(player:id(PS), Goods),
            %% 卸下要装备位置的原装备
            takeoff_equip(for_player, PS, EquipPos, false),
            {ok, NewGoods, Change} = add_player_equip_change_attr(PS, Goods, EquipPos),
            lib_inv:notify_cli_goods_destroyed(player:id(PS), lib_goods:get_id(_OldEquipingGoods), ?LOC_PLAYER_EQP),

            ShowEquips1 =
                case EquipPos of
                    ?EQP_POS_WEAPON ->
                        lib_scene:notify_int_info_change_to_aoi(player, player:get_id(PS), [{?OI_CODE_WEAPON, lib_goods:get_no(Goods)}]),
                        ShowEquips#showing_equip{weapon = lib_goods:get_no(Goods)};
                    ?EQP_POS_HEADWEAR ->
                        case ply_setting:is_headwear_hide(player:id(PS)) of
                            true -> skip;
                            false ->
                                lib_scene:notify_int_info_change_to_aoi(player, player:get_id(PS), [{?OI_CODE_HEADWEAR, lib_goods:get_no(Goods)}])
                        end,
                        ShowEquips#showing_equip{headwear = lib_goods:get_no(Goods)};
                    ?EQP_POS_CLOTHES ->
                        case ply_setting:is_clothes_hide(player:id(PS)) of
                            true -> skip;
                            false ->
                                lib_scene:notify_int_info_change_to_aoi(player, player:get_id(PS), [{?OI_CODE_CLOTHES, lib_goods:get_no(Goods)}])
                        end,
                        ShowEquips#showing_equip{clothes = lib_goods:get_no(Goods)};
                    ?EQP_POS_BACKWEAR ->
                        case ply_setting:is_backwear_hide(player:id(PS)) of
                            true -> skip;
                            false ->
                                lib_scene:notify_int_info_change_to_aoi(player, player:get_id(PS), [{?OI_CODE_BACKWEAR, lib_goods:get_no(Goods)}])
                        end,
                        ShowEquips#showing_equip{backwear = lib_goods:get_no(Goods)};
                    ?EQP_POS_MAGIC_KEY ->
                        lib_scene:notify_int_info_change_to_aoi(player, player:get_id(PS), [{?OI_CODE_MAGIC_KEY, lib_goods:get_no(Goods)}]),
                        ShowEquips#showing_equip{magic_key = lib_goods:get_no(Goods)};
                    _Any -> ShowEquips
                end,

            player:set_showing_equips(PS, ShowEquips1),
            notify_achi(PS),
            mod_rank:equip_battle_power(NewGoods),
            {ok, NewGoods, Change}
    end.

%return ok
do_partner_puton_equip(PS, PartnerId, Goods1) ->
    PlayerId = player:id(PS),
    % 需要装备在宠物身上的位置
    Goods = mod_inv:extra_handle_for_timging_goods_when_use_it(Goods1),
    EquipPos = lib_goods:get_equip_pos(Goods),
    lib_inv:notify_cli_goods_destroyed(player:id(PS), lib_goods:get_id(Goods), ?LOC_BAG_EQ),
    case get_partner_equip_by_pos(PlayerId, PartnerId, EquipPos) of
        null ->
            mod_inv:remove_goods_from_bag(PlayerId, Goods),
            {ok, NewGoods, Change} = add_partner_equip_change_attr(PS, PartnerId, Goods, EquipPos),
            {ok, NewGoods, Change};
        _OldEquipingGoods ->
            %% 卸下要装备位置的原装备
            mod_inv:remove_goods_from_bag(PlayerId, Goods),
            takeoff_equip(for_partner, PS, PartnerId, EquipPos, false),
            {ok, NewGoods, Change} = add_partner_equip_change_attr(PS, PartnerId, Goods, EquipPos),
            lib_inv:notify_cli_goods_destroyed(player:id(PS), lib_goods:get_id(_OldEquipingGoods), ?LOC_PARTNER_EQP),
            {ok, NewGoods, Change}
    end.

%% return {ok, GoodsId, Slot} 所卸下的物品id 和 所在的格子 | {fail, Reason}
takeoff_equip(for_player, PS, EquipPos) ->
    takeoff_equip(for_player, PS, EquipPos, true).

takeoff_equip(for_player, PS, EquipPos, RecountNow) when is_boolean(RecountNow) ->
    case mod_inv:is_bag_eq_full(player:get_id(PS)) of
        true -> {fail, ?PM_EQ_BAG_FULL};
        false ->
            Inv = mod_inv:get_inventory(player:get_id(PS)),
            case get_player_equip_by_pos(player:get_id(PS), EquipPos) of
                null ->
                    {fail, ?PM_GOODS_NOT_EXISTS};
                EquipingGoods ->
                    GemIdList = lib_goods:get_gem_id_list(EquipingGoods),
                    NewPlayerEqGoodsList = Inv#inv.player_eq_goods -- [EquipingGoods#goods.id],
                    NewPlayerEqGoodsList1 = NewPlayerEqGoodsList -- GemIdList,
                    mod_inv:update_inventory_to_ets(Inv#inv{player_eq_goods = NewPlayerEqGoodsList1}),

                    %% 改变宝石位置
                    F = fun(Id) ->
                        case mod_inv:get_goods_from_ets(Id) of
                            null ->
                                ?ASSERT(false, Id),
                                skip;
                            GemGoods ->
                                GemGoods1 = lib_goods:set_location(GemGoods, ?LOC_BAG_EQ),
                                GemGoods2 = lib_goods:set_dirty(GemGoods1, true),                
                                mod_inv:update_goods_to_ets(GemGoods2)
                        end
                    end,
                    [F(X) || X <- GemIdList],
    
                    %% 把卸下的装备放进背包
                    NewSlot = mod_inv:find_first_empty_slot(player:get_id(PS), ?LOC_BAG_EQ),
                    {ok, Slot} = mod_inv:add_goods_to_bag(player:get_id(PS), lib_goods:set_slot(EquipingGoods, NewSlot), [?LOG_SKIP]),
                    %% 改变相关属性
                    case RecountNow of
                        true ->
                            SuitNo = decide_player_suit_no(player:get_id(PS)),
                            player:set_suit_no(PS, SuitNo),
                            case player:get_suit_no(PS) =:= SuitNo of
                                true -> skip;
                                false -> lib_scene:notify_int_info_change_to_aoi(player, player:get_id(PS), [{?OI_CODE_STREN_LV, SuitNo}])
                            end,
                            ply_attr:recount_equip_add_and_total_attrs(PS);
                        false -> skip
                    end,

                    ShowEquips = player:get_showing_equips(PS),
                    ShowEquips1 =
                        case EquipPos of
                            ?EQP_POS_WEAPON ->
                                lib_scene:notify_int_info_change_to_aoi(player, player:get_id(PS), [{?OI_CODE_WEAPON, ?INVALID_NO}]),
                                ShowEquips#showing_equip{weapon = ?INVALID_NO};
                            ?EQP_POS_HEADWEAR ->
                                case ply_setting:is_headwear_hide(player:id(PS)) of
                                    true -> skip;
                                    false ->
                                        lib_scene:notify_int_info_change_to_aoi(player, player:get_id(PS), [{?OI_CODE_HEADWEAR, ?INVALID_NO}])
                                end,
                                ShowEquips#showing_equip{headwear = ?INVALID_NO};
                            ?EQP_POS_CLOTHES ->
                                case ply_setting:is_clothes_hide(player:id(PS)) of
                                    true -> skip;
                                    false ->
                                        lib_scene:notify_int_info_change_to_aoi(player, player:get_id(PS), [{?OI_CODE_CLOTHES, ?INVALID_NO}])
                                end,
                                ShowEquips#showing_equip{clothes = ?INVALID_NO};
                            ?EQP_POS_BACKWEAR ->
                                case ply_setting:is_backwear_hide(player:id(PS)) of
                                    true -> skip;
                                    false ->
                                        lib_scene:notify_int_info_change_to_aoi(player, player:get_id(PS), [{?OI_CODE_BACKWEAR, ?INVALID_NO}])
                                end,
                                ShowEquips#showing_equip{backwear = ?INVALID_NO};
                            ?EQP_POS_MAGIC_KEY ->
                                lib_scene:notify_int_info_change_to_aoi(player, player:get_id(PS), [{?OI_CODE_MAGIC_KEY, ?INVALID_NO}]),
                                ShowEquips#showing_equip{magic_key = ?INVALID_NO};
                            _Any -> ShowEquips
                        end,

                    player:set_showing_equips(PS, ShowEquips1),
                    notify_achi(PS),
                    {ok, EquipingGoods#goods.id, Slot}
            end
    end;

%% return {ok, GoodsId, Slot} 所卸下的物品id 和 所在的格子 | {fail, Reason}
%% 玩家操作专用接口
takeoff_equip(for_partner, PS, PartnerId, EquipPos) when is_integer(EquipPos) ->
    takeoff_equip(for_partner, PS, PartnerId, EquipPos, true);

%% 程序操作强制卸下装备：如女妖放生时，强制卸下身上的装备
takeoff_equip(for_partner, PlayerId, _PartnerId, EquipingGoods) ->
    Inv = mod_inv:get_inventory(PlayerId),
    NewPartnerEqGoodsList = Inv#inv.partner_eq_goods -- [EquipingGoods#goods.id],
    mod_inv:update_inventory_to_ets(Inv#inv{partner_eq_goods = NewPartnerEqGoodsList}),
    %% 把卸下的装备放进背包
    Location = lib_goods:decide_bag_location(EquipingGoods),
    mod_inv:smart_add_goods(PlayerId, lib_goods:set_location(EquipingGoods, Location)).
    

takeoff_equip(for_partner, PS, PartnerId, EquipPos, RecountNow) ->
    PlayerId = player:id(PS),
    case mod_inv:is_bag_eq_full(PlayerId) of
        true -> {fail, ?PM_EQ_BAG_FULL};
        false ->
            Inv = mod_inv:get_inventory(PlayerId),

            case get_partner_equip_by_pos(PlayerId, PartnerId, EquipPos) of
                null ->
                    {fail, ?PM_GOODS_NOT_EXISTS};
                EquipingGoods ->
                    GemIdList = lib_goods:get_gem_id_list(EquipingGoods),
                    %% 改变宝石位置
                    F = fun(Id) ->
                        case mod_inv:get_goods_from_ets(Id) of
                            null ->
                                ?ASSERT(false, Id),
                                skip;
                            GemGoods ->
                                GemGoods1 = lib_goods:set_location(GemGoods, ?LOC_BAG_EQ),
                                GemGoods2 = lib_goods:set_dirty(GemGoods1, true),                
                                mod_inv:update_goods_to_ets(GemGoods2)
                        end
                    end,
                    [F(X) || X <- GemIdList],

                    NewPartnerEqGoodsList = Inv#inv.partner_eq_goods -- [EquipingGoods#goods.id],
                    NewPartnerEqGoodsList1 = NewPartnerEqGoodsList -- GemIdList,
                    mod_inv:update_inventory_to_ets(Inv#inv{partner_eq_goods = NewPartnerEqGoodsList1}),
                    %% 把卸下的装备放进背包
                    NewSlot = mod_inv:find_first_empty_slot(player:get_id(PS), ?LOC_BAG_EQ),
                    {ok, Slot} = mod_inv:add_goods_to_bag(PlayerId, lib_goods:set_slot(EquipingGoods, NewSlot), [?LOG_SKIP]),
                    %% 改变相关属性
                    Partner =
                        case RecountNow of
                            true ->
                                lib_partner:recount_equip_add_and_total_attrs(PlayerId, PartnerId);
                            false ->
                                lib_partner:get_partner(PartnerId)
                        end,

                    ShowEquips = lib_partner:get_showing_equips(Partner),
                    PartnerLatest =
                        case EquipPos of
                            ?PEQP_POS_SKIN ->
                                ShowEquips1 = ShowEquips#showing_equip{clothes = ?INVALID_NO},
                                TPartner = lib_partner:set_showing_equips(Partner, ShowEquips1),
                                case lib_partner:is_follow_partner(TPartner) of
                                    false -> skip;
                                    true -> lib_partner:notify_main_partner_info_change_to_AOI(PS, TPartner)
                                end,
                                lib_partner:notify_cli_info_change(TPartner, [{?OI_CODE_PAR_CLOTHES, ?INVALID_NO}]),
                                TPartner;
                            ?PEQP_POS_YAODAN -> %% 有待根据需求修正
                                ShowEquips1 = ShowEquips#showing_equip{headwear = ?INVALID_NO},
                                lib_partner:set_showing_equips(Partner, ShowEquips1);
                            ?PEQP_POS_SEAL ->
                                ShowEquips1 = ShowEquips#showing_equip{backwear = ?INVALID_NO},
                                lib_partner:set_showing_equips(Partner, ShowEquips1);
                            _Any -> Partner
                        end,

                    mod_partner:update_partner_to_ets(PartnerLatest),
                    case RecountNow of
                        true ->
                            case lib_partner:is_fighting(PartnerLatest) of
                                true -> ply_attr:recount_battle_power(PS);
                                false -> skip
                            end;
                        false -> skip
                    end,
                    {ok, EquipingGoods#goods.id, Slot}
            end
    end.


%% 获取玩家当前拥有的套装强化等级，如果没有达到则返回 0
decide_player_suit_no(PlayerId) ->
    F = fun(EquipPos, Acc) ->
        case lists:keyfind(EquipPos, #goods.slot, get_player_equip_list(PlayerId)) of
            false ->
                Acc;
            Goods ->
                [Goods | Acc]
        end
    end,
    NeedList = [?EQP_POS_NECKLACE, ?EQP_POS_BRACER, ?EQP_POS_WEAPON, ?EQP_POS_BARDE, ?EQP_POS_WAISTBAND, ?EQP_POS_SHOES],
    RetList = lists:foldl(F, [], NeedList),
    case length(RetList) < length(NeedList) of
        true ->
            ?INVALID_NO;
        false ->
            F1 = fun(Goods, Lv) ->
                TLv = lib_goods:get_stren_lv(Goods),
                case TLv < Lv of
                    true -> TLv;
                    false -> Lv
                end
            end,
            MinStrenLv = lists:foldl(F1, ?MAX_U8, RetList),
            decide_suit_no(MinStrenLv)
    end.

decide_suit_no(MinStrenLv) ->
    [H | T] = data_equip_suit:get_all_lv(),
    case MinStrenLv < H of
        true -> ?INVALID_NO;
        false -> decide_suit_no(MinStrenLv, [H | T])
    end.

decide_suit_no(_StrenLv, []) ->
    case data_equip_suit:get_all_lv() of
        [] -> ?INVALID_NO;
        List -> lists:last(List)
    end;
decide_suit_no(StrenLv, [H | T]) ->
    case T =:= [] of
        true ->
            case StrenLv >= H of
                true -> H;
                false -> ?INVALID_NO
            end;
        false ->
            [H1 | _] = T,
            case StrenLv >= H andalso StrenLv < H1 of
                true -> H;
                false -> decide_suit_no(StrenLv, T)
            end
    end.

%% return Goods | null
get_magic_key(PlayerId) ->
    case mod_inv:get_inventory(PlayerId) of
        null ->
            null;
        Inv ->
            GoodsList = mod_inv:get_goods_list_by_id_list(Inv#inv.player_eq_goods),
            L = [Goods || Goods <- GoodsList, lib_goods:is_magic_key(Goods) andalso is_equip_put_on(PlayerId, Goods#goods.id)],
            case L =:= [] of
                true -> null;
                false -> erlang:hd(L)
            end
    end.


tst_add_magic_key_skill(PlayerId, SkillId) ->
    case get_magic_key(PlayerId) of
        null -> 
            skip;
        Goods ->
            List = lib_goods:get_mk_skill_list(Goods),
            NewList = 
                case mod_skill:is_initiative(SkillId) of
                    true ->
                        TList = List -- [lists:last(List)],
                        TList ++ [SkillId];
                    false ->
                        TList = List -- [erlang:hd(List)],
                        [SkillId | TList]
                end,
            Goods2 = lib_goods:set_mk_skill_list(Goods, NewList),
            mod_inv:mark_dirty_flag(PlayerId, Goods2),
            lib_inv:notify_cli_goods_info_change(PlayerId, Goods2)
    end.


%% 获取玩家的装备栏的物品列表
%% @return: [] | goods结构体列表
get_player_equip_list(PlayerId) ->
    Inv = mod_inv:get_inventory(PlayerId),
    GoodsList = mod_inv:get_goods_list_by_id_list(Inv#inv.player_eq_goods),
    %% 过滤掉宝石
    [Goods || Goods <- GoodsList, lib_goods:is_equip(Goods)].

get_player_equip_gem_list(PlayerId) ->
    GoodsList = get_player_equip_list(PlayerId),
    F = fun(Goods, AccNoL) ->
        GemInlay = lib_goods:get_equip_gemstone(Goods),
        F0 = fun({_HoleNo, Id}, Acc) ->
            case Id =:= ?INVALID_ID of
                true -> Acc;
                false -> [lib_goods:get_no_by_id(Id) | Acc]
            end
        end,
        NoList = lists:foldl(F0, [], GemInlay),
        NoList ++ AccNoL
    end,
    lists:foldl(F, [], GoodsList).


% 获取宠物的装备栏的物品列表
%% @return: [] | goods结构体列表
get_partner_equip_list(PlayerId, PartnerId) ->
    % ?ASSERT(PartnerId > 0),
    case mod_inv:get_inventory(PlayerId) of
        null -> [];
        Inv ->
            GoodsList = mod_inv:get_goods_list_by_id_list(Inv#inv.partner_eq_goods),
            [Goods || Goods <- GoodsList, Goods#goods.partner_id =:= PartnerId, lib_goods:is_equip(Goods)]
    end.

% 获得宠物装备栏宝石
get_partner_equip_gem_list(PlayerId,PartnerId) ->
    GoodsList = 
        case PartnerId of 0 -> [];
            _ -> get_partner_equip_list(PlayerId,PartnerId)
        end,
    F = fun(Goods, AccNoL) ->
        GemInlay = lib_goods:get_equip_gemstone(Goods),
        F0 = fun({_HoleNo, Id}, Acc) ->
            case Id =:= ?INVALID_ID of
                true -> Acc;
                false -> [lib_goods:get_no_by_id(Id) | Acc]
            end
        end,
        NoList = lists:foldl(F0, [], GemInlay),
        NoList ++ AccNoL
    end,
    lists:foldl(F, [], GoodsList).

%%
%%strenthen_equip(PS, GoodsId, Count, UseBindStone) ->
%%    case Count =:= 0 of
%%        false ->
%%            do_strenthen_equip(PS, GoodsId, Count, UseBindStone, []);
%%        true ->
%%            do_strenthen_equip_until_lv_up(PS, GoodsId, 2000, UseBindStone, [])
%%    end.

is_equip_put_on(PlayerId, GoodsId) ->
    Inv = mod_inv:get_inventory(PlayerId),
    lists:member(GoodsId, Inv#inv.player_eq_goods).


is_equip_put_on_par(PlayerId, GoodsId) ->
    Inv = mod_inv:get_inventory(PlayerId),
    lists:member(GoodsId, Inv#inv.partner_eq_goods).


compose_goods(PS, GoodsNo, Count, UseBindGoods) ->
    case check_compose_goods(PS, GoodsNo, Count, UseBindGoods) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, GoodsList} ->
            do_compose_goods(PS, GoodsNo, Count, UseBindGoods, GoodsList)
    end.

% duanshihe 转换道具
change_goods(PS, GoodsId, GoodsNo) ->
    case check_change_goods(PS, GoodsId, GoodsNo) of
        {fail, Reason} ->
            {fail, Reason};
        ok ->
            do_change_goods(PS, GoodsId, GoodsNo)
    end.

% 装备打造
equip_build(PS, GoodsNo, Type ) ->
    case check_equip_build(PS, GoodsNo, Type) of
        {fail, Reason} ->
            {fail, Reason};
        ok ->
            do_equip_build(PS, GoodsNo, Type)
    end.

goods_smelt(PS, GoodsList) ->
    case check_goods_smelt(PS, GoodsList) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, DataCfg, GoodsList1, BGoodsList} ->
            do_goods_smelt(PS, GoodsList1, BGoodsList, DataCfg)
    end.


equip_decompose(PS, IdList) ->
    case check_equip_decompose(PS, IdList) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, Goods, GoodsList} ->
            do_equip_decompose(PS, Goods, GoodsList)
    end.


open_gemstone_hole(PS, GoodsId, HoleNo) ->
    case check_open_gemstone_hole(PS, GoodsId, HoleNo) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, Goods, NeedGoodsList} ->
            do_open_gemstone_hole(PS, Goods, HoleNo, NeedGoodsList)
    end.


inlay_gemstone(PS, EqGoodsId, GemGoodsId, HoleNo) ->
    case check_inlay_gemstone(PS, EqGoodsId, GemGoodsId, HoleNo) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, EqGoods, GemGoods} ->
            do_inlay_gemstone(PS, EqGoods, GemGoods, HoleNo)
    end.


unload_gemstone(PS, EqGoodsId, GemGoodsId, HoleNo) ->
    case check_unload_gemstone(PS, EqGoodsId, GemGoodsId, HoleNo) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, EqGoods, GemGoods} ->
            do_unload_gemstone(PS, EqGoods, GemGoods, HoleNo)
    end.

stren_trs(PS, SrcEqId, ObjEqId) ->
    case check_stren_trs(PS, SrcEqId, ObjEqId) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, SrcEq, ObjEq, DataCfg} ->
            do_stren_trs(PS, SrcEq, ObjEq, DataCfg)
    end.


upgrade_quality(PS, GoodsId) ->
    case check_upgrade_quality(PS, GoodsId) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, Goods} ->
            do_upgrade_quality(PS, Goods)
    end.


upgrade_lv(PS, GoodsId) ->
    case check_upgrade_lv(PS, GoodsId) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, Goods, ObjStrenLv} ->
            do_upgrade_lv(PS, Goods, ObjStrenLv)
    end.    


recast(PS, GoodsId,Type) ->
    case check_recast(PS, GoodsId,Type) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, Goods} ->
            case Type of
                0 ->
                    do_recast(PS, Goods);
                _ ->
                    do_recast_base(PS,Goods)
            end
    end.   

recast_new(PS, GoodsId,Type) ->
    case check_recast(PS, GoodsId,Type) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, Goods} ->
            case Type of
                0 ->
                    do_recast_new(PS, Goods);
                _ ->
                    do_recast_base_new(PS,Goods)
            end
    end.   

% 替换
recast_new1(PS, GoodsId,Type,Action) ->
    case check_recast1(PS, GoodsId,Type,Action) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, Goods} ->
            do_recast_new1(PS, Goods, Type,Action)
    end.   

%% 需要上层函数 重算 装备战力与人物战力
refine(PS, GoodsId, Count, Index) ->
    do_refine(PS, GoodsId, Index, [], [], Count). 


%% 装备特效洗练
eff_refresh(PS, GoodsId, Type) ->
	case check_eff_refresh(PS, GoodsId, Type) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, Goods, StoneId, StoneCount, PriceType, Price} ->
			do_eff_refresh(PS, Goods, StoneId, StoneCount, PriceType, Price);
		{ok, Goods} ->
			do_eff_replace(PS, Goods)
    end.

%% 装备幻化
equip_transmogrify(PS, TargetGoodsId, GoodsId, Type) ->
    case check_equip_transmogrify(PS, TargetGoodsId, GoodsId, Type) of
        {fail, Reason} ->
            {fail, Reason};
        ok ->
            TarGoods = lib_goods:get_goods_by_id(TargetGoodsId),
            do_equip_transmogrify(PS, TarGoods, GoodsId, Type)
    end.

equip_transmogrify_save(PS, TargetGoodsId) ->
    case check_equip_transmogrify_save(PS, TargetGoodsId) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, TarGoods} ->
            do_equip_transmogrify_save(PS, TarGoods)
    end.


%------------------------------------------Local Function------------------------------------------------

check_refine(PS, GoodsId, Count, Index, AccMoneyL, AccGoodsL) ->
    try check_refine__(PS, GoodsId, Count, Index, AccMoneyL, AccGoodsL) of
        {ok, Goods, AccMoneyL1, AccGoodsL1} ->
            {ok, Goods, AccMoneyL1, AccGoodsL1}
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

do_refine(PS, GoodsId, _Index, AccMoneyL, AccGoodsL, 0) ->
    case length(AccMoneyL) of
        0 -> skip;
        1 ->
            {MoneyType1, Money1} = lists:nth(1, AccMoneyL),
            player:cost_money(PS, MoneyType1, Money1, [?LOG_EQUIP, "refine"]);
        2 ->            
            {MoneyType1, Money1} = lists:nth(1, AccMoneyL),
            {MoneyType2, Money2} = lists:nth(2, AccMoneyL),
            player:cost_money(PS, MoneyType1, Money1, [?LOG_EQUIP, "refine"]),
            player:cost_money(PS, MoneyType2, Money2, [?LOG_EQUIP, "refine"])
    end,

    mod_inv:destroy_goods_WNC(PS, AccGoodsL, [?LOG_EQUIP, "refine"]),
    Goods = mod_inv:get_goods_from_ets(GoodsId),
    {ok, Goods};

do_refine(PS, GoodsId, Index, AccMoneyL, AccGoodsL, Count) when Count > 0 ->
    case check_refine(PS, GoodsId, 1, Index, AccMoneyL, AccGoodsL) of
        {fail, Reason} ->
            case length(AccMoneyL) of
                0 -> skip;
                1 ->
                    {MoneyType1, Money1} = lists:nth(1, AccMoneyL),
                    player:cost_money(PS, MoneyType1, Money1, [?LOG_EQUIP, "refine"]);
                2 ->            
                    {MoneyType1, Money1} = lists:nth(1, AccMoneyL),
                    {MoneyType2, Money2} = lists:nth(2, AccMoneyL),
                    player:cost_money(PS, MoneyType1, Money1, [?LOG_EQUIP, "refine"]),
                    player:cost_money(PS, MoneyType2, Money2, [?LOG_EQUIP, "refine"])
            end,
            mod_inv:destroy_goods_WNC(PS, AccGoodsL, [?LOG_EQUIP, "refine"]),
            {fail, mod_inv:get_goods_from_ets(GoodsId), Reason};
        {ok, Goods, AccMoneyL1, AccGoodsL1} ->
            {_Index, AttrName, _AttrValue, CurRefineLv} = lists:keyfind(Index, 1, lib_goods:get_addi_ep_add_kv(Goods)),
            NewAttrValue = lib_equip:recount_addi_value(lib_goods:get_no(Goods), AttrName, CurRefineLv + 1),
            NewAddiEpAddKV = lists:keyreplace(Index, 1, lib_goods:get_addi_ep_add_kv(Goods), {Index, AttrName, NewAttrValue, CurRefineLv+1}),

            Goods1 = lib_goods:set_addi_ep_add_kv(Goods, NewAddiEpAddKV),
            Goods2 = lib_goods:set_addi_equip_add(Goods1, lib_attribute:to_addi_equip_add_attrs_record(NewAddiEpAddKV)),
            mod_inv:mark_dirty_flag(player:get_id(PS), Goods2),
            
            do_refine(PS, GoodsId, Index, AccMoneyL1, AccGoodsL1, Count-1)
    end;

do_refine(_PS, _GoodsId, _Index, _AccMoneyL, _AccGoodsL, _Count) ->
    {fail, ?PM_PARA_ERROR}.


check_refine__(PS, GoodsId, Count, Index, AccMoneyL, AccGoodsL) ->
    ?Ifc (GoodsId =< 0)
        throw(?PM_PARA_ERROR)
    ?End,

    ?Ifc (Count =< 0)
        throw(?PM_PARA_ERROR)
    ?End,

    ?Ifc (not util:in_range(Index, 1, 5))
        throw(?PM_PARA_ERROR)
    ?End,

    ?Ifc (not ply_sys_open:is_open(PS, ?SYS_EQ_XILIAN))
        throw(?PM_LV_LIMIT)
    ?End,

    Goods = mod_inv:find_goods_by_id_from_whole_inv(player:id(PS), GoodsId),
    ?Ifc (Goods =:= null)
        throw(?PM_GOODS_NOT_EXISTS)
    ?End,

    ?Ifc (lib_goods:is_partner_equip(Goods))
        throw(?PM_PARA_ERROR)
    ?End,

    ?Ifc (lib_goods:is_fashion(Goods))
        throw(?PM_PARA_ERROR)
    ?End,

    ?Ifc (not lib_goods:is_equip(Goods))
        throw(?PM_PARA_ERROR)
    ?End,

    EqLv = lib_goods:get_lv(Goods),
    RefineOpenCfg = data_eq_refine_lv_open:get(EqLv),
    ?Ifc (RefineOpenCfg =:= null)
        throw(?PM_DATA_CONFIG_ERROR)
    ?End,

    {_RefineLvMin, RefineLvMax, _} = RefineOpenCfg,
    AddiAttrTup = lists:keyfind(Index, 1, lib_goods:get_addi_ep_add_kv(Goods)),
    ?Ifc (AddiAttrTup =:= false)
        throw(?PM_UNKNOWN_ERR)
    ?End,

    {_Index, _, _, CurRefineLv} = AddiAttrTup,
    ?Ifc (CurRefineLv + Count > RefineLvMax)
        throw(?PM_GOODS_REFINE_LV_MAX)
    ?End,

    Data = data_eq_refine_lv_rela:get(CurRefineLv),
    ?Ifc (Data =:= null)
        throw(?PM_DATA_CONFIG_ERROR)
    ?End,

    ?Ifc (length(Data#eq_refine_lv_rela.money_list) > 2)
        throw(?PM_DATA_CONFIG_ERROR)
    ?End,

    AccMoneyL1 = arrange_money_list(Data#eq_refine_lv_rela.money_list ++ AccMoneyL),
    RetMoney = check_money(PS, AccMoneyL1),
    ?Ifc (RetMoney =/= 0)
        throw(RetMoney)
    ?End,

    AccGoodsL1 = AccGoodsL ++ Data#eq_refine_lv_rela.goods_list,
    case mod_inv:check_batch_destroy_goods(PS, AccGoodsL1) of
        {fail, Reason} ->
            throw(Reason);
        ok ->
            {ok, Goods, AccMoneyL1, AccGoodsL1}
    end.


check_recast1(PS, GoodsId,Type,Action) ->
    try check_recast1__(PS, GoodsId,Type,Action) of
        {ok, Goods} ->
            {ok, Goods}
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

check_recast1__(PS, GoodsId,Type,_Action) ->
    ?Ifc (GoodsId =< 0)
        throw(?PM_PARA_ERROR)
    ?End,

    Goods = mod_inv:find_goods_by_id_from_whole_inv(player:id(PS), GoodsId),
    GoodsNo = lib_goods:get_no(Goods),

    ?Ifc (Goods =:= null)
        throw(?PM_GOODS_NOT_EXISTS)
    ?End,

    ?Ifc (lib_goods:is_fashion(Goods))
        throw(?PM_PARA_ERROR)
    ?End,

    ?Ifc (not lib_goods:is_equip(Goods))
        throw(?PM_PARA_ERROR)
    ?End,

    %% 判断系统开放等级 
    ?Ifc (not ply_sys_open:is_open(PS, ?SYS_EQ_XILIAN))
        throw(?PM_LV_LIMIT)
    ?End,

    ?Ifc (Type == 0 andalso lib_goods:get_last_ref_attr(Goods) =:= null)
        throw(?PM_NOT_HAVE_ATTRS)
    ?End,

    ?Ifc (Type == 1 andalso lib_goods:get_last_base_attr(Goods) =:= null)
        throw(?PM_NOT_HAVE_ATTRS)
    ?End,

    {ok, Goods}.


check_recast(PS, GoodsId,Type) ->
    try check_recast__(PS, GoodsId,Type) of
        {ok, Goods} ->
            {ok, Goods}
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.


check_recast__(PS, GoodsId,Type) ->
    ?Ifc (GoodsId =< 0)
        throw(?PM_PARA_ERROR)
    ?End,

    Goods = mod_inv:find_goods_by_id_from_whole_inv(player:id(PS), GoodsId),
    GoodsNo = lib_goods:get_no(Goods),

    ?Ifc (Goods =:= null)
        throw(?PM_GOODS_NOT_EXISTS)
    ?End,

    ?Ifc (lib_goods:is_fashion(Goods))
        throw(?PM_PARA_ERROR)
    ?End,

    ?Ifc (not lib_goods:is_equip(Goods))
        throw(?PM_PARA_ERROR)
    ?End,

    %% 判断系统开放等级 
    ?Ifc (not ply_sys_open:is_open(PS, ?SYS_EQ_XILIAN))
        throw(?PM_LV_LIMIT)
    ?End,

    Data = data_equip_recast:get(GoodsNo),
    ?Ifc (Data =:= null)
        throw(?PM_DATA_CONFIG_ERROR)
    ?End,

    ?Ifc (length(Data#eq_recast_cfg.money_list) > 2)
        throw(?PM_DATA_CONFIG_ERROR)
    ?End,

    RetMoney = check_money(PS, Data#eq_recast_cfg.money_list),
    ?Ifc (RetMoney =/= 0)
        throw(RetMoney)
    ?End,

    % 重铸基本属性消耗强化石
    GoodsList = case Type of
        0 -> Data#eq_recast_cfg.goods_list;
        _ ->
            case lib_goods:get_quality(Goods) of
                ?QUALITY_WHITE ->
                    [{70011,util:minmax(util:ceil((lib_goods:get_lv(Goods)/30)),1,10)}];
                ?QUALITY_GREEN ->
                    [{70011,util:minmax(util:ceil((lib_goods:get_lv(Goods)/25)),1,15)}];
                ?QUALITY_BLUE ->
                    [{70011,util:minmax(util:ceil((lib_goods:get_lv(Goods)/20)),1,20)}];
                ?QUALITY_PURPLE ->
                    [{70012,util:minmax(util:ceil((lib_goods:get_lv(Goods)/30)),1,10)}];
                ?QUALITY_ORANGE ->
                    [{70012,util:minmax(util:ceil((lib_goods:get_lv(Goods)/25)),1,15)}];
                ?QUALITY_RED ->
                    [{70012,util:minmax(util:ceil((lib_goods:get_lv(Goods)/20)),1,20)}]
            end
    end,

    case mod_inv:check_batch_destroy_goods(PS,GoodsList) of
        {fail, Reason} ->
            throw(Reason);
        ok ->
            {ok, Goods}
    end.


check_eff_refresh(PS, GoodsId, Type) ->
    try check_eff_refresh__(PS, GoodsId, Type) of
        {ok, Goods, StoneId, StoneCount, PriceType, Price} ->
            {ok, Goods, StoneId, StoneCount, PriceType, Price};
		{ok, Goods} ->
			{ok, Goods}
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

check_eff_refresh__(PS, GoodsId, 1) ->
    ?Ifc (GoodsId =< 0)
        throw(?PM_PARA_ERROR)
    ?End,

    Goods = mod_inv:find_goods_by_id_from_whole_inv(player:id(PS), GoodsId),
    GoodsNo = lib_goods:get_no(Goods),

    ?Ifc (Goods =:= null)
        throw(?PM_GOODS_NOT_EXISTS)
    ?End,

    ?Ifc (not lib_goods:is_equip(Goods))
        throw(?PM_PARA_ERROR)
    ?End,

    %% 判断系统开放等级 
    ?Ifc (not ply_sys_open:is_open(PS, ?SYS_EQ_EFFECT_XILIAN))
        throw(?PM_LV_LIMIT)
    ?End,

	GoodsTplLv = lib_goods:get_tpl_lv(Goods),
    Nos = data_equip_effect_wash:get_all_no(),
	case lists:foldl(fun(No, Acc) ->
					Data = #equip_effect_wash{lv_lower = LvLower,
									   lv_upper = LvUpper} = data_equip_effect_wash:get(No),
					case LvLower =< GoodsTplLv andalso LvUpper >= GoodsTplLv of
						true ->
							Data;
						false ->
							Acc
					end
				end, null, Nos) of
		null ->
			throw(?PM_PARA_ERROR);
		#equip_effect_wash{xilian_stone = StoneId,
						   xilian_stone_count = StoneCount,
						   price_type = PriceType,
						   price = Price} ->
			RetMoney = check_money(PS, [{PriceType, Price}]),
    		?Ifc (RetMoney =/= 0)
        		throw(RetMoney)
    		?End,

    		case mod_inv:check_batch_destroy_goods(PS, [{StoneId, StoneCount}]) of
        		{fail, Reason} ->
            		throw(Reason);
				ok ->	
					{ok, Goods, StoneId, StoneCount, PriceType, Price}
			end
	end;

check_eff_refresh__(PS, GoodsId, 2) ->
    ?Ifc (GoodsId =< 0)
        throw(?PM_PARA_ERROR)
    ?End,

    Goods = mod_inv:find_goods_by_id_from_whole_inv(player:id(PS), GoodsId),

    ?Ifc (Goods =:= null)
        throw(?PM_GOODS_NOT_EXISTS)
    ?End,

    ?Ifc (not lib_goods:is_equip(Goods))
        throw(?PM_PARA_ERROR)
    ?End,

    %% 判断系统开放等级 
    ?Ifc (not ply_sys_open:is_open(PS, ?SYS_EQ_EFFECT_XILIAN))
        throw(?PM_LV_LIMIT)
    ?End,

	{ok, Goods}.


do_eff_refresh(PS, Goods, StoneId, StoneCount, PriceType, Price) ->
	player:cost_money(PS, PriceType, Price, [?LOG_EQUIP, "eff_refresh"]),
	mod_inv:destroy_goods_WNC(PS, [{StoneId, StoneCount}], [?LOG_EQUIP, "eff_refresh"]),
	
	Nos = data_equip_speci_effect:get_type_no(1),
	N = util:rand(1, erlang:length(Nos)),
	AddiEquipEffNo = lists:nth(N, Nos),
%%     AddiEquipEffAdd = case AddiEquipEffNo of 
%%     		            	0 -> #attrs{};
%%             		    	_ -> lib_attribute:to_addi_equip_eff(AddiEquipEffNo)
%% 					  end,
	?INFO_MSG("~n~n~n~nAddiEquipEffNo : ~p~n~n~n", [AddiEquipEffNo]),
	Goods2 = lib_goods:set_equip_eff_temp_no(Goods, AddiEquipEffNo),
%% 	Goods2 = Goods#goods{
%% 						 addi_equip_eff = AddiEquipEffNo,
%% 						 addi_equip_eff_add = AddiEquipEffAdd
%% 						 },
%% 	Goods3 = lib_goods:set_equip_effect(Goods2,Goods2#goods.addi_equip_eff),
%%     Goods4 = lib_goods:set_battle_power(Goods3, lib_equip:recount_battle_power(Goods3)),
	mod_inv:mark_dirty_flag(player:get_id(PS), Goods2),
	lib_inv:notify_cli_goods_info_change(player:id(PS), Goods2),
	%% 属性计算
%%     case mod_equip:is_equip_put_on(player:get_id(PS), lib_goods:get_id(Goods4)) of
%%         false -> skip;
%%         true -> ply_attr:recount_equip_add_and_total_attrs(PS)
%%     end,
	{ok, Goods2}.


do_eff_replace(PS, Goods) ->
	case lib_goods:get_equip_eff_temp_no(Goods) of
		0 ->
			{fail, ?PM_PARA_ERROR};
		AddiEquipEffNo ->
			AddiEquipEffAdd = case AddiEquipEffNo of 
								  0 -> #attrs{};
								  _ -> lib_attribute:to_addi_equip_eff(AddiEquipEffNo)
							  end,
			?INFO_MSG("~n~n~n~nAddiEquipEffNo : ~p~n~n~n", [AddiEquipEffNo]),
			Goods2 = lib_goods:set_equip_eff_temp_no(Goods#goods{
																 addi_equip_eff = AddiEquipEffNo,
																 addi_equip_eff_add = AddiEquipEffAdd
																}, 0),
			Goods3 = lib_goods:set_equip_effect(Goods2,Goods2#goods.addi_equip_eff),
			Goods4 = lib_goods:set_battle_power(Goods3, lib_equip:recount_battle_power(Goods3)),
			mod_inv:mark_dirty_flag(player:get_id(PS), Goods4),
			lib_inv:notify_cli_goods_info_change(player:id(PS), Goods4),
			%% 属性计算
			recount_attr_equip_put_on(PS, Goods4),
			{ok, Goods4}  
	end.

% ------------------------------------------------------------------------- %
% 重铸基础属性
do_recast_base_new(PS, Goods) ->
    GoodsNo = lib_goods:get_no(Goods),
    DataCfg = data_equip_recast:get(GoodsNo),
    case length(DataCfg#eq_recast_cfg.money_list) of
        0 -> skip;
        1 ->
            {MoneyType1, Money1} = lists:nth(1, DataCfg#eq_recast_cfg.money_list),
            player:cost_money(PS, MoneyType1, Money1, [?LOG_EQUIP, "recast"]);
        2 ->
            {MoneyType1, Money1} = lists:nth(1, DataCfg#eq_recast_cfg.money_list),
            {MoneyType2, Money2} = lists:nth(2, DataCfg#eq_recast_cfg.money_list),
            player:cost_money(PS, MoneyType1, Money1, [?LOG_EQUIP, "recast"]),
            player:cost_money(PS, MoneyType2, Money2, [?LOG_EQUIP, "recast"])
    end,

    % 重铸基本属性消耗强化石
    GoodsList = 
        case lib_goods:get_quality(Goods) of
            ?QUALITY_WHITE ->
                [{70011,util:minmax(util:ceil((lib_goods:get_lv(Goods)/30)),1,10)}];
            ?QUALITY_GREEN ->
                [{70011,util:minmax(util:ceil((lib_goods:get_lv(Goods)/25)),2,15)}];
            ?QUALITY_BLUE ->
                [{70011,util:minmax(util:ceil((lib_goods:get_lv(Goods)/20)),1,20)}];
            ?QUALITY_PURPLE ->
                [{70012,util:minmax(util:ceil((lib_goods:get_lv(Goods)/30)),2,10)}];
            ?QUALITY_ORANGE ->
                [{70012,util:minmax(util:ceil((lib_goods:get_lv(Goods)/25)),1,15)}];
            ?QUALITY_RED -> 
                [{70012,util:minmax(util:ceil((lib_goods:get_lv(Goods)/20)),2,20)}]
        end,


    mod_inv:destroy_goods_WNC(PS,GoodsList,[?LOG_EQUIP, "recast_base"]),

    GoodsTpl = lib_goods:get_tpl_data(GoodsNo),
    Quality = lib_goods:get_quality(Goods),

    BaseEquipAdd = lib_equip:decide_base_equip_add(GoodsTpl, Quality),
    Goods4 = lib_goods:set_last_base_attr(Goods,BaseEquipAdd),
    
    mod_inv:mark_dirty_flag(player:get_id(PS), Goods4),
    lib_inv:notify_cli_goods_info_change(player:id(PS), Goods4),

    %% 属性计算
	recount_attr_equip_put_on(PS, Goods4),

    {ok, Goods4,BaseEquipAdd}.

% 重铸附加属性
do_recast_new(PS, Goods) ->
    GoodsNo = lib_goods:get_no(Goods),
    DataCfg = data_equip_recast:get(GoodsNo),
    case length(DataCfg#eq_recast_cfg.money_list) of
        0 -> skip;
        1 ->
            {MoneyType1, Money1} = lists:nth(1, DataCfg#eq_recast_cfg.money_list),
            player:cost_money(PS, MoneyType1, Money1, [?LOG_EQUIP, "recast"]);
        2 ->
            {MoneyType1, Money1} = lists:nth(1, DataCfg#eq_recast_cfg.money_list),
            {MoneyType2, Money2} = lists:nth(2, DataCfg#eq_recast_cfg.money_list),
            player:cost_money(PS, MoneyType1, Money1, [?LOG_EQUIP, "recast"]),
            player:cost_money(PS, MoneyType2, Money2, [?LOG_EQUIP, "recast"])
    end,

    mod_inv:destroy_goods_WNC(PS,DataCfg#eq_recast_cfg.goods_list,[?LOG_EQUIP, "recast"]),

    GoodsTpl = lib_goods:get_tpl_data(GoodsNo),
    Quality = lib_goods:get_quality(Goods),

    % 重铸附加属性
    AddiEquipAdd = 
        case lib_goods:get_type(GoodsTpl) =:= ?GOODS_T_PAR_EQUIP of
            true -> [];
            false ->
                AddiEquipAddDebug = lib_equip:make_addi_random_attr(GoodsNo, Quality),
                AddiEquipAddDebug
        end,

    Goods4 = lib_goods:set_last_ref_attr(Goods,AddiEquipAdd), 
    
    mod_inv:mark_dirty_flag(player:get_id(PS), Goods4),
    lib_inv:notify_cli_goods_info_change(player:id(PS), Goods4),

    %% 属性计算
	recount_attr_equip_put_on(PS, Goods4),
    % lib_log:statis_equip_recast(PS, lib_goods:get_id(Goods4), lib_goods:get_addi_ep_add_kv(Goods), AddiEquipAdd),
    {ok, Goods4,AddiEquipAdd}.

do_recast_new1(PS, Goods,Type,Action) ->
    case Type of
        0 ->
            case Action of
                1 ->
                    AddiEquipAdd = lib_goods:get_last_ref_attr(Goods),
                    AddiEquipAdd2 = lib_attribute:to_addi_equip_add_attrs_record(AddiEquipAdd),   % 转为attrs结构体

                    Goods1 = lib_goods:set_addi_ep_add_kv(Goods, AddiEquipAdd),                   % 存到ets
                    Goods2 = lib_goods:set_addi_equip_add(Goods1, AddiEquipAdd2),
                    Goods3 = lib_goods:set_last_ref_attr(Goods2,null),

                    Goods4 = lib_goods:set_battle_power(Goods3, lib_equip:recount_battle_power(Goods3)),
                    
                    mod_inv:mark_dirty_flag(player:get_id(PS), Goods4),
                    lib_inv:notify_cli_goods_info_change(player:id(PS), Goods4),



                    %% 属性计算
                    recount_attr_equip_put_on(PS, Goods4),
                    lib_log:statis_equip_recast(PS, lib_goods:get_id(Goods4), lib_goods:get_addi_ep_add_kv(Goods), AddiEquipAdd),
                    {ok, Goods4};
                0 -> 
                    Goods1 = lib_goods:set_last_ref_attr(Goods,null),
                    mod_inv:mark_dirty_flag(player:get_id(PS), Goods1),
                    {ok, Goods1};
                _G -> {fail, ?PM_CLI_MSG_ILLEGAL}
            end;
        1 ->
            case Action of
                1 ->
                    BaseEquipAdd = lib_goods:get_last_base_attr(Goods),
                    Goods01 = lib_goods:set_show_base_equip_add(Goods,BaseEquipAdd),
                    BaseEquipAdd01 =util:duplicate_key_sum_value(BaseEquipAdd) ,
                    BaseEquipAdd2 = lib_attribute:to_attrs_record(BaseEquipAdd01),
                    Goods1 = lib_goods:set_last_base_attr(Goods01,null),
                    Goods3 = lib_goods:set_base_equip_add(Goods1, BaseEquipAdd2),
                    Goods4 = lib_goods:set_battle_power(Goods3, lib_equip:recount_battle_power(Goods3)),
                    
                    mod_inv:mark_dirty_flag(player:get_id(PS), Goods4),
                    lib_inv:notify_cli_goods_info_change(player:id(PS), Goods4),

                    %% 属性计算
                    recount_attr_equip_put_on(PS, Goods4),

                    {ok, Goods4};
                0 -> 
                    Goods1 = lib_goods:set_last_base_attr(Goods,null),
                    mod_inv:mark_dirty_flag(player:get_id(PS), Goods1),
                    {ok, Goods1};
                _G -> {fail, ?PM_CLI_MSG_ILLEGAL}
            end;
        _ ->
            {fail, ?PM_CLI_MSG_ILLEGAL}
    end.

% ------------------------------------------------------------------------- %
% 重铸基础属性
do_recast_base(PS, Goods) ->
    GoodsNo = lib_goods:get_no(Goods),
    DataCfg = data_equip_recast:get(GoodsNo),
    case length(DataCfg#eq_recast_cfg.money_list) of
        0 -> skip;
        1 ->
            {MoneyType1, Money1} = lists:nth(1, DataCfg#eq_recast_cfg.money_list),
            player:cost_money(PS, MoneyType1, Money1, [?LOG_EQUIP, "recast"]);
        2 ->
            {MoneyType1, Money1} = lists:nth(1, DataCfg#eq_recast_cfg.money_list),
            {MoneyType2, Money2} = lists:nth(2, DataCfg#eq_recast_cfg.money_list),
            player:cost_money(PS, MoneyType1, Money1, [?LOG_EQUIP, "recast"]),
            player:cost_money(PS, MoneyType2, Money2, [?LOG_EQUIP, "recast"])
    end,

    % 重铸基本属性消耗强化石
    GoodsList = 
        case lib_goods:get_quality(Goods) of
            ?QUALITY_WHITE ->
                [{70011,util:minmax(util:ceil((lib_goods:get_lv(Goods)/30)),1,10)}];
            ?QUALITY_GREEN ->
                [{70011,util:minmax(util:ceil((lib_goods:get_lv(Goods)/25)),2,15)}];
            ?QUALITY_BLUE ->
                [{70011,util:minmax(util:ceil((lib_goods:get_lv(Goods)/20)),1,20)}];
            ?QUALITY_PURPLE ->
                [{70012,util:minmax(util:ceil((lib_goods:get_lv(Goods)/30)),2,10)}];
            ?QUALITY_ORANGE ->
                [{70012,util:minmax(util:ceil((lib_goods:get_lv(Goods)/25)),1,15)}];
            ?QUALITY_RED -> 
                [{70012,util:minmax(util:ceil((lib_goods:get_lv(Goods)/20)),2,20)}]
        end,

    % ?DEBUG_MSG("do_recast goods_list:~p", [DataCfg#eq_recast_cfg.goods_list]),    
    % mod_inv:destroy_goods_by_id(PS, {lib_goods:get_id(Goods2Cons),1}, [?LOG_EQUIP, "recast"]),
    mod_inv:destroy_goods_WNC(PS,GoodsList,[?LOG_EQUIP, "recast_base"]),

    GoodsTpl = lib_goods:get_tpl_data(GoodsNo),
    Quality = lib_goods:get_quality(Goods),

    BaseEquipAdd = lib_equip:decide_base_equip_add(GoodsTpl, Quality),
    BaseEquipAdd2 = lib_attribute:to_attrs_record(BaseEquipAdd),

    % 重铸附加属性
    % AddiEquipAdd = 
    %     case lib_goods:get_type(GoodsTpl) =:= ?GOODS_T_PAR_EQUIP of
    %         true -> [];
    %         false ->
    %             AddiEquipAddDebug = lib_equip:make_random_attr(GoodsNo),
    %             AddiEquipAddDebug
    %     end,

    % AddiEquipAdd2 = lib_attribute:to_addi_equip_add_attrs_record(AddiEquipAdd),   % 转为attrs结构体

    % Goods1 = lib_goods:set_addi_ep_add_kv(Goods, AddiEquipAdd),
    % Goods2 = lib_goods:set_addi_equip_add(Goods1, AddiEquipAdd2),
    % Goods3 = Goods2,
    Goods3 = lib_goods:set_base_equip_add(Goods, BaseEquipAdd2),

    Goods4 = lib_goods:set_battle_power(Goods3, lib_equip:recount_battle_power(Goods3)),
    
    mod_inv:mark_dirty_flag(player:get_id(PS), Goods4),
    lib_inv:notify_cli_goods_info_change(player:id(PS), Goods4),

    %% 属性计算
    % lib_log:statis_equip_recast(PS, lib_goods:get_id(Goods4), lib_goods:get_addi_ep_add_kv(Goods), AddiEquipAdd),
    {ok, Goods4}.

% 重铸附加属性
do_recast(PS, Goods) ->
    GoodsNo = lib_goods:get_no(Goods),
    DataCfg = data_equip_recast:get(GoodsNo),
    case length(DataCfg#eq_recast_cfg.money_list) of
        0 -> skip;
        1 ->
            {MoneyType1, Money1} = lists:nth(1, DataCfg#eq_recast_cfg.money_list),
            player:cost_money(PS, MoneyType1, Money1, [?LOG_EQUIP, "recast"]);
        2 ->
            {MoneyType1, Money1} = lists:nth(1, DataCfg#eq_recast_cfg.money_list),
            {MoneyType2, Money2} = lists:nth(2, DataCfg#eq_recast_cfg.money_list),
            player:cost_money(PS, MoneyType1, Money1, [?LOG_EQUIP, "recast"]),
            player:cost_money(PS, MoneyType2, Money2, [?LOG_EQUIP, "recast"])
    end,

    % ?DEBUG_MSG("do_recast goods_list:~p", [DataCfg#eq_recast_cfg.goods_list]),    
    % mod_inv:destroy_goods_by_id(PS, {lib_goods:get_id(Goods2Cons),1}, [?LOG_EQUIP, "recast"]),
    mod_inv:destroy_goods_WNC(PS,DataCfg#eq_recast_cfg.goods_list,[?LOG_EQUIP, "recast"]),

    GoodsTpl = lib_goods:get_tpl_data(GoodsNo),
    Quality = lib_goods:get_quality(Goods),

    % BaseEquipAdd = lib_equip:decide_base_equip_add(GoodsTpl, Quality),
    % BaseEquipAdd2 = lib_attribute:to_attrs_record(BaseEquipAdd),

    % 重铸附加属性
    AddiEquipAdd = 
        case lib_goods:get_type(GoodsTpl) =:= ?GOODS_T_PAR_EQUIP of
            true -> [];
            false ->
                AddiEquipAddDebug = lib_equip:make_addi_random_attr(GoodsNo, Quality),
                AddiEquipAddDebug
        end,

    AddiEquipAdd2 = lib_attribute:to_addi_equip_add_attrs_record(AddiEquipAdd),   % 转为attrs结构体

    Goods1 = lib_goods:set_addi_ep_add_kv(Goods, AddiEquipAdd),
    Goods2 = lib_goods:set_addi_equip_add(Goods1, AddiEquipAdd2),
    Goods3 = Goods2,
    % Goods3 = lib_goods:set_base_equip_add(Goods2, BaseEquipAdd2),

    Goods4 = lib_goods:set_battle_power(Goods3, lib_equip:recount_battle_power(Goods3)),
    
    mod_inv:mark_dirty_flag(player:get_id(PS), Goods4),
    lib_inv:notify_cli_goods_info_change(player:id(PS), Goods4),

    %% 属性计算
    lib_log:statis_equip_recast(PS, lib_goods:get_id(Goods4), lib_goods:get_addi_ep_add_kv(Goods), AddiEquipAdd),
    {ok, Goods4}.


rand_get_diff_attr(Goods, AttrName) ->
    rand_get_diff_attr(Goods, AttrName, 500).


rand_get_diff_attr(_Goods, _AttrName, 0) ->
    ?ERROR_MSG("mod_equip:rand_get_diff_attr error!~n", []),
    phy_att;
rand_get_diff_attr(Goods, AttrName, Count) ->
    case lib_equip:decide_addi_equip_add_by_count(lib_goods:get_no(Goods), lib_goods:get_quality(Goods), 1) of
        [] ->
            rand_get_diff_attr(Goods, AttrName, Count-1);
        [{_, NewAttrName, _Value, _}] ->
            case NewAttrName =:= AttrName of
                false -> NewAttrName;
                true -> rand_get_diff_attr(Goods, AttrName, Count-1)
            end
    end.


check_upgrade_lv(PS, GoodsId) ->
    try check_upgrade_lv__(PS, GoodsId) of
        {ok, Goods, ObjStrenLv} ->
            {ok, Goods, ObjStrenLv}
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.


check_upgrade_lv__(PS, GoodsId) ->
    ?Ifc (GoodsId =< 0)
        throw(?PM_PARA_ERROR)
    ?End,

    Goods = mod_inv:find_goods_by_id_from_whole_inv(player:id(PS), GoodsId),
    ?Ifc (Goods =:= null)
        throw(?PM_GOODS_NOT_EXISTS)
    ?End,

    ?Ifc (lib_goods:is_partner_equip(Goods))
        throw(?PM_PARA_ERROR)
    ?End,

    ?Ifc (lib_goods:is_fashion(Goods))
        throw(?PM_PARA_ERROR)
    ?End,

    ?Ifc (not lib_goods:is_equip(Goods))
        throw(?PM_PARA_ERROR)
    ?End,

    Quality = lib_goods:get_quality(Goods),
    Lv = lib_goods:get_tpl_lv(Goods),
    % ?Ifc (Quality < ?QUALITY_ORANGE)
    %     throw(?PM_GOODS_QUALITY_LIMIT)
    % ?End,

    %% 判断系统开放等级
    ?Ifc (not ply_sys_open:is_open(PS, ?SYS_EQ_UPGRADE_LV))
        throw(?PM_LV_LIMIT)
    ?End,

    Data = data_eq_upgrade_lv:get(Quality, lib_goods:get_no(Goods)),
    ?Ifc (Data =:= null)
        throw(?PM_GOODS_LV_MAX)
    ?End,
    
    ?Ifc (length(Data#upgrade_lv_cfg.money) > 2)
        throw(?PM_DATA_CONFIG_ERROR)
    ?End,

    RetMoney = check_money(PS, Data#upgrade_lv_cfg.money),

    ?Ifc (RetMoney =/= 0)
        throw(RetMoney)
    ?End,

    %% 强化转移相关判断
    StepList = sets:to_list(sets:from_list(data_equip_strenthen:get_all_lv_step_list())),
    ?Ifc (StepList =:= [])
        throw(?PM_DATA_CONFIG_ERROR)
    ?End,

    ObjTplData = lib_goods:get_tpl_data(Data#upgrade_lv_cfg.obj_goods_no),
    ?Ifc(ObjTplData =:= null)
        throw(?PM_DATA_CONFIG_ERROR)
    ?End,

    ObjLv = lib_goods:get_tpl_lv(ObjTplData),
    ?Ifc (player:get_lv(PS) < ObjLv)
        throw(?PM_LV_LIMIT)
    ?End,
    
    StepSrc = lib_equip:get_lv_step_for_strenthen(Lv,  StepList),
    StepObj = lib_equip:get_lv_step_for_strenthen(ObjLv,  StepList),
    ?Ifc (StepSrc > StepObj)
        throw(?PM_GOODS_TRS_LIMIT)
    ?End,

    DataStrenTrs = data_stren_trs:get(StepSrc, StepObj, lib_goods:get_stren_lv(Goods)),
    ?Ifc (lib_goods:get_stren_lv(Goods) > 0 andalso DataStrenTrs =:= null)
        throw(?PM_DATA_CONFIG_ERROR)
    ?End,

    ObjStrenLv = 
        case DataStrenTrs =:= null of
            true -> 0;
            false -> DataStrenTrs#stren_trs_cfg.obj_stren_lv
        end,

    case mod_inv:check_batch_destroy_goods(PS, Data#upgrade_lv_cfg.goods_list) of
        {fail, Reason} ->
            throw(Reason);
        ok ->
            {ok, Goods, ObjStrenLv}
    end.


do_upgrade_lv(PS, Goods, ObjStrenLv) ->
    Quality = lib_goods:get_quality(Goods),
    DataCfg = data_eq_upgrade_lv:get(Quality, lib_goods:get_no(Goods)),

    case length(DataCfg#upgrade_lv_cfg.money) of
        0 -> skip;
        1 ->
            {MoneyType1, Money1} = lists:nth(1, DataCfg#upgrade_lv_cfg.money),
            player:cost_money(PS, MoneyType1, Money1, [?LOG_EQUIP, "upgrade_lv"]);
        2 ->
            {MoneyType1, Money1} = lists:nth(1, DataCfg#upgrade_lv_cfg.money),
            {MoneyType2, Money2} = lists:nth(2, DataCfg#upgrade_lv_cfg.money),
            player:cost_money(PS, MoneyType1, Money1, [?LOG_EQUIP, "upgrade_lv"]),
            player:cost_money(PS, MoneyType2, Money2, [?LOG_EQUIP, "upgrade_lv"])
    end,

    mod_inv:destroy_goods_WNC(PS, DataCfg#upgrade_lv_cfg.goods_list, [?LOG_EQUIP, "upgrade_lv"]),

    BaseEquipAdd = lib_equip:decide_base_equip_add(lib_goods:get_tpl_data(DataCfg#upgrade_lv_cfg.obj_goods_no), Quality),
    BaseEquipAdd2 = lib_attribute:to_attrs_record(BaseEquipAdd),
    Goods1 = lib_goods:set_base_equip_add(Goods, BaseEquipAdd2),
    Goods2 = lib_goods:set_stren_lv(Goods1, ObjStrenLv),
    Goods3 = lib_goods:set_stren_exp(Goods2, 0),

    Goods4 = lib_goods:set_bind_state(Goods3, ?BIND_ALREADY),
    Goods5 = lib_goods:set_no(Goods4, DataCfg#upgrade_lv_cfg.obj_goods_no),

    Goods6 = lib_goods:set_battle_power(Goods5, lib_equip:recount_battle_power(Goods5)),
    
    mod_inv:mark_dirty_flag(player:get_id(PS), Goods6),
    lib_inv:notify_cli_goods_info_change(player:id(PS), Goods6),

    %% 属性计算
	recount_attr_equip_put_on(PS, Goods6),
    lib_log:statis_equip_upgrade(PS, lib_goods:get_id(Goods6), lib_goods:get_lv(Goods), lib_goods:get_lv(Goods6)),
    {ok, Goods6}.


check_upgrade_quality(PS, GoodsId) ->
    try check_upgrade_quality__(PS, GoodsId) of
        {ok, Goods} ->
            {ok, Goods}
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.


check_upgrade_quality__(PS, GoodsId) ->
    ?Ifc (GoodsId =< 0)
        throw(?PM_PARA_ERROR)
    ?End,

    Goods = mod_inv:find_goods_by_id_from_whole_inv(player:id(PS), GoodsId),
    ?Ifc (Goods =:= null)
        throw(?PM_GOODS_NOT_EXISTS)
    ?End,

    ?Ifc (not lib_goods:is_equip(Goods))
        throw(?PM_PARA_ERROR)
    ?End,

    Quality = lib_goods:get_quality(Goods) + 1,
    Lv = lib_goods:get_tpl_lv(Goods),
    % ?Ifc (Quality < ?QUALITY_BLUE)
    %     throw(?PM_GOODS_QUALITY_LIMIT)
    % ?End,

    ?Ifc (Quality > ?QUALITY_MAX)
        throw(?PM_GOODS_QUALITY_MAX)
    ?End,

    %% 判断系统开放等级
    ?Ifc (not ply_sys_open:is_open(PS, ?SYS_EQ_UPGRADE_QUALITY))
        throw(?PM_LV_LIMIT)
    ?End,

    Data = data_eq_upgrade_quality:get(Lv, Quality),
    ?Ifc (Data =:= null)
        throw(?PM_DATA_CONFIG_ERROR)
    ?End,
    
    ?Ifc (length(Data#upgrade_quality_cfg.money) > 2)
        throw(?PM_DATA_CONFIG_ERROR)
    ?End,

    RetMoney = check_money(PS, Data#upgrade_quality_cfg.money),

    ?Ifc (RetMoney =/= 0)
        throw(RetMoney)
    ?End,

    ?Ifc (lib_goods:is_partner_equip(Goods))
        throw(?PM_PARA_ERROR)
    ?End,

    ?Ifc (lib_goods:is_fashion(Goods))
        throw(?PM_PARA_ERROR)
    ?End,

    case mod_inv:check_batch_destroy_goods(PS, Data#upgrade_quality_cfg.goods_list) of
        {fail, Reason} ->
            throw(Reason);
        ok ->
            {ok, Goods}
    end.


check_money(_PS, []) ->
    0;
check_money(PS, [{MoneyType, Count} | T]) ->
    ?DEBUG_MSG("check_money=~p,~p",[MoneyType, Count]),
    case player:has_enough_money(PS, MoneyType, Count) of
        false ->
            case MoneyType of
                ?MNY_T_GAMEMONEY -> ?PM_GAMEMONEY_LIMIT;
                ?MNY_T_YUANBAO -> ?PM_YB_LIMIT;
                ?MNY_T_BIND_GAMEMONEY -> ?PM_BIND_GAMEMONEY_LIMIT;
                ?MNY_T_BIND_YUANBAO -> ?PM_BIND_YB_LIMIT;
                ?MNY_T_INTEGRAL -> ?PM_INTEGRAL_LIMIT;
                ?MNY_T_VITALITY -> ?PM_VITALITY_LIMIT;
                ?MNY_T_COPPER -> ?PM_COPPER_LIMIT;
                ?MNY_T_CHIVALROUS -> ?PM_CHIVALROUS_LIMIT;
                ?MNY_T_EXP -> ?PM_EXP_LIMIT;
                ?MNY_T_GUILD_CONTRI -> ?PM_GUILD_CONTRI_LIMIT;
                ?MNY_T_QUJING       ->  ?PM_JINGWEN_LIMIT

            end;
        true -> check_money(PS, T)
    end;
check_money(_PS, _) ->
    ?PM_DATA_CONFIG_ERROR.


do_upgrade_quality(PS, Goods) ->
    Quality = lib_goods:get_quality(Goods),
    New_Quality = Quality + 1,

    Lv = lib_goods:get_tpl_lv(Goods),
    DataCfg = data_eq_upgrade_quality:get(Lv, New_Quality),

    case length(DataCfg#upgrade_quality_cfg.money) of
        0 -> skip;
        1 ->
            {MoneyType1, Money1} = lists:nth(1, DataCfg#upgrade_quality_cfg.money),
            player:cost_money(PS, MoneyType1, Money1, [?LOG_EQUIP, "evolve"]);
        2 ->
            {MoneyType1, Money1} = lists:nth(1, DataCfg#upgrade_quality_cfg.money),
            {MoneyType2, Money2} = lists:nth(2, DataCfg#upgrade_quality_cfg.money),
            player:cost_money(PS, MoneyType1, Money1, [?LOG_EQUIP, "evolve"]),
            player:cost_money(PS, MoneyType2, Money2, [?LOG_EQUIP, "evolve"])
    end,

    mod_inv:destroy_goods_WNC(PS, DataCfg#upgrade_quality_cfg.goods_list, [?LOG_EQUIP, "evolve"]),

    BaseEquipAdd = lib_equip:recount_base_equip_add(Goods, lib_goods:get_tpl_data(lib_goods:get_no(Goods)), New_Quality),
    Goods01 = lib_goods:set_show_base_equip_add(Goods,BaseEquipAdd),
    BaseEquipAdd01 =util:duplicate_key_sum_value(BaseEquipAdd) ,
    BaseEquipAdd2 = lib_attribute:to_attrs_record(BaseEquipAdd01),

    Goods3 = lib_goods:set_base_equip_add(Goods01, BaseEquipAdd2),
    AddiEquipAdd = lib_equip:recount_addi_equip_add(Goods3, New_Quality),
    AddiEquipAdd2 = lib_attribute:to_addi_equip_add_attrs_record(AddiEquipAdd),
    Goods3_1 = lib_goods:set_addi_ep_add_kv(Goods3, AddiEquipAdd),
    Goods3_2 = lib_goods:set_addi_equip_add(Goods3_1, AddiEquipAdd2),
    Goods4 = lib_goods:set_battle_power(Goods3_2, lib_equip:recount_battle_power(Goods3_2)),
    Goods5 = lib_goods:set_quality(Goods4, New_Quality),
    Goods6 = lib_goods:set_bind_state(Goods5, ?BIND_ALREADY),
    mod_inv:mark_dirty_flag(player:get_id(PS), Goods6),
    lib_inv:notify_cli_goods_info_change(player:id(PS), Goods6),

    %% 属性计算
	recount_attr_equip_put_on(PS, Goods6),

    lib_log:statis_equip_upgrade_quality(PS, lib_goods:get_no(Goods), integer_to_list(Quality) ++ "_"  ++ integer_to_list(New_Quality)),
    {ok, Goods6}.


check_stren_trs(PS, SrcEqId, ObjEqId) ->
    try check_stren_trs__(PS, SrcEqId, ObjEqId) of
        {ok, SrcEq, ObjEq, DataCfg} ->
            {ok, SrcEq, ObjEq, DataCfg}
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.


check_stren_trs__(PS, SrcEqId, ObjEqId) ->
    ?Ifc (SrcEqId =< 0 orelse ObjEqId =< 0)
        throw(?PM_PARA_ERROR)
    ?End,

    PlayerId = player:id(PS),
    SrcEq = mod_inv:find_goods_by_id_from_bag(PlayerId, SrcEqId),
    ObjEq = mod_inv:find_goods_by_id_from_whole_inv(PlayerId, ObjEqId),
    ?Ifc (SrcEq =:= null orelse ObjEq =:= null)
        throw(?PM_GOODS_NOT_EXISTS)
    ?End,

    StrenLvSrc = lib_goods:get_stren_lv(SrcEq),
    ?Ifc (StrenLvSrc =< 0)
        throw(?PM_GOODS_SRC_EQ_NOT_STREN)
    ?End,

    ?Ifc (not ply_sys_open:is_open(PS, ?SYS_EQ_STREN_TRS))
        throw(?PM_LV_LIMIT)
    ?End,

    StepList = sets:to_list(sets:from_list(data_equip_strenthen:get_all_lv_step_list())),
    ?Ifc (StepList =:= [])
        throw(?PM_DATA_CONFIG_ERROR)
    ?End,

    StepSrc = lib_equip:get_lv_step_for_strenthen(lib_goods:get_tpl_lv(SrcEq),  StepList),
    StepObj = lib_equip:get_lv_step_for_strenthen(lib_goods:get_tpl_lv(ObjEq),  StepList),
    ?Ifc (StepSrc > StepObj)
        throw(?PM_GOODS_TRS_LIMIT)
    ?End,

    Data = data_stren_trs:get(StepSrc, StepObj, StrenLvSrc),
    ?Ifc (Data =:= null)
        throw(?PM_DATA_CONFIG_ERROR)
    ?End,

    ?Ifc (Data#stren_trs_cfg.obj_stren_lv < lib_goods:get_stren_lv(ObjEq))
        throw(?PM_GOODS_TRS_STREN_LV_LIMIT)
    ?End,

    ?Ifc (not player:has_enough_money(PS, ?MNY_T_BIND_GAMEMONEY, Data#stren_trs_cfg.money) )
        throw(?PM_GAMEMONEY_LIMIT)
    ?End,

    {ok, SrcEq, ObjEq, Data}.


% 强化装备属性更新
do_stren_trs(PS, SrcEq, ObjEq, DataCfg) ->
    player:cost_money(PS, ?MNY_T_BIND_GAMEMONEY, DataCfg#stren_trs_cfg.money, [?LOG_EQUIP, "trans_stren"]),

    SrcEq1 = lib_goods:set_stren_exp(SrcEq, 0),
    SrcEq3 = lib_goods:set_stren_lv(SrcEq1, 0),
%%    SrcEq3 = lib_equip:change_equip_stren_attr(SrcEq2),

    SrcEq4 = lib_goods:set_battle_power(SrcEq3, lib_equip:recount_battle_power(SrcEq3)),
    mod_inv:mark_dirty_flag(player:get_id(PS), SrcEq4),
    lib_inv:notify_cli_goods_info_change(player:id(PS), SrcEq4),

    ObjEq1 = lib_goods:set_stren_exp(ObjEq, 0),
    ObjEq2 = lib_goods:set_stren_lv(ObjEq1, DataCfg#stren_trs_cfg.obj_stren_lv),
    ObjEq3 = 
        case lib_goods:get_bind_state(SrcEq3) =:= ?BIND_ALREADY of
            false -> ObjEq2;
            true -> lib_goods:set_bind_state(ObjEq2, ?BIND_ALREADY)
        end,
%%    ObjEq4 = lib_equip:change_equip_stren_attr(ObjEq3),
    ObjEq5 = lib_goods:set_battle_power(ObjEq3, lib_equip:recount_battle_power(ObjEq3)),
    mod_inv:mark_dirty_flag(player:get_id(PS), ObjEq5),
    lib_inv:notify_cli_goods_info_change(player:id(PS), ObjEq5),

    %% 属性计算
	recount_attr_equip_put_on(PS, ObjEq5),

    lib_log:statis_equip_transfer(PS, lib_goods:get_no(SrcEq), lib_goods:get_id(SrcEq), lib_goods:get_stren_lv(SrcEq), 
        lib_goods:get_no(ObjEq), lib_goods:get_id(ObjEq), integer_to_list(lib_goods:get_stren_lv(ObjEq)) ++ "_"  ++ integer_to_list(lib_goods:get_stren_lv(ObjEq5)), 
        ?MNY_T_BIND_GAMEMONEY, DataCfg#stren_trs_cfg.money),

    {ok, ObjEq5}.


check_unload_gemstone(PS, EqGoodsId, GemGoodsId, HoleNo) ->
    try check_unload_gemstone__(PS, EqGoodsId, GemGoodsId, HoleNo) of
        {ok, EqGoods, GemGoods} ->
            {ok, EqGoods, GemGoods}
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.


check_unload_gemstone__(PS, EqGoodsId, GemGoodsId, HoleNo) ->
    ?Ifc (HoleNo =< 0 orelse HoleNo > ?MAX_GEMSTONE_HOLE)
        throw(?PM_PARA_ERROR)
    ?End,

    EqGoods = mod_inv:find_goods_by_id_from_whole_inv(player:get_id(PS), EqGoodsId),
    ?Ifc (EqGoods =:= null)
        throw(?PM_GOODS_NOT_EXISTS)
    ?End,

    GemGoods = mod_inv:find_goods_by_id_from_whole_inv(player:get_id(PS), GemGoodsId),
    ?Ifc (GemGoods =:= null)
        throw(?PM_GOODS_NOT_EXISTS)
    ?End,

    ?ASSERT(lib_goods:get_count(GemGoods) =:= 1, lib_goods:get_count(GemGoods)),
     GemStoneList = lib_goods:get_equip_gemstone(EqGoods),
    ?ASSERT(is_list(GemStoneList), GemStoneList),

    case lists:keyfind(HoleNo, 1, GemStoneList) of
        false -> throw(?PM_GOODS_EQUIP_HOLE_NOT_OPENED);
        {_No, Id} ->
            if
                Id =:= ?INVALID_ID ->
                    throw(?PM_GOODS_EQUIP_NOT_INLAY_GEM);
                Id =/= GemGoodsId ->
                    throw(?PM_PARA_ERROR);
                true ->
                    case mod_inv:check_batch_add_goods(player:id(PS), [GemGoods]) of
                        {fail, Reason} ->
                            throw(Reason);
                        ok ->
                            {ok, EqGoods, GemGoods}
                    end
            end
    end.


do_unload_gemstone(PS, EqGoods, GemGoods, HoleNo) ->
    GemStoneList = lib_goods:get_equip_gemstone(EqGoods),
    case lists:keyfind(HoleNo, 1, GemStoneList) of
        false ->
            ?ASSERT(false, EqGoods),
            {fail, ?PM_UNKNOWN_ERR};
        {_, _} ->
            Location = lib_goods:decide_bag_location(GemGoods),
            GemGoods1 = lib_goods:set_count(GemGoods, 1), %% 确保是返回一个
            mod_inv:smart_add_goods(player:get_id(PS), lib_goods:set_location(GemGoods1, Location)),

            %% 更新物品栏信息
            Inv = mod_inv:get_inventory(player:id(PS)),
            case lib_goods:get_location(GemGoods) of
                ?LOC_BAG_EQ ->
                    BagEqGoodsList = Inv#inv.eq_goods -- [lib_goods:get_id(GemGoods)],
                    mod_inv:update_inventory_to_ets(Inv#inv{eq_goods = BagEqGoodsList});
                ?LOC_PLAYER_EQP ->
                    PlayerEqGoodsList = Inv#inv.player_eq_goods -- [lib_goods:get_id(GemGoods)],
                    mod_inv:update_inventory_to_ets(Inv#inv{player_eq_goods = PlayerEqGoodsList});
                ?LOC_PARTNER_EQP ->
                    PartnerEqGoodsList = Inv#inv.partner_eq_goods -- [lib_goods:get_id(GemGoods)],
                    mod_inv:update_inventory_to_ets(Inv#inv{partner_eq_goods = PartnerEqGoodsList});
                _Any ->
                    ?ASSERT(false, _Any),
                    ?ERROR_MSG("mod_equip:do_unload_gemstone error!~p~n", [_Any])
            end,

            GemStoneList1 = lists:keyreplace(HoleNo, 1, GemStoneList, {HoleNo, ?INVALID_ID}),
            EqGoods1 = lib_goods:set_equip_gemstone(EqGoods, GemStoneList1),
            mod_inv:mark_dirty_flag(player:get_id(PS), EqGoods1),
            lib_inv:notify_cli_goods_info_change(player:id(PS), EqGoods1),

            % ply_attr:recount_all_attrs(imme, PS),
            lib_log:statis_unload_gemstone(PS, lib_goods:get_no(GemGoods), lib_goods:get_id(GemGoods), lib_goods:get_id(EqGoods), HoleNo),

            % 是否是宠物装备
            case lib_goods:get_partner_id(EqGoods) of 
                0 -> ply_attr:recount_all_attrs(imme, PS);
                PartnerId -> 
                    Partner = lib_partner:recount_equip_add_and_total_attrs(player:id(PS), PartnerId),
                    mod_partner:update_partner_to_ets(Partner),

                    case lib_partner:is_fighting(Partner) of
                        true -> ply_attr:recount_battle_power(PS);
                        false -> void
                    end
            end,   



            ok
    end.


check_inlay_gemstone(PS, EqGoodsId, GemGoodsId, HoleNo) ->
    try check_inlay_gemstone__(PS, EqGoodsId, GemGoodsId, HoleNo) of
        {ok, EqGoods, GemGoods} ->
            {ok, EqGoods, GemGoods}
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.


check_inlay_gemstone__(PS, EqGoodsId, GemGoodsId, HoleNo) ->
    ?Ifc (HoleNo =< 0 orelse HoleNo > ?MAX_GEMSTONE_HOLE)
        throw(?PM_PARA_ERROR)
    ?End,

    EqGoods = mod_inv:find_goods_by_id_from_whole_inv(player:get_id(PS), EqGoodsId),
    ?Ifc (EqGoods =:= null)
        throw(?PM_GOODS_NOT_EXISTS)
    ?End,

    % ?Ifc (lib_goods:get_type(EqGoods) =:= ?GOODS_T_PAR_EQUIP)
    %     throw(?PM_PARA_ERROR)
    % ?End,

    GemGoods = mod_inv:find_goods_by_id_from_bag(player:get_id(PS), GemGoodsId),
    ?Ifc (GemGoods =:= null)
        throw(?PM_GOODS_NOT_EXISTS)
    ?End,

    ?Ifc (lib_goods:get_count(GemGoods) < 1)
        throw(?PM_GOODS_NOT_EXISTS)
    ?End,

    ?Ifc (lib_goods:get_slot(GemGoods) =< 0)
        throw(?PM_PARA_ERROR)
    ?End,

    GemStoneList = lib_goods:get_equip_gemstone(EqGoods),
    ?ASSERT(is_list(GemStoneList), GemStoneList),

    GemNo = lib_goods:get_no(GemGoods),
    GemCfg = data_gem_add:get(GemNo),
    ?Ifc (GemCfg =:= null)
        throw(?PM_DATA_CONFIG_ERROR)
    ?End,

    GemTypeList = GemCfg#gem_add.b_type,

    % 判断是否满足宝石位置
    F = fun(Type, Satisfy) ->
        lib_goods:get_subtype(EqGoods) == Type andalso Satisfy
    end,

    IsSatisfy = lists:foldl(F, true, GemTypeList),

    ?Ifc (IsSatisfy)
        throw(?PM_GOODS_EQUIP_NOT_APPLICABLE_GEM)
    ?End,

    %% 调整：判断是否有镶嵌了相同类型的宝石
    % F = fun({_HNo, Id}, Acc) ->
    %     case Id =:= ?INVALID_ID of
    %         true -> Acc;
    %         false ->
    %             case mod_inv:find_goods_by_id_from_whole_inv(player:get_id(PS), Id) of
    %                 null ->
    %                     ?ASSERT(false, {Id, EqGoodsId}),
    %                     Acc;
    %                 TGoods ->
    %                     TGemType = (data_gem_add:get(lib_goods:get_no(TGoods)))#gem_add.b_type,
    %                     case TGemType =:= GemType of
    %                         true -> [TGoods | Acc];
    %                         false -> 
    %                             Acc
    %                     end
    %             end
    %     end
    % end,

    % GemGoodsList = lists:foldl(F, [], GemStoneList),
    % ?Ifc (GemGoodsList =/= [])
    %     throw(?PM_GOODS_EQUIP_INLAY_SAME_GEM)
    % ?End,

    case lists:keyfind(HoleNo, 1, GemStoneList) of
        false -> throw(?PM_GOODS_EQUIP_HOLE_NOT_OPENED);
        _Any -> {ok, EqGoods, GemGoods}
    end.


do_inlay_gemstone(PS, EqGoods, GemGoods, HoleNo) ->
    GemStoneList = lib_goods:get_equip_gemstone(EqGoods),
    case lists:keyfind(HoleNo, 1, GemStoneList) of
        false ->
            ?ASSERT(false, EqGoods),
            {fail, ?PM_UNKNOWN_ERR};
        {_, Id} ->
            %% 从背包移除物品
            mod_inv:remove_goods_from_bag(player:id(PS), GemGoods),
            lib_inv:notify_cli_goods_destroyed_from_bag(player:id(PS), lib_goods:get_id(GemGoods), lib_goods:decide_bag_location(GemGoods)),
            DelGemIdList = 
                case Id =:= ?INVALID_ID of
                    true -> [];
                    false ->
                        case mod_inv:find_goods_by_id_from_whole_inv(player:get_id(PS), Id) of
                            null ->
                                ?ASSERT(false, Id),
                                [];
                            OldGem ->
                                % mod_inv:add_goods_to_bag(player:get_id(PS), OldGem, [?LOG_SKIP])
                                Location = lib_goods:decide_bag_location(OldGem),
                                mod_inv:smart_add_goods(player:get_id(PS), lib_goods:set_location(OldGem, Location)),
                                [lib_goods:get_id(OldGem)]
                        end
                end,

            case lib_goods:get_count(GemGoods) > 1 of
                false ->
                    %% 放在装备上
                    GemGoods1 = lib_goods:set_slot(GemGoods, ?INVALID_NO),
                    GemGoods2 = lib_goods:set_location(GemGoods1, lib_goods:get_location(EqGoods)),
                    % ?DEBUG_MSG("mod_equip:do_inlay_gemstone() Gem Location:~p slot:~p ~n", [lib_goods:get_location(GemGoods2), lib_goods:get_slot(GemGoods2)]),
                    mod_inv:mark_dirty_flag(player:get_id(PS), GemGoods2),
                    lib_inv:notify_cli_goods_info_change(player:id(PS), GemGoods2);
                true ->
                    %% 放在装备上
                    GemGoods1 = lib_goods:set_slot(GemGoods, ?INVALID_NO),
                    GemGoods2 = lib_goods:set_location(GemGoods1, lib_goods:get_location(EqGoods)),
                    GemGoods3 = lib_goods:set_count(GemGoods2, 1),
                    mod_inv:mark_dirty_flag(player:get_id(PS), GemGoods3),
                    lib_inv:notify_cli_goods_info_change(player:id(PS), GemGoods3),

                    %% 把剩余的宝石重新放入背包
                    GemLeft = lib_goods:set_count(GemGoods, lib_goods:get_count(GemGoods) - 1),
                    GemLeft1 = lib_goods:set_slot(GemLeft, ?INVALID_NO),
                    NewGoodsId = lib_goods:db_insert_new_goods(GemLeft1),
                    GemLeft2 = lib_goods:set_id(GemLeft1, NewGoodsId),
                    % mod_inv:add_goods_to_bag(player:get_id(PS), GemLeft2, [?LOG_SKIP])
                    mod_inv:smart_add_goods(player:get_id(PS), GemLeft2)
            end,

            %% 更新物品栏信息
            Inv = mod_inv:get_inventory(player:id(PS)),
            case lib_goods:get_location(EqGoods) of
                ?LOC_BAG_EQ ->
                    BagEqGoodsList = [lib_goods:get_id(GemGoods) | Inv#inv.eq_goods],
                    BagEqGoodsList1 = BagEqGoodsList -- DelGemIdList,
                    mod_inv:update_inventory_to_ets(Inv#inv{eq_goods = sets:to_list(sets:from_list(BagEqGoodsList1))});
                ?LOC_PLAYER_EQP ->
                    PlayerEqGoodsList = [lib_goods:get_id(GemGoods) | Inv#inv.player_eq_goods],
                    PlayerEqGoodsList1 = PlayerEqGoodsList -- DelGemIdList,
                    mod_inv:update_inventory_to_ets(Inv#inv{player_eq_goods = sets:to_list(sets:from_list(PlayerEqGoodsList1))});
                ?LOC_PARTNER_EQP ->
                    PartnerEqGoodsList = [lib_goods:get_id(GemGoods) | Inv#inv.partner_eq_goods],
                    PartnerEqGoodsList1 = PartnerEqGoodsList -- DelGemIdList,
                    mod_inv:update_inventory_to_ets(Inv#inv{partner_eq_goods = sets:to_list(sets:from_list(PartnerEqGoodsList1))});
                _Any ->
                    ?ASSERT(false, _Any),
                    ?ERROR_MSG("mod_equip:do_inlay_gemstone error!~p~n", [_Any])
            end,

            %% 更新装备信息
            GemStoneList1 = lists:keyreplace(HoleNo, 1, GemStoneList, {HoleNo, lib_goods:get_id(GemGoods)}),
            EqGoods1 = lib_goods:set_equip_gemstone(EqGoods, GemStoneList1),
            EqGoods2 = 
                case lib_goods:get_bind_state(GemGoods) of
                    ?BIND_ALREADY -> lib_goods:set_bind_state(EqGoods1, ?BIND_ALREADY);
                    _ -> EqGoods1
                end,
            mod_inv:mark_dirty_flag(player:get_id(PS), EqGoods2),

            lib_inv:notify_cli_goods_info_change(player:id(PS), EqGoods2),

            lib_event:event(inlay_gemstone, [], PS),            
            % 指定等级的宝石成就
            mod_achievement:notify_achi(inlay_gemstone,[{gem_lv,lib_goods:get_lv(GemGoods)}], PS),
            mod_achievement:notify_achi(inlay_gemstone,[], PS),

            lib_log:statis_inlay_gemstone(PS, lib_goods:get_no(GemGoods), lib_goods:get_id(GemGoods), lib_goods:get_id(EqGoods), HoleNo, lib_goods:get_no(EqGoods)),
            
            % 是否是宠物装备
            case lib_goods:get_partner_id(EqGoods) of 
                0 -> ply_attr:recount_all_attrs(imme, PS);
                PartnerId -> 
                    Partner = lib_partner:recount_equip_add_and_total_attrs(player:id(PS), PartnerId),
                    mod_partner:update_partner_to_ets(Partner),

                    case lib_partner:is_fighting(Partner) of
                        true -> ply_attr:recount_battle_power(PS);
                        false -> void
                    end
            end,            

            ok
    end.


check_open_gemstone_hole(PS, GoodsId, HoleNo) ->
    try check_open_gemstone_hole__(PS, GoodsId, HoleNo) of
        {ok, Goods, NeedGoodsList} ->
            {ok, Goods, NeedGoodsList}
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

check_open_gemstone_hole__(PS, GoodsId, HoleNo) ->
    ?Ifc (HoleNo =< 0 orelse HoleNo > ?MAX_GEMSTONE_HOLE)
        throw(?PM_PARA_ERROR)
    ?End,
    Goods = mod_inv:find_goods_by_id_from_whole_inv(player:get_id(PS), GoodsId),
    ?Ifc (Goods =:= null)
        throw(?PM_GOODS_NOT_EXISTS)
    ?End,

    ?Ifc (not lib_goods:is_equip(Goods))
        throw(?PM_GOODS_NOT_EQUIP)
    ?End,

    GemStoneList = lib_goods:get_equip_gemstone(Goods),
    ?ASSERT(is_list(GemStoneList), GemStoneList),
    HoleCount = length(GemStoneList),
    ?Ifc (HoleCount >= ?MAX_GEMSTONE_HOLE)
        throw(?PM_GOODS_EQUIP_GEM_HOLE_LIMIT)
    ?End,

    DataCfg = data_equip_open_hole:get(HoleCount + 1),
    ?Ifc (DataCfg =:= null)
        throw(?PM_DATA_CONFIG_ERROR)
    ?End,

    case lists:keyfind(HoleNo, 1, GemStoneList) of
        false ->
            case mod_inv:check_batch_destroy_goods(player:id(PS), DataCfg#equip_open_hole.need_goods_list) of
                {fail, _Reason} ->
                    throw(?PM_GOODS_NOT_ENOUGH);
                ok -> {ok, Goods, DataCfg#equip_open_hole.need_goods_list}
            end;
        {_No, _Id} ->
            throw(?PM_GOODS_EQUIP_GEM_HOLE_OPENED)
    end.

do_open_gemstone_hole(PS, Goods, HoleNo, NeedGoodsList) ->
    mod_inv:destroy_goods_WNC(player:id(PS), NeedGoodsList, [?LOG_EQUIP, "hole"]),
    GemStoneList = lib_goods:get_equip_gemstone(Goods),
    GemStoneList1 = [{HoleNo, 0} | GemStoneList],
    Goods1 = lib_goods:set_equip_gemstone(Goods, GemStoneList1),
    mod_inv:mark_dirty_flag(player:get_id(PS), Goods1),
    lib_inv:notify_cli_goods_info_change(player:id(PS), Goods1),
    ok.

% 检测转换道具需要的银子是否足够
check_money_for_change_goods(PS, Data) ->
    ?DEBUG_MSG("ASSERT FAILED!!! DATA=~w",[Data]),

    %{compose_goods,950009,5,[70287],[{1,10000}],[{70107,70117,70127,70137,70147,70247,70257,70267,70287,70297,70307,70317,70327,70337}]}

    %%  no = 0,
    %%  op_no = 0,
    %%  need_goods_list = [],
    %%  money = [],
    %%  get_goods_list = []     
    case Data#compose_goods.money of
        [] ->
            ok;
        [{MoneyType, Count}] ->
            Ret = 
            case player:has_enough_money(PS,MoneyType,Count) of
                false ->
                    case MoneyType of
                        ?MNY_T_GAMEMONEY -> ?PM_GAMEMONEY_LIMIT;
                        ?MNY_T_YUANBAO -> ?PM_YB_LIMIT;
                        ?MNY_T_BIND_GAMEMONEY -> ?PM_BIND_GAMEMONEY_LIMIT;
                        ?MNY_T_BIND_YUANBAO -> ?PM_BIND_YB_LIMIT;
                        ?MNY_T_VITALITY -> ?PM_VITALITY_LIMIT;
                        ?MNY_T_COPPER -> ?PM_COPPER_LIMIT;
                        ?MNY_T_CHIVALROUS -> ?PM_CHIVALROUS_LIMIT;
                        ?MNY_T_EXP -> ?PM_EXP_LIMIT;
                        ?MNY_T_GUILD_CONTRI -> ?PM_GUILD_CONTRI_LIMIT
                    end;
                true -> 
                    ok
            end,

            Ret
    end.
    

% return 0 | ?PM_GAMEMONEY_LIMIT | PM_YB_LIMIT | PM_BIND_GAMEMONEY_LIMIT | PM_BIND_YB_LIMIT
check_money_for_compose_goods(PS, GoodsNo, GoodsCount) when is_integer(GoodsNo) ->
    ComposeCfg = data_compose_goods:get(GoodsNo),
    F = fun({Type, Cnt}) ->
        {Type, Cnt * GoodsCount}
    end,
    Money = [F(X) || X <- ComposeCfg#compose_goods.money],
    check_money_for_compose_goods(PS, Money).


check_money_for_compose_goods(_PS, []) ->

    0;
check_money_for_compose_goods(PS, [{MoneyType, Count} | T]) ->
    case player:has_enough_money(PS, MoneyType, Count) of
        false ->
            case MoneyType of
                ?MNY_T_GAMEMONEY -> ?PM_GAMEMONEY_LIMIT;
                ?MNY_T_YUANBAO -> ?PM_YB_LIMIT;
                ?MNY_T_BIND_GAMEMONEY -> ?PM_BIND_GAMEMONEY_LIMIT;
                ?MNY_T_BIND_YUANBAO -> ?PM_BIND_YB_LIMIT;
                ?MNY_T_VITALITY -> ?PM_VITALITY_LIMIT;
                ?MNY_T_COPPER -> ?PM_COPPER_LIMIT;
                ?MNY_T_CHIVALROUS -> ?PM_CHIVALROUS_LIMIT;
                ?MNY_T_EXP -> ?PM_EXP_LIMIT;
                ?MNY_T_GUILD_CONTRI -> ?PM_GUILD_CONTRI_LIMIT
            end;
        true -> check_money_for_compose_goods(PS, T)
    end.

cost_money_for_compose_goods(PS, GoodsNo, GoodsCount) when is_integer(GoodsNo) ->
    ComposeCfg = data_compose_goods:get(GoodsNo),
    F = fun({Type, Cnt}) ->
        {Type, Cnt * GoodsCount}
    end,
    Money = [F(X) || X <- ComposeCfg#compose_goods.money],
    cost_money_for_compose_goods(PS, Money).

cost_money_for_compose_goods(_PS, []) ->
    ok;
cost_money_for_compose_goods(PS, [{MoneyType, Count} | T]) ->
    player:cost_money(PS, MoneyType, Count, [?LOG_GOODS, "synthetise"]),
    cost_money_for_compose_goods(PS, T).

cost_money_for_change_goods(_PS, []) ->
    ok;
cost_money_for_change_goods(PS, [{MoneyType, Count} | T]) ->
    player:cost_money(PS, MoneyType, Count, [?LOG_GOODS, "change_goods"]),
    cost_money_for_change_goods(PS, T).


check_equip_decompose(PS, IdList) ->
    case check_equip_decompose__(PS, IdList) of
        {ok, Goods, GoodsList} ->
            {ok, Goods, GoodsList};
        {fail, FailReason} ->
            {fail, FailReason}
    end.


check_equip_decompose__(PS, IdList) ->
    case IdList =:= [] of
        true ->
            {fail, ?PM_GOODS_NOT_EXISTS};
        false ->
            get_equip_decompose_goods(IdList, [], [], PS)
    end.

get_equip_decompose_goods([GoodsId|T], GoodsList, AddGoodsList, PS) ->
    Goods = mod_inv:find_goods_by_id_from_bag(player:get_id(PS), GoodsId),
    case Goods =:= null of
        true ->
            {fail, ?PM_GOODS_NOT_EXISTS};
        false ->
            case (not lib_goods:is_equip(Goods)) of
                true ->
                    {fail, ?PM_PARA_ERROR};
                false ->
                    Quality = lib_goods:get_quality(Goods),
                    Lv = lib_goods:get_tpl_lv(Goods),
                    DataBase = data_equip_decompose_base:get(Lv),
                    case DataBase =:= null of
                        true ->
                            {fail, ?PM_PARA_ERROR};
                        false ->
                            GoodsListBase =
                                case Quality of
                                    ?QUALITY_WHITE -> DataBase#equip_decompose_base.goods_list_1;
                                    ?QUALITY_GREEN -> DataBase#equip_decompose_base.goods_list_2;
                                    ?QUALITY_BLUE -> DataBase#equip_decompose_base.goods_list_3;
                                    ?QUALITY_PURPLE -> DataBase#equip_decompose_base.goods_list_4;
                                    ?QUALITY_ORANGE -> DataBase#equip_decompose_base.goods_list_5;
                                    ?QUALITY_RED -> DataBase#equip_decompose_base.goods_list_6
                                end,

                            NewGoodsListBase = AddGoodsList ++ GoodsListBase,
                            case mod_inv:check_batch_add_goods(player:id(PS), NewGoodsListBase) of
                                {fail, Reason} ->
                                    {fail, Reason};
                                ok ->
                                    NewGoodsList = [Goods|GoodsList],
                                    get_equip_decompose_goods(T, NewGoodsList, NewGoodsListBase, PS)
                            end
                    end
            end
    end;

get_equip_decompose_goods([], GoodsList, AddGoodsList, _PS) ->
    {ok, GoodsList, AddGoodsList}.

get_lv_step_for_decompose(_Lv, []) ->
    ?ASSERT(false),
    ?INVALID_NO;
get_lv_step_for_decompose(Lv, [Step | T]) ->
    case data_equip_decompose_add:get(Step) of
        null ->
            get_lv_step_for_decompose(Lv, T);
        DataList ->
            Rd = erlang:hd(DataList),
            Range = Rd#equip_decompose_add.lv_range,
            case util:in_range(Lv, lists:nth(1, Range), lists:nth(2, Range)) of
                true ->
                    Step;
                false ->
                    get_lv_step_for_decompose(Lv, T)
            end
    end.


do_equip_decompose(PS, DelGoodsList, GoodsList) ->
    F = fun(Goods) ->
            mod_inv:destroy_goods_WNC(player:id(PS), Goods, lib_goods:get_count(Goods), [?LOG_EQUIP, "release"])
        end,
    lists:foreach(F, DelGoodsList),
    {ok,RetGoods} = mod_inv:batch_smart_add_new_goods(player:id(PS), GoodsList, [{bind_state, ?BIND_ALREADY}], [?LOG_EQUIP, "release"]),

    % 增加分解提示
    F1 = fun({Id, No, Cnt}) ->
            case mod_inv:find_goods_by_id_from_bag(player:id(PS), Id) of
                null -> skip;
                Goods1 ->
                    ply_tips:send_sys_tips(PS, {get_goods, [No, lib_goods:get_quality(Goods1), Cnt,Id]})
            end
    end,
    [F1(X) || X <- RetGoods],


    % ?DEBUG_MSG("Goods = ~p,release =~p",[Goods,GoodsList]),

    % case GoodsList =:= [] of
    %     true -> mod_inv:batch_smart_add_new_goods(player:id(PS), BaseGoodsL, [?LOG_EQUIP, "release"]);
    %     false -> skip
    % end,

    mod_achievement:notify_achi(equip_decompose, [], PS),
    lib_event:event(equip_decompose, [], PS),
    ok.

check_goods_smelt(PS, GoodsList) ->
    try 
        check_goods_smelt__(PS, GoodsList)
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

%% GoodsList -> [{GoodsNo, BindState}] Count 默认是1
check_goods_smelt__(PS, GoodsList) ->
    ?Ifc (length(GoodsList) =/= 4)
        throw(?PM_PARA_ERROR)
    ?End,
    
    No = get_smelt_no_by_goods(GoodsList),
    ?Ifc (No =:= ?INVALID_NO)
        throw(?PM_PARA_ERROR)
    ?End,

    Data = data_compose_goods:get(No),
    ?Ifc (Data =:= null)
        throw(?PM_DATA_CONFIG_ERROR)
    ?End,

    RetMoney = check_money(PS, Data#compose_goods.money),

    ?Ifc (RetMoney =/= 0)
        throw(RetMoney)
    ?End,

    F = fun({GoodsNo, State}, Acc) ->
        case State =:= ?BIND_NEVER of
            true -> [{GoodsNo, State} | Acc];
            false -> Acc
        end
    end,
    List = lists:foldl(F, [], GoodsList),

    F1 = fun({GoodsNo, State}, Acc) ->
        case State =:= ?BIND_ALREADY of
            true -> [{GoodsNo, State} | Acc];
            false -> Acc
        end
    end,
    BList = lists:foldl(F1, [], GoodsList),

    GoodsList1 = [{GoodsNo, 1, BindState} || {GoodsNo, BindState} <- List],
    BGoodsList = [{GoodsNo, 1, BindState} || {GoodsNo, BindState} <- BList],

    ?DEBUG_MSG("mod_equip:check_goods_smelt__:GoodsList1:~w~n", [GoodsList1]),
    case mod_inv:check_batch_destroy_goods(PS, GoodsList1) of
        {fail, Reason} ->
            throw(Reason);
        ok -> 
            case mod_inv:check_batch_destroy_goods(PS, BGoodsList) of
                {fail, Reason1} ->
                    throw(Reason1);
                ok ->
                    {ok, Data, GoodsList1, BGoodsList}
            end
    end.


%% GoodsList -> [{GoodsNo, Count, BindState}]
do_goods_smelt(PS, GoodsList, BGoodsList, DataCfg) ->
    case length(DataCfg#compose_goods.money) of
        0 -> skip;
        1 ->
            {MoneyType1, Money1} = lists:nth(1, DataCfg#compose_goods.money),
            player:cost_money(PS, MoneyType1, Money1, [?LOG_GOODS, "synthetise"]);
        2 ->
            {MoneyType1, Money1} = lists:nth(1, DataCfg#compose_goods.money),
            {MoneyType2, Money2} = lists:nth(2, DataCfg#compose_goods.money),
            player:cost_money(PS, MoneyType1, Money1, [?LOG_GOODS, "synthetise"]),
            player:cost_money(PS, MoneyType2, Money2, [?LOG_GOODS, "synthetise"])
    end,
    
    BindState = 
        case BGoodsList =:= [] of
            true -> ?BIND_NEVER;
            false -> ?BIND_ALREADY
        end,

    mod_inv:destroy_goods_WNC(PS, GoodsList, [?LOG_GOODS, "synthetise"]),
    mod_inv:destroy_goods_WNC(PS, BGoodsList, [?LOG_GOODS, "synthetise"]),
    
    RandNum = util:rand(1, length(DataCfg#compose_goods.get_goods_list)),
    {GoodsNo, Count} = lists:nth(RandNum,  DataCfg#compose_goods.get_goods_list),
    %% {ok, [{GoodsId, GoodsNo, GoodsCount}]}  |  {fail, Reason}
    case mod_inv:batch_smart_add_new_goods(player:id(PS), [{GoodsNo, Count}], [{bind_state, BindState}], [?LOG_GOODS, "synthetise"]) of
        {fail, _} ->
            ?ERROR_MSG("mod_equip:batch_smart_add_new_goods error~w~n", [{GoodsNo, Count}]),
            {ok, DataCfg#compose_goods.op_no, ?INVALID_ID};
        {ok, RetGoodsList} ->
            RetGoodsId = 
                case RetGoodsList =:= [] of
                    true -> ?INVALID_ID;
                    false -> 
                        {TGoodsId, _, _} = erlang:hd(RetGoodsList),
                        TGoodsId
                end,
            {ok, DataCfg#compose_goods.op_no, RetGoodsId}
    end.

    


check_compose_goods(PS, GoodsNo, Count, UseBindGoods) ->
    try check_compose_goods__(PS, GoodsNo, Count, UseBindGoods) of
        {ok, GoodsList} ->
            {ok, GoodsList}
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

check_equip_build(PS,GoodsNo,Type) ->
    try check_equip_build__(PS, GoodsNo, Type) of
        ok ->
            ok
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

% 检测转换道具需要的银子是否足够
check_money_for_build(PS, Data) ->
    PriceType = Data#goods_build_tpl.price_type,
    Price = Data#goods_build_tpl.price, 

    Ret = player:check_need_price(PS,PriceType,Price),
    Ret.

% 获得打造需要的材料
get_build_need(PS,Data) when is_record(Data,goods_build_tpl) ->
    GoodsType = 3,

    {OreType,OLv} = Data#goods_build_tpl.ore,
    {RuneType,RLv} = Data#goods_build_tpl.rune,

    {SuperGoodsNo,Count} = Data#goods_build_tpl.super_goods,

    Olist = mod_inv:find_all_goods_by_type_and_sub(PS,GoodsType,OreType),
    Rlist = mod_inv:find_all_goods_by_type_and_sub(PS,GoodsType,RuneType),

    FO = fun(Goods) when is_record(Goods,goods) ->
        GoodsNo = Goods#goods.no,
        GoodsTpl = lib_goods:get_tpl_data(GoodsNo),
        GoodsTpl#goods_tpl.lv >= OLv
    end,
    FR = fun(Goods) when is_record(Goods,goods) ->
        GoodsNo = Goods#goods.no,
        GoodsTpl = lib_goods:get_tpl_data(GoodsNo),
        GoodsTpl#goods_tpl.lv >= RLv
    end,

    Olist1 = lists:filter(FO,Olist),
    Rlist1 = lists:filter(FR,Rlist),

    Fsort = fun(GoodsA, GoodsB) ->
        GoodsANo = GoodsA#goods.no,
        GoodsATpl = lib_goods:get_tpl_data(GoodsANo),
        GoodsBNo = GoodsB#goods.no,
        GoodsBTpl = lib_goods:get_tpl_data(GoodsBNo),

        GoodsATpl#goods_tpl.lv > GoodsBTpl#goods_tpl.lv
    end,

    Olist2 = lists:sort(Fsort, Olist1),
    Rlist2 = lists:sort(Fsort, Rlist1),

    % ?DEBUG_MSG("Plist2=~p,Olist2=~p,Rlist2=~p",[Plist2,Olist2,Rlist2]),

    if 
        Olist2 == [] orelse Rlist2 == [] ->
            {null,null};
        true ->
            {Ore1,Rune1} = {lists:last(Olist2),lists:last(Rlist2)},
            {Ore1#goods.no,Rune1#goods.no}
    end.

% 检测装备打造相关
check_equip_build__(PS, GoodsNo, Type) ->
    Data = data_goods_build:get(GoodsNo),

    ?Ifc(Data =:= null)
        throw(?PM_PARA_ERROR)
    ?End,

    RetMoney = check_money_for_build(PS, Data),

    ?Ifc (RetMoney =/= ok)
        throw(RetMoney)
    ?End,

    ?Ifc (RetMoney =/= ok)
        throw(RetMoney)
    ?End,

    {Ore,Rune} = get_build_need(PS,Data),
    ?DEBUG_MSG("Ore1=~p,Rune1=~p",[Ore,Rune]),

    ?Ifc (Ore == Rune)
        throw(?PM_GOODS_SRC_EQ_NOT_BUILD)
    ?End,

    {SuperGoodsNo,Count} = Data#goods_build_tpl.super_goods,

    % 判断是否有足够消耗的道具

    case mod_inv:check_batch_destroy_goods(PS, [{Rune,1}]) of
        {fail, Reason____} ->
            throw(Reason____);
        ok ->
            ?DEBUG_MSG("Rune Ok = ~p",[Rune])
    end,

    case mod_inv:check_batch_destroy_goods(PS, [{Ore,1}]) of
        {fail, Reason_} ->
            throw(Reason_);
        ok ->
            ?DEBUG_MSG("Ore Ok = ~p",[Ore])
    end,

    case Type of
        0 ->
            % ?DEBUG_MSG("Type Is 0",[]),
            ok;
        _ ->
            % ?DEBUG_MSG("Type Is ~p",[Type]),
            case mod_inv:check_batch_destroy_goods(PS, [{SuperGoodsNo,Count}]) of
                {fail, Reason__} ->
                    throw(Reason__);
                ok ->
                    ok
            end
    end,

    % 判断能否添加道具
    case mod_inv:check_batch_add_goods(player:id(PS), [{GoodsNo, 1}]) of
        {fail, Reason___} ->
            throw(Reason___);
        ok ->
            ok
    end.

check_change_goods(PS, GoodsId, GoodsNo) ->
    try check_change_goods__(PS, GoodsId, GoodsNo) of
        ok ->
            ok
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

% 检测是否满足装备转换
check_change_goods__(PS, GoodsId, TargetGoodsNo) ->
    GoodsNo = lib_goods:get_no_by_id(GoodsId),
    Data = get_change_item_config(GoodsNo),

    ?Ifc(Data =:= null)
        throw(?PM_PARA_ERROR)
    ?End,

    RetMoney = check_money_for_change_goods(PS, Data),

    ?Ifc (RetMoney =/= ok)
        throw(RetMoney)
    ?End,

    ?DEBUG_MSG("check_change_goods__ TargetGoodsNo:~p, GoodsNo:~p,GoodsId:~p~n",[TargetGoodsNo,GoodsNo,GoodsId]),

    case mod_inv:check_batch_destroy_goods(PS, [{GoodsNo,1}]) of
        {fail, Reason} ->
            throw(Reason);
        ok ->
            case mod_inv:check_batch_add_goods(player:id(PS), [{TargetGoodsNo, 1}]) of
                {fail, Reason} ->
                    throw(Reason);
                ok ->
                    ok
            end
    end.



check_compose_goods__(PS, GoodsNo, Count, UseBindGoods) ->
    ?Ifc (Count =< 0)
        throw(?PM_PARA_ERROR)
    ?End,
    
    ComposeCfg = data_compose_goods:get(GoodsNo),
    ?Ifc(ComposeCfg =:= null)
        throw(?PM_PARA_ERROR)
    ?End,

    RetMoney = check_money_for_compose_goods(PS, GoodsNo, Count),

    ?Ifc (RetMoney =/= 0)
        throw(RetMoney)
    ?End,

    ?Ifc (not lists:member(UseBindGoods, [0, 1, 2, 3]))
        throw(?PM_PARA_ERROR)
    ?End,

    BindState = 
        case UseBindGoods of
            0 -> ?BIND_NEVER;
            1 -> ?BIND_ALREADY;
            _ -> 0
        end,

    %% 批量合成不支持 同时使用绑定与非绑定的 宝石
    ?Ifc (BindState =:= 0 andalso Count > 1)
        throw(?PM_PARA_ERROR)
    ?End,

    F = fun({No, Cnt}) ->
        if
            BindState =:= 0 ->
                {No, Cnt * Count};
            true ->
                {No, Cnt * Count, BindState}
        end
    end,


    GoodsList = [F(X) || X <- ComposeCfg#compose_goods.need_goods_list],
    io:format("GoodsNo====~p,GoodsList====~p~n",[GoodsNo,GoodsList]),

    case mod_inv:check_batch_destroy_goods(PS, GoodsList) of
        {fail, Reason} ->
            throw(Reason);
        ok ->
            case mod_inv:check_batch_add_goods(player:id(PS), [{GoodsNo, Count}]) of
                {fail, Reason} ->
                    throw(Reason);
                ok ->
                    {ok, GoodsList}
            end
    end.

do_change_goods(PS, GoodsId, TargetGoodsNo) ->
    GoodsNo = lib_goods:get_no_by_id(GoodsId),
    Data = get_change_item_config(GoodsNo),
    cost_money_for_change_goods(PS,Data#compose_goods.money),

    Goods = lib_goods:get_goods_by_id(GoodsId),
    BindState = lib_goods:get_bind_state(Goods),
    Quality = lib_goods:get_quality(Goods),

    CurStrenLv = lib_goods:get_stren_lv(Goods),

    mod_inv:destroy_goods_WNC(player:id(PS), Goods,1,[?LOG_GOODS, "change_goods"]),
    case mod_inv:batch_smart_add_new_goods(player:id(PS), [{TargetGoodsNo, 1}], [{bind_state, BindState},{quality,Quality},{strenlv,CurStrenLv}], [?LOG_GOODS, "change_goods"]) of
        {fail, Reason} ->
            ?ERROR_MSG("mod_equip:do_change_goods(),PlayerId:~p,Reason:~p~n", [player:id(PS), Reason]);
        {ok, _GoodsList} ->   
            skip
    end,
    ok.

% 执行装备打造
do_equip_build(PS,GoodsNo,Type) ->
    Data = data_goods_build:get(GoodsNo),

    PriceType = Data#goods_build_tpl.price_type,
    Price = Data#goods_build_tpl.price,

    % 扣除游戏币
    player:cost_money(PS, PriceType, Price, [?LOG_GOODS, "equip_build"]),

    {Ore,Rune} = get_build_need(PS,Data),
    {SuperGoodsNo,Count} = Data#goods_build_tpl.super_goods,

    % 扣除道具1
    mod_inv:destroy_goods_WNC(player:id(PS), [{Ore, 1}], [?LOG_GOODS, "equip_build"]),
    mod_inv:destroy_goods_WNC(player:id(PS), [{Rune, 1}], [?LOG_GOODS, "equip_build"]),

    ?Ifc(Type /= 0)
        mod_inv:destroy_goods_WNC(player:id(PS), [{SuperGoodsNo, Count}], [?LOG_GOODS, "equip_build"])
    ?End,

%%    AllList = [
%%        [{3,30},{4,100},{5,120},{6,20}],
%%        [{1,500},{2,500},{3,500},{4,50},{5,10},{6,1}]
%%    ],

    % aa
    L = 
    case Type of
        1 -> 
            Data#goods_build_tpl.super_quality_weight;
        _ ->
            Data#goods_build_tpl.quality_weight
    end,

    F = fun({Q,W},Acc) ->
        Acc + W
    end,   

    Range = lists:foldl(F,0,L),
    RandNum = util:rand(1,Range),

    
    F1 = fun({Q,W},Acc = {R,A,Q1}) ->
        case (R >= A andalso R < A+W) of
            true -> 
                {R,A + W,Q};
            false ->
                {R,A + W,Q1}
        end
    end,

    {_,_,Quality} = lists:foldl(F1,{RandNum,0,1},L),

    % % 最大品质
    % MaxQuality =
    %     case Type of 
    %         1 -> 5;
    %         _ -> 3
    %     end,

    % % 最小品质
    % MinQuality =
    %     case Type of 
    %         1 -> 4;
    %         _ -> 1
    %     end,

    % Quality = util:rand(MinQuality,MaxQuality),

    % 给予道具
    ExtraInitInfo = [{quality,Quality}],
    mod_inv:add_new_goods_to_bag_by_build(player:id(PS), GoodsNo, 1, ExtraInitInfo).

do_compose_goods(PS, GoodsNo, Count, UseBindGoods, GoodsList) ->
    cost_money_for_compose_goods(PS, GoodsNo, Count),

    ComposeCfg = data_compose_goods:get(GoodsNo),

    F = fun(Para, {Acc, AccB}) ->
        case Para of
            {No, Cnt} ->
                if
                    UseBindGoods =:= 2 -> %% 优先使用非绑定
                        FisrtCount = mod_inv:get_goods_count_in_bag(player:id(PS), No, ?BIND_NEVER),
                        case FisrtCount >= Cnt of
                            true -> {[{No, Cnt, ?BIND_NEVER} | Acc], AccB};
                            false -> {[{No, FisrtCount, ?BIND_NEVER} | Acc], [{No, max(Cnt - FisrtCount, 0), ?BIND_ALREADY} | AccB]}
                        end;
                    UseBindGoods =:= 3 -> %% 3  优先使用绑定
                        FisrtCount = mod_inv:get_goods_count_in_bag(player:id(PS), No, ?BIND_ALREADY),
                        case FisrtCount >= Cnt of
                            true -> {Acc, [{No, Cnt, ?BIND_ALREADY} | AccB]};
                            false -> {[{No, max(Cnt - FisrtCount, 0), ?BIND_NEVER} | Acc], [{No, FisrtCount, ?BIND_ALREADY} | AccB]}
                        end;
                    true ->
                        ?ASSERT(false, UseBindGoods),
                        ?ERROR_MSG("mod_equip:do_compose_goods error!~p~n", [UseBindGoods]),
                        {Acc, AccB}
                end;
            {No, Cnt, State} ->
                case State of
                    ?BIND_ALREADY -> {Acc, [{No, Cnt, State} | AccB]};
                    ?BIND_NEVER -> {[{No, Cnt, State} | Acc], AccB}
                end
        end
    end,

    {GoodsList1, BGoodsList} = lists:foldl(F, {[], []}, GoodsList),
    case GoodsList1 =:= [] of
        true -> skip;
        false -> mod_inv:destroy_goods_WNC(PS, GoodsList1, [?LOG_GOODS, "synthetise"])
    end,

    case BGoodsList =:= [] of
        true -> skip;
        false -> mod_inv:destroy_goods_WNC(PS, BGoodsList, [?LOG_GOODS, "synthetise"])
    end,

    BindState = 
        case BGoodsList =:= [] of
            true -> ?BIND_NEVER;
            false -> ?BIND_ALREADY
        end,

    case mod_inv:batch_smart_add_new_goods(player:id(PS), [{GoodsNo, Count}], [{bind_state, BindState}], [?LOG_GOODS, "synthetise"]) of
        {fail, Reason} ->
            ?ERROR_MSG("mod_equip:do_compose_goods(),PlayerId:~p,Reason:~p~n", [player:id(PS), Reason]);
        {ok, _GoodsList} ->
            skip
    end,

    lib_event:event(compose_goods, [], PS),
    {ok, ComposeCfg#compose_goods.op_no}.

% 判断装备幻化
check_equip_transmogrify(PS, TargetGoodsId, GoodsId, Type) ->
    try check_equip_transmogrify__(PS, TargetGoodsId, GoodsId, Type) of
        ok ->
            ok
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

check_equip_transmogrify__(PS, TargetGoodsId, GoodsId, Type) ->

    TarGoods = lib_goods:get_goods_by_id(TargetGoodsId),
    Goods = lib_goods:get_goods_by_id(GoodsId),

    ?Ifc(Goods =:= null)
        throw(?PM_EQUIP_NOT_EXISTS)		%% 材料装备不存在
    ?End,

    ?Ifc(Goods =:= null)
        throw(?PM_TAR_EQUIP_NOT_EXISTS)		%% 目标装备不存在
    ?End,

    TarData = data_goods_build:get(TarGoods#goods.no),
    GoodsData = data_goods_build:get(Goods#goods.no),
    ?Ifc(TarData =:= null)
        throw(?PM_TAR_EQUIP_NOT_EXISTS)		%% 目标装备不存在
    ?End,

    ?Ifc(GoodsData =:= null)
        throw(?PM_EQUIP_NOT_EXISTS)		    %% 材料装备不存在
    ?End,

  % [{4,0},{3,0},{2,0},{1,0}]
     
   
    FGem = fun({_Key,GemstoneValue}) ->
                        GemstoneValue == 0
                   end,
    GemstoneJudge = lists:all(FGem, lib_goods:get_equip_gemstone(Goods)),   
          
    ?Ifc( not GemstoneJudge )
        throw(?PM_GOOD_HAS_GEM)		        %% 此材料装备已镶嵌宝石
    ?End,

    TarGoodsLv = lib_goods:get_tpl_lv(TarGoods),
    GoodsLv = lib_goods:get_tpl_lv(Goods),
    ?Ifc(TarGoodsLv =/= GoodsLv)
        throw(?PM_EQUIP_LV_NOT_SAME)		%% 目标装备和材料装备等级不同
    ?End,

    TarGoodsStrenLv = lib_goods:get_stren_lv(TarGoods),
    ?Ifc(TarGoodsStrenLv < 20)
        throw(?PM_TAR_EQUIP_STREN_LV_NOT_CONFORM)		%% 目标装备必须强化到20级
    ?End,

    TarSubType = lib_goods:get_subtype(TarGoods),
    SubType = lib_goods:get_subtype(Goods),
    case (lists:member(TarSubType, lists:seq(1,11))) andalso (lists:member(TarSubType, lists:seq(1,11))) of
        true ->
            case (lists:member(TarSubType, lists:seq(1,6))) andalso (lists:member(SubType, lists:seq(1,6))) of
                true ->
                    ok;
                false ->
                    case (lists:member(TarSubType, lists:seq(7,11))) andalso (lists:member(SubType, lists:seq(7,11))) of
                        true ->
                            ?Ifc(TarSubType =/= SubType)
                                throw(?PM_EQUIP_TYPE_NOT_SAME)		%% 目标装备和材料装备类型不同
                            ?End;
                        false ->
                            throw(?PM_EQUIP_TYPE_NOT_SAME)		    %% 目标装备和材料装备类型不同
                    end
            end;
        false ->
            throw(?PM_EQUIP_IS_NOT_BUILD)		                    %% 目标装备必须是打造出来的
    end,

    DataCfg = data_equip_effect_huanhua:get(TarGoodsLv),
    % 判断是否有足够消耗道具
    case Type of
        0 ->
            case mod_inv:check_batch_destroy_goods(PS, [{DataCfg#equip_effect_huanhua.huanhua_material, DataCfg#equip_effect_huanhua.huanhua_material_count}]) of
                {fail, Reason} ->
                    throw(Reason);
                ok ->
                    ok
            end;
        _->
            case mod_inv:check_batch_destroy_goods(PS, [{DataCfg#equip_effect_huanhua.huanhua_material, DataCfg#equip_effect_huanhua.huanhua_material_count}]) of
                {fail, Reason} ->
                    throw(Reason);
                ok ->
                    case mod_inv:check_batch_destroy_goods(PS, [{DataCfg#equip_effect_huanhua.amulet, DataCfg#equip_effect_huanhua.amulet_count}]) of
                        {fail, Reason} ->
                            throw(Reason);
                        ok ->
                            ok
                    end
            end
    end.

% 装备幻化，返回{ok, EffNo, Attrs}
do_equip_transmogrify(PS, TarGoods, GoodsId, Type) ->
    TarGoodsTpl = lib_goods:get_tpl_data(TarGoods#goods.no),
    TarGoodsLv = lib_goods:get_tpl_lv(TarGoodsTpl),		                        %% 不要使用get_lv
    TransMoCfg = data_equip_effect_huanhua:get(TarGoodsLv),
    PriceType = TransMoCfg#equip_effect_huanhua.price_type,
    Price = TransMoCfg#equip_effect_huanhua.price,

    % 扣除游戏币
    player:cost_money(PS, PriceType, Price, [?LOG_GOODS, "equip_transmogrify"]),

    %% 扣除材料装备
    Production = TransMoCfg#equip_effect_huanhua.huanhua_material,
    Count = TransMoCfg#equip_effect_huanhua.huanhua_material_count,
    mod_inv:destroy_goods_WNC(player:id(PS), [{Production,Count}],  [?LOG_GOODS, "equip_transmogrify"]),

    Amulet = TransMoCfg#equip_effect_huanhua.amulet,
    AmuletCount = TransMoCfg#equip_effect_huanhua.amulet_count,

    {EffNo, Attrs} =
        case Type of
            0 ->
                Rate = TransMoCfg#equip_effect_huanhua.success_rate,
                Seed = util:rand(1, 100),
                if
                    Seed =< Rate ->
                        make_random_attr_eff(GoodsId);
                    true ->
                        {0, []}
                end;
            _ ->
                mod_inv:destroy_goods_WNC(player:id(PS), [{Amulet, AmuletCount}], [?LOG_GOODS, "equip_transmogrify"]),
                make_random_attr_eff(GoodsId)
        end,

    ?DEBUG_MSG("-------------------------EffNo:~p~n-------------------Attrs:~p~n", [EffNo, Attrs]),
%%    GoodsNo = lib_goods:get_no_by_id(GoodsId),
%%    mod_inv:destroy_goods_WNC(player:id(PS), [{GoodsNo,1}],  [?LOG_GOODS, "equip_transmogrify"]),       % 删除材料装备

    case ply_trade:sell_goods_from_bag(PS, GoodsId, 1) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        ok ->
            skip
    end,

    Goods3 = lib_goods:set_transmo_last_ref_attr(TarGoods, Attrs),
    Goods4 = lib_goods:set_transmo_last_eff_no(Goods3, EffNo),
%%    lib_inv:notify_cli_goods_info_change(player:id(PS), Goods4),
    mod_inv:mark_dirty_flag(player:get_id(PS), Goods4),
    {ok, EffNo, Attrs, Goods4}.

%% 返回的是{EffNo, Attrs=[] | [{Index, AttrName, RealValue, RefineLv}...]}
make_random_attr_eff(GoodsId) ->

    % 获得材料装备的附加属性和特效
    Goods = lib_goods:get_goods_by_id(GoodsId),
    ?DEBUG_MSG("--------------------GoodsId--------------------------~p~n", [GoodsId]),
    GoodsEffNo = lib_goods:get_equip_effect(Goods),
    ?DEBUG_MSG("--------------------GoodsEffNo-----------------------~p~n", [GoodsEffNo]),

    case GoodsEffNo of
        0 ->
            ProList = (data_equip_effect_huanhua_weight:get(2))#equip_effect_huanhua_weight.huanhua_effect_weight;
        _ ->
            ProList = (data_equip_effect_huanhua_weight:get(1))#equip_effect_huanhua_weight.huanhua_effect_weight
    end,

    F = fun({_, _, Weight}, Acc) ->
            Weight + Acc
        end,
    Sum = lists:foldl(F, 0, ProList),
    Seed = util:rand(1, Sum),
    {AttrCount, EffCount} = get_attr_eff_count(Seed, ProList, 0),

    EquipAddTupL = lib_goods:get_addi_ep_add_kv(Goods),
    case AttrCount =:= 0 andalso EffCount =:= 0 of
        true ->
            {0, []};                             %% 保险判断，以防策划表出错
        false ->
            case EffCount =:= 0 of
                true ->
                    case AttrCount of
                        1 ->
                            Elem = lists:nth(random:uniform(length(EquipAddTupL)), EquipAddTupL),
                            ?DEBUG_MSG("--------------EffCount =:= 0 AttrCount=1-----------Elem:---------------~p~n", [Elem]),
                            {0, [Elem]};
                        2 ->
                            Elem1 = lists:nth(random:uniform(length(EquipAddTupL)), EquipAddTupL),
                            EquipAddTupL1 = lists:delete(Elem1, EquipAddTupL),
                            Elem2 = lists:nth(random:uniform(length(EquipAddTupL1)), EquipAddTupL1),
                            ?DEBUG_MSG("--------------EffCount =:= 0 AttrCount=2-----------Elem1:-----Elem2:---------------~p~p~n", [Elem1, Elem2]),
                            {0, [Elem1, Elem2]};
                        _ ->
                            {0, EquipAddTupL}
                    end;
                false ->
                    case AttrCount of
                        0 ->
                            {GoodsEffNo, []};
                        1 ->
                            Elem1 = lists:nth(random:uniform(length(EquipAddTupL)), EquipAddTupL),
                            ?DEBUG_MSG("--------------EffCount =:= 1 AttrCount=2-----------Elem1:---------------~p~n", [Elem1]),
                            {GoodsEffNo, [Elem1]};
                        2 ->
                            Elem1 = lists:nth(random:uniform(length(EquipAddTupL)), EquipAddTupL),
                            EquipAddTupL1 = lists:delete(Elem1, EquipAddTupL),
                            Elem2 = lists:nth(random:uniform(length(EquipAddTupL1)), EquipAddTupL1),
                            ?DEBUG_MSG("--------------EffCount =:= 1 AttrCount=2-----------Elem1:-----Elem2:---------------~p~p~n", [Elem1, Elem2]),
                            {GoodsEffNo, [Elem1, Elem2]};
                        _ ->
                            {GoodsEffNo, EquipAddTupL}
                    end

            end
    end.

get_attr_eff_count(Seed, [H|T], SumCount0) ->
    {AttrCount, EffCount, Weight} = H,
    SumCount = SumCount0 + Weight,
    case SumCount >= Seed of
        true ->
            {AttrCount, EffCount};
        false ->
            get_attr_eff_count(Seed, T, SumCount)
    end.

check_equip_transmogrify_save(PS, TargetGoodsId) ->
    try check_equip_transmogrify_save__(PS, TargetGoodsId) of
        {ok, TarGoods}->
            {ok, TarGoods}
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

check_equip_transmogrify_save__(PS, TargetGoodsId) ->

    ?Ifc(TargetGoodsId =< 0)
        throw(?PM_PARA_ERROR)
    ?End,

    TarGoods = lib_goods:get_goods_by_id(TargetGoodsId),

    ?Ifc(lib_goods:is_fashion(TarGoods))
        throw(?PM_PARA_ERROR)
    ?End,

    ?Ifc((lib_goods:get_transmo_last_eff_no(TarGoods) =:= 0) andalso (lib_goods:get_transmo_last_ref_attr(TarGoods) =:= null))
        throw(?PM_NOT_HAVE_REF_ATTRS_AND_EFFNO)
    ?End,

    {ok, TarGoods}.

do_equip_transmogrify_save(PS, TarGoods) ->

    % 幻化的附加属性，格式：[{Index, 属性名，属性值, 精炼等级}, ...]
    TAddiEquipAdd_Last = lib_goods:get_transmo_last_ref_attr(TarGoods),
    TAddiEquipAdd =
        case lib_goods:get_transmo_ref_attr(TarGoods) of
            null ->
                [];
            Attr ->
                Attr
        end,
%%    ?DEBUG_MSG("--------------------------TAddiEquipAdd----------------------------~p~n", [TAddiEquipAdd]),
    AddiEquipAdd = lib_goods:get_addi_ep_add_kv(TarGoods),
    AddiEquipAdd_Tmp = AddiEquipAdd -- TAddiEquipAdd,

%%    ?DEBUG_MSG("--------------------------AddiEquipAdd----------------------------~p~n", [AddiEquipAdd]),
    EffNo = lib_goods:get_transmo_last_eff_no(TarGoods),

    TotalAddi = TAddiEquipAdd_Last ++ AddiEquipAdd_Tmp,
%%    TAddiEquipAdd2 = lib_attribute:to_addi_equip_add_attrs_record(TotalAddi),
%%    ?DEBUG_MSG("--------------------------TAddiEquipAdd2----------------------------~p~n", [TAddiEquipAdd2]),
    TarGoods1 = lib_goods:set_transmo_ref_attr(TarGoods, TAddiEquipAdd_Last),
%%    ?DEBUG_MSG("--------------------------TarGoods1#goods.extra----------------------------~p~n", [TarGoods1#goods.extra]),
%%    TarGoods2 = lib_goods:set_addi_equip_add(TarGoods1, TAddiEquipAdd2),

    TarGoods3 = lib_goods:set_transmo_eff_no(TarGoods1, EffNo),

    TarGoods4 = lib_goods:set_transmo_last_ref_attr(TarGoods3, null),
    TarGoods5 = lib_goods:set_transmo_last_eff_no(TarGoods4, 0),

    %% 需要重新计算战斗力和属性
    TarGoods6 = lib_goods:set_battle_power(TarGoods5, lib_equip:recount_battle_power(TarGoods5)),
%%    ?DEBUG_MSG("--------------------TarGoods6#goods.extra-------------------~p~n", [TarGoods6#goods.extra]),
    mod_inv:mark_dirty_flag(player:get_id(PS), TarGoods6),
    lib_inv:notify_cli_goods_info_change(player:id(PS), TarGoods6),
%%    TarGoodsId = lib_goods:get_id(TarGoods),
%%    TotalAddi_BS = util:term_to_bitstring(TotalAddi),
%%    db:update(goods, [{addi_equip_add, TotalAddi_BS}], [{id, TarGoodsId}]),

    %% 属性计算
	recount_attr_equip_put_on(PS, TarGoods6),
%%     case mod_equip:is_equip_put_on(player:get_id(PS), lib_goods:get_id(TarGoods6)) of
%%         false -> skip;
%%         true -> ply_attr:recount_equip_add_and_total_attrs(PS)
%%     end,
%%    ?DEBUG_MSG("-----------------------TarGoods6#goods.extra---------------------~p~n", [TarGoods6#goods.extra]),
    {ok, TarGoods6}.





%% 获取武将身上穿的装备（依据装备位置）
%%return: null | Goods结构体
get_partner_equip_by_pos(PlayerId, PartnerId, EquipPos) ->
    case lists:keyfind(EquipPos, #goods.slot, get_partner_equip_list(PlayerId, PartnerId)) of
        false ->
            null;
        Goods ->
            Goods
    end.


%% 获取玩家身上穿的装备（依据装备位置）
%%return: null | Goods结构体
get_player_equip_by_pos(PlayerId, EquipPos) ->
    case lists:keyfind(EquipPos, #goods.slot, get_player_equip_list(PlayerId)) of
        false ->
            null;
        Goods ->
            Goods
    end.

%% return ok
%% 改变玩家装备以及相关属性
add_player_equip_change_attr(PS, GoodsInfo, EquipPos) ->
    PlayerId = player:id(PS),
    Inv = mod_inv:get_inventory(PlayerId),
    GemIdList = lib_goods:get_gem_id_list(GoodsInfo),
    NewPlayerEqGoodsList = Inv#inv.player_eq_goods ++ [lib_goods:get_id(GoodsInfo)] ++ GemIdList,
    mod_inv:update_inventory_to_ets(Inv#inv{player_eq_goods = sets:to_list(sets:from_list(NewPlayerEqGoodsList))}),

    %% 改变宝石位置
    F = fun(Id) ->
        case mod_inv:get_goods_from_ets(Id) of
            null ->
                ?ASSERT(false),
                skip;
            GemGoods ->
                GemGoods1 = lib_goods:set_location(GemGoods, ?LOC_PLAYER_EQP),
                GemGoods2 = lib_goods:set_dirty(GemGoods1, true),                
                mod_inv:update_goods_to_ets(GemGoods2)
        end
    end,
    [F(X) || X <- GemIdList],

    {Goods, Change} =
        case lib_goods:get_bind_state(GoodsInfo) of
            ?BIND_ON_USE -> {GoodsInfo#goods{location = ?LOC_PLAYER_EQP, slot = EquipPos, bind_state = ?BIND_ALREADY}, true};
            _ -> {GoodsInfo#goods{location = ?LOC_PLAYER_EQP, slot = EquipPos}, false}
        end,

    mod_inv:mark_dirty_flag(player:get_id(PS), Goods),
    lib_inv:notify_cli_goods_added(player:get_id(PS), Goods),

    SuitNo = decide_player_suit_no(PlayerId),
    player:set_suit_no(PS, SuitNo),
    case player:get_suit_no(PS) =:= SuitNo of
        true -> skip;
        false -> lib_scene:notify_int_info_change_to_aoi(player, player:get_id(PS), [{?OI_CODE_STREN_LV, SuitNo}])
    end,
    %% 重算相关属性
    ply_attr:recount_equip_add_and_total_attrs(PS),
    {ok, Goods, Change}.


%% return ok
%% 改变宠物装备以及相关属性
add_partner_equip_change_attr(PS, PartnerId, GoodsInfo, EquipPos) ->
    PlayerId = player:id(PS),
    Inv = mod_inv:get_inventory(PlayerId),
    %% 如果有宝石，这里还需要处理

    GemIdList = lib_goods:get_gem_id_list(GoodsInfo),
    %% 改变宝石位置
    F = fun(Id) ->
        case mod_inv:get_goods_from_ets(Id) of
            null ->
                ?ASSERT(false),
                skip;
            GemGoods ->
                GemGoods1 = lib_goods:set_location(GemGoods, ?LOC_PARTNER_EQP),
                GemGoods2 = lib_goods:set_dirty(GemGoods1, true),                
                mod_inv:update_goods_to_ets(GemGoods2)
        end
    end,

    [F(X) || X <- GemIdList],

    NewPlayerEqGoodsList = Inv#inv.partner_eq_goods ++ [lib_goods:get_id(GoodsInfo)] ++ GemIdList,
    mod_inv:update_inventory_to_ets(Inv#inv{partner_eq_goods = sets:to_list(sets:from_list(NewPlayerEqGoodsList))}),

    % NewPartnerEqGoodsList = Inv#inv.partner_eq_goods ++ [lib_goods:get_id(GoodsInfo)],
    % mod_inv:update_inventory_to_ets(Inv#inv{partner_eq_goods = NewPartnerEqGoodsList}),
    {Goods, Change} =
        case lib_goods:get_bind_state(GoodsInfo) of
            ?BIND_ON_USE -> {GoodsInfo#goods{location = ?LOC_PARTNER_EQP, slot = EquipPos, partner_id = PartnerId, player_id = PlayerId, bind_state = ?BIND_ALREADY}, true};
            _ -> {GoodsInfo#goods{location = ?LOC_PARTNER_EQP, slot = EquipPos, partner_id = PartnerId, player_id = PlayerId}, false}
        end,

    mod_inv:mark_dirty_flag(PlayerId, Goods),
    lib_inv:notify_cli_goods_added(player:get_id(PS), Goods),

    %%重算相关属性
    Partner = lib_partner:recount_equip_add_and_total_attrs(PlayerId, PartnerId),

    ShowEquips = lib_partner:get_showing_equips(Partner),
    PartnerLatest =
        case EquipPos of
            ?PEQP_POS_SKIN ->
                ShowEquips1 = ShowEquips#showing_equip{clothes = lib_goods:get_no(Goods)},
                TPartner = lib_partner:set_showing_equips(Partner, ShowEquips1),
                case lib_partner:is_follow_partner(TPartner) of
                    false -> skip;
                    true -> lib_partner:notify_main_partner_info_change_to_AOI(PS, TPartner)
                end,
                lib_partner:notify_cli_info_change(TPartner, [{?OI_CODE_PAR_CLOTHES, lib_goods:get_no(Goods)}]),
                TPartner;
            ?PEQP_POS_YAODAN -> %% 有待根据需求修正
                ShowEquips1 = ShowEquips#showing_equip{headwear = lib_goods:get_no(Goods)},
                lib_partner:set_showing_equips(Partner, ShowEquips1);
            ?PEQP_POS_SEAL ->
                ShowEquips1 = ShowEquips#showing_equip{backwear = lib_goods:get_no(Goods)},
                lib_partner:set_showing_equips(Partner, ShowEquips1);
            _Any -> Partner
        end,

    mod_partner:update_partner_to_ets(PartnerLatest),

    case lib_partner:is_fighting(PartnerLatest) of
        true -> ply_attr:recount_battle_power(PS);
        false -> skip
    end,

    {ok, Goods, Change}.

%%
%%check_strenthen_equip(PS, GoodsId, AccMoney, AccGoodsL, AccBGoodsL, UseBindStone, Step) ->
%%    case mod_inv:find_goods_by_id_from_whole_inv(player:get_id(PS), GoodsId) of
%%        null ->
%%            {fail, ?PM_GOODS_NOT_EXISTS, null};
%%        Goods ->
%%            % case lib_goods:get_type(Goods) =:= ?GOODS_T_PAR_EQUIP orelse lib_goods:is_fashion(Goods) of
%%            case lib_goods:is_fashion(Goods) of
%%                true -> {fail, ?PM_PARA_ERROR, Goods};
%%                false ->
%%                    DataList = data_equip_strenthen:get(Step),
%%                    CurStrenLv = (lib_goods:get_equip_prop(Goods))#equip_prop.stren_lv,
%%                    case CurStrenLv =:= length(DataList) of
%%                        true -> {fail, ?PM_MAX_STREN_LV_LIMIT, Goods};
%%                        false ->
%%                            Data = lists:keyfind(CurStrenLv + 1, #equip_strenthen.stren_lv, DataList),
%%                            HaveMoney = player:get_bind_gamemoney(PS) + player:get_gamemoney(PS),
%%                            {Price, UseFreeCnt} =
%%                                case lib_equip:get_free_stren_cnt(PS) > 0 of
%%                                    true -> {0, true};
%%                                    false ->
%%                                        case mod_admin_activity:get_admin_sys_set(5) of
%%                                            null -> {Data#equip_strenthen.yuanbao, false};
%%                                            ActivitySet ->
%%                                                case lists:keyfind(discount, 1, ActivitySet) of
%%                                                    false -> {Data#equip_strenthen.yuanbao, false};
%%                                                    {discount, Para} -> {util:ceil(Data#equip_strenthen.yuanbao * Para/100), false}
%%                                                end
%%                                        end
%%                                end,
%%
%%                            case Price + AccMoney > HaveMoney of
%%                                true -> {fail, ?PM_BIND_GAMEMONEY_LIMIT, Goods};
%%                                false ->
%%                                    AccGoodsL1 = mod_inv:arrange_goods_list(AccGoodsL),
%%                                    AccBGoodsL1 = mod_inv:arrange_goods_list(AccBGoodsL),
%%                                    case UseBindStone of
%%                                        0 ->
%%                                            GoodsList =
%%                                                case UseFreeCnt of
%%                                                    false ->
%%                                                        [{Data#equip_strenthen.strengthen_stone, Data#equip_strenthen.strengthen_stone_count, ?BIND_NEVER} | AccGoodsL1];
%%                                                    true ->
%%                                                        AccGoodsL1
%%                                                end,
%%                                            case mod_inv:check_batch_destroy_goods(PS, GoodsList) of
%%                                                {fail, _Reason} -> {fail, ?PM_STREN_STONE_COUNT_LIMIT, Goods};
%%                                                ok -> {ok, Goods, GoodsList, AccBGoodsL, Price + AccMoney, UseFreeCnt}
%%                                            end;
%%                                        1 ->
%%                                            GoodsList =
%%                                                case UseFreeCnt of
%%                                                    false ->
%%                                                        [{Data#equip_strenthen.strengthen_stone, Data#equip_strenthen.strengthen_stone_count, ?BIND_ALREADY} | AccBGoodsL1];
%%                                                    true ->
%%                                                        AccBGoodsL1
%%                                                end,
%%                                            case mod_inv:check_batch_destroy_goods(PS, GoodsList) of
%%                                                {fail, _Reason} -> {fail, ?PM_BIND_STREN_STONE_COUNT_LIMIT, Goods};
%%                                                ok -> {ok, Goods, AccGoodsL, GoodsList, Price + AccMoney, UseFreeCnt}
%%                                            end;
%%                                        2 ->
%%                                            StateFirst = lib_goods:get_bind_state(Goods),
%%                                            StateSecond =
%%                                                case StateFirst of
%%                                                    ?BIND_NEVER -> ?BIND_ALREADY;
%%                                                    ?BIND_ALREADY -> ?BIND_NEVER
%%                                                end,
%%
%%                                            GoodsNo = Data#equip_strenthen.strengthen_stone,
%%                                            GoodsCount =
%%                                                case UseFreeCnt of
%%                                                    false -> Data#equip_strenthen.strengthen_stone_count;
%%                                                    true -> 0
%%                                                end,
%%
%%                                            FisrtCount = mod_inv:get_goods_count_in_bag(player:id(PS), GoodsNo, StateFirst),
%%                                            SecondCount = mod_inv:get_goods_count_in_bag(player:id(PS), GoodsNo, StateSecond),
%%                                            NowUseGoodsCount = calc_now_use_goods_count(AccGoodsL1),
%%                                            NowUseBGoodsCount = calc_now_use_goods_count(AccBGoodsL1),
%%                                            case FisrtCount + SecondCount < GoodsCount + NowUseGoodsCount + NowUseBGoodsCount of
%%                                                true -> {fail, ?PM_STREN_STONE_COUNT_LIMIT, Goods};
%%                                                false ->
%%                                                    case StateFirst of
%%                                                        ?BIND_NEVER -> %% 尝试全部使用非绑定强化石
%%                                                            case NowUseGoodsCount + GoodsCount =< FisrtCount of
%%                                                                true ->
%%                                                                    {ok, Goods, [{GoodsNo, GoodsCount, ?BIND_NEVER} | AccGoodsL1], AccBGoodsL1, Price + AccMoney, UseFreeCnt};
%%                                                                false -> %% 混合使用，优先使用非绑定的
%%                                                                    TGoodsCount = erlang:max(0, FisrtCount - NowUseGoodsCount),
%%                                                                    TBGoodsCount = erlang:max(0, GoodsCount - TGoodsCount),
%%                                                                    {ok, Goods, [{GoodsNo, TGoodsCount, ?BIND_NEVER} | AccGoodsL1], [{GoodsNo, TBGoodsCount, ?BIND_ALREADY} | AccBGoodsL1], Price + AccMoney, UseFreeCnt}
%%                                                            end;
%%                                                        ?BIND_ALREADY ->
%%                                                            case NowUseBGoodsCount + GoodsCount =< FisrtCount of
%%                                                                true ->
%%                                                                    {ok, Goods, AccGoodsL1, [{GoodsNo, GoodsCount, ?BIND_ALREADY} | AccBGoodsL1], Price + AccMoney, UseFreeCnt};
%%                                                                false -> %% 混合使用，优先使用绑定的
%%                                                                    TBGoodsCount = erlang:max(0, FisrtCount - NowUseBGoodsCount),
%%                                                                    TGoodsCount = erlang:max(0, GoodsCount - TBGoodsCount),
%%                                                                    {ok, Goods, [{GoodsNo, TGoodsCount, ?BIND_NEVER} | AccGoodsL1], [{GoodsNo, TBGoodsCount, ?BIND_ALREADY} | AccBGoodsL1], Price + AccMoney, UseFreeCnt}
%%                                                            end
%%                                                    end
%%                                            end;
%%                                        _ ->
%%                                            {fail, ?PM_PARA_ERROR, Goods}
%%                                    end
%%                            end
%%                    end
%%            end
%%    end.
%%
%%do_strenthen_equip(PS, GoodsId, Count, UseBindStone, RetList) ->
%%    Goods = mod_inv:get_goods_from_ets(GoodsId),
%%    Step = lib_equip:get_lv_step_for_strenthen(lib_goods:get_tpl_lv(Goods), sets:to_list(sets:from_list(data_equip_strenthen:get_all_lv_step_list())) ),
%%    do_strenthen_equip(PS, GoodsId, Count, UseBindStone, Step, 0, [], [], RetList).
%%
%%do_strenthen_equip(PS, _GoodsId, 0, _UseBindStone, _Step, AccMoney, AccGoodsL, AccBGoodsL, RetList) ->
%%    PS1 =
%%        case AccMoney > 0 of
%%            true -> player_syn:cost_money(PS, ?MNY_T_BIND_GAMEMONEY, AccMoney, [?LOG_EQUIP, "stren"]);
%%            false -> PS
%%        end,
%%
%%    case mod_inv:destroy_goods_WNC(PS, AccBGoodsL, [?LOG_EQUIP, "stren"]) of
%%        true -> skip;
%%        false -> ?ERROR_MSG("mod_equip:destroy_goods_WNC error!~n", [])
%%    end,
%%    case mod_inv:destroy_goods_WNC(PS, AccGoodsL, [?LOG_EQUIP, "stren"]) of
%%        true -> skip;
%%        false -> ?ERROR_MSG("mod_equip:destroy_goods_WNC error!~n", [])
%%    end,
%%
%%    {RetList, PS1};
%%
%%do_strenthen_equip(PS, GoodsId, Count, UseBindStone, Step, AccMoney, AccGoodsL, AccBGoodsL, RetList) when Count > 0 ->
%%    case check_strenthen_equip(PS, GoodsId, AccMoney, AccGoodsL, AccBGoodsL, UseBindStone, Step) of
%%        {fail, Reason, Goods} ->
%%            PS1 =
%%                case AccMoney > 0 of
%%                    true -> player_syn:cost_money(PS, ?MNY_T_BIND_GAMEMONEY, AccMoney, [?LOG_EQUIP, "stren"]);
%%                    false -> PS
%%                end,
%%
%%            case mod_inv:destroy_goods_WNC(PS, AccBGoodsL, [?LOG_EQUIP, "stren"]) of
%%                true -> skip;
%%                false -> ?ERROR_MSG("mod_equip:destroy_goods_WNC error!~n", [])
%%            end,
%%            case mod_inv:destroy_goods_WNC(PS, AccGoodsL, [?LOG_EQUIP, "stren"]) of
%%                true -> skip;
%%                false -> ?ERROR_MSG("mod_equip:destroy_goods_WNC error!~n", [])
%%            end,
%%
%%            {RetList ++ [{Reason, lib_goods:get_stren_lv(Goods), lib_goods:get_stren_exp(Goods)}], PS1};
%%        {ok, Goods, AccGoodsL1, AccBGoodsL1, AccMoney1, UseFreeCnt} ->
%%            case UseFreeCnt of
%%                false -> skip;
%%                true -> lib_equip:cost_free_stren_cnt(PS, 1)
%%            end,
%%
%%            DataList = data_equip_strenthen:get(Step),
%%            CurStrenLv = lib_goods:get_stren_lv(Goods),
%%            Data = lists:keyfind(CurStrenLv + 1, #equip_strenthen.stren_lv, DataList),
%%
%%            RandNum = util:rand(1, 10000),
%%            case 1 =< RandNum andalso RandNum =< Data#equip_strenthen.success_prob of
%%                true -> % 强化成功，直接升级
%%                    Goods2 = lib_goods:set_stren_exp(Goods, 0),
%%                    Goods3 = lib_goods:set_stren_lv(Goods2, CurStrenLv + 1),
%%                    Goods4 = lib_equip:change_equip_stren_attr(Goods3),
%%                    mod_inv:mark_dirty_flag(player:get_id(PS), Goods4),
%%                    send_sys_tips_for_stren(PS, Goods4),
%%                    mod_achievement:notify_achi(stren_equip,  [[{stren_lv, CurStrenLv + 1}, {num, 1}]], PS),
%%
%%                    RetList1 = RetList ++ [{0, lib_goods:get_stren_lv(Goods4), lib_goods:get_stren_exp(Goods4)}],
%%                    do_strenthen_equip(PS, GoodsId, Count - 1, UseBindStone, Step, AccMoney1, AccGoodsL1, AccBGoodsL1, RetList1);
%%                false -> %% 强化失败，添加经验值，经验值满的话，也升级
%%                    {ok, Goods2, IsLvUp} = lib_goods:add_stren_exp(Goods, Data#equip_strenthen.exp),
%%                    Goods3 = lib_equip:change_equip_stren_attr(Goods2),
%%
%%                    mod_inv:mark_dirty_flag(player:get_id(PS), Goods3),
%%                    case IsLvUp of
%%                        true -> send_sys_tips_for_stren(PS, Goods3);
%%                        false -> skip
%%                    end,
%%                    RetList1 = RetList ++ [{?PM_STRENGTHEN_FAIL, lib_goods:get_stren_lv(Goods3), lib_goods:get_stren_exp(Goods3)}],
%%                    do_strenthen_equip(PS, GoodsId, Count - 1, UseBindStone, Step, AccMoney1, AccGoodsL1, AccBGoodsL1, RetList1)
%%            end
%%    end.

%%do_strenthen_equip_until_lv_up(PS, GoodsId, Count, UseBindStone, RetList) ->
%%    Goods = mod_inv:get_goods_from_ets(GoodsId),
%%    Step = lib_equip:get_lv_step_for_strenthen(lib_goods:get_tpl_lv(Goods), sets:to_list(sets:from_list(data_equip_strenthen:get_all_lv_step_list())) ),
%%    do_strenthen_equip_until_lv_up(PS, GoodsId, Count, UseBindStone, Step, 0, [], [], RetList).
%%
%%do_strenthen_equip_until_lv_up(PS, _GoodsId, 0, _UseBindStone, _Step, AccMoney, AccGoodsL, AccBGoodsL, RetList) ->
%%    PS1 =
%%        case AccMoney > 0 of
%%            true -> player_syn:cost_money(PS, ?MNY_T_BIND_GAMEMONEY, AccMoney, [?LOG_EQUIP, "stren"]);
%%            false -> PS
%%        end,
%%
%%    case mod_inv:destroy_goods_WNC(PS, AccBGoodsL, [?LOG_EQUIP, "stren"]) of
%%        true -> skip;
%%        false -> ?ERROR_MSG("mod_equip:destroy_goods_WNC error!~n", [])
%%    end,
%%    case mod_inv:destroy_goods_WNC(PS, AccGoodsL, [?LOG_EQUIP, "stren"]) of
%%        true -> skip;
%%        false -> ?ERROR_MSG("mod_equip:destroy_goods_WNC error!~n", [])
%%    end,
%%
%%    {RetList, PS1};
%%do_strenthen_equip_until_lv_up(PS, GoodsId, Count, UseBindStone, Step, AccMoney, AccGoodsL, AccBGoodsL, RetList) ->
%%    case check_strenthen_equip(PS, GoodsId, AccMoney, AccGoodsL, AccBGoodsL, UseBindStone, Step) of
%%        {fail, Reason, Goods} ->
%%            RetList1 = RetList ++ [{Reason, lib_goods:get_stren_lv(Goods), lib_goods:get_stren_exp(Goods)}],
%%            PS1 =
%%                case AccMoney > 0 of
%%                    true -> player_syn:cost_money(PS, ?MNY_T_BIND_GAMEMONEY, AccMoney, [?LOG_EQUIP, "stren"]);
%%                    false -> PS
%%                end,
%%
%%            case mod_inv:destroy_goods_WNC(PS, AccBGoodsL, [?LOG_EQUIP, "stren"]) of
%%                true -> skip;
%%                false -> ?ERROR_MSG("mod_equip:destroy_goods_WNC error!~n", [])
%%            end,
%%            case mod_inv:destroy_goods_WNC(PS, AccGoodsL, [?LOG_EQUIP, "stren"]) of
%%                true -> skip;
%%                false -> ?ERROR_MSG("mod_equip:destroy_goods_WNC error!~n", [])
%%            end,
%%
%%            {RetList1, PS1};
%%        {ok, Goods, AccGoodsL1, AccBGoodsL1, AccMoney1, UseFreeCnt} ->
%%            case UseFreeCnt of
%%                false -> skip;
%%                true -> lib_equip:cost_free_stren_cnt(PS, 1)
%%            end,
%%
%%            DataList = data_equip_strenthen:get(Step),
%%            CurStrenLv = lib_goods:get_stren_lv(Goods),
%%            Data = lists:keyfind(CurStrenLv + 1, #equip_strenthen.stren_lv, DataList),
%%
%%            RandNum = util:rand(1, 10000),
%%            case 1 =< RandNum andalso RandNum =< Data#equip_strenthen.success_prob of
%%                true ->
%%                    Goods2 = lib_goods:set_stren_exp(Goods, 0),
%%                    Goods3 = lib_goods:set_stren_lv(Goods2, CurStrenLv + 1),
%%                    Goods4 = lib_equip:change_equip_stren_attr(Goods3),
%%                    mod_inv:mark_dirty_flag(player:get_id(PS), Goods4),
%%                    send_sys_tips_for_stren(PS, Goods4),
%%                    RetList1 = RetList ++ [{0, lib_goods:get_stren_lv(Goods4), lib_goods:get_stren_exp(Goods4)}],
%%                    PS1 =
%%                        case AccMoney1 > 0 of
%%                            true -> player_syn:cost_money(PS, ?MNY_T_BIND_GAMEMONEY, AccMoney1, [?LOG_EQUIP, "stren"]);
%%                            false -> PS
%%                        end,
%%
%%                    mod_inv:destroy_goods_WNC(PS, AccBGoodsL1, [?LOG_EQUIP, "stren"]),
%%                    mod_inv:destroy_goods_WNC(PS, AccGoodsL1, [?LOG_EQUIP, "stren"]),
%%
%%                    {RetList1, PS1};
%%                false ->
%%                    {ok, Goods2, IsLvUp} = lib_goods:add_stren_exp(Goods, Data#equip_strenthen.exp),
%%                    Goods3 = lib_equip:change_equip_stren_attr(Goods2),
%%
%%                    mod_inv:mark_dirty_flag(player:get_id(PS), Goods3),
%%                    RetList1 = RetList ++ [{?PM_STRENGTHEN_FAIL, lib_goods:get_stren_lv(Goods3), lib_goods:get_stren_exp(Goods3)}],
%%                    case IsLvUp of
%%                        true ->
%%                            PS1 =
%%                                case AccMoney1 > 0 of
%%                                    true -> player_syn:cost_money(PS, ?MNY_T_BIND_GAMEMONEY, AccMoney1, [?LOG_EQUIP, "stren"]);
%%                                    false -> PS
%%                                end,
%%
%%                            mod_inv:destroy_goods_WNC(PS, AccBGoodsL1, [?LOG_EQUIP, "stren"]),
%%                            mod_inv:destroy_goods_WNC(PS, AccGoodsL1, [?LOG_EQUIP, "stren"]),
%%
%%                            send_sys_tips_for_stren(PS, Goods3),
%%                            {RetList1, PS1};
%%                        false ->
%%                            do_strenthen_equip_until_lv_up(PS, GoodsId, Count - 1, UseBindStone, Step, AccMoney1, AccGoodsL1, AccBGoodsL1, RetList1)
%%                    end
%%            end
%%    end.

notify_achi(PS) ->
    PlayerId = player:id(PS),
    GoodsList = get_player_equip_list(PlayerId),
    F = fun(Goods, {QAcc, LvAcc}) ->
        Quality = lib_goods:get_quality(Goods),
        QAcc1 =
            case lists:member(Quality, QAcc) of
                true -> QAcc;
                false -> [Quality | QAcc]
            end,
        StrenLv = lib_goods:get_stren_lv(Goods),
        LvAcc1 =
            case lists:member(StrenLv, LvAcc) of
                true -> LvAcc;
                false -> [StrenLv | LvAcc]
            end,
        {QAcc1, LvAcc1}
    end,
    {QualityList, StrenLvList} = lists:foldl(F, {[],[]}, GoodsList),

    F1 = fun(Q, Acc) ->
         F2 = fun(Goods, Sum) ->
            case lib_goods:get_quality(Goods) =:= Q of
                true -> Sum + 1;
                false -> Sum
            end
        end,
        Num = lists:foldl(F2, 0, GoodsList),
        [[{quality, Q}, {num, Num}] | Acc]
    end,
    InfoList = lists:foldl(F1, [], QualityList),

    F3 = fun(Lv, Acc) ->
         F4 = fun(Goods, Sum) ->
            case lib_goods:get_stren_lv(Goods) =:= Lv of
                true -> Sum + 1;
                false -> Sum
            end
        end,
        Num = lists:foldl(F4, 0, GoodsList),
        [[{stren_lv, Lv}, {num, Num}] | Acc]
    end,
    InfoList1 = lists:foldl(F3, [], StrenLvList),

    %强化通知成就
    InfoList2 = [[{stren_lv, lib_goods:get_stren_lv(Goods)},{lv, lib_goods:get_lv(Goods)}] || Goods <- GoodsList],
    mod_achievement:notify_achi(wear_equip_ex, InfoList2, PS),

    %指定id时装通知成就
    F5 = fun(Goods, _Acc) ->
            case lib_goods:get_type(Goods) =:= 1 andalso lib_goods:get_subtype(Goods) >= 12 andalso lib_goods:get_subtype(Goods) =< 14 of
                true -> 
                    %是时装
                    mod_achievement:notify_achi(wear_equip_fashion, [{no, lib_goods:get_no(Goods)}], PS);
                false ->
                    _Acc
            end
        end,

    lists:foldl(F5, [], GoodsList),
    mod_achievement:notify_achi(wear_equip, InfoList, PS),
    mod_achievement:notify_achi(wear_equip, InfoList1, PS).



send_sys_tips_for_stren(PS, Goods) ->
    Lv = lib_goods:get_stren_lv(Goods),
    GoodsNo = lib_goods:get_no(Goods),
    if
        Lv =:= 10 ->
            ply_tips:send_sys_tips(PS, {strenthen_equip_10, [player:get_name(PS), player:id(PS), GoodsNo, lib_goods:get_quality(Goods), 1,lib_goods:get_id(Goods)]});
        Lv =:= 15 ->
            ply_tips:send_sys_tips(PS, {strenthen_equip_15, [player:get_name(PS), player:id(PS), GoodsNo, lib_goods:get_quality(Goods), 1,lib_goods:get_id(Goods)]});
        Lv =:= 17 ->
            ply_tips:send_sys_tips(PS, {strenthen_equip_17, [player:get_name(PS), player:id(PS), GoodsNo, lib_goods:get_quality(Goods), 1,lib_goods:get_id(Goods)]});
        Lv =:= 20 ->
            ply_tips:send_sys_tips(PS, {strenthen_equip_20, [player:get_name(PS), player:id(PS), GoodsNo, lib_goods:get_quality(Goods), 1,lib_goods:get_id(Goods)]});
        Lv =:= 30 ->
            ply_tips:send_sys_tips(PS, {strenthen_equip_30, [player:get_name(PS), player:id(PS), GoodsNo, lib_goods:get_quality(Goods), 1,lib_goods:get_id(Goods)]});
        Lv =:= 40 ->
            ply_tips:send_sys_tips(PS, {strenthen_equip_40, [player:get_name(PS), player:id(PS), GoodsNo, lib_goods:get_quality(Goods), 1,lib_goods:get_id(Goods)]});
        Lv =:= 50 ->
            ply_tips:send_sys_tips(PS, {strenthen_equip_50, [player:get_name(PS), player:id(PS), GoodsNo, lib_goods:get_quality(Goods), 1,lib_goods:get_id(Goods)]});
        % Lv =:= 18 ->
        %     ply_tips:send_sys_tips(PS, {strenthen_equip_18, [player:get_name(PS), player:id(PS), GoodsNo, lib_goods:get_quality(Goods), 1]});
        % Lv =:= 20 ->
        %     ply_tips:send_sys_tips(PS, {strenthen_equip_20, [player:get_name(PS), player:id(PS), GoodsNo, lib_goods:get_quality(Goods), 1]});
        true ->
            skip
    end.



calc_now_use_goods_count(GoodsList) ->
    F = fun({_GoodsNo, Count, _State}, Sum) ->
        Sum + Count
    end,
    lists:foldl(F, 0, GoodsList).



%% 如[{1, 1000},{1, 2000}] -> [{1, 3000}]
arrange_money_list(List) ->
    F = fun(Para) ->
        case Para of
            {No, _Cnt} -> No;
            {No, _Cnt, _} -> No
        end
    end,
    MoneyTypeList = [F(X) || X <- List],
    MoneyTypeList1 = sets:to_list(sets:from_list(MoneyTypeList)),

    F1 = fun(X1) ->
        F2 = fun({Type, Cnt}, Sum) ->
            case Type =:= X1 of
                true -> Sum + Cnt;
                false -> Sum
            end
        end,
        Total = lists:foldl(F2, 0, List),
        {X1, Total}
    end,
    [F1(X1) || X1 <- MoneyTypeList1].

%GoodsList: [{Prob, GoodsNo, Count} ...]
% 这里是几率
decide_goods_list_by_prob(GoodsList) ->
    F = fun({Prob, GoodsNo, Count}, Acc) ->
        case Prob =:= 0 orelse Count =:= 0 of
            true -> Acc;
            false ->
                RandNum = util:rand(1, ?PROBABILITY_BASE),
                case 1 =< RandNum andalso RandNum =< Prob of
                    true -> [{GoodsNo, Count} | Acc];
                    false -> Acc
                end
        end
    end,
    lists:foldl(F, [], GoodsList).

% 这里是权重
decide_goods_list_by_widget([]) ->
    [];
decide_goods_list_by_widget(List) ->   
    ?DEBUG_MSG("List = ~p",[List]), 
    F = fun({W,_,_}, A) -> 
        A+W 
    end,
    Range = lists:foldl(F,0, List),
    ?DEBUG_MSG("Range=~p",[Range]),
    RandNum = util:rand(1, Range),

    decide_goods_list_by_widget(List,RandNum).


% 获取随机特效信息
decide_goods_list_by_widget(List, RandNum) ->
    decide_goods_list_by_widget(List, RandNum, 0).

decide_goods_list_by_widget([H | T], RandNum, SumToCompare) ->
    {Widget,GoodsNo, Count} = H,
    SumToCompare_2 = Widget + SumToCompare,

    case RandNum =< SumToCompare_2 of
        true -> 
            [{GoodsNo,Count}];
        false ->
            decide_goods_list_by_widget(T, RandNum, SumToCompare_2)
    end;

decide_goods_list_by_widget([], _RandNum, _SumToCompare) ->
    [].


%% GoodsList --> [{GoodsNo, BindState},...]
get_smelt_no_by_goods(GoodsList) ->
    NoList = data_compose_goods:get_no_list_by_op_no(4),
    get_smelt_no_by_goods(NoList, GoodsList).

%% 返回兑换类配置
get_change_item_config(GoodsNo) ->
% 找到对应的配置
    NoList = data_compose_goods:get_no_list_by_op_no(5),
    
    get_change_item_config(NoList, GoodsNo).

%%
get_change_item_config([], _GoodsNo) ->
    ?INVALID_NO;

get_change_item_config([H | T], GoodsNo) ->
    case data_compose_goods:get(H) of
        null -> 
            get_change_item_config(T, GoodsNo);
        Data ->
            [MyGoodsNo] = Data#compose_goods.need_goods_list,
            ?DEBUG_MSG("get_change_item_config H:~p~n, GoodsNo:~p~n ,MyGoodsNo:~p~n",[H,GoodsNo,MyGoodsNo]),

            if
                MyGoodsNo =:= GoodsNo -> 
                    Data;
                true -> 
                    get_change_item_config(T, GoodsNo)
            end
    end.


get_smelt_no_by_goods([], _GoodsList) ->
    ?INVALID_NO;
get_smelt_no_by_goods([H | T], GoodsList) ->
    case data_compose_goods:get(H) of
        null -> 
            get_smelt_no_by_goods(T, GoodsList);
        Data ->
            F = fun({GoodsNo, _}, Sum) ->
                case lists:keyfind(GoodsNo, 1, Data#compose_goods.need_goods_list) of
                    false -> Sum;
                    _ -> Sum + 1
                end
            end,

            case lists:foldl(F, 0, GoodsList) =:= length(GoodsList) of
                true -> H;
                false -> get_smelt_no_by_goods(T, GoodsList)
            end
    end.



%% 穿戴的装备属性重算
recount_attr_equip_put_on(PS, Goods) ->
	PlayerId = player:get_id(PS),
	GoodsId = lib_goods:get_id(Goods),
	case mod_equip:is_equip_put_on(PlayerId, GoodsId) of
		false ->
			case mod_equip:is_equip_put_on_par(PlayerId, GoodsId) of
				false ->
					skip;
				true ->
					PartnerId = Goods#goods.partner_id,
					Partner = lib_partner:recount_equip_add_and_total_attrs(PlayerId, PartnerId),
					mod_partner:update_partner_to_ets(Partner)
			end;
		true -> ply_attr:recount_equip_add_and_total_attrs(PS)
	end.




