%% Author: huangjf
%% Created: 2014.4.18
%% Description: 测试erlang:date()的效率
-module(tst_erlang_date).

-export([
		test/1
	]).





	




%% 2014.9.3 huangjf本机测试结果：
%%           100万次用时约200ms
%%           
test(Times) ->
	tst_prof:run(fun test__/0, Times).



test__() ->
    Ret = erlang:date(),
    Ret. %%io:format("ret: ~p~n", [Ret]).