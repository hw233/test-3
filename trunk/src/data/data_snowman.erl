%%%---------------------------------------
%%% @Module  : data_snowman
%%% @Author  : lds
%%% @Email   : 
%%% @Description:  
%%%---------------------------------------


-module(data_snowman).
-include("debug.hrl").
-compile(export_all).

 
get_info(money_no) -> 89001
;
 
get_info(money_num) -> 100
;
 
get_info(item_no) -> 80060
;
 
get_info(max_num) -> 20000
;

get_info(_Arg1) ->
    ?ASSERT(false, [_Arg1]),
    null.



 
get_rate(0) -> 1
;
 
get_rate(500) -> 1.100000
;
 
get_rate(2000) -> 1.200000
;
 
get_rate(5000) -> 1.300000
;
 
get_rate(10000) -> 1.400000
;
 
get_rate(15000) -> 1.500000
;

get_rate(_Arg1) ->
    ?ASSERT(false, [_Arg1]),
    null.

get_num_list()->
	[0,500,2000,5000,10000,15000].

