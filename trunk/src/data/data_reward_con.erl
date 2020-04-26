%%%---------------------------------------
%%% @Module  : data_reward_con
%%% @Author  : zwq
%%% @Email   : 
%%% @Description:  奖励相关
%%%---------------------------------------


-module(data_reward_con).
-include("common.hrl").
-include("record.hrl").
-include("reward.hrl").
-compile(export_all).

get(300001) ->
	#reward_con{
		no = 300001,
		player_coef = 1,
		par_coef = 1,
		coef_a = [0,0,0,0,0],
		coef_b = [16,0,0,0,0],
		constant_c = [4032,0,0,1,0],
		ring_add_coef = [0.1,0,0.1,0.1,0.1],
		round_add = [20,20,20,20,20],
		round_add_coef = [4,4,4,4,4],
		round_dec_coef = [1,1,1,0,1],
		buff = [1,0,0,0,0],
		coef_time = 0,
		lv_need = [1,1,1]
};

get(300101) ->
	#reward_con{
		no = 300101,
		player_coef = 1,
		par_coef = 1,
		coef_a = [0,0,0,0,0],
		coef_b = [117,0,0,0,0],
		constant_c = [29268,24390,0,5,0],
		ring_add_coef = [0.1,0.1,0.1,0.1,0.1],
		round_add = [2,2,2,2,2],
		round_add_coef = [1,1,1,1,1],
		round_dec_coef = [1,1,1,1,1],
		buff = [0,0,0,0,0],
		coef_time = 0,
		lv_need = [1,1,1]
};

get(300201) ->
	#reward_con{
		no = 300201,
		player_coef = 1,
		par_coef = 1,
		coef_a = [0,0,0,0,0],
		coef_b = [70,0,0,0,0],
		constant_c = [17561,0,0,5,0],
		ring_add_coef = [0.25,0,0.1,0.1,0.1],
		round_add = [2,2,2,2,2],
		round_add_coef = [1,1,1,1,1],
		round_dec_coef = [1,1,1,1,1],
		buff = [0,0,0,0,0],
		coef_time = 0,
		lv_need = [1,1,1]
};

get(300301) ->
	#reward_con{
		no = 300301,
		player_coef = 1,
		par_coef = 1,
		coef_a = [0,0,0,0,0],
		coef_b = [26,0,0,0,0],
		constant_c = [6048,0,0,1,0],
		ring_add_coef = [0.1,0,0.1,0.1,0.1],
		round_add = [20,20,20,20,20],
		round_add_coef = [4,4,4,4,4],
		round_dec_coef = [1,1,1,0,1],
		buff = [1,0,0,0,0],
		coef_time = 0,
		lv_need = [1,1,1]
};

get(42001) ->
	#reward_con{
		no = 42001,
		player_coef = 0,
		par_coef = 1,
		coef_a = [0,0,0,0,0],
		coef_b = [0,0,0,0,0],
		constant_c = [0,0,500,0,0],
		ring_add_coef = [0,0,0,0,0],
		round_add = [1,1,1,1,1],
		round_add_coef = [1,1,1,1,1],
		round_dec_coef = [0,0,0,0,0],
		buff = [],
		coef_time = 0,
		lv_need = [16,1,15]
};

get(42002) ->
	#reward_con{
		no = 42002,
		player_coef = 0,
		par_coef = 1,
		coef_a = [0,0,0,0,0],
		coef_b = [0,0,0,0,0],
		constant_c = [0,0,500,0,0],
		ring_add_coef = [0,0,0,0,0],
		round_add = [1,1,1,1,1],
		round_add_coef = [1,1,1,1,1],
		round_dec_coef = [0,0,0,0,0],
		buff = [],
		coef_time = 0,
		lv_need = [16,1,15]
};

get(42003) ->
	#reward_con{
		no = 42003,
		player_coef = 0,
		par_coef = 1,
		coef_a = [0,0,0,0,0],
		coef_b = [0,0,0,0,0],
		constant_c = [0,0,500,0,0],
		ring_add_coef = [0,0,0,0,0],
		round_add = [1,1,1,1,1],
		round_add_coef = [1,1,1,1,1],
		round_dec_coef = [0,0,0,0,0],
		buff = [],
		coef_time = 0,
		lv_need = [16,1,15]
};

get(42004) ->
	#reward_con{
		no = 42004,
		player_coef = 0,
		par_coef = 1,
		coef_a = [0,0,0,0,0],
		coef_b = [0,0,0,0,0],
		constant_c = [0,0,500,0,0],
		ring_add_coef = [0,0,0,0,0],
		round_add = [1,1,1,1,1],
		round_add_coef = [1,1,1,1,1],
		round_dec_coef = [0,0,0,0,0],
		buff = [],
		coef_time = 0,
		lv_need = [16,1,15]
};

get(42005) ->
	#reward_con{
		no = 42005,
		player_coef = 0,
		par_coef = 1,
		coef_a = [0,0,0,0,0],
		coef_b = [0,0,0,0,0],
		constant_c = [0,0,500,0,0],
		ring_add_coef = [0,0,0,0,0],
		round_add = [1,1,1,1,1],
		round_add_coef = [1,1,1,1,1],
		round_dec_coef = [0,0,0,0,0],
		buff = [],
		coef_time = 0,
		lv_need = [16,1,15]
};

get(42006) ->
	#reward_con{
		no = 42006,
		player_coef = 0,
		par_coef = 1,
		coef_a = [0,0,0,0,0],
		coef_b = [0,0,0,0,0],
		constant_c = [0,0,500,0,0],
		ring_add_coef = [0,0,0,0,0],
		round_add = [1,1,1,1,1],
		round_add_coef = [1,1,1,1,1],
		round_dec_coef = [0,0,0,0,0],
		buff = [],
		coef_time = 0,
		lv_need = [16,1,15]
};

get(_No) ->
          null.

