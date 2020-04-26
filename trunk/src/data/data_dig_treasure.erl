%%%---------------------------------------
%%% @Module  : data_dig_treasure
%%% @Author  : zhangwq
%%% @Email   : 
%%% @Description: 物品使用效果：挖宝事件
%%%---------------------------------------


-module(data_dig_treasure).
-compile(export_all).

-include("effect.hrl").
-include("debug.hrl").

get_all_event_no()->
	[1,101].

get(1) ->
	#dig_treasure{
		no = 1,
		event = 1,
		gid = 10044,
		prob = 100,
		reward = 300501,
		para = 0
};

get(101) ->
	#dig_treasure{
		no = 101,
		event = 1,
		gid = 10047,
		prob = 100,
		reward = 300502,
		para = 0
};

get(_No) ->
	?ASSERT(false, {_No}),
    null.

