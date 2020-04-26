%%%---------------------------------------
%%% @Module  : data_ranking3v3_team_match_range
%%% @Author  : lzx
%%% @Email   : 
%%% @Description: 队友匹配范围表
%%%---------------------------------------


-module(data_ranking3v3_team_match_range).
-compile(export_all).
-include("pvp.hrl").
-include("debug.hrl").

get(0) ->
	#ranking3v3_team_match_range{
		no = 0,
		team_match_range = {0,8}
};

get(1) ->
	#ranking3v3_team_match_range{
		no = 1,
		team_match_range = {0,8}
};

get(2) ->
	#ranking3v3_team_match_range{
		no = 2,
		team_match_range = {0,8}
};

get(3) ->
	#ranking3v3_team_match_range{
		no = 3,
		team_match_range = {0,8}
};

get(4) ->
	#ranking3v3_team_match_range{
		no = 4,
		team_match_range = {0,9}
};

get(5) ->
	#ranking3v3_team_match_range{
		no = 5,
		team_match_range = {1,10}
};

get(6) ->
	#ranking3v3_team_match_range{
		no = 6,
		team_match_range = {1,11}
};

get(7) ->
	#ranking3v3_team_match_range{
		no = 7,
		team_match_range = {2,12}
};

get(8) ->
	#ranking3v3_team_match_range{
		no = 8,
		team_match_range = {3,13}
};

get(9) ->
	#ranking3v3_team_match_range{
		no = 9,
		team_match_range = {4,14}
};

get(10) ->
	#ranking3v3_team_match_range{
		no = 10,
		team_match_range = {5,15}
};

get(11) ->
	#ranking3v3_team_match_range{
		no = 11,
		team_match_range = {6,16}
};

get(12) ->
	#ranking3v3_team_match_range{
		no = 12,
		team_match_range = {7,17}
};

get(13) ->
	#ranking3v3_team_match_range{
		no = 13,
		team_match_range = {8,18}
};

get(14) ->
	#ranking3v3_team_match_range{
		no = 14,
		team_match_range = {9,19}
};

get(15) ->
	#ranking3v3_team_match_range{
		no = 15,
		team_match_range = {10,20}
};

get(16) ->
	#ranking3v3_team_match_range{
		no = 16,
		team_match_range = {11,21}
};

get(17) ->
	#ranking3v3_team_match_range{
		no = 17,
		team_match_range = {12,22}
};

get(18) ->
	#ranking3v3_team_match_range{
		no = 18,
		team_match_range = {13,23}
};

get(19) ->
	#ranking3v3_team_match_range{
		no = 19,
		team_match_range = {14,24}
};

get(20) ->
	#ranking3v3_team_match_range{
		no = 20,
		team_match_range = {15,25}
};

get(21) ->
	#ranking3v3_team_match_range{
		no = 21,
		team_match_range = {16,26}
};

get(22) ->
	#ranking3v3_team_match_range{
		no = 22,
		team_match_range = {17,27}
};

get(23) ->
	#ranking3v3_team_match_range{
		no = 23,
		team_match_range = {18,28}
};

get(24) ->
	#ranking3v3_team_match_range{
		no = 24,
		team_match_range = {19,29}
};

get(25) ->
	#ranking3v3_team_match_range{
		no = 25,
		team_match_range = {20,30}
};

get(26) ->
	#ranking3v3_team_match_range{
		no = 26,
		team_match_range = {21,31}
};

get(27) ->
	#ranking3v3_team_match_range{
		no = 27,
		team_match_range = {21,32}
};

get(28) ->
	#ranking3v3_team_match_range{
		no = 28,
		team_match_range = {21,32}
};

get(29) ->
	#ranking3v3_team_match_range{
		no = 29,
		team_match_range = {21,32}
};

get(30) ->
	#ranking3v3_team_match_range{
		no = 30,
		team_match_range = {21,32}
};

get(31) ->
	#ranking3v3_team_match_range{
		no = 31,
		team_match_range = {21,32}
};

get(32) ->
	#ranking3v3_team_match_range{
		no = 32,
		team_match_range = {21,32}
};

get(_no) ->
	?ASSERT(false, _no),
    null.

