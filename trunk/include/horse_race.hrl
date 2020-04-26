%%%------------------------------------
%%% @author 严利宏 <542430172@qq.com>
%%% @copyright UCweb 2014.12.5
%%% @doc 跑马场头文件
%%% @end
%%%------------------------------------

-ifndef(__HORSE_RACE_H__).
-define(__HORSE_RACE_H__, 0). 

-define(HORSE_1, 1).    % 一号马
-define(HORSE_2, 2).    % 二号马
-define(HORSE_3, 3).    % 三号马
-define(HORSE_LIST, [?HORSE_1, ?HORSE_2, ?HORSE_3]).

-define(STATUS_GAMBLE, 0).  % 竞猜阶段
-define(STATUS_RACE, 1).    % 比赛阶段
-define(STATUS_CLOSE, 2).   % 比赛结束
% 跑马场信息
-record(ets_horse_race, {
        id = horse_race      % 唯一标识
        ,round = 0          % 轮次
        ,status = 0         % 比赛状态（0-竞猜阶段  1-比赛阶段  2-比赛结束
        ,time = 0           % 状态开始时间戳
        ,rank_type = 0      % 排名类型（0-12 详情见pt_29） 
        ,event_list = []    % 事件列表
        
        % 以下是预留字段，用于应付游戏正式上线后的功能需求的拓展
        ,reserved_field1 = null
        ,reserved_field2 = null
        ,reserved_field3 = null
    }).

% 跑马场状态信息
-record(horse_race_state, {
        race_players = dict:new()           % 竞猜玩家 % k=role_id v={horse_no, gamble_num}
        ,next_race_players = dict:new()     % 下场竞猜玩家（玩家在比赛中下注）
        ,race_props_good = dict:new()       % 使用神奇草料信息
        ,race_props_bad = dict:new()        % 使用绊马钉信息
        ,last_event_ratio = {0,0,0}         % 上次特殊事件产生的概率变化
        ,reward_players = dict:new()        % 有奖励的玩家信息
        ,first_horse_no = 0                 % 上轮中奖马号
        % ,player_gamble_times = dict:new()   % 玩家竞猜总次数  % k = role_id v = gamble_time
        ,use_prop_time  = dict:new()        % 玩家上次使用物品的时间 %k = role_id v = usePropTime
    }).

%% 玩家的跑马场活动竞猜数据
%% !!!!!!!!!!!!特别注意：因数据库activity_data表是直接存储本结构体，所以游戏正式上线后，千万不要修改本结构体内各字段的顺序!!!!!!!!!!
-record(player_gamble_times_state, {
        player_gamble_times = 0,  % 当天已竞猜活动的次数
        last_gamble_time    = util:unixtime(),  % 上一次竞猜的时间
        % 以下是预留字段，用于应付游戏正式上线后的功能需求的拓展
        reserved_field1 = 0,
        reserved_field2 = 0,
        reserved_field3 = 0
    }).

-endif. % __HORSE_RACE_H__
