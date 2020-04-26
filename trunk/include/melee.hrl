%%%------------------------------------
%%% @author 严利宏 <542430172@qq.com>
%%% @copyright UCweb 2014.11.5
%%% @doc 女妖乱斗 头文件.
%%% @end
%%%------------------------------------

-ifndef(__MELEE_H__).
-define(__MELEE_H__, 0). 

%% 个人最大龙珠数
-define(MAX_BALL_NUM, 7).

-define(POPULAR_PAODIAN_ADD, 100). 

%% 女妖乱斗活动状态信息
-define(MS_KEY, melee_status). % MS = melee_status
-record(ets_melee_status, {
        id = melee_status   % 唯一键（该ets表只有一条记录）
        ,open_status = 0    % 开启状态（0未开启 1开启）
        ,act_data = none    % 活动数据
        ,scene_list = []    % 活动场景列表 [#melee_scene{}, ...]
    }).

%% 女妖乱斗活动场景信息
-record(melee_scene, {
        min_lv = 0          % 最低等级
        ,max_lv = 0         % 最高等级
        ,scene_id = 0       % 场景Id
        ,scene_no = 0       % 场景编号
        ,role_num = 0       % 玩家数量
    }).


%% 玩家乱斗信息
-record(ets_melee_ply_info, {
        id = 0              % 玩家Id
        ,status = 0         % 玩家活动状态 (0未报名 1已报名 2已提交完成)
        ,ball_num = 0       % 龙珠数量
        ,scene_no = 0       % 分配的场景编号
        ,create_time = 0     % 创建时间
    }).
-define(MELEE_PLY_INFO_STATUS_NO_APPLY, 0). % 未报名
-define(MELEE_PLY_INFO_STATUS_APPLY, 1).    % 已报名
-define(MELEE_PLY_INFO_STATUS_FINISH, 2).   % 已提交完成

% 提交龙珠类型
-define(SUBMIT_BALL_T_NORMAL, 1).   % 自己正常提交
-define(SUBMIT_BALL_T_SYS, 2).      % 系统提交

-endif. % __MELEE_H__
