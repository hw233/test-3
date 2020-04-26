%%%------------------------------------
%%% @Module  : mod_xinfa
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2013.11.14
%%% @Description: 心法类（心法配置数据）
%%%------------------------------------

-module(mod_xinfa).
-export([
		get_cfg_data/1,
		is_valid_xinfa_id/1,
		is_master/1,
		is_slave/1,

		get_faction/1,
		get_unlock_lv/1,

		get_skill1/1,
		get_skill2/1,
		get_skill3/1,

		get_skill1_unlock_lv/1,
		get_skill2_unlock_lv/1,
		get_skill3_unlock_lv/1,

		get_related_skill_list/1,

		get_add_attrs_name_list/1,

		get_std_value/2
    ]).

-include("common.hrl").
-include("xinfa.hrl").
-include("attribute.hrl").
-include("faction.hrl").



%% 获取心法的配置数据
%% @return: null | xinfa结构体
get_cfg_data(XfId) ->
	data_xinfa:get(XfId).


is_valid_xinfa_id(XfId) ->
	get_cfg_data(XfId) /= null.



%% 是否为主心法？
is_master(XfId) when is_integer(XfId) ->
	XfCfg = get_cfg_data(XfId),
	XfCfg#xinfa.is_master == 1;
is_master(XfCfg) when is_record(XfCfg, xinfa) ->
	XfCfg#xinfa.is_master == 1.




%% 是否为从属心法？
is_slave(XfId) when is_integer(XfId) ->
	not is_master(XfId);
is_slave(XfCfg) when is_record(XfCfg, xinfa) ->
	not is_master(XfCfg).



get_faction(XfCfg) ->
	XfCfg#xinfa.faction.


get_unlock_lv(XfCfg) ->
	XfCfg#xinfa.unlock_lv.



% get_upg_cost_money_type(XfCfg) ->
% 	XfCfg#xinfa.upg_cost_money_type.


% get_upg_cost_money(XfCfg) ->
% 	XfCfg#xinfa.upg_cost_money.



% get_upg_cost_exp(XfCfg) ->
% 	XfCfg#xinfa.upg_cost_exp.


get_skill1(XfCfg) ->
	XfCfg#xinfa.skill1.

get_skill2(XfCfg) ->
	XfCfg#xinfa.skill2.

get_skill3(XfCfg) ->
	XfCfg#xinfa.skill3.


get_skill1_unlock_lv(XfCfg) ->
	XfCfg#xinfa.skill1_unlock_lv.

get_skill2_unlock_lv(XfCfg) ->
	XfCfg#xinfa.skill2_unlock_lv.

get_skill3_unlock_lv(XfCfg) ->
	XfCfg#xinfa.skill3_unlock_lv.


%% 所关联的技能id列表
get_related_skill_list(XfCfg) ->
	L = [get_skill1(XfCfg), get_skill2(XfCfg), get_skill3(XfCfg)],
	[X || X <- L, X /= ?INVALID_ID].



get_add_attrs_name_list(XfCfg) ->
	XfCfg#xinfa.add_attrs.



%% 获取标准数值（用于参与各种公式的计算）
get_std_value(XinfaLv, AttrType) -> 1;    %% 废弃心法的公式影响（2019.11.12）zhengjy
get_std_value(XinfaLv, AttrType) ->
	?ASSERT(XinfaLv > 0, {XinfaLv, AttrType}),

	case XinfaLv of
		0 ->   % 容错
			?ERROR_MSG("[mod_xinfa] get_std_value() error!!!! XinfaLv is 0! AttrType=~p, stacktrace=~w", [AttrType, erlang:get_stacktrace()]),
			0;
		_ ->
			R = data_xinfa_std_value:get(XinfaLv),
			?ASSERT(R /= null, XinfaLv),
			case AttrType of
				?ATTR_HP ->
					R#xinfa_std_val.hp;
				?ATTR_MP ->
					R#xinfa_std_val.mp;

				?ATTR_PHY_ATT ->
					R#xinfa_std_val.phy_att;
				?ATTR_MAG_ATT ->
					R#xinfa_std_val.mag_att;
				?ATTR_PHY_DEF ->
					R#xinfa_std_val.phy_def;
				?ATTR_MAG_DEF ->
					R#xinfa_std_val.mag_def;

				?ATTR_HIT ->
					R#xinfa_std_val.hit;
				?ATTR_DODGE ->
					R#xinfa_std_val.dodge;

				?ATTR_CRIT ->
					R#xinfa_std_val.crit;
				?ATTR_TEN ->
					R#xinfa_std_val.ten;

				?ATTR_ACT_SPEED ->
					R#xinfa_std_val.act_speed;

				?ATTR_SEAL_HIT ->
					R#xinfa_std_val.seal_hit;
				?ATTR_SEAL_RESIS ->
					R#xinfa_std_val.seal_resis;

				_ -> % 容错
					?ERROR_MSG("[mod_xinfa] get_std_value() error!! AttrType=~p", [AttrType]),
					?ASSERT(false, AttrType),
					0	
			end
	end.

			



