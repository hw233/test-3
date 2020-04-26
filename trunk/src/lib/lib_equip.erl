%%%--------------------------------------
%%% @Module  : lib_equip
%%% @Author  : huangjf, 
%%% @Email   : 
%%% @Created : 2013.7.6
%%% @Description : 装备的相关函数
%%%--------------------------------------
-module(lib_equip).

-export([
        decide_quality/1,
        decide_base_equip_add/2,
        recount_base_equip_add/3,
        decide_addi_equip_add/3,
        decide_addi_equip_add_by_count/3,
        decide_addi_attr_count/1,
        init_gem_inlay/0,
        get_attr_name_and_base_list/1,
        recount_addi_equip_add/2,

        decide_refine_Lv/3,
        recount_addi_value/3,       % 重算附加属性值
        adjust_eq_addi_attr/2,      % 由于规则或者数值调整，调整线上数据

        calc_battle_power/1,
        recount_battle_power/1,

        change_equip_stren_attr/1, % 在强化等级1级以上，计算强化属性
        change_equip_stren_attr/2, % 在强化等级1级以上，计算强化属性
        calc_one_gem_attrs/3,
        calc_one_gem_attrs/4,
        get_field_index_in_equip_added1/1,

        equip_prop_name_to_obj_info_code/1,
        get_lv_step_for_strenthen/2,
        get_free_stren_cnt/1,
        cost_free_stren_cnt/2,
        reset_free_stren_cnt/1,
        make_random_attr/1,         % 创建随机附加属性
        make_random_eff/1,           % 创建随机特效
        make_random_stunt/1,           % 创建随机特技
        make_addi_random_attr/2,         % 创建随机附加属性
        get_addi_random_attr_name_and_value/2,
        make_new_random_eff/1,          % 创建随机特效
        make_new_random_eff/3,          % 创建随机特效
        make_new_random_stunt/1,        % 创建随机特技
        make_new_random_stunt/3,         % 创建随机特技
        get_new_make_equip_added_stunt_no/3,
        get_new_make_equip_added_effect_no/3
    ]).


-include("common.hrl").
-include("record.hrl").
-include("goods.hrl").
-include("record/goods_record.hrl").
-include("attribute.hrl").
-include("equip.hrl").
-include("obj_info_code.hrl").
-include("pt_12.hrl").
-include("skill.hrl").


%% 装备的附加属性加成列表
-define(EQUIP_BASE_ADDI_ATTR_LIST,[?ATTR_TALENT_STR,?ATTR_TALENT_CON,?ATTR_TALENT_STA,?ATTR_TALENT_SPI,?ATTR_TALENT_AGI]).
-define(EQUIP_ADD_ADDI_ATTR_LIST, [
    ?ATTR_TALENT_STR, 
    ?ATTR_TALENT_AGI, 
    ?ATTR_TALENT_STA, 
    ?ATTR_TALENT_CON, 
    ?ATTR_TALENT_SPI,
    ?ATTR_NEGLECT_SEAL_RESIS,
    ?ATTR_SEAL_HIT_TO_PARTNER,
    ?ATTR_SEAL_HIT_TO_MON,
    ?ATTR_PHY_DAM_TO_PARTNER,
    ?ATTR_PHY_DAM_TO_MON,
    ?ATTR_MAG_DAM_TO_PARTNER,
    ?ATTR_MAG_DAM_TO_MON,
    ?ATTR_BE_CHAOS_ROUND_REPAIR,
    ?ATTR_CHAOS_ROUND_REPAIR,
    ?ATTR_BE_FROZE_ROUND_REPAIR,
    ?ATTR_FROZE_ROUND_REPAIR,
    ?ATTR_NEGLECT_PHY_DEF,
    ?ATTR_NEGLECT_MAG_DEF,
    ?ATTR_PHY_DAM_TO_SPEED_1,
    ?ATTR_PHY_DAM_TO_SPEED_2,
    ?ATTR_MAG_DAM_TO_SPEED_1,
    ?ATTR_MAG_DAM_TO_SPEED_2,
    ?ATTR_SEAL_HIT_TO_SPEED,
    ?ATTR_PHY_CRIT,
    ?ATTR_PHY_TEN,
    ?ATTR_MAG_CRIT,
    ?ATTR_MAG_TEN,
    ?ATTR_PHY_CRIT_COEF,
    ?ATTR_MAG_CRIT_COEF,
    ?ATTR_HEAL_VALUE,
    ?ATTR_REVIVE_HEAL_COEF,
	
	?ATTR_HP_LIM,
    ?ATTR_MP_LIM,
    ?ATTR_PHY_ATT,
    ?ATTR_MAG_ATT,
    ?ATTR_PHY_DEF,
    ?ATTR_MAG_DEF,
    ?ATTR_ACT_SPEED,
    ?ATTR_SEAL_HIT,
    ?ATTR_SEAL_RESIS,
    ?ATTR_DO_PHY_DAM_SCALING,
    ?ATTR_DO_MAG_DAM_SCALING,
    ?ATTR_BE_PHY_DAM_REDUCE_COEF,
    ?ATTR_BE_MAG_DAM_REDUCE_COEF
    ]).

get_quality_proba(LvStep) ->
    data_equip_quality_proba:get(LvStep).



%% 依据概率，判定新装备的品质
decide_quality(EquipLv) ->
    LvStep = calc_lv_step(EquipLv),
    case get_quality_proba(LvStep) of
        null ->
            ?ASSERT(false, EquipLv),
            ?QUALITY_MIN;      % 容错，返回最低品质
        EqpQualityProba ->
            ?ASSERT(dbg_is_valid_eqp_quality_proba_rd(EqpQualityProba), LvStep),
            [_RecordName | QualityProbaList] = tuple_to_list(EqpQualityProba),
            RandNum = util:rand(1, ?PROBABILITY_BASE),
            decide_quality__(QualityProbaList, RandNum)
    end.

%% 获取装备附加属性加成的 属性名称 和 基数
%% return {attrName, Base}
get_attr_name_and_base(GoodsNo) ->
    case data_equip_added:get(GoodsNo) of
        null -> 
            {null, 0};
        AddedEquipAdd ->
            Range = calc_prob_range_in_fields_info(AddedEquipAdd),
            ?TRACE("lib_equip:get_attr_name_and_base() RandRange:~p~n", [Range]),
            ?ASSERT(Range >= 1, Range),
            RandNum = util:rand(1, Range),
            decide_attr_name_and_base(AddedEquipAdd, RandNum)
    end.


%% 依据概率， 判定新装备的基本属性加成
%% 返回值格式：[] | [{属性名，属性加成的值}, ...]
decide_base_equip_add(GoodsTpl, Quality) ->
    EquipLv = GoodsTpl#goods_tpl.lv,
    _EquipRace = GoodsTpl#goods_tpl.race,

    AttrNameAndBaseList = get_attr_name_and_base_list(GoodsTpl),
    ?ASSERT(is_list(AttrNameAndBaseList), {EquipLv, _EquipRace}),
    F = fun({AttrName, AttrBase}) ->
            BaseQualityCoef = decide_base_quality_coef(EquipLv, Quality), %% 每一条属性都会从品质段中抽取数值系数
            RealValue = util:ceil(BaseQualityCoef * AttrBase),  % 系数 * 基础属性加成基数， 勿忘对结果取整！
            ?ASSERT(RealValue >= 1),
            {AttrName, RealValue}  
        end,
    [F(X) || X <- AttrNameAndBaseList].


recount_base_equip_add(Goods, GoodsTpl, Quality) when is_record(Goods, goods) ->
    EquipLv = GoodsTpl#goods_tpl.lv,
    _EquipRace = GoodsTpl#goods_tpl.race,

    BaseEquipAdd = lib_goods:get_show_base_equip_add(Goods),
    AttrNameAndBaseList = get_attr_name_and_base_list(GoodsTpl, BaseEquipAdd),
    ?ASSERT(is_list(BaseEquipAdd), _EquipRace),
    F = fun({AttrName, AttrBase}) ->
        BaseQualityCoef = decide_base_quality_coef(EquipLv, Quality), %% 每一条属性都会从品质段中抽取数值系数
        RealValue = util:ceil(BaseQualityCoef * AttrBase),  % 系数 * 基础属性加成基数， 勿忘对结果取整！
        ?ASSERT(RealValue >= 1),
        {AttrName, RealValue}
        end,
    [F(X) || X <- AttrNameAndBaseList];


recount_base_equip_add(GoodsTpl, Quality, EquipLv) ->
    AttrNameAndBaseList = get_attr_name_and_base_list(GoodsTpl),
    ?ASSERT(is_list(AttrNameAndBaseList), EquipLv),
    F = fun({AttrName, AttrBase}) ->
        BaseQualityCoef = decide_base_quality_coef(EquipLv, Quality), %% 每一条属性都会从品质段中抽取数值系数
        RealValue = util:ceil(BaseQualityCoef * AttrBase),  % 系数 * 基础属性加成基数， 勿忘对结果取整！
        ?ASSERT(RealValue >= 1),
        {AttrName, RealValue}
        end,
    [F(X) || X <- AttrNameAndBaseList].





%% 依据概率，判定新装备的附加属性加成
%% 返回值格式：[] | [{属性名，属性加成的值}, ...]
decide_addi_equip_add(GoodsNo, Quality, _EquipLv) ->
    case lib_goods:get_tpl_data(GoodsNo) of
        null -> [];
        GoodsTpl ->
            case lib_goods:get_type(GoodsTpl) =:= ?GOODS_T_PAR_EQUIP of
                true -> []; %% 宠物装备没有附加属性
                false -> [] % 暂时屏蔽附加属性
                    % AddiAttrCount = decide_addi_attr_count(Quality),
                    % decide_addi_equip_add(GoodsNo, Quality, AddiAttrCount, [], 0)
            end
    end.

%% 返回值格式：[] | [{Index, 属性名，属性加成的值, 精炼等级}, ...]
decide_addi_equip_add_by_count(GoodsNo, Quality, AddiAttrCount) ->
    decide_addi_equip_add(GoodsNo, Quality, AddiAttrCount, [], 0).


decide_addi_equip_add(_GoodsNo, _Quality, AddiAttrCount, AttrValueList, TryTimes) when length(AttrValueList) >= AddiAttrCount orelse TryTimes >= 50 ->
    AttrValueList;
decide_addi_equip_add(GoodsNo, Quality, AddiAttrCount, AttrValueList, TryTimes) ->
    case get_attr_name_and_base(GoodsNo) of
        {null, 0} -> % 某些装备没有附加属性
            AttrValueList;
        {AttrName, Base} -> 
            % ConType = get_constant_type_by_attr_name(AttrName),
            % EquipAddedCon = data_equip_added_con:get(ConType),
           
            % AddValueLv = get_equip_add_lv(),
            % RealValue = util:ceil( Base * (1 + ((AddValueLv - 100) / 100) * EquipAddedCon#equip_added_con.up_lv_coef) ),
            % ?DEBUG_MSG("lib_equip:decide_addi_equip_add() GoodsNo:~p, RealValue:~p AddValueLv:~p up_lv_coef:~p ~n", [GoodsNo, RealValue, AddValueLv, EquipAddedCon#equip_added_con.up_lv_coef]),
            % ?ASSERT(RealValue > 0, RealValue),
            RefineLv = decide_addi_refine_lv(GoodsNo),
            RealValue = calc_addi_value(AttrName, Base, RefineLv),
            ?DEBUG_MSG("lib_equip:decide_addi_equip_add() GoodsNo:~p, RealValue:~p, RefineLv:~p ~n", [GoodsNo, RealValue, RefineLv]),
            Index = length(AttrValueList) + 1,
            AttrValueList1 = [{Index, AttrName, RealValue, RefineLv} | AttrValueList],
            decide_addi_equip_add(GoodsNo, Quality, AddiAttrCount, AttrValueList1, TryTimes + 1)
    end.


%% 依据概率，判定新装备所具有的附加属性加成的个数
decide_addi_attr_count(Quality) ->
    case data_equip_addi_attr_count_proba:get(Quality) of
        null ->
            ?ASSERT(false, Quality),
            0;   % 容错，返回0
        AddiAttrCountProba ->
            ?ASSERT(dbg_is_valid_eqp_addi_attr_count_proba_rd(AddiAttrCountProba), Quality),
            [_RecordName | QualityProbaList] = tuple_to_list(AddiAttrCountProba),
            RandNum = util:rand(1, ?PROBABILITY_BASE),
            ProbaList = QualityProbaList -- [erlang:hd(QualityProbaList)],
            decide_addi_attr_count__(ProbaList, RandNum)
    end.


% decide_addi_attr_name_list(AddiAttrCount) ->
%     tool:shuffle(?EQUIP_ADD_ADDI_ATTR_LIST, AddiAttrCount).




%% 依据概率，判定新装备的基本属性加成的品质系数(数值系数)
decide_base_quality_coef(EquipLv, Quality) ->
    LvStep = calc_lv_step(EquipLv),

    QualityCoef = data_equip_base_quality_coef:get(LvStep),

    {Min, Max} = case Quality of
        ?QUALITY_WHITE ->
            {QualityCoef#eqp_base_quality_coef.white_min, QualityCoef#eqp_base_quality_coef.white_max};
        ?QUALITY_GREEN ->
            {QualityCoef#eqp_base_quality_coef.green_min, QualityCoef#eqp_base_quality_coef.green_max};
        ?QUALITY_BLUE ->
            {QualityCoef#eqp_base_quality_coef.blue_min, QualityCoef#eqp_base_quality_coef.blue_max};
        ?QUALITY_PURPLE ->
            {QualityCoef#eqp_base_quality_coef.purple_min, QualityCoef#eqp_base_quality_coef.purple_max};
        ?QUALITY_ORANGE ->
            {QualityCoef#eqp_base_quality_coef.orange_min, QualityCoef#eqp_base_quality_coef.orange_max};
        ?QUALITY_RED ->
            {QualityCoef#eqp_base_quality_coef.red_min, QualityCoef#eqp_base_quality_coef.red_max}

    end,

    %% 这里的策划需求是在最小与最大的之间随机一个数作为系数
    Diff = util:ceil( (Max - Min) * 100 ),  % 放大100倍
    Rand = util:rand(1, 100),
    Floating = ((Rand * Diff) div 100) / 100,  % 浮动值
    Min + Floating.
     




% %% 按策划给的公式计算新装备的附加属性加成的品质系数
% calc_addi_quality_coef() ->
%     Pow = (util:rand(1, 100) / 100) - 0.01,
%     math:pow(0.1, Pow).


init_gem_inlay() ->
    HoleCount = decide_equip_hole_count(data_equip_hole:get_all_no_list(), util:rand(1, 100)),
    F = fun(X, Acc) ->
        [{X, 0} | Acc]
    end,
    lists:foldl(F, [], lists:seq(1, HoleCount)).


    
%% 装备自身的属性名转为对应的对象信息代号（atom -> integer），用于打包协议（和客户端通信）
equip_prop_name_to_obj_info_code(EquipPropName) ->
    case EquipPropName of
        ?EQP_PROP_STREN_LV ->    ?OI_CODE_STREN_LV;
        ?EQP_PROP_STREN_EXP ->   ?OI_CODE_STREN_EXP
    end.            


% 计算装备战斗力
calc_battle_power(Goods) ->
    Coef = data_formula:get(equip_cal_battle_power),
    
    AttrsList1 = lib_goods:get_base_equip_add(Goods),
    AttrsList2 = lib_goods:get_addi_equip_add(Goods),
    AttrsList3 = lib_goods:get_stren_equip_add(Goods),
    AddiEquipEffNo = Goods#goods.addi_equip_eff,

    TransmoEffNo = lib_goods:get_transmo_eff_no(Goods),

    AttrsList4 = case TransmoEffNo of
        0 ->
            case AddiEquipEffNo of
                0 ->
                    #attrs{};
                null ->
                    #attrs{};
                _ ->
                    lib_attribute:to_addi_equip_eff(AddiEquipEffNo)
            end;
        _ ->
            case AddiEquipEffNo of
                0 ->
                    lib_attribute:to_addi_equip_eff(TransmoEffNo);
                null ->
                    lib_attribute:to_addi_equip_eff(TransmoEffNo);
                _ ->
                    EquipEffCfg = data_equip_speci_effect:get(AddiEquipEffNo),
                    EquipEffName = EquipEffCfg#equip_speci_effect_tpl.eff_name,
                    Value1 = EquipEffCfg#equip_speci_effect_tpl.value,

                    TransmoEffCfg = data_equip_speci_effect:get(TransmoEffNo),
                    TransmoEffName = TransmoEffCfg#equip_speci_effect_tpl.eff_name,
                    Value2 = TransmoEffCfg#equip_speci_effect_tpl.value,
                    case EquipEffName =:= TransmoEffName of
                        true ->
                            if
                                Value1 > Value2 ->
                                    lib_attribute:to_addi_equip_eff(AddiEquipEffNo);
                                Value1 < Value2 ->
                                    lib_attribute:to_addi_equip_eff(TransmoEffNo);
                                true ->
                                    lib_attribute:to_addi_equip_eff(TransmoEffNo)
                            end;
                        false ->
                            Attr1 = lib_attribute:to_addi_equip_eff(AddiEquipEffNo),
                            Attr2 = lib_attribute:to_addi_equip_eff(TransmoEffNo),
                            lib_attribute:sum_two_attrs(Attr1, Attr2)

                    end
            end
    end,

%%    AttrsList4 = case AddiEquipEffNo of
%%        0 -> #attrs{};
%%        null -> #attrs{};
%%        _ ->
%%            lib_attribute:to_addi_equip_eff(AddiEquipEffNo)
%%    end,

    %% 幻化附加属性

    AttrsList5 =
        case lib_goods:get_transmo_ref_attr(Goods) of
            null ->
                #attrs{};
            Attr ->
                lib_attribute:to_addi_equip_add_attrs_record(Attr)
        end,

    % ?DEBUG_MSG("AttrsList1~p,AttrsList2~p,AttrsList3~p,AttrsList4~p",[AttrsList1,AttrsList2,AttrsList3,AttrsList4]),
    AttrsList = [AttrsList1] ++ [AttrsList2] ++ [AttrsList3] ++ [AttrsList4] ++ [AttrsList5],
    Attrs = lib_attribute:sum_attrs(AttrsList),

    BattlePower = 
    Coef#formula.hp_lim * Attrs#attrs.hp_lim +
    Coef#formula.mp_lim * Attrs#attrs.mp_lim +
    Coef#formula.phy_att * Attrs#attrs.phy_att +
    Coef#formula.mag_att * Attrs#attrs.mag_att +
    Coef#formula.phy_def * Attrs#attrs.phy_def +
    Coef#formula.mag_def * Attrs#attrs.mag_def +
    Coef#formula.talent_str * Attrs#attrs.talent_str +
    Coef#formula.talent_con * Attrs#attrs.talent_con +
    Coef#formula.talent_sta * Attrs#attrs.talent_sta +
    Coef#formula.talent_spi * Attrs#attrs.talent_spi +
    Coef#formula.talent_agi * Attrs#attrs.talent_agi +
    Coef#formula.act_speed * Attrs#attrs.act_speed +
    Coef#formula.seal_hit * Attrs#attrs.seal_hit +
    Coef#formula.seal_resis * Attrs#attrs.seal_resis +
    Coef#formula.do_phy_dam_scaling * Attrs#attrs.do_phy_dam_scaling +
    Coef#formula.do_mag_dam_scaling * Attrs#attrs.do_mag_dam_scaling +
    Coef#formula.be_heal_eff_coef * Attrs#attrs.be_heal_eff_coef +
    Coef#formula.be_phy_dam_reduce_coef * Attrs#attrs.be_phy_dam_reduce_coef +
    Coef#formula.be_mag_dam_reduce_coef * Attrs#attrs.be_mag_dam_reduce_coef +
    Coef#formula.be_phy_dam_shrink * Attrs#attrs.be_phy_dam_shrink +
    Coef#formula.be_mag_dam_shrink * Attrs#attrs.be_mag_dam_shrink +
    Coef#formula.phy_crit * Attrs#attrs.phy_crit +
    Coef#formula.phy_ten * Attrs#attrs.phy_ten +
    Coef#formula.mag_crit * Attrs#attrs.mag_crit +
    Coef#formula.mag_ten * Attrs#attrs.mag_ten +
    Coef#formula.phy_crit_coef * Attrs#attrs.phy_crit_coef +
    Coef#formula.mag_crit_coef * Attrs#attrs.mag_crit_coef +
    Coef#formula.heal_value * Attrs#attrs.heal_value +
    Coef#formula.be_chaos_att_team_paoba * Attrs#attrs.be_chaos_att_team_paoba +
    Coef#formula.be_chaos_att_team_phy_dam * Attrs#attrs.be_chaos_att_team_phy_dam +
    Coef#formula.seal_hit_to_partner * Attrs#attrs.seal_hit_to_partner +
    Coef#formula.seal_hit_to_mon * Attrs#attrs.seal_hit_to_mon +
    Coef#formula.phy_dam_to_partner * Attrs#attrs.phy_dam_to_partner +
    Coef#formula.phy_dam_to_mon * Attrs#attrs.phy_dam_to_mon +
    Coef#formula.mag_dam_to_partner * Attrs#attrs.mag_dam_to_partner +
    Coef#formula.mag_dam_to_mon * Attrs#attrs.mag_dam_to_mon +
    Coef#formula.be_chaos_round_repair * Attrs#attrs.be_chaos_round_repair +
    Coef#formula.chaos_round_repair * Attrs#attrs.chaos_round_repair +
    Coef#formula.be_froze_round_repair * Attrs#attrs.be_froze_round_repair +
    Coef#formula.froze_round_repair * Attrs#attrs.froze_round_repair +
    Coef#formula.neglect_phy_def * Attrs#attrs.neglect_phy_def +
    Coef#formula.neglect_mag_def * Attrs#attrs.neglect_mag_def +
    Coef#formula.neglect_seal_resis * Attrs#attrs.neglect_seal_resis +
    Coef#formula.phy_dam_to_speed_1 * Attrs#attrs.phy_dam_to_speed_1 +
    Coef#formula.phy_dam_to_speed_2 * Attrs#attrs.phy_dam_to_speed_2 +
    Coef#formula.mag_dam_to_speed_1 * Attrs#attrs.mag_dam_to_speed_1 +
    Coef#formula.mag_dam_to_speed_2 * Attrs#attrs.mag_dam_to_speed_2 +
    Coef#formula.seal_hit_to_speed * Attrs#attrs.seal_hit_to_speed ,

    erlang:max(util:ceil(BattlePower),0).


%% 重算战斗力
recount_battle_power(Goods) ->
    BattlePower = calc_battle_power(Goods),
    % lib_inv:notify_cli_goods_info_change(Goods#goods.player_id, Goods),
    BattlePower.

change_equip_stren_attr(Goods) ->
    StrenLv = lib_goods:get_stren_lv(Goods),
    change_equip_stren_attr(Goods, StrenLv).

change_equip_stren_attr(Goods, StrenLv) ->
    case StrenLv =< 0 of
        true -> Goods#goods{stren_equip_add = #attrs{}};
        false ->
            ?DEBUG_MSG("lib_goods:get_tpl_lv(Goods)=~p",[lib_goods:get_tpl_lv(Goods)]),
            Step = get_lv_step_for_strenthen(lib_goods:get_tpl_lv(Goods), data_equip_strenthen:get_all_lv_step_list()),
            DataList = data_equip_strenthen:get(Step),
            Data = lists:keyfind(StrenLv, #equip_strenthen.stren_lv, DataList),
            AddRatio = Data#equip_strenthen.base_attr_add,
            %% 强化进度获得的数值=基础值*（下一级基础属性增加百分比-这一级基础属性增加百分比）*0.8*当前强化进度值
            %% 强化属性=原强化属性+强化进度获得的数值
            Data1 = lists:keyfind(StrenLv+1, #equip_strenthen.stren_lv, DataList),
            AddRatio1 = 
                case Data1 =:= false of
                    false -> Data1#equip_strenthen.base_attr_add;
                    true -> 0
                end,

            ExpLim = lib_goods:get_stren_exp_lim(StrenLv + 1, lib_goods:get_tpl_lv(Goods)),
            CurExp = lib_goods:get_stren_exp(Goods),
            AddValueCoef = 
                case Data1 =:= false of
                    false -> (AddRatio1 / 100 - AddRatio / 100) * 0.8 * (CurExp / ExpLim);
                    true -> 0
                end,

            BaseAttr = lib_goods:get_base_equip_add(Goods),
            StrenAttr = BaseAttr#attrs{
                    hp = util:ceil(BaseAttr#attrs.hp * ((AddRatio / 100) + AddValueCoef)),
                    hp_lim = util:ceil(BaseAttr#attrs.hp_lim * ((AddRatio / 100) + AddValueCoef)),
                    mp = util:ceil(BaseAttr#attrs.mp * ((AddRatio / 100) + AddValueCoef)),
                    mp_lim = util:ceil(BaseAttr#attrs.mp_lim * ((AddRatio / 100) + AddValueCoef)),
                    phy_att = util:ceil(BaseAttr#attrs.phy_att * ((AddRatio / 100) + AddValueCoef)),
                    mag_att = util:ceil(BaseAttr#attrs.mag_att * ((AddRatio / 100) + AddValueCoef)),
                    phy_def = util:ceil(BaseAttr#attrs.phy_def * ((AddRatio / 100) + AddValueCoef)),
                    mag_def = util:ceil(BaseAttr#attrs.mag_def * ((AddRatio / 100) + AddValueCoef)),
                    hit = util:ceil(BaseAttr#attrs.hit * ((AddRatio / 100) + AddValueCoef)),
                    dodge = util:ceil(BaseAttr#attrs.dodge * ((AddRatio / 100) + AddValueCoef)),
                    crit = util:ceil(BaseAttr#attrs.crit * ((AddRatio / 100) + AddValueCoef)),
                    ten = util:ceil(BaseAttr#attrs.ten * ((AddRatio / 100) + AddValueCoef)),
                    talent_str = util:ceil(BaseAttr#attrs.talent_str * ((AddRatio / 100) + AddValueCoef)),
                    talent_con = util:ceil(BaseAttr#attrs.talent_con * ((AddRatio / 100) + AddValueCoef)),
                    talent_sta = util:ceil(BaseAttr#attrs.talent_sta * ((AddRatio / 100) + AddValueCoef)),
                    talent_spi = util:ceil(BaseAttr#attrs.talent_spi * ((AddRatio / 100) + AddValueCoef)),
                    talent_agi = util:ceil(BaseAttr#attrs.talent_agi * ((AddRatio / 100) + AddValueCoef)),
                    anger = util:ceil(BaseAttr#attrs.anger * ((AddRatio / 100) + AddValueCoef)),
                    anger_lim = util:ceil(BaseAttr#attrs.anger_lim * ((AddRatio / 100) + AddValueCoef)),
                    act_speed = util:ceil(BaseAttr#attrs.act_speed * ((AddRatio / 100) + AddValueCoef)),
                    luck = util:ceil(BaseAttr#attrs.luck * ((AddRatio / 100) + AddValueCoef)),
                neglect_ret_dam  = util:ceil(BaseAttr#attrs.neglect_ret_dam * ((AddRatio / 100) + AddValueCoef)),
                    frozen_hit = util:ceil(BaseAttr#attrs.frozen_hit * ((AddRatio / 100) + AddValueCoef)),
                    frozen_hit_lim = util:ceil(BaseAttr#attrs.frozen_hit_lim * ((AddRatio / 100) + AddValueCoef)),
                    trance_hit = util:ceil(BaseAttr#attrs.trance_hit * ((AddRatio / 100) + AddValueCoef)),
                    trance_hit_lim = util:ceil(BaseAttr#attrs.trance_hit_lim * ((AddRatio / 100) + AddValueCoef)),
                    chaos_hit = util:ceil(BaseAttr#attrs.chaos_hit * ((AddRatio / 100) + AddValueCoef)),
                    chaos_hit_lim = util:ceil(BaseAttr#attrs.chaos_hit_lim * ((AddRatio / 100) + AddValueCoef)),
                    frozen_resis = util:ceil(BaseAttr#attrs.frozen_resis * ((AddRatio / 100) + AddValueCoef)),
                    frozen_resis_lim = util:ceil(BaseAttr#attrs.frozen_resis_lim * ((AddRatio / 100) + AddValueCoef)),
                    trance_resis = util:ceil(BaseAttr#attrs.trance_resis * ((AddRatio / 100) + AddValueCoef)),
                    trance_resis_lim = util:ceil(BaseAttr#attrs.trance_resis_lim * ((AddRatio / 100) + AddValueCoef)),
                    chaos_resis = util:ceil(BaseAttr#attrs.chaos_resis * ((AddRatio / 100) + AddValueCoef)),
                    chaos_resis_lim = util:ceil(BaseAttr#attrs.chaos_resis_lim * ((AddRatio / 100) + AddValueCoef)),
                    seal_hit = util:ceil(BaseAttr#attrs.seal_hit * ((AddRatio / 100) + AddValueCoef)),
                    seal_resis = util:ceil(BaseAttr#attrs.seal_resis * ((AddRatio / 100) + AddValueCoef)),
                    heal_value = util:ceil(BaseAttr#attrs.heal_value * ((AddRatio / 100) + AddValueCoef))
                    % combo_att_proba = util:ceil(BaseAttr#attrs.combo_att_proba * (1 + AddRatio / 100)),
                    % strikeback_proba = util:ceil(BaseAttr#attrs.strikeback_proba * (1 + AddRatio / 100)),
                    % pursue_att_proba = util:ceil(BaseAttr#attrs.pursue_att_proba * (1 + AddRatio / 100)),
                    % do_dam_scaling = util:ceil(BaseAttr#attrs.do_dam_scaling * (1 + AddRatio / 100))
            },
            ?DEBUG_MSG("lib_equip:change_equip_stren_attr:AddValueCoef:~p, CurExp:~p, ExpLim:~p, phy_att:~p~n", [AddValueCoef, CurExp, ExpLim, StrenAttr#attrs.phy_att]),
            Goods#goods{stren_equip_add = StrenAttr}
    end.


calc_one_gem_attrs(Attrs, GemNo,IsGemRate) ->
    % ?DEBUG_MSG("lib_equip:calc_one_gem_attrs() GemNo:~p~n", [GemNo]),
    case data_gem_add:get(GemNo) of
        null -> Attrs;
        Data2 ->
            {BooleanGem, GemRate} = IsGemRate,
            Data = case BooleanGem of
                       false ->
                           Data2;
                       true ->
                           Data2#gem_add{ratio = (Data2#gem_add.ratio + util:ceil(Data2#gem_add.ratio *GemRate))}
                   end,
            ?DEBUG_MSG("GemRateBefor ~p   GemRateAfter ~p ~n",[Data2#gem_add.ratio,Data#gem_add.ratio]),
            case Data#gem_add.type of
                % 物理伤害增加百分比
                ?GEM_TYPE_DO_PHY_DAM ->
                    Para = Data#gem_add.ratio,
                    ?ASSERT(util:is_percent(Para), Para),
                    OldVal = Attrs#attrs.do_phy_dam_scaling,
                    NewVal = OldVal + Para,
                    Attrs#attrs{do_phy_dam_scaling = NewVal};
                % 法术伤害增加百分比
                ?GEM_TYPE_DO_MAG_DAM ->
                    Para = Data#gem_add.ratio,
                    ?ASSERT(util:is_percent(Para), Para),

                    OldVal = Attrs#attrs.do_mag_dam_scaling,
                    NewVal = OldVal + Para,
                    Attrs#attrs{do_mag_dam_scaling = NewVal};
                % 被物理伤害减少百分比
                ?GEM_TYPE_BE_PHY_DAM ->
                    Para = Data#gem_add.ratio,
                    ?ASSERT(util:is_percent(Para), Para),

                    OldVal = Attrs#attrs.be_phy_dam_reduce_coef,
                    NewVal = OldVal + Para,
                    Attrs#attrs{be_phy_dam_reduce_coef = NewVal};
                % 被法术伤害减少百分比
                ?GEM_TYPE_BE_MAG_DAM ->
                    Para = Data#gem_add.ratio,
                    ?ASSERT(util:is_percent(Para), Para),

                    OldVal = Attrs#attrs.be_mag_dam_reduce_coef,
                    NewVal = OldVal + Para,
                    Attrs#attrs{be_mag_dam_reduce_coef = NewVal};

                % 气血上限百分比
                ?GEM_TYPE_HP_LIM_RATE ->
                    Para = Data#gem_add.ratio,
                    ?ASSERT(util:is_percent(Para), Para),
                    OldVal = Attrs#attrs.hp_lim_rate,
                    NewVal = OldVal + Para,
                    Attrs#attrs{hp_lim_rate = NewVal};
                % 速度百分比增加
                ?GEM_TYPE_ACT_SPEED_RATE ->
                    Para = Data#gem_add.ratio,
                    ?ASSERT(util:is_percent(Para), Para),
                    OldVal = Attrs#attrs.act_speed_rate,
                    NewVal = OldVal + Para,
                    Attrs#attrs{act_speed_rate = NewVal};

                % 法术暴击伤害
                ?GEM_TYPE_MAG_CRIT_COEF ->
                    Para = Data#gem_add.ratio,
                    ?ASSERT(util:is_percent(Para), Para),
                    OldVal = Attrs#attrs.mag_crit_coef,
                    NewVal = OldVal + Para,
                    Attrs#attrs{mag_crit_coef = NewVal}; 

                % 物理暴击伤害
                ?GEM_TYPE_PHY_CRIT_COEF ->
                    Para = Data#gem_add.ratio,
                    ?ASSERT(util:is_percent(Para), Para),
                    OldVal = Attrs#attrs.phy_crit_coef,
                    NewVal = OldVal + Para,
                    Attrs#attrs{phy_crit_coef = NewVal};

                %%  以下都是整数
                ?GEM_TYPE_PHY_DAM_SHRINK -> 
                    Para = Data#gem_add.ratio,
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.be_phy_dam_shrink,
                    NewVal = OldVal + Para,
                    Attrs#attrs{be_phy_dam_shrink = NewVal};
                ?GEM_TYPE_MAG_DAM_SHRINK -> 
                    Para = Data#gem_add.ratio,                  
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.be_mag_dam_shrink,
                    NewVal = OldVal + Para,
                    Attrs#attrs{be_mag_dam_shrink = NewVal};
                ?GEM_TYPE_PHY_CRIT -> 
                    Para = Data#gem_add.ratio,
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.phy_crit,    
                    NewVal = OldVal + Para,
                    Attrs#attrs{phy_crit = NewVal};
                ?GEM_TYPE_PHY_TEN -> 
                    Para = Data#gem_add.ratio,                
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.phy_ten,
                    NewVal = OldVal + Para,
                    Attrs#attrs{phy_ten = NewVal};
                ?GEM_TYPE_MAG_CRIT -> 
                    Para = Data#gem_add.ratio,                
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.mag_crit,
                    NewVal = OldVal + Para,
                    Attrs#attrs{mag_crit = NewVal};
                ?GEM_TYPE_MAG_TEN -> 
                    Para = Data#gem_add.ratio,
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.mag_ten,                   
                    NewVal = OldVal + Para,
                    Attrs#attrs{mag_ten = NewVal};


                ?GEM_TYPE_PURSUE_ATT ->
                    Para = Data#gem_add.ratio,
                    % ?ASSERT(util:is_positive_int(Para) andalso Para =< ?PROBABILITY_BASE, Para),
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.pursue_att_proba,
                    % NewVal = min(util:ceil(OldVal * (1 + (Para / ?PROBABILITY_BASE_COM))), ?PROBABILITY_BASE),  % 做min矫正，避免溢出
                    NewVal = OldVal + Para,
                    Attrs#attrs{pursue_att_proba = NewVal};
                ?GEM_TYPE_PHY_COMBO_ATT ->
                    Para = Data#gem_add.ratio,
                    % ?ASSERT(util:is_positive_int(Para) andalso Para =< ?PROBABILITY_BASE, Para),
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.phy_combo_att_proba,
                    % NewVal = min(util:ceil(OldVal * (1 + (Para / ?PROBABILITY_BASE_COM))), ?PROBABILITY_BASE),  % 做min矫正，避免溢出
                    NewVal = OldVal + Para,
                    Attrs#attrs{phy_combo_att_proba = NewVal};
                ?GEM_TYPE_ABSORB_HP ->
                    Para = Data#gem_add.ratio,
                    % ?ASSERT(util:is_nonnegative_int(Para), Para),
                    
                    OldVal = Attrs#attrs.absorb_hp_coef,
                    % NewVal = OldVal * (1 + (Para / ?PROBABILITY_BASE_COM)),
                    NewVal = OldVal + Para,
                    % ?DEBUG_MSG("lib_equip:calc_one_gem_attrs() absorb_hp_coef: OldVal:~p NewVal:~p~n", [OldVal, NewVal]),
                    Attrs#attrs{absorb_hp_coef = NewVal};
                ?GEM_TYPE_MAG_COMBO_ATT ->
                    Para = Data#gem_add.ratio,
                    ?ASSERT(util:is_nonnegative_int(Para), Para),

                    OldVal = Attrs#attrs.mag_combo_att_proba,
                    % NewVal = min(util:ceil(OldVal * (1 + (Para / ?PROBABILITY_BASE_COM))), ?PROBABILITY_BASE),  % 做min矫正，避免溢出
                    NewVal = OldVal + Para,
                    Attrs#attrs{mag_combo_att_proba = NewVal};
                ?GEM_TYPE_STRIKEBACK ->
                    Para = Data#gem_add.ratio,
                    ?ASSERT(util:is_nonnegative_int(Para), Para),

                    OldVal = Attrs#attrs.strikeback_proba,
                    % NewVal = min(util:ceil(OldVal * (1 + (Para / ?PROBABILITY_BASE_COM))), ?PROBABILITY_BASE),  % 做min矫正，避免溢出
                    NewVal = OldVal + Para,
                    Attrs#attrs{strikeback_proba = NewVal};
                ?GEM_TYPE_CRIT ->
                    Para = Data#gem_add.ratio,
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.crit,
                    NewVal = util:ceil(OldVal + Para),
                    Attrs#attrs{crit = NewVal};
                ?GEM_TYPE_TEN ->
                    Para = Data#gem_add.ratio,
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.ten,
                    NewVal = util:ceil(OldVal + Para),
                    Attrs#attrs{ten = NewVal};
                ?GEM_TYPE_HIT ->
                    Para = Data#gem_add.ratio,
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.hit,
                    NewVal = util:ceil(OldVal + Para),
                    Attrs#attrs{hit = NewVal};
                ?GEM_TYPE_DODGE ->
                    Para = Data#gem_add.ratio,
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.dodge,
                    NewVal = util:ceil(OldVal + Para),
                    Attrs#attrs{dodge = NewVal};
                ?GEM_TYPE_ACT_SPEED ->
                    Para = Data#gem_add.ratio,
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.act_speed,
                    NewVal = util:ceil(OldVal + Para),
                    Attrs#attrs{act_speed = NewVal};
                ?GEM_TYPE_PHY_ATT ->
                    Para = Data#gem_add.ratio,
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.phy_att,
                    NewVal = util:ceil(OldVal + Para),
                    Attrs#attrs{phy_att = NewVal};
                ?GEM_TYPE_MAG_ATT ->
                    Para = Data#gem_add.ratio,
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.mag_att,
                    NewVal = util:ceil(OldVal + Para),
                    Attrs#attrs{mag_att = NewVal};
                ?GEM_TYPE_PHY_DEF ->
                    Para = Data#gem_add.ratio,
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.phy_def,
                    NewVal = util:ceil(OldVal + Para),
                    Attrs#attrs{phy_def = NewVal};
                ?GEM_TYPE_MAG_DEF ->
                    Para = Data#gem_add.ratio,
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.mag_def,
                    NewVal = util:ceil(OldVal + Para),
                    Attrs#attrs{mag_def = NewVal};
                ?GEM_TYPE_HP_LIM ->
                    Para = Data#gem_add.ratio,
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.hp_lim,
                    NewVal = util:ceil(OldVal + Para),
                    Attrs#attrs{hp_lim = NewVal};
                ?GEM_TYPE_MP_LIM ->
                    Para = Data#gem_add.ratio,
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.mp_lim,
                    NewVal = util:ceil(OldVal + Para),
                    Attrs#attrs{mp_lim = NewVal};
                ?GEM_TYPE_SEAL_HIT ->
                    Para = Data#gem_add.ratio,
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.seal_hit,
                    NewVal = util:ceil(OldVal + Para),
                    Attrs#attrs{seal_hit = NewVal};
                ?GEM_TYPE_SEAL_RESIS ->
                    Para = Data#gem_add.ratio,
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.seal_resis,
                    NewVal = util:ceil(OldVal + Para),
                    Attrs#attrs{seal_resis = NewVal};
                ?GEM_TYPE_FROZEN_HIT ->
                    Para = Data#gem_add.ratio,
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.frozen_hit,
                    NewVal = util:ceil(OldVal + Para),
                    Attrs#attrs{frozen_hit = NewVal};
                ?GEM_TYPE_CHAOS_HIT ->
                    Para = Data#gem_add.ratio,
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.chaos_hit,
                    NewVal = util:ceil(OldVal + Para),
                    Attrs#attrs{chaos_hit = NewVal};
                ?GEM_TYPE_FROZEN_RESIS ->
                    Para = Data#gem_add.ratio,
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.frozen_resis,
                    NewVal = util:ceil(OldVal + Para),
                    Attrs#attrs{frozen_resis = NewVal};
                ?GEM_TYPE_CHAOS_RESIS ->
                    Para = Data#gem_add.ratio,
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.chaos_resis,
                    NewVal = util:ceil(OldVal + Para),
                    Attrs#attrs{chaos_resis = NewVal};
                ?GEM_TYPE_TRANCE_HIT ->
                    Para = Data#gem_add.ratio,
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.trance_hit,
                    NewVal = util:ceil(OldVal + Para),
                    Attrs#attrs{trance_hit = NewVal};
                ?GEM_TYPE_TRANCE_RESIS ->
                    Para = Data#gem_add.ratio,
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.trance_resis,
                    NewVal = util:ceil(OldVal + Para),
                    Attrs#attrs{trance_resis = NewVal};  
                ?GEM_TYPE_HEAL_VALUE ->
                    Para = Data#gem_add.ratio,
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.heal_value,
                    NewVal = util:ceil(OldVal + Para),
                    Attrs#attrs{heal_value = NewVal}; 
                          
                _ ->
                    ?ASSERT(false, Data),
                    Attrs
            end
    end.

calc_one_gem_attrs(Attrs, GemNo,Coef,IsGemRate) ->
    % ?DEBUG_MSG("lib_equip:calc_one_gem_attrs() GemNo:~p~n", [GemNo]),
    case data_gem_add:get(GemNo) of
        null -> Attrs;
        Data2 ->
            {BooleanGem, GemRate} = IsGemRate,
            Data = case BooleanGem of
                       false ->
                           Data2;
                       true ->
                           Data2#gem_add{ratio = (Data2#gem_add.ratio + util:ceil((Data2#gem_add.ratio *GemRate)))}
                   end,
            ?DEBUG_MSG("GemRate2Befor ~p   GemRate2After ~p ~n",[Data2#gem_add.ratio,Data#gem_add.ratio]),
            case Data#gem_add.type of
                ?GEM_TYPE_DO_PHY_DAM ->
                    Para = Data#gem_add.ratio,
                    ?ASSERT(util:is_percent(Para), Para),
                    OldVal = Attrs#attrs.do_phy_dam_scaling,
                    NewVal = OldVal + Para,
                    Attrs#attrs{do_phy_dam_scaling = NewVal};
                ?GEM_TYPE_DO_MAG_DAM ->
                    Para = Data#gem_add.ratio,
                    ?ASSERT(util:is_percent(Para), Para),

                    OldVal = Attrs#attrs.do_mag_dam_scaling,
                    NewVal = OldVal + Para,
                    Attrs#attrs{do_mag_dam_scaling = NewVal};
                ?GEM_TYPE_BE_PHY_DAM ->
                    Para = Data#gem_add.ratio,
                    ?ASSERT(util:is_percent(Para), Para),

                    OldVal = Attrs#attrs.be_phy_dam_reduce_coef,
                    NewVal = OldVal + Para,
                    Attrs#attrs{be_phy_dam_reduce_coef = NewVal};
                ?GEM_TYPE_BE_MAG_DAM ->
                    Para = Data#gem_add.ratio,
                    ?ASSERT(util:is_percent(Para), Para),

                    OldVal = Attrs#attrs.be_mag_dam_reduce_coef,
                    NewVal = OldVal + Para,
                    Attrs#attrs{be_mag_dam_reduce_coef = NewVal};
                ?GEM_TYPE_HP_LIM_RATE ->
                    Para = Data#gem_add.ratio,
                    ?ASSERT(util:is_percent(Para), Para),
                    OldVal = Attrs#attrs.hp_lim_rate,
                    NewVal = OldVal + Para,
                    % ?DEBUG_MSG("lib_equip:calc_one_gem_attrs() NewHpLim:~p~n", [NewVal]),
                    Attrs#attrs{hp_lim_rate = NewVal};

                %%  以下都是整数
                ?GEM_TYPE_PURSUE_ATT ->
                    Para = round(Data#gem_add.ratio * Coef),
                    % ?ASSERT(util:is_positive_int(Para) andalso Para =< ?PROBABILITY_BASE, Para),
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.pursue_att_proba,
                    % NewVal = min(util:ceil(OldVal * (1 + (Para / ?PROBABILITY_BASE_COM))), ?PROBABILITY_BASE),  % 做min矫正，避免溢出
                    NewVal = OldVal + Para,
                    Attrs#attrs{pursue_att_proba = NewVal};
                ?GEM_TYPE_PHY_COMBO_ATT ->
                    Para = round(Data#gem_add.ratio),
                    % ?ASSERT(util:is_positive_int(Para) andalso Para =< ?PROBABILITY_BASE, Para),
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.phy_combo_att_proba,
                    % NewVal = min(util:ceil(OldVal * (1 + (Para / ?PROBABILITY_BASE_COM))), ?PROBABILITY_BASE),  % 做min矫正，避免溢出
                    NewVal = OldVal + Para,
                    Attrs#attrs{phy_combo_att_proba = NewVal};
                ?GEM_TYPE_ABSORB_HP ->
                    Para = round(Data#gem_add.ratio),
                    % ?ASSERT(util:is_nonnegative_int(Para), Para),
                    
                    OldVal = Attrs#attrs.absorb_hp_coef,
                    % NewVal = OldVal * (1 + (Para / ?PROBABILITY_BASE_COM)),
                    NewVal = OldVal + Para,
                    % ?DEBUG_MSG("lib_equip:calc_one_gem_attrs() absorb_hp_coef: OldVal:~p NewVal:~p~n", [OldVal, NewVal]),
                    Attrs#attrs{absorb_hp_coef = NewVal};
                ?GEM_TYPE_MAG_COMBO_ATT ->
                    Para = round(Data#gem_add.ratio * Coef),
                    ?ASSERT(util:is_nonnegative_int(Para), Para),

                    OldVal = Attrs#attrs.mag_combo_att_proba,
                    % NewVal = min(util:ceil(OldVal * (1 + (Para / ?PROBABILITY_BASE_COM))), ?PROBABILITY_BASE),  % 做min矫正，避免溢出
                    NewVal = OldVal + Para,
                    Attrs#attrs{mag_combo_att_proba = NewVal};
                ?GEM_TYPE_STRIKEBACK ->
                    Para =  round(Data#gem_add.ratio * Coef),
                    ?ASSERT(util:is_nonnegative_int(Para), Para),

                    OldVal = Attrs#attrs.strikeback_proba,
                    % NewVal = min(util:ceil(OldVal * (1 + (Para / ?PROBABILITY_BASE_COM))), ?PROBABILITY_BASE),  % 做min矫正，避免溢出
                    NewVal = OldVal + Para,
                    Attrs#attrs{strikeback_proba = NewVal};
                ?GEM_TYPE_CRIT ->
                    Para =  round(Data#gem_add.ratio * Coef),
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.crit,
                    NewVal = util:ceil(OldVal + Para),
                    Attrs#attrs{crit = NewVal};
                ?GEM_TYPE_TEN ->
                    Para =  round(Data#gem_add.ratio * Coef),
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.ten,
                    NewVal = util:ceil(OldVal + Para),
                    Attrs#attrs{ten = NewVal};
                ?GEM_TYPE_HIT ->
                    Para =  round(Data#gem_add.ratio * Coef),
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.hit,
                    NewVal = util:ceil(OldVal + Para),
                    Attrs#attrs{hit = NewVal};
                ?GEM_TYPE_DODGE ->
                    Para =  round(Data#gem_add.ratio * Coef),
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.dodge,
                    NewVal = util:ceil(OldVal + Para),
                    Attrs#attrs{dodge = NewVal};
                ?GEM_TYPE_ACT_SPEED ->
                    Para =  round(Data#gem_add.ratio * Coef),
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.act_speed,
                    NewVal = util:ceil(OldVal + Para),
                    Attrs#attrs{act_speed = NewVal};
                ?GEM_TYPE_PHY_ATT ->
                    Para =  round(Data#gem_add.ratio * Coef),
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.phy_att,
                    NewVal = util:ceil(OldVal + Para),
                    Attrs#attrs{phy_att = NewVal};
                ?GEM_TYPE_MAG_ATT ->
                    Para =  round(Data#gem_add.ratio * Coef),
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.mag_att,
                    NewVal = util:ceil(OldVal + Para),
                    Attrs#attrs{mag_att = NewVal};
                ?GEM_TYPE_PHY_DEF ->
                    Para =  round(Data#gem_add.ratio * Coef),
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.phy_def,
                    NewVal = util:ceil(OldVal + Para),
                    Attrs#attrs{phy_def = NewVal};
                ?GEM_TYPE_MAG_DEF ->
                    Para =  round(Data#gem_add.ratio * Coef),
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.mag_def,
                    NewVal = util:ceil(OldVal + Para),
                    Attrs#attrs{mag_def = NewVal};
                ?GEM_TYPE_HP_LIM ->
                    Para =  round(Data#gem_add.ratio * Coef),
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.hp_lim,
                    NewVal = util:ceil(OldVal + Para),
                    Attrs#attrs{hp_lim = NewVal};
                ?GEM_TYPE_MP_LIM ->
                    Para =  round(Data#gem_add.ratio * Coef),
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.mp_lim,
                    NewVal = util:ceil(OldVal + Para),
                    Attrs#attrs{mp_lim = NewVal};
                ?GEM_TYPE_SEAL_HIT ->
                    Para =  round(Data#gem_add.ratio * Coef),
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.seal_hit,
                    NewVal = util:ceil(OldVal + Para),
                    Attrs#attrs{seal_hit = NewVal};
                ?GEM_TYPE_SEAL_RESIS ->
                    Para =  round(Data#gem_add.ratio * Coef),
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.seal_resis,
                    NewVal = util:ceil(OldVal + Para),
                    Attrs#attrs{seal_resis = NewVal};
                ?GEM_TYPE_FROZEN_HIT ->
                    Para =  round(Data#gem_add.ratio * Coef),
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.frozen_hit,
                    NewVal = util:ceil(OldVal + Para),
                    Attrs#attrs{frozen_hit = NewVal};
                ?GEM_TYPE_CHAOS_HIT ->
                    Para =  round(Data#gem_add.ratio * Coef),
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.chaos_hit,
                    NewVal = util:ceil(OldVal + Para),
                    Attrs#attrs{chaos_hit = NewVal};
                ?GEM_TYPE_FROZEN_RESIS ->
                    Para =  round(Data#gem_add.ratio * Coef),
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.frozen_resis,
                    NewVal = util:ceil(OldVal + Para),
                    Attrs#attrs{frozen_resis = NewVal};
                ?GEM_TYPE_CHAOS_RESIS ->
                    Para =  round(Data#gem_add.ratio * Coef),
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.chaos_resis,
                    NewVal = util:ceil(OldVal + Para),
                    Attrs#attrs{chaos_resis = NewVal};
                ?GEM_TYPE_TRANCE_HIT ->
                    Para =  round(Data#gem_add.ratio * Coef),
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.trance_hit,
                    NewVal = util:ceil(OldVal + Para),
                    Attrs#attrs{trance_hit = NewVal};
                ?GEM_TYPE_TRANCE_RESIS ->
                    Para =  round(Data#gem_add.ratio * Coef),
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.trance_resis,
                    NewVal = util:ceil(OldVal + Para),
                    Attrs#attrs{trance_resis = NewVal};  
                ?GEM_TYPE_HEAL_VALUE ->
                    Para =  round(Data#gem_add.ratio * Coef),
                    ?ASSERT(util:is_nonnegative_int(Para), Para),
                    OldVal = Attrs#attrs.heal_value,
                    NewVal = util:ceil(OldVal + Para),
                    Attrs#attrs{heal_value = NewVal}; 
                          
                _ ->
                    ?ASSERT(false, Data),
                    Attrs
            end
    end.


%% ===================================================== Local Functions =====================================================

get_hp_lim(Goods) ->
    Goods#goods.base_equip_add#attrs.hp_lim + Goods#goods.addi_equip_add#attrs.hp_lim + Goods#goods.stren_equip_add#attrs.hp_lim.

get_mp_lim(Goods) ->
    Goods#goods.base_equip_add#attrs.mp_lim + Goods#goods.addi_equip_add#attrs.mp_lim + Goods#goods.stren_equip_add#attrs.mp_lim.    

get_phy_att(Goods) ->
    Goods#goods.base_equip_add#attrs.phy_att + Goods#goods.addi_equip_add#attrs.phy_att + Goods#goods.stren_equip_add#attrs.phy_att.     

get_mag_att(Goods) ->
    Goods#goods.base_equip_add#attrs.mag_att + Goods#goods.addi_equip_add#attrs.mag_att + Goods#goods.stren_equip_add#attrs.mag_att.

get_phy_def(Goods) ->
    Goods#goods.base_equip_add#attrs.phy_def + Goods#goods.addi_equip_add#attrs.phy_def + Goods#goods.stren_equip_add#attrs.phy_def.

get_mag_def(Goods) ->
    Goods#goods.base_equip_add#attrs.mag_def + Goods#goods.addi_equip_add#attrs.mag_def + Goods#goods.stren_equip_add#attrs.mag_def.

get_act_speed(Goods) ->
    Goods#goods.base_equip_add#attrs.act_speed + Goods#goods.addi_equip_add#attrs.act_speed + Goods#goods.stren_equip_add#attrs.act_speed.

get_dodge(Goods) ->
    Goods#goods.base_equip_add#attrs.dodge + Goods#goods.addi_equip_add#attrs.dodge + Goods#goods.stren_equip_add#attrs.dodge.

get_hit(Goods) ->
    Goods#goods.base_equip_add#attrs.hit + Goods#goods.addi_equip_add#attrs.hit + Goods#goods.stren_equip_add#attrs.hit.

get_frozen_hit(Goods) ->
    Goods#goods.base_equip_add#attrs.frozen_hit + Goods#goods.addi_equip_add#attrs.frozen_hit + Goods#goods.stren_equip_add#attrs.frozen_hit + get_seal_hit(Goods).
get_frozen_resis(Goods) ->
    Goods#goods.base_equip_add#attrs.frozen_resis + Goods#goods.addi_equip_add#attrs.frozen_resis + Goods#goods.stren_equip_add#attrs.frozen_resis + get_seal_resis(Goods).

get_trance_hit(Goods) ->
    Goods#goods.base_equip_add#attrs.trance_hit + Goods#goods.addi_equip_add#attrs.trance_hit + Goods#goods.stren_equip_add#attrs.trance_hit + get_seal_hit(Goods).
get_trance_resis(Goods) ->
    Goods#goods.base_equip_add#attrs.trance_resis + Goods#goods.addi_equip_add#attrs.trance_resis + Goods#goods.stren_equip_add#attrs.trance_resis + get_seal_resis(Goods).

get_chaos_hit(Goods) ->
    Goods#goods.base_equip_add#attrs.chaos_hit + Goods#goods.addi_equip_add#attrs.chaos_hit + Goods#goods.stren_equip_add#attrs.chaos_hit + get_seal_hit(Goods).
get_chaos_resis(Goods) ->
    Goods#goods.base_equip_add#attrs.chaos_resis + Goods#goods.addi_equip_add#attrs.chaos_resis + Goods#goods.stren_equip_add#attrs.chaos_resis + get_seal_resis(Goods).

get_seal_hit(Goods) ->
    Goods#goods.base_equip_add#attrs.seal_hit + Goods#goods.addi_equip_add#attrs.seal_hit + Goods#goods.stren_equip_add#attrs.seal_hit.  
get_seal_resis(Goods) ->
    Goods#goods.base_equip_add#attrs.seal_resis + Goods#goods.addi_equip_add#attrs.seal_resis + Goods#goods.stren_equip_add#attrs.seal_resis.   

get_crit(Goods) ->
    Goods#goods.base_equip_add#attrs.crit + Goods#goods.addi_equip_add#attrs.crit + Goods#goods.stren_equip_add#attrs.crit.

get_ten(Goods) ->
    Goods#goods.base_equip_add#attrs.ten + Goods#goods.addi_equip_add#attrs.ten + Goods#goods.stren_equip_add#attrs.ten.    

%% 计算等级对应的等级段
calc_lv_step(EquipLv) ->
    % case EquipLv =< 10 of
    %     true ->
    %         10;
    %     false ->
    %         (EquipLv div 10 + 1) * 10
    % end.
    EquipLv.



%% 判断是否合法的装备品质概率结构体（概率之和应该刚好为1）
%% dbg: 表示debug，此函数仅仅用于辅助调试
dbg_is_valid_eqp_quality_proba_rd(EqpQualityProba) ->
    {_RecordName, _Lv, ProbaWhite, ProbaGreen, ProbaBule, ProbaPurple, ProbaOrange} = EqpQualityProba,
    ProbaTuple = {ProbaWhite, ProbaGreen, ProbaBule, ProbaPurple, ProbaOrange},
    util:is_numeric_tuple(ProbaTuple) andalso (util:sum_tuple(ProbaTuple) == 1).



dbg_is_valid_eqp_addi_attr_count_proba_rd(EqpAddiAttrCountProba) ->
    {_RecordName, _Quality, Proba_NoAttrs, Proba_OneAttrs, Proba_TwoAttrs, Proba_ThreeAttrs, Proba_FourAttrs, Proba_FiveAttrs} = EqpAddiAttrCountProba,
    ProbaTuple = {Proba_NoAttrs, Proba_OneAttrs, Proba_TwoAttrs, Proba_ThreeAttrs, Proba_FourAttrs, Proba_FiveAttrs},
    util:is_numeric_tuple(ProbaTuple) andalso (util:sum_tuple(ProbaTuple) == 1).



decide_quality__(QualityProbaList, RandNum) ->
    decide_quality__(QualityProbaList, RandNum, 0, ?QUALITY_MIN).

decide_quality__([H | T], RandNum, SumToCompare, CurQuailty) ->
    SumToCompare_2 = H * ?PROBABILITY_BASE + SumToCompare,
    case RandNum =< SumToCompare_2 of
        true ->
            CurQuailty;
        false ->
            decide_quality__(T, RandNum, SumToCompare_2, CurQuailty + 1)
    end;
decide_quality__([], _RandNum, _SumToCompare, _CurQuailty) ->
    ?ASSERT(false),
    ?QUALITY_MIN.  % 正常逻辑不会触发此分支，返回最低品质以容错！


get_constant_type_by_attr_name(AttrName) ->
    case AttrName of
        % ?ATTR_HP -> #equip_added.hp;
        ?ATTR_HP_LIM -> ?CON_TYPE_HP;
        % ?ATTR_MP -> #attrs.mp;
        ?ATTR_MP_LIM -> ?CON_TYPE_HP;

        ?ATTR_PHY_ATT -> ?CON_TYPE_ATT;
        ?ATTR_MAG_ATT -> ?CON_TYPE_ATT;
        ?ATTR_PHY_DEF -> ?CON_TYPE_DEF;
        ?ATTR_MAG_DEF -> ?CON_TYPE_DEF;

        ?ATTR_HIT -> ?CON_TYPE_HIT;
        ?ATTR_DODGE -> ?CON_TYPE_DODGE;
        ?ATTR_CRIT -> ?CON_TYPE_CRIT;
        ?ATTR_TEN -> ?CON_TYPE_TEN;

        % ?ATTR_TALENT_STR -> #attrs.talent_str;
        % ?ATTR_TALENT_CON -> #attrs.talent_con;
        % ?ATTR_TALENT_STA -> #attrs.talent_sta;
        % ?ATTR_TALENT_SPI -> #attrs.talent_spi;
        % ?ATTR_TALENT_AGI -> #attrs.talent_agi;

        % ?ATTR_ANGER -> #attrs.anger;
        % ?ATTR_ANGER_LIM -> #attrs.anger_lim;

        ?ATTR_ACT_SPEED -> ?CON_TYPE_SPEED;
        % ?ATTR_LUCK -> #attrs.luck;

        ?ATTR_FROZEN_RESIS -> ?CON_TYPE_FROZEN_RESIS;
        % ?ATTR_FROZEN_RESIS_LIM -> #attrs.frozen_resis_lim;
          
        ?ATTR_TRANCE_RESIS -> ?CON_TYPE_TRANCE_RESIS;
        % ?ATTR_TRANCE_RESIS_LIM -> #attrs.trance_resis_lim;
             
        ?ATTR_CHAOS_RESIS -> ?CON_TYPE_CHAOS_RESIS;
        % ?ATTR_CHAOS_RESIS_LIM -> #attrs.chaos_resis_lim;
  
        ?ATTR_FROZEN_HIT -> ?CON_TYPE_FROZEN_HIT;
        % ?ATTR_FROZEN_HIT_LIM -> #attrs.frozen_hit_lim;
          
        ?ATTR_TRANCE_HIT -> ?CON_TYPE_TRANCE_HIT;
        % ?ATTR_TRANCE_HIT_LIM -> #attrs.trance_hit_lim;
          
        ?ATTR_CHAOS_HIT -> ?CON_TYPE_CHAOS_HIT;
        % ?ATTR_CHAOS_HIT_LIM -> #attrs.chaos_hit_lim;

        ?ATTR_SEAL_HIT -> ?CON_TYPE_SEAL_HIT;
        ?ATTR_SEAL_RESIS -> ?CON_TYPE_SEAL_RESIS;

        % TODO: 和策划确认 --> 策划已经修改计算公式，此函数暂时没用
        ?ATTR_PHY_COMBO_ATT_PROBA ->  ?CON_TYPE_SPEED;
        ?ATTR_MAG_COMBO_ATT_PROBA ->  ?CON_TYPE_SPEED;
        ?ATTR_STRIKEBACK_PROBA -> ?CON_TYPE_SPEED;
        ?ATTR_PURSUE_ATT_PROBA -> ?CON_TYPE_SPEED
    end.


get_field_index_in_equip_added(AttrName) ->
    case AttrName of
        % ?ATTR_HP -> #equip_added.hp;
        % ?ATTR_HP_LIM -> #equip_added.hp_lim;
        % % ?ATTR_MP -> #attrs.mp;
        % ?ATTR_MP_LIM -> #equip_added.mp_lim;

        % ?ATTR_PHY_ATT -> #equip_added.phy_att;
        % ?ATTR_MAG_ATT -> #equip_added.mag_att;
        % ?ATTR_PHY_DEF -> #equip_added.phy_def;
        % ?ATTR_MAG_DEF -> #equip_added.mag_def;

        % ?ATTR_HIT -> #equip_added.hit;
        % ?ATTR_DODGE -> #equip_added.dodge;
        % ?ATTR_CRIT -> #equip_added.crit;
        % ?ATTR_TEN -> #equip_added.ten;

        % 解开加基本属性的属性
        ?ATTR_TALENT_STR -> #attrs.talent_str;
        ?ATTR_TALENT_CON -> #attrs.talent_con;
        ?ATTR_TALENT_STA -> #attrs.talent_sta;
        ?ATTR_TALENT_SPI -> #attrs.talent_spi;
        ?ATTR_TALENT_AGI -> #attrs.talent_agi;

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

        ?ATTR_PHY_CRIT -> #attrs.phy_crit ;
        ?ATTR_PHY_TEN -> #attrs.phy_ten ;
        ?ATTR_MAG_CRIT -> #attrs.mag_crit ;
        ?ATTR_MAG_TEN -> #attrs.mag_ten ;
        ?ATTR_PHY_CRIT_COEF -> #attrs.phy_crit_coef ;
        ?ATTR_MAG_CRIT_COEF -> #attrs.mag_crit_coef ;
        ?ATTR_HEAL_VALUE -> #attrs.heal_value 

        % ?ATTR_ANGER -> #attrs.anger;
        % ?ATTR_ANGER_LIM -> #attrs.anger_lim;

        % ?ATTR_ACT_SPEED -> #equip_added.act_speed;
        % % ?ATTR_LUCK -> #attrs.luck;

        % ?ATTR_FROZEN_RESIS -> #equip_added.frozen_resis;
        % % ?ATTR_FROZEN_RESIS_LIM -> #attrs.frozen_resis_lim;
          
        % ?ATTR_TRANCE_RESIS -> #equip_added.trance_resis;
        % % ?ATTR_TRANCE_RESIS_LIM -> #attrs.trance_resis_lim;
             
        % ?ATTR_CHAOS_RESIS -> #equip_added.chaos_resis;
        % % ?ATTR_CHAOS_RESIS_LIM -> #attrs.chaos_resis_lim;
  
        % ?ATTR_FROZEN_HIT -> #equip_added.frozen_hit;
        % % ?ATTR_FROZEN_HIT_LIM -> #attrs.frozen_hit_lim;
          
        % ?ATTR_TRANCE_HIT -> #equip_added.trance_hit;
        % % ?ATTR_TRANCE_HIT_LIM -> #attrs.trance_hit_lim;
          
        % ?ATTR_CHAOS_HIT -> #equip_added.chaos_hit;
        % % ?ATTR_CHAOS_HIT_LIM -> #attrs.chaos_hit_lim;

        % ?ATTR_SEAL_HIT -> #equip_added.seal_hit;
        % ?ATTR_SEAL_RESIS -> #equip_added.seal_resis;
        % ?ATTR_PHY_COMBO_ATT_PROBA ->  #equip_added.phy_combo_att_proba;
        % ?ATTR_MAG_COMBO_ATT_PROBA ->  #equip_added.mag_combo_att_proba;
        % ?ATTR_STRIKEBACK_PROBA -> #equip_added.strikeback_proba;
        % ?ATTR_PURSUE_ATT_PROBA -> #equip_added.pursue_att_proba
    end.


%% 获取生成装备附加属性数量
get_make_equip_added_base_attr_count(No) ->
    EquipAdded = data_equip_added:get(No),

    Count = case is_record(EquipAdded, equip_added) of 
        true -> 
            Chance1 = EquipAdded#equip_added.chance1,
            Chance2 = EquipAdded#equip_added.chance2,
            Chance3 = EquipAdded#equip_added.chance3,
            Chance4 = EquipAdded#equip_added.chance4,
            Chance5 = EquipAdded#equip_added.chance5,

            Total = Chance1 + Chance2 + Chance3 + Chance4 + Chance5,
            RandNum = util:rand(1, Total),
            % 暂定最多5条属性
            AttCount = 
            case RandNum =< Chance1 of
                true -> 1  ;
                false ->
                    case RandNum =< (Chance1 + Chance2) of
                        true -> 2  ;
                        false ->
                            case RandNum =< (Chance1 + Chance2 + Chance3) of
                                true -> 3  ;
                                false ->
                                    case RandNum =< (Chance1 + Chance2 + Chance3 + Chance4) of
                                        true -> 4  ;
                                        false ->
                                                case RandNum =< Total of
                                                    true -> 5  ;
                                                    false ->  0
                                            end
                                    end
                            end
                    end
            end,

            AttCount;
        false -> 0
    end,

    Count.

%% 获取是否有获得特技权限
get_make_equip_stunt_chance(No) ->
    EquipAdded = data_equip_added:get(No),
    case is_record(EquipAdded, equip_added) of 
        true ->
            StuntChance = util:minmax( EquipAdded#equip_added.stunt_chance/1000,0,1),
            ?DEBUG_MSG("get_make_equip_stunt_chance ~p",[StuntChance]),
            % StuntChance = 1,
            case util:decide_proba_once(StuntChance) of
                success -> ok;
                _-> fail
            end;
        __ -> fail
    end.


%% 获取是否有获得特技权限
get_make_equip_added_effect_chance(No) ->
    EquipAdded = data_equip_added:get(No),
    case is_record(EquipAdded, equip_added) of 
        true ->
            StuntChance = util:minmax(EquipAdded#equip_added.effect_chance/1000,0,1),
            % StuntChance = 1,
            ?DEBUG_MSG("get_make_equip_added_effect_chance ~p(~p)",[StuntChance,EquipAdded#equip_added.effect_chance]),

            case util:decide_proba_once(StuntChance) of
                success -> ok;
                _-> fail
            end;
        __ -> fail
    end.


% 获取特特技编号（新的洗炼规则）
get_new_make_equip_added_stunt_no(No, Time, Action) ->
    case data_equip_added:get(No) of
        null ->
            null;
        EquipAdded ->
            ?ASSERT(is_record(EquipAdded, equip_added)),

            EffList = case Action of
                          0 ->
                              EquipAdded#equip_added.stunt;
                          1 ->
                              EquipAdded#equip_added.stunt2
                      end,

            % ?DEBUG_MSG("EffList = ~p",[EffList]),
            RandEffList = case Time =:= 0 of
                              true ->
                                  EffListInfo = erlang:hd(EffList),
                                  [_WashTime, WidgetList] = EffListInfo,
                                  WidgetList;
                              false ->
                                  get_random_equip_stunt_weigth_list(EffList, Time)
                          end,
            F = fun({Widget, _NoList}, Sum) ->
                    Widget + Sum
                end,
            Range = lists:foldl(F, 0, RandEffList),
            % ?DEBUG_MSG("Range = ~p",[Range]),
            RandNum = util:rand(1, Range),
            % ?DEBUG_MSG("RandNum = ~p",[RandNum]),
            get_random_equip_stunt_no(RandEffList, RandNum, 0)
    end.

get_random_equip_stunt_weigth_list([H | T], Time) ->
    [{Min, Max}, WidgetList] = H,
    if
        Time >= Min andalso Time =< Max ->
            WidgetList;
        Time > Max andalso T =:= [] ->
            WidgetList;
        true ->
            get_random_equip_stunt_weigth_list(T, Time)
    end;

get_random_equip_stunt_weigth_list([], _Time) ->
    ?ASSERT(false, {_Time}),
    null.

get_random_equip_stunt_no([H | T], RandNum, Sum) ->
    {Widget, EffNoList} = H,

    NewSumWidget = Widget + Sum,
    case RandNum =< NewSumWidget of
        true ->
            EffNo = list_util:rand_pick_one(EffNoList),
            EffNo;
        false ->
            get_random_equip_stunt_no(T, RandNum, NewSumWidget)
    end;

get_random_equip_stunt_no([], _RandNum, _Sum) ->
    ?ASSERT(false, {_RandNum, _Sum}),
    null.

% 获取特技信息
get_make_equip_stunt_info(No) ->
    case data_equip_added:get(No) of
        null -> 
            null;
        EquipAdded ->
            Range = get_random_range_equip_stunt(EquipAdded),
            RandNum = util:rand(1, Range),
            get_random_equip_stunt(EquipAdded, RandNum)
    end.

%% 计算需要随机的范围
get_random_range_equip_stunt(EquipAdded) ->
    ?ASSERT(is_record(EquipAdded, equip_added)),
    EffList = EquipAdded#equip_added.stunt,

    F = fun(SkillNo, Sum) ->
        Skill = data_skill:get(SkillNo),

        Widget = Skill#skl_cfg.rarity_no,
        Widget + Sum
    end,

    lists:foldl(F, 0, EffList).

% 获取随机特技信息
get_random_equip_stunt(EquipAdded, RandNum) ->
    ?ASSERT(is_record(EquipAdded, equip_added)),
    EffList = EquipAdded#equip_added.stunt,
    get_random_equip_stunt(EffList, EquipAdded, RandNum, 0).

get_random_equip_stunt([H | T], EquipAdded, RandNum, SumToCompare) ->
    Skill = data_skill:get(H),

    Widget = Skill#skl_cfg.rarity_no,
    SumToCompare_2 = Widget + SumToCompare,

    case RandNum =< SumToCompare_2 of
        true -> 
            ?DEBUG_MSG("get_random_equip_stunt=~p",[H]),
            H;
        false ->
            get_random_equip_stunt(T, EquipAdded, RandNum, SumToCompare_2)
    end;

get_random_equip_stunt([], _AddedEquipAdd, _RandNum, _SumToCompare) ->
    ?ASSERT(false, {_AddedEquipAdd, _RandNum, _SumToCompare}),
    null.

% ================================================================================================== %

% 获取特效编号（新的洗炼规则）
get_new_make_equip_added_effect_no(No, Time, Action) ->
    case data_equip_added:get(No) of
        null ->
            null;
        EquipAdded ->
            ?ASSERT(is_record(EquipAdded, equip_added)),

            EffList = case Action of
                          0 -> EquipAdded#equip_added.effect;
                          1 -> EquipAdded#equip_added.effect2
                      end,

            % ?DEBUG_MSG("EffList = ~p",[EffList]),
            RandEffList = case Time =:= 0 of
                              true ->
                                  EffListInfo = erlang:hd(EffList),
                                  [_WashTime, WidgetList] = EffListInfo,
                                  WidgetList;
                              false ->
                                  get_random_equip_effect_weigth_list(EffList, Time)
                          end,
            F = fun({Widget, _NoList}, Sum) ->
                    Widget + Sum
                end,
            Range = lists:foldl(F, 0, RandEffList),
            RandNum = util:rand(1, Range),
            EffectNo = get_random_equip_effect_no(RandEffList, RandNum, 0),
            ?DEBUG_MSG("Time = ~p, RandNum = ~p, Range = ~p, EffectNo = ~p",[Time,RandNum,Range,EffectNo]),
            EffectNo
    end.

get_random_equip_effect_weigth_list([H | T], Time) ->
    [{Min, Max}, WidgetList] = H,
    if
        Time >= Min andalso Time =< Max ->
            WidgetList;
        Time > Max andalso T =:= [] ->
            WidgetList;
        true ->
            get_random_equip_effect_weigth_list(T, Time)
    end;

get_random_equip_effect_weigth_list([], _Time) ->
    ?ASSERT(false, {_Time}),
    null.

get_random_equip_effect_no([H | T], RandNum, Sum) ->
    {Widget, EffNoList} = H,

    NewSumWidget = Widget + Sum,
    case RandNum =< NewSumWidget of
        true ->
            EffNo = list_util:rand_pick_one(EffNoList),
            EffNo;
        false ->
            get_random_equip_effect_no(T, RandNum, NewSumWidget)
    end;

get_random_equip_effect_no([], _RandNum, _Sum) ->
    ?ASSERT(false, {_RandNum, _Sum}),
    null.

% 获取特效信息
get_make_equip_added_effect_info(No) ->
    % ?DEBUG_MSG("get_make_equip_added_effect_info ~p",[No]),
    case data_equip_added:get(No) of
        null -> 
            null;
        EquipAdded ->
            Range = get_random_range_equip_effect(EquipAdded),
            % ?DEBUG_MSG("Range = ~p",[Range]),
            RandNum = util:rand(1, Range),
            % ?DEBUG_MSG("RandNum = ~p",[RandNum]),
            get_random_equip_effect(EquipAdded, RandNum)
    end.

%% 计算需要随机的范围
get_random_range_equip_effect(EquipAdded) ->
    ?ASSERT(is_record(EquipAdded, equip_added)),

    EffList = EquipAdded#equip_added.effect,

    % ?DEBUG_MSG("EffList = ~p",[EffList]),

    F = fun(EffNo, Sum) ->
        DESEff = data_equip_speci_effect:get(EffNo),
        Widget = DESEff#equip_speci_effect_tpl.widget,
        Widget + Sum
    end,

    lists:foldl(F, 0, EffList).

% 获取随机特效信息
get_random_equip_effect(EquipAdded, RandNum) ->
    ?ASSERT(is_record(EquipAdded, equip_added)),
    EffList = EquipAdded#equip_added.effect,
    get_random_equip_effect(EffList, EquipAdded, RandNum, 0).

get_random_equip_effect([H | T], EquipAdded, RandNum, SumToCompare) ->
    DESEff = data_equip_speci_effect:get(H),

    AttName = DESEff#equip_speci_effect_tpl.eff_name,
    Widget = DESEff#equip_speci_effect_tpl.widget,

    SumToCompare_2 = Widget + SumToCompare,

    case RandNum =< SumToCompare_2 of
        true -> 
            DESEff;
        false ->
            get_random_equip_effect(T, EquipAdded, RandNum, SumToCompare_2)
    end;

get_random_equip_effect([], _AddedEquipAdd, _RandNum, _SumToCompare) ->
    ?ASSERT(false, {_AddedEquipAdd, _RandNum, _SumToCompare}),
    null.

get_field_index_in_equip_added1(AttrName) ->
    case AttrName of
        % 解开加基本属性的属性
        ?ATTR_TALENT_STR -> #equip_added.talent_str;
        ?ATTR_TALENT_CON -> #equip_added.talent_con;
        ?ATTR_TALENT_STA -> #equip_added.talent_sta;
        ?ATTR_TALENT_SPI -> #equip_added.talent_spi;
        ?ATTR_TALENT_AGI -> #equip_added.talent_agi;
        ?ATTR_NEGLECT_SEAL_RESIS  -> #equip_added.neglect_seal_resis;
        ?ATTR_SEAL_HIT_TO_PARTNER  -> #equip_added.seal_hit_to_partner;
        ?ATTR_SEAL_HIT_TO_MON  -> #equip_added.seal_hit_to_mon;
        ?ATTR_PHY_DAM_TO_PARTNER  -> #equip_added.phy_dam_to_partner;
        ?ATTR_PHY_DAM_TO_MON  -> #equip_added.phy_dam_to_mon;
        ?ATTR_MAG_DAM_TO_PARTNER  -> #equip_added.mag_dam_to_partner;
        ?ATTR_MAG_DAM_TO_MON  -> #equip_added.mag_dam_to_mon;
        ?ATTR_BE_CHAOS_ROUND_REPAIR  -> #equip_added.be_chaos_round_repair;
        ?ATTR_CHAOS_ROUND_REPAIR  -> #equip_added.chaos_round_repair;
        ?ATTR_BE_FROZE_ROUND_REPAIR  -> #equip_added.be_froze_round_repair;
        ?ATTR_FROZE_ROUND_REPAIR  -> #equip_added.froze_round_repair;
        ?ATTR_NEGLECT_PHY_DEF  -> #equip_added.neglect_phy_def;
        ?ATTR_NEGLECT_MAG_DEF  -> #equip_added.neglect_mag_def;
        ?ATTR_PHY_DAM_TO_SPEED_1  -> #equip_added.phy_dam_to_speed_1;
        ?ATTR_PHY_DAM_TO_SPEED_2  -> #equip_added.phy_dam_to_speed_2;
        ?ATTR_MAG_DAM_TO_SPEED_1  -> #equip_added.mag_dam_to_speed_1;
        ?ATTR_MAG_DAM_TO_SPEED_2  -> #equip_added.mag_dam_to_speed_2;
        ?ATTR_SEAL_HIT_TO_SPEED  -> #equip_added.seal_hit_to_speed;

        ?ATTR_REVIVE_HEAL_COEF -> #equip_added.revive_heal_coef;

        ?ATTR_PHY_CRIT -> #equip_added.phy_crit;
        ?ATTR_PHY_TEN -> #equip_added.phy_ten;
        ?ATTR_MAG_CRIT -> #equip_added.mag_crit;
        ?ATTR_MAG_TEN -> #equip_added.mag_ten;
        ?ATTR_PHY_CRIT_COEF -> #equip_added.phy_crit_coef;
        ?ATTR_MAG_CRIT_COEF -> #equip_added.mag_crit_coef;
        ?ATTR_HEAL_VALUE -> #equip_added.heal_value;

		?ATTR_HP_LIM -> #equip_added.hp_lim;
		?ATTR_MP_LIM -> #equip_added.mp_lim;
		?ATTR_PHY_ATT -> #equip_added.phy_att;
		?ATTR_MAG_ATT -> #equip_added.mag_att;
		?ATTR_PHY_DEF -> #equip_added.phy_def;
		?ATTR_MAG_DEF -> #equip_added.mag_def;
		?ATTR_ACT_SPEED -> #equip_added.act_speed;
		?ATTR_SEAL_HIT -> #equip_added.seal_hit;
		?ATTR_SEAL_RESIS -> #equip_added.seal_resis;
		?ATTR_DO_PHY_DAM_SCALING -> #equip_added.do_phy_dam_scaling;
		?ATTR_DO_MAG_DAM_SCALING -> #equip_added.do_mag_dam_scaling;
		?ATTR_BE_PHY_DAM_REDUCE_COEF -> #equip_added.be_phy_dam_reduce_coef;
		?ATTR_BE_MAG_DAM_REDUCE_COEF -> #equip_added.be_mag_dam_reduce_coef;
		

        _ -> 0
    end.

% 随机获得获取属性名字以及最小最大值
get_random_attr_name_and_min_max(No,LastAttNameList,Count) ->
    EquipAdded = data_equip_added:get(No),
    ?ASSERT(is_record(EquipAdded, equip_added)),
 
    % 全部属性列表 第一条属性为常规属性 后面的都不为常规属性
    AttrNameList = case Count of
        1 -> ?EQUIP_BASE_ADDI_ATTR_LIST;
        _C -> ?EQUIP_ADD_ADDI_ATTR_LIST -- ?EQUIP_BASE_ADDI_ATTR_LIST
    end,

    % 还原装备属性的修改
    % AttrNameList = ?EQUIP_BASE_ADDI_ATTR_LIST,

    % 有效不重复属性列表
    ValidAttrNameList = AttrNameList -- LastAttNameList,

    ValidIdx = case length(ValidAttrNameList) of
        1 -> 1;
        Len when (Len > 1) -> util:rand(1,Len);
        _ -> 1
    end,

    % 属性名
    ?DEBUG_MSG("No=~p,ValidAttrNameList=~p,ValidIdx=~p",[No,ValidAttrNameList,ValidIdx]),
    ValidAttName = lists:nth(ValidIdx,ValidAttrNameList),

    % 属性位置
    Index = get_field_index_in_equip_added1(ValidAttName),

    ?DEBUG_MSG("ValidAttName=~p,ValidIdx=~p,Index=~p",[ValidAttName,ValidIdx,Index]),

    % 便宜货
    case element(Index,EquipAdded) of
        [] ->
            get_random_attr_name_and_min_max(No,LastAttNameList ++ [ValidAttName],Count);
        [Min,Max] -> [ValidAttName,Min,Max]
    end.

%{_Index, AttrName, Value, _RefineLv}
% 创建随机附加属性
make_random_attr(No) ->
    Count = get_make_equip_added_base_attr_count(No),
    case Count of
        5 ->
            [ValidAttName,Min,Max] = get_random_attr_name_and_min_max(No,[],1),
            [ValidAttName2,Min2,Max2] = get_random_attr_name_and_min_max(No,[ValidAttName],2),
            [ValidAttName3,Min3,Max3] = get_random_attr_name_and_min_max(No,[ValidAttName,ValidAttName2],3),
            [ValidAttName4,Min4,Max4] = get_random_attr_name_and_min_max(No,[ValidAttName,ValidAttName2,ValidAttName3],4),
            [ValidAttName5,Min5,Max5] = get_random_attr_name_and_min_max(No,[ValidAttName,ValidAttName2,ValidAttName3,ValidAttName4],5),
            [
                {0, ValidAttName, util:rand(Min,Max), 0},
                {0, ValidAttName2, util:rand(Min2,Max2), 0},
                {0, ValidAttName3, util:rand(Min3,Max3), 0},
                {0, ValidAttName4, util:rand(Min4,Max4), 0},
                {0, ValidAttName5, util:rand(Min5,Max5), 0}
            ];
        4 ->
            [ValidAttName,Min,Max] = get_random_attr_name_and_min_max(No,[],1),
            [ValidAttName2,Min2,Max2] = get_random_attr_name_and_min_max(No,[ValidAttName],2),
            [ValidAttName3,Min3,Max3] = get_random_attr_name_and_min_max(No,[ValidAttName,ValidAttName2],3),
            [ValidAttName4,Min4,Max4] = get_random_attr_name_and_min_max(No,[ValidAttName,ValidAttName2,ValidAttName3],4),

            [
                {0, ValidAttName, util:rand(Min,Max), 0},
                {0, ValidAttName2, util:rand(Min2,Max2), 0},
                {0, ValidAttName3, util:rand(Min3,Max3), 0},
                {0, ValidAttName4, util:rand(Min4,Max4), 0}
            ];
        3 ->
            [ValidAttName,Min,Max] = get_random_attr_name_and_min_max(No,[],1),
            [ValidAttName2,Min2,Max2] = get_random_attr_name_and_min_max(No,[ValidAttName],2),
            [ValidAttName3,Min3,Max3] = get_random_attr_name_and_min_max(No,[ValidAttName,ValidAttName2],3),

            [
                {0, ValidAttName, util:rand(Min,Max), 0},
                {0, ValidAttName2, util:rand(Min2,Max2), 0},
                {0, ValidAttName3, util:rand(Min3,Max3), 0}
            ];
        2 ->
            [ValidAttName,Min,Max] = get_random_attr_name_and_min_max(No,[],1),
            [ValidAttName2,Min2,Max2] = get_random_attr_name_and_min_max(No,[ValidAttName],2),

            [
                {0, ValidAttName, util:rand(Min,Max), 0},
                {0, ValidAttName2, util:rand(Min2,Max2), 0}
            ];

        1 ->
            case get_random_attr_name_and_min_max(No,[],1) of
                [ValidAttName,Min,Max] ->
                    [{0, ValidAttName, util:rand(Min,Max), 0}];
                _ -> []
            end;
        _ -> []       
    end.

% 创建随机附加属性
make_addi_random_attr(No, Quality) ->
    Count = get_make_equip_added_base_attr_count(No),
    case Count of
        5 ->
            {ok, ValidAttName1, Value1} = get_addi_random_attr_name_and_value(No, Quality),
            {ok, ValidAttName2, Value2} = get_addi_random_attr_name_and_value(No, Quality),
            {ok, ValidAttName3, Value3} = get_addi_random_attr_name_and_value(No, Quality),
            {ok, ValidAttName4, Value4} = get_addi_random_attr_name_and_value(No, Quality),
            {ok, ValidAttName5, Value5} = get_addi_random_attr_name_and_value(No, Quality),
            [
                {0, ValidAttName1, Value1, 0},
                {0, ValidAttName2, Value2, 0},
                {0, ValidAttName3, Value3, 0},
                {0, ValidAttName4, Value4, 0},
                {0, ValidAttName5, Value5, 0}
            ];
        4 ->
            {ok, ValidAttName1, Value1} = get_addi_random_attr_name_and_value(No, Quality),
            {ok, ValidAttName2, Value2} = get_addi_random_attr_name_and_value(No, Quality),
            {ok, ValidAttName3, Value3} = get_addi_random_attr_name_and_value(No, Quality),
            {ok, ValidAttName4, Value4} = get_addi_random_attr_name_and_value(No, Quality),

            [
                {0, ValidAttName1, Value1, 0},
                {0, ValidAttName2, Value2, 0},
                {0, ValidAttName3, Value3, 0},
                {0, ValidAttName4, Value4, 0}
            ];
        3 ->
            {ok, ValidAttName1 ,Value1} = get_addi_random_attr_name_and_value(No, Quality),
            {ok, ValidAttName2 ,Value2} = get_addi_random_attr_name_and_value(No, Quality),
            {ok, ValidAttName3 ,Value3} = get_addi_random_attr_name_and_value(No, Quality),

            [
                {0, ValidAttName1, Value1, 0},
                {0, ValidAttName2, Value2, 0},
                {0, ValidAttName3, Value3, 0}
            ];
        2 ->
            {ok, ValidAttName1, Value1} = get_addi_random_attr_name_and_value(No, Quality),
            {ok, ValidAttName2, Value2} = get_addi_random_attr_name_and_value(No, Quality),

            [
                {0, ValidAttName1, Value1, 0},
                {0, ValidAttName2, Value2, 0}
            ];

        1 ->
            case get_addi_random_attr_name_and_value(No, Quality) of
                {ok, ValidAttName, Value} ->
                    [{0, ValidAttName, Value, 0}];
                _ -> []
            end;
        _ -> []
    end.

% 随机获得获取属性名字以及属性值  lib_equip:get_addi_random_attr_name_and_value(204301,1).
get_addi_random_attr_name_and_value(No, Quality) ->
    EquipAdded = data_equip_added:get(No),
    ?ASSERT(is_record(EquipAdded, equip_added)),

    % 全部属性列表
    AttrNameList = ?EQUIP_ADD_ADDI_ATTR_LIST,

    Len = length(AttrNameList),
    ValidIdx = util:rand(1,Len),

    % 属性名
    ?DEBUG_MSG("No=~p,ValidIdx=~p",[No,ValidIdx]),
    ValidAttName = lists:nth(ValidIdx,AttrNameList),

    % 属性位置
    Index = get_field_index_in_equip_added1(ValidAttName),

    ?DEBUG_MSG("ValidAttName=~p,ValidIdx=~p,Index=~p",[ValidAttName,ValidIdx,Index]),

    % 便宜货
    case element(Index,EquipAdded) of
        0 ->
            get_addi_random_attr_name_and_value(No, Quality);
        AttrBase ->
            AddiCoef = data_special_config:get('recast_addi_coef'),
            {Min, Max} = case lists:keyfind(Quality, 1, AddiCoef) of
                             {_Quality, _Min, _Max} ->
                                 {_Min, _Max};
                             false ->
                                 %%用于纠正系数
                                 {1.0, 1.1}
                         end,
            Diff = util:ceil( (Max - Min) * 100 ),  % 放大100倍
            Rand = util:rand(1, 100),
            Floating = ((Rand * Diff) div 100) / 100,  % 浮动值
            %% 取得装备真实附加属性
            RealCoef = Min + Floating,
            RealValue = RealCoef * AttrBase,  % 系数 * 基础属性加成基数， 勿忘对结果取整！
            {ok, ValidAttName, RealValue}
    end.

%% 重算附加属性
recount_addi_equip_add(Goods, Quality) when is_record(Goods, goods) ->
    AddiAttrList = lib_goods:get_addi_ep_add_kv(Goods),
    GoodsNo = lib_goods:get_no(Goods),

    EquipAdded = data_equip_added:get(GoodsNo),
    ?ASSERT(is_record(EquipAdded, equip_added)),

    F = fun({_, AttrName, _AttrValue, _}, Acc) ->
            % 属性位置
            Index = get_field_index_in_equip_added1(AttrName),
            case element(Index,EquipAdded) of
                0 ->
                    Acc;
                AttrBase ->
                    AddiCoef = data_special_config:get('recast_addi_coef'),
                    {Min, Max} = case lists:keyfind(Quality, 1, AddiCoef) of
                                     {_Quality, _Min, _Max} ->
                                         {_Min, _Max};
                                     false ->
                                         %%用于纠正系数
                                         {1.0, 1.1}
                                 end,
                    Diff = util:ceil( (Max - Min) * 100 ),  % 放大100倍
                    Rand = util:rand(1, 100),
                    Floating = ((Rand * Diff) div 100) / 100,  % 浮动值
                    %% 取得装备真实附加属性
                    RealCoef = Min + Floating,
                    RealValue = util:ceil(RealCoef * AttrBase),  % 系数 * 基础属性加成基数， 勿忘对结果取整！
                    ?ASSERT(RealValue >= 1),
                    [{0, AttrName, RealValue, 0} | Acc]
            end
        end,
    lists:foldr(F, [], AddiAttrList).


%% 创建随机特效
make_random_eff(No) ->
    % ?DEBUG_MSG("make_random_eff = ~p",[No]),
    case get_make_equip_added_effect_chance(No) of 
        ok -> 
            case get_make_equip_added_effect_info(No) of 
                null -> 0;
                EffInfo -> EffInfo#equip_speci_effect_tpl.no
            end;
        fail ->  0
    end.

%% 创建随机特效(新规则)
make_new_random_eff(No) ->
    make_new_random_eff(No, 0, 0).

make_new_random_eff(No, Time, Action) ->
    % ?DEBUG_MSG("make_random_eff = ~p",[No]),
    case get_make_equip_added_effect_chance(No) of
        ok ->
            case get_new_make_equip_added_effect_no(No, Time, Action) of
                null -> 0;
                EffNo -> EffNo
            end;
        fail ->  0
    end.



%% 创建随机特技
make_random_stunt(No) ->
    case get_make_equip_stunt_chance(No) of 
        ok -> 
            ?DEBUG_MSG("make_random_stunt =~p",[No]),
            case get_make_equip_stunt_info(No) of 
                null -> 0;
                SkillNo -> SkillNo
            end;
        fail ->  0
    end.

%% 创建随机特技（新规则）
make_new_random_stunt(No) ->
    make_new_random_stunt(No, 0, 0).

make_new_random_stunt(No, Time, Action) ->
    case get_make_equip_stunt_chance(No) of
        ok ->
            ?DEBUG_MSG("make_random_stunt =~p",[No]),
            case get_new_make_equip_added_stunt_no(No, Time, Action) of
                null -> 0;
                SkillNo -> SkillNo
            end;
        fail ->  0
    end.


%% 从equip_added结构体提取非空的字段信息
%% @return：元素为[] 字段名的列表
extract_no_null_fields_info(AddedEquipAdd) ->
    ?ASSERT(is_record(AddedEquipAdd, equip_added)),
    AllNameList = record_info(fields, equip_added),
    AttrNameList = AllNameList -- [erlang:hd(AllNameList)],
    ?TRACE("lib_equip:extract_no_null_fields_info() AttrNameList:~p~n", [AttrNameList]),
    F = fun(AttrName, AccInfoList) ->
            Index = get_field_index_in_equip_added(AttrName),
            case element(Index, AddedEquipAdd) of
                [] ->
                    AccInfoList;
                _Value ->
                    [AttrName | AccInfoList]
            end
        end,
    lists:foldl(F, [], AttrNameList).

%% 计算需要随机的范围
calc_prob_range_in_fields_info(AddedEquipAdd) ->
    ?ASSERT(is_record(AddedEquipAdd, equip_added)),
    AllNameList = record_info(fields, equip_added),
    AttrNameList = AllNameList -- [erlang:hd(AllNameList)],
    F = fun(AttrName, Sum) ->
            Index = get_field_index_in_equip_added(AttrName),
            case element(Index, AddedEquipAdd) of
                [] ->
                    Sum;
                Value ->
                    ?ASSERT(is_list(Value), Value),
                    erlang:hd(Value) + Sum
            end
        end,
    lists:foldl(F, 0, AttrNameList).


decide_attr_name_and_base(AddedEquipAdd, RandNum) ->
    AttrNameList = extract_no_null_fields_info(AddedEquipAdd),
    decide_attr_name_and_base(AttrNameList, AddedEquipAdd, RandNum, 0).

decide_attr_name_and_base([H | T], AddedEquipAdd, RandNum, SumToCompare) ->
    Index = get_field_index_in_equip_added(H),
    ProbBaseL = element(Index, AddedEquipAdd),
    ?ASSERT(length(ProbBaseL) =:= 2, ProbBaseL),
    SumToCompare_2 = lists:nth(1, ProbBaseL) + SumToCompare,
    case RandNum =< SumToCompare_2 of
        true -> 
            {H, lists:nth(2, ProbBaseL)};
        false ->
            decide_attr_name_and_base(T, AddedEquipAdd, RandNum, SumToCompare_2)
    end;
decide_attr_name_and_base([], _AddedEquipAdd, _RandNum, _SumToCompare) ->
    ?ASSERT(false, {_AddedEquipAdd, _RandNum, _SumToCompare}),
    {null, 0}.
    

decide_addi_attr_count__(AddiAttrCountProbaList, RandNum) ->
    decide_addi_attr_count__(AddiAttrCountProbaList, RandNum, 0, 0).

decide_addi_attr_count__([H | T], RandNum, SumToCompare, Count) ->
    SumToCompare_2 = H * ?PROBABILITY_BASE + SumToCompare,
    case RandNum =< SumToCompare_2 of
        true ->
            Count;
        false ->
            decide_addi_attr_count__(T, RandNum, SumToCompare_2, Count + 1)
    end;
decide_addi_attr_count__([], _RandNum, _SumToCompare, _Count) ->
    ?ASSERT(false),
    0.  % 正常逻辑不会触发此分支，返回0个以容错！


% return [{属性加成名称,属性加成基数} ...]
get_attr_name_and_base_list(GoodsTpl) ->
    TempAttrNameAndBaseL1 =
    case GoodsTpl#goods_tpl.equip_add_base_attr_name1 /= [] of
        true -> decide_base_attr_by_prob(GoodsTpl#goods_tpl.equip_add_base_attr_name1);
        false -> []
    end,
    TempAttrNameAndBaseL2 =
    case GoodsTpl#goods_tpl.equip_add_base_attr_name2 /= [] of
        true -> decide_base_attr_by_prob(GoodsTpl#goods_tpl.equip_add_base_attr_name2);
        false -> []
    end,
    TempAttrNameAndBaseL3 =
    case GoodsTpl#goods_tpl.equip_add_base_attr_name3 /= [] of
        true -> decide_base_attr_by_prob(GoodsTpl#goods_tpl.equip_add_base_attr_name3);
        false -> []
    end,

    TempAttrNameAndBaseL4 =
    case GoodsTpl#goods_tpl.equip_add_base_attr_name4 /= [] of
        true -> decide_base_attr_by_prob(GoodsTpl#goods_tpl.equip_add_base_attr_name4);
        false -> []
    end,

    TempAttrNameAndBaseL5 =
    case GoodsTpl#goods_tpl.equip_add_base_attr_name5 /= [] of
        true -> decide_base_attr_by_prob(GoodsTpl#goods_tpl.equip_add_base_attr_name5);
        false -> []
    end,

    TempAttrNameAndBaseL6 =
    case GoodsTpl#goods_tpl.equip_add_base_attr_name6 /= [] of
        true -> decide_base_attr_by_prob(GoodsTpl#goods_tpl.equip_add_base_attr_name6);
        false -> []
    end,

    TempAttrNameAndBaseL1 ++ TempAttrNameAndBaseL2 ++ TempAttrNameAndBaseL3 ++ TempAttrNameAndBaseL4 ++ TempAttrNameAndBaseL5 ++ TempAttrNameAndBaseL6.

% return [{属性加成名称,属性加成基数} ...]
get_attr_name_and_base_list(GoodsTpl, OldBaseList) ->
    TempAttrNameAndBaseL1 =
        case GoodsTpl#goods_tpl.equip_add_base_attr_name1 /= [] of
            true -> get_original_attr_name_and_base(GoodsTpl#goods_tpl.equip_add_base_attr_name1, OldBaseList, 1);
            false -> []
        end,
    TempAttrNameAndBaseL2 =
        case GoodsTpl#goods_tpl.equip_add_base_attr_name2 /= [] of
            true -> get_original_attr_name_and_base(GoodsTpl#goods_tpl.equip_add_base_attr_name2, OldBaseList, 2);
            false -> []
        end,
    TempAttrNameAndBaseL3 =
        case GoodsTpl#goods_tpl.equip_add_base_attr_name3 /= [] of
            true -> get_original_attr_name_and_base(GoodsTpl#goods_tpl.equip_add_base_attr_name3, OldBaseList, 3);
            false -> []
        end,

    TempAttrNameAndBaseL4 =
        case GoodsTpl#goods_tpl.equip_add_base_attr_name4 /= [] of
            true -> get_original_attr_name_and_base(GoodsTpl#goods_tpl.equip_add_base_attr_name4, OldBaseList, 4);
            false -> []
        end,

    TempAttrNameAndBaseL5 =
        case GoodsTpl#goods_tpl.equip_add_base_attr_name5 /= [] of
            true -> get_original_attr_name_and_base(GoodsTpl#goods_tpl.equip_add_base_attr_name5, OldBaseList, 5);
            false -> []
        end,

    TempAttrNameAndBaseL6 =
        case GoodsTpl#goods_tpl.equip_add_base_attr_name6 /= [] of
            true -> get_original_attr_name_and_base(GoodsTpl#goods_tpl.equip_add_base_attr_name6, OldBaseList, 6);
            false -> []
        end,

    TempAttrNameAndBaseL1 ++ TempAttrNameAndBaseL2 ++ TempAttrNameAndBaseL3 ++ TempAttrNameAndBaseL4 ++ TempAttrNameAndBaseL5 ++ TempAttrNameAndBaseL6.

get_original_attr_name_and_base(BaseAttrList, OldBaseList, Count) ->
    Len = length(OldBaseList),
    case Len < Count of
        true ->
            ?ASSERT(false, Len),
            [];
        false ->
            NowBaseAttr = lists:nth(Count, OldBaseList),
            {AttrName, _Attrvalue} = NowBaseAttr,
            case lists:keyfind(AttrName, 2, BaseAttrList) of
                {_Prob, _Name, AttrValue} ->
                    [{AttrName, AttrValue}];
                false ->
                    ?ASSERT(false, AttrName)
            end
    end.

%% 获取基础属性
decide_base_attr_by_prob(AttrList) ->
    F = fun({Prob, _AttrName, _AttrValue}, Acc) ->
            Acc + Prob
        end,
    TotalProb = lists:foldl(F, 0, AttrList),
    RandNum = util:rand(1, TotalProb),
    decide_base_attr_by_prob(AttrList, RandNum, 0).

decide_base_attr_by_prob([H | T], RandNum, TotalProb) ->
    {Prob, AttrName, AttrValue} = H,
    CurProb = TotalProb + Prob,
    case RandNum =< CurProb of
        true ->
            [{AttrName, AttrValue}];
        false ->
            decide_base_attr_by_prob(T, RandNum, CurProb)
    end;

decide_base_attr_by_prob([], RandNum, TotalProb) ->
    ?ASSERT(false),
    [].  % 正常逻辑不会触发此分支！


get_equip_add_lv() ->
    LvList = data_equip_add_lv:get_all_lv_list(),
    RandNum = util:rand(1, mod_global_data:get_equip_add_sum_weight()),
    get_equip_add_lv(LvList, RandNum, 0, erlang:hd(LvList)).

get_equip_add_lv([H | T], RandNum, SumToCompare, CurLv) ->
    Data = data_equip_add_lv:get(H),
    SumToCompare_2 = Data#equip_add_lv.weight + SumToCompare,
    case RandNum =< SumToCompare_2 of
        true ->
            CurLv;
        false ->
            get_equip_add_lv(T, RandNum, SumToCompare_2, CurLv + 1)
    end;
get_equip_add_lv([], _RandNum, _SumToCompare, _CurLv) ->
    ?ASSERT(false),
    0.  % 正常逻辑不会触发此分支，返回0个以容错！

get_lv_step_for_strenthen(_Lv, []) ->
    ?ASSERT(false),
    ?INVALID_NO.

%%get_lv_step_for_strenthen(Lv, [Step | T]) ->
%%    case data_equip_strenthen:get(Step) of
%%        null ->
%%            get_lv_step_for_strenthen(Lv, T);
%%        DataList ->
%%            Rd = erlang:hd(DataList),
%%            Range = Rd#equip_strenthen.lv_range,
%%            case util:in_range(Lv, lists:nth(1, Range), lists:nth(2, Range)) of
%%                true ->
%%                    Step;
%%                false ->
%%                    get_lv_step_for_strenthen(Lv, T)
%%            end
%%    end.


decide_equip_hole_count(NoList, RandNum) ->
    decide_equip_hole_count(NoList, RandNum, 0).

decide_equip_hole_count([H | T], RandNum, SumToCompare) ->
    Data = data_equip_hole:get(H),
    SumToCompare_2 = Data#equip_hole.proba + SumToCompare,
    case RandNum =< SumToCompare_2 of
        true ->
            Data#equip_hole.hole_no;
        false ->
            decide_equip_hole_count(T, RandNum, SumToCompare_2)
    end;
decide_equip_hole_count([], _RandNum, _SumToCompare) ->
    ?ASSERT(false), 0.  % 正常逻辑不会触发此分支，返回0以容错！



%% 重算附加属性值
% 基准值*精炼等级对应的系数
calc_addi_value(AttrName, Base, RefineLv) ->
    case data_eq_refine_lv_rela:get(RefineLv) of
        null -> ?ASSERT(false, RefineLv), 10;
        EqRefineLvRelaCfg ->
            Index = get_field_index_in_eq_refine_lv_rela(AttrName),
            AttrCoef = element(Index, EqRefineLvRelaCfg),
            util:ceil(Base * AttrCoef)
    end.

% 暂时屏蔽这个接口
recount_addi_value(_GoodsNo, _AttrName, _RefineLv) ->
    void.

recount_addi_value1(GoodsNo, AttrName, RefineLv) ->
    case data_equip_added:get(GoodsNo) of
        null -> ?ASSERT(false, GoodsNo), 10;
        EqAddedAddCfg ->
            Index = get_field_index_in_equip_added(AttrName),
            ProbBaseL = element(Index, EqAddedAddCfg),
            Base = lists:nth(2, ProbBaseL),
            case data_eq_refine_lv_rela:get(RefineLv) of
                null -> ?ASSERT(false, RefineLv), 10;
                EqRefineLvRelaCfg ->
                    Index1 = get_field_index_in_eq_refine_lv_rela(AttrName),
                    AttrCoef = element(Index1, EqRefineLvRelaCfg),
                    util:ceil(Base * AttrCoef)
            end
    end.
                

decide_refine_Lv(GoodsNo, AttrName, AttrValue) ->
    EquipLv = lib_goods:get_lv(lib_goods:get_tpl_data(GoodsNo)),
    {Min, Max} = 
        case data_eq_refine_lv_open:get(EquipLv) of
            null ->
                ?ASSERT(false, EquipLv), {1, 1, 1};
            {TMin, TMax, _} -> {TMin, TMax}
        end,

    case data_equip_added:get(GoodsNo) of
        null -> 
            Min;
        EqAddedAddCfg ->
            Index = get_field_index_in_equip_added(AttrName),
            ProbBaseL = element(Index, EqAddedAddCfg),
            Base = lists:nth(2, ProbBaseL),
            decide_refine_Lv(AttrName, AttrValue, Base, Max, lists:seq(Min, Max))
    end.

decide_refine_Lv(_AttrName, _AttrValue, _Base, Max, []) ->
    ?WARNING_MSG("lib_equip:decide_refine_Lv error!{_AttrName, _AttrValue, _Base, Max}:~p~n", [{_AttrName, _AttrValue, _Base, Max}]),
    Max;
decide_refine_Lv(AttrName, AttrValue, Base, Max, [H | T]) ->
    case data_eq_refine_lv_rela:get(H) of
        null -> 
            decide_refine_Lv(AttrName, AttrValue, Base, Max, T);
        EqRefineLvRelaCfg ->
            Index = get_field_index_in_eq_refine_lv_rela(AttrName),
            AttrCoef = element(Index, EqRefineLvRelaCfg),

            case util:ceil(Base * AttrCoef) >= AttrValue of
                true -> H;
                false -> decide_refine_Lv(AttrName, AttrValue, Base, Max, T)
            end
    end.

decide_addi_refine_lv(GoodsNo) ->
    EquipLv = lib_goods:get_lv(lib_goods:get_tpl_data(GoodsNo)),
    case data_eq_refine_lv_open:get(EquipLv) of
        null ->
            ?ASSERT(false, EquipLv), 1;
        {Min, _Max, InitMax} -> 
            F = fun(Lv, Sum) ->
                case data_eq_refine_lv_rela:get(Lv) of
                    null -> Sum;
                    EqRefineLvRelaCfg -> EqRefineLvRelaCfg#eq_refine_lv_rela.weight + Sum
                end
            end,
            Range = lists:foldl(F, 0, lists:seq(Min, InitMax)),
            RandNum = util:rand(1, Range),
            decide_addi_refine_lv(lists:seq(Min, InitMax), RandNum)
    end.


decide_addi_refine_lv(LvList, RandNum) ->
    decide_addi_refine_lv(LvList, RandNum, 0).

decide_addi_refine_lv([H | T], RandNum, SumToCompare) ->
    case data_eq_refine_lv_rela:get(H) of
        null -> decide_addi_refine_lv(T, RandNum, SumToCompare);
        EqRefineLvRelaCfg -> 
            SumToCompare_2 = EqRefineLvRelaCfg#eq_refine_lv_rela.weight + SumToCompare,
            case RandNum =< SumToCompare_2 of
                true -> H;
                false -> decide_addi_refine_lv(T, RandNum, SumToCompare_2)
            end
    end;
decide_addi_refine_lv([], _RandNum, _SumToCompare) ->
    ?ASSERT(false), 1.  % 正常逻辑不会触发此分支，返回0以容错！



get_field_index_in_eq_refine_lv_rela(AttrName) ->
    case AttrName of
        ?ATTR_HP_LIM -> #eq_refine_lv_rela.hp_lim;
        ?ATTR_MP_LIM -> #eq_refine_lv_rela.mp_lim;

        ?ATTR_PHY_ATT -> #eq_refine_lv_rela.phy_att;
        ?ATTR_MAG_ATT -> #eq_refine_lv_rela.mag_att;
        ?ATTR_PHY_DEF -> #eq_refine_lv_rela.phy_def;
        ?ATTR_MAG_DEF -> #eq_refine_lv_rela.mag_def;

        ?ATTR_HIT -> #eq_refine_lv_rela.hit;
        ?ATTR_DODGE -> #eq_refine_lv_rela.dodge;
        ?ATTR_CRIT -> #eq_refine_lv_rela.crit;
        ?ATTR_TEN -> #eq_refine_lv_rela.ten;

        % ?ATTR_TALENT_STR -> #attrs.talent_str;
        % ?ATTR_TALENT_CON -> #attrs.talent_con;
        % ?ATTR_TALENT_STA -> #attrs.talent_sta;
        % ?ATTR_TALENT_SPI -> #attrs.talent_spi;
        % ?ATTR_TALENT_AGI -> #attrs.talent_agi;

        % ?ATTR_ANGER -> #attrs.anger;
        % ?ATTR_ANGER_LIM -> #attrs.anger_lim;

        ?ATTR_ACT_SPEED -> #eq_refine_lv_rela.act_speed;
        % ?ATTR_LUCK -> #attrs.luck;

        ?ATTR_FROZEN_RESIS -> #eq_refine_lv_rela.frozen_resis;
        % ?ATTR_FROZEN_RESIS_LIM -> #attrs.frozen_resis_lim;
          
        ?ATTR_TRANCE_RESIS -> #eq_refine_lv_rela.trance_resis;
        % ?ATTR_TRANCE_RESIS_LIM -> #attrs.trance_resis_lim;
             
        ?ATTR_CHAOS_RESIS -> #eq_refine_lv_rela.chaos_resis;
        % ?ATTR_CHAOS_RESIS_LIM -> #attrs.chaos_resis_lim;
  
        ?ATTR_FROZEN_HIT -> #eq_refine_lv_rela.frozen_hit;
        % ?ATTR_FROZEN_HIT_LIM -> #attrs.frozen_hit_lim;
          
        ?ATTR_TRANCE_HIT -> #eq_refine_lv_rela.trance_hit;
        % ?ATTR_TRANCE_HIT_LIM -> #attrs.trance_hit_lim;
          
        ?ATTR_CHAOS_HIT -> #eq_refine_lv_rela.chaos_hit;
        % ?ATTR_CHAOS_HIT_LIM -> #attrs.chaos_hit_lim;

        ?ATTR_SEAL_HIT -> #eq_refine_lv_rela.seal_hit;
        ?ATTR_SEAL_RESIS -> #eq_refine_lv_rela.seal_resis
        % ?ATTR_PHY_COMBO_ATT_PROBA ->  #eq_refine_lv_rela.phy_combo_att_proba;
        % ?ATTR_MAG_COMBO_ATT_PROBA ->  #eq_refine_lv_rela.mag_combo_att_proba;
        % ?ATTR_STRIKEBACK_PROBA -> #eq_refine_lv_rela.strikeback_proba;
        % ?ATTR_PURSUE_ATT_PROBA -> #eq_refine_lv_rela.pursue_att_proba
    end.

% 暂时不重置
adjust_eq_addi_attr(GoodsNo, AddiEpAdd_TupL) ->
    AddiEpAdd_TupL.

adjust_eq_addi_attr1(GoodsNo, AddiEpAdd_TupL) ->
    case AddiEpAdd_TupL =:= [] of
        true -> AddiEpAdd_TupL;
        false ->
            case lists:nth(1, AddiEpAdd_TupL) of
                {_Index, _AttrName, _AttrValue, _RefineLv} -> %% 重算以便数值调整
                    F = fun({Idx, Name, _Value, Lv}, Acc) ->
                        NewValue = recount_addi_value(GoodsNo, Name, Lv),
                        [{Idx, Name, NewValue, Lv} | Acc]
                    end,
                    lists:foldl(F, [], AddiEpAdd_TupL);
                {_AttrName, _AttrValue} -> %% 规则调整
                    F = fun({Name, Value}, Acc) ->
                        Index = length(Acc) + 1,
                        RefineLv = decide_refine_Lv(GoodsNo, Name, Value),
                        NewValue = recount_addi_value(GoodsNo, Name, RefineLv),
                        case NewValue >= Value of
                            true ->
                                [{Index, Name, NewValue, RefineLv} | Acc];
                            false ->
                                ?WARNING_MSG("lib_equip:adjust_eq_addi_attr error! Value:~p, NewValue:~p", [Value, NewValue]),
                                [{Index, Name, Value, RefineLv} | Acc]
                        end
                    end,
                    lists:foldl(F, [], AddiEpAdd_TupL);
                _Any ->
                    ?ASSERT(false, _Any),
                    AddiEpAdd_TupL
            end
    end.

get_free_stren_cnt(PS) ->
    PlayerMisc = ply_misc:get_player_misc(player:id(PS)),
    PlayerMisc#player_misc.free_stren_cnt.

reset_free_stren_cnt(PS) ->
    PlayerMisc = ply_misc:get_player_misc(player:id(PS)),
    % 去掉每日免费送一次强化次数
    PlayerMisc1 = PlayerMisc#player_misc{free_stren_cnt = 0},
    ply_misc:update_player_misc(PlayerMisc1),
    player:notify_cli_info_change(PS, ?OI_CODE_FREE_STREN_CNT, PlayerMisc1#player_misc.free_stren_cnt).

cost_free_stren_cnt(PS, Cnt) ->
    PlayerMisc = ply_misc:get_player_misc(player:id(PS)),
    PlayerMisc1 = PlayerMisc#player_misc{free_stren_cnt = PlayerMisc#player_misc.free_stren_cnt - Cnt},
    ply_misc:update_player_misc(PlayerMisc1),
    player:notify_cli_info_change(PS, ?OI_CODE_FREE_STREN_CNT, PlayerMisc1#player_misc.free_stren_cnt).    