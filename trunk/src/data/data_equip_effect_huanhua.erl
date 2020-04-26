%%%---------------------------------------
%%% @Module  : data_equip_effect_huanhua
%%% @Author  : lzx
%%% @Email   : 
%%% @Description:  装备幻化配置表
%%%---------------------------------------


-module(data_equip_effect_huanhua).

-include("record/goods_record.hrl").
-include("debug.hrl").
-export([get/1]).

get(20) ->
	#equip_effect_huanhua{
		lv = 20,
		huanhua_material = 70576,
		huanhua_material_count = 50,
		price_type = 1,
		price = 500000,
		success_rate = 60,
		amulet = 70579,
		amulet_count = 20,
		amulet_success_rate = 100
};

get(60) ->
	#equip_effect_huanhua{
		lv = 60,
		huanhua_material = 70576,
		huanhua_material_count = 50,
		price_type = 1,
		price = 500000,
		success_rate = 60,
		amulet = 70579,
		amulet_count = 20,
		amulet_success_rate = 100
};

get(120) ->
	#equip_effect_huanhua{
		lv = 120,
		huanhua_material = 70576,
		huanhua_material_count = 50,
		price_type = 1,
		price = 500000,
		success_rate = 60,
		amulet = 70579,
		amulet_count = 20,
		amulet_success_rate = 100
};

get(140) ->
	#equip_effect_huanhua{
		lv = 140,
		huanhua_material = 70576,
		huanhua_material_count = 50,
		price_type = 1,
		price = 500000,
		success_rate = 60,
		amulet = 70579,
		amulet_count = 20,
		amulet_success_rate = 100
};

get(160) ->
	#equip_effect_huanhua{
		lv = 160,
		huanhua_material = 70576,
		huanhua_material_count = 50,
		price_type = 1,
		price = 500000,
		success_rate = 60,
		amulet = 70579,
		amulet_count = 20,
		amulet_success_rate = 100
};

get(180) ->
	#equip_effect_huanhua{
		lv = 180,
		huanhua_material = 70576,
		huanhua_material_count = 50,
		price_type = 1,
		price = 500000,
		success_rate = 60,
		amulet = 70579,
		amulet_count = 20,
		amulet_success_rate = 100
};

get(200) ->
	#equip_effect_huanhua{
		lv = 200,
		huanhua_material = 70577,
		huanhua_material_count = 100,
		price_type = 2,
		price = 200,
		success_rate = 40,
		amulet = 70579,
		amulet_count = 50,
		amulet_success_rate = 100
};

get(220) ->
	#equip_effect_huanhua{
		lv = 220,
		huanhua_material = 70577,
		huanhua_material_count = 100,
		price_type = 2,
		price = 200,
		success_rate = 40,
		amulet = 70579,
		amulet_count = 50,
		amulet_success_rate = 100
};

get(250) ->
	#equip_effect_huanhua{
		lv = 250,
		huanhua_material = 70578,
		huanhua_material_count = 150,
		price_type = 2,
		price = 500,
		success_rate = 20,
		amulet = 70579,
		amulet_count = 80,
		amulet_success_rate = 100
};

get(300) ->
	#equip_effect_huanhua{
		lv = 300,
		huanhua_material = 70578,
		huanhua_material_count = 150,
		price_type = 2,
		price = 500,
		success_rate = 20,
		amulet = 70579,
		amulet_count = 80,
		amulet_success_rate = 100
};

get(_Lv) ->
	      ?ASSERT(false),
          null.

