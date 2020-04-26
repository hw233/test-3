%%%---------------------------------------
%%% @Module  : data_xunbao_xuyuanchi_cost
%%% @Author  : lzx
%%% @Email   : 
%%% @Description: 寻宝许愿池转盘消耗表
%%%---------------------------------------


-module(data_xunbao_xuyuanchi_cost).
-compile(export_all).

-include("luck_info.hrl").
-include("debug.hrl").

get_xunbao_no()->
	[1,2,3].

get_xuyuanchi_no()->
	[4,5,6].

get(1) ->
	#xunbao_xuyuanchi_cost{
		no = 1,
		type = 1,
		num = 1,
		draw_cost = {89002, 50000}
};

get(2) ->
	#xunbao_xuyuanchi_cost{
		no = 2,
		type = 1,
		num = 10,
		draw_cost = {89002, 450000}
};

get(3) ->
	#xunbao_xuyuanchi_cost{
		no = 3,
		type = 1,
		num = 1,
		draw_cost = {62542, 1}
};

get(4) ->
	#xunbao_xuyuanchi_cost{
		no = 4,
		type = 2,
		num = 1,
		draw_cost = {89058, 300}
};

get(5) ->
	#xunbao_xuyuanchi_cost{
		no = 5,
		type = 2,
		num = 10,
		draw_cost = {89058, 2700}
};

get(6) ->
	#xunbao_xuyuanchi_cost{
		no = 6,
		type = 2,
		num = 1,
		draw_cost = {62543, 1}
};

get(_No) ->
	?ASSERT(false, {_No}),
    null.

