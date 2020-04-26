%%%---------------------------------------
%%% @Module  : data_fabao_config
%%% @Author  : lzx
%%% @Email   : 
%%% @Description: 法宝配置表
%%%---------------------------------------


-module(data_fabao_config).
-compile(export_all).
-include("fabao.hrl").
-include("debug.hrl").

get(60001) ->
	#fabao_config{
		no = 60001,
		type = 1,
		sp_value = 200,
		sp_value_cost = 5,
		compose_need = [{120000,200}],
		attr = [act_speed, mp_lim],
		step_need_goods = [120000,120006],
		step_need_num = [{2,200},{3,300},{4,400},{5,500},{6,600}]
};

get(60002) ->
	#fabao_config{
		no = 60002,
		type = 2,
		sp_value = 200,
		sp_value_cost = 5,
		compose_need = [{120001,200}],
		attr = [hp_lim, mp_lim],
		step_need_goods = [120001,120006],
		step_need_num = [{2,200},{3,300},{4,400},{5,500},{6,600}]
};

get(60003) ->
	#fabao_config{
		no = 60003,
		type = 3,
		sp_value = 200,
		sp_value_cost = 5,
		compose_need = [{120002,200}],
		attr = [phy_att, mag_def],
		step_need_goods = [120002,120006],
		step_need_num = [{2,200},{3,300},{4,400},{5,500},{6,600}]
};

get(60004) ->
	#fabao_config{
		no = 60004,
		type = 4,
		sp_value = 200,
		sp_value_cost = 5,
		compose_need = [{120003,200}],
		attr = [hp_lim, phy_def],
		step_need_goods = [120003,120006],
		step_need_num = [{2,200},{3,300},{4,400},{5,500},{6,600}]
};

get(60005) ->
	#fabao_config{
		no = 60005,
		type = 5,
		sp_value = 200,
		sp_value_cost = 5,
		compose_need = [{120004,200}],
		attr = [act_speed, mag_def],
		step_need_goods = [120004,120006],
		step_need_num = [{2,200},{3,300},{4,400},{5,500},{6,600}]
};

get(60006) ->
	#fabao_config{
		no = 60006,
		type = 6,
		sp_value = 200,
		sp_value_cost = 5,
		compose_need = [{120005,200}],
		attr = [mag_att, phy_def],
		step_need_goods = [120005,120006],
		step_need_num = [{2,200},{3,300},{4,400},{5,500},{6,600}]
};

get(_No) ->
	?ASSERT(false, {_No}),
    null.

