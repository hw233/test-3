%%%------------------------------------------------
%%% File    : attribute.hrl
%%% Author  : 
%%% Created : 2013.5.20
%%% Description: 属性相关的宏
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__ATTRIBUTE_H__).
-define(__ATTRIBUTE_H__, 0).



%% 属性名（不同的名字代表不同的属性类型）
-define(ATTR_HP, 	 		hp).             % 气血
-define(ATTR_HP_LIM, 		hp_lim).     % 气血上限
-define(ATTR_HP_LIM_RATE, 	hp_lim_rate).     % 气血上限比例
-define(ATTR_MP, 			mp).             % 魔法值
-define(ATTR_MP_LIM, 		mp_lim).     % 魔法值上限
-define(ATTR_MP_LIM_RATE, 	mp_lim_rate).     % 魔法值上限比例
-define(ATTR_PHY_ATT, 		phy_att).   % 物理攻击
-define(ATTR_PHY_ATT_RATE, 	phy_att_rate).   % 物理攻击
-define(ATTR_MAG_ATT, 		mag_att).   % 法术攻击
-define(ATTR_MAG_ATT_RATE, 	mag_att_rate).   % 法术攻击
-define(ATTR_PHY_DEF, 		phy_def).   % 物理防御
-define(ATTR_PHY_DEF_RATE, 	phy_def_rate).   % 物理防御
-define(ATTR_MAG_DEF, 		mag_def).   % 法术防御
-define(ATTR_MAG_DEF_RATE, 	mag_def_rate).   % 法术防御

-define(ATTR_HIT, 	hit).           % 命中
-define(ATTR_HIT_RATE, hit_rate).           % 命中
-define(ATTR_DODGE, dodge).       % 闪避
-define(ATTR_DODGE_RATE, dodge_rate).       % 闪避
-define(ATTR_CRIT, crit).         % 暴击
-define(ATTR_CRIT_RATE, crit_rate).         % 暴击
-define(ATTR_TEN, ten).           % 坚韧
-define(ATTR_TEN_RATE, ten_rate).           % 坚韧

-define(ATTR_PHY_CRIT, phy_crit).         			% 物理暴击
-define(ATTR_PHY_TEN, phy_ten).           			% 物理坚韧
-define(ATTR_MAG_CRIT, mag_crit).         			% 法术暴击
-define(ATTR_MAG_TEN, mag_ten).           			% 法术坚韧
-define(ATTR_PHY_CRIT_COEF, phy_crit_coef).         % 物理暴击程度
-define(ATTR_MAG_CRIT_COEF, mag_crit_coef).         % 法术暴击程度
-define(ATTR_HEAL_VALUE, heal_value).         		% 治疗强度
-define(ATTR_HEAL_VALUE_RATE, heal_value_rate).     % 治疗强度

-define(ATTR_TALENT_STR, talent_str).           	% 天赋：力量（strength）
-define(ATTR_TALENT_CON, talent_con).           	% 天赋：体质（constitution）
-define(ATTR_TALENT_STA, talent_sta).           	% 天赋：耐力（stamina）
-define(ATTR_TALENT_SPI, talent_spi).           	% 天赋：灵力（spirit）
-define(ATTR_TALENT_AGI, talent_agi).           	% 天赋：敏捷（agility）

%%-define(ATTR_TALENTS, talents).           		% 天赋属性
-define(ATTR_ANGER, anger).                     	% 怒气
-define(ATTR_ANGER_LIM, anger_lim).             	% 怒气上限
-define(ATTR_ACT_SPEED, act_speed).             	% 出手速度
-define(ATTR_ACT_SPEED_RATE, act_speed_rate).       % 出手速度
-define(ATTR_LUCK, luck).                       	% 幸运
-define(ATTR_NEGLECT_RET_DAM, neglect_ret_dam).   %忽视反震概率

-define(ATTR_FROZEN_RESIS, frozen_resis).			% 冰封抗性
-define(ATTR_FROZEN_RESIS_LIM, frozen_resis_lim).	% 冰封抗性上限

-define(ATTR_TRANCE_RESIS, trance_resis).			% 昏睡抗性
-define(ATTR_TRANCE_RESIS_LIM, trance_resis_lim).	% 昏睡抗性上限
            
-define(ATTR_CHAOS_RESIS, chaos_resis).             % 混乱抗性
-define(ATTR_CHAOS_RESIS_LIM, chaos_resis_lim).     % 混乱抗性上限

-define(ATTR_FROZEN_HIT, frozen_hit).				% 冰封命中
-define(ATTR_FROZEN_HIT_LIM, frozen_hit_lim).		% 冰封命中上限



-define(ATTR_TRANCE_HIT, trance_hit).				% 昏睡命中
-define(ATTR_TRANCE_HIT_LIM, trance_hit_lim).       % 昏睡命中上限

-define(ATTR_CHAOS_HIT, chaos_hit).					% 混乱命中
-define(ATTR_CHAOS_HIT_LIM, chaos_hit_lim).         % 混乱命中上限

-define(ATTR_SEAL_HIT, seal_hit).                   % 封印命中
-define(ATTR_SEAL_RESIS, seal_resis).               % 封印抗性

-define(ATTR_PHY_COMBO_ATT_PROBA, phy_combo_att_proba).     % 物理连击概率
-define(ATTR_MAG_COMBO_ATT_PROBA, mag_combo_att_proba).     % 法术连击概率
-define(ATTR_STRIKEBACK_PROBA, strikeback_proba).   		% 反击概率
-define(ATTR_PURSUE_ATT_PROBA, pursue_att_proba).  		 	% 追击概率

-define(ATTR_DO_PHY_DAM_SCALING, do_phy_dam_scaling).   % 物理伤害放缩系数
-define(ATTR_DO_MAG_DAM_SCALING, do_mag_dam_scaling).   % 法术伤害放缩系数
-define(ATTR_CRIT_COEF, crit_coef).            			% 暴击系数

-define(ATTR_RET_DAM_PROBA, ret_dam_proba).            	% 反震（即反弹）概率（是一个放大1000倍的整数）
-define(ATTR_RET_DAM_COEF, ret_dam_coef).              	% 反震（即反弹）系数

-define(ATTR_BE_HEAL_EFF_COEF, be_heal_eff_coef).      	% 被治疗效果系数
-define(ATTR_HEAL_EFF_COEF, heal_eff_coef).      	% 被治疗效果系数

-define(ATTR_REDUCE_PURSUE_ATT_DAM_COEF, reduce_pursue_att_dam_coef).      	% 被治疗效果系数


-define(ATTR_BE_PHY_DAM_REDUCE_COEF, be_phy_dam_reduce_coef).   % 物理伤害减免系数
-define(ATTR_BE_MAG_DAM_REDUCE_COEF, be_mag_dam_reduce_coef).   % 法术伤害减免系数

-define(ATTR_BE_PHY_DAM_SHRINK, be_phy_dam_shrink).   % （受）物理伤害缩小值
-define(ATTR_BE_MAG_DAM_SHRINK, be_mag_dam_shrink).   % （受）法术伤害缩小值

-define(ATTR_PURSUE_ATT_DAM_COEF, pursue_att_dam_coef).    		% 追击伤害系数
-define(ATTR_ABSORB_HP_COEF, absorb_hp_coef).    				% 吸血系数
-define(ATTR_QUGUI_COEF, qugui_coef).    						% 驱鬼系数

-define(ATTR_SEAL_HIT_RATE, seal_hit_rate).
-define(ATTR_SEAL_RESIS_RATE, seal_resis_rate).

-define(ATTR_ANGER_EFF_COEF, anger_eff_coef).

%% 天赋属性的代号
-define(TALENT_CODE_STR, 1).   % 力量
-define(TALENT_CODE_CON, 2).   % 体质
-define(TALENT_CODE_STA, 3).   % 耐力
-define(TALENT_CODE_SPI, 4).   % 灵力
-define(TALENT_CODE_AGI, 5).   % 敏捷

-define(STORE_HP_MP_LIM, 1000000).                     % 人物生命和法力储备值上限为100000
-define(STORE_PAR_HP_MP_LIM, 4000000).                 % 人物宠物用的生命和法力储备值上限为400000

% 新增部分属性
-define(ATTR_BE_CHAOS_ATT_TEAM_PAOBA,be_chaos_att_team_paoba).
-define(ATTR_BE_CHAOS_ATT_TEAM_PHY_DAM,be_chaos_att_team_phy_dam).
-define(ATTR_NEGLECT_SEAL_RESIS,neglect_seal_resis).
-define(ATTR_SEAL_HIT_TO_PARTNER,seal_hit_to_partner).
-define(ATTR_SEAL_HIT_TO_MON,seal_hit_to_mon).
-define(ATTR_PHY_DAM_TO_PARTNER,phy_dam_to_partner).
-define(ATTR_PHY_DAM_TO_MON,phy_dam_to_mon).
-define(ATTR_MAG_DAM_TO_PARTNER,mag_dam_to_partner).
-define(ATTR_MAG_DAM_TO_MON,mag_dam_to_mon).
-define(ATTR_BE_CHAOS_ROUND_REPAIR,be_chaos_round_repair).
-define(ATTR_CHAOS_ROUND_REPAIR,chaos_round_repair).
-define(ATTR_BE_FROZE_ROUND_REPAIR,be_froze_round_repair).
-define(ATTR_FROZE_ROUND_REPAIR,froze_round_repair).
-define(ATTR_NEGLECT_PHY_DEF,neglect_phy_def).
-define(ATTR_NEGLECT_MAG_DEF,neglect_mag_def).

-define(ATTR_PHY_DAM_TO_SPEED_1,phy_dam_to_speed_1).
-define(ATTR_PHY_DAM_TO_SPEED_2,phy_dam_to_speed_2).
-define(ATTR_MAG_DAM_TO_SPEED_1,mag_dam_to_speed_1).
-define(ATTR_MAG_DAM_TO_SPEED_2,mag_dam_to_speed_2).
-define(ATTR_SEAL_HIT_TO_SPEED,seal_hit_to_speed).

-define(ATTR_REVIVE_HEAL_COEF,revive_heal_coef).		% 复活治疗系数

% -define(ATTR_FIGHT_ORDER_FACTOR, fight_order_factor).
% -define(ATTR_PRO_SWORD, pro_sword).
% -define(ATTR_PRO_BOW, pro_bow).
% -define(ATTR_PRO_SPEAR, pro_spear).
% -define(ATTR_PRO_MAG, pro_msg).
% -define(ATTR_RESIS_SWORD, resis_sowrd).
% -define(ATTR_RESIS_BOW, resis_bow).
% -define(ATTR_RESIS_SPEAR, resis_spear).
% -define(ATTR_RESIS_MAG, resis_msg).



















-endif.  %% __ATTRIBUTE_H__
