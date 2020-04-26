%%%---------------------------------------
%%% @Module  : data_xunbao_xuyuanchi_draw
%%% @Author  : lzx
%%% @Email   : 
%%% @Description: 寻宝许愿池转盘配置表
%%%---------------------------------------


-module(data_xunbao_xuyuanchi_draw).
-compile(export_all).

-include("luck_info.hrl").
-include("debug.hrl").

get_xunbao_no()->
	[1,2,3,4,5,6,7,8,9,10,11,12].

get_xuyuanchi_no()->
	[13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28].

get(1) ->
	#xunbao_xuyuanchi_draw{
		no = 1,
		type = 1,
		prob = 1,
		goods_type = 4,
		reward = [{20030,1,0,3}],
		notice = 405
};

get(2) ->
	#xunbao_xuyuanchi_draw{
		no = 2,
		type = 1,
		prob = 2000,
		goods_type = 0,
		reward = [{50398,10,0,3}],
		notice = 0
};

get(3) ->
	#xunbao_xuyuanchi_draw{
		no = 3,
		type = 1,
		prob = 2000,
		goods_type = 0,
		reward = [{62349,10,0,3}],
		notice = 0
};

get(4) ->
	#xunbao_xuyuanchi_draw{
		no = 4,
		type = 1,
		prob = 100,
		goods_type = 1,
		reward = [{62373,10,0,3}],
		notice = 405
};

get(5) ->
	#xunbao_xuyuanchi_draw{
		no = 5,
		type = 1,
		prob = 500,
		goods_type = 0,
		reward = [{62335,1,0,3}],
		notice = 0
};

get(6) ->
	#xunbao_xuyuanchi_draw{
		no = 6,
		type = 1,
		prob = 1200,
		goods_type = 0,
		reward = [{60101,100,0,3}],
		notice = 0
};

get(7) ->
	#xunbao_xuyuanchi_draw{
		no = 7,
		type = 1,
		prob = 1,
		goods_type = 3,
		reward = [{20028,1,0,3}],
		notice = 405
};

get(8) ->
	#xunbao_xuyuanchi_draw{
		no = 8,
		type = 1,
		prob = 1200,
		goods_type = 0,
		reward = [{62034,1,0,3}],
		notice = 0
};

get(9) ->
	#xunbao_xuyuanchi_draw{
		no = 9,
		type = 1,
		prob = 1500,
		goods_type = 0,
		reward = [{10043,100,0,3}],
		notice = 0
};

get(10) ->
	#xunbao_xuyuanchi_draw{
		no = 10,
		type = 1,
		prob = 10,
		goods_type = 2,
		reward = [{62543,2,0,3}],
		notice = 405
};

get(11) ->
	#xunbao_xuyuanchi_draw{
		no = 11,
		type = 1,
		prob = 1500,
		goods_type = 0,
		reward = [{50307,100,0,3}],
		notice = 0
};

get(12) ->
	#xunbao_xuyuanchi_draw{
		no = 12,
		type = 1,
		prob = 1500,
		goods_type = 0,
		reward = [{50038,100,0,3}],
		notice = 0
};

get(13) ->
	#xunbao_xuyuanchi_draw{
		no = 13,
		type = 2,
		prob = 1,
		goods_type = 1,
		reward = [{89127,1,0,3}],
		notice = 406
};

get(14) ->
	#xunbao_xuyuanchi_draw{
		no = 14,
		type = 2,
		prob = 100,
		goods_type = 0,
		reward = [{62542,2,0,3}],
		notice = 0
};

get(15) ->
	#xunbao_xuyuanchi_draw{
		no = 15,
		type = 2,
		prob = 250,
		goods_type = 0,
		reward = [{89323,50,0,3}],
		notice = 0
};

get(16) ->
	#xunbao_xuyuanchi_draw{
		no = 16,
		type = 2,
		prob = 1000,
		goods_type = 0,
		reward = [{20040,50,0,3}],
		notice = 0
};

get(17) ->
	#xunbao_xuyuanchi_draw{
		no = 17,
		type = 2,
		prob = 500,
		goods_type = 0,
		reward = [{70579,2,0,3}],
		notice = 406
};

get(18) ->
	#xunbao_xuyuanchi_draw{
		no = 18,
		type = 2,
		prob = 1,
		goods_type = 2,
		reward = [{89301,1,0,3}],
		notice = 406
};

get(19) ->
	#xunbao_xuyuanchi_draw{
		no = 19,
		type = 2,
		prob = 2500,
		goods_type = 0,
		reward = [{62161,5,0,3}],
		notice = 406
};

get(20) ->
	#xunbao_xuyuanchi_draw{
		no = 20,
		type = 2,
		prob = 2000,
		goods_type = 0,
		reward = [{62161,10,0,3}],
		notice = 406
};

get(21) ->
	#xunbao_xuyuanchi_draw{
		no = 21,
		type = 2,
		prob = 1,
		goods_type = 3,
		reward = [{89315,1,0,3}],
		notice = 406
};

get(22) ->
	#xunbao_xuyuanchi_draw{
		no = 22,
		type = 2,
		prob = 1500,
		goods_type = 0,
		reward = [{62034,5,0,3}],
		notice = 0
};

get(23) ->
	#xunbao_xuyuanchi_draw{
		no = 23,
		type = 2,
		prob = 1500,
		goods_type = 0,
		reward = [{70576,50,0,3}],
		notice = 0
};

get(24) ->
	#xunbao_xuyuanchi_draw{
		no = 24,
		type = 2,
		prob = 1000,
		goods_type = 0,
		reward = [{70577,50,0,3}],
		notice = 0
};

get(25) ->
	#xunbao_xuyuanchi_draw{
		no = 25,
		type = 2,
		prob = 500,
		goods_type = 0,
		reward = [{70578,50,0,3}],
		notice = 406
};

get(26) ->
	#xunbao_xuyuanchi_draw{
		no = 26,
		type = 2,
		prob = 1,
		goods_type = 4,
		reward = [{89307,1,0,3}],
		notice = 406
};

get(27) ->
	#xunbao_xuyuanchi_draw{
		no = 27,
		type = 2,
		prob = 2500,
		goods_type = 0,
		reward = [{70055,200,0,3}],
		notice = 0
};

get(28) ->
	#xunbao_xuyuanchi_draw{
		no = 28,
		type = 2,
		prob = 2500,
		goods_type = 0,
		reward = [{70056,200,0,3}],
		notice = 0
};

get(_No) ->
	?ASSERT(false, {_No}),
    null.

