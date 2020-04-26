%%%---------------------------------------
%%% @Module  : data_stall_config
%%% @Author  : 段世和
%%% @Email   :
%%% @Description: 摆摊系统配置
%%%---------------------------------------


-module(data_stall_config).
-export([get_ids/0, get/1]).
-include("market.hrl").
-include("debug.hrl").

get_ids()->
	[1001,1002,1003,1004,1005,1006,1007,1008,1009,1051,1052,1053,1054,1055,1056,1057,1058,1059,2001,2002,2003,2004,2005,2006,2007,2008,2009,2051,2052,2053,2054,2055,2056,2057,2058,2059,3001,3002,3003,3004,3005,3006,3007,3008,3009,4101,4102,4103,4104,4105,4106,4107,4108,4109,4151,4152,4153,4154,4155,4156,4157,4158,4159,4201,4202,4203,4204,4205,4206,4207,4208,4209,4251,4252,4253,4254,4255,4256,4257,4258,4259,4301,4302,4303,4304,4305,4306,4307,4308,4309,4351,4352,4353,4354,4355,4356,4357,4358,4359,5001,5002,5003,5004,5005,5006,5007,5008,5009,6001,6002,6003,6004,6005,6006,6007,6008,6009,7001,7002,7003,7004,7005,7006,7007,7008,7009,7010,7011,7012,7013,7014,7015,7016,7017,7018,7019,7020,7021,7022,7023,7024,7025,7026,7027,7028,7029,7030,7031,7032,7033,7034,7035,7036,7037,7038,7039,7040,7041,7042,7043,7044,7045,7046,7047,7048,10001,10002,10003,10004,10005,10006,10007,10008,10023,10024,10025,10026,10027,10028,10029,10030,10031,10032,10033,10034,10035,10036,10037,10039,10102,10103,10201,10202,10203,10204,10205,10206,10207,10208,10209,10210,10211,10212,10213,10214,10215,10216,10217,10218,10219,10220,10221,10222,10223,10224,10225,10226,10227,10228,10229,10230,10231,10232,10233,10234,10235,20001,20002,20003,20005,20006,20007,20009,20010,20011,20013,20014,20015,20016,20017,20019,20020,20021,20023,50038,50046,50047,50048,50049,50050,50051,50052,50053,50054,50055,50056,50057,50058,50059,50060,50061,50062,50063,50064,50065,50066,50067,50068,50069,50070,50071,50072,50073,50074,50075,50076,50077,50078,50079,50080,50081,50082,50083,50084,50307,50310,50311,50312,50313,50314,50315,50317,50318,50319,50320,50321,50323,50324,50325,50326,50327,50329,50330,50331,50339,50340,50341,50342,50430,50431,50432,50433,50434,50435,50436,50437,50438,50439,50440,50441,50442,50443,50444,50445,50446,50447,50448,50449,55001,55007,55013,55019,55025,55031,55037,55043,55049,55055,55061,55067,55073,55074,55075,55076,55077,55078,55079,55080,55081,55082,55083,55084,55085,55086,55087,55088,55089,55090,55096,55102,55108,55114,55120,55162,55163,55164,55170,55176,55182,55188,55194,55200,55206,55212,55218,55224,55230,55236,55242,55248,55254,55260,55261,55262,60039,60040,60101,62032,62161,70011,70012,70013,70014,70101,70102,70103,70104,70105,70106,70107,70108,70109,70110,70111,70112,70113,70114,70115,70116,70117,70118,70119,70120,70121,70122,70123,70124,70125,70126,70127,70128,70129,70130,70131,70132,70133,70134,70135,70136,70137,70138,70139,70140,70141,70142,70143,70144,70145,70146,70147,70148,70149,70150,70241,70242,70243,70244,70245,70246,70247,70248,70249,70250,70301,70302,70303,70304,70305,70306,70307,70308,70309,70310,70311,70312,70313,70314,70315,70316,70317,70318,70319,70320,70341,70342,70343,70344,70345,70346,70347,70348,70349,70350,72007,72008,72009,72010,72017,72018,72019,72020,72027,72028,72029,72030,72037,72038,72039,72040,72047,72048,72049,72050,72057,72058,72059,72060,72067,72068,72069,72070,72077,72078,72079,72080,72087,72088,72089,72090,72097,72098,72099,72100,72107,72108,72109,72110,72117,72118,72119,72120,72127,72128,72129,72130,72141,72142,72143,72144,72145,72146,72147,72148,72149,72150,72151,72152,72153,72154,72155,72156,72157,72158,72159,72160,72161,72162,72163,72164,72165,72166,72167,72168,72169,72170,72177,72178,72179,72180,201001,201002,201003,201004,201005,201006,201007,201008,201009,201010,201011,201051,201052,201053,201054,201055,201056,201057,201058,201059,201060,201061,202001,202002,202003,202004,202005,202006,202007,202008,202009,202010,202011,202051,202052,202053,202054,202055,202056,202057,202058,202059,202060,202061,203001,203002,203003,203004,203005,203006,203007,203008,203009,203010,203011,204101,204102,204103,204104,204105,204106,204107,204108,204109,204110,204111,204151,204152,204153,204154,204155,204156,204157,204158,204159,204160,204161,204201,204202,204203,204204,204205,204206,204207,204208,204209,204210,204211,204251,204252,204253,204254,204255,204256,204257,204258,204259,204260,204261,204301,204302,204303,204304,204305,204306,204307,204308,204309,204310,204311,204351,204352,204353,204354,204355,204356,204357,204358,204359,204360,204361,205001,205002,205003,205004,205005,205006,205007,205008,205009,205010,205011,206001,206002,206003,206004,206005,206006,206007,206008,206009,206010,206011,308101,308103,308104,308151,308153,308154,308201,308251,308301,308351,318101,318103,318104,318151,318153,318154,318201,318251,318301,318351].

get(20001) ->
	#data_stall_config{
		no = 20001,
		type = 9,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(20005) ->
	#data_stall_config{
		no = 20005,
		type = 9,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(20009) ->
	#data_stall_config{
		no = 20009,
		type = 9,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(20015) ->
	#data_stall_config{
		no = 20015,
		type = 9,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(20019) ->
	#data_stall_config{
		no = 20019,
		type = 9,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(20002) ->
	#data_stall_config{
		no = 20002,
		type = 9,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(20006) ->
	#data_stall_config{
		no = 20006,
		type = 9,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(20010) ->
	#data_stall_config{
		no = 20010,
		type = 9,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(20016) ->
	#data_stall_config{
		no = 20016,
		type = 9,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(20020) ->
	#data_stall_config{
		no = 20020,
		type = 9,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(20003) ->
	#data_stall_config{
		no = 20003,
		type = 9,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(20007) ->
	#data_stall_config{
		no = 20007,
		type = 9,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(20011) ->
	#data_stall_config{
		no = 20011,
		type = 9,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(20017) ->
	#data_stall_config{
		no = 20017,
		type = 9,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(20021) ->
	#data_stall_config{
		no = 20021,
		type = 9,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(20013) ->
	#data_stall_config{
		no = 20013,
		type = 9,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(20014) ->
	#data_stall_config{
		no = 20014,
		type = 9,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(20023) ->
	#data_stall_config{
		no = 20023,
		type = 9,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(50061) ->
	#data_stall_config{
		no = 50061,
		type = 1,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(50062) ->
	#data_stall_config{
		no = 50062,
		type = 1,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(50063) ->
	#data_stall_config{
		no = 50063,
		type = 1,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(50064) ->
	#data_stall_config{
		no = 50064,
		type = 1,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(50065) ->
	#data_stall_config{
		no = 50065,
		type = 1,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(50066) ->
	#data_stall_config{
		no = 50066,
		type = 1,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(50067) ->
	#data_stall_config{
		no = 50067,
		type = 1,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(50068) ->
	#data_stall_config{
		no = 50068,
		type = 1,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(50069) ->
	#data_stall_config{
		no = 50069,
		type = 1,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(50070) ->
	#data_stall_config{
		no = 50070,
		type = 1,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(50071) ->
	#data_stall_config{
		no = 50071,
		type = 1,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(50075) ->
	#data_stall_config{
		no = 50075,
		type = 1,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(50076) ->
	#data_stall_config{
		no = 50076,
		type = 1,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(50077) ->
	#data_stall_config{
		no = 50077,
		type = 1,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(50078) ->
	#data_stall_config{
		no = 50078,
		type = 1,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(50079) ->
	#data_stall_config{
		no = 50079,
		type = 1,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(50080) ->
	#data_stall_config{
		no = 50080,
		type = 1,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(50081) ->
	#data_stall_config{
		no = 50081,
		type = 1,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(50082) ->
	#data_stall_config{
		no = 50082,
		type = 1,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(50083) ->
	#data_stall_config{
		no = 50083,
		type = 1,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(50084) ->
	#data_stall_config{
		no = 50084,
		type = 1,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(50315) ->
	#data_stall_config{
		no = 50315,
		type = 1,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(50323) ->
	#data_stall_config{
		no = 50323,
		type = 1,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(50324) ->
	#data_stall_config{
		no = 50324,
		type = 1,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(50325) ->
	#data_stall_config{
		no = 50325,
		type = 1,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(50326) ->
	#data_stall_config{
		no = 50326,
		type = 1,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(50327) ->
	#data_stall_config{
		no = 50327,
		type = 1,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(50339) ->
	#data_stall_config{
		no = 50339,
		type = 1,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(50340) ->
	#data_stall_config{
		no = 50340,
		type = 1,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(50341) ->
	#data_stall_config{
		no = 50341,
		type = 1,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(50342) ->
	#data_stall_config{
		no = 50342,
		type = 1,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(50430) ->
	#data_stall_config{
		no = 50430,
		type = 1,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(50431) ->
	#data_stall_config{
		no = 50431,
		type = 1,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(50432) ->
	#data_stall_config{
		no = 50432,
		type = 1,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(50433) ->
	#data_stall_config{
		no = 50433,
		type = 1,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(50072) ->
	#data_stall_config{
		no = 50072,
		type = 1,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(50073) ->
	#data_stall_config{
		no = 50073,
		type = 1,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(50074) ->
	#data_stall_config{
		no = 50074,
		type = 1,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(50329) ->
	#data_stall_config{
		no = 50329,
		type = 1,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(50330) ->
	#data_stall_config{
		no = 50330,
		type = 1,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(50331) ->
	#data_stall_config{
		no = 50331,
		type = 1,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(50434) ->
	#data_stall_config{
		no = 50434,
		type = 1,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 2000
};

get(50435) ->
	#data_stall_config{
		no = 50435,
		type = 1,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 2000
};

get(50436) ->
	#data_stall_config{
		no = 50436,
		type = 1,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 2000
};

get(50437) ->
	#data_stall_config{
		no = 50437,
		type = 1,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 2000
};

get(50438) ->
	#data_stall_config{
		no = 50438,
		type = 1,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 2000
};

get(50439) ->
	#data_stall_config{
		no = 50439,
		type = 1,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 2000
};

get(50440) ->
	#data_stall_config{
		no = 50440,
		type = 1,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 2000
};

get(50441) ->
	#data_stall_config{
		no = 50441,
		type = 1,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 2000
};

get(50442) ->
	#data_stall_config{
		no = 50442,
		type = 1,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 2000
};

get(50443) ->
	#data_stall_config{
		no = 50443,
		type = 1,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 2000
};

get(50444) ->
	#data_stall_config{
		no = 50444,
		type = 1,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 2000
};

get(50445) ->
	#data_stall_config{
		no = 50445,
		type = 1,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 2000
};

get(50446) ->
	#data_stall_config{
		no = 50446,
		type = 1,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 2000
};

get(50310) ->
	#data_stall_config{
		no = 50310,
		type = 1,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 2000
};

get(50311) ->
	#data_stall_config{
		no = 50311,
		type = 1,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 2000
};

get(50312) ->
	#data_stall_config{
		no = 50312,
		type = 1,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 2000
};

get(50313) ->
	#data_stall_config{
		no = 50313,
		type = 1,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 2000
};

get(50314) ->
	#data_stall_config{
		no = 50314,
		type = 1,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 2000
};

get(50317) ->
	#data_stall_config{
		no = 50317,
		type = 1,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 2000
};

get(50318) ->
	#data_stall_config{
		no = 50318,
		type = 1,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 2000
};

get(50319) ->
	#data_stall_config{
		no = 50319,
		type = 1,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 2000
};

get(50320) ->
	#data_stall_config{
		no = 50320,
		type = 1,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 2000
};

get(50321) ->
	#data_stall_config{
		no = 50321,
		type = 1,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 2000
};

get(50046) ->
	#data_stall_config{
		no = 50046,
		type = 1,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 2000
};

get(50047) ->
	#data_stall_config{
		no = 50047,
		type = 1,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 2000
};

get(50048) ->
	#data_stall_config{
		no = 50048,
		type = 1,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 2000
};

get(50049) ->
	#data_stall_config{
		no = 50049,
		type = 1,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 2000
};

get(50050) ->
	#data_stall_config{
		no = 50050,
		type = 1,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 2000
};

get(50051) ->
	#data_stall_config{
		no = 50051,
		type = 1,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 2000
};

get(50052) ->
	#data_stall_config{
		no = 50052,
		type = 1,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 2000
};

get(50053) ->
	#data_stall_config{
		no = 50053,
		type = 1,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 2000
};

get(50054) ->
	#data_stall_config{
		no = 50054,
		type = 1,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 2000
};

get(50055) ->
	#data_stall_config{
		no = 50055,
		type = 1,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 2000
};

get(50056) ->
	#data_stall_config{
		no = 50056,
		type = 1,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 2000
};

get(50060) ->
	#data_stall_config{
		no = 50060,
		type = 1,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 2000
};

get(50057) ->
	#data_stall_config{
		no = 50057,
		type = 1,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 2000
};

get(50058) ->
	#data_stall_config{
		no = 50058,
		type = 1,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 2000
};

get(50059) ->
	#data_stall_config{
		no = 50059,
		type = 1,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 2000
};

get(50447) ->
	#data_stall_config{
		no = 50447,
		type = 1,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 2000
};

get(50448) ->
	#data_stall_config{
		no = 50448,
		type = 1,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 2000
};

get(50449) ->
	#data_stall_config{
		no = 50449,
		type = 1,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 2000
};

get(55073) ->
	#data_stall_config{
		no = 55073,
		type = 1,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(55074) ->
	#data_stall_config{
		no = 55074,
		type = 1,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(55075) ->
	#data_stall_config{
		no = 55075,
		type = 1,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(55076) ->
	#data_stall_config{
		no = 55076,
		type = 1,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(55077) ->
	#data_stall_config{
		no = 55077,
		type = 1,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(55078) ->
	#data_stall_config{
		no = 55078,
		type = 1,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(55079) ->
	#data_stall_config{
		no = 55079,
		type = 1,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(55080) ->
	#data_stall_config{
		no = 55080,
		type = 1,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(55081) ->
	#data_stall_config{
		no = 55081,
		type = 1,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(55082) ->
	#data_stall_config{
		no = 55082,
		type = 1,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(55083) ->
	#data_stall_config{
		no = 55083,
		type = 1,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(55084) ->
	#data_stall_config{
		no = 55084,
		type = 1,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(55085) ->
	#data_stall_config{
		no = 55085,
		type = 1,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(55086) ->
	#data_stall_config{
		no = 55086,
		type = 1,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(55087) ->
	#data_stall_config{
		no = 55087,
		type = 1,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(55088) ->
	#data_stall_config{
		no = 55088,
		type = 1,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(55089) ->
	#data_stall_config{
		no = 55089,
		type = 1,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(55162) ->
	#data_stall_config{
		no = 55162,
		type = 1,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(55163) ->
	#data_stall_config{
		no = 55163,
		type = 1,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(55260) ->
	#data_stall_config{
		no = 55260,
		type = 1,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(55261) ->
	#data_stall_config{
		no = 55261,
		type = 1,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(55262) ->
	#data_stall_config{
		no = 55262,
		type = 1,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(4101) ->
	#data_stall_config{
		no = 4101,
		type = 3,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 5
};

get(4102) ->
	#data_stall_config{
		no = 4102,
		type = 3,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 11
};

get(4103) ->
	#data_stall_config{
		no = 4103,
		type = 3,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 23
};

get(4104) ->
	#data_stall_config{
		no = 4104,
		type = 3,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 42
};

get(4105) ->
	#data_stall_config{
		no = 4105,
		type = 3,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 74
};

get(4106) ->
	#data_stall_config{
		no = 4106,
		type = 3,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 123
};

get(4107) ->
	#data_stall_config{
		no = 4107,
		type = 3,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 198
};

get(4108) ->
	#data_stall_config{
		no = 4108,
		type = 3,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 314
};

get(4109) ->
	#data_stall_config{
		no = 4109,
		type = 3,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 489
};

get(4151) ->
	#data_stall_config{
		no = 4151,
		type = 3,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 5
};

get(4152) ->
	#data_stall_config{
		no = 4152,
		type = 3,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 11
};

get(4153) ->
	#data_stall_config{
		no = 4153,
		type = 3,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 23
};

get(4154) ->
	#data_stall_config{
		no = 4154,
		type = 3,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 42
};

get(4155) ->
	#data_stall_config{
		no = 4155,
		type = 3,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 74
};

get(4156) ->
	#data_stall_config{
		no = 4156,
		type = 3,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 123
};

get(4157) ->
	#data_stall_config{
		no = 4157,
		type = 3,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 198
};

get(4158) ->
	#data_stall_config{
		no = 4158,
		type = 3,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 314
};

get(4159) ->
	#data_stall_config{
		no = 4159,
		type = 3,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 489
};

get(4201) ->
	#data_stall_config{
		no = 4201,
		type = 3,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 5
};

get(4202) ->
	#data_stall_config{
		no = 4202,
		type = 3,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 11
};

get(4203) ->
	#data_stall_config{
		no = 4203,
		type = 3,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 23
};

get(4204) ->
	#data_stall_config{
		no = 4204,
		type = 3,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 42
};

get(4205) ->
	#data_stall_config{
		no = 4205,
		type = 3,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 74
};

get(4206) ->
	#data_stall_config{
		no = 4206,
		type = 3,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 123
};

get(4207) ->
	#data_stall_config{
		no = 4207,
		type = 3,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 198
};

get(4208) ->
	#data_stall_config{
		no = 4208,
		type = 3,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 314
};

get(4209) ->
	#data_stall_config{
		no = 4209,
		type = 3,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 489
};

get(4251) ->
	#data_stall_config{
		no = 4251,
		type = 3,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 5
};

get(4252) ->
	#data_stall_config{
		no = 4252,
		type = 3,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 11
};

get(4253) ->
	#data_stall_config{
		no = 4253,
		type = 3,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 23
};

get(4254) ->
	#data_stall_config{
		no = 4254,
		type = 3,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 42
};

get(4255) ->
	#data_stall_config{
		no = 4255,
		type = 3,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 74
};

get(4256) ->
	#data_stall_config{
		no = 4256,
		type = 3,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 123
};

get(4257) ->
	#data_stall_config{
		no = 4257,
		type = 3,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 198
};

get(4258) ->
	#data_stall_config{
		no = 4258,
		type = 3,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 314
};

get(4259) ->
	#data_stall_config{
		no = 4259,
		type = 3,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 489
};

get(4301) ->
	#data_stall_config{
		no = 4301,
		type = 3,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 5
};

get(4302) ->
	#data_stall_config{
		no = 4302,
		type = 3,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 11
};

get(4303) ->
	#data_stall_config{
		no = 4303,
		type = 3,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 23
};

get(4304) ->
	#data_stall_config{
		no = 4304,
		type = 3,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 42
};

get(4305) ->
	#data_stall_config{
		no = 4305,
		type = 3,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 74
};

get(4306) ->
	#data_stall_config{
		no = 4306,
		type = 3,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 123
};

get(4307) ->
	#data_stall_config{
		no = 4307,
		type = 3,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 198
};

get(4308) ->
	#data_stall_config{
		no = 4308,
		type = 3,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 314
};

get(4309) ->
	#data_stall_config{
		no = 4309,
		type = 3,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 489
};

get(4351) ->
	#data_stall_config{
		no = 4351,
		type = 3,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 5
};

get(4352) ->
	#data_stall_config{
		no = 4352,
		type = 3,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 11
};

get(4353) ->
	#data_stall_config{
		no = 4353,
		type = 3,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 23
};

get(4354) ->
	#data_stall_config{
		no = 4354,
		type = 3,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 42
};

get(4355) ->
	#data_stall_config{
		no = 4355,
		type = 3,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 74
};

get(4356) ->
	#data_stall_config{
		no = 4356,
		type = 3,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 123
};

get(4357) ->
	#data_stall_config{
		no = 4357,
		type = 3,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 198
};

get(4358) ->
	#data_stall_config{
		no = 4358,
		type = 3,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 314
};

get(4359) ->
	#data_stall_config{
		no = 4359,
		type = 3,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 489
};

get(1001) ->
	#data_stall_config{
		no = 1001,
		type = 3,
		sub_type = 7,
		bind_state = 2,
		price_type = 9,
		price = 5
};

get(1002) ->
	#data_stall_config{
		no = 1002,
		type = 3,
		sub_type = 7,
		bind_state = 2,
		price_type = 9,
		price = 11
};

get(1003) ->
	#data_stall_config{
		no = 1003,
		type = 3,
		sub_type = 7,
		bind_state = 2,
		price_type = 9,
		price = 23
};

get(1004) ->
	#data_stall_config{
		no = 1004,
		type = 3,
		sub_type = 7,
		bind_state = 2,
		price_type = 9,
		price = 42
};

get(1005) ->
	#data_stall_config{
		no = 1005,
		type = 3,
		sub_type = 7,
		bind_state = 2,
		price_type = 9,
		price = 74
};

get(1006) ->
	#data_stall_config{
		no = 1006,
		type = 3,
		sub_type = 7,
		bind_state = 2,
		price_type = 9,
		price = 123
};

get(1007) ->
	#data_stall_config{
		no = 1007,
		type = 3,
		sub_type = 7,
		bind_state = 2,
		price_type = 9,
		price = 198
};

get(1008) ->
	#data_stall_config{
		no = 1008,
		type = 3,
		sub_type = 7,
		bind_state = 2,
		price_type = 9,
		price = 314
};

get(1009) ->
	#data_stall_config{
		no = 1009,
		type = 3,
		sub_type = 7,
		bind_state = 2,
		price_type = 9,
		price = 489
};

get(1051) ->
	#data_stall_config{
		no = 1051,
		type = 3,
		sub_type = 8,
		bind_state = 2,
		price_type = 9,
		price = 5
};

get(1052) ->
	#data_stall_config{
		no = 1052,
		type = 3,
		sub_type = 8,
		bind_state = 2,
		price_type = 9,
		price = 11
};

get(1053) ->
	#data_stall_config{
		no = 1053,
		type = 3,
		sub_type = 8,
		bind_state = 2,
		price_type = 9,
		price = 23
};

get(1054) ->
	#data_stall_config{
		no = 1054,
		type = 3,
		sub_type = 8,
		bind_state = 2,
		price_type = 9,
		price = 42
};

get(1055) ->
	#data_stall_config{
		no = 1055,
		type = 3,
		sub_type = 8,
		bind_state = 2,
		price_type = 9,
		price = 74
};

get(1056) ->
	#data_stall_config{
		no = 1056,
		type = 3,
		sub_type = 8,
		bind_state = 2,
		price_type = 9,
		price = 123
};

get(1057) ->
	#data_stall_config{
		no = 1057,
		type = 3,
		sub_type = 8,
		bind_state = 2,
		price_type = 9,
		price = 198
};

get(1058) ->
	#data_stall_config{
		no = 1058,
		type = 3,
		sub_type = 8,
		bind_state = 2,
		price_type = 9,
		price = 314
};

get(1059) ->
	#data_stall_config{
		no = 1059,
		type = 3,
		sub_type = 8,
		bind_state = 2,
		price_type = 9,
		price = 489
};

get(2001) ->
	#data_stall_config{
		no = 2001,
		type = 3,
		sub_type = 9,
		bind_state = 2,
		price_type = 9,
		price = 5
};

get(2002) ->
	#data_stall_config{
		no = 2002,
		type = 3,
		sub_type = 9,
		bind_state = 2,
		price_type = 9,
		price = 11
};

get(2003) ->
	#data_stall_config{
		no = 2003,
		type = 3,
		sub_type = 9,
		bind_state = 2,
		price_type = 9,
		price = 23
};

get(2004) ->
	#data_stall_config{
		no = 2004,
		type = 3,
		sub_type = 9,
		bind_state = 2,
		price_type = 9,
		price = 42
};

get(2005) ->
	#data_stall_config{
		no = 2005,
		type = 3,
		sub_type = 9,
		bind_state = 2,
		price_type = 9,
		price = 74
};

get(2006) ->
	#data_stall_config{
		no = 2006,
		type = 3,
		sub_type = 9,
		bind_state = 2,
		price_type = 9,
		price = 123
};

get(2007) ->
	#data_stall_config{
		no = 2007,
		type = 3,
		sub_type = 9,
		bind_state = 2,
		price_type = 9,
		price = 198
};

get(2008) ->
	#data_stall_config{
		no = 2008,
		type = 3,
		sub_type = 9,
		bind_state = 2,
		price_type = 9,
		price = 314
};

get(2009) ->
	#data_stall_config{
		no = 2009,
		type = 3,
		sub_type = 9,
		bind_state = 2,
		price_type = 9,
		price = 489
};

get(2051) ->
	#data_stall_config{
		no = 2051,
		type = 3,
		sub_type = 10,
		bind_state = 2,
		price_type = 9,
		price = 5
};

get(2052) ->
	#data_stall_config{
		no = 2052,
		type = 3,
		sub_type = 10,
		bind_state = 2,
		price_type = 9,
		price = 11
};

get(2053) ->
	#data_stall_config{
		no = 2053,
		type = 3,
		sub_type = 10,
		bind_state = 2,
		price_type = 9,
		price = 23
};

get(2054) ->
	#data_stall_config{
		no = 2054,
		type = 3,
		sub_type = 10,
		bind_state = 2,
		price_type = 9,
		price = 42
};

get(2055) ->
	#data_stall_config{
		no = 2055,
		type = 3,
		sub_type = 10,
		bind_state = 2,
		price_type = 9,
		price = 74
};

get(2056) ->
	#data_stall_config{
		no = 2056,
		type = 3,
		sub_type = 10,
		bind_state = 2,
		price_type = 9,
		price = 123
};

get(2057) ->
	#data_stall_config{
		no = 2057,
		type = 3,
		sub_type = 10,
		bind_state = 2,
		price_type = 9,
		price = 198
};

get(2058) ->
	#data_stall_config{
		no = 2058,
		type = 3,
		sub_type = 10,
		bind_state = 2,
		price_type = 9,
		price = 314
};

get(2059) ->
	#data_stall_config{
		no = 2059,
		type = 3,
		sub_type = 10,
		bind_state = 2,
		price_type = 9,
		price = 489
};

get(3001) ->
	#data_stall_config{
		no = 3001,
		type = 3,
		sub_type = 11,
		bind_state = 2,
		price_type = 9,
		price = 5
};

get(3002) ->
	#data_stall_config{
		no = 3002,
		type = 3,
		sub_type = 11,
		bind_state = 2,
		price_type = 9,
		price = 11
};

get(3003) ->
	#data_stall_config{
		no = 3003,
		type = 3,
		sub_type = 11,
		bind_state = 2,
		price_type = 9,
		price = 23
};

get(3004) ->
	#data_stall_config{
		no = 3004,
		type = 3,
		sub_type = 11,
		bind_state = 2,
		price_type = 9,
		price = 42
};

get(3005) ->
	#data_stall_config{
		no = 3005,
		type = 3,
		sub_type = 11,
		bind_state = 2,
		price_type = 9,
		price = 74
};

get(3006) ->
	#data_stall_config{
		no = 3006,
		type = 3,
		sub_type = 11,
		bind_state = 2,
		price_type = 9,
		price = 123
};

get(3007) ->
	#data_stall_config{
		no = 3007,
		type = 3,
		sub_type = 11,
		bind_state = 2,
		price_type = 9,
		price = 198
};

get(3008) ->
	#data_stall_config{
		no = 3008,
		type = 3,
		sub_type = 11,
		bind_state = 2,
		price_type = 9,
		price = 314
};

get(3009) ->
	#data_stall_config{
		no = 3009,
		type = 3,
		sub_type = 11,
		bind_state = 2,
		price_type = 9,
		price = 489
};

get(6001) ->
	#data_stall_config{
		no = 6001,
		type = 3,
		sub_type = 12,
		bind_state = 2,
		price_type = 9,
		price = 5
};

get(6002) ->
	#data_stall_config{
		no = 6002,
		type = 3,
		sub_type = 12,
		bind_state = 2,
		price_type = 9,
		price = 11
};

get(6003) ->
	#data_stall_config{
		no = 6003,
		type = 3,
		sub_type = 12,
		bind_state = 2,
		price_type = 9,
		price = 23
};

get(6004) ->
	#data_stall_config{
		no = 6004,
		type = 3,
		sub_type = 12,
		bind_state = 2,
		price_type = 9,
		price = 42
};

get(6005) ->
	#data_stall_config{
		no = 6005,
		type = 3,
		sub_type = 12,
		bind_state = 2,
		price_type = 9,
		price = 74
};

get(6006) ->
	#data_stall_config{
		no = 6006,
		type = 3,
		sub_type = 12,
		bind_state = 2,
		price_type = 9,
		price = 123
};

get(6007) ->
	#data_stall_config{
		no = 6007,
		type = 3,
		sub_type = 12,
		bind_state = 2,
		price_type = 9,
		price = 198
};

get(6008) ->
	#data_stall_config{
		no = 6008,
		type = 3,
		sub_type = 12,
		bind_state = 2,
		price_type = 9,
		price = 314
};

get(6009) ->
	#data_stall_config{
		no = 6009,
		type = 3,
		sub_type = 12,
		bind_state = 2,
		price_type = 9,
		price = 489
};

get(5001) ->
	#data_stall_config{
		no = 5001,
		type = 3,
		sub_type = 13,
		bind_state = 2,
		price_type = 9,
		price = 5
};

get(5002) ->
	#data_stall_config{
		no = 5002,
		type = 3,
		sub_type = 13,
		bind_state = 2,
		price_type = 9,
		price = 11
};

get(5003) ->
	#data_stall_config{
		no = 5003,
		type = 3,
		sub_type = 13,
		bind_state = 2,
		price_type = 9,
		price = 23
};

get(5004) ->
	#data_stall_config{
		no = 5004,
		type = 3,
		sub_type = 13,
		bind_state = 2,
		price_type = 9,
		price = 42
};

get(5005) ->
	#data_stall_config{
		no = 5005,
		type = 3,
		sub_type = 13,
		bind_state = 2,
		price_type = 9,
		price = 74
};

get(5006) ->
	#data_stall_config{
		no = 5006,
		type = 3,
		sub_type = 13,
		bind_state = 2,
		price_type = 9,
		price = 123
};

get(5007) ->
	#data_stall_config{
		no = 5007,
		type = 3,
		sub_type = 13,
		bind_state = 2,
		price_type = 9,
		price = 198
};

get(5008) ->
	#data_stall_config{
		no = 5008,
		type = 3,
		sub_type = 13,
		bind_state = 2,
		price_type = 9,
		price = 314
};

get(5009) ->
	#data_stall_config{
		no = 5009,
		type = 3,
		sub_type = 13,
		bind_state = 2,
		price_type = 9,
		price = 489
};

get(7001) ->
	#data_stall_config{
		no = 7001,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 200
};

get(7002) ->
	#data_stall_config{
		no = 7002,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 200
};

get(7003) ->
	#data_stall_config{
		no = 7003,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 200
};

get(7004) ->
	#data_stall_config{
		no = 7004,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 200
};

get(7005) ->
	#data_stall_config{
		no = 7005,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 200
};

get(7006) ->
	#data_stall_config{
		no = 7006,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 200
};

get(7007) ->
	#data_stall_config{
		no = 7007,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 200
};

get(7008) ->
	#data_stall_config{
		no = 7008,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 200
};

get(7009) ->
	#data_stall_config{
		no = 7009,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 200
};

get(7010) ->
	#data_stall_config{
		no = 7010,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 200
};

get(7011) ->
	#data_stall_config{
		no = 7011,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 200
};

get(7012) ->
	#data_stall_config{
		no = 7012,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 200
};

get(7013) ->
	#data_stall_config{
		no = 7013,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 500
};

get(7014) ->
	#data_stall_config{
		no = 7014,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 500
};

get(7015) ->
	#data_stall_config{
		no = 7015,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 500
};

get(7016) ->
	#data_stall_config{
		no = 7016,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 500
};

get(7017) ->
	#data_stall_config{
		no = 7017,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 500
};

get(7018) ->
	#data_stall_config{
		no = 7018,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 500
};

get(7019) ->
	#data_stall_config{
		no = 7019,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 500
};

get(7020) ->
	#data_stall_config{
		no = 7020,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 500
};

get(7021) ->
	#data_stall_config{
		no = 7021,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 500
};

get(7022) ->
	#data_stall_config{
		no = 7022,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 500
};

get(7023) ->
	#data_stall_config{
		no = 7023,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 500
};

get(7024) ->
	#data_stall_config{
		no = 7024,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 500
};

get(7025) ->
	#data_stall_config{
		no = 7025,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 1600
};

get(7026) ->
	#data_stall_config{
		no = 7026,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 1600
};

get(7027) ->
	#data_stall_config{
		no = 7027,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 1600
};

get(7028) ->
	#data_stall_config{
		no = 7028,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 1600
};

get(7029) ->
	#data_stall_config{
		no = 7029,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 1600
};

get(7030) ->
	#data_stall_config{
		no = 7030,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 1600
};

get(7031) ->
	#data_stall_config{
		no = 7031,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 1600
};

get(7032) ->
	#data_stall_config{
		no = 7032,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 1600
};

get(7033) ->
	#data_stall_config{
		no = 7033,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 1600
};

get(7034) ->
	#data_stall_config{
		no = 7034,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 1600
};

get(7035) ->
	#data_stall_config{
		no = 7035,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 1600
};

get(7036) ->
	#data_stall_config{
		no = 7036,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 1600
};

get(7037) ->
	#data_stall_config{
		no = 7037,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(7038) ->
	#data_stall_config{
		no = 7038,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(7039) ->
	#data_stall_config{
		no = 7039,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(7040) ->
	#data_stall_config{
		no = 7040,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(7041) ->
	#data_stall_config{
		no = 7041,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(7042) ->
	#data_stall_config{
		no = 7042,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(7043) ->
	#data_stall_config{
		no = 7043,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(7044) ->
	#data_stall_config{
		no = 7044,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(7045) ->
	#data_stall_config{
		no = 7045,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(7046) ->
	#data_stall_config{
		no = 7046,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(7047) ->
	#data_stall_config{
		no = 7047,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(7048) ->
	#data_stall_config{
		no = 7048,
		type = 5,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(10031) ->
	#data_stall_config{
		no = 10031,
		type = 2,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 50
};

get(10032) ->
	#data_stall_config{
		no = 10032,
		type = 2,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 50
};

get(10033) ->
	#data_stall_config{
		no = 10033,
		type = 2,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 50
};

get(10034) ->
	#data_stall_config{
		no = 10034,
		type = 2,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 50
};

get(10035) ->
	#data_stall_config{
		no = 10035,
		type = 2,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 100
};

get(10036) ->
	#data_stall_config{
		no = 10036,
		type = 2,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 100
};

get(10037) ->
	#data_stall_config{
		no = 10037,
		type = 2,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 100
};

get(10039) ->
	#data_stall_config{
		no = 10039,
		type = 2,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 100
};

get(10005) ->
	#data_stall_config{
		no = 10005,
		type = 2,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 300
};

get(10006) ->
	#data_stall_config{
		no = 10006,
		type = 2,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 300
};

get(10007) ->
	#data_stall_config{
		no = 10007,
		type = 2,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 300
};

get(10008) ->
	#data_stall_config{
		no = 10008,
		type = 2,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 300
};

get(10023) ->
	#data_stall_config{
		no = 10023,
		type = 2,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 10
};

get(10024) ->
	#data_stall_config{
		no = 10024,
		type = 2,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 10
};

get(10025) ->
	#data_stall_config{
		no = 10025,
		type = 2,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 10
};

get(10026) ->
	#data_stall_config{
		no = 10026,
		type = 2,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 10
};

get(10027) ->
	#data_stall_config{
		no = 10027,
		type = 2,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 18
};

get(10028) ->
	#data_stall_config{
		no = 10028,
		type = 2,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 18
};

get(10029) ->
	#data_stall_config{
		no = 10029,
		type = 2,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 18
};

get(10030) ->
	#data_stall_config{
		no = 10030,
		type = 2,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 18
};

get(10001) ->
	#data_stall_config{
		no = 10001,
		type = 2,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 80
};

get(10002) ->
	#data_stall_config{
		no = 10002,
		type = 2,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 80
};

get(10003) ->
	#data_stall_config{
		no = 10003,
		type = 2,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 80
};

get(10004) ->
	#data_stall_config{
		no = 10004,
		type = 2,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 80
};

get(72141) ->
	#data_stall_config{
		no = 72141,
		type = 2,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 30
};

get(72142) ->
	#data_stall_config{
		no = 72142,
		type = 2,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 60
};

get(72143) ->
	#data_stall_config{
		no = 72143,
		type = 2,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 90
};

get(72144) ->
	#data_stall_config{
		no = 72144,
		type = 2,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 120
};

get(72145) ->
	#data_stall_config{
		no = 72145,
		type = 2,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 150
};

get(72146) ->
	#data_stall_config{
		no = 72146,
		type = 2,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 200
};

get(72147) ->
	#data_stall_config{
		no = 72147,
		type = 2,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 250
};

get(72148) ->
	#data_stall_config{
		no = 72148,
		type = 2,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 300
};

get(72149) ->
	#data_stall_config{
		no = 72149,
		type = 2,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 500
};

get(72150) ->
	#data_stall_config{
		no = 72150,
		type = 2,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 500
};

get(72151) ->
	#data_stall_config{
		no = 72151,
		type = 2,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 30
};

get(72152) ->
	#data_stall_config{
		no = 72152,
		type = 2,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 60
};

get(72153) ->
	#data_stall_config{
		no = 72153,
		type = 2,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 90
};

get(72154) ->
	#data_stall_config{
		no = 72154,
		type = 2,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 120
};

get(72155) ->
	#data_stall_config{
		no = 72155,
		type = 2,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 150
};

get(72156) ->
	#data_stall_config{
		no = 72156,
		type = 2,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 200
};

get(72157) ->
	#data_stall_config{
		no = 72157,
		type = 2,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 250
};

get(72158) ->
	#data_stall_config{
		no = 72158,
		type = 2,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 300
};

get(72159) ->
	#data_stall_config{
		no = 72159,
		type = 2,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 500
};

get(72160) ->
	#data_stall_config{
		no = 72160,
		type = 2,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 500
};

get(72161) ->
	#data_stall_config{
		no = 72161,
		type = 2,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 30
};

get(72162) ->
	#data_stall_config{
		no = 72162,
		type = 2,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 60
};

get(72163) ->
	#data_stall_config{
		no = 72163,
		type = 2,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 90
};

get(72164) ->
	#data_stall_config{
		no = 72164,
		type = 2,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 120
};

get(72165) ->
	#data_stall_config{
		no = 72165,
		type = 2,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 150
};

get(72166) ->
	#data_stall_config{
		no = 72166,
		type = 2,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 200
};

get(72167) ->
	#data_stall_config{
		no = 72167,
		type = 2,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 250
};

get(72168) ->
	#data_stall_config{
		no = 72168,
		type = 2,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 300
};

get(72169) ->
	#data_stall_config{
		no = 72169,
		type = 2,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 300
};

get(72170) ->
	#data_stall_config{
		no = 72170,
		type = 2,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 500
};

get(72127) ->
	#data_stall_config{
		no = 72127,
		type = 2,
		sub_type = 20,
		bind_state = 2,
		price_type = 9,
		price = 3200
};

get(72128) ->
	#data_stall_config{
		no = 72128,
		type = 2,
		sub_type = 20,
		bind_state = 2,
		price_type = 9,
		price = 6400
};

get(72129) ->
	#data_stall_config{
		no = 72129,
		type = 2,
		sub_type = 20,
		bind_state = 2,
		price_type = 9,
		price = 9600
};

get(72130) ->
	#data_stall_config{
		no = 72130,
		type = 2,
		sub_type = 20,
		bind_state = 2,
		price_type = 9,
		price = 12800
};

get(72007) ->
	#data_stall_config{
		no = 72007,
		type = 2,
		sub_type = 7,
		bind_state = 2,
		price_type = 9,
		price = 3200
};

get(72008) ->
	#data_stall_config{
		no = 72008,
		type = 2,
		sub_type = 7,
		bind_state = 2,
		price_type = 9,
		price = 6400
};

get(72009) ->
	#data_stall_config{
		no = 72009,
		type = 2,
		sub_type = 7,
		bind_state = 2,
		price_type = 9,
		price = 9600
};

get(72010) ->
	#data_stall_config{
		no = 72010,
		type = 2,
		sub_type = 7,
		bind_state = 2,
		price_type = 9,
		price = 12800
};

get(72017) ->
	#data_stall_config{
		no = 72017,
		type = 2,
		sub_type = 8,
		bind_state = 2,
		price_type = 9,
		price = 3200
};

get(72018) ->
	#data_stall_config{
		no = 72018,
		type = 2,
		sub_type = 8,
		bind_state = 2,
		price_type = 9,
		price = 6400
};

get(72019) ->
	#data_stall_config{
		no = 72019,
		type = 2,
		sub_type = 8,
		bind_state = 2,
		price_type = 9,
		price = 9600
};

get(72020) ->
	#data_stall_config{
		no = 72020,
		type = 2,
		sub_type = 8,
		bind_state = 2,
		price_type = 9,
		price = 12800
};

get(72027) ->
	#data_stall_config{
		no = 72027,
		type = 2,
		sub_type = 9,
		bind_state = 2,
		price_type = 9,
		price = 3200
};

get(72028) ->
	#data_stall_config{
		no = 72028,
		type = 2,
		sub_type = 9,
		bind_state = 2,
		price_type = 9,
		price = 6400
};

get(72029) ->
	#data_stall_config{
		no = 72029,
		type = 2,
		sub_type = 9,
		bind_state = 2,
		price_type = 9,
		price = 9600
};

get(72030) ->
	#data_stall_config{
		no = 72030,
		type = 2,
		sub_type = 9,
		bind_state = 2,
		price_type = 9,
		price = 12800
};

get(72037) ->
	#data_stall_config{
		no = 72037,
		type = 2,
		sub_type = 10,
		bind_state = 2,
		price_type = 9,
		price = 3200
};

get(72038) ->
	#data_stall_config{
		no = 72038,
		type = 2,
		sub_type = 10,
		bind_state = 2,
		price_type = 9,
		price = 6400
};

get(72039) ->
	#data_stall_config{
		no = 72039,
		type = 2,
		sub_type = 10,
		bind_state = 2,
		price_type = 9,
		price = 9600
};

get(72040) ->
	#data_stall_config{
		no = 72040,
		type = 2,
		sub_type = 10,
		bind_state = 2,
		price_type = 9,
		price = 12800
};

get(72047) ->
	#data_stall_config{
		no = 72047,
		type = 2,
		sub_type = 11,
		bind_state = 2,
		price_type = 9,
		price = 3200
};

get(72048) ->
	#data_stall_config{
		no = 72048,
		type = 2,
		sub_type = 11,
		bind_state = 2,
		price_type = 9,
		price = 6400
};

get(72049) ->
	#data_stall_config{
		no = 72049,
		type = 2,
		sub_type = 11,
		bind_state = 2,
		price_type = 9,
		price = 9600
};

get(72050) ->
	#data_stall_config{
		no = 72050,
		type = 2,
		sub_type = 11,
		bind_state = 2,
		price_type = 9,
		price = 12800
};

get(72057) ->
	#data_stall_config{
		no = 72057,
		type = 2,
		sub_type = 12,
		bind_state = 2,
		price_type = 9,
		price = 3200
};

get(72058) ->
	#data_stall_config{
		no = 72058,
		type = 2,
		sub_type = 12,
		bind_state = 2,
		price_type = 9,
		price = 6400
};

get(72059) ->
	#data_stall_config{
		no = 72059,
		type = 2,
		sub_type = 12,
		bind_state = 2,
		price_type = 9,
		price = 9600
};

get(72060) ->
	#data_stall_config{
		no = 72060,
		type = 2,
		sub_type = 12,
		bind_state = 2,
		price_type = 9,
		price = 12800
};

get(72067) ->
	#data_stall_config{
		no = 72067,
		type = 2,
		sub_type = 13,
		bind_state = 2,
		price_type = 9,
		price = 3200
};

get(72068) ->
	#data_stall_config{
		no = 72068,
		type = 2,
		sub_type = 13,
		bind_state = 2,
		price_type = 9,
		price = 6400
};

get(72069) ->
	#data_stall_config{
		no = 72069,
		type = 2,
		sub_type = 13,
		bind_state = 2,
		price_type = 9,
		price = 9600
};

get(72070) ->
	#data_stall_config{
		no = 72070,
		type = 2,
		sub_type = 13,
		bind_state = 2,
		price_type = 9,
		price = 12800
};

get(72077) ->
	#data_stall_config{
		no = 72077,
		type = 2,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 3200
};

get(72078) ->
	#data_stall_config{
		no = 72078,
		type = 2,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 6400
};

get(72079) ->
	#data_stall_config{
		no = 72079,
		type = 2,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 9600
};

get(72080) ->
	#data_stall_config{
		no = 72080,
		type = 2,
		sub_type = 14,
		bind_state = 2,
		price_type = 9,
		price = 12800
};

get(72087) ->
	#data_stall_config{
		no = 72087,
		type = 2,
		sub_type = 15,
		bind_state = 2,
		price_type = 9,
		price = 3200
};

get(72088) ->
	#data_stall_config{
		no = 72088,
		type = 2,
		sub_type = 15,
		bind_state = 2,
		price_type = 9,
		price = 6400
};

get(72089) ->
	#data_stall_config{
		no = 72089,
		type = 2,
		sub_type = 15,
		bind_state = 2,
		price_type = 9,
		price = 9600
};

get(72090) ->
	#data_stall_config{
		no = 72090,
		type = 2,
		sub_type = 15,
		bind_state = 2,
		price_type = 9,
		price = 12800
};

get(72097) ->
	#data_stall_config{
		no = 72097,
		type = 2,
		sub_type = 16,
		bind_state = 2,
		price_type = 9,
		price = 3200
};

get(72098) ->
	#data_stall_config{
		no = 72098,
		type = 2,
		sub_type = 16,
		bind_state = 2,
		price_type = 9,
		price = 6400
};

get(72099) ->
	#data_stall_config{
		no = 72099,
		type = 2,
		sub_type = 16,
		bind_state = 2,
		price_type = 9,
		price = 9600
};

get(72100) ->
	#data_stall_config{
		no = 72100,
		type = 2,
		sub_type = 16,
		bind_state = 2,
		price_type = 9,
		price = 12800
};

get(72107) ->
	#data_stall_config{
		no = 72107,
		type = 2,
		sub_type = 17,
		bind_state = 2,
		price_type = 9,
		price = 3200
};

get(72108) ->
	#data_stall_config{
		no = 72108,
		type = 2,
		sub_type = 17,
		bind_state = 2,
		price_type = 9,
		price = 6400
};

get(72109) ->
	#data_stall_config{
		no = 72109,
		type = 2,
		sub_type = 17,
		bind_state = 2,
		price_type = 9,
		price = 9600
};

get(72110) ->
	#data_stall_config{
		no = 72110,
		type = 2,
		sub_type = 17,
		bind_state = 2,
		price_type = 9,
		price = 12800
};

get(72117) ->
	#data_stall_config{
		no = 72117,
		type = 2,
		sub_type = 18,
		bind_state = 2,
		price_type = 9,
		price = 3200
};

get(72118) ->
	#data_stall_config{
		no = 72118,
		type = 2,
		sub_type = 18,
		bind_state = 2,
		price_type = 9,
		price = 6400
};

get(72119) ->
	#data_stall_config{
		no = 72119,
		type = 2,
		sub_type = 18,
		bind_state = 2,
		price_type = 9,
		price = 9600
};

get(72120) ->
	#data_stall_config{
		no = 72120,
		type = 2,
		sub_type = 18,
		bind_state = 2,
		price_type = 9,
		price = 12800
};

get(72177) ->
	#data_stall_config{
		no = 72177,
		type = 2,
		sub_type = 19,
		bind_state = 2,
		price_type = 9,
		price = 3200
};

get(72178) ->
	#data_stall_config{
		no = 72178,
		type = 2,
		sub_type = 19,
		bind_state = 2,
		price_type = 9,
		price = 6400
};

get(72179) ->
	#data_stall_config{
		no = 72179,
		type = 2,
		sub_type = 19,
		bind_state = 2,
		price_type = 9,
		price = 9600
};

get(72180) ->
	#data_stall_config{
		no = 72180,
		type = 2,
		sub_type = 19,
		bind_state = 2,
		price_type = 9,
		price = 12800
};

get(60101) ->
	#data_stall_config{
		no = 60101,
		type = 4,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 10000
};

get(62032) ->
	#data_stall_config{
		no = 62032,
		type = 4,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 10000
};

get(204101) ->
	#data_stall_config{
		no = 204101,
		type = 5,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204102) ->
	#data_stall_config{
		no = 204102,
		type = 5,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204103) ->
	#data_stall_config{
		no = 204103,
		type = 5,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204104) ->
	#data_stall_config{
		no = 204104,
		type = 5,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204105) ->
	#data_stall_config{
		no = 204105,
		type = 5,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204106) ->
	#data_stall_config{
		no = 204106,
		type = 5,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204107) ->
	#data_stall_config{
		no = 204107,
		type = 5,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204108) ->
	#data_stall_config{
		no = 204108,
		type = 5,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204109) ->
	#data_stall_config{
		no = 204109,
		type = 5,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204110) ->
	#data_stall_config{
		no = 204110,
		type = 5,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204111) ->
	#data_stall_config{
		no = 204111,
		type = 5,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204151) ->
	#data_stall_config{
		no = 204151,
		type = 5,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204152) ->
	#data_stall_config{
		no = 204152,
		type = 5,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204153) ->
	#data_stall_config{
		no = 204153,
		type = 5,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204154) ->
	#data_stall_config{
		no = 204154,
		type = 5,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204155) ->
	#data_stall_config{
		no = 204155,
		type = 5,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204156) ->
	#data_stall_config{
		no = 204156,
		type = 5,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204157) ->
	#data_stall_config{
		no = 204157,
		type = 5,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204158) ->
	#data_stall_config{
		no = 204158,
		type = 5,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204159) ->
	#data_stall_config{
		no = 204159,
		type = 5,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204160) ->
	#data_stall_config{
		no = 204160,
		type = 5,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204161) ->
	#data_stall_config{
		no = 204161,
		type = 5,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204201) ->
	#data_stall_config{
		no = 204201,
		type = 5,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204202) ->
	#data_stall_config{
		no = 204202,
		type = 5,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204203) ->
	#data_stall_config{
		no = 204203,
		type = 5,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204204) ->
	#data_stall_config{
		no = 204204,
		type = 5,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204205) ->
	#data_stall_config{
		no = 204205,
		type = 5,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204206) ->
	#data_stall_config{
		no = 204206,
		type = 5,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204207) ->
	#data_stall_config{
		no = 204207,
		type = 5,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204208) ->
	#data_stall_config{
		no = 204208,
		type = 5,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204209) ->
	#data_stall_config{
		no = 204209,
		type = 5,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204210) ->
	#data_stall_config{
		no = 204210,
		type = 5,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204211) ->
	#data_stall_config{
		no = 204211,
		type = 5,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204251) ->
	#data_stall_config{
		no = 204251,
		type = 5,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204252) ->
	#data_stall_config{
		no = 204252,
		type = 5,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204253) ->
	#data_stall_config{
		no = 204253,
		type = 5,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204254) ->
	#data_stall_config{
		no = 204254,
		type = 5,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204255) ->
	#data_stall_config{
		no = 204255,
		type = 5,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204256) ->
	#data_stall_config{
		no = 204256,
		type = 5,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204257) ->
	#data_stall_config{
		no = 204257,
		type = 5,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204258) ->
	#data_stall_config{
		no = 204258,
		type = 5,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204259) ->
	#data_stall_config{
		no = 204259,
		type = 5,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204260) ->
	#data_stall_config{
		no = 204260,
		type = 5,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204261) ->
	#data_stall_config{
		no = 204261,
		type = 5,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204301) ->
	#data_stall_config{
		no = 204301,
		type = 5,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204302) ->
	#data_stall_config{
		no = 204302,
		type = 5,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204303) ->
	#data_stall_config{
		no = 204303,
		type = 5,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204304) ->
	#data_stall_config{
		no = 204304,
		type = 5,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204305) ->
	#data_stall_config{
		no = 204305,
		type = 5,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204306) ->
	#data_stall_config{
		no = 204306,
		type = 5,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204307) ->
	#data_stall_config{
		no = 204307,
		type = 5,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204308) ->
	#data_stall_config{
		no = 204308,
		type = 5,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204309) ->
	#data_stall_config{
		no = 204309,
		type = 5,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204310) ->
	#data_stall_config{
		no = 204310,
		type = 5,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204311) ->
	#data_stall_config{
		no = 204311,
		type = 5,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204351) ->
	#data_stall_config{
		no = 204351,
		type = 5,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204352) ->
	#data_stall_config{
		no = 204352,
		type = 5,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204353) ->
	#data_stall_config{
		no = 204353,
		type = 5,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204354) ->
	#data_stall_config{
		no = 204354,
		type = 5,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204355) ->
	#data_stall_config{
		no = 204355,
		type = 5,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204356) ->
	#data_stall_config{
		no = 204356,
		type = 5,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204357) ->
	#data_stall_config{
		no = 204357,
		type = 5,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204358) ->
	#data_stall_config{
		no = 204358,
		type = 5,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204359) ->
	#data_stall_config{
		no = 204359,
		type = 5,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204360) ->
	#data_stall_config{
		no = 204360,
		type = 5,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(204361) ->
	#data_stall_config{
		no = 204361,
		type = 5,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(201001) ->
	#data_stall_config{
		no = 201001,
		type = 5,
		sub_type = 7,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(201002) ->
	#data_stall_config{
		no = 201002,
		type = 5,
		sub_type = 7,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(201003) ->
	#data_stall_config{
		no = 201003,
		type = 5,
		sub_type = 7,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(201004) ->
	#data_stall_config{
		no = 201004,
		type = 5,
		sub_type = 7,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(201005) ->
	#data_stall_config{
		no = 201005,
		type = 5,
		sub_type = 7,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(201006) ->
	#data_stall_config{
		no = 201006,
		type = 5,
		sub_type = 7,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(201007) ->
	#data_stall_config{
		no = 201007,
		type = 5,
		sub_type = 7,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(201008) ->
	#data_stall_config{
		no = 201008,
		type = 5,
		sub_type = 7,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(201009) ->
	#data_stall_config{
		no = 201009,
		type = 5,
		sub_type = 7,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(201010) ->
	#data_stall_config{
		no = 201010,
		type = 5,
		sub_type = 7,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(201011) ->
	#data_stall_config{
		no = 201011,
		type = 5,
		sub_type = 7,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(201051) ->
	#data_stall_config{
		no = 201051,
		type = 5,
		sub_type = 8,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(201052) ->
	#data_stall_config{
		no = 201052,
		type = 5,
		sub_type = 8,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(201053) ->
	#data_stall_config{
		no = 201053,
		type = 5,
		sub_type = 8,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(201054) ->
	#data_stall_config{
		no = 201054,
		type = 5,
		sub_type = 8,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(201055) ->
	#data_stall_config{
		no = 201055,
		type = 5,
		sub_type = 8,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(201056) ->
	#data_stall_config{
		no = 201056,
		type = 5,
		sub_type = 8,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(201057) ->
	#data_stall_config{
		no = 201057,
		type = 5,
		sub_type = 8,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(201058) ->
	#data_stall_config{
		no = 201058,
		type = 5,
		sub_type = 8,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(201059) ->
	#data_stall_config{
		no = 201059,
		type = 5,
		sub_type = 8,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(201060) ->
	#data_stall_config{
		no = 201060,
		type = 5,
		sub_type = 8,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(201061) ->
	#data_stall_config{
		no = 201061,
		type = 5,
		sub_type = 8,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(202001) ->
	#data_stall_config{
		no = 202001,
		type = 5,
		sub_type = 9,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(202002) ->
	#data_stall_config{
		no = 202002,
		type = 5,
		sub_type = 9,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(202003) ->
	#data_stall_config{
		no = 202003,
		type = 5,
		sub_type = 9,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(202004) ->
	#data_stall_config{
		no = 202004,
		type = 5,
		sub_type = 9,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(202005) ->
	#data_stall_config{
		no = 202005,
		type = 5,
		sub_type = 9,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(202006) ->
	#data_stall_config{
		no = 202006,
		type = 5,
		sub_type = 9,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(202007) ->
	#data_stall_config{
		no = 202007,
		type = 5,
		sub_type = 9,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(202008) ->
	#data_stall_config{
		no = 202008,
		type = 5,
		sub_type = 9,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(202009) ->
	#data_stall_config{
		no = 202009,
		type = 5,
		sub_type = 9,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(202010) ->
	#data_stall_config{
		no = 202010,
		type = 5,
		sub_type = 9,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(202011) ->
	#data_stall_config{
		no = 202011,
		type = 5,
		sub_type = 9,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(202051) ->
	#data_stall_config{
		no = 202051,
		type = 5,
		sub_type = 10,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(202052) ->
	#data_stall_config{
		no = 202052,
		type = 5,
		sub_type = 10,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(202053) ->
	#data_stall_config{
		no = 202053,
		type = 5,
		sub_type = 10,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(202054) ->
	#data_stall_config{
		no = 202054,
		type = 5,
		sub_type = 10,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(202055) ->
	#data_stall_config{
		no = 202055,
		type = 5,
		sub_type = 10,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(202056) ->
	#data_stall_config{
		no = 202056,
		type = 5,
		sub_type = 10,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(202057) ->
	#data_stall_config{
		no = 202057,
		type = 5,
		sub_type = 10,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(202058) ->
	#data_stall_config{
		no = 202058,
		type = 5,
		sub_type = 10,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(202059) ->
	#data_stall_config{
		no = 202059,
		type = 5,
		sub_type = 10,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(202060) ->
	#data_stall_config{
		no = 202060,
		type = 5,
		sub_type = 10,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(202061) ->
	#data_stall_config{
		no = 202061,
		type = 5,
		sub_type = 10,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(203001) ->
	#data_stall_config{
		no = 203001,
		type = 5,
		sub_type = 11,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(203002) ->
	#data_stall_config{
		no = 203002,
		type = 5,
		sub_type = 11,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(203003) ->
	#data_stall_config{
		no = 203003,
		type = 5,
		sub_type = 11,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(203004) ->
	#data_stall_config{
		no = 203004,
		type = 5,
		sub_type = 11,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(203005) ->
	#data_stall_config{
		no = 203005,
		type = 5,
		sub_type = 11,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(203006) ->
	#data_stall_config{
		no = 203006,
		type = 5,
		sub_type = 11,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(203007) ->
	#data_stall_config{
		no = 203007,
		type = 5,
		sub_type = 11,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(203008) ->
	#data_stall_config{
		no = 203008,
		type = 5,
		sub_type = 11,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(203009) ->
	#data_stall_config{
		no = 203009,
		type = 5,
		sub_type = 11,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(203010) ->
	#data_stall_config{
		no = 203010,
		type = 5,
		sub_type = 11,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(203011) ->
	#data_stall_config{
		no = 203011,
		type = 5,
		sub_type = 11,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(206001) ->
	#data_stall_config{
		no = 206001,
		type = 5,
		sub_type = 12,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(206002) ->
	#data_stall_config{
		no = 206002,
		type = 5,
		sub_type = 12,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(206003) ->
	#data_stall_config{
		no = 206003,
		type = 5,
		sub_type = 12,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(206004) ->
	#data_stall_config{
		no = 206004,
		type = 5,
		sub_type = 12,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(206005) ->
	#data_stall_config{
		no = 206005,
		type = 5,
		sub_type = 12,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(206006) ->
	#data_stall_config{
		no = 206006,
		type = 5,
		sub_type = 12,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(206007) ->
	#data_stall_config{
		no = 206007,
		type = 5,
		sub_type = 12,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(206008) ->
	#data_stall_config{
		no = 206008,
		type = 5,
		sub_type = 12,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(206009) ->
	#data_stall_config{
		no = 206009,
		type = 5,
		sub_type = 12,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(206010) ->
	#data_stall_config{
		no = 206010,
		type = 5,
		sub_type = 12,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(206011) ->
	#data_stall_config{
		no = 206011,
		type = 5,
		sub_type = 12,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(205001) ->
	#data_stall_config{
		no = 205001,
		type = 5,
		sub_type = 13,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(205002) ->
	#data_stall_config{
		no = 205002,
		type = 5,
		sub_type = 13,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(205003) ->
	#data_stall_config{
		no = 205003,
		type = 5,
		sub_type = 13,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(205004) ->
	#data_stall_config{
		no = 205004,
		type = 5,
		sub_type = 13,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(205005) ->
	#data_stall_config{
		no = 205005,
		type = 5,
		sub_type = 13,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(205006) ->
	#data_stall_config{
		no = 205006,
		type = 5,
		sub_type = 13,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(205007) ->
	#data_stall_config{
		no = 205007,
		type = 5,
		sub_type = 13,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(205008) ->
	#data_stall_config{
		no = 205008,
		type = 5,
		sub_type = 13,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(205009) ->
	#data_stall_config{
		no = 205009,
		type = 5,
		sub_type = 13,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(205010) ->
	#data_stall_config{
		no = 205010,
		type = 5,
		sub_type = 13,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(205011) ->
	#data_stall_config{
		no = 205011,
		type = 5,
		sub_type = 13,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(55037) ->
	#data_stall_config{
		no = 55037,
		type = 1,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 100
};

get(55164) ->
	#data_stall_config{
		no = 55164,
		type = 1,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 100
};

get(55170) ->
	#data_stall_config{
		no = 55170,
		type = 1,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 100
};

get(55019) ->
	#data_stall_config{
		no = 55019,
		type = 1,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 200
};

get(55013) ->
	#data_stall_config{
		no = 55013,
		type = 1,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 200
};

get(55007) ->
	#data_stall_config{
		no = 55007,
		type = 1,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 350
};

get(55061) ->
	#data_stall_config{
		no = 55061,
		type = 1,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 350
};

get(55025) ->
	#data_stall_config{
		no = 55025,
		type = 1,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 550
};

get(55043) ->
	#data_stall_config{
		no = 55043,
		type = 1,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 550
};

get(55031) ->
	#data_stall_config{
		no = 55031,
		type = 1,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 800
};

get(55055) ->
	#data_stall_config{
		no = 55055,
		type = 1,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 800
};

get(55176) ->
	#data_stall_config{
		no = 55176,
		type = 1,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 1100
};

get(55182) ->
	#data_stall_config{
		no = 55182,
		type = 1,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 1100
};

get(55188) ->
	#data_stall_config{
		no = 55188,
		type = 1,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 1500
};

get(55194) ->
	#data_stall_config{
		no = 55194,
		type = 1,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 1500
};

get(55200) ->
	#data_stall_config{
		no = 55200,
		type = 1,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 2000
};

get(55206) ->
	#data_stall_config{
		no = 55206,
		type = 1,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 2000
};

get(55001) ->
	#data_stall_config{
		no = 55001,
		type = 1,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(55067) ->
	#data_stall_config{
		no = 55067,
		type = 1,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(55224) ->
	#data_stall_config{
		no = 55224,
		type = 1,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(55049) ->
	#data_stall_config{
		no = 55049,
		type = 1,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(55218) ->
	#data_stall_config{
		no = 55218,
		type = 1,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(55212) ->
	#data_stall_config{
		no = 55212,
		type = 1,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(55120) ->
	#data_stall_config{
		no = 55120,
		type = 1,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(55236) ->
	#data_stall_config{
		no = 55236,
		type = 1,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(55230) ->
	#data_stall_config{
		no = 55230,
		type = 1,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(55242) ->
	#data_stall_config{
		no = 55242,
		type = 1,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(55248) ->
	#data_stall_config{
		no = 55248,
		type = 1,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(55254) ->
	#data_stall_config{
		no = 55254,
		type = 1,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(55090) ->
	#data_stall_config{
		no = 55090,
		type = 1,
		sub_type = 7,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(55096) ->
	#data_stall_config{
		no = 55096,
		type = 1,
		sub_type = 7,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(55102) ->
	#data_stall_config{
		no = 55102,
		type = 1,
		sub_type = 7,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(55108) ->
	#data_stall_config{
		no = 55108,
		type = 1,
		sub_type = 7,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(55114) ->
	#data_stall_config{
		no = 55114,
		type = 1,
		sub_type = 7,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(62161) ->
	#data_stall_config{
		no = 62161,
		type = 7,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(308101) ->
	#data_stall_config{
		no = 308101,
		type = 7,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(308151) ->
	#data_stall_config{
		no = 308151,
		type = 7,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(308201) ->
	#data_stall_config{
		no = 308201,
		type = 7,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(308251) ->
	#data_stall_config{
		no = 308251,
		type = 7,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(308301) ->
	#data_stall_config{
		no = 308301,
		type = 7,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(308351) ->
	#data_stall_config{
		no = 308351,
		type = 7,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(308103) ->
	#data_stall_config{
		no = 308103,
		type = 7,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(308153) ->
	#data_stall_config{
		no = 308153,
		type = 7,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(308104) ->
	#data_stall_config{
		no = 308104,
		type = 7,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(308154) ->
	#data_stall_config{
		no = 308154,
		type = 7,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(318101) ->
	#data_stall_config{
		no = 318101,
		type = 7,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(318151) ->
	#data_stall_config{
		no = 318151,
		type = 7,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(318201) ->
	#data_stall_config{
		no = 318201,
		type = 7,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(318251) ->
	#data_stall_config{
		no = 318251,
		type = 7,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(318301) ->
	#data_stall_config{
		no = 318301,
		type = 7,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(318351) ->
	#data_stall_config{
		no = 318351,
		type = 7,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(318103) ->
	#data_stall_config{
		no = 318103,
		type = 7,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(318153) ->
	#data_stall_config{
		no = 318153,
		type = 7,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(318104) ->
	#data_stall_config{
		no = 318104,
		type = 7,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(318154) ->
	#data_stall_config{
		no = 318154,
		type = 7,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(10102) ->
	#data_stall_config{
		no = 10102,
		type = 7,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(10103) ->
	#data_stall_config{
		no = 10103,
		type = 7,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(10201) ->
	#data_stall_config{
		no = 10201,
		type = 7,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(10202) ->
	#data_stall_config{
		no = 10202,
		type = 7,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(10203) ->
	#data_stall_config{
		no = 10203,
		type = 7,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(10205) ->
	#data_stall_config{
		no = 10205,
		type = 7,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(10206) ->
	#data_stall_config{
		no = 10206,
		type = 7,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(10208) ->
	#data_stall_config{
		no = 10208,
		type = 7,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(10209) ->
	#data_stall_config{
		no = 10209,
		type = 7,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(10211) ->
	#data_stall_config{
		no = 10211,
		type = 7,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(10212) ->
	#data_stall_config{
		no = 10212,
		type = 7,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(10214) ->
	#data_stall_config{
		no = 10214,
		type = 7,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(10215) ->
	#data_stall_config{
		no = 10215,
		type = 7,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(10217) ->
	#data_stall_config{
		no = 10217,
		type = 7,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(10218) ->
	#data_stall_config{
		no = 10218,
		type = 7,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(10220) ->
	#data_stall_config{
		no = 10220,
		type = 7,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(10221) ->
	#data_stall_config{
		no = 10221,
		type = 7,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(10223) ->
	#data_stall_config{
		no = 10223,
		type = 7,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(10224) ->
	#data_stall_config{
		no = 10224,
		type = 7,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(10204) ->
	#data_stall_config{
		no = 10204,
		type = 7,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(10207) ->
	#data_stall_config{
		no = 10207,
		type = 7,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(10210) ->
	#data_stall_config{
		no = 10210,
		type = 7,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(10213) ->
	#data_stall_config{
		no = 10213,
		type = 7,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(10216) ->
	#data_stall_config{
		no = 10216,
		type = 7,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(10219) ->
	#data_stall_config{
		no = 10219,
		type = 7,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(10222) ->
	#data_stall_config{
		no = 10222,
		type = 7,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(10225) ->
	#data_stall_config{
		no = 10225,
		type = 7,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(10226) ->
	#data_stall_config{
		no = 10226,
		type = 7,
		sub_type = 7,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(10227) ->
	#data_stall_config{
		no = 10227,
		type = 7,
		sub_type = 7,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(10228) ->
	#data_stall_config{
		no = 10228,
		type = 7,
		sub_type = 7,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(10229) ->
	#data_stall_config{
		no = 10229,
		type = 7,
		sub_type = 7,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(10230) ->
	#data_stall_config{
		no = 10230,
		type = 7,
		sub_type = 8,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(10231) ->
	#data_stall_config{
		no = 10231,
		type = 7,
		sub_type = 8,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(10232) ->
	#data_stall_config{
		no = 10232,
		type = 7,
		sub_type = 8,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(10233) ->
	#data_stall_config{
		no = 10233,
		type = 7,
		sub_type = 8,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(10234) ->
	#data_stall_config{
		no = 10234,
		type = 7,
		sub_type = 8,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(10235) ->
	#data_stall_config{
		no = 10235,
		type = 7,
		sub_type = 8,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70011) ->
	#data_stall_config{
		no = 70011,
		type = 8,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70012) ->
	#data_stall_config{
		no = 70012,
		type = 8,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70013) ->
	#data_stall_config{
		no = 70013,
		type = 8,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70014) ->
	#data_stall_config{
		no = 70014,
		type = 8,
		sub_type = 1,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70101) ->
	#data_stall_config{
		no = 70101,
		type = 8,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70102) ->
	#data_stall_config{
		no = 70102,
		type = 8,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70103) ->
	#data_stall_config{
		no = 70103,
		type = 8,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70104) ->
	#data_stall_config{
		no = 70104,
		type = 8,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70105) ->
	#data_stall_config{
		no = 70105,
		type = 8,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70106) ->
	#data_stall_config{
		no = 70106,
		type = 8,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70107) ->
	#data_stall_config{
		no = 70107,
		type = 8,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70108) ->
	#data_stall_config{
		no = 70108,
		type = 8,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70109) ->
	#data_stall_config{
		no = 70109,
		type = 8,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70110) ->
	#data_stall_config{
		no = 70110,
		type = 8,
		sub_type = 2,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70111) ->
	#data_stall_config{
		no = 70111,
		type = 8,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70112) ->
	#data_stall_config{
		no = 70112,
		type = 8,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70113) ->
	#data_stall_config{
		no = 70113,
		type = 8,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70114) ->
	#data_stall_config{
		no = 70114,
		type = 8,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70115) ->
	#data_stall_config{
		no = 70115,
		type = 8,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70116) ->
	#data_stall_config{
		no = 70116,
		type = 8,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70117) ->
	#data_stall_config{
		no = 70117,
		type = 8,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70118) ->
	#data_stall_config{
		no = 70118,
		type = 8,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70119) ->
	#data_stall_config{
		no = 70119,
		type = 8,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70120) ->
	#data_stall_config{
		no = 70120,
		type = 8,
		sub_type = 3,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70121) ->
	#data_stall_config{
		no = 70121,
		type = 8,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70122) ->
	#data_stall_config{
		no = 70122,
		type = 8,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70123) ->
	#data_stall_config{
		no = 70123,
		type = 8,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70124) ->
	#data_stall_config{
		no = 70124,
		type = 8,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70125) ->
	#data_stall_config{
		no = 70125,
		type = 8,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70126) ->
	#data_stall_config{
		no = 70126,
		type = 8,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70127) ->
	#data_stall_config{
		no = 70127,
		type = 8,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70128) ->
	#data_stall_config{
		no = 70128,
		type = 8,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70129) ->
	#data_stall_config{
		no = 70129,
		type = 8,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70130) ->
	#data_stall_config{
		no = 70130,
		type = 8,
		sub_type = 4,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70131) ->
	#data_stall_config{
		no = 70131,
		type = 8,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70132) ->
	#data_stall_config{
		no = 70132,
		type = 8,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70133) ->
	#data_stall_config{
		no = 70133,
		type = 8,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70134) ->
	#data_stall_config{
		no = 70134,
		type = 8,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70135) ->
	#data_stall_config{
		no = 70135,
		type = 8,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70136) ->
	#data_stall_config{
		no = 70136,
		type = 8,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70137) ->
	#data_stall_config{
		no = 70137,
		type = 8,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70138) ->
	#data_stall_config{
		no = 70138,
		type = 8,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70139) ->
	#data_stall_config{
		no = 70139,
		type = 8,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70140) ->
	#data_stall_config{
		no = 70140,
		type = 8,
		sub_type = 5,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70141) ->
	#data_stall_config{
		no = 70141,
		type = 8,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70142) ->
	#data_stall_config{
		no = 70142,
		type = 8,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70143) ->
	#data_stall_config{
		no = 70143,
		type = 8,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70144) ->
	#data_stall_config{
		no = 70144,
		type = 8,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70145) ->
	#data_stall_config{
		no = 70145,
		type = 8,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70146) ->
	#data_stall_config{
		no = 70146,
		type = 8,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70147) ->
	#data_stall_config{
		no = 70147,
		type = 8,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70148) ->
	#data_stall_config{
		no = 70148,
		type = 8,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70149) ->
	#data_stall_config{
		no = 70149,
		type = 8,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70150) ->
	#data_stall_config{
		no = 70150,
		type = 8,
		sub_type = 6,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70241) ->
	#data_stall_config{
		no = 70241,
		type = 8,
		sub_type = 7,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70242) ->
	#data_stall_config{
		no = 70242,
		type = 8,
		sub_type = 7,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70243) ->
	#data_stall_config{
		no = 70243,
		type = 8,
		sub_type = 7,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70244) ->
	#data_stall_config{
		no = 70244,
		type = 8,
		sub_type = 7,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70245) ->
	#data_stall_config{
		no = 70245,
		type = 8,
		sub_type = 7,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70246) ->
	#data_stall_config{
		no = 70246,
		type = 8,
		sub_type = 7,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70247) ->
	#data_stall_config{
		no = 70247,
		type = 8,
		sub_type = 7,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70248) ->
	#data_stall_config{
		no = 70248,
		type = 8,
		sub_type = 7,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70249) ->
	#data_stall_config{
		no = 70249,
		type = 8,
		sub_type = 7,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70250) ->
	#data_stall_config{
		no = 70250,
		type = 8,
		sub_type = 7,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70301) ->
	#data_stall_config{
		no = 70301,
		type = 8,
		sub_type = 8,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70302) ->
	#data_stall_config{
		no = 70302,
		type = 8,
		sub_type = 8,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70303) ->
	#data_stall_config{
		no = 70303,
		type = 8,
		sub_type = 8,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70304) ->
	#data_stall_config{
		no = 70304,
		type = 8,
		sub_type = 8,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70305) ->
	#data_stall_config{
		no = 70305,
		type = 8,
		sub_type = 8,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70306) ->
	#data_stall_config{
		no = 70306,
		type = 8,
		sub_type = 8,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70307) ->
	#data_stall_config{
		no = 70307,
		type = 8,
		sub_type = 8,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70308) ->
	#data_stall_config{
		no = 70308,
		type = 8,
		sub_type = 8,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70309) ->
	#data_stall_config{
		no = 70309,
		type = 8,
		sub_type = 8,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70310) ->
	#data_stall_config{
		no = 70310,
		type = 8,
		sub_type = 8,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70311) ->
	#data_stall_config{
		no = 70311,
		type = 8,
		sub_type = 9,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70312) ->
	#data_stall_config{
		no = 70312,
		type = 8,
		sub_type = 9,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70313) ->
	#data_stall_config{
		no = 70313,
		type = 8,
		sub_type = 9,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70314) ->
	#data_stall_config{
		no = 70314,
		type = 8,
		sub_type = 9,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70315) ->
	#data_stall_config{
		no = 70315,
		type = 8,
		sub_type = 9,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70316) ->
	#data_stall_config{
		no = 70316,
		type = 8,
		sub_type = 9,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70317) ->
	#data_stall_config{
		no = 70317,
		type = 8,
		sub_type = 9,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70318) ->
	#data_stall_config{
		no = 70318,
		type = 8,
		sub_type = 9,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70319) ->
	#data_stall_config{
		no = 70319,
		type = 8,
		sub_type = 9,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70320) ->
	#data_stall_config{
		no = 70320,
		type = 8,
		sub_type = 9,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70341) ->
	#data_stall_config{
		no = 70341,
		type = 8,
		sub_type = 10,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70342) ->
	#data_stall_config{
		no = 70342,
		type = 8,
		sub_type = 10,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70343) ->
	#data_stall_config{
		no = 70343,
		type = 8,
		sub_type = 10,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70344) ->
	#data_stall_config{
		no = 70344,
		type = 8,
		sub_type = 10,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70345) ->
	#data_stall_config{
		no = 70345,
		type = 8,
		sub_type = 10,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70346) ->
	#data_stall_config{
		no = 70346,
		type = 8,
		sub_type = 10,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70347) ->
	#data_stall_config{
		no = 70347,
		type = 8,
		sub_type = 10,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70348) ->
	#data_stall_config{
		no = 70348,
		type = 8,
		sub_type = 10,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70349) ->
	#data_stall_config{
		no = 70349,
		type = 8,
		sub_type = 10,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(70350) ->
	#data_stall_config{
		no = 70350,
		type = 8,
		sub_type = 10,
		bind_state = 2,
		price_type = 9,
		price = 0
};

get(50038) ->
	#data_stall_config{
		no = 50038,
		type = 1,
		sub_type = 9,
		bind_state = 2,
		price_type = 9,
		price = 50
};

get(50307) ->
	#data_stall_config{
		no = 50307,
		type = 1,
		sub_type = 9,
		bind_state = 2,
		price_type = 9,
		price = 50
};

get(60039) ->
	#data_stall_config{
		no = 60039,
		type = 1,
		sub_type = 8,
		bind_state = 2,
		price_type = 9,
		price = 750
};

get(60040) ->
	#data_stall_config{
		no = 60040,
		type = 1,
		sub_type = 8,
		bind_state = 2,
		price_type = 9,
		price = 7500
};

get(_No) ->
				?WARNING_MSG("Cannot get ~p", [_No]),
          null.

