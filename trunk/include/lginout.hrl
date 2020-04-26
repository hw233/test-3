%%%------------------------------------------------
%%% File    : lginout.hrl
%%% Author  : huangjf 
%%% Created : 2014.3.17
%%% Description: 上线、下线处理的相关宏
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__LGINOUT_H__).
-define(__LGINOUT_H__, 0).







%% 开启专处理玩家下线的server的数量
-define(MAX_LOGOUT_SERVER_COUNT, 24).







-define(MAX_HANDLE_LOGOUT_TIME, 30).
-define(MAX_HANDLE_GAME_LOGIC_RECONN_TIMEOUT_TIME, 18).



















-endif.  %% __LGINOUT_H__
