%%%------------------------------------------------
%%% File    : battle.hrl
%%% Author  : huangjf 
%%% Created : 2012.4.20
%%% Description: 战斗系统相关的宏
%%%------------------------------------------------


%% 避免头文件多重包含
-ifndef(__BATTLE_H__).
-define(__BATTLE_H__, 0).


% %% 无效的校验码
% -define(INVALID_CHECK_CODE, 0).

% %% 无效的战斗对象id
% -define(INVALID_BO_ID, 0).

%% 起始战斗对象id （从1开始）
-define(START_BO_ID, 1).


% %% 第0个格子位置
% -define(GRID_0, 0).

% %% 技能当前可以使用
% -define(CAN_USE, true).

% %% 技能当前不可使用
% -define(CANNOT_USE, false).


%% 默认的战斗回合数上限（回合数超过此上限，则立即终止战斗）
-define(DFL_MAX_BATTLE_ROUND, 150).




%% 等待客户端下达指令的最长时间（30秒）
-define(MAX_WAIT_TIME_FOR_PREPARE_CMD_SEC, 30).




%% 等待所有客户端播放完战报的最长时间（暂定60秒）
-define(MAX_WAIT_TIME_FOR_SHOW_BR_SEC, 60).


% %% 战斗对象类型，BO表示battle object
% -define(BO_INVALID, 0).  %% 无效的战斗对象类型
% -define(BO_MONSTER, 1).  %% 怪物
% -define(BO_PLAYER,  2).  %% 玩家
% -define(BO_PARTNER, 3).  %% 武将
% -define(BO_PET,     4).  %% 宠物
% -define(BO_BOSS,    5).  %% BOSS
% -define(BO_NPC,     6).  %% NPC


%% 单场战斗中所允许的召唤宠物的最大次数
-define(MAX_SUMMON_PARTNER_TIMES, 10).



% 不属于任何一方
-define(NO_SIDE, 0).

% 战场双方中的一方：主队
-define(HOST_SIDE, 1).
% 战场双方中的一方：客队
-define(GUEST_SIDE, 2).




-define(PLAYER_DFL_SIDE, ?HOST_SIDE).     % 玩家默认所属方：主队
-define(PARTNER_DFL_SIDE, ?HOST_SIDE).    % 宠物默认所属方：主队
-define(MON_DFL_SIDE, ?GUEST_SIDE).       % 怪物默认所属方：客队



%% 无效的战场位置
-define(INVALID_BATTLE_POS, 0).

%% 战场中一方的最小位置序号
-define(MIN_BATTLE_POS, 1).

%% 战场中一方的最大位置序号
-define(MAX_BATTLE_POS_PER_SIDE, 15).


%% 战场中一方的bo的最大数量
-define(MAX_BO_COUNT_PER_SIDE, 10).

%% 战场中最大重生次数
-define(MAX_REBORN_COUNT, 3).




%% 队伍中普通队员（非队长）的站位顺序列表
-define(BATTLE_POS_ORDER_FOR_NORMAL_TEAM_MEMBERS, [7, 9, 6, 10]).
%% 副宠的站位顺序列表
-define(BATTLE_POS_ORDER_FOR_DEPUTY_PARTNER, [2, 4, 1, 5]).
%% 宠物的站位顺序列表
-define(BATTLE_POS_ORDER_FOR_PARTNER, [3, 2, 4, 1, 5]).
%% 队长的站位（固定是在后排的中央位置）
-define(BATTLE_POS_FOR_LEADER, 8).

%% 战斗中一方的站位顺序列表 -- 同时用于“策划位置站位”转“程序站位” (见pt_20.hrl)
-define(BATTLE_POS_ORDER_PER_SIDE, [8, 7, 9, 6, 10, 3, 2, 4, 1, 5]).
%% --用于“程序站位”转“策划配置站位”(见pt_20.hrl)
-define(BATTLE_POS_ORDER_CFG_SIDE, [9, 7, 6, 8, 10, 4, 2, 1, 3, 5]).






%% 无效的整型参数
-define(INVALID_INT_PARA, 0).


%% 战斗进程的进程字典的key名(KN: key name)
-define(KN_BATTLE_LOG_FILE_FD, kn_battle_log_file_fd).
-define(KN_BATTLE_STATE, kn_battle_state).
-define(KN_CUR_ACTOR_LIST, kn_cur_actor_list).
-define(KN_CUR_ACTOR_ID, kn_cur_actor_id).
-define(KN_CUR_REACTOR_ID, kn_cur_reactor_id).
% -define(KN_HOST_SIDE_PRESET_RAND_POS_ORDER, kn_host_side_preset_rand_pos_order).    % 本场战斗预安排的随机站位顺序（主队），用于辅助实现随机集火原则
% -define(KN_GUEST_SIDE_PRESET_RAND_POS_ORDER, kn_guest_side_preset_rand_pos_order).  % 本场战斗预安排的随机站位顺序（客队），用于辅助实现随机集火原则
-define(KN_PRESET_RAND_POS_ORDER, kn_preset_rand_pos_order).  % 本场战斗预安排的随机站位顺序，用于辅助实现随机集火原则
-define(KN_COLLECTED_REPORTS, kn_collected_reports).  % 当前已收集的战报
-define(KN_HOST_SIDE_BO_ID_LIST, kn_host_side_bo_id_list).
-define(KN_GUEST_SIDE_BO_ID_LIST, kn_guest_side_bo_id_list).
-define(KN_SPAWNED_BMON_LIST, kn_spawned_bmon_list).  % 已刷出的战斗怪列表

-define(KN_DEAD_PARTNER_LEFT_MP, kn_dead_partner_left_mp).   % 宠物的剩余蓝量
-define(KN_WORLD_BOSS_MF_INFO, kn_world_boss_mf_info).   % 世界boss战斗的信息

-define(KN_INTIMACY_BETWEEN, kn_intimacy_between).       % 两个bo之间的好友度
-define(KN_ALREADY_FEEDBACK_TO_TEAM_OF_SIDE, kn_already_feedback_to_team_of_side). % 战斗结果是否已经反馈给某一方的队伍了？

-define(KN_MELEE_INIT_PLAYER_ID_LIST, kn_melee_init_player_id_list).  % 女妖乱斗活动的战斗开始时某一方的玩家id列表（不包括雇佣的玩家）

-define(KN_SHOULD_CUR_ROUND_FORCE_FINISH, kn_should_cur_round_force_finish). % 当前回合是否需要强行立即结束




%% 为哪个bo下指令？
-define(PREPARE_CMD_FOR_PLAYER_SELF, 1).        % 表示是为玩家自己下指令
-define(PREPARE_CMD_FOR_MAIN_PARTNER, 2).  		% 表示是为主宠下指令
-define(PREPARE_CMD_FOR_HIRED_PLAYER, 3).  		% 表示是为雇佣玩家下指令
-define(PREPARE_CMD_FOR_PLOT_BO, 4).  			% 表示是为剧情bo下指令




-define(PK_T_QIECUO, 1).  % pk类型：切磋
-define(PK_T_FORCE, 2).  % pk类型：强行pk
-define(PK_T_1V1_ONLINE_ARENA, 3).  % pk类型：在线1v1竞技场（比武大会）
-define(PK_T_GUILD_WAR, 4).  % pk类型：帮派争夺战
-define(PK_T_MELEE, 5).      % pk类型：女妖乱斗活动pk
-define(PK_T_3V3_ONLINE_ARENA, 6). %pk类型：在线3v3竞技场
-define(PK_T_CROSS_3V3, 7). %pk类型：跨服3v3竞技场




%% 战斗类型
-define(BTL_T_PVE, 			1).	   	% Player VS Environment
-define(BTL_T_PVP, 			2).	   	% Player VS Player
%% 战斗子类型
-define(BTL_SUB_T_NONE, 				0).	    % 无效子类型
-define(BTL_SUB_T_MIN, 				    1).	    % 最小子类型
-define(BTL_SUB_T_NORMAL_MF, 			1).		% 普通打怪（这是打怪时的默认子类型）
-define(BTL_SUB_T_OFFLINE_ARENA, 		2).		% 离线竞技场
-define(BTL_SUB_T_1V1_ONLINE_ARENA, 	3).		% 在线1V1竞技场
-define(BTL_SUB_T_TEAM_ONLINE_ARENA, 	4).		% 在线组队竞技场
-define(BTL_SUB_T_PK_QIECUO, 			5).		% pk：切磋
-define(BTL_SUB_T_PK_FORCE, 			6).		% pk：强行pk
-define(BTL_SUB_T_WORLD_BOSS_MF, 		7).		% 打世界boss
-define(BTL_SUB_T_HIJACK,               8).     % 劫镖
-define(BTL_SUB_T_GUILD_WAR,            9).     % 帮派争夺战
-define(BTL_SUB_T_MELEE_PK,             10).    % 女妖乱斗活动pk
-define(BTL_SUB_T_MELEE_MF,             11).    % 女妖乱斗活动mf
-define(BTL_SUB_T_TVE_MF,               12).    % 三界副本mf
-define(BTL_SUB_T_MAX, 				    30).	% 最大子类型
-define(BTL_SUB_T_3V3_ONLINE_ARENA,     13).    % 在线3v3竞技场
-define(BTL_SUB_T_CROSS_3V3,            14).    % 跨服3v3
-define(BTL_SUB_T_CROSS_3V3_ROBORT,     15).    % 跨服3v3机器人

-define(BTL_SUB_T_TIMEBATTLE, 				  16).	  % 多少回合内胜利
-define(BTL_SUB_T_DEFENSE,              17).    % 坚持多少回合
-define(BTL_SUB_T_HURT,                 18).    % 伤害达到多少

-define(BTL_SUB_T_MYSTREY,              20).    % 大秘境


-define(BTL_SUB_T_GUILD_BOSS_MF,       1 ).    % 帮派副本BOSS

% -define(BTL_SUB_T_CG, 					2).		% 剧情CG战斗
% -define(BTL_SUB_T_ARENA_PK_ONLINE, 		4).		% 竞技场在线pk
% -define(BTL_SUB_T_WANTED_MF, 			5).		% 通缉令打怪
% -define(BTL_SUB_T_WANTED_PK_OFFLINE, 	6).		% 通缉令离线pk
% -define(BTL_SUB_T_RICH_MF, 				7).		% 灵界打怪
% -define(BTL_SUB_T_RICH_PK_ONLINE, 		8).		% 灵界在线pk
% -define(BTL_SUB_T_GUILD_PK_ONLINE, 		9).		% 帮派战在线pk
% -define(BTL_SUB_T_TREVI_MF, 			10).	% 许愿池打怪
% -define(BTL_SUB_T_TOWER_MF, 			11).	% 爬塔打怪
% -define(BTL_SUB_T_CHAL_WORLDBOSS, 		12).	% 打世界boss
% -define(BTL_SUB_T_GODS_PK_ONLINE, 		13).	% 诸神战场PK





%% 战斗自身的行为状态（根据需要，目前分三大状态）
-define(BHV_WAITING_CLIENTS_FOR_PREPARE_CMD_DONE, 1).  % 等待客户端下达完指令
-define(BHV_WAITING_CLIENTS_FOR_SHOW_BR_DONE, 2).  % 等待客户端播放完战报
-define(BHV_HANDLING_ROUND_ACTIONS, 3).  % 正在处理当前回合的行动






%% 攻击的子类型（目前实际上仅有物理攻击的子类型）
%% 注：攻击类型见skill.hrl(ATT_T_XXX)
-define(ATT_SUB_T_NONE,       0).  % 无意义
-define(ATT_SUB_T_NORMAL,     1).  % 普通攻击
-define(ATT_SUB_T_STRIKEBACK, 2).  % 反击
-define(ATT_SUB_T_COMBO,      3).  % 连击
-define(ATT_SUB_T_PURSUE,     4).  % 追击
% 其他。。




%% 战报类型(BR: battle report,  BO: battle object,  BOS: battle objects)
-define(BR_T_BO_DO_PHY_ATT, 	1).      % bo执行物理攻击
-define(BR_T_BO_DO_MAG_ATT, 	2).      % bo执行法术攻击
-define(BR_T_BO_CAST_BUFFS,  	3).      % bo施法：添加或驱散buff
-define(BR_T_BO_DO_HEAL,   		4).      % bo执行治疗
-define(BR_T_BO_DO_REVIVE, 	    5).      % bo执行复活
-define(BR_T_BO_DO_SUMMON,      6).      % bo执行召唤
-define(BR_T_BO_ESCAPE,      	7).      % bo逃跑
-define(BR_T_BOS_FORCE_DIE,     8).      % 一或多个bo强行死亡
-define(BR_T_BO_USE_GOODS,      9).      % bo使用物品
-define(BR_T_SEND_TIPS,        10).      % 发送战斗提示信息



%% 治疗的类型
-define(HEAL_T_HP, 1).  % 加血
-define(HEAL_T_MP, 2).  % 加蓝
-define(HEAL_T_HP_MP, 3).  % 加血加蓝
-define(HEAL_T_ANGER, 4).  % 加怒气


%% 玩家每回合自动增长xx点觉醒值
-define(AROUSAL_AUTO_GAIN_EACH_TURN, 25).



%% 玩家下达的指令类型
-define(CMD_T_INVALID,   		0).   % 无效类型
-define(CMD_T_USE_SKILL, 		1).   % 使用技能
-define(CMD_T_USE_GOODS, 		2).   % 使用物品
-define(CMD_T_DEFEND, 	 		3).   % 防御
-define(CMD_T_PROTECT, 	 		4).   % 保护
-define(CMD_T_ESCAPE, 	 		5).   % 逃跑
-define(CMD_T_CAPTURE_PARTNER, 	6).   % 捕捉宠物
-define(CMD_T_SUMMON_PARTNER,  	7).   % 召唤宠物
-define(CMD_T_NORMAL_ATT,  		8).   % 普通攻击
-define(CMD_T_SUMMON_MON,  	    9).   % 召唤宠物







%% 攻击结果（AR：attack result）
-define(AR_HIT, 1).  % 命中
-define(AR_DODGE, 2).  % 闪避
-define(AR_CRIT, 3).   % 暴击



%% 死亡原因
-define(DIE_REASON_NORMAL, 1).     	% 正常死亡
-define(DIE_REASON_DOT, 2).     	% 因DOT而死亡


%% 死亡状态
-define(DIE_STATUS_LIVING, 0).     % 未死亡
-define(DIE_STATUS_FALLEN, 1).     % 死亡并且进入倒地状态
-define(DIE_STATUS_GHOST, 2).      % 死亡并且进入鬼魂状态
-define(DIE_STATUS_DISAPPEAR, 3).  % 死亡并且直接消失

%% 在线对离线战斗 战斗类型码
-define(O2O_BT_TYPE_OFFLINE_ARENA, 1).  % 离线竞技场
-define(O2O_BT_TYPE_HIJACK, 2).         % 劫镖战斗


-define(ANGER_INIT,(begin {_,Init,_} = data_special_config:get('anger_resume_set') , Init end) ).                % 玩家进入战斗初始怒气值
-define(ANGER_LIM, (begin {Max,_,_} = data_special_config:get('anger_resume_set'),Max end)).                % 玩家战斗中怒气值上限





% %% 战斗对象的最大怒气值
% -define(MAX_BO_ANGER, 100).

% %% 战斗对象的最大觉醒值
% -define(MAX_BO_AROUSAL, 100).

% %% 玩家在选择技能的时间内，每xx秒自动减少N点觉醒值
% -define(AUTO_COST_AROUSAL_PER_TIMER_INTV, 20).

% %% 玩家在选择技能的时间内，每xx秒对方角色自动增长N点觉醒值
% -define(AUTO_ADD_AROUSAL_PER_TIMER_INTV, 2).



% %% QTE类型
% -define(QTE_T_PURSUE_SKILL, 1).		    % 追击技QTE
% -define(QTE_T_COOPR_SKILL, 2).			% 合体技QTE



% %% 战斗对象的行为状态
% -define(BO_BHV_NONE, 						  0).	% 空状态
% -define(BO_BHV_HANDLING_PURSUE_SKILL_QTE,  1).  	% 正在处理追击技QTE
% -define(BO_BHV_HANDLING_COOPR_SKILL_QTE,  	  2).  	% 正在处理合体技QTE
% %%-define(BO_BHV_USE_COOPR_SKILL, 		  	  3).  	% 使用合体技（暂时没用）
% -define(BO_BHV_ASSIST_TO_USE_COOPR_SKILL, 	  4).  	% 配合使用合体技
% -define(BO_BHV_SKILL_BALL_OVER, 5).   % 本回合中某一玩家的技能球处理结束


% %% 棋盘坐标
% -define(ORIGIN_X, 1).   % 棋盘原点
% -define(ORIGIN_Y, 1).
% -define(CHESSBOARD_33, {3, 3}).   % 33棋盘xy
% -define(CHESSBOARD_35, {3, 5}).   % 35棋盘xy
% -define(CHESSBOARD_53, {5, 3}).   % 53棋盘xy
% -define(CHESSBOARD_55, {5, 5}).   % 55棋盘xy

% %% gm 指令
% -define(GM_INVINCIBLE, 1).   % 无敌
% -define(GM_UNVINCIBLE, 0).   % 取消无敌
% %% 战斗技能球的颜色
% %% 0红色，1蓝色1，2蓝色2，3黄色1, 4黄色2
% -define(SKILL_BALL_C_RED, 0).
% -define(SKILL_BALL_C_BLUE1, 1).
% -define(SKILL_BALL_C_BLUE2, 2).
% -define(SKILL_BALL_C_YELLOW1, 3).
% -define(SKILL_BALL_C_YELLOW2, 4).

% %% 技能球的选择完美度
% %% 0失败，1一般，2好，3优秀
% -define(SKILL_BALL_F_BAD, 1). 
% -define(SKILL_BALL_F_GOODS, 2).
% -define(SKILL_BALL_F_COOL, 3).


% %% buff的重算类型
% -define(EFF_T_ONCE, 0).  % 不需重算，回合结束时不再进行处理(触发时处理了)
% -define(EFF_T_EVERY_EFFECTIVE_TURN, 1).   % 需要重算，回合结束时需要重新操作












%% 
-ifdef(debug_on_windows). % Windows系统下调试
    -define(OPEN_BT_LOG_FILE(BattleId), lib_bt_util:open_battle_log_file(BattleId)).
    -define(CLOSE_BT_LOG_FILE(), lib_bt_util:close_battle_log_file()).
    -define(BT_LOG(String), lib_bt_util:write_battle_log_file(String)).
-else.
    -define(OPEN_BT_LOG_FILE(BattleId), void).
    -define(CLOSE_BT_LOG_FILE(), void).
    -define(BT_LOG(String), void).
-endif.










-endif.  %% __BATTLE_H__
