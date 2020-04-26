%%%------------------------------------------------
%%% File    : activity_degree_sys_2.hrl
%%% Author  : zhangwq
%%% Created : 2015.1.16
%%% Description: 区别与游戏内固定的活动（运营活动）
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__ACTIVITY_DEGREE_SYS_2_H__).
-define(__ACTIVITY_DEGREE_SYS_2_H__, 0).


%% !!!!!!为避免和activity_degree_sys.hrl中的活动代号冲突，故这里的编号都是运营活动编号+1000

-define(AD_FIREWORKS, 1020).    %% 放礼花

-define(AD_BRESS, 1022). %% 节日祝福

-define(AD_BAINIAN, 1023). %% 拜年

-endif.  %% __ACTIVITY_DEGREE_SYS_2_H__
