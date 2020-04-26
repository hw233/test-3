%%%------------------------------------------------
%%% File    : job_schedule.hrl
%%% Author  : huangjf
%%% Created : 2013.6.20
%%% Description: 作业计划相关的宏（相关主模块：mod_job_schedule）
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__JOB_SCHEDULE_H__).
-define(__JOB_SCHEDULE_H__, 0).




%% jset: job schedule event type（作业计划的事件类型）
%% 玩家自己相关的作业计划事件类型
-define(JSET_RECONNECT_TIMEOUT, 1).          	% 角色重连超时
-define(JSET_CANCEL_BUFF, 2).          			% 取消buff
-define(JSET_GOODS_EXPIRE, 3).					% 时效物品过期
-define(JSET_GAME_LOGIC_RECONN_TIMEOUT, 4).		% 游戏逻辑（如：队伍，副本等）重连超时
-define(JSET_BUY_BACK_GOODS_EXPIRE, 5).			% 回购物品过期，不许回购
-define(JSET_CLEAR_HIRE_DATA, 6).				% 清空天将系统数据
-define(JSET_UPDATE_PAR_MOOD, 7).				% 更新玩家所有宠物心情



%% 系统相关的作业计划事件类型
-define(JSET_AUDIT_GUILD_STATE, 100).			 % 审计帮派状态
-define(JSET_CLEANUP_RESIDUAL_PLAYER_PROC, 101). % 清理残余的玩家进程
-define(JSET_ADD_GUILD_BUFF, 102).			     % 给帮派成员添加帮派buff
-define(JSET_CUR_WAITING_NPC_START_CRUISE, 103). % 巡游活动npc开始巡游
-define(JSET_SPAWN_NEXT_CRUISE_NPC, 104).		 % 刷出下一个巡游活动npc
-define(JSET_GIVE_TVE_RANK_REWARD, 105).		 % 发放tve兵临城下奖励
-define(JSET_GIVE_ARENA_1V1_TITLE, 106).		 % 发放比武大会称号给玩家
-define(JSET_GIVE_ARENA_3V3_TITLE, 107).		 % 发放比武大会3V3称号给玩家









%%% -define(JSET_OPEN_ACTIVITY, xxx).          		% 开启活动
%%% -define(JSET_CLOSE_ACTIVITY, xxx).          	% 关闭活动













-record(js_extra, {
			player_pid = null, % 涉及的玩家进程
			buff_no = 0,       % buff编号
			activity_no = 0,   % 活动编号
			goods_id = 0,      % 物品id
            partner_id = 0     % 宠物id
	}).



-record(job_sche, {
			event_type = 0,          % 事件类型
			trigger_time = 0,        % 触发时间（unix时间戳）
			player_id = 0,           % 涉及的玩家id（如果没有，则固定为0）
			extra = #js_extra{},     % 额外信息
			callback_func = null,    % 回调函数
			callback_para = null     % 回调函数的参数
	}).






















-endif.  %% __JOB_SCHEDULE_H__
