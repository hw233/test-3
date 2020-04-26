%%%------------------------------------
%%% @Module  : mod_id_alloc
%%% @Author  : liuzhongzheng2012@gmail.com
%%% @Email   :
%%% @Created : 2014.6.6
%%% @Description: id自动分配器（这里的id和数据库表中的行记录id没有关系，而是用于表示内存中的对象的唯一性，比如队伍的id）
%%%------------------------------------
-module(mod_id_alloc).
-export([
        init/0,

        next_comm_id/0,
        next_npc_id/0,
        next_scene_id/0
        ]).

-include("ets_name.hrl").
-include("npc.hrl").
-include("scene.hrl").
-include("num_limits.hrl").


%% 通用id的起始值
-define(START_COMMON_ID, 1).


init() ->
    ets:new(?ETS_ID_ALLOC, [{keypos, 1}, named_table, public, set]),
    init_id(common),
    init_id(npc),
    init_id(scene).
    


%% 获取下一个通用id（从?START_COMMON_ID开始）
%% @return: 整数值
next_comm_id() ->
    get_next_id(common).

%% 获取下一个npc id（从?DYNAMIC_NPC_START_ID开始）
%% @return: 整数值
next_npc_id() ->
    get_next_id(npc).

%% 获取下一个场景id（从?COPY_SCENE_START_ID开始）
%% @return: 整数值
next_scene_id() ->
    get_next_id(scene).





%% ===============================================================================

init_id(common) ->
    init_id(common, ?START_COMMON_ID - 1);
init_id(npc) ->
    init_id(npc, ?DYNAMIC_NPC_START_ID - 1);
init_id(scene) ->
    init_id(scene, ?COPY_SCENE_START_ID - 1).


init_id(Type, InitVal) ->
    ets:insert(?ETS_ID_ALLOC, {Type, InitVal}).


get_next_id(Type) ->
    % 暂时不考虑溢出MAX_U32的情况！
    ets:update_counter(?ETS_ID_ALLOC, Type, 1).
    


     

            
