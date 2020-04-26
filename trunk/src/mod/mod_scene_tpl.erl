%%%------------------------------------
%%% @Module  : mod_scene_tpl
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2013.11.7
%%% @Description: 场景模板
%%%------------------------------------
-module(mod_scene_tpl).

-export([
        get_tpl_data/1,
        is_tpl_exists/1,

        is_normal_scene/1,
        is_city_scene/1,
        is_melee_scene/1,
        is_newyear_banquat_scene/1,
        get_scene_type/1,          %% 获取场景类型
        get_cfg_static_npc_list/1,
        get_cfg_static_mon_list/1,

        get_spawn_mon_area_list/1,
        get_dig_treasure_area/1,

        get_trap_list/1,


        is_xy_valid/3,
        is_trap_area/3

        ]).


% -include("common.hrl").
-include("scene.hrl").
-include("debug.hrl").




%% 获取场景模板的数据（依据场景编号）
%% @return: null | scene_tpl结构体
get_tpl_data(SceneNo) ->
    data_scene:get(SceneNo).


%% 场景模板是否存在？
is_tpl_exists(SceneNo) ->
    get_tpl_data(SceneNo) /= null.


%% 是否为普通场景？    
is_normal_scene(SceneTpl) ->
    lists:member(SceneTpl#scene_tpl.type, ?NORMAL_SCENE_TYPE_LIST).


%% 是否为城市场景？
is_city_scene(SceneTpl) ->
    SceneTpl#scene_tpl.type == ?SCENE_T_CITY.

%% 是否为女妖乱斗活动的场景？
is_melee_scene(SceneTpl) ->
    SceneTpl#scene_tpl.type == ?SCENE_T_MELEE.

is_newyear_banquat_scene(SceneTpl) ->
    SceneTpl#scene_tpl.type == ?SCENE_T_NEWYEAR.

%% 是否帮派地图 与 帮派副本不同
get_scene_type(SceneNo) when is_integer(SceneNo) ->
    (get_tpl_data(SceneNo))#scene_tpl.type;
get_scene_type(SceneTpl) ->
    SceneTpl#scene_tpl.type.

%% 获取场景模板所配置的静态npc编号列表
get_cfg_static_npc_list(SceneTpl) ->
    SceneTpl#scene_tpl.npcs.

%% 获取场景模板所配置的明雷怪编号列表
get_cfg_static_mon_list(SceneTpl) ->
    SceneTpl#scene_tpl.mons.


%% 获取场景的刷怪区域列表
get_spawn_mon_area_list(SceneTpl) ->
    SceneTpl#scene_tpl.spawn_mon_area_list.


get_dig_treasure_area(SceneTpl) ->
    SceneTpl#scene_tpl.dig_treasure_area.


get_trap_list(SceneTpl) ->
    SceneNo = SceneTpl#scene_tpl.no,
    data_scene_trap:get(SceneNo).




is_xy_valid(SceneTpl, X, Y) ->
    (X >= ?X_START)
    andalso (X < SceneTpl#scene_tpl.width)
    andalso (Y >= ?Y_START)
    andalso (Y < SceneTpl#scene_tpl.height).

    

%% 判断场景的某位置是否为暗雷区
is_trap_area(SceneTpl, X, Y) ->
    case is_xy_valid(SceneTpl, X, Y) of
        false ->
            ?ASSERT(false, {X, Y, SceneTpl}),
            false;
        true ->
            Index = lib_scene:to_server_xy_index(SceneTpl, X, Y),
            Mask = data_mask:get(SceneTpl#scene_tpl.no),
            BlockType = erlang:element(Index, Mask),
            BlockType == ?BLOCK_T_TRAP
    end.


