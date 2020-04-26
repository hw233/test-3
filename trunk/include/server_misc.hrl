%%%------------------------------------------------
%%% File    : server_misc.hrl
%%% Author  : huangjf 
%%% Created : 2013.6.11
%%% Description: 服务器的一些杂项信息
%%%------------------------------------------------






%% 避免头文件多重包含
-ifndef(__SERVER_MISC_H__).
-define(__SERVER_MISC_H__, 0).





%% SM：表示server misc
-define(SM_OPEN_STATE,  server_misc_open_state).               		% 服务器的开启状态（1表示开启中，0表示未开启）
-define(SM_CLOCK_TICK_COUNT,  server_misc_clock_tick_count).   		% 服务器时钟---- 当前的滴答计数
-define(SM_CLOCK_UNIXTIME,  server_misc_clock_unixtime).       		% 服务器时钟---- 当前的unix时间戳
-define(SM_RESERVE_CDK_8_COUNT, server_misc_reserve_cdk_8_count).  	% 已生成的8位保留cdk的数量



-define(SERVER_CLOCK_TICK_INTV, 2000).   % 服务器时钟：每XX毫秒滴答一次（目前是2000毫秒）









-endif.  %% __SERVER_MISC_H__
