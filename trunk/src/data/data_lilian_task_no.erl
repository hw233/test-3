%%%---------------------------------------
%%% @Module  : data_lilian_task_no
%%% @Author  : lzx
%%% @Email   : 
%%% @Description: 历练任务序号表
%%%---------------------------------------


-module(data_lilian_task_no).
-export([get_no/0,get/1]).
-include("chapter_target.hrl").
-include("debug.hrl").

get_no()->
	[15,20,25,29,30,35,40,45,50,61,65,70,90,93,100,101,110,122,130,140,150,1000060,1000120,1000370,1000400,1000764,1001040,1001301,1010058,1010061].

get(1000060) ->
	#lilian_task_no{
		no = 1000060,
		type = 1,
		num = [1]
};

get(15) ->
	#lilian_task_no{
		no = 15,
		type = 2,
		num = [2]
};

get(1000120) ->
	#lilian_task_no{
		no = 1000120,
		type = 1,
		num = [3]
};

get(1000370) ->
	#lilian_task_no{
		no = 1000370,
		type = 1,
		num = [4]
};

get(20) ->
	#lilian_task_no{
		no = 20,
		type = 2,
		num = [5]
};

get(1000400) ->
	#lilian_task_no{
		no = 1000400,
		type = 1,
		num = [6,7]
};

get(25) ->
	#lilian_task_no{
		no = 25,
		type = 2,
		num = [8]
};

get(29) ->
	#lilian_task_no{
		no = 29,
		type = 2,
		num = [9]
};

get(1000764) ->
	#lilian_task_no{
		no = 1000764,
		type = 1,
		num = [10]
};

get(30) ->
	#lilian_task_no{
		no = 30,
		type = 2,
		num = [11,12]
};

get(35) ->
	#lilian_task_no{
		no = 35,
		type = 2,
		num = [13]
};

get(40) ->
	#lilian_task_no{
		no = 40,
		type = 2,
		num = [14]
};

get(45) ->
	#lilian_task_no{
		no = 45,
		type = 2,
		num = [15]
};

get(50) ->
	#lilian_task_no{
		no = 50,
		type = 2,
		num = [16,17]
};

get(1010058) ->
	#lilian_task_no{
		no = 1010058,
		type = 1,
		num = [18]
};

get(1010061) ->
	#lilian_task_no{
		no = 1010061,
		type = 1,
		num = [19]
};

get(61) ->
	#lilian_task_no{
		no = 61,
		type = 2,
		num = [20]
};

get(65) ->
	#lilian_task_no{
		no = 65,
		type = 2,
		num = [21,22]
};

get(70) ->
	#lilian_task_no{
		no = 70,
		type = 2,
		num = [23]
};

get(1001040) ->
	#lilian_task_no{
		no = 1001040,
		type = 1,
		num = [24]
};

get(90) ->
	#lilian_task_no{
		no = 90,
		type = 2,
		num = [25,26]
};

get(93) ->
	#lilian_task_no{
		no = 93,
		type = 2,
		num = [27]
};

get(100) ->
	#lilian_task_no{
		no = 100,
		type = 2,
		num = [28]
};

get(1001301) ->
	#lilian_task_no{
		no = 1001301,
		type = 1,
		num = [29]
};

get(101) ->
	#lilian_task_no{
		no = 101,
		type = 2,
		num = [30]
};

get(110) ->
	#lilian_task_no{
		no = 110,
		type = 2,
		num = [31]
};

get(122) ->
	#lilian_task_no{
		no = 122,
		type = 2,
		num = [32]
};

get(130) ->
	#lilian_task_no{
		no = 130,
		type = 2,
		num = [33]
};

get(140) ->
	#lilian_task_no{
		no = 140,
		type = 2,
		num = [34]
};

get(150) ->
	#lilian_task_no{
		no = 150,
		type = 2,
		num = [35]
};

get(_no) ->
	?ASSERT(false, _no),
    null.

