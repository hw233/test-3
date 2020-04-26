%%%------------------------------------------------
%%% File    : effect.hrl
%%% Author  : huangjf
%%% Created : 2013.5.15
%%% Description: 效果
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__EFFECT_H__).
-define(__EFFECT_H__, 0).





%% 无效的效果编号
-define(INVALID_EFF_NO, 0).


% 主动技能的效果
-record(skl_eff, {
			no = 0,  % 效果编号
			name = null,  % 效果名

			need_perf_casting = 0,  % 客户端是否需要做对应的施法表现（1：是，0：否）？（仅仅针对添加buff的技能效果而言，其他类型的效果统一为invalid）

			trigger_proba = 0.0,     % 触发概率

			rules_filter_target = [],          % 作用目标的筛选规则
			rules_sort_target = [],            % 作用目标的排序规则

			target_count = 0,          % 作用目标个数

			para = null                % 效果参数

			% value = 0,
			% lasting_time = 0    % 效果的持续时间（单位： 秒）， 0表示永久
	}).


% 被动技能的效果
-record(passi_eff, {
	no = 0,       	% 效果编号
	name = null,  	% 效果名
	op = 0,			% 计算方式
	para = null,   	% 效果参数
	para2 = null,  	% 效果参数2
	para3 = null,  	% 效果参数3
	para4 = null,
	para5 = null ,  %% 用于区分大于还是小于
	para6 = null,   %% 用于区分行动被动触发前中后（123）
	battle_power_coef = 0, % 影响战斗力的系数
	rules_filter_target = [],          % 作用目标的筛选规则
	rules_sort_target = [],            % 作用目标的排序规则
	target_count = 0                   % 作用目标个数
}).





% 物品特有的效果
-record(goods_eff, {
		no = 0,            % 效果编号
		name = null,       % 效果名
		trigger_proba = 0.0,  % 生效概率
		para = null         % 效果参数

		% 其他字段
		% ...
	}).


% 物品效果：触发挖宝事件结构体
-record(dig_treasure, {
		no = 0,
		gid = 0,
		event = 0,
		prob = 0,
		reward = 0,
		para = 0
	}).

% 物品效果：触发触发挖宝事件之刷出明雷怪事件 规则记录体
-record(spawn_mon, {
	step = 0,
	mon_no = 0,
	mon_count = 0,
	scene_no = 0,
	lv_region = 0
	}).


% % 其他特殊效果（special effect）
% -record(spec_eff, {

% 	}).




%% RDT: rules of deciding target 选定目标的规则，包含两种：筛选规则和排序规则
-define(RDT_NONE, none).                 				  		% 筛选：筛选结果为空（即不选取任何目标）
-define(RDT_MYSELF, myself).                 				  	% 筛选：筛选出自己
-define(RDT_NOT_MYSELF, not_myself).                 			% 筛选：筛选出非自己
-define(RDT_CUR_ATT_TARGET, cur_att_target). 				  	% 筛选：筛选出当前所攻击的目标
-define(RDT_CUR_PICK_TARGET, cur_pick_target). 				  	% 筛选：筛选出当前回合所选的目标
-define(RDT_HE_WHO_TAUNT_ME, he_who_taunt_me).  			  	% 筛选：筛选出当前嘲讽我的bo
-define(RDT_ALLY_SIDE, ally_side).           				  	% 筛选：筛选出我方的bo
-define(RDT_ENEMY_SIDE, enemy_side).   						  	% 筛选：筛选出敌方的bo
-define(RDT_DEAD, dead).           						  	  	% 筛选：筛选出已死亡的bo
-define(RDT_UNDEAD, undead).           						  	% 筛选：筛选出未死亡的bo
-define(RDT_IS_PLAYER, is_player).           		  		  	% 筛选：筛选出玩家bo
-define(RDT_IS_NOT_PLAYER, is_not_player).           		  	% 筛选：筛选出非玩家bo
-define(RDT_IS_NOT_MONSTER, is_not_monster).           		  	% 筛选：筛选出非怪物bo
-define(RDT_IS_PARTNER, is_partner).           		  		  	% 筛选：筛选出宠物bo
-define(RDT_IS_MONSTER, is_monster).           				  	% 筛选：筛选出怪物bo

-define(RDT_IS_NOT_PARTNER, is_not_partner).           		  		  	% 筛选：筛选出不是宠物bo

%% 激活基金返利
-define(EN_ACTIVATE_FUND_RECHARGE_REBATES, activate_fund_recharge_rebates).

-define(RDT_IS_GHOST, is_ghost).           				      	% 筛选：筛选出处于鬼魂状态的bo
-define(RDT_IS_NOT_GHOST, is_not_ghost).           			  	% 筛选：筛选出不处于鬼魂状态的bo
-define(RDT_IS_FALLEN, is_fallen).           				  	% 筛选：筛选出处于倒地状态的bo
-define(RDT_IS_NOT_FALLEN, is_not_fallen).           		  	% 筛选：筛选出不处于倒地状态的bo
-define(RDT_MY_OWNER, my_owner).           				      	% 筛选：筛选出自己的主人bo（用于宠物）
-define(RDT_SPOUSE, spouse).           				      		% 筛选：筛选出自己的配偶bo
-define(RDT_HAS_INVISIBLE_EFF, has_invisible_eff).  	  	  	% 筛选：筛选出有隐身效果的bo
-define(RDT_HAS_NOT_INVISIBLE_EFF, has_not_invisible_eff).    	% 筛选：筛选出没有隐身效果的bo
-define(RDT_INVISIBLE_TO_ME, invisible_to_me).  	 	      	% 筛选：筛选出对自己而言隐身效果成立的bo
-define(RDT_NOT_INVISIBLE_TO_ME, not_invisible_to_me).  	  	% 筛选：筛选出对自己而言隐身效果不成立的bo
-define(RDT_BELONG_TO_FACTION, belong_to_faction).				% 筛选：筛选出属于某个门派的bo
-define(RDT_HAS_SPEC_NO_BUFF, has_spec_no_buff).				% 筛选：筛选出有指定编号的buff的bo
-define(RDT_HAS_SPEC_CATEGORY_BUFF, has_spec_category_buff).	% 筛选：筛选出有指定类别的buff的bo
-define(RDT_HAS_SPEC_EFF_TYPE_BUFF, has_spec_eff_type_buff).	% 筛选：筛选出有指定效果类型（增益|减益|中性）的buff的bo
-define(RDT_HAS_NOT_SPEC_NO_BUFF, has_not_spec_no_buff).				% 筛选：筛选出无指定编号的buff的bo
-define(RDT_HAS_NOT_SPEC_CATEGORY_BUFF, has_not_spec_category_buff).	% 筛选：筛选出无指定类别的buff的bo
-define(RDT_MON_NO_EQUAL_TO, mon_no_equal_to).							% 筛选：筛选出对应编号等于指定值的怪物bo
-define(RDT_POS_EQUAL_TO, pos_equal_to).								% 筛选：筛选出站位编号等于指定值的bo
-define(RDT_HAS_SPEC_SKILL, has_spec_skill).							% 筛选：筛选出有指定技能（主动技或被动技）的bo
-define(RDT_HAS_NOT_SPEC_SKILL, has_not_spec_skill).					% 筛选：筛选出无指定技能（主动技或被动技）的bo
-define(RDT_IS_CAN_USE_SKILL, is_can_use_skill).						% 筛选：筛选出当前可以使用指定技能（主动技）的bo
-define(RDT_IS_FROZEN, is_frozen).										% 筛选：筛选出处于冰冻状态的bo
-define(RDT_IS_TRANCE, is_trance).										% 筛选：筛选出处于昏睡状态的bo
-define(RDT_IS_CHAOS, is_chaos).										% 筛选：筛选出处于混乱状态的bo
-define(RDT_IS_SILENCE, is_silence).										% 筛选：筛选出处于沉默状态的bo
-define(RDT_IS_CDING, is_cding).										% 筛选：筛选出处于冷却状态的bo
-define(RDT_IS_XULIING, is_xuliing).									% 筛选：筛选出处于蓄力状态的bo
-define(RDT_IS_UNDER_CONTROL, is_under_control).						% 筛选：筛选出处于任意一种控制状态（冰冻|昏睡|混乱|冷却|蓄力）的目标
-define(RDT_IS_NOT_FROZEN, is_not_frozen).								% 筛选：筛选出不处于冰冻状态的bo
-define(RDT_IS_NOT_TRANCE, is_not_trance).								% 筛选：筛选出不处于昏睡状态的bo
-define(RDT_IS_NOT_CHAOS, is_not_chaos).								% 筛选：筛选出不处于混乱状态的bo
-define(RDT_IS_NOT_CDING, is_not_cding).								% 筛选：筛选出不处于冷却状态的bo
-define(RDT_IS_NOT_XULIING, is_not_xuliing).							% 筛选：筛选出不处于蓄力状态的bo
-define(RDT_IS_NOT_UNDER_CONTROL, is_not_under_control).				% 筛选：筛选出不处于任意一种控制状态（冰冻|昏睡|混乱|冷却|蓄力）的目标
-define(RDT_CAN_ANTI_INVISIBLE, can_anti_invisible).					% 筛选：筛选出有反隐状态的bo
-define(RDT_CANNOT_ANTI_INVISIBLE, cannot_anti_invisible).				% 筛选：筛选出没有反隐状态的bo

-define(RDT_LV_HIGHEST, lv_highest).  	  			  			% 筛选：筛选出等级最高的bo
-define(RDT_CUR_HP_HIGHEST, cur_hp_highest).  	  			  	% 筛选：筛选出当前血量最高的bo
-define(RDT_CUR_MP_HIGHEST, cur_mp_highest).  	  			  	% 筛选：筛选出当前蓝量最高的bo
-define(RDT_CUR_ANGER_HIGHEST, cur_anger_highest).  	  	  	% 筛选：筛选出当前怒气最高的bo
-define(RDT_PHY_ATT_HIGHEST, phy_att_highest).  	  		  	% 筛选：筛选出物理攻击最高的bo
-define(RDT_MAG_ATT_HIGHEST, mag_att_highest).  	  		  	% 筛选：筛选出法术攻击最高的bo
-define(RDT_PHY_DEF_HIGHEST, phy_def_highest).  	  		  	% 筛选：筛选出物理防御最高的bo
-define(RDT_MAG_DEF_HIGHEST, mag_def_highest).  	  			% 筛选：筛选出法术防御最高的bo
-define(RDT_SEAL_HIT_HIGHEST, seal_hit_highest).  	  			% 筛选：筛选出封印命中最高的bo
-define(RDT_SEAL_RESIS_HIGHEST, seal_resis_highest).  	  		% 筛选：筛选出封印抗性最高的bo
-define(RDT_ACT_SPEED_HIGHEST, act_speed_highest).  	  		% 筛选：筛选出出手速度最高的bo
-define(RDT_NOT_ACT_BO, no_act_bo).				% 筛选：筛选出还未出手的bo

-define(RDT_NOT_INVINCIBLE,not_invincible).						% 筛选非无敌Bo

-define(RDT_LV_LOWEST, lv_lowest).  	  			  			% 筛选：筛选出等级最低的bo
-define(RDT_CUR_HP_LOWEST, cur_hp_lowest).  	  			  	% 筛选：筛选出当前血量最低的bo
-define(RDT_CUR_MP_LOWEST, cur_mp_lowest).  	  			  	% 筛选：筛选出当前蓝量最低的bo
-define(RDT_CUR_ANGER_LOWEST, cur_anger_lowest).  	  			% 筛选：筛选出当前怒气最低的bo
-define(RDT_PHY_ATT_LOWEST, phy_att_lowest).  	  			  	% 筛选：筛选出物理攻击最低的bo
-define(RDT_MAG_ATT_LOWEST, mag_att_lowest).  	  				% 筛选：筛选出法术攻击最低的bo
-define(RDT_PHY_DEF_LOWEST, phy_def_lowest).  	  				% 筛选：筛选出物理防御最低的bo
-define(RDT_MAG_DEF_LOWEST, mag_def_lowest).  	  				% 筛选：筛选出法术防御最低的bo
-define(RDT_SEAL_HIT_LOWEST, seal_hit_lowest).  	  			% 筛选：筛选出封印命中最低的bo
-define(RDT_SEAL_RESIS_LOWEST, seal_resis_lowest).  	  		% 筛选：筛选出封印抗性最低的bo
-define(RDT_ACT_SPEED_LOWEST, act_speed_lowest).  	  			% 筛选：筛选出出手速度最低的bo

-define(RDT_LV_HIGHER_THAN, lv_higher_than).  	  			  	% 筛选：筛选出等级高于某固定值的bo
-define(RDT_CUR_HP_HIGHER_THAN, cur_hp_higher_than).  	  		% 筛选：筛选出当前血量高于某固定值的bo
-define(RDT_CUR_MP_HIGHER_THAN, cur_mp_higher_than).  	  		% 筛选：筛选出当前蓝量高于某固定值的bo
-define(RDT_CUR_ANGER_HIGHER_THAN, cur_anger_higher_than).  	% 筛选：筛选出当前怒气高于某固定值的bo
-define(RDT_PHY_ATT_HIGHER_THAN, phy_att_higher_than).  	  	% 筛选：筛选出物理攻击高于某固定值的bo
-define(RDT_MAG_ATT_HIGHER_THAN, mag_att_higher_than).  	  	% 筛选：筛选出法术攻击高于某固定值的bo
-define(RDT_PHY_DEF_HIGHER_THAN, phy_def_higher_than).  	  	% 筛选：筛选出物理防御高于某固定值的bo
-define(RDT_MAG_DEF_HIGHER_THAN, mag_def_higher_than).  	  	% 筛选：筛选出法术防御高于某固定值的bo
-define(RDT_SEAL_HIT_HIGHER_THAN, seal_hit_higher_than).  	  	% 筛选：筛选出封印命中高于某固定值的bo
-define(RDT_SEAL_RESIS_HIGHER_THAN, seal_resis_higher_than).  	% 筛选：筛选出封印抗性高于某固定值的bo
-define(RDT_ACT_SPEED_HIGHER_THAN, act_speed_higher_than).  	% 筛选：筛选出出手速度高于某固定值的bo

-define(RDT_LV_EQUAL_TO, lv_equal_to).  	  			  		% 筛选：筛选出等级等于某固定值的bo
-define(RDT_CUR_HP_EQUAL_TO, cur_hp_equal_to).  	  			% 筛选：筛选出当前血量等于某固定值的bo
-define(RDT_CUR_MP_EQUAL_TO, cur_mp_equal_to).  	  			% 筛选：筛选出当前蓝量等于某固定值的bo
-define(RDT_CUR_ANGER_EQUAL_TO, cur_anger_equal_to).  			% 筛选：筛选出当前怒气等于某固定值的bo
-define(RDT_PHY_ATT_EQUAL_TO, phy_att_equal_to).  	  			% 筛选：筛选出物理攻击等于某固定值的bo
-define(RDT_MAG_ATT_EQUAL_TO, mag_att_equal_to).  	  			% 筛选：筛选出法术攻击等于某固定值的bo
-define(RDT_PHY_DEF_EQUAL_TO, phy_def_equal_to).  	  			% 筛选：筛选出物理防御等于某固定值的bo
-define(RDT_MAG_DEF_EQUAL_TO, mag_def_equal_to).  	  			% 筛选：筛选出法术防御等于某固定值的bo
-define(RDT_SEAL_HIT_EQUAL_TO, seal_hit_equal_to).  	  		% 筛选：筛选出封印命中等于某固定值的bo
-define(RDT_SEAL_RESIS_EQUAL_TO, seal_resis_equal_to).  		% 筛选：筛选出封印抗性等于某固定值的bo
-define(RDT_ACT_SPEED_EQUAL_TO, act_speed_equal_to).  			% 筛选：筛选出出手速度等于某固定值的bo

-define(RDT_LV_LOWER_THAN, lv_lower_than).  	  			  	% 筛选：筛选出等级低于某固定值的bo
-define(RDT_CUR_HP_LOWER_THAN, cur_hp_lower_than).  	  		% 筛选：筛选出当前血量低于某固定值的bo
-define(RDT_CUR_MP_LOWER_THAN, cur_mp_lower_than).  	  		% 筛选：筛选出当前蓝量低于某固定值的bo
-define(RDT_CUR_ANGER_LOWER_THAN, cur_anger_lower_than).  		% 筛选：筛选出当前怒气低于某固定值的bo
-define(RDT_PHY_ATT_LOWER_THAN, phy_att_lower_than).  	  		% 筛选：筛选出物理攻击低于某固定值的bo
-define(RDT_MAG_ATT_LOWER_THAN, mag_att_lower_than).  	  		% 筛选：筛选出法术攻击低于某固定值的bo
-define(RDT_PHY_DEF_LOWER_THAN, phy_def_lower_than).  	  		% 筛选：筛选出物理防御低于某固定值的bo
-define(RDT_MAG_DEF_LOWER_THAN, mag_def_lower_than).  	  		% 筛选：筛选出法术防御低于某固定值的bo
-define(RDT_SEAL_HIT_LOWER_THAN, seal_hit_lower_than).  	  	% 筛选：筛选出封印命中低于某固定值的bo
-define(RDT_SEAL_RESIS_LOWER_THAN, seal_resis_lower_than).  	% 筛选：筛选出封印抗性低于某固定值的bo
-define(RDT_ACT_SPEED_LOWER_THAN, act_speed_lower_than).  		% 筛选：筛选出出手速度低于某固定值的bo

-define(RDT_CUR_HP_PERCENTAGE_HIGHER_THAN, cur_hp_percentage_higher_than).			% 筛选：筛选出当前血量的百分比高于某固定值的bo
-define(RDT_CUR_MP_PERCENTAGE_HIGHER_THAN, cur_mp_percentage_higher_than).			% 筛选：筛选出当前蓝量的百分比高于某固定值的bo
-define(RDT_CUR_ANGER_PERCENTAGE_HIGHER_THAN, cur_anger_percentage_higher_than).	% 筛选：筛选出当前怒气的百分比高于某固定值的bo

-define(RDT_CUR_HP_PERCENTAGE_EQUAL_TO, cur_hp_percentage_equal_to).				% 筛选：筛选出当前血量的百分比等于某固定值的bo
-define(RDT_CUR_MP_PERCENTAGE_EQUAL_TO, cur_mp_percentage_equal_to).				% 筛选：筛选出当前蓝量的百分比等于某固定值的bo
-define(RDT_CUR_ANGER_PERCENTAGE_EQUAL_TO, cur_anger_percentage_equal_to).			% 筛选：筛选出当前怒气的百分比等于某固定值的bo

-define(RDT_CUR_HP_PERCENTAGE_LOWER_THAN, cur_hp_percentage_lower_than).			% 筛选：筛选出当前血量的百分比低于某固定值的bo
-define(RDT_CUR_MP_PERCENTAGE_LOWER_THAN, cur_mp_percentage_lower_than).			% 筛选：筛选出当前蓝量的百分比低于某固定值的bo
-define(RDT_CUR_ANGER_PERCENTAGE_LOWER_THAN, cur_anger_percentage_lower_than).		% 筛选：筛选出当前怒气的百分比低于某固定值的bo




-define(RDT_SJJH_PRINCIPLE, sjjh_principle).  				  						% 排序：随机集火原则（按本场战斗预安排的随机站位顺序）
-define(RDT_CUR_PICK_TARGET_FIRST, cur_pick_target_first).    						% 排序：当前所选的目标优先
% -define(RDT_HAS_NOT_HOT_BUFF_FIRST, has_not_hot_buff_first).  						% 排序：无hot类buff者优先
% -define(RDT_HAS_NOT_DOT_BUFF_FIRST, has_not_dot_buff_first).  						% 排序：无dot类buff者优先
-define(RDT_HAS_SPEC_BUFF_FIRST, has_spec_buff_first).        						% 排序：有指定编号的buff者优先
-define(RDT_HAS_NOT_SPEC_BUFF_FIRST, has_not_spec_buff_first). 						% 排序：无指定编号的buff者优先
-define(RDT_SORT_BY_HP_ASCE, sort_by_hp_asce).                						% 排序：按血量从低到高排序
-define(RDT_SORT_BY_HP_DESC, sort_by_hp_desc).                						% 排序：按血量从高到低排序
-define(RDT_SORT_BY_MP_ASCE, sort_by_mp_asce).                						% 排序：按蓝量从低到高排序
-define(RDT_SORT_BY_MP_DESC, sort_by_mp_desc).                						% 排序：按蓝量从高到低排序

-define(RDT_SORT_BY_ACT_SPEED_ASCE, sort_by_act_speed_asce).                						% 排序：按速度从低到高排序
-define(RDT_SORT_BY_ACT_SPEED_DESC, sort_by_act_speed_desc).                						% 排序：按速度从高到低排序

-define(RDT_SORT_BY_PHY_ATT_ASCE, sort_by_phy_att_asce).                						% 排序：按物理攻击从低到高排序
-define(RDT_SORT_BY_PHY_ATT_DESC, sort_by_phy_att_desc).                						% 排序：按物理攻击从高到低排序
-define(RDT_SORT_BY_MAG_ATT_ASCE, sort_by_mag_att_asce).                						% 排序：按法术攻击从低到高排序
-define(RDT_SORT_BY_MAG_ATT_DESC, sort_by_mag_att_desc).                						% 排序：按法术攻击从高到低排序
-define(RDT_SORT_BY_PHY_DEF_ASCE, sort_by_phy_def_asce).                						% 排序：按物理防御从低到高排序
-define(RDT_SORT_BY_PHY_DEF_DESC, sort_by_phy_def_desc).                						% 排序：按物理防御从高到低排序
-define(RDT_SORT_BY_MAG_DEF_ASCE, sort_by_mag_def_asce).                						% 排序：按法术防御从低到高排序
-define(RDT_SORT_BY_MAG_DEF_DESC, sort_by_mag_def_desc).                						% 排序：按法术防御从高到低排序


-define(RDT_DEAD_FIRST, dead_first).                		  						% 排序：死亡者优先
-define(RDT_HAS_SPEC_CATEGORY_BUFF_FIRST, has_spec_category_buff_first). 			% 排序：有指定编号的buff者优先
-define(RDT_HAS_NOT_SPEC_CATEGORY_BUFF_FIRST, has_not_spec_category_buff_first).   	% 排序：无指定类别的buff者优先
% -define(RDT_HE_WHO_TAUNT_ME_FIRST, he_who_taunt_me_first).    						% 排序：当前嘲讽我的bo优先
-define(RDT_RE_DISORDER, re_disorder).   											% 排序：重新乱序目标列表
-define(RDT_NOT_FROZEN_FIRST, not_frozen_first).   									% 排序：不处于冰冻状态者优先
-define(RDT_NOT_TRANCE_FIRST, not_trance_first).   									% 排序：不处于昏睡状态者优先
-define(RDT_SPEC_MON_FIRST, spec_mon_first).   										% 排序：指定编号的战斗怪优先
-define(RDT_SPEC_CATEGORY_BUFF_FROM_FIRST, spec_category_buff_from_first).          % 排序：对我身上释放指定类别buff的bo优先 （buff来源优先）











%% ================== 以下是效果名的宏 ============================
%% ================== EN: 表示effect name =======================



% -define(EN_TMP_ADD_PHY_ATT, tmp_add_phy_att).     % 临时提升物理攻击

% -define(EN_TMP_ADD_ACT_SPEED, tmp_add_act_speed). % 临时提升出手速度

% -define(EN_TMP_FORCE_ATTACK, tmp_force_attack).   % 临时强行攻击（只能执行攻击，而不能执行其他的操作）
-define(EN_TMP_FORCE_AUTO_ATTACK, tmp_force_auto_attack).   % 临时强行自动攻击


% -define(EN_SET_PHY_COMBO_ATT_TIMES, set_phy_combo_att_times).   % 设置物理连击次数
% -define(EN_SET_MAX_HIT_OBJ_COUNT, set_max_hit_obj_count).   % 设置多目标物理攻击时，攻击目标的个数上限

%%新增的被动技能效果 wjc 219.11.14
-define(EN_TMP_KILL_TARGET_ADD_BUFF, tmp_kill_target_add_buff).   % 当前行动单位本次攻击击杀目标后加BUFF
-define(EN_TMP_SELECT_FIRST_ADD_BUFF, tmp_select_target_add_buff).   % 为本次技能所首选的单位添加BUFF
-define(EN_TMP_SELECT_FIRST_CAUSE_CRIT, tmp_select_first_cause_crit).   % 对本次技能所首选的单位攻击必定造成暴击



-define(EN_TMP_FORCE_SET_PHY_COMBO_ATT_TIMES, tmp_force_set_phy_combo_att_times).   % 临时强行设置可触发XX次物理连击


-define(EN_TMP_FORCE_SET_PURSUE_ATT_PROBA, tmp_force_set_pursue_att_proba).   % 临时强行设置追击概率
-define(EN_TMP_FORCE_SET_MAX_PURSUE_ATT_TIMES, tmp_force_set_max_pursue_att_times).   % 临时强行设置追击次数上限
-define(EN_TMP_FORCE_SET_PURSUE_ATT_DAM_COEF, tmp_force_set_pursue_att_dam_coef).  % 临时强行设置追击伤害系数

% -define(EN_TMP_FORCE_SET_PHY_COMBO_ATT_PROBA, tmp_force_set_phy_combo_att_proba).   % 临时强行设置物理连击概率
% -define(EN_TMP_FORCE_SET_MAX_PHY_COMBO_ATT_TIMES, tmp_force_set_max_phy_combo_att_times).   % 临时强行设置物理连击次数上限
% -define(EN_TMP_FORCE_MARK_PHY_COMBO_ATT_STATUS, tmp_force_mark_phy_combo_att_status).   % 临时强行标记为处于物理连击状态


-define(EN_TMP_MARK_DO_FIX_HP_DAM_BY_XINFA_LV, tmp_mark_do_fix_hp_dam_by_xinfa_lv).   % 临时标记在当前回合攻击时所造成的hp伤害为固定伤害（具体伤害值与心法等级相关）
-define(EN_TMP_MARK_DO_FIX_MP_DAM_BY_XINFA_LV, tmp_mark_do_fix_mp_dam_by_xinfa_lv).   % 临时标记在当前回合攻击时所造成的mp伤害为固定伤害（具体伤害值与心法等级相关）
-define(EN_TMP_MARK_DO_TWICE_PHY_ATT_BUT_REDUCE_PHY_ATT_BY_RATE, tmp_mark_do_twice_phy_att_but_reduce_phy_att_by_rate).   % 临时标记自己在当前回合有一定的几率连续物理攻击目标两次，但物理攻击力会降低一定比例
-define(EN_TMP_MARK_DO_DAM_BY_DEFER_HP_RATE_WITH_LIMIT, tmp_mark_do_dam_by_defer_hp_rate_with_limit).   % 临时标记当前回合攻击时，伤害值为受击方生命的一定比例，并有一个伤害上限


-define(EN_DO_ATTACK, do_attack).
-define(EN_ADD_BUFF, add_buff).   % 添加指定编号的buff
-define(EN_ADD_MULTI_BUFFS, add_multi_buffs).   % 添加多个指定编号的buff
-define(EN_PURGE_BUFF, purge_buff). % 驱散规定规则的buff

-define(EN_REDUCE_TARGET_MP_BY_DO_SKILL_ATT, reduce_target_mp_by_do_skill_att).   % 执行技能攻击时附带对目标伤蓝（扣目标的蓝）
-define(EN_REDUCE_TARGET_ANGER_BY_DO_SKILL_ATT, reduce_target_anger_by_do_skill_att).   % 执行技能攻击时附带扣（选定目标）的怒气(如果是负数表示增加)

-define(EN_HEAL_HP, heal_hp).        % 治疗：加血
-define(EN_HEAL_MP, heal_mp).        % 治疗：加蓝
-define(EN_HEAL_HP_MP, heal_hp_mp).        % 治疗：加血加蓝
-define(EN_REVIVE, revive).        % 复活
-define(EN_HEAL_HP_AND_ADD_BUFF, heal_hp_and_add_buff).        % 加血并加buff（通常是HOT类buff）
-define(EN_HEAL_MP_AND_ADD_BUFF, heal_mp_and_add_buff).        % 加蓝并加buff（通常是HOT类buff）

-define(EN_RECOVER_SELF_HP_BY_RATE, recover_self_hp_by_rate).        % 按比例恢复自身的hp

-define(EN_FORCE_DIE_AND_LEAVE_BATTLE, force_die_and_leave_battle).        % 强行死亡并离开战斗

-define(EN_SPLASH, splash).     % 溅射效果

%% 加血
-define(EN_ADD_HP_BY_QUALITY, add_hp_by_quality).
%% 加蓝
-define(EN_ADD_MP_BY_QUALITY, add_mp_by_quality).
%% 加血并加蓝
-define(EN_ADD_HP_MP_BY_QUALITY, add_hp_mp_by_quality).
%% 附带复活效果的加血
-define(EN_REVIVE_AND_ADD_HP_BY_QUALITY, revive_and_add_hp_by_quality).
%% 附带解控效果的加血
-define(EN_CLEARANCE_AND_ADD_HP_BY_QUALITY, clearance_and_add_hp_by_quality).


%% 	加血库
-define(EN_ADD_STORE_HP_BY_QUALITY, add_store_hp_by_quality). 
-define(EN_ADD_STORE_MP_BY_QUALITY, add_store_mp_by_quality).

%% 	加血库宠物专用
-define(EN_ADD_STORE_PAR_HP_BY_QUALITY, add_store_par_hp_by_quality).
-define(EN_ADD_STORE_PAR_MP_BY_QUALITY, add_store_par_mp_by_quality).

-define(EN_SUB_STR, sub_str).%% 力量
-define(EN_SUB_CON, sub_con).%% 体质
-define(EN_SUB_STA, sub_sta).%% 耐力
-define(EN_SUB_SPI, sub_spi).%% 智力
-define(EN_SUB_AGI, sub_agi).%% 敏捷

%% 加血
-define(EN_ADD_HP, add_hp).
%% 加蓝
-define(EN_ADD_MP, add_mp).
%% 加血并加蓝
-define(EN_ADD_HP_MP, add_hp_mp).
%% 附带复活效果的加血
-define(EN_REVIVE_AND_ADD_HP, revive_and_add_hp).
%% 附带复活效果的加血并加蓝
-define(EN_REVIVE_AND_ADD_HP_MP, revive_and_add_hp_mp).

%% 加xx%的血（百分比的基数为初始血量上限）
-define(EN_ADD_HP_BY_RATE, add_hp_by_rate).
%% 加xx%的魔法（百分比的基数为初始魔法上限）
-define(EN_ADD_MP_BY_RATE, add_mp_by_rate).

-define(EN_ADD_PHY_ATT, add_phy_att).  						% 提升物理攻击
-define(EN_REDUCE_PHY_ATT, reduce_phy_att).  				% 减少物理攻击

-define(EN_ADD_PHY_ATT_BY_RATE, add_phy_att_by_rate). 		% ...按比例
-define(EN_REDUCE_PHY_ATT_BY_RATE, reduce_phy_att_by_rate).
-define(EN_ADD_MAG_ATT, add_mag_att).  					    % 提升法术攻击
-define(EN_REDUCE_MAG_ATT, reduce_mag_att).  				% 减少法术攻击

-define(EN_ADD_MAG_ATT_BY_RATE, add_mag_att_by_rate).
-define(EN_REDUCE_MAG_ATT_BY_RATE, reduce_mag_att_by_rate).
-define(EN_ADD_PHY_DEF, add_phy_def).  					% 提升物理防御
-define(EN_ADD_PHY_DEF_BY_RATE, add_phy_def_by_rate).
-define(EN_REDUCE_PHY_DEF_BY_RATE, reduce_phy_def_by_rate).

-define(EN_ADD_MAG_DEF, add_mag_def).  					% 提升法术防御
-define(EN_ADD_NEGLECT_RER_DAM,add_neglect_ret_dam).  %提升忽视反震概率
-define(EN_ADD_MAG_DEF_BY_RATE, add_mag_def_by_rate).
-define(EN_REDUCE_MAG_DEF_BY_RATE, reduce_mag_def_by_rate).

-define(EN_ADD_ACT_SPEED, add_act_speed).  					% 提升出手速度
-define(EN_ADD_ACT_SPEED_BY_RATE, add_act_speed_by_rate).
-define(EN_REDUCE_ACT_SPEED_BY_RATE, reduce_act_speed_by_rate).
-define(EN_REDUCE_ACT_SPEED, reduce_act_speed). % 降低出手速度

-define(EN_ADD_HIT, add_hit).           			% 提升命中
-define(EN_ADD_HIT_BY_RATE, add_hit_by_rate).
-define(EN_REDUCE_HIT_BY_RATE, reduce_hit_by_rate).

-define(EN_ADD_DODGE, add_dodge). 					% 提升闪避
-define(EN_ADD_DODGE_BY_RATE, add_dodge_by_rate).
-define(EN_REDUCE_DODGE_BY_RATE, reduce_dodge_by_rate).

-define(EN_ADD_CRIT, add_crit). 					% 提升暴击
-define(EN_ADD_CRIT_BY_RATE, add_crit_by_rate).
-define(EN_REDUCE_CRIT_BY_RATE, reduce_crit_by_rate).
-define(EN_ADD_TEN, add_ten). 			% 提升坚韧（抗暴击）

-define(EN_ADD_CHAOS_RESIS, add_chaos_resis).  		% 提升混乱抗性
-define(EN_ADD_TRANCE_RESIS, add_trance_resis). 	% 提升昏睡抗性
-define(EN_ADD_FROZEN_RESIS, add_frozen_resis). 	% 提升冰冻抗性
-define(EN_ADD_SEAL_RESIS, add_seal_resis). 		% 提升封印抗性

-define(EN_ADD_STRIKEBACK_PROBA, add_strikeback_proba). 						% 提升反击几率
-define(EN_REDUCE_STRIKEBACK_PROBA, reduce_strikeback_proba). 					% 降低反击几率


-define(EN_ADD_PHY_COMBO_ATT_PROBA, add_phy_combo_att_proba). 					% 提升物理连击几率
-define(EN_REDUCE_PHY_COMBO_ATT_PROBA, reduce_phy_combo_att_proba). 			% 降低物理连击几率
-define(EN_ADD_MAG_COMBO_ATT_PROBA, add_mag_combo_att_proba). 					% 提升法术连击几率
-define(EN_REDUCE_MAG_COMBO_ATT_PROBA, reduce_mag_combo_att_proba). 			% 降低法术连击几率

-define(EN_ADD_PURSUE_ATT_PROBA, add_pursue_att_proba). 						% 提升追击几率

-define(EN_ADD_RET_DAM_PROBA, add_ret_dam_proba). 								% 提升反震（即反弹）几率
-define(EN_REDUCE_RET_DAM_PROBA, reduce_ret_dam_proba). 						% 降低反震（即反弹）几率



-define(EN_ADD_BE_HEAL_EFF_COEF, add_be_heal_eff_coef). 		% 提升被治疗效果系数
-define(EN_REDUCE_BE_HEAL_EFF_COEF, reduce_be_heal_eff_coef). 	% 降低被治疗效果系数

-define(EN_ADD_HEAL_EFF_COEF, add_heal_eff_coef). 		% 提升治疗效果系数
-define(EN_REDUCE_HEAL_EFF_COEF, reduce_heal_eff_coef). 	% 降低治疗效果系数

-define(EN_ADD_REVIVE_HEAL_COEF, add_revive_heal_coef). 		% 加复活恢复

-define(EN_REDUCE_PURSUE_ATT_DAM_COEF, reduce_pursue_att_dam_coef). 		% 减追击伤害

-define(EN_ADD_DO_PHY_DAM_SCALING, add_do_phy_dam_scaling). 	% 提升物理伤害放缩系数
-define(EN_ADD_DO_MAG_DAM_SCALING, add_do_mag_dam_scaling). 	% 提升法术伤害放缩系数
-define(EN_ADD_DO_DAM_SCALING, add_do_dam_scaling).				% 提升物理伤害放缩系数和法术伤害放缩系数

-define(EN_REDUCE_DO_PHY_DAM_SCALING, reduce_do_phy_dam_scaling). 	% 降低物理伤害放缩系数
-define(EN_REDUCE_DO_MAG_DAM_SCALING, reduce_do_mag_dam_scaling). 	% 降低物理伤害放缩系数
-define(EN_REDUCE_DO_DAM_SCALING, reduce_do_dam_scaling).			% 降低物理伤害放缩系数和法术伤害放缩系数

-define(EN_REDUCE_PHY_CRIT_COEF, reduce_phy_crit_coef).			% 降低物理暴伤
-define(EN_REDUCE_MAG_CRIT_COEF, reduce_mag_crit_coef).			% 降低法术暴伤



-define(EN_ADD_BE_PHY_DAM_REDUCE_COEF, add_be_phy_dam_reduce_coef).	% 提升物理伤害减免系数
-define(EN_ADD_BE_MAG_DAM_REDUCE_COEF, add_be_mag_dam_reduce_coef).	% 提升法术伤害减免系数
-define(EN_ADD_BE_DAM_REDUCE_COEF, add_be_dam_reduce_coef).			% 提升物理伤害减免系数和法术伤害减免系数

-define(EN_REDUCE_BE_PHY_DAM_REDUCE_COEF, reduce_be_phy_dam_reduce_coef).	% 降低物理伤害减免系数
-define(EN_REDUCE_BE_MAG_DAM_REDUCE_COEF, reduce_be_mag_dam_reduce_coef).	% 降低法术伤害减免系数
-define(EN_REDUCE_BE_DAM_REDUCE_COEF, reduce_be_dam_reduce_coef).			% 降低物理伤害减免系数和法术伤害减免系数

-define(EN_ADD_GEM_ATTE_RATE, add_gem_attr_rate).  %% (普通)完美搭配：宝石属性提高


-define(EN_ADD_MAX_PHY_COMBO_ATT_TIMES, add_max_phy_combo_att_times).     % 提升物理连击次数上限
-define(EN_ADD_MAX_MAG_COMBO_ATT_TIMES, add_max_mag_combo_att_times).     % 提升法术连击次数上限
-define(EN_ADD_MAX_PURSUE_ATT_TIMES, add_max_pursue_att_times).           % 提升追击次数上限
-define(EN_ADD_RET_DAM_COEF, add_ret_dam_coef).                           % 提升反震系数
-define(EN_ADD_PURSUE_ATT_DAM_COEF, add_pursue_att_dam_coef).             % 提升追击伤害系数
-define(EN_ADD_ABSORB_HP_COEF, add_absorb_hp_coef).                       % 提升吸血系数
-define(EN_ADD_QUGUI_COEF, add_qugui_coef).                               % 提升驱鬼系数
-define(EN_ADD_GHOST_PREP_STATUS, add_ghost_prep_status).                 % 添加鬼魂预备状态
-define(EN_ADD_REBORN_PREP_STATUS, add_reborn_prep_status).               % 添加重生预备状态
-define(EN_ADD_INVISIBLE_STATUS, add_invisible_status).                   % 添加隐身状态
-define(EN_ADD_ANTI_INVISIBLE_STATUS, add_anti_invisible_status).                   % 添加反隐身状态
-define(EN_ADD_QUGUI_STATUS, add_qugui_status).                           % 添加驱鬼状态
-define(EN_ADD_PREVENT_INVERSE_DAM_STATUS, add_prevent_inverse_dam_status).% 添加防止“反转伤害”状态

% -define(EN_SET_DAM_REDUCE_COEF_ON_PURSUE_ATT, set_dam_reduce_coef_on_pursue_att).   % 设定追击时的伤害衰减系数

-define(EN_REDUCE_DO_PHY_DAM_SCALING_WHEN_INVISIBLE, reduce_do_phy_dam_scaling_when_invisible).   % 隐身时降低物理伤害放缩系数

-define(EN_ADD_BUFF_ON_PHY_ATT_HIT, add_buff_on_phy_att_hit).   % 物理攻击命中时给目标添加buff
-define(EN_ADD_BUFF_ON_MAG_ATT_HIT, add_buff_on_mag_att_hit).   % 法术攻击命中时给目标添加buff
-define(EN_ADD_BUFF_ON_ATT_HIT, add_buff_on_att_hit).   % 物理攻击或法术攻击命中时给目标添加buff

% 新增被攻击时候的触发效果
-define(EN_ADD_BUFF_ON_BE_PHY_ATT_HIT, add_buff_on_be_phy_att_hit).   % 物理攻击命中时给目标添加buff
-define(EN_ADD_BUFF_ON_BE_MAG_ATT_HIT, add_buff_on_be_mag_att_hit).   % 法术攻击命中时给目标添加buff
-define(EN_ADD_BUFF_ON_BE_ATT_HIT, add_buff_on_be_att_hit).   % 物理攻击或法术攻击命中时给目标添加buff

%%新增血量少于或大于某个百分比时触发
-define(EN_ADD_BUFF_ON_HP_LOW, add_buff_on_hp_low).          % 血量低于某个百分比时的buff

%%回合开始时友方存活单位数量
-define(EN_ADD_BUFF_BEGIN_FRIEND_SURVIVAL, add_buff_begin_friend_survival).

%%回合开始时敌方存活单位数量
-define(EN_ADD_BUFF_BEGIN_ENEMY_SURVIVAL, add_buff_begin_enemy_survival).

%%自身行动时友方存活单位数量
-define(EN_ADD_BUFF_ACTION_FRIEND_SURVIVAL, add_buff_action_friend_survival).

%%自身行动时敌方存活单位数量
-define(EN_ADD_BUFF_ACTION_ENEMY_SURVIVAL, add_buff_action_enemy_survival).

%%敌方阵亡时加buff
-define(EN_ENEMY_WHILE_DIE, add_buff_enemy_while_die).

%%友方阵亡时加buff
-define(EN_FRIEND_WHILE_DIE, add_buff_friend_while_die).

%%自己阵亡时加buff
-define(EN_SELF_WHILE_DIE, add_buff_self_while_die).

%%有某个buff并到达指定层数时加buff
-define(EN_BUFF_ARRIVE_LAYER, add_buff_arrive_layer).

%%死亡时触发支援
-define(EN_DIE_TRRIGER_SUPPORT, die_trriger_support).

-define(EN_REDUCE_ANGER_ON_PHY_ATT_HIT, reduce_anger_on_phy_att_hit). %% 物理攻击命中时给目标掉怒气
-define(EN_REDUCE_ANGER_ON_MAG_ATT_HIT, reduce_anger_on_mag_att_hit). %% 法术攻击命中时给目标掉怒气
-define(EN_REDUCE_HP_ON_PHY_ATT_HIT_BASE_TARGET_MG_LIM, reduce_hp_on_phy_att_hit_base_target_mg_lim).   %% 基于目标法力上限，当物理攻击命中时给目标直接伤害
-define(EN_REDUCE_HP_ON_PHY_ATT_HIT_BASE_MG, reduce_hp_on_phy_att_hit_base_mg). 	  		 %% 基于自己当前法力值，当物理攻击命中时给目标物理伤害
-define(EN_REDUCE_HP_ON_MAG_ATT_HIT_BASE_MG, reduce_hp_on_mag_att_hit_base_mg). 	  	     %% 基于自己当前法力值，当法术攻击命中时给目标法术伤害

-define(EN_PROTECT_HP_BY_RATE_BASE_LIM, protect_hp_by_rate_base_hp_lim). 					 %% 单次受到伤害不可超过生命上限的百分之多少
-define(EN_REDUCE_DAM_BY_RATE_BASE_LIM, reduce_dam_by_rate_base_hp_lim). 	         %%受到伤害时，有一定概率抵挡伤害（抵挡伤害≤自身生命上限的A%）

-define(EN_DAM_IS_FULL, dam_is_full). 					 %% 伤害永远是满的无视恩赐

-define(EN_CHANGE_PHY_ATT_WHEN_HP_CHANGE, change_phy_att_when_hp_change).					     %% 每损失(获得)x的生命值将获得(减少)1点物理攻击加成
-define(EN_CHANGE_MAG_ATT_WHEN_HP_CHANGE, change_mag_att_when_hp_change).					     %% 每损失(获得)x的生命值将获得(减少)1点法术攻击加成

-define(EN_CHANGE_PHY_DEF_WHEN_HP_CHANGE_BY_RATE, change_phy_def_when_hp_change_by_rate).					     %% 每损失(获得)x%的生命值将获得(减少)1%点物理防御加成
-define(EN_CHANGE_MAG_DEF_WHEN_HP_CHANGE_BY_RATE, change_mag_def_when_hp_change_by_rate).					     %% 每损失(获得)x%的生命值将获得(减少)1%点法术防御加成

-define(EN_HOT_HP, hot_hp).                           % hot: 回血
-define(EN_HOT_MP, hot_mp).                           % hot: 回蓝
-define(EN_HOT_PHY_ATT, hot_phy_att).				  % hot: 提升物理攻击
-define(EN_HOT_MAG_ATT, hot_mag_att).				  % hot: 提升法术攻击

-define(EN_LENGTHEN_GOOD_BUFF_LASTING_ROUND, lengthen_good_buff_lasting_round).		% 延长增益buff的回合数
-define(EN_SHORTEN_BAD_BUFF_LASTING_ROUND, shorten_bad_buff_lasting_round).			% 缩短减益buff的回合数

-define(EN_FORCE_CHANGE_GOOD_BUFF_LASTING_ROUND, force_change_good_buff_lasting_round).	% 强行修改增益buff的回合数为指定的回合数
-define(EN_FORCE_CHANGE_BAD_BUFF_LASTING_ROUND, force_change_bad_buff_lasting_round).	% 强行修改减益buff的回合数为指定的回合数


-define(EN_ADD_NEGLECT_PHY_DEF,add_neglect_phy_def).	% 增加忽视物理防御
-define(EN_ADD_NEGLECT_MAG_DEF,add_neglect_mag_def).	% 增加忽视法术防御

-define(EN_ADD_PHY_DAM_TO_MON,add_phy_dam_to_mon).	% 增加物理伤害怪物加成
-define(EN_ADD_MAG_DAM_TO_MON,add_mag_dam_to_mon).	% 增加忽视法术怪物加成


-define(EN_PHY_CRIT_COEF,add_phy_crit_coef).	% 增加暴击物理伤害
-define(EN_MAG_CRIT_COEF,add_mag_crit_coef).	% 增加暴击法术伤害

%%新增被动
-define(EN_ADD_PHY_CRIT,add_phy_crit).	%       加物理暴击
-define(EN_REDUCE_PHY_CRIT,reduce_phy_crit).	% 减物理暴击

-define(EN_ADD_MAG_CRIT,add_mag_crit).	%       加法术暴击
-define(EN_REDUCE_MAG_CRIT,reduce_mag_crit).	% 减法术暴击

-define(EN_ADD_PHY_TEN,add_phy_ten).	%         加抗物理暴击
-define(EN_REDUCE_PHY_TEN,reduce_phy_ten).	%   减抗物理暴击

-define(EN_ADD_MAG_TEN,add_mag_ten).	%         加抗法术暴击
-define(EN_REDUCE_MAG_TEN,reduce_mag_ten).	%   减抗法术暴击

-define(EN_ADD_SEAL_HIT,add_seal_hit).	%    	加封印命中

-define(EN_ADD_SEAL_HIT_BY_RATE,add_seal_hit_by_rate).	%    	加封印命中百分比

-define(EN_REDUCE_SEAL_HIT_BY_RATE,reduce_seal_hit_by_rate).	%    	减封印命中百分比


-define(EN_ADD_SEAL_RESIS_BY_RATE,add_seal_resis_by_rate).	%    	加封印抗性百分比

-define(EN_REDUCE_SEAL_RESIS_BY_RATE,reduce_seal_resis_by_rate).	%    	减封印抗性百分比

-define(EN_ADD_NEGLECT_SEAL_RESIS,add_neglect_seal_resis).	%    	加忽视抗封







%%%% 20190924 新增被动buff触发给其他战斗对象施加额外的buff的buff
%%-define(EN_ACTIVE_BE_HIT_HP_CURRENT,				active_be_hit_hp_current).				% 当受击时血量达到特定条件时触发向特定对象施加buff
%%-define(EN_ACTIVE_ACTION_BEGIN_SELF_ALIVE,			active_action_begin_self_alive).		% 当友方存活单位数量达到条件时触发向特定对象施加buff
%%-define(EN_ACTIVE_ACTION_BEGIN_ENEMY_ALIVE,			active_action_begin_enemy_alive).		% 当敌方存活单位数量达到条件时触发向特定对象施加buff
%%-define(EN_ACTIVE_ACTION_BEGIN_SELF_DEAD,			active_action_begin_self_dead).			% 当友方阵亡单位数量达到条件时触发向特定对象施加buff
%%-define(EN_ACTIVE_ACTION_BEGIN_ENEMY_DEAD,			active_action_begin_enemy_dead).		% 当敌方阵亡单位数量达到条件时触发向特定对象施加buff
%%-define(EN_ACTIVE_BO_DIE_ENEMY,						active_bo_die_enemy).					% 当地方单位阵亡时触发向特定对象施加buff
%%-define(EN_ACTIVE_BO_DIE_SELF,						active_bo_die_self).					% 当友方单位阵亡时触发向特定对象施加buff
%%-define(EN_ACTIVE_BO_DIE_MYSELF,					active_bo_die_myself).					% 当自己阵亡时触发向特定对象施加buff
%%-define(EN_ACTIVE_ACTION_BEGIN_BUFF_LAYER,			active_action_begin_buff_layer).		% BUFF目标行动时存在指定层数的指定BUFF时加BUFF




%% 接受任务
-define(EN_ACCEPT_TASK, accept_task).

%% 标记完成任务
-define(EN_MARK_FINISH_TASK, mark_finish_task).

%%玩家使用物品获得宠物
-define(EN_GET_PARTNER, get_partner).

%%玩家使用物品变身
-define(EN_TRANSFIGURATION, transfiguration).

%%玩家使用物品获得坐骑
-define(EN_GET_MOUNTS, get_mounts).

%%玩家使用物品获得坐骑皮肤
-define(EN_GET_MOUNT_SKIN, add_mount_skin).


%% 传送到XXX
-define(EN_TELEPORT, teleport).
%% 重新激活暗雷
-define(EN_REACTIVATE_TRAP, reactivate_trap).
%% 使用某个战斗外技能
-define(EN_USE_SKILL, use_skill).

%% 添加体力
-define(EN_ADD_PHY_POWER, add_phy_power).
%% 添加活力
-define(EN_ADD_ENERGY, add_energy).
%% 添加怒气
-define(EN_ADD_ANGER, add_anger).

%% 获得指定编号的奖励包
-define(EN_GET_REWARD, get_reward).

%% 获得奖励（获得指定编号的奖励 或者 奖励池编号）
-define(EN_RAND_GET_REWARD, rand_get_reward).

%% 宠物相关的

%% 增加宠物寿命
-define(EN_ADD_LIFE, add_life).
%% 增加宠物忠诚度
-define(EN_ADD_LOYALTY, add_loyalty).

%% 宠物技能打书
-define(EN_CHANGE_SKILL, change_skill).

%% 完成任务:进度加1
-define(EN_FINISH_TASK, finish_task).

%% 经验
-define(EN_ADD_EXP, add_exp).

%% PK值
-define(EN_SUB_POPULAR, sub_popular).
-define(EN_ADD_POPULAR, add_popular).

%% 筹码
-define(EN_SUB_CHIP, sub_chip).
-define(EN_ADD_CHIP, add_chip).

%% 加多倍经验
-define(EN_ADD_MULTIPLE_EXP, add_multiple_exp).

%% 加绑银
-define(EN_ADD_BIND_GAMEMONEY, add_bind_gamemoney).

-define(EN_ADD_GAMEMONEY, add_gamemoney).

-define(EN_ADD_COPPER, add_copper).

-define(EN_ADD_CONTRI, add_contri).

-define(EN_ADD_GUILD_CONTRI, add_guild_contri).
-define(EN_ADD_GUILD_FEAT, add_guild_feat).

-define(EN_ADD_CHIVALROUS, add_chivalrous).
-define(EN_ADD_JINGWEN, add_jingwen).
-define(EN_ADD_YUANBAO, add_yuanbao).
-define(EN_ADD_MIJING, add_mijing).
-define(EN_ADD_HUANJING, add_huanjing).

-define(EN_ADD_INTEGRAL, add_integral).

%% 挖宝
-define(EN_TRIGGER_DIG_TREASURE, trigger_dig_treasure).

%% 激活vip充值返利
-define(EN_ACTIVATE_VIP_RECHARGE_REBATES, activate_vip_recharge_rebates).

%% 	加血库
-define(EN_ADD_STORE_HP, add_store_hp).
%%
-define(EN_ADD_STORE_MP, add_store_mp).

%% 	加血库宠物专用
-define(EN_ADD_STORE_PAR_HP, add_store_par_hp).

-define(EN_ADD_STORE_PAR_MP, add_store_par_mp).

%% 升级转换的天赋点恢复成潜能点
-define(EN_TURN_TALENT_TO_FREE, turn_talent_to_free).

%% 随机获得一个指定编号的物品
-define(EN_RAND_GET_GOODS, rand_get_goods).

%% 激活vip
-define(EN_ACTIVE_VIP, active_vip).

%% 使用后获得 x vip成长值
-define(EN_ADD_VIP_EXP, add_vip_exp).

%% 增加女妖进化值
-define(EN_ADD_PAR_EVOLVE, add_par_evolve).

%% 随机获得一个指定编号的宠物
-define(EN_RAND_GET_PAR, rand_get_par).

%% 增加女妖可携带容量
-define(EN_EXTEND_PAR_CAPACITY, extend_par_capacity).

-define(EN_ADD_TITLE, add_title).

%% 增加女妖可出战数量
-define(EN_EXPAND_FIGHT_PAR_CAPACITY, expand_fight_par_capacity).


%% 使用物品刷出明雷怪
-define(EN_SPAWN_MON, spawn_mon).

%获取翅膀
-define(EN_ADD_WING, get_chibang).


% %% 判定施法目标
% -define(EN_DECIDE_CAST_TARGET, decide_cast_target).

% %% 提升xx点物理攻击
% -define(EN_PHY_ATT_ADD, phy_att_add).
% %% 提升xx点法术攻击
% -define(EN_MAG_ATT_ADD, mag_att_add).
% %% 提升xx点绝技攻击
% -define(EN_STU_ATT_ADD, stu_att_add).


% %% 提升xx点物理防御
% -define(EN_PHY_DEF_ADD, phy_def_add).
% %% 提升xx点法术防御
% -define(EN_MAG_DEF_ADD, mag_def_add).
% %% 提升xx点绝技防御
% -define(EN_STU_DEF_ADD, stu_def_add).




% %% 提升xx%的物理攻击
% -define(EN_PHY_ATT_ADD_RATE, phy_att_add_rate).
% %% 提升xx%的法术攻击
% -define(EN_MAG_ATT_ADD_RATE, mag_att_add_rate).
% %% 提升xx%的绝技攻击
% -define(EN_STU_ATT_ADD_RATE, stu_att_add_rate).

% %% 提升xx%的物理防御
% -define(EN_PHY_DEF_ADD_RATE, phy_def_add_rate).
% %% 提升xx%的法术防御
% -define(EN_MAG_DEF_ADD_RATE, mag_def_add_rate).
% %% 提升xx%的绝技防御
% -define(EN_STU_DEF_ADD_RATE, stu_def_add_rate).



% %% 攻击者的暴击率加成
% -define(EN_CRIT_RATE_ADD, crit_rate_add).
% %% 受击者的被暴击的加成
% -define(EN_BE_CRIT_RATE_ADD, be_crit_rate_add).

% %% 提升xx%的闪避
% -define(EN_DODGE_RATE_ADD, dodge_rate_add).
% %% 提升xx%的格挡
% -define(EN_BLOCK_RATE_ADD, block_rate_add).




% %% 冻结怒气增长
% -define(EN_FREEZE_ANGER_ADD, freeze_anger_add).


% % %% 减少血量(以当前血量为基础)
% % -define(EN_SUB_HP_BY_RATE, sub_hp_by_rate).


-define(EN_ADD_HP_LIM, add_hp_lim).

%% 提升xx%的血量上限
-define(EN_ADD_HP_LIM_BY_RATE, add_hp_lim_by_rate).
-define(EN_REDUCE_HP_LIM_BY_RATE, reduce_hp_lim_by_rate).

-define(EN_ADD_MP_LIM_BY_RATE, add_mp_lim_by_rate).
-define(EN_REDUCE_MP_LIM_BY_RATE, reduce_mp_lim_by_rate).

%% 获得指定内功
-define(EN_GET_INTERNAL_SKILL, get_internal_skill).

%% 获得指定符印
-define(EN_GET_FABAO_RUNE, get_fabao_rune).

%% 使用代金券，累充金额增加
-define(EN_ADD_RECHARGE_MONEY, add_recharge_money).


%% 挖宝事件子事件宏定义
%% DT 表示 DIG_TREASURE
-define(DT_GET_MONEY, 1).    			%%.获得货币
-define(DT_GET_GOODS, 2).    			%%.获得物品
-define(DT_GET_GOLDEN_GOODS, 3).    	%%.获得密保
-define(DT_TRIGGER_BEGINNER_BATTLE, 4). %%.触发初级战斗
-define(DT_TRIGGER_MIDDLE_BATTLE, 5).   %%.触发中级战斗
-define(DT_TRIGGER_HIGH_BATTLE, 6).     %%.触发高级战斗
-define(DT_SPAWN_MON, 7).    			%%.触发刷出明雷怪




















-endif.  %% __EFFECT_H__
