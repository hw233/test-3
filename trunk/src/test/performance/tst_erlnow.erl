%% Author: Administrator
%% Created: 2012-3-27
%% Description: TODO: Add description to erlnow
-module(tst_erlnow).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([test/0, test_rand1/0, test_rand2/0, test_rand3/0]).

%%
%% API Functions
%%

test() ->
	tst_prof:run(fun erlang:now/0, 100000).

test_rand1() ->
  tst_prof:run(fun rand1/0, 100000).

test_rand2() ->
  tst_prof:run(fun rand2/0, 100000).

test_rand3() ->
  tst_prof:run(fun rand3/0, 100000).

%%
%% Local Functions
%%
rand1() ->
	{_,_,R} = erlang:now(),
    N = R div 1000 rem 3 + 1,
	N.
	%io:format("N1=~p~n", [N]).

rand2() ->
	N = random:uniform(3),
	N.
	%io:format("N2=~p~n", [N]).

rand3() ->
	{_,_,R} = os:timestamp(),
    N = R div 1000 rem 3 + 1,
	N.
	%io:format("N3=~p~n", [N]).
