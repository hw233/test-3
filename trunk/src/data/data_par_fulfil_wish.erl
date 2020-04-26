%%%---------------------------------------
%%% @Module  : data_par_fulfil_wish
%%% @Author  : huangjf
%%% @Email   : 
%%% @Description: 宠物满足心愿
%%%---------------------------------------


-module(data_par_fulfil_wish).
-compile(export_all).

-include("partner.hrl").
-include("debug.hrl").

get_all_intimacy_lv_step()->
	[1,2,3,4,5].

get(1) ->
	#fulfil_wish{
		step = 1,
		goods_no1 = 0,
		goods_no2 = 0,
		goods_no3 = 0,
		goods_no4 = 0,
		goods_no5 = 0,
		goods_no6 = 0,
		count = 0,
		intimacy_lv_region = [1,5]
};

get(2) ->
	#fulfil_wish{
		step = 2,
		goods_no1 = 0,
		goods_no2 = 0,
		goods_no3 = 0,
		goods_no4 = 0,
		goods_no5 = 0,
		goods_no6 = 0,
		count = 0,
		intimacy_lv_region = [6,10]
};

get(3) ->
	#fulfil_wish{
		step = 3,
		goods_no1 = 0,
		goods_no2 = 0,
		goods_no3 = 0,
		goods_no4 = 0,
		goods_no5 = 0,
		goods_no6 = 0,
		count = 0,
		intimacy_lv_region = [11,14]
};

get(4) ->
	#fulfil_wish{
		step = 4,
		goods_no1 = 0,
		goods_no2 = 0,
		goods_no3 = 0,
		goods_no4 = 0,
		goods_no5 = 0,
		goods_no6 = 0,
		count = 0,
		intimacy_lv_region = [15,18]
};

get(5) ->
	#fulfil_wish{
		step = 5,
		goods_no1 = 0,
		goods_no2 = 0,
		goods_no3 = 0,
		goods_no4 = 0,
		goods_no5 = 0,
		goods_no6 = 0,
		count = 0,
		intimacy_lv_region = [19,20]
};

get(_Step) ->
	?ASSERT(false, {_Step}),
    null.

