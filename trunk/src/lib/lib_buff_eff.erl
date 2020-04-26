%%%--------------------------------------
%%% @Module  : lib_buff_eff
%%% @Author  : zhangwq
%%% @Email   : 
%%% @Created : 2014.3.20
%%% @Description : buff的效果
%%%--------------------------------------
-module(lib_buff_eff).

-export([
            calc_one_buff_eff/2
            %%其他 ...
            

             
    ]).

-include("common.hrl").
-include("record.hrl").
-include("effect.hrl").
-include("attribute.hrl").

    
%% return attrs 结构体

calc_one_buff_eff(Attrs, BuffNo) ->
    BuffTpl = lib_buff_tpl:get_tpl_data(BuffNo),
    Name = lib_buff_tpl:get_name(BuffTpl),
    calc_one_buff_eff(Name, Attrs, BuffTpl).

calc_one_buff_eff(?EN_ADD_PHY_ATT, Attrs, BuffTpl) ->
    case lib_buff_tpl:get_para(BuffTpl) of 
        null -> Attrs;
        AddVal ->
            OldVal = Attrs#attrs.phy_att,
            NewVal = OldVal + AddVal,
            Attrs#attrs{phy_att = NewVal}
    end;


calc_one_buff_eff(?EN_ADD_HP_LIM_BY_RATE, Attrs, BuffTpl) ->
    case lib_buff_tpl:get_para(BuffTpl) of 
        null -> Attrs;
        AddVal ->
            OldVal = Attrs#attrs.hp_lim,
            NewVal = util:ceil(OldVal * (1 + (AddVal / ?PROBABILITY_BASE_COM))),
            Attrs#attrs{hp_lim = NewVal}
    end;

calc_one_buff_eff(?EN_REDUCE_HP_LIM_BY_RATE, Attrs, BuffTpl) ->
    case lib_buff_tpl:get_para(BuffTpl) of 
        null -> Attrs;
        AddVal ->
            OldVal = Attrs#attrs.hp_lim,
            NewVal = util:ceil(OldVal * (1 - (AddVal / ?PROBABILITY_BASE_COM))),
            Attrs#attrs{hp_lim = NewVal}
    end;

calc_one_buff_eff(?EN_ADD_MP_LIM_BY_RATE, Attrs, BuffTpl) ->
    case lib_buff_tpl:get_para(BuffTpl) of 
        null -> Attrs;
        AddVal ->
            OldVal = Attrs#attrs.mp_lim,
            NewVal = util:ceil(OldVal * (1 + (AddVal / ?PROBABILITY_BASE_COM))),
            Attrs#attrs{mp_lim = NewVal}
    end;

calc_one_buff_eff(?EN_REDUCE_MP_LIM_BY_RATE, Attrs, BuffTpl) ->
    case lib_buff_tpl:get_para(BuffTpl) of 
        null -> Attrs;
        AddVal ->
            OldVal = Attrs#attrs.mp_lim,
            NewVal = util:ceil(OldVal * (1 - (AddVal / ?PROBABILITY_BASE_COM))),
            Attrs#attrs{mp_lim = NewVal}
    end;

calc_one_buff_eff(?EN_ADD_PHY_ATT_BY_RATE, Attrs, BuffTpl) ->
    AddVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.phy_att,
    NewVal = util:ceil(OldVal * (1 + (AddVal / ?PROBABILITY_BASE_COM))),
    Attrs#attrs{phy_att = NewVal};


calc_one_buff_eff(?EN_REDUCE_PHY_ATT_BY_RATE, Attrs, BuffTpl) ->
    AddVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.phy_att,
    NewVal = util:ceil(OldVal * (1 - (AddVal / ?PROBABILITY_BASE_COM))),
    Attrs#attrs{phy_att = NewVal};


calc_one_buff_eff(?EN_ADD_MAG_ATT, Attrs, BuffTpl) ->
    AddVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.mag_att,
    NewVal = OldVal + AddVal,
    Attrs#attrs{mag_att = NewVal};


calc_one_buff_eff(?EN_ADD_MAG_ATT_BY_RATE, Attrs, BuffTpl) ->
    AddVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.mag_att,
    NewVal = util:ceil(OldVal * (1 + (AddVal / ?PROBABILITY_BASE_COM))),
    Attrs#attrs{mag_att = NewVal};

calc_one_buff_eff(?EN_REDUCE_MAG_ATT_BY_RATE, Attrs, BuffTpl) ->
    AddVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.mag_att,
    NewVal = util:ceil(OldVal * (1 - (AddVal / ?PROBABILITY_BASE_COM))),
    Attrs#attrs{mag_att = NewVal};

calc_one_buff_eff(?EN_ADD_PHY_DEF, Attrs, BuffTpl) ->
    AddVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.phy_def,
    NewVal = OldVal + AddVal,
    Attrs#attrs{phy_def = NewVal};

calc_one_buff_eff(?EN_ADD_PHY_DEF_BY_RATE, Attrs, BuffTpl) ->
    AddVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.phy_def,
    NewVal = util:ceil(OldVal * (1 + (AddVal / ?PROBABILITY_BASE_COM))),
    Attrs#attrs{phy_def = NewVal};

calc_one_buff_eff(?EN_REDUCE_PHY_DEF_BY_RATE, Attrs, BuffTpl) ->
    AddVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.phy_def,
    NewVal = util:ceil(OldVal * (1 - (AddVal / ?PROBABILITY_BASE_COM))),
    Attrs#attrs{phy_def = NewVal};

calc_one_buff_eff(?EN_ADD_MAG_DEF, Attrs, BuffTpl) ->
    AddVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.mag_def,
    NewVal = OldVal + AddVal,
    Attrs#attrs{mag_def = NewVal};

calc_one_buff_eff(?EN_ADD_MAG_DEF_BY_RATE, Attrs, BuffTpl) ->
    AddVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.mag_def,
    NewVal = util:ceil(OldVal * (1 + (AddVal / ?PROBABILITY_BASE_COM))),
    Attrs#attrs{mag_def = NewVal};


calc_one_buff_eff(?EN_REDUCE_MAG_DEF_BY_RATE, Attrs, BuffTpl) ->
    AddVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.mag_def,
    NewVal = util:ceil(OldVal * (1 - (AddVal / ?PROBABILITY_BASE_COM))),
    Attrs#attrs{mag_def = NewVal};

calc_one_buff_eff(?EN_ADD_ACT_SPEED, Attrs, BuffTpl) ->
    AddVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.act_speed,
    NewVal = OldVal + AddVal,
    Attrs#attrs{act_speed = NewVal};


calc_one_buff_eff(?EN_ADD_ACT_SPEED_BY_RATE, Attrs, BuffTpl) ->
    AddVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.act_speed,
    NewVal = util:ceil(OldVal * (1 + (AddVal / ?PROBABILITY_BASE_COM))),
    Attrs#attrs{act_speed = NewVal};


calc_one_buff_eff(?EN_REDUCE_ACT_SPEED_BY_RATE, Attrs, BuffTpl) ->
    AddVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.act_speed,
    NewVal = util:ceil(OldVal * (1 - (AddVal / ?PROBABILITY_BASE_COM))),
    Attrs#attrs{act_speed = NewVal};


calc_one_buff_eff(?EN_REDUCE_ACT_SPEED, Attrs, BuffTpl) ->
    ReduceVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.act_speed,
    NewVal = max(OldVal - ReduceVal, 0),  % max矫正一下，避免为负值
    Attrs#attrs{act_speed = NewVal};

calc_one_buff_eff(?EN_ADD_HIT, Attrs, BuffTpl) ->
    AddVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.hit,
    NewVal = OldVal + AddVal,
    Attrs#attrs{hit = NewVal};

calc_one_buff_eff(?EN_ADD_HIT_BY_RATE, Attrs, BuffTpl) ->
    AddVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.hit,
    NewVal = util:ceil(OldVal * (1 + (AddVal / ?PROBABILITY_BASE_COM))),
    Attrs#attrs{hit = NewVal};

calc_one_buff_eff(?EN_REDUCE_HIT_BY_RATE, Attrs, BuffTpl) ->
    AddVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.hit,
    NewVal = util:ceil(OldVal * (1 - (AddVal / ?PROBABILITY_BASE_COM))),
    Attrs#attrs{hit = NewVal};

calc_one_buff_eff(?EN_ADD_DODGE, Attrs, BuffTpl) ->
    AddVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.dodge,
    NewVal = OldVal + AddVal,
    Attrs#attrs{dodge = NewVal};

calc_one_buff_eff(?EN_ADD_DODGE_BY_RATE, Attrs, BuffTpl) ->
    AddVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.dodge,
    NewVal = util:ceil(OldVal * (1 + (AddVal / ?PROBABILITY_BASE_COM))),
    Attrs#attrs{dodge = NewVal};

calc_one_buff_eff(?EN_REDUCE_DODGE_BY_RATE, Attrs, BuffTpl) ->
    AddVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.dodge,
    NewVal = util:ceil(OldVal * (1 - (AddVal / ?PROBABILITY_BASE_COM))),
    Attrs#attrs{dodge = NewVal};

calc_one_buff_eff(?EN_ADD_CRIT, Attrs, BuffTpl) ->
    AddVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.crit,
    NewVal = OldVal + AddVal,
    Attrs#attrs{crit = NewVal};


calc_one_buff_eff(?EN_ADD_PHY_CRIT, Attrs, BuffTpl) ->
    AddVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.phy_crit,
    NewVal = OldVal + AddVal,
    Attrs#attrs{phy_crit = NewVal};

calc_one_buff_eff(?EN_REDUCE_PHY_CRIT, Attrs, BuffTpl) ->
    AddVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.phy_crit,
    NewVal = min(0,OldVal - AddVal),
    Attrs#attrs{phy_crit = NewVal};

calc_one_buff_eff(?EN_ADD_MAG_CRIT, Attrs, BuffTpl) ->
    AddVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.mag_crit,
    NewVal = OldVal + AddVal,
    Attrs#attrs{mag_crit = NewVal};

calc_one_buff_eff(?EN_REDUCE_MAG_CRIT, Attrs, BuffTpl) ->
    AddVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.mag_crit,
    NewVal = min(0,OldVal - AddVal),
    Attrs#attrs{mag_crit = NewVal};

calc_one_buff_eff(?EN_ADD_PHY_TEN, Attrs, BuffTpl) ->
    AddVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.phy_ten,
    NewVal = OldVal + AddVal,
    Attrs#attrs{phy_ten = NewVal};

calc_one_buff_eff(?EN_REDUCE_PHY_TEN, Attrs, BuffTpl) ->
    AddVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.phy_ten,
    NewVal = min(0,OldVal - AddVal),
    Attrs#attrs{phy_ten = NewVal};

calc_one_buff_eff(?EN_ADD_MAG_TEN, Attrs, BuffTpl) ->
    AddVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.mag_ten,
    NewVal = OldVal + AddVal,
    Attrs#attrs{mag_ten = NewVal};

calc_one_buff_eff(?EN_REDUCE_MAG_TEN, Attrs, BuffTpl) ->
    AddVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.mag_ten,
    NewVal = min(0,OldVal - AddVal),
    Attrs#attrs{mag_ten = NewVal};

calc_one_buff_eff(?EN_ADD_SEAL_HIT, Attrs, BuffTpl) ->
    AddVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.seal_hit,
    NewVal = OldVal + AddVal,
    Attrs#attrs{seal_hit  = NewVal};

calc_one_buff_eff(?EN_ADD_SEAL_HIT_BY_RATE, Attrs, BuffTpl) ->
    AddVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.seal_hit_rate,
    NewVal = OldVal + AddVal,
    Attrs#attrs{seal_hit_rate =  NewVal};


calc_one_buff_eff(?EN_REDUCE_SEAL_HIT_BY_RATE, Attrs, BuffTpl) ->
    AddVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.seal_hit_rate,
    NewVal =  min(0,OldVal - AddVal),
    Attrs#attrs{seal_hit_rate =  NewVal};

calc_one_buff_eff(?EN_ADD_SEAL_RESIS, Attrs, BuffTpl) ->
    AddVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.seal_resis,
    NewVal = OldVal + AddVal,
    Attrs#attrs{seal_resis  = NewVal};

calc_one_buff_eff(?EN_ADD_SEAL_RESIS_BY_RATE, Attrs, BuffTpl) ->
    AddVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.seal_resis_rate,
    NewVal = OldVal + AddVal,
    Attrs#attrs{seal_resis_rate =  NewVal};


calc_one_buff_eff(?EN_REDUCE_SEAL_RESIS_BY_RATE, Attrs, BuffTpl) ->
    AddVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.seal_resis_rate,
    NewVal =  min(0,OldVal - AddVal),
    Attrs#attrs{seal_resis_rate =  NewVal};

calc_one_buff_eff(?EN_ADD_NEGLECT_SEAL_RESIS, Attrs, BuffTpl) ->
    AddVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.neglect_seal_resis,
    NewVal = OldVal + AddVal,
    Attrs#attrs{neglect_seal_resis  = NewVal};

calc_one_buff_eff(?EN_ADD_CRIT_BY_RATE, Attrs, BuffTpl) ->
    AddVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.crit,
    NewVal = util:ceil(OldVal * (1 + (AddVal / ?PROBABILITY_BASE_COM))),
    Attrs#attrs{crit = NewVal};

calc_one_buff_eff(?EN_REDUCE_CRIT_BY_RATE, Attrs, BuffTpl) ->
    AddVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.crit,
    NewVal = util:ceil(OldVal * (1 - (AddVal / ?PROBABILITY_BASE_COM))),
    Attrs#attrs{crit = NewVal};

calc_one_buff_eff(?EN_ADD_TEN, Attrs, BuffTpl) ->
    AddVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.ten,
    NewVal = OldVal + AddVal,
    Attrs#attrs{ten = NewVal};

calc_one_buff_eff(?EN_ADD_CHAOS_RESIS, Attrs, BuffTpl) ->
    AddVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.chaos_resis,
    NewVal = OldVal + AddVal,
    Attrs#attrs{chaos_resis = NewVal};

calc_one_buff_eff(?EN_ADD_TRANCE_RESIS, Attrs, BuffTpl) ->
    AddVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.trance_resis,
    NewVal = OldVal + AddVal,
    Attrs#attrs{trance_resis = NewVal};

calc_one_buff_eff(?EN_ADD_FROZEN_RESIS, Attrs, BuffTpl) ->
    AddVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.frozen_resis,
    NewVal = OldVal + AddVal,
    Attrs#attrs{frozen_resis = NewVal};

calc_one_buff_eff(?EN_ADD_SEAL_RESIS, Attrs, BuffTpl) ->
    AddVal = lib_buff_tpl:get_para(BuffTpl),
    OldVal = Attrs#attrs.seal_resis,
    NewVal = OldVal + AddVal,
    Attrs#attrs{seal_resis = NewVal};

calc_one_buff_eff(?EN_ADD_STRIKEBACK_PROBA, Attrs, BuffTpl) ->
    Para = lib_buff_tpl:get_para(BuffTpl),
    ?ASSERT(util:is_positive_int(Para) andalso Para =< ?PROBABILITY_BASE, BuffTpl),

    OldVal = Attrs#attrs.strikeback_proba,
    NewVal = min(OldVal + Para, ?PROBABILITY_BASE),  % 做min矫正，避免溢出
    Attrs#attrs{strikeback_proba = NewVal};


calc_one_buff_eff(?EN_REDUCE_STRIKEBACK_PROBA, Attrs, BuffTpl) ->
    Para = lib_buff_tpl:get_para(BuffTpl),
    ?ASSERT(util:is_positive_int(Para) andalso Para =< ?PROBABILITY_BASE, BuffTpl),

    OldVal = Attrs#attrs.strikeback_proba,
    NewVal = max(OldVal - Para, 0),  
    Attrs#attrs{strikeback_proba = NewVal};


calc_one_buff_eff(?EN_ADD_PHY_COMBO_ATT_PROBA, Attrs, BuffTpl) ->
    Para = lib_buff_tpl:get_para(BuffTpl),
    ?ASSERT(util:is_positive_int(Para) andalso Para =< ?PROBABILITY_BASE, BuffTpl),

    OldVal = Attrs#attrs.phy_combo_att_proba,
    NewVal = min(OldVal + Para, ?PROBABILITY_BASE),  % 做min矫正，避免溢出
    Attrs#attrs{phy_combo_att_proba = NewVal};


calc_one_buff_eff(?EN_REDUCE_PHY_COMBO_ATT_PROBA, Attrs, BuffTpl) ->
    Para = lib_buff_tpl:get_para(BuffTpl),
    ?ASSERT(util:is_positive_int(Para) andalso Para =< ?PROBABILITY_BASE, BuffTpl),

    OldVal = Attrs#attrs.phy_combo_att_proba,
    NewVal = max(OldVal - Para, 0),  % 做min矫正，避免溢出
    Attrs#attrs{phy_combo_att_proba = NewVal};


calc_one_buff_eff(?EN_ADD_MAG_COMBO_ATT_PROBA, Attrs, BuffTpl) ->
    Para = lib_buff_tpl:get_para(BuffTpl),
    ?ASSERT(util:is_positive_int(Para) andalso Para =< ?PROBABILITY_BASE, BuffTpl),

    OldVal = Attrs#attrs.mag_combo_att_proba,
    NewVal = min(OldVal + Para, ?PROBABILITY_BASE),  % 做min矫正，避免溢出
    Attrs#attrs{mag_combo_att_proba = NewVal};


calc_one_buff_eff(?EN_REDUCE_MAG_COMBO_ATT_PROBA, Attrs, BuffTpl) ->
    Para = lib_buff_tpl:get_para(BuffTpl),
    ?ASSERT(util:is_positive_int(Para) andalso Para =< ?PROBABILITY_BASE, BuffTpl),

    OldVal = Attrs#attrs.mag_combo_att_proba,
    NewVal = max(OldVal - Para, 0),  % 做min矫正，避免溢出
    Attrs#attrs{mag_combo_att_proba = NewVal};


calc_one_buff_eff(?EN_ADD_RET_DAM_PROBA, Attrs, BuffTpl) ->
    Para = lib_buff_tpl:get_para(BuffTpl),
    ?ASSERT(util:is_positive_int(Para) andalso Para =< ?PROBABILITY_BASE, BuffTpl),

    OldVal = Attrs#attrs.ret_dam_proba,
    NewVal = min(OldVal + Para, ?PROBABILITY_BASE),  % 做min矫正，避免溢出
    Attrs#attrs{ret_dam_proba = NewVal};

calc_one_buff_eff(?EN_REDUCE_RET_DAM_PROBA, Attrs, BuffTpl) ->
    Para = lib_buff_tpl:get_para(BuffTpl),
    ?ASSERT(util:is_positive_int(Para) andalso Para =< ?PROBABILITY_BASE, BuffTpl),

    OldVal = Attrs#attrs.ret_dam_proba,
    NewVal = max(OldVal - Para, 0),  % 矫正
    Attrs#attrs{ret_dam_proba = NewVal};

calc_one_buff_eff(?EN_ADD_BE_HEAL_EFF_COEF, Attrs, BuffTpl) ->
    Para = lib_buff_tpl:get_para(BuffTpl),
    ?ASSERT(Para > 0, BuffTpl),

    OldVal = Attrs#attrs.be_heal_eff_coef,
    NewVal = OldVal + Para,
    Attrs#attrs{be_heal_eff_coef = NewVal};

% calc_one_buff_eff(?EN_ADD_BE_MAG_DAM_SHRINK, Attrs, BuffTpl) ->
%     Para = lib_buff_tpl:get_para(BuffTpl),
%     ?ASSERT(Para > 0, BuffTpl),

%     OldVal = Attrs#attrs.be_mag_dam_shrink,
%     NewVal = OldVal + Para,
%     Attrs#attrs{be_mag_dam_shrink = NewVal};

% calc_one_buff_eff(?EN_ADD_BE_PHY_DAM_SHRINK, Attrs, BuffTpl) ->
%     Para = lib_buff_tpl:get_para(BuffTpl),
%     ?ASSERT(Para > 0, BuffTpl),

%     OldVal = Attrs#attrs.be_phy_dam_shrink,
%     NewVal = OldVal + Para,
%     Attrs#attrs{be_phy_dam_shrink = NewVal};


calc_one_buff_eff(?EN_REDUCE_BE_HEAL_EFF_COEF, Attrs, BuffTpl) ->
    Para = lib_buff_tpl:get_para(BuffTpl),
    ?ASSERT(Para > 0 andalso Para =< 1, BuffTpl),

    OldVal = Attrs#attrs.be_heal_eff_coef,
    NewVal = max(OldVal - Para, 0),  % 做max矫正，避免为负值
    Attrs#attrs{be_heal_eff_coef = NewVal};

calc_one_buff_eff(?EN_ADD_DO_PHY_DAM_SCALING, Attrs, BuffTpl) ->
    Para = lib_buff_tpl:get_para(BuffTpl),
    % ?ASSERT(Para > 0, BuffTpl),

    OldVal = Attrs#attrs.do_phy_dam_scaling,
    NewVal = OldVal + Para,
    Attrs#attrs{do_phy_dam_scaling = NewVal};

calc_one_buff_eff(?EN_ADD_DO_MAG_DAM_SCALING, Attrs, BuffTpl) ->
    Para = lib_buff_tpl:get_para(BuffTpl),
    % ?ASSERT(Para > 0, BuffTpl),

    OldVal = Attrs#attrs.do_mag_dam_scaling,
    NewVal = OldVal + Para,
    Attrs#attrs{do_mag_dam_scaling = NewVal};

calc_one_buff_eff(?EN_ADD_DO_DAM_SCALING, Attrs, BuffTpl) ->
    Para = lib_buff_tpl:get_para(BuffTpl),
    ?ASSERT(Para > 0, BuffTpl),

    OldVal1 = Attrs#attrs.do_phy_dam_scaling,
    OldVal2 = Attrs#attrs.do_mag_dam_scaling,

    NewVal1 = OldVal1 + Para,
    NewVal2 = OldVal2 + Para,
    Attrs#attrs{
                do_phy_dam_scaling = NewVal1,
                do_mag_dam_scaling = NewVal2
                };

calc_one_buff_eff(?EN_REDUCE_DO_PHY_DAM_SCALING, Attrs, BuffTpl) ->
    Para = lib_buff_tpl:get_para(BuffTpl),
    % ?ASSERT(Para > 0 andalso Para =< 1, BuffTpl),

    OldVal = Attrs#attrs.do_phy_dam_scaling,
    NewVal = max(OldVal - Para, 0),  % 做max矫正，避免为负值
    Attrs#attrs{do_phy_dam_scaling = NewVal};


calc_one_buff_eff(?EN_REDUCE_DO_MAG_DAM_SCALING, Attrs, BuffTpl) ->
    Para = lib_buff_tpl:get_para(BuffTpl),
    % ?ASSERT(Para > 0 andalso Para =< 1, BuffTpl),

    OldVal = Attrs#attrs.do_mag_dam_scaling,
    NewVal = max(OldVal - Para, 0),  % 做max矫正，避免为负值
    Attrs#attrs{do_mag_dam_scaling = NewVal};

calc_one_buff_eff(?EN_REDUCE_DO_DAM_SCALING, Attrs, BuffTpl) ->
    Para = lib_buff_tpl:get_para(BuffTpl),
    ?ASSERT(Para > 0 andalso Para =< 1, BuffTpl),

    OldVal1 = Attrs#attrs.do_phy_dam_scaling,
    OldVal2 = Attrs#attrs.do_mag_dam_scaling,
    
    NewVal1 = max(OldVal1 - Para, 0),  % 做max矫正，避免为负值
    NewVal2 = max(OldVal2 - Para, 0),  % 做max矫正，避免为负值
    Attrs#attrs{
                do_phy_dam_scaling = NewVal1,
                do_mag_dam_scaling = NewVal2
                };

calc_one_buff_eff(?EN_ADD_BE_PHY_DAM_REDUCE_COEF, Attrs, BuffTpl) ->
    Para = lib_buff_tpl:get_para(BuffTpl),
    ?ASSERT(Para > 0 andalso Para =< 1, BuffTpl),

    OldVal = Attrs#attrs.be_phy_dam_reduce_coef,
    NewVal = erlang:max(Attrs#attrs.be_phy_dam_reduce_coef + Para,0),  % 做矫正，避免溢出
    Attrs#attrs{be_phy_dam_reduce_coef = NewVal};

calc_one_buff_eff(?EN_ADD_BE_MAG_DAM_REDUCE_COEF, Attrs, BuffTpl) ->
    Para = lib_buff_tpl:get_para(BuffTpl),
    ?ASSERT(Para > 0 andalso Para =< 1, BuffTpl),

    OldVal = Attrs#attrs.be_mag_dam_reduce_coef,
    % NewVal = min(1 - (1 - OldVal) * (1 - Para) , 1),  % 做矫正，避免溢出
    NewVal = erlang:max(Attrs#attrs.be_mag_dam_reduce_coef + Para,0),  % 做矫正，避免溢出
    Attrs#attrs{be_mag_dam_reduce_coef = NewVal};

calc_one_buff_eff(?EN_ADD_BE_DAM_REDUCE_COEF, Attrs, BuffTpl) ->
    Para = lib_buff_tpl:get_para(BuffTpl),
    ?ASSERT(Para > 0 andalso Para =< 1, BuffTpl),

    OldVal1 = Attrs#attrs.be_phy_dam_reduce_coef,
    OldVal2 = Attrs#attrs.be_mag_dam_reduce_coef,

    NewVal1 = min(OldVal1 + Para, 1),  % 做矫正，避免溢出
    NewVal2 = min(OldVal2 + Para, 1),  % 做矫正，避免溢出
    Attrs#attrs{
            be_phy_dam_reduce_coef = NewVal1,
            be_mag_dam_reduce_coef = NewVal2
            };

calc_one_buff_eff(?EN_REDUCE_BE_PHY_DAM_REDUCE_COEF, Attrs, BuffTpl) ->
    Para = lib_buff_tpl:get_para(BuffTpl),
    ?ASSERT(Para > 0, BuffTpl),

    OldVal = Attrs#attrs.be_phy_dam_reduce_coef,
    NewVal = erlang:max(Attrs#attrs.be_phy_dam_reduce_coef - Para,0),  % 做矫正，避免溢出
    Attrs#attrs{be_phy_dam_reduce_coef = NewVal};


calc_one_buff_eff(?EN_REDUCE_BE_MAG_DAM_REDUCE_COEF, Attrs, BuffTpl) ->
    Para = lib_buff_tpl:get_para(BuffTpl),
    ?ASSERT(Para > 0, BuffTpl),

    OldVal = Attrs#attrs.be_mag_dam_reduce_coef,
    NewVal = erlang:max(Attrs#attrs.be_mag_dam_reduce_coef - Para,0),  % 做矫正，避免溢出
    Attrs#attrs{be_mag_dam_reduce_coef = NewVal};

calc_one_buff_eff(?EN_REDUCE_BE_DAM_REDUCE_COEF, Attrs, BuffTpl) ->
    Para = lib_buff_tpl:get_para(BuffTpl),
    ?ASSERT(Para > 0, BuffTpl),

    OldVal1 = Attrs#attrs.be_phy_dam_reduce_coef,
    OldVal2 = Attrs#attrs.be_mag_dam_reduce_coef,
    NewVal1 = OldVal1 - Para,
    NewVal2 = OldVal2 - Para,
    Attrs#attrs{
            be_phy_dam_reduce_coef = NewVal1,
            be_mag_dam_reduce_coef = NewVal2
            };


calc_one_buff_eff(_Other, Attrs, _BuffTpl) ->  % 与战斗属性无关的
    % ?ASSERT(false, {_Other, _BuffTpl}),
    % ?ERROR_MSG("[lib_buff_eff] calc_one_buff_eff() error!!! _Other:~p, _BuffTpl:~w", [_Other, _BuffTpl]),
    Attrs.
                    