%%%---------------------------------------
%%% @Module  : data_lilian_sys_open
%%% @Author  : lzx
%%% @Email   : 
%%% @Description: 历练系统开发表
%%%---------------------------------------


-module(data_lilian_sys_open).
-export([get_no/0,get/1]).
-include("chapter_target.hrl").
-include("debug.hrl").

get_no()->
	[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35].

get(1) ->
	#lilian_sys_open{
		no = 1,
		type = 1,
		reward = 91570
};

get(2) ->
	#lilian_sys_open{
		no = 2,
		type = 2,
		reward = 91573
};

get(3) ->
	#lilian_sys_open{
		no = 3,
		type = 1,
		reward = 91576
};

get(4) ->
	#lilian_sys_open{
		no = 4,
		type = 1,
		reward = 91575
};

get(5) ->
	#lilian_sys_open{
		no = 5,
		type = 2,
		reward = 91572
};

get(6) ->
	#lilian_sys_open{
		no = 6,
		type = 1,
		reward = 91580
};

get(7) ->
	#lilian_sys_open{
		no = 7,
		type = 1,
		reward = 91581
};

get(8) ->
	#lilian_sys_open{
		no = 8,
		type = 2,
		reward = 91571
};

get(9) ->
	#lilian_sys_open{
		no = 9,
		type = 2,
		reward = 91578
};

get(10) ->
	#lilian_sys_open{
		no = 10,
		type = 1,
		reward = 91583
};

get(11) ->
	#lilian_sys_open{
		no = 11,
		type = 2,
		reward = 91577
};

get(12) ->
	#lilian_sys_open{
		no = 12,
		type = 2,
		reward = 91582
};

get(13) ->
	#lilian_sys_open{
		no = 13,
		type = 2,
		reward = 91579
};

get(14) ->
	#lilian_sys_open{
		no = 14,
		type = 2,
		reward = 91601
};

get(15) ->
	#lilian_sys_open{
		no = 15,
		type = 2,
		reward = 91574
};

get(16) ->
	#lilian_sys_open{
		no = 16,
		type = 2,
		reward = 91585
};

get(17) ->
	#lilian_sys_open{
		no = 17,
		type = 2,
		reward = 91586
};

get(18) ->
	#lilian_sys_open{
		no = 18,
		type = 1,
		reward = 91588
};

get(19) ->
	#lilian_sys_open{
		no = 19,
		type = 1,
		reward = 91589
};

get(20) ->
	#lilian_sys_open{
		no = 20,
		type = 2,
		reward = 91584
};

get(21) ->
	#lilian_sys_open{
		no = 21,
		type = 2,
		reward = 91587
};

get(22) ->
	#lilian_sys_open{
		no = 22,
		type = 2,
		reward = 91590
};

get(23) ->
	#lilian_sys_open{
		no = 23,
		type = 2,
		reward = 91600
};

get(24) ->
	#lilian_sys_open{
		no = 24,
		type = 1,
		reward = 91592
};

get(25) ->
	#lilian_sys_open{
		no = 25,
		type = 2,
		reward = 91593
};

get(26) ->
	#lilian_sys_open{
		no = 26,
		type = 2,
		reward = 91598
};

get(27) ->
	#lilian_sys_open{
		no = 27,
		type = 2,
		reward = 91594
};

get(28) ->
	#lilian_sys_open{
		no = 28,
		type = 2,
		reward = 91595
};

get(29) ->
	#lilian_sys_open{
		no = 29,
		type = 1,
		reward = 91596
};

get(30) ->
	#lilian_sys_open{
		no = 30,
		type = 2,
		reward = 91597
};

get(31) ->
	#lilian_sys_open{
		no = 31,
		type = 2,
		reward = 91599
};

get(32) ->
	#lilian_sys_open{
		no = 32,
		type = 2,
		reward = 91602
};

get(33) ->
	#lilian_sys_open{
		no = 33,
		type = 2,
		reward = 91591
};

get(34) ->
	#lilian_sys_open{
		no = 34,
		type = 2,
		reward = 91603
};

get(35) ->
	#lilian_sys_open{
		no = 35,
		type = 2,
		reward = 91604
};

get(_no) ->
	?ASSERT(false, _no),
    null.

