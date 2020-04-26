%% Author: huangjf
%% Created: 2014.4.18
%% Description: 测试ets读写时所涉及的数据拷贝的效率
-module(tst_ets_data_copy).

-export([
		pre_test/0,
		test/1,
		test_get/1,
		test_set/1
	]).




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

            be_phy_dam_reduce_coef = 0,  % 物理伤害减免系数
            be_mag_dam_reduce_coef = 0,  % 法术伤害减免系数

            be_phy_dam_shrink = 0,       % （受）物理伤害缩小值（整数）
            be_mag_dam_shrink = 0,       % （受）法术伤害缩小值（整数）

            pursue_att_dam_coef = 0,     % 追击伤害系数

            absorb_hp_coef = 0,           % 吸血系数

            qugui_coef = 0,               % 驱鬼系数

            % 以下是预留字段，用于应付游戏正式上线后的功能需求的拓展  -- huangjf
            reserved_field1 = 0,
            reserved_field2 = 0,
            reserved_field3 = 0
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
        backwear = 0        % 背饰
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

        local_id = 0,           % 玩家显示的ID(全服唯一)

        accname = "",           % (平台)账户名（list类型）

        create_time = 0,        % 角色创建时间
        last_logout_time = 0,   % 上次退出游戏的时间（unix时间戳）
        login_time = 0,         % 此次的登录时间（unix时间戳）
		login_ip = "",          % 此次登录的所在IP

        accum_online_time = 0,  % 玩家累计在线时长

        socket = null,          % 和客户端连接的socket
        pid = null,             % 玩家进程pid

        cur_bhv_state = 0,      %  当前的行为状态（空闲，战斗中，死亡等，详见common.hrl的宏）

        nickname = <<"无名">>,  % 名字（注意：是binary类型，而不是list）
        race = 0,               % 种族（人族，魔族，仙族，妖族）
        faction = 0,            % 门派

        sex = 0,                % 性别（1：男，2：女）
        lv = 1,                 % 等级
        exp = 0,                % 当前的经验值

        yuanbao = 0,            % 金子即元宝
        yuanbao_acc = 0,      % 累计现金充值的元宝数
        bind_yuanbao = 0,       % 绑金
        gamemoney = 0,          % 银子即游戏币(game money)
        bind_gamemoney = 0,     % 绑银(binding game money)

        feat = 0,               % 功勋值（货币）
        literary = 0,           % 学分
        literary_clear_time = 0,    % 学分清零时间戳

        dungeon_id = 0,         % 所在副本的唯一id

        is_auto_battle = false,     % 是否自动战斗


        %%auto_mf_info = #role_am{},  % 自动挂机的信息（包括挂机技能组合，是否自动购买气血包等）


        free_talent_points = 0,  % 自由（未分配的）天赋属性点数

        base_attrs = #attrs{},      % 玩家的基础属性
        equip_add_attrs = #attrs{}, % 装备的加成属性（为了避免此record过大，现在已改为存在进程字典中）
        xinfa_add_attrs = #attrs{},     % 心法的加成属性（为了避免此record过大，现在已改为存在进程字典中）
        total_attrs = #attrs{},     % 玩家的总属性

        move_speed = 0,          % 移动速度

        %%%att_distance = 0,  % 攻击距离


        sendpid = null,          % 专用于发送消息给客户端的进程pid

		cur_battle_id = 0,		 % 当前所在战斗的id（不在战斗中则为0）

		%%%last_handle_proto_time = 0,    % 上次做协议处理的时间（作废！！）
        guild_id = 0,            % 所属帮派的ID（没有加入帮派则固定为0）
        guild_attrs = [],        % 帮派点修属性列表：[{属性名,点修等级,点修值},...]
        team_id = 0,             % 所在队伍的id，若没有队伍，则固定为0
        is_leader = false,       % 是否队长，true:是，false:否
        team_target_type = 0,    % 玩家组队目标类型
        team_condition1 = 0,     % 玩家组队目的之条件1
        team_condition2 = 0,     % 玩家组队目标之条件2

        % newbie_guide_step = 0,		% 新手引导的当前步骤

        partner_id_list = [],      % 宠物id列表（实际的宠物数据统一存到一个ets）
        partner_capacity = 0,      % 玩家当前可以携带的宠物数
        main_partner_id = 0,       % 当前主宠物的id
        follow_partner_id = 0,     % 当前跟随的女妖id
        fight_par_capacity = 0,    % 玩家当前可出战的宠物数量

        phy_power = 0,             % 体力
        % phy_power_lim = 0,         % 体力上限

        battle_power = 0,          % 战斗力

        dun_info = #dun_info{},           % 副本信息 {{NO, Type}, Pid, Builder, null/out/in}
        prev_pos = {0, {0, 0}},                 %进入副本前位置{场景ID,{X坐标, Y坐标}}


        % recharge_bit = 0,            % 充值状态位串(二进制位所在位置从右侧开始顺序为档次号,位值为该档次状态0:未首充 1:首充)
        recharge_state = [],         % 充值各档次状态[{档次, 首充时间戳, 最后一次返利时间戳}]

        month_card_state = [],      % 月卡状态[{月卡编号, 剩余发放天数, 最后一次返利日期数}]

        recharge_accum = {0, 0},        % 充值累积状态 {累积值, 最近一次叠加的时间戳}

        first_recharge_reward_state = 0,    % 首充礼包状态0->不可领取 1->可领取 2->已领取

        vip = #vip{},              %% VIP
        off_state = [],            %% 离线挂机时的状态, proplists
        last_daily_reset_time = 0,       %% 上次执行日重置的时间点（unix时间戳）
        last_weekly_reset_time = 0,       %% 上次执行周重置的时间点（unix时间戳）
        showing_equips = #showing_equip{}, %% 影响玩家场景展示的装备信息

        store_hp = 0,              % 玩家血库
        store_mp = 0,              % 玩家魔法库

        store_par_hp = 0,          % 玩家宠物专用血库
        store_par_mp = 0,          % 玩家宠物专用魔法库

        update_mood_count = 0,     % 当天更新宠物心情次数,
        last_update_mood_time = 0, % 上次更新宠物心情时间
        suit_no = 0                % 套装编号，目前保存符合套装要求的最低强化等级，不符合则此字段为0
    }).






pre_test() ->
	new_ets().

	




%% 2014.5.23 huangjf本机测试结果：
%%           1万次用时约90ms， 10万次用时约930ms 
%%           后注（2014.11.5）： 如果改为用进程字典， 则1万次get+put用时少于8ms，10万次用时约40ms， 100万次用时约420ms，
%%                               可见，从进程字典get、put的效率非常高（即使get、put的记录体比较大），不用担心性能问题。
%%           
test(Times) ->
	erlang:put(test_seq, 0),
	tst_prof:run(fun ets_get_set/0, Times).




test_get(Times) ->
	tst_prof:run(fun ets_get/0, Times).


test_set(Times) ->
	erlang:put(test_seq, 0),
	tst_prof:run(fun ets_set/0, Times).






new_ets() ->
	io:format("new_est()...~n"),
	ets:new(my_test_tbl, [{keypos, #player_status.id}, named_table, public, set]),

	PS1 = #player_status{
				id = 1
				% partner_id_list = lists:seq(1, 150)
				% rela_list = lists:seq(1, 150)
				},

	PS2 = #player_status{
				id = 2
				% partner_id_list = lists:seq(1, 150)
				% rela_list = lists:seq(1, 150)
				},

	PS3 = #player_status{
				id = 3
				% partner_id_list = lists:seq(1, 150)
				% rela_list = lists:seq(1, 150)
				},

	ets:insert(my_test_tbl, PS1),
	ets:insert(my_test_tbl, PS2),
	ets:insert(my_test_tbl, PS3),

	io:format("new_est() done!~n").






ets_get() ->
	[PS] = ets:lookup(my_test_tbl, 1),
	PS.


ets_set() ->
	Seq = erlang:get(test_seq),
	erlang:put(test_seq, Seq + 1),
	PS = #player_status{
				id = 1,
				lv = Seq
				},
	ets:insert(my_test_tbl, PS).



ets_get_set() ->
	Seq = erlang:get(test_seq),
	erlang:put(test_seq, Seq + 1),
	[PS] = ets:lookup(my_test_tbl, 1),
	PS2 = PS#player_status{
				id = 1,  %%PS#player_status.id,
				%%pid = invalid,
				lv = Seq
				},
	ets:insert(my_test_tbl, PS2).


% 从进程字典get/put
% pd_get_put() ->
%     Seq = erlang:get(test_seq),
%     erlang:put(test_seq, Seq + 1),
%     PS = case erlang:get(pdkn_player_status) of
%         undefined ->
%             #player_status{};
%         Any ->
%             Any
%     end,
%     PS2 = PS#player_status{
%                 id = 1,  %%PS#player_status.id,
%                 %%pid = invalid,
%                 lv = Seq
%                 },
%     erlang:put(pdkn_player_status, PS2).




