%%%--------------------------------------
%%% @Module  : lib_aoi
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2014.4.10
%%% @Description : aoi相关的函数，注意：此模块的函数都只用于go进程（对应mod_go模块）！

%%%%%%%%  TODO：定时检测场景九宫格中所记录的对象（玩家，怪物，可移动npc）列表是否有残余或错误的数据 -- huangjf
%%%--------------------------------------
-module(lib_aoi).

-export([
        get_scene_grid_data/1,
        set_scene_grid_data/2,
        del_scene_grid_data/1,


        get_player_pos/1,
        set_player_pos/2,
        del_player_pos/1,

        get_player_scene_line/1,


        get_mon_pos/1,
        set_mon_pos/2,
        del_mon_pos/1,

        get_npc_pos/1,
        set_npc_pos/2,
        del_npc_pos/1,

        get_scene_info/1,
        set_scene_info/2,
        init_scene_info/2,
        get_scene_width_height/1,


        add_player_to_grid/3, add_player_to_grid/4,
        add_mon_to_grid/2,
        add_npc_to_grid/2, add_npc_to_grid/3,

        del_player_from_grid/2, del_player_from_grid/3,
        del_mon_from_grid/2,
        del_npc_from_grid/2, del_npc_from_grid/3,


        to_aoi_pos/1,
        to_scene_obj/1,

        calc_grid_index/3,


        get_AOI_player_ids/1,
        get_AOI_player_ids/3,
        % get_AOI_player_ids_TOL/1,
        get_AOI_player_ids_except_me/2,
        get_AOI_player_ids_by_scene_line_or_team_except_me/3,
        

        get_AOI_player_ids_by_scene_line/2,
        get_AOI_all_obj_ids_by_scene_line_or_team_except_me/3,

        get_AOI_all_obj_ids_except_me/2,

        player_move_aoi_broadcast/6,

        npc_move_aoi_broadcast/6
             
    ]).


-include("aoi.hrl").
-include("scene.hrl").
-include("scene_line.hrl").
-include("player.hrl").
-include("debug.hrl").
-include("ets_name.hrl").
-include("pt_12.hrl").
-include("abbreviate.hrl").




-define(PDKN_PLAYER_POS, pdkn_player_pos).
-define(PDKN_MON_POS, pdkn_mon_pos).
-define(PDKN_NPC_POS, pdkn_npc_pos).
-define(PDKN_SCENE_INFO, pdkn_scene_info).



get_scene_grid_data(SceneGridKey) ->
    ?ASSERT(is_tuple(SceneGridKey), SceneGridKey),
    case erlang:get(SceneGridKey) of
        undefined ->
            null;
        Val ->
            ?ASSERT(is_record(Val, scene_grid), {SceneGridKey, Val}),
            ?ASSERT(Val#scene_grid.key =:= SceneGridKey, {SceneGridKey, Val}),
            Val
    end.


set_scene_grid_data(SceneGridKey, Val) when is_record(Val, scene_grid) ->
    ?ASSERT(is_tuple(SceneGridKey), SceneGridKey),
    erlang:put(SceneGridKey, Val).
        

del_scene_grid_data(SceneGridKey) ->
    ?ASSERT(is_tuple(SceneGridKey), SceneGridKey),
    erlang:erase(SceneGridKey).






%% return: null | aoi_pos结构体
get_player_pos(PlayerId) ->
    ?ASSERT(is_integer(PlayerId), PlayerId),
    case erlang:get({?PDKN_PLAYER_POS, PlayerId}) of
        undefined ->
            null;
        Val ->
            ?ASSERT(is_record(Val, aoi_pos), {PlayerId, Val}),
            Val
    end.

set_player_pos(PlayerId, Val) when is_record(Val, aoi_pos) ->
    ?ASSERT(is_integer(PlayerId), PlayerId),
    erlang:put({?PDKN_PLAYER_POS, PlayerId}, Val).
        
del_player_pos(PlayerId) ->
    ?ASSERT(is_integer(PlayerId), PlayerId),
    erlang:erase({?PDKN_PLAYER_POS, PlayerId}).






%% return: null | aoi_pos结构体
get_mon_pos(MonId) ->
    ?ASSERT(is_integer(MonId), MonId),
    case erlang:get({?PDKN_MON_POS, MonId}) of
        undefined ->
            null;
        Val ->
            ?ASSERT(is_record(Val, aoi_pos), {MonId, Val}),
            Val
    end.

set_mon_pos(MonId, Val) when is_record(Val, aoi_pos) ->
    ?ASSERT(is_integer(MonId), MonId),
    erlang:put({?PDKN_MON_POS, MonId}, Val).


del_mon_pos(MonId) ->
    ?ASSERT(is_integer(MonId), MonId),
    erlang:erase({?PDKN_MON_POS, MonId}).





%% return: null | aoi_pos结构体
get_npc_pos(NpcId) ->
    ?ASSERT(is_integer(NpcId), NpcId),
    case erlang:get({?PDKN_NPC_POS, NpcId}) of
        undefined ->
            null;
        Val ->
            ?ASSERT(is_record(Val, aoi_pos), {NpcId, Val}),
            Val
    end.

set_npc_pos(NpcId, Val) when is_record(Val, aoi_pos) ->
    ?ASSERT(is_integer(NpcId), NpcId),
    erlang:put({?PDKN_NPC_POS, NpcId}, Val).

del_npc_pos(NpcId) ->
    ?ASSERT(is_integer(NpcId), NpcId),
    erlang:erase({?PDKN_NPC_POS, NpcId}).




get_scene_info(SceneId) ->
    case erlang:get({?PDKN_SCENE_INFO, SceneId}) of
        undefined ->
            null;
        Val ->
            ?ASSERT(is_record(Val, aoi_scene), {SceneId, Val}),
            Val
    end.

set_scene_info(SceneId, Val) when is_record(Val, aoi_scene) ->
    erlang:put({?PDKN_SCENE_INFO, SceneId}, Val).


init_scene_info(SceneId, Val) ->
    set_scene_info(SceneId, Val).


get_scene_width_height(SceneId) ->
    case get_scene_info(SceneId) of
        null ->
            error;
        Val ->
            {Val#aoi_scene.width, Val#aoi_scene.height}
    end.


        
    



get_player_scene_line(PlayerId) ->
    case get_player_pos(PlayerId) of
        null ->
            ?INVALID_SCENE_LINE;
        Pos ->
            Pos#aoi_pos.scene_line
    end.



%% @doc 
%% @spec 把玩家加入场景格子的内部数据记录
%% @end
add_player_to_grid(SceneId, GridIdx, PlayerId, SendPid) ->
    Key = lib_scene:to_scene_grid_key(SceneId, GridIdx),
    add_player_to_grid(Key, PlayerId, SendPid).

add_player_to_grid(SceneGridkey, PlayerId, SendPid) ->
    % case ets:lookup(?ETS_SCENE_GRID(SceneId), SceneGridkey) of
    %     [] ->
    %         NewSceneGrid = make_new_scene_grid_rd(SceneGridkey), 
    %         NewSceneGrid_2 = NewSceneGrid#scene_grid{
    %                             player_infos = [{PlayerId, SendPid}]
    %                             },
    %         true = ets:insert_new(?ETS_SCENE_GRID(SceneId), NewSceneGrid_2);
    %     [#scene_grid{player_infos = L} = SceneGrid] ->
    %         %%%%?ASSERT(not lists:keymember(PlayerId, 1, L), {SceneGridkey, PlayerId}),  % 断言新进入的场景格子中没有该玩家的记录
    %         case lists:keymember(PlayerId, 1, L) of
    %             true ->
    %                 ?ASSERT(false, {SceneGridkey, PlayerId}),
    %                 ?ERROR_MSG("[lib_scene] add_player_to_grid() error!! SceneGridkey:~w, PlayerId:~p", [SceneGridkey, PlayerId]),
    %                 skip;
    %             false ->
    %                 SceneGrid_2 = SceneGrid#scene_grid{player_infos = [{PlayerId, SendPid} | L]},
    %                 ets:insert(?ETS_SCENE_GRID(SceneId), SceneGrid_2)
    %         end 
    % end.
    case get_scene_grid_data(SceneGridkey) of
        null ->
            NewSceneGrid = make_new_scene_grid_rd(SceneGridkey), 
            NewSceneGrid_2 = NewSceneGrid#scene_grid{
                                player_infos = [{PlayerId, SendPid}]
                                },
            % ?TRACE("add_player_to_grid(), PlayerId:~p, NewSceneGrid_2:~w~n", [PlayerId, NewSceneGrid_2]),
            set_scene_grid_data(SceneGridkey, NewSceneGrid_2);
        SceneGrid ->
            L = SceneGrid#scene_grid.player_infos,
            %%%%?ASSERT(not lists:keymember(PlayerId, 1, L), {SceneGridkey, PlayerId}),  % 断言新进入的场景格子中没有该玩家的记录
            case lists:keymember(PlayerId, 1, L) of
                true ->
                    ?ASSERT(false, {SceneGridkey, PlayerId}),
                    ?ERROR_MSG("[lib_scene] add_player_to_grid() error!! SceneGridkey:~w, PlayerId:~p", [SceneGridkey, PlayerId]),
                    skip;
                false ->
                    SceneGrid_2 = SceneGrid#scene_grid{player_infos = [{PlayerId, SendPid} | L]},
                    % ?TRACE("add_player_to_grid(), PlayerId:~p, SceneGrid:~w, SceneGrid_2:~w~n", [PlayerId, SceneGrid, SceneGrid_2]),
                    set_scene_grid_data(SceneGridkey, SceneGrid_2)
            end 
    end.


%% 把怪物加入场景格子的内部数据记录
add_mon_to_grid(SceneGridkey, MonId) ->
    % case ets:lookup(?ETS_SCENE_GRID(SceneId), SceneGridkey) of
    %     [] ->
    %         NewSceneGrid = make_new_scene_grid_rd(SceneGridkey), 
    %         NewSceneGrid_2 = NewSceneGrid#scene_grid{
    %                             mon_ids = [MonId]
    %                             },
    %         true = ets:insert_new(?ETS_SCENE_GRID(SceneId), NewSceneGrid_2);
    %     [#scene_grid{mon_ids = L} = SceneGrid] ->
    %         %%%?ASSERT(not lists:member(MonId, L), {SceneGridkey, MonId}),  % 断言新进入的场景格子中没有该怪物的记录
    %         case lists:member(MonId, L) of
    %             true ->
    %                 ?ASSERT(false, {SceneGridkey, MonId}),
    %                 ?ERROR_MSG("[lib_scene] add_mon_to_grid() error!! SceneGridkey:~w, MonId:~p", [SceneGridkey, MonId]),
    %                 skip;
    %             false ->
    %                 SceneGrid_2 = SceneGrid#scene_grid{mon_ids = [MonId | L]},
    %                 ets:insert(?ETS_SCENE_GRID(SceneId), SceneGrid_2)
    %         end 
    % end.
    case get_scene_grid_data(SceneGridkey) of
        null ->
            NewSceneGrid = make_new_scene_grid_rd(SceneGridkey), 
            NewSceneGrid_2 = NewSceneGrid#scene_grid{
                                mon_ids = [MonId]
                                },
            set_scene_grid_data(SceneGridkey, NewSceneGrid_2);
        SceneGrid ->
            L = SceneGrid#scene_grid.mon_ids,
            %%%?ASSERT(not lists:member(MonId, L), {SceneGridkey, MonId}),  
            case lists:member(MonId, L) of
                true ->
                    ?ASSERT(false, {SceneGridkey, MonId}),  % 断言新进入的场景格子中没有该怪物的记录
                    ?ERROR_MSG("[lib_scene] add_mon_to_grid() error!! SceneGridkey:~w, MonId:~p", [SceneGridkey, MonId]),
                    skip;
                false ->
                    SceneGrid_2 = SceneGrid#scene_grid{mon_ids = [MonId | L]},
                    set_scene_grid_data(SceneGridkey, SceneGrid_2)
            end 
    end.


%% 把NPC加入场景格子的内部数据记录
add_npc_to_grid(SceneId, GridIdx, NpcId) ->
    Key = lib_scene:to_scene_grid_key(SceneId, GridIdx),
    add_npc_to_grid(Key, NpcId).


add_npc_to_grid(SceneGridkey, NpcId) ->
    % case ets:lookup(?ETS_SCENE_GRID(SceneId), SceneGridkey) of
    %     [] ->
    %         NewSceneGrid = make_new_scene_grid_rd(SceneGridkey), 
    %         NewSceneGrid_2 = NewSceneGrid#scene_grid{
    %                             npc_ids = [NpcId]
    %                             },
    %         true = ets:insert_new(?ETS_SCENE_GRID(SceneId), NewSceneGrid_2);
    %     [#scene_grid{npc_ids = L} = SceneGrid] ->
    %         %%%?ASSERT(not lists:member(NpcId, L), {SceneGridkey, NpcId}),  % 断言新进入的场景格子中没有该NPC的记录
    %         case lists:member(NpcId, L) of
    %             true ->
    %                 ?ASSERT(false, {SceneGridkey, NpcId}),
    %                 ?ERROR_MSG("[lib_scene] add_npc_to_grid() error!! SceneGridkey:~w, NpcId:~p", [SceneGridkey, NpcId]),
    %                 skip;
    %             false ->
    %                 SceneGrid_2 = SceneGrid#scene_grid{npc_ids = [NpcId | L]},
    %                 ets:insert(?ETS_SCENE_GRID(SceneId), SceneGrid_2)
    %         end 
    % end.
    case get_scene_grid_data(SceneGridkey) of
        null ->
            NewSceneGrid = make_new_scene_grid_rd(SceneGridkey), 
            NewSceneGrid_2 = NewSceneGrid#scene_grid{
                                npc_ids = [NpcId]
                                },
            set_scene_grid_data(SceneGridkey, NewSceneGrid_2);
        SceneGrid ->
            L = SceneGrid#scene_grid.npc_ids,
            %%%?ASSERT(not lists:member(NpcId, L), {SceneGridkey, NpcId}),  
            case lists:member(NpcId, L) of
                true ->
                    ?ASSERT(false, {SceneGridkey, NpcId}),  % 断言新进入的场景格子中没有该NPC的记录
                    ?ERROR_MSG("[lib_scene] add_npc_to_grid() error!! SceneGridkey:~w, NpcId:~p", [SceneGridkey, NpcId]),
                    skip;
                false ->
                    SceneGrid_2 = SceneGrid#scene_grid{npc_ids = [NpcId | L]},
                    set_scene_grid_data(SceneGridkey, SceneGrid_2)
            end 
    end.




%% 场景格子的内部数据记录移除某个玩家的记录
del_player_from_grid(SceneId, GridIdx, PlayerId) ->
    del_player_from_grid( lib_scene:to_scene_grid_key(SceneId, GridIdx), PlayerId).

del_player_from_grid(SceneGridKey, PlayerId) ->
    % case ets:lookup(?ETS_SCENE_GRID(SceneId), SceneGridKey) of
    %     [] ->
    %         %%?ERROR_MSG("[lib_scene] del_player_from_grid() error!! SceneGridKey: ~w, PlayerId: ~p", [SceneGridKey, PlayerId]),
    %         %%?ASSERT(false, {SceneGridKey, PlayerId}),
    %         %%error;
    %         skip;
    %     [#scene_grid{player_infos = L} = SceneGrid] ->
    %         % 多人组队跳转场景时，此断言不适用，故屏蔽掉！ -- huangjf
    %         %%?ASSERT(lists:keymember(PlayerId, 1, L), {SceneGridKey, PlayerId, player:get_position(PlayerId), L}),  % 断言原先所在的场景格子有该玩家的记录

    %         ets:insert(?ETS_SCENE_GRID(SceneId), SceneGrid#scene_grid{player_infos = del_elem_from_list__(PlayerId, L)})
    % end.
    case get_scene_grid_data(SceneGridKey) of
        null ->
            %%?ERROR_MSG("[lib_scene] del_player_from_grid() error!! SceneGridKey: ~w, PlayerId: ~p", [SceneGridKey, PlayerId]),
            %%?ASSERT(false, {SceneGridKey, PlayerId}),
            %%error;
            skip;
        SceneGrid ->
            L = SceneGrid#scene_grid.player_infos,
            % 多人组队跳转场景时，此断言不适用，故屏蔽掉！ -- huangjf
            %%?ASSERT(lists:keymember(PlayerId, 1, L), {SceneGridKey, PlayerId, player:get_position(PlayerId), L}),  % 断言原先所在的场景格子有该玩家的记录
            SceneGrid_2 = SceneGrid#scene_grid{player_infos = del_elem_from_list__(PlayerId, L)},
            % ?TRACE("del_player_from_grid(), PlayerId:~p, SceneGrid:~w, SceneGrid_2:~w~n", [PlayerId, SceneGrid, SceneGrid_2]),
            set_scene_grid_data(SceneGridKey, SceneGrid_2)
    end.




%% 场景格子的内部数据记录移除某个怪物的记录
del_mon_from_grid(SceneGridKey, MonId) ->
    % case ets:lookup(?ETS_SCENE_GRID(SceneId), SceneGridKey) of
    %     [] ->
    %         ?ERROR_MSG("[lib_scene] del_mon_from_grid() error!! SceneGridKey: ~p, MonId: ~p", [SceneGridKey, MonId]),
    %         ?ASSERT(false, {SceneGridKey, MonId}),
    %         error;
    %     [#scene_grid{mon_ids = L} = SceneGrid] ->
    %         ?ASSERT(lists:member(MonId, L), {SceneGridKey, MonId}),  % 断言原先所在的场景格子有该怪物的记录
    %         NewMonIdList = L -- [MonId],
    %         ets:insert(?ETS_SCENE_GRID(SceneId), SceneGrid#scene_grid{mon_ids = NewMonIdList})
    % end.
    case get_scene_grid_data(SceneGridKey) of
        null ->
            ?ERROR_MSG("[mod_go] del_mon_from_grid() error!! SceneGridKey: ~p, MonId: ~p", [SceneGridKey, MonId]),
            ?ASSERT(false, {SceneGridKey, MonId}),
            error;
        SceneGrid ->
            L = SceneGrid#scene_grid.mon_ids,
            ?ASSERT(lists:member(MonId, L), {SceneGridKey, MonId}),  % 断言原先所在的场景格子有该怪物的记录
            NewMonIdList = L -- [MonId],
            set_scene_grid_data(SceneGridKey, SceneGrid#scene_grid{mon_ids = NewMonIdList})
    end.




%% 场景格子的内部数据记录移除某个NPC的记录
del_npc_from_grid(SceneId, GridIdx, NpcId) ->
    del_npc_from_grid( lib_scene:to_scene_grid_key(SceneId, GridIdx), NpcId).

del_npc_from_grid(SceneGridKey, NpcId) ->
    % case ets:lookup(?ETS_SCENE_GRID(SceneId), SceneGridKey) of
    %     [] ->
    %         ?ERROR_MSG("[lib_scene] del_npc_from_grid() error!! SceneGridKey: ~p, NpcId: ~p", [SceneGridKey, NpcId]),
    %         ?ASSERT(false, {SceneGridKey, NpcId}),
    %         error;
    %     [#scene_grid{npc_ids = L} = SceneGrid] ->
    %         ?ASSERT(lists:member(NpcId, L), {SceneGridKey, NpcId}),  % 断言原先所在的场景格子有该NPC的记录
    %         NewNpcIdList = L -- [NpcId],
    %         ets:insert(?ETS_SCENE_GRID(SceneId), SceneGrid#scene_grid{npc_ids = NewNpcIdList})
    % end.
    case get_scene_grid_data(SceneGridKey) of
        null ->
            ?ERROR_MSG("[mod_go] del_npc_from_grid() error!! SceneGridKey: ~p, NpcId: ~p", [SceneGridKey, NpcId]),
            ?ASSERT(false, {SceneGridKey, NpcId}),
            error;
        SceneGrid ->
            L = SceneGrid#scene_grid.npc_ids,
            ?ASSERT(lists:member(NpcId, L), {SceneGridKey, NpcId}),  % 断言原先所在的场景格子有该NPC的记录
            NewNpcIdList = L -- [NpcId],
            set_scene_grid_data(SceneGridKey, SceneGrid#scene_grid{npc_ids = NewNpcIdList})
    end.




%% 转为aoi_pos结构体
to_aoi_pos(PlayerPos) ->
    #aoi_pos{
        scene_id = PlayerPos#plyr_pos.scene_id,
        x = PlayerPos#plyr_pos.x,
        y = PlayerPos#plyr_pos.y,
        scene_line = PlayerPos#plyr_pos.scene_line
        %%scene_grid_index = PlayerPos#plyr_pos.scene_grid_index
        }.


%% 转为场景对象结构体
to_scene_obj(SceneInfo) ->
    #scene{
        id = SceneInfo#aoi_scene.scene_id,
        width = SceneInfo#aoi_scene.width,
        height = SceneInfo#aoi_scene.height
        }.

    

calc_grid_index(SceneId, X, Y) ->
    {SceneWid, SceneHei} = get_scene_width_height(SceneId),
    lib_scene:calc_grid_index(SceneWid, SceneHei, X, Y).




%% make一个新的scene_grid结构体
make_new_scene_grid_rd(SceneGridKey) ->
    ?ASSERT(is_tuple(SceneGridKey)),
    #scene_grid{
            key = SceneGridKey,
            player_infos = [],
            mon_ids = [],
            npc_ids = []
        }.





%% @doc delete the first matching element form list
%% @spec del_elem_from_list(Target::trem(), List::list()) -> NewList::list()
%% @end
del_elem_from_list__(_, []) -> [];
del_elem_from_list__(Target, [{Target, _} | List]) -> List;
del_elem_from_list__(Target, [Element | List]) ->
    [Element | del_elem_from_list__(Target, List)].










%% 获取某位置对应的AOI范围内的所有玩家id列表
%% @return: [] | 玩家id列表
get_AOI_player_ids(SceneId, X, Y) ->
    % GridIdx = lib_scene:calc_grid_index(SceneId, X, Y),
    % get_scene_aoi_player_ids(SceneId, GridIdx).

    case get_scene_width_height(SceneId) of
        error ->
            ?ASSERT(false, {SceneId, X, Y}),
            [];
        {SceneWid, SceneHei} ->
            GridIdx = lib_scene:calc_grid_index(SceneWid, SceneHei, X, Y),
            get_scene_aoi_player_ids(SceneId, GridIdx)
    end.

    
    

    
%% 获取某位置对应的AOI范围内的所有玩家id列表
%% @para: PlayerPos => 玩家的位置，plyr_pos结构体
%% @return: [] | 玩家id列表
% get_AOI_player_ids(PlayerPos) ->
%     ?ASSERT(is_record(PlayerPos, plyr_pos), PlayerPos),
%     SceneId = PlayerPos#plyr_pos.scene_id,
%     GridIdx = lib_scene:calc_grid_index(PlayerPos),
%     get_scene_aoi_player_ids(SceneId, GridIdx).

 get_AOI_player_ids(Pos) ->
    ?ASSERT(is_record(Pos, aoi_pos), Pos),
    SceneId = Pos#aoi_pos.scene_id,

    case get_scene_width_height(SceneId) of
        error ->
            ?ASSERT(false, {SceneId, Pos}),
            [];
        {SceneWid, SceneHei} ->
            GridIdx = lib_scene:calc_grid_index(SceneWid, SceneHei, Pos#aoi_pos.x, Pos#aoi_pos.y),
            get_scene_aoi_player_ids(SceneId, GridIdx)
    end.

            



% %% TOL：tolerant，表示此函数是包含容错处理的版本
% get_AOI_player_ids_TOL(PlayerPos) ->
%     ?ASSERT(is_record(PlayerPos, plyr_pos), PlayerPos),
%     SceneId = PlayerPos#plyr_pos.scene_id,
%     case lib_scene:calc_grid_index_TOL(PlayerPos) of
%         invalid ->
%             [];
%         GridIdx ->
%             get_scene_aoi_player_ids(SceneId, GridIdx)
%     end.




%% 获取某位置对应的AOI范围内的玩家id列表，排除掉玩家自己！
%% @para: MyPos => 玩家的位置，plyr_pos结构体
%% @return: [] | 玩家id列表
get_AOI_player_ids_except_me(MyId, Pos) ->
    ?ASSERT(is_record(Pos, aoi_pos), Pos),
    L = get_AOI_player_ids(Pos),
    L -- [MyId].




            
get_AOI_player_ids_by_scene_line_or_team_except_me(MyId, Pos, SceneLine) ->
    ?ASSERT(is_record(Pos, aoi_pos), Pos),
    L = get_AOI_player_ids_by_scene_line_or_team(MyId, Pos, SceneLine),
    L -- [MyId].


% %% TOL: tolerant, 表示此函数是包含了容错处理的版本      
% get_AOI_player_ids_by_scene_line_or_team_except_me_TOL(MyId, Pos, SceneLine) ->
%     RetL =  case get_AOI_player_ids(Pos) of %%get_AOI_player_ids_TOL(Pos) of
%                 [] ->
%                     [];
%                 L ->
%                     TeammateIdList = lib_team:get_teammate_id_list(MyId),
%                     F = fun(PlayerId) ->
%                             (player:get_scene_line(PlayerId) == SceneLine)
%                             orelse lists:member(PlayerId, TeammateIdList)
%                         end,
%                     [X || X <- L, F(X)]
%             end,
%     RetL -- [MyId].






get_AOI_all_obj_ids_by_scene_line_or_team_except_me(MyId, Pos, SceneLine) ->
    ?ASSERT(is_record(Pos, aoi_pos), Pos),
    {PlayerIdList , MonIdList, NpcIdList} = get_AOI_all_obj_ids_except_me(MyId, Pos),
    PlayerIdList2 = case PlayerIdList of
                        [] ->
                            [];
                        _ ->
                            TeammateIdList = lib_team:get_teammate_id_list(MyId),
                            F = fun(PlayerId) ->
                                    (get_player_scene_line(PlayerId) == SceneLine)
                                    orelse lists:member(PlayerId, TeammateIdList)
                                end,
                            [X || X <- PlayerIdList, F(X)]
                    end,

    {PlayerIdList2, MonIdList, NpcIdList}.





%% 类似上几个接口，但只返回指定场景分线的玩家
get_AOI_player_ids_by_scene_line(Pos, SceneLine) ->
    L = get_AOI_player_ids(Pos),
    F = fun(PlayerId) ->
            get_player_scene_line(PlayerId) == SceneLine
        end,
    [X || X <- L, F(X)].






get_AOI_player_ids_by_scene_line_or_team(MyId, Pos, SceneLine) ->
    case get_AOI_player_ids(Pos) of
        [] ->
            [];
        L ->
            TeammateIdList = lib_team:get_teammate_id_list(MyId),
            F = fun(PlayerId) ->
                    (get_player_scene_line(PlayerId) == SceneLine)
                    orelse lists:member(PlayerId, TeammateIdList)
                end,
            [X || X <- L, F(X)]
    end.





%% 获取某位置对应的AOI范围内的所有对象（包括其他玩家，怪物和巡逻NPC）的id列表，排除掉玩家自己！
get_AOI_all_obj_ids_except_me(MyId, Pos) ->
    ?ASSERT(is_record(Pos, aoi_pos), Pos),

    SceneId = Pos#aoi_pos.scene_id,  %%%SceneId = Pos#plyr_pos.scene_id,
    case get_scene_width_height(SceneId) of
        error ->
            ?ASSERT(false, Pos),
            [];
        {SceneWid, SceneHei} ->
            GridIdx = lib_scene:calc_grid_index(SceneWid, SceneHei, Pos#aoi_pos.x, Pos#aoi_pos.y),
            {PlayerIdList, MonIdList, NpcIdList} = get_scene_aoi_all_obj_ids(SceneId, GridIdx),

            % ?TRACE("lib_aoi, get_AOI_all_obj_ids_except_me(), MyId:~p, Pos:~w, {PlayerIdList , MonIdList, NpcIdList}:~w~n", 
            %                 [MyId, Pos, {PlayerIdList , MonIdList, NpcIdList}]),
            {PlayerIdList -- [MyId], MonIdList, NpcIdList}
    end.


            






% %% 同上，只是限制了返回的玩家数（以避免AOI大量广播的压力）
% get_AOI_all_obj_ids_except_me_limited(MyId, Pos) ->
%   ?ASSERT(is_record(Pos, plyr_pos), Pos),
%   GridIdx = calc_grid_index(Pos),
%   SceneId = Pos#plyr_pos.scene_id,
%   ?TRACE("get_AOI_all_obj_ids_except_me_limited()...~n"),
%   {PlayerIdList, MonIdList, NpcIdList} = get_scene_aoi_all_obj_ids_limited(SceneId, GridIdx, ?MAX_PLAYERS_PICKED_EACH_GRID),
%   {PlayerIdList -- [MyId], MonIdList, NpcIdList}.










%% 玩家移动的AOI广播
player_move_aoi_broadcast(PS, SceneId, NewX, NewY, OldGrid, OldGrid) ->  % 同场景格子内走动
    {Mixed, _, _} = get_two_grid_sets(SceneId, OldGrid, OldGrid),
    {Mixed_PlayerIdL0, _, _} = Mixed,
    % 过滤掉不同分线的玩家
    MyId = player:id(PS),
    MySceneLine = get_player_scene_line(MyId), %%player:get_scene_line(MyId),
    Mixed_PlayerIdL = pick_player_by_scene_line_or_team(Mixed_PlayerIdL0, PS, MySceneLine),
    ?Ifc (Mixed_PlayerIdL /= [])
        {ok, MyMoveNotice} = pt_12:write(?PT_PLAYER_MOVE, [player:id(PS), NewX, NewY]),
        lists:foreach(fun(__Id) -> lib_send:send_to_uid(__Id, MyMoveNotice) end, Mixed_PlayerIdL)
    ?End;
player_move_aoi_broadcast(PS, SceneId, NewX, NewY, OldGrid, NewGrid) ->  % 跨场景格子走动
    {Mixed, Leave, Enter} = get_two_grid_sets(SceneId, OldGrid, NewGrid),

    {Mixed_PlayerIdL0, _Mixed_MonIdL, _Mixed_NpcIdL} = Mixed,
    {Leave_PlayerIdL0, Leave_MonIdL, Leave_NpcIdL} = Leave,
    {Enter_PlayerIdL0, Enter_MonIdL, Enter_NpcIdL} = Enter,

    % 过滤掉不同分线的玩家
    MyId = player:id(PS),
    MySceneLine = get_player_scene_line(MyId), %%player:get_scene_line(MyId),
    %%?DEBUG_MSG("player_move_aoi_broadcast(), MySceneLine:~p", [MySceneLine]),
    %%?DEBUG_MSG("Mixed_PlayerIdL0:~w, Leave_PlayerIdL0:~w, Enter_PlayerIdL0:~w", [Mixed_PlayerIdL0, Leave_PlayerIdL0, Enter_PlayerIdL0]),
    Mixed_PlayerIdL = pick_player_by_scene_line_or_team(Mixed_PlayerIdL0, PS, MySceneLine),
    Leave_PlayerIdL = pick_player_by_scene_line_or_team(Leave_PlayerIdL0, PS, MySceneLine),
    Enter_PlayerIdL = pick_player_by_scene_line_or_team(Enter_PlayerIdL0, PS, MySceneLine),

    %%?DEBUG_MSG("Mixed_PlayerIdL:~w, Leave_PlayerIdL:~w, Enter_PlayerIdL:~w", [Mixed_PlayerIdL, Leave_PlayerIdL, Enter_PlayerIdL]),

    % ?TRACE("Mixed=~p, Leave=~p, Enter=~p~n~n~n", [Mixed, Leave, Enter]),

    % ?TRACE("Mixed_MonIdL=~p, Leave_MonIdL=~p, Enter_MonIdL=~p~n~n", [_Mixed_MonIdL, Leave_MonIdL, Enter_MonIdL]),
    % ?TRACE("Mixed_NpcIdL=~p, Leave_NpcIdL=~p, Enter_NpcIdL=~p~n~n", [_Mixed_NpcIdL, Leave_NpcIdL, Enter_NpcIdL]),


    ?Ifc (Mixed_PlayerIdL /= [])
        {ok, MyMoveNotice} = pt_12:write(?PT_PLAYER_MOVE, [MyId, NewX, NewY]),
        lists:foreach(fun(__Id) -> lib_send:send_to_uid(__Id, MyMoveNotice) end, Mixed_PlayerIdL)
    ?End,

    ?Ifc (Leave_PlayerIdL /= [])
        {ok, MyLeaveAoiNotice} = pt_12:write(?PT_NOTIFY_PLAYERS_LEAVE_MY_AOI, [MyId]),
        lists:foreach(fun(__Id) -> lib_send:send_to_uid(__Id, MyLeaveAoiNotice) end, Leave_PlayerIdL)
    ?End,

    ?Ifc (Enter_PlayerIdL /= [])
        {ok, MyEnterAoiNotice} = pt_12:write(?PT_NOTIFY_PLAYERS_ENTER_MY_AOI, PS),
        lists:foreach(fun(__Id) -> lib_send:send_to_uid(__Id, MyEnterAoiNotice) end, Enter_PlayerIdL)
    ?End,

            
    % 通知其他玩家的进入与离开
    % Enter_PlayerIdL: 新进入我的AOI的玩家id列表， Leave_PlayerIdL: 被动离开我的AOI的玩家id列表
    ?Ifc (Enter_PlayerIdL /= [])
        {ok, _Bin_NotifyEnterMyAOI} = pt_12:write(?PT_NOTIFY_PLAYERS_ENTER_MY_AOI, Enter_PlayerIdL),
        lib_send:send_to_sid(PS, _Bin_NotifyEnterMyAOI)
    ?End,
    ?Ifc (Leave_PlayerIdL /= [])
        {ok, _Bin_NotifyLeaveMyAOI} = pt_12:write(?PT_NOTIFY_PLAYERS_LEAVE_MY_AOI, Leave_PlayerIdL),
        lib_send:send_to_sid(PS, _Bin_NotifyLeaveMyAOI)
    ?End,

    % 通知怪物的进入与离开
    ?Ifc (Enter_MonIdL /= [])
        {ok, _Bin_NotifyEnterMyAOI_Mon} = pt_12:write(?PT_NOTIFY_OBJS_ENTER_MY_AOI, {mon, Enter_MonIdL}),
        lib_send:send_to_sid(PS, _Bin_NotifyEnterMyAOI_Mon)
    ?End,
    ?Ifc (Leave_MonIdL /= [])
        {ok, _Bin_NotifyLeaveMyAOI_Mon} = pt_12:write(?PT_NOTIFY_OBJS_LEAVE_MY_AOI, {mon, Leave_MonIdL}),
        lib_send:send_to_sid(PS, _Bin_NotifyLeaveMyAOI_Mon)
    ?End,

    ?TRACE("lib_aoi, player move, Enter_NpcIdL:~p~n", [Enter_NpcIdL]),
    ?TRACE("lib_aoi, player move, Leave_NpcIdL:~p~n", [Leave_NpcIdL]),

    % 通知NPC（可移动npc）的进入与离开
    ?Ifc (Enter_NpcIdL /= [])
        {ok, _Bin_NotifyEnterMyAOI_Npc} = pt_12:write(?PT_NOTIFY_OBJS_ENTER_MY_AOI, {npc, Enter_NpcIdL}),
        lib_send:send_to_sid(PS, _Bin_NotifyEnterMyAOI_Npc)
    ?End,
    ?Ifc (Leave_NpcIdL /= [])
        {ok, _Bin_NotifyLeaveMyAOI_Npc} = pt_12:write(?PT_NOTIFY_OBJS_LEAVE_MY_AOI, {npc, Leave_NpcIdL}),
        lib_send:send_to_sid(PS, _Bin_NotifyLeaveMyAOI_Npc)
    ?End.






%% npc移动的AOI广播
npc_move_aoi_broadcast(NpcObj, SceneId, NewX, NewY, OldGrid, OldGrid) ->  % 同场景格子内走动
    {Mixed, _, _} = get_two_grid_sets(SceneId, OldGrid, OldGrid),
    {Mixed_PlayerIdL, _, _} = Mixed,
    ?Ifc (Mixed_PlayerIdL /= [])
        {ok, MoveNotice} = pt_12:write(?PT_NOTIFY_OBJ_MOVE, [npc, mod_npc:get_id(NpcObj), NewX, NewY]),
        ?TRACE("npc_move_aoi_broadcast(), SAME GRID!!! NpcId:~p, NewX:~p, NewY:~p, Mixed_PlayerIdL:~p, MoveNotice:~w~n", [mod_npc:get_id(NpcObj), NewX, NewY, Mixed_PlayerIdL, MoveNotice]),
        lists:foreach(fun(__Id) -> lib_send:send_to_uid(__Id, MoveNotice) end, Mixed_PlayerIdL)
    ?End;
npc_move_aoi_broadcast(NpcObj, SceneId, NewX, NewY, OldGrid, NewGrid) ->  % 跨场景格子走动
    {Mixed, Leave, Enter} = get_two_grid_sets(SceneId, OldGrid, NewGrid),

    {Mixed_PlayerIdL, _Mixed_MonIdL, _Mixed_NpcIdL} = Mixed,
    {Leave_PlayerIdL, _Leave_MonIdL, _Leave_NpcIdL} = Leave,
    {Enter_PlayerIdL, _Enter_MonIdL, _Enter_NpcIdL} = Enter,

    NpcId = mod_npc:get_id(NpcObj),

    ?Ifc (Mixed_PlayerIdL /= [])
        {ok, MoveNotice} = pt_12:write(?PT_NOTIFY_OBJ_MOVE, [npc, NpcId, NewX, NewY]),
        ?TRACE("npc_move_aoi_broadcast(), SkIP GRID! NpcId:~p, NewX:~p, NewY:~p, Mixed_PlayerIdL:~p, MoveNotice:~w~n", [NpcId, NewX, NewY, Mixed_PlayerIdL, MoveNotice]),
        lists:foreach(fun(__Id) -> lib_send:send_to_uid(__Id, MoveNotice) end, Mixed_PlayerIdL)
    ?End,

    ?Ifc (Leave_PlayerIdL /= [])
        {ok, LeaveAoiNotice} = pt_12:write(?PT_NOTIFY_OBJS_LEAVE_MY_AOI, {npc, [NpcId]}),
        ?TRACE("npc_move_aoi_broadcast(), SkIP GRID! NpcId:~p, NewX:~p, NewY:~p, Leave_PlayerIdL:~p, LeaveAoiNotice:~w~n", [NpcId, NewX, NewY, Leave_PlayerIdL, LeaveAoiNotice]),
        lists:foreach(fun(__Id) -> lib_send:send_to_uid(__Id, LeaveAoiNotice) end, Leave_PlayerIdL)
    ?End,

    ?Ifc (Enter_PlayerIdL /= [])
        {ok, EnterAoiNotice} = pt_12:write(?PT_NOTIFY_OBJS_ENTER_MY_AOI, {npc, NpcObj}),
        ?TRACE("npc_move_aoi_broadcast(), SkIP GRID! NpcId:~p, NewX:~p, NewY:~p, Enter_PlayerIdL:~p, EnterAoiNotice:~w~n", [NpcId, NewX, NewY, Enter_PlayerIdL, EnterAoiNotice]),
        lists:foreach(fun(__Id) -> lib_send:send_to_uid(__Id, EnterAoiNotice) end, Enter_PlayerIdL)
    ?End.

    
            






pick_player_by_scene_line_or_team([], _MyPS, _MySceneLine) ->
    [];
pick_player_by_scene_line_or_team(PlayerIdList, MyPS, MySceneLine) ->
    MyId = player:id(MyPS),
    TeammateIdList = lib_team:get_teammate_id_list(MyPS),
    F = fun(PlayerId) ->
            %%?DEBUG_MSG("pick_player_by_scene_line(), MyId:~p, MySceneLine:~p, PlayerId:~p, PlayerSceneLine:~p", 
            %%                          [MyId, MySceneLine, PlayerId, player:get_scene_line(PlayerId)]),

            case PlayerId of
                MyId ->
                    true;   % 目前不过滤掉自己
                _ ->
                    (get_player_scene_line(PlayerId) == MySceneLine)
                    orelse lists:member(PlayerId, TeammateIdList)
            end
        end,

    [X || X <- PlayerIdList, F(X)].





% %% @doc 取得两个格子间的 {交集，离开列表，新进入列表}
% get_two_grid_sets(SceneId, OldGrid, OldGrid) ->
%   {get_scene_aoi_player_infos(SceneId, OldGrid), [], []};
% get_two_grid_sets(SceneId, OldGrid, NewGrid) ->
%   Old_nine = get_grid_list(OldGrid),
%   New_nine = get_grid_list(NewGrid),
%   New_enter = lists:subtract(New_nine, Old_nine),
%   Mixed = lists:subtract(New_nine, New_enter),
%   Leave = lists:subtract(Old_nine, Mixed),

%   EtsName = ?ETS_SCENE_GRID(SceneId),
%   {get_grid_player_infos(EtsName, SceneId, Mixed, []), 
%    get_grid_player_infos(EtsName, SceneId, Leave, []),
%    get_grid_player_infos(EtsName, SceneId, New_enter, [])}.


% %% @doc 玩家走动的AOI广播
% player_move_aoi_broadcast(PS, SceneId, NewX, NewY, OldGrid, OldGrid) ->  % 同场景格子内走动
%   {ok, PlayerMoveData} = pt_12:write(?PT_PLAYER_MOVE, [player:id(PS), NewX, NewY]),
%   {IdList, _, _} = get_two_grid_sets(SceneId, OldGrid, OldGrid),
%   % SendPid表示专用于发送消息给客户端的进程pid，下同
%   lists:foreach(fun({_, SendPid}) -> lib_send:send_to_sid(SendPid, PlayerMoveData) end, IdList);
% player_move_aoi_broadcast(PS, SceneId, NewX, NewY, OldGrid, NewGrid) ->  % 跨场景格子走动
%   PlayerId = player:id(PS),
%   {ok, PlayerMoveData} = pt_12:write(?PT_PLAYER_MOVE, [PlayerId, NewX, NewY]),
%     {ok, LeaveMyAOIData} = pt_12:write(?PT_NOTIFY_PLAYERS_LEAVE_MY_AOI, [PlayerId]),
%     {ok, EnterMyAOIData} = pt_12:write(?PT_NOTIFY_PLAYERS_ENTER_MY_AOI, [PlayerId]),
%   {Mixed, Leave, Enter} = get_two_grid_sets(SceneId, OldGrid, NewGrid),
%   lists:foreach(fun({_, SendPid}) -> lib_send:send_to_sid(SendPid, PlayerMoveData) end, Mixed),
%   lists:foreach(fun({_, SendPid}) -> lib_send:send_to_sid(SendPid, LeaveMyAOIData) end, Leave),
%   lists:foreach(fun({_, SendPid}) -> lib_send:send_to_sid(SendPid, EnterMyAOIData) end, Enter),

%   % EnterIdList: 新进入我的AOI的玩家id列表， LeaveIdList：被动离开我的AOI的玩家id列表
%     EnterIdList = [EnterId || {EnterId, _} <- Enter],   
%     LeaveIdList = [LeaveId || {LeaveId, _} <- Leave],
%     ?Ifc (EnterIdList /= [])
%         {ok, _Bin_NotifyEnterMyAOI} = pt_12:write(?PT_NOTIFY_PLAYERS_ENTER_MY_AOI, EnterIdList),
%         lib_send:send_to_sock(PS, _Bin_NotifyEnterMyAOI)
%     ?End,
%     ?Ifc (LeaveIdList /= [])
%         {ok, _Bin_NotifyLeaveMyAOI} = pt_12:write(?PT_NOTIFY_PLAYERS_LEAVE_MY_AOI, LeaveIdList),
%         lib_send:send_to_sock(PS, _Bin_NotifyLeaveMyAOI)
%     ?End.




%% @doc 取得两个格子间的 {交集，离开列表，新进入列表}
get_two_grid_sets(SceneId, OldGrid, OldGrid) ->
    {get_scene_aoi_all_obj_ids(SceneId, OldGrid),
     {[], [], []}, 
     {[], [], []} };
% get_two_grid_sets(SceneId, OldGrid, NewGrid) ->
%     OldNine = get_grid_list(OldGrid),
%     NewNine = get_grid_list(NewGrid),
%     NewEnter = lists:subtract(NewNine, OldNine),
%     Mixed = lists:subtract(NewNine, NewEnter),
%     Leave = lists:subtract(OldNine, Mixed),

%     EtsName = ?ETS_SCENE_GRID(SceneId),
%     {get_grid_all_obj_ids(EtsName, SceneId, Mixed),    % get_grid_all_obj_ids()返回值格式：{玩家id列表，怪物id列表，巡逻NPC的id列表}
%      get_grid_all_obj_ids(EtsName, SceneId, Leave),
%      get_grid_all_obj_ids(EtsName, SceneId, NewEnter)}.
get_two_grid_sets(SceneId, OldGrid, NewGrid) ->
    OldNine = get_grid_list(OldGrid),
    NewNine = get_grid_list(NewGrid),
    NewEnter = lists:subtract(NewNine, OldNine),
    Mixed = lists:subtract(NewNine, NewEnter),
    Leave = lists:subtract(OldNine, Mixed),

    {get_grid_all_obj_ids(SceneId, Mixed),    % get_grid_all_obj_ids()返回值格式：{玩家id列表，怪物id列表，巡逻NPC的id列表}
     get_grid_all_obj_ids(SceneId, Leave),
     get_grid_all_obj_ids(SceneId, NewEnter)}.



% %% @doc 取得两个格子间的 {交集，离开列表，新进入列表}
% get_two_grid_sets(SceneId, OldGrid, OldGrid) ->
%   {get_scene_aoi_all_obj_ids_limited(SceneId, OldGrid, ?MAX_PLAYERS_PICKED_EACH_GRID),
%    {[], [], []}, 
%    {[], [], []} };
% get_two_grid_sets(SceneId, OldGrid, NewGrid) ->
%   Old_nine = get_grid_list(OldGrid),
%   New_nine = get_grid_list(NewGrid),
%   New_enter = lists:subtract(New_nine, Old_nine),
%   Mixed = lists:subtract(New_nine, New_enter),
%   Leave = lists:subtract(Old_nine, Mixed),

%   EtsName = ?ETS_SCENE_GRID(SceneId),
%   {get_grid_all_obj_ids_limited(EtsName, SceneId, Mixed, ?MAX_PLAYERS_PICKED_EACH_GRID),    % get_grid_all_obj_ids_limited()返回值格式：{玩家id列表，怪物id列表，巡逻NPC的id列表}
%    get_grid_all_obj_ids_limited(EtsName, SceneId, Leave, ?MAX_PLAYERS_PICKED_EACH_GRID),
%    get_grid_all_obj_ids_limited(EtsName, SceneId, New_enter, ?MAX_PLAYERS_PICKED_EACH_GRID)}.




%% @doc alawys return the grids around include self total nine grid, ignore the around grids exits or not
%% @spec
%% @end
% get_grid_list({X, Y}, Width, Height) ->
%   case ?CUT_GRID_WIDTH > Width andalso ?CUT_GRID_HEGIHT > Height of
%       true -> [{?DEFAULT_GRID, ?DEFAULT_GRID}];
%       false ->
%           get_grid_list({X, Y})
%   end.

get_grid_list({X, Y}) ->
    [{X, Y}, {X, Y - 1}, {X, Y + 1}, {X - 1, Y}, {X - 1, Y - 1}, {X - 1, Y + 1}, 
     {X + 1, Y}, {X + 1, Y - 1}, {X + 1, Y + 1}].




%% @doc 取得九宫格所有对象的id列表
%% @return: {玩家id列表，怪物id列表，巡逻NPC的id列表}
get_scene_aoi_all_obj_ids(SceneId, GridIdx) ->
    GridList = get_grid_list(GridIdx),
    get_grid_all_obj_ids(SceneId, GridList).  %%%get_grid_all_obj_ids(?ETS_SCENE_GRID(SceneId), SceneId, GridList).


% %% 同上， 只是限制了返回的玩家数（以避免AOI大量广播的压力）
% get_scene_aoi_all_obj_ids_limited(SceneId, GridIdx, LimitNum) ->
%   GridList = get_grid_list(GridIdx),
%   get_grid_all_obj_ids_limited(?ETS_SCENE_GRID(SceneId), SceneId, GridList, LimitNum).
    





%% @doc 取得一或多个场景格子内的所有对象的id列表
%% @return: {玩家id列表，怪物id列表，巡逻NPC的id列表}
% get_grid_all_obj_ids(Tab, SceneId, GridList) ->
%     get_grid_all_obj_ids__(Tab, SceneId, GridList, {[], [], []}).

% get_grid_all_obj_ids__(Tab, SceneId, [Grid | T], {PlayerIds, MonIds, NpcIds}) ->
%     case ets:lookup(Tab, lib_scene:to_scene_grid_key(SceneId, Grid)) of
%         [] -> 
%             get_grid_all_obj_ids__(Tab, SceneId, T, {PlayerIds, MonIds, NpcIds});
%         [SceneGrid] ->
%             __PlayerIds = [Id || {Id, _SendPid} <- SceneGrid#scene_grid.player_infos],
%             PlayerIds_2 = __PlayerIds ++ PlayerIds,
%             MonIds_2 = SceneGrid#scene_grid.mon_ids ++ MonIds,
%             NpcIds_2 = SceneGrid#scene_grid.npc_ids ++ NpcIds,
%             get_grid_all_obj_ids__(Tab, SceneId, T, {PlayerIds_2, MonIds_2, NpcIds_2})
%     end;
% get_grid_all_obj_ids__(_Tab, _SceneId, [], {PlayerIds, MonIds, NpcIds}) ->
%     {PlayerIds, MonIds, NpcIds}.
get_grid_all_obj_ids(SceneId, GridList) ->
    get_grid_all_obj_ids__(SceneId, GridList, {[], [], []}).

get_grid_all_obj_ids__(SceneId, [Grid | T], {PlayerIds, MonIds, NpcIds}) ->
    SceneGridKey = lib_scene:to_scene_grid_key(SceneId, Grid),
    case get_scene_grid_data(SceneGridKey) of
        null -> 
            get_grid_all_obj_ids__(SceneId, T, {PlayerIds, MonIds, NpcIds});
        SceneGrid ->
            __PlayerIds = [Id || {Id, _SendPid} <- SceneGrid#scene_grid.player_infos],
            PlayerIds_2 = __PlayerIds ++ PlayerIds,
            MonIds_2 = SceneGrid#scene_grid.mon_ids ++ MonIds,
            NpcIds_2 = SceneGrid#scene_grid.npc_ids ++ NpcIds,
            get_grid_all_obj_ids__(SceneId, T, {PlayerIds_2, MonIds_2, NpcIds_2})
    end;
get_grid_all_obj_ids__(_SceneId, [], {PlayerIds, MonIds, NpcIds}) ->
    {PlayerIds, MonIds, NpcIds}.








%% @doc 取得九宫格玩家的id列表
%% @return: 玩家id列表
get_scene_aoi_player_ids(SceneId, GridIdx) ->
    GridList = get_grid_list(GridIdx),
    get_grid_player_ids(SceneId, GridList, []).  %%%%get_grid_player_ids(?ETS_SCENE_GRID(SceneId), SceneId, GridList, []).


% %% @doc 取得九宫格玩家的信息列表
% %% @return: {PlayerId, SendPid}列表
% get_scene_aoi_player_infos(SceneId, GridIdx) ->
%   GridList = get_grid_list(GridIdx),
%   get_grid_player_infos(?ETS_SCENE_GRID(SceneId), SceneId, GridList, []).
    






    

% get_grid_all_obj_ids_limited(Tab, SceneId, GridList, LimitNum) ->
%   get_grid_all_obj_ids_limited__(Tab, SceneId, GridList, LimitNum, {[], [], []}).

% get_grid_all_obj_ids_limited__(Tab, SceneId, [Grid | T], LimitNum, {PlayerIds, MonIds, NpcIds}) ->
%   case ets:lookup(Tab, to_scene_grid_key(SceneId, Grid)) of
%       [] -> 
%           get_grid_all_obj_ids_limited__(Tab, SceneId, T, LimitNum, {PlayerIds, MonIds, NpcIds});
%       [SceneGrid] ->
%           __PlayerIds = [Id || {Id, _SendPid} <- SceneGrid#scene_grid.player_infos],
%           ?TRACE("get_grid_all_obj_ids_limited__(),  __PlayerIds:~w, SubPlayerL:~w~n", [__PlayerIds, lists:sublist(__PlayerIds, LimitNum)]),
%           PlayerIds_2 = lists:sublist(__PlayerIds, LimitNum) ++ PlayerIds,  % sublist()取前面的LimitNum个元素
%           MonIds_2 = SceneGrid#scene_grid.mon_ids ++ MonIds,
%           NpcIds_2 = SceneGrid#scene_grid.npc_ids ++ NpcIds,
%           get_grid_all_obj_ids_limited__(Tab, SceneId, T, LimitNum, {PlayerIds_2, MonIds_2, NpcIds_2})
%   end;
% get_grid_all_obj_ids_limited__(_Tab, _SceneId, [], _LimitNum, {PlayerIds, MonIds, NpcIds}) ->
%   ?TRACE("get_grid_all_obj_ids_limited__(), final player id list:~w~n", [PlayerIds]),
%   {PlayerIds, MonIds, NpcIds}.





%% @doc 取得场景所有网格编号
%% @spec 
%% @end
% get_scene_all_grid(Width, Height) ->
%   X = ?BIN_PRED(?CUT_GRID_WIDTH =< Width, erlang:max((Width div ?GRID_WIDTH), 1), 1),
%   Y = ?BIN_PRED(?CUT_GRID_HEGIHT =< Height, erlang:max((Height div ?GRID_HEIGHT), 1), 1),
%   lists:seq(?DEFAULT_GRID, X * Y).

% %% @doc 取得一或多个场景格子内的玩家信息列表 ---- {PlayerId, SendPid}列表
% %% @spec get_grid_player_infos/4 -> [] | [{Id, SendPid}, ...]
% %% @end
% get_grid_player_infos(Tab, SceneId, [Grid | T], AccList) ->
%   case ets:lookup(Tab, to_scene_grid_key(SceneId, Grid)) of
%       [] -> 
%           get_grid_player_infos(Tab, SceneId, T, AccList);
%       [#scene_grid{player_infos = P_list}] -> 
%           get_grid_player_infos(Tab, SceneId, T, P_list ++ AccList)
%   end;
% get_grid_player_infos(_, _, [], AccList) -> AccList.


%% @doc 取得一或多个场景格子内的玩家id列表
% get_grid_player_ids(Tab, SceneId, [Grid | T], AccList) ->
%     case ets:lookup(Tab, lib_scene:to_scene_grid_key(SceneId, Grid)) of
%         [] -> 
%             get_grid_player_ids(Tab, SceneId, T, AccList);
%         [#scene_grid{player_infos = P_list}] ->
%             PlayerIdList = [Id || {Id, _SendPid} <- P_list],
%             get_grid_player_ids(Tab, SceneId, T, PlayerIdList ++ AccList)
%     end;
% get_grid_player_ids(_, _, [], AccList) -> AccList.
    


%% @doc 取得一或多个场景格子内的玩家id列表
get_grid_player_ids(SceneId, [Grid | T], AccList) ->
    SceneGridKey = lib_scene:to_scene_grid_key(SceneId, Grid),
    case get_scene_grid_data(SceneGridKey) of
        null -> 
            get_grid_player_ids(SceneId, T, AccList);
        #scene_grid{player_infos = P_list} ->
            PlayerIdList = [Id || {Id, _SendPid} <- P_list],
            get_grid_player_ids(SceneId, T, PlayerIdList ++ AccList)
    end;
get_grid_player_ids(_SceneId, [], AccList) -> AccList.





