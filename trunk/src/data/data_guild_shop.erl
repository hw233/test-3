%%%---------------------------------------
%%% @Module  : data_guild_shop
%%% @Author  : 段世和/段绍冰
%%% @Email   :
%%% @Description: 帮派系统配置
%%%---------------------------------------


-module(data_guild_shop).
-export([get_ids/0, get/1]).
-include("business.hrl").
-include("debug.hrl").

get_ids()->
	[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135].

get(1) ->
	#data_guild_shop{
		id = 1,
		shop_no = 1,
		goods_no = 20013,
		count_limit = 200,
		price = [{3,100}],
		weight = 1000,
		guide_lv_limit = 1
};

get(2) ->
	#data_guild_shop{
		id = 2,
		shop_no = 1,
		goods_no = 20022,
		count_limit = 50,
		price = [{3,400}],
		weight = 1000,
		guide_lv_limit = 1
};

get(3) ->
	#data_guild_shop{
		id = 3,
		shop_no = 1,
		goods_no = 20023,
		count_limit = 50,
		price = [{3,400}],
		weight = 1000,
		guide_lv_limit = 1
};

get(4) ->
	#data_guild_shop{
		id = 4,
		shop_no = 1,
		goods_no = 20003,
		count_limit = 50,
		price = [{3,400}],
		weight = 1000,
		guide_lv_limit = 1
};

get(5) ->
	#data_guild_shop{
		id = 5,
		shop_no = 1,
		goods_no = 20011,
		count_limit = 50,
		price = [{3,400}],
		weight = 1000,
		guide_lv_limit = 1
};

get(6) ->
	#data_guild_shop{
		id = 6,
		shop_no = 1,
		goods_no = 20007,
		count_limit = 50,
		price = [{3,400}],
		weight = 1000,
		guide_lv_limit = 1
};

get(7) ->
	#data_guild_shop{
		id = 7,
		shop_no = 1,
		goods_no = 20017,
		count_limit = 50,
		price = [{3,400}],
		weight = 1000,
		guide_lv_limit = 1
};

get(8) ->
	#data_guild_shop{
		id = 8,
		shop_no = 1,
		goods_no = 20024,
		count_limit = 50,
		price = [{3,300}],
		weight = 500,
		guide_lv_limit = 1
};

get(9) ->
	#data_guild_shop{
		id = 9,
		shop_no = 1,
		goods_no = 20025,
		count_limit = 20,
		price = [{3,900}],
		weight = 500,
		guide_lv_limit = 1
};

get(10) ->
	#data_guild_shop{
		id = 10,
		shop_no = 1,
		goods_no = 20026,
		count_limit = 10,
		price = [{3,2400}],
		weight = 500,
		guide_lv_limit = 1
};

get(11) ->
	#data_guild_shop{
		id = 11,
		shop_no = 2,
		goods_no = 60063,
		count_limit = 500,
		price = [{3,60}],
		weight = 1000,
		guide_lv_limit = 1
};

get(12) ->
	#data_guild_shop{
		id = 12,
		shop_no = 2,
		goods_no = 60039,
		count_limit = 100,
		price = [{3,310}],
		weight = 1000,
		guide_lv_limit = 1
};

get(13) ->
	#data_guild_shop{
		id = 13,
		shop_no = 2,
		goods_no = 60040,
		count_limit = 20,
		price = [{3,1570}],
		weight = 1000,
		guide_lv_limit = 1
};

get(14) ->
	#data_guild_shop{
		id = 14,
		shop_no = 2,
		goods_no = 50038,
		count_limit = 500,
		price = [{3,70}],
		weight = 1000,
		guide_lv_limit = 1
};

get(15) ->
	#data_guild_shop{
		id = 15,
		shop_no = 2,
		goods_no = 50307,
		count_limit = 100,
		price = [{3,200}],
		weight = 1000,
		guide_lv_limit = 1
};

get(16) ->
	#data_guild_shop{
		id = 16,
		shop_no = 2,
		goods_no = 50368,
		count_limit = 1000,
		price = [{3,20}],
		weight = 1000,
		guide_lv_limit = 1
};

get(17) ->
	#data_guild_shop{
		id = 17,
		shop_no = 2,
		goods_no = 62041,
		count_limit = 5,
		price = [{3,6000}],
		weight = 1000,
		guide_lv_limit = 1
};

get(18) ->
	#data_guild_shop{
		id = 18,
		shop_no = 2,
		goods_no = 62042,
		count_limit = 1,
		price = [{3,45000}],
		weight = 1000,
		guide_lv_limit = 1
};

get(19) ->
	#data_guild_shop{
		id = 19,
		shop_no = 2,
		goods_no = 55113,
		count_limit = 1,
		price = [{3,40000}],
		weight = 300,
		guide_lv_limit = 1
};

get(20) ->
	#data_guild_shop{
		id = 20,
		shop_no = 2,
		goods_no = 55111,
		count_limit = 1,
		price = [{3,40000}],
		weight = 300,
		guide_lv_limit = 1
};

get(21) ->
	#data_guild_shop{
		id = 21,
		shop_no = 2,
		goods_no = 55112,
		count_limit = 1,
		price = [{3,40000}],
		weight = 300,
		guide_lv_limit = 1
};

get(22) ->
	#data_guild_shop{
		id = 22,
		shop_no = 2,
		goods_no = 55109,
		count_limit = 1,
		price = [{3,40000}],
		weight = 300,
		guide_lv_limit = 1
};

get(23) ->
	#data_guild_shop{
		id = 23,
		shop_no = 2,
		goods_no = 55110,
		count_limit = 1,
		price = [{3,40000}],
		weight = 300,
		guide_lv_limit = 1
};

get(24) ->
	#data_guild_shop{
		id = 24,
		shop_no = 3,
		goods_no = 70011,
		count_limit = 50,
		price = [{3,880}],
		weight = 1000,
		guide_lv_limit = 1
};

get(25) ->
	#data_guild_shop{
		id = 25,
		shop_no = 3,
		goods_no = 72403,
		count_limit = 300,
		price = [{3,100}],
		weight = 1000,
		guide_lv_limit = 1
};

get(26) ->
	#data_guild_shop{
		id = 26,
		shop_no = 3,
		goods_no = 72402,
		count_limit = 100,
		price = [{3,200}],
		weight = 1000,
		guide_lv_limit = 1
};

get(27) ->
	#data_guild_shop{
		id = 27,
		shop_no = 3,
		goods_no = 62025,
		count_limit = 2,
		price = [{3,12000}],
		weight = 1000,
		guide_lv_limit = 1
};

get(28) ->
	#data_guild_shop{
		id = 28,
		shop_no = 3,
		goods_no = 72401,
		count_limit = 20,
		price = [{3,1720}],
		weight = 1000,
		guide_lv_limit = 1
};

get(29) ->
	#data_guild_shop{
		id = 29,
		shop_no = 3,
		goods_no = 72405,
		count_limit = 30,
		price = [{3,1000}],
		weight = 500,
		guide_lv_limit = 1
};

get(30) ->
	#data_guild_shop{
		id = 30,
		shop_no = 3,
		goods_no = 72404,
		count_limit = 5,
		price = [{3,6000}],
		weight = 500,
		guide_lv_limit = 1
};

get(31) ->
	#data_guild_shop{
		id = 31,
		shop_no = 4,
		goods_no = 62028,
		count_limit = 1,
		price = [{3,96000}],
		weight = 200,
		guide_lv_limit = 5
};

get(32) ->
	#data_guild_shop{
		id = 32,
		shop_no = 4,
		goods_no = 20013,
		count_limit = 200,
		price = [{3,100}],
		weight = 1000,
		guide_lv_limit = 5
};

get(33) ->
	#data_guild_shop{
		id = 33,
		shop_no = 4,
		goods_no = 20022,
		count_limit = 50,
		price = [{3,400}],
		weight = 1000,
		guide_lv_limit = 5
};

get(34) ->
	#data_guild_shop{
		id = 34,
		shop_no = 4,
		goods_no = 20023,
		count_limit = 50,
		price = [{3,400}],
		weight = 1000,
		guide_lv_limit = 5
};

get(35) ->
	#data_guild_shop{
		id = 35,
		shop_no = 4,
		goods_no = 20003,
		count_limit = 50,
		price = [{3,400}],
		weight = 1000,
		guide_lv_limit = 5
};

get(36) ->
	#data_guild_shop{
		id = 36,
		shop_no = 4,
		goods_no = 20011,
		count_limit = 50,
		price = [{3,400}],
		weight = 1000,
		guide_lv_limit = 5
};

get(37) ->
	#data_guild_shop{
		id = 37,
		shop_no = 4,
		goods_no = 20007,
		count_limit = 50,
		price = [{3,400}],
		weight = 1000,
		guide_lv_limit = 5
};

get(38) ->
	#data_guild_shop{
		id = 38,
		shop_no = 4,
		goods_no = 20017,
		count_limit = 50,
		price = [{3,400}],
		weight = 1000,
		guide_lv_limit = 5
};

get(39) ->
	#data_guild_shop{
		id = 39,
		shop_no = 4,
		goods_no = 20024,
		count_limit = 50,
		price = [{3,300}],
		weight = 500,
		guide_lv_limit = 5
};

get(40) ->
	#data_guild_shop{
		id = 40,
		shop_no = 4,
		goods_no = 20025,
		count_limit = 20,
		price = [{3,900}],
		weight = 500,
		guide_lv_limit = 5
};

get(41) ->
	#data_guild_shop{
		id = 41,
		shop_no = 4,
		goods_no = 20026,
		count_limit = 10,
		price = [{3,2400}],
		weight = 500,
		guide_lv_limit = 5
};

get(42) ->
	#data_guild_shop{
		id = 42,
		shop_no = 4,
		goods_no = 60063,
		count_limit = 500,
		price = [{3,60}],
		weight = 1000,
		guide_lv_limit = 5
};

get(43) ->
	#data_guild_shop{
		id = 43,
		shop_no = 4,
		goods_no = 60039,
		count_limit = 100,
		price = [{3,310}],
		weight = 1000,
		guide_lv_limit = 5
};

get(44) ->
	#data_guild_shop{
		id = 44,
		shop_no = 4,
		goods_no = 60040,
		count_limit = 20,
		price = [{3,1570}],
		weight = 1000,
		guide_lv_limit = 5
};

get(45) ->
	#data_guild_shop{
		id = 45,
		shop_no = 4,
		goods_no = 50038,
		count_limit = 500,
		price = [{3,70}],
		weight = 1000,
		guide_lv_limit = 5
};

get(46) ->
	#data_guild_shop{
		id = 46,
		shop_no = 4,
		goods_no = 50307,
		count_limit = 100,
		price = [{3,200}],
		weight = 1000,
		guide_lv_limit = 5
};

get(47) ->
	#data_guild_shop{
		id = 47,
		shop_no = 4,
		goods_no = 50368,
		count_limit = 1000,
		price = [{3,20}],
		weight = 1000,
		guide_lv_limit = 5
};

get(48) ->
	#data_guild_shop{
		id = 48,
		shop_no = 4,
		goods_no = 62041,
		count_limit = 5,
		price = [{3,6000}],
		weight = 1000,
		guide_lv_limit = 5
};

get(49) ->
	#data_guild_shop{
		id = 49,
		shop_no = 4,
		goods_no = 62042,
		count_limit = 1,
		price = [{3,45000}],
		weight = 1000,
		guide_lv_limit = 5
};

get(50) ->
	#data_guild_shop{
		id = 50,
		shop_no = 4,
		goods_no = 55113,
		count_limit = 1,
		price = [{3,40000}],
		weight = 300,
		guide_lv_limit = 5
};

get(51) ->
	#data_guild_shop{
		id = 51,
		shop_no = 4,
		goods_no = 55111,
		count_limit = 1,
		price = [{3,40000}],
		weight = 300,
		guide_lv_limit = 5
};

get(52) ->
	#data_guild_shop{
		id = 52,
		shop_no = 4,
		goods_no = 55112,
		count_limit = 1,
		price = [{3,40000}],
		weight = 300,
		guide_lv_limit = 5
};

get(53) ->
	#data_guild_shop{
		id = 53,
		shop_no = 4,
		goods_no = 55109,
		count_limit = 1,
		price = [{3,40000}],
		weight = 300,
		guide_lv_limit = 5
};

get(54) ->
	#data_guild_shop{
		id = 54,
		shop_no = 4,
		goods_no = 55110,
		count_limit = 1,
		price = [{3,40000}],
		weight = 300,
		guide_lv_limit = 5
};

get(55) ->
	#data_guild_shop{
		id = 55,
		shop_no = 4,
		goods_no = 70011,
		count_limit = 50,
		price = [{3,880}],
		weight = 1000,
		guide_lv_limit = 5
};

get(56) ->
	#data_guild_shop{
		id = 56,
		shop_no = 4,
		goods_no = 72403,
		count_limit = 300,
		price = [{3,100}],
		weight = 1000,
		guide_lv_limit = 5
};

get(57) ->
	#data_guild_shop{
		id = 57,
		shop_no = 4,
		goods_no = 72402,
		count_limit = 100,
		price = [{3,200}],
		weight = 1000,
		guide_lv_limit = 5
};

get(58) ->
	#data_guild_shop{
		id = 58,
		shop_no = 4,
		goods_no = 62025,
		count_limit = 2,
		price = [{3,12000}],
		weight = 1000,
		guide_lv_limit = 5
};

get(59) ->
	#data_guild_shop{
		id = 59,
		shop_no = 4,
		goods_no = 72401,
		count_limit = 20,
		price = [{3,1720}],
		weight = 1000,
		guide_lv_limit = 5
};

get(60) ->
	#data_guild_shop{
		id = 60,
		shop_no = 4,
		goods_no = 72405,
		count_limit = 30,
		price = [{3,1000}],
		weight = 500,
		guide_lv_limit = 5
};

get(61) ->
	#data_guild_shop{
		id = 61,
		shop_no = 4,
		goods_no = 72404,
		count_limit = 5,
		price = [{3,6000}],
		weight = 500,
		guide_lv_limit = 5
};

get(62) ->
	#data_guild_shop{
		id = 62,
		shop_no = 5,
		goods_no = 62028,
		count_limit = 1,
		price = [{3,96000}],
		weight = 200,
		guide_lv_limit = 7
};

get(63) ->
	#data_guild_shop{
		id = 63,
		shop_no = 5,
		goods_no = 20013,
		count_limit = 200,
		price = [{3,100}],
		weight = 1000,
		guide_lv_limit = 7
};

get(64) ->
	#data_guild_shop{
		id = 64,
		shop_no = 5,
		goods_no = 20022,
		count_limit = 50,
		price = [{3,400}],
		weight = 1000,
		guide_lv_limit = 7
};

get(65) ->
	#data_guild_shop{
		id = 65,
		shop_no = 5,
		goods_no = 20023,
		count_limit = 50,
		price = [{3,400}],
		weight = 1000,
		guide_lv_limit = 7
};

get(66) ->
	#data_guild_shop{
		id = 66,
		shop_no = 5,
		goods_no = 20003,
		count_limit = 50,
		price = [{3,400}],
		weight = 1000,
		guide_lv_limit = 7
};

get(67) ->
	#data_guild_shop{
		id = 67,
		shop_no = 5,
		goods_no = 20011,
		count_limit = 50,
		price = [{3,400}],
		weight = 1000,
		guide_lv_limit = 7
};

get(68) ->
	#data_guild_shop{
		id = 68,
		shop_no = 5,
		goods_no = 20007,
		count_limit = 50,
		price = [{3,400}],
		weight = 1000,
		guide_lv_limit = 7
};

get(69) ->
	#data_guild_shop{
		id = 69,
		shop_no = 5,
		goods_no = 20017,
		count_limit = 50,
		price = [{3,400}],
		weight = 1000,
		guide_lv_limit = 7
};

get(70) ->
	#data_guild_shop{
		id = 70,
		shop_no = 5,
		goods_no = 20024,
		count_limit = 50,
		price = [{3,300}],
		weight = 500,
		guide_lv_limit = 7
};

get(71) ->
	#data_guild_shop{
		id = 71,
		shop_no = 5,
		goods_no = 20025,
		count_limit = 20,
		price = [{3,900}],
		weight = 500,
		guide_lv_limit = 7
};

get(72) ->
	#data_guild_shop{
		id = 72,
		shop_no = 5,
		goods_no = 20026,
		count_limit = 10,
		price = [{3,2400}],
		weight = 500,
		guide_lv_limit = 7
};

get(73) ->
	#data_guild_shop{
		id = 73,
		shop_no = 5,
		goods_no = 60063,
		count_limit = 500,
		price = [{3,60}],
		weight = 1000,
		guide_lv_limit = 7
};

get(74) ->
	#data_guild_shop{
		id = 74,
		shop_no = 5,
		goods_no = 60039,
		count_limit = 100,
		price = [{3,310}],
		weight = 1000,
		guide_lv_limit = 7
};

get(75) ->
	#data_guild_shop{
		id = 75,
		shop_no = 5,
		goods_no = 60040,
		count_limit = 20,
		price = [{3,1570}],
		weight = 1000,
		guide_lv_limit = 7
};

get(76) ->
	#data_guild_shop{
		id = 76,
		shop_no = 5,
		goods_no = 50038,
		count_limit = 500,
		price = [{3,70}],
		weight = 1000,
		guide_lv_limit = 7
};

get(77) ->
	#data_guild_shop{
		id = 77,
		shop_no = 5,
		goods_no = 50307,
		count_limit = 100,
		price = [{3,200}],
		weight = 1000,
		guide_lv_limit = 7
};

get(78) ->
	#data_guild_shop{
		id = 78,
		shop_no = 5,
		goods_no = 50368,
		count_limit = 1000,
		price = [{3,20}],
		weight = 1000,
		guide_lv_limit = 7
};

get(79) ->
	#data_guild_shop{
		id = 79,
		shop_no = 5,
		goods_no = 62041,
		count_limit = 5,
		price = [{3,6000}],
		weight = 1000,
		guide_lv_limit = 7
};

get(80) ->
	#data_guild_shop{
		id = 80,
		shop_no = 5,
		goods_no = 62042,
		count_limit = 1,
		price = [{3,45000}],
		weight = 1000,
		guide_lv_limit = 7
};

get(81) ->
	#data_guild_shop{
		id = 81,
		shop_no = 5,
		goods_no = 55113,
		count_limit = 1,
		price = [{3,40000}],
		weight = 300,
		guide_lv_limit = 7
};

get(82) ->
	#data_guild_shop{
		id = 82,
		shop_no = 5,
		goods_no = 55111,
		count_limit = 1,
		price = [{3,40000}],
		weight = 300,
		guide_lv_limit = 7
};

get(83) ->
	#data_guild_shop{
		id = 83,
		shop_no = 5,
		goods_no = 55112,
		count_limit = 1,
		price = [{3,40000}],
		weight = 300,
		guide_lv_limit = 7
};

get(84) ->
	#data_guild_shop{
		id = 84,
		shop_no = 5,
		goods_no = 55109,
		count_limit = 1,
		price = [{3,40000}],
		weight = 300,
		guide_lv_limit = 7
};

get(85) ->
	#data_guild_shop{
		id = 85,
		shop_no = 5,
		goods_no = 55110,
		count_limit = 1,
		price = [{3,40000}],
		weight = 300,
		guide_lv_limit = 7
};

get(86) ->
	#data_guild_shop{
		id = 86,
		shop_no = 5,
		goods_no = 70011,
		count_limit = 50,
		price = [{3,880}],
		weight = 1000,
		guide_lv_limit = 7
};

get(87) ->
	#data_guild_shop{
		id = 87,
		shop_no = 5,
		goods_no = 72403,
		count_limit = 300,
		price = [{3,100}],
		weight = 1000,
		guide_lv_limit = 7
};

get(88) ->
	#data_guild_shop{
		id = 88,
		shop_no = 5,
		goods_no = 72402,
		count_limit = 100,
		price = [{3,200}],
		weight = 1000,
		guide_lv_limit = 7
};

get(89) ->
	#data_guild_shop{
		id = 89,
		shop_no = 5,
		goods_no = 62025,
		count_limit = 2,
		price = [{3,12000}],
		weight = 1000,
		guide_lv_limit = 7
};

get(90) ->
	#data_guild_shop{
		id = 90,
		shop_no = 5,
		goods_no = 72401,
		count_limit = 20,
		price = [{3,1720}],
		weight = 1000,
		guide_lv_limit = 7
};

get(91) ->
	#data_guild_shop{
		id = 91,
		shop_no = 5,
		goods_no = 72405,
		count_limit = 30,
		price = [{3,1000}],
		weight = 500,
		guide_lv_limit = 7
};

get(92) ->
	#data_guild_shop{
		id = 92,
		shop_no = 5,
		goods_no = 72404,
		count_limit = 5,
		price = [{3,6000}],
		weight = 500,
		guide_lv_limit = 7
};

get(93) ->
	#data_guild_shop{
		id = 93,
		shop_no = 6,
		goods_no = 62028,
		count_limit = 1,
		price = [{3,96000}],
		weight = 200,
		guide_lv_limit = 9
};

get(94) ->
	#data_guild_shop{
		id = 94,
		shop_no = 6,
		goods_no = 20013,
		count_limit = 200,
		price = [{3,100}],
		weight = 1000,
		guide_lv_limit = 9
};

get(95) ->
	#data_guild_shop{
		id = 95,
		shop_no = 6,
		goods_no = 20022,
		count_limit = 50,
		price = [{3,400}],
		weight = 1000,
		guide_lv_limit = 9
};

get(96) ->
	#data_guild_shop{
		id = 96,
		shop_no = 6,
		goods_no = 20023,
		count_limit = 50,
		price = [{3,400}],
		weight = 1000,
		guide_lv_limit = 9
};

get(97) ->
	#data_guild_shop{
		id = 97,
		shop_no = 6,
		goods_no = 20003,
		count_limit = 50,
		price = [{3,400}],
		weight = 1000,
		guide_lv_limit = 9
};

get(98) ->
	#data_guild_shop{
		id = 98,
		shop_no = 6,
		goods_no = 20011,
		count_limit = 50,
		price = [{3,400}],
		weight = 1000,
		guide_lv_limit = 9
};

get(99) ->
	#data_guild_shop{
		id = 99,
		shop_no = 6,
		goods_no = 20007,
		count_limit = 50,
		price = [{3,400}],
		weight = 1000,
		guide_lv_limit = 9
};

get(100) ->
	#data_guild_shop{
		id = 100,
		shop_no = 6,
		goods_no = 20017,
		count_limit = 50,
		price = [{3,400}],
		weight = 1000,
		guide_lv_limit = 9
};

get(101) ->
	#data_guild_shop{
		id = 101,
		shop_no = 6,
		goods_no = 20024,
		count_limit = 50,
		price = [{3,300}],
		weight = 500,
		guide_lv_limit = 9
};

get(102) ->
	#data_guild_shop{
		id = 102,
		shop_no = 6,
		goods_no = 20025,
		count_limit = 20,
		price = [{3,900}],
		weight = 500,
		guide_lv_limit = 9
};

get(103) ->
	#data_guild_shop{
		id = 103,
		shop_no = 6,
		goods_no = 20026,
		count_limit = 10,
		price = [{3,2400}],
		weight = 500,
		guide_lv_limit = 9
};

get(104) ->
	#data_guild_shop{
		id = 104,
		shop_no = 6,
		goods_no = 60063,
		count_limit = 500,
		price = [{3,60}],
		weight = 1000,
		guide_lv_limit = 9
};

get(105) ->
	#data_guild_shop{
		id = 105,
		shop_no = 6,
		goods_no = 60039,
		count_limit = 100,
		price = [{3,310}],
		weight = 1000,
		guide_lv_limit = 9
};

get(106) ->
	#data_guild_shop{
		id = 106,
		shop_no = 6,
		goods_no = 60040,
		count_limit = 20,
		price = [{3,1570}],
		weight = 1000,
		guide_lv_limit = 9
};

get(107) ->
	#data_guild_shop{
		id = 107,
		shop_no = 6,
		goods_no = 50038,
		count_limit = 500,
		price = [{3,70}],
		weight = 1000,
		guide_lv_limit = 9
};

get(108) ->
	#data_guild_shop{
		id = 108,
		shop_no = 6,
		goods_no = 50307,
		count_limit = 100,
		price = [{3,200}],
		weight = 1000,
		guide_lv_limit = 9
};

get(109) ->
	#data_guild_shop{
		id = 109,
		shop_no = 6,
		goods_no = 50368,
		count_limit = 1000,
		price = [{3,20}],
		weight = 1000,
		guide_lv_limit = 9
};

get(110) ->
	#data_guild_shop{
		id = 110,
		shop_no = 6,
		goods_no = 62041,
		count_limit = 5,
		price = [{3,6000}],
		weight = 1000,
		guide_lv_limit = 9
};

get(111) ->
	#data_guild_shop{
		id = 111,
		shop_no = 6,
		goods_no = 62042,
		count_limit = 1,
		price = [{3,45000}],
		weight = 1000,
		guide_lv_limit = 9
};

get(112) ->
	#data_guild_shop{
		id = 112,
		shop_no = 6,
		goods_no = 55113,
		count_limit = 1,
		price = [{3,40000}],
		weight = 300,
		guide_lv_limit = 9
};

get(113) ->
	#data_guild_shop{
		id = 113,
		shop_no = 6,
		goods_no = 55111,
		count_limit = 1,
		price = [{3,40000}],
		weight = 300,
		guide_lv_limit = 9
};

get(114) ->
	#data_guild_shop{
		id = 114,
		shop_no = 6,
		goods_no = 55112,
		count_limit = 1,
		price = [{3,40000}],
		weight = 300,
		guide_lv_limit = 9
};

get(115) ->
	#data_guild_shop{
		id = 115,
		shop_no = 6,
		goods_no = 55109,
		count_limit = 1,
		price = [{3,40000}],
		weight = 300,
		guide_lv_limit = 9
};

get(116) ->
	#data_guild_shop{
		id = 116,
		shop_no = 6,
		goods_no = 55110,
		count_limit = 1,
		price = [{3,40000}],
		weight = 300,
		guide_lv_limit = 9
};

get(117) ->
	#data_guild_shop{
		id = 117,
		shop_no = 6,
		goods_no = 70011,
		count_limit = 50,
		price = [{3,880}],
		weight = 1000,
		guide_lv_limit = 9
};

get(118) ->
	#data_guild_shop{
		id = 118,
		shop_no = 6,
		goods_no = 72403,
		count_limit = 300,
		price = [{3,100}],
		weight = 1000,
		guide_lv_limit = 9
};

get(119) ->
	#data_guild_shop{
		id = 119,
		shop_no = 6,
		goods_no = 72402,
		count_limit = 100,
		price = [{3,200}],
		weight = 1000,
		guide_lv_limit = 9
};

get(120) ->
	#data_guild_shop{
		id = 120,
		shop_no = 6,
		goods_no = 62025,
		count_limit = 2,
		price = [{3,12000}],
		weight = 1000,
		guide_lv_limit = 9
};

get(121) ->
	#data_guild_shop{
		id = 121,
		shop_no = 6,
		goods_no = 72401,
		count_limit = 20,
		price = [{3,1720}],
		weight = 1000,
		guide_lv_limit = 9
};

get(122) ->
	#data_guild_shop{
		id = 122,
		shop_no = 6,
		goods_no = 72405,
		count_limit = 30,
		price = [{3,1000}],
		weight = 500,
		guide_lv_limit = 9
};

get(123) ->
	#data_guild_shop{
		id = 123,
		shop_no = 6,
		goods_no = 72404,
		count_limit = 5,
		price = [{3,6000}],
		weight = 500,
		guide_lv_limit = 9
};

get(124) ->
	#data_guild_shop{
		id = 124,
		shop_no = 7,
		goods_no = 50370,
		count_limit = 200,
		price = [{3,240}],
		weight = 1000,
		guide_lv_limit = 11
};

get(125) ->
	#data_guild_shop{
		id = 125,
		shop_no = 7,
		goods_no = 50371,
		count_limit = 50,
		price = [{3,1210}],
		weight = 500,
		guide_lv_limit = 11
};

get(126) ->
	#data_guild_shop{
		id = 126,
		shop_no = 7,
		goods_no = 50369,
		count_limit = 1000,
		price = [{3,20}],
		weight = 1000,
		guide_lv_limit = 11
};

get(127) ->
	#data_guild_shop{
		id = 127,
		shop_no = 7,
		goods_no = 50373,
		count_limit = 100,
		price = [{3,200}],
		weight = 1000,
		guide_lv_limit = 11
};

get(128) ->
	#data_guild_shop{
		id = 128,
		shop_no = 7,
		goods_no = 50375,
		count_limit = 300,
		price = [{3,100}],
		weight = 1000,
		guide_lv_limit = 11
};

get(129) ->
	#data_guild_shop{
		id = 129,
		shop_no = 7,
		goods_no = 50374,
		count_limit = 20,
		price = [{3,1000}],
		weight = 1000,
		guide_lv_limit = 11
};

get(130) ->
	#data_guild_shop{
		id = 130,
		shop_no = 8,
		goods_no = 50370,
		count_limit = 200,
		price = [{3,240}],
		weight = 1000,
		guide_lv_limit = 13
};

get(131) ->
	#data_guild_shop{
		id = 131,
		shop_no = 8,
		goods_no = 50371,
		count_limit = 50,
		price = [{3,1210}],
		weight = 1000,
		guide_lv_limit = 13
};

get(132) ->
	#data_guild_shop{
		id = 132,
		shop_no = 8,
		goods_no = 50369,
		count_limit = 1000,
		price = [{3,20}],
		weight = 1000,
		guide_lv_limit = 13
};

get(133) ->
	#data_guild_shop{
		id = 133,
		shop_no = 8,
		goods_no = 50373,
		count_limit = 100,
		price = [{3,200}],
		weight = 1000,
		guide_lv_limit = 13
};

get(134) ->
	#data_guild_shop{
		id = 134,
		shop_no = 8,
		goods_no = 50375,
		count_limit = 300,
		price = [{3,100}],
		weight = 1000,
		guide_lv_limit = 13
};

get(135) ->
	#data_guild_shop{
		id = 135,
		shop_no = 8,
		goods_no = 50374,
		count_limit = 20,
		price = [{3,1000}],
		weight = 1000,
		guide_lv_limit = 13
};

get(_Id) ->
				?DEBUG_MSG("Cannot get ~p", [_Id]),
          null.

