%% Author: Administrator
%% Created: 2012-3-13
%% Description: TODO: Add description to io_lib_format
%% lists:concat约62ms，io_lib:format约360ms，lists:concat比io_lib:format快
-module(tst_io_lib_format_test).

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
	F1 = fun(I) ->
				 lists:concat(["Test io_lib perf: ", I])
		 end,
	
	F2 = fun(I) ->
				 io_lib:format(<<"Test io_lib perf: ~p">>, [I])
		 end,
	
	tst_prof:run_index(F1, 100000),
	tst_prof:run_index(F2, 100000).


%%
%% Local Functions
%%

