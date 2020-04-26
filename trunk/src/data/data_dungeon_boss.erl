%%%---------------------------------------
%%% @Module  : data_dungeon_boss
%%% @Author  : lds
%%% @Email   : 
%%% @Description:  世界boss
%%%---------------------------------------


-module(data_dungeon_boss).
-include("debug.hrl").
-compile(export_all).

get_no()->
	[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28].

get_boss_ranks()->
	[1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10,11,11,21,21,31,31,41,41].

get_boss_ranks_right()->
	[1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10,20,20,30,30,40,40,50,50].


get_boss_rank_reward(1) -> [{62160, 3, 50}];


get_boss_rank_reward(2) -> [{62160, 3, 30}];


get_boss_rank_reward(3) -> [{62160, 3, 20}];


get_boss_rank_reward(4) -> [{62160, 3, 18}];


get_boss_rank_reward(5) -> [{62160, 3, 15}];


get_boss_rank_reward(6) -> [{62160, 3, 13}];


get_boss_rank_reward(7) -> [{62160, 3, 12}];


get_boss_rank_reward(8) -> [{62160, 3, 10}];


get_boss_rank_reward(9) -> [{62160, 3, 8} ];


get_boss_rank_reward(10) -> [{62160, 3, 5} ];


get_boss_rank_reward(11) -> [{62160, 3, 4} ];


get_boss_rank_reward(12) -> [{62160, 3, 3} ];


get_boss_rank_reward(13) -> [{62160, 3, 2} ];


get_boss_rank_reward(14) -> [{62160, 3, 1} ];


get_boss_rank_reward(15) -> [{62546, 3, 30}];


get_boss_rank_reward(16) -> [{62546, 3, 25}];


get_boss_rank_reward(17) -> [{62546, 3, 20}];


get_boss_rank_reward(18) -> [{62546, 3, 15}];


get_boss_rank_reward(19) -> [{62546, 3, 13}];


get_boss_rank_reward(20) -> [{62546, 3, 13}];


get_boss_rank_reward(21) -> [{62546, 3, 10}];


get_boss_rank_reward(22) -> [{62546, 3, 10}];


get_boss_rank_reward(23) -> [{62546, 3, 8} ];


get_boss_rank_reward(24) -> [{62546, 3, 5} ];


get_boss_rank_reward(25) -> [{62546, 3, 4} ];


get_boss_rank_reward(26) -> [{62546, 3, 3} ];


get_boss_rank_reward(27) -> [{62546, 3, 2} ];


get_boss_rank_reward(28) -> [{62546, 3, 1} ];


get_boss_rank_reward(_Arg) ->
    ?ASSERT(false, [_Arg]), [].



get_boss_damage_rates()->
	[0,0,1,1,2,2,5,5,10,10,15,15,20,20,25,25,30,30,35,35,40,40,50,50].


get_boss_damage_rate_reward(1) -> [{62160, 3, 50},{62209, 3, 1}];


get_boss_damage_rate_reward(2) -> [{62160, 3, 30},{62309, 3, 1}];


get_boss_damage_rate_reward(3) -> [{62160, 3, 20},{62309, 3, 1}];


get_boss_damage_rate_reward(4) -> [{62160, 3, 18},{62309, 3, 1}];


get_boss_damage_rate_reward(5) -> [{62160, 3, 15},{62309, 3, 1}];


get_boss_damage_rate_reward(6) -> [{62160, 3, 13},{62309, 3, 1}];


get_boss_damage_rate_reward(7) -> [{62160, 3, 12},{62309, 3, 1}];


get_boss_damage_rate_reward(8) -> [{62160, 3, 10},{62309, 3, 1}];


get_boss_damage_rate_reward(9) -> [{62160, 3, 8}, {62309, 3, 1}];


get_boss_damage_rate_reward(10) -> [{62160, 3, 5}, {62309, 3, 1}];


get_boss_damage_rate_reward(11) -> [{62160, 3, 3}, {62309, 3, 1}];


get_boss_damage_rate_reward(12) -> [{62160, 3, 1}, {62309, 3, 1}];


get_boss_damage_rate_reward(13) -> [{62546, 3, 30}];


get_boss_damage_rate_reward(14) -> [{62546, 3, 25}];


get_boss_damage_rate_reward(15) -> [{62546, 3, 20}];


get_boss_damage_rate_reward(16) -> [{62546, 3, 15}];


get_boss_damage_rate_reward(17) -> [{62546, 3, 12}];


get_boss_damage_rate_reward(18) -> [{62546, 3, 10}];


get_boss_damage_rate_reward(19) -> [{62546, 3, 8}];


get_boss_damage_rate_reward(20) -> [{62546, 3, 5}];


get_boss_damage_rate_reward(21) -> [{62546, 3, 4}];


get_boss_damage_rate_reward(22) -> [{62546, 3, 3}];


get_boss_damage_rate_reward(23) -> [{62546, 3, 2}];


get_boss_damage_rate_reward(24) -> [{62546, 3, 1}];


get_boss_damage_rate_reward(_Arg) ->
    ?ASSERT(false, [_Arg]), [].




get_boss_damage_kill_reward(1) -> [{62161,3,15},{62158,2,2}];


get_boss_damage_kill_reward(2) -> [{62544,3,15}];


get_boss_damage_kill_reward(_Arg) ->
    ?ASSERT(false, [_Arg]), [].

