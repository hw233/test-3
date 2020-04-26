%%%---------------------------------------
%%% @Module  : data_compose_goods
%%% @Author  : zwq
%%% @Email   : 
%%% @Description:  道具合成提炼
%%%---------------------------------------


-module(data_compose_goods).
-include("common.hrl").
-include("record.hrl").
-include("record/goods_record.hrl").
-compile(export_all).

get_no_list_by_op_no(1)->
	[70102,70103,70104,70105,70106,70107,70108,70109,70110,70501,70502,70503,70504,70112,70113,70114,70115,70116,70117,70118,70119,70120,70509,70510,70511,70512,70122,70123,70124,70125,70126,70127,70128,70129,70130,70517,70518,70519,70520,70132,70133,70134,70135,70136,70137,70138,70139,70140,70525,70526,70527,70528,70142,70143,70144,70145,70146,70147,70148,70149,70150,70533,70534,70535,70536,70242,70243,70244,70245,70246,70247,70248,70249,70250,70541,70542,70543,70544,70302,70303,70304,70305,70306,70307,70308,70309,70310,70549,70550,70551,70552,70312,70313,70314,70315,70316,70317,70318,70319,70320,70557,70558,70559,70560];
get_no_list_by_op_no(3)->
	[72205,72206,72207,72208,72209,72210,72211,72212,72213,72214,72215,72216,72217,72218,55109,55110,55111,55112,55113,20004,20012,20008,20018].

get(70102) ->
	#compose_goods{
		no = 70102,
		op_no = 1,
		need_goods_list = [{70101,2}],
		money = [{1, 2000}],
		get_goods_list = []
};

get(70103) ->
	#compose_goods{
		no = 70103,
		op_no = 1,
		need_goods_list = [{70102,2}],
		money = [{1, 3000}],
		get_goods_list = []
};

get(70104) ->
	#compose_goods{
		no = 70104,
		op_no = 1,
		need_goods_list = [{70103,2}],
		money = [{1, 4000}],
		get_goods_list = []
};

get(70105) ->
	#compose_goods{
		no = 70105,
		op_no = 1,
		need_goods_list = [{70104,2}],
		money = [{1, 5000}],
		get_goods_list = []
};

get(70106) ->
	#compose_goods{
		no = 70106,
		op_no = 1,
		need_goods_list = [{70105,2}],
		money = [{1, 6000}],
		get_goods_list = []
};

get(70107) ->
	#compose_goods{
		no = 70107,
		op_no = 1,
		need_goods_list = [{70106,2}],
		money = [{1, 8000}],
		get_goods_list = []
};

get(70108) ->
	#compose_goods{
		no = 70108,
		op_no = 1,
		need_goods_list = [{70107,2}],
		money = [{1, 10000}],
		get_goods_list = []
};

get(70109) ->
	#compose_goods{
		no = 70109,
		op_no = 1,
		need_goods_list = [{70108,2}],
		money = [{1, 12000}],
		get_goods_list = []
};

get(70110) ->
	#compose_goods{
		no = 70110,
		op_no = 1,
		need_goods_list = [{70109,2}],
		money = [{1, 15000}],
		get_goods_list = []
};

get(70501) ->
	#compose_goods{
		no = 70501,
		op_no = 1,
		need_goods_list = [{70110,2}],
		money = [{1, 20000}],
		get_goods_list = []
};

get(70502) ->
	#compose_goods{
		no = 70502,
		op_no = 1,
		need_goods_list = [{70501,2}],
		money = [{1, 30000}],
		get_goods_list = []
};

get(70503) ->
	#compose_goods{
		no = 70503,
		op_no = 1,
		need_goods_list = [{70502,2}],
		money = [{1, 40000}],
		get_goods_list = []
};

get(70504) ->
	#compose_goods{
		no = 70504,
		op_no = 1,
		need_goods_list = [{70503,2}],
		money = [{1, 50000}],
		get_goods_list = []
};

get(70112) ->
	#compose_goods{
		no = 70112,
		op_no = 1,
		need_goods_list = [{70111,2}],
		money = [{1, 2000}],
		get_goods_list = []
};

get(70113) ->
	#compose_goods{
		no = 70113,
		op_no = 1,
		need_goods_list = [{70112,2}],
		money = [{1, 3000}],
		get_goods_list = []
};

get(70114) ->
	#compose_goods{
		no = 70114,
		op_no = 1,
		need_goods_list = [{70113,2}],
		money = [{1, 4000}],
		get_goods_list = []
};

get(70115) ->
	#compose_goods{
		no = 70115,
		op_no = 1,
		need_goods_list = [{70114,2}],
		money = [{1, 5000}],
		get_goods_list = []
};

get(70116) ->
	#compose_goods{
		no = 70116,
		op_no = 1,
		need_goods_list = [{70115,2}],
		money = [{1, 6000}],
		get_goods_list = []
};

get(70117) ->
	#compose_goods{
		no = 70117,
		op_no = 1,
		need_goods_list = [{70116,2}],
		money = [{1, 8000}],
		get_goods_list = []
};

get(70118) ->
	#compose_goods{
		no = 70118,
		op_no = 1,
		need_goods_list = [{70117,2}],
		money = [{1, 10000}],
		get_goods_list = []
};

get(70119) ->
	#compose_goods{
		no = 70119,
		op_no = 1,
		need_goods_list = [{70118,2}],
		money = [{1, 12000}],
		get_goods_list = []
};

get(70120) ->
	#compose_goods{
		no = 70120,
		op_no = 1,
		need_goods_list = [{70119,2}],
		money = [{1, 15000}],
		get_goods_list = []
};

get(70509) ->
	#compose_goods{
		no = 70509,
		op_no = 1,
		need_goods_list = [{70120,2}],
		money = [{1, 20000}],
		get_goods_list = []
};

get(70510) ->
	#compose_goods{
		no = 70510,
		op_no = 1,
		need_goods_list = [{70509,2}],
		money = [{1, 30000}],
		get_goods_list = []
};

get(70511) ->
	#compose_goods{
		no = 70511,
		op_no = 1,
		need_goods_list = [{70510,2}],
		money = [{1, 40000}],
		get_goods_list = []
};

get(70512) ->
	#compose_goods{
		no = 70512,
		op_no = 1,
		need_goods_list = [{70511,2}],
		money = [{1, 50000}],
		get_goods_list = []
};

get(70122) ->
	#compose_goods{
		no = 70122,
		op_no = 1,
		need_goods_list = [{70121,2}],
		money = [{1, 2000}],
		get_goods_list = []
};

get(70123) ->
	#compose_goods{
		no = 70123,
		op_no = 1,
		need_goods_list = [{70122,2}],
		money = [{1, 3000}],
		get_goods_list = []
};

get(70124) ->
	#compose_goods{
		no = 70124,
		op_no = 1,
		need_goods_list = [{70123,2}],
		money = [{1, 4000}],
		get_goods_list = []
};

get(70125) ->
	#compose_goods{
		no = 70125,
		op_no = 1,
		need_goods_list = [{70124,2}],
		money = [{1, 5000}],
		get_goods_list = []
};

get(70126) ->
	#compose_goods{
		no = 70126,
		op_no = 1,
		need_goods_list = [{70125,2}],
		money = [{1, 6000}],
		get_goods_list = []
};

get(70127) ->
	#compose_goods{
		no = 70127,
		op_no = 1,
		need_goods_list = [{70126,2}],
		money = [{1, 8000}],
		get_goods_list = []
};

get(70128) ->
	#compose_goods{
		no = 70128,
		op_no = 1,
		need_goods_list = [{70127,2}],
		money = [{1, 10000}],
		get_goods_list = []
};

get(70129) ->
	#compose_goods{
		no = 70129,
		op_no = 1,
		need_goods_list = [{70128,2}],
		money = [{1, 12000}],
		get_goods_list = []
};

get(70130) ->
	#compose_goods{
		no = 70130,
		op_no = 1,
		need_goods_list = [{70129,2}],
		money = [{1, 15000}],
		get_goods_list = []
};

get(70517) ->
	#compose_goods{
		no = 70517,
		op_no = 1,
		need_goods_list = [{70130,2}],
		money = [{1, 20000}],
		get_goods_list = []
};

get(70518) ->
	#compose_goods{
		no = 70518,
		op_no = 1,
		need_goods_list = [{70517,2}],
		money = [{1, 30000}],
		get_goods_list = []
};

get(70519) ->
	#compose_goods{
		no = 70519,
		op_no = 1,
		need_goods_list = [{70518,2}],
		money = [{1, 40000}],
		get_goods_list = []
};

get(70520) ->
	#compose_goods{
		no = 70520,
		op_no = 1,
		need_goods_list = [{70519,2}],
		money = [{1, 50000}],
		get_goods_list = []
};

get(70132) ->
	#compose_goods{
		no = 70132,
		op_no = 1,
		need_goods_list = [{70131,2}],
		money = [{1, 2000}],
		get_goods_list = []
};

get(70133) ->
	#compose_goods{
		no = 70133,
		op_no = 1,
		need_goods_list = [{70132,2}],
		money = [{1, 3000}],
		get_goods_list = []
};

get(70134) ->
	#compose_goods{
		no = 70134,
		op_no = 1,
		need_goods_list = [{70133,2}],
		money = [{1, 4000}],
		get_goods_list = []
};

get(70135) ->
	#compose_goods{
		no = 70135,
		op_no = 1,
		need_goods_list = [{70134,2}],
		money = [{1, 5000}],
		get_goods_list = []
};

get(70136) ->
	#compose_goods{
		no = 70136,
		op_no = 1,
		need_goods_list = [{70135,2}],
		money = [{1, 6000}],
		get_goods_list = []
};

get(70137) ->
	#compose_goods{
		no = 70137,
		op_no = 1,
		need_goods_list = [{70136,2}],
		money = [{1, 8000}],
		get_goods_list = []
};

get(70138) ->
	#compose_goods{
		no = 70138,
		op_no = 1,
		need_goods_list = [{70137,2}],
		money = [{1, 10000}],
		get_goods_list = []
};

get(70139) ->
	#compose_goods{
		no = 70139,
		op_no = 1,
		need_goods_list = [{70138,2}],
		money = [{1, 12000}],
		get_goods_list = []
};

get(70140) ->
	#compose_goods{
		no = 70140,
		op_no = 1,
		need_goods_list = [{70139,2}],
		money = [{1, 15000}],
		get_goods_list = []
};

get(70525) ->
	#compose_goods{
		no = 70525,
		op_no = 1,
		need_goods_list = [{70140,2}],
		money = [{1, 20000}],
		get_goods_list = []
};

get(70526) ->
	#compose_goods{
		no = 70526,
		op_no = 1,
		need_goods_list = [{70525,2}],
		money = [{1, 30000}],
		get_goods_list = []
};

get(70527) ->
	#compose_goods{
		no = 70527,
		op_no = 1,
		need_goods_list = [{70526,2}],
		money = [{1, 40000}],
		get_goods_list = []
};

get(70528) ->
	#compose_goods{
		no = 70528,
		op_no = 1,
		need_goods_list = [{70527,2}],
		money = [{1, 50000}],
		get_goods_list = []
};

get(70142) ->
	#compose_goods{
		no = 70142,
		op_no = 1,
		need_goods_list = [{70141,2}],
		money = [{1, 2000}],
		get_goods_list = []
};

get(70143) ->
	#compose_goods{
		no = 70143,
		op_no = 1,
		need_goods_list = [{70142,2}],
		money = [{1, 3000}],
		get_goods_list = []
};

get(70144) ->
	#compose_goods{
		no = 70144,
		op_no = 1,
		need_goods_list = [{70143,2}],
		money = [{1, 4000}],
		get_goods_list = []
};

get(70145) ->
	#compose_goods{
		no = 70145,
		op_no = 1,
		need_goods_list = [{70144,2}],
		money = [{1, 5000}],
		get_goods_list = []
};

get(70146) ->
	#compose_goods{
		no = 70146,
		op_no = 1,
		need_goods_list = [{70145,2}],
		money = [{1, 6000}],
		get_goods_list = []
};

get(70147) ->
	#compose_goods{
		no = 70147,
		op_no = 1,
		need_goods_list = [{70146,2}],
		money = [{1, 8000}],
		get_goods_list = []
};

get(70148) ->
	#compose_goods{
		no = 70148,
		op_no = 1,
		need_goods_list = [{70147,2}],
		money = [{1, 10000}],
		get_goods_list = []
};

get(70149) ->
	#compose_goods{
		no = 70149,
		op_no = 1,
		need_goods_list = [{70148,2}],
		money = [{1, 12000}],
		get_goods_list = []
};

get(70150) ->
	#compose_goods{
		no = 70150,
		op_no = 1,
		need_goods_list = [{70149,2}],
		money = [{1, 15000}],
		get_goods_list = []
};

get(70533) ->
	#compose_goods{
		no = 70533,
		op_no = 1,
		need_goods_list = [{70150,2}],
		money = [{1, 20000}],
		get_goods_list = []
};

get(70534) ->
	#compose_goods{
		no = 70534,
		op_no = 1,
		need_goods_list = [{70533,2}],
		money = [{1, 30000}],
		get_goods_list = []
};

get(70535) ->
	#compose_goods{
		no = 70535,
		op_no = 1,
		need_goods_list = [{70534,2}],
		money = [{1, 40000}],
		get_goods_list = []
};

get(70536) ->
	#compose_goods{
		no = 70536,
		op_no = 1,
		need_goods_list = [{70535,2}],
		money = [{1, 50000}],
		get_goods_list = []
};

get(70242) ->
	#compose_goods{
		no = 70242,
		op_no = 1,
		need_goods_list = [{70241,2}],
		money = [{1, 2000}],
		get_goods_list = []
};

get(70243) ->
	#compose_goods{
		no = 70243,
		op_no = 1,
		need_goods_list = [{70242,2}],
		money = [{1, 3000}],
		get_goods_list = []
};

get(70244) ->
	#compose_goods{
		no = 70244,
		op_no = 1,
		need_goods_list = [{70243,2}],
		money = [{1, 4000}],
		get_goods_list = []
};

get(70245) ->
	#compose_goods{
		no = 70245,
		op_no = 1,
		need_goods_list = [{70244,2}],
		money = [{1, 5000}],
		get_goods_list = []
};

get(70246) ->
	#compose_goods{
		no = 70246,
		op_no = 1,
		need_goods_list = [{70245,2}],
		money = [{1, 6000}],
		get_goods_list = []
};

get(70247) ->
	#compose_goods{
		no = 70247,
		op_no = 1,
		need_goods_list = [{70246,2}],
		money = [{1, 8000}],
		get_goods_list = []
};

get(70248) ->
	#compose_goods{
		no = 70248,
		op_no = 1,
		need_goods_list = [{70247,2}],
		money = [{1, 10000}],
		get_goods_list = []
};

get(70249) ->
	#compose_goods{
		no = 70249,
		op_no = 1,
		need_goods_list = [{70248,2}],
		money = [{1, 12000}],
		get_goods_list = []
};

get(70250) ->
	#compose_goods{
		no = 70250,
		op_no = 1,
		need_goods_list = [{70249,2}],
		money = [{1, 15000}],
		get_goods_list = []
};

get(70541) ->
	#compose_goods{
		no = 70541,
		op_no = 1,
		need_goods_list = [{70250,2}],
		money = [{1, 20000}],
		get_goods_list = []
};

get(70542) ->
	#compose_goods{
		no = 70542,
		op_no = 1,
		need_goods_list = [{70541,2}],
		money = [{1, 30000}],
		get_goods_list = []
};

get(70543) ->
	#compose_goods{
		no = 70543,
		op_no = 1,
		need_goods_list = [{70542,2}],
		money = [{1, 40000}],
		get_goods_list = []
};

get(70544) ->
	#compose_goods{
		no = 70544,
		op_no = 1,
		need_goods_list = [{70543,2}],
		money = [{1, 50000}],
		get_goods_list = []
};

get(70302) ->
	#compose_goods{
		no = 70302,
		op_no = 1,
		need_goods_list = [{70301,2}],
		money = [{1, 2000}],
		get_goods_list = []
};

get(70303) ->
	#compose_goods{
		no = 70303,
		op_no = 1,
		need_goods_list = [{70302,2}],
		money = [{1, 3000}],
		get_goods_list = []
};

get(70304) ->
	#compose_goods{
		no = 70304,
		op_no = 1,
		need_goods_list = [{70303,2}],
		money = [{1, 4000}],
		get_goods_list = []
};

get(70305) ->
	#compose_goods{
		no = 70305,
		op_no = 1,
		need_goods_list = [{70304,2}],
		money = [{1, 5000}],
		get_goods_list = []
};

get(70306) ->
	#compose_goods{
		no = 70306,
		op_no = 1,
		need_goods_list = [{70305,2}],
		money = [{1, 6000}],
		get_goods_list = []
};

get(70307) ->
	#compose_goods{
		no = 70307,
		op_no = 1,
		need_goods_list = [{70306,2}],
		money = [{1, 8000}],
		get_goods_list = []
};

get(70308) ->
	#compose_goods{
		no = 70308,
		op_no = 1,
		need_goods_list = [{70307,2}],
		money = [{1, 10000}],
		get_goods_list = []
};

get(70309) ->
	#compose_goods{
		no = 70309,
		op_no = 1,
		need_goods_list = [{70308,2}],
		money = [{1, 12000}],
		get_goods_list = []
};

get(70310) ->
	#compose_goods{
		no = 70310,
		op_no = 1,
		need_goods_list = [{70309,2}],
		money = [{1, 15000}],
		get_goods_list = []
};

get(70549) ->
	#compose_goods{
		no = 70549,
		op_no = 1,
		need_goods_list = [{70310,2}],
		money = [{1, 20000}],
		get_goods_list = []
};

get(70550) ->
	#compose_goods{
		no = 70550,
		op_no = 1,
		need_goods_list = [{70549,2}],
		money = [{1, 30000}],
		get_goods_list = []
};

get(70551) ->
	#compose_goods{
		no = 70551,
		op_no = 1,
		need_goods_list = [{70550,2}],
		money = [{1, 40000}],
		get_goods_list = []
};

get(70552) ->
	#compose_goods{
		no = 70552,
		op_no = 1,
		need_goods_list = [{70551,2}],
		money = [{1, 50000}],
		get_goods_list = []
};

get(70312) ->
	#compose_goods{
		no = 70312,
		op_no = 1,
		need_goods_list = [{70311,2}],
		money = [{1, 2000}],
		get_goods_list = []
};

get(70313) ->
	#compose_goods{
		no = 70313,
		op_no = 1,
		need_goods_list = [{70312,2}],
		money = [{1, 3000}],
		get_goods_list = []
};

get(70314) ->
	#compose_goods{
		no = 70314,
		op_no = 1,
		need_goods_list = [{70313,2}],
		money = [{1, 4000}],
		get_goods_list = []
};

get(70315) ->
	#compose_goods{
		no = 70315,
		op_no = 1,
		need_goods_list = [{70314,2}],
		money = [{1, 5000}],
		get_goods_list = []
};

get(70316) ->
	#compose_goods{
		no = 70316,
		op_no = 1,
		need_goods_list = [{70315,2}],
		money = [{1, 6000}],
		get_goods_list = []
};

get(70317) ->
	#compose_goods{
		no = 70317,
		op_no = 1,
		need_goods_list = [{70316,2}],
		money = [{1, 8000}],
		get_goods_list = []
};

get(70318) ->
	#compose_goods{
		no = 70318,
		op_no = 1,
		need_goods_list = [{70317,2}],
		money = [{1, 10000}],
		get_goods_list = []
};

get(70319) ->
	#compose_goods{
		no = 70319,
		op_no = 1,
		need_goods_list = [{70318,2}],
		money = [{1, 12000}],
		get_goods_list = []
};

get(70320) ->
	#compose_goods{
		no = 70320,
		op_no = 1,
		need_goods_list = [{70319,2}],
		money = [{1, 15000}],
		get_goods_list = []
};

get(70557) ->
	#compose_goods{
		no = 70557,
		op_no = 1,
		need_goods_list = [{70320,2}],
		money = [{1, 20000}],
		get_goods_list = []
};

get(70558) ->
	#compose_goods{
		no = 70558,
		op_no = 1,
		need_goods_list = [{70557,2}],
		money = [{1, 30000}],
		get_goods_list = []
};

get(70559) ->
	#compose_goods{
		no = 70559,
		op_no = 1,
		need_goods_list = [{70558,2}],
		money = [{1, 40000}],
		get_goods_list = []
};

get(70560) ->
	#compose_goods{
		no = 70560,
		op_no = 1,
		need_goods_list = [{70559,2}],
		money = [{1, 50000}],
		get_goods_list = []
};

get(72205) ->
	#compose_goods{
		no = 72205,
		op_no = 3,
		need_goods_list = [{72204,2}],
		money = [{1, 2000}],
		get_goods_list = []
};

get(72206) ->
	#compose_goods{
		no = 72206,
		op_no = 3,
		need_goods_list = [{72205,2}],
		money = [{1, 4000}],
		get_goods_list = []
};

get(72207) ->
	#compose_goods{
		no = 72207,
		op_no = 3,
		need_goods_list = [{72206,2}],
		money = [{1, 6000}],
		get_goods_list = []
};

get(72208) ->
	#compose_goods{
		no = 72208,
		op_no = 3,
		need_goods_list = [{72207,2}],
		money = [{1, 8000}],
		get_goods_list = []
};

get(72209) ->
	#compose_goods{
		no = 72209,
		op_no = 3,
		need_goods_list = [{72208,2}],
		money = [{1, 10000}],
		get_goods_list = []
};

get(72210) ->
	#compose_goods{
		no = 72210,
		op_no = 3,
		need_goods_list = [{72209,2}],
		money = [{1, 13000}],
		get_goods_list = []
};

get(72211) ->
	#compose_goods{
		no = 72211,
		op_no = 3,
		need_goods_list = [{72210,2}],
		money = [{1, 26000}],
		get_goods_list = []
};

get(72212) ->
	#compose_goods{
		no = 72212,
		op_no = 3,
		need_goods_list = [{72211,2}],
		money = [{1, 30000}],
		get_goods_list = []
};

get(72213) ->
	#compose_goods{
		no = 72213,
		op_no = 3,
		need_goods_list = [{72212,2}],
		money = [{1, 40000}],
		get_goods_list = []
};

get(72214) ->
	#compose_goods{
		no = 72214,
		op_no = 3,
		need_goods_list = [{72213,2}],
		money = [{1, 50000}],
		get_goods_list = []
};

get(72215) ->
	#compose_goods{
		no = 72215,
		op_no = 3,
		need_goods_list = [{72214,2}],
		money = [{1, 60000}],
		get_goods_list = []
};

get(72216) ->
	#compose_goods{
		no = 72216,
		op_no = 3,
		need_goods_list = [{72215,2}],
		money = [{1, 70000}],
		get_goods_list = []
};

get(72217) ->
	#compose_goods{
		no = 72217,
		op_no = 3,
		need_goods_list = [{72216,2}],
		money = [{1, 80000}],
		get_goods_list = []
};

get(72218) ->
	#compose_goods{
		no = 72218,
		op_no = 3,
		need_goods_list = [{72217,2}],
		money = [{1, 90000}],
		get_goods_list = []
};

get(55109) ->
	#compose_goods{
		no = 55109,
		op_no = 3,
		need_goods_list = [{55100,200}],
		money = [{1, 10000}],
		get_goods_list = []
};

get(55110) ->
	#compose_goods{
		no = 55110,
		op_no = 3,
		need_goods_list = [{55100,200}],
		money = [{1, 10000}],
		get_goods_list = []
};

get(55111) ->
	#compose_goods{
		no = 55111,
		op_no = 3,
		need_goods_list = [{55100,200}],
		money = [{1, 10000}],
		get_goods_list = []
};

get(55112) ->
	#compose_goods{
		no = 55112,
		op_no = 3,
		need_goods_list = [{55100,200}],
		money = [{1, 10000}],
		get_goods_list = []
};

get(55113) ->
	#compose_goods{
		no = 55113,
		op_no = 3,
		need_goods_list = [{55100,200}],
		money = [{1, 10000}],
		get_goods_list = []
};

get(20004) ->
	#compose_goods{
		no = 20004,
		op_no = 3,
		need_goods_list = [{20003,30}],
		money = [{1, 10000}],
		get_goods_list = []
};

get(20012) ->
	#compose_goods{
		no = 20012,
		op_no = 3,
		need_goods_list = [{20011,30}],
		money = [{1, 10000}],
		get_goods_list = []
};

get(20008) ->
	#compose_goods{
		no = 20008,
		op_no = 3,
		need_goods_list = [{20007,30}],
		money = [{1, 10000}],
		get_goods_list = []
};

get(20018) ->
	#compose_goods{
		no = 20018,
		op_no = 3,
		need_goods_list = [{20017,30}],
		money = [{1, 10000}],
		get_goods_list = []
};

get(_No) ->
	      ?ASSERT(false, _No),
          null.

