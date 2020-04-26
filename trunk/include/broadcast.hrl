%%%------------------------------------------------
%%% File    : broadcast.hrl
%%% Author  : zhangwq
%%% Created : 2014.2.25
%%% Description: 公告系统的相关宏定义
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__BROADCAST_H__).
-define(__BROADCAST_H__, 0).

-record(broadcast, {
        id = 0,     
        type = 0,            %% 公告类型 1.后台运营走马灯 2.系统走马灯 3.聊天框信息 4.私聊信息
        priority = 0,        %% 优先级 (1：立即,2：高,3：低)
        content = <<>>,      %% 公告内容
        interval = 0,        %% 间隔(sec) 为0 表示只发一次的
        start_time = 0,      %% 当type=1开始时间，当type=3时，表示每天从0点开始经过StartTime秒后开始显示
        end_time = 0,        %% 当type=1过期时间，当type=3时，表示每天从0点开始经过EndTime-StartTime秒后结束显示
        op_type = 0          %% 操作类型(1->insert,2->update, 3->delete)
    }).%% 


-record(sys_broadcast, {
        no = 0,
        target = 0,
        type = 0,
        priority = 0
    }).


-define(BROADCAST_PROCESS, broadcast_process).

%%定时清除内存中过期的公告 单位：毫秒）, 目前为2分钟
-define(CLEAR_OUTDATED_BROADCAST_INTV, (2*60*1000)).


-endif.  %% __BROADCAST_H__