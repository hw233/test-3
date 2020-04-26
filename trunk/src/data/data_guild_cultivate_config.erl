%%%---------------------------------------
%%% @Module  : data_guild_cultivate_config
%%% @Author  : dsh
%%% @Email   : 
%%% @Description:  帮派点修等级配置表
%%%---------------------------------------


-module(data_guild_cultivate_config).
-include("common.hrl").
-include("record.hrl").
-include("record/guild_record.hrl").
-compile(export_all).

get(1) ->
	#guild_cultivate_lv_cfg{
		lv = 1,
		need_point = 10,
		price_type = 6,
		price = 20,
		do_phy_dam_scaling = 0.005000,
		do_mag_dam_scaling = 0.005000,
		heal_value = 0,
		seal_hit = 0.010000,
		seal_resis = 0.010000,
		be_phy_dam_reduce_coef = 0.005000,
		be_mag_dam_reduce_coef = 0.005000
};

get(2) ->
	#guild_cultivate_lv_cfg{
		lv = 2,
		need_point = 24,
		price_type = 6,
		price = 25,
		do_phy_dam_scaling = 0.010000,
		do_mag_dam_scaling = 0.010000,
		heal_value = 0,
		seal_hit = 0.020000,
		seal_resis = 0.020000,
		be_phy_dam_reduce_coef = 0.010000,
		be_mag_dam_reduce_coef = 0.010000
};

get(3) ->
	#guild_cultivate_lv_cfg{
		lv = 3,
		need_point = 38,
		price_type = 6,
		price = 30,
		do_phy_dam_scaling = 0.015000,
		do_mag_dam_scaling = 0.015000,
		heal_value = 0,
		seal_hit = 0.030000,
		seal_resis = 0.030000,
		be_phy_dam_reduce_coef = 0.015000,
		be_mag_dam_reduce_coef = 0.015000
};

get(4) ->
	#guild_cultivate_lv_cfg{
		lv = 4,
		need_point = 52,
		price_type = 6,
		price = 35,
		do_phy_dam_scaling = 0.020000,
		do_mag_dam_scaling = 0.020000,
		heal_value = 0,
		seal_hit = 0.040000,
		seal_resis = 0.040000,
		be_phy_dam_reduce_coef = 0.020000,
		be_mag_dam_reduce_coef = 0.020000
};

get(5) ->
	#guild_cultivate_lv_cfg{
		lv = 5,
		need_point = 66,
		price_type = 6,
		price = 40,
		do_phy_dam_scaling = 0.025000,
		do_mag_dam_scaling = 0.025000,
		heal_value = 0,
		seal_hit = 0.050000,
		seal_resis = 0.050000,
		be_phy_dam_reduce_coef = 0.025000,
		be_mag_dam_reduce_coef = 0.025000
};

get(6) ->
	#guild_cultivate_lv_cfg{
		lv = 6,
		need_point = 80,
		price_type = 6,
		price = 45,
		do_phy_dam_scaling = 0.030000,
		do_mag_dam_scaling = 0.030000,
		heal_value = 0,
		seal_hit = 0.060000,
		seal_resis = 0.060000,
		be_phy_dam_reduce_coef = 0.030000,
		be_mag_dam_reduce_coef = 0.030000
};

get(7) ->
	#guild_cultivate_lv_cfg{
		lv = 7,
		need_point = 94,
		price_type = 6,
		price = 50,
		do_phy_dam_scaling = 0.035000,
		do_mag_dam_scaling = 0.035000,
		heal_value = 0,
		seal_hit = 0.070000,
		seal_resis = 0.070000,
		be_phy_dam_reduce_coef = 0.035000,
		be_mag_dam_reduce_coef = 0.035000
};

get(8) ->
	#guild_cultivate_lv_cfg{
		lv = 8,
		need_point = 108,
		price_type = 6,
		price = 55,
		do_phy_dam_scaling = 0.040000,
		do_mag_dam_scaling = 0.040000,
		heal_value = 0,
		seal_hit = 0.080000,
		seal_resis = 0.080000,
		be_phy_dam_reduce_coef = 0.040000,
		be_mag_dam_reduce_coef = 0.040000
};

get(9) ->
	#guild_cultivate_lv_cfg{
		lv = 9,
		need_point = 122,
		price_type = 6,
		price = 60,
		do_phy_dam_scaling = 0.045000,
		do_mag_dam_scaling = 0.045000,
		heal_value = 0,
		seal_hit = 0.090000,
		seal_resis = 0.090000,
		be_phy_dam_reduce_coef = 0.045000,
		be_mag_dam_reduce_coef = 0.045000
};

get(10) ->
	#guild_cultivate_lv_cfg{
		lv = 10,
		need_point = 136,
		price_type = 6,
		price = 65,
		do_phy_dam_scaling = 0.050000,
		do_mag_dam_scaling = 0.050000,
		heal_value = 0,
		seal_hit = 0.100000,
		seal_resis = 0.100000,
		be_phy_dam_reduce_coef = 0.050000,
		be_mag_dam_reduce_coef = 0.050000
};

get(11) ->
	#guild_cultivate_lv_cfg{
		lv = 11,
		need_point = 150,
		price_type = 6,
		price = 70,
		do_phy_dam_scaling = 0.055000,
		do_mag_dam_scaling = 0.055000,
		heal_value = 0,
		seal_hit = 0.110000,
		seal_resis = 0.110000,
		be_phy_dam_reduce_coef = 0.055000,
		be_mag_dam_reduce_coef = 0.055000
};

get(12) ->
	#guild_cultivate_lv_cfg{
		lv = 12,
		need_point = 164,
		price_type = 6,
		price = 75,
		do_phy_dam_scaling = 0.060000,
		do_mag_dam_scaling = 0.060000,
		heal_value = 0,
		seal_hit = 0.120000,
		seal_resis = 0.120000,
		be_phy_dam_reduce_coef = 0.060000,
		be_mag_dam_reduce_coef = 0.060000
};

get(13) ->
	#guild_cultivate_lv_cfg{
		lv = 13,
		need_point = 178,
		price_type = 6,
		price = 80,
		do_phy_dam_scaling = 0.065000,
		do_mag_dam_scaling = 0.065000,
		heal_value = 0,
		seal_hit = 0.130000,
		seal_resis = 0.130000,
		be_phy_dam_reduce_coef = 0.065000,
		be_mag_dam_reduce_coef = 0.065000
};

get(14) ->
	#guild_cultivate_lv_cfg{
		lv = 14,
		need_point = 192,
		price_type = 6,
		price = 85,
		do_phy_dam_scaling = 0.070000,
		do_mag_dam_scaling = 0.070000,
		heal_value = 0,
		seal_hit = 0.140000,
		seal_resis = 0.140000,
		be_phy_dam_reduce_coef = 0.070000,
		be_mag_dam_reduce_coef = 0.070000
};

get(15) ->
	#guild_cultivate_lv_cfg{
		lv = 15,
		need_point = 206,
		price_type = 6,
		price = 90,
		do_phy_dam_scaling = 0.075000,
		do_mag_dam_scaling = 0.075000,
		heal_value = 0,
		seal_hit = 0.150000,
		seal_resis = 0.150000,
		be_phy_dam_reduce_coef = 0.075000,
		be_mag_dam_reduce_coef = 0.075000
};

get(16) ->
	#guild_cultivate_lv_cfg{
		lv = 16,
		need_point = 220,
		price_type = 6,
		price = 95,
		do_phy_dam_scaling = 0.080000,
		do_mag_dam_scaling = 0.080000,
		heal_value = 0,
		seal_hit = 0.160000,
		seal_resis = 0.160000,
		be_phy_dam_reduce_coef = 0.080000,
		be_mag_dam_reduce_coef = 0.080000
};

get(17) ->
	#guild_cultivate_lv_cfg{
		lv = 17,
		need_point = 234,
		price_type = 6,
		price = 100,
		do_phy_dam_scaling = 0.085000,
		do_mag_dam_scaling = 0.085000,
		heal_value = 0,
		seal_hit = 0.170000,
		seal_resis = 0.170000,
		be_phy_dam_reduce_coef = 0.085000,
		be_mag_dam_reduce_coef = 0.085000
};

get(18) ->
	#guild_cultivate_lv_cfg{
		lv = 18,
		need_point = 248,
		price_type = 6,
		price = 105,
		do_phy_dam_scaling = 0.090000,
		do_mag_dam_scaling = 0.090000,
		heal_value = 0,
		seal_hit = 0.180000,
		seal_resis = 0.180000,
		be_phy_dam_reduce_coef = 0.090000,
		be_mag_dam_reduce_coef = 0.090000
};

get(19) ->
	#guild_cultivate_lv_cfg{
		lv = 19,
		need_point = 262,
		price_type = 6,
		price = 110,
		do_phy_dam_scaling = 0.095000,
		do_mag_dam_scaling = 0.095000,
		heal_value = 0,
		seal_hit = 0.190000,
		seal_resis = 0.190000,
		be_phy_dam_reduce_coef = 0.095000,
		be_mag_dam_reduce_coef = 0.095000
};

get(20) ->
	#guild_cultivate_lv_cfg{
		lv = 20,
		need_point = 276,
		price_type = 6,
		price = 115,
		do_phy_dam_scaling = 0.100000,
		do_mag_dam_scaling = 0.100000,
		heal_value = 0,
		seal_hit = 0.200000,
		seal_resis = 0.200000,
		be_phy_dam_reduce_coef = 0.100000,
		be_mag_dam_reduce_coef = 0.100000
};

get(21) ->
	#guild_cultivate_lv_cfg{
		lv = 21,
		need_point = 290,
		price_type = 6,
		price = 120,
		do_phy_dam_scaling = 0.105000,
		do_mag_dam_scaling = 0.105000,
		heal_value = 0,
		seal_hit = 0.210000,
		seal_resis = 0.210000,
		be_phy_dam_reduce_coef = 0.105000,
		be_mag_dam_reduce_coef = 0.105000
};

get(22) ->
	#guild_cultivate_lv_cfg{
		lv = 22,
		need_point = 304,
		price_type = 6,
		price = 125,
		do_phy_dam_scaling = 0.110000,
		do_mag_dam_scaling = 0.110000,
		heal_value = 0,
		seal_hit = 0.220000,
		seal_resis = 0.220000,
		be_phy_dam_reduce_coef = 0.110000,
		be_mag_dam_reduce_coef = 0.110000
};

get(23) ->
	#guild_cultivate_lv_cfg{
		lv = 23,
		need_point = 318,
		price_type = 6,
		price = 130,
		do_phy_dam_scaling = 0.115000,
		do_mag_dam_scaling = 0.115000,
		heal_value = 0,
		seal_hit = 0.230000,
		seal_resis = 0.230000,
		be_phy_dam_reduce_coef = 0.115000,
		be_mag_dam_reduce_coef = 0.115000
};

get(24) ->
	#guild_cultivate_lv_cfg{
		lv = 24,
		need_point = 332,
		price_type = 6,
		price = 135,
		do_phy_dam_scaling = 0.120000,
		do_mag_dam_scaling = 0.120000,
		heal_value = 0,
		seal_hit = 0.240000,
		seal_resis = 0.240000,
		be_phy_dam_reduce_coef = 0.120000,
		be_mag_dam_reduce_coef = 0.120000
};

get(25) ->
	#guild_cultivate_lv_cfg{
		lv = 25,
		need_point = 346,
		price_type = 6,
		price = 140,
		do_phy_dam_scaling = 0.125000,
		do_mag_dam_scaling = 0.125000,
		heal_value = 0,
		seal_hit = 0.250000,
		seal_resis = 0.250000,
		be_phy_dam_reduce_coef = 0.125000,
		be_mag_dam_reduce_coef = 0.125000
};

get(26) ->
	#guild_cultivate_lv_cfg{
		lv = 26,
		need_point = 360,
		price_type = 6,
		price = 145,
		do_phy_dam_scaling = 0.130000,
		do_mag_dam_scaling = 0.130000,
		heal_value = 0,
		seal_hit = 0.260000,
		seal_resis = 0.260000,
		be_phy_dam_reduce_coef = 0.130000,
		be_mag_dam_reduce_coef = 0.130000
};

get(27) ->
	#guild_cultivate_lv_cfg{
		lv = 27,
		need_point = 374,
		price_type = 6,
		price = 150,
		do_phy_dam_scaling = 0.135000,
		do_mag_dam_scaling = 0.135000,
		heal_value = 0,
		seal_hit = 0.270000,
		seal_resis = 0.270000,
		be_phy_dam_reduce_coef = 0.135000,
		be_mag_dam_reduce_coef = 0.135000
};

get(28) ->
	#guild_cultivate_lv_cfg{
		lv = 28,
		need_point = 388,
		price_type = 6,
		price = 155,
		do_phy_dam_scaling = 0.140000,
		do_mag_dam_scaling = 0.140000,
		heal_value = 0,
		seal_hit = 0.280000,
		seal_resis = 0.280000,
		be_phy_dam_reduce_coef = 0.140000,
		be_mag_dam_reduce_coef = 0.140000
};

get(29) ->
	#guild_cultivate_lv_cfg{
		lv = 29,
		need_point = 402,
		price_type = 6,
		price = 160,
		do_phy_dam_scaling = 0.145000,
		do_mag_dam_scaling = 0.145000,
		heal_value = 0,
		seal_hit = 0.290000,
		seal_resis = 0.290000,
		be_phy_dam_reduce_coef = 0.145000,
		be_mag_dam_reduce_coef = 0.145000
};

get(30) ->
	#guild_cultivate_lv_cfg{
		lv = 30,
		need_point = 416,
		price_type = 6,
		price = 165,
		do_phy_dam_scaling = 0.150000,
		do_mag_dam_scaling = 0.150000,
		heal_value = 0,
		seal_hit = 0.300000,
		seal_resis = 0.300000,
		be_phy_dam_reduce_coef = 0.150000,
		be_mag_dam_reduce_coef = 0.150000
};

get(31) ->
	#guild_cultivate_lv_cfg{
		lv = 31,
		need_point = 430,
		price_type = 6,
		price = 170,
		do_phy_dam_scaling = 0.155000,
		do_mag_dam_scaling = 0.155000,
		heal_value = 0,
		seal_hit = 0.310000,
		seal_resis = 0.310000,
		be_phy_dam_reduce_coef = 0.155000,
		be_mag_dam_reduce_coef = 0.155000
};

get(32) ->
	#guild_cultivate_lv_cfg{
		lv = 32,
		need_point = 444,
		price_type = 6,
		price = 175,
		do_phy_dam_scaling = 0.160000,
		do_mag_dam_scaling = 0.160000,
		heal_value = 0,
		seal_hit = 0.320000,
		seal_resis = 0.320000,
		be_phy_dam_reduce_coef = 0.160000,
		be_mag_dam_reduce_coef = 0.160000
};

get(33) ->
	#guild_cultivate_lv_cfg{
		lv = 33,
		need_point = 458,
		price_type = 6,
		price = 180,
		do_phy_dam_scaling = 0.165000,
		do_mag_dam_scaling = 0.165000,
		heal_value = 0,
		seal_hit = 0.330000,
		seal_resis = 0.330000,
		be_phy_dam_reduce_coef = 0.165000,
		be_mag_dam_reduce_coef = 0.165000
};

get(34) ->
	#guild_cultivate_lv_cfg{
		lv = 34,
		need_point = 472,
		price_type = 6,
		price = 185,
		do_phy_dam_scaling = 0.170000,
		do_mag_dam_scaling = 0.170000,
		heal_value = 0,
		seal_hit = 0.340000,
		seal_resis = 0.340000,
		be_phy_dam_reduce_coef = 0.170000,
		be_mag_dam_reduce_coef = 0.170000
};

get(35) ->
	#guild_cultivate_lv_cfg{
		lv = 35,
		need_point = 486,
		price_type = 6,
		price = 190,
		do_phy_dam_scaling = 0.175000,
		do_mag_dam_scaling = 0.175000,
		heal_value = 0,
		seal_hit = 0.350000,
		seal_resis = 0.350000,
		be_phy_dam_reduce_coef = 0.175000,
		be_mag_dam_reduce_coef = 0.175000
};

get(36) ->
	#guild_cultivate_lv_cfg{
		lv = 36,
		need_point = 500,
		price_type = 6,
		price = 195,
		do_phy_dam_scaling = 0.180000,
		do_mag_dam_scaling = 0.180000,
		heal_value = 0,
		seal_hit = 0.360000,
		seal_resis = 0.360000,
		be_phy_dam_reduce_coef = 0.180000,
		be_mag_dam_reduce_coef = 0.180000
};

get(37) ->
	#guild_cultivate_lv_cfg{
		lv = 37,
		need_point = 514,
		price_type = 6,
		price = 200,
		do_phy_dam_scaling = 0.185000,
		do_mag_dam_scaling = 0.185000,
		heal_value = 0,
		seal_hit = 0.370000,
		seal_resis = 0.370000,
		be_phy_dam_reduce_coef = 0.185000,
		be_mag_dam_reduce_coef = 0.185000
};

get(38) ->
	#guild_cultivate_lv_cfg{
		lv = 38,
		need_point = 528,
		price_type = 6,
		price = 205,
		do_phy_dam_scaling = 0.190000,
		do_mag_dam_scaling = 0.190000,
		heal_value = 0,
		seal_hit = 0.380000,
		seal_resis = 0.380000,
		be_phy_dam_reduce_coef = 0.190000,
		be_mag_dam_reduce_coef = 0.190000
};

get(39) ->
	#guild_cultivate_lv_cfg{
		lv = 39,
		need_point = 542,
		price_type = 6,
		price = 210,
		do_phy_dam_scaling = 0.195000,
		do_mag_dam_scaling = 0.195000,
		heal_value = 0,
		seal_hit = 0.390000,
		seal_resis = 0.390000,
		be_phy_dam_reduce_coef = 0.195000,
		be_mag_dam_reduce_coef = 0.195000
};

get(40) ->
	#guild_cultivate_lv_cfg{
		lv = 40,
		need_point = 556,
		price_type = 6,
		price = 215,
		do_phy_dam_scaling = 0.200000,
		do_mag_dam_scaling = 0.200000,
		heal_value = 0,
		seal_hit = 0.400000,
		seal_resis = 0.400000,
		be_phy_dam_reduce_coef = 0.200000,
		be_mag_dam_reduce_coef = 0.200000
};

get(41) ->
	#guild_cultivate_lv_cfg{
		lv = 41,
		need_point = 570,
		price_type = 6,
		price = 220,
		do_phy_dam_scaling = 0.205000,
		do_mag_dam_scaling = 0.205000,
		heal_value = 0,
		seal_hit = 0.410000,
		seal_resis = 0.410000,
		be_phy_dam_reduce_coef = 0.205000,
		be_mag_dam_reduce_coef = 0.205000
};

get(42) ->
	#guild_cultivate_lv_cfg{
		lv = 42,
		need_point = 584,
		price_type = 6,
		price = 225,
		do_phy_dam_scaling = 0.210000,
		do_mag_dam_scaling = 0.210000,
		heal_value = 0,
		seal_hit = 0.420000,
		seal_resis = 0.420000,
		be_phy_dam_reduce_coef = 0.210000,
		be_mag_dam_reduce_coef = 0.210000
};

get(43) ->
	#guild_cultivate_lv_cfg{
		lv = 43,
		need_point = 598,
		price_type = 6,
		price = 230,
		do_phy_dam_scaling = 0.215000,
		do_mag_dam_scaling = 0.215000,
		heal_value = 0,
		seal_hit = 0.430000,
		seal_resis = 0.430000,
		be_phy_dam_reduce_coef = 0.215000,
		be_mag_dam_reduce_coef = 0.215000
};

get(44) ->
	#guild_cultivate_lv_cfg{
		lv = 44,
		need_point = 612,
		price_type = 6,
		price = 235,
		do_phy_dam_scaling = 0.220000,
		do_mag_dam_scaling = 0.220000,
		heal_value = 0,
		seal_hit = 0.440000,
		seal_resis = 0.440000,
		be_phy_dam_reduce_coef = 0.220000,
		be_mag_dam_reduce_coef = 0.220000
};

get(45) ->
	#guild_cultivate_lv_cfg{
		lv = 45,
		need_point = 626,
		price_type = 6,
		price = 240,
		do_phy_dam_scaling = 0.225000,
		do_mag_dam_scaling = 0.225000,
		heal_value = 0,
		seal_hit = 0.450000,
		seal_resis = 0.450000,
		be_phy_dam_reduce_coef = 0.225000,
		be_mag_dam_reduce_coef = 0.225000
};

get(46) ->
	#guild_cultivate_lv_cfg{
		lv = 46,
		need_point = 640,
		price_type = 6,
		price = 245,
		do_phy_dam_scaling = 0.230000,
		do_mag_dam_scaling = 0.230000,
		heal_value = 0,
		seal_hit = 0.460000,
		seal_resis = 0.460000,
		be_phy_dam_reduce_coef = 0.230000,
		be_mag_dam_reduce_coef = 0.230000
};

get(47) ->
	#guild_cultivate_lv_cfg{
		lv = 47,
		need_point = 654,
		price_type = 6,
		price = 250,
		do_phy_dam_scaling = 0.235000,
		do_mag_dam_scaling = 0.235000,
		heal_value = 0,
		seal_hit = 0.470000,
		seal_resis = 0.470000,
		be_phy_dam_reduce_coef = 0.235000,
		be_mag_dam_reduce_coef = 0.235000
};

get(48) ->
	#guild_cultivate_lv_cfg{
		lv = 48,
		need_point = 668,
		price_type = 6,
		price = 255,
		do_phy_dam_scaling = 0.240000,
		do_mag_dam_scaling = 0.240000,
		heal_value = 0,
		seal_hit = 0.480000,
		seal_resis = 0.480000,
		be_phy_dam_reduce_coef = 0.240000,
		be_mag_dam_reduce_coef = 0.240000
};

get(49) ->
	#guild_cultivate_lv_cfg{
		lv = 49,
		need_point = 682,
		price_type = 6,
		price = 260,
		do_phy_dam_scaling = 0.245000,
		do_mag_dam_scaling = 0.245000,
		heal_value = 0,
		seal_hit = 0.490000,
		seal_resis = 0.490000,
		be_phy_dam_reduce_coef = 0.245000,
		be_mag_dam_reduce_coef = 0.245000
};

get(50) ->
	#guild_cultivate_lv_cfg{
		lv = 50,
		need_point = 696,
		price_type = 6,
		price = 280,
		do_phy_dam_scaling = 0.250000,
		do_mag_dam_scaling = 0.250000,
		heal_value = 0,
		seal_hit = 0.500000,
		seal_resis = 0.500000,
		be_phy_dam_reduce_coef = 0.250000,
		be_mag_dam_reduce_coef = 0.250000
};

get(51) ->
	#guild_cultivate_lv_cfg{
		lv = 51,
		need_point = 710,
		price_type = 6,
		price = 300,
		do_phy_dam_scaling = 0.255000,
		do_mag_dam_scaling = 0.255000,
		heal_value = 0,
		seal_hit = 0.510000,
		seal_resis = 0.510000,
		be_phy_dam_reduce_coef = 0.255000,
		be_mag_dam_reduce_coef = 0.255000
};

get(52) ->
	#guild_cultivate_lv_cfg{
		lv = 52,
		need_point = 724,
		price_type = 6,
		price = 320,
		do_phy_dam_scaling = 0.260000,
		do_mag_dam_scaling = 0.260000,
		heal_value = 0,
		seal_hit = 0.520000,
		seal_resis = 0.520000,
		be_phy_dam_reduce_coef = 0.260000,
		be_mag_dam_reduce_coef = 0.260000
};

get(53) ->
	#guild_cultivate_lv_cfg{
		lv = 53,
		need_point = 738,
		price_type = 6,
		price = 340,
		do_phy_dam_scaling = 0.265000,
		do_mag_dam_scaling = 0.265000,
		heal_value = 0,
		seal_hit = 0.530000,
		seal_resis = 0.530000,
		be_phy_dam_reduce_coef = 0.265000,
		be_mag_dam_reduce_coef = 0.265000
};

get(54) ->
	#guild_cultivate_lv_cfg{
		lv = 54,
		need_point = 752,
		price_type = 6,
		price = 360,
		do_phy_dam_scaling = 0.270000,
		do_mag_dam_scaling = 0.270000,
		heal_value = 0,
		seal_hit = 0.540000,
		seal_resis = 0.540000,
		be_phy_dam_reduce_coef = 0.270000,
		be_mag_dam_reduce_coef = 0.270000
};

get(55) ->
	#guild_cultivate_lv_cfg{
		lv = 55,
		need_point = 766,
		price_type = 6,
		price = 380,
		do_phy_dam_scaling = 0.275000,
		do_mag_dam_scaling = 0.275000,
		heal_value = 0,
		seal_hit = 0.550000,
		seal_resis = 0.550000,
		be_phy_dam_reduce_coef = 0.275000,
		be_mag_dam_reduce_coef = 0.275000
};

get(56) ->
	#guild_cultivate_lv_cfg{
		lv = 56,
		need_point = 780,
		price_type = 6,
		price = 400,
		do_phy_dam_scaling = 0.280000,
		do_mag_dam_scaling = 0.280000,
		heal_value = 0,
		seal_hit = 0.560000,
		seal_resis = 0.560000,
		be_phy_dam_reduce_coef = 0.280000,
		be_mag_dam_reduce_coef = 0.280000
};

get(57) ->
	#guild_cultivate_lv_cfg{
		lv = 57,
		need_point = 794,
		price_type = 6,
		price = 430,
		do_phy_dam_scaling = 0.285000,
		do_mag_dam_scaling = 0.285000,
		heal_value = 0,
		seal_hit = 0.570000,
		seal_resis = 0.570000,
		be_phy_dam_reduce_coef = 0.285000,
		be_mag_dam_reduce_coef = 0.285000
};

get(58) ->
	#guild_cultivate_lv_cfg{
		lv = 58,
		need_point = 808,
		price_type = 6,
		price = 460,
		do_phy_dam_scaling = 0.290000,
		do_mag_dam_scaling = 0.290000,
		heal_value = 0,
		seal_hit = 0.580000,
		seal_resis = 0.580000,
		be_phy_dam_reduce_coef = 0.290000,
		be_mag_dam_reduce_coef = 0.290000
};

get(59) ->
	#guild_cultivate_lv_cfg{
		lv = 59,
		need_point = 822,
		price_type = 6,
		price = 500,
		do_phy_dam_scaling = 0.295000,
		do_mag_dam_scaling = 0.295000,
		heal_value = 0,
		seal_hit = 0.590000,
		seal_resis = 0.590000,
		be_phy_dam_reduce_coef = 0.295000,
		be_mag_dam_reduce_coef = 0.295000
};

get(60) ->
	#guild_cultivate_lv_cfg{
		lv = 60,
		need_point = 836,
		price_type = 6,
		price = 550,
		do_phy_dam_scaling = 0.300000,
		do_mag_dam_scaling = 0.300000,
		heal_value = 0,
		seal_hit = 0.600000,
		seal_resis = 0.600000,
		be_phy_dam_reduce_coef = 0.300000,
		be_mag_dam_reduce_coef = 0.300000
};

get(61) ->
	#guild_cultivate_lv_cfg{
		lv = 61,
		need_point = 850,
		price_type = 6,
		price = 600,
		do_phy_dam_scaling = 0.305000,
		do_mag_dam_scaling = 0.305000,
		heal_value = 0,
		seal_hit = 0.610000,
		seal_resis = 0.610000,
		be_phy_dam_reduce_coef = 0.305000,
		be_mag_dam_reduce_coef = 0.305000
};

get(62) ->
	#guild_cultivate_lv_cfg{
		lv = 62,
		need_point = 864,
		price_type = 6,
		price = 650,
		do_phy_dam_scaling = 0.310000,
		do_mag_dam_scaling = 0.310000,
		heal_value = 0,
		seal_hit = 0.620000,
		seal_resis = 0.620000,
		be_phy_dam_reduce_coef = 0.310000,
		be_mag_dam_reduce_coef = 0.310000
};

get(63) ->
	#guild_cultivate_lv_cfg{
		lv = 63,
		need_point = 878,
		price_type = 6,
		price = 700,
		do_phy_dam_scaling = 0.315000,
		do_mag_dam_scaling = 0.315000,
		heal_value = 0,
		seal_hit = 0.630000,
		seal_resis = 0.630000,
		be_phy_dam_reduce_coef = 0.315000,
		be_mag_dam_reduce_coef = 0.315000
};

get(64) ->
	#guild_cultivate_lv_cfg{
		lv = 64,
		need_point = 892,
		price_type = 6,
		price = 750,
		do_phy_dam_scaling = 0.320000,
		do_mag_dam_scaling = 0.320000,
		heal_value = 0,
		seal_hit = 0.640000,
		seal_resis = 0.640000,
		be_phy_dam_reduce_coef = 0.320000,
		be_mag_dam_reduce_coef = 0.320000
};

get(65) ->
	#guild_cultivate_lv_cfg{
		lv = 65,
		need_point = 906,
		price_type = 6,
		price = 800,
		do_phy_dam_scaling = 0.325000,
		do_mag_dam_scaling = 0.325000,
		heal_value = 0,
		seal_hit = 0.650000,
		seal_resis = 0.650000,
		be_phy_dam_reduce_coef = 0.325000,
		be_mag_dam_reduce_coef = 0.325000
};

get(66) ->
	#guild_cultivate_lv_cfg{
		lv = 66,
		need_point = 920,
		price_type = 6,
		price = 850,
		do_phy_dam_scaling = 0.330000,
		do_mag_dam_scaling = 0.330000,
		heal_value = 0,
		seal_hit = 0.660000,
		seal_resis = 0.660000,
		be_phy_dam_reduce_coef = 0.330000,
		be_mag_dam_reduce_coef = 0.330000
};

get(67) ->
	#guild_cultivate_lv_cfg{
		lv = 67,
		need_point = 934,
		price_type = 6,
		price = 900,
		do_phy_dam_scaling = 0.335000,
		do_mag_dam_scaling = 0.335000,
		heal_value = 0,
		seal_hit = 0.670000,
		seal_resis = 0.670000,
		be_phy_dam_reduce_coef = 0.335000,
		be_mag_dam_reduce_coef = 0.335000
};

get(68) ->
	#guild_cultivate_lv_cfg{
		lv = 68,
		need_point = 948,
		price_type = 6,
		price = 1000,
		do_phy_dam_scaling = 0.340000,
		do_mag_dam_scaling = 0.340000,
		heal_value = 0,
		seal_hit = 0.680000,
		seal_resis = 0.680000,
		be_phy_dam_reduce_coef = 0.340000,
		be_mag_dam_reduce_coef = 0.340000
};

get(69) ->
	#guild_cultivate_lv_cfg{
		lv = 69,
		need_point = 962,
		price_type = 6,
		price = 1200,
		do_phy_dam_scaling = 0.345000,
		do_mag_dam_scaling = 0.345000,
		heal_value = 0,
		seal_hit = 0.690000,
		seal_resis = 0.690000,
		be_phy_dam_reduce_coef = 0.345000,
		be_mag_dam_reduce_coef = 0.345000
};

get(70) ->
	#guild_cultivate_lv_cfg{
		lv = 70,
		need_point = 976,
		price_type = 6,
		price = 1400,
		do_phy_dam_scaling = 0.350000,
		do_mag_dam_scaling = 0.350000,
		heal_value = 0,
		seal_hit = 0.700000,
		seal_resis = 0.700000,
		be_phy_dam_reduce_coef = 0.350000,
		be_mag_dam_reduce_coef = 0.350000
};

get(71) ->
	#guild_cultivate_lv_cfg{
		lv = 71,
		need_point = 990,
		price_type = 6,
		price = 1600,
		do_phy_dam_scaling = 0.355000,
		do_mag_dam_scaling = 0.355000,
		heal_value = 0,
		seal_hit = 0.710000,
		seal_resis = 0.710000,
		be_phy_dam_reduce_coef = 0.355000,
		be_mag_dam_reduce_coef = 0.355000
};

get(72) ->
	#guild_cultivate_lv_cfg{
		lv = 72,
		need_point = 1004,
		price_type = 6,
		price = 1800,
		do_phy_dam_scaling = 0.360000,
		do_mag_dam_scaling = 0.360000,
		heal_value = 0,
		seal_hit = 0.720000,
		seal_resis = 0.720000,
		be_phy_dam_reduce_coef = 0.360000,
		be_mag_dam_reduce_coef = 0.360000
};

get(73) ->
	#guild_cultivate_lv_cfg{
		lv = 73,
		need_point = 1018,
		price_type = 6,
		price = 2000,
		do_phy_dam_scaling = 0.365000,
		do_mag_dam_scaling = 0.365000,
		heal_value = 0,
		seal_hit = 0.730000,
		seal_resis = 0.730000,
		be_phy_dam_reduce_coef = 0.365000,
		be_mag_dam_reduce_coef = 0.365000
};

get(74) ->
	#guild_cultivate_lv_cfg{
		lv = 74,
		need_point = 1032,
		price_type = 6,
		price = 2200,
		do_phy_dam_scaling = 0.370000,
		do_mag_dam_scaling = 0.370000,
		heal_value = 0,
		seal_hit = 0.740000,
		seal_resis = 0.740000,
		be_phy_dam_reduce_coef = 0.370000,
		be_mag_dam_reduce_coef = 0.370000
};

get(75) ->
	#guild_cultivate_lv_cfg{
		lv = 75,
		need_point = 1046,
		price_type = 6,
		price = 2400,
		do_phy_dam_scaling = 0.375000,
		do_mag_dam_scaling = 0.375000,
		heal_value = 0,
		seal_hit = 0.750000,
		seal_resis = 0.750000,
		be_phy_dam_reduce_coef = 0.375000,
		be_mag_dam_reduce_coef = 0.375000
};

get(76) ->
	#guild_cultivate_lv_cfg{
		lv = 76,
		need_point = 1060,
		price_type = 6,
		price = 2600,
		do_phy_dam_scaling = 0.380000,
		do_mag_dam_scaling = 0.380000,
		heal_value = 0,
		seal_hit = 0.760000,
		seal_resis = 0.760000,
		be_phy_dam_reduce_coef = 0.380000,
		be_mag_dam_reduce_coef = 0.380000
};

get(77) ->
	#guild_cultivate_lv_cfg{
		lv = 77,
		need_point = 1074,
		price_type = 6,
		price = 2800,
		do_phy_dam_scaling = 0.385000,
		do_mag_dam_scaling = 0.385000,
		heal_value = 0,
		seal_hit = 0.770000,
		seal_resis = 0.770000,
		be_phy_dam_reduce_coef = 0.385000,
		be_mag_dam_reduce_coef = 0.385000
};

get(78) ->
	#guild_cultivate_lv_cfg{
		lv = 78,
		need_point = 1088,
		price_type = 6,
		price = 3000,
		do_phy_dam_scaling = 0.390000,
		do_mag_dam_scaling = 0.390000,
		heal_value = 0,
		seal_hit = 0.780000,
		seal_resis = 0.780000,
		be_phy_dam_reduce_coef = 0.390000,
		be_mag_dam_reduce_coef = 0.390000
};

get(79) ->
	#guild_cultivate_lv_cfg{
		lv = 79,
		need_point = 1102,
		price_type = 6,
		price = 3200,
		do_phy_dam_scaling = 0.395000,
		do_mag_dam_scaling = 0.395000,
		heal_value = 0,
		seal_hit = 0.790000,
		seal_resis = 0.790000,
		be_phy_dam_reduce_coef = 0.395000,
		be_mag_dam_reduce_coef = 0.395000
};

get(80) ->
	#guild_cultivate_lv_cfg{
		lv = 80,
		need_point = 1116,
		price_type = 6,
		price = 3400,
		do_phy_dam_scaling = 0.400000,
		do_mag_dam_scaling = 0.400000,
		heal_value = 0,
		seal_hit = 0.800000,
		seal_resis = 0.800000,
		be_phy_dam_reduce_coef = 0.400000,
		be_mag_dam_reduce_coef = 0.400000
};

get(81) ->
	#guild_cultivate_lv_cfg{
		lv = 81,
		need_point = 1130,
		price_type = 6,
		price = 3600,
		do_phy_dam_scaling = 0.405000,
		do_mag_dam_scaling = 0.405000,
		heal_value = 0,
		seal_hit = 0.810000,
		seal_resis = 0.810000,
		be_phy_dam_reduce_coef = 0.405000,
		be_mag_dam_reduce_coef = 0.405000
};

get(82) ->
	#guild_cultivate_lv_cfg{
		lv = 82,
		need_point = 1144,
		price_type = 6,
		price = 3800,
		do_phy_dam_scaling = 0.410000,
		do_mag_dam_scaling = 0.410000,
		heal_value = 0,
		seal_hit = 0.820000,
		seal_resis = 0.820000,
		be_phy_dam_reduce_coef = 0.410000,
		be_mag_dam_reduce_coef = 0.410000
};

get(83) ->
	#guild_cultivate_lv_cfg{
		lv = 83,
		need_point = 1158,
		price_type = 6,
		price = 4000,
		do_phy_dam_scaling = 0.415000,
		do_mag_dam_scaling = 0.415000,
		heal_value = 0,
		seal_hit = 0.830000,
		seal_resis = 0.830000,
		be_phy_dam_reduce_coef = 0.415000,
		be_mag_dam_reduce_coef = 0.415000
};

get(84) ->
	#guild_cultivate_lv_cfg{
		lv = 84,
		need_point = 1172,
		price_type = 6,
		price = 4200,
		do_phy_dam_scaling = 0.420000,
		do_mag_dam_scaling = 0.420000,
		heal_value = 0,
		seal_hit = 0.840000,
		seal_resis = 0.840000,
		be_phy_dam_reduce_coef = 0.420000,
		be_mag_dam_reduce_coef = 0.420000
};

get(85) ->
	#guild_cultivate_lv_cfg{
		lv = 85,
		need_point = 1186,
		price_type = 6,
		price = 4400,
		do_phy_dam_scaling = 0.425000,
		do_mag_dam_scaling = 0.425000,
		heal_value = 0,
		seal_hit = 0.850000,
		seal_resis = 0.850000,
		be_phy_dam_reduce_coef = 0.425000,
		be_mag_dam_reduce_coef = 0.425000
};

get(86) ->
	#guild_cultivate_lv_cfg{
		lv = 86,
		need_point = 1200,
		price_type = 6,
		price = 4600,
		do_phy_dam_scaling = 0.430000,
		do_mag_dam_scaling = 0.430000,
		heal_value = 0,
		seal_hit = 0.860000,
		seal_resis = 0.860000,
		be_phy_dam_reduce_coef = 0.430000,
		be_mag_dam_reduce_coef = 0.430000
};

get(87) ->
	#guild_cultivate_lv_cfg{
		lv = 87,
		need_point = 1214,
		price_type = 6,
		price = 4800,
		do_phy_dam_scaling = 0.435000,
		do_mag_dam_scaling = 0.435000,
		heal_value = 0,
		seal_hit = 0.870000,
		seal_resis = 0.870000,
		be_phy_dam_reduce_coef = 0.435000,
		be_mag_dam_reduce_coef = 0.435000
};

get(88) ->
	#guild_cultivate_lv_cfg{
		lv = 88,
		need_point = 1228,
		price_type = 6,
		price = 5000,
		do_phy_dam_scaling = 0.440000,
		do_mag_dam_scaling = 0.440000,
		heal_value = 0,
		seal_hit = 0.880000,
		seal_resis = 0.880000,
		be_phy_dam_reduce_coef = 0.440000,
		be_mag_dam_reduce_coef = 0.440000
};

get(89) ->
	#guild_cultivate_lv_cfg{
		lv = 89,
		need_point = 1242,
		price_type = 6,
		price = 5200,
		do_phy_dam_scaling = 0.445000,
		do_mag_dam_scaling = 0.445000,
		heal_value = 0,
		seal_hit = 0.890000,
		seal_resis = 0.890000,
		be_phy_dam_reduce_coef = 0.445000,
		be_mag_dam_reduce_coef = 0.445000
};

get(90) ->
	#guild_cultivate_lv_cfg{
		lv = 90,
		need_point = 1256,
		price_type = 6,
		price = 5400,
		do_phy_dam_scaling = 0.450000,
		do_mag_dam_scaling = 0.450000,
		heal_value = 0,
		seal_hit = 0.900000,
		seal_resis = 0.900000,
		be_phy_dam_reduce_coef = 0.450000,
		be_mag_dam_reduce_coef = 0.450000
};

get(91) ->
	#guild_cultivate_lv_cfg{
		lv = 91,
		need_point = 1270,
		price_type = 6,
		price = 5600,
		do_phy_dam_scaling = 0.455000,
		do_mag_dam_scaling = 0.455000,
		heal_value = 0,
		seal_hit = 0.910000,
		seal_resis = 0.910000,
		be_phy_dam_reduce_coef = 0.455000,
		be_mag_dam_reduce_coef = 0.455000
};

get(92) ->
	#guild_cultivate_lv_cfg{
		lv = 92,
		need_point = 1284,
		price_type = 6,
		price = 5800,
		do_phy_dam_scaling = 0.460000,
		do_mag_dam_scaling = 0.460000,
		heal_value = 0,
		seal_hit = 0.920000,
		seal_resis = 0.920000,
		be_phy_dam_reduce_coef = 0.460000,
		be_mag_dam_reduce_coef = 0.460000
};

get(93) ->
	#guild_cultivate_lv_cfg{
		lv = 93,
		need_point = 1298,
		price_type = 6,
		price = 6000,
		do_phy_dam_scaling = 0.465000,
		do_mag_dam_scaling = 0.465000,
		heal_value = 0,
		seal_hit = 0.930000,
		seal_resis = 0.930000,
		be_phy_dam_reduce_coef = 0.465000,
		be_mag_dam_reduce_coef = 0.465000
};

get(94) ->
	#guild_cultivate_lv_cfg{
		lv = 94,
		need_point = 1312,
		price_type = 6,
		price = 6200,
		do_phy_dam_scaling = 0.470000,
		do_mag_dam_scaling = 0.470000,
		heal_value = 0,
		seal_hit = 0.940000,
		seal_resis = 0.940000,
		be_phy_dam_reduce_coef = 0.470000,
		be_mag_dam_reduce_coef = 0.470000
};

get(95) ->
	#guild_cultivate_lv_cfg{
		lv = 95,
		need_point = 1326,
		price_type = 6,
		price = 6400,
		do_phy_dam_scaling = 0.475000,
		do_mag_dam_scaling = 0.475000,
		heal_value = 0,
		seal_hit = 0.950000,
		seal_resis = 0.950000,
		be_phy_dam_reduce_coef = 0.475000,
		be_mag_dam_reduce_coef = 0.475000
};

get(96) ->
	#guild_cultivate_lv_cfg{
		lv = 96,
		need_point = 1340,
		price_type = 6,
		price = 6600,
		do_phy_dam_scaling = 0.480000,
		do_mag_dam_scaling = 0.480000,
		heal_value = 0,
		seal_hit = 0.960000,
		seal_resis = 0.960000,
		be_phy_dam_reduce_coef = 0.480000,
		be_mag_dam_reduce_coef = 0.480000
};

get(97) ->
	#guild_cultivate_lv_cfg{
		lv = 97,
		need_point = 1354,
		price_type = 6,
		price = 6800,
		do_phy_dam_scaling = 0.485000,
		do_mag_dam_scaling = 0.485000,
		heal_value = 0,
		seal_hit = 0.970000,
		seal_resis = 0.970000,
		be_phy_dam_reduce_coef = 0.485000,
		be_mag_dam_reduce_coef = 0.485000
};

get(98) ->
	#guild_cultivate_lv_cfg{
		lv = 98,
		need_point = 1368,
		price_type = 6,
		price = 7000,
		do_phy_dam_scaling = 0.490000,
		do_mag_dam_scaling = 0.490000,
		heal_value = 0,
		seal_hit = 0.980000,
		seal_resis = 0.980000,
		be_phy_dam_reduce_coef = 0.490000,
		be_mag_dam_reduce_coef = 0.490000
};

get(99) ->
	#guild_cultivate_lv_cfg{
		lv = 99,
		need_point = 1382,
		price_type = 6,
		price = 7200,
		do_phy_dam_scaling = 0.495000,
		do_mag_dam_scaling = 0.495000,
		heal_value = 0,
		seal_hit = 0.990000,
		seal_resis = 0.990000,
		be_phy_dam_reduce_coef = 0.495000,
		be_mag_dam_reduce_coef = 0.495000
};

get(100) ->
	#guild_cultivate_lv_cfg{
		lv = 100,
		need_point = 1396,
		price_type = 6,
		price = 7400,
		do_phy_dam_scaling = 0.500000,
		do_mag_dam_scaling = 0.500000,
		heal_value = 0,
		seal_hit = 1,
		seal_resis = 1,
		be_phy_dam_reduce_coef = 0.500000,
		be_mag_dam_reduce_coef = 0.500000
};

get(101) ->
	#guild_cultivate_lv_cfg{
		lv = 101,
		need_point = 1410,
		price_type = 6,
		price = 7600,
		do_phy_dam_scaling = 0.505000,
		do_mag_dam_scaling = 0.505000,
		heal_value = 0,
		seal_hit = 1.010000,
		seal_resis = 1.010000,
		be_phy_dam_reduce_coef = 0.505000,
		be_mag_dam_reduce_coef = 0.505000
};

get(102) ->
	#guild_cultivate_lv_cfg{
		lv = 102,
		need_point = 1424,
		price_type = 6,
		price = 7800,
		do_phy_dam_scaling = 0.510000,
		do_mag_dam_scaling = 0.510000,
		heal_value = 0,
		seal_hit = 1.020000,
		seal_resis = 1.020000,
		be_phy_dam_reduce_coef = 0.510000,
		be_mag_dam_reduce_coef = 0.510000
};

get(103) ->
	#guild_cultivate_lv_cfg{
		lv = 103,
		need_point = 1438,
		price_type = 6,
		price = 8000,
		do_phy_dam_scaling = 0.515000,
		do_mag_dam_scaling = 0.515000,
		heal_value = 0,
		seal_hit = 1.030000,
		seal_resis = 1.030000,
		be_phy_dam_reduce_coef = 0.515000,
		be_mag_dam_reduce_coef = 0.515000
};

get(104) ->
	#guild_cultivate_lv_cfg{
		lv = 104,
		need_point = 1452,
		price_type = 6,
		price = 8200,
		do_phy_dam_scaling = 0.520000,
		do_mag_dam_scaling = 0.520000,
		heal_value = 0,
		seal_hit = 1.040000,
		seal_resis = 1.040000,
		be_phy_dam_reduce_coef = 0.520000,
		be_mag_dam_reduce_coef = 0.520000
};

get(105) ->
	#guild_cultivate_lv_cfg{
		lv = 105,
		need_point = 1466,
		price_type = 6,
		price = 8400,
		do_phy_dam_scaling = 0.525000,
		do_mag_dam_scaling = 0.525000,
		heal_value = 0,
		seal_hit = 1.050000,
		seal_resis = 1.050000,
		be_phy_dam_reduce_coef = 0.525000,
		be_mag_dam_reduce_coef = 0.525000
};

get(106) ->
	#guild_cultivate_lv_cfg{
		lv = 106,
		need_point = 1480,
		price_type = 6,
		price = 8600,
		do_phy_dam_scaling = 0.530000,
		do_mag_dam_scaling = 0.530000,
		heal_value = 0,
		seal_hit = 1.060000,
		seal_resis = 1.060000,
		be_phy_dam_reduce_coef = 0.530000,
		be_mag_dam_reduce_coef = 0.530000
};

get(107) ->
	#guild_cultivate_lv_cfg{
		lv = 107,
		need_point = 1494,
		price_type = 6,
		price = 8800,
		do_phy_dam_scaling = 0.535000,
		do_mag_dam_scaling = 0.535000,
		heal_value = 0,
		seal_hit = 1.070000,
		seal_resis = 1.070000,
		be_phy_dam_reduce_coef = 0.535000,
		be_mag_dam_reduce_coef = 0.535000
};

get(108) ->
	#guild_cultivate_lv_cfg{
		lv = 108,
		need_point = 1508,
		price_type = 6,
		price = 9000,
		do_phy_dam_scaling = 0.540000,
		do_mag_dam_scaling = 0.540000,
		heal_value = 0,
		seal_hit = 1.080000,
		seal_resis = 1.080000,
		be_phy_dam_reduce_coef = 0.540000,
		be_mag_dam_reduce_coef = 0.540000
};

get(109) ->
	#guild_cultivate_lv_cfg{
		lv = 109,
		need_point = 1522,
		price_type = 6,
		price = 9200,
		do_phy_dam_scaling = 0.545000,
		do_mag_dam_scaling = 0.545000,
		heal_value = 0,
		seal_hit = 1.090000,
		seal_resis = 1.090000,
		be_phy_dam_reduce_coef = 0.545000,
		be_mag_dam_reduce_coef = 0.545000
};

get(110) ->
	#guild_cultivate_lv_cfg{
		lv = 110,
		need_point = 1536,
		price_type = 6,
		price = 9400,
		do_phy_dam_scaling = 0.550000,
		do_mag_dam_scaling = 0.550000,
		heal_value = 0,
		seal_hit = 1.100000,
		seal_resis = 1.100000,
		be_phy_dam_reduce_coef = 0.550000,
		be_mag_dam_reduce_coef = 0.550000
};

get(_Lv) ->
	      ?ASSERT(false, _Lv),
          null.

