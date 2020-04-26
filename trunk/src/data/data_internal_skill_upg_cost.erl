%%%---------------------------------------
%%% @Module  : data_internal_skill_upg_cost
%%% @Author  : easy
%%% @Email   : 
%%% @Description: 内功升级经验表
%%%---------------------------------------


-module(data_internal_skill_upg_cost).
-export([
        get_lv/0,
        get/1
    ]).

-include("train.hrl").
-include("debug.hrl").

get_lv()->
	[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100].

get(1) ->
	#internal_skill_upg_cost_cfg{
		lv = 1,
		star_1_exp = 30,
		star_2_exp = 150,
		star_3_exp = 1150,
		star_4_exp = 1013,
		star_5_exp = 1055,
		star_6_exp = 1266
};

get(2) ->
	#internal_skill_upg_cost_cfg{
		lv = 2,
		star_1_exp = 60,
		star_2_exp = 200,
		star_3_exp = 1300,
		star_4_exp = 1032,
		star_5_exp = 1120,
		star_6_exp = 1344
};

get(3) ->
	#internal_skill_upg_cost_cfg{
		lv = 3,
		star_1_exp = 90,
		star_2_exp = 250,
		star_3_exp = 1450,
		star_4_exp = 1057,
		star_5_exp = 1195,
		star_6_exp = 1434
};

get(4) ->
	#internal_skill_upg_cost_cfg{
		lv = 4,
		star_1_exp = 120,
		star_2_exp = 300,
		star_3_exp = 1600,
		star_4_exp = 1088,
		star_5_exp = 1280,
		star_6_exp = 1536
};

get(5) ->
	#internal_skill_upg_cost_cfg{
		lv = 5,
		star_1_exp = 150,
		star_2_exp = 350,
		star_3_exp = 1750,
		star_4_exp = 1125,
		star_5_exp = 1375,
		star_6_exp = 1650
};

get(6) ->
	#internal_skill_upg_cost_cfg{
		lv = 6,
		star_1_exp = 180,
		star_2_exp = 400,
		star_3_exp = 1900,
		star_4_exp = 1168,
		star_5_exp = 1480,
		star_6_exp = 1776
};

get(7) ->
	#internal_skill_upg_cost_cfg{
		lv = 7,
		star_1_exp = 210,
		star_2_exp = 450,
		star_3_exp = 2050,
		star_4_exp = 1217,
		star_5_exp = 1595,
		star_6_exp = 1914
};

get(8) ->
	#internal_skill_upg_cost_cfg{
		lv = 8,
		star_1_exp = 240,
		star_2_exp = 500,
		star_3_exp = 2200,
		star_4_exp = 1272,
		star_5_exp = 1720,
		star_6_exp = 2064
};

get(9) ->
	#internal_skill_upg_cost_cfg{
		lv = 9,
		star_1_exp = 270,
		star_2_exp = 550,
		star_3_exp = 2350,
		star_4_exp = 1333,
		star_5_exp = 1855,
		star_6_exp = 2226
};

get(10) ->
	#internal_skill_upg_cost_cfg{
		lv = 10,
		star_1_exp = 300,
		star_2_exp = 600,
		star_3_exp = 2500,
		star_4_exp = 1400,
		star_5_exp = 2000,
		star_6_exp = 2400
};

get(11) ->
	#internal_skill_upg_cost_cfg{
		lv = 11,
		star_1_exp = 330,
		star_2_exp = 650,
		star_3_exp = 2650,
		star_4_exp = 1473,
		star_5_exp = 2155,
		star_6_exp = 2586
};

get(12) ->
	#internal_skill_upg_cost_cfg{
		lv = 12,
		star_1_exp = 360,
		star_2_exp = 700,
		star_3_exp = 2800,
		star_4_exp = 1552,
		star_5_exp = 2320,
		star_6_exp = 2784
};

get(13) ->
	#internal_skill_upg_cost_cfg{
		lv = 13,
		star_1_exp = 390,
		star_2_exp = 750,
		star_3_exp = 2950,
		star_4_exp = 1637,
		star_5_exp = 2495,
		star_6_exp = 2994
};

get(14) ->
	#internal_skill_upg_cost_cfg{
		lv = 14,
		star_1_exp = 420,
		star_2_exp = 800,
		star_3_exp = 3100,
		star_4_exp = 1728,
		star_5_exp = 2680,
		star_6_exp = 3216
};

get(15) ->
	#internal_skill_upg_cost_cfg{
		lv = 15,
		star_1_exp = 450,
		star_2_exp = 850,
		star_3_exp = 3250,
		star_4_exp = 1825,
		star_5_exp = 2875,
		star_6_exp = 3450
};

get(16) ->
	#internal_skill_upg_cost_cfg{
		lv = 16,
		star_1_exp = 480,
		star_2_exp = 900,
		star_3_exp = 3400,
		star_4_exp = 1928,
		star_5_exp = 3080,
		star_6_exp = 3696
};

get(17) ->
	#internal_skill_upg_cost_cfg{
		lv = 17,
		star_1_exp = 510,
		star_2_exp = 950,
		star_3_exp = 3550,
		star_4_exp = 2037,
		star_5_exp = 3295,
		star_6_exp = 3954
};

get(18) ->
	#internal_skill_upg_cost_cfg{
		lv = 18,
		star_1_exp = 540,
		star_2_exp = 1000,
		star_3_exp = 3700,
		star_4_exp = 2152,
		star_5_exp = 3520,
		star_6_exp = 4224
};

get(19) ->
	#internal_skill_upg_cost_cfg{
		lv = 19,
		star_1_exp = 570,
		star_2_exp = 1050,
		star_3_exp = 3850,
		star_4_exp = 2273,
		star_5_exp = 3755,
		star_6_exp = 4506
};

get(20) ->
	#internal_skill_upg_cost_cfg{
		lv = 20,
		star_1_exp = 600,
		star_2_exp = 1100,
		star_3_exp = 4000,
		star_4_exp = 2400,
		star_5_exp = 4000,
		star_6_exp = 4800
};

get(21) ->
	#internal_skill_upg_cost_cfg{
		lv = 21,
		star_1_exp = 630,
		star_2_exp = 1150,
		star_3_exp = 4150,
		star_4_exp = 2533,
		star_5_exp = 4255,
		star_6_exp = 5106
};

get(22) ->
	#internal_skill_upg_cost_cfg{
		lv = 22,
		star_1_exp = 660,
		star_2_exp = 1200,
		star_3_exp = 4300,
		star_4_exp = 2672,
		star_5_exp = 4520,
		star_6_exp = 5424
};

get(23) ->
	#internal_skill_upg_cost_cfg{
		lv = 23,
		star_1_exp = 690,
		star_2_exp = 1250,
		star_3_exp = 4450,
		star_4_exp = 2817,
		star_5_exp = 4795,
		star_6_exp = 5754
};

get(24) ->
	#internal_skill_upg_cost_cfg{
		lv = 24,
		star_1_exp = 720,
		star_2_exp = 1300,
		star_3_exp = 4600,
		star_4_exp = 2968,
		star_5_exp = 5080,
		star_6_exp = 6096
};

get(25) ->
	#internal_skill_upg_cost_cfg{
		lv = 25,
		star_1_exp = 750,
		star_2_exp = 1350,
		star_3_exp = 4750,
		star_4_exp = 3125,
		star_5_exp = 5375,
		star_6_exp = 6450
};

get(26) ->
	#internal_skill_upg_cost_cfg{
		lv = 26,
		star_1_exp = 780,
		star_2_exp = 1400,
		star_3_exp = 4900,
		star_4_exp = 3288,
		star_5_exp = 5680,
		star_6_exp = 6816
};

get(27) ->
	#internal_skill_upg_cost_cfg{
		lv = 27,
		star_1_exp = 810,
		star_2_exp = 1450,
		star_3_exp = 5050,
		star_4_exp = 3457,
		star_5_exp = 5995,
		star_6_exp = 7194
};

get(28) ->
	#internal_skill_upg_cost_cfg{
		lv = 28,
		star_1_exp = 840,
		star_2_exp = 1500,
		star_3_exp = 5200,
		star_4_exp = 3632,
		star_5_exp = 6320,
		star_6_exp = 7584
};

get(29) ->
	#internal_skill_upg_cost_cfg{
		lv = 29,
		star_1_exp = 870,
		star_2_exp = 1550,
		star_3_exp = 5350,
		star_4_exp = 3813,
		star_5_exp = 6655,
		star_6_exp = 7986
};

get(30) ->
	#internal_skill_upg_cost_cfg{
		lv = 30,
		star_1_exp = 900,
		star_2_exp = 1600,
		star_3_exp = 5500,
		star_4_exp = 4000,
		star_5_exp = 7000,
		star_6_exp = 8400
};

get(31) ->
	#internal_skill_upg_cost_cfg{
		lv = 31,
		star_1_exp = 930,
		star_2_exp = 1650,
		star_3_exp = 5650,
		star_4_exp = 4193,
		star_5_exp = 7355,
		star_6_exp = 8826
};

get(32) ->
	#internal_skill_upg_cost_cfg{
		lv = 32,
		star_1_exp = 960,
		star_2_exp = 1700,
		star_3_exp = 5800,
		star_4_exp = 4392,
		star_5_exp = 7720,
		star_6_exp = 9264
};

get(33) ->
	#internal_skill_upg_cost_cfg{
		lv = 33,
		star_1_exp = 990,
		star_2_exp = 1750,
		star_3_exp = 5950,
		star_4_exp = 4597,
		star_5_exp = 8095,
		star_6_exp = 9714
};

get(34) ->
	#internal_skill_upg_cost_cfg{
		lv = 34,
		star_1_exp = 1020,
		star_2_exp = 1800,
		star_3_exp = 6100,
		star_4_exp = 4808,
		star_5_exp = 8480,
		star_6_exp = 10176
};

get(35) ->
	#internal_skill_upg_cost_cfg{
		lv = 35,
		star_1_exp = 1050,
		star_2_exp = 1850,
		star_3_exp = 6250,
		star_4_exp = 5025,
		star_5_exp = 8875,
		star_6_exp = 10650
};

get(36) ->
	#internal_skill_upg_cost_cfg{
		lv = 36,
		star_1_exp = 1080,
		star_2_exp = 1900,
		star_3_exp = 6400,
		star_4_exp = 5248,
		star_5_exp = 9280,
		star_6_exp = 11136
};

get(37) ->
	#internal_skill_upg_cost_cfg{
		lv = 37,
		star_1_exp = 1110,
		star_2_exp = 1950,
		star_3_exp = 6550,
		star_4_exp = 5477,
		star_5_exp = 9695,
		star_6_exp = 11634
};

get(38) ->
	#internal_skill_upg_cost_cfg{
		lv = 38,
		star_1_exp = 1140,
		star_2_exp = 2000,
		star_3_exp = 6700,
		star_4_exp = 5712,
		star_5_exp = 10120,
		star_6_exp = 12144
};

get(39) ->
	#internal_skill_upg_cost_cfg{
		lv = 39,
		star_1_exp = 1170,
		star_2_exp = 2050,
		star_3_exp = 6850,
		star_4_exp = 5953,
		star_5_exp = 10555,
		star_6_exp = 12666
};

get(40) ->
	#internal_skill_upg_cost_cfg{
		lv = 40,
		star_1_exp = 1200,
		star_2_exp = 2100,
		star_3_exp = 7000,
		star_4_exp = 6200,
		star_5_exp = 11000,
		star_6_exp = 13200
};

get(41) ->
	#internal_skill_upg_cost_cfg{
		lv = 41,
		star_1_exp = 1230,
		star_2_exp = 2150,
		star_3_exp = 7150,
		star_4_exp = 6453,
		star_5_exp = 11455,
		star_6_exp = 13746
};

get(42) ->
	#internal_skill_upg_cost_cfg{
		lv = 42,
		star_1_exp = 1260,
		star_2_exp = 2200,
		star_3_exp = 7300,
		star_4_exp = 6712,
		star_5_exp = 11920,
		star_6_exp = 14304
};

get(43) ->
	#internal_skill_upg_cost_cfg{
		lv = 43,
		star_1_exp = 1290,
		star_2_exp = 2250,
		star_3_exp = 7450,
		star_4_exp = 6977,
		star_5_exp = 12395,
		star_6_exp = 14874
};

get(44) ->
	#internal_skill_upg_cost_cfg{
		lv = 44,
		star_1_exp = 1320,
		star_2_exp = 2300,
		star_3_exp = 7600,
		star_4_exp = 7248,
		star_5_exp = 12880,
		star_6_exp = 15456
};

get(45) ->
	#internal_skill_upg_cost_cfg{
		lv = 45,
		star_1_exp = 1350,
		star_2_exp = 2350,
		star_3_exp = 7750,
		star_4_exp = 7525,
		star_5_exp = 13375,
		star_6_exp = 16050
};

get(46) ->
	#internal_skill_upg_cost_cfg{
		lv = 46,
		star_1_exp = 1380,
		star_2_exp = 2400,
		star_3_exp = 7900,
		star_4_exp = 7808,
		star_5_exp = 13880,
		star_6_exp = 16656
};

get(47) ->
	#internal_skill_upg_cost_cfg{
		lv = 47,
		star_1_exp = 1410,
		star_2_exp = 2450,
		star_3_exp = 8050,
		star_4_exp = 8097,
		star_5_exp = 14395,
		star_6_exp = 17274
};

get(48) ->
	#internal_skill_upg_cost_cfg{
		lv = 48,
		star_1_exp = 1440,
		star_2_exp = 2500,
		star_3_exp = 8200,
		star_4_exp = 8392,
		star_5_exp = 14920,
		star_6_exp = 17904
};

get(49) ->
	#internal_skill_upg_cost_cfg{
		lv = 49,
		star_1_exp = 1470,
		star_2_exp = 2550,
		star_3_exp = 8350,
		star_4_exp = 8693,
		star_5_exp = 15455,
		star_6_exp = 18546
};

get(50) ->
	#internal_skill_upg_cost_cfg{
		lv = 50,
		star_1_exp = 1500,
		star_2_exp = 2600,
		star_3_exp = 8500,
		star_4_exp = 9000,
		star_5_exp = 16000,
		star_6_exp = 19200
};

get(51) ->
	#internal_skill_upg_cost_cfg{
		lv = 51,
		star_1_exp = 1530,
		star_2_exp = 2650,
		star_3_exp = 8650,
		star_4_exp = 9313,
		star_5_exp = 16555,
		star_6_exp = 19866
};

get(52) ->
	#internal_skill_upg_cost_cfg{
		lv = 52,
		star_1_exp = 1560,
		star_2_exp = 2700,
		star_3_exp = 8800,
		star_4_exp = 9632,
		star_5_exp = 17120,
		star_6_exp = 20544
};

get(53) ->
	#internal_skill_upg_cost_cfg{
		lv = 53,
		star_1_exp = 1590,
		star_2_exp = 2750,
		star_3_exp = 8950,
		star_4_exp = 9957,
		star_5_exp = 17695,
		star_6_exp = 21234
};

get(54) ->
	#internal_skill_upg_cost_cfg{
		lv = 54,
		star_1_exp = 1620,
		star_2_exp = 2800,
		star_3_exp = 9100,
		star_4_exp = 10288,
		star_5_exp = 18280,
		star_6_exp = 21936
};

get(55) ->
	#internal_skill_upg_cost_cfg{
		lv = 55,
		star_1_exp = 1650,
		star_2_exp = 2850,
		star_3_exp = 9250,
		star_4_exp = 10625,
		star_5_exp = 18875,
		star_6_exp = 22650
};

get(56) ->
	#internal_skill_upg_cost_cfg{
		lv = 56,
		star_1_exp = 1680,
		star_2_exp = 2900,
		star_3_exp = 9400,
		star_4_exp = 10968,
		star_5_exp = 19480,
		star_6_exp = 23376
};

get(57) ->
	#internal_skill_upg_cost_cfg{
		lv = 57,
		star_1_exp = 1710,
		star_2_exp = 2950,
		star_3_exp = 9550,
		star_4_exp = 11317,
		star_5_exp = 20095,
		star_6_exp = 24114
};

get(58) ->
	#internal_skill_upg_cost_cfg{
		lv = 58,
		star_1_exp = 1740,
		star_2_exp = 3000,
		star_3_exp = 9700,
		star_4_exp = 11672,
		star_5_exp = 20720,
		star_6_exp = 24864
};

get(59) ->
	#internal_skill_upg_cost_cfg{
		lv = 59,
		star_1_exp = 1770,
		star_2_exp = 3050,
		star_3_exp = 9850,
		star_4_exp = 12033,
		star_5_exp = 21355,
		star_6_exp = 25626
};

get(60) ->
	#internal_skill_upg_cost_cfg{
		lv = 60,
		star_1_exp = 1800,
		star_2_exp = 3100,
		star_3_exp = 10000,
		star_4_exp = 12400,
		star_5_exp = 22000,
		star_6_exp = 26400
};

get(61) ->
	#internal_skill_upg_cost_cfg{
		lv = 61,
		star_1_exp = 1830,
		star_2_exp = 3150,
		star_3_exp = 10150,
		star_4_exp = 12773,
		star_5_exp = 22655,
		star_6_exp = 27186
};

get(62) ->
	#internal_skill_upg_cost_cfg{
		lv = 62,
		star_1_exp = 1860,
		star_2_exp = 3200,
		star_3_exp = 10300,
		star_4_exp = 13152,
		star_5_exp = 23320,
		star_6_exp = 27984
};

get(63) ->
	#internal_skill_upg_cost_cfg{
		lv = 63,
		star_1_exp = 1890,
		star_2_exp = 3250,
		star_3_exp = 10450,
		star_4_exp = 13537,
		star_5_exp = 23995,
		star_6_exp = 28794
};

get(64) ->
	#internal_skill_upg_cost_cfg{
		lv = 64,
		star_1_exp = 1920,
		star_2_exp = 3300,
		star_3_exp = 10600,
		star_4_exp = 13928,
		star_5_exp = 24680,
		star_6_exp = 29616
};

get(65) ->
	#internal_skill_upg_cost_cfg{
		lv = 65,
		star_1_exp = 1950,
		star_2_exp = 3350,
		star_3_exp = 10750,
		star_4_exp = 14325,
		star_5_exp = 25375,
		star_6_exp = 30450
};

get(66) ->
	#internal_skill_upg_cost_cfg{
		lv = 66,
		star_1_exp = 1980,
		star_2_exp = 3400,
		star_3_exp = 10900,
		star_4_exp = 14728,
		star_5_exp = 26080,
		star_6_exp = 31296
};

get(67) ->
	#internal_skill_upg_cost_cfg{
		lv = 67,
		star_1_exp = 2010,
		star_2_exp = 3450,
		star_3_exp = 11050,
		star_4_exp = 15137,
		star_5_exp = 26795,
		star_6_exp = 32154
};

get(68) ->
	#internal_skill_upg_cost_cfg{
		lv = 68,
		star_1_exp = 2040,
		star_2_exp = 3500,
		star_3_exp = 11200,
		star_4_exp = 15552,
		star_5_exp = 27520,
		star_6_exp = 33024
};

get(69) ->
	#internal_skill_upg_cost_cfg{
		lv = 69,
		star_1_exp = 2070,
		star_2_exp = 3550,
		star_3_exp = 11350,
		star_4_exp = 15973,
		star_5_exp = 28255,
		star_6_exp = 33906
};

get(70) ->
	#internal_skill_upg_cost_cfg{
		lv = 70,
		star_1_exp = 2100,
		star_2_exp = 3600,
		star_3_exp = 11500,
		star_4_exp = 16400,
		star_5_exp = 29000,
		star_6_exp = 34800
};

get(71) ->
	#internal_skill_upg_cost_cfg{
		lv = 71,
		star_1_exp = 2130,
		star_2_exp = 3650,
		star_3_exp = 11650,
		star_4_exp = 16833,
		star_5_exp = 29755,
		star_6_exp = 35706
};

get(72) ->
	#internal_skill_upg_cost_cfg{
		lv = 72,
		star_1_exp = 2160,
		star_2_exp = 3700,
		star_3_exp = 11800,
		star_4_exp = 17272,
		star_5_exp = 30520,
		star_6_exp = 36624
};

get(73) ->
	#internal_skill_upg_cost_cfg{
		lv = 73,
		star_1_exp = 2190,
		star_2_exp = 3750,
		star_3_exp = 11950,
		star_4_exp = 17717,
		star_5_exp = 31295,
		star_6_exp = 37554
};

get(74) ->
	#internal_skill_upg_cost_cfg{
		lv = 74,
		star_1_exp = 2220,
		star_2_exp = 3800,
		star_3_exp = 12100,
		star_4_exp = 18168,
		star_5_exp = 32080,
		star_6_exp = 38496
};

get(75) ->
	#internal_skill_upg_cost_cfg{
		lv = 75,
		star_1_exp = 2250,
		star_2_exp = 3850,
		star_3_exp = 12250,
		star_4_exp = 18625,
		star_5_exp = 32875,
		star_6_exp = 39450
};

get(76) ->
	#internal_skill_upg_cost_cfg{
		lv = 76,
		star_1_exp = 2280,
		star_2_exp = 3900,
		star_3_exp = 12400,
		star_4_exp = 19088,
		star_5_exp = 33680,
		star_6_exp = 40416
};

get(77) ->
	#internal_skill_upg_cost_cfg{
		lv = 77,
		star_1_exp = 2310,
		star_2_exp = 3950,
		star_3_exp = 12550,
		star_4_exp = 19557,
		star_5_exp = 34495,
		star_6_exp = 41394
};

get(78) ->
	#internal_skill_upg_cost_cfg{
		lv = 78,
		star_1_exp = 2340,
		star_2_exp = 4000,
		star_3_exp = 12700,
		star_4_exp = 20032,
		star_5_exp = 35320,
		star_6_exp = 42384
};

get(79) ->
	#internal_skill_upg_cost_cfg{
		lv = 79,
		star_1_exp = 2370,
		star_2_exp = 4050,
		star_3_exp = 12850,
		star_4_exp = 20513,
		star_5_exp = 36155,
		star_6_exp = 43386
};

get(80) ->
	#internal_skill_upg_cost_cfg{
		lv = 80,
		star_1_exp = 2400,
		star_2_exp = 4100,
		star_3_exp = 13000,
		star_4_exp = 21000,
		star_5_exp = 37000,
		star_6_exp = 44400
};

get(81) ->
	#internal_skill_upg_cost_cfg{
		lv = 81,
		star_1_exp = 2430,
		star_2_exp = 4150,
		star_3_exp = 13150,
		star_4_exp = 21493,
		star_5_exp = 37855,
		star_6_exp = 45426
};

get(82) ->
	#internal_skill_upg_cost_cfg{
		lv = 82,
		star_1_exp = 2460,
		star_2_exp = 4200,
		star_3_exp = 13300,
		star_4_exp = 21992,
		star_5_exp = 38720,
		star_6_exp = 46464
};

get(83) ->
	#internal_skill_upg_cost_cfg{
		lv = 83,
		star_1_exp = 2490,
		star_2_exp = 4250,
		star_3_exp = 13450,
		star_4_exp = 22497,
		star_5_exp = 39595,
		star_6_exp = 47514
};

get(84) ->
	#internal_skill_upg_cost_cfg{
		lv = 84,
		star_1_exp = 2520,
		star_2_exp = 4300,
		star_3_exp = 13600,
		star_4_exp = 23008,
		star_5_exp = 40480,
		star_6_exp = 48576
};

get(85) ->
	#internal_skill_upg_cost_cfg{
		lv = 85,
		star_1_exp = 2550,
		star_2_exp = 4350,
		star_3_exp = 13750,
		star_4_exp = 23525,
		star_5_exp = 41375,
		star_6_exp = 49650
};

get(86) ->
	#internal_skill_upg_cost_cfg{
		lv = 86,
		star_1_exp = 2580,
		star_2_exp = 4400,
		star_3_exp = 13900,
		star_4_exp = 24048,
		star_5_exp = 42280,
		star_6_exp = 50736
};

get(87) ->
	#internal_skill_upg_cost_cfg{
		lv = 87,
		star_1_exp = 2610,
		star_2_exp = 4450,
		star_3_exp = 14050,
		star_4_exp = 24577,
		star_5_exp = 43195,
		star_6_exp = 51834
};

get(88) ->
	#internal_skill_upg_cost_cfg{
		lv = 88,
		star_1_exp = 2640,
		star_2_exp = 4500,
		star_3_exp = 14200,
		star_4_exp = 25112,
		star_5_exp = 44120,
		star_6_exp = 52944
};

get(89) ->
	#internal_skill_upg_cost_cfg{
		lv = 89,
		star_1_exp = 2670,
		star_2_exp = 4550,
		star_3_exp = 14350,
		star_4_exp = 25653,
		star_5_exp = 45055,
		star_6_exp = 54066
};

get(90) ->
	#internal_skill_upg_cost_cfg{
		lv = 90,
		star_1_exp = 2700,
		star_2_exp = 4600,
		star_3_exp = 14500,
		star_4_exp = 26200,
		star_5_exp = 46000,
		star_6_exp = 55200
};

get(91) ->
	#internal_skill_upg_cost_cfg{
		lv = 91,
		star_1_exp = 2730,
		star_2_exp = 4650,
		star_3_exp = 14650,
		star_4_exp = 26753,
		star_5_exp = 46955,
		star_6_exp = 56346
};

get(92) ->
	#internal_skill_upg_cost_cfg{
		lv = 92,
		star_1_exp = 2760,
		star_2_exp = 4700,
		star_3_exp = 14800,
		star_4_exp = 27312,
		star_5_exp = 47920,
		star_6_exp = 57504
};

get(93) ->
	#internal_skill_upg_cost_cfg{
		lv = 93,
		star_1_exp = 2790,
		star_2_exp = 4750,
		star_3_exp = 14950,
		star_4_exp = 27877,
		star_5_exp = 48895,
		star_6_exp = 58674
};

get(94) ->
	#internal_skill_upg_cost_cfg{
		lv = 94,
		star_1_exp = 2820,
		star_2_exp = 4800,
		star_3_exp = 15100,
		star_4_exp = 28448,
		star_5_exp = 49880,
		star_6_exp = 59856
};

get(95) ->
	#internal_skill_upg_cost_cfg{
		lv = 95,
		star_1_exp = 2850,
		star_2_exp = 4850,
		star_3_exp = 15250,
		star_4_exp = 29025,
		star_5_exp = 50875,
		star_6_exp = 61050
};

get(96) ->
	#internal_skill_upg_cost_cfg{
		lv = 96,
		star_1_exp = 2880,
		star_2_exp = 4900,
		star_3_exp = 15400,
		star_4_exp = 29608,
		star_5_exp = 51880,
		star_6_exp = 62256
};

get(97) ->
	#internal_skill_upg_cost_cfg{
		lv = 97,
		star_1_exp = 2910,
		star_2_exp = 4950,
		star_3_exp = 15550,
		star_4_exp = 30197,
		star_5_exp = 52895,
		star_6_exp = 63474
};

get(98) ->
	#internal_skill_upg_cost_cfg{
		lv = 98,
		star_1_exp = 2940,
		star_2_exp = 5000,
		star_3_exp = 15700,
		star_4_exp = 30792,
		star_5_exp = 53920,
		star_6_exp = 64704
};

get(99) ->
	#internal_skill_upg_cost_cfg{
		lv = 99,
		star_1_exp = 2970,
		star_2_exp = 5050,
		star_3_exp = 15850,
		star_4_exp = 31393,
		star_5_exp = 54955,
		star_6_exp = 65946
};

get(100) ->
	#internal_skill_upg_cost_cfg{
		lv = 100,
		star_1_exp = 3000,
		star_2_exp = 5100,
		star_3_exp = 16000,
		star_4_exp = 32000,
		star_5_exp = 56000,
		star_6_exp = 67200
};

get(_Lv) ->
	?ASSERT(false, _Lv),
    null.

