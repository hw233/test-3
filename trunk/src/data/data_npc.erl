%%%---------------------------------------
%%% @Module  : data_npc
%%% @Author  : zwq
%%% @Email   : 
%%% @Description:  npc
%%%---------------------------------------


-module(data_npc).

-include("npc.hrl").
-include("debug.hrl").
-compile(export_all).

get_all_npc_no_list()->
	[1001,1002,1003,1004,1005,1006,1007,1008,1009,1010,1011,1012,1013,1014,1015,1016,1017,1018,1019,1020,1021,1022,1023,1024,1025,1026,1027,1028,1029,1030,1031,1032,1033,1034,1035,1036,1037,1038,1039,1040,1041,1042,1043,1044,1045,1046,1047,1048,1049,1050,1051,1052,1053,1054,1055,1057,1058,1059,1060,1061,1062,1063,1064,1065,1066,1067,1068,1069,1074,1075,1076,1077,1078,1079,1080,1081,1082,1083,1084,1085,1086,1087,1088,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023,2024,2025,2026,2027,2028,2029,2030,2031,2032,2033,2034,2035,2036,2037,2038,2039,2040,2041,2042,2043,2044,2045,2046,2047,2048,2049,2050,2051,2052,2053,2054,2055,2056,2057,2058,2059,2060,2061,2062,2063,2064,2065,2066,2067,2068,2069,2070,2071,2072,2073,2074,2075,2076,2077,2078,2079,2080,2081,2082,2083,2084,2085,2086,2087,2088,2089,2090,2091,2092,2093,2094,2095,2096,2097,2098,2099,2100,2101,2102,2103,2104,2105,2106,2107,2108,2109,2110,2111,2112,2113,2114,2115,2116,2117,2118,2119,2120,2121,2122,2123,2124,2125,2126,2127,2128,2129,2130,2131,2132,2133,2134,2135,2136,2137,2138,2139,2140,2141,2142,2143,2144,2145,2146,2147,2148,2149,2150,2151,2152,2153,2154,2155,2156,2157,2158,2159,2160,2161,2162,2163,2164,2165,2166,2167,2168,2169,2170,2171,2172,2173,2174,2175,2176,2177,2178,2179,2180,2181,2182,2183,2184,2185,2186,2187,2188,2189,2190,2191,2192,2193,2194,2195,2196,2197,2198,2199,2200,2201,2202,2203,2204,2205,2206,2207,2208,2209,2210,2211,2212,2213,2214,2215,2216,2217,2218,2219,2220,2221,2222,2223,2224,2225,2400,2401,2402,2403,2404,2405,2406,2901,2902,2903,2904,2905,2906,2907,2908,2909,2910,2911,2912,2913,2914,2915,2916,2917,2918,2919,2920,2921,2922,2923,2924,3001,3101,3102,3103,4000,4101,4701,5001,5002,5003,5004,5005,5006,5007,5008,5009,5010,5011,5012,5013,5014,5015,5016,5017,5018,5019,5020,5021,5022,5023,5024,5025,5026,5027,5028,5029,5030,5031,5032,5033,5034,5035,5036,5037,5038,5039,5040,5041,5500,5501,5502,5503,5504,5800,5801,5900,5901,5902,6001,6002,6003,6004,6100,6101,6102,6103,6104,6105,6106,6107,6108,6109,6301,8001,8002,8003,8004,8005,8006,9000,9001,9002,9003,9004,9005,9006,9007,9008,9009,9093,10001,10002,10003,10004,10005,10006,10007,10008,10009,10010,10011,10012,10013,10014,10015,10016,10017,10018,10019,10020,10021,10022,10023,10030,10031,10032,10033,10034,10035,10036,10037,10038,10039,10040,10041,20001,20002,20003,20004,20005,20006,20007,20008,20009,20010,20011,20012,20013,20014,20015,20016,20017,20018,20019,20020,20021,20022,20023,20024,20025,20026,20027,20028,20029,20030,20031,20032,20033,20034,20035,20036,20037,20038,20039,20040,20041,20042,20043,20044,20045,20046,20047,20048,20049,20050,20051,20052,20053,20054,20055,20056,20057,20058,20059,20060,20061,20062,20063,20064,20065,20066,20067,20068,20069,20070,20071,20072,20073,20074,20075,20076,20077,20078,20079,20080,20081,20082,20083,20084,20085,20086,20087,20088,20089,20090,20091,20092,20093,20094,20095,20096,20097,20098,20099,20100,20101,20102,20103,20104,20105,20106,20107,20108,20109,20110,20111,20112,20113,20114,20115,20116,20117,20118,20119,20120,20121,20122,20123,20124,20125,20126,20127,20128,20129,20130,20131,20132,20133,20134,20135,20136,20137,20138,20139,20140,20141,20142,20143,20144,20145,20146,20147,20148,20149,20150,20151,20152,20153,20154,20155,20156,20157,20158,20159,20160,20161,20162,20163,20164,20165,20166,20167,20168,20169,20170,20171,20172,20173,20174,20175,20176,20177,30001,30002,30003,30004,30005,30006,30007,30008,30009,30010,30011,30012,30013,30014,30015,30016,30017,30018,30019,30020].

get(5800) ->
	#npc_tpl{
		no = 5800,
		name = <<"赤金宝箱">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 3599,
		func_list = [{open_box, 1}]
};

get(1067) ->
	#npc_tpl{
		no = 1067,
		name = <<"王镖头">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [enter_transport,{trigger_mf,800474,[{has_one_of_unfinished_task,[1300026]}]},{sell_goods,19}, enter_mijing, enter_huanjing
]
};

get(1041) ->
	#npc_tpl{
		no = 1041,
		name = <<"帮派官员">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{teleport, [202]}]
};

get(1016) ->
	#npc_tpl{
		no = 1016,
		name = <<"礼包使者">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [reward_cdkey,{goods_exchange,91},{goods_exchange,90},{goods_exchange,89}]
};

get(1057) ->
	#npc_tpl{
		no = 1057,
		name = <<"传送师">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{teleport, [108,109]},go_back_faction]
};

get(2028) ->
	#npc_tpl{
		no = 2028,
		name = <<"皇城守卫">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [arena_biwu, arena_biwu_3v3, arena_kuafu_3v3, {sell_goods,12},{trigger_mf,2009,[{has_one_of_unfinished_task,[1000810]}]}]
};

get(1017) ->
	#npc_tpl{
		no = 1017,
		name = <<"红娘">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [couple_entry,join_couple_cruise]
};

get(1026) ->
	#npc_tpl{
		no = 1026,
		name = <<"商会老板">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{goods_exchange,32},{goods_exchange,33},{goods_exchange,34}]
};

get(1035) ->
	#npc_tpl{
		no = 1035,
		name = <<"仓库管理员">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 3600*24*60,
		func_list = []
};

get(1031) ->
	#npc_tpl{
		no = 1031,
		name = <<"杂货商人">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{sell_goods, 6}, {trigger_mf,800468,[{has_one_of_unfinished_task,[1300009]}]}]
};

get(1033) ->
	#npc_tpl{
		no = 1033,
		name = <<"妖塔使者">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [tower]
};

get(1018) ->
	#npc_tpl{
		no = 1018,
		name = <<"魔龙使者">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [dragon_boss_enter,boss_rank]
};

get(1020) ->
	#npc_tpl{
		no = 1020,
		name = <<"装备副本使者">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{dungeon,[5051,5052,5053,5054,4001,4002,4003,4004,2031,2032,2033,2034],1}]
};

get(1021) ->
	#npc_tpl{
		no = 1021,
		name = <<"宠物副本使者">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{dungeon,[5051,5052,5053,5054,4001,4002,4003,4004,2031,2032,2033,2034],2}]
};

get(2046) ->
	#npc_tpl{
		no = 2046,
		name = <<"翅膀副本使者">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{dungeon,[5051,5052,5053,5054,4001,4002,4003,4004,2031,2032,2033,2034],3}]
};

get(2031) ->
	#npc_tpl{
		no = 2031,
		name = <<"抓鬼大使">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,800473,[{has_one_of_unfinished_task,[1300025]}]},enter_kuafu]
};

get(1068) ->
	#npc_tpl{
		no = 1068,
		name = <<"宝图使者">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{goods_exchange,1}]
};

get(1022) ->
	#npc_tpl{
		no = 1022,
		name = <<"竞技大使">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [tve_entry,single_tve,{goods_exchange,83}]
};

get(10036) ->
	#npc_tpl{
		no = 10036,
		name = <<"昆仑神鹿">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{goods_exchange,56}]
};

get(10011) ->
	#npc_tpl{
		no = 10011,
		name = <<"熊猫酒圣">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{goods_exchange,22}]
};

get(1029) ->
	#npc_tpl{
		no = 1029,
		name = <<"六尾天狐">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{goods_exchange,2},{goods_exchange,79}]
};

get(10037) ->
	#npc_tpl{
		no = 10037,
		name = <<"赤炎角狮">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{goods_exchange,92}]
};

get(1014) ->
	#npc_tpl{
		no = 1014,
		name = <<"蟠桃盛会使者">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [melee_apply]
};

get(1024) ->
	#npc_tpl{
		no = 1024,
		name = <<"武器商人">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{sell_goods, 7}]
};

get(1025) ->
	#npc_tpl{
		no = 1025,
		name = <<"药店商人">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{sell_goods, 8}]
};

get(1027) ->
	#npc_tpl{
		no = 1027,
		name = <<"防具商人">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{sell_goods, 10}]
};

get(1028) ->
	#npc_tpl{
		no = 1028,
		name = <<"首饰商人">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{sell_goods, 11}]
};

get(1001) ->
	#npc_tpl{
		no = 1001,
		name = <<"玄天宗掌门">>,
		type = 1,
		race = 0,
		faction = 1,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(1002) ->
	#npc_tpl{
		no = 1002,
		name = <<"风清门掌门">>,
		type = 1,
		race = 0,
		faction = 2,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(1003) ->
	#npc_tpl{
		no = 1003,
		name = <<"阎罗殿掌门">>,
		type = 1,
		race = 0,
		faction = 3,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(1004) ->
	#npc_tpl{
		no = 1004,
		name = <<"神医谷掌门">>,
		type = 1,
		race = 0,
		faction = 4,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20001) ->
	#npc_tpl{
		no = 20001,
		name = <<"师门信物">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1000002],50000}]
};

get(20002) ->
	#npc_tpl{
		no = 20002,
		name = <<"师门信物">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1000017],50000}]
};

get(20003) ->
	#npc_tpl{
		no = 20003,
		name = <<"师门信物">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1000032],50000}]
};

get(20004) ->
	#npc_tpl{
		no = 20004,
		name = <<"师门信物">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1000047],50000}]
};

get(20005) ->
	#npc_tpl{
		no = 20005,
		name = <<"师门信物">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20006) ->
	#npc_tpl{
		no = 20006,
		name = <<"师门信物">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20007) ->
	#npc_tpl{
		no = 20007,
		name = <<"同门师兄">>,
		type = 1,
		race = 0,
		faction = 1,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2097,[{has_one_of_unfinished_task,[1000005]}]}]
};

get(20008) ->
	#npc_tpl{
		no = 20008,
		name = <<"同门师姐">>,
		type = 1,
		race = 0,
		faction = 2,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2098,[{has_one_of_unfinished_task,[1000020]}]}]
};

get(20009) ->
	#npc_tpl{
		no = 20009,
		name = <<"同门师兄">>,
		type = 1,
		race = 0,
		faction = 3,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2099,[{has_one_of_unfinished_task,[1000035]}]}]
};

get(20010) ->
	#npc_tpl{
		no = 20010,
		name = <<"同门师姐">>,
		type = 1,
		race = 0,
		faction = 4,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2100,[{has_one_of_unfinished_task,[1000050]}]}]
};

get(20011) ->
	#npc_tpl{
		no = 20011,
		name = <<"同门师兄">>,
		type = 1,
		race = 0,
		faction = 5,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20012) ->
	#npc_tpl{
		no = 20012,
		name = <<"同门师兄">>,
		type = 1,
		race = 0,
		faction = 6,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20013) ->
	#npc_tpl{
		no = 20013,
		name = <<"童子">>,
		type = 1,
		race = 0,
		faction = 1,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20014) ->
	#npc_tpl{
		no = 20014,
		name = <<"童子">>,
		type = 1,
		race = 0,
		faction = 2,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20015) ->
	#npc_tpl{
		no = 20015,
		name = <<"童子">>,
		type = 1,
		race = 0,
		faction = 3,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20016) ->
	#npc_tpl{
		no = 20016,
		name = <<"童子">>,
		type = 1,
		race = 0,
		faction = 4,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20017) ->
	#npc_tpl{
		no = 20017,
		name = <<"童子">>,
		type = 1,
		race = 0,
		faction = 5,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20018) ->
	#npc_tpl{
		no = 20018,
		name = <<"童子">>,
		type = 1,
		race = 0,
		faction = 6,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20019) ->
	#npc_tpl{
		no = 20019,
		name = <<"白露花">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1000006],50001}]
};

get(20020) ->
	#npc_tpl{
		no = 20020,
		name = <<"白露花">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1000021],50001}]
};

get(20021) ->
	#npc_tpl{
		no = 20021,
		name = <<"白露花">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1000036],50001}]
};

get(20022) ->
	#npc_tpl{
		no = 20022,
		name = <<"白露花">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1000051],50001}]
};

get(20023) ->
	#npc_tpl{
		no = 20023,
		name = <<"白露花">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20024) ->
	#npc_tpl{
		no = 20024,
		name = <<"白露花">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20025) ->
	#npc_tpl{
		no = 20025,
		name = <<"璞玉">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1000009],50003}]
};

get(20026) ->
	#npc_tpl{
		no = 20026,
		name = <<"璞玉">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1000024],50003}]
};

get(20027) ->
	#npc_tpl{
		no = 20027,
		name = <<"璞玉">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1000039],50003}]
};

get(20028) ->
	#npc_tpl{
		no = 20028,
		name = <<"璞玉">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1000054],50003}]
};

get(20029) ->
	#npc_tpl{
		no = 20029,
		name = <<"璞玉">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20030) ->
	#npc_tpl{
		no = 20030,
		name = <<"璞玉">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20031) ->
	#npc_tpl{
		no = 20031,
		name = <<"雪参">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1000011],50005}]
};

get(20032) ->
	#npc_tpl{
		no = 20032,
		name = <<"雪参">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1000026],50005}]
};

get(20033) ->
	#npc_tpl{
		no = 20033,
		name = <<"雪参">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1000041],50005}]
};

get(20034) ->
	#npc_tpl{
		no = 20034,
		name = <<"雪参">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1000056],50005}]
};

get(20035) ->
	#npc_tpl{
		no = 20035,
		name = <<"雪参">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20036) ->
	#npc_tpl{
		no = 20036,
		name = <<"雪参">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20037) ->
	#npc_tpl{
		no = 20037,
		name = <<"灵芝">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1000012],50006}]
};

get(20038) ->
	#npc_tpl{
		no = 20038,
		name = <<"灵芝">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1000027],50006}]
};

get(20039) ->
	#npc_tpl{
		no = 20039,
		name = <<"灵芝">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1000042],50006}]
};

get(20040) ->
	#npc_tpl{
		no = 20040,
		name = <<"灵芝">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1000057],50006}]
};

get(20041) ->
	#npc_tpl{
		no = 20041,
		name = <<"灵芝">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20042) ->
	#npc_tpl{
		no = 20042,
		name = <<"灵芝">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20043) ->
	#npc_tpl{
		no = 20043,
		name = <<"丹砂">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1000013],50007}]
};

get(20044) ->
	#npc_tpl{
		no = 20044,
		name = <<"丹砂">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1000028],50007}]
};

get(20045) ->
	#npc_tpl{
		no = 20045,
		name = <<"丹砂">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1000043],50007}]
};

get(20046) ->
	#npc_tpl{
		no = 20046,
		name = <<"丹砂">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1000058],50007}]
};

get(20047) ->
	#npc_tpl{
		no = 20047,
		name = <<"丹砂">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20048) ->
	#npc_tpl{
		no = 20048,
		name = <<"丹砂">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20049) ->
	#npc_tpl{
		no = 20049,
		name = <<"妇人">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20050) ->
	#npc_tpl{
		no = 20050,
		name = <<"幼童">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20051) ->
	#npc_tpl{
		no = 20051,
		name = <<"魔猪">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2004,[{has_one_of_unfinished_task,[1000450]}]}]
};

get(20052) ->
	#npc_tpl{
		no = 20052,
		name = <<"云游天师">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20053) ->
	#npc_tpl{
		no = 20053,
		name = <<"叶仙的踪迹">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20054) ->
	#npc_tpl{
		no = 20054,
		name = <<"员外">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20055) ->
	#npc_tpl{
		no = 20055,
		name = <<"叶仙的踪迹">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20056) ->
	#npc_tpl{
		no = 20056,
		name = <<"叶仙">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2005,[{has_one_of_unfinished_task,[1000530]}]}]
};

get(20057) ->
	#npc_tpl{
		no = 20057,
		name = <<"打斗痕迹">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20058) ->
	#npc_tpl{
		no = 20058,
		name = <<"破碎的长剑">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20059) ->
	#npc_tpl{
		no = 20059,
		name = <<"血迹">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20060) ->
	#npc_tpl{
		no = 20060,
		name = <<"小徒">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20061) ->
	#npc_tpl{
		no = 20061,
		name = <<"药草">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1000600],50008}]
};

get(20062) ->
	#npc_tpl{
		no = 20062,
		name = <<"雪猿">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2006,[{has_one_of_unfinished_task,[1000650]}]}]
};

get(20063) ->
	#npc_tpl{
		no = 20063,
		name = <<"雪猿毛">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1000660],50009}]
};

get(20064) ->
	#npc_tpl{
		no = 20064,
		name = <<"雪猿血">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1000670],50010}]
};

get(20065) ->
	#npc_tpl{
		no = 20065,
		name = <<"书生">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20066) ->
	#npc_tpl{
		no = 20066,
		name = <<"舍神">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20067) ->
	#npc_tpl{
		no = 20067,
		name = <<"红袖">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20068) ->
	#npc_tpl{
		no = 20068,
		name = <<"弟子">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2007,[{has_one_of_unfinished_task,[1000750]}]}]
};

get(20069) ->
	#npc_tpl{
		no = 20069,
		name = <<"火石">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1000760],50012}]
};

get(20070) ->
	#npc_tpl{
		no = 20070,
		name = <<"阳石">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1000770],50013}]
};

get(20071) ->
	#npc_tpl{
		no = 20071,
		name = <<"叶石">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1000780],50014}]
};

get(20072) ->
	#npc_tpl{
		no = 20072,
		name = <<"小萌">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2011,[{has_one_of_unfinished_task,[1000920]}]}]
};

get(20073) ->
	#npc_tpl{
		no = 20073,
		name = <<"树妖">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2008,[{has_one_of_unfinished_task,[1000820]}]}]
};

get(20074) ->
	#npc_tpl{
		no = 20074,
		name = <<"灵狐">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2009,[{has_one_of_unfinished_task,[1000830]}]}]
};

get(20075) ->
	#npc_tpl{
		no = 20075,
		name = <<"雪莲">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1000840],50016}]
};

get(20076) ->
	#npc_tpl{
		no = 20076,
		name = <<"仙草">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1000860,1000910],50017}]
};

get(20077) ->
	#npc_tpl{
		no = 20077,
		name = <<"灵石">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1000880],50018}]
};

get(20078) ->
	#npc_tpl{
		no = 20078,
		name = <<"石像鬼">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2010,[{has_one_of_unfinished_task,[1000900]}]}]
};

get(20079) ->
	#npc_tpl{
		no = 20079,
		name = <<"蝴蝶精的踪迹">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20080) ->
	#npc_tpl{
		no = 20080,
		name = <<"蝴蝶精">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2012,[{has_one_of_unfinished_task,[1001010]}]}]
};

get(20081) ->
	#npc_tpl{
		no = 20081,
		name = <<"玉笛">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1001020],50020}]
};

get(20082) ->
	#npc_tpl{
		no = 20082,
		name = <<"天狼的踪迹">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20083) ->
	#npc_tpl{
		no = 20083,
		name = <<"天狼">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2013,[{has_one_of_unfinished_task,[1001040]}]}]
};

get(20084) ->
	#npc_tpl{
		no = 20084,
		name = <<"风晶石">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1001050],50021}]
};

get(20085) ->
	#npc_tpl{
		no = 20085,
		name = <<"夜叉女的踪迹">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20086) ->
	#npc_tpl{
		no = 20086,
		name = <<"夜叉女">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2014,[{has_one_of_unfinished_task,[1001070]}]}]
};

get(20087) ->
	#npc_tpl{
		no = 20087,
		name = <<"水晶石">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1001080],50022}]
};

get(20088) ->
	#npc_tpl{
		no = 20088,
		name = <<"侏儒怪的踪迹">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20089) ->
	#npc_tpl{
		no = 20089,
		name = <<"侏儒怪">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2015,[{has_one_of_unfinished_task,[1001110]}]}]
};

get(20090) ->
	#npc_tpl{
		no = 20090,
		name = <<"妖灵石">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1001120],50023}]
};

get(20091) ->
	#npc_tpl{
		no = 20091,
		name = <<"野猪怪的踪迹">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20092) ->
	#npc_tpl{
		no = 20092,
		name = <<"野猪怪">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2016,[{has_one_of_unfinished_task,[1001140]}]}]
};

get(20093) ->
	#npc_tpl{
		no = 20093,
		name = <<"土灵石">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1001150],50024}]
};

get(20094) ->
	#npc_tpl{
		no = 20094,
		name = <<"鬼精灵的踪迹">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20095) ->
	#npc_tpl{
		no = 20095,
		name = <<"鬼精灵">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2017,[{has_one_of_unfinished_task,[1001170]}]}]
};

get(20096) ->
	#npc_tpl{
		no = 20096,
		name = <<"魔力种子">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1001180],50025}]
};

get(20097) ->
	#npc_tpl{
		no = 20097,
		name = <<"妖族使者的踪迹">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20098) ->
	#npc_tpl{
		no = 20098,
		name = <<"妖族使者">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2018,[{has_one_of_unfinished_task,[1001210]}]}]
};

get(20099) ->
	#npc_tpl{
		no = 20099,
		name = <<"通灵盘">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1001220],50026}]
};

get(20100) ->
	#npc_tpl{
		no = 20100,
		name = <<"象怪的踪迹">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20101) ->
	#npc_tpl{
		no = 20101,
		name = <<"象怪">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2019,[{has_one_of_unfinished_task,[1001240]}]}]
};

get(20102) ->
	#npc_tpl{
		no = 20102,
		name = <<"血滴玉">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1001250],50027}]
};

get(20103) ->
	#npc_tpl{
		no = 20103,
		name = <<"古藤妖的踪迹">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20104) ->
	#npc_tpl{
		no = 20104,
		name = <<"古藤妖">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2020,[{has_one_of_unfinished_task,[1001270]}]}]
};

get(20105) ->
	#npc_tpl{
		no = 20105,
		name = <<"元灵玉">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1001280],50028}]
};

get(20106) ->
	#npc_tpl{
		no = 20106,
		name = <<"绿魔">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20107) ->
	#npc_tpl{
		no = 20107,
		name = <<"暴走雪猿">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2021,[{has_one_of_unfinished_task,[1001360]}]}]
};

get(20108) ->
	#npc_tpl{
		no = 20108,
		name = <<"暴走灵狐">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2022,[{has_one_of_unfinished_task,[1001370]}]}]
};

get(20109) ->
	#npc_tpl{
		no = 20109,
		name = <<"暴走战熊">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2023,[{has_one_of_unfinished_task,[1001380]}]}]
};

get(20110) ->
	#npc_tpl{
		no = 20110,
		name = <<"石甲怪">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2024,[{has_one_of_unfinished_task,[1001430]}]}]
};

get(20111) ->
	#npc_tpl{
		no = 20111,
		name = <<"稻草人">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2025,[{has_one_of_unfinished_task,[1001440]}]}]
};

get(20112) ->
	#npc_tpl{
		no = 20112,
		name = <<"石像鬼">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2026,[{has_one_of_unfinished_task,[1001450]}]}]
};

get(20113) ->
	#npc_tpl{
		no = 20113,
		name = <<"紫光珠">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1001520],50029}]
};

get(20114) ->
	#npc_tpl{
		no = 20114,
		name = <<"妖狼">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2027,[{has_one_of_unfinished_task,[1001510]}]}]
};

get(20115) ->
	#npc_tpl{
		no = 20115,
		name = <<"封灵珠">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1001550],50030}]
};

get(20116) ->
	#npc_tpl{
		no = 20116,
		name = <<"魔蜘蛛">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2028,[{has_one_of_unfinished_task,[1001540]}]}]
};

get(20117) ->
	#npc_tpl{
		no = 20117,
		name = <<"婆罗珠">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1001580],50031}]
};

get(20118) ->
	#npc_tpl{
		no = 20118,
		name = <<"树魔">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2029,[{has_one_of_unfinished_task,[1001570]}]}]
};

get(20119) ->
	#npc_tpl{
		no = 20119,
		name = <<"霓裳草">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1001620],50032}]
};

get(20120) ->
	#npc_tpl{
		no = 20120,
		name = <<"花非花">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2030,[{has_one_of_unfinished_task,[1001610]}]}]
};

get(20121) ->
	#npc_tpl{
		no = 20121,
		name = <<"雪灵水">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1001650],50033}]
};

get(20122) ->
	#npc_tpl{
		no = 20122,
		name = <<"毒蜂怪">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2031,[{has_one_of_unfinished_task,[1001640]}]}]
};

get(20123) ->
	#npc_tpl{
		no = 20123,
		name = <<"养魂木">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1001680],50034}]
};

get(20124) ->
	#npc_tpl{
		no = 20124,
		name = <<"木怪">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2032,[{has_one_of_unfinished_task,[1001670]}]}]
};

get(20125) ->
	#npc_tpl{
		no = 20125,
		name = <<"幻境石">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1001720],50035}]
};

get(20126) ->
	#npc_tpl{
		no = 20126,
		name = <<"双头狼">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2033,[{has_one_of_unfinished_task,[1001710]}]}]
};

get(20127) ->
	#npc_tpl{
		no = 20127,
		name = <<"吸灵石">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1001750],50036}]
};

get(20128) ->
	#npc_tpl{
		no = 20128,
		name = <<"赤红罗刹">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2034,[{has_one_of_unfinished_task,[1001740]}]}]
};

get(20129) ->
	#npc_tpl{
		no = 20129,
		name = <<"五行玉">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1001780],50037}]
};

get(20130) ->
	#npc_tpl{
		no = 20130,
		name = <<"飞翼魔蛇">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2035,[{has_one_of_unfinished_task,[1001770]}]}]
};

get(20131) ->
	#npc_tpl{
		no = 20131,
		name = <<"黑衣人">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2036,[{has_one_of_unfinished_task,[1001800]}]}]
};

get(20132) ->
	#npc_tpl{
		no = 20132,
		name = <<"可疑痕迹">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20133) ->
	#npc_tpl{
		no = 20133,
		name = <<"黑衣人的踪迹">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20134) ->
	#npc_tpl{
		no = 20134,
		name = <<"黑衣人">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2037,[{has_one_of_unfinished_task,[1001840]}]}]
};

get(20135) ->
	#npc_tpl{
		no = 20135,
		name = <<"黑衣人同伙">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2038,[{has_one_of_unfinished_task,[1001850]}]}]
};

get(20136) ->
	#npc_tpl{
		no = 20136,
		name = <<"血狼">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2039,[{has_one_of_unfinished_task,[1001890]}]}]
};

get(20137) ->
	#npc_tpl{
		no = 20137,
		name = <<"猪妖">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2040,[{has_one_of_unfinished_task,[1001930]}]}]
};

get(20138) ->
	#npc_tpl{
		no = 20138,
		name = <<"蝴蝶精">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2041,[{has_one_of_unfinished_task,[1001940]}]}]
};

get(20139) ->
	#npc_tpl{
		no = 20139,
		name = <<"狼战士">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2042,[{has_one_of_unfinished_task,[1001950]}]}]
};

get(20140) ->
	#npc_tpl{
		no = 20140,
		name = <<"君墨的书房">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20141) ->
	#npc_tpl{
		no = 20141,
		name = <<"飞翼魔蛇">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2043,[{has_one_of_unfinished_task,[1002040]}]}]
};

get(20142) ->
	#npc_tpl{
		no = 20142,
		name = <<"玄武碧麟兽">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2044,[{has_one_of_unfinished_task,[1002060]}]}]
};

get(20143) ->
	#npc_tpl{
		no = 20143,
		name = <<"苍蓝雷鸟">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2045,[{has_one_of_unfinished_task,[1002080]}]}]
};

get(20144) ->
	#npc_tpl{
		no = 20144,
		name = <<"土行者">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2046,[{has_one_of_unfinished_task,[1002100]}]}]
};

get(20145) ->
	#npc_tpl{
		no = 20145,
		name = <<"双头魔狼">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2047,[{has_one_of_unfinished_task,[1002120]}]}]
};

get(20146) ->
	#npc_tpl{
		no = 20146,
		name = <<"昆仑巨猿">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2048,[{has_one_of_unfinished_task,[1002140]}]}]
};

get(20147) ->
	#npc_tpl{
		no = 20147,
		name = <<"狂化牛魔">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2049,[{has_one_of_unfinished_task,[1002200]}]}]
};

get(20148) ->
	#npc_tpl{
		no = 20148,
		name = <<"碧蓝幽鬼">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2050,[{has_one_of_unfinished_task,[1002220]}]}]
};

get(20149) ->
	#npc_tpl{
		no = 20149,
		name = <<"魅魔">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2051,[{has_one_of_unfinished_task,[1002240]}]}]
};

get(20150) ->
	#npc_tpl{
		no = 20150,
		name = <<"左护法的踪迹">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20151) ->
	#npc_tpl{
		no = 20151,
		name = <<"左护法">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2052,[{has_one_of_unfinished_task,[1002300]}]}]
};

get(20152) ->
	#npc_tpl{
		no = 20152,
		name = <<"左阵眼">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20153) ->
	#npc_tpl{
		no = 20153,
		name = <<"右护法的踪迹">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20154) ->
	#npc_tpl{
		no = 20154,
		name = <<"右护法">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2053,[{has_one_of_unfinished_task,[1002330]}]}]
};

get(20155) ->
	#npc_tpl{
		no = 20155,
		name = <<"右阵眼">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20156) ->
	#npc_tpl{
		no = 20156,
		name = <<"深海统领的踪迹">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20157) ->
	#npc_tpl{
		no = 20157,
		name = <<"深海统领">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2054,[{has_one_of_unfinished_task,[1002360]}]}]
};

get(20158) ->
	#npc_tpl{
		no = 20158,
		name = <<"中阵眼">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20159) ->
	#npc_tpl{
		no = 20159,
		name = <<"狐狸">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2002,[{has_one_of_unfinished_task,[1000008]}]}]
};

get(20160) ->
	#npc_tpl{
		no = 20160,
		name = <<"狐狸">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2002,[{has_one_of_unfinished_task,[1000023]}]}]
};

get(20161) ->
	#npc_tpl{
		no = 20161,
		name = <<"狐狸">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2002,[{has_one_of_unfinished_task,[1000038]}]}]
};

get(20162) ->
	#npc_tpl{
		no = 20162,
		name = <<"狐狸">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2002,[{has_one_of_unfinished_task,[1000053]}]}]
};

get(20163) ->
	#npc_tpl{
		no = 20163,
		name = <<"同门师兄">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2093,[{has_one_of_unfinished_task,[1000014]}]}]
};

get(20164) ->
	#npc_tpl{
		no = 20164,
		name = <<"同门师姐">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2094,[{has_one_of_unfinished_task,[1000029]}]}]
};

get(20165) ->
	#npc_tpl{
		no = 20165,
		name = <<"同门师兄">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2095,[{has_one_of_unfinished_task,[1000044]}]}]
};

get(20166) ->
	#npc_tpl{
		no = 20166,
		name = <<"同门师姐">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2096,[{has_one_of_unfinished_task,[1000059]}]}]
};

get(20167) ->
	#npc_tpl{
		no = 20167,
		name = <<"南海同伴">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20168) ->
	#npc_tpl{
		no = 20168,
		name = <<"蓬莱同伴">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20169) ->
	#npc_tpl{
		no = 20169,
		name = <<"盘龙同伴">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20170) ->
	#npc_tpl{
		no = 20170,
		name = <<"草泥马">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20171) ->
	#npc_tpl{
		no = 20171,
		name = <<"雪山银狐">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20172) ->
	#npc_tpl{
		no = 20172,
		name = <<"灵域战狼">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20173) ->
	#npc_tpl{
		no = 20173,
		name = <<"火麒麟">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20174) ->
	#npc_tpl{
		no = 20174,
		name = <<"幻灵战狮">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20175) ->
	#npc_tpl{
		no = 20175,
		name = <<"赤炎火凤">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20176) ->
	#npc_tpl{
		no = 20176,
		name = <<"四爪金龙">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(20177) ->
	#npc_tpl{
		no = 20177,
		name = <<"帮派神兽">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(30001) ->
	#npc_tpl{
		no = 30001,
		name = <<"蜘蛛精">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2101,[{has_one_of_unfinished_task,[1041145,1042145,1043145,1044145]}]}]
};

get(30002) ->
	#npc_tpl{
		no = 30002,
		name = <<"六指琴魔">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2102,[{has_one_of_unfinished_task,[1041146,1042146,1043146,1044146]}]}]
};

get(30003) ->
	#npc_tpl{
		no = 30003,
		name = <<"盗匪头领">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2103,[{has_one_of_unfinished_task,[1041147,1042147,1043147,1044147]}]}]
};

get(30004) ->
	#npc_tpl{
		no = 30004,
		name = <<"石甲怪">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2104,[{has_one_of_unfinished_task,[1041148,1042148,1043148,1044148]}]}]
};

get(30005) ->
	#npc_tpl{
		no = 30005,
		name = <<"狼魔">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2105,[{has_one_of_unfinished_task,[1041149,1042149,1043149,1044149]}]}]
};

get(30006) ->
	#npc_tpl{
		no = 30006,
		name = <<"三尾灵狐">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2106,[{has_one_of_unfinished_task,[1041150,1042150,1043150,1044150]}]}]
};

get(30007) ->
	#npc_tpl{
		no = 30007,
		name = <<"雪猿">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2107,[{has_one_of_unfinished_task,[1041151,1042151,1043151,1044151]}]}]
};

get(30008) ->
	#npc_tpl{
		no = 30008,
		name = <<"妖族使者">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2108,[{has_one_of_unfinished_task,[1041152,1042152,1043152,1044152]}]}]
};

get(30009) ->
	#npc_tpl{
		no = 30009,
		name = <<"夜叉女">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2109,[{has_one_of_unfinished_task,[1041153,1042153,1043153,1044153]}]}]
};

get(30010) ->
	#npc_tpl{
		no = 30010,
		name = <<"白象精">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2110,[{has_one_of_unfinished_task,[1041154,1042154,1043154,1044154]}]}]
};

get(30011) ->
	#npc_tpl{
		no = 30011,
		name = <<"碧蓝幽鬼">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2111,[{has_one_of_unfinished_task,[1041155,1042155,1043155,1044155]}]}]
};

get(30012) ->
	#npc_tpl{
		no = 30012,
		name = <<"赤红罗刹">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2112,[{has_one_of_unfinished_task,[1041156,1042156,1043156,1044156]}]}]
};

get(30013) ->
	#npc_tpl{
		no = 30013,
		name = <<"飞翼魔蛇">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2113,[{has_one_of_unfinished_task,[1041157,1042157,1043157,1044157]}]}]
};

get(30014) ->
	#npc_tpl{
		no = 30014,
		name = <<"魔瞳女妖">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2114,[{has_one_of_unfinished_task,[1041158,1042158,1043158,1044158]}]}]
};

get(30015) ->
	#npc_tpl{
		no = 30015,
		name = <<"玄武碧麟兽">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2115,[{has_one_of_unfinished_task,[1041159,1042159,1043159,1044159]}]}]
};

get(30016) ->
	#npc_tpl{
		no = 30016,
		name = <<"苍蓝雷鸟">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2116,[{has_one_of_unfinished_task,[1041160,1042160,1043160,1044160]}]}]
};

get(30017) ->
	#npc_tpl{
		no = 30017,
		name = <<"狂化牛魔">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2117,[{has_one_of_unfinished_task,[1041161,1042161,1043161,1044161]}]}]
};

get(30018) ->
	#npc_tpl{
		no = 30018,
		name = <<"土行者">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2118,[{has_one_of_unfinished_task,[1041162,1042162,1043162,1044162]}]}]
};

get(30019) ->
	#npc_tpl{
		no = 30019,
		name = <<"魅魔">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2119,[{has_one_of_unfinished_task,[1041163,1042163,1043163,1044163]}]}]
};

get(30020) ->
	#npc_tpl{
		no = 30020,
		name = <<"飞翼冥使">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2120,[{has_one_of_unfinished_task,[1041164,1042164,1043164,1044164]}]}]
};

get(1005) ->
	#npc_tpl{
		no = 1005,
		name = <<"李耳">>,
		type = 1,
		race = 0,
		faction = 5,
		sex = 0,
		existing_time = 0,
		func_list = [{dungeon,[5041,5042,5043],0}]
};

get(1006) ->
	#npc_tpl{
		no = 1006,
		name = <<"孔若雨">>,
		type = 1,
		race = 0,
		faction = 6,
		sex = 0,
		existing_time = 0,
		func_list = [{dungeon,[5051,5052,5053],0}]
};

get(1007) ->
	#npc_tpl{
		no = 1007,
		name = <<"欧冶子">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{sell_goods, 1}]
};

get(1008) ->
	#npc_tpl{
		no = 1008,
		name = <<"神农氏">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{sell_goods, 2}]
};

get(1009) ->
	#npc_tpl{
		no = 1009,
		name = <<"沈百万">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(1010) ->
	#npc_tpl{
		no = 1010,
		name = <<"黄道女">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{sell_goods, 4}]
};

get(1011) ->
	#npc_tpl{
		no = 1011,
		name = <<"西施">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{sell_goods, 5}]
};

get(1012) ->
	#npc_tpl{
		no = 1012,
		name = <<"陶朱公">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{sell_goods, 6}]
};

get(1013) ->
	#npc_tpl{
		no = 1013,
		name = <<"铁鸡公">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [enter_storage]
};

get(1015) ->
	#npc_tpl{
		no = 1015,
		name = <<"路人甲">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(1019) ->
	#npc_tpl{
		no = 1019,
		name = <<"荆轲">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(1023) ->
	#npc_tpl{
		no = 1023,
		name = <<"未知NPC">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(1030) ->
	#npc_tpl{
		no = 1030,
		name = <<"监狱古神">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [open_slotmachine]
};

get(1034) ->
	#npc_tpl{
		no = 1034,
		name = <<"陈咬金">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 3600*24*60,
		func_list = [join_guild_battle]
};

get(1037) ->
	#npc_tpl{
		no = 1037,
		name = <<"帮派东护法">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 3600*24*60,
		func_list = [{sell_goods, 13}]
};

get(1038) ->
	#npc_tpl{
		no = 1038,
		name = <<"帮派西护法">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 3600*24*60,
		func_list = [{sell_goods, 14}]
};

get(1039) ->
	#npc_tpl{
		no = 1039,
		name = <<"帮派南护法">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 3600*24*60,
		func_list = []
};

get(1040) ->
	#npc_tpl{
		no = 1040,
		name = <<"帮派北护法">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 3600*24*60,
		func_list = []
};

get(1042) ->
	#npc_tpl{
		no = 1042,
		name = <<"武神">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(1043) ->
	#npc_tpl{
		no = 1043,
		name = <<"帮派二当家">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 3600*24*60,
		func_list = []
};

get(1044) ->
	#npc_tpl{
		no = 1044,
		name = <<"墨家驿夫">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{teleport, [107,108,109]}]
};

get(1045) ->
	#npc_tpl{
		no = 1045,
		name = <<"兵家驿夫">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{teleport, [107,108,109]}]
};

get(1046) ->
	#npc_tpl{
		no = 1046,
		name = <<"法家驿夫">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{teleport, [107,108,109]}]
};

get(1047) ->
	#npc_tpl{
		no = 1047,
		name = <<"阴阳家驿夫">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{teleport, [107,108,109]}]
};

get(1048) ->
	#npc_tpl{
		no = 1048,
		name = <<"道家驿夫">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{teleport, [107,108,109]}]
};

get(1049) ->
	#npc_tpl{
		no = 1049,
		name = <<"儒家驿夫">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{teleport, [107,108,109]}]
};

get(1050) ->
	#npc_tpl{
		no = 1050,
		name = <<"赵家村驿夫">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{teleport, [107]},go_back_faction]
};

get(1051) ->
	#npc_tpl{
		no = 1051,
		name = <<"轮回鬼">>,
		type = 1,
		race = 0,
		faction = 4,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(1052) ->
	#npc_tpl{
		no = 1052,
		name = <<"黄石公">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [goods_compose]
};

get(1053) ->
	#npc_tpl{
		no = 1053,
		name = <<"帮派旗手">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 3600*24*60,
		func_list = [guild_dishes]
};

get(1054) ->
	#npc_tpl{
		no = 1054,
		name = <<"文状元">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{literary_exchange,15}]
};

get(1055) ->
	#npc_tpl{
		no = 1055,
		name = <<"帮派武师">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 3600*24*60,
		func_list = [{trigger_mf,800479,[{has_one_of_unfinished_task,[1300020]}]}]
};

get(1058) ->
	#npc_tpl{
		no = 1058,
		name = <<"刘关张">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [enter_sworn,modify_sworn,remove_sworn,{trigger_mf,800469,[{has_one_of_unfinished_task,[1300021]}]}]
};

get(1059) ->
	#npc_tpl{
		no = 1059,
		name = <<"欧冶子">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{sell_goods, 7}]
};

get(1060) ->
	#npc_tpl{
		no = 1060,
		name = <<"神农氏">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{sell_goods, 8}]
};

get(1061) ->
	#npc_tpl{
		no = 1061,
		name = <<"黄道女">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{sell_goods, 10}]
};

get(1062) ->
	#npc_tpl{
		no = 1062,
		name = <<"西施">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{sell_goods, 11}]
};

get(1063) ->
	#npc_tpl{
		no = 1063,
		name = <<"陶朱公">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{sell_goods, 6}]
};

get(1064) ->
	#npc_tpl{
		no = 1064,
		name = <<"咸阳驿夫">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{teleport, [107,108]},go_back_faction]
};

get(1065) ->
	#npc_tpl{
		no = 1065,
		name = <<"未知NPC">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{teleport,[30]},enter_shop]
};

get(1066) ->
	#npc_tpl{
		no = 1066,
		name = <<"未知NPC">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 3600*24*60,
		func_list = [{sell_goods, 16}]
};

get(1069) ->
	#npc_tpl{
		no = 1069,
		name = <<"定山将军">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(1074) ->
	#npc_tpl{
		no = 1074,
		name = <<"欧冶子">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{sell_goods, 7}]
};

get(1075) ->
	#npc_tpl{
		no = 1075,
		name = <<"神农氏">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{sell_goods, 8}]
};

get(1076) ->
	#npc_tpl{
		no = 1076,
		name = <<"黄道女">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{sell_goods, 10}]
};

get(1077) ->
	#npc_tpl{
		no = 1077,
		name = <<"西施">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{sell_goods, 11}]
};

get(1078) ->
	#npc_tpl{
		no = 1078,
		name = <<"陶朱公">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{sell_goods, 6}]
};

get(1079) ->
	#npc_tpl{
		no = 1079,
		name = <<"夏黄公">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{sell_goods, 16}]
};

get(1080) ->
	#npc_tpl{
		no = 1080,
		name = <<"门派转换师">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [open_change_faction]
};

get(1081) ->
	#npc_tpl{
		no = 1081,
		name = <<"未知NPC">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 3600*24*60,
		func_list = [year_dishes]
};

get(1082) ->
	#npc_tpl{
		no = 1082,
		name = <<"未知NPC">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [year_entry,get_goods]
};

get(1083) ->
	#npc_tpl{
		no = 1083,
		name = <<"未知NPC">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{teleport, [107,108,109]}]
};

get(1084) ->
	#npc_tpl{
		no = 1084,
		name = <<"坐骑形象达人">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{goods_exchange,3},{goods_exchange,4},{goods_exchange,5},{goods_exchange,6},{goods_exchange,7},{goods_exchange,87}]
};

get(1085) ->
	#npc_tpl{
		no = 1085,
		name = <<"坐骑商人">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{goods_exchange,8},{goods_exchange,9},{goods_exchange,10},{goods_exchange,11},{goods_exchange,12},{goods_exchange,88}]
};

get(1086) ->
	#npc_tpl{
		no = 1086,
		name = <<"刘二龙">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{teleport, [54]}]
};

get(1087) ->
	#npc_tpl{
		no = 1087,
		name = <<"时尚男模">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [offline_arena]
};

get(1088) ->
	#npc_tpl{
		no = 1088,
		name = <<"时尚女模">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [melee_apply]
};

get(2001) ->
	#npc_tpl{
		no = 2001,
		name = <<"项少龙">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,800474,[{has_one_of_unfinished_task,[1300015]}]}]
};

get(2002) ->
	#npc_tpl{
		no = 2002,
		name = <<"驿夫">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2003) ->
	#npc_tpl{
		no = 2003,
		name = <<"驿夫">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2004) ->
	#npc_tpl{
		no = 2004,
		name = <<"翻倒马车">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2005) ->
	#npc_tpl{
		no = 2005,
		name = <<"妙龄少女">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2006) ->
	#npc_tpl{
		no = 2006,
		name = <<"妙龄少女">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2007) ->
	#npc_tpl{
		no = 2007,
		name = <<"妙龄少女">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2008) ->
	#npc_tpl{
		no = 2008,
		name = <<"连晋">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2009) ->
	#npc_tpl{
		no = 2009,
		name = <<"乌廷芳">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2010) ->
	#npc_tpl{
		no = 2010,
		name = <<"项少龙">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2011) ->
	#npc_tpl{
		no = 2011,
		name = <<"乌廷芳">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2002,[{has_one_of_unfinished_task,[1000230]}]}]
};

get(2012) ->
	#npc_tpl{
		no = 2012,
		name = <<"赵家总管">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2013) ->
	#npc_tpl{
		no = 2013,
		name = <<"赵老板">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,800475,[{has_one_of_unfinished_task,[1300016]}]}]
};

get(2014) ->
	#npc_tpl{
		no = 2014,
		name = <<"陆仁嘉">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2015) ->
	#npc_tpl{
		no = 2015,
		name = <<"赵村老者">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2016) ->
	#npc_tpl{
		no = 2016,
		name = <<"赵村村长">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2017) ->
	#npc_tpl{
		no = 2017,
		name = <<"山贼喽罗">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2004,[{has_one_of_unfinished_task,[1000350]}]}]
};

get(2018) ->
	#npc_tpl{
		no = 2018,
		name = <<"凶恶盗贼">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2006,[{has_one_of_unfinished_task,[1000880]}]}]
};

get(2019) ->
	#npc_tpl{
		no = 2019,
		name = <<"陶方">>,
		type = 1,
		race = 0,
		faction = 6,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,800472,[{has_one_of_unfinished_task,[1300013]}]}]
};

get(2020) ->
	#npc_tpl{
		no = 2020,
		name = <<"灰胡">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2021) ->
	#npc_tpl{
		no = 2021,
		name = <<"地头蛇">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2022) ->
	#npc_tpl{
		no = 2022,
		name = <<"春十三娘">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2007,[{has_one_of_unfinished_task,[1000960]}]},{trigger_mf,800473,[{has_one_of_unfinished_task,[1300014]}]}]
};

get(2117) ->
	#npc_tpl{
		no = 2117,
		name = <<"灰胡真身">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2027,[{has_one_of_unfinished_task,[1000981]}]}]
};

get(2023) ->
	#npc_tpl{
		no = 2023,
		name = <<"神秘脚印">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2024) ->
	#npc_tpl{
		no = 2024,
		name = <<"古神">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [open_slotmachine]
};

get(2025) ->
	#npc_tpl{
		no = 2025,
		name = <<"张捕快">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2008,[{has_one_of_unfinished_task,[1001020]}]}]
};

get(2026) ->
	#npc_tpl{
		no = 2026,
		name = <<"万事通">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2027) ->
	#npc_tpl{
		no = 2027,
		name = <<"荆轲">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{sell_goods, 14}]
};

get(2029) ->
	#npc_tpl{
		no = 2029,
		name = <<"廉颇">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{goods_exchange,66},{goods_exchange,67},{goods_exchange,68}]
};

get(2030) ->
	#npc_tpl{
		no = 2030,
		name = <<"赵王">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{goods_exchange,69},{goods_exchange,70}]
};

get(2032) ->
	#npc_tpl{
		no = 2032,
		name = <<"抓鬼弟子">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2033) ->
	#npc_tpl{
		no = 2033,
		name = <<"蒙武">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2014,[{has_one_of_unfinished_task,[1001320]}]}, {trigger_mf,800471,[{has_one_of_unfinished_task,[1300012]}]}]
};

get(2034) ->
	#npc_tpl{
		no = 2034,
		name = <<"秦国小兵">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2015,[{has_one_of_unfinished_task,[1001370]}]}]
};

get(2035) ->
	#npc_tpl{
		no = 2035,
		name = <<"秦国军官">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2036) ->
	#npc_tpl{
		no = 2036,
		name = <<"秦国校尉">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2037) ->
	#npc_tpl{
		no = 2037,
		name = <<"秦国士长">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2017,[{has_one_of_unfinished_task,[1001490]}]}]
};

get(2038) ->
	#npc_tpl{
		no = 2038,
		name = <<"东据点">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2039) ->
	#npc_tpl{
		no = 2039,
		name = <<"北据点">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2040) ->
	#npc_tpl{
		no = 2040,
		name = <<"南据点">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2041) ->
	#npc_tpl{
		no = 2041,
		name = <<"西据点">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2042) ->
	#npc_tpl{
		no = 2042,
		name = <<"赵致">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2018,[{has_one_of_unfinished_task,[1001560]}]}]
};

get(2043) ->
	#npc_tpl{
		no = 2043,
		name = <<"赵致">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2044) ->
	#npc_tpl{
		no = 2044,
		name = <<"赵正叔">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2045) ->
	#npc_tpl{
		no = 2045,
		name = <<"赵小虎">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2047) ->
	#npc_tpl{
		no = 2047,
		name = <<"周术">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2048) ->
	#npc_tpl{
		no = 2048,
		name = <<"镇妖弟子">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2049) ->
	#npc_tpl{
		no = 2049,
		name = <<"镇妖弟子">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2050) ->
	#npc_tpl{
		no = 2050,
		name = <<"镇妖弟子">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2051) ->
	#npc_tpl{
		no = 2051,
		name = <<"地方恶霸">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2100,[{has_one_of_unfinished_task,[1001100]}]}]
};

get(2052) ->
	#npc_tpl{
		no = 2052,
		name = <<"逆天魔龙">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2053) ->
	#npc_tpl{
		no = 2053,
		name = <<"抓鬼弟子">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,800477,[{has_one_of_unfinished_task,[1300018]}]}]
};

get(2054) ->
	#npc_tpl{
		no = 2054,
		name = <<"少女侍卫">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2000,[{has_one_of_unfinished_task,[1000060]}]}]
};

get(2055) ->
	#npc_tpl{
		no = 2055,
		name = <<"少女侍卫">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2001,[{has_one_of_unfinished_task,[1000070]}]}]
};

get(2056) ->
	#npc_tpl{
		no = 2056,
		name = <<"荆轲">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2003,[{has_one_of_unfinished_task,[1000240]}]}]
};

get(2063) ->
	#npc_tpl{
		no = 2063,
		name = <<"愚笨盗贼">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2025,[{has_one_of_unfinished_task,[1000280]}]}]
};

get(2064) ->
	#npc_tpl{
		no = 2064,
		name = <<"作恶强盗">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2010,[{has_one_of_unfinished_task,[1000860]}]}]
};

get(2065) ->
	#npc_tpl{
		no = 2065,
		name = <<"锯子鬼">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2011,[{has_one_of_unfinished_task,[1001150]}]}]
};

get(2066) ->
	#npc_tpl{
		no = 2066,
		name = <<"曲尺鬼">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2012,[{has_one_of_unfinished_task,[1001160]}]}]
};

get(2067) ->
	#npc_tpl{
		no = 2067,
		name = <<"墨斗鬼">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2013,[{has_one_of_unfinished_task,[1001170]}]}]
};

get(2068) ->
	#npc_tpl{
		no = 2068,
		name = <<"监狱看守">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2016,[{has_one_of_unfinished_task,[1001440]}]}]
};

get(2081) ->
	#npc_tpl{
		no = 2081,
		name = <<"商会商人">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2082) ->
	#npc_tpl{
		no = 2082,
		name = <<"山寨娄罗">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2083) ->
	#npc_tpl{
		no = 2083,
		name = <<"游玩孩童">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2084) ->
	#npc_tpl{
		no = 2084,
		name = <<"山寨娄罗">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2019,[{has_one_of_unfinished_task,[1001740]}]}]
};

get(2085) ->
	#npc_tpl{
		no = 2085,
		name = <<"赵寨主">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,800476,[{has_one_of_unfinished_task,[1300017]}]},{trigger_mf,800472,[{has_one_of_unfinished_task,[1300024]}]}]
};

get(2086) ->
	#npc_tpl{
		no = 2086,
		name = <<"凶饿山贼">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2087) ->
	#npc_tpl{
		no = 2087,
		name = <<"守寨首领">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2021,[{has_one_of_unfinished_task,[1001960]}]}]
};

get(2088) ->
	#npc_tpl{
		no = 2088,
		name = <<"昏迷少年">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2089) ->
	#npc_tpl{
		no = 2089,
		name = <<"年轻人">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2090) ->
	#npc_tpl{
		no = 2090,
		name = <<"赵寨主">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2023,[{has_one_of_unfinished_task,[1002030]}]}]
};

get(2091) ->
	#npc_tpl{
		no = 2091,
		name = <<"包裹">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2092) ->
	#npc_tpl{
		no = 2092,
		name = <<"太子丹">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2093) ->
	#npc_tpl{
		no = 2093,
		name = <<"万鬼王">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2024,[{has_one_of_unfinished_task,[1002120]}]}]
};

get(2094) ->
	#npc_tpl{
		no = 2094,
		name = <<"绮里季吴实">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2020,[{has_one_of_unfinished_task,[1001910]}]}]
};

get(2095) ->
	#npc_tpl{
		no = 2095,
		name = <<"残暴鬼">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2022,[{has_one_of_unfinished_task,[1001970]}]}]
};

get(2096) ->
	#npc_tpl{
		no = 2096,
		name = <<"酒店老板">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,800468,[{has_one_of_unfinished_task,[1300020]}]}]
};

get(2097) ->
	#npc_tpl{
		no = 2097,
		name = <<"无用">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2026,[{has_one_of_unfinished_task,[1000370]}]}]
};

get(2098) ->
	#npc_tpl{
		no = 2098,
		name = <<"秦营石碑">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2099) ->
	#npc_tpl{
		no = 2099,
		name = <<"哨兵">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2033,[{has_one_of_unfinished_task,[1002190]}]}]
};

get(2100) ->
	#npc_tpl{
		no = 2100,
		name = <<"蒙太傅">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2101) ->
	#npc_tpl{
		no = 2101,
		name = <<"蒙武">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,800477,[{has_one_of_unfinished_task,[1300029]}]}]
};

get(2102) ->
	#npc_tpl{
		no = 2102,
		name = <<"乌卓">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2103) ->
	#npc_tpl{
		no = 2103,
		name = <<"钥匙">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2104) ->
	#npc_tpl{
		no = 2104,
		name = <<"蒙恬">>,
		type = 1,
		race = 3,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,800475,[{has_one_of_unfinished_task,[1300027]}]}]
};

get(2105) ->
	#npc_tpl{
		no = 2105,
		name = <<"军营钥匙">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1002400],30081}]
};

get(2106) ->
	#npc_tpl{
		no = 2106,
		name = <<"王翦">>,
		type = 1,
		race = 3,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2036,[{has_one_of_unfinished_task,[1002380]}]},{trigger_mf,800476,[{has_one_of_unfinished_task,[1300028]}]}]
};

get(2107) ->
	#npc_tpl{
		no = 2107,
		name = <<"奇怪的士兵">>,
		type = 1,
		race = 3,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2108) ->
	#npc_tpl{
		no = 2108,
		name = <<"奇怪的士兵">>,
		type = 1,
		race = 3,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2109) ->
	#npc_tpl{
		no = 2109,
		name = <<"连晋手下">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2040,[{has_one_of_unfinished_task,[1002510]}]}]
};

get(2110) ->
	#npc_tpl{
		no = 2110,
		name = <<"连晋手下">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2042,[{has_one_of_unfinished_task,[1002620]}]}]
};

get(2111) ->
	#npc_tpl{
		no = 2111,
		name = <<"王翦">>,
		type = 1,
		race = 3,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2112) ->
	#npc_tpl{
		no = 2112,
		name = <<"蒙武">>,
		type = 1,
		race = 3,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2113) ->
	#npc_tpl{
		no = 2113,
		name = <<"奇怪的士兵">>,
		type = 1,
		race = 3,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2043,[{has_one_of_unfinished_task,[1002720]}]}]
};

get(2114) ->
	#npc_tpl{
		no = 2114,
		name = <<"秦国小兵">>,
		type = 1,
		race = 3,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2115) ->
	#npc_tpl{
		no = 2115,
		name = <<"秦国小兵">>,
		type = 1,
		race = 3,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2116) ->
	#npc_tpl{
		no = 2116,
		name = <<"哨兵">>,
		type = 1,
		race = 3,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2118) ->
	#npc_tpl{
		no = 2118,
		name = <<"夜叉">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2028,[{has_one_of_unfinished_task,[1001230]}]}]
};

get(2119) ->
	#npc_tpl{
		no = 2119,
		name = <<"千年匠魂">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2029,[{has_one_of_unfinished_task,[1001280]}]}]
};

get(2120) ->
	#npc_tpl{
		no = 2120,
		name = <<"赵倩">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2030,[{has_one_of_unfinished_task,[1001650]}]}]
};

get(2121) ->
	#npc_tpl{
		no = 2121,
		name = <<"疯狂草灵">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2031,[{has_one_of_unfinished_task,[1001820]}]}]
};

get(2122) ->
	#npc_tpl{
		no = 2122,
		name = <<"监狱盾兵">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2034,[{has_one_of_unfinished_task,[1002250]}]}]
};

get(2123) ->
	#npc_tpl{
		no = 2123,
		name = <<"捣乱妖魔">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2035,[{has_one_of_unfinished_task,[1002300]}]}]
};

get(2124) ->
	#npc_tpl{
		no = 2124,
		name = <<"贪睡猪">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2037,[{has_one_of_unfinished_task,[1002460]}]}]
};

get(2125) ->
	#npc_tpl{
		no = 2125,
		name = <<"贪财熊">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2038,[{has_one_of_unfinished_task,[1002470]}]}]
};

get(2127) ->
	#npc_tpl{
		no = 2127,
		name = <<"偷听鬼">>,
		type = 1,
		race = 3,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2041,[{has_one_of_unfinished_task,[1002550]}]}]
};

get(2126) ->
	#npc_tpl{
		no = 2126,
		name = <<"秦营卫队">>,
		type = 1,
		race = 3,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2039,[{has_one_of_unfinished_task,[1002480]}]}]
};

get(2057) ->
	#npc_tpl{
		no = 2057,
		name = <<"偷懒弟子">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2005,[{has_one_of_unfinished_task,[1000440]}]}]
};

get(2058) ->
	#npc_tpl{
		no = 2058,
		name = <<"偷懒弟子">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2005,[{has_one_of_unfinished_task,[1000500]}]}]
};

get(2059) ->
	#npc_tpl{
		no = 2059,
		name = <<"偷懒弟子">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2005,[{has_one_of_unfinished_task,[1000560]}]}]
};

get(2060) ->
	#npc_tpl{
		no = 2060,
		name = <<"偷懒弟子">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2005,[{has_one_of_unfinished_task,[1000620]}]}]
};

get(2061) ->
	#npc_tpl{
		no = 2061,
		name = <<"偷懒弟子">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2005,[{has_one_of_unfinished_task,[1000680]}]}]
};

get(2062) ->
	#npc_tpl{
		no = 2062,
		name = <<"偷懒弟子">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2005,[{has_one_of_unfinished_task,[1000740]}]}]
};

get(2069) ->
	#npc_tpl{
		no = 2069,
		name = <<"偷懒弟子">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2301,[{has_one_of_unfinished_task,[1040141,1040142,1040143,1040144,1040145,1040146,1040147,1040148,1040149]}]}]
};

get(2070) ->
	#npc_tpl{
		no = 2070,
		name = <<"偷懒弟子">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2305,[{has_one_of_unfinished_task,[1040241,1040242,1040243,1040244,1040245,1040246,1040247,1040248,1040249]}]}]
};

get(2071) ->
	#npc_tpl{
		no = 2071,
		name = <<"偷懒弟子">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2309,[{has_one_of_unfinished_task,[1040341,1040342,1040343,1040344,1040345,1040346,1040347,1040348,1040349]}]}]
};

get(2072) ->
	#npc_tpl{
		no = 2072,
		name = <<"偷懒弟子">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2313,[{has_one_of_unfinished_task,[1040441,1040442,1040443,1040444,1040445,1040446,1040447,1040448,1040449]}]}]
};

get(2073) ->
	#npc_tpl{
		no = 2073,
		name = <<"偷懒弟子">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2317,[{has_one_of_unfinished_task,[1040541,1040542,1040543,1040544,1040545,1040546,1040547,1040548,1040549]}]}]
};

get(2074) ->
	#npc_tpl{
		no = 2074,
		name = <<"偷懒弟子">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2321,[{has_one_of_unfinished_task,[1040641,1040642,1040643,1040644,1040645,1040646,1040647,1040648,1040649]}]}]
};

get(2075) ->
	#npc_tpl{
		no = 2075,
		name = <<"偷懒弟子">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2300,[{has_one_of_unfinished_task,[1041136,
1041137,
1041138,
1041139,
1041140,
1041141,
1041142,
1041143,
1041144,
1041145,
1041146,
1041147,
1041148,
1041149]}]}]
};

get(2076) ->
	#npc_tpl{
		no = 2076,
		name = <<"偷懒弟子">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2304,[{has_one_of_unfinished_task,[1041236,
1041237,
1041238,
1041239,
1041240,
1041241,
1041242,
1041243,
1041244,
1041245,
1041246,
1041247,
1041248,
1041249]}]}]
};

get(2077) ->
	#npc_tpl{
		no = 2077,
		name = <<"偷懒弟子">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2308,[{has_one_of_unfinished_task,[1041336,
1041337,
1041338,
1041339,
1041340,
1041341,
1041342,
1041343,
1041344,
1041345,
1041346,
1041347,
1041348,
1041349]}]}]
};

get(2078) ->
	#npc_tpl{
		no = 2078,
		name = <<"偷懒弟子">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2312,[{has_one_of_unfinished_task,[1041436,
1041437,
1041438,
1041439,
1041440,
1041441,
1041442,
1041443,
1041444,
1041445,
1041446,
1041447,
1041448,
1041449
]}]}]
};

get(2079) ->
	#npc_tpl{
		no = 2079,
		name = <<"偷懒弟子">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2316,[{has_one_of_unfinished_task,[1041536,
1041537,
1041538,
1041539,
1041540,
1041541,
1041542,
1041543,
1041544,
1041545,
1041546,
1041547,
1041548,
1041549]}]}]
};

get(2080) ->
	#npc_tpl{
		no = 2080,
		name = <<"偷懒弟子">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2320,[{has_one_of_unfinished_task,[1041636,
1041637,
1041638,
1041639,
1041640,
1041641,
1041642,
1041643,
1041644,
1041645,
1041646,
1041647,
1041648,
1041649]}]}]
};

get(2128) ->
	#npc_tpl{
		no = 2128,
		name = <<"偷懒弟子">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2299,[{has_one_of_unfinished_task,[1042136,
1042137,
1042138,
1042139,
1042140,
1042141,
1042142,
1042143,
1042144,
1042145,
1042146,
1042147,
1042148,
1042149]}]}]
};

get(2129) ->
	#npc_tpl{
		no = 2129,
		name = <<"偷懒弟子">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2303,[{has_one_of_unfinished_task,[1042236,
1042237,
1042238,
1042239,
1042240,
1042241,
1042242,
1042243,
1042244,
1042245,
1042246,
1042247,
1042248,
1042249]}]}]
};

get(2130) ->
	#npc_tpl{
		no = 2130,
		name = <<"偷懒弟子">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2307,[{has_one_of_unfinished_task,[1042336,
1042337,
1042338,
1042339,
1042340,
1042341,
1042342,
1042343,
1042344,
1042345,
1042346,
1042347,
1042348,
1042349]}]}]
};

get(2131) ->
	#npc_tpl{
		no = 2131,
		name = <<"偷懒弟子">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2311,[{has_one_of_unfinished_task,[1042436,
1042437,
1042438,
1042439,
1042440,
1042441,
1042442,
1042443,
1042444,
1042445,
1042446,
1042447,
1042448,
1042449]}]}]
};

get(2132) ->
	#npc_tpl{
		no = 2132,
		name = <<"偷懒弟子">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2315,[{has_one_of_unfinished_task,[1042536,
1042537,
1042538,
1042539,
1042540,
1042541,
1042542,
1042543,
1042544,
1042545,
1042546,
1042547,
1042548,
1042549]}]}]
};

get(2133) ->
	#npc_tpl{
		no = 2133,
		name = <<"偷懒弟子">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2319,[{has_one_of_unfinished_task,[1042636,
1042637,
1042638,
1042639,
1042640,
1042641,
1042642,
1042643,
1042644,
1042645,
1042646,
1042647,
1042648,
1042649]}]}]
};

get(2187) ->
	#npc_tpl{
		no = 2187,
		name = <<"偷懒弟子">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2298,[{has_one_of_unfinished_task,[1043134,1043135,1043136,1043137,1043138,1043139,1043140,1043141,1043142,1043143,1043144,1043145,1043146,1043147,1043148,1043149]}]}]
};

get(2188) ->
	#npc_tpl{
		no = 2188,
		name = <<"偷懒弟子">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2302,[{has_one_of_unfinished_task,[1043234,1043235,1043236,1043237,1043238,1043239,1043240,1043241,1043242,1043243,1043244,1043245,1043246,1043247,1043248,1043249]}]}]
};

get(2189) ->
	#npc_tpl{
		no = 2189,
		name = <<"偷懒弟子">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2306,[{has_one_of_unfinished_task,[1043334,1043335,1043336,1043337,1043338,1043339,1043340,1043341,1043342,1043343,1043344,1043345,1043346,1043347,1043348,1043349]}]}]
};

get(2190) ->
	#npc_tpl{
		no = 2190,
		name = <<"偷懒弟子">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2310,[{has_one_of_unfinished_task,[1043434,1043435,1043436,1043437,1043438,1043439,1043440,1043441,1043442,1043443,1043444,1043445,1043446,1043447,1043448,1043449]}]}]
};

get(2191) ->
	#npc_tpl{
		no = 2191,
		name = <<"偷懒弟子">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2314,[{has_one_of_unfinished_task,[1043534,1043535,1043536,1043537,1043538,1043539,1043540,1043541,1043542,1043543,1043544,1043545,1043546,1043547,1043548,1043549]}]}]
};

get(2192) ->
	#npc_tpl{
		no = 2192,
		name = <<"偷懒弟子">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2318,[{has_one_of_unfinished_task,[1043634,1043635,1043636,1043637,1043638,1043639,1043640,1043641,1043642,1043643,1043644,1043645,1043646,1043647,1043648,1043649]}]}]
};

get(2134) ->
	#npc_tpl{
		no = 2134,
		name = <<"秦国驿夫">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2135) ->
	#npc_tpl{
		no = 2135,
		name = <<"嬴政">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2136) ->
	#npc_tpl{
		no = 2136,
		name = <<"琴清">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2137) ->
	#npc_tpl{
		no = 2137,
		name = <<"蚌精守卫">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2103,[{has_one_of_unfinished_task,[1002770]}]}]
};

get(2138) ->
	#npc_tpl{
		no = 2138,
		name = <<"蚌精大王">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,800470,[{has_one_of_unfinished_task,[1300011]}]}]
};

get(2139) ->
	#npc_tpl{
		no = 2139,
		name = <<"异界墨灵">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2104,[{has_one_of_unfinished_task,[1002810]}]}]
};

get(2140) ->
	#npc_tpl{
		no = 2140,
		name = <<"吕不韦">>,
		type = 1,
		race = 3,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{goods_exchange,13}]
};

get(2141) ->
	#npc_tpl{
		no = 2141,
		name = <<"秦国卫士">>,
		type = 1,
		race = 3,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2105,[{has_one_of_unfinished_task,[1002840]}]}]
};

get(2142) ->
	#npc_tpl{
		no = 2142,
		name = <<"奇怪的蚌精">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2106,[{has_one_of_unfinished_task,[1002870]}]}]
};

get(2143) ->
	#npc_tpl{
		no = 2143,
		name = <<"琴清">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2144) ->
	#npc_tpl{
		no = 2144,
		name = <<"冒牌琴清">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2107,[{has_one_of_unfinished_task,[1002920]}]}]
};

get(2145) ->
	#npc_tpl{
		no = 2145,
		name = <<"御前侍卫">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2146) ->
	#npc_tpl{
		no = 2146,
		name = <<"塞外大汉">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2108,[{has_one_of_unfinished_task,[1002960]}]}]
};

get(2147) ->
	#npc_tpl{
		no = 2147,
		name = <<"西域刺客">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2109,[{has_one_of_unfinished_task,[1002980]}]}]
};

get(2148) ->
	#npc_tpl{
		no = 2148,
		name = <<"炼狱魔王">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2110,[{has_one_of_unfinished_task,[1003000]}]}]
};

get(2149) ->
	#npc_tpl{
		no = 2149,
		name = <<"长信侯党羽">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2111,[{has_one_of_unfinished_task,[1003040]}]}]
};

get(2150) ->
	#npc_tpl{
		no = 2150,
		name = <<"怨毒鬼怪">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2112,[{has_one_of_unfinished_task,[1003070]}]}]
};

get(2151) ->
	#npc_tpl{
		no = 2151,
		name = <<"长信侯手下">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2113,[{has_one_of_unfinished_task,[1003090]}]}]
};

get(2152) ->
	#npc_tpl{
		no = 2152,
		name = <<"长信侯之影">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2114,[{has_one_of_unfinished_task,[1003130]}]}]
};

get(2153) ->
	#npc_tpl{
		no = 2153,
		name = <<"魔化项少龙">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2115,[{has_one_of_unfinished_task,[1003170]}]}]
};

get(2154) ->
	#npc_tpl{
		no = 2154,
		name = <<"圣水守护者">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2116,[{has_one_of_unfinished_task,[1003200]}]}]
};

get(2155) ->
	#npc_tpl{
		no = 2155,
		name = <<"黑暗之影">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2117,[{has_one_of_unfinished_task,[1003240]}]}]
};

get(2156) ->
	#npc_tpl{
		no = 2156,
		name = <<"长信侯守卫">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2118,[{has_one_of_unfinished_task,[1003290]}]}]
};

get(2157) ->
	#npc_tpl{
		no = 2157,
		name = <<"项少龙">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2158) ->
	#npc_tpl{
		no = 2158,
		name = <<"长信侯化身">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2119,[{has_one_of_unfinished_task,[1003320]}]}]
};

get(2159) ->
	#npc_tpl{
		no = 2159,
		name = <<"未知NPC">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2160) ->
	#npc_tpl{
		no = 2160,
		name = <<"连晋">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,1,[{has_one_of_unfinished_task,[1000120]}]}]
};

get(2161) ->
	#npc_tpl{
		no = 2161,
		name = <<"未知NPC">>,
		type = 1,
		race = 3,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2162) ->
	#npc_tpl{
		no = 2162,
		name = <<"未知NPC">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2116,[{has_one_of_unfinished_task,[1003500]}]}]
};

get(2163) ->
	#npc_tpl{
		no = 2163,
		name = <<"未知NPC">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2117,[{has_one_of_unfinished_task,[1003580]}]}]
};

get(2164) ->
	#npc_tpl{
		no = 2164,
		name = <<"未知NPC">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2165) ->
	#npc_tpl{
		no = 2165,
		name = <<"未知NPC">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2166) ->
	#npc_tpl{
		no = 2166,
		name = <<"未知NPC">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2118,[{has_one_of_unfinished_task,[1003640]}]}]
};

get(2167) ->
	#npc_tpl{
		no = 2167,
		name = <<"未知NPC">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2168) ->
	#npc_tpl{
		no = 2168,
		name = <<"未知NPC">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2169) ->
	#npc_tpl{
		no = 2169,
		name = <<"未知NPC">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2119,[{has_one_of_unfinished_task,[1003690]}]}]
};

get(2170) ->
	#npc_tpl{
		no = 2170,
		name = <<"未知NPC">>,
		type = 1,
		race = 2,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2120,[{has_one_of_unfinished_task,[1003760]}]}]
};

get(2171) ->
	#npc_tpl{
		no = 2171,
		name = <<"未知NPC">>,
		type = 1,
		race = 2,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2172) ->
	#npc_tpl{
		no = 2172,
		name = <<"未知NPC">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2121,[{has_one_of_unfinished_task,[1003790]}]}]
};

get(2173) ->
	#npc_tpl{
		no = 2173,
		name = <<"未知NPC">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2122,[{has_one_of_unfinished_task,[1003840]}]}]
};

get(2174) ->
	#npc_tpl{
		no = 2174,
		name = <<"未知NPC">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2175) ->
	#npc_tpl{
		no = 2175,
		name = <<"未知NPC">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2123,[{has_one_of_unfinished_task,[1003930]}]}]
};

get(2176) ->
	#npc_tpl{
		no = 2176,
		name = <<"未知NPC">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2124,[{has_one_of_unfinished_task,[1003960]}]}]
};

get(2177) ->
	#npc_tpl{
		no = 2177,
		name = <<"未知NPC">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2178) ->
	#npc_tpl{
		no = 2178,
		name = <<"未知NPC">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2125,[{has_one_of_unfinished_task,[1003980]}]}]
};

get(2179) ->
	#npc_tpl{
		no = 2179,
		name = <<"未知NPC">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2126,[{has_one_of_unfinished_task,[1004040]}]}]
};

get(2180) ->
	#npc_tpl{
		no = 2180,
		name = <<"未知NPC">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2181) ->
	#npc_tpl{
		no = 2181,
		name = <<"未知NPC">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2127,[{has_one_of_unfinished_task,[1004070]}]}]
};

get(2182) ->
	#npc_tpl{
		no = 2182,
		name = <<"未知NPC">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2128,[{has_one_of_unfinished_task,[1004090]}]}]
};

get(2183) ->
	#npc_tpl{
		no = 2183,
		name = <<"未知NPC">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2184) ->
	#npc_tpl{
		no = 2184,
		name = <<"未知NPC">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2129,[{has_one_of_unfinished_task,[1004150]}]}]
};

get(2185) ->
	#npc_tpl{
		no = 2185,
		name = <<"未知NPC">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2130,[{has_one_of_unfinished_task,[1004200]}]}]
};

get(2186) ->
	#npc_tpl{
		no = 2186,
		name = <<"未知NPC">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2131,[{has_one_of_unfinished_task,[1004250]}]}]
};

get(2193) ->
	#npc_tpl{
		no = 2193,
		name = <<"未知NPC">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2139,[{has_one_of_unfinished_task,[1004740]}]}]
};

get(2194) ->
	#npc_tpl{
		no = 2194,
		name = <<"未知NPC">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2132,[{has_one_of_unfinished_task,[1004330]}]}]
};

get(2195) ->
	#npc_tpl{
		no = 2195,
		name = <<"未知NPC">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2196) ->
	#npc_tpl{
		no = 2196,
		name = <<"未知NPC">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2197) ->
	#npc_tpl{
		no = 2197,
		name = <<"未知NPC">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2198) ->
	#npc_tpl{
		no = 2198,
		name = <<"未知NPC">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2199) ->
	#npc_tpl{
		no = 2199,
		name = <<"未知NPC">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2133,[{has_one_of_unfinished_task,[1004440]}]}]
};

get(2200) ->
	#npc_tpl{
		no = 2200,
		name = <<"未知NPC">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2137,[{has_one_of_unfinished_task,[1004640]}]}]
};

get(2201) ->
	#npc_tpl{
		no = 2201,
		name = <<"未知NPC">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2134,[{has_one_of_unfinished_task,[1004460]}]}]
};

get(2202) ->
	#npc_tpl{
		no = 2202,
		name = <<"未知NPC">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2135,[{has_one_of_unfinished_task,[1004490]}]}]
};

get(2203) ->
	#npc_tpl{
		no = 2203,
		name = <<"未知NPC">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2204) ->
	#npc_tpl{
		no = 2204,
		name = <<"未知NPC">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2205) ->
	#npc_tpl{
		no = 2205,
		name = <<"未知NPC">>,
		type = 1,
		race = 3,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2206) ->
	#npc_tpl{
		no = 2206,
		name = <<"未知NPC">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2136,[{has_one_of_unfinished_task,[1004580]}]}]
};

get(2207) ->
	#npc_tpl{
		no = 2207,
		name = <<"未知NPC">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2208) ->
	#npc_tpl{
		no = 2208,
		name = <<"未知NPC">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2138,[{has_one_of_unfinished_task,[1004680]}]}]
};

get(2209) ->
	#npc_tpl{
		no = 2209,
		name = <<"未知NPC">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2210) ->
	#npc_tpl{
		no = 2210,
		name = <<"未知NPC">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2140,[{has_one_of_unfinished_task,[1004800]}]}]
};

get(2211) ->
	#npc_tpl{
		no = 2211,
		name = <<"未知NPC">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2212) ->
	#npc_tpl{
		no = 2212,
		name = <<"未知NPC">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2141,[{has_one_of_unfinished_task,[1004880]}]}]
};

get(2213) ->
	#npc_tpl{
		no = 2213,
		name = <<"未知NPC">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2142,[{has_one_of_unfinished_task,[1004950]}]}]
};

get(2214) ->
	#npc_tpl{
		no = 2214,
		name = <<"未知NPC">>,
		type = 1,
		race = 3,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2215) ->
	#npc_tpl{
		no = 2215,
		name = <<"未知NPC">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2216) ->
	#npc_tpl{
		no = 2216,
		name = <<"未知NPC">>,
		type = 1,
		race = 4,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2143,[{has_one_of_unfinished_task,[1004970]}]}]
};

get(2217) ->
	#npc_tpl{
		no = 2217,
		name = <<"未知NPC">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2218) ->
	#npc_tpl{
		no = 2218,
		name = <<"未知NPC">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2144,[{has_one_of_unfinished_task,[1005060]}]}]
};

get(2219) ->
	#npc_tpl{
		no = 2219,
		name = <<"未知NPC">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2220) ->
	#npc_tpl{
		no = 2220,
		name = <<"墨家首席弟子">>,
		type = 1,
		race = 1,
		faction = 1,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2221) ->
	#npc_tpl{
		no = 2221,
		name = <<"兵家首席弟子">>,
		type = 1,
		race = 1,
		faction = 2,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2222) ->
	#npc_tpl{
		no = 2222,
		name = <<"法家首席弟子">>,
		type = 1,
		race = 2,
		faction = 3,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2223) ->
	#npc_tpl{
		no = 2223,
		name = <<"阴阳家首席弟子">>,
		type = 1,
		race = 2,
		faction = 4,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2224) ->
	#npc_tpl{
		no = 2224,
		name = <<"道家首席弟子">>,
		type = 1,
		race = 3,
		faction = 5,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(2225) ->
	#npc_tpl{
		no = 2225,
		name = <<"儒家首席弟子">>,
		type = 1,
		race = 3,
		faction = 6,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(9093) ->
	#npc_tpl{
		no = 9093,
		name = <<"万鬼王">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2024,[{has_one_of_unfinished_task,[1002160]}]}]
};

get(2901) ->
	#npc_tpl{
		no = 2901,
		name = <<"流氓痞子">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2901,[{has_one_of_unfinished_task,[1030017,1030020,1030023]}]}]
};

get(2902) ->
	#npc_tpl{
		no = 2902,
		name = <<"阴险探子">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2902,[{has_one_of_unfinished_task,[1030018,1030021,1030024]}]}]
};

get(2903) ->
	#npc_tpl{
		no = 2903,
		name = <<"江洋大盗">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2903,[{has_one_of_unfinished_task,[1030019,1030022,1030025]}]}]
};

get(2904) ->
	#npc_tpl{
		no = 2904,
		name = <<"流氓痞子">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2904,[{has_one_of_unfinished_task,[1031017,1031020,1031023]}]}]
};

get(2905) ->
	#npc_tpl{
		no = 2905,
		name = <<"阴险探子">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2905,[{has_one_of_unfinished_task,[1031018,1031021,1031024]}]}]
};

get(2906) ->
	#npc_tpl{
		no = 2906,
		name = <<"江洋大盗">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2906,[{has_one_of_unfinished_task,[1031019,1031022,1031025]}]}]
};

get(2907) ->
	#npc_tpl{
		no = 2907,
		name = <<"流氓痞子">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2907,[{has_one_of_unfinished_task,[1032017,1032020,1032023]}]}]
};

get(2908) ->
	#npc_tpl{
		no = 2908,
		name = <<"阴险探子">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2908,[{has_one_of_unfinished_task,[1032018,1032021,1032024]}]}]
};

get(2909) ->
	#npc_tpl{
		no = 2909,
		name = <<"江洋大盗">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2909,[{has_one_of_unfinished_task,[1032019,1032022,1032025]}]}]
};

get(2910) ->
	#npc_tpl{
		no = 2910,
		name = <<"流氓痞子">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2910,[{has_one_of_unfinished_task,[1033017,1033020,1033023]}]}]
};

get(2911) ->
	#npc_tpl{
		no = 2911,
		name = <<"阴险探子">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2911,[{has_one_of_unfinished_task,[1033018,1033021,1033024]}]}]
};

get(2912) ->
	#npc_tpl{
		no = 2912,
		name = <<"江洋大盗">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2912,[{has_one_of_unfinished_task,[1033019,1033022,1033025]}]}]
};

get(2913) ->
	#npc_tpl{
		no = 2913,
		name = <<"流氓痞子">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2913,[{has_one_of_unfinished_task,[1034026,1034027,1034028,1034029]}]}]
};

get(2914) ->
	#npc_tpl{
		no = 2914,
		name = <<"阴险探子">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2914,[{has_one_of_unfinished_task,[1034030,1034031,1034032]}]}]
};

get(2915) ->
	#npc_tpl{
		no = 2915,
		name = <<"江洋大盗">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2915,[{has_one_of_unfinished_task,[1034033,1034034,1034035]}]}]
};

get(2916) ->
	#npc_tpl{
		no = 2916,
		name = <<"流氓痞子">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2916,[{has_one_of_unfinished_task,[1035026,1035027,1035028,1035029]}]}]
};

get(2917) ->
	#npc_tpl{
		no = 2917,
		name = <<"阴险探子">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2917,[{has_one_of_unfinished_task,[1035030,1035031,1035032]}]}]
};

get(2918) ->
	#npc_tpl{
		no = 2918,
		name = <<"江洋大盗">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2918,[{has_one_of_unfinished_task,[1035033,1035034,1035035]}]}]
};

get(2919) ->
	#npc_tpl{
		no = 2919,
		name = <<"流氓痞子">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2919,[{has_one_of_unfinished_task,[1036026,1036027,1036028,1036029]}]}]
};

get(2920) ->
	#npc_tpl{
		no = 2920,
		name = <<"阴险探子">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2920,[{has_one_of_unfinished_task,[1036030,1036031,1036032]}]}]
};

get(2921) ->
	#npc_tpl{
		no = 2921,
		name = <<"江洋大盗">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2921,[{has_one_of_unfinished_task,[1036033,1036034,1036035]}]}]
};

get(2922) ->
	#npc_tpl{
		no = 2922,
		name = <<"流氓痞子">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2922,[{has_one_of_unfinished_task,[1037026,1037027,1037028,1037029]}]}]
};

get(2923) ->
	#npc_tpl{
		no = 2923,
		name = <<"阴险探子">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2923,[{has_one_of_unfinished_task,[1037030,1037031,1037032]}]}]
};

get(2924) ->
	#npc_tpl{
		no = 2924,
		name = <<"江洋大盗">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,2924,[{has_one_of_unfinished_task,[1037033,1037034,1037035]}]}]
};

get(3001) ->
	#npc_tpl{
		no = 3001,
		name = <<"未知NPC">>,
		type = 8,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 3600*24*60,
		func_list = []
};

get(3101) ->
	#npc_tpl{
		no = 3101,
		name = <<"巡游花车">>,
		type = 9,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 5184000,
		func_list = [join_couple_cruise,close_win]
};

get(3102) ->
	#npc_tpl{
		no = 3102,
		name = <<"豪华花车">>,
		type = 9,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 5184000,
		func_list = [join_couple_cruise,close_win]
};

get(3103) ->
	#npc_tpl{
		no = 3103,
		name = <<"奢华花车">>,
		type = 9,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 5184000,
		func_list = [join_couple_cruise,close_win]
};

get(5001) ->
	#npc_tpl{
		no = 5001,
		name = <<"玉佩">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1000080],30049}]
};

get(5002) ->
	#npc_tpl{
		no = 5002,
		name = <<"玉佩">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(5003) ->
	#npc_tpl{
		no = 5003,
		name = <<"梦蝶花">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(5004) ->
	#npc_tpl{
		no = 5004,
		name = <<"夜明珠">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1000970],30052}]
};

get(5005) ->
	#npc_tpl{
		no = 5005,
		name = <<"幽兰香">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1040139,1040140,1040239,1040240,1040339,1040340,1040439,1040440,1040539,1040540,1040639,1040640,1041134,1041135,1041234,1041235,1041334,1041335,1041434,1041435,1041534,1041535,1041634,1041635],30055}]
};

get(5006) ->
	#npc_tpl{
		no = 5006,
		name = <<"迷迭香">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1001330],30035}]
};

get(5007) ->
	#npc_tpl{
		no = 5007,
		name = <<"蔓陀萝花">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1001350],30036}]
};

get(5008) ->
	#npc_tpl{
		no = 5008,
		name = <<"砖石">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1001420],30037}]
};

get(5009) ->
	#npc_tpl{
		no = 5009,
		name = <<"监牢钥匙">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1001540],30040}]
};

get(5010) ->
	#npc_tpl{
		no = 5010,
		name = <<"奇怪的土堆">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1001670],30057}]
};

get(5011) ->
	#npc_tpl{
		no = 5011,
		name = <<"金疮药">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1001076,1001250],30059}]
};

get(5012) ->
	#npc_tpl{
		no = 5012,
		name = <<"常春藤">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(5013) ->
	#npc_tpl{
		no = 5013,
		name = <<"灵芝">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1001920],30072}]
};

get(5014) ->
	#npc_tpl{
		no = 5014,
		name = <<"珍珠草">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(5015) ->
	#npc_tpl{
		no = 5015,
		name = <<"幻心草">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1002340],30079}]
};

get(5016) ->
	#npc_tpl{
		no = 5016,
		name = <<"秦军宝箱">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1002490],30082}]
};

get(5017) ->
	#npc_tpl{
		no = 5017,
		name = <<"绝世兵器">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1002660],30084}]
};

get(5018) ->
	#npc_tpl{
		no = 5018,
		name = <<"穿心莲">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1042134,1042234,1042334,1042434,1042534,1042634],30085}]
};

get(5019) ->
	#npc_tpl{
		no = 5019,
		name = <<"辛夷花">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1042135,1042235,1042335,1042435,1042535,1042635],30086}]
};

get(5020) ->
	#npc_tpl{
		no = 5020,
		name = <<"益母草">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1042141,1042241,1042341,1042441,1042541,1042641],30087}]
};

get(5021) ->
	#npc_tpl{
		no = 5021,
		name = <<"露水">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1002570],30083}]
};

get(5022) ->
	#npc_tpl{
		no = 5022,
		name = <<"军营钥匙">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1002400],30081}]
};

get(5023) ->
	#npc_tpl{
		no = 5023,
		name = <<"忘忧草">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1002950],30090}]
};

get(5024) ->
	#npc_tpl{
		no = 5024,
		name = <<"解毒草">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1003060],30093}]
};

get(5025) ->
	#npc_tpl{
		no = 5025,
		name = <<"明镜之尘">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1002900],30088}]
};

get(5026) ->
	#npc_tpl{
		no = 5026,
		name = <<"天山圣水">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1003210],30091}]
};

get(5027) ->
	#npc_tpl{
		no = 5027,
		name = <<"不值钱的酒瓶">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[2000004],30012}]
};

get(5028) ->
	#npc_tpl{
		no = 5028,
		name = <<"露水">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1003190],30099}]
};

get(5029) ->
	#npc_tpl{
		no = 5029,
		name = <<"未知NPC">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1003630],30102}]
};

get(5030) ->
	#npc_tpl{
		no = 5030,
		name = <<"未知NPC">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1003700],30104}]
};

get(5031) ->
	#npc_tpl{
		no = 5031,
		name = <<"未知NPC">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1003900],30106}]
};

get(5032) ->
	#npc_tpl{
		no = 5032,
		name = <<"未知NPC">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1004130],30109}]
};

get(5033) ->
	#npc_tpl{
		no = 5033,
		name = <<"未知NPC">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(5034) ->
	#npc_tpl{
		no = 5034,
		name = <<"未知NPC">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1043139,1043239,1043339,1043439,1043539,1043639],30112}]
};

get(5035) ->
	#npc_tpl{
		no = 5035,
		name = <<"未知NPC">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1043140,1043240,1043340,1043440,1043540,1043640],30113}]
};

get(5036) ->
	#npc_tpl{
		no = 5036,
		name = <<"未知NPC">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1043141,1043241,1043341,1043441,1043541,1043641],30114}]
};

get(5037) ->
	#npc_tpl{
		no = 5037,
		name = <<"未知NPC">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1004530],30116}]
};

get(5038) ->
	#npc_tpl{
		no = 5038,
		name = <<"未知NPC">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1004600],30117}]
};

get(5039) ->
	#npc_tpl{
		no = 5039,
		name = <<"未知NPC">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1004720],30119}]
};

get(5040) ->
	#npc_tpl{
		no = 5040,
		name = <<"未知NPC">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1004810],30120}]
};

get(5041) ->
	#npc_tpl{
		no = 5041,
		name = <<"未知NPC">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{collect,[1004890],30122}]
};

get(5500) ->
	#npc_tpl{
		no = 5500,
		name = <<"未知NPC">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 3600*24*60,
		func_list = []
};

get(5501) ->
	#npc_tpl{
		no = 5501,
		name = <<"未知NPC">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 3600*24*60,
		func_list = []
};

get(5502) ->
	#npc_tpl{
		no = 5502,
		name = <<"未知NPC">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 3600*24*60,
		func_list = []
};

get(5503) ->
	#npc_tpl{
		no = 5503,
		name = <<"未知NPC">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 3600*24*60,
		func_list = []
};

get(5504) ->
	#npc_tpl{
		no = 5504,
		name = <<"未知NPC">>,
		type = 5,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 3600*24*60,
		func_list = []
};

get(5801) ->
	#npc_tpl{
		no = 5801,
		name = <<"秘银宝箱">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 3000,
		func_list = [{open_box, 0}]
};

get(4000) ->
	#npc_tpl{
		no = 4000,
		name = <<"传送门">>,
		type = 7,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 86400,
		func_list = []
};

get(4101) ->
	#npc_tpl{
		no = 4101,
		name = <<"地遁鬼">>,
		type = 2,
		race = 2,
		faction = 0,
		sex = 0,
		existing_time = 86400,
		func_list = [employ_hirer]
};

get(4701) ->
	#npc_tpl{
		no = 4701,
		name = <<"异界引路人">>,
		type = 2,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 86400,
		func_list = []
};

get(6001) ->
	#npc_tpl{
		no = 6001,
		name = <<"神秘少女">>,
		type = 6,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(6002) ->
	#npc_tpl{
		no = 6002,
		name = <<"连晋手下">>,
		type = 6,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(6003) ->
	#npc_tpl{
		no = 6003,
		name = <<"连晋手下">>,
		type = 6,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(6004) ->
	#npc_tpl{
		no = 6004,
		name = <<"连晋手下">>,
		type = 6,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(6100) ->
	#npc_tpl{
		no = 6100,
		name = <<"普通战旗">>,
		type = 6,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 3600,
		func_list = []
};

get(6101) ->
	#npc_tpl{
		no = 6101,
		name = <<"果敢战旗">>,
		type = 6,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 3600,
		func_list = []
};

get(6102) ->
	#npc_tpl{
		no = 6102,
		name = <<"振威战旗">>,
		type = 6,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 3600,
		func_list = []
};

get(6103) ->
	#npc_tpl{
		no = 6103,
		name = <<"骁勇战旗">>,
		type = 6,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 3600,
		func_list = []
};

get(6104) ->
	#npc_tpl{
		no = 6104,
		name = <<"未知NPC">>,
		type = 6,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 3600,
		func_list = []
};

get(6105) ->
	#npc_tpl{
		no = 6105,
		name = <<"未知NPC">>,
		type = 6,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 3600,
		func_list = []
};

get(6106) ->
	#npc_tpl{
		no = 6106,
		name = <<"未知NPC">>,
		type = 6,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 3600,
		func_list = []
};

get(6107) ->
	#npc_tpl{
		no = 6107,
		name = <<"未知NPC">>,
		type = 6,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 3600,
		func_list = []
};

get(6108) ->
	#npc_tpl{
		no = 6108,
		name = <<"未知NPC">>,
		type = 6,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 3600,
		func_list = []
};

get(6109) ->
	#npc_tpl{
		no = 6109,
		name = <<"未知NPC">>,
		type = 6,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 5184000,
		func_list = [bless_entry,bless_get]
};

get(6301) ->
	#npc_tpl{
		no = 6301,
		name = <<"未知NPC">>,
		type = 2,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(8001) ->
	#npc_tpl{
		no = 8001,
		name = <<"墨家赋闲弟子">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,505031,[{has_one_of_unfinished_task,[1300002]}]}]
};

get(8002) ->
	#npc_tpl{
		no = 8002,
		name = <<"兵家赋闲弟子">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,505032,[{has_one_of_unfinished_task,[1300003]}]}]
};

get(8003) ->
	#npc_tpl{
		no = 8003,
		name = <<"道家赋闲弟子">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,505033,[{has_one_of_unfinished_task,[1300004]}]}]
};

get(8004) ->
	#npc_tpl{
		no = 8004,
		name = <<"儒家赋闲弟子">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,505034,[{has_one_of_unfinished_task,[1300005]}]}]
};

get(8005) ->
	#npc_tpl{
		no = 8005,
		name = <<"阴阳赋闲弟子">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,505038,[{has_one_of_unfinished_task,[1300006]}]}]
};

get(8006) ->
	#npc_tpl{
		no = 8006,
		name = <<"法家赋闲弟子">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,505039,[{has_one_of_unfinished_task,[1300007]}]}]
};

get(9001) ->
	#npc_tpl{
		no = 9001,
		name = <<"传送无尽战场">>,
		type = 11,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [join_guild_battle1]
};

get(9002) ->
	#npc_tpl{
		no = 9002,
		name = <<"传送无尽战场">>,
		type = 11,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [join_guild_battle1]
};

get(9003) ->
	#npc_tpl{
		no = 9003,
		name = <<"传送无尽战场">>,
		type = 11,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [join_guild_battle1]
};

get(9004) ->
	#npc_tpl{
		no = 9004,
		name = <<"传送无尽战场">>,
		type = 11,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [join_guild_battle1]
};

get(9005) ->
	#npc_tpl{
		no = 9005,
		name = <<"传送无尽战场">>,
		type = 11,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [join_guild_battle1]
};

get(9006) ->
	#npc_tpl{
		no = 9006,
		name = <<"传送海底战场">>,
		type = 11,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [join_guild_battle2]
};

get(9007) ->
	#npc_tpl{
		no = 9007,
		name = <<"传送海底战场">>,
		type = 11,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [join_guild_battle2]
};

get(9008) ->
	#npc_tpl{
		no = 9008,
		name = <<"传送海底战场">>,
		type = 11,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [join_guild_battle2]
};

get(9009) ->
	#npc_tpl{
		no = 9009,
		name = <<"胜者王座">>,
		type = 11,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [join_guild_battle3]
};

get(9000) ->
	#npc_tpl{
		no = 9000,
		name = <<"帮战传送员">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 3600*24*60,
		func_list = [join_guild_battle]
};

get(10001) ->
	#npc_tpl{
		no = 10001,
		name = <<"东邪">>,
		type = 6,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{change_paodian_type, 0},
{change_paodian_type, 1},
{change_paodian_type, 2},
{change_paodian_type, 3},
{change_paodian_type, 4}]
};

get(10002) ->
	#npc_tpl{
		no = 10002,
		name = <<"西毒">>,
		type = 6,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{change_paodian_type, 0},
{change_paodian_type, 1},
{change_paodian_type, 2},
{change_paodian_type, 3},
{change_paodian_type, 4}]
};

get(10003) ->
	#npc_tpl{
		no = 10003,
		name = <<"南帝">>,
		type = 6,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{change_paodian_type, 0},
{change_paodian_type, 1},
{change_paodian_type, 2},
{change_paodian_type, 3},
{change_paodian_type, 4}]
};

get(10004) ->
	#npc_tpl{
		no = 10004,
		name = <<"北丐">>,
		type = 6,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{change_paodian_type, 0},
{change_paodian_type, 1},
{change_paodian_type, 2},
{change_paodian_type, 3},
{change_paodian_type, 4}]
};

get(10005) ->
	#npc_tpl{
		no = 10005,
		name = <<"中神通">>,
		type = 6,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{change_paodian_type, 0},
{change_paodian_type, 1},
{change_paodian_type, 2},
{change_paodian_type, 3},
{change_paodian_type, 4}]
};

get(10006) ->
	#npc_tpl{
		no = 10006,
		name = <<"离场指引员">>,
		type = 6,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [melee_out,hand_in_dragonball]
};

get(10007) ->
	#npc_tpl{
		no = 10007,
		name = <<"青龙">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{goods_exchange,16},{goods_exchange,81}]
};

get(10008) ->
	#npc_tpl{
		no = 10008,
		name = <<"朱雀">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{goods_exchange,15},{goods_exchange,80}]
};

get(10009) ->
	#npc_tpl{
		no = 10009,
		name = <<"麒麟">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{goods_exchange,17},{goods_exchange,82}]
};

get(10010) ->
	#npc_tpl{
		no = 10010,
		name = <<"元始天尊">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{goods_exchange,21}]
};

get(10012) ->
	#npc_tpl{
		no = 10012,
		name = <<"逍遥剑仙">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{goods_exchange,23}]
};

get(10013) ->
	#npc_tpl{
		no = 10013,
		name = <<"修罗武神">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{goods_exchange,24}]
};

get(10014) ->
	#npc_tpl{
		no = 10014,
		name = <<"神荼鬼帝">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{goods_exchange,25}]
};

get(10015) ->
	#npc_tpl{
		no = 10015,
		name = <<"土地">>,
		type = 501,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(10016) ->
	#npc_tpl{
		no = 10016,
		name = <<"土地">>,
		type = 502,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(10017) ->
	#npc_tpl{
		no = 10017,
		name = <<"土地">>,
		type = 503,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(10018) ->
	#npc_tpl{
		no = 10018,
		name = <<"土地">>,
		type = 504,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(10019) ->
	#npc_tpl{
		no = 10019,
		name = <<"土地">>,
		type = 505,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(10020) ->
	#npc_tpl{
		no = 10020,
		name = <<"土地">>,
		type = 506,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(10021) ->
	#npc_tpl{
		no = 10021,
		name = <<"普通炼丹炉">>,
		type = 700,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(10022) ->
	#npc_tpl{
		no = 10022,
		name = <<"普通矿井">>,
		type = 600,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(10023) ->
	#npc_tpl{
		no = 10023,
		name = <<"普通家园">>,
		type = 710,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(10030) ->
	#npc_tpl{
		no = 10030,
		name = <<"异·骨鲲">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{goods_exchange,71}]
};

get(10031) ->
	#npc_tpl{
		no = 10031,
		name = <<"异·玄鲲">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{goods_exchange,72}]
};

get(10032) ->
	#npc_tpl{
		no = 10032,
		name = <<"异·仙鲲">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{goods_exchange,74}]
};

get(10033) ->
	#npc_tpl{
		no = 10033,
		name = <<"异·噬鲲">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{goods_exchange,73}]
};

get(10034) ->
	#npc_tpl{
		no = 10034,
		name = <<"冰雪年兽">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{goods_exchange,54}]
};

get(5900) ->
	#npc_tpl{
		no = 5900,
		name = <<"龙须草">>,
		type = 10,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 604800,
		func_list = []
};

get(5901) ->
	#npc_tpl{
		no = 5901,
		name = <<"月见草">>,
		type = 10,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 604800,
		func_list = []
};

get(5902) ->
	#npc_tpl{
		no = 5902,
		name = <<"四叶花">>,
		type = 10,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 604800,
		func_list = []
};

get(2400) ->
	#npc_tpl{
		no = 2400,
		name = <<"山贼头目">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,800484,[{has_one_of_unfinished_task,[1081017,1081020,1081023]}]}]
};

get(2401) ->
	#npc_tpl{
		no = 2401,
		name = <<"无赖赌徒">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,800485,[{has_one_of_unfinished_task,[1081018,1081021,1081024]}]}]
};

get(2402) ->
	#npc_tpl{
		no = 2402,
		name = <<"强盗帮凶">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,800486,[{has_one_of_unfinished_task,[1081019,1081022,1081025]}]}]
};

get(2403) ->
	#npc_tpl{
		no = 2403,
		name = <<"山贼头目">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,800487,[{has_one_of_unfinished_task,[1082017,1082020,1082023]}]}]
};

get(2404) ->
	#npc_tpl{
		no = 2404,
		name = <<"无赖赌徒">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,800488,[{has_one_of_unfinished_task,[1082018,1082021,1082024]}]}]
};

get(2405) ->
	#npc_tpl{
		no = 2405,
		name = <<"强盗帮凶">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,800489,[{has_one_of_unfinished_task,[1082019,1082022,1082025]}]}]
};

get(2406) ->
	#npc_tpl{
		no = 2406,
		name = <<"路人丙">>,
		type = 1,
		race = 3,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = []
};

get(10038) ->
	#npc_tpl{
		no = 10038,
		name = <<"昂日星官">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{goods_exchange,93}]
};

get(10039) ->
	#npc_tpl{
		no = 10039,
		name = <<"谷雨娘娘">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{goods_exchange,94}]
};

get(10041) ->
	#npc_tpl{
		no = 10041,
		name = <<"易物">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [exchange]
};

get(10040) ->
	#npc_tpl{
		no = 10040,
		name = <<"吸血鬼">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{goods_exchange,95}]
};

get(10035) ->
	#npc_tpl{
		no = 10035,
		name = <<"彩灵儿">>,
		type = 1,
		race = 0,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{goods_exchange,55}]
};

get(1036) ->
	#npc_tpl{
		no = 1036,
		name = <<"帮派驿夫">>,
		type = 1,
		race = 3,
		faction = 0,
		sex = 0,
		existing_time = 3600*24*60,
		func_list = [{teleport, [200,201,109]}]
};

get(1032) ->
	#npc_tpl{
		no = 1032,
		name = <<"店小二">>,
		type = 1,
		race = 1,
		faction = 0,
		sex = 0,
		existing_time = 0,
		func_list = [{trigger_mf,800470,[{has_one_of_unfinished_task,[1300022]}]}]
};

get(_No) ->
	      ?ASSERT(false, _No),
          null.

