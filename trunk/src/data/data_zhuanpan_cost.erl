%%%---------------------------------------
%%% @Module  : data_zhuanpan_cost
%%% @Author  : lds
%%% @Email   : 
%%% @Description:  幸运转盘消耗
%%%---------------------------------------


-module(data_zhuanpan_cost).
-include("debug.hrl").
-compile(export_all).

 
get(0) -> 1
;
 
get(1) -> 1
;
 
get(2) -> 3
;
 
get(3) -> 7
;
 
get(4) -> 13
;
 
get(5) -> 22
;
 
get(6) -> 34
;
 
get(7) -> 50
;
 
get(8) -> 70
;
 
get(9) -> 95
;

get(_Arg1) ->
    ?ASSERT(false, [_Arg1]),
    null.

