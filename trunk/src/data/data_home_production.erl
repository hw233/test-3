%%%---------------------------------------
%%% @Module  : data_home_production
%%% @Author  : dsh
%%% @Email   : 
%%% @Description:  家园产出配置表
%%%---------------------------------------


-module(data_home_production).

-include("home.hrl").
-include("debug.hrl").
-compile(export_all).

get(62413) ->
	#home_production{
		no = 62413,
		type = 1,
		cost = {62419,3},
		production_num = 30,
		seedling = 1,
		growth = 5,
		maturity = 5,
		withering = 9999,
		reward_upgrade = {62413,62435,62436,62437},
		reward_broadcast = 365,
		mon_broadcast = 368,
		mon = 35163,
		mon_proba = 50,
		mon_xy = [{6,38},{13,30},{5,26},{6,53},{21,59}]
};

get(62414) ->
	#home_production{
		no = 62414,
		type = 1,
		cost = {62420,3},
		production_num = 30,
		seedling = 1,
		growth = 5,
		maturity = 5,
		withering = 9999,
		reward_upgrade = {62414,62438,62439,62440},
		reward_broadcast = 365,
		mon_broadcast = 368,
		mon = 35163,
		mon_proba = 50,
		mon_xy = [{6,38},{13,30},{5,26},{6,53},{21,59}]
};

get(62415) ->
	#home_production{
		no = 62415,
		type = 1,
		cost = {62421,5},
		production_num = 30,
		seedling = 2,
		growth = 5,
		maturity = 6,
		withering = 9999,
		reward_upgrade = {62415,62441,62442,62443},
		reward_broadcast = 365,
		mon_broadcast = 368,
		mon = 35163,
		mon_proba = 50,
		mon_xy = [{6,38},{13,30},{5,26},{6,53},{21,59}]
};

get(62416) ->
	#home_production{
		no = 62416,
		type = 1,
		cost = {62422,5},
		production_num = 30,
		seedling = 2,
		growth = 5,
		maturity = 6,
		withering = 9999,
		reward_upgrade = {62416,62444,62445,62446},
		reward_broadcast = 365,
		mon_broadcast = 368,
		mon = 35163,
		mon_proba = 50,
		mon_xy = [{6,38},{13,30},{5,26},{6,53},{21,59}]
};

get(62417) ->
	#home_production{
		no = 62417,
		type = 1,
		cost = {62423,7},
		production_num = 20,
		seedling = 3,
		growth = 5,
		maturity = 7,
		withering = 9999,
		reward_upgrade = {62417,62447,62448,62449},
		reward_broadcast = 365,
		mon_broadcast = 368,
		mon = 35163,
		mon_proba = 50,
		mon_xy = [{6,38},{13,30},{5,26},{6,53},{21,59}]
};

get(62418) ->
	#home_production{
		no = 62418,
		type = 1,
		cost = {62424,7},
		production_num = 20,
		seedling = 3,
		growth = 5,
		maturity = 7,
		withering = 9999,
		reward_upgrade = {62418,62450,62451,62452},
		reward_broadcast = 365,
		mon_broadcast = 368,
		mon = 35163,
		mon_proba = 50,
		mon_xy = [{6,38},{13,30},{5,26},{6,53},{21,59}]
};

get(50366) ->
	#home_production{
		no = 50366,
		type = 2,
		cost = [{62413,40},{62425,40}],
		production_num = 40,
		seedling = 6,
		growth = 0,
		maturity = 0,
		withering = 0,
		reward_upgrade = 0,
		reward_broadcast = 366,
		mon_broadcast = 369,
		mon = 35164,
		mon_proba = 50,
		mon_xy = [{35,57},{38,46},{47,46},{54,53},{50,58}]
};

get(50038) ->
	#home_production{
		no = 50038,
		type = 2,
		cost = [{62414,40},{62426,40}],
		production_num = 40,
		seedling = 6,
		growth = 0,
		maturity = 0,
		withering = 0,
		reward_upgrade = 0,
		reward_broadcast = 366,
		mon_broadcast = 369,
		mon = 35164,
		mon_proba = 50,
		mon_xy = [{35,57},{38,46},{47,46},{54,53},{50,58}]
};

get(20013) ->
	#home_production{
		no = 20013,
		type = 2,
		cost = [{62415,30},{62427,30}],
		production_num = 30,
		seedling = 7,
		growth = 0,
		maturity = 0,
		withering = 0,
		reward_upgrade = 0,
		reward_broadcast = 366,
		mon_broadcast = 369,
		mon = 35164,
		mon_proba = 50,
		mon_xy = [{35,57},{38,46},{47,46},{54,53},{50,58}]
};

get(60101) ->
	#home_production{
		no = 60101,
		type = 2,
		cost = [{62416,30},{62428,30}],
		production_num = 30,
		seedling = 7,
		growth = 0,
		maturity = 0,
		withering = 0,
		reward_upgrade = 0,
		reward_broadcast = 366,
		mon_broadcast = 369,
		mon = 35164,
		mon_proba = 50,
		mon_xy = [{35,57},{38,46},{47,46},{54,53},{50,58}]
};

get(50307) ->
	#home_production{
		no = 50307,
		type = 2,
		cost = [{62417,30},{62429,30}],
		production_num = 30,
		seedling = 8,
		growth = 0,
		maturity = 0,
		withering = 0,
		reward_upgrade = 0,
		reward_broadcast = 366,
		mon_broadcast = 369,
		mon = 35164,
		mon_proba = 50,
		mon_xy = [{35,57},{38,46},{47,46},{54,53},{50,58}]
};

get(60039) ->
	#home_production{
		no = 60039,
		type = 2,
		cost = [{62417,20},{62429,20}],
		production_num = 20,
		seedling = 8,
		growth = 0,
		maturity = 0,
		withering = 0,
		reward_upgrade = 0,
		reward_broadcast = 366,
		mon_broadcast = 369,
		mon = 35164,
		mon_proba = 50,
		mon_xy = [{35,57},{38,46},{47,46},{54,53},{50,58}]
};

get(10043) ->
	#home_production{
		no = 10043,
		type = 2,
		cost = [{62418,30},{62430,30}],
		production_num = 30,
		seedling = 8,
		growth = 0,
		maturity = 0,
		withering = 0,
		reward_upgrade = 0,
		reward_broadcast = 366,
		mon_broadcast = 369,
		mon = 35164,
		mon_proba = 50,
		mon_xy = [{35,57},{38,46},{47,46},{54,53},{50,58}]
};

get(60028) ->
	#home_production{
		no = 60028,
		type = 2,
		cost = [{62418,10},{62430,10}],
		production_num = 20,
		seedling = 8,
		growth = 0,
		maturity = 0,
		withering = 0,
		reward_upgrade = 0,
		reward_broadcast = 366,
		mon_broadcast = 369,
		mon = 35164,
		mon_proba = 50,
		mon_xy = [{35,57},{38,46},{47,46},{54,53},{50,58}]
};

get(62425) ->
	#home_production{
		no = 62425,
		type = 3,
		cost = [{62431,3},{62432,3}],
		production_num = 30,
		seedling = 5,
		growth = 0,
		maturity = 0,
		withering = 0,
		reward_upgrade = 0,
		reward_broadcast = 367,
		mon_broadcast = 370,
		mon = 35165,
		mon_proba = 50,
		mon_xy = [{59,25},{79,22},{81,28},{72,30},{60,28}]
};

get(62426) ->
	#home_production{
		no = 62426,
		type = 3,
		cost = [{62431,3},{62432,3}],
		production_num = 30,
		seedling = 5,
		growth = 0,
		maturity = 0,
		withering = 0,
		reward_upgrade = 0,
		reward_broadcast = 367,
		mon_broadcast = 370,
		mon = 35165,
		mon_proba = 50,
		mon_xy = [{59,25},{79,22},{81,28},{72,30},{60,28}]
};

get(62427) ->
	#home_production{
		no = 62427,
		type = 3,
		cost = [{62432,5},{62433,5}],
		production_num = 30,
		seedling = 6,
		growth = 0,
		maturity = 0,
		withering = 0,
		reward_upgrade = 0,
		reward_broadcast = 367,
		mon_broadcast = 370,
		mon = 35165,
		mon_proba = 50,
		mon_xy = [{59,25},{79,22},{81,28},{72,30},{60,28}]
};

get(62428) ->
	#home_production{
		no = 62428,
		type = 3,
		cost = [{62432,5},{62433,5}],
		production_num = 30,
		seedling = 6,
		growth = 0,
		maturity = 0,
		withering = 0,
		reward_upgrade = 0,
		reward_broadcast = 367,
		mon_broadcast = 370,
		mon = 35165,
		mon_proba = 50,
		mon_xy = [{59,25},{79,22},{81,28},{72,30},{60,28}]
};

get(62429) ->
	#home_production{
		no = 62429,
		type = 3,
		cost = [{62433,7},{62434,7}],
		production_num = 20,
		seedling = 7,
		growth = 0,
		maturity = 0,
		withering = 0,
		reward_upgrade = 0,
		reward_broadcast = 367,
		mon_broadcast = 370,
		mon = 35165,
		mon_proba = 50,
		mon_xy = [{59,25},{79,22},{81,28},{72,30},{60,28}]
};

get(62430) ->
	#home_production{
		no = 62430,
		type = 3,
		cost = [{62433,7},{62434,7}],
		production_num = 20,
		seedling = 7,
		growth = 0,
		maturity = 0,
		withering = 0,
		reward_upgrade = 0,
		reward_broadcast = 367,
		mon_broadcast = 370,
		mon = 35165,
		mon_proba = 50,
		mon_xy = [{59,25},{79,22},{81,28},{72,30},{60,28}]
};

get(_No) ->
	      ?ASSERT(false, _No),
          null.

