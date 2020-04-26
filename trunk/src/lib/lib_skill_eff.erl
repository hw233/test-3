%%%--------------------------------------
%%% @Module  : lib_skill_eff
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2013.9.11
%%% @Description : 主动技能的效果
%%%--------------------------------------
-module(lib_skill_eff).

-export([
            get_cfg_data/1
            

            %%其他 ...
            

             
    ]).


-include("common.hrl").
-include("record.hrl").
-include("effect.hrl").
%%-include("inventory.hrl").
%%-include("ets_name.hrl").



get_cfg_data(EffNo) ->
    data_skill_eff:get(EffNo).





                    