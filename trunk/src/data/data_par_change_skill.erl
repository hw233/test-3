%%%---------------------------------------
%%% @Module  : data_par_change_skill
%%% @Author  : zwq
%%% @Email   : 
%%% @Description:  宠物技能打书配置表
%%%---------------------------------------


-module(data_par_change_skill).
-include("common.hrl").
-include("record.hrl").
-include("partner.hrl").
-compile(export_all).

get(1,0) ->
	#change_skill_cfg{
		max_slot = 1,
		cur_p_skill_count = 0,
		prob = 2000,
		coef_a = 1000,
		goods_list = [{50398,1}]
};

get(2,0) ->
	#change_skill_cfg{
		max_slot = 2,
		cur_p_skill_count = 0,
		prob = 1250,
		coef_a = 1000,
		goods_list = [{50398,2}]
};

get(2,1) ->
	#change_skill_cfg{
		max_slot = 2,
		cur_p_skill_count = 1,
		prob = 1000,
		coef_a = 1000,
		goods_list = [{50398,2}]
};

get(3,0) ->
	#change_skill_cfg{
		max_slot = 3,
		cur_p_skill_count = 0,
		prob = 1000,
		coef_a = 1000,
		goods_list = [{50398,2}]
};

get(3,1) ->
	#change_skill_cfg{
		max_slot = 3,
		cur_p_skill_count = 1,
		prob = 800,
		coef_a = 1000,
		goods_list = [{50398,3}]
};

get(3,2) ->
	#change_skill_cfg{
		max_slot = 3,
		cur_p_skill_count = 2,
		prob = 500,
		coef_a = 1000,
		goods_list = [{50398,4}]
};

get(4,0) ->
	#change_skill_cfg{
		max_slot = 4,
		cur_p_skill_count = 0,
		prob = 1000,
		coef_a = 1000,
		goods_list = [{50398,2}]
};

get(4,1) ->
	#change_skill_cfg{
		max_slot = 4,
		cur_p_skill_count = 1,
		prob = 666.666667,
		coef_a = 1000,
		goods_list = [{50398,3}]
};

get(4,2) ->
	#change_skill_cfg{
		max_slot = 4,
		cur_p_skill_count = 2,
		prob = 416.666667,
		coef_a = 1000,
		goods_list = [{50398,5}]
};

get(4,3) ->
	#change_skill_cfg{
		max_slot = 4,
		cur_p_skill_count = 3,
		prob = 347.222222,
		coef_a = 1000,
		goods_list = [{50398,6}]
};

get(5,0) ->
	#change_skill_cfg{
		max_slot = 5,
		cur_p_skill_count = 0,
		prob = 1000,
		coef_a = 1000,
		goods_list = [{50398,2}]
};

get(5,1) ->
	#change_skill_cfg{
		max_slot = 5,
		cur_p_skill_count = 1,
		prob = 571.428571,
		coef_a = 1000,
		goods_list = [{50398,4}]
};

get(5,2) ->
	#change_skill_cfg{
		max_slot = 5,
		cur_p_skill_count = 2,
		prob = 357.142857,
		coef_a = 1000,
		goods_list = [{50398,6}]
};

get(5,3) ->
	#change_skill_cfg{
		max_slot = 5,
		cur_p_skill_count = 3,
		prob = 285.714286,
		coef_a = 1000,
		goods_list = [{50398,8}]
};

get(5,4) ->
	#change_skill_cfg{
		max_slot = 5,
		cur_p_skill_count = 4,
		prob = 238.095238,
		coef_a = 1000,
		goods_list = [{50398,9}]
};

get(6,0) ->
	#change_skill_cfg{
		max_slot = 6,
		cur_p_skill_count = 0,
		prob = 1000,
		coef_a = 1000,
		goods_list = [{50398,2}]
};

get(6,1) ->
	#change_skill_cfg{
		max_slot = 6,
		cur_p_skill_count = 1,
		prob = 500,
		coef_a = 1000,
		goods_list = [{50398,4}]
};

get(6,2) ->
	#change_skill_cfg{
		max_slot = 6,
		cur_p_skill_count = 2,
		prob = 312.500000,
		coef_a = 1000,
		goods_list = [{50398,7}]
};

get(6,3) ->
	#change_skill_cfg{
		max_slot = 6,
		cur_p_skill_count = 3,
		prob = 250,
		coef_a = 1000,
		goods_list = [{50398,9}]
};

get(6,4) ->
	#change_skill_cfg{
		max_slot = 6,
		cur_p_skill_count = 4,
		prob = 208.333333,
		coef_a = 1000,
		goods_list = [{50398,11}]
};

get(6,5) ->
	#change_skill_cfg{
		max_slot = 6,
		cur_p_skill_count = 5,
		prob = 156.250000,
		coef_a = 1000,
		goods_list = [{50398,14}]
};

get(7,0) ->
	#change_skill_cfg{
		max_slot = 7,
		cur_p_skill_count = 0,
		prob = 1000,
		coef_a = 1000,
		goods_list = [{50398,2}]
};

get(7,1) ->
	#change_skill_cfg{
		max_slot = 7,
		cur_p_skill_count = 1,
		prob = 444.444444,
		coef_a = 1000,
		goods_list = [{50398,5}]
};

get(7,2) ->
	#change_skill_cfg{
		max_slot = 7,
		cur_p_skill_count = 2,
		prob = 277.777778,
		coef_a = 1000,
		goods_list = [{50398,8}]
};

get(7,3) ->
	#change_skill_cfg{
		max_slot = 7,
		cur_p_skill_count = 3,
		prob = 222.222222,
		coef_a = 1000,
		goods_list = [{50398,10}]
};

get(7,4) ->
	#change_skill_cfg{
		max_slot = 7,
		cur_p_skill_count = 4,
		prob = 185.185185,
		coef_a = 1000,
		goods_list = [{50398,12}]
};

get(7,5) ->
	#change_skill_cfg{
		max_slot = 7,
		cur_p_skill_count = 5,
		prob = 138.888889,
		coef_a = 1000,
		goods_list = [{50398,16}]
};

get(7,6) ->
	#change_skill_cfg{
		max_slot = 7,
		cur_p_skill_count = 6,
		prob = 92.592593,
		coef_a = 1000,
		goods_list = [{50398,24}]
};

get(8,0) ->
	#change_skill_cfg{
		max_slot = 8,
		cur_p_skill_count = 0,
		prob = 1000,
		coef_a = 1000,
		goods_list = [{50398,1}]
};

get(8,1) ->
	#change_skill_cfg{
		max_slot = 8,
		cur_p_skill_count = 1,
		prob = 400,
		coef_a = 1000,
		goods_list = [{50398,2}]
};

get(8,2) ->
	#change_skill_cfg{
		max_slot = 8,
		cur_p_skill_count = 2,
		prob = 250,
		coef_a = 1000,
		goods_list = [{50398,4}]
};

get(8,3) ->
	#change_skill_cfg{
		max_slot = 8,
		cur_p_skill_count = 3,
		prob = 200,
		coef_a = 1000,
		goods_list = [{50398,8}]
};

get(8,4) ->
	#change_skill_cfg{
		max_slot = 8,
		cur_p_skill_count = 4,
		prob = 166.666667,
		coef_a = 1000,
		goods_list = [{50398,16}]
};

get(8,5) ->
	#change_skill_cfg{
		max_slot = 8,
		cur_p_skill_count = 5,
		prob = 125,
		coef_a = 1000,
		goods_list = [{50398,32}]
};

get(8,6) ->
	#change_skill_cfg{
		max_slot = 8,
		cur_p_skill_count = 6,
		prob = 83.333333,
		coef_a = 1000,
		goods_list = [{50398,64}]
};

get(8,7) ->
	#change_skill_cfg{
		max_slot = 8,
		cur_p_skill_count = 7,
		prob = 41.666667,
		coef_a = 1000,
		goods_list = [{50398,200}]
};

get(9,0) ->
	#change_skill_cfg{
		max_slot = 9,
		cur_p_skill_count = 0,
		prob = 1000,
		coef_a = 1000,
		goods_list = [{50398,1}]
};

get(9,1) ->
	#change_skill_cfg{
		max_slot = 9,
		cur_p_skill_count = 1,
		prob = 400,
		coef_a = 1000,
		goods_list = [{50398,2}]
};

get(9,2) ->
	#change_skill_cfg{
		max_slot = 9,
		cur_p_skill_count = 2,
		prob = 250,
		coef_a = 1000,
		goods_list = [{50398,4}]
};

get(9,3) ->
	#change_skill_cfg{
		max_slot = 9,
		cur_p_skill_count = 3,
		prob = 200,
		coef_a = 1000,
		goods_list = [{50398,8}]
};

get(9,4) ->
	#change_skill_cfg{
		max_slot = 9,
		cur_p_skill_count = 4,
		prob = 166.666667,
		coef_a = 1000,
		goods_list = [{50398,16}]
};

get(9,5) ->
	#change_skill_cfg{
		max_slot = 9,
		cur_p_skill_count = 5,
		prob = 125,
		coef_a = 1000,
		goods_list = [{50398,32}]
};

get(9,6) ->
	#change_skill_cfg{
		max_slot = 9,
		cur_p_skill_count = 6,
		prob = 83.333333,
		coef_a = 1000,
		goods_list = [{50398,64}]
};

get(9,7) ->
	#change_skill_cfg{
		max_slot = 9,
		cur_p_skill_count = 7,
		prob = 50,
		coef_a = 1000,
		goods_list = [{50398,200}]
};

get(9,8) ->
	#change_skill_cfg{
		max_slot = 9,
		cur_p_skill_count = 8,
		prob = 30,
		coef_a = 1000,
		goods_list = [{50398,500}]
};

get(10,0) ->
	#change_skill_cfg{
		max_slot = 10,
		cur_p_skill_count = 0,
		prob = 1000,
		coef_a = 1000,
		goods_list = [{50398,1}]
};

get(10,1) ->
	#change_skill_cfg{
		max_slot = 10,
		cur_p_skill_count = 1,
		prob = 400,
		coef_a = 1000,
		goods_list = [{50398,2}]
};

get(10,2) ->
	#change_skill_cfg{
		max_slot = 10,
		cur_p_skill_count = 2,
		prob = 250,
		coef_a = 1000,
		goods_list = [{50398,4}]
};

get(10,3) ->
	#change_skill_cfg{
		max_slot = 10,
		cur_p_skill_count = 3,
		prob = 200,
		coef_a = 1000,
		goods_list = [{50398,8}]
};

get(10,4) ->
	#change_skill_cfg{
		max_slot = 10,
		cur_p_skill_count = 4,
		prob = 166.666667,
		coef_a = 1000,
		goods_list = [{50398,16}]
};

get(10,5) ->
	#change_skill_cfg{
		max_slot = 10,
		cur_p_skill_count = 5,
		prob = 125,
		coef_a = 1000,
		goods_list = [{50398,32}]
};

get(10,6) ->
	#change_skill_cfg{
		max_slot = 10,
		cur_p_skill_count = 6,
		prob = 83.333333,
		coef_a = 1000,
		goods_list = [{50398,64}]
};

get(10,7) ->
	#change_skill_cfg{
		max_slot = 10,
		cur_p_skill_count = 7,
		prob = 50,
		coef_a = 1000,
		goods_list = [{50398,200}]
};

get(10,8) ->
	#change_skill_cfg{
		max_slot = 10,
		cur_p_skill_count = 8,
		prob = 37,
		coef_a = 1000,
		goods_list = [{50398,500}]
};

get(10,9) ->
	#change_skill_cfg{
		max_slot = 10,
		cur_p_skill_count = 9,
		prob = 25,
		coef_a = 1000,
		goods_list = [{50398,1000}]
};

get(11,0) ->
	#change_skill_cfg{
		max_slot = 11,
		cur_p_skill_count = 0,
		prob = 1000,
		coef_a = 1000,
		goods_list = [{50398,1}]
};

get(11,1) ->
	#change_skill_cfg{
		max_slot = 11,
		cur_p_skill_count = 1,
		prob = 400,
		coef_a = 1000,
		goods_list = [{50398,2}]
};

get(11,2) ->
	#change_skill_cfg{
		max_slot = 11,
		cur_p_skill_count = 2,
		prob = 250,
		coef_a = 1000,
		goods_list = [{50398,4}]
};

get(11,3) ->
	#change_skill_cfg{
		max_slot = 11,
		cur_p_skill_count = 3,
		prob = 200,
		coef_a = 1000,
		goods_list = [{50398,8}]
};

get(11,4) ->
	#change_skill_cfg{
		max_slot = 11,
		cur_p_skill_count = 4,
		prob = 166.666667,
		coef_a = 1000,
		goods_list = [{50398,16}]
};

get(11,5) ->
	#change_skill_cfg{
		max_slot = 11,
		cur_p_skill_count = 5,
		prob = 125,
		coef_a = 1000,
		goods_list = [{50398,32}]
};

get(11,6) ->
	#change_skill_cfg{
		max_slot = 11,
		cur_p_skill_count = 6,
		prob = 83.333333,
		coef_a = 1000,
		goods_list = [{50398,64}]
};

get(11,7) ->
	#change_skill_cfg{
		max_slot = 11,
		cur_p_skill_count = 7,
		prob = 50,
		coef_a = 1000,
		goods_list = [{50398,200}]
};

get(11,8) ->
	#change_skill_cfg{
		max_slot = 11,
		cur_p_skill_count = 8,
		prob = 37,
		coef_a = 1000,
		goods_list = [{50398,500}]
};

get(11,9) ->
	#change_skill_cfg{
		max_slot = 11,
		cur_p_skill_count = 9,
		prob = 25,
		coef_a = 1000,
		goods_list = [{50398,1000}]
};

get(11,10) ->
	#change_skill_cfg{
		max_slot = 11,
		cur_p_skill_count = 10,
		prob = 14,
		coef_a = 1000,
		goods_list = [{50398,2000}]
};

get(12,0) ->
	#change_skill_cfg{
		max_slot = 12,
		cur_p_skill_count = 0,
		prob = 1000,
		coef_a = 1000,
		goods_list = [{50398,1}]
};

get(12,1) ->
	#change_skill_cfg{
		max_slot = 12,
		cur_p_skill_count = 1,
		prob = 400,
		coef_a = 1000,
		goods_list = [{50398,2}]
};

get(12,2) ->
	#change_skill_cfg{
		max_slot = 12,
		cur_p_skill_count = 2,
		prob = 250,
		coef_a = 1000,
		goods_list = [{50398,4}]
};

get(12,3) ->
	#change_skill_cfg{
		max_slot = 12,
		cur_p_skill_count = 3,
		prob = 200,
		coef_a = 1000,
		goods_list = [{50398,8}]
};

get(12,4) ->
	#change_skill_cfg{
		max_slot = 12,
		cur_p_skill_count = 4,
		prob = 166.666667,
		coef_a = 1000,
		goods_list = [{50398,16}]
};

get(12,5) ->
	#change_skill_cfg{
		max_slot = 12,
		cur_p_skill_count = 5,
		prob = 125,
		coef_a = 1000,
		goods_list = [{50398,32}]
};

get(12,6) ->
	#change_skill_cfg{
		max_slot = 12,
		cur_p_skill_count = 6,
		prob = 83.333333,
		coef_a = 1000,
		goods_list = [{50398,64}]
};

get(12,7) ->
	#change_skill_cfg{
		max_slot = 12,
		cur_p_skill_count = 7,
		prob = 50,
		coef_a = 1000,
		goods_list = [{50398,200}]
};

get(12,8) ->
	#change_skill_cfg{
		max_slot = 12,
		cur_p_skill_count = 8,
		prob = 37,
		coef_a = 1000,
		goods_list = [{50398,500}]
};

get(12,9) ->
	#change_skill_cfg{
		max_slot = 12,
		cur_p_skill_count = 9,
		prob = 25,
		coef_a = 1000,
		goods_list = [{50398,1000}]
};

get(12,10) ->
	#change_skill_cfg{
		max_slot = 12,
		cur_p_skill_count = 10,
		prob = 14,
		coef_a = 1000,
		goods_list = [{50398,2000}]
};

get(12,11) ->
	#change_skill_cfg{
		max_slot = 12,
		cur_p_skill_count = 11,
		prob = 4,
		coef_a = 1000,
		goods_list = [{50398,5000}]
};

get(_MaxSlot, _CurPSkillCount) ->
          null.

