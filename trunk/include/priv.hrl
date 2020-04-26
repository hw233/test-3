%%%------------------------------------------------
%%% File    : priv.hrl
%%% Author  : huangjf
%%% Created : 2014.9.15
%%% Description: 玩家的权限等级
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__PRIV__).
-define(__PRIV__, 0).




%% 规定：数值越大，权限越高
-define(PRIV_NOR_PLAYER, 0).        % 普通玩家
-define(PRIV_INSTRUCTOR, 1).        % 指导员
-define(PRIV_GM, 2).                % GM



















-endif.  %% __PRIV__
