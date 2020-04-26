%%%------------------------------------------------
%%% File    : player_ext.hrl
%%% Author  : 段世和
%%% Created : 2015-10-24
%%% Description: 玩家拓展信息表
%%%------------------------------------------------


%% 避免头文件多重包含
-ifndef(__SLOTMACHINE_H__).
-define(__SLOTMACHINE_H__, 0).

% 老虎机配置结构体--------------------------------------------------
-record(slotmachine_config,{
		no = 0,
		class = 0,
		odds = 0,
		widget = 0,
		type = 0,
		name = <<"名字">>
	}).


% 老虎机玩家信息结构体--------------------------------------------------
-record(slotmachine_player,{
		rounds = 0,
		player_id = 0,
		change = 0,
		value = 0,
		infos = []
	}).

% 老虎机玩家信息结构体--------------------------------------------------
-record(slotmachine_player_info,{
		class = 0,
		count = 0
	}).

% 老虎机玩家信息结构体--------------------------------------------------
-record(slotmachine_history,{
		rounds = 0,
		no = 0,
		change = 0
	}).



% 老虎机信息--------------------------------------------------
-record(slotmachine_info,{
		rounds = 0,			% 当前轮次
		lefttime = 0		% 剩余开奖时间
	}).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%废弃？
-record(slotmachine_players,{
		player_id = 0,			% 当前轮次
		count = 0				% 剩余开奖时间
	}).



-record(state, {}).

-define(SLOTMACHINE_ROUNDS,  slotmachine_rounds).               		% 轮次
-define(SLOTMACHINE_LEFT_TIME,  slotmachine_left_time).                 % 剩余时间

-define(SLOTMACHINE_INTERVAL, 600).                                   % 剩余时间
-define(SLOTMACHINE_TIMER,  1000).                                    % 剩余时间 正式改成60000 也就是1分钟

-define(SLOTMACHINE_NEED_PLAYER_COUNT,  0).                          % 多少人在线才会开老虎机

-define(SLOTMACHINE_DICE_CLASS,10).										% 骰子类型

%% 打开老虎机的玩家
-define(ETS_SLOTMACHINE_PLAYERS, ets_slotmachine_players).
-define(ETS_SLOTMACHINE_INFO, ets_slotmachine_info).
-define(ETS_SLOTMACHINE_HISTORY, ets_slotmachine_history).


-endif.  %% __SLOTMACHINE_H__