%%%---------------------------------------
%%% @Module  : data_hardtower_reward1
%%% @Author  : lds
%%% @Email   : 
%%% @Description: 
%%%---------------------------------------


-module(data_hardtower_reward1).
-include("common.hrl").
-include("record.hrl").
-include("tower.hrl").
-compile(export_all).


get(1) -> 
    #tower_config{
        floor = 1
        ,lv = 60            
        ,reward_id = 42054      
        ,battle_power = 0
    }
		;

get(2) -> 
    #tower_config{
        floor = 2
        ,lv = 60            
        ,reward_id = 42055      
        ,battle_power = 0
    }
		;

get(3) -> 
    #tower_config{
        floor = 3
        ,lv = 60            
        ,reward_id = 42056      
        ,battle_power = 0
    }
		;

get(4) -> 
    #tower_config{
        floor = 4
        ,lv = 60            
        ,reward_id = 42057      
        ,battle_power = 0
    }
		;

get(5) -> 
    #tower_config{
        floor = 5
        ,lv = 60            
        ,reward_id = 42058      
        ,battle_power = 0
    }
		;

get(6) -> 
    #tower_config{
        floor = 6
        ,lv = 60            
        ,reward_id = 42059      
        ,battle_power = 0
    }
		;

get(7) -> 
    #tower_config{
        floor = 7
        ,lv = 60            
        ,reward_id = 42060      
        ,battle_power = 0
    }
		;

get(8) -> 
    #tower_config{
        floor = 8
        ,lv = 60            
        ,reward_id = 42061      
        ,battle_power = 0
    }
		;

get(9) -> 
    #tower_config{
        floor = 9
        ,lv = 60            
        ,reward_id = 42062      
        ,battle_power = 0
    }
		;

get(10) -> 
    #tower_config{
        floor = 10
        ,lv = 60            
        ,reward_id = 42063      
        ,battle_power = 0
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
    

get_span_money(6) -> 0;
    

get_span_money(7) -> 0;
    

get_span_money(8) -> 0;
    

get_span_money(9) -> 0;
    

get_span_money(10) -> 0;
    

get_span_money(_No) ->
  ?ASSERT(false, [_No]),
  null.
    

get_span_coin(1) -> 0;
    

get_span_coin(2) -> 0;
    

get_span_coin(3) -> 0;
    

get_span_coin(4) -> 0;
    

get_span_coin(5) -> 0;
    

get_span_coin(6) -> 0;
    

get_span_coin(7) -> 0;
    

get_span_coin(8) -> 0;
    

get_span_coin(9) -> 0;
    

get_span_coin(10) -> 0;
    

get_span_coin(_No) ->
  ?ASSERT(false, [_No]),
  null.
    

get_span_exp(1) -> 0;
    

get_span_exp(2) -> 0;
    

get_span_exp(3) -> 0;
    

get_span_exp(4) -> 0;
    

get_span_exp(5) -> 0;
    

get_span_exp(6) -> 0;
    

get_span_exp(7) -> 0;
    

get_span_exp(8) -> 0;
    

get_span_exp(9) -> 0;
    

get_span_exp(10) -> 0;
    

get_span_exp(_No) ->
  ?ASSERT(false, [_No]),
  null.
    

get_span_reward(1) -> [];
    

get_span_reward(2) -> [];
    

get_span_reward(3) -> [];
    

get_span_reward(4) -> [];
    

get_span_reward(5) -> [];
    

get_span_reward(6) -> [];
    

get_span_reward(7) -> [];
    

get_span_reward(8) -> [];
    

get_span_reward(9) -> [];
    

get_span_reward(10) -> [];
    

get_span_reward(_No) ->
  ?ASSERT(false, [_No]),
  [].
    
