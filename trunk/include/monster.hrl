%%%------------------------------------------------
%%% File    : monster.hrl
%%% Author  : huangjf 
%%% Created : 2012.7.31
%%% Description: 怪物相关的宏
%%%------------------------------------------------


%% 避免头文件多重包含
-ifndef(__MONSTER_H__).
-define(__MONSTER_H__, 0).


-include("bo.hrl").


%% 明雷怪对象的位置，目前是用于辅助实现客户端的自动寻路
-record(mon_pos, {
        key = {0, 0},           % 格式：{所属玩家的id，明雷怪编号}， 如果是公共怪（即不属于任何玩家），则所属玩家的id为宏INVALID_ID
        mon_no = 0,             % 明雷怪编号
        mon_id = 0,             % 明雷怪id
        scene_id = 0,           % 所在场景的id
        x = 0,                  % 所在位置的X坐标
        y = 0                   % 所在位置的Y坐标
        }).



%% 明雷怪模板（由策划配置）
-record(mon_tpl, {
        no = 0,           % 明雷怪编号（由策划制定和填写）
        name = <<"无名">>,

        type = 0,

        lv = 1,
        bmon_group_no = 0,
        bmon_group_no_list = [],

        can_concurrent_battle = 0, % 是否可以同时和多个玩家触发战斗（1：是，0：否）


        % scene_id = 0,           %%所在场景的唯一id（若为副本场景，则表示副本场景的唯一id）
        
        % res_id = 0,        %% 资源id

        % cur_bhv_state = 0,   % 当前的行为状态
        

        is_combative = false,

        is_visible_to_all = 1,  % 是否对所有玩家都可见（1：是，0： 否）


        can_be_killed_times = 0,         % 可以被杀死的次数

        
        conditions = [],  % 触发战斗的条件列表

        need_cleared_after_die = true,  % 彻底死亡后是否消失？
        existing_time = 0,          % 刷出后持续存在的时间（单位：秒），为0表示永久存在

        events_after_die = [],      % 彻底死亡后所触发的事件



        % is_auto_respawn = 1,  % 是否死亡后自动重新刷出（1：是，0：否）
        
        
        speed = 0,           %% 移动速度
        % att_speed = 0,       %% 攻击速度

        att_area = 0,  % 攻击范围
        trace_area = 0      % 追踪范围

        %%          hit = 0,         %% 命中
        %%          dodge = 0,       %% 躲避
        %%          crit = 0,        %% 暴击
        %%          ten = 0,         %% 坚韧
        
        
%%      start_trace = 0,     %% 开始追踪
        % x = 0,               %% 当前所在位置的x坐标
        % y = 0              %% 当前所在位置的y坐标
        
        % revive = true,    % 死亡后是否需要重新刷出

        

        % talk_1,          %% 怪物对白1
        % talk_2,          %% 怪物对白2

        %%aid = none,      %% 怪物活动进程
        %%bid = none,      %% 战斗进程

        %%battle_mon_list = [],%%战斗怪物列表
        %%troop_size,      %%阵法大小
        % bmon_group_no = 0,  %% 战斗怪群组Id  
        % exp,             %% 怪物经验
        % coin,            %% 怪物掉落铜钱
        % drop_goods,      %% 怪物可掉落物品[{Goodsid1, DropRate1}, {Goodsid2, DropRate2}, ...]
        %%pass_finish,     %% 完成
        %%fight_order_factor = 0,   %% 先手值（TODO: 如果有不为0的怪则需要在配置表中增加一列）
        % event = [],
        %%soul_power = 0,
        
        % team_trigger = false,           % 是否需要组队才能触发与该怪物的战斗
        % team_id = 0             % 所属队伍的id，如果不属于任何队伍，则为0
        
    }).






%% （内存中的）明雷怪对象
-record(mon, {
        id = 0,           % 明雷怪对象的唯一id
        no = 0,           % 明雷怪编号（由策划制定和填写）
        % name = <<"无名">>, % 名字

        type = 0,        %% 类型


        scene_id = 0,           %%所在场景的唯一id（若为副本场景，则表示副本场景的唯一id）
        
        % res_id = 0,        %% 资源id

        bhv_state = 0,   % 当前的行为状态


        is_combative = false,

        is_visible_to_all = 1,     % 是否对所有玩家都可见（1：是，0： 否）

        can_be_killed_times = 0,         % 可以被杀死的次数

        acc_be_killed_times = 0,           % 当前累计已被杀死的次数


        need_cleared_after_die = true,  % 彻底死亡后是否消失？
        existing_time = 0,          % 刷出后持续存在的时间（单位：秒），如果无时间限制，则固定为0
        expire_time = 0,            % 过期时间（到了该时间点，怪物会消失），如果无时间限制，则固定为0
        


        % is_auto_respawn = 1,  % 是否死亡后自动重新刷出（1：是，0：否）
		
        lv = 0,
        % speed = 0,           %% 移动速度
        % att_speed = 0,       %% 攻击速度
        %%          hit = 0,         %% 命中
        %%          dodge = 0,       %% 躲避
        %%          crit = 0,        %% 暴击
        %%          ten = 0,         %% 坚韧
        % att_area = 0,        %% 攻击范围
        % trace_area = 0,      %% 追踪范围
%% 		start_trace = 0,	 %% 开始追踪

        x = 0,               %% 当前所在位置的x坐标
        y = 0,               %% 当前所在位置的y坐标
		
        % revive = true,    % 死亡后是否需要重新刷出

        % x0,             %% 默认出生X
        % y0,             %% 默认出生y

        born_x = 0,             %% 出生点的X坐标
        born_y = 0,             %% 出生点的Y坐标


		% talk_1,			 %% 怪物对白1
		% talk_2,			 %% 怪物对白2

        %%aid = none,      %% 怪物活动进程
        %%bid = none,      %% 战斗进程

        

        %%battle_mon_list = [],%%战斗怪物列表
        %%troop_size,      %%阵法大小
        % bmon_group_no = 0,  %% 战斗怪群组Id  
        % bmon_group_no_list = [],
        % exp,             %% 怪物经验
        % coin,            %% 怪物掉落铜钱
        % drop_goods,      %% 怪物可掉落物品[{Goodsid1, DropRate1}, {Goodsid2, DropRate2}, ...]
        %%pass_finish,     %% 完成
        %%fight_order_factor = 0,	%% 先手值（TODO: 如果有不为0的怪则需要在配置表中增加一列）
		% event = [],
		%%soul_power = 0,


        % conditions = [],  % 触发战斗的条件列表
		
		% team_trigger = false,			% 是否需要组队才能触发与该怪物的战斗

        owner_id = 0,          % 所属玩家的id，如果不属于任何玩家，则为0
        team_id = 0            % 所属队伍的id，如果不属于任何队伍，则为0
		
    }).


%% 战斗怪
-record(battle_mon, {
        no = 0,
        name = <<"无名">>,

        faction = 0,
        
        % res_id = 0,        % 资源id
        % bust_id = 0,       % 胸像id
		
        type = 0,
        can_be_captured = 0,

        % skill_list = [],    % 技能id列表

        initiative_skill_list_by_lv = [], % 根据等级判断是否该有的主动技能
        initiative_skill_list = [],  % 主动技列表
        passi_skill_list_by_lv = [], % 根据等级判断是否该有的被动技能
        passi_skill_list = [],       % 被动技列表

        ai_list = [],       % AI编号列表
        talk_ai_list = [],  % 对话气泡AI编号列表

        action_res = [],    % 资源列表
        
        lv = 0,

        hp = 0,
        hp_lim = 0,
        mp = 0,
        mp_lim = 0,
        anger = 0,
        anger_lim = 0,

        act_speed = 0,      % 出手速度

        phy_att = 0,         %% 物理攻击
        mag_att = 0,         %% 法术攻击
        phy_def = 0,         %% 物理防御
        mag_def = 0,         %% 法术防御

        hit = 0,         %% 命中
        dodge = 0,       %% 躲避
        crit = 0,        %% 暴击
        ten = 0,         %% 坚韧（抗暴击）

        phy_crit = 0,                                
        phy_ten = 0,                              
        mag_crit = 0,                               
        mag_ten = 0,                               
        phy_crit_coef = 0,                  
        mag_crit_coef = 0,

        heal_value = 0,              % 治疗强度
        
        ret_dam_proba = 0.0,    % 反弹几率
        ret_dam_rate = 0.0,  % 反弹比率
        combo_att_proba = 0.0,   % 连击几率

        max_combo_att_times = 0,  % 单次连击次数上限
        max_pursue_att_times = 0,  % 单次追击次数上限
        has_ghost_prep_status = 0,   % 是否有鬼魂预备状态
        ghost_prep_round_count = 0,  % 鬼魂预备的回合数
        has_fallen_prep_status = 0,  % 是否有倒地预备状态
        has_invisible_status = 0,  % 是否有隐身状态

        dam_reduce_rate = 0.0,  % 伤害减免百分比

        phy_att_add_rate = 0.0,  % 物理攻击加成百分比
        mag_att_add_rate = 0.0,  % 法术攻击加成百分比
        heal_eff_add_rate = 0.0, % 治疗效果加成百分比

        seal_hit = 0,          % 封印命中
        seal_resis = 0,        % 封印抗性

        do_phy_dam_scaling = ?DEFAULT_DO_DAM_SCALING,   % 物理伤害放缩系数
        do_mag_dam_scaling = ?DEFAULT_DO_DAM_SCALING,   % 法术伤害放缩系数
        crit_coef = ?DEFAULT_CRIT_COEF,        % 暴击系数

        be_heal_eff_coef = ?DEFAULT_BE_HEAL_EFF_COEF,

        be_phy_dam_reduce_coef = ?DEFAULT_BE_DAM_REDUCE_COEF,
        be_mag_dam_reduce_coef = ?DEFAULT_BE_DAM_REDUCE_COEF,

        % do_phy_dam_reduce_coef = ?DEFAULT_DO_DAM_REDUCE_COEF,
        % do_mag_dam_reduce_coef = ?DEFAULT_DO_DAM_REDUCE_COEF,

        absorb_hp_coef = ?DEFAULT_ABSORB_HP_COEF,
        qugui_coef = ?DEFAULT_QUGUI_COEF,

        drop_exp_coef = 0.0,        % 人物掉落经验系数 与 主宠一样
        drop_par_exp_coef = 0.0,    % 副宠物掉落经验比例，相对于主宠
        % drop_proba = 0.0,  % 掉落概率
        drop_pkg_no = 0,    % 掉落包编号
        adapt_team_mb_count = 0, % 掉落包的队伍适配人数
        buff_effect = 0 ,        % 掉落是否受buff影响 1表示受影响 0表示不受影响
        five_elements=0,
        ref = 0                   % 引用属性的编号
}).





%% 战斗怪物组(battle monster group)
-record(bmon_group, {
        no = 0,                     % 战斗怪物组编号
        name = <<"无名">>,          % 战斗怪物组名字

        troop_no = 0,               % 阵法编号

        spawn_mon_type = 0,           % 刷怪方式，1：固定，2：随机。

        force_spawn_mon_count = 0,    % 强行刷怪的数量（如果按正常规则刷怪，则为0）
        
        attr_random_range = 0,         % 浮动范围
        attr_streng = 1,               % 强行放大或者缩小比率

        mon_pool_fixed = [],           % 固定怪物池（固定会刷出）：[{战斗怪编号, 战斗位置}, ...]

        mon_pool_normal = [],   % 普通怪物池：[战斗怪编号, ...]
        mon_pool_chief = [],    % 头领怪物池：[{战斗怪编号, 刷出概率}, ...]
        mon_pool_elite = [],    % 精英怪物池：[{战斗怪编号, 刷出概率}, ...]
        mon_pool_rare = [],    % 稀有怪物池：[{战斗怪编号, 刷出概率}, ...]

        lv_range_min = 0,
        lv_range_max = 150,

        % drop_proba = 0.0,
        % drop_pkg_no = 0,

        bt_plot_no = 0,        % 对应战斗剧情的编号

        is_hire_prohibited = 0, % 是否禁止雇佣的玩家出战（1：是，0：否）
        zf_no = 0,              % 可能有的阵法编号，服务端根据条件判断是否生效
        next_bmon_group_no = [] % 下一波战斗怪物组编号池，格式：[] | [战斗怪物组编号, ...]
    }).




%% 暗雷
-record(trap, {
        no = 0,             % 暗雷编号
        type = 0,           % 1：普通，2：任务，3：活动
        bmon_group_no = 0,  % 对应的战斗怪物组编号
        conditions = []     % 触发条件
    }).


% %% 无效的明雷怪id
% -define(INVALID_MON_ID, 0).



%% （战斗中的）战斗怪类型
-define(BMON_NORMAL, 1).         % 普通
-define(BMON_ELITE, 2).          % 精英
-define(BMON_CHIEF, 3).          % 头领
-define(BMON_NORMAL_BOSS, 4).    % 普通BOSS
-define(BMON_NVYAO, 5).          % 女妖
-define(BMON_NVYAO_HQ, 6).       % 高品质（high quality）女妖（紫色女妖）
-define(BMON_WORLD_BOSS, 7).     % 世界BOSS


%% 明雷怪类型（目前等同于战斗怪类型）
-define(MON_NORMAL, ?BMON_NORMAL).
-define(MON_ELITE, ?BMON_ELITE).
-define(MON_CHIEF, ?BMON_CHIEF).
-define(MON_BOSS, ?BMON_NORMAL_BOSS).
-define(MON_NVYAO, ?BMON_NVYAO).
-define(MON_NVYAO_HQ, ?BMON_NVYAO_HQ).
-define(MON_WORLD_BOSS, ?BMON_WORLD_BOSS).




% -define(BMON_BB, 5).          % 宝宝
% -define(BMON_VARIANT_BB, 6).          % 变异宝宝

% -define(BMON_WORLD_BOSS, 3).    % 世界boss（全服只有一个）
% -define(BMON_WORLD_MON, 4). % 世界boss的小弟



% %% 走动怪的类型
% %%（0被动，1主动, 2 boss， 3 世界boss, 4 世界boss的小弟， 5 机关怪）
% -define(MOVING_M_PASSIVE, 0).
% -define(MOVING_M_ACTIVE, 1).
% -define(MOVING_M_BOSS, 2).
% -define(MOVING_M_WORLD_BOSS, 3).
% -define(MOVING_M_WORLD_MON, 4).
% -define(MOVING_M_MECHANISM, 5).








% 通知客户端时，用9999表示可以无限被杀死
-define(INFINITE_CAN_BE_KILLED_TIMES, 9999).











-endif.  %% __MONSTER_H__
