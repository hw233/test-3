%%%--------------------------------------------------------
%%% @author Lzz <liuzhongzheng2012@gmail.com>
%%% @doc 定制系统
%%%
%%% @end
%%%--------------------------------------------------------

%% ets ets_diy_title

%% 称号
-record(diy_title_config, {
            no = 0,                     %% 编号
            type = 0,                   %% 类型
            name = <<"">>,              %% 称号名称
            optional_attr_num = 0,      %% 选择属性数量
            optional_attr_add = [],     %% 对应属性列表
            cost = {}                   %% 消耗道具
}).

-record(diy_title, {
            uid = 0,                    %% 玩家id
            titles = []                 %% DIY称号列表 diy_title_config
}).

-record(diy_partner_config, {
            no = 0,                     %% 编号
            aptitude = 0,               %% 资质档位
            partner_no = {},            %% 可选门客编号
            skill_no = {},              %% 可选主动技能
            passi_skill_limit = 0,      %% 被动技能数量
            cost = {}                   %% 消耗道具
}).

-record(diy_fashion_config, {
    no = 0,                             %% 编号
    type = 0,                           %% 类型
    fashion_no = [],                    %% 时装编号列表
    fashion_add_attr_num = 0,           %% 附加属性数量
    fashion_add_attr = [],              %% 附加属性列表
    fashion_effect_no = [],             %% 特效编号列表
    cost = {}                           %% 消耗道具
}).

-record(diy_chibang_config, {
    no = 0,                             %% 翅膀编号
    type = 0,                           %% 类型
    chibang_no = [],                    %% 翅膀编号
    chibang_add_attr_num = 0,           %% 翅膀属性数量
    chibang_add_attr = [],              %% 翅膀属性列表
    cost = {}                           %% 消耗道具
}).

-record(diy_mount_config, {
    no = 0,                             %% 编号
    type = 0,                           %% 类型
    mount_no = [],                      %% 坐骑编号
    mount_add_attr = [],                %% 初始附加属性列表
    attr_min1 = 0,                      %% 增益最小值1
    attr_max1 = 0,                      %% 增益最大值1
    attr_min2 = 0,                      %% 增益最小值2
    attr_max2 = 0,                      %% 增益最大值2
    attr_min3 = 0,                      %% 增益最小值3
    attr_max3 = 0,                      %% 增益最大值3
    gamemoney_reset_attr_min1 = 0,      %% 银币重置增益最小值1
    gamemoney_reset_attr_max1 = 0,      %% 银币重置增益最大值1
    gamemoney_reset_attr_min2 = 0,      %% 银币重置增益最小值2
    gamemoney_reset_attr_max2 = 0,      %% 银币重置增益最大值2
    gamemoney_reset_attr_min3 = 0,      %% 银币重置增益最小值3
    gamemoney_reset_attr_max3 = 0,      %% 银币重置增益最大值3
    shuiyu_reset_attr_min1 = 0,         %% 水玉重置增益最小值1
    shuiyu_reset_attr_max1 = 0,         %% 水玉重置增益最大值1
    shuiyu_reset_attr_min2 = 0,         %% 水玉重置增益最小值2
    shuiyu_reset_attr_max2 = 0,         %% 水玉重置增益最大值2
    shuiyu_reset_attr_min3 = 0,         %% 水玉重置增益最小值3
    shuiyu_reset_attr_max3 = 0,         %% 水玉重置增益最大值3
    mount_effect_par_num = 0,           %% 坐骑管制数量
    cost = {}
}).

-record(diy_mount_attr, {
    no = 0,
    type = 0,
    lv = 0,
    attr = []
}).

-record(diy_equip_config, {
    no = 0,
    type = 0,
    equip_no = [],
    equip_add_attr_num = 0,
    equip_add_attr = [],
    equip_effect_num = 0,
    equip_effect_no = [],
    equip_skill_num = 0,
    equip_skill_no = [],
    cost = {}
}).

-record(diy_exchange_decompose, {
    no = 1,
    goods_no = 89324,
    type = 1,
    get_goods = 89323,
    get_goods_num = 3
}).