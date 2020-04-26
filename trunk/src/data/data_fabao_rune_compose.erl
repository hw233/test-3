%%%---------------------------------------
%%% @Module  : data_fabao_rune_compose
%%% @Author  : lzx
%%% @Email   : 
%%% @Description: 法宝符印合成消耗表
%%%---------------------------------------


-module(data_fabao_rune_compose).
-compile(export_all).
-include("fabao.hrl").
-include("debug.hrl").

get(120008) ->
	#fabao_rune_compose{
		no = 120008,
		need_goods_num = 2,
		get_goods_no = 120009,
		money = [{9, 20000}]
};

get(120009) ->
	#fabao_rune_compose{
		no = 120009,
		need_goods_num = 3,
		get_goods_no = 120010,
		money = [{9, 50000}]
};

get(120010) ->
	#fabao_rune_compose{
		no = 120010,
		need_goods_num = 4,
		get_goods_no = 120011,
		money = [{9, 100000}]
};

get(120011) ->
	#fabao_rune_compose{
		no = 120011,
		need_goods_num = 5,
		get_goods_no = 120012,
		money = [{9, 200000}]
};

get(120012) ->
	#fabao_rune_compose{
		no = 120012,
		need_goods_num = 6,
		get_goods_no = 120013,
		money = [{9, 400000}]
};

get(120014) ->
	#fabao_rune_compose{
		no = 120014,
		need_goods_num = 2,
		get_goods_no = 120015,
		money = [{9, 20000}]
};

get(120015) ->
	#fabao_rune_compose{
		no = 120015,
		need_goods_num = 3,
		get_goods_no = 120016,
		money = [{9, 50000}]
};

get(120016) ->
	#fabao_rune_compose{
		no = 120016,
		need_goods_num = 4,
		get_goods_no = 120017,
		money = [{9, 100000}]
};

get(120017) ->
	#fabao_rune_compose{
		no = 120017,
		need_goods_num = 5,
		get_goods_no = 120018,
		money = [{9, 200000}]
};

get(120018) ->
	#fabao_rune_compose{
		no = 120018,
		need_goods_num = 6,
		get_goods_no = 120019,
		money = [{9, 400000}]
};

get(120020) ->
	#fabao_rune_compose{
		no = 120020,
		need_goods_num = 2,
		get_goods_no = 120021,
		money = [{9, 20000}]
};

get(120021) ->
	#fabao_rune_compose{
		no = 120021,
		need_goods_num = 3,
		get_goods_no = 120022,
		money = [{9, 50000}]
};

get(120022) ->
	#fabao_rune_compose{
		no = 120022,
		need_goods_num = 4,
		get_goods_no = 120023,
		money = [{9, 100000}]
};

get(120023) ->
	#fabao_rune_compose{
		no = 120023,
		need_goods_num = 5,
		get_goods_no = 120024,
		money = [{9, 200000}]
};

get(120024) ->
	#fabao_rune_compose{
		no = 120024,
		need_goods_num = 6,
		get_goods_no = 120025,
		money = [{9, 400000}]
};

get(120026) ->
	#fabao_rune_compose{
		no = 120026,
		need_goods_num = 2,
		get_goods_no = 120027,
		money = [{9, 20000}]
};

get(120027) ->
	#fabao_rune_compose{
		no = 120027,
		need_goods_num = 3,
		get_goods_no = 120028,
		money = [{9, 50000}]
};

get(120028) ->
	#fabao_rune_compose{
		no = 120028,
		need_goods_num = 4,
		get_goods_no = 120029,
		money = [{9, 100000}]
};

get(120029) ->
	#fabao_rune_compose{
		no = 120029,
		need_goods_num = 5,
		get_goods_no = 120030,
		money = [{9, 200000}]
};

get(120030) ->
	#fabao_rune_compose{
		no = 120030,
		need_goods_num = 6,
		get_goods_no = 120031,
		money = [{9, 400000}]
};

get(120032) ->
	#fabao_rune_compose{
		no = 120032,
		need_goods_num = 2,
		get_goods_no = 120033,
		money = [{9, 20000}]
};

get(120033) ->
	#fabao_rune_compose{
		no = 120033,
		need_goods_num = 3,
		get_goods_no = 120034,
		money = [{9, 50000}]
};

get(120034) ->
	#fabao_rune_compose{
		no = 120034,
		need_goods_num = 4,
		get_goods_no = 120035,
		money = [{9, 100000}]
};

get(120035) ->
	#fabao_rune_compose{
		no = 120035,
		need_goods_num = 5,
		get_goods_no = 120036,
		money = [{9, 200000}]
};

get(120036) ->
	#fabao_rune_compose{
		no = 120036,
		need_goods_num = 6,
		get_goods_no = 120037,
		money = [{9, 400000}]
};

get(120038) ->
	#fabao_rune_compose{
		no = 120038,
		need_goods_num = 2,
		get_goods_no = 120039,
		money = [{9, 20000}]
};

get(120039) ->
	#fabao_rune_compose{
		no = 120039,
		need_goods_num = 3,
		get_goods_no = 120040,
		money = [{9, 50000}]
};

get(120040) ->
	#fabao_rune_compose{
		no = 120040,
		need_goods_num = 4,
		get_goods_no = 120041,
		money = [{9, 100000}]
};

get(120041) ->
	#fabao_rune_compose{
		no = 120041,
		need_goods_num = 5,
		get_goods_no = 120042,
		money = [{9, 200000}]
};

get(120042) ->
	#fabao_rune_compose{
		no = 120042,
		need_goods_num = 6,
		get_goods_no = 120043,
		money = [{9, 400000}]
};

get(_No) ->
	?ASSERT(false, {_No}),
    null.

