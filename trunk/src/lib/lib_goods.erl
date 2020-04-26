%%%--------------------------------------
%%% @Module  : lib_goods
%%% @Author  : huangjf,
%%% @Email   :
%%% @Created : 2013.5.15
%%% @Description : 物品的相关函数
%%%--------------------------------------
-module(lib_goods).

-export([
        get_tpl_data/1,
        is_tpl_exists/1,
        make_new_goods/4,
        make_new_goods_2/2,
        db_save_goods/1,
        db_insert_new_goods/1,
        db_delete_goods/2, db_delete_goods/1,
        set_show_base_equip_add/2,
        get_show_base_equip_add/1,

        get_owner_id/1, set_owner_id/2,
        get_partner_id/1,
        get_id/1, set_id/2,
        get_no/1,  get_no_by_id/1, get_goods_by_id/1, set_no/2,
        get_name/1,
        get_race/1,
        get_faction/1,
        get_camp/1,
        get_target_obj_type_list/1,
        get_lv/1,
        get_skill_lv_eff/2,
        get_tpl_lv/1,
        get_vip_lv/1,
        get_quality/1, set_quality/2,
        get_type/1,
        get_subtype/1,
        get_max_stack/1,
        get_effects/1,
        get_effects_name_list/1,
        get_sell_price_type/1,
        get_sell_price/1,
        get_sex/1,
		get_use_cost_money/1,
        get_use_cost_goods/1,
        get_timekeeping_type/1,
        get_when_begin_timekeeping/1,
        get_base_equip_add/1, set_base_equip_add/2,
        get_addi_equip_add/1, get_addi_ep_add_kv/1, set_addi_equip_add/2, set_addi_ep_add_kv/2,
        get_stren_equip_add/1,
        get_addi_equip_eff_no/1,
        get_bind_state/1, set_bind_state/2,
        get_equip_prop/1, add_stren_exp/2, get_stren_lv/1, set_stren_lv/2, get_stren_exp/1, set_stren_exp/2, get_equip_gemstone/1, set_equip_gemstone/2,
        get_gem_id_list/1, get_stren_exp_lim/2,

        get_location/1, set_location/2,
        get_slot/1, set_slot/2,
        get_count/1, set_count/2,
        get_time_on_mark_dirty/1,
        get_usable_times/1, set_usable_times/2,
        get_extra/2, set_extra/3, set_extra/2,
        get_sell_time/1,
        get_first_use_time/1, set_first_use_time/2,
        get_expire_time/1, set_expire_time/2,
        get_time_on_last_save_valid_time/1, set_time_on_last_save_valid_time/2,
        get_cfg_valid_time/1,
        get_left_valid_time/1, set_left_valid_time/2,
        timekeeping_start/1,
        get_battle_power/1, set_battle_power/2,
        get_use_limit/1, get_use_limit_time/1,
        get_statistics_state/1,
        get_quality_lv/1, set_quality_lv/2,
        get_purchase_price/1, set_purchase_price/2,
        get_equip_effect/1, set_equip_effect/2,

        get_equip_stunt/1, set_equip_stunt/2,

        % 幻化相关
        set_transmo_ref_attr/2, set_transmo_last_ref_attr/2,
        get_transmo_ref_attr/1, get_transmo_last_ref_attr/1,
        set_transmo_eff_no/2, set_transmo_last_eff_no/2,
        get_transmo_eff_no/1, get_transmo_last_eff_no/1,

        get_purchase_price_type/1,set_purchase_price_type/2,    
        get_maker_name/1,set_maker_name/2,check_maker_name/2,
        get_last_ref_attr/1,set_last_ref_attr/2,
        get_last_base_attr/1,set_last_base_attr/2,
        get_last_sell_time/1,set_last_sell_time/2,
        get_mk_skill_list/1, set_mk_skill_list/2,
        get_equip_eff_temp_no/1, set_equip_eff_temp_no/2,
        get_equip_stunt_temp_no/1, set_equip_stunt_temp_no/2,
        get_equip_stunt_refresh_time/1, set_equip_stunt_refresh_time/2,
        get_equip_eff_refresh_time/1, set_equip_eff_refresh_time/2,
        get_equip_high_stunt_refresh_time/1, set_equip_high_stunt_refresh_time/2,
        get_equip_high_eff_refresh_time/1, set_equip_high_eff_refresh_time/2,
        get_contri_need_when_puton/1,
        mk_magic_key_skill_list/1,
        mk_magic_key_skill_list/5,

        is_can_discard/1,
        is_can_sell/1,
        is_can_trade/1,
        is_dirty/1, set_dirty/2,
        is_can_use/1,
        is_can_use_on_obj_type/2,
        is_can_use_on_ally/1, is_can_use_on_enemy/1,
        is_can_batch_use/1,
        is_can_use_in_battle/1,
        is_can_equiped/1,
        is_can_store/1, can_present/1,
        is_gift/1,
        %is_random/1,
        is_equip/1, is_fashion/1, is_magic_key/1,
        is_mount/1,
        %is_random_equip/1,
        is_can_stack/1,
        is_weapon/1,
        is_armor/1,
        is_in_timekeeping/1,
        is_timing_goods/1,
        is_expired/1,
        is_expired_on_zero/1,

        is_task_goods/1,    % 是否是任务物品
        is_gem_goods/1,
        is_trigger_accept_task_goods/1, % 是否是触发接受任务物品
        is_partner_goods/1, is_partner_equip/1,
        get_equip_pos/1,
        % ...

        is_valid_bind_state/1,
        is_valid_quality/1,

        decide_bag_location/1,

        extract_nonzero_fields_info_from/1,
        get_field_index_in_equip_prop/1,
        my_ets_inv_goods/1,
		get_cross_goods_data/3,
		get_goods_data/2

    ]).

% 以后再统一决定哪些函数要inline --- huangjf
% -compile({inline, [get_owner_id/1, get_partner_id/1, get_id/1, get_no/1, get_lv/1, get_race/1, get_faction/1,
%                     get_type/1, get_subtype/1,
%                     get_location/1, set_location/2,
%                     get_slot/1, set_slot/2,
%                     get_count/1, set_count/2,
%                     get_time_on_mark_dirty/1,
%                     is_dirty/1, is_equip/1
%                   ]
%         }).

-include("common.hrl").
-include("record.hrl").
-include("goods.hrl").
-include("record/goods_record.hrl").
-include("equip.hrl").
-include("inventory.hrl").
-include("attribute.hrl").
-include("ets_name.hrl").
-include("effect.hrl").
-include("num_limits.hrl").
-include("scene.hrl").
-include("log.hrl").
-include("equip.hrl").
-include("prompt_msg_code.hrl").
%% 获取物品的模板数据
%% @return: null | goods_tpl结构体
get_tpl_data(GoodsNo) ->
    case data_goods:get(GoodsNo) of
        GoodsTpl when is_record(GoodsTpl, goods_tpl) ->
            GoodsTpl;
        _ ->
            null
    end.

%% 指定编号的物品模板是否存在？
%% @return: true（存在） | false（不存在）
is_tpl_exists(GoodsNo) ->
    get_tpl_data(GoodsNo) /= null.

get_statistics_state(GoodsTpl) when is_record(GoodsTpl, goods_tpl) ->
    GoodsTpl#goods_tpl.statistics;
get_statistics_state(Goods) ->
    GoodsTpl = get_tpl_data(Goods#goods.no),
    GoodsTpl#goods_tpl.statistics.

get_name(GoodsNo) when is_integer(GoodsNo) ->
    GoodsTpl = get_tpl_data(GoodsNo),
    GoodsTpl#goods_tpl.name;
get_name(Goods) when is_record(Goods, goods) ->
    GoodsTpl = get_tpl_data(Goods#goods.no),
    GoodsTpl#goods_tpl.name.



%% 获取由策划配置的有效时间
get_cfg_valid_time(GoodsTpl) when is_record(GoodsTpl, goods_tpl) ->
    GoodsTpl#goods_tpl.valid_time;
get_cfg_valid_time(Goods) when is_record(Goods, goods) ->
    (get_tpl_data(Goods#goods.no))#goods_tpl.valid_time.

%% 获取物品编号
get_no(Goods) when is_record(Goods, goods) ->
    Goods#goods.no;
get_no(GoodsTpl) when is_record(GoodsTpl, goods_tpl) ->
    GoodsTpl#goods_tpl.no.

set_no(Goods, No) ->
    Goods#goods{no = No}.

%% 依据物品id，获取对应的物品编号
get_no_by_id(GoodsId) ->
    case mod_inv:get_goods_from_ets(GoodsId) of
        null ->
            ?INVALID_NO;
        Goods ->
            Goods#goods.no
    end.


get_goods_by_id(GoodsId) ->
    case mod_inv:get_goods_from_ets(GoodsId) of
        null ->
            null;
        Goods ->
            Goods
    end.


%% 获取种族
get_race(GoodsTpl) when is_record(GoodsTpl, goods_tpl) ->
    GoodsTpl#goods_tpl.race;
get_race(Goods) when is_record(Goods, goods) ->
    (get_tpl_data(Goods#goods.no))#goods_tpl.race;
get_race(GoodsNo) ->
    GoodsTpl = get_tpl_data(GoodsNo),
    get_race(GoodsTpl).

%% 获取门派
get_faction(GoodsTpl) when is_record(GoodsTpl, goods_tpl) ->
    GoodsTpl#goods_tpl.faction;
get_faction(Goods) when is_record(Goods, goods) ->
    (get_tpl_data(Goods#goods.no))#goods_tpl.faction;
get_faction(GoodsNo) ->
    GoodsTpl = get_tpl_data(GoodsNo),
    get_faction(GoodsTpl).

%% 获取阵营
get_camp(GoodsTpl) when is_record(GoodsTpl, goods_tpl) ->
    GoodsTpl#goods_tpl.camp;
get_camp(Goods) when is_record(Goods, goods) ->
    (get_tpl_data(Goods#goods.no))#goods_tpl.camp.

%% 获取使用物品所针对的目标对象类型列表
get_target_obj_type_list(GoodsTpl) when is_record(GoodsTpl, goods_tpl) ->
    GoodsTpl#goods_tpl.target_obj_type_list;
get_target_obj_type_list(Goods) when is_record(Goods, goods) ->
    (get_tpl_data(Goods#goods.no))#goods_tpl.target_obj_type_list.

% 获取模板等级
get_tpl_lv(GoodsTpl) when is_record(GoodsTpl, goods_tpl) ->
    GoodsTpl#goods_tpl.lv;

get_tpl_lv(Goods) when is_record(Goods, goods) ->
    (get_tpl_data(Goods#goods.no))#goods_tpl.lv.

%% 获取等级
get_lv(GoodsTpl) when is_record(GoodsTpl, goods_tpl) ->
    GoodsTpl#goods_tpl.lv;

get_lv(Goods) when is_record(Goods, goods) ->
	% 增加判断是否有简易类特效
	CutLevel = case get_equip_effect(Goods) of 
		0 ->
            case lib_goods:get_transmo_eff_no(Goods) of
                0 ->
                    0;
                No ->
                    EquipEff = data_equip_speci_effect:get(No),
                    EffName = EquipEff#equip_speci_effect_tpl.eff_name,
                    Value = EquipEff#equip_speci_effect_tpl.value,

                    case EffName of
                        ?EQUIP_EFFECT_NO_LEVEL -> -Value;
                        _ -> 0
                    end
            end;

		EquipEffNo ->
            case lib_goods:get_transmo_eff_no(Goods) of
                0 ->
                    EquipEff = data_equip_speci_effect:get(EquipEffNo),
                    EffName = EquipEff#equip_speci_effect_tpl.eff_name,
                    Value = EquipEff#equip_speci_effect_tpl.value,

                    case EffName of
                        ?EQUIP_EFFECT_NO_LEVEL -> -Value;
                        _ -> 0
                    end;
                No ->
                    EquipEff2 = data_equip_speci_effect:get(EquipEffNo),
                    EffName2 = EquipEff2#equip_speci_effect_tpl.eff_name,
                    Value2 = EquipEff2#equip_speci_effect_tpl.value,

                    EquipEff3 = data_equip_speci_effect:get(No),
                    EffName3 = EquipEff3#equip_speci_effect_tpl.eff_name,
                    Value3 = EquipEff3#equip_speci_effect_tpl.value,

                    case EffName2 =:= ?EQUIP_EFFECT_NO_LEVEL andalso EffName2 =:= ?EQUIP_EFFECT_NO_LEVEL of
                        false ->
                            case EffName2 of
                                ?EQUIP_EFFECT_NO_LEVEL -> -Value2;
                                _ ->
                                    case EffName3 of
                                        ?EQUIP_EFFECT_NO_LEVEL -> -Value3;
                                        _ -> 0
                                    end
                            end;
                        true ->
                            MaxValue = lists:max([Value2, Value3]),
                            -MaxValue
                    end
            end

	end,

	% ?DEBUG_MSG("CutLevel=~p",[CutLevel]),

    (get_tpl_data(Goods#goods.no))#goods_tpl.lv + CutLevel.

% 获取技能类特效
get_skill_lv_eff(Goods,SkillNo) when is_record(Goods, goods) ->
    % 是否有既能增加特效
    AddLevel = case get_equip_effect(Goods) of 
        0 -> 0;
        EquipEffNo ->

        EquipEff = data_equip_speci_effect:get(EquipEffNo),
        EffName = EquipEff#equip_speci_effect_tpl.eff_name,
        Value = EquipEff#equip_speci_effect_tpl.value,

        case EffName of 
            ?EQUIP_EFFECT_ADD_SKILL_LV -> 
                case Value of
                    {SkillNo,Lv} -> Lv;
                    _O -> 0
                end;
            _ -> 0
        end
    end,
    AddLevel.

%% 获取vip等级限制
get_vip_lv(GoodsTpl) when is_record(GoodsTpl, goods_tpl) ->
    GoodsTpl#goods_tpl.vip_lv;
get_vip_lv(Goods) when is_record(Goods, goods) ->
    (get_tpl_data(Goods#goods.no))#goods_tpl.vip_lv.

%% 获取类型
get_type(GoodsTpl) when is_record(GoodsTpl, goods_tpl) ->
    GoodsTpl#goods_tpl.type;
get_type(Goods) when is_record(Goods, goods) ->
    (get_tpl_data(Goods#goods.no))#goods_tpl.type.

%% 获取子类型
get_subtype(GoodsTpl) when is_record(GoodsTpl, goods_tpl) ->
    GoodsTpl#goods_tpl.subtype;
get_subtype(Goods) when is_record(Goods, goods) ->
    (get_tpl_data(Goods#goods.no))#goods_tpl.subtype.

%% 获取叠加数量上限
get_max_stack(GoodsTpl) when is_record(GoodsTpl, goods_tpl) ->
    GoodsTpl#goods_tpl.max_stack;
get_max_stack(Goods) when is_record(Goods, goods) ->
    (get_tpl_data(Goods#goods.no))#goods_tpl.max_stack.

%% 获取效果
get_effects(GoodsTpl) when is_record(GoodsTpl, goods_tpl) ->
    GoodsTpl#goods_tpl.effects;
get_effects(Goods) when is_record(Goods, goods) ->
    (get_tpl_data(Goods#goods.no))#goods_tpl.effects.

get_effects_name_list(GoodsTpl) when is_record(GoodsTpl, goods_tpl) ->
    EffectsNo = GoodsTpl#goods_tpl.effects,
    [(data_goods_eff:get(No))#goods_eff.name || No <- EffectsNo];
get_effects_name_list(Goods) when is_record(Goods, goods) ->
    GoodsTpl = get_tpl_data(Goods#goods.no),
    get_effects_name_list(GoodsTpl).


%% 获取价格类型
get_sell_price_type(GoodsTpl) when is_record(GoodsTpl, goods_tpl) ->
    GoodsTpl#goods_tpl.sell_price_type;
get_sell_price_type(Goods) when is_record(Goods, goods) ->
    (get_tpl_data(Goods#goods.no))#goods_tpl.sell_price_type.

%% 获取卖出价格
get_sell_price(GoodsTpl) when is_record(GoodsTpl, goods_tpl) ->
    GoodsTpl#goods_tpl.sell_price;
get_sell_price(Goods) when is_record(Goods, goods) ->
    (get_tpl_data(Goods#goods.no))#goods_tpl.sell_price.

%% 获取性别限制
get_sex(GoodsTpl) when is_record(GoodsTpl, goods_tpl) ->
    GoodsTpl#goods_tpl.sex;
get_sex(Goods) when is_record(Goods, goods) ->
    (get_tpl_data(Goods#goods.no))#goods_tpl.sex;
get_sex(GoodsNo) ->
    GoodsTpl = get_tpl_data(GoodsNo),
    get_sex(GoodsTpl).


%% 获取使用消耗
get_use_cost_money(GoodsTpl) when is_record(GoodsTpl, goods_tpl) ->
    GoodsTpl#goods_tpl.use_need_money;
get_use_cost_money(Goods) when is_record(Goods, goods) ->
    (get_tpl_data(Goods#goods.no))#goods_tpl.use_need_money;
get_use_cost_money(GoodsNo) ->
    GoodsTpl = get_tpl_data(GoodsNo),
    get_use_cost_money(GoodsTpl).

get_use_cost_goods(GoodsTpl) when is_record(GoodsTpl, goods_tpl) ->
    GoodsTpl#goods_tpl.use_need_goods;
get_use_cost_goods(Goods) when is_record(Goods, goods) ->
    (get_tpl_data(Goods#goods.no))#goods_tpl.use_need_goods;
get_use_cost_goods(GoodsNo) ->
    GoodsTpl = get_tpl_data(GoodsNo),
    get_use_cost_goods(GoodsTpl).


%% 获取计时方式
get_timekeeping_type(GoodsTpl) when is_record(GoodsTpl, goods_tpl) ->
    GoodsTpl#goods_tpl.timekeeping_type;
get_timekeeping_type(Goods) when is_record(Goods, goods) ->
    (get_tpl_data(Goods#goods.no))#goods_tpl.timekeeping_type.

%% 获取何时开始计时，默认无（0：无， 1：获取即开始计时，2：第一次使用后开始计时）
get_when_begin_timekeeping(GoodsTpl) when is_record(GoodsTpl, goods_tpl) ->
    GoodsTpl#goods_tpl.when_begin_timekeeping;
get_when_begin_timekeeping(Goods) when is_record(Goods, goods) ->
    (get_tpl_data(Goods#goods.no))#goods_tpl.when_begin_timekeeping.

get_bind_state(GoodsTpl) when is_record(GoodsTpl, goods_tpl) ->
    GoodsTpl#goods_tpl.bind_state;
get_bind_state(Goods) when is_record(Goods, goods) ->
    Goods#goods.bind_state.

set_bind_state(Goods, State) ->
    Goods#goods{bind_state = State}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 获取物品唯一id
get_id(Goods) -> Goods#goods.id.

set_id(Goods, GoodsId) ->
    Goods#goods{id = GoodsId}.

%% 获取所属玩家的id
get_owner_id(Goods) -> Goods#goods.player_id.

set_owner_id(Goods, OwnerId) ->
    Goods#goods{player_id = OwnerId}.

%% 获取武将id（装备穿在武将身上时对应武将的唯一Id）
get_partner_id(Goods) -> Goods#goods.partner_id.

%% 获取物品品质
get_quality(GoodsNo) when is_integer(GoodsNo) ->
    (get_tpl_data(GoodsNo))#goods_tpl.quality;
get_quality(GoodsTpl) when is_record(GoodsTpl, goods_tpl) ->
    GoodsTpl#goods_tpl.quality;
get_quality(Goods) -> Goods#goods.quality.

set_quality(Goods, Value) ->
    Goods#goods{quality = Value}.

%% 获取上次标记物品为脏时的服务器时钟滴答计数
get_time_on_mark_dirty(Goods) -> Goods#goods.time_on_mark_dirty.

%% 获取/设置过期时间（unix时间戳）
get_expire_time(Goods) ->
    Goods#goods.expire_time.
set_expire_time(Goods, UnixTime) ->
    ?ASSERT(is_integer(UnixTime) andalso UnixTime > 0),
    Goods#goods{expire_time = UnixTime}.

%% 获取/设置上次保存物品的剩余有效时间到DB时的时间点（unix时间戳）
get_time_on_last_save_valid_time(Goods) ->
    Goods#goods.time_on_last_save_valid_time.
set_time_on_last_save_valid_time(Goods, UnixTime) ->
    Goods#goods{time_on_last_save_valid_time = UnixTime}.

%% 获取/设置时效物品的剩余有效时间（单位：秒）
get_left_valid_time(Goods) ->
    ?ASSERT(is_timing_goods(Goods), Goods),   % 断言是时效物品
    case is_in_timekeeping(Goods) of
        true ->

            TimekpType = get_timekeeping_type(Goods),
            WhenBeginTimekp = get_when_begin_timekeeping(Goods),

            case WhenBeginTimekp of
                ?WBTKP_ON_GOT ->
                    case TimekpType of
                        ?TKP_BY_REAL ->
                            LeftTime = get_expire_time(Goods) - svr_clock:get_unixtime(),
                            erlang:max(LeftTime, 0);   % 过期则统一返回0，故矫正
                        ?TKP_BY_ACC_ONLINE ->
                            Goods#goods.valid_time
                    end;
                ?WBTKP_ON_FIRST_USE ->
                    case TimekpType of
                        ?TKP_BY_REAL ->
                            LeftTime = (get_first_use_time(Goods) + get_cfg_valid_time(Goods)) - svr_clock:get_unixtime(),
                            erlang:max(LeftTime, 0);   % 过期则统一返回0，故矫正
                        ?TKP_BY_ACC_ONLINE ->
                            Goods#goods.valid_time
                    end
            end;            
        false ->
            Goods#goods.valid_time
    end.
set_left_valid_time(Goods, LeftValidTime) ->
    ?ASSERT(is_integer(LeftValidTime) andalso LeftValidTime >= 0),
    ?ASSERT(is_timing_goods(Goods), Goods),   % 断言是时效物品
    Goods#goods{valid_time = LeftValidTime}.


%% 处理开始计时
%% @return: 更新后的goods结构体
timekeeping_start(Goods) ->
    ?ASSERT(is_record(Goods, goods)),
    ?ASSERT(is_timing_goods(Goods)),
    TimeNow = svr_clock:get_unixtime(),
    CfgValidTime = 
        case is_expired_on_zero(Goods) of
            false -> get_cfg_valid_time(Goods);
            true -> 24*3600 - (TimeNow - util:calc_today_0_sec())
        end,
    
    % ?ASSERT(CfgValidTime > 0, Goods),
    RetGoods = case get_timekeeping_type(Goods) of
        ?TKP_BY_REAL ->
            set_expire_time(Goods, TimeNow + CfgValidTime);
        ?TKP_BY_ACC_ONLINE ->
            Goods2 = set_left_valid_time(Goods, CfgValidTime),
            set_time_on_last_save_valid_time(Goods2, TimeNow)
    end,
    ?ASSERT(is_record(RetGoods, goods)),
    RetGoods.


get_battle_power(Goods) ->
    Goods#goods.battle_power.

set_battle_power(#goods{battle_power=BattlePower}=Goods, BattlePower) ->
    Goods;
set_battle_power(#goods{}=Goods, BattlePower) ->
    Goods1 = Goods#goods{battle_power = BattlePower},
    mod_rank:equip_battle_power(Goods1),
    Goods1.

get_use_limit(Goods) when is_record(Goods, goods) ->
    (get_tpl_data(Goods#goods.no))#goods_tpl.use_limit;
get_use_limit(GoodsTpl) ->
    GoodsTpl#goods_tpl.use_limit.

get_use_limit_time(Goods) when is_record(Goods, goods) ->
    (get_tpl_data(Goods#goods.no))#goods_tpl.use_limit_time;

get_use_limit_time(GoodsTpl) ->
    GoodsTpl#goods_tpl.use_limit_time.

%% 获取装备的属性加成
get_base_equip_add(Goods) when is_record(Goods, goods) ->
    Goods#goods.base_equip_add.
set_base_equip_add(Goods, Attr) when is_record(Attr, attrs) ->
    Goods#goods{base_equip_add = Attr}.

get_addi_equip_add(Goods) when is_record(Goods, goods) ->
    Goods#goods.addi_equip_add.

set_addi_equip_add(Goods, Attr) when is_record(Goods, goods) andalso is_record(Attr, attrs) ->
    Goods#goods{addi_equip_add = Attr}.

get_show_base_equip_add(Goods) when is_record(Goods, goods) ->
    Goods#goods.show_base_attr.

set_show_base_equip_add(Goods, ShowAttr) when is_record(Goods, goods)  ->
    Goods#goods{show_base_attr = ShowAttr}.

get_addi_ep_add_kv(Goods) when is_record(Goods, goods) ->
    Goods#goods.addi_ep_add_kv;
get_addi_ep_add_kv(_) ->
    [].

set_addi_ep_add_kv(Goods, Value) when is_record(Goods, goods) andalso is_list(Value) ->
    Goods#goods{addi_ep_add_kv = Value}.

get_stren_equip_add(Goods) when is_record(Goods, goods) ->
    Goods#goods.stren_equip_add.

get_addi_equip_eff_no(Goods) when is_record(Goods, goods) ->
    Goods#goods.addi_equip_eff.

%% 装备自身的额外特性（如：强化等级， 镶嵌， 洗练等）
get_equip_prop(Goods) when is_record(Goods, goods) ->
    Goods#goods.equip_prop.

get_stren_exp(Goods) ->
    ?ASSERT(is_record(Goods, goods), Goods),
    Goods#goods.equip_prop#equip_prop.stren_exp.

get_stren_lv(Goods) ->
    case is_equip(Goods) of
        false -> ?INVALID_NO;
        true ->
            ?ASSERT(is_record(Goods, goods), Goods),
            Goods#goods.equip_prop#equip_prop.stren_lv
    end.

%% 获取装备上的宝石列表
get_equip_gemstone(Goods) ->
    ?ASSERT(is_record(Goods, goods), Goods),
    ?ASSERT(is_equip(Goods), Goods),
    ?ASSERT(is_record(Goods#goods.equip_prop, equip_prop), {get_no(Goods), Goods#goods.equip_prop}),
    case is_equip(Goods) of
        false -> [];
        true -> Goods#goods.equip_prop#equip_prop.gem_inlay
    end.

set_equip_gemstone(Goods, GemInlay) ->
    ?ASSERT(is_record(Goods, goods) andalso is_list(GemInlay), {Goods, GemInlay}),
    EquipProp = Goods#goods.equip_prop#equip_prop{gem_inlay = GemInlay},
    Goods#goods{equip_prop = EquipProp}.


get_stren_exp_lim(StrenLv, GoodsLv) ->
    case StrenLv =:= 0 of
        true -> 0;
        false ->
          0
%%            Step = lib_equip:get_lv_step_for_strenthen(GoodsLv, sets:to_list(sets:from_list(data_equip_strenthen:get_all_lv_step_list())) ),
%%            DataList = data_equip_strenthen:get(Step),
%%            case StrenLv > length(DataList) of
%%                true -> ?MAX_U32;
%%                false ->
%%                    Data = lists:keyfind(StrenLv, #equip_strenthen.stren_lv, DataList),
%%                    Data#equip_strenthen.exp_next_lv_need
%%            end
    end.

set_stren_exp(Goods, Value) ->
    EquipProp = Goods#goods.equip_prop#equip_prop{stren_exp = Value},
    Goods#goods{equip_prop = EquipProp}.

set_stren_lv(Goods, Value) ->
    EquipProp = Goods#goods.equip_prop#equip_prop{stren_lv = Value},
    Goods#goods{equip_prop = EquipProp}.

%% return {ok, Goods, 是否升级(true|false)}
add_stren_exp(Goods, Exp) ->
    EquipProp = get_equip_prop(Goods),
    CurExp = EquipProp#equip_prop.stren_exp,
    CurStrenLv = EquipProp#equip_prop.stren_lv,
    Goods1 = set_stren_exp(Goods, CurExp + Exp),
    ExpLim = get_stren_exp_lim(CurStrenLv + 1, lib_goods:get_tpl_lv(Goods1)),
    case get_stren_exp(Goods1) < ExpLim of
        true ->
            {ok, Goods1, false};
        false ->
            {NewStrenLv, LeftExp} = change_stren_lv_by_stren_exp(CurStrenLv, Goods1),
            LeftExp1 =
                case NewStrenLv > CurStrenLv of
                    true -> 0;
                    false -> LeftExp
                end,
            Goods2 = set_stren_exp(Goods1, LeftExp1),
            Goods3 = set_stren_lv(Goods2, NewStrenLv),
            LvUp =
            case NewStrenLv > CurStrenLv of
                true -> true;
                false -> false
            end,
            {ok, Goods3, LvUp}
    end.


%% 获取/设置location
get_location(Goods) -> Goods#goods.location.
set_location(Goods, NewLocation) ->
    Goods#goods{location = NewLocation}.

%% 获取/设置所在的格子位置（从1开始算起）
get_slot(Goods) -> Goods#goods.slot.
set_slot(Goods, NewSlot) ->
    Goods#goods{slot = NewSlot}.

%% 获取/设置叠加数量
get_count(Goods) -> Goods#goods.count.
set_count(Goods, NewCount) ->
    Goods#goods{count = NewCount}.

%% 获取/设置当前剩余的可使用次数（注：规定可使用多次的物品不能叠加！）
%% @return: infinite(表示不限制次数，可以无限使用) | 次数（整数）
get_usable_times(Goods) when is_record(Goods, goods) ->
    case Goods#goods.usable_times of
        -1 ->
            infinite;
        _ ->
            Goods#goods.usable_times
    end;
get_usable_times(GoodsTpl) ->
    case GoodsTpl#goods_tpl.usable_times of
        -1 ->
            infinite;
        _ ->
            GoodsTpl#goods_tpl.usable_times
    end.
set_usable_times(Goods, NewTimes) ->
    ?ASSERT(is_integer(NewTimes) andalso NewTimes > 0),
    Goods#goods{usable_times = NewTimes}.

%% 获取/设置第一次使用物品的时间（unix时间戳）
get_first_use_time(Goods) -> Goods#goods.first_use_time.
set_first_use_time(Goods, UnixTime) ->
    ?ASSERT(is_integer(UnixTime) andalso UnixTime > 0),
    Goods#goods{first_use_time = UnixTime}.


get_quality_lv(Goods) ->
    case lists:keyfind(quality_lv, 1, Goods#goods.extra) of
        false -> 1;
        {_, Lv} -> Lv
    end.


set_quality_lv(Goods, Value) ->
    InfoTuple = {quality_lv, Value},
    case lists:keyfind(quality_lv, 1, Goods#goods.extra) of
        false ->  % 原先没有，则添加
            Goods#goods{extra = [InfoTuple | Goods#goods.extra]};
        _OldInfoTuple ->  % 原先已有，则更新
            NewExtraInfoList = lists:keyreplace(quality_lv, 1, Goods#goods.extra, InfoTuple),
            Goods#goods{extra = NewExtraInfoList}
    end.


% 获取买入价
get_purchase_price(Goods) ->
    case lists:keyfind(purchase_price, 1, Goods#goods.extra) of
        false -> 0;
        {_, Lv} -> Lv
    end.


% 设置买入价
set_purchase_price(Goods, Value) ->
    InfoTuple = {purchase_price, Value},

    case lists:keyfind(purchase_price, 1, Goods#goods.extra) of
        false ->  % 原先没有，则添加
            Goods#goods{extra = [InfoTuple | Goods#goods.extra]};
        _OldInfoTuple ->  % 原先已有，则更新
            NewExtraInfoList = lists:keyreplace(purchase_price, 1, Goods#goods.extra, InfoTuple),
            Goods#goods{extra = NewExtraInfoList}
    end.

% 检测是否有设置制造者名字
check_maker_name(Goods, Value) ->
    case lists:keyfind(maker_name, 1, Goods#goods.extra) of
        false ->  % 原先没有，则添加
            set_maker_name(Goods, Value);
        _OldInfoTuple ->  % 原先已有，则更新
            Goods
    end.

% 获取制造者的名字
get_maker_name(Goods) ->
    % ?DEBUG_MSG("Goods#goods.extra ~p",[Goods#goods.extra]),
    case lists:keyfind(maker_name, 1, Goods#goods.extra) of
        false -> null;
        {_, Name} -> Name
    end.

% 设置制造者的名字
set_maker_name(Goods, Value) ->
    InfoTuple = {maker_name, Value},
    % ?DEBUG_MSG("Goods#goods.extra ~p setName= ~p",[Goods#goods.extra,Value]),
    case lists:keyfind(maker_name, 1, Goods#goods.extra) of
        false ->  % 原先没有，则添加
            Goods#goods{extra = [InfoTuple | Goods#goods.extra]};
        _OldInfoTuple ->  % 原先已有，则更新
            NewExtraInfoList = lists:keyreplace(maker_name, 1, Goods#goods.extra, InfoTuple),
            Goods#goods{extra = NewExtraInfoList}
    end.

% 获取最后一次洗练出来的附加属性
get_last_ref_attr(Goods) ->
    % ?DEBUG_MSG("Goods#goods.extra ~p",[Goods#goods.extra]),
    case lists:keyfind(last_ref_attr, 1, Goods#goods.extra) of
        false -> null;
        {_, Attr} -> Attr
    end.

% 最后一次洗出来的属性
set_last_ref_attr(Goods,Value) ->
   InfoTuple = {last_ref_attr, Value},
    % ?DEBUG_MSG("Goods#goods.extra ~p setName= ~p",[Goods#goods.extra,Value]),
    case lists:keyfind(last_ref_attr, 1, Goods#goods.extra) of
        false ->  % 原先没有，则添加
            Goods#goods{extra = [InfoTuple | Goods#goods.extra]};
        _OldInfoTuple ->  % 原先已有，则更新
            NewExtraInfoList = lists:keyreplace(last_ref_attr, 1, Goods#goods.extra, InfoTuple),
            Goods#goods{extra = NewExtraInfoList}
    end.

% 获取最后一次洗练出来的基础属性
get_last_base_attr(Goods) ->
    % ?DEBUG_MSG("Goods#goods.extra ~p",[Goods#goods.extra]),
    case lists:keyfind(last_base_attr, 1, Goods#goods.extra) of
        false -> null;
        {_, Attr} -> Attr
    end.

% 最后一次洗出来的属性
set_last_base_attr(Goods,Value) ->
   InfoTuple = {last_base_attr, Value},
    % ?DEBUG_MSG("Goods#goods.extra ~p setName= ~p",[Goods#goods.extra,Value]),
    case lists:keyfind(last_base_attr, 1, Goods#goods.extra) of
        false ->  % 原先没有，则添加
            Goods#goods{extra = [InfoTuple | Goods#goods.extra]};
        _OldInfoTuple ->  % 原先已有，则更新
            NewExtraInfoList = lists:keyreplace(last_base_attr, 1, Goods#goods.extra, InfoTuple),
            Goods#goods{extra = NewExtraInfoList}
    end.

% 装备幻化出来的效果(附加属性), Value格式：[]
set_transmo_ref_attr(Goods, Value) ->
    InfoTuple = {transmo_ref_attr, Value},
    case lists:keyfind(transmo_ref_attr, 1, Goods#goods.extra) of
        false ->
            Goods#goods{extra = [InfoTuple | Goods#goods.extra]};
        _OldInfoTuple ->
            NewExtraInfoList = lists:keyreplace(transmo_ref_attr, 1, Goods#goods.extra, InfoTuple),
            Goods#goods{extra =  NewExtraInfoList}
    end.

% 最后一次幻化的附加属性
set_transmo_last_ref_attr(Goods, Value) ->
    InfoTuple = {transmo_last_ref_attr, Value},
    case lists:keyfind(transmo_last_ref_attr, 1, Goods#goods.extra) of
        false ->
            Goods#goods{extra = [InfoTuple | Goods#goods.extra]};
        _OldInfoTuple ->
            NewExtraInfoList = lists:keyreplace(transmo_last_ref_attr, 1, Goods#goods.extra, InfoTuple),
            Goods#goods{extra =  NewExtraInfoList}
    end.

% 获取幻化出来的附加属性
get_transmo_ref_attr(Goods) ->
    case lists:keyfind(transmo_ref_attr, 1, Goods#goods.extra) of
        false ->
            null;
        {_, Attr} ->
            Attr
    end.

% 获取最后一次幻化的附加属性
get_transmo_last_ref_attr(Goods) ->
    case lists:keyfind(transmo_last_ref_attr, 1, Goods#goods.extra) of
        false ->
            null;
        {_, Attr} ->
            Attr
    end.

% 限制购买时间
get_last_sell_time(Goods) ->
    case lists:keyfind(last_sell_time, 1, Goods#goods.extra) of
        false -> 0;
        {_, Time} -> Time
    end.

set_last_sell_time(Goods, Value) ->
    InfoTuple = {last_sell_time, Value},
    % ?DEBUG_MSG("Goods#goods.extra ~p setName= ~p",[Goods#goods.extra,Value]),
    case lists:keyfind(last_sell_time, 1, Goods#goods.extra) of
        false ->  % 原先没有，则添加
            Goods#goods{extra = [InfoTuple | Goods#goods.extra]};
        _OldInfoTuple ->  % 原先已有，则更新
            NewExtraInfoList = lists:keyreplace(last_sell_time, 1, Goods#goods.extra, InfoTuple),
            Goods#goods{extra = NewExtraInfoList}
    end.


% 获取特效编号
get_equip_effect(Goods) ->
    ?DEBUG_MSG("-------------------------Goods#goods.extra--------------------~p~n", [Goods#goods.extra]),
    case lists:keyfind(equip_effect, 1, Goods#goods.extra) of
        false -> 0;
        {_, Lv} -> Lv
    end.

% 设置特效编号
set_equip_effect(Goods, Value) ->
    InfoTuple = {equip_effect, Value},

    case lists:keyfind(equip_effect, 1, Goods#goods.extra) of
        false ->  % 原先没有，则添加
            Goods#goods{extra = [InfoTuple | Goods#goods.extra]};
        _OldInfoTuple ->  % 原先已有，则更新
            NewExtraInfoList = lists:keyreplace(equip_effect, 1, Goods#goods.extra, InfoTuple),
            Goods#goods{extra = NewExtraInfoList}
    end.

% 装备幻化出来的效果(特效)
set_transmo_eff_no(Goods, Value) ->
    InfoTuple = {transmo_eff_no, Value},

    case lists:keyfind(transmo_eff_no, 1, Goods#goods.extra) of
        false ->  % 原先没有，则添加
            Goods#goods{extra = [InfoTuple | Goods#goods.extra]};
        _OldInfoTuple ->  % 原先已有，则更新
            NewExtraInfoList = lists:keyreplace(transmo_eff_no, 1, Goods#goods.extra, InfoTuple),
            Goods#goods{extra = NewExtraInfoList}
    end.

% 最后一次幻化的特效
set_transmo_last_eff_no(Goods, Value) ->
    InfoTuple = {transmo_eff_temp_no, Value},
    ?DEBUG_MSG("---------------------------Goods#goods.extra---------------------------~p~n", [Goods#goods.extra]),
    case lists:keyfind(transmo_eff_temp_no, 1, Goods#goods.extra) of
        false ->  % 原先没有，则添加
            Goods#goods{extra = [InfoTuple | Goods#goods.extra]};
        _OldInfoTuple ->  % 原先已有，则更新
            NewExtraInfoList = lists:keyreplace(transmo_eff_temp_no, 1, Goods#goods.extra, InfoTuple),
            Goods#goods{extra = NewExtraInfoList}
    end.

% 获取幻化出来的特效
get_transmo_eff_no(Goods) ->
    case lists:keyfind(transmo_eff_no, 1, Goods#goods.extra) of
        false -> 0;
        {_, No} -> No
    end.

% 获取最后一次幻化的特效
get_transmo_last_eff_no(Goods) ->
    case lists:keyfind(transmo_eff_temp_no, 1, Goods#goods.extra) of
        false -> 0;
        {_, No} -> No
    end.

% 获取特技编号
get_equip_stunt(Goods) ->
    case lists:keyfind(equip_stunt, 1, Goods#goods.extra) of
        false -> 0;
        {_, No} -> No
    end.

% 设置特技编号
set_equip_stunt(Goods, Value) ->
    InfoTuple = {equip_stunt, Value},

    case lists:keyfind(equip_stunt, 1, Goods#goods.extra) of
        false ->  % 原先没有，则添加
            Goods#goods{extra = [InfoTuple | Goods#goods.extra]};
        _OldInfoTuple ->  % 原先已有，则更新
            NewExtraInfoList = lists:keyreplace(equip_stunt, 1, Goods#goods.extra, InfoTuple),
            Goods#goods{extra = NewExtraInfoList}
    end.

% 获取买入价类型
get_purchase_price_type(Goods) ->
    case lists:keyfind(purchase_price_type, 1, Goods#goods.extra) of
        false -> 0;
        {_, Lv} -> Lv
    end.

% 设置买入价类型
set_purchase_price_type(Goods, Value) ->
    InfoTuple = {purchase_price_type, Value},
    case lists:keyfind(purchase_price_type, 1, Goods#goods.extra) of
        false ->  % 原先没有，则添加
            Goods#goods{extra = [InfoTuple | Goods#goods.extra]};
        _OldInfoTuple ->  % 原先已有，则更新
            NewExtraInfoList = lists:keyreplace(purchase_price_type, 1, Goods#goods.extra, InfoTuple),
            Goods#goods{extra = NewExtraInfoList}
    end.

get_mk_skill_list(Goods) ->
    case lists:keyfind(skill_list, 1, Goods#goods.extra) of
        false -> [];
        {_, List} -> List
    end.

set_mk_skill_list(Goods, Value) when is_list(Value) ->
    InfoTuple = {skill_list, Value},
    case lists:keyfind(skill_list, 1, Goods#goods.extra) of
        false ->  % 原先没有，则添加
            Goods#goods{extra = [InfoTuple | Goods#goods.extra]};
        _OldInfoTuple ->  % 原先已有，则更新
            NewExtraInfoList = lists:keyreplace(skill_list, 1, Goods#goods.extra, InfoTuple),
            Goods#goods{extra = NewExtraInfoList}
    end.


%% 洗练特技暂存信息
get_equip_stunt_temp_no(Goods) ->
    case lists:keyfind(equip_stunt_temp_no, 1, Goods#goods.extra) of
        false -> 0;
        {_, Val} -> Val
    end.

set_equip_stunt_temp_no(Goods, Value) ->
    InfoTuple = {equip_stunt_temp_no, Value},
    case lists:keyfind(equip_stunt_temp_no, 1, Goods#goods.extra) of
        false ->  % 原先没有，则添加
            Goods#goods{extra = [InfoTuple | Goods#goods.extra]};
        _OldInfoTuple ->  % 原先已有，则更新
            NewExtraInfoList = lists:keyreplace(equip_stunt_temp_no, 1, Goods#goods.extra, InfoTuple),
            Goods#goods{extra = NewExtraInfoList}
    end.


%% 洗练特效暂存信息
get_equip_eff_temp_no(Goods) ->
    case lists:keyfind(equip_eff_temp_no, 1, Goods#goods.extra) of
        false -> 0;
        {_, Val} -> Val
    end.

set_equip_eff_temp_no(Goods, Value) ->
    InfoTuple = {equip_eff_temp_no, Value},
    case lists:keyfind(equip_eff_temp_no, 1, Goods#goods.extra) of
        false ->  % 原先没有，则添加
            Goods#goods{extra = [InfoTuple | Goods#goods.extra]};
        _OldInfoTuple ->  % 原先已有，则更新
            NewExtraInfoList = lists:keyreplace(equip_eff_temp_no, 1, Goods#goods.extra, InfoTuple),
            Goods#goods{extra = NewExtraInfoList}
    end.

%% 洗练特技暂存信息（累积洗炼次数）
get_equip_stunt_refresh_time(Goods) ->
    case lists:keyfind(equip_stunt_refresh_time, 1, Goods#goods.extra) of
        false -> 0;
        {_, Val} -> Val
    end.

set_equip_stunt_refresh_time(Goods, Value) ->
    InfoTuple = {equip_stunt_refresh_time, Value},
    case lists:keyfind(equip_stunt_refresh_time, 1, Goods#goods.extra) of
        false ->  % 原先没有，则添加
            Goods#goods{extra = [InfoTuple | Goods#goods.extra]};
        _OldInfoTuple ->  % 原先已有，则更新
            NewExtraInfoList = lists:keyreplace(equip_stunt_refresh_time, 1, Goods#goods.extra, InfoTuple),
            Goods#goods{extra = NewExtraInfoList}
    end.

%% 洗练特效暂存信息（累积洗炼次数）
get_equip_eff_refresh_time(Goods) ->
    case lists:keyfind(equip_eff_refresh_time, 1, Goods#goods.extra) of
        false -> 0;
        {_, Val} -> Val
    end.

set_equip_eff_refresh_time(Goods, Value) ->
    InfoTuple = {equip_eff_refresh_time, Value},
    case lists:keyfind(equip_eff_refresh_time, 1, Goods#goods.extra) of
        false ->  % 原先没有，则添加
            Goods#goods{extra = [InfoTuple | Goods#goods.extra]};
        _OldInfoTuple ->  % 原先已有，则更新
            NewExtraInfoList = lists:keyreplace(equip_eff_refresh_time, 1, Goods#goods.extra, InfoTuple),
            Goods#goods{extra = NewExtraInfoList}
    end.

%% 洗练特技暂存信息（累积洗炼次数）
get_equip_high_stunt_refresh_time(Goods) ->
    case lists:keyfind(equip_high_stunt_refresh_time, 1, Goods#goods.extra) of
        false -> 0;
        {_, Val} -> Val
    end.

set_equip_high_stunt_refresh_time(Goods, Value) ->
    InfoTuple = {equip_high_stunt_refresh_time, Value},
    case lists:keyfind(equip_high_stunt_refresh_time, 1, Goods#goods.extra) of
        false ->  % 原先没有，则添加
            Goods#goods{extra = [InfoTuple | Goods#goods.extra]};
        _OldInfoTuple ->  % 原先已有，则更新
            NewExtraInfoList = lists:keyreplace(equip_high_stunt_refresh_time, 1, Goods#goods.extra, InfoTuple),
            Goods#goods{extra = NewExtraInfoList}
    end.

%% 洗练特效暂存信息（累积洗炼次数）
get_equip_high_eff_refresh_time(Goods) ->
    case lists:keyfind(equip_high_eff_refresh_time, 1, Goods#goods.extra) of
        false -> 0;
        {_, Val} -> Val
    end.

set_equip_high_eff_refresh_time(Goods, Value) ->
    InfoTuple = {equip_high_eff_refresh_time, Value},
    case lists:keyfind(equip_high_eff_refresh_time, 1, Goods#goods.extra) of
        false ->  % 原先没有，则添加
            Goods#goods{extra = [InfoTuple | Goods#goods.extra]};
        _OldInfoTuple ->  % 原先已有，则更新
            NewExtraInfoList = lists:keyreplace(equip_high_eff_refresh_time, 1, Goods#goods.extra, InfoTuple),
            Goods#goods{extra = NewExtraInfoList}
    end.


%% 获取物品的额外信息
%% @para: Key => 额外信息的key，为atom类型
%% @return: null | 信息元组，形如：{Key, Value, 其他Value（可选）}
get_extra(Goods, Key) when is_record(Goods, goods) ->
    ExtraInfoList = Goods#goods.extra,
    ?ASSERT(util:is_tuple_list(ExtraInfoList), Goods),
    case lists:keyfind(Key, 1, ExtraInfoList) of
        false ->  % 没有，则尝试去模板数据中查找
            GoodsTpl = get_tpl_data(Goods#goods.no),
            _ExtraInfoList = GoodsTpl#goods_tpl.extra,
            case is_list(_ExtraInfoList) of
                false -> null;
                true ->
                    case lists:keyfind(Key, 1, _ExtraInfoList) of
                        false ->
                            null;
                        _InfoTuple ->
                            _InfoTuple
                    end
            end;
        InfoTuple ->
            InfoTuple
    end;

get_extra(GoodsTpl, Key) ->
    ExtraInfoList = GoodsTpl#goods_tpl.extra,
    ?ASSERT(util:is_tuple_list(ExtraInfoList), GoodsTpl),
    case lists:keyfind(Key, 1, ExtraInfoList) of
        false ->  % 没有，则尝试去模板数据中查找
            null;
        InfoTuple ->
            InfoTuple
    end.


get_contri_need_when_puton(Goods) when is_record(Goods, goods) ->
    GoodsTpl = get_tpl_data(Goods#goods.no),
    get_contri_need_when_puton(GoodsTpl);

get_contri_need_when_puton(GoodsTpl) ->
    case lists:keyfind(contri, 1, GoodsTpl#goods_tpl.extra) of
        false ->  % 没有，则尝试去模板数据中查找
            ?INVALID_NO;
        {_, Value} ->
            Value
    end.    

%% 设置物品的额外信息
%% @para: Key => 额外信息的key，为atom类型
%%        InfoTuple => 信息元组（信息元组的第一个元素其实就是参数Key）
%% @return: 更新后的goods结构体
set_extra(Goods, Key, InfoTuple) ->
    ExtraInfoList = Goods#goods.extra,
    ?ASSERT(util:is_tuple_list(ExtraInfoList), Goods),
    case lists:keyfind(Key, 1, ExtraInfoList) of
        false ->  % 原先没有，则添加
            Goods#goods{extra = [InfoTuple | ExtraInfoList]};
        _OldInfoTuple ->  % 原先已有，则更新
            NewExtraInfoList = lists:keyreplace(Key, 1, ExtraInfoList, InfoTuple),
            Goods#goods{extra = NewExtraInfoList}
    end.

%%        InfoTuple => 信息元组（信息元组的第一个元素其实就是参数Key）
set_extra(Goods, InfoTuple) ->
    {Key, _Value} = InfoTuple,
    ExtraInfoList = Goods#goods.extra,
    case lists:keyfind(Key, 1, ExtraInfoList) of
        false ->  % 原先没有，则添加
            Goods#goods{extra = [InfoTuple | ExtraInfoList]};
        _OldInfoTuple ->  % 原先已有，则更新
            NewExtraInfoList = lists:keyreplace(Key, 1, ExtraInfoList, InfoTuple),
            Goods#goods{extra = NewExtraInfoList}
    end.


%% 获取物品卖出时的时间戳
get_sell_time(Goods) ->
    Goods#goods.sell_time.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 是否可以叠加
% return true | false
is_can_stack(GoodsTpl) when is_record(GoodsTpl, goods_tpl) ->
    GoodsTpl#goods_tpl.max_stack > 1;
is_can_stack(Goods) when is_record(Goods, goods) ->
    (get_tpl_data(Goods#goods.no))#goods_tpl.max_stack > 1.

%% 是否可以丢弃
%% @return: true | false
is_can_discard(GoodsTpl) when is_record(GoodsTpl, goods_tpl) ->
    GoodsTpl#goods_tpl.can_discard == 1;
is_can_discard(Goods) when is_record(Goods, goods) ->
    (get_tpl_data(Goods#goods.no))#goods_tpl.can_discard == 1.

%% 是否可以出售
is_can_sell(GoodsTpl) when is_record(GoodsTpl, goods_tpl) ->
    GoodsTpl#goods_tpl.can_sell == 1;
is_can_sell(Goods) when is_record(Goods, goods) ->
    (get_tpl_data(Goods#goods.no))#goods_tpl.can_sell == 1.


%% 是否可以放入仓库
is_can_store(GoodsTpl) when is_record(GoodsTpl, goods_tpl) ->
    GoodsTpl#goods_tpl.can_store == 1;
is_can_store(Goods) when is_record(Goods, goods) ->
    (get_tpl_data(Goods#goods.no))#goods_tpl.can_store == 1.

can_present(GoodsTpl) when is_record(GoodsTpl, goods_tpl) ->
    GoodsTpl#goods_tpl.can_present == 1;
can_present(Goods) when is_record(Goods, goods) ->
    (get_tpl_data(Goods#goods.no))#goods_tpl.can_present == 1.


% 是否是礼物
is_gift(GoodsTpl) when is_record(GoodsTpl, goods_tpl) ->
    GoodsTpl#goods_tpl.can_present == 2;
is_gift(Goods) when is_record(Goods, goods) ->
    (get_tpl_data(Goods#goods.no))#goods_tpl.can_present == 2.

%% 是否可交易
is_can_trade(GoodsTpl) when is_record(GoodsTpl, goods_tpl) ->
    GoodsTpl#goods_tpl.can_trade == 1;
is_can_trade(Goods) when is_record(Goods, goods) ->
    (get_tpl_data(Goods#goods.no))#goods_tpl.can_trade == 1.

%% 是否可使用
is_can_use(GoodsTpl) when is_record(GoodsTpl, goods_tpl) ->
    GoodsTpl#goods_tpl.can_use == 1;
is_can_use(Goods) when is_record(Goods, goods) ->
    (get_tpl_data(Goods#goods.no))#goods_tpl.can_use == 1.

%% 判断物品是否可以用于指定的目标对象类型
is_can_use_on_obj_type(Goods_Or_GoodsTpl, ObjType)
  when is_record(Goods_Or_GoodsTpl, goods_tpl);
       is_record(Goods_Or_GoodsTpl, goods)  ->
    ?ASSERT(ObjType >= ?OBJ_MIN andalso ObjType =< ?OBJ_MAX),
    lists:member(ObjType, get_target_obj_type_list(Goods_Or_GoodsTpl)).


%% （战斗中）是否可以用于友方？
is_can_use_on_ally(Goods_Or_GoodsTpl)
  when is_record(Goods_Or_GoodsTpl, goods_tpl);
       is_record(Goods_Or_GoodsTpl, goods) ->
    Camp = get_camp(Goods_Or_GoodsTpl),
    Camp == ?CAMP_NONE orelse Camp == ?CAMP_ALLY.


%% （战斗中）是否可以用于敌方？
is_can_use_on_enemy(Goods_Or_GoodsTpl)
  when is_record(Goods_Or_GoodsTpl, goods_tpl);
       is_record(Goods_Or_GoodsTpl, goods) ->
    Camp = get_camp(Goods_Or_GoodsTpl),
    Camp == ?CAMP_NONE orelse Camp == ?CAMP_ENEMY.



%% 是否可批量使用
is_can_batch_use(GoodsTpl) when is_record(GoodsTpl, goods_tpl) ->
    GoodsTpl#goods_tpl.can_batch_use == 1;
is_can_batch_use(Goods) when is_record(Goods, goods) ->
    (get_tpl_data(Goods#goods.no))#goods_tpl.can_batch_use == 1.

%% 是否可以在战斗中使用
is_can_use_in_battle(GoodsTpl) when is_record(GoodsTpl, goods_tpl) ->
    GoodsTpl#goods_tpl.can_use_in_battle == 1;
is_can_use_in_battle(Goods) when is_record(Goods, goods) ->
    (get_tpl_data(Goods#goods.no))#goods_tpl.can_use_in_battle == 1.



%% 是否装备
is_equip(GoodsTpl) when is_record(GoodsTpl, goods_tpl) ->
    GoodsTpl#goods_tpl.type == ?GOODS_T_EQUIP orelse GoodsTpl#goods_tpl.type == ?GOODS_T_PAR_EQUIP;
is_equip(Goods) when is_record(Goods, goods) ->
    (get_tpl_data(Goods#goods.no))#goods_tpl.type == ?GOODS_T_EQUIP orelse (get_tpl_data(Goods#goods.no))#goods_tpl.type == ?GOODS_T_PAR_EQUIP.

is_magic_key(GoodsTpl) when is_record(GoodsTpl, goods_tpl) ->
    GoodsTpl#goods_tpl.type == ?GOODS_T_EQUIP andalso GoodsTpl#goods_tpl.subtype =:= ?EQP_T_MAGIC_KEY;
is_magic_key(Goods) ->
    GoodsTpl = get_tpl_data(Goods#goods.no),
    is_magic_key(GoodsTpl).


%% 是否人物时装
is_fashion(GoodsTpl) when is_record(GoodsTpl, goods_tpl) ->
    GoodsTpl#goods_tpl.type == ?GOODS_T_EQUIP andalso lists:member(GoodsTpl#goods_tpl.subtype, [?EQP_T_HEADWEAR, ?EQP_T_CLOTHES, ?EQP_T_BACKWEAR]);
is_fashion(Goods) when is_record(Goods, goods) ->
    GoodsTpl = get_tpl_data(Goods#goods.no),
    is_fashion(GoodsTpl).

%% 是否坐骑
is_mount(GoodsTpl) when is_record(GoodsTpl, goods_tpl) ->
    GoodsTpl#goods_tpl.type == ?GOODS_T_MOUNT;
is_mount(Goods) when is_record(Goods, goods) ->
    (get_tpl_data(Goods#goods.no))#goods_tpl.type == ?GOODS_T_MOUNT.

%% 判断某物品是否武器
is_weapon(GoodsTpl) when is_record(GoodsTpl, goods_tpl) ->
    (GoodsTpl#goods_tpl.type == ?GOODS_T_EQUIP)
    andalso (GoodsTpl#goods_tpl.subtype >= ?EQP_T_WEAPON_BEGIN)
    andalso (GoodsTpl#goods_tpl.subtype =< ?EQP_T_WEAPON_END);
is_weapon(Goods) when is_record(Goods, goods) ->
    GoodsTpl = get_tpl_data(Goods#goods.no),
    is_weapon(GoodsTpl).


%% 防具类型列表
-define(ARMOR_T_LIST, [?EQP_T_CLOTHES, ?EQP_T_BRACER, ?EQP_T_SHOES, ?EQP_T_WAISTBAND]).

%% 判断某物品是否防具
is_armor(GoodsTpl) when is_record(GoodsTpl, goods_tpl) ->
    (GoodsTpl#goods_tpl.type == ?GOODS_T_EQUIP)
    andalso lists:member(GoodsTpl#goods_tpl.subtype, ?ARMOR_T_LIST);
is_armor(Goods) when is_record(Goods, goods) ->
    GoodsTpl = get_tpl_data(Goods#goods.no),
    is_armor(GoodsTpl).


%% 物品是否可以装备
is_can_equiped(Goods_Or_GoodsTpl) ->
    ?ASSERT(is_record(Goods_Or_GoodsTpl, goods) orelse is_record(Goods_Or_GoodsTpl, goods_tpl)),
    is_equip(Goods_Or_GoodsTpl).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 是否脏物品（脏物品表示物品数据在内存中有改动并且未存到数据库）
is_dirty(Goods) -> Goods#goods.is_dirty.

%% 设置脏标记
%% @return: 更新后的goods结构体
set_dirty(Goods, Flag) ->
    case Flag of
        true ->
            % 同时设置标记物品为脏时的服务器时钟滴答计数
            Goods#goods{is_dirty = true, time_on_mark_dirty = svr_clock:get_tick_count()};
        false ->
            Goods#goods{is_dirty = false}
    end.

%% 是否随机物品
%% 随机物品表示物品的某些属性和对应的模板是不同的（如：装备强化时随机增加的一些属性加成），需要记录到数据库
%is_random(Goods) -> Goods#goods.is_random.

%% 是否随机装备
%is_random_equip(Goods) -> is_equip(Goods) andalso Goods#goods.is_random.

%% 是否时效物品， 时效物品是指：非永久性物品，有时间限制，到期则物品效果消失
is_timing_goods(Goods) ->
    GoodsTpl = get_tpl_data(Goods#goods.no),
    GoodsTpl#goods_tpl.valid_time /= 0 orelse GoodsTpl#goods_tpl.timekeeping_type /= 0.

is_expired_on_zero(Goods) ->
    GoodsTpl = get_tpl_data(Goods#goods.no),
    GoodsTpl#goods_tpl.expire_on_zero =/= 0.    

%% 是否处于计时状态中（满足条件：属于时效物品并且当前已经在计时中）
%% 注意：对于已过期的时效物品，返回true（即认为也是处于计时状态中）
%% @return: true | false
is_in_timekeeping(Goods) ->
    case is_timing_goods(Goods) of
        false ->
            false;
        true ->
            TimekpType = get_timekeeping_type(Goods),
            WhenBeginTimekp = get_when_begin_timekeeping(Goods),
            if
                TimekpType == ?TKP_BY_REAL orelse TimekpType == ?TKP_BY_ACC_ONLINE ->
                    case WhenBeginTimekp of
                        ?WBTKP_ON_GOT ->
                            true;
                        ?WBTKP_ON_FIRST_USE ->
                            get_first_use_time(Goods) /= 0
                    end;

                % 拓展：其他计时类型的判断处理，目前暂时没有
                % ...

                true ->
                    ?ASSERT(false),
                    false
            end
    end.


%% 判断物品是否已经过期
%% @return: true | false
is_expired(Goods) ->
    case is_timing_goods(Goods) of
        true ->
            get_left_valid_time(Goods) == 0;
        false ->
            false  % 非时效物品不会过期
    end.

% 判断是否宝石
is_gem_goods(GoodsTpl) when is_record(GoodsTpl, goods_tpl) ->
    GoodsType = lib_goods:get_type(GoodsTpl),
    GoodsSubType = lib_goods:get_subtype(GoodsTpl),
    case GoodsType =:= ?GOODS_T_EQ_CONSUME andalso GoodsSubType =:= ?EQP_T_GEM of
        true -> true;
        false -> false
    end;

is_gem_goods(Goods) when is_record(Goods, goods) ->
    GoodsTpl = get_tpl_data(get_no(Goods)),
    is_gem_goods(GoodsTpl).

is_task_goods(GoodsTpl) when is_record(GoodsTpl, goods_tpl) ->
    GoodsType = lib_goods:get_type(GoodsTpl),
    GoodsSubType = lib_goods:get_subtype(GoodsTpl),
    case GoodsType =:= ?GOODS_T_TOLLGATE andalso GoodsSubType =:= ?TOLLGATE_T_TASK of
        true -> true;
        false -> false
    end;
is_task_goods(Goods) when is_record(Goods, goods) ->
    GoodsTpl = get_tpl_data(get_no(Goods)),
    is_task_goods(GoodsTpl).


is_trigger_accept_task_goods(Goods) when is_record(Goods, goods) ->
    EffectList = get_effects(Goods),
    lib_goods_eff:has_effect_name_in_effect_list(EffectList, ?EN_ACCEPT_TASK).


% 是否是宠物道具
is_partner_goods(GoodsTpl) when is_record(GoodsTpl, goods_tpl) ->
    GoodsType = lib_goods:get_type(GoodsTpl),
    % GoodsSubType = lib_goods:get_subtype(GoodsTpl),
    case GoodsType =:= ?GOODS_T_PARTNER_PROP of
        true -> true;
        false -> false
    end;
is_partner_goods(Goods) when is_record(Goods, goods) ->
    GoodsTpl = get_tpl_data(get_no(Goods)),
    is_partner_goods(GoodsTpl).

is_partner_equip(Goods) when is_record(Goods, goods) ->
    lib_goods:get_type(Goods) =:= ?GOODS_T_PAR_EQUIP.


%% 构造新物品
%% @para:   Goods => 物品
%% @return: goods结构体
redo_goods(PlayerId, Goods ) when is_integer(PlayerId) ->
    %?ASSERT(Location == ?LOC_BAG orelse Location == ?LOC_STORAGE),  % TODO: 暂时只考虑背包和仓库！以后再按需动态调整此断言。
    Location =
    case is_equip(Goods) of
        true -> ?LOC_BAG_EQ;
        false ->
            case is_can_use(Goods) of
                true -> ?LOC_BAG_USABLE;
                false -> ?LOC_BAG_UNUSABLE
            end
    end,

    GoodsNo = get_no(Goods),
    GoodsTpl = get_tpl_data(GoodsNo),
    
    Goods_ = Goods#goods{
                no = GoodsNo,
                player_id = PlayerId,
                location = Location,
                is_dirty = false,            % 初始时是非脏的
                usable_times = get_usable_times(GoodsTpl)
                },
    % 删除原道具
    mod_inv:destroy_goods_WNC(PlayerId,get_id(Goods),[?LOG_GOODS,"redo_goods"]),

    Goods1 = case lib_goods:is_timing_goods(Goods_)
                andalso lib_goods:get_when_begin_timekeeping(Goods_) == ?WBTKP_ON_GOT of
                    false ->
                        Goods_;
                    true ->
                        lib_goods:timekeeping_start(Goods_)  % 开始计时
                end,
    ?ASSERT(is_record(Goods1, goods)),

    case lib_goods:is_equip(Goods1) of
        true -> 
            BattlePower = lib_equip:calc_battle_power(Goods1),
            Goods1#goods{battle_power = BattlePower};
        false -> 
            Goods1
    end.


%% 构造新物品
%% @para:   GoodsNo => 物品编号
%%          StackCount => 叠加数量
%%          Location => 所在地（如:背包）
%%          ExtraInitInfo => 物品的额外初始化信息， 格式如： [{bind_state, ?BIND_ON_USE}, ...]
%% @return: goods结构体
make_new_goods(PlayerId, GoodsNo, StackCount, ExtraInit) when is_integer(PlayerId) ->
    %?ASSERT(Location == ?LOC_BAG orelse Location == ?LOC_STORAGE),  % TODO: 暂时只考虑背包和仓库！以后再按需动态调整此断言。
    GoodsTpl = get_tpl_data(GoodsNo),
    ExtraInitInfo = case GoodsTpl#goods_tpl.fix_id =:= 0 of
                        true -> ExtraInit;
                        false ->
                            case lists:keyfind(GoodsTpl#goods_tpl.fix_id, 1, data_special_config:get('equip_fixed_attr')) of
                                {_FixId, Ext} ->
                                    ExtraInit ++ Ext;
                                false ->
                                    ExtraInit
                            end
                    end,
    Location =
    case is_equip(GoodsTpl) of
        true -> ?LOC_BAG_EQ;
        false ->
            case is_can_use(GoodsTpl) of
                true -> ?LOC_BAG_USABLE;
                false -> ?LOC_BAG_UNUSABLE
            end
    end,

    ?ASSERT(StackCount =< get_max_stack(GoodsTpl)),
    case is_equip(GoodsTpl) of
        false ->
            % ?ASSERT(GoodsTpl#goods_tpl.quality /= ?QUALITY_INVALID, get_no(GoodsTpl)),
            Quality = GoodsTpl#goods_tpl.quality,
            BaseEquipAdd2 = null,
            AddiEquipAdd2 = null,
            AddiEquipAdd = [],
            AddiEquipEffNo = 0,
            AddiEquipEffAdd = null,
            StrenEquipAdd = null,
            EquipProp = null,
            AddiEquipStuntNo = 0,
            CustomType = 0,
            BaseEquipAdd0 = [];

        true ->
            EquipLv = get_lv(GoodsTpl),
            Quality =
                case lists:keyfind(quality, 1, ExtraInitInfo) of  % 判断是否指定品质
                    {quality, Quality__} -> % 指定品质
                        case is_valid_quality(Quality__) of
                            true -> Quality__;
                            false -> 
                                case GoodsTpl#goods_tpl.quality =:= ?QUALITY_INVALID of
                                    true -> lib_equip:decide_quality(EquipLv);
                                    false ->
                                        ?ASSERT(is_valid_quality(GoodsTpl#goods_tpl.quality), {GoodsTpl#goods_tpl.quality, GoodsNo}),
                                        GoodsTpl#goods_tpl.quality
                                end
                        end;
                    false ->  % 不指定品质
                        case GoodsTpl#goods_tpl.quality =:= ?QUALITY_INVALID of
                            true -> lib_equip:decide_quality(EquipLv);
                            false ->
                                ?ASSERT(is_valid_quality(GoodsTpl#goods_tpl.quality), {GoodsTpl#goods_tpl.quality, GoodsNo}),
                                GoodsTpl#goods_tpl.quality
                        end
                end,

            StrenLv = 
                case lists:keyfind(strenlv, 1, ExtraInitInfo) of  % 判断是否强化等级
                    {strenlv, StrenLv__} -> % 指定强化等级
                        StrenLv__;
                    false ->  % 不指定强化等级
                        0
                end,

			BaseEquipAdd0 =
                case lists:keyfind(base_equip_add, 1, ExtraInitInfo) of
                    {base_equip_add, BaseEquipAdd__} ->
                        BaseEquipAdd__;
                    false ->
                        lib_equip:decide_base_equip_add(GoodsTpl, Quality)
                end,
            %% 合并相同基础的属性[{attrname,attrvalue}]
            BaseEquipAdd =util:duplicate_key_sum_value(BaseEquipAdd0),

            %% 策划待定
			
			AddiEquipAdd = 
                case get_type(GoodsTpl) =:= ?GOODS_T_PAR_EQUIP of
                    true -> [];
					false ->
						case lists:keyfind(addi_equip_add, 1, ExtraInitInfo) of
							{addi_equip_add, AddiEquipAdd__} ->
								[{0, AttrName, AttrValue, 0} || {AttrName, AttrValue} <- AddiEquipAdd__];
							false -> 
								lib_equip:make_addi_random_attr(GoodsNo, Quality)
						end
                end,

            %% 特效
            % ?DEBUG_MSG("GoodsNo = ~p",[GoodsNo]),
%%             AddiEquipEffNo = lib_equip:make_random_eff(GoodsNo), 
            AddiEquipEffNo = 
                case lists:keyfind(addi_equip_eff_no, 1, ExtraInitInfo) of
                    {addi_equip_eff_no, AddiEquipEffNo__} ->
                        AddiEquipEffNo__;
                    false ->
                        lib_equip:make_new_random_eff(GoodsNo)
                end,
			AddiEquipEffAdd = case AddiEquipEffNo of 
                0 -> #attrs{};
                _ -> lib_attribute:to_addi_equip_eff(AddiEquipEffNo)
            end,

            %% 特技
%%             AddiEquipStuntNo = lib_equip:make_random_stunt(GoodsNo), 
			AddiEquipStuntNo = 
				case lists:keyfind(addi_equip_stunt_no, 1, ExtraInitInfo) of
					{addi_equip_stunt_no, AddiEquipStuntNo__} ->
						AddiEquipStuntNo__;
					false ->
						lib_equip:make_new_random_stunt(GoodsNo)
				end,
			?DEBUG_MSG("AddiEquipStuntNo=~p",[AddiEquipStuntNo]),

            %% 定制
            CustomType =
                case lists:keyfind(custom_type, 1, ExtraInitInfo) of
                    {custom_type, CustomType__} -> CustomType__;
                    false -> 0
                end,
			
            BaseEquipAdd2 = lib_attribute:to_attrs_record(BaseEquipAdd),   % 转为attrs结构体
            AddiEquipAdd2 = lib_attribute:to_addi_equip_add_attrs_record(AddiEquipAdd),   % 转为attrs结构体

            % get_make_equip_added_effect_info 返回 equip_speci_effect_tpl

            StrenEquipAdd = #attrs{},
            GemInlayInit = lib_equip:init_gem_inlay(),                     % 初始化宝石镶嵌数据
            EquipProp = #equip_prop{stren_lv = StrenLv, gem_inlay = GemInlayInit}
    end,

    ?ASSERT(is_record(BaseEquipAdd2, attrs) orelse BaseEquipAdd2 == null, BaseEquipAdd2),
    ?ASSERT(is_record(AddiEquipAdd2, attrs) orelse AddiEquipAdd2 == null, AddiEquipAdd2),
    BindState =
      case is_equip(GoodsTpl) of
        false ->
          case get_bind_state(GoodsTpl) of
              ?BIND_ALREADY -> ?BIND_ALREADY;
              ?BIND_NEVER -> ?BIND_NEVER;
              ?BIND_ON_GET -> ?BIND_ALREADY;
              ?BIND_ON_USE -> ?BIND_ON_USE;
              _ -> ?BIND_NEVER
          end;
        true ->
          ?BIND_ON_USE
      end,
    Goods = #goods{
                no = GoodsNo,
                player_id = PlayerId,
                count = StackCount,
                location = Location,
                bind_state = BindState,
                is_dirty = false,            % 初始时是非脏的
                quality = Quality,
                usable_times = get_usable_times(GoodsTpl),
                base_equip_add = BaseEquipAdd2,
                addi_equip_add = AddiEquipAdd2,
                addi_ep_add_kv = AddiEquipAdd,
                stren_equip_add = StrenEquipAdd,
                addi_equip_eff = AddiEquipEffNo,
                addi_equip_eff_add = AddiEquipEffAdd,
                equip_prop = EquipProp,
                custom_type = CustomType,
                show_base_attr = BaseEquipAdd0
                },


    Goods1 = case lib_goods:is_timing_goods(Goods)
                andalso lib_goods:get_when_begin_timekeeping(Goods) == ?WBTKP_ON_GOT of
                    false ->
                        Goods;
                    true ->
                        lib_goods:timekeeping_start(Goods)  % 开始计时
                end,
    ?ASSERT(is_record(Goods1, goods)),

    Goods2 =
        case is_equip(GoodsTpl) andalso GoodsTpl#goods_tpl.stren_lv > 0 of
            true -> lib_equip:change_equip_stren_attr(Goods1, GoodsTpl#goods_tpl.stren_lv);
            false -> Goods1
        end,
    Goods3 = make_new_goods_2(Goods2, ExtraInitInfo),
    Goods4 = mk_extra_info(Goods3, GoodsTpl),

    % 添加装备技能
    Goods5 = set_equip_stunt(Goods4,AddiEquipStuntNo),
	Goods6 = 
		case lists:keymember(addi_equip_eff_no, 1, ExtraInitInfo) of
			?true ->
				set_equip_effect(Goods5, AddiEquipEffNo);
			?false ->
				Goods5
		end,

    Goods7 = case lib_goods:is_equip(Goods6) of
        true -> 
            BattlePower = lib_equip:calc_battle_power(Goods6),
            Goods6#goods{battle_power = BattlePower};
        false -> 
            Goods6
    end,
    case lists:keyfind(maker_name, 1, ExtraInitInfo) of
        {maker_name, MakeName} ->
            set_maker_name(Goods7, MakeName);
        false ->
            Goods7
    end.



mk_extra_info(Goods, GoodsTpl) ->
    F = fun({Key, Value}, Acc) ->
        case Key of
            dig_treasure ->
                ScenNo = lists:nth(util:rand(1, length(Value)), Value),
                case mod_scene_tpl:get_tpl_data(ScenNo) of
                    null -> Acc;
                    SceneTpl ->
                        {X, Y} = rand_get_xy_by_area(SceneTpl#scene_tpl.dig_treasure_area),
                        [{dig_treasure, {ScenNo, X, Y}} | Acc]
                end;
            _ -> Acc
        end
    end,

    InfoL = 
        case is_magic_key(GoodsTpl) of
            false ->
                lists:foldl(F, [], GoodsTpl#goods_tpl.extra);
            true ->
                lists:foldl(F, [], GoodsTpl#goods_tpl.extra) ++ [{skill_list, mk_magic_key_skill_list(Goods)}]
        end,
    Goods#goods{extra = InfoL}.

%% return {L1, L2} 分别表示被动技能和主动技能列表
mk_magic_key_skill_list(GoodsNo, Quality, InitL1, InitL2, IsXilian) when is_integer(GoodsNo) ->
    DataCfg = data_mk_relate:get(GoodsNo),
    case DataCfg =:= null of
        true -> {[], []};
        false ->
            TalentSkillCnt = 
                case length(DataCfg#mk_relate_cfg.talent_skill_cnt) < Quality of
                    true -> 0;
                    false -> lists:nth(Quality, DataCfg#mk_relate_cfg.talent_skill_cnt)
                end,
            CommonSkillCnt = 
                case length(DataCfg#mk_relate_cfg.common_skill_cnt) < Quality of
                    true -> 0;
                    false -> lists:nth(Quality, DataCfg#mk_relate_cfg.common_skill_cnt)
                end,
            
            ?ASSERT(length(DataCfg#mk_relate_cfg.common_skill_list) >= CommonSkillCnt, {DataCfg#mk_relate_cfg.common_skill_list, CommonSkillCnt}),

            F2 = fun(N, Acc) ->
                {List} = 
                    case IsXilian of
                        false -> lists:nth(N, DataCfg#mk_relate_cfg.common_skill_list);
                        true -> lists:nth(N, DataCfg#mk_relate_cfg.refresh_skill_list)
                    end,
                case length(Acc) >= CommonSkillCnt of
                    true -> Acc;
                    false -> rand_get_magic_key_skill(List, 1, Acc)
                end
            end,

            L1 = rand_get_magic_key_skill(DataCfg#mk_relate_cfg.talent_skill_list, TalentSkillCnt-length(InitL1), InitL1),

            L2 = lists:foldl(F2, InitL2, lists:seq(1, CommonSkillCnt)),
            ?DEBUG_MSG("mk_magic_key_skill_list(), CommonSkillCnt=~p, InitL2=~p, L2=~p~n", [CommonSkillCnt, InitL2, L2]),
            {L1, lists:usort(L2)}
    end.


get_init_para_list(PoolL, InitL) ->
    F = fun(Id, Acc) ->
        case lists:keyfind(Id, 1, PoolL) of
            false -> Acc;
            {_, _} -> [Id | Acc]
        end
    end,
    lists:foldl(F, [], InitL).


%% return L
mk_magic_key_skill_list(Goods) ->
    {L1, L2} = mk_magic_key_skill_list(get_no(Goods), get_quality(Goods), [], [], false),
    L1 ++ L2.


rand_get_magic_key_skill([], _Cnt, RetList) ->
    RetList;
rand_get_magic_key_skill(_, Cnt, RetList) when Cnt =< 0 ->
    RetList;
rand_get_magic_key_skill(PoolL, Cnt, RetList) ->
    List1 = lists:usort([Id || {Id, _} <- PoolL]),
    case List1 =:= lists:usort(RetList) of
        true -> RetList;
        false ->
            rand_get_magic_key_skill(PoolL, Cnt, RetList, 1000)
    end.


rand_get_magic_key_skill(_PoolL, _Cnt, RetList, 0) ->
    RetList;
rand_get_magic_key_skill(_PoolL, 0, RetList, _TryCnt) ->
    RetList;
rand_get_magic_key_skill(PoolL, Cnt, RetList, TryCnt) ->
    {Id, _} = util:rand_by_weight(PoolL, 2),
    case lists:member(Id, RetList) of
        true ->
            rand_get_magic_key_skill(PoolL, Cnt, RetList, TryCnt - 1);
        false ->
            case has_same_type_skill(Id, RetList) of
                true -> rand_get_magic_key_skill(PoolL, Cnt, RetList, TryCnt - 1);
                false -> rand_get_magic_key_skill(PoolL, Cnt-1, [Id | RetList], TryCnt - 1)
            end
    end.


has_same_type_skill(Id, RetList) ->
    L = get_same_type_skill_list_by_id(Id),
    has_same_type_skill__(L, RetList).


has_same_type_skill__([], _RetList) ->
    false;
has_same_type_skill__([H | T], RetList) ->
    case lists:member(H, RetList) of
        true -> true;
        false -> has_same_type_skill__(T, RetList)
    end.

get_same_type_skill_list_by_id(Id) ->
    get_same_type_skill_list_by_id_high(Id, []) ++ get_same_type_skill_list_by_id_low(Id, []).


get_same_type_skill_list_by_id_high(Id, RetList) ->
    case data_mk_skill_up:get(Id) of
        null -> RetList;
        Data -> get_same_type_skill_list_by_id_high(Data#mk_skill_up_cfg.next_id, [Data#mk_skill_up_cfg.next_id | RetList])
    end.

%% 目前技能分为初，中，高三个级别的技能，配置时要求id连续
get_same_type_skill_list_by_id_low(Id, RetList) ->
    LowId = Id - 1,
    case data_mk_skill_up:get(LowId) of
        null -> RetList;
        Data -> 
            case Data#mk_skill_up_cfg.next_id =:= Id of
                true ->
                    get_same_type_skill_list_by_id_low(LowId, [LowId | RetList]);
                false ->
                    RetList
            end
    end.

%获取物品详细信息
get_goods_data(PS,GoodsId) ->
	case mod_inv:get_goods_from_ets(GoodsId) of
		null ->
			case ply_trade:get_goods_from_buy_back_list(PS, GoodsId) of
				null -> 
					case mod_market:get_goods_info_from_market(GoodsId) of
						null ->
							% 从数据库加载道具 io:format("playerdata ~p~n",[player:get_PS(1000100000000676)]).
							?DEBUG_MSG("get_goods_info_from_db[~p]",[GoodsId]),
							case mod_inv:get_goods_info_from_db(GoodsId) of
								[] ->
                  case ets:lookup(?ETS_ACHIEVEMENT_TMP_CACHE, {tmp_pro, PS#player_status.id}) of
                    [] ->
                      lib_send:send_prompt_msg(PS, ?PM_GOODS_NOT_EXISTS);
                    [{_,LastTime}] ->
                      ?DEBUG_MSG("wujianchengpro ~p~n",[LastTime]),
                      case util:unixtime() - LastTime > 5 of
                        true ->
                          lib_send:send_prompt_msg(PS, ?PM_GOODS_NOT_EXISTS);
                        false ->
                          skip
                      end
                  end;
								List when is_list(List) ->

									case lists:last(List) of
										null ->
											lib_send:send_prompt_msg(PS, ?PM_GOODS_NOT_EXISTS);
										Goods -> 
											{ok, BinData} = pt_15:write(15001, Goods),
											lib_send:send_to_sock(PS, BinData)
										
									end
							end;
						Goods ->
							{ok, BinData} = pt_15:write(15001, Goods),
							lib_send:send_to_sock(PS, BinData)
					end;
				Goods ->
					{ok, BinData} = pt_15:write(15001, Goods),
					lib_send:send_to_sock(PS, BinData)
			end;
		Goods ->
			Goods1 = 
				case lib_goods:get_owner_id(Goods) =:= player:get_id(PS) of
					true -> Goods;
					false -> lib_goods:set_location(Goods, ?LOC_INVALID) %% 获取其他玩家的物品，标记位置无效，发送给客户端，方便客户端显示
				end,
			{ok, BinData} = pt_15:write(15001, Goods1),
			lib_send:send_to_sock(PS, BinData)
	end.

%%获取跨服聊天的物品详细信息
get_cross_goods_data(GoodsId,ServerId,PlayerId) ->
	case mod_inv:get_goods_from_ets(GoodsId) of
		null ->
			case mod_market:get_goods_info_from_market(GoodsId) of
				null ->
					% 从数据库加载道具
					?DEBUG_MSG("get_goods_info_from_db[~p]",[GoodsId]),
					case mod_inv:get_goods_info_from_db(GoodsId) of
						[] ->sm_cross_server:rpc_cast(ServerId,lib_send, send_prompt_msg, [PlayerId,?PM_GOODS_NOT_EXISTS]);					
						List when is_list(List) ->
							
							case lists:last(List) of
								null ->
									sm_cross_server:rpc_cast(ServerId,lib_send, send_prompt_msg, [PlayerId,?PM_GOODS_NOT_EXISTS]);
								Goods -> 
									{ok, BinData} = pt_15:write(15001, Goods),
									sm_cross_server:rpc_cast(ServerId,lib_chat, cross_chat_data, [PlayerId, BinData,GoodsId,3])	
							
							end
					end;
				Goods ->
					{ok, BinData} = pt_15:write(15001, Goods),
					sm_cross_server:rpc_cast(ServerId,lib_chat, cross_chat_data, [PlayerId, BinData,GoodsId,3])	
			end;
		Goods ->
			Goods1 = lib_goods:set_location(Goods, ?LOC_INVALID), %% 获取其他玩家的物品，标记位置无效，发送给客户端，方便客户端显示
			
			{ok, BinData} = pt_15:write(15001, Goods1),
			sm_cross_server:rpc_cast(ServerId,lib_chat, cross_chat_data, [PlayerId, BinData,GoodsId,3])	
	end.

%% 插入新物品到数据库的goods表
%% @return；新物品的唯一id
db_insert_new_goods(Goods) ->
    % ?ASSERT(get_slot(Goods) /= 0), 虚拟物品格子是0
    % BS:表示bitstring
    BaseEquipAdd_BS = build_base_equip_add_bitstring(Goods),
    AddiEquipAdd_BS = build_addi_equip_add_bitstring(Goods),
    StrenEquipAdd_BS = build_stren_equip_add_bitstring(Goods),
    EquipProp_BS = build_equip_prop_bitstring(Goods),
    Extra_BS = build_goods_extra_bitstring(Goods),
    ShowBaseAdd_BS =  util:term_to_bitstring(Goods#goods.show_base_attr),

    TId = db:insert_get_id(goods, ["no", "player_id", "partner_id", "bind_state", "usable_times", "location", "slot", "count", "quality", "valid_time", "expire_time", "base_equip_add", "addi_equip_add", "stren_equip_add", "equip_prop", "custom_type", "extra", "show_base_attr"],
                     [Goods#goods.no, Goods#goods.player_id, Goods#goods.partner_id, Goods#goods.bind_state, Goods#goods.usable_times,
                      Goods#goods.location, Goods#goods.slot, Goods#goods.count, Goods#goods.quality, Goods#goods.valid_time, Goods#goods.expire_time,
                      BaseEquipAdd_BS, AddiEquipAdd_BS, StrenEquipAdd_BS, EquipProp_BS, Goods#goods.custom_type, Extra_BS, ShowBaseAdd_BS]
                    ),
    Id = 
        case lib_account:is_global_uni_id(TId) of 
            true -> TId; 
            false -> 
                GlobalId = lib_account:to_global_uni_id(TId),
                db:update(Goods#goods.player_id, goods, ["id"], [GlobalId], "id", TId), 
                GlobalId
        end,
    Id.



%% 保存物品到数据库
db_save_goods(Goods) ->
    % 将物品的equip_add，equip_prop这些字段转为key-value元组的列表的方式（如果它们不是null的话），然后再存到数据库。

    % BS:表示bitstring
    BaseEquipAdd_BS = build_base_equip_add_bitstring(Goods),
    AddiEquipAdd_BS = build_addi_equip_add_bitstring(Goods),
    StrenEquipAdd_BS = build_stren_equip_add_bitstring(Goods),
    EquipProp_BS = build_equip_prop_bitstring(Goods),
    Extra_BS = build_goods_extra_bitstring(Goods),
    ShowBaseAdd_BS =  util:term_to_bitstring(Goods#goods.show_base_attr),

    db:update(Goods#goods.player_id, goods, 
        ["no", "player_id", "bind_state", "usable_times", "location", "slot", "count", "quality", "first_use_time", "valid_time", "expire_time", "base_equip_add", 
        "addi_equip_add", "stren_equip_add", "equip_prop", "extra", "battle_power", "partner_id", "custom_type", "show_base_attr"],
        [Goods#goods.no, Goods#goods.player_id, Goods#goods.bind_state, Goods#goods.usable_times, Goods#goods.location, Goods#goods.slot, Goods#goods.count, 
        Goods#goods.quality, Goods#goods.first_use_time, Goods#goods.valid_time, Goods#goods.expire_time, BaseEquipAdd_BS, AddiEquipAdd_BS, StrenEquipAdd_BS, 
        EquipProp_BS, Extra_BS, Goods#goods.battle_power, Goods#goods.partner_id, Goods#goods.custom_type, ShowBaseAdd_BS],
                    "id",
                    Goods#goods.id
            ).



%% 从数据库的goods表删除物品
db_delete_goods(PlayerId, GoodsId) ->
    db:delete(PlayerId, goods, [{id, GoodsId}]).

%% 系统数据库队列，从数据库的goods表删除物品
db_delete_goods(GoodsId) ->
    db:delete(?DB_SYS, goods, [{id, GoodsId}]).

%% 获取可装备物品的装备位置
%% @para: Goods_Or_GoodsTpl => 实际物品对象或物品模板
get_equip_pos(Goods_Or_GoodsTpl) ->
    ?ASSERT(is_can_equiped(Goods_Or_GoodsTpl), Goods_Or_GoodsTpl),
    case lib_goods:get_type(Goods_Or_GoodsTpl) =:= ?GOODS_T_PAR_EQUIP of
        true ->
            case get_subtype(Goods_Or_GoodsTpl) of
                ?PEQP_T_NECKLACE -> ?PEQP_POS_NECKLACE;
                ?PEQP_T_MAGIC_KEY -> ?PEQP_POS_MAGIC_KEY;
                ?PEQP_T_KEEPSAKE -> ?PEQP_POS_KEEPSAKE;
                ?PEQP_T_SKIN -> ?PEQP_POS_SKIN;
                ?PEQP_T_YAODAN -> ?PEQP_POS_YAODAN;
                ?PEQP_T_SEAL -> ?PEQP_POS_SEAL
            end;
        false ->
            case is_weapon(Goods_Or_GoodsTpl) of
                true -> ?EQP_POS_WEAPON;  % 武器
                false ->
                    case get_subtype(Goods_Or_GoodsTpl) of
                        ?EQP_T_BRACER        -> ?EQP_POS_BRACER;            % 护腕
                        ?EQP_T_BARDE       ->   ?EQP_POS_BARDE;             % 铠甲
                        ?EQP_T_SHOES         -> ?EQP_POS_SHOES;             % 鞋子
                        ?EQP_T_NECKLACE     ->  ?EQP_POS_NECKLACE;          % 项链
                        ?EQP_T_WAISTBAND    ->  ?EQP_POS_WAISTBAND;         % 腰带

                        %% 以下都是时装
                        ?EQP_T_HEADWEAR  ->     ?EQP_POS_HEADWEAR;          % 时装（头饰）
                        ?EQP_T_CLOTHES  ->      ?EQP_POS_CLOTHES           % 时装（服饰)
                    end
            end
    end.



%% 是否合法的绑定状态？
is_valid_bind_state(BindState) ->
    ?BIND_MIN =< BindState andalso BindState =< ?BIND_MAX.

%% 是否合法的品质？
is_valid_quality(Quality) ->
    ?QUALITY_MIN =< Quality andalso Quality =< ?QUALITY_MAX.


%% 判定物品应该放在哪个小背包的位置
decide_bag_location(Goods) when is_record(Goods, goods) ->
    case is_equip(Goods) of
        true -> ?LOC_BAG_EQ;
        false ->
            case is_can_use(Goods) of
                true -> ?LOC_BAG_USABLE;
                false -> ?LOC_BAG_UNUSABLE
            end
    end;
    
decide_bag_location(GoodsTpl) ->
    case lib_goods:is_equip(GoodsTpl) of
        true -> ?LOC_BAG_EQ;
        false ->
            case lib_goods:is_can_use(GoodsTpl) of
                true -> ?LOC_BAG_USABLE;
                false -> ?LOC_BAG_UNUSABLE
            end
    end.


make_new_goods_2(Goods, [{Key, Value} | T]) ->
    Goods2 = case Key of
                bind_state ->
                    % ?ASSERT(is_valid_bind_state(Value), {Value, get_no(Goods)}), 此断言已经不适用，虚拟物品没有绑定状态
                    Value1 =
                        case ?BIND_ON_GET =:= Value of
                            true -> ?BIND_ALREADY;
                            false -> Value
                        end,
                    Goods#goods{bind_state = Value1};
                quality ->
                    case is_valid_quality(Value) of
                        true -> Goods#goods{quality = Value};
                        false -> Goods
                    end;
                slot ->
                    ?ASSERT(Value > 0, Value),
                    Goods#goods{slot = Value};
                location ->
                    Goods#goods{location = Value};
                expire_time ->
                    Goods#goods{expire_time = Value};
                extra ->
                    Extra = 
                        case Value of
                            {gift, [FromPlayerId, BlessingNo]} ->
                                [{gift, [FromPlayerId, BlessingNo]} | Goods#goods.extra];
                            _ ->
                                Goods#goods.extra
                        end,
                    Goods#goods{extra = Extra};
                strenlv ->
                    Goods;
                % 其他。。。

                _ ->
%%                    ?ASSERT(false, {Key, get_no(Goods)}),
                    Goods
             end,
    make_new_goods_2(Goods2, T);
make_new_goods_2(Goods, []) ->
    Goods.



%% ============================== Local Funcitons =============================================


% %% 转为attr结构体（先计算，然后转为attr结构体）
% remake_field_equip_add_from_tpl(GoodsTpl, Quality) ->
%     ?ASSERT(is_equip(GoodsTpl)),
%     ?ASSERT(util:is_in_range(Quality, ?QUALITY_MIN, ?QUALITY_MAX)),
%     QualityCoefTuple = GoodsTpl#goods_tpl.quality_coef,
%     ?ASSERT(is_tuple(QualityCoefTuple)
%             andalso tuple_size(QualityCoefTuple) == ?QUALITY_MAX
%            ),
%     QualityCoef = erlang:element(Quality, QualityCoefTuple),

%     EquipAdd = [{AttrName, util:ceil(ValueBase * QualityCoef)} ||
%                     {AttrName, ValueBase} <- GoodsTpl#goods_tpl.equip_add_base],
%     % 转为attr结构体
%     lib_common:to_attrs_record(EquipAdd).



build_base_equip_add_bitstring(Goods) ->
    % case is_random_equip(Goods) of
    %     true -> % 随机装备才保存其属性加成到数据库
    %         L = to_equip_add_kv_tuple_list(Goods#goods.equip_add),
    %         ?ASSERT(L /= []),
    %         util:term_to_bitstring(L);
    %     false ->
    %         <<>>   % 这里返回空bitstring，让数据库中对应保存的是空字符串，下同
    % end.
    case is_equip(Goods) of
        true ->
            ?ASSERT(is_record(get_base_equip_add(Goods), attrs), Goods),
            case to_equip_add_kv_tuple_list(get_base_equip_add(Goods)) of
                [] ->
                    % ?ASSERT(false, Goods),  % 目前这里先断言装备肯定是至少有加成一个属性的，以后如果不合适的话，再删掉此断言。
                    <<>>;  % 容错，返回空bitstring，让数据库中对应保存的是空字符串
                L ->
                    ?ASSERT(is_list(L), L),
                    util:term_to_bitstring(L)
            end;
        false ->
            <<>>  % 非装备则固定返回空bitstring，让数据库中对应保存的是空字符串
    end.


build_addi_equip_add_bitstring(Goods) ->
    case is_equip(Goods) of
        true ->
            % ?ASSERT(is_record(get_addi_equip_add(Goods), attrs), Goods),
            % case to_equip_add_kv_tuple_list(get_addi_equip_add(Goods)) of
            case get_addi_ep_add_kv(Goods) of
                [] ->
                    % ?ASSERT(false, Goods),  % 目前这里先断言装备肯定是至少有加成一个属性的，以后如果不合适的话，再删掉此断言。
                    <<>>;  % 容错，返回空bitstring，让数据库中对应保存的是空字符串
                L ->
                    ?ASSERT(is_list(L), L),
                    util:term_to_bitstring(L)
            end;
        false ->
            <<>>  % 非装备则固定返回空bitstring，让数据库中对应保存的是空字符串
    end.


build_stren_equip_add_bitstring(Goods) ->
    case is_equip(Goods) of
        true ->
            ?ASSERT(is_record(get_stren_equip_add(Goods), attrs), Goods),
            case to_equip_add_kv_tuple_list(get_stren_equip_add(Goods)) of
                [] ->
                    <<>>;  % 容错，返回空bitstring，让数据库中对应保存的是空字符串
                L ->
                    ?ASSERT(is_list(L), L),
                    util:term_to_bitstring(L)
            end;
        false ->
            <<>>  % 非装备则固定返回空bitstring，让数据库中对应保存的是空字符串
    end.

%%
%% 做法类似build_equip_add_bitstring（）， 结构体转为key-value的元组列表形式的bitstring
build_equip_prop_bitstring(Goods) ->
    case is_equip(Goods) of
        true ->
            ?ASSERT(is_record(get_equip_prop(Goods), equip_prop), Goods),
            case to_equip_prop_kv_tuple_list(get_equip_prop(Goods)) of
                [] ->
                    %?ASSERT(false, Goods),
                    <<>>;
                L ->
                    ?ASSERT(is_list(L), L),
                    util:term_to_bitstring(L)
            end;
        false ->
            <<>>
    end.




%% 元组列表形式转为相同格式的对应的bitstring
build_goods_extra_bitstring(Goods) ->
    case Goods#goods.extra of
        [] ->
            <<>>;
        TupleList when is_list(TupleList) ->
            util:term_to_bitstring(TupleList)
    end.




%% kv: 表示key-value
to_equip_add_kv_tuple_list(EquipAdd) ->
    ?ASSERT(is_record(EquipAdd, attrs), EquipAdd),
    lib_attribute:extract_nonzero_fields_info(EquipAdd).


to_equip_prop_kv_tuple_list(EquipProp) ->
    ?ASSERT(is_record(EquipProp, equip_prop), EquipProp),
    extract_nonzero_fields_info_from(EquipProp).


%% 从equip_prop结构体提取字段信息
%% @return：元素为{字段名, 字段值}的列表
extract_nonzero_fields_info_from(EquipProp) when is_record(EquipProp, equip_prop) ->
    FieldList = record_info(fields, equip_prop),
    F = fun(Field, AccInfoList) ->
            Index = get_field_index_in_equip_prop(Field),
            [{Field, element(Index, EquipProp)} | AccInfoList]
        end,
    FieldVauleList = lists:foldl(F, [], FieldList),
    %% 以下是容错代码
    case lists:keyfind(?EQP_PROP_GEM_INLAY, 1, FieldVauleList) of
        false -> FieldVauleList;
        {?EQP_PROP_GEM_INLAY, GemInlayList} ->
            F1 = fun({HNo, Id}, Acc) ->
                case Id =:= ?INVALID_ID of
                    true -> [{HNo, Id} | Acc];
                    false ->
                        case get_goods_by_id(Id) of
                            null -> [{HNo, ?INVALID_ID} | Acc];
                            _ -> [{HNo, Id} | Acc]
                        end
                end
            end,
            NewGemInlayList = lists:foldl(F1, [], GemInlayList),
            case GemInlayList =:= NewGemInlayList of
                true -> FieldVauleList;
                false -> lists:keyreplace(?EQP_PROP_GEM_INLAY, 1, FieldVauleList, {?EQP_PROP_GEM_INLAY, NewGemInlayList})
            end
    end.


%% 获取属性字段在equip_prop结构体中的索引
get_field_index_in_equip_prop(Field) ->
    case Field of
        ?EQP_PROP_STREN_LV -> #equip_prop.stren_lv;
        ?EQP_PROP_STREN_EXP -> #equip_prop.stren_exp;
        ?EQP_PROP_GEM_INLAY -> #equip_prop.gem_inlay
    end.


%% 玩家物品结构体所在的ets_inv_goods表名
my_ets_inv_goods(GoodsId) when is_integer(GoodsId) ->
    ?ASSERT(?ETS_INV_GOODS_COUNT =< 10),      % watch out: 硬代码断言！！！ 认为10个应该足够了！
    case GoodsId rem ?ETS_INV_GOODS_COUNT of
        0 ->
            ?ETS_INV_GOODS_1;
        1 ->
            ?ETS_INV_GOODS_2;
        2 ->
            ?ETS_INV_GOODS_3;
        3 ->
            ?ETS_INV_GOODS_4;
        4 ->
            ?ETS_INV_GOODS_5;
        5 ->
            ?ETS_INV_GOODS_6;
        6 ->
            ?ETS_INV_GOODS_7;
        7 ->
            ?ETS_INV_GOODS_8;
        8 ->
            ?ETS_INV_GOODS_9;
        9 ->
            ?ETS_INV_GOODS_10;
        _ ->
            ?ETS_INV_GOODS_10     % 返回默认的ETS_INV_GOODS_10以容错
    end;
my_ets_inv_goods(Goods) ->
    my_ets_inv_goods(Goods#goods.id).


change_stren_lv_by_stren_exp(CurStrenLv, Goods) when is_record(Goods, goods) ->
    change_stren_lv_by_stren_exp(CurStrenLv, get_lv(Goods), get_stren_exp(Goods)).

change_stren_lv_by_stren_exp(CurStrenLv, Lv, Exp) ->
    ExpLim = get_stren_exp_lim(CurStrenLv + 1, Lv),
    case Exp < ExpLim of
        true ->
            {CurStrenLv, Exp};
        _ ->
            change_stren_lv_by_stren_exp(CurStrenLv + 1, Lv, Exp - ExpLim)
    end.


%% 获取装备上的宝石id列表
get_gem_id_list(Goods) ->
    case lib_goods:is_equip(Goods) of
        false -> [];
        true ->
            GemStoneList = lib_goods:get_equip_gemstone(Goods),
            F = fun({_HoleNo, Id}, Acc) ->
                case Id =:= ?INVALID_ID of
                    true -> Acc;
                    false -> [Id | Acc]
                end
            end,
            lists:foldl(F, [], GemStoneList)
    end.


%% para [{区域编号，左下角X坐标，左下角Y坐标，宽，高}, ...]
rand_get_xy_by_area(AreaList) ->
    case AreaList =:= [] of
        true -> {0, 0};
        false ->
            {_AreaNo, XMin, YMin, W, H} = lists:nth(util:rand(1, length(AreaList)), AreaList), 
            X = util:rand(XMin, XMin + W),
            Y = util:rand(YMin, YMin + H), 
            case X > XMin + W orelse Y > YMin + H of
                true ->
                    ?ERROR_MSG("lib_goods:rand_get_xy_by_area error!RetXY:~p, Range:~p~n", [{X,Y}, {XMin + W, YMin + H}]);
                false -> skip
            end,
            {X, Y}
    end.