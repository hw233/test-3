-ifndef(TOWER_GHOST_HRL).
-define(TOWER_GHOST_HRL, tower_ghost_hrl).


-define(TABLE_TOWER_GHOST,		tower_ghost).

-define(ETS_TOWER_GHOST,		ets_tower_ghost).

%% 伏魔数据记录定义
-record(tower_ghost, {
					  player_id = 0,			% 玩家id
					  floor = 0,				% 已通关的最大层数
					  times = 0,				% 可用次数
					  last_time_restore = 0		% 上次回复次数时间戳
					 }).


-endif.