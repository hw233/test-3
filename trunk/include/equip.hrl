%%%------------------------------------------------
%%% File    : equip.hrl
%%% Author  : huangjf, zhangwq, dsh
%%% Created : 2013.8.20
%%% Description: 装备的相关宏定义
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__EQUIP_H__).
-define(__EQUIP_H__, 0).

 
% 装备自身的额外特性（如：强化等级， 镶嵌， 洗练等）相关宏
-define(EQP_PROP_STREN_LV, stren_lv).   % 强化等级
-define(EQP_PROP_STREN_EXP, stren_exp). % 强化经验
-define(EQP_PROP_GEM_INLAY, gem_inlay). % 宝石镶嵌


%% 装备最大强化等级
% -define(MAX_STREN_LV, 10).      % 最大强化等级
-define(MAX_GEMSTONE_HOLE, 4).  % 最大宝石孔个数

-define(GEM_TYPE_PHY_ATT, 1).				   %% 物理攻击值    武器 头盔
-define(GEM_TYPE_MAG_ATT, 2).				   %% 法术攻击值	武器 项链
-define(GEM_TYPE_PHY_DEF, 3).				   %% 物理防御值	头盔 衣服
-define(GEM_TYPE_MAG_DEF, 4).				   %% 法术防御值	衣服 项链
-define(GEM_TYPE_HP_LIM, 5).				   %% 生命上限值	衣服 腰带
-define(GEM_TYPE_ACT_SPEED, 6).                %% 速度宝石      鞋子 腰带
-define(GEM_TYPE_SEAL_HIT, 7).				   %% 封印命中值    武器
-define(GEM_TYPE_SEAL_RESIS, 8).			   %% 抗封印命中值  鞋子 腰带
-define(GEM_TYPE_HEAL_VALUE, 9).               %% 治疗强度      武器 衣服
% ---------------------------------------------------------------------------------------------

-record(equip_fashion, {
    no = 1,
    goods_list = [],
    add_attr = []
}).

-record(equip_fashion_info, {
    uid = 1,
    wear_fashion_no = 0,
    all_fashion = []
}).

-record(equip_fashion_data, {
    no = 0,
    expire = 0,
    ext = []
}).

% 新
% 武器 4  物理攻击 法术攻击 封印命中 治疗强度 物理伤害增加 法术伤害增加 忽视封印抗性 忽视物理防御 忽视法术防御 
% 衣服 4  物理防御 法术防御 气血上限 治疗强度 物理伤害减少固定值 法术伤害减少固定值 抗物理暴击 抗法术暴击
% 头盔 2  物理防御 物理攻击 物理伤害增加 物理伤害减少固定值 物理暴击几率 抗物理暴击
% 项链 2  法术攻击 法术防御 法术伤害增加 法术伤害减少固定值 法术暴击几率 抗法术暴击
% 腰带 3  气血上限 封印抗性 速度 气血上限百分比 速度百分比 
% 鞋子 2  封印抗性 速度 速度百分比 物理暴击伤害 法术暴击伤害

% 物理攻击 8
% 法术攻击 8
% 封印命中 4
% 治疗强度 8
% 物理伤害增加 8
% 法术伤害增加 8
% 忽视封印抗性 4
% 忽视物理防御 4
% 忽视法术防御 4
% 气血上限 8
% 物理伤害减少固定值 8
% 法术伤害减少固定值 8
% 抗物理暴击 8
% 抗法术暴击 8
% 物理暴击几率 4
% 法术暴击几率 4
% 封印抗性 8
% 速度 8
% 速度百分比 8
% 物理暴击伤害 4
% 法术暴击伤害 4
% 气血上限百分比 4

-define(GEM_TYPE_DO_PHY_DAM, 10).               %% 物伤宝石
-define(GEM_TYPE_DO_MAG_DAM, 11).               %% 法伤宝石
-define(GEM_TYPE_HP_LIM_RATE, 14).              %% 气血上限百分比
-define(GEM_TYPE_ACT_SPEED_RATE, 42).   		%% 速度百分比

-define(GEM_TYPE_PHY_DAM_SHRINK, 31).               %% 物伤减少
-define(GEM_TYPE_MAG_DAM_SHRINK, 32).               %% 法伤减少

-define(GEM_TYPE_PHY_CRIT,33).						% 物理暴击
-define(GEM_TYPE_PHY_TEN,34).						% 物理坚韧
-define(GEM_TYPE_MAG_CRIT,35).						% 法术暴击
-define(GEM_TYPE_MAG_TEN,36).						% 法术坚韧
-define(GEM_TYPE_PHY_CRIT_COEF,37).					% 物理暴击伤害
-define(GEM_TYPE_MAG_CRIT_COEF,38).					% 法术暴击伤害

-define(GEM_TYPE_NEGLECT_SEAL_RESIS,39).			% 忽视抗封
-define(GEM_TYPE_NEGLECT_PHY_DEF,40).				% 忽视物理防御
-define(GEM_TYPE_NEGLECT_MAG_DEF,41).				% 忽视法术防御
% ---------------------------------------------------------------------------------------------

-define(GEM_TYPE_BE_PHY_DAM, 12).               %% 物免宝石
-define(GEM_TYPE_BE_MAG_DAM, 13).               %% 法免宝石

-define(GEM_TYPE_PURSUE_ATT, 15).               %% 追击宝石
-define(GEM_TYPE_PHY_COMBO_ATT, 16).            %% 连击宝石
-define(GEM_TYPE_ABSORB_HP, 17).                %% 吸血宝石
-define(GEM_TYPE_MAG_COMBO_ATT, 18).            %% 法术连击宝石
-define(GEM_TYPE_STRIKEBACK, 19).              %% 反击宝石
-define(GEM_TYPE_CRIT, 20).                    %% 暴击宝石
-define(GEM_TYPE_TEN, 21).                     %% 韧性宝石
-define(GEM_TYPE_HIT, 22).                     %% 命中宝石
-define(GEM_TYPE_DODGE, 23).                   %% 闪避宝石
% -define(GEM_TYPE_ACT_SPEED, 15).               %% 速度宝石
% -define(GEM_TYPE_PHY_ATT, 16).				   %% 物理攻击值
% -define(GEM_TYPE_MAG_ATT, 17).				   %% 法术攻击值
% -define(GEM_TYPE_PHY_DEF, 18).				   %% 物理防御值
% -define(GEM_TYPE_MAG_DEF, 19).				   %% 法术防御值
% -define(GEM_TYPE_HP_LIM, 20).				   %% 生命上限值
-define(GEM_TYPE_MP_LIM, 24).				   %% 法力上限值
% -define(GEM_TYPE_SEAL_HIT, 22).				   %% 封印命中值
% -define(GEM_TYPE_SEAL_RESIS, 23).			   %% 抗封印命中值
-define(GEM_TYPE_FROZEN_HIT, 25).              %% 冰封命中
-define(GEM_TYPE_CHAOS_HIT, 26).               %% 混乱命中
-define(GEM_TYPE_FROZEN_RESIS, 27).            %% 冰封抗性
-define(GEM_TYPE_CHAOS_RESIS, 28).             %% 混乱抗性
-define(GEM_TYPE_TRANCE_HIT, 29).              %% 昏睡命中
-define(GEM_TYPE_TRANCE_RESIS, 30).            %% 昏睡抗性
% -define(GEM_TYPE_HEAL_VALUE, 30).              %% 治疗强度


% 特效属性
-define(EQUIP_EFFECT_PHY_CRIT, equip_effect_phy_crit).									% 物理暴击
-define(EQUIP_EFFECT_MAG_CRIT, equip_effect_mag_crit).									% 法术暴击

-define(EQUIP_EFFECT_PHY_TEN, equip_effect_phy_ten).									% 抗物理暴击
-define(EQUIP_EFFECT_MAG_TEN, equip_effect_mag_ten).									% 抗法术暴击

-define(EQUIP_EFFECT_SEAL_HIT, equip_effect_seal_hit).									% 封印命中
-define(EQUIP_EFFECT_SEAL_RESIS, equip_effect_seal_resis).								% 封印抗性

% 20151119添加
-define(EQUIP_EFFECT_HEAL_VALUE, equip_effect_heal_value).         						% 治疗强度
-define(EQUIP_EFFECT_DO_PHY_DAM_SCALING, equip_effect_do_phy_dam_scaling).   			% 物理伤害放缩系数
-define(EQUIP_EFFECT_DO_MAG_DAM_SCALING, equip_effect_do_mag_dam_scaling).   			% 法术伤害放缩系数

-define(EQUIP_EFFECT_RET_DAM_PROBA, equip_effect_ret_dam_proba).            			% 反震（即反弹）概率（是一个放大1000倍的整数）
-define(EQUIP_EFFECT_RET_DAM_COEF, equip_effect_ret_dam_coef).              			% 反震（即反弹）系数
-define(EQUIP_EFFECT_BE_HEAL_EFF_COEF, equip_effect_be_heal_eff_coef).      			% 被治疗效果系数
-define(EQUIP_EFFECT_BE_PHY_DAM_REDUCE_COEF, equip_effect_be_phy_dam_reduce_coef).  	% 物理伤害减免系数
-define(EQUIP_EFFECT_BE_MAG_DAM_REDUCE_COEF, equip_effect_be_mag_dam_reduce_coef).  	% 法术伤害减免系数
-define(EQUIP_EFFECT_BE_PHY_DAM_SHRINK, equip_effect_be_phy_dam_shrink).  	 			% （受）物理伤害缩小值
-define(EQUIP_EFFECT_BE_MAG_DAM_SHRINK, equip_effect_be_mag_dam_shrink).   				% （受）法术伤害缩小值

% 新增特效属性
-define(EQUIP_EFFECT_SEAL_HIT_TO_PARTNER 			,equip_effect_seal_hit_to_partner).
-define(EQUIP_EFFECT_SEAL_HIT_TO_MON 				,equip_effect_seal_hit_to_mon).
-define(EQUIP_EFFECT_PHY_DAM_TO_PARTNER 			,equip_effect_phy_dam_to_partner).
-define(EQUIP_EFFECT_PHY_DAM_TO_MON 				,equip_effect_phy_dam_to_mon).
-define(EQUIP_EFFECT_MAG_DAM_TO_PARTNER 			,equip_effect_mag_dam_to_partner).
-define(EQUIP_EFFECT_MAG_DAM_TO_MON 				,equip_effect_mag_dam_to_mon).
-define(EQUIP_EFFECT_BE_CHAOS_ROUND_REPAIR 			,equip_effect_be_chaos_round_repair).
-define(EQUIP_EFFECT_CHAOS_ROUND_REPAIR 			,equip_effect_chaos_round_repair).
-define(EQUIP_EFFECT_BE_FROZE_ROUND_REPAIR 			,equip_effect_be_froze_round_repair).
-define(EQUIP_EFFECT_FROZE_ROUND_REPAIR 			,equip_effect_froze_round_repair).
-define(EQUIP_EFFECT_NEGLECT_PHY_DEF 				,equip_effect_neglect_phy_def).
-define(EQUIP_EFFECT_NEGLECT_MAG_DEF 				,equip_effect_neglect_mag_def).
-define(EQUIP_EFFECT_NEGLECT_SEAL_RESIS 			,equip_effect_neglect_seal_resis).
-define(EQUIP_EFFECT_PHY_DAM_TO_SPEED_1 			,equip_effect_phy_dam_to_speed_1).
-define(EQUIP_EFFECT_PHY_DAM_TO_SPEED_2 			,equip_effect_phy_dam_to_speed_2).
-define(EQUIP_EFFECT_MAG_DAM_TO_SPEED_1 			,equip_effect_mag_dam_to_speed_1).
-define(EQUIP_EFFECT_MAG_DAM_TO_SPEED_2 			,equip_effect_mag_dam_to_speed_2).
-define(EQUIP_EFFECT_SEAL_HIT_TO_SPEED 				,equip_effect_seal_hit_to_speed).

-define(EQUIP_EFFECT_NO_LEVEL, equip_effect_to_low_level). 	%% 降低装备要求级别

-define(EQUIP_EFFECT_CRIT,  equip_effect_crit).									% 双系暴击
-define(EQUIP_EFFECT_TEN,  equip_effect_ten).								% 双系抗暴击
-define(EQUIP_EFFECT_DO_DAM_SCALING,  equip_effect_do_dam_scaling).   			% 双系伤害放缩系数
-define(EQUIP_EFFECT_BE_DAM_REDUCE_COEF,  equip_effect_be_dam_reduce_coef).  	% 双系伤害减免系数
-define(EQUIP_EFFECT_BE_DAM_SHRINK,  equip_effect_be_dam_shrink).   				% 双系伤害缩小值

-define(EQUIP_EFFECT_ADD_SKILL_LV,  equip_effect_add_skill_lv).   				% 技能等级提高

-define(EQUIP_EFFECT_ADD_ACT_SPEED_RATE, equip_effect_add_act_speed_rate).                      % 增加出手速度（百分比）
-define(EQUIP_EFFECT_DEC_ACT_SPEED_RATE, equip_effect_dec_act_speed_rate).                      % 降低出手速度（百分比）
-define(EQUIP_EFFECT_ANGER_EFF_COEF, equip_effect_anger_eff_coef).                      % 怒气恢复效果（百分比）
-define(EQUIP_EFFECT_ADD_SKILL, equip_effect_add_skill).                                % 增加技能主（被）动

-endif.  %% __EQUIP_H__
