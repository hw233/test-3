%%%-----------------------------------
%%% @Author  : lds
%%% @Email   : 
%%% @Created : 2013.10
%%% @Description: 副本
%%%-----------------------------------
-ifndef (DUNGEON_HRL).
-define(DUNGEON_HRL, dungeon_hrl).

-include("event.hrl").
%% ================================================

%% --------------- state -------------------
-define(DEFAULT_STATE, 0).
-define(ERROR, 0).          %错误
-define(SUCCESS, 1).        %成功
-define(LV_NOT_ENGOUTH, 2). %等级不足
-define(TEAM_LIMIT, 3).     %队伍人数不足
-define(DUN_LIMIT, 4).      %
-define(CD_LIMIT, 5).       %CD
-define(DUN_TIMES_USED_OUT, 6). %时间
-define(NOT_ENGOUTH_DUN_PROPS, 7).  %道具不足
-define(DUN_NOT_SAME, 8).           %副本进度不同

-define(PASS, 1).

-define(SINGLE_DUN, 1).
-define(TEAM_DUN, 2).

-define(TOWER_DUNGEON_NO, 100001).       %% 爬塔副本编号

-define(HARD_TOWER_DUNGEON_NO1, 100002).       %% 噩梦爬塔副本编号
-define(HARD_TOWER_DUNGEON_NO2, 100003).       %% 噩梦爬塔副本编号
-define(HARD_TOWER_DUNGEON_NO3, 100004).       %% 噩梦爬塔副本编号
-define(HARD_TOWER_DUNGEON_NO_LIST, [?HARD_TOWER_DUNGEON_NO1, ?HARD_TOWER_DUNGEON_NO2, ?HARD_TOWER_DUNGEON_NO3]). %%噩梦爬塔副本

-define(BOSS_DUNGEON_NO_MOLONG, 110001).        %% 魔龙BOSS编号
-define(BOSS_DUNGEON_NO_YIJUN, 110002).        %% 异军BOSS编号

-define(DUN_GUILD, 123456124).               %% %弃用 帮派副本编号

-define(DUN_GUILD_PREPAR, 200010).        %% 帮派战场准备副本编号

-define(DUN_GUILD_BATTLE, 200011).        %% 帮派战场战斗副本编号

-define(TOWER_POSITION_FALG, {dun, tower_flag}).

-define(HARD_TOWER_POSITION_FALG, {dun, hardtower_flag}). 

-define(INFINITE_TIME, 0).       % 无限时间

-define(FLOOR_TO_ID(Floor), Floor * 10).
-define(ID_TO_FLOOR(Id), (Id div 10)).

-define(EASY, 1).
-define(MIDDLE, 2).
-define(HARD, 3).

-define(DIAMOND_BOX, 1).
-define(GOLD_BOX, 2).
-define(SILVER_BOX, 3).
-define(COPPER_BOX, 4).

-define(POINTS_LV(Lv), 
    case Lv of
        1 -> [?DIAMOND_BOX, ?DIAMOND_BOX, ?DIAMOND_BOX, ?DIAMOND_BOX];
        2 -> [?GOLD_BOX, ?GOLD_BOX, ?GOLD_BOX, ?GOLD_BOX];
        3 -> [?SILVER_BOX, ?SILVER_BOX, ?SILVER_BOX, ?SILVER_BOX];
        4 -> [?COPPER_BOX, ?COPPER_BOX, ?COPPER_BOX, ?COPPER_BOX]
    end
        ).

-define(AHEAD_CHECK, ahead_check).


-define(MAX_BOX_NUM, 4).        %% 最大箱子数

-define(DUN_TIMER_REF, {dungeon, timer_ref}).     % 计时器句柄

-define(DUN_TIMER_REF(Id), {dungeon, timer_ref, Id}).     % 计时器句柄

-define(GUILD_DUNGEON_LIST, [?DUN_GUILD, ?DUN_GUILD_PREPAR, ?DUN_GUILD_BATTLE]).      % 帮派副本列表

-define(BOSS_RANK_NUM, 10).         % 排行榜显示人数

-define(BOSS_HP_COEF, 360).           % 世界BOSS血量修正参数

-define(DEFAULT_BOSS_PLAYER_LV, 40).    % 默认世界BOSS人物等级
-define(MAX_BOSS_PLAYER_LV, 150).       % 默认最大世界BOSS人物等级
-define(DEFAULT_BOSS_PLAYER_NUM, 1).   % 默认世界BOSS参与人数

%% --------------- time --------------------
-define(RECLAIM_INTERVAL, 7200000).  % 2 hour
-define(ENSURE_WAIT_TIME, 8).
-define(CLOSE_WAITING_TIME, 10000).

-define(PASS_WAITING_CLOSE_TIME, 120000).   % 通关后等待检测副本是否还有人的等待时间

-define(BROADCAST_DUNGEON_PLAYER_NUM, 10000).      % 广播副本人数时间间隔

-define(BOSS_CHAL_CD, 60).                  %世界BOSS挑战CD(sec)

-define(BOSS_DUNGEON_WAIT_CLOSE, 10000).    % 世界BOSS副本最后关闭等待时间

-define(DUN_BOSS_DELAY_REWARD_TIME, 10000).     % 世界BOSS被杀后等待奖励结算时间

%% --------------- data --------------------
-define(ETS_ROLE_DUNGEON, ets_role_dungeon).
-define(ETS_DUNGEON_CD, ets_dungeon_cd).

-define(ENSURE_LIST, {dungeon, ensure}).

-define(DUNGEON_PASS_MEM, {dungeon, pass_record}).

-define(BOUT_SUB_POINTS, 100).   % 回合减分
-define(DEAD_SUB_POINTS, 100).   % 死亡减分


-define(PASS_LV, {dungeon, pass_lv}).

-define(DUN_GUILD_MAX_FLOOR, {dungeon, guild_max_floor}).       % 帮派副本最大层数
-define(DUN_GUILD_Id, {dungeon, guild_id}).                     % 帮派ID
-define(DUN_GUILD_FLOOR, {dungeon, guild_floor}).               % 帮派副本当前层数

-define(DUNGEON_PLAYER_NUM, {dungeon, player_num}).             % 副本人数

-define(DUNGEON_BOSS_HP, {dungeon, boss_hp}).                   % 副本BOSS HP

-define(BOSS_DAMAGE_RANK, {dungeon, boss_damage_rank}).         % 副本BOSS伤害排行

-define(FINAL_KILL_BOSS, {dungeon, final_kill_boss}).           % 最终击杀BOSS人物ID

-define(PUBLIC_DUN(DunNo), {dungeon, public_dungeon, DunNo}).   % 公共副本编号-PID映射表

-define(DUNGEON_BOSS_TIME, {dungeon, boss_time}).

-define(DUN_ROLE_ENTER_TIME(RoleId), {dungeon_enter_time, RoleId}).  % 玩家进入副本时间

%% --------------- function --------------------
-define(BOND_RESUME_ITEM, 60019).


-define(DUNGEON, dungeon).

-define(REWARD_TIMES, [a,a,a,a,a]).

-define(DIFFICULTLY, [1]).

-define(LV_NUM, 4).

-define(DUN_TP(MapNo, TpNo, X, Y), {dungeon, tp, MapNo, TpNo, X, Y}).

-define(DUN_MON(MapNo, MonNo, X, Y), {dungeon, mon, MapNo, MonNo, X, Y}).

-define(DUN_NPC(MapNo, NpcNo, X, Y), {dungeon, npc, MapNo, NpcNo, X, Y}).

-define(WAIT_TO_RECLAIM, {dungeon, wait_to_reclaim}).

-define(DUNGEON_PASS_MEM_BOX, {dungeon, dungeon_pass_box}).

-define(DUN_GUILD_MAP_ID, {dungeon, guild_map_id}).           % 帮派地图ID


-define(DUN_PRI, 1).        % 私人副本
-define(DUN_PUB, 0).        % 公共副本

% ---------------- event --------------------
%% 私人副本注册的事件
-define(DUNGEON_REG_EVENT, [
    ?TASK_CAN_ACCEPT_EVENT, ?TASK_ACCEPTED_EVENT, ?TASK_COMPLETED_EVENT, ?TASK_SUBMIT_EVENT, ?TASK_FAIL_EVENT, ?HAVE_BAG_ITEM, ?TAKE_PET,
    ?HAVE_MONEY, ?IN_DUNGEON, ?IN_SCENE, ?IN_POSITION, ?BATTLE_WIN, ?BATTLE_FAIL, ?PLOT_FINISH, ?DUN_TIME_OUT, ?BATTLE_WIN_GROUP, ?BATTLE_FAIL_GROUP,
    ?TOWER_TOP, ?NEXT_FLOOR, ?SET_DUNGEON_PASS_2, ?SET_FLOOR_PASS, ?CLIENT_BATTLE_END, ?GET_ASSIGN_REWARD, ?RAND_BATTLE_WIN, ?RAND_BATTLE_WIN_GROUP
    ]).

%% 公共副本注册事件
-define(PUBLIC_DUNGEON_EVENT, [?DUN_TIMER_TIMEOUT, ?DUN_POINTS_THRESHOLD, ?DUN_MAX_FLOOR, ?DUN_NOT_MAX_FLOOR, ?DUNGEON_BOSS_KILLED]).


%%-------------副本类型-------------------------
-define(DUNGEON_TYPE_BOSS, 6).              %% 世界BOSS类型
-define(DUNGEON_TYPE_TOWER, 8).             %% 镇妖塔 new
-define(DUNGEON_TYPE_GUILD, 7).             %% 帮派副本类型
-define(DUNGEON_TYPE_EQUIP, 2).             %% 装备副本类型
-define(DUNGEON_TYPE_PET,   4).             %% 宠物副本类型
-define(DUNGEON_TYPE_TVE,   9).             %% 兵临城下副本类型
-define(DUNGEON_TYPE_GUILD_PREPARE, 10).    %% 帮派战斗预备副本
-define(DUNGEON_TYPE_GUILD_BATTLE, 11).     %% 帮派战斗副本
-define(DUNGEON_TYPE_HARD_TOWER, 12).       %% 噩梦爬塔类型
-define(DUNGEON_TYPE_NEW_GUILD, 13).       %% 帮派副本
-define(DUNGEON_TYPE_TOWER_GHOST, 14).       %% 伏魔塔副本类型

-define(RANDOM_REWAR_ID, 89001).       %% 魔龙幸运奖ID
%% --------------- record --------------------


-record(dungeon, {
     id = 1                 %副本唯一ID
    ,no = 0                 %副本编号
    ,type = 0               %类型
    ,diff = 0               %难度
    ,lv = 0                 %等级
    ,pid = 0                %副本进程ID
    ,pass = 0               %通关标志
    ,builder = 0            %副本创建者ID
    ,actives = []           %副本参与者ID
    ,outer = []             %副本外
    ,create_timestamp = 0   %创建时间
    ,living_time = 0        %副本存活时间
    ,map_index = []         %副本地图索引{地图编号, 场景ID}
    ,listening = []         %正在监听的事件状态列表 #listen_state{}
    ,bouts = 0              %副本战斗回合数
    ,deads = 0              %副本战斗死亡数
    ,proc_type = 0          %程序副本类型(?DUN_PRI, ?DUN_PUB)
    ,had_pass_reward = 0    %是否有通关奖励
    }).

-record(listen_state, {
    id = 0,                 %监听器ID
    state = 0,              %当前状态值
    finish = 0,              %完成状态值
    condition = [],
    action = []
    }).

-record(role_dungeon, {
     id = {0, 0}            %{roleId, dunId}
    ,pass = 0               %副本是否(1/0)已通关
    ,timestamp = 0          %创建副本的时间戳
    % ,times = 0              %当前已经创建副本的次数
    }).

-record(dungeon_cd, {
     id = {0, 0}             %{roleId, dunGroup}
    ,timestamp = 0          %创建副本的时间戳
    ,times = 0              %当前已经创建副本的次数
    }).

-record(dungeon_data, {     % 配置表数据记录
     no = 0
    ,group = 0
    ,pass_group = 0
    ,had_pass_reward = 1
    ,lv = 0
    ,diff = 0
    ,type = 0
    ,npcNo = 0
    ,cd = {}
	,floor = 0
    ,role_num = 0
    ,timing = 0
    ,init_pos = {}
    ,more_box_price = 0
    ,discount = 0
    ,default_listener = []
    ,listener = []
    ,listen_bout_battle = []
    ,listen_dead_battle = []
    ,bout_max_points = 0
    ,dead_max_points = 0
    ,point_lv = []
    ,reward_times = 0 %% 控制是否可获得副本通关奖励
	,final_reward = 0
	,first_reward = 0
    }).

-record(listener, {
     id = 0
    ,condition = []
    ,action = []
    }).

-record(condition, {
     type = nil
    ,object = nil
    ,target = []
    }).

-record(action, {
     type = nil
    ,object = nil
    ,target = []
    }).

-record(dungeon_pass_info, {
     id = 0
    ,no = 0
    ,bouts = 0
    ,deads = 0
    ,bout_points = 0
    ,dead_points = 0
    ,lv = 0
    ,box = []
    ,ref = 0 %% 用来识别翻箱子是否同一场
    }).

-record(dungeon_tower,{
    floor = 1
    ,fuben_id = 11001
    ,cost1 = {2,100}
    ,cost2 = {3,100}}).


%% --------------- debug --------------------

-ifdef (debug).
    -define(DUN_DEBUG(Msg, Id), lib_dungeon:dun_debug(Msg, Id)).
-else.
    -define(DUN_DEBUG(_Msg, _Id), skip).
-endif.


%% ================================================

-endif.