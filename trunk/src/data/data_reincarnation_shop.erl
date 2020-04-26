%%%---------------------------------------
%%% @Module  : data_reincarnation_shop
%%% @Author  : 
%%% @Email   : 
%%% @Description:  Z转生兑换商品配置表
%%%---------------------------------------


-module(data_reincarnation_shop).

-include("reincarnation.hrl").
-include("debug.hrl").
-compile(export_all).

get(1) ->
	#reincarnation_shop{
		id = 1,
		good = [{110000,1,3,3}],
		buy_count_limit = 99999,
		price_type = 18,
		price = 5
};

get(2) ->
	#reincarnation_shop{
		id = 2,
		good = [{110001,1,3,4}],
		buy_count_limit = 99999,
		price_type = 18,
		price = 20
};

get(3) ->
	#reincarnation_shop{
		id = 3,
		good = [{110004,1,3,3}],
		buy_count_limit = 99999,
		price_type = 18,
		price = 5
};

get(4) ->
	#reincarnation_shop{
		id = 4,
		good = [{110005,1,3,4}],
		buy_count_limit = 99999,
		price_type = 18,
		price = 20
};

get(5) ->
	#reincarnation_shop{
		id = 5,
		good = [{110008,1,3,3}],
		buy_count_limit = 99999,
		price_type = 18,
		price = 5
};

get(6) ->
	#reincarnation_shop{
		id = 6,
		good = [{110009,1,3,4}],
		buy_count_limit = 99999,
		price_type = 18,
		price = 20
};

get(7) ->
	#reincarnation_shop{
		id = 7,
		good = [{110012,1,3,3}],
		buy_count_limit = 99999,
		price_type = 18,
		price = 5
};

get(8) ->
	#reincarnation_shop{
		id = 8,
		good = [{110013,1,3,4}],
		buy_count_limit = 99999,
		price_type = 18,
		price = 20
};

get(9) ->
	#reincarnation_shop{
		id = 9,
		good = [{110014,1,3,5}],
		buy_count_limit = 99999,
		price_type = 18,
		price = 50
};

get(10) ->
	#reincarnation_shop{
		id = 10,
		good = [{110015,1,3,6}],
		buy_count_limit = 99999,
		price_type = 18,
		price = 4500
};

get(11) ->
	#reincarnation_shop{
		id = 11,
		good = [{62633,1,3,6}],
		buy_count_limit = 99999,
		price_type = 18,
		price = 10000
};

get(12) ->
	#reincarnation_shop{
		id = 12,
		good = [{62636,1,3,6}],
		buy_count_limit = 99999,
		price_type = 18,
		price = 6000
};

get(13) ->
	#reincarnation_shop{
		id = 13,
		good = [{62637,1,3,6}],
		buy_count_limit = 99999,
		price_type = 18,
		price = 6000
};

get(14) ->
	#reincarnation_shop{
		id = 14,
		good = [{62365,1,3,6}],
		buy_count_limit = 99999,
		price_type = 18,
		price = 5000
};

get(15) ->
	#reincarnation_shop{
		id = 15,
		good = [{62364,1,3,6}],
		buy_count_limit = 99999,
		price_type = 18,
		price = 5000
};

get(16) ->
	#reincarnation_shop{
		id = 16,
		good = [{62366,1,3,6}],
		buy_count_limit = 99999,
		price_type = 18,
		price = 3000
};

get(_Id) ->
	      ?ASSERT(false, _Id),
          null.

