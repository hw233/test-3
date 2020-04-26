
%%%------------------------------------------------
%%% File    : goods_record.hrl
%%% Author  : huangjf, zhangwq
%%% Created : 2013.5.14
%%% Description: 物品系统的相关record定义
%%%------------------------------------------------


%% 避免头文件多重包含
-ifndef(__GOODS_RECORD_H__).
-define(__GOODS_RECORD_H__, 0).


-include("common.hrl").
-include("faction.hrl").




%% 物品模板，由策划配置（详见data_goods.erl）
%% tpl: template
-record(goods_tpl, {
        no = 0,                      % 物品编号，no为number的缩写
        name = <<"无名">>,           % 名字

        type = 0,                    % 物品类型
        subtype = 0,                 % 物品子类型

        race = ?RACE_NONE,           % 种族（默认无种族限制）
        faction = ?FACTION_NONE,     % 门派（默认无门派限制）
        camp = ?CAMP_NONE,           % 阵营（友方或敌方，默认无阵营限制）
        sex = ?SEX_NONE,             % 性别（默认男女通用）
        lv = 1,                      % 等级（默认1级）
        vip_lv = 0,                  % vip等级限制（默认不限制）

        sell_price_type = 0,         % 卖出价格类型
        sell_price = 0,              % 卖出价格

        bind_state = 0,              % 当前绑定状态（详见goods.hrl中的宏BIND_XXX）

        quality = 0,                 % 品质

        max_stack = 1,               % 最大叠加数量（对于不可叠加物品，则固定为1）

        can_trade = 0,               % 是否可交易：1为可(交易)，0为不可(交易)，下同
        can_sell = 0,                % 是否可卖出：1 | 0
        can_discard = 0,             % 是否可丢弃：1 | 0
        can_use = 0,                 % 是否可使用：1 | 0
        can_use_in_battle = 0,       % 是否可以在战斗中使用： 1 | 0
        can_batch_use = 0,           % 是否可以批量使用: 1 | 0
        can_store = 1,               % 是否可以放入仓库 默认是1表示：可以放入的 0表示不可以放入
        can_present = 0,             % 是否可以赠送，默认是0表示不可以赠送 1表示可以赠送
        target_obj_type_list = [],   % 使用目标类型列表，表示只能对指定的目标对象类型使用，如：玩家、宠物，默认为空
        usable_times = 0,            % 单个物品的可使用次数（不可使用物品固定为0, 可无限使用的物品则为-1，有限次数的可使用物品则为具体的次数），
                                     % 注意：规定————可无限使用的物品或可使用多次的物品不能叠加！！！

        suit_id = 0,                 % 所属套装的ID，0表示无，非套装则固定为0

        valid_time = 0,                         % 有效时间，单位：秒。默认0表示永久有效
        timekeeping_type = ?TKP_NONE,           % 计时方式，默认无，表示永久有效（0: 无，1：按现实时间计算，2：按在线累积时间计算），宏定义在common.hrl：TKP_XXX
        when_begin_timekeeping = ?WBTKP_NONE,   % 什么时候开始计时，默认无（0：无， 1：获取即开始计时，2：第一次使用后开始计时），宏定义在common.hrl: WBTKP_XXXX
        expire_on_zero = 0,                     % 是否在每天的24点过期，0表示否，1表示是

        effects = [],                           % 物品的效果：[] | 效果编号列表

        %equip_add_base_attrs = [],              % 装备的基本属性加成属性列表。若是装备，则形如：[] | [属性名1，属性名2...]，否则，固定为[]

        equip_add_base_attr_name1 = [],   % 装备的基本属性加成属性名称1
        equip_add_base_attr_value1 = 0,          % 装备的基本属性加成基数1

        equip_add_base_attr_name2 = [],   % 装备的基本属性加成属性名称2
        equip_add_base_attr_value2 = 0,          % 装备的基本属性加成基数2

        equip_add_base_attr_name3 = [],   % 装备的基本属性加成属性名称3
        equip_add_base_attr_value3 = 0,          % 装备的基本属性加成基数3

        equip_add_base_attr_name4 = [],   % 装备的基本属性加成属性名称1
        equip_add_base_attr_value4 = 0,          % 装备的基本属性加成基数1

        equip_add_base_attr_name5 = [],   % 装备的基本属性加成属性名称2
        equip_add_base_attr_value5 = 0,          % 装备的基本属性加成基数2

        equip_add_base_attr_name6 = [],   % 装备的基本属性加成属性名称3
        equip_add_base_attr_value6 = 0,          % 装备的基本属性加成基数3

        enter_faction,

        stren_lv = 0,
        use_limit = 0,                          % 一天或一周内或一个月内限制玩家使用的个数 0表示没有限制
        use_limit_time = 0,                     % 1.一天内 2.一周内 3.一个月内 0表示没有限制
        statistics = 0,                         % 后台数据是否统计这个编号的物品的产出 1表示统计0表示不统计
        extra = [],                              % 物品的额外数据，形如：[] | [{Key, Value, 其他Value（可选）}, ...] 如 {dig_treasure,[地图编号1,地图编号2,..]}表示挖宝区域
		use_need_money = [],						% 使用消耗
		use_need_goods = [],						% 使用消耗
        fix_id = []
    }).


% 装备打造相关结构体
-record(goods_build_tpl, {
        no = 0,
        production = 0,
        ore = 0,
        rune = 0,
        super_goods = {},
        price_type = 0,
        price = 0,
        quality_weight = [],
        super_quality_weight = []
    }).


%% 装备特效结构体
-record(equip_speci_effect_tpl, {   
        no = 0,                 % 特效编号
        rarity_no = 0,
        eff_name = null,        % 特效名
        widget = 0,             % 权重
        lv = 0,                 % 等级
        slot = 0,               % 部位
        value = 0               % 值
        ,need_broadcast = 0   % 是否有公告
		,type = 0
        ,attribute = 0
}).

%% 装备特效编号
-record(equip_speci_effect_type, {
        no = 1,
        eff_name = equip_effect_to_low_level
}).


%% 内存中的实际物品对象
-record(goods, {
		no = 0,                      % 物品编号，由策划制定（no为number的缩写）
        id = 0,                      % 物品唯一Id

        player_id = 0,               % 所属玩家的id（但如果物品挂售在市场，或在邮件附件，则该字段设置为0）
        partner_id = 0,              % 武将Id（装备穿在武将身上时对应武将的唯一Id）

        bind_state = 0,              % 当前绑定状态（详见goods.hrl中的宏BIND_XXX）

        usable_times = 0,            % 当前剩余的可使用次数（不可使用物品固定为0, 可无限使用的物品则为-1，有限次数的可使用物品则为具体的次数），
                                     % 注意：规定————可无限使用的物品或可使用多次的物品不能叠加！！！

        location = 0,                % 所在位置（表示是在背包还是在仓库等），详见common.hrl相关宏定义
        slot = 0,                    % 所在的格子位置（从1开始），若在装备栏，则表示对应的装备位置（详见inventory.hrl中的EQUIP_POS_XXX宏）
        count = 1,                   % 叠加数量（不可叠加物品固定为1，可叠加物品则为实际的叠加数量）
        quality = 0,                 % 品质

        is_dirty = false,            % 脏标记：true表示物品数据在内存中有改动，需要更新到数据库，false则反之
        time_on_mark_dirty = 0,      % 上次标记物品为脏时的服务器时钟滴答计数

        % 以下几个字段是针对有时效的物品
        time_on_last_save_valid_time = 0, % 上次保存时效物品的剩余有效时间到DB时的时间点（unix时间戳）
        first_use_time = 0,          % 第一次使用该物品的时间（unix时间戳），永久物品固定为0
        valid_time = 0,              % !!!!!有效时间，单位：秒。
                                     %   1. 对于永久有效的物品，则固定为0
                                     %   2. 对于按现实时间计时的物品，则表示由策划所配置的有效时间
                                     %   3. 对于按在线累积时间计时的物品，则表示当前剩余的有效时间
        expire_time = 0,             % 过期时间点（unix时间戳），只针对按现实时间计时的物品，表示到了该时间即过期，永久物品则固定为0

        base_equip_add = null,            % !!!!!装备的基本属性加成：
                                     %      (1) 若是装备，则为attrs结构体（见record.hrl），生成装备时是按策划给的规则计算而来，详见lib_goods.erl中的make_new_goods()
                                     %      (2) 否则（非装备），固定为null
        addi_equip_add = null,       % 装备的附加属性加成 同上  服务器属性计算用
        addi_ep_add_kv = [],         % 装备的附加属性加成 服务器保存属性用，方便客户端展示相同类型的附加属性 格式：[] | [{Index, 属性名，属性加成的值, 属性加成精炼等级}, ...] Index表示第几条附加属性

        addi_equip_eff = null,         % 装备特效列表 编号
        addi_equip_eff_add = null,     % 装备特效属性 编号

        stren_equip_add = null,      % 装备强化属性加成 同上
        equip_prop = null,           % !!!!!装备自身的额外特性（如：强化等级， 镶嵌， 洗练等）。
                                     % 若是装备，则为equip_prop结构体， 否则固定为null
        sell_time = 0,               % 物品卖出时的时间戳，次字段仅用于物品回购，在背包或仓库中的物品此字段是0
        battle_power = 0,            % 装备战斗力
        custom_type = 0,             % 0非定制 （1~5）定制
        extra = [],                  % 物品的额外数据: 见下面说明
        show_base_attr = []         % 显示基础属性，[{20,255},{20,255},{20,255}]

    }).


%% goods 的extra字段说明：
% 格式：[] | [{Key, Value, 其他Value（可选）}, ...] 
% {dig_treasure,{SceneNo,X,Y}} 表示挖宝场景和坐标
% {gift, [FromPlayerId, BlessingNo]} 表示来自哪个玩家的礼物，祝福语编号
% {skill_list,[skill_id,...]} 表示技能列表
% {quality_lv, value} 表示品质等级 如 绿+2等
% {contri,功绩值} 表示法宝穿戴需要达到的功绩


%% 装备自身的额外特性（如：强化等级， 镶嵌， 洗练等）
-record(equip_prop, {
		stren_lv = 0,          % 强化等级
        stren_exp = 0,         % 强化经验
        gem_inlay = []         % 宝石镶嵌 格式：[{孔的编号,宝石物品id},...]
		% 其他。。。
	}).


%% 装备的品质概率
-record(eqp_quality_proba, {
        lv_step = 0,
        proba_white = 0.00,        % 白色的概率
        proba_green = 0.00,        % 绿色的系数
        proba_blue = 0.00,         % 蓝色的系数
        proba_purple = 0.00,       % 紫色的系数
        proba_orange = 0.00        % 橙色的系数
        }).




%% 装备具有附加属性加成的条数的概率
-record(eqp_addi_attr_count_proba, {
        quality = 0,
        proba_no_addi_attrs = 0.00,          % 0条的概率
        proba_one_addi_attrs = 0.00,         % 1条的概率
        proba_two_addi_attrs = 0.00,         % 2条的概率
        proba_three_addi_attrs = 0.00,       % 3条的概率
        proba_four_addi_attrs = 0.00,
        proba_five_addi_attrs = 0.00
        }).





%% 装备的基本属性加成的品质系数
-record(eqp_base_quality_coef, {
        lv_step = 0,            % 等级段
        white_min = 0.0,        % 白色的系数下限
        white_max = 0.0,        % 白色的系数上限

        green_min = 0.0,        % 绿色的系数下限
        green_max = 0.0,        % 绿色的系数上限

        blue_min = 0.0,         % 蓝色的系数下限
        blue_max = 0.0,         % 蓝色的系数上限

        purple_min = 0.0,       % 紫色的系数下限
        purple_max = 0.0,       % 紫色的系数上限

        orange_min = 0.0,       % 橙色的系数下限
        orange_max = 0.0,       % 橙色的系数上限

        red_min = 0.0,          % 红色系数下限
        red_max = 0.0           % 红色系数上限
        }).


% 装备附加属性相关
% [命中概率,附加属性基数]
% 列表中的命中概率之和是100  如：[50,1000]  注意：每一行的命中概率之后是1000"
-record(equip_added, {
        no = 0,
        talent_str = 0,
        talent_con = 0,
        talent_sta = 0,
        talent_spi = 0,
        talent_agi = 3,

		hp_lim = 0,
		mp_lim = 0,
		phy_att = 1130,
		mag_att = 1130,
		phy_def = 0,
		mag_def = 0,
		act_speed = 0,
		seal_hit = 282,
		seal_resis = 0,
		do_phy_dam_scaling = 0.050000,
		do_mag_dam_scaling = 0.050000,
		be_phy_dam_reduce_coef = 0,
		be_mag_dam_reduce_coef = 0,

        neglect_seal_resis = 0,
        seal_hit_to_partner = 0,
        seal_hit_to_mon = 0,
        phy_dam_to_partner = 0,
        phy_dam_to_mon = 0,
        mag_dam_to_partner = 0,
        mag_dam_to_mon = 0,
        be_chaos_round_repair = 0,
        chaos_round_repair = 0,
        be_froze_round_repair = 0,
        froze_round_repair = 0,
        neglect_phy_def = 0,
        neglect_mag_def = 0,
        phy_dam_to_speed_1 = 0,
        phy_dam_to_speed_2 = 0,
        mag_dam_to_speed_1 = 0,
        mag_dam_to_speed_2 = 0,
        seal_hit_to_speed = 0,

        phy_crit = 0,
        phy_ten = 0,
        mag_crit = 0,
        mag_ten = 0,
        phy_crit_coef = 0,
        mag_crit_coef = 0,
        heal_value = 0,
        revive_heal_coef = 0,
        addi_coef = [],

        chance1 = 200,
        chance2 = 10,
        chance3 = 0,
        chance4 = 0,
        chance5 = 0,
        effect_chance = 10,
        effect = [1,2,3],
        stunt_chance = 5,
        stunt = [1,2,3],
        stunt2 = [],
        effect2 = []
    }).

% 装备附加属性相关 结构体（备用，暂时不用）
-record(equip_added1, {
        no = 0,
        phy_att = 0,
        phy_att_prob = 0,
        mag_att = 0,
        mag_att_prob = 0,
        mp_lim = 0,
        mp_lim_prob = 0,
        crit = 0,
        crit_prob = 0,
        seal_hit = 0,
        seal_hit_prob = 0,
        phy_def = 0,
        phy_def_prob = 0,
        mag_def = 0,
        mag_def_prob = 0,
        hp_lim = 0,
        hp_lim_prob = 0,
        act_speed = 0,
        act_speed_prob = 0,
        hit = 0,
        hit_prob = 0,
        dodge = 0,
        dodge_prob = 0,
        ten = 0,
        ten_prob = 0,
        seal_resis = 0,
        seal_resis_prob = 0,
        frozen_hit = 0,
        frozen_hit_prob = 0,
        trance_hit = 0,
        trance_hit_prob = 0,
        chaos_hit = 0,
        chaos_hit_prob = 0,
        frozen_resis = 0,
        frozen_resis_prob = 0,
        trance_resis = 0,
        trance_resis_prob = 0,
        chaos_resis = 0,
        chaos_resis_prob = 0
    }).

%% 装备附加属性常量
-record(equip_added_con, {
        constant_type = 0,
        con_lv_up = 0,
        star_lv_up = 0,
        up_lv_coef = 0
    }).

%% 作废！！
% %% 物品的额外数据（ TODO： 包含的字段名待定，临时简单些some_field_xx）
% -record(goods_extra, {
% 		some_filed_1 = 0,
%         some_filed_2 = 0
% 	}).



%% 装备强化数据结构体
-record(equip_strenthen, {
        stren_lv = 1,
        need_eq_lv = 0,
        strengthen_stone = 0,
        strengthen_stone_count = 0,
        base_attr_add = 0
    }).


%% 女妖装备强化
-record(par_eq_stren, {
        lv_range = [],    
        stren_lv = 0,    
        exp_need = 0,    
        attr_add = 0
    }).

%% 女妖装备基础经验
-record(par_eq_base_exp, {
        no   = 0,
        eq_no    = 0,
        quality  = 0,
        base_exp = 0
    }).

%% 道具合成提炼数据结构体
-record(compose_goods, {
        no = 0,
        op_no = 0,
        need_goods_list = [],
        money = [],
        get_goods_list = []         %% 宝石熔炼获得
    }).


%% 装备分解基础所得
-record(equip_decompose_base, {
        no = 0,
        goods_list = [],      %% 保底物品，分解没有获得物品的时候才发{物品编号, 物品数量}
        goods_list_1 = [],    %% 格式：{概率,物品编号, 物品数量} 概率填0到1000的数 其他以此类推
        goods_list_2 = [],    
        goods_list_3 = [],    
        goods_list_4 = [],    
        goods_list_5 = [],    
        goods_list_6 = [],
        dummy = 0
    }).


%% 装备分解强化额外所得
-record(equip_decompose_add, {
        no = 0,
        stren_lv = 0,
        goods_list = [],
        lv_range = 0
    }).


%% 装备附加属性值等级表
-record(equip_add_lv, {
        lv = 0,
        weight = 0
    }).

%% 装备生成时开孔个数随机数据
-record(equip_hole, {
        no = 0,
        hole_no = 0,
        proba = 0
    }).

%% 开孔消耗数据结构
-record(equip_open_hole, {
        no = 0,
        need_goods_list = []
    }).

%% 宝石属性加成
-record(gem_add, {
        no = 0,
        type = 0,
        b_type = 0,
        body_type = [],
        ratio = 0,      %% 宝石属性加成 可能是一个百分数也可能是一个整数
        coef = 0,
        lv_limit = 0
    }).


-record(equip_suit, {
        no = 0,
        lv = 0, 
        hp_lim_rate = 0,
        mp_lim_rate = 0,
        phy_att_rate = 0,   
        mag_att_rate = 0,   
        phy_def_rate = 0,   
        mag_def_rate = 0
    }).


%% 物品兑换
-record(goods_exchange, {
        no = 0,
        goods_no = 0,
        need_goods_list = []
    }).

%% 装备强化转移配置
-record(stren_trs_cfg, {
        src_no = 0,
        obj_no = 0,
        stren_lv = 0,
        obj_stren_lv = 0,
        money = 0
    }).


%% 装备进阶（品质提升）
-record(upgrade_quality_cfg, {
        lv   = 0,
        quality  = 0,
        money    = 0,
        goods_list = 0
    }).

-record(eq_recast_cfg, {
        no = 0,
        money_list = [],
        goods_list = []
    }).

-record(eq_recast_cost, {
        no = 0,
        base_money_list = [],
        base_goods_list = [],
        money_list = [],
        stunt_list = [],
        eff_list = [],
        goods_list = [],
        stunt_money_list = [],
        eff_money_list = [],
        stunt_list2 = [],
        eff_list2 = []
    }).


-record(eq_refine_lv_rela, {
        no = 0,  
        money_list = [],  
        goods_list = [],  
        weight = 0,  
        phy_att = 0, 
        mag_att = 0, 
        phy_def = 0,     
        mag_def = 0,     
        hp_lim = 0,  
        mp_lim = 0,  
        act_speed = 0,   
        hit = 0, 
        dodge = 0,   
        crit = 0,    
        ten = 0, 
        seal_hit = 0,    
        seal_resis = 0,
        frozen_hit = 0,
        trance_hit = 0,
        chaos_hit = 0,   
        frozen_resis = 0,    
        trance_resis = 0,    
        chaos_resis = 0
    }).


%% 装备升级
-record(upgrade_lv_cfg, {
        lv   = 0,
        src_goods_no = 0,
        quality  = 0,
        money    = 0,
        goods_list = 0,
        obj_goods_no = 0
    }).



%% magic_key（mk）法宝基础经验
-record(mk_exp_cfg, {
        no   = 0,
        eq_no    = 0,
        quality  = 0,
        base_exp = 0
    }).


%% 法宝技能升级
-record(mk_skill_up_cfg, {
        skill_id = 0,    
        next_id = 0, 
        quality_need = 0,    
        consume_role_exp = 0
    }).


%% 法宝关联属性配置
-record(mk_relate_cfg, {
        no = 0,   
        talent_skill_cnt = [],    
        common_skill_cnt = [],    
        talent_skill_list = [],   
        common_skill_list = [],
        refresh_skill_list = [],
        need_money_ratio = 0,
        need_goods_ratio = 0,   
        need_money = [],  
        need_goods = []
    }).


%% 法宝强化
-record(mk_stren_cfg, {
        no = 0,      
        quality = 0, 
        layer = 0,   
        exp_need = 0,    
        need_money = []
    }).


%% 特技洗练
-record(equip_effect_wash, {
							no = 1,
							lv_lower = 1,			%% 等级段下限 1-60
							lv_upper = 1,			%% 等级上限
							xilian_stone = 70573,	%% 洗练消耗道具编号
							xilian_stone_count = 10,%% 数量	
							price_type = 0,				%% 货币类型
							price = 20000			%% 货币值
						   }).


%% 幻化
-record(equip_effect_huanhua, {
    lv,
    huanhua_material,
    huanhua_material_count,
    price_type,
    price,
    success_rate,
    amulet,
    amulet_count,
    amulet_success_rate
}).

-record(equip_effect_huanhua_weight, {
    no,
    huanhua_effect_weight
}).

-endif.  %% __GOODS_RECORD_H__