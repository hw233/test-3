%%%---------------------------------------
%%% @Module  : data_shop
%%% @Author  : zhangwq
%%% @Email   : 
%%% @Description: 商城数据
%%%---------------------------------------


-module(data_shop).
-export([
        get_shop_goods_no_list_by_type/1,
        get_shop_goods_type_list/0,
        get/1
    ]).

-include("trade.hrl").
-include("debug.hrl").

get_shop_goods_no_list_by_type(0)->
	[72401,72402,72404,72405,50366,50373,50374,20024,20025,20026,20043,20046];
get_shop_goods_no_list_by_type(3)->
	[62161,60022,10052,10053].

get_shop_goods_type_list()->
	[0,3].

get(72401) ->
	#shop_goods{
		goods_no = 72401,
		quality = 0,
		bind_state = 2,
		price_type = 3,
		price = 860,
		discount_price = 860,
		goods_type = 0,
		goods_count_limit = 0,
		buy_count_limit = 0,
		count_limit_type = 0,
		buy_count_limit_time = 0,
		lv_need = 0,
		vip_lv_need = 0,
		repu_need = 0,
		sex = 0,
		race_need = 0,
		faction_need = 0,
		year = nil,
		month = nil,
		week = nil,
		day = nil,
		hour = nil,
		server_start_day = nil,
		refresh_interval = nil,
		continue_day = nil,
		continue_time = nil
};

get(72402) ->
	#shop_goods{
		goods_no = 72402,
		quality = 0,
		bind_state = 2,
		price_type = 3,
		price = 100,
		discount_price = 100,
		goods_type = 0,
		goods_count_limit = 0,
		buy_count_limit = 0,
		count_limit_type = 0,
		buy_count_limit_time = 0,
		lv_need = 0,
		vip_lv_need = 0,
		repu_need = 0,
		sex = 0,
		race_need = 0,
		faction_need = 0,
		year = nil,
		month = nil,
		week = nil,
		day = nil,
		hour = nil,
		server_start_day = nil,
		refresh_interval = nil,
		continue_day = nil,
		continue_time = nil
};

get(72404) ->
	#shop_goods{
		goods_no = 72404,
		quality = 0,
		bind_state = 2,
		price_type = 3,
		price = 3000,
		discount_price = 3000,
		goods_type = 0,
		goods_count_limit = 0,
		buy_count_limit = 0,
		count_limit_type = 0,
		buy_count_limit_time = 0,
		lv_need = 0,
		vip_lv_need = 0,
		repu_need = 0,
		sex = 0,
		race_need = 0,
		faction_need = 0,
		year = nil,
		month = nil,
		week = nil,
		day = nil,
		hour = nil,
		server_start_day = nil,
		refresh_interval = nil,
		continue_day = nil,
		continue_time = nil
};

get(72405) ->
	#shop_goods{
		goods_no = 72405,
		quality = 0,
		bind_state = 2,
		price_type = 3,
		price = 500,
		discount_price = 500,
		goods_type = 0,
		goods_count_limit = 0,
		buy_count_limit = 0,
		count_limit_type = 0,
		buy_count_limit_time = 0,
		lv_need = 0,
		vip_lv_need = 0,
		repu_need = 0,
		sex = 0,
		race_need = 0,
		faction_need = 0,
		year = nil,
		month = nil,
		week = nil,
		day = nil,
		hour = nil,
		server_start_day = nil,
		refresh_interval = nil,
		continue_day = nil,
		continue_time = nil
};

get(62161) ->
	#shop_goods{
		goods_no = 62161,
		quality = 0,
		bind_state = 2,
		price_type = 3,
		price = 500,
		discount_price = 500,
		goods_type = 3,
		goods_count_limit = 0,
		buy_count_limit = 0,
		count_limit_type = 1,
		buy_count_limit_time = 50,
		lv_need = 0,
		vip_lv_need = 0,
		repu_need = 0,
		sex = 0,
		race_need = 0,
		faction_need = 0,
		year = nil,
		month = nil,
		week = nil,
		day = nil,
		hour = nil,
		server_start_day = nil,
		refresh_interval = nil,
		continue_day = nil,
		continue_time = nil
};

get(50366) ->
	#shop_goods{
		goods_no = 50366,
		quality = 0,
		bind_state = 2,
		price_type = 3,
		price = 1987,
		discount_price = 1987,
		goods_type = 0,
		goods_count_limit = 0,
		buy_count_limit = 0,
		count_limit_type = 0,
		buy_count_limit_time = 0,
		lv_need = 0,
		vip_lv_need = 0,
		repu_need = 0,
		sex = 0,
		race_need = 0,
		faction_need = 0,
		year = nil,
		month = nil,
		week = nil,
		day = nil,
		hour = nil,
		server_start_day = nil,
		refresh_interval = nil,
		continue_day = nil,
		continue_time = nil
};

get(50373) ->
	#shop_goods{
		goods_no = 50373,
		quality = 0,
		bind_state = 2,
		price_type = 3,
		price = 100,
		discount_price = 100,
		goods_type = 0,
		goods_count_limit = 0,
		buy_count_limit = 0,
		count_limit_type = 0,
		buy_count_limit_time = 0,
		lv_need = 0,
		vip_lv_need = 0,
		repu_need = 0,
		sex = 0,
		race_need = 0,
		faction_need = 0,
		year = nil,
		month = nil,
		week = nil,
		day = nil,
		hour = nil,
		server_start_day = nil,
		refresh_interval = nil,
		continue_day = nil,
		continue_time = nil
};

get(50374) ->
	#shop_goods{
		goods_no = 50374,
		quality = 0,
		bind_state = 2,
		price_type = 3,
		price = 500,
		discount_price = 500,
		goods_type = 0,
		goods_count_limit = 0,
		buy_count_limit = 0,
		count_limit_type = 0,
		buy_count_limit_time = 0,
		lv_need = 0,
		vip_lv_need = 0,
		repu_need = 0,
		sex = 0,
		race_need = 0,
		faction_need = 0,
		year = nil,
		month = nil,
		week = nil,
		day = nil,
		hour = nil,
		server_start_day = nil,
		refresh_interval = nil,
		continue_day = nil,
		continue_time = nil
};

get(20024) ->
	#shop_goods{
		goods_no = 20024,
		quality = 0,
		bind_state = 2,
		price_type = 3,
		price = 150,
		discount_price = 150,
		goods_type = 0,
		goods_count_limit = 0,
		buy_count_limit = 0,
		count_limit_type = 0,
		buy_count_limit_time = 0,
		lv_need = 0,
		vip_lv_need = 0,
		repu_need = 0,
		sex = 0,
		race_need = 0,
		faction_need = 0,
		year = nil,
		month = nil,
		week = nil,
		day = nil,
		hour = nil,
		server_start_day = nil,
		refresh_interval = nil,
		continue_day = nil,
		continue_time = nil
};

get(20025) ->
	#shop_goods{
		goods_no = 20025,
		quality = 0,
		bind_state = 2,
		price_type = 3,
		price = 450,
		discount_price = 450,
		goods_type = 0,
		goods_count_limit = 0,
		buy_count_limit = 0,
		count_limit_type = 0,
		buy_count_limit_time = 0,
		lv_need = 0,
		vip_lv_need = 0,
		repu_need = 0,
		sex = 0,
		race_need = 0,
		faction_need = 0,
		year = nil,
		month = nil,
		week = nil,
		day = nil,
		hour = nil,
		server_start_day = nil,
		refresh_interval = nil,
		continue_day = nil,
		continue_time = nil
};

get(20026) ->
	#shop_goods{
		goods_no = 20026,
		quality = 0,
		bind_state = 2,
		price_type = 3,
		price = 1200,
		discount_price = 1200,
		goods_type = 0,
		goods_count_limit = 0,
		buy_count_limit = 0,
		count_limit_type = 0,
		buy_count_limit_time = 0,
		lv_need = 0,
		vip_lv_need = 0,
		repu_need = 0,
		sex = 0,
		race_need = 0,
		faction_need = 0,
		year = nil,
		month = nil,
		week = nil,
		day = nil,
		hour = nil,
		server_start_day = nil,
		refresh_interval = nil,
		continue_day = nil,
		continue_time = nil
};

get(20043) ->
	#shop_goods{
		goods_no = 20043,
		quality = 0,
		bind_state = 2,
		price_type = 3,
		price = 9103,
		discount_price = 9103,
		goods_type = 0,
		goods_count_limit = 0,
		buy_count_limit = 0,
		count_limit_type = 0,
		buy_count_limit_time = 0,
		lv_need = 0,
		vip_lv_need = 0,
		repu_need = 0,
		sex = 0,
		race_need = 0,
		faction_need = 0,
		year = nil,
		month = nil,
		week = nil,
		day = nil,
		hour = nil,
		server_start_day = nil,
		refresh_interval = nil,
		continue_day = nil,
		continue_time = nil
};

get(20046) ->
	#shop_goods{
		goods_no = 20046,
		quality = 0,
		bind_state = 2,
		price_type = 3,
		price = 9103,
		discount_price = 9103,
		goods_type = 0,
		goods_count_limit = 0,
		buy_count_limit = 0,
		count_limit_type = 0,
		buy_count_limit_time = 0,
		lv_need = 0,
		vip_lv_need = 0,
		repu_need = 0,
		sex = 0,
		race_need = 0,
		faction_need = 0,
		year = nil,
		month = nil,
		week = nil,
		day = nil,
		hour = nil,
		server_start_day = nil,
		refresh_interval = nil,
		continue_day = nil,
		continue_time = nil
};

get(60022) ->
	#shop_goods{
		goods_no = 60022,
		quality = 0,
		bind_state = 2,
		price_type = 3,
		price = 250,
		discount_price = 250,
		goods_type = 3,
		goods_count_limit = 0,
		buy_count_limit = 0,
		count_limit_type = 1,
		buy_count_limit_time = 50,
		lv_need = 0,
		vip_lv_need = 0,
		repu_need = 0,
		sex = 0,
		race_need = 0,
		faction_need = 0,
		year = nil,
		month = nil,
		week = nil,
		day = nil,
		hour = nil,
		server_start_day = nil,
		refresh_interval = nil,
		continue_day = nil,
		continue_time = nil
};

get(10052) ->
	#shop_goods{
		goods_no = 10052,
		quality = 0,
		bind_state = 2,
		price_type = 3,
		price = 2000,
		discount_price = 2000,
		goods_type = 3,
		goods_count_limit = 0,
		buy_count_limit = 0,
		count_limit_type = 1,
		buy_count_limit_time = 10,
		lv_need = 0,
		vip_lv_need = 0,
		repu_need = 0,
		sex = 0,
		race_need = 0,
		faction_need = 0,
		year = nil,
		month = nil,
		week = nil,
		day = nil,
		hour = nil,
		server_start_day = nil,
		refresh_interval = nil,
		continue_day = nil,
		continue_time = nil
};

get(10053) ->
	#shop_goods{
		goods_no = 10053,
		quality = 0,
		bind_state = 2,
		price_type = 3,
		price = 2000,
		discount_price = 2000,
		goods_type = 3,
		goods_count_limit = 0,
		buy_count_limit = 0,
		count_limit_type = 1,
		buy_count_limit_time = 10,
		lv_need = 0,
		vip_lv_need = 0,
		repu_need = 0,
		sex = 0,
		race_need = 0,
		faction_need = 0,
		year = nil,
		month = nil,
		week = nil,
		day = nil,
		hour = nil,
		server_start_day = nil,
		refresh_interval = nil,
		continue_day = nil,
		continue_time = nil
};

get(_GoodsNo) ->
    null.

