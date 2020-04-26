%%%---------------------------------------
%%% @Module  : data_ernie
%%% @Author  : liufang
%%% @Email   : 
%%% @Description: 幸运转盘
%%%---------------------------------------


-module(data_ernie).
-compile(export_all).

-include("ernie.hrl").
-include("debug.hrl").

get_all_event_no()->
	[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100].

get(1) ->
	#ernie_reward_data{
		no = 1,
		prob = 1,
		type = 1,
		reward = [{62375,30,0,3}],
		notice = 319
};

get(2) ->
	#ernie_reward_data{
		no = 2,
		prob = 800,
		type = 1,
		reward = [{70051,100,0,3}],
		notice = 0
};

get(3) ->
	#ernie_reward_data{
		no = 3,
		prob = 800,
		type = 1,
		reward = [{70052,100,0,3}],
		notice = 0
};

get(4) ->
	#ernie_reward_data{
		no = 4,
		prob = 800,
		type = 1,
		reward = [{70053,100,0,3}],
		notice = 0
};

get(5) ->
	#ernie_reward_data{
		no = 5,
		prob = 600,
		type = 1,
		reward = [{70054,200,0,3}],
		notice = 0
};

get(6) ->
	#ernie_reward_data{
		no = 6,
		prob = 600,
		type = 1,
		reward = [{70055,200,0,3}],
		notice = 0
};

get(7) ->
	#ernie_reward_data{
		no = 7,
		prob = 600,
		type = 1,
		reward = [{70056,200,0,3}],
		notice = 0
};

get(8) ->
	#ernie_reward_data{
		no = 8,
		prob = 300,
		type = 1,
		reward = [{62034,10,0,3}],
		notice = 319
};

get(9) ->
	#ernie_reward_data{
		no = 9,
		prob = 300,
		type = 1,
		reward = [{60027,10,0,3}],
		notice = 319
};

get(10) ->
	#ernie_reward_data{
		no = 10,
		prob = 200,
		type = 1,
		reward = [{62375,3,0,3}],
		notice = 319
};

get(11) ->
	#ernie_reward_data{
		no = 11,
		prob = 1,
		type = 2,
		reward = [{62374,30,0,3}],
		notice = 319
};

get(12) ->
	#ernie_reward_data{
		no = 12,
		prob = 500,
		type = 2,
		reward = [{62380,1,0,3}],
		notice = 0
};

get(13) ->
	#ernie_reward_data{
		no = 13,
		prob = 900,
		type = 2,
		reward = [{62168,2,0,3}],
		notice = 0
};

get(14) ->
	#ernie_reward_data{
		no = 14,
		prob = 800,
		type = 2,
		reward = [{62165,2,0,3}],
		notice = 0
};

get(15) ->
	#ernie_reward_data{
		no = 15,
		prob = 700,
		type = 2,
		reward = [{62164,2,0,3}],
		notice = 0
};

get(16) ->
	#ernie_reward_data{
		no = 16,
		prob = 600,
		type = 2,
		reward = [{62163,2,0,3}],
		notice = 0
};

get(17) ->
	#ernie_reward_data{
		no = 17,
		prob = 500,
		type = 2,
		reward = [{62034,10,0,3}],
		notice = 319
};

get(18) ->
	#ernie_reward_data{
		no = 18,
		prob = 300,
		type = 2,
		reward = [{30001,1,0,3}],
		notice = 319
};

get(19) ->
	#ernie_reward_data{
		no = 19,
		prob = 300,
		type = 2,
		reward = [{70014,50,0,3}],
		notice = 319
};

get(20) ->
	#ernie_reward_data{
		no = 20,
		prob = 200,
		type = 2,
		reward = [{62374,3,0,3}],
		notice = 319
};

get(21) ->
	#ernie_reward_data{
		no = 21,
		prob = 1,
		type = 3,
		reward = [{62318,30,0,3}],
		notice = 319
};

get(22) ->
	#ernie_reward_data{
		no = 22,
		prob = 600,
		type = 3,
		reward = [{62163,2,0,3}],
		notice = 0
};

get(23) ->
	#ernie_reward_data{
		no = 23,
		prob = 600,
		type = 3,
		reward = [{10043,1000,0,3}],
		notice = 319
};

get(24) ->
	#ernie_reward_data{
		no = 24,
		prob = 600,
		type = 3,
		reward = [{60101,1000,0,3}],
		notice = 319
};

get(25) ->
	#ernie_reward_data{
		no = 25,
		prob = 600,
		type = 3,
		reward = [{62032,500,0,3}],
		notice = 319
};

get(26) ->
	#ernie_reward_data{
		no = 26,
		prob = 600,
		type = 3,
		reward = [{50038,500,0,3}],
		notice = 319
};

get(27) ->
	#ernie_reward_data{
		no = 27,
		prob = 600,
		type = 3,
		reward = [{50307,500,0,3}],
		notice = 319
};

get(28) ->
	#ernie_reward_data{
		no = 28,
		prob = 300,
		type = 3,
		reward = [{60027,10,0,3}],
		notice = 319
};

get(29) ->
	#ernie_reward_data{
		no = 29,
		prob = 300,
		type = 3,
		reward = [{30001,2,0,3}],
		notice = 319
};

get(30) ->
	#ernie_reward_data{
		no = 30,
		prob = 200,
		type = 3,
		reward = [{62318,3,0,3}],
		notice = 319
};

get(31) ->
	#ernie_reward_data{
		no = 31,
		prob = 1,
		type = 4,
		reward = [{62376,30,0,3}],
		notice = 319
};

get(32) ->
	#ernie_reward_data{
		no = 32,
		prob = 400,
		type = 4,
		reward = [{50307,2000,0,3}],
		notice = 319
};

get(33) ->
	#ernie_reward_data{
		no = 33,
		prob = 800,
		type = 4,
		reward = [{62163,2,0,3}],
		notice = 0
};

get(34) ->
	#ernie_reward_data{
		no = 34,
		prob = 600,
		type = 4,
		reward = [{30001,2,0,3}],
		notice = 319
};

get(35) ->
	#ernie_reward_data{
		no = 35,
		prob = 700,
		type = 4,
		reward = [{62200,1,0,3}],
		notice = 0
};

get(36) ->
	#ernie_reward_data{
		no = 36,
		prob = 600,
		type = 4,
		reward = [{70055,500,0,3}],
		notice = 0
};

get(37) ->
	#ernie_reward_data{
		no = 37,
		prob = 600,
		type = 4,
		reward = [{70056,500,0,3}],
		notice = 0
};

get(38) ->
	#ernie_reward_data{
		no = 38,
		prob = 300,
		type = 4,
		reward = [{62239,1,0,3}],
		notice = 319
};

get(39) ->
	#ernie_reward_data{
		no = 39,
		prob = 100,
		type = 4,
		reward = [{20017,30,0,3}],
		notice = 319
};

get(40) ->
	#ernie_reward_data{
		no = 40,
		prob = 200,
		type = 4,
		reward = [{62376,3,0,3}],
		notice = 319
};

get(41) ->
	#ernie_reward_data{
		no = 41,
		prob = 1,
		type = 5,
		reward = [{62373,66,0,3}],
		notice = 319
};

get(42) ->
	#ernie_reward_data{
		no = 42,
		prob = 500,
		type = 5,
		reward = [{50038,1000,0,3}],
		notice = 319
};

get(43) ->
	#ernie_reward_data{
		no = 43,
		prob = 700,
		type = 5,
		reward = [{62163,2,0,3}],
		notice = 0
};

get(44) ->
	#ernie_reward_data{
		no = 44,
		prob = 600,
		type = 5,
		reward = [{70053,100,0,3}],
		notice = 0
};

get(45) ->
	#ernie_reward_data{
		no = 45,
		prob = 600,
		type = 5,
		reward = [{70054,100,0,3}],
		notice = 0
};

get(46) ->
	#ernie_reward_data{
		no = 46,
		prob = 700,
		type = 5,
		reward = [{62197,1,0,3}],
		notice = 0
};

get(47) ->
	#ernie_reward_data{
		no = 47,
		prob = 600,
		type = 5,
		reward = [{62240,1,0,3}],
		notice = 319
};

get(48) ->
	#ernie_reward_data{
		no = 48,
		prob = 300,
		type = 5,
		reward = [{30001,4,0,3}],
		notice = 319
};

get(49) ->
	#ernie_reward_data{
		no = 49,
		prob = 100,
		type = 5,
		reward = [{20011,60,0,3}],
		notice = 319
};

get(50) ->
	#ernie_reward_data{
		no = 50,
		prob = 200,
		type = 5,
		reward = [{62373,6,0,3}],
		notice = 319
};

get(51) ->
	#ernie_reward_data{
		no = 51,
		prob = 1,
		type = 6,
		reward = [{62317,30,0,3}],
		notice = 319
};

get(52) ->
	#ernie_reward_data{
		no = 52,
		prob = 700,
		type = 6,
		reward = [{70051,100,0,3}],
		notice = 0
};

get(53) ->
	#ernie_reward_data{
		no = 53,
		prob = 700,
		type = 6,
		reward = [{70052,100,0,3}],
		notice = 0
};

get(54) ->
	#ernie_reward_data{
		no = 54,
		prob = 700,
		type = 6,
		reward = [{62165,2,0,3}],
		notice = 0
};

get(55) ->
	#ernie_reward_data{
		no = 55,
		prob = 700,
		type = 6,
		reward = [{62185,1,0,3}],
		notice = 0
};

get(56) ->
	#ernie_reward_data{
		no = 56,
		prob = 300,
		type = 6,
		reward = [{10043,500,0,3}],
		notice = 319
};

get(57) ->
	#ernie_reward_data{
		no = 57,
		prob = 600,
		type = 6,
		reward = [{62241,1,0,3}],
		notice = 319
};

get(58) ->
	#ernie_reward_data{
		no = 58,
		prob = 100,
		type = 6,
		reward = [{20007,30,0,3}],
		notice = 319
};

get(59) ->
	#ernie_reward_data{
		no = 59,
		prob = 300,
		type = 6,
		reward = [{30001,2,0,3}],
		notice = 319
};

get(60) ->
	#ernie_reward_data{
		no = 60,
		prob = 200,
		type = 6,
		reward = [{62317,3,0,3}],
		notice = 319
};

get(61) ->
	#ernie_reward_data{
		no = 61,
		prob = 1,
		type = 7,
		reward = [{62373,66,0,3}],
		notice = 319
};

get(62) ->
	#ernie_reward_data{
		no = 62,
		prob = 300,
		type = 7,
		reward = [{60101,1000,0,3}],
		notice = 319
};

get(63) ->
	#ernie_reward_data{
		no = 63,
		prob = 800,
		type = 7,
		reward = [{10237,5,0,3}],
		notice = 0
};

get(64) ->
	#ernie_reward_data{
		no = 64,
		prob = 700,
		type = 7,
		reward = [{10038,5,0,3}],
		notice = 0
};

get(65) ->
	#ernie_reward_data{
		no = 65,
		prob = 500,
		type = 7,
		reward = [{62242,1,0,3}],
		notice = 319
};

get(66) ->
	#ernie_reward_data{
		no = 66,
		prob = 700,
		type = 7,
		reward = [{10236,3,0,3}],
		notice = 0
};

get(67) ->
	#ernie_reward_data{
		no = 67,
		prob = 600,
		type = 7,
		reward = [{30001,4,0,3}],
		notice = 319
};

get(68) ->
	#ernie_reward_data{
		no = 68,
		prob = 300,
		type = 7,
		reward = [{60027,10,0,3}],
		notice = 319
};

get(69) ->
	#ernie_reward_data{
		no = 69,
		prob = 100,
		type = 7,
		reward = [{20021,60,0,3}],
		notice = 319
};

get(70) ->
	#ernie_reward_data{
		no = 70,
		prob = 200,
		type = 7,
		reward = [{62373,6,0,3}],
		notice = 319
};

get(71) ->
	#ernie_reward_data{
		no = 71,
		prob = 1,
		type = 8,
		reward = [{62319,30,0,3}],
		notice = 319
};

get(72) ->
	#ernie_reward_data{
		no = 72,
		prob = 600,
		type = 8,
		reward = [{30001,2,0,3}],
		notice = 319
};

get(73) ->
	#ernie_reward_data{
		no = 73,
		prob = 500,
		type = 8,
		reward = [{62034,10,0,3}],
		notice = 319
};

get(74) ->
	#ernie_reward_data{
		no = 74,
		prob = 500,
		type = 8,
		reward = [{62032,1000,0,3}],
		notice = 319
};

get(75) ->
	#ernie_reward_data{
		no = 75,
		prob = 600,
		type = 8,
		reward = [{62243,1,0,3}],
		notice = 319
};

get(76) ->
	#ernie_reward_data{
		no = 76,
		prob = 800,
		type = 8,
		reward = [{62163,2,0,3}],
		notice = 0
};

get(77) ->
	#ernie_reward_data{
		no = 77,
		prob = 800,
		type = 8,
		reward = [{62200,1,0,3}],
		notice = 0
};

get(78) ->
	#ernie_reward_data{
		no = 78,
		prob = 100,
		type = 8,
		reward = [{20003,30,0,3}],
		notice = 319
};

get(79) ->
	#ernie_reward_data{
		no = 79,
		prob = 200,
		type = 8,
		reward = [{60027,10,0,3}],
		notice = 319
};

get(80) ->
	#ernie_reward_data{
		no = 80,
		prob = 300,
		type = 8,
		reward = [{62319,3,0,3}],
		notice = 319
};

get(81) ->
	#ernie_reward_data{
		no = 81,
		prob = 1,
		type = 9,
		reward = [{62319,30,0,3}],
		notice = 319
};

get(82) ->
	#ernie_reward_data{
		no = 82,
		prob = 600,
		type = 9,
		reward = [{30001,2,0,3}],
		notice = 319
};

get(83) ->
	#ernie_reward_data{
		no = 83,
		prob = 500,
		type = 9,
		reward = [{62034,10,0,3}],
		notice = 319
};

get(84) ->
	#ernie_reward_data{
		no = 84,
		prob = 500,
		type = 9,
		reward = [{62032,1000,0,3}],
		notice = 319
};

get(85) ->
	#ernie_reward_data{
		no = 85,
		prob = 600,
		type = 9,
		reward = [{62243,1,0,3}],
		notice = 319
};

get(86) ->
	#ernie_reward_data{
		no = 86,
		prob = 800,
		type = 9,
		reward = [{62163,2,0,3}],
		notice = 0
};

get(87) ->
	#ernie_reward_data{
		no = 87,
		prob = 800,
		type = 9,
		reward = [{62200,1,0,3}],
		notice = 0
};

get(88) ->
	#ernie_reward_data{
		no = 88,
		prob = 100,
		type = 9,
		reward = [{20003,30,0,3}],
		notice = 319
};

get(89) ->
	#ernie_reward_data{
		no = 89,
		prob = 200,
		type = 9,
		reward = [{60027,10,0,3}],
		notice = 319
};

get(90) ->
	#ernie_reward_data{
		no = 90,
		prob = 300,
		type = 9,
		reward = [{62319,3,0,3}],
		notice = 319
};

get(91) ->
	#ernie_reward_data{
		no = 91,
		prob = 1,
		type = 10,
		reward = [{62319,30,0,3}],
		notice = 319
};

get(92) ->
	#ernie_reward_data{
		no = 92,
		prob = 600,
		type = 10,
		reward = [{30001,2,0,3}],
		notice = 319
};

get(93) ->
	#ernie_reward_data{
		no = 93,
		prob = 500,
		type = 10,
		reward = [{62034,10,0,3}],
		notice = 319
};

get(94) ->
	#ernie_reward_data{
		no = 94,
		prob = 500,
		type = 10,
		reward = [{62032,1000,0,3}],
		notice = 319
};

get(95) ->
	#ernie_reward_data{
		no = 95,
		prob = 600,
		type = 10,
		reward = [{62243,1,0,3}],
		notice = 319
};

get(96) ->
	#ernie_reward_data{
		no = 96,
		prob = 800,
		type = 10,
		reward = [{62163,2,0,3}],
		notice = 0
};

get(97) ->
	#ernie_reward_data{
		no = 97,
		prob = 800,
		type = 10,
		reward = [{62200,1,0,3}],
		notice = 0
};

get(98) ->
	#ernie_reward_data{
		no = 98,
		prob = 100,
		type = 10,
		reward = [{20003,30,0,3}],
		notice = 319
};

get(99) ->
	#ernie_reward_data{
		no = 99,
		prob = 200,
		type = 10,
		reward = [{60027,10,0,3}],
		notice = 319
};

get(100) ->
	#ernie_reward_data{
		no = 100,
		prob = 300,
		type = 10,
		reward = [{62319,3,0,3}],
		notice = 319
};

get(_No) ->
	?ASSERT(false, {_No}),
    null.

