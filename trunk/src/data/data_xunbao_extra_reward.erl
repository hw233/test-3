%%%---------------------------------------
%%% @Module  : data_xunbao_extra_reward
%%% @Author  : lzx
%%% @Email   : 
%%% @Description: 寻宝额外奖励表
%%%---------------------------------------


-module(data_xunbao_extra_reward).
-compile(export_all).

-include("luck_info.hrl").
-include("debug.hrl").

get(1) ->
	#xunbao_extra_reward{
		no = 1,
		num = 20,
		reward = 91659
};

get(2) ->
	#xunbao_extra_reward{
		no = 2,
		num = 30,
		reward = 91660
};

get(3) ->
	#xunbao_extra_reward{
		no = 3,
		num = 50,
		reward = 91661
};

get(4) ->
	#xunbao_extra_reward{
		no = 4,
		num = 100,
		reward = 91662
};

get(5) ->
	#xunbao_extra_reward{
		no = 5,
		num = 200,
		reward = 91663
};

get(_No) ->
	?ASSERT(false, {_No}),
    null.

