%%%-----------------------------------
%%% @Module  : lib_buff_tpl
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2013.8.18
%%% @Description: buff模板(buff template)
%%%-----------------------------------
-module(lib_buff_tpl).
-export([
    	get_tpl_data/1,
        is_exists/1,
    	get_no/1,
        get_name/1,
        get_category/1,
        get_replacement_rule/1,
        get_icon/1,
        get_priority/1,
        get_eff_type/1,
        get_max_overlap/1,
        get_lasting_time/1,
        get_handle_freq/1,

        get_base_lasting_round/1,
        get_calc_lasting_round_mode/1,
        get_para/1,

        get_xinfa_coef/1,
        get_rate_coef/1,
        get_fix_value/1,
        get_attr_rate/1,
        get_caster_attr_type/1,
        get_receptor_attr_type/1,
        get_op_mode/1,
        get_upper_limit_coef/1,

        get_expire_events/1,

        is_good/1,
        is_bad/1,
        is_neutral/1,
        is_removed_after_died/1,

        is_be_protect_buff/1
    ]).

-include("buff.hrl").




%% 获取模板数据
%% @para: BuffNo => buff编号
%% @return: null | buff_tpl结构体
get_tpl_data(BuffNo) ->
	data_buff:get(BuffNo).


is_exists(BuffNo) ->
    get_tpl_data(BuffNo) /= null.

get_no(BuffTpl) -> BuffTpl#buff_tpl.no.

get_name(BuffTpl) -> BuffTpl#buff_tpl.name.

get_category(BuffTpl) -> BuffTpl#buff_tpl.category.

get_replacement_rule(BuffTpl) -> BuffTpl#buff_tpl.replacement_rule.

get_icon(BuffTpl) -> BuffTpl#buff_tpl.icon.

get_priority(BuffTpl) -> BuffTpl#buff_tpl.priority.

get_eff_type(BuffTpl) -> BuffTpl#buff_tpl.eff_type.

get_max_overlap(BuffTpl) -> BuffTpl#buff_tpl.max_overlap.

get_lasting_time(BuffTpl) -> BuffTpl#buff_tpl.lasting_time.

get_handle_freq(BuffTpl) -> BuffTpl#buff_tpl.handle_freq.

get_base_lasting_round(BuffTpl) -> BuffTpl#buff_tpl.base_lasting_round.

get_calc_lasting_round_mode(BuffTpl) -> BuffTpl#buff_tpl.calc_lasting_round_mode.

get_para(BuffTpl) -> BuffTpl#buff_tpl.para.

get_xinfa_coef(BuffTpl) -> BuffTpl#buff_tpl.xinfa_coef.
get_rate_coef(BuffTpl) -> BuffTpl#buff_tpl.rate_coef.
get_fix_value(BuffTpl) -> BuffTpl#buff_tpl.fix_value.
get_attr_rate(BuffTpl) -> BuffTpl#buff_tpl.attr_rate.
get_caster_attr_type(BuffTpl) -> BuffTpl#buff_tpl.caster_attr_type.
get_receptor_attr_type(BuffTpl) -> BuffTpl#buff_tpl.receptor_attr_type.

get_op_mode(BuffTpl) -> BuffTpl#buff_tpl.op_mode.
get_upper_limit_coef(BuffTpl) -> BuffTpl#buff_tpl.upper_limit_coef.

get_expire_events(BuffTpl) -> BuffTpl#buff_tpl.expire_events.


%% 是否增益buff
is_good(BuffTpl) ->
    get_eff_type(BuffTpl) == good.

%% 是否减益buff
is_bad(BuffTpl) ->
    get_eff_type(BuffTpl) == bad.

%% 是否中性buff
is_neutral(BuffTpl) ->
    get_eff_type(BuffTpl) == neutral.


%% 是否死亡后移除
is_removed_after_died(BuffTpl) ->
    BuffTpl#buff_tpl.is_removed_after_died == 1.


%% 是否受保护buff
is_be_protect_buff(BuffTpl) ->
    BuffTpl#buff_tpl.name == ?BFN_BE_PROTECT.
    