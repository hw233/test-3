%%%------------------------------------------------
%%% File    : mount.hrl
%%% Author  : lf
%%% Created : 2015-05-06
%%% Description: 坐骑的相关宏定义
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__MOUNT_H__).
-define(__MOUNT_H__, 0).

-include("record.hrl").

-define(RESET_ATT_YUANBAO, 10000).
-define(RESET_ATT_INTEGRAL, 500).

-define(MAX_MOUNT_COUNT, 10). %坐骑最大数
-define(OPEN_MOUNT_LV, 40).  %坐骑开启等级
-define(MAX_FEED_TIMES, 999). %坐骑最大喂养次数
-define(DAY_FEED_TIMES, 30). %每天喂养次数
-define(INIT_FEED_TIMES,3). %初始化喂养次数
-define(MOUNT_MAX_LV, 250).  %坐骑最大等级
-define(FEED_GOOD1, 20013).  %喂养物品1编号
-define(FEED_GOOD2, 20014).  %喂养物品2编号
-define(FEED_EXP1, 300).  %喂养物品1的成长值
-define(FEED_EXP2, 800). %喂养物品2的成长值

-define(MAX_STEP, 8).  %进阶最大等级
-define(MAX_SKILL_NUM, 9).  %技能格子数最大
-define(MAX_SKILL_LV, 5).   %技能最大等级
-define(MAX_CONNECT_PARTNERS, 2). %最大关联宠物数
-define(MAX_INHERITANCE_LV, 30).  %传承等级限制
-define(INHERITANCE_NEED_COUNT, 200).  %传承消耗

-define(MOUNT_ADD_RANCE_MIN, 300). 
-define(MOUNT_ADD_RANCE_MAX, 850). 
-define(MOUNT_ADD_RANCE_MIN_HIGHT, 600). 
-define(MOUNT_ADD_RANCE_MAX_HIGHT, 1000). 
-define(MOUNT_SUB_RANCE_MIN, 200). 
-define(MOUNT_SUB_RANCE_MAX, 300).  


-define(SQL_GET_MOUNT_INFO, "id, no, player_id, name, type, quality, level, exp, skillNum, skill, attribute_1, attribute_2, attribute_3, attribute_add1, attribute_add2, attribute_sub, 
    attributeList, step, step_value, status, partner_num, partner1, partner2, partner3, partner4, partner5, feed, feed_timestamp, battle_power, custom_type, partner_maxnum").

%% 坐骑对象
-record(ets_mount, {
            id = 0              %坐骑id
            ,no = 0             %坐骑编号
            ,player_id = 0      %所属玩家id
            ,name = <<"无名">>  %坐骑名字
            ,type = 0           %类型（t1,t2,t3）
            ,quality = 0        %品质
            ,level = 0          %等级
            ,exp = 0            %成长值
            ,skillNum = 0     %坐骑最大格子数
            ,skill = <<"[0,0,0,0]">>
            ,attribute_1 = 0     %属性编号1
            ,attribute_2 = 0     %属性编号2
            ,attribute_3 = 0     %属性编号3
            ,attribute_add1 = 0 %属性增益比率1
            ,attribute_add2 = 0 %属性增益比率2
            ,attribute_sub = 0 %属性减益比率
            ,attributeList = <<"[]">> %属性列表[{编号1，编号2，编号3，增益比率，减益比率}]
            ,step = 0          %阶数
            ,step_value = 0    %阶数经验值
            ,status = 0        %是否骑乘 （0否1是）
            ,partner_num = 0   %关联宠物数量
            ,partner1 = 0      %关联宠物1
            ,partner2 = 0      %关联宠物2
            ,partner3 = 0      %关联宠物3
            ,partner4 = 0      %关联宠物4
            ,partner5 = 0      %关联宠物5
            ,feed = 0          %可喂养次数
            ,feed_timestamp = 0 %最后一次喂养时间
            ,battle_power = 0  %坐骑战斗力
            ,custom_type = 0   %定制类型 0非定制 1SR 2SSR 3SSS 4SSSR
            ,partner_maxnum = 0 %%关联宠物数量上限
    }).

-record(mount_info, {
        no = 0                %坐骑编号
        ,name = <<"">>        %坐骑名字
        ,type = 0             %坐骑类型
        ,goods_list = []     %激活消耗
        ,quality_ratio = []   %坐骑属性加成比率 [1, 1.1, 1.2, 1.3, 1.4] 
        ,skill_num  = 0       %技能格子数
        ,step_need  = []      %进阶需要的进化值[30,50,90,140]
        ,step_need_goods = [] %坐骑进阶需要的物品编号[20003,20004]
        ,step_skill = []      %专属技能
    }).

-record(mount_skill, {
        no = 0,
        mount_skill_id = [],
        limit_lv = 0,
        god_need = 0,
        max_skill_lv = 0,
        up_skill_limit = []
    }).

-record(mount_skin_info, {
    uid = 1,
    wear_skin_no = 0,
    all_skin = []
}).

-record(mount_skin, {
    no = 0,
    expire = 0,
    ext = []
}).

-record(data_mount_skin, {
    no = 1,
    goods_list = [],
    add_attr = []
}).

-endif.  %% __MOUNT_H__
