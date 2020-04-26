%%%---------------------------------------
%%% @Module  : data_partner_evolve
%%% @Author  : zwq
%%% @Email   : 
%%% @Description:  宠物
%%%---------------------------------------


-module(data_partner_evolve).
-include("common.hrl").
-include("record.hrl").
-include("partner.hrl").
-compile(export_all).

get_all_evolve_no_list()->
	[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49].


				get(1) -> {1, 0}
			;

				get(2) -> {1, 1}
			;

				get(3) -> {1, 2}
			;

				get(4) -> {1, 3}
			;

				get(5) -> {1, 4}
			;

				get(6) -> {1, 5}
			;

				get(7) -> {1, 6}
			;

				get(8) -> {2, 7}
			;

				get(9) -> {2, 8}
			;

				get(10) -> {2, 9}
			;

				get(11) -> {2, 10}
			;

				get(12) -> {2, 11}
			;

				get(13) -> {2, 12}
			;

				get(14) -> {2, 13}
			;

				get(15) -> {3, 14}
			;

				get(16) -> {3, 15}
			;

				get(17) -> {3, 16}
			;

				get(18) -> {3, 17}
			;

				get(19) -> {3, 18}
			;

				get(20) -> {3, 19}
			;

				get(21) -> {3, 20}
			;

				get(22) -> {4, 21}
			;

				get(23) -> {4, 22}
			;

				get(24) -> {4, 23}
			;

				get(25) -> {4, 24}
			;

				get(26) -> {4, 25}
			;

				get(27) -> {4, 26}
			;

				get(28) -> {4, 27}
			;

				get(29) -> {5, 28}
			;

				get(30) -> {5, 29}
			;

				get(31) -> {5, 30}
			;

				get(32) -> {5, 31}
			;

				get(33) -> {5, 32}
			;

				get(34) -> {5, 33}
			;

				get(35) -> {5, 34}
			;

				get(36) -> {6, 35}
			;

				get(37) -> {6, 36}
			;

				get(38) -> {6, 37}
			;

				get(39) -> {6, 38}
			;

				get(40) -> {6, 39}
			;

				get(41) -> {6, 40}
			;

				get(42) -> {6, 41}
			;

				get(43) -> {6, 42}
			;

				get(44) -> {6, 43}
			;

				get(45) -> {6, 44}
			;

				get(46) -> {6, 45}
			;

				get(47) -> {6, 46}
			;

				get(48) -> {6, 47}
			;

				get(49) -> {6, 48}
			;

				get(_No) ->
					null.
		
get(1,0) ->
	#partner_evolve{
		no = 1,
		quality = 1,
		lv = 0,
		evolve = 0,
		evolve_support = 2,
		par_lv_need = 1,
		intimacy_lv = 1,
		consume_goods = [{50307,0}],
		bind_yuanbao = {1,0},
		grow_add = 0,
		free_get_goods_1 = [{50307,0}],
		free_get_goods_2 = [{50307,0}],
		free_get_goods_3 = [{50307,0}],
		free_get_goods_4 = [{50307,0}],
		free_get_goods_5 = [{50307,0}],
		free_get_goods_6 = [{50307,0}],
		free_get_goods_7 = [{50307,0}]
};

get(1,1) ->
	#partner_evolve{
		no = 2,
		quality = 1,
		lv = 1,
		evolve = 2,
		evolve_support = 4,
		par_lv_need = 1,
		intimacy_lv = 1,
		consume_goods = [{50307,3}],
		bind_yuanbao = {1,0},
		grow_add = 0.040000,
		free_get_goods_1 = [{50307,3}],
		free_get_goods_2 = [{50307,3}],
		free_get_goods_3 = [{50307,3}],
		free_get_goods_4 = [{50307,3}],
		free_get_goods_5 = [{50307,3}],
		free_get_goods_6 = [{50307,3}],
		free_get_goods_7 = [{50307,3}]
};

get(1,2) ->
	#partner_evolve{
		no = 3,
		quality = 1,
		lv = 2,
		evolve = 4,
		evolve_support = 6,
		par_lv_need = 1,
		intimacy_lv = 1,
		consume_goods = [{50307,6}],
		bind_yuanbao = {1,0},
		grow_add = 0.080000,
		free_get_goods_1 = [{50307,9}],
		free_get_goods_2 = [{50307,9}],
		free_get_goods_3 = [{50307,9}],
		free_get_goods_4 = [{50307,9}],
		free_get_goods_5 = [{50307,9}],
		free_get_goods_6 = [{50307,9}],
		free_get_goods_7 = [{50307,9}]
};

get(1,3) ->
	#partner_evolve{
		no = 4,
		quality = 1,
		lv = 3,
		evolve = 6,
		evolve_support = 8,
		par_lv_need = 1,
		intimacy_lv = 1,
		consume_goods = [{50307,10}],
		bind_yuanbao = {1,0},
		grow_add = 0.120000,
		free_get_goods_1 = [{50307,19}],
		free_get_goods_2 = [{50307,19}],
		free_get_goods_3 = [{50307,19}],
		free_get_goods_4 = [{50307,19}],
		free_get_goods_5 = [{50307,19}],
		free_get_goods_6 = [{50307,19}],
		free_get_goods_7 = [{50307,19}]
};

get(1,4) ->
	#partner_evolve{
		no = 5,
		quality = 1,
		lv = 4,
		evolve = 8,
		evolve_support = 10,
		par_lv_need = 1,
		intimacy_lv = 1,
		consume_goods = [{50307,14}],
		bind_yuanbao = {1,0},
		grow_add = 0.160000,
		free_get_goods_1 = [{50307,33}],
		free_get_goods_2 = [{50307,33}],
		free_get_goods_3 = [{50307,33}],
		free_get_goods_4 = [{50307,33}],
		free_get_goods_5 = [{50307,33}],
		free_get_goods_6 = [{50307,33}],
		free_get_goods_7 = [{50307,33}]
};

get(1,5) ->
	#partner_evolve{
		no = 6,
		quality = 1,
		lv = 5,
		evolve = 10,
		evolve_support = 12,
		par_lv_need = 1,
		intimacy_lv = 1,
		consume_goods = [{50307,20}],
		bind_yuanbao = {1,0},
		grow_add = 0.200000,
		free_get_goods_1 = [{50307,53}],
		free_get_goods_2 = [{50307,53}],
		free_get_goods_3 = [{50307,53}],
		free_get_goods_4 = [{50307,53}],
		free_get_goods_5 = [{50307,53}],
		free_get_goods_6 = [{50307,53}],
		free_get_goods_7 = [{50307,53}]
};

get(1,6) ->
	#partner_evolve{
		no = 7,
		quality = 1,
		lv = 6,
		evolve = 15,
		evolve_support = 17,
		par_lv_need = 1,
		intimacy_lv = 1,
		consume_goods = [{50307,26}],
		bind_yuanbao = {1,0},
		grow_add = 0.240000,
		free_get_goods_1 = [{50307,79}],
		free_get_goods_2 = [{50307,79}],
		free_get_goods_3 = [{50307,79}],
		free_get_goods_4 = [{50307,79}],
		free_get_goods_5 = [{50307,79}],
		free_get_goods_6 = [{50307,79}],
		free_get_goods_7 = [{50307,79}]
};

get(2,7) ->
	#partner_evolve{
		no = 8,
		quality = 2,
		lv = 7,
		evolve = 20,
		evolve_support = 22,
		par_lv_need = 80,
		intimacy_lv = 1,
		consume_goods = [{50307,34}],
		bind_yuanbao = {1,0},
		grow_add = 0.280000,
		free_get_goods_1 = [{50307,113}],
		free_get_goods_2 = [{50307,113}],
		free_get_goods_3 = [{50307,113}],
		free_get_goods_4 = [{50307,113}],
		free_get_goods_5 = [{50307,113}],
		free_get_goods_6 = [{50307,113}],
		free_get_goods_7 = [{50307,113}]
};

get(2,8) ->
	#partner_evolve{
		no = 9,
		quality = 2,
		lv = 8,
		evolve = 25,
		evolve_support = 27,
		par_lv_need = 80,
		intimacy_lv = 1,
		consume_goods = [{50307,43}],
		bind_yuanbao = {1,0},
		grow_add = 0.320000,
		free_get_goods_1 = [{50307,156}],
		free_get_goods_2 = [{50307,156}],
		free_get_goods_3 = [{50307,156}],
		free_get_goods_4 = [{50307,156}],
		free_get_goods_5 = [{50307,156}],
		free_get_goods_6 = [{50307,156}],
		free_get_goods_7 = [{50307,156}]
};

get(2,9) ->
	#partner_evolve{
		no = 10,
		quality = 2,
		lv = 9,
		evolve = 30,
		evolve_support = 32,
		par_lv_need = 80,
		intimacy_lv = 1,
		consume_goods = [{50307,53}],
		bind_yuanbao = {1,0},
		grow_add = 0.360000,
		free_get_goods_1 = [{50307,209}],
		free_get_goods_2 = [{50307,209}],
		free_get_goods_3 = [{50307,209}],
		free_get_goods_4 = [{50307,209}],
		free_get_goods_5 = [{50307,209}],
		free_get_goods_6 = [{50307,209}],
		free_get_goods_7 = [{50307,209}]
};

get(2,10) ->
	#partner_evolve{
		no = 11,
		quality = 2,
		lv = 10,
		evolve = 35,
		evolve_support = 37,
		par_lv_need = 80,
		intimacy_lv = 1,
		consume_goods = [{50307,64}],
		bind_yuanbao = {1,0},
		grow_add = 0.400000,
		free_get_goods_1 = [{50307,273}],
		free_get_goods_2 = [{50307,273}],
		free_get_goods_3 = [{50307,273}],
		free_get_goods_4 = [{50307,273}],
		free_get_goods_5 = [{50307,273}],
		free_get_goods_6 = [{50307,273}],
		free_get_goods_7 = [{50307,273}]
};

get(2,11) ->
	#partner_evolve{
		no = 12,
		quality = 2,
		lv = 11,
		evolve = 40,
		evolve_support = 42,
		par_lv_need = 80,
		intimacy_lv = 1,
		consume_goods = [{50307,76}],
		bind_yuanbao = {1,0},
		grow_add = 0.440000,
		free_get_goods_1 = [{50307,349}],
		free_get_goods_2 = [{50307,349}],
		free_get_goods_3 = [{50307,349}],
		free_get_goods_4 = [{50307,349}],
		free_get_goods_5 = [{50307,349}],
		free_get_goods_6 = [{50307,349}],
		free_get_goods_7 = [{50307,349}]
};

get(2,12) ->
	#partner_evolve{
		no = 13,
		quality = 2,
		lv = 12,
		evolve = 50,
		evolve_support = 52,
		par_lv_need = 80,
		intimacy_lv = 1,
		consume_goods = [{50307,90}],
		bind_yuanbao = {1,0},
		grow_add = 0.480000,
		free_get_goods_1 = [{50307,439}],
		free_get_goods_2 = [{50307,439}],
		free_get_goods_3 = [{50307,439}],
		free_get_goods_4 = [{50307,439}],
		free_get_goods_5 = [{50307,439}],
		free_get_goods_6 = [{50307,439}],
		free_get_goods_7 = [{50307,439}]
};

get(2,13) ->
	#partner_evolve{
		no = 14,
		quality = 2,
		lv = 13,
		evolve = 60,
		evolve_support = 62,
		par_lv_need = 80,
		intimacy_lv = 1,
		consume_goods = [{50307,105}],
		bind_yuanbao = {1,0},
		grow_add = 0.520000,
		free_get_goods_1 = [{50307,544}],
		free_get_goods_2 = [{50307,544}],
		free_get_goods_3 = [{50307,544}],
		free_get_goods_4 = [{50307,544}],
		free_get_goods_5 = [{50307,544}],
		free_get_goods_6 = [{50307,544}],
		free_get_goods_7 = [{50307,544}]
};

get(3,14) ->
	#partner_evolve{
		no = 15,
		quality = 3,
		lv = 14,
		evolve = 70,
		evolve_support = 72,
		par_lv_need = 80,
		intimacy_lv = 1,
		consume_goods = [{50307,121}],
		bind_yuanbao = {1,0},
		grow_add = 0.560000,
		free_get_goods_1 = [{50307,665}],
		free_get_goods_2 = [{50307,665}],
		free_get_goods_3 = [{50307,665}],
		free_get_goods_4 = [{50307,665}],
		free_get_goods_5 = [{50307,665}],
		free_get_goods_6 = [{50307,665}],
		free_get_goods_7 = [{50307,665}]
};

get(3,15) ->
	#partner_evolve{
		no = 16,
		quality = 3,
		lv = 15,
		evolve = 80,
		evolve_support = 82,
		par_lv_need = 80,
		intimacy_lv = 1,
		consume_goods = [{50307,139}],
		bind_yuanbao = {1,0},
		grow_add = 0.600000,
		free_get_goods_1 = [{50307,804}],
		free_get_goods_2 = [{50307,804}],
		free_get_goods_3 = [{50307,804}],
		free_get_goods_4 = [{50307,804}],
		free_get_goods_5 = [{50307,804}],
		free_get_goods_6 = [{50307,804}],
		free_get_goods_7 = [{50307,804}]
};

get(3,16) ->
	#partner_evolve{
		no = 17,
		quality = 3,
		lv = 16,
		evolve = 90,
		evolve_support = 92,
		par_lv_need = 80,
		intimacy_lv = 1,
		consume_goods = [{50307,158}],
		bind_yuanbao = {1,0},
		grow_add = 0.640000,
		free_get_goods_1 = [{50307,962}],
		free_get_goods_2 = [{50307,962}],
		free_get_goods_3 = [{50307,962}],
		free_get_goods_4 = [{50307,962}],
		free_get_goods_5 = [{50307,962}],
		free_get_goods_6 = [{50307,962}],
		free_get_goods_7 = [{50307,962}]
};

get(3,17) ->
	#partner_evolve{
		no = 18,
		quality = 3,
		lv = 17,
		evolve = 100,
		evolve_support = 102,
		par_lv_need = 80,
		intimacy_lv = 1,
		consume_goods = [{50307,178}],
		bind_yuanbao = {1,0},
		grow_add = 0.680000,
		free_get_goods_1 = [{50307,1140}],
		free_get_goods_2 = [{50307,1140}],
		free_get_goods_3 = [{50307,1140}],
		free_get_goods_4 = [{50307,1140}],
		free_get_goods_5 = [{50307,1140}],
		free_get_goods_6 = [{50307,1140}],
		free_get_goods_7 = [{50307,1140}]
};

get(3,18) ->
	#partner_evolve{
		no = 19,
		quality = 3,
		lv = 18,
		evolve = 120,
		evolve_support = 122,
		par_lv_need = 80,
		intimacy_lv = 1,
		consume_goods = [{50307,200}],
		bind_yuanbao = {1,0},
		grow_add = 0.720000,
		free_get_goods_1 = [{50307,1340}],
		free_get_goods_2 = [{50307,1340}],
		free_get_goods_3 = [{50307,1340}],
		free_get_goods_4 = [{50307,1340}],
		free_get_goods_5 = [{50307,1340}],
		free_get_goods_6 = [{50307,1340}],
		free_get_goods_7 = [{50307,1340}]
};

get(3,19) ->
	#partner_evolve{
		no = 20,
		quality = 3,
		lv = 19,
		evolve = 140,
		evolve_support = 142,
		par_lv_need = 80,
		intimacy_lv = 1,
		consume_goods = [{50307,223}],
		bind_yuanbao = {1,0},
		grow_add = 0.760000,
		free_get_goods_1 = [{50307,1563}],
		free_get_goods_2 = [{50307,1563}],
		free_get_goods_3 = [{50307,1563}],
		free_get_goods_4 = [{50307,1563}],
		free_get_goods_5 = [{50307,1563}],
		free_get_goods_6 = [{50307,1563}],
		free_get_goods_7 = [{50307,1563}]
};

get(3,20) ->
	#partner_evolve{
		no = 21,
		quality = 3,
		lv = 20,
		evolve = 160,
		evolve_support = 162,
		par_lv_need = 80,
		intimacy_lv = 1,
		consume_goods = [{50307,248}],
		bind_yuanbao = {1,0},
		grow_add = 0.800000,
		free_get_goods_1 = [{50307,1811}],
		free_get_goods_2 = [{50307,1811}],
		free_get_goods_3 = [{50307,1811}],
		free_get_goods_4 = [{50307,1811}],
		free_get_goods_5 = [{50307,1811}],
		free_get_goods_6 = [{50307,1811}],
		free_get_goods_7 = [{50307,1811}]
};

get(4,21) ->
	#partner_evolve{
		no = 22,
		quality = 4,
		lv = 21,
		evolve = 180,
		evolve_support = 182,
		par_lv_need = 80,
		intimacy_lv = 1,
		consume_goods = [{50307,274}],
		bind_yuanbao = {1,0},
		grow_add = 0.840000,
		free_get_goods_1 = [{50307,2085}],
		free_get_goods_2 = [{50307,2085}],
		free_get_goods_3 = [{50307,2085}],
		free_get_goods_4 = [{50307,2085}],
		free_get_goods_5 = [{50307,2085}],
		free_get_goods_6 = [{50307,2085}],
		free_get_goods_7 = [{50307,2085}]
};

get(4,22) ->
	#partner_evolve{
		no = 23,
		quality = 4,
		lv = 22,
		evolve = 200,
		evolve_support = 202,
		par_lv_need = 80,
		intimacy_lv = 1,
		consume_goods = [{50307,301}],
		bind_yuanbao = {1,0},
		grow_add = 0.880000,
		free_get_goods_1 = [{50307,2386}],
		free_get_goods_2 = [{50307,2386}],
		free_get_goods_3 = [{50307,2386}],
		free_get_goods_4 = [{50307,2386}],
		free_get_goods_5 = [{50307,2386}],
		free_get_goods_6 = [{50307,2386}],
		free_get_goods_7 = [{50307,2386}]
};

get(4,23) ->
	#partner_evolve{
		no = 24,
		quality = 4,
		lv = 23,
		evolve = 220,
		evolve_support = 222,
		par_lv_need = 80,
		intimacy_lv = 1,
		consume_goods = [{50307,330}],
		bind_yuanbao = {1,0},
		grow_add = 0.920000,
		free_get_goods_1 = [{50307,2716}],
		free_get_goods_2 = [{50307,2716}],
		free_get_goods_3 = [{50307,2716}],
		free_get_goods_4 = [{50307,2716}],
		free_get_goods_5 = [{50307,2716}],
		free_get_goods_6 = [{50307,2716}],
		free_get_goods_7 = [{50307,2716}]
};

get(4,24) ->
	#partner_evolve{
		no = 25,
		quality = 4,
		lv = 24,
		evolve = 240,
		evolve_support = 242,
		par_lv_need = 80,
		intimacy_lv = 1,
		consume_goods = [{50307,360}],
		bind_yuanbao = {1,0},
		grow_add = 0.960000,
		free_get_goods_1 = [{50307,3076}],
		free_get_goods_2 = [{50307,3076}],
		free_get_goods_3 = [{50307,3076}],
		free_get_goods_4 = [{50307,3076}],
		free_get_goods_5 = [{50307,3076}],
		free_get_goods_6 = [{50307,3076}],
		free_get_goods_7 = [{50307,3076}]
};

get(4,25) ->
	#partner_evolve{
		no = 26,
		quality = 4,
		lv = 25,
		evolve = 260,
		evolve_support = 262,
		par_lv_need = 80,
		intimacy_lv = 1,
		consume_goods = [{50307,392}],
		bind_yuanbao = {1,0},
		grow_add = 1,
		free_get_goods_1 = [{50307,3468}],
		free_get_goods_2 = [{50307,3468}],
		free_get_goods_3 = [{50307,3468}],
		free_get_goods_4 = [{50307,3468}],
		free_get_goods_5 = [{50307,3468}],
		free_get_goods_6 = [{50307,3468}],
		free_get_goods_7 = [{50307,3468}]
};

get(4,26) ->
	#partner_evolve{
		no = 27,
		quality = 4,
		lv = 26,
		evolve = 280,
		evolve_support = 282,
		par_lv_need = 80,
		intimacy_lv = 1,
		consume_goods = [{50307,426}],
		bind_yuanbao = {1,0},
		grow_add = 1.040000,
		free_get_goods_1 = [{50307,3894}],
		free_get_goods_2 = [{50307,3894}],
		free_get_goods_3 = [{50307,3894}],
		free_get_goods_4 = [{50307,3894}],
		free_get_goods_5 = [{50307,3894}],
		free_get_goods_6 = [{50307,3894}],
		free_get_goods_7 = [{50307,3894}]
};

get(4,27) ->
	#partner_evolve{
		no = 28,
		quality = 4,
		lv = 27,
		evolve = 300,
		evolve_support = 302,
		par_lv_need = 80,
		intimacy_lv = 1,
		consume_goods = [{50307,461}],
		bind_yuanbao = {1,0},
		grow_add = 1.080000,
		free_get_goods_1 = [{50307,4355}],
		free_get_goods_2 = [{50307,4355}],
		free_get_goods_3 = [{50307,4355}],
		free_get_goods_4 = [{50307,4355}],
		free_get_goods_5 = [{50307,4355}],
		free_get_goods_6 = [{50307,4355}],
		free_get_goods_7 = [{50307,4355}]
};

get(5,28) ->
	#partner_evolve{
		no = 29,
		quality = 5,
		lv = 28,
		evolve = 320,
		evolve_support = 322,
		par_lv_need = 80,
		intimacy_lv = 1,
		consume_goods = [{50307,498}],
		bind_yuanbao = {1,0},
		grow_add = 1.120000,
		free_get_goods_1 = [{50307,4853}],
		free_get_goods_2 = [{50307,4853}],
		free_get_goods_3 = [{50307,4853}],
		free_get_goods_4 = [{50307,4853}],
		free_get_goods_5 = [{50307,4853}],
		free_get_goods_6 = [{50307,4853}],
		free_get_goods_7 = [{50307,4853}]
};

get(5,29) ->
	#partner_evolve{
		no = 30,
		quality = 5,
		lv = 29,
		evolve = 340,
		evolve_support = 342,
		par_lv_need = 80,
		intimacy_lv = 1,
		consume_goods = [{50307,536}],
		bind_yuanbao = {1,0},
		grow_add = 1.160000,
		free_get_goods_1 = [{50307,5389}],
		free_get_goods_2 = [{50307,5389}],
		free_get_goods_3 = [{50307,5389}],
		free_get_goods_4 = [{50307,5389}],
		free_get_goods_5 = [{50307,5389}],
		free_get_goods_6 = [{50307,5389}],
		free_get_goods_7 = [{50307,5389}]
};

get(5,30) ->
	#partner_evolve{
		no = 31,
		quality = 5,
		lv = 30,
		evolve = 360,
		evolve_support = 362,
		par_lv_need = 80,
		intimacy_lv = 1,
		consume_goods = [{50307,576}],
		bind_yuanbao = {1,0},
		grow_add = 1.200000,
		free_get_goods_1 = [{50307,5965}],
		free_get_goods_2 = [{50307,5965}],
		free_get_goods_3 = [{50307,5965}],
		free_get_goods_4 = [{50307,5965}],
		free_get_goods_5 = [{50307,5965}],
		free_get_goods_6 = [{50307,5965}],
		free_get_goods_7 = [{50307,5965}]
};

get(5,31) ->
	#partner_evolve{
		no = 32,
		quality = 5,
		lv = 31,
		evolve = 380,
		evolve_support = 382,
		par_lv_need = 80,
		intimacy_lv = 1,
		consume_goods = [{50307,618}],
		bind_yuanbao = {1,0},
		grow_add = 1.240000,
		free_get_goods_1 = [{50307,6583}],
		free_get_goods_2 = [{50307,6583}],
		free_get_goods_3 = [{50307,6583}],
		free_get_goods_4 = [{50307,6583}],
		free_get_goods_5 = [{50307,6583}],
		free_get_goods_6 = [{50307,6583}],
		free_get_goods_7 = [{50307,6583}]
};

get(5,32) ->
	#partner_evolve{
		no = 33,
		quality = 5,
		lv = 32,
		evolve = 400,
		evolve_support = 402,
		par_lv_need = 80,
		intimacy_lv = 1,
		consume_goods = [{50307,661}],
		bind_yuanbao = {1,0},
		grow_add = 1.280000,
		free_get_goods_1 = [{50307,7244}],
		free_get_goods_2 = [{50307,7244}],
		free_get_goods_3 = [{50307,7244}],
		free_get_goods_4 = [{50307,7244}],
		free_get_goods_5 = [{50307,7244}],
		free_get_goods_6 = [{50307,7244}],
		free_get_goods_7 = [{50307,7244}]
};

get(5,33) ->
	#partner_evolve{
		no = 34,
		quality = 5,
		lv = 33,
		evolve = 420,
		evolve_support = 422,
		par_lv_need = 80,
		intimacy_lv = 1,
		consume_goods = [{50307,706}],
		bind_yuanbao = {1,0},
		grow_add = 1.320000,
		free_get_goods_1 = [{50307,7950}],
		free_get_goods_2 = [{50307,7950}],
		free_get_goods_3 = [{50307,7950}],
		free_get_goods_4 = [{50307,7950}],
		free_get_goods_5 = [{50307,7950}],
		free_get_goods_6 = [{50307,7950}],
		free_get_goods_7 = [{50307,7950}]
};

get(5,34) ->
	#partner_evolve{
		no = 35,
		quality = 5,
		lv = 34,
		evolve = 440,
		evolve_support = 442,
		par_lv_need = 80,
		intimacy_lv = 1,
		consume_goods = [{50307,752}],
		bind_yuanbao = {1,0},
		grow_add = 1.360000,
		free_get_goods_1 = [{50307,8702}],
		free_get_goods_2 = [{50307,8702}],
		free_get_goods_3 = [{50307,8702}],
		free_get_goods_4 = [{50307,8702}],
		free_get_goods_5 = [{50307,8702}],
		free_get_goods_6 = [{50307,8702}],
		free_get_goods_7 = [{50307,8702}]
};

get(6,35) ->
	#partner_evolve{
		no = 36,
		quality = 6,
		lv = 35,
		evolve = 460,
		evolve_support = 462,
		par_lv_need = 80,
		intimacy_lv = 1,
		consume_goods = [{50307,800}],
		bind_yuanbao = {1,0},
		grow_add = 1.400000,
		free_get_goods_1 = [{50307,9502}],
		free_get_goods_2 = [{50307,9502}],
		free_get_goods_3 = [{50307,9502}],
		free_get_goods_4 = [{50307,9502}],
		free_get_goods_5 = [{50307,9502}],
		free_get_goods_6 = [{50307,9502}],
		free_get_goods_7 = [{50307,9502}]
};

get(6,36) ->
	#partner_evolve{
		no = 37,
		quality = 6,
		lv = 36,
		evolve = 480,
		evolve_support = 482,
		par_lv_need = 80,
		intimacy_lv = 1,
		consume_goods = [{50307,850}],
		bind_yuanbao = {1,0},
		grow_add = 1.440000,
		free_get_goods_1 = [{50307,10352}],
		free_get_goods_2 = [{50307,10352}],
		free_get_goods_3 = [{50307,10352}],
		free_get_goods_4 = [{50307,10352}],
		free_get_goods_5 = [{50307,10352}],
		free_get_goods_6 = [{50307,10352}],
		free_get_goods_7 = [{50307,10352}]
};

get(6,37) ->
	#partner_evolve{
		no = 38,
		quality = 6,
		lv = 37,
		evolve = 500,
		evolve_support = 502,
		par_lv_need = 80,
		intimacy_lv = 1,
		consume_goods = [{50307,902}],
		bind_yuanbao = {1,0},
		grow_add = 1.480000,
		free_get_goods_1 = [{50307,11254}],
		free_get_goods_2 = [{50307,11254}],
		free_get_goods_3 = [{50307,11254}],
		free_get_goods_4 = [{50307,11254}],
		free_get_goods_5 = [{50307,11254}],
		free_get_goods_6 = [{50307,11254}],
		free_get_goods_7 = [{50307,11254}]
};

get(6,38) ->
	#partner_evolve{
		no = 39,
		quality = 6,
		lv = 38,
		evolve = 520,
		evolve_support = 522,
		par_lv_need = 80,
		intimacy_lv = 1,
		consume_goods = [{50307,955}],
		bind_yuanbao = {1,0},
		grow_add = 1.520000,
		free_get_goods_1 = [{50307,12209}],
		free_get_goods_2 = [{50307,12209}],
		free_get_goods_3 = [{50307,12209}],
		free_get_goods_4 = [{50307,12209}],
		free_get_goods_5 = [{50307,12209}],
		free_get_goods_6 = [{50307,12209}],
		free_get_goods_7 = [{50307,12209}]
};

get(6,39) ->
	#partner_evolve{
		no = 40,
		quality = 6,
		lv = 39,
		evolve = 540,
		evolve_support = 542,
		par_lv_need = 80,
		intimacy_lv = 1,
		consume_goods = [{50307,1010}],
		bind_yuanbao = {1,0},
		grow_add = 1.560000,
		free_get_goods_1 = [{50307,13219}],
		free_get_goods_2 = [{50307,13219}],
		free_get_goods_3 = [{50307,13219}],
		free_get_goods_4 = [{50307,13219}],
		free_get_goods_5 = [{50307,13219}],
		free_get_goods_6 = [{50307,13219}],
		free_get_goods_7 = [{50307,13219}]
};

get(6,40) ->
	#partner_evolve{
		no = 41,
		quality = 6,
		lv = 40,
		evolve = 560,
		evolve_support = 562,
		par_lv_need = 80,
		intimacy_lv = 1,
		consume_goods = [{50307,1067}],
		bind_yuanbao = {1,0},
		grow_add = 1.600000,
		free_get_goods_1 = [{50307,14286}],
		free_get_goods_2 = [{50307,14286}],
		free_get_goods_3 = [{50307,14286}],
		free_get_goods_4 = [{50307,14286}],
		free_get_goods_5 = [{50307,14286}],
		free_get_goods_6 = [{50307,14286}],
		free_get_goods_7 = [{50307,14286}]
};

get(6,41) ->
	#partner_evolve{
		no = 42,
		quality = 6,
		lv = 41,
		evolve = 580,
		evolve_support = 582,
		par_lv_need = 80,
		intimacy_lv = 1,
		consume_goods = [{50307,1126}],
		bind_yuanbao = {1,0},
		grow_add = 1.640000,
		free_get_goods_1 = [{50307,15412}],
		free_get_goods_2 = [{50307,15412}],
		free_get_goods_3 = [{50307,15412}],
		free_get_goods_4 = [{50307,15412}],
		free_get_goods_5 = [{50307,15412}],
		free_get_goods_6 = [{50307,15412}],
		free_get_goods_7 = [{50307,15412}]
};

get(6,42) ->
	#partner_evolve{
		no = 43,
		quality = 6,
		lv = 42,
		evolve = 600,
		evolve_support = 602,
		par_lv_need = 80,
		intimacy_lv = 1,
		consume_goods = [{50307,1186}],
		bind_yuanbao = {1,0},
		grow_add = 1.680000,
		free_get_goods_1 = [{50307,16598}],
		free_get_goods_2 = [{50307,16598}],
		free_get_goods_3 = [{50307,16598}],
		free_get_goods_4 = [{50307,16598}],
		free_get_goods_5 = [{50307,16598}],
		free_get_goods_6 = [{50307,16598}],
		free_get_goods_7 = [{50307,16598}]
};

get(6,43) ->
	#partner_evolve{
		no = 44,
		quality = 6,
		lv = 43,
		evolve = 620,
		evolve_support = 622,
		par_lv_need = 80,
		intimacy_lv = 1,
		consume_goods = [{50307,1248}],
		bind_yuanbao = {1,0},
		grow_add = 1.720000,
		free_get_goods_1 = [{50307,17846}],
		free_get_goods_2 = [{50307,17846}],
		free_get_goods_3 = [{50307,17846}],
		free_get_goods_4 = [{50307,17846}],
		free_get_goods_5 = [{50307,17846}],
		free_get_goods_6 = [{50307,17846}],
		free_get_goods_7 = [{50307,17846}]
};

get(6,44) ->
	#partner_evolve{
		no = 45,
		quality = 6,
		lv = 44,
		evolve = 640,
		evolve_support = 642,
		par_lv_need = 80,
		intimacy_lv = 1,
		consume_goods = [{50307,1312}],
		bind_yuanbao = {1,0},
		grow_add = 1.760000,
		free_get_goods_1 = [{50307,19158}],
		free_get_goods_2 = [{50307,19158}],
		free_get_goods_3 = [{50307,19158}],
		free_get_goods_4 = [{50307,19158}],
		free_get_goods_5 = [{50307,19158}],
		free_get_goods_6 = [{50307,19158}],
		free_get_goods_7 = [{50307,19158}]
};

get(6,45) ->
	#partner_evolve{
		no = 46,
		quality = 6,
		lv = 45,
		evolve = 660,
		evolve_support = 662,
		par_lv_need = 80,
		intimacy_lv = 1,
		consume_goods = [{50307,1378}],
		bind_yuanbao = {1,0},
		grow_add = 1.800000,
		free_get_goods_1 = [{50307,20536}],
		free_get_goods_2 = [{50307,20536}],
		free_get_goods_3 = [{50307,20536}],
		free_get_goods_4 = [{50307,20536}],
		free_get_goods_5 = [{50307,20536}],
		free_get_goods_6 = [{50307,20536}],
		free_get_goods_7 = [{50307,20536}]
};

get(6,46) ->
	#partner_evolve{
		no = 47,
		quality = 6,
		lv = 46,
		evolve = 680,
		evolve_support = 682,
		par_lv_need = 80,
		intimacy_lv = 1,
		consume_goods = [{50307,1446}],
		bind_yuanbao = {1,0},
		grow_add = 1.840000,
		free_get_goods_1 = [{50307,21982}],
		free_get_goods_2 = [{50307,21982}],
		free_get_goods_3 = [{50307,21982}],
		free_get_goods_4 = [{50307,21982}],
		free_get_goods_5 = [{50307,21982}],
		free_get_goods_6 = [{50307,21982}],
		free_get_goods_7 = [{50307,21982}]
};

get(6,47) ->
	#partner_evolve{
		no = 48,
		quality = 6,
		lv = 47,
		evolve = 700,
		evolve_support = 702,
		par_lv_need = 80,
		intimacy_lv = 1,
		consume_goods = [{50307,1515}],
		bind_yuanbao = {1,0},
		grow_add = 1.880000,
		free_get_goods_1 = [{50307,23497}],
		free_get_goods_2 = [{50307,23497}],
		free_get_goods_3 = [{50307,23497}],
		free_get_goods_4 = [{50307,23497}],
		free_get_goods_5 = [{50307,23497}],
		free_get_goods_6 = [{50307,23497}],
		free_get_goods_7 = [{50307,23497}]
};

get(6,48) ->
	#partner_evolve{
		no = 49,
		quality = 6,
		lv = 48,
		evolve = 720,
		evolve_support = 722,
		par_lv_need = 80,
		intimacy_lv = 1,
		consume_goods = [{50307,1586}],
		bind_yuanbao = {1,0},
		grow_add = 1.920000,
		free_get_goods_1 = [{50307,25083}],
		free_get_goods_2 = [{50307,25083}],
		free_get_goods_3 = [{50307,25083}],
		free_get_goods_4 = [{50307,25083}],
		free_get_goods_5 = [{50307,25083}],
		free_get_goods_6 = [{50307,25083}],
		free_get_goods_7 = [{50307,25083}]
};

get(_Quality, _Lv) ->
          null.

