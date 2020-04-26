%%%---------------------------------------
%%% @Module  : data_xinfa_add_attrs_value
%%% @Author  : huangjf
%%% @Email   : 
%%% @Description: 心法的属性加成的数值
%%%---------------------------------------


-module(data_xinfa_add_attrs_value).
-export([get/1]).
-include("xinfa.hrl").
-include("debug.hrl").

get(1) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 1,
		hp_lim = 32,
		phy_att = 5,
		mag_att = 8,
		phy_def = 8,
		mag_def = 12,
		crit = 5,
		ten = 8,
		hit = 5,
		dodge = 0,
		act_speed = 2,
		seal_hit = 5,
		seal_resis = 5,
		mp_lim = 16
};

get(2) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 2,
		hp_lim = 64,
		phy_att = 10,
		mag_att = 16,
		phy_def = 16,
		mag_def = 24,
		crit = 10,
		ten = 16,
		hit = 10,
		dodge = 0,
		act_speed = 5,
		seal_hit = 10,
		seal_resis = 10,
		mp_lim = 32
};

get(3) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 3,
		hp_lim = 97,
		phy_att = 16,
		mag_att = 24,
		phy_def = 24,
		mag_def = 36,
		crit = 16,
		ten = 24,
		hit = 16,
		dodge = 0,
		act_speed = 8,
		seal_hit = 16,
		seal_resis = 16,
		mp_lim = 48
};

get(4) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 4,
		hp_lim = 129,
		phy_att = 21,
		mag_att = 32,
		phy_def = 32,
		mag_def = 48,
		crit = 21,
		ten = 32,
		hit = 21,
		dodge = 0,
		act_speed = 10,
		seal_hit = 21,
		seal_resis = 21,
		mp_lim = 64
};

get(5) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 5,
		hp_lim = 162,
		phy_att = 27,
		mag_att = 40,
		phy_def = 40,
		mag_def = 60,
		crit = 27,
		ten = 40,
		hit = 27,
		dodge = 0,
		act_speed = 13,
		seal_hit = 27,
		seal_resis = 27,
		mp_lim = 81
};

get(6) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 6,
		hp_lim = 194,
		phy_att = 32,
		mag_att = 48,
		phy_def = 48,
		mag_def = 72,
		crit = 32,
		ten = 48,
		hit = 32,
		dodge = 0,
		act_speed = 16,
		seal_hit = 32,
		seal_resis = 32,
		mp_lim = 97
};

get(7) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 7,
		hp_lim = 226,
		phy_att = 37,
		mag_att = 56,
		phy_def = 56,
		mag_def = 85,
		crit = 37,
		ten = 56,
		hit = 37,
		dodge = 0,
		act_speed = 18,
		seal_hit = 37,
		seal_resis = 37,
		mp_lim = 113
};

get(8) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 8,
		hp_lim = 259,
		phy_att = 43,
		mag_att = 64,
		phy_def = 64,
		mag_def = 97,
		crit = 43,
		ten = 64,
		hit = 43,
		dodge = 0,
		act_speed = 21,
		seal_hit = 43,
		seal_resis = 43,
		mp_lim = 129
};

get(9) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 9,
		hp_lim = 291,
		phy_att = 48,
		mag_att = 72,
		phy_def = 72,
		mag_def = 109,
		crit = 48,
		ten = 72,
		hit = 48,
		dodge = 0,
		act_speed = 24,
		seal_hit = 48,
		seal_resis = 48,
		mp_lim = 145
};

get(10) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 10,
		hp_lim = 324,
		phy_att = 54,
		mag_att = 81,
		phy_def = 81,
		mag_def = 121,
		crit = 54,
		ten = 81,
		hit = 54,
		dodge = 0,
		act_speed = 27,
		seal_hit = 54,
		seal_resis = 54,
		mp_lim = 162
};

get(11) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 11,
		hp_lim = 356,
		phy_att = 59,
		mag_att = 89,
		phy_def = 89,
		mag_def = 133,
		crit = 59,
		ten = 89,
		hit = 59,
		dodge = 0,
		act_speed = 29,
		seal_hit = 59,
		seal_resis = 59,
		mp_lim = 178
};

get(12) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 12,
		hp_lim = 388,
		phy_att = 64,
		mag_att = 97,
		phy_def = 97,
		mag_def = 145,
		crit = 64,
		ten = 97,
		hit = 64,
		dodge = 0,
		act_speed = 32,
		seal_hit = 64,
		seal_resis = 64,
		mp_lim = 194
};

get(13) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 13,
		hp_lim = 421,
		phy_att = 70,
		mag_att = 105,
		phy_def = 105,
		mag_def = 157,
		crit = 70,
		ten = 105,
		hit = 70,
		dodge = 0,
		act_speed = 35,
		seal_hit = 70,
		seal_resis = 70,
		mp_lim = 210
};

get(14) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 14,
		hp_lim = 453,
		phy_att = 75,
		mag_att = 113,
		phy_def = 113,
		mag_def = 170,
		crit = 75,
		ten = 113,
		hit = 75,
		dodge = 0,
		act_speed = 37,
		seal_hit = 75,
		seal_resis = 75,
		mp_lim = 226
};

get(15) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 15,
		hp_lim = 486,
		phy_att = 81,
		mag_att = 121,
		phy_def = 121,
		mag_def = 182,
		crit = 81,
		ten = 121,
		hit = 81,
		dodge = 0,
		act_speed = 40,
		seal_hit = 81,
		seal_resis = 81,
		mp_lim = 243
};

get(16) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 16,
		hp_lim = 518,
		phy_att = 86,
		mag_att = 129,
		phy_def = 129,
		mag_def = 194,
		crit = 86,
		ten = 129,
		hit = 86,
		dodge = 0,
		act_speed = 43,
		seal_hit = 86,
		seal_resis = 86,
		mp_lim = 259
};

get(17) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 17,
		hp_lim = 550,
		phy_att = 91,
		mag_att = 137,
		phy_def = 137,
		mag_def = 206,
		crit = 91,
		ten = 137,
		hit = 91,
		dodge = 0,
		act_speed = 45,
		seal_hit = 91,
		seal_resis = 91,
		mp_lim = 275
};

get(18) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 18,
		hp_lim = 583,
		phy_att = 97,
		mag_att = 145,
		phy_def = 145,
		mag_def = 218,
		crit = 97,
		ten = 145,
		hit = 97,
		dodge = 0,
		act_speed = 48,
		seal_hit = 97,
		seal_resis = 97,
		mp_lim = 291
};

get(19) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 19,
		hp_lim = 615,
		phy_att = 102,
		mag_att = 153,
		phy_def = 153,
		mag_def = 230,
		crit = 102,
		ten = 153,
		hit = 102,
		dodge = 0,
		act_speed = 51,
		seal_hit = 102,
		seal_resis = 102,
		mp_lim = 307
};

get(20) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 20,
		hp_lim = 648,
		phy_att = 108,
		mag_att = 162,
		phy_def = 162,
		mag_def = 243,
		crit = 108,
		ten = 162,
		hit = 108,
		dodge = 0,
		act_speed = 54,
		seal_hit = 108,
		seal_resis = 108,
		mp_lim = 324
};

get(21) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 21,
		hp_lim = 680,
		phy_att = 113,
		mag_att = 170,
		phy_def = 170,
		mag_def = 255,
		crit = 113,
		ten = 170,
		hit = 113,
		dodge = 0,
		act_speed = 56,
		seal_hit = 113,
		seal_resis = 113,
		mp_lim = 340
};

get(22) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 22,
		hp_lim = 712,
		phy_att = 118,
		mag_att = 178,
		phy_def = 178,
		mag_def = 267,
		crit = 118,
		ten = 178,
		hit = 118,
		dodge = 0,
		act_speed = 59,
		seal_hit = 118,
		seal_resis = 118,
		mp_lim = 356
};

get(23) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 23,
		hp_lim = 745,
		phy_att = 124,
		mag_att = 186,
		phy_def = 186,
		mag_def = 279,
		crit = 124,
		ten = 186,
		hit = 124,
		dodge = 0,
		act_speed = 62,
		seal_hit = 124,
		seal_resis = 124,
		mp_lim = 372
};

get(24) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 24,
		hp_lim = 777,
		phy_att = 129,
		mag_att = 194,
		phy_def = 194,
		mag_def = 291,
		crit = 129,
		ten = 194,
		hit = 129,
		dodge = 0,
		act_speed = 64,
		seal_hit = 129,
		seal_resis = 129,
		mp_lim = 388
};

get(25) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 25,
		hp_lim = 810,
		phy_att = 135,
		mag_att = 202,
		phy_def = 202,
		mag_def = 303,
		crit = 135,
		ten = 202,
		hit = 135,
		dodge = 0,
		act_speed = 67,
		seal_hit = 135,
		seal_resis = 135,
		mp_lim = 405
};

get(26) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 26,
		hp_lim = 842,
		phy_att = 140,
		mag_att = 210,
		phy_def = 210,
		mag_def = 315,
		crit = 140,
		ten = 210,
		hit = 140,
		dodge = 0,
		act_speed = 70,
		seal_hit = 140,
		seal_resis = 140,
		mp_lim = 421
};

get(27) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 27,
		hp_lim = 874,
		phy_att = 145,
		mag_att = 218,
		phy_def = 218,
		mag_def = 328,
		crit = 145,
		ten = 218,
		hit = 145,
		dodge = 0,
		act_speed = 72,
		seal_hit = 145,
		seal_resis = 145,
		mp_lim = 437
};

get(28) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 28,
		hp_lim = 907,
		phy_att = 151,
		mag_att = 226,
		phy_def = 226,
		mag_def = 340,
		crit = 151,
		ten = 226,
		hit = 151,
		dodge = 0,
		act_speed = 75,
		seal_hit = 151,
		seal_resis = 151,
		mp_lim = 453
};

get(29) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 29,
		hp_lim = 939,
		phy_att = 156,
		mag_att = 234,
		phy_def = 234,
		mag_def = 352,
		crit = 156,
		ten = 234,
		hit = 156,
		dodge = 0,
		act_speed = 78,
		seal_hit = 156,
		seal_resis = 156,
		mp_lim = 469
};

get(30) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 30,
		hp_lim = 972,
		phy_att = 162,
		mag_att = 243,
		phy_def = 243,
		mag_def = 364,
		crit = 162,
		ten = 243,
		hit = 162,
		dodge = 0,
		act_speed = 81,
		seal_hit = 162,
		seal_resis = 162,
		mp_lim = 486
};

get(31) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 31,
		hp_lim = 1004,
		phy_att = 167,
		mag_att = 251,
		phy_def = 251,
		mag_def = 376,
		crit = 167,
		ten = 251,
		hit = 167,
		dodge = 0,
		act_speed = 83,
		seal_hit = 167,
		seal_resis = 167,
		mp_lim = 502
};

get(32) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 32,
		hp_lim = 1036,
		phy_att = 172,
		mag_att = 259,
		phy_def = 259,
		mag_def = 388,
		crit = 172,
		ten = 259,
		hit = 172,
		dodge = 0,
		act_speed = 86,
		seal_hit = 172,
		seal_resis = 172,
		mp_lim = 518
};

get(33) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 33,
		hp_lim = 1069,
		phy_att = 178,
		mag_att = 267,
		phy_def = 267,
		mag_def = 400,
		crit = 178,
		ten = 267,
		hit = 178,
		dodge = 0,
		act_speed = 89,
		seal_hit = 178,
		seal_resis = 178,
		mp_lim = 534
};

get(34) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 34,
		hp_lim = 1101,
		phy_att = 183,
		mag_att = 275,
		phy_def = 275,
		mag_def = 413,
		crit = 183,
		ten = 275,
		hit = 183,
		dodge = 0,
		act_speed = 91,
		seal_hit = 183,
		seal_resis = 183,
		mp_lim = 550
};

get(35) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 35,
		hp_lim = 1134,
		phy_att = 189,
		mag_att = 283,
		phy_def = 283,
		mag_def = 425,
		crit = 189,
		ten = 283,
		hit = 189,
		dodge = 0,
		act_speed = 94,
		seal_hit = 189,
		seal_resis = 189,
		mp_lim = 567
};

get(36) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 36,
		hp_lim = 1166,
		phy_att = 194,
		mag_att = 291,
		phy_def = 291,
		mag_def = 437,
		crit = 194,
		ten = 291,
		hit = 194,
		dodge = 0,
		act_speed = 97,
		seal_hit = 194,
		seal_resis = 194,
		mp_lim = 583
};

get(37) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 37,
		hp_lim = 1198,
		phy_att = 199,
		mag_att = 299,
		phy_def = 299,
		mag_def = 449,
		crit = 199,
		ten = 299,
		hit = 199,
		dodge = 0,
		act_speed = 99,
		seal_hit = 199,
		seal_resis = 199,
		mp_lim = 599
};

get(38) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 38,
		hp_lim = 1231,
		phy_att = 205,
		mag_att = 307,
		phy_def = 307,
		mag_def = 461,
		crit = 205,
		ten = 307,
		hit = 205,
		dodge = 0,
		act_speed = 102,
		seal_hit = 205,
		seal_resis = 205,
		mp_lim = 615
};

get(39) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 39,
		hp_lim = 1263,
		phy_att = 210,
		mag_att = 315,
		phy_def = 315,
		mag_def = 473,
		crit = 210,
		ten = 315,
		hit = 210,
		dodge = 0,
		act_speed = 105,
		seal_hit = 210,
		seal_resis = 210,
		mp_lim = 631
};

get(40) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 40,
		hp_lim = 1296,
		phy_att = 216,
		mag_att = 324,
		phy_def = 324,
		mag_def = 486,
		crit = 216,
		ten = 324,
		hit = 216,
		dodge = 0,
		act_speed = 108,
		seal_hit = 216,
		seal_resis = 216,
		mp_lim = 648
};

get(41) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 41,
		hp_lim = 1328,
		phy_att = 221,
		mag_att = 332,
		phy_def = 332,
		mag_def = 498,
		crit = 221,
		ten = 332,
		hit = 221,
		dodge = 0,
		act_speed = 110,
		seal_hit = 221,
		seal_resis = 221,
		mp_lim = 664
};

get(42) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 42,
		hp_lim = 1360,
		phy_att = 226,
		mag_att = 340,
		phy_def = 340,
		mag_def = 510,
		crit = 226,
		ten = 340,
		hit = 226,
		dodge = 0,
		act_speed = 113,
		seal_hit = 226,
		seal_resis = 226,
		mp_lim = 680
};

get(43) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 43,
		hp_lim = 1393,
		phy_att = 232,
		mag_att = 348,
		phy_def = 348,
		mag_def = 522,
		crit = 232,
		ten = 348,
		hit = 232,
		dodge = 0,
		act_speed = 116,
		seal_hit = 232,
		seal_resis = 232,
		mp_lim = 696
};

get(44) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 44,
		hp_lim = 1425,
		phy_att = 237,
		mag_att = 356,
		phy_def = 356,
		mag_def = 534,
		crit = 237,
		ten = 356,
		hit = 237,
		dodge = 0,
		act_speed = 118,
		seal_hit = 237,
		seal_resis = 237,
		mp_lim = 712
};

get(45) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 45,
		hp_lim = 1458,
		phy_att = 243,
		mag_att = 364,
		phy_def = 364,
		mag_def = 546,
		crit = 243,
		ten = 364,
		hit = 243,
		dodge = 0,
		act_speed = 121,
		seal_hit = 243,
		seal_resis = 243,
		mp_lim = 729
};

get(46) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 46,
		hp_lim = 1490,
		phy_att = 248,
		mag_att = 372,
		phy_def = 372,
		mag_def = 558,
		crit = 248,
		ten = 372,
		hit = 248,
		dodge = 0,
		act_speed = 124,
		seal_hit = 248,
		seal_resis = 248,
		mp_lim = 745
};

get(47) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 47,
		hp_lim = 1522,
		phy_att = 253,
		mag_att = 380,
		phy_def = 380,
		mag_def = 571,
		crit = 253,
		ten = 380,
		hit = 253,
		dodge = 0,
		act_speed = 126,
		seal_hit = 253,
		seal_resis = 253,
		mp_lim = 761
};

get(48) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 48,
		hp_lim = 1555,
		phy_att = 259,
		mag_att = 388,
		phy_def = 388,
		mag_def = 583,
		crit = 259,
		ten = 388,
		hit = 259,
		dodge = 0,
		act_speed = 129,
		seal_hit = 259,
		seal_resis = 259,
		mp_lim = 777
};

get(49) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 49,
		hp_lim = 1587,
		phy_att = 264,
		mag_att = 396,
		phy_def = 396,
		mag_def = 595,
		crit = 264,
		ten = 396,
		hit = 264,
		dodge = 0,
		act_speed = 132,
		seal_hit = 264,
		seal_resis = 264,
		mp_lim = 793
};

get(50) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 50,
		hp_lim = 1620,
		phy_att = 270,
		mag_att = 405,
		phy_def = 405,
		mag_def = 607,
		crit = 270,
		ten = 405,
		hit = 270,
		dodge = 0,
		act_speed = 135,
		seal_hit = 270,
		seal_resis = 270,
		mp_lim = 810
};

get(51) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 51,
		hp_lim = 1652,
		phy_att = 275,
		mag_att = 413,
		phy_def = 413,
		mag_def = 619,
		crit = 275,
		ten = 413,
		hit = 275,
		dodge = 0,
		act_speed = 137,
		seal_hit = 275,
		seal_resis = 275,
		mp_lim = 826
};

get(52) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 52,
		hp_lim = 1684,
		phy_att = 280,
		mag_att = 421,
		phy_def = 421,
		mag_def = 631,
		crit = 280,
		ten = 421,
		hit = 280,
		dodge = 0,
		act_speed = 140,
		seal_hit = 280,
		seal_resis = 280,
		mp_lim = 842
};

get(53) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 53,
		hp_lim = 1717,
		phy_att = 286,
		mag_att = 429,
		phy_def = 429,
		mag_def = 643,
		crit = 286,
		ten = 429,
		hit = 286,
		dodge = 0,
		act_speed = 143,
		seal_hit = 286,
		seal_resis = 286,
		mp_lim = 858
};

get(54) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 54,
		hp_lim = 1749,
		phy_att = 291,
		mag_att = 437,
		phy_def = 437,
		mag_def = 656,
		crit = 291,
		ten = 437,
		hit = 291,
		dodge = 0,
		act_speed = 145,
		seal_hit = 291,
		seal_resis = 291,
		mp_lim = 874
};

get(55) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 55,
		hp_lim = 1782,
		phy_att = 297,
		mag_att = 445,
		phy_def = 445,
		mag_def = 668,
		crit = 297,
		ten = 445,
		hit = 297,
		dodge = 0,
		act_speed = 148,
		seal_hit = 297,
		seal_resis = 297,
		mp_lim = 891
};

get(56) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 56,
		hp_lim = 1814,
		phy_att = 302,
		mag_att = 453,
		phy_def = 453,
		mag_def = 680,
		crit = 302,
		ten = 453,
		hit = 302,
		dodge = 0,
		act_speed = 151,
		seal_hit = 302,
		seal_resis = 302,
		mp_lim = 907
};

get(57) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 57,
		hp_lim = 1846,
		phy_att = 307,
		mag_att = 461,
		phy_def = 461,
		mag_def = 692,
		crit = 307,
		ten = 461,
		hit = 307,
		dodge = 0,
		act_speed = 153,
		seal_hit = 307,
		seal_resis = 307,
		mp_lim = 923
};

get(58) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 58,
		hp_lim = 1879,
		phy_att = 313,
		mag_att = 469,
		phy_def = 469,
		mag_def = 704,
		crit = 313,
		ten = 469,
		hit = 313,
		dodge = 0,
		act_speed = 156,
		seal_hit = 313,
		seal_resis = 313,
		mp_lim = 939
};

get(59) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 59,
		hp_lim = 1911,
		phy_att = 318,
		mag_att = 477,
		phy_def = 477,
		mag_def = 716,
		crit = 318,
		ten = 477,
		hit = 318,
		dodge = 0,
		act_speed = 159,
		seal_hit = 318,
		seal_resis = 318,
		mp_lim = 955
};

get(60) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 60,
		hp_lim = 1944,
		phy_att = 324,
		mag_att = 486,
		phy_def = 486,
		mag_def = 729,
		crit = 324,
		ten = 486,
		hit = 324,
		dodge = 0,
		act_speed = 162,
		seal_hit = 324,
		seal_resis = 324,
		mp_lim = 972
};

get(61) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 61,
		hp_lim = 1976,
		phy_att = 329,
		mag_att = 494,
		phy_def = 494,
		mag_def = 741,
		crit = 329,
		ten = 494,
		hit = 329,
		dodge = 0,
		act_speed = 164,
		seal_hit = 329,
		seal_resis = 329,
		mp_lim = 988
};

get(62) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 62,
		hp_lim = 2008,
		phy_att = 334,
		mag_att = 502,
		phy_def = 502,
		mag_def = 753,
		crit = 334,
		ten = 502,
		hit = 334,
		dodge = 0,
		act_speed = 167,
		seal_hit = 334,
		seal_resis = 334,
		mp_lim = 1004
};

get(63) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 63,
		hp_lim = 2041,
		phy_att = 340,
		mag_att = 510,
		phy_def = 510,
		mag_def = 765,
		crit = 340,
		ten = 510,
		hit = 340,
		dodge = 0,
		act_speed = 170,
		seal_hit = 340,
		seal_resis = 340,
		mp_lim = 1020
};

get(64) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 64,
		hp_lim = 2073,
		phy_att = 345,
		mag_att = 518,
		phy_def = 518,
		mag_def = 777,
		crit = 345,
		ten = 518,
		hit = 345,
		dodge = 0,
		act_speed = 172,
		seal_hit = 345,
		seal_resis = 345,
		mp_lim = 1036
};

get(65) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 65,
		hp_lim = 2106,
		phy_att = 351,
		mag_att = 526,
		phy_def = 526,
		mag_def = 789,
		crit = 351,
		ten = 526,
		hit = 351,
		dodge = 0,
		act_speed = 175,
		seal_hit = 351,
		seal_resis = 351,
		mp_lim = 1053
};

get(66) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 66,
		hp_lim = 2138,
		phy_att = 356,
		mag_att = 534,
		phy_def = 534,
		mag_def = 801,
		crit = 356,
		ten = 534,
		hit = 356,
		dodge = 0,
		act_speed = 178,
		seal_hit = 356,
		seal_resis = 356,
		mp_lim = 1069
};

get(67) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 67,
		hp_lim = 2170,
		phy_att = 361,
		mag_att = 542,
		phy_def = 542,
		mag_def = 814,
		crit = 361,
		ten = 542,
		hit = 361,
		dodge = 0,
		act_speed = 180,
		seal_hit = 361,
		seal_resis = 361,
		mp_lim = 1085
};

get(68) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 68,
		hp_lim = 2203,
		phy_att = 367,
		mag_att = 550,
		phy_def = 550,
		mag_def = 826,
		crit = 367,
		ten = 550,
		hit = 367,
		dodge = 0,
		act_speed = 183,
		seal_hit = 367,
		seal_resis = 367,
		mp_lim = 1101
};

get(69) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 69,
		hp_lim = 2235,
		phy_att = 372,
		mag_att = 558,
		phy_def = 558,
		mag_def = 838,
		crit = 372,
		ten = 558,
		hit = 372,
		dodge = 0,
		act_speed = 186,
		seal_hit = 372,
		seal_resis = 372,
		mp_lim = 1117
};

get(70) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 70,
		hp_lim = 2268,
		phy_att = 378,
		mag_att = 567,
		phy_def = 567,
		mag_def = 850,
		crit = 378,
		ten = 567,
		hit = 378,
		dodge = 0,
		act_speed = 189,
		seal_hit = 378,
		seal_resis = 378,
		mp_lim = 1134
};

get(71) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 71,
		hp_lim = 2300,
		phy_att = 383,
		mag_att = 575,
		phy_def = 575,
		mag_def = 862,
		crit = 383,
		ten = 575,
		hit = 383,
		dodge = 0,
		act_speed = 191,
		seal_hit = 383,
		seal_resis = 383,
		mp_lim = 1150
};

get(72) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 72,
		hp_lim = 2332,
		phy_att = 388,
		mag_att = 583,
		phy_def = 583,
		mag_def = 874,
		crit = 388,
		ten = 583,
		hit = 388,
		dodge = 0,
		act_speed = 194,
		seal_hit = 388,
		seal_resis = 388,
		mp_lim = 1166
};

get(73) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 73,
		hp_lim = 2365,
		phy_att = 394,
		mag_att = 591,
		phy_def = 591,
		mag_def = 886,
		crit = 394,
		ten = 591,
		hit = 394,
		dodge = 0,
		act_speed = 197,
		seal_hit = 394,
		seal_resis = 394,
		mp_lim = 1182
};

get(74) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 74,
		hp_lim = 2397,
		phy_att = 399,
		mag_att = 599,
		phy_def = 599,
		mag_def = 899,
		crit = 399,
		ten = 599,
		hit = 399,
		dodge = 0,
		act_speed = 199,
		seal_hit = 399,
		seal_resis = 399,
		mp_lim = 1198
};

get(75) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 75,
		hp_lim = 2430,
		phy_att = 405,
		mag_att = 607,
		phy_def = 607,
		mag_def = 911,
		crit = 405,
		ten = 607,
		hit = 405,
		dodge = 0,
		act_speed = 202,
		seal_hit = 405,
		seal_resis = 405,
		mp_lim = 1215
};

get(76) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 76,
		hp_lim = 2462,
		phy_att = 410,
		mag_att = 615,
		phy_def = 615,
		mag_def = 923,
		crit = 410,
		ten = 615,
		hit = 410,
		dodge = 0,
		act_speed = 205,
		seal_hit = 410,
		seal_resis = 410,
		mp_lim = 1231
};

get(77) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 77,
		hp_lim = 2494,
		phy_att = 415,
		mag_att = 623,
		phy_def = 623,
		mag_def = 935,
		crit = 415,
		ten = 623,
		hit = 415,
		dodge = 0,
		act_speed = 207,
		seal_hit = 415,
		seal_resis = 415,
		mp_lim = 1247
};

get(78) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 78,
		hp_lim = 2527,
		phy_att = 421,
		mag_att = 631,
		phy_def = 631,
		mag_def = 947,
		crit = 421,
		ten = 631,
		hit = 421,
		dodge = 0,
		act_speed = 210,
		seal_hit = 421,
		seal_resis = 421,
		mp_lim = 1263
};

get(79) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 79,
		hp_lim = 2559,
		phy_att = 426,
		mag_att = 639,
		phy_def = 639,
		mag_def = 959,
		crit = 426,
		ten = 639,
		hit = 426,
		dodge = 0,
		act_speed = 213,
		seal_hit = 426,
		seal_resis = 426,
		mp_lim = 1279
};

get(80) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 80,
		hp_lim = 2592,
		phy_att = 432,
		mag_att = 648,
		phy_def = 648,
		mag_def = 972,
		crit = 432,
		ten = 648,
		hit = 432,
		dodge = 0,
		act_speed = 216,
		seal_hit = 432,
		seal_resis = 432,
		mp_lim = 1296
};

get(81) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 81,
		hp_lim = 2624,
		phy_att = 437,
		mag_att = 656,
		phy_def = 656,
		mag_def = 984,
		crit = 437,
		ten = 656,
		hit = 437,
		dodge = 0,
		act_speed = 218,
		seal_hit = 437,
		seal_resis = 437,
		mp_lim = 1312
};

get(82) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 82,
		hp_lim = 2656,
		phy_att = 442,
		mag_att = 664,
		phy_def = 664,
		mag_def = 996,
		crit = 442,
		ten = 664,
		hit = 442,
		dodge = 0,
		act_speed = 221,
		seal_hit = 442,
		seal_resis = 442,
		mp_lim = 1328
};

get(83) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 83,
		hp_lim = 2689,
		phy_att = 448,
		mag_att = 672,
		phy_def = 672,
		mag_def = 1008,
		crit = 448,
		ten = 672,
		hit = 448,
		dodge = 0,
		act_speed = 224,
		seal_hit = 448,
		seal_resis = 448,
		mp_lim = 1344
};

get(84) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 84,
		hp_lim = 2721,
		phy_att = 453,
		mag_att = 680,
		phy_def = 680,
		mag_def = 1020,
		crit = 453,
		ten = 680,
		hit = 453,
		dodge = 0,
		act_speed = 226,
		seal_hit = 453,
		seal_resis = 453,
		mp_lim = 1360
};

get(85) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 85,
		hp_lim = 2754,
		phy_att = 459,
		mag_att = 688,
		phy_def = 688,
		mag_def = 1032,
		crit = 459,
		ten = 688,
		hit = 459,
		dodge = 0,
		act_speed = 229,
		seal_hit = 459,
		seal_resis = 459,
		mp_lim = 1377
};

get(86) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 86,
		hp_lim = 2786,
		phy_att = 464,
		mag_att = 696,
		phy_def = 696,
		mag_def = 1044,
		crit = 464,
		ten = 696,
		hit = 464,
		dodge = 0,
		act_speed = 232,
		seal_hit = 464,
		seal_resis = 464,
		mp_lim = 1393
};

get(87) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 87,
		hp_lim = 2818,
		phy_att = 469,
		mag_att = 704,
		phy_def = 704,
		mag_def = 1057,
		crit = 469,
		ten = 704,
		hit = 469,
		dodge = 0,
		act_speed = 234,
		seal_hit = 469,
		seal_resis = 469,
		mp_lim = 1409
};

get(88) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 88,
		hp_lim = 2851,
		phy_att = 475,
		mag_att = 712,
		phy_def = 712,
		mag_def = 1069,
		crit = 475,
		ten = 712,
		hit = 475,
		dodge = 0,
		act_speed = 237,
		seal_hit = 475,
		seal_resis = 475,
		mp_lim = 1425
};

get(89) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 89,
		hp_lim = 2883,
		phy_att = 480,
		mag_att = 720,
		phy_def = 720,
		mag_def = 1081,
		crit = 480,
		ten = 720,
		hit = 480,
		dodge = 0,
		act_speed = 240,
		seal_hit = 480,
		seal_resis = 480,
		mp_lim = 1441
};

get(90) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 90,
		hp_lim = 2916,
		phy_att = 486,
		mag_att = 729,
		phy_def = 729,
		mag_def = 1093,
		crit = 486,
		ten = 729,
		hit = 486,
		dodge = 0,
		act_speed = 243,
		seal_hit = 486,
		seal_resis = 486,
		mp_lim = 1458
};

get(91) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 91,
		hp_lim = 2948,
		phy_att = 491,
		mag_att = 737,
		phy_def = 737,
		mag_def = 1105,
		crit = 491,
		ten = 737,
		hit = 491,
		dodge = 0,
		act_speed = 245,
		seal_hit = 491,
		seal_resis = 491,
		mp_lim = 1474
};

get(92) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 92,
		hp_lim = 2980,
		phy_att = 496,
		mag_att = 745,
		phy_def = 745,
		mag_def = 1117,
		crit = 496,
		ten = 745,
		hit = 496,
		dodge = 0,
		act_speed = 248,
		seal_hit = 496,
		seal_resis = 496,
		mp_lim = 1490
};

get(93) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 93,
		hp_lim = 3013,
		phy_att = 502,
		mag_att = 753,
		phy_def = 753,
		mag_def = 1129,
		crit = 502,
		ten = 753,
		hit = 502,
		dodge = 0,
		act_speed = 251,
		seal_hit = 502,
		seal_resis = 502,
		mp_lim = 1506
};

get(94) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 94,
		hp_lim = 3045,
		phy_att = 507,
		mag_att = 761,
		phy_def = 761,
		mag_def = 1142,
		crit = 507,
		ten = 761,
		hit = 507,
		dodge = 0,
		act_speed = 253,
		seal_hit = 507,
		seal_resis = 507,
		mp_lim = 1522
};

get(95) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 95,
		hp_lim = 3078,
		phy_att = 513,
		mag_att = 769,
		phy_def = 769,
		mag_def = 1154,
		crit = 513,
		ten = 769,
		hit = 513,
		dodge = 0,
		act_speed = 256,
		seal_hit = 513,
		seal_resis = 513,
		mp_lim = 1539
};

get(96) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 96,
		hp_lim = 3110,
		phy_att = 518,
		mag_att = 777,
		phy_def = 777,
		mag_def = 1166,
		crit = 518,
		ten = 777,
		hit = 518,
		dodge = 0,
		act_speed = 259,
		seal_hit = 518,
		seal_resis = 518,
		mp_lim = 1555
};

get(97) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 97,
		hp_lim = 3142,
		phy_att = 523,
		mag_att = 785,
		phy_def = 785,
		mag_def = 1178,
		crit = 523,
		ten = 785,
		hit = 523,
		dodge = 0,
		act_speed = 261,
		seal_hit = 523,
		seal_resis = 523,
		mp_lim = 1571
};

get(98) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 98,
		hp_lim = 3175,
		phy_att = 529,
		mag_att = 793,
		phy_def = 793,
		mag_def = 1190,
		crit = 529,
		ten = 793,
		hit = 529,
		dodge = 0,
		act_speed = 264,
		seal_hit = 529,
		seal_resis = 529,
		mp_lim = 1587
};

get(99) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 99,
		hp_lim = 3207,
		phy_att = 534,
		mag_att = 801,
		phy_def = 801,
		mag_def = 1202,
		crit = 534,
		ten = 801,
		hit = 534,
		dodge = 0,
		act_speed = 267,
		seal_hit = 534,
		seal_resis = 534,
		mp_lim = 1603
};

get(100) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 100,
		hp_lim = 3240,
		phy_att = 540,
		mag_att = 810,
		phy_def = 810,
		mag_def = 1215,
		crit = 540,
		ten = 810,
		hit = 540,
		dodge = 0,
		act_speed = 270,
		seal_hit = 540,
		seal_resis = 540,
		mp_lim = 1620
};

get(101) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 101,
		hp_lim = 3272,
		phy_att = 545,
		mag_att = 818,
		phy_def = 818,
		mag_def = 1227,
		crit = 545,
		ten = 818,
		hit = 545,
		dodge = 0,
		act_speed = 272,
		seal_hit = 545,
		seal_resis = 545,
		mp_lim = 1636
};

get(102) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 102,
		hp_lim = 3304,
		phy_att = 550,
		mag_att = 826,
		phy_def = 826,
		mag_def = 1239,
		crit = 550,
		ten = 826,
		hit = 550,
		dodge = 0,
		act_speed = 275,
		seal_hit = 550,
		seal_resis = 550,
		mp_lim = 1652
};

get(103) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 103,
		hp_lim = 3337,
		phy_att = 556,
		mag_att = 834,
		phy_def = 834,
		mag_def = 1251,
		crit = 556,
		ten = 834,
		hit = 556,
		dodge = 0,
		act_speed = 278,
		seal_hit = 556,
		seal_resis = 556,
		mp_lim = 1668
};

get(104) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 104,
		hp_lim = 3369,
		phy_att = 561,
		mag_att = 842,
		phy_def = 842,
		mag_def = 1263,
		crit = 561,
		ten = 842,
		hit = 561,
		dodge = 0,
		act_speed = 280,
		seal_hit = 561,
		seal_resis = 561,
		mp_lim = 1684
};

get(105) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 105,
		hp_lim = 3402,
		phy_att = 567,
		mag_att = 850,
		phy_def = 850,
		mag_def = 1275,
		crit = 567,
		ten = 850,
		hit = 567,
		dodge = 0,
		act_speed = 283,
		seal_hit = 567,
		seal_resis = 567,
		mp_lim = 1701
};

get(106) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 106,
		hp_lim = 3434,
		phy_att = 572,
		mag_att = 858,
		phy_def = 858,
		mag_def = 1287,
		crit = 572,
		ten = 858,
		hit = 572,
		dodge = 0,
		act_speed = 286,
		seal_hit = 572,
		seal_resis = 572,
		mp_lim = 1717
};

get(107) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 107,
		hp_lim = 3466,
		phy_att = 577,
		mag_att = 866,
		phy_def = 866,
		mag_def = 1300,
		crit = 577,
		ten = 866,
		hit = 577,
		dodge = 0,
		act_speed = 288,
		seal_hit = 577,
		seal_resis = 577,
		mp_lim = 1733
};

get(108) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 108,
		hp_lim = 3499,
		phy_att = 583,
		mag_att = 874,
		phy_def = 874,
		mag_def = 1312,
		crit = 583,
		ten = 874,
		hit = 583,
		dodge = 0,
		act_speed = 291,
		seal_hit = 583,
		seal_resis = 583,
		mp_lim = 1749
};

get(109) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 109,
		hp_lim = 3531,
		phy_att = 588,
		mag_att = 882,
		phy_def = 882,
		mag_def = 1324,
		crit = 588,
		ten = 882,
		hit = 588,
		dodge = 0,
		act_speed = 294,
		seal_hit = 588,
		seal_resis = 588,
		mp_lim = 1765
};

get(110) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 110,
		hp_lim = 3564,
		phy_att = 594,
		mag_att = 891,
		phy_def = 891,
		mag_def = 1336,
		crit = 594,
		ten = 891,
		hit = 594,
		dodge = 0,
		act_speed = 297,
		seal_hit = 594,
		seal_resis = 594,
		mp_lim = 1782
};

get(111) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 111,
		hp_lim = 3596,
		phy_att = 599,
		mag_att = 899,
		phy_def = 899,
		mag_def = 1348,
		crit = 599,
		ten = 899,
		hit = 599,
		dodge = 0,
		act_speed = 299,
		seal_hit = 599,
		seal_resis = 599,
		mp_lim = 1798
};

get(112) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 112,
		hp_lim = 3628,
		phy_att = 604,
		mag_att = 907,
		phy_def = 907,
		mag_def = 1360,
		crit = 604,
		ten = 907,
		hit = 604,
		dodge = 0,
		act_speed = 302,
		seal_hit = 604,
		seal_resis = 604,
		mp_lim = 1814
};

get(113) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 113,
		hp_lim = 3661,
		phy_att = 610,
		mag_att = 915,
		phy_def = 915,
		mag_def = 1372,
		crit = 610,
		ten = 915,
		hit = 610,
		dodge = 0,
		act_speed = 305,
		seal_hit = 610,
		seal_resis = 610,
		mp_lim = 1830
};

get(114) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 114,
		hp_lim = 3693,
		phy_att = 615,
		mag_att = 923,
		phy_def = 923,
		mag_def = 1385,
		crit = 615,
		ten = 923,
		hit = 615,
		dodge = 0,
		act_speed = 307,
		seal_hit = 615,
		seal_resis = 615,
		mp_lim = 1846
};

get(115) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 115,
		hp_lim = 3726,
		phy_att = 621,
		mag_att = 931,
		phy_def = 931,
		mag_def = 1397,
		crit = 621,
		ten = 931,
		hit = 621,
		dodge = 0,
		act_speed = 310,
		seal_hit = 621,
		seal_resis = 621,
		mp_lim = 1863
};

get(116) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 116,
		hp_lim = 3758,
		phy_att = 626,
		mag_att = 939,
		phy_def = 939,
		mag_def = 1409,
		crit = 626,
		ten = 939,
		hit = 626,
		dodge = 0,
		act_speed = 313,
		seal_hit = 626,
		seal_resis = 626,
		mp_lim = 1879
};

get(117) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 117,
		hp_lim = 3790,
		phy_att = 631,
		mag_att = 947,
		phy_def = 947,
		mag_def = 1421,
		crit = 631,
		ten = 947,
		hit = 631,
		dodge = 0,
		act_speed = 315,
		seal_hit = 631,
		seal_resis = 631,
		mp_lim = 1895
};

get(118) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 118,
		hp_lim = 3823,
		phy_att = 637,
		mag_att = 955,
		phy_def = 955,
		mag_def = 1433,
		crit = 637,
		ten = 955,
		hit = 637,
		dodge = 0,
		act_speed = 318,
		seal_hit = 637,
		seal_resis = 637,
		mp_lim = 1911
};

get(119) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 119,
		hp_lim = 3855,
		phy_att = 642,
		mag_att = 963,
		phy_def = 963,
		mag_def = 1445,
		crit = 642,
		ten = 963,
		hit = 642,
		dodge = 0,
		act_speed = 321,
		seal_hit = 642,
		seal_resis = 642,
		mp_lim = 1927
};

get(120) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 120,
		hp_lim = 3888,
		phy_att = 648,
		mag_att = 972,
		phy_def = 972,
		mag_def = 1458,
		crit = 648,
		ten = 972,
		hit = 648,
		dodge = 0,
		act_speed = 324,
		seal_hit = 648,
		seal_resis = 648,
		mp_lim = 1944
};

get(121) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 121,
		hp_lim = 3920,
		phy_att = 653,
		mag_att = 980,
		phy_def = 980,
		mag_def = 1470,
		crit = 653,
		ten = 980,
		hit = 653,
		dodge = 0,
		act_speed = 326,
		seal_hit = 653,
		seal_resis = 653,
		mp_lim = 1960
};

get(122) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 122,
		hp_lim = 3952,
		phy_att = 658,
		mag_att = 988,
		phy_def = 988,
		mag_def = 1482,
		crit = 658,
		ten = 988,
		hit = 658,
		dodge = 0,
		act_speed = 329,
		seal_hit = 658,
		seal_resis = 658,
		mp_lim = 1976
};

get(123) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 123,
		hp_lim = 3985,
		phy_att = 664,
		mag_att = 996,
		phy_def = 996,
		mag_def = 1494,
		crit = 664,
		ten = 996,
		hit = 664,
		dodge = 0,
		act_speed = 332,
		seal_hit = 664,
		seal_resis = 664,
		mp_lim = 1992
};

get(124) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 124,
		hp_lim = 4017,
		phy_att = 669,
		mag_att = 1004,
		phy_def = 1004,
		mag_def = 1506,
		crit = 669,
		ten = 1004,
		hit = 669,
		dodge = 0,
		act_speed = 334,
		seal_hit = 669,
		seal_resis = 669,
		mp_lim = 2008
};

get(125) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 125,
		hp_lim = 4050,
		phy_att = 675,
		mag_att = 1012,
		phy_def = 1012,
		mag_def = 1518,
		crit = 675,
		ten = 1012,
		hit = 675,
		dodge = 0,
		act_speed = 337,
		seal_hit = 675,
		seal_resis = 675,
		mp_lim = 2025
};

get(126) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 126,
		hp_lim = 4082,
		phy_att = 680,
		mag_att = 1020,
		phy_def = 1020,
		mag_def = 1530,
		crit = 680,
		ten = 1020,
		hit = 680,
		dodge = 0,
		act_speed = 340,
		seal_hit = 680,
		seal_resis = 680,
		mp_lim = 2041
};

get(127) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 127,
		hp_lim = 4114,
		phy_att = 685,
		mag_att = 1028,
		phy_def = 1028,
		mag_def = 1543,
		crit = 685,
		ten = 1028,
		hit = 685,
		dodge = 0,
		act_speed = 342,
		seal_hit = 685,
		seal_resis = 685,
		mp_lim = 2057
};

get(128) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 128,
		hp_lim = 4147,
		phy_att = 691,
		mag_att = 1036,
		phy_def = 1036,
		mag_def = 1555,
		crit = 691,
		ten = 1036,
		hit = 691,
		dodge = 0,
		act_speed = 345,
		seal_hit = 691,
		seal_resis = 691,
		mp_lim = 2073
};

get(129) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 129,
		hp_lim = 4179,
		phy_att = 696,
		mag_att = 1044,
		phy_def = 1044,
		mag_def = 1567,
		crit = 696,
		ten = 1044,
		hit = 696,
		dodge = 0,
		act_speed = 348,
		seal_hit = 696,
		seal_resis = 696,
		mp_lim = 2089
};

get(130) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 130,
		hp_lim = 4212,
		phy_att = 702,
		mag_att = 1053,
		phy_def = 1053,
		mag_def = 1579,
		crit = 702,
		ten = 1053,
		hit = 702,
		dodge = 0,
		act_speed = 351,
		seal_hit = 702,
		seal_resis = 702,
		mp_lim = 2106
};

get(131) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 131,
		hp_lim = 4244,
		phy_att = 707,
		mag_att = 1061,
		phy_def = 1061,
		mag_def = 1591,
		crit = 707,
		ten = 1061,
		hit = 707,
		dodge = 0,
		act_speed = 353,
		seal_hit = 707,
		seal_resis = 707,
		mp_lim = 2122
};

get(132) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 132,
		hp_lim = 4276,
		phy_att = 712,
		mag_att = 1069,
		phy_def = 1069,
		mag_def = 1603,
		crit = 712,
		ten = 1069,
		hit = 712,
		dodge = 0,
		act_speed = 356,
		seal_hit = 712,
		seal_resis = 712,
		mp_lim = 2138
};

get(133) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 133,
		hp_lim = 4309,
		phy_att = 718,
		mag_att = 1077,
		phy_def = 1077,
		mag_def = 1615,
		crit = 718,
		ten = 1077,
		hit = 718,
		dodge = 0,
		act_speed = 359,
		seal_hit = 718,
		seal_resis = 718,
		mp_lim = 2154
};

get(134) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 134,
		hp_lim = 4341,
		phy_att = 723,
		mag_att = 1085,
		phy_def = 1085,
		mag_def = 1628,
		crit = 723,
		ten = 1085,
		hit = 723,
		dodge = 0,
		act_speed = 361,
		seal_hit = 723,
		seal_resis = 723,
		mp_lim = 2170
};

get(135) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 135,
		hp_lim = 4374,
		phy_att = 729,
		mag_att = 1093,
		phy_def = 1093,
		mag_def = 1640,
		crit = 729,
		ten = 1093,
		hit = 729,
		dodge = 0,
		act_speed = 364,
		seal_hit = 729,
		seal_resis = 729,
		mp_lim = 2187
};

get(136) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 136,
		hp_lim = 4406,
		phy_att = 734,
		mag_att = 1101,
		phy_def = 1101,
		mag_def = 1652,
		crit = 734,
		ten = 1101,
		hit = 734,
		dodge = 0,
		act_speed = 367,
		seal_hit = 734,
		seal_resis = 734,
		mp_lim = 2203
};

get(137) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 137,
		hp_lim = 4438,
		phy_att = 739,
		mag_att = 1109,
		phy_def = 1109,
		mag_def = 1664,
		crit = 739,
		ten = 1109,
		hit = 739,
		dodge = 0,
		act_speed = 369,
		seal_hit = 739,
		seal_resis = 739,
		mp_lim = 2219
};

get(138) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 138,
		hp_lim = 4471,
		phy_att = 745,
		mag_att = 1117,
		phy_def = 1117,
		mag_def = 1676,
		crit = 745,
		ten = 1117,
		hit = 745,
		dodge = 0,
		act_speed = 372,
		seal_hit = 745,
		seal_resis = 745,
		mp_lim = 2235
};

get(139) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 139,
		hp_lim = 4503,
		phy_att = 750,
		mag_att = 1125,
		phy_def = 1125,
		mag_def = 1688,
		crit = 750,
		ten = 1125,
		hit = 750,
		dodge = 0,
		act_speed = 375,
		seal_hit = 750,
		seal_resis = 750,
		mp_lim = 2251
};

get(140) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 140,
		hp_lim = 4536,
		phy_att = 756,
		mag_att = 1134,
		phy_def = 1134,
		mag_def = 1701,
		crit = 756,
		ten = 1134,
		hit = 756,
		dodge = 0,
		act_speed = 378,
		seal_hit = 756,
		seal_resis = 756,
		mp_lim = 2268
};

get(141) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 141,
		hp_lim = 4568,
		phy_att = 761,
		mag_att = 1142,
		phy_def = 1142,
		mag_def = 1713,
		crit = 761,
		ten = 1142,
		hit = 761,
		dodge = 0,
		act_speed = 380,
		seal_hit = 761,
		seal_resis = 761,
		mp_lim = 2284
};

get(142) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 142,
		hp_lim = 4600,
		phy_att = 766,
		mag_att = 1150,
		phy_def = 1150,
		mag_def = 1725,
		crit = 766,
		ten = 1150,
		hit = 766,
		dodge = 0,
		act_speed = 383,
		seal_hit = 766,
		seal_resis = 766,
		mp_lim = 2300
};

get(143) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 143,
		hp_lim = 4633,
		phy_att = 772,
		mag_att = 1158,
		phy_def = 1158,
		mag_def = 1737,
		crit = 772,
		ten = 1158,
		hit = 772,
		dodge = 0,
		act_speed = 386,
		seal_hit = 772,
		seal_resis = 772,
		mp_lim = 2316
};

get(144) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 144,
		hp_lim = 4665,
		phy_att = 777,
		mag_att = 1166,
		phy_def = 1166,
		mag_def = 1749,
		crit = 777,
		ten = 1166,
		hit = 777,
		dodge = 0,
		act_speed = 388,
		seal_hit = 777,
		seal_resis = 777,
		mp_lim = 2332
};

get(145) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 145,
		hp_lim = 4698,
		phy_att = 783,
		mag_att = 1174,
		phy_def = 1174,
		mag_def = 1761,
		crit = 783,
		ten = 1174,
		hit = 783,
		dodge = 0,
		act_speed = 391,
		seal_hit = 783,
		seal_resis = 783,
		mp_lim = 2349
};

get(146) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 146,
		hp_lim = 4730,
		phy_att = 788,
		mag_att = 1182,
		phy_def = 1182,
		mag_def = 1773,
		crit = 788,
		ten = 1182,
		hit = 788,
		dodge = 0,
		act_speed = 394,
		seal_hit = 788,
		seal_resis = 788,
		mp_lim = 2365
};

get(147) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 147,
		hp_lim = 4762,
		phy_att = 793,
		mag_att = 1190,
		phy_def = 1190,
		mag_def = 1786,
		crit = 793,
		ten = 1190,
		hit = 793,
		dodge = 0,
		act_speed = 396,
		seal_hit = 793,
		seal_resis = 793,
		mp_lim = 2381
};

get(148) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 148,
		hp_lim = 4795,
		phy_att = 799,
		mag_att = 1198,
		phy_def = 1198,
		mag_def = 1798,
		crit = 799,
		ten = 1198,
		hit = 799,
		dodge = 0,
		act_speed = 399,
		seal_hit = 799,
		seal_resis = 799,
		mp_lim = 2397
};

get(149) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 149,
		hp_lim = 4827,
		phy_att = 804,
		mag_att = 1206,
		phy_def = 1206,
		mag_def = 1810,
		crit = 804,
		ten = 1206,
		hit = 804,
		dodge = 0,
		act_speed = 402,
		seal_hit = 804,
		seal_resis = 804,
		mp_lim = 2413
};

get(150) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 150,
		hp_lim = 4860,
		phy_att = 810,
		mag_att = 1215,
		phy_def = 1215,
		mag_def = 1822,
		crit = 810,
		ten = 1215,
		hit = 810,
		dodge = 0,
		act_speed = 405,
		seal_hit = 810,
		seal_resis = 810,
		mp_lim = 2430
};

get(151) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 151,
		hp_lim = 4893,
		phy_att = 816,
		mag_att = 1224,
		phy_def = 1224,
		mag_def = 1834,
		crit = 816,
		ten = 1224,
		hit = 816,
		dodge = 0,
		act_speed = 408,
		seal_hit = 816,
		seal_resis = 816,
		mp_lim = 2447
};

get(152) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 152,
		hp_lim = 4926,
		phy_att = 822,
		mag_att = 1233,
		phy_def = 1233,
		mag_def = 1846,
		crit = 822,
		ten = 1233,
		hit = 822,
		dodge = 0,
		act_speed = 411,
		seal_hit = 822,
		seal_resis = 822,
		mp_lim = 2464
};

get(153) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 153,
		hp_lim = 4959,
		phy_att = 828,
		mag_att = 1242,
		phy_def = 1242,
		mag_def = 1858,
		crit = 828,
		ten = 1242,
		hit = 828,
		dodge = 0,
		act_speed = 414,
		seal_hit = 828,
		seal_resis = 828,
		mp_lim = 2481
};

get(154) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 154,
		hp_lim = 4992,
		phy_att = 834,
		mag_att = 1251,
		phy_def = 1251,
		mag_def = 1870,
		crit = 834,
		ten = 1251,
		hit = 834,
		dodge = 0,
		act_speed = 417,
		seal_hit = 834,
		seal_resis = 834,
		mp_lim = 2498
};

get(155) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 155,
		hp_lim = 5025,
		phy_att = 840,
		mag_att = 1260,
		phy_def = 1260,
		mag_def = 1882,
		crit = 840,
		ten = 1260,
		hit = 840,
		dodge = 0,
		act_speed = 420,
		seal_hit = 840,
		seal_resis = 840,
		mp_lim = 2515
};

get(156) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 156,
		hp_lim = 5058,
		phy_att = 846,
		mag_att = 1269,
		phy_def = 1269,
		mag_def = 1894,
		crit = 846,
		ten = 1269,
		hit = 846,
		dodge = 0,
		act_speed = 423,
		seal_hit = 846,
		seal_resis = 846,
		mp_lim = 2532
};

get(157) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 157,
		hp_lim = 5091,
		phy_att = 852,
		mag_att = 1278,
		phy_def = 1278,
		mag_def = 1906,
		crit = 852,
		ten = 1278,
		hit = 852,
		dodge = 0,
		act_speed = 426,
		seal_hit = 852,
		seal_resis = 852,
		mp_lim = 2549
};

get(158) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 158,
		hp_lim = 5124,
		phy_att = 858,
		mag_att = 1287,
		phy_def = 1287,
		mag_def = 1918,
		crit = 858,
		ten = 1287,
		hit = 858,
		dodge = 0,
		act_speed = 429,
		seal_hit = 858,
		seal_resis = 858,
		mp_lim = 2566
};

get(159) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 159,
		hp_lim = 5157,
		phy_att = 864,
		mag_att = 1296,
		phy_def = 1296,
		mag_def = 1930,
		crit = 864,
		ten = 1296,
		hit = 864,
		dodge = 0,
		act_speed = 432,
		seal_hit = 864,
		seal_resis = 864,
		mp_lim = 2583
};

get(160) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 160,
		hp_lim = 5190,
		phy_att = 870,
		mag_att = 1305,
		phy_def = 1305,
		mag_def = 1942,
		crit = 870,
		ten = 1305,
		hit = 870,
		dodge = 0,
		act_speed = 435,
		seal_hit = 870,
		seal_resis = 870,
		mp_lim = 2600
};

get(161) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 161,
		hp_lim = 5223,
		phy_att = 876,
		mag_att = 1314,
		phy_def = 1314,
		mag_def = 1954,
		crit = 876,
		ten = 1314,
		hit = 876,
		dodge = 0,
		act_speed = 438,
		seal_hit = 876,
		seal_resis = 876,
		mp_lim = 2617
};

get(162) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 162,
		hp_lim = 5256,
		phy_att = 882,
		mag_att = 1323,
		phy_def = 1323,
		mag_def = 1966,
		crit = 882,
		ten = 1323,
		hit = 882,
		dodge = 0,
		act_speed = 441,
		seal_hit = 882,
		seal_resis = 882,
		mp_lim = 2634
};

get(163) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 163,
		hp_lim = 5289,
		phy_att = 888,
		mag_att = 1332,
		phy_def = 1332,
		mag_def = 1978,
		crit = 888,
		ten = 1332,
		hit = 888,
		dodge = 0,
		act_speed = 444,
		seal_hit = 888,
		seal_resis = 888,
		mp_lim = 2651
};

get(164) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 164,
		hp_lim = 5322,
		phy_att = 894,
		mag_att = 1341,
		phy_def = 1341,
		mag_def = 1990,
		crit = 894,
		ten = 1341,
		hit = 894,
		dodge = 0,
		act_speed = 447,
		seal_hit = 894,
		seal_resis = 894,
		mp_lim = 2668
};

get(165) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 165,
		hp_lim = 5355,
		phy_att = 900,
		mag_att = 1350,
		phy_def = 1350,
		mag_def = 2002,
		crit = 900,
		ten = 1350,
		hit = 900,
		dodge = 0,
		act_speed = 450,
		seal_hit = 900,
		seal_resis = 900,
		mp_lim = 2685
};

get(166) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 166,
		hp_lim = 5388,
		phy_att = 906,
		mag_att = 1359,
		phy_def = 1359,
		mag_def = 2014,
		crit = 906,
		ten = 1359,
		hit = 906,
		dodge = 0,
		act_speed = 453,
		seal_hit = 906,
		seal_resis = 906,
		mp_lim = 2702
};

get(167) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 167,
		hp_lim = 5421,
		phy_att = 912,
		mag_att = 1368,
		phy_def = 1368,
		mag_def = 2026,
		crit = 912,
		ten = 1368,
		hit = 912,
		dodge = 0,
		act_speed = 456,
		seal_hit = 912,
		seal_resis = 912,
		mp_lim = 2719
};

get(168) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 168,
		hp_lim = 5454,
		phy_att = 918,
		mag_att = 1377,
		phy_def = 1377,
		mag_def = 2038,
		crit = 918,
		ten = 1377,
		hit = 918,
		dodge = 0,
		act_speed = 459,
		seal_hit = 918,
		seal_resis = 918,
		mp_lim = 2736
};

get(169) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 169,
		hp_lim = 5487,
		phy_att = 924,
		mag_att = 1386,
		phy_def = 1386,
		mag_def = 2050,
		crit = 924,
		ten = 1386,
		hit = 924,
		dodge = 0,
		act_speed = 462,
		seal_hit = 924,
		seal_resis = 924,
		mp_lim = 2753
};

get(170) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 170,
		hp_lim = 5520,
		phy_att = 930,
		mag_att = 1395,
		phy_def = 1395,
		mag_def = 2062,
		crit = 930,
		ten = 1395,
		hit = 930,
		dodge = 0,
		act_speed = 465,
		seal_hit = 930,
		seal_resis = 930,
		mp_lim = 2770
};

get(171) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 171,
		hp_lim = 5553,
		phy_att = 936,
		mag_att = 1404,
		phy_def = 1404,
		mag_def = 2074,
		crit = 936,
		ten = 1404,
		hit = 936,
		dodge = 0,
		act_speed = 468,
		seal_hit = 936,
		seal_resis = 936,
		mp_lim = 2787
};

get(172) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 172,
		hp_lim = 5586,
		phy_att = 942,
		mag_att = 1413,
		phy_def = 1413,
		mag_def = 2086,
		crit = 942,
		ten = 1413,
		hit = 942,
		dodge = 0,
		act_speed = 471,
		seal_hit = 942,
		seal_resis = 942,
		mp_lim = 2804
};

get(173) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 173,
		hp_lim = 5619,
		phy_att = 948,
		mag_att = 1422,
		phy_def = 1422,
		mag_def = 2098,
		crit = 948,
		ten = 1422,
		hit = 948,
		dodge = 0,
		act_speed = 474,
		seal_hit = 948,
		seal_resis = 948,
		mp_lim = 2821
};

get(174) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 174,
		hp_lim = 5652,
		phy_att = 954,
		mag_att = 1431,
		phy_def = 1431,
		mag_def = 2110,
		crit = 954,
		ten = 1431,
		hit = 954,
		dodge = 0,
		act_speed = 477,
		seal_hit = 954,
		seal_resis = 954,
		mp_lim = 2838
};

get(175) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 175,
		hp_lim = 5685,
		phy_att = 960,
		mag_att = 1440,
		phy_def = 1440,
		mag_def = 2122,
		crit = 960,
		ten = 1440,
		hit = 960,
		dodge = 0,
		act_speed = 480,
		seal_hit = 960,
		seal_resis = 960,
		mp_lim = 2855
};

get(176) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 176,
		hp_lim = 5718,
		phy_att = 966,
		mag_att = 1449,
		phy_def = 1449,
		mag_def = 2134,
		crit = 966,
		ten = 1449,
		hit = 966,
		dodge = 0,
		act_speed = 483,
		seal_hit = 966,
		seal_resis = 966,
		mp_lim = 2872
};

get(177) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 177,
		hp_lim = 5751,
		phy_att = 972,
		mag_att = 1458,
		phy_def = 1458,
		mag_def = 2146,
		crit = 972,
		ten = 1458,
		hit = 972,
		dodge = 0,
		act_speed = 486,
		seal_hit = 972,
		seal_resis = 972,
		mp_lim = 2889
};

get(178) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 178,
		hp_lim = 5784,
		phy_att = 978,
		mag_att = 1467,
		phy_def = 1467,
		mag_def = 2158,
		crit = 978,
		ten = 1467,
		hit = 978,
		dodge = 0,
		act_speed = 489,
		seal_hit = 978,
		seal_resis = 978,
		mp_lim = 2906
};

get(179) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 179,
		hp_lim = 5817,
		phy_att = 984,
		mag_att = 1476,
		phy_def = 1476,
		mag_def = 2170,
		crit = 984,
		ten = 1476,
		hit = 984,
		dodge = 0,
		act_speed = 492,
		seal_hit = 984,
		seal_resis = 984,
		mp_lim = 2923
};

get(180) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 180,
		hp_lim = 5850,
		phy_att = 990,
		mag_att = 1485,
		phy_def = 1485,
		mag_def = 2182,
		crit = 990,
		ten = 1485,
		hit = 990,
		dodge = 0,
		act_speed = 495,
		seal_hit = 990,
		seal_resis = 990,
		mp_lim = 2940
};

get(181) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 181,
		hp_lim = 5883,
		phy_att = 996,
		mag_att = 1494,
		phy_def = 1494,
		mag_def = 2194,
		crit = 996,
		ten = 1494,
		hit = 996,
		dodge = 0,
		act_speed = 498,
		seal_hit = 996,
		seal_resis = 996,
		mp_lim = 2957
};

get(182) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 182,
		hp_lim = 5916,
		phy_att = 1002,
		mag_att = 1503,
		phy_def = 1503,
		mag_def = 2206,
		crit = 1002,
		ten = 1503,
		hit = 1002,
		dodge = 0,
		act_speed = 501,
		seal_hit = 1002,
		seal_resis = 1002,
		mp_lim = 2974
};

get(183) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 183,
		hp_lim = 5949,
		phy_att = 1008,
		mag_att = 1512,
		phy_def = 1512,
		mag_def = 2218,
		crit = 1008,
		ten = 1512,
		hit = 1008,
		dodge = 0,
		act_speed = 504,
		seal_hit = 1008,
		seal_resis = 1008,
		mp_lim = 2991
};

get(184) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 184,
		hp_lim = 5982,
		phy_att = 1014,
		mag_att = 1521,
		phy_def = 1521,
		mag_def = 2230,
		crit = 1014,
		ten = 1521,
		hit = 1014,
		dodge = 0,
		act_speed = 507,
		seal_hit = 1014,
		seal_resis = 1014,
		mp_lim = 3008
};

get(185) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 185,
		hp_lim = 6015,
		phy_att = 1020,
		mag_att = 1530,
		phy_def = 1530,
		mag_def = 2242,
		crit = 1020,
		ten = 1530,
		hit = 1020,
		dodge = 0,
		act_speed = 510,
		seal_hit = 1020,
		seal_resis = 1020,
		mp_lim = 3025
};

get(186) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 186,
		hp_lim = 6048,
		phy_att = 1026,
		mag_att = 1539,
		phy_def = 1539,
		mag_def = 2254,
		crit = 1026,
		ten = 1539,
		hit = 1026,
		dodge = 0,
		act_speed = 513,
		seal_hit = 1026,
		seal_resis = 1026,
		mp_lim = 3042
};

get(187) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 187,
		hp_lim = 6081,
		phy_att = 1032,
		mag_att = 1548,
		phy_def = 1548,
		mag_def = 2266,
		crit = 1032,
		ten = 1548,
		hit = 1032,
		dodge = 0,
		act_speed = 516,
		seal_hit = 1032,
		seal_resis = 1032,
		mp_lim = 3059
};

get(188) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 188,
		hp_lim = 6114,
		phy_att = 1038,
		mag_att = 1557,
		phy_def = 1557,
		mag_def = 2278,
		crit = 1038,
		ten = 1557,
		hit = 1038,
		dodge = 0,
		act_speed = 519,
		seal_hit = 1038,
		seal_resis = 1038,
		mp_lim = 3076
};

get(189) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 189,
		hp_lim = 6147,
		phy_att = 1044,
		mag_att = 1566,
		phy_def = 1566,
		mag_def = 2290,
		crit = 1044,
		ten = 1566,
		hit = 1044,
		dodge = 0,
		act_speed = 522,
		seal_hit = 1044,
		seal_resis = 1044,
		mp_lim = 3093
};

get(190) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 190,
		hp_lim = 6180,
		phy_att = 1050,
		mag_att = 1575,
		phy_def = 1575,
		mag_def = 2302,
		crit = 1050,
		ten = 1575,
		hit = 1050,
		dodge = 0,
		act_speed = 525,
		seal_hit = 1050,
		seal_resis = 1050,
		mp_lim = 3110
};

get(191) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 191,
		hp_lim = 6213,
		phy_att = 1056,
		mag_att = 1584,
		phy_def = 1584,
		mag_def = 2314,
		crit = 1056,
		ten = 1584,
		hit = 1056,
		dodge = 0,
		act_speed = 528,
		seal_hit = 1056,
		seal_resis = 1056,
		mp_lim = 3127
};

get(192) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 192,
		hp_lim = 6246,
		phy_att = 1062,
		mag_att = 1593,
		phy_def = 1593,
		mag_def = 2326,
		crit = 1062,
		ten = 1593,
		hit = 1062,
		dodge = 0,
		act_speed = 531,
		seal_hit = 1062,
		seal_resis = 1062,
		mp_lim = 3144
};

get(193) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 193,
		hp_lim = 6279,
		phy_att = 1068,
		mag_att = 1602,
		phy_def = 1602,
		mag_def = 2338,
		crit = 1068,
		ten = 1602,
		hit = 1068,
		dodge = 0,
		act_speed = 534,
		seal_hit = 1068,
		seal_resis = 1068,
		mp_lim = 3161
};

get(194) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 194,
		hp_lim = 6312,
		phy_att = 1074,
		mag_att = 1611,
		phy_def = 1611,
		mag_def = 2350,
		crit = 1074,
		ten = 1611,
		hit = 1074,
		dodge = 0,
		act_speed = 537,
		seal_hit = 1074,
		seal_resis = 1074,
		mp_lim = 3178
};

get(195) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 195,
		hp_lim = 6345,
		phy_att = 1080,
		mag_att = 1620,
		phy_def = 1620,
		mag_def = 2362,
		crit = 1080,
		ten = 1620,
		hit = 1080,
		dodge = 0,
		act_speed = 540,
		seal_hit = 1080,
		seal_resis = 1080,
		mp_lim = 3195
};

get(196) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 196,
		hp_lim = 6378,
		phy_att = 1086,
		mag_att = 1629,
		phy_def = 1629,
		mag_def = 2374,
		crit = 1086,
		ten = 1629,
		hit = 1086,
		dodge = 0,
		act_speed = 543,
		seal_hit = 1086,
		seal_resis = 1086,
		mp_lim = 3212
};

get(197) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 197,
		hp_lim = 6411,
		phy_att = 1092,
		mag_att = 1638,
		phy_def = 1638,
		mag_def = 2386,
		crit = 1092,
		ten = 1638,
		hit = 1092,
		dodge = 0,
		act_speed = 546,
		seal_hit = 1092,
		seal_resis = 1092,
		mp_lim = 3229
};

get(198) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 198,
		hp_lim = 6444,
		phy_att = 1098,
		mag_att = 1647,
		phy_def = 1647,
		mag_def = 2398,
		crit = 1098,
		ten = 1647,
		hit = 1098,
		dodge = 0,
		act_speed = 549,
		seal_hit = 1098,
		seal_resis = 1098,
		mp_lim = 3246
};

get(199) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 199,
		hp_lim = 6477,
		phy_att = 1104,
		mag_att = 1656,
		phy_def = 1656,
		mag_def = 2410,
		crit = 1104,
		ten = 1656,
		hit = 1104,
		dodge = 0,
		act_speed = 552,
		seal_hit = 1104,
		seal_resis = 1104,
		mp_lim = 3263
};

get(200) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 200,
		hp_lim = 6510,
		phy_att = 1110,
		mag_att = 1665,
		phy_def = 1665,
		mag_def = 2422,
		crit = 1110,
		ten = 1665,
		hit = 1110,
		dodge = 0,
		act_speed = 555,
		seal_hit = 1110,
		seal_resis = 1110,
		mp_lim = 3280
};

get(201) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 201,
		hp_lim = 6543,
		phy_att = 1116,
		mag_att = 1674,
		phy_def = 1674,
		mag_def = 2434,
		crit = 1116,
		ten = 1674,
		hit = 1116,
		dodge = 0,
		act_speed = 558,
		seal_hit = 1116,
		seal_resis = 1116,
		mp_lim = 3297
};

get(202) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 202,
		hp_lim = 6576,
		phy_att = 1122,
		mag_att = 1683,
		phy_def = 1683,
		mag_def = 2446,
		crit = 1122,
		ten = 1683,
		hit = 1122,
		dodge = 0,
		act_speed = 561,
		seal_hit = 1122,
		seal_resis = 1122,
		mp_lim = 3314
};

get(203) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 203,
		hp_lim = 6609,
		phy_att = 1128,
		mag_att = 1692,
		phy_def = 1692,
		mag_def = 2458,
		crit = 1128,
		ten = 1692,
		hit = 1128,
		dodge = 0,
		act_speed = 564,
		seal_hit = 1128,
		seal_resis = 1128,
		mp_lim = 3331
};

get(204) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 204,
		hp_lim = 6642,
		phy_att = 1134,
		mag_att = 1701,
		phy_def = 1701,
		mag_def = 2470,
		crit = 1134,
		ten = 1701,
		hit = 1134,
		dodge = 0,
		act_speed = 567,
		seal_hit = 1134,
		seal_resis = 1134,
		mp_lim = 3348
};

get(205) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 205,
		hp_lim = 6675,
		phy_att = 1140,
		mag_att = 1710,
		phy_def = 1710,
		mag_def = 2482,
		crit = 1140,
		ten = 1710,
		hit = 1140,
		dodge = 0,
		act_speed = 570,
		seal_hit = 1140,
		seal_resis = 1140,
		mp_lim = 3365
};

get(206) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 206,
		hp_lim = 6708,
		phy_att = 1146,
		mag_att = 1719,
		phy_def = 1719,
		mag_def = 2494,
		crit = 1146,
		ten = 1719,
		hit = 1146,
		dodge = 0,
		act_speed = 573,
		seal_hit = 1146,
		seal_resis = 1146,
		mp_lim = 3382
};

get(207) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 207,
		hp_lim = 6741,
		phy_att = 1152,
		mag_att = 1728,
		phy_def = 1728,
		mag_def = 2506,
		crit = 1152,
		ten = 1728,
		hit = 1152,
		dodge = 0,
		act_speed = 576,
		seal_hit = 1152,
		seal_resis = 1152,
		mp_lim = 3399
};

get(208) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 208,
		hp_lim = 6774,
		phy_att = 1158,
		mag_att = 1737,
		phy_def = 1737,
		mag_def = 2518,
		crit = 1158,
		ten = 1737,
		hit = 1158,
		dodge = 0,
		act_speed = 579,
		seal_hit = 1158,
		seal_resis = 1158,
		mp_lim = 3416
};

get(209) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 209,
		hp_lim = 6807,
		phy_att = 1164,
		mag_att = 1746,
		phy_def = 1746,
		mag_def = 2530,
		crit = 1164,
		ten = 1746,
		hit = 1164,
		dodge = 0,
		act_speed = 582,
		seal_hit = 1164,
		seal_resis = 1164,
		mp_lim = 3433
};

get(210) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 210,
		hp_lim = 6840,
		phy_att = 1170,
		mag_att = 1755,
		phy_def = 1755,
		mag_def = 2542,
		crit = 1170,
		ten = 1755,
		hit = 1170,
		dodge = 0,
		act_speed = 585,
		seal_hit = 1170,
		seal_resis = 1170,
		mp_lim = 3450
};

get(211) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 211,
		hp_lim = 6873,
		phy_att = 1176,
		mag_att = 1764,
		phy_def = 1764,
		mag_def = 2554,
		crit = 1176,
		ten = 1764,
		hit = 1176,
		dodge = 0,
		act_speed = 588,
		seal_hit = 1176,
		seal_resis = 1176,
		mp_lim = 3467
};

get(212) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 212,
		hp_lim = 6906,
		phy_att = 1182,
		mag_att = 1773,
		phy_def = 1773,
		mag_def = 2566,
		crit = 1182,
		ten = 1773,
		hit = 1182,
		dodge = 0,
		act_speed = 591,
		seal_hit = 1182,
		seal_resis = 1182,
		mp_lim = 3484
};

get(213) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 213,
		hp_lim = 6939,
		phy_att = 1188,
		mag_att = 1782,
		phy_def = 1782,
		mag_def = 2578,
		crit = 1188,
		ten = 1782,
		hit = 1188,
		dodge = 0,
		act_speed = 594,
		seal_hit = 1188,
		seal_resis = 1188,
		mp_lim = 3501
};

get(214) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 214,
		hp_lim = 6972,
		phy_att = 1194,
		mag_att = 1791,
		phy_def = 1791,
		mag_def = 2590,
		crit = 1194,
		ten = 1791,
		hit = 1194,
		dodge = 0,
		act_speed = 597,
		seal_hit = 1194,
		seal_resis = 1194,
		mp_lim = 3518
};

get(215) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 215,
		hp_lim = 7005,
		phy_att = 1200,
		mag_att = 1800,
		phy_def = 1800,
		mag_def = 2602,
		crit = 1200,
		ten = 1800,
		hit = 1200,
		dodge = 0,
		act_speed = 600,
		seal_hit = 1200,
		seal_resis = 1200,
		mp_lim = 3535
};

get(216) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 216,
		hp_lim = 7038,
		phy_att = 1206,
		mag_att = 1809,
		phy_def = 1809,
		mag_def = 2614,
		crit = 1206,
		ten = 1809,
		hit = 1206,
		dodge = 0,
		act_speed = 603,
		seal_hit = 1206,
		seal_resis = 1206,
		mp_lim = 3552
};

get(217) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 217,
		hp_lim = 7071,
		phy_att = 1212,
		mag_att = 1818,
		phy_def = 1818,
		mag_def = 2626,
		crit = 1212,
		ten = 1818,
		hit = 1212,
		dodge = 0,
		act_speed = 606,
		seal_hit = 1212,
		seal_resis = 1212,
		mp_lim = 3569
};

get(218) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 218,
		hp_lim = 7104,
		phy_att = 1218,
		mag_att = 1827,
		phy_def = 1827,
		mag_def = 2638,
		crit = 1218,
		ten = 1827,
		hit = 1218,
		dodge = 0,
		act_speed = 609,
		seal_hit = 1218,
		seal_resis = 1218,
		mp_lim = 3586
};

get(219) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 219,
		hp_lim = 7137,
		phy_att = 1224,
		mag_att = 1836,
		phy_def = 1836,
		mag_def = 2650,
		crit = 1224,
		ten = 1836,
		hit = 1224,
		dodge = 0,
		act_speed = 612,
		seal_hit = 1224,
		seal_resis = 1224,
		mp_lim = 3603
};

get(220) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 220,
		hp_lim = 7170,
		phy_att = 1230,
		mag_att = 1845,
		phy_def = 1845,
		mag_def = 2662,
		crit = 1230,
		ten = 1845,
		hit = 1230,
		dodge = 0,
		act_speed = 615,
		seal_hit = 1230,
		seal_resis = 1230,
		mp_lim = 3620
};

get(221) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 221,
		hp_lim = 7203,
		phy_att = 1236,
		mag_att = 1854,
		phy_def = 1854,
		mag_def = 2674,
		crit = 1236,
		ten = 1854,
		hit = 1236,
		dodge = 0,
		act_speed = 618,
		seal_hit = 1236,
		seal_resis = 1236,
		mp_lim = 3637
};

get(222) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 222,
		hp_lim = 7236,
		phy_att = 1242,
		mag_att = 1863,
		phy_def = 1863,
		mag_def = 2686,
		crit = 1242,
		ten = 1863,
		hit = 1242,
		dodge = 0,
		act_speed = 621,
		seal_hit = 1242,
		seal_resis = 1242,
		mp_lim = 3654
};

get(223) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 223,
		hp_lim = 7269,
		phy_att = 1248,
		mag_att = 1872,
		phy_def = 1872,
		mag_def = 2698,
		crit = 1248,
		ten = 1872,
		hit = 1248,
		dodge = 0,
		act_speed = 624,
		seal_hit = 1248,
		seal_resis = 1248,
		mp_lim = 3671
};

get(224) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 224,
		hp_lim = 7302,
		phy_att = 1254,
		mag_att = 1881,
		phy_def = 1881,
		mag_def = 2710,
		crit = 1254,
		ten = 1881,
		hit = 1254,
		dodge = 0,
		act_speed = 627,
		seal_hit = 1254,
		seal_resis = 1254,
		mp_lim = 3688
};

get(225) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 225,
		hp_lim = 7335,
		phy_att = 1260,
		mag_att = 1890,
		phy_def = 1890,
		mag_def = 2722,
		crit = 1260,
		ten = 1890,
		hit = 1260,
		dodge = 0,
		act_speed = 630,
		seal_hit = 1260,
		seal_resis = 1260,
		mp_lim = 3705
};

get(226) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 226,
		hp_lim = 7368,
		phy_att = 1266,
		mag_att = 1899,
		phy_def = 1899,
		mag_def = 2734,
		crit = 1266,
		ten = 1899,
		hit = 1266,
		dodge = 0,
		act_speed = 633,
		seal_hit = 1266,
		seal_resis = 1266,
		mp_lim = 3722
};

get(227) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 227,
		hp_lim = 7401,
		phy_att = 1272,
		mag_att = 1908,
		phy_def = 1908,
		mag_def = 2746,
		crit = 1272,
		ten = 1908,
		hit = 1272,
		dodge = 0,
		act_speed = 636,
		seal_hit = 1272,
		seal_resis = 1272,
		mp_lim = 3739
};

get(228) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 228,
		hp_lim = 7434,
		phy_att = 1278,
		mag_att = 1917,
		phy_def = 1917,
		mag_def = 2758,
		crit = 1278,
		ten = 1917,
		hit = 1278,
		dodge = 0,
		act_speed = 639,
		seal_hit = 1278,
		seal_resis = 1278,
		mp_lim = 3756
};

get(229) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 229,
		hp_lim = 7467,
		phy_att = 1284,
		mag_att = 1926,
		phy_def = 1926,
		mag_def = 2770,
		crit = 1284,
		ten = 1926,
		hit = 1284,
		dodge = 0,
		act_speed = 642,
		seal_hit = 1284,
		seal_resis = 1284,
		mp_lim = 3773
};

get(230) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 230,
		hp_lim = 7500,
		phy_att = 1290,
		mag_att = 1935,
		phy_def = 1935,
		mag_def = 2782,
		crit = 1290,
		ten = 1935,
		hit = 1290,
		dodge = 0,
		act_speed = 645,
		seal_hit = 1290,
		seal_resis = 1290,
		mp_lim = 3790
};

get(231) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 231,
		hp_lim = 7533,
		phy_att = 1296,
		mag_att = 1944,
		phy_def = 1944,
		mag_def = 2794,
		crit = 1296,
		ten = 1944,
		hit = 1296,
		dodge = 0,
		act_speed = 648,
		seal_hit = 1296,
		seal_resis = 1296,
		mp_lim = 3807
};

get(232) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 232,
		hp_lim = 7566,
		phy_att = 1302,
		mag_att = 1953,
		phy_def = 1953,
		mag_def = 2806,
		crit = 1302,
		ten = 1953,
		hit = 1302,
		dodge = 0,
		act_speed = 651,
		seal_hit = 1302,
		seal_resis = 1302,
		mp_lim = 3824
};

get(233) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 233,
		hp_lim = 7599,
		phy_att = 1308,
		mag_att = 1962,
		phy_def = 1962,
		mag_def = 2818,
		crit = 1308,
		ten = 1962,
		hit = 1308,
		dodge = 0,
		act_speed = 654,
		seal_hit = 1308,
		seal_resis = 1308,
		mp_lim = 3841
};

get(234) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 234,
		hp_lim = 7632,
		phy_att = 1314,
		mag_att = 1971,
		phy_def = 1971,
		mag_def = 2830,
		crit = 1314,
		ten = 1971,
		hit = 1314,
		dodge = 0,
		act_speed = 657,
		seal_hit = 1314,
		seal_resis = 1314,
		mp_lim = 3858
};

get(235) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 235,
		hp_lim = 7665,
		phy_att = 1320,
		mag_att = 1980,
		phy_def = 1980,
		mag_def = 2842,
		crit = 1320,
		ten = 1980,
		hit = 1320,
		dodge = 0,
		act_speed = 660,
		seal_hit = 1320,
		seal_resis = 1320,
		mp_lim = 3875
};

get(236) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 236,
		hp_lim = 7698,
		phy_att = 1326,
		mag_att = 1989,
		phy_def = 1989,
		mag_def = 2854,
		crit = 1326,
		ten = 1989,
		hit = 1326,
		dodge = 0,
		act_speed = 663,
		seal_hit = 1326,
		seal_resis = 1326,
		mp_lim = 3892
};

get(237) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 237,
		hp_lim = 7731,
		phy_att = 1332,
		mag_att = 1998,
		phy_def = 1998,
		mag_def = 2866,
		crit = 1332,
		ten = 1998,
		hit = 1332,
		dodge = 0,
		act_speed = 666,
		seal_hit = 1332,
		seal_resis = 1332,
		mp_lim = 3909
};

get(238) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 238,
		hp_lim = 7764,
		phy_att = 1338,
		mag_att = 2007,
		phy_def = 2007,
		mag_def = 2878,
		crit = 1338,
		ten = 2007,
		hit = 1338,
		dodge = 0,
		act_speed = 669,
		seal_hit = 1338,
		seal_resis = 1338,
		mp_lim = 3926
};

get(239) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 239,
		hp_lim = 7797,
		phy_att = 1344,
		mag_att = 2016,
		phy_def = 2016,
		mag_def = 2890,
		crit = 1344,
		ten = 2016,
		hit = 1344,
		dodge = 0,
		act_speed = 672,
		seal_hit = 1344,
		seal_resis = 1344,
		mp_lim = 3943
};

get(240) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 240,
		hp_lim = 7830,
		phy_att = 1350,
		mag_att = 2025,
		phy_def = 2025,
		mag_def = 2902,
		crit = 1350,
		ten = 2025,
		hit = 1350,
		dodge = 0,
		act_speed = 675,
		seal_hit = 1350,
		seal_resis = 1350,
		mp_lim = 3960
};

get(241) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 241,
		hp_lim = 7863,
		phy_att = 1356,
		mag_att = 2034,
		phy_def = 2034,
		mag_def = 2914,
		crit = 1356,
		ten = 2034,
		hit = 1356,
		dodge = 0,
		act_speed = 678,
		seal_hit = 1356,
		seal_resis = 1356,
		mp_lim = 3977
};

get(242) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 242,
		hp_lim = 7896,
		phy_att = 1362,
		mag_att = 2043,
		phy_def = 2043,
		mag_def = 2926,
		crit = 1362,
		ten = 2043,
		hit = 1362,
		dodge = 0,
		act_speed = 681,
		seal_hit = 1362,
		seal_resis = 1362,
		mp_lim = 3994
};

get(243) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 243,
		hp_lim = 7929,
		phy_att = 1368,
		mag_att = 2052,
		phy_def = 2052,
		mag_def = 2938,
		crit = 1368,
		ten = 2052,
		hit = 1368,
		dodge = 0,
		act_speed = 684,
		seal_hit = 1368,
		seal_resis = 1368,
		mp_lim = 4011
};

get(244) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 244,
		hp_lim = 7962,
		phy_att = 1374,
		mag_att = 2061,
		phy_def = 2061,
		mag_def = 2950,
		crit = 1374,
		ten = 2061,
		hit = 1374,
		dodge = 0,
		act_speed = 687,
		seal_hit = 1374,
		seal_resis = 1374,
		mp_lim = 4028
};

get(245) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 245,
		hp_lim = 7995,
		phy_att = 1380,
		mag_att = 2070,
		phy_def = 2070,
		mag_def = 2962,
		crit = 1380,
		ten = 2070,
		hit = 1380,
		dodge = 0,
		act_speed = 690,
		seal_hit = 1380,
		seal_resis = 1380,
		mp_lim = 4045
};

get(246) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 246,
		hp_lim = 8028,
		phy_att = 1386,
		mag_att = 2079,
		phy_def = 2079,
		mag_def = 2974,
		crit = 1386,
		ten = 2079,
		hit = 1386,
		dodge = 0,
		act_speed = 693,
		seal_hit = 1386,
		seal_resis = 1386,
		mp_lim = 4062
};

get(247) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 247,
		hp_lim = 8061,
		phy_att = 1392,
		mag_att = 2088,
		phy_def = 2088,
		mag_def = 2986,
		crit = 1392,
		ten = 2088,
		hit = 1392,
		dodge = 0,
		act_speed = 696,
		seal_hit = 1392,
		seal_resis = 1392,
		mp_lim = 4079
};

get(248) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 248,
		hp_lim = 8094,
		phy_att = 1398,
		mag_att = 2097,
		phy_def = 2097,
		mag_def = 2998,
		crit = 1398,
		ten = 2097,
		hit = 1398,
		dodge = 0,
		act_speed = 699,
		seal_hit = 1398,
		seal_resis = 1398,
		mp_lim = 4096
};

get(249) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 249,
		hp_lim = 8127,
		phy_att = 1404,
		mag_att = 2106,
		phy_def = 2106,
		mag_def = 3010,
		crit = 1404,
		ten = 2106,
		hit = 1404,
		dodge = 0,
		act_speed = 702,
		seal_hit = 1404,
		seal_resis = 1404,
		mp_lim = 4113
};

get(250) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 250,
		hp_lim = 8160,
		phy_att = 1410,
		mag_att = 2115,
		phy_def = 2115,
		mag_def = 3022,
		crit = 1410,
		ten = 2115,
		hit = 1410,
		dodge = 0,
		act_speed = 705,
		seal_hit = 1410,
		seal_resis = 1410,
		mp_lim = 4130
};

get(251) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 251,
		hp_lim = 8193,
		phy_att = 1416,
		mag_att = 2124,
		phy_def = 2124,
		mag_def = 3034,
		crit = 1416,
		ten = 2124,
		hit = 1416,
		dodge = 0,
		act_speed = 708,
		seal_hit = 1416,
		seal_resis = 1416,
		mp_lim = 4147
};

get(252) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 252,
		hp_lim = 8226,
		phy_att = 1422,
		mag_att = 2133,
		phy_def = 2133,
		mag_def = 3046,
		crit = 1422,
		ten = 2133,
		hit = 1422,
		dodge = 0,
		act_speed = 711,
		seal_hit = 1422,
		seal_resis = 1422,
		mp_lim = 4164
};

get(253) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 253,
		hp_lim = 8259,
		phy_att = 1428,
		mag_att = 2142,
		phy_def = 2142,
		mag_def = 3058,
		crit = 1428,
		ten = 2142,
		hit = 1428,
		dodge = 0,
		act_speed = 714,
		seal_hit = 1428,
		seal_resis = 1428,
		mp_lim = 4181
};

get(254) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 254,
		hp_lim = 8292,
		phy_att = 1434,
		mag_att = 2151,
		phy_def = 2151,
		mag_def = 3070,
		crit = 1434,
		ten = 2151,
		hit = 1434,
		dodge = 0,
		act_speed = 717,
		seal_hit = 1434,
		seal_resis = 1434,
		mp_lim = 4198
};

get(255) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 255,
		hp_lim = 8325,
		phy_att = 1440,
		mag_att = 2160,
		phy_def = 2160,
		mag_def = 3082,
		crit = 1440,
		ten = 2160,
		hit = 1440,
		dodge = 0,
		act_speed = 720,
		seal_hit = 1440,
		seal_resis = 1440,
		mp_lim = 4215
};

get(256) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 256,
		hp_lim = 8358,
		phy_att = 1446,
		mag_att = 2169,
		phy_def = 2169,
		mag_def = 3094,
		crit = 1446,
		ten = 2169,
		hit = 1446,
		dodge = 0,
		act_speed = 723,
		seal_hit = 1446,
		seal_resis = 1446,
		mp_lim = 4232
};

get(257) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 257,
		hp_lim = 8391,
		phy_att = 1452,
		mag_att = 2178,
		phy_def = 2178,
		mag_def = 3106,
		crit = 1452,
		ten = 2178,
		hit = 1452,
		dodge = 0,
		act_speed = 726,
		seal_hit = 1452,
		seal_resis = 1452,
		mp_lim = 4249
};

get(258) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 258,
		hp_lim = 8424,
		phy_att = 1458,
		mag_att = 2187,
		phy_def = 2187,
		mag_def = 3118,
		crit = 1458,
		ten = 2187,
		hit = 1458,
		dodge = 0,
		act_speed = 729,
		seal_hit = 1458,
		seal_resis = 1458,
		mp_lim = 4266
};

get(259) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 259,
		hp_lim = 8457,
		phy_att = 1464,
		mag_att = 2196,
		phy_def = 2196,
		mag_def = 3130,
		crit = 1464,
		ten = 2196,
		hit = 1464,
		dodge = 0,
		act_speed = 732,
		seal_hit = 1464,
		seal_resis = 1464,
		mp_lim = 4283
};

get(260) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 260,
		hp_lim = 8490,
		phy_att = 1470,
		mag_att = 2205,
		phy_def = 2205,
		mag_def = 3142,
		crit = 1470,
		ten = 2205,
		hit = 1470,
		dodge = 0,
		act_speed = 735,
		seal_hit = 1470,
		seal_resis = 1470,
		mp_lim = 4300
};

get(261) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 261,
		hp_lim = 8523,
		phy_att = 1476,
		mag_att = 2214,
		phy_def = 2214,
		mag_def = 3154,
		crit = 1476,
		ten = 2214,
		hit = 1476,
		dodge = 0,
		act_speed = 738,
		seal_hit = 1476,
		seal_resis = 1476,
		mp_lim = 4317
};

get(262) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 262,
		hp_lim = 8556,
		phy_att = 1482,
		mag_att = 2223,
		phy_def = 2223,
		mag_def = 3166,
		crit = 1482,
		ten = 2223,
		hit = 1482,
		dodge = 0,
		act_speed = 741,
		seal_hit = 1482,
		seal_resis = 1482,
		mp_lim = 4334
};

get(263) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 263,
		hp_lim = 8589,
		phy_att = 1488,
		mag_att = 2232,
		phy_def = 2232,
		mag_def = 3178,
		crit = 1488,
		ten = 2232,
		hit = 1488,
		dodge = 0,
		act_speed = 744,
		seal_hit = 1488,
		seal_resis = 1488,
		mp_lim = 4351
};

get(264) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 264,
		hp_lim = 8622,
		phy_att = 1494,
		mag_att = 2241,
		phy_def = 2241,
		mag_def = 3190,
		crit = 1494,
		ten = 2241,
		hit = 1494,
		dodge = 0,
		act_speed = 747,
		seal_hit = 1494,
		seal_resis = 1494,
		mp_lim = 4368
};

get(265) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 265,
		hp_lim = 8655,
		phy_att = 1500,
		mag_att = 2250,
		phy_def = 2250,
		mag_def = 3202,
		crit = 1500,
		ten = 2250,
		hit = 1500,
		dodge = 0,
		act_speed = 750,
		seal_hit = 1500,
		seal_resis = 1500,
		mp_lim = 4385
};

get(266) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 266,
		hp_lim = 8688,
		phy_att = 1506,
		mag_att = 2259,
		phy_def = 2259,
		mag_def = 3214,
		crit = 1506,
		ten = 2259,
		hit = 1506,
		dodge = 0,
		act_speed = 753,
		seal_hit = 1506,
		seal_resis = 1506,
		mp_lim = 4402
};

get(267) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 267,
		hp_lim = 8721,
		phy_att = 1512,
		mag_att = 2268,
		phy_def = 2268,
		mag_def = 3226,
		crit = 1512,
		ten = 2268,
		hit = 1512,
		dodge = 0,
		act_speed = 756,
		seal_hit = 1512,
		seal_resis = 1512,
		mp_lim = 4419
};

get(268) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 268,
		hp_lim = 8754,
		phy_att = 1518,
		mag_att = 2277,
		phy_def = 2277,
		mag_def = 3238,
		crit = 1518,
		ten = 2277,
		hit = 1518,
		dodge = 0,
		act_speed = 759,
		seal_hit = 1518,
		seal_resis = 1518,
		mp_lim = 4436
};

get(269) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 269,
		hp_lim = 8787,
		phy_att = 1524,
		mag_att = 2286,
		phy_def = 2286,
		mag_def = 3250,
		crit = 1524,
		ten = 2286,
		hit = 1524,
		dodge = 0,
		act_speed = 762,
		seal_hit = 1524,
		seal_resis = 1524,
		mp_lim = 4453
};

get(270) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 270,
		hp_lim = 8820,
		phy_att = 1530,
		mag_att = 2295,
		phy_def = 2295,
		mag_def = 3262,
		crit = 1530,
		ten = 2295,
		hit = 1530,
		dodge = 0,
		act_speed = 765,
		seal_hit = 1530,
		seal_resis = 1530,
		mp_lim = 4470
};

get(271) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 271,
		hp_lim = 8853,
		phy_att = 1536,
		mag_att = 2304,
		phy_def = 2304,
		mag_def = 3274,
		crit = 1536,
		ten = 2304,
		hit = 1536,
		dodge = 0,
		act_speed = 768,
		seal_hit = 1536,
		seal_resis = 1536,
		mp_lim = 4487
};

get(272) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 272,
		hp_lim = 8886,
		phy_att = 1542,
		mag_att = 2313,
		phy_def = 2313,
		mag_def = 3286,
		crit = 1542,
		ten = 2313,
		hit = 1542,
		dodge = 0,
		act_speed = 771,
		seal_hit = 1542,
		seal_resis = 1542,
		mp_lim = 4504
};

get(273) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 273,
		hp_lim = 8919,
		phy_att = 1548,
		mag_att = 2322,
		phy_def = 2322,
		mag_def = 3298,
		crit = 1548,
		ten = 2322,
		hit = 1548,
		dodge = 0,
		act_speed = 774,
		seal_hit = 1548,
		seal_resis = 1548,
		mp_lim = 4521
};

get(274) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 274,
		hp_lim = 8952,
		phy_att = 1554,
		mag_att = 2331,
		phy_def = 2331,
		mag_def = 3310,
		crit = 1554,
		ten = 2331,
		hit = 1554,
		dodge = 0,
		act_speed = 777,
		seal_hit = 1554,
		seal_resis = 1554,
		mp_lim = 4538
};

get(275) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 275,
		hp_lim = 8985,
		phy_att = 1560,
		mag_att = 2340,
		phy_def = 2340,
		mag_def = 3322,
		crit = 1560,
		ten = 2340,
		hit = 1560,
		dodge = 0,
		act_speed = 780,
		seal_hit = 1560,
		seal_resis = 1560,
		mp_lim = 4555
};

get(276) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 276,
		hp_lim = 9018,
		phy_att = 1566,
		mag_att = 2349,
		phy_def = 2349,
		mag_def = 3334,
		crit = 1566,
		ten = 2349,
		hit = 1566,
		dodge = 0,
		act_speed = 783,
		seal_hit = 1566,
		seal_resis = 1566,
		mp_lim = 4572
};

get(277) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 277,
		hp_lim = 9051,
		phy_att = 1572,
		mag_att = 2358,
		phy_def = 2358,
		mag_def = 3346,
		crit = 1572,
		ten = 2358,
		hit = 1572,
		dodge = 0,
		act_speed = 786,
		seal_hit = 1572,
		seal_resis = 1572,
		mp_lim = 4589
};

get(278) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 278,
		hp_lim = 9084,
		phy_att = 1578,
		mag_att = 2367,
		phy_def = 2367,
		mag_def = 3358,
		crit = 1578,
		ten = 2367,
		hit = 1578,
		dodge = 0,
		act_speed = 789,
		seal_hit = 1578,
		seal_resis = 1578,
		mp_lim = 4606
};

get(279) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 279,
		hp_lim = 9117,
		phy_att = 1584,
		mag_att = 2376,
		phy_def = 2376,
		mag_def = 3370,
		crit = 1584,
		ten = 2376,
		hit = 1584,
		dodge = 0,
		act_speed = 792,
		seal_hit = 1584,
		seal_resis = 1584,
		mp_lim = 4623
};

get(280) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 280,
		hp_lim = 9150,
		phy_att = 1590,
		mag_att = 2385,
		phy_def = 2385,
		mag_def = 3382,
		crit = 1590,
		ten = 2385,
		hit = 1590,
		dodge = 0,
		act_speed = 795,
		seal_hit = 1590,
		seal_resis = 1590,
		mp_lim = 4640
};

get(281) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 281,
		hp_lim = 9183,
		phy_att = 1596,
		mag_att = 2394,
		phy_def = 2394,
		mag_def = 3394,
		crit = 1596,
		ten = 2394,
		hit = 1596,
		dodge = 0,
		act_speed = 798,
		seal_hit = 1596,
		seal_resis = 1596,
		mp_lim = 4657
};

get(282) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 282,
		hp_lim = 9216,
		phy_att = 1602,
		mag_att = 2403,
		phy_def = 2403,
		mag_def = 3406,
		crit = 1602,
		ten = 2403,
		hit = 1602,
		dodge = 0,
		act_speed = 801,
		seal_hit = 1602,
		seal_resis = 1602,
		mp_lim = 4674
};

get(283) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 283,
		hp_lim = 9249,
		phy_att = 1608,
		mag_att = 2412,
		phy_def = 2412,
		mag_def = 3418,
		crit = 1608,
		ten = 2412,
		hit = 1608,
		dodge = 0,
		act_speed = 804,
		seal_hit = 1608,
		seal_resis = 1608,
		mp_lim = 4691
};

get(284) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 284,
		hp_lim = 9282,
		phy_att = 1614,
		mag_att = 2421,
		phy_def = 2421,
		mag_def = 3430,
		crit = 1614,
		ten = 2421,
		hit = 1614,
		dodge = 0,
		act_speed = 807,
		seal_hit = 1614,
		seal_resis = 1614,
		mp_lim = 4708
};

get(285) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 285,
		hp_lim = 9315,
		phy_att = 1620,
		mag_att = 2430,
		phy_def = 2430,
		mag_def = 3442,
		crit = 1620,
		ten = 2430,
		hit = 1620,
		dodge = 0,
		act_speed = 810,
		seal_hit = 1620,
		seal_resis = 1620,
		mp_lim = 4725
};

get(286) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 286,
		hp_lim = 9348,
		phy_att = 1626,
		mag_att = 2439,
		phy_def = 2439,
		mag_def = 3454,
		crit = 1626,
		ten = 2439,
		hit = 1626,
		dodge = 0,
		act_speed = 813,
		seal_hit = 1626,
		seal_resis = 1626,
		mp_lim = 4742
};

get(287) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 287,
		hp_lim = 9381,
		phy_att = 1632,
		mag_att = 2448,
		phy_def = 2448,
		mag_def = 3466,
		crit = 1632,
		ten = 2448,
		hit = 1632,
		dodge = 0,
		act_speed = 816,
		seal_hit = 1632,
		seal_resis = 1632,
		mp_lim = 4759
};

get(288) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 288,
		hp_lim = 9414,
		phy_att = 1638,
		mag_att = 2457,
		phy_def = 2457,
		mag_def = 3478,
		crit = 1638,
		ten = 2457,
		hit = 1638,
		dodge = 0,
		act_speed = 819,
		seal_hit = 1638,
		seal_resis = 1638,
		mp_lim = 4776
};

get(289) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 289,
		hp_lim = 9447,
		phy_att = 1644,
		mag_att = 2466,
		phy_def = 2466,
		mag_def = 3490,
		crit = 1644,
		ten = 2466,
		hit = 1644,
		dodge = 0,
		act_speed = 822,
		seal_hit = 1644,
		seal_resis = 1644,
		mp_lim = 4793
};

get(290) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 290,
		hp_lim = 9480,
		phy_att = 1650,
		mag_att = 2475,
		phy_def = 2475,
		mag_def = 3502,
		crit = 1650,
		ten = 2475,
		hit = 1650,
		dodge = 0,
		act_speed = 825,
		seal_hit = 1650,
		seal_resis = 1650,
		mp_lim = 4810
};

get(291) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 291,
		hp_lim = 9513,
		phy_att = 1656,
		mag_att = 2484,
		phy_def = 2484,
		mag_def = 3514,
		crit = 1656,
		ten = 2484,
		hit = 1656,
		dodge = 0,
		act_speed = 828,
		seal_hit = 1656,
		seal_resis = 1656,
		mp_lim = 4827
};

get(292) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 292,
		hp_lim = 9546,
		phy_att = 1662,
		mag_att = 2493,
		phy_def = 2493,
		mag_def = 3526,
		crit = 1662,
		ten = 2493,
		hit = 1662,
		dodge = 0,
		act_speed = 831,
		seal_hit = 1662,
		seal_resis = 1662,
		mp_lim = 4844
};

get(293) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 293,
		hp_lim = 9579,
		phy_att = 1668,
		mag_att = 2502,
		phy_def = 2502,
		mag_def = 3538,
		crit = 1668,
		ten = 2502,
		hit = 1668,
		dodge = 0,
		act_speed = 834,
		seal_hit = 1668,
		seal_resis = 1668,
		mp_lim = 4861
};

get(294) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 294,
		hp_lim = 9612,
		phy_att = 1674,
		mag_att = 2511,
		phy_def = 2511,
		mag_def = 3550,
		crit = 1674,
		ten = 2511,
		hit = 1674,
		dodge = 0,
		act_speed = 837,
		seal_hit = 1674,
		seal_resis = 1674,
		mp_lim = 4878
};

get(295) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 295,
		hp_lim = 9645,
		phy_att = 1680,
		mag_att = 2520,
		phy_def = 2520,
		mag_def = 3562,
		crit = 1680,
		ten = 2520,
		hit = 1680,
		dodge = 0,
		act_speed = 840,
		seal_hit = 1680,
		seal_resis = 1680,
		mp_lim = 4895
};

get(296) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 296,
		hp_lim = 9678,
		phy_att = 1686,
		mag_att = 2529,
		phy_def = 2529,
		mag_def = 3574,
		crit = 1686,
		ten = 2529,
		hit = 1686,
		dodge = 0,
		act_speed = 843,
		seal_hit = 1686,
		seal_resis = 1686,
		mp_lim = 4912
};

get(297) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 297,
		hp_lim = 9711,
		phy_att = 1692,
		mag_att = 2538,
		phy_def = 2538,
		mag_def = 3586,
		crit = 1692,
		ten = 2538,
		hit = 1692,
		dodge = 0,
		act_speed = 846,
		seal_hit = 1692,
		seal_resis = 1692,
		mp_lim = 4929
};

get(298) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 298,
		hp_lim = 9744,
		phy_att = 1698,
		mag_att = 2547,
		phy_def = 2547,
		mag_def = 3598,
		crit = 1698,
		ten = 2547,
		hit = 1698,
		dodge = 0,
		act_speed = 849,
		seal_hit = 1698,
		seal_resis = 1698,
		mp_lim = 4946
};

get(299) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 299,
		hp_lim = 9777,
		phy_att = 1704,
		mag_att = 2556,
		phy_def = 2556,
		mag_def = 3610,
		crit = 1704,
		ten = 2556,
		hit = 1704,
		dodge = 0,
		act_speed = 852,
		seal_hit = 1704,
		seal_resis = 1704,
		mp_lim = 4963
};

get(300) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 300,
		hp_lim = 9810,
		phy_att = 1710,
		mag_att = 2565,
		phy_def = 2565,
		mag_def = 3622,
		crit = 1710,
		ten = 2565,
		hit = 1710,
		dodge = 0,
		act_speed = 855,
		seal_hit = 1710,
		seal_resis = 1710,
		mp_lim = 4980
};

get(301) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 301,
		hp_lim = 9843,
		phy_att = 1716,
		mag_att = 2574,
		phy_def = 2574,
		mag_def = 3634,
		crit = 1716,
		ten = 2574,
		hit = 1716,
		dodge = 0,
		act_speed = 858,
		seal_hit = 1716,
		seal_resis = 1716,
		mp_lim = 4997
};

get(302) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 302,
		hp_lim = 9876,
		phy_att = 1722,
		mag_att = 2583,
		phy_def = 2583,
		mag_def = 3646,
		crit = 1722,
		ten = 2583,
		hit = 1722,
		dodge = 0,
		act_speed = 861,
		seal_hit = 1722,
		seal_resis = 1722,
		mp_lim = 5014
};

get(303) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 303,
		hp_lim = 9909,
		phy_att = 1728,
		mag_att = 2592,
		phy_def = 2592,
		mag_def = 3658,
		crit = 1728,
		ten = 2592,
		hit = 1728,
		dodge = 0,
		act_speed = 864,
		seal_hit = 1728,
		seal_resis = 1728,
		mp_lim = 5031
};

get(304) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 304,
		hp_lim = 9942,
		phy_att = 1734,
		mag_att = 2601,
		phy_def = 2601,
		mag_def = 3670,
		crit = 1734,
		ten = 2601,
		hit = 1734,
		dodge = 0,
		act_speed = 867,
		seal_hit = 1734,
		seal_resis = 1734,
		mp_lim = 5048
};

get(305) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 305,
		hp_lim = 9975,
		phy_att = 1740,
		mag_att = 2610,
		phy_def = 2610,
		mag_def = 3682,
		crit = 1740,
		ten = 2610,
		hit = 1740,
		dodge = 0,
		act_speed = 870,
		seal_hit = 1740,
		seal_resis = 1740,
		mp_lim = 5065
};

get(306) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 306,
		hp_lim = 10008,
		phy_att = 1746,
		mag_att = 2619,
		phy_def = 2619,
		mag_def = 3694,
		crit = 1746,
		ten = 2619,
		hit = 1746,
		dodge = 0,
		act_speed = 873,
		seal_hit = 1746,
		seal_resis = 1746,
		mp_lim = 5082
};

get(307) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 307,
		hp_lim = 10041,
		phy_att = 1752,
		mag_att = 2628,
		phy_def = 2628,
		mag_def = 3706,
		crit = 1752,
		ten = 2628,
		hit = 1752,
		dodge = 0,
		act_speed = 876,
		seal_hit = 1752,
		seal_resis = 1752,
		mp_lim = 5099
};

get(308) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 308,
		hp_lim = 10074,
		phy_att = 1758,
		mag_att = 2637,
		phy_def = 2637,
		mag_def = 3718,
		crit = 1758,
		ten = 2637,
		hit = 1758,
		dodge = 0,
		act_speed = 879,
		seal_hit = 1758,
		seal_resis = 1758,
		mp_lim = 5116
};

get(309) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 309,
		hp_lim = 10107,
		phy_att = 1764,
		mag_att = 2646,
		phy_def = 2646,
		mag_def = 3730,
		crit = 1764,
		ten = 2646,
		hit = 1764,
		dodge = 0,
		act_speed = 882,
		seal_hit = 1764,
		seal_resis = 1764,
		mp_lim = 5133
};

get(310) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 310,
		hp_lim = 10140,
		phy_att = 1770,
		mag_att = 2655,
		phy_def = 2655,
		mag_def = 3742,
		crit = 1770,
		ten = 2655,
		hit = 1770,
		dodge = 0,
		act_speed = 885,
		seal_hit = 1770,
		seal_resis = 1770,
		mp_lim = 5150
};

get(311) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 311,
		hp_lim = 10173,
		phy_att = 1776,
		mag_att = 2664,
		phy_def = 2664,
		mag_def = 3754,
		crit = 1776,
		ten = 2664,
		hit = 1776,
		dodge = 0,
		act_speed = 888,
		seal_hit = 1776,
		seal_resis = 1776,
		mp_lim = 5167
};

get(312) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 312,
		hp_lim = 10206,
		phy_att = 1782,
		mag_att = 2673,
		phy_def = 2673,
		mag_def = 3766,
		crit = 1782,
		ten = 2673,
		hit = 1782,
		dodge = 0,
		act_speed = 891,
		seal_hit = 1782,
		seal_resis = 1782,
		mp_lim = 5184
};

get(313) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 313,
		hp_lim = 10239,
		phy_att = 1788,
		mag_att = 2682,
		phy_def = 2682,
		mag_def = 3778,
		crit = 1788,
		ten = 2682,
		hit = 1788,
		dodge = 0,
		act_speed = 894,
		seal_hit = 1788,
		seal_resis = 1788,
		mp_lim = 5201
};

get(314) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 314,
		hp_lim = 10272,
		phy_att = 1794,
		mag_att = 2691,
		phy_def = 2691,
		mag_def = 3790,
		crit = 1794,
		ten = 2691,
		hit = 1794,
		dodge = 0,
		act_speed = 897,
		seal_hit = 1794,
		seal_resis = 1794,
		mp_lim = 5218
};

get(315) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 315,
		hp_lim = 10305,
		phy_att = 1800,
		mag_att = 2700,
		phy_def = 2700,
		mag_def = 3802,
		crit = 1800,
		ten = 2700,
		hit = 1800,
		dodge = 0,
		act_speed = 900,
		seal_hit = 1800,
		seal_resis = 1800,
		mp_lim = 5235
};

get(316) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 316,
		hp_lim = 10338,
		phy_att = 1806,
		mag_att = 2709,
		phy_def = 2709,
		mag_def = 3814,
		crit = 1806,
		ten = 2709,
		hit = 1806,
		dodge = 0,
		act_speed = 903,
		seal_hit = 1806,
		seal_resis = 1806,
		mp_lim = 5252
};

get(317) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 317,
		hp_lim = 10371,
		phy_att = 1812,
		mag_att = 2718,
		phy_def = 2718,
		mag_def = 3826,
		crit = 1812,
		ten = 2718,
		hit = 1812,
		dodge = 0,
		act_speed = 906,
		seal_hit = 1812,
		seal_resis = 1812,
		mp_lim = 5269
};

get(318) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 318,
		hp_lim = 10404,
		phy_att = 1818,
		mag_att = 2727,
		phy_def = 2727,
		mag_def = 3838,
		crit = 1818,
		ten = 2727,
		hit = 1818,
		dodge = 0,
		act_speed = 909,
		seal_hit = 1818,
		seal_resis = 1818,
		mp_lim = 5286
};

get(319) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 319,
		hp_lim = 10437,
		phy_att = 1824,
		mag_att = 2736,
		phy_def = 2736,
		mag_def = 3850,
		crit = 1824,
		ten = 2736,
		hit = 1824,
		dodge = 0,
		act_speed = 912,
		seal_hit = 1824,
		seal_resis = 1824,
		mp_lim = 5303
};

get(320) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 320,
		hp_lim = 10470,
		phy_att = 1830,
		mag_att = 2745,
		phy_def = 2745,
		mag_def = 3862,
		crit = 1830,
		ten = 2745,
		hit = 1830,
		dodge = 0,
		act_speed = 915,
		seal_hit = 1830,
		seal_resis = 1830,
		mp_lim = 5320
};

get(321) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 321,
		hp_lim = 10503,
		phy_att = 1836,
		mag_att = 2754,
		phy_def = 2754,
		mag_def = 3874,
		crit = 1836,
		ten = 2754,
		hit = 1836,
		dodge = 0,
		act_speed = 918,
		seal_hit = 1836,
		seal_resis = 1836,
		mp_lim = 5337
};

get(322) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 322,
		hp_lim = 10536,
		phy_att = 1842,
		mag_att = 2763,
		phy_def = 2763,
		mag_def = 3886,
		crit = 1842,
		ten = 2763,
		hit = 1842,
		dodge = 0,
		act_speed = 921,
		seal_hit = 1842,
		seal_resis = 1842,
		mp_lim = 5354
};

get(323) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 323,
		hp_lim = 10569,
		phy_att = 1848,
		mag_att = 2772,
		phy_def = 2772,
		mag_def = 3898,
		crit = 1848,
		ten = 2772,
		hit = 1848,
		dodge = 0,
		act_speed = 924,
		seal_hit = 1848,
		seal_resis = 1848,
		mp_lim = 5371
};

get(324) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 324,
		hp_lim = 10602,
		phy_att = 1854,
		mag_att = 2781,
		phy_def = 2781,
		mag_def = 3910,
		crit = 1854,
		ten = 2781,
		hit = 1854,
		dodge = 0,
		act_speed = 927,
		seal_hit = 1854,
		seal_resis = 1854,
		mp_lim = 5388
};

get(325) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 325,
		hp_lim = 10635,
		phy_att = 1860,
		mag_att = 2790,
		phy_def = 2790,
		mag_def = 3922,
		crit = 1860,
		ten = 2790,
		hit = 1860,
		dodge = 0,
		act_speed = 930,
		seal_hit = 1860,
		seal_resis = 1860,
		mp_lim = 5405
};

get(326) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 326,
		hp_lim = 10668,
		phy_att = 1866,
		mag_att = 2799,
		phy_def = 2799,
		mag_def = 3934,
		crit = 1866,
		ten = 2799,
		hit = 1866,
		dodge = 0,
		act_speed = 933,
		seal_hit = 1866,
		seal_resis = 1866,
		mp_lim = 5422
};

get(327) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 327,
		hp_lim = 10701,
		phy_att = 1872,
		mag_att = 2808,
		phy_def = 2808,
		mag_def = 3946,
		crit = 1872,
		ten = 2808,
		hit = 1872,
		dodge = 0,
		act_speed = 936,
		seal_hit = 1872,
		seal_resis = 1872,
		mp_lim = 5439
};

get(328) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 328,
		hp_lim = 10734,
		phy_att = 1878,
		mag_att = 2817,
		phy_def = 2817,
		mag_def = 3958,
		crit = 1878,
		ten = 2817,
		hit = 1878,
		dodge = 0,
		act_speed = 939,
		seal_hit = 1878,
		seal_resis = 1878,
		mp_lim = 5456
};

get(329) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 329,
		hp_lim = 10767,
		phy_att = 1884,
		mag_att = 2826,
		phy_def = 2826,
		mag_def = 3970,
		crit = 1884,
		ten = 2826,
		hit = 1884,
		dodge = 0,
		act_speed = 942,
		seal_hit = 1884,
		seal_resis = 1884,
		mp_lim = 5473
};

get(330) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 330,
		hp_lim = 10800,
		phy_att = 1890,
		mag_att = 2835,
		phy_def = 2835,
		mag_def = 3982,
		crit = 1890,
		ten = 2835,
		hit = 1890,
		dodge = 0,
		act_speed = 945,
		seal_hit = 1890,
		seal_resis = 1890,
		mp_lim = 5490
};

get(331) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 331,
		hp_lim = 10833,
		phy_att = 1896,
		mag_att = 2844,
		phy_def = 2844,
		mag_def = 3994,
		crit = 1896,
		ten = 2844,
		hit = 1896,
		dodge = 0,
		act_speed = 948,
		seal_hit = 1896,
		seal_resis = 1896,
		mp_lim = 5507
};

get(332) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 332,
		hp_lim = 10866,
		phy_att = 1902,
		mag_att = 2853,
		phy_def = 2853,
		mag_def = 4006,
		crit = 1902,
		ten = 2853,
		hit = 1902,
		dodge = 0,
		act_speed = 951,
		seal_hit = 1902,
		seal_resis = 1902,
		mp_lim = 5524
};

get(333) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 333,
		hp_lim = 10899,
		phy_att = 1908,
		mag_att = 2862,
		phy_def = 2862,
		mag_def = 4018,
		crit = 1908,
		ten = 2862,
		hit = 1908,
		dodge = 0,
		act_speed = 954,
		seal_hit = 1908,
		seal_resis = 1908,
		mp_lim = 5541
};

get(334) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 334,
		hp_lim = 10932,
		phy_att = 1914,
		mag_att = 2871,
		phy_def = 2871,
		mag_def = 4030,
		crit = 1914,
		ten = 2871,
		hit = 1914,
		dodge = 0,
		act_speed = 957,
		seal_hit = 1914,
		seal_resis = 1914,
		mp_lim = 5558
};

get(335) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 335,
		hp_lim = 10965,
		phy_att = 1920,
		mag_att = 2880,
		phy_def = 2880,
		mag_def = 4042,
		crit = 1920,
		ten = 2880,
		hit = 1920,
		dodge = 0,
		act_speed = 960,
		seal_hit = 1920,
		seal_resis = 1920,
		mp_lim = 5575
};

get(336) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 336,
		hp_lim = 10998,
		phy_att = 1926,
		mag_att = 2889,
		phy_def = 2889,
		mag_def = 4054,
		crit = 1926,
		ten = 2889,
		hit = 1926,
		dodge = 0,
		act_speed = 963,
		seal_hit = 1926,
		seal_resis = 1926,
		mp_lim = 5592
};

get(337) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 337,
		hp_lim = 11031,
		phy_att = 1932,
		mag_att = 2898,
		phy_def = 2898,
		mag_def = 4066,
		crit = 1932,
		ten = 2898,
		hit = 1932,
		dodge = 0,
		act_speed = 966,
		seal_hit = 1932,
		seal_resis = 1932,
		mp_lim = 5609
};

get(338) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 338,
		hp_lim = 11064,
		phy_att = 1938,
		mag_att = 2907,
		phy_def = 2907,
		mag_def = 4078,
		crit = 1938,
		ten = 2907,
		hit = 1938,
		dodge = 0,
		act_speed = 969,
		seal_hit = 1938,
		seal_resis = 1938,
		mp_lim = 5626
};

get(339) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 339,
		hp_lim = 11097,
		phy_att = 1944,
		mag_att = 2916,
		phy_def = 2916,
		mag_def = 4090,
		crit = 1944,
		ten = 2916,
		hit = 1944,
		dodge = 0,
		act_speed = 972,
		seal_hit = 1944,
		seal_resis = 1944,
		mp_lim = 5643
};

get(340) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 340,
		hp_lim = 11130,
		phy_att = 1950,
		mag_att = 2925,
		phy_def = 2925,
		mag_def = 4102,
		crit = 1950,
		ten = 2925,
		hit = 1950,
		dodge = 0,
		act_speed = 975,
		seal_hit = 1950,
		seal_resis = 1950,
		mp_lim = 5660
};

get(341) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 341,
		hp_lim = 11163,
		phy_att = 1956,
		mag_att = 2934,
		phy_def = 2934,
		mag_def = 4114,
		crit = 1956,
		ten = 2934,
		hit = 1956,
		dodge = 0,
		act_speed = 978,
		seal_hit = 1956,
		seal_resis = 1956,
		mp_lim = 5677
};

get(342) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 342,
		hp_lim = 11196,
		phy_att = 1962,
		mag_att = 2943,
		phy_def = 2943,
		mag_def = 4126,
		crit = 1962,
		ten = 2943,
		hit = 1962,
		dodge = 0,
		act_speed = 981,
		seal_hit = 1962,
		seal_resis = 1962,
		mp_lim = 5694
};

get(343) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 343,
		hp_lim = 11229,
		phy_att = 1968,
		mag_att = 2952,
		phy_def = 2952,
		mag_def = 4138,
		crit = 1968,
		ten = 2952,
		hit = 1968,
		dodge = 0,
		act_speed = 984,
		seal_hit = 1968,
		seal_resis = 1968,
		mp_lim = 5711
};

get(344) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 344,
		hp_lim = 11262,
		phy_att = 1974,
		mag_att = 2961,
		phy_def = 2961,
		mag_def = 4150,
		crit = 1974,
		ten = 2961,
		hit = 1974,
		dodge = 0,
		act_speed = 987,
		seal_hit = 1974,
		seal_resis = 1974,
		mp_lim = 5728
};

get(345) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 345,
		hp_lim = 11295,
		phy_att = 1980,
		mag_att = 2970,
		phy_def = 2970,
		mag_def = 4162,
		crit = 1980,
		ten = 2970,
		hit = 1980,
		dodge = 0,
		act_speed = 990,
		seal_hit = 1980,
		seal_resis = 1980,
		mp_lim = 5745
};

get(346) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 346,
		hp_lim = 11328,
		phy_att = 1986,
		mag_att = 2979,
		phy_def = 2979,
		mag_def = 4174,
		crit = 1986,
		ten = 2979,
		hit = 1986,
		dodge = 0,
		act_speed = 993,
		seal_hit = 1986,
		seal_resis = 1986,
		mp_lim = 5762
};

get(347) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 347,
		hp_lim = 11361,
		phy_att = 1992,
		mag_att = 2988,
		phy_def = 2988,
		mag_def = 4186,
		crit = 1992,
		ten = 2988,
		hit = 1992,
		dodge = 0,
		act_speed = 996,
		seal_hit = 1992,
		seal_resis = 1992,
		mp_lim = 5779
};

get(348) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 348,
		hp_lim = 11394,
		phy_att = 1998,
		mag_att = 2997,
		phy_def = 2997,
		mag_def = 4198,
		crit = 1998,
		ten = 2997,
		hit = 1998,
		dodge = 0,
		act_speed = 999,
		seal_hit = 1998,
		seal_resis = 1998,
		mp_lim = 5796
};

get(349) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 349,
		hp_lim = 11427,
		phy_att = 2004,
		mag_att = 3006,
		phy_def = 3006,
		mag_def = 4210,
		crit = 2004,
		ten = 3006,
		hit = 2004,
		dodge = 0,
		act_speed = 1002,
		seal_hit = 2004,
		seal_resis = 2004,
		mp_lim = 5813
};

get(350) ->
	#xinfa_add_attrs_val{
		xinfa_lv = 350,
		hp_lim = 11460,
		phy_att = 2010,
		mag_att = 3015,
		phy_def = 3015,
		mag_def = 4222,
		crit = 2010,
		ten = 3015,
		hit = 2010,
		dodge = 0,
		act_speed = 1005,
		seal_hit = 2010,
		seal_resis = 2010,
		mp_lim = 5830
};

get(_XinfaLv) ->
	      ?ASSERT(false, _XinfaLv),
          null.

