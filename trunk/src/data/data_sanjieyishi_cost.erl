%%%---------------------------------------
%%% @Module  : data_sanjieyishi_cost
%%% @Author  : lzx
%%% @Email   : 
%%% @Description:  三界轶事消耗表
%%%---------------------------------------


-module(data_sanjieyishi_cost).

-include("record.hrl").
-include("debug.hrl").
-export([get/1]).

get(1081000) ->
	#sanjieyishi_cost{
		no = 1081000,
		cost = {2, 10000},
		lv_range = {60, 199}
};

get(1082000) ->
	#sanjieyishi_cost{
		no = 1082000,
		cost = {2, 60000},
		lv_range = {200, 309}
};

get(_No) ->
	      ?ASSERT(false),
          null.

