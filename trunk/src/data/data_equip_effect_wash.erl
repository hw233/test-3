%%%---------------------------------------
%%% @Module  : data_equip_effect_wash
%%% @Author  : lds
%%% @Email   : 
%%% @Description:  装备特效洗练
%%%---------------------------------------


-module(data_equip_effect_wash).
-include("record/goods_record.hrl").
-include("debug.hrl").
-compile(export_all).

get_all_no()->
	[1,2,3].

get(1) ->
	#equip_effect_wash{
		no = 1,
		lv_lower = 1,
		lv_upper = 180,
		xilian_stone = 70573,
		xilian_stone_count = 10,
		price_type = 9,
		price = 20000
};

get(2) ->
	#equip_effect_wash{
		no = 2,
		lv_lower = 200,
		lv_upper = 220,
		xilian_stone = 70574,
		xilian_stone_count = 20,
		price_type = 9,
		price = 20000
};

get(3) ->
	#equip_effect_wash{
		no = 3,
		lv_lower = 250,
		lv_upper = 300,
		xilian_stone = 70575,
		xilian_stone_count = 30,
		price_type = 9,
		price = 20000
};

get(_No) ->
	      ?ASSERT(false, _No),
          null.

