%%%---------------------------------------
%%% @Module  : data_reward_goods
%%% @Author  : liuzz
%%% @Email   :
%%% @Description: 奖励池配置数据
%%%---------------------------------------


-module(data_reward_goods).
-export([get_ids/0, get/1]).
-include("reward.hrl").
-include("debug.hrl").

get_ids()->
	[50000,50001,50002,50003,50004,50007,50008,50009,50010,50011,50012,50013,50014,50015,50016,50017,50018,60001,60002,60003,60004,60005,60006,60007,60008,60009,60010,60011,60012,60013,60014,60015,60016,60017,60018,60019,60020,60021,60022,60023,60024,60025,60026,60027,60028,60029,60030,60031,60032,60033,60034,60035,60036,60037,60038,60039,60040,60200,60201,60202,60203,60204,60205,60206,60207,60208,60209,60210,60211,60212,60213,60214,60215,60216,60217,60218,60219,60220,60221,60222,60223,60224,60225,60226,60227,60228,60229,60230,60231,60232,60233,60234,60235,60236,60237,60238,60239,60240,60241,60242,60243,60244,60245,60246,60247,60248,60400,60401,60402,60403,60404,60405,60406,60407,60408,60409,60410,60411,60412,60413,60414,60415,60416,60417,60418,60419,60420,60421,60422,60423,60424,60701,60702].

get(50000) ->
	#data_reward_goods{
		no = 50000,
		good_no = 60177,
		bind_state = 2,
		quality = 0,
		limit = 400,
		need_broadcast = 107
};

get(50001) ->
	#data_reward_goods{
		no = 50001,
		good_no = 60178,
		bind_state = 2,
		quality = 0,
		limit = 200,
		need_broadcast = 107
};

get(50002) ->
	#data_reward_goods{
		no = 50002,
		good_no = 60179,
		bind_state = 2,
		quality = 0,
		limit = 300,
		need_broadcast = 107
};

get(50003) ->
	#data_reward_goods{
		no = 50003,
		good_no = 60180,
		bind_state = 2,
		quality = 0,
		limit = 100,
		need_broadcast = 107
};

get(50004) ->
	#data_reward_goods{
		no = 50004,
		good_no = 60181,
		bind_state = 2,
		quality = 0,
		limit = 100,
		need_broadcast = 107
};

get(50007) ->
	#data_reward_goods{
		no = 50007,
		good_no = 62029,
		bind_state = 2,
		quality = 0,
		limit = 100,
		need_broadcast = 107
};

get(50008) ->
	#data_reward_goods{
		no = 50008,
		good_no = 72131,
		bind_state = 2,
		quality = 0,
		limit = 200,
		need_broadcast = 107
};

get(50009) ->
	#data_reward_goods{
		no = 50009,
		good_no = 72132,
		bind_state = 2,
		quality = 0,
		limit = 200,
		need_broadcast = 107
};

get(50010) ->
	#data_reward_goods{
		no = 50010,
		good_no = 72133,
		bind_state = 2,
		quality = 0,
		limit = 200,
		need_broadcast = 107
};

get(50011) ->
	#data_reward_goods{
		no = 50011,
		good_no = 72134,
		bind_state = 2,
		quality = 0,
		limit = 200,
		need_broadcast = 107
};

get(50012) ->
	#data_reward_goods{
		no = 50012,
		good_no = 62030,
		bind_state = 2,
		quality = 0,
		limit = 500,
		need_broadcast = 0
};

get(50013) ->
	#data_reward_goods{
		no = 50013,
		good_no = 62031,
		bind_state = 2,
		quality = 0,
		limit = 100,
		need_broadcast = 118
};

get(50014) ->
	#data_reward_goods{
		no = 50014,
		good_no = 62250,
		bind_state = 2,
		quality = 0,
		limit = 200,
		need_broadcast = 118
};

get(50015) ->
	#data_reward_goods{
		no = 50015,
		good_no = 62161,
		bind_state = 2,
		quality = 0,
		limit = 50,
		need_broadcast = 118
};

get(50016) ->
	#data_reward_goods{
		no = 50016,
		good_no = 62252,
		bind_state = 2,
		quality = 0,
		limit = 500,
		need_broadcast = 118
};

get(50017) ->
	#data_reward_goods{
		no = 50017,
		good_no = 62249,
		bind_state = 2,
		quality = 0,
		limit = 100,
		need_broadcast = 118
};

get(50018) ->
	#data_reward_goods{
		no = 50018,
		good_no = 62251,
		bind_state = 2,
		quality = 0,
		limit = 5,
		need_broadcast = 118
};

get(60001) ->
	#data_reward_goods{
		no = 60001,
		good_no = 62033,
		bind_state = 3,
		quality = 0,
		limit = 50,
		need_broadcast = 0
};

get(60002) ->
	#data_reward_goods{
		no = 60002,
		good_no = 62074,
		bind_state = 3,
		quality = 0,
		limit = 25,
		need_broadcast = 0
};

get(60003) ->
	#data_reward_goods{
		no = 60003,
		good_no = 72134,
		bind_state = 3,
		quality = 0,
		limit = 20,
		need_broadcast = 203
};

get(60004) ->
	#data_reward_goods{
		no = 60004,
		good_no = 72133,
		bind_state = 3,
		quality = 0,
		limit = 20,
		need_broadcast = 203
};

get(60005) ->
	#data_reward_goods{
		no = 60005,
		good_no = 72131,
		bind_state = 3,
		quality = 0,
		limit = 20,
		need_broadcast = 203
};

get(60006) ->
	#data_reward_goods{
		no = 60006,
		good_no = 72132,
		bind_state = 3,
		quality = 0,
		limit = 20,
		need_broadcast = 203
};

get(60007) ->
	#data_reward_goods{
		no = 60007,
		good_no = 62003,
		bind_state = 3,
		quality = 0,
		limit = 50,
		need_broadcast = 0
};

get(60008) ->
	#data_reward_goods{
		no = 60008,
		good_no = 62004,
		bind_state = 3,
		quality = 0,
		limit = 40,
		need_broadcast = 0
};

get(60009) ->
	#data_reward_goods{
		no = 60009,
		good_no = 62005,
		bind_state = 3,
		quality = 0,
		limit = 35,
		need_broadcast = 0
};

get(60010) ->
	#data_reward_goods{
		no = 60010,
		good_no = 62006,
		bind_state = 3,
		quality = 0,
		limit = 30,
		need_broadcast = 0
};

get(60011) ->
	#data_reward_goods{
		no = 60011,
		good_no = 62007,
		bind_state = 3,
		quality = 0,
		limit = 30,
		need_broadcast = 203
};

get(60012) ->
	#data_reward_goods{
		no = 60012,
		good_no = 62008,
		bind_state = 3,
		quality = 0,
		limit = 20,
		need_broadcast = 203
};

get(60013) ->
	#data_reward_goods{
		no = 60013,
		good_no = 62009,
		bind_state = 3,
		quality = 0,
		limit = 15,
		need_broadcast = 203
};

get(60014) ->
	#data_reward_goods{
		no = 60014,
		good_no = 62010,
		bind_state = 3,
		quality = 0,
		limit = 10,
		need_broadcast = 203
};

get(60015) ->
	#data_reward_goods{
		no = 60015,
		good_no = 62027,
		bind_state = 3,
		quality = 0,
		limit = 50,
		need_broadcast = 0
};

get(60016) ->
	#data_reward_goods{
		no = 60016,
		good_no = 62028,
		bind_state = 3,
		quality = 0,
		limit = 30,
		need_broadcast = 0
};

get(60017) ->
	#data_reward_goods{
		no = 60017,
		good_no = 62029,
		bind_state = 3,
		quality = 0,
		limit = 20,
		need_broadcast = 203
};

get(60018) ->
	#data_reward_goods{
		no = 60018,
		good_no = 62030,
		bind_state = 3,
		quality = 0,
		limit = 15,
		need_broadcast = 203
};

get(60019) ->
	#data_reward_goods{
		no = 60019,
		good_no = 62031,
		bind_state = 3,
		quality = 0,
		limit = 10,
		need_broadcast = 203
};

get(60020) ->
	#data_reward_goods{
		no = 60020,
		good_no = 62032,
		bind_state = 3,
		quality = 0,
		limit = 50,
		need_broadcast = 203
};

get(60021) ->
	#data_reward_goods{
		no = 60021,
		good_no = 10071,
		bind_state = 3,
		quality = 0,
		limit = 25,
		need_broadcast = 0
};

get(60022) ->
	#data_reward_goods{
		no = 60022,
		good_no = 10072,
		bind_state = 3,
		quality = 0,
		limit = 25,
		need_broadcast = 0
};

get(60023) ->
	#data_reward_goods{
		no = 60023,
		good_no = 10073,
		bind_state = 3,
		quality = 0,
		limit = 25,
		need_broadcast = 0
};

get(60024) ->
	#data_reward_goods{
		no = 60024,
		good_no = 10074,
		bind_state = 3,
		quality = 0,
		limit = 25,
		need_broadcast = 0
};

get(60025) ->
	#data_reward_goods{
		no = 60025,
		good_no = 10075,
		bind_state = 3,
		quality = 0,
		limit = 25,
		need_broadcast = 0
};

get(60026) ->
	#data_reward_goods{
		no = 60026,
		good_no = 10086,
		bind_state = 3,
		quality = 0,
		limit = 25,
		need_broadcast = 0
};

get(60027) ->
	#data_reward_goods{
		no = 60027,
		good_no = 10087,
		bind_state = 3,
		quality = 0,
		limit = 25,
		need_broadcast = 0
};

get(60028) ->
	#data_reward_goods{
		no = 60028,
		good_no = 10088,
		bind_state = 3,
		quality = 0,
		limit = 25,
		need_broadcast = 0
};

get(60029) ->
	#data_reward_goods{
		no = 60029,
		good_no = 10089,
		bind_state = 3,
		quality = 0,
		limit = 25,
		need_broadcast = 0
};

get(60030) ->
	#data_reward_goods{
		no = 60030,
		good_no = 10090,
		bind_state = 3,
		quality = 0,
		limit = 25,
		need_broadcast = 0
};

get(60031) ->
	#data_reward_goods{
		no = 60031,
		good_no = 50366,
		bind_state = 2,
		quality = 0,
		limit = 50,
		need_broadcast = 0
};

get(60032) ->
	#data_reward_goods{
		no = 60032,
		good_no = 50398,
		bind_state = 2,
		quality = 0,
		limit = 25,
		need_broadcast = 203
};

get(60033) ->
	#data_reward_goods{
		no = 60033,
		good_no = 50038,
		bind_state = 3,
		quality = 0,
		limit = 25,
		need_broadcast = 0
};

get(60034) ->
	#data_reward_goods{
		no = 60034,
		good_no = 60177,
		bind_state = 3,
		quality = 0,
		limit = 10,
		need_broadcast = 203
};

get(60035) ->
	#data_reward_goods{
		no = 60035,
		good_no = 60178,
		bind_state = 3,
		quality = 0,
		limit = 10,
		need_broadcast = 203
};

get(60036) ->
	#data_reward_goods{
		no = 60036,
		good_no = 60179,
		bind_state = 3,
		quality = 0,
		limit = 10,
		need_broadcast = 203
};

get(60037) ->
	#data_reward_goods{
		no = 60037,
		good_no = 60180,
		bind_state = 3,
		quality = 0,
		limit = 10,
		need_broadcast = 203
};

get(60038) ->
	#data_reward_goods{
		no = 60038,
		good_no = 60181,
		bind_state = 3,
		quality = 0,
		limit = 10,
		need_broadcast = 203
};

get(60039) ->
	#data_reward_goods{
		no = 60039,
		good_no = 62013,
		bind_state = 3,
		quality = 0,
		limit = 10,
		need_broadcast = 203
};

get(60040) ->
	#data_reward_goods{
		no = 60040,
		good_no = 62014,
		bind_state = 3,
		quality = 0,
		limit = 10,
		need_broadcast = 203
};

get(60200) ->
	#data_reward_goods{
		no = 60200,
		good_no = 62033,
		bind_state = 3,
		quality = 0,
		limit = 20,
		need_broadcast = 0
};

get(60201) ->
	#data_reward_goods{
		no = 60201,
		good_no = 62074,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 0
};

get(60202) ->
	#data_reward_goods{
		no = 60202,
		good_no = 72134,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 203
};

get(60203) ->
	#data_reward_goods{
		no = 60203,
		good_no = 72133,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 203
};

get(60204) ->
	#data_reward_goods{
		no = 60204,
		good_no = 72131,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 203
};

get(60205) ->
	#data_reward_goods{
		no = 60205,
		good_no = 72132,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 203
};

get(60206) ->
	#data_reward_goods{
		no = 60206,
		good_no = 62005,
		bind_state = 3,
		quality = 0,
		limit = 20,
		need_broadcast = 0
};

get(60207) ->
	#data_reward_goods{
		no = 60207,
		good_no = 62006,
		bind_state = 3,
		quality = 0,
		limit = 10,
		need_broadcast = 0
};

get(60208) ->
	#data_reward_goods{
		no = 60208,
		good_no = 62007,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 0
};

get(60209) ->
	#data_reward_goods{
		no = 60209,
		good_no = 62008,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 0
};

get(60210) ->
	#data_reward_goods{
		no = 60210,
		good_no = 62009,
		bind_state = 3,
		quality = 0,
		limit = 2,
		need_broadcast = 0
};

get(60211) ->
	#data_reward_goods{
		no = 60211,
		good_no = 62010,
		bind_state = 3,
		quality = 0,
		limit = 2,
		need_broadcast = 0
};

get(60212) ->
	#data_reward_goods{
		no = 60212,
		good_no = 62028,
		bind_state = 3,
		quality = 0,
		limit = 15,
		need_broadcast = 0
};

get(60213) ->
	#data_reward_goods{
		no = 60213,
		good_no = 62029,
		bind_state = 3,
		quality = 0,
		limit = 10,
		need_broadcast = 203
};

get(60214) ->
	#data_reward_goods{
		no = 60214,
		good_no = 62030,
		bind_state = 3,
		quality = 0,
		limit = 7,
		need_broadcast = 203
};

get(60215) ->
	#data_reward_goods{
		no = 60215,
		good_no = 62031,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 203
};

get(60216) ->
	#data_reward_goods{
		no = 60216,
		good_no = 62032,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 203
};

get(60217) ->
	#data_reward_goods{
		no = 60217,
		good_no = 10071,
		bind_state = 3,
		quality = 0,
		limit = 10,
		need_broadcast = 0
};

get(60218) ->
	#data_reward_goods{
		no = 60218,
		good_no = 10072,
		bind_state = 3,
		quality = 0,
		limit = 10,
		need_broadcast = 0
};

get(60219) ->
	#data_reward_goods{
		no = 60219,
		good_no = 10073,
		bind_state = 3,
		quality = 0,
		limit = 10,
		need_broadcast = 0
};

get(60220) ->
	#data_reward_goods{
		no = 60220,
		good_no = 10074,
		bind_state = 3,
		quality = 0,
		limit = 10,
		need_broadcast = 0
};

get(60221) ->
	#data_reward_goods{
		no = 60221,
		good_no = 10075,
		bind_state = 3,
		quality = 0,
		limit = 10,
		need_broadcast = 0
};

get(60222) ->
	#data_reward_goods{
		no = 60222,
		good_no = 10086,
		bind_state = 3,
		quality = 0,
		limit = 10,
		need_broadcast = 0
};

get(60223) ->
	#data_reward_goods{
		no = 60223,
		good_no = 10087,
		bind_state = 3,
		quality = 0,
		limit = 10,
		need_broadcast = 0
};

get(60224) ->
	#data_reward_goods{
		no = 60224,
		good_no = 10088,
		bind_state = 3,
		quality = 0,
		limit = 10,
		need_broadcast = 0
};

get(60225) ->
	#data_reward_goods{
		no = 60225,
		good_no = 10089,
		bind_state = 3,
		quality = 0,
		limit = 10,
		need_broadcast = 0
};

get(60226) ->
	#data_reward_goods{
		no = 60226,
		good_no = 10090,
		bind_state = 3,
		quality = 0,
		limit = 10,
		need_broadcast = 0
};

get(60227) ->
	#data_reward_goods{
		no = 60227,
		good_no = 50366,
		bind_state = 3,
		quality = 0,
		limit = 50,
		need_broadcast = 0
};

get(60228) ->
	#data_reward_goods{
		no = 60228,
		good_no = 50398,
		bind_state = 3,
		quality = 0,
		limit = 10,
		need_broadcast = 203
};

get(60229) ->
	#data_reward_goods{
		no = 60229,
		good_no = 50038,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 0
};

get(60230) ->
	#data_reward_goods{
		no = 60230,
		good_no = 62034,
		bind_state = 3,
		quality = 0,
		limit = 25,
		need_broadcast = 203
};

get(60231) ->
	#data_reward_goods{
		no = 60231,
		good_no = 308101,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 203
};

get(60232) ->
	#data_reward_goods{
		no = 60232,
		good_no = 308151,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 203
};

get(60233) ->
	#data_reward_goods{
		no = 60233,
		good_no = 308201,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 203
};

get(60234) ->
	#data_reward_goods{
		no = 60234,
		good_no = 308251,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 203
};

get(60235) ->
	#data_reward_goods{
		no = 60235,
		good_no = 308301,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 203
};

get(60236) ->
	#data_reward_goods{
		no = 60236,
		good_no = 308351,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 203
};

get(60237) ->
	#data_reward_goods{
		no = 60237,
		good_no = 308103,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 203
};

get(60238) ->
	#data_reward_goods{
		no = 60238,
		good_no = 308153,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 203
};

get(60239) ->
	#data_reward_goods{
		no = 60239,
		good_no = 308104,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 203
};

get(60240) ->
	#data_reward_goods{
		no = 60240,
		good_no = 308154,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 203
};

get(60241) ->
	#data_reward_goods{
		no = 60241,
		good_no = 60177,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 203
};

get(60242) ->
	#data_reward_goods{
		no = 60242,
		good_no = 60178,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 203
};

get(60243) ->
	#data_reward_goods{
		no = 60243,
		good_no = 60179,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 203
};

get(60244) ->
	#data_reward_goods{
		no = 60244,
		good_no = 60180,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 203
};

get(60245) ->
	#data_reward_goods{
		no = 60245,
		good_no = 60181,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 203
};

get(60246) ->
	#data_reward_goods{
		no = 60246,
		good_no = 62161,
		bind_state = 3,
		quality = 0,
		limit = 20,
		need_broadcast = 203
};

get(60247) ->
	#data_reward_goods{
		no = 60247,
		good_no = 62013,
		bind_state = 3,
		quality = 0,
		limit = 25,
		need_broadcast = 203
};

get(60248) ->
	#data_reward_goods{
		no = 60248,
		good_no = 62014,
		bind_state = 3,
		quality = 0,
		limit = 25,
		need_broadcast = 203
};

get(60400) ->
	#data_reward_goods{
		no = 60400,
		good_no = 62008,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 203
};

get(60401) ->
	#data_reward_goods{
		no = 60401,
		good_no = 62009,
		bind_state = 3,
		quality = 0,
		limit = 4,
		need_broadcast = 203
};

get(60402) ->
	#data_reward_goods{
		no = 60402,
		good_no = 62010,
		bind_state = 3,
		quality = 0,
		limit = 2,
		need_broadcast = 203
};

get(60403) ->
	#data_reward_goods{
		no = 60403,
		good_no = 62029,
		bind_state = 3,
		quality = 0,
		limit = 10,
		need_broadcast = 203
};

get(60404) ->
	#data_reward_goods{
		no = 60404,
		good_no = 62030,
		bind_state = 3,
		quality = 0,
		limit = 7,
		need_broadcast = 203
};

get(60405) ->
	#data_reward_goods{
		no = 60405,
		good_no = 62031,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 203
};

get(60406) ->
	#data_reward_goods{
		no = 60406,
		good_no = 62032,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 203
};

get(60407) ->
	#data_reward_goods{
		no = 60407,
		good_no = 50398,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 203
};

get(60408) ->
	#data_reward_goods{
		no = 60408,
		good_no = 62034,
		bind_state = 3,
		quality = 0,
		limit = 25,
		need_broadcast = 203
};

get(60409) ->
	#data_reward_goods{
		no = 60409,
		good_no = 308101,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 203
};

get(60410) ->
	#data_reward_goods{
		no = 60410,
		good_no = 308151,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 203
};

get(60411) ->
	#data_reward_goods{
		no = 60411,
		good_no = 308201,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 203
};

get(60412) ->
	#data_reward_goods{
		no = 60412,
		good_no = 308251,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 203
};

get(60413) ->
	#data_reward_goods{
		no = 60413,
		good_no = 308301,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 203
};

get(60414) ->
	#data_reward_goods{
		no = 60414,
		good_no = 308351,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 203
};

get(60415) ->
	#data_reward_goods{
		no = 60415,
		good_no = 308103,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 203
};

get(60416) ->
	#data_reward_goods{
		no = 60416,
		good_no = 308153,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 203
};

get(60417) ->
	#data_reward_goods{
		no = 60417,
		good_no = 308104,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 203
};

get(60418) ->
	#data_reward_goods{
		no = 60418,
		good_no = 308154,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 203
};

get(60419) ->
	#data_reward_goods{
		no = 60419,
		good_no = 60177,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 203
};

get(60420) ->
	#data_reward_goods{
		no = 60420,
		good_no = 60178,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 203
};

get(60421) ->
	#data_reward_goods{
		no = 60421,
		good_no = 60179,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 203
};

get(60422) ->
	#data_reward_goods{
		no = 60422,
		good_no = 60180,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 203
};

get(60423) ->
	#data_reward_goods{
		no = 60423,
		good_no = 60181,
		bind_state = 3,
		quality = 0,
		limit = 5,
		need_broadcast = 203
};

get(60424) ->
	#data_reward_goods{
		no = 60424,
		good_no = 62161,
		bind_state = 3,
		quality = 0,
		limit = 30,
		need_broadcast = 203
};

get(60701) ->
	#data_reward_goods{
		no = 60701,
		good_no = 7001,
		bind_state = 2,
		quality = 0,
		limit = 0,
		need_broadcast = 0
};

get(60702) ->
	#data_reward_goods{
		no = 60702,
		good_no = 7002,
		bind_state = 2,
		quality = 0,
		limit = 0,
		need_broadcast = 0
};

get(_No) ->
				?WARNING_MSG("Cannot get ~p", [_No]),
          null.

