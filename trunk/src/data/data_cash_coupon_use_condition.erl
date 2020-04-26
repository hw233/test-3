%%%---------------------------------------
%%% @Module  : data_cash_coupon_use_condition
%%% @Author  : lzx
%%% @Email   : 
%%% @Description:  现金券使用条件配置表
%%%---------------------------------------


-module(data_cash_coupon_use_condition).

-include("record.hrl").
-include("debug.hrl").
-export([get/1]).

get(89061) ->
	#cash_coupon_use_condition{
		no = 89061,
		type = 1,
		value = 3,
		condition = 12
};

get(89062) ->
	#cash_coupon_use_condition{
		no = 89062,
		type = 1,
		value = 5,
		condition = 12
};

get(89063) ->
	#cash_coupon_use_condition{
		no = 89063,
		type = 1,
		value = 8,
		condition = 30
};

get(89064) ->
	#cash_coupon_use_condition{
		no = 89064,
		type = 1,
		value = 10,
		condition = 30
};

get(89065) ->
	#cash_coupon_use_condition{
		no = 89065,
		type = 1,
		value = 15,
		condition = 30
};

get(89066) ->
	#cash_coupon_use_condition{
		no = 89066,
		type = 1,
		value = 20,
		condition = 98
};

get(89067) ->
	#cash_coupon_use_condition{
		no = 89067,
		type = 1,
		value = 30,
		condition = 98
};

get(89068) ->
	#cash_coupon_use_condition{
		no = 89068,
		type = 1,
		value = 40,
		condition = 98
};

get(89069) ->
	#cash_coupon_use_condition{
		no = 89069,
		type = 1,
		value = 50,
		condition = 98
};

get(89070) ->
	#cash_coupon_use_condition{
		no = 89070,
		type = 1,
		value = 60,
		condition = 198
};

get(89071) ->
	#cash_coupon_use_condition{
		no = 89071,
		type = 1,
		value = 70,
		condition = 198
};

get(89072) ->
	#cash_coupon_use_condition{
		no = 89072,
		type = 1,
		value = 80,
		condition = 198
};

get(89073) ->
	#cash_coupon_use_condition{
		no = 89073,
		type = 1,
		value = 90,
		condition = 198
};

get(89074) ->
	#cash_coupon_use_condition{
		no = 89074,
		type = 1,
		value = 100,
		condition = 328
};

get(89075) ->
	#cash_coupon_use_condition{
		no = 89075,
		type = 1,
		value = 110,
		condition = 328
};

get(89076) ->
	#cash_coupon_use_condition{
		no = 89076,
		type = 1,
		value = 120,
		condition = 328
};

get(89077) ->
	#cash_coupon_use_condition{
		no = 89077,
		type = 1,
		value = 130,
		condition = 328
};

get(89078) ->
	#cash_coupon_use_condition{
		no = 89078,
		type = 1,
		value = 140,
		condition = 328
};

get(89079) ->
	#cash_coupon_use_condition{
		no = 89079,
		type = 1,
		value = 150,
		condition = 328
};

get(89080) ->
	#cash_coupon_use_condition{
		no = 89080,
		type = 1,
		value = 160,
		condition = 328
};

get(89081) ->
	#cash_coupon_use_condition{
		no = 89081,
		type = 1,
		value = 170,
		condition = 648
};

get(89082) ->
	#cash_coupon_use_condition{
		no = 89082,
		type = 1,
		value = 180,
		condition = 648
};

get(89083) ->
	#cash_coupon_use_condition{
		no = 89083,
		type = 1,
		value = 190,
		condition = 648
};

get(89084) ->
	#cash_coupon_use_condition{
		no = 89084,
		type = 1,
		value = 200,
		condition = 648
};

get(89085) ->
	#cash_coupon_use_condition{
		no = 89085,
		type = 1,
		value = 210,
		condition = 648
};

get(89086) ->
	#cash_coupon_use_condition{
		no = 89086,
		type = 1,
		value = 220,
		condition = 648
};

get(89087) ->
	#cash_coupon_use_condition{
		no = 89087,
		type = 1,
		value = 230,
		condition = 648
};

get(89088) ->
	#cash_coupon_use_condition{
		no = 89088,
		type = 1,
		value = 240,
		condition = 648
};

get(89089) ->
	#cash_coupon_use_condition{
		no = 89089,
		type = 1,
		value = 250,
		condition = 648
};

get(89090) ->
	#cash_coupon_use_condition{
		no = 89090,
		type = 1,
		value = 260,
		condition = 648
};

get(89091) ->
	#cash_coupon_use_condition{
		no = 89091,
		type = 1,
		value = 270,
		condition = 648
};

get(89092) ->
	#cash_coupon_use_condition{
		no = 89092,
		type = 1,
		value = 280,
		condition = 648
};

get(89093) ->
	#cash_coupon_use_condition{
		no = 89093,
		type = 1,
		value = 290,
		condition = 648
};

get(89094) ->
	#cash_coupon_use_condition{
		no = 89094,
		type = 1,
		value = 300,
		condition = 648
};

get(89200) ->
	#cash_coupon_use_condition{
		no = 89200,
		type = 2,
		value = 10,
		condition = 198
};

get(89201) ->
	#cash_coupon_use_condition{
		no = 89201,
		type = 2,
		value = 30,
		condition = 648
};

get(89202) ->
	#cash_coupon_use_condition{
		no = 89202,
		type = 2,
		value = 50,
		condition = 2000
};

get(_No) ->
	      ?ASSERT(false),
          null.

