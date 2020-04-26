%%%---------------------------------------
%%% @Module  : data_couple_cruise_event
%%% @Author  : huangjf
%%% @Email   : 
%%% @Description: 花车游长安触发事件配置表
%%%---------------------------------------


-module(data_couple_cruise_event).
-export([get/1]).
-include("relation.hrl").
-include("debug.hrl").

get({165, 135}) ->
	#couple_cru_event{
		pos = {165, 135},
		events = [{spawn, 1304,[3101,3102,3103]},{stay,15},{fireworks},{broadcast,357}]
};

get({230, 85}) ->
	#couple_cru_event{
		pos = {230, 85},
		events = [{fireworks}]
};

get({215, 35}) ->
	#couple_cru_event{
		pos = {215, 35},
		events = [{fireworks}]
};

get({105, 35}) ->
	#couple_cru_event{
		pos = {105, 35},
		events = [{fireworks}]
};

get({183, 95}) ->
	#couple_cru_event{
		pos = {183, 95},
		events = [{fireworks}]
};

get({75, 40}) ->
	#couple_cru_event{
		pos = {75, 40},
		events = [{broadcast,357}]
};

get({105, 90}) ->
	#couple_cru_event{
		pos = {105, 90},
		events = [{fireworks}]
};

get({135, 125}) ->
	#couple_cru_event{
		pos = {135, 125},
		events = [{fireworks}]
};

get(_Pos) ->
          null.

