%%%---------------------------------------
%%% @Module  : data_eq_refine_lv_open
%%% @Author  : zhangwq
%%% @Email   : 
%%% @Description: 装备附加属性精炼等级开放表
%%%---------------------------------------


-module(data_eq_refine_lv_open).

-include("record/goods_record.hrl").
-include("debug.hrl").
-compile(export_all).


				get(1) -> {1, 10, 10}
			;

				get(10) -> {1, 10, 10}
			;

				get(20) -> {4, 20, 15}
			;

				get(30) -> {7, 30, 20}
			;

				get(40) -> {10, 40, 25}
			;

				get(50) -> {12, 50, 30}
			;

				get(60) -> {14, 60, 40}
			;

				get(70) -> {16, 70, 46}
			;

				get(80) -> {18, 80, 55}
			;

				get(_No) ->
					null.
		
