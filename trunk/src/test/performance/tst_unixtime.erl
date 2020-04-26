%% Author: huangjf
%% Created: 2014.9.19
%% Description: 测试util:unixtime()的效率
-module(tst_unixtime).

-export([
		test/1
	]).






%% 2014.9.19 huangjf本机测试结果：
%%           10万次用时约30ms， 100万次用时约265ms
%%           
test(Times) ->
	tst_prof:run(fun do_test/0, Times).






do_test() ->
	util:unixtime().

