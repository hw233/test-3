%%%---------------------------------------
%%% @Module  : data__ranking3v3_reach_time_reward
%%% @Author  : lzx
%%% @Email   : 
%%% @Description: 战斗次数奖励表
%%%---------------------------------------


-module(data_ranking3v3_reach_time_reward).
-export([get_no/0,get/1]).
-include("pvp.hrl").
-include("debug.hrl").

get_no()->
	[1,5,10].


				get(1) -> 91613
			;

				get(5) -> 91614
			;

				get(10) -> 91615
			;

				get(_Arg) ->
	      ?ASSERT(false, [_Arg]),
          null.
		
