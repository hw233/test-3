%%%---------------------------------------
%%% @Module  : data_equip_added_con
%%% @Author  : zwq
%%% @Email   : 
%%% @Description:  装备附加属性常量
%%%---------------------------------------


-module(data_equip_added_con).
-include("common.hrl").
-include("record/goods_record.hrl").
-compile(export_all).

get(1) ->
	#equip_added_con{
		constant_type = 1,
		con_lv_up = 1.250000,
		star_lv_up = 1,
		up_lv_coef = 3
};

get(2) ->
	#equip_added_con{
		constant_type = 2,
		con_lv_up = 1.250000,
		star_lv_up = 1,
		up_lv_coef = 3
};

get(3) ->
	#equip_added_con{
		constant_type = 3,
		con_lv_up = 1.250000,
		star_lv_up = 1,
		up_lv_coef = 3
};

get(4) ->
	#equip_added_con{
		constant_type = 4,
		con_lv_up = 1.250000,
		star_lv_up = 2,
		up_lv_coef = 3
};

get(5) ->
	#equip_added_con{
		constant_type = 5,
		con_lv_up = 1.250000,
		star_lv_up = 2,
		up_lv_coef = 3
};

get(6) ->
	#equip_added_con{
		constant_type = 6,
		con_lv_up = 1.250000,
		star_lv_up = 2,
		up_lv_coef = 3
};

get(7) ->
	#equip_added_con{
		constant_type = 7,
		con_lv_up = 1.250000,
		star_lv_up = 2,
		up_lv_coef = 3
};

get(8) ->
	#equip_added_con{
		constant_type = 8,
		con_lv_up = 1.250000,
		star_lv_up = 2,
		up_lv_coef = 3
};

get(9) ->
	#equip_added_con{
		constant_type = 9,
		con_lv_up = 1.250000,
		star_lv_up = 2,
		up_lv_coef = 3
};

get(10) ->
	#equip_added_con{
		constant_type = 10,
		con_lv_up = 1.250000,
		star_lv_up = 2,
		up_lv_coef = 3
};

get(11) ->
	#equip_added_con{
		constant_type = 11,
		con_lv_up = 1.250000,
		star_lv_up = 1,
		up_lv_coef = 3
};

get(12) ->
	#equip_added_con{
		constant_type = 12,
		con_lv_up = 1.250000,
		star_lv_up = 3,
		up_lv_coef = 3
};

get(13) ->
	#equip_added_con{
		constant_type = 13,
		con_lv_up = 1.250000,
		star_lv_up = 3,
		up_lv_coef = 3
};

get(14) ->
	#equip_added_con{
		constant_type = 14,
		con_lv_up = 1.250000,
		star_lv_up = 3,
		up_lv_coef = 3
};

get(15) ->
	#equip_added_con{
		constant_type = 15,
		con_lv_up = 1.250000,
		star_lv_up = 3,
		up_lv_coef = 3
};

get(16) ->
	#equip_added_con{
		constant_type = 16,
		con_lv_up = 1.250000,
		star_lv_up = 3,
		up_lv_coef = 3
};

get(17) ->
	#equip_added_con{
		constant_type = 17,
		con_lv_up = 1.250000,
		star_lv_up = 3,
		up_lv_coef = 3
};

get(_ConstantType) ->
	      ?ASSERT(false, _ConstantType),
          null.

