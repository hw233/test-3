%%%-----------------------------------
%%% @Author  : lds
%%% @Email   :
%%% @Created : 2013.12
%%% @Description: 离线竞技场
%%%-----------------------------------
-ifndef (OFFLINE_ARENA_HRL).
-define(OFFLINE_ARENA_HRL, offline_arena_hrl).

-include("sys_code.hrl").

-define(OA_OPEN_LV, ply_sys_open:get_sys_open_lv(?SYS_OFFLINE_ARENA)).    %竞技场开发等级
-define(ENTER_NOVICE_LV, ply_sys_open:get_sys_open_lv(?SYS_OFFLINE_ARENA)).       % 新手组准入等级
-define(ENTER_BRONZE_LV, 50).       % 青铜组准入等级
-define(ENTER_SILVER_LV, 70).       % 白银组准入等级
-define(ENTER_GOLD_LV, 90).         % 黄金组准入等级
-define(ENTER_DIAMOND_LV, 110).      % 钻石组准入等级
-define(ENTER_EMPEROR_LV, 130).      % 帝皇组准入等级

-define(OA_CHANGE_RANK_LV, [?ENTER_BRONZE_LV, ?ENTER_SILVER_LV, ?ENTER_GOLD_LV, ?ENTER_DIAMOND_LV, ?ENTER_EMPEROR_LV]).

-define(OA_MANAGE, 'offline_arena_manage').     % 竞技场管理进程名

-define(OA_NOVICE, 1).      % 新手组
-define(OA_BRONZE, 2).      % 青铜组
-define(OA_SILVER, 3).      % 白银组
-define(OA_GOLD, 4).        % 黄金组
-define(OA_DIAMOND, 5).     % 钻石组
-define(OA_EMPEROR, 6).     % 帝皇组


-define(GROUP_NAME_LIST, [?OA_NOVICE, ?OA_BRONZE, ?OA_SILVER, ?OA_GOLD, ?OA_DIAMOND, ?OA_EMPEROR]).  %组别列表
-define(GET_PROC_NAME(Group), list_to_atom(string:concat("offline_arena_", tool:to_list(Group)))).      %进程注册名

%% ------------------------ ets -----------------------------

-define(ETS_ROLE_OFFLINE_ARENA, ets_role_offline_arena).  % 个人竞技场信息

-define(ETS_OFFLINE_ARENA_RANKING(Group),   % 全局组别排名信息
    case Group of
        ?OA_NOVICE -> ets_offline_arena_novice_ranking;
        ?OA_BRONZE -> ets_offline_arena_bronze_ranking;
        ?OA_SILVER -> ets_offline_arena_silver_ranking;
        ?OA_GOLD -> ets_offline_arena_gold_ranking;
        ?OA_DIAMOND -> ets_offline_arena_diamond_ranking;
        ?OA_EMPEROR -> ets_offline_arena_emperor_ranking
    end
        ).

-define(ETS_OFFLINE_ARENA_ROLE_RANKING(Group),   % 全局组别角色ID - 排名信息
    case Group of
        ?OA_NOVICE -> ets_offline_arena_novice_role_ranking;
        ?OA_BRONZE -> ets_offline_arena_bronze_role_ranking;
        ?OA_SILVER -> ets_offline_arena_silver_role_ranking;
        ?OA_GOLD -> ets_offline_arena_gold_role_ranking;
        ?OA_DIAMOND -> ets_offline_arena_diamond_role_ranking;
        ?OA_EMPEROR -> ets_offline_arena_emperor_role_ranking
    end
        ).


-define(ETS_OFFLINE_ARENA_TEMP_RANKING, ets_offline_arena_temp_ranking).        % 临时保存玩家战斗前排名

-define(ETS_RANKING_STAMP, ets_ranking_stamp).      % 排名快照

-define(DB_OFFLINE_ARENA_TABLE_NAME, "offline_arena_rank_").

%% ------------------------ state ---------------------------



-define(OA_ERROR, 0).
-define(OA_SUCCESS, 1).

-define(CHALLENGE_WARRIOR, oa_challenge_warrior).
-define(WRONG_ROLE, 2).
-define(NOT_ECOUGHT_TIMES, 3).
-define(IS_BATTLEING, 4).

-define(OA_LOCK, {offline_arena, lock}).
-define(RANK_LOCK, 1).
-define(UN_RANK_LOCK, 0).

-define(INIV_BATTLE, 0).        % 主动挑战
-define(PASI_BATTLE, 1).        % 被动挑战

-define(OA_BATTLE_WIN, 1).
-define(OA_BATTLE_LOSE, 0).

-define(WINNING_STREAK_TYPE, 1).  % 领取连胜奖励类型
-define(CHALENGE_TIMES_TYPE, 2).  % 领取场次奖励类型

-define(MAX_BATTLE_HISTORY_LENGTH, 10).         % 战报条数

-define(CAL_RANKING_START, 1).  % 开始排名结算
-define(CAL_RANKING_END, 2).    % 结算排名结算


-define(RANKING_LEADER, [1,2,3,4,5,6,7,8,9,10]).

-define(INIT_CHALLANGE_TIMES, 10).  %初始挑战次数
-define(VIP_CHALLANGE_TIMES, 10).  %VIP挑战次数
-define(INIT_BUY_CHALLANGE_TIMES, 0).  %初始可购买挑战次数
-define(VIP_BUY_CHALLANGE_TIMES, 10).  %VIP可购买挑战次数

-define(BUY_CHALLANGE_TIMES_MONEY, 100).   %

-define(MAX_CHALLANGE_TIMES(Vip), case Vip > 0 of true -> 20; false -> 20 end).   % 最大可挑战次数
-define(CHALLANGE_RESUME_TIME, 3600).   %挑战次数回复时间（S）

-define(OVER_MAX_RANKING, 0).       %超过排行榜最大容量时排名状态值

-define(RANKING_OUTER_VAL, 0).      % 榜外默认排名值

-define(RANKING_BLANK_VAL, 0).      % 空排名玩家默认Id值

-define(MAX_RANk_COUNT, 1000).          % 最大排名数

-define(WINNING_STREAK_1, 1).
-define(WINNING_STREAK_2, 10).
% -define(WINNING_STREAK_3, 15).

-define(WINNING_STREAK_LIST, [?WINNING_STREAK_1, ?WINNING_STREAK_2]).

-define(GET_WINNING_STREAK_REWARD(St),  % 连胜奖励
        if  St < ?WINNING_STREAK_1 -> null;
            St < ?WINNING_STREAK_2 -> data_offline_arena:get_ws_reward(five_rid);
            true -> data_offline_arena:get_ws_reward(ten_rid)
            % St < ?WINNING_STREAK_2 -> 10001;
            % St < ?WINNING_STREAK_3 -> 10001;
            % true -> 10001
        end
    ).

-define(MAX_REWARD_TIMES, 3).       % 每日最大领奖次数
-define(REWARD_CD, 7200).           % 领奖CD
-define(REWARD_REFRESH_TIME, 3).    % 每日奖励刷新时间
-define(DAY_SECONDS, 86400).

-define(REFRESH_RANKING_CD, 7200).  % 刷新排行榜CD(s)

-define(CHALLENGE_CD, 300).         % 挑战CD (s)

-define(CANCEL_CHALL_CD_MONEY, 100). % 取消挑战CD钱数

-define(OA_RANK_STATIC, 0).     % 排名不变
-define(OA_RANK_ASC, 1).        % 排名上升
-define(OA_RANK_DESC, 2).        % 排名下降

-define(OA_RANK_EXCEPT, 1).     % 排名异常
-define(OA_RANK_NORMAL, 0).     % 排名状态正常

-record(offline_arena, {
    id = 0
    ,group = 0
    ,rank = 0
    ,rank_seed = 0
    ,refresh_stamp = 0
    ,reward_times = 0
    ,reward_stamp = 0
    ,challange_times = 0
    ,challange_stamp = 0
    ,challenge_buy_times = 0
    % ,offline_stamp = 0
    ,winning_streak = 0
    ,reward_ws = 0
    % ,reward_ws_stamp = 0
    ,battle_history = []

    ,create_stamp = 0
    ,update_stamp = 0

    % ,challenge_times = 0
    ,reward_chal = 0
    ,his_max_ws_no = 0
    }).

-record(offline_arena_role_info, {
    id = 0
    ,rank = 0
    ,lv = 0
    ,name = <<>>
    ,race = 0
    ,faction = 0
    ,battle_power = 0
    ,vip_lv = 0
    ,peak_lv = 0
    }).


-record(offline_arena_ranking, {
    rank = 0
    ,id = 0
    }).


-record(ranking_stamp, {
    id = 0
    ,group = 0
    ,rank = 0
    }).

-record(offline_arena_role_ranking, {
    id = 0,
    rank = 0
    }).

-record(battle_history, {
    id = 0
    ,timestamp = 0      %% 战报时间戳
    ,challenger = <<>>  %% 挑战者名字
    ,combat_type = 0    %% 战斗类型(0->主动挑战 1->被动)
    ,result = 0         %% 结果(0->lose 1-win)
    ,state = 0          %% 排名状态
    ,rank = 0           %% 排名
    ,feat = 0           %% 获得功勋
    ,group = 0          %% 所在组别
    ,except = 0         %% 异常状态 (0:正常 1:异常)
    }).


-record(temp_ranking, {
    id = {0, 0}
    ,rank = 0
    }).

-endif.