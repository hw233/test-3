%%%---------------------------------------
%%% @Module  : data_vip
%%% @Author  : liuzz
%%% @Email   :
%%% @Description: VIP配置数据
%%%---------------------------------------


-module(data_vip).
-export([get/1]).
-include("player.hrl").
-include("debug.hrl").

get(1) ->
	#vip_cfg{
		lv = 1,
		exp = 1000
};

get(2) ->
	#vip_cfg{
		lv = 2,
		exp = 6000
};

get(3) ->
	#vip_cfg{
		lv = 3,
		exp = 120000
};

get(4) ->
	#vip_cfg{
		lv = 4,
		exp = 500000
};

get(5) ->
	#vip_cfg{
		lv = 5,
		exp = 2000000
};

get(6) ->
	#vip_cfg{
		lv = 6,
		exp = 999999999
};

get(_VipLv) ->
          null.

