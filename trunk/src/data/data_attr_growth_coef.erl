%%%---------------------------------------
%%% @Module  : data_attr_growth_coef
%%% @Author  : huangjf
%%% @Email   : 
%%% @Description: 角色属性成长系数配置表
%%%---------------------------------------


-module(data_attr_growth_coef).
-export([get/1]).
-include("player.hrl").
-include("debug.hrl").

get(1) ->
	#attr_growth_coef{
		no = 1,
		hp = 1200,
		mp = 0,
		phy_att = 0,
		mag_att = 0,
		phy_def = 0,
		mag_def = 40,
		act_speed = 0,
		seal_hit = 0,
		seal_resis = 32,
		heal_value = 0,
		hit = 0,
		dodge = 0,
		crit = 0,
		ten = 0
};

get(2) ->
	#attr_growth_coef{
		no = 2,
		hp = 0,
		mp = 0,
		phy_att = 120,
		mag_att = 0,
		phy_def = 0,
		mag_def = 40,
		act_speed = 6,
		seal_hit = 12,
		seal_resis = 0,
		heal_value = 0,
		hit = 0,
		dodge = 0,
		crit = 0,
		ten = 0
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
		act_speed = 30,
		seal_hit = 32,
		seal_resis = 0,
		heal_value = 0,
		hit = 0,
		dodge = 0,
		crit = 0,
		ten = 0
};

get(4) ->
	#attr_growth_coef{
		no = 4,
		hp = 0,
		mp = 0,
		phy_att = 0,
		mag_att = 120,
		phy_def = 0,
		mag_def = 138,
		act_speed = 6,
		seal_hit = 0,
		seal_resis = 0,
		heal_value = 0,
		hit = 0,
		dodge = 0,
		crit = 0,
		ten = 0
};

get(5) ->
	#attr_growth_coef{
		no = 5,
		hp = 0,
		mp = 0,
		phy_att = 0,
		mag_att = 0,
		phy_def = 240,
		mag_def = 40,
		act_speed = 0,
		seal_hit = 0,
		seal_resis = 32,
		heal_value = 0,
		hit = 0,
		dodge = 0,
		crit = 0,
		ten = 0
};

get(_No) ->
	      ?ASSERT(false, _No),
          null.

