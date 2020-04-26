%%%---------------------------------------
%%% @Module  : data_couple
%%% @Author  : zwq
%%% @Email   : 
%%% @Description:  婚姻系统
%%%---------------------------------------


-module(data_couple).
-include("common.hrl").
-include("record.hrl").
-include("relation.hrl").
-compile(export_all).

get_type_list_by_key(marry)->
	[1,2,3];
get_type_list_by_key(learn_skill)->
	[40001,40002,40003];
get_type_list_by_key(cruise)->
	[1,2,3];
get_type_list_by_key(divorce)->
	[1,2,3].

get_title_no_list_by_key(marry)->
	[62005,62006,62007];
get_title_no_list_by_key(learn_skill)->
	[0,0,0];
get_title_no_list_by_key(cruise)->
	[0,0,0];
get_title_no_list_by_key(divorce)->
	[0,0,0].

get(marry,1) ->
	#couple_cfg{
		no = 1,
		key = marry,
		type = 1,
		need_money = [{2,99999}],
		tips_no = 356,
		title_no = 62005,
		output_money = [],
		per_money = [],
		intimacy_limit = 1000,
		intimacy_left = 0,
		lv_limit = 45,
		fireworks = 1,
		fire_no = 0,
		fire_price = []
};

get(marry,2) ->
	#couple_cfg{
		no = 2,
		key = marry,
		type = 2,
		need_money = [{2,299999}],
		tips_no = 356,
		title_no = 62006,
		output_money = [],
		per_money = [],
		intimacy_limit = 1000,
		intimacy_left = 0,
		lv_limit = 45,
		fireworks = 2,
		fire_no = 0,
		fire_price = []
};

get(marry,3) ->
	#couple_cfg{
		no = 3,
		key = marry,
		type = 3,
		need_money = [{2,999999}],
		tips_no = 356,
		title_no = 62007,
		output_money = [],
		per_money = [],
		intimacy_limit = 1000,
		intimacy_left = 0,
		lv_limit = 45,
		fireworks = 3,
		fire_no = 0,
		fire_price = []
};

get(learn_skill,40001) ->
	#couple_cfg{
		no = 4,
		key = learn_skill,
		type = 40001,
		need_money = [],
		tips_no = 0,
		title_no = 0,
		output_money = [],
		per_money = [],
		intimacy_limit = 1000,
		intimacy_left = 0,
		lv_limit = 45,
		fireworks = 0,
		fire_no = 0,
		fire_price = []
};

get(learn_skill,40002) ->
	#couple_cfg{
		no = 5,
		key = learn_skill,
		type = 40002,
		need_money = [],
		tips_no = 0,
		title_no = 0,
		output_money = [],
		per_money = [],
		intimacy_limit = 2000,
		intimacy_left = 0,
		lv_limit = 45,
		fireworks = 0,
		fire_no = 0,
		fire_price = []
};

get(learn_skill,40003) ->
	#couple_cfg{
		no = 6,
		key = learn_skill,
		type = 40003,
		need_money = [],
		tips_no = 0,
		title_no = 0,
		output_money = [],
		per_money = [],
		intimacy_limit = 3000,
		intimacy_left = 0,
		lv_limit = 45,
		fireworks = 0,
		fire_no = 0,
		fire_price = []
};

get(cruise,1) ->
	#couple_cfg{
		no = 7,
		key = cruise,
		type = 1,
		need_money = [{2,66666}],
		tips_no = 357,
		title_no = 0,
		output_money = [{1,500000}],
		per_money = [{1,1500}],
		intimacy_limit = 0,
		intimacy_left = 0,
		lv_limit = 45,
		fireworks = 4,
		fire_no = 7,
		fire_price = [{1,3000000}]
};

get(cruise,2) ->
	#couple_cfg{
		no = 8,
		key = cruise,
		type = 2,
		need_money = [{2,188888}],
		tips_no = 357,
		title_no = 0,
		output_money = [{1,1000000}],
		per_money = [{1,2500}],
		intimacy_limit = 0,
		intimacy_left = 0,
		lv_limit = 45,
		fireworks = 5,
		fire_no = 8,
		fire_price = [{1,6666666}]
};

get(cruise,3) ->
	#couple_cfg{
		no = 9,
		key = cruise,
		type = 3,
		need_money = [{2,888888}],
		tips_no = 357,
		title_no = 0,
		output_money = [{1,2000000}],
		per_money = [{1,5000}],
		intimacy_limit = 0,
		intimacy_left = 0,
		lv_limit = 45,
		fireworks = 6,
		fire_no = 9,
		fire_price = [{1,8888888}]
};

get(divorce,1) ->
	#couple_cfg{
		no = 10,
		key = divorce,
		type = 1,
		need_money = [],
		tips_no = 0,
		title_no = 0,
		output_money = [],
		per_money = [],
		intimacy_limit = 0,
		intimacy_left = 500,
		lv_limit = 45,
		fireworks = 0,
		fire_no = 0,
		fire_price = []
};

get(divorce,2) ->
	#couple_cfg{
		no = 11,
		key = divorce,
		type = 2,
		need_money = [{1,2000000}],
		tips_no = 0,
		title_no = 0,
		output_money = [],
		per_money = [],
		intimacy_limit = 0,
		intimacy_left = 10,
		lv_limit = 45,
		fireworks = 0,
		fire_no = 0,
		fire_price = []
};

get(divorce,3) ->
	#couple_cfg{
		no = 12,
		key = divorce,
		type = 3,
		need_money = [],
		tips_no = 0,
		title_no = 0,
		output_money = [],
		per_money = [],
		intimacy_limit = 0,
		intimacy_left = 10,
		lv_limit = 0,
		fireworks = 0,
		fire_no = 0,
		fire_price = []
};

get(_, _) ->
          null.

