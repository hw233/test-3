%%%---------------------------------------
%%% @Module  : data_internal_skill_eat_exp
%%% @Author  : easy
%%% @Email   : 
%%% @Description: 内功吞噬经验表
%%%---------------------------------------


-module(data_internal_skill_eat_exp).
-export([
        get_lv/0,
        get/1
    ]).

-include("train.hrl").
-include("debug.hrl").

get_lv()->
	[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100].

get(1) ->
	#internal_skill_eat_exp_cfg{
		lv = 1,
		eat_1_star_exp = 3,
		eat_2_star_exp = 20,
		eat_3_star_exp = 280,
		eat_4_star_exp = 400,
		eat_5_star_exp = 800
};

get(2) ->
	#internal_skill_eat_exp_cfg{
		lv = 2,
		eat_1_star_exp = 6,
		eat_2_star_exp = 45,
		eat_3_star_exp = 575,
		eat_4_star_exp = 810.400000,
		eat_5_star_exp = 1055
};

get(3) ->
	#internal_skill_eat_exp_cfg{
		lv = 3,
		eat_1_star_exp = 18,
		eat_2_star_exp = 105,
		eat_3_star_exp = 1225,
		eat_4_star_exp = 1636,
		eat_5_star_exp = 2175
};

get(4) ->
	#internal_skill_eat_exp_cfg{
		lv = 4,
		eat_1_star_exp = 36,
		eat_2_star_exp = 180,
		eat_3_star_exp = 1950,
		eat_4_star_exp = 2481,
		eat_5_star_exp = 3370
};

get(5) ->
	#internal_skill_eat_exp_cfg{
		lv = 5,
		eat_1_star_exp = 60,
		eat_2_star_exp = 270,
		eat_3_star_exp = 2750,
		eat_4_star_exp = 3352,
		eat_5_star_exp = 4650
};

get(6) ->
	#internal_skill_eat_exp_cfg{
		lv = 6,
		eat_1_star_exp = 90,
		eat_2_star_exp = 375,
		eat_3_star_exp = 3625,
		eat_4_star_exp = 4252,
		eat_5_star_exp = 6025
};

get(7) ->
	#internal_skill_eat_exp_cfg{
		lv = 7,
		eat_1_star_exp = 126,
		eat_2_star_exp = 495,
		eat_3_star_exp = 4575,
		eat_4_star_exp = 5186,
		eat_5_star_exp = 7505
};

get(8) ->
	#internal_skill_eat_exp_cfg{
		lv = 8,
		eat_1_star_exp = 168,
		eat_2_star_exp = 630,
		eat_3_star_exp = 5600,
		eat_4_star_exp = 6160,
		eat_5_star_exp = 9100
};

get(9) ->
	#internal_skill_eat_exp_cfg{
		lv = 9,
		eat_1_star_exp = 216,
		eat_2_star_exp = 780,
		eat_3_star_exp = 6700,
		eat_4_star_exp = 7177,
		eat_5_star_exp = 10820
};

get(10) ->
	#internal_skill_eat_exp_cfg{
		lv = 10,
		eat_1_star_exp = 270,
		eat_2_star_exp = 945,
		eat_3_star_exp = 7875,
		eat_4_star_exp = 8244,
		eat_5_star_exp = 12675
};

get(11) ->
	#internal_skill_eat_exp_cfg{
		lv = 11,
		eat_1_star_exp = 330,
		eat_2_star_exp = 1125,
		eat_3_star_exp = 9125,
		eat_4_star_exp = 9364,
		eat_5_star_exp = 14675
};

get(12) ->
	#internal_skill_eat_exp_cfg{
		lv = 12,
		eat_1_star_exp = 396,
		eat_2_star_exp = 1320,
		eat_3_star_exp = 10450,
		eat_4_star_exp = 10542,
		eat_5_star_exp = 16830
};

get(13) ->
	#internal_skill_eat_exp_cfg{
		lv = 13,
		eat_1_star_exp = 468,
		eat_2_star_exp = 1530,
		eat_3_star_exp = 11850,
		eat_4_star_exp = 11784,
		eat_5_star_exp = 19150
};

get(14) ->
	#internal_skill_eat_exp_cfg{
		lv = 14,
		eat_1_star_exp = 546,
		eat_2_star_exp = 1755,
		eat_3_star_exp = 13325,
		eat_4_star_exp = 13093,
		eat_5_star_exp = 21645
};

get(15) ->
	#internal_skill_eat_exp_cfg{
		lv = 15,
		eat_1_star_exp = 630,
		eat_2_star_exp = 1995,
		eat_3_star_exp = 14875,
		eat_4_star_exp = 14476,
		eat_5_star_exp = 24325
};

get(16) ->
	#internal_skill_eat_exp_cfg{
		lv = 16,
		eat_1_star_exp = 720,
		eat_2_star_exp = 2250,
		eat_3_star_exp = 16500,
		eat_4_star_exp = 15936,
		eat_5_star_exp = 27200
};

get(17) ->
	#internal_skill_eat_exp_cfg{
		lv = 17,
		eat_1_star_exp = 816,
		eat_2_star_exp = 2520,
		eat_3_star_exp = 18200,
		eat_4_star_exp = 17478,
		eat_5_star_exp = 30280
};

get(18) ->
	#internal_skill_eat_exp_cfg{
		lv = 18,
		eat_1_star_exp = 918,
		eat_2_star_exp = 2805,
		eat_3_star_exp = 19975,
		eat_4_star_exp = 19108,
		eat_5_star_exp = 33575
};

get(19) ->
	#internal_skill_eat_exp_cfg{
		lv = 19,
		eat_1_star_exp = 1026,
		eat_2_star_exp = 3105,
		eat_3_star_exp = 21825,
		eat_4_star_exp = 20829,
		eat_5_star_exp = 37095
};

get(20) ->
	#internal_skill_eat_exp_cfg{
		lv = 20,
		eat_1_star_exp = 1140,
		eat_2_star_exp = 3420,
		eat_3_star_exp = 23750,
		eat_4_star_exp = 22648,
		eat_5_star_exp = 40850
};

get(21) ->
	#internal_skill_eat_exp_cfg{
		lv = 21,
		eat_1_star_exp = 1260,
		eat_2_star_exp = 3750,
		eat_3_star_exp = 25750,
		eat_4_star_exp = 24568,
		eat_5_star_exp = 44850
};

get(22) ->
	#internal_skill_eat_exp_cfg{
		lv = 22,
		eat_1_star_exp = 1386,
		eat_2_star_exp = 4095,
		eat_3_star_exp = 27825,
		eat_4_star_exp = 26594,
		eat_5_star_exp = 49105
};

get(23) ->
	#internal_skill_eat_exp_cfg{
		lv = 23,
		eat_1_star_exp = 1518,
		eat_2_star_exp = 4455,
		eat_3_star_exp = 29975,
		eat_4_star_exp = 28732,
		eat_5_star_exp = 53625
};

get(24) ->
	#internal_skill_eat_exp_cfg{
		lv = 24,
		eat_1_star_exp = 1656,
		eat_2_star_exp = 4830,
		eat_3_star_exp = 32200,
		eat_4_star_exp = 30985,
		eat_5_star_exp = 58420
};

get(25) ->
	#internal_skill_eat_exp_cfg{
		lv = 25,
		eat_1_star_exp = 1800,
		eat_2_star_exp = 5220,
		eat_3_star_exp = 34500,
		eat_4_star_exp = 33360,
		eat_5_star_exp = 63500
};

get(26) ->
	#internal_skill_eat_exp_cfg{
		lv = 26,
		eat_1_star_exp = 1950,
		eat_2_star_exp = 5625,
		eat_3_star_exp = 36875,
		eat_4_star_exp = 35860,
		eat_5_star_exp = 68875
};

get(27) ->
	#internal_skill_eat_exp_cfg{
		lv = 27,
		eat_1_star_exp = 2106,
		eat_2_star_exp = 6045,
		eat_3_star_exp = 39325,
		eat_4_star_exp = 38490,
		eat_5_star_exp = 74555
};

get(28) ->
	#internal_skill_eat_exp_cfg{
		lv = 28,
		eat_1_star_exp = 2268,
		eat_2_star_exp = 6480,
		eat_3_star_exp = 41850,
		eat_4_star_exp = 41256,
		eat_5_star_exp = 80550
};

get(29) ->
	#internal_skill_eat_exp_cfg{
		lv = 29,
		eat_1_star_exp = 2436,
		eat_2_star_exp = 6930,
		eat_3_star_exp = 44450,
		eat_4_star_exp = 44161,
		eat_5_star_exp = 86870
};

get(30) ->
	#internal_skill_eat_exp_cfg{
		lv = 30,
		eat_1_star_exp = 2610,
		eat_2_star_exp = 7395,
		eat_3_star_exp = 47125,
		eat_4_star_exp = 47212,
		eat_5_star_exp = 93525
};

get(31) ->
	#internal_skill_eat_exp_cfg{
		lv = 31,
		eat_1_star_exp = 2790,
		eat_2_star_exp = 7875,
		eat_3_star_exp = 49875,
		eat_4_star_exp = 50412,
		eat_5_star_exp = 100525
};

get(32) ->
	#internal_skill_eat_exp_cfg{
		lv = 32,
		eat_1_star_exp = 2976,
		eat_2_star_exp = 8370,
		eat_3_star_exp = 52700,
		eat_4_star_exp = 53766,
		eat_5_star_exp = 107880
};

get(33) ->
	#internal_skill_eat_exp_cfg{
		lv = 33,
		eat_1_star_exp = 3168,
		eat_2_star_exp = 8880,
		eat_3_star_exp = 55600,
		eat_4_star_exp = 57280,
		eat_5_star_exp = 115600
};

get(34) ->
	#internal_skill_eat_exp_cfg{
		lv = 34,
		eat_1_star_exp = 3366,
		eat_2_star_exp = 9405,
		eat_3_star_exp = 58575,
		eat_4_star_exp = 60957,
		eat_5_star_exp = 123695
};

get(35) ->
	#internal_skill_eat_exp_cfg{
		lv = 35,
		eat_1_star_exp = 3570,
		eat_2_star_exp = 9945,
		eat_3_star_exp = 61625,
		eat_4_star_exp = 64804,
		eat_5_star_exp = 132175
};

get(36) ->
	#internal_skill_eat_exp_cfg{
		lv = 36,
		eat_1_star_exp = 3780,
		eat_2_star_exp = 10500,
		eat_3_star_exp = 64750,
		eat_4_star_exp = 68824,
		eat_5_star_exp = 141050
};

get(37) ->
	#internal_skill_eat_exp_cfg{
		lv = 37,
		eat_1_star_exp = 3996,
		eat_2_star_exp = 11070,
		eat_3_star_exp = 67950,
		eat_4_star_exp = 73022,
		eat_5_star_exp = 150330
};

get(38) ->
	#internal_skill_eat_exp_cfg{
		lv = 38,
		eat_1_star_exp = 4218,
		eat_2_star_exp = 11655,
		eat_3_star_exp = 71225,
		eat_4_star_exp = 77404,
		eat_5_star_exp = 160025
};

get(39) ->
	#internal_skill_eat_exp_cfg{
		lv = 39,
		eat_1_star_exp = 4446,
		eat_2_star_exp = 12255,
		eat_3_star_exp = 74575,
		eat_4_star_exp = 81973,
		eat_5_star_exp = 170145
};

get(40) ->
	#internal_skill_eat_exp_cfg{
		lv = 40,
		eat_1_star_exp = 4680,
		eat_2_star_exp = 12870,
		eat_3_star_exp = 78000,
		eat_4_star_exp = 86736,
		eat_5_star_exp = 180700
};

get(41) ->
	#internal_skill_eat_exp_cfg{
		lv = 41,
		eat_1_star_exp = 4920,
		eat_2_star_exp = 13500,
		eat_3_star_exp = 81500,
		eat_4_star_exp = 91696,
		eat_5_star_exp = 191700
};

get(42) ->
	#internal_skill_eat_exp_cfg{
		lv = 42,
		eat_1_star_exp = 5166,
		eat_2_star_exp = 14145,
		eat_3_star_exp = 85075,
		eat_4_star_exp = 96858,
		eat_5_star_exp = 203155
};

get(43) ->
	#internal_skill_eat_exp_cfg{
		lv = 43,
		eat_1_star_exp = 5418,
		eat_2_star_exp = 14805,
		eat_3_star_exp = 88725,
		eat_4_star_exp = 102228,
		eat_5_star_exp = 215075
};

get(44) ->
	#internal_skill_eat_exp_cfg{
		lv = 44,
		eat_1_star_exp = 5676,
		eat_2_star_exp = 15480,
		eat_3_star_exp = 92450,
		eat_4_star_exp = 107809,
		eat_5_star_exp = 227470
};

get(45) ->
	#internal_skill_eat_exp_cfg{
		lv = 45,
		eat_1_star_exp = 5940,
		eat_2_star_exp = 16170,
		eat_3_star_exp = 96250,
		eat_4_star_exp = 113608,
		eat_5_star_exp = 240350
};

get(46) ->
	#internal_skill_eat_exp_cfg{
		lv = 46,
		eat_1_star_exp = 6210,
		eat_2_star_exp = 16875,
		eat_3_star_exp = 100125,
		eat_4_star_exp = 119628,
		eat_5_star_exp = 253725
};

get(47) ->
	#internal_skill_eat_exp_cfg{
		lv = 47,
		eat_1_star_exp = 6486,
		eat_2_star_exp = 17595,
		eat_3_star_exp = 104075,
		eat_4_star_exp = 125874,
		eat_5_star_exp = 267605
};

get(48) ->
	#internal_skill_eat_exp_cfg{
		lv = 48,
		eat_1_star_exp = 6768,
		eat_2_star_exp = 18330,
		eat_3_star_exp = 108100,
		eat_4_star_exp = 132352,
		eat_5_star_exp = 282000
};

get(49) ->
	#internal_skill_eat_exp_cfg{
		lv = 49,
		eat_1_star_exp = 7056,
		eat_2_star_exp = 19080,
		eat_3_star_exp = 112200,
		eat_4_star_exp = 139065,
		eat_5_star_exp = 296920
};

get(50) ->
	#internal_skill_eat_exp_cfg{
		lv = 50,
		eat_1_star_exp = 7350,
		eat_2_star_exp = 19845,
		eat_3_star_exp = 116375,
		eat_4_star_exp = 146020,
		eat_5_star_exp = 312375
};

get(51) ->
	#internal_skill_eat_exp_cfg{
		lv = 51,
		eat_1_star_exp = 7650,
		eat_2_star_exp = 20625,
		eat_3_star_exp = 120625,
		eat_4_star_exp = 153220,
		eat_5_star_exp = 328375
};

get(52) ->
	#internal_skill_eat_exp_cfg{
		lv = 52,
		eat_1_star_exp = 7956,
		eat_2_star_exp = 21420,
		eat_3_star_exp = 124950,
		eat_4_star_exp = 160670,
		eat_5_star_exp = 344930
};

get(53) ->
	#internal_skill_eat_exp_cfg{
		lv = 53,
		eat_1_star_exp = 8268,
		eat_2_star_exp = 22230,
		eat_3_star_exp = 129350,
		eat_4_star_exp = 168376,
		eat_5_star_exp = 362050
};

get(54) ->
	#internal_skill_eat_exp_cfg{
		lv = 54,
		eat_1_star_exp = 8586,
		eat_2_star_exp = 23055,
		eat_3_star_exp = 133825,
		eat_4_star_exp = 176341,
		eat_5_star_exp = 379745
};

get(55) ->
	#internal_skill_eat_exp_cfg{
		lv = 55,
		eat_1_star_exp = 8910,
		eat_2_star_exp = 23895,
		eat_3_star_exp = 138375,
		eat_4_star_exp = 184572,
		eat_5_star_exp = 398025
};

get(56) ->
	#internal_skill_eat_exp_cfg{
		lv = 56,
		eat_1_star_exp = 9240,
		eat_2_star_exp = 24750,
		eat_3_star_exp = 143000,
		eat_4_star_exp = 193072,
		eat_5_star_exp = 416900
};

get(57) ->
	#internal_skill_eat_exp_cfg{
		lv = 57,
		eat_1_star_exp = 9576,
		eat_2_star_exp = 25620,
		eat_3_star_exp = 147700,
		eat_4_star_exp = 201846,
		eat_5_star_exp = 436380
};

get(58) ->
	#internal_skill_eat_exp_cfg{
		lv = 58,
		eat_1_star_exp = 9918,
		eat_2_star_exp = 26505,
		eat_3_star_exp = 152475,
		eat_4_star_exp = 210900,
		eat_5_star_exp = 456475
};

get(59) ->
	#internal_skill_eat_exp_cfg{
		lv = 59,
		eat_1_star_exp = 10266,
		eat_2_star_exp = 27405,
		eat_3_star_exp = 157325,
		eat_4_star_exp = 220237,
		eat_5_star_exp = 477195
};

get(60) ->
	#internal_skill_eat_exp_cfg{
		lv = 60,
		eat_1_star_exp = 10620,
		eat_2_star_exp = 28320,
		eat_3_star_exp = 162250,
		eat_4_star_exp = 229864,
		eat_5_star_exp = 498550
};

get(61) ->
	#internal_skill_eat_exp_cfg{
		lv = 61,
		eat_1_star_exp = 10980,
		eat_2_star_exp = 29250,
		eat_3_star_exp = 167250,
		eat_4_star_exp = 239784,
		eat_5_star_exp = 520550
};

get(62) ->
	#internal_skill_eat_exp_cfg{
		lv = 62,
		eat_1_star_exp = 11346,
		eat_2_star_exp = 30195,
		eat_3_star_exp = 172325,
		eat_4_star_exp = 250002,
		eat_5_star_exp = 543205
};

get(63) ->
	#internal_skill_eat_exp_cfg{
		lv = 63,
		eat_1_star_exp = 11718,
		eat_2_star_exp = 31155,
		eat_3_star_exp = 177475,
		eat_4_star_exp = 260524,
		eat_5_star_exp = 566525
};

get(64) ->
	#internal_skill_eat_exp_cfg{
		lv = 64,
		eat_1_star_exp = 12096,
		eat_2_star_exp = 32130,
		eat_3_star_exp = 182700,
		eat_4_star_exp = 271353,
		eat_5_star_exp = 590520
};

get(65) ->
	#internal_skill_eat_exp_cfg{
		lv = 65,
		eat_1_star_exp = 12480,
		eat_2_star_exp = 33120,
		eat_3_star_exp = 188000,
		eat_4_star_exp = 282496,
		eat_5_star_exp = 615200
};

get(66) ->
	#internal_skill_eat_exp_cfg{
		lv = 66,
		eat_1_star_exp = 12870,
		eat_2_star_exp = 34125,
		eat_3_star_exp = 193375,
		eat_4_star_exp = 293956,
		eat_5_star_exp = 640575
};

get(67) ->
	#internal_skill_eat_exp_cfg{
		lv = 67,
		eat_1_star_exp = 13266,
		eat_2_star_exp = 35145,
		eat_3_star_exp = 198825,
		eat_4_star_exp = 305738,
		eat_5_star_exp = 666655
};

get(68) ->
	#internal_skill_eat_exp_cfg{
		lv = 68,
		eat_1_star_exp = 13668,
		eat_2_star_exp = 36180,
		eat_3_star_exp = 204350,
		eat_4_star_exp = 317848,
		eat_5_star_exp = 693450
};

get(69) ->
	#internal_skill_eat_exp_cfg{
		lv = 69,
		eat_1_star_exp = 14076,
		eat_2_star_exp = 37230,
		eat_3_star_exp = 209950,
		eat_4_star_exp = 330289,
		eat_5_star_exp = 720970
};

get(70) ->
	#internal_skill_eat_exp_cfg{
		lv = 70,
		eat_1_star_exp = 14490,
		eat_2_star_exp = 38295,
		eat_3_star_exp = 215625,
		eat_4_star_exp = 343068,
		eat_5_star_exp = 749225
};

get(71) ->
	#internal_skill_eat_exp_cfg{
		lv = 71,
		eat_1_star_exp = 14910,
		eat_2_star_exp = 39375,
		eat_3_star_exp = 221375,
		eat_4_star_exp = 356188,
		eat_5_star_exp = 778225
};

get(72) ->
	#internal_skill_eat_exp_cfg{
		lv = 72,
		eat_1_star_exp = 15336,
		eat_2_star_exp = 40470,
		eat_3_star_exp = 227200,
		eat_4_star_exp = 369654,
		eat_5_star_exp = 807980
};

get(73) ->
	#internal_skill_eat_exp_cfg{
		lv = 73,
		eat_1_star_exp = 15768,
		eat_2_star_exp = 41580,
		eat_3_star_exp = 233100,
		eat_4_star_exp = 383472,
		eat_5_star_exp = 838500
};

get(74) ->
	#internal_skill_eat_exp_cfg{
		lv = 74,
		eat_1_star_exp = 16206,
		eat_2_star_exp = 42705,
		eat_3_star_exp = 239075,
		eat_4_star_exp = 397645,
		eat_5_star_exp = 869795
};

get(75) ->
	#internal_skill_eat_exp_cfg{
		lv = 75,
		eat_1_star_exp = 16650,
		eat_2_star_exp = 43845,
		eat_3_star_exp = 245125,
		eat_4_star_exp = 412180,
		eat_5_star_exp = 901875
};

get(76) ->
	#internal_skill_eat_exp_cfg{
		lv = 76,
		eat_1_star_exp = 17100,
		eat_2_star_exp = 45000,
		eat_3_star_exp = 251250,
		eat_4_star_exp = 427080,
		eat_5_star_exp = 934750
};

get(77) ->
	#internal_skill_eat_exp_cfg{
		lv = 77,
		eat_1_star_exp = 17556,
		eat_2_star_exp = 46170,
		eat_3_star_exp = 257450,
		eat_4_star_exp = 442350,
		eat_5_star_exp = 968430
};

get(78) ->
	#internal_skill_eat_exp_cfg{
		lv = 78,
		eat_1_star_exp = 18018,
		eat_2_star_exp = 47355,
		eat_3_star_exp = 263725,
		eat_4_star_exp = 457996,
		eat_5_star_exp = 1002925
};

get(79) ->
	#internal_skill_eat_exp_cfg{
		lv = 79,
		eat_1_star_exp = 18486,
		eat_2_star_exp = 48555,
		eat_3_star_exp = 270075,
		eat_4_star_exp = 474021,
		eat_5_star_exp = 1038245
};

get(80) ->
	#internal_skill_eat_exp_cfg{
		lv = 80,
		eat_1_star_exp = 18960,
		eat_2_star_exp = 49770,
		eat_3_star_exp = 276500,
		eat_4_star_exp = 490432,
		eat_5_star_exp = 1074400
};

get(81) ->
	#internal_skill_eat_exp_cfg{
		lv = 81,
		eat_1_star_exp = 19440,
		eat_2_star_exp = 51000,
		eat_3_star_exp = 283000,
		eat_4_star_exp = 507232,
		eat_5_star_exp = 1111400
};

get(82) ->
	#internal_skill_eat_exp_cfg{
		lv = 82,
		eat_1_star_exp = 19926,
		eat_2_star_exp = 52245,
		eat_3_star_exp = 289575,
		eat_4_star_exp = 524426,
		eat_5_star_exp = 1149255
};

get(83) ->
	#internal_skill_eat_exp_cfg{
		lv = 83,
		eat_1_star_exp = 20418,
		eat_2_star_exp = 53505,
		eat_3_star_exp = 296225,
		eat_4_star_exp = 542020,
		eat_5_star_exp = 1187975
};

get(84) ->
	#internal_skill_eat_exp_cfg{
		lv = 84,
		eat_1_star_exp = 20916,
		eat_2_star_exp = 54780,
		eat_3_star_exp = 302950,
		eat_4_star_exp = 560017,
		eat_5_star_exp = 1227570
};

get(85) ->
	#internal_skill_eat_exp_cfg{
		lv = 85,
		eat_1_star_exp = 21420,
		eat_2_star_exp = 56070,
		eat_3_star_exp = 309750,
		eat_4_star_exp = 578424,
		eat_5_star_exp = 1268050
};

get(86) ->
	#internal_skill_eat_exp_cfg{
		lv = 86,
		eat_1_star_exp = 21930,
		eat_2_star_exp = 57375,
		eat_3_star_exp = 316625,
		eat_4_star_exp = 597244,
		eat_5_star_exp = 1309425
};

get(87) ->
	#internal_skill_eat_exp_cfg{
		lv = 87,
		eat_1_star_exp = 22446,
		eat_2_star_exp = 58695,
		eat_3_star_exp = 323575,
		eat_4_star_exp = 616482,
		eat_5_star_exp = 1351705
};

get(88) ->
	#internal_skill_eat_exp_cfg{
		lv = 88,
		eat_1_star_exp = 22968,
		eat_2_star_exp = 60030,
		eat_3_star_exp = 330600,
		eat_4_star_exp = 636144,
		eat_5_star_exp = 1394900
};

get(89) ->
	#internal_skill_eat_exp_cfg{
		lv = 89,
		eat_1_star_exp = 23496,
		eat_2_star_exp = 61380,
		eat_3_star_exp = 337700,
		eat_4_star_exp = 656233,
		eat_5_star_exp = 1439020
};

get(90) ->
	#internal_skill_eat_exp_cfg{
		lv = 90,
		eat_1_star_exp = 24030,
		eat_2_star_exp = 62745,
		eat_3_star_exp = 344875,
		eat_4_star_exp = 676756,
		eat_5_star_exp = 1484075
};

get(91) ->
	#internal_skill_eat_exp_cfg{
		lv = 91,
		eat_1_star_exp = 24570,
		eat_2_star_exp = 64125,
		eat_3_star_exp = 352125,
		eat_4_star_exp = 697716,
		eat_5_star_exp = 1530075
};

get(92) ->
	#internal_skill_eat_exp_cfg{
		lv = 92,
		eat_1_star_exp = 25116,
		eat_2_star_exp = 65520,
		eat_3_star_exp = 359450,
		eat_4_star_exp = 719118,
		eat_5_star_exp = 1577030
};

get(93) ->
	#internal_skill_eat_exp_cfg{
		lv = 93,
		eat_1_star_exp = 25668,
		eat_2_star_exp = 66930,
		eat_3_star_exp = 366850,
		eat_4_star_exp = 740968,
		eat_5_star_exp = 1624950
};

get(94) ->
	#internal_skill_eat_exp_cfg{
		lv = 94,
		eat_1_star_exp = 26226,
		eat_2_star_exp = 68355,
		eat_3_star_exp = 374325,
		eat_4_star_exp = 763269,
		eat_5_star_exp = 1673845
};

get(95) ->
	#internal_skill_eat_exp_cfg{
		lv = 95,
		eat_1_star_exp = 26790,
		eat_2_star_exp = 69795,
		eat_3_star_exp = 381875,
		eat_4_star_exp = 786028,
		eat_5_star_exp = 1723725
};

get(96) ->
	#internal_skill_eat_exp_cfg{
		lv = 96,
		eat_1_star_exp = 27360,
		eat_2_star_exp = 71250,
		eat_3_star_exp = 389500,
		eat_4_star_exp = 809248,
		eat_5_star_exp = 1774600
};

get(97) ->
	#internal_skill_eat_exp_cfg{
		lv = 97,
		eat_1_star_exp = 27936,
		eat_2_star_exp = 72720,
		eat_3_star_exp = 397200,
		eat_4_star_exp = 832934,
		eat_5_star_exp = 1826480
};

get(98) ->
	#internal_skill_eat_exp_cfg{
		lv = 98,
		eat_1_star_exp = 28518,
		eat_2_star_exp = 74205,
		eat_3_star_exp = 404975,
		eat_4_star_exp = 857092,
		eat_5_star_exp = 1879375
};

get(99) ->
	#internal_skill_eat_exp_cfg{
		lv = 99,
		eat_1_star_exp = 29106,
		eat_2_star_exp = 75705,
		eat_3_star_exp = 412825,
		eat_4_star_exp = 881725,
		eat_5_star_exp = 1933295
};

get(100) ->
	#internal_skill_eat_exp_cfg{
		lv = 100,
		eat_1_star_exp = 29700,
		eat_2_star_exp = 77220,
		eat_3_star_exp = 420750,
		eat_4_star_exp = 906840,
		eat_5_star_exp = 1988250
};

get(_Lv) ->
	?ASSERT(false, _Lv),
    null.

