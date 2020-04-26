%%%------------------------------------------------
%%% File    : guild_battle.hrl
%%% Author  : 段世和
%%% Created : 2015-12-25
%%% Description: 帮战信息宏
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__guild_battle_H__).
-define(__guild_battle_H__, 0).


% 历史记录帮派排行信息报表
-record(guild_battle_guild_info,{
		rounds = 0,									% 帮战轮次
		guild_id = 0,								% 帮派id
		rank = 0,									% 排名
		guild_name = <<"无名">>,					% 帮派名称		
		join_battle_player_count = 0,				% 帮派参战人数
		battle_count = 0,							% 战斗次数
		battle_win_count = 0,						% 战斗胜利次数
		touch_throne = 0,							% 触摸王座次数
		point = 0									% 积分
	}).

% 帮战总信息报表
-record(guild_battle_history,{
		rounds = 0,
		join_battle_player_count = 0, 				% 参战人数
		join_battle_guild_count = 0, 				% 参战帮派数

		better_fighter_name = <<"战斗王">>,	
		better_fighter_player_id = 0,

		better_touch_throne_name = <<"偷鸡王">>,
		better_touch_throne_player_id = 0,

		better_trouble_name = <<"捣蛋王">>,
		better_trouble_player_id = 0,

		better_streak_name = <<"连杀王">>,
		better_streak_player_id = 0,

		better_defend_name = <<"防守王">>,
		better_defend_player_id = 0,

		better_try_name = <<"尽力王">>,
		better_try_player_id = 0,

		join_battle_max_rate = 0,
		join_battle_max_rate_guild_id = 0,
		join_battle_max_rate_guild_name = <<"参战率最高的帮派">>,

		join_battle_max_count = 0,
		join_battle_max_count_guild_id = 0,
		join_battle_max_count_guild_name = <<"参战人数最高的帮派">>,

		win_guild_name = <<"胜利帮派名字">>,
		win_guild_id = 0,
		
		take_throne_player_id = 0,
		take_throne_player_name = <<"拿取王座玩家名字">>
	}).

% 帮战个人数据信息
-record(guild_battle_player_info,{
		player_id = 0						% 玩家id
		,rounds = 0							% 轮次
		,guild_id = 0						% 效力帮派编号
		,guild_name = <<"无名">>			% 效力帮派名称

		,cur_state = 0						% 当前状态 0 闲着 1读条->2 2读条->3 3读条->take 
		,cut_step_time = 0      			% 当前读条时间

		,halt_time = 0          			% 休息时间，在休息期间无法进入战场
		,enter1_count = 0   				% 进入第1区域次数
		,enter1_time = 0        			% 进入第1区域时间
		,enter2_count = 0 					% 进入第2区域次数
		,enter2_time = 0 					% 进入第2区域时间
		,enter3_count = 0  					% 进入第3区域次数
		,enter3_time = 0 					% 进入第3区域时间

		,touch_throne = 0 					% 触摸王座次数
		,interrupt_load = 0					% 打断别人读条

		,battle_win = 0  					% 战斗胜利次数
		,battle_lose = 0   					% 战斗失败次数
		,winning_streak = 0 				% 连胜次数
		,max_winning_streak = 0             % 最大连胜次数

		% 付费相关
		,quick_enetr2_count = 0 			% 快速进入第二区域次数
		,quick_clear_halt_time_count = 0 	% 快速清除休息时间次数

		% 结算后的数据
		,point = 0
		,rank = 0						% 排名
	}).


% NPC传送点相关配置
-record(guild_battle_npc,{
		id = 0,
		use_player_id = 0,
		use_guild_id = 0,
		use_time = 0
	}).

% 系统杂项
-record(guild_battle_sys,{
		rounds = 0							% 当前轮次
		,battle_state = 0                   % 0 等待 1 进行中 2 结束
		,last_win_guild_id = 0              % 上次胜利帮派id
		,last_take_throne_player_id = 0     % 上次获得王座玩家id
		,time = 0          					% 如果帮战已经开始则是帮战持续时间 如果已经结束 则是修整时间 帮战已经持续时间 如果是等待则是等待时间
		,count = 0							% 战斗次数
	}).


% 帮派战奖励配置结构体
-record(guild_battle_reward_cfg,{
	no = 0
	,class = 0
	,reward_pool_no = 0
	,widget = 0
	}).

% -record(state, {}).

-define(GUILD_BATTLE_WAIT,  0).               				% 等待
-define(GUILD_BATTLE_OPEN,  1).               				% 进行中
-define(GUILD_BATTLE_END,  2).               				% 结束

-define(GUILD_BATTLE_IDLE,  0).               				% 休息
-define(GUILD_BATTLE_READ2,  1).               				% 读条2
-define(GUILD_BATTLE_READ3,  2).               				% 读条3
-define(GUILD_BATTLE_TAKE,  3).               				% 拿取王座

-define(GUILD_BATTLE_ROUNDS,  					guild_battle_rounds).               		% 当前轮次
-define(GUILD_BATTLE_STATE,  					guild_battle_state).                 		% 状态
-define(LAST_WIN_GUILD_ID,  					last_win_guild_id).                 		% 上次胜利帮派id
-define(LAST_TAKE_THRONE_PLAYER_ID,  			last_take_throne_player_id). 				% 上次获得王座玩家id
-define(GUILD_BATTLE_TIME,  					guild_battle_time).                 		% 如果帮战已经开始则是帮战持续时间

-define(GUILD_BATTLE_PK_COUNT,  				guild_battle_pk_count).                 	% 本次帮派战 战斗结果次数

% 定义
-define(GUILD_BATTLE_DURATION,  7200).               		% 7200秒 2小时
-define(GUILD_BATTLE_DURATION_TIPS,  6600).               		% 6600秒 1小时50分开始提示
-define(GUILD_DUEL_TIME,  		2100).                		% 决斗从什么时候开始 开始后无法从准备区域进入战场

-define(GUILD_DUEL_TIME_TIPS,  	1800).                		% 提前开始通知即将进入决斗期间
-define(GUILD_CAN_TAKE_TIME,  	900).                		% 提前开始通知即将进入决斗期间

% 帮战等待时间
-define(GUILD_WAIT_TIME,  		1800).                		% 帮战等待时间 等待期间所有人都无法进入帮战区域
% 
-define(GUILD_INTERVAL,  		1000).                		% 定时器间隔 线上改为1000毫秒

% 加快公告提示频率时间阈
-define(GUILD_MORE_POST_WAIT_TIME, 1200).

% 帮战开始 星期N
-define(GUILD_BATTLE_BEGIN_WEEK1, 6).
-define(GUILD_BATTLE_BEGIN_WEEK2, 3).

%-
-define(GUILD_BATTLE_BEGIN_HOUR, 20).
-define(GUILD_BATTLE_BEGIN_MIN, 0).

-define(GUILD_BALT_TIME, 90).

% 7天- 2小时 - 30分钟
% -define(GUILD_BATTLE_HALT_TIME, 595800).             		% 帮战后修整时间 在此期间只有 当前胜利的帮派可以进入到帮战场景中 帮战场景中会有一些玩法

-define(GUILD_ENTER2_LOAD_TIME,  10).                		% 进入第二区域读条时间
-define(GUILD_ENTER3_LOAD_TIME,  30).                		% 进入第三区域读条时间
-define(GUILD_TAKE_THRONE_TIME,  260).                		% 拿取王座时间

-define(GUILD_ENTER1_CONFIG,{3511,47,36}).
-define(GUILD_ENTER2_CONFIG,{3512,45,33}).
-define(GUILD_ENTER3_CONFIG,{3513,18,16}).

% ETS
-define(ETS_GUILD_BATTLE_INFO, ets_guild_battle_info).				% 玩家信息
-define(ETS_GUILD_BATTLE_GUILD_INFO, ets_guild_battle_guild_info).	% 帮派信息
-define(ETS_GUILD_BATTLE_HISTORY, ets_guild_battle_history).		% 帮派战历史

-define(ETS_GUILD_BATTLE_NPC, ets_guild_battle_npc).		% 帮战NPC
-define(ETS_GUILD_BATTLE_SYS, ets_guild_battle_sys).		% 帮战系统信息
% 队伍需要数量
-define(GUILD_TEAM_PLAYER_COUNT, 1). 

%% 帮战提示相关判断宏
-define(GUILD_SHUTDOWN,3).

-define(GUILD_FIRST_BLOOD,1).
-define(GUILD_KILLING_SPREE,3).
-define(GUILD_RAMPAGE,5).
-define(GUILD_UNSTOPPABLE,8).
-define(GUILD_DOMINATING,12).
-define(GUILD_GOD_LIKE,18).
-define(GUILD_LEGENDARY,25).

% 全部战场次数提示
-define(GUILD_ALL_BATTLE_COUNT_TIPS1,1).
-define(GUILD_ALL_BATTLE_COUNT_TIPS10,10).
-define(GUILD_ALL_BATTLE_COUNT_TIPS50,50).
-define(GUILD_ALL_BATTLE_COUNT_TIPS100,100).
-define(GUILD_ALL_BATTLE_COUNT_TIPS200,200).
-define(GUILD_ALL_BATTLE_COUNT_TIPS500,500).
-define(GUILD_ALL_BATTLE_COUNT_TIPS1000,1000).
-define(GUILD_ALL_BATTLE_COUNT_TIPS2000,2000).
-define(GUILD_ALL_BATTLE_COUNT_TIPS5000,5000).

% 最少要在场地30秒才有奖励
-define(GUILD_BATTLE_REWARD_NEED_TIME1,30).
% 参与奖励
-define(GUILD_BATTLE_REWARD_ID1,21000).

% 在场地时间超过1200秒的奖励
-define(GUILD_BATTLE_REWARD_NEED_TIME2,1200).
% 战场中超过一定时间的
-define(GUILD_BATTLE_REWARD_ID2,21001).

% 在场地时间超过1800秒的奖励
-define(GUILD_BATTLE_REWARD_NEED_TIME3,1800).
% 战场中超过一定时间的
-define(GUILD_BATTLE_REWARD_ID3,21002).

% 帮战获得胜利的帮派所有成员奖励 帮主奖励
-define(GUILD_BATTLE_REWARD_ID_MEM,21003).
-define(GUILD_BATTLE_REWARD_ID_KING,21004).

% 称号编号
-define(GUILD_BATTLE_TITLE_TAKE,60007).
-define(GUILD_BATTLE_TITLE_MEM,60005).
-define(GUILD_BATTLE_TITLE_KING,60006).

%% 奖励贡献度
-define(GUILD_BATTLE_KING_CHIEF_CONTRI,20000).
-define(GUILD_BATTLE_KING_MEN_CONTRI,2000).
-define(GUILD_BATTLE_CHIEF_CONTRI,3000).
-define(GUILD_BATTLE_MEN_CONTRI,500).


% 排行榜数据条数
-define(GUILD_BATTLE_GUILD_RANK_COUNT,20).
-define(GUILD_BATTLE_PLAYER_RANK_COUNT,50).

% 帮战等级限制
-define(ENTER_GUILD_LV,30).
-endif.  %% __guild_battle_H__