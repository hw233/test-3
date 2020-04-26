%%%---------------------------------------
%%% @Module  : data_five_elements_level
%%% @Author  : 海狸喵
%%% @Email   : 
%%% @Description:  五行等级配置表
%%%---------------------------------------


-module(data_five_elements_level).

-include("five_elements.hrl").
-include("debug.hrl").
-compile(export_all).


get(1,1) -> 
	#five_elements_level{
		effect = five_elements_1,
		effect_num = 0.100000,
		expend = [{62591,100}]
	}
	
;

get(1,2) -> 
	#five_elements_level{
		effect = five_elements_1,
		effect_num = 0.150000,
		expend = [{62591,200},{62597,100}]
	}
	
;

get(1,3) -> 
	#five_elements_level{
		effect = crit_rate,
		effect_num = 30,
		expend = [{62591,300},{62597,200}]
	}
	
;

get(1,4) -> 
	#five_elements_level{
		effect = crit_rate,
		effect_num = 50,
		expend = [{62591,400},{62597,300}]
	}
	
;

get(1,5) -> 
	#five_elements_level{
		effect = crit_coef,
		effect_num = 100,
		expend = []
	}
	
;

get(2,1) -> 
	#five_elements_level{
		effect = five_elements_2,
		effect_num = 0.100000,
		expend = [{62592,100}]
	}
	
;

get(2,2) -> 
	#five_elements_level{
		effect = five_elements_2,
		effect_num = 0.150000,
		expend = [{62592,200},{62598,100}]
	}
	
;

get(2,3) -> 
	#five_elements_level{
		effect = hp_lim_rate,
		effect_num = 0.100000,
		expend = [{62592,300},{62598,200}]
	}
	
;

get(2,4) -> 
	#five_elements_level{
		effect = hp_lim_rate,
		effect_num = 0.150000,
		expend = [{62592,400},{62598,300}]
	}
	
;

get(2,5) -> 
	#five_elements_level{
		effect = be_dam_reduce_coef,
		effect_num = 0.050000,
		expend = []
	}
	
;

get(3,1) -> 
	#five_elements_level{
		effect = five_elements_3,
		effect_num = 0.100000,
		expend = [{62593,100}]
	}
	
;

get(3,2) -> 
	#five_elements_level{
		effect = five_elements_3,
		effect_num = 0.150000,
		expend = [{62593,200},{62599,100}]
	}
	
;

get(3,3) -> 
	#five_elements_level{
		effect = heal_value,
		effect_num = 0.050000,
		expend = [{62593,300},{62599,200}]
	}
	
;

get(3,4) -> 
	#five_elements_level{
		effect = heal_value,
		effect_num = 0.100000,
		expend = [{62593,400},{62599,300}]
	}
	
;

get(3,5) -> 
	#five_elements_level{
		effect = be_heal_eff_coef,
		effect_num = 0.100000,
		expend = []
	}
	
;

get(4,1) -> 
	#five_elements_level{
		effect = five_elements_4,
		effect_num = 0.100000,
		expend = [{62594,100}]
	}
	
;

get(4,2) -> 
	#five_elements_level{
		effect = five_elements_4,
		effect_num = 0.150000,
		expend = [{62594,200},{62600,100}]
	}
	
;

get(4,3) -> 
	#five_elements_level{
		effect = mag_att_rate,
		effect_num = 0.050000,
		expend = [{62594,300},{62600,200}]
	}
	
;

get(4,4) -> 
	#five_elements_level{
		effect = mag_att_rate,
		effect_num = 0.100000,
		expend = [{62594,400},{62600,300}]
	}
	
;

get(4,5) -> 
	#five_elements_level{
		effect = do_mag_dam_scaling,
		effect_num = 0.050000,
		expend = []
	}
	
;

get(5,1) -> 
	#five_elements_level{
		effect = five_elements_5,
		effect_num = 0.100000,
		expend = [{62595,100}]
	}
	
;

get(5,2) -> 
	#five_elements_level{
		effect = five_elements_5,
		effect_num = 0.150000,
		expend = [{62595,200},{62601,100}]
	}
	
;

get(5,3) -> 
	#five_elements_level{
		effect = phy_att_rate,
		effect_num = 0.050000,
		expend = [{62595,300},{62601,200}]
	}
	
;

get(5,4) -> 
	#five_elements_level{
		effect = phy_att_rate,
		effect_num = 0.100000,
		expend = [{62595,400},{62601,300}]
	}
	
;

get(5,5) -> 
	#five_elements_level{
		effect = do_phy_dam_scaling,
		effect_num = 0.050000,
		expend = []
	}
	
;

get(6,1) -> 
	#five_elements_level{
		effect = five_elements_6,
		effect_num = 0.100000,
		expend = [{62596,100}]
	}
	
;

get(6,2) -> 
	#five_elements_level{
		effect = five_elements_6,
		effect_num = 0.150000,
		expend = [{62596,200},{62602,100}]
	}
	
;

get(6,3) -> 
	#five_elements_level{
		effect = act_speed_rate,
		effect_num = 0.020000,
		expend = [{62596,300},{62602,200}]
	}
	
;

get(6,4) -> 
	#five_elements_level{
		effect = act_speed_rate,
		effect_num = 0.030000,
		expend = [{62596,400},{62602,300}]
	}
	
;

get(6,5) -> 
	#five_elements_level{
		effect = violent,
		effect_num = [{80,10},{50,15},{20,20}],
		expend = []
	}
	
;

get(_Arg1, _Arg2) ->
    ?ASSERT(false, [_Arg1, _Arg2]), null.

