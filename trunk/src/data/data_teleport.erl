%%%---------------------------------------
%%% @Module  : data_teleport
%%% @Author  : huangjf
%%% @Email   : 
%%% @Description: 传送配置数据
%%%---------------------------------------


-module(data_teleport).
-export([get/1]).
-include("scene.hrl").
-include("debug.hrl").

get(1001) ->
	#teleport{
		no = 1001,
		target_scene_no = 1304,
		target_xy = {144, 129},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(1002) ->
	#teleport{
		no = 1002,
		target_scene_no = 1304,
		target_xy = {122, 130},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(1003) ->
	#teleport{
		no = 1003,
		target_scene_no = 1304,
		target_xy = {113, 116},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(1004) ->
	#teleport{
		no = 1004,
		target_scene_no = 1304,
		target_xy = {122, 107},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(1005) ->
	#teleport{
		no = 1005,
		target_scene_no = 1304,
		target_xy = {135, 106},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(1006) ->
	#teleport{
		no = 1006,
		target_scene_no = 1304,
		target_xy = {148, 110},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(1007) ->
	#teleport{
		no = 1007,
		target_scene_no = 1304,
		target_xy = {153, 123},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(1008) ->
	#teleport{
		no = 1008,
		target_scene_no = 1304,
		target_xy = {143, 133},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(1009) ->
	#teleport{
		no = 1009,
		target_scene_no = 1304,
		target_xy = {108, 131},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(24) ->
	#teleport{
		no = 24,
		target_scene_no = 1304,
		target_xy = {155, 118},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(14) ->
	#teleport{
		no = 14,
		target_scene_no = 1304,
		target_xy = {155, 118},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(10) ->
	#teleport{
		no = 10,
		target_scene_no = 1304,
		target_xy = {155, 118},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(13) ->
	#teleport{
		no = 13,
		target_scene_no = 1304,
		target_xy = {155, 118},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(26) ->
	#teleport{
		no = 26,
		target_scene_no = 1304,
		target_xy = {155, 118},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(17) ->
	#teleport{
		no = 17,
		target_scene_no = 1304,
		target_xy = {155, 118},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(101) ->
	#teleport{
		no = 101,
		target_scene_no = 1101,
		target_xy = {69, 25},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [already_joined_faction],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(102) ->
	#teleport{
		no = 102,
		target_scene_no = 1102,
		target_xy = {22, 53},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [already_joined_faction],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(103) ->
	#teleport{
		no = 103,
		target_scene_no = 1103,
		target_xy = {89, 27},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [already_joined_faction],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(104) ->
	#teleport{
		no = 104,
		target_scene_no = 1104,
		target_xy = {27, 20},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [already_joined_faction],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(105) ->
	#teleport{
		no = 105,
		target_scene_no = 1105,
		target_xy = {110, 3},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [already_joined_faction],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(106) ->
	#teleport{
		no = 106,
		target_scene_no = 1106,
		target_xy = {110, 32},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [already_joined_faction],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(107) ->
	#teleport{
		no = 107,
		target_scene_no = 1304,
		target_xy = {155, 118},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(108) ->
	#teleport{
		no = 108,
		target_scene_no = 1303,
		target_xy = {107, 78},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(109) ->
	#teleport{
		no = 109,
		target_scene_no = 1305,
		target_xy = {98, 89},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(200) ->
	#teleport{
		no = 200,
		target_scene_no = 1304,
		target_xy = {155, 118},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(201) ->
	#teleport{
		no = 201,
		target_scene_no = 1303,
		target_xy = {107, 78},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(202) ->
	#teleport{
		no = 202,
		target_scene_no = 5001,
		target_xy = {133, 74},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [already_joined_guild],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(5) ->
	#teleport{
		no = 5,
		target_scene_no = 1307,
		target_xy = {119, 89},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(20) ->
	#teleport{
		no = 20,
		target_scene_no = 1303,
		target_xy = {100, 8},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(16) ->
	#teleport{
		no = 16,
		target_scene_no = 1102,
		target_xy = {22, 53},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(9) ->
	#teleport{
		no = 9,
		target_scene_no = 1103,
		target_xy = {89, 27},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(15) ->
	#teleport{
		no = 15,
		target_scene_no = 1104,
		target_xy = {27, 20},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(25) ->
	#teleport{
		no = 25,
		target_scene_no = 1105,
		target_xy = {110, 3},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(6) ->
	#teleport{
		no = 6,
		target_scene_no = 1304,
		target_xy = {155, 118},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(7) ->
	#teleport{
		no = 7,
		target_scene_no = 1304,
		target_xy = {155, 118},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(11) ->
	#teleport{
		no = 11,
		target_scene_no = 1309,
		target_xy = {18, 144},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(8) ->
	#teleport{
		no = 8,
		target_scene_no = 1304,
		target_xy = {155, 118},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(12) ->
	#teleport{
		no = 12,
		target_scene_no = 1308,
		target_xy = {266, 38},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(30) ->
	#teleport{
		no = 30,
		target_scene_no = 1202,
		target_xy = {9, 30},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(31) ->
	#teleport{
		no = 31,
		target_scene_no = 1308,
		target_xy = {28, 68},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(18) ->
	#teleport{
		no = 18,
		target_scene_no = 1106,
		target_xy = {110, 32},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(19) ->
	#teleport{
		no = 19,
		target_scene_no = 1301,
		target_xy = {104, 14},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(21) ->
	#teleport{
		no = 21,
		target_scene_no = 1301,
		target_xy = {9, 18},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(23) ->
	#teleport{
		no = 23,
		target_scene_no = 1101,
		target_xy = {69, 25},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(27) ->
	#teleport{
		no = 27,
		target_scene_no = 1201,
		target_xy = {15, 39},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(28) ->
	#teleport{
		no = 28,
		target_scene_no = 1304,
		target_xy = {155, 118},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(29) ->
	#teleport{
		no = 29,
		target_scene_no = 3001,
		target_xy = {27, 24},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(32) ->
	#teleport{
		no = 32,
		target_scene_no = 3301,
		target_xy = {37, 55},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(38) ->
	#teleport{
		no = 38,
		target_scene_no = 1201,
		target_xy = {95, 52},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(39) ->
	#teleport{
		no = 39,
		target_scene_no = 1206,
		target_xy = {20, 56},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(40) ->
	#teleport{
		no = 40,
		target_scene_no = 1206,
		target_xy = {95, 52},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(41) ->
	#teleport{
		no = 41,
		target_scene_no = 1211,
		target_xy = {31, 13},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(42) ->
	#teleport{
		no = 42,
		target_scene_no = 1202,
		target_xy = {126, 150},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(43) ->
	#teleport{
		no = 43,
		target_scene_no = 1207,
		target_xy = {18, 40},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(44) ->
	#teleport{
		no = 44,
		target_scene_no = 1207,
		target_xy = {126, 150},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(45) ->
	#teleport{
		no = 45,
		target_scene_no = 1212,
		target_xy = {18, 40},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(46) ->
	#teleport{
		no = 46,
		target_scene_no = 1203,
		target_xy = {95, 8},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(47) ->
	#teleport{
		no = 47,
		target_scene_no = 1203,
		target_xy = {58, 90},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(48) ->
	#teleport{
		no = 48,
		target_scene_no = 1208,
		target_xy = {130, 16},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(49) ->
	#teleport{
		no = 49,
		target_scene_no = 1208,
		target_xy = {58, 90},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(50) ->
	#teleport{
		no = 50,
		target_scene_no = 1213,
		target_xy = {130, 16},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(51) ->
	#teleport{
		no = 51,
		target_scene_no = 1309,
		target_xy = {142, 15},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(52) ->
	#teleport{
		no = 52,
		target_scene_no = 1309,
		target_xy = {156, 10},
		lv_need = 100,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(53) ->
	#teleport{
		no = 53,
		target_scene_no = 9001,
		target_xy = {16, 9},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(54) ->
	#teleport{
		no = 54,
		target_scene_no = 1304,
		target_xy = {155, 118},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(55) ->
	#teleport{
		no = 55,
		target_scene_no = 13081,
		target_xy = {91, 101},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(56) ->
	#teleport{
		no = 56,
		target_scene_no = 1308,
		target_xy = {79, 13},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(57) ->
	#teleport{
		no = 57,
		target_scene_no = 1305,
		target_xy = {18, 28},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(58) ->
	#teleport{
		no = 58,
		target_scene_no = 13081,
		target_xy = {285, 10},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(59) ->
	#teleport{
		no = 59,
		target_scene_no = 1311,
		target_xy = {29, 20},
		lv_need = 100,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(60) ->
	#teleport{
		no = 60,
		target_scene_no = 1305,
		target_xy = {203, 158},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(61) ->
	#teleport{
		no = 61,
		target_scene_no = 1204,
		target_xy = {19, 18},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(62) ->
	#teleport{
		no = 62,
		target_scene_no = 1311,
		target_xy = {57, 37},
		lv_need = 100,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(63) ->
	#teleport{
		no = 63,
		target_scene_no = 1105,
		target_xy = {110, 3},
		lv_need = 100,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(64) ->
	#teleport{
		no = 64,
		target_scene_no = 1209,
		target_xy = {19, 18},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(65) ->
	#teleport{
		no = 65,
		target_scene_no = 1204,
		target_xy = {121, 18},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(66) ->
	#teleport{
		no = 66,
		target_scene_no = 1214,
		target_xy = {19, 18},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(67) ->
	#teleport{
		no = 67,
		target_scene_no = 1209,
		target_xy = {121, 18},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(68) ->
	#teleport{
		no = 68,
		target_scene_no = 1310,
		target_xy = {22, 53},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(69) ->
	#teleport{
		no = 69,
		target_scene_no = 1309,
		target_xy = {71, 32},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(70) ->
	#teleport{
		no = 70,
		target_scene_no = 1103,
		target_xy = {89, 27},
		lv_need = 100,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(71) ->
	#teleport{
		no = 71,
		target_scene_no = 1204,
		target_xy = {32, 43},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(72) ->
	#teleport{
		no = 72,
		target_scene_no = 1310,
		target_xy = {117, 79},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(73) ->
	#teleport{
		no = 73,
		target_scene_no = 1209,
		target_xy = {44, 64},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(74) ->
	#teleport{
		no = 74,
		target_scene_no = 1204,
		target_xy = {162, 46},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(75) ->
	#teleport{
		no = 75,
		target_scene_no = 1214,
		target_xy = {44, 64},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(76) ->
	#teleport{
		no = 76,
		target_scene_no = 1209,
		target_xy = {162, 46},
		lv_need = 0,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(77) ->
	#teleport{
		no = 77,
		target_scene_no = 1306,
		target_xy = {17, 34},
		lv_need = 100,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(78) ->
	#teleport{
		no = 78,
		target_scene_no = 13081,
		target_xy = {412, 17},
		lv_need = 100,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(79) ->
	#teleport{
		no = 79,
		target_scene_no = 1312,
		target_xy = {105, 21},
		lv_need = 100,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(80) ->
	#teleport{
		no = 80,
		target_scene_no = 1306,
		target_xy = {95, 168},
		lv_need = 100,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(81) ->
	#teleport{
		no = 81,
		target_scene_no = 1216,
		target_xy = {32, 59},
		lv_need = 100,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(82) ->
	#teleport{
		no = 82,
		target_scene_no = 1312,
		target_xy = {155, 70},
		lv_need = 100,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(83) ->
	#teleport{
		no = 83,
		target_scene_no = 1217,
		target_xy = {32, 59},
		lv_need = 100,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(84) ->
	#teleport{
		no = 84,
		target_scene_no = 1216,
		target_xy = {93, 15},
		lv_need = 100,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(85) ->
	#teleport{
		no = 85,
		target_scene_no = 1218,
		target_xy = {32, 59},
		lv_need = 100,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(86) ->
	#teleport{
		no = 86,
		target_scene_no = 1217,
		target_xy = {93, 15},
		lv_need = 100,
		race_need = 0,
		faction_need = 0,
		extra_conditions = [],
		bind_gamemoney_cost = 0,
		bind_yuanbao_cost = 0
};

get(_No) ->
	      ?ASSERT(false, _No),
          null.

