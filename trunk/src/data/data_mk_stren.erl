%%%---------------------------------------
%%% @Module  : data_mk_stren
%%% @Author  : zwq
%%% @Email   : 
%%% @Description:  法宝强化
%%%---------------------------------------


-module(data_mk_stren).
-include("common.hrl").
-include("record.hrl").
-include("record/goods_record.hrl").
-compile(export_all).

get_all_lv_step_list()->
	[7001].

get(7001) ->
	[
		#mk_stren_cfg{
			quality = 1, 
			layer = 1, 
			exp_need = 60, 
			need_money = [{1, 200}]
			},
		#mk_stren_cfg{
			quality = 1, 
			layer = 2, 
			exp_need = 84, 
			need_money = [{1, 200}]
			},
		#mk_stren_cfg{
			quality = 1, 
			layer = 3, 
			exp_need = 252, 
			need_money = [{1, 200}]
			},
		#mk_stren_cfg{
			quality = 1, 
			layer = 4, 
			exp_need = 504, 
			need_money = [{1, 200}]
			},
		#mk_stren_cfg{
			quality = 2, 
			layer = 1, 
			exp_need = 840, 
			need_money = [{1, 200}]
			},
		#mk_stren_cfg{
			quality = 2, 
			layer = 2, 
			exp_need = 1260, 
			need_money = [{1, 200}]
			},
		#mk_stren_cfg{
			quality = 2, 
			layer = 3, 
			exp_need = 1680, 
			need_money = [{1, 200}]
			},
		#mk_stren_cfg{
			quality = 2, 
			layer = 4, 
			exp_need = 2100, 
			need_money = [{1, 200}]
			},
		#mk_stren_cfg{
			quality = 3, 
			layer = 1, 
			exp_need = 2520, 
			need_money = [{1, 200}]
			},
		#mk_stren_cfg{
			quality = 3, 
			layer = 2, 
			exp_need = 3150, 
			need_money = [{1, 200}]
			},
		#mk_stren_cfg{
			quality = 3, 
			layer = 3, 
			exp_need = 4200, 
			need_money = [{1, 200}]
			},
		#mk_stren_cfg{
			quality = 3, 
			layer = 4, 
			exp_need = 5670, 
			need_money = [{1, 200}]
			},
		#mk_stren_cfg{
			quality = 4, 
			layer = 1, 
			exp_need = 7560, 
			need_money = [{1, 200}]
			},
		#mk_stren_cfg{
			quality = 4, 
			layer = 2, 
			exp_need = 10080, 
			need_money = [{1, 200}]
			},
		#mk_stren_cfg{
			quality = 4, 
			layer = 3, 
			exp_need = 13440, 
			need_money = [{1, 200}]
			},
		#mk_stren_cfg{
			quality = 4, 
			layer = 4, 
			exp_need = 17640, 
			need_money = [{1, 200}]
			},
		#mk_stren_cfg{
			quality = 5, 
			layer = 1, 
			exp_need = 23520, 
			need_money = [{1, 200}]
			},
		#mk_stren_cfg{
			quality = 5, 
			layer = 2, 
			exp_need = 31080, 
			need_money = [{1, 200}]
			},
		#mk_stren_cfg{
			quality = 5, 
			layer = 3, 
			exp_need = 40320, 
			need_money = [{1, 200}]
			},
		#mk_stren_cfg{
			quality = 5, 
			layer = 4, 
			exp_need = 52080, 
			need_money = [{1, 200}]
			},
		#mk_stren_cfg{
			quality = 6, 
			layer = 1, 
			exp_need = 68040, 
			need_money = [{1, 200}]
			}
	];


get(_No) ->
	      ?ASSERT(false, _No),
          null.

get(7001,1,1) ->
	#mk_stren_cfg{
		no = 7001,
		quality = 1,
		layer = 1,
		exp_need = 60,
		need_money = [{1, 200}]
};

get(7001,1,2) ->
	#mk_stren_cfg{
		no = 7001,
		quality = 1,
		layer = 2,
		exp_need = 84,
		need_money = [{1, 200}]
};

get(7001,1,3) ->
	#mk_stren_cfg{
		no = 7001,
		quality = 1,
		layer = 3,
		exp_need = 252,
		need_money = [{1, 200}]
};

get(7001,1,4) ->
	#mk_stren_cfg{
		no = 7001,
		quality = 1,
		layer = 4,
		exp_need = 504,
		need_money = [{1, 200}]
};

get(7001,2,1) ->
	#mk_stren_cfg{
		no = 7001,
		quality = 2,
		layer = 1,
		exp_need = 840,
		need_money = [{1, 200}]
};

get(7001,2,2) ->
	#mk_stren_cfg{
		no = 7001,
		quality = 2,
		layer = 2,
		exp_need = 1260,
		need_money = [{1, 200}]
};

get(7001,2,3) ->
	#mk_stren_cfg{
		no = 7001,
		quality = 2,
		layer = 3,
		exp_need = 1680,
		need_money = [{1, 200}]
};

get(7001,2,4) ->
	#mk_stren_cfg{
		no = 7001,
		quality = 2,
		layer = 4,
		exp_need = 2100,
		need_money = [{1, 200}]
};

get(7001,3,1) ->
	#mk_stren_cfg{
		no = 7001,
		quality = 3,
		layer = 1,
		exp_need = 2520,
		need_money = [{1, 200}]
};

get(7001,3,2) ->
	#mk_stren_cfg{
		no = 7001,
		quality = 3,
		layer = 2,
		exp_need = 3150,
		need_money = [{1, 200}]
};

get(7001,3,3) ->
	#mk_stren_cfg{
		no = 7001,
		quality = 3,
		layer = 3,
		exp_need = 4200,
		need_money = [{1, 200}]
};

get(7001,3,4) ->
	#mk_stren_cfg{
		no = 7001,
		quality = 3,
		layer = 4,
		exp_need = 5670,
		need_money = [{1, 200}]
};

get(7001,4,1) ->
	#mk_stren_cfg{
		no = 7001,
		quality = 4,
		layer = 1,
		exp_need = 7560,
		need_money = [{1, 200}]
};

get(7001,4,2) ->
	#mk_stren_cfg{
		no = 7001,
		quality = 4,
		layer = 2,
		exp_need = 10080,
		need_money = [{1, 200}]
};

get(7001,4,3) ->
	#mk_stren_cfg{
		no = 7001,
		quality = 4,
		layer = 3,
		exp_need = 13440,
		need_money = [{1, 200}]
};

get(7001,4,4) ->
	#mk_stren_cfg{
		no = 7001,
		quality = 4,
		layer = 4,
		exp_need = 17640,
		need_money = [{1, 200}]
};

get(7001,5,1) ->
	#mk_stren_cfg{
		no = 7001,
		quality = 5,
		layer = 1,
		exp_need = 23520,
		need_money = [{1, 200}]
};

get(7001,5,2) ->
	#mk_stren_cfg{
		no = 7001,
		quality = 5,
		layer = 2,
		exp_need = 31080,
		need_money = [{1, 200}]
};

get(7001,5,3) ->
	#mk_stren_cfg{
		no = 7001,
		quality = 5,
		layer = 3,
		exp_need = 40320,
		need_money = [{1, 200}]
};

get(7001,5,4) ->
	#mk_stren_cfg{
		no = 7001,
		quality = 5,
		layer = 4,
		exp_need = 52080,
		need_money = [{1, 200}]
};

get(7001,6,1) ->
	#mk_stren_cfg{
		no = 7001,
		quality = 6,
		layer = 1,
		exp_need = 68040,
		need_money = [{1, 200}]
};

get(_No, _Quality, _Layer) ->
	      ?ASSERT(false, {_No, _Quality, _Layer}),
          null.

