%%%---------------------------------------
%%% @Module  : data_mk_base_exp
%%% @Author  : zwq
%%% @Email   : 
%%% @Description:  法宝基础经验表
%%%---------------------------------------


-module(data_mk_base_exp).
-include("common.hrl").
-include("record.hrl").
-include("record/goods_record.hrl").
-include("num_limits.hrl").
-compile(export_all).

get(1,3) ->
	#mk_exp_cfg{
		no = 7001,
		eq_no = 1,
		quality = 3,
		base_exp = 10
};

get(_, _) ->
          null.

