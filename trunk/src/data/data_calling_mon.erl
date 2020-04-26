%%%-------------------------------------- 
%%% @Module: data_calling_mon
%%% @Author: lxl
%%% @Created: 2012-09-24  16:52:42
%%% @Description: 
%%%-------------------------------------- 
-module(data_calling_mon).

%% 
%% Including Files
%%

%%
%% Exports
%%

-export([
             get/1
         ]).
         

get(1)->
	[4200, 0, 0, 0, 0];
get(_)->[].
