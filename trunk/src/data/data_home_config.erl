%%%---------------------------------------
%%% @Module  : data_home_config
%%% @Author  : dsh
%%% @Email   : 
%%% @Description:  家园配置表
%%%---------------------------------------


-module(data_home_config).

-include("home.hrl").
-include("debug.hrl").
-compile(export_all).

get(1) ->
	#home_config{
		no = 1,
		lv = 1,
		lv_limit = 93,
		upgrade_money = {2, 10000},
		home_xy = {53, 38},
		land_xy = {20, 37},
		alchemy_furnace_xy = {40, 45},
		mine_xy = {55, 20},
		luxury = 50
};

get(2) ->
	#home_config{
		no = 2,
		lv = 2,
		lv_limit = 120,
		upgrade_money = {2, 50000},
		home_xy = {53, 38},
		land_xy = {20, 37},
		alchemy_furnace_xy = {40, 45},
		mine_xy = {55, 20},
		luxury = 0
};

get(3) ->
	#home_config{
		no = 3,
		lv = 3,
		lv_limit = 150,
		upgrade_money = {2, 100000},
		home_xy = {53, 38},
		land_xy = {20, 37},
		alchemy_furnace_xy = {40, 45},
		mine_xy = {55, 20},
		luxury = 0
};

get(_No) ->
	      ?ASSERT(false, _No),
          null.

