%%%-------------------------------------- 
%%% @Module: data_week_level_mon
%%% @Author: 
%%% @Created: 2012-09-15  12:23:42
%%% @Description: 
%%%-------------------------------------- 

-module(data_week_level_mon).

-export([get/1]).

get(101) -> [109, 110, 111, 112, 113, 114, 115];
get(_) -> [].
