


-module(data_activity_degree).
-include("common.hrl").
-compile(export_all).


get_reward_index_list() -> [1,2,3,4,5].
get_reward_lv_list() -> [{1,500}].

get_need_point_list() -> [{1,20}, {2,40}, {3,60}, {4,80}, {5,100}].

get_need_point_list(1) -> skip
;

get_need_point_list(_) -> skip.




get(1, {1,500}) -> 2201
;

get(2, {1,500}) -> 2202
;

get(3, {1,500}) -> 2203
;

get(4, {1,500}) -> 2204
;

get(5, {1,500}) -> 2205
;

get(_Arg1, _Arg2) ->
    ?ASSERT(false, [_Arg1, _Arg2]), null.


get_rank_reward(1, {1,500}) -> 2201
;

get_rank_reward(2, {1,500}) -> 2202
;

get_rank_reward(3, {1,500}) -> 2203
;

get_rank_reward(4, {1,500}) -> 2204
;

get_rank_reward(5, {1,500}) -> 2205
;

get_rank_reward(_Arg1, _Arg2) ->
    ?ASSERT(false, [_Arg1, _Arg2]), null.



get_sys_list()->
	[1,3,50,4,5,6,12,16,18,28,29,20,7,9,10,13,30,31,32,33,34,35,36,37,22,2,38,39,40,41,42,43,44,45,46,47,48,49].


get_sys_max_times(1) -> 20
;

get_sys_max_times(3) -> 0
;

get_sys_max_times(50) -> 0
;

get_sys_max_times(4) -> 1
;

get_sys_max_times(5) -> 1
;

get_sys_max_times(6) -> 10
;

get_sys_max_times(12) -> 20
;

get_sys_max_times(16) -> 0
;

get_sys_max_times(18) -> 0
;

get_sys_max_times(28) -> 0
;

get_sys_max_times(29) -> 10
;

get_sys_max_times(20) -> 0
;

get_sys_max_times(7) -> 1
;

get_sys_max_times(17) -> 0
;

get_sys_max_times(9) -> 2
;

get_sys_max_times(10) -> 10
;

get_sys_max_times(13) -> 5
;

get_sys_max_times(30) -> 10
;

get_sys_max_times(31) -> 5
;

get_sys_max_times(32) -> 5
;

get_sys_max_times(33) -> 5
;

get_sys_max_times(34) -> 5
;

get_sys_max_times(35) -> 5
;

get_sys_max_times(36) -> 1
;

get_sys_max_times(37) -> 0
;

get_sys_max_times(22) -> 0
;

get_sys_max_times(8) -> 1
;

get_sys_max_times(11) -> 10
;

get_sys_max_times(14) -> 5
;

get_sys_max_times(15) -> 5
;

get_sys_max_times(19) -> 1
;

get_sys_max_times(21) -> 0
;

get_sys_max_times(23) -> 0
;

get_sys_max_times(24) -> 0
;

get_sys_max_times(25) -> 0
;

get_sys_max_times(26) -> 0
;

get_sys_max_times(27) -> 0
;

get_sys_max_times(2) -> 10
;

get_sys_max_times(38) -> 0
;

get_sys_max_times(39) -> 0
;

get_sys_max_times(40) -> 0
;

get_sys_max_times(41) -> 0
;

get_sys_max_times(42) -> 0
;

get_sys_max_times(43) -> 0
;

get_sys_max_times(44) -> 0
;

get_sys_max_times(45) -> 0
;

get_sys_max_times(46) -> 0
;

get_sys_max_times(47) -> 0
;

get_sys_max_times(48) -> 0
;

get_sys_max_times(49) -> 0
;

get_sys_max_times(_Arg) ->
    ?ASSERT(false, [_Arg]), 0.


get_sys_max_point(1) -> 1
;

get_sys_max_point(3) -> 0
;

get_sys_max_point(50) -> 0
;

get_sys_max_point(4) -> 5
;

get_sys_max_point(5) -> 5
;

get_sys_max_point(6) -> 3
;

get_sys_max_point(12) -> 1
;

get_sys_max_point(16) -> 0
;

get_sys_max_point(18) -> 0
;

get_sys_max_point(28) -> 0
;

get_sys_max_point(29) -> 1
;

get_sys_max_point(20) -> 0
;

get_sys_max_point(7) -> 10
;

get_sys_max_point(17) -> 0
;

get_sys_max_point(9) -> 5
;

get_sys_max_point(10) -> 1
;

get_sys_max_point(13) -> 1
;

get_sys_max_point(30) -> 1
;

get_sys_max_point(31) -> 1
;

get_sys_max_point(32) -> 1
;

get_sys_max_point(33) -> 1
;

get_sys_max_point(34) -> 1
;

get_sys_max_point(35) -> 1
;

get_sys_max_point(36) -> 5
;

get_sys_max_point(37) -> 0
;

get_sys_max_point(22) -> 0
;

get_sys_max_point(8) -> 10
;

get_sys_max_point(11) -> 0
;

get_sys_max_point(14) -> 2
;

get_sys_max_point(15) -> 2
;

get_sys_max_point(19) -> 10
;

get_sys_max_point(21) -> 0
;

get_sys_max_point(23) -> 0
;

get_sys_max_point(24) -> 0
;

get_sys_max_point(25) -> 0
;

get_sys_max_point(26) -> 0
;

get_sys_max_point(27) -> 0
;

get_sys_max_point(2) -> 2
;

get_sys_max_point(38) -> 0
;

get_sys_max_point(39) -> 0
;

get_sys_max_point(40) -> 0
;

get_sys_max_point(41) -> 0
;

get_sys_max_point(42) -> 0
;

get_sys_max_point(43) -> 0
;

get_sys_max_point(44) -> 0
;

get_sys_max_point(45) -> 0
;

get_sys_max_point(46) -> 0
;

get_sys_max_point(47) -> 0
;

get_sys_max_point(48) -> 0
;

get_sys_max_point(49) -> 0
;

get_sys_max_point(_Arg) ->
    ?ASSERT(false, [_Arg]), 0.

get_script_activity_list()->
	[16,18,28,20,17,10,13,30,31,32,33,34,35,36,37,22,44].


get_actual_time_script(16) -> [{cycle,{day,[0]},{12,00},30}]
;

get_actual_time_script(18) -> [{cycle,{day,[0]},{12,00},30}]
;

get_actual_time_script(28) -> [{cycle,{day,[0]},{12,00},30}]
;

get_actual_time_script(20) -> [{cycle,{day,[0]},{12,00},30}]
;

get_actual_time_script(17) -> [{cycle,{day,[0]},{18,00},30}]
;

get_actual_time_script(10) -> [{cycle,{day,[0]},{00,00},30},
{cycle,{day,[0]},{01,00},30},
{cycle,{day,[0]},{02,00},30},
{cycle,{day,[0]},{03,00},30},
{cycle,{day,[0]},{04,00},30},
{cycle,{day,[0]},{05,00},30},
{cycle,{day,[0]},{06,00},30},
{cycle,{day,[0]},{07,00},30},
{cycle,{day,[0]},{08,00},30},
{cycle,{day,[0]},{09,00},30},
{cycle,{day,[0]},{10,00},30},
{cycle,{day,[0]},{11,00},30},
{cycle,{day,[0]},{12,00},30},
{cycle,{day,[0]},{13,00},30},
{cycle,{day,[0]},{14,00},30},
{cycle,{day,[0]},{15,00},30},
{cycle,{day,[0]},{16,00},30},
{cycle,{day,[0]},{17,00},30},
{cycle,{day,[0]},{18,00},30},
{cycle,{day,[0]},{19,00},30},
{cycle,{day,[0]},{20,00},30},
{cycle,{day,[0]},{21,00},30},
{cycle,{day,[0]},{22,00},30},
{cycle,{day,[0]},{23,00},30}
]
;

get_actual_time_script(13) -> [{cycle,{day,[0]},{00,00},30},
{cycle,{day,[0]},{01,00},30},
{cycle,{day,[0]},{02,00},30},
{cycle,{day,[0]},{03,00},30},
{cycle,{day,[0]},{04,00},30},
{cycle,{day,[0]},{05,00},30},
{cycle,{day,[0]},{06,00},30},
{cycle,{day,[0]},{07,00},30},
{cycle,{day,[0]},{08,00},30},
{cycle,{day,[0]},{09,00},30},
{cycle,{day,[0]},{10,00},30},
{cycle,{day,[0]},{11,00},30},
{cycle,{day,[0]},{12,00},30},
{cycle,{day,[0]},{13,00},30},
{cycle,{day,[0]},{14,00},30},
{cycle,{day,[0]},{15,00},30},
{cycle,{day,[0]},{16,00},30},
{cycle,{day,[0]},{17,00},30},
{cycle,{day,[0]},{18,00},30},
{cycle,{day,[0]},{19,00},30},
{cycle,{day,[0]},{20,00},30},
{cycle,{day,[0]},{21,00},30},
{cycle,{day,[0]},{22,00},30},
{cycle,{day,[0]},{23,00},30}
]
;

get_actual_time_script(30) -> [{cycle,{day,[0]},{00,30},30},
{cycle,{day,[0]},{01,30},30},
{cycle,{day,[0]},{02,30},30},
{cycle,{day,[0]},{03,30},30},
{cycle,{day,[0]},{04,30},30},
{cycle,{day,[0]},{05,30},30},
{cycle,{day,[0]},{06,30},30},
{cycle,{day,[0]},{07,30},30},
{cycle,{day,[0]},{08,30},30},
{cycle,{day,[0]},{09,30},30},
{cycle,{day,[0]},{10,30},30},
{cycle,{day,[0]},{11,30},30},
{cycle,{day,[0]},{12,30},30},
{cycle,{day,[0]},{13,30},30},
{cycle,{day,[0]},{14,30},30},
{cycle,{day,[0]},{15,30},30},
{cycle,{day,[0]},{16,30},30},
{cycle,{day,[0]},{17,30},30},
{cycle,{day,[0]},{18,30},30},
{cycle,{day,[0]},{19,30},30},
{cycle,{day,[0]},{20,30},30},
{cycle,{day,[0]},{21,30},30},
{cycle,{day,[0]},{22,30},30},
{cycle,{day,[0]},{23,30},30}
]
;

get_actual_time_script(31) -> [{cycle,{day,[0]},{00,30},30},
{cycle,{day,[0]},{01,30},30},
{cycle,{day,[0]},{02,30},30},
{cycle,{day,[0]},{03,30},30},
{cycle,{day,[0]},{04,30},30},
{cycle,{day,[0]},{05,30},30},
{cycle,{day,[0]},{06,30},30},
{cycle,{day,[0]},{07,30},30},
{cycle,{day,[0]},{08,30},30},
{cycle,{day,[0]},{09,30},30},
{cycle,{day,[0]},{10,30},30},
{cycle,{day,[0]},{11,30},30},
{cycle,{day,[0]},{12,30},30},
{cycle,{day,[0]},{13,30},30},
{cycle,{day,[0]},{14,30},30},
{cycle,{day,[0]},{15,30},30},
{cycle,{day,[0]},{16,30},30},
{cycle,{day,[0]},{17,30},30},
{cycle,{day,[0]},{18,30},30},
{cycle,{day,[0]},{19,30},30},
{cycle,{day,[0]},{20,30},30},
{cycle,{day,[0]},{21,30},30},
{cycle,{day,[0]},{22,30},30},
{cycle,{day,[0]},{23,30},30}
]
;

get_actual_time_script(32) -> [{cycle,{day,[0]},{12,00},30},
{cycle,{day,[0]},{14,00},30},
{cycle,{day,[0]},{16,00},30},
{cycle,{day,[0]},{18,00},30},
{cycle,{day,[0]},{20,00},30},
{cycle,{day,[0]},{22,00},30}
]
;

get_actual_time_script(33) -> [{cycle,{day,[0]},{13,00},30},
{cycle,{day,[0]},{15,00},30},
{cycle,{day,[0]},{17,00},30},
{cycle,{day,[0]},{19,00},30},
{cycle,{day,[0]},{21,00},30},
{cycle,{day,[0]},{23,00},30}
]
;

get_actual_time_script(34) -> [{cycle,{day,[0]},{18,00},30},
{cycle,{day,[0]},{19,00},30},
{cycle,{day,[0]},{20,00},30},
{cycle,{day,[0]},{21,00},30},
{cycle,{day,[0]},{22,00},30},
{cycle,{day,[0]},{23,00},30}
]
;

get_actual_time_script(35) -> [{cycle,{day,[0]},{18,30},30},
{cycle,{day,[0]},{19,30},30},
{cycle,{day,[0]},{20,30},30},
{cycle,{day,[0]},{21,30},30},
{cycle,{day,[0]},{22,30},30},
{cycle,{day,[0]},{23,30},30}
]
;

get_actual_time_script(36) -> [{cycle,{day,[0]},{12,00},720}]
;

get_actual_time_script(37) -> [{cycle,{day,[0]},{00,00},30},
{cycle,{day,[0]},{01,00},30},
{cycle,{day,[0]},{02,00},30},
{cycle,{day,[0]},{03,00},30},
{cycle,{day,[0]},{04,00},30},
{cycle,{day,[0]},{05,00},30},
{cycle,{day,[0]},{06,00},30},
{cycle,{day,[0]},{07,00},30},
{cycle,{day,[0]},{08,00},30},
{cycle,{day,[0]},{09,00},30},
{cycle,{day,[0]},{10,00},30},
{cycle,{day,[0]},{11,00},30},
{cycle,{day,[0]},{12,00},30},
{cycle,{day,[0]},{13,00},30},
{cycle,{day,[0]},{14,00},30},
{cycle,{day,[0]},{15,00},30},
{cycle,{day,[0]},{16,00},30},
{cycle,{day,[0]},{17,00},30},
{cycle,{day,[0]},{18,00},30},
{cycle,{day,[0]},{19,00},30},
{cycle,{day,[0]},{20,00},30},
{cycle,{day,[0]},{21,00},30},
{cycle,{day,[0]},{22,00},30},
{cycle,{day,[0]},{23,00},30}
]
;

get_actual_time_script(22) -> [{cycle,{day,[0]},{19,00},30}]
;

get_actual_time_script(44) -> [{cycle,{day,[0]},{12,00},60}]
;

get_actual_time_script(_Arg) ->
    ?ASSERT(false, [_Arg]), null.


get_time_script(16) -> [{cycle,{day,[0]},{12,00},30}]
;

get_time_script(18) -> [{cycle,{day,[0]},{12,00},30}]
;

get_time_script(28) -> [{cycle,{day,[0]},{12,00},30}]
;

get_time_script(20) -> [{cycle,{day,[0]},{12,00},30}]
;

get_time_script(17) -> [{cycle,{day,[0]},{17,45},45}]
;

get_time_script(10) -> [{cycle,{day,[0]},{00,00},30},
{cycle,{day,[0]},{01,00},30},
{cycle,{day,[0]},{02,00},30},
{cycle,{day,[0]},{03,00},30},
{cycle,{day,[0]},{04,00},30},
{cycle,{day,[0]},{05,00},30},
{cycle,{day,[0]},{06,00},30},
{cycle,{day,[0]},{07,00},30},
{cycle,{day,[0]},{08,00},30},
{cycle,{day,[0]},{09,00},30},
{cycle,{day,[0]},{10,00},30},
{cycle,{day,[0]},{11,00},30},
{cycle,{day,[0]},{12,00},30},
{cycle,{day,[0]},{13,00},30},
{cycle,{day,[0]},{14,00},30},
{cycle,{day,[0]},{15,00},30},
{cycle,{day,[0]},{16,00},30},
{cycle,{day,[0]},{17,00},30},
{cycle,{day,[0]},{18,00},30},
{cycle,{day,[0]},{19,00},30},
{cycle,{day,[0]},{20,00},30},
{cycle,{day,[0]},{21,00},30},
{cycle,{day,[0]},{22,00},30},
{cycle,{day,[0]},{23,00},30}
]
;

get_time_script(13) -> [{cycle,{day,[0]},{00,00},30},
{cycle,{day,[0]},{01,00},30},
{cycle,{day,[0]},{02,00},30},
{cycle,{day,[0]},{03,00},30},
{cycle,{day,[0]},{04,00},30},
{cycle,{day,[0]},{05,00},30},
{cycle,{day,[0]},{06,00},30},
{cycle,{day,[0]},{07,00},30},
{cycle,{day,[0]},{08,00},30},
{cycle,{day,[0]},{09,00},30},
{cycle,{day,[0]},{10,00},30},
{cycle,{day,[0]},{11,00},30},
{cycle,{day,[0]},{12,00},30},
{cycle,{day,[0]},{13,00},30},
{cycle,{day,[0]},{14,00},30},
{cycle,{day,[0]},{15,00},30},
{cycle,{day,[0]},{16,00},30},
{cycle,{day,[0]},{17,00},30},
{cycle,{day,[0]},{18,00},30},
{cycle,{day,[0]},{19,00},30},
{cycle,{day,[0]},{20,00},30},
{cycle,{day,[0]},{21,00},30},
{cycle,{day,[0]},{22,00},30},
{cycle,{day,[0]},{23,00},30}
]
;

get_time_script(30) -> [{cycle,{day,[0]},{00,30},30},
{cycle,{day,[0]},{01,30},30},
{cycle,{day,[0]},{02,30},30},
{cycle,{day,[0]},{03,30},30},
{cycle,{day,[0]},{04,30},30},
{cycle,{day,[0]},{05,30},30},
{cycle,{day,[0]},{06,30},30},
{cycle,{day,[0]},{07,30},30},
{cycle,{day,[0]},{08,30},30},
{cycle,{day,[0]},{09,30},30},
{cycle,{day,[0]},{10,30},30},
{cycle,{day,[0]},{11,30},30},
{cycle,{day,[0]},{12,30},30},
{cycle,{day,[0]},{13,30},30},
{cycle,{day,[0]},{14,30},30},
{cycle,{day,[0]},{15,30},30},
{cycle,{day,[0]},{16,30},30},
{cycle,{day,[0]},{17,30},30},
{cycle,{day,[0]},{18,30},30},
{cycle,{day,[0]},{19,30},30},
{cycle,{day,[0]},{20,30},30},
{cycle,{day,[0]},{21,30},30},
{cycle,{day,[0]},{22,30},30},
{cycle,{day,[0]},{23,30},30}
]
;

get_time_script(31) -> [{cycle,{day,[0]},{00,30},30},
{cycle,{day,[0]},{01,30},30},
{cycle,{day,[0]},{02,30},30},
{cycle,{day,[0]},{03,30},30},
{cycle,{day,[0]},{04,30},30},
{cycle,{day,[0]},{05,30},30},
{cycle,{day,[0]},{06,30},30},
{cycle,{day,[0]},{07,30},30},
{cycle,{day,[0]},{08,30},30},
{cycle,{day,[0]},{09,30},30},
{cycle,{day,[0]},{10,30},30},
{cycle,{day,[0]},{11,30},30},
{cycle,{day,[0]},{12,30},30},
{cycle,{day,[0]},{13,30},30},
{cycle,{day,[0]},{14,30},30},
{cycle,{day,[0]},{15,30},30},
{cycle,{day,[0]},{16,30},30},
{cycle,{day,[0]},{17,30},30},
{cycle,{day,[0]},{18,30},30},
{cycle,{day,[0]},{19,30},30},
{cycle,{day,[0]},{20,30},30},
{cycle,{day,[0]},{21,30},30},
{cycle,{day,[0]},{22,30},30},
{cycle,{day,[0]},{23,30},30}
]
;

get_time_script(32) -> [{cycle,{day,[0]},{12,00},30},
{cycle,{day,[0]},{14,00},30},
{cycle,{day,[0]},{16,00},30},
{cycle,{day,[0]},{18,00},30},
{cycle,{day,[0]},{20,00},30},
{cycle,{day,[0]},{22,00},30}
]
;

get_time_script(33) -> [{cycle,{day,[0]},{13,00},30},
{cycle,{day,[0]},{15,00},30},
{cycle,{day,[0]},{17,00},30},
{cycle,{day,[0]},{19,00},30},
{cycle,{day,[0]},{21,00},30},
{cycle,{day,[0]},{23,00},30}
]
;

get_time_script(34) -> [{cycle,{day,[0]},{18,00},30},
{cycle,{day,[0]},{19,00},30},
{cycle,{day,[0]},{20,00},30},
{cycle,{day,[0]},{21,00},30},
{cycle,{day,[0]},{22,00},30},
{cycle,{day,[0]},{23,00},30}
]
;

get_time_script(35) -> [{cycle,{day,[0]},{18,30},30},
{cycle,{day,[0]},{19,30},30},
{cycle,{day,[0]},{20,30},30},
{cycle,{day,[0]},{21,30},30},
{cycle,{day,[0]},{22,30},30},
{cycle,{day,[0]},{23,30},30}
]
;

get_time_script(36) -> [{cycle,{day,[0]},{12,00},720}]
;

get_time_script(37) -> [{cycle,{day,[0]},{00,00},30},
{cycle,{day,[0]},{01,00},30},
{cycle,{day,[0]},{02,00},30},
{cycle,{day,[0]},{03,00},30},
{cycle,{day,[0]},{04,00},30},
{cycle,{day,[0]},{05,00},30},
{cycle,{day,[0]},{06,00},30},
{cycle,{day,[0]},{07,00},30},
{cycle,{day,[0]},{08,00},30},
{cycle,{day,[0]},{09,00},30},
{cycle,{day,[0]},{10,00},30},
{cycle,{day,[0]},{11,00},30},
{cycle,{day,[0]},{12,00},30},
{cycle,{day,[0]},{13,00},30},
{cycle,{day,[0]},{14,00},30},
{cycle,{day,[0]},{15,00},30},
{cycle,{day,[0]},{16,00},30},
{cycle,{day,[0]},{17,00},30},
{cycle,{day,[0]},{18,00},30},
{cycle,{day,[0]},{19,00},30},
{cycle,{day,[0]},{20,00},30},
{cycle,{day,[0]},{21,00},30},
{cycle,{day,[0]},{22,00},30},
{cycle,{day,[0]},{23,00},30}
]
;

get_time_script(22) -> [{cycle,{day,[0]},{19,00},30}]
;

get_time_script(44) -> [{cycle,{week,1},{11,50},70},{cycle,{week,2},{11,50},70},{cycle,{week,3},{11,50},70},{cycle,{week,4},{11,50},70},{cycle,{week,5},{11,50},70},{cycle,{week,6},{11,50},70},{cycle,{week,7},{11,50},70}]
;

get_time_script(_Arg) ->
    ?ASSERT(false, [_Arg]), null.


get_script(16) -> [{0,{broadcast,[{49, []}]}},{0,{notify_activity_open,[16]}},
{1, {guild_party_b}},
{2, {add_guild_buff, 10}},
{1798, {guild_party_e}},{1799,{broadcast,[{90, []}]}}]
;

get_script(18) -> [{0,{notify_activity_open,[18]}},
{1800,{arena_1v1_close}}]
;

get_script(28) -> [{0,{notify_activity_open,[28]}},
{1800,{arena_3v3_close}}]
;

get_script(20) -> [{0,{broadcast,[{75, []}]}},
{10,{broadcast,[{76, []}]}},
{0,{open_boss_dungeon,[110001]}},
{0,{notify_activity_open,[20]}}]
;

get_script(17) -> [{0,{broadcast,[{82, []}]}},
{300,{broadcast,[{83, []}]}},
{600,{broadcast,[{84, []}]}},
{780,{notify_activity_open,[17]}},
{840,{broadcast,[{85, []}]}},
{901,{guild_dungeon_b,[]}}]
;

get_script(10) -> [{0,{broadcast,[{10, []}]}},
{0,{notify_activity_open,[10]}},
{0,{refresh,[[random,[1304],[{1001,10000}],20]]}},
{120,{refresh,[[random,[1304],[{1001,10000}],20]]}},
{240,{refresh,[[random,[1304],[{1001,10000}],20]]}},
{360,{refresh,[[random,[1304],[{1001,10000}],20]]}},
{480,{refresh,[[random,[1304],[{1001,10000}],20]]}},
{600,{refresh,[[random,[1304],[{1001,10000}],20]]}},
{720,{refresh,[[random,[1304],[{1001,10000}],20]]}},
{840,{refresh,[[random,[1304],[{1001,10000}],20]]}},
{960,{refresh,[[random,[1304],[{1001,10000}],20]]}},
{1080,{refresh,[[random,[1304],[{1001,10000}],20]]}},
{1200,{refresh,[[random,[1304],[{1001,10000}],20]]}},
{1320,{refresh,[[random,[1304],[{1001,10000}],20]]}},
{1440,{refresh,[[random,[1304],[{1001,10000}],20]]}},
{1560,{refresh,[[random,[1304],[{1001,10000}],20]]}},
{1680,{refresh,[[random,[1304],[{1001,10000}],20]]}}]
;

get_script(13) -> [{0,{broadcast,[{10, []}]}},
{0,{notify_activity_open,[13]}},
{0,{refresh,[[random,[1304],[{1002,10000}],15]]}},
{120,{refresh,[[random,[1304],[{1002,10000}],15]]}},
{240,{refresh,[[random,[1304],[{1002,10000}],15]]}},
{360,{refresh,[[random,[1304],[{1002,10000}],15]]}},
{480,{refresh,[[random,[1304],[{1002,10000}],15]]}},
{600,{refresh,[[random,[1304],[{1002,10000}],15]]}},
{720,{refresh,[[random,[1304],[{1002,10000}],15]]}},
{840,{refresh,[[random,[1304],[{1002,10000}],15]]}},
{960,{refresh,[[random,[1304],[{1002,10000}],15]]}},
{1080,{refresh,[[random,[1304],[{1002,10000}],15]]}},
{1200,{refresh,[[random,[1304],[{1002,10000}],15]]}},
{1320,{refresh,[[random,[1304],[{1002,10000}],15]]}},
{1440,{refresh,[[random,[1304],[{1002,10000}],15]]}},
{1560,{refresh,[[random,[1304],[{1002,10000}],15]]}},
{1680,{refresh,[[random,[1304],[{1002,10000}],15]]}}]
;

get_script(30) -> [{0,{broadcast,[{10, []}]}},
{0,{notify_activity_open,[30]}},
{0,{refresh,[[random,[1304],[{1003,10000}],20]]}},
{120,{refresh,[[random,[1304],[{1003,10000}],20]]}},
{240,{refresh,[[random,[1304],[{1003,10000}],20]]}},
{360,{refresh,[[random,[1304],[{1003,10000}],20]]}},
{480,{refresh,[[random,[1304],[{1003,10000}],20]]}},
{600,{refresh,[[random,[1304],[{1003,10000}],20]]}},
{720,{refresh,[[random,[1304],[{1003,10000}],20]]}},
{840,{refresh,[[random,[1304],[{1003,10000}],20]]}},
{960,{refresh,[[random,[1304],[{1003,10000}],20]]}},
{1080,{refresh,[[random,[1304],[{1003,10000}],20]]}},
{1200,{refresh,[[random,[1304],[{1003,10000}],20]]}},
{1320,{refresh,[[random,[1304],[{1003,10000}],20]]}},
{1440,{refresh,[[random,[1304],[{1003,10000}],20]]}},
{1560,{refresh,[[random,[1304],[{1003,10000}],20]]}},
{1680,{refresh,[[random,[1304],[{1003,10000}],20]]}}]
;

get_script(31) -> [{0,{broadcast,[{10, []}]}},
{0,{notify_activity_open,[31]}},
{0,{refresh,[[random,[1304],[{1004,10000}],15]]}},
{120,{refresh,[[random,[1304],[{1004,10000}],15]]}},
{240,{refresh,[[random,[1304],[{1004,10000}],15]]}},
{360,{refresh,[[random,[1304],[{1004,10000}],15]]}},
{480,{refresh,[[random,[1304],[{1004,10000}],15]]}},
{600,{refresh,[[random,[1304],[{1004,10000}],15]]}},
{720,{refresh,[[random,[1304],[{1004,10000}],15]]}},
{840,{refresh,[[random,[1304],[{1004,10000}],15]]}},
{960,{refresh,[[random,[1304],[{1004,10000}],15]]}},
{1080,{refresh,[[random,[1304],[{1004,10000}],15]]}},
{1200,{refresh,[[random,[1304],[{1004,10000}],15]]}},
{1320,{refresh,[[random,[1304],[{1004,10000}],15]]}},
{1440,{refresh,[[random,[1304],[{1004,10000}],15]]}},
{1560,{refresh,[[random,[1304],[{1004,10000}],15]]}},
{1680,{refresh,[[random,[1304],[{1004,10000}],15]]}}]
;

get_script(32) -> [{0,{broadcast,[{10, []}]}},
{0,{notify_activity_open,[32]}},
{0,{refresh,[[random,[1305],[{1005,2500},{1006,2500},{1007,2500},{1008,2500}],15]]}},
{120,{refresh,[[random,[1305],[{1005,2500},{1006,2500},{1007,2500},{1008,2500}],15]]}},
{240,{refresh,[[random,[1305],[{1005,2500},{1006,2500},{1007,2500},{1008,2500}],15]]}},
{360,{refresh,[[random,[1305],[{1005,2500},{1006,2500},{1007,2500},{1008,2500}],15]]}},
{480,{refresh,[[random,[1305],[{1005,2500},{1006,2500},{1007,2500},{1008,2500}],15]]}},
{600,{refresh,[[random,[1305],[{1005,2500},{1006,2500},{1007,2500},{1008,2500}],15]]}},
{720,{refresh,[[random,[1305],[{1005,2500},{1006,2500},{1007,2500},{1008,2500}],15]]}},
{840,{refresh,[[random,[1305],[{1005,2500},{1006,2500},{1007,2500},{1008,2500}],15]]}},
{960,{refresh,[[random,[1305],[{1005,2500},{1006,2500},{1007,2500},{1008,2500}],15]]}},
{1080,{refresh,[[random,[1305],[{1005,2500},{1006,2500},{1007,2500},{1008,2500}],15]]}},
{1200,{refresh,[[random,[1305],[{1005,2500},{1006,2500},{1007,2500},{1008,2500}],15]]}},
{1320,{refresh,[[random,[1305],[{1005,2500},{1006,2500},{1007,2500},{1008,2500}],15]]}},
{1440,{refresh,[[random,[1305],[{1005,2500},{1006,2500},{1007,2500},{1008,2500}],15]]}},
{1560,{refresh,[[random,[1305],[{1005,2500},{1006,2500},{1007,2500},{1008,2500}],15]]}},
{1680,{refresh,[[random,[1305],[{1005,2500},{1006,2500},{1007,2500},{1008,2500}],15]]}}]
;

get_script(33) -> [{0,{broadcast,[{10, []}]}},
{0,{notify_activity_open,[33]}},
{0,{refresh,[[random,[1203],[{1009,2500},{1010,2500},{1011,2500},{1012,2500}],15]]}},
{120,{refresh,[[random,[1203],[{1009,2500},{1010,2500},{1011,2500},{1012,2500}],15]]}},
{240,{refresh,[[random,[1203],[{1009,2500},{1010,2500},{1011,2500},{1012,2500}],15]]}},
{360,{refresh,[[random,[1203],[{1009,2500},{1010,2500},{1011,2500},{1012,2500}],15]]}},
{480,{refresh,[[random,[1203],[{1009,2500},{1010,2500},{1011,2500},{1012,2500}],15]]}},
{600,{refresh,[[random,[1203],[{1009,2500},{1010,2500},{1011,2500},{1012,2500}],15]]}},
{720,{refresh,[[random,[1203],[{1009,2500},{1010,2500},{1011,2500},{1012,2500}],15]]}},
{840,{refresh,[[random,[1203],[{1009,2500},{1010,2500},{1011,2500},{1012,2500}],15]]}},
{960,{refresh,[[random,[1203],[{1009,2500},{1010,2500},{1011,2500},{1012,2500}],15]]}},
{1080,{refresh,[[random,[1203],[{1009,2500},{1010,2500},{1011,2500},{1012,2500}],15]]}},
{1200,{refresh,[[random,[1203],[{1009,2500},{1010,2500},{1011,2500},{1012,2500}],15]]}},
{1320,{refresh,[[random,[1203],[{1009,2500},{1010,2500},{1011,2500},{1012,2500}],15]]}},
{1440,{refresh,[[random,[1203],[{1009,2500},{1010,2500},{1011,2500},{1012,2500}],15]]}},
{1560,{refresh,[[random,[1203],[{1009,2500},{1010,2500},{1011,2500},{1012,2500}],15]]}},
{1680,{refresh,[[random,[1203],[{1009,2500},{1010,2500},{1011,2500},{1012,2500}],15]]}}
]
;

get_script(34) -> [{0,{broadcast,[{10, []}]}},
{0,{notify_activity_open,[34]}},
{0,{refresh,[[random,[13081],[{1013,2500},{1014,2500},{1015,2500},{1016,2500}],15]]}},
{120,{refresh,[[random,[13081],[{1013,2500},{1014,2500},{1015,2500},{1016,2500}],15]]}},
{240,{refresh,[[random,[13081],[{1013,2500},{1014,2500},{1015,2500},{1016,2500}],15]]}},
{360,{refresh,[[random,[13081],[{1013,2500},{1014,2500},{1015,2500},{1016,2500}],15]]}},
{480,{refresh,[[random,[13081],[{1013,2500},{1014,2500},{1015,2500},{1016,2500}],15]]}},
{600,{refresh,[[random,[13081],[{1013,2500},{1014,2500},{1015,2500},{1016,2500}],15]]}},
{720,{refresh,[[random,[13081],[{1013,2500},{1014,2500},{1015,2500},{1016,2500}],15]]}},
{840,{refresh,[[random,[13081],[{1013,2500},{1014,2500},{1015,2500},{1016,2500}],15]]}},
{960,{refresh,[[random,[13081],[{1013,2500},{1014,2500},{1015,2500},{1016,2500}],15]]}},
{1080,{refresh,[[random,[13081],[{1013,2500},{1014,2500},{1015,2500},{1016,2500}],15]]}},
{1200,{refresh,[[random,[13081],[{1013,2500},{1014,2500},{1015,2500},{1016,2500}],15]]}},
{1320,{refresh,[[random,[13081],[{1013,2500},{1014,2500},{1015,2500},{1016,2500}],15]]}},
{1440,{refresh,[[random,[13081],[{1013,2500},{1014,2500},{1015,2500},{1016,2500}],15]]}},
{1560,{refresh,[[random,[13081],[{1013,2500},{1014,2500},{1015,2500},{1016,2500}],15]]}},
{1680,{refresh,[[random,[13081],[{1013,2500},{1014,2500},{1015,2500},{1016,2500}],15]]}}]
;

get_script(35) -> [{0,{broadcast,[{10, []}]}},
{0,{notify_activity_open,[35]}},
{0,{refresh,[[random,[1310],[{1017,2500},{1018,2500},{1019,2500},{1020,2500}],15]]}},
{120,{refresh,[[random,[1310],[{1017,2500},{1018,2500},{1019,2500},{1020,2500}],15]]}},
{240,{refresh,[[random,[1310],[{1017,2500},{1018,2500},{1019,2500},{1020,2500}],15]]}},
{360,{refresh,[[random,[1310],[{1017,2500},{1018,2500},{1019,2500},{1020,2500}],15]]}},
{480,{refresh,[[random,[1310],[{1017,2500},{1018,2500},{1019,2500},{1020,2500}],15]]}},
{600,{refresh,[[random,[1310],[{1017,2500},{1018,2500},{1019,2500},{1020,2500}],15]]}},
{720,{refresh,[[random,[1310],[{1017,2500},{1018,2500},{1019,2500},{1020,2500}],15]]}},
{840,{refresh,[[random,[1310],[{1017,2500},{1018,2500},{1019,2500},{1020,2500}],15]]}},
{960,{refresh,[[random,[1310],[{1017,2500},{1018,2500},{1019,2500},{1020,2500}],15]]}},
{1080,{refresh,[[random,[1310],[{1017,2500},{1018,2500},{1019,2500},{1020,2500}],15]]}},
{1200,{refresh,[[random,[1310],[{1017,2500},{1018,2500},{1019,2500},{1020,2500}],15]]}},
{1320,{refresh,[[random,[1310],[{1017,2500},{1018,2500},{1019,2500},{1020,2500}],15]]}},
{1440,{refresh,[[random,[1310],[{1017,2500},{1018,2500},{1019,2500},{1020,2500}],15]]}},
{1560,{refresh,[[random,[1310],[{1017,2500},{1018,2500},{1019,2500},{1020,2500}],15]]}},
{1680,{refresh,[[random,[1310],[{1017,2500},{1018,2500},{1019,2500},{1020,2500}],15]]}}]
;

get_script(36) -> [{0,{broadcast,[{10, []}]}},
{0,{notify_activity_open,[36]}},
{0,{refresh,[[single,1303,[{61, 108}],[{1021,2500},{1022,2500},{1023,2500},{1024,2500}],1]]}}]
;

get_script(37) -> [{0,{broadcast,[{306, []}]}},
{0,{refresh,[[random_npc,[1304],[{5800,10000}],10]]}},
{0,{refresh,[[random_npc,[1305],[{5800,10000}],10]]}},
{0,{refresh,[[random_npc,[1203],[{5800,10000}],10]]}},
{0,{refresh,[[random_npc,[1303],[{5800,10000}],10]]}},
{0,{refresh,[[random_npc,[1310],[{5800,10000}],10]]}},
{0,{refresh,[[random_npc,[13081],[{5800,10000}],10]]}}]
;

get_script(22) -> [{0,{broadcast,[{322, []}]}},
{0,{notify_activity_open,[22]}},
{0,{melee_activity_begin}},
{1,{refresh,[[random,[9002],[{2301,10000}],15]]}},
{120,{refresh,[[random,[9002],[{2301,10000}],15]]}},
{240,{refresh,[[random,[9002],[{2301,10000}],15]]}},
{360,{refresh,[[random,[9002],[{2301,10000}],15]]}},
{480,{refresh,[[random,[9002],[{2301,10000}],15]]}},
{600,{refresh,[[random,[9002],[{2301,10000}],15]]}},
{720,{refresh,[[random,[9002],[{2301,10000}],15]]}},
{840,{refresh,[[random,[9002],[{2301,10000}],15]]}},
{960,{refresh,[[random,[9002],[{2301,10000}],15]]}},
{1080,{refresh,[[random,[9002],[{2301,10000}],15]]}},
{1200,{refresh,[[random,[9002],[{2301,10000}],15]]}},
{1320,{refresh,[[random,[9002],[{2301,10000}],15]]}},
{1440,{refresh,[[random,[9002],[{2301,10000}],15]]}},
{1560,{refresh,[[random,[9002],[{2301,10000}],15]]}},
{1680,{refresh,[[random,[9002],[{2301,10000}],15]]}},
{1800,{melee_activity_end}}]
;

get_script(44) -> [{0,{broadcast,[{371, []}]}},
{420,{broadcast,[{372, []}]}},
{421,{open_boss_dungeon,[110002]}},
{570,{notify_activity_open,[44]}}]
;

get_script(_Arg) ->
    ?ASSERT(false, [_Arg]), null.


get_actual_times(1) -> sys
;

get_actual_times(3) -> 0
;

get_actual_times(50) -> 0
;

get_actual_times(4) -> sys
;

get_actual_times(5) -> sys
;

get_actual_times(6) -> sys
;

get_actual_times(12) -> sys
;

get_actual_times(16) -> 0
;

get_actual_times(18) -> 0
;

get_actual_times(28) -> 0
;

get_actual_times(29) -> sys
;

get_actual_times(20) -> 0
;

get_actual_times(7) -> sys
;

get_actual_times(17) -> 0
;

get_actual_times(9) -> sys
;

get_actual_times(10) -> sys
;

get_actual_times(13) -> sys
;

get_actual_times(30) -> sys
;

get_actual_times(31) -> sys
;

get_actual_times(32) -> sys
;

get_actual_times(33) -> sys
;

get_actual_times(34) -> ad
;

get_actual_times(35) -> ad
;

get_actual_times(36) -> ad
;

get_actual_times(37) -> 0
;

get_actual_times(22) -> 0
;

get_actual_times(8) -> 0
;

get_actual_times(11) -> sys
;

get_actual_times(14) -> ad
;

get_actual_times(15) -> ad
;

get_actual_times(19) -> sys
;

get_actual_times(21) -> 0
;

get_actual_times(23) -> 0
;

get_actual_times(24) -> 0
;

get_actual_times(25) -> 0
;

get_actual_times(26) -> 0
;

get_actual_times(27) -> ad
;

get_actual_times(2) -> sys
;

get_actual_times(38) -> 0
;

get_actual_times(39) -> 0
;

get_actual_times(40) -> 0
;

get_actual_times(41) -> 0
;

get_actual_times(42) -> 0
;

get_actual_times(43) -> 0
;

get_actual_times(44) -> 0
;

get_actual_times(45) -> 0
;

get_actual_times(46) -> 0
;

get_actual_times(47) -> 0
;

get_actual_times(48) -> 0
;

get_actual_times(49) -> 0
;

get_actual_times(_Arg) ->
    ?ASSERT(false, [_Arg]), 0.


get_actual_max_times(1) -> 20
;

get_actual_max_times(3) -> 0
;

get_actual_max_times(50) -> 0
;

get_actual_max_times(4) -> sys
;

get_actual_max_times(5) -> sys
;

get_actual_max_times(6) -> 100
;

get_actual_max_times(12) -> 20
;

get_actual_max_times(16) -> 0
;

get_actual_max_times(18) -> 0
;

get_actual_max_times(28) -> 0
;

get_actual_max_times(29) -> 10
;

get_actual_max_times(20) -> 0
;

get_actual_max_times(7) -> 1
;

get_actual_max_times(17) -> 0
;

get_actual_max_times(9) -> sys
;

get_actual_max_times(10) -> 10
;

get_actual_max_times(13) -> 5
;

get_actual_max_times(30) -> 10
;

get_actual_max_times(31) -> 5
;

get_actual_max_times(32) -> 5
;

get_actual_max_times(33) -> 5
;

get_actual_max_times(34) -> 5
;

get_actual_max_times(35) -> 5
;

get_actual_max_times(36) -> 1
;

get_actual_max_times(37) -> 0
;

get_actual_max_times(22) -> 0
;

get_actual_max_times(8) -> 0
;

get_actual_max_times(11) -> sys
;

get_actual_max_times(14) -> 5
;

get_actual_max_times(15) -> 5
;

get_actual_max_times(19) -> sys
;

get_actual_max_times(21) -> 0
;

get_actual_max_times(23) -> 0
;

get_actual_max_times(24) -> 0
;

get_actual_max_times(25) -> 0
;

get_actual_max_times(26) -> 0
;

get_actual_max_times(27) -> 1
;

get_actual_max_times(2) -> sys
;

get_actual_max_times(38) -> 0
;

get_actual_max_times(39) -> 0
;

get_actual_max_times(40) -> 0
;

get_actual_max_times(41) -> 0
;

get_actual_max_times(42) -> 0
;

get_actual_max_times(43) -> 0
;

get_actual_max_times(44) -> 0
;

get_actual_max_times(45) -> 0
;

get_actual_max_times(46) -> 0
;

get_actual_max_times(47) -> 0
;

get_actual_max_times(48) -> 0
;

get_actual_max_times(49) -> 0
;

get_actual_max_times(_Arg) ->
    ?ASSERT(false, [_Arg]), 0.


get_times_data(1) -> [1041100,1042100,1043100,1044100]
;

get_times_data(3) -> nil
;

get_times_data(50) -> nil
;

get_times_data(4) -> 5051
;

get_times_data(5) -> 4001
;

get_times_data(6) -> [1060000]
;

get_times_data(12) -> [1031000]
;

get_times_data(16) -> nil
;

get_times_data(18) -> nil
;

get_times_data(28) -> nil
;

get_times_data(29) -> [1070000]
;

get_times_data(20) -> nil
;

get_times_data(7) -> nil
;

get_times_data(17) -> nil
;

get_times_data(9) -> nil
;

get_times_data(10) -> [1001]
;

get_times_data(13) -> [1002]
;

get_times_data(30) -> [1003]
;

get_times_data(31) -> [1004]
;

get_times_data(32) -> [1005]
;

get_times_data(33) -> [1006]
;

get_times_data(34) -> [1007,1008,1009,1010,1011]
;

get_times_data(35) -> [1012,1013,1014,1015,1016]
;

get_times_data(36) -> [1017,1018,1019,1020,1021]
;

get_times_data(37) -> nil
;

get_times_data(22) -> nil
;

get_times_data(8) -> nil
;

get_times_data(11) -> nil
;

get_times_data(14) -> nil
;

get_times_data(15) -> nil
;

get_times_data(19) -> nil
;

get_times_data(21) -> nil
;

get_times_data(23) -> nil
;

get_times_data(24) -> nil
;

get_times_data(25) -> nil
;

get_times_data(26) -> nil
;

get_times_data(27) -> nil
;

get_times_data(2) -> nil
;

get_times_data(38) -> nil
;

get_times_data(39) -> nil
;

get_times_data(40) -> nil
;

get_times_data(41) -> nil
;

get_times_data(42) -> nil
;

get_times_data(43) -> nil
;

get_times_data(44) -> nil
;

get_times_data(45) -> nil
;

get_times_data(46) -> nil
;

get_times_data(47) -> nil
;

get_times_data(48) -> nil
;

get_times_data(49) -> nil
;

get_times_data(_Arg) ->
    ?ASSERT(false, [_Arg]), nil.


get_mark_data(1) -> []
;

get_mark_data(3) -> []
;

get_mark_data(50) -> []
;

get_mark_data(4) -> []
;

get_mark_data(5) -> []
;

get_mark_data(6) -> []
;

get_mark_data(12) -> []
;

get_mark_data(16) -> []
;

get_mark_data(18) -> []
;

get_mark_data(28) -> []
;

get_mark_data(29) -> [1070000]
;

get_mark_data(20) -> []
;

get_mark_data(7) -> []
;

get_mark_data(17) -> []
;

get_mark_data(9) -> []
;

get_mark_data(10) -> [1001]
;

get_mark_data(13) -> [1002]
;

get_mark_data(30) -> [1003]
;

get_mark_data(31) -> [1004]
;

get_mark_data(32) -> [1005]
;

get_mark_data(33) -> [1006]
;

get_mark_data(34) -> [1007,1008,1009,1010,1011]
;

get_mark_data(35) -> [1012,1013,1014,1015,1016]
;

get_mark_data(36) -> [1017,1018,1019,1020,1021]
;

get_mark_data(37) -> []
;

get_mark_data(22) -> []
;

get_mark_data(8) -> []
;

get_mark_data(11) -> []
;

get_mark_data(14) -> [1021001,1021002,1021003]
;

get_mark_data(15) -> [1022001,1022002,1022003]
;

get_mark_data(19) -> []
;

get_mark_data(21) -> []
;

get_mark_data(23) -> []
;

get_mark_data(24) -> []
;

get_mark_data(25) -> []
;

get_mark_data(26) -> []
;

get_mark_data(27) -> []
;

get_mark_data(2) -> []
;

get_mark_data(38) -> []
;

get_mark_data(39) -> []
;

get_mark_data(40) -> []
;

get_mark_data(41) -> []
;

get_mark_data(42) -> []
;

get_mark_data(43) -> []
;

get_mark_data(44) -> []
;

get_mark_data(45) -> []
;

get_mark_data(46) -> []
;

get_mark_data(47) -> []
;

get_mark_data(48) -> []
;

get_mark_data(49) -> []
;

get_mark_data(_Arg) ->
    ?ASSERT(false, [_Arg]), [].


get_activity_open_lv(1) -> 60;


get_activity_open_lv(3) -> 125;


get_activity_open_lv(50) -> 160;


get_activity_open_lv(4) -> 80;


get_activity_open_lv(5) -> 80;


get_activity_open_lv(6) -> 90;


get_activity_open_lv(12) -> 65;


get_activity_open_lv(16) -> 15;


get_activity_open_lv(18) -> 30;


get_activity_open_lv(28) -> 30;


get_activity_open_lv(29) -> 100;


get_activity_open_lv(20) -> 120;


get_activity_open_lv(7) -> 70;


get_activity_open_lv(17) -> 65;


get_activity_open_lv(9) -> 150;


get_activity_open_lv(10) -> 70;


get_activity_open_lv(13) -> 70;


get_activity_open_lv(30) -> 120;


get_activity_open_lv(31) -> 120;


get_activity_open_lv(32) -> 150;


get_activity_open_lv(33) -> 180;


get_activity_open_lv(34) -> 220;


get_activity_open_lv(35) -> 250;


get_activity_open_lv(36) -> 300;


get_activity_open_lv(37) -> 20;


get_activity_open_lv(22) -> 100;


get_activity_open_lv(8) -> 0;


get_activity_open_lv(11) -> 25;


get_activity_open_lv(14) -> 33;


get_activity_open_lv(15) -> 20;


get_activity_open_lv(19) -> 16;


get_activity_open_lv(21) -> 15;


get_activity_open_lv(23) -> 50;


get_activity_open_lv(24) -> 40;


get_activity_open_lv(25) -> 15;


get_activity_open_lv(26) -> 30;


get_activity_open_lv(27) -> 60;


get_activity_open_lv(2) -> 85;


get_activity_open_lv(38) -> 150;


get_activity_open_lv(39) -> 150;


get_activity_open_lv(40) -> 150;


get_activity_open_lv(41) -> 150;


get_activity_open_lv(42) -> 150;


get_activity_open_lv(43) -> 150;


get_activity_open_lv(44) -> 30;


get_activity_open_lv(45) -> 150;


get_activity_open_lv(46) -> 0;


get_activity_open_lv(47) -> 120;


get_activity_open_lv(48) -> 120;


get_activity_open_lv(49) -> 135;


get_activity_open_lv(_Arg) ->
    ?ASSERT(false, [_Arg]), 0.

