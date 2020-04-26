%%%---------------------------------------
%%% @Module  : data_answer
%%% @Author  : lds
%%% @Email   : 
%%% @Description:  答题
%%%---------------------------------------


-module(data_recharge).
-include("common.hrl").
-include("player.hrl").
-compile(export_all).

 
get_data_by_money(10) -> 
    #recharge{
       no = 1
    	,money = 10
		,yuanbao= 1000
        ,type = 1
        ,show_days = 0
		,mabey_mon = 0
    	,normal_feekback_num = 1000
    	,normal_feekback_type = 3
    	,is_first = 1
    	,first_feekback_num = [{89001,10000}]
    	,first_feekback_day = 0
    	,first_feekback_type = 0
    }
;
 
get_data_by_money(30) -> 
    #recharge{
       no = 2
    	,money = 30
		,yuanbao= 3000
        ,type = 1
        ,show_days = 0
		,mabey_mon = 0
    	,normal_feekback_num = 3000
    	,normal_feekback_type = 3
    	,is_first = 1
    	,first_feekback_num = [{89001,30000}]
    	,first_feekback_day = 0
    	,first_feekback_type = 0
    }
;
 
get_data_by_money(98) -> 
    #recharge{
       no = 3
    	,money = 98
		,yuanbao= 9800
        ,type = 1
        ,show_days = 0
		,mabey_mon = 0
    	,normal_feekback_num = 9800
    	,normal_feekback_type = 3
    	,is_first = 1
    	,first_feekback_num = [{89001,98000}]
    	,first_feekback_day = 0
    	,first_feekback_type = 0
    }
;
 
get_data_by_money(198) -> 
    #recharge{
       no = 4
    	,money = 198
		,yuanbao= 19800
        ,type = 1
        ,show_days = 0
		,mabey_mon = 0
    	,normal_feekback_num = 19800
    	,normal_feekback_type = 3
    	,is_first = 1
    	,first_feekback_num = [{89001,198000}]
    	,first_feekback_day = 0
    	,first_feekback_type = 0
    }
;
 
get_data_by_money(328) -> 
    #recharge{
       no = 5
    	,money = 328
		,yuanbao= 32800
        ,type = 1
        ,show_days = 0
		,mabey_mon = 0
    	,normal_feekback_num = 32800
    	,normal_feekback_type = 3
    	,is_first = 1
    	,first_feekback_num = [{89001,328000}]
    	,first_feekback_day = 0
    	,first_feekback_type = 0
    }
;
 
get_data_by_money(500) -> 
    #recharge{
       no = 6
    	,money = 500
		,yuanbao= 50000
        ,type = 1
        ,show_days = 0
		,mabey_mon = 0
    	,normal_feekback_num = 50000
    	,normal_feekback_type = 3
    	,is_first = 1
    	,first_feekback_num = [{89001,500000}]
    	,first_feekback_day = 0
    	,first_feekback_type = 0
    }
;
 
get_data_by_money(1000) -> 
    #recharge{
       no = 7
    	,money = 1000
		,yuanbao= 100000
        ,type = 1
        ,show_days = 0
		,mabey_mon = 0
    	,normal_feekback_num = 100000
    	,normal_feekback_type = 3
    	,is_first = 1
    	,first_feekback_num = [{89001,1000000}]
    	,first_feekback_day = 0
    	,first_feekback_type = 0
    }
;
 
get_data_by_money(2000) -> 
    #recharge{
       no = 8
    	,money = 2000
		,yuanbao= 200000
        ,type = 1
        ,show_days = 0
		,mabey_mon = 0
    	,normal_feekback_num = 200000
    	,normal_feekback_type = 3
    	,is_first = 1
    	,first_feekback_num = [{89001,2000000}]
    	,first_feekback_day = 0
    	,first_feekback_type = 0
    }
;
 
get_data_by_money(5000) -> 
    #recharge{
       no = 9
    	,money = 5000
		,yuanbao= 500000
        ,type = 1
        ,show_days = 0
		,mabey_mon = 0
    	,normal_feekback_num = 0
    	,normal_feekback_type = 3
    	,is_first = 1
    	,first_feekback_num = [{89001,5000000}]
    	,first_feekback_day = 0
    	,first_feekback_type = 0
    }
;
 
get_data_by_money(9999) -> 
    #recharge{
       no = 10
    	,money = 9999
		,yuanbao= 999900
        ,type = 1
        ,show_days = 0
		,mabey_mon = 0
    	,normal_feekback_num = 0
    	,normal_feekback_type = 3
    	,is_first = 1
    	,first_feekback_num = [{89001,9999000}]
    	,first_feekback_day = 0
    	,first_feekback_type = 0
    }
;

get_data_by_money(_Arg) ->
    null.

 
get_data_by_no(1) -> 
    #recharge{
       no = 1
    	,money = 10
		,yuanbao = 1000
        ,type = 1
        ,show_days = 0
		,mabey_mon = 0
    	,normal_feekback_num = 1000
    	,normal_feekback_type = 3
    	,is_first = 1
    	,first_feekback_num = [{89001,10000}]
    	,first_feekback_day = 0
    	,first_feekback_type = 0
    }
;
 
get_data_by_no(2) -> 
    #recharge{
       no = 2
    	,money = 30
		,yuanbao = 3000
        ,type = 1
        ,show_days = 0
		,mabey_mon = 0
    	,normal_feekback_num = 3000
    	,normal_feekback_type = 3
    	,is_first = 1
    	,first_feekback_num = [{89001,30000}]
    	,first_feekback_day = 0
    	,first_feekback_type = 0
    }
;
 
get_data_by_no(3) -> 
    #recharge{
       no = 3
    	,money = 98
		,yuanbao = 9800
        ,type = 1
        ,show_days = 0
		,mabey_mon = 0
    	,normal_feekback_num = 9800
    	,normal_feekback_type = 3
    	,is_first = 1
    	,first_feekback_num = [{89001,98000}]
    	,first_feekback_day = 0
    	,first_feekback_type = 0
    }
;
 
get_data_by_no(4) -> 
    #recharge{
       no = 4
    	,money = 198
		,yuanbao = 19800
        ,type = 1
        ,show_days = 0
		,mabey_mon = 0
    	,normal_feekback_num = 19800
    	,normal_feekback_type = 3
    	,is_first = 1
    	,first_feekback_num = [{89001,198000}]
    	,first_feekback_day = 0
    	,first_feekback_type = 0
    }
;
 
get_data_by_no(5) -> 
    #recharge{
       no = 5
    	,money = 328
		,yuanbao = 32800
        ,type = 1
        ,show_days = 0
		,mabey_mon = 0
    	,normal_feekback_num = 32800
    	,normal_feekback_type = 3
    	,is_first = 1
    	,first_feekback_num = [{89001,328000}]
    	,first_feekback_day = 0
    	,first_feekback_type = 0
    }
;
 
get_data_by_no(6) -> 
    #recharge{
       no = 6
    	,money = 500
		,yuanbao = 50000
        ,type = 1
        ,show_days = 0
		,mabey_mon = 0
    	,normal_feekback_num = 50000
    	,normal_feekback_type = 3
    	,is_first = 1
    	,first_feekback_num = [{89001,500000}]
    	,first_feekback_day = 0
    	,first_feekback_type = 0
    }
;
 
get_data_by_no(7) -> 
    #recharge{
       no = 7
    	,money = 1000
		,yuanbao = 100000
        ,type = 1
        ,show_days = 0
		,mabey_mon = 0
    	,normal_feekback_num = 100000
    	,normal_feekback_type = 3
    	,is_first = 1
    	,first_feekback_num = [{89001,1000000}]
    	,first_feekback_day = 0
    	,first_feekback_type = 0
    }
;
 
get_data_by_no(8) -> 
    #recharge{
       no = 8
    	,money = 2000
		,yuanbao = 200000
        ,type = 1
        ,show_days = 0
		,mabey_mon = 0
    	,normal_feekback_num = 200000
    	,normal_feekback_type = 3
    	,is_first = 1
    	,first_feekback_num = [{89001,2000000}]
    	,first_feekback_day = 0
    	,first_feekback_type = 0
    }
;
 
get_data_by_no(9) -> 
    #recharge{
       no = 9
    	,money = 5000
		,yuanbao = 500000
        ,type = 1
        ,show_days = 0
		,mabey_mon = 0
    	,normal_feekback_num = 0
    	,normal_feekback_type = 3
    	,is_first = 1
    	,first_feekback_num = [{89001,5000000}]
    	,first_feekback_day = 0
    	,first_feekback_type = 0
    }
;
 
get_data_by_no(10) -> 
    #recharge{
       no = 10
    	,money = 9999
		,yuanbao = 999900
        ,type = 1
        ,show_days = 0
		,mabey_mon = 0
    	,normal_feekback_num = 0
    	,normal_feekback_type = 3
    	,is_first = 1
    	,first_feekback_num = [{89001,9999000}]
    	,first_feekback_day = 0
    	,first_feekback_type = 0
    }
;

get_data_by_no(_Arg) ->
    null.

get_nos()->
	[1,2,3,4,5,6,7,8,9,10].

get_normal_card_nos()->
	[1,2,3,4,5,6,7,8,9,10].

get_month_card_nos()->
	[].

get_life_card_nos()->
	[].

get_week_card_nos()->
	[].



 
get_first_recharge_reward() -> 1.


