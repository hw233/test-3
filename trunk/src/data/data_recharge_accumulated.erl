%%%---------------------------------------
%%% @Module  : data_recharge_accumulated
%%% @Author  : zjy
%%% @Email   : 
%%% @Description:  常驻累充配置表
%%%---------------------------------------


-module(data_recharge_accumulated).
-include("common.hrl").
-include("player.hrl").
-compile(export_all).

get_all_no_list()->
	[1,2,3,4,5,6,7,8,9,10,11,12,13,14].

get(1) ->
	#recharge_accumulated{
		no = 1,
		need_recharge = 20,
		reward_no = 2301
};

get(2) ->
	#recharge_accumulated{
		no = 2,
		need_recharge = 50,
		reward_no = 2302
};

get(3) ->
	#recharge_accumulated{
		no = 3,
		need_recharge = 100,
		reward_no = 2303
};

get(4) ->
	#recharge_accumulated{
		no = 4,
		need_recharge = 200,
		reward_no = 2304
};

get(5) ->
	#recharge_accumulated{
		no = 5,
		need_recharge = 400,
		reward_no = 2305
};

get(6) ->
	#recharge_accumulated{
		no = 6,
		need_recharge = 800,
		reward_no = 2306
};

get(7) ->
	#recharge_accumulated{
		no = 7,
		need_recharge = 1200,
		reward_no = 2307
};

get(8) ->
	#recharge_accumulated{
		no = 8,
		need_recharge = 2500,
		reward_no = 2308
};

get(9) ->
	#recharge_accumulated{
		no = 9,
		need_recharge = 4000,
		reward_no = 2309
};

get(10) ->
	#recharge_accumulated{
		no = 10,
		need_recharge = 8000,
		reward_no = 2310
};

get(11) ->
	#recharge_accumulated{
		no = 11,
		need_recharge = 12000,
		reward_no = 2311
};

get(12) ->
	#recharge_accumulated{
		no = 12,
		need_recharge = 20000,
		reward_no = 2312
};

get(13) ->
	#recharge_accumulated{
		no = 13,
		need_recharge = 30000,
		reward_no = 2313
};

get(14) ->
	#recharge_accumulated{
		no = 14,
		need_recharge = 50000,
		reward_no = 2314
};

get(_) ->
          null.

