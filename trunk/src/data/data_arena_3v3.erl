%%%---------------------------------------
%%% @Module  : data_arena_3v3
%%% @Author  : liuf
%%% @Email   :
%%% @Description: 比武大会
%%%---------------------------------------


-module(data_arena_3v3).
-include("debug.hrl").
-include("arena_1v1.hrl").
-compile(export_all).

get_all_no()->
	[1,2,3].


				get(1) ->
	#arena_3v3_reward{
		no = 1,
		min = 20,
		max = 999999999,
		goods_id = 62268}
			;

				get(2) ->
	#arena_3v3_reward{
		no = 2,
		min = 10,
		max = 19,
		goods_id = 62267}
			;

				get(3) ->
	#arena_3v3_reward{
		no = 3,
		min = 0,
		max = 10,
		goods_id = 62266}
			;

				get(_) ->
	      ?ASSERT(false),
          null.

		
