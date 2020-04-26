


-module(data_offline_arena).
-include("common.hrl").
-include("record.hrl").
-compile(export_all).

get_ranks()->
	[0,1,2,3,4,5,6,11,51,101,301,501].



get_rank_reward(1) -> [40000, 40100, 40200, 40300, 40400, 40500]

			;


get_rank_reward(2) -> [40001, 40101, 40201, 40301, 40401, 40501]

			;


get_rank_reward(3) -> [40002, 40102, 40202, 40302, 40402, 40502]

			;


get_rank_reward(4) -> [40003, 40103, 40203, 40303, 40403, 40503]

			;


get_rank_reward(5) -> [40004, 40104, 40204, 40304, 40404, 40504]

			;


get_rank_reward(6) -> [40005, 40105, 40205, 40305, 40405, 40505]

			;


get_rank_reward(11) -> [40006, 40106, 40206, 40306, 40406, 40506]

			;


get_rank_reward(51) -> [40007, 40107, 40207, 40307, 40407, 40507]

			;


get_rank_reward(101) -> [40008, 40108, 40208, 40308, 40408, 40508]

			;


get_rank_reward(301) -> [40009, 40109, 40209, 40309, 40409, 40509]

			;


get_rank_reward(501) -> [40010, 40110, 40210, 40310, 40410, 40510]

			;


get_rank_reward(0) -> [40011, 40111, 40211, 40311, 40411, 40511]

			;

get_rank_reward(_Arg) ->
	?ASSERT(false, [_Arg]),
	null.
		


get_ws_event()->
	[1,10].


				get_ws_reward(1) -> 40800
			;

				get_ws_reward(10) -> 40801
			;

				get_ws_reward(_Arg) ->
	      ?ASSERT(false, [_Arg]),
          null.
		


get_chal_times_event()->
	[10].


				get_chal_times_reward(10) -> 40802
			;

				get_chal_times_reward(_Arg) ->
	      ?ASSERT(false, [_Arg]),
          null.
		



get_battle_reward(1, 1) -> {7, {1, 10, -2500, 2, 1}}

;

get_battle_reward(1, 0) -> {7, {1, 5, -2100, 2, 1}}

;

get_battle_reward(2, 1) -> {7, {4.4,-120, 7400, 2, 1}}

;

get_battle_reward(2, 0) -> {7, {3.52,-96, 5920, 2, 1}}

;

get_battle_reward(3, 1) -> {7, {4.4,-120, 7400, 2, 1}}

;

get_battle_reward(3, 0) -> {7, {3.52,-96, 5920, 2, 1}}

;

get_battle_reward(4, 1) -> {7, {4.4,-120, 7400, 2, 1}}

;

get_battle_reward(4, 0) -> {7, {3.52,-96, 5920, 2, 1}}

;

get_battle_reward(5, 1) -> {7, {4.4,-120, 7400, 2, 1}}

;

get_battle_reward(5, 0) -> {7, {3.52,-96, 5920, 2, 1}}

;

get_battle_reward(6, 1) -> {7, {4.4,-120, 7400, 2, 1}}

;

get_battle_reward(6, 0) -> {7, {3.52,-96, 5920, 2, 1}}

;

get_battle_reward(_Arg1, _Arg2) ->
	?ASSERT(false, [_Arg1, _Arg2]),
	null.

