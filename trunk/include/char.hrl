%%%------------------------------------------------------------------------------
%%% File    : char.hrl
%%% Author  : huangjf
%%% Created : 2014.3.7
%%% Description: 广义上的角色（character，包括玩家，NPC, 宠物，怪物）的相关宏定义
%%%------------------------------------------------------------------------------


%% 避免头文件多重包含
-ifndef(__CHAR_H__).
-define(__CHAR_H__, 0).





%% 对象的行为状态(bhv: behaviour)
-define(BHV_IDLE, 0). 		         % 空闲状态
-define(BHV_BUSY_WITH_SOMETHING, 1). % 正在忙着做某事（比如：采集，修炼）
-define(BHV_BATTLING, 2). 		     % 战斗状态
-define(BHV_DEAD, 3). 		         % 死亡状态
-define(BHV_TRACING_ENEMY, 4). 	     % 正在追踪敌人
-define(BHV_ENTERING_GAME, 5).       % 正在进入游戏中（处于登录保护阶段）
-define(BHV_OFFLINE_GUAJI, 6).       % 正在离线挂机中
-define(BHV_ARENA_1V1_WAITING, 7).   % 正在竞技场等待
-define(BHV_ARENA_1V1_READY, 8).     % 比武大会上已经匹配准备状态
-define(BHV_ARENA_3V3_WAITING, 9).   % 3v3比武大会等待
-define(BHV_ARENA_3V3_READY, 10).    % 3V3比武大会已经匹配准备状态

-define(BHV_DOING_SINGLE_TARGET_PHY_ATT, 20). 	    % (战斗对象)执行单体物理攻击
-define(BHV_DOING_MULTI_TARGET_PHY_ATT, 21). 	    % (战斗对象)执行多目标物理攻击
-define(BHV_WAITING_PLAYER_TO_JOIN_CRUISE, 22).		% （巡游活动npc）正在等待玩家报名参与活动
-define(BHV_WAITING_TO_START_CRUISE, 23).			% （玩家）正在等待开始巡游
-define(BHV_CRUISING, 24).							% （巡游活动npc或玩家）正在巡游
-define(BHV_COUPLE_HIDE, 25).                       % （巡游活动npc或玩家）正在花车巡游(隐藏)
-define(BHV_COUPLE_CRUISING, 26).                   % （巡游活动npc或玩家）正在花车巡游（跟随）

% 废弃！
% -define(BHV_RECONNECT_ENTERING_GAME, 10). 	    % 重连进入游戏中
% -define(BHV_FINAL_LOGOUTING, 11). 	    % 最终退出游戏中
















-endif.  %% __CHAR_H__
