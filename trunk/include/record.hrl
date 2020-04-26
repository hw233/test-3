%%%------------------------------------------------
%%% File    : record.hrl
%%% Author  :
%%% Created : 2011-04-15
%%% Modified: 2013.6 -- huangjf
%%% Description: 通用的record（注意：对于非通用的record，不要定义在此文件，而是要分类定义在对应的头文件）
%%%------------------------------------------------


%% 避免头文件多重包含
-ifndef(__RECORD_H__).
-define(__RECORD_H__, 0).

-include("damijing.hrl").

%% 线路记录
-record(server, {
        id,
        ip,
        port,
        node,
        num = 0
    }).


%% @desc: 精确到秒
-record(unixtime, {
                   year = 1970,
                   month = 1,
                   week = 1,   % 今年的第几周(默认1970年1月1日第一周，这里约定：周一为一周的第一天)
                   day = 1,

                   day_of_year = 1,   % 今天的第几天
                   day_of_month = 1,   % 本月的第几天
                   day_of_week = 4,   % 本周的第几天

                   last_day_of_year = 365,   % 今年的最后一天，即今天的总天数
                   last_day_of_month = 31,   % 本月的最后一天，即本月的总天数

                   hour = 0,
                   minute = 0,
                   seconds = 0,

                   seconds_since_midnight = 0,   % 今天0点到当前时间的秒数
                   seconds_since_week_midnight = 0   % 本周开始到当前时间的秒数
                   }).





%% 坐标
-record(coord, {
            x = 0,
            y = 0
            }).


%% 天赋属性（天赋属性即策划文档中所指的1级属性）
-record(talents, {
        str = 0,    % 力量（strength）
        con = 0,    % 体质（constitution）
        sta = 0,    % 耐力（stamina）
        spi = 0,    % 灵力（spirit）
        agi = 0     % 敏捷（agility）
   }).


%% 属性
%% !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
%% ！！！！特别注意：因数据库offline_bo表的attrs字段是直接存储本结构体，所以游戏正式上线后，千万不要修改本结构体内各字段的顺序！！！！！ -- huangjf
%% !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-record(attrs, {
            hp = 0,                 % 气血
            hp_lim = 0,             % 气血上限
            hp_lim_rate = 0,        % 气血上限加成比例
            mp = 0,                 % 魔法
            mp_lim = 0,             % 魔法上限
            mp_lim_rate = 0,        % 魔法上限加成比例

            phy_att = 0,            % 物理攻击
            phy_att_rate = 0,
            mag_att = 0,            % 法术攻击
            mag_att_rate = 0,
            phy_def = 0,            % 物理防御
            phy_def_rate = 0,
            mag_def = 0,            % 法术防御
            mag_def_rate = 0,

            hit = 0,                % 命中
            hit_rate = 0,
            dodge = 0,              % 闪避
            dodge_rate = 0,
            crit = 0,               % 暴击
            crit_rate = 0,
            ten = 0,                % 坚韧（抗暴击）
            ten_rate = 0,

            talent_str = 0,         % 天赋：力量（strength）
            talent_con = 0,         % 天赋：体质（constitution）
            talent_sta = 0,         % 天赋：耐力（stamina）
            talent_spi = 0,         % 天赋：灵力（spirit）
            talent_agi = 0,         % 天赋：敏捷（agility）

            anger = 0,              % 怒气
            anger_lim = 0,          % 怒气上限

            act_speed = 0,          % 出手速度
            act_speed_rate = 0,

            luck = 0,               % 幸运


            frozen_hit = 0,              % 冰封命中
            frozen_hit_lim = 0,          % 冰封命中上限

            trance_hit = 0,              % 昏睡命中
            trance_hit_lim = 0,          % 昏睡命中上限

            chaos_hit = 0,               % 混乱命中
            chaos_hit_lim = 0,           % 混乱命中上限

            frozen_resis = 0,            % 冰封抗性
            frozen_resis_lim = 0,        % 冰封抗性上限

            trance_resis = 0,            % 昏睡抗性
            trance_resis_lim = 0,        % 昏睡抗性上限

            chaos_resis = 0,             % 混乱抗性
            chaos_resis_lim = 0,         % 混乱抗性上限

            seal_hit = 0,                % 封印命中（同时影响冰封命中、昏睡命中和混乱命中）
            seal_resis = 0,              % 封印抗性（同时影响冰封抗性、昏睡抗性和混乱抗性）

            phy_combo_att_proba = 0,     % 物理连击概率（是一个放大1000倍的整数）
            mag_combo_att_proba = 0,     % 法术连击概率（是一个放大1000倍的整数）
            strikeback_proba = 0,        % 反击概率（是一个放大1000倍的整数）
            pursue_att_proba = 0,        % 追击概率（是一个放大1000倍的整数）

            do_phy_dam_scaling = 0,      % 物理伤害放缩系数
            do_mag_dam_scaling = 0,      % 法术伤害放缩系数

            crit_coef = 0,               % 暴击系数

            ret_dam_proba = 0,           % 反震（即反弹）概率（是一个放大1000倍的整数）
            ret_dam_coef = 0,            % 反震（即反弹）系数

            be_heal_eff_coef = 0,        % 被治疗效果系数
            heal_eff_coef  = 0,          % 治疗别人的效果系数
            be_phy_dam_reduce_coef = 0,  % 物理伤害减免系数
            be_mag_dam_reduce_coef = 0,  % 法术伤害减免系数

            be_phy_dam_shrink = 0,       % （受）物理伤害缩小值（整数）
            be_mag_dam_shrink = 0,       % （受）法术伤害缩小值（整数）

            pursue_att_dam_coef = 0,     % 追击伤害系数
            reduce_pursue_att_dam_coef = 0, % 减免追击伤害系数
            absorb_hp_coef = 0,           % 吸血系数

            qugui_coef = 0,               % 驱鬼系数

            % 以下是预留字段，用于应付游戏正式上线后的功能需求的拓展  -- huangjf
            seal_hit_rate = 0,            % 封印命中（同时影响冰封命中、昏睡命中和混乱命中）
            seal_resis_rate = 0,          % 封印抗性（同时影响冰封抗性、昏睡抗性和混乱抗性）
            reserved_field3 = 0,

            phy_crit = 0,                                
            phy_ten = 0,                              
            mag_crit = 0,                               
            mag_ten = 0,                               
            phy_crit_coef = 0,                  
            mag_crit_coef = 0,

            heal_value = 0             % 治疗强度

            % 新增属性
            ,be_chaos_att_team_paoba = 0        % 被混乱攻击自己队友的几率
            ,be_chaos_att_team_phy_dam = 0      % 被混乱攻击自己队友的伤害加成

            ,seal_hit_to_partner = 0            % 封印门客加成系数
            ,seal_hit_to_mon = 0                % 封印怪物加成系数
            ,phy_dam_to_partner = 0             % 物理伤害门客加成系数
            ,phy_dam_to_mon = 0                 % 物理伤害怪物加成系数
            ,mag_dam_to_partner = 0             % 法术伤害门客加成系数
            ,mag_dam_to_mon = 0                 % 法术伤害怪物加成系数

            ,be_chaos_round_repair = 0          % 被混乱回合数修正              减少被混乱的持续回合
            ,chaos_round_repair = 0             % 混乱回合数修正                增加混乱目标的持续回合
            ,be_froze_round_repair = 0          % 被冰冻回合数修正
            ,froze_round_repair = 0             % 冰冻回合数修正         

            ,neglect_phy_def = 0                % 忽视目标物理防御
            ,neglect_mag_def = 0                % 忽视目标法术防御
            ,neglect_seal_resis = 0             % 忽视抗封印数值
             ,neglect_ret_dam = 0               % 忽视反震

            ,phy_dam_to_speed_1 = 0             % 物理伤害攻击比自己快的伤害加成
            ,phy_dam_to_speed_2 = 0             % 物理伤害攻击比自己慢的伤害加成
            ,mag_dam_to_speed_1 = 0             % 法术伤害攻击比自己快的伤害加成
            ,mag_dam_to_speed_2 = 0             % 法术伤害攻击比自己慢的伤害加成
            ,seal_hit_to_speed = 0              % 封印比自己快的目标加成
            ,revive_heal_coef = 0               % 复活时治疗加成系数
            ,anger_eff_coef = 0                 % 怒气恢复加成系数
            }).
% -record(ext_attrs, {

%     }).


%% 玩家简要信息（只存少量的轻量数据，不存其他）
-record(plyr_brief, {
        id = 0,             % 玩家id
        pid = null,         % 玩家进程pid
        socket = null,      % 与客户端的socket连接
        sendpid = null,     % 专用于发送消息给客户端的进程pid
        is_online = false,   % 当前是否在线
        force_mark_not_in_tmplogout_cache = false,  % 是否强行标记为不在临时退出缓存中（默认为false）
		cross_state = null  % 玩家跨服状态，断线的时候更新下这个字段，在重连的时候做首要判断是否有必要回到跨服节点
    }).



-record(dun_info, {
     dun_no = 0             % dungeon NO
    ,dun_id = 0             % dungeon id in dungoen_manage
    ,dun_pid = 0            % dungeon pid
    ,builder = 0            % dungeon builder
    ,state = null           % null / in / out / dead
    }).

-define(DEF_DUN_INFO, #dun_info{dun_no = 0,dun_id = 0,dun_pid = 0,builder = 0,state = null}).
% -define(DEAD_DUN_INFO, #dun_info{dun_no = 0,dun_pid = 0,builder = 0,state = dead}).


%% 会影响外形的装备
-record(showing_equip, {
        suit_no = 0,        % 套装（目前是保存穿在身上的最低强化等级）
        weapon = 0,         % 武器
        headwear = 0,       % 头饰
        clothes = 0,        % 服饰  若是女妖则叫画皮
        backwear = 0,       % 背饰
        magic_key = 0
    }).

%% VIP
-record(vip, {
             lv          = 0,
             exp         = 0,
             active_time = 0,
             expire_time = 0
             }).

%% 玩家结构体
-record(player_status, {
        id = 0,                 % 玩家id(全局唯一)
        local_id = 0,           % 玩家在服务器内的流水ID(服务器内唯一)，仅用于客户端做显示
        server_id = 0,          % 玩家所在服务器的id

        accname = "",           % (平台)账户名（list类型）
        from_server_id = 0,     % 表示角色是在哪个服创建的

        create_time = 0,        % 角色创建时间
        last_logout_time = 0,   % 上次退出游戏的时间（unix时间戳）
        login_time = 0,         % 此次的登录时间（unix时间戳）
		login_ip = "",          % 此次登录的所在IP

        accum_online_time = 0,  % 玩家累计在线时长

        socket = null,          % 和客户端连接的socket
        pid = null,             % 玩家进程pid

        priv_lv = 0,            % 权限级别（priv：privilege）， 0：普通玩家， 1：指导员，2：GM

        cur_bhv_state = 0,      % 当前的行为状态（空闲，战斗中，死亡等，详见common.hrl的宏）

        nickname = <<"无名">>,  % 名字（注意：是binary类型，而不是list）
        race = 0,               % 种族（人族|魔族|仙族|妖族）
        faction = 0,            % 门派

        sex = 0,                % 性别（1：男，2：女）
        lv = 1,                 % 等级
        exp = 0,                % 当前的经验值

        yuanbao = 0,            % 元宝，即：金子
        yuanbao_acc = 0,        % 累计现金充值的元宝数
        bind_yuanbao = 0,       % 绑定的元宝，即：绑金
        gamemoney = 0,          % feat游戏币(game money)，即：银子
        bind_gamemoney = 0,     % 绑定的游戏币(binding game money)，即：绑银

		integral = 0,			% 积分
        copper = 0,             % 专用游戏货币
        chivalrous = 0,         % 侠义值
        vitality = 0,           % 活力值

        guild_contri = 0,       % 帮派贡献度
        guild_feat = 0,         % 帮派战功

        jingwen = 0,            % 经文
        dan = 0,                % 段位

        mijing = 0,             % 秘境点数
        huanjing = 0,           % 幻境点数

        popular = 0,            % 人气值
        chip = 0,               % 筹码
        feat = 0,               % 功勋值（货币）
        literary = 0,           % 学分
        literary_clear_time = 0,% 学分清零时间戳

        dungeon_id = 0,         % 所在副本的唯一id

        is_auto_battle = false,  % 是否自动战斗

        free_talent_points = 0,  % 自由（未分配的）天赋属性点数

        base_attrs = #attrs{},   % 玩家的基础属性
        % equip_add_attrs = #attrs{}, % 装备的加成属性（为了避免此record过大，现在已改为存在进程字典中）
        % xinfa_add_attrs = #attrs{}, % 心法的加成属性（为了避免此record过大，现在已改为存在进程字典中）
        total_attrs = #attrs{},  % 玩家的总属性

        move_speed = 0,          % 移动速度

        sendpid = null,          % 专用于发送消息给客户端的进程pid

		cur_battle_id = 0,		 % 当前所在战斗的id（不在战斗中则为0）

        guild_id = 0,            % 所属帮派的ID（没有加入帮派则固定为0）
        guild_attrs = [],        % 帮派技能属性列表：[{技能名,点修等级},...]
        cultivate_attrs = [],    % 帮派点修属性列表：[{技能名,点修等级},...]

        jingmai_infos  = [],     % 经脉属性：[{经脉类型,经脉等级},...]
        jingmai_point  = 0,      % 经脉点数

        team_id = 0,             % 所在队伍的id，若没有队伍，则固定为0
        is_leader = false,       % 是否队长，true:是，false:否
        team_target_type = 0,    % 玩家组队目标类型
        team_condition1 = 0,     % 玩家组队目的之条件1
        team_condition2 = 0,     % 玩家组队目标之条件2

        team_lv_range = {0,100},  % 玩家组队等级范围

        %% newbie_guide_step = 0,		% 新手引导的当前步骤

        partner_id_list = [],      % 宠物id列表（实际的宠物数据统一存到一个ets）
        partner_capacity = 0,      % 玩家当前可以携带的宠物数
        main_partner_id = 0,       % 当前主宠物的id
        follow_partner_id = 0,     % 当前跟随的女妖id
        fight_par_capacity = 0,    % 玩家当前可出战的宠物数量

        phy_power = 0,             % 体力
        % phy_power_lim = 0,         % 体力上限

        battle_power = 0,                   % 战斗力

        dun_info = #dun_info{},             % 副本信息 {{NO, Type}, Pid, Builder, null/out/in}
        prev_pos = {0, {0, 0}},             %进入副本前位置{场景ID,{X坐标, Y坐标}}


        % recharge_bit = 0,            % 充值状态位串(二进制位所在位置从右侧开始顺序为档次号,位值为该档次状态0:未首充 1:首充)
        recharge_state = [],                % 充值各档次状态[{档次, 首充时间戳, 最后一次返利时间戳}]

        month_card_state = [],              % 月卡状态[{月卡编号, 剩余发放天数, 最后一次返利日期数}]

        recharge_accum = {0, 0, 0},         % 充值累积状态 {累积值, 最近一次叠加的时间戳, 活动ID} 如果没有获得，也会记录这个时间戳，表示最近充值时间
        consume_state = [],                 % 消费状态 [{钱类型, {累积值, 最近一次叠加的时间戳}, 活动标志}, ..]
        admin_acitvity_state = [],          % 后台活动状态 [{活动类型, 累计值, 最近一次叠加的时间戳, 活动标志} | _]

        first_recharge_reward_state = 0,    % 首充礼包状态0->不可领取 1->可领取 2->已领取
        one_recharge_reward = [],           % 上次领取单笔充值奖励信息[{充值钱的数量, 时间戳}]
        vip = #vip{},                       % VIP相关信息
        off_state = [],                     % 离线挂机时的状态, 格式为proplists
        last_daily_reset_time = 0,          % 上次执行日重置的时间点（unix时间戳）
        last_weekly_reset_time = 0,         % 上次执行周重置的时间点（unix时间戳）
        showing_equips = #showing_equip{},  % 影响玩家场景展示的装备信息

        store_hp = 0,                       % 玩家血库
        store_mp = 0,                       % 玩家魔法库

        store_par_hp = 0,                   % 玩家宠物专用血库
        store_par_mp = 0,                   % 玩家宠物专用魔法库

        exp_slot = {0, 0},                  % {已领取世界经验的等级, 储备槽经验}

        update_mood_count = 0,              % 当天更新宠物心情次数,
        last_update_mood_time = 0,          % 上次更新宠物心情时间
        suit_no = 0                         % 套装编号，目前保存符合套装要求的最低强化等级，不符合则此字段为0

        ,xs_task_issue_num = 0              % 悬赏任务发布次数
        ,xs_task_left_issue_num = 0         % 悬赏任务剩余发布次数
        ,xs_task_receive_num = 0            % 悬赏任务领取次数
        ,zf_state = []                      % 玩家阵法
        ,contri = 0                         % 玩家成就功绩值
        ,recharge_accum_day = {0, 0, 0}     % 每日充值累积状态 {累积值, 最近一次叠加的时间戳, 活动ID}
        ,mount = 0                          % 玩家骑乘坐骑id
        ,mount_id_list = []                 % 坐骑id列表
        ,last_transform_time = 0            % 最后转职日期
		,day_transform_times = 0			% 当天已转换门派次数

        ,kill_num = 0                       % 杀人数量
        ,be_kill_num = 0                    % 被杀数

        ,enter_guild_time = 0               % 加入帮派时间
        ,leave_guild_time = 0               % 离开帮派时间
        ,pvp_flee = 0
        ,soaring = 0                        % 飞升次数
        ,transfiguration_no = 0             % 变身编号 
		,first_recharge_reward = []			% 首冲礼包3天已领取数据
		,login_reward_day = 0
		,login_reward_time = 0
        ,peak_lv = 0
        ,reincarnation = 0
        ,unlimited_resources =[]            % 无限资源，hava_recharge代表已首充，其他的代表是否已无限
		,faction_skills = []			    % 门派技能列表
        ,tmp_skill = []                     % 临时技能
    }).



%% 玩家的杂项信息 包括 购买信息：如某些物品的购买数量，某物品已经使用个数等
-record(player_misc, {
        player_id = 0,
        is_dirty = false,

        buy_goods_from_npc = [],     %%  [] （表示没有物品） | [{GoodsNo, Count, LastBuyTime} ...]
        buy_goods_from_shop = [],    %%  [] （表示没有物品） | [{GoodsNo, Count, LastBuyTime} ...]
        buy_goods_from_op_shop = [], %%  [] （表示没有物品） | [{GoodsNo, Count, LastBuyTime} ...]
        use_goods = [],      %%  [] （表示没有物品） | [{GoodsNo, Count, LastUseTime} ...]
        grow_fund = [],           %%  成长基金，格式如：[{基金编号,购买基金时间戳,[{领取等级，领取时间}]},...]

        guild_dungeon_id = 0,       %% 上次参加帮派副本所在帮派id    （以下两字段用于控制一周只可以参加一次帮派副本，避免更换帮派参加多次）
        guild_dungeon_time = 0,     %% 上次参加帮派副本时间

        guild_war_id = 0,           %% 上次参加帮派争霸赛所在帮派id  （以下两字段用于控制玩家参加一届帮派争霸赛失败，不能更换帮派继续参加本届比赛）
        guild_war_turn = 0,         %% 上次参加帮派争霸赛届数
        lv_train = [1],               %% 练功房开启等级
        reset_time,                 %% 时间戳
        free_stren_cnt = 0,         %% 今天剩余免费强化装备次数
        lilian = 0 ,                %% 历练领取记录
        monopoly = [2,5],           %% 大富翁每日次数
        monopoly_reset_time = 0,    %% 上一次重置时间
        mijing = 3,                 %% 每日秘境次数
        mijing_record = [],         %% 秘境进度记录
        huanjing = 3,               %% 每日幻境次数
        huanjing_record = [],        %% 幻境进度记录
        unlock = [] ,                %% 幻境解锁关卡
        mystery_reset_time = 0,     %% 上一次重置时间
        fabao_special = [],         %% 法宝特殊外观
        fabao_displayer = 0,
        fabao_degree = 0,
        recharge_unixtime = {0,0} ,          %% 上次充值的时间戳
        strengthen_info   = [],  %%玩家强化信息 [{1, Level, [宝石Id1,宝石Id2,宝石Id3···]},···] [{部位NO,强化LV,宝石镶嵌}]
		create_role_reward = 0,		%% 创号奖励领取状态
		recharge_accumulated = [],	%% 已领取的常驻累充奖励
  		dungeon_reward_time = [],       %%副本有效领奖次数
		rank_data_current = [],		%% 排行榜当前数据
        liangong_bag = []               %% 内功临时背包
    }).


%% 公式系数
-record(formula, {
        name = player_cal_battle_power,
        hp_lim = 0.177778,
        mp_lim = 0.320000,
        phy_att = 1.066667,
        mag_att = 1.367521,
        phy_def = 0.740741,
        mag_def = 1.333333,
        talent_str = 0,
        talent_con = 0,
        talent_sta = 0,
        talent_spi = 0,
        talent_agi = 0,
        act_speed = 1.111111,
        seal_hit = 5,
        seal_resis = 5,
        do_phy_dam_scaling = 11111,
        do_mag_dam_scaling = 11111,
        be_heal_eff_coef = 6000,
        be_phy_dam_reduce_coef = 11111,
        be_mag_dam_reduce_coef = 11111,
        be_phy_dam_shrink = 6,
        be_mag_dam_shrink = 6,
        phy_crit = 5,
        phy_ten = 5,
        mag_crit = 5,
        mag_ten = 5,
        phy_crit_coef = 5,
        mag_crit_coef = 5,
        heal_value = 6.666660,
        be_chaos_att_team_paoba = 0,
        be_chaos_att_team_phy_dam = 0,
        seal_hit_to_partner = 0.010000,
        seal_hit_to_mon = 0.010000,
        phy_dam_to_partner = 0.010000,
        phy_dam_to_mon = 0.010000,
        mag_dam_to_partner = 0.010000,
        mag_dam_to_mon = 0.010000,
        be_chaos_round_repair = 0.010000,
        chaos_round_repair = 0.010000,
        be_froze_round_repair = 0.010000,
        froze_round_repair = 0.010000,
        neglect_phy_def = 0.010000,
        neglect_mag_def = 0.010000,
        neglect_seal_resis = 0.010000,
        phy_dam_to_speed_1 = 0.010000,
        phy_dam_to_speed_2 = 0.010000,
        mag_dam_to_speed_1 = 0.010000,
        mag_dam_to_speed_2 = 0.010000,
        seal_hit_to_speed = 0.010000,
  ret_dam_proba = 0,
  ret_dam_coef = 0,
  phy_combo_att_proba = 0,
  mag_combo_att_proba = 0,
  absorb_hp_coef = 0,
  strikeback_proba = 0,
  neglect_ret_dam = 0,
  pursue_att_proba = 0
    }).

%% 种族基本信息
-record(race, {
            no = 0,
            % race_name = 0,
            sex = 0,
            speed = 0,
            half_portrait = 0,
            full_portrait = 0,
            action_res = 0,
            head_anim = 0,
            body_anim = 0,
            back_anim = 0,
            weapon_anim = 0,
            attack_time = 0,
            inborn_goods = [],
            inborn_money = []
    }).



%% 全局系统变量
-record(global_sys_var, {
    sys = 0
    ,var = []
    }).



%% 全局系统变量
-record(paodian_config, {
    id = 0
    ,price_type = 0
    ,price = 0
    ,exp = 0
    }).


-record(paodian_rob_rate_config, {
		id = 0,
		min = 0,
		max = 0,
		rob_rate = 1
	}).
	
-record(dan, {
    min = 0,
    max = 0,
    name = ''
}).

-record(cash_coupon_use_condition, {
  no,
  type,
  value,
  condition
}).

-record(sanjieyishi_cost, {
    no,
    cost,
    lv_range
}).



-endif.  %% __RECORD_H__
