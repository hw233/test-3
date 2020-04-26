%% Author: Administrator
%% Created: 2012-9-24
%% Description: TODO: Add description to type_cast
-module(tst_type_cast).

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
	tst_prof:run(fun int_to_list/0, 1000000).

int_to_list() ->
	erlang:integer_to_list(123).
%%
%% Local Functions
%%

