%%%------------------------------------------------
%%% File    : task.hrl
%%% Author  : huangjf, ...
%%% Created : 2013.6.28
%%% Description: 任务系统相关的宏
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__TASK_H__).
-define(__TASK_H__, 0).




% %% 任务类型
% -define(TASK_T_MAIN,     1).		 % 主线任务
% -define(TASK_T_BRANCH,   2).	     % 支线任务
% -define(TASK_T_DAILY,    3).		 % 日常任务
% -define(TASK_T_FACTION,  4).		 % 师门任务
% -define(TASK_T_GUILD,    5).	  	 % 帮派任务
% 其他。。。







%% 旧宏，废弃！！
% %% 任务宏
% -define(TASK_WRITE_BACK,   600000).   %任务系统刷新时间
% -define(PLOT_TASK,   1016).   %剧情任务编号
% -define(CHALG_TASKA,   3001).   %触发挑战任务A
% -define(CHALG_TASKB,   3002).   %触发挑战任务B
% -define(CHALG_TASKC,   3003).   %触发挑战任务B
% -define(BAR_TASK_FRESH_CD,   (20*60)).   %酒馆任务刷新CD
% -define(BAR_FREE_TIME,   3).   %酒馆任务刷新免费次数
% -define(BAR_CD_COST,   1).   %酒馆任务每分钟消耗元宝数额

% -define(MAIN_TASK, 0).		 %主线任务类型
% -define(BRANCH_TASK, 1).	 %支线任务类型
% -define(DAILY_TASK, 2).		 %日常任务类型
% -define(GUILD_TASK, 4).	  	 %帮派任务类型
% -define(CHALG_TASK_TYPEA, 5).	%挑战接取任务类型
% -define(CHALG_TASK_TYPEB, 6).	%挑战任务类型
% -define(BAR_TASK_TYPEA,   7).   %酒馆任务类型1 对应五种不同的颜色
% -define(BAR_TASK_TYPEB,   8).   %酒馆任务类型2
% -define(BAR_TASK_TYPEC,   9).   %酒馆任务类型3
% -define(BAR_TASK_TYPED,   10).   %酒馆任务类型4
% -define(BAR_TASK_TYPEE,   11).   %酒馆任务类型5
% -define(TREASURE_TASK_TYPE, 12). %藏宝任务
% -define(MERC_TASK_TYPE,   13).   %佣兵任务类型
% -define(COL_GOLD_TASK_TYPE,   14).   %采金任务类型
% -define(PROTECT_TASK,   15).   %护送任务类型
% -define(AUTO_DAILY_TASK, 16).   % 自动接取日常任务类型
% %% 开启时间
% -define(CHALG_TASK_START,    30).          %% 日常任务开启时间


-define(TASK_ITEM_TRIGGER, 100).

-define(TASK_MAIN_TYPE, 0).         %% 主线任务类型
-define(TASK_BRANCH_TYPE, 1).       %% 支线任务
-define(TASK_ACTIVITY_TYPE, 2).     %% 活动任务
-define(TASK_GUILD_TYPE, 3).        %% 帮派任务
-define(TASK_FACTION_TYPE, 4).      %% 师门任务
-define(TASK_DUNGEON_TYPE, 5).      %% 副本任务
-define(TASK_GOSHT_TYPE, 6).        %% 抓鬼任务
-define(TASK_TREASURE_TYPE, 7).        %% 宝图任务
-define(TASK_ONHOOK_TYPE, 8).       %% 挂机任务
-define(TASK_PEACH_TYPE, 9).        %% 桃园任务
-define(TASK_WORLD_TYPE, 10).       %% 世界等级任务
-define(TASK_RECHARGE_TYPE, 11).    %% 充值任务
-define(TASK_FESTIVAL_ACITVITY_TYPE, 12).    %% 节日活动任务
-define(TASK_FESTIVAL_ACITVITY_RING_TYPE, 13).      %% 节日活动任务
-define(TASK_XS_TASK_TYPE, 14).                     %% 悬赏任务
-define(TASK_FACTION_FIGHT_TYPE, 15).      %% 师门挑战任务
-define(TASK_GOSHT_KING_TYPE, 16).      %% 抓鬼挑战任务
-define(TASK_SANJIE_TYPE, 17).          %% 三界任务

-define(UNREPEAT_TASK_TYPE, unrepeate_task_type).
-define(UNREPEAT_TASK_TYPES, [?TASK_MAIN_TYPE]).     
-define(REPEAT_TASK_TYPE, repeate_task_type).
-define(REPEAT_TASK_TYPES, [?TASK_ACTIVITY_TYPE, ?TASK_ONHOOK_TYPE, ?TASK_BRANCH_TYPE, ?TASK_FESTIVAL_ACITVITY_TYPE]).
-define(RING_TASK_TYPE, ring_task_type).
-define(RING_TASK_TYPES, [?TASK_SANJIE_TYPE, ?TASK_GUILD_TYPE, ?TASK_FACTION_TYPE,?TASK_GOSHT_KING_TYPE, ?TASK_GOSHT_TYPE, ?TASK_FESTIVAL_ACITVITY_RING_TYPE, ?TASK_TREASURE_TYPE, ?TASK_FACTION_FIGHT_TYPE]).
-define(DUNGEON_TASK_TYPE, dungeon_task_type).
-define(DUNGEON_TASK_TYPES, [?TASK_DUNGEON_TYPE]).

-define(DEF_CLASSIFY, 0).           %% 默认任务分类


-define(TASK_SEED, {task, seed}).
-define(TASK_RING(TaskId), {task, ring, TaskId}).
-define(TASK_RING_LIST, {task, ring_list}).

-define(TASK_RING_ACCEPTED(TaskId), {task, ring, accepted, TaskId}).

-define(UPDATE_CHECK_ACTION, [buy, drop_kill, drop_kill_dark, collect, catch_pet, had_guild, be_hired, hire,reach_achievement]).

-define(TASK_SPECIFIC_ACTION, [had_guild, be_hired, hire,reach_achievement]).

-define(TASK_TIMING_REF, {task, timing_ref}).

-define(TASK_TIMES, 10).

-define(TASK_REWARD, task_reward).

% -record(ring_task, {
%     id = 0,
%     ring_step = 1,
%     ring_num = 1,
%     timestamp = 0
%     })

-record(task, {
        id = 0,
        type = 0,
        team = 0,
        auto_accept = 0,
        dun_no = no,
        sys_no = 0,
        lv = 0,
        lv_limit = 0,
        prev_id = 0,
        repeat = 0,
        exp = 0,
        week_task = 0,
        day_task = 0,
        max_reward_round = 0,
        race = 0,
        career = 0,
        lv_down = 0,
        ring = 0,
        ring_head = 0,
        prest = 0,   
        time_limit = 0,
        tigger_item = [], 
        start_item = [],  
        start_ub_cost = 0,   
        start_cost = 0,  
        start_recycle = [],
        start_npc = 0,
        accepted_submit = [],

        start_event = [],
        finish_event = [],
        mon_type = 0,
        end_event = [],   
        end_npc = 0, 
        end_item = [],    
        end_cost = 0,    
        next = 0,    
        content = [], 
        reward = [],
        year = [],    
        month = [],     
        week = [],     
        day = [],  
        hour = [],     
        server_start = []

    }).

%% 角色任务记录
-record(role_task, {
    id = 0,         % task_id
    state = 0,              % 任务状态标记 
    accept_time = 0,        % 接受任务时间戳
    timing = 0,     % 触发任务计时时间戳
    monNo = {0, 0},
    mark = []       % [[state, event | _],...]
    }).


-record(task_ring, {
    masterId = 0,       % 首任务，系列任务的标志
    ring = 0,           % 内环环数
    seed = 0,           % 随机种子，表示系列任务中第几个
    times = 0,          % 外环环数(轮数)
    date = 0            % 日期
    }).

-record(completed_unrepeat, {
    id = 0,
    task_type = 0,
    date = 0
    }).

-record(task_ernie, {
    no,
    prob,
    reward
}).

-endif.  %% __TASK_H__
