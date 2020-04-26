%%%---------------------------------------
%%% @Module  : data_credit_shop
%%% @Author  : BJH
%%% @Email   : 
%%% @Description: 兑换商店
%%%---------------------------------------


-module(data_credit_shop).
-include("exchange.hrl").
-include("debug.hrl").
-compile(export_all).

get(1) ->
	#credit_shop{
		id = 1,
		goods_no = 10072,
		price = [{8,3000}]
};

get(2) ->
	#credit_shop{
		id = 2,
		goods_no = 10071,
		price = [{8,3000}]
};

get(3) ->
	#credit_shop{
		id = 3,
		goods_no = 20022,
		price = [{8,400}]
};

get(4) ->
	#credit_shop{
		id = 4,
		goods_no = 50307,
		price = [{8,200}]
};

get(5) ->
	#credit_shop{
		id = 5,
		goods_no = 10102,
		price = [{8,100}]
};

get(6) ->
	#credit_shop{
		id = 6,
		goods_no = 10103,
		price = [{8,300}]
};

get(7) ->
	#credit_shop{
		id = 7,
		goods_no = 10104,
		price = [{8,1000}]
};

get(8) ->
	#credit_shop{
		id = 8,
		goods_no = 10105,
		price = [{8,3000}]
};

get(_Id) ->
	      ?ASSERT(false, _Id),
          null.

