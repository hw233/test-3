%%%-------------------------------------------------------------------
%%% @author wujiancheng
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 09. 七月 2019 21:00
%%%-------------------------------------------------------------------
-author("wujiancheng").


%% 避免头文件多重包含
-ifndef(__PT_FABAO_H__).
-define(__PT_FABAO_H__, 0).

-define(MAX_STAR_LIMIT_LV, 6).  %% 升星最大等级
-define(MAX_FUYIN_MOSAIC_LIMIT_NUM, 3). %% 单类型符印槽最大镶嵌个数
-define(MAX_FUYIN_LIMIT_NUM, 9999). %% 单个符印最多叠加数量

%% 法宝符印基础属性加成
-define(FUYIN_TYPE_PHY_ATT, 1).				   %% 物理攻击值
-define(FUYIN_TYPE_MAG_ATT, 2).				   %% 法术攻击值
-define(FUYIN_TYPE_PHY_DEF, 3).				   %% 物理防御值
-define(FUYIN_TYPE_MAG_DEF, 4).				   %% 法术防御值
-define(FUYIN_TYPE_HP_LIM, 5).				   %% 生命上限值
-define(FUYIN_TYPE_ACT_SPEED, 6).              %% 速度值
-define(FUYIN_TYPE_SEAL_HIT, 7).			   %% 封印命中值
-define(FUYIN_TYPE_SEAL_RESIS, 8).			   %% 抗封印命中值
-define(FUYIN_TYPE_HEAL_VALUE, 9).             %% 治疗强度

-record(fabao_base_attr_growth_ratio, {
  no = 1,
  attr = [],
  growth_ratio_min = 0.100000,
  growth_ratio_max = 1.200000,
  float_value = 300,
  growth_ratio_wash_goods = {},
  diagrams_attr = {},
  rune_lv_limit = 1
}).


-record(fabao_config , {
  no = 60001,
  type = 1,
  sp_value = 500,
  sp_value_cost = 0,
  compose_need = [{20003,200}],
  attr = {act_speed, mp_lim},
  step_need_goods = [],
  step_need_num = []
}).


-record(fabao_info, {
  id = 0,
  player_id = 0,
  no = 0,
  star_num =0,
  degree =0,
  type =0,
  sp_value = 0,
  displayer = 0 ,
  battle = 0,
  degree_num = 1,
  degree_pro = 0 ,
  cultivate_pro =0 ,
  is_identify = 2,
  eight_diagrams = [],
  skill_num =0,
  skill_array_1 = 0,
  skill_array_2 = 0,
  skill_array_3 =0 ,
  magic_power = [],
  fu_yin = [],
  is_dirty = false
}).


-record(fabao_advance,{
  no = 1,
  lv = 1,
  layer = 1,
  cultivate_next_lv_need = 0,
  get_cultivate = 1,
  alchemy_no = 0,
  alchemy_num = 0,
  bind_gamemoney = {}
}).

-record(fabao_goods_exchange, {
  no = 1,
  type = 1,
  exchange_goods = [],
  exchange_goods_num = 10,
  get_goods = [],
  get_goods_num = 1
}).

-record(fabao_change_anim, {
  no = 60001,
  type = 1,
  get_price = 0
}).

-record(fabao_fuyin, {
  id = 0,            %% 符印id
  player_id = 0,     %% 玩家id
  no = 0,            %% 玩家编号
  fabao_id = 0,      %% 法宝编号
  count = 0,         %% 叠加数量
  type = 0,          %% 符印类型：1风2火3雷
  lv = 1,            %% 符印等级
  position = 0       %% 镶嵌位置：123
}).

-record(fabao_rune_attr, {
  no = 70243,
  attr_type = 2,
  set_type = 1,
  lv = 1,
  ratio = 540
}).

-record(fabao_rune_combin_effect, {
  no = 70101,
  rune_combin_num = 3,
  rune_combin_effect = [{act_speed, 0, 0.03}]
}).

-record(fabao_rune_compose, {
  no = 0,
  need_goods_num = 0,
  get_goods_no = 0,
  money = []
}).

-record(fabao_diagrams_attr, {
  no = 1,
  name = <<"乾卦属性">>,
  attr= 0,
  fabao_star_lv ,
  attr2_chance = 300,
  effect2_chance = 0,
  effect1 = [],
  effect2 = [],
  identify_cost = [{120044,100}],
  identify_price = [{2,200}],
  wash_cost = [{120045,50}],
  wash_price = [{1,1000000}],
  reset_cost = [{120046,100}],
  reset_price = [{2,50}]
}).

-record(flashprint, {
  type = 0,
  fuyin_id1 = 0,
  fuyin_no1 = 0,
  fuyin_id2 = 0,
  fuyin_no2 = 0,
  fuyin_id3 = 0,
  fuyin_no3 = 0
}).

-record(fabao_magic_skill, {
  no = 1,
  fabao_no = 60001,
  advance_no = 1,
  magic_skill_no = 1,
  learn_condition = [],
  magic_skill = [],
  skill_point_cost = 0,
  skill_point_extra_cost = [],
  money = []
}).

-record(fabao_magic_skill_attr_value,{
  lv = 1,
  attr_value = [{0,1000},{1,75},{2,0,0.01},{3,0,0.01},{4,0,10},{5,0,0.01}]
}).

-endif.

