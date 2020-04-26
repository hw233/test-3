%%%---------------------------------------
%%% @Module  : data_goods_eff
%%% @Author  : zwq
%%% @Email   : 
%%% @Description:  物品效果
%%%---------------------------------------


-module(data_goods_eff).
-include("effect.hrl").
-include("debug.hrl").
-compile(export_all).

get(1) ->
	#goods_eff{
		no = 1,
		name = add_hp_by_rate,
		trigger_proba = 100,
		para = 0.100000
};

get(2) ->
	#goods_eff{
		no = 2,
		name = revive_and_add_hp,
		trigger_proba = 100,
		para = 10000
};

get(3) ->
	#goods_eff{
		no = 3,
		name = add_anger,
		trigger_proba = 100,
		para = 10
};

get(4) ->
	#goods_eff{
		no = 4,
		name = clearance_and_add_hp_by_quality,
		trigger_proba = 100,
		para = {5000,1,{by_no_list, [401,405,406,2401,2410,10003,10008,10103,10108,10203,10229,10315,10317,10319,13007,13030,13107,13130,13221,13222,13321,13322,13421,13422,13521,13522,13607,13630,13707,13730,50001,50004,50006,50010,50014,50015,50019,50020,50021,50023,50024,50025,50026,50103,50128]}}
};

get(5) ->
	#goods_eff{
		no = 5,
		name = add_mp,
		trigger_proba = 100,
		para = 10
};

get(6) ->
	#goods_eff{
		no = 6,
		name = add_mp,
		trigger_proba = 100,
		para = 20
};

get(7) ->
	#goods_eff{
		no = 7,
		name = add_mp,
		trigger_proba = 100,
		para = 30
};

get(8) ->
	#goods_eff{
		no = 8,
		name = add_mp_by_rate,
		trigger_proba = 100,
		para = 0.250000
};

get(9) ->
	#goods_eff{
		no = 9,
		name = teleport,
		trigger_proba = 100,
		para = 1
};

get(10) ->
	#goods_eff{
		no = 10,
		name = add_buff,
		trigger_proba = 100,
		para = 100000
};

get(11) ->
	#goods_eff{
		no = 11,
		name = reactivate_trap,
		trigger_proba = 100,
		para = 0
};

get(12) ->
	#goods_eff{
		no = 12,
		name = get_partner,
		trigger_proba = 100,
		para = 1001
};

get(13) ->
	#goods_eff{
		no = 13,
		name = get_partner,
		trigger_proba = 100,
		para = 2001
};

get(14) ->
	#goods_eff{
		no = 14,
		name = get_partner,
		trigger_proba = 100,
		para = 3001
};

get(15) ->
	#goods_eff{
		no = 15,
		name = get_partner,
		trigger_proba = 100,
		para = 4001
};

get(16) ->
	#goods_eff{
		no = 16,
		name = get_partner,
		trigger_proba = 100,
		para = 5001
};

get(17) ->
	#goods_eff{
		no = 17,
		name = get_partner,
		trigger_proba = 100,
		para = 6001
};

get(18) ->
	#goods_eff{
		no = 18,
		name = get_partner,
		trigger_proba = 100,
		para = 1002
};

get(19) ->
	#goods_eff{
		no = 19,
		name = get_partner,
		trigger_proba = 100,
		para = 2002
};

get(20) ->
	#goods_eff{
		no = 20,
		name = get_partner,
		trigger_proba = 100,
		para = 3002
};

get(21) ->
	#goods_eff{
		no = 21,
		name = get_partner,
		trigger_proba = 100,
		para = 4002
};

get(22) ->
	#goods_eff{
		no = 22,
		name = get_partner,
		trigger_proba = 100,
		para = 5002
};

get(23) ->
	#goods_eff{
		no = 23,
		name = get_partner,
		trigger_proba = 100,
		para = 6002
};

get(24) ->
	#goods_eff{
		no = 24,
		name = get_partner,
		trigger_proba = 100,
		para = 1003
};

get(25) ->
	#goods_eff{
		no = 25,
		name = get_partner,
		trigger_proba = 100,
		para = 2003
};

get(26) ->
	#goods_eff{
		no = 26,
		name = get_partner,
		trigger_proba = 100,
		para = 3003
};

get(27) ->
	#goods_eff{
		no = 27,
		name = get_partner,
		trigger_proba = 100,
		para = 4003
};

get(28) ->
	#goods_eff{
		no = 28,
		name = get_partner,
		trigger_proba = 100,
		para = 5003
};

get(29) ->
	#goods_eff{
		no = 29,
		name = get_partner,
		trigger_proba = 100,
		para = 6003
};

get(30) ->
	#goods_eff{
		no = 30,
		name = get_partner,
		trigger_proba = 100,
		para = 1004
};

get(31) ->
	#goods_eff{
		no = 31,
		name = get_partner,
		trigger_proba = 100,
		para = 2004
};

get(32) ->
	#goods_eff{
		no = 32,
		name = get_partner,
		trigger_proba = 100,
		para = 3004
};

get(33) ->
	#goods_eff{
		no = 33,
		name = get_partner,
		trigger_proba = 100,
		para = 4004
};

get(34) ->
	#goods_eff{
		no = 34,
		name = get_partner,
		trigger_proba = 100,
		para = 5004
};

get(35) ->
	#goods_eff{
		no = 35,
		name = get_partner,
		trigger_proba = 100,
		para = 6004
};

get(36) ->
	#goods_eff{
		no = 36,
		name = get_partner,
		trigger_proba = 100,
		para = 1005
};

get(37) ->
	#goods_eff{
		no = 37,
		name = get_partner,
		trigger_proba = 100,
		para = 2005
};

get(38) ->
	#goods_eff{
		no = 38,
		name = get_partner,
		trigger_proba = 100,
		para = 3005
};

get(39) ->
	#goods_eff{
		no = 39,
		name = get_partner,
		trigger_proba = 100,
		para = 4005
};

get(40) ->
	#goods_eff{
		no = 40,
		name = get_partner,
		trigger_proba = 100,
		para = 5005
};

get(41) ->
	#goods_eff{
		no = 41,
		name = get_partner,
		trigger_proba = 100,
		para = 6005
};

get(42) ->
	#goods_eff{
		no = 42,
		name = get_partner,
		trigger_proba = 100,
		para = 1006
};

get(43) ->
	#goods_eff{
		no = 43,
		name = get_partner,
		trigger_proba = 100,
		para = 2006
};

get(44) ->
	#goods_eff{
		no = 44,
		name = get_partner,
		trigger_proba = 100,
		para = 3006
};

get(45) ->
	#goods_eff{
		no = 45,
		name = get_partner,
		trigger_proba = 100,
		para = 4006
};

get(46) ->
	#goods_eff{
		no = 46,
		name = get_partner,
		trigger_proba = 100,
		para = 5006
};

get(47) ->
	#goods_eff{
		no = 47,
		name = get_partner,
		trigger_proba = 100,
		para = 6006
};

get(48) ->
	#goods_eff{
		no = 48,
		name = accept_task,
		trigger_proba = 100,
		para = 147
};

get(49) ->
	#goods_eff{
		no = 49,
		name = add_phy_power,
		trigger_proba = 100,
		para = 100
};

get(50) ->
	#goods_eff{
		no = 50,
		name = add_energy,
		trigger_proba = 100,
		para = 100
};

get(51) ->
	#goods_eff{
		no = 51,
		name = add_anger,
		trigger_proba = 100,
		para = 20
};

get(52) ->
	#goods_eff{
		no = 52,
		name = add_hp,
		trigger_proba = 100,
		para = 25
};

get(53) ->
	#goods_eff{
		no = 53,
		name = add_hp,
		trigger_proba = 100,
		para = 50
};

get(54) ->
	#goods_eff{
		no = 54,
		name = add_life,
		trigger_proba = 100,
		para = 50
};

get(55) ->
	#goods_eff{
		no = 55,
		name = add_loyalty,
		trigger_proba = 100,
		para = 5
};

get(56) ->
	#goods_eff{
		no = 56,
		name = get_reward,
		trigger_proba = 100,
		para = 17001
};

get(57) ->
	#goods_eff{
		no = 57,
		name = get_reward,
		trigger_proba = 100,
		para = 17002
};

get(58) ->
	#goods_eff{
		no = 58,
		name = get_reward,
		trigger_proba = 100,
		para = 17003
};

get(59) ->
	#goods_eff{
		no = 59,
		name = finish_task,
		trigger_proba = 100,
		para = {1001530,1308,42}
};

get(60) ->
	#goods_eff{
		no = 60,
		name = get_reward,
		trigger_proba = 100,
		para = 17000
};

get(61) ->
	#goods_eff{
		no = 61,
		name = finish_task,
		trigger_proba = 100,
		para = {1001270,1201,61}
};

get(62) ->
	#goods_eff{
		no = 62,
		name = finish_task,
		trigger_proba = 100,
		para = {1010026,1308,43}
};

get(63) ->
	#goods_eff{
		no = 63,
		name = finish_task,
		trigger_proba = 100,
		para = {1010042,1101,120}
};

get(64) ->
	#goods_eff{
		no = 64,
		name = add_exp,
		trigger_proba = 100,
		para = 20000
};

get(65) ->
	#goods_eff{
		no = 65,
		name = add_exp,
		trigger_proba = 100,
		para = 10000
};

get(66) ->
	#goods_eff{
		no = 66,
		name = add_bind_gamemoney,
		trigger_proba = 100,
		para = 10000
};

get(67) ->
	#goods_eff{
		no = 67,
		name = add_bind_gamemoney,
		trigger_proba = 100,
		para = 5000
};

get(68) ->
	#goods_eff{
		no = 68,
		name = get_reward,
		trigger_proba = 100,
		para = 41000
};

get(69) ->
	#goods_eff{
		no = 69,
		name = get_reward,
		trigger_proba = 100,
		para = 41001
};

get(70) ->
	#goods_eff{
		no = 70,
		name = get_reward,
		trigger_proba = 100,
		para = 41002
};

get(71) ->
	#goods_eff{
		no = 71,
		name = get_reward,
		trigger_proba = 100,
		para = 41003
};

get(72) ->
	#goods_eff{
		no = 72,
		name = get_reward,
		trigger_proba = 100,
		para = 41004
};

get(73) ->
	#goods_eff{
		no = 73,
		name = get_reward,
		trigger_proba = 100,
		para = 41308
};

get(74) ->
	#goods_eff{
		no = 74,
		name = get_reward,
		trigger_proba = 100,
		para = 41309
};

get(75) ->
	#goods_eff{
		no = 75,
		name = get_reward,
		trigger_proba = 100,
		para = 41310
};

get(76) ->
	#goods_eff{
		no = 76,
		name = get_reward,
		trigger_proba = 100,
		para = 41311
};

get(77) ->
	#goods_eff{
		no = 77,
		name = add_exp,
		trigger_proba = 100,
		para = 100000
};

get(78) ->
	#goods_eff{
		no = 78,
		name = add_exp,
		trigger_proba = 100,
		para = 500000
};

get(79) ->
	#goods_eff{
		no = 79,
		name = get_reward,
		trigger_proba = 100,
		para = 41312
};

get(80) ->
	#goods_eff{
		no = 80,
		name = get_reward,
		trigger_proba = 100,
		para = 41313
};

get(81) ->
	#goods_eff{
		no = 81,
		name = add_store_par_hp,
		trigger_proba = 100,
		para = 25000
};

get(82) ->
	#goods_eff{
		no = 82,
		name = add_store_par_mp,
		trigger_proba = 100,
		para = 12500
};

get(83) ->
	#goods_eff{
		no = 83,
		name = add_buff,
		trigger_proba = 100,
		para = 100001
};

get(84) ->
	#goods_eff{
		no = 84,
		name = get_reward,
		trigger_proba = 100,
		para = 41105
};

get(85) ->
	#goods_eff{
		no = 85,
		name = get_reward,
		trigger_proba = 100,
		para = 41106
};

get(86) ->
	#goods_eff{
		no = 86,
		name = get_reward,
		trigger_proba = 100,
		para = 41107
};

get(87) ->
	#goods_eff{
		no = 87,
		name = get_reward,
		trigger_proba = 100,
		para = 41108
};

get(88) ->
	#goods_eff{
		no = 88,
		name = get_reward,
		trigger_proba = 100,
		para = 41109
};

get(89) ->
	#goods_eff{
		no = 89,
		name = get_reward,
		trigger_proba = 100,
		para = 41115
};

get(90) ->
	#goods_eff{
		no = 90,
		name = get_reward,
		trigger_proba = 100,
		para = 41116
};

get(91) ->
	#goods_eff{
		no = 91,
		name = get_reward,
		trigger_proba = 100,
		para = 41117
};

get(92) ->
	#goods_eff{
		no = 92,
		name = get_reward,
		trigger_proba = 100,
		para = 41118
};

get(93) ->
	#goods_eff{
		no = 93,
		name = get_reward,
		trigger_proba = 100,
		para = 41119
};

get(94) ->
	#goods_eff{
		no = 94,
		name = get_reward,
		trigger_proba = 100,
		para = 41500
};

get(95) ->
	#goods_eff{
		no = 95,
		name = get_reward,
		trigger_proba = 100,
		para = 41501
};

get(96) ->
	#goods_eff{
		no = 96,
		name = get_reward,
		trigger_proba = 100,
		para = 41502
};

get(97) ->
	#goods_eff{
		no = 97,
		name = get_reward,
		trigger_proba = 100,
		para = 41503
};

get(98) ->
	#goods_eff{
		no = 98,
		name = get_reward,
		trigger_proba = 100,
		para = 41504
};

get(99) ->
	#goods_eff{
		no = 99,
		name = get_reward,
		trigger_proba = 100,
		para = 41505
};

get(100) ->
	#goods_eff{
		no = 100,
		name = turn_talent_to_free,
		trigger_proba = 100,
		para = 0
};

get(101) ->
	#goods_eff{
		no = 101,
		name = get_partner,
		trigger_proba = 100,
		para = 6008
};

get(102) ->
	#goods_eff{
		no = 102,
		name = rand_get_goods,
		trigger_proba = 100,
		para = [{50002,10},{50003,7},{50008,10},{50009,7},{50014,10},{500015,7},{50020,10},{50021,7},{50026,10},{50027,6},{50032,10},{50033,6}]
};

get(103) ->
	#goods_eff{
		no = 103,
		name = rand_get_goods,
		trigger_proba = 100,
		para = [{50003,16},{50009,16},{50015,17},{50021,17},{50027,17},{50033,17}]
};

get(104) ->
	#goods_eff{
		no = 104,
		name = rand_get_goods,
		trigger_proba = 100,
		para = [{50004,16},{50010,16},{50016,17},{50022,17},{50028,17},{50034,17}]
};

get(105) ->
	#goods_eff{
		no = 105,
		name = add_bind_gamemoney,
		trigger_proba = 100,
		para = 1000
};

get(106) ->
	#goods_eff{
		no = 106,
		name = add_bind_gamemoney,
		trigger_proba = 100,
		para = 2000
};

get(107) ->
	#goods_eff{
		no = 107,
		name = get_reward,
		trigger_proba = 100,
		para = 41506
};

get(108) ->
	#goods_eff{
		no = 108,
		name = get_reward,
		trigger_proba = 100,
		para = 41507
};

get(109) ->
	#goods_eff{
		no = 109,
		name = get_reward,
		trigger_proba = 100,
		para = 41508
};

get(110) ->
	#goods_eff{
		no = 110,
		name = get_reward,
		trigger_proba = 100,
		para = 41509
};

get(111) ->
	#goods_eff{
		no = 111,
		name = get_reward,
		trigger_proba = 100,
		para = 41510
};

get(112) ->
	#goods_eff{
		no = 112,
		name = get_reward,
		trigger_proba = 100,
		para = 41511
};

get(113) ->
	#goods_eff{
		no = 113,
		name = get_reward,
		trigger_proba = 100,
		para = 41512
};

get(114) ->
	#goods_eff{
		no = 114,
		name = rand_get_goods,
		trigger_proba = 100,
		para = [{50046,2.56},{50272,2.56},{50047,2.56},{50273,2.56},{50274,2.56},{50048,2.56},{50049,2.56},{50050,2.56},{50051,2.56},{50052,2.56},{50053,2.56},{50054,2.56},{50055,2.56},{50056,2.56},{50284,2.56},{50057,2.56},{50059,2.56},{50275,2.56},{50276,2.56},{50060,2.56},{50277,2.56},{50278,2.56},{50279,2.56},{50280,2.56},{50281,2.56},{50282,2.56},{50283,2.56},{50310,2.56},{50311,2.56},{50312,2.56},{50313,2.56},{50314,2.56},{50317,2.56},{50318,2.56},{50319,2.56},{50320,2.6},{50321,2.6},{50322,2.6},{50058,2.6}]
};

get(115) ->
	#goods_eff{
		no = 115,
		name = rand_get_goods,
		trigger_proba = 100,
		para = [{50061,2.56},{50076,2.56},{50062,2.56},{50077,2.56},{50078,2.56},{50063,2.56},{50064,2.56},{50065,2.56},{50066,2.56},{50067,2.56},{50068,2.56},{50069,2.56},{50070,2.56},{50071,2.56},{50271,2.56},{50072,2.56},{50074,2.56},{50079,2.56},{50080,2.56},{50075,2.56},{50081,2.56},{50082,2.56},{50083,2.56},{50084,2.56},{50268,2.56},{50269,2.56},{50270,2.56},{50315,2.56},{50339,2.56},{50340,2.56},{50341,2.56},{50342,2.56},{50323,2.56},{50324,2.56},{50325,2.56},{50326,2.6},{50327,2.6},{50328,2.6},{50073,2.6}]
};

get(116) ->
	#goods_eff{
		no = 116,
		name = add_bind_gamemoney,
		trigger_proba = 100,
		para = 100
};

get(117) ->
	#goods_eff{
		no = 117,
		name = add_exp,
		trigger_proba = 100,
		para = 20000
};

get(118) ->
	#goods_eff{
		no = 118,
		name = get_reward,
		trigger_proba = 100,
		para = 3
};

get(119) ->
	#goods_eff{
		no = 119,
		name = get_reward,
		trigger_proba = 100,
		para = 4
};

get(130) ->
	#goods_eff{
		no = 130,
		name = get_reward,
		trigger_proba = 100,
		para = 41501
};

get(131) ->
	#goods_eff{
		no = 131,
		name = get_reward,
		trigger_proba = 100,
		para = 41503
};

get(132) ->
	#goods_eff{
		no = 132,
		name = get_reward,
		trigger_proba = 100,
		para = 41504
};

get(133) ->
	#goods_eff{
		no = 133,
		name = get_reward,
		trigger_proba = 100,
		para = 41527
};

get(134) ->
	#goods_eff{
		no = 134,
		name = get_reward,
		trigger_proba = 100,
		para = 41528
};

get(135) ->
	#goods_eff{
		no = 135,
		name = get_reward,
		trigger_proba = 100,
		para = 41529
};

get(136) ->
	#goods_eff{
		no = 136,
		name = get_reward,
		trigger_proba = 100,
		para = 41530
};

get(137) ->
	#goods_eff{
		no = 137,
		name = get_reward,
		trigger_proba = 100,
		para = 41500
};

get(138) ->
	#goods_eff{
		no = 138,
		name = get_reward,
		trigger_proba = 100,
		para = 41531
};

get(139) ->
	#goods_eff{
		no = 139,
		name = get_reward,
		trigger_proba = 100,
		para = 41532
};

get(140) ->
	#goods_eff{
		no = 140,
		name = get_reward,
		trigger_proba = 100,
		para = 41533
};

get(141) ->
	#goods_eff{
		no = 141,
		name = get_reward,
		trigger_proba = 100,
		para = 41534
};

get(142) ->
	#goods_eff{
		no = 142,
		name = get_reward,
		trigger_proba = 100,
		para = 41535
};

get(143) ->
	#goods_eff{
		no = 143,
		name = get_reward,
		trigger_proba = 100,
		para = 41536
};

get(144) ->
	#goods_eff{
		no = 144,
		name = get_reward,
		trigger_proba = 100,
		para = 41537
};

get(145) ->
	#goods_eff{
		no = 145,
		name = get_reward,
		trigger_proba = 100,
		para = 41538
};

get(146) ->
	#goods_eff{
		no = 146,
		name = get_reward,
		trigger_proba = 100,
		para = 41539
};

get(315) ->
	#goods_eff{
		no = 315,
		name = rand_get_goods,
		trigger_proba = 100,
		para = [{50095,33},{50101,34},{50107,33}]
};

get(316) ->
	#goods_eff{
		no = 316,
		name = rand_get_goods,
		trigger_proba = 100,
		para = [{50096,33},{50102,34},{50108,33}]
};

get(317) ->
	#goods_eff{
		no = 317,
		name = rand_get_goods,
		trigger_proba = 100,
		para = [{50098,33},{50104,34},{50110,33}]
};

get(318) ->
	#goods_eff{
		no = 318,
		name = rand_get_goods,
		trigger_proba = 100,
		para = [{50096,20},{50097,10},{50098,1},{50108,40},{50109,20},{50110,1.5},{50254,2.5},{50259,5}]
};

get(319) ->
	#goods_eff{
		no = 319,
		name = get_partner,
		trigger_proba = 100,
		para = 2024
};

get(320) ->
	#goods_eff{
		no = 320,
		name = get_reward,
		trigger_proba = 100,
		para = 90003
};

get(321) ->
	#goods_eff{
		no = 321,
		name = get_reward,
		trigger_proba = 100,
		para = 90004
};

get(322) ->
	#goods_eff{
		no = 322,
		name = get_reward,
		trigger_proba = 100,
		para = 90005
};

get(323) ->
	#goods_eff{
		no = 323,
		name = get_reward,
		trigger_proba = 100,
		para = 90006
};

get(324) ->
	#goods_eff{
		no = 324,
		name = get_reward,
		trigger_proba = 100,
		para = 90007
};

get(325) ->
	#goods_eff{
		no = 325,
		name = get_reward,
		trigger_proba = 100,
		para = 90008
};

get(326) ->
	#goods_eff{
		no = 326,
		name = get_reward,
		trigger_proba = 100,
		para = 41540
};

get(327) ->
	#goods_eff{
		no = 327,
		name = get_reward,
		trigger_proba = 100,
		para = 41541
};

get(328) ->
	#goods_eff{
		no = 328,
		name = get_reward,
		trigger_proba = 100,
		para = 41542
};

get(329) ->
	#goods_eff{
		no = 329,
		name = get_reward,
		trigger_proba = 100,
		para = 41543
};

get(330) ->
	#goods_eff{
		no = 330,
		name = get_reward,
		trigger_proba = 100,
		para = 41544
};

get(331) ->
	#goods_eff{
		no = 331,
		name = get_reward,
		trigger_proba = 100,
		para = 41545
};

get(332) ->
	#goods_eff{
		no = 332,
		name = get_reward,
		trigger_proba = 100,
		para = 41546
};

get(333) ->
	#goods_eff{
		no = 333,
		name = get_reward,
		trigger_proba = 100,
		para = 41547
};

get(334) ->
	#goods_eff{
		no = 334,
		name = get_reward,
		trigger_proba = 100,
		para = 41548
};

get(335) ->
	#goods_eff{
		no = 335,
		name = get_reward,
		trigger_proba = 100,
		para = 41549
};

get(336) ->
	#goods_eff{
		no = 336,
		name = get_reward,
		trigger_proba = 100,
		para = 41550
};

get(337) ->
	#goods_eff{
		no = 337,
		name = get_reward,
		trigger_proba = 100,
		para = 41551
};

get(370) ->
	#goods_eff{
		no = 370,
		name = add_gamemoney,
		trigger_proba = 100,
		para = 10000
};

get(371) ->
	#goods_eff{
		no = 371,
		name = add_gamemoney,
		trigger_proba = 100,
		para = 50000
};

get(372) ->
	#goods_eff{
		no = 372,
		name = add_gamemoney,
		trigger_proba = 100,
		para = 200000
};

get(373) ->
	#goods_eff{
		no = 373,
		name = add_gamemoney,
		trigger_proba = 100,
		para = 1000000
};

get(374) ->
	#goods_eff{
		no = 374,
		name = get_reward,
		trigger_proba = 100,
		para = 30300
};

get(375) ->
	#goods_eff{
		no = 375,
		name = get_reward,
		trigger_proba = 100,
		para = 30301
};

get(376) ->
	#goods_eff{
		no = 376,
		name = get_reward,
		trigger_proba = 100,
		para = 30302
};

get(377) ->
	#goods_eff{
		no = 377,
		name = get_reward,
		trigger_proba = 100,
		para = 30303
};

get(378) ->
	#goods_eff{
		no = 378,
		name = get_reward,
		trigger_proba = 100,
		para = 30304
};

get(379) ->
	#goods_eff{
		no = 379,
		name = get_reward,
		trigger_proba = 100,
		para = 30305
};

get(380) ->
	#goods_eff{
		no = 380,
		name = get_reward,
		trigger_proba = 100,
		para = 44511
};

get(381) ->
	#goods_eff{
		no = 381,
		name = get_partner,
		trigger_proba = 100,
		para = 2031
};

get(382) ->
	#goods_eff{
		no = 382,
		name = get_partner,
		trigger_proba = 100,
		para = 2032
};

get(383) ->
	#goods_eff{
		no = 383,
		name = get_partner,
		trigger_proba = 100,
		para = 2033
};

get(384) ->
	#goods_eff{
		no = 384,
		name = get_partner,
		trigger_proba = 100,
		para = 2034
};

get(385) ->
	#goods_eff{
		no = 385,
		name = get_partner,
		trigger_proba = 100,
		para = 2035
};

get(386) ->
	#goods_eff{
		no = 386,
		name = get_partner,
		trigger_proba = 100,
		para = 2036
};

get(387) ->
	#goods_eff{
		no = 387,
		name = get_reward,
		trigger_proba = 100,
		para = 41552
};

get(388) ->
	#goods_eff{
		no = 388,
		name = get_reward,
		trigger_proba = 100,
		para = 41553
};

get(389) ->
	#goods_eff{
		no = 389,
		name = get_reward,
		trigger_proba = 100,
		para = 41554
};

get(391) ->
	#goods_eff{
		no = 391,
		name = add_par_evolve,
		trigger_proba = 100,
		para = 1
};

get(392) ->
	#goods_eff{
		no = 392,
		name = add_par_evolve,
		trigger_proba = 100,
		para = 6
};

get(393) ->
	#goods_eff{
		no = 393,
		name = add_par_evolve,
		trigger_proba = 100,
		para = 24
};

get(394) ->
	#goods_eff{
		no = 394,
		name = get_partner,
		trigger_proba = 100,
		para = 2034
};

get(395) ->
	#goods_eff{
		no = 395,
		name = get_partner,
		trigger_proba = 100,
		para = 2014
};

get(396) ->
	#goods_eff{
		no = 396,
		name = get_partner,
		trigger_proba = 100,
		para = 2024
};

get(397) ->
	#goods_eff{
		no = 397,
		name = rand_get_par,
		trigger_proba = 100,
		para = [{2033,92.5},{2013,2.5},{2023,5}]
};

get(398) ->
	#goods_eff{
		no = 398,
		name = get_partner,
		trigger_proba = 100,
		para = 1063
};

get(399) ->
	#goods_eff{
		no = 399,
		name = rand_get_par,
		trigger_proba = 100,
		para = [{1013,33.4},{1023,33.3},{1033,33.3}]
};

get(400) ->
	#goods_eff{
		no = 400,
		name = rand_get_par,
		trigger_proba = 100,
		para = [{1012,33.4},{1022,33.3},{1032,33.3}]
};

get(401) ->
	#goods_eff{
		no = 401,
		name = get_partner,
		trigger_proba = 100,
		para = 2033
};

get(402) ->
	#goods_eff{
		no = 402,
		name = get_reward,
		trigger_proba = 100,
		para = 91015
};

get(403) ->
	#goods_eff{
		no = 403,
		name = get_reward,
		trigger_proba = 100,
		para = 41556
};

get(404) ->
	#goods_eff{
		no = 404,
		name = get_reward,
		trigger_proba = 100,
		para = 41557
};

get(405) ->
	#goods_eff{
		no = 405,
		name = get_reward,
		trigger_proba = 100,
		para = 41558
};

get(406) ->
	#goods_eff{
		no = 406,
		name = get_reward,
		trigger_proba = 100,
		para = 41559
};

get(407) ->
	#goods_eff{
		no = 407,
		name = get_reward,
		trigger_proba = 100,
		para = 41560
};

get(408) ->
	#goods_eff{
		no = 408,
		name = get_reward,
		trigger_proba = 100,
		para = 41561
};

get(409) ->
	#goods_eff{
		no = 409,
		name = add_vip_exp,
		trigger_proba = 100,
		para = 3000
};

get(410) ->
	#goods_eff{
		no = 410,
		name = get_reward,
		trigger_proba = 100,
		para = 90009
};

get(411) ->
	#goods_eff{
		no = 411,
		name = get_reward,
		trigger_proba = 100,
		para = 90010
};

get(412) ->
	#goods_eff{
		no = 412,
		name = get_reward,
		trigger_proba = 100,
		para = 90011
};

get(413) ->
	#goods_eff{
		no = 413,
		name = get_reward,
		trigger_proba = 100,
		para = 15023
};

get(414) ->
	#goods_eff{
		no = 414,
		name = get_reward,
		trigger_proba = 100,
		para = 15024
};

get(415) ->
	#goods_eff{
		no = 415,
		name = get_reward,
		trigger_proba = 100,
		para = 15025
};

get(416) ->
	#goods_eff{
		no = 416,
		name = get_reward,
		trigger_proba = 100,
		para = 15026
};

get(417) ->
	#goods_eff{
		no = 417,
		name = get_reward,
		trigger_proba = 100,
		para = 15027
};

get(418) ->
	#goods_eff{
		no = 418,
		name = get_reward,
		trigger_proba = 100,
		para = 15028
};

get(419) ->
	#goods_eff{
		no = 419,
		name = get_reward,
		trigger_proba = 100,
		para = 15029
};

get(420) ->
	#goods_eff{
		no = 420,
		name = finish_task,
		trigger_proba = 100,
		para = {1002290,1309,92}
};

get(421) ->
	#goods_eff{
		no = 421,
		name = finish_task,
		trigger_proba = 100,
		para = {1002580,1309,95}
};

get(422) ->
	#goods_eff{
		no = 422,
		name = finish_task,
		trigger_proba = 100,
		para = {1002670,1309,94}
};

get(423) ->
	#goods_eff{
		no = 423,
		name = finish_task,
		trigger_proba = 100,
		para = {1002690,1309,94}
};

get(424) ->
	#goods_eff{
		no = 424,
		name = add_title,
		trigger_proba = 100,
		para = 40005
};

get(425) ->
	#goods_eff{
		no = 425,
		name = add_title,
		trigger_proba = 100,
		para = 40006
};

get(426) ->
	#goods_eff{
		no = 426,
		name = get_reward,
		trigger_proba = 100,
		para = 90014
};

get(427) ->
	#goods_eff{
		no = 427,
		name = add_buff,
		trigger_proba = 100,
		para = 20006
};

get(428) ->
	#goods_eff{
		no = 428,
		name = get_reward,
		trigger_proba = 100,
		para = 30124
};

get(429) ->
	#goods_eff{
		no = 429,
		name = get_reward,
		trigger_proba = 100,
		para = 30125
};

get(430) ->
	#goods_eff{
		no = 430,
		name = get_reward,
		trigger_proba = 100,
		para = 30126
};

get(431) ->
	#goods_eff{
		no = 431,
		name = get_reward,
		trigger_proba = 100,
		para = 30127
};

get(432) ->
	#goods_eff{
		no = 432,
		name = get_reward,
		trigger_proba = 100,
		para = 30128
};

get(433) ->
	#goods_eff{
		no = 433,
		name = get_reward,
		trigger_proba = 100,
		para = 30129
};

get(434) ->
	#goods_eff{
		no = 434,
		name = get_reward,
		trigger_proba = 100,
		para = 30130
};

get(435) ->
	#goods_eff{
		no = 435,
		name = get_reward,
		trigger_proba = 100,
		para = 30131
};

get(436) ->
	#goods_eff{
		no = 436,
		name = get_reward,
		trigger_proba = 100,
		para = 30132
};

get(437) ->
	#goods_eff{
		no = 437,
		name = get_reward,
		trigger_proba = 100,
		para = 30133
};

get(438) ->
	#goods_eff{
		no = 438,
		name = get_reward,
		trigger_proba = 100,
		para = 30134
};

get(439) ->
	#goods_eff{
		no = 439,
		name = get_reward,
		trigger_proba = 100,
		para = 30135
};

get(440) ->
	#goods_eff{
		no = 440,
		name = extend_par_capacity,
		trigger_proba = 100,
		para = 1
};

get(441) ->
	#goods_eff{
		no = 441,
		name = add_store_hp,
		trigger_proba = 100,
		para = 125000
};

get(442) ->
	#goods_eff{
		no = 442,
		name = add_store_mp,
		trigger_proba = 100,
		para = 62500
};

get(443) ->
	#goods_eff{
		no = 443,
		name = add_store_par_hp,
		trigger_proba = 100,
		para = 125000
};

get(444) ->
	#goods_eff{
		no = 444,
		name = add_store_par_mp,
		trigger_proba = 100,
		para = 62500
};

get(445) ->
	#goods_eff{
		no = 445,
		name = get_reward,
		trigger_proba = 100,
		para = 44600
};

get(446) ->
	#goods_eff{
		no = 446,
		name = get_reward,
		trigger_proba = 100,
		para = 44601
};

get(447) ->
	#goods_eff{
		no = 447,
		name = get_reward,
		trigger_proba = 100,
		para = 44602
};

get(448) ->
	#goods_eff{
		no = 448,
		name = get_reward,
		trigger_proba = 100,
		para = 44603
};

get(449) ->
	#goods_eff{
		no = 449,
		name = get_reward,
		trigger_proba = 100,
		para = 44604
};

get(450) ->
	#goods_eff{
		no = 450,
		name = get_reward,
		trigger_proba = 100,
		para = 44605
};

get(451) ->
	#goods_eff{
		no = 451,
		name = get_reward,
		trigger_proba = 100,
		para = 44606
};

get(452) ->
	#goods_eff{
		no = 452,
		name = get_reward,
		trigger_proba = 100,
		para = 44607
};

get(453) ->
	#goods_eff{
		no = 453,
		name = get_reward,
		trigger_proba = 100,
		para = 44608
};

get(454) ->
	#goods_eff{
		no = 454,
		name = get_reward,
		trigger_proba = 100,
		para = 44609
};

get(455) ->
	#goods_eff{
		no = 455,
		name = get_reward,
		trigger_proba = 100,
		para = 44610
};

get(456) ->
	#goods_eff{
		no = 456,
		name = get_reward,
		trigger_proba = 100,
		para = 44611
};

get(457) ->
	#goods_eff{
		no = 457,
		name = get_reward,
		trigger_proba = 100,
		para = 44612
};

get(458) ->
	#goods_eff{
		no = 458,
		name = get_reward,
		trigger_proba = 100,
		para = 44613
};

get(459) ->
	#goods_eff{
		no = 459,
		name = finish_task,
		trigger_proba = 100,
		para = {1002910,1305,70}
};

get(460) ->
	#goods_eff{
		no = 460,
		name = finish_task,
		trigger_proba = 100,
		para = {1003150,1204,3008}
};

get(461) ->
	#goods_eff{
		no = 461,
		name = finish_task,
		trigger_proba = 100,
		para = {1003230,1305,3007}
};

get(462) ->
	#goods_eff{
		no = 462,
		name = finish_task,
		trigger_proba = 100,
		para = {1003470,1311,77}
};

get(463) ->
	#goods_eff{
		no = 463,
		name = finish_task,
		trigger_proba = 100,
		para = {1003200,1311,73}
};

get(464) ->
	#goods_eff{
		no = 464,
		name = add_hp,
		trigger_proba = 100,
		para = 150
};

get(465) ->
	#goods_eff{
		no = 465,
		name = add_mp,
		trigger_proba = 100,
		para = 52
};

get(466) ->
	#goods_eff{
		no = 466,
		name = add_hp,
		trigger_proba = 100,
		para = 262
};

get(467) ->
	#goods_eff{
		no = 467,
		name = add_mp,
		trigger_proba = 100,
		para = 85
};

get(468) ->
	#goods_eff{
		no = 468,
		name = get_reward,
		trigger_proba = 100,
		para = 43004
};

get(469) ->
	#goods_eff{
		no = 469,
		name = get_reward,
		trigger_proba = 100,
		para = 43005
};

get(470) ->
	#goods_eff{
		no = 470,
		name = get_partner,
		trigger_proba = 100,
		para = 2041
};

get(471) ->
	#goods_eff{
		no = 471,
		name = get_partner,
		trigger_proba = 100,
		para = 2042
};

get(472) ->
	#goods_eff{
		no = 472,
		name = get_partner,
		trigger_proba = 100,
		para = 2043
};

get(473) ->
	#goods_eff{
		no = 473,
		name = get_partner,
		trigger_proba = 100,
		para = 2044
};

get(474) ->
	#goods_eff{
		no = 474,
		name = get_partner,
		trigger_proba = 100,
		para = 2045
};

get(475) ->
	#goods_eff{
		no = 475,
		name = get_partner,
		trigger_proba = 100,
		para = 2046
};

get(476) ->
	#goods_eff{
		no = 476,
		name = get_partner,
		trigger_proba = 100,
		para = 2051
};

get(477) ->
	#goods_eff{
		no = 477,
		name = get_partner,
		trigger_proba = 100,
		para = 2052
};

get(478) ->
	#goods_eff{
		no = 478,
		name = get_partner,
		trigger_proba = 100,
		para = 2053
};

get(479) ->
	#goods_eff{
		no = 479,
		name = get_partner,
		trigger_proba = 100,
		para = 2054
};

get(480) ->
	#goods_eff{
		no = 480,
		name = get_partner,
		trigger_proba = 100,
		para = 2055
};

get(481) ->
	#goods_eff{
		no = 481,
		name = get_partner,
		trigger_proba = 100,
		para = 2056
};

get(482) ->
	#goods_eff{
		no = 482,
		name = get_reward,
		trigger_proba = 100,
		para = 43006
};

get(483) ->
	#goods_eff{
		no = 483,
		name = add_title,
		trigger_proba = 100,
		para = 50021
};

get(484) ->
	#goods_eff{
		no = 484,
		name = get_reward,
		trigger_proba = 100,
		para = 90024
};

get(485) ->
	#goods_eff{
		no = 485,
		name = add_bind_gamemoney,
		trigger_proba = 100,
		para = 20000
};

get(486) ->
	#goods_eff{
		no = 486,
		name = add_bind_gamemoney,
		trigger_proba = 100,
		para = 30000
};

get(487) ->
	#goods_eff{
		no = 487,
		name = add_bind_gamemoney,
		trigger_proba = 100,
		para = 50000
};

get(488) ->
	#goods_eff{
		no = 488,
		name = get_reward,
		trigger_proba = 100,
		para = 40803
};

get(489) ->
	#goods_eff{
		no = 489,
		name = get_reward,
		trigger_proba = 100,
		para = 40804
};

get(490) ->
	#goods_eff{
		no = 490,
		name = get_reward,
		trigger_proba = 100,
		para = 41563
};

get(491) ->
	#goods_eff{
		no = 491,
		name = get_reward,
		trigger_proba = 100,
		para = 41564
};

get(492) ->
	#goods_eff{
		no = 492,
		name = get_reward,
		trigger_proba = 100,
		para = 41565
};

get(493) ->
	#goods_eff{
		no = 493,
		name = get_reward,
		trigger_proba = 100,
		para = 41566
};

get(494) ->
	#goods_eff{
		no = 494,
		name = get_reward,
		trigger_proba = 100,
		para = 41567
};

get(495) ->
	#goods_eff{
		no = 495,
		name = get_reward,
		trigger_proba = 100,
		para = 41568
};

get(514) ->
	#goods_eff{
		no = 514,
		name = trigger_dig_treasure,
		trigger_proba = 100,
		para = 0
};

get(573) ->
	#goods_eff{
		no = 573,
		name = activate_vip_recharge_rebates,
		trigger_proba = 100,
		para = 250
};

get(575) ->
	#goods_eff{
		no = 575,
		name = get_reward,
		trigger_proba = 100,
		para = 45023
};

get(576) ->
	#goods_eff{
		no = 576,
		name = get_reward,
		trigger_proba = 100,
		para = 46000
};

get(577) ->
	#goods_eff{
		no = 577,
		name = get_reward,
		trigger_proba = 100,
		para = 46001
};

get(578) ->
	#goods_eff{
		no = 578,
		name = get_reward,
		trigger_proba = 100,
		para = 46002
};

get(579) ->
	#goods_eff{
		no = 579,
		name = get_reward,
		trigger_proba = 100,
		para = 46003
};

get(580) ->
	#goods_eff{
		no = 580,
		name = get_reward,
		trigger_proba = 100,
		para = 46004
};

get(581) ->
	#goods_eff{
		no = 581,
		name = get_reward,
		trigger_proba = 100,
		para = 45011
};

get(582) ->
	#goods_eff{
		no = 582,
		name = get_reward,
		trigger_proba = 100,
		para = 46006
};

get(583) ->
	#goods_eff{
		no = 583,
		name = active_vip,
		trigger_proba = 100,
		para = 50000
};

get(598) ->
	#goods_eff{
		no = 598,
		name = add_title,
		trigger_proba = 100,
		para = 50028
};

get(599) ->
	#goods_eff{
		no = 599,
		name = get_reward,
		trigger_proba = 100,
		para = 45005
};

get(600) ->
	#goods_eff{
		no = 600,
		name = get_reward,
		trigger_proba = 100,
		para = 45006
};

get(601) ->
	#goods_eff{
		no = 601,
		name = get_reward,
		trigger_proba = 100,
		para = 45007
};

get(602) ->
	#goods_eff{
		no = 602,
		name = get_reward,
		trigger_proba = 100,
		para = 45008
};

get(603) ->
	#goods_eff{
		no = 603,
		name = get_reward,
		trigger_proba = 100,
		para = 45009
};

get(604) ->
	#goods_eff{
		no = 604,
		name = get_reward,
		trigger_proba = 100,
		para = 46018
};

get(605) ->
	#goods_eff{
		no = 605,
		name = get_reward,
		trigger_proba = 100,
		para = 91017
};

get(606) ->
	#goods_eff{
		no = 606,
		name = get_reward,
		trigger_proba = 100,
		para = 91018
};

get(607) ->
	#goods_eff{
		no = 607,
		name = get_reward,
		trigger_proba = 100,
		para = 91019
};

get(608) ->
	#goods_eff{
		no = 608,
		name = get_reward,
		trigger_proba = 100,
		para = 91020
};

get(609) ->
	#goods_eff{
		no = 609,
		name = get_reward,
		trigger_proba = 100,
		para = 91021
};

get(610) ->
	#goods_eff{
		no = 610,
		name = add_hp,
		trigger_proba = 100,
		para = 375
};

get(611) ->
	#goods_eff{
		no = 611,
		name = add_mp,
		trigger_proba = 100,
		para = 125
};

get(612) ->
	#goods_eff{
		no = 612,
		name = get_reward,
		trigger_proba = 100,
		para = 44500
};

get(613) ->
	#goods_eff{
		no = 613,
		name = get_reward,
		trigger_proba = 100,
		para = 44501
};

get(614) ->
	#goods_eff{
		no = 614,
		name = get_reward,
		trigger_proba = 100,
		para = 44502
};

get(615) ->
	#goods_eff{
		no = 615,
		name = get_reward,
		trigger_proba = 100,
		para = 44503
};

get(616) ->
	#goods_eff{
		no = 616,
		name = get_reward,
		trigger_proba = 100,
		para = 44504
};

get(617) ->
	#goods_eff{
		no = 617,
		name = get_reward,
		trigger_proba = 100,
		para = 44505
};

get(618) ->
	#goods_eff{
		no = 618,
		name = get_reward,
		trigger_proba = 100,
		para = 44506
};

get(619) ->
	#goods_eff{
		no = 619,
		name = get_reward,
		trigger_proba = 100,
		para = 44507
};

get(620) ->
	#goods_eff{
		no = 620,
		name = get_reward,
		trigger_proba = 100,
		para = 43004
};

get(621) ->
	#goods_eff{
		no = 621,
		name = get_reward,
		trigger_proba = 100,
		para = 43005
};

get(622) ->
	#goods_eff{
		no = 622,
		name = get_reward,
		trigger_proba = 100,
		para = 43006
};

get(623) ->
	#goods_eff{
		no = 623,
		name = get_reward,
		trigger_proba = 100,
		para = 43007
};

get(624) ->
	#goods_eff{
		no = 624,
		name = get_reward,
		trigger_proba = 100,
		para = 15021
};

get(625) ->
	#goods_eff{
		no = 625,
		name = finish_task,
		trigger_proba = 100,
		para = {1004730,1306,1106}
};

get(626) ->
	#goods_eff{
		no = 626,
		name = finish_task,
		trigger_proba = 100,
		para = {1004840,1309,1107}
};

get(627) ->
	#goods_eff{
		no = 627,
		name = finish_task,
		trigger_proba = 100,
		para = {1004940,1312,1109}
};

get(628) ->
	#goods_eff{
		no = 628,
		name = finish_task,
		trigger_proba = 100,
		para = {1005030,1312,1110}
};

get(629) ->
	#goods_eff{
		no = 629,
		name = get_reward,
		trigger_proba = 100,
		para = 45010
};

get(630) ->
	#goods_eff{
		no = 630,
		name = get_reward,
		trigger_proba = 100,
		para = 45025
};

get(631) ->
	#goods_eff{
		no = 631,
		name = add_yuanbao,
		trigger_proba = 100,
		para = 700
};

get(632) ->
	#goods_eff{
		no = 632,
		name = add_yuanbao,
		trigger_proba = 100,
		para = 500
};

get(633) ->
	#goods_eff{
		no = 633,
		name = add_yuanbao,
		trigger_proba = 100,
		para = 300
};

get(634) ->
	#goods_eff{
		no = 634,
		name = add_yuanbao,
		trigger_proba = 100,
		para = 250
};

get(635) ->
	#goods_eff{
		no = 635,
		name = add_yuanbao,
		trigger_proba = 100,
		para = 100
};

get(740) ->
	#goods_eff{
		no = 740,
		name = get_reward,
		trigger_proba = 100,
		para = 1000
};

get(741) ->
	#goods_eff{
		no = 741,
		name = get_reward,
		trigger_proba = 100,
		para = 1001
};

get(742) ->
	#goods_eff{
		no = 742,
		name = get_reward,
		trigger_proba = 100,
		para = 1002
};

get(743) ->
	#goods_eff{
		no = 743,
		name = get_reward,
		trigger_proba = 100,
		para = 1003
};

get(745) ->
	#goods_eff{
		no = 745,
		name = get_mounts,
		trigger_proba = 100,
		para = 1001
};

get(746) ->
	#goods_eff{
		no = 746,
		name = get_mounts,
		trigger_proba = 100,
		para = 1002
};

get(747) ->
	#goods_eff{
		no = 747,
		name = get_mounts,
		trigger_proba = 100,
		para = 1003
};

get(748) ->
	#goods_eff{
		no = 748,
		name = get_mounts,
		trigger_proba = 100,
		para = 1004
};

get(750) ->
	#goods_eff{
		no = 750,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(751) ->
	#goods_eff{
		no = 751,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(752) ->
	#goods_eff{
		no = 752,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(753) ->
	#goods_eff{
		no = 753,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(754) ->
	#goods_eff{
		no = 754,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(755) ->
	#goods_eff{
		no = 755,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(756) ->
	#goods_eff{
		no = 756,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(757) ->
	#goods_eff{
		no = 757,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(758) ->
	#goods_eff{
		no = 758,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(759) ->
	#goods_eff{
		no = 759,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(760) ->
	#goods_eff{
		no = 760,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(761) ->
	#goods_eff{
		no = 761,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(762) ->
	#goods_eff{
		no = 762,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(763) ->
	#goods_eff{
		no = 763,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(764) ->
	#goods_eff{
		no = 764,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(765) ->
	#goods_eff{
		no = 765,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(766) ->
	#goods_eff{
		no = 766,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(767) ->
	#goods_eff{
		no = 767,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(768) ->
	#goods_eff{
		no = 768,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(769) ->
	#goods_eff{
		no = 769,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(770) ->
	#goods_eff{
		no = 770,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(771) ->
	#goods_eff{
		no = 771,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(772) ->
	#goods_eff{
		no = 772,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(773) ->
	#goods_eff{
		no = 773,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(774) ->
	#goods_eff{
		no = 774,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(775) ->
	#goods_eff{
		no = 775,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(776) ->
	#goods_eff{
		no = 776,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(777) ->
	#goods_eff{
		no = 777,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(778) ->
	#goods_eff{
		no = 778,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(779) ->
	#goods_eff{
		no = 779,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(780) ->
	#goods_eff{
		no = 780,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(781) ->
	#goods_eff{
		no = 781,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(782) ->
	#goods_eff{
		no = 782,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(783) ->
	#goods_eff{
		no = 783,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(784) ->
	#goods_eff{
		no = 784,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(785) ->
	#goods_eff{
		no = 785,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(786) ->
	#goods_eff{
		no = 786,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(787) ->
	#goods_eff{
		no = 787,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(788) ->
	#goods_eff{
		no = 788,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(789) ->
	#goods_eff{
		no = 789,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(790) ->
	#goods_eff{
		no = 790,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(791) ->
	#goods_eff{
		no = 791,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(792) ->
	#goods_eff{
		no = 792,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(793) ->
	#goods_eff{
		no = 793,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(794) ->
	#goods_eff{
		no = 794,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(795) ->
	#goods_eff{
		no = 795,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(796) ->
	#goods_eff{
		no = 796,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(797) ->
	#goods_eff{
		no = 797,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(798) ->
	#goods_eff{
		no = 798,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(799) ->
	#goods_eff{
		no = 799,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(800) ->
	#goods_eff{
		no = 800,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(801) ->
	#goods_eff{
		no = 801,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(802) ->
	#goods_eff{
		no = 802,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(803) ->
	#goods_eff{
		no = 803,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(804) ->
	#goods_eff{
		no = 804,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(805) ->
	#goods_eff{
		no = 805,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(806) ->
	#goods_eff{
		no = 806,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(807) ->
	#goods_eff{
		no = 807,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(808) ->
	#goods_eff{
		no = 808,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(809) ->
	#goods_eff{
		no = 809,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(810) ->
	#goods_eff{
		no = 810,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(811) ->
	#goods_eff{
		no = 811,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(812) ->
	#goods_eff{
		no = 812,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(813) ->
	#goods_eff{
		no = 813,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(814) ->
	#goods_eff{
		no = 814,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(815) ->
	#goods_eff{
		no = 815,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(816) ->
	#goods_eff{
		no = 816,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(817) ->
	#goods_eff{
		no = 817,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(818) ->
	#goods_eff{
		no = 818,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(819) ->
	#goods_eff{
		no = 819,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(820) ->
	#goods_eff{
		no = 820,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(821) ->
	#goods_eff{
		no = 821,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(822) ->
	#goods_eff{
		no = 822,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(823) ->
	#goods_eff{
		no = 823,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(824) ->
	#goods_eff{
		no = 824,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(825) ->
	#goods_eff{
		no = 825,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(826) ->
	#goods_eff{
		no = 826,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(827) ->
	#goods_eff{
		no = 827,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(828) ->
	#goods_eff{
		no = 828,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(829) ->
	#goods_eff{
		no = 829,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(830) ->
	#goods_eff{
		no = 830,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(831) ->
	#goods_eff{
		no = 831,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(832) ->
	#goods_eff{
		no = 832,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(833) ->
	#goods_eff{
		no = 833,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(834) ->
	#goods_eff{
		no = 834,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(835) ->
	#goods_eff{
		no = 835,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(836) ->
	#goods_eff{
		no = 836,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(837) ->
	#goods_eff{
		no = 837,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(838) ->
	#goods_eff{
		no = 838,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(839) ->
	#goods_eff{
		no = 839,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(861) ->
	#goods_eff{
		no = 861,
		name = get_reward,
		trigger_proba = 100,
		para = 20000
};

get(862) ->
	#goods_eff{
		no = 862,
		name = get_reward,
		trigger_proba = 100,
		para = 20001
};

get(863) ->
	#goods_eff{
		no = 863,
		name = get_reward,
		trigger_proba = 100,
		para = 20002
};

get(864) ->
	#goods_eff{
		no = 864,
		name = get_reward,
		trigger_proba = 100,
		para = 20003
};

get(865) ->
	#goods_eff{
		no = 865,
		name = get_reward,
		trigger_proba = 100,
		para = 20004
};

get(866) ->
	#goods_eff{
		no = 866,
		name = get_reward,
		trigger_proba = 100,
		para = 20005
};

get(867) ->
	#goods_eff{
		no = 867,
		name = get_reward,
		trigger_proba = 100,
		para = 20006
};

get(868) ->
	#goods_eff{
		no = 868,
		name = get_reward,
		trigger_proba = 100,
		para = 20007
};

get(869) ->
	#goods_eff{
		no = 869,
		name = get_reward,
		trigger_proba = 100,
		para = 20008
};

get(870) ->
	#goods_eff{
		no = 870,
		name = get_reward,
		trigger_proba = 100,
		para = 20009
};

get(880) ->
	#goods_eff{
		no = 880,
		name = get_reward,
		trigger_proba = 100,
		para = 20020
};

get(881) ->
	#goods_eff{
		no = 881,
		name = get_reward,
		trigger_proba = 100,
		para = 20021
};

get(882) ->
	#goods_eff{
		no = 882,
		name = get_reward,
		trigger_proba = 100,
		para = 20022
};

get(883) ->
	#goods_eff{
		no = 883,
		name = get_reward,
		trigger_proba = 100,
		para = 20023
};

get(886) ->
	#goods_eff{
		no = 886,
		name = add_title,
		trigger_proba = 100,
		para = 70001
};

get(887) ->
	#goods_eff{
		no = 887,
		name = add_title,
		trigger_proba = 100,
		para = 70002
};

get(888) ->
	#goods_eff{
		no = 888,
		name = add_title,
		trigger_proba = 100,
		para = 70003
};

get(889) ->
	#goods_eff{
		no = 889,
		name = add_title,
		trigger_proba = 100,
		para = 70004
};

get(890) ->
	#goods_eff{
		no = 890,
		name = get_reward,
		trigger_proba = 100,
		para = 46074
};

get(891) ->
	#goods_eff{
		no = 891,
		name = get_reward,
		trigger_proba = 100,
		para = 46075
};

get(892) ->
	#goods_eff{
		no = 892,
		name = get_reward,
		trigger_proba = 100,
		para = 46076
};

get(893) ->
	#goods_eff{
		no = 893,
		name = get_reward,
		trigger_proba = 100,
		para = 50114
};

get(894) ->
	#goods_eff{
		no = 894,
		name = get_reward,
		trigger_proba = 100,
		para = 50115
};

get(895) ->
	#goods_eff{
		no = 895,
		name = get_reward,
		trigger_proba = 100,
		para = 50116
};

get(896) ->
	#goods_eff{
		no = 896,
		name = get_reward,
		trigger_proba = 100,
		para = 50117
};

get(897) ->
	#goods_eff{
		no = 897,
		name = get_reward,
		trigger_proba = 100,
		para = 50118
};

get(898) ->
	#goods_eff{
		no = 898,
		name = get_reward,
		trigger_proba = 100,
		para = 50119
};

get(899) ->
	#goods_eff{
		no = 899,
		name = get_reward,
		trigger_proba = 100,
		para = 50120
};

get(900) ->
	#goods_eff{
		no = 900,
		name = get_reward,
		trigger_proba = 100,
		para = 50121
};

get(901) ->
	#goods_eff{
		no = 901,
		name = get_reward,
		trigger_proba = 100,
		para = 50122
};

get(902) ->
	#goods_eff{
		no = 902,
		name = get_reward,
		trigger_proba = 100,
		para = 50123
};

get(903) ->
	#goods_eff{
		no = 903,
		name = get_reward,
		trigger_proba = 100,
		para = 50124
};

get(904) ->
	#goods_eff{
		no = 904,
		name = get_reward,
		trigger_proba = 100,
		para = 50125
};

get(905) ->
	#goods_eff{
		no = 905,
		name = get_reward,
		trigger_proba = 100,
		para = 50126
};

get(906) ->
	#goods_eff{
		no = 906,
		name = get_reward,
		trigger_proba = 100,
		para = 46077
};

get(907) ->
	#goods_eff{
		no = 907,
		name = get_reward,
		trigger_proba = 100,
		para = 46078
};

get(908) ->
	#goods_eff{
		no = 908,
		name = add_yuanbao,
		trigger_proba = 100,
		para = 80000
};

get(909) ->
	#goods_eff{
		no = 909,
		name = get_reward,
		trigger_proba = 100,
		para = 50127
};

get(910) ->
	#goods_eff{
		no = 910,
		name = get_reward,
		trigger_proba = 100,
		para = 46079
};

get(911) ->
	#goods_eff{
		no = 911,
		name = get_reward,
		trigger_proba = 100,
		para = 46080
};

get(912) ->
	#goods_eff{
		no = 912,
		name = get_reward,
		trigger_proba = 100,
		para = 50128
};

get(913) ->
	#goods_eff{
		no = 913,
		name = get_reward,
		trigger_proba = 100,
		para = 50129
};

get(914) ->
	#goods_eff{
		no = 914,
		name = get_reward,
		trigger_proba = 100,
		para = 50130
};

get(915) ->
	#goods_eff{
		no = 915,
		name = get_reward,
		trigger_proba = 100,
		para = 50131
};

get(916) ->
	#goods_eff{
		no = 916,
		name = get_reward,
		trigger_proba = 100,
		para = 46086
};

get(917) ->
	#goods_eff{
		no = 917,
		name = get_reward,
		trigger_proba = 100,
		para = 46087
};

get(918) ->
	#goods_eff{
		no = 918,
		name = get_reward,
		trigger_proba = 100,
		para = 46088
};

get(919) ->
	#goods_eff{
		no = 919,
		name = add_title,
		trigger_proba = 100,
		para = 70005
};

get(920) ->
	#goods_eff{
		no = 920,
		name = add_title,
		trigger_proba = 100,
		para = 70006
};

get(921) ->
	#goods_eff{
		no = 921,
		name = add_title,
		trigger_proba = 100,
		para = 70007
};

get(922) ->
	#goods_eff{
		no = 922,
		name = get_reward,
		trigger_proba = 100,
		para = 91045
};

get(923) ->
	#goods_eff{
		no = 923,
		name = get_reward,
		trigger_proba = 100,
		para = 140001
};

get(924) ->
	#goods_eff{
		no = 924,
		name = get_reward,
		trigger_proba = 100,
		para = 140002
};

get(925) ->
	#goods_eff{
		no = 925,
		name = get_reward,
		trigger_proba = 100,
		para = 140003
};

get(926) ->
	#goods_eff{
		no = 926,
		name = get_reward,
		trigger_proba = 100,
		para = 46082
};

get(927) ->
	#goods_eff{
		no = 927,
		name = get_reward,
		trigger_proba = 100,
		para = 46083
};

get(928) ->
	#goods_eff{
		no = 928,
		name = get_reward,
		trigger_proba = 100,
		para = 46085
};

get(929) ->
	#goods_eff{
		no = 929,
		name = get_reward,
		trigger_proba = 100,
		para = 91100
};

get(5076) ->
	#goods_eff{
		no = 5076,
		name = get_reward,
		trigger_proba = 100,
		para = 91080
};

get(961) ->
	#goods_eff{
		no = 961,
		name = get_reward,
		trigger_proba = 100,
		para = 91090
};

get(962) ->
	#goods_eff{
		no = 962,
		name = get_reward,
		trigger_proba = 100,
		para = 91091
};

get(963) ->
	#goods_eff{
		no = 963,
		name = get_reward,
		trigger_proba = 100,
		para = 91092
};

get(964) ->
	#goods_eff{
		no = 964,
		name = get_reward,
		trigger_proba = 100,
		para = 91093
};

get(965) ->
	#goods_eff{
		no = 965,
		name = get_reward,
		trigger_proba = 100,
		para = 91094
};

get(966) ->
	#goods_eff{
		no = 966,
		name = get_reward,
		trigger_proba = 100,
		para = 91095
};

get(967) ->
	#goods_eff{
		no = 967,
		name = get_reward,
		trigger_proba = 100,
		para = 91096
};

get(968) ->
	#goods_eff{
		no = 968,
		name = get_reward,
		trigger_proba = 100,
		para = 91097
};

get(969) ->
	#goods_eff{
		no = 969,
		name = get_reward,
		trigger_proba = 100,
		para = 91098
};

get(970) ->
	#goods_eff{
		no = 970,
		name = get_reward,
		trigger_proba = 100,
		para = 91099
};

get(5000) ->
	#goods_eff{
		no = 5000,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5001) ->
	#goods_eff{
		no = 5001,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5002) ->
	#goods_eff{
		no = 5002,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5003) ->
	#goods_eff{
		no = 5003,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5004) ->
	#goods_eff{
		no = 5004,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5005) ->
	#goods_eff{
		no = 5005,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5006) ->
	#goods_eff{
		no = 5006,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5007) ->
	#goods_eff{
		no = 5007,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5008) ->
	#goods_eff{
		no = 5008,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5009) ->
	#goods_eff{
		no = 5009,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5010) ->
	#goods_eff{
		no = 5010,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5011) ->
	#goods_eff{
		no = 5011,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5012) ->
	#goods_eff{
		no = 5012,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5013) ->
	#goods_eff{
		no = 5013,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5014) ->
	#goods_eff{
		no = 5014,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5015) ->
	#goods_eff{
		no = 5015,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5016) ->
	#goods_eff{
		no = 5016,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5017) ->
	#goods_eff{
		no = 5017,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5018) ->
	#goods_eff{
		no = 5018,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5019) ->
	#goods_eff{
		no = 5019,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5020) ->
	#goods_eff{
		no = 5020,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5021) ->
	#goods_eff{
		no = 5021,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5022) ->
	#goods_eff{
		no = 5022,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5023) ->
	#goods_eff{
		no = 5023,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5024) ->
	#goods_eff{
		no = 5024,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5025) ->
	#goods_eff{
		no = 5025,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5026) ->
	#goods_eff{
		no = 5026,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5027) ->
	#goods_eff{
		no = 5027,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5028) ->
	#goods_eff{
		no = 5028,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5029) ->
	#goods_eff{
		no = 5029,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5030) ->
	#goods_eff{
		no = 5030,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5031) ->
	#goods_eff{
		no = 5031,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5032) ->
	#goods_eff{
		no = 5032,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5033) ->
	#goods_eff{
		no = 5033,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5034) ->
	#goods_eff{
		no = 5034,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5035) ->
	#goods_eff{
		no = 5035,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5036) ->
	#goods_eff{
		no = 5036,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5037) ->
	#goods_eff{
		no = 5037,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5038) ->
	#goods_eff{
		no = 5038,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5039) ->
	#goods_eff{
		no = 5039,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5040) ->
	#goods_eff{
		no = 5040,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5041) ->
	#goods_eff{
		no = 5041,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5042) ->
	#goods_eff{
		no = 5042,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5043) ->
	#goods_eff{
		no = 5043,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5044) ->
	#goods_eff{
		no = 5044,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5045) ->
	#goods_eff{
		no = 5045,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5046) ->
	#goods_eff{
		no = 5046,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5047) ->
	#goods_eff{
		no = 5047,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5048) ->
	#goods_eff{
		no = 5048,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5049) ->
	#goods_eff{
		no = 5049,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5050) ->
	#goods_eff{
		no = 5050,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5051) ->
	#goods_eff{
		no = 5051,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5052) ->
	#goods_eff{
		no = 5052,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5053) ->
	#goods_eff{
		no = 5053,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5054) ->
	#goods_eff{
		no = 5054,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5055) ->
	#goods_eff{
		no = 5055,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5056) ->
	#goods_eff{
		no = 5056,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5057) ->
	#goods_eff{
		no = 5057,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5058) ->
	#goods_eff{
		no = 5058,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5059) ->
	#goods_eff{
		no = 5059,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5060) ->
	#goods_eff{
		no = 5060,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5061) ->
	#goods_eff{
		no = 5061,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5062) ->
	#goods_eff{
		no = 5062,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5063) ->
	#goods_eff{
		no = 5063,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5064) ->
	#goods_eff{
		no = 5064,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5065) ->
	#goods_eff{
		no = 5065,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5066) ->
	#goods_eff{
		no = 5066,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5067) ->
	#goods_eff{
		no = 5067,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5068) ->
	#goods_eff{
		no = 5068,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5069) ->
	#goods_eff{
		no = 5069,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5070) ->
	#goods_eff{
		no = 5070,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5071) ->
	#goods_eff{
		no = 5071,
		name = add_hp,
		trigger_proba = 100,
		para = 1
};

get(5072) ->
	#goods_eff{
		no = 5072,
		name = get_reward,
		trigger_proba = 100,
		para = 91101
};

get(5073) ->
	#goods_eff{
		no = 5073,
		name = get_reward,
		trigger_proba = 100,
		para = 91106
};

get(5074) ->
	#goods_eff{
		no = 5074,
		name = add_gamemoney,
		trigger_proba = 100,
		para = 50000000
};

get(5075) ->
	#goods_eff{
		no = 5075,
		name = get_reward,
		trigger_proba = 100,
		para = 91102
};

get(5077) ->
	#goods_eff{
		no = 5077,
		name = get_reward,
		trigger_proba = 100,
		para = 91103
};

get(5078) ->
	#goods_eff{
		no = 5078,
		name = get_reward,
		trigger_proba = 100,
		para = 91104
};

get(5079) ->
	#goods_eff{
		no = 5079,
		name = get_reward,
		trigger_proba = 100,
		para = 91105
};

get(5080) ->
	#goods_eff{
		no = 5080,
		name = get_reward,
		trigger_proba = 100,
		para = 91107
};

get(5081) ->
	#goods_eff{
		no = 5081,
		name = get_reward,
		trigger_proba = 100,
		para = 91108
};

get(5082) ->
	#goods_eff{
		no = 5082,
		name = get_reward,
		trigger_proba = 100,
		para = 91109
};

get(5083) ->
	#goods_eff{
		no = 5083,
		name = get_reward,
		trigger_proba = 100,
		para = 91110
};

get(5084) ->
	#goods_eff{
		no = 5084,
		name = get_reward,
		trigger_proba = 100,
		para = 91111
};

get(5085) ->
	#goods_eff{
		no = 5085,
		name = get_reward,
		trigger_proba = 100,
		para = 91112
};

get(5086) ->
	#goods_eff{
		no = 5086,
		name = get_reward,
		trigger_proba = 100,
		para = 91113
};

get(5087) ->
	#goods_eff{
		no = 5087,
		name = get_reward,
		trigger_proba = 100,
		para = 91114
};

get(5088) ->
	#goods_eff{
		no = 5088,
		name = get_reward,
		trigger_proba = 100,
		para = 91115
};

get(5099) ->
	#goods_eff{
		no = 5099,
		name = add_title,
		trigger_proba = 100,
		para = 70008
};

get(5100) ->
	#goods_eff{
		no = 5100,
		name = get_reward,
		trigger_proba = 100,
		para = 91116
};

get(5101) ->
	#goods_eff{
		no = 5101,
		name = get_reward,
		trigger_proba = 100,
		para = 91117
};

get(5102) ->
	#goods_eff{
		no = 5102,
		name = get_reward,
		trigger_proba = 100,
		para = 91118
};

get(5103) ->
	#goods_eff{
		no = 5103,
		name = get_reward,
		trigger_proba = 100,
		para = 91119
};

get(5104) ->
	#goods_eff{
		no = 5104,
		name = get_reward,
		trigger_proba = 100,
		para = 91120
};

get(5105) ->
	#goods_eff{
		no = 5105,
		name = get_reward,
		trigger_proba = 100,
		para = 91121
};

get(5106) ->
	#goods_eff{
		no = 5106,
		name = get_reward,
		trigger_proba = 100,
		para = 91122
};

get(5107) ->
	#goods_eff{
		no = 5107,
		name = get_reward,
		trigger_proba = 100,
		para = 91128
};

get(5108) ->
	#goods_eff{
		no = 5108,
		name = get_mounts,
		trigger_proba = 100,
		para = 1006
};

get(5109) ->
	#goods_eff{
		no = 5109,
		name = get_mounts,
		trigger_proba = 100,
		para = 1007
};

get(5110) ->
	#goods_eff{
		no = 5110,
		name = get_mounts,
		trigger_proba = 100,
		para = 1008
};

get(5111) ->
	#goods_eff{
		no = 5111,
		name = get_mounts,
		trigger_proba = 100,
		para = 1009
};

get(5112) ->
	#goods_eff{
		no = 5112,
		name = get_reward,
		trigger_proba = 100,
		para = 91129
};

get(5113) ->
	#goods_eff{
		no = 5113,
		name = get_reward,
		trigger_proba = 100,
		para = 91130
};

get(5114) ->
	#goods_eff{
		no = 5114,
		name = get_reward,
		trigger_proba = 100,
		para = 91131
};

get(5115) ->
	#goods_eff{
		no = 5115,
		name = get_reward,
		trigger_proba = 100,
		para = 91132
};

get(5116) ->
	#goods_eff{
		no = 5116,
		name = get_reward,
		trigger_proba = 100,
		para = 91133
};

get(5117) ->
	#goods_eff{
		no = 5117,
		name = get_reward,
		trigger_proba = 100,
		para = 91134
};

get(5118) ->
	#goods_eff{
		no = 5118,
		name = get_reward,
		trigger_proba = 100,
		para = 91135
};

get(5119) ->
	#goods_eff{
		no = 5119,
		name = get_reward,
		trigger_proba = 100,
		para = 91136
};

get(5120) ->
	#goods_eff{
		no = 5120,
		name = get_reward,
		trigger_proba = 100,
		para = 91137
};

get(5121) ->
	#goods_eff{
		no = 5121,
		name = get_reward,
		trigger_proba = 100,
		para = 91138
};

get(5122) ->
	#goods_eff{
		no = 5122,
		name = get_reward,
		trigger_proba = 100,
		para = 91139
};

get(5123) ->
	#goods_eff{
		no = 5123,
		name = get_reward,
		trigger_proba = 100,
		para = 91140
};

get(5124) ->
	#goods_eff{
		no = 5124,
		name = add_title,
		trigger_proba = 100,
		para = 70008
};

get(5125) ->
	#goods_eff{
		no = 5125,
		name = add_title,
		trigger_proba = 100,
		para = 70009
};

get(5126) ->
	#goods_eff{
		no = 5126,
		name = add_title,
		trigger_proba = 100,
		para = 70011
};

get(5127) ->
	#goods_eff{
		no = 5127,
		name = add_title,
		trigger_proba = 100,
		para = 70014
};

get(5128) ->
	#goods_eff{
		no = 5128,
		name = add_title,
		trigger_proba = 100,
		para = 70015
};

get(5129) ->
	#goods_eff{
		no = 5129,
		name = add_title,
		trigger_proba = 100,
		para = 70013
};

get(5130) ->
	#goods_eff{
		no = 5130,
		name = add_title,
		trigger_proba = 100,
		para = 70022
};

get(5131) ->
	#goods_eff{
		no = 5131,
		name = add_title,
		trigger_proba = 100,
		para = 70021
};

get(932) ->
	#goods_eff{
		no = 932,
		name = get_reward,
		trigger_proba = 100,
		para = 91049
};

get(5132) ->
	#goods_eff{
		no = 5132,
		name = get_reward,
		trigger_proba = 100,
		para = 91141
};

get(5133) ->
	#goods_eff{
		no = 5133,
		name = get_reward,
		trigger_proba = 100,
		para = 91142
};

get(5134) ->
	#goods_eff{
		no = 5134,
		name = get_reward,
		trigger_proba = 100,
		para = 91196
};

get(5135) ->
	#goods_eff{
		no = 5135,
		name = add_title,
		trigger_proba = 100,
		para = 70010
};

get(5136) ->
	#goods_eff{
		no = 5136,
		name = add_title,
		trigger_proba = 100,
		para = 70012
};

get(5137) ->
	#goods_eff{
		no = 5137,
		name = add_title,
		trigger_proba = 100,
		para = 70016
};

get(5138) ->
	#goods_eff{
		no = 5138,
		name = add_title,
		trigger_proba = 100,
		para = 70017
};

get(5139) ->
	#goods_eff{
		no = 5139,
		name = add_title,
		trigger_proba = 100,
		para = 70018
};

get(5140) ->
	#goods_eff{
		no = 5140,
		name = add_title,
		trigger_proba = 100,
		para = 70019
};

get(5141) ->
	#goods_eff{
		no = 5141,
		name = add_title,
		trigger_proba = 100,
		para = 70023
};

get(5142) ->
	#goods_eff{
		no = 5142,
		name = add_title,
		trigger_proba = 100,
		para = 70026
};

get(5143) ->
	#goods_eff{
		no = 5143,
		name = add_title,
		trigger_proba = 100,
		para = 70028
};

get(5230) ->
	#goods_eff{
		no = 5230,
		name = get_reward,
		trigger_proba = 100,
		para = 91291
};

get(5231) ->
	#goods_eff{
		no = 5231,
		name = get_reward,
		trigger_proba = 100,
		para = 91292
};

get(5232) ->
	#goods_eff{
		no = 5232,
		name = get_reward,
		trigger_proba = 100,
		para = 91293
};

get(5233) ->
	#goods_eff{
		no = 5233,
		name = get_reward,
		trigger_proba = 100,
		para = 91294
};

get(5234) ->
	#goods_eff{
		no = 5234,
		name = get_reward,
		trigger_proba = 100,
		para = 91295
};

get(5235) ->
	#goods_eff{
		no = 5235,
		name = get_reward,
		trigger_proba = 100,
		para = 91296
};

get(5236) ->
	#goods_eff{
		no = 5236,
		name = get_reward,
		trigger_proba = 100,
		para = 91297
};

get(5237) ->
	#goods_eff{
		no = 5237,
		name = get_reward,
		trigger_proba = 100,
		para = 91298
};

get(5238) ->
	#goods_eff{
		no = 5238,
		name = get_reward,
		trigger_proba = 100,
		para = 91299
};

get(5239) ->
	#goods_eff{
		no = 5239,
		name = get_reward,
		trigger_proba = 100,
		para = 91300
};

get(5240) ->
	#goods_eff{
		no = 5240,
		name = get_reward,
		trigger_proba = 100,
		para = 91301
};

get(5241) ->
	#goods_eff{
		no = 5241,
		name = get_reward,
		trigger_proba = 100,
		para = 91302
};

get(5242) ->
	#goods_eff{
		no = 5242,
		name = get_reward,
		trigger_proba = 100,
		para = 91303
};

get(5243) ->
	#goods_eff{
		no = 5243,
		name = get_reward,
		trigger_proba = 100,
		para = 91304
};

get(5244) ->
	#goods_eff{
		no = 5244,
		name = get_reward,
		trigger_proba = 100,
		para = 91305
};

get(5245) ->
	#goods_eff{
		no = 5245,
		name = get_reward,
		trigger_proba = 100,
		para = 91306
};

get(5246) ->
	#goods_eff{
		no = 5246,
		name = get_reward,
		trigger_proba = 100,
		para = 91307
};

get(5247) ->
	#goods_eff{
		no = 5247,
		name = get_reward,
		trigger_proba = 100,
		para = 91308
};

get(5287) ->
	#goods_eff{
		no = 5287,
		name = get_reward,
		trigger_proba = 100,
		para = 91353
};

get(5288) ->
	#goods_eff{
		no = 5288,
		name = get_reward,
		trigger_proba = 100,
		para = 91354
};

get(5289) ->
	#goods_eff{
		no = 5289,
		name = get_reward,
		trigger_proba = 100,
		para = 91355
};

get(5290) ->
	#goods_eff{
		no = 5290,
		name = get_reward,
		trigger_proba = 100,
		para = 91356
};

get(5291) ->
	#goods_eff{
		no = 5291,
		name = get_reward,
		trigger_proba = 100,
		para = 91357
};

get(5292) ->
	#goods_eff{
		no = 5292,
		name = get_reward,
		trigger_proba = 100,
		para = 91358
};

get(5293) ->
	#goods_eff{
		no = 5293,
		name = get_reward,
		trigger_proba = 100,
		para = 91359
};

get(5294) ->
	#goods_eff{
		no = 5294,
		name = get_reward,
		trigger_proba = 100,
		para = 91360
};

get(5295) ->
	#goods_eff{
		no = 5295,
		name = get_reward,
		trigger_proba = 100,
		para = 91361
};

get(5296) ->
	#goods_eff{
		no = 5296,
		name = get_reward,
		trigger_proba = 100,
		para = 91362
};

get(5297) ->
	#goods_eff{
		no = 5297,
		name = get_reward,
		trigger_proba = 100,
		para = 91363
};

get(5298) ->
	#goods_eff{
		no = 5298,
		name = get_reward,
		trigger_proba = 100,
		para = 91364
};

get(5299) ->
	#goods_eff{
		no = 5299,
		name = get_reward,
		trigger_proba = 100,
		para = 91365
};

get(5300) ->
	#goods_eff{
		no = 5300,
		name = get_reward,
		trigger_proba = 100,
		para = 91366
};

get(5301) ->
	#goods_eff{
		no = 5301,
		name = get_reward,
		trigger_proba = 100,
		para = 91367
};

get(5302) ->
	#goods_eff{
		no = 5302,
		name = get_reward,
		trigger_proba = 100,
		para = 91368
};

get(5303) ->
	#goods_eff{
		no = 5303,
		name = get_reward,
		trigger_proba = 100,
		para = 91369
};

get(5304) ->
	#goods_eff{
		no = 5304,
		name = get_reward,
		trigger_proba = 100,
		para = 91370
};

get(5305) ->
	#goods_eff{
		no = 5305,
		name = get_reward,
		trigger_proba = 100,
		para = 91371
};

get(5306) ->
	#goods_eff{
		no = 5306,
		name = get_reward,
		trigger_proba = 100,
		para = 91372
};

get(5307) ->
	#goods_eff{
		no = 5307,
		name = get_reward,
		trigger_proba = 100,
		para = 91373
};

get(5308) ->
	#goods_eff{
		no = 5308,
		name = get_reward,
		trigger_proba = 100,
		para = 91374
};

get(5309) ->
	#goods_eff{
		no = 5309,
		name = get_reward,
		trigger_proba = 100,
		para = 91375
};

get(5310) ->
	#goods_eff{
		no = 5310,
		name = get_reward,
		trigger_proba = 100,
		para = 91376
};

get(5311) ->
	#goods_eff{
		no = 5311,
		name = get_reward,
		trigger_proba = 100,
		para = 91377
};

get(5312) ->
	#goods_eff{
		no = 5312,
		name = get_reward,
		trigger_proba = 100,
		para = 91378
};

get(5313) ->
	#goods_eff{
		no = 5313,
		name = get_reward,
		trigger_proba = 100,
		para = 91379
};

get(5314) ->
	#goods_eff{
		no = 5314,
		name = get_reward,
		trigger_proba = 100,
		para = 91380
};

get(5315) ->
	#goods_eff{
		no = 5315,
		name = get_reward,
		trigger_proba = 100,
		para = 91381
};

get(5316) ->
	#goods_eff{
		no = 5316,
		name = get_reward,
		trigger_proba = 100,
		para = 91382
};

get(5317) ->
	#goods_eff{
		no = 5317,
		name = get_reward,
		trigger_proba = 100,
		para = 91383
};

get(5318) ->
	#goods_eff{
		no = 5318,
		name = get_reward,
		trigger_proba = 100,
		para = 91384
};

get(5319) ->
	#goods_eff{
		no = 5319,
		name = get_reward,
		trigger_proba = 100,
		para = 91385
};

get(5320) ->
	#goods_eff{
		no = 5320,
		name = get_reward,
		trigger_proba = 100,
		para = 91386
};

get(5321) ->
	#goods_eff{
		no = 5321,
		name = get_reward,
		trigger_proba = 100,
		para = 91387
};

get(5322) ->
	#goods_eff{
		no = 5322,
		name = get_reward,
		trigger_proba = 100,
		para = 91388
};

get(933) ->
	#goods_eff{
		no = 933,
		name = get_reward,
		trigger_proba = 100,
		para = 91062
};

get(5323) ->
	#goods_eff{
		no = 5323,
		name = add_title,
		trigger_proba = 100,
		para = 70027
};

get(5324) ->
	#goods_eff{
		no = 5324,
		name = get_reward,
		trigger_proba = 100,
		para = 91389
};

get(5325) ->
	#goods_eff{
		no = 5325,
		name = add_yuanbao,
		trigger_proba = 100,
		para = 100000
};

get(5326) ->
	#goods_eff{
		no = 5326,
		name = add_buff,
		trigger_proba = 100,
		para = 100002
};

get(5327) ->
	#goods_eff{
		no = 5327,
		name = add_buff,
		trigger_proba = 100,
		para = 100003
};

get(5328) ->
	#goods_eff{
		no = 5328,
		name = activate_fund_recharge_rebates,
		trigger_proba = 100,
		para = 1
};

get(5329) ->
	#goods_eff{
		no = 5329,
		name = activate_fund_recharge_rebates,
		trigger_proba = 100,
		para = 2
};

get(5330) ->
	#goods_eff{
		no = 5330,
		name = activate_fund_recharge_rebates,
		trigger_proba = 100,
		para = 3
};

get(5331) ->
	#goods_eff{
		no = 5331,
		name = get_reward,
		trigger_proba = 100,
		para = 91194
};

get(5332) ->
	#goods_eff{
		no = 5332,
		name = get_reward,
		trigger_proba = 100,
		para = 91195
};

get(5333) ->
	#goods_eff{
		no = 5333,
		name = get_reward,
		trigger_proba = 100,
		para = 91197
};

get(5334) ->
	#goods_eff{
		no = 5334,
		name = add_title,
		trigger_proba = 100,
		para = 70025
};

get(5335) ->
	#goods_eff{
		no = 5335,
		name = get_reward,
		trigger_proba = 100,
		para = 91390
};

get(5336) ->
	#goods_eff{
		no = 5336,
		name = get_reward,
		trigger_proba = 100,
		para = 91391
};

get(5337) ->
	#goods_eff{
		no = 5337,
		name = get_reward,
		trigger_proba = 100,
		para = 91392
};

get(5338) ->
	#goods_eff{
		no = 5338,
		name = get_reward,
		trigger_proba = 100,
		para = 91393
};

get(5339) ->
	#goods_eff{
		no = 5339,
		name = get_reward,
		trigger_proba = 100,
		para = 91394
};

get(5340) ->
	#goods_eff{
		no = 5340,
		name = add_title,
		trigger_proba = 100,
		para = 70029
};

get(5341) ->
	#goods_eff{
		no = 5341,
		name = add_title,
		trigger_proba = 100,
		para = 70030
};

get(5342) ->
	#goods_eff{
		no = 5342,
		name = add_title,
		trigger_proba = 100,
		para = 70031
};

get(5343) ->
	#goods_eff{
		no = 5343,
		name = get_reward,
		trigger_proba = 100,
		para = 91395
};

get(5344) ->
	#goods_eff{
		no = 5344,
		name = activate_vip_recharge_rebates,
		trigger_proba = 100,
		para = 2
};

get(5345) ->
	#goods_eff{
		no = 5345,
		name = activate_vip_recharge_rebates,
		trigger_proba = 100,
		para = 3
};

get(5346) ->
	#goods_eff{
		no = 5346,
		name = activate_vip_recharge_rebates,
		trigger_proba = 100,
		para = 4
};

get(5347) ->
	#goods_eff{
		no = 5347,
		name = get_reward,
		trigger_proba = 100,
		para = 91400
};

get(5348) ->
	#goods_eff{
		no = 5348,
		name = get_reward,
		trigger_proba = 100,
		para = 91401
};

get(5349) ->
	#goods_eff{
		no = 5349,
		name = get_reward,
		trigger_proba = 100,
		para = 91402
};

get(5350) ->
	#goods_eff{
		no = 5350,
		name = get_reward,
		trigger_proba = 100,
		para = 91403
};

get(5351) ->
	#goods_eff{
		no = 5351,
		name = get_reward,
		trigger_proba = 100,
		para = 91404
};

get(5352) ->
	#goods_eff{
		no = 5352,
		name = get_reward,
		trigger_proba = 100,
		para = 91405
};

get(5353) ->
	#goods_eff{
		no = 5353,
		name = get_reward,
		trigger_proba = 100,
		para = 91406
};

get(5354) ->
	#goods_eff{
		no = 5354,
		name = get_reward,
		trigger_proba = 100,
		para = 91407
};

get(5355) ->
	#goods_eff{
		no = 5355,
		name = get_reward,
		trigger_proba = 100,
		para = 91408
};

get(5356) ->
	#goods_eff{
		no = 5356,
		name = get_reward,
		trigger_proba = 100,
		para = 91409
};

get(5357) ->
	#goods_eff{
		no = 5357,
		name = get_reward,
		trigger_proba = 100,
		para = 91410
};

get(5358) ->
	#goods_eff{
		no = 5358,
		name = get_reward,
		trigger_proba = 100,
		para = 91411
};

get(5359) ->
	#goods_eff{
		no = 5359,
		name = get_reward,
		trigger_proba = 100,
		para = 91412
};

get(5360) ->
	#goods_eff{
		no = 5360,
		name = get_internal_skill,
		trigger_proba = 100,
		para = 100000
};

get(5361) ->
	#goods_eff{
		no = 5361,
		name = get_internal_skill,
		trigger_proba = 100,
		para = 100001
};

get(5362) ->
	#goods_eff{
		no = 5362,
		name = get_internal_skill,
		trigger_proba = 100,
		para = 100002
};

get(5363) ->
	#goods_eff{
		no = 5363,
		name = get_internal_skill,
		trigger_proba = 100,
		para = 100003
};

get(5364) ->
	#goods_eff{
		no = 5364,
		name = get_internal_skill,
		trigger_proba = 100,
		para = 100004
};

get(5365) ->
	#goods_eff{
		no = 5365,
		name = get_internal_skill,
		trigger_proba = 100,
		para = 100005
};

get(5366) ->
	#goods_eff{
		no = 5366,
		name = get_internal_skill,
		trigger_proba = 100,
		para = 100006
};

get(5367) ->
	#goods_eff{
		no = 5367,
		name = get_internal_skill,
		trigger_proba = 100,
		para = 100007
};

get(5368) ->
	#goods_eff{
		no = 5368,
		name = get_internal_skill,
		trigger_proba = 100,
		para = 100008
};

get(5369) ->
	#goods_eff{
		no = 5369,
		name = get_internal_skill,
		trigger_proba = 100,
		para = 100009
};

get(5370) ->
	#goods_eff{
		no = 5370,
		name = get_internal_skill,
		trigger_proba = 100,
		para = 100010
};

get(5371) ->
	#goods_eff{
		no = 5371,
		name = get_internal_skill,
		trigger_proba = 100,
		para = 100011
};

get(5372) ->
	#goods_eff{
		no = 5372,
		name = get_internal_skill,
		trigger_proba = 100,
		para = 100012
};

get(5373) ->
	#goods_eff{
		no = 5373,
		name = get_internal_skill,
		trigger_proba = 100,
		para = 100013
};

get(5374) ->
	#goods_eff{
		no = 5374,
		name = get_internal_skill,
		trigger_proba = 100,
		para = 100014
};

get(5375) ->
	#goods_eff{
		no = 5375,
		name = get_internal_skill,
		trigger_proba = 100,
		para = 100015
};

get(5376) ->
	#goods_eff{
		no = 5376,
		name = get_internal_skill,
		trigger_proba = 100,
		para = 100016
};

get(5377) ->
	#goods_eff{
		no = 5377,
		name = get_internal_skill,
		trigger_proba = 100,
		para = 100017
};

get(5378) ->
	#goods_eff{
		no = 5378,
		name = get_internal_skill,
		trigger_proba = 100,
		para = 100018
};

get(5379) ->
	#goods_eff{
		no = 5379,
		name = get_internal_skill,
		trigger_proba = 100,
		para = 100019
};

get(5380) ->
	#goods_eff{
		no = 5380,
		name = get_internal_skill,
		trigger_proba = 100,
		para = 100020
};

get(5381) ->
	#goods_eff{
		no = 5381,
		name = get_internal_skill,
		trigger_proba = 100,
		para = 100021
};

get(5382) ->
	#goods_eff{
		no = 5382,
		name = get_internal_skill,
		trigger_proba = 100,
		para = 100022
};

get(5383) ->
	#goods_eff{
		no = 5383,
		name = get_internal_skill,
		trigger_proba = 100,
		para = 100023
};

get(5384) ->
	#goods_eff{
		no = 5384,
		name = get_internal_skill,
		trigger_proba = 100,
		para = 100024
};

get(5385) ->
	#goods_eff{
		no = 5385,
		name = get_internal_skill,
		trigger_proba = 100,
		para = 100025
};

get(5386) ->
	#goods_eff{
		no = 5386,
		name = get_internal_skill,
		trigger_proba = 100,
		para = 100026
};

get(5387) ->
	#goods_eff{
		no = 5387,
		name = get_internal_skill,
		trigger_proba = 100,
		para = 100027
};

get(5388) ->
	#goods_eff{
		no = 5388,
		name = get_internal_skill,
		trigger_proba = 100,
		para = 100028
};

get(5389) ->
	#goods_eff{
		no = 5389,
		name = get_internal_skill,
		trigger_proba = 100,
		para = 100029
};

get(5390) ->
	#goods_eff{
		no = 5390,
		name = get_internal_skill,
		trigger_proba = 100,
		para = 100030
};

get(5391) ->
	#goods_eff{
		no = 5391,
		name = get_internal_skill,
		trigger_proba = 100,
		para = 100031
};

get(5392) ->
	#goods_eff{
		no = 5392,
		name = get_internal_skill,
		trigger_proba = 100,
		para = 100032
};

get(5393) ->
	#goods_eff{
		no = 5393,
		name = get_internal_skill,
		trigger_proba = 100,
		para = 100033
};

get(5394) ->
	#goods_eff{
		no = 5394,
		name = get_reward,
		trigger_proba = 100,
		para = 91413
};

get(5395) ->
	#goods_eff{
		no = 5395,
		name = get_reward,
		trigger_proba = 100,
		para = 91414
};

get(5396) ->
	#goods_eff{
		no = 5396,
		name = get_reward,
		trigger_proba = 100,
		para = 91415
};

get(5397) ->
	#goods_eff{
		no = 5397,
		name = get_reward,
		trigger_proba = 100,
		para = 91416
};

get(5398) ->
	#goods_eff{
		no = 5398,
		name = get_reward,
		trigger_proba = 100,
		para = 91417
};

get(5399) ->
	#goods_eff{
		no = 5399,
		name = get_mounts,
		trigger_proba = 100,
		para = 1010
};

get(5400) ->
	#goods_eff{
		no = 5400,
		name = get_mounts,
		trigger_proba = 100,
		para = 1011
};

get(5401) ->
	#goods_eff{
		no = 5401,
		name = get_mounts,
		trigger_proba = 100,
		para = 1012
};

get(5402) ->
	#goods_eff{
		no = 5402,
		name = get_mounts,
		trigger_proba = 100,
		para = 1013
};

get(5403) ->
	#goods_eff{
		no = 5403,
		name = get_reward,
		trigger_proba = 100,
		para = 91424
};

get(5205) ->
	#goods_eff{
		no = 5205,
		name = get_reward,
		trigger_proba = 100,
		para = 91267
};

get(5206) ->
	#goods_eff{
		no = 5206,
		name = get_reward,
		trigger_proba = 100,
		para = 91268
};

get(5207) ->
	#goods_eff{
		no = 5207,
		name = get_reward,
		trigger_proba = 100,
		para = 91269
};

get(5208) ->
	#goods_eff{
		no = 5208,
		name = get_reward,
		trigger_proba = 100,
		para = 91270
};

get(5209) ->
	#goods_eff{
		no = 5209,
		name = get_reward,
		trigger_proba = 100,
		para = 91271
};

get(5210) ->
	#goods_eff{
		no = 5210,
		name = get_reward,
		trigger_proba = 100,
		para = 91272
};

get(5211) ->
	#goods_eff{
		no = 5211,
		name = get_reward,
		trigger_proba = 100,
		para = 91273
};

get(5212) ->
	#goods_eff{
		no = 5212,
		name = get_reward,
		trigger_proba = 100,
		para = 91274
};

get(5213) ->
	#goods_eff{
		no = 5213,
		name = get_reward,
		trigger_proba = 100,
		para = 91275
};

get(5214) ->
	#goods_eff{
		no = 5214,
		name = get_reward,
		trigger_proba = 100,
		para = 91276
};

get(5215) ->
	#goods_eff{
		no = 5215,
		name = get_reward,
		trigger_proba = 100,
		para = 91277
};

get(5216) ->
	#goods_eff{
		no = 5216,
		name = get_reward,
		trigger_proba = 100,
		para = 91278
};

get(5217) ->
	#goods_eff{
		no = 5217,
		name = get_reward,
		trigger_proba = 100,
		para = 91279
};

get(5218) ->
	#goods_eff{
		no = 5218,
		name = get_reward,
		trigger_proba = 100,
		para = 91280
};

get(5219) ->
	#goods_eff{
		no = 5219,
		name = get_reward,
		trigger_proba = 100,
		para = 91281
};

get(5404) ->
	#goods_eff{
		no = 5404,
		name = get_reward,
		trigger_proba = 100,
		para = 91425
};

get(5405) ->
	#goods_eff{
		no = 5405,
		name = get_reward,
		trigger_proba = 100,
		para = 91426
};

get(5406) ->
	#goods_eff{
		no = 5406,
		name = get_reward,
		trigger_proba = 100,
		para = 91427
};

get(5407) ->
	#goods_eff{
		no = 5407,
		name = get_reward,
		trigger_proba = 100,
		para = 91428
};

get(5408) ->
	#goods_eff{
		no = 5408,
		name = get_reward,
		trigger_proba = 100,
		para = 91429
};

get(5409) ->
	#goods_eff{
		no = 5409,
		name = get_reward,
		trigger_proba = 100,
		para = 91430
};

get(5410) ->
	#goods_eff{
		no = 5410,
		name = get_reward,
		trigger_proba = 100,
		para = 91431
};

get(5411) ->
	#goods_eff{
		no = 5411,
		name = get_reward,
		trigger_proba = 100,
		para = 91432
};

get(5412) ->
	#goods_eff{
		no = 5412,
		name = get_reward,
		trigger_proba = 100,
		para = 91433
};

get(5413) ->
	#goods_eff{
		no = 5413,
		name = get_reward,
		trigger_proba = 100,
		para = 91434
};

get(5414) ->
	#goods_eff{
		no = 5414,
		name = get_reward,
		trigger_proba = 100,
		para = 91435
};

get(5415) ->
	#goods_eff{
		no = 5415,
		name = get_reward,
		trigger_proba = 100,
		para = 91436
};

get(5416) ->
	#goods_eff{
		no = 5416,
		name = get_reward,
		trigger_proba = 100,
		para = 91437
};

get(5417) ->
	#goods_eff{
		no = 5417,
		name = get_reward,
		trigger_proba = 100,
		para = 91438
};

get(5418) ->
	#goods_eff{
		no = 5418,
		name = get_reward,
		trigger_proba = 100,
		para = 91439
};

get(5419) ->
	#goods_eff{
		no = 5419,
		name = get_reward,
		trigger_proba = 100,
		para = 91440
};

get(5420) ->
	#goods_eff{
		no = 5420,
		name = get_reward,
		trigger_proba = 100,
		para = 91441
};

get(5421) ->
	#goods_eff{
		no = 5421,
		name = get_reward,
		trigger_proba = 100,
		para = 91442
};

get(5422) ->
	#goods_eff{
		no = 5422,
		name = get_reward,
		trigger_proba = 100,
		para = 91443
};

get(5423) ->
	#goods_eff{
		no = 5423,
		name = get_reward,
		trigger_proba = 100,
		para = 91444
};

get(5424) ->
	#goods_eff{
		no = 5424,
		name = get_reward,
		trigger_proba = 100,
		para = 91445
};

get(5425) ->
	#goods_eff{
		no = 5425,
		name = get_reward,
		trigger_proba = 100,
		para = 91446
};

get(5426) ->
	#goods_eff{
		no = 5426,
		name = get_reward,
		trigger_proba = 100,
		para = 91447
};

get(5427) ->
	#goods_eff{
		no = 5427,
		name = get_reward,
		trigger_proba = 100,
		para = 91448
};

get(5428) ->
	#goods_eff{
		no = 5428,
		name = get_reward,
		trigger_proba = 100,
		para = 91449
};

get(5429) ->
	#goods_eff{
		no = 5429,
		name = get_reward,
		trigger_proba = 100,
		para = 91450
};

get(5430) ->
	#goods_eff{
		no = 5430,
		name = get_reward,
		trigger_proba = 100,
		para = 91451
};

get(5431) ->
	#goods_eff{
		no = 5431,
		name = get_reward,
		trigger_proba = 100,
		para = 91452
};

get(5432) ->
	#goods_eff{
		no = 5432,
		name = get_reward,
		trigger_proba = 100,
		para = 91453
};

get(5188) ->
	#goods_eff{
		no = 5188,
		name = add_title,
		trigger_proba = 100,
		para = 70020
};

get(5189) ->
	#goods_eff{
		no = 5189,
		name = get_reward,
		trigger_proba = 100,
		para = 91253
};

get(5190) ->
	#goods_eff{
		no = 5190,
		name = get_reward,
		trigger_proba = 100,
		para = 91254
};

get(5191) ->
	#goods_eff{
		no = 5191,
		name = get_reward,
		trigger_proba = 100,
		para = 91255
};

get(5192) ->
	#goods_eff{
		no = 5192,
		name = get_reward,
		trigger_proba = 100,
		para = 91484
};

get(5193) ->
	#goods_eff{
		no = 5193,
		name = get_reward,
		trigger_proba = 100,
		para = 91485
};

get(5194) ->
	#goods_eff{
		no = 5194,
		name = get_reward,
		trigger_proba = 100,
		para = 91486
};

get(5195) ->
	#goods_eff{
		no = 5195,
		name = get_reward,
		trigger_proba = 100,
		para = 91487
};

get(5196) ->
	#goods_eff{
		no = 5196,
		name = get_reward,
		trigger_proba = 100,
		para = 91488
};

get(5433) ->
	#goods_eff{
		no = 5433,
		name = get_reward,
		trigger_proba = 100,
		para = 91454
};

get(5434) ->
	#goods_eff{
		no = 5434,
		name = get_reward,
		trigger_proba = 100,
		para = 91455
};

get(5435) ->
	#goods_eff{
		no = 5435,
		name = get_reward,
		trigger_proba = 100,
		para = 91456
};

get(5436) ->
	#goods_eff{
		no = 5436,
		name = get_reward,
		trigger_proba = 100,
		para = 91457
};

get(5437) ->
	#goods_eff{
		no = 5437,
		name = get_reward,
		trigger_proba = 100,
		para = 91458
};

get(5438) ->
	#goods_eff{
		no = 5438,
		name = get_reward,
		trigger_proba = 100,
		para = 91459
};

get(5439) ->
	#goods_eff{
		no = 5439,
		name = get_reward,
		trigger_proba = 100,
		para = 91460
};

get(5440) ->
	#goods_eff{
		no = 5440,
		name = get_reward,
		trigger_proba = 100,
		para = 91461
};

get(5441) ->
	#goods_eff{
		no = 5441,
		name = get_reward,
		trigger_proba = 100,
		para = 91462
};

get(5442) ->
	#goods_eff{
		no = 5442,
		name = get_reward,
		trigger_proba = 100,
		para = 91463
};

get(5443) ->
	#goods_eff{
		no = 5443,
		name = get_reward,
		trigger_proba = 100,
		para = 91464
};

get(5444) ->
	#goods_eff{
		no = 5444,
		name = get_reward,
		trigger_proba = 100,
		para = 91465
};

get(5445) ->
	#goods_eff{
		no = 5445,
		name = get_reward,
		trigger_proba = 100,
		para = 91466
};

get(5446) ->
	#goods_eff{
		no = 5446,
		name = get_reward,
		trigger_proba = 100,
		para = 91467
};

get(5447) ->
	#goods_eff{
		no = 5447,
		name = get_reward,
		trigger_proba = 100,
		para = 91468
};

get(5448) ->
	#goods_eff{
		no = 5448,
		name = get_reward,
		trigger_proba = 100,
		para = 91469
};

get(5449) ->
	#goods_eff{
		no = 5449,
		name = get_reward,
		trigger_proba = 100,
		para = 91470
};

get(5450) ->
	#goods_eff{
		no = 5450,
		name = get_reward,
		trigger_proba = 100,
		para = 91471
};

get(5451) ->
	#goods_eff{
		no = 5451,
		name = get_reward,
		trigger_proba = 100,
		para = 91472
};

get(5452) ->
	#goods_eff{
		no = 5452,
		name = get_reward,
		trigger_proba = 100,
		para = 91473
};

get(5453) ->
	#goods_eff{
		no = 5453,
		name = get_reward,
		trigger_proba = 100,
		para = 91474
};

get(5454) ->
	#goods_eff{
		no = 5454,
		name = get_reward,
		trigger_proba = 100,
		para = 91475
};

get(5455) ->
	#goods_eff{
		no = 5455,
		name = get_reward,
		trigger_proba = 100,
		para = 91476
};

get(5456) ->
	#goods_eff{
		no = 5456,
		name = get_reward,
		trigger_proba = 100,
		para = 91477
};

get(5457) ->
	#goods_eff{
		no = 5457,
		name = get_reward,
		trigger_proba = 100,
		para = 91478
};

get(5458) ->
	#goods_eff{
		no = 5458,
		name = get_reward,
		trigger_proba = 100,
		para = 91479
};

get(5459) ->
	#goods_eff{
		no = 5459,
		name = get_reward,
		trigger_proba = 100,
		para = 91480
};

get(5460) ->
	#goods_eff{
		no = 5460,
		name = get_reward,
		trigger_proba = 100,
		para = 91481
};

get(5461) ->
	#goods_eff{
		no = 5461,
		name = get_reward,
		trigger_proba = 100,
		para = 91482
};

get(5462) ->
	#goods_eff{
		no = 5462,
		name = get_reward,
		trigger_proba = 100,
		para = 91483
};

get(5463) ->
	#goods_eff{
		no = 5463,
		name = get_reward,
		trigger_proba = 100,
		para = 91489
};

get(5464) ->
	#goods_eff{
		no = 5464,
		name = get_reward,
		trigger_proba = 100,
		para = 91490
};

get(5465) ->
	#goods_eff{
		no = 5465,
		name = get_reward,
		trigger_proba = 100,
		para = 91491
};

get(5466) ->
	#goods_eff{
		no = 5466,
		name = get_reward,
		trigger_proba = 100,
		para = 91492
};

get(5467) ->
	#goods_eff{
		no = 5467,
		name = get_reward,
		trigger_proba = 100,
		para = 91493
};

get(5468) ->
	#goods_eff{
		no = 5468,
		name = get_reward,
		trigger_proba = 100,
		para = 91494
};

get(5469) ->
	#goods_eff{
		no = 5469,
		name = get_reward,
		trigger_proba = 100,
		para = 91495
};

get(5470) ->
	#goods_eff{
		no = 5470,
		name = get_reward,
		trigger_proba = 100,
		para = 91496
};

get(5471) ->
	#goods_eff{
		no = 5471,
		name = get_reward,
		trigger_proba = 100,
		para = 91497
};

get(5472) ->
	#goods_eff{
		no = 5472,
		name = get_reward,
		trigger_proba = 100,
		para = 91498
};

get(5473) ->
	#goods_eff{
		no = 5473,
		name = get_reward,
		trigger_proba = 100,
		para = 91499
};

get(5474) ->
	#goods_eff{
		no = 5474,
		name = get_reward,
		trigger_proba = 100,
		para = 91500
};

get(5475) ->
	#goods_eff{
		no = 5475,
		name = get_reward,
		trigger_proba = 100,
		para = 91501
};

get(5476) ->
	#goods_eff{
		no = 5476,
		name = get_reward,
		trigger_proba = 100,
		para = 91505
};

get(5477) ->
	#goods_eff{
		no = 5477,
		name = get_reward,
		trigger_proba = 100,
		para = 91506
};

get(5478) ->
	#goods_eff{
		no = 5478,
		name = get_reward,
		trigger_proba = 100,
		para = 91507
};

get(5479) ->
	#goods_eff{
		no = 5479,
		name = get_reward,
		trigger_proba = 100,
		para = 91508
};

get(5480) ->
	#goods_eff{
		no = 5480,
		name = get_reward,
		trigger_proba = 100,
		para = 91509
};

get(5481) ->
	#goods_eff{
		no = 5481,
		name = get_reward,
		trigger_proba = 100,
		para = 91510
};

get(5482) ->
	#goods_eff{
		no = 5482,
		name = get_reward,
		trigger_proba = 100,
		para = 91511
};

get(5483) ->
	#goods_eff{
		no = 5483,
		name = get_reward,
		trigger_proba = 100,
		para = 91512
};

get(5484) ->
	#goods_eff{
		no = 5484,
		name = get_reward,
		trigger_proba = 100,
		para = 91513
};

get(5485) ->
	#goods_eff{
		no = 5485,
		name = get_reward,
		trigger_proba = 100,
		para = 91514
};

get(5486) ->
	#goods_eff{
		no = 5486,
		name = get_reward,
		trigger_proba = 100,
		para = 91515
};

get(5487) ->
	#goods_eff{
		no = 5487,
		name = get_reward,
		trigger_proba = 100,
		para = 91516
};

get(5488) ->
	#goods_eff{
		no = 5488,
		name = get_reward,
		trigger_proba = 100,
		para = 91517
};

get(5489) ->
	#goods_eff{
		no = 5489,
		name = get_reward,
		trigger_proba = 100,
		para = 91518
};

get(5490) ->
	#goods_eff{
		no = 5490,
		name = get_reward,
		trigger_proba = 100,
		para = 91519
};

get(5491) ->
	#goods_eff{
		no = 5491,
		name = get_reward,
		trigger_proba = 100,
		para = 91520
};

get(5492) ->
	#goods_eff{
		no = 5492,
		name = get_reward,
		trigger_proba = 100,
		para = 91521
};

get(5493) ->
	#goods_eff{
		no = 5493,
		name = get_reward,
		trigger_proba = 100,
		para = 91523
};

get(5494) ->
	#goods_eff{
		no = 5494,
		name = get_reward,
		trigger_proba = 100,
		para = 91524
};

get(5495) ->
	#goods_eff{
		no = 5495,
		name = get_reward,
		trigger_proba = 100,
		para = 91525
};

get(5496) ->
	#goods_eff{
		no = 5496,
		name = get_reward,
		trigger_proba = 100,
		para = 91526
};

get(5497) ->
	#goods_eff{
		no = 5497,
		name = get_reward,
		trigger_proba = 100,
		para = 91527
};

get(5498) ->
	#goods_eff{
		no = 5498,
		name = get_reward,
		trigger_proba = 100,
		para = 91528
};

get(5499) ->
	#goods_eff{
		no = 5499,
		name = get_reward,
		trigger_proba = 100,
		para = 91529
};

get(5500) ->
	#goods_eff{
		no = 5500,
		name = get_reward,
		trigger_proba = 100,
		para = 91530
};

get(5501) ->
	#goods_eff{
		no = 5501,
		name = get_reward,
		trigger_proba = 100,
		para = 91531
};

get(5502) ->
	#goods_eff{
		no = 5502,
		name = get_reward,
		trigger_proba = 100,
		para = 91532
};

get(5503) ->
	#goods_eff{
		no = 5503,
		name = get_reward,
		trigger_proba = 100,
		para = 91533
};

get(5504) ->
	#goods_eff{
		no = 5504,
		name = get_reward,
		trigger_proba = 100,
		para = 91534
};

get(5505) ->
	#goods_eff{
		no = 5505,
		name = get_reward,
		trigger_proba = 100,
		para = 91535
};

get(5506) ->
	#goods_eff{
		no = 5506,
		name = get_reward,
		trigger_proba = 100,
		para = 91536
};

get(5507) ->
	#goods_eff{
		no = 5507,
		name = get_reward,
		trigger_proba = 100,
		para = 91537
};

get(5508) ->
	#goods_eff{
		no = 5508,
		name = get_reward,
		trigger_proba = 100,
		para = 91538
};

get(5509) ->
	#goods_eff{
		no = 5509,
		name = get_reward,
		trigger_proba = 100,
		para = 91539
};

get(5510) ->
	#goods_eff{
		no = 5510,
		name = get_reward,
		trigger_proba = 100,
		para = 91504
};

get(5511) ->
	#goods_eff{
		no = 5511,
		name = add_title,
		trigger_proba = 100,
		para = 70038
};

get(5512) ->
	#goods_eff{
		no = 5512,
		name = add_title,
		trigger_proba = 100,
		para = 70039
};

get(5513) ->
	#goods_eff{
		no = 5513,
		name = add_title,
		trigger_proba = 100,
		para = 70040
};

get(5514) ->
	#goods_eff{
		no = 5514,
		name = get_reward,
		trigger_proba = 100,
		para = 91543
};

get(5515) ->
	#goods_eff{
		no = 5515,
		name = get_reward,
		trigger_proba = 100,
		para = 91544
};

get(5516) ->
	#goods_eff{
		no = 5516,
		name = get_reward,
		trigger_proba = 100,
		para = 91545
};

get(5517) ->
	#goods_eff{
		no = 5517,
		name = get_reward,
		trigger_proba = 100,
		para = 91546
};

get(5518) ->
	#goods_eff{
		no = 5518,
		name = get_reward,
		trigger_proba = 100,
		para = 91547
};

get(5519) ->
	#goods_eff{
		no = 5519,
		name = get_reward,
		trigger_proba = 100,
		para = 91548
};

get(5520) ->
	#goods_eff{
		no = 5520,
		name = get_reward,
		trigger_proba = 100,
		para = 91549
};

get(5521) ->
	#goods_eff{
		no = 5521,
		name = get_reward,
		trigger_proba = 100,
		para = 91550
};

get(5522) ->
	#goods_eff{
		no = 5522,
		name = get_reward,
		trigger_proba = 100,
		para = 91664
};

get(5534) ->
	#goods_eff{
		no = 5534,
		name = get_chibang,
		trigger_proba = 100,
		para = 10000
};

get(5541) ->
	#goods_eff{
		no = 5541,
		name = get_chibang,
		trigger_proba = 100,
		para = 10001
};

get(5542) ->
	#goods_eff{
		no = 5542,
		name = get_chibang,
		trigger_proba = 100,
		para = 10002
};

get(5543) ->
	#goods_eff{
		no = 5543,
		name = add_recharge_money,
		trigger_proba = 100,
		para = 10
};

get(5544) ->
	#goods_eff{
		no = 5544,
		name = add_recharge_money,
		trigger_proba = 100,
		para = 20
};

get(5545) ->
	#goods_eff{
		no = 5545,
		name = add_recharge_money,
		trigger_proba = 100,
		para = 30
};

get(5546) ->
	#goods_eff{
		no = 5546,
		name = add_recharge_money,
		trigger_proba = 100,
		para = 40
};

get(5547) ->
	#goods_eff{
		no = 5547,
		name = add_recharge_money,
		trigger_proba = 100,
		para = 50
};

get(5548) ->
	#goods_eff{
		no = 5548,
		name = add_recharge_money,
		trigger_proba = 100,
		para = 60
};

get(5549) ->
	#goods_eff{
		no = 5549,
		name = add_recharge_money,
		trigger_proba = 100,
		para = 70
};

get(5550) ->
	#goods_eff{
		no = 5550,
		name = add_recharge_money,
		trigger_proba = 100,
		para = 80
};

get(5551) ->
	#goods_eff{
		no = 5551,
		name = add_recharge_money,
		trigger_proba = 100,
		para = 90
};

get(5552) ->
	#goods_eff{
		no = 5552,
		name = add_recharge_money,
		trigger_proba = 100,
		para = 100
};

get(5553) ->
	#goods_eff{
		no = 5553,
		name = add_recharge_money,
		trigger_proba = 100,
		para = 110
};

get(5554) ->
	#goods_eff{
		no = 5554,
		name = add_recharge_money,
		trigger_proba = 100,
		para = 120
};

get(5555) ->
	#goods_eff{
		no = 5555,
		name = add_recharge_money,
		trigger_proba = 100,
		para = 130
};

get(5556) ->
	#goods_eff{
		no = 5556,
		name = add_recharge_money,
		trigger_proba = 100,
		para = 140
};

get(5557) ->
	#goods_eff{
		no = 5557,
		name = add_recharge_money,
		trigger_proba = 100,
		para = 150
};

get(5558) ->
	#goods_eff{
		no = 5558,
		name = add_recharge_money,
		trigger_proba = 100,
		para = 160
};

get(5559) ->
	#goods_eff{
		no = 5559,
		name = add_recharge_money,
		trigger_proba = 100,
		para = 170
};

get(5560) ->
	#goods_eff{
		no = 5560,
		name = add_recharge_money,
		trigger_proba = 100,
		para = 180
};

get(5561) ->
	#goods_eff{
		no = 5561,
		name = add_recharge_money,
		trigger_proba = 100,
		para = 190
};

get(5562) ->
	#goods_eff{
		no = 5562,
		name = add_recharge_money,
		trigger_proba = 100,
		para = 200
};

get(5563) ->
	#goods_eff{
		no = 5563,
		name = add_recharge_money,
		trigger_proba = 100,
		para = 210
};

get(5564) ->
	#goods_eff{
		no = 5564,
		name = add_recharge_money,
		trigger_proba = 100,
		para = 220
};

get(5565) ->
	#goods_eff{
		no = 5565,
		name = add_recharge_money,
		trigger_proba = 100,
		para = 230
};

get(5566) ->
	#goods_eff{
		no = 5566,
		name = add_recharge_money,
		trigger_proba = 100,
		para = 240
};

get(5567) ->
	#goods_eff{
		no = 5567,
		name = add_recharge_money,
		trigger_proba = 100,
		para = 250
};

get(5568) ->
	#goods_eff{
		no = 5568,
		name = add_recharge_money,
		trigger_proba = 100,
		para = 260
};

get(5569) ->
	#goods_eff{
		no = 5569,
		name = add_recharge_money,
		trigger_proba = 100,
		para = 270
};

get(5570) ->
	#goods_eff{
		no = 5570,
		name = add_recharge_money,
		trigger_proba = 100,
		para = 280
};

get(5571) ->
	#goods_eff{
		no = 5571,
		name = add_recharge_money,
		trigger_proba = 100,
		para = 290
};

get(5572) ->
	#goods_eff{
		no = 5572,
		name = add_recharge_money,
		trigger_proba = 100,
		para = 300
};

get(5573) ->
	#goods_eff{
		no = 5573,
		name = add_title,
		trigger_proba = 100,
		para = 70035
};

get(5574) ->
	#goods_eff{
		no = 5574,
		name = get_reward,
		trigger_proba = 100,
		para = 91801
};

get(5575) ->
	#goods_eff{
		no = 5575,
		name = add_title,
		trigger_proba = 100,
		para = 70036
};

get(5576) ->
	#goods_eff{
		no = 5576,
		name = get_reward,
		trigger_proba = 100,
		para = 91802
};

get(5577) ->
	#goods_eff{
		no = 5577,
		name = add_title,
		trigger_proba = 100,
		para = 70037
};

get(5578) ->
	#goods_eff{
		no = 5578,
		name = get_reward,
		trigger_proba = 100,
		para = 91803
};

get(5579) ->
	#goods_eff{
		no = 5579,
		name = get_reward,
		trigger_proba = 100,
		para = 91778
};

get(5580) ->
	#goods_eff{
		no = 5580,
		name = get_reward,
		trigger_proba = 100,
		para = 91779
};

get(5581) ->
	#goods_eff{
		no = 5581,
		name = get_reward,
		trigger_proba = 100,
		para = 91794
};

get(5582) ->
	#goods_eff{
		no = 5582,
		name = get_reward,
		trigger_proba = 100,
		para = 91793
};

get(5583) ->
	#goods_eff{
		no = 5583,
		name = get_reward,
		trigger_proba = 100,
		para = 91800
};

get(5584) ->
	#goods_eff{
		no = 5584,
		name = get_reward,
		trigger_proba = 100,
		para = 91612
};

get(5585) ->
	#goods_eff{
		no = 5585,
		name = add_title,
		trigger_proba = 100,
		para = 70041
};

get(5586) ->
	#goods_eff{
		no = 5586,
		name = add_title,
		trigger_proba = 100,
		para = 70042
};

get(5587) ->
	#goods_eff{
		no = 5587,
		name = add_title,
		trigger_proba = 100,
		para = 70043
};

get(5588) ->
	#goods_eff{
		no = 5588,
		name = add_title,
		trigger_proba = 100,
		para = 70044
};

get(5589) ->
	#goods_eff{
		no = 5589,
		name = add_title,
		trigger_proba = 100,
		para = 70045
};

get(5590) ->
	#goods_eff{
		no = 5590,
		name = add_title,
		trigger_proba = 100,
		para = 70046
};

get(5591) ->
	#goods_eff{
		no = 5591,
		name = add_title,
		trigger_proba = 100,
		para = 70047
};

get(5592) ->
	#goods_eff{
		no = 5592,
		name = add_title,
		trigger_proba = 100,
		para = 70048
};

get(5593) ->
	#goods_eff{
		no = 5593,
		name = add_title,
		trigger_proba = 100,
		para = 70049
};

get(5594) ->
	#goods_eff{
		no = 5594,
		name = get_mounts,
		trigger_proba = 100,
		para = 1014
};

get(5595) ->
	#goods_eff{
		no = 5595,
		name = get_mounts,
		trigger_proba = 100,
		para = 1015
};

get(5596) ->
	#goods_eff{
		no = 5596,
		name = get_reward,
		trigger_proba = 100,
		para = 91669
};

get(5597) ->
	#goods_eff{
		no = 5597,
		name = get_reward,
		trigger_proba = 100,
		para = 91670
};

get(5598) ->
	#goods_eff{
		no = 5598,
		name = get_reward,
		trigger_proba = 100,
		para = 91671
};

get(5599) ->
	#goods_eff{
		no = 5599,
		name = get_reward,
		trigger_proba = 100,
		para = 91676
};

get(5600) ->
	#goods_eff{
		no = 5600,
		name = get_mounts,
		trigger_proba = 100,
		para = 1016
};

get(5601) ->
	#goods_eff{
		no = 5601,
		name = get_reward,
		trigger_proba = 100,
		para = 91677
};

get(5602) ->
	#goods_eff{
		no = 5602,
		name = get_reward,
		trigger_proba = 100,
		para = 91821
};

get(5603) ->
	#goods_eff{
		no = 5603,
		name = get_reward,
		trigger_proba = 100,
		para = 91838
};

get(5604) ->
	#goods_eff{
		no = 5604,
		name = get_reward,
		trigger_proba = 100,
		para = 91822
};

get(5605) ->
	#goods_eff{
		no = 5605,
		name = get_reward,
		trigger_proba = 100,
		para = 91823
};

get(5606) ->
	#goods_eff{
		no = 5606,
		name = get_reward,
		trigger_proba = 100,
		para = 91824
};

get(5607) ->
	#goods_eff{
		no = 5607,
		name = get_reward,
		trigger_proba = 100,
		para = 91825
};

get(5608) ->
	#goods_eff{
		no = 5608,
		name = get_reward,
		trigger_proba = 100,
		para = 91839
};

get(5609) ->
	#goods_eff{
		no = 5609,
		name = get_reward,
		trigger_proba = 100,
		para = 91840
};

get(5610) ->
	#goods_eff{
		no = 5610,
		name = get_reward,
		trigger_proba = 100,
		para = 91841
};

get(5611) ->
	#goods_eff{
		no = 5611,
		name = get_reward,
		trigger_proba = 100,
		para = 91842
};

get(5612) ->
	#goods_eff{
		no = 5612,
		name = get_reward,
		trigger_proba = 100,
		para = 91843
};

get(5613) ->
	#goods_eff{
		no = 5613,
		name = get_reward,
		trigger_proba = 100,
		para = 91845
};

get(5614) ->
	#goods_eff{
		no = 5614,
		name = get_reward,
		trigger_proba = 100,
		para = 91850
};

get(5615) ->
	#goods_eff{
		no = 5615,
		name = get_reward,
		trigger_proba = 100,
		para = 91851
};

get(5616) ->
	#goods_eff{
		no = 5616,
		name = get_reward,
		trigger_proba = 100,
		para = 91852
};

get(5617) ->
	#goods_eff{
		no = 5617,
		name = get_reward,
		trigger_proba = 100,
		para = 91853
};

get(5618) ->
	#goods_eff{
		no = 5618,
		name = get_reward,
		trigger_proba = 100,
		para = 91854
};

get(5619) ->
	#goods_eff{
		no = 5619,
		name = get_reward,
		trigger_proba = 100,
		para = 91855
};

get(5620) ->
	#goods_eff{
		no = 5620,
		name = get_reward,
		trigger_proba = 100,
		para = 91856
};

get(5621) ->
	#goods_eff{
		no = 5621,
		name = get_reward,
		trigger_proba = 100,
		para = 91857
};

get(5622) ->
	#goods_eff{
		no = 5622,
		name = get_reward,
		trigger_proba = 100,
		para = 91858
};

get(5623) ->
	#goods_eff{
		no = 5623,
		name = get_reward,
		trigger_proba = 100,
		para = 91859
};

get(5624) ->
	#goods_eff{
		no = 5624,
		name = get_reward,
		trigger_proba = 100,
		para = 91860
};

get(5625) ->
	#goods_eff{
		no = 5625,
		name = get_reward,
		trigger_proba = 100,
		para = 91861
};

get(5626) ->
	#goods_eff{
		no = 5626,
		name = get_reward,
		trigger_proba = 100,
		para = 91862
};

get(5627) ->
	#goods_eff{
		no = 5627,
		name = get_reward,
		trigger_proba = 100,
		para = 91863
};

get(5628) ->
	#goods_eff{
		no = 5628,
		name = get_reward,
		trigger_proba = 100,
		para = 91864
};

get(5629) ->
	#goods_eff{
		no = 5629,
		name = get_reward,
		trigger_proba = 100,
		para = 91865
};

get(5630) ->
	#goods_eff{
		no = 5630,
		name = get_reward,
		trigger_proba = 100,
		para = 91866
};

get(5631) ->
	#goods_eff{
		no = 5631,
		name = get_reward,
		trigger_proba = 100,
		para = 91867
};

get(5632) ->
	#goods_eff{
		no = 5632,
		name = get_reward,
		trigger_proba = 100,
		para = 91868
};

get(5633) ->
	#goods_eff{
		no = 5633,
		name = get_reward,
		trigger_proba = 100,
		para = 91869
};

get(5634) ->
	#goods_eff{
		no = 5634,
		name = get_reward,
		trigger_proba = 100,
		para = 91870
};

get(5635) ->
	#goods_eff{
		no = 5635,
		name = get_reward,
		trigger_proba = 100,
		para = 91871
};

get(5636) ->
	#goods_eff{
		no = 5636,
		name = get_reward,
		trigger_proba = 100,
		para = 91872
};

get(5637) ->
	#goods_eff{
		no = 5637,
		name = get_reward,
		trigger_proba = 100,
		para = 91873
};

get(5638) ->
	#goods_eff{
		no = 5638,
		name = get_reward,
		trigger_proba = 100,
		para = 91874
};

get(5639) ->
	#goods_eff{
		no = 5639,
		name = get_reward,
		trigger_proba = 100,
		para = 91875
};

get(5640) ->
	#goods_eff{
		no = 5640,
		name = get_reward,
		trigger_proba = 100,
		para = 91877
};

get(5641) ->
	#goods_eff{
		no = 5641,
		name = get_reward,
		trigger_proba = 100,
		para = 91878
};

get(5642) ->
	#goods_eff{
		no = 5642,
		name = get_chibang,
		trigger_proba = 100,
		para = 10003
};

get(5643) ->
	#goods_eff{
		no = 5643,
		name = get_fabao_rune,
		trigger_proba = 100,
		para = 120008
};

get(5644) ->
	#goods_eff{
		no = 5644,
		name = get_fabao_rune,
		trigger_proba = 100,
		para = 120009
};

get(5645) ->
	#goods_eff{
		no = 5645,
		name = get_fabao_rune,
		trigger_proba = 100,
		para = 120010
};

get(5646) ->
	#goods_eff{
		no = 5646,
		name = get_fabao_rune,
		trigger_proba = 100,
		para = 120011
};

get(5647) ->
	#goods_eff{
		no = 5647,
		name = get_fabao_rune,
		trigger_proba = 100,
		para = 120012
};

get(5648) ->
	#goods_eff{
		no = 5648,
		name = get_fabao_rune,
		trigger_proba = 100,
		para = 120013
};

get(5649) ->
	#goods_eff{
		no = 5649,
		name = get_fabao_rune,
		trigger_proba = 100,
		para = 120014
};

get(5650) ->
	#goods_eff{
		no = 5650,
		name = get_fabao_rune,
		trigger_proba = 100,
		para = 120015
};

get(5651) ->
	#goods_eff{
		no = 5651,
		name = get_fabao_rune,
		trigger_proba = 100,
		para = 120016
};

get(5652) ->
	#goods_eff{
		no = 5652,
		name = get_fabao_rune,
		trigger_proba = 100,
		para = 120017
};

get(5653) ->
	#goods_eff{
		no = 5653,
		name = get_fabao_rune,
		trigger_proba = 100,
		para = 120018
};

get(5654) ->
	#goods_eff{
		no = 5654,
		name = get_fabao_rune,
		trigger_proba = 100,
		para = 120019
};

get(5655) ->
	#goods_eff{
		no = 5655,
		name = get_fabao_rune,
		trigger_proba = 100,
		para = 120020
};

get(5656) ->
	#goods_eff{
		no = 5656,
		name = get_fabao_rune,
		trigger_proba = 100,
		para = 120021
};

get(5657) ->
	#goods_eff{
		no = 5657,
		name = get_fabao_rune,
		trigger_proba = 100,
		para = 120022
};

get(5658) ->
	#goods_eff{
		no = 5658,
		name = get_fabao_rune,
		trigger_proba = 100,
		para = 120023
};

get(5659) ->
	#goods_eff{
		no = 5659,
		name = get_fabao_rune,
		trigger_proba = 100,
		para = 120024
};

get(5660) ->
	#goods_eff{
		no = 5660,
		name = get_fabao_rune,
		trigger_proba = 100,
		para = 120025
};

get(5661) ->
	#goods_eff{
		no = 5661,
		name = get_fabao_rune,
		trigger_proba = 100,
		para = 120026
};

get(5662) ->
	#goods_eff{
		no = 5662,
		name = get_fabao_rune,
		trigger_proba = 100,
		para = 120027
};

get(5663) ->
	#goods_eff{
		no = 5663,
		name = get_fabao_rune,
		trigger_proba = 100,
		para = 120028
};

get(5664) ->
	#goods_eff{
		no = 5664,
		name = get_fabao_rune,
		trigger_proba = 100,
		para = 120029
};

get(5665) ->
	#goods_eff{
		no = 5665,
		name = get_fabao_rune,
		trigger_proba = 100,
		para = 120030
};

get(5666) ->
	#goods_eff{
		no = 5666,
		name = get_fabao_rune,
		trigger_proba = 100,
		para = 120031
};

get(5667) ->
	#goods_eff{
		no = 5667,
		name = get_fabao_rune,
		trigger_proba = 100,
		para = 120032
};

get(5668) ->
	#goods_eff{
		no = 5668,
		name = get_fabao_rune,
		trigger_proba = 100,
		para = 120033
};

get(5669) ->
	#goods_eff{
		no = 5669,
		name = get_fabao_rune,
		trigger_proba = 100,
		para = 120034
};

get(5670) ->
	#goods_eff{
		no = 5670,
		name = get_fabao_rune,
		trigger_proba = 100,
		para = 120035
};

get(5671) ->
	#goods_eff{
		no = 5671,
		name = get_fabao_rune,
		trigger_proba = 100,
		para = 120036
};

get(5672) ->
	#goods_eff{
		no = 5672,
		name = get_fabao_rune,
		trigger_proba = 100,
		para = 120037
};

get(5673) ->
	#goods_eff{
		no = 5673,
		name = get_fabao_rune,
		trigger_proba = 100,
		para = 120038
};

get(5674) ->
	#goods_eff{
		no = 5674,
		name = get_fabao_rune,
		trigger_proba = 100,
		para = 120039
};

get(5675) ->
	#goods_eff{
		no = 5675,
		name = get_fabao_rune,
		trigger_proba = 100,
		para = 120040
};

get(5676) ->
	#goods_eff{
		no = 5676,
		name = get_fabao_rune,
		trigger_proba = 100,
		para = 120041
};

get(5677) ->
	#goods_eff{
		no = 5677,
		name = get_fabao_rune,
		trigger_proba = 100,
		para = 120042
};

get(5678) ->
	#goods_eff{
		no = 5678,
		name = get_fabao_rune,
		trigger_proba = 100,
		para = 120043
};

get(5679) ->
	#goods_eff{
		no = 5679,
		name = add_title,
		trigger_proba = 100,
		para = 70050
};

get(5680) ->
	#goods_eff{
		no = 5680,
		name = get_reward,
		trigger_proba = 100,
		para = 91879
};

get(5681) ->
	#goods_eff{
		no = 5681,
		name = get_reward,
		trigger_proba = 100,
		para = 91880
};

get(5682) ->
	#goods_eff{
		no = 5682,
		name = add_title,
		trigger_proba = 100,
		para = 1001
};

get(5683) ->
	#goods_eff{
		no = 5683,
		name = add_title,
		trigger_proba = 100,
		para = 1002
};

get(5684) ->
	#goods_eff{
		no = 5684,
		name = add_title,
		trigger_proba = 100,
		para = 1003
};

get(5685) ->
	#goods_eff{
		no = 5685,
		name = add_title,
		trigger_proba = 100,
		para = 1004
};

get(5686) ->
	#goods_eff{
		no = 5686,
		name = add_title,
		trigger_proba = 100,
		para = 1005
};

get(5687) ->
	#goods_eff{
		no = 5687,
		name = add_title,
		trigger_proba = 100,
		para = 1006
};

get(5688) ->
	#goods_eff{
		no = 5688,
		name = add_title,
		trigger_proba = 100,
		para = 1007
};

get(5689) ->
	#goods_eff{
		no = 5689,
		name = add_title,
		trigger_proba = 100,
		para = 1008
};

get(5690) ->
	#goods_eff{
		no = 5690,
		name = add_title,
		trigger_proba = 100,
		para = 1009
};

get(5691) ->
	#goods_eff{
		no = 5691,
		name = add_title,
		trigger_proba = 100,
		para = 1010
};

get(5692) ->
	#goods_eff{
		no = 5692,
		name = add_title,
		trigger_proba = 100,
		para = 1011
};

get(5693) ->
	#goods_eff{
		no = 5693,
		name = add_title,
		trigger_proba = 100,
		para = 1012
};

get(5694) ->
	#goods_eff{
		no = 5694,
		name = add_title,
		trigger_proba = 100,
		para = 1013
};

get(5695) ->
	#goods_eff{
		no = 5695,
		name = add_title,
		trigger_proba = 100,
		para = 1014
};

get(5696) ->
	#goods_eff{
		no = 5696,
		name = add_title,
		trigger_proba = 100,
		para = 1015
};

get(3001) ->
	#goods_eff{
		no = 3001,
		name = get_partner,
		trigger_proba = 100,
		para = 1001
};

get(3002) ->
	#goods_eff{
		no = 3002,
		name = get_partner,
		trigger_proba = 100,
		para = 1002
};

get(3003) ->
	#goods_eff{
		no = 3003,
		name = get_partner,
		trigger_proba = 100,
		para = 1003
};

get(3004) ->
	#goods_eff{
		no = 3004,
		name = get_partner,
		trigger_proba = 100,
		para = 1004
};

get(3005) ->
	#goods_eff{
		no = 3005,
		name = get_partner,
		trigger_proba = 100,
		para = 1005
};

get(3006) ->
	#goods_eff{
		no = 3006,
		name = get_partner,
		trigger_proba = 100,
		para = 1006
};

get(3007) ->
	#goods_eff{
		no = 3007,
		name = get_partner,
		trigger_proba = 100,
		para = 1007
};

get(3008) ->
	#goods_eff{
		no = 3008,
		name = get_partner,
		trigger_proba = 100,
		para = 1008
};

get(3009) ->
	#goods_eff{
		no = 3009,
		name = get_partner,
		trigger_proba = 100,
		para = 1020
};

get(3010) ->
	#goods_eff{
		no = 3010,
		name = get_partner,
		trigger_proba = 100,
		para = 1021
};

get(3011) ->
	#goods_eff{
		no = 3011,
		name = get_partner,
		trigger_proba = 100,
		para = 1022
};

get(3012) ->
	#goods_eff{
		no = 3012,
		name = get_partner,
		trigger_proba = 100,
		para = 1023
};

get(3013) ->
	#goods_eff{
		no = 3013,
		name = get_partner,
		trigger_proba = 100,
		para = 1024
};

get(3101) ->
	#goods_eff{
		no = 3101,
		name = change_skill,
		trigger_proba = 100,
		para = 1001
};

get(3102) ->
	#goods_eff{
		no = 3102,
		name = change_skill,
		trigger_proba = 100,
		para = 1002
};

get(3103) ->
	#goods_eff{
		no = 3103,
		name = change_skill,
		trigger_proba = 100,
		para = 1003
};

get(3104) ->
	#goods_eff{
		no = 3104,
		name = change_skill,
		trigger_proba = 100,
		para = 1004
};

get(3105) ->
	#goods_eff{
		no = 3105,
		name = change_skill,
		trigger_proba = 100,
		para = 1005
};

get(3106) ->
	#goods_eff{
		no = 3106,
		name = change_skill,
		trigger_proba = 100,
		para = 1006
};

get(3107) ->
	#goods_eff{
		no = 3107,
		name = change_skill,
		trigger_proba = 100,
		para = 1007
};

get(3108) ->
	#goods_eff{
		no = 3108,
		name = change_skill,
		trigger_proba = 100,
		para = 1008
};

get(3109) ->
	#goods_eff{
		no = 3109,
		name = change_skill,
		trigger_proba = 100,
		para = 1009
};

get(3110) ->
	#goods_eff{
		no = 3110,
		name = change_skill,
		trigger_proba = 100,
		para = 1010
};

get(3111) ->
	#goods_eff{
		no = 3111,
		name = change_skill,
		trigger_proba = 100,
		para = 1011
};

get(3112) ->
	#goods_eff{
		no = 3112,
		name = change_skill,
		trigger_proba = 100,
		para = 1012
};

get(3113) ->
	#goods_eff{
		no = 3113,
		name = change_skill,
		trigger_proba = 100,
		para = 1013
};

get(3114) ->
	#goods_eff{
		no = 3114,
		name = change_skill,
		trigger_proba = 100,
		para = 1014
};

get(3115) ->
	#goods_eff{
		no = 3115,
		name = change_skill,
		trigger_proba = 100,
		para = 1015
};

get(3116) ->
	#goods_eff{
		no = 3116,
		name = change_skill,
		trigger_proba = 100,
		para = 1016
};

get(3117) ->
	#goods_eff{
		no = 3117,
		name = change_skill,
		trigger_proba = 100,
		para = 1017
};

get(3118) ->
	#goods_eff{
		no = 3118,
		name = change_skill,
		trigger_proba = 100,
		para = 1018
};

get(3119) ->
	#goods_eff{
		no = 3119,
		name = change_skill,
		trigger_proba = 100,
		para = 1019
};

get(3120) ->
	#goods_eff{
		no = 3120,
		name = change_skill,
		trigger_proba = 100,
		para = 1020
};

get(3121) ->
	#goods_eff{
		no = 3121,
		name = change_skill,
		trigger_proba = 100,
		para = 1021
};

get(3122) ->
	#goods_eff{
		no = 3122,
		name = change_skill,
		trigger_proba = 100,
		para = 1022
};

get(3123) ->
	#goods_eff{
		no = 3123,
		name = change_skill,
		trigger_proba = 100,
		para = 1023
};

get(3124) ->
	#goods_eff{
		no = 3124,
		name = change_skill,
		trigger_proba = 100,
		para = 1024
};

get(3125) ->
	#goods_eff{
		no = 3125,
		name = change_skill,
		trigger_proba = 100,
		para = 1025
};

get(3126) ->
	#goods_eff{
		no = 3126,
		name = change_skill,
		trigger_proba = 100,
		para = 1026
};

get(3127) ->
	#goods_eff{
		no = 3127,
		name = change_skill,
		trigger_proba = 100,
		para = 1027
};

get(3128) ->
	#goods_eff{
		no = 3128,
		name = change_skill,
		trigger_proba = 100,
		para = 1028
};

get(3129) ->
	#goods_eff{
		no = 3129,
		name = change_skill,
		trigger_proba = 100,
		para = 1029
};

get(3130) ->
	#goods_eff{
		no = 3130,
		name = change_skill,
		trigger_proba = 100,
		para = 1030
};

get(3131) ->
	#goods_eff{
		no = 3131,
		name = change_skill,
		trigger_proba = 100,
		para = 1031
};

get(3132) ->
	#goods_eff{
		no = 3132,
		name = change_skill,
		trigger_proba = 100,
		para = 1032
};

get(3133) ->
	#goods_eff{
		no = 3133,
		name = change_skill,
		trigger_proba = 100,
		para = 1033
};

get(3134) ->
	#goods_eff{
		no = 3134,
		name = change_skill,
		trigger_proba = 100,
		para = 1034
};

get(3135) ->
	#goods_eff{
		no = 3135,
		name = change_skill,
		trigger_proba = 100,
		para = 1035
};

get(3136) ->
	#goods_eff{
		no = 3136,
		name = change_skill,
		trigger_proba = 100,
		para = 1036
};

get(3201) ->
	#goods_eff{
		no = 3201,
		name = change_skill,
		trigger_proba = 100,
		para = 1101
};

get(3202) ->
	#goods_eff{
		no = 3202,
		name = change_skill,
		trigger_proba = 100,
		para = 1102
};

get(3203) ->
	#goods_eff{
		no = 3203,
		name = change_skill,
		trigger_proba = 100,
		para = 1103
};

get(3204) ->
	#goods_eff{
		no = 3204,
		name = change_skill,
		trigger_proba = 100,
		para = 1104
};

get(3205) ->
	#goods_eff{
		no = 3205,
		name = change_skill,
		trigger_proba = 100,
		para = 1105
};

get(3206) ->
	#goods_eff{
		no = 3206,
		name = change_skill,
		trigger_proba = 100,
		para = 1106
};

get(3207) ->
	#goods_eff{
		no = 3207,
		name = change_skill,
		trigger_proba = 100,
		para = 1107
};

get(3208) ->
	#goods_eff{
		no = 3208,
		name = change_skill,
		trigger_proba = 100,
		para = 1108
};

get(3209) ->
	#goods_eff{
		no = 3209,
		name = change_skill,
		trigger_proba = 100,
		para = 1109
};

get(3210) ->
	#goods_eff{
		no = 3210,
		name = change_skill,
		trigger_proba = 100,
		para = 1110
};

get(3211) ->
	#goods_eff{
		no = 3211,
		name = change_skill,
		trigger_proba = 100,
		para = 1111
};

get(3212) ->
	#goods_eff{
		no = 3212,
		name = change_skill,
		trigger_proba = 100,
		para = 1112
};

get(3213) ->
	#goods_eff{
		no = 3213,
		name = change_skill,
		trigger_proba = 100,
		para = 1113
};

get(3214) ->
	#goods_eff{
		no = 3214,
		name = change_skill,
		trigger_proba = 100,
		para = 1114
};

get(3215) ->
	#goods_eff{
		no = 3215,
		name = change_skill,
		trigger_proba = 100,
		para = 1115
};

get(3216) ->
	#goods_eff{
		no = 3216,
		name = change_skill,
		trigger_proba = 100,
		para = 1116
};

get(3217) ->
	#goods_eff{
		no = 3217,
		name = change_skill,
		trigger_proba = 100,
		para = 1117
};

get(3218) ->
	#goods_eff{
		no = 3218,
		name = change_skill,
		trigger_proba = 100,
		para = 1118
};

get(3219) ->
	#goods_eff{
		no = 3219,
		name = change_skill,
		trigger_proba = 100,
		para = 1119
};

get(3220) ->
	#goods_eff{
		no = 3220,
		name = change_skill,
		trigger_proba = 100,
		para = 1120
};

get(3221) ->
	#goods_eff{
		no = 3221,
		name = change_skill,
		trigger_proba = 100,
		para = 1121
};

get(3222) ->
	#goods_eff{
		no = 3222,
		name = change_skill,
		trigger_proba = 100,
		para = 1122
};

get(3223) ->
	#goods_eff{
		no = 3223,
		name = change_skill,
		trigger_proba = 100,
		para = 1123
};

get(3224) ->
	#goods_eff{
		no = 3224,
		name = change_skill,
		trigger_proba = 100,
		para = 1124
};

get(3225) ->
	#goods_eff{
		no = 3225,
		name = change_skill,
		trigger_proba = 100,
		para = 1125
};

get(3226) ->
	#goods_eff{
		no = 3226,
		name = change_skill,
		trigger_proba = 100,
		para = 1126
};

get(3227) ->
	#goods_eff{
		no = 3227,
		name = change_skill,
		trigger_proba = 100,
		para = 1127
};

get(3228) ->
	#goods_eff{
		no = 3228,
		name = change_skill,
		trigger_proba = 100,
		para = 1128
};

get(3229) ->
	#goods_eff{
		no = 3229,
		name = change_skill,
		trigger_proba = 100,
		para = 1129
};

get(3230) ->
	#goods_eff{
		no = 3230,
		name = change_skill,
		trigger_proba = 100,
		para = 1130
};

get(3231) ->
	#goods_eff{
		no = 3231,
		name = change_skill,
		trigger_proba = 100,
		para = 1131
};

get(3232) ->
	#goods_eff{
		no = 3232,
		name = change_skill,
		trigger_proba = 100,
		para = 1132
};

get(3233) ->
	#goods_eff{
		no = 3233,
		name = change_skill,
		trigger_proba = 100,
		para = 1133
};

get(3234) ->
	#goods_eff{
		no = 3234,
		name = change_skill,
		trigger_proba = 100,
		para = 1134
};

get(3235) ->
	#goods_eff{
		no = 3235,
		name = change_skill,
		trigger_proba = 100,
		para = 1135
};

get(3236) ->
	#goods_eff{
		no = 3236,
		name = change_skill,
		trigger_proba = 100,
		para = 1136
};

get(3301) ->
	#goods_eff{
		no = 3301,
		name = change_skill,
		trigger_proba = 100,
		para = 1201
};

get(3302) ->
	#goods_eff{
		no = 3302,
		name = change_skill,
		trigger_proba = 100,
		para = 1202
};

get(3303) ->
	#goods_eff{
		no = 3303,
		name = change_skill,
		trigger_proba = 100,
		para = 1203
};

get(3304) ->
	#goods_eff{
		no = 3304,
		name = change_skill,
		trigger_proba = 100,
		para = 1204
};

get(3305) ->
	#goods_eff{
		no = 3305,
		name = change_skill,
		trigger_proba = 100,
		para = 1205
};

get(3306) ->
	#goods_eff{
		no = 3306,
		name = change_skill,
		trigger_proba = 100,
		para = 1206
};

get(3307) ->
	#goods_eff{
		no = 3307,
		name = change_skill,
		trigger_proba = 100,
		para = 1207
};

get(3308) ->
	#goods_eff{
		no = 3308,
		name = change_skill,
		trigger_proba = 100,
		para = 1208
};

get(3309) ->
	#goods_eff{
		no = 3309,
		name = change_skill,
		trigger_proba = 100,
		para = 1209
};

get(3310) ->
	#goods_eff{
		no = 3310,
		name = change_skill,
		trigger_proba = 100,
		para = 1210
};

get(3311) ->
	#goods_eff{
		no = 3311,
		name = change_skill,
		trigger_proba = 100,
		para = 1211
};

get(3312) ->
	#goods_eff{
		no = 3312,
		name = change_skill,
		trigger_proba = 100,
		para = 1212
};

get(3313) ->
	#goods_eff{
		no = 3313,
		name = change_skill,
		trigger_proba = 100,
		para = 1213
};

get(3314) ->
	#goods_eff{
		no = 3314,
		name = change_skill,
		trigger_proba = 100,
		para = 1214
};

get(3315) ->
	#goods_eff{
		no = 3315,
		name = change_skill,
		trigger_proba = 100,
		para = 1215
};

get(3316) ->
	#goods_eff{
		no = 3316,
		name = change_skill,
		trigger_proba = 100,
		para = 1216
};

get(3317) ->
	#goods_eff{
		no = 3317,
		name = change_skill,
		trigger_proba = 100,
		para = 1217
};

get(3318) ->
	#goods_eff{
		no = 3318,
		name = change_skill,
		trigger_proba = 100,
		para = 1218
};

get(3319) ->
	#goods_eff{
		no = 3319,
		name = change_skill,
		trigger_proba = 100,
		para = 1219
};

get(3320) ->
	#goods_eff{
		no = 3320,
		name = change_skill,
		trigger_proba = 100,
		para = 1220
};

get(3321) ->
	#goods_eff{
		no = 3321,
		name = change_skill,
		trigger_proba = 100,
		para = 1221
};

get(3322) ->
	#goods_eff{
		no = 3322,
		name = change_skill,
		trigger_proba = 100,
		para = 1222
};

get(3323) ->
	#goods_eff{
		no = 3323,
		name = change_skill,
		trigger_proba = 100,
		para = 1223
};

get(3324) ->
	#goods_eff{
		no = 3324,
		name = change_skill,
		trigger_proba = 100,
		para = 1224
};

get(3325) ->
	#goods_eff{
		no = 3325,
		name = change_skill,
		trigger_proba = 100,
		para = 1225
};

get(3326) ->
	#goods_eff{
		no = 3326,
		name = change_skill,
		trigger_proba = 100,
		para = 1226
};

get(3327) ->
	#goods_eff{
		no = 3327,
		name = change_skill,
		trigger_proba = 100,
		para = 1227
};

get(3328) ->
	#goods_eff{
		no = 3328,
		name = change_skill,
		trigger_proba = 100,
		para = 1228
};

get(3329) ->
	#goods_eff{
		no = 3329,
		name = change_skill,
		trigger_proba = 100,
		para = 1229
};

get(3330) ->
	#goods_eff{
		no = 3330,
		name = change_skill,
		trigger_proba = 100,
		para = 1230
};

get(3331) ->
	#goods_eff{
		no = 3331,
		name = change_skill,
		trigger_proba = 100,
		para = 1231
};

get(3332) ->
	#goods_eff{
		no = 3332,
		name = change_skill,
		trigger_proba = 100,
		para = 1232
};

get(3333) ->
	#goods_eff{
		no = 3333,
		name = change_skill,
		trigger_proba = 100,
		para = 1233
};

get(3334) ->
	#goods_eff{
		no = 3334,
		name = change_skill,
		trigger_proba = 100,
		para = 1234
};

get(3335) ->
	#goods_eff{
		no = 3335,
		name = change_skill,
		trigger_proba = 100,
		para = 1235
};

get(3336) ->
	#goods_eff{
		no = 3336,
		name = change_skill,
		trigger_proba = 100,
		para = 1236
};

get(3337) ->
	#goods_eff{
		no = 3337,
		name = change_skill,
		trigger_proba = 100,
		para = 1237
};

get(3338) ->
	#goods_eff{
		no = 3338,
		name = change_skill,
		trigger_proba = 100,
		para = 1238
};

get(3339) ->
	#goods_eff{
		no = 3339,
		name = change_skill,
		trigger_proba = 100,
		para = 1239
};

get(3340) ->
	#goods_eff{
		no = 3340,
		name = change_skill,
		trigger_proba = 100,
		para = 1240
};

get(3341) ->
	#goods_eff{
		no = 3341,
		name = change_skill,
		trigger_proba = 100,
		para = 1241
};

get(3342) ->
	#goods_eff{
		no = 3342,
		name = change_skill,
		trigger_proba = 100,
		para = 1242
};

get(3343) ->
	#goods_eff{
		no = 3343,
		name = change_skill,
		trigger_proba = 100,
		para = 1243
};

get(3344) ->
	#goods_eff{
		no = 3344,
		name = change_skill,
		trigger_proba = 100,
		para = 1244
};

get(3345) ->
	#goods_eff{
		no = 3345,
		name = change_skill,
		trigger_proba = 100,
		para = 1245
};

get(3346) ->
	#goods_eff{
		no = 3346,
		name = change_skill,
		trigger_proba = 100,
		para = 1246
};

get(3347) ->
	#goods_eff{
		no = 3347,
		name = change_skill,
		trigger_proba = 100,
		para = 1247
};

get(3348) ->
	#goods_eff{
		no = 3348,
		name = change_skill,
		trigger_proba = 100,
		para = 1248
};

get(3349) ->
	#goods_eff{
		no = 3349,
		name = change_skill,
		trigger_proba = 100,
		para = 1249
};

get(3401) ->
	#goods_eff{
		no = 3401,
		name = change_skill,
		trigger_proba = 100,
		para = 1301
};

get(3402) ->
	#goods_eff{
		no = 3402,
		name = change_skill,
		trigger_proba = 100,
		para = 1302
};

get(3403) ->
	#goods_eff{
		no = 3403,
		name = change_skill,
		trigger_proba = 100,
		para = 1303
};

get(3404) ->
	#goods_eff{
		no = 3404,
		name = change_skill,
		trigger_proba = 100,
		para = 1304
};

get(3405) ->
	#goods_eff{
		no = 3405,
		name = change_skill,
		trigger_proba = 100,
		para = 1305
};

get(3406) ->
	#goods_eff{
		no = 3406,
		name = change_skill,
		trigger_proba = 100,
		para = 1306
};

get(3407) ->
	#goods_eff{
		no = 3407,
		name = change_skill,
		trigger_proba = 100,
		para = 1307
};

get(3408) ->
	#goods_eff{
		no = 3408,
		name = change_skill,
		trigger_proba = 100,
		para = 1308
};

get(3409) ->
	#goods_eff{
		no = 3409,
		name = change_skill,
		trigger_proba = 100,
		para = 1309
};

get(3410) ->
	#goods_eff{
		no = 3410,
		name = change_skill,
		trigger_proba = 100,
		para = 1310
};

get(3411) ->
	#goods_eff{
		no = 3411,
		name = change_skill,
		trigger_proba = 100,
		para = 1311
};

get(3412) ->
	#goods_eff{
		no = 3412,
		name = change_skill,
		trigger_proba = 100,
		para = 1312
};

get(3413) ->
	#goods_eff{
		no = 3413,
		name = change_skill,
		trigger_proba = 100,
		para = 1313
};

get(3414) ->
	#goods_eff{
		no = 3414,
		name = change_skill,
		trigger_proba = 100,
		para = 1314
};

get(4001) ->
	#goods_eff{
		no = 4001,
		name = add_guild_contri,
		trigger_proba = 100,
		para = 100
};

get(4002) ->
	#goods_eff{
		no = 4002,
		name = add_guild_contri,
		trigger_proba = 100,
		para = 200
};

get(4003) ->
	#goods_eff{
		no = 4003,
		name = add_guild_contri,
		trigger_proba = 100,
		para = 500
};

get(4004) ->
	#goods_eff{
		no = 4004,
		name = add_guild_contri,
		trigger_proba = 100,
		para = 1000
};

get(4005) ->
	#goods_eff{
		no = 4005,
		name = add_guild_contri,
		trigger_proba = 100,
		para = 2000
};

get(4006) ->
	#goods_eff{
		no = 4006,
		name = add_guild_contri,
		trigger_proba = 100,
		para = 5000
};

get(4007) ->
	#goods_eff{
		no = 4007,
		name = add_guild_contri,
		trigger_proba = 100,
		para = 10000
};

get(4008) ->
	#goods_eff{
		no = 4008,
		name = add_guild_contri,
		trigger_proba = 100,
		para = 20000
};

get(4009) ->
	#goods_eff{
		no = 4009,
		name = add_guild_contri,
		trigger_proba = 100,
		para = 50000
};

get(4010) ->
	#goods_eff{
		no = 4010,
		name = sub_popular,
		trigger_proba = 100,
		para = 30
};

get(4011) ->
	#goods_eff{
		no = 4011,
		name = sub_popular,
		trigger_proba = 100,
		para = 100
};

get(4012) ->
	#goods_eff{
		no = 4012,
		name = add_popular,
		trigger_proba = 100,
		para = 30
};

get(4013) ->
	#goods_eff{
		no = 4013,
		name = add_popular,
		trigger_proba = 100,
		para = 100
};

get(4014) ->
	#goods_eff{
		no = 4014,
		name = sub_chip,
		trigger_proba = 100,
		para = 1000
};

get(4015) ->
	#goods_eff{
		no = 4015,
		name = sub_chip,
		trigger_proba = 100,
		para = 20000
};

get(4016) ->
	#goods_eff{
		no = 4016,
		name = add_chip,
		trigger_proba = 100,
		para = 1000
};

get(4017) ->
	#goods_eff{
		no = 4017,
		name = add_chip,
		trigger_proba = 100,
		para = 20000
};

get(4018) ->
	#goods_eff{
		no = 4018,
		name = add_chip,
		trigger_proba = 100,
		para = 1
};

get(4019) ->
	#goods_eff{
		no = 4019,
		name = add_chip,
		trigger_proba = 100,
		para = 5
};

get(4020) ->
	#goods_eff{
		no = 4020,
		name = add_chip,
		trigger_proba = 100,
		para = 10
};

get(4021) ->
	#goods_eff{
		no = 4021,
		name = add_chip,
		trigger_proba = 100,
		para = 20
};

get(4022) ->
	#goods_eff{
		no = 4022,
		name = add_chip,
		trigger_proba = 100,
		para = 50
};

get(4023) ->
	#goods_eff{
		no = 4023,
		name = add_chip,
		trigger_proba = 100,
		para = 100
};

get(4024) ->
	#goods_eff{
		no = 4024,
		name = turn_talent_to_free,
		trigger_proba = 100,
		para = 0
};

get(4054) ->
	#goods_eff{
		no = 4054,
		name = add_chip,
		trigger_proba = 100,
		para = 1
};

get(4055) ->
	#goods_eff{
		no = 4055,
		name = add_chip,
		trigger_proba = 100,
		para = 5
};

get(4056) ->
	#goods_eff{
		no = 4056,
		name = add_chip,
		trigger_proba = 100,
		para = 10
};

get(4057) ->
	#goods_eff{
		no = 4057,
		name = add_chip,
		trigger_proba = 100,
		para = 20
};

get(4058) ->
	#goods_eff{
		no = 4058,
		name = add_chip,
		trigger_proba = 100,
		para = 50
};

get(4059) ->
	#goods_eff{
		no = 4059,
		name = add_chip,
		trigger_proba = 100,
		para = 100
};

get(4060) ->
	#goods_eff{
		no = 4060,
		name = accept_task,
		trigger_proba = 100,
		para = 1200019
};

get(4061) ->
	#goods_eff{
		no = 4061,
		name = accept_task,
		trigger_proba = 100,
		para = 1200020
};

get(4062) ->
	#goods_eff{
		no = 4062,
		name = accept_task,
		trigger_proba = 100,
		para = 1200021
};

get(4101) ->
	#goods_eff{
		no = 4101,
		name = transfiguration,
		trigger_proba = 100,
		para = 1
};

get(4102) ->
	#goods_eff{
		no = 4102,
		name = transfiguration,
		trigger_proba = 100,
		para = 2
};

get(4103) ->
	#goods_eff{
		no = 4103,
		name = transfiguration,
		trigger_proba = 100,
		para = 3
};

get(4104) ->
	#goods_eff{
		no = 4104,
		name = transfiguration,
		trigger_proba = 100,
		para = 4
};

get(4105) ->
	#goods_eff{
		no = 4105,
		name = transfiguration,
		trigger_proba = 100,
		para = 5
};

get(4106) ->
	#goods_eff{
		no = 4106,
		name = transfiguration,
		trigger_proba = 100,
		para = 6
};

get(4107) ->
	#goods_eff{
		no = 4107,
		name = transfiguration,
		trigger_proba = 100,
		para = 7
};

get(4108) ->
	#goods_eff{
		no = 4108,
		name = transfiguration,
		trigger_proba = 100,
		para = 8
};

get(4109) ->
	#goods_eff{
		no = 4109,
		name = transfiguration,
		trigger_proba = 100,
		para = 9
};

get(4110) ->
	#goods_eff{
		no = 4110,
		name = transfiguration,
		trigger_proba = 100,
		para = 10
};

get(4111) ->
	#goods_eff{
		no = 4111,
		name = transfiguration,
		trigger_proba = 100,
		para = 11
};

get(4112) ->
	#goods_eff{
		no = 4112,
		name = transfiguration,
		trigger_proba = 100,
		para = 12
};

get(4113) ->
	#goods_eff{
		no = 4113,
		name = transfiguration,
		trigger_proba = 100,
		para = 13
};

get(4114) ->
	#goods_eff{
		no = 4114,
		name = transfiguration,
		trigger_proba = 100,
		para = 14
};

get(4115) ->
	#goods_eff{
		no = 4115,
		name = transfiguration,
		trigger_proba = 100,
		para = 15
};

get(4116) ->
	#goods_eff{
		no = 4116,
		name = transfiguration,
		trigger_proba = 100,
		para = 16
};

get(4117) ->
	#goods_eff{
		no = 4117,
		name = transfiguration,
		trigger_proba = 100,
		para = 17
};

get(4118) ->
	#goods_eff{
		no = 4118,
		name = transfiguration,
		trigger_proba = 100,
		para = 18
};

get(4119) ->
	#goods_eff{
		no = 4119,
		name = transfiguration,
		trigger_proba = 100,
		para = 19
};

get(4120) ->
	#goods_eff{
		no = 4120,
		name = transfiguration,
		trigger_proba = 100,
		para = 20
};

get(4121) ->
	#goods_eff{
		no = 4121,
		name = transfiguration,
		trigger_proba = 100,
		para = 21
};

get(4122) ->
	#goods_eff{
		no = 4122,
		name = transfiguration,
		trigger_proba = 100,
		para = 22
};

get(4123) ->
	#goods_eff{
		no = 4123,
		name = transfiguration,
		trigger_proba = 100,
		para = 23
};

get(4124) ->
	#goods_eff{
		no = 4124,
		name = transfiguration,
		trigger_proba = 100,
		para = 24
};

get(4125) ->
	#goods_eff{
		no = 4125,
		name = transfiguration,
		trigger_proba = 100,
		para = 25
};

get(4126) ->
	#goods_eff{
		no = 4126,
		name = transfiguration,
		trigger_proba = 100,
		para = 26
};

get(4127) ->
	#goods_eff{
		no = 4127,
		name = transfiguration,
		trigger_proba = 100,
		para = 27
};

get(4128) ->
	#goods_eff{
		no = 4128,
		name = transfiguration,
		trigger_proba = 100,
		para = 28
};

get(4129) ->
	#goods_eff{
		no = 4129,
		name = transfiguration,
		trigger_proba = 100,
		para = 29
};

get(4130) ->
	#goods_eff{
		no = 4130,
		name = transfiguration,
		trigger_proba = 100,
		para = 30
};

get(4131) ->
	#goods_eff{
		no = 4131,
		name = transfiguration,
		trigger_proba = 100,
		para = 31
};

get(4132) ->
	#goods_eff{
		no = 4132,
		name = transfiguration,
		trigger_proba = 100,
		para = 32
};

get(4133) ->
	#goods_eff{
		no = 4133,
		name = transfiguration,
		trigger_proba = 100,
		para = 33
};

get(4134) ->
	#goods_eff{
		no = 4134,
		name = transfiguration,
		trigger_proba = 100,
		para = 34
};

get(4135) ->
	#goods_eff{
		no = 4135,
		name = transfiguration,
		trigger_proba = 100,
		para = 35
};

get(4200) ->
	#goods_eff{
		no = 4200,
		name = add_mount_skin,
		trigger_proba = 100,
		para = {1,604800}
};

get(4201) ->
	#goods_eff{
		no = 4201,
		name = add_mount_skin,
		trigger_proba = 100,
		para = {1,1296000}
};

get(4202) ->
	#goods_eff{
		no = 4202,
		name = add_mount_skin,
		trigger_proba = 100,
		para = {1,0}
};

get(4203) ->
	#goods_eff{
		no = 4203,
		name = add_mount_skin,
		trigger_proba = 100,
		para = {2,604800}
};

get(4204) ->
	#goods_eff{
		no = 4204,
		name = add_mount_skin,
		trigger_proba = 100,
		para = {2,1296000}
};

get(4205) ->
	#goods_eff{
		no = 4205,
		name = add_mount_skin,
		trigger_proba = 100,
		para = {2,0}
};

get(4206) ->
	#goods_eff{
		no = 4206,
		name = add_mount_skin,
		trigger_proba = 100,
		para = {3,604800}
};

get(4207) ->
	#goods_eff{
		no = 4207,
		name = add_mount_skin,
		trigger_proba = 100,
		para = {3,1296000}
};

get(4208) ->
	#goods_eff{
		no = 4208,
		name = add_mount_skin,
		trigger_proba = 100,
		para = {3,0}
};

get(4209) ->
	#goods_eff{
		no = 4209,
		name = add_mount_skin,
		trigger_proba = 100,
		para = {4,604800}
};

get(4210) ->
	#goods_eff{
		no = 4210,
		name = add_mount_skin,
		trigger_proba = 100,
		para = {4,1296000}
};

get(4211) ->
	#goods_eff{
		no = 4211,
		name = add_mount_skin,
		trigger_proba = 100,
		para = {4,0}
};

get(4212) ->
	#goods_eff{
		no = 4212,
		name = add_mount_skin,
		trigger_proba = 100,
		para = {5,604800}
};

get(4213) ->
	#goods_eff{
		no = 4213,
		name = add_mount_skin,
		trigger_proba = 100,
		para = {5,1296000}
};

get(4214) ->
	#goods_eff{
		no = 4214,
		name = add_mount_skin,
		trigger_proba = 100,
		para = {5,0}
};

get(4215) ->
	#goods_eff{
		no = 4215,
		name = add_mount_skin,
		trigger_proba = 100,
		para = {6,604800}
};

get(4216) ->
	#goods_eff{
		no = 4216,
		name = add_mount_skin,
		trigger_proba = 100,
		para = {6,1296000}
};

get(4217) ->
	#goods_eff{
		no = 4217,
		name = add_mount_skin,
		trigger_proba = 100,
		para = {6,0}
};

get(4218) ->
	#goods_eff{
		no = 4218,
		name = add_mount_skin,
		trigger_proba = 100,
		para = {7,604800}
};

get(4219) ->
	#goods_eff{
		no = 4219,
		name = add_mount_skin,
		trigger_proba = 100,
		para = {7,1296000}
};

get(4220) ->
	#goods_eff{
		no = 4220,
		name = add_mount_skin,
		trigger_proba = 100,
		para = {7,0}
};

get(4301) ->
	#goods_eff{
		no = 4301,
		name = equip_fashion,
		trigger_proba = 100,
		para = {1,604800}
};

get(4302) ->
	#goods_eff{
		no = 4302,
		name = equip_fashion,
		trigger_proba = 100,
		para = {1,1296000}
};

get(4303) ->
	#goods_eff{
		no = 4303,
		name = equip_fashion,
		trigger_proba = 100,
		para = {1,0}
};

get(4304) ->
	#goods_eff{
		no = 4304,
		name = equip_fashion,
		trigger_proba = 100,
		para = {2,604800}
};

get(4305) ->
	#goods_eff{
		no = 4305,
		name = equip_fashion,
		trigger_proba = 100,
		para = {2,1296000}
};

get(4306) ->
	#goods_eff{
		no = 4306,
		name = equip_fashion,
		trigger_proba = 100,
		para = {2,0}
};

get(4307) ->
	#goods_eff{
		no = 4307,
		name = equip_fashion,
		trigger_proba = 100,
		para = {3,604800}
};

get(4308) ->
	#goods_eff{
		no = 4308,
		name = equip_fashion,
		trigger_proba = 100,
		para = {3,1296000}
};

get(4309) ->
	#goods_eff{
		no = 4309,
		name = equip_fashion,
		trigger_proba = 100,
		para = {3,0}
};

get(4310) ->
	#goods_eff{
		no = 4310,
		name = equip_fashion,
		trigger_proba = 100,
		para = {4,604800}
};

get(4311) ->
	#goods_eff{
		no = 4311,
		name = equip_fashion,
		trigger_proba = 100,
		para = {4,1296000}
};

get(4312) ->
	#goods_eff{
		no = 4312,
		name = equip_fashion,
		trigger_proba = 100,
		para = {4,0}
};

get(4313) ->
	#goods_eff{
		no = 4313,
		name = equip_fashion,
		trigger_proba = 100,
		para = {5,604800}
};

get(4314) ->
	#goods_eff{
		no = 4314,
		name = equip_fashion,
		trigger_proba = 100,
		para = {5,1296000}
};

get(4315) ->
	#goods_eff{
		no = 4315,
		name = equip_fashion,
		trigger_proba = 100,
		para = {5,0}
};

get(_) ->
	      ?ASSERT(false),
          null.

