%%%---------------------------------------
%%% @Module  : data_home_mine
%%% @Author  : dsh
%%% @Email   : 
%%% @Description:  矿井配置表
%%%---------------------------------------


-module(data_home_mine).

-include("home.hrl").
-include("debug.hrl").
-compile(export_all).

get(1) ->
	#home_mine{
		no = 1,
		lv = 1,
		home_lv_limit = 1,
		upgrade_money = {1, 0},
		lattice_num = 1,
		mineral = [{62425}],
		charge_time = {0,30,60,120},
		charge_proba = {80,60,10,3},
		strengthen_effect = {0,2,3,4},
		strengthen_effect_proba = {80,60,10,3}
};

get(2) ->
	#home_mine{
		no = 2,
		lv = 2,
		home_lv_limit = 1,
		upgrade_money = {1, 100000},
		lattice_num = 2,
		mineral = [{62425,62426}],
		charge_time = {0,30,60,120},
		charge_proba = {80,60,10,3},
		strengthen_effect = {0,2,3,4},
		strengthen_effect_proba = {80,60,10,3}
};

get(3) ->
	#home_mine{
		no = 3,
		lv = 3,
		home_lv_limit = 2,
		upgrade_money = {1, 200000},
		lattice_num = 3,
		mineral = [{62425,62426,62427}],
		charge_time = {0,30,60,120},
		charge_proba = {80,60,10,3},
		strengthen_effect = {0,2,3,4},
		strengthen_effect_proba = {80,60,10,3}
};

get(4) ->
	#home_mine{
		no = 4,
		lv = 4,
		home_lv_limit = 2,
		upgrade_money = {1, 200000},
		lattice_num = 4,
		mineral = [{62425,62426,62427,62428}],
		charge_time = {0,30,60,120},
		charge_proba = {80,60,10,3},
		strengthen_effect = {0,2,3,4},
		strengthen_effect_proba = {80,60,10,3}
};

get(5) ->
	#home_mine{
		no = 5,
		lv = 5,
		home_lv_limit = 3,
		upgrade_money = {1, 300000},
		lattice_num = 5,
		mineral = [{62425,62426,62427,62428,62429}],
		charge_time = {0,30,60,120},
		charge_proba = {80,60,10,3},
		strengthen_effect = {0,2,3,4},
		strengthen_effect_proba = {80,60,10,3}
};

get(6) ->
	#home_mine{
		no = 6,
		lv = 6,
		home_lv_limit = 3,
		upgrade_money = {1, 300000},
		lattice_num = 6,
		mineral = [{62425,62426,62427,62428,62429,62430}],
		charge_time = {0,30,60,120},
		charge_proba = {80,60,10,3},
		strengthen_effect = {0,2,3,4},
		strengthen_effect_proba = {80,60,10,3}
};

get(_No) ->
	      ?ASSERT(false, _No),
          null.

