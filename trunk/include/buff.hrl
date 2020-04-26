%%%------------------------------------------------
%%% File    : buff.hrl
%%% Author  : huangjf 
%%% Created : 2013.8.18
%%% Description: buff相关的宏
%%%------------------------------------------------




%% 避免头文件多重包含
-ifndef(__BUFF_H__).
-define(__BUFF_H__, 0).






%% buff模板
-record(buff_tpl, {
		no = 0,             % 编号
		name = no_name,     % 目前名字为atom类型

		icon = 0,

		category = 0,       % 类别（用于判定buff替换规则等）
		priority = 0,
		replacement_rule = 0,  % 替换规则（1：共存，2：替换，3：挤占）

		eff_type = good,    % good(增益buff) | bad(减益buff) | neutral（中性buff）|passi 被动效果buff

		max_overlap = 1,

		lasting_time = 0,    % 持续时间（战斗外），单位：秒
		handle_freq = 0,

		base_lasting_round = 0,   % 基础持续回合数（战斗内）
		calc_lasting_round_mode = 0,  % 计算实际持续回合数的方式， 1：固定为基础持续回合数， 2：按控制类buff的持续回合数的公式计算

		para = null,  % buff自身的参数


		is_removed_after_died = true,  % 是否死亡后移除


		% 用于参与计算buff效果的具体数值
		xinfa_coef = 0,   % 心法参数
		rate_coef = 0,    % 比例参数
		fix_value = 0,    % 固定值
		attr_rate = 0,    % 属性比例
		caster_attr_type = null,  % buff释放者的属性类型，如物攻，法攻， 默认为null，表示无意义
		receptor_attr_type = null,  % buff目标的属性类型
		op_mode = 0,	% buff运算类型lib_bt_calc中的do_calc_buff_eff_real_value判断用

		upper_limit_coef = 0,   % 属性影响的上限系数

		expire_events = [],   % buff到期时所触发的事件

		desc = <<"这里是buff模板的文字描述...">>
	}).



%% 玩家或宠物战斗外buff结构体
%% !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
%% ！！！！特别注意：因数据库obj_buff表的buff_list字段是直接存储本结构体列表，所以游戏正式上线后，千万不要修改本结构体内各字段的顺序！！！！！ -- zhangwq
%% !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-record(buff, {
		no = 0,				% buff编号
		start_time = 0,		% buff开始计时时间
		left_time = 0,		% buff剩余时间
        open_state = 0      % 0--不开启 1--开启
	}).

-record(obj_buff, {
		key = {},			% {player, PlayerId} or {partner, PartnerId}
		buff_list = []		% 角色buff列表，存buff结构体列表
	}).





%% 伪buff详情
-define(DUMMY_BUFF_DETAILS, <<
                                0 : 32,  % buff编号
                                0 : 16,  % 到期回合
                                0 : 8,   % 当前叠加层数
                                0 : 8,   % 参数1的类型
                                0 : 32,  % 参数1的值
                                0 : 8,   % 参数2的类型
                                0 : 32   % 参数2的值
                        >>).


%% 被移除的buff详情（半伪）
-define(REMOVED_BUFF_DETAILS(BuffNo), <<
                                        BuffNo  : 32,  % 被移除的buff的编号
                                        0       : 16,  % 到期回合
                                        0       : 8,   % 当前叠加层数
                                        0       : 8,   % 参数1的类型
                                        0       : 32,  % 参数1的值
                                        0       : 8,   % 参数2的类型
                                        0       : 32   % 参数2的值
                                >>).




%% 用9999表示buff或被动效果的持续回合数为无限
-define(PERMANENT_LASTING_ROUND, 9999).




%% --------- buff的名字(BFN: buff name) -----------
-define(BFN_CHAOS, chaos).  % 混乱
-define(BFN_XULI, xuli).    % 蓄力
-define(BFN_SILENCE, silence).    % 沉默


-define(BFN_TRANS_MAG_DEF_TO_MAG_ATT, trans_mag_def_to_mag_att).  % 转换法防为法攻（牺牲物防，以提高物攻）
-define(BFN_TRANS_PHY_DEF_TO_PHY_ATT, trans_phy_def_to_phy_att).  % 转换物防为物攻（牺牲物防，以提高物攻）
-define(BFN_TRANS_PHY_MAG_DEF_TO_PHY_ATT, trans_phy_mag_def_to_phy_att).  % 转换物防和法防为物攻（牺牲物防和法防，以提高物攻）
-define(BFN_FORCE_PARTNER_ESCAPE, force_partner_escape).                  % 命中此BUFF的宠物，将会被强制执行逃跑指令



% -define(BFN_TRANS_PHY_DEF_TO_ATT_TILL_DIE, trans_phy_def_to_att_till_die).  % 转换物理防御为物理攻击
-define(BFN_UNDEAD, undead).  % 抵挡死亡（至少保留1点血）
-define(BFN_UNDEAD_BUT_HEAL_HP_SHIELD, undead_but_heal_hp_shield).  % 抵挡死亡并且给自己恢复一定的hp
-define(BFN_TRANCE, trance).  % 昏睡
-define(BFN_FROZEN, frozen).  % 冰封

-define(BFN_IMMU_DAMAGE, immu_damage).  % 免疫伤害


-define(BFN_CD, cd).  % 冷却(cool down)


-define(BFN_AVOID_TRAP, avoid_trap).  % 屏蔽触发暗雷

-define(BFN_ADD_EXP, add_exp).        % 添加多倍经验

-define(BFN_ADD_ZHUOGUI_EXP, add_zhuogui_exp).        % 添加捉鬼多倍经验

-define(BFN_ADD_EXP_BIND_GAMEMONEY, add_exp_bind_gamemoney). %% 添加多倍经验和绑银

%% 帮派宴会buff
-define(BFN_ADD_DISHES_1, add_dishes_1).	% 普通餐食
-define(BFN_ADD_DISHES_2, add_dishes_2).	% 一丈见方
-define(BFN_ADD_DISHES_3, add_dishes_3).	% 满汉全席
-define(BFN_ADD_DISHES_4, add_dishes_4).	% 饕餮盛宴
-define(BFN_ADD_DISHES_5, add_dishes_5).	% 普通餐食
-define(BFN_ADD_DISHES_6, add_dishes_6).	% 一丈见方
-define(BFN_ADD_DISHES_7, add_dishes_7).	% 满汉全席
-define(BFN_ADD_DISHES_8, add_dishes_8).	% 饕餮盛宴
-define(BFN_ADD_DISHES_9, add_dishes_9).	% 普通餐食
-define(BFN_ADD_DISHES_10, add_dishes_10).	% 一丈见方
-define(BFN_ADD_DISHES_11, add_dishes_11).	% 满汉全席
-define(BFN_ADD_DISHES_12, add_dishes_12).	% 饕餮盛宴
-define(BFN_ADD_DISHES_13, add_dishes_13).	% 饕餮盛宴

%% pk buff
-define(BFN_PK_PROTECT, pk_protect).		% pk保护

-define(BFN_GUILD_WAR_PK_CD, guild_war_pk_cd).        % 帮派争霸赛 挑战冷却BUFF

-define(BFN_GUILD_WAR_PK_PROTECT, guild_war_pk_protect).        % 帮派争霸赛 被挑战保护BUFF

-define(BFN_MELEE_LEAVE_TEAM, melee_leave_team).        	% 女妖乱斗 离队后1分钟内无法发起决斗

-define(BFN_MELEE_TICK_OUT_MEMBER, melee_tick_out_member).	% 女妖乱斗 踢出队员后1分钟内无法发起决斗

-define(BFN_VIP_EXPERIENCE, vip_experience).% vip体验buff

% -define(BFN_TMP_FORCE_AUTO_ATTACK, tmp_force_auto_attack).  % 临时强行自动攻击

-define(BFN_FORCE_AUTO_ATTACK, force_auto_attack).  % 强行自动攻击

-define(BFN_AT_ONCE_PURGE_BUFF, at_once_purge_buff).  % 立即驱散buff

-define(BFN_REVEVI_ONE_ROUND, revevi_one_round).  % 复活一回合立马移除

-define(BFN_TMP_FORCE_SET_PHY_COMBO_ATT_TIMES, tmp_force_set_phy_combo_att_times).   % 临时强行设置可触发XX次物理连击

-define(BFN_TMP_FORCE_SET_PURSUE_ATT_PROBA, tmp_force_set_pursue_att_proba).   % 临时强行设置追击概率
-define(BFN_TMP_FORCE_SET_MAX_PURSUE_ATT_TIMES, tmp_force_set_max_pursue_att_times).   % 临时强行设置追击次数上限
-define(BFN_TMP_FORCE_SET_PURSUE_ATT_DAM_COEF, tmp_force_set_pursue_att_dam_coef).  % 临时强行设置追击伤害系数
-define(BFN_TMP_MARK_DO_DAM_BY_DEFER_HP_RATE_WITH_LIMIT, tmp_mark_do_dam_by_defer_hp_rate_with_limit).   % 临时标记当前回合攻击时，伤害值为受击方生命的一定比例，并有一个伤害上限
-define(BFN_FORCE_DIE_AND_LEAVE_BATTLE, force_die_and_leave_battle).        % 强行死亡并离开战斗

-define(BFN_HURT_HP_AT_ONCE, hurt_hp_at_once).  % 播放扣血

-define(BFN_HEAL_HP_AT_ONCE, heal_hp_at_once).  % 播放加血

-define(BFN_HEAL_ANGER_AT_ONCE, heal_anger_at_once).  % 加怒气

-define(BFN_HURT_ANGER_AT_ONCE, hurt_anger_at_once).  % 减怒气

-define(BFN_REDUCE_ANGER_COST , reduce_anger_cost).   %% 使用特技或技能时怒气消耗减少

-define(BFN_RECOVER_SELF_ANGER_BY_RATE, recover_self_anger_by_rate).  % 每回合多回复百分之比怒气怒气


-define(BFN_ADD_INSTABLE_DAM, add_instable_dam).   % 该目标攻击时伤害在100%~130%之间随机

-define(BFN_ADD_ACT_SPEED_SEQ, add_act_speed_seq).  % 添加干扰顺序buff


-define(BFN_REDUCE_SEAL_RESIS, reduce_seal_resis).  % 降低抗封能力
-define(BFN_ADD_SEAL_RESIS, add_seal_resis).  % 提高抗封能力

-define(BFN_ADD_NEGLECT_SEAL_RESIS, add_neglect_seal_resis).  % 提高忽视抗封能力




-define(BFN_AVATAR, avatar).				% 增加封印几率

-define(BFN_REDUCE_SEAL_HIT, reduce_seal_hit).  % 降低命中能力
-define(BFN_ADD_SEAL_HIT, add_seal_hit). 		% 提高命中能力



%%%%%%%%%%duanshihe 添加
-define(BFN_ADD_CRIT_COEF, add_crit_coef).  % 提高暴击伤害比率
-define(BFN_REDUCE_CRIT_COEF, reduce_crit_coef).  % 降低暴击伤害比率

%%% -define(BFN_DO_PHY_DAM_ENHANCE, do_phy_dam_enhance).  % 提升xx点物理伤害
%%% -define(BFN_BE_PHY_DAM_ENHANCE, be_phy_dam_enhance).  % 受物理伤害增加xx点

%%% -define(BFN_BE_MAG_DAM_ENHANCE_BY_RATE, be_mag_dam_enhance_by_rate).  % 受到的法术伤害增加一定的百分比

-define(BFN_REDUCE_BE_PHY_DAM_SHIELD, reduce_be_phy_dam_shield).  % 减轻所受物理伤害的护盾
-define(BFN_REDUCE_BE_MAG_DAM_SHIELD, reduce_be_mag_dam_shield).  % 减轻所受法术伤害的护盾
-define(BFN_ABSORB_PHY_DAM_TO_MP_SHIELD, absorb_phy_dam_to_mp_shield).  % 受到物理攻击时增加一定的mp的护盾
-define(BFN_REDUCE_BE_DAM_SHIELD, reduce_be_dam_shield   ).  % 减轻所受伤害的(免疫伤害)



-define(BFN_HOT_HP, hot_hp).  % HOT类buff，回血
-define(BFN_HOT_MP, hot_mp).  % HOT类buff，回蓝
-define(BFN_HOT_HP_MP, hot_hp_mp).  % HOT类buff，回血回蓝

-define(BFN_DOT_HP, dot_hp).  % DOT类buff，掉血
-define(BFN_DOT_MP, dot_mp).  % DOT类buff，掉蓝
-define(BFN_DOT_HP_MP, dot_hp_mp).  % DOT类buff，掉血掉蓝

-define(BFN_ADD_PHY_ATT, add_phy_att).        	% 提升物攻
-define(BFN_ADD_MAG_ATT, add_mag_att).        	% 提升法攻
-define(BFN_ADD_PHY_DEF, add_phy_def).        	% 提升物防
-define(BFN_ADD_MAG_DEF, add_mag_def).        	% 提升法防
-define(BFN_ADD_PHY_MAG_DEF, add_phy_mag_def).  % 提升物防和法防
-define(BFN_ADD_DODGE, add_dodge).        		% 提升闪避
-define(BFN_ADD_CRIT, add_crit).        		% 提升暴击


-define(BFN_ADD_BE_PHY_DAM_SHRINK, add_be_phy_dam_shrink).  % 增加物理伤害吸收
-define(BFN_ADD_BE_MAG_DAM_SHRINK, add_be_mag_dam_shrink).  % 增加法术伤害吸收

-define(BFN_ADD_MAG_CRIT, add_mag_crit).        		% 提升法术暴击
-define(BFN_ADD_PHY_CRIT, add_phy_crit).        		% 提升物理暴击
-define(BFN_REDUCE_PHY_CRIT, reduce_phy_crit).      % 降低物理暴击
-define(BFN_ADD_PHY_TEN, add_phy_ten).              % 提升物理抗暴击
-define(BFN_REDUCE_PHY_TEN, reduce_phy_ten).        % 降低物理抗暴击
-define(BFN_REDUCE_MAG_CRIT, reduce_mag_crit).      % 降低法术暴击
-define(BFN_ADD_MAG_TEN, add_mag_ten).              % 提升法术抗暴击
-define(BFN_REDUCE_MAG_TEN, reduce_mag_ten).        % 降低法术抗暴击





-define(BFN_REDUCE_PHY_ATT, reduce_phy_att).        			% 降低物攻
-define(BFN_REDUCE_MAG_ATT, reduce_mag_att).        			% 降低法攻
-define(BFN_REDUCE_PHY_DEF, reduce_phy_def).        			% 降低物防
-define(BFN_REDUCE_MAG_DEF, reduce_mag_def).        			% 降低法防
-define(BFN_REDUCE_PHY_MAG_DEF, reduce_phy_mag_def).    		% 降低物防和法防
-define(BFN_REDUCE_DODGE, reduce_dodge).  						% 降低闪避
-define(BFN_REDUCE_TEN, reduce_ten).      						% 降低坚韧（抗暴击）

-define(BFN_ADD_SEAL_HIT_BY_RATE, add_seal_hit_by_rate).    % 加封印命中百分比
-define(BFN_REDUCE_SEAL_HIT_BY_RATE, reduce_seal_hit_by_rate).    % 减封印命中百分比

-define(BFN_ADD_SEAL_RESIS_BY_RATE, add_seal_resis_by_rate).    % 加封印抗性百分比
-define(BFN_REDUCE_SEAL_RESIS_BY_RATE, reduce_seal_resis_by_rate).    % 减封印抗性百分比

-define(BFN_REDUCE_ACT_SPEED_BY_RATE, reduce_act_speed_by_rate).    % 减出手速度百分比
-define(BFN_ADD_ACT_SPEED_BY_RATE, add_act_speed_by_rate).    % 加出手速度百分比

-define(BFN_REDUCE_MAG_DEF_BY_RATE, reduce_mag_def_by_rate).  %减法术防御百分比
-define(BFN_ADD_MAG_DEF_BY_RATE, add_mag_def_by_rate).  %增加术防御百分比


-define(BFN_REDUCE_PHY_DEF_BY_RATE, reduce_phy_def_by_rate).  %减物理防御百分比
-define(BFN_ADD_PHY_DEF_BY_RATE, add_phy_def_by_rate).  %增加物理防御百分比

-define(BFN_REDUCE_MAG_ATT_BY_RATE, reduce_mag_att_by_rate).  %减少法术攻击百分比
-define(BFN_ADD_MAG_ATT_BY_RATE, add_mag_att_by_rate).  %增加法术攻击百分比

-define(BFN_REDUCE_PHY_ATT_BY_RATE, reduce_phy_att_by_rate).  %减少物理攻击百分比
-define(BFN_ADD_PHY_ATT_BY_RATE, add_phy_att_by_rate).  %增加物理攻击百分比

-define(BFN_REDUCE_HP_LIM_BY_RATE, reduce_hp_lim_by_rate). %减少生命上限百分比
-define(BFN_ADD_HP_LIM_BY_RATE, add_hp_lim_by_rate). %增加生命上限百分比

-define(BFN_ADD_HEAL_EFF_COEF, add_heal_eff_coef). %提升治疗效果系数
-define(BFN_REDUCE_HEAL_EFF_COEF, reduce_heal_eff_coef). %降低治疗效果系数

-define(BFN_ADD_REVIVE_HEAL_COEF, add_revive_heal_coef). %提升复活效果系数
-define(BFN_REDUCE_PURSUE_ATT_DAM_COEF, reduce_pursue_att_dam_coef). %减追击伤害

-define(BFN_REDUCE_PHY_CRIT_COEF, reduce_phy_crit_coef).			% 降低物理暴伤
-define(BFN_REDUCE_MAG_CRIT_COEF, reduce_mag_crit_coef).			% 降低法术暴伤

-define(BFN_ADD_PHY_CRIT_COEF, add_phy_crit_coef).			% 增加物理暴伤
-define(BFN_ADD_MAG_CRIT_COEF, add_mag_crit_coef).			% 增加法术暴伤

-define(BFN_WEAK, weak).        % 虚弱


-define(BFN_ADD_STRIKEBACK_PROBA, add_strikeback_proba).       			 % 提升反击概率

-define(BFN_ADD_PHY_COMBO_ATT_PROBA, add_phy_combo_att_proba).            % 提升物理连击概率
-define(BFN_ADD_MAG_COMBO_ATT_PROBA, add_mag_combo_att_proba).            % 提升法术连击概率


-define(BFN_ADD_ACT_SPEED, add_act_speed).        % 提升出手速度
-define(BFN_REDUCE_ACT_SPEED, reduce_act_speed).        % 降低出手速度


-define(BFN_PURGE_GOOD_BUFFS_BY_DO_PHY_DAM, purge_good_buffs_by_do_phy_dam).        % 物理攻击时有一定的几率驱散敌人身上的增益buff

-define(BFN_PURGE_BUFF_BY_ROUND_START, purge_buff_by_round_start).        % 回合开始有几率驱散BUFF


-define(BFN_YOUYING_MINGWANG, youying_mingwang).        % 幽影冥王技能所触发的buff（加出手速度，并且物理攻击时有一定的几率驱散敌人身上的增益buff）

-define(BFN_SHIXUE_MINGWANG, shixue_mingwang).        % 嗜血冥王技能所触发的buff（加抗封，并且物理攻击时附带嗜血效果）

-define(BFN_DALI_MINGWANG, dali_mingwang).        % 大力冥王技能所触发的buff（加暴击，提升连击率和连击次数上限）

-define(BFN_INVISIBLE, invisible).        			% 隐身
-define(BFN_ANTI_INVISIBLE, anti_invisible).        % 反隐身
-define(BFN_SOUL_SHACKLE, soul_shackle).        	% 灵魂禁锢
-define(BFN_CANNOT_BE_HEAL, cannot_be_heal).        % 禁疗（无法被治疗）
-define(REVIVE_FORBID,revive_forbid).               %%封印复活被动

%%%%%%%%%%duanshihe 添加
-define(BFN_ADD_RET_DAM_PROBA, add_ret_dam_proba). 							% 提升反震（即反弹）几率
-define(BFN_ADD_RET_DAM_COEF, add_ret_dam_coef).                           	% 提升反震系数
-define(BFN_ABSORB_HP_COEF, absorb_hp_coef).                           		% 提高吸血系数

-define(BFN_REVIVE_ADD_DAM, revive_add_dam).                           		% 复活1次并提高伤害

-define(BFN_INVINCIBLE, invincible).        								% 无敌
-define(BFN_IMMUNITY_CONTROL, immunity_control).        % 免疫控制

-define(BFN_ADD_BE_PHY_DAM_REDUCE_COEF, add_be_phy_dam_reduce_coef).        % 提升物理伤害减免系数
-define(BFN_ADD_BE_MAG_DAM_REDUCE_COEF, add_be_mag_dam_reduce_coef).        % 提升法术伤害减免系数
-define(BFN_ADD_BE_DAM_REDUCE_COEF, add_be_dam_reduce_coef).        % 提升物理伤害减免系数和法术伤害减免系数

-define(BFN_REDUCE_BE_PHY_DAM_REDUCE_COEF, reduce_be_phy_dam_reduce_coef).        % 降低物理伤害减免系数
-define(BFN_REDUCE_BE_MAG_DAM_REDUCE_COEF, reduce_be_mag_dam_reduce_coef).        % 降低法术伤害减免系数
-define(BFN_REDUCE_BE_DAM_REDUCE_COEF, reduce_be_dam_reduce_coef).        % 降低物理伤害减免系数和法术伤害减免系数


-define(BFN_ADD_DO_PHY_DAM_SCALING, add_do_phy_dam_scaling).        % 提升物理伤害放缩系数
-define(BFN_ADD_DO_MAG_DAM_SCALING, add_do_mag_dam_scaling).        % 提升法术伤害放缩系数
-define(BFN_ADD_DO_DAM_SCALING, add_do_dam_scaling).        % 提升物理伤害放缩系数和法术伤害放缩系数

-define(BFN_REDUCE_DO_PHY_DAM_SCALING, reduce_do_phy_dam_scaling).        % 降低物理伤害放缩系数
-define(BFN_REDUCE_DO_MAG_DAM_SCALING, reduce_do_mag_dam_scaling).        % 降低法术伤害放缩系数
-define(BFN_REDUCE_DO_DAM_SCALING, reduce_do_dam_scaling).        % 降低物理伤害放缩系数和法术伤害放缩系数

-define(BFN_ADD_BE_HEAL_EFF_COEF, add_be_heal_eff_coef).        % 提升被治疗效果系数
-define(BFN_REDUCE_BE_HEAL_EFF_COEF, reduce_be_heal_eff_coef).        % 降低被治疗效果系数

-define(BFN_ANTI_INVISIBLE_AND_ADD_PHY_MAG_ATT, anti_invisible_and_add_phy_mag_att).  % 反隐并且提升物攻和法攻

% 提升法术伤害减免系数，但同时降低物理伤害减免系数
% BMDR: be mag dam recude（法术伤害减免）,   BPDR: be phy dam recude（物理伤害减免）
-define(BFN_ADD_BMDR_COEF_BUT_REDUCE_BPDR_COEF, add_be_mag_dam_reduce_coef_but_reduce_be_phy_dam_reduce_coef). 

% 提升物理伤害减免系数，但同时降低法术伤害减免系数
-define(BFN_ADD_BPDR_COEF_BUT_REDUCE_BMDR_COEF, add_be_phy_dam_reduce_coef_but_reduce_be_mag_dam_reduce_coef).

%%新增buuf
%%如果A单位获得这个buff，则A单位使用任何技能都会触发这个额外效果（额外效果包括释放技能前，释放技能中，释放技能后，暴击时触发等）
-define(BFN_ADD_SKILL_EFF, add_skill_eff).

-define(BFN_BE_TAUNT, be_taunt).        % 被嘲讽

-define(BFN_BE_PROTECT, be_protect).    % 受保护

-define(BFN_DUMMY, dummy).              % 无任何效果的buff，只是用来做显示







%% --------- buff过期时所触发的事件(BEE: buff expire event) -----------
-define(BEE_ADD_BUFF, add_buff).                   % 添加buff
-define(BEE_TMP_ADD_PHY_ATT, tmp_add_phy_att).     % 临时提升物理攻击
-define(BEE_TMP_ADD_ACT_SPEED, tmp_add_act_speed). % 临时提升出手速度
-define(BEE_DEL_BUFF, del_buff).                   % 添加buff





% %% 移除buff的原因（RB: remove buff） 
% % 回合结束刷新
% -define(RB_EXPIRE,		   1).   % buff过期
% % 立即刷新
% -define(RB_PURGED, 		   2).   % 被驱散
% -define(RB_EFF_DISAPPEAR,  3).   % 效果消失了（比如护盾的效果消失了）
% -define(RB_REPLACED,       4).   % 被新的同类buff代替（包括叠加buff时先移除旧buff的情况）
% % 动作 + 清除debuff
% -define(RB_SKL_CLEAR, 5).   % 使用纯粹清除debuff的技能




% %% 改变怒气
% -define(CHANGE_ANGER, change_anger).

% %% 改变觉醒
% -define(CHANGE_AROUSAL, change_arousal).

% %% 召唤
-define(CALLING_MON, calling_mon).


%%----------------------------------------------------------------------------------

%% 某些buff的编号 与配置表保持一致

-define(BNO_PK_PROTECT, 20005).
-define(BNO_GUILD_WAR_PK_CD, 20007).
-define(BNO_GUILD_WAR_PK_PROTECT, 20008).
-define(BNO_MELEE_LEAVE_TEAM, 20009).
-define(BNO_MELEE_TICK_OUT_MEMBER, 20010).









-endif.  %% __BUFF_H__
