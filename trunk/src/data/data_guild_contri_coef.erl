%%%---------------------------------------
%%% @Module  : data_guild_contri_coef
%%% @Author  : zwq
%%% @Email   : 
%%% @Description:  帮派贡献度档次系数
%%%---------------------------------------


-module(data_guild_contri_coef).
-include("record/guild_record.hrl").
-include("debug.hrl").
-compile(export_all).

get_all_step_list()->
	[1,2,3,4,5,6,7,8,9].

get(1) ->
	[
		#guild_contri_coef{
			range = [0,1], 
			coef = 0.500000
			}
	];


get(2) ->
	[
		#guild_contri_coef{
			range = [1,75], 
			coef = 1
			}
	];


get(3) ->
	[
		#guild_contri_coef{
			range = [76,175], 
			coef = 1.100000
			}
	];


get(4) ->
	[
		#guild_contri_coef{
			range = [176,350], 
			coef = 1.300000
			}
	];


get(5) ->
	[
		#guild_contri_coef{
			range = [351,750], 
			coef = 1.600000
			}
	];


get(6) ->
	[
		#guild_contri_coef{
			range = [751,1500], 
			coef = 2
			}
	];


get(7) ->
	[
		#guild_contri_coef{
			range = [1501,2250], 
			coef = 2.500000
			}
	];


get(8) ->
	[
		#guild_contri_coef{
			range = [2251,4500], 
			coef = 3.100000
			}
	];


get(9) ->
	[
		#guild_contri_coef{
			range = [4501,max], 
			coef = 3.800000
			}
	];


get(_No) ->
	?ASSERT(false, _No),
	null.

