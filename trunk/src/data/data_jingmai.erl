%%%---------------------------------------
%%% @Module  : data_jingmai
%%% @Author  : dsh
%%% @Email   : 
%%% @Description:  经脉
%%%---------------------------------------


-module(data_jingmai).

-include("jingmai.hrl").
-include("debug.hrl").
-compile(export_all).


				get(1) -> {1, 1}
			;

				get(2) -> {1, 2}
			;

				get(3) -> {1, 3}
			;

				get(4) -> {1, 4}
			;

				get(5) -> {1, 5}
			;

				get(6) -> {1, 6}
			;

				get(7) -> {1, 7}
			;

				get(8) -> {1, 8}
			;

				get(9) -> {1, 9}
			;

				get(10) -> {2, 1}
			;

				get(11) -> {2, 2}
			;

				get(12) -> {2, 3}
			;

				get(13) -> {2, 4}
			;

				get(14) -> {2, 5}
			;

				get(15) -> {2, 6}
			;

				get(16) -> {2, 7}
			;

				get(17) -> {2, 8}
			;

				get(18) -> {2, 9}
			;

				get(19) -> {3, 1}
			;

				get(20) -> {3, 2}
			;

				get(21) -> {3, 3}
			;

				get(22) -> {3, 4}
			;

				get(23) -> {3, 5}
			;

				get(24) -> {3, 6}
			;

				get(25) -> {3, 7}
			;

				get(26) -> {3, 8}
			;

				get(27) -> {3, 9}
			;

				get(28) -> {4, 1}
			;

				get(29) -> {4, 2}
			;

				get(30) -> {4, 3}
			;

				get(31) -> {4, 4}
			;

				get(32) -> {4, 5}
			;

				get(33) -> {4, 6}
			;

				get(34) -> {4, 7}
			;

				get(35) -> {4, 8}
			;

				get(36) -> {4, 9}
			;

				get(37) -> {5, 1}
			;

				get(38) -> {5, 2}
			;

				get(39) -> {5, 3}
			;

				get(40) -> {5, 4}
			;

				get(41) -> {5, 5}
			;

				get(42) -> {5, 6}
			;

				get(43) -> {5, 7}
			;

				get(44) -> {5, 8}
			;

				get(45) -> {5, 9}
			;

				get(46) -> {6, 1}
			;

				get(47) -> {6, 2}
			;

				get(48) -> {6, 3}
			;

				get(49) -> {6, 4}
			;

				get(50) -> {6, 5}
			;

				get(51) -> {6, 6}
			;

				get(52) -> {6, 7}
			;

				get(53) -> {6, 8}
			;

				get(54) -> {6, 9}
			;

				get(55) -> {7, 1}
			;

				get(56) -> {7, 2}
			;

				get(57) -> {7, 3}
			;

				get(58) -> {7, 4}
			;

				get(59) -> {7, 5}
			;

				get(60) -> {7, 6}
			;

				get(61) -> {7, 7}
			;

				get(62) -> {7, 8}
			;

				get(63) -> {7, 9}
			;

				get(_No) ->
					null.
		
get(1,1) ->
	#jinmai_config{
		no = 1,
		class = 1,
		lv = 1,
		limit_1 = [{2,1}],
		add_attr = [{seal_hit,7681,0}]
};

get(1,2) ->
	#jinmai_config{
		no = 2,
		class = 1,
		lv = 2,
		limit_1 = [{2,1}],
		add_attr = [{seal_hit,8705,0}]
};

get(1,3) ->
	#jinmai_config{
		no = 3,
		class = 1,
		lv = 3,
		limit_1 = [{2,1}],
		add_attr = [{act_speed,12290,0}]
};

get(1,4) ->
	#jinmai_config{
		no = 4,
		class = 1,
		lv = 4,
		limit_1 = [{2,4}],
		add_attr = [{seal_hit,9729,0}]
};

get(1,5) ->
	#jinmai_config{
		no = 5,
		class = 1,
		lv = 5,
		limit_1 = [{2,4}],
		add_attr = [{seal_resis,19459,0}]
};

get(1,6) ->
	#jinmai_config{
		no = 6,
		class = 1,
		lv = 6,
		limit_1 = [{2,8}],
		add_attr = [{seal_hit,10753,0}]
};

get(1,7) ->
	#jinmai_config{
		no = 7,
		class = 1,
		lv = 7,
		limit_1 = [{2,8}],
		add_attr = [{act_speed,17206,0}]
};

get(1,8) ->
	#jinmai_config{
		no = 8,
		class = 1,
		lv = 8,
		limit_1 = [{2,9}],
		add_attr = [{seal_hit,11778,0}]
};

get(1,9) ->
	#jinmai_config{
		no = 9,
		class = 1,
		lv = 9,
		limit_1 = [{2,9}],
		add_attr = [{seal_resis,23555,0}]
};

get(2,1) ->
	#jinmai_config{
		no = 10,
		class = 2,
		lv = 1,
		limit_1 = [],
		add_attr = [{hp_lim,307243,0}]
};

get(2,2) ->
	#jinmai_config{
		no = 11,
		class = 2,
		lv = 2,
		limit_1 = [],
		add_attr = [{phy_def,61449,0}]
};

get(2,3) ->
	#jinmai_config{
		no = 12,
		class = 2,
		lv = 3,
		limit_1 = [],
		add_attr = [{mag_def,61449,0}]
};

get(2,4) ->
	#jinmai_config{
		no = 13,
		class = 2,
		lv = 4,
		limit_1 = [{5,3}],
		add_attr = [{seal_resis,15362,0}]
};

get(2,5) ->
	#jinmai_config{
		no = 14,
		class = 2,
		lv = 5,
		limit_1 = [{5,3}],
		add_attr = [{be_mag_dam_reduce_coef,0.07,0}]
};

get(2,6) ->
	#jinmai_config{
		no = 15,
		class = 2,
		lv = 6,
		limit_1 = [{5,3}],
		add_attr = [{hp_lim,348208,0}]
};

get(2,7) ->
	#jinmai_config{
		no = 16,
		class = 2,
		lv = 7,
		limit_1 = [{5,6}],
		add_attr = [{phy_def,69642,0}]
};

get(2,8) ->
	#jinmai_config{
		no = 17,
		class = 2,
		lv = 8,
		limit_1 = [{5,6}],
		add_attr = [{mag_def,69642,0}]
};

get(2,9) ->
	#jinmai_config{
		no = 18,
		class = 2,
		lv = 9,
		limit_1 = [{5,6}],
		add_attr = [{be_phy_dam_reduce_coef,0.07,0}]
};

get(3,1) ->
	#jinmai_config{
		no = 19,
		class = 3,
		lv = 1,
		limit_1 = [{2,1}],
		add_attr = [{phy_att,30724,0}]
};

get(3,2) ->
	#jinmai_config{
		no = 20,
		class = 3,
		lv = 2,
		limit_1 = [{2,1}],
		add_attr = [{phy_att,34821,0}]
};

get(3,3) ->
	#jinmai_config{
		no = 21,
		class = 3,
		lv = 3,
		limit_1 = [{2,1}],
		add_attr = [{do_phy_dam_scaling,0.045,0}]
};

get(3,4) ->
	#jinmai_config{
		no = 22,
		class = 3,
		lv = 4,
		limit_1 = [{2,4}],
		add_attr = [{phy_att,38917,0}]
};

get(3,5) ->
	#jinmai_config{
		no = 23,
		class = 3,
		lv = 5,
		limit_1 = [{2,4}],
		add_attr = [{be_phy_dam_reduce_coef,0.065,0}]
};

get(3,6) ->
	#jinmai_config{
		no = 24,
		class = 3,
		lv = 6,
		limit_1 = [{2,8}],
		add_attr = [{phy_att,43014,0}]
};

get(3,7) ->
	#jinmai_config{
		no = 25,
		class = 3,
		lv = 7,
		limit_1 = [{2,8}],
		add_attr = [{do_phy_dam_scaling,0.055,0}]
};

get(3,8) ->
	#jinmai_config{
		no = 26,
		class = 3,
		lv = 8,
		limit_1 = [{2,9}],
		add_attr = [{phy_att,47111,0}]
};

get(3,9) ->
	#jinmai_config{
		no = 27,
		class = 3,
		lv = 9,
		limit_1 = [{2,9}],
		add_attr = [{be_phy_dam_reduce_coef,0.075,0}]
};

get(4,1) ->
	#jinmai_config{
		no = 28,
		class = 4,
		lv = 1,
		limit_1 = [{2,1}],
		add_attr = [{mag_att,30724,0}]
};

get(4,2) ->
	#jinmai_config{
		no = 29,
		class = 4,
		lv = 2,
		limit_1 = [{2,1}],
		add_attr = [{mag_att,34821,0}]
};

get(4,3) ->
	#jinmai_config{
		no = 30,
		class = 4,
		lv = 3,
		limit_1 = [{2,1}],
		add_attr = [{do_mag_dam_scaling,0.045,0}]
};

get(4,4) ->
	#jinmai_config{
		no = 31,
		class = 4,
		lv = 4,
		limit_1 = [{2,4}],
		add_attr = [{mag_att,38917,0}]
};

get(4,5) ->
	#jinmai_config{
		no = 32,
		class = 4,
		lv = 5,
		limit_1 = [{2,4}],
		add_attr = [{be_mag_dam_reduce_coef,0.065,0}]
};

get(4,6) ->
	#jinmai_config{
		no = 33,
		class = 4,
		lv = 6,
		limit_1 = [{2,8}],
		add_attr = [{mag_att,43014,0}]
};

get(4,7) ->
	#jinmai_config{
		no = 34,
		class = 4,
		lv = 7,
		limit_1 = [{2,8}],
		add_attr = [{do_mag_dam_scaling,0.055,0}]
};

get(4,8) ->
	#jinmai_config{
		no = 35,
		class = 4,
		lv = 8,
		limit_1 = [{2,9}],
		add_attr = [{mag_att,47111,0}]
};

get(4,9) ->
	#jinmai_config{
		no = 36,
		class = 4,
		lv = 9,
		limit_1 = [{2,9}],
		add_attr = [{be_mag_dam_reduce_coef,0.075,0}]
};

get(5,1) ->
	#jinmai_config{
		no = 37,
		class = 5,
		lv = 1,
		limit_1 = [{2,1}],
		add_attr = [{hp_lim,307243,0}]
};

get(5,2) ->
	#jinmai_config{
		no = 38,
		class = 5,
		lv = 2,
		limit_1 = [{2,1}],
		add_attr = [{do_phy_dam_scaling,0.045,0}]
};

get(5,3) ->
	#jinmai_config{
		no = 39,
		class = 5,
		lv = 3,
		limit_1 = [{2,1}],
		add_attr = [{do_mag_dam_scaling,0.045,0}]
};

get(5,4) ->
	#jinmai_config{
		no = 40,
		class = 5,
		lv = 4,
		limit_1 = [{2,4}],
		add_attr = [{hp_lim,348208,0}]
};

get(5,5) ->
	#jinmai_config{
		no = 41,
		class = 5,
		lv = 5,
		limit_1 = [{2,4}],
		add_attr = [{be_phy_dam_reduce_coef,0.065,0}]
};

get(5,6) ->
	#jinmai_config{
		no = 42,
		class = 5,
		lv = 6,
		limit_1 = [{2,4}],
		add_attr = [{be_mag_dam_reduce_coef,0.065,0}]
};

get(5,7) ->
	#jinmai_config{
		no = 43,
		class = 5,
		lv = 7,
		limit_1 = [{2,8}],
		add_attr = [{hp_lim,389174,0}]
};

get(5,8) ->
	#jinmai_config{
		no = 44,
		class = 5,
		lv = 8,
		limit_1 = [{2,8}],
		add_attr = [{do_phy_dam_scaling,0.06,0}]
};

get(5,9) ->
	#jinmai_config{
		no = 45,
		class = 5,
		lv = 9,
		limit_1 = [{2,8}],
		add_attr = [{do_mag_dam_scaling,0.06,0}]
};

get(6,1) ->
	#jinmai_config{
		no = 46,
		class = 6,
		lv = 1,
		limit_1 = [{5,1}],
		add_attr = [{phy_crit,120,0}]
};

get(6,2) ->
	#jinmai_config{
		no = 47,
		class = 6,
		lv = 2,
		limit_1 = [{5,1}],
		add_attr = [{phy_ten,180,0}]
};

get(6,3) ->
	#jinmai_config{
		no = 48,
		class = 6,
		lv = 3,
		limit_1 = [{5,3}],
		add_attr = [{do_phy_dam_scaling,0.045,0}]
};

get(6,4) ->
	#jinmai_config{
		no = 49,
		class = 6,
		lv = 4,
		limit_1 = [{5,3}],
		add_attr = [{be_phy_dam_reduce_coef,0.065,0}]
};

get(6,5) ->
	#jinmai_config{
		no = 50,
		class = 6,
		lv = 5,
		limit_1 = [{5,6}],
		add_attr = [{phy_crit,135,0}]
};

get(6,6) ->
	#jinmai_config{
		no = 51,
		class = 6,
		lv = 6,
		limit_1 = [{5,6}],
		add_attr = [{phy_ten,200,0}]
};

get(6,7) ->
	#jinmai_config{
		no = 52,
		class = 6,
		lv = 7,
		limit_1 = [{5,7}],
		add_attr = [{do_phy_dam_scaling,0.055,0}]
};

get(6,8) ->
	#jinmai_config{
		no = 53,
		class = 6,
		lv = 8,
		limit_1 = [{5,7}],
		add_attr = [{be_phy_dam_reduce_coef,0.075,0}]
};

get(6,9) ->
	#jinmai_config{
		no = 54,
		class = 6,
		lv = 9,
		limit_1 = [{5,9}],
		add_attr = [{phy_crit_coef,55,0}]
};

get(7,1) ->
	#jinmai_config{
		no = 55,
		class = 7,
		lv = 1,
		limit_1 = [{5,1}],
		add_attr = [{mag_crit,120,0}]
};

get(7,2) ->
	#jinmai_config{
		no = 56,
		class = 7,
		lv = 2,
		limit_1 = [{5,1}],
		add_attr = [{mag_ten,180,0}]
};

get(7,3) ->
	#jinmai_config{
		no = 57,
		class = 7,
		lv = 3,
		limit_1 = [{5,3}],
		add_attr = [{do_mag_dam_scaling,0.045,0}]
};

get(7,4) ->
	#jinmai_config{
		no = 58,
		class = 7,
		lv = 4,
		limit_1 = [{5,3}],
		add_attr = [{be_mag_dam_reduce_coef,0.065,0}]
};

get(7,5) ->
	#jinmai_config{
		no = 59,
		class = 7,
		lv = 5,
		limit_1 = [{5,6}],
		add_attr = [{mag_crit,135,0}]
};

get(7,6) ->
	#jinmai_config{
		no = 60,
		class = 7,
		lv = 6,
		limit_1 = [{5,6}],
		add_attr = [{mag_ten,200,0}]
};

get(7,7) ->
	#jinmai_config{
		no = 61,
		class = 7,
		lv = 7,
		limit_1 = [{5,7}],
		add_attr = [{do_mag_dam_scaling,0.055,0}]
};

get(7,8) ->
	#jinmai_config{
		no = 62,
		class = 7,
		lv = 8,
		limit_1 = [{5,7}],
		add_attr = [{be_mag_dam_reduce_coef,0.075,0}]
};

get(7,9) ->
	#jinmai_config{
		no = 63,
		class = 7,
		lv = 9,
		limit_1 = [{5,9}],
		add_attr = [{mag_crit_coef,55,0}]
};

get(_, _) ->
          null.

