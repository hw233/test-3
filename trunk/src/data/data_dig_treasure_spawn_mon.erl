%%%---------------------------------------
%%% @Module  : data_dig_treasure_spawn_mon
%%% @Author  : zhangwq
%%% @Email   : 
%%% @Description: 挖宝事件之刷出明雷怪
%%%---------------------------------------


-module(data_dig_treasure_spawn_mon).
-compile(export_all).

-include("effect.hrl").
-include("debug.hrl").

get_all_lv_step_no()->
	[1,2,3,4,5].

get(1) ->
	#spawn_mon{
		step = 1,
		mon_no = 0,
		mon_count = 0,
		scene_no = 0,
		lv_region = [20,29]
};

get(2) ->
	#spawn_mon{
		step = 2,
		mon_no = 0,
		mon_count = 0,
		scene_no = 0,
		lv_region = [30,39]
};

get(3) ->
	#spawn_mon{
		step = 3,
		mon_no = 0,
		mon_count = 0,
		scene_no = 0,
		lv_region = [40,49]
};

get(4) ->
	#spawn_mon{
		step = 4,
		mon_no = 0,
		mon_count = 0,
		scene_no = 0,
		lv_region = [50,59]
};

get(5) ->
	#spawn_mon{
		step = 5,
		mon_no = 0,
		mon_count = 0,
		scene_no = 0,
		lv_region = [60,69]
};

get(_Step) ->
	?ASSERT(false, {_Step}),
    null.

