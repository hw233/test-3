%%%---------------------------------------
%%% @Module  : data_reward_pool
%%% @Author  : liuzz
%%% @Email   :
%%% @Description: 奖励池配置数据
%%%---------------------------------------


-module(data_reward_pool).
-export([get_ids/0, get/1]).
-include("reward.hrl").
-include("debug.hrl").

get_ids()->
	[10000,10001,10002,10003,10004,10007,10008,10009,10010,10011,10012,10013,10014,10015,10016,10017,10018,21000,21001,21002,21003,21004,60001,60002,60003,60004,60005,60006,60007,60008,60009,60010,60011,60012,60013,60014,60015,60016,60017,60018,60019,60020,60021,60022,60023,60024,60025,60026,60027,60028,60029,60030,60031,60032,60033,60034,60035,60036,60037,60038,60039,60040,60200,60201,60202,60203,60204,60205,60206,60207,60208,60209,60210,60211,60212,60213,60214,60215,60216,60217,60218,60219,60220,60221,60222,60223,60224,60225,60226,60227,60228,60229,60230,60231,60232,60233,60234,60235,60236,60237,60238,60239,60240,60241,60242,60243,60244,60245,60246,60247,60248,60400,60401,60402,60403,60404,60405,60406,60407,60408,60409,60410,60411,60412,60413,60414,60415,60416,60417,60418,60419,60420,60421,60422,60423,60424].

get(10000) ->
	#data_reward_pool{
		no = 10000,
		goods_pools = [{50000,1}],
		prob = 1,
		reward_bag = 46054,
		period = 3,
		renews = [{1,20,20}, {2,1,20}, {4,5,20}]
};

get(10001) ->
	#data_reward_pool{
		no = 10001,
		goods_pools = [{50001,1}],
		prob = 1,
		reward_bag = 46054,
		period = 3,
		renews = [{1,20,20}, {2,2,20}, {4,5,20}]
};

get(10002) ->
	#data_reward_pool{
		no = 10002,
		goods_pools = [{50002,1}],
		prob = 1,
		reward_bag = 46054,
		period = 3,
		renews = [{1,20,20}, {2,3,20}, {4,5,20}]
};

get(10003) ->
	#data_reward_pool{
		no = 10003,
		goods_pools = [{50003,1}],
		prob = 1,
		reward_bag = 46054,
		period = 3,
		renews = [{1,20,20}, {2,4,20}, {4,6,20}]
};

get(10004) ->
	#data_reward_pool{
		no = 10004,
		goods_pools = [{50004,1}],
		prob = 1,
		reward_bag = 46054,
		period = 3,
		renews = [{1,20,20}, {2,5,20}, {4,6,20}]
};

get(10007) ->
	#data_reward_pool{
		no = 10007,
		goods_pools = [{50007,1}],
		prob = 1,
		reward_bag = 46050,
		period = 2,
		renews = [{04,01}, {13,20}, {21,30}]
};

get(10008) ->
	#data_reward_pool{
		no = 10008,
		goods_pools = [{50008,1}],
		prob = 1,
		reward_bag = 46051,
		period = 2,
		renews = [{2,40}, {12,20}, {22,30}]
};

get(10009) ->
	#data_reward_pool{
		no = 10009,
		goods_pools = [{50009,1}],
		prob = 1,
		reward_bag = 46051,
		period = 2,
		renews = [{3,40}, {11,20}, {21,30}]
};

get(10010) ->
	#data_reward_pool{
		no = 10010,
		goods_pools = [{50010,1}],
		prob = 1,
		reward_bag = 46051,
		period = 2,
		renews = [{1,40}, {10,20}, {19,30}]
};

get(10011) ->
	#data_reward_pool{
		no = 10011,
		goods_pools = [{50011,1}],
		prob = 1,
		reward_bag = 46051,
		period = 2,
		renews = [{5,40}, {9,20}, {18,30}]
};

get(10012) ->
	#data_reward_pool{
		no = 10012,
		goods_pools = [{50012,1}],
		prob = 1,
		reward_bag = 46051,
		period = 2,
		renews = [{5,40}, {9,20}, {18,30}]
};

get(10013) ->
	#data_reward_pool{
		no = 10013,
		goods_pools = [{50013,1}],
		prob = 1,
		reward_bag = 46051,
		period = 2,
		renews = [{5,40}, {9,20}, {18,30}]
};

get(10014) ->
	#data_reward_pool{
		no = 10014,
		goods_pools = [{50014,1}],
		prob = 1,
		reward_bag = 46062,
		period = 2,
		renews = [{6,40}, {10,20}, {19,30}]
};

get(10015) ->
	#data_reward_pool{
		no = 10015,
		goods_pools = [{50015,1}],
		prob = 1,
		reward_bag = 46062,
		period = 2,
		renews = [{7,40}, {11,20}, {20,30}]
};

get(10016) ->
	#data_reward_pool{
		no = 10016,
		goods_pools = [{50016,1}],
		prob = 1,
		reward_bag = 46062,
		period = 2,
		renews = [{9,40}, {12,20}, {21,30}]
};

get(10017) ->
	#data_reward_pool{
		no = 10017,
		goods_pools = [{50017,1}],
		prob = 1,
		reward_bag = 46062,
		period = 2,
		renews = [{10,40}, {23,20}, {20,30}]
};

get(10018) ->
	#data_reward_pool{
		no = 10018,
		goods_pools = [{50018,1}],
		prob = 1,
		reward_bag = 46062,
		period = 2,
		renews = [{11,40}, {2,20}, {4,30}]
};

get(21000) ->
	#data_reward_pool{
		no = 21000,
		goods_pools = [{60001,50},{60002,25},{60003,20},{60004,20},{60005,20},{60006,20},{60007,50},{60008,40},{60009,35},{60010,30},{60011,30},{60012,20},{60013,15},{60014,10},{60015,50},{60016,30},{60017,20},{60018,15},{60019,50},{60020,25},{60021,25},{60022,25},{60023,25},{60024,25},{60025,25},{60026,25},{60027,25},{60028,25},{60029,25},{60030,25},{60031,50},{60032,25},{60033,25},{60034,10},{60035,10},{60036,10},{60037,10},{60038,10},{60039,10},{60040,10}],
		prob = 1,
		reward_bag = 90000,
		period = 3,
		renews = [{2,3,20}]
};

get(21001) ->
	#data_reward_pool{
		no = 21001,
		goods_pools = [{60200,20},{60201,5},{60202,5},{60203,5},{60204,5},{60205,5},{60206,20},{60207,10},{60208,5},{60209,5},{60210,2},{60211,2},{60212,15},{60213,10},{60214,7},{60215,5},{60216,5},{60217,10},{60218,10},{60219,10},{60220,10},{60221,10},{60222,10},{60223,10},{60224,10},{60225,10},{60226,10},{60227,50},{60228,10},{60229,5},{60230,25},{60231,5},{60232,5},{60233,5},{60234,5},{60235,5},{60236,5},{60237,5},{60238,5},{60239,5},{60240,5},{60241,5},{60242,5},{60243,5},{60244,5},{60245,5},{60246,5},{60247,25},{60248,25}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(21002) ->
	#data_reward_pool{
		no = 21002,
		goods_pools = [{60400,7},{60401,5},{60402,5},{60403,5},{60404,25},{60405,5},{60406,5},{60407,5},{60408,5},{60409,5},{60410,5},{60411,5},{60412,5},{60413,5},{60414,5},{60415,5},{60416,5},{60417,5},{60418,5},{60419,5},{60420,5},{60421,5},{60422,5},{60423,5},{60424,5}],
		prob = 1,
		reward_bag = 90002,
		period = 3,
		renews = [{2,3,20}]
};

get(21003) ->
	#data_reward_pool{
		no = 21003,
		goods_pools = [{60701,1}],
		prob = 1,
		reward_bag = 41584,
		period = 3,
		renews = [{2,3,20}]
};

get(21004) ->
	#data_reward_pool{
		no = 21004,
		goods_pools = [{60702,1}],
		prob = 1,
		reward_bag = 41585,
		period = 3,
		renews = [{2,3,20}]
};

get(60001) ->
	#data_reward_pool{
		no = 60001,
		goods_pools = [{60001,50}],
		prob = 1,
		reward_bag = 90000,
		period = 3,
		renews = [{2,3,20}]
};

get(60002) ->
	#data_reward_pool{
		no = 60002,
		goods_pools = [{60002,25}],
		prob = 1,
		reward_bag = 90000,
		period = 3,
		renews = [{2,3,20}]
};

get(60003) ->
	#data_reward_pool{
		no = 60003,
		goods_pools = [{60003,20}],
		prob = 1,
		reward_bag = 90000,
		period = 3,
		renews = [{2,3,20}]
};

get(60004) ->
	#data_reward_pool{
		no = 60004,
		goods_pools = [{60004,20}],
		prob = 1,
		reward_bag = 90000,
		period = 3,
		renews = [{2,3,20}]
};

get(60005) ->
	#data_reward_pool{
		no = 60005,
		goods_pools = [{60005,20}],
		prob = 1,
		reward_bag = 90000,
		period = 3,
		renews = [{2,3,20}]
};

get(60006) ->
	#data_reward_pool{
		no = 60006,
		goods_pools = [{60006,20}],
		prob = 1,
		reward_bag = 90000,
		period = 3,
		renews = [{2,3,20}]
};

get(60007) ->
	#data_reward_pool{
		no = 60007,
		goods_pools = [{60007,50}],
		prob = 1,
		reward_bag = 90000,
		period = 3,
		renews = [{2,3,20}]
};

get(60008) ->
	#data_reward_pool{
		no = 60008,
		goods_pools = [{60008,40}],
		prob = 1,
		reward_bag = 90000,
		period = 3,
		renews = [{2,3,20}]
};

get(60009) ->
	#data_reward_pool{
		no = 60009,
		goods_pools = [{60009,35}],
		prob = 1,
		reward_bag = 90000,
		period = 3,
		renews = [{2,3,20}]
};

get(60010) ->
	#data_reward_pool{
		no = 60010,
		goods_pools = [{60010,30}],
		prob = 1,
		reward_bag = 90000,
		period = 3,
		renews = [{2,3,20}]
};

get(60011) ->
	#data_reward_pool{
		no = 60011,
		goods_pools = [{60011,30}],
		prob = 1,
		reward_bag = 90000,
		period = 3,
		renews = [{2,3,20}]
};

get(60012) ->
	#data_reward_pool{
		no = 60012,
		goods_pools = [{60012,20}],
		prob = 1,
		reward_bag = 90000,
		period = 3,
		renews = [{2,3,20}]
};

get(60013) ->
	#data_reward_pool{
		no = 60013,
		goods_pools = [{60013,15}],
		prob = 1,
		reward_bag = 90000,
		period = 3,
		renews = [{2,3,20}]
};

get(60014) ->
	#data_reward_pool{
		no = 60014,
		goods_pools = [{60014,10}],
		prob = 1,
		reward_bag = 90000,
		period = 3,
		renews = [{2,3,20}]
};

get(60015) ->
	#data_reward_pool{
		no = 60015,
		goods_pools = [{60015,50}],
		prob = 1,
		reward_bag = 90000,
		period = 3,
		renews = [{2,3,20}]
};

get(60016) ->
	#data_reward_pool{
		no = 60016,
		goods_pools = [{60016,30}],
		prob = 1,
		reward_bag = 90000,
		period = 3,
		renews = [{2,3,20}]
};

get(60017) ->
	#data_reward_pool{
		no = 60017,
		goods_pools = [{60017,20}],
		prob = 1,
		reward_bag = 90000,
		period = 3,
		renews = [{2,3,20}]
};

get(60018) ->
	#data_reward_pool{
		no = 60018,
		goods_pools = [{60018,15}],
		prob = 1,
		reward_bag = 90000,
		period = 3,
		renews = [{2,3,20}]
};

get(60019) ->
	#data_reward_pool{
		no = 60019,
		goods_pools = [{60019,50}],
		prob = 1,
		reward_bag = 90000,
		period = 3,
		renews = [{2,3,20}]
};

get(60020) ->
	#data_reward_pool{
		no = 60020,
		goods_pools = [{60020,25}],
		prob = 1,
		reward_bag = 90000,
		period = 3,
		renews = [{2,3,20}]
};

get(60021) ->
	#data_reward_pool{
		no = 60021,
		goods_pools = [{60021,25}],
		prob = 1,
		reward_bag = 90000,
		period = 3,
		renews = [{2,3,20}]
};

get(60022) ->
	#data_reward_pool{
		no = 60022,
		goods_pools = [{60022,25}],
		prob = 1,
		reward_bag = 90000,
		period = 3,
		renews = [{2,3,20}]
};

get(60023) ->
	#data_reward_pool{
		no = 60023,
		goods_pools = [{60023,25}],
		prob = 1,
		reward_bag = 90000,
		period = 3,
		renews = [{2,3,20}]
};

get(60024) ->
	#data_reward_pool{
		no = 60024,
		goods_pools = [{60024,25}],
		prob = 1,
		reward_bag = 90000,
		period = 3,
		renews = [{2,3,20}]
};

get(60025) ->
	#data_reward_pool{
		no = 60025,
		goods_pools = [{60025,25}],
		prob = 1,
		reward_bag = 90000,
		period = 3,
		renews = [{2,3,20}]
};

get(60026) ->
	#data_reward_pool{
		no = 60026,
		goods_pools = [{60026,25}],
		prob = 1,
		reward_bag = 90000,
		period = 3,
		renews = [{2,3,20}]
};

get(60027) ->
	#data_reward_pool{
		no = 60027,
		goods_pools = [{60027,25}],
		prob = 1,
		reward_bag = 90000,
		period = 3,
		renews = [{2,3,20}]
};

get(60028) ->
	#data_reward_pool{
		no = 60028,
		goods_pools = [{60028,25}],
		prob = 1,
		reward_bag = 90000,
		period = 3,
		renews = [{2,3,20}]
};

get(60029) ->
	#data_reward_pool{
		no = 60029,
		goods_pools = [{60029,25}],
		prob = 1,
		reward_bag = 90000,
		period = 3,
		renews = [{2,3,20}]
};

get(60030) ->
	#data_reward_pool{
		no = 60030,
		goods_pools = [{60030,25}],
		prob = 1,
		reward_bag = 90000,
		period = 3,
		renews = [{2,3,20}]
};

get(60031) ->
	#data_reward_pool{
		no = 60031,
		goods_pools = [{60031,50}],
		prob = 1,
		reward_bag = 90000,
		period = 3,
		renews = [{2,3,20}]
};

get(60032) ->
	#data_reward_pool{
		no = 60032,
		goods_pools = [{60032,25}],
		prob = 1,
		reward_bag = 90000,
		period = 3,
		renews = [{2,3,20}]
};

get(60033) ->
	#data_reward_pool{
		no = 60033,
		goods_pools = [{60033,25}],
		prob = 1,
		reward_bag = 90000,
		period = 3,
		renews = [{2,3,20}]
};

get(60034) ->
	#data_reward_pool{
		no = 60034,
		goods_pools = [{60034,10}],
		prob = 1,
		reward_bag = 90000,
		period = 3,
		renews = [{2,3,20}]
};

get(60035) ->
	#data_reward_pool{
		no = 60035,
		goods_pools = [{60035,10}],
		prob = 1,
		reward_bag = 90000,
		period = 3,
		renews = [{2,3,20}]
};

get(60036) ->
	#data_reward_pool{
		no = 60036,
		goods_pools = [{60036,10}],
		prob = 1,
		reward_bag = 90000,
		period = 3,
		renews = [{2,3,20}]
};

get(60037) ->
	#data_reward_pool{
		no = 60037,
		goods_pools = [{60037,10}],
		prob = 1,
		reward_bag = 90000,
		period = 3,
		renews = [{2,3,20}]
};

get(60038) ->
	#data_reward_pool{
		no = 60038,
		goods_pools = [{60038,10}],
		prob = 1,
		reward_bag = 90000,
		period = 3,
		renews = [{2,3,20}]
};

get(60039) ->
	#data_reward_pool{
		no = 60039,
		goods_pools = [{60039,10}],
		prob = 1,
		reward_bag = 90000,
		period = 3,
		renews = [{2,3,20}]
};

get(60040) ->
	#data_reward_pool{
		no = 60040,
		goods_pools = [{60040,10}],
		prob = 1,
		reward_bag = 90000,
		period = 3,
		renews = [{2,3,20}]
};

get(60200) ->
	#data_reward_pool{
		no = 60200,
		goods_pools = [{60200,20}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60201) ->
	#data_reward_pool{
		no = 60201,
		goods_pools = [{60201,5}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60202) ->
	#data_reward_pool{
		no = 60202,
		goods_pools = [{60202,5}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60203) ->
	#data_reward_pool{
		no = 60203,
		goods_pools = [{60203,5}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60204) ->
	#data_reward_pool{
		no = 60204,
		goods_pools = [{60204,5}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60205) ->
	#data_reward_pool{
		no = 60205,
		goods_pools = [{60205,5}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60206) ->
	#data_reward_pool{
		no = 60206,
		goods_pools = [{60206,20}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60207) ->
	#data_reward_pool{
		no = 60207,
		goods_pools = [{60207,10}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60208) ->
	#data_reward_pool{
		no = 60208,
		goods_pools = [{60208,5}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60209) ->
	#data_reward_pool{
		no = 60209,
		goods_pools = [{60209,5}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60210) ->
	#data_reward_pool{
		no = 60210,
		goods_pools = [{60210,2}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60211) ->
	#data_reward_pool{
		no = 60211,
		goods_pools = [{60211,2}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60212) ->
	#data_reward_pool{
		no = 60212,
		goods_pools = [{60212,15}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60213) ->
	#data_reward_pool{
		no = 60213,
		goods_pools = [{60213,10}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60214) ->
	#data_reward_pool{
		no = 60214,
		goods_pools = [{60214,7}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60215) ->
	#data_reward_pool{
		no = 60215,
		goods_pools = [{60215,5}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60216) ->
	#data_reward_pool{
		no = 60216,
		goods_pools = [{60216,5}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60217) ->
	#data_reward_pool{
		no = 60217,
		goods_pools = [{60217,10}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60218) ->
	#data_reward_pool{
		no = 60218,
		goods_pools = [{60218,10}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60219) ->
	#data_reward_pool{
		no = 60219,
		goods_pools = [{60219,10}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60220) ->
	#data_reward_pool{
		no = 60220,
		goods_pools = [{60220,10}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60221) ->
	#data_reward_pool{
		no = 60221,
		goods_pools = [{60221,10}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60222) ->
	#data_reward_pool{
		no = 60222,
		goods_pools = [{60222,10}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60223) ->
	#data_reward_pool{
		no = 60223,
		goods_pools = [{60223,10}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60224) ->
	#data_reward_pool{
		no = 60224,
		goods_pools = [{60224,10}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60225) ->
	#data_reward_pool{
		no = 60225,
		goods_pools = [{60225,10}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60226) ->
	#data_reward_pool{
		no = 60226,
		goods_pools = [{60226,10}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60227) ->
	#data_reward_pool{
		no = 60227,
		goods_pools = [{60227,50}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60228) ->
	#data_reward_pool{
		no = 60228,
		goods_pools = [{60228,10}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60229) ->
	#data_reward_pool{
		no = 60229,
		goods_pools = [{60229,5}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60230) ->
	#data_reward_pool{
		no = 60230,
		goods_pools = [{60230,25}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60231) ->
	#data_reward_pool{
		no = 60231,
		goods_pools = [{60231,5}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60232) ->
	#data_reward_pool{
		no = 60232,
		goods_pools = [{60232,5}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60233) ->
	#data_reward_pool{
		no = 60233,
		goods_pools = [{60233,5}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60234) ->
	#data_reward_pool{
		no = 60234,
		goods_pools = [{60234,5}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60235) ->
	#data_reward_pool{
		no = 60235,
		goods_pools = [{60235,5}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60236) ->
	#data_reward_pool{
		no = 60236,
		goods_pools = [{60236,5}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60237) ->
	#data_reward_pool{
		no = 60237,
		goods_pools = [{60237,5}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60238) ->
	#data_reward_pool{
		no = 60238,
		goods_pools = [{60238,5}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60239) ->
	#data_reward_pool{
		no = 60239,
		goods_pools = [{60239,5}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60240) ->
	#data_reward_pool{
		no = 60240,
		goods_pools = [{60240,5}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60241) ->
	#data_reward_pool{
		no = 60241,
		goods_pools = [{60241,5}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60242) ->
	#data_reward_pool{
		no = 60242,
		goods_pools = [{60242,5}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60243) ->
	#data_reward_pool{
		no = 60243,
		goods_pools = [{60243,5}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60244) ->
	#data_reward_pool{
		no = 60244,
		goods_pools = [{60244,5}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60245) ->
	#data_reward_pool{
		no = 60245,
		goods_pools = [{60245,5}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60246) ->
	#data_reward_pool{
		no = 60246,
		goods_pools = [{60246,5}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60247) ->
	#data_reward_pool{
		no = 60247,
		goods_pools = [{60247,25}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60248) ->
	#data_reward_pool{
		no = 60248,
		goods_pools = [{60248,25}],
		prob = 1,
		reward_bag = 90001,
		period = 3,
		renews = [{2,3,20}]
};

get(60400) ->
	#data_reward_pool{
		no = 60400,
		goods_pools = [{60400,7}],
		prob = 1,
		reward_bag = 90002,
		period = 3,
		renews = [{2,3,20}]
};

get(60401) ->
	#data_reward_pool{
		no = 60401,
		goods_pools = [{60401,5}],
		prob = 1,
		reward_bag = 90002,
		period = 3,
		renews = [{2,3,20}]
};

get(60402) ->
	#data_reward_pool{
		no = 60402,
		goods_pools = [{60402,5}],
		prob = 1,
		reward_bag = 90002,
		period = 3,
		renews = [{2,3,20}]
};

get(60403) ->
	#data_reward_pool{
		no = 60403,
		goods_pools = [{60403,5}],
		prob = 1,
		reward_bag = 90002,
		period = 3,
		renews = [{2,3,20}]
};

get(60404) ->
	#data_reward_pool{
		no = 60404,
		goods_pools = [{60404,25}],
		prob = 1,
		reward_bag = 90002,
		period = 3,
		renews = [{2,3,20}]
};

get(60405) ->
	#data_reward_pool{
		no = 60405,
		goods_pools = [{60405,5}],
		prob = 1,
		reward_bag = 90002,
		period = 3,
		renews = [{2,3,20}]
};

get(60406) ->
	#data_reward_pool{
		no = 60406,
		goods_pools = [{60406,5}],
		prob = 1,
		reward_bag = 90002,
		period = 3,
		renews = [{2,3,20}]
};

get(60407) ->
	#data_reward_pool{
		no = 60407,
		goods_pools = [{60407,5}],
		prob = 1,
		reward_bag = 90002,
		period = 3,
		renews = [{2,3,20}]
};

get(60408) ->
	#data_reward_pool{
		no = 60408,
		goods_pools = [{60408,5}],
		prob = 1,
		reward_bag = 90002,
		period = 3,
		renews = [{2,3,20}]
};

get(60409) ->
	#data_reward_pool{
		no = 60409,
		goods_pools = [{60409,5}],
		prob = 1,
		reward_bag = 90002,
		period = 3,
		renews = [{2,3,20}]
};

get(60410) ->
	#data_reward_pool{
		no = 60410,
		goods_pools = [{60410,5}],
		prob = 1,
		reward_bag = 90002,
		period = 3,
		renews = [{2,3,20}]
};

get(60411) ->
	#data_reward_pool{
		no = 60411,
		goods_pools = [{60411,5}],
		prob = 1,
		reward_bag = 90002,
		period = 3,
		renews = [{2,3,20}]
};

get(60412) ->
	#data_reward_pool{
		no = 60412,
		goods_pools = [{60412,5}],
		prob = 1,
		reward_bag = 90002,
		period = 3,
		renews = [{2,3,20}]
};

get(60413) ->
	#data_reward_pool{
		no = 60413,
		goods_pools = [{60413,5}],
		prob = 1,
		reward_bag = 90002,
		period = 3,
		renews = [{2,3,20}]
};

get(60414) ->
	#data_reward_pool{
		no = 60414,
		goods_pools = [{60414,5}],
		prob = 1,
		reward_bag = 90002,
		period = 3,
		renews = [{2,3,20}]
};

get(60415) ->
	#data_reward_pool{
		no = 60415,
		goods_pools = [{60415,5}],
		prob = 1,
		reward_bag = 90002,
		period = 3,
		renews = [{2,3,20}]
};

get(60416) ->
	#data_reward_pool{
		no = 60416,
		goods_pools = [{60416,5}],
		prob = 1,
		reward_bag = 90002,
		period = 3,
		renews = [{2,3,20}]
};

get(60417) ->
	#data_reward_pool{
		no = 60417,
		goods_pools = [{60417,5}],
		prob = 1,
		reward_bag = 90002,
		period = 3,
		renews = [{2,3,20}]
};

get(60418) ->
	#data_reward_pool{
		no = 60418,
		goods_pools = [{60418,5}],
		prob = 1,
		reward_bag = 90002,
		period = 3,
		renews = [{2,3,20}]
};

get(60419) ->
	#data_reward_pool{
		no = 60419,
		goods_pools = [{60419,5}],
		prob = 1,
		reward_bag = 90002,
		period = 3,
		renews = [{2,3,20}]
};

get(60420) ->
	#data_reward_pool{
		no = 60420,
		goods_pools = [{60420,5}],
		prob = 1,
		reward_bag = 90002,
		period = 3,
		renews = [{2,3,20}]
};

get(60421) ->
	#data_reward_pool{
		no = 60421,
		goods_pools = [{60421,5}],
		prob = 1,
		reward_bag = 90002,
		period = 3,
		renews = [{2,3,20}]
};

get(60422) ->
	#data_reward_pool{
		no = 60422,
		goods_pools = [{60422,5}],
		prob = 1,
		reward_bag = 90002,
		period = 3,
		renews = [{2,3,20}]
};

get(60423) ->
	#data_reward_pool{
		no = 60423,
		goods_pools = [{60423,5}],
		prob = 1,
		reward_bag = 90002,
		period = 3,
		renews = [{2,3,20}]
};

get(60424) ->
	#data_reward_pool{
		no = 60424,
		goods_pools = [{60424,5}],
		prob = 1,
		reward_bag = 90002,
		period = 3,
		renews = [{2,3,20}]
};

get(_No) ->
				?WARNING_MSG("Cannot get ~p", [_No]),
          null.

