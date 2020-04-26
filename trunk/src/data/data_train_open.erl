%%%---------------------------------------
%%% @Module  : data_train_open
%%% @Author  : easy
%%% @Email   : 
%%% @Description: 内功格子开放等级表
%%%---------------------------------------


-module(data_train_open).
-export([
        get_need_lv/0,
        get/1
    ]).

-include("train.hrl").
-include("debug.hrl").

get_need_lv()->
	[100,130,160,190,220,250,280,300].

get(1) ->
	#train_open_cfg{
		no = 1,
		need_lv = 100,
		cost = [{60177,1}]
};

get(2) ->
	#train_open_cfg{
		no = 2,
		need_lv = 130,
		cost = [{60177,2}]
};

get(3) ->
	#train_open_cfg{
		no = 3,
		need_lv = 160,
		cost = [{60177,3}]
};

get(4) ->
	#train_open_cfg{
		no = 4,
		need_lv = 190,
		cost = [{60177,4}]
};

get(5) ->
	#train_open_cfg{
		no = 5,
		need_lv = 220,
		cost = [{60177,5}]
};

get(6) ->
	#train_open_cfg{
		no = 6,
		need_lv = 250,
		cost = [{60177,6}]
};

get(7) ->
	#train_open_cfg{
		no = 7,
		need_lv = 280,
		cost = [{60177,7}]
};

get(8) ->
	#train_open_cfg{
		no = 8,
		need_lv = 300,
		cost = [{60177,8}]
};

get(_No) ->
	?ASSERT(false, _No),
    null.

