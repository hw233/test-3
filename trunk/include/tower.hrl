-ifndef(TOWER_HRL).
-define(TOWER_HRL, tower_hrl).

-include("sys_code.hrl").

-define(DEF_FLOOR, 0).      %% 默认层数

-define(SPAN_FLOOR_COEF, 5).        %% 跳层系数

-define(TOWER_OPEN_LV, ply_sys_open:get_sys_open_lv(?SYS_TOWER)). %% 爬塔开放等级
    
-define(MAX_TOWER_TIMES, 0).         %% 最大清进度次数

-define(MAX_CHAL_TIMES, 65535).         %% 最大挑战次数
-define(VIP_EXTRA_CHAL_TIMES, 65535).     %% 土豪额外最大挑战次数    
-define(MAX_BUY_TIMES, 65535).          %% 最大购买次数
-define(VIP_EXTRA_BUY_TIMES, 65535).      %% 土豪额外最大购买次数

-define(BUY_TIMES_MONEY, 100).      %% 购买挑战次数钱币

-define(ETS_TOWER, ets_tower).

-define(ETS_HARD_TOWER, ets_hardtower).
-define(HARD_TOWER_MAX_CHAL_TIMES, 2). %%噩梦爬塔最大挑战次数为2次
-define(HARD_TOWER_MAX_BUY_TIMES, 0).  %%噩梦爬塔最大购买次数
-define(HARD_SPAN_FLOOR_COEF, 10). %%噩梦爬塔跳层系数


%%[{tower,1000100000000283,0,0,0,0,737792,0,5}] {tower,1000100000000289,0,0,0,0,737793,0,37}]
-record(tower, {
    id = 0                  % roleID
    ,floor = 0              % 当前层数
    ,chal_boss_times = 0    % 挑战当层BOSS次数
    ,buy_times = 0          % 购买次数
    ,schedule_times = 0     % 进度次数
    ,refresh_stamp = 0      % 刷新时间
    ,span_exp_floor = 0     % 领取跨级经验所在层数
    ,best_floor = 0         % 历史最佳进度层数
  ,have_jump = 0             % 是否已跳层 1是
    }). 

-record(hardtower, {
    id = 0                  % roleID
    ,tower_no = 0           % 当前副本的编号[100002, 100003, 100004]
    ,floor = 0              % 当前层数
    ,chal_boss_times = 0    % 挑战当层BOSS次数
    ,buy_times = 0          % 购买次数
    ,schedule_times = 0     % 进度次数
    ,refresh_stamp = 0      % 刷新时间
    ,span_exp_floor = 0     % 领取跨级经验所在层数
    ,best_floor = 0         % 历史最佳进度层数
    }).

-record(tower_config, {
    floor = 0           % 层数
    ,lv = 0             % 等级限制
    ,reward_id = 0      % 奖励ID
    ,battle_power = 0   % 推荐战斗力
    }).

-endif.