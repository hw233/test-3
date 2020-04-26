%%%------------------------------------------------
%%% File    : player.hrl
%%% Author  : huangjf
%%% Created : 2011-11-3
%%% Description: 角色的相关宏定义
%%%------------------------------------------------

% 避免头文件多重包含
-ifndef(__PLAYER_H__).
-define(__PLAYER_H__, 0).


-include("num_limits.hrl").


%% 计步器相关
%% regen: regenerate
-define(REGEN_STEP_COUNT_MIN, 75).
-define(REGEN_STEP_COUNT_MAX, 160).



%% 玩家的具体位置(player position)
-record(plyr_pos, {
			player_id = 0,         % 玩家id
			scene_id = 0,          % 所在场景的唯一id
			x = 0,                 % x坐标
			y = 0,                 % y坐标
			scene_line = 0,        % 所属的场景分线
			%%scene_grid_index = 0,  % 所在场景格子的索引，二维的{Grid_X, Grid_Y}形式
			step_counter = {0, 0}  % 计步器：{当前累计的计步数，最大计步数}
	}).


%% 属性成长系数
-record(attr_growth_coef, {
		no = 0,
		hp = 0,
		mp = 0,
		phy_att = 0,
		mag_att = 0,
		phy_def = 0,
		mag_def = 0,
		act_speed = 0,
		hit = 0,
		dodge = 0,
		crit = 0,
		ten = 0,
		seal_hit = 0,
		seal_resis = 0,
		heal_value = 0
	}).


%% 充值结构体
-record(recharge, {
	no = 0
	,money = 0
	,yuanbao = 0
	,type = 0
	,normal_feekback_num = 0
	,normal_feekback_type = 0
	,is_first = 0
	,first_feekback_num = 0
	,first_feekback_day = 0
	,first_feekback_type = 0
	,show_days = 0
	,mabey_mon = 0
	}).

%% 充值结构体
-record(first_recharge_reward, {
								money = 12,
								day = 1,
								reward_no = 91110
							   }).

%% 充值累积活动
-record(recharge_accum, {
	id = 0
	,start_time = 0
	,end_time = 0
	,content = []
	}).

%% 每日充值累积活动
-record(recharge_accum_day, {
	id = 0
	,start_time = 0
	,end_time = 0
	,content = []
	}).


%% 单笔充值活动
-record(recharge_one, {
	id = 0
	,start_time = 0
	,end_time = 0
	,content = []
	}).

%% 消费累积活动
-record(consume_activity, {
	no = 0
	,start_time = 0
	,end_time = 0
	,content = []
	}).

%% 活动查询
-record(admin_activity_query, {
	id = 0
	,start_time = 0
	,end_time = 0
	,content = []
	}).

%% 角色等级突破
-record(lv_break, {
			lv = 0,                     % 要突破的等级
			master_xinfa_lv_need = 0,   % 突破所需的主心法等级
			slave_xinfa_lv_need = 0,	% 突破所需的附属心法等级
			reward_str = 0,				% 突破后额外奖励的力量
			reward_con = 0,				% 突破后额外奖励的体质
			reward_sta = 0,				% 突破后额外奖励的耐力
			reward_spi = 0,				% 突破后额外奖励的灵力
			reward_agi = 0 				% 突破后额外奖励的敏捷
	}).

%% VIP配置
-record(vip_cfg,{
			lv  = 1,
			exp = 0
		}).

%% 离线挂机奖励
-record(data_offline_award, {
			lv            = 0,
			exp           = 0,
			cost          = 0,
			main_pet_exp  = 0,
			other_pet_exp = 0
}).

%% 飞升配置
-record(soaring_config, { 
    id = 0,
	goods = [],
	need_lv = 0,
	lv_limit = 0
    }).

%% 常驻累充配置
-record(recharge_accumulated,	{
		no = 1,
		need_recharge = 200,
		reward_no = 1
}).


%% 充值累积活动 玩家数据
-record(r_accum, {
					  activity_id = 0,
					  num = 0,
					  timestamp = 0,
					  reward_yet = []
					  }).

%% 每日充值累积活动 玩家数据
-record(r_accum_day, {
					  activity_id = 0,
					  num = 0,
					  timestamp = 0,
					  reward_yet = []
					  }).


%% 单笔充值活动
-record(r_accum_one, {
					  activity_id = 0,
					  timestamp = 0,
					  reward_valid = [],
					  reward_yet = []
					  }).


%% 累计消耗运营活动
-record(r_consume, {
					type = 0,			%% 固定的活动类型6/9
					activity_id = 0,    %% 当前有效活动id
					num = 0,			  %% 当前进度值
					timestamp = 0,
					reward_yet = []
				   }).

-record(player_vouchers_info, {
    player_id = 0,
    vouchers_no = 0,
	step_num = 0
}).

%% 无效的玩家id
% -define(INVALID_PLAYER_ID, 0).


%% 玩家的出生等级
-define(PLAYER_BORN_LV, 1).
%% 玩家的最大等级
-define(PLAYER_MAX_LV, data_special_config:get('break_lv')).


-define(PLAYER_BORN_CRIT, 20).    % 玩家的出生暴击
-define(PLAYER_BORN_TEN, 20).     % 玩家的出生坚韧（抗暴击）
-define(PLAYER_BORN_SEAL_HIT, 1). % 玩家的出生封印命中
-define(PLAYER_BORN_SEAL_RESIS, 1). % 玩家的出生封印抗性

%% 玩家初始属性预定义
-define(PLAYER_BORN_HP_LIMIT,620).				%初始生命
-define(PLAYER_BORN_MP_LIMIT,420).				%初始生命
-define(PLAYER_BORN_PHY_ATT,161).				%初始物理攻击
-define(PLAYER_BORN_MAG_ATT,130).				%初始法术攻击
-define(PLAYER_BORN_PHY_DEF,94).				%初始物理攻击
-define(PLAYER_BORN_MAG_DEF,82).				%初始法术攻击
-define(PLAYER_BORN_SPEED,14).					%初始速度

-define(PLAYER_BORN_PHY_CRIT,0).				%初始物理暴击
-define(PLAYER_BORN_PHY_TEN,0).					%初始抗物理暴击
-define(PLAYER_BORN_MAG_CRIT,0).				%初始法术暴击
-define(PLAYER_BORN_MAG_TEN,0).					%初始抗法术暴击
-define(PLAYER_BORN_PHY_CRIT_COEF,500).			%初始物理暴击程度 /1000
-define(PLAYER_BORN_MAG_CRIT_COEF,500).			%初始法术暴击程度 /1000

%% 天赋的最高点数
-define(MAX_TALENT_POINTS, ?MAX_U16).

-define(GROW_NORMAL, 1).  	% 经济 
-define(GROW_LUXURY, 2).    % 豪华    
-define(GROW_HONOUR, 3).    % 至尊

%% 手动升级的起始等级
-define(MANUAL_UPGRADE_START_LV, 120).


%% 手动分配自由天赋点的起始等级
-define(MANUAL_ALLOT_FREE_TALENT_POINTS_START_LV, 31).

%% 免费升级等级
-define(FREE_WASH_POINT_LV, 50).

%% 使用道具检测门派的等级
-define(USE_GOODS_CHECK_FACTION_LV, 15).


%% 天赋属性的个数（目前有5个: 力量，敏捷，耐力，体质，灵力）
-define(TOTAL_TALENT_COUNT, 5).

%% 玩家的出生场景和坐标
-define(BORN_SCENE_NO,  1303).
-define(BORN_POS_X,  12).
-define(BORN_POS_Y,  97).

%% 玩家的攻击距离
-define(PLAYER_ATT_DISTANCE, 24).


-define(NORMAIL_CARD, 1).  	% 普通卡
-define(MONTH_CARD, 2).		% 月卡
-define(MONTH_CARD_LIFE, 3). % 终身卡
-define(MONTH_CARD_WEEK, 4). % 周卡

-define(RECHARGE_FEEKBACK_COEF, 2). 	% 充值返还系数

-define(RECHARGE_UN_DEAL, 0). 		% 充值订单未处理
-define(RECHARGE_DEAL, 1).			% 充值订单已处理

% %% 从数据库的battle_data表获取战斗数据
% -define(SQL_QUERY_BATTLE_DATA, "hp_lim, phy_att, mag_att, spr_att, phy_def, mag_def, spr_def, "
% 				"hit, dodge, crit, block, battle_capacity, anger, soul_power, fight_order_factor, "
% 				"cur_troop, skills, fighting_objs").






%% player_status结构体中的字段名（atom类型），psf： player status field
-define(PSF_FACTION, faction).
-define(PSF_SEX, sex).
-define(PSF_SOARING, soaring).
-define(PSF_TRANSFIGURATION_NO, transfiguration_no).

-define(PSF_RACE, race).
-define(PSF_LV, lv).
-define(PSF_EXP, exp).
% -define(PSF_REPU, repu).
-define(PSF_PHY_POWER, phy_power).
-define(PSF_BASE_ATTRS, base_attrs).
-define(PSF_EQUIP_ADD_ATTRS, equip_add_attrs).
-define(PSF_XINFA_ADD_ATTRS, xinfa_add_attrs).
-define(PSF_TOTAL_ATTRS, total_attrs).
-define(PSF_IS_LEADER, is_leader).
-define(PSF_TEAM_ID, team_id).
-define(PSF_GAMEMONEY, gamemoney).
-define(PSF_BIND_GAMEMONEY, bind_gamemoney).
-define(PSF_YUANBAO, yuanbao).
-define(PSF_BIND_YUANBAO, bind_yuanbao).

-define(PSF_INTEGRAL, integral).
-define(PSF_COPPER, copper).
-define(PSF_CHIVALROUS, chivalrous).

-define(PSF_POPULAR,popular).
-define(PSF_KILL_NUM,kill_num).
-define(PSF_BE_KILL_NUM,be_kill_num).
-define(PSF_ENTER_GUILD_TIME,enter_guild_time).
-define(PSF_CHIP,chip).

-define(PSF_VITALITY, vitality).

-define(PSF_BASE_TALENT_STR, base_talent_str).
-define(PSF_BASE_TALENT_CON, base_talent_con).
-define(PSF_BASE_TALENT_STA, base_talent_sta).
-define(PSF_BASE_TALENT_SPI, base_talent_spi).
-define(PSF_BASE_TALENT_AGI, base_talent_agi).
-define(PSF_FREE_TALENT_POINTS, free_talent_points).

-define(PSF_FIGHTING_PARTNER_ID, fighting_partner_id).

-define(PSF_CUR_BHV_STATE, cur_bhv_state).
-define(PSF_CUR_BATTLE_ID, cur_battle_id).

-define(PSF_GUILD_ID, guild_id).
-define(PSF_GUILD_ATTRS, guild_attrs).
-define(PSF_LEAVE_GUILD_TIME, leave_guild_time).

-define(PSF_JINGMAI_INFOS, jingmai_infos).
-define(PSF_JINGMAI_POINT, jingmai_point).

-define(PSF_CULTIVATE_ATTRS, cultivate_attrs).
-define(PSF_TEAM_TAGET_TYPE, team_target_type).
-define(PSF_TEAM_CONDITION1, team_condition1).
-define(PSF_TEAM_CONDITION2, team_condition2).
-define(PSF_TEAM_LV_RANGE, team_lv_range).

-define(PSF_PARTNER_ID_LIST, partner_id_list).
-define(PSF_PARTNER_CAPACITY, partner_capacity).
-define(PSF_MAIN_PARTNER_ID, main_partner_id).
-define(PSF_FOLLOW_PARTNER_ID, follow_partner_id).
-define(PSF_FIGHT_PAR_CAPACITY, fight_par_capacity).

-define(PSF_BATTLE_POWER, battle_power).

-define(PSF_VIP_LV, vip_lv).

-define(PSF_SHOWING_EQUIPS, showing_equips).

-define(PSF_UPDATE_MOOD_COUNT, update_mood_count).
-define(PSF_LAST_UPDATE_MOOD_TIME, last_update_mood_time).
-define(PSF_RELA_LIST, rela_list).
-define(PSF_LAST_DAILY_RESET_TIME, last_daily_reset_time).
-define(PSF_LAST_WEEKLY_RESET_TIME, last_weekly_reset_time).

-define(PSF_XS_TASK_ISSUE_NUM, xs_task_issue_num).
-define(PSF_XS_TASK_LEFT_ISSUE_NUM, xs_task_left_issue_num).
-define(PSF_XS_TASK_RECEIVE_NUM, xs_task_receive_num).

-define(PSF_ZF_STATE, zf_state).
-define(PSF_MOUNT_ID_LIST, mount_id_list).

-define(PSF_VIP_INFO, vip).

-define(PSF_SUIT_NO, suit_no).
-define(PSF_LAST_TRANSFORM_FACTION_TIME, last_transform_time).
-define(PSF_DAY_TRANSFORM_FACTION_TIMES, day_transform_times).

%%-define(PSF_BASE_TALENTS, base_talents).
%%-define(PSF_TOTAL_TALENTS, total_talents).
%%-define(PSF_SHORTCUT_BAR, shortcut_bar).





%% 玩家进程标识
-record(ply_proc_flg, {
		id = 0,           % 玩家id
		pid = null        % 进程id
	}).


% 进程字典的key名（pdkn：表示process dictionary key name）
-define(PDKN_DETECT_HEART_TIME, pdkn_detect_heart_time).   % 心跳包时间检测
-define(PDKN_PLAYER_HEARTBEAT_COUNT, pdkn_player_heartbeat_count). % 玩家的心跳计数（这里的心跳是指服务端逻辑的玩家心跳，和客户端发送的心跳消息包没有关系！）
-define(PDKN_LAST_GC_TIMESTAMP, pdkn_last_gc_timestamp). % 上次做垃圾回收的时间戳
-define(PDKN_CUR_SCENE_ID_AND_NO, pdkn_cur_scene_id_and_no).  % 当前所在场景的id和编号
-define(PDKN_LAST_PROTO, pdkn_last_proto).  % 上次所收到的协议号
-define(PDKN_INIT_FOR_ENTER_GAME_DONE, pdkn_init_for_enter_game_done).  % 进游戏时是否已初始化完毕
-define(PDKN_DELAY_DO_FINAL_LOGOUT, pdkn_delay_do_final_logout).  % 下线时是否延迟执行final_logout()
-define(PDKN_ADMIN_CALLBACK_PID, pdkn_admin_callback_pid).  % 后台回调PID

-define(PDKN_LAST_REQ_BUILD_SPRD_RELA_TIME, pdkn_last_req_build_sprd_rela_time).  % 上次请求建立推广关系的时间点
-define(PDKN_LAST_SEARCH_MK_GOODS_TIME, pdkn_last_search_mk_goods_time). 	% 上次搜索拍卖行物品的时间
-define(PDKN_LAST_SEARCH_GUILD_TIME, pdkn_last_search_guild_time).    		% 上次搜索帮派列表的时间
-define(PDKN_LAST_STREN_EQUIP_TIME, pdkn_last_stren_equip_time).     		% 上次装备强化一键升级时间

-define(PDKN_PLAYER_PROC_FLAG, pdkn_player_proc_flag).						% 玩家进程标识
-define(PDKN_PLAYER_ID, pdkn_player_id).									% 玩家id

-define(PDKN_EQUIP_ADD_ATTRS, pdkn_equip_add_attrs).						% 装备的加成属性
-define(PDKN_XINFA_ADD_ATTRS, pdkn_xinfa_add_attrs).						% 心法的加成属性

-define(PDKN_LAST_BATTLE_START_TIME, pdkn_last_battle_start_time).          % 上一场战斗（目前只包含打怪或pk的情况）的开始时间，暂时仅用于辅助实现：避免同时发生触发暗雷战斗和跳转场景
-define(PDKN_LAST_BATTLE_FINISH_TIME, pdkn_last_battle_finish_time).        % 上一场战斗的结束时间

-define(PDKN_PHONE_INFO, pdkn_phone_info).                                  % 玩家的手机信息

-define(PDKN_TST_PLAYER_DROP_PROB_EXPAND, tst_player_drop_prob_expand). 	% 测试获取掉落放大的倍数


-define(PDKN_CROSS_STATE,	pdkn_cross_state).								% 玩家当前跨服状态 0：未跨服进程 | 1：跨服中本地进程(中转玩家协议到跨服服务器) | 2：跨服节点镜像进程

-define(PDKN_RECAST_TIMER, pdkn_recast_timer).




%% 玩家可以携带的武将的最大数量（目前最多可以携带8个武将）
-define(MAX_ALIVE_PARTNER_COUNT, 8).









% %% 体力的增减
% %%-define(PLAYER_POWER_LIMIT, 200).   % 玩家体力值上限(固定值)
% -define(ADD_POWER_PER_30_MIN, 5).   % (自动回复)体力增加
% -define(POWER_INCREASE, 40).   % (购买)体力增加
% -define(POWER_DECREASE, 10).   % (关卡)体力消耗
% -define(POWER_BUFF, 50).   % (体力buff)12、18点系统赠予50点体力buff
% -define(COST_BUY_POWER, 20).   % 购买体力固定花费的元宝








%% VIP 相关
-define(VIP_YUANBAO_EXP_RATIO, 1).   % 元宝对VIP经验比率


% -define(BOOKING_GIFT, 181000005).	%预定礼包

% % 定时更新称号（单位：秒）为18分钟
% -define(UPDATE_TITLE_TIMER, 18*60*1000).




% %% 显示获得东西类型
% -define(DISPLAY_GOODS, 1).  %物品
% -define(DISPLAY_EXP, 2).	%经验
% -define(DISPLAY_UBCOIN, 3).	%非绑定金币
% -define(DISPLAY_COIN, 4).	%绑定金币
% -define(DISPLAY_ZTM, 5).	%战天币
% -define(DISPLAY_GOLD, 6).	%元宝
% -define(DISPLAY_SOUL, 7).	%战魂点
% -define(DISPLAY_AR_ACC_POINTS, 8).	%勇勋值（竞技场积分）
% -define(DISPLAY_PRES, 9).	%个人声望
% -define(DISPLAY_G_PRES, 10).	%帮会声望
% -define(DISPLAY_PARTNER, 11).	%武将





%% 角色被禁相关
-define(EXCEPTION_CHAT_PROTOL, [11201, 11202, 11203, 11204, 11205, 11009, 11300, 11301]).    %% 非封禁的例外协议

-define(BAN_CHAT, {ban, ban_chat}).   % 禁言
-define(BAN_ROLE, {ban, ban_role}).         %禁角色
-define(BAN_PHONE, {ban, ban_phone}).         %禁手机号

-define(FORVER_BAN_TIME, 1).          % 永远封禁值
-define(CANCEL_BAN_TIME, 0).          % 取消封禁值



-define(KILL_ONE_SUB_POPULAR, 20).          % 每杀一个人人气值减少

-define(KILL_SUB_EXT_COEF, 0.12).          % 被杀经验减少 当前经验的30%

-define(PRISON_POPULAR, 150).          % 蹲牢狱需要的pk值 
-define(LEAVE_PRISON_POPULAR, 50).     % 离开监狱需要PK值低于 
-define(RED_NAME_POPULAR, 100).          % 蹲红名需要的pk值 



-define(JINGMAI_ADD_GOODS_NO, 10043).          % 经脉提升道具编号 






-endif.  % __PLAYER_H__
