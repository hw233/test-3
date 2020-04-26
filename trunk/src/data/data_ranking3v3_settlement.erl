%%%---------------------------------------
%%% @Module  : data_ranking3v3_settlement
%%% @Author  : lzx
%%% @Email   : 
%%% @Description:  结算分数表
%%%---------------------------------------


-module(data_ranking3v3_settlement).

-include("pvp.hrl").
-include("debug.hrl").
-compile(export_all).

get(1) ->
	#ranking3v3_settlement{
		no = 1,
		min = -999999,
		max = -151,
		bonus_points = 12,
		minus_points = 10
};

get(2) ->
	#ranking3v3_settlement{
		no = 2,
		min = -150,
		max = -101,
		bonus_points = 11,
		minus_points = 9
};

get(3) ->
	#ranking3v3_settlement{
		no = 3,
		min = -100,
		max = -51,
		bonus_points = 10,
		minus_points = 8
};

get(4) ->
	#ranking3v3_settlement{
		no = 4,
		min = -50,
		max = 50,
		bonus_points = 9,
		minus_points = 7
};

get(5) ->
	#ranking3v3_settlement{
		no = 5,
		min = 51,
		max = 100,
		bonus_points = 8,
		minus_points = 6
};

get(6) ->
	#ranking3v3_settlement{
		no = 6,
		min = 101,
		max = 150,
		bonus_points = 7,
		minus_points = 5
};

get(7) ->
	#ranking3v3_settlement{
		no = 7,
		min = 151,
		max = 999999,
		bonus_points = 6,
		minus_points = 4
};

get(_no) ->
	      ?ASSERT(false, {_no}),
          null.

