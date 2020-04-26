%% Author: huangjf
%% Created: 2014.7.3
%% Description: 测试erlang:iolist_size()的效率
-module(tst_iolist_size).

-export([
		pre_test/0,
		test/1,

		make_iolist/0,
		do_it/1
	]).




pre_test() ->
	do_nothing.




%% 2014.7.3 huangjf本机测试结果：
%%     Times为十万，耗时：31~47ms， Times为一百万，耗时约450ms
test(Times) ->
	IoList = make_iolist(),
	tst_prof:run_arg(fun do_it/1, Times, IoList).




make_iolist() ->
	Ele1 = <<"adfsdfsdfjsdjfsiusldfjslkdjflsdjfl;sdjfl;sjdfl;sjdfklsdjfsd;fjsl;dfjsldfjiosdfjsl;dfj">>,
	L1 = lists:duplicate(50, Ele1),

	Ele2 = <<3434:16, 34:8, 44:16, 343435:32, 33:8, 343:32, 0:32, 23423423:32, 34:32, 466:32, 3435:32, 94355:32, 3435:32, 345:32, 34345:32, 1199:32, 34:8, 16:8, 0:16, 3435:32, 34345223445:64, 4509:32>>,
	L2 = lists:duplicate(60, Ele2),

	L1 ++ L2.
	




do_it(IoList) ->
	% io:format("do_it, IoList:~w~n", [IoList]),
	Size = iolist_size(IoList),
	Size.

	

