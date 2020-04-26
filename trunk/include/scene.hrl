%%%------------------------------------------------
%%% File    : scene.hrl
%%% Author  : huangjf
%%% Created : 2012-4-16
%%% Description: 场景相关的宏
%%%------------------------------------------------


%% 避免头文件多重包含
-ifndef(__SCENE_H__).
-define(__SCENE_H__, 0).


%% 主城的重生点
-define(REBORN_POS_OF_MAIN_CITY, {1304, 155, 118}).
%% 桃源镇的重生点
-define(REBORN_POS_OF_TAOYUANZHEN, {1303 , 107, 78}).

%% 地牢地图
-define(REBORN_POS_OF_PRISON, {9001, 23, 13}).


%% 场景模板（由策划配置）
-record(scene_tpl, {
        no = 0,              % 场景编号
        % res_id = 0,          % 资源id(resource id)
        name = <<"无名">>,   % 场景名称
        type = 0,            % 场景类型
        subtype = 0,         % 场景子类型(详见scene.hrl)

        width = 0,           % 场景宽度（X坐标的最大值）
        height = 0,          % 场景高度（Y坐标的最大值）

        % x0 = 0,              % 默认开始点X坐标
        % y0 = 0,              % 默认开始点Y坐标

        npcs = [],            % 场景中的静态npc编号列表，注意：按目前的设计，只有普通场景中才有静态npc，非普通场景中的npc都认为是动态npc！ -- huangjf
        mons = [],            % 场景中的静态明雷怪编号列表

        teleports = [],       % 传送点列表

        spawn_mon_area_list = [],  % 刷怪区域列表，格式如：[{X, Y, 宽度半径，高度半径}, ...]
    
        explore_area = [],      % 探索区域

        dig_treasure_area = []  % 挖宝区域
    }).


%% 内存中的场景对象
-record(scene, {
        id = 0,              % 场景id（唯一id）
        no = 0,              % 场景编号
        %%res_id = 0,          % 资源id(resource id)
        %%name = <<"无名">>,   % 场景名称
        type = 0,            % 场景类型(1:普通场景, 2:副本场景，3:特殊场景，详见scene.hrl)
        subtype = 0,         % 场景子类型(详见scene.hrl)

        width = 0,           % 场景宽度（X坐标的最大值）
		height = 0           % 场景高度（Y坐标的最大值）

        % x0 = 0,              % 默认开始点X坐标
        % y0 = 0,              % 默认开始点Y坐标
    }).



%% 场景中的对象记录
-record(objs_of_scene, {
        scene_id = 0,         % 场景id
        static_npcs = [],     % 场景中静态npc的id列表
        dynamic_npcs = [],    % 场景中动态npc的id列表
        mons = [],            % 场景中明雷怪（静态+动态）的id列表
        dynamic_teleports = [] % 动态传送点列表，列表中的元素为teleporter结构体
    }).


%% 场景格子（场景划分九宫格后的其中一格）
-record(scene_grid, {
           key = {0, 0},         % 场景格子的key: {所在场景的唯一id， 场景格子的索引} ---- 目前场景格子的索引不是一维的整数索引，而是二维的{Grid_X, Grid_Y}形式
           player_infos = [],    % 场景格子中的玩家信息列表：{PlayerId, SendPid}列表
           mon_ids = [],         % 场景格子中的怪物唯一id列表
           npc_ids = []          % 场景格子中的npc唯一id列表（这里npc是指巡逻npc）
    }).




-record(scene_ply, {
        id = 0,          % 玩家id
        scene_line = 0   % 玩家所属的场景分线
    }).

%% 场景中的玩家记录（存储于ETS_SCENE_PLAYERS中，用于方便获取同场景内的玩家数量和玩家列表）
-record(scene_players, {
           scene_id = 0,        % 场景唯一id
           player_count = 0,    % 场景中的玩家数量
           player_list = []     % 场景中的玩家列表（scene_ply结构体列表）
    }).



%% 传送配置数据
-record(teleport, {
        no = 0,                   % 传送编号
        target_scene_no = 0,      % 目标场景编号
        target_xy = {0, 0},       % 目标坐标
        lv_need = 0,              % 等级需求
        race_need = 0,            % 种族需求
        faction_need = 0,         % 门派需求
        bind_gamemoney_cost = 0,  % 消耗绑定游戏币
        bind_yuanbao_cost = 0,    % 消耗绑定元宝
        extra_conditions = []     % 额外的传送条件
    }).



%% 传送点
-record(teleporter, {
        teleport_no = 0,   % 对应的传送编号
        scene_id = 0,      % 所在的场景id
        x = 0,             % 所在的X坐标
        y = 0              % 所在的Y坐标
    }).




%% 无效的场景编号和id
-define(INVALID_SCENE_NO, 0).
-define(INVALID_SCENE_ID, 0).

%% 拷贝场景的起始id（注：副本场景属于拷贝场景的一种）
-define(COPY_SCENE_START_ID, 1000000).   % 定一个比较大的数，以避免和普通场景的id冲突!!!


%% 主城的场景编号
-define(MAIN_CITY_SCENE_NO, 1304).



-define(X_START, 0).           % X坐标的起始值
-define(Y_START, 0).           % Y坐标的起始值



%% 地图阻挡类型
-define(BLOCK_T_NONE, 0).      % 没有阻挡
-define(BLOCK_T_NORMAL, 1).    % 普通阻挡
-define(BLOCK_T_TRAP, 2).      % 暗雷区
-define(BLOCK_T_SAFE, 3).      % 安全区
-define(BLOCK_T_LEITAI, 4).    % 擂台区
-define(BLOCK_T_WATER, 5).     % 有水区域的阻挡




%% 场景类型
-define(SCENE_T_INVALID,    0).  % 无效类型
-define(SCENE_T_CITY,       1).  % 城市
-define(SCENE_T_WILD,       2).  % 野外
-define(SCENE_T_DUNGEON,    3).  % 副本
-define(SCENE_T_FACTION,    4).  % 师门
-define(SCENE_T_GUILD,      5).  % 帮派场景
-define(SCENE_T_MELEE,      6).  % 女妖乱斗场景
-define(SCENE_T_PRISON,     7).  % 监狱场景
-define(SCENE_T_NEWYEAR,    1).  % 新年宴会场景

-define(SCENE_PRISON_NO,    9001).  % 监狱场景9001

% 泡点地图编号
-define(SCENE_PAODIAN_NO,   9002).   % 泡点地图

%% 属于普通场景的场景类型列表
-define(NORMAL_SCENE_TYPE_LIST, [?SCENE_T_CITY, ?SCENE_T_WILD, ?SCENE_T_FACTION]).



%% 暗雷类型
-define(TRAP_T_NORMAL,       1).  % 普通暗雷
-define(TRAP_T_TASK,         2).  % 任务暗雷
-define(TRAP_T_ACTIVITY,     3).  % 活动暗雷





%% 单个场景内允许的最大玩家数
-define(MAX_ALLOWED_PLAYER_EACH_SCENE, 2000).















% %%  场景子类型
% -define(DUN_SCENE_T_GUILD,   1).    % 副本场景的子类型：帮派副本场景
% -define(DUN_SCENE_T_FACTION,   2).    % 副本场景的子类型：师门副本场景
% -define(DUN_SCENE_T_ACTIVITY,   3).    % 副本场景的子类型：活动副本场景
% % ...














-endif.  %% __SCENE_H__
