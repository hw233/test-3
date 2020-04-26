%%%---------------------------------------
%%% @Module  : data_o2o_battle_add_attrs
%%% @Author  : huangjf
%%% @Email   : 
%%% @Description: “在线打离线竞技场”战斗的离线方属性加成配置表 online to offline
%%%---------------------------------------


-module(data_o2o_battle_add_attrs).
-export([get/1]).
-include("record/battle_record.hrl").
-include("debug.hrl").


get(1) ->
	#o2o_bt_add_attrs{
		bt_type_code = 1,
		do_phy_dam_scaling = 0.050000,
		do_mag_dam_scaling = 0.050000,
		be_phy_dam_reduce_coef = 0.050000,
		be_mag_dam_reduce_coef = 0.050000,
		be_heal_eff_coef = 0.050000,
		act_speed_rate = 0.050000,
		seal_hit_rate = 0.050000,
		seal_resis_rate = 0.050000
};

get(2) ->
	#o2o_bt_add_attrs{
		bt_type_code = 2,
		do_phy_dam_scaling = 0.050000,
		do_mag_dam_scaling = 0.050000,
		be_phy_dam_reduce_coef = 0.050000,
		be_mag_dam_reduce_coef = 0.050000,
		be_heal_eff_coef = 0.050000,
		act_speed_rate = 0.050000,
		seal_hit_rate = 0.050000,
		seal_resis_rate = 0.050000
};

get(_BT_Type) ->
	      ?ASSERT(false, _BT_Type),
          null.

