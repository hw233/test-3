%%%---------------------------------------
%%% @Module  : data_par_eq_strenthen
%%% @Author  : zwq
%%% @Email   : 
%%% @Description:  女妖装备强化
%%%---------------------------------------


-module(data_par_eq_strenthen).
-include("common.hrl").
-include("record.hrl").
-include("record/goods_record.hrl").
-compile(export_all).

get_all_lv_step_list()->
	[1,2,3].

get(1) ->
	[
		#par_eq_stren{
			lv_range = [1,49], 
			stren_lv = 1, 
			exp_need = 15, 
			attr_add = 5
			},
		#par_eq_stren{
			lv_range = [1,49], 
			stren_lv = 2, 
			exp_need = 30, 
			attr_add = 10
			},
		#par_eq_stren{
			lv_range = [1,49], 
			stren_lv = 3, 
			exp_need = 50, 
			attr_add = 15
			},
		#par_eq_stren{
			lv_range = [1,49], 
			stren_lv = 4, 
			exp_need = 75, 
			attr_add = 20
			},
		#par_eq_stren{
			lv_range = [1,49], 
			stren_lv = 5, 
			exp_need = 100, 
			attr_add = 26
			},
		#par_eq_stren{
			lv_range = [1,49], 
			stren_lv = 6, 
			exp_need = 150, 
			attr_add = 32
			},
		#par_eq_stren{
			lv_range = [1,49], 
			stren_lv = 7, 
			exp_need = 190, 
			attr_add = 38
			},
		#par_eq_stren{
			lv_range = [1,49], 
			stren_lv = 8, 
			exp_need = 250.000000, 
			attr_add = 44
			},
		#par_eq_stren{
			lv_range = [1,49], 
			stren_lv = 9, 
			exp_need = 375, 
			attr_add = 52
			},
		#par_eq_stren{
			lv_range = [1,49], 
			stren_lv = 10, 
			exp_need = 750, 
			attr_add = 60
			},
		#par_eq_stren{
			lv_range = [1,49], 
			stren_lv = 11, 
			exp_need = 940, 
			attr_add = 71
			},
		#par_eq_stren{
			lv_range = [1,49], 
			stren_lv = 12, 
			exp_need = 1070, 
			attr_add = 84
			},
		#par_eq_stren{
			lv_range = [1,49], 
			stren_lv = 13, 
			exp_need = 1250, 
			attr_add = 97
			},
		#par_eq_stren{
			lv_range = [1,49], 
			stren_lv = 14, 
			exp_need = 1500, 
			attr_add = 111
			},
		#par_eq_stren{
			lv_range = [1,49], 
			stren_lv = 15, 
			exp_need = 1875, 
			attr_add = 129
			},
		#par_eq_stren{
			lv_range = [1,49], 
			stren_lv = 16, 
			exp_need = 2500, 
			attr_add = 157
			},
		#par_eq_stren{
			lv_range = [1,49], 
			stren_lv = 17, 
			exp_need = 3750, 
			attr_add = 226
			},
		#par_eq_stren{
			lv_range = [1,49], 
			stren_lv = 18, 
			exp_need = 5000, 
			attr_add = 300
			},
		#par_eq_stren{
			lv_range = [1,49], 
			stren_lv = 19, 
			exp_need = 7500, 
			attr_add = 380
			},
		#par_eq_stren{
			lv_range = [1,49], 
			stren_lv = 20, 
			exp_need = 15000, 
			attr_add = 470
			}
	];


get(2) ->
	[
		#par_eq_stren{
			lv_range = [50,69], 
			stren_lv = 1, 
			exp_need = 15, 
			attr_add = 5
			},
		#par_eq_stren{
			lv_range = [50,69], 
			stren_lv = 2, 
			exp_need = 30, 
			attr_add = 10
			},
		#par_eq_stren{
			lv_range = [50,69], 
			stren_lv = 3, 
			exp_need = 50, 
			attr_add = 15
			},
		#par_eq_stren{
			lv_range = [50,69], 
			stren_lv = 4, 
			exp_need = 75, 
			attr_add = 20
			},
		#par_eq_stren{
			lv_range = [50,69], 
			stren_lv = 5, 
			exp_need = 100, 
			attr_add = 26
			},
		#par_eq_stren{
			lv_range = [50,69], 
			stren_lv = 6, 
			exp_need = 150, 
			attr_add = 32
			},
		#par_eq_stren{
			lv_range = [50,69], 
			stren_lv = 7, 
			exp_need = 190, 
			attr_add = 38
			},
		#par_eq_stren{
			lv_range = [50,69], 
			stren_lv = 8, 
			exp_need = 250.000000, 
			attr_add = 44
			},
		#par_eq_stren{
			lv_range = [50,69], 
			stren_lv = 9, 
			exp_need = 375, 
			attr_add = 52
			},
		#par_eq_stren{
			lv_range = [50,69], 
			stren_lv = 10, 
			exp_need = 750, 
			attr_add = 60
			},
		#par_eq_stren{
			lv_range = [50,69], 
			stren_lv = 11, 
			exp_need = 940, 
			attr_add = 71
			},
		#par_eq_stren{
			lv_range = [50,69], 
			stren_lv = 12, 
			exp_need = 1070, 
			attr_add = 84
			},
		#par_eq_stren{
			lv_range = [50,69], 
			stren_lv = 13, 
			exp_need = 1250, 
			attr_add = 97
			},
		#par_eq_stren{
			lv_range = [50,69], 
			stren_lv = 14, 
			exp_need = 1500, 
			attr_add = 111
			},
		#par_eq_stren{
			lv_range = [50,69], 
			stren_lv = 15, 
			exp_need = 1875, 
			attr_add = 129
			},
		#par_eq_stren{
			lv_range = [50,69], 
			stren_lv = 16, 
			exp_need = 2500, 
			attr_add = 157
			},
		#par_eq_stren{
			lv_range = [50,69], 
			stren_lv = 17, 
			exp_need = 3750, 
			attr_add = 226
			},
		#par_eq_stren{
			lv_range = [50,69], 
			stren_lv = 18, 
			exp_need = 5000, 
			attr_add = 300
			},
		#par_eq_stren{
			lv_range = [50,69], 
			stren_lv = 19, 
			exp_need = 7500, 
			attr_add = 380
			},
		#par_eq_stren{
			lv_range = [50,69], 
			stren_lv = 20, 
			exp_need = 15000, 
			attr_add = 470
			}
	];


get(3) ->
	[
		#par_eq_stren{
			lv_range = [70,89], 
			stren_lv = 1, 
			exp_need = 15, 
			attr_add = 5
			},
		#par_eq_stren{
			lv_range = [70,89], 
			stren_lv = 2, 
			exp_need = 30, 
			attr_add = 10
			},
		#par_eq_stren{
			lv_range = [70,89], 
			stren_lv = 3, 
			exp_need = 50, 
			attr_add = 15
			},
		#par_eq_stren{
			lv_range = [70,89], 
			stren_lv = 4, 
			exp_need = 75, 
			attr_add = 20
			},
		#par_eq_stren{
			lv_range = [70,89], 
			stren_lv = 5, 
			exp_need = 100, 
			attr_add = 26
			},
		#par_eq_stren{
			lv_range = [70,89], 
			stren_lv = 6, 
			exp_need = 150, 
			attr_add = 32
			},
		#par_eq_stren{
			lv_range = [70,89], 
			stren_lv = 7, 
			exp_need = 190, 
			attr_add = 38
			},
		#par_eq_stren{
			lv_range = [70,89], 
			stren_lv = 8, 
			exp_need = 250.000000, 
			attr_add = 44
			},
		#par_eq_stren{
			lv_range = [70,89], 
			stren_lv = 9, 
			exp_need = 375, 
			attr_add = 52
			},
		#par_eq_stren{
			lv_range = [70,89], 
			stren_lv = 10, 
			exp_need = 750, 
			attr_add = 60
			},
		#par_eq_stren{
			lv_range = [70,89], 
			stren_lv = 11, 
			exp_need = 940, 
			attr_add = 71
			},
		#par_eq_stren{
			lv_range = [70,89], 
			stren_lv = 12, 
			exp_need = 1070, 
			attr_add = 84
			},
		#par_eq_stren{
			lv_range = [70,89], 
			stren_lv = 13, 
			exp_need = 1250, 
			attr_add = 97
			},
		#par_eq_stren{
			lv_range = [70,89], 
			stren_lv = 14, 
			exp_need = 1500, 
			attr_add = 111
			},
		#par_eq_stren{
			lv_range = [70,89], 
			stren_lv = 15, 
			exp_need = 1875, 
			attr_add = 129
			},
		#par_eq_stren{
			lv_range = [70,89], 
			stren_lv = 16, 
			exp_need = 2500, 
			attr_add = 157
			},
		#par_eq_stren{
			lv_range = [70,89], 
			stren_lv = 17, 
			exp_need = 3750, 
			attr_add = 226
			},
		#par_eq_stren{
			lv_range = [70,89], 
			stren_lv = 18, 
			exp_need = 5000, 
			attr_add = 300
			},
		#par_eq_stren{
			lv_range = [70,89], 
			stren_lv = 19, 
			exp_need = 7500, 
			attr_add = 380
			},
		#par_eq_stren{
			lv_range = [70,89], 
			stren_lv = 20, 
			exp_need = 15000, 
			attr_add = 470
			}
	];


get(_No) ->
	      ?ASSERT(false, _No),
          null.

