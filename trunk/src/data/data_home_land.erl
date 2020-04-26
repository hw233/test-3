%%%---------------------------------------
%%% @Module  : data_home_land
%%% @Author  : dsh
%%% @Email   : 
%%% @Description:  土地配置表
%%%---------------------------------------


-module(data_home_land).

-include("home.hrl").
-include("debug.hrl").
-compile(export_all).

get(1) ->
	#home_land{
		no = 1,
		lv = 1,
		home_lv_limit = 1,
		upgrade_money = {1, 0},
		lattice_num = 1,
		herb = [{62413}],
		advance_time = {0,30,60,120},
		advance_proba = {80,60,10,3},
		insecticide_effect = {0,2,3,4},
		insecticide_effect_proba = {80,60,10,3},
		reward_upgrade_proba = {80,60,10,3}
};

get(2) ->
	#home_land{
		no = 2,
		lv = 2,
		home_lv_limit = 1,
		upgrade_money = {1, 100000},
		lattice_num = 2,
		herb = [{62413,62414}],
		advance_time = {0,30,60,120},
		advance_proba = {80,60,10,3},
		insecticide_effect = {0,2,3,4},
		insecticide_effect_proba = {80,60,10,3},
		reward_upgrade_proba = {80,60,10,3}
};

get(3) ->
	#home_land{
		no = 3,
		lv = 3,
		home_lv_limit = 2,
		upgrade_money = {1, 200000},
		lattice_num = 3,
		herb = [{62413,62414,62415}],
		advance_time = {0,30,60,120},
		advance_proba = {80,60,10,3},
		insecticide_effect = {0,2,3,4},
		insecticide_effect_proba = {80,60,10,3},
		reward_upgrade_proba = {80,60,10,3}
};

get(4) ->
	#home_land{
		no = 4,
		lv = 4,
		home_lv_limit = 2,
		upgrade_money = {1, 200000},
		lattice_num = 4,
		herb = [{62413,62414,62415,62416}],
		advance_time = {0,30,60,120},
		advance_proba = {80,60,10,3},
		insecticide_effect = {0,2,3,4},
		insecticide_effect_proba = {80,60,10,3},
		reward_upgrade_proba = {80,60,10,3}
};

get(5) ->
	#home_land{
		no = 5,
		lv = 5,
		home_lv_limit = 3,
		upgrade_money = {1, 300000},
		lattice_num = 5,
		herb = [{62413,62414,62415,62416,62417}],
		advance_time = {0,30,60,120},
		advance_proba = {80,60,10,3},
		insecticide_effect = {0,2,3,4},
		insecticide_effect_proba = {80,60,10,3},
		reward_upgrade_proba = {80,60,10,3}
};

get(6) ->
	#home_land{
		no = 6,
		lv = 6,
		home_lv_limit = 3,
		upgrade_money = {1, 300000},
		lattice_num = 6,
		herb = [{62413,62414,62415,62416,62417,62418}],
		advance_time = {0,30,60,120},
		advance_proba = {80,60,10,3},
		insecticide_effect = {0,2,3,4},
		insecticide_effect_proba = {80,60,10,3},
		reward_upgrade_proba = {80,60,10,3}
};

get(_No) ->
	      ?ASSERT(false, _No),
          null.

