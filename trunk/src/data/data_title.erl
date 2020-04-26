%%%---------------------------------------
%%% @Module  : data_title
%%% @Author  : liuzz
%%% @Email   :
%%% @Description: 人物称号
%%%---------------------------------------


-module(data_title).
-export([get/1]).
-include("title.hrl").
-include("debug.hrl").

get(60001) ->
	#data_title{
		id = 60001,
		type = 2,
		valid_minute = 0,
		ava_attr = [],
		add_attr = []
};

get(60002) ->
	#data_title{
		id = 60002,
		type = 2,
		valid_minute = 0,
		ava_attr = [],
		add_attr = []
};

get(60003) ->
	#data_title{
		id = 60003,
		type = 2,
		valid_minute = 0,
		ava_attr = [],
		add_attr = []
};

get(60004) ->
	#data_title{
		id = 60004,
		type = 2,
		valid_minute = 0,
		ava_attr = [],
		add_attr = []
};

get(62005) ->
	#data_title{
		id = 62005,
		type = 2,
		valid_minute = 0,
		ava_attr = [{phy_att, 100, 0},{mag_att, 100, 0},{act_speed,40,0}],
		add_attr = [{phy_att, 100, 0},{mag_att, 100, 0},{act_speed,40,0}]
};

get(62006) ->
	#data_title{
		id = 62006,
		type = 2,
		valid_minute = 0,
		ava_attr = [{be_phy_dam_reduce_coef,0.02,0},{be_mag_dam_reduce_coef, 0.02, 0},{seal_resis,0,0.08}],
		add_attr = [{be_phy_dam_reduce_coef,0.02,0},{be_mag_dam_reduce_coef, 0.02, 0},{seal_resis,0,0.08}]
};

get(62007) ->
	#data_title{
		id = 62007,
		type = 2,
		valid_minute = 0,
		ava_attr = [{do_phy_dam_scaling,0.02,0},{do_mag_dam_scaling, 0.02, 0},{seal_resis,0,0.12}],
		add_attr = [{do_phy_dam_scaling,0.02,0},{do_mag_dam_scaling, 0.02, 0},{seal_resis,0,0.12}]
};

get(1001) ->
	#data_title{
		id = 1001,
		type = 1,
		valid_minute = 10080,
		ava_attr = [{hp_lim,367643,0},{phy_att,73529,0},{mag_att,73529,0},{phy_def,44117,0},{mag_def,44117,0},{seal_hit,7353,0},{seal_resis,14706,0}],
		add_attr = [{be_phy_dam_reduce_coef,0.1183,0},{be_mag_dam_reduce_coef,0.1183,0}]
};

get(1002) ->
	#data_title{
		id = 1002,
		type = 1,
		valid_minute = 10080,
		ava_attr = [{hp_lim,183822,0},{phy_att,36764,0},{mag_att,36764,0},{phy_def,22059,0},{mag_def,22059,0},{seal_hit,3676,0},{seal_resis,7353,0}],
		add_attr = [{be_phy_dam_reduce_coef,0.0592,0},{be_mag_dam_reduce_coef,0.0592,0}]
};

get(1003) ->
	#data_title{
		id = 1003,
		type = 1,
		valid_minute = 43200,
		ava_attr = [{hp_lim,735287,0},{phy_att,147057,0},{mag_att,147057,0},{phy_def,88234,0},{mag_def,88234,0},{seal_hit,14706,0},{seal_resis,29411,0}],
		add_attr = [{phy_crit_coef,141,0},{mag_crit_coef,141,0}]
};

get(1004) ->
	#data_title{
		id = 1004,
		type = 1,
		valid_minute = 10080,
		ava_attr = [{hp_lim,740393,0},{phy_att,74039,0},{mag_att,74039,0},{seal_hit,7404,0}],
		add_attr = [{phy_ten,268,0},{mag_ten,268,0}]
};

get(1005) ->
	#data_title{
		id = 1005,
		type = 1,
		valid_minute = 0,
		ava_attr = [{hp_lim,980382,0},{phy_att,196076,0},{mag_att,196076,0},{phy_def,117646,0},{mag_def,117646,0},{seal_hit,19608,0},{seal_resis,39215,0}],
		add_attr = [{do_phy_dam_scaling,0.2,0},{do_mag_dam_scaling,0.2,0}]
};

get(1006) ->
	#data_title{
		id = 1006,
		type = 1,
		valid_minute = 0,
		ava_attr = [{hp_lim,612739,0},{phy_att,122548,0},{mag_att,122548,0},{phy_def,73529,0},{mag_def,73529,0},{seal_hit,12255,0},{seal_resis,24510,0}],
		add_attr = [{neglect_phy_def,800,0},{neglect_mag_def,800,0}]
};

get(1007) ->
	#data_title{
		id = 1007,
		type = 1,
		valid_minute = 0,
		ava_attr = [{hp_lim,266541,0},{phy_att,26654,0},{mag_att,26654,0},{seal_hit,2665,0}],
		add_attr = [{phy_crit,179,0},{mag_crit,179,0}]
};

get(1008) ->
	#data_title{
		id = 1008,
		type = 1,
		valid_minute = 0,
		ava_attr = [{hp_lim,266541,0},{phy_att,26654,0},{mag_att,26654,0},{seal_hit,2665,0}],
		add_attr = [{do_phy_dam_scaling,0.0704,0},{do_mag_dam_scaling,0.0704,0}]
};

get(1009) ->
	#data_title{
		id = 1009,
		type = 1,
		valid_minute = 0,
		ava_attr = [{hp_lim,444236,0},{phy_att,44424,0},{mag_att,44424,0},{seal_hit,4442,0}],
		add_attr = [{do_phy_dam_scaling,0.1174,0},{do_mag_dam_scaling,0.1174,0}]
};

get(1010) ->
	#data_title{
		id = 1010,
		type = 1,
		valid_minute = 0,
		ava_attr = [{hp_lim,59231,0},{phy_att,5923,0},{mag_att,5923,0},{seal_hit,592,0}],
		add_attr = [{phy_ten,107,0},{mag_ten,107,0}]
};

get(1011) ->
	#data_title{
		id = 1011,
		type = 1,
		valid_minute = 0,
		ava_attr = [{hp_lim,29616,0},{phy_att,2962,0},{mag_att,2962,0},{seal_hit,296,0}],
		add_attr = [{phy_ten,54,0},{mag_ten,54,0}]
};

get(1012) ->
	#data_title{
		id = 1012,
		type = 1,
		valid_minute = 0,
		ava_attr = [{hp_lim,444236,0},{phy_att,44424,0},{mag_att,44424,0},{seal_hit,4442,0}],
		add_attr = [{do_phy_dam_scaling,0.1174,0},{do_mag_dam_scaling,0.1174,0}]
};

get(1013) ->
	#data_title{
		id = 1013,
		type = 1,
		valid_minute = 10080,
		ava_attr = [{hp_lim,490191,0},{phy_att,98038,0},{mag_att,98038,0},{phy_def,58823,0},{mag_def,58823,0},{seal_hit,9804,0},{seal_resis,19608,0}],
		add_attr = [{do_phy_dam_scaling,0.0939,0},{do_mag_dam_scaling,0.0939,0}]
};

get(1014) ->
	#data_title{
		id = 1014,
		type = 1,
		valid_minute = 10080,
		ava_attr = [{hp_lim,857835,0},{phy_att,171567,0},{mag_att,171567,0},{phy_def,102940,0},{mag_def,102940,0},{seal_hit,17157,0},{seal_resis,34313,0}],
		add_attr = [{neglect_phy_def,920,0},{neglect_mag_def,920,0}]
};

get(1015) ->
	#data_title{
		id = 1015,
		type = 1,
		valid_minute = 0,
		ava_attr = [{hp_lim,9352,0},{phy_att,1870,0},{mag_att,1870,0},{seal_hit,187,0}],
		add_attr = [{phy_crit,30,0},{mag_crit,30,0}]
};

get(_ID) ->
				?ERROR_MSG("not found ~w", [_ID]),
          null.

