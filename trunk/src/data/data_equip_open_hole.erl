%%%---------------------------------------
%%% @Module  : data_equip_open_hole
%%% @Author  : zwq
%%% @Email   : 
%%% @Description:  装备开孔消耗表
%%%---------------------------------------


-module(data_equip_open_hole).
-include("common.hrl").
-include("record.hrl").
-include("record/goods_record.hrl").
-compile(export_all).

get(1) ->
	#equip_open_hole{
		no = 1,
		need_goods_list = [{70100,1}]
};

get(2) ->
	#equip_open_hole{
		no = 2,
		need_goods_list = [{70100,2}]
};

get(3) ->
	#equip_open_hole{
		no = 3,
		need_goods_list = [{70100,4}]
};

get(4) ->
	#equip_open_hole{
		no = 4,
		need_goods_list = [{70100,8}]
};

get(_No) ->
	      ?ASSERT(false, _No),
          null.

