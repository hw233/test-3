%%%------------------------------------------------
%%% File    : sys_open.hrl
%%% Author  : huangjf 
%%% Created : 2014.4.17
%%% Description: 玩家的系统开放
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__SYS_OPEN_H__).
-define(__SYS_OPEN_H__, 0).





-record(sys_open_cfg, {
        sys_code = 0,
        lv_need = 0,
        par_lv_need = 0,
        task_need = null,
        sys_open_reward = null             % 功能开发获得奖励
        }).







-endif.  %% __SYS_OPEN_H__
