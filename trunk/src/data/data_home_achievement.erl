%%%---------------------------------------
%%% @Module  : data_home_achievement
%%% @Author  : dsh
%%% @Email   : 
%%% @Description:  家园成就配置表
%%%---------------------------------------


-module(data_home_achievement).

-include("home.hrl").
-include("debug.hrl").
-compile(export_all).

get(1) ->
	#home_achievement{
		no = 1,
		achievement = <<"家园升到高级">>,
		type = 1,
		num = 2,
		partner_id = 0,
		reward = 30,
		goods = 0
};

get(2) ->
	#home_achievement{
		no = 2,
		achievement = <<"家园升到豪华">>,
		type = 1,
		num = 3,
		partner_id = 0,
		reward = 50,
		goods = 0
};

get(3) ->
	#home_achievement{
		no = 3,
		achievement = <<"土地升到1级">>,
		type = 2,
		num = 1,
		partner_id = 0,
		reward = 5,
		goods = 0
};

get(4) ->
	#home_achievement{
		no = 4,
		achievement = <<"土地升到2级">>,
		type = 2,
		num = 2,
		partner_id = 0,
		reward = 10,
		goods = 0
};

get(5) ->
	#home_achievement{
		no = 5,
		achievement = <<"土地升到3级">>,
		type = 2,
		num = 3,
		partner_id = 0,
		reward = 15,
		goods = 0
};

get(6) ->
	#home_achievement{
		no = 6,
		achievement = <<"土地升到4级">>,
		type = 2,
		num = 4,
		partner_id = 0,
		reward = 20,
		goods = 0
};

get(7) ->
	#home_achievement{
		no = 7,
		achievement = <<"土地升到5级">>,
		type = 2,
		num = 5,
		partner_id = 0,
		reward = 25,
		goods = 0
};

get(8) ->
	#home_achievement{
		no = 8,
		achievement = <<"土地升到6级">>,
		type = 2,
		num = 6,
		partner_id = 0,
		reward = 30,
		goods = 0
};

get(9) ->
	#home_achievement{
		no = 9,
		achievement = <<"炼丹炉升到1级">>,
		type = 3,
		num = 1,
		partner_id = 0,
		reward = 5,
		goods = 0
};

get(10) ->
	#home_achievement{
		no = 10,
		achievement = <<"炼丹炉升到2级">>,
		type = 3,
		num = 2,
		partner_id = 0,
		reward = 10,
		goods = 0
};

get(11) ->
	#home_achievement{
		no = 11,
		achievement = <<"炼丹炉升到3级">>,
		type = 3,
		num = 3,
		partner_id = 0,
		reward = 15,
		goods = 0
};

get(12) ->
	#home_achievement{
		no = 12,
		achievement = <<"炼丹炉升到4级">>,
		type = 3,
		num = 4,
		partner_id = 0,
		reward = 20,
		goods = 0
};

get(13) ->
	#home_achievement{
		no = 13,
		achievement = <<"炼丹炉升到5级">>,
		type = 3,
		num = 5,
		partner_id = 0,
		reward = 25,
		goods = 0
};

get(14) ->
	#home_achievement{
		no = 14,
		achievement = <<"炼丹炉升到6级">>,
		type = 3,
		num = 6,
		partner_id = 0,
		reward = 30,
		goods = 0
};

get(15) ->
	#home_achievement{
		no = 15,
		achievement = <<"矿井升到1级">>,
		type = 4,
		num = 1,
		partner_id = 0,
		reward = 5,
		goods = 0
};

get(16) ->
	#home_achievement{
		no = 16,
		achievement = <<"矿井升到2级">>,
		type = 4,
		num = 2,
		partner_id = 0,
		reward = 10,
		goods = 0
};

get(17) ->
	#home_achievement{
		no = 17,
		achievement = <<"矿井升到3级">>,
		type = 4,
		num = 3,
		partner_id = 0,
		reward = 15,
		goods = 0
};

get(18) ->
	#home_achievement{
		no = 18,
		achievement = <<"矿井升到4级">>,
		type = 4,
		num = 4,
		partner_id = 0,
		reward = 20,
		goods = 0
};

get(19) ->
	#home_achievement{
		no = 19,
		achievement = <<"矿井升到5级">>,
		type = 4,
		num = 5,
		partner_id = 0,
		reward = 25,
		goods = 0
};

get(20) ->
	#home_achievement{
		no = 20,
		achievement = <<"矿井升到6级">>,
		type = 4,
		num = 6,
		partner_id = 0,
		reward = 30,
		goods = 0
};

get(21) ->
	#home_achievement{
		no = 21,
		achievement = <<"土地收获10次">>,
		type = 5,
		num = 10,
		partner_id = 0,
		reward = 50,
		goods = 0
};

get(22) ->
	#home_achievement{
		no = 22,
		achievement = <<"土地收获30次">>,
		type = 5,
		num = 30,
		partner_id = 0,
		reward = 150,
		goods = 0
};

get(23) ->
	#home_achievement{
		no = 23,
		achievement = <<"土地收获50次">>,
		type = 5,
		num = 50,
		partner_id = 0,
		reward = 250,
		goods = 0
};

get(24) ->
	#home_achievement{
		no = 24,
		achievement = <<"土地收获100次">>,
		type = 5,
		num = 100,
		partner_id = 0,
		reward = 500,
		goods = 0
};

get(25) ->
	#home_achievement{
		no = 25,
		achievement = <<"炼丹炉收获10次">>,
		type = 6,
		num = 10,
		partner_id = 0,
		reward = 50,
		goods = 0
};

get(26) ->
	#home_achievement{
		no = 26,
		achievement = <<"炼丹炉收获30次">>,
		type = 6,
		num = 30,
		partner_id = 0,
		reward = 150,
		goods = 0
};

get(27) ->
	#home_achievement{
		no = 27,
		achievement = <<"炼丹炉收获50次">>,
		type = 6,
		num = 50,
		partner_id = 0,
		reward = 250,
		goods = 0
};

get(28) ->
	#home_achievement{
		no = 28,
		achievement = <<"炼丹炉收获100次">>,
		type = 6,
		num = 100,
		partner_id = 0,
		reward = 500,
		goods = 0
};

get(29) ->
	#home_achievement{
		no = 29,
		achievement = <<"矿井收获10次">>,
		type = 7,
		num = 10,
		partner_id = 0,
		reward = 50,
		goods = 0
};

get(30) ->
	#home_achievement{
		no = 30,
		achievement = <<"矿井收获30次">>,
		type = 7,
		num = 30,
		partner_id = 0,
		reward = 150,
		goods = 0
};

get(31) ->
	#home_achievement{
		no = 31,
		achievement = <<"矿井收获50次">>,
		type = 7,
		num = 50,
		partner_id = 0,
		reward = 250,
		goods = 0
};

get(32) ->
	#home_achievement{
		no = 32,
		achievement = <<"矿井收获100次">>,
		type = 7,
		num = 100,
		partner_id = 0,
		reward = 500,
		goods = 0
};

get(33) ->
	#home_achievement{
		no = 33,
		achievement = <<"雇佣青龙、朱雀或麒麟种植收获10次">>,
		type = 8,
		num = 10,
		partner_id = {4001,4002,4003,4004,4005,4006,4007,4008,4009,4010,4011,4012,4013,4014,4015,4016,4017,4018,4019,4020,4021,4022,4023,4024,4025,4026},
		reward = 50,
		goods = 0
};

get(34) ->
	#home_achievement{
		no = 34,
		achievement = <<"雇佣青龙、朱雀或麒麟种植收获30次">>,
		type = 8,
		num = 30,
		partner_id = {4001,4002,4003,4004,4005,4006,4007,4008,4009,4010,4011,4012,4013,4014,4015,4016,4017,4018,4019,4020,4021,4022,4023,4024,4025,4026},
		reward = 150,
		goods = 0
};

get(35) ->
	#home_achievement{
		no = 35,
		achievement = <<"雇佣青龙、朱雀或麒麟种植收获50次">>,
		type = 8,
		num = 50,
		partner_id = {4001,4002,4003,4004,4005,4006,4007,4008,4009,4010,4011,4012,4013,4014,4015,4016,4017,4018,4019,4020,4021,4022,4023,4024,4025,4026},
		reward = 250,
		goods = 0
};

get(36) ->
	#home_achievement{
		no = 36,
		achievement = <<"雇佣青龙、朱雀或麒麟种植收获100次">>,
		type = 8,
		num = 100,
		partner_id = {4001,4002,4003,4004,4005,4006,4011,4012,4013,4014,4015,4016,4021,4022,4023,4024,4025,4026},
		reward = 500,
		goods = 0
};

get(37) ->
	#home_achievement{
		no = 37,
		achievement = <<"雇佣元始天尊、月姬仙子或逍遥剑仙炼丹收获10次">>,
		type = 9,
		num = 10,
		partner_id = {4027,4028,4029,4030,4031,4032,4033,4034,4035,4036,4037,4038,4039,4040,4041,4042,4043,4044},
		reward = 50,
		goods = 0
};

get(38) ->
	#home_achievement{
		no = 38,
		achievement = <<"雇佣元始天尊、月姬仙子或逍遥剑仙炼丹收获30次">>,
		type = 9,
		num = 30,
		partner_id = {4027,4028,4029,4030,4031,4032,4033,4034,4035,4036,4037,4038,4039,4040,4041,4042,4043,4044},
		reward = 150,
		goods = 0
};

get(39) ->
	#home_achievement{
		no = 39,
		achievement = <<"雇佣元始天尊、月姬仙子或逍遥剑仙炼丹收获50次">>,
		type = 9,
		num = 50,
		partner_id = {4027,4028,4029,4030,4031,4032,4033,4034,4035,4036,4037,4038,4039,4040,4041,4042,4043,4044},
		reward = 250,
		goods = 0
};

get(40) ->
	#home_achievement{
		no = 40,
		achievement = <<"雇佣元始天尊、月姬仙子或逍遥剑仙炼丹收获100次">>,
		type = 9,
		num = 100,
		partner_id = {4027,4028,4029,4030,4031,4032,4033,4034,4035,4036,4037,4038,4039,4040,4041,4042,4043,4044},
		reward = 500,
		goods = 0
};

get(41) ->
	#home_achievement{
		no = 41,
		achievement = <<"雇佣逆天魔龙、九天魔女、惑天玄姬采矿收获10次">>,
		type = 10,
		num = 10,
		partner_id = {2061,2062,2063,2064,2065,2066,2071,2072,2073,2074,2075,2076,2081,2082,2083,2084,2085,2086},
		reward = 50,
		goods = 0
};

get(42) ->
	#home_achievement{
		no = 42,
		achievement = <<"雇佣逆天魔龙、九天魔女、惑天玄姬采矿收获30次">>,
		type = 10,
		num = 30,
		partner_id = {2061,2062,2063,2064,2065,2066,2071,2072,2073,2074,2075,2076,2081,2082,2083,2084,2085,2086},
		reward = 150,
		goods = 0
};

get(43) ->
	#home_achievement{
		no = 43,
		achievement = <<"雇佣逆天魔龙、九天魔女、惑天玄姬采矿收获50次">>,
		type = 10,
		num = 50,
		partner_id = {2061,2062,2063,2064,2065,2066,2071,2072,2073,2074,2075,2076,2081,2082,2083,2084,2085,2086},
		reward = 250,
		goods = 0
};

get(44) ->
	#home_achievement{
		no = 44,
		achievement = <<"雇佣逆天魔龙、九天魔女、惑天玄姬采矿收获100次">>,
		type = 10,
		num = 100,
		partner_id = {2061,2062,2063,2064,2065,2066,2071,2072,2073,2074,2075,2076,2081,2082,2083,2084,2085,2086},
		reward = 500,
		goods = 0
};

get(45) ->
	#home_achievement{
		no = 45,
		achievement = <<"家园豪华度达到5000">>,
		type = 11,
		num = 5000,
		partner_id = 0,
		reward = 0,
		goods = {62453,1}
};

get(_No) ->
	      ?ASSERT(false, _No),
          null.

get_nos()->
	[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45].

