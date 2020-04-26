%%%--------------------------------------
%%% @Module  : lib_attribute
%%% @Author  : huangjf
%%% @Email   :
%%% @Created : 2013.7.17
%%% @Description : 属性的相关函数
%%%--------------------------------------
-module(lib_attribute).

-export([
        to_attrs_record/1,
        to_addi_equip_add_attrs_record/1,
        to_talents_record/1,
        to_addi_equip_eff/1,
        adjust_attrs/1,
        compare_attrs/2,
        get_field_index_in_attrs/1,
        attr_name_to_obj_info_code/1,
        obj_info_code_to_attr_name/1,

        sum_talents_from_attrs_list/1,
        sum_talents/1,
        sum_attrs/1,
        sum_two_attrs/2,

        calc_attrs_for_coef/2,

        extract_nonzero_fields_info/1,

        ajust_value_for_send_to_client/2,

        calc_guild_attrs/2,
        calc_cultivate_attrs/2,
        calc_equip_suit_attrs/2,
        attr_bonus/2,
        calc_rate_attrs/2,              %% 处理比例属性
        calc_passi_eff_attrs/2

    ]).


-include("common.hrl").
-include("record.hrl").
-include("obj_info_code.hrl").
-include("attribute.hrl").
-include("bo.hrl").
-include("record/guild_record.hrl").
-include("record/goods_record.hrl").
-include("skill.hrl").
-include("equip.hrl").


%% 提取attrs结构体中的信息，组成talents结构体
to_talents_record(Attrs) when is_record(Attrs, attrs) ->
    #talents{
        str = Attrs#attrs.talent_str,
        con = Attrs#attrs.talent_con,
        sta = Attrs#attrs.talent_sta,
        spi = Attrs#attrs.talent_spi,
        agi = Attrs#attrs.talent_agi
        };

%% @para： {力量，体质，耐力，灵力，敏捷}， 顺序不要调换!
to_talents_record({Str, Con, Sta, Spi, Agi}) ->
    #talents{
        str = Str,
        con = Con,
        sta = Sta,
        spi = Spi,
        agi = Agi
        }.


%% 转为attr结构体
%% @para: KV_TupleList => [] | [{属性名，属性值}, ...]
%% @return: attrs结构体
to_attrs_record(KV_TupleList) ->
    ?ASSERT(util:is_tuple_list(KV_TupleList), KV_TupleList),
    F = fun({AttrName, Value}, AttrsRd) ->
            Index = get_field_index_in_attrs(AttrName),
            setelement(Index, AttrsRd, Value)
        end,
    lists:foldl(F, #attrs{}, KV_TupleList).

%% 特效属性
to_addi_equip_eff(No) ->
    EquipEff = data_equip_speci_effect:get(No),
    EffName = EquipEff#equip_speci_effect_tpl.eff_name,
    Value = EquipEff#equip_speci_effect_tpl.value,

    Ret = #attrs{},

    Ret1 = 
    case eff_to_attr(EffName) of
        null -> Ret;
        {AttrName1,AttrName2} ->
            Index1 = get_field_index_in_attrs(AttrName1),
            Ret2 = setelement(Index1, Ret, Value),
            Index2 = get_field_index_in_attrs(AttrName2),
            setelement(Index2, Ret2, Value);
        AttrName ->
            Index = get_field_index_in_attrs(AttrName),
            case EffName =:= ?EQUIP_EFFECT_DEC_ACT_SPEED_RATE of
                true ->
                    setelement(Index, Ret, -Value);
                false ->
                    setelement(Index, Ret, Value)
            end
    end,

    Ret1.

eff_to_attr(EffName) ->
    case EffName of 
        ?EQUIP_EFFECT_PHY_CRIT -> ?ATTR_PHY_CRIT;
        ?EQUIP_EFFECT_MAG_CRIT -> ?ATTR_MAG_CRIT;

        ?EQUIP_EFFECT_CRIT -> {?ATTR_PHY_CRIT,?ATTR_MAG_CRIT};

        ?EQUIP_EFFECT_PHY_TEN -> ?ATTR_PHY_TEN;
        ?EQUIP_EFFECT_MAG_TEN -> ?ATTR_MAG_TEN;

        ?EQUIP_EFFECT_TEN -> {?ATTR_PHY_TEN,?ATTR_MAG_TEN};

        ?EQUIP_EFFECT_SEAL_HIT -> ?ATTR_SEAL_HIT;
        ?EQUIP_EFFECT_SEAL_RESIS -> ?ATTR_SEAL_RESIS;

        ?EQUIP_EFFECT_HEAL_VALUE -> ?ATTR_HEAL_VALUE;
        ?EQUIP_EFFECT_DO_PHY_DAM_SCALING -> ?ATTR_DO_PHY_DAM_SCALING;
        ?EQUIP_EFFECT_DO_MAG_DAM_SCALING -> ?ATTR_DO_MAG_DAM_SCALING;

        ?EQUIP_EFFECT_DO_DAM_SCALING -> {?ATTR_DO_PHY_DAM_SCALING,?ATTR_DO_MAG_DAM_SCALING};

        % 修改反震特效为生命值以及法力值
        ?EQUIP_EFFECT_RET_DAM_PROBA -> ?ATTR_HP_LIM;
        ?EQUIP_EFFECT_RET_DAM_COEF -> ?ATTR_MP_LIM;
        ?EQUIP_EFFECT_BE_HEAL_EFF_COEF -> ?ATTR_BE_HEAL_EFF_COEF;
        ?EQUIP_EFFECT_BE_PHY_DAM_REDUCE_COEF -> ?ATTR_BE_PHY_DAM_REDUCE_COEF;
        ?EQUIP_EFFECT_BE_MAG_DAM_REDUCE_COEF -> ?ATTR_BE_MAG_DAM_REDUCE_COEF;

        ?EQUIP_EFFECT_BE_DAM_REDUCE_COEF -> {?ATTR_BE_PHY_DAM_REDUCE_COEF,?ATTR_BE_MAG_DAM_REDUCE_COEF};

        ?EQUIP_EFFECT_BE_PHY_DAM_SHRINK -> ?ATTR_BE_PHY_DAM_SHRINK;
        ?EQUIP_EFFECT_BE_MAG_DAM_SHRINK -> ?ATTR_BE_MAG_DAM_SHRINK;

        ?EQUIP_EFFECT_SEAL_HIT_TO_PARTNER -> ?ATTR_SEAL_HIT_TO_PARTNER;
        ?EQUIP_EFFECT_SEAL_HIT_TO_MON -> ?ATTR_SEAL_HIT_TO_MON;
        ?EQUIP_EFFECT_PHY_DAM_TO_PARTNER -> ?ATTR_PHY_DAM_TO_PARTNER;
        ?EQUIP_EFFECT_PHY_DAM_TO_MON -> ?ATTR_PHY_DAM_TO_MON;
        ?EQUIP_EFFECT_MAG_DAM_TO_PARTNER -> ?ATTR_MAG_DAM_TO_PARTNER;
        ?EQUIP_EFFECT_MAG_DAM_TO_MON -> ?ATTR_MAG_DAM_TO_MON;
        ?EQUIP_EFFECT_BE_CHAOS_ROUND_REPAIR -> ?ATTR_BE_CHAOS_ROUND_REPAIR;
        ?EQUIP_EFFECT_CHAOS_ROUND_REPAIR -> ?ATTR_CHAOS_ROUND_REPAIR;
        ?EQUIP_EFFECT_BE_FROZE_ROUND_REPAIR -> ?ATTR_BE_FROZE_ROUND_REPAIR;
        ?EQUIP_EFFECT_FROZE_ROUND_REPAIR -> ?ATTR_FROZE_ROUND_REPAIR;
        ?EQUIP_EFFECT_NEGLECT_PHY_DEF -> ?ATTR_NEGLECT_PHY_DEF;
        ?EQUIP_EFFECT_NEGLECT_MAG_DEF -> ?ATTR_NEGLECT_MAG_DEF;
        ?EQUIP_EFFECT_NEGLECT_SEAL_RESIS -> ?ATTR_NEGLECT_SEAL_RESIS;
        ?EQUIP_EFFECT_PHY_DAM_TO_SPEED_1 -> ?ATTR_PHY_DAM_TO_SPEED_1;
        ?EQUIP_EFFECT_PHY_DAM_TO_SPEED_2 -> ?ATTR_PHY_DAM_TO_SPEED_2;
        ?EQUIP_EFFECT_MAG_DAM_TO_SPEED_1 -> ?ATTR_MAG_DAM_TO_SPEED_1;
        ?EQUIP_EFFECT_MAG_DAM_TO_SPEED_2 -> ?ATTR_MAG_DAM_TO_SPEED_2;
        ?EQUIP_EFFECT_SEAL_HIT_TO_SPEED -> ?ATTR_SEAL_HIT_TO_SPEED;

        ?EQUIP_EFFECT_BE_DAM_SHRINK -> {?ATTR_BE_PHY_DAM_SHRINK,?ATTR_BE_MAG_DAM_SHRINK};

        ?EQUIP_EFFECT_ADD_ACT_SPEED_RATE -> ?ATTR_ACT_SPEED_RATE;
        ?EQUIP_EFFECT_DEC_ACT_SPEED_RATE -> ?ATTR_ACT_SPEED_RATE;
        ?EQUIP_EFFECT_ANGER_EFF_COEF -> ?ATTR_ANGER_EFF_COEF;

        _ -> null
    end.



%% 转为attr结构体
%% @para: TupleList => [] | [{Index, 属性名，属性值, 精炼等级}, ...]
%% @return: attrs结构体  注意：TupleList 可能包含重复的属实字段，需要把对应的值相加
to_addi_equip_add_attrs_record(TupleList) ->
    % ?DEBUG_MSG("TupleList =~p~n",[TupleList]),
    ?ASSERT(util:is_tuple_list(TupleList), TupleList),
    F = fun({_Index, AttrName, Value, _RefineLv}, AttrsRd) ->
            Index = get_field_index_in_attrs(AttrName),
            OldValue = element(Index, AttrsRd),
            setelement(Index, AttrsRd, Value + OldValue)
        end,
    lists:foldl(F, #attrs{}, TupleList).




%% 矫正当前气血，魔法值，怒气等
adjust_attrs(Attrs) ->
    Attrs#attrs{
        hp = min(Attrs#attrs.hp, Attrs#attrs.hp_lim),
        mp = min(Attrs#attrs.mp, Attrs#attrs.mp_lim),
        anger = min(Attrs#attrs.anger, Attrs#attrs.anger_lim),

        % 矫正概率，避免超出
        phy_combo_att_proba = min(Attrs#attrs.phy_combo_att_proba, ?PROBABILITY_BASE),
        mag_combo_att_proba = min(Attrs#attrs.mag_combo_att_proba, ?PROBABILITY_BASE),
        strikeback_proba = min(Attrs#attrs.strikeback_proba, ?PROBABILITY_BASE),
        pursue_att_proba = min(Attrs#attrs.pursue_att_proba, ?PROBABILITY_BASE),
        ret_dam_proba = min(Attrs#attrs.ret_dam_proba, ?PROBABILITY_BASE),

        % 矫正伤害减免系数，避免超出
        be_phy_dam_reduce_coef = util:minmax(Attrs#attrs.be_phy_dam_reduce_coef, -10, ?MAX_BE_DAM_REDUCE_COEF),
        be_mag_dam_reduce_coef = util:minmax(Attrs#attrs.be_mag_dam_reduce_coef, -10, ?MAX_BE_DAM_REDUCE_COEF)
        }.



%% 比较两个attrs结构体，返回不同值的字段（属性名）列表
compare_attrs(Attrs1, Attrs2) ->
    ?ASSERT( is_record(Attrs1, attrs) andalso is_record(Attrs2, attrs) ),
    AttrNameList = record_info(fields, attrs),
    F = fun(AttrName, DiffAttrNameList) ->
            Index = get_field_index_in_attrs(AttrName),
            case element(Index, Attrs1) /= element(Index, Attrs2) of
                true ->
                    case AttrName of
                        ?ATTR_SEAL_HIT -> [?ATTR_SEAL_HIT, ?ATTR_CHAOS_HIT, ?ATTR_TRANCE_HIT, ?ATTR_FROZEN_HIT] ++ DiffAttrNameList;
                        ?ATTR_SEAL_RESIS -> [?ATTR_SEAL_RESIS, ?ATTR_CHAOS_RESIS, ?ATTR_TRANCE_RESIS, ?ATTR_FROZEN_RESIS] ++ DiffAttrNameList;
                        _ -> [AttrName | DiffAttrNameList]
                    end;
                false ->
                    DiffAttrNameList
            end
        end,
    lists:foldl(F, [], AttrNameList).



%% 获取属性字段在attrs结构体中的索引
get_field_index_in_attrs(AttrName) ->
    case AttrName of
        ?ATTR_HP -> #attrs.hp;
        ?ATTR_HP_LIM -> #attrs.hp_lim;
        ?ATTR_HP_LIM_RATE -> #attrs.hp_lim_rate;
        ?ATTR_MP -> #attrs.mp;
        ?ATTR_MP_LIM -> #attrs.mp_lim;
        ?ATTR_MP_LIM_RATE -> #attrs.mp_lim_rate;

        ?ATTR_PHY_ATT -> #attrs.phy_att;
        ?ATTR_MAG_ATT -> #attrs.mag_att;
        ?ATTR_PHY_DEF -> #attrs.phy_def;
        ?ATTR_MAG_DEF -> #attrs.mag_def;

        ?ATTR_PHY_ATT_RATE -> #attrs.phy_att_rate;
        ?ATTR_MAG_ATT_RATE -> #attrs.mag_att_rate;
        ?ATTR_PHY_DEF_RATE -> #attrs.phy_def_rate;
        ?ATTR_MAG_DEF_RATE -> #attrs.mag_def_rate;

        ?ATTR_HIT -> #attrs.hit;
        ?ATTR_DODGE -> #attrs.dodge;
        ?ATTR_CRIT -> #attrs.crit;
        ?ATTR_TEN -> #attrs.ten;

        ?ATTR_HIT_RATE -> #attrs.hit_rate;
        ?ATTR_DODGE_RATE -> #attrs.dodge_rate;
        ?ATTR_CRIT_RATE -> #attrs.crit_rate;
        ?ATTR_TEN_RATE -> #attrs.ten_rate;

        ?ATTR_TALENT_STR -> #attrs.talent_str;
        ?ATTR_TALENT_CON -> #attrs.talent_con;
        ?ATTR_TALENT_STA -> #attrs.talent_sta;
        ?ATTR_TALENT_SPI -> #attrs.talent_spi;
        ?ATTR_TALENT_AGI -> #attrs.talent_agi;

        ?ATTR_ANGER -> #attrs.anger;
        ?ATTR_ANGER_LIM -> #attrs.anger_lim;

        ?ATTR_ACT_SPEED -> #attrs.act_speed;
        ?ATTR_ACT_SPEED_RATE -> #attrs.act_speed_rate;
        ?ATTR_LUCK -> #attrs.luck;
        ?ATTR_NEGLECT_RET_DAM ->#attrs.neglect_ret_dam;
        ?ATTR_FROZEN_RESIS -> #attrs.frozen_resis;
        ?ATTR_FROZEN_RESIS_LIM -> #attrs.frozen_resis_lim;

        ?ATTR_TRANCE_RESIS -> #attrs.trance_resis;
        ?ATTR_TRANCE_RESIS_LIM -> #attrs.trance_resis_lim;

        ?ATTR_CHAOS_RESIS -> #attrs.chaos_resis;
        ?ATTR_CHAOS_RESIS_LIM -> #attrs.chaos_resis_lim;

        ?ATTR_FROZEN_HIT -> #attrs.frozen_hit;
        ?ATTR_FROZEN_HIT_LIM -> #attrs.frozen_hit_lim;

        ?ATTR_TRANCE_HIT -> #attrs.trance_hit;
        ?ATTR_TRANCE_HIT_LIM -> #attrs.trance_hit_lim;

        ?ATTR_CHAOS_HIT -> #attrs.chaos_hit;
        ?ATTR_CHAOS_HIT_LIM -> #attrs.chaos_hit_lim;

        ?ATTR_SEAL_HIT -> #attrs.seal_hit;
        ?ATTR_SEAL_RESIS -> #attrs.seal_resis;
        ?ATTR_PHY_COMBO_ATT_PROBA ->  #attrs.phy_combo_att_proba;
        ?ATTR_MAG_COMBO_ATT_PROBA ->  #attrs.mag_combo_att_proba;
        ?ATTR_STRIKEBACK_PROBA -> #attrs.strikeback_proba;
        ?ATTR_PURSUE_ATT_PROBA -> #attrs.pursue_att_proba;

        ?ATTR_DO_PHY_DAM_SCALING -> #attrs.do_phy_dam_scaling;
        ?ATTR_DO_MAG_DAM_SCALING -> #attrs.do_mag_dam_scaling;
        ?ATTR_CRIT_COEF -> #attrs.crit_coef;

        ?ATTR_RET_DAM_PROBA -> #attrs.ret_dam_proba;
        ?ATTR_RET_DAM_COEF -> #attrs.ret_dam_coef;

        ?ATTR_BE_HEAL_EFF_COEF -> #attrs.be_heal_eff_coef;

        ?ATTR_HEAL_EFF_COEF -> #attrs.heal_eff_coef;
        ?ATTR_REDUCE_PURSUE_ATT_DAM_COEF -> #attrs.reduce_pursue_att_dam_coef;
        ?ATTR_BE_PHY_DAM_REDUCE_COEF -> #attrs.be_phy_dam_reduce_coef;
        ?ATTR_BE_MAG_DAM_REDUCE_COEF -> #attrs.be_mag_dam_reduce_coef;

        ?ATTR_BE_PHY_DAM_SHRINK -> #attrs.be_phy_dam_shrink;
        ?ATTR_BE_MAG_DAM_SHRINK -> #attrs.be_mag_dam_shrink;

        ?ATTR_PURSUE_ATT_DAM_COEF -> #attrs.pursue_att_dam_coef;
        ?ATTR_ABSORB_HP_COEF -> #attrs.absorb_hp_coef;

        ?ATTR_QUGUI_COEF -> #attrs.qugui_coef;

        ?ATTR_PHY_CRIT -> #attrs.phy_crit;                   % 物理暴击
        ?ATTR_PHY_TEN -> #attrs.phy_ten;                     % 物理坚韧
        ?ATTR_MAG_CRIT -> #attrs.mag_crit;                   % 法术暴击
        ?ATTR_MAG_TEN -> #attrs.mag_ten;                     % 法术坚韧
        ?ATTR_PHY_CRIT_COEF -> #attrs.phy_crit_coef;         % 物理暴击程度
        ?ATTR_MAG_CRIT_COEF -> #attrs.mag_crit_coef;         % 法术暴击程度

        % 预留的字段
        ?ATTR_SEAL_HIT_RATE -> #attrs.seal_hit_rate;
        ?ATTR_SEAL_RESIS_RATE -> #attrs.seal_resis_rate;

        ?ATTR_HEAL_VALUE -> #attrs.heal_value;

        ?ATTR_BE_CHAOS_ATT_TEAM_PAOBA -> #attrs.be_chaos_att_team_paoba;
        ?ATTR_BE_CHAOS_ATT_TEAM_PHY_DAM -> #attrs.be_chaos_att_team_phy_dam;
        ?ATTR_NEGLECT_SEAL_RESIS -> #attrs.neglect_seal_resis;
        ?ATTR_SEAL_HIT_TO_PARTNER -> #attrs.seal_hit_to_partner;
        ?ATTR_SEAL_HIT_TO_MON -> #attrs.seal_hit_to_mon;
        ?ATTR_PHY_DAM_TO_PARTNER -> #attrs.phy_dam_to_partner;
        ?ATTR_PHY_DAM_TO_MON -> #attrs.phy_dam_to_mon;
        ?ATTR_MAG_DAM_TO_PARTNER -> #attrs.mag_dam_to_partner;
        ?ATTR_MAG_DAM_TO_MON -> #attrs.mag_dam_to_mon;
        ?ATTR_BE_CHAOS_ROUND_REPAIR -> #attrs.be_chaos_round_repair;
        ?ATTR_CHAOS_ROUND_REPAIR -> #attrs.chaos_round_repair;
        ?ATTR_BE_FROZE_ROUND_REPAIR -> #attrs.be_froze_round_repair;
        ?ATTR_FROZE_ROUND_REPAIR -> #attrs.froze_round_repair;
        ?ATTR_NEGLECT_PHY_DEF -> #attrs.neglect_phy_def;
        ?ATTR_NEGLECT_MAG_DEF -> #attrs.neglect_mag_def;

        ?ATTR_PHY_DAM_TO_SPEED_1 -> #attrs.phy_dam_to_speed_1;
        ?ATTR_PHY_DAM_TO_SPEED_2 -> #attrs.phy_dam_to_speed_2;
        ?ATTR_MAG_DAM_TO_SPEED_1 -> #attrs.mag_dam_to_speed_1;
        ?ATTR_MAG_DAM_TO_SPEED_2 -> #attrs.mag_dam_to_speed_2;
        ?ATTR_SEAL_HIT_TO_SPEED -> #attrs.seal_hit_to_speed;

        ?ATTR_REVIVE_HEAL_COEF -> #attrs.revive_heal_coef;
        ?ATTR_ANGER_EFF_COEF -> #attrs.anger_eff_coef;

        reserved_field3 -> #attrs.reserved_field3
    end.



%% 属性名转为对应的对象信息代号（atom -> integer），用于打包协议（和客户端通信）
attr_name_to_obj_info_code(AttrName) ->
    case AttrName of
        ?ATTR_HP ->                 ?OI_CODE_HP;
        ?ATTR_HP_LIM ->             ?OI_CODE_HP_LIM;
        ?ATTR_HP_LIM_RATE ->        ?INVALID_NO;
        ?ATTR_MP ->                 ?OI_CODE_MP;
        ?ATTR_MP_LIM ->             ?OI_CODE_MP_LIM;
        ?ATTR_MP_LIM_RATE ->        ?INVALID_NO;

        ?ATTR_PHY_ATT ->            ?OI_CODE_PHY_ATT;
        ?ATTR_MAG_ATT  ->           ?OI_CODE_MAG_ATT;
        ?ATTR_PHY_DEF ->            ?OI_CODE_PHY_DEF;
        ?ATTR_MAG_DEF ->            ?OI_CODE_MAG_DEF;

        ?ATTR_HIT ->                ?OI_CODE_HIT;
        ?ATTR_DODGE ->              ?OI_CODE_DODGE;
        ?ATTR_CRIT ->               ?OI_CODE_CRIT;
        ?ATTR_TEN ->                ?OI_CODE_TEN;

        ?ATTR_TALENT_STR ->         ?OI_CODE_TALENT_STR;
        ?ATTR_TALENT_CON ->         ?OI_CODE_TALENT_CON;
        ?ATTR_TALENT_STA ->         ?OI_CODE_TALENT_STA;
        ?ATTR_TALENT_SPI ->         ?OI_CODE_TALENT_SPI;
        ?ATTR_TALENT_AGI ->         ?OI_CODE_TALENT_AGI;

        ?ATTR_ANGER ->              ?OI_CODE_ANGER;
        ?ATTR_ANGER_LIM ->          ?OI_CODE_ANGER_LIM;
        ?ATTR_ACT_SPEED ->          ?OI_CODE_ACT_SPEED;
        ?ATTR_LUCK ->               ?OI_CODE_LUCK;
        ?ATTR_NEGLECT_RET_DAM ->    ?OI_CODE_NEGLECT_RET_DAM;

        ?ATTR_FROZEN_RESIS ->       ?OI_CODE_FROZEN_RESIS;
        ?ATTR_FROZEN_RESIS_LIM ->   ?OI_CODE_FROZEN_RESIS_LIM;

        ?ATTR_TRANCE_RESIS ->       ?OI_CODE_TRANCE_RESIS;
        ?ATTR_TRANCE_RESIS_LIM ->   ?OI_CODE_TRANCE_RESIS_LIM;

        ?ATTR_CHAOS_RESIS ->        ?OI_CODE_RESIS_CHAOS;
        ?ATTR_CHAOS_RESIS_LIM ->    ?OI_CODE_RESIS_CHAOS_LIM;

        ?ATTR_FROZEN_HIT ->         ?OI_CODE_FROZEN_HIT;
        ?ATTR_FROZEN_HIT_LIM ->     ?OI_CODE_FROZEN_HIT_LIM;

        ?ATTR_TRANCE_HIT ->         ?OI_CODE_TRANCE_HIT;
        ?ATTR_TRANCE_HIT_LIM ->     ?OI_CODE_TRANCE_HIT_LIM;

        ?ATTR_CHAOS_HIT ->          ?OI_CODE_CHAOS_HIT;
        ?ATTR_CHAOS_HIT_LIM ->      ?OI_CODE_CHAOS_HIT_LIM;
        ?ATTR_SEAL_HIT ->           ?OI_CODE_SEAL_HIT;
        ?ATTR_SEAL_RESIS ->         ?OI_CODE_SEAL_RESIS;
        ?ATTR_PHY_COMBO_ATT_PROBA ->    ?OI_CODE_PHY_COMBO_ATT_PROBA;
        ?ATTR_MAG_COMBO_ATT_PROBA ->    ?OI_CODE_MAG_COMBO_ATT_PROBA;
        ?ATTR_STRIKEBACK_PROBA ->   ?OI_CODE_STRIKEBACK_PROBA;
        ?ATTR_PURSUE_ATT_PROBA ->   ?OI_CODE_PURSUE_ATT_PROBA;

        ?ATTR_DO_PHY_DAM_SCALING ->     ?OI_CODE_DO_PHY_DAM_SCALING;
        ?ATTR_DO_MAG_DAM_SCALING ->     ?OI_CODE_DO_MAG_DAM_SCALING;

        ?ATTR_CRIT_COEF ->          ?OI_CODE_CRIT_COEF;

        ?ATTR_RET_DAM_PROBA ->      ?OI_CODE_RET_DAM_PROBA;
        ?ATTR_RET_DAM_COEF ->       ?OI_CODE_RET_DAM_COEF;

        ?ATTR_BE_HEAL_EFF_COEF ->   ?OI_CODE_BE_HEAL_EFF_COEF;

        ?ATTR_BE_PHY_DAM_REDUCE_COEF -> ?OI_CODE_BE_PHY_DAM_REDUCE_COEF;
        ?ATTR_BE_MAG_DAM_REDUCE_COEF -> ?OI_CODE_BE_MAG_DAM_REDUCE_COEF;

        ?ATTR_BE_PHY_DAM_SHRINK -> ?OI_CODE_BE_PHY_DAM_SHRINK;
        ?ATTR_BE_MAG_DAM_SHRINK -> ?OI_CODE_BE_MAG_DAM_SHRINK;

        ?ATTR_PURSUE_ATT_DAM_COEF ->    ?OI_CODE_PURSUE_ATT_DAM_COEF;
        ?ATTR_ABSORB_HP_COEF ->         ?OI_CODE_ABSORB_HP_COEF;

        ?ATTR_QUGUI_COEF ->             ?OI_CODE_QUGUI_COEF;

        ?ATTR_PHY_CRIT -> ?OI_CODE_PHY_CRIT;                   % 物理暴击
        ?ATTR_PHY_TEN -> ?OI_CODE_PHY_TEN;                     % 物理坚韧
        ?ATTR_MAG_CRIT -> ?OI_CODE_MAG_CRIT;                   % 法术暴击
        ?ATTR_MAG_TEN -> ?OI_CODE_MAG_TEN;                     % 法术坚韧
        ?ATTR_PHY_CRIT_COEF -> ?OI_CODE_PHY_CRIT_COEF;         % 物理暴击程度
        ?ATTR_MAG_CRIT_COEF -> ?OI_CODE_MAG_CRIT_COEF;         % 法术暴击程度

        ?ATTR_HEAL_VALUE -> ?OI_CODE_HEAL_VALUE;

        ?ATTR_BE_CHAOS_ATT_TEAM_PAOBA -> ?OI_BE_CHAOS_ATT_TEAM_PAOBA;
        ?ATTR_BE_CHAOS_ATT_TEAM_PHY_DAM -> ?OI_BE_CHAOS_ATT_TEAM_PHY_DAM;
        ?ATTR_NEGLECT_SEAL_RESIS -> ?OI_NEGLECT_SEAL_RESIS;
        ?ATTR_SEAL_HIT_TO_PARTNER -> ?OI_SEAL_HIT_TO_PARTNER;
        ?ATTR_SEAL_HIT_TO_MON -> ?OI_SEAL_HIT_TO_MON;
        ?ATTR_PHY_DAM_TO_PARTNER -> ?OI_PHY_DAM_TO_PARTNER;
        ?ATTR_PHY_DAM_TO_MON -> ?OI_PHY_DAM_TO_MON;
        ?ATTR_MAG_DAM_TO_PARTNER -> ?OI_MAG_DAM_TO_PARTNER;
        ?ATTR_MAG_DAM_TO_MON -> ?OI_MAG_DAM_TO_MON;
        ?ATTR_BE_CHAOS_ROUND_REPAIR -> ?OI_BE_CHAOS_ROUND_REPAIR;
        ?ATTR_CHAOS_ROUND_REPAIR -> ?OI_CHAOS_ROUND_REPAIR;
        ?ATTR_BE_FROZE_ROUND_REPAIR -> ?OI_BE_FROZE_ROUND_REPAIR;
        ?ATTR_FROZE_ROUND_REPAIR -> ?OI_FROZE_ROUND_REPAIR;
        ?ATTR_NEGLECT_PHY_DEF -> ?OI_NEGLECT_PHY_DEF;
        ?ATTR_NEGLECT_MAG_DEF -> ?OI_NEGLECT_MAG_DEF;

        ?ATTR_PHY_DAM_TO_SPEED_1 -> ?OI_PHY_DAM_TO_SPEED_1;
        ?ATTR_PHY_DAM_TO_SPEED_2 -> ?OI_PHY_DAM_TO_SPEED_2;
        ?ATTR_MAG_DAM_TO_SPEED_1 -> ?OI_MAG_DAM_TO_SPEED_1;
        ?ATTR_MAG_DAM_TO_SPEED_2 -> ?OI_MAG_DAM_TO_SPEED_2;
        ?ATTR_SEAL_HIT_TO_SPEED -> ?OI_SEAL_HIT_TO_SPEED;

        ?ATTR_REVIVE_HEAL_COEF -> ?OI_REVIVE_HEAL_COEF;

        _ ->                            ?INVALID_NO
    end.

obj_info_code_to_attr_name(Code) ->
    case Code of
        ?OI_CODE_HP ->                 ?ATTR_HP;
        ?OI_CODE_HP_LIM ->             ?ATTR_HP_LIM;
        ?OI_CODE_MP ->                 ?ATTR_MP;
        ?OI_CODE_MP_LIM ->             ?ATTR_MP_LIM;

        ?OI_CODE_PHY_ATT ->            ?ATTR_PHY_ATT;
        ?OI_CODE_MAG_ATT  ->           ?ATTR_MAG_ATT;
        ?OI_CODE_PHY_DEF ->            ?ATTR_PHY_DEF;
        ?OI_CODE_MAG_DEF ->            ?ATTR_MAG_DEF;

        ?OI_CODE_HIT ->                ?ATTR_HIT;
        ?OI_CODE_DODGE ->              ?ATTR_DODGE;
        ?OI_CODE_CRIT ->               ?ATTR_CRIT;
        ?OI_CODE_TEN ->                ?ATTR_TEN;

        ?OI_CODE_TALENT_STR ->         ?ATTR_TALENT_STR;
        ?OI_CODE_TALENT_CON ->         ?ATTR_TALENT_CON;
        ?OI_CODE_TALENT_STA ->         ?ATTR_TALENT_STA;
        ?OI_CODE_TALENT_SPI ->         ?ATTR_TALENT_SPI;
        ?OI_CODE_TALENT_AGI ->         ?ATTR_TALENT_AGI;

        ?OI_CODE_ANGER ->              ?ATTR_ANGER;
        ?OI_CODE_ANGER_LIM ->          ?ATTR_ANGER_LIM;
        ?OI_CODE_ACT_SPEED ->          ?ATTR_ACT_SPEED;
        ?OI_CODE_LUCK ->               ?ATTR_LUCK;
        ?OI_CODE_NEGLECT_RET_DAM ->    ?ATTR_NEGLECT_RET_DAM;

        ?OI_CODE_FROZEN_RESIS ->       ?ATTR_FROZEN_RESIS;
        ?OI_CODE_FROZEN_RESIS_LIM ->   ?ATTR_FROZEN_RESIS_LIM;

        ?OI_CODE_TRANCE_RESIS ->       ?ATTR_TRANCE_RESIS;
        ?OI_CODE_TRANCE_RESIS_LIM ->   ?ATTR_TRANCE_RESIS_LIM;

        ?OI_CODE_RESIS_CHAOS ->        ?ATTR_CHAOS_RESIS;
        ?OI_CODE_RESIS_CHAOS_LIM ->    ?ATTR_CHAOS_RESIS_LIM;

        ?OI_CODE_FROZEN_HIT ->         ?ATTR_FROZEN_HIT;
        ?OI_CODE_FROZEN_HIT_LIM ->     ?ATTR_FROZEN_HIT_LIM;

        ?OI_CODE_TRANCE_HIT ->         ?ATTR_TRANCE_HIT;
        ?OI_CODE_TRANCE_HIT_LIM ->     ?ATTR_TRANCE_HIT_LIM;

        ?OI_CODE_CHAOS_HIT ->          ?ATTR_CHAOS_HIT;
        ?OI_CODE_CHAOS_HIT_LIM ->      ?ATTR_CHAOS_HIT_LIM;
        ?OI_CODE_SEAL_HIT ->           ?ATTR_SEAL_HIT;
        ?OI_CODE_SEAL_RESIS ->         ?ATTR_SEAL_RESIS;
        ?OI_CODE_PHY_COMBO_ATT_PROBA ->    ?ATTR_PHY_COMBO_ATT_PROBA;
        ?OI_CODE_MAG_COMBO_ATT_PROBA ->    ?ATTR_MAG_COMBO_ATT_PROBA;
        ?OI_CODE_STRIKEBACK_PROBA ->   ?ATTR_STRIKEBACK_PROBA;
        ?OI_CODE_PURSUE_ATT_PROBA ->   ?ATTR_PURSUE_ATT_PROBA;

        ?OI_CODE_DO_PHY_DAM_SCALING ->     ?ATTR_DO_PHY_DAM_SCALING;
        ?OI_CODE_DO_MAG_DAM_SCALING ->     ?ATTR_DO_MAG_DAM_SCALING;

        ?OI_CODE_CRIT_COEF ->          ?ATTR_CRIT_COEF;

        ?OI_CODE_RET_DAM_PROBA ->      ?ATTR_RET_DAM_PROBA;
        ?OI_CODE_RET_DAM_COEF ->       ?ATTR_RET_DAM_COEF;

        ?OI_CODE_BE_HEAL_EFF_COEF ->   ?ATTR_BE_HEAL_EFF_COEF;

        ?OI_CODE_BE_PHY_DAM_REDUCE_COEF -> ?ATTR_BE_PHY_DAM_REDUCE_COEF;
        ?OI_CODE_BE_MAG_DAM_REDUCE_COEF -> ?ATTR_BE_MAG_DAM_REDUCE_COEF;

        ?OI_CODE_BE_PHY_DAM_SHRINK -> ?ATTR_BE_PHY_DAM_SHRINK;
        ?OI_CODE_BE_MAG_DAM_SHRINK -> ?ATTR_BE_MAG_DAM_SHRINK;

        ?OI_CODE_ABSORB_HP_COEF ->         ?ATTR_ABSORB_HP_COEF;
        ?OI_CODE_PURSUE_ATT_DAM_COEF ->    ?ATTR_PURSUE_ATT_DAM_COEF;

        ?OI_CODE_QUGUI_COEF ->             ?ATTR_QUGUI_COEF;

        ?OI_CODE_PHY_CRIT -> ?ATTR_PHY_CRIT ;                   % 物理暴击
        ?OI_CODE_PHY_TEN -> ?ATTR_PHY_TEN ;                     % 物理坚韧
        ?OI_CODE_MAG_CRIT -> ?ATTR_MAG_CRIT ;                   % 法术暴击
        ?OI_CODE_MAG_TEN -> ?ATTR_MAG_TEN ;                     % 法术坚韧
        ?OI_CODE_PHY_CRIT_COEF -> ?ATTR_PHY_CRIT_COEF ;         % 物理暴击程度
        ?OI_CODE_MAG_CRIT_COEF -> ?ATTR_MAG_CRIT_COEF ;         % 法术暴击程度
        ?OI_CODE_HEAL_VALUE-> ?ATTR_HEAL_VALUE;

        ?OI_BE_CHAOS_ATT_TEAM_PAOBA -> ?ATTR_BE_CHAOS_ATT_TEAM_PAOBA;
        ?OI_BE_CHAOS_ATT_TEAM_PHY_DAM -> ?ATTR_BE_CHAOS_ATT_TEAM_PHY_DAM;
        ?OI_NEGLECT_SEAL_RESIS -> ?ATTR_NEGLECT_SEAL_RESIS;
        ?OI_SEAL_HIT_TO_PARTNER -> ?ATTR_SEAL_HIT_TO_PARTNER;
        ?OI_SEAL_HIT_TO_MON -> ?ATTR_SEAL_HIT_TO_MON;
        ?OI_PHY_DAM_TO_PARTNER -> ?ATTR_PHY_DAM_TO_PARTNER;
        ?OI_PHY_DAM_TO_MON -> ?ATTR_PHY_DAM_TO_MON;
        ?OI_MAG_DAM_TO_PARTNER -> ?ATTR_MAG_DAM_TO_PARTNER;
        ?OI_MAG_DAM_TO_MON -> ?ATTR_MAG_DAM_TO_MON;
        ?OI_BE_CHAOS_ROUND_REPAIR -> ?ATTR_BE_CHAOS_ROUND_REPAIR;
        ?OI_CHAOS_ROUND_REPAIR -> ?ATTR_CHAOS_ROUND_REPAIR;
        ?OI_BE_FROZE_ROUND_REPAIR -> ?ATTR_BE_FROZE_ROUND_REPAIR;
        ?OI_FROZE_ROUND_REPAIR -> ?ATTR_FROZE_ROUND_REPAIR;
        ?OI_NEGLECT_PHY_DEF -> ?ATTR_NEGLECT_PHY_DEF;
        ?OI_NEGLECT_MAG_DEF -> ?ATTR_NEGLECT_MAG_DEF;

         ?OI_PHY_DAM_TO_SPEED_1   -> ?ATTR_PHY_DAM_TO_SPEED_1;
         ?OI_PHY_DAM_TO_SPEED_2   -> ?ATTR_PHY_DAM_TO_SPEED_2;
         ?OI_MAG_DAM_TO_SPEED_1   -> ?ATTR_MAG_DAM_TO_SPEED_1;
         ?OI_MAG_DAM_TO_SPEED_2   -> ?ATTR_MAG_DAM_TO_SPEED_2;
        ?OI_SEAL_HIT_TO_SPEED  ->  ?ATTR_SEAL_HIT_TO_SPEED ;

        ?OI_REVIVE_HEAL_COEF -> ?ATTR_REVIVE_HEAL_COEF;

        _Any -> ?ASSERT(false, _Any), null
    end.


%% @return: talents结构体
sum_talents_from_attrs_list([Attrs]) ->
    to_talents_record(Attrs);
sum_talents_from_attrs_list([_Attrs1, _Attrs2 | _T] = AttrsList) ->
    TalentsList = [to_talents_record(X) ||  X <- AttrsList],
    sum_talents(TalentsList).


%% 多个talents结构体的对应字段相加，返回结果
%% @return: talents结构体
sum_talents([Talents]) ->
    ?ASSERT(is_record(Talents, talents)),
    Talents;
sum_talents([Talents1, Talents2 | T]) ->
    TmpTalents = sum_two_talents(Talents1, Talents2),
    sum_talents([TmpTalents | T]).




%% 多个attrs结构体的对应字段相加，返回结果
%% @return: attrs结构体
sum_attrs([]) ->
    #attrs{};
sum_attrs([Attrs]) ->
    ?ASSERT(is_record(Attrs, attrs)),
    Attrs;
sum_attrs([Attrs1, Attrs2 | T]) ->
    TmpAttrs = sum_two_attrs(Attrs1, Attrs2),
    sum_attrs([TmpAttrs | T]).

%% 两个元组元素值相加抽象做法
sum_two_attrs(Attrs1, Attrs2) ->
	AttrsAcc0 = #attrs{}, 
	Fun = fun(Index, AttrsAcc) ->
				  Value = erlang:element(Index, Attrs1) + erlang:element(Index, Attrs2),
				  erlang:setelement(Index, AttrsAcc, Value)
		  end,
	lists:foldl(Fun, AttrsAcc0, lists:seq(2, erlang:tuple_size(AttrsAcc0))).

%% 直接用上面的抽象做法，方便扩展字段，不然每次修改attr记录都得修改太麻烦且字段太多不好维护易出错 zjy 2020/01/11
%% sum_two_attrs(Attrs1, Attrs2) ->
%%     #attrs{
%%         hp = Attrs1#attrs.hp + Attrs2#attrs.hp,
%%         hp_lim = Attrs1#attrs.hp_lim + Attrs2#attrs.hp_lim,
%%         hp_lim_rate = Attrs1#attrs.hp_lim_rate + Attrs2#attrs.hp_lim_rate,
%%         mp = Attrs1#attrs.mp + Attrs2#attrs.mp,
%%         mp_lim = Attrs1#attrs.mp_lim + Attrs2#attrs.mp_lim,
%%         mp_lim_rate = Attrs1#attrs.mp_lim_rate + Attrs2#attrs.mp_lim_rate,
%% 
%%         phy_att = Attrs1#attrs.phy_att + Attrs2#attrs.phy_att,
%%         phy_att_rate = Attrs1#attrs.phy_att_rate + Attrs2#attrs.phy_att_rate,
%%         mag_att = Attrs1#attrs.mag_att + Attrs2#attrs.mag_att,
%%         mag_att_rate = Attrs1#attrs.mag_att_rate + Attrs2#attrs.mag_att_rate,
%%         phy_def = Attrs1#attrs.phy_def + Attrs2#attrs.phy_def,
%%         phy_def_rate = Attrs1#attrs.phy_def_rate + Attrs2#attrs.phy_def_rate,
%%         mag_def = Attrs1#attrs.mag_def + Attrs2#attrs.mag_def,
%%         mag_def_rate = Attrs1#attrs.mag_def_rate + Attrs2#attrs.mag_def_rate,
%% 
%%         hit = Attrs1#attrs.hit + Attrs2#attrs.hit,
%%         hit_rate = Attrs1#attrs.hit_rate + Attrs2#attrs.hit_rate,
%%         dodge = Attrs1#attrs.dodge + Attrs2#attrs.dodge,
%%         dodge_rate = Attrs1#attrs.dodge_rate + Attrs2#attrs.dodge_rate,
%%         crit = Attrs1#attrs.crit + Attrs2#attrs.crit,
%%         crit_rate = Attrs1#attrs.crit_rate + Attrs2#attrs.crit_rate,
%%         ten = Attrs1#attrs.ten + Attrs2#attrs.ten,
%%         ten_rate = Attrs1#attrs.ten_rate + Attrs2#attrs.ten_rate,
%% 
%%         talent_str = Attrs1#attrs.talent_str + Attrs2#attrs.talent_str,
%%         talent_agi = Attrs1#attrs.talent_agi + Attrs2#attrs.talent_agi,
%%         talent_sta = Attrs1#attrs.talent_sta + Attrs2#attrs.talent_sta,
%%         talent_con = Attrs1#attrs.talent_con + Attrs2#attrs.talent_con,
%%         talent_spi = Attrs1#attrs.talent_spi + Attrs2#attrs.talent_spi,
%% 
%%         anger = Attrs1#attrs.anger + Attrs2#attrs.anger,
%%         anger_lim = Attrs1#attrs.anger_lim + Attrs2#attrs.anger_lim,
%% 
%%         act_speed = Attrs1#attrs.act_speed + Attrs2#attrs.act_speed,
%%         act_speed_rate = Attrs1#attrs.act_speed_rate + Attrs2#attrs.act_speed_rate,
%%         
%%         luck = Attrs1#attrs.luck + Attrs2#attrs.luck,
%%         neglect_ret_dam =  Attrs1#attrs.neglect_ret_dam + Attrs2#attrs.neglect_ret_dam,
%% 
%%         frozen_hit = Attrs1#attrs.frozen_hit + Attrs2#attrs.frozen_hit,
%%         frozen_hit_lim = Attrs1#attrs.frozen_hit_lim + Attrs2#attrs.frozen_hit,
%% 
%%         trance_hit = Attrs1#attrs.trance_hit + Attrs2#attrs.trance_hit,
%%         trance_hit_lim = Attrs1#attrs.trance_hit_lim + Attrs2#attrs.trance_hit_lim,
%% 
%%         chaos_hit = Attrs1#attrs.chaos_hit + Attrs2#attrs.chaos_hit,
%%         chaos_hit_lim = Attrs1#attrs.chaos_hit_lim + Attrs2#attrs.chaos_hit_lim,
%% 
%%         frozen_resis = Attrs1#attrs.frozen_resis + Attrs2#attrs.frozen_resis,
%%         frozen_resis_lim = Attrs1#attrs.frozen_resis_lim + Attrs2#attrs.frozen_resis_lim,
%% 
%%         trance_resis = Attrs1#attrs.trance_resis + Attrs2#attrs.trance_resis,
%%         trance_resis_lim = Attrs1#attrs.trance_resis_lim + Attrs2#attrs.trance_resis_lim,
%% 
%%         chaos_resis = Attrs1#attrs.chaos_resis + Attrs2#attrs.chaos_resis,
%%         chaos_resis_lim = Attrs1#attrs.chaos_resis_lim + Attrs2#attrs.chaos_resis_lim,
%% 
%%         seal_hit = Attrs1#attrs.seal_hit + Attrs2#attrs.seal_hit,
%%         seal_hit_rate = Attrs1#attrs.seal_hit_rate + Attrs2#attrs.seal_hit_rate,
%%         seal_resis = Attrs1#attrs.seal_resis + Attrs2#attrs.seal_resis,
%%         seal_resis_rate = Attrs1#attrs.seal_resis_rate + Attrs2#attrs.seal_resis_rate,
%% 
%%         phy_combo_att_proba = Attrs1#attrs.phy_combo_att_proba + Attrs2#attrs.phy_combo_att_proba,
%%         mag_combo_att_proba = Attrs1#attrs.mag_combo_att_proba + Attrs2#attrs.mag_combo_att_proba,
%%         strikeback_proba = Attrs1#attrs.strikeback_proba + Attrs2#attrs.strikeback_proba,
%%         pursue_att_proba = Attrs1#attrs.pursue_att_proba + Attrs2#attrs.pursue_att_proba,
%% 
%%         do_phy_dam_scaling = Attrs1#attrs.do_phy_dam_scaling + Attrs2#attrs.do_phy_dam_scaling,
%%         do_mag_dam_scaling = Attrs1#attrs.do_mag_dam_scaling + Attrs2#attrs.do_mag_dam_scaling,
%%         crit_coef = Attrs1#attrs.crit_coef + Attrs2#attrs.crit_coef,
%% 
%%         ret_dam_proba = Attrs1#attrs.ret_dam_proba + Attrs2#attrs.ret_dam_proba,
%%         ret_dam_coef = Attrs1#attrs.ret_dam_coef + Attrs2#attrs.ret_dam_coef,
%% 
%%         be_heal_eff_coef = Attrs1#attrs.be_heal_eff_coef + Attrs2#attrs.be_heal_eff_coef,
%% 
%%         be_phy_dam_reduce_coef = Attrs1#attrs.be_phy_dam_reduce_coef + Attrs2#attrs.be_phy_dam_reduce_coef,
%%         be_mag_dam_reduce_coef = Attrs1#attrs.be_mag_dam_reduce_coef + Attrs2#attrs.be_mag_dam_reduce_coef,
%% 
%%         be_phy_dam_shrink = Attrs1#attrs.be_phy_dam_shrink + Attrs2#attrs.be_phy_dam_shrink,
%%         be_mag_dam_shrink = Attrs1#attrs.be_mag_dam_shrink + Attrs2#attrs.be_mag_dam_shrink,
%% 
%%         pursue_att_dam_coef = Attrs1#attrs.pursue_att_dam_coef + Attrs2#attrs.pursue_att_dam_coef,
%%         absorb_hp_coef = Attrs1#attrs.absorb_hp_coef + Attrs2#attrs.absorb_hp_coef,
%% 
%%         phy_crit = Attrs1#attrs.phy_crit + Attrs2#attrs.phy_crit,
%%         phy_ten = Attrs1#attrs.phy_ten + Attrs2#attrs.phy_ten,
%%         mag_crit = Attrs1#attrs.mag_crit + Attrs2#attrs.mag_crit,
%%         mag_ten = Attrs1#attrs.mag_ten + Attrs2#attrs.mag_ten,
%%         phy_crit_coef = Attrs1#attrs.phy_crit_coef + Attrs2#attrs.phy_crit_coef,
%%         mag_crit_coef = Attrs1#attrs.mag_crit_coef + Attrs2#attrs.mag_crit_coef,
%% 
%%         heal_value = Attrs1#attrs.heal_value + Attrs2#attrs.heal_value,
%%         qugui_coef = Attrs1#attrs.qugui_coef + Attrs2#attrs.qugui_coef,
%% 
%%         % 新增属性
%%         be_chaos_att_team_paoba = Attrs1#attrs.be_chaos_att_team_paoba + Attrs2#attrs.be_chaos_att_team_paoba,
%%         be_chaos_att_team_phy_dam = Attrs1#attrs.be_chaos_att_team_phy_dam + Attrs2#attrs.be_chaos_att_team_phy_dam,
%%         neglect_seal_resis = Attrs1#attrs.neglect_seal_resis + Attrs2#attrs.neglect_seal_resis,
%%         seal_hit_to_partner = Attrs1#attrs.seal_hit_to_partner + Attrs2#attrs.seal_hit_to_partner,
%%         seal_hit_to_mon = Attrs1#attrs.seal_hit_to_mon + Attrs2#attrs.seal_hit_to_mon,
%%         phy_dam_to_partner = Attrs1#attrs.phy_dam_to_partner + Attrs2#attrs.phy_dam_to_partner,
%%         phy_dam_to_mon = Attrs1#attrs.phy_dam_to_mon + Attrs2#attrs.phy_dam_to_mon,
%%         mag_dam_to_partner = Attrs1#attrs.mag_dam_to_partner + Attrs2#attrs.mag_dam_to_partner,
%%         mag_dam_to_mon = Attrs1#attrs.mag_dam_to_mon + Attrs2#attrs.mag_dam_to_mon,
%%         be_chaos_round_repair = Attrs1#attrs.be_chaos_round_repair + Attrs2#attrs.be_chaos_round_repair,
%%         chaos_round_repair = Attrs1#attrs.chaos_round_repair + Attrs2#attrs.chaos_round_repair,
%%         be_froze_round_repair = Attrs1#attrs.be_froze_round_repair + Attrs2#attrs.be_froze_round_repair,
%%         froze_round_repair = Attrs1#attrs.froze_round_repair + Attrs2#attrs.froze_round_repair,
%%         neglect_phy_def = Attrs1#attrs.neglect_phy_def + Attrs2#attrs.neglect_phy_def,
%%         neglect_mag_def = Attrs1#attrs.neglect_mag_def + Attrs2#attrs.neglect_mag_def,
%% 
%%         phy_dam_to_speed_1 = Attrs1#attrs.phy_dam_to_speed_1 + Attrs2#attrs.phy_dam_to_speed_1,
%%         phy_dam_to_speed_2 = Attrs1#attrs.phy_dam_to_speed_2 + Attrs2#attrs.phy_dam_to_speed_2,
%%         mag_dam_to_speed_1 = Attrs1#attrs.mag_dam_to_speed_1 + Attrs2#attrs.mag_dam_to_speed_1,
%%         mag_dam_to_speed_2 = Attrs1#attrs.mag_dam_to_speed_2 + Attrs2#attrs.mag_dam_to_speed_2,
%%         seal_hit_to_speed = Attrs1#attrs.seal_hit_to_speed + Attrs2#attrs.seal_hit_to_speed,
%% 
%%         revive_heal_coef = Attrs1#attrs.revive_heal_coef + Attrs2#attrs.revive_heal_coef,
%%         anger_eff_coef = Attrs1#attrs.anger_eff_coef + Attrs2#attrs.anger_eff_coef
%%         }.


calc_attrs_for_coef(Attrs1, Coef) ->
    #attrs{
        hp = round(Attrs1#attrs.hp * Coef),
        hp_lim = round(Attrs1#attrs.hp_lim * Coef),
        hp_lim_rate = round(Attrs1#attrs.hp_lim_rate * Coef),
        mp = round(Attrs1#attrs.mp * Coef),
        mp_lim = round(Attrs1#attrs.mp_lim * Coef),
        mp_lim_rate = round(Attrs1#attrs.mp_lim_rate * Coef),
        phy_att = round(Attrs1#attrs.phy_att * Coef),
        phy_att_rate = Attrs1#attrs.phy_att_rate,
        mag_att = round(Attrs1#attrs.mag_att * Coef),
        mag_att_rate = Attrs1#attrs.mag_att_rate,
        phy_def = round(Attrs1#attrs.phy_def * Coef),
        phy_def_rate = Attrs1#attrs.phy_def_rate ,
        mag_def = round(Attrs1#attrs.mag_def * Coef),
        mag_def_rate = Attrs1#attrs.mag_def_rate,
        hit = Attrs1#attrs.hit ,
        hit_rate = Attrs1#attrs.hit_rate ,
        dodge = Attrs1#attrs.dodge  ,
        dodge_rate = Attrs1#attrs.dodge_rate ,
        crit = Attrs1#attrs.crit  ,
        crit_rate = Attrs1#attrs.crit_rate,
        ten = Attrs1#attrs.ten ,
        ten_rate = Attrs1#attrs.ten_rate,
        talent_str = Attrs1#attrs.talent_str  ,
        talent_agi = Attrs1#attrs.talent_agi ,
        talent_sta = Attrs1#attrs.talent_sta  ,
        talent_con = Attrs1#attrs.talent_con  ,
        talent_spi = Attrs1#attrs.talent_spi  ,
        anger = Attrs1#attrs.anger ,
        anger_lim = Attrs1#attrs.anger_lim ,
        act_speed = round(Attrs1#attrs.act_speed * Coef),
        act_speed_rate = Attrs1#attrs.act_speed_rate,        
        luck = Attrs1#attrs.luck,
        neglect_ret_dam =  Attrs1#attrs.neglect_ret_dam,
        frozen_hit = Attrs1#attrs.frozen_hit * Coef,
        frozen_hit_lim = Attrs1#attrs.frozen_hit_lim * Coef,
        trance_hit = Attrs1#attrs.trance_hit * Coef,
        trance_hit_lim = Attrs1#attrs.trance_hit_lim * Coef,
        chaos_hit = Attrs1#attrs.chaos_hit * Coef,
        chaos_hit_lim = Attrs1#attrs.chaos_hit_lim * Coef,
        frozen_resis = Attrs1#attrs.frozen_resis * Coef,
        frozen_resis_lim = Attrs1#attrs.frozen_resis_lim * Coef,
        trance_resis = Attrs1#attrs.trance_resis * Coef,
        trance_resis_lim = Attrs1#attrs.trance_resis_lim * Coef,
        chaos_resis = Attrs1#attrs.chaos_resis * Coef,
        chaos_resis_lim = Attrs1#attrs.chaos_resis_lim * Coef,
        seal_hit = round(Attrs1#attrs.seal_hit * Coef),
        seal_hit_rate = Attrs1#attrs.seal_hit_rate ,
        seal_resis = round(Attrs1#attrs.seal_resis * Coef),
        seal_resis_rate = Attrs1#attrs.seal_resis_rate  ,
        phy_combo_att_proba = Attrs1#attrs.phy_combo_att_proba ,
        mag_combo_att_proba = Attrs1#attrs.mag_combo_att_proba  ,
        strikeback_proba = Attrs1#attrs.strikeback_proba  ,
        pursue_att_proba = Attrs1#attrs.pursue_att_proba  ,
        do_phy_dam_scaling = Attrs1#attrs.do_phy_dam_scaling,
        do_mag_dam_scaling = Attrs1#attrs.do_mag_dam_scaling,
        crit_coef = Attrs1#attrs.crit_coef ,
        ret_dam_proba = Attrs1#attrs.ret_dam_proba ,
        ret_dam_coef = Attrs1#attrs.ret_dam_coef ,
        be_heal_eff_coef = Attrs1#attrs.be_heal_eff_coef ,
        be_phy_dam_reduce_coef = Attrs1#attrs.be_phy_dam_reduce_coef ,
        be_mag_dam_reduce_coef = Attrs1#attrs.be_mag_dam_reduce_coef ,
        be_phy_dam_shrink = round(Attrs1#attrs.be_phy_dam_shrink * Coef),
        be_mag_dam_shrink = round(Attrs1#attrs.be_mag_dam_shrink * Coef),
        pursue_att_dam_coef = Attrs1#attrs.pursue_att_dam_coef,
        absorb_hp_coef = Attrs1#attrs.absorb_hp_coef,
        phy_crit = round(Attrs1#attrs.phy_crit),
        phy_ten = round(Attrs1#attrs.phy_ten),
        mag_crit = round(Attrs1#attrs.mag_crit),
        mag_ten = round(Attrs1#attrs.mag_ten),
        phy_crit_coef = round(Attrs1#attrs.phy_crit_coef),
        mag_crit_coef = round(Attrs1#attrs.mag_crit_coef),
        heal_value = round(Attrs1#attrs.heal_value * Coef),
        qugui_coef = Attrs1#attrs.qugui_coef,

         % 新增属性
        be_chaos_att_team_paoba = Attrs1#attrs.be_chaos_att_team_paoba,
        be_chaos_att_team_phy_dam = Attrs1#attrs.be_chaos_att_team_phy_dam,
        neglect_seal_resis = Attrs1#attrs.neglect_seal_resis,
        seal_hit_to_partner = Attrs1#attrs.seal_hit_to_partner,
        seal_hit_to_mon = Attrs1#attrs.seal_hit_to_mon,
        phy_dam_to_partner = Attrs1#attrs.phy_dam_to_partner,
        phy_dam_to_mon = Attrs1#attrs.phy_dam_to_mon,
        mag_dam_to_partner = Attrs1#attrs.mag_dam_to_partner,
        mag_dam_to_mon = Attrs1#attrs.mag_dam_to_mon,
        be_chaos_round_repair = Attrs1#attrs.be_chaos_round_repair,
        chaos_round_repair = Attrs1#attrs.chaos_round_repair,
        be_froze_round_repair = Attrs1#attrs.be_froze_round_repair,
        froze_round_repair = Attrs1#attrs.froze_round_repair,
        neglect_phy_def = Attrs1#attrs.neglect_phy_def,
        neglect_mag_def = Attrs1#attrs.neglect_mag_def,

        phy_dam_to_speed_1 = Attrs1#attrs.phy_dam_to_speed_1,
        phy_dam_to_speed_2 = Attrs1#attrs.phy_dam_to_speed_2,
        mag_dam_to_speed_1 = Attrs1#attrs.mag_dam_to_speed_1,
        mag_dam_to_speed_2 = Attrs1#attrs.mag_dam_to_speed_2,
        seal_hit_to_speed = Attrs1#attrs.seal_hit_to_speed,

        revive_heal_coef = Attrs1#attrs.revive_heal_coef
                
        }.


%% 从attrs结构体提取非零的字段信息
%% @return：元素为{字段名, 字段值}的列表
extract_nonzero_fields_info(Attrs) ->
    ?ASSERT(is_record(Attrs, attrs)),
    AttrNameList = record_info(fields, attrs),
    F = fun(AttrName, AccInfoList) ->
            Index = get_field_index_in_attrs(AttrName),
            case element(Index, Attrs) of
                0 ->
                    AccInfoList;
                Value ->
                    [{AttrName, Value} | AccInfoList]
            end
        end,
    lists:foldl(F, [], AttrNameList).



%% 调整数值为整数，以通过协议发送给客户端
ajust_value_for_send_to_client(ObjInfoCode, Value) ->
    case ObjInfoCode of
        ?OI_CODE_CRIT_COEF -> erlang:round(Value * 100);
        ?OI_CODE_RET_DAM_COEF -> erlang:round(Value * 1000);
        ?OI_CODE_BE_HEAL_EFF_COEF -> erlang:round(Value * 100);
        ?OI_CODE_ABSORB_HP_COEF -> erlang:round(Value * 1000);
        ?OI_CODE_DO_PHY_DAM_SCALING ->  erlang:round(Value * 1000);
        ?OI_CODE_DO_MAG_DAM_SCALING ->  erlang:round(Value * 1000);
        ?OI_CODE_BE_PHY_DAM_REDUCE_COEF -> erlang:round(Value * 1000);
        ?OI_CODE_BE_MAG_DAM_REDUCE_COEF ->  erlang:round(Value * 1000);
        ?OI_CODE_PHY_CRIT_COEF ->  erlang:round(Value * 1000);
        ?OI_CODE_MAG_CRIT_COEF ->  erlang:round(Value * 1000);
        ?OI_CODE_PURSUE_ATT_PROBA -> erlang:round(Value * 1000);
        _ -> erlang:round(Value)  % 其他情况，值不变
    end.


%% 帮派技能属性计算
calc_guild_attrs(PS, Attrs) ->
    GuildAttrsL = player:get_guild_attrs(PS),

    F = fun({No, Lv}, AccAttrs) ->
        Data = data_guild_skill_config:get(No),

        AttrName = Data#guild_skill_config.skill_name,
        Value = Data#guild_skill_config.value,
        case AttrName of
            ?ATTR_HP_LIM ->
                AccAttrs#attrs{hp_lim = AccAttrs#attrs.hp_lim + (Value * Lv) };
            ?ATTR_MP_LIM ->
                AccAttrs#attrs{mp_lim = AccAttrs#attrs.mp_lim + (Value * Lv) };            
            _ ->
                AccAttrs
        end
    end,
    lists:foldl(F, Attrs, GuildAttrsL).

%% 帮派修炼属性计算
calc_cultivate_attrs(PS, Attrs) ->
    CultivateAttrsL = player:get_cultivate_attrs(PS),

    % ?DEBUG_MSG("CultivateAttrsL=~p",[CultivateAttrsL]),

    F = fun({No, Lv,_Point}, AccAttrs) -> 
        % ?DEBUG_MSG("No=~p,Lv=~p",[No,Lv]),

        if 
            Lv > 0 ->
                Data = data_guild_cultivate_learn_config:get(No),
                IncludeAttrs = Data#guild_cultivate_learn_cfg.include_attrs,

                Type = Data#guild_cultivate_learn_cfg.type,

                if 
                    Type == 1 ->

                        LvData = data_guild_cultivate_config:get(Lv),
                        F1 = fun(AttrName,AccAttrs_) ->
                            % ?DEBUG_MSG("AttrName=~p,",[AttrName]),
                            case AttrName of
                                ?ATTR_DO_PHY_DAM_SCALING        -> AccAttrs_#attrs{do_phy_dam_scaling=AccAttrs_#attrs.do_phy_dam_scaling + LvData#guild_cultivate_lv_cfg.do_phy_dam_scaling}; 
                                ?ATTR_DO_MAG_DAM_SCALING        -> AccAttrs_#attrs{do_mag_dam_scaling = AccAttrs_#attrs.do_mag_dam_scaling + LvData#guild_cultivate_lv_cfg.do_mag_dam_scaling}; 
                                ?ATTR_HEAL_VALUE                -> AccAttrs_#attrs{heal_value = util:ceil(AccAttrs_#attrs.heal_value + LvData#guild_cultivate_lv_cfg.heal_value)}; 
                                ?ATTR_SEAL_HIT                  -> AccAttrs_#attrs{seal_hit_rate = AccAttrs_#attrs.seal_hit_rate + LvData#guild_cultivate_lv_cfg.seal_hit}; 
                                ?ATTR_BE_PHY_DAM_REDUCE_COEF    -> AccAttrs_#attrs{be_phy_dam_reduce_coef = AccAttrs_#attrs.be_phy_dam_reduce_coef + LvData#guild_cultivate_lv_cfg.be_phy_dam_reduce_coef}; 
                                ?ATTR_BE_MAG_DAM_REDUCE_COEF    -> AccAttrs_#attrs{be_mag_dam_reduce_coef = AccAttrs_#attrs.be_mag_dam_reduce_coef + LvData#guild_cultivate_lv_cfg.be_mag_dam_reduce_coef}; 
                                ?ATTR_SEAL_RESIS                -> AccAttrs_#attrs{seal_resis_rate = AccAttrs_#attrs.seal_resis_rate + LvData#guild_cultivate_lv_cfg.seal_resis}; 
                                _ -> AccAttrs_
                            end
                        end,

                        lists:foldl(F1, AccAttrs, IncludeAttrs); 
                    true ->
                        AccAttrs
                end;
            true ->  AccAttrs
        end   
    end,
    lists:foldl(F, Attrs, CultivateAttrsL).

%%装备套装属性计算
calc_equip_suit_attrs(PS, Attrs) ->
    case player:get_suit_no(PS) of
        ?INVALID_NO -> Attrs;
        StrenLv ->
            % ?DEBUG_MSG("lib_attribute:calc_equip_suit_attrs:StrenLv:~p~n", [StrenLv]),
            case data_equip_suit:get(StrenLv) of
                null ->
                    Attrs;
                Data ->
                    AllNameList = record_info(fields, equip_suit),
                    [_H | T] = AllNameList,
                    [_ | AddAttrsNameL] = T,

                    F = fun(AttrsName, AccAttrs) ->
                        case AttrsName of
                            ?ATTR_HP_LIM_RATE ->
                                AccAttrs#attrs{hp_lim_rate =  AccAttrs#attrs.hp_lim_rate + Data#equip_suit.hp_lim_rate};
                            ?ATTR_MP_LIM_RATE ->
                                AccAttrs#attrs{mp_lim_rate =  AccAttrs#attrs.mp_lim_rate + Data#equip_suit.mp_lim_rate};
                            ?ATTR_PHY_ATT_RATE ->
                                AccAttrs#attrs{phy_att_rate =  AccAttrs#attrs.phy_att_rate + Data#equip_suit.phy_att_rate};
                            ?ATTR_MAG_ATT_RATE ->
                                AccAttrs#attrs{mag_att_rate =  AccAttrs#attrs.mag_att_rate + Data#equip_suit.mag_att_rate};
                            ?ATTR_PHY_DEF_RATE ->
                                AccAttrs#attrs{phy_def_rate =  AccAttrs#attrs.phy_def_rate + Data#equip_suit.phy_def_rate};
                            ?ATTR_MAG_DEF_RATE ->
                                AccAttrs#attrs{mag_def_rate =  AccAttrs#attrs.mag_def_rate + Data#equip_suit.mag_def_rate};
                            _ -> AccAttrs
                        end
                    end,
                    lists:foldl(F, Attrs, AddAttrsNameL)
            end
    end.


%% ================================== Local Functions ===================================

% 天赋属性
sum_two_talents(Talents1, Talents2) ->
    #talents{
        str = Talents1#talents.str + Talents2#talents.str,
        con = Talents1#talents.con + Talents2#talents.con,
        sta = Talents1#talents.sta + Talents2#talents.sta,
        spi = Talents1#talents.spi + Talents2#talents.spi,
        agi = Talents1#talents.agi + Talents2#talents.agi
        }.


%% 属性加成, Bonus为{属性类型名, 增加值, 增加率}的列表 | {属性类型名, 增加值} 列表
attr_bonus(Attrs, Bonus) ->
    attr_bonus(Attrs, Bonus, Attrs).

attr_bonus(Attrs, Bonus, BaseAttr) -> % 做乘法时, 以BaseAttr为基础进行
    F = fun(Para, AccAttrs) ->
        case Para of
            {Item, Value, Rate} ->
                Index = get_field_index_in_attrs(Item),
                VBase = element(Index, BaseAttr),
                V0 = element(Index, AccAttrs),
                V1 = fix_type(Item, V0 + VBase * Rate + Value),
                ?DEBUG_MSG("------------------------V1---------------------~p~n", [V1]),
                setelement(Index, AccAttrs, V1);
            {Item, Value} ->
                Index = get_field_index_in_attrs(Item),
                V0 = erlang:element(Index, AccAttrs),
                V1 = fix_type(Item, V0 + Value),
                erlang:setelement(Index, AccAttrs, V1);
            _Any ->
                ?ASSERT(false, _Any),
                AccAttrs
        end
    end,
    lists:foldl(F, Attrs, Bonus).


%% 如果字段增加，需要做相应的调整
calc_rate_attrs(BaseAttrs, AddAttrs) ->
    BaseAttrs#attrs{
                        hp_lim = util:ceil(BaseAttrs#attrs.hp_lim * (1 + AddAttrs#attrs.hp_lim_rate)),
                        mp_lim = util:ceil(BaseAttrs#attrs.mp_lim * (1 + AddAttrs#attrs.mp_lim_rate)),

                        phy_att = util:ceil(BaseAttrs#attrs.phy_att * (1 + AddAttrs#attrs.phy_att_rate)),
                        mag_att = util:ceil(BaseAttrs#attrs.mag_att * (1 + AddAttrs#attrs.mag_att_rate)),
                        phy_def = util:ceil(BaseAttrs#attrs.phy_def * (1 + AddAttrs#attrs.phy_def_rate)),
                        mag_def = util:ceil(BaseAttrs#attrs.mag_def * (1 + AddAttrs#attrs.mag_def_rate)),

                        hit = util:ceil(BaseAttrs#attrs.hit * (1 + AddAttrs#attrs.hit_rate)),
                        dodge = util:ceil(BaseAttrs#attrs.dodge * (1 + AddAttrs#attrs.dodge_rate)),
                        crit = util:ceil(BaseAttrs#attrs.crit * (1 + AddAttrs#attrs.crit_rate)),
                        ten = util:ceil(BaseAttrs#attrs.ten * (1 + AddAttrs#attrs.ten_rate)),

                        act_speed = util:ceil(BaseAttrs#attrs.act_speed * (1 + AddAttrs#attrs.act_speed_rate)),
                        seal_hit = util:ceil(BaseAttrs#attrs.seal_hit * (1 + AddAttrs#attrs.seal_hit_rate)),
                        seal_resis = util:ceil(BaseAttrs#attrs.seal_resis * (1 + AddAttrs#attrs.seal_resis_rate))
                        }.



calc_passi_eff_attrs(PS, Attrs) ->
    SkillList = ply_skill:get_passive_skill_list(player:id(PS)),
    Lv = player:get_lv(PS),
    F = fun(Skill, AccAttrs) ->
        SklCfg = mod_skill:get_cfg_data(Skill#skl_brief.id),
        PassiEffNoList = mod_skill:get_passive_effs(SklCfg),
        lib_passi_eff:calc_passi_eff(AccAttrs, Lv, PassiEffNoList)
    end,
    lists:foldl(F, Attrs, SkillList).



fix_type(?ATTR_HP, X) -> round(X);                     % 气血
fix_type(?ATTR_HP_LIM, X) -> round(X);                 % 气血上限

fix_type(?ATTR_MP, X) -> round(X);                     % 魔法
fix_type(?ATTR_MP_LIM, X) -> round(X);                 % 魔法上限

fix_type(?ATTR_PHY_ATT, X) -> round(X);                % 物理攻击

fix_type(?ATTR_MAG_ATT, X) -> round(X);                % 法术攻击

fix_type(?ATTR_PHY_DEF, X) -> round(X);                % 物理防御

fix_type(?ATTR_MAG_DEF, X) -> round(X);                % 法术防御

fix_type(?ATTR_HIT, X) -> round(X);                    % 命中

fix_type(?ATTR_DODGE, X) -> round(X);                  % 闪避

fix_type(?ATTR_CRIT, X) -> round(X);                   % 暴击
fix_type(?ATTR_TEN, X) -> round(X);                    % 坚韧（抗暴击）

fix_type(?ATTR_PHY_CRIT, X) -> round(X);                   % 暴击
fix_type(?ATTR_MAG_CRIT, X) -> round(X);                   % 暴击
fix_type(?ATTR_PHY_TEN, X) -> round(X);                    % 暴击
fix_type(?ATTR_MAG_TEN, X) -> round(X);                    % 暴击
fix_type(?ATTR_PHY_CRIT_COEF, X) -> round(X);                   % 暴击
fix_type(?ATTR_MAG_CRIT_COEF, X) -> round(X);                   % 暴击

fix_type(?ATTR_HEAL_VALUE, X) -> round(X);             % 治疗强度

fix_type(?ATTR_TALENT_STR, X) -> round(X);             % 天赋：力量（strength）
fix_type(?ATTR_TALENT_CON, X) -> round(X);             % 天赋：体质（constitution）
fix_type(?ATTR_TALENT_STA, X) -> round(X);             % 天赋：耐力（stamina）
fix_type(?ATTR_TALENT_SPI, X) -> round(X);             % 天赋：灵力（spirit）
fix_type(?ATTR_TALENT_AGI, X) -> round(X);             % 天赋：敏捷（agility）

fix_type(?ATTR_ANGER, X) -> round(X);                  % 怒气
fix_type(?ATTR_ANGER_LIM, X) -> round(X);              % 怒气上限

fix_type(?ATTR_ACT_SPEED, X) -> round(X);              % 出手速度

fix_type(?ATTR_LUCK, X) -> round(X);                   % 幸运
fix_type(?ATTR_NEGLECT_RET_DAM, X) -> round(X);                   % 忽视反震
fix_type(?ATTR_FROZEN_HIT, X) -> round(X);             % 冰封命中
fix_type(?ATTR_FROZEN_HIT_LIM, X) -> round(X);         % 冰封命中上限

fix_type(?ATTR_TRANCE_HIT, X) -> round(X);             % 昏睡命中
fix_type(?ATTR_TRANCE_HIT_LIM, X) -> round(X);         % 昏睡命中上限

fix_type(?ATTR_CHAOS_HIT, X) -> round(X);              % 混乱命中
fix_type(?ATTR_CHAOS_HIT_LIM, X) -> round(X);          % 混乱命中上限

fix_type(?ATTR_FROZEN_RESIS, X) -> round(X);           % 冰封抗性
fix_type(?ATTR_FROZEN_RESIS_LIM, X) -> round(X);       % 冰封抗性上限

fix_type(?ATTR_TRANCE_RESIS, X) -> round(X);           % 昏睡抗性
fix_type(?ATTR_TRANCE_RESIS_LIM, X) -> round(X);       % 昏睡抗性上限

fix_type(?ATTR_CHAOS_RESIS, X) -> round(X);            % 混乱抗性
fix_type(?ATTR_CHAOS_RESIS_LIM, X) -> round(X);        % 混乱抗性上限

fix_type(?ATTR_SEAL_HIT, X) -> round(X);               % 封印命中（同时影响冰封命中、昏睡命中和混乱命中）
fix_type(?ATTR_SEAL_RESIS, X) -> round(X);             % 封印抗性（同时影响冰封抗性、昏睡抗性和混乱抗性）

fix_type(?ATTR_PHY_COMBO_ATT_PROBA, X) -> round(X);    % 物理连击概率（是一个放大1000倍的整数）
fix_type(?ATTR_MAG_COMBO_ATT_PROBA, X) -> round(X);    % 法术连击概率（是一个放大1000倍的整数）
fix_type(?ATTR_STRIKEBACK_PROBA, X) -> round(X);       % 反击概率（是一个放大1000倍的整数）
fix_type(?ATTR_PURSUE_ATT_PROBA, X) -> round(X);       % 追击概率（是一个放大1000倍的整数）

% fix_type(do_phy_dam_scaling, X) -> round(X);     % 物理伤害放缩系数
% fix_type(do_mag_dam_scaling, X) -> round(X);     % 法术伤害放缩系数

% fix_type(crit_coef, X) -> round(X);              % 暴击系数

fix_type(?ATTR_RET_DAM_PROBA, X) -> round(X);          % 反震（即反弹）概率（是一个放大1000倍的整数）
% fix_type(ret_dam_coef, X) -> round(X);           % 反震（即反弹）系数

% fix_type(be_heal_eff_coef, X) -> round(X);       % 被治疗效果系数

% fix_type(be_phy_dam_reduce_coef, X) -> round(X); % 物理伤害减免系数
% fix_type(be_mag_dam_reduce_coef, X) -> round(X); % 法术伤害减免系数

fix_type(?ATTR_BE_PHY_DAM_SHRINK, X) -> round(X);      % （受）物理伤害缩小值（整数）
fix_type(?ATTR_BE_MAG_DAM_SHRINK, X) -> round(X);      % （受）法术伤害缩小值（整数）

fix_type(?ATTR_BE_CHAOS_ATT_TEAM_PAOBA,X) -> round(X);                  % 放大10000倍的整数
fix_type(?ATTR_BE_CHAOS_ATT_TEAM_PHY_DAM,X) -> round(X);                % 放大10000倍的整数
fix_type(?ATTR_NEGLECT_SEAL_RESIS,X) -> round(X);                       % 放大10000倍的整数
fix_type(?ATTR_SEAL_HIT_TO_PARTNER,X) -> round(X);                      % 放大10000倍的整数
fix_type(?ATTR_SEAL_HIT_TO_MON,X) -> round(X);                          % 放大10000倍的整数
fix_type(?ATTR_PHY_DAM_TO_PARTNER,X) -> round(X);                       % 放大10000倍的整数
fix_type(?ATTR_PHY_DAM_TO_MON,X) -> round(X);                           % 放大10000倍的整数
fix_type(?ATTR_MAG_DAM_TO_PARTNER,X) -> round(X);                       % 放大10000倍的整数
fix_type(?ATTR_MAG_DAM_TO_MON,X) -> round(X);                           % 放大10000倍的整数
fix_type(?ATTR_BE_CHAOS_ROUND_REPAIR,X) -> round(X);                    % 放大10000倍的整数
fix_type(?ATTR_CHAOS_ROUND_REPAIR,X) -> round(X);                       % 放大10000倍的整数
fix_type(?ATTR_BE_FROZE_ROUND_REPAIR,X) -> round(X);                    % 放大10000倍的整数
fix_type(?ATTR_FROZE_ROUND_REPAIR,X) -> round(X);                       % 放大10000倍的整数
fix_type(?ATTR_NEGLECT_PHY_DEF,X) -> round(X);                          % 放大10000倍的整数
fix_type(?ATTR_NEGLECT_MAG_DEF,X) -> round(X);                          % 放大10000倍的整数
fix_type(?ATTR_PHY_DAM_TO_SPEED_1,X) -> round(X);                       % 放大10000倍的整数
fix_type(?ATTR_PHY_DAM_TO_SPEED_2,X) -> round(X);                       % 放大10000倍的整数
fix_type(?ATTR_MAG_DAM_TO_SPEED_1,X) -> round(X);                       % 放大10000倍的整数
fix_type(?ATTR_MAG_DAM_TO_SPEED_2,X) -> round(X);                       % 放大10000倍的整数
fix_type(?ATTR_SEAL_HIT_TO_SPEED,X) -> round(X);                        % 放大10000倍的整数

fix_type(?ATTR_REVIVE_HEAL_COEF,X) -> round(X);                           % 放大10000倍的整数

% fix_type(absorb_hp_coef, X) -> round(X);         % 吸血系数

% fix_type(qugui_coef, X) -> round(X);             % 驱鬼系数

fix_type(_, X) -> X.