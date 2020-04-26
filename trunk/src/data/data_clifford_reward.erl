%%%---------------------------------------
%%% @Module  : data_clifford_reward
%%% @Author  : duansh
%%% @Email   : 
%%% @Description: 福源
%%%---------------------------------------


-module(data_clifford_reward).
-export([
        get_config_by_type/1,
        get/1
    ]).

-include("clifford.hrl").
-include("debug.hrl").

get_all_type_list()->
	[0,1].

get_config_by_type(0)->
	[1,2,3,4,5,6,7,8];
get_config_by_type(1)->
	[11,12,13,14,15,16,17,18].

get(1) ->
	#clifford_reward{
		no = 1,
		type = 0,
		reward = 44508,
		widget = 100,
		normal_widget = 50
};

get(2) ->
	#clifford_reward{
		no = 2,
		type = 0,
		reward = 44509,
		widget = 60,
		normal_widget = 50
};

get(3) ->
	#clifford_reward{
		no = 3,
		type = 0,
		reward = 44510,
		widget = 50,
		normal_widget = 20
};

get(4) ->
	#clifford_reward{
		no = 4,
		type = 0,
		reward = 44511,
		widget = 50,
		normal_widget = 100
};

get(5) ->
	#clifford_reward{
		no = 5,
		type = 0,
		reward = 44512,
		widget = 100,
		normal_widget = 50
};

get(6) ->
	#clifford_reward{
		no = 6,
		type = 0,
		reward = 44513,
		widget = 100,
		normal_widget = 50
};

get(7) ->
	#clifford_reward{
		no = 7,
		type = 0,
		reward = 44514,
		widget = 30,
		normal_widget = 40
};

get(8) ->
	#clifford_reward{
		no = 8,
		type = 0,
		reward = 44515,
		widget = 30,
		normal_widget = 40
};

get(11) ->
	#clifford_reward{
		no = 11,
		type = 1,
		reward = 44516,
		widget = 30,
		normal_widget = 20
};

get(12) ->
	#clifford_reward{
		no = 12,
		type = 1,
		reward = 44551,
		widget = 60,
		normal_widget = 20
};

get(13) ->
	#clifford_reward{
		no = 13,
		type = 1,
		reward = 44552,
		widget = 10,
		normal_widget = 10
};

get(14) ->
	#clifford_reward{
		no = 14,
		type = 1,
		reward = 44553,
		widget = 50,
		normal_widget = 20
};

get(15) ->
	#clifford_reward{
		no = 15,
		type = 1,
		reward = 44554,
		widget = 30,
		normal_widget = 10
};

get(16) ->
	#clifford_reward{
		no = 16,
		type = 1,
		reward = 44555,
		widget = 40,
		normal_widget = 40
};

get(17) ->
	#clifford_reward{
		no = 17,
		type = 1,
		reward = 44556,
		widget = 10,
		normal_widget = 20
};

get(18) ->
	#clifford_reward{
		no = 18,
		type = 1,
		reward = 44600,
		widget = 30,
		normal_widget = 30
};

get(_No) ->
				?ASSERT(false, _No),
				null.

