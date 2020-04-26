%%%---------------------------------------
%%% @Module  : data_fabao_goods_exchange
%%% @Author  : lzx
%%% @Email   : 
%%% @Description: 法宝碎片兑换及转化表
%%%---------------------------------------


-module(data_fabao_goods_exchange).
-compile(export_all).
-include("fabao.hrl").
-include("debug.hrl").

get(1) ->
	#fabao_goods_exchange{
		no = 1,
		type = 1,
		exchange_goods = [120006],
		exchange_goods_num = 10,
		get_goods = [120000,120001,120002,120003,120004,120005],
		get_goods_num = 1
};

get(2) ->
	#fabao_goods_exchange{
		no = 2,
		type = 2,
		exchange_goods = [120000,120001,120002,120003,120004,120005],
		exchange_goods_num = 10,
		get_goods = [120006],
		get_goods_num = 1
};

get(_No) ->
	?ASSERT(false, {_No}),
    null.

