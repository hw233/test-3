%%%------------------------------------------------
%%% File    : framework.hrl
%%% Author  : huangjf 
%%% Created : 2014.1.7
%%% Description: 服务器框架
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__FRAMEWORK_H__).
-define(__FRAMEWORK_H__, 0).



-define(TOP_SUP, sm_sup).  % 系统的顶层监控进程


-define(APP_GATEWAY, gateway).  % gateway application
-define(APP_SERVER, server).    % server application



%% 注：方便起见，两个节点所在主机的ip相同（即位于同一台主机）
-define(IP_OF_GATEWAY_NODE, "127.0.0.1").   % gateway节点所在主机的ip
-define(IP_OF_SERVER_NODE, "127.0.0.1").    % server节点所在主机的ip


%% 注：目前实际上并没有做游戏server的分线，代码里仍保留是为了适配旧框架
-define(LINE_ID_OF_GATEWAY_NODE, 0).        % gateway节点的线路id
-define(LINE_ID_OF_SERVER_NODE, 1).         % server节点的线路id

























-endif.  %% __FRAMEWORK_H__
