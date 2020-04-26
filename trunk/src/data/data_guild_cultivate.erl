%%%---------------------------------------
%%% @Module  : data_guild_cultivate
%%% @Author  : zwq
%%% @Email   : 
%%% @Description:  帮派点修
%%%---------------------------------------


-module(data_guild_cultivate).
-include("common.hrl").
-include("record.hrl").
-include("record/guild_record.hrl").
-compile(export_all).

get(0) ->
	#guild_cultivate_cfg{
		lv = 0,
		need_point_next_lv = 5,
		need_gamemoney = 50000,
		need_contri = 5,
		need_exp = 150000,
		need_contri_2 = 5,
		hp_lim = {2,0},
		act_speed = {1,0},
		seal_hit = {1,0},
		seal_resis = {1,0},
		mp_lim = {2,0},
		crit = {1,0},
		ten = {1,0},
		hit = {1,0},
		dodge = {1,0}
};

get(1) ->
	#guild_cultivate_cfg{
		lv = 1,
		need_point_next_lv = 25,
		need_gamemoney = 50000,
		need_contri = 5,
		need_exp = 150000,
		need_contri_2 = 5,
		hp_lim = {2,0.5},
		act_speed = {1,2},
		seal_hit = {1,18},
		seal_resis = {1,18},
		mp_lim = {2,0.5},
		crit = {1,18},
		ten = {1,18},
		hit = {1,18},
		dodge = {1,18}
};

get(2) ->
	#guild_cultivate_cfg{
		lv = 2,
		need_point_next_lv = 45,
		need_gamemoney = 50000,
		need_contri = 5,
		need_exp = 150000,
		need_contri_2 = 5,
		hp_lim = {2,1},
		act_speed = {1,4},
		seal_hit = {1,36},
		seal_resis = {1,36},
		mp_lim = {2,1},
		crit = {1,36},
		ten = {1,36},
		hit = {1,36},
		dodge = {1,36}
};

get(3) ->
	#guild_cultivate_cfg{
		lv = 3,
		need_point_next_lv = 65,
		need_gamemoney = 50000,
		need_contri = 5,
		need_exp = 150000,
		need_contri_2 = 5,
		hp_lim = {2,1.5},
		act_speed = {1,6},
		seal_hit = {1,54},
		seal_resis = {1,54},
		mp_lim = {2,1.5},
		crit = {1,54},
		ten = {1,54},
		hit = {1,54},
		dodge = {1,54}
};

get(4) ->
	#guild_cultivate_cfg{
		lv = 4,
		need_point_next_lv = 85,
		need_gamemoney = 50000,
		need_contri = 5,
		need_exp = 150000,
		need_contri_2 = 5,
		hp_lim = {2,2},
		act_speed = {1,8},
		seal_hit = {1,72},
		seal_resis = {1,72},
		mp_lim = {2,2},
		crit = {1,72},
		ten = {1,72},
		hit = {1,72},
		dodge = {1,72}
};

get(5) ->
	#guild_cultivate_cfg{
		lv = 5,
		need_point_next_lv = 105,
		need_gamemoney = 50000,
		need_contri = 5,
		need_exp = 150000,
		need_contri_2 = 5,
		hp_lim = {2,2.6},
		act_speed = {1,10},
		seal_hit = {1,90},
		seal_resis = {1,90},
		mp_lim = {2,2.6},
		crit = {1,90},
		ten = {1,90},
		hit = {1,90},
		dodge = {1,90}
};

get(6) ->
	#guild_cultivate_cfg{
		lv = 6,
		need_point_next_lv = 125,
		need_gamemoney = 50000,
		need_contri = 5,
		need_exp = 150000,
		need_contri_2 = 5,
		hp_lim = {2,3.1},
		act_speed = {1,13},
		seal_hit = {1,117},
		seal_resis = {1,117},
		mp_lim = {2,3.1},
		crit = {1,117},
		ten = {1,117},
		hit = {1,117},
		dodge = {1,117}
};

get(7) ->
	#guild_cultivate_cfg{
		lv = 7,
		need_point_next_lv = 145,
		need_gamemoney = 50000,
		need_contri = 5,
		need_exp = 150000,
		need_contri_2 = 5,
		hp_lim = {2,3.7},
		act_speed = {1,16},
		seal_hit = {1,144},
		seal_resis = {1,144},
		mp_lim = {2,3.7},
		crit = {1,144},
		ten = {1,144},
		hit = {1,144},
		dodge = {1,144}
};

get(8) ->
	#guild_cultivate_cfg{
		lv = 8,
		need_point_next_lv = 165,
		need_gamemoney = 50000,
		need_contri = 5,
		need_exp = 150000,
		need_contri_2 = 5,
		hp_lim = {2,4.3},
		act_speed = {1,19},
		seal_hit = {1,171},
		seal_resis = {1,171},
		mp_lim = {2,4.3},
		crit = {1,171},
		ten = {1,171},
		hit = {1,171},
		dodge = {1,171}
};

get(9) ->
	#guild_cultivate_cfg{
		lv = 9,
		need_point_next_lv = 185,
		need_gamemoney = 50000,
		need_contri = 5,
		need_exp = 150000,
		need_contri_2 = 5,
		hp_lim = {2,4.9},
		act_speed = {1,22},
		seal_hit = {1,198},
		seal_resis = {1,198},
		mp_lim = {2,4.9},
		crit = {1,198},
		ten = {1,198},
		hit = {1,198},
		dodge = {1,198}
};

get(10) ->
	#guild_cultivate_cfg{
		lv = 10,
		need_point_next_lv = 205,
		need_gamemoney = 50000,
		need_contri = 5,
		need_exp = 150000,
		need_contri_2 = 5,
		hp_lim = {2,5.5},
		act_speed = {1,25},
		seal_hit = {1,225},
		seal_resis = {1,225},
		mp_lim = {2,5.5},
		crit = {1,225},
		ten = {1,225},
		hit = {1,225},
		dodge = {1,225}
};

get(11) ->
	#guild_cultivate_cfg{
		lv = 11,
		need_point_next_lv = 225,
		need_gamemoney = 55000,
		need_contri = 5,
		need_exp = 160000,
		need_contri_2 = 5,
		hp_lim = {2,6.1},
		act_speed = {1,28},
		seal_hit = {1,252},
		seal_resis = {1,252},
		mp_lim = {2,6.1},
		crit = {1,252},
		ten = {1,252},
		hit = {1,252},
		dodge = {1,252}
};

get(12) ->
	#guild_cultivate_cfg{
		lv = 12,
		need_point_next_lv = 245,
		need_gamemoney = 60000,
		need_contri = 5,
		need_exp = 170000,
		need_contri_2 = 5,
		hp_lim = {2,6.7},
		act_speed = {1,31},
		seal_hit = {1,279},
		seal_resis = {1,279},
		mp_lim = {2,6.7},
		crit = {1,279},
		ten = {1,279},
		hit = {1,279},
		dodge = {1,279}
};

get(13) ->
	#guild_cultivate_cfg{
		lv = 13,
		need_point_next_lv = 265,
		need_gamemoney = 65000,
		need_contri = 5,
		need_exp = 180000,
		need_contri_2 = 5,
		hp_lim = {2,7.3},
		act_speed = {1,34},
		seal_hit = {1,306},
		seal_resis = {1,306},
		mp_lim = {2,7.3},
		crit = {1,306},
		ten = {1,306},
		hit = {1,306},
		dodge = {1,306}
};

get(14) ->
	#guild_cultivate_cfg{
		lv = 14,
		need_point_next_lv = 285,
		need_gamemoney = 70000,
		need_contri = 5,
		need_exp = 190000,
		need_contri_2 = 5,
		hp_lim = {2,7.9},
		act_speed = {1,38},
		seal_hit = {1,342},
		seal_resis = {1,342},
		mp_lim = {2,7.9},
		crit = {1,342},
		ten = {1,342},
		hit = {1,342},
		dodge = {1,342}
};

get(15) ->
	#guild_cultivate_cfg{
		lv = 15,
		need_point_next_lv = 305,
		need_gamemoney = 75000,
		need_contri = 5,
		need_exp = 200000,
		need_contri_2 = 5,
		hp_lim = {2,8.6},
		act_speed = {1,42},
		seal_hit = {1,378},
		seal_resis = {1,378},
		mp_lim = {2,8.6},
		crit = {1,378},
		ten = {1,378},
		hit = {1,378},
		dodge = {1,378}
};

get(16) ->
	#guild_cultivate_cfg{
		lv = 16,
		need_point_next_lv = 325,
		need_gamemoney = 80000,
		need_contri = 5,
		need_exp = 210000,
		need_contri_2 = 5,
		hp_lim = {2,9.2},
		act_speed = {1,46},
		seal_hit = {1,414},
		seal_resis = {1,414},
		mp_lim = {2,9.2},
		crit = {1,414},
		ten = {1,414},
		hit = {1,414},
		dodge = {1,414}
};

get(17) ->
	#guild_cultivate_cfg{
		lv = 17,
		need_point_next_lv = 345,
		need_gamemoney = 85000,
		need_contri = 5,
		need_exp = 220000,
		need_contri_2 = 5,
		hp_lim = {2,9.9},
		act_speed = {1,48},
		seal_hit = {1,432},
		seal_resis = {1,432},
		mp_lim = {2,9.9},
		crit = {1,432},
		ten = {1,432},
		hit = {1,432},
		dodge = {1,432}
};

get(18) ->
	#guild_cultivate_cfg{
		lv = 18,
		need_point_next_lv = 365,
		need_gamemoney = 90000,
		need_contri = 5,
		need_exp = 230000,
		need_contri_2 = 5,
		hp_lim = {2,10.6},
		act_speed = {1,52},
		seal_hit = {1,468},
		seal_resis = {1,468},
		mp_lim = {2,10.6},
		crit = {1,468},
		ten = {1,468},
		hit = {1,468},
		dodge = {1,468}
};

get(19) ->
	#guild_cultivate_cfg{
		lv = 19,
		need_point_next_lv = 385,
		need_gamemoney = 95000,
		need_contri = 5,
		need_exp = 240000,
		need_contri_2 = 5,
		hp_lim = {2,11.3},
		act_speed = {1,56},
		seal_hit = {1,504},
		seal_resis = {1,504},
		mp_lim = {2,11.3},
		crit = {1,504},
		ten = {1,504},
		hit = {1,504},
		dodge = {1,504}
};

get(20) ->
	#guild_cultivate_cfg{
		lv = 20,
		need_point_next_lv = 405,
		need_gamemoney = 100000,
		need_contri = 5,
		need_exp = 250000,
		need_contri_2 = 5,
		hp_lim = {2,12},
		act_speed = {1,60},
		seal_hit = {1,540},
		seal_resis = {1,540},
		mp_lim = {2,12},
		crit = {1,540},
		ten = {1,540},
		hit = {1,540},
		dodge = {1,540}
};

get(21) ->
	#guild_cultivate_cfg{
		lv = 21,
		need_point_next_lv = 425,
		need_gamemoney = 105000,
		need_contri = 5,
		need_exp = 260000,
		need_contri_2 = 5,
		hp_lim = {2,12.7},
		act_speed = {1,65},
		seal_hit = {1,585},
		seal_resis = {1,585},
		mp_lim = {2,12.7},
		crit = {1,585},
		ten = {1,585},
		hit = {1,585},
		dodge = {1,585}
};

get(22) ->
	#guild_cultivate_cfg{
		lv = 22,
		need_point_next_lv = 445,
		need_gamemoney = 110000,
		need_contri = 5,
		need_exp = 270000,
		need_contri_2 = 5,
		hp_lim = {2,13.4},
		act_speed = {1,70},
		seal_hit = {1,630},
		seal_resis = {1,630},
		mp_lim = {2,13.4},
		crit = {1,630},
		ten = {1,630},
		hit = {1,630},
		dodge = {1,630}
};

get(23) ->
	#guild_cultivate_cfg{
		lv = 23,
		need_point_next_lv = 465,
		need_gamemoney = 115000,
		need_contri = 5,
		need_exp = 280000,
		need_contri_2 = 5,
		hp_lim = {2,14.1},
		act_speed = {1,75},
		seal_hit = {1,675},
		seal_resis = {1,675},
		mp_lim = {2,14.1},
		crit = {1,675},
		ten = {1,675},
		hit = {1,675},
		dodge = {1,675}
};

get(24) ->
	#guild_cultivate_cfg{
		lv = 24,
		need_point_next_lv = 485,
		need_gamemoney = 120000,
		need_contri = 5,
		need_exp = 290000,
		need_contri_2 = 5,
		hp_lim = {2,14.8},
		act_speed = {1,80},
		seal_hit = {1,720},
		seal_resis = {1,720},
		mp_lim = {2,14.8},
		crit = {1,720},
		ten = {1,720},
		hit = {1,720},
		dodge = {1,720}
};

get(25) ->
	#guild_cultivate_cfg{
		lv = 25,
		need_point_next_lv = 505,
		need_gamemoney = 125000,
		need_contri = 5,
		need_exp = 300000,
		need_contri_2 = 5,
		hp_lim = {2,15.6},
		act_speed = {1,85},
		seal_hit = {1,765},
		seal_resis = {1,765},
		mp_lim = {2,15.6},
		crit = {1,765},
		ten = {1,765},
		hit = {1,765},
		dodge = {1,765}
};

get(26) ->
	#guild_cultivate_cfg{
		lv = 26,
		need_point_next_lv = 525,
		need_gamemoney = 130000,
		need_contri = 5,
		need_exp = 310000,
		need_contri_2 = 5,
		hp_lim = {2,16.3},
		act_speed = {1,90},
		seal_hit = {1,810},
		seal_resis = {1,810},
		mp_lim = {2,16.3},
		crit = {1,810},
		ten = {1,810},
		hit = {1,810},
		dodge = {1,810}
};

get(27) ->
	#guild_cultivate_cfg{
		lv = 27,
		need_point_next_lv = 545,
		need_gamemoney = 135000,
		need_contri = 5,
		need_exp = 320000,
		need_contri_2 = 5,
		hp_lim = {2,17.1},
		act_speed = {1,95},
		seal_hit = {1,855},
		seal_resis = {1,855},
		mp_lim = {2,17.1},
		crit = {1,855},
		ten = {1,855},
		hit = {1,855},
		dodge = {1,855}
};

get(28) ->
	#guild_cultivate_cfg{
		lv = 28,
		need_point_next_lv = 565,
		need_gamemoney = 140000,
		need_contri = 5,
		need_exp = 330000,
		need_contri_2 = 5,
		hp_lim = {2,17.9},
		act_speed = {1,100},
		seal_hit = {1,900},
		seal_resis = {1,900},
		mp_lim = {2,17.9},
		crit = {1,900},
		ten = {1,900},
		hit = {1,900},
		dodge = {1,900}
};

get(29) ->
	#guild_cultivate_cfg{
		lv = 29,
		need_point_next_lv = 585,
		need_gamemoney = 145000,
		need_contri = 5,
		need_exp = 340000,
		need_contri_2 = 5,
		hp_lim = {2,18.7},
		act_speed = {1,105},
		seal_hit = {1,945},
		seal_resis = {1,945},
		mp_lim = {2,18.7},
		crit = {1,945},
		ten = {1,945},
		hit = {1,945},
		dodge = {1,945}
};

get(30) ->
	#guild_cultivate_cfg{
		lv = 30,
		need_point_next_lv = 605,
		need_gamemoney = 150000,
		need_contri = 5,
		need_exp = 350000,
		need_contri_2 = 5,
		hp_lim = {2,19.5},
		act_speed = {1,110},
		seal_hit = {1,990},
		seal_resis = {1,990},
		mp_lim = {2,19.5},
		crit = {1,990},
		ten = {1,990},
		hit = {1,990},
		dodge = {1,990}
};

get(31) ->
	#guild_cultivate_cfg{
		lv = 31,
		need_point_next_lv = 625,
		need_gamemoney = 155000,
		need_contri = 5,
		need_exp = 360000,
		need_contri_2 = 5,
		hp_lim = {2,20.3},
		act_speed = {1,115},
		seal_hit = {1,1035},
		seal_resis = {1,1035},
		mp_lim = {2,20.3},
		crit = {1,1035},
		ten = {1,1035},
		hit = {1,1035},
		dodge = {1,1035}
};

get(32) ->
	#guild_cultivate_cfg{
		lv = 32,
		need_point_next_lv = 645,
		need_gamemoney = 160000,
		need_contri = 5,
		need_exp = 370000,
		need_contri_2 = 5,
		hp_lim = {2,21.1},
		act_speed = {1,120},
		seal_hit = {1,1080},
		seal_resis = {1,1080},
		mp_lim = {2,21.1},
		crit = {1,1080},
		ten = {1,1080},
		hit = {1,1080},
		dodge = {1,1080}
};

get(33) ->
	#guild_cultivate_cfg{
		lv = 33,
		need_point_next_lv = 665,
		need_gamemoney = 165000,
		need_contri = 5,
		need_exp = 380000,
		need_contri_2 = 5,
		hp_lim = {2,21.9},
		act_speed = {1,125},
		seal_hit = {1,1125},
		seal_resis = {1,1125},
		mp_lim = {2,21.9},
		crit = {1,1125},
		ten = {1,1125},
		hit = {1,1125},
		dodge = {1,1125}
};

get(34) ->
	#guild_cultivate_cfg{
		lv = 34,
		need_point_next_lv = 685,
		need_gamemoney = 170000,
		need_contri = 5,
		need_exp = 390000,
		need_contri_2 = 5,
		hp_lim = {2,22.7},
		act_speed = {1,131},
		seal_hit = {1,1179},
		seal_resis = {1,1179},
		mp_lim = {2,22.7},
		crit = {1,1179},
		ten = {1,1179},
		hit = {1,1179},
		dodge = {1,1179}
};

get(35) ->
	#guild_cultivate_cfg{
		lv = 35,
		need_point_next_lv = 705,
		need_gamemoney = 175000,
		need_contri = 5,
		need_exp = 400000,
		need_contri_2 = 5,
		hp_lim = {2,23.6},
		act_speed = {1,137},
		seal_hit = {1,1233},
		seal_resis = {1,1233},
		mp_lim = {2,23.6},
		crit = {1,1233},
		ten = {1,1233},
		hit = {1,1233},
		dodge = {1,1233}
};

get(36) ->
	#guild_cultivate_cfg{
		lv = 36,
		need_point_next_lv = 725,
		need_gamemoney = 180000,
		need_contri = 5,
		need_exp = 410000,
		need_contri_2 = 5,
		hp_lim = {2,24.4},
		act_speed = {1,143},
		seal_hit = {1,1287},
		seal_resis = {1,1287},
		mp_lim = {2,24.4},
		crit = {1,1287},
		ten = {1,1287},
		hit = {1,1287},
		dodge = {1,1287}
};

get(37) ->
	#guild_cultivate_cfg{
		lv = 37,
		need_point_next_lv = 745,
		need_gamemoney = 185000,
		need_contri = 5,
		need_exp = 420000,
		need_contri_2 = 5,
		hp_lim = {2,25.3},
		act_speed = {1,149},
		seal_hit = {1,1341},
		seal_resis = {1,1341},
		mp_lim = {2,25.3},
		crit = {1,1341},
		ten = {1,1341},
		hit = {1,1341},
		dodge = {1,1341}
};

get(38) ->
	#guild_cultivate_cfg{
		lv = 38,
		need_point_next_lv = 765,
		need_gamemoney = 190000,
		need_contri = 5,
		need_exp = 430000,
		need_contri_2 = 5,
		hp_lim = {2,26.2},
		act_speed = {1,155},
		seal_hit = {1,1395},
		seal_resis = {1,1395},
		mp_lim = {2,26.2},
		crit = {1,1395},
		ten = {1,1395},
		hit = {1,1395},
		dodge = {1,1395}
};

get(39) ->
	#guild_cultivate_cfg{
		lv = 39,
		need_point_next_lv = 785,
		need_gamemoney = 195000,
		need_contri = 5,
		need_exp = 440000,
		need_contri_2 = 5,
		hp_lim = {2,27.1},
		act_speed = {1,160},
		seal_hit = {1,1440},
		seal_resis = {1,1440},
		mp_lim = {2,27.1},
		crit = {1,1440},
		ten = {1,1440},
		hit = {1,1440},
		dodge = {1,1440}
};

get(40) ->
	#guild_cultivate_cfg{
		lv = 40,
		need_point_next_lv = 805,
		need_gamemoney = 200000,
		need_contri = 5,
		need_exp = 450000,
		need_contri_2 = 5,
		hp_lim = {2,28},
		act_speed = {1,166},
		seal_hit = {1,1494},
		seal_resis = {1,1494},
		mp_lim = {2,28},
		crit = {1,1494},
		ten = {1,1494},
		hit = {1,1494},
		dodge = {1,1494}
};

get(41) ->
	#guild_cultivate_cfg{
		lv = 41,
		need_point_next_lv = 825,
		need_gamemoney = 205000,
		need_contri = 5,
		need_exp = 460000,
		need_contri_2 = 5,
		hp_lim = {2,28.9},
		act_speed = {1,172},
		seal_hit = {1,1548},
		seal_resis = {1,1548},
		mp_lim = {2,28.9},
		crit = {1,1548},
		ten = {1,1548},
		hit = {1,1548},
		dodge = {1,1548}
};

get(42) ->
	#guild_cultivate_cfg{
		lv = 42,
		need_point_next_lv = 845,
		need_gamemoney = 210000,
		need_contri = 5,
		need_exp = 470000,
		need_contri_2 = 5,
		hp_lim = {2,29.8},
		act_speed = {1,178},
		seal_hit = {1,1602},
		seal_resis = {1,1602},
		mp_lim = {2,29.8},
		crit = {1,1602},
		ten = {1,1602},
		hit = {1,1602},
		dodge = {1,1602}
};

get(43) ->
	#guild_cultivate_cfg{
		lv = 43,
		need_point_next_lv = 865,
		need_gamemoney = 215000,
		need_contri = 5,
		need_exp = 480000,
		need_contri_2 = 5,
		hp_lim = {2,30.7},
		act_speed = {1,184},
		seal_hit = {1,1656},
		seal_resis = {1,1656},
		mp_lim = {2,30.7},
		crit = {1,1656},
		ten = {1,1656},
		hit = {1,1656},
		dodge = {1,1656}
};

get(44) ->
	#guild_cultivate_cfg{
		lv = 44,
		need_point_next_lv = 885,
		need_gamemoney = 220000,
		need_contri = 5,
		need_exp = 490000,
		need_contri_2 = 5,
		hp_lim = {2,31.6},
		act_speed = {1,190},
		seal_hit = {1,1710},
		seal_resis = {1,1710},
		mp_lim = {2,31.6},
		crit = {1,1710},
		ten = {1,1710},
		hit = {1,1710},
		dodge = {1,1710}
};

get(45) ->
	#guild_cultivate_cfg{
		lv = 45,
		need_point_next_lv = 905,
		need_gamemoney = 225000,
		need_contri = 5,
		need_exp = 500000,
		need_contri_2 = 5,
		hp_lim = {2,32.6},
		act_speed = {1,196},
		seal_hit = {1,1764},
		seal_resis = {1,1764},
		mp_lim = {2,32.6},
		crit = {1,1764},
		ten = {1,1764},
		hit = {1,1764},
		dodge = {1,1764}
};

get(46) ->
	#guild_cultivate_cfg{
		lv = 46,
		need_point_next_lv = 925,
		need_gamemoney = 230000,
		need_contri = 5,
		need_exp = 510000,
		need_contri_2 = 5,
		hp_lim = {2,33.5},
		act_speed = {1,202},
		seal_hit = {1,1818},
		seal_resis = {1,1818},
		mp_lim = {2,33.5},
		crit = {1,1818},
		ten = {1,1818},
		hit = {1,1818},
		dodge = {1,1818}
};

get(47) ->
	#guild_cultivate_cfg{
		lv = 47,
		need_point_next_lv = 945,
		need_gamemoney = 235000,
		need_contri = 5,
		need_exp = 520000,
		need_contri_2 = 5,
		hp_lim = {2,34.5},
		act_speed = {1,208},
		seal_hit = {1,1872},
		seal_resis = {1,1872},
		mp_lim = {2,34.5},
		crit = {1,1872},
		ten = {1,1872},
		hit = {1,1872},
		dodge = {1,1872}
};

get(48) ->
	#guild_cultivate_cfg{
		lv = 48,
		need_point_next_lv = 965,
		need_gamemoney = 240000,
		need_contri = 5,
		need_exp = 530000,
		need_contri_2 = 5,
		hp_lim = {2,35.5},
		act_speed = {1,214},
		seal_hit = {1,1926},
		seal_resis = {1,1926},
		mp_lim = {2,35.5},
		crit = {1,1926},
		ten = {1,1926},
		hit = {1,1926},
		dodge = {1,1926}
};

get(49) ->
	#guild_cultivate_cfg{
		lv = 49,
		need_point_next_lv = 985,
		need_gamemoney = 245000,
		need_contri = 5,
		need_exp = 540000,
		need_contri_2 = 5,
		hp_lim = {2,36.5},
		act_speed = {1,220},
		seal_hit = {1,1980},
		seal_resis = {1,1980},
		mp_lim = {2,36.5},
		crit = {1,1980},
		ten = {1,1980},
		hit = {1,1980},
		dodge = {1,1980}
};

get(50) ->
	#guild_cultivate_cfg{
		lv = 50,
		need_point_next_lv = 1005,
		need_gamemoney = 250000,
		need_contri = 5,
		need_exp = 550000,
		need_contri_2 = 5,
		hp_lim = {2,37.5},
		act_speed = {1,226},
		seal_hit = {1,2034},
		seal_resis = {1,2034},
		mp_lim = {2,37.5},
		crit = {1,2034},
		ten = {1,2034},
		hit = {1,2034},
		dodge = {1,2034}
};

get(51) ->
	#guild_cultivate_cfg{
		lv = 51,
		need_point_next_lv = 1025,
		need_gamemoney = 255000,
		need_contri = 5,
		need_exp = 560000,
		need_contri_2 = 5,
		hp_lim = {2,38.5},
		act_speed = {1,232},
		seal_hit = {1,2088},
		seal_resis = {1,2088},
		mp_lim = {2,38.5},
		crit = {1,2088},
		ten = {1,2088},
		hit = {1,2088},
		dodge = {1,2088}
};

get(52) ->
	#guild_cultivate_cfg{
		lv = 52,
		need_point_next_lv = 1045,
		need_gamemoney = 260000,
		need_contri = 5,
		need_exp = 570000,
		need_contri_2 = 5,
		hp_lim = {2,39.5},
		act_speed = {1,238},
		seal_hit = {1,2142},
		seal_resis = {1,2142},
		mp_lim = {2,39.5},
		crit = {1,2142},
		ten = {1,2142},
		hit = {1,2142},
		dodge = {1,2142}
};

get(53) ->
	#guild_cultivate_cfg{
		lv = 53,
		need_point_next_lv = 1065,
		need_gamemoney = 265000,
		need_contri = 5,
		need_exp = 580000,
		need_contri_2 = 5,
		hp_lim = {2,40.5},
		act_speed = {1,244},
		seal_hit = {1,2196},
		seal_resis = {1,2196},
		mp_lim = {2,40.5},
		crit = {1,2196},
		ten = {1,2196},
		hit = {1,2196},
		dodge = {1,2196}
};

get(54) ->
	#guild_cultivate_cfg{
		lv = 54,
		need_point_next_lv = 1085,
		need_gamemoney = 270000,
		need_contri = 5,
		need_exp = 590000,
		need_contri_2 = 5,
		hp_lim = {2,41.5},
		act_speed = {1,250},
		seal_hit = {1,2250},
		seal_resis = {1,2250},
		mp_lim = {2,41.5},
		crit = {1,2250},
		ten = {1,2250},
		hit = {1,2250},
		dodge = {1,2250}
};

get(55) ->
	#guild_cultivate_cfg{
		lv = 55,
		need_point_next_lv = 1105,
		need_gamemoney = 275000,
		need_contri = 5,
		need_exp = 600000,
		need_contri_2 = 5,
		hp_lim = {2,42.6},
		act_speed = {1,256},
		seal_hit = {1,2304},
		seal_resis = {1,2304},
		mp_lim = {2,42.6},
		crit = {1,2304},
		ten = {1,2304},
		hit = {1,2304},
		dodge = {1,2304}
};

get(56) ->
	#guild_cultivate_cfg{
		lv = 56,
		need_point_next_lv = 1125,
		need_gamemoney = 280000,
		need_contri = 5,
		need_exp = 610000,
		need_contri_2 = 5,
		hp_lim = {2,43.6},
		act_speed = {1,263},
		seal_hit = {1,2367},
		seal_resis = {1,2367},
		mp_lim = {2,43.6},
		crit = {1,2367},
		ten = {1,2367},
		hit = {1,2367},
		dodge = {1,2367}
};

get(57) ->
	#guild_cultivate_cfg{
		lv = 57,
		need_point_next_lv = 1145,
		need_gamemoney = 285000,
		need_contri = 5,
		need_exp = 620000,
		need_contri_2 = 5,
		hp_lim = {2,44.7},
		act_speed = {1,270},
		seal_hit = {1,2430},
		seal_resis = {1,2430},
		mp_lim = {2,44.7},
		crit = {1,2430},
		ten = {1,2430},
		hit = {1,2430},
		dodge = {1,2430}
};

get(58) ->
	#guild_cultivate_cfg{
		lv = 58,
		need_point_next_lv = 1165,
		need_gamemoney = 290000,
		need_contri = 5,
		need_exp = 630000,
		need_contri_2 = 5,
		hp_lim = {2,45.8},
		act_speed = {1,277},
		seal_hit = {1,2493},
		seal_resis = {1,2493},
		mp_lim = {2,45.8},
		crit = {1,2493},
		ten = {1,2493},
		hit = {1,2493},
		dodge = {1,2493}
};

get(59) ->
	#guild_cultivate_cfg{
		lv = 59,
		need_point_next_lv = 1185,
		need_gamemoney = 295000,
		need_contri = 5,
		need_exp = 640000,
		need_contri_2 = 5,
		hp_lim = {2,46.9},
		act_speed = {1,284},
		seal_hit = {1,2556},
		seal_resis = {1,2556},
		mp_lim = {2,46.9},
		crit = {1,2556},
		ten = {1,2556},
		hit = {1,2556},
		dodge = {1,2556}
};

get(60) ->
	#guild_cultivate_cfg{
		lv = 60,
		need_point_next_lv = 1205,
		need_gamemoney = 300000,
		need_contri = 5,
		need_exp = 650000,
		need_contri_2 = 5,
		hp_lim = {2,48},
		act_speed = {1,291},
		seal_hit = {1,2619},
		seal_resis = {1,2619},
		mp_lim = {2,48},
		crit = {1,2619},
		ten = {1,2619},
		hit = {1,2619},
		dodge = {1,2619}
};

get(61) ->
	#guild_cultivate_cfg{
		lv = 61,
		need_point_next_lv = 1225,
		need_gamemoney = 305000,
		need_contri = 5,
		need_exp = 660000,
		need_contri_2 = 5,
		hp_lim = {2,49.1},
		act_speed = {1,298},
		seal_hit = {1,2682},
		seal_resis = {1,2682},
		mp_lim = {2,49.1},
		crit = {1,2682},
		ten = {1,2682},
		hit = {1,2682},
		dodge = {1,2682}
};

get(62) ->
	#guild_cultivate_cfg{
		lv = 62,
		need_point_next_lv = 1245,
		need_gamemoney = 310000,
		need_contri = 5,
		need_exp = 670000,
		need_contri_2 = 5,
		hp_lim = {2,50.2},
		act_speed = {1,305},
		seal_hit = {1,2745},
		seal_resis = {1,2745},
		mp_lim = {2,50.2},
		crit = {1,2745},
		ten = {1,2745},
		hit = {1,2745},
		dodge = {1,2745}
};

get(63) ->
	#guild_cultivate_cfg{
		lv = 63,
		need_point_next_lv = 1265,
		need_gamemoney = 315000,
		need_contri = 5,
		need_exp = 680000,
		need_contri_2 = 5,
		hp_lim = {2,51.3},
		act_speed = {1,312},
		seal_hit = {1,2808},
		seal_resis = {1,2808},
		mp_lim = {2,51.3},
		crit = {1,2808},
		ten = {1,2808},
		hit = {1,2808},
		dodge = {1,2808}
};

get(64) ->
	#guild_cultivate_cfg{
		lv = 64,
		need_point_next_lv = 1285,
		need_gamemoney = 320000,
		need_contri = 5,
		need_exp = 690000,
		need_contri_2 = 5,
		hp_lim = {2,52.4},
		act_speed = {1,320},
		seal_hit = {1,2880},
		seal_resis = {1,2880},
		mp_lim = {2,52.4},
		crit = {1,2880},
		ten = {1,2880},
		hit = {1,2880},
		dodge = {1,2880}
};

get(65) ->
	#guild_cultivate_cfg{
		lv = 65,
		need_point_next_lv = 1305,
		need_gamemoney = 325000,
		need_contri = 5,
		need_exp = 700000,
		need_contri_2 = 5,
		hp_lim = {2,53.6},
		act_speed = {1,328},
		seal_hit = {1,2952},
		seal_resis = {1,2952},
		mp_lim = {2,53.6},
		crit = {1,2952},
		ten = {1,2952},
		hit = {1,2952},
		dodge = {1,2952}
};

get(66) ->
	#guild_cultivate_cfg{
		lv = 66,
		need_point_next_lv = 1325,
		need_gamemoney = 330000,
		need_contri = 5,
		need_exp = 710000,
		need_contri_2 = 5,
		hp_lim = {2,54.7},
		act_speed = {1,336},
		seal_hit = {1,3024},
		seal_resis = {1,3024},
		mp_lim = {2,54.7},
		crit = {1,3024},
		ten = {1,3024},
		hit = {1,3024},
		dodge = {1,3024}
};

get(67) ->
	#guild_cultivate_cfg{
		lv = 67,
		need_point_next_lv = 1345,
		need_gamemoney = 335000,
		need_contri = 5,
		need_exp = 720000,
		need_contri_2 = 5,
		hp_lim = {2,55.9},
		act_speed = {1,344},
		seal_hit = {1,3096},
		seal_resis = {1,3096},
		mp_lim = {2,55.9},
		crit = {1,3096},
		ten = {1,3096},
		hit = {1,3096},
		dodge = {1,3096}
};

get(68) ->
	#guild_cultivate_cfg{
		lv = 68,
		need_point_next_lv = 1365,
		need_gamemoney = 340000,
		need_contri = 5,
		need_exp = 730000,
		need_contri_2 = 5,
		hp_lim = {2,57.1},
		act_speed = {1,352},
		seal_hit = {1,3168},
		seal_resis = {1,3168},
		mp_lim = {2,57.1},
		crit = {1,3168},
		ten = {1,3168},
		hit = {1,3168},
		dodge = {1,3168}
};

get(69) ->
	#guild_cultivate_cfg{
		lv = 69,
		need_point_next_lv = 1385,
		need_gamemoney = 345000,
		need_contri = 5,
		need_exp = 740000,
		need_contri_2 = 5,
		hp_lim = {2,58.3},
		act_speed = {1,360},
		seal_hit = {1,3240},
		seal_resis = {1,3240},
		mp_lim = {2,58.3},
		crit = {1,3240},
		ten = {1,3240},
		hit = {1,3240},
		dodge = {1,3240}
};

get(70) ->
	#guild_cultivate_cfg{
		lv = 70,
		need_point_next_lv = 1405,
		need_gamemoney = 350000,
		need_contri = 5,
		need_exp = 750000,
		need_contri_2 = 5,
		hp_lim = {2,59.5},
		act_speed = {1,368},
		seal_hit = {1,3312},
		seal_resis = {1,3312},
		mp_lim = {2,59.5},
		crit = {1,3312},
		ten = {1,3312},
		hit = {1,3312},
		dodge = {1,3312}
};

get(71) ->
	#guild_cultivate_cfg{
		lv = 71,
		need_point_next_lv = 1425,
		need_gamemoney = 355000,
		need_contri = 5,
		need_exp = 750000,
		need_contri_2 = 5,
		hp_lim = {2,60.7},
		act_speed = {1,376},
		seal_hit = {1,3384},
		seal_resis = {1,3384},
		mp_lim = {2,60.7},
		crit = {1,3384},
		ten = {1,3384},
		hit = {1,3384},
		dodge = {1,3384}
};

get(72) ->
	#guild_cultivate_cfg{
		lv = 72,
		need_point_next_lv = 1445,
		need_gamemoney = 360000,
		need_contri = 5,
		need_exp = 750000,
		need_contri_2 = 5,
		hp_lim = {2,61.9},
		act_speed = {1,384},
		seal_hit = {1,3456},
		seal_resis = {1,3456},
		mp_lim = {2,61.9},
		crit = {1,3456},
		ten = {1,3456},
		hit = {1,3456},
		dodge = {1,3456}
};

get(73) ->
	#guild_cultivate_cfg{
		lv = 73,
		need_point_next_lv = 1465,
		need_gamemoney = 365000,
		need_contri = 5,
		need_exp = 750000,
		need_contri_2 = 5,
		hp_lim = {2,63.1},
		act_speed = {1,392},
		seal_hit = {1,3528},
		seal_resis = {1,3528},
		mp_lim = {2,63.1},
		crit = {1,3528},
		ten = {1,3528},
		hit = {1,3528},
		dodge = {1,3528}
};

get(74) ->
	#guild_cultivate_cfg{
		lv = 74,
		need_point_next_lv = 1485,
		need_gamemoney = 370000,
		need_contri = 5,
		need_exp = 750000,
		need_contri_2 = 5,
		hp_lim = {2,64.3},
		act_speed = {1,400},
		seal_hit = {1,3600},
		seal_resis = {1,3600},
		mp_lim = {2,64.3},
		crit = {1,3600},
		ten = {1,3600},
		hit = {1,3600},
		dodge = {1,3600}
};

get(75) ->
	#guild_cultivate_cfg{
		lv = 75,
		need_point_next_lv = 1505,
		need_gamemoney = 375000,
		need_contri = 5,
		need_exp = 750000,
		need_contri_2 = 5,
		hp_lim = {2,65.6},
		act_speed = {1,408},
		seal_hit = {1,3672},
		seal_resis = {1,3672},
		mp_lim = {2,65.6},
		crit = {1,3672},
		ten = {1,3672},
		hit = {1,3672},
		dodge = {1,3672}
};

get(76) ->
	#guild_cultivate_cfg{
		lv = 76,
		need_point_next_lv = 1525,
		need_gamemoney = 380000,
		need_contri = 5,
		need_exp = 750000,
		need_contri_2 = 5,
		hp_lim = {2,66.8},
		act_speed = {1,417},
		seal_hit = {1,3753},
		seal_resis = {1,3753},
		mp_lim = {2,66.8},
		crit = {1,3753},
		ten = {1,3753},
		hit = {1,3753},
		dodge = {1,3753}
};

get(77) ->
	#guild_cultivate_cfg{
		lv = 77,
		need_point_next_lv = 1545,
		need_gamemoney = 385000,
		need_contri = 5,
		need_exp = 750000,
		need_contri_2 = 5,
		hp_lim = {2,68.1},
		act_speed = {1,426},
		seal_hit = {1,3834},
		seal_resis = {1,3834},
		mp_lim = {2,68.1},
		crit = {1,3834},
		ten = {1,3834},
		hit = {1,3834},
		dodge = {1,3834}
};

get(78) ->
	#guild_cultivate_cfg{
		lv = 78,
		need_point_next_lv = 1565,
		need_gamemoney = 390000,
		need_contri = 5,
		need_exp = 750000,
		need_contri_2 = 5,
		hp_lim = {2,69.4},
		act_speed = {1,435},
		seal_hit = {1,3915},
		seal_resis = {1,3915},
		mp_lim = {2,69.4},
		crit = {1,3915},
		ten = {1,3915},
		hit = {1,3915},
		dodge = {1,3915}
};

get(79) ->
	#guild_cultivate_cfg{
		lv = 79,
		need_point_next_lv = 1585,
		need_gamemoney = 395000,
		need_contri = 5,
		need_exp = 750000,
		need_contri_2 = 5,
		hp_lim = {2,70.7},
		act_speed = {1,444},
		seal_hit = {1,3996},
		seal_resis = {1,3996},
		mp_lim = {2,70.7},
		crit = {1,3996},
		ten = {1,3996},
		hit = {1,3996},
		dodge = {1,3996}
};

get(80) ->
	#guild_cultivate_cfg{
		lv = 80,
		need_point_next_lv = 1605,
		need_gamemoney = 400000,
		need_contri = 5,
		need_exp = 750000,
		need_contri_2 = 5,
		hp_lim = {2,72},
		act_speed = {1,453},
		seal_hit = {1,4077},
		seal_resis = {1,4077},
		mp_lim = {2,72},
		crit = {1,4077},
		ten = {1,4077},
		hit = {1,4077},
		dodge = {1,4077}
};

get(81) ->
	#guild_cultivate_cfg{
		lv = 81,
		need_point_next_lv = 1625,
		need_gamemoney = 405000,
		need_contri = 5,
		need_exp = 750000,
		need_contri_2 = 5,
		hp_lim = {2,73.3},
		act_speed = {1,462},
		seal_hit = {1,4158},
		seal_resis = {1,4158},
		mp_lim = {2,73.3},
		crit = {1,4158},
		ten = {1,4158},
		hit = {1,4158},
		dodge = {1,4158}
};

get(82) ->
	#guild_cultivate_cfg{
		lv = 82,
		need_point_next_lv = 1645,
		need_gamemoney = 410000,
		need_contri = 5,
		need_exp = 750000,
		need_contri_2 = 5,
		hp_lim = {2,74.6},
		act_speed = {1,471},
		seal_hit = {1,4239},
		seal_resis = {1,4239},
		mp_lim = {2,74.6},
		crit = {1,4239},
		ten = {1,4239},
		hit = {1,4239},
		dodge = {1,4239}
};

get(83) ->
	#guild_cultivate_cfg{
		lv = 83,
		need_point_next_lv = 1665,
		need_gamemoney = 415000,
		need_contri = 5,
		need_exp = 750000,
		need_contri_2 = 5,
		hp_lim = {2,75.9},
		act_speed = {1,481},
		seal_hit = {1,4329},
		seal_resis = {1,4329},
		mp_lim = {2,75.9},
		crit = {1,4329},
		ten = {1,4329},
		hit = {1,4329},
		dodge = {1,4329}
};

get(84) ->
	#guild_cultivate_cfg{
		lv = 84,
		need_point_next_lv = 1685,
		need_gamemoney = 420000,
		need_contri = 5,
		need_exp = 750000,
		need_contri_2 = 5,
		hp_lim = {2,77.2},
		act_speed = {1,491},
		seal_hit = {1,4419},
		seal_resis = {1,4419},
		mp_lim = {2,77.2},
		crit = {1,4419},
		ten = {1,4419},
		hit = {1,4419},
		dodge = {1,4419}
};

get(85) ->
	#guild_cultivate_cfg{
		lv = 85,
		need_point_next_lv = 1705,
		need_gamemoney = 425000,
		need_contri = 5,
		need_exp = 750000,
		need_contri_2 = 5,
		hp_lim = {2,78.6},
		act_speed = {1,501},
		seal_hit = {1,4509},
		seal_resis = {1,4509},
		mp_lim = {2,78.6},
		crit = {1,4509},
		ten = {1,4509},
		hit = {1,4509},
		dodge = {1,4509}
};

get(86) ->
	#guild_cultivate_cfg{
		lv = 86,
		need_point_next_lv = 1725,
		need_gamemoney = 430000,
		need_contri = 5,
		need_exp = 750000,
		need_contri_2 = 5,
		hp_lim = {2,79.9},
		act_speed = {1,511},
		seal_hit = {1,4599},
		seal_resis = {1,4599},
		mp_lim = {2,79.9},
		crit = {1,4599},
		ten = {1,4599},
		hit = {1,4599},
		dodge = {1,4599}
};

get(87) ->
	#guild_cultivate_cfg{
		lv = 87,
		need_point_next_lv = 1745,
		need_gamemoney = 435000,
		need_contri = 5,
		need_exp = 750000,
		need_contri_2 = 5,
		hp_lim = {2,81.3},
		act_speed = {1,521},
		seal_hit = {1,4689},
		seal_resis = {1,4689},
		mp_lim = {2,81.3},
		crit = {1,4689},
		ten = {1,4689},
		hit = {1,4689},
		dodge = {1,4689}
};

get(88) ->
	#guild_cultivate_cfg{
		lv = 88,
		need_point_next_lv = 1765,
		need_gamemoney = 440000,
		need_contri = 5,
		need_exp = 750000,
		need_contri_2 = 5,
		hp_lim = {2,82.7},
		act_speed = {1,531},
		seal_hit = {1,4779},
		seal_resis = {1,4779},
		mp_lim = {2,82.7},
		crit = {1,4779},
		ten = {1,4779},
		hit = {1,4779},
		dodge = {1,4779}
};

get(89) ->
	#guild_cultivate_cfg{
		lv = 89,
		need_point_next_lv = 1785,
		need_gamemoney = 445000,
		need_contri = 5,
		need_exp = 750000,
		need_contri_2 = 5,
		hp_lim = {2,84.1},
		act_speed = {1,541},
		seal_hit = {1,4869},
		seal_resis = {1,4869},
		mp_lim = {2,84.1},
		crit = {1,4869},
		ten = {1,4869},
		hit = {1,4869},
		dodge = {1,4869}
};

get(90) ->
	#guild_cultivate_cfg{
		lv = 90,
		need_point_next_lv = 1805,
		need_gamemoney = 450000,
		need_contri = 5,
		need_exp = 750000,
		need_contri_2 = 5,
		hp_lim = {2,85.5},
		act_speed = {1,551},
		seal_hit = {1,4959},
		seal_resis = {1,4959},
		mp_lim = {2,85.5},
		crit = {1,4959},
		ten = {1,4959},
		hit = {1,4959},
		dodge = {1,4959}
};

get(91) ->
	#guild_cultivate_cfg{
		lv = 91,
		need_point_next_lv = 1825,
		need_gamemoney = 455000,
		need_contri = 5,
		need_exp = 750000,
		need_contri_2 = 5,
		hp_lim = {2,86.9},
		act_speed = {1,561},
		seal_hit = {1,5049},
		seal_resis = {1,5049},
		mp_lim = {2,86.9},
		crit = {1,5049},
		ten = {1,5049},
		hit = {1,5049},
		dodge = {1,5049}
};

get(92) ->
	#guild_cultivate_cfg{
		lv = 92,
		need_point_next_lv = 1845,
		need_gamemoney = 460000,
		need_contri = 5,
		need_exp = 750000,
		need_contri_2 = 5,
		hp_lim = {2,88.3},
		act_speed = {1,572},
		seal_hit = {1,5148},
		seal_resis = {1,5148},
		mp_lim = {2,88.3},
		crit = {1,5148},
		ten = {1,5148},
		hit = {1,5148},
		dodge = {1,5148}
};

get(93) ->
	#guild_cultivate_cfg{
		lv = 93,
		need_point_next_lv = 1865,
		need_gamemoney = 465000,
		need_contri = 5,
		need_exp = 750000,
		need_contri_2 = 5,
		hp_lim = {2,89.7},
		act_speed = {1,583},
		seal_hit = {1,5247},
		seal_resis = {1,5247},
		mp_lim = {2,89.7},
		crit = {1,5247},
		ten = {1,5247},
		hit = {1,5247},
		dodge = {1,5247}
};

get(94) ->
	#guild_cultivate_cfg{
		lv = 94,
		need_point_next_lv = 1885,
		need_gamemoney = 470000,
		need_contri = 5,
		need_exp = 750000,
		need_contri_2 = 5,
		hp_lim = {2,91.1},
		act_speed = {1,594},
		seal_hit = {1,5346},
		seal_resis = {1,5346},
		mp_lim = {2,91.1},
		crit = {1,5346},
		ten = {1,5346},
		hit = {1,5346},
		dodge = {1,5346}
};

get(95) ->
	#guild_cultivate_cfg{
		lv = 95,
		need_point_next_lv = 1905,
		need_gamemoney = 475000,
		need_contri = 5,
		need_exp = 750000,
		need_contri_2 = 5,
		hp_lim = {2,92.6},
		act_speed = {1,605},
		seal_hit = {1,5445},
		seal_resis = {1,5445},
		mp_lim = {2,92.6},
		crit = {1,5445},
		ten = {1,5445},
		hit = {1,5445},
		dodge = {1,5445}
};

get(96) ->
	#guild_cultivate_cfg{
		lv = 96,
		need_point_next_lv = 1925,
		need_gamemoney = 480000,
		need_contri = 5,
		need_exp = 750000,
		need_contri_2 = 5,
		hp_lim = {2,94},
		act_speed = {1,617},
		seal_hit = {1,5553},
		seal_resis = {1,5553},
		mp_lim = {2,94},
		crit = {1,5553},
		ten = {1,5553},
		hit = {1,5553},
		dodge = {1,5553}
};

get(97) ->
	#guild_cultivate_cfg{
		lv = 97,
		need_point_next_lv = 1945,
		need_gamemoney = 485000,
		need_contri = 5,
		need_exp = 750000,
		need_contri_2 = 5,
		hp_lim = {2,95.5},
		act_speed = {1,629},
		seal_hit = {1,5661},
		seal_resis = {1,5661},
		mp_lim = {2,95.5},
		crit = {1,5661},
		ten = {1,5661},
		hit = {1,5661},
		dodge = {1,5661}
};

get(98) ->
	#guild_cultivate_cfg{
		lv = 98,
		need_point_next_lv = 1965,
		need_gamemoney = 490000,
		need_contri = 5,
		need_exp = 750000,
		need_contri_2 = 5,
		hp_lim = {2,97},
		act_speed = {1,641},
		seal_hit = {1,5769},
		seal_resis = {1,5769},
		mp_lim = {2,97},
		crit = {1,5769},
		ten = {1,5769},
		hit = {1,5769},
		dodge = {1,5769}
};

get(99) ->
	#guild_cultivate_cfg{
		lv = 99,
		need_point_next_lv = 1985,
		need_gamemoney = 495000,
		need_contri = 5,
		need_exp = 750000,
		need_contri_2 = 5,
		hp_lim = {2,98.5},
		act_speed = {1,653},
		seal_hit = {1,5877},
		seal_resis = {1,5877},
		mp_lim = {2,98.5},
		crit = {1,5877},
		ten = {1,5877},
		hit = {1,5877},
		dodge = {1,5877}
};

get(100) ->
	#guild_cultivate_cfg{
		lv = 100,
		need_point_next_lv = 2005,
		need_gamemoney = 500000,
		need_contri = 5,
		need_exp = 750000,
		need_contri_2 = 5,
		hp_lim = {2,100},
		act_speed = {1,665},
		seal_hit = {1,5985},
		seal_resis = {1,5985},
		mp_lim = {2,100},
		crit = {1,5985},
		ten = {1,5985},
		hit = {1,5985},
		dodge = {1,5985}
};

get(_Lv) ->
	      ?ASSERT(false, _Lv),
          null.

