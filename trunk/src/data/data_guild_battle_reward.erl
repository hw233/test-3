%%%---------------------------------------
%%% @Module  : data_skill
%%% @Author  : huangjf
%%% @Email   : 
%%% @Description: 帮战奖励
%%%---------------------------------------


-module(data_guild_battle_reward).
-export([
        get_all_no_list/0,
        get_no_list_by_class/1,
        get/1
    ]).

-include("guild_battle.hrl").
-include("debug.hrl").

get_all_no_list()->
	[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114].

get_no_list_by_class(1)->
	[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40];
get_no_list_by_class(2)->
	[41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89];
get_no_list_by_class(3)->
	[90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114].

get(1) ->
	#guild_battle_reward_cfg{
		no = 1,
		class = 1,
		reward_pool_no = 60001,
		widget = 50
};

get(2) ->
	#guild_battle_reward_cfg{
		no = 2,
		class = 1,
		reward_pool_no = 60002,
		widget = 25
};

get(3) ->
	#guild_battle_reward_cfg{
		no = 3,
		class = 1,
		reward_pool_no = 60003,
		widget = 20
};

get(4) ->
	#guild_battle_reward_cfg{
		no = 4,
		class = 1,
		reward_pool_no = 60004,
		widget = 20
};

get(5) ->
	#guild_battle_reward_cfg{
		no = 5,
		class = 1,
		reward_pool_no = 60005,
		widget = 20
};

get(6) ->
	#guild_battle_reward_cfg{
		no = 6,
		class = 1,
		reward_pool_no = 60006,
		widget = 20
};

get(7) ->
	#guild_battle_reward_cfg{
		no = 7,
		class = 1,
		reward_pool_no = 60007,
		widget = 50
};

get(8) ->
	#guild_battle_reward_cfg{
		no = 8,
		class = 1,
		reward_pool_no = 60008,
		widget = 40
};

get(9) ->
	#guild_battle_reward_cfg{
		no = 9,
		class = 1,
		reward_pool_no = 60009,
		widget = 35
};

get(10) ->
	#guild_battle_reward_cfg{
		no = 10,
		class = 1,
		reward_pool_no = 60010,
		widget = 30
};

get(11) ->
	#guild_battle_reward_cfg{
		no = 11,
		class = 1,
		reward_pool_no = 60011,
		widget = 30
};

get(12) ->
	#guild_battle_reward_cfg{
		no = 12,
		class = 1,
		reward_pool_no = 60012,
		widget = 20
};

get(13) ->
	#guild_battle_reward_cfg{
		no = 13,
		class = 1,
		reward_pool_no = 60013,
		widget = 15
};

get(14) ->
	#guild_battle_reward_cfg{
		no = 14,
		class = 1,
		reward_pool_no = 60014,
		widget = 10
};

get(15) ->
	#guild_battle_reward_cfg{
		no = 15,
		class = 1,
		reward_pool_no = 60015,
		widget = 50
};

get(16) ->
	#guild_battle_reward_cfg{
		no = 16,
		class = 1,
		reward_pool_no = 60016,
		widget = 30
};

get(17) ->
	#guild_battle_reward_cfg{
		no = 17,
		class = 1,
		reward_pool_no = 60017,
		widget = 20
};

get(18) ->
	#guild_battle_reward_cfg{
		no = 18,
		class = 1,
		reward_pool_no = 60018,
		widget = 15
};

get(19) ->
	#guild_battle_reward_cfg{
		no = 19,
		class = 1,
		reward_pool_no = 60019,
		widget = 50
};

get(20) ->
	#guild_battle_reward_cfg{
		no = 20,
		class = 1,
		reward_pool_no = 60020,
		widget = 25
};

get(21) ->
	#guild_battle_reward_cfg{
		no = 21,
		class = 1,
		reward_pool_no = 60021,
		widget = 25
};

get(22) ->
	#guild_battle_reward_cfg{
		no = 22,
		class = 1,
		reward_pool_no = 60022,
		widget = 25
};

get(23) ->
	#guild_battle_reward_cfg{
		no = 23,
		class = 1,
		reward_pool_no = 60023,
		widget = 25
};

get(24) ->
	#guild_battle_reward_cfg{
		no = 24,
		class = 1,
		reward_pool_no = 60024,
		widget = 25
};

get(25) ->
	#guild_battle_reward_cfg{
		no = 25,
		class = 1,
		reward_pool_no = 60025,
		widget = 25
};

get(26) ->
	#guild_battle_reward_cfg{
		no = 26,
		class = 1,
		reward_pool_no = 60026,
		widget = 25
};

get(27) ->
	#guild_battle_reward_cfg{
		no = 27,
		class = 1,
		reward_pool_no = 60027,
		widget = 25
};

get(28) ->
	#guild_battle_reward_cfg{
		no = 28,
		class = 1,
		reward_pool_no = 60028,
		widget = 25
};

get(29) ->
	#guild_battle_reward_cfg{
		no = 29,
		class = 1,
		reward_pool_no = 60029,
		widget = 25
};

get(30) ->
	#guild_battle_reward_cfg{
		no = 30,
		class = 1,
		reward_pool_no = 60030,
		widget = 25
};

get(31) ->
	#guild_battle_reward_cfg{
		no = 31,
		class = 1,
		reward_pool_no = 60031,
		widget = 50
};

get(32) ->
	#guild_battle_reward_cfg{
		no = 32,
		class = 1,
		reward_pool_no = 60032,
		widget = 25
};

get(33) ->
	#guild_battle_reward_cfg{
		no = 33,
		class = 1,
		reward_pool_no = 60033,
		widget = 25
};

get(34) ->
	#guild_battle_reward_cfg{
		no = 34,
		class = 1,
		reward_pool_no = 60034,
		widget = 10
};

get(35) ->
	#guild_battle_reward_cfg{
		no = 35,
		class = 1,
		reward_pool_no = 60035,
		widget = 10
};

get(36) ->
	#guild_battle_reward_cfg{
		no = 36,
		class = 1,
		reward_pool_no = 60036,
		widget = 10
};

get(37) ->
	#guild_battle_reward_cfg{
		no = 37,
		class = 1,
		reward_pool_no = 60037,
		widget = 10
};

get(38) ->
	#guild_battle_reward_cfg{
		no = 38,
		class = 1,
		reward_pool_no = 60038,
		widget = 10
};

get(39) ->
	#guild_battle_reward_cfg{
		no = 39,
		class = 1,
		reward_pool_no = 60039,
		widget = 10
};

get(40) ->
	#guild_battle_reward_cfg{
		no = 40,
		class = 1,
		reward_pool_no = 60040,
		widget = 10
};

get(41) ->
	#guild_battle_reward_cfg{
		no = 41,
		class = 2,
		reward_pool_no = 60200,
		widget = 20
};

get(42) ->
	#guild_battle_reward_cfg{
		no = 42,
		class = 2,
		reward_pool_no = 60201,
		widget = 5
};

get(43) ->
	#guild_battle_reward_cfg{
		no = 43,
		class = 2,
		reward_pool_no = 60202,
		widget = 5
};

get(44) ->
	#guild_battle_reward_cfg{
		no = 44,
		class = 2,
		reward_pool_no = 60203,
		widget = 5
};

get(45) ->
	#guild_battle_reward_cfg{
		no = 45,
		class = 2,
		reward_pool_no = 60204,
		widget = 5
};

get(46) ->
	#guild_battle_reward_cfg{
		no = 46,
		class = 2,
		reward_pool_no = 60205,
		widget = 5
};

get(47) ->
	#guild_battle_reward_cfg{
		no = 47,
		class = 2,
		reward_pool_no = 60206,
		widget = 20
};

get(48) ->
	#guild_battle_reward_cfg{
		no = 48,
		class = 2,
		reward_pool_no = 60207,
		widget = 10
};

get(49) ->
	#guild_battle_reward_cfg{
		no = 49,
		class = 2,
		reward_pool_no = 60208,
		widget = 5
};

get(50) ->
	#guild_battle_reward_cfg{
		no = 50,
		class = 2,
		reward_pool_no = 60209,
		widget = 5
};

get(51) ->
	#guild_battle_reward_cfg{
		no = 51,
		class = 2,
		reward_pool_no = 60210,
		widget = 2
};

get(52) ->
	#guild_battle_reward_cfg{
		no = 52,
		class = 2,
		reward_pool_no = 60211,
		widget = 2
};

get(53) ->
	#guild_battle_reward_cfg{
		no = 53,
		class = 2,
		reward_pool_no = 60212,
		widget = 15
};

get(54) ->
	#guild_battle_reward_cfg{
		no = 54,
		class = 2,
		reward_pool_no = 60213,
		widget = 10
};

get(55) ->
	#guild_battle_reward_cfg{
		no = 55,
		class = 2,
		reward_pool_no = 60214,
		widget = 7
};

get(56) ->
	#guild_battle_reward_cfg{
		no = 56,
		class = 2,
		reward_pool_no = 60215,
		widget = 5
};

get(57) ->
	#guild_battle_reward_cfg{
		no = 57,
		class = 2,
		reward_pool_no = 60216,
		widget = 5
};

get(58) ->
	#guild_battle_reward_cfg{
		no = 58,
		class = 2,
		reward_pool_no = 60217,
		widget = 10
};

get(59) ->
	#guild_battle_reward_cfg{
		no = 59,
		class = 2,
		reward_pool_no = 60218,
		widget = 10
};

get(60) ->
	#guild_battle_reward_cfg{
		no = 60,
		class = 2,
		reward_pool_no = 60219,
		widget = 10
};

get(61) ->
	#guild_battle_reward_cfg{
		no = 61,
		class = 2,
		reward_pool_no = 60220,
		widget = 10
};

get(62) ->
	#guild_battle_reward_cfg{
		no = 62,
		class = 2,
		reward_pool_no = 60221,
		widget = 10
};

get(63) ->
	#guild_battle_reward_cfg{
		no = 63,
		class = 2,
		reward_pool_no = 60222,
		widget = 10
};

get(64) ->
	#guild_battle_reward_cfg{
		no = 64,
		class = 2,
		reward_pool_no = 60223,
		widget = 10
};

get(65) ->
	#guild_battle_reward_cfg{
		no = 65,
		class = 2,
		reward_pool_no = 60224,
		widget = 10
};

get(66) ->
	#guild_battle_reward_cfg{
		no = 66,
		class = 2,
		reward_pool_no = 60225,
		widget = 10
};

get(67) ->
	#guild_battle_reward_cfg{
		no = 67,
		class = 2,
		reward_pool_no = 60226,
		widget = 10
};

get(68) ->
	#guild_battle_reward_cfg{
		no = 68,
		class = 2,
		reward_pool_no = 60227,
		widget = 50
};

get(69) ->
	#guild_battle_reward_cfg{
		no = 69,
		class = 2,
		reward_pool_no = 60228,
		widget = 10
};

get(70) ->
	#guild_battle_reward_cfg{
		no = 70,
		class = 2,
		reward_pool_no = 60229,
		widget = 5
};

get(71) ->
	#guild_battle_reward_cfg{
		no = 71,
		class = 2,
		reward_pool_no = 60230,
		widget = 25
};

get(72) ->
	#guild_battle_reward_cfg{
		no = 72,
		class = 2,
		reward_pool_no = 60231,
		widget = 5
};

get(73) ->
	#guild_battle_reward_cfg{
		no = 73,
		class = 2,
		reward_pool_no = 60232,
		widget = 5
};

get(74) ->
	#guild_battle_reward_cfg{
		no = 74,
		class = 2,
		reward_pool_no = 60233,
		widget = 5
};

get(75) ->
	#guild_battle_reward_cfg{
		no = 75,
		class = 2,
		reward_pool_no = 60234,
		widget = 5
};

get(76) ->
	#guild_battle_reward_cfg{
		no = 76,
		class = 2,
		reward_pool_no = 60235,
		widget = 5
};

get(77) ->
	#guild_battle_reward_cfg{
		no = 77,
		class = 2,
		reward_pool_no = 60236,
		widget = 5
};

get(78) ->
	#guild_battle_reward_cfg{
		no = 78,
		class = 2,
		reward_pool_no = 60237,
		widget = 5
};

get(79) ->
	#guild_battle_reward_cfg{
		no = 79,
		class = 2,
		reward_pool_no = 60238,
		widget = 5
};

get(80) ->
	#guild_battle_reward_cfg{
		no = 80,
		class = 2,
		reward_pool_no = 60239,
		widget = 5
};

get(81) ->
	#guild_battle_reward_cfg{
		no = 81,
		class = 2,
		reward_pool_no = 60240,
		widget = 5
};

get(82) ->
	#guild_battle_reward_cfg{
		no = 82,
		class = 2,
		reward_pool_no = 60241,
		widget = 5
};

get(83) ->
	#guild_battle_reward_cfg{
		no = 83,
		class = 2,
		reward_pool_no = 60242,
		widget = 5
};

get(84) ->
	#guild_battle_reward_cfg{
		no = 84,
		class = 2,
		reward_pool_no = 60243,
		widget = 5
};

get(85) ->
	#guild_battle_reward_cfg{
		no = 85,
		class = 2,
		reward_pool_no = 60244,
		widget = 5
};

get(86) ->
	#guild_battle_reward_cfg{
		no = 86,
		class = 2,
		reward_pool_no = 60245,
		widget = 5
};

get(87) ->
	#guild_battle_reward_cfg{
		no = 87,
		class = 2,
		reward_pool_no = 60246,
		widget = 20
};

get(88) ->
	#guild_battle_reward_cfg{
		no = 88,
		class = 2,
		reward_pool_no = 60247,
		widget = 25
};

get(89) ->
	#guild_battle_reward_cfg{
		no = 89,
		class = 2,
		reward_pool_no = 60248,
		widget = 25
};

get(90) ->
	#guild_battle_reward_cfg{
		no = 90,
		class = 3,
		reward_pool_no = 60400,
		widget = 7
};

get(91) ->
	#guild_battle_reward_cfg{
		no = 91,
		class = 3,
		reward_pool_no = 60401,
		widget = 5
};

get(92) ->
	#guild_battle_reward_cfg{
		no = 92,
		class = 3,
		reward_pool_no = 60402,
		widget = 5
};

get(93) ->
	#guild_battle_reward_cfg{
		no = 93,
		class = 3,
		reward_pool_no = 60403,
		widget = 5
};

get(94) ->
	#guild_battle_reward_cfg{
		no = 94,
		class = 3,
		reward_pool_no = 60404,
		widget = 25
};

get(95) ->
	#guild_battle_reward_cfg{
		no = 95,
		class = 3,
		reward_pool_no = 60405,
		widget = 5
};

get(96) ->
	#guild_battle_reward_cfg{
		no = 96,
		class = 3,
		reward_pool_no = 60406,
		widget = 5
};

get(97) ->
	#guild_battle_reward_cfg{
		no = 97,
		class = 3,
		reward_pool_no = 60407,
		widget = 5
};

get(98) ->
	#guild_battle_reward_cfg{
		no = 98,
		class = 3,
		reward_pool_no = 60408,
		widget = 5
};

get(99) ->
	#guild_battle_reward_cfg{
		no = 99,
		class = 3,
		reward_pool_no = 60409,
		widget = 5
};

get(100) ->
	#guild_battle_reward_cfg{
		no = 100,
		class = 3,
		reward_pool_no = 60410,
		widget = 5
};

get(101) ->
	#guild_battle_reward_cfg{
		no = 101,
		class = 3,
		reward_pool_no = 60411,
		widget = 5
};

get(102) ->
	#guild_battle_reward_cfg{
		no = 102,
		class = 3,
		reward_pool_no = 60412,
		widget = 5
};

get(103) ->
	#guild_battle_reward_cfg{
		no = 103,
		class = 3,
		reward_pool_no = 60413,
		widget = 5
};

get(104) ->
	#guild_battle_reward_cfg{
		no = 104,
		class = 3,
		reward_pool_no = 60414,
		widget = 5
};

get(105) ->
	#guild_battle_reward_cfg{
		no = 105,
		class = 3,
		reward_pool_no = 60415,
		widget = 5
};

get(106) ->
	#guild_battle_reward_cfg{
		no = 106,
		class = 3,
		reward_pool_no = 60416,
		widget = 5
};

get(107) ->
	#guild_battle_reward_cfg{
		no = 107,
		class = 3,
		reward_pool_no = 60417,
		widget = 5
};

get(108) ->
	#guild_battle_reward_cfg{
		no = 108,
		class = 3,
		reward_pool_no = 60418,
		widget = 5
};

get(109) ->
	#guild_battle_reward_cfg{
		no = 109,
		class = 3,
		reward_pool_no = 60419,
		widget = 5
};

get(110) ->
	#guild_battle_reward_cfg{
		no = 110,
		class = 3,
		reward_pool_no = 60420,
		widget = 5
};

get(111) ->
	#guild_battle_reward_cfg{
		no = 111,
		class = 3,
		reward_pool_no = 60421,
		widget = 5
};

get(112) ->
	#guild_battle_reward_cfg{
		no = 112,
		class = 3,
		reward_pool_no = 60422,
		widget = 5
};

get(113) ->
	#guild_battle_reward_cfg{
		no = 113,
		class = 3,
		reward_pool_no = 60423,
		widget = 5
};

get(114) ->
	#guild_battle_reward_cfg{
		no = 114,
		class = 3,
		reward_pool_no = 60424,
		widget = 20
};

get(No) ->
    null.

