%%%---------------------------------------
%%% @Module  : data_damijing_config
%%% @Author  : lzx
%%% @Email   : 
%%% @Description: 大秘境关卡设定表
%%%---------------------------------------


-module(data_damijing_config).
-compile(export_all).

-include("damijing.hrl").
-include("debug.hrl").

get(10001) ->
	#damijing_config{
		no = 10001,
		type = 1,
		degree = 1,
		lv = 120,
		cost = {62576,  5},
		spawn_mon_type = 1,
		mon_pool_elite = [5, 7, 9],
		diamond_card = 91678,
		gold_card = 91679,
		silver_card = 91680,
		copper_card = 91681,
		more_card_price = [{1,1,0},{2,2,800},{3,14,100},{4,14,200}],
		teammate_card = 91702
};

get(10002) ->
	#damijing_config{
		no = 10002,
		type = 1,
		degree = 2,
		lv = 180,
		cost = {62577, 10},
		spawn_mon_type = 1,
		mon_pool_elite = [16, 19, 21, 23, 25],
		diamond_card = 91682,
		gold_card = 91683,
		silver_card = 91684,
		copper_card = 91685,
		more_card_price = [{1,1,0},{2,2,800},{3,14,100},{4,14,200}],
		teammate_card = 91703
};

get(10003) ->
	#damijing_config{
		no = 10003,
		type = 1,
		degree = 3,
		lv = 250,
		cost = {62578, 15},
		spawn_mon_type = 1,
		mon_pool_elite = [31, 34, 37, 39, 41, 43, 45],
		diamond_card = 91686,
		gold_card = 91687,
		silver_card = 91688,
		copper_card = 91689,
		more_card_price = [{1,1,0},{2,2,800},{3,14,100},{4,14,200}],
		teammate_card = 91704
};

get(10011) ->
	#damijing_config{
		no = 10011,
		type = 2,
		degree = 1,
		lv = 120,
		cost = {62579,  5},
		spawn_mon_type = 2,
		mon_pool_elite = [[48, 49, 51, 52, 54, 55, 57, 58, 60, 61, 63, 64, 65] , 9],
		diamond_card = 91690,
		gold_card = 91691,
		silver_card = 91692,
		copper_card = 91693,
		more_card_price = [{1,1,0},{2,2,800},{3,14,100},{4,14,200}],
		teammate_card = 91705
};

get(10012) ->
	#damijing_config{
		no = 10012,
		type = 2,
		degree = 2,
		lv = 180,
		cost = {62580, 10},
		spawn_mon_type = 2,
		mon_pool_elite = [[68, 69, 71, 72, 74, 75, 77, 78, 80, 81, 83, 84, 86, 87, 89, 90] , 12],
		diamond_card = 91694,
		gold_card = 91695,
		silver_card = 91696,
		copper_card = 91697,
		more_card_price = [{1,1,0},{2,2,800},{3,14,100},{4,14,200}],
		teammate_card = 91706
};

get(10013) ->
	#damijing_config{
		no = 10013,
		type = 2,
		degree = 3,
		lv = 250,
		cost = {62581, 15},
		spawn_mon_type = 2,
		mon_pool_elite = [[93, 94, 96, 97, 99, 100, 102, 103, 105, 106, 108, 109, 111, 112, 114, 115, 116, 118, 119, 120] , 15],
		diamond_card = 91698,
		gold_card = 91699,
		silver_card = 91700,
		copper_card = 91701,
		more_card_price = [{1,1,0},{2,2,800},{3,14,100},{4,14,200}],
		teammate_card = 91707
};

get(_No) ->
	?ASSERT(false, {_No}),
    null.

get_mystery_no()->
	[10001,10002,10003].

get_mriage_no()->
	[10011,10012,10013].

