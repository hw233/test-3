%%%---------------------------------------
%%% @Module  : data_world_lv
%%% @Author  : lds
%%% @Email   : 
%%% @Description:  世界等级
%%%---------------------------------------


-module(data_world_lv).
-include("debug.hrl").
-compile(export_all).

 
get_lv_by_open_day(0) -> 40
;
 
get_lv_by_open_day(2) -> 50
;
 
get_lv_by_open_day(7) -> 60
;
 
get_lv_by_open_day(17) -> 65
;
 
get_lv_by_open_day(37) -> 70
;
 
get_lv_by_open_day(77) -> 75
;
 
get_lv_by_open_day(130) -> 80
;
 
get_lv_by_open_day(210) -> 85
;
 
get_lv_by_open_day(370) -> 90
;

get_lv_by_open_day(_Arg1) ->
    ?ASSERT(false, [_Arg1]),
    null.

 
get_open_day_by_lv(40) -> 0
;
 
get_open_day_by_lv(50) -> 2
;
 
get_open_day_by_lv(60) -> 7
;
 
get_open_day_by_lv(65) -> 17
;
 
get_open_day_by_lv(70) -> 37
;
 
get_open_day_by_lv(75) -> 77
;
 
get_open_day_by_lv(80) -> 130
;
 
get_open_day_by_lv(85) -> 210
;
 
get_open_day_by_lv(90) -> 370
;

get_open_day_by_lv(_Arg1) ->
    ?ASSERT(false, [_Arg1]),
    null.

 
get_lv_by_effect_day(2) -> 40
;
 
get_lv_by_effect_day(5) -> 50
;
 
get_lv_by_effect_day(10) -> 60
;
 
get_lv_by_effect_day(20) -> 65
;
 
get_lv_by_effect_day(40) -> 70
;
 
get_lv_by_effect_day(53) -> 75
;
 
get_lv_by_effect_day(80) -> 80
;
 
get_lv_by_effect_day(160) -> 85
;
 
get_lv_by_effect_day(320) -> 90
;

get_lv_by_effect_day(_Arg1) ->
    ?ASSERT(false, [_Arg1]),
    null.

 
get_lv_exp(40) -> 652500
;
 
get_lv_exp(50) -> 1372500
;
 
get_lv_exp(60) -> 2872500
;
 
get_lv_exp(65) -> 4372500
;
 
get_lv_exp(70) -> 6622500
;
 
get_lv_exp(75) -> 10372500
;
 
get_lv_exp(80) -> 17872500
;
 
get_lv_exp(85) -> 29122500
;
 
get_lv_exp(90) -> 44122500
;

get_lv_exp(_Arg1) ->
    ?ASSERT(false, [_Arg1]),
    null.

get_open_day_list()->
	[0,2,7,17,37,77,130,210,370].

get_effect_day_list()->
	[2,5,10,20,40,53,80,160,320].

get_lv_list()->
	[40,50,60,65,70,75,80,85,90].



 
get_debuff_coef(0) -> 1;

 
get_debuff_coef(1) -> 0.950000;

 
get_debuff_coef(2) -> 0.880000;

 
get_debuff_coef(3) -> 0.800000;

 
get_debuff_coef(4) -> 0.700000;

 
get_debuff_coef(5) -> 0.580000;

 
get_debuff_coef(6) -> 0.440000;

 
get_debuff_coef(7) -> 0.260000;

 
get_debuff_coef(8) -> 0.250000;

 
get_debuff_coef(9) -> 0.240000;

 
get_debuff_coef(10) -> 0.230000;

 
get_debuff_coef(11) -> 0.200000;

 
get_debuff_coef(12) -> 0.200000;

 
get_debuff_coef(13) -> 0.200000;

 
get_debuff_coef(14) -> 0.200000;

 
get_debuff_coef(15) -> 0.200000;

 
get_debuff_coef(16) -> 0.200000;

 
get_debuff_coef(17) -> 0.200000;

 
get_debuff_coef(18) -> 0.200000;

 
get_debuff_coef(19) -> 0.200000;

 
get_debuff_coef(20) -> 0.200000;

 
get_debuff_coef(21) -> 0.200000;

 
get_debuff_coef(22) -> 0.200000;

 
get_debuff_coef(23) -> 0.200000;

 
get_debuff_coef(24) -> 0.200000;

 
get_debuff_coef(25) -> 0.200000;

 
get_debuff_coef(26) -> 0.200000;

 
get_debuff_coef(27) -> 0.200000;

 
get_debuff_coef(28) -> 0.200000;

 
get_debuff_coef(29) -> 0.200000;

 
get_debuff_coef(30) -> 0.200000;

 
get_debuff_coef(31) -> 0.200000;

 
get_debuff_coef(32) -> 0.200000;

 
get_debuff_coef(33) -> 0.200000;

 
get_debuff_coef(34) -> 0.200000;

 
get_debuff_coef(35) -> 0.200000;

 
get_debuff_coef(36) -> 0.200000;

 
get_debuff_coef(37) -> 0.200000;

 
get_debuff_coef(38) -> 0.200000;

 
get_debuff_coef(39) -> 0.200000;

 
get_debuff_coef(40) -> 0.200000;

 
get_debuff_coef(41) -> 0.200000;

 
get_debuff_coef(42) -> 0.200000;

 
get_debuff_coef(43) -> 0.200000;

 
get_debuff_coef(44) -> 0.200000;

 
get_debuff_coef(45) -> 0.200000;

 
get_debuff_coef(46) -> 0.200000;

 
get_debuff_coef(47) -> 0.200000;

 
get_debuff_coef(48) -> 0.200000;

 
get_debuff_coef(49) -> 0.200000;

 
get_debuff_coef(50) -> 0.200000;

 
get_debuff_coef(51) -> 0.200000;

 
get_debuff_coef(52) -> 0.200000;

 
get_debuff_coef(53) -> 0.200000;

 
get_debuff_coef(54) -> 0.200000;

 
get_debuff_coef(55) -> 0.200000;

 
get_debuff_coef(56) -> 0.200000;

 
get_debuff_coef(57) -> 0.200000;

 
get_debuff_coef(58) -> 0.200000;

 
get_debuff_coef(59) -> 0.200000;

 
get_debuff_coef(60) -> 0.200000;

 
get_debuff_coef(61) -> 0.200000;

 
get_debuff_coef(62) -> 0.200000;

 
get_debuff_coef(63) -> 0.200000;

 
get_debuff_coef(64) -> 0.200000;

 
get_debuff_coef(65) -> 0.200000;

 
get_debuff_coef(66) -> 0.200000;

 
get_debuff_coef(67) -> 0.200000;

 
get_debuff_coef(68) -> 0.200000;

 
get_debuff_coef(69) -> 0.200000;

 
get_debuff_coef(70) -> 0.200000;

 
get_debuff_coef(71) -> 0.200000;

 
get_debuff_coef(72) -> 0.200000;

 
get_debuff_coef(73) -> 0.200000;

 
get_debuff_coef(74) -> 0.200000;

 
get_debuff_coef(75) -> 0.200000;

 
get_debuff_coef(76) -> 0.200000;

 
get_debuff_coef(77) -> 0.200000;

 
get_debuff_coef(78) -> 0.200000;

 
get_debuff_coef(79) -> 0.200000;

 
get_debuff_coef(80) -> 0.200000;

 
get_debuff_coef(81) -> 0.200000;

 
get_debuff_coef(82) -> 0.200000;

 
get_debuff_coef(83) -> 0.200000;

 
get_debuff_coef(84) -> 0.200000;

 
get_debuff_coef(85) -> 0.200000;

 
get_debuff_coef(86) -> 0.200000;

 
get_debuff_coef(87) -> 0.200000;

 
get_debuff_coef(88) -> 0.200000;

 
get_debuff_coef(89) -> 0.200000;

 
get_debuff_coef(90) -> 0.200000;

 
get_debuff_coef(91) -> 0.200000;

 
get_debuff_coef(92) -> 0.200000;

 
get_debuff_coef(93) -> 0.200000;

 
get_debuff_coef(94) -> 0.200000;

 
get_debuff_coef(95) -> 0.200000;

 
get_debuff_coef(96) -> 0.200000;

 
get_debuff_coef(97) -> 0.200000;

 
get_debuff_coef(98) -> 0.200000;

 
get_debuff_coef(99) -> 0.200000;

 
get_debuff_coef(100) -> 0.200000;


get_debuff_coef(_Arg1) ->
    ?ASSERT(false, [_Arg1]),
    null.

get_dif_lv_list()->
	[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100].



 
get_buff_coef() -> 1.


 

