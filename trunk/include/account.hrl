%%%------------------------------------------------
%%% File    : account.hrl
%%% Author  : huangjf 
%%% Created : 2013.5.30
%%% Description: 玩家账户相关的宏
%%%------------------------------------------------


%% 避免头文件多重包含
-ifndef(__ACCOUNT_H__).
-define(__ACCOUNT_H__, 0).





%% 每个账户下最多能创建多少个角色？
-define(MAX_ROLES_PER_ACCOUNT, 1).


%% 角色名的最小长度（1汉字=1单位长度，1数字或字母=1单位长度）
-define(MIN_ROLE_NAME_LEN, 2).


%% 角色名的最大长度
-define(MAX_ROLE_NAME_LEN, 6).


%% 允许删除角色的最大次数
-define(MAX_DISCARD_ROLE_TIMES, 3).

%% 删除角色的次数记录
-record(discard_role_times, {
		accname = "",
		times = 0
	}).
















-endif.  %% __ACCOUNT_H__
