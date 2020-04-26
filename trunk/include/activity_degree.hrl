-ifndef(ACTIVITY_DEGREE_HRL).
-define(ACTIVITY_DEGREE_HRL, activity_degree_hrl).


-record(activity_degree, {
    % id = 0          % role id
    % point = 0      % 活跃点数
    daystamp = 0  % 日期戳
    ,reward_list = []    % 领奖记录
    }).


-define(AP_SYS_NAME(Sys), {activity_degree, sys_name, Sys}).

-define(AP_ACTIVITY_DEGREE, ap_activity_degree).

-define(AP_HAD_GET_REWARD, 1).  % 已领奖
-define(AP_NO_GET_REWARD, 0).  % 未领奖

-define(ACTIVITY_TIMING_INTEVAL, 1000).     % 活动定时器时间间隔

-define(LOG_ONLINE_NUM_INTEVAL, 300000).    % 在线人数定时器间隔

-define(ACTIVITY_OPEN(Activity), {activity, Activity}).

-define(PUBLIC_ACITICTY_ALIVE(Activity), {activity, alive, Activity}).  % 公共系统实际存活

-endif.