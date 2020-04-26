%% Author: Administrator
%% Created: 2013-6-4
%% Description: TODO: Add description to tuple_vs_list use in scene data
%% Result: tuple比list快
-module(tst_locate_tuple_vs_list).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([test/0, test_tuple_locate/0, test_list_locate/0]).

-include("debug.hrl").
%%
%% API Functions
%%
test_list_locate() ->
	F = fun() ->
				ScenList = data_mask:get(100),
				%io:format("ScenList: ~p~n", ScenList),
				%io:format("ScenListLen: ~p~n", [length(ScenList)]),
				%%X = 40,
				%%Y = 85,
				X = rand(1, 54),
				Y = rand(1, 96),
				Z = (X - 1) * 96 + Y,
				%io:format("Z: ~p~n", [Z]),
				_ScenState = lists:nth(Z, ScenList),
				%?ASSERT(Z > 5184),
				%?ASSERT(Z < 1),
				%ScenState = lists:nth(40 * 96 + 85, ScenList),
				_ScenState
			end,
	tst_prof:run(F, 100000). %% X Y 固定时用时4940ms   X Y 随机时4945ms 与函数运行次数成正比关系

test_tuple_locate() ->
	F = fun() ->
				ScenTuple = data_mask:get(99),
				%%X = 40, 
				%%Y = 85,
				X = rand(1, 54),
				Y = rand(1, 96),
				Z = (X - 1) * 96 + Y,
				_ScenState = element(Z, ScenTuple),
				%ScenState = element(40 * 96 + 85, ScenTuple),
				_ScenState
			end,
	tst_prof:run(F, 100000). %% X Y 固定时用时16ms, X Y 随机时140ms 与函数运行次数成正比关系
	
test() ->
	test_tuple_locate(),
	test_list_locate().
%%
%% Local Functions
%%
%% 产生一个介于Min到Max之间的随机整数
rand(Same, Same) -> Same;
rand(Min, Max) ->
    %% 如果没有种子，将从核心服务器中去获取一个种子，以保证不同进程都可取得不同的种子
   
    random:seed(os:timestamp()),
    M = Min - 1,
    random:uniform(Max - M) + M.