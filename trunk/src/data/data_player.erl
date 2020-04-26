%%%---------------------------------------
%%% @Module  : data_player
%%% @Author  : LDS
%%% @Email   : 
%%% @Created : 2012-09-24  12:07:32
%%% @Description:  自动生成
%%%---------------------------------------
-module(data_player).
% -export([get/2]).
% -include("record.hrl").

% 	get(1, 1) ->
% 	#attrs{
% 		phy_att = 51,
% 		phy_def = 13,
% 		hp_lim = 145,
% 		dodge = 500,
% 		hit = 500,
% 		crit = 3,
% 		ten = 5,
% 		spr_att = 88,
% 		spr_def = 19,
% 		mag_att = 0,
% 		mag_def = 7,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 12,
		
% 		resis = 0	};

% 	get(1, 2) ->
% 	#attrs{
% 		phy_att = 54,
% 		phy_def = 16,
% 		hp_lim = 154,
% 		dodge = 504,
% 		hit = 504,
% 		crit = 5,
% 		ten = 6,
% 		spr_att = 94,
% 		spr_def = 23,
% 		mag_att = 0,
% 		mag_def = 9,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 15,
		
% 		resis = 0	};

% 	get(1, 3) ->
% 	#attrs{
% 		phy_att = 57,
% 		phy_def = 18,
% 		hp_lim = 164,
% 		dodge = 508,
% 		hit = 508,
% 		crit = 6,
% 		ten = 7,
% 		spr_att = 99,
% 		spr_def = 25,
% 		mag_att = 0,
% 		mag_def = 10,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 18,
		
% 		resis = 0	};

% 	get(1, 4) ->
% 	#attrs{
% 		phy_att = 59,
% 		phy_def = 21,
% 		hp_lim = 176,
% 		dodge = 512,
% 		hit = 512,
% 		crit = 8,
% 		ten = 8,
% 		spr_att = 103,
% 		spr_def = 29,
% 		mag_att = 0,
% 		mag_def = 11,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 21,
		
% 		resis = 0	};

% 	get(1, 5) ->
% 	#attrs{
% 		phy_att = 62,
% 		phy_def = 23,
% 		hp_lim = 186,
% 		dodge = 516,
% 		hit = 516,
% 		crit = 9,
% 		ten = 9,
% 		spr_att = 108,
% 		spr_def = 32,
% 		mag_att = 0,
% 		mag_def = 12,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 24,
		
% 		resis = 0	};

% 	get(1, 6) ->
% 	#attrs{
% 		phy_att = 64,
% 		phy_def = 26,
% 		hp_lim = 198,
% 		dodge = 520,
% 		hit = 520,
% 		crit = 11,
% 		ten = 10,
% 		spr_att = 112,
% 		spr_def = 36,
% 		mag_att = 0,
% 		mag_def = 14,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 27,
		
% 		resis = 0	};

% 	get(1, 7) ->
% 	#attrs{
% 		phy_att = 67,
% 		phy_def = 29,
% 		hp_lim = 207,
% 		dodge = 524,
% 		hit = 524,
% 		crit = 12,
% 		ten = 11,
% 		spr_att = 117,
% 		spr_def = 39,
% 		mag_att = 0,
% 		mag_def = 16,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 30,
		
% 		resis = 0	};

% 	get(1, 8) ->
% 	#attrs{
% 		phy_att = 69,
% 		phy_def = 32,
% 		hp_lim = 219,
% 		dodge = 528,
% 		hit = 528,
% 		crit = 14,
% 		ten = 12,
% 		spr_att = 121,
% 		spr_def = 43,
% 		mag_att = 0,
% 		mag_def = 17,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 33,
		
% 		resis = 0	};

% 	get(1, 9) ->
% 	#attrs{
% 		phy_att = 72,
% 		phy_def = 35,
% 		hp_lim = 229,
% 		dodge = 532,
% 		hit = 532,
% 		crit = 15,
% 		ten = 13,
% 		spr_att = 126,
% 		spr_def = 47,
% 		mag_att = 0,
% 		mag_def = 19,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 36,
		
% 		resis = 0	};

% 	get(1, 10) ->
% 	#attrs{
% 		phy_att = 73,
% 		phy_def = 38,
% 		hp_lim = 240,
% 		dodge = 536,
% 		hit = 536,
% 		crit = 17,
% 		ten = 14,
% 		spr_att = 128,
% 		spr_def = 51,
% 		mag_att = 0,
% 		mag_def = 20,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 39,
		
% 		resis = 0	};

% 	get(1, 11) ->
% 	#attrs{
% 		phy_att = 77,
% 		phy_def = 42,
% 		hp_lim = 255,
% 		dodge = 540,
% 		hit = 540,
% 		crit = 18,
% 		ten = 15,
% 		spr_att = 135,
% 		spr_def = 56,
% 		mag_att = 0,
% 		mag_def = 22,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 43,
		
% 		resis = 0	};

% 	get(1, 12) ->
% 	#attrs{
% 		phy_att = 81,
% 		phy_def = 45,
% 		hp_lim = 271,
% 		dodge = 544,
% 		hit = 544,
% 		crit = 20,
% 		ten = 16,
% 		spr_att = 142,
% 		spr_def = 60,
% 		mag_att = 0,
% 		mag_def = 24,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 47,
		
% 		resis = 0	};

% 	get(1, 13) ->
% 	#attrs{
% 		phy_att = 83,
% 		phy_def = 48,
% 		hp_lim = 287,
% 		dodge = 548,
% 		hit = 548,
% 		crit = 21,
% 		ten = 17,
% 		spr_att = 146,
% 		spr_def = 63,
% 		mag_att = 0,
% 		mag_def = 25,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 51,
		
% 		resis = 0	};

% 	get(1, 14) ->
% 	#attrs{
% 		phy_att = 87,
% 		phy_def = 52,
% 		hp_lim = 305,
% 		dodge = 552,
% 		hit = 552,
% 		crit = 23,
% 		ten = 18,
% 		spr_att = 153,
% 		spr_def = 69,
% 		mag_att = 0,
% 		mag_def = 28,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 55,
		
% 		resis = 0	};

% 	get(1, 15) ->
% 	#attrs{
% 		phy_att = 90,
% 		phy_def = 55,
% 		hp_lim = 321,
% 		dodge = 556,
% 		hit = 556,
% 		crit = 24,
% 		ten = 19,
% 		spr_att = 158,
% 		spr_def = 72,
% 		mag_att = 0,
% 		mag_def = 29,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 59,
		
% 		resis = 0	};

% 	get(1, 16) ->
% 	#attrs{
% 		phy_att = 94,
% 		phy_def = 59,
% 		hp_lim = 337,
% 		dodge = 560,
% 		hit = 560,
% 		crit = 26,
% 		ten = 20,
% 		spr_att = 165,
% 		spr_def = 77,
% 		mag_att = 0,
% 		mag_def = 31,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 63,
		
% 		resis = 0	};

% 	get(1, 17) ->
% 	#attrs{
% 		phy_att = 96,
% 		phy_def = 63,
% 		hp_lim = 355,
% 		dodge = 564,
% 		hit = 564,
% 		crit = 27,
% 		ten = 21,
% 		spr_att = 169,
% 		spr_def = 82,
% 		mag_att = 0,
% 		mag_def = 33,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 67,
		
% 		resis = 0	};

% 	get(1, 18) ->
% 	#attrs{
% 		phy_att = 100,
% 		phy_def = 67,
% 		hp_lim = 371,
% 		dodge = 568,
% 		hit = 568,
% 		crit = 29,
% 		ten = 22,
% 		spr_att = 176,
% 		spr_def = 87,
% 		mag_att = 0,
% 		mag_def = 35,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 71,
		
% 		resis = 0	};

% 	get(1, 19) ->
% 	#attrs{
% 		phy_att = 102,
% 		phy_def = 71,
% 		hp_lim = 387,
% 		dodge = 572,
% 		hit = 572,
% 		crit = 30,
% 		ten = 23,
% 		spr_att = 179,
% 		spr_def = 92,
% 		mag_att = 0,
% 		mag_def = 37,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 75,
		
% 		resis = 0	};

% 	get(1, 20) ->
% 	#attrs{
% 		phy_att = 106,
% 		phy_def = 75,
% 		hp_lim = 401,
% 		dodge = 576,
% 		hit = 576,
% 		crit = 32,
% 		ten = 24,
% 		spr_att = 186,
% 		spr_def = 97,
% 		mag_att = 0,
% 		mag_def = 39,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 79,
		
% 		resis = 0	};

% 	get(1, 21) ->
% 	#attrs{
% 		phy_att = 111,
% 		phy_def = 79,
% 		hp_lim = 430,
% 		dodge = 580,
% 		hit = 580,
% 		crit = 33,
% 		ten = 25,
% 		spr_att = 195,
% 		spr_def = 102,
% 		mag_att = 0,
% 		mag_def = 41,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 84,
		
% 		resis = 0	};

% 	get(1, 22) ->
% 	#attrs{
% 		phy_att = 115,
% 		phy_def = 83,
% 		hp_lim = 458,
% 		dodge = 584,
% 		hit = 584,
% 		crit = 35,
% 		ten = 26,
% 		spr_att = 202,
% 		spr_def = 107,
% 		mag_att = 0,
% 		mag_def = 43,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 89,
		
% 		resis = 0	};

% 	get(1, 23) ->
% 	#attrs{
% 		phy_att = 120,
% 		phy_def = 87,
% 		hp_lim = 486,
% 		dodge = 588,
% 		hit = 588,
% 		crit = 36,
% 		ten = 27,
% 		spr_att = 211,
% 		spr_def = 112,
% 		mag_att = 0,
% 		mag_def = 46,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 94,
		
% 		resis = 0	};

% 	get(1, 24) ->
% 	#attrs{
% 		phy_att = 125,
% 		phy_def = 91,
% 		hp_lim = 515,
% 		dodge = 592,
% 		hit = 592,
% 		crit = 38,
% 		ten = 28,
% 		spr_att = 219,
% 		spr_def = 117,
% 		mag_att = 0,
% 		mag_def = 47,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 99,
		
% 		resis = 0	};

% 	get(1, 25) ->
% 	#attrs{
% 		phy_att = 131,
% 		phy_def = 96,
% 		hp_lim = 543,
% 		dodge = 596,
% 		hit = 596,
% 		crit = 39,
% 		ten = 29,
% 		spr_att = 230,
% 		spr_def = 123,
% 		mag_att = 0,
% 		mag_def = 50,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 104,
		
% 		resis = 0	};

% 	get(1, 26) ->
% 	#attrs{
% 		phy_att = 134,
% 		phy_def = 100,
% 		hp_lim = 572,
% 		dodge = 600,
% 		hit = 600,
% 		crit = 41,
% 		ten = 30,
% 		spr_att = 235,
% 		spr_def = 128,
% 		mag_att = 0,
% 		mag_def = 52,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 109,
		
% 		resis = 0	};

% 	get(1, 27) ->
% 	#attrs{
% 		phy_att = 139,
% 		phy_def = 105,
% 		hp_lim = 600,
% 		dodge = 604,
% 		hit = 604,
% 		crit = 42,
% 		ten = 31,
% 		spr_att = 244,
% 		spr_def = 134,
% 		mag_att = 0,
% 		mag_def = 55,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 114,
		
% 		resis = 0	};

% 	get(1, 28) ->
% 	#attrs{
% 		phy_att = 145,
% 		phy_def = 109,
% 		hp_lim = 629,
% 		dodge = 608,
% 		hit = 608,
% 		crit = 44,
% 		ten = 32,
% 		spr_att = 254,
% 		spr_def = 139,
% 		mag_att = 0,
% 		mag_def = 57,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 119,
		
% 		resis = 0	};

% 	get(1, 29) ->
% 	#attrs{
% 		phy_att = 150,
% 		phy_def = 114,
% 		hp_lim = 657,
% 		dodge = 612,
% 		hit = 612,
% 		crit = 45,
% 		ten = 33,
% 		spr_att = 263,
% 		spr_def = 146,
% 		mag_att = 0,
% 		mag_def = 59,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 124,
		
% 		resis = 0	};

% 	get(1, 30) ->
% 	#attrs{
% 		phy_att = 153,
% 		phy_def = 119,
% 		hp_lim = 684,
% 		dodge = 616,
% 		hit = 616,
% 		crit = 47,
% 		ten = 34,
% 		spr_att = 268,
% 		spr_def = 151,
% 		mag_att = 0,
% 		mag_def = 62,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 129,
		
% 		resis = 0	};

% 	get(1, 31) ->
% 	#attrs{
% 		phy_att = 161,
% 		phy_def = 123,
% 		hp_lim = 730,
% 		dodge = 620,
% 		hit = 620,
% 		crit = 48,
% 		ten = 35,
% 		spr_att = 282,
% 		spr_def = 156,
% 		mag_att = 0,
% 		mag_def = 64,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 135,
		
% 		resis = 0	};

% 	get(1, 32) ->
% 	#attrs{
% 		phy_att = 169,
% 		phy_def = 128,
% 		hp_lim = 775,
% 		dodge = 624,
% 		hit = 624,
% 		crit = 50,
% 		ten = 36,
% 		spr_att = 296,
% 		spr_def = 163,
% 		mag_att = 0,
% 		mag_def = 67,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 141,
		
% 		resis = 0	};

% 	get(1, 33) ->
% 	#attrs{
% 		phy_att = 175,
% 		phy_def = 133,
% 		hp_lim = 826,
% 		dodge = 628,
% 		hit = 628,
% 		crit = 51,
% 		ten = 37,
% 		spr_att = 306,
% 		spr_def = 169,
% 		mag_att = 0,
% 		mag_def = 69,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 147,
		
% 		resis = 0	};

% 	get(1, 34) ->
% 	#attrs{
% 		phy_att = 183,
% 		phy_def = 138,
% 		hp_lim = 872,
% 		dodge = 632,
% 		hit = 632,
% 		crit = 53,
% 		ten = 38,
% 		spr_att = 320,
% 		spr_def = 175,
% 		mag_att = 0,
% 		mag_def = 71,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 153,
		
% 		resis = 0	};

% 	get(1, 35) ->
% 	#attrs{
% 		phy_att = 189,
% 		phy_def = 143,
% 		hp_lim = 918,
% 		dodge = 636,
% 		hit = 636,
% 		crit = 54,
% 		ten = 39,
% 		spr_att = 330,
% 		spr_def = 182,
% 		mag_att = 0,
% 		mag_def = 74,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 159,
		
% 		resis = 0	};

% 	get(1, 36) ->
% 	#attrs{
% 		phy_att = 197,
% 		phy_def = 148,
% 		hp_lim = 968,
% 		dodge = 640,
% 		hit = 640,
% 		crit = 56,
% 		ten = 40,
% 		spr_att = 344,
% 		spr_def = 188,
% 		mag_att = 0,
% 		mag_def = 77,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 165,
		
% 		resis = 0	};

% 	get(1, 37) ->
% 	#attrs{
% 		phy_att = 203,
% 		phy_def = 154,
% 		hp_lim = 1012,
% 		dodge = 644,
% 		hit = 644,
% 		crit = 57,
% 		ten = 41,
% 		spr_att = 355,
% 		spr_def = 196,
% 		mag_att = 0,
% 		mag_def = 80,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 171,
		
% 		resis = 0	};

% 	get(1, 38) ->
% 	#attrs{
% 		phy_att = 211,
% 		phy_def = 159,
% 		hp_lim = 1063,
% 		dodge = 648,
% 		hit = 648,
% 		crit = 59,
% 		ten = 42,
% 		spr_att = 369,
% 		spr_def = 202,
% 		mag_att = 0,
% 		mag_def = 83,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 177,
		
% 		resis = 0	};

% 	get(1, 39) ->
% 	#attrs{
% 		phy_att = 217,
% 		phy_def = 164,
% 		hp_lim = 1108,
% 		dodge = 652,
% 		hit = 652,
% 		crit = 60,
% 		ten = 43,
% 		spr_att = 379,
% 		spr_def = 208,
% 		mag_att = 0,
% 		mag_def = 85,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 183,
		
% 		resis = 0	};

% 	get(1, 40) ->
% 	#attrs{
% 		phy_att = 224,
% 		phy_def = 170,
% 		hp_lim = 1156,
% 		dodge = 656,
% 		hit = 656,
% 		crit = 62,
% 		ten = 44,
% 		spr_att = 391,
% 		spr_def = 214,
% 		mag_att = 0,
% 		mag_def = 88,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 189,
		
% 		resis = 0	};

% 	get(1, 41) ->
% 	#attrs{
% 		phy_att = 235,
% 		phy_def = 175,
% 		hp_lim = 1239,
% 		dodge = 660,
% 		hit = 660,
% 		crit = 63,
% 		ten = 45,
% 		spr_att = 410,
% 		spr_def = 220,
% 		mag_att = 0,
% 		mag_def = 90,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 196,
		
% 		resis = 0	};

% 	get(1, 42) ->
% 	#attrs{
% 		phy_att = 245,
% 		phy_def = 181,
% 		hp_lim = 1318,
% 		dodge = 664,
% 		hit = 664,
% 		crit = 65,
% 		ten = 46,
% 		spr_att = 427,
% 		spr_def = 229,
% 		mag_att = 0,
% 		mag_def = 94,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 203,
		
% 		resis = 0	};

% 	get(1, 43) ->
% 	#attrs{
% 		phy_att = 257,
% 		phy_def = 186,
% 		hp_lim = 1397,
% 		dodge = 668,
% 		hit = 668,
% 		crit = 66,
% 		ten = 47,
% 		spr_att = 448,
% 		spr_def = 235,
% 		mag_att = 0,
% 		mag_def = 96,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 210,
		
% 		resis = 0	};

% 	get(1, 44) ->
% 	#attrs{
% 		phy_att = 267,
% 		phy_def = 192,
% 		hp_lim = 1479,
% 		dodge = 672,
% 		hit = 672,
% 		crit = 68,
% 		ten = 48,
% 		spr_att = 465,
% 		spr_def = 242,
% 		mag_att = 0,
% 		mag_def = 99,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 217,
		
% 		resis = 0	};

% 	get(1, 45) ->
% 	#attrs{
% 		phy_att = 277,
% 		phy_def = 197,
% 		hp_lim = 1562,
% 		dodge = 676,
% 		hit = 676,
% 		crit = 69,
% 		ten = 49,
% 		spr_att = 482,
% 		spr_def = 248,
% 		mag_att = 0,
% 		mag_def = 102,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 224,
		
% 		resis = 0	};

% 	get(1, 46) ->
% 	#attrs{
% 		phy_att = 287,
% 		phy_def = 203,
% 		hp_lim = 1639,
% 		dodge = 680,
% 		hit = 680,
% 		crit = 71,
% 		ten = 50,
% 		spr_att = 499,
% 		spr_def = 255,
% 		mag_att = 0,
% 		mag_def = 105,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 231,
		
% 		resis = 0	};

% 	get(1, 47) ->
% 	#attrs{
% 		phy_att = 299,
% 		phy_def = 209,
% 		hp_lim = 1721,
% 		dodge = 684,
% 		hit = 684,
% 		crit = 72,
% 		ten = 51,
% 		spr_att = 520,
% 		spr_def = 262,
% 		mag_att = 0,
% 		mag_def = 108,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 238,
		
% 		resis = 0	};

% 	get(1, 48) ->
% 	#attrs{
% 		phy_att = 309,
% 		phy_def = 215,
% 		hp_lim = 1798,
% 		dodge = 688,
% 		hit = 688,
% 		crit = 74,
% 		ten = 52,
% 		spr_att = 538,
% 		spr_def = 271,
% 		mag_att = 0,
% 		mag_def = 111,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 245,
		
% 		resis = 0	};

% 	get(1, 49) ->
% 	#attrs{
% 		phy_att = 319,
% 		phy_def = 221,
% 		hp_lim = 1879,
% 		dodge = 692,
% 		hit = 692,
% 		crit = 75,
% 		ten = 53,
% 		spr_att = 555,
% 		spr_def = 278,
% 		mag_att = 0,
% 		mag_def = 114,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 252,
		
% 		resis = 0	};

% 	get(1, 50) ->
% 	#attrs{
% 		phy_att = 329,
% 		phy_def = 227,
% 		hp_lim = 1958,
% 		dodge = 696,
% 		hit = 696,
% 		crit = 77,
% 		ten = 54,
% 		spr_att = 572,
% 		spr_def = 285,
% 		mag_att = 0,
% 		mag_def = 117,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 259,
		
% 		resis = 0	};

% 	get(1, 51) ->
% 	#attrs{
% 		phy_att = 346,
% 		phy_def = 233,
% 		hp_lim = 2097,
% 		dodge = 700,
% 		hit = 700,
% 		crit = 78,
% 		ten = 55,
% 		spr_att = 601,
% 		spr_def = 293,
% 		mag_att = 0,
% 		mag_def = 120,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 267,
		
% 		resis = 0	};

% 	get(1, 52) ->
% 	#attrs{
% 		phy_att = 361,
% 		phy_def = 239,
% 		hp_lim = 2234,
% 		dodge = 704,
% 		hit = 704,
% 		crit = 80,
% 		ten = 56,
% 		spr_att = 627,
% 		spr_def = 300,
% 		mag_att = 0,
% 		mag_def = 123,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 275,
		
% 		resis = 0	};

% 	get(1, 53) ->
% 	#attrs{
% 		phy_att = 377,
% 		phy_def = 245,
% 		hp_lim = 2366,
% 		dodge = 708,
% 		hit = 708,
% 		crit = 81,
% 		ten = 57,
% 		spr_att = 655,
% 		spr_def = 307,
% 		mag_att = 0,
% 		mag_def = 126,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 283,
		
% 		resis = 0	};

% 	get(1, 54) ->
% 	#attrs{
% 		phy_att = 392,
% 		phy_def = 251,
% 		hp_lim = 2508,
% 		dodge = 712,
% 		hit = 712,
% 		crit = 83,
% 		ten = 58,
% 		spr_att = 680,
% 		spr_def = 315,
% 		mag_att = 0,
% 		mag_def = 130,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 291,
		
% 		resis = 0	};

% 	get(1, 55) ->
% 	#attrs{
% 		phy_att = 407,
% 		phy_def = 257,
% 		hp_lim = 2640,
% 		dodge = 716,
% 		hit = 716,
% 		crit = 84,
% 		ten = 59,
% 		spr_att = 706,
% 		spr_def = 322,
% 		mag_att = 0,
% 		mag_def = 133,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 299,
		
% 		resis = 0	};

% 	get(1, 56) ->
% 	#attrs{
% 		phy_att = 423,
% 		phy_def = 264,
% 		hp_lim = 2781,
% 		dodge = 720,
% 		hit = 720,
% 		crit = 86,
% 		ten = 60,
% 		spr_att = 733,
% 		spr_def = 330,
% 		mag_att = 0,
% 		mag_def = 136,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 307,
		
% 		resis = 0	};

% 	get(1, 57) ->
% 	#attrs{
% 		phy_att = 439,
% 		phy_def = 270,
% 		hp_lim = 2910,
% 		dodge = 724,
% 		hit = 724,
% 		crit = 87,
% 		ten = 61,
% 		spr_att = 762,
% 		spr_def = 338,
% 		mag_att = 0,
% 		mag_def = 139,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 315,
		
% 		resis = 0	};

% 	get(1, 58) ->
% 	#attrs{
% 		phy_att = 454,
% 		phy_def = 276,
% 		hp_lim = 3046,
% 		dodge = 728,
% 		hit = 728,
% 		crit = 89,
% 		ten = 62,
% 		spr_att = 787,
% 		spr_def = 346,
% 		mag_att = 0,
% 		mag_def = 142,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 323,
		
% 		resis = 0	};

% 	get(1, 59) ->
% 	#attrs{
% 		phy_att = 470,
% 		phy_def = 283,
% 		hp_lim = 3186,
% 		dodge = 732,
% 		hit = 732,
% 		crit = 90,
% 		ten = 63,
% 		spr_att = 814,
% 		spr_def = 354,
% 		mag_att = 0,
% 		mag_def = 146,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 331,
		
% 		resis = 0	};

% 	get(1, 60) ->
% 	#attrs{
% 		phy_att = 484,
% 		phy_def = 289,
% 		hp_lim = 3323,
% 		dodge = 736,
% 		hit = 736,
% 		crit = 92,
% 		ten = 64,
% 		spr_att = 839,
% 		spr_def = 362,
% 		mag_att = 0,
% 		mag_def = 149,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 339,
		
% 		resis = 0	};

% 	get(1, 61) ->
% 	#attrs{
% 		phy_att = 508,
% 		phy_def = 296,
% 		hp_lim = 3547,
% 		dodge = 740,
% 		hit = 740,
% 		crit = 93,
% 		ten = 65,
% 		spr_att = 880,
% 		spr_def = 370,
% 		mag_att = 0,
% 		mag_def = 152,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 348,
		
% 		resis = 0	};

% 	get(1, 62) ->
% 	#attrs{
% 		phy_att = 531,
% 		phy_def = 302,
% 		hp_lim = 3777,
% 		dodge = 744,
% 		hit = 744,
% 		crit = 95,
% 		ten = 66,
% 		spr_att = 920,
% 		spr_def = 378,
% 		mag_att = 0,
% 		mag_def = 156,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 357,
		
% 		resis = 0	};

% 	get(1, 63) ->
% 	#attrs{
% 		phy_att = 554,
% 		phy_def = 309,
% 		hp_lim = 4012,
% 		dodge = 748,
% 		hit = 748,
% 		crit = 96,
% 		ten = 67,
% 		spr_att = 959,
% 		spr_def = 386,
% 		mag_att = 0,
% 		mag_def = 159,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 366,
		
% 		resis = 0	};

% 	get(1, 64) ->
% 	#attrs{
% 		phy_att = 576,
% 		phy_def = 315,
% 		hp_lim = 4243,
% 		dodge = 752,
% 		hit = 752,
% 		crit = 98,
% 		ten = 68,
% 		spr_att = 997,
% 		spr_def = 395,
% 		mag_att = 0,
% 		mag_def = 163,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 375,
		
% 		resis = 0	};

% 	get(1, 65) ->
% 	#attrs{
% 		phy_att = 598,
% 		phy_def = 322,
% 		hp_lim = 4467,
% 		dodge = 756,
% 		hit = 756,
% 		crit = 99,
% 		ten = 69,
% 		spr_att = 1035,
% 		spr_def = 403,
% 		mag_att = 0,
% 		mag_def = 166,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 384,
		
% 		resis = 0	};

% 	get(1, 66) ->
% 	#attrs{
% 		phy_att = 621,
% 		phy_def = 329,
% 		hp_lim = 4697,
% 		dodge = 760,
% 		hit = 760,
% 		crit = 101,
% 		ten = 70,
% 		spr_att = 1074,
% 		spr_def = 412,
% 		mag_att = 0,
% 		mag_def = 170,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 393,
		
% 		resis = 0	};

% 	get(1, 67) ->
% 	#attrs{
% 		phy_att = 644,
% 		phy_def = 335,
% 		hp_lim = 4934,
% 		dodge = 764,
% 		hit = 764,
% 		crit = 102,
% 		ten = 71,
% 		spr_att = 1113,
% 		spr_def = 417,
% 		mag_att = 0,
% 		mag_def = 172,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 402,
		
% 		resis = 0	};

% 	get(1, 68) ->
% 	#attrs{
% 		phy_att = 667,
% 		phy_def = 342,
% 		hp_lim = 5165,
% 		dodge = 768,
% 		hit = 768,
% 		crit = 104,
% 		ten = 72,
% 		spr_att = 1153,
% 		spr_def = 426,
% 		mag_att = 0,
% 		mag_def = 176,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 411,
		
% 		resis = 0	};

% 	get(1, 69) ->
% 	#attrs{
% 		phy_att = 690,
% 		phy_def = 349,
% 		hp_lim = 5396,
% 		dodge = 772,
% 		hit = 772,
% 		crit = 105,
% 		ten = 73,
% 		spr_att = 1192,
% 		spr_def = 435,
% 		mag_att = 0,
% 		mag_def = 179,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 420,
		
% 		resis = 0	};

% 	get(1, 70) ->
% 	#attrs{
% 		phy_att = 712,
% 		phy_def = 356,
% 		hp_lim = 5625,
% 		dodge = 776,
% 		hit = 776,
% 		crit = 107,
% 		ten = 74,
% 		spr_att = 1230,
% 		spr_def = 443,
% 		mag_att = 0,
% 		mag_def = 183,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 429,
		
% 		resis = 0	};

% 	get(1, 71) ->
% 	#attrs{
% 		phy_att = 746,
% 		phy_def = 363,
% 		hp_lim = 6012,
% 		dodge = 780,
% 		hit = 780,
% 		crit = 108,
% 		ten = 75,
% 		spr_att = 1289,
% 		spr_def = 452,
% 		mag_att = 0,
% 		mag_def = 187,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 439,
		
% 		resis = 0	};

% 	get(1, 72) ->
% 	#attrs{
% 		phy_att = 780,
% 		phy_def = 370,
% 		hp_lim = 6397,
% 		dodge = 784,
% 		hit = 784,
% 		crit = 110,
% 		ten = 76,
% 		spr_att = 1348,
% 		spr_def = 462,
% 		mag_att = 0,
% 		mag_def = 191,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 449,
		
% 		resis = 0	};

% 	get(1, 73) ->
% 	#attrs{
% 		phy_att = 813,
% 		phy_def = 376,
% 		hp_lim = 6790,
% 		dodge = 788,
% 		hit = 788,
% 		crit = 111,
% 		ten = 77,
% 		spr_att = 1403,
% 		spr_def = 467,
% 		mag_att = 0,
% 		mag_def = 193,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 459,
		
% 		resis = 0	};

% 	get(1, 74) ->
% 	#attrs{
% 		phy_att = 846,
% 		phy_def = 383,
% 		hp_lim = 7183,
% 		dodge = 792,
% 		hit = 792,
% 		crit = 113,
% 		ten = 78,
% 		spr_att = 1460,
% 		spr_def = 476,
% 		mag_att = 0,
% 		mag_def = 197,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 469,
		
% 		resis = 0	};

% 	get(1, 75) ->
% 	#attrs{
% 		phy_att = 880,
% 		phy_def = 390,
% 		hp_lim = 7568,
% 		dodge = 796,
% 		hit = 796,
% 		crit = 114,
% 		ten = 79,
% 		spr_att = 1518,
% 		spr_def = 486,
% 		mag_att = 0,
% 		mag_def = 201,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 479,
		
% 		resis = 0	};

% 	get(1, 76) ->
% 	#attrs{
% 		phy_att = 913,
% 		phy_def = 397,
% 		hp_lim = 7954,
% 		dodge = 800,
% 		hit = 800,
% 		crit = 116,
% 		ten = 80,
% 		spr_att = 1575,
% 		spr_def = 495,
% 		mag_att = 0,
% 		mag_def = 205,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 489,
		
% 		resis = 0	};

% 	get(1, 77) ->
% 	#attrs{
% 		phy_att = 947,
% 		phy_def = 405,
% 		hp_lim = 8339,
% 		dodge = 804,
% 		hit = 804,
% 		crit = 117,
% 		ten = 81,
% 		spr_att = 1634,
% 		spr_def = 505,
% 		mag_att = 0,
% 		mag_def = 209,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 499,
		
% 		resis = 0	};

% 	get(1, 78) ->
% 	#attrs{
% 		phy_att = 980,
% 		phy_def = 412,
% 		hp_lim = 8733,
% 		dodge = 808,
% 		hit = 808,
% 		crit = 119,
% 		ten = 82,
% 		spr_att = 1691,
% 		spr_def = 514,
% 		mag_att = 0,
% 		mag_def = 213,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 509,
		
% 		resis = 0	};

% 	get(1, 79) ->
% 	#attrs{
% 		phy_att = 1014,
% 		phy_def = 419,
% 		hp_lim = 9130,
% 		dodge = 812,
% 		hit = 812,
% 		crit = 120,
% 		ten = 83,
% 		spr_att = 1747,
% 		spr_def = 520,
% 		mag_att = 0,
% 		mag_def = 215,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 519,
		
% 		resis = 0	};

% 	get(1, 80) ->
% 	#attrs{
% 		phy_att = 1047,
% 		phy_def = 426,
% 		hp_lim = 9518,
% 		dodge = 816,
% 		hit = 816,
% 		crit = 122,
% 		ten = 84,
% 		spr_att = 1804,
% 		spr_def = 530,
% 		mag_att = 0,
% 		mag_def = 219,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 529,
		
% 		resis = 0	};

% 	get(1, 81) ->
% 	#attrs{
% 		phy_att = 1097,
% 		phy_def = 433,
% 		hp_lim = 10173,
% 		dodge = 820,
% 		hit = 820,
% 		crit = 123,
% 		ten = 85,
% 		spr_att = 1890,
% 		spr_def = 540,
% 		mag_att = 0,
% 		mag_def = 223,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 540,
		
% 		resis = 0	};

% 	get(1, 82) ->
% 	#attrs{
% 		phy_att = 1145,
% 		phy_def = 440,
% 		hp_lim = 10833,
% 		dodge = 824,
% 		hit = 824,
% 		crit = 125,
% 		ten = 86,
% 		spr_att = 1973,
% 		spr_def = 545,
% 		mag_att = 0,
% 		mag_def = 226,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 551,
		
% 		resis = 0	};

% 	get(1, 83) ->
% 	#attrs{
% 		phy_att = 1195,
% 		phy_def = 448,
% 		hp_lim = 11482,
% 		dodge = 828,
% 		hit = 828,
% 		crit = 126,
% 		ten = 87,
% 		spr_att = 2059,
% 		spr_def = 555,
% 		mag_att = 0,
% 		mag_def = 230,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 562,
		
% 		resis = 0	};

% 	get(1, 84) ->
% 	#attrs{
% 		phy_att = 1245,
% 		phy_def = 455,
% 		hp_lim = 12142,
% 		dodge = 832,
% 		hit = 832,
% 		crit = 128,
% 		ten = 88,
% 		spr_att = 2145,
% 		spr_def = 565,
% 		mag_att = 0,
% 		mag_def = 234,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 573,
		
% 		resis = 0	};

% 	get(1, 85) ->
% 	#attrs{
% 		phy_att = 1293,
% 		phy_def = 462,
% 		hp_lim = 12792,
% 		dodge = 836,
% 		hit = 836,
% 		crit = 129,
% 		ten = 89,
% 		spr_att = 2227,
% 		spr_def = 576,
% 		mag_att = 0,
% 		mag_def = 238,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 584,
		
% 		resis = 0	};

% 	get(1, 86) ->
% 	#attrs{
% 		phy_att = 1343,
% 		phy_def = 469,
% 		hp_lim = 13465,
% 		dodge = 840,
% 		hit = 840,
% 		crit = 131,
% 		ten = 90,
% 		spr_att = 2311,
% 		spr_def = 582,
% 		mag_att = 0,
% 		mag_def = 241,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 595,
		
% 		resis = 0	};

% 	get(1, 87) ->
% 	#attrs{
% 		phy_att = 1393,
% 		phy_def = 477,
% 		hp_lim = 14110,
% 		dodge = 844,
% 		hit = 844,
% 		crit = 132,
% 		ten = 91,
% 		spr_att = 2400,
% 		spr_def = 592,
% 		mag_att = 0,
% 		mag_def = 245,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 606,
		
% 		resis = 0	};

% 	get(1, 88) ->
% 	#attrs{
% 		phy_att = 1443,
% 		phy_def = 484,
% 		hp_lim = 14759,
% 		dodge = 848,
% 		hit = 848,
% 		crit = 134,
% 		ten = 92,
% 		spr_att = 2486,
% 		spr_def = 602,
% 		mag_att = 0,
% 		mag_def = 249,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 617,
		
% 		resis = 0	};

% 	get(1, 89) ->
% 	#attrs{
% 		phy_att = 1491,
% 		phy_def = 491,
% 		hp_lim = 15439,
% 		dodge = 852,
% 		hit = 852,
% 		crit = 135,
% 		ten = 93,
% 		spr_att = 2565,
% 		spr_def = 608,
% 		mag_att = 0,
% 		mag_def = 252,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 628,
		
% 		resis = 0	};

% 	get(1, 90) ->
% 	#attrs{
% 		phy_att = 1540,
% 		phy_def = 499,
% 		hp_lim = 16091,
% 		dodge = 856,
% 		hit = 856,
% 		crit = 137,
% 		ten = 94,
% 		spr_att = 2649,
% 		spr_def = 619,
% 		mag_att = 0,
% 		mag_def = 256,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 639,
		
% 		resis = 0	};

% 	get(1, 91) ->
% 	#attrs{
% 		phy_att = 1606,
% 		phy_def = 506,
% 		hp_lim = 16992,
% 		dodge = 860,
% 		hit = 860,
% 		crit = 138,
% 		ten = 95,
% 		spr_att = 2766,
% 		spr_def = 630,
% 		mag_att = 0,
% 		mag_def = 261,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 651,
		
% 		resis = 0	};

% 	get(1, 92) ->
% 	#attrs{
% 		phy_att = 1671,
% 		phy_def = 513,
% 		hp_lim = 17945,
% 		dodge = 864,
% 		hit = 864,
% 		crit = 140,
% 		ten = 96,
% 		spr_att = 2875,
% 		spr_def = 636,
% 		mag_att = 0,
% 		mag_def = 263,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 663,
		
% 		resis = 0	};

% 	get(1, 93) ->
% 	#attrs{
% 		phy_att = 1736,
% 		phy_def = 521,
% 		hp_lim = 18861,
% 		dodge = 868,
% 		hit = 868,
% 		crit = 141,
% 		ten = 97,
% 		spr_att = 2986,
% 		spr_def = 647,
% 		mag_att = 0,
% 		mag_def = 268,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 675,
		
% 		resis = 0	};

% 	get(1, 94) ->
% 	#attrs{
% 		phy_att = 1802,
% 		phy_def = 528,
% 		hp_lim = 19785,
% 		dodge = 872,
% 		hit = 872,
% 		crit = 143,
% 		ten = 98,
% 		spr_att = 3100,
% 		spr_def = 653,
% 		mag_att = 0,
% 		mag_def = 271,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 687,
		
% 		resis = 0	};

% 	get(1, 95) ->
% 	#attrs{
% 		phy_att = 1867,
% 		phy_def = 536,
% 		hp_lim = 20711,
% 		dodge = 876,
% 		hit = 876,
% 		crit = 144,
% 		ten = 99,
% 		spr_att = 3211,
% 		spr_def = 664,
% 		mag_att = 0,
% 		mag_def = 275,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 699,
		
% 		resis = 0	};

% 	get(1, 96) ->
% 	#attrs{
% 		phy_att = 1932,
% 		phy_def = 543,
% 		hp_lim = 21634,
% 		dodge = 880,
% 		hit = 880,
% 		crit = 146,
% 		ten = 100,
% 		spr_att = 3323,
% 		spr_def = 675,
% 		mag_att = 0,
% 		mag_def = 280,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 711,
		
% 		resis = 0	};

% 	get(1, 97) ->
% 	#attrs{
% 		phy_att = 1997,
% 		phy_def = 551,
% 		hp_lim = 22559,
% 		dodge = 884,
% 		hit = 884,
% 		crit = 147,
% 		ten = 101,
% 		spr_att = 3435,
% 		spr_def = 681,
% 		mag_att = 0,
% 		mag_def = 282,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 723,
		
% 		resis = 0	};

% 	get(1, 98) ->
% 	#attrs{
% 		phy_att = 2062,
% 		phy_def = 558,
% 		hp_lim = 23485,
% 		dodge = 888,
% 		hit = 888,
% 		crit = 149,
% 		ten = 102,
% 		spr_att = 3547,
% 		spr_def = 692,
% 		mag_att = 0,
% 		mag_def = 287,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 735,
		
% 		resis = 0	};

% 	get(1, 99) ->
% 	#attrs{
% 		phy_att = 2127,
% 		phy_def = 566,
% 		hp_lim = 24410,
% 		dodge = 892,
% 		hit = 892,
% 		crit = 150,
% 		ten = 103,
% 		spr_att = 3658,
% 		spr_def = 699,
% 		mag_att = 0,
% 		mag_def = 290,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 747,
		
% 		resis = 0	};

% 	get(1, 100) ->
% 	#attrs{
% 		phy_att = 2192,
% 		phy_def = 573,
% 		hp_lim = 25332,
% 		dodge = 896,
% 		hit = 896,
% 		crit = 152,
% 		ten = 104,
% 		spr_att = 3770,
% 		spr_def = 710,
% 		mag_att = 0,
% 		mag_def = 294,
% 		pro_sword = 100,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 759,
		
% 		resis = 0	};

% 	get(3, 1) ->
% 	#attrs{
% 		phy_att = 40,
% 		phy_def = 21,
% 		hp_lim = 180,
% 		dodge = 120,
% 		hit = 150,
% 		crit = 150,
% 		ten = 32,
% 		spr_att = 77,
% 		spr_def = 30,
% 		mag_att = 0,
% 		mag_def = 12,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 8,
		
% 		resis = 0	};

% 	get(3, 2) ->
% 	#attrs{
% 		phy_att = 42,
% 		phy_def = 23,
% 		hp_lim = 194,
% 		dodge = 124,
% 		hit = 154,
% 		crit = 152,
% 		ten = 33,
% 		spr_att = 81,
% 		spr_def = 33,
% 		mag_att = 0,
% 		mag_def = 13,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 10,
		
% 		resis = 0	};

% 	get(3, 3) ->
% 	#attrs{
% 		phy_att = 44,
% 		phy_def = 26,
% 		hp_lim = 208,
% 		dodge = 128,
% 		hit = 158,
% 		crit = 154,
% 		ten = 34,
% 		spr_att = 84,
% 		spr_def = 36,
% 		mag_att = 0,
% 		mag_def = 14,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 12,
		
% 		resis = 0	};

% 	get(3, 4) ->
% 	#attrs{
% 		phy_att = 46,
% 		phy_def = 29,
% 		hp_lim = 221,
% 		dodge = 132,
% 		hit = 162,
% 		crit = 156,
% 		ten = 35,
% 		spr_att = 88,
% 		spr_def = 40,
% 		mag_att = 0,
% 		mag_def = 16,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 14,
		
% 		resis = 0	};

% 	get(3, 5) ->
% 	#attrs{
% 		phy_att = 48,
% 		phy_def = 32,
% 		hp_lim = 235,
% 		dodge = 135,
% 		hit = 165,
% 		crit = 158,
% 		ten = 36,
% 		spr_att = 92,
% 		spr_def = 44,
% 		mag_att = 0,
% 		mag_def = 17,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 16,
		
% 		resis = 0	};

% 	get(3, 6) ->
% 	#attrs{
% 		phy_att = 50,
% 		phy_def = 34,
% 		hp_lim = 249,
% 		dodge = 139,
% 		hit = 169,
% 		crit = 160,
% 		ten = 37,
% 		spr_att = 96,
% 		spr_def = 46,
% 		mag_att = 0,
% 		mag_def = 18,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 18,
		
% 		resis = 0	};

% 	get(3, 7) ->
% 	#attrs{
% 		phy_att = 52,
% 		phy_def = 37,
% 		hp_lim = 262,
% 		dodge = 143,
% 		hit = 173,
% 		crit = 162,
% 		ten = 38,
% 		spr_att = 100,
% 		spr_def = 50,
% 		mag_att = 0,
% 		mag_def = 20,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 20,
		
% 		resis = 0	};

% 	get(3, 8) ->
% 	#attrs{
% 		phy_att = 54,
% 		phy_def = 40,
% 		hp_lim = 276,
% 		dodge = 146,
% 		hit = 176,
% 		crit = 164,
% 		ten = 39,
% 		spr_att = 103,
% 		spr_def = 54,
% 		mag_att = 0,
% 		mag_def = 21,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 22,
		
% 		resis = 0	};

% 	get(3, 9) ->
% 	#attrs{
% 		phy_att = 56,
% 		phy_def = 43,
% 		hp_lim = 290,
% 		dodge = 150,
% 		hit = 180,
% 		crit = 166,
% 		ten = 40,
% 		spr_att = 107,
% 		spr_def = 57,
% 		mag_att = 0,
% 		mag_def = 23,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 24,
		
% 		resis = 0	};

% 	get(3, 10) ->
% 	#attrs{
% 		phy_att = 57,
% 		phy_def = 46,
% 		hp_lim = 303,
% 		dodge = 154,
% 		hit = 184,
% 		crit = 168,
% 		ten = 41,
% 		spr_att = 109,
% 		spr_def = 62,
% 		mag_att = 0,
% 		mag_def = 24,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 26,
		
% 		resis = 0	};

% 	get(3, 11) ->
% 	#attrs{
% 		phy_att = 60,
% 		phy_def = 49,
% 		hp_lim = 324,
% 		dodge = 157,
% 		hit = 187,
% 		crit = 170,
% 		ten = 42,
% 		spr_att = 115,
% 		spr_def = 65,
% 		mag_att = 0,
% 		mag_def = 26,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 29,
		
% 		resis = 0	};

% 	get(3, 12) ->
% 	#attrs{
% 		phy_att = 63,
% 		phy_def = 52,
% 		hp_lim = 345,
% 		dodge = 161,
% 		hit = 191,
% 		crit = 172,
% 		ten = 43,
% 		spr_att = 121,
% 		spr_def = 68,
% 		mag_att = 0,
% 		mag_def = 27,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 32,
		
% 		resis = 0	};

% 	get(3, 13) ->
% 	#attrs{
% 		phy_att = 65,
% 		phy_def = 56,
% 		hp_lim = 366,
% 		dodge = 165,
% 		hit = 195,
% 		crit = 174,
% 		ten = 44,
% 		spr_att = 124,
% 		spr_def = 74,
% 		mag_att = 0,
% 		mag_def = 30,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 35,
		
% 		resis = 0	};

% 	get(3, 14) ->
% 	#attrs{
% 		phy_att = 68,
% 		phy_def = 59,
% 		hp_lim = 387,
% 		dodge = 169,
% 		hit = 199,
% 		crit = 176,
% 		ten = 45,
% 		spr_att = 130,
% 		spr_def = 77,
% 		mag_att = 0,
% 		mag_def = 31,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 38,
		
% 		resis = 0	};

% 	get(3, 15) ->
% 	#attrs{
% 		phy_att = 70,
% 		phy_def = 63,
% 		hp_lim = 408,
% 		dodge = 172,
% 		hit = 202,
% 		crit = 178,
% 		ten = 46,
% 		spr_att = 134,
% 		spr_def = 82,
% 		mag_att = 0,
% 		mag_def = 33,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 41,
		
% 		resis = 0	};

% 	get(3, 16) ->
% 	#attrs{
% 		phy_att = 73,
% 		phy_def = 67,
% 		hp_lim = 429,
% 		dodge = 176,
% 		hit = 206,
% 		crit = 180,
% 		ten = 47,
% 		spr_att = 140,
% 		spr_def = 87,
% 		mag_att = 0,
% 		mag_def = 35,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 44,
		
% 		resis = 0	};

% 	get(3, 17) ->
% 	#attrs{
% 		phy_att = 75,
% 		phy_def = 71,
% 		hp_lim = 449,
% 		dodge = 180,
% 		hit = 210,
% 		crit = 182,
% 		ten = 48,
% 		spr_att = 143,
% 		spr_def = 93,
% 		mag_att = 0,
% 		mag_def = 37,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 47,
		
% 		resis = 0	};

% 	get(3, 18) ->
% 	#attrs{
% 		phy_att = 78,
% 		phy_def = 75,
% 		hp_lim = 470,
% 		dodge = 183,
% 		hit = 213,
% 		crit = 184,
% 		ten = 49,
% 		spr_att = 149,
% 		spr_def = 97,
% 		mag_att = 0,
% 		mag_def = 39,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 50,
		
% 		resis = 0	};

% 	get(3, 19) ->
% 	#attrs{
% 		phy_att = 80,
% 		phy_def = 79,
% 		hp_lim = 491,
% 		dodge = 187,
% 		hit = 217,
% 		crit = 186,
% 		ten = 50,
% 		spr_att = 153,
% 		spr_def = 103,
% 		mag_att = 0,
% 		mag_def = 41,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 53,
		
% 		resis = 0	};

% 	get(3, 20) ->
% 	#attrs{
% 		phy_att = 82,
% 		phy_def = 83,
% 		hp_lim = 511,
% 		dodge = 191,
% 		hit = 221,
% 		crit = 188,
% 		ten = 52,
% 		spr_att = 157,
% 		spr_def = 107,
% 		mag_att = 0,
% 		mag_def = 43,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 56,
		
% 		resis = 0	};

% 	get(3, 21) ->
% 	#attrs{
% 		phy_att = 87,
% 		phy_def = 88,
% 		hp_lim = 547,
% 		dodge = 194,
% 		hit = 224,
% 		crit = 190,
% 		ten = 53,
% 		spr_att = 166,
% 		spr_def = 113,
% 		mag_att = 0,
% 		mag_def = 46,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 60,
		
% 		resis = 0	};

% 	get(3, 22) ->
% 	#attrs{
% 		phy_att = 90,
% 		phy_def = 92,
% 		hp_lim = 582,
% 		dodge = 198,
% 		hit = 228,
% 		crit = 192,
% 		ten = 54,
% 		spr_att = 172,
% 		spr_def = 119,
% 		mag_att = 0,
% 		mag_def = 48,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 64,
		
% 		resis = 0	};

% 	get(3, 23) ->
% 	#attrs{
% 		phy_att = 94,
% 		phy_def = 97,
% 		hp_lim = 617,
% 		dodge = 202,
% 		hit = 232,
% 		crit = 194,
% 		ten = 55,
% 		spr_att = 180,
% 		spr_def = 125,
% 		mag_att = 0,
% 		mag_def = 51,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 68,
		
% 		resis = 0	};

% 	get(3, 24) ->
% 	#attrs{
% 		phy_att = 98,
% 		phy_def = 102,
% 		hp_lim = 652,
% 		dodge = 206,
% 		hit = 236,
% 		crit = 196,
% 		ten = 56,
% 		spr_att = 187,
% 		spr_def = 130,
% 		mag_att = 0,
% 		mag_def = 53,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 72,
		
% 		resis = 0	};

% 	get(3, 25) ->
% 	#attrs{
% 		phy_att = 102,
% 		phy_def = 107,
% 		hp_lim = 687,
% 		dodge = 209,
% 		hit = 239,
% 		crit = 198,
% 		ten = 57,
% 		spr_att = 195,
% 		spr_def = 137,
% 		mag_att = 0,
% 		mag_def = 56,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 76,
		
% 		resis = 0	};

% 	get(3, 26) ->
% 	#attrs{
% 		phy_att = 105,
% 		phy_def = 112,
% 		hp_lim = 723,
% 		dodge = 213,
% 		hit = 243,
% 		crit = 200,
% 		ten = 58,
% 		spr_att = 201,
% 		spr_def = 144,
% 		mag_att = 0,
% 		mag_def = 58,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 80,
		
% 		resis = 0	};

% 	get(3, 27) ->
% 	#attrs{
% 		phy_att = 109,
% 		phy_def = 117,
% 		hp_lim = 758,
% 		dodge = 217,
% 		hit = 247,
% 		crit = 202,
% 		ten = 59,
% 		spr_att = 208,
% 		spr_def = 149,
% 		mag_att = 0,
% 		mag_def = 61,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 84,
		
% 		resis = 0	};

% 	get(3, 28) ->
% 	#attrs{
% 		phy_att = 113,
% 		phy_def = 122,
% 		hp_lim = 793,
% 		dodge = 220,
% 		hit = 250,
% 		crit = 204,
% 		ten = 60,
% 		spr_att = 216,
% 		spr_def = 156,
% 		mag_att = 0,
% 		mag_def = 63,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 88,
		
% 		resis = 0	};

% 	get(3, 29) ->
% 	#attrs{
% 		phy_att = 117,
% 		phy_def = 128,
% 		hp_lim = 828,
% 		dodge = 224,
% 		hit = 254,
% 		crit = 206,
% 		ten = 61,
% 		spr_att = 223,
% 		spr_def = 163,
% 		mag_att = 0,
% 		mag_def = 66,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 92,
		
% 		resis = 0	};

% 	get(3, 30) ->
% 	#attrs{
% 		phy_att = 120,
% 		phy_def = 133,
% 		hp_lim = 862,
% 		dodge = 228,
% 		hit = 258,
% 		crit = 208,
% 		ten = 62,
% 		spr_att = 229,
% 		spr_def = 169,
% 		mag_att = 0,
% 		mag_def = 69,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 96,
		
% 		resis = 0	};

% 	get(3, 31) ->
% 	#attrs{
% 		phy_att = 126,
% 		phy_def = 139,
% 		hp_lim = 922,
% 		dodge = 231,
% 		hit = 261,
% 		crit = 210,
% 		ten = 63,
% 		spr_att = 241,
% 		spr_def = 176,
% 		mag_att = 0,
% 		mag_def = 72,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 101,
		
% 		resis = 0	};

% 	get(3, 32) ->
% 	#attrs{
% 		phy_att = 132,
% 		phy_def = 144,
% 		hp_lim = 981,
% 		dodge = 235,
% 		hit = 265,
% 		crit = 212,
% 		ten = 64,
% 		spr_att = 252,
% 		spr_def = 182,
% 		mag_att = 0,
% 		mag_def = 74,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 106,
		
% 		resis = 0	};

% 	get(3, 33) ->
% 	#attrs{
% 		phy_att = 137,
% 		phy_def = 150,
% 		hp_lim = 1041,
% 		dodge = 239,
% 		hit = 269,
% 		crit = 214,
% 		ten = 65,
% 		spr_att = 262,
% 		spr_def = 190,
% 		mag_att = 0,
% 		mag_def = 77,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 111,
		
% 		resis = 0	};

% 	get(3, 34) ->
% 	#attrs{
% 		phy_att = 143,
% 		phy_def = 156,
% 		hp_lim = 1100,
% 		dodge = 243,
% 		hit = 273,
% 		crit = 216,
% 		ten = 66,
% 		spr_att = 273,
% 		spr_def = 198,
% 		mag_att = 0,
% 		mag_def = 81,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 116,
		
% 		resis = 0	};

% 	get(3, 35) ->
% 	#attrs{
% 		phy_att = 148,
% 		phy_def = 162,
% 		hp_lim = 1159,
% 		dodge = 246,
% 		hit = 276,
% 		crit = 218,
% 		ten = 67,
% 		spr_att = 283,
% 		spr_def = 206,
% 		mag_att = 0,
% 		mag_def = 84,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 121,
		
% 		resis = 0	};

% 	get(3, 36) ->
% 	#attrs{
% 		phy_att = 154,
% 		phy_def = 168,
% 		hp_lim = 1218,
% 		dodge = 250,
% 		hit = 280,
% 		crit = 220,
% 		ten = 68,
% 		spr_att = 294,
% 		spr_def = 212,
% 		mag_att = 0,
% 		mag_def = 87,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 126,
		
% 		resis = 0	};

% 	get(3, 37) ->
% 	#attrs{
% 		phy_att = 159,
% 		phy_def = 174,
% 		hp_lim = 1278,
% 		dodge = 254,
% 		hit = 284,
% 		crit = 222,
% 		ten = 69,
% 		spr_att = 304,
% 		spr_def = 221,
% 		mag_att = 0,
% 		mag_def = 90,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 131,
		
% 		resis = 0	};

% 	get(3, 38) ->
% 	#attrs{
% 		phy_att = 165,
% 		phy_def = 180,
% 		hp_lim = 1337,
% 		dodge = 257,
% 		hit = 287,
% 		crit = 224,
% 		ten = 70,
% 		spr_att = 315,
% 		spr_def = 227,
% 		mag_att = 0,
% 		mag_def = 93,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 136,
		
% 		resis = 0	};

% 	get(3, 39) ->
% 	#attrs{
% 		phy_att = 170,
% 		phy_def = 186,
% 		hp_lim = 1396,
% 		dodge = 261,
% 		hit = 291,
% 		crit = 226,
% 		ten = 71,
% 		spr_att = 325,
% 		spr_def = 234,
% 		mag_att = 0,
% 		mag_def = 96,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 141,
		
% 		resis = 0	};

% 	get(3, 40) ->
% 	#attrs{
% 		phy_att = 175,
% 		phy_def = 193,
% 		hp_lim = 1455,
% 		dodge = 265,
% 		hit = 295,
% 		crit = 228,
% 		ten = 73,
% 		spr_att = 334,
% 		spr_def = 243,
% 		mag_att = 0,
% 		mag_def = 99,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 146,
		
% 		resis = 0	};

% 	get(3, 41) ->
% 	#attrs{
% 		phy_att = 184,
% 		phy_def = 199,
% 		hp_lim = 1556,
% 		dodge = 268,
% 		hit = 298,
% 		crit = 230,
% 		ten = 74,
% 		spr_att = 351,
% 		spr_def = 252,
% 		mag_att = 0,
% 		mag_def = 103,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 152,
		
% 		resis = 0	};

% 	get(3, 42) ->
% 	#attrs{
% 		phy_att = 192,
% 		phy_def = 206,
% 		hp_lim = 1656,
% 		dodge = 272,
% 		hit = 302,
% 		crit = 232,
% 		ten = 75,
% 		spr_att = 366,
% 		spr_def = 259,
% 		mag_att = 0,
% 		mag_def = 106,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 158,
		
% 		resis = 0	};

% 	get(3, 43) ->
% 	#attrs{
% 		phy_att = 201,
% 		phy_def = 213,
% 		hp_lim = 1756,
% 		dodge = 276,
% 		hit = 306,
% 		crit = 234,
% 		ten = 76,
% 		spr_att = 384,
% 		spr_def = 268,
% 		mag_att = 0,
% 		mag_def = 110,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 164,
		
% 		resis = 0	};

% 	get(3, 44) ->
% 	#attrs{
% 		phy_att = 209,
% 		phy_def = 219,
% 		hp_lim = 1856,
% 		dodge = 280,
% 		hit = 310,
% 		crit = 236,
% 		ten = 77,
% 		spr_att = 399,
% 		spr_def = 276,
% 		mag_att = 0,
% 		mag_def = 113,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 170,
		
% 		resis = 0	};

% 	get(3, 45) ->
% 	#attrs{
% 		phy_att = 217,
% 		phy_def = 226,
% 		hp_lim = 1956,
% 		dodge = 283,
% 		hit = 313,
% 		crit = 238,
% 		ten = 78,
% 		spr_att = 414,
% 		spr_def = 285,
% 		mag_att = 0,
% 		mag_def = 117,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 176,
		
% 		resis = 0	};

% 	get(3, 46) ->
% 	#attrs{
% 		phy_att = 225,
% 		phy_def = 233,
% 		hp_lim = 2056,
% 		dodge = 287,
% 		hit = 317,
% 		crit = 240,
% 		ten = 79,
% 		spr_att = 429,
% 		spr_def = 293,
% 		mag_att = 0,
% 		mag_def = 120,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 182,
		
% 		resis = 0	};

% 	get(3, 47) ->
% 	#attrs{
% 		phy_att = 234,
% 		phy_def = 240,
% 		hp_lim = 2156,
% 		dodge = 291,
% 		hit = 321,
% 		crit = 242,
% 		ten = 80,
% 		spr_att = 446,
% 		spr_def = 300,
% 		mag_att = 0,
% 		mag_def = 123,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 188,
		
% 		resis = 0	};

% 	get(3, 48) ->
% 	#attrs{
% 		phy_att = 242,
% 		phy_def = 247,
% 		hp_lim = 2256,
% 		dodge = 294,
% 		hit = 324,
% 		crit = 244,
% 		ten = 81,
% 		spr_att = 462,
% 		spr_def = 311,
% 		mag_att = 0,
% 		mag_def = 128,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 194,
		
% 		resis = 0	};

% 	get(3, 49) ->
% 	#attrs{
% 		phy_att = 250,
% 		phy_def = 254,
% 		hp_lim = 2356,
% 		dodge = 298,
% 		hit = 328,
% 		crit = 246,
% 		ten = 82,
% 		spr_att = 477,
% 		spr_def = 318,
% 		mag_att = 0,
% 		mag_def = 131,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 200,
		
% 		resis = 0	};

% 	get(3, 50) ->
% 	#attrs{
% 		phy_att = 258,
% 		phy_def = 261,
% 		hp_lim = 2455,
% 		dodge = 302,
% 		hit = 332,
% 		crit = 248,
% 		ten = 83,
% 		spr_att = 492,
% 		spr_def = 326,
% 		mag_att = 0,
% 		mag_def = 134,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 206,
		
% 		resis = 0	};

% 	get(3, 51) ->
% 	#attrs{
% 		phy_att = 271,
% 		phy_def = 269,
% 		hp_lim = 2625,
% 		dodge = 305,
% 		hit = 335,
% 		crit = 250,
% 		ten = 84,
% 		spr_att = 517,
% 		spr_def = 337,
% 		mag_att = 0,
% 		mag_def = 138,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 213,
		
% 		resis = 0	};

% 	get(3, 52) ->
% 	#attrs{
% 		phy_att = 283,
% 		phy_def = 276,
% 		hp_lim = 2794,
% 		dodge = 309,
% 		hit = 339,
% 		crit = 252,
% 		ten = 85,
% 		spr_att = 540,
% 		spr_def = 345,
% 		mag_att = 0,
% 		mag_def = 142,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 220,
		
% 		resis = 0	};

% 	get(3, 53) ->
% 	#attrs{
% 		phy_att = 295,
% 		phy_def = 283,
% 		hp_lim = 2963,
% 		dodge = 313,
% 		hit = 343,
% 		crit = 254,
% 		ten = 86,
% 		spr_att = 563,
% 		spr_def = 353,
% 		mag_att = 0,
% 		mag_def = 145,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 227,
		
% 		resis = 0	};

% 	get(3, 54) ->
% 	#attrs{
% 		phy_att = 307,
% 		phy_def = 291,
% 		hp_lim = 3132,
% 		dodge = 317,
% 		hit = 347,
% 		crit = 256,
% 		ten = 87,
% 		spr_att = 586,
% 		spr_def = 364,
% 		mag_att = 0,
% 		mag_def = 150,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 234,
		
% 		resis = 0	};

% 	get(3, 55) ->
% 	#attrs{
% 		phy_att = 319,
% 		phy_def = 298,
% 		hp_lim = 3300,
% 		dodge = 320,
% 		hit = 350,
% 		crit = 258,
% 		ten = 88,
% 		spr_att = 609,
% 		spr_def = 373,
% 		mag_att = 0,
% 		mag_def = 153,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 241,
		
% 		resis = 0	};

% 	get(3, 56) ->
% 	#attrs{
% 		phy_att = 331,
% 		phy_def = 306,
% 		hp_lim = 3469,
% 		dodge = 324,
% 		hit = 354,
% 		crit = 260,
% 		ten = 89,
% 		spr_att = 631,
% 		spr_def = 384,
% 		mag_att = 0,
% 		mag_def = 158,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 248,
		
% 		resis = 0	};

% 	get(3, 57) ->
% 	#attrs{
% 		phy_att = 344,
% 		phy_def = 313,
% 		hp_lim = 3638,
% 		dodge = 328,
% 		hit = 358,
% 		crit = 262,
% 		ten = 90,
% 		spr_att = 656,
% 		spr_def = 390,
% 		mag_att = 0,
% 		mag_def = 161,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 255,
		
% 		resis = 0	};

% 	get(3, 58) ->
% 	#attrs{
% 		phy_att = 356,
% 		phy_def = 321,
% 		hp_lim = 3807,
% 		dodge = 331,
% 		hit = 361,
% 		crit = 264,
% 		ten = 91,
% 		spr_att = 679,
% 		spr_def = 402,
% 		mag_att = 0,
% 		mag_def = 165,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 262,
		
% 		resis = 0	};

% 	get(3, 59) ->
% 	#attrs{
% 		phy_att = 368,
% 		phy_def = 329,
% 		hp_lim = 3976,
% 		dodge = 335,
% 		hit = 365,
% 		crit = 266,
% 		ten = 92,
% 		spr_att = 702,
% 		spr_def = 411,
% 		mag_att = 0,
% 		mag_def = 169,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 269,
		
% 		resis = 0	};

% 	get(3, 60) ->
% 	#attrs{
% 		phy_att = 379,
% 		phy_def = 337,
% 		hp_lim = 4144,
% 		dodge = 339,
% 		hit = 369,
% 		crit = 268,
% 		ten = 94,
% 		spr_att = 723,
% 		spr_def = 420,
% 		mag_att = 0,
% 		mag_def = 173,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 276,
		
% 		resis = 0	};

% 	get(3, 61) ->
% 	#attrs{
% 		phy_att = 398,
% 		phy_def = 344,
% 		hp_lim = 4430,
% 		dodge = 342,
% 		hit = 372,
% 		crit = 270,
% 		ten = 95,
% 		spr_att = 759,
% 		spr_def = 429,
% 		mag_att = 0,
% 		mag_def = 177,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 284,
		
% 		resis = 0	};

% 	get(3, 62) ->
% 	#attrs{
% 		phy_att = 416,
% 		phy_def = 352,
% 		hp_lim = 4715,
% 		dodge = 346,
% 		hit = 376,
% 		crit = 272,
% 		ten = 96,
% 		spr_att = 793,
% 		spr_def = 438,
% 		mag_att = 0,
% 		mag_def = 180,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 292,
		
% 		resis = 0	};

% 	get(3, 63) ->
% 	#attrs{
% 		phy_att = 434,
% 		phy_def = 360,
% 		hp_lim = 5000,
% 		dodge = 350,
% 		hit = 380,
% 		crit = 274,
% 		ten = 97,
% 		spr_att = 828,
% 		spr_def = 450,
% 		mag_att = 0,
% 		mag_def = 186,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 300,
		
% 		resis = 0	};

% 	get(3, 64) ->
% 	#attrs{
% 		phy_att = 451,
% 		phy_def = 368,
% 		hp_lim = 5286,
% 		dodge = 354,
% 		hit = 384,
% 		crit = 276,
% 		ten = 98,
% 		spr_att = 860,
% 		spr_def = 460,
% 		mag_att = 0,
% 		mag_def = 190,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 308,
		
% 		resis = 0	};

% 	get(3, 65) ->
% 	#attrs{
% 		phy_att = 469,
% 		phy_def = 376,
% 		hp_lim = 5571,
% 		dodge = 357,
% 		hit = 387,
% 		crit = 278,
% 		ten = 99,
% 		spr_att = 894,
% 		spr_def = 469,
% 		mag_att = 0,
% 		mag_def = 194,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 316,
		
% 		resis = 0	};

% 	get(3, 66) ->
% 	#attrs{
% 		phy_att = 487,
% 		phy_def = 384,
% 		hp_lim = 5856,
% 		dodge = 361,
% 		hit = 391,
% 		crit = 280,
% 		ten = 100,
% 		spr_att = 929,
% 		spr_def = 479,
% 		mag_att = 0,
% 		mag_def = 198,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 324,
		
% 		resis = 0	};

% 	get(3, 67) ->
% 	#attrs{
% 		phy_att = 505,
% 		phy_def = 393,
% 		hp_lim = 6141,
% 		dodge = 365,
% 		hit = 395,
% 		crit = 282,
% 		ten = 101,
% 		spr_att = 963,
% 		spr_def = 489,
% 		mag_att = 0,
% 		mag_def = 202,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 332,
		
% 		resis = 0	};

% 	get(3, 68) ->
% 	#attrs{
% 		phy_att = 523,
% 		phy_def = 401,
% 		hp_lim = 6426,
% 		dodge = 368,
% 		hit = 398,
% 		crit = 284,
% 		ten = 102,
% 		spr_att = 997,
% 		spr_def = 498,
% 		mag_att = 0,
% 		mag_def = 206,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 340,
		
% 		resis = 0	};

% 	get(3, 69) ->
% 	#attrs{
% 		phy_att = 541,
% 		phy_def = 409,
% 		hp_lim = 6711,
% 		dodge = 372,
% 		hit = 402,
% 		crit = 286,
% 		ten = 103,
% 		spr_att = 1032,
% 		spr_def = 508,
% 		mag_att = 0,
% 		mag_def = 210,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 348,
		
% 		resis = 0	};

% 	get(3, 70) ->
% 	#attrs{
% 		phy_att = 558,
% 		phy_def = 417,
% 		hp_lim = 6996,
% 		dodge = 376,
% 		hit = 406,
% 		crit = 288,
% 		ten = 104,
% 		spr_att = 1064,
% 		spr_def = 518,
% 		mag_att = 0,
% 		mag_def = 214,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 356,
		
% 		resis = 0	};

% 	get(3, 71) ->
% 	#attrs{
% 		phy_att = 585,
% 		phy_def = 425,
% 		hp_lim = 7478,
% 		dodge = 379,
% 		hit = 409,
% 		crit = 290,
% 		ten = 105,
% 		spr_att = 1115,
% 		spr_def = 528,
% 		mag_att = 0,
% 		mag_def = 218,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 365,
		
% 		resis = 0	};

% 	get(3, 72) ->
% 	#attrs{
% 		phy_att = 611,
% 		phy_def = 434,
% 		hp_lim = 7959,
% 		dodge = 383,
% 		hit = 413,
% 		crit = 292,
% 		ten = 106,
% 		spr_att = 1165,
% 		spr_def = 539,
% 		mag_att = 0,
% 		mag_def = 222,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 374,
		
% 		resis = 0	};

% 	get(3, 73) ->
% 	#attrs{
% 		phy_att = 637,
% 		phy_def = 442,
% 		hp_lim = 8441,
% 		dodge = 387,
% 		hit = 417,
% 		crit = 294,
% 		ten = 107,
% 		spr_att = 1215,
% 		spr_def = 549,
% 		mag_att = 0,
% 		mag_def = 227,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 383,
		
% 		resis = 0	};

% 	get(3, 74) ->
% 	#attrs{
% 		phy_att = 663,
% 		phy_def = 450,
% 		hp_lim = 8922,
% 		dodge = 391,
% 		hit = 421,
% 		crit = 296,
% 		ten = 108,
% 		spr_att = 1264,
% 		spr_def = 559,
% 		mag_att = 0,
% 		mag_def = 231,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 392,
		
% 		resis = 0	};

% 	get(3, 75) ->
% 	#attrs{
% 		phy_att = 690,
% 		phy_def = 459,
% 		hp_lim = 9403,
% 		dodge = 394,
% 		hit = 424,
% 		crit = 298,
% 		ten = 109,
% 		spr_att = 1316,
% 		spr_def = 570,
% 		mag_att = 0,
% 		mag_def = 235,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 401,
		
% 		resis = 0	};

% 	get(3, 76) ->
% 	#attrs{
% 		phy_att = 716,
% 		phy_def = 467,
% 		hp_lim = 9885,
% 		dodge = 398,
% 		hit = 428,
% 		crit = 300,
% 		ten = 110,
% 		spr_att = 1365,
% 		spr_def = 580,
% 		mag_att = 0,
% 		mag_def = 240,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 410,
		
% 		resis = 0	};

% 	get(3, 77) ->
% 	#attrs{
% 		phy_att = 742,
% 		phy_def = 476,
% 		hp_lim = 10366,
% 		dodge = 402,
% 		hit = 432,
% 		crit = 302,
% 		ten = 111,
% 		spr_att = 1415,
% 		spr_def = 591,
% 		mag_att = 0,
% 		mag_def = 244,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 419,
		
% 		resis = 0	};

% 	get(3, 78) ->
% 	#attrs{
% 		phy_att = 768,
% 		phy_def = 484,
% 		hp_lim = 10847,
% 		dodge = 405,
% 		hit = 435,
% 		crit = 304,
% 		ten = 112,
% 		spr_att = 1464,
% 		spr_def = 602,
% 		mag_att = 0,
% 		mag_def = 249,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 428,
		
% 		resis = 0	};

% 	get(3, 79) ->
% 	#attrs{
% 		phy_att = 795,
% 		phy_def = 493,
% 		hp_lim = 11329,
% 		dodge = 409,
% 		hit = 439,
% 		crit = 306,
% 		ten = 113,
% 		spr_att = 1516,
% 		spr_def = 613,
% 		mag_att = 0,
% 		mag_def = 253,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 437,
		
% 		resis = 0	};

% 	get(3, 80) ->
% 	#attrs{
% 		phy_att = 820,
% 		phy_def = 501,
% 		hp_lim = 11809,
% 		dodge = 413,
% 		hit = 443,
% 		crit = 308,
% 		ten = 115,
% 		spr_att = 1563,
% 		spr_def = 624,
% 		mag_att = 0,
% 		mag_def = 258,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 446,
		
% 		resis = 0	};

% 	get(3, 81) ->
% 	#attrs{
% 		phy_att = 860,
% 		phy_def = 510,
% 		hp_lim = 12623,
% 		dodge = 416,
% 		hit = 446,
% 		crit = 310,
% 		ten = 116,
% 		spr_att = 1640,
% 		spr_def = 635,
% 		mag_att = 0,
% 		mag_def = 263,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 456,
		
% 		resis = 0	};

% 	get(3, 82) ->
% 	#attrs{
% 		phy_att = 898,
% 		phy_def = 518,
% 		hp_lim = 13435,
% 		dodge = 420,
% 		hit = 450,
% 		crit = 312,
% 		ten = 117,
% 		spr_att = 1712,
% 		spr_def = 642,
% 		mag_att = 0,
% 		mag_def = 265,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 466,
		
% 		resis = 0	};

% 	get(3, 83) ->
% 	#attrs{
% 		phy_att = 937,
% 		phy_def = 527,
% 		hp_lim = 14248,
% 		dodge = 424,
% 		hit = 454,
% 		crit = 314,
% 		ten = 118,
% 		spr_att = 1786,
% 		spr_def = 653,
% 		mag_att = 0,
% 		mag_def = 270,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 476,
		
% 		resis = 0	};

% 	get(3, 84) ->
% 	#attrs{
% 		phy_att = 976,
% 		phy_def = 535,
% 		hp_lim = 15060,
% 		dodge = 428,
% 		hit = 458,
% 		crit = 316,
% 		ten = 119,
% 		spr_att = 1861,
% 		spr_def = 664,
% 		mag_att = 0,
% 		mag_def = 275,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 486,
		
% 		resis = 0	};

% 	get(3, 85) ->
% 	#attrs{
% 		phy_att = 1014,
% 		phy_def = 544,
% 		hp_lim = 15873,
% 		dodge = 431,
% 		hit = 461,
% 		crit = 318,
% 		ten = 120,
% 		spr_att = 1933,
% 		spr_def = 676,
% 		mag_att = 0,
% 		mag_def = 280,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 496,
		
% 		resis = 0	};

% 	get(3, 86) ->
% 	#attrs{
% 		phy_att = 1053,
% 		phy_def = 553,
% 		hp_lim = 16685,
% 		dodge = 435,
% 		hit = 465,
% 		crit = 320,
% 		ten = 121,
% 		spr_att = 2007,
% 		spr_def = 687,
% 		mag_att = 0,
% 		mag_def = 285,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 506,
		
% 		resis = 0	};

% 	get(3, 87) ->
% 	#attrs{
% 		phy_att = 1092,
% 		phy_def = 561,
% 		hp_lim = 17498,
% 		dodge = 439,
% 		hit = 469,
% 		crit = 322,
% 		ten = 122,
% 		spr_att = 2082,
% 		spr_def = 694,
% 		mag_att = 0,
% 		mag_def = 287,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 516,
		
% 		resis = 0	};

% 	get(3, 88) ->
% 	#attrs{
% 		phy_att = 1131,
% 		phy_def = 570,
% 		hp_lim = 18310,
% 		dodge = 442,
% 		hit = 472,
% 		crit = 324,
% 		ten = 123,
% 		spr_att = 2156,
% 		spr_def = 706,
% 		mag_att = 0,
% 		mag_def = 292,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 526,
		
% 		resis = 0	};

% 	get(3, 89) ->
% 	#attrs{
% 		phy_att = 1169,
% 		phy_def = 578,
% 		hp_lim = 19123,
% 		dodge = 446,
% 		hit = 476,
% 		crit = 326,
% 		ten = 124,
% 		spr_att = 2229,
% 		spr_def = 718,
% 		mag_att = 0,
% 		mag_def = 297,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 536,
		
% 		resis = 0	};

% 	get(3, 90) ->
% 	#attrs{
% 		phy_att = 1207,
% 		phy_def = 587,
% 		hp_lim = 19935,
% 		dodge = 450,
% 		hit = 480,
% 		crit = 328,
% 		ten = 125,
% 		spr_att = 2301,
% 		spr_def = 730,
% 		mag_att = 0,
% 		mag_def = 302,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 546,
		
% 		resis = 0	};

% 	get(3, 91) ->
% 	#attrs{
% 		phy_att = 1259,
% 		phy_def = 596,
% 		hp_lim = 21079,
% 		dodge = 453,
% 		hit = 483,
% 		crit = 330,
% 		ten = 126,
% 		spr_att = 2400,
% 		spr_def = 737,
% 		mag_att = 0,
% 		mag_def = 305,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 557,
		
% 		resis = 0	};

% 	get(3, 92) ->
% 	#attrs{
% 		phy_att = 1310,
% 		phy_def = 604,
% 		hp_lim = 22223,
% 		dodge = 457,
% 		hit = 487,
% 		crit = 332,
% 		ten = 127,
% 		spr_att = 2497,
% 		spr_def = 749,
% 		mag_att = 0,
% 		mag_def = 310,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 568,
		
% 		resis = 0	};

% 	get(3, 93) ->
% 	#attrs{
% 		phy_att = 1361,
% 		phy_def = 613,
% 		hp_lim = 23367,
% 		dodge = 461,
% 		hit = 491,
% 		crit = 334,
% 		ten = 128,
% 		spr_att = 2595,
% 		spr_def = 761,
% 		mag_att = 0,
% 		mag_def = 315,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 579,
		
% 		resis = 0	};

% 	get(3, 94) ->
% 	#attrs{
% 		phy_att = 1413,
% 		phy_def = 621,
% 		hp_lim = 24510,
% 		dodge = 465,
% 		hit = 495,
% 		crit = 336,
% 		ten = 129,
% 		spr_att = 2694,
% 		spr_def = 769,
% 		mag_att = 0,
% 		mag_def = 319,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 590,
		
% 		resis = 0	};

% 	get(3, 95) ->
% 	#attrs{
% 		phy_att = 1464,
% 		phy_def = 630,
% 		hp_lim = 25654,
% 		dodge = 468,
% 		hit = 498,
% 		crit = 338,
% 		ten = 130,
% 		spr_att = 2791,
% 		spr_def = 781,
% 		mag_att = 0,
% 		mag_def = 324,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 601,
		
% 		resis = 0	};

% 	get(3, 96) ->
% 	#attrs{
% 		phy_att = 1515,
% 		phy_def = 639,
% 		hp_lim = 26798,
% 		dodge = 472,
% 		hit = 502,
% 		crit = 340,
% 		ten = 131,
% 		spr_att = 2888,
% 		spr_def = 794,
% 		mag_att = 0,
% 		mag_def = 329,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 612,
		
% 		resis = 0	};

% 	get(3, 97) ->
% 	#attrs{
% 		phy_att = 1566,
% 		phy_def = 647,
% 		hp_lim = 27941,
% 		dodge = 476,
% 		hit = 506,
% 		crit = 342,
% 		ten = 132,
% 		spr_att = 2985,
% 		spr_def = 801,
% 		mag_att = 0,
% 		mag_def = 332,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 623,
		
% 		resis = 0	};

% 	get(3, 98) ->
% 	#attrs{
% 		phy_att = 1617,
% 		phy_def = 656,
% 		hp_lim = 29085,
% 		dodge = 479,
% 		hit = 509,
% 		crit = 344,
% 		ten = 133,
% 		spr_att = 3082,
% 		spr_def = 814,
% 		mag_att = 0,
% 		mag_def = 337,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 634,
		
% 		resis = 0	};

% 	get(3, 99) ->
% 	#attrs{
% 		phy_att = 1668,
% 		phy_def = 664,
% 		hp_lim = 30229,
% 		dodge = 483,
% 		hit = 513,
% 		crit = 346,
% 		ten = 134,
% 		spr_att = 3180,
% 		spr_def = 821,
% 		mag_att = 0,
% 		mag_def = 340,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 645,
		
% 		resis = 0	};

% 	get(3, 100) ->
% 	#attrs{
% 		phy_att = 1719,
% 		phy_def = 673,
% 		hp_lim = 31372,
% 		dodge = 487,
% 		hit = 517,
% 		crit = 348,
% 		ten = 136,
% 		spr_att = 3277,
% 		spr_def = 834,
% 		mag_att = 0,
% 		mag_def = 346,
% 		pro_sword = 0,
% 		pro_bow = 100,
% 		pro_spear = 0,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 656,
		
% 		resis = 0	};

% 	get(2, 1) ->
% 	#attrs{
% 		phy_att = 28,
% 		phy_def = 34,
% 		hp_lim = 246,
% 		dodge = 80,
% 		hit = 100,
% 		crit = 21,
% 		ten = 220,
% 		spr_att = 71,
% 		spr_def = 48,
% 		mag_att = 0,
% 		mag_def = 18,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 5,
		
% 		resis = 0	};

% 	get(2, 2) ->
% 	#attrs{
% 		phy_att = 30,
% 		phy_def = 37,
% 		hp_lim = 260,
% 		dodge = 84,
% 		hit = 104,
% 		crit = 23,
% 		ten = 222,
% 		spr_att = 76,
% 		spr_def = 52,
% 		mag_att = 0,
% 		mag_def = 20,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 6,
		
% 		resis = 0	};

% 	get(2, 3) ->
% 	#attrs{
% 		phy_att = 31,
% 		phy_def = 40,
% 		hp_lim = 283,
% 		dodge = 87,
% 		hit = 107,
% 		crit = 25,
% 		ten = 224,
% 		spr_att = 78,
% 		spr_def = 56,
% 		mag_att = 0,
% 		mag_def = 21,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 7,
		
% 		resis = 0	};

% 	get(2, 4) ->
% 	#attrs{
% 		phy_att = 33,
% 		phy_def = 43,
% 		hp_lim = 297,
% 		dodge = 91,
% 		hit = 111,
% 		crit = 27,
% 		ten = 226,
% 		spr_att = 83,
% 		spr_def = 59,
% 		mag_att = 0,
% 		mag_def = 23,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 8,
		
% 		resis = 0	};

% 	get(2, 5) ->
% 	#attrs{
% 		phy_att = 34,
% 		phy_def = 46,
% 		hp_lim = 320,
% 		dodge = 94,
% 		hit = 114,
% 		crit = 29,
% 		ten = 228,
% 		spr_att = 85,
% 		spr_def = 63,
% 		mag_att = 0,
% 		mag_def = 24,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 9,
		
% 		resis = 0	};

% 	get(2, 6) ->
% 	#attrs{
% 		phy_att = 35,
% 		phy_def = 49,
% 		hp_lim = 343,
% 		dodge = 97,
% 		hit = 117,
% 		crit = 30,
% 		ten = 230,
% 		spr_att = 87,
% 		spr_def = 66,
% 		mag_att = 0,
% 		mag_def = 26,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 10,
		
% 		resis = 0	};

% 	get(2, 7) ->
% 	#attrs{
% 		phy_att = 37,
% 		phy_def = 52,
% 		hp_lim = 356,
% 		dodge = 101,
% 		hit = 121,
% 		crit = 32,
% 		ten = 232,
% 		spr_att = 93,
% 		spr_def = 70,
% 		mag_att = 0,
% 		mag_def = 27,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 11,
		
% 		resis = 0	};

% 	get(2, 8) ->
% 	#attrs{
% 		phy_att = 38,
% 		phy_def = 55,
% 		hp_lim = 380,
% 		dodge = 104,
% 		hit = 124,
% 		crit = 34,
% 		ten = 234,
% 		spr_att = 95,
% 		spr_def = 74,
% 		mag_att = 0,
% 		mag_def = 29,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 12,
		
% 		resis = 0	};

% 	get(2, 9) ->
% 	#attrs{
% 		phy_att = 40,
% 		phy_def = 58,
% 		hp_lim = 394,
% 		dodge = 108,
% 		hit = 128,
% 		crit = 36,
% 		ten = 236,
% 		spr_att = 100,
% 		spr_def = 77,
% 		mag_att = 0,
% 		mag_def = 30,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 13,
		
% 		resis = 0	};

% 	get(2, 10) ->
% 	#attrs{
% 		phy_att = 40,
% 		phy_def = 62,
% 		hp_lim = 419,
% 		dodge = 111,
% 		hit = 131,
% 		crit = 38,
% 		ten = 238,
% 		spr_att = 100,
% 		spr_def = 82,
% 		mag_att = 0,
% 		mag_def = 33,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 14,
		
% 		resis = 0	};

% 	get(2, 11) ->
% 	#attrs{
% 		phy_att = 42,
% 		phy_def = 65,
% 		hp_lim = 450,
% 		dodge = 114,
% 		hit = 134,
% 		crit = 39,
% 		ten = 240,
% 		spr_att = 104,
% 		spr_def = 86,
% 		mag_att = 0,
% 		mag_def = 34,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 16,
		
% 		resis = 0	};

% 	get(2, 12) ->
% 	#attrs{
% 		phy_att = 45,
% 		phy_def = 69,
% 		hp_lim = 469,
% 		dodge = 118,
% 		hit = 138,
% 		crit = 41,
% 		ten = 242,
% 		spr_att = 112,
% 		spr_def = 91,
% 		mag_att = 0,
% 		mag_def = 36,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 18,
		
% 		resis = 0	};

% 	get(2, 13) ->
% 	#attrs{
% 		phy_att = 46,
% 		phy_def = 73,
% 		hp_lim = 500,
% 		dodge = 121,
% 		hit = 141,
% 		crit = 43,
% 		ten = 244,
% 		spr_att = 117,
% 		spr_def = 96,
% 		mag_att = 0,
% 		mag_def = 38,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 20,
		
% 		resis = 0	};

% 	get(2, 14) ->
% 	#attrs{
% 		phy_att = 48,
% 		phy_def = 77,
% 		hp_lim = 533,
% 		dodge = 125,
% 		hit = 145,
% 		crit = 45,
% 		ten = 246,
% 		spr_att = 119,
% 		spr_def = 101,
% 		mag_att = 0,
% 		mag_def = 40,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 22,
		
% 		resis = 0	};

% 	get(2, 15) ->
% 	#attrs{
% 		phy_att = 49,
% 		phy_def = 81,
% 		hp_lim = 564,
% 		dodge = 128,
% 		hit = 148,
% 		crit = 47,
% 		ten = 248,
% 		spr_att = 125,
% 		spr_def = 106,
% 		mag_att = 0,
% 		mag_def = 42,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 24,
		
% 		resis = 0	};

% 	get(2, 16) ->
% 	#attrs{
% 		phy_att = 52,
% 		phy_def = 86,
% 		hp_lim = 594,
% 		dodge = 131,
% 		hit = 151,
% 		crit = 48,
% 		ten = 250,
% 		spr_att = 129,
% 		spr_def = 112,
% 		mag_att = 0,
% 		mag_def = 45,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 26,
		
% 		resis = 0	};

% 	get(2, 17) ->
% 	#attrs{
% 		phy_att = 53,
% 		phy_def = 90,
% 		hp_lim = 616,
% 		dodge = 135,
% 		hit = 155,
% 		crit = 50,
% 		ten = 252,
% 		spr_att = 134,
% 		spr_def = 116,
% 		mag_att = 0,
% 		mag_def = 47,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 28,
		
% 		resis = 0	};

% 	get(2, 18) ->
% 	#attrs{
% 		phy_att = 55,
% 		phy_def = 95,
% 		hp_lim = 646,
% 		dodge = 138,
% 		hit = 158,
% 		crit = 52,
% 		ten = 254,
% 		spr_att = 140,
% 		spr_def = 123,
% 		mag_att = 0,
% 		mag_def = 49,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 30,
		
% 		resis = 0	};

% 	get(2, 19) ->
% 	#attrs{
% 		phy_att = 56,
% 		phy_def = 100,
% 		hp_lim = 676,
% 		dodge = 142,
% 		hit = 162,
% 		crit = 54,
% 		ten = 256,
% 		spr_att = 144,
% 		spr_def = 130,
% 		mag_att = 0,
% 		mag_def = 52,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 32,
		
% 		resis = 0	};

% 	get(2, 20) ->
% 	#attrs{
% 		phy_att = 58,
% 		phy_def = 105,
% 		hp_lim = 709,
% 		dodge = 145,
% 		hit = 165,
% 		crit = 56,
% 		ten = 258,
% 		spr_att = 147,
% 		spr_def = 135,
% 		mag_att = 0,
% 		mag_def = 54,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 34,
		
% 		resis = 0	};

% 	get(2, 21) ->
% 	#attrs{
% 		phy_att = 61,
% 		phy_def = 110,
% 		hp_lim = 756,
% 		dodge = 148,
% 		hit = 168,
% 		crit = 57,
% 		ten = 260,
% 		spr_att = 155,
% 		spr_def = 142,
% 		mag_att = 0,
% 		mag_def = 57,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 37,
		
% 		resis = 0	};

% 	get(2, 22) ->
% 	#attrs{
% 		phy_att = 63,
% 		phy_def = 115,
% 		hp_lim = 803,
% 		dodge = 152,
% 		hit = 172,
% 		crit = 59,
% 		ten = 262,
% 		spr_att = 161,
% 		spr_def = 148,
% 		mag_att = 0,
% 		mag_def = 60,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 40,
		
% 		resis = 0	};

% 	get(2, 23) ->
% 	#attrs{
% 		phy_att = 66,
% 		phy_def = 121,
% 		hp_lim = 849,
% 		dodge = 155,
% 		hit = 175,
% 		crit = 61,
% 		ten = 264,
% 		spr_att = 169,
% 		spr_def = 155,
% 		mag_att = 0,
% 		mag_def = 63,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 43,
		
% 		resis = 0	};

% 	get(2, 24) ->
% 	#attrs{
% 		phy_att = 69,
% 		phy_def = 126,
% 		hp_lim = 908,
% 		dodge = 159,
% 		hit = 179,
% 		crit = 63,
% 		ten = 266,
% 		spr_att = 174,
% 		spr_def = 161,
% 		mag_att = 0,
% 		mag_def = 65,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 46,
		
% 		resis = 0	};

% 	get(2, 25) ->
% 	#attrs{
% 		phy_att = 72,
% 		phy_def = 132,
% 		hp_lim = 954,
% 		dodge = 162,
% 		hit = 182,
% 		crit = 65,
% 		ten = 268,
% 		spr_att = 182,
% 		spr_def = 169,
% 		mag_att = 0,
% 		mag_def = 68,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 49,
		
% 		resis = 0	};

% 	get(2, 26) ->
% 	#attrs{
% 		phy_att = 74,
% 		phy_def = 138,
% 		hp_lim = 1001,
% 		dodge = 165,
% 		hit = 185,
% 		crit = 66,
% 		ten = 270,
% 		spr_att = 189,
% 		spr_def = 176,
% 		mag_att = 0,
% 		mag_def = 72,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 52,
		
% 		resis = 0	};

% 	get(2, 27) ->
% 	#attrs{
% 		phy_att = 77,
% 		phy_def = 144,
% 		hp_lim = 1046,
% 		dodge = 169,
% 		hit = 189,
% 		crit = 68,
% 		ten = 272,
% 		spr_att = 197,
% 		spr_def = 184,
% 		mag_att = 0,
% 		mag_def = 75,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 55,
		
% 		resis = 0	};

% 	get(2, 28) ->
% 	#attrs{
% 		phy_att = 80,
% 		phy_def = 150,
% 		hp_lim = 1093,
% 		dodge = 172,
% 		hit = 192,
% 		crit = 70,
% 		ten = 274,
% 		spr_att = 204,
% 		spr_def = 191,
% 		mag_att = 0,
% 		mag_def = 77,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 58,
		
% 		resis = 0	};

% 	get(2, 29) ->
% 	#attrs{
% 		phy_att = 82,
% 		phy_def = 156,
% 		hp_lim = 1153,
% 		dodge = 176,
% 		hit = 196,
% 		crit = 72,
% 		ten = 276,
% 		spr_att = 209,
% 		spr_def = 199,
% 		mag_att = 0,
% 		mag_def = 81,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 61,
		
% 		resis = 0	};

% 	get(2, 30) ->
% 	#attrs{
% 		phy_att = 84,
% 		phy_def = 163,
% 		hp_lim = 1187,
% 		dodge = 179,
% 		hit = 199,
% 		crit = 74,
% 		ten = 278,
% 		spr_att = 216,
% 		spr_def = 207,
% 		mag_att = 0,
% 		mag_def = 84,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 64,
		
% 		resis = 0	};

% 	get(2, 31) ->
% 	#attrs{
% 		phy_att = 89,
% 		phy_def = 169,
% 		hp_lim = 1274,
% 		dodge = 182,
% 		hit = 202,
% 		crit = 75,
% 		ten = 280,
% 		spr_att = 226,
% 		spr_def = 214,
% 		mag_att = 0,
% 		mag_def = 87,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 68,
		
% 		resis = 0	};

% 	get(2, 32) ->
% 	#attrs{
% 		phy_att = 93,
% 		phy_def = 176,
% 		hp_lim = 1357,
% 		dodge = 186,
% 		hit = 206,
% 		crit = 77,
% 		ten = 282,
% 		spr_att = 237,
% 		spr_def = 223,
% 		mag_att = 0,
% 		mag_def = 91,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 72,
		
% 		resis = 0	};

% 	get(2, 33) ->
% 	#attrs{
% 		phy_att = 96,
% 		phy_def = 182,
% 		hp_lim = 1443,
% 		dodge = 189,
% 		hit = 209,
% 		crit = 79,
% 		ten = 284,
% 		spr_att = 247,
% 		spr_def = 232,
% 		mag_att = 0,
% 		mag_def = 94,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 76,
		
% 		resis = 0	};

% 	get(2, 34) ->
% 	#attrs{
% 		phy_att = 101,
% 		phy_def = 189,
% 		hp_lim = 1530,
% 		dodge = 193,
% 		hit = 213,
% 		crit = 81,
% 		ten = 286,
% 		spr_att = 256,
% 		spr_def = 239,
% 		mag_att = 0,
% 		mag_def = 97,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 80,
		
% 		resis = 0	};

% 	get(2, 35) ->
% 	#attrs{
% 		phy_att = 104,
% 		phy_def = 196,
% 		hp_lim = 1600,
% 		dodge = 196,
% 		hit = 216,
% 		crit = 83,
% 		ten = 288,
% 		spr_att = 269,
% 		spr_def = 248,
% 		mag_att = 0,
% 		mag_def = 101,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 84,
		
% 		resis = 0	};

% 	get(2, 36) ->
% 	#attrs{
% 		phy_att = 108,
% 		phy_def = 203,
% 		hp_lim = 1683,
% 		dodge = 199,
% 		hit = 219,
% 		crit = 84,
% 		ten = 290,
% 		spr_att = 279,
% 		spr_def = 257,
% 		mag_att = 0,
% 		mag_def = 105,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 88,
		
% 		resis = 0	};

% 	get(2, 37) ->
% 	#attrs{
% 		phy_att = 112,
% 		phy_def = 211,
% 		hp_lim = 1774,
% 		dodge = 203,
% 		hit = 223,
% 		crit = 86,
% 		ten = 292,
% 		spr_att = 287,
% 		spr_def = 267,
% 		mag_att = 0,
% 		mag_def = 109,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 92,
		
% 		resis = 0	};

% 	get(2, 38) ->
% 	#attrs{
% 		phy_att = 116,
% 		phy_def = 218,
% 		hp_lim = 1859,
% 		dodge = 206,
% 		hit = 226,
% 		crit = 88,
% 		ten = 294,
% 		spr_att = 296,
% 		spr_def = 275,
% 		mag_att = 0,
% 		mag_def = 112,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 96,
		
% 		resis = 0	};

% 	get(2, 39) ->
% 	#attrs{
% 		phy_att = 119,
% 		phy_def = 226,
% 		hp_lim = 1926,
% 		dodge = 210,
% 		hit = 230,
% 		crit = 90,
% 		ten = 296,
% 		spr_att = 310,
% 		spr_def = 285,
% 		mag_att = 0,
% 		mag_def = 116,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 100,
		
% 		resis = 0	};

% 	get(2, 40) ->
% 	#attrs{
% 		phy_att = 123,
% 		phy_def = 233,
% 		hp_lim = 2006,
% 		dodge = 213,
% 		hit = 233,
% 		crit = 92,
% 		ten = 298,
% 		spr_att = 319,
% 		spr_def = 295,
% 		mag_att = 0,
% 		mag_def = 121,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 104,
		
% 		resis = 0	};

% 	get(2, 41) ->
% 	#attrs{
% 		phy_att = 129,
% 		phy_def = 241,
% 		hp_lim = 2158,
% 		dodge = 216,
% 		hit = 236,
% 		crit = 93,
% 		ten = 300,
% 		spr_att = 334,
% 		spr_def = 303,
% 		mag_att = 0,
% 		mag_def = 124,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 109,
		
% 		resis = 0	};

% 	get(2, 42) ->
% 	#attrs{
% 		phy_att = 135,
% 		phy_def = 249,
% 		hp_lim = 2288,
% 		dodge = 220,
% 		hit = 240,
% 		crit = 95,
% 		ten = 302,
% 		spr_att = 349,
% 		spr_def = 313,
% 		mag_att = 0,
% 		mag_def = 128,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 114,
		
% 		resis = 0	};

% 	get(2, 43) ->
% 	#attrs{
% 		phy_att = 141,
% 		phy_def = 257,
% 		hp_lim = 2432,
% 		dodge = 223,
% 		hit = 243,
% 		crit = 97,
% 		ten = 304,
% 		spr_att = 364,
% 		spr_def = 324,
% 		mag_att = 0,
% 		mag_def = 133,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 119,
		
% 		resis = 0	};

% 	get(2, 44) ->
% 	#attrs{
% 		phy_att = 147,
% 		phy_def = 265,
% 		hp_lim = 2575,
% 		dodge = 227,
% 		hit = 247,
% 		crit = 99,
% 		ten = 306,
% 		spr_att = 379,
% 		spr_def = 332,
% 		mag_att = 0,
% 		mag_def = 136,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 124,
		
% 		resis = 0	};

% 	get(2, 45) ->
% 	#attrs{
% 		phy_att = 152,
% 		phy_def = 273,
% 		hp_lim = 2707,
% 		dodge = 230,
% 		hit = 250,
% 		crit = 101,
% 		ten = 308,
% 		spr_att = 394,
% 		spr_def = 343,
% 		mag_att = 0,
% 		mag_def = 141,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 129,
		
% 		resis = 0	};

% 	get(2, 46) ->
% 	#attrs{
% 		phy_att = 158,
% 		phy_def = 281,
% 		hp_lim = 2851,
% 		dodge = 233,
% 		hit = 253,
% 		crit = 102,
% 		ten = 310,
% 		spr_att = 409,
% 		spr_def = 352,
% 		mag_att = 0,
% 		mag_def = 144,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 134,
		
% 		resis = 0	};

% 	get(2, 47) ->
% 	#attrs{
% 		phy_att = 164,
% 		phy_def = 289,
% 		hp_lim = 2974,
% 		dodge = 237,
% 		hit = 257,
% 		crit = 104,
% 		ten = 312,
% 		spr_att = 427,
% 		spr_def = 363,
% 		mag_att = 0,
% 		mag_def = 149,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 139,
		
% 		resis = 0	};

% 	get(2, 48) ->
% 	#attrs{
% 		phy_att = 170,
% 		phy_def = 298,
% 		hp_lim = 3118,
% 		dodge = 240,
% 		hit = 260,
% 		crit = 106,
% 		ten = 314,
% 		spr_att = 442,
% 		spr_def = 375,
% 		mag_att = 0,
% 		mag_def = 154,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 144,
		
% 		resis = 0	};

% 	get(2, 49) ->
% 	#attrs{
% 		phy_att = 175,
% 		phy_def = 306,
% 		hp_lim = 3267,
% 		dodge = 244,
% 		hit = 264,
% 		crit = 108,
% 		ten = 316,
% 		spr_att = 454,
% 		spr_def = 384,
% 		mag_att = 0,
% 		mag_def = 158,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 149,
		
% 		resis = 0	};

% 	get(2, 50) ->
% 	#attrs{
% 		phy_att = 181,
% 		phy_def = 315,
% 		hp_lim = 3400,
% 		dodge = 247,
% 		hit = 267,
% 		crit = 110,
% 		ten = 318,
% 		spr_att = 470,
% 		spr_def = 396,
% 		mag_att = 0,
% 		mag_def = 163,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 154,
		
% 		resis = 0	};

% 	get(2, 51) ->
% 	#attrs{
% 		phy_att = 190,
% 		phy_def = 323,
% 		hp_lim = 3628,
% 		dodge = 250,
% 		hit = 270,
% 		crit = 111,
% 		ten = 320,
% 		spr_att = 494,
% 		spr_def = 405,
% 		mag_att = 0,
% 		mag_def = 166,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 160,
		
% 		resis = 0	};

% 	get(2, 52) ->
% 	#attrs{
% 		phy_att = 199,
% 		phy_def = 332,
% 		hp_lim = 3870,
% 		dodge = 254,
% 		hit = 274,
% 		crit = 113,
% 		ten = 322,
% 		spr_att = 515,
% 		spr_def = 415,
% 		mag_att = 0,
% 		mag_def = 170,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 166,
		
% 		resis = 0	};

% 	get(2, 53) ->
% 	#attrs{
% 		phy_att = 207,
% 		phy_def = 341,
% 		hp_lim = 4101,
% 		dodge = 257,
% 		hit = 277,
% 		crit = 115,
% 		ten = 324,
% 		spr_att = 538,
% 		spr_def = 427,
% 		mag_att = 0,
% 		mag_def = 176,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 172,
		
% 		resis = 0	};

% 	get(2, 54) ->
% 	#attrs{
% 		phy_att = 215,
% 		phy_def = 350,
% 		hp_lim = 4342,
% 		dodge = 261,
% 		hit = 281,
% 		crit = 117,
% 		ten = 326,
% 		spr_att = 559,
% 		spr_def = 437,
% 		mag_att = 0,
% 		mag_def = 180,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 178,
		
% 		resis = 0	};

% 	get(2, 55) ->
% 	#attrs{
% 		phy_att = 224,
% 		phy_def = 359,
% 		hp_lim = 4551,
% 		dodge = 264,
% 		hit = 284,
% 		crit = 119,
% 		ten = 328,
% 		spr_att = 585,
% 		spr_def = 449,
% 		mag_att = 0,
% 		mag_def = 185,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 184,
		
% 		resis = 0	};

% 	get(2, 56) ->
% 	#attrs{
% 		phy_att = 232,
% 		phy_def = 368,
% 		hp_lim = 4798,
% 		dodge = 267,
% 		hit = 287,
% 		crit = 120,
% 		ten = 330,
% 		spr_att = 604,
% 		spr_def = 459,
% 		mag_att = 0,
% 		mag_def = 189,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 190,
		
% 		resis = 0	};

% 	get(2, 57) ->
% 	#attrs{
% 		phy_att = 241,
% 		phy_def = 377,
% 		hp_lim = 5022,
% 		dodge = 271,
% 		hit = 291,
% 		crit = 122,
% 		ten = 332,
% 		spr_att = 629,
% 		spr_def = 472,
% 		mag_att = 0,
% 		mag_def = 194,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 196,
		
% 		resis = 0	};

% 	get(2, 58) ->
% 	#attrs{
% 		phy_att = 250,
% 		phy_def = 386,
% 		hp_lim = 5264,
% 		dodge = 274,
% 		hit = 294,
% 		crit = 124,
% 		ten = 334,
% 		spr_att = 650,
% 		spr_def = 483,
% 		mag_att = 0,
% 		mag_def = 199,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 202,
		
% 		resis = 0	};

% 	get(2, 59) ->
% 	#attrs{
% 		phy_att = 258,
% 		phy_def = 396,
% 		hp_lim = 5493,
% 		dodge = 278,
% 		hit = 298,
% 		crit = 126,
% 		ten = 336,
% 		spr_att = 673,
% 		spr_def = 496,
% 		mag_att = 0,
% 		mag_def = 204,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 208,
		
% 		resis = 0	};

% 	get(2, 60) ->
% 	#attrs{
% 		phy_att = 266,
% 		phy_def = 405,
% 		hp_lim = 5713,
% 		dodge = 281,
% 		hit = 301,
% 		crit = 128,
% 		ten = 338,
% 		spr_att = 696,
% 		spr_def = 507,
% 		mag_att = 0,
% 		mag_def = 209,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 214,
		
% 		resis = 0	};

% 	get(2, 61) ->
% 	#attrs{
% 		phy_att = 279,
% 		phy_def = 415,
% 		hp_lim = 6114,
% 		dodge = 284,
% 		hit = 304,
% 		crit = 129,
% 		ten = 340,
% 		spr_att = 728,
% 		spr_def = 517,
% 		mag_att = 0,
% 		mag_def = 213,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 221,
		
% 		resis = 0	};

% 	get(2, 62) ->
% 	#attrs{
% 		phy_att = 292,
% 		phy_def = 424,
% 		hp_lim = 6514,
% 		dodge = 288,
% 		hit = 308,
% 		crit = 131,
% 		ten = 342,
% 		spr_att = 761,
% 		spr_def = 528,
% 		mag_att = 0,
% 		mag_def = 217,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 228,
		
% 		resis = 0	};

% 	get(2, 63) ->
% 	#attrs{
% 		phy_att = 304,
% 		phy_def = 434,
% 		hp_lim = 6892,
% 		dodge = 291,
% 		hit = 311,
% 		crit = 133,
% 		ten = 344,
% 		spr_att = 796,
% 		spr_def = 542,
% 		mag_att = 0,
% 		mag_def = 223,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 235,
		
% 		resis = 0	};

% 	get(2, 64) ->
% 	#attrs{
% 		phy_att = 316,
% 		phy_def = 444,
% 		hp_lim = 7294,
% 		dodge = 295,
% 		hit = 315,
% 		crit = 135,
% 		ten = 346,
% 		spr_att = 828,
% 		spr_def = 553,
% 		mag_att = 0,
% 		mag_def = 228,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 242,
		
% 		resis = 0	};

% 	get(2, 65) ->
% 	#attrs{
% 		phy_att = 329,
% 		phy_def = 453,
% 		hp_lim = 7694,
% 		dodge = 298,
% 		hit = 318,
% 		crit = 137,
% 		ten = 348,
% 		spr_att = 861,
% 		spr_def = 564,
% 		mag_att = 0,
% 		mag_def = 232,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 249,
		
% 		resis = 0	};

% 	get(2, 66) ->
% 	#attrs{
% 		phy_att = 341,
% 		phy_def = 463,
% 		hp_lim = 8084,
% 		dodge = 301,
% 		hit = 321,
% 		crit = 138,
% 		ten = 350,
% 		spr_att = 896,
% 		spr_def = 578,
% 		mag_att = 0,
% 		mag_def = 239,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 256,
		
% 		resis = 0	};

% 	get(2, 67) ->
% 	#attrs{
% 		phy_att = 354,
% 		phy_def = 473,
% 		hp_lim = 8461,
% 		dodge = 305,
% 		hit = 325,
% 		crit = 140,
% 		ten = 352,
% 		spr_att = 930,
% 		spr_def = 590,
% 		mag_att = 0,
% 		mag_def = 243,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 263,
		
% 		resis = 0	};

% 	get(2, 68) ->
% 	#attrs{
% 		phy_att = 367,
% 		phy_def = 483,
% 		hp_lim = 8861,
% 		dodge = 308,
% 		hit = 328,
% 		crit = 142,
% 		ten = 354,
% 		spr_att = 963,
% 		spr_def = 601,
% 		mag_att = 0,
% 		mag_def = 248,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 270,
		
% 		resis = 0	};

% 	get(2, 69) ->
% 	#attrs{
% 		phy_att = 379,
% 		phy_def = 493,
% 		hp_lim = 9261,
% 		dodge = 312,
% 		hit = 332,
% 		crit = 144,
% 		ten = 356,
% 		spr_att = 996,
% 		spr_def = 613,
% 		mag_att = 0,
% 		mag_def = 253,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 277,
		
% 		resis = 0	};

% 	get(2, 70) ->
% 	#attrs{
% 		phy_att = 391,
% 		phy_def = 503,
% 		hp_lim = 9644,
% 		dodge = 315,
% 		hit = 335,
% 		crit = 146,
% 		ten = 358,
% 		spr_att = 1028,
% 		spr_def = 624,
% 		mag_att = 0,
% 		mag_def = 258,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 284,
		
% 		resis = 0	};

% 	get(2, 71) ->
% 	#attrs{
% 		phy_att = 410,
% 		phy_def = 513,
% 		hp_lim = 10303,
% 		dodge = 318,
% 		hit = 338,
% 		crit = 147,
% 		ten = 360,
% 		spr_att = 1079,
% 		spr_def = 640,
% 		mag_att = 0,
% 		mag_def = 264,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 292,
		
% 		resis = 0	};

% 	get(2, 72) ->
% 	#attrs{
% 		phy_att = 428,
% 		phy_def = 523,
% 		hp_lim = 10956,
% 		dodge = 322,
% 		hit = 342,
% 		crit = 149,
% 		ten = 362,
% 		spr_att = 1130,
% 		spr_def = 652,
% 		mag_att = 0,
% 		mag_def = 269,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 300,
		
% 		resis = 0	};

% 	get(2, 73) ->
% 	#attrs{
% 		phy_att = 446,
% 		phy_def = 533,
% 		hp_lim = 11635,
% 		dodge = 325,
% 		hit = 345,
% 		crit = 151,
% 		ten = 364,
% 		spr_att = 1177,
% 		spr_def = 663,
% 		mag_att = 0,
% 		mag_def = 274,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 308,
		
% 		resis = 0	};

% 	get(2, 74) ->
% 	#attrs{
% 		phy_att = 465,
% 		phy_def = 543,
% 		hp_lim = 12287,
% 		dodge = 329,
% 		hit = 349,
% 		crit = 153,
% 		ten = 366,
% 		spr_att = 1228,
% 		spr_def = 676,
% 		mag_att = 0,
% 		mag_def = 279,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 316,
		
% 		resis = 0	};

% 	get(2, 75) ->
% 	#attrs{
% 		phy_att = 483,
% 		phy_def = 554,
% 		hp_lim = 12939,
% 		dodge = 332,
% 		hit = 352,
% 		crit = 155,
% 		ten = 368,
% 		spr_att = 1279,
% 		spr_def = 688,
% 		mag_att = 0,
% 		mag_def = 284,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 324,
		
% 		resis = 0	};

% 	get(2, 76) ->
% 	#attrs{
% 		phy_att = 502,
% 		phy_def = 564,
% 		hp_lim = 13618,
% 		dodge = 335,
% 		hit = 355,
% 		crit = 156,
% 		ten = 370,
% 		spr_att = 1326,
% 		spr_def = 700,
% 		mag_att = 0,
% 		mag_def = 289,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 332,
		
% 		resis = 0	};

% 	get(2, 77) ->
% 	#attrs{
% 		phy_att = 520,
% 		phy_def = 574,
% 		hp_lim = 14270,
% 		dodge = 339,
% 		hit = 359,
% 		crit = 158,
% 		ten = 372,
% 		spr_att = 1377,
% 		spr_def = 712,
% 		mag_att = 0,
% 		mag_def = 294,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 340,
		
% 		resis = 0	};

% 	get(2, 78) ->
% 	#attrs{
% 		phy_att = 538,
% 		phy_def = 585,
% 		hp_lim = 14948,
% 		dodge = 342,
% 		hit = 362,
% 		crit = 160,
% 		ten = 374,
% 		spr_att = 1425,
% 		spr_def = 725,
% 		mag_att = 0,
% 		mag_def = 300,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 348,
		
% 		resis = 0	};

% 	get(2, 79) ->
% 	#attrs{
% 		phy_att = 557,
% 		phy_def = 595,
% 		hp_lim = 15601,
% 		dodge = 346,
% 		hit = 366,
% 		crit = 162,
% 		ten = 376,
% 		spr_att = 1475,
% 		spr_def = 737,
% 		mag_att = 0,
% 		mag_def = 305,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 356,
		
% 		resis = 0	};

% 	get(2, 80) ->
% 	#attrs{
% 		phy_att = 575,
% 		phy_def = 606,
% 		hp_lim = 16269,
% 		dodge = 349,
% 		hit = 369,
% 		crit = 164,
% 		ten = 378,
% 		spr_att = 1523,
% 		spr_def = 750,
% 		mag_att = 0,
% 		mag_def = 310,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 364,
		
% 		resis = 0	};

% 	get(2, 81) ->
% 	#attrs{
% 		phy_att = 602,
% 		phy_def = 616,
% 		hp_lim = 17390,
% 		dodge = 352,
% 		hit = 372,
% 		crit = 165,
% 		ten = 380,
% 		spr_att = 1596,
% 		spr_def = 763,
% 		mag_att = 0,
% 		mag_def = 316,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 373,
		
% 		resis = 0	};

% 	get(2, 82) ->
% 	#attrs{
% 		phy_att = 629,
% 		phy_def = 627,
% 		hp_lim = 18469,
% 		dodge = 356,
% 		hit = 376,
% 		crit = 167,
% 		ten = 382,
% 		spr_att = 1673,
% 		spr_def = 776,
% 		mag_att = 0,
% 		mag_def = 321,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 382,
		
% 		resis = 0	};

% 	get(2, 83) ->
% 	#attrs{
% 		phy_att = 656,
% 		phy_def = 637,
% 		hp_lim = 19606,
% 		dodge = 359,
% 		hit = 379,
% 		crit = 169,
% 		ten = 384,
% 		spr_att = 1743,
% 		spr_def = 789,
% 		mag_att = 0,
% 		mag_def = 326,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 391,
		
% 		resis = 0	};

% 	get(2, 84) ->
% 	#attrs{
% 		phy_att = 684,
% 		phy_def = 648,
% 		hp_lim = 20706,
% 		dodge = 363,
% 		hit = 383,
% 		crit = 171,
% 		ten = 386,
% 		spr_att = 1819,
% 		spr_def = 802,
% 		mag_att = 0,
% 		mag_def = 332,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 400,
		
% 		resis = 0	};

% 	get(2, 85) ->
% 	#attrs{
% 		phy_att = 710,
% 		phy_def = 658,
% 		hp_lim = 21814,
% 		dodge = 366,
% 		hit = 386,
% 		crit = 173,
% 		ten = 388,
% 		spr_att = 1892,
% 		spr_def = 815,
% 		mag_att = 0,
% 		mag_def = 337,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 409,
		
% 		resis = 0	};

% 	get(2, 86) ->
% 	#attrs{
% 		phy_att = 738,
% 		phy_def = 669,
% 		hp_lim = 22951,
% 		dodge = 369,
% 		hit = 389,
% 		crit = 174,
% 		ten = 390,
% 		spr_att = 1963,
% 		spr_def = 829,
% 		mag_att = 0,
% 		mag_def = 343,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 418,
		
% 		resis = 0	};

% 	get(2, 87) ->
% 	#attrs{
% 		phy_att = 765,
% 		phy_def = 680,
% 		hp_lim = 24021,
% 		dodge = 373,
% 		hit = 393,
% 		crit = 176,
% 		ten = 392,
% 		spr_att = 2040,
% 		spr_def = 842,
% 		mag_att = 0,
% 		mag_def = 349,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 427,
		
% 		resis = 0	};

% 	get(2, 88) ->
% 	#attrs{
% 		phy_att = 792,
% 		phy_def = 690,
% 		hp_lim = 25156,
% 		dodge = 376,
% 		hit = 396,
% 		crit = 178,
% 		ten = 394,
% 		spr_att = 2111,
% 		spr_def = 856,
% 		mag_att = 0,
% 		mag_def = 354,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 436,
		
% 		resis = 0	};

% 	get(2, 89) ->
% 	#attrs{
% 		phy_att = 819,
% 		phy_def = 701,
% 		hp_lim = 26254,
% 		dodge = 380,
% 		hit = 400,
% 		crit = 180,
% 		ten = 396,
% 		spr_att = 2186,
% 		spr_def = 869,
% 		mag_att = 0,
% 		mag_def = 360,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 445,
		
% 		resis = 0	};

% 	get(2, 90) ->
% 	#attrs{
% 		phy_att = 846,
% 		phy_def = 712,
% 		hp_lim = 27379,
% 		dodge = 383,
% 		hit = 403,
% 		crit = 182,
% 		ten = 398,
% 		spr_att = 2257,
% 		spr_def = 883,
% 		mag_att = 0,
% 		mag_def = 366,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 454,
		
% 		resis = 0	};

% 	get(2, 91) ->
% 	#attrs{
% 		phy_att = 882,
% 		phy_def = 722,
% 		hp_lim = 28946,
% 		dodge = 386,
% 		hit = 406,
% 		crit = 183,
% 		ten = 400,
% 		spr_att = 2355,
% 		spr_def = 892,
% 		mag_att = 0,
% 		mag_def = 369,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 464,
		
% 		resis = 0	};

% 	get(2, 92) ->
% 	#attrs{
% 		phy_att = 917,
% 		phy_def = 733,
% 		hp_lim = 30510,
% 		dodge = 390,
% 		hit = 410,
% 		crit = 185,
% 		ten = 402,
% 		spr_att = 2452,
% 		spr_def = 906,
% 		mag_att = 0,
% 		mag_def = 375,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 474,
		
% 		resis = 0	};

% 	get(2, 93) ->
% 	#attrs{
% 		phy_att = 953,
% 		phy_def = 744,
% 		hp_lim = 32095,
% 		dodge = 393,
% 		hit = 413,
% 		crit = 187,
% 		ten = 404,
% 		spr_att = 2547,
% 		spr_def = 920,
% 		mag_att = 0,
% 		mag_def = 381,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 484,
		
% 		resis = 0	};

% 	get(2, 94) ->
% 	#attrs{
% 		phy_att = 990,
% 		phy_def = 755,
% 		hp_lim = 33606,
% 		dodge = 397,
% 		hit = 417,
% 		crit = 189,
% 		ten = 406,
% 		spr_att = 2649,
% 		spr_def = 934,
% 		mag_att = 0,
% 		mag_def = 387,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 494,
		
% 		resis = 0	};

% 	get(2, 95) ->
% 	#attrs{
% 		phy_att = 1025,
% 		phy_def = 765,
% 		hp_lim = 35190,
% 		dodge = 400,
% 		hit = 420,
% 		crit = 191,
% 		ten = 408,
% 		spr_att = 2745,
% 		spr_def = 949,
% 		mag_att = 0,
% 		mag_def = 393,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 504,
		
% 		resis = 0	};

% 	get(2, 96) ->
% 	#attrs{
% 		phy_att = 1061,
% 		phy_def = 776,
% 		hp_lim = 36751,
% 		dodge = 403,
% 		hit = 423,
% 		crit = 192,
% 		ten = 410,
% 		spr_att = 2840,
% 		spr_def = 963,
% 		mag_att = 0,
% 		mag_def = 399,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 514,
		
% 		resis = 0	};

% 	get(2, 97) ->
% 	#attrs{
% 		phy_att = 1097,
% 		phy_def = 787,
% 		hp_lim = 38303,
% 		dodge = 407,
% 		hit = 427,
% 		crit = 194,
% 		ten = 412,
% 		spr_att = 2940,
% 		spr_def = 972,
% 		mag_att = 0,
% 		mag_def = 403,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 524,
		
% 		resis = 0	};

% 	get(2, 98) ->
% 	#attrs{
% 		phy_att = 1132,
% 		phy_def = 798,
% 		hp_lim = 39887,
% 		dodge = 410,
% 		hit = 430,
% 		crit = 196,
% 		ten = 414,
% 		spr_att = 3035,
% 		spr_def = 987,
% 		mag_att = 0,
% 		mag_def = 409,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 534,
		
% 		resis = 0	};

% 	get(2, 99) ->
% 	#attrs{
% 		phy_att = 1168,
% 		phy_def = 808,
% 		hp_lim = 41386,
% 		dodge = 414,
% 		hit = 434,
% 		crit = 198,
% 		ten = 416,
% 		spr_att = 3138,
% 		spr_def = 1002,
% 		mag_att = 0,
% 		mag_def = 415,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 544,
		
% 		resis = 0	};

% 	get(2, 100) ->
% 	#attrs{
% 		phy_att = 1204,
% 		phy_def = 819,
% 		hp_lim = 43032,
% 		dodge = 417,
% 		hit = 437,
% 		crit = 200,
% 		ten = 418,
% 		spr_att = 3227,
% 		spr_def = 1011,
% 		mag_att = 0,
% 		mag_def = 419,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 100,
% 		pro_mag = 0,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 554,
		
% 		resis = 0	};

% 	get(4, 1) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 11,
% 		hp_lim = 131,
% 		dodge = 120,
% 		hit = 150,
% 		crit = 21,
% 		ten = 32,
% 		spr_att = 93,
% 		spr_def = 15,
% 		mag_att = 57,
% 		mag_def = 6,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 15,
		
% 		resis = 0	};

% 	get(4, 2) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 13,
% 		hp_lim = 140,
% 		dodge = 124,
% 		hit = 154,
% 		crit = 23,
% 		ten = 33,
% 		spr_att = 97,
% 		spr_def = 18,
% 		mag_att = 60,
% 		mag_def = 7,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 19,
		
% 		resis = 0	};

% 	get(4, 3) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 15,
% 		hp_lim = 150,
% 		dodge = 128,
% 		hit = 158,
% 		crit = 25,
% 		ten = 34,
% 		spr_att = 102,
% 		spr_def = 20,
% 		mag_att = 63,
% 		mag_def = 8,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 23,
		
% 		resis = 0	};

% 	get(4, 4) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 17,
% 		hp_lim = 159,
% 		dodge = 132,
% 		hit = 162,
% 		crit = 27,
% 		ten = 35,
% 		spr_att = 107,
% 		spr_def = 23,
% 		mag_att = 66,
% 		mag_def = 9,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 27,
		
% 		resis = 0	};

% 	get(4, 5) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 19,
% 		hp_lim = 169,
% 		dodge = 135,
% 		hit = 165,
% 		crit = 29,
% 		ten = 36,
% 		spr_att = 112,
% 		spr_def = 25,
% 		mag_att = 69,
% 		mag_def = 10,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 31,
		
% 		resis = 0	};

% 	get(4, 6) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 21,
% 		hp_lim = 180,
% 		dodge = 139,
% 		hit = 169,
% 		crit = 30,
% 		ten = 37,
% 		spr_att = 116,
% 		spr_def = 28,
% 		mag_att = 71,
% 		mag_def = 11,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 35,
		
% 		resis = 0	};

% 	get(4, 7) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 23,
% 		hp_lim = 190,
% 		dodge = 143,
% 		hit = 173,
% 		crit = 32,
% 		ten = 38,
% 		spr_att = 120,
% 		spr_def = 31,
% 		mag_att = 74,
% 		mag_def = 12,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 39,
		
% 		resis = 0	};

% 	get(4, 8) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 26,
% 		hp_lim = 199,
% 		dodge = 146,
% 		hit = 176,
% 		crit = 34,
% 		ten = 39,
% 		spr_att = 125,
% 		spr_def = 34,
% 		mag_att = 77,
% 		mag_def = 14,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 43,
		
% 		resis = 0	};

% 	get(4, 9) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 28,
% 		hp_lim = 209,
% 		dodge = 150,
% 		hit = 180,
% 		crit = 36,
% 		ten = 40,
% 		spr_att = 131,
% 		spr_def = 37,
% 		mag_att = 80,
% 		mag_def = 15,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 47,
		
% 		resis = 0	};

% 	get(4, 10) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 31,
% 		hp_lim = 219,
% 		dodge = 154,
% 		hit = 184,
% 		crit = 38,
% 		ten = 41,
% 		spr_att = 132,
% 		spr_def = 40,
% 		mag_att = 81,
% 		mag_def = 16,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 51,
		
% 		resis = 0	};

% 	get(4, 11) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 34,
% 		hp_lim = 232,
% 		dodge = 157,
% 		hit = 187,
% 		crit = 39,
% 		ten = 42,
% 		spr_att = 141,
% 		spr_def = 44,
% 		mag_att = 86,
% 		mag_def = 18,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 56,
		
% 		resis = 0	};

% 	get(4, 12) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 36,
% 		hp_lim = 248,
% 		dodge = 161,
% 		hit = 191,
% 		crit = 41,
% 		ten = 43,
% 		spr_att = 147,
% 		spr_def = 47,
% 		mag_att = 90,
% 		mag_def = 19,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 61,
		
% 		resis = 0	};

% 	get(4, 13) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 39,
% 		hp_lim = 264,
% 		dodge = 165,
% 		hit = 195,
% 		crit = 43,
% 		ten = 44,
% 		spr_att = 153,
% 		spr_def = 50,
% 		mag_att = 94,
% 		mag_def = 20,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 66,
		
% 		resis = 0	};

% 	get(4, 14) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 42,
% 		hp_lim = 278,
% 		dodge = 169,
% 		hit = 199,
% 		crit = 45,
% 		ten = 45,
% 		spr_att = 159,
% 		spr_def = 54,
% 		mag_att = 97,
% 		mag_def = 22,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 71,
		
% 		resis = 0	};

% 	get(4, 15) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 44,
% 		hp_lim = 295,
% 		dodge = 172,
% 		hit = 202,
% 		crit = 47,
% 		ten = 46,
% 		spr_att = 166,
% 		spr_def = 57,
% 		mag_att = 101,
% 		mag_def = 23,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 76,
		
% 		resis = 0	};

% 	get(4, 16) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 47,
% 		hp_lim = 308,
% 		dodge = 176,
% 		hit = 206,
% 		crit = 48,
% 		ten = 47,
% 		spr_att = 173,
% 		spr_def = 61,
% 		mag_att = 106,
% 		mag_def = 24,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 81,
		
% 		resis = 0	};

% 	get(4, 17) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 50,
% 		hp_lim = 325,
% 		dodge = 180,
% 		hit = 210,
% 		crit = 50,
% 		ten = 48,
% 		spr_att = 176,
% 		spr_def = 65,
% 		mag_att = 108,
% 		mag_def = 26,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 86,
		
% 		resis = 0	};

% 	get(4, 18) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 53,
% 		hp_lim = 338,
% 		dodge = 183,
% 		hit = 213,
% 		crit = 52,
% 		ten = 49,
% 		spr_att = 185,
% 		spr_def = 69,
% 		mag_att = 113,
% 		mag_def = 28,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 91,
		
% 		resis = 0	};

% 	get(4, 19) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 57,
% 		hp_lim = 354,
% 		dodge = 187,
% 		hit = 217,
% 		crit = 54,
% 		ten = 50,
% 		spr_att = 192,
% 		spr_def = 73,
% 		mag_att = 117,
% 		mag_def = 29,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 96,
		
% 		resis = 0	};

% 	get(4, 20) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 59,
% 		hp_lim = 368,
% 		dodge = 191,
% 		hit = 221,
% 		crit = 56,
% 		ten = 52,
% 		spr_att = 196,
% 		spr_def = 76,
% 		mag_att = 120,
% 		mag_def = 31,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 101,
		
% 		resis = 0	};

% 	get(4, 21) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 63,
% 		hp_lim = 396,
% 		dodge = 194,
% 		hit = 224,
% 		crit = 57,
% 		ten = 53,
% 		spr_att = 204,
% 		spr_def = 80,
% 		mag_att = 125,
% 		mag_def = 32,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 107,
		
% 		resis = 0	};

% 	get(4, 22) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 66,
% 		hp_lim = 421,
% 		dodge = 198,
% 		hit = 228,
% 		crit = 59,
% 		ten = 54,
% 		spr_att = 214,
% 		spr_def = 84,
% 		mag_att = 131,
% 		mag_def = 34,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 113,
		
% 		resis = 0	};

% 	get(4, 23) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 69,
% 		hp_lim = 446,
% 		dodge = 202,
% 		hit = 232,
% 		crit = 61,
% 		ten = 55,
% 		spr_att = 223,
% 		spr_def = 88,
% 		mag_att = 137,
% 		mag_def = 36,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 119,
		
% 		resis = 0	};

% 	get(4, 24) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 72,
% 		hp_lim = 474,
% 		dodge = 206,
% 		hit = 236,
% 		crit = 63,
% 		ten = 56,
% 		spr_att = 232,
% 		spr_def = 92,
% 		mag_att = 142,
% 		mag_def = 37,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 125,
		
% 		resis = 0	};

% 	get(4, 25) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 76,
% 		hp_lim = 498,
% 		dodge = 209,
% 		hit = 239,
% 		crit = 65,
% 		ten = 57,
% 		spr_att = 241,
% 		spr_def = 96,
% 		mag_att = 148,
% 		mag_def = 39,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 131,
		
% 		resis = 0	};

% 	get(4, 26) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 79,
% 		hp_lim = 524,
% 		dodge = 213,
% 		hit = 243,
% 		crit = 66,
% 		ten = 58,
% 		spr_att = 250,
% 		spr_def = 100,
% 		mag_att = 154,
% 		mag_def = 41,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 137,
		
% 		resis = 0	};

% 	get(4, 27) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 83,
% 		hp_lim = 548,
% 		dodge = 217,
% 		hit = 247,
% 		crit = 68,
% 		ten = 59,
% 		spr_att = 261,
% 		spr_def = 105,
% 		mag_att = 160,
% 		mag_def = 43,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 143,
		
% 		resis = 0	};

% 	get(4, 28) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 86,
% 		hp_lim = 577,
% 		dodge = 220,
% 		hit = 250,
% 		crit = 70,
% 		ten = 60,
% 		spr_att = 268,
% 		spr_def = 109,
% 		mag_att = 165,
% 		mag_def = 44,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 149,
		
% 		resis = 0	};

% 	get(4, 29) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 90,
% 		hp_lim = 602,
% 		dodge = 224,
% 		hit = 254,
% 		crit = 72,
% 		ten = 61,
% 		spr_att = 278,
% 		spr_def = 114,
% 		mag_att = 171,
% 		mag_def = 47,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 155,
		
% 		resis = 0	};

% 	get(4, 30) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 94,
% 		hp_lim = 628,
% 		dodge = 228,
% 		hit = 258,
% 		crit = 74,
% 		ten = 62,
% 		spr_att = 285,
% 		spr_def = 118,
% 		mag_att = 175,
% 		mag_def = 48,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 161,
		
% 		resis = 0	};

% 	get(4, 31) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 97,
% 		hp_lim = 670,
% 		dodge = 231,
% 		hit = 261,
% 		crit = 75,
% 		ten = 63,
% 		spr_att = 298,
% 		spr_def = 122,
% 		mag_att = 184,
% 		mag_def = 50,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 168,
		
% 		resis = 0	};

% 	get(4, 32) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 101,
% 		hp_lim = 715,
% 		dodge = 235,
% 		hit = 265,
% 		crit = 77,
% 		ten = 64,
% 		spr_att = 312,
% 		spr_def = 128,
% 		mag_att = 192,
% 		mag_def = 52,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 175,
		
% 		resis = 0	};

% 	get(4, 33) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 105,
% 		hp_lim = 758,
% 		dodge = 239,
% 		hit = 269,
% 		crit = 79,
% 		ten = 65,
% 		spr_att = 326,
% 		spr_def = 132,
% 		mag_att = 201,
% 		mag_def = 54,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 182,
		
% 		resis = 0	};

% 	get(4, 34) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 108,
% 		hp_lim = 804,
% 		dodge = 243,
% 		hit = 273,
% 		crit = 81,
% 		ten = 66,
% 		spr_att = 338,
% 		spr_def = 136,
% 		mag_att = 209,
% 		mag_def = 56,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 189,
		
% 		resis = 0	};

% 	get(4, 35) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 113,
% 		hp_lim = 846,
% 		dodge = 246,
% 		hit = 276,
% 		crit = 83,
% 		ten = 67,
% 		spr_att = 353,
% 		spr_def = 142,
% 		mag_att = 218,
% 		mag_def = 58,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 196,
		
% 		resis = 0	};

% 	get(4, 36) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 117,
% 		hp_lim = 892,
% 		dodge = 250,
% 		hit = 280,
% 		crit = 84,
% 		ten = 68,
% 		spr_att = 365,
% 		spr_def = 147,
% 		mag_att = 226,
% 		mag_def = 60,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 203,
		
% 		resis = 0	};

% 	get(4, 37) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 122,
% 		hp_lim = 936,
% 		dodge = 254,
% 		hit = 284,
% 		crit = 86,
% 		ten = 69,
% 		spr_att = 377,
% 		spr_def = 153,
% 		mag_att = 233,
% 		mag_def = 62,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 210,
		
% 		resis = 0	};

% 	get(4, 38) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 125,
% 		hp_lim = 978,
% 		dodge = 257,
% 		hit = 287,
% 		crit = 88,
% 		ten = 70,
% 		spr_att = 391,
% 		spr_def = 157,
% 		mag_att = 242,
% 		mag_def = 64,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 217,
		
% 		resis = 0	};

% 	get(4, 39) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 129,
% 		hp_lim = 1024,
% 		dodge = 261,
% 		hit = 291,
% 		crit = 90,
% 		ten = 71,
% 		spr_att = 404,
% 		spr_def = 162,
% 		mag_att = 250,
% 		mag_def = 66,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 224,
		
% 		resis = 0	};

% 	get(4, 40) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 133,
% 		hp_lim = 1068,
% 		dodge = 265,
% 		hit = 295,
% 		crit = 92,
% 		ten = 73,
% 		spr_att = 416,
% 		spr_def = 167,
% 		mag_att = 258,
% 		mag_def = 68,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 231,
		
% 		resis = 0	};

% 	get(4, 41) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 137,
% 		hp_lim = 1141,
% 		dodge = 268,
% 		hit = 298,
% 		crit = 93,
% 		ten = 74,
% 		spr_att = 438,
% 		spr_def = 172,
% 		mag_att = 272,
% 		mag_def = 70,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 239,
		
% 		resis = 0	};

% 	get(4, 42) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 142,
% 		hp_lim = 1216,
% 		dodge = 272,
% 		hit = 302,
% 		crit = 95,
% 		ten = 75,
% 		spr_att = 456,
% 		spr_def = 178,
% 		mag_att = 283,
% 		mag_def = 73,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 247,
		
% 		resis = 0	};

% 	get(4, 43) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 146,
% 		hp_lim = 1290,
% 		dodge = 276,
% 		hit = 306,
% 		crit = 97,
% 		ten = 76,
% 		spr_att = 477,
% 		spr_def = 183,
% 		mag_att = 296,
% 		mag_def = 75,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 255,
		
% 		resis = 0	};

% 	get(4, 44) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 150,
% 		hp_lim = 1363,
% 		dodge = 280,
% 		hit = 310,
% 		crit = 99,
% 		ten = 77,
% 		spr_att = 497,
% 		spr_def = 188,
% 		mag_att = 309,
% 		mag_def = 77,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 263,
		
% 		resis = 0	};

% 	get(4, 45) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 155,
% 		hp_lim = 1440,
% 		dodge = 283,
% 		hit = 313,
% 		crit = 101,
% 		ten = 78,
% 		spr_att = 514,
% 		spr_def = 193,
% 		mag_att = 320,
% 		mag_def = 79,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 271,
		
% 		resis = 0	};

% 	get(4, 46) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 159,
% 		hp_lim = 1514,
% 		dodge = 287,
% 		hit = 317,
% 		crit = 102,
% 		ten = 79,
% 		spr_att = 535,
% 		spr_def = 198,
% 		mag_att = 333,
% 		mag_def = 82,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 279,
		
% 		resis = 0	};

% 	get(4, 47) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 163,
% 		hp_lim = 1587,
% 		dodge = 291,
% 		hit = 321,
% 		crit = 104,
% 		ten = 80,
% 		spr_att = 555,
% 		spr_def = 204,
% 		mag_att = 346,
% 		mag_def = 84,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 287,
		
% 		resis = 0	};

% 	get(4, 48) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 169,
% 		hp_lim = 1665,
% 		dodge = 294,
% 		hit = 324,
% 		crit = 106,
% 		ten = 81,
% 		spr_att = 575,
% 		spr_def = 211,
% 		mag_att = 358,
% 		mag_def = 87,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 295,
		
% 		resis = 0	};

% 	get(4, 49) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 173,
% 		hp_lim = 1736,
% 		dodge = 298,
% 		hit = 328,
% 		crit = 108,
% 		ten = 82,
% 		spr_att = 594,
% 		spr_def = 216,
% 		mag_att = 370,
% 		mag_def = 89,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 303,
		
% 		resis = 0	};

% 	get(4, 50) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 178,
% 		hp_lim = 1811,
% 		dodge = 302,
% 		hit = 332,
% 		crit = 110,
% 		ten = 83,
% 		spr_att = 613,
% 		spr_def = 222,
% 		mag_att = 382,
% 		mag_def = 91,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 311,
		
% 		resis = 0	};

% 	get(4, 51) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 182,
% 		hp_lim = 1940,
% 		dodge = 305,
% 		hit = 335,
% 		crit = 111,
% 		ten = 84,
% 		spr_att = 643,
% 		spr_def = 227,
% 		mag_att = 401,
% 		mag_def = 94,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 320,
		
% 		resis = 0	};

% 	get(4, 52) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 187,
% 		hp_lim = 2065,
% 		dodge = 309,
% 		hit = 339,
% 		crit = 113,
% 		ten = 85,
% 		spr_att = 670,
% 		spr_def = 233,
% 		mag_att = 418,
% 		mag_def = 96,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 329,
		
% 		resis = 0	};

% 	get(4, 53) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 192,
% 		hp_lim = 2193,
% 		dodge = 313,
% 		hit = 343,
% 		crit = 115,
% 		ten = 86,
% 		spr_att = 698,
% 		spr_def = 239,
% 		mag_att = 436,
% 		mag_def = 98,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 338,
		
% 		resis = 0	};

% 	get(4, 54) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 196,
% 		hp_lim = 2319,
% 		dodge = 317,
% 		hit = 347,
% 		crit = 117,
% 		ten = 87,
% 		spr_att = 727,
% 		spr_def = 244,
% 		mag_att = 455,
% 		mag_def = 101,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 347,
		
% 		resis = 0	};

% 	get(4, 55) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 201,
% 		hp_lim = 2447,
% 		dodge = 320,
% 		hit = 350,
% 		crit = 119,
% 		ten = 88,
% 		spr_att = 756,
% 		spr_def = 250,
% 		mag_att = 473,
% 		mag_def = 103,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 356,
		
% 		resis = 0	};

% 	get(4, 56) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 206,
% 		hp_lim = 2576,
% 		dodge = 324,
% 		hit = 354,
% 		crit = 120,
% 		ten = 89,
% 		spr_att = 782,
% 		spr_def = 256,
% 		mag_att = 490,
% 		mag_def = 105,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 365,
		
% 		resis = 0	};

% 	get(4, 57) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 211,
% 		hp_lim = 2696,
% 		dodge = 328,
% 		hit = 358,
% 		crit = 122,
% 		ten = 90,
% 		spr_att = 813,
% 		spr_def = 262,
% 		mag_att = 509,
% 		mag_def = 108,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 374,
		
% 		resis = 0	};

% 	get(4, 58) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 216,
% 		hp_lim = 2829,
% 		dodge = 331,
% 		hit = 361,
% 		crit = 124,
% 		ten = 91,
% 		spr_att = 840,
% 		spr_def = 268,
% 		mag_att = 527,
% 		mag_def = 110,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 383,
		
% 		resis = 0	};

% 	get(4, 59) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 221,
% 		hp_lim = 2952,
% 		dodge = 335,
% 		hit = 365,
% 		crit = 126,
% 		ten = 92,
% 		spr_att = 870,
% 		spr_def = 274,
% 		mag_att = 546,
% 		mag_def = 113,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 392,
		
% 		resis = 0	};

% 	get(4, 60) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 226,
% 		hp_lim = 3078,
% 		dodge = 339,
% 		hit = 369,
% 		crit = 128,
% 		ten = 94,
% 		spr_att = 897,
% 		spr_def = 280,
% 		mag_att = 563,
% 		mag_def = 116,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 401,
		
% 		resis = 0	};

% 	get(4, 61) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 231,
% 		hp_lim = 3292,
% 		dodge = 342,
% 		hit = 372,
% 		crit = 129,
% 		ten = 95,
% 		spr_att = 940,
% 		spr_def = 286,
% 		mag_att = 590,
% 		mag_def = 118,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 411,
		
% 		resis = 0	};

% 	get(4, 62) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 236,
% 		hp_lim = 3504,
% 		dodge = 346,
% 		hit = 376,
% 		crit = 131,
% 		ten = 96,
% 		spr_att = 983,
% 		spr_def = 293,
% 		mag_att = 617,
% 		mag_def = 121,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 421,
		
% 		resis = 0	};

% 	get(4, 63) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 241,
% 		hp_lim = 3722,
% 		dodge = 350,
% 		hit = 380,
% 		crit = 133,
% 		ten = 97,
% 		spr_att = 1024,
% 		spr_def = 299,
% 		mag_att = 644,
% 		mag_def = 123,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 431,
		
% 		resis = 0	};

% 	get(4, 64) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 246,
% 		hp_lim = 3936,
% 		dodge = 354,
% 		hit = 384,
% 		crit = 135,
% 		ten = 98,
% 		spr_att = 1067,
% 		spr_def = 305,
% 		mag_att = 671,
% 		mag_def = 126,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 441,
		
% 		resis = 0	};

% 	get(4, 65) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 251,
% 		hp_lim = 4150,
% 		dodge = 357,
% 		hit = 387,
% 		crit = 137,
% 		ten = 99,
% 		spr_att = 1109,
% 		spr_def = 312,
% 		mag_att = 698,
% 		mag_def = 129,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 451,
		
% 		resis = 0	};

% 	get(4, 66) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 257,
% 		hp_lim = 4363,
% 		dodge = 361,
% 		hit = 391,
% 		crit = 138,
% 		ten = 100,
% 		spr_att = 1152,
% 		spr_def = 318,
% 		mag_att = 725,
% 		mag_def = 132,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 461,
		
% 		resis = 0	};

% 	get(4, 67) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 260,
% 		hp_lim = 4581,
% 		dodge = 365,
% 		hit = 395,
% 		crit = 140,
% 		ten = 101,
% 		spr_att = 1194,
% 		spr_def = 323,
% 		mag_att = 752,
% 		mag_def = 133,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 471,
		
% 		resis = 0	};

% 	get(4, 68) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 266,
% 		hp_lim = 4795,
% 		dodge = 368,
% 		hit = 398,
% 		crit = 142,
% 		ten = 102,
% 		spr_att = 1236,
% 		spr_def = 329,
% 		mag_att = 779,
% 		mag_def = 136,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 481,
		
% 		resis = 0	};

% 	get(4, 69) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 271,
% 		hp_lim = 5009,
% 		dodge = 372,
% 		hit = 402,
% 		crit = 144,
% 		ten = 103,
% 		spr_att = 1278,
% 		spr_def = 336,
% 		mag_att = 806,
% 		mag_def = 139,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 491,
		
% 		resis = 0	};

% 	get(4, 70) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 277,
% 		hp_lim = 5227,
% 		dodge = 376,
% 		hit = 406,
% 		crit = 146,
% 		ten = 104,
% 		spr_att = 1318,
% 		spr_def = 343,
% 		mag_att = 831,
% 		mag_def = 142,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 501,
		
% 		resis = 0	};

% 	get(4, 71) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 282,
% 		hp_lim = 5591,
% 		dodge = 379,
% 		hit = 409,
% 		crit = 147,
% 		ten = 105,
% 		spr_att = 1383,
% 		spr_def = 350,
% 		mag_att = 872,
% 		mag_def = 144,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 512,
		
% 		resis = 0	};

% 	get(4, 72) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 288,
% 		hp_lim = 5950,
% 		dodge = 383,
% 		hit = 413,
% 		crit = 149,
% 		ten = 106,
% 		spr_att = 1445,
% 		spr_def = 357,
% 		mag_att = 912,
% 		mag_def = 147,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 523,
		
% 		resis = 0	};

% 	get(4, 73) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 291,
% 		hp_lim = 6317,
% 		dodge = 387,
% 		hit = 417,
% 		crit = 151,
% 		ten = 107,
% 		spr_att = 1507,
% 		spr_def = 361,
% 		mag_att = 952,
% 		mag_def = 149,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 534,
		
% 		resis = 0	};

% 	get(4, 74) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 297,
% 		hp_lim = 6678,
% 		dodge = 391,
% 		hit = 421,
% 		crit = 153,
% 		ten = 108,
% 		spr_att = 1570,
% 		spr_def = 368,
% 		mag_att = 992,
% 		mag_def = 152,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 545,
		
% 		resis = 0	};

% 	get(4, 75) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 303,
% 		hp_lim = 7045,
% 		dodge = 394,
% 		hit = 424,
% 		crit = 155,
% 		ten = 109,
% 		spr_att = 1631,
% 		spr_def = 375,
% 		mag_att = 1031,
% 		mag_def = 155,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 556,
		
% 		resis = 0	};

% 	get(4, 76) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 309,
% 		hp_lim = 7407,
% 		dodge = 398,
% 		hit = 428,
% 		crit = 156,
% 		ten = 110,
% 		spr_att = 1694,
% 		spr_def = 382,
% 		mag_att = 1071,
% 		mag_def = 158,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 567,
		
% 		resis = 0	};

% 	get(4, 77) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 315,
% 		hp_lim = 7768,
% 		dodge = 402,
% 		hit = 432,
% 		crit = 158,
% 		ten = 111,
% 		spr_att = 1756,
% 		spr_def = 389,
% 		mag_att = 1111,
% 		mag_def = 161,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 578,
		
% 		resis = 0	};

% 	get(4, 78) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 321,
% 		hp_lim = 8129,
% 		dodge = 405,
% 		hit = 435,
% 		crit = 160,
% 		ten = 112,
% 		spr_att = 1820,
% 		spr_def = 397,
% 		mag_att = 1151,
% 		mag_def = 164,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 589,
		
% 		resis = 0	};

% 	get(4, 79) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 324,
% 		hp_lim = 8507,
% 		dodge = 409,
% 		hit = 439,
% 		crit = 162,
% 		ten = 113,
% 		spr_att = 1878,
% 		spr_def = 401,
% 		mag_att = 1190,
% 		mag_def = 166,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 600,
		
% 		resis = 0	};

% 	get(4, 80) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 330,
% 		hp_lim = 8863,
% 		dodge = 413,
% 		hit = 443,
% 		crit = 164,
% 		ten = 115,
% 		spr_att = 1941,
% 		spr_def = 409,
% 		mag_att = 1230,
% 		mag_def = 169,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 611,
		
% 		resis = 0	};

% 	get(4, 81) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 336,
% 		hp_lim = 9484,
% 		dodge = 416,
% 		hit = 446,
% 		crit = 165,
% 		ten = 116,
% 		spr_att = 2032,
% 		spr_def = 416,
% 		mag_att = 1288,
% 		mag_def = 172,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 623,
		
% 		resis = 0	};

% 	get(4, 82) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 340,
% 		hp_lim = 10091,
% 		dodge = 420,
% 		hit = 450,
% 		crit = 167,
% 		ten = 117,
% 		spr_att = 2127,
% 		spr_def = 421,
% 		mag_att = 1348,
% 		mag_def = 174,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 635,
		
% 		resis = 0	};

% 	get(4, 83) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 346,
% 		hp_lim = 10707,
% 		dodge = 424,
% 		hit = 454,
% 		crit = 169,
% 		ten = 118,
% 		spr_att = 2217,
% 		spr_def = 428,
% 		mag_att = 1406,
% 		mag_def = 177,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 647,
		
% 		resis = 0	};

% 	get(4, 84) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 353,
% 		hp_lim = 11318,
% 		dodge = 428,
% 		hit = 458,
% 		crit = 171,
% 		ten = 119,
% 		spr_att = 2311,
% 		spr_def = 436,
% 		mag_att = 1466,
% 		mag_def = 180,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 659,
		
% 		resis = 0	};

% 	get(4, 85) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 359,
% 		hp_lim = 11935,
% 		dodge = 431,
% 		hit = 461,
% 		crit = 173,
% 		ten = 120,
% 		spr_att = 2402,
% 		spr_def = 443,
% 		mag_att = 1524,
% 		mag_def = 184,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 671,
		
% 		resis = 0	};

% 	get(4, 86) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 363,
% 		hp_lim = 12563,
% 		dodge = 435,
% 		hit = 465,
% 		crit = 174,
% 		ten = 121,
% 		spr_att = 2491,
% 		spr_def = 448,
% 		mag_att = 1582,
% 		mag_def = 186,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 683,
		
% 		resis = 0	};

% 	get(4, 87) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 369,
% 		hp_lim = 13160,
% 		dodge = 439,
% 		hit = 469,
% 		crit = 176,
% 		ten = 122,
% 		spr_att = 2588,
% 		spr_def = 456,
% 		mag_att = 1642,
% 		mag_def = 189,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 695,
		
% 		resis = 0	};

% 	get(4, 88) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 376,
% 		hp_lim = 13777,
% 		dodge = 442,
% 		hit = 472,
% 		crit = 178,
% 		ten = 123,
% 		spr_att = 2678,
% 		spr_def = 464,
% 		mag_att = 1700,
% 		mag_def = 192,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 707,
		
% 		resis = 0	};

% 	get(4, 89) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 379,
% 		hp_lim = 14403,
% 		dodge = 446,
% 		hit = 476,
% 		crit = 180,
% 		ten = 124,
% 		spr_att = 2769,
% 		spr_def = 468,
% 		mag_att = 1760,
% 		mag_def = 194,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 719,
		
% 		resis = 0	};

% 	get(4, 90) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 386,
% 		hp_lim = 15024,
% 		dodge = 450,
% 		hit = 480,
% 		crit = 182,
% 		ten = 125,
% 		spr_att = 2857,
% 		spr_def = 476,
% 		mag_att = 1817,
% 		mag_def = 197,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 731,
		
% 		resis = 0	};

% 	get(4, 91) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 393,
% 		hp_lim = 15870,
% 		dodge = 453,
% 		hit = 483,
% 		crit = 183,
% 		ten = 126,
% 		spr_att = 2985,
% 		spr_def = 485,
% 		mag_att = 1896,
% 		mag_def = 201,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 744,
		
% 		resis = 0	};

% 	get(4, 92) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 397,
% 		hp_lim = 16749,
% 		dodge = 457,
% 		hit = 487,
% 		crit = 185,
% 		ten = 127,
% 		spr_att = 3102,
% 		spr_def = 489,
% 		mag_att = 1973,
% 		mag_def = 203,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 757,
		
% 		resis = 0	};

% 	get(4, 93) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 403,
% 		hp_lim = 17618,
% 		dodge = 461,
% 		hit = 491,
% 		crit = 187,
% 		ten = 128,
% 		spr_att = 3224,
% 		spr_def = 497,
% 		mag_att = 2051,
% 		mag_def = 206,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 770,
		
% 		resis = 0	};

% 	get(4, 94) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 407,
% 		hp_lim = 18481,
% 		dodge = 465,
% 		hit = 495,
% 		crit = 189,
% 		ten = 129,
% 		spr_att = 3346,
% 		spr_def = 502,
% 		mag_att = 2129,
% 		mag_def = 208,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 783,
		
% 		resis = 0	};

% 	get(4, 95) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 414,
% 		hp_lim = 19351,
% 		dodge = 468,
% 		hit = 498,
% 		crit = 191,
% 		ten = 130,
% 		spr_att = 3468,
% 		spr_def = 511,
% 		mag_att = 2207,
% 		mag_def = 212,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 796,
		
% 		resis = 0	};

% 	get(4, 96) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 421,
% 		hp_lim = 20217,
% 		dodge = 472,
% 		hit = 502,
% 		crit = 192,
% 		ten = 131,
% 		spr_att = 3588,
% 		spr_def = 519,
% 		mag_att = 2284,
% 		mag_def = 215,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 809,
		
% 		resis = 0	};

% 	get(4, 97) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 425,
% 		hp_lim = 21081,
% 		dodge = 476,
% 		hit = 506,
% 		crit = 194,
% 		ten = 132,
% 		spr_att = 3710,
% 		spr_def = 524,
% 		mag_att = 2362,
% 		mag_def = 217,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 822,
		
% 		resis = 0	};

% 	get(4, 98) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 432,
% 		hp_lim = 21952,
% 		dodge = 479,
% 		hit = 509,
% 		crit = 196,
% 		ten = 133,
% 		spr_att = 3832,
% 		spr_def = 532,
% 		mag_att = 2440,
% 		mag_def = 221,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 835,
		
% 		resis = 0	};

% 	get(4, 99) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 436,
% 		hp_lim = 22816,
% 		dodge = 483,
% 		hit = 513,
% 		crit = 198,
% 		ten = 134,
% 		spr_att = 3954,
% 		spr_def = 537,
% 		mag_att = 2518,
% 		mag_def = 223,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 848,
		
% 		resis = 0	};

% 	get(4, 100) ->
% 	#attrs{
% 		phy_att = 0,
% 		phy_def = 443,
% 		hp_lim = 23684,
% 		dodge = 487,
% 		hit = 517,
% 		crit = 200,
% 		ten = 136,
% 		spr_att = 4074,
% 		spr_def = 546,
% 		mag_att = 2595,
% 		mag_def = 226,
% 		pro_sword = 0,
% 		pro_bow = 0,
% 		pro_spear = 0,
% 		pro_mag = 100,
% 		resis_sword = 100,
% 		resis_bow = 100,
% 		resis_spear = 100,
% 		resis_mag = 100,
% 		fight_order_factor = 861,
		
% 		resis = 0	};


% get(_Career, _Lv) ->
% 	[].
