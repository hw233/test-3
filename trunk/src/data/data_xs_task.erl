%%%------------------------------------
%%% @author 严利宏 542430172@qq.com
%%% @copyright UCweb 2014.1.1
%%% @doc description.
%%% @end
%%%------------------------------------


-module(data_xs_task).
-include("common.hrl").
-include("record.hrl").
-compile(export_all).


			config(issue_min_lv) -> 40
		;

			config(issue_num_per_day) -> 50
		;

			config(issue__num_limit) -> 200
		;

			config(issue_task_live_time) -> 5400
		;

			config(receive_num_per_day) -> 10
		;

			config(sys_issue_task_period) -> 1440
		;

			config(sys_issue_task_condition) -> 5
		;

			config(sys_issue_task_rand_info) -> [{40,50,1}, {50, 20, 1},{60, 20, 1},{70, 20,1},{80, 15, 1}]
		;

			config(sys_receive_task_period) -> 3600
		;

			config(sys_receive_task_condition1) -> {5,2}
		;

			config(sys_receive_task_condition2) -> 300
		;

			config(_Key) ->
	?ASSERT(false, _Key),
	null.
		





			get_issue_cost(40) -> 100
		;

			get_issue_cost(41) -> 100
		;

			get_issue_cost(42) -> 100
		;

			get_issue_cost(43) -> 100
		;

			get_issue_cost(44) -> 100
		;

			get_issue_cost(45) -> 100
		;

			get_issue_cost(46) -> 100
		;

			get_issue_cost(47) -> 100
		;

			get_issue_cost(48) -> 100
		;

			get_issue_cost(49) -> 100
		;

			get_issue_cost(50) -> 200
		;

			get_issue_cost(51) -> 200
		;

			get_issue_cost(52) -> 200
		;

			get_issue_cost(53) -> 200
		;

			get_issue_cost(54) -> 200
		;

			get_issue_cost(55) -> 200
		;

			get_issue_cost(56) -> 200
		;

			get_issue_cost(57) -> 200
		;

			get_issue_cost(58) -> 200
		;

			get_issue_cost(59) -> 200
		;

			get_issue_cost(60) -> 300
		;

			get_issue_cost(61) -> 300
		;

			get_issue_cost(62) -> 300
		;

			get_issue_cost(63) -> 300
		;

			get_issue_cost(64) -> 300
		;

			get_issue_cost(65) -> 300
		;

			get_issue_cost(66) -> 300
		;

			get_issue_cost(67) -> 300
		;

			get_issue_cost(68) -> 300
		;

			get_issue_cost(69) -> 300
		;

			get_issue_cost(70) -> 400
		;

			get_issue_cost(71) -> 400
		;

			get_issue_cost(72) -> 400
		;

			get_issue_cost(73) -> 400
		;

			get_issue_cost(74) -> 400
		;

			get_issue_cost(75) -> 400
		;

			get_issue_cost(76) -> 400
		;

			get_issue_cost(77) -> 400
		;

			get_issue_cost(78) -> 400
		;

			get_issue_cost(79) -> 400
		;

			get_issue_cost(80) -> 500
		;

			get_issue_cost(81) -> 500
		;

			get_issue_cost(82) -> 500
		;

			get_issue_cost(83) -> 500
		;

			get_issue_cost(84) -> 500
		;

			get_issue_cost(85) -> 500
		;

			get_issue_cost(86) -> 500
		;

			get_issue_cost(87) -> 500
		;

			get_issue_cost(88) -> 500
		;

			get_issue_cost(89) -> 500
		;

			get_issue_cost(90) -> 500
		;

			get_issue_cost(91) -> 500
		;

			get_issue_cost(92) -> 500
		;

			get_issue_cost(93) -> 500
		;

			get_issue_cost(94) -> 500
		;

			get_issue_cost(95) -> 500
		;

			get_issue_cost(96) -> 500
		;

			get_issue_cost(97) -> 500
		;

			get_issue_cost(98) -> 500
		;

			get_issue_cost(99) -> 500
		;

			get_issue_cost(100) -> 500
		;

			get_issue_cost(_Lv) ->
	?ASSERT(false, _Lv),
	0.
		

			get_issue_exp(40) -> 36000
		;

			get_issue_exp(41) -> 36000
		;

			get_issue_exp(42) -> 36000
		;

			get_issue_exp(43) -> 36000
		;

			get_issue_exp(44) -> 36000
		;

			get_issue_exp(45) -> 36000
		;

			get_issue_exp(46) -> 36000
		;

			get_issue_exp(47) -> 36000
		;

			get_issue_exp(48) -> 36000
		;

			get_issue_exp(49) -> 36000
		;

			get_issue_exp(50) -> 45000
		;

			get_issue_exp(51) -> 45000
		;

			get_issue_exp(52) -> 45000
		;

			get_issue_exp(53) -> 45000
		;

			get_issue_exp(54) -> 45000
		;

			get_issue_exp(55) -> 45000
		;

			get_issue_exp(56) -> 45000
		;

			get_issue_exp(57) -> 45000
		;

			get_issue_exp(58) -> 45000
		;

			get_issue_exp(59) -> 45000
		;

			get_issue_exp(60) -> 57000
		;

			get_issue_exp(61) -> 57000
		;

			get_issue_exp(62) -> 57000
		;

			get_issue_exp(63) -> 57000
		;

			get_issue_exp(64) -> 57000
		;

			get_issue_exp(65) -> 57000
		;

			get_issue_exp(66) -> 57000
		;

			get_issue_exp(67) -> 57000
		;

			get_issue_exp(68) -> 57000
		;

			get_issue_exp(69) -> 57000
		;

			get_issue_exp(70) -> 72000
		;

			get_issue_exp(71) -> 72000
		;

			get_issue_exp(72) -> 72000
		;

			get_issue_exp(73) -> 72000
		;

			get_issue_exp(74) -> 72000
		;

			get_issue_exp(75) -> 72000
		;

			get_issue_exp(76) -> 72000
		;

			get_issue_exp(77) -> 72000
		;

			get_issue_exp(78) -> 72000
		;

			get_issue_exp(79) -> 72000
		;

			get_issue_exp(80) -> 90000
		;

			get_issue_exp(81) -> 90000
		;

			get_issue_exp(82) -> 90000
		;

			get_issue_exp(83) -> 90000
		;

			get_issue_exp(84) -> 90000
		;

			get_issue_exp(85) -> 90000
		;

			get_issue_exp(86) -> 90000
		;

			get_issue_exp(87) -> 90000
		;

			get_issue_exp(88) -> 90000
		;

			get_issue_exp(89) -> 90000
		;

			get_issue_exp(90) -> 90000
		;

			get_issue_exp(91) -> 90000
		;

			get_issue_exp(92) -> 90000
		;

			get_issue_exp(93) -> 90000
		;

			get_issue_exp(94) -> 90000
		;

			get_issue_exp(95) -> 90000
		;

			get_issue_exp(96) -> 90000
		;

			get_issue_exp(97) -> 90000
		;

			get_issue_exp(98) -> 90000
		;

			get_issue_exp(99) -> 90000
		;

			get_issue_exp(100) -> 90000
		;

			get_issue_exp(_Lv) ->
	?ASSERT(false, _Lv),
	0.
		

			get_receive_reward(40) -> 16000
		;

			get_receive_reward(41) -> 16000
		;

			get_receive_reward(42) -> 16000
		;

			get_receive_reward(43) -> 16000
		;

			get_receive_reward(44) -> 16000
		;

			get_receive_reward(45) -> 16000
		;

			get_receive_reward(46) -> 16000
		;

			get_receive_reward(47) -> 16000
		;

			get_receive_reward(48) -> 16000
		;

			get_receive_reward(49) -> 16000
		;

			get_receive_reward(50) -> 18000
		;

			get_receive_reward(51) -> 18000
		;

			get_receive_reward(52) -> 18000
		;

			get_receive_reward(53) -> 18000
		;

			get_receive_reward(54) -> 18000
		;

			get_receive_reward(55) -> 18000
		;

			get_receive_reward(56) -> 18000
		;

			get_receive_reward(57) -> 18000
		;

			get_receive_reward(58) -> 18000
		;

			get_receive_reward(59) -> 18000
		;

			get_receive_reward(60) -> 20000
		;

			get_receive_reward(61) -> 20000
		;

			get_receive_reward(62) -> 20000
		;

			get_receive_reward(63) -> 20000
		;

			get_receive_reward(64) -> 20000
		;

			get_receive_reward(65) -> 20000
		;

			get_receive_reward(66) -> 20000
		;

			get_receive_reward(67) -> 20000
		;

			get_receive_reward(68) -> 20000
		;

			get_receive_reward(69) -> 20000
		;

			get_receive_reward(70) -> 22000
		;

			get_receive_reward(71) -> 22000
		;

			get_receive_reward(72) -> 22000
		;

			get_receive_reward(73) -> 22000
		;

			get_receive_reward(74) -> 22000
		;

			get_receive_reward(75) -> 22000
		;

			get_receive_reward(76) -> 22000
		;

			get_receive_reward(77) -> 22000
		;

			get_receive_reward(78) -> 22000
		;

			get_receive_reward(79) -> 22000
		;

			get_receive_reward(80) -> 24000
		;

			get_receive_reward(81) -> 24000
		;

			get_receive_reward(82) -> 24000
		;

			get_receive_reward(83) -> 24000
		;

			get_receive_reward(84) -> 24000
		;

			get_receive_reward(85) -> 24000
		;

			get_receive_reward(86) -> 24000
		;

			get_receive_reward(87) -> 24000
		;

			get_receive_reward(88) -> 24000
		;

			get_receive_reward(89) -> 24000
		;

			get_receive_reward(90) -> 24000
		;

			get_receive_reward(91) -> 24000
		;

			get_receive_reward(92) -> 24000
		;

			get_receive_reward(93) -> 24000
		;

			get_receive_reward(94) -> 24000
		;

			get_receive_reward(95) -> 24000
		;

			get_receive_reward(96) -> 24000
		;

			get_receive_reward(97) -> 24000
		;

			get_receive_reward(98) -> 24000
		;

			get_receive_reward(99) -> 24000
		;

			get_receive_reward(100) -> 24000
		;

			get_receive_reward(_Lv) ->
	?ASSERT(false, _Lv),
	0.
		

			get_rand_task_list(40) -> [{1141000, 100}]
		;

			get_rand_task_list(41) -> [{1141000, 100}]
		;

			get_rand_task_list(42) -> [{1141000, 100}]
		;

			get_rand_task_list(43) -> [{1141000, 100}]
		;

			get_rand_task_list(44) -> [{1141000, 100}]
		;

			get_rand_task_list(45) -> [{1141000, 100}]
		;

			get_rand_task_list(46) -> [{1141000, 100}]
		;

			get_rand_task_list(47) -> [{1141000, 100}]
		;

			get_rand_task_list(48) -> [{1141000, 100}]
		;

			get_rand_task_list(49) -> [{1141000, 100}]
		;

			get_rand_task_list(50) -> [{1142000, 100}]
		;

			get_rand_task_list(51) -> [{1142000, 100}]
		;

			get_rand_task_list(52) -> [{1142000, 100}]
		;

			get_rand_task_list(53) -> [{1142000, 100}]
		;

			get_rand_task_list(54) -> [{1142000, 100}]
		;

			get_rand_task_list(55) -> [{1142000, 100}]
		;

			get_rand_task_list(56) -> [{1142000, 100}]
		;

			get_rand_task_list(57) -> [{1142000, 100}]
		;

			get_rand_task_list(58) -> [{1142000, 100}]
		;

			get_rand_task_list(59) -> [{1142000, 100}]
		;

			get_rand_task_list(60) -> [{1143000, 100}]
		;

			get_rand_task_list(61) -> [{1143000, 100}]
		;

			get_rand_task_list(62) -> [{1143000, 100}]
		;

			get_rand_task_list(63) -> [{1143000, 100}]
		;

			get_rand_task_list(64) -> [{1143000, 100}]
		;

			get_rand_task_list(65) -> [{1143000, 100}]
		;

			get_rand_task_list(66) -> [{1143000, 100}]
		;

			get_rand_task_list(67) -> [{1143000, 100}]
		;

			get_rand_task_list(68) -> [{1143000, 100}]
		;

			get_rand_task_list(69) -> [{1143000, 100}]
		;

			get_rand_task_list(70) -> [{1144000, 100}]
		;

			get_rand_task_list(71) -> [{1144000, 100}]
		;

			get_rand_task_list(72) -> [{1144000, 100}]
		;

			get_rand_task_list(73) -> [{1144000, 100}]
		;

			get_rand_task_list(74) -> [{1144000, 100}]
		;

			get_rand_task_list(75) -> [{1144000, 100}]
		;

			get_rand_task_list(76) -> [{1144000, 100}]
		;

			get_rand_task_list(77) -> [{1144000, 100}]
		;

			get_rand_task_list(78) -> [{1144000, 100}]
		;

			get_rand_task_list(79) -> [{1144000, 100}]
		;

			get_rand_task_list(80) -> [{1145000, 100}]
		;

			get_rand_task_list(81) -> [{1145000, 100}]
		;

			get_rand_task_list(82) -> [{1145000, 100}]
		;

			get_rand_task_list(83) -> [{1145000, 100}]
		;

			get_rand_task_list(84) -> [{1145000, 100}]
		;

			get_rand_task_list(85) -> [{1145000, 100}]
		;

			get_rand_task_list(86) -> [{1145000, 100}]
		;

			get_rand_task_list(87) -> [{1145000, 100}]
		;

			get_rand_task_list(88) -> [{1145000, 100}]
		;

			get_rand_task_list(89) -> [{1145000, 100}]
		;

			get_rand_task_list(90) -> [{1145000, 100}]
		;

			get_rand_task_list(91) -> [{1145000, 100}]
		;

			get_rand_task_list(92) -> [{1145000, 100}]
		;

			get_rand_task_list(93) -> [{1145000, 100}]
		;

			get_rand_task_list(94) -> [{1145000, 100}]
		;

			get_rand_task_list(95) -> [{1145000, 100}]
		;

			get_rand_task_list(96) -> [{1145000, 100}]
		;

			get_rand_task_list(97) -> [{1145000, 100}]
		;

			get_rand_task_list(98) -> [{1145000, 100}]
		;

			get_rand_task_list(99) -> [{1145000, 100}]
		;

			get_rand_task_list(100) -> [{1145000, 100}]
		;

			get_rand_task_list(_Lv) ->
	?ASSERT(false, _Lv),
	[].
		
