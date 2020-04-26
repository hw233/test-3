%%%-------------------------------------------------------------------
%%% @author lizhipeng
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 04. 七月 2018 20:38
%%%-------------------------------------------------------------------

%% 避免头文件多重包含
-ifndef(__TRAIN_H__).
-define(__TRAIN_H__, 0).

%% 内功相关结构体
-record(role_arts, {
    id,             % 内功唯一编号(递增)
    art_no,         % 内功编号(策划给出的)
    player_id,      % 玩家ID
    partner_id,     % 武将ID(内功佩戴在武将身上时对应的武将唯一ID，0:表示自己)
    bind_state,     % 当前的绑定状态
    star,           % 内功品质(1~5星)
    lv,             % 内功等级
    exp,            % 经验
    attr_add,        % 内功属性加成,格式如：空字符串|[{属性名, 数值},...]
    pos             % 佩戴的格子顺序，不佩戴=0
}).

%% 配置结构表
-record(train_cfg, {
    no,
    cost,
    cost2,
    pool,
    upgrade_rate
}).

-record(internal_skill_upg_cost_cfg, {
    lv,
    star_1_exp,
    star_2_exp,
    star_3_exp,
    star_4_exp,
    star_5_exp,
    star_6_exp
}).

-record(train_open_cfg, {
    no,
    need_lv,
    cost = {}
}).

-record(internal_skill_cfg, {
    no,
    internal_skill_name,
    internal_skill_des,
    internal_skill_star,
    internal_skill_type,
    lv_coef
}).

-record(internal_skill_attribute_cfg, {
    lv,
    internal_correct,
    type_0,
    type_1,
    type_2,
    type_3,
    type_4,
    type_5
}).

-record(internal_skill_eat_exp_cfg, {
    lv,
    eat_1_star_exp,
    eat_2_star_exp,
    eat_3_star_exp,
    eat_4_star_exp,
    eat_5_star_exp
}).

-record(internal_skill_star_relevant_cfg, {
    no,
    coe_a,
    coe_b,
    coe_c,
    coe_d
}).

-define(ISEQUIPED, 1).
-define(ISPLAYER, 0).

-define(ONE_STAR, 1).               % 一星
-define(TWO_STAR, 2).               % 二星
-define(THREE_STAR, 3).             % 三星
-define(FOUR_STAR, 4).              % 四星
-define(FIVE_STAR, 5).              % 五星
-define(SIX_STAR, 6).               % 六星

-define(FORTY, 40).
-define(FIFTY, 50).
-define(SIXTY, 60).
-define(SEVENTY, 70).
-define(EIGHTY, 80).
-define(NINETY, 90).
-define(HUNDRED, 100).

%% 配置文件
-define(TYPE_0, 0).
-define(TYPE_1, 1).
-define(TYPE_2, 2).
-define(TYPE_3, 3).
-define(TYPE_4, 4).
-define(TYPE_5, 5).


-endif.  %% __BATTLE_RECORD_H__
