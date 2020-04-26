%%%------------------------------------------------
%%% File    : team.hrl
%%% Author  : huangjf zhangwq
%%% Created : 2012-4-15 2013-9-11
%%% Description: 组队系统相关的宏
%%%------------------------------------------------

%% 注：tm是team的缩写


%% 避免头文件多重包含
-ifndef(__TEAM_H__).
-define(__TEAM_H__, 0).




%% 开启组队功能所需的最低等级
% -define(START_TEAM_NEED_LV, 16).


%% 队伍阵型的位置
-define(TEAM_TROOP_POS_MIN, 	1).   % 队伍阵型的最小位置
-define(TEAM_TROOP_POS_MAX, 	9).   % 队伍阵型的最大位置
-define(TEAM_TROOP_POS_INVALID, 0).   % 无效的队伍阵型位置



-define(TEAM_MEMBER_MAX, 5).    		% 队伍最多有5个人


-define(MB_STATE_INVALID, 0).       % 无效的状态
-define(MB_STATE_TEM_LEAVE, 1).     % 暂离
-define(MB_STATE_IN, 2).            % 在队在线
-define(MB_STATE_OFFLINE, 3).       % 离线托管（参与队伍战斗、获取任务进度等）


%% 队伍类型
%% 0:任意, 1:任务，2：副本，3：日常，4：活动
-define(TM_TYPE_MIN, 0).
-define(TM_TYPE_NONE, 0).
-define(TM_TYPE_TASK, 1).
-define(TM_TYPE_COPY, 2).
-define(TM_TYPE_DAILY, 3).
-define(TM_TYPE_ACTIVITY, 4).
-define(TM_TYPE_MAX, 4).


%% 队伍条件1范围
-define(TM_CON1_MIN, 0).
-define(TM_CON1_MAX, 20).


%% 怪物等级段范围
-define(TM_MON_LV_STEP_MIN, 0).
-define(TM_MON_LV_STEP_MAX, 15). %% 90~99


%%%-define(TIME_MB_IN_TM_LOGOUT, (60 * 3)).      % 作废！！ 玩家离线后保持离线在队的时间 单位s  测试用的时间 注意：此时间应小于服务器缓存玩家数据的时间
-define(TIME_LEADER_IN_TM_LOGOUT, 20).      % (暂时没用了)% 在队队长离线后保持离线在队的时间 单位s  测试用的时间 注意：此时间应小于服务器缓存玩家数据的时间

-define(PLAYER_COUNT_ALONE_LIST, 20).       % 每次获取或刷新落单玩家列表的玩家个数

-define(DISTANCE_RETURN_TEAM, 40).          % 玩家归队允许的最大距离

-define(TM_OI_CODE_LV, 2).                  % 与 PT_TM_NOTIFY_MEMBER_JOIN 协议字段位置对应


-define(TEAM_ENSURE_LIST, {act_no, team_ensure}).     % 组队进入某个活动的信息，保存在某个进程字段的key



%%队伍详细资料
-record(team, 
    {
    	team_id = 0,        		     % 队伍唯一id
        leader_id = 0,         		     % 队长id
        leader_pid= none,      		     % 队长pid
        leader_name = <<"">>,      		 % 队长名字
        scene = 0,            		     % 队伍所属普通场景编号
        members = [], 				     % 队员列表,存mb结构体,元素的顺序表示玩家在地图移动时的排队顺序
        troop_no = 0,			  		 % 队伍当前启用的阵法编号
        team_activity_type = 0,    		 % 队伍活动类型：0:任意, 1:任务，2：副本，3：日常，4：活动
		condition1 = 0,                  % 队伍条件限制1
        condition2 = 0,                  % 队伍条件限制2
        lv_range = {0,100},              % 队伍成员等级范围
		team_name = <<"">>,				 % 队伍名字
        create_time = 0,                 % 创建时间
        apply_list = [],                 % 申请入队玩家信息列表，存apply结构体
        invited_list = [],               % 队长已经发送邀请信息的玩家id列表
        task_mon_list = [],               % [] | [{TaskId, [{MonId, MonNo} ...]}]
        is_exam = 0                      %% 1表示需要审核，0是默认值
    }).


%%队员数据(mb: member的缩写)
-record(mb, 
    {
        id = 0,             % 队员id
        pid = none,         % 队员pid
        troop_pos = 0,      % 队员在队伍阵型中的位置(1~9)
        train_pos = 0,      % 队员在组队界面或在场景中拖火车的位置(目前是1到5)
        name = <<"">>,      % 队员名字
        state = 0           % 玩家状态：1 暂离，2 在队在线 3 离线托管（参与队伍战斗、获取任务进度等）
    }).


% 申请入队玩家信息
-record(apply,
    {
        player_id = 0,
        player_name = <<"">>,       % 申请玩家姓名
        lv = 0,                     % 等级
        race = 0,                   % 种族
        sex = 0,
        faction = 0,
        weapon = 0,
        back_wear = 0,
        headwear = 0,                   %头饰编号
        clothes = 0,                    %服饰编号
        magic_key = 0,
        suit_no = 0 ,                    % 玩家套装最低强化等级，如果没有套装则是0
        battle_power = 0
    }).








-endif.  %% __TEAM_H__
