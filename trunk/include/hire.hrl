%%%------------------------------------------------
%%% File    : hire.hrl
%%% Author  : zhangwq
%%% Created : 2013-12-30
%%% Description: 雇佣天将、受雇系统的相关记录、宏定义
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__HIRE_H__).
-define(__HIRE_H__, 0).

% 宠物简要信息
-record(par_brief, {
        id = 0,
        no = 0,
        name = <<"无名">>,
        lv = 0,
        position = 0,     % 是否主宠：1表示主宠
        battle_power = 0
    }).

% 可以供雇佣的天将数据
-record(hire, {
        id = 0, % 玩家id
        name = <<"无名">>,
        lv = 0,
        faction = 0,
        battle_power = 0,
        left_time = 0, % 当天剩余可被雇佣的的次数 24点清0
        price = 0,      % 当前被雇佣一次（参加一次战斗）的价格（绑银）可以修改
        par_list = [],  % [] | par_brief 列表
        hire_history = [], % [] | {PlayerId, Name, Time, Income} --> {雇主玩家id，名字，雇佣次数} 列表，表示被雇佣历史情况
        get_income = 0,      % 已经领取的收益
        sex = 0,             % 显示玩家模型需要
        change_price_count = 0 % 今天修改价格次数
    }).


% 雇主雇佣情况信息数据
-record(hirer, {
        id = 0, % 雇主玩家id 
        hire_id = 0,  % 被雇佣天将id
        hire_name = <<"无名">>,
        hire_lv = 0,
        hire_battle_power = 0,
        left_time = 0,    % 剩余助战次数
        hire_par_list = [], % [] | par_brief 列表
        is_fight = 0,       % 是否出战 1表示出战
        hire_sex = 0,
        hire_faction = 0
    }).


% -define(MAX_HIRED_TIME, 100).    % 每天最大可被雇佣的次数
-define(TAX_RATE, 5).           % 今日税率

-define(FIGHT_STATE, 1).        % 出战
-define(REST_STATE, 0).         % 休息

-define(CHANGE_PRICE_COUNT_DAY, 2). %% 当天修改价格次数限制

-define(HIRE_MGR_PROCESS, hire_mgr_process).

-endif.  %% 