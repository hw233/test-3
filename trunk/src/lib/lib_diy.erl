%%%-------------------------------------------------------------------
%%% @author
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 20. 五月 2019 17:08
%%%-------------------------------------------------------------------
-module(lib_diy).

%% API
-include("diy.hrl").
-include("common.hrl").
-include("prompt_msg_code.hrl").
-include("reward.hrl").
-include("record.hrl").
-include("ets_name.hrl").
-include("battle.hrl").
-include("partner.hrl").
-include("event.hrl").
-include("skill.hrl").
-include("chibang.hrl").
-include("inventory.hrl").


-export([start_diy_title/3,start_diy_partner/5,start_diy_fashion/5,start_diy_wing/4,
    start_diy_mount/5,start_diy_equip/7,start_goods_exchange/4]).


%% 开始定制称号
start_diy_title(PlayerId, No, AttrsNum) ->
    DiyTitle = data_diy_title_config:get(No),
    %% 判断选择属性是否对应
    case DiyTitle#diy_title_config.optional_attr_num =:= length(AttrsNum) of
        true ->
            NeedCost = DiyTitle#diy_title_config.cost,
            case mod_inv:check_batch_destroy_goods(PlayerId, [NeedCost]) of
                ok ->
                    OptionalAttrAdd = DiyTitle#diy_title_config.optional_attr_add,
                    F = fun(X, Attr) ->
                        [lists:nth(X, OptionalAttrAdd) | Attr]
                        end,
                    AttrsList = lists:foldl(F, [], AttrsNum),
                    DiyTitles = ply_title:get_diytitles(PlayerId),
                    NewDiyTitles = [{No, AttrsList} | DiyTitles],
                    %% 消耗道具
                    mod_inv:destroy_goods_WNC(PlayerId, [NeedCost], ["lib_diy", "diy_title"]),
                    ets:insert(?ETS_DIY_TITLE, #diy_title{uid = PlayerId, titles = NewDiyTitles}),
                    %% 使用定制称号
                    {GoodsNo, _GoodsNum} = NeedCost,
                    {ok, Bin} =pt_51:write(51001, [ 0, GoodsNo ]),
                    lib_send:send_to_sock(player:get_PS(PlayerId), Bin),
                    ply_title:use_title(PlayerId, No);
                {fail, Reason} ->
                    lib_send:send_prompt_msg(PlayerId, Reason)
            end;
        false ->
            lib_send:send_prompt_msg(PlayerId,?PM_DIY_TITLE_ATTRS_NOT_CORRECT)
    end.

%% 开始定制门客
start_diy_partner(PS, Type, No, PartnerNo, SkillNo) ->
    PlayerId = player:get_id(PS),
    DiyPartner = data_diy_partner_config:get(No),
    NeedCost = lists:nth(Type, DiyPartner#diy_partner_config.cost),
    %% 道具是否足够
    case mod_inv:check_batch_destroy_goods(PlayerId, [NeedCost]) of
        ok ->
            PartnerNos = DiyPartner#diy_partner_config.partner_no,
            SkillNos = DiyPartner#diy_partner_config.skill_no,
            %% 判断门客是否可以定制
            case lists:member(PartnerNo, PartnerNos) of
                true ->
                    %% 技能是否可以定制
                    case lists:member(SkillNo, SkillNos) of
                        true ->
                            case length(player:get_partner_id_list(PS)) >= player:get_partner_capacity(PS) of
                                true ->
                                    lib_send:send_prompt_msg(PlayerId,?PM_PAR_CARRY_LIMIT);
                                false ->
                                    %% 消耗道具
                                    mod_inv:destroy_goods_WNC(PlayerId, [NeedCost], ["lib_diy", "diy_partner"]),
                                    ExtraInfo = [{count_skill_passive, DiyPartner#diy_partner_config.passi_skill_limit},
                                                    {inborn_skill, [SkillNo]}],
                                    ply_partner:player_add_partner(PS, PartnerNo, ExtraInfo),

                                    {GoodsNo, _GoodsNum} = NeedCost,
                                    {ok, Bin} =pt_51:write(51002, [ 0, GoodsNo ]),
                                    lib_send:send_to_sock(player:get_PS(PlayerId), Bin)
                            end;
                        false ->
                            lib_send:send_prompt_msg(PlayerId,?PM_DIY_PARTNERSKILLNO_NOT_IN_GROUP)
                    end;
                false ->
                    lib_send:send_prompt_msg(PlayerId,?PM_DIY_PARTNERNO_NOT_IN_GROUP)
            end;
        {fail, Reason} ->
            lib_send:send_prompt_msg(PlayerId, Reason)
    end.

%% 开始时装定制
start_diy_fashion(PlayerId, No, FashionNo, EffectNo, AttrsNum) ->
    DiyFashion = data_diy_fashion_config:get(No),
    NeedCost = DiyFashion#diy_fashion_config.cost,
    %% 道具是否足够
    case mod_inv:check_batch_destroy_goods(PlayerId, [NeedCost]) of
        ok ->
            FashionNos = DiyFashion#diy_fashion_config.fashion_no,
            EffectNos = DiyFashion#diy_fashion_config.fashion_effect_no,
            %% 判断时装是否可以定制
            case lists:member(FashionNo, FashionNos) of
                true ->
                    %% 特效是否可以定制
                    case lists:member(EffectNo, EffectNos) of
                        true ->
                            case DiyFashion#diy_fashion_config.fashion_add_attr_num =:= length(AttrsNum) of
                                true ->
                                    Type = DiyFashion#diy_fashion_config.type,
                                    %% 基础属性
                                    GoodsTpl = lib_goods:get_tpl_data(FashionNo),
                                    BaseAttrList = lib_equip:get_attr_name_and_base_list(GoodsTpl),
                                    %% 附加属性
                                    FashionAttrAdd = DiyFashion#diy_fashion_config.fashion_add_attr,
                                    F = fun(X, Attr) ->
                                        {AttrName, AttrValue1, AttrValue2} = lists:nth(X, FashionAttrAdd),
                                        NewAttr = {0, AttrName, AttrValue1, AttrValue2},
                                        [NewAttr | Attr]
                                        end,
                                    AttrsList = lists:foldl(F, [], AttrsNum),
                                    %% 消耗道具
                                    mod_inv:destroy_goods_WNC(PlayerId, [NeedCost], ["lib_diy", "diy_fashion"]),
                                    ExtraInitInfo = [{base_equip_add, BaseAttrList}, {addi_equip_add, AttrsList}, {addi_equip_eff_no, EffectNo}, {custom_type, Type}],
                                    mod_inv:batch_smart_add_new_goods(PlayerId, [{FashionNo, 1}], ExtraInitInfo, ["diy_fashion"]),

                                    {GoodsNo, _GoodsNum} = NeedCost,
                                    {ok, Bin} =pt_51:write(51003, [ 0, GoodsNo ]),
                                    lib_send:send_to_sock(player:get_PS(PlayerId), Bin);
                                false ->
                                    lib_send:send_prompt_msg(PlayerId,?PM_DIY_TITLE_ATTRS_NOT_CORRECT)
                            end;
                        false ->
                            lib_send:send_prompt_msg(PlayerId,?PM_DIY_EFFECTNO_NOT_IN_GROUP)
                    end;
                false ->
                    lib_send:send_prompt_msg(PlayerId,?PM_DIY_FASHION_NOT_IN_GROUP)
            end;
        {fail, Reason} ->
            lib_send:send_prompt_msg(PlayerId, Reason)
    end.

%% 开始定制翅膀
start_diy_wing(PlayerId, No, WingNo, AttrsNum) ->
    DiyWing = data_diy_chibang_config:get(No),
    %% 道具是否足够
    NeedCost = DiyWing#diy_chibang_config.cost,
    case mod_inv:check_batch_destroy_goods(PlayerId, [NeedCost]) of
        ok ->
            WingNos = DiyWing#diy_chibang_config.chibang_no,
            %% 判断翅膀是否可以定制
            case lists:member(WingNo, WingNos) of
                true ->
                    case DiyWing#diy_chibang_config.chibang_add_attr_num =:= length(AttrsNum) of
                        true ->
                            %% 消耗道具
                            mod_inv:destroy_goods_WNC(PlayerId, [NeedCost], ["lib_diy", "diy_wing"]),
                            lib_wing:add_wing(PlayerId, WingNo, No, AttrsNum),

                            {GoodsNo, _GoodsNum} = NeedCost,
                            {ok, Bin} =pt_51:write(51004, [ 0, GoodsNo ]),
                            lib_send:send_to_sock(player:get_PS(PlayerId), Bin);
                        false ->
                            lib_send:send_prompt_msg(PlayerId,?PM_DIY_TITLE_ATTRS_NOT_CORRECT)
                    end;
                false ->
                    lib_send:send_prompt_msg(PlayerId,?PM_DIY_WING_NOT_IN_GROUP)
            end;
        {fail, Reason} ->
            lib_send:send_prompt_msg(PlayerId, Reason)
    end.

%% 开始定制坐骑
start_diy_mount(PS, Type, No, MountNo, AttrsNum) ->
    PlayerId = player:get_id(PS),
    DiyMount = data_diy_mount_config:get(No),
    %% 道具是否足够
    NeedCost = lists:nth(Type, DiyMount#diy_mount_config.cost),
    case mod_inv:check_batch_destroy_goods(PlayerId, [NeedCost]) of
        ok ->
            MountNos = DiyMount#diy_mount_config.mount_no,
            %% 判断坐骑是否可以定制
            case lists:member(MountNo, MountNos) of
                true ->
                    case length(AttrsNum) =:= 3 of
                        true ->
                            %% 判断是否可定制
                            MaxMountCount = data_special_config:get('mount_num'),
                            case length(player:get_mount_id_list(PS)) >= MaxMountCount of
                                true -> lib_send:send_prompt_msg(PlayerId,?PM_MOUNT_OVER_MAX_COUNT);
                                false ->
                                    NoList = lib_mount:get_mount_nos(PS),
                                    case data_mount:get_mount_info(MountNo) of
                                        null ->
                                            ?ASSERT(false, MountNo),
                                            lib_send:send_prompt_msg(PlayerId, ?PM_DATA_CONFIG_ERROR);
                                        _Any ->
                                            case lists:member(MountNo,NoList) of
                                                true ->
                                                    lib_send:send_prompt_msg(PlayerId, ?PM_YOU_HAVE_DIY_MOUNT);
                                                false ->
                                                    %% 消耗道具
                                                    mod_inv:destroy_goods_WNC(PlayerId, [NeedCost], ["lib_diy", "diy_mount"]),
                                                    CustomType = DiyMount#diy_mount_config.type,
                                                    PartnerMaxNum = DiyMount#diy_mount_config.mount_effect_par_num,
                                                    AttributeAdd1  = util:rand(DiyMount#diy_mount_config.attr_min1,DiyMount#diy_mount_config.attr_max1),
                                                    AttributeAdd2  = util:rand(DiyMount#diy_mount_config.attr_min2,DiyMount#diy_mount_config.attr_max2),
                                                    AttributeAdd3  = util:rand(DiyMount#diy_mount_config.attr_min3,DiyMount#diy_mount_config.attr_max3),
                                                    ExtraInfo = [{attribute_1, lists:nth(1, AttrsNum)}, {attribute_2, lists:nth(2, AttrsNum)}, {attribute_3, lists:nth(3, AttrsNum)},
                                                        {attribute_add1, AttributeAdd1}, {attribute_add2, AttributeAdd2}, {attribute_sub, AttributeAdd3}, {custom_type, CustomType}, {partner_maxnum, PartnerMaxNum}],
                                                    lib_mount:player_add_mount(PS, MountNo, ExtraInfo),

                                                    {GoodsNo, _GoodsNum} = NeedCost,
                                                    {ok, Bin} =pt_51:write(51005, [ 0, GoodsNo ]),
                                                    lib_send:send_to_sock(player:get_PS(PlayerId), Bin)
                                            end
                                    end
                            end;
                        false ->
                            lib_send:send_prompt_msg(PlayerId,?PM_DIY_TITLE_ATTRS_NOT_CORRECT)
                    end;
                false ->
                    lib_send:send_prompt_msg(PlayerId,?PM_DIY_MOUNT_NOT_IN_GROUP)
            end;
        {fail, Reason} ->
            lib_send:send_prompt_msg(PlayerId, Reason)
    end.

%% 开始定制装备
start_diy_equip(PlayerId, Type, No, EquipNo, EffectNo, SkillNo, AttrsNum) ->
    DiyEquip = data_diy_equip_config:get(No),
    %% 道具是否足够
    NeedCost = lists:nth(Type, DiyEquip#diy_equip_config.cost),
    case mod_inv:check_batch_destroy_goods(PlayerId, [NeedCost]) of
        ok ->
            EquipNos = DiyEquip#diy_equip_config.equip_no,
            %% 判断装备是否可以定制
            case lists:member(EquipNo, EquipNos) of
                true ->
                    EffectNos = DiyEquip#diy_equip_config.equip_effect_no,
                    case lists:member(EffectNo, EffectNos) of
                        true ->
                            SkillNos = DiyEquip#diy_equip_config.equip_skill_no,
                            case lists:member(SkillNo, SkillNos) of
                                true ->
                                    case DiyEquip#diy_equip_config.equip_add_attr_num =:= length(AttrsNum) of
                                        true ->
                                            %% 消耗道具
                                            mod_inv:destroy_goods_WNC(PlayerId, [NeedCost], ["lib_diy", "diy_equip"]),
                                            %% 基础属性
                                            BaseAttrList = get_base_equip_add(EquipNo),
                                            BaseAddAttrList = get_addi_equip_add(DiyEquip, AttrsNum),
                                            MakeName = player:get_name(PlayerId),

                                            ExtraInitInfo = [{base_equip_add, BaseAttrList}, {addi_equip_add, BaseAddAttrList},{maker_name, MakeName},{quality, 6},
                                                {addi_equip_eff_no, EffectNo}, {addi_equip_stunt_no, SkillNo}, {custom_type, DiyEquip#diy_equip_config.type}],
                                            mod_inv:batch_smart_add_new_goods(PlayerId, [{EquipNo, 1}], ExtraInitInfo, ["diy_equip"]),

                                            {GoodsNo, _GoodsNum} = NeedCost,
                                            {ok, Bin} =pt_51:write(51006, [ 0, GoodsNo ]),
                                            lib_send:send_to_sock(player:get_PS(PlayerId), Bin);
                                        false ->
                                            lib_send:send_prompt_msg(PlayerId,?PM_DIY_TITLE_ATTRS_NOT_CORRECT)
                                    end;
                                false ->
                                    lib_send:send_prompt_msg(PlayerId,?PM_DIY_PARTNERSKILLNO_NOT_IN_GROUP)
                            end;
                        false ->
                            lib_send:send_prompt_msg(PlayerId,?PM_DIY_EFFECTNO_NOT_IN_GROUP)
                    end;
                false ->
                    lib_send:send_prompt_msg(PlayerId,?PM_DIY_EQUIP_NOT_IN_GROUP)
            end;
        {fail, Reason} ->
            lib_send:send_prompt_msg(PlayerId, Reason)
    end.

%% 定制道具兑换/分解
start_goods_exchange(PlayerId, Type, GoodsNo, Count) ->
    case data_diy_exchange_decompose:get(GoodsNo,Type) of
        null -> lib_send:send_prompt_msg(PlayerId,?PM_GOODS_NOT_EXISTS);
        ExchangeInfo ->
            %% 1兑换，2分解
            case Type of
                1 ->
                    NeedGoodsNo = ExchangeInfo#diy_exchange_decompose.get_goods,
                    NeedGoodsNum = ExchangeInfo#diy_exchange_decompose.get_goods_num * Count,
                    GetGoodsNo = ExchangeInfo#diy_exchange_decompose.goods_no,
                    %% 是否足够道具
                    case mod_inv:check_batch_destroy_goods(PlayerId, [{NeedGoodsNo, NeedGoodsNum}]) of
                        ok ->
                            %% 检测背包是否已满
                            case mod_inv:check_batch_add_goods(PlayerId, [{GetGoodsNo, Count}]) of
                                {fail, _Reason} ->
                                    lib_send:send_prompt_msg(PlayerId, ?PM_US_BAG_FULL);
                                _ ->
                                    mod_inv:destroy_goods_WNC(PlayerId, [{NeedGoodsNo, NeedGoodsNum}], ["lib_diy", "exchange_goods"]),
                                    mod_inv:batch_smart_add_new_goods(PlayerId, [{GetGoodsNo, Count}], [{bind_state, 1}], ["lib_diy", "exchange_goods"]),
                                    {ok, Bin} =pt_51:write(51007, [ 0, Type ]),
                                    lib_send:send_to_sock(player:get_PS(PlayerId), Bin)
                            end;
                        {fail, Reason} ->
                            lib_send:send_prompt_msg(PlayerId, Reason)
                    end;
                2 ->
                    NeedGoodsNo = ExchangeInfo#diy_exchange_decompose.goods_no,
                    GetGoodsNo = ExchangeInfo#diy_exchange_decompose.get_goods,
                    GetGoodsNum = ExchangeInfo#diy_exchange_decompose.get_goods_num * Count,
                    %% 是否足够道具
                    case mod_inv:check_batch_destroy_goods(PlayerId, [{NeedGoodsNo, Count}])  of
                        ok ->
                            %% 检测背包是否已满
                            case mod_inv:check_batch_add_goods(PlayerId, [{GetGoodsNo, GetGoodsNum}]) of
                                {fail, _Reason} ->
                                    lib_send:send_prompt_msg(PlayerId, ?PM_US_BAG_FULL);
                                _ ->
                                    mod_inv:destroy_goods_WNC(PlayerId, [{NeedGoodsNo, Count}], ["lib_diy", "exchange_goods"]),
                                    mod_inv:batch_smart_add_new_goods(PlayerId, [{GetGoodsNo, GetGoodsNum}], [{bind_state, 1}], ["lib_diy", "exchange_goods"]),
                                    {ok, Bin} =pt_51:write(51007, [ 0, Type ]),
                                    lib_send:send_to_sock(player:get_PS(PlayerId), Bin)
                            end;
                        {fail, Reason} ->
                            lib_send:send_prompt_msg(PlayerId, Reason)
                    end
            end
    end.

%% 获取定制装备基础属性
get_base_equip_add(GoodsNo) ->
    GoodsTpl = lib_goods:get_tpl_data(GoodsNo),
    BaseAttrList = lib_equip:get_attr_name_and_base_list(GoodsTpl),
    F = fun({AttrName, AttrBase}) ->
        RealValue = util:ceil(AttrBase * 1.4),  % 定制初始属性为红色最高 * 1.4
        ?ASSERT(RealValue >= 1),
        {AttrName, RealValue}
        end,
    [ F(X) || X <- BaseAttrList ].

%% 获取定制装备附加属性
get_addi_equip_add(EquipConfig, AttrsNum) ->
    ?ASSERT(is_record(EquipConfig, diy_equip_config)),
    EquipAddAttr = EquipConfig#diy_equip_config.equip_add_attr,
    F = fun(Num) ->
        {AttrName, AttrBase} = lists:nth(Num, EquipAddAttr),
        ?ASSERT(AttrBase >= 1),
        {0, AttrName, AttrBase, 0}
        end,
    [ F(X) || X <- AttrsNum ].