%%%---------------------------------------
%%% @Module  : data_hardtower_reward2
%%% @Author  : lds
%%% @Email   : 
%%% @Description: 
%%%---------------------------------------


-module(data_hardtower_reward2).
-include("common.hrl").
-include("record.hrl").
-include("tower.hrl").
-compile(export_all).


get(1) -> 
    #tower_config{
        floor = 1
        ,lv = 10            
        ,reward_id = 42000      
        ,battle_power = 8710
    }
		;

get(2) -> 
    #tower_config{
        floor = 2
        ,lv = 10            
        ,reward_id = 42000      
        ,battle_power = 9190
    }
		;

get(3) -> 
    #tower_config{
        floor = 3
        ,lv = 10            
        ,reward_id = 42000      
        ,battle_power = 9670
    }
		;

get(4) -> 
    #tower_config{
        floor = 4
        ,lv = 10            
        ,reward_id = 42000      
        ,battle_power = 10160
    }
		;

get(5) -> 
    #tower_config{
        floor = 5
        ,lv = 10            
        ,reward_id = 42001      
        ,battle_power = 10650
    }
		;

get(_No) ->
  ?ASSERT(false, [_No]),
  null.
		

get_span_money(1) -> 0;
    

get_span_money(2) -> 0;
    

get_span_money(3) -> 0;
    

get_span_money(4) -> 0;
    

get_span_money(5) -> 0;
    

get_span_money(_No) ->
  ?ASSERT(false, [_No]),
  null.
    

get_span_coin(1) -> 0;
    

get_span_coin(2) -> 0;
    

get_span_coin(3) -> 0;
    

get_span_coin(4) -> 0;
    

get_span_coin(5) -> 0;
    

get_span_coin(_No) ->
  ?ASSERT(false, [_No]),
  null.
    

get_span_exp(1) -> 2300;
    

get_span_exp(2) -> 4700;
    

get_span_exp(3) -> 7200;
    

get_span_exp(4) -> 9800;
    

get_span_exp(5) -> 12500;
    

get_span_exp(_No) ->
  ?ASSERT(false, [_No]),
  null.
    

get_span_reward(1) -> [];
    

get_span_reward(2) -> [];
    

get_span_reward(3) -> [];
    

get_span_reward(4) -> [];
    

get_span_reward(5) -> [];
    

get_span_reward(_No) ->
  ?ASSERT(false, [_No]),
  [].
    
