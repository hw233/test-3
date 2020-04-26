%%%---------------------------------------
%%% @Module  : data_chibang
%%% @Author  : wbh
%%% @Email   :
%%% @Description: 翅膀
%%%---------------------------------------


-module(data_chibang).
-include("debug.hrl").
-include("chibang.hrl").
-compile(export_all).


get_all_id()->
	[10000,10001,10002,10003].


				get_attr(10000) -> [{phy_att,50, 1},{mag_att,50,1}]
			;

				get_attr(10001) -> [{hp_lim,200,2},{phy_def,50, 2},{mag_def,50,2},{heal_value,50,1}]
			;

				get_attr(10002) -> [{act_speed,50,1},{mp_lim,200,2},{seal_resis,30,1}]
			;

				get_attr(10003) -> [{phy_att,450, 1},{mag_att,450,1},{hp_lim,300,2}]
			;

				get_attr(_) ->
	      ?ASSERT(false),   
          null.
		

				get_chibang_info(10000) ->
			#chibang_info{
				id=10000,
				type=0,
				train_goods1={110000,10},
				train_goods2={110001,50},
				train_goods3={110003,2000}
				}
			;

				get_chibang_info(10001) ->
			#chibang_info{
				id=10001,
				type=0,
				train_goods1={110008,10},
				train_goods2={110009,50},
				train_goods3={110011,2000}
				}
			;

				get_chibang_info(10002) ->
			#chibang_info{
				id=10002,
				type=0,
				train_goods1={110004,10},
				train_goods2={110005,50},
				train_goods3={110007,2000}
				}
			;

				get_chibang_info(10003) ->
			#chibang_info{
				id=10003,
				type=0,
				train_goods1={110012,10},
				train_goods2={110013,50},
				train_goods3={110015,2000}
				}
			;

				 get_chibang_info(_) -> 
	      ?ASSERT(false), 
          null.
		

				get_max_lv(10000) -> 50
			;

				get_max_lv(10001) -> 50
			;

				get_max_lv(10002) -> 50
			;

				get_max_lv(10003) -> 50
			;

				get_max_lv(_) ->
	      ?ASSERT(false),   
          null.
		
