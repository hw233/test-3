%%%------------------------------------
%%% @author liufang <529132738@qq.com>
%%% @copyright UCweb 2015.01.07
%%% @doc 年夜宴会头文件
%%% @end
%%%------------------------------------

-ifndef(__NEWYEAR_BANQUET_H__).
-define(__NEWYEAR_BANQUET_H__, 0). 

-define(BANQUET_STATUS_OPEN, 1).   % 宴会开始
-define(BANQUET_STATUS_CLOSE, 0).   % 宴会结束

-define(DISH_1, 1).    % 粗茶淡饭
-define(DISH_2, 2).    % 大鱼大肉
-define(DISH_3, 3).    % 鲍参翅肚
-define(DISH_LIST, [?DISH_1, ?DISH_2, ?DISH_3]).

-define(BANQUET_LV1, 1).
-define(BANQUET_LV2, 2).
-define(BANQUET_LV3, 3).
-define(BANQUET_LV4, 4).
-define(BANQUET_LV5, 5).
-define(BANQUET_LV6, 6).

% 年夜宴会状态信息
-record(newyear_banquet_state, {
        status = 0                          % 年夜宴会状态（0-宴会结束 1-宴会开始）
        ,banquet_lv = 1                     % 年夜宴会档次
        ,banquet_exp = 0                    % 年夜宴会经验
        ,refresh_time = 0                   % 年夜宴会刷新时间
        ,add_limit_times = dict:new()       % 加菜总次数 %k=dish_no, v=dish_times
        ,add_dish_players = dict:new()      % 加菜玩家 % k=role_id v={player_name, dish1_num, dish2_num, dish_3_num}
        ,add_dish_logs = []                 % 加菜记录 % {player_name, dish_no}
    }).

% 年夜宴会加菜信息
-record(newyear_dishes, {
        type = 0                %加菜类型 （1粗菜淡饭 2大鱼大肉 3鲍参翅肚）
        ,dish_limit = 0         %加菜次数限制
        ,exp_add = 0            %加菜增加整个宴会经验
        ,need_gamemoney = 0     %加菜需要消耗的绑银
        ,need_yuanbao = 0       %加菜需要消耗的元宝
        ,special_goods = []     %加菜获得珍贵物品
        ,normal_goods = []      %加菜获得普通物品
        ,name = <<"">>          %菜名
    }).

% 年夜宴会档次信息
-record(newyear_banquet_lv, {
    banquet_lv = 0                  %宴会档次
    ,banquet_exp = 0                %宴会档次需要经验
    ,buff_no = 0
    ,banquet_exp_limit = 0          %宴会系统增加经验临界值 0表示该档次系统不加 {临界值，菜式，数量}
    ,banquet_player_exp = 0         %宴会档次玩家所获得的经验值
    ,banquet_player_gamemoney = 0   %宴会档次玩家所获得的绑银
    ,banquet_player_item = []       %宴会档次玩家获得的物品 {数量，物品id}
    ,banquet_even = []              %宴会发放物品权限
    ,npc = null
    }).

%% 年夜宴会场景状态信息
-define(NEWYEAR_BANQUET_SCENE_KEY, newyear_banquet_scene_status). 
-record(ets_newyear_banquet_scene_status, {
        id = newyear_banquet_scene_status   % 唯一键（该ets表只有一条记录）
        ,open_status = 0    % 开启状态（0未开启 1开启）
        ,scene_id = 0       % 场景Id
        ,scene_no = 0       % 场景编号
        ,dishes_npc = []    % 年夜宴会刷出来的npc id列表，清除时用
    }).


-record(ets_time_limit_rank, {
        id = time_limit_rank  % 唯一键（该ets表只有一条记录）
        ,ranklist =[]       %排名列表
        ,dirty = 1          % 脏数据（0正常数据 1脏读数据）
    }).


-record(lottery_data, {
    no = 0,
    reward = [],
    notice = 0
}).

-record(player_lottery_info, {
    player_id,          %% 玩家id
    token,              %% 玩家点券
    free_time,          %% 免费抽奖时间戳
    time,               %% 时间戳
    reward              %% 领取奖励记录
}).

-endif. % __NEWYEAR_BANQUET_H__
