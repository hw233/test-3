%%%---------------------------------------
%%% @Module  : data_bt_plot_event
%%% @Author  : huangjf
%%% @Email   : 
%%% @Description: 剧情战斗的剧情事件
%%%---------------------------------------


-module(data_bt_plot_event).
-export([
        get_event_no_list_by_plot/1,
        get/1
    ]).

-include("bt_plot.hrl").
-include("debug.hrl").

get_event_no_list_by_plot(1)->
	[1,2,3];
get_event_no_list_by_plot(2)->
	[4,5,6,7,8,9];
get_event_no_list_by_plot(3)->
	[10,11,12,13,14,15];
get_event_no_list_by_plot(4)->
	[16,17,18,19,20,21].

get(1) ->
	#bt_plot_event{
		bt_plot_no = 1,
		no = 1,
		condition_list = [100001],
		content = {spawn_mon, 25005, host_side, 6, cannot_be_ctrled}
};

get(2) ->
	#bt_plot_event{
		bt_plot_no = 1,
		no = 2,
		condition_list = [100002],
		content = {spawn_mon, 25006, host_side, 3, cannot_be_ctrled}
};

get(3) ->
	#bt_plot_event{
		bt_plot_no = 1,
		no = 3,
		condition_list = [100003],
		content = {spawn_mon, 25002, guest_side, 2, cannot_be_ctrled}
};

get(4) ->
	#bt_plot_event{
		bt_plot_no = 2,
		no = 4,
		condition_list = [100002],
		content = {spawn_mon, 56009, guest_side, 2, cannot_be_ctrled}
};

get(5) ->
	#bt_plot_event{
		bt_plot_no = 2,
		no = 5,
		condition_list = [100003],
		content = {spawn_mon, 56009, guest_side, 2, cannot_be_ctrled}
};

get(6) ->
	#bt_plot_event{
		bt_plot_no = 2,
		no = 6,
		condition_list = [100004 ],
		content = {spawn_mon, 56009, guest_side, 2, cannot_be_ctrled}
};

get(7) ->
	#bt_plot_event{
		bt_plot_no = 2,
		no = 7,
		condition_list = [100002 ],
		content = {spawn_mon, 56010, guest_side, 2, cannot_be_ctrled}
};

get(8) ->
	#bt_plot_event{
		bt_plot_no = 2,
		no = 8,
		condition_list = [100003 ],
		content = {spawn_mon, 56010, guest_side, 2, cannot_be_ctrled}
};

get(9) ->
	#bt_plot_event{
		bt_plot_no = 2,
		no = 9,
		condition_list = [100004],
		content = {spawn_mon, 56010, guest_side, 2, cannot_be_ctrled}
};

get(10) ->
	#bt_plot_event{
		bt_plot_no = 3,
		no = 10,
		condition_list = [100002],
		content = {spawn_mon, 56012, guest_side, 2, cannot_be_ctrled}
};

get(11) ->
	#bt_plot_event{
		bt_plot_no = 3,
		no = 11,
		condition_list = [100003],
		content = {spawn_mon, 56012, guest_side, 2, cannot_be_ctrled}
};

get(12) ->
	#bt_plot_event{
		bt_plot_no = 3,
		no = 12,
		condition_list = [100004 ],
		content = {spawn_mon, 56012, guest_side, 2, cannot_be_ctrled}
};

get(13) ->
	#bt_plot_event{
		bt_plot_no = 3,
		no = 13,
		condition_list = [100002 ],
		content = {spawn_mon, 56013, guest_side, 2, cannot_be_ctrled}
};

get(14) ->
	#bt_plot_event{
		bt_plot_no = 3,
		no = 14,
		condition_list = [100003 ],
		content = {spawn_mon, 56013, guest_side, 2, cannot_be_ctrled}
};

get(15) ->
	#bt_plot_event{
		bt_plot_no = 3,
		no = 15,
		condition_list = [100004],
		content = {spawn_mon, 56013, guest_side, 2, cannot_be_ctrled}
};

get(16) ->
	#bt_plot_event{
		bt_plot_no = 4,
		no = 16,
		condition_list = [100002],
		content = {spawn_mon, 56014, guest_side, 2, cannot_be_ctrled}
};

get(17) ->
	#bt_plot_event{
		bt_plot_no = 4,
		no = 17,
		condition_list = [100003],
		content = {spawn_mon, 56014, guest_side, 2, cannot_be_ctrled}
};

get(18) ->
	#bt_plot_event{
		bt_plot_no = 4,
		no = 18,
		condition_list = [100004 ],
		content = {spawn_mon, 56014, guest_side, 2, cannot_be_ctrled}
};

get(19) ->
	#bt_plot_event{
		bt_plot_no = 4,
		no = 19,
		condition_list = [100002 ],
		content = {spawn_mon, 56015, guest_side, 2, cannot_be_ctrled}
};

get(20) ->
	#bt_plot_event{
		bt_plot_no = 4,
		no = 20,
		condition_list = [100003 ],
		content = {spawn_mon, 56015, guest_side, 2, cannot_be_ctrled}
};

get(21) ->
	#bt_plot_event{
		bt_plot_no = 4,
		no = 21,
		condition_list = [100004],
		content = {spawn_mon, 56015, guest_side, 2, cannot_be_ctrled}
};

get(_No) ->
	?ASSERT(false, _No),
    null.

