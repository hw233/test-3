%%%------------------------------------------------
%%% File    : transport.hrl
%%% Author  : lds 
%%% Created : 
%%% Description: 活动相关
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__TRANSPORT_H__).
-define(__TRANSPORT_H__, 0).
-include("sys_code.hrl").

% 镖车对象
-record(truck, {
    role_id = 0                 % 所属人物ID
    ,role_lv = 0                % 人物等级
    ,truck_lv = 0               % 镖车等级
    ,is_employ = 0              % 是否被雇佣
    ,be_hijacked_times = 0      % 被劫持次数
    ,start_timestamp = 0        % 开始运镖时间戳
    ,cur_stage = 0              % 当前阶段 (0 - 3)
    ,cur_stage_timestamp = 0    % 当前阶段开始时的时间戳
    ,cur_event = []             % 当前发生的事件集合
    }).

-record(role_transport, {
    role_id = 0
    ,truck_lv = 0           % 镖车等级
    ,transport_times = 0    % 运输次数
    ,hijack_times = 0       % 劫车次数
    ,refresh_times = 0      % 刷新次数
    ,days_count = 0         % 日数
    ,news = []              % 新闻
    ,attentives = ordsets:new()    % 关注列表 (玩家ID)
    ,free_times = 0         % 使用的免费次数
    % ,state = 0              % 运镖状态(0:空闲 1:运镖中)
    }).

-record(transport_data, {
    truck_lv = 0
    ,ts_time = 0
    ,ts_money_type = 0
    ,ts_money_num = 0
    ,reward_money_type = 0
    ,reward_money_num = 0
    ,deduct_coef = 0
    ,evolve_money_type = 0
    ,evolve_money_num  = 0
    ,evolve_rate_money = 0
    ,evolve_rate_goods = 0
    ,event_rate = 0
    ,direct_evolve_money_type = 0
    ,direct_evolve_money_num = 0
    ,refresh_money_type = 1
    ,refresh_money_num = 1
    }).

-record(transport_news, {
    no = 0
    ,performer = 0
    ,performer_name = <<>>
    ,timestamp = 0
    }).

-define(TS_TRUCK_SYSCODE, ?SYS_TRANSPORT).           % 运镖系统代号

-define(TS_TRUCK_LIMIT_NUM, 10).        % 镖车限制数量
-define(TS_TRUCK_THRES, 5).             % 补充镖车数量阈值
-define(TS_TRUCK_LIMIT_LV, 3).          % 镖车等级上限

-define(TS_TRUCK_MAX_STAGE, 3).       % 运镖最大阶段

% -define(TS_EVOLVE_MONEY_TYPE, ?MNY_T_BIND_GAMEMONEY).   % 进阶镖车钱类型
% -define(TS_EVOLVE_MONEY, 999).          % 进阶镖车钱数
-define(TS_EVOLVE_GOODS, 60172).         % 进阶物品编号

-define(TS_MAX_HIJACK_TIMES, 6).        % 最大抢劫次数
-define(TS_MAX_BE_HIJACKED_TIMES, 3).   % 最大被抢次数

-define(TS_MAX_TRANSPORT_TIMES, 2).     % 最大运镖次数

-define(TS_CHECK_TRUCK_INTEVAL, 5000).      % 镖车检查时间间隔

-define(TS_TRUCK_ID_SET_KEY, truck_key).    % 镖车集合key


-define(TS_EVENT_0, 0).         % 东风事件
-define(TS_EVENT_1, 1).         % 免疫攻击事件

-define(TS_NEWS_0, 0).          % 东风事件新闻
-define(TS_NEWS_1, 1).          % 免疫攻击事件新闻
-define(TS_NEWS_2, 2).          % 被劫镖新闻

-define(TS_MAX_NEWS, 10).       % 最大新闻数

-define(TS_EVENTS, [?TS_EVENT_0, ?TS_EVENT_1]).     % 事件概率集合


-endif.