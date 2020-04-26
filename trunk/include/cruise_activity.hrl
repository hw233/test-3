%%%------------------------------------------------------------------------------
%%% File    : cruise_activity.hrl
%%% Author  : huangjf
%%% Created : 2014.6.12
%%% Description: 巡游活动
%%%------------------------------------------------------------------------------


%% 避免头文件多重包含
-ifndef(__CRUISE_ACTIVITY_H__).
-define(__CRUISE_ACTIVITY_H__, 0).






%% 玩家的巡游活动数据
%% !!!!!!!!!!!!特别注意：因数据库activity_data表是直接存储本结构体，所以游戏正式上线后，千万不要修改本结构体内各字段的顺序!!!!!!!!!!
-record(ply_cruise, {
		join_times = 0,  % 当天已参加活动的次数

		% 以下是预留字段，用于应付游戏正式上线后的功能需求的拓展
		reserved_field1 = 0,
		reserved_field2 = 0,
		reserved_field3 = 0
	}).




%% trigger cruise event
-record(tri_cru_event, {
		pos = {0, 0},
		events = []
	}).



%% cruise event
-record(cru_event, {
		no = 0,
		type = 0,
		stay_time = 0,
		question_pool = [],
		reward = null
	}).



%% 巡游事件的类型
-define(CRU_EVENT_T_STAY, 1).   % 停留
-define(CRU_EVENT_T_TALK, 2).   % 说话
-define(CRU_EVENT_T_QUIZ, 3).   % 互动答题


-define(ONE_QUIZ_LASTING_TIME_MS, 10000).  % 一次互动答题的持续时间（单位：毫秒）

-define(INVALID_QUESTION_NO, 0).  % 无效的题目编号
-define(INVALID_QUIZ_EVENT_NO, 0). % 无效的互动答题事件编号


% -define(CRUISE_NPC_INIT_POS, {1304, 122, 115}).





-define(MAX_JOIN_TIMES_PER_DAY, 1).   % 玩家每天参与活动的最大次数




-define(MAX_JOIN_PLAYER_COUNT_EACH_TIME, 80). % 单次巡游所允许的最大报名人数








-endif.  %% __CRUISE_ACTIVITY_H__
