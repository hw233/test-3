%%%---------------------------------------
%%% @Module  : data_guild_sys_cfg
%%% @Author  : zhangwq
%%% @Email   : 
%%% @Description: 山寨
%%%---------------------------------------


-module(data_guild_sys_cfg).
-export([
        get/1
    ]).

-include("record/guild_record.hrl").
-include("debug.hrl").

get(guild_war) ->
	#guild_sys_cfg{
		p_name = guild_war,
		init_phy_power = 100,
		att_phy_power = 10,
		fail_phy_power = 20,
		atted_succ_phy_power = 5,
		pre_war_time = 1200,
		war_time = 2400
};

get(_Pname) ->
  ?ASSERT(false, _Pname),
    null.

