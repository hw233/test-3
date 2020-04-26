%%%------------------------------------------------
%%% File    : npc.hrl
%%% Author  : huangjf 
%%% Created : 2013.7.15
%%% Description: NPC相关的宏
%%%------------------------------------------------


%% 避免头文件多重包含
-ifndef(__NPC_H__).
-define(__NPC_H__, 0).




%% 动态npc的起始id（从一个较大的值开始，以避免和普通npc的id冲突）
-define(DYNAMIC_NPC_START_ID, 100000).


%% npc类型
-define(NPC_T_NORMAL, 1).           % 普通npc（即：静态的功能npc）
-define(NPC_T_DUNGEON, 2).          % 副本npc
-define(NPC_T_ACTIVITY, 3).         % 活动npc
-define(NPC_T_PATROL, 4).           % 巡逻npc
-define(NPC_T_COLLECT, 5).          % 采集npc
-define(NPC_T_DUMMY, 6).            % 酱油npc
-define(NPC_T_TELEPORTER, 7).       % 传送门
-define(NPC_T_CRUISE_ACTIVITY, 8).  % 巡游活动npc
-define(NPC_T_COUPLE_CRUISE, 9).    % 花车巡游活动npc



%% 默认刷出后持续存在的时间（单位：秒）
-define(NPC_DEFAULT_EXISTING_TIME, (3600 * 2)).



%% NPC模板（由策划配置）
-record(npc_tpl, {
        no = 0,              % npc编号（由策划制定和填写）
        name = <<"无名">>,   % 名字
        type = ?NPC_T_NORMAL,  % 类型，默认为普通
        race = 0,          % 
        faction = 0,
        sex = 0,
        func_list = [],      % 功能列表，形如：[{sell_goods, 1}, {teleport, [1,2,3]}, ...]
        existing_time = 0    % 刷出后持续存在的时间（单位：秒），仅用于动态刷出的npc
    }).



%% （内存中的）NPC对象
-record(npc, {
        id = 0,                % npc唯一id
        no = 0,                % npc编号（由策划制定和填写）
        type = ?NPC_T_NORMAL,  % 类型，默认为普通
        % res_id = 0,            % 资源id
        % name = <<"无名">>,     % 名字
        % func_list = [],        % 功能列表，形如：[{sell_goods, 1}, {teleport, [1,2,3]}, ...]
        scene_id = 0,          % 所在场景的唯一id
        x = 0,                 % x坐标
        y = 0,                 % y坐标
        existing_time = 0,     % 刷出后持续存在的时间（单位：秒），默认为0，表示无时间限制
        expire_time = 0,       % 过期时间（到了该时间点，会消失），默认为0，表示无时间限制
        bhv_state = 0,         % 当前的行为状态
        extra = []             % 额外信息  {Key, Value} Key 可以是:title_no,string_1,string_2等aoi需要显示的内容
    }).


%% NPC的功能（NPCF: NPC's Function）
-define(NPCF_SELL_GOODS,   sell_goods).         % 出售物品
-define(NPCF_TELEPORT,     teleport).           % 传送
-define(NPCF_STREN_EQUIP,  stren_equip).        % 强化装备
-define(NPCF_TEACH_SKILLS, teach_skills).       % 教授技能
-define(NPCF_DUNGEON,      dungeon).            % 副本
-define(NPCF_COLLECT,      collect).            % 采集
-define(NPCF_TRIGGER_MF,   trigger_mf).         % 触发打怪
-define(NPCF_EMPLOY_HIRER, employ_hirer).       % 雇佣天将
-define(NPCF_TOWER, tower).                     % 进入爬塔
-define(NPCF_HARDTOWER, hardtower).             % 进入爬塔
-define(NPCF_OFFLINE_ARENA, offline_arena).     % 离线竞技场
-define(NPCF_OA_FEAT_EXCHANGE, feat_exchange).  % 离线竞技场功勋兑换(OA: offline arena)
-define(NPCF_REWARD_CDKEY, reward_cdkey).       % 领取礼包输入激活码入口
-define(NPCF_GUILD_DISHES, guild_dishes).       % 帮派加菜入口
-define(NPCF_GOODS_COMPOSE, goods_compose).     % 物品合成入口
-define(NPCF_GUILD_DUNGEON, guild_dungeon).     % 帮派副本入口
-define(NPCF_LITERARY_EXCHANGE, literary_exchange). % 学分兑换
-define(NPCF_GUILD_CULTIVATE, guild_cultivate).     % 帮派点修入口
-define(NPCF_GUILD_DONATE, guild_donate).           % 帮派捐献入口
-define(NPCF_JOIN_CRUISE, join_cruise).             % 报名参加巡游活动
-define(NPCF_ARENA_BIWU, arena_biwu).               % 比武大会入口
-define(NPCF_ARENA_BIWU_3V3, arena_biwu_3v3).           % 比武大会入口
-define(NPCF_ARENA_3V3_PVP, arena_kuafu_3v3). % 跨服3v3
-define(NPCF_BOSS_ENTER_MOLONG, dragon_boss_enter).               % 世界boss魔龙入口 
-define(NPCF_BOSS_ENTER_YIJUN, commander_boss_enter).               % 世界boss异军入口
-define(NPCF_MONOPOLY, monopoly). % 大富翁
-define(NPCF_ENTER_MIJING, enter_mijing).           % 秘境
-define(NPCF_ENTER_HUANJING, enter_huanjing).       % 幻境
-define(NPCF_ENTER_EXCHANGE, exchange).       % 幻境





-define(NPCF_BOSS_RANK, boss_rank).                 % 世界boss排名入口
-define(NPCF_DISCARD_ROLE, discard_role).           % 删除角色
-define(NPCF_ENTER_SWORN, enter_sworn).             % 进入结拜
-define(NPCF_MODIFY_SWORN, modify_sworn).           % 修改结拜
-define(NPCF_REMOVE_SWORN, remove_sworn).           % 删除结拜
-define(NPCF_ENTER_SHOP, enter_shop).               % 进入商城 
-define(NPCF_ENTER_TRANSPORT, enter_transport).     % 进入运镖
-define(NPCF_ENTER_STORAGE, enter_storage).         % 进入仓库
-define(NPCF_GOODS_EXCHANGE, goods_exchange).       % npc物品兑换功能入口
-define(NPCF_MELEE_APPLY, melee_apply).             % 乱斗入口
-define(NPCF_MELEE_OUT, melee_out).                 % 乱斗出口（不上缴龙珠）
-define(NPCF_SHOW_MASSAGE, show_message).           % 说明展示
-define(NPCF_TVE_ENTRY, tve_entry).                 % 兵临城下入口
-define(NPCF_COUPLE_ENTRY, couple_entry).           % 结婚入口
-define(NPCF_JOIN_COUPLE_CRUISE, join_couple_cruise). % 婚车入口
-define(NPCF_CLOSE_WIN, close_win).                   % 关闭弹出的窗口
-define(NPCF_YEAR_DISHES, year_dishes).               % 年夜饭加菜入口
-define(NPCF_YEAR_ENTRY, year_entry).                 % 新年宴会入口
-define(NPCF_BLESS_ENTRY, bless_entry).               % 祝福界面入口
-define(NPCF_BLESS_GET, bless_get).                   % 领取祝福
-define(NPCF_GET_GOODS, get_goods).                   % 领取物品（领取新年红包）

-define(NPCF_OPEN_SLOTMACHINE, open_slotmachine).                   % 打开老虎机
-define(NPCF_GO_BACK_FACTION, go_back_faction).                   % 回到门派

-define(NPCF_JOIN_GUILD_BATTLE, join_guild_battle).                   % 回到门派
-define(NPCF_JOIN_GUILD_BATTLE1, join_guild_battle1).                 % 回到门派
-define(NPCF_JOIN_GUILD_BATTLE2, join_guild_battle2).                 % 回到门派
-define(NPCF_JOIN_GUILD_BATTLE3, join_guild_battle3).                 % 回到门派

-define(NPCF_OPEN_CHANGE_FACTION, open_change_faction).                 % 回到门派

-define(NPCF_OPEN_BOX,open_box).                          % 打开宝箱
-define(NPCF_CHANGE_PAODIAN_TYPE,change_paodian_type).   

-define(NPCF_MELEE_HAND_IN_DRAGONBALL, hand_in_dragonball). % 乱斗上缴龙珠

-define(NPCF_SINGLE_TVE, single_tve). % 单人兵临
-define(NPCF_ENTER_KUAFU, enter_kuafu). % 单人兵临


%% NPC功能的代号（NPCF: NPC's Function）
-define(NPCF_CODE_SELL_GOODS,   1).        % 出售物品
-define(NPCF_CODE_TELEPORT,     2).        % 传送
-define(NPCF_CODE_STREN_EQUIP,  3).        % 强化装备
-define(NPCF_CODE_TEACH_SKILLS, 4).        % 教授技能
-define(NPCF_CODE_DUNGEON,      5).        % 副本
% -define(NPCF_CODE_COLLECT,      6).        % 采集  -- 客户端现在自己去判断npc是否有采集功能
-define(NPCF_CODE_TRIGGER_MF,   6).        % 触发打怪
-define(NPCF_CODE_DUNGEON_TP,   7).        % 副本专用传送
-define(NPCF_CODE_EMPLOY_HIRER, 8).        % 雇佣天将
-define(NPCF_CODE_TOWER,        9).        % 进入爬塔
-define(NPCF_CODE_OFFLINE_ARENA, 10).      % 离线竞技场
-define(NPCF_CODE_OA_FEAT_EXCHANGE, 11).   % 离线竞技场功勋兑换 (OA: offline arena)
-define(NPCF_CODE_REWARD_CDKEY, 12).       % 领取礼包输入激活码入口
-define(NPCF_CODE_GUILD_DISHES, 13).       % 帮派加菜入口
-define(NPCF_CODE_GOODS_COMPOSE, 14).      % 物品合成入口
-define(NPCF_CODE_GUILD_DUNGEON, 15).      % 帮派副本入口   
-define(NPCF_CODE_LITERARY_EXCHANGE, 16).  % 学分兑换
-define(NPCF_CODE_GUILD_CULTIVATE, 17).    % 帮派点修入口
-define(NPCF_CODE_GUILD_DONATE, 18).       % 帮派捐献入口
-define(NPCF_CODE_JOIN_CRUISE, 19).        % 报名参加巡游活动
-define(NPCF_CODE_ARENA_BIWU, 20).         % 比武大会入口
-define(NPCF_CODE_BOSS_ENTER, 21).         % 世界boss魔龙入口 
-define(NPCF_CODE_BOSS_ENTER2, 57).       % 世界boss异军排名入口
-define(NPCF_CODE_BOSS_RANK, 22).          % 世界boss排名入口

-define(NPCF_CODE_DISCARD_ROLE, 23).       % 删除角色
-define(NPCF_CODE_ENTER_SWORN, 24).        % 进入结拜
-define(NPCF_CODE_MODIFY_SWORN, 25).       % 修改结拜
-define(NPCF_CODE_REMOVE_SWORN, 26).       % 删除结拜
-define(NPCF_CODE_ENTER_SHOP, 27).         % 进入商城 
-define(NPCF_CODE_ENTER_TRANSPORT, 28).    % 进入运镖
-define(NPCF_CODE_ENTER_STORAGE, 29).      % 进入仓库
-define(NPCF_CODE_GOODS_EXCHANGE, 30).     % npc物品兑换功能入口
-define(NPCF_CODE_MELEE_APPLY, 31).        % 女妖乱斗入口
-define(NPCF_CODE_MELEE_OUT, 32).          % 女妖乱斗出口（上缴龙珠）
-define(NPCF_CODE_SHOW_MASSAGE, 33).       % 说明展示
-define(NPCF_CODE_TVE_ENTRY, 34).          % 兵临城下入口
-define(NPCF_CODE_COUPLE_ENTRY, 35).       % 结婚入口
-define(NPCF_CODE_JOIN_COUPLE_CRUISE,36).
-define(NPCF_CODE_CLOSE_WIN,37).
-define(NPCF_CODE_YEAR_DISHES, 38).
-define(NPCF_CODE_YEAR_ENTRY, 39).
-define(NPCF_CODE_BLESS_ENTRY, 40).
-define(NPCF_CODE_BLESS_GET, 41).
-define(NPCF_CODE_GET_GOODS, 42).
-define(NPCF_CODE_HARDTOWER, 43).        % 进入噩梦爬塔
-define(NPCF_CODE_ARENA_BIWU_3V3, 44).  

-define(NPCF_CODE_OPEN_SLOTMACHINE, 45).                   % 打开老虎机
-define(NPCF_CODE_GO_BACK_FACTION, 46).                   % 回门派

-define(NPCF_CODE_JOIN_GUILD_BATTLE,  47).                   % 回门派
-define(NPCF_CODE_JOIN_GUILD_BATTLE1, 48).                   % 回门派
-define(NPCF_CODE_JOIN_GUILD_BATTLE2, 49).                   % 回门派
-define(NPCF_CODE_JOIN_GUILD_BATTLE3, 50).                   % 回门派

-define(NPCF_CODE_OPEN_CHANGE_FACTION, 51).                   % 打开专职

-define(NPCF_CODE_OPEN_BOX, 52).                   % 打开宝箱
-define(NPCF_CODE_CHANGE_PAODIAN_TYPE, 54).                   % 修改泡点类型
-define(NPCF_CODE_MELEE_HAND_IN_DRAGONBALL, 55).                   % 乱斗上缴龙珠
-define(NPCF_CODE_SINGLE_TVE, 56).                   % 单人兵临
-define(NPCF_CODE_ENTER_KUAFU, 58).                   % 进入跨服

-define(NPCF_CODE_ARENA_3V3_PVP, 59).

-define(NPC_MONOPOL_ENTER, 60).   % 大富翁
-define(NPC_ENTER_MIJING,  61).   % 秘境
-define(NPC_ENTER_HUANJING, 62).  % 幻境

-define(NPC_ENTER_EXCHANGE, 63).  % 兑换商店




-endif.  %% __NPC_H__
