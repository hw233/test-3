%%%-------------------------------------- 
%%% @Module: data_gods_pvp
%%% @Author: 
%%% @Created: 2012-09-22  11:02:46
%%% @Description: 诸神战场
%%%-------------------------------------- 
-module(data_gods_pvp).
% -include("common_gods_pvp.hrl").
% -compile(export_all).

% %%荣誉奖励
% get_win_honor(MyLv, PkLv) -> max(25 + PkLv - MyLv, 0).

% config(Arg) ->
% 	case Arg of

% 		%%每天开始时间
% 		start_time -> {19,0,0};

% 		%%持续时间，距开始时间的秒数
% 		during_time -> 1800;

% 		%%提示结束时间,距开始时间秒数
% 		notice_end_time -> 1500;

% 		%%中途最大离开秒数
% 		max_leave_seconds -> 300;

% 		%%最小允许等级
% 		allow_level -> 32;

% 		%%开启新场景需要达到人数
% 		next_scene_open_num -> 38;

% 		%%每区最大战场数
% 		max_battle_num -> 10;

% 		%%开始默认旗子数｛绿蓝紫红黄｝
% 		default_flag -> {0,0,0,0,0};

% 		%%最大采集旗子数
% 		max_flag_num -> 3;

% 		%%祝福费用，元宝
% 		bless_cost -> 10;

% 		%%最大战神祝福等级
% 		max_bless_mars -> 5;

% 		%%最大血神祝福等级
% 		max_bless_blood -> 5;

% 		%%战败增加荣誉值
% 		lost_honor -> 5;

% 		%%阵营战胜时给玩家增加荣誉值
% 		camp_win_honor -> 100;

% 		%%旗子的权重(荣誉)
% 		color_weigth -> {2,3,5,20,40};

% 		%%额外五级奖的荣誉要求
% 		addition_award_num -> [100,300,500,800,1500];

% 		%%奖励 前XX名, 注意get_award(rank)要对应
% 		top_award_num -> 10;

% 		%%参与礼包发送最小荣誉要求，前XX名不发
% 		attendee_award_honor -> 50;

% 		%%安全区坐标
% 		secure_area -> [{1,23,14,27},{80,22,94,26}];

% 		%%战场阵营信息更新周期(秒)
% 		campinfo_update_period -> 60
% 	end.


% %%所有战场分区ID
% get_id_list() -> [1, 2, 3, 4].


% %%战场分区1, 默认开启的战场
% get(1)->
% 	#ets_gods_pvp_field_s{
% 		field_sid = 1,
% 		res_id = 9003,
% 		minlevel = 32,
% 		maxlevel = 49,
% 		max_player = 44,
% 		max_vip = 6,
% 		addition_award = [{220800502,1},{110100502,2},{120600502,2},{110100503,2},{110100504,1}],
% 		award_top3 = {580100502,1},
% 		award_top10 = {580100503,1},
% 		award_attend = {580100504,1}
% 	};

% get(2)->
% 	#ets_gods_pvp_field_s{
% 		field_sid = 2,
% 		res_id = 9003,
% 		minlevel = 50,
% 		maxlevel = 69,
% 		max_player = 44,
% 		max_vip = 6,
% 		addition_award = [{220800502,1},{110100502,2},{120600502,2},{110100503,2},{110100504,1}],
% 		award_top3 = {580100502,1},
% 		award_top10 = {580100503,1},
% 		award_attend = {580100504,1}
% 	};

% get(3)->
% 	#ets_gods_pvp_field_s{
% 		field_sid = 3,
% 		res_id = 9003,
% 		minlevel = 70,
% 		maxlevel = 89,
% 		max_player = 44,
% 		max_vip = 6,
% 		addition_award = [{220800502,1},{110100502,2},{120600502,2},{110100503,2},{110100504,1}],
% 		award_top3 = {580100502,1},
% 		award_top10 = {580100503,1},
% 		award_attend = {580100504,1}
% 	};

% get(4)->
% 	#ets_gods_pvp_field_s{
% 		field_sid = 4,
% 		res_id = 9003,
% 		minlevel = 90,
% 		maxlevel = 100,
% 		max_player = 44,
% 		max_vip = 6,
% 		addition_award = [{220800502,1},{110100502,2},{120600502,2},{110100503,2},{110100504,1}],
% 		award_top3 = {580100502,1},
% 		award_top10 = {580100503,1},
% 		award_attend = {580100504,1}
% 	}.


% %% 类型, 等级 -> {BuffId, 百分比}
% %%1. 战神
% %%2. 血神
% %%3. 荣誉
% %%4. 全民皆兵
% %%5. 全民自强
% %% 类型
% get_buff(1,1)->{51,10};
% get_buff(1,2)->{52,20};
% get_buff(1,3)->{53,30};
% get_buff(1,4)->{54,40};
% get_buff(1,5)->{55,50};
% get_buff(2,1)->{56,10};
% get_buff(2,2)->{57,20};
% get_buff(2,3)->{58,30};
% get_buff(2,4)->{59,40};
% get_buff(2,5)->{60,50};
% get_buff(3,1)->{0,10};
% get_buff(3,2)->{0,20};
% get_buff(3,3)->{0,30};
% get_buff(3,4)->{0,40};
% get_buff(3,5)->{0,50};
% get_buff(3,6)->{0,60};
% get_buff(3,7)->{0,70};
% get_buff(3,8)->{0,80};
% get_buff(3,9)->{0,90};
% get_buff(3,10)->{0,100};
% get_buff(4,1)->{61,1};
% get_buff(4,2)->{62,2};
% get_buff(4,3)->{63,3};
% get_buff(4,4)->{64,4};
% get_buff(4,5)->{65,6};
% get_buff(4,6)->{66,7};
% get_buff(4,7)->{67,8};
% get_buff(4,8)->{68,9};
% get_buff(4,9)->{69,10};
% get_buff(4,10)->{70,11};
% get_buff(4,11)->{71,13};
% get_buff(4,12)->{72,15};
% get_buff(5,1)->{73,1};
% get_buff(5,2)->{74,2};
% get_buff(5,3)->{75,3};
% get_buff(5,4)->{76,4};
% get_buff(5,5)->{77,6};
% get_buff(5,6)->{78,7};
% get_buff(5,7)->{79,8};
% get_buff(5,8)->{80,9};
% get_buff(5,9)->{81,10};
% get_buff(5,10)->{82,11};
% get_buff(5,11)->{83,13};
% get_buff(5,12)->{84,15};
% get_buff(_,_) ->{0,0}.


% %%连杀荣誉
% get_cont_kill_honor(3) -> 5;
% get_cont_kill_honor(5) -> 10;
% get_cont_kill_honor(8) -> 15;
% get_cont_kill_honor(12) -> 25;
% get_cont_kill_honor(18) -> 50;
% get_cont_kill_honor(24) -> 80;
% get_cont_kill_honor(30) -> 120;
% get_cont_kill_honor(35) -> 150;
% get_cont_kill_honor(40) -> 180;
% get_cont_kill_honor(50) -> 250;
% get_cont_kill_honor(70) -> 400;
% get_cont_kill_honor(90) -> 900;
% get_cont_kill_honor(100) -> 1000;
% get_cont_kill_honor(_) -> 0.
% %%连杀结算荣誉
% get_max_kill_honor(0) -> 0;
% get_max_kill_honor(1) -> 1;
% get_max_kill_honor(2) -> 2;
% get_max_kill_honor(3) -> 6;
% get_max_kill_honor(4) -> 8;
% get_max_kill_honor(5) -> 15;
% get_max_kill_honor(6) -> 18;
% get_max_kill_honor(7) -> 28;
% get_max_kill_honor(8) -> 32;
% get_max_kill_honor(9) -> 45;
% get_max_kill_honor(10) -> 50;
% get_max_kill_honor(11) -> 66;
% get_max_kill_honor(12) -> 72;
% get_max_kill_honor(13) -> 78;
% get_max_kill_honor(14) -> 98;
% get_max_kill_honor(15) -> 105;
% get_max_kill_honor(16) -> 128;
% get_max_kill_honor(17) -> 136;
% get_max_kill_honor(18) -> 144;
% get_max_kill_honor(19) -> 171;
% get_max_kill_honor(20) -> 180;
% get_max_kill_honor(21) -> 189;
% get_max_kill_honor(22) -> 220;
% get_max_kill_honor(23) -> 230;
% get_max_kill_honor(24) -> 240;
% get_max_kill_honor(25) -> 275;
% get_max_kill_honor(26) -> 286;
% get_max_kill_honor(27) -> 297;
% get_max_kill_honor(28) -> 336;
% get_max_kill_honor(29) -> 348;
% get_max_kill_honor(30) -> 360;
% get_max_kill_honor(31) -> 403;
% get_max_kill_honor(32) -> 416;
% get_max_kill_honor(33) -> 429;
% get_max_kill_honor(34) -> 476;
% get_max_kill_honor(35) -> 490;
% get_max_kill_honor(36) -> 504;
% get_max_kill_honor(37) -> 555;
% get_max_kill_honor(38) -> 570;
% get_max_kill_honor(39) -> 585;
% get_max_kill_honor(40) -> 600;
% get_max_kill_honor(41) -> 656;
% get_max_kill_honor(42) -> 672;
% get_max_kill_honor(43) -> 688;
% get_max_kill_honor(44) -> 748;
% get_max_kill_honor(45) -> 765;
% get_max_kill_honor(46) -> 782;
% get_max_kill_honor(47) -> 799;
% get_max_kill_honor(48) -> 864;
% get_max_kill_honor(49) -> 882;
% get_max_kill_honor(50) -> 900;
% get_max_kill_honor(51) -> 969;
% get_max_kill_honor(52) -> 988;
% get_max_kill_honor(53) -> 1007;
% get_max_kill_honor(54) -> 1026;
% get_max_kill_honor(55) -> 1100;
% get_max_kill_honor(56) -> 1120;
% get_max_kill_honor(57) -> 1140;
% get_max_kill_honor(58) -> 1218;
% get_max_kill_honor(59) -> 1239;
% get_max_kill_honor(60) -> 1260;
% get_max_kill_honor(61) -> 1281;
% get_max_kill_honor(62) -> 1364;
% get_max_kill_honor(63) -> 1386;
% get_max_kill_honor(64) -> 1408;
% get_max_kill_honor(65) -> 1430;
% get_max_kill_honor(66) -> 1518;
% get_max_kill_honor(67) -> 1541;
% get_max_kill_honor(68) -> 1564;
% get_max_kill_honor(69) -> 1587;
% get_max_kill_honor(70) -> 1680;
% get_max_kill_honor(71) -> 1704;
% get_max_kill_honor(72) -> 1728;
% get_max_kill_honor(73) -> 1752;
% get_max_kill_honor(74) -> 1850;
% get_max_kill_honor(75) -> 1875;
% get_max_kill_honor(76) -> 1900;
% get_max_kill_honor(77) -> 1925;
% get_max_kill_honor(78) -> 2028;
% get_max_kill_honor(79) -> 2054;
% get_max_kill_honor(80) -> 2080;
% get_max_kill_honor(81) -> 2187;
% get_max_kill_honor(82) -> 2214;
% get_max_kill_honor(83) -> 2241;
% get_max_kill_honor(84) -> 2268;
% get_max_kill_honor(85) -> 2295;
% get_max_kill_honor(86) -> 2408;
% get_max_kill_honor(87) -> 2436;
% get_max_kill_honor(88) -> 2464;
% get_max_kill_honor(89) -> 2492;
% get_max_kill_honor(90) -> 2610;
% get_max_kill_honor(91) -> 2639;
% get_max_kill_honor(92) -> 2668;
% get_max_kill_honor(93) -> 2697;
% get_max_kill_honor(94) -> 2820;
% get_max_kill_honor(95) -> 2850;
% get_max_kill_honor(96) -> 2880;
% get_max_kill_honor(97) -> 2910;
% get_max_kill_honor(98) -> 3038;
% get_max_kill_honor(99) -> 3069;
% get_max_kill_honor(100) -> 3100;
% get_max_kill_honor(_) -> 3100.


% get_acc(1) -> 175;
% get_acc(2) -> 163;
% get_acc(3) -> 154;
% get_acc(4) -> 146;
% get_acc(5) -> 140;
% get_acc(6) -> 134;
% get_acc(7) -> 130;
% get_acc(8) -> 126;
% get_acc(9) -> 123;
% get_acc(10) -> 120;
% get_acc(11) -> 117;
% get_acc(12) -> 115;
% get_acc(13) -> 113;
% get_acc(14) -> 111;
% get_acc(15) -> 109;
% get_acc(16) -> 108;
% get_acc(17) -> 106;
% get_acc(18) -> 105;
% get_acc(19) -> 104;
% get_acc(20) -> 103;
% get_acc(21) -> 102;
% get_acc(22) -> 101;
% get_acc(23) -> 100;
% get_acc(24) -> 99;
% get_acc(25) -> 98;
% get_acc(26) -> 97;
% get_acc(27) -> 97;
% get_acc(28) -> 96;
% get_acc(29) -> 96;
% get_acc(30) -> 95;
% get_acc(31) -> 94;
% get_acc(32) -> 94;
% get_acc(33) -> 93;
% get_acc(34) -> 93;
% get_acc(35) -> 93;
% get_acc(36) -> 92;
% get_acc(37) -> 92;
% get_acc(38) -> 91;
% get_acc(39) -> 91;
% get_acc(40) -> 91;
% get_acc(41) -> 90;
% get_acc(42) -> 90;
% get_acc(43) -> 90;
% get_acc(44) -> 89;
% get_acc(45) -> 89;
% get_acc(46) -> 89;
% get_acc(47) -> 89;
% get_acc(48) -> 88;
% get_acc(49) -> 88;
% get_acc(50) -> 88;
% get_acc(_) -> 0.



