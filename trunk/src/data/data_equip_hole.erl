%%%---------------------------------------
%%% @Module  : data_equip_hole
%%% @Author  : zhangwq
%%% @Email   : 
%%% @Description: 装备生成时开的宝石孔个数
%%%---------------------------------------


-module(data_equip_hole).
-export([
        get_all_no_list/0,
        get/1
    ]).

-include("record/goods_record.hrl").
-include("debug.hrl").

get_all_no_list()->
	[1,2,3,4,5].

get(1) ->
	#equip_hole{
		no = 1,
		hole_no = 0,
		proba = 0
};

get(2) ->
	#equip_hole{
		no = 2,
		hole_no = 1,
		proba = 0
};

get(3) ->
	#equip_hole{
		no = 3,
		hole_no = 2,
		proba = 0
};

get(4) ->
	#equip_hole{
		no = 4,
		hole_no = 3,
		proba = 0
};

get(5) ->
	#equip_hole{
		no = 5,
		hole_no = 4,
		proba = 100
};

get(_No) ->
	?ASSERT(false, _No),
    null.

