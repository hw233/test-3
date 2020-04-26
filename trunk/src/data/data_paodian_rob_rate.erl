%%%---------------------------------------
%%% @Module  : data_paodian_rob_rate
%%% @Author  : duan
%%% @Email   :
%%% @Description: 泡点抢夺龙珠概率表
%%%---------------------------------------


-module(data_paodian_rob_rate).
-export([get/1,get_id_list/0]).
-include("record.hrl").
-include("debug.hrl").

get_id_list()->
	[1,2,3,4,5].

get(1) ->
	#paodian_rob_rate_config{
		id = 1,
		min = -99999,
		max = 0,
		rob_rate = 1
};

get(2) ->
	#paodian_rob_rate_config{
		id = 2,
		min = 0,
		max = 3,
		rob_rate = 1
};

get(3) ->
	#paodian_rob_rate_config{
		id = 3,
		min = 3,
		max = 5,
		rob_rate = 0.800000
};

get(4) ->
	#paodian_rob_rate_config{
		id = 4,
		min = 5,
		max = 10,
		rob_rate = 0.700000
};

get(5) ->
	#paodian_rob_rate_config{
		id = 5,
		min = 10,
		max = 99999,
		rob_rate = 0.500000
};

get(_ID) ->
				?ERROR_MSG("not found ~w", [_ID]),
          null.

