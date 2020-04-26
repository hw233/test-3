%%%---------------------------------------
%%% @Module  : data_equip_strenthen
%%% @Author  : zwq
%%% @Email   : 
%%% @Description:  装备强化
%%%---------------------------------------


-module(data_equip_strenthen).
-include("common.hrl").
-include("record.hrl").
-include("record/goods_record.hrl").
-compile(export_all).

get_all_lv_step_list()->
	[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100].

get(1) ->
	#equip_strenthen{
		stren_lv = 1,
		need_eq_lv = 10,
		strengthen_stone = 70011,
		strengthen_stone_count = 1,
		base_attr_add = 30
};

get(2) ->
	#equip_strenthen{
		stren_lv = 2,
		need_eq_lv = 10,
		strengthen_stone = 70011,
		strengthen_stone_count = 1,
		base_attr_add = 60
};

get(3) ->
	#equip_strenthen{
		stren_lv = 3,
		need_eq_lv = 10,
		strengthen_stone = 70011,
		strengthen_stone_count = 2,
		base_attr_add = 90
};

get(4) ->
	#equip_strenthen{
		stren_lv = 4,
		need_eq_lv = 10,
		strengthen_stone = 70011,
		strengthen_stone_count = 2,
		base_attr_add = 120
};

get(5) ->
	#equip_strenthen{
		stren_lv = 5,
		need_eq_lv = 10,
		strengthen_stone = 70011,
		strengthen_stone_count = 3,
		base_attr_add = 150
};

get(6) ->
	#equip_strenthen{
		stren_lv = 6,
		need_eq_lv = 40,
		strengthen_stone = 70011,
		strengthen_stone_count = 3,
		base_attr_add = 180
};

get(7) ->
	#equip_strenthen{
		stren_lv = 7,
		need_eq_lv = 40,
		strengthen_stone = 70011,
		strengthen_stone_count = 4,
		base_attr_add = 210
};

get(8) ->
	#equip_strenthen{
		stren_lv = 8,
		need_eq_lv = 40,
		strengthen_stone = 70011,
		strengthen_stone_count = 4,
		base_attr_add = 240
};

get(9) ->
	#equip_strenthen{
		stren_lv = 9,
		need_eq_lv = 40,
		strengthen_stone = 70011,
		strengthen_stone_count = 5,
		base_attr_add = 270
};

get(10) ->
	#equip_strenthen{
		stren_lv = 10,
		need_eq_lv = 40,
		strengthen_stone = 70011,
		strengthen_stone_count = 5,
		base_attr_add = 300
};

get(11) ->
	#equip_strenthen{
		stren_lv = 11,
		need_eq_lv = 60,
		strengthen_stone = 70011,
		strengthen_stone_count = 6,
		base_attr_add = 330
};

get(12) ->
	#equip_strenthen{
		stren_lv = 12,
		need_eq_lv = 60,
		strengthen_stone = 70011,
		strengthen_stone_count = 6,
		base_attr_add = 360
};

get(13) ->
	#equip_strenthen{
		stren_lv = 13,
		need_eq_lv = 60,
		strengthen_stone = 70011,
		strengthen_stone_count = 7,
		base_attr_add = 390
};

get(14) ->
	#equip_strenthen{
		stren_lv = 14,
		need_eq_lv = 60,
		strengthen_stone = 70011,
		strengthen_stone_count = 8,
		base_attr_add = 420
};

get(15) ->
	#equip_strenthen{
		stren_lv = 15,
		need_eq_lv = 60,
		strengthen_stone = 70011,
		strengthen_stone_count = 10,
		base_attr_add = 450
};

get(16) ->
	#equip_strenthen{
		stren_lv = 16,
		need_eq_lv = 80,
		strengthen_stone = 70011,
		strengthen_stone_count = 12,
		base_attr_add = 480
};

get(17) ->
	#equip_strenthen{
		stren_lv = 17,
		need_eq_lv = 80,
		strengthen_stone = 70011,
		strengthen_stone_count = 14,
		base_attr_add = 510
};

get(18) ->
	#equip_strenthen{
		stren_lv = 18,
		need_eq_lv = 80,
		strengthen_stone = 70011,
		strengthen_stone_count = 16,
		base_attr_add = 540
};

get(19) ->
	#equip_strenthen{
		stren_lv = 19,
		need_eq_lv = 80,
		strengthen_stone = 70011,
		strengthen_stone_count = 18,
		base_attr_add = 570
};

get(20) ->
	#equip_strenthen{
		stren_lv = 20,
		need_eq_lv = 80,
		strengthen_stone = 70011,
		strengthen_stone_count = 20,
		base_attr_add = 600
};

get(21) ->
	#equip_strenthen{
		stren_lv = 21,
		need_eq_lv = 100,
		strengthen_stone = 70011,
		strengthen_stone_count = 22,
		base_attr_add = 630
};

get(22) ->
	#equip_strenthen{
		stren_lv = 22,
		need_eq_lv = 100,
		strengthen_stone = 70011,
		strengthen_stone_count = 24,
		base_attr_add = 660
};

get(23) ->
	#equip_strenthen{
		stren_lv = 23,
		need_eq_lv = 100,
		strengthen_stone = 70011,
		strengthen_stone_count = 26,
		base_attr_add = 690
};

get(24) ->
	#equip_strenthen{
		stren_lv = 24,
		need_eq_lv = 100,
		strengthen_stone = 70011,
		strengthen_stone_count = 28,
		base_attr_add = 720
};

get(25) ->
	#equip_strenthen{
		stren_lv = 25,
		need_eq_lv = 100,
		strengthen_stone = 70011,
		strengthen_stone_count = 30,
		base_attr_add = 750
};

get(26) ->
	#equip_strenthen{
		stren_lv = 26,
		need_eq_lv = 120,
		strengthen_stone = 70011,
		strengthen_stone_count = 32,
		base_attr_add = 780
};

get(27) ->
	#equip_strenthen{
		stren_lv = 27,
		need_eq_lv = 120,
		strengthen_stone = 70011,
		strengthen_stone_count = 34,
		base_attr_add = 810
};

get(28) ->
	#equip_strenthen{
		stren_lv = 28,
		need_eq_lv = 120,
		strengthen_stone = 70011,
		strengthen_stone_count = 36,
		base_attr_add = 840
};

get(29) ->
	#equip_strenthen{
		stren_lv = 29,
		need_eq_lv = 120,
		strengthen_stone = 70011,
		strengthen_stone_count = 38,
		base_attr_add = 870
};

get(30) ->
	#equip_strenthen{
		stren_lv = 30,
		need_eq_lv = 120,
		strengthen_stone = 70011,
		strengthen_stone_count = 40,
		base_attr_add = 900
};

get(31) ->
	#equip_strenthen{
		stren_lv = 31,
		need_eq_lv = 140,
		strengthen_stone = 70011,
		strengthen_stone_count = 42,
		base_attr_add = 930
};

get(32) ->
	#equip_strenthen{
		stren_lv = 32,
		need_eq_lv = 140,
		strengthen_stone = 70011,
		strengthen_stone_count = 44,
		base_attr_add = 960
};

get(33) ->
	#equip_strenthen{
		stren_lv = 33,
		need_eq_lv = 140,
		strengthen_stone = 70011,
		strengthen_stone_count = 46,
		base_attr_add = 990
};

get(34) ->
	#equip_strenthen{
		stren_lv = 34,
		need_eq_lv = 140,
		strengthen_stone = 70011,
		strengthen_stone_count = 48,
		base_attr_add = 1020
};

get(35) ->
	#equip_strenthen{
		stren_lv = 35,
		need_eq_lv = 140,
		strengthen_stone = 70011,
		strengthen_stone_count = 50,
		base_attr_add = 1050
};

get(36) ->
	#equip_strenthen{
		stren_lv = 36,
		need_eq_lv = 160,
		strengthen_stone = 70011,
		strengthen_stone_count = 52,
		base_attr_add = 1080
};

get(37) ->
	#equip_strenthen{
		stren_lv = 37,
		need_eq_lv = 160,
		strengthen_stone = 70011,
		strengthen_stone_count = 54,
		base_attr_add = 1110
};

get(38) ->
	#equip_strenthen{
		stren_lv = 38,
		need_eq_lv = 160,
		strengthen_stone = 70011,
		strengthen_stone_count = 56,
		base_attr_add = 1140
};

get(39) ->
	#equip_strenthen{
		stren_lv = 39,
		need_eq_lv = 160,
		strengthen_stone = 70011,
		strengthen_stone_count = 58,
		base_attr_add = 1170
};

get(40) ->
	#equip_strenthen{
		stren_lv = 40,
		need_eq_lv = 160,
		strengthen_stone = 70011,
		strengthen_stone_count = 60,
		base_attr_add = 1200
};

get(41) ->
	#equip_strenthen{
		stren_lv = 41,
		need_eq_lv = 180,
		strengthen_stone = 70011,
		strengthen_stone_count = 62,
		base_attr_add = 1230
};

get(42) ->
	#equip_strenthen{
		stren_lv = 42,
		need_eq_lv = 180,
		strengthen_stone = 70011,
		strengthen_stone_count = 64,
		base_attr_add = 1260
};

get(43) ->
	#equip_strenthen{
		stren_lv = 43,
		need_eq_lv = 180,
		strengthen_stone = 70011,
		strengthen_stone_count = 66,
		base_attr_add = 1290
};

get(44) ->
	#equip_strenthen{
		stren_lv = 44,
		need_eq_lv = 180,
		strengthen_stone = 70011,
		strengthen_stone_count = 68,
		base_attr_add = 1320
};

get(45) ->
	#equip_strenthen{
		stren_lv = 45,
		need_eq_lv = 180,
		strengthen_stone = 70011,
		strengthen_stone_count = 70,
		base_attr_add = 1350
};

get(46) ->
	#equip_strenthen{
		stren_lv = 46,
		need_eq_lv = 200,
		strengthen_stone = 70011,
		strengthen_stone_count = 72,
		base_attr_add = 1380
};

get(47) ->
	#equip_strenthen{
		stren_lv = 47,
		need_eq_lv = 200,
		strengthen_stone = 70011,
		strengthen_stone_count = 74,
		base_attr_add = 1410
};

get(48) ->
	#equip_strenthen{
		stren_lv = 48,
		need_eq_lv = 200,
		strengthen_stone = 70011,
		strengthen_stone_count = 76,
		base_attr_add = 1440
};

get(49) ->
	#equip_strenthen{
		stren_lv = 49,
		need_eq_lv = 200,
		strengthen_stone = 70011,
		strengthen_stone_count = 78,
		base_attr_add = 1470
};

get(50) ->
	#equip_strenthen{
		stren_lv = 50,
		need_eq_lv = 200,
		strengthen_stone = 70011,
		strengthen_stone_count = 80,
		base_attr_add = 1500
};

get(51) ->
	#equip_strenthen{
		stren_lv = 51,
		need_eq_lv = 220,
		strengthen_stone = 70011,
		strengthen_stone_count = 82,
		base_attr_add = 1530
};

get(52) ->
	#equip_strenthen{
		stren_lv = 52,
		need_eq_lv = 220,
		strengthen_stone = 70011,
		strengthen_stone_count = 84,
		base_attr_add = 1560
};

get(53) ->
	#equip_strenthen{
		stren_lv = 53,
		need_eq_lv = 220,
		strengthen_stone = 70011,
		strengthen_stone_count = 86,
		base_attr_add = 1590
};

get(54) ->
	#equip_strenthen{
		stren_lv = 54,
		need_eq_lv = 220,
		strengthen_stone = 70011,
		strengthen_stone_count = 88,
		base_attr_add = 1620
};

get(55) ->
	#equip_strenthen{
		stren_lv = 55,
		need_eq_lv = 220,
		strengthen_stone = 70011,
		strengthen_stone_count = 90,
		base_attr_add = 1650
};

get(56) ->
	#equip_strenthen{
		stren_lv = 56,
		need_eq_lv = 240,
		strengthen_stone = 70011,
		strengthen_stone_count = 92,
		base_attr_add = 1680
};

get(57) ->
	#equip_strenthen{
		stren_lv = 57,
		need_eq_lv = 240,
		strengthen_stone = 70011,
		strengthen_stone_count = 94,
		base_attr_add = 1710
};

get(58) ->
	#equip_strenthen{
		stren_lv = 58,
		need_eq_lv = 240,
		strengthen_stone = 70011,
		strengthen_stone_count = 97,
		base_attr_add = 1740
};

get(59) ->
	#equip_strenthen{
		stren_lv = 59,
		need_eq_lv = 240,
		strengthen_stone = 70011,
		strengthen_stone_count = 100,
		base_attr_add = 1770
};

get(60) ->
	#equip_strenthen{
		stren_lv = 60,
		need_eq_lv = 240,
		strengthen_stone = 70011,
		strengthen_stone_count = 105,
		base_attr_add = 1800
};

get(61) ->
	#equip_strenthen{
		stren_lv = 61,
		need_eq_lv = 260,
		strengthen_stone = 70011,
		strengthen_stone_count = 110,
		base_attr_add = 1830
};

get(62) ->
	#equip_strenthen{
		stren_lv = 62,
		need_eq_lv = 260,
		strengthen_stone = 70011,
		strengthen_stone_count = 115,
		base_attr_add = 1860
};

get(63) ->
	#equip_strenthen{
		stren_lv = 63,
		need_eq_lv = 260,
		strengthen_stone = 70011,
		strengthen_stone_count = 120,
		base_attr_add = 1890
};

get(64) ->
	#equip_strenthen{
		stren_lv = 64,
		need_eq_lv = 260,
		strengthen_stone = 70011,
		strengthen_stone_count = 125,
		base_attr_add = 1920
};

get(65) ->
	#equip_strenthen{
		stren_lv = 65,
		need_eq_lv = 260,
		strengthen_stone = 70011,
		strengthen_stone_count = 130,
		base_attr_add = 1950
};

get(66) ->
	#equip_strenthen{
		stren_lv = 66,
		need_eq_lv = 280,
		strengthen_stone = 70011,
		strengthen_stone_count = 135,
		base_attr_add = 1980
};

get(67) ->
	#equip_strenthen{
		stren_lv = 67,
		need_eq_lv = 280,
		strengthen_stone = 70011,
		strengthen_stone_count = 140,
		base_attr_add = 2010
};

get(68) ->
	#equip_strenthen{
		stren_lv = 68,
		need_eq_lv = 280,
		strengthen_stone = 70011,
		strengthen_stone_count = 145,
		base_attr_add = 2040
};

get(69) ->
	#equip_strenthen{
		stren_lv = 69,
		need_eq_lv = 280,
		strengthen_stone = 70011,
		strengthen_stone_count = 150,
		base_attr_add = 2070
};

get(70) ->
	#equip_strenthen{
		stren_lv = 70,
		need_eq_lv = 280,
		strengthen_stone = 70011,
		strengthen_stone_count = 155,
		base_attr_add = 2100
};

get(71) ->
	#equip_strenthen{
		stren_lv = 71,
		need_eq_lv = 300,
		strengthen_stone = 70011,
		strengthen_stone_count = 160,
		base_attr_add = 2130
};

get(72) ->
	#equip_strenthen{
		stren_lv = 72,
		need_eq_lv = 300,
		strengthen_stone = 70011,
		strengthen_stone_count = 170,
		base_attr_add = 2160
};

get(73) ->
	#equip_strenthen{
		stren_lv = 73,
		need_eq_lv = 300,
		strengthen_stone = 70011,
		strengthen_stone_count = 180,
		base_attr_add = 2190
};

get(74) ->
	#equip_strenthen{
		stren_lv = 74,
		need_eq_lv = 300,
		strengthen_stone = 70011,
		strengthen_stone_count = 190,
		base_attr_add = 2220
};

get(75) ->
	#equip_strenthen{
		stren_lv = 75,
		need_eq_lv = 300,
		strengthen_stone = 70011,
		strengthen_stone_count = 200,
		base_attr_add = 2250
};

get(76) ->
	#equip_strenthen{
		stren_lv = 76,
		need_eq_lv = 320,
		strengthen_stone = 70011,
		strengthen_stone_count = 210,
		base_attr_add = 2280
};

get(77) ->
	#equip_strenthen{
		stren_lv = 77,
		need_eq_lv = 320,
		strengthen_stone = 70011,
		strengthen_stone_count = 220,
		base_attr_add = 2310
};

get(78) ->
	#equip_strenthen{
		stren_lv = 78,
		need_eq_lv = 320,
		strengthen_stone = 70011,
		strengthen_stone_count = 230,
		base_attr_add = 2340
};

get(79) ->
	#equip_strenthen{
		stren_lv = 79,
		need_eq_lv = 320,
		strengthen_stone = 70011,
		strengthen_stone_count = 240,
		base_attr_add = 2370
};

get(80) ->
	#equip_strenthen{
		stren_lv = 80,
		need_eq_lv = 320,
		strengthen_stone = 70011,
		strengthen_stone_count = 250,
		base_attr_add = 2400
};

get(81) ->
	#equip_strenthen{
		stren_lv = 81,
		need_eq_lv = 340,
		strengthen_stone = 70011,
		strengthen_stone_count = 260,
		base_attr_add = 2430
};

get(82) ->
	#equip_strenthen{
		stren_lv = 82,
		need_eq_lv = 340,
		strengthen_stone = 70011,
		strengthen_stone_count = 270,
		base_attr_add = 2460
};

get(83) ->
	#equip_strenthen{
		stren_lv = 83,
		need_eq_lv = 340,
		strengthen_stone = 70011,
		strengthen_stone_count = 280,
		base_attr_add = 2490
};

get(84) ->
	#equip_strenthen{
		stren_lv = 84,
		need_eq_lv = 340,
		strengthen_stone = 70011,
		strengthen_stone_count = 290,
		base_attr_add = 2520
};

get(85) ->
	#equip_strenthen{
		stren_lv = 85,
		need_eq_lv = 340,
		strengthen_stone = 70011,
		strengthen_stone_count = 300,
		base_attr_add = 2550
};

get(86) ->
	#equip_strenthen{
		stren_lv = 86,
		need_eq_lv = 360,
		strengthen_stone = 70011,
		strengthen_stone_count = 310,
		base_attr_add = 2580
};

get(87) ->
	#equip_strenthen{
		stren_lv = 87,
		need_eq_lv = 360,
		strengthen_stone = 70011,
		strengthen_stone_count = 320,
		base_attr_add = 2610
};

get(88) ->
	#equip_strenthen{
		stren_lv = 88,
		need_eq_lv = 360,
		strengthen_stone = 70011,
		strengthen_stone_count = 330,
		base_attr_add = 2640
};

get(89) ->
	#equip_strenthen{
		stren_lv = 89,
		need_eq_lv = 360,
		strengthen_stone = 70011,
		strengthen_stone_count = 340,
		base_attr_add = 2670
};

get(90) ->
	#equip_strenthen{
		stren_lv = 90,
		need_eq_lv = 360,
		strengthen_stone = 70011,
		strengthen_stone_count = 350,
		base_attr_add = 2700
};

get(91) ->
	#equip_strenthen{
		stren_lv = 91,
		need_eq_lv = 380,
		strengthen_stone = 70011,
		strengthen_stone_count = 360,
		base_attr_add = 2730
};

get(92) ->
	#equip_strenthen{
		stren_lv = 92,
		need_eq_lv = 380,
		strengthen_stone = 70011,
		strengthen_stone_count = 370,
		base_attr_add = 2760
};

get(93) ->
	#equip_strenthen{
		stren_lv = 93,
		need_eq_lv = 380,
		strengthen_stone = 70011,
		strengthen_stone_count = 380,
		base_attr_add = 2790
};

get(94) ->
	#equip_strenthen{
		stren_lv = 94,
		need_eq_lv = 380,
		strengthen_stone = 70011,
		strengthen_stone_count = 390,
		base_attr_add = 2820
};

get(95) ->
	#equip_strenthen{
		stren_lv = 95,
		need_eq_lv = 380,
		strengthen_stone = 70011,
		strengthen_stone_count = 400,
		base_attr_add = 2850
};

get(96) ->
	#equip_strenthen{
		stren_lv = 96,
		need_eq_lv = 400,
		strengthen_stone = 70011,
		strengthen_stone_count = 410,
		base_attr_add = 2880
};

get(97) ->
	#equip_strenthen{
		stren_lv = 97,
		need_eq_lv = 400,
		strengthen_stone = 70011,
		strengthen_stone_count = 420,
		base_attr_add = 2910
};

get(98) ->
	#equip_strenthen{
		stren_lv = 98,
		need_eq_lv = 400,
		strengthen_stone = 70011,
		strengthen_stone_count = 430,
		base_attr_add = 2940
};

get(99) ->
	#equip_strenthen{
		stren_lv = 99,
		need_eq_lv = 400,
		strengthen_stone = 70011,
		strengthen_stone_count = 440,
		base_attr_add = 2970
};

get(100) ->
	#equip_strenthen{
		stren_lv = 100,
		need_eq_lv = 400,
		strengthen_stone = 70011,
		strengthen_stone_count = 450,
		base_attr_add = 3000
};

get(_No) ->
	      ?ASSERT(false, _No),
          null.

