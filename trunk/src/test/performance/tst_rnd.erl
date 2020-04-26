%% Author: Administrator
%% Created: 2012-2-6
%% Description: TODO: Add description to rnd
%% Result: random:uniform比util:rand快大概30ms
-module(tst_rnd).

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
	F1 = fun() ->
				 random:uniform(1000)
		 end,
	F2 = fun() ->
				 util:rand(1, 1000)
		 end,
	tst_prof:run(F1, 100000),
	tst_prof:run(F2, 100000).

%%
%% Local Functions
%%

