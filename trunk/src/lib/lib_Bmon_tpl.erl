%%%-----------------------------------
%%% @Module  : lib_Bmon_tpl (Bmon: battle monster)
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2013.7.16
%%% @Description: 战斗怪模板的相关接口
%%%-----------------------------------
-module(lib_Bmon_tpl).
-export([
    	get_tpl_data/1,
        is_tpl_exists/1,

        make_attrs_rd_from/1,
        make_attrs_rd_from/3,
    
        get_drop_pkg_no/1,
        get_drop_exp_coef/1,
        get_drop_par_exp_coef/1,
        

    	get_no/1, 
    	get_name/1, get_sex/1, get_race/1, get_faction/1,
        get_type/1,
    	get_lv/1, 
    	get_hp/1, get_hp_lim/1,
    	get_mp/1, get_mp_lim/1,
%%    	get_anger/1, get_anger_lim/1,
    	get_phy_att/1, get_mag_att/1,
    	get_phy_def/1, get_mag_def/1,

%%    	get_hit/1, get_dodge/1, get_crit/1, get_ten/1,
        get_act_speed/1,

        % get_frozen_hit/1, get_frozen_resis/1,
        % get_trance_hit/1, get_trance_resis/1,
        % get_chaos_hit/1, get_chaos_resis/1,
        get_seal_hit/1, get_seal_resis/1,
        

        get_do_phy_dam_scaling/1, get_do_mag_dam_scaling/1,
        get_crit_coef/1,
        get_be_heal_eff_coef/1,
        get_be_phy_dam_reduce_coef/1,
        get_be_mag_dam_reduce_coef/1,
        get_absorb_hp_coef/1,

        get_initiative_skill_list/1,
        get_initiative_skill_list/2,
        get_passive_skill_list/1,
        get_passive_skill_list/2,
        get_AI_list/1,
        get_AI_list/2,

        is_world_boss/1,
        is_drop_exp_buff_effect/1,                   %% 掉落的经验是否受经验buff影响
        get_action_res_count/1,
        can_be_captured/1,
        has_fallen_prep_status/1
        
    ]).

-include("common.hrl").
-include("record.hrl").
-include("monster.hrl").
-include("faction.hrl").
-include("bo.hrl").
-include("ref_attr.hrl").


%% 获取模板数据
%% @para: MonNo => 战斗怪编号
%% @return: null | battle_mon结构体
get_tpl_data(BMonNo) ->
	data_Bmon:get(BMonNo).


%% 战斗怪模板是否存在？
is_tpl_exists(BMonNo) ->
    get_tpl_data(BMonNo) /= null.


% get_tpl_adapt_team_mb_count(BMonTpl) ->
%     BMonTpl#battle_mon.adapt_team_mb_count.


make_attrs_rd_from(BMonTpl) ->
    #attrs{
        hp = get_hp_lim(BMonTpl),  % 满血
        mp = get_mp_lim(BMonTpl),  % 满魔
        hp_lim = get_hp_lim(BMonTpl),
        mp_lim = get_mp_lim(BMonTpl),

        phy_att = get_phy_att(BMonTpl),
        mag_att = get_mag_att(BMonTpl),
        phy_def = get_phy_def(BMonTpl),
        mag_def = get_mag_def(BMonTpl),

%%        anger = get_anger(BMonTpl),
%%        anger_lim = get_anger_lim(BMonTpl),

        act_speed = get_act_speed(BMonTpl),

        phy_crit = get_phy_crit(BMonTpl),   
        phy_ten = get_phy_ten(BMonTpl), 
        mag_crit = get_mag_crit(BMonTpl),    
        mag_ten = get_mag_ten(BMonTpl), 
        phy_crit_coef = get_phy_crit_coef(BMonTpl),   
        mag_crit_coef = get_mag_crit_coef(BMonTpl),   
        heal_value = get_heal_value(BMonTpl),  
        seal_resis = get_seal_resis(BMonTpl),  
        seal_hit = get_seal_hit(BMonTpl),

        do_phy_dam_scaling = erlang:max(1 + get_do_phy_dam_scaling(BMonTpl) ,0.1),
        do_mag_dam_scaling = erlang:max(1 + get_do_mag_dam_scaling(BMonTpl) ,0.1),

        be_heal_eff_coef = get_be_heal_eff_coef(BMonTpl),
        be_phy_dam_reduce_coef = erlang:max(get_be_phy_dam_reduce_coef(BMonTpl) ,0),
        be_mag_dam_reduce_coef = erlang:max(get_be_mag_dam_reduce_coef(BMonTpl) ,0),
        absorb_hp_coef = get_absorb_hp_coef(BMonTpl),
        qugui_coef = get_qugui_coef(BMonTpl)
        }.


random_range_attr(AttrRandomRange) ->
    RangeMax = util:ceil(AttrRandomRange * 10000),

    % ?DEBUG_MSG("AttrRandomRange = ~p RangeMax = ~p",[AttrRandomRange,RangeMax]),

    Ret = case AttrRandomRange of 
        0 ->  
            0;
        _ -> 
            case util:rand(1,2) of
                1 -> util:rand(1,RangeMax)/10000;
                _ -> -util:rand(1,RangeMax)/10000
            end
    end,

    % ?DEBUG_MSG("Ret = ~p AttrRandomRange = ~p RangeMax = ~p",[Ret,AttrRandomRange,RangeMax]),
    Ret.

make_attrs_rd_from(BMonTpl,AttrRandomRange,AttrStreng) ->
    #attrs{
        hp = util:ceil(get_hp_lim(BMonTpl) * (1+random_range_attr(AttrRandomRange)) * AttrStreng),  % 满血
        mp = util:ceil(get_mp_lim(BMonTpl) * (1+random_range_attr(AttrRandomRange)) * AttrStreng),  % 满魔
        hp_lim = util:ceil(get_hp_lim(BMonTpl) * (1+random_range_attr(AttrRandomRange)) * AttrStreng),
        mp_lim = util:ceil(get_mp_lim(BMonTpl) * (1+random_range_attr(AttrRandomRange)) * AttrStreng),

        phy_att = util:ceil(get_phy_att(BMonTpl) * (1+random_range_attr(AttrRandomRange)) * AttrStreng),
        mag_att = util:ceil(get_mag_att(BMonTpl) * (1+random_range_attr(AttrRandomRange)) * AttrStreng),
        phy_def = util:ceil(get_phy_def(BMonTpl) * (1+random_range_attr(AttrRandomRange)) * AttrStreng),
        mag_def = util:ceil(get_mag_def(BMonTpl) * (1+random_range_attr(AttrRandomRange)) * AttrStreng),
        act_speed = util:ceil(get_act_speed(BMonTpl) * (1+random_range_attr(AttrRandomRange)) * AttrStreng),

        phy_crit = util:ceil(get_phy_crit(BMonTpl) * AttrStreng),   
        phy_ten = util:ceil(get_phy_ten(BMonTpl) * AttrStreng), 
        mag_crit = util:ceil(get_mag_crit(BMonTpl) * AttrStreng),    
        mag_ten = util:ceil(get_mag_ten(BMonTpl) * AttrStreng), 
        phy_crit_coef = util:ceil(get_phy_crit_coef(BMonTpl) ),   
        mag_crit_coef = util:ceil(get_mag_crit_coef(BMonTpl) ),   
        heal_value = util:ceil(get_heal_value(BMonTpl) * (1+random_range_attr(AttrRandomRange)) * AttrStreng),  
        seal_resis = util:ceil(get_seal_resis(BMonTpl) * (1+random_range_attr(AttrRandomRange)) * AttrStreng),  
        seal_hit = util:ceil(get_seal_hit(BMonTpl) * (1+random_range_attr(AttrRandomRange)) * AttrStreng),

        do_phy_dam_scaling = erlang:max(1 + get_do_phy_dam_scaling(BMonTpl) * (1+random_range_attr(AttrRandomRange)) * AttrStreng,0.1),
        do_mag_dam_scaling = erlang:max(1 + get_do_mag_dam_scaling(BMonTpl) * (1+random_range_attr(AttrRandomRange)) * AttrStreng,0.1),

        be_heal_eff_coef = get_be_heal_eff_coef(BMonTpl),

        be_phy_dam_reduce_coef = erlang:max(get_be_phy_dam_reduce_coef(BMonTpl) * (1+random_range_attr(AttrRandomRange)) * AttrStreng,0),
        be_mag_dam_reduce_coef = erlang:max(get_be_mag_dam_reduce_coef(BMonTpl) * (1+random_range_attr(AttrRandomRange)) * AttrStreng,0),
        
        absorb_hp_coef = get_absorb_hp_coef(BMonTpl),
        qugui_coef = get_qugui_coef(BMonTpl)
        }.


% 获取资源配置的数量
get_action_res_count(BMonTpl) ->
    length(BMonTpl#battle_mon.action_res).

% 是否可以捕捉
can_be_captured(BMonTpl) ->
    BMonTpl#battle_mon.can_be_captured.

%% 获取掉落包编号
get_drop_pkg_no(BMonTpl) ->
    BMonTpl#battle_mon.drop_pkg_no.

get_drop_exp_coef(BMonTpl) ->
    BMonTpl#battle_mon.drop_exp_coef.

get_drop_par_exp_coef(BMonTpl) ->
    BMonTpl#battle_mon.drop_par_exp_coef.

get_no(BMonTpl) -> BMonTpl#battle_mon.no.

% get_res_id(BMonTpl) -> BMonTpl#battle_mon.res_id.

get_name(BMonTpl) -> BMonTpl#battle_mon.name.

get_sex(_BMonTpl) -> ?SEX_NONE.     % 战斗怪无性别

get_race(_BMonTpl) -> ?RACE_NONE.   % 战斗怪无种族

get_faction(BMonTpl) -> BMonTpl#battle_mon.faction.   % 战斗怪无门派

get_type(BMonTpl) -> BMonTpl#battle_mon.type.

get_lv(BMonTpl) -> BMonTpl#battle_mon.lv.


get_hp(RefAttrData) -> RefAttrData#ref_attr.hp.

get_hp_lim(RefAttrData) -> RefAttrData#ref_attr.hp_lim.

get_mp(RefAttrData) -> RefAttrData#ref_attr.mp.

get_mp_lim(RefAttrData) -> RefAttrData#ref_attr.mp_lim.

%%get_anger(RefAttrData) -> RefAttrData#ref_attr.anger.
%%
%%get_anger_lim(RefAttrData) -> RefAttrData#ref_attr.anger_lim.

get_phy_att(RefAttrData) -> RefAttrData#ref_attr.phy_att.

get_mag_att(RefAttrData) -> RefAttrData#ref_attr.mag_att.

get_phy_def(RefAttrData) -> RefAttrData#ref_attr.phy_def.

get_mag_def(RefAttrData) -> RefAttrData#ref_attr.mag_def.

%%get_hit(RefAttrData) -> RefAttrData#ref_attr.hit.
%%
%%get_dodge(RefAttrData) -> RefAttrData#ref_attr.dodge.

get_crit(RefAttrData) -> RefAttrData#ref_attr.crit.

get_ten(RefAttrData) -> RefAttrData#ref_attr.ten.

get_act_speed(RefAttrData) -> RefAttrData#ref_attr.act_speed.

% duan新增属性
get_phy_crit(RefAttrData) -> RefAttrData#ref_attr.phy_crit.
get_phy_ten(RefAttrData) -> RefAttrData#ref_attr.phy_ten.
get_mag_crit(RefAttrData) -> RefAttrData#ref_attr.mag_crit.
get_mag_ten(RefAttrData) -> RefAttrData#ref_attr.mag_ten.
get_phy_crit_coef(RefAttrData) -> RefAttrData#ref_attr.phy_crit_coef.
get_mag_crit_coef(RefAttrData) -> RefAttrData#ref_attr.mag_crit_coef.
get_heal_value(RefAttrData) -> RefAttrData#ref_attr.heal_value.
get_seal_resis(RefAttrData) -> RefAttrData#ref_attr.seal_resis.
get_seal_hit(RefAttrData) -> RefAttrData#ref_attr.seal_hit.


%% 冰封命中/抗性
% get_frozen_hit(RefAttrData) -> RefAttrData#ref_attr.frozen_hit.
% get_frozen_resis(RefAttrData) -> RefAttrData#ref_attr.frozen_resis.

% %% 昏睡命中/抗性
% get_trance_hit(RefAttrData) -> RefAttrData#ref_attr.trance_hit.
% get_trance_resis(RefAttrData) -> RefAttrData#ref_attr.trance_resis.

% %% 混乱命中/抗性
% get_chaos_hit(RefAttrData) -> RefAttrData#ref_attr.chaos_hit.
% get_chaos_resis(RefAttrData) -> RefAttrData#ref_attr.chaos_resis.


%% 获取物理伤害放缩系数
get_do_phy_dam_scaling(RefAttrData) ->
  RefAttrData#ref_attr.do_phy_dam_scaling.

%% 获取法术伤害放缩系数
get_do_mag_dam_scaling(RefAttrData) ->
  RefAttrData#ref_attr.do_mag_dam_scaling.


%% 获取暴击系数
get_crit_coef(RefAttrData) ->
  RefAttrData#ref_attr.crit_coef.


get_be_heal_eff_coef(RefAttrData) ->
  RefAttrData#ref_attr.be_heal_eff_coef.

get_be_phy_dam_reduce_coef(RefAttrData) ->
  RefAttrData#ref_attr.be_phy_dam_reduce_coef.

get_be_mag_dam_reduce_coef(RefAttrData) ->
  RefAttrData#ref_attr.be_mag_dam_reduce_coef.

get_absorb_hp_coef(RefAttrData) ->
  RefAttrData#ref_attr.absorb_hp_coef.

get_qugui_coef(RefAttrData) ->
  RefAttrData#ref_attr.qugui_coef.



%% 获取技能列表（主动技 + 被动技）
%% @return：技能id列表
get_skill_list(BMonTpl) ->
    get_initiative_skill_list(BMonTpl) ++ get_passive_skill_list(BMonTpl).


%% 获取技能列表（主动技 + 被动技）
%% @return：技能id列表
get_skill_list(BMonTpl,MonLv) ->
    get_initiative_skill_list(BMonTpl,MonLv) ++ get_passive_skill_list(BMonTpl,MonLv).


%% 获取主动技列表
get_initiative_skill_list(BMonTpl) ->
    % L = get_skill_list(BMonTpl),
    % [X || X <- L, mod_skill:is_initiative(X)].
    BMonTpl#battle_mon.initiative_skill_list.


%% 获取被动技列表
get_initiative_skill_list(BMonTpl,MonLv) ->
    List = BMonTpl#battle_mon.initiative_skill_list_by_lv,

    F = fun({Lv,No},Acc) ->
        case MonLv >= Lv of
            true ->  Acc ++ [No];
            false -> Acc
        end
    end,
    
    BMonTpl#battle_mon.initiative_skill_list ++ lists:foldl(F,[],List).



%% 获取被动技列表
get_passive_skill_list(BMonTpl) ->
    % L = get_skill_list(BMonTpl),
    % [X || X <- L, mod_skill:is_passive(X)].
    BMonTpl#battle_mon.passi_skill_list.

%% 获取被动技列表
get_passive_skill_list(BMonTpl,MonLv) ->
    List = BMonTpl#battle_mon.passi_skill_list_by_lv,

    F = fun({Lv,No},Acc) ->
        case MonLv >= Lv of
            true ->  Acc ++ [No];
            false -> Acc
        end
    end,
    
    BMonTpl#battle_mon.passi_skill_list ++ lists:foldl(F,[],List).

%% 获取ai列表（自身的ai + 技能所附带的ai）
%% @return: ai编号列表
get_AI_list(BMonTpl) ->
    L1 = BMonTpl#battle_mon.ai_list,

    F = fun(SkillId, AccAIList) ->
            ?ASSERT(mod_skill:is_valid_skill_id(SkillId), {SkillId, BMonTpl}),
            SKillCfg = mod_skill:get_cfg_data(SkillId),
            L = mod_skill:get_AI_list(SKillCfg),
            L ++ AccAIList
        end,
    L2 = lists:foldl(F, [], get_skill_list(BMonTpl)),

    L3 = BMonTpl#battle_mon.talk_ai_list,

    ?ASSERT(util:is_integer_list(L1), L1),
    ?ASSERT(util:is_integer_list(L2), L2),
    ?ASSERT(util:is_integer_list(L3), L3),
    L1 ++ L2 ++ L3.

%% 获取ai列表（自身的ai + 技能所附带的ai）
%% @return: ai编号列表
get_AI_list(BMonTpl,MonLv) ->
    L1 = BMonTpl#battle_mon.ai_list,

    F = fun(SkillId, AccAIList) ->
            ?ASSERT(mod_skill:is_valid_skill_id(SkillId), {SkillId, BMonTpl}),
            SKillCfg = mod_skill:get_cfg_data(SkillId),
            L = mod_skill:get_AI_list(SKillCfg),
            L ++ AccAIList
        end,
    L2 = lists:foldl(F, [], get_skill_list(BMonTpl,MonLv)),

    L3 = BMonTpl#battle_mon.talk_ai_list,

    ?ASSERT(util:is_integer_list(L1), L1),
    ?ASSERT(util:is_integer_list(L2), L2),
    ?ASSERT(util:is_integer_list(L3), L3),
    L1 ++ L2 ++ L3.


is_world_boss(BMonTpl) ->
    get_type(BMonTpl) == ?BMON_WORLD_BOSS.


is_drop_exp_buff_effect(BMonTpl) ->
    BMonTpl#battle_mon.buff_effect =:= 1.


has_fallen_prep_status(BMonTpl) ->
    BMonTpl#battle_mon.has_fallen_prep_status =:= 1.