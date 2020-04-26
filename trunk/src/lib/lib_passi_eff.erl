%%%--------------------------------------
%%% @Module  : lib_passi_eff
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2013.9.11
%%% @Description : 被动技能的效果
%%%--------------------------------------
-module(lib_passi_eff).
-export([
        get_cfg_data/1,
        is_hot/1,
        calc_passi_eff/3,
        calc_one_passi_eff/4,
        calc_passi_eff_add_value/3,
  calc_passi_eff_value_duan2/2
    ]).

-include("common.hrl").
-include("record.hrl").
-include("effect.hrl").
-include("attribute.hrl").


get_cfg_data(EffNo) ->
    data_passi_eff:get(EffNo).


%% 是否HOT类被动效果
is_hot(EffNo) when is_integer(EffNo) ->
    case get_cfg_data(EffNo) of
        null ->
            false;
        Eff ->
            is_hot__(Eff#passi_eff.name)
    end;
is_hot(Eff) when is_record(Eff, passi_eff) ->
    is_hot__(Eff#passi_eff.name).


is_hot__(EffName) ->
    EffName == ?EN_HOT_HP
    orelse EffName == ?EN_HOT_MP orelse EffName == ?EN_HOT_PHY_ATT orelse EffName == ?EN_HOT_MAG_ATT.



%% return attrs 结构体
calc_passi_eff(Attrs, _Lv, []) ->
    Attrs;

calc_passi_eff(Attrs, Lv, [PassiEffNo | T]) ->
    PassiEff = get_cfg_data(PassiEffNo),

    Attrs2 = 
        case PassiEff of
            null ->
                ?ASSERT(false, PassiEffNo),
                ?ERROR_MSG("[lib_passi_eff] calc_passi_eff() error! passi eff not exists!! PassiEffNo=~p", [PassiEffNo]),
                Attrs;
            _ ->
                calc_one_passi_eff(PassiEff#passi_eff.name, Attrs, PassiEff, Lv)
        end,
    ?ASSERT(is_record(Attrs2, attrs), Attrs2),

    calc_passi_eff(Attrs2, Lv, T).

    
%% return attrs 结构体
calc_one_passi_eff(?EN_ADD_HP_LIM, Attrs, PassiEff, Lv) ->
    % AddVal = calc_passi_eff_add_value(PassiEff, Lv, ?ATTR_HP),

    Op = PassiEff#passi_eff.op,
    
    Value = case Op of 
        1 -> 
            calc_passi_eff_value_duan1(PassiEff,Lv);
        2 ->
            calc_passi_eff_value_duan2(PassiEff,Lv);
        _ -> 
            calc_passi_eff_add_value(PassiEff, Lv, ?EN_ADD_HP_LIM)
    end,

    OldVal = Attrs#attrs.hp_lim,
    NewVal = OldVal + Value,
    Attrs#attrs{hp_lim = NewVal};

calc_one_passi_eff(?EN_ADD_PHY_ATT, Attrs, PassiEff, Lv) ->
    % AddVal = calc_passi_eff_add_value(PassiEff, Lv, ?ATTR_PHY_ATT),
    Op = PassiEff#passi_eff.op,
    
    Value = case Op of 
        1 -> 
            calc_passi_eff_value_duan1(PassiEff,Lv);
        2 ->
            calc_passi_eff_value_duan2(PassiEff,Lv);
        _ -> 
            calc_passi_eff_add_value(PassiEff, Lv, ?EN_ADD_PHY_ATT)
    end,


    OldVal = Attrs#attrs.phy_att,
    NewVal = OldVal + Value,
    Attrs#attrs{phy_att = NewVal};


calc_one_passi_eff(?EN_ADD_ACT_SPEED_BY_RATE, Attrs, PassiEff, Lv) ->
    % AddVal = calc_passi_eff_add_value(PassiEff, Lv, ?ATTR_PHY_ATT),
    Op = PassiEff#passi_eff.op,

    Value = case Op of
                1 ->
                    calc_passi_eff_value_duan1(PassiEff,Lv);
                2 ->
                    calc_passi_eff_value_duan2(PassiEff,Lv);
                _ ->
                    calc_passi_eff_add_value(PassiEff, Lv, ?EN_ADD_ACT_SPEED_BY_RATE)
            end,
    OldVal = Attrs#attrs.act_speed_rate,
    NewVal = OldVal + Value,
    Attrs#attrs{act_speed_rate = NewVal};

calc_one_passi_eff(?EN_REDUCE_ACT_SPEED_BY_RATE, Attrs, PassiEff, Lv) ->
    % AddVal = calc_passi_eff_add_value(PassiEff, Lv, ?ATTR_PHY_ATT),
    Op = PassiEff#passi_eff.op,

    Value = case Op of
                1 ->
                    calc_passi_eff_value_duan1(PassiEff,Lv);
                2 ->
                    calc_passi_eff_value_duan2(PassiEff,Lv);
                _ ->
                    calc_passi_eff_add_value(PassiEff, Lv, ?EN_REDUCE_ACT_SPEED_BY_RATE)
            end,
    OldVal = Attrs#attrs.act_speed_rate,
    NewVal = OldVal - Value,
    Attrs#attrs{act_speed_rate = NewVal};

calc_one_passi_eff(?EN_ADD_MAG_DEF_BY_RATE, Attrs, PassiEff, Lv) ->
    % AddVal = calc_passi_eff_add_value(PassiEff, Lv, ?ATTR_PHY_ATT),
    Op = PassiEff#passi_eff.op,

    Value = case Op of
                1 ->
                    calc_passi_eff_value_duan1(PassiEff,Lv);
                2 ->
                    calc_passi_eff_value_duan2(PassiEff,Lv);
                _ ->
                    calc_passi_eff_add_value(PassiEff, Lv, ?EN_ADD_MAG_DEF_BY_RATE)
            end,
    OldVal = Attrs#attrs.mag_def_rate,
    NewVal = OldVal + Value,
    Attrs#attrs{mag_def_rate = NewVal};

calc_one_passi_eff(?EN_REDUCE_MAG_DEF_BY_RATE, Attrs, PassiEff, Lv) ->
    % AddVal = calc_passi_eff_add_value(PassiEff, Lv, ?ATTR_PHY_ATT),
    Op = PassiEff#passi_eff.op,

    Value = case Op of
                1 ->
                    calc_passi_eff_value_duan1(PassiEff,Lv);
                2 ->
                    calc_passi_eff_value_duan2(PassiEff,Lv);
                _ ->
                    calc_passi_eff_add_value(PassiEff, Lv, ?EN_REDUCE_MAG_DEF_BY_RATE)
            end,
    OldVal = Attrs#attrs.mag_def_rate,
    NewVal = OldVal - Value,
    Attrs#attrs{mag_def_rate = NewVal};


calc_one_passi_eff(?EN_ADD_PHY_DEF_BY_RATE, Attrs, PassiEff, Lv) ->
    % AddVal = calc_passi_eff_add_value(PassiEff, Lv, ?ATTR_PHY_ATT),
    Op = PassiEff#passi_eff.op,

    Value = case Op of
                1 ->
                    calc_passi_eff_value_duan1(PassiEff,Lv);
                2 ->
                    calc_passi_eff_value_duan2(PassiEff,Lv);
                _ ->
                    calc_passi_eff_add_value(PassiEff, Lv, ?EN_ADD_PHY_DEF_BY_RATE)
            end,
    OldVal = Attrs#attrs.phy_def_rate,
    NewVal = OldVal + Value,
    Attrs#attrs{phy_def_rate = NewVal};

calc_one_passi_eff(?EN_REDUCE_PHY_DEF_BY_RATE, Attrs, PassiEff, Lv) ->
    % AddVal = calc_passi_eff_add_value(PassiEff, Lv, ?ATTR_PHY_ATT),
    Op = PassiEff#passi_eff.op,

    Value = case Op of
                1 ->
                    calc_passi_eff_value_duan1(PassiEff,Lv);
                2 ->
                    calc_passi_eff_value_duan2(PassiEff,Lv);
                _ ->
                    calc_passi_eff_add_value(PassiEff, Lv, ?EN_REDUCE_PHY_DEF_BY_RATE)
            end,
    OldVal = Attrs#attrs.phy_def_rate,
    NewVal = OldVal - Value,
    Attrs#attrs{phy_def_rate = NewVal};

calc_one_passi_eff(?EN_REDUCE_MAG_ATT_BY_RATE, Attrs, PassiEff, Lv) ->
    % AddVal = calc_passi_eff_add_value(PassiEff, Lv, ?ATTR_PHY_ATT),
    Op = PassiEff#passi_eff.op,

    Value = case Op of
                1 ->
                    calc_passi_eff_value_duan1(PassiEff,Lv);
                2 ->
                    calc_passi_eff_value_duan2(PassiEff,Lv);
                _ ->
                    calc_passi_eff_add_value(PassiEff, Lv, ?EN_REDUCE_MAG_ATT_BY_RATE)
            end,
    OldVal = Attrs#attrs.mag_att_rate,
    NewVal = OldVal - Value,
    Attrs#attrs{mag_att_rate = NewVal};

calc_one_passi_eff(?EN_ADD_MAG_ATT_BY_RATE, Attrs, PassiEff, Lv) ->
    % AddVal = calc_passi_eff_add_value(PassiEff, Lv, ?ATTR_PHY_ATT),
    Op = PassiEff#passi_eff.op,

    Value = case Op of
                1 ->
                    calc_passi_eff_value_duan1(PassiEff,Lv);
                2 ->
                    calc_passi_eff_value_duan2(PassiEff,Lv);
                _ ->
                    calc_passi_eff_add_value(PassiEff, Lv, ?EN_ADD_MAG_ATT_BY_RATE)
            end,
    OldVal = Attrs#attrs.mag_att_rate,
    NewVal = OldVal + Value,
    Attrs#attrs{mag_att_rate = NewVal};

calc_one_passi_eff(?EN_REDUCE_PHY_ATT_BY_RATE, Attrs, PassiEff, Lv) ->
    % AddVal = calc_passi_eff_add_value(PassiEff, Lv, ?ATTR_PHY_ATT),
    Op = PassiEff#passi_eff.op,

    Value = case Op of
                1 ->
                    calc_passi_eff_value_duan1(PassiEff,Lv);
                2 ->
                    calc_passi_eff_value_duan2(PassiEff,Lv);
                _ ->
                    calc_passi_eff_add_value(PassiEff, Lv, ?EN_REDUCE_PHY_ATT_BY_RATE)
            end,
    OldVal = Attrs#attrs.phy_att_rate,
    NewVal = OldVal - Value,
    Attrs#attrs{phy_att_rate = NewVal};

calc_one_passi_eff(?EN_ADD_PHY_ATT_BY_RATE, Attrs, PassiEff, Lv) ->
    % AddVal = calc_passi_eff_add_value(PassiEff, Lv, ?ATTR_PHY_ATT),
    Op = PassiEff#passi_eff.op,

    Value = case Op of
                1 ->
                    calc_passi_eff_value_duan1(PassiEff,Lv);
                2 ->
                    calc_passi_eff_value_duan2(PassiEff,Lv);
                _ ->
                    calc_passi_eff_add_value(PassiEff, Lv, ?EN_ADD_PHY_ATT_BY_RATE)
            end,
    OldVal = Attrs#attrs.phy_att_rate,
    NewVal = OldVal + Value,
    Attrs#attrs{phy_att_rate = NewVal};


calc_one_passi_eff(?EN_REDUCE_HP_LIM_BY_RATE, Attrs, PassiEff, Lv) ->
    % AddVal = calc_passi_eff_add_value(PassiEff, Lv, ?ATTR_PHY_ATT),
    Op = PassiEff#passi_eff.op,

    Value = case Op of
                1 ->
                    calc_passi_eff_value_duan1(PassiEff,Lv);
                2 ->
                    calc_passi_eff_value_duan2(PassiEff,Lv);
                _ ->
                    calc_passi_eff_add_value(PassiEff, Lv, ?EN_REDUCE_HP_LIM_BY_RATE)
            end,
    OldVal = Attrs#attrs.hp_lim_rate,
    NewVal = OldVal - Value,
    Attrs#attrs{hp_lim_rate = NewVal};

calc_one_passi_eff(?EN_ADD_HP_LIM_BY_RATE, Attrs, PassiEff, Lv) ->
    % AddVal = calc_passi_eff_add_value(PassiEff, Lv, ?ATTR_PHY_ATT),
    Op = PassiEff#passi_eff.op,

    Value = case Op of
                1 ->
                    calc_passi_eff_value_duan1(PassiEff,Lv);
                2 ->
                    calc_passi_eff_value_duan2(PassiEff,Lv);
                _ ->
                    calc_passi_eff_add_value(PassiEff, Lv, ?EN_ADD_HP_LIM_BY_RATE)
            end,
    OldVal = Attrs#attrs.hp_lim_rate,
    NewVal = OldVal + Value,
    Attrs#attrs{hp_lim_rate = NewVal};



calc_one_passi_eff(?EN_ADD_MAG_ATT, Attrs, PassiEff, Lv) ->
    % AddVal = calc_passi_eff_add_value(PassiEff, Lv, ?ATTR_MAG_ATT),

    Op = PassiEff#passi_eff.op,
    
    Value = case Op of 
        1 -> 
            calc_passi_eff_value_duan1(PassiEff,Lv);
        2 ->
            calc_passi_eff_value_duan2(PassiEff,Lv);
        _ -> 
            calc_passi_eff_add_value(PassiEff, Lv, ?EN_ADD_MAG_ATT)
    end,


    OldVal = Attrs#attrs.mag_att,
    NewVal = OldVal + Value,
    Attrs#attrs{mag_att = NewVal};

calc_one_passi_eff(?EN_ADD_PHY_DEF, Attrs, PassiEff, Lv) ->
    % AddVal = calc_passi_eff_add_value(PassiEff, Lv, ?ATTR_PHY_DEF),

    Op = PassiEff#passi_eff.op,
    
    Value = case Op of 
        1 -> 
            calc_passi_eff_value_duan1(PassiEff,Lv);
        2 ->
            calc_passi_eff_value_duan2(PassiEff,Lv);
        _ -> 
            calc_passi_eff_add_value(PassiEff, Lv, ?EN_ADD_PHY_DEF)
    end,


    OldVal = Attrs#attrs.phy_def,
    NewVal = OldVal + Value,
    Attrs#attrs{phy_def = NewVal};

calc_one_passi_eff(?EN_ADD_MAG_DEF, Attrs, PassiEff, Lv) ->
    % AddVal = calc_passi_eff_add_value(PassiEff, Lv, ?ATTR_MAG_DEF),

    Op = PassiEff#passi_eff.op,
    
    Value = case Op of 
        1 -> 
            calc_passi_eff_value_duan1(PassiEff,Lv);
        2 ->
            calc_passi_eff_value_duan2(PassiEff,Lv);
        _ -> 
            calc_passi_eff_add_value(PassiEff, Lv, ?EN_ADD_MAG_DEF)
    end,


    OldVal = Attrs#attrs.mag_def,
    NewVal = OldVal + Value,
    Attrs#attrs{mag_def = NewVal};

calc_one_passi_eff(?EN_ADD_NEGLECT_RER_DAM, Attrs, PassiEff, Lv) ->
    % AddVal = calc_passi_eff_add_value(PassiEff, Lv, ?ATTR_MAG_DEF),

    Op = PassiEff#passi_eff.op,

    Value = case Op of
                1 ->
                    calc_passi_eff_value_duan1(PassiEff,Lv);
                2 ->
                    calc_passi_eff_value_duan2(PassiEff,Lv);
                _ ->
                    calc_passi_eff_add_value(PassiEff, Lv, ?EN_ADD_NEGLECT_RER_DAM)
            end,


    OldVal = Attrs#attrs.neglect_ret_dam,
    NewVal = OldVal + Value,
    ?DEBUG_MSG("wjctestretdam ~p~n",[NewVal]),
    Attrs#attrs{neglect_ret_dam = NewVal};


% 增加速度
calc_one_passi_eff(?EN_ADD_ACT_SPEED, Attrs, PassiEff, Lv) ->
    Op = PassiEff#passi_eff.op,

    Value = case Op of 
        1 -> 
            calc_passi_eff_value_duan1(PassiEff,Lv);
        2 ->
            calc_passi_eff_value_duan2(PassiEff,Lv);
        _ -> 
            calc_passi_eff_add_value(PassiEff, Lv, ?ATTR_ACT_SPEED)
    end,

    OldVal = Attrs#attrs.act_speed,
    NewVal = OldVal + Value,
    Attrs#attrs{act_speed = NewVal};

% 减少速度
calc_one_passi_eff(?EN_REDUCE_ACT_SPEED, Attrs, PassiEff, Lv) ->
    Op = PassiEff#passi_eff.op,
    
    Value = case Op of 
        1 -> 
            calc_passi_eff_value_duan1(PassiEff,Lv);
        2 ->
            calc_passi_eff_value_duan2(PassiEff,Lv);
        _ -> 
            calc_passi_eff_add_value(PassiEff, Lv, ?ATTR_ACT_SPEED)
    end,

    OldVal = Attrs#attrs.act_speed,
    NewVal = OldVal - Value,
    Attrs#attrs{act_speed = NewVal};


% calc_one_passi_eff(?EN_REDUCE_ACT_SPEED, Attrs, PassiEff, Lv) ->
%     ReduceVal = calc_passi_eff_reduce_value(PassiEff, Lv, ?ATTR_ACT_SPEED),
%     OldVal = Attrs#attrs.act_speed,
%     NewVal = max(OldVal - ReduceVal, 0),  % max矫正一下，避免为负值
%     Attrs#attrs{act_speed = NewVal};

calc_one_passi_eff(?EN_ADD_HIT, Attrs, PassiEff, Lv) ->
    AddVal = calc_passi_eff_add_value(PassiEff, Lv, ?ATTR_HIT),
    OldVal = Attrs#attrs.hit,
    NewVal = OldVal + AddVal,
    Attrs#attrs{hit = NewVal};

calc_one_passi_eff(?EN_ADD_DODGE, Attrs, PassiEff, Lv) ->
    AddVal = calc_passi_eff_add_value(PassiEff, Lv, ?ATTR_DODGE),
    OldVal = Attrs#attrs.dodge,
    NewVal = OldVal + AddVal,
    Attrs#attrs{dodge = NewVal};

% 被动效果增加暴击 双系暴击
calc_one_passi_eff(?EN_ADD_CRIT, Attrs, PassiEff, Lv) ->
    Op = PassiEff#passi_eff.op,
    
    Value = case Op of 
        1 -> 
            calc_passi_eff_value_duan1(PassiEff,Lv);
        2 ->
            calc_passi_eff_value_duan2(PassiEff,Lv);
        _ -> 
            calc_passi_eff_add_value(PassiEff, Lv, ?EN_ADD_CRIT)
    end,

    OldPhyVal = Attrs#attrs.phy_crit,
    NewPhyVal = OldPhyVal + Value,

    OldMagVal = Attrs#attrs.mag_crit,
    NewMagVal = OldMagVal + Value,
    Attrs#attrs{phy_crit = NewPhyVal,mag_crit = NewMagVal};

% 被动效果增加暴击 物理暴击
calc_one_passi_eff(?EN_ADD_PHY_CRIT, Attrs, PassiEff, Lv) ->
    Op = PassiEff#passi_eff.op,

    Value = case Op of
                1 ->
                    calc_passi_eff_value_duan1(PassiEff,Lv);
                2 ->
                    calc_passi_eff_value_duan2(PassiEff,Lv);
                _ ->
                    calc_passi_eff_add_value(PassiEff, Lv, ?EN_ADD_PHY_CRIT)
            end,

    OldPhyVal = Attrs#attrs.phy_crit,
    NewPhyVal = OldPhyVal + Value,
    Attrs#attrs{phy_crit = NewPhyVal};
% 被动效果减少暴击 物理暴击
calc_one_passi_eff(?EN_REDUCE_PHY_CRIT, Attrs, PassiEff, Lv) ->
    Op = PassiEff#passi_eff.op,

    Value = case Op of
                1 ->
                    calc_passi_eff_value_duan1(PassiEff,Lv);
                2 ->
                    calc_passi_eff_value_duan2(PassiEff,Lv);
                _ ->
                    calc_passi_eff_add_value(PassiEff, Lv, ?EN_REDUCE_PHY_CRIT)
            end,

    OldPhyVal = Attrs#attrs.phy_crit,
    NewPhyVal = min(0,OldPhyVal - Value),
    Attrs#attrs{phy_crit = NewPhyVal};

calc_one_passi_eff(?EN_ADD_MAG_CRIT, Attrs, PassiEff, Lv) ->
    Op = PassiEff#passi_eff.op,

    Value = case Op of
                1 ->
                    calc_passi_eff_value_duan1(PassiEff,Lv);
                2 ->
                    calc_passi_eff_value_duan2(PassiEff,Lv);
                _ ->
                    calc_passi_eff_add_value(PassiEff, Lv, ?EN_ADD_MAG_CRIT)
            end,

    OldPhyVal = Attrs#attrs.mag_crit,
    NewPhyVal = OldPhyVal + Value,
    Attrs#attrs{mag_crit = NewPhyVal};
% 被动效果减少暴击 物理暴击
calc_one_passi_eff(?EN_REDUCE_MAG_CRIT, Attrs, PassiEff, Lv) ->
    Op = PassiEff#passi_eff.op,

    Value = case Op of
                1 ->
                    calc_passi_eff_value_duan1(PassiEff,Lv);
                2 ->
                    calc_passi_eff_value_duan2(PassiEff,Lv);
                _ ->
                    calc_passi_eff_add_value(PassiEff, Lv, ?EN_REDUCE_MAG_CRIT)
            end,

    OldPhyVal = Attrs#attrs.mag_crit,
    NewPhyVal = min(0,OldPhyVal - Value),
    Attrs#attrs{mag_crit = NewPhyVal};


calc_one_passi_eff(?EN_ADD_PHY_TEN, Attrs, PassiEff, Lv) ->
    Op = PassiEff#passi_eff.op,

    Value = case Op of
                1 ->
                    calc_passi_eff_value_duan1(PassiEff,Lv);
                2 ->
                    calc_passi_eff_value_duan2(PassiEff,Lv);
                _ ->
                    calc_passi_eff_add_value(PassiEff, Lv, ?EN_ADD_PHY_TEN)
            end,

    OldPhyVal = Attrs#attrs.phy_ten,
    NewPhyVal = OldPhyVal + Value,
    Attrs#attrs{phy_ten = NewPhyVal};


calc_one_passi_eff(?EN_REDUCE_PHY_TEN, Attrs, PassiEff, Lv) ->
    Op = PassiEff#passi_eff.op,

    Value = case Op of
                1 ->
                    calc_passi_eff_value_duan1(PassiEff,Lv);
                2 ->
                    calc_passi_eff_value_duan2(PassiEff,Lv);
                _ ->
                    calc_passi_eff_add_value(PassiEff, Lv, ?EN_REDUCE_PHY_TEN)
            end,

    OldPhyVal = Attrs#attrs.phy_ten,
    NewPhyVal = min(0,OldPhyVal - Value),
    Attrs#attrs{phy_ten = NewPhyVal};

calc_one_passi_eff(?EN_ADD_MAG_TEN, Attrs, PassiEff, Lv) ->
    Op = PassiEff#passi_eff.op,

    Value = case Op of
                1 ->
                    calc_passi_eff_value_duan1(PassiEff,Lv);
                2 ->
                    calc_passi_eff_value_duan2(PassiEff,Lv);
                _ ->
                    calc_passi_eff_add_value(PassiEff, Lv, ?EN_ADD_MAG_TEN)
            end,

    OldPhyVal = Attrs#attrs.mag_ten,
    NewPhyVal = OldPhyVal + Value,
    Attrs#attrs{mag_ten = NewPhyVal};


calc_one_passi_eff(?EN_REDUCE_MAG_TEN, Attrs, PassiEff, Lv) ->
    Op = PassiEff#passi_eff.op,

    Value = case Op of
                1 ->
                    calc_passi_eff_value_duan1(PassiEff,Lv);
                2 ->
                    calc_passi_eff_value_duan2(PassiEff,Lv);
                _ ->
                    calc_passi_eff_add_value(PassiEff, Lv, ?EN_REDUCE_MAG_TEN)
            end,

    OldPhyVal = Attrs#attrs.mag_ten,
    NewPhyVal = min(0,OldPhyVal - Value),
    Attrs#attrs{mag_ten = NewPhyVal};

calc_one_passi_eff(?EN_ADD_SEAL_HIT, Attrs, PassiEff, Lv) ->
    Op = PassiEff#passi_eff.op,

    Value = case Op of
                1 ->
                    calc_passi_eff_value_duan1(PassiEff,Lv);
                2 ->
                    calc_passi_eff_value_duan2(PassiEff,Lv);
                _ ->
                    calc_passi_eff_add_value(PassiEff, Lv, ?EN_ADD_SEAL_HIT)
            end,

    OldPhyVal = Attrs#attrs.seal_hit,
    NewPhyVal =OldPhyVal + Value,
    Attrs#attrs{seal_hit = NewPhyVal};

calc_one_passi_eff(?EN_REDUCE_SEAL_HIT_BY_RATE, Attrs, PassiEff, Lv) ->
    Op = PassiEff#passi_eff.op,

    Value = case Op of
                1 ->
                    calc_passi_eff_value_duan1(PassiEff,Lv);
                2 ->
                    calc_passi_eff_value_duan2(PassiEff,Lv);
                _ ->
                    calc_passi_eff_add_value(PassiEff, Lv, ?EN_REDUCE_SEAL_HIT_BY_RATE)
            end,

    OldPhyVal = Attrs#attrs.seal_hit_rate,
    NewPhyVal =  min(0,OldPhyVal - Value),
    Attrs#attrs{seal_hit_rate = NewPhyVal};

calc_one_passi_eff(?EN_ADD_SEAL_HIT_BY_RATE, Attrs, PassiEff, Lv) ->
    Op = PassiEff#passi_eff.op,

    Value = case Op of
                1 ->
                    calc_passi_eff_value_duan1(PassiEff,Lv);
                2 ->
                    calc_passi_eff_value_duan2(PassiEff,Lv);
                _ ->
                    calc_passi_eff_add_value(PassiEff, Lv, ?EN_ADD_SEAL_HIT_BY_RATE)
            end,

    OldPhyVal = Attrs#attrs.seal_hit_rate,
    NewPhyVal =OldPhyVal + Value,
    Attrs#attrs{seal_hit_rate = NewPhyVal};

calc_one_passi_eff(?EN_ADD_SEAL_RESIS, Attrs, PassiEff, Lv) ->
    Op = PassiEff#passi_eff.op,

    Value = case Op of
                1 ->
                    calc_passi_eff_value_duan1(PassiEff,Lv);
                2 ->
                    calc_passi_eff_value_duan2(PassiEff,Lv);
                _ ->
                    calc_passi_eff_add_value(PassiEff, Lv, ?EN_ADD_SEAL_RESIS)
            end,

    OldPhyVal = Attrs#attrs.seal_resis,
    NewPhyVal =OldPhyVal + Value,
    Attrs#attrs{seal_resis  = NewPhyVal};

calc_one_passi_eff(?EN_REDUCE_SEAL_RESIS_BY_RATE, Attrs, PassiEff, Lv) ->
    Op = PassiEff#passi_eff.op,

    Value = case Op of
                1 ->
                    calc_passi_eff_value_duan1(PassiEff,Lv);
                2 ->
                    calc_passi_eff_value_duan2(PassiEff,Lv);
                _ ->
                    calc_passi_eff_add_value(PassiEff, Lv, ?EN_REDUCE_SEAL_RESIS_BY_RATE)
            end,

    OldPhyVal = Attrs#attrs.seal_resis_rate,
    NewPhyVal =  min(0,OldPhyVal - Value),
    Attrs#attrs{seal_resis_rate = NewPhyVal};

calc_one_passi_eff(?EN_ADD_SEAL_RESIS_BY_RATE, Attrs, PassiEff, Lv) ->
    Op = PassiEff#passi_eff.op,

    Value = case Op of
                1 ->
                    calc_passi_eff_value_duan1(PassiEff,Lv);
                2 ->
                    calc_passi_eff_value_duan2(PassiEff,Lv);
                _ ->
                    calc_passi_eff_add_value(PassiEff, Lv, ?EN_ADD_SEAL_HIT_BY_RATE)
            end,

    OldPhyVal = Attrs#attrs.seal_resis_rate,
    NewPhyVal =OldPhyVal + Value,
    Attrs#attrs{seal_resis_rate = NewPhyVal};

calc_one_passi_eff(?EN_ADD_NEGLECT_SEAL_RESIS, Attrs, PassiEff, Lv) ->
    Op = PassiEff#passi_eff.op,

    Value = case Op of
                1 ->
                    calc_passi_eff_value_duan1(PassiEff,Lv);
                2 ->
                    calc_passi_eff_value_duan2(PassiEff,Lv);
                _ ->
                    calc_passi_eff_add_value(PassiEff, Lv, ?EN_ADD_NEGLECT_SEAL_RESIS)
            end,

    OldPhyVal = Attrs#attrs.neglect_seal_resis,
    NewPhyVal =OldPhyVal + Value,
    Attrs#attrs{neglect_seal_resis  = NewPhyVal};




% 被动效果增加抗暴击 双系抗暴击
calc_one_passi_eff(?EN_ADD_TEN, Attrs, PassiEff, Lv) ->
    Op = PassiEff#passi_eff.op,
    
    Value = case Op of 
        1 -> 
            calc_passi_eff_value_duan1(PassiEff,Lv);
        2 ->
            calc_passi_eff_value_duan2(PassiEff,Lv);
        _ -> 
            calc_passi_eff_add_value(PassiEff, Lv, ?EN_ADD_TEN)
    end,

    OldMagVal = Attrs#attrs.mag_ten,
    NewMagVal = OldMagVal + Value,

    OldPhyVal = Attrs#attrs.phy_ten,
    NewPhyVal = OldPhyVal + Value,

    Attrs#attrs{mag_ten = NewMagVal,phy_ten = NewPhyVal};

calc_one_passi_eff(?EN_ADD_CHAOS_RESIS, Attrs, PassiEff, Lv) ->
    AttrName = ?ATTR_SEAL_RESIS,   % 取标准值时， 统一对应取封印抗性
    AddVal = calc_passi_eff_add_value(PassiEff, Lv, AttrName),
    OldVal = Attrs#attrs.chaos_resis,
    NewVal = OldVal + AddVal,
    Attrs#attrs{chaos_resis = NewVal};

calc_one_passi_eff(?EN_ADD_TRANCE_RESIS, Attrs, PassiEff, Lv) ->
    AttrName = ?ATTR_SEAL_RESIS,   % 取标准值时， 统一对应取封印抗性
    AddVal = calc_passi_eff_add_value(PassiEff, Lv, AttrName),
    OldVal = Attrs#attrs.trance_resis,
    NewVal = OldVal + AddVal,
    Attrs#attrs{trance_resis = NewVal};

calc_one_passi_eff(?EN_ADD_FROZEN_RESIS, Attrs, PassiEff, Lv) ->
    AttrName = ?ATTR_SEAL_RESIS,   % 取标准值时， 统一对应取封印抗性
    AddVal = calc_passi_eff_add_value(PassiEff, Lv, AttrName),
    OldVal = Attrs#attrs.frozen_resis,
    NewVal = OldVal + AddVal,
    Attrs#attrs{frozen_resis = NewVal};

calc_one_passi_eff(?EN_ADD_SEAL_RESIS, Attrs, PassiEff, Lv) ->
    Op = PassiEff#passi_eff.op,
    
    Value = case Op of 
        1 -> 
            calc_passi_eff_value_duan1(PassiEff,Lv);
        2 ->
            calc_passi_eff_value_duan2(PassiEff,Lv);
        _ -> 
            calc_passi_eff_add_value(PassiEff, Lv, ?EN_ADD_SEAL_RESIS)
    end,

    % AddVal = calc_passi_eff_add_value(PassiEff, Lv, ?ATTR_SEAL_RESIS),
    OldVal = Attrs#attrs.seal_resis,
    NewVal = OldVal + Value,
    Attrs#attrs{seal_resis = NewVal};

calc_one_passi_eff(?EN_ADD_STRIKEBACK_PROBA, Attrs, PassiEff, _Lv) ->
    Para = PassiEff#passi_eff.para,
    ?ASSERT(util:is_positive_int(Para) andalso Para =< ?PROBABILITY_BASE, PassiEff),

    OldVal = Attrs#attrs.strikeback_proba,
    NewVal = min(OldVal + Para, ?PROBABILITY_BASE),  % 做min矫正，避免溢出
    Attrs#attrs{strikeback_proba = NewVal};

calc_one_passi_eff(?EN_ADD_PHY_COMBO_ATT_PROBA, Attrs, PassiEff, _Lv) ->
    Para = PassiEff#passi_eff.para,
    ?ASSERT(util:is_positive_int(Para) andalso Para =< ?PROBABILITY_BASE, PassiEff),

    OldVal = Attrs#attrs.phy_combo_att_proba,
    NewVal = min(OldVal + Para, ?PROBABILITY_BASE),  % 做min矫正，避免溢出
    Attrs#attrs{phy_combo_att_proba = NewVal};

calc_one_passi_eff(?EN_ADD_MAG_COMBO_ATT_PROBA, Attrs, PassiEff, _Lv) ->
    Para = PassiEff#passi_eff.para,
    ?ASSERT(util:is_positive_int(Para) andalso Para =< ?PROBABILITY_BASE, PassiEff),

    OldVal = Attrs#attrs.mag_combo_att_proba,
    NewVal = min(OldVal + Para, ?PROBABILITY_BASE),  % 做min矫正，避免溢出
    Attrs#attrs{mag_combo_att_proba = NewVal};

calc_one_passi_eff(?EN_ADD_PURSUE_ATT_PROBA, Attrs, PassiEff, _Lv) ->
    Para = PassiEff#passi_eff.para,
    ?ASSERT(util:is_positive_int(Para) andalso Para =< ?PROBABILITY_BASE, PassiEff),

    OldVal = Attrs#attrs.pursue_att_proba,
    NewVal = min(OldVal + Para, ?PROBABILITY_BASE),  % 做min矫正，避免溢出
    Attrs#attrs{pursue_att_proba = NewVal};

calc_one_passi_eff(?EN_ADD_RET_DAM_PROBA, Attrs, PassiEff, _Lv) ->
    Para = PassiEff#passi_eff.para,
    ?ASSERT(util:is_positive_int(Para) andalso Para =< ?PROBABILITY_BASE, PassiEff),

    OldVal = Attrs#attrs.ret_dam_proba,
    NewVal = min(OldVal + Para, ?PROBABILITY_BASE),  % 做min矫正，避免溢出
    Attrs#attrs{ret_dam_proba = NewVal};

calc_one_passi_eff(?EN_ADD_BE_HEAL_EFF_COEF, Attrs, PassiEff, _Lv) ->
    Para = PassiEff#passi_eff.para,
    ?ASSERT(Para > 0, PassiEff),

    OldVal = Attrs#attrs.be_heal_eff_coef,
    NewVal = OldVal + Para,
    Attrs#attrs{be_heal_eff_coef = NewVal};

calc_one_passi_eff(?EN_ADD_HEAL_EFF_COEF, Attrs, PassiEff, _Lv) ->
  Para = PassiEff#passi_eff.para,
  ?ASSERT(Para > 0, PassiEff),

  OldVal = Attrs#attrs.heal_eff_coef,
  NewVal = OldVal + Para,
  Attrs#attrs{heal_eff_coef = NewVal};

calc_one_passi_eff(?EN_ADD_REVIVE_HEAL_COEF, Attrs, PassiEff, _Lv) ->
  Para = PassiEff#passi_eff.para,
  ?ASSERT(Para > 0, PassiEff),

  OldVal = Attrs#attrs.revive_heal_coef,
  NewVal = OldVal + Para,
  Attrs#attrs{revive_heal_coef = NewVal};

calc_one_passi_eff(?EN_REDUCE_PURSUE_ATT_DAM_COEF, Attrs, PassiEff, _Lv) ->
  Para = PassiEff#passi_eff.para,
  ?ASSERT(Para > 0, PassiEff),

  OldVal = Attrs#attrs.reduce_pursue_att_dam_coef,
  NewVal = OldVal + Para,
  Attrs#attrs{reduce_pursue_att_dam_coef = NewVal};



calc_one_passi_eff(?EN_REDUCE_HEAL_EFF_COEF, Attrs, PassiEff, _Lv) ->
  Para = PassiEff#passi_eff.para,
  ?ASSERT(Para > 0, PassiEff),

  OldVal = Attrs#attrs.heal_eff_coef,
  NewVal = util:floor(OldVal - Para),
  Attrs#attrs{heal_eff_coef = NewVal};


calc_one_passi_eff(?EN_REDUCE_BE_HEAL_EFF_COEF, Attrs, PassiEff, _Lv) ->
    Para = PassiEff#passi_eff.para,
    ?ASSERT(Para > 0 andalso Para =< 1, PassiEff),

    OldVal = Attrs#attrs.be_heal_eff_coef,
    NewVal = max(OldVal - Para, 0),  % 做max矫正，避免为负值
    Attrs#attrs{be_heal_eff_coef = NewVal};

calc_one_passi_eff(?EN_ADD_DO_PHY_DAM_SCALING, Attrs, PassiEff, _Lv) ->
    Para = PassiEff#passi_eff.para,
    ?ASSERT(Para > 0, PassiEff),

    OldVal = Attrs#attrs.do_phy_dam_scaling,
    NewVal = OldVal + Para,
    Attrs#attrs{do_phy_dam_scaling = NewVal};

calc_one_passi_eff(?EN_ADD_DO_MAG_DAM_SCALING, Attrs, PassiEff, _Lv) ->
    Para = PassiEff#passi_eff.para,
    ?ASSERT(Para > 0, PassiEff),

    OldVal = Attrs#attrs.do_mag_dam_scaling,
    NewVal = OldVal + Para,
    Attrs#attrs{do_mag_dam_scaling = NewVal};

calc_one_passi_eff(?EN_ADD_DO_DAM_SCALING, Attrs, PassiEff, _Lv) ->
    Para = PassiEff#passi_eff.para,
    ?ASSERT(Para > 0, PassiEff),

    OldVal1 = Attrs#attrs.do_phy_dam_scaling,
    OldVal2 = Attrs#attrs.do_mag_dam_scaling,

    NewVal1 = OldVal1 + Para,
    NewVal2 = OldVal2 + Para,
    Attrs#attrs{
                do_phy_dam_scaling = NewVal1,
                do_mag_dam_scaling = NewVal2
                };

% 新增被动效果
calc_one_passi_eff(?EN_ADD_NEGLECT_PHY_DEF, Attrs, PassiEff, _Lv) ->
    Para = PassiEff#passi_eff.para,
    ?ASSERT(Para > 0 andalso Para =< 10000, PassiEff),

    OldVal = Attrs#attrs.neglect_phy_def,
    NewVal = util:minmax(OldVal + Para, 0,10000),  % 做max矫正，避免为负值
    Attrs#attrs{neglect_phy_def = NewVal};

calc_one_passi_eff(?EN_ADD_NEGLECT_MAG_DEF, Attrs, PassiEff, _Lv) ->
    Para = PassiEff#passi_eff.para,
    ?ASSERT(Para > 0 andalso Para =< 10000, PassiEff),

    OldVal = Attrs#attrs.neglect_mag_def,
    NewVal = util:minmax(OldVal + Para, 0,10000),  % 做max矫正，避免为负值
    Attrs#attrs{neglect_mag_def = NewVal};

calc_one_passi_eff(?EN_ADD_PHY_DAM_TO_MON, Attrs, PassiEff, _Lv) ->
    Para = PassiEff#passi_eff.para,
    ?ASSERT(Para > 0 andalso Para =< 10000, PassiEff),

    OldVal = Attrs#attrs.phy_dam_to_mon,
    NewVal = util:minmax(OldVal + Para, 0,50000),  % 做max矫正，避免为负值
    Attrs#attrs{phy_dam_to_mon = NewVal};

calc_one_passi_eff(?EN_ADD_MAG_DAM_TO_MON, Attrs, PassiEff, _Lv) ->
    Para = PassiEff#passi_eff.para,
    ?ASSERT(Para > 0 andalso Para =< 10000, PassiEff),

    OldVal = Attrs#attrs.mag_dam_to_mon,
    NewVal = util:minmax(OldVal + Para, 0,50000),  % 做max矫正，避免为负值
    Attrs#attrs{mag_dam_to_mon = NewVal};


calc_one_passi_eff(?EN_PHY_CRIT_COEF, Attrs, PassiEff, _Lv) ->
    Para = PassiEff#passi_eff.para,
    ?ASSERT(Para > 0 andalso Para =< 10000, PassiEff),

    OldVal = Attrs#attrs.phy_crit_coef,
    NewVal = util:minmax(OldVal + Para, 0,50000),  % 做max矫正，避免为负值
    Attrs#attrs{phy_crit_coef = NewVal};

calc_one_passi_eff(?EN_MAG_CRIT_COEF, Attrs, PassiEff, _Lv) ->
    Para = PassiEff#passi_eff.para,
    ?ASSERT(Para > 0 andalso Para =< 10000, PassiEff),

    OldVal = Attrs#attrs.mag_crit_coef,
    NewVal = util:minmax(OldVal + Para, 0,50000),  % 做max矫正，避免为负值
    Attrs#attrs{mag_crit_coef = NewVal};

calc_one_passi_eff(?EN_REDUCE_PHY_CRIT_COEF, Attrs, PassiEff, _Lv) ->
  Para = PassiEff#passi_eff.para,
  ?ASSERT(Para > 0 andalso Para =< 10000, PassiEff),

  OldVal = Attrs#attrs.phy_crit_coef,
  NewVal = util:minmax(OldVal - Para, 0,50000),  % 做max矫正，避免为负值
  Attrs#attrs{phy_crit_coef = NewVal};

calc_one_passi_eff(?EN_REDUCE_MAG_CRIT_COEF, Attrs, PassiEff, _Lv) ->
  Para = PassiEff#passi_eff.para,
  ?ASSERT(Para > 0 andalso Para =< 10000, PassiEff),

  OldVal = Attrs#attrs.mag_crit_coef,
  NewVal = util:minmax(OldVal - Para, 0,50000),  % 做max矫正，避免为负值
  Attrs#attrs{mag_crit_coef = NewVal};

% ---------------------------------------------------------


calc_one_passi_eff(?EN_REDUCE_DO_PHY_DAM_SCALING, Attrs, PassiEff, _Lv) ->
    Para = PassiEff#passi_eff.para,
    ?ASSERT(Para > 0 andalso Para =< 1, PassiEff),

    OldVal = Attrs#attrs.do_phy_dam_scaling,
    NewVal = max(OldVal - Para, -1),  % 做max矫正，避免为负值
    Attrs#attrs{do_phy_dam_scaling = NewVal};

calc_one_passi_eff(?EN_REDUCE_DO_MAG_DAM_SCALING, Attrs, PassiEff, _Lv) ->
    Para = PassiEff#passi_eff.para,
    ?ASSERT(Para > 0 andalso Para =< 1, PassiEff),

    OldVal = Attrs#attrs.do_mag_dam_scaling,
    NewVal = max(OldVal - Para, -1),  % 做max矫正，避免为负值
    Attrs#attrs{do_mag_dam_scaling = NewVal};

calc_one_passi_eff(?EN_REDUCE_DO_DAM_SCALING, Attrs, PassiEff, _Lv) ->
    Para = PassiEff#passi_eff.para,
    ?ASSERT(Para > 0 andalso Para =< 1, PassiEff),

    OldVal1 = Attrs#attrs.do_phy_dam_scaling,
    OldVal2 = Attrs#attrs.do_mag_dam_scaling,
    
    NewVal1 = max(OldVal1 - Para, -1),  % 做max矫正，避免为负值
    NewVal2 = max(OldVal2 - Para, -1),  % 做max矫正，避免为负值
    Attrs#attrs{
                do_phy_dam_scaling = NewVal1,
                do_mag_dam_scaling = NewVal2
                };


calc_one_passi_eff(?EN_ADD_BE_PHY_DAM_REDUCE_COEF, Attrs, PassiEff, _Lv) ->
    Para = PassiEff#passi_eff.para,
    ?ASSERT(Para > 0 andalso Para =< 1, PassiEff),

    OldVal = Attrs#attrs.be_phy_dam_reduce_coef,
    NewVal = min(1 - (1 - OldVal) * (1 - Para) , 1),  % 做矫正，避免溢出
    Attrs#attrs{be_phy_dam_reduce_coef = NewVal};

calc_one_passi_eff(?EN_ADD_BE_MAG_DAM_REDUCE_COEF, Attrs, PassiEff, _Lv) ->
    Para = PassiEff#passi_eff.para,
    ?ASSERT(Para > 0 andalso Para =< 1, PassiEff),

    OldVal = Attrs#attrs.be_mag_dam_reduce_coef,
    NewVal = min(1 - (1 - OldVal) * (1 - Para) , 1),  % 做矫正，避免溢出
    Attrs#attrs{be_mag_dam_reduce_coef = NewVal};

calc_one_passi_eff(?EN_ADD_BE_DAM_REDUCE_COEF, Attrs, PassiEff, _Lv) ->
    Para = PassiEff#passi_eff.para,
    ?ASSERT(Para > 0 andalso Para =< 1, PassiEff),

    OldVal1 = Attrs#attrs.be_phy_dam_reduce_coef,
    OldVal2 = Attrs#attrs.be_mag_dam_reduce_coef,

    NewVal1 = min(OldVal1 + Para, 1),  % 做矫正，避免溢出
    NewVal2 = min(OldVal2 + Para, 1),  % 做矫正，避免溢出
    Attrs#attrs{
            be_phy_dam_reduce_coef = NewVal1,
            be_mag_dam_reduce_coef = NewVal2
            };

calc_one_passi_eff(?EN_REDUCE_BE_PHY_DAM_REDUCE_COEF, Attrs, PassiEff, _Lv) ->
    Para = PassiEff#passi_eff.para,
    ?ASSERT(Para > 0, PassiEff),

    OldVal = Attrs#attrs.be_phy_dam_reduce_coef,
    NewVal = OldVal - Para,
    Attrs#attrs{be_phy_dam_reduce_coef = NewVal};


calc_one_passi_eff(?EN_REDUCE_BE_MAG_DAM_REDUCE_COEF, Attrs, PassiEff, _Lv) ->
    Para = PassiEff#passi_eff.para,
    ?ASSERT(Para > 0, PassiEff),

    OldVal = Attrs#attrs.be_mag_dam_reduce_coef,
    NewVal = OldVal - Para,
    Attrs#attrs{be_mag_dam_reduce_coef = NewVal};

calc_one_passi_eff(?EN_REDUCE_BE_DAM_REDUCE_COEF, Attrs, PassiEff, _Lv) ->
    Para = PassiEff#passi_eff.para,
    ?ASSERT(Para > 0, PassiEff),

    OldVal1 = Attrs#attrs.be_phy_dam_reduce_coef,
    OldVal2 = Attrs#attrs.be_mag_dam_reduce_coef,
    NewVal1 = OldVal1 - Para,
    NewVal2 = OldVal2 - Para,
    Attrs#attrs{
            be_phy_dam_reduce_coef = NewVal1,
            be_mag_dam_reduce_coef = NewVal2
            };


calc_one_passi_eff(?EN_ADD_RET_DAM_COEF, Attrs, PassiEff, _Lv) ->
    Para = PassiEff#passi_eff.para,
    ?ASSERT(Para > 0, PassiEff),

    OldVal = Attrs#attrs.ret_dam_coef,
    NewVal = OldVal + Para,
    Attrs#attrs{ret_dam_coef = NewVal};

calc_one_passi_eff(?EN_ADD_PURSUE_ATT_DAM_COEF, Attrs, PassiEff, _Lv) ->
    Para = PassiEff#passi_eff.para,
    ?ASSERT(Para > 0, PassiEff),

    OldVal = Attrs#attrs.pursue_att_dam_coef,
    NewVal = OldVal + Para,
    Attrs#attrs{pursue_att_dam_coef = NewVal};


calc_one_passi_eff(?EN_ADD_ABSORB_HP_COEF, Attrs, PassiEff, _Lv) ->
    Para = PassiEff#passi_eff.para,
    ?ASSERT(Para > 0, PassiEff),
    
    OldVal = Attrs#attrs.absorb_hp_coef,
    NewVal = OldVal + Para,
    Attrs#attrs{absorb_hp_coef = NewVal};

calc_one_passi_eff(?EN_ADD_QUGUI_COEF, Attrs, PassiEff, _Lv) ->
    Para = PassiEff#passi_eff.para,
    ?ASSERT(Para >= 0, PassiEff),
    
    OldVal = Attrs#attrs.qugui_coef,
    NewVal = OldVal + Para,
    Attrs#attrs{qugui_coef = NewVal};


calc_one_passi_eff(_Other, Attrs, _PassiEff, _Lv) ->  % 其他，不做处理
    Attrs.




% 计算方式1
calc_passi_eff_value_duan1(PassiEff, _Lv) ->
    Para = PassiEff#passi_eff.para,
    ?ASSERT(Para > 0, PassiEff),
    Para.

% 计算方式2
calc_passi_eff_value_duan2(PassiEff, Lv) ->
    Para = PassiEff#passi_eff.para,
    Para2 = PassiEff#passi_eff.para2,
    ?ASSERT(Para > 0, PassiEff),
    ?ASSERT(Para2 > 0, PassiEff),
    AddVal = Para * Lv + Para2,
    ?ASSERT(AddVal >= 0, {AddVal, Para, Para2, PassiEff}),
    AddVal.


calc_passi_eff_add_value(PassiEff, Lv, AttrName) ->
    Para = PassiEff#passi_eff.para,
    ?ASSERT(Para > 0, PassiEff),
    StdVal = mod_xinfa:get_std_value(Lv, AttrName), % 等级当做心法等级，取对应的标准值
    AddVal = erlang:round(Para * StdVal),
    ?ASSERT(AddVal >= 0, {AddVal, Para, StdVal, PassiEff}),
    AddVal.


calc_passi_eff_reduce_value(PassiEff, Lv, AttrName) ->
    Para = PassiEff#passi_eff.para,
    ?ASSERT(Para > 0, PassiEff),
    StdVal = mod_xinfa:get_std_value(Lv, AttrName), % 将等级当做心法等级，取对应的标准值
    ReduceVal = erlang:round(Para * StdVal),
    ?ASSERT(ReduceVal >= 0, {ReduceVal, Para, StdVal, PassiEff}),
    ReduceVal.


                    