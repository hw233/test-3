%% Author: Administrator
%% Created: 2012-1-17
%% Description: TODO: Add description to arith_vs_branch
-module(tst_arith_vs_branch).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([test/0]).

%%
%% API Functions
%%
test() ->
	F1 = fun(I, A) ->
				if A > 0 -> I + A;
				   true -> I
				end   
			end,
	tst_prof:run_index_arg(F1, 100000, 0),
	
	F2 = fun(I, A) ->
				I + A
			end,
	tst_prof:run_index_arg(F2, 100000, 0).


%%
%% Local Functions
%%

