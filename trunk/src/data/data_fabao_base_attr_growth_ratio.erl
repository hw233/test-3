%%%---------------------------------------
%%% @Module  : data_fabao_base_attr_growth_ratio
%%% @Author  : lzx
%%% @Email   : 
%%% @Description: 法宝基础属性及成长率关系表
%%%---------------------------------------


-module(data_fabao_base_attr_growth_ratio).
-compile(export_all).
-include("fabao.hrl").
-include("debug.hrl").

get(1) ->
	#fabao_base_attr_growth_ratio{
		no = 1,
		attr = [{hp_lim,800,0},{mp_lim,800,0},{phy_att,500,0},{mag_att,500,0},{phy_def,500,0},{mag_def,500,0},{act_speed,50,0}],
		growth_ratio_min = 0.100000,
		growth_ratio_max = 1.200000,
		float_value = 300,
		growth_ratio_wash_goods = {120054,50},
		diagrams_attr = {1, 2},
		rune_lv_limit = 1
};

get(2) ->
	#fabao_base_attr_growth_ratio{
		no = 2,
		attr = [{hp_lim,810,0},{mp_lim,810,0},{phy_att,510,0},{mag_att,510,0},{phy_def,550,0},{mag_def,550,0},{act_speed,60,0}],
		growth_ratio_min = 0.100000,
		growth_ratio_max = 1.600000,
		float_value = 320,
		growth_ratio_wash_goods = {120054,50},
		diagrams_attr = {3, 4},
		rune_lv_limit = 2
};

get(3) ->
	#fabao_base_attr_growth_ratio{
		no = 3,
		attr = [{hp_lim,820,0},{mp_lim,820,0},{phy_att,520,0},{mag_att,520,0},{phy_def,600,0},{mag_def,600,0},{act_speed,70,0}],
		growth_ratio_min = 0.100000,
		growth_ratio_max = 2,
		float_value = 340,
		growth_ratio_wash_goods = {120054,50},
		diagrams_attr = {9},
		rune_lv_limit = 3
};

get(4) ->
	#fabao_base_attr_growth_ratio{
		no = 4,
		attr = [{hp_lim,830,0},{mp_lim,830,0},{phy_att,530,0},{mag_att,530,0},{phy_def,650,0},{mag_def,650,0},{act_speed,80,0}],
		growth_ratio_min = 0.100000,
		growth_ratio_max = 2.400000,
		float_value = 360,
		growth_ratio_wash_goods = {120054,50},
		diagrams_attr = {5, 6},
		rune_lv_limit = 4
};

get(5) ->
	#fabao_base_attr_growth_ratio{
		no = 5,
		attr = [{hp_lim,840,0},{mp_lim,840,0},{phy_att,540,0},{mag_att,540,0},{phy_def,700,0},{mag_def,700,0},{act_speed,90,0}],
		growth_ratio_min = 0.100000,
		growth_ratio_max = 2.800000,
		float_value = 380,
		growth_ratio_wash_goods = {120054,50},
		diagrams_attr = {7, 8},
		rune_lv_limit = 5
};

get(6) ->
	#fabao_base_attr_growth_ratio{
		no = 6,
		attr = [{hp_lim,850,0},{mp_lim,850,0},{phy_att,550,0},{mag_att,550,0},{phy_def,750,0},{mag_def,750,0},{act_speed,100,0}],
		growth_ratio_min = 0.100000,
		growth_ratio_max = 3.200000,
		float_value = 400,
		growth_ratio_wash_goods = {120054,50},
		diagrams_attr = {10},
		rune_lv_limit = 6
};

get(_No) ->
	?ASSERT(false, {_No}),
    null.

