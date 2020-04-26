%%%------------------------------------
%%% @Module  : mod_npc_tpl
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2013.11.7
%%% @Description: NPC模板
%%%------------------------------------
-module(mod_npc_tpl).

-export([
        get_tpl_data/1,
        is_tpl_exists/1,
        get_no/1,
        get_name/1,
        get_func_list/1,
        is_cruise_activity_npc/1
    ]).


-include("common.hrl").
-include("npc.hrl").



%% 获取模板数据
%% @para: NpcNo => npc编号
%% @return：null | npc_tpl结构体
get_tpl_data(NpcNo) ->
    data_npc:get(NpcNo).




%% npc模板是否存在？(true | false)
is_tpl_exists(NpcNo) ->
    get_tpl_data(NpcNo) /= null.




get_no(NpcTpl) ->
	NpcTpl#npc_tpl.no.
	

get_name(NpcTpl) ->
    NpcTpl#npc_tpl.name.


get_func_list(NpcTpl) ->
    NpcTpl#npc_tpl.func_list.

    



%% 是否巡游活动npc
is_cruise_activity_npc(NpcTpl) ->
	NpcTpl#npc_tpl.type == ?NPC_T_CRUISE_ACTIVITY.

