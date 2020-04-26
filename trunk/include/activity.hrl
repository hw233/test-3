%%%------------------------------------------------
%%% File    : activity.hrl
%%% Author  : lds 
%%% Created : 
%%% Description: 活动相关
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__ACTIVITY_H__).
-define(__ACTIVITY_H__, 0).

-include("sys_code.hrl").

% 没用！！
% %% 活动的代号
% -define(ACTIVITY_DAILY_FACTION, 1).     % 每日师门
% -define(ACTIVITY_OFFLINE_ARENA, 2).     % 离线竞技场
% -define(ACTIVITY_LL_TOWER, 3).          % 玲珑宝塔
% -define(ACTIVITY_SANDABAIGU, 4).        % 三打白骨
% -define(ACTIVITY_SUOYAO, 5).            % 锁妖大阵
% -define(ACTIVITY_BUXING, 6).            % 捕星任务
% -define(ACTIVITY_ANSWER, 7).            % 答题
% -define(ACTIVITY_DAILY_ONLINE, 8).      % 每日在线 
% -define(ACTIVITY_YUNBIAO, 9).           % 运镖
% -define(ACTIVITY_TIME_BOSS, 10).        % 定时boss
% -define(ACTIVITY_TREASURE_HUNT, 11).    % 挖宝
% -define(ACTIVITY_GUILD_TASK, 12).       % 帮派任务
% -define(ACTIVITY_MON_SIEGE, 13).        % 怪物攻城
% -define(ACTIVITY_EXP_BB, 14).           % 经验宝宝
% -define(ACTIVITY_PARTNER_BB, 15).       % 女妖宝宝
% -define(ACTIVITY_GUILD, 16).            % 帮派活动
% -define(ACTIVITY_GUILD_DUNGEON, 17).    % 帮派副本
% -define(ACTIVITY_ONLINE_1V1_ARENA, 18). % 在线1v1竞技场（比武大会）





-record(answer, {
    role_id = 0
    ,join_time = 0          % 参与活动时间戳
    ,cur_question = 0       % 当前题号
    ,cur_index = 0          % 当前题目进度号
    ,correct_num = 0        % 当前答对题数
    ,his_cor_num = 0        % 历史答对题数
    ,literary = 0           % 学分
    ,exp = 0                % 经验
    ,reward_info = []       % 奖励信息  [{streak, [{连对数, 领取状态(0：不可领 1：可领 2: 已领)}]}, {correct, [{答对数, 领取状态}]}]
    ,acepack_info = []      % 锦囊信息  {锦囊编号::integer(), 使用次数::integer(), 对应题目进度号::integer(), 附属属性::lists()}
    ,questions_info = []    % 已出题目信息 [{qustion_type, num}, ...]
    ,score_streak = 0       % 连对题数
    }).

-record(answer_reward, {
    r_exp = 0,
    r_b_silver = 0,
    r_literary = 0,
    w_exp = 0,
    w_b_silver = 0,
    w_literary = 0,
    streak_reward_1 = 0,
    streak_reward_2 = 0
    }).



-record(guess_question,		{
							 id,
							 title,
							 content,
							 options,
							 correct,
							 commission,
							 is_reward = 0,
							 time_bet_begin,
							 time_bet_end,
							 time_show_begin,
							 time_show_end,
							 create_time,
							 total_cup = 0,
							 total_rmb = 0
							}).


-define(GUESS_DB_FIELD_ESCAPE,	[options]).

-define(GUESS_POS_FIELD_LIST,	[
								 {#guess_question.id, id},
								 {#guess_question.title, title},
								 {#guess_question.content, content},
								 {#guess_question.options, options},
								 {#guess_question.correct, correct},
								 {#guess_question.commission, commission},
								 {#guess_question.time_bet_begin, time_bet_begin},
								 {#guess_question.time_bet_end, time_bet_end},
								 {#guess_question.time_show_begin, time_show_begin},
								 {#guess_question.time_show_end, time_show_end}
								 ]).


-define(ANSWER_ACEPACK_NAME(PackIndex), case PackIndex of           % 取得锦囊次数名次
        1 -> answer_acepack_1_times;
        2 -> answer_acepack_2_times;
        3 -> answer_acepack_3_times 
    end
    ).       

-define(ANSWER_STREAK_TYPE, 0).         % 连对类型
-define(ANSWER_CORRECT_TYPE, 1).        % 答对类型

-define(ACEPACK_LIST, [1,2,3]).         % 锦囊编号列表

-define(OPTIONS, [1,2,3,4]).            % 答题答案选项

-define(SCORE_STREAK_1, 10).
-define(SCORE_STREAK_2, 20).
-define(SCORE_STREAK_LIST, [?SCORE_STREAK_2]).   % 连对奖励题数

-define(SCORE_CORRECT_1, 10). 
-define(SCORE_CORRECT_LIST, [?SCORE_CORRECT_1]).        % 答对奖励题数

-define(SCORE_STREAK_REWARD(Times), 
    case Times of
        10 -> 0;
        20 -> 0
    end).                               % 连对奖励

-define(MAX_QUESTION_NUM, 20).          % 最大题数

-define(ANSWER_OPEN_LV, ply_sys_open:get_sys_open_lv(?SYS_ANSWER)).            % 答题开放等级

-define(ANSWER_ACTIVITY_TYPE, 7).      % 答题活动类型













-endif.  %% __ACTIVITY_H__