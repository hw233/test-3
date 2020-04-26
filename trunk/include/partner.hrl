%%%------------------------------------------------
%%% File    : partner.hrl
%%% Author  : huangjf
%%% Created : 2011-12-7
%%% Modify  : 2013-10-22
%%% Description: 宠物的相关宏定义
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__PARTNER_H__).
-define(__PARTNER_H__, 0).

-include("record.hrl").


%% 宠物出生培养相关值
-record(base_train_attrs, {
            grow = 0,               % 成长
            life_aptitude = 0,      % 生命资质
            mag_aptitude = 0,       % 法力资质
            phy_att_aptitude = 0,   % 物攻资质
            mag_att_aptitude = 0,   % 法功资质
            phy_def_aptitude = 0,   % 物防资质
            mag_def_aptitude = 0,   % 法防资质
            speed_aptitude = 0      % 速度资质
    }).


%% 宠物对象
-record(partner, {
        	id = 0,             			            % 武将唯一id
        	no = 0,    			                        % 武将编号
        	player_id = 0,      			            % 所属玩家的id
        	name = <<"无名">>,      		                % 武将名称
        	sex = 0,       					            % 武将性别：1 男，2 女
        	state = 0,     					            % 武将状态, 详见partner.hrl文件
        	quality = 0,   					            % 宠物品质 白、绿、蓝、紫、橙、红6种品质
            lv = 0,                                     % 武将等级
            exp = 0,                                    % 武将经验值(升级后剩余的经验，不是总经验值)
            intimacy = 0,                               % 亲密度 (升级后剩余的亲密度，不是总亲密度) (去掉了)
            intimacy_lv = 0,                            % 亲密度等级 (去掉了)
            life = 0,                                   % 寿命
            cur_battle_num = 0,                         % 当前战斗场数
            hp = 0,
            position = 0,                               % 是否主宠：1表示主宠
            follow = 0,                                 % 是否跟随 1表示跟随
            cultivate = 0,                              % 修炼值
            cultivate_lv = 0,                           % 修炼等级
            cultivate_layer = 0,                        % 修炼层数
            base_attrs = #attrs{},                      % 基础属性
            equip_add_attrs = #attrs{},                 % 装备的加成属性
            passi_eff_attrs = #attrs{},                 % 宠物被动技能加成属性
            buff_eff_attrs = #attrs{},                  % 宠物buff加成属性
			awake_attrs = #attrs{},						% 宠物觉醒加成属性
                                                        % 如果以后通过其他方式增加属性值的话，在数据库保存成key-value形式
            total_attrs = #attrs{},                     % 总属性

			skills_use = 1,								% 当前使用的技能页
        	skills = [],    				            % 已学的技能列表，格式为：[] | skl_brief结构体列表
			skills_two = [],   				            % 已学的技能列表2，格式为：[] | skl_brief结构体列表
			skills_exclusive = [],   				    % 已学的技能列表2，格式为：[] | skl_brief结构体列表
						
            battle_power = 0,                           % 战斗力
            loyalty = 0,                                % 忠诚度 (去掉了)
            nature_no = 0,                              % 性格编号
            evolve_lv = 0,                              % 进化等级
            evolve = 0,                                 % 进化值
            awake_lv = 0,                               % 觉醒等级
			awake_illusion = 0,							% 觉醒幻化
            base_train_attrs = #base_train_attrs{},     % 宠物出生培养相关值 包括 成长基础值 和 7肿资质基础值
            base_train_attrs_tmp = #base_train_attrs{},     % 宠物出生培养相关值 包括 成长基础值 和 7肿资质基础值
            max_postnatal_skill = 0,                    % 最大后天技能格数(这个字段改成是最大可学习技能格子数量)
            showing_equips = #showing_equip{},
            wash_count = 0,                             % 宠物累计的洗髓次数
            mood_no = 0,                                % 当前心情编号
            last_update_mood_time = 0,                  % 上次更新心情时间，一天一更新
            update_mood_count = 0,                      % 当天更新心情次数
            is_dirty = false,                           % 标记是否需要保存数据库
            add_skill_fail_cnt = 0,                     % 新增后天技能失败次数，当成功新增一个技能，次数清零
            version = 0,                                 % 数据版本,用于调整线上数据(规则调整等情况)
            mount_id = 0                                %宠物关联坐骑id
            ,free_talent_points = 0,                     % 可以分配属性点
            five_element = {0,0},                        %五行属性，五行等级
            ts_join_battle = 0,
		    join_battle_order = 0,
			attr_refine = [],							% 宠物精炼属性
            art_slot = [],                               % 已解锁的功法格子
			cost_refine = []							% 宠物精炼消耗的精炼丹数
			
        }).


%% 宠物的出生数据
-record(par_born_data, {
  no = 0,                        % 武将编号
  name = <<"无名">>,   	       % 武将名称
  quality = 0,                   % 品质
  sex = 0,       			       % 性别：1 男，2 女
  character_pool = [],           % 性格池
  inborn_skill_pool = [],        % 先天技能池
  postnatal_skill_pool = [],     % 后天技能池
  max_postnatal_skill_slot = 0,
  inborn_skill_slot = 0,
  exclusive_skill = [],
  reserve_skill_pool = [],       % 在后天技能池里使用道具获得被动技能失败时用得备用技能池
  half_res = 0,                  % 半身像id
  action_res = 0,                % 身体动作包id
  head_res = 0,                  % 头饰资源id
  back_res = 0,                  % 背饰资源id
  ref_attr = 1,
  player_lv_need = 0, % 女妖出战对玩家的等级要求
  ref_lv = 0,
  evolve_consume_par_no = [],
  add_point = [],

  %% 以下字段为固定属性女妖用
  fix = 0,                 % 默认是0表示没有，填1则表示有固定属性
  inborn_skill_num     = 0, % 先天技能个数
  postnatal_skill_num  = 0, % 后天技能个数
%%             max_postnatal_skill_slot = 0, % 后天技能格子上限
  grade = 0  ,                % 档次 0 普通 1高级 2珍兽 3神兽
  grow = 832,
  hp_aptitude = 0,
  phy_att_aptitude = 0,
  mag_att_aptitude = 0,
  phy_def_aptitude = 0,
  mag_def_aptitude = 0,
  speed_aptitude = 0
}).


%% 品质关联数据
-record(quality_relate_data, {
            quality = 0,
            life = 0,
            loyalty_max = 0,
            evolution_lv_max = 0,
            evolution_intimacy = 0,
            growth_value_region = 0,
            aptitude_toplimit_sum = 0,
            one_aptitude_region = 0,
            inborn_skill_num_region = 0,
            postnatal_skill_slot_region = 0,
            postnatal_skill_num_region = 0,
            wash_elixir_no = 0,
            wash_elixir_count = 0,
            high_wash_elixir_no = 0, 
            high_wash_elixir_count = 0
    }).


%% 亲密度等级关联数据
-record(intimacy_lv_relate_data, {
            intimacy_lv = 0,
            lv = 0,
            evolution_lv = 0,
            consume_life = 0,
            battle_num = 0,
            consume_loyalty_die = 0,
            intimacy_lim = 0,
            grow = 0,
            inborn_skill_num = 0
    }).


%% 性格关联属性
-record(nature_relate_data, {
            no = 0,
            phy_att_lean = 0,
            phy_def_lean = 0,
            mag_att_lean = 0,
            mag_def_lean = 0,
            life_lean = 0,
            super_power_lean = 0,
            speed_lean = 0,
            str = 0,
            con = 0,
            sta = 0,
            spi = 0,
            agi= 0
    }).


% 宠物进化相关数据
-record(partner_evolve, {
            quality = 0,
            lv = 0,
            no = 0,
            evolve = 0,
            evolve_support = 0,
            intimacy_lv = 0,
            par_lv_need = 0,
            consume_goods = [],
            bind_yuanbao = 0,
            grow_add = 0,

            free_get_goods_1 = [],
            free_get_goods_2 = [],
            free_get_goods_3 = [],
            free_get_goods_4 = [],
            free_get_goods_5 = [],
            free_get_goods_6 = [],
            free_get_goods_7 = []
    }).


% 宠物
-record(partner_cultivate, {
            no = 0,
            lv = 0,
            layer = 0,
			need_lv = 0,
            cultivate_next_lv_need = 0,
            success_prob = 0,
            alchemy_no = 0,
            alchemy_num = 0,
            bind_yuanbao = 0,
            attrs_add = [],
            get_cultivate = 0,
            exp_crit_rate = 0,
            fossil_num = 0,
            result = 0,
            free_get_goods_1 = [],
            free_get_goods_2 = [],
            free_get_goods_3 = [],
            free_get_goods_4 = [],
            free_get_goods_5 = [],
            free_get_goods_6 = [],
            free_get_goods_7 = []
    }).

%% 宠物后天技能
-record(partner_skill, {
        id = 0,
        rarity_no = 0
    }).


%% 宠物标准数值
-record(par_standard_dt, {
        nature_no = 0,
        lv = 0,
        hp = 0,
        phy_att = 0,
        mag_att = 0,
        phy_def = 0,
        mag_def = 0,
        crit = 0,
        ten = 0,
        hit = 0,
        dodge = 0,
        act_speed = 0,
        seal_hit = 0,
        seal_resis = 0,
        mp = 0
    }).


%% 宠物提升亲密度获得惊喜
-record(surprise, {
        no = 0,
        para = 0,
        weight = 0
    }).

%% 满足心愿提升宠物亲密度
-record(fulfil_wish, {
        step = 0,
        goods_no1 = 0,
        goods_no2 = 0,
        goods_no3 = 0,
        goods_no4 = 0,
        goods_no5 = 0,
        goods_no6 = 0,
        count = 0,
        intimacy_lv_region = 0
    }).


%% 宠物心情配置表
-record(mood_cfg, {
        no = 0,
        buff_no_list = [],
        weight = 0
    }).


%% 宠物觉醒表
-record(partner_awake,	{
			no = 1,
			par_no = 301,
			awake_lv = 0,
			need_lv1 = 6,
			need_lv2 = 6,
			goods = [{59001,3}],
			attrs = [{phy_att,24000,0}],
			skills = [20601]
}).


%% 宠物精炼表
-record(partner_refine,	{
						 no = 11022,
						 attr_name = phy_att,
						 add_range = {14,14},
						 add_top = 230000
						}).


%% 宠物资质上下限
-record(par_aptitude, {
        lv = 0,                 % 等级段
        white_min = 0,        % 白色的下限
        white_max = 0,        % 白色的上限
        green_min = 0,        % 绿色的下限
        green_max = 0,        % 绿色的上限
        blue_min = 0,         % 蓝色的下限
        blue_max = 0,         % 蓝色的上限
        purple_min = 0,       % 紫色的下限
        purple_max = 0,       % 紫色的上限
        orange_min = 0,       % 橙色的下限
        orange_max = 0,       % 橙色的上限
        red_min = 0,          % 红色下限
        red_max = 0           % 红色上限
        }).


%% 玩家寻妖信息
-record(find_par, {
        player_id = 0,
        is_dirty = false,

        lv_step = 0,                % 寻妖系统进入青楼的等级段编号
        last_free_enter_time = 0,   % 上次免费普通进入的青楼的时间戳
        enter_type = 0,             % 当前进入青楼的类型 0表示还没有进入;1表示普通进入；2表示高级进入
        last_enter_type = 0,        % 上次进入青楼的类型 0表示还没有进入;1表示普通进入；2表示高级进入
        counter = [],               % 计数器信息，用于实现需要保底功能,格式：[{等级段,累计抽取个数,累计抽取话费元宝数},...] 累计抽取个数，累计抽取话费元宝数会清0 重新累计
        par_list = []               % 青楼的女妖列表
    }).

%% 寻妖数据结构
-record(find_par_cfg,{
        no = 0,
        lv_range = [],
        money_need_com = 0,
        goods_need_com = [],
        money_need_high = 0,
        goods_need_high = [],
        common_pool = [],
        high_pool = [],
        high_pool10 = [],
        minimum_pool = [],    
        minimum_money = 0,   
        minimum_count = 0
    }).


%% 女妖能力等级关联属性数据结构
-record(ability_lv_cfg, {
        no   = 0,
        range    = [],
        evolve_coef  = 0,
        wash_goods_count_coef    = 0,
        cultivate_goods_count_coef = 0
    }).


%% 洗髓获得成长和资质值概率配置
-record(wash_prob_cfg, {
        no = 0,  
        prob = 0
    }).


% 宠物技能打书配置
-record(change_skill_cfg, {
        max_slot = 0,
        cur_p_skill_count = 0,   
        prob = 0,
        coef_a = 0,
        goods_list = []
    }).

%% 宠物状态
-define(PAR_STATE_INVALID,        0).   % 无效状态
-define(PAR_STATE_REST_UNLOCKED,           100).   % 100-->休息非锁定
-define(PAR_STATE_REST_LOCKED,             101).   % 101-->休息锁定
-define(PAR_STATE_JOIN_BATTLE_UNLOCKED,    110).   % 110-->参战非锁定
-define(PAR_STATE_JOIN_BATTLE_LOCKED,      111).   % 111-->参战锁定
-define(PAR_STATE_HOME_WORK,      		   112).   % 112-->家园雇佣


%% 宠物携带数量
-define(PAR_CARRY_DEFAULT, 20).
-define(PAR_CARRY_MAX, 20).

-define(PAR_FIGHT_DEFAULT, 1).      %% 默认可出战宠物数


%% 宠物的最大等级
-define(PARTNER_MAX_LV, 70).
-define(DELTA_LV_JOIN_BATTLE_LIMIT, 15).    % 当宠物等级大于等于角色等级15级则无法设置参战状态
-define(DELTA_LV_PLAYER_PAR, 1).            % 当(wjc,改为能获取经验但等级不能超过人物等级)
-define(MAX_NAME_LEN, 6).                   % 宠物名字最大允许汉字数

-define(PAR_MAX_POSTNATAL_SKILL_SLOT, 8).   % 宠物规定系统最大后天技能格子数

-define(PARTNER_MAX_INTIMACY_LV, 20).       % 最大亲密度等级
-define(PARTNER_MAX_EVOLVE_LV, 9).          % 最大进化等级
-define(PARTNER_MAX_CULTIVATE_LV, 10).      % 最大修炼等级

%% 是否主宠
-define(PAR_POS_MAIN, 1).                   % 主宠
-define(PAR_POS_NOT_MAIN, 0).               % 非主宠

-define(PAR_FOLLOW, 1).
-define(PAR_UNFOLLOW, 0).

-define(PAR_FOSSIL_NO, 50091).               % 宠物修炼使用的点化石编号
-define(PAR_EXTEND_CAPACITY_GOODS_NO, 60012).% 开启未开放的携带格子消耗的物品编号

-define(PAR_EVOLVE_GOODS_NO,50307).         % 进化道具编号

-define(PAR_LOYALTY_POINT_BATTLE, 1).       % 宠物每战斗n场消耗忠诚度点数

-define(PAR_LIFE_POINT_BATTLE, 1).          % 宠物每战斗一场消耗寿命点数
-define(PAR_LIFE_POINT_BATTLE_DIE, 50).     % 宠物每战斗死一次消耗寿命点数

-define(PAR_CONSUME_LOYALTY_LV_LIMIT, 20).  % 女妖死亡扣除忠诚度等级限制

-define(SQL_GET_PARTNER_INFO, "id, player_id, no, name, sex, quality, state, lv, exp, hp, intimacy, intimacy_lv, life, cur_battle_num, position, follow, cultivate,cultivate_lv, cultivate_layer,  skills_use, skills, skills_two, skills_exclusive, battle_power, loyalty, nature_no, evolve_lv,evolve,awake_lv,awake_illusion,base_train_attrs,base_train_attrs_tmp,max_postnatal_skill, wash_count, mood_no, last_update_mood_time, update_mood_count, add_skill_fail_cnt, version, mount_id,base_talents,free_talent_points,five_element,ts_join_battle,join_battle_order,attr_refine,art_slot,cost_refine").

%% 总属性的组成列表： [基础属性，装备的加成属性]
-define(PARTNER_ATTRS_FIELD_LIST(Partner), [Partner#partner.base_attrs, Partner#partner.equip_add_attrs]).

%% 女妖各个系统开放女妖等级限制
% -define(PAR_EVOLVE_LV_NEED, 25).
% -define(PAR_CULTIVATE_LV_NEED, 1).

% 宠物携带装备基础属性系数
-define(PAR_EQUIP_BASE_ATTR_COEF, 0.5).
% 装备强化属性系数
-define(PAR_EQUIP_STRENGTHEN_ATTR_COEF, 0.7).
% 宝石属性系数
-define(PAR_EQUIP_GEM_ATTR_COEF, 0.8).

%% 每日限制刷新30次，VIP 50 次 心情
-define(PAR_CHANGE_MOOD_COUNT_LIMIT, 30).
-define(PAR_VIP_CHANGE_MOOD_COUNT_LIMIT, 50).

-define(GOODS_NO_FOR_CHANGE_MOOD, 50085).

%% 女妖的7种资质
-define(APTITUDE_LIFE, 1).
-define(APTITUDE_MAG, 2).
-define(APTITUDE_PHY_ATT, 3).
-define(APTITUDE_MAG_ATT, 4).
-define(APTITUDE_PHY_DEF, 5).
-define(APTITUDE_MAG_DEF, 6).
-define(APTITUDE_SPEED, 7).

%%  进入青楼的类型
-define(ENTER_HOTLE_TYPE_NONE, 0).          %% 表示还没有进入
-define(ENTER_HOTLE_TYPE_COM, 1).           %% 表示普通进入；
-define(ENTER_HOTLE_TYPE_HIGH, 2).          %% 表示高级进入；
-define(ENTER_HOTLE_TYPE_HIGH10, 4).        %% 表示高级10次进入；
-define(ENTER_HOTLE_TYPE_COM_FREE, 3).      %% 表示免费普通进入


-define(PAR_PROB_EVOLVE_ADD_SKILL_SLOT, 150).   %% 进化改变技能的概率,基数是1000
-define(PAR_PROB_EVOLVE_ADD_SKILL, 30).        %% 进化改变技能的概率,基数是1000


-define(PAR_FIND_COUNT_CON , 1).            %% 普通寻妖 产出女妖个数
-define(PAR_FIND_COUNT_HIGH, 5).            %% 高级寻妖 产出女妖个数
-define(PAR_FIND_COUNT_HIGH10, 10).         %% 高级10连寻妖 产出女妖个数


-define(PAR_FIND_TYPE_CON , con).            %% 普通寻妖 
-define(PAR_FIND_TYPE_HIGH, high).           %% 高级寻妖 
-define(PAR_FIND_TYPE_HIGH10, high10).       %% 高级10连寻妖

-define(PAR_FIND_PURPLE_COUNTER, 10).       %% 累计寻妖 必出紫色女妖的计数器

-define(PAR_MAX_TRANSMITED_OBJ, 4).         %% 一次最大允许的被传功对象个数

-define(PAR_DATA_VERSION_OLD, 0).           %% 上个数据版本
-define(PAR_DATA_VERSION_NEW, 1).           %% 当前要调整到的数据版本

-endif.  %% __PARTNER_H__
