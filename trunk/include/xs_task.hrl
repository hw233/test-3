%%%------------------------------------
%%% @author 严利宏 <542430172@qq.com>
%%% @copyright UCweb 2014.11.27
%%% @doc 悬赏任务头文件
%%% @end
%%%------------------------------------

-ifndef(__ISSUE_TASK_H__).
-define(__ISSUE_TASK_H__, 0). 

-define(PAGE_NUM, 5). % 悬赏任务榜单页数量

-define(XS_TASK_MATCH_PERIOD, 20). % 定时检查周期

% 悬赏管理进程状态
-record(issue_state, {
        next_id = 0
        ,last_sys_issue_time = 0    % 上次系统自动发布任务时间
        ,last_sys_receive_time = 0  % 上次系统自动接取任务时间
        ,task_list = [] % [#issue_task{}, ...]
    }).

% 悬赏任务信息
-record(issue_task, {
        id = 0              % 悬赏任务Id
        ,role_id = 0        % 发布者Id
        ,role_name = ""     % 发布者昵称（空则表示匿名）
        ,task_no = 0        % 任务编号
        ,issue_lv = 0       % 任务等级
        ,issue_num = 0      % 剩余任务数量
        ,sys_receive = []   % 被系统接取的任务信息 [{RTime, Num}, ...]
        ,role_receive = []  % 被玩家接取任务信息 [{RTime, RoleId}, ...] 数量一定为1
        ,complete_num = 0   % 完成任务数量
        ,issue_time = 0     % 任务发布时间

        % 以下是预留字段，用于应付游戏正式上线后的功能需求的拓展
        ,reserved_field1 = null
        ,reserved_field2 = null
        ,reserved_field3 = null
    }).


-endif. % __ISSUE_TASK_H__
