%%%---------------------------------------
%%% @Module  : data_pet_attr_growth_coef
%%% @Author  : wbh
%%% @Email   : 
%%% @Description: 门客属性成长系数配置表
%%%---------------------------------------


-module(data_pet_attr_growth_coef).
-export([get/1]).
-include("player.hrl").
-include("debug.hrl").

get(1) ->
	#attr_growth_coef{
		no = 1,
		hp = 45,
		mp = 0,
		phy_att = 0,
		mag_att = 0,
		phy_def = 0,
		mag_def = 2.700000,
		act_speed = 0,
		hit = 0,
		dodge = 0,
		seal_resis = 0.540000,
		crit = 0,
		ten = 0,
		seal_hit = 0.720000,
		heal_value = 0.600000
};

get(2) ->
	#attr_growth_coef{
		no = 2,
		hp = 0,
		mp = 0,
		phy_att = 7.500000,
		mag_att = 0,
		phy_def = 0,
		mag_def = 0,
		act_speed = 1.500000,
		hit = 0,
		dodge = 0,
		seal_resis = 0.240000,
		crit = 0,
		ten = 0,
		seal_hit = 0.220000,
		heal_value = 0
};

get(3) ->
	#attr_growth_coef{
		no = 3,
		hp = 0,
		mp = 0,
		phy_att = 0,
		mag_att = 0,
		phy_def = 0,
		mag_def = 0,
		act_speed = 7.200000,
		hit = 0,
		dodge = 0,
		seal_resis = 0,
		crit = 0,
		ten = 0,
		seal_hit = 0,
		heal_value = 1.200000
};

get(4) ->
	#attr_growth_coef{
		no = 4,
		hp = 0,
		mp = 22.500000,
		phy_att = 0,
		mag_att = 5.850000,
		phy_def = 0,
		mag_def = 6,
		act_speed = 1.500000,
		hit = 0,
		dodge = 0,
		seal_resis = 0.240000,
		crit = 0,
		ten = 0,
		seal_hit = 0.220000,
		heal_value = 0.600000
};

get(5) ->
	#attr_growth_coef{
		no = 5,
		hp = 0,
		mp = 0,
		phy_att = 0,
		mag_att = 0,
		phy_def = 10.800000,
		mag_def = 0.900000,
		act_speed = 0,
		hit = 0,
		dodge = 0,
		seal_resis = 0.840000,
		crit = 0,
		ten = 0,
		seal_hit = 0.220000,
		heal_value = 0.600000
};

get(_No) ->
	      ?ASSERT(false, _No),
          null.

