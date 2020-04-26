%%%---------------------------------------
%%% @Module  : data_goods_exchange
%%% @Author  : zwq
%%% @Email   : 
%%% @Description:  NPC物品兑换
%%%---------------------------------------


-module(data_goods_exchange).
-include("common.hrl").
-include("record.hrl").
-include("record/goods_record.hrl").
-compile(export_all).

get(1) ->
	#goods_exchange{
		no = 1,
		goods_no = 10047,
		need_goods_list = [{60177,1},{60178,1},{60179,1},{60180,1},{60181,1}]
};

get(2) ->
	#goods_exchange{
		no = 2,
		goods_no = 62162,
		need_goods_list = [{62161,99}]
};

get(3) ->
	#goods_exchange{
		no = 3,
		goods_no = 20003,
		need_goods_list = [{20001,1},{20002,1}]
};

get(4) ->
	#goods_exchange{
		no = 4,
		goods_no = 20007,
		need_goods_list = [{20005,1},{20006,1}]
};

get(5) ->
	#goods_exchange{
		no = 5,
		goods_no = 20011,
		need_goods_list = [{20009,1},{20010,1}]
};

get(6) ->
	#goods_exchange{
		no = 6,
		goods_no = 20017,
		need_goods_list = [{20015,1},{20016,1}]
};

get(7) ->
	#goods_exchange{
		no = 7,
		goods_no = 20021,
		need_goods_list = [{20019,1},{20020,1}]
};

get(8) ->
	#goods_exchange{
		no = 8,
		goods_no = 20004,
		need_goods_list = [{20003,30}]
};

get(9) ->
	#goods_exchange{
		no = 9,
		goods_no = 20008,
		need_goods_list = [{20007,30}]
};

get(10) ->
	#goods_exchange{
		no = 10,
		goods_no = 20012,
		need_goods_list = [{20011,30}]
};

get(11) ->
	#goods_exchange{
		no = 11,
		goods_no = 20018,
		need_goods_list = [{20017,30}]
};

get(12) ->
	#goods_exchange{
		no = 12,
		goods_no = 20022,
		need_goods_list = [{20021,30}]
};

get(13) ->
	#goods_exchange{
		no = 13,
		goods_no = 62297,
		need_goods_list = [{62269, 1},{62270, 1},{62271, 1},{62272, 1},{62273, 1},{62274, 1},{62275, 1},{62276, 1},{62277, 1},{62278, 1},{62279, 1},{62280, 1},{62281, 1},{62282, 1},{62283, 1},{62284, 1},{62285, 1},{62286, 1},{62287, 1},{62288, 1},{62289, 1},{62290, 1},{62291, 1},{62292, 1},{62293, 1},{62294, 1},{62295, 1},{62296, 1}]
};

get(15) ->
	#goods_exchange{
		no = 15,
		goods_no = 55270,
		need_goods_list = [{62317,99}]
};

get(16) ->
	#goods_exchange{
		no = 16,
		goods_no = 55264,
		need_goods_list = [{62318,99}]
};

get(17) ->
	#goods_exchange{
		no = 17,
		goods_no = 55276,
		need_goods_list = [{62319,99}]
};

get(32) ->
	#goods_exchange{
		no = 32,
		goods_no = 70573,
		need_goods_list = [{62349,3}]
};

get(33) ->
	#goods_exchange{
		no = 33,
		goods_no = 70574,
		need_goods_list = [{62349,5}]
};

get(34) ->
	#goods_exchange{
		no = 34,
		goods_no = 70575,
		need_goods_list = [{62349,10}]
};

get(21) ->
	#goods_exchange{
		no = 21,
		goods_no = 55282,
		need_goods_list = [{62374,99}]
};

get(22) ->
	#goods_exchange{
		no = 22,
		goods_no = 55288,
		need_goods_list = [{62375,99}]
};

get(23) ->
	#goods_exchange{
		no = 23,
		goods_no = 55294,
		need_goods_list = [{62376,99}]
};

get(24) ->
	#goods_exchange{
		no = 24,
		goods_no = 55300,
		need_goods_list = [{62386,99}]
};

get(25) ->
	#goods_exchange{
		no = 25,
		goods_no = 55306,
		need_goods_list = [{62387,99}]
};

get(61) ->
	#goods_exchange{
		no = 61,
		goods_no = 81271,
		need_goods_list = [{81268, 10},{81269, 10},{81270, 1}]
};

get(62) ->
	#goods_exchange{
		no = 62,
		goods_no = 81272,
		need_goods_list = [{81268, 15},{81269, 15},{81270, 2}]
};

get(63) ->
	#goods_exchange{
		no = 63,
		goods_no = 81273,
		need_goods_list = [{81268, 25},{81269, 25},{81270, 3}]
};

get(64) ->
	#goods_exchange{
		no = 64,
		goods_no = 81274,
		need_goods_list = [{81268, 30},{81269, 30},{81270, 4}]
};

get(65) ->
	#goods_exchange{
		no = 65,
		goods_no = 81275,
		need_goods_list = [{81268, 35},{81269, 35},{81270, 5}]
};

get(66) ->
	#goods_exchange{
		no = 66,
		goods_no = 81310,
		need_goods_list = [{81308, 10},{81307, 10},{81309, 1}]
};

get(67) ->
	#goods_exchange{
		no = 67,
		goods_no = 81311,
		need_goods_list = [{81308, 15},{81307, 15},{81309, 2}]
};

get(68) ->
	#goods_exchange{
		no = 68,
		goods_no = 81312,
		need_goods_list = [{81308, 25},{81307, 25},{81309, 3}]
};

get(69) ->
	#goods_exchange{
		no = 69,
		goods_no = 81313,
		need_goods_list = [{81308, 30},{81307, 30},{81309, 4}]
};

get(70) ->
	#goods_exchange{
		no = 70,
		goods_no = 81314,
		need_goods_list = [{81308, 35},{81307, 35},{81309, 5}]
};

get(71) ->
	#goods_exchange{
		no = 71,
		goods_no = 55330,
		need_goods_list = [{62486,99}]
};

get(72) ->
	#goods_exchange{
		no = 72,
		goods_no = 55336,
		need_goods_list = [{62487,99}]
};

get(73) ->
	#goods_exchange{
		no = 73,
		goods_no = 55348,
		need_goods_list = [{62488,99}]
};

get(74) ->
	#goods_exchange{
		no = 74,
		goods_no = 55342,
		need_goods_list = [{62489,99}]
};

get(46) ->
	#goods_exchange{
		no = 46,
		goods_no = 62504,
		need_goods_list = [{62497, 1},{62498, 1},{62499, 1},{62500, 1},{62501, 1},{62502, 1}]
};

get(47) ->
	#goods_exchange{
		no = 47,
		goods_no = 62505,
		need_goods_list = [{62497, 3},{62498, 3},{62499, 3},{62500, 3},{62501, 3},{62502, 3}]
};

get(48) ->
	#goods_exchange{
		no = 48,
		goods_no = 62506,
		need_goods_list = [{62497, 5},{62498, 5},{62499, 5},{62500, 5},{62501, 5},{62502, 5}]
};

get(49) ->
	#goods_exchange{
		no = 49,
		goods_no = 81369,
		need_goods_list = [{81374, 10},{81375, 10},{81376, 1}]
};

get(50) ->
	#goods_exchange{
		no = 50,
		goods_no = 81370,
		need_goods_list = [{81374, 15},{81375, 15},{81376, 2}]
};

get(51) ->
	#goods_exchange{
		no = 51,
		goods_no = 81371,
		need_goods_list = [{81374, 25},{81375, 25},{81376, 3}]
};

get(52) ->
	#goods_exchange{
		no = 52,
		goods_no = 81372,
		need_goods_list = [{81374, 30},{81375, 30},{81376, 4}]
};

get(53) ->
	#goods_exchange{
		no = 53,
		goods_no = 81373,
		need_goods_list = [{81374, 35},{81375, 35},{81376, 5}]
};

get(54) ->
	#goods_exchange{
		no = 54,
		goods_no = 20025,
		need_goods_list = [{62529,99}]
};

get(55) ->
	#goods_exchange{
		no = 55,
		goods_no = 55366,
		need_goods_list = [{62534,99}]
};

get(56) ->
	#goods_exchange{
		no = 56,
		goods_no = 55360,
		need_goods_list = [{62535,99}]
};

get(75) ->
	#goods_exchange{
		no = 75,
		goods_no = 81406,
		need_goods_list = [{81404, 1},{81403, 1},{81405, 3},{81402, 5}]
};

get(76) ->
	#goods_exchange{
		no = 76,
		goods_no = 81407,
		need_goods_list = [{81404, 2},{81403, 2},{81405, 5},{81402, 10}]
};

get(77) ->
	#goods_exchange{
		no = 77,
		goods_no = 81408,
		need_goods_list = [{81404, 3},{81403, 3},{81405, 7},{81402, 15}]
};

get(78) ->
	#goods_exchange{
		no = 78,
		goods_no = 81409,
		need_goods_list = [{81404, 5},{81403, 5},{81405, 10},{81402, 20}]
};

get(79) ->
	#goods_exchange{
		no = 79,
		goods_no = 62545,
		need_goods_list = [{62544,99}]
};

get(80) ->
	#goods_exchange{
		no = 80,
		goods_no = 55318,
		need_goods_list = [{62547,99}]
};

get(81) ->
	#goods_exchange{
		no = 81,
		goods_no = 55312,
		need_goods_list = [{62548,99}]
};

get(82) ->
	#goods_exchange{
		no = 82,
		goods_no = 55324,
		need_goods_list = [{62549,99}]
};

get(83) ->
	#goods_exchange{
		no = 83,
		goods_no = 62381,
		need_goods_list = [{30001, 5}]
};

get(84) ->
	#goods_exchange{
		no = 84,
		goods_no = 110003,
		need_goods_list = [{110002,99}]
};

get(85) ->
	#goods_exchange{
		no = 85,
		goods_no = 110007,
		need_goods_list = [{110006,99}]
};

get(86) ->
	#goods_exchange{
		no = 86,
		goods_no = 110011,
		need_goods_list = [{110010,99}]
};

get(87) ->
	#goods_exchange{
		no = 87,
		goods_no = 20034,
		need_goods_list = [{20032,1},{20033,1}]
};

get(88) ->
	#goods_exchange{
		no = 88,
		goods_no = 20035,
		need_goods_list = [{20034,60}]
};

get(89) ->
	#goods_exchange{
		no = 89,
		goods_no = 20038,
		need_goods_list = [{20036,1},{20037,1}]
};

get(90) ->
	#goods_exchange{
		no = 90,
		goods_no = 20039,
		need_goods_list = [{20038,60}]
};

get(91) ->
	#goods_exchange{
		no = 91,
		goods_no = 20042,
		need_goods_list = [{20041,99}]
};

get(92) ->
	#goods_exchange{
		no = 92,
		goods_no = 55412,
		need_goods_list = [{62575,99}]
};

get(93) ->
	#goods_exchange{
		no = 93,
		goods_no = 55419,
		need_goods_list = [{62573,99}]
};

get(94) ->
	#goods_exchange{
		no = 94,
		goods_no = 55425,
		need_goods_list = [{62574,99}]
};

get(95) ->
	#goods_exchange{
		no = 95,
		goods_no = 55510,
		need_goods_list = [{62630,99}]
};

get(_No) ->
	      ?ASSERT(false, _No),
          null.

