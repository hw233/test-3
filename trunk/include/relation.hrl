%%%------------------------------------------------
%%% File    : relation.hrl
%%% Author  : huangjf 
%%% Created : 2013.6.28
%%% Description: 好友系统相关的定义
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__RELATION_H__).
-define(__RELATION_H__, 0).



%%关系列表
-record(relation, 
    {
        id = 0,         %%记录id
        idA = 0,        %%角色A的id
        idB = 0,        %%角色B的id
        rela = 0,       %%关系(0:没关系 1:好友 2:黑名单 3:仇人)
        intimacy_bt = 0,%% 通过战斗获得的好友度
        intimacy = 0    %% 总好友度
        % group = 1,      %%B所在分组
        % time = 0        %%关系建立的时间戳
    }).


%%玩家关系相关的信息
-record(relation_info, 
    {
        id = 0,                 %% 角色A的id
        is_dirty = false,
        apply_count_day = 0,    %% 当天剩余申请加为好友次数
        last_apply_time = 0,    %% 上次申请加好友时间
        rela_list = null,       %% null | [] 玩家关系列表，目前只缓存玩家关系的唯一id列表,如果还没有加载则初始化为null
        offline_msg = [],       %% [{MsgSourceId, Msg, TimeStamp} ...]

        sworn_id = 0,               %% 结拜唯一id，目前保存队长的id，如果没有结拜则为0
        free_modify_pre_count = 0,  %% 剩余免费修改前缀次数 队长专用
        free_modify_suf_count = 0,  %% 剩余免费修改后缀次数
        sworn_suffix = <<>>,        %% 结拜关系称号后缀 1到3个字符
        get_intimacy = 0,           %% 每周通过收花获得的好友度
        give_intimacy = 0,          %% 每周通过送花获得的好友度

        spouse_id = 0,              %% 配偶玩家id
        couple_skill = [],          %% 夫妻技能: id列表
		time_marry = 0,				%% 上次结婚unixtime
		time_divorce = 0,			%% 上次离婚unixtime
		last_divorce_force = 0		%% 上次离婚是否为强制离婚        
    }).

%% 结拜数据
-record(sworn,
    {
        id = 0,        %% 用队长id唯一标识
        type = 0,      %% 结拜类型 1 普通结拜，2，生死结拜
        prefix_only = 0, %% 前缀是否唯一，1表示唯一
        prefix = <<>>, %% 结拜关系前缀
        suffix_list = [], %% 后缀列表
        members = []   %% 好友id列表
    }).


%% 结拜属性加成
-record(sworn_attr_add, {
        type = 0,    
        group_no = 0,
        add_attrs_2 = [], 
        add_attrs_3 = [], 
        add_attrs_4 = [], 
        add_attrs_5 = [],
        reward_no = 0
    }).


-record(couple_cfg, {
        no  = 0,
        key = null,
        type    = 0,
        need_money  = [],
        tips_no = 0,
        title_no    = 0,
        output_money    = [],
        per_money   = [],
        intimacy_limit  = 0, 
        intimacy_left   = 0,
        lv_limit = 0,
        fireworks = 0,
        fire_no = 0,
        fire_price = [] 
    }).


%% trigger cruise event
-record(couple_cru_event, {
        pos = {0, 0},
        events = []
    }).

%% 玩家关系
-define(FRIEND,             1).   %好友
-define(BLACKLIST,          2).   %黑名单            
-define(ENEMY,              3).   %仇人
-define(CURRENTLY_CONTACT,  4).   %临时好友
-define(CURRENTLY_TEAMMATE, 5).   %最近战友

-define(MAX_FRIENDS, 1000).   %好友人数上限
-define(MAX_APPLY_DAY, 100). %当天最大可申请加好友次数
-define(RELA_MSG_LENGTH, 200).

-define(RELATION_PROCESS, relation_process).

%% 支持最大的离线数据条数
-define(RELA_MAX_OFFLINE_MSG, 200).
%% 离线消息保存的最大天数
-define(RELA_MAX_DAY_MSG_SAVE, 7).

-define(RELA_ENSURE_WAIT_TIME, 20).

-define(RELA_TEAM_ENSURE_LIST, ensure_list).     % 组队进入结拜过程，保存在某个进程字段的key

-define(RELA_INFO_SQL, "apply_count_day, last_apply_time, offline_msg, sworn_id, free_modify_pre_count, free_modify_suf_count, sworn_suffix, get_intimacy, give_intimacy, spouse_id, couple_skill, time_marry, time_divorce, last_divorce_force").
-define(RELA_SQL, "id, idA, idB, rela, intimacy_bt, intimacy").

-define(RELA_TITLE_NO_COM, 62001).
-define(RELA_TITLE_NO_COM_ONLY, 62002).
-define(RELA_TITLE_NO_HIGH, 62003).
-define(RELA_TITLE_NO_HIGH_ONLY, 62004).

% 取消结拜不扣钱
-define(RELA_DEL_SWORN_NEED_MONEY, 0).

%% 修改称号费用
-define(RELA_MODIFY_SWORN_PRE_NEED_MONEY, 888).

%% 称号前缀唯一费用：666金子
-define(RELA_MAKE_SWORN_PRE_ONLY, 666).

-define(RELA_SWORN_COM_MONEY, 888).
-define(RELA_SWORN_HIGH_MONEY, 2888).

-define(RELA_MIN_PREFIX_LEN, 2).    % 结拜最小称号前缀长度
-define(RELA_MAX_PREFIX_LEN, 2).    % 结拜最大称号前缀长度
-define(RELA_MAX_PREFIX_LEN1, 5).    % 结拜最大称号前缀长度
-define(RELA_MAX_SWORN_LEN, 7).     % 结拜最大称号长度8字

%% 结拜类型：普通结拜 与 生死结拜
-define(RELA_SWORN_TYPE_NONE, 0).
-define(RELA_SWORN_TYPE_COM, 1).
-define(RELA_SWORN_TYPE_HIGH, 2).

-define(RELA_MAX_INTIMACY_BT, 1000).

-define(RELA_JOIN_COUPLE_LV, 25).

% 朋友之间决斗减少友好度
-define(RELA_KILL_DEL_INTIMACY, 45).

%% 婚姻系统相关
-define(COUPLE_CRUISE_PROCESS, couple_cruise_process).

-endif.  %% __RELATION_H__
