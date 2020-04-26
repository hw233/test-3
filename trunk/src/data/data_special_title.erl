%%%---------------------------------------
%%% @Module  : data_special_title
%%% @Author  : lzx
%%% @Email   : 
%%% @Description: 定制称号配置表
%%%---------------------------------------


-module(data_special_title).
-compile(export_all).

-include("title.hrl").
-include("debug.hrl").

get(1) ->
	#special_title{
		id = 1,
		optional_attr_add = [{be_phy_dam_reduce_coef,0.02,0},
{be_mag_dam_reduce_coef, 0.02, 0},
{seal_resis,0,0.08},
{do_phy_dam_scaling,0.02,0},
{do_mag_dam_scaling, 0.02, 0},
{seal_resis,0,0.12},{hp_lim,94090,0},
{act_speed,3764,0},
{phy_crit,70,0},
{mag_crit,70,0},
{hp_lim,282270,0},
{act_speed,11291,0},
{do_phy_dam_scaling,0.0828,0},
{do_mag_dam_scaling,0.0828,0}],
		cost1 = {55100,1},
		cost2 = {55109,1},
		custom_select = 6
};

get(_No) ->
	?ASSERT(false, {_No}),
    null.

