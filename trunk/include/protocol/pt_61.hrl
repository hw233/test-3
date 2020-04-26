-ifndef(__PT_61_H__).
-define(__PT_61_H__, 0).


%% 登录排队系统的相关协议：


% -define(PT_ACC_QUEUE_START_WAIT,  61009). %开始排队
% s >> c
% Index int16

% -define(PT_ACC_QUEUE_QUERY_INDEX, 61010). %查询索引（排位）
% c >> s 
% s >> c
% Index int16

% -define(PT_ACC_QUEUE_SERVER_FULL, 61011). %服务器已满
% s >> c



-define(PT_MONITOR_COME,          61000). %监视器到达
-define(PT_MONITOR_PROCESS_COUNT, 61001). %查看进程数
-define(PT_MONITOR_PROCESSES,     61002). %查看进程列表
-define(PT_MONITOR_PROCESS_INFO,  61003). %查看进程信息
-define(PT_MONITOR_MEMORY,        61004). %查看内存情况
-define(PT_MONITOR_MANUAL_GC,     61005). %手动GC
-define(PT_MONITOR_TRACE,         61006). %监视器输出
-define(PT_MONITOR_PROF_SAMPLE,   61007). %profile采样
-define(PT_MONITOR_ETOP_SAMPLE,   61008). %etop采样 
-define(PT_ACC_QUEUE_START_WAIT,  61009). %开始等待
-define(PT_ACC_QUEUE_QUERY_INDEX, 61010). %查询索引
-define(PT_ACC_QUEUE_SERVER_FULL, 61011). %服务器已满
-define(PT_ACC_QUEUE_SET_MAX_POL, 61012). %设置最大在线
-define(PT_ACC_QUEUE_GET_OL_INFO, 61013). %获取在线信息


%% 跨服协议
-define(PT_CROSS_CONNECT_NETWORK, 61100). %初始化跨服网络连接 
%   array(
%       server_id       u32         服务器ID
%		auth			string		scurity_str
%   )


-endif.