%%%---------------------------------------
%%% @Module  : data_business_config
%%% @Author  : 段世和
%%% @Email   :
%%% @Description: 商会系统配置
%%%---------------------------------------


-module(data_business_config).
-export([get_ids/0, get/1]).
-include("business.hrl").
-include("debug.hrl").

get_ids()->
	[10056,10057,10058,10059,10060,10061,10062,10063,10064,10065,50038,50307,60039,60040,70011,70012,70101,70102,70103,70104,70105,70111,70112,70113,70114,70115,70121,70122,70123,70124,70125,70131,70132,70133,70134,70135,70141,70142,70143,70144,70145,70241,70242,70243,70244,70245,70301,70302,70303,70304,70305,70311,70312,70313,70314,70315,70341,70342,70343,70344,70345,70506,70507,70508,70514,70515,70516,70522,70523,70524,70530,70531,70532,70538,70539,70540,70546,70547,70548,70554,70555,70556,70562,70563,70564,70570,70571,70572,72001,72002,72003,72004,72005,72006,72007,72008,72009,72010,72011,72012,72013,72014,72015,72016,72017,72018,72019,72020,72021,72022,72023,72024,72025,72026,72027,72028,72029,72030,72031,72032,72033,72034,72035,72036,72037,72038,72039,72040,72041,72042,72043,72044,72045,72046,72047,72048,72049,72050,72051,72052,72053,72054,72055,72056,72057,72058,72059,72060,72061,72062,72063,72064,72065,72066,72067,72068,72069,72070,72071,72072,72073,72074,72075,72076,72077,72078,72079,72080,72081,72082,72083,72084,72085,72086,72087,72088,72089,72090,72091,72092,72093,72094,72095,72096,72097,72098,72099,72100,72101,72102,72103,72104,72105,72106,72107,72108,72109,72110,72111,72112,72113,72114,72115,72116,72117,72118,72119,72120,72121,72122,72123,72124,72125,72126,72127,72128,72129,72130,72171,72172,72173,72174,72175,72176,72177,72178,72179,72180,311005,311007,311009,311055,311057,311059,312005,312007,312009,312055,312057,312059,313005,313007,313009,314105,314107,314109,314155,314157,314159,314205,314207,314209,314255,314257,314259,314305,314307,314309,314355,314357,314359,315005,315007,315009,316005,316007,316009,321005,321007,321009,321055,321057,321059,322005,322007,322009,322055,322057,322059,323005,323007,323009,324105,324107,324109,324155,324157,324159,324205,324207,324209,324255,324257,324259,324305,324307,324309,324355,324357,324359,325005,325007,325009,326005,326007,326009,331005,331007,331009,331055,331057,331059,332005,332007,332009,332055,332057,332059,333005,333007,333009,334105,334107,334109,334155,334157,334159,334205,334207,334209,334255,334257,334259,334305,334307,334309,334355,334357,334359,335005,335007,335009,336005,336007,336009,341005,341007,341009,341055,341057,341059,342005,342007,342009,342055,342057,342059,343005,343007,343009,344105,344107,344109,344155,344157,344159,344205,344207,344209,344255,344257,344259,344305,344307,344309,344355,344357,344359,345005,345007,345009,346005,346007,346009,351005,351007,351009,351055,351057,351059,352005,352007,352009,352055,352057,352059,353005,353007,353009,354105,354107,354109,354155,354157,354159,354205,354207,354209,354255,354257,354259,354305,354307,354309,354355,354357,354359,355005,355007,355009,356005,356007,356009,361005,361007,361009,361055,361057,361059,362005,362007,362009,362055,362057,362059,363005,363007,363009,364105,364107,364109,364155,364157,364159,364205,364207,364209,364255,364257,364259,364305,364307,364309,364355,364357,364359,365005,365007,365009,366005,366007,366009,375005,375007,375009].

get(72001) ->
	#data_business_config{
		no = 72001,
		type = 2,
		sub_type = 1,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 50000,
		extent = 0
};

get(72002) ->
	#data_business_config{
		no = 72002,
		type = 2,
		sub_type = 1,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 100000,
		extent = 0.005000
};

get(72003) ->
	#data_business_config{
		no = 72003,
		type = 2,
		sub_type = 1,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 200000,
		extent = 0.005000
};

get(72004) ->
	#data_business_config{
		no = 72004,
		type = 2,
		sub_type = 1,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 400000,
		extent = 0.005000
};

get(72005) ->
	#data_business_config{
		no = 72005,
		type = 2,
		sub_type = 1,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 800000,
		extent = 0.005000
};

get(72006) ->
	#data_business_config{
		no = 72006,
		type = 2,
		sub_type = 1,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 1600000,
		extent = 0.005000
};

get(72007) ->
	#data_business_config{
		no = 72007,
		type = 2,
		sub_type = 1,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 3200000,
		extent = 0.005000
};

get(72008) ->
	#data_business_config{
		no = 72008,
		type = 2,
		sub_type = 1,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 6400000,
		extent = 0.005000
};

get(72009) ->
	#data_business_config{
		no = 72009,
		type = 2,
		sub_type = 1,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 12800000,
		extent = 0.005000
};

get(72010) ->
	#data_business_config{
		no = 72010,
		type = 2,
		sub_type = 1,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 25600000,
		extent = 0.005000
};

get(72011) ->
	#data_business_config{
		no = 72011,
		type = 2,
		sub_type = 2,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 50000,
		extent = 0
};

get(72012) ->
	#data_business_config{
		no = 72012,
		type = 2,
		sub_type = 2,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 100000,
		extent = 0.005000
};

get(72013) ->
	#data_business_config{
		no = 72013,
		type = 2,
		sub_type = 2,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 200000,
		extent = 0.005000
};

get(72014) ->
	#data_business_config{
		no = 72014,
		type = 2,
		sub_type = 2,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 400000,
		extent = 0.005000
};

get(72015) ->
	#data_business_config{
		no = 72015,
		type = 2,
		sub_type = 2,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 800000,
		extent = 0.005000
};

get(72016) ->
	#data_business_config{
		no = 72016,
		type = 2,
		sub_type = 2,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 1600000,
		extent = 0.005000
};

get(72017) ->
	#data_business_config{
		no = 72017,
		type = 2,
		sub_type = 2,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 3200000,
		extent = 0.005000
};

get(72018) ->
	#data_business_config{
		no = 72018,
		type = 2,
		sub_type = 2,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 6400000,
		extent = 0.005000
};

get(72019) ->
	#data_business_config{
		no = 72019,
		type = 2,
		sub_type = 2,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 12800000,
		extent = 0.005000
};

get(72020) ->
	#data_business_config{
		no = 72020,
		type = 2,
		sub_type = 2,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 25600000,
		extent = 0.005000
};

get(72021) ->
	#data_business_config{
		no = 72021,
		type = 2,
		sub_type = 3,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 50000,
		extent = 0
};

get(72022) ->
	#data_business_config{
		no = 72022,
		type = 2,
		sub_type = 3,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 100000,
		extent = 0.005000
};

get(72023) ->
	#data_business_config{
		no = 72023,
		type = 2,
		sub_type = 3,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 200000,
		extent = 0.005000
};

get(72024) ->
	#data_business_config{
		no = 72024,
		type = 2,
		sub_type = 3,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 400000,
		extent = 0.005000
};

get(72025) ->
	#data_business_config{
		no = 72025,
		type = 2,
		sub_type = 3,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 800000,
		extent = 0.005000
};

get(72026) ->
	#data_business_config{
		no = 72026,
		type = 2,
		sub_type = 3,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 1600000,
		extent = 0.005000
};

get(72027) ->
	#data_business_config{
		no = 72027,
		type = 2,
		sub_type = 3,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 3200000,
		extent = 0.005000
};

get(72028) ->
	#data_business_config{
		no = 72028,
		type = 2,
		sub_type = 3,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 6400000,
		extent = 0.005000
};

get(72029) ->
	#data_business_config{
		no = 72029,
		type = 2,
		sub_type = 3,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 12800000,
		extent = 0.005000
};

get(72030) ->
	#data_business_config{
		no = 72030,
		type = 2,
		sub_type = 3,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 25600000,
		extent = 0.005000
};

get(72031) ->
	#data_business_config{
		no = 72031,
		type = 2,
		sub_type = 4,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 50000,
		extent = 0
};

get(72032) ->
	#data_business_config{
		no = 72032,
		type = 2,
		sub_type = 4,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 100000,
		extent = 0.005000
};

get(72033) ->
	#data_business_config{
		no = 72033,
		type = 2,
		sub_type = 4,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 200000,
		extent = 0.005000
};

get(72034) ->
	#data_business_config{
		no = 72034,
		type = 2,
		sub_type = 4,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 400000,
		extent = 0.005000
};

get(72035) ->
	#data_business_config{
		no = 72035,
		type = 2,
		sub_type = 4,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 800000,
		extent = 0.005000
};

get(72036) ->
	#data_business_config{
		no = 72036,
		type = 2,
		sub_type = 4,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 1600000,
		extent = 0.005000
};

get(72037) ->
	#data_business_config{
		no = 72037,
		type = 2,
		sub_type = 4,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 3200000,
		extent = 0.005000
};

get(72038) ->
	#data_business_config{
		no = 72038,
		type = 2,
		sub_type = 4,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 6400000,
		extent = 0.005000
};

get(72039) ->
	#data_business_config{
		no = 72039,
		type = 2,
		sub_type = 4,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 12800000,
		extent = 0.005000
};

get(72040) ->
	#data_business_config{
		no = 72040,
		type = 2,
		sub_type = 4,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 25600000,
		extent = 0.005000
};

get(72041) ->
	#data_business_config{
		no = 72041,
		type = 2,
		sub_type = 5,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 50000,
		extent = 0.005000
};

get(72042) ->
	#data_business_config{
		no = 72042,
		type = 2,
		sub_type = 5,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 100000,
		extent = 0.005000
};

get(72043) ->
	#data_business_config{
		no = 72043,
		type = 2,
		sub_type = 5,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 200000,
		extent = 0.005000
};

get(72044) ->
	#data_business_config{
		no = 72044,
		type = 2,
		sub_type = 5,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 400000,
		extent = 0.005000
};

get(72045) ->
	#data_business_config{
		no = 72045,
		type = 2,
		sub_type = 5,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 800000,
		extent = 0.005000
};

get(72046) ->
	#data_business_config{
		no = 72046,
		type = 2,
		sub_type = 5,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 1600000,
		extent = 0.005000
};

get(72047) ->
	#data_business_config{
		no = 72047,
		type = 2,
		sub_type = 5,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 3200000,
		extent = 0.005000
};

get(72048) ->
	#data_business_config{
		no = 72048,
		type = 2,
		sub_type = 5,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 6400000,
		extent = 0.005000
};

get(72049) ->
	#data_business_config{
		no = 72049,
		type = 2,
		sub_type = 5,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 12800000,
		extent = 0.005000
};

get(72050) ->
	#data_business_config{
		no = 72050,
		type = 2,
		sub_type = 5,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 25600000,
		extent = 0.005000
};

get(72051) ->
	#data_business_config{
		no = 72051,
		type = 2,
		sub_type = 6,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 50000,
		extent = 0
};

get(72052) ->
	#data_business_config{
		no = 72052,
		type = 2,
		sub_type = 6,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 100000,
		extent = 0.005000
};

get(72053) ->
	#data_business_config{
		no = 72053,
		type = 2,
		sub_type = 6,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 200000,
		extent = 0.005000
};

get(72054) ->
	#data_business_config{
		no = 72054,
		type = 2,
		sub_type = 6,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 400000,
		extent = 0.005000
};

get(72055) ->
	#data_business_config{
		no = 72055,
		type = 2,
		sub_type = 6,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 800000,
		extent = 0.005000
};

get(72056) ->
	#data_business_config{
		no = 72056,
		type = 2,
		sub_type = 6,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 1600000,
		extent = 0.005000
};

get(72057) ->
	#data_business_config{
		no = 72057,
		type = 2,
		sub_type = 6,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 3200000,
		extent = 0.005000
};

get(72058) ->
	#data_business_config{
		no = 72058,
		type = 2,
		sub_type = 6,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 6400000,
		extent = 0.005000
};

get(72059) ->
	#data_business_config{
		no = 72059,
		type = 2,
		sub_type = 6,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 12800000,
		extent = 0.005000
};

get(72060) ->
	#data_business_config{
		no = 72060,
		type = 2,
		sub_type = 6,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 25600000,
		extent = 0.005000
};

get(72061) ->
	#data_business_config{
		no = 72061,
		type = 2,
		sub_type = 7,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 50000,
		extent = 0.005000
};

get(72062) ->
	#data_business_config{
		no = 72062,
		type = 2,
		sub_type = 7,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 100000,
		extent = 0.005000
};

get(72063) ->
	#data_business_config{
		no = 72063,
		type = 2,
		sub_type = 7,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 200000,
		extent = 0.005000
};

get(72064) ->
	#data_business_config{
		no = 72064,
		type = 2,
		sub_type = 7,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 400000,
		extent = 0.005000
};

get(72065) ->
	#data_business_config{
		no = 72065,
		type = 2,
		sub_type = 7,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 800000,
		extent = 0.005000
};

get(72066) ->
	#data_business_config{
		no = 72066,
		type = 2,
		sub_type = 7,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 1600000,
		extent = 0.005000
};

get(72067) ->
	#data_business_config{
		no = 72067,
		type = 2,
		sub_type = 7,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 3200000,
		extent = 0.005000
};

get(72068) ->
	#data_business_config{
		no = 72068,
		type = 2,
		sub_type = 7,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 6400000,
		extent = 0.005000
};

get(72069) ->
	#data_business_config{
		no = 72069,
		type = 2,
		sub_type = 7,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 12800000,
		extent = 0.005000
};

get(72070) ->
	#data_business_config{
		no = 72070,
		type = 2,
		sub_type = 7,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 25600000,
		extent = 0.005000
};

get(72071) ->
	#data_business_config{
		no = 72071,
		type = 2,
		sub_type = 8,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 50000,
		extent = 0
};

get(72072) ->
	#data_business_config{
		no = 72072,
		type = 2,
		sub_type = 8,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 100000,
		extent = 0.005000
};

get(72073) ->
	#data_business_config{
		no = 72073,
		type = 2,
		sub_type = 8,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 200000,
		extent = 0.005000
};

get(72074) ->
	#data_business_config{
		no = 72074,
		type = 2,
		sub_type = 8,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 400000,
		extent = 0.005000
};

get(72075) ->
	#data_business_config{
		no = 72075,
		type = 2,
		sub_type = 8,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 800000,
		extent = 0.005000
};

get(72076) ->
	#data_business_config{
		no = 72076,
		type = 2,
		sub_type = 8,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 1600000,
		extent = 0.005000
};

get(72077) ->
	#data_business_config{
		no = 72077,
		type = 2,
		sub_type = 8,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 3200000,
		extent = 0.005000
};

get(72078) ->
	#data_business_config{
		no = 72078,
		type = 2,
		sub_type = 8,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 6400000,
		extent = 0.005000
};

get(72079) ->
	#data_business_config{
		no = 72079,
		type = 2,
		sub_type = 8,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 12800000,
		extent = 0.005000
};

get(72080) ->
	#data_business_config{
		no = 72080,
		type = 2,
		sub_type = 8,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 25600000,
		extent = 0.005000
};

get(72081) ->
	#data_business_config{
		no = 72081,
		type = 2,
		sub_type = 9,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 50000,
		extent = 0.005000
};

get(72082) ->
	#data_business_config{
		no = 72082,
		type = 2,
		sub_type = 9,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 100000,
		extent = 0.005000
};

get(72083) ->
	#data_business_config{
		no = 72083,
		type = 2,
		sub_type = 9,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 200000,
		extent = 0.005000
};

get(72084) ->
	#data_business_config{
		no = 72084,
		type = 2,
		sub_type = 9,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 400000,
		extent = 0.005000
};

get(72085) ->
	#data_business_config{
		no = 72085,
		type = 2,
		sub_type = 9,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 800000,
		extent = 0.005000
};

get(72086) ->
	#data_business_config{
		no = 72086,
		type = 2,
		sub_type = 9,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 1600000,
		extent = 0.005000
};

get(72087) ->
	#data_business_config{
		no = 72087,
		type = 2,
		sub_type = 9,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 3200000,
		extent = 0.005000
};

get(72088) ->
	#data_business_config{
		no = 72088,
		type = 2,
		sub_type = 9,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 6400000,
		extent = 0.005000
};

get(72089) ->
	#data_business_config{
		no = 72089,
		type = 2,
		sub_type = 9,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 12800000,
		extent = 0.005000
};

get(72090) ->
	#data_business_config{
		no = 72090,
		type = 2,
		sub_type = 9,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 25600000,
		extent = 0.005000
};

get(72091) ->
	#data_business_config{
		no = 72091,
		type = 2,
		sub_type = 10,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 50000,
		extent = 0
};

get(72092) ->
	#data_business_config{
		no = 72092,
		type = 2,
		sub_type = 10,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 100000,
		extent = 0.005000
};

get(72093) ->
	#data_business_config{
		no = 72093,
		type = 2,
		sub_type = 10,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 200000,
		extent = 0.005000
};

get(72094) ->
	#data_business_config{
		no = 72094,
		type = 2,
		sub_type = 10,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 400000,
		extent = 0.005000
};

get(72095) ->
	#data_business_config{
		no = 72095,
		type = 2,
		sub_type = 10,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 800000,
		extent = 0.005000
};

get(72096) ->
	#data_business_config{
		no = 72096,
		type = 2,
		sub_type = 10,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 1600000,
		extent = 0.005000
};

get(72097) ->
	#data_business_config{
		no = 72097,
		type = 2,
		sub_type = 10,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 3200000,
		extent = 0.005000
};

get(72098) ->
	#data_business_config{
		no = 72098,
		type = 2,
		sub_type = 10,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 6400000,
		extent = 0.005000
};

get(72099) ->
	#data_business_config{
		no = 72099,
		type = 2,
		sub_type = 10,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 12800000,
		extent = 0.005000
};

get(72100) ->
	#data_business_config{
		no = 72100,
		type = 2,
		sub_type = 10,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 25600000,
		extent = 0.005000
};

get(72101) ->
	#data_business_config{
		no = 72101,
		type = 2,
		sub_type = 11,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 50000,
		extent = 0
};

get(72102) ->
	#data_business_config{
		no = 72102,
		type = 2,
		sub_type = 11,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 100000,
		extent = 0.005000
};

get(72103) ->
	#data_business_config{
		no = 72103,
		type = 2,
		sub_type = 11,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 200000,
		extent = 0.005000
};

get(72104) ->
	#data_business_config{
		no = 72104,
		type = 2,
		sub_type = 11,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 400000,
		extent = 0.005000
};

get(72105) ->
	#data_business_config{
		no = 72105,
		type = 2,
		sub_type = 11,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 800000,
		extent = 0.005000
};

get(72106) ->
	#data_business_config{
		no = 72106,
		type = 2,
		sub_type = 11,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 1600000,
		extent = 0.005000
};

get(72107) ->
	#data_business_config{
		no = 72107,
		type = 2,
		sub_type = 11,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 3200000,
		extent = 0.005000
};

get(72108) ->
	#data_business_config{
		no = 72108,
		type = 2,
		sub_type = 11,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 6400000,
		extent = 0.005000
};

get(72109) ->
	#data_business_config{
		no = 72109,
		type = 2,
		sub_type = 11,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 12800000,
		extent = 0.005000
};

get(72110) ->
	#data_business_config{
		no = 72110,
		type = 2,
		sub_type = 11,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 25600000,
		extent = 0.005000
};

get(72111) ->
	#data_business_config{
		no = 72111,
		type = 2,
		sub_type = 12,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 50000,
		extent = 0
};

get(72112) ->
	#data_business_config{
		no = 72112,
		type = 2,
		sub_type = 12,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 100000,
		extent = 0.005000
};

get(72113) ->
	#data_business_config{
		no = 72113,
		type = 2,
		sub_type = 12,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 200000,
		extent = 0.005000
};

get(72114) ->
	#data_business_config{
		no = 72114,
		type = 2,
		sub_type = 12,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 400000,
		extent = 0.005000
};

get(72115) ->
	#data_business_config{
		no = 72115,
		type = 2,
		sub_type = 12,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 800000,
		extent = 0.005000
};

get(72116) ->
	#data_business_config{
		no = 72116,
		type = 2,
		sub_type = 12,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 1600000,
		extent = 0.005000
};

get(72117) ->
	#data_business_config{
		no = 72117,
		type = 2,
		sub_type = 12,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 3200000,
		extent = 0.005000
};

get(72118) ->
	#data_business_config{
		no = 72118,
		type = 2,
		sub_type = 12,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 6400000,
		extent = 0.005000
};

get(72119) ->
	#data_business_config{
		no = 72119,
		type = 2,
		sub_type = 12,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 12800000,
		extent = 0.005000
};

get(72120) ->
	#data_business_config{
		no = 72120,
		type = 2,
		sub_type = 12,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 1000,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 25600000,
		extent = 0.005000
};

get(72171) ->
	#data_business_config{
		no = 72171,
		type = 2,
		sub_type = 14,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 50000,
		extent = 0
};

get(72172) ->
	#data_business_config{
		no = 72172,
		type = 2,
		sub_type = 14,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 100000,
		extent = 0.005000
};

get(72173) ->
	#data_business_config{
		no = 72173,
		type = 2,
		sub_type = 14,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 200000,
		extent = 0.005000
};

get(72174) ->
	#data_business_config{
		no = 72174,
		type = 2,
		sub_type = 14,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 400000,
		extent = 0.005000
};

get(72175) ->
	#data_business_config{
		no = 72175,
		type = 2,
		sub_type = 14,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 800000,
		extent = 0.005000
};

get(72176) ->
	#data_business_config{
		no = 72176,
		type = 2,
		sub_type = 14,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 1600000,
		extent = 0.005000
};

get(72177) ->
	#data_business_config{
		no = 72177,
		type = 2,
		sub_type = 14,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 3200000,
		extent = 0.005000
};

get(72178) ->
	#data_business_config{
		no = 72178,
		type = 2,
		sub_type = 14,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 6400000,
		extent = 0.005000
};

get(72179) ->
	#data_business_config{
		no = 72179,
		type = 2,
		sub_type = 14,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 12800000,
		extent = 0.005000
};

get(72180) ->
	#data_business_config{
		no = 72180,
		type = 2,
		sub_type = 14,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 25600000,
		extent = 0.005000
};

get(72121) ->
	#data_business_config{
		no = 72121,
		type = 2,
		sub_type = 13,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 60,
		global_buy_count_limit = 0,
		sell_count_limit = 100,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 50000,
		extent = 0
};

get(72122) ->
	#data_business_config{
		no = 72122,
		type = 2,
		sub_type = 13,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 60,
		global_buy_count_limit = 0,
		sell_count_limit = 100,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 100000,
		extent = 0.005000
};

get(72123) ->
	#data_business_config{
		no = 72123,
		type = 2,
		sub_type = 13,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 60,
		global_buy_count_limit = 0,
		sell_count_limit = 100,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 200000,
		extent = 0.005000
};

get(72124) ->
	#data_business_config{
		no = 72124,
		type = 2,
		sub_type = 13,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 60,
		global_buy_count_limit = 0,
		sell_count_limit = 100,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 400000,
		extent = 0.005000
};

get(72125) ->
	#data_business_config{
		no = 72125,
		type = 2,
		sub_type = 13,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 60,
		global_buy_count_limit = 0,
		sell_count_limit = 100,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 800000,
		extent = 0.005000
};

get(72126) ->
	#data_business_config{
		no = 72126,
		type = 2,
		sub_type = 13,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 60,
		global_buy_count_limit = 0,
		sell_count_limit = 100,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 1600000,
		extent = 0.005000
};

get(72127) ->
	#data_business_config{
		no = 72127,
		type = 2,
		sub_type = 13,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 60,
		global_buy_count_limit = 0,
		sell_count_limit = 100,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 3200000,
		extent = 0.005000
};

get(72128) ->
	#data_business_config{
		no = 72128,
		type = 2,
		sub_type = 13,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 60,
		global_buy_count_limit = 0,
		sell_count_limit = 100,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 6400000,
		extent = 0.005000
};

get(72129) ->
	#data_business_config{
		no = 72129,
		type = 2,
		sub_type = 13,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 60,
		global_buy_count_limit = 0,
		sell_count_limit = 100,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 12800000,
		extent = 0.005000
};

get(72130) ->
	#data_business_config{
		no = 72130,
		type = 2,
		sub_type = 13,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 60,
		global_buy_count_limit = 0,
		sell_count_limit = 100,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 25600000,
		extent = 0.005000
};

get(70341) ->
	#data_business_config{
		no = 70341,
		type = 1,
		sub_type = 1,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 1000000,
		extent = 0.008000
};

get(70342) ->
	#data_business_config{
		no = 70342,
		type = 1,
		sub_type = 2,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 2100000,
		extent = 0.008000
};

get(70343) ->
	#data_business_config{
		no = 70343,
		type = 1,
		sub_type = 3,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 4500000,
		extent = 0.008000
};

get(70344) ->
	#data_business_config{
		no = 70344,
		type = 1,
		sub_type = 4,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 10000000,
		extent = 0.008000
};

get(70345) ->
	#data_business_config{
		no = 70345,
		type = 1,
		sub_type = 5,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 21000000,
		extent = 0.008000
};

get(70301) ->
	#data_business_config{
		no = 70301,
		type = 1,
		sub_type = 1,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 1000000,
		extent = 0.008000
};

get(70302) ->
	#data_business_config{
		no = 70302,
		type = 1,
		sub_type = 2,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 2100000,
		extent = 0.008000
};

get(70303) ->
	#data_business_config{
		no = 70303,
		type = 1,
		sub_type = 3,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 4500000,
		extent = 0.008000
};

get(70304) ->
	#data_business_config{
		no = 70304,
		type = 1,
		sub_type = 4,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 10000000,
		extent = 0.008000
};

get(70305) ->
	#data_business_config{
		no = 70305,
		type = 1,
		sub_type = 5,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 21000000,
		extent = 0.008000
};

get(70311) ->
	#data_business_config{
		no = 70311,
		type = 1,
		sub_type = 1,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 1000000,
		extent = 0.008000
};

get(70312) ->
	#data_business_config{
		no = 70312,
		type = 1,
		sub_type = 2,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 2100000,
		extent = 0.008000
};

get(70313) ->
	#data_business_config{
		no = 70313,
		type = 1,
		sub_type = 3,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 4500000,
		extent = 0.008000
};

get(70314) ->
	#data_business_config{
		no = 70314,
		type = 1,
		sub_type = 4,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 10000000,
		extent = 0.008000
};

get(70315) ->
	#data_business_config{
		no = 70315,
		type = 1,
		sub_type = 5,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 21000000,
		extent = 0.008000
};

get(70241) ->
	#data_business_config{
		no = 70241,
		type = 1,
		sub_type = 1,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 1000000,
		extent = 0.008000
};

get(70242) ->
	#data_business_config{
		no = 70242,
		type = 1,
		sub_type = 2,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 2100000,
		extent = 0.008000
};

get(70243) ->
	#data_business_config{
		no = 70243,
		type = 1,
		sub_type = 3,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 4500000,
		extent = 0.008000
};

get(70244) ->
	#data_business_config{
		no = 70244,
		type = 1,
		sub_type = 4,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 10000000,
		extent = 0.008000
};

get(70245) ->
	#data_business_config{
		no = 70245,
		type = 1,
		sub_type = 5,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 21000000,
		extent = 0.008000
};

get(70141) ->
	#data_business_config{
		no = 70141,
		type = 1,
		sub_type = 1,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 1000000,
		extent = 0.008000
};

get(70142) ->
	#data_business_config{
		no = 70142,
		type = 1,
		sub_type = 2,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 2100000,
		extent = 0.008000
};

get(70143) ->
	#data_business_config{
		no = 70143,
		type = 1,
		sub_type = 3,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 4500000,
		extent = 0.008000
};

get(70144) ->
	#data_business_config{
		no = 70144,
		type = 1,
		sub_type = 4,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 10000000,
		extent = 0.008000
};

get(70145) ->
	#data_business_config{
		no = 70145,
		type = 1,
		sub_type = 5,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 21000000,
		extent = 0.008000
};

get(70131) ->
	#data_business_config{
		no = 70131,
		type = 1,
		sub_type = 1,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 1000000,
		extent = 0.008000
};

get(70132) ->
	#data_business_config{
		no = 70132,
		type = 1,
		sub_type = 2,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 2100000,
		extent = 0.008000
};

get(70133) ->
	#data_business_config{
		no = 70133,
		type = 1,
		sub_type = 3,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 4500000,
		extent = 0.008000
};

get(70134) ->
	#data_business_config{
		no = 70134,
		type = 1,
		sub_type = 4,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 10000000,
		extent = 0.008000
};

get(70135) ->
	#data_business_config{
		no = 70135,
		type = 1,
		sub_type = 5,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 21000000,
		extent = 0.008000
};

get(70121) ->
	#data_business_config{
		no = 70121,
		type = 1,
		sub_type = 1,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 1000000,
		extent = 0.008000
};

get(70122) ->
	#data_business_config{
		no = 70122,
		type = 1,
		sub_type = 2,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 2100000,
		extent = 0.008000
};

get(70123) ->
	#data_business_config{
		no = 70123,
		type = 1,
		sub_type = 3,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 4500000,
		extent = 0.008000
};

get(70124) ->
	#data_business_config{
		no = 70124,
		type = 1,
		sub_type = 4,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 10000000,
		extent = 0.008000
};

get(70125) ->
	#data_business_config{
		no = 70125,
		type = 1,
		sub_type = 5,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 21000000,
		extent = 0.008000
};

get(70111) ->
	#data_business_config{
		no = 70111,
		type = 1,
		sub_type = 1,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 1000000,
		extent = 0.008000
};

get(70112) ->
	#data_business_config{
		no = 70112,
		type = 1,
		sub_type = 2,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 2100000,
		extent = 0.008000
};

get(70113) ->
	#data_business_config{
		no = 70113,
		type = 1,
		sub_type = 3,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 4500000,
		extent = 0.008000
};

get(70114) ->
	#data_business_config{
		no = 70114,
		type = 1,
		sub_type = 4,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 10000000,
		extent = 0.008000
};

get(70115) ->
	#data_business_config{
		no = 70115,
		type = 1,
		sub_type = 5,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 21000000,
		extent = 0.008000
};

get(70101) ->
	#data_business_config{
		no = 70101,
		type = 1,
		sub_type = 1,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 1000000,
		extent = 0.008000
};

get(70102) ->
	#data_business_config{
		no = 70102,
		type = 1,
		sub_type = 2,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 2100000,
		extent = 0.008000
};

get(70103) ->
	#data_business_config{
		no = 70103,
		type = 1,
		sub_type = 3,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 4500000,
		extent = 0.008000
};

get(70104) ->
	#data_business_config{
		no = 70104,
		type = 1,
		sub_type = 4,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 10000000,
		extent = 0.008000
};

get(70105) ->
	#data_business_config{
		no = 70105,
		type = 1,
		sub_type = 5,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 50,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 21000000,
		extent = 0.008000
};

get(70011) ->
	#data_business_config{
		no = 70011,
		type = 4,
		sub_type = 1,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 60,
		global_buy_count_limit = 0,
		sell_count_limit = 200,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 250000,
		extent = 0.005000
};

get(70012) ->
	#data_business_config{
		no = 70012,
		type = 4,
		sub_type = 1,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 200,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 1500000,
		extent = 0.008000
};

get(50038) ->
	#data_business_config{
		no = 50038,
		type = 3,
		sub_type = 1,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 300,
		global_buy_count_limit = 0,
		sell_count_limit = 3000,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 50000,
		extent = 0.002000
};

get(50307) ->
	#data_business_config{
		no = 50307,
		type = 3,
		sub_type = 1,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 300,
		global_buy_count_limit = 0,
		sell_count_limit = 3000,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 50000,
		extent = 0.002000
};

get(60039) ->
	#data_business_config{
		no = 60039,
		type = 3,
		sub_type = 1,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 300,
		global_buy_count_limit = 0,
		sell_count_limit = 300,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 750000,
		extent = 0.002000
};

get(60040) ->
	#data_business_config{
		no = 60040,
		type = 3,
		sub_type = 1,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 300,
		global_buy_count_limit = 0,
		sell_count_limit = 300,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 7500000,
		extent = 0.002000
};

get(10056) ->
	#data_business_config{
		no = 10056,
		type = 6,
		sub_type = 1,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 200,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 500000,
		extent = 0.002000
};

get(10057) ->
	#data_business_config{
		no = 10057,
		type = 6,
		sub_type = 1,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 200,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 500000,
		extent = 0.002000
};

get(10058) ->
	#data_business_config{
		no = 10058,
		type = 6,
		sub_type = 1,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 200,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 500000,
		extent = 0.002000
};

get(10059) ->
	#data_business_config{
		no = 10059,
		type = 6,
		sub_type = 1,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 200,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 500000,
		extent = 0.002000
};

get(10060) ->
	#data_business_config{
		no = 10060,
		type = 6,
		sub_type = 1,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 200,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 500000,
		extent = 0.002000
};

get(10061) ->
	#data_business_config{
		no = 10061,
		type = 6,
		sub_type = 1,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 200,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 500000,
		extent = 0.002000
};

get(10062) ->
	#data_business_config{
		no = 10062,
		type = 6,
		sub_type = 1,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 200,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 500000,
		extent = 0.002000
};

get(10063) ->
	#data_business_config{
		no = 10063,
		type = 6,
		sub_type = 1,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 200,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 500000,
		extent = 0.002000
};

get(10064) ->
	#data_business_config{
		no = 10064,
		type = 6,
		sub_type = 1,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 200,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 500000,
		extent = 0.002000
};

get(10065) ->
	#data_business_config{
		no = 10065,
		type = 6,
		sub_type = 1,
		bind_state = 3,
		init_num = 99999999,
		refresh_num = 99999999,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 40,
		global_buy_count_limit = 0,
		sell_count_limit = 200,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 500000,
		extent = 0.002000
};

get(70506) ->
	#data_business_config{
		no = 70506,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 150000,
		extent = 0
};

get(70507) ->
	#data_business_config{
		no = 70507,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 150000,
		extent = 0
};

get(70508) ->
	#data_business_config{
		no = 70508,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 150000,
		extent = 0
};

get(70514) ->
	#data_business_config{
		no = 70514,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 150000,
		extent = 0
};

get(70515) ->
	#data_business_config{
		no = 70515,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 150000,
		extent = 0
};

get(70516) ->
	#data_business_config{
		no = 70516,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 150000,
		extent = 0
};

get(70522) ->
	#data_business_config{
		no = 70522,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 150000,
		extent = 0
};

get(70523) ->
	#data_business_config{
		no = 70523,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 150000,
		extent = 0
};

get(70524) ->
	#data_business_config{
		no = 70524,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 150000,
		extent = 0
};

get(70530) ->
	#data_business_config{
		no = 70530,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 150000,
		extent = 0
};

get(70531) ->
	#data_business_config{
		no = 70531,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 150000,
		extent = 0
};

get(70532) ->
	#data_business_config{
		no = 70532,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 150000,
		extent = 0
};

get(70538) ->
	#data_business_config{
		no = 70538,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 150000,
		extent = 0
};

get(70539) ->
	#data_business_config{
		no = 70539,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 150000,
		extent = 0
};

get(70540) ->
	#data_business_config{
		no = 70540,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 150000,
		extent = 0
};

get(70546) ->
	#data_business_config{
		no = 70546,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 150000,
		extent = 0
};

get(70547) ->
	#data_business_config{
		no = 70547,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 150000,
		extent = 0
};

get(70548) ->
	#data_business_config{
		no = 70548,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 150000,
		extent = 0
};

get(70554) ->
	#data_business_config{
		no = 70554,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 150000,
		extent = 0
};

get(70555) ->
	#data_business_config{
		no = 70555,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 150000,
		extent = 0
};

get(70556) ->
	#data_business_config{
		no = 70556,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 150000,
		extent = 0
};

get(70562) ->
	#data_business_config{
		no = 70562,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 150000,
		extent = 0
};

get(70563) ->
	#data_business_config{
		no = 70563,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 150000,
		extent = 0
};

get(70564) ->
	#data_business_config{
		no = 70564,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 150000,
		extent = 0
};

get(70570) ->
	#data_business_config{
		no = 70570,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 150000,
		extent = 0
};

get(70571) ->
	#data_business_config{
		no = 70571,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 150000,
		extent = 0
};

get(70572) ->
	#data_business_config{
		no = 70572,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 1,
		price = 150000,
		extent = 0
};

get(315005) ->
	#data_business_config{
		no = 315005,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(315007) ->
	#data_business_config{
		no = 315007,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(315009) ->
	#data_business_config{
		no = 315009,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(325005) ->
	#data_business_config{
		no = 325005,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(325007) ->
	#data_business_config{
		no = 325007,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(325009) ->
	#data_business_config{
		no = 325009,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(335005) ->
	#data_business_config{
		no = 335005,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(335007) ->
	#data_business_config{
		no = 335007,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(335009) ->
	#data_business_config{
		no = 335009,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(345005) ->
	#data_business_config{
		no = 345005,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(345007) ->
	#data_business_config{
		no = 345007,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(345009) ->
	#data_business_config{
		no = 345009,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(355005) ->
	#data_business_config{
		no = 355005,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(355007) ->
	#data_business_config{
		no = 355007,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(355009) ->
	#data_business_config{
		no = 355009,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(365005) ->
	#data_business_config{
		no = 365005,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(365007) ->
	#data_business_config{
		no = 365007,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(365009) ->
	#data_business_config{
		no = 365009,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(375005) ->
	#data_business_config{
		no = 375005,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(375007) ->
	#data_business_config{
		no = 375007,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(375009) ->
	#data_business_config{
		no = 375009,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(314105) ->
	#data_business_config{
		no = 314105,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(314107) ->
	#data_business_config{
		no = 314107,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(314109) ->
	#data_business_config{
		no = 314109,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(314155) ->
	#data_business_config{
		no = 314155,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(314157) ->
	#data_business_config{
		no = 314157,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(314159) ->
	#data_business_config{
		no = 314159,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(314205) ->
	#data_business_config{
		no = 314205,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(314207) ->
	#data_business_config{
		no = 314207,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(314209) ->
	#data_business_config{
		no = 314209,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(314255) ->
	#data_business_config{
		no = 314255,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(314257) ->
	#data_business_config{
		no = 314257,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(314259) ->
	#data_business_config{
		no = 314259,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(314305) ->
	#data_business_config{
		no = 314305,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(314307) ->
	#data_business_config{
		no = 314307,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(314309) ->
	#data_business_config{
		no = 314309,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(314355) ->
	#data_business_config{
		no = 314355,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(314357) ->
	#data_business_config{
		no = 314357,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(314359) ->
	#data_business_config{
		no = 314359,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(311005) ->
	#data_business_config{
		no = 311005,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(311007) ->
	#data_business_config{
		no = 311007,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(311009) ->
	#data_business_config{
		no = 311009,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(311055) ->
	#data_business_config{
		no = 311055,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(311057) ->
	#data_business_config{
		no = 311057,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(311059) ->
	#data_business_config{
		no = 311059,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(312005) ->
	#data_business_config{
		no = 312005,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(312007) ->
	#data_business_config{
		no = 312007,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(312009) ->
	#data_business_config{
		no = 312009,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(312055) ->
	#data_business_config{
		no = 312055,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(312057) ->
	#data_business_config{
		no = 312057,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(312059) ->
	#data_business_config{
		no = 312059,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(313005) ->
	#data_business_config{
		no = 313005,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(313007) ->
	#data_business_config{
		no = 313007,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(313009) ->
	#data_business_config{
		no = 313009,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(316005) ->
	#data_business_config{
		no = 316005,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(316007) ->
	#data_business_config{
		no = 316007,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(316009) ->
	#data_business_config{
		no = 316009,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(324105) ->
	#data_business_config{
		no = 324105,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(324107) ->
	#data_business_config{
		no = 324107,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(324109) ->
	#data_business_config{
		no = 324109,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(324155) ->
	#data_business_config{
		no = 324155,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(324157) ->
	#data_business_config{
		no = 324157,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(324159) ->
	#data_business_config{
		no = 324159,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(324205) ->
	#data_business_config{
		no = 324205,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(324207) ->
	#data_business_config{
		no = 324207,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(324209) ->
	#data_business_config{
		no = 324209,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(324255) ->
	#data_business_config{
		no = 324255,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(324257) ->
	#data_business_config{
		no = 324257,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(324259) ->
	#data_business_config{
		no = 324259,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(324305) ->
	#data_business_config{
		no = 324305,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(324307) ->
	#data_business_config{
		no = 324307,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(324309) ->
	#data_business_config{
		no = 324309,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(324355) ->
	#data_business_config{
		no = 324355,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(324357) ->
	#data_business_config{
		no = 324357,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(324359) ->
	#data_business_config{
		no = 324359,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(321005) ->
	#data_business_config{
		no = 321005,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(321007) ->
	#data_business_config{
		no = 321007,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(321009) ->
	#data_business_config{
		no = 321009,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(321055) ->
	#data_business_config{
		no = 321055,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(321057) ->
	#data_business_config{
		no = 321057,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(321059) ->
	#data_business_config{
		no = 321059,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(322005) ->
	#data_business_config{
		no = 322005,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(322007) ->
	#data_business_config{
		no = 322007,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(322009) ->
	#data_business_config{
		no = 322009,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(322055) ->
	#data_business_config{
		no = 322055,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(322057) ->
	#data_business_config{
		no = 322057,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(322059) ->
	#data_business_config{
		no = 322059,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(323005) ->
	#data_business_config{
		no = 323005,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(323007) ->
	#data_business_config{
		no = 323007,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(323009) ->
	#data_business_config{
		no = 323009,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(326005) ->
	#data_business_config{
		no = 326005,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(326007) ->
	#data_business_config{
		no = 326007,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(326009) ->
	#data_business_config{
		no = 326009,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(334105) ->
	#data_business_config{
		no = 334105,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(334107) ->
	#data_business_config{
		no = 334107,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(334109) ->
	#data_business_config{
		no = 334109,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(334155) ->
	#data_business_config{
		no = 334155,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(334157) ->
	#data_business_config{
		no = 334157,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(334159) ->
	#data_business_config{
		no = 334159,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(334205) ->
	#data_business_config{
		no = 334205,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(334207) ->
	#data_business_config{
		no = 334207,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(334209) ->
	#data_business_config{
		no = 334209,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(334255) ->
	#data_business_config{
		no = 334255,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(334257) ->
	#data_business_config{
		no = 334257,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(334259) ->
	#data_business_config{
		no = 334259,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(334305) ->
	#data_business_config{
		no = 334305,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(334307) ->
	#data_business_config{
		no = 334307,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(334309) ->
	#data_business_config{
		no = 334309,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(334355) ->
	#data_business_config{
		no = 334355,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(334357) ->
	#data_business_config{
		no = 334357,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(334359) ->
	#data_business_config{
		no = 334359,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(331005) ->
	#data_business_config{
		no = 331005,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(331007) ->
	#data_business_config{
		no = 331007,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(331009) ->
	#data_business_config{
		no = 331009,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(331055) ->
	#data_business_config{
		no = 331055,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(331057) ->
	#data_business_config{
		no = 331057,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(331059) ->
	#data_business_config{
		no = 331059,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(332005) ->
	#data_business_config{
		no = 332005,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(332007) ->
	#data_business_config{
		no = 332007,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(332009) ->
	#data_business_config{
		no = 332009,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(332055) ->
	#data_business_config{
		no = 332055,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(332057) ->
	#data_business_config{
		no = 332057,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(332059) ->
	#data_business_config{
		no = 332059,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(333005) ->
	#data_business_config{
		no = 333005,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(333007) ->
	#data_business_config{
		no = 333007,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(333009) ->
	#data_business_config{
		no = 333009,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(336005) ->
	#data_business_config{
		no = 336005,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(336007) ->
	#data_business_config{
		no = 336007,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(336009) ->
	#data_business_config{
		no = 336009,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(344105) ->
	#data_business_config{
		no = 344105,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(344107) ->
	#data_business_config{
		no = 344107,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(344109) ->
	#data_business_config{
		no = 344109,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(344155) ->
	#data_business_config{
		no = 344155,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(344157) ->
	#data_business_config{
		no = 344157,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(344159) ->
	#data_business_config{
		no = 344159,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(344205) ->
	#data_business_config{
		no = 344205,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(344207) ->
	#data_business_config{
		no = 344207,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(344209) ->
	#data_business_config{
		no = 344209,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(344255) ->
	#data_business_config{
		no = 344255,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(344257) ->
	#data_business_config{
		no = 344257,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(344259) ->
	#data_business_config{
		no = 344259,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(344305) ->
	#data_business_config{
		no = 344305,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(344307) ->
	#data_business_config{
		no = 344307,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(344309) ->
	#data_business_config{
		no = 344309,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(344355) ->
	#data_business_config{
		no = 344355,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(344357) ->
	#data_business_config{
		no = 344357,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(344359) ->
	#data_business_config{
		no = 344359,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(341005) ->
	#data_business_config{
		no = 341005,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(341007) ->
	#data_business_config{
		no = 341007,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(341009) ->
	#data_business_config{
		no = 341009,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(341055) ->
	#data_business_config{
		no = 341055,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(341057) ->
	#data_business_config{
		no = 341057,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(341059) ->
	#data_business_config{
		no = 341059,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(342005) ->
	#data_business_config{
		no = 342005,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(342007) ->
	#data_business_config{
		no = 342007,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(342009) ->
	#data_business_config{
		no = 342009,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(342055) ->
	#data_business_config{
		no = 342055,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(342057) ->
	#data_business_config{
		no = 342057,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(342059) ->
	#data_business_config{
		no = 342059,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(343005) ->
	#data_business_config{
		no = 343005,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(343007) ->
	#data_business_config{
		no = 343007,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(343009) ->
	#data_business_config{
		no = 343009,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(346005) ->
	#data_business_config{
		no = 346005,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(346007) ->
	#data_business_config{
		no = 346007,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(346009) ->
	#data_business_config{
		no = 346009,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(354105) ->
	#data_business_config{
		no = 354105,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(354107) ->
	#data_business_config{
		no = 354107,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(354109) ->
	#data_business_config{
		no = 354109,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(354155) ->
	#data_business_config{
		no = 354155,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(354157) ->
	#data_business_config{
		no = 354157,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(354159) ->
	#data_business_config{
		no = 354159,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(354205) ->
	#data_business_config{
		no = 354205,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(354207) ->
	#data_business_config{
		no = 354207,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(354209) ->
	#data_business_config{
		no = 354209,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(354255) ->
	#data_business_config{
		no = 354255,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(354257) ->
	#data_business_config{
		no = 354257,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(354259) ->
	#data_business_config{
		no = 354259,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(354305) ->
	#data_business_config{
		no = 354305,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(354307) ->
	#data_business_config{
		no = 354307,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(354309) ->
	#data_business_config{
		no = 354309,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(354355) ->
	#data_business_config{
		no = 354355,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(354357) ->
	#data_business_config{
		no = 354357,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(354359) ->
	#data_business_config{
		no = 354359,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(351005) ->
	#data_business_config{
		no = 351005,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(351007) ->
	#data_business_config{
		no = 351007,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(351009) ->
	#data_business_config{
		no = 351009,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(351055) ->
	#data_business_config{
		no = 351055,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(351057) ->
	#data_business_config{
		no = 351057,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(351059) ->
	#data_business_config{
		no = 351059,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(352005) ->
	#data_business_config{
		no = 352005,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(352007) ->
	#data_business_config{
		no = 352007,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(352009) ->
	#data_business_config{
		no = 352009,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(352055) ->
	#data_business_config{
		no = 352055,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(352057) ->
	#data_business_config{
		no = 352057,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(352059) ->
	#data_business_config{
		no = 352059,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(353005) ->
	#data_business_config{
		no = 353005,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(353007) ->
	#data_business_config{
		no = 353007,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(353009) ->
	#data_business_config{
		no = 353009,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(356005) ->
	#data_business_config{
		no = 356005,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(356007) ->
	#data_business_config{
		no = 356007,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(356009) ->
	#data_business_config{
		no = 356009,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(364105) ->
	#data_business_config{
		no = 364105,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(364107) ->
	#data_business_config{
		no = 364107,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(364109) ->
	#data_business_config{
		no = 364109,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(364155) ->
	#data_business_config{
		no = 364155,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(364157) ->
	#data_business_config{
		no = 364157,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(364159) ->
	#data_business_config{
		no = 364159,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(364205) ->
	#data_business_config{
		no = 364205,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(364207) ->
	#data_business_config{
		no = 364207,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(364209) ->
	#data_business_config{
		no = 364209,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(364255) ->
	#data_business_config{
		no = 364255,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(364257) ->
	#data_business_config{
		no = 364257,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(364259) ->
	#data_business_config{
		no = 364259,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(364305) ->
	#data_business_config{
		no = 364305,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(364307) ->
	#data_business_config{
		no = 364307,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(364309) ->
	#data_business_config{
		no = 364309,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(364355) ->
	#data_business_config{
		no = 364355,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(364357) ->
	#data_business_config{
		no = 364357,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(364359) ->
	#data_business_config{
		no = 364359,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(361005) ->
	#data_business_config{
		no = 361005,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(361007) ->
	#data_business_config{
		no = 361007,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(361009) ->
	#data_business_config{
		no = 361009,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(361055) ->
	#data_business_config{
		no = 361055,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(361057) ->
	#data_business_config{
		no = 361057,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(361059) ->
	#data_business_config{
		no = 361059,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(362005) ->
	#data_business_config{
		no = 362005,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(362007) ->
	#data_business_config{
		no = 362007,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(362009) ->
	#data_business_config{
		no = 362009,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(362055) ->
	#data_business_config{
		no = 362055,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(362057) ->
	#data_business_config{
		no = 362057,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(362059) ->
	#data_business_config{
		no = 362059,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(363005) ->
	#data_business_config{
		no = 363005,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(363007) ->
	#data_business_config{
		no = 363007,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(363009) ->
	#data_business_config{
		no = 363009,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(366005) ->
	#data_business_config{
		no = 366005,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 5,
		extent = 0
};

get(366007) ->
	#data_business_config{
		no = 366007,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 25,
		extent = 0
};

get(366009) ->
	#data_business_config{
		no = 366009,
		type = 14,
		sub_type = 100,
		bind_state = 3,
		init_num = 0,
		refresh_num = 0,
		refresh_cycle = 2,
		refresh_time = {4,0},
		buy_count_limit = 0,
		global_buy_count_limit = 0,
		sell_count_limit = 999999,
		global_sell_count_limit = 0,
		price_type = 14,
		price = 10,
		extent = 0
};

get(_No) ->
				?DEBUG_MSG("Cannot get ~p", [_No]),
          null.

