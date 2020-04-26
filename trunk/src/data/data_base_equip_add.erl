%%%---------------------------------------
%%% @Module  : data_base_equip_add
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2013-07-07  20:11:25
%%% @Description:  装备的基本属性加成的基数表，
%%%                自动生成（模板：base_equip_add.tpl.php）
%%%---------------------------------------

-module(data_base_equip_add).

-export([get/2]).

-include("record.hrl").
-include("debug.hrl").



get(0, 1) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 353,
		mp_lim = 188,
		phy_att = 107,
		mag_att = 32,
		phy_def = 33,
		mag_def = 33,
		act_speed = 15
		};

get(0, 2) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 389,
		mp_lim = 176,
		phy_att = 112,
		mag_att = 32,
		phy_def = 32,
		mag_def = 33,
		act_speed = 15
		};

get(0, 3) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 330,
		mp_lim = 210,
		phy_att = 101,
		mag_att = 34,
		phy_def = 40,
		mag_def = 34,
		act_speed = 15
		};

get(10, 1) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 465,
		mp_lim = 255,
		phy_att = 206,
		mag_att = 110,
		phy_def = 110,
		mag_def = 110,
		act_speed = 38
		};

get(10, 2) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 524,
		mp_lim = 233,
		phy_att = 220,
		mag_att = 109,
		phy_def = 63,
		mag_def = 111,
		act_speed = 38
		};

get(10, 3) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 431,
		mp_lim = 660,
		phy_att = 114,
		mag_att = 145,
		phy_def = 76,
		mag_def = 145,
		act_speed = 30
		};

get(20, 1) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 578,
		mp_lim = 323,
		phy_att = 305,
		mag_att = 187,
		phy_def = 188,
		mag_def = 188,
		act_speed = 60
		};

get(20, 2) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 659,
		mp_lim = 289,
		phy_att = 328,
		mag_att = 186,
		phy_def = 95,
		mag_def = 188,
		act_speed = 60
		};

get(20, 3) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 531,
		mp_lim = 1110,
		phy_att = 128,
		mag_att = 256,
		phy_def = 112,
		mag_def = 257,
		act_speed = 45
		};

get(30, 1) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 690,
		mp_lim = 390,
		phy_att = 404,
		mag_att = 264,
		phy_def = 266,
		mag_def = 266,
		act_speed = 83
		};

get(30, 2) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 794,
		mp_lim = 345,
		phy_att = 436,
		mag_att = 264,
		phy_def = 126,
		mag_def = 266,
		act_speed = 83
		};

get(30, 3) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 632,
		mp_lim = 1560,
		phy_att = 141,
		mag_att = 367,
		phy_def = 148,
		mag_def = 368,
		act_speed = 60
		};

get(40, 1) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 803,
		mp_lim = 458,
		phy_att = 503,
		mag_att = 341,
		phy_def = 344,
		mag_def = 344,
		act_speed = 105
		};

get(40, 2) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 929,
		mp_lim = 401,
		phy_att = 544,
		mag_att = 341,
		phy_def = 158,
		mag_def = 344,
		act_speed = 105
		};

get(40, 3) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 732,
		mp_lim = 2010,
		phy_att = 155,
		mag_att = 478,
		phy_def = 184,
		mag_def = 480,
		act_speed = 75
		};

get(50, 1) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 915,
		mp_lim = 525,
		phy_att = 602,
		mag_att = 419,
		phy_def = 421,
		mag_def = 421,
		act_speed = 128
		};

get(50, 2) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 1064,
		mp_lim = 458,
		phy_att = 652,
		mag_att = 418,
		phy_def = 189,
		mag_def = 421,
		act_speed = 128
		};

get(50, 3) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 833,
		mp_lim = 2460,
		phy_att = 168,
		mag_att = 589,
		phy_def = 220,
		mag_def = 591,
		act_speed = 90
		};

get(60, 1) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 1028,
		mp_lim = 593,
		phy_att = 701,
		mag_att = 496,
		phy_def = 499,
		mag_def = 499,
		act_speed = 150
		};

get(60, 2) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 1199,
		mp_lim = 514,
		phy_att = 760,
		mag_att = 495,
		phy_def = 221,
		mag_def = 499,
		act_speed = 150
		};

get(60, 3) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 933,
		mp_lim = 2910,
		phy_att = 182,
		mag_att = 700,
		phy_def = 256,
		mag_def = 702,
		act_speed = 105
		};

get(70, 1) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 1140,
		mp_lim = 660,
		phy_att = 800,
		mag_att = 573,
		phy_def = 577,
		mag_def = 577,
		act_speed = 173
		};

get(70, 2) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 1334,
		mp_lim = 570,
		phy_att = 868,
		mag_att = 573,
		phy_def = 252,
		mag_def = 577,
		act_speed = 173
		};

get(70, 3) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 1034,
		mp_lim = 3360,
		phy_att = 195,
		mag_att = 811,
		phy_def = 292,
		mag_def = 814,
		act_speed = 120
		};

get(80, 1) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 1253,
		mp_lim = 728,
		phy_att = 899,
		mag_att = 650,
		phy_def = 654,
		mag_def = 654,
		act_speed = 195
		};

get(80, 2) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 1469,
		mp_lim = 626,
		phy_att = 976,
		mag_att = 650,
		phy_def = 284,
		mag_def = 655,
		act_speed = 195
		};

get(80, 3) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 1134,
		mp_lim = 3810,
		phy_att = 209,
		mag_att = 922,
		phy_def = 328,
		mag_def = 925,
		act_speed = 135
		};

get(90, 1) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 1365,
		mp_lim = 795,
		phy_att = 998,
		mag_att = 728,
		phy_def = 732,
		mag_def = 732,
		act_speed = 218
		};

get(90, 2) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 1604,
		mp_lim = 683,
		phy_att = 1084,
		mag_att = 727,
		phy_def = 315,
		mag_def = 732,
		act_speed = 218
		};

get(90, 3) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 1235,
		mp_lim = 4260,
		phy_att = 222,
		mag_att = 1033,
		phy_def = 364,
		mag_def = 1037,
		act_speed = 150
		};

get(100, 1) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 1478,
		mp_lim = 863,
		phy_att = 1097,
		mag_att = 805,
		phy_def = 810,
		mag_def = 810,
		act_speed = 240
		};

get(100, 2) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 1739,
		mp_lim = 739,
		phy_att = 1192,
		mag_att = 804,
		phy_def = 347,
		mag_def = 810,
		act_speed = 240
		};

get(100, 3) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 1335,
		mp_lim = 4710,
		phy_att = 236,
		mag_att = 1144,
		phy_def = 400,
		mag_def = 1148,
		act_speed = 165
		};

get(110, 1) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 1590,
		mp_lim = 930,
		phy_att = 1196,
		mag_att = 882,
		phy_def = 887,
		mag_def = 887,
		act_speed = 263
		};

get(110, 2) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 1874,
		mp_lim = 795,
		phy_att = 1300,
		mag_att = 882,
		phy_def = 378,
		mag_def = 888,
		act_speed = 263
		};

get(110, 3) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 1436,
		mp_lim = 5160,
		phy_att = 249,
		mag_att = 1255,
		phy_def = 436,
		mag_def = 1260,
		act_speed = 180
		};

get(120, 1) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 1703,
		mp_lim = 998,
		phy_att = 1295,
		mag_att = 959,
		phy_def = 965,
		mag_def = 965,
		act_speed = 285
		};

get(120, 2) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 2009,
		mp_lim = 851,
		phy_att = 1408,
		mag_att = 959,
		phy_def = 410,
		mag_def = 965,
		act_speed = 285
		};

get(120, 3) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 1536,
		mp_lim = 5610,
		phy_att = 263,
		mag_att = 1366,
		phy_def = 472,
		mag_def = 1371,
		act_speed = 195
		};

get(130, 1) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 1815,
		mp_lim = 1065,
		phy_att = 1394,
		mag_att = 1037,
		phy_def = 1043,
		mag_def = 1043,
		act_speed = 308
		};

get(130, 2) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 2144,
		mp_lim = 908,
		phy_att = 1516,
		mag_att = 1036,
		phy_def = 441,
		mag_def = 1043,
		act_speed = 308
		};

get(130, 3) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 1637,
		mp_lim = 6060,
		phy_att = 276,
		mag_att = 1477,
		phy_def = 508,
		mag_def = 1483,
		act_speed = 210
		};

get(140, 1) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 1928,
		mp_lim = 1133,
		phy_att = 1493,
		mag_att = 1114,
		phy_def = 1121,
		mag_def = 1121,
		act_speed = 330
		};

get(140, 2) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 2279,
		mp_lim = 964,
		phy_att = 1624,
		mag_att = 1113,
		phy_def = 473,
		mag_def = 1121,
		act_speed = 330
		};

get(140, 3) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 1737,
		mp_lim = 6510,
		phy_att = 290,
		mag_att = 1588,
		phy_def = 544,
		mag_def = 1594,
		act_speed = 225
		};

get(150, 1) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 2040,
		mp_lim = 1200,
		phy_att = 1592,
		mag_att = 1191,
		phy_def = 1198,
		mag_def = 1198,
		act_speed = 353
		};

get(150, 2) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 2414,
		mp_lim = 1020,
		phy_att = 1732,
		mag_att = 1191,
		phy_def = 504,
		mag_def = 1198,
		act_speed = 353
		};

get(150, 3) ->  % 参数表示装备所属的等级段和种族
	#attrs{
		hp_lim = 1838,
		mp_lim = 6960,
		phy_att = 303,
		mag_att = 1699,
		phy_def = 580,
		mag_def = 1706,
		act_speed = 240
		};
	
get(_LvStep, _Race) ->
	?ASSERT(false, {_LvStep, _Race}),
    null.
