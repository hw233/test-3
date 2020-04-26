%%%---------------------------------------
%%% @Module  : data_equip_decompose_add
%%% @Author  : zwq
%%% @Email   : 
%%% @Description:  装备分解强化额外所得
%%%---------------------------------------


-module(data_equip_decompose_add).
-include("record/goods_record.hrl").
-include("debug.hrl").
-compile(export_all).

get_all_lv_step_list()->
	[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3].

get(1) ->
	[
		#equip_decompose_add{
			stren_lv = 1, 
			goods_list = [{70011,1}], 
			lv_range = [1, 180]
			},
		#equip_decompose_add{
			stren_lv = 2, 
			goods_list = [{70011,3}], 
			lv_range = [1, 180]
			},
		#equip_decompose_add{
			stren_lv = 3, 
			goods_list = [{70011,6}], 
			lv_range = [1, 180]
			},
		#equip_decompose_add{
			stren_lv = 4, 
			goods_list = [{70011,10}], 
			lv_range = [1, 180]
			},
		#equip_decompose_add{
			stren_lv = 5, 
			goods_list = [{70011,15}], 
			lv_range = [1, 180]
			},
		#equip_decompose_add{
			stren_lv = 6, 
			goods_list = [{70011,15},{70012,1}], 
			lv_range = [1, 180]
			},
		#equip_decompose_add{
			stren_lv = 7, 
			goods_list = [{70011,15},{70012,3}], 
			lv_range = [1, 180]
			},
		#equip_decompose_add{
			stren_lv = 8, 
			goods_list = [{70011,15},{70012,6}], 
			lv_range = [1, 180]
			},
		#equip_decompose_add{
			stren_lv = 9, 
			goods_list = [{70011,15},{70012,10}], 
			lv_range = [1, 180]
			},
		#equip_decompose_add{
			stren_lv = 10, 
			goods_list = [{70011,15},{70012,15}], 
			lv_range = [1, 180]
			},
		#equip_decompose_add{
			stren_lv = 11, 
			goods_list = [{70011,15},{70013,1},{70012,15}], 
			lv_range = [1, 180]
			},
		#equip_decompose_add{
			stren_lv = 12, 
			goods_list = [{70011,15},{70013,3},{70012,15}], 
			lv_range = [1, 180]
			},
		#equip_decompose_add{
			stren_lv = 13, 
			goods_list = [{70011,15},{70013,6},{70012,15}], 
			lv_range = [1, 180]
			},
		#equip_decompose_add{
			stren_lv = 14, 
			goods_list = [{70011,15},{70013,10},{70012,15}], 
			lv_range = [1, 180]
			},
		#equip_decompose_add{
			stren_lv = 15, 
			goods_list = [{70011,15},{70013,15},{70012,15}], 
			lv_range = [1, 180]
			},
		#equip_decompose_add{
			stren_lv = 16, 
			goods_list = [{70011,15},{70014,1},{70012,15},{70013,15}], 
			lv_range = [1, 180]
			},
		#equip_decompose_add{
			stren_lv = 17, 
			goods_list = [{70011,15},{70014,3},{70012,15},{70013,15}], 
			lv_range = [1, 180]
			},
		#equip_decompose_add{
			stren_lv = 18, 
			goods_list = [{70011,15},{70014,6},{70012,15},{70013,15}], 
			lv_range = [1, 180]
			},
		#equip_decompose_add{
			stren_lv = 19, 
			goods_list = [{70011,15},{70014,10},{70012,15},{70013,15}], 
			lv_range = [1, 180]
			},
		#equip_decompose_add{
			stren_lv = 20, 
			goods_list = [{70011,15},{70014,15},{70012,15},{70013,15}], 
			lv_range = [1, 180]
			}
	];


get(2) ->
	[
		#equip_decompose_add{
			stren_lv = 1, 
			goods_list = [{70011,1}], 
			lv_range = [200, 220]
			},
		#equip_decompose_add{
			stren_lv = 2, 
			goods_list = [{70011,3}], 
			lv_range = [200, 220]
			},
		#equip_decompose_add{
			stren_lv = 3, 
			goods_list = [{70011,6}], 
			lv_range = [200, 220]
			},
		#equip_decompose_add{
			stren_lv = 4, 
			goods_list = [{70011,10}], 
			lv_range = [200, 220]
			},
		#equip_decompose_add{
			stren_lv = 5, 
			goods_list = [{70011,15}], 
			lv_range = [200, 220]
			},
		#equip_decompose_add{
			stren_lv = 6, 
			goods_list = [{70011,15},{70012,1}], 
			lv_range = [200, 220]
			},
		#equip_decompose_add{
			stren_lv = 7, 
			goods_list = [{70011,15},{70012,3}], 
			lv_range = [200, 220]
			},
		#equip_decompose_add{
			stren_lv = 8, 
			goods_list = [{70011,15},{70012,6}], 
			lv_range = [200, 220]
			},
		#equip_decompose_add{
			stren_lv = 9, 
			goods_list = [{70011,15},{70012,10}], 
			lv_range = [200, 220]
			},
		#equip_decompose_add{
			stren_lv = 10, 
			goods_list = [{70011,15},{70012,15}], 
			lv_range = [200, 220]
			},
		#equip_decompose_add{
			stren_lv = 11, 
			goods_list = [{70011,15},{70013,1},{70012,15}], 
			lv_range = [200, 220]
			},
		#equip_decompose_add{
			stren_lv = 12, 
			goods_list = [{70011,15},{70013,3},{70012,15}], 
			lv_range = [200, 220]
			},
		#equip_decompose_add{
			stren_lv = 13, 
			goods_list = [{70011,15},{70013,6},{70012,15}], 
			lv_range = [200, 220]
			},
		#equip_decompose_add{
			stren_lv = 14, 
			goods_list = [{70011,15},{70013,10},{70012,15}], 
			lv_range = [200, 220]
			},
		#equip_decompose_add{
			stren_lv = 15, 
			goods_list = [{70011,15},{70013,15},{70012,15}], 
			lv_range = [200, 220]
			},
		#equip_decompose_add{
			stren_lv = 16, 
			goods_list = [{70011,15},{70014,1},{70012,15},{70013,15}], 
			lv_range = [200, 220]
			},
		#equip_decompose_add{
			stren_lv = 17, 
			goods_list = [{70011,15},{70014,3},{70012,15},{70013,15}], 
			lv_range = [200, 220]
			},
		#equip_decompose_add{
			stren_lv = 18, 
			goods_list = [{70011,15},{70014,6},{70012,15},{70013,15}], 
			lv_range = [200, 220]
			},
		#equip_decompose_add{
			stren_lv = 19, 
			goods_list = [{70011,15},{70014,10},{70012,15},{70013,15}], 
			lv_range = [200, 220]
			},
		#equip_decompose_add{
			stren_lv = 20, 
			goods_list = [{70011,15},{70014,15},{70012,15},{70013,15}], 
			lv_range = [200, 220]
			},
		#equip_decompose_add{
			stren_lv = 21, 
			goods_list = [{70011,15},{70015,1},{70012,15},{70013,15},{70014,15}], 
			lv_range = [200, 220]
			},
		#equip_decompose_add{
			stren_lv = 22, 
			goods_list = [{70011,15},{70015,3},{70012,15},{70013,15},{70014,15}], 
			lv_range = [200, 220]
			},
		#equip_decompose_add{
			stren_lv = 23, 
			goods_list = [{70011,15},{70015,6},{70012,15},{70013,15},{70014,15}], 
			lv_range = [200, 220]
			},
		#equip_decompose_add{
			stren_lv = 24, 
			goods_list = [{70011,15},{70015,10},{70012,15},{70013,15},{70014,15}], 
			lv_range = [200, 220]
			},
		#equip_decompose_add{
			stren_lv = 25, 
			goods_list = [{70011,15},{70015,15},{70012,15},{70013,15},{70014,15}], 
			lv_range = [200, 220]
			},
		#equip_decompose_add{
			stren_lv = 26, 
			goods_list = [{70011,15},{70015,15},{70012,15},{70013,15},{70014,15},{70016,1}], 
			lv_range = [200, 220]
			},
		#equip_decompose_add{
			stren_lv = 27, 
			goods_list = [{70011,15},{70015,15},{70012,15},{70013,15},{70014,15},{70016,3}], 
			lv_range = [200, 220]
			},
		#equip_decompose_add{
			stren_lv = 28, 
			goods_list = [{70011,15},{70015,15},{70012,15},{70013,15},{70014,15},{70016,6}], 
			lv_range = [200, 220]
			},
		#equip_decompose_add{
			stren_lv = 29, 
			goods_list = [{70011,15},{70015,15},{70012,15},{70013,15},{70014,15},{70016,10}], 
			lv_range = [200, 220]
			},
		#equip_decompose_add{
			stren_lv = 30, 
			goods_list = [{70011,15},{70015,15},{70012,15},{70013,15},{70014,15},{70016,15}], 
			lv_range = [200, 220]
			}
	];


get(3) ->
	[
		#equip_decompose_add{
			stren_lv = 1, 
			goods_list = [{70011,1}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 2, 
			goods_list = [{70011,3}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 3, 
			goods_list = [{70011,6}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 4, 
			goods_list = [{70011,10}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 5, 
			goods_list = [{70011,15}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 6, 
			goods_list = [{70011,15},{70012,1}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 7, 
			goods_list = [{70011,15},{70012,3}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 8, 
			goods_list = [{70011,15},{70012,6}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 9, 
			goods_list = [{70011,15},{70012,10}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 10, 
			goods_list = [{70011,15},{70012,15}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 11, 
			goods_list = [{70011,15},{70013,1},{70012,15}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 12, 
			goods_list = [{70011,15},{70013,3},{70012,15}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 13, 
			goods_list = [{70011,15},{70013,6},{70012,15}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 14, 
			goods_list = [{70011,15},{70013,10},{70012,15}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 15, 
			goods_list = [{70011,15},{70013,15},{70012,15}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 16, 
			goods_list = [{70011,15},{70014,1},{70012,15},{70013,15}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 17, 
			goods_list = [{70011,15},{70014,3},{70012,15},{70013,15}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 18, 
			goods_list = [{70011,15},{70014,6},{70012,15},{70013,15}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 19, 
			goods_list = [{70011,15},{70014,10},{70012,15},{70013,15}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 20, 
			goods_list = [{70011,15},{70014,15},{70012,15},{70013,15}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 21, 
			goods_list = [{70011,15},{70015,1},{70012,15},{70013,15},{70014,15}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 22, 
			goods_list = [{70011,15},{70015,3},{70012,15},{70013,15},{70014,15}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 23, 
			goods_list = [{70011,15},{70015,6},{70012,15},{70013,15},{70014,15}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 24, 
			goods_list = [{70011,15},{70015,10},{70012,15},{70013,15},{70014,15}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 25, 
			goods_list = [{70011,15},{70015,15},{70012,15},{70013,15},{70014,15}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 26, 
			goods_list = [{70011,15},{70015,15},{70012,15},{70013,15},{70014,15},{70016,1}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 27, 
			goods_list = [{70011,15},{70015,15},{70012,15},{70013,15},{70014,15},{70016,3}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 28, 
			goods_list = [{70011,15},{70015,15},{70012,15},{70013,15},{70014,15},{70016,6}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 29, 
			goods_list = [{70011,15},{70015,15},{70012,15},{70013,15},{70014,15},{70016,10}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 30, 
			goods_list = [{70011,15},{70015,15},{70012,15},{70013,15},{70014,15},{70016,15}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 31, 
			goods_list = [{70011,15},{70015,15},{70012,15},{70013,15},{70014,15},{70016,15},{70017,1}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 32, 
			goods_list = [{70011,15},{70015,15},{70012,15},{70013,15},{70014,15},{70016,15},{70017,3}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 33, 
			goods_list = [{70011,15},{70015,15},{70012,15},{70013,15},{70014,15},{70016,15},{70017,6}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 34, 
			goods_list = [{70011,15},{70015,15},{70012,15},{70013,15},{70014,15},{70016,15},{70017,10}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 35, 
			goods_list = [{70011,15},{70015,15},{70012,15},{70013,15},{70014,15},{70016,15},{70017,15}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 36, 
			goods_list = [{70011,15},{70015,15},{70012,15},{70013,15},{70014,15},{70016,15},{70017,15},{70018,1}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 37, 
			goods_list = [{70011,15},{70015,15},{70012,15},{70013,15},{70014,15},{70016,15},{70017,15},{70018,3}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 38, 
			goods_list = [{70011,15},{70015,15},{70012,15},{70013,15},{70014,15},{70016,15},{70017,15},{70018,6}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 39, 
			goods_list = [{70011,15},{70015,15},{70012,15},{70013,15},{70014,15},{70016,15},{70017,15},{70018,10}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 40, 
			goods_list = [{70011,15},{70015,15},{70012,15},{70013,15},{70014,15},{70016,15},{70017,15},{70018,15}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 41, 
			goods_list = [{70011,15},{70015,15},{70012,15},{70013,15},{70014,15},{70016,15},{70017,15},{70018,15},{70019,1}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 42, 
			goods_list = [{70011,15},{70015,15},{70012,15},{70013,15},{70014,15},{70016,15},{70017,15},{70018,15},{70019,3}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 43, 
			goods_list = [{70011,15},{70015,15},{70012,15},{70013,15},{70014,15},{70016,15},{70017,15},{70018,15},{70019,6}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 44, 
			goods_list = [{70011,15},{70015,15},{70012,15},{70013,15},{70014,15},{70016,15},{70017,15},{70018,15},{70019,10}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 45, 
			goods_list = [{70011,15},{70015,15},{70012,15},{70013,15},{70014,15},{70016,15},{70017,15},{70018,15},{70019,15}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 46, 
			goods_list = [{70011,15},{70015,15},{70012,15},{70013,15},{70014,15},{70016,15},{70017,15},{70018,15},{70019,15},{70020,1}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 47, 
			goods_list = [{70011,15},{70015,15},{70012,15},{70013,15},{70014,15},{70016,15},{70017,15},{70018,15},{70019,15},{70020,3}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 48, 
			goods_list = [{70011,15},{70015,15},{70012,15},{70013,15},{70014,15},{70016,15},{70017,15},{70018,15},{70019,15},{70020,6}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 49, 
			goods_list = [{70011,15},{70015,15},{70012,15},{70013,15},{70014,15},{70016,15},{70017,15},{70018,15},{70019,15},{70020,10}], 
			lv_range = [250, 300]
			},
		#equip_decompose_add{
			stren_lv = 50, 
			goods_list = [{70011,15},{70015,15},{70012,15},{70013,15},{70014,15},{70016,15},{70017,15},{70018,15},{70019,15},{70020,15}], 
			lv_range = [250, 300]
			}
	];


get(_No) ->
	?ASSERT(false, _No),
	null.

