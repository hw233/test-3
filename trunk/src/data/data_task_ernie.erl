%%%---------------------------------------
%%% @Module  : data_task_ernie
%%% @Author  : lzx
%%% @Email   : 
%%% @Description:  任务转盘奖励表
%%%---------------------------------------


-module(data_task_ernie).

-include("task.hrl").
-include("debug.hrl").
-compile(export_all).

get_no()->
	[1,2,3,4,5,6,7,8,9,10].

get(1) ->
	#task_ernie{
		no = 1,
		prob = 400,
		reward = [{60040,3,3,3}]
};

get(2) ->
	#task_ernie{
		no = 2,
		prob = 200,
		reward = [{62161,3,3,3}]
};

get(3) ->
	#task_ernie{
		no = 3,
		prob = 535,
		reward = [{89323,4,4,3}]
};

get(4) ->
	#task_ernie{
		no = 4,
		prob = 300,
		reward = [{60101,5,3,3}]
};

get(5) ->
	#task_ernie{
		no = 5,
		prob = 400,
		reward = [{10043,5,3,3}]
};

get(6) ->
	#task_ernie{
		no = 6,
		prob = 700,
		reward = [{62032,10,3,3}]
};

get(7) ->
	#task_ernie{
		no = 7,
		prob = 535,
		reward = [{89323,2,4,3}]
};

get(8) ->
	#task_ernie{
		no = 8,
		prob = 10,
		reward = [{62574,1,5,3}]
};

get(9) ->
	#task_ernie{
		no = 9,
		prob = 700,
		reward = [{60027,1,3,3}]
};

get(10) ->
	#task_ernie{
		no = 10,
		prob = 700,
		reward = [{50366,3,4,3}]
};

get(_No) ->
	      ?ASSERT(false, _No),
          null.

