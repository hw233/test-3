%%%------------------------------------------------
%%% File    : sys_code_2.hrl
%%% Author  : huangjf
%%% Created : 2014.6.23
%%% Description: 程序另行自定义的系统代号（和策划无关）
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__SYS_CODE_2_H__).
-define(__SYS_CODE_2_H__, 0).







%% !!!!!!为避免和sys_code.hrl中的系统代号冲突，故从一个较大的数值1000开始!!!!!!
-define(SYS_DAILY_RESET_TIME, 1000).  % 系统日重置
-define(SYS_WEEKLY_RESET_TIME, 1001).  % 系统周重置


-define(SYS_DUNGEON, 1002).
-define(SYS_REWARD_POOL, 1003). % 奖励池
-define(SYS_MARRY, 1004).       % 结婚
-define(SYS_HORSE_RACE, 1005).  % 跑马场
-define(SYS_BUSINESS, 1006). % 商会系统
-define(SYS_SLOTMACHINE, 1007). % 老虎机
-define(SYS_GUILD_BATTLE, 1008). % 帮战

% -define(SYS_SWORN, 1009).       % 结拜




-endif.  %% __SYS_CODE_2_H__
