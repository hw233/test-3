%%%---------------------------------------
%%% @Module  : data_ranking3v3_score
%%% @Author  : lzx
%%% @Email   : 
%%% @Description: 段位分数表
%%%---------------------------------------


-module(data_ranking3v3_score).
-export([get_no/0,get/1]).
-include("pvp.hrl").
-include("debug.hrl").

get_no()->
	[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32].

get(0) ->
	#ranking3v3_score{
		no = 0,
		min = 0,
		max = 0,
		name = <<"无段位">>,
		reward = 0,
		inactive_minus_points = 0
};

get(1) ->
	#ranking3v3_score{
		no = 1,
		min = 1,
		max = 50,
		name = <<"青铜1">>,
		reward = 91658,
		inactive_minus_points = 10
};

get(2) ->
	#ranking3v3_score{
		no = 2,
		min = 51,
		max = 100,
		name = <<"青铜2">>,
		reward = 91657,
		inactive_minus_points = 10
};

get(3) ->
	#ranking3v3_score{
		no = 3,
		min = 101,
		max = 150,
		name = <<"青铜3">>,
		reward = 91656,
		inactive_minus_points = 10
};

get(4) ->
	#ranking3v3_score{
		no = 4,
		min = 151,
		max = 200,
		name = <<"青铜4">>,
		reward = 91655,
		inactive_minus_points = 10
};

get(5) ->
	#ranking3v3_score{
		no = 5,
		min = 201,
		max = 250,
		name = <<"青铜5">>,
		reward = 91654,
		inactive_minus_points = 10
};

get(6) ->
	#ranking3v3_score{
		no = 6,
		min = 251,
		max = 300,
		name = <<"白银1">>,
		reward = 91653,
		inactive_minus_points = 15
};

get(7) ->
	#ranking3v3_score{
		no = 7,
		min = 301,
		max = 350,
		name = <<"白银2">>,
		reward = 91652,
		inactive_minus_points = 15
};

get(8) ->
	#ranking3v3_score{
		no = 8,
		min = 351,
		max = 400,
		name = <<"白银3">>,
		reward = 91651,
		inactive_minus_points = 15
};

get(9) ->
	#ranking3v3_score{
		no = 9,
		min = 401,
		max = 450,
		name = <<"白银4">>,
		reward = 91650,
		inactive_minus_points = 15
};

get(10) ->
	#ranking3v3_score{
		no = 10,
		min = 451,
		max = 530,
		name = <<"白银5">>,
		reward = 91649,
		inactive_minus_points = 15
};

get(11) ->
	#ranking3v3_score{
		no = 11,
		min = 531,
		max = 610,
		name = <<"黄金1">>,
		reward = 91648,
		inactive_minus_points = 20
};

get(12) ->
	#ranking3v3_score{
		no = 12,
		min = 611,
		max = 690,
		name = <<"黄金2">>,
		reward = 91647,
		inactive_minus_points = 20
};

get(13) ->
	#ranking3v3_score{
		no = 13,
		min = 691,
		max = 770,
		name = <<"黄金3">>,
		reward = 91646,
		inactive_minus_points = 20
};

get(14) ->
	#ranking3v3_score{
		no = 14,
		min = 771,
		max = 850,
		name = <<"黄金4">>,
		reward = 91645,
		inactive_minus_points = 20
};

get(15) ->
	#ranking3v3_score{
		no = 15,
		min = 851,
		max = 930,
		name = <<"黄金5">>,
		reward = 91644,
		inactive_minus_points = 20
};

get(16) ->
	#ranking3v3_score{
		no = 16,
		min = 931,
		max = 1010,
		name = <<"铂金1">>,
		reward = 91643,
		inactive_minus_points = 30
};

get(17) ->
	#ranking3v3_score{
		no = 17,
		min = 1011,
		max = 1090,
		name = <<"铂金2">>,
		reward = 91642,
		inactive_minus_points = 30
};

get(18) ->
	#ranking3v3_score{
		no = 18,
		min = 1091,
		max = 1170,
		name = <<"铂金3">>,
		reward = 91641,
		inactive_minus_points = 30
};

get(19) ->
	#ranking3v3_score{
		no = 19,
		min = 1171,
		max = 1250,
		name = <<"铂金4">>,
		reward = 91640,
		inactive_minus_points = 30
};

get(20) ->
	#ranking3v3_score{
		no = 20,
		min = 1251,
		max = 1350,
		name = <<"铂金5">>,
		reward = 91639,
		inactive_minus_points = 30
};

get(21) ->
	#ranking3v3_score{
		no = 21,
		min = 1351,
		max = 1450,
		name = <<"钻石1">>,
		reward = 91638,
		inactive_minus_points = 35
};

get(22) ->
	#ranking3v3_score{
		no = 22,
		min = 1451,
		max = 1550,
		name = <<"钻石2">>,
		reward = 91637,
		inactive_minus_points = 35
};

get(23) ->
	#ranking3v3_score{
		no = 23,
		min = 1551,
		max = 1650,
		name = <<"钻石3">>,
		reward = 91636,
		inactive_minus_points = 35
};

get(24) ->
	#ranking3v3_score{
		no = 24,
		min = 1651,
		max = 1750,
		name = <<"钻石4">>,
		reward = 91635,
		inactive_minus_points = 35
};

get(25) ->
	#ranking3v3_score{
		no = 25,
		min = 1751,
		max = 1870,
		name = <<"钻石5">>,
		reward = 91634,
		inactive_minus_points = 35
};

get(26) ->
	#ranking3v3_score{
		no = 26,
		min = 1871,
		max = 1990,
		name = <<"无双1">>,
		reward = 91633,
		inactive_minus_points = 35
};

get(27) ->
	#ranking3v3_score{
		no = 27,
		min = 1991,
		max = 2110,
		name = <<"无双2">>,
		reward = 91632,
		inactive_minus_points = 35
};

get(28) ->
	#ranking3v3_score{
		no = 28,
		min = 2111,
		max = 2230,
		name = <<"无双3">>,
		reward = 91631,
		inactive_minus_points = 35
};

get(29) ->
	#ranking3v3_score{
		no = 29,
		min = 2231,
		max = 2350,
		name = <<"无双4">>,
		reward = 91630,
		inactive_minus_points = 35
};

get(30) ->
	#ranking3v3_score{
		no = 30,
		min = 2351,
		max = 2500,
		name = <<"无双5">>,
		reward = 91629,
		inactive_minus_points = 35
};

get(31) ->
	#ranking3v3_score{
		no = 31,
		min = 2501,
		max = 99999999,
		name = <<"王者">>,
		reward = 91628,
		inactive_minus_points = -2450
};

get(32) ->
	#ranking3v3_score{
		no = 32,
		min = 2700,
		max = 99999999,
		name = <<"传奇">>,
		reward = 91627,
		inactive_minus_points = -2450
};

get(_no) ->
	?ASSERT(false, _no),
    null.

