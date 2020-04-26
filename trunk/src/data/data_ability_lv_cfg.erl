%%%---------------------------------------
%%% @Module  : data_ability_lv_cfg
%%% @Author  : zwq
%%% @Email   : 
%%% @Description:  能力等级关联属性
%%%---------------------------------------


-module(data_ability_lv_cfg).
-include("partner.hrl").
-include("debug.hrl").
-compile(export_all).

get_all_lv_step_list()->
	[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25].

get(1) ->
	#ability_lv_cfg{
		no = 1,
		range = [1, 29],
		evolve_coef = 0.800000,
		wash_goods_count_coef = 1,
		cultivate_goods_count_coef = 1
};

get(2) ->
	#ability_lv_cfg{
		no = 2,
		range = [30, 49],
		evolve_coef = 0.800000,
		wash_goods_count_coef = 1,
		cultivate_goods_count_coef = 1
};

get(3) ->
	#ability_lv_cfg{
		no = 3,
		range = [50, 69],
		evolve_coef = 0.800000,
		wash_goods_count_coef = 1,
		cultivate_goods_count_coef = 1
};

get(4) ->
	#ability_lv_cfg{
		no = 4,
		range = [70, 89],
		evolve_coef = 1.123077,
		wash_goods_count_coef = 1.461538,
		cultivate_goods_count_coef = 1.153846
};

get(5) ->
	#ability_lv_cfg{
		no = 5,
		range = [90, 109],
		evolve_coef = 1.123077,
		wash_goods_count_coef = 1.461538,
		cultivate_goods_count_coef = 1.153846
};

get(6) ->
	#ability_lv_cfg{
		no = 6,
		range = [110, 129],
		evolve_coef = 1.123077,
		wash_goods_count_coef = 1.461538,
		cultivate_goods_count_coef = 1.153846
};

get(7) ->
	#ability_lv_cfg{
		no = 7,
		range = [130, 149],
		evolve_coef = 1.446154,
		wash_goods_count_coef = 1.923077,
		cultivate_goods_count_coef = 1.307692
};

get(8) ->
	#ability_lv_cfg{
		no = 8,
		range = [150, 169],
		evolve_coef = 1.446154,
		wash_goods_count_coef = 1.923077,
		cultivate_goods_count_coef = 1.307692
};

get(9) ->
	#ability_lv_cfg{
		no = 9,
		range = [170, 189],
		evolve_coef = 1.446154,
		wash_goods_count_coef = 1.923077,
		cultivate_goods_count_coef = 1.307692
};

get(10) ->
	#ability_lv_cfg{
		no = 10,
		range = [190, 209],
		evolve_coef = 1.769231,
		wash_goods_count_coef = 2.384615,
		cultivate_goods_count_coef = 1.461538
};

get(11) ->
	#ability_lv_cfg{
		no = 11,
		range = [209, 229],
		evolve_coef = 1.769231,
		wash_goods_count_coef = 2.384615,
		cultivate_goods_count_coef = 1.461538
};

get(12) ->
	#ability_lv_cfg{
		no = 12,
		range = [230, 249],
		evolve_coef = 1.769231,
		wash_goods_count_coef = 2.384615,
		cultivate_goods_count_coef = 1.461538
};

get(13) ->
	#ability_lv_cfg{
		no = 13,
		range = [250, 269],
		evolve_coef = 2.092308,
		wash_goods_count_coef = 2.846154,
		cultivate_goods_count_coef = 1.615385
};

get(14) ->
	#ability_lv_cfg{
		no = 14,
		range = [270, 289],
		evolve_coef = 2.092308,
		wash_goods_count_coef = 2.846154,
		cultivate_goods_count_coef = 1.615385
};

get(15) ->
	#ability_lv_cfg{
		no = 15,
		range = [290, 309],
		evolve_coef = 2.092308,
		wash_goods_count_coef = 2.846154,
		cultivate_goods_count_coef = 1.615385
};

get(16) ->
	#ability_lv_cfg{
		no = 16,
		range = [310, 329],
		evolve_coef = 2.415385,
		wash_goods_count_coef = 3.307692,
		cultivate_goods_count_coef = 1.769231
};

get(17) ->
	#ability_lv_cfg{
		no = 17,
		range = [330, 349],
		evolve_coef = 2.415385,
		wash_goods_count_coef = 3.307692,
		cultivate_goods_count_coef = 1.769231
};

get(18) ->
	#ability_lv_cfg{
		no = 18,
		range = [350, 369],
		evolve_coef = 2.415385,
		wash_goods_count_coef = 3.307692,
		cultivate_goods_count_coef = 1.769231
};

get(19) ->
	#ability_lv_cfg{
		no = 19,
		range = [370, 389],
		evolve_coef = 2.738462,
		wash_goods_count_coef = 3.769231,
		cultivate_goods_count_coef = 1.923077
};

get(20) ->
	#ability_lv_cfg{
		no = 20,
		range = [390, 409],
		evolve_coef = 2.738462,
		wash_goods_count_coef = 3.769231,
		cultivate_goods_count_coef = 1.923077
};

get(21) ->
	#ability_lv_cfg{
		no = 21,
		range = [410, 429],
		evolve_coef = 2.738462,
		wash_goods_count_coef = 3.769231,
		cultivate_goods_count_coef = 1.923077
};

get(22) ->
	#ability_lv_cfg{
		no = 22,
		range = [430, 449],
		evolve_coef = 3.061538,
		wash_goods_count_coef = 4.230769,
		cultivate_goods_count_coef = 2.076923
};

get(23) ->
	#ability_lv_cfg{
		no = 23,
		range = [450, 469],
		evolve_coef = 3.061538,
		wash_goods_count_coef = 4.230769,
		cultivate_goods_count_coef = 2.076923
};

get(24) ->
	#ability_lv_cfg{
		no = 24,
		range = [470, 489],
		evolve_coef = 3.061538,
		wash_goods_count_coef = 4.230769,
		cultivate_goods_count_coef = 2.076923
};

get(25) ->
	#ability_lv_cfg{
		no = 25,
		range = [490, 509],
		evolve_coef = 3.384615,
		wash_goods_count_coef = 4.692308,
		cultivate_goods_count_coef = 2.230769
};

get(_No) ->
	?ASSERT(false, _No),
	null.

