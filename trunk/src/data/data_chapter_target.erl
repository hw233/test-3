%%%---------------------------------------
%%% @Module  : data_chapter_target
%%% @Author  : lds
%%% @Email   : 
%%% @Description:  章节目标
%%%---------------------------------------


-module(data_chapter_target).
-include("chapter_target.hrl").
-include("common.hrl").
-compile(export_all).

 
get_chapter_info(1) ->
    #chapter_data{
        no = 1
        ,reward_id = 30000
        ,target = [{1,1},{2,1},{3,1},{4,10},{5,1},{6,10},{7,1},{8,1},{9,1},{10,1}]
    }
	      ;
 
get_chapter_info(2) ->
    #chapter_data{
        no = 2
        ,reward_id = 30001
        ,target = [{11,1},{12,1},{13,1},{14,1},{15,1},{16,10},{17,1},{18,1},{19,1},{20,1}]
    }
	      ;
 
get_chapter_info(3) ->
    #chapter_data{
        no = 3
        ,reward_id = 30002
        ,target = [{21,1},{22,1},{23,1},{24,1},{25,1},{26,1},{27,1},{28,10},{29,10},{30,1}]
    }
	      ;
 
get_chapter_info(4) ->
    #chapter_data{
        no = 4
        ,reward_id = 30003
        ,target = [{31,1},{32,1},{33,10},{34,1},{35,1},{36,1},{37,1},{38,1},{39,1},{40,1}]
    }
	      ;
 
get_chapter_info(5) ->
    #chapter_data{
        no = 5
        ,reward_id = 30004
        ,target = [{41,1},{42,1},{43,5},{44,1},{45,1},{46,1},{47,1},{48,10},{49,1},{50,1}]
    }
	      ;
 
get_chapter_info(6) ->
    #chapter_data{
        no = 6
        ,reward_id = 30005
        ,target = [{51,1},{52,1},{53,10},{54,1},{55,1},{56,1},{57,1},{58,1},{59,1},{60,1}]
    }
	      ;
 
get_chapter_info(7) ->
    #chapter_data{
        no = 7
        ,reward_id = 30006
        ,target = [{61,1},{62,1},{63,1},{64,1},{65,1},{66,1},{67,1},{68,1},{69,10},{70,1}]
    }
	      ;

get_chapter_info(_Arg) ->
    ?ASSERT(false, [_Arg]),
    null.
		  
get_nos()->
	[1,2,3,4,5,6,7].

get(1) ->
	#chapter_no{
		no = 1,
		sex = 0,
		lv = 0,
		reward_id = 30000,
		target = [{1,1},{2,1},{3,1},{4,10},{5,1},{6,10},{7,1},{8,1},{9,1},{10,1}],
		buy_pkg = 60305,
		buy_count = 1,
		price_type = 2,
		discount_price = 720,
		discount = 5,
		recharge_pkg = 60306,
		recharge_count = 1,
		recharge_amount = 1,
		recharge_discount = 9
};

get(2) ->
	#chapter_no{
		no = 2,
		sex = 0,
		lv = 0,
		reward_id = 30001,
		target = [{11,1},{12,1},{13,1},{14,1},{15,1},{16,10},{17,1},{18,1},{19,1},{20,1}],
		buy_pkg = 62350,
		buy_count = 1,
		price_type = 2,
		discount_price = 900,
		discount = 5,
		recharge_pkg = 62350,
		recharge_count = 30,
		recharge_amount = 3,
		recharge_discount = 7
};

get(3) ->
	#chapter_no{
		no = 3,
		sex = 0,
		lv = 0,
		reward_id = 30002,
		target = [{21,1},{22,1},{23,1},{24,1},{25,1},{26,1},{27,1},{28,10},{29,10},{30,1}],
		buy_pkg = 62029,
		buy_count = 5,
		price_type = 2,
		discount_price = 1500,
		discount = 5,
		recharge_pkg = 62031,
		recharge_count = 6,
		recharge_amount = 6,
		recharge_discount = 5
};

get(4) ->
	#chapter_no{
		no = 4,
		sex = 0,
		lv = 0,
		reward_id = 30003,
		target = [{31,1},{32,1},{33,10},{34,1},{35,1},{36,1},{37,1},{38,1},{39,1},{40,1}],
		buy_pkg = 60294,
		buy_count = 1,
		price_type = 2,
		discount_price = 2000,
		discount = 5,
		recharge_pkg = 62053,
		recharge_count = 2,
		recharge_amount = 9,
		recharge_discount = 5
};

get(5) ->
	#chapter_no{
		no = 5,
		sex = 0,
		lv = 0,
		reward_id = 30004,
		target = [{41,1},{42,1},{43,5},{44,1},{45,1},{46,1},{47,1},{48,10},{49,1},{50,1}],
		buy_pkg = 60299,
		buy_count = 1,
		price_type = 2,
		discount_price = 2500,
		discount = 5,
		recharge_pkg = 60302,
		recharge_count = 1,
		recharge_amount = 6,
		recharge_discount = 5
};

get(6) ->
	#chapter_no{
		no = 6,
		sex = 0,
		lv = 0,
		reward_id = 30005,
		target = [{51,1},{52,1},{53,10},{54,1},{55,1},{56,1},{57,1},{58,1},{59,1},{60,1}],
		buy_pkg = 60312,
		buy_count = 1,
		price_type = 2,
		discount_price = 20000,
		discount = 5,
		recharge_pkg = 60313,
		recharge_count = 1,
		recharge_amount = 15,
		recharge_discount = 5
};

get(7) ->
	#chapter_no{
		no = 7,
		sex = 0,
		lv = 0,
		reward_id = 30006,
		target = [{61,1},{62,1},{63,1},{64,1},{65,1},{66,1},{67,1},{68,1},{69,10},{70,1}],
		buy_pkg = 62034,
		buy_count = 1,
		price_type = 2,
		discount_price = 1900,
		discount = 5,
		recharge_pkg = 62161,
		recharge_count = 3,
		recharge_amount = 18,
		recharge_discount = 5
};

get(_no) ->
	?ASSERT(false, _no),
    null.

get_recharge_amount()->
	[1,3,6,6,9,15,18].

