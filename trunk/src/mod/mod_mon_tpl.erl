%%%------------------------------------
%%% @Module  : mod_mon_tpl
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2013.11.7
%%% @Description: 明雷怪模板
%%%------------------------------------
-module(mod_mon_tpl).


-export([
        get_tpl_data/1,
        is_tpl_exists/1,
        get_name/1,
        get_trigger_battle_condi/1,
        can_concurrent_battle/1,
        get_bmon_group_no_list/1,
		get_existing_time/1
        
	]).

% -include("common.hrl").
-include("monster.hrl").





%% 获取模板数据
%% @para: MonNo => 怪物编号
%% @return: null | mon_tpl结构体
get_tpl_data(MonNo) ->
    data_mon:get(MonNo).



%% 明雷怪模板是否存在？（true | false）
is_tpl_exists(MonNo) ->
    get_tpl_data(MonNo) /= null.



%% 获取名字
get_name(MonTpl) ->
	MonTpl#mon_tpl.name.

%% 获取存在时间 0代表永久
get_existing_time(MonNo) when is_integer(MonNo) ->
	get_existing_time(get_tpl_data(MonNo));

get_existing_time(MonTpl) ->
	MonTpl#mon_tpl.existing_time.
	
	
%% 获取触发战斗的条件列表
get_trigger_battle_condi(MonTpl) ->
	MonTpl#mon_tpl.conditions.


%% 是否可以同时和多个玩家触发战斗？
can_concurrent_battle(MonTpl) ->
	MonTpl#mon_tpl.can_concurrent_battle == 1.



get_bmon_group_no_list(MonTpl) ->
    MonTpl#mon_tpl.bmon_group_no_list.





