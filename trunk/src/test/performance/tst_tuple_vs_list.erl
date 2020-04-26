%% Author: Administrator
%% Created: 2012-1-7
%% Description: TODO: Add description to tuple_vs_list
%% Result: tuple比list快
-module(tst_tuple_vs_list).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([test/0, test_tuple/0, test_list/0]).

%%
%% API Functions
%%
test_tuple() ->
	F = fun() ->
				A1 = [{{1,2,3},{4,5,6}}],
				A2 = [{{11,22,33},{44,55,66}} | A1],
				[{{A,B,C},{D,E,F}} | _T] = A2,
				Sum = A + B + C + D + E + F,
				Sum
			end,
	tst_prof:run(F, 100000).

test_list() ->
	F = fun() ->
				A1 = [[[1,2,3],[4,5,6]]],
				A2 = [[[11,22,33],[44,55,66]] | A1],
				[[[A,B,C],[D,E,F]] | _T] = A2,
				Sum = A + B + C + D + E + F,
				Sum	  
			end,
	tst_prof:run(F, 100000).
	
test() ->
	test_tuple(),
	test_list().
%%
%% Local Functions
%%

