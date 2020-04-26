%%%-----------------------------------
%%% @Author  : liuzhongzheng2012@gmail.com
%%% @Email   :
%%% @Created : 2014.6.10
%%% @Description: 1v1在线竞技场
%%%-----------------------------------

%% 避免头文件多重包含
-ifndef(__ARENA_1V1_H__).
-define(__ARENA_1V1_H__, 0).

-define(MAX_DAY_WIN, 10).
-define(MAX_DAY_LOST, 3).
-define(MIN_LV, 22).
-define(WIN_JIFEN, 3).
-define(LOSE_JIFEN, 1).
-define(MAX_PLAYERS, 3).

-record(waiter, {
                id       = 0,
                win      = 0,
                win_rate = 0, % 万分之
                lv       = 0,
                name     = <<>>,
                sex      = 0,
                race     = 0,
                rand     = 0}).

%% !!!!!!!!!!!!特别注意：因数据库activity_data表是直接存储本结构体，所以游戏正式上线后，千万不要修改本结构体内各字段的顺序!!!!!!!!!!
-record(arena1, {
                id        = 0,
                day_wins  = 0,
                day_all   = 0,
                week_wins = 0,
                week_all  = 0,
                recs      = [],
                ext       = [],

                % 以下是预留字段，用于应付游戏正式上线后的功能需求的拓展
                reserved_field1 = 0,
                reserved_field2 = 0,
                reserved_field3 = 0
    }).

-record(rec, {
                winer = 0,
                winer_name = <<>>,
                loser = 0,
                loser_name = <<>>,
                time  = 0,
                winer_wins = 0 % 胜方胜利场数
                }).

-record(astate, {
                waiters       = [],
                recs          = [],
                remain        = [],
                player_infos  = [], % 参赛玩家信息（相当于报名表）[#arena_1v1_player{}, ...]
                week_top_id   = 0,
                week_top_name = <<"">>
                }).

% 比武大会玩家信息表（报名表）
-record(arena_1v1_player, {
                id = 0              % 玩家Id
                ,day_wins = 0       % 胜利场数
                ,day_loses = 0      % 当天总战斗数
                ,battle_flag = 0    % 战斗标识（1则标识战斗中，活动结束的时候战斗中玩家需要终止战斗进程）
    }). 


% 比武大会3v3参加team信息
-record(arena_3v3_waiter, {
        id = 0              %队长id
        ,team_id = 0         %队伍id
        ,team_name = <<"">> %队伍名
        ,team_power = 0     %队伍战力
        ,battle_flag = 0    %战斗标识（1则标识战斗中，活动结束的时候战斗中玩家需要终止战斗进程）
    }).

% 比武大会3v3玩家信息表
-record(arena_3v3_player, {
                id = 0              % 玩家Id
                ,day_wins = 0       % 胜利场数
                ,day_loses = 0      % 当天总战斗数
                ,battle_flag = 0    % 战斗标识（1则标识战斗中，活动结束的时候战斗中玩家需要终止战斗进程）
                ,day_all = 0
                ,player_status = 0  % 比武竞技状态
    }).

-record(arena_3v3_state, {
        waiters = []     %准备下次匹配开始比赛的队伍
        ,recs         = []
        ,remain        = []
        % ,battle_teams = []   %当前正在匹配的比赛队伍
        ,player_infos = [] %所有参与此次比武大会的玩家id
        ,week_top_id   = 0
        ,week_top_name = <<"">>
    }).

-record(arena_3v3_reward, {
        no = 0
        ,min = 0
        ,max = 0
        ,goods_id = 0
    }).

-endif.
