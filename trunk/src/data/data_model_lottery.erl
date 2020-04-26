%%%---------------------------------------
%%% @Module  : data_model_lottery
%%% @Author  : easy
%%% @Email   : 
%%% @Description: 限时抽奖
%%%---------------------------------------


-module(data_model_lottery).
-compile(export_all).

-include("newyear_banquet.hrl").
-include("debug.hrl").

get_no()->
	[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77].

get(1) ->
	#lottery_data{
		no = 1,
		reward = [{62375, 1, 700, 0, 3}],
		notice = 0
};

get(2) ->
	#lottery_data{
		no = 2,
		reward = [{70051,50,1000,0,3}],
		notice = 0
};

get(3) ->
	#lottery_data{
		no = 3,
		reward = [{70052,50,1000,0,3}],
		notice = 0
};

get(4) ->
	#lottery_data{
		no = 4,
		reward = [{70053,50,1000,0,3}],
		notice = 0
};

get(5) ->
	#lottery_data{
		no = 5,
		reward = [{70054,50,1000,0,3}],
		notice = 0
};

get(6) ->
	#lottery_data{
		no = 6,
		reward = [{70055,50,1000,0,3}],
		notice = 0
};

get(7) ->
	#lottery_data{
		no = 7,
		reward = [{70056,50,1000,0,3}],
		notice = 0
};

get(8) ->
	#lottery_data{
		no = 8,
		reward = [{62034,5,600,0,3}],
		notice = 0
};

get(9) ->
	#lottery_data{
		no = 9,
		reward = [{60027,10,500,0,3}],
		notice = 0
};

get(10) ->
	#lottery_data{
		no = 10,
		reward = [{62375,2,500,0,3}],
		notice = 0
};

get(11) ->
	#lottery_data{
		no = 11,
		reward = [{62374, 2, 500, 0, 3}],
		notice = 0
};

get(12) ->
	#lottery_data{
		no = 12,
		reward = [{30001, 1, 400,0,3}],
		notice = 0
};

get(13) ->
	#lottery_data{
		no = 13,
		reward = [{62381, 1, 400,0,3}],
		notice = 0
};

get(14) ->
	#lottery_data{
		no = 14,
		reward = [{62220, 1, 300,0,3}],
		notice = 0
};

get(15) ->
	#lottery_data{
		no = 15,
		reward = [{62168,1,600,0,3}],
		notice = 0
};

get(16) ->
	#lottery_data{
		no = 16,
		reward = [{62165,1,500,0,3}],
		notice = 0
};

get(17) ->
	#lottery_data{
		no = 17,
		reward = [{62164,1,400,0,3}],
		notice = 0
};

get(18) ->
	#lottery_data{
		no = 18,
		reward = [{62163,1,300,0,3}],
		notice = 0
};

get(19) ->
	#lottery_data{
		no = 19,
		reward = [{62034,80,100,0,3}],
		notice = 0
};

get(20) ->
	#lottery_data{
		no = 20,
		reward = [{62374,3,500,0,3}],
		notice = 0
};

get(21) ->
	#lottery_data{
		no = 21,
		reward = [{62318,1,700,0,3}],
		notice = 0
};

get(22) ->
	#lottery_data{
		no = 22,
		reward = [{50307,200,900,0,3}],
		notice = 0
};

get(23) ->
	#lottery_data{
		no = 23,
		reward = [{50038,200,900,0,3}],
		notice = 0
};

get(24) ->
	#lottery_data{
		no = 24,
		reward = [{62032,200,900,0,3}],
		notice = 0
};

get(25) ->
	#lottery_data{
		no = 25,
		reward = [{60101,200,800,0,3}],
		notice = 0
};

get(26) ->
	#lottery_data{
		no = 26,
		reward = [{10043,200,800,0,3}],
		notice = 0
};

get(27) ->
	#lottery_data{
		no = 27,
		reward = [{30001,2,600,0,3}],
		notice = 0
};

get(28) ->
	#lottery_data{
		no = 28,
		reward = [{62163,2,400,0,3}],
		notice = 0
};

get(29) ->
	#lottery_data{
		no = 29,
		reward = [{60027,10,500,0,3}],
		notice = 0
};

get(30) ->
	#lottery_data{
		no = 30,
		reward = [{62318,3,500,0,3}],
		notice = 0
};

get(31) ->
	#lottery_data{
		no = 31,
		reward = [{62376,3,500,0,3}],
		notice = 0
};

get(32) ->
	#lottery_data{
		no = 32,
		reward = [{70055,80,700,0,3}],
		notice = 0
};

get(33) ->
	#lottery_data{
		no = 33,
		reward = [{70056,80,700,0,3}],
		notice = 0
};

get(34) ->
	#lottery_data{
		no = 34,
		reward = [{50307,200,800,0,3}],
		notice = 0
};

get(35) ->
	#lottery_data{
		no = 35,
		reward = [{62163,2,500,0,3}],
		notice = 0
};

get(36) ->
	#lottery_data{
		no = 36,
		reward = [{30001,2,500,0,3}],
		notice = 0
};

get(37) ->
	#lottery_data{
		no = 37,
		reward = [{62200,1,500,0,3}],
		notice = 0
};

get(38) ->
	#lottery_data{
		no = 38,
		reward = [{62239,1,700,0,3}],
		notice = 0
};

get(39) ->
	#lottery_data{
		no = 39,
		reward = [{20017,30,500,0,3}],
		notice = 0
};

get(40) ->
	#lottery_data{
		no = 40,
		reward = [{62376,5,500,0,3}],
		notice = 0
};

get(41) ->
	#lottery_data{
		no = 41,
		reward = [{62373,2,700,0,3}],
		notice = 0
};

get(42) ->
	#lottery_data{
		no = 42,
		reward = [{70053,80,900,0,3}],
		notice = 0
};

get(43) ->
	#lottery_data{
		no = 43,
		reward = [{70054,80,900,0,3}],
		notice = 0
};

get(44) ->
	#lottery_data{
		no = 44,
		reward = [{50038,400,800,0,3}],
		notice = 0
};

get(45) ->
	#lottery_data{
		no = 45,
		reward = [{62163,2,500,0,3}],
		notice = 0
};

get(46) ->
	#lottery_data{
		no = 46,
		reward = [{30001,4,300,0,3}],
		notice = 0
};

get(47) ->
	#lottery_data{
		no = 47,
		reward = [{62197,1,400,0,3}],
		notice = 0
};

get(48) ->
	#lottery_data{
		no = 48,
		reward = [{62240,1,700,0,3}],
		notice = 0
};

get(49) ->
	#lottery_data{
		no = 49,
		reward = [{20011,30,400,0,3}],
		notice = 0
};

get(50) ->
	#lottery_data{
		no = 50,
		reward = [{62373,5,600,0,3}],
		notice = 0
};

get(51) ->
	#lottery_data{
		no = 51,
		reward = [{62317,3,500,0,3}],
		notice = 0
};

get(52) ->
	#lottery_data{
		no = 52,
		reward = [{70051,100,900,0,3}],
		notice = 0
};

get(53) ->
	#lottery_data{
		no = 53,
		reward = [{70052,100,900,0,3}],
		notice = 0
};

get(54) ->
	#lottery_data{
		no = 54,
		reward = [{10043,1000,700,0,3}],
		notice = 0
};

get(55) ->
	#lottery_data{
		no = 55,
		reward = [{62165,2,600,0,3}],
		notice = 0
};

get(56) ->
	#lottery_data{
		no = 56,
		reward = [{30001,2,500,0,3}],
		notice = 0
};

get(57) ->
	#lottery_data{
		no = 57,
		reward = [{62185,1,600,0,3}],
		notice = 0
};

get(58) ->
	#lottery_data{
		no = 58,
		reward = [{62241,1,700,0,3}],
		notice = 0
};

get(59) ->
	#lottery_data{
		no = 59,
		reward = [{20007,30,400,0,3}],
		notice = 0
};

get(60) ->
	#lottery_data{
		no = 60,
		reward = [{62317,5,500,0,3}],
		notice = 0
};

get(61) ->
	#lottery_data{
		no = 61,
		reward = [{62373,3,700,0,3}],
		notice = 0
};

get(62) ->
	#lottery_data{
		no = 62,
		reward = [{10038,5,700,0,3}],
		notice = 0
};

get(63) ->
	#lottery_data{
		no = 63,
		reward = [{60027,20,300,0,3}],
		notice = 0
};

get(64) ->
	#lottery_data{
		no = 64,
		reward = [{60101,400,700,0,3}],
		notice = 0
};

get(65) ->
	#lottery_data{
		no = 65,
		reward = [{10236,3,800,0,3}],
		notice = 0
};

get(66) ->
	#lottery_data{
		no = 66,
		reward = [{30001,3,400,0,3}],
		notice = 0
};

get(67) ->
	#lottery_data{
		no = 67,
		reward = [{10237,5,700,0,3}],
		notice = 0
};

get(68) ->
	#lottery_data{
		no = 68,
		reward = [{62242,1,700,0,3}],
		notice = 0
};

get(69) ->
	#lottery_data{
		no = 69,
		reward = [{20021,30,400,0,3}],
		notice = 0
};

get(70) ->
	#lottery_data{
		no = 70,
		reward = [{62373,6,500,0,3}],
		notice = 0
};

get(71) ->
	#lottery_data{
		no = 71,
		reward = [{62319,3,500,0,3}],
		notice = 0
};

get(72) ->
	#lottery_data{
		no = 72,
		reward = [{60027,15,500,0,3}],
		notice = 0
};

get(73) ->
	#lottery_data{
		no = 73,
		reward = [{62034,10,600,0,3}],
		notice = 0
};

get(74) ->
	#lottery_data{
		no = 74,
		reward = [{62032,400,700,0,3}],
		notice = 0
};

get(75) ->
	#lottery_data{
		no = 75,
		reward = [{62243,1,700,0,3}],
		notice = 0
};

get(76) ->
	#lottery_data{
		no = 76,
		reward = [{20003,30,400,0,3}],
		notice = 0
};

get(77) ->
	#lottery_data{
		no = 77,
		reward = [{62319,5,500,0,3}],
		notice = 0
};

get(_No) ->
	?ASSERT(false, {_No}),
    null.

