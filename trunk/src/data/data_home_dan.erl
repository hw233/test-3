%%%---------------------------------------
%%% @Module  : data_home_dan
%%% @Author  : dsh
%%% @Email   : 
%%% @Description:  炼丹炉配置表
%%%---------------------------------------


-module(data_home_dan).

-include("home.hrl").
-include("debug.hrl").
-compile(export_all).

get(1) ->
	#home_dan{
		no = 1,
		lv = 1,
		home_lv_limit = 1,
		upgrade_money = {2, 0},
		lattice_num = 1,
		pellet = [{50366}],
		force_time = {0,30,60,120},
		force_proba = {80,60,10,3},
		inject_effect = {0,2,3,4},
		inject_effect_proba = {80,60,10,3}
};

get(2) ->
	#home_dan{
		no = 2,
		lv = 2,
		home_lv_limit = 1,
		upgrade_money = {2, 1000},
		lattice_num = 2,
		pellet = [{50366,50038}],
		force_time = {0,30,60,120},
		force_proba = {80,60,10,3},
		inject_effect = {0,2,3,4},
		inject_effect_proba = {80,60,10,3}
};

get(3) ->
	#home_dan{
		no = 3,
		lv = 3,
		home_lv_limit = 2,
		upgrade_money = {2, 2000},
		lattice_num = 3,
		pellet = [{50366,50038,20013}],
		force_time = {0,30,60,120},
		force_proba = {80,60,10,3},
		inject_effect = {0,2,3,4},
		inject_effect_proba = {80,60,10,3}
};

get(4) ->
	#home_dan{
		no = 4,
		lv = 4,
		home_lv_limit = 2,
		upgrade_money = {2, 2000},
		lattice_num = 4,
		pellet = [{50366,50038,20013,60101}],
		force_time = {0,30,60,120},
		force_proba = {80,60,10,3},
		inject_effect = {0,2,3,4},
		inject_effect_proba = {80,60,10,3}
};

get(5) ->
	#home_dan{
		no = 5,
		lv = 5,
		home_lv_limit = 3,
		upgrade_money = {2, 3000},
		lattice_num = 6,
		pellet = [{50366,50038,20013,60101,50307,60039}],
		force_time = {0,30,60,120},
		force_proba = {80,60,10,3},
		inject_effect = {0,2,3,4},
		inject_effect_proba = {80,60,10,3}
};

get(6) ->
	#home_dan{
		no = 6,
		lv = 6,
		home_lv_limit = 3,
		upgrade_money = {2, 3000},
		lattice_num = 8,
		pellet = [{50366,50038,20013,60101,50307,60039,10043,60028}],
		force_time = {0,30,60,120},
		force_proba = {80,60,10,3},
		inject_effect = {0,2,3,4},
		inject_effect_proba = {80,60,10,3}
};

get(_No) ->
	      ?ASSERT(false, _No),
          null.

