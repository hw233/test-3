%% Author: huangjf
%% Created: 2014.5.23
%% Description: 测试ets:tab2list()的效率
-module(tst_ets_tab2list).

-export([
		pre_test/0,
		test/1,
		test2/1
	]).


-include("monster.hrl").


pre_test() ->
	new_ets().




%% 2014.5.23 huangjf本机测试结果：
%%     
test(Times) ->
	tst_prof:run(fun tab2list/0, Times).


test2(Times) ->
	tst_prof:run(fun get_foreach/0, Times).




new_ets() ->
	io:format("new_est()...~n"),
	ets:new(my_test_tbl_ets_tab2list, [{keypos, #mon.id}, named_table, public, set]),

	ets:new(my_test_tbl_ets_tab2list_2, [named_table, public, set]),

	F = fun(Seq) ->
			Mon = #mon{
					id = Seq
					% res_id = Seq
					% bmon_group_no_list = [10001, 10002, 10003]
					},
			ets:insert(my_test_tbl_ets_tab2list, Mon)
		end,

	L = lists:seq(1, 3000),
	lists:foreach(F, L),


	ets:insert(my_test_tbl_ets_tab2list_2, {mon_id_list, L}),

	io:format("new_est() done!~n").

	


tab2list() ->
	_L = ets:tab2list(my_test_tbl_ets_tab2list), 
	ok.
	% erlang:hd(L).



get_foreach() ->
	[{mon_id_list, L}] = ets:lookup(my_test_tbl_ets_tab2list_2, mon_id_list),
	lists:foreach(fun get_mon/1, L).








get_mon(MonId) ->
			[Mon] = ets:lookup(my_test_tbl_ets_tab2list, MonId),
			Mon#mon.id.