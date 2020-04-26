%%%---------------------------------------
%%% @Module  : data_internal_skill_attribute
%%% @Author  : easy
%%% @Email   : 
%%% @Description: 内功基础表
%%%---------------------------------------


-module(data_internal_skill_attribute).
-export([
        get_lv/0,
        get/1
    ]).

-include("train.hrl").
-include("debug.hrl").

get_lv()->
	[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100].

get(1) ->
	#internal_skill_attribute_cfg{
		lv = 1,
		type_0 = 100,
		type_1 = 60,
		type_2 = 0.001000,
		type_3 = 0.001000,
		type_4 = 1,
		type_5 = 0.001000,
		internal_correct = 1
};

get(2) ->
	#internal_skill_attribute_cfg{
		lv = 2,
		type_0 = 200,
		type_1 = 72,
		type_2 = 0.003000,
		type_3 = 0.004000,
		type_4 = 4,
		type_5 = 0.004000,
		internal_correct = 1
};

get(3) ->
	#internal_skill_attribute_cfg{
		lv = 3,
		type_0 = 300,
		type_1 = 84,
		type_2 = 0.005000,
		type_3 = 0.007000,
		type_4 = 7,
		type_5 = 0.007000,
		internal_correct = 1
};

get(4) ->
	#internal_skill_attribute_cfg{
		lv = 4,
		type_0 = 400,
		type_1 = 96,
		type_2 = 0.007000,
		type_3 = 0.010000,
		type_4 = 10,
		type_5 = 0.010000,
		internal_correct = 1
};

get(5) ->
	#internal_skill_attribute_cfg{
		lv = 5,
		type_0 = 500,
		type_1 = 108,
		type_2 = 0.009000,
		type_3 = 0.013000,
		type_4 = 13.000000,
		type_5 = 0.013000,
		internal_correct = 1
};

get(6) ->
	#internal_skill_attribute_cfg{
		lv = 6,
		type_0 = 600,
		type_1 = 120,
		type_2 = 0.011000,
		type_3 = 0.016000,
		type_4 = 16,
		type_5 = 0.016000,
		internal_correct = 1
};

get(7) ->
	#internal_skill_attribute_cfg{
		lv = 7,
		type_0 = 700,
		type_1 = 132,
		type_2 = 0.013000,
		type_3 = 0.019000,
		type_4 = 19,
		type_5 = 0.019000,
		internal_correct = 1
};

get(8) ->
	#internal_skill_attribute_cfg{
		lv = 8,
		type_0 = 800,
		type_1 = 144,
		type_2 = 0.015000,
		type_3 = 0.022000,
		type_4 = 22,
		type_5 = 0.022000,
		internal_correct = 1
};

get(9) ->
	#internal_skill_attribute_cfg{
		lv = 9,
		type_0 = 900,
		type_1 = 156,
		type_2 = 0.017000,
		type_3 = 0.025000,
		type_4 = 25.000000,
		type_5 = 0.025000,
		internal_correct = 1
};

get(10) ->
	#internal_skill_attribute_cfg{
		lv = 10,
		type_0 = 1000,
		type_1 = 168,
		type_2 = 0.019000,
		type_3 = 0.028000,
		type_4 = 28.000000,
		type_5 = 0.028000,
		internal_correct = 1
};

get(11) ->
	#internal_skill_attribute_cfg{
		lv = 11,
		type_0 = 1100,
		type_1 = 180,
		type_2 = 0.021000,
		type_3 = 0.031000,
		type_4 = 31.000000,
		type_5 = 0.031000,
		internal_correct = 1
};

get(12) ->
	#internal_skill_attribute_cfg{
		lv = 12,
		type_0 = 1200,
		type_1 = 192,
		type_2 = 0.023000,
		type_3 = 0.034000,
		type_4 = 34.000000,
		type_5 = 0.034000,
		internal_correct = 1
};

get(13) ->
	#internal_skill_attribute_cfg{
		lv = 13,
		type_0 = 1300,
		type_1 = 204,
		type_2 = 0.025000,
		type_3 = 0.037000,
		type_4 = 37,
		type_5 = 0.037000,
		internal_correct = 1
};

get(14) ->
	#internal_skill_attribute_cfg{
		lv = 14,
		type_0 = 1400,
		type_1 = 216,
		type_2 = 0.027000,
		type_3 = 0.040000,
		type_4 = 40,
		type_5 = 0.040000,
		internal_correct = 1
};

get(15) ->
	#internal_skill_attribute_cfg{
		lv = 15,
		type_0 = 1500,
		type_1 = 228,
		type_2 = 0.029000,
		type_3 = 0.043000,
		type_4 = 43,
		type_5 = 0.043000,
		internal_correct = 1
};

get(16) ->
	#internal_skill_attribute_cfg{
		lv = 16,
		type_0 = 1600,
		type_1 = 240,
		type_2 = 0.031000,
		type_3 = 0.046000,
		type_4 = 46.000000,
		type_5 = 0.046000,
		internal_correct = 1
};

get(17) ->
	#internal_skill_attribute_cfg{
		lv = 17,
		type_0 = 1700,
		type_1 = 252,
		type_2 = 0.033000,
		type_3 = 0.049000,
		type_4 = 49.000000,
		type_5 = 0.049000,
		internal_correct = 1
};

get(18) ->
	#internal_skill_attribute_cfg{
		lv = 18,
		type_0 = 1800,
		type_1 = 264,
		type_2 = 0.035000,
		type_3 = 0.052000,
		type_4 = 52.000000,
		type_5 = 0.052000,
		internal_correct = 1
};

get(19) ->
	#internal_skill_attribute_cfg{
		lv = 19,
		type_0 = 1900,
		type_1 = 276,
		type_2 = 0.037000,
		type_3 = 0.055000,
		type_4 = 55.000000,
		type_5 = 0.055000,
		internal_correct = 1
};

get(20) ->
	#internal_skill_attribute_cfg{
		lv = 20,
		type_0 = 2000,
		type_1 = 288,
		type_2 = 0.039000,
		type_3 = 0.058000,
		type_4 = 58.000000,
		type_5 = 0.058000,
		internal_correct = 1
};

get(21) ->
	#internal_skill_attribute_cfg{
		lv = 21,
		type_0 = 2100,
		type_1 = 300,
		type_2 = 0.041000,
		type_3 = 0.061000,
		type_4 = 61.000000,
		type_5 = 0.061000,
		internal_correct = 1
};

get(22) ->
	#internal_skill_attribute_cfg{
		lv = 22,
		type_0 = 2200,
		type_1 = 312,
		type_2 = 0.043000,
		type_3 = 0.064000,
		type_4 = 64.000000,
		type_5 = 0.064000,
		internal_correct = 1
};

get(23) ->
	#internal_skill_attribute_cfg{
		lv = 23,
		type_0 = 2300,
		type_1 = 324,
		type_2 = 0.045000,
		type_3 = 0.067000,
		type_4 = 67.000000,
		type_5 = 0.067000,
		internal_correct = 1
};

get(24) ->
	#internal_skill_attribute_cfg{
		lv = 24,
		type_0 = 2400,
		type_1 = 336,
		type_2 = 0.047000,
		type_3 = 0.070000,
		type_4 = 70.000000,
		type_5 = 0.070000,
		internal_correct = 1
};

get(25) ->
	#internal_skill_attribute_cfg{
		lv = 25,
		type_0 = 2500,
		type_1 = 348,
		type_2 = 0.049000,
		type_3 = 0.073000,
		type_4 = 73.000000,
		type_5 = 0.073000,
		internal_correct = 1
};

get(26) ->
	#internal_skill_attribute_cfg{
		lv = 26,
		type_0 = 2600,
		type_1 = 360,
		type_2 = 0.051000,
		type_3 = 0.076000,
		type_4 = 76.000000,
		type_5 = 0.076000,
		internal_correct = 1
};

get(27) ->
	#internal_skill_attribute_cfg{
		lv = 27,
		type_0 = 2700,
		type_1 = 372,
		type_2 = 0.053000,
		type_3 = 0.079000,
		type_4 = 79.000000,
		type_5 = 0.079000,
		internal_correct = 1
};

get(28) ->
	#internal_skill_attribute_cfg{
		lv = 28,
		type_0 = 2800,
		type_1 = 384,
		type_2 = 0.055000,
		type_3 = 0.082000,
		type_4 = 82.000000,
		type_5 = 0.082000,
		internal_correct = 1
};

get(29) ->
	#internal_skill_attribute_cfg{
		lv = 29,
		type_0 = 2900,
		type_1 = 396,
		type_2 = 0.057000,
		type_3 = 0.085000,
		type_4 = 85.000000,
		type_5 = 0.085000,
		internal_correct = 1
};

get(30) ->
	#internal_skill_attribute_cfg{
		lv = 30,
		type_0 = 3000,
		type_1 = 408,
		type_2 = 0.059000,
		type_3 = 0.088000,
		type_4 = 88.000000,
		type_5 = 0.088000,
		internal_correct = 1
};

get(31) ->
	#internal_skill_attribute_cfg{
		lv = 31,
		type_0 = 3100,
		type_1 = 420,
		type_2 = 0.061000,
		type_3 = 0.091000,
		type_4 = 91.000000,
		type_5 = 0.091000,
		internal_correct = 1
};

get(32) ->
	#internal_skill_attribute_cfg{
		lv = 32,
		type_0 = 3200,
		type_1 = 432,
		type_2 = 0.063000,
		type_3 = 0.094000,
		type_4 = 94.000000,
		type_5 = 0.094000,
		internal_correct = 1
};

get(33) ->
	#internal_skill_attribute_cfg{
		lv = 33,
		type_0 = 3300,
		type_1 = 444,
		type_2 = 0.065000,
		type_3 = 0.097000,
		type_4 = 97.000000,
		type_5 = 0.097000,
		internal_correct = 1
};

get(34) ->
	#internal_skill_attribute_cfg{
		lv = 34,
		type_0 = 3400,
		type_1 = 456,
		type_2 = 0.067000,
		type_3 = 0.100000,
		type_4 = 100.000000,
		type_5 = 0.100000,
		internal_correct = 1
};

get(35) ->
	#internal_skill_attribute_cfg{
		lv = 35,
		type_0 = 3500,
		type_1 = 468,
		type_2 = 0.069000,
		type_3 = 0.103000,
		type_4 = 103.000000,
		type_5 = 0.103000,
		internal_correct = 1
};

get(36) ->
	#internal_skill_attribute_cfg{
		lv = 36,
		type_0 = 3600,
		type_1 = 480,
		type_2 = 0.071000,
		type_3 = 0.106000,
		type_4 = 106.000000,
		type_5 = 0.106000,
		internal_correct = 1
};

get(37) ->
	#internal_skill_attribute_cfg{
		lv = 37,
		type_0 = 3700,
		type_1 = 492,
		type_2 = 0.073000,
		type_3 = 0.109000,
		type_4 = 109.000000,
		type_5 = 0.109000,
		internal_correct = 1
};

get(38) ->
	#internal_skill_attribute_cfg{
		lv = 38,
		type_0 = 3800,
		type_1 = 504,
		type_2 = 0.075000,
		type_3 = 0.112000,
		type_4 = 112.000000,
		type_5 = 0.112000,
		internal_correct = 1
};

get(39) ->
	#internal_skill_attribute_cfg{
		lv = 39,
		type_0 = 3900,
		type_1 = 516,
		type_2 = 0.077000,
		type_3 = 0.115000,
		type_4 = 115.000000,
		type_5 = 0.115000,
		internal_correct = 1
};

get(40) ->
	#internal_skill_attribute_cfg{
		lv = 40,
		type_0 = 4000,
		type_1 = 528,
		type_2 = 0.079000,
		type_3 = 0.118000,
		type_4 = 118.000000,
		type_5 = 0.118000,
		internal_correct = 1
};

get(41) ->
	#internal_skill_attribute_cfg{
		lv = 41,
		type_0 = 4100,
		type_1 = 540,
		type_2 = 0.081000,
		type_3 = 0.121000,
		type_4 = 121.000000,
		type_5 = 0.121000,
		internal_correct = 1
};

get(42) ->
	#internal_skill_attribute_cfg{
		lv = 42,
		type_0 = 4200,
		type_1 = 552,
		type_2 = 0.083000,
		type_3 = 0.124000,
		type_4 = 124.000000,
		type_5 = 0.124000,
		internal_correct = 1
};

get(43) ->
	#internal_skill_attribute_cfg{
		lv = 43,
		type_0 = 4300,
		type_1 = 564,
		type_2 = 0.085000,
		type_3 = 0.127000,
		type_4 = 127.000000,
		type_5 = 0.127000,
		internal_correct = 1
};

get(44) ->
	#internal_skill_attribute_cfg{
		lv = 44,
		type_0 = 4400,
		type_1 = 576,
		type_2 = 0.087000,
		type_3 = 0.130000,
		type_4 = 130.000000,
		type_5 = 0.130000,
		internal_correct = 1
};

get(45) ->
	#internal_skill_attribute_cfg{
		lv = 45,
		type_0 = 4500,
		type_1 = 588,
		type_2 = 0.089000,
		type_3 = 0.133000,
		type_4 = 133.000000,
		type_5 = 0.133000,
		internal_correct = 1
};

get(46) ->
	#internal_skill_attribute_cfg{
		lv = 46,
		type_0 = 4600,
		type_1 = 600,
		type_2 = 0.091000,
		type_3 = 0.136000,
		type_4 = 136.000000,
		type_5 = 0.136000,
		internal_correct = 1
};

get(47) ->
	#internal_skill_attribute_cfg{
		lv = 47,
		type_0 = 4700,
		type_1 = 612,
		type_2 = 0.093000,
		type_3 = 0.139000,
		type_4 = 139.000000,
		type_5 = 0.139000,
		internal_correct = 1
};

get(48) ->
	#internal_skill_attribute_cfg{
		lv = 48,
		type_0 = 4800,
		type_1 = 624,
		type_2 = 0.095000,
		type_3 = 0.142000,
		type_4 = 142.000000,
		type_5 = 0.142000,
		internal_correct = 1
};

get(49) ->
	#internal_skill_attribute_cfg{
		lv = 49,
		type_0 = 4900,
		type_1 = 636,
		type_2 = 0.097000,
		type_3 = 0.145000,
		type_4 = 145.000000,
		type_5 = 0.145000,
		internal_correct = 1
};

get(50) ->
	#internal_skill_attribute_cfg{
		lv = 50,
		type_0 = 5000,
		type_1 = 648,
		type_2 = 0.099000,
		type_3 = 0.148000,
		type_4 = 148.000000,
		type_5 = 0.148000,
		internal_correct = 1
};

get(51) ->
	#internal_skill_attribute_cfg{
		lv = 51,
		type_0 = 5100,
		type_1 = 660,
		type_2 = 0.101000,
		type_3 = 0.151000,
		type_4 = 151.000000,
		type_5 = 0.151000,
		internal_correct = 1
};

get(52) ->
	#internal_skill_attribute_cfg{
		lv = 52,
		type_0 = 5200,
		type_1 = 672,
		type_2 = 0.103000,
		type_3 = 0.154000,
		type_4 = 154.000000,
		type_5 = 0.154000,
		internal_correct = 1
};

get(53) ->
	#internal_skill_attribute_cfg{
		lv = 53,
		type_0 = 5300,
		type_1 = 684,
		type_2 = 0.105000,
		type_3 = 0.157000,
		type_4 = 157.000000,
		type_5 = 0.157000,
		internal_correct = 1
};

get(54) ->
	#internal_skill_attribute_cfg{
		lv = 54,
		type_0 = 5400,
		type_1 = 696,
		type_2 = 0.107000,
		type_3 = 0.160000,
		type_4 = 160.000000,
		type_5 = 0.160000,
		internal_correct = 1
};

get(55) ->
	#internal_skill_attribute_cfg{
		lv = 55,
		type_0 = 5500,
		type_1 = 708,
		type_2 = 0.109000,
		type_3 = 0.163000,
		type_4 = 163.000000,
		type_5 = 0.163000,
		internal_correct = 1
};

get(56) ->
	#internal_skill_attribute_cfg{
		lv = 56,
		type_0 = 5600,
		type_1 = 720,
		type_2 = 0.111000,
		type_3 = 0.166000,
		type_4 = 166.000000,
		type_5 = 0.166000,
		internal_correct = 1
};

get(57) ->
	#internal_skill_attribute_cfg{
		lv = 57,
		type_0 = 5700,
		type_1 = 732,
		type_2 = 0.113000,
		type_3 = 0.169000,
		type_4 = 169.000000,
		type_5 = 0.169000,
		internal_correct = 1
};

get(58) ->
	#internal_skill_attribute_cfg{
		lv = 58,
		type_0 = 5800,
		type_1 = 744,
		type_2 = 0.115000,
		type_3 = 0.172000,
		type_4 = 172.000000,
		type_5 = 0.172000,
		internal_correct = 1
};

get(59) ->
	#internal_skill_attribute_cfg{
		lv = 59,
		type_0 = 5900,
		type_1 = 756,
		type_2 = 0.117000,
		type_3 = 0.175000,
		type_4 = 175.000000,
		type_5 = 0.175000,
		internal_correct = 1
};

get(60) ->
	#internal_skill_attribute_cfg{
		lv = 60,
		type_0 = 6000,
		type_1 = 768,
		type_2 = 0.119000,
		type_3 = 0.178000,
		type_4 = 178.000000,
		type_5 = 0.178000,
		internal_correct = 1
};

get(61) ->
	#internal_skill_attribute_cfg{
		lv = 61,
		type_0 = 6100,
		type_1 = 780,
		type_2 = 0.121000,
		type_3 = 0.181000,
		type_4 = 181.000000,
		type_5 = 0.181000,
		internal_correct = 1
};

get(62) ->
	#internal_skill_attribute_cfg{
		lv = 62,
		type_0 = 6200,
		type_1 = 792,
		type_2 = 0.123000,
		type_3 = 0.184000,
		type_4 = 184.000000,
		type_5 = 0.184000,
		internal_correct = 1
};

get(63) ->
	#internal_skill_attribute_cfg{
		lv = 63,
		type_0 = 6300,
		type_1 = 804,
		type_2 = 0.125000,
		type_3 = 0.187000,
		type_4 = 187.000000,
		type_5 = 0.187000,
		internal_correct = 1
};

get(64) ->
	#internal_skill_attribute_cfg{
		lv = 64,
		type_0 = 6400,
		type_1 = 816,
		type_2 = 0.127000,
		type_3 = 0.190000,
		type_4 = 190.000000,
		type_5 = 0.190000,
		internal_correct = 1
};

get(65) ->
	#internal_skill_attribute_cfg{
		lv = 65,
		type_0 = 6500,
		type_1 = 828,
		type_2 = 0.129000,
		type_3 = 0.193000,
		type_4 = 193.000000,
		type_5 = 0.193000,
		internal_correct = 1
};

get(66) ->
	#internal_skill_attribute_cfg{
		lv = 66,
		type_0 = 6600,
		type_1 = 840,
		type_2 = 0.131000,
		type_3 = 0.196000,
		type_4 = 196.000000,
		type_5 = 0.196000,
		internal_correct = 1
};

get(67) ->
	#internal_skill_attribute_cfg{
		lv = 67,
		type_0 = 6700,
		type_1 = 852,
		type_2 = 0.133000,
		type_3 = 0.199000,
		type_4 = 199.000000,
		type_5 = 0.199000,
		internal_correct = 1
};

get(68) ->
	#internal_skill_attribute_cfg{
		lv = 68,
		type_0 = 6800,
		type_1 = 864,
		type_2 = 0.135000,
		type_3 = 0.202000,
		type_4 = 202.000000,
		type_5 = 0.202000,
		internal_correct = 1
};

get(69) ->
	#internal_skill_attribute_cfg{
		lv = 69,
		type_0 = 6900,
		type_1 = 876,
		type_2 = 0.137000,
		type_3 = 0.205000,
		type_4 = 205.000000,
		type_5 = 0.205000,
		internal_correct = 1
};

get(70) ->
	#internal_skill_attribute_cfg{
		lv = 70,
		type_0 = 7000,
		type_1 = 888,
		type_2 = 0.139000,
		type_3 = 0.208000,
		type_4 = 208.000000,
		type_5 = 0.208000,
		internal_correct = 1
};

get(71) ->
	#internal_skill_attribute_cfg{
		lv = 71,
		type_0 = 7100,
		type_1 = 900,
		type_2 = 0.141000,
		type_3 = 0.211000,
		type_4 = 211.000000,
		type_5 = 0.211000,
		internal_correct = 1
};

get(72) ->
	#internal_skill_attribute_cfg{
		lv = 72,
		type_0 = 7200,
		type_1 = 912,
		type_2 = 0.143000,
		type_3 = 0.214000,
		type_4 = 214.000000,
		type_5 = 0.214000,
		internal_correct = 1
};

get(73) ->
	#internal_skill_attribute_cfg{
		lv = 73,
		type_0 = 7300,
		type_1 = 924,
		type_2 = 0.145000,
		type_3 = 0.217000,
		type_4 = 217.000000,
		type_5 = 0.217000,
		internal_correct = 1
};

get(74) ->
	#internal_skill_attribute_cfg{
		lv = 74,
		type_0 = 7400,
		type_1 = 936,
		type_2 = 0.147000,
		type_3 = 0.220000,
		type_4 = 220.000000,
		type_5 = 0.220000,
		internal_correct = 1
};

get(75) ->
	#internal_skill_attribute_cfg{
		lv = 75,
		type_0 = 7500,
		type_1 = 948,
		type_2 = 0.149000,
		type_3 = 0.223000,
		type_4 = 223.000000,
		type_5 = 0.223000,
		internal_correct = 1
};

get(76) ->
	#internal_skill_attribute_cfg{
		lv = 76,
		type_0 = 7600,
		type_1 = 960,
		type_2 = 0.151000,
		type_3 = 0.226000,
		type_4 = 226.000000,
		type_5 = 0.226000,
		internal_correct = 1
};

get(77) ->
	#internal_skill_attribute_cfg{
		lv = 77,
		type_0 = 7700,
		type_1 = 972,
		type_2 = 0.153000,
		type_3 = 0.229000,
		type_4 = 229.000000,
		type_5 = 0.229000,
		internal_correct = 1
};

get(78) ->
	#internal_skill_attribute_cfg{
		lv = 78,
		type_0 = 7800,
		type_1 = 984,
		type_2 = 0.155000,
		type_3 = 0.232000,
		type_4 = 232.000000,
		type_5 = 0.232000,
		internal_correct = 1
};

get(79) ->
	#internal_skill_attribute_cfg{
		lv = 79,
		type_0 = 7900,
		type_1 = 996,
		type_2 = 0.157000,
		type_3 = 0.235000,
		type_4 = 235.000000,
		type_5 = 0.235000,
		internal_correct = 1
};

get(80) ->
	#internal_skill_attribute_cfg{
		lv = 80,
		type_0 = 8000,
		type_1 = 1008,
		type_2 = 0.159000,
		type_3 = 0.238000,
		type_4 = 238.000000,
		type_5 = 0.238000,
		internal_correct = 1
};

get(81) ->
	#internal_skill_attribute_cfg{
		lv = 81,
		type_0 = 8100,
		type_1 = 1020,
		type_2 = 0.161000,
		type_3 = 0.241000,
		type_4 = 241.000000,
		type_5 = 0.241000,
		internal_correct = 1
};

get(82) ->
	#internal_skill_attribute_cfg{
		lv = 82,
		type_0 = 8200,
		type_1 = 1032,
		type_2 = 0.163000,
		type_3 = 0.244000,
		type_4 = 244.000000,
		type_5 = 0.244000,
		internal_correct = 1
};

get(83) ->
	#internal_skill_attribute_cfg{
		lv = 83,
		type_0 = 8300,
		type_1 = 1044,
		type_2 = 0.165000,
		type_3 = 0.247000,
		type_4 = 247.000000,
		type_5 = 0.247000,
		internal_correct = 1
};

get(84) ->
	#internal_skill_attribute_cfg{
		lv = 84,
		type_0 = 8400,
		type_1 = 1056,
		type_2 = 0.167000,
		type_3 = 0.250000,
		type_4 = 250.000000,
		type_5 = 0.250000,
		internal_correct = 1
};

get(85) ->
	#internal_skill_attribute_cfg{
		lv = 85,
		type_0 = 8500,
		type_1 = 1068,
		type_2 = 0.169000,
		type_3 = 0.253000,
		type_4 = 253.000000,
		type_5 = 0.253000,
		internal_correct = 1
};

get(86) ->
	#internal_skill_attribute_cfg{
		lv = 86,
		type_0 = 8600,
		type_1 = 1080,
		type_2 = 0.171000,
		type_3 = 0.256000,
		type_4 = 256.000000,
		type_5 = 0.256000,
		internal_correct = 1
};

get(87) ->
	#internal_skill_attribute_cfg{
		lv = 87,
		type_0 = 8700,
		type_1 = 1092,
		type_2 = 0.173000,
		type_3 = 0.259000,
		type_4 = 259.000000,
		type_5 = 0.259000,
		internal_correct = 1
};

get(88) ->
	#internal_skill_attribute_cfg{
		lv = 88,
		type_0 = 8800,
		type_1 = 1104,
		type_2 = 0.175000,
		type_3 = 0.262000,
		type_4 = 262.000000,
		type_5 = 0.262000,
		internal_correct = 1
};

get(89) ->
	#internal_skill_attribute_cfg{
		lv = 89,
		type_0 = 8900,
		type_1 = 1116,
		type_2 = 0.177000,
		type_3 = 0.265000,
		type_4 = 265.000000,
		type_5 = 0.265000,
		internal_correct = 1
};

get(90) ->
	#internal_skill_attribute_cfg{
		lv = 90,
		type_0 = 9000,
		type_1 = 1128,
		type_2 = 0.179000,
		type_3 = 0.268000,
		type_4 = 268.000000,
		type_5 = 0.268000,
		internal_correct = 1
};

get(91) ->
	#internal_skill_attribute_cfg{
		lv = 91,
		type_0 = 9100,
		type_1 = 1140,
		type_2 = 0.181000,
		type_3 = 0.271000,
		type_4 = 271.000000,
		type_5 = 0.271000,
		internal_correct = 1
};

get(92) ->
	#internal_skill_attribute_cfg{
		lv = 92,
		type_0 = 9200,
		type_1 = 1152,
		type_2 = 0.183000,
		type_3 = 0.274000,
		type_4 = 274.000000,
		type_5 = 0.274000,
		internal_correct = 1
};

get(93) ->
	#internal_skill_attribute_cfg{
		lv = 93,
		type_0 = 9300,
		type_1 = 1164,
		type_2 = 0.185000,
		type_3 = 0.277000,
		type_4 = 277.000000,
		type_5 = 0.277000,
		internal_correct = 1
};

get(94) ->
	#internal_skill_attribute_cfg{
		lv = 94,
		type_0 = 9400,
		type_1 = 1176,
		type_2 = 0.187000,
		type_3 = 0.280000,
		type_4 = 280.000000,
		type_5 = 0.280000,
		internal_correct = 1
};

get(95) ->
	#internal_skill_attribute_cfg{
		lv = 95,
		type_0 = 9500,
		type_1 = 1188,
		type_2 = 0.189000,
		type_3 = 0.283000,
		type_4 = 283.000000,
		type_5 = 0.283000,
		internal_correct = 1
};

get(96) ->
	#internal_skill_attribute_cfg{
		lv = 96,
		type_0 = 9600,
		type_1 = 1200,
		type_2 = 0.191000,
		type_3 = 0.286000,
		type_4 = 286.000000,
		type_5 = 0.286000,
		internal_correct = 1
};

get(97) ->
	#internal_skill_attribute_cfg{
		lv = 97,
		type_0 = 9700,
		type_1 = 1212,
		type_2 = 0.193000,
		type_3 = 0.289000,
		type_4 = 289.000000,
		type_5 = 0.289000,
		internal_correct = 1
};

get(98) ->
	#internal_skill_attribute_cfg{
		lv = 98,
		type_0 = 9800,
		type_1 = 1224,
		type_2 = 0.195000,
		type_3 = 0.292000,
		type_4 = 292.000000,
		type_5 = 0.292000,
		internal_correct = 1
};

get(99) ->
	#internal_skill_attribute_cfg{
		lv = 99,
		type_0 = 9900,
		type_1 = 1236,
		type_2 = 0.197000,
		type_3 = 0.295000,
		type_4 = 295.000000,
		type_5 = 0.295000,
		internal_correct = 1
};

get(100) ->
	#internal_skill_attribute_cfg{
		lv = 100,
		type_0 = 10000,
		type_1 = 1248,
		type_2 = 0.199000,
		type_3 = 0.298000,
		type_4 = 298.000000,
		type_5 = 0.298000,
		internal_correct = 1
};

get(_Lv) ->
	?ASSERT(false, _Lv),
    null.

