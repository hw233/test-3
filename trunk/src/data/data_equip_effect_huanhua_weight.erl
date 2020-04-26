%%%---------------------------------------
%%% @Module  : data_equip_effect_huanhua_weight
%%% @Author  : lzx
%%% @Email   : 
%%% @Description:  装备幻化效果权重配置表
%%%---------------------------------------


-module(data_equip_effect_huanhua_weight).

-include("record/goods_record.hrl").
-include("debug.hrl").
-compile(export_all).

get(1) ->
	#equip_effect_huanhua_weight{
		no = 1,
		huanhua_effect_weight = [{1,0,500},{2,0,300},{3,0,100},{0,1,200},{1,1,100},{2,1,50},{3,1,10}]
};

get(2) ->
	#equip_effect_huanhua_weight{
		no = 2,
		huanhua_effect_weight = [{1,0,500},{2,0,300},{3,0,100}]
};

get(_No) ->
	      ?ASSERT(false, _No),
          null.

