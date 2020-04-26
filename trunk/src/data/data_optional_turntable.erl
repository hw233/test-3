%%%---------------------------------------
%%% @Module  : data_optional_turntable
%%% @Author  : 
%%% @Email   : 
%%% @Description:  自选转盘配置表
%%%---------------------------------------


-module(data_optional_turntable).

-include("optional_turntable.hrl").
-include("debug.hrl").
-compile(export_all).

get(1) ->
	#optional_turntable{
		no = 1,
		trigger_prob = 900,
		partition = 0,
		goods_type = 4,
		reward = [{62572,10,3,5}],
		notice = 412
};

get(2) ->
	#optional_turntable{
		no = 2,
		trigger_prob = 1000,
		partition = 0,
		goods_type = 4,
		reward = [{62575,3,3,5}],
		notice = 412
};

get(3) ->
	#optional_turntable{
		no = 3,
		trigger_prob = 1000,
		partition = 0,
		goods_type = 4,
		reward = [{62574,3,3,5}],
		notice = 412
};

get(4) ->
	#optional_turntable{
		no = 4,
		trigger_prob = 1000,
		partition = 0,
		goods_type = 4,
		reward = [{62573,3,3,5}],
		notice = 412
};

get(5) ->
	#optional_turntable{
		no = 5,
		trigger_prob = 500,
		partition = 0,
		goods_type = 4,
		reward = [{20041,5,3,5}],
		notice = 412
};

get(6) ->
	#optional_turntable{
		no = 6,
		trigger_prob = 200,
		partition = 0,
		goods_type = 4,
		reward = [{62456,1,3,5}],
		notice = 412
};

get(7) ->
	#optional_turntable{
		no = 7,
		trigger_prob = 800,
		partition = 0,
		goods_type = 4,
		reward = [{70579,10,3,5}],
		notice = 412
};

get(8) ->
	#optional_turntable{
		no = 8,
		trigger_prob = 800,
		partition = 0,
		goods_type = 4,
		reward = [{89324,10,3,5}],
		notice = 412
};

get(9) ->
	#optional_turntable{
		no = 9,
		trigger_prob = 800,
		partition = 0,
		goods_type = 4,
		reward = [{89326,10,3,5}],
		notice = 412
};

get(10) ->
	#optional_turntable{
		no = 10,
		trigger_prob = 800,
		partition = 0,
		goods_type = 4,
		reward = [{89325,10,3,5}],
		notice = 412
};

get(11) ->
	#optional_turntable{
		no = 11,
		trigger_prob = 800,
		partition = 1,
		goods_type = 3,
		reward = [{62544,5,3,5}],
		notice = 0
};

get(12) ->
	#optional_turntable{
		no = 12,
		trigger_prob = 800,
		partition = 1,
		goods_type = 3,
		reward = [{62547,3,3,5}],
		notice = 0
};

get(13) ->
	#optional_turntable{
		no = 13,
		trigger_prob = 800,
		partition = 1,
		goods_type = 3,
		reward = [{62548,3,3,5}],
		notice = 0
};

get(14) ->
	#optional_turntable{
		no = 14,
		trigger_prob = 800,
		partition = 1,
		goods_type = 3,
		reward = [{62549,3,3,5}],
		notice = 0
};

get(15) ->
	#optional_turntable{
		no = 15,
		trigger_prob = 1300,
		partition = 1,
		goods_type = 3,
		reward = [{62034,50,3,3}],
		notice = 0
};

get(16) ->
	#optional_turntable{
		no = 16,
		trigger_prob = 4000,
		partition = 1,
		goods_type = 3,
		reward = [{60027,10,3,3}],
		notice = 0
};

get(17) ->
	#optional_turntable{
		no = 17,
		trigger_prob = 800,
		partition = 1,
		goods_type = 3,
		reward = [{20040,50,3,4}],
		notice = 0
};

get(18) ->
	#optional_turntable{
		no = 18,
		trigger_prob = 800,
		partition = 1,
		goods_type = 3,
		reward = [{62335,5,3,3}],
		notice = 0
};

get(19) ->
	#optional_turntable{
		no = 19,
		trigger_prob = 800,
		partition = 1,
		goods_type = 3,
		reward = [{70578,50,3,5}],
		notice = 0
};

get(20) ->
	#optional_turntable{
		no = 20,
		trigger_prob = 5000,
		partition = 1,
		goods_type = 3,
		reward = [{62496,1,3,3}],
		notice = 0
};

get(21) ->
	#optional_turntable{
		no = 21,
		trigger_prob = 1200,
		partition = 2,
		goods_type = 2,
		reward = [{62161,30,3,3}],
		notice = 0
};

get(22) ->
	#optional_turntable{
		no = 22,
		trigger_prob = 800,
		partition = 2,
		goods_type = 2,
		reward = [{62317,10,3,4}],
		notice = 0
};

get(23) ->
	#optional_turntable{
		no = 23,
		trigger_prob = 800,
		partition = 2,
		goods_type = 2,
		reward = [{62318,10,3,4}],
		notice = 0
};

get(24) ->
	#optional_turntable{
		no = 24,
		trigger_prob = 800,
		partition = 2,
		goods_type = 2,
		reward = [{62319,10,3,4}],
		notice = 0
};

get(25) ->
	#optional_turntable{
		no = 25,
		trigger_prob = 1000,
		partition = 2,
		goods_type = 2,
		reward = [{62335,3,3,3}],
		notice = 0
};

get(26) ->
	#optional_turntable{
		no = 26,
		trigger_prob = 1500,
		partition = 2,
		goods_type = 2,
		reward = [{62032,200,3,3}],
		notice = 0
};

get(27) ->
	#optional_turntable{
		no = 27,
		trigger_prob = 3000,
		partition = 2,
		goods_type = 2,
		reward = [{20023,30,3,3}],
		notice = 0
};

get(28) ->
	#optional_turntable{
		no = 28,
		trigger_prob = 4000,
		partition = 2,
		goods_type = 2,
		reward = [{20014,50,3,3}],
		notice = 0
};

get(29) ->
	#optional_turntable{
		no = 29,
		trigger_prob = 2000,
		partition = 2,
		goods_type = 2,
		reward = [{62542,2,3,3}],
		notice = 0
};

get(30) ->
	#optional_turntable{
		no = 30,
		trigger_prob = 2000,
		partition = 2,
		goods_type = 2,
		reward = [{62543,2,3,3}],
		notice = 0
};

get(31) ->
	#optional_turntable{
		no = 31,
		trigger_prob = 2000,
		partition = 3,
		goods_type = 1,
		reward = [{60101,100,3,3}],
		notice = 0
};

get(32) ->
	#optional_turntable{
		no = 32,
		trigger_prob = 2000,
		partition = 3,
		goods_type = 1,
		reward = [{62349,100,3,5}],
		notice = 0
};

get(33) ->
	#optional_turntable{
		no = 33,
		trigger_prob = 1800,
		partition = 3,
		goods_type = 1,
		reward = [{70577,50,3,5}],
		notice = 0
};

get(34) ->
	#optional_turntable{
		no = 34,
		trigger_prob = 2000,
		partition = 3,
		goods_type = 1,
		reward = [{10043,100,3,3}],
		notice = 0
};

get(35) ->
	#optional_turntable{
		no = 35,
		trigger_prob = 2000,
		partition = 3,
		goods_type = 1,
		reward = [{70054,200,3,5}],
		notice = 0
};

get(36) ->
	#optional_turntable{
		no = 36,
		trigger_prob = 2000,
		partition = 3,
		goods_type = 1,
		reward = [{50307,100,3,4}],
		notice = 0
};

get(37) ->
	#optional_turntable{
		no = 37,
		trigger_prob = 1800,
		partition = 3,
		goods_type = 1,
		reward = [{50038,100,3,4}],
		notice = 0
};

get(38) ->
	#optional_turntable{
		no = 38,
		trigger_prob = 1500,
		partition = 3,
		goods_type = 1,
		reward = [{62316,1,3,4}],
		notice = 0
};

get(39) ->
	#optional_turntable{
		no = 39,
		trigger_prob = 1500,
		partition = 3,
		goods_type = 1,
		reward = [{70055,200,3,3}],
		notice = 0
};

get(40) ->
	#optional_turntable{
		no = 40,
		trigger_prob = 1500,
		partition = 3,
		goods_type = 1,
		reward = [{70056,200,3,3}],
		notice = 0
};

get(_No) ->
	      ?ASSERT(false, _No),
          null.

