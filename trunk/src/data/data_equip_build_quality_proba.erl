%%%---------------------------------------
%%% @Module  : data_equip_build_quality_proba
%%% @Author  : zwq
%%% @Email   : 
%%% @Description:  物品相关
%%%---------------------------------------


-module(data_equip_build_quality_proba).
-include("common.hrl").
-include("record.hrl").
-include("record/goods_record.hrl").
-include("debug.hrl").
-compile(export_all).


				get(1) -> [{1,80}, {2,30},  {3,10}, {4,0},  {5,0},  {6,0}]
			;

				get(2) -> [{1,0}, {2,0},  {3,80}, {4,30},  {5,10},  {6,0}]
			;

				get(3) -> [{1,0}, {2,0},  {3,80}, {4,30},  {5,10},  {6,5}]
			;

				get(_No) ->
					null.
		
