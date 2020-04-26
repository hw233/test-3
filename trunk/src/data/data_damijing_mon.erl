%%%---------------------------------------
%%% @Module  : data_damijing_mon
%%% @Author  : lzx
%%% @Email   : 
%%% @Description: 大秘境关卡怪物表
%%%---------------------------------------


-module(data_damijing_mon).
-compile(export_all).

-include("damijing.hrl").
-include("debug.hrl").

get_normal_mijing_no()->
	[1,2,3,4,5,6,7,8,9,10].

get_hard_mijing_no()->
	[11,12,13,14,15,16,17,18,19,20,21,22,23,24,25].

get_nightmare_mijing_no()->
	[26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45].

get_normal_huanjing_no()->
	[46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65].

get_hard_huanjing_no()->
	[66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90].

get_nightmare_huanjing_no()->
	[91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120].

get(1) ->
	#damijing_mon{
		no = 1,
		type = 10001,
		num = 1,
		mon_group = 800567,
		elite_mon_group = 0,
		victory_points = 5
};

get(2) ->
	#damijing_mon{
		no = 2,
		type = 10001,
		num = 2,
		mon_group = 800568,
		elite_mon_group = 0,
		victory_points = 5
};

get(3) ->
	#damijing_mon{
		no = 3,
		type = 10001,
		num = 3,
		mon_group = 800569,
		elite_mon_group = 0,
		victory_points = 5
};

get(4) ->
	#damijing_mon{
		no = 4,
		type = 10001,
		num = 4,
		mon_group = 800570,
		elite_mon_group = 0,
		victory_points = 5
};

get(5) ->
	#damijing_mon{
		no = 5,
		type = 10001,
		num = 5,
		mon_group = 800571,
		elite_mon_group = 800687,
		victory_points = 5
};

get(6) ->
	#damijing_mon{
		no = 6,
		type = 10001,
		num = 6,
		mon_group = 800572,
		elite_mon_group = 0,
		victory_points = 5
};

get(7) ->
	#damijing_mon{
		no = 7,
		type = 10001,
		num = 7,
		mon_group = 800573,
		elite_mon_group = 800688,
		victory_points = 5
};

get(8) ->
	#damijing_mon{
		no = 8,
		type = 10001,
		num = 8,
		mon_group = 800574,
		elite_mon_group = 0,
		victory_points = 5
};

get(9) ->
	#damijing_mon{
		no = 9,
		type = 10001,
		num = 9,
		mon_group = 800575,
		elite_mon_group = 800689,
		victory_points = 5
};

get(10) ->
	#damijing_mon{
		no = 10,
		type = 10001,
		num = 10,
		mon_group = 800576,
		elite_mon_group = 0,
		victory_points = 5
};

get(11) ->
	#damijing_mon{
		no = 11,
		type = 10002,
		num = 1,
		mon_group = 800577,
		elite_mon_group = 0,
		victory_points = 5
};

get(12) ->
	#damijing_mon{
		no = 12,
		type = 10002,
		num = 2,
		mon_group = 800578,
		elite_mon_group = 0,
		victory_points = 5
};

get(13) ->
	#damijing_mon{
		no = 13,
		type = 10002,
		num = 3,
		mon_group = 800579,
		elite_mon_group = 0,
		victory_points = 5
};

get(14) ->
	#damijing_mon{
		no = 14,
		type = 10002,
		num = 4,
		mon_group = 800580,
		elite_mon_group = 0,
		victory_points = 5
};

get(15) ->
	#damijing_mon{
		no = 15,
		type = 10002,
		num = 5,
		mon_group = 800581,
		elite_mon_group = 0,
		victory_points = 5
};

get(16) ->
	#damijing_mon{
		no = 16,
		type = 10002,
		num = 6,
		mon_group = 800582,
		elite_mon_group = 800690,
		victory_points = 5
};

get(17) ->
	#damijing_mon{
		no = 17,
		type = 10002,
		num = 7,
		mon_group = 800583,
		elite_mon_group = 0,
		victory_points = 5
};

get(18) ->
	#damijing_mon{
		no = 18,
		type = 10002,
		num = 8,
		mon_group = 800584,
		elite_mon_group = 0,
		victory_points = 5
};

get(19) ->
	#damijing_mon{
		no = 19,
		type = 10002,
		num = 9,
		mon_group = 800585,
		elite_mon_group = 800691,
		victory_points = 5
};

get(20) ->
	#damijing_mon{
		no = 20,
		type = 10002,
		num = 10,
		mon_group = 800586,
		elite_mon_group = 0,
		victory_points = 5
};

get(21) ->
	#damijing_mon{
		no = 21,
		type = 10002,
		num = 11,
		mon_group = 800587,
		elite_mon_group = 800692,
		victory_points = 5
};

get(22) ->
	#damijing_mon{
		no = 22,
		type = 10002,
		num = 12,
		mon_group = 800588,
		elite_mon_group = 0,
		victory_points = 5
};

get(23) ->
	#damijing_mon{
		no = 23,
		type = 10002,
		num = 13,
		mon_group = 800589,
		elite_mon_group = 800693,
		victory_points = 5
};

get(24) ->
	#damijing_mon{
		no = 24,
		type = 10002,
		num = 14,
		mon_group = 800590,
		elite_mon_group = 0,
		victory_points = 5
};

get(25) ->
	#damijing_mon{
		no = 25,
		type = 10002,
		num = 15,
		mon_group = 800591,
		elite_mon_group = 800694,
		victory_points = 5
};

get(26) ->
	#damijing_mon{
		no = 26,
		type = 10003,
		num = 1,
		mon_group = 800592,
		elite_mon_group = 0,
		victory_points = 5
};

get(27) ->
	#damijing_mon{
		no = 27,
		type = 10003,
		num = 2,
		mon_group = 800593,
		elite_mon_group = 0,
		victory_points = 5
};

get(28) ->
	#damijing_mon{
		no = 28,
		type = 10003,
		num = 3,
		mon_group = 800594,
		elite_mon_group = 0,
		victory_points = 5
};

get(29) ->
	#damijing_mon{
		no = 29,
		type = 10003,
		num = 4,
		mon_group = 800595,
		elite_mon_group = 0,
		victory_points = 5
};

get(30) ->
	#damijing_mon{
		no = 30,
		type = 10003,
		num = 5,
		mon_group = 800596,
		elite_mon_group = 0,
		victory_points = 5
};

get(31) ->
	#damijing_mon{
		no = 31,
		type = 10003,
		num = 6,
		mon_group = 800597,
		elite_mon_group = 800695,
		victory_points = 5
};

get(32) ->
	#damijing_mon{
		no = 32,
		type = 10003,
		num = 7,
		mon_group = 800598,
		elite_mon_group = 0,
		victory_points = 5
};

get(33) ->
	#damijing_mon{
		no = 33,
		type = 10003,
		num = 8,
		mon_group = 800599,
		elite_mon_group = 0,
		victory_points = 5
};

get(34) ->
	#damijing_mon{
		no = 34,
		type = 10003,
		num = 9,
		mon_group = 800600,
		elite_mon_group = 800696,
		victory_points = 5
};

get(35) ->
	#damijing_mon{
		no = 35,
		type = 10003,
		num = 10,
		mon_group = 800601,
		elite_mon_group = 0,
		victory_points = 5
};

get(36) ->
	#damijing_mon{
		no = 36,
		type = 10003,
		num = 11,
		mon_group = 800602,
		elite_mon_group = 0,
		victory_points = 5
};

get(37) ->
	#damijing_mon{
		no = 37,
		type = 10003,
		num = 12,
		mon_group = 800603,
		elite_mon_group = 800697,
		victory_points = 5
};

get(38) ->
	#damijing_mon{
		no = 38,
		type = 10003,
		num = 13,
		mon_group = 800604,
		elite_mon_group = 0,
		victory_points = 5
};

get(39) ->
	#damijing_mon{
		no = 39,
		type = 10003,
		num = 14,
		mon_group = 800605,
		elite_mon_group = 800698,
		victory_points = 5
};

get(40) ->
	#damijing_mon{
		no = 40,
		type = 10003,
		num = 15,
		mon_group = 800606,
		elite_mon_group = 0,
		victory_points = 5
};

get(41) ->
	#damijing_mon{
		no = 41,
		type = 10003,
		num = 16,
		mon_group = 800607,
		elite_mon_group = 800699,
		victory_points = 5
};

get(42) ->
	#damijing_mon{
		no = 42,
		type = 10003,
		num = 17,
		mon_group = 800608,
		elite_mon_group = 0,
		victory_points = 5
};

get(43) ->
	#damijing_mon{
		no = 43,
		type = 10003,
		num = 18,
		mon_group = 800609,
		elite_mon_group = 800700,
		victory_points = 5
};

get(44) ->
	#damijing_mon{
		no = 44,
		type = 10003,
		num = 19,
		mon_group = 800610,
		elite_mon_group = 0,
		victory_points = 5
};

get(45) ->
	#damijing_mon{
		no = 45,
		type = 10003,
		num = 20,
		mon_group = 800611,
		elite_mon_group = 800701,
		victory_points = 5
};

get(46) ->
	#damijing_mon{
		no = 46,
		type = 10011,
		num = 1,
		mon_group = 800612,
		elite_mon_group = 0,
		victory_points = 10
};

get(47) ->
	#damijing_mon{
		no = 47,
		type = 10011,
		num = 2,
		mon_group = 800613,
		elite_mon_group = 0,
		victory_points = 10
};

get(48) ->
	#damijing_mon{
		no = 48,
		type = 10011,
		num = 3,
		mon_group = 800614,
		elite_mon_group = 800702,
		victory_points = 10
};

get(49) ->
	#damijing_mon{
		no = 49,
		type = 10011,
		num = 4,
		mon_group = 800615,
		elite_mon_group = 800703,
		victory_points = 10
};

get(50) ->
	#damijing_mon{
		no = 50,
		type = 10011,
		num = 5,
		mon_group = 800616,
		elite_mon_group = 0,
		victory_points = 10
};

get(51) ->
	#damijing_mon{
		no = 51,
		type = 10011,
		num = 6,
		mon_group = 800617,
		elite_mon_group = 800704,
		victory_points = 10
};

get(52) ->
	#damijing_mon{
		no = 52,
		type = 10011,
		num = 7,
		mon_group = 800618,
		elite_mon_group = 800705,
		victory_points = 10
};

get(53) ->
	#damijing_mon{
		no = 53,
		type = 10011,
		num = 8,
		mon_group = 800619,
		elite_mon_group = 0,
		victory_points = 10
};

get(54) ->
	#damijing_mon{
		no = 54,
		type = 10011,
		num = 9,
		mon_group = 800620,
		elite_mon_group = 800706,
		victory_points = 10
};

get(55) ->
	#damijing_mon{
		no = 55,
		type = 10011,
		num = 10,
		mon_group = 800621,
		elite_mon_group = 800707,
		victory_points = 10
};

get(56) ->
	#damijing_mon{
		no = 56,
		type = 10011,
		num = 11,
		mon_group = 800622,
		elite_mon_group = 0,
		victory_points = 10
};

get(57) ->
	#damijing_mon{
		no = 57,
		type = 10011,
		num = 12,
		mon_group = 800623,
		elite_mon_group = 800708,
		victory_points = 10
};

get(58) ->
	#damijing_mon{
		no = 58,
		type = 10011,
		num = 13,
		mon_group = 800624,
		elite_mon_group = 800709,
		victory_points = 10
};

get(59) ->
	#damijing_mon{
		no = 59,
		type = 10011,
		num = 14,
		mon_group = 800625,
		elite_mon_group = 0,
		victory_points = 10
};

get(60) ->
	#damijing_mon{
		no = 60,
		type = 10011,
		num = 15,
		mon_group = 800626,
		elite_mon_group = 800710,
		victory_points = 10
};

get(61) ->
	#damijing_mon{
		no = 61,
		type = 10011,
		num = 16,
		mon_group = 800627,
		elite_mon_group = 800711,
		victory_points = 10
};

get(62) ->
	#damijing_mon{
		no = 62,
		type = 10011,
		num = 17,
		mon_group = 800628,
		elite_mon_group = 0,
		victory_points = 10
};

get(63) ->
	#damijing_mon{
		no = 63,
		type = 10011,
		num = 18,
		mon_group = 800629,
		elite_mon_group = 800712,
		victory_points = 10
};

get(64) ->
	#damijing_mon{
		no = 64,
		type = 10011,
		num = 19,
		mon_group = 800630,
		elite_mon_group = 800713,
		victory_points = 10
};

get(65) ->
	#damijing_mon{
		no = 65,
		type = 10011,
		num = 20,
		mon_group = 800631,
		elite_mon_group = 800714,
		victory_points = 10
};

get(66) ->
	#damijing_mon{
		no = 66,
		type = 10012,
		num = 1,
		mon_group = 800632,
		elite_mon_group = 0,
		victory_points = 10
};

get(67) ->
	#damijing_mon{
		no = 67,
		type = 10012,
		num = 2,
		mon_group = 800633,
		elite_mon_group = 0,
		victory_points = 10
};

get(68) ->
	#damijing_mon{
		no = 68,
		type = 10012,
		num = 3,
		mon_group = 800634,
		elite_mon_group = 800715,
		victory_points = 10
};

get(69) ->
	#damijing_mon{
		no = 69,
		type = 10012,
		num = 4,
		mon_group = 800635,
		elite_mon_group = 800716,
		victory_points = 10
};

get(70) ->
	#damijing_mon{
		no = 70,
		type = 10012,
		num = 5,
		mon_group = 800636,
		elite_mon_group = 0,
		victory_points = 10
};

get(71) ->
	#damijing_mon{
		no = 71,
		type = 10012,
		num = 6,
		mon_group = 800637,
		elite_mon_group = 800717,
		victory_points = 10
};

get(72) ->
	#damijing_mon{
		no = 72,
		type = 10012,
		num = 7,
		mon_group = 800638,
		elite_mon_group = 800718,
		victory_points = 10
};

get(73) ->
	#damijing_mon{
		no = 73,
		type = 10012,
		num = 8,
		mon_group = 800639,
		elite_mon_group = 0,
		victory_points = 10
};

get(74) ->
	#damijing_mon{
		no = 74,
		type = 10012,
		num = 9,
		mon_group = 800640,
		elite_mon_group = 800719,
		victory_points = 10
};

get(75) ->
	#damijing_mon{
		no = 75,
		type = 10012,
		num = 10,
		mon_group = 800641,
		elite_mon_group = 800720,
		victory_points = 10
};

get(76) ->
	#damijing_mon{
		no = 76,
		type = 10012,
		num = 11,
		mon_group = 800642,
		elite_mon_group = 0,
		victory_points = 10
};

get(77) ->
	#damijing_mon{
		no = 77,
		type = 10012,
		num = 12,
		mon_group = 800643,
		elite_mon_group = 800721,
		victory_points = 10
};

get(78) ->
	#damijing_mon{
		no = 78,
		type = 10012,
		num = 13,
		mon_group = 800644,
		elite_mon_group = 800722,
		victory_points = 10
};

get(79) ->
	#damijing_mon{
		no = 79,
		type = 10012,
		num = 14,
		mon_group = 800645,
		elite_mon_group = 0,
		victory_points = 10
};

get(80) ->
	#damijing_mon{
		no = 80,
		type = 10012,
		num = 15,
		mon_group = 800646,
		elite_mon_group = 800723,
		victory_points = 10
};

get(81) ->
	#damijing_mon{
		no = 81,
		type = 10012,
		num = 16,
		mon_group = 800647,
		elite_mon_group = 800724,
		victory_points = 10
};

get(82) ->
	#damijing_mon{
		no = 82,
		type = 10012,
		num = 17,
		mon_group = 800648,
		elite_mon_group = 0,
		victory_points = 10
};

get(83) ->
	#damijing_mon{
		no = 83,
		type = 10012,
		num = 18,
		mon_group = 800649,
		elite_mon_group = 800725,
		victory_points = 10
};

get(84) ->
	#damijing_mon{
		no = 84,
		type = 10012,
		num = 19,
		mon_group = 800650,
		elite_mon_group = 800726,
		victory_points = 10
};

get(85) ->
	#damijing_mon{
		no = 85,
		type = 10012,
		num = 20,
		mon_group = 800651,
		elite_mon_group = 0,
		victory_points = 10
};

get(86) ->
	#damijing_mon{
		no = 86,
		type = 10012,
		num = 21,
		mon_group = 800652,
		elite_mon_group = 800727,
		victory_points = 10
};

get(87) ->
	#damijing_mon{
		no = 87,
		type = 10012,
		num = 22,
		mon_group = 800653,
		elite_mon_group = 800728,
		victory_points = 10
};

get(88) ->
	#damijing_mon{
		no = 88,
		type = 10012,
		num = 23,
		mon_group = 800654,
		elite_mon_group = 0,
		victory_points = 10
};

get(89) ->
	#damijing_mon{
		no = 89,
		type = 10012,
		num = 24,
		mon_group = 800655,
		elite_mon_group = 800729,
		victory_points = 10
};

get(90) ->
	#damijing_mon{
		no = 90,
		type = 10012,
		num = 25,
		mon_group = 800656,
		elite_mon_group = 800730,
		victory_points = 10
};

get(91) ->
	#damijing_mon{
		no = 91,
		type = 10013,
		num = 1,
		mon_group = 800657,
		elite_mon_group = 0,
		victory_points = 10
};

get(92) ->
	#damijing_mon{
		no = 92,
		type = 10013,
		num = 2,
		mon_group = 800658,
		elite_mon_group = 0,
		victory_points = 10
};

get(93) ->
	#damijing_mon{
		no = 93,
		type = 10013,
		num = 3,
		mon_group = 800659,
		elite_mon_group = 800731,
		victory_points = 10
};

get(94) ->
	#damijing_mon{
		no = 94,
		type = 10013,
		num = 4,
		mon_group = 800660,
		elite_mon_group = 800732,
		victory_points = 10
};

get(95) ->
	#damijing_mon{
		no = 95,
		type = 10013,
		num = 5,
		mon_group = 800661,
		elite_mon_group = 0,
		victory_points = 10
};

get(96) ->
	#damijing_mon{
		no = 96,
		type = 10013,
		num = 6,
		mon_group = 800662,
		elite_mon_group = 800733,
		victory_points = 10
};

get(97) ->
	#damijing_mon{
		no = 97,
		type = 10013,
		num = 7,
		mon_group = 800663,
		elite_mon_group = 800734,
		victory_points = 10
};

get(98) ->
	#damijing_mon{
		no = 98,
		type = 10013,
		num = 8,
		mon_group = 800664,
		elite_mon_group = 0,
		victory_points = 10
};

get(99) ->
	#damijing_mon{
		no = 99,
		type = 10013,
		num = 9,
		mon_group = 800665,
		elite_mon_group = 800735,
		victory_points = 10
};

get(100) ->
	#damijing_mon{
		no = 100,
		type = 10013,
		num = 10,
		mon_group = 800666,
		elite_mon_group = 800736,
		victory_points = 10
};

get(101) ->
	#damijing_mon{
		no = 101,
		type = 10013,
		num = 11,
		mon_group = 800667,
		elite_mon_group = 0,
		victory_points = 10
};

get(102) ->
	#damijing_mon{
		no = 102,
		type = 10013,
		num = 12,
		mon_group = 800668,
		elite_mon_group = 800737,
		victory_points = 10
};

get(103) ->
	#damijing_mon{
		no = 103,
		type = 10013,
		num = 13,
		mon_group = 800669,
		elite_mon_group = 800738,
		victory_points = 10
};

get(104) ->
	#damijing_mon{
		no = 104,
		type = 10013,
		num = 14,
		mon_group = 800670,
		elite_mon_group = 0,
		victory_points = 10
};

get(105) ->
	#damijing_mon{
		no = 105,
		type = 10013,
		num = 15,
		mon_group = 800671,
		elite_mon_group = 800739,
		victory_points = 10
};

get(106) ->
	#damijing_mon{
		no = 106,
		type = 10013,
		num = 16,
		mon_group = 800672,
		elite_mon_group = 800740,
		victory_points = 10
};

get(107) ->
	#damijing_mon{
		no = 107,
		type = 10013,
		num = 17,
		mon_group = 800673,
		elite_mon_group = 0,
		victory_points = 10
};

get(108) ->
	#damijing_mon{
		no = 108,
		type = 10013,
		num = 18,
		mon_group = 800674,
		elite_mon_group = 800741,
		victory_points = 10
};

get(109) ->
	#damijing_mon{
		no = 109,
		type = 10013,
		num = 19,
		mon_group = 800675,
		elite_mon_group = 800742,
		victory_points = 10
};

get(110) ->
	#damijing_mon{
		no = 110,
		type = 10013,
		num = 20,
		mon_group = 800676,
		elite_mon_group = 0,
		victory_points = 10
};

get(111) ->
	#damijing_mon{
		no = 111,
		type = 10013,
		num = 21,
		mon_group = 800677,
		elite_mon_group = 800743,
		victory_points = 10
};

get(112) ->
	#damijing_mon{
		no = 112,
		type = 10013,
		num = 22,
		mon_group = 800678,
		elite_mon_group = 800744,
		victory_points = 10
};

get(113) ->
	#damijing_mon{
		no = 113,
		type = 10013,
		num = 23,
		mon_group = 800679,
		elite_mon_group = 0,
		victory_points = 10
};

get(114) ->
	#damijing_mon{
		no = 114,
		type = 10013,
		num = 24,
		mon_group = 800680,
		elite_mon_group = 800745,
		victory_points = 10
};

get(115) ->
	#damijing_mon{
		no = 115,
		type = 10013,
		num = 25,
		mon_group = 800681,
		elite_mon_group = 800746,
		victory_points = 10
};

get(116) ->
	#damijing_mon{
		no = 116,
		type = 10013,
		num = 26,
		mon_group = 800682,
		elite_mon_group = 800747,
		victory_points = 10
};

get(117) ->
	#damijing_mon{
		no = 117,
		type = 10013,
		num = 27,
		mon_group = 800683,
		elite_mon_group = 0,
		victory_points = 10
};

get(118) ->
	#damijing_mon{
		no = 118,
		type = 10013,
		num = 28,
		mon_group = 800684,
		elite_mon_group = 800748,
		victory_points = 10
};

get(119) ->
	#damijing_mon{
		no = 119,
		type = 10013,
		num = 29,
		mon_group = 800685,
		elite_mon_group = 800749,
		victory_points = 10
};

get(120) ->
	#damijing_mon{
		no = 120,
		type = 10013,
		num = 30,
		mon_group = 800686,
		elite_mon_group = 800750,
		victory_points = 10
};

get(_No) ->
	?ASSERT(false, {_No}),
    null.

