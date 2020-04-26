%%%-----------------------------------
%%% @Module  : lib_scene
%%% @Author  : huangjf, LDS
%%% @Email   : 
%%% @Created : 2011.05.08
%%% @Modified: 2013.6
%%% @Description: 场景对象的相关函数
%%%-----------------------------------
-module(lib_scene).
-export([
			get_obj/1,
			is_exists/1,

			get_id/1, get_no/1, get_no_by_id/1,
			get_type/1,
			% get_res_id/1,
			get_width/1, get_height/1,
			get_default_xy/1,

			is_reserve_scene_exists/1,
			get_reserve_scene_id/1,
			set_reserve_scene_id/2,

			is_xy_valid/3,
			to_server_xy_index/3,


			get_scene_player_list/1,
			get_scene_player_ids/1,
			get_scene_player_count/1,

			get_objs_of_scene/1,
			init_objs_of_scene_rd/1,
			del_objs_of_scene_rd_from_ets/1,

			get_scene_static_npc_ids/1, set_scene_static_npc_ids/2,
			get_scene_dynamic_npc_ids/1, add_to_scene_dynamic_npc_ids/2, del_from_scene_dynamic_npc_ids/2,
            get_scene_mon_ids/1, set_scene_mon_ids/2, add_to_scene_mon_ids/2, del_from_scene_mon_ids/2,
            get_scene_mon_count/1,


            get_dynamic_teleporter_list/1,
            add_to_scene_dynamic_teleporter_list/2,
            del_from_scene_dynamic_teleporter_list/2,

            get_trap_list/1,			

			% is_safe/1,
            is_blocked/3,
            is_bad_pos/3,
            is_trap_area/3,
            is_leitai_area/3,

			is_normal_scene/1,
			is_special_scene/1,
			is_copy_scene/1,
			is_noncopy_scene/1,
			is_reserve_scene/1,
			is_melee_scene/1,
			is_newyear_banquat_scene/1,
			is_home_scene/1,
			is_guild_dungeon_scene/1,

			add_scene_to_ets/1,
			del_scene_from_ets/1,
			update_scene_to_ets/1,

			to_scene_grid_key/1,
			to_scene_grid_key/2,

			% calc_grid_index/1,
   %      	calc_grid_index/3,
        	calc_grid_index/4,
        	% calc_grid_index_TOL/1,

        	calc_max_grid_index_X/1,
        	calc_max_grid_index_Y/1,
			delete_scene_mons/1,
			
			
			% decide_ets_scene_grid/1,
						

			% leave_old_scene_grid/3, leave_old_scene_grid/5,
			% enter_new_scene_grid/3, enter_new_scene_grid/5,
			add_to_scene_player_list/3,
			del_from_scene_player_list/2,
			del_scene_players_record_from_ets/1,
			

			notify_int_info_change_to_aoi/3, 			%% 通知玩家aoi范围的整形信息发生变化
			notify_string_info_change_to_aoi/2, 		%% 通知玩家aoi范围的字符串信息发生变化

			find_nearby_legal_pos/3
        ]).

-compile({inline,[
				get_id/1, get_no/1,
				get_width/1, get_height/1,
				to_scene_grid_key/1, to_scene_grid_key/2
				]
		}).

-include("common.hrl").
-include("record.hrl").
-include("player.hrl").
-include("scene.hrl").
-include("aoi.hrl").
-include("ets_name.hrl").
-include("pt_12.hrl").
-include("abbreviate.hrl").



%%%-define(MAX_PLAYERS_PICKED_EACH_GRID, 2).   % 每个九宫格最多选前5名玩家（以避免AOI大量广播的压力）



%% 从ets获取场景对象（依据场景唯一id）
%% @return: null | scene结构体
get_obj(SceneId) ->
	case ets:lookup(?ETS_SCENE, SceneId) of
		[] ->
			null;
		[SceneObj] ->
			SceneObj
	end.

%% 场景对象是否存在？（true | false）
is_exists(SceneId) ->
	ets:member(?ETS_SCENE, SceneId).



% 作废！！
% %% 判断是否有效的场景唯一id
% is_valid_scene_id(SceneId) ->
% 	get_obj(SceneId) /= null.


%% 获取场景唯一id
get_id(SceneObj) ->
	SceneObj#scene.id.

%% 获取场景编号
get_no(SceneObj) ->
	SceneObj#scene.no.

%% 获取场景编号（依据场景唯一id）
get_no_by_id(SceneId) ->
	case get_obj(SceneId) of
		null -> ?ASSERT(false, SceneId), ?INVALID_SCENE_NO;
		Scene -> Scene#scene.no
	end.

%% 获取场景类型
get_type(SceneObj) ->
	SceneObj#scene.type.

% %% 获取场景的资源id
% get_res_id(SceneObj) ->
% 	SceneObj#scene.res_id.

%% 获取场景的宽度
get_width(SceneObj) when is_record(SceneObj, scene) ->
	SceneObj#scene.width;

get_width(SceneTpl) ->
	SceneTpl#scene_tpl.width.

%% 获取场景的高度
get_height(SceneObj) when is_record(SceneObj, scene) ->
	SceneObj#scene.height;

get_height(SceneTpl) ->
	SceneTpl#scene_tpl.height.


% 暂时作废！！
% %% 依据场景唯一id获取场景的宽度
% %% @return：error | 宽度值 (注意：正常情况是不会出现返回null的情况，如果出现，说明其他地方有bug) 
% get_width_by_id(SceneId) ->
% 	case get_obj(SceneId) of
% 		null ->
% 			null;
% 		SceneObj ->
% 			SceneObj#scene.width
% 	end.

% %% 依据场景唯一id获取场景的高度
% %% @return：error | 高度值 (注意：正常情况是不会出现返回null的情况，如果出现，说明其他地方有bug) 
% get_height_by_id(SceneId) ->
% 	case get_obj(SceneId) of
% 		null ->
% 			null;
% 		SceneObj ->
% 			SceneObj#scene.height
% 	end.









add_scene_to_ets(NewScene) when is_record(NewScene, scene) ->
	?ASSERT(get_obj( get_id(NewScene)) == null, NewScene),
	ets:insert(?ETS_SCENE, NewScene).

del_scene_from_ets(SceneId) ->
	?ASSERT(is_integer(SceneId)),
    ets:delete(?ETS_SCENE, SceneId).

update_scene_to_ets(Scene_Latest) when is_record(Scene_Latest, scene) ->
	ets:insert(?ETS_SCENE, Scene_Latest).





%% 依据plyr_pos结构体组合成所在场景格子的key: {所在场景的唯一id， 所在场景格子的索引}
% to_scene_grid_key(PlayerPos) ->
% 	{PlayerPos#plyr_pos.scene_id, PlayerPos#plyr_pos.scene_grid_index}.
to_scene_grid_key(AoiPos) ->
	{AoiPos#aoi_pos.scene_id, AoiPos#aoi_pos.scene_grid_index}.

%% 组合成所在场景格子的key: {所在场景的唯一id， 所在场景格子的索引}
to_scene_grid_key(SceneId, SceneGridIdx) ->
	?ASSERT(is_integer(SceneId), SceneId),
	?ASSERT(is_tuple(SceneGridIdx), SceneGridIdx),
	{SceneId, SceneGridIdx}.

	


%% 计算场景某坐标对应所属的场景格子的索引（索引为二维的{Grid_X, Grid_Y}形式）
%% @para: PlayerPos => 玩家的位置，plyr_pos结构体
%% @return: {Grid_X, Grid_Y}
% calc_grid_index(PlayerPos) ->
%     SceneId = PlayerPos#plyr_pos.scene_id,
%     X = PlayerPos#plyr_pos.x,
%     Y = PlayerPos#plyr_pos.y,
%     SceneObj = lib_scene:get_obj(SceneId),
%     ?ASSERT(SceneObj /= null, SceneId),
%     calc_grid_index(lib_scene:get_width(SceneObj), lib_scene:get_height(SceneObj), X, Y).


% calc_grid_index(SceneId, X, Y) ->
%     SceneObj = lib_scene:get_obj(SceneId),
%     ?ASSERT(SceneObj /= null, {SceneId, erlang:get_stacktrace()}),
%     calc_grid_index(lib_scene:get_width(SceneObj), lib_scene:get_height(SceneObj), X, Y).



%% @doc 计算场景某坐标对应所属的场景格子的索引（索引为二维的{Grid_X, Grid_Y}形式）
%% @spec calc_grid_index(Width::Integer(), Height::Integer, X::Integer(), Y::Integer()) -> {Grid_X, Grid_Y}
%% @end
%% 注意：场景格子索引是从1开始，
%%       但X、Y坐标是从0开始索引（为了和客户端一致），而不是1
calc_grid_index(SceneWidth, SceneHeight, X, Y) ->
    Grid_X = 
        case ?CUT_GRID_WIDTH =< SceneWidth of
            true -> 
                calc_grid_index_X(SceneWidth, X);  %%%cut(Width, X, ?GRID_WIDTH);
            false ->
                ?DEFAULT_GRID
        end,
    Grid_Y = 
        case ?CUT_GRID_HEGIHT =< SceneHeight of
            true ->
                calc_grid_index_Y(SceneHeight, Y);  %%%cut(Height, Y, ?GRID_HEIGHT);
            false ->
                ?DEFAULT_GRID
        end,
    {Grid_X, Grid_Y}.

    
% %% TOL: tolerant，表示此函数是包含了容错处理的版本
% %% @return: {Grid_X, Grid_Y} | invalid
% calc_grid_index_TOL(PlayerPos) ->
%     SceneId = PlayerPos#plyr_pos.scene_id,
%     X = PlayerPos#plyr_pos.x,
%     Y = PlayerPos#plyr_pos.y,
%     case lib_scene:get_obj(SceneId) of
%         null ->  % 容错，返回invalid
%             invalid;
%         SceneObj ->
%             calc_grid_index(lib_scene:get_width(SceneObj), lib_scene:get_height(SceneObj), X, Y)
%     end.

%% @doc 是否需要对地图进行切割
%% @spec can_cut(Width::Integer(), Height::Integer()) -> true | false 
%% @end 
% can_cut(Width, Height) -> 
%   ?CUT_GRID_WIDTH =< Width orelse ?CUT_GRID_HEGIHT =< Height.


% %% @doc Accroding to the cut_factor to calculate the Length's seq in the T_Length
% %% @mark use config data to replace 
% %% @spec cut(T_Length::Integer(), Length:Integer(), Factor::Integer()) -> Seq::Integer()
% %% @end
% cut(T_Length, Length, Factor) when T_Length >= Factor ->
%     Limit = T_Length div Factor,
%     Seq = (Length div Factor) + 1,
%     erlang:min(Limit, Seq);
% cut(_, _, _) ->
%     ?DEFAULT_GRID.

calc_max_grid_index_X(SceneWidth) ->
	erlang:max(SceneWidth div ?GRID_WIDTH, ?GRID_SEQ_START).

calc_max_grid_index_Y(SceneHeight) ->
	erlang:max(SceneHeight div ?GRID_HEIGHT, ?GRID_SEQ_START).
		



calc_grid_index_X(SceneWidth, X) when SceneWidth > ?GRID_WIDTH ->
    Limit = calc_max_grid_index_X(SceneWidth),
    Seq = (X div ?GRID_WIDTH) + 1,
    erlang:min(Limit, Seq);
calc_grid_index_X(_, _) ->
    ?GRID_SEQ_START.


calc_grid_index_Y(SceneHeight, Y) when SceneHeight > ?GRID_HEIGHT ->
    Limit = calc_max_grid_index_Y(SceneHeight),
    Seq = (Y div ?GRID_HEIGHT) + 1,
    erlang:min(Limit, Seq);
calc_grid_index_Y(_, _) ->
    ?GRID_SEQ_START.





% %% 判断是否为安全场景
% is_safe(SceneId) when is_integer(SceneId) ->
% 	case get_obj(SceneId) of
% 		null ->
% 			?ASSERT(false, SceneId),
% 			false;
% 		SceneObj ->
% 			SceneObj#scene.is_safe
% 	end;
% is_safe(SceneObj) ->
% 	SceneObj#scene.is_safe.




%% 判断是否普通场景
%% @return: true | false
is_normal_scene(SceneObj) when is_record(SceneObj, scene) ->
	lists:member(SceneObj#scene.type, ?NORMAL_SCENE_TYPE_LIST);
is_normal_scene(SceneId) when is_integer(SceneId) ->
	case get_obj(SceneId) of
		null ->
			?ASSERT(false, SceneId),
			false;
		SceneObj ->
			is_normal_scene(SceneObj)
	end.

%% 是否为女妖乱斗活动的场景？
is_melee_scene(SceneObj) when is_record(SceneObj, scene) ->
	get_type(SceneObj) == ?SCENE_T_MELEE;
is_melee_scene(SceneId) when is_integer(SceneId) ->
	case get_obj(SceneId) of
		null ->
			?ASSERT(false, SceneId),
			false;
		SceneObj ->
			is_melee_scene(SceneObj)
	end.

%% 是否为新年宴会活动的场景？
is_newyear_banquat_scene(SceneObj) when is_record(SceneObj, scene) ->
	get_type(SceneObj) == ?SCENE_T_NEWYEAR;
is_newyear_banquat_scene(SceneId) when is_integer(SceneId) ->
	case get_obj(SceneId) of
		null ->
			?ASSERT(false, SceneId),
			false;
		SceneObj ->
			is_newyear_banquat_scene(SceneObj)
	end.

%% TODO: 判断是否特殊场景
is_special_scene(_SceneId) ->
	todo_here.


%% 是否家园场景
is_home_scene(SceneObj) when is_record(SceneObj, scene) ->
	get_no(SceneObj) == data_special_config:get('home_map');
is_home_scene(SceneId) when is_integer(SceneId) ->
	get_no_by_id(SceneId) == data_special_config:get('home_map').

%%是否帮派副本场景
is_guild_dungeon_scene(SceneId) when is_integer(SceneId) ->
	MapNo = get_no_by_id(SceneId),
	lists:member(MapNo, [7001,7002,7003,7004]).

%% 获取场景内的所有玩家列表
%% @return: [] | scene_ply结构体列表
get_scene_player_list(SceneId) ->
	case ets:lookup(?ETS_SCENE_PLAYERS, SceneId) of
		[] ->
			[];
		[ScenePlayers] ->
			ScenePlayers#scene_players.player_list
	end.


%% 获取场景内的所有玩家id列表
get_scene_player_ids(SceneId) ->
	case ets:lookup(?ETS_SCENE_PLAYERS, SceneId) of
		[] ->
			[];
		[ScenePlayers] ->
			[X#scene_ply.id || X <- ScenePlayers#scene_players.player_list]
	end.

%% 获取场景内的玩家数量
get_scene_player_count(SceneId) ->
	case ets:lookup(?ETS_SCENE_PLAYERS, SceneId) of
		[] ->
			0;
		[ScenePlayers] ->
			ScenePlayers#scene_players.player_count
	end.






%% 获取场景中的对象记录信息
get_objs_of_scene(SceneId) ->
	case ets:lookup(?ETS_OBJS_OF_SCENE, SceneId) of
		[] -> null;
		[R] -> R
	end.


init_objs_of_scene_rd(SceneId) ->
	?ASSERT(get_objs_of_scene(SceneId) == null, SceneId),
	ets:insert(?ETS_OBJS_OF_SCENE, #objs_of_scene{scene_id = SceneId}).


update_objs_of_scene_rd_to_ets(R) when is_record(R, objs_of_scene) ->
	ets:insert(?ETS_OBJS_OF_SCENE, R).


del_objs_of_scene_rd_from_ets(SceneId) ->
	ets:delete(?ETS_OBJS_OF_SCENE, SceneId),
	?ASSERT(get_objs_of_scene(SceneId) == null),
	void.



%% 获取场景内静态NPC的id列表
get_scene_static_npc_ids(SceneId) when is_integer(SceneId) ->
	case get_objs_of_scene(SceneId) of
		null ->
			?ASSERT(false, SceneId),
			[];
		R ->
			R#objs_of_scene.static_npcs
	end;
get_scene_static_npc_ids(R) ->
	R#objs_of_scene.static_npcs.


%% 设置场景内静态NPC的id列表
set_scene_static_npc_ids(SceneId, NpcIdList) ->
	?ASSERT(is_integer(SceneId)),
	?ASSERT(is_list(NpcIdList)),
	case get_objs_of_scene(SceneId) of
		null ->
			?ASSERT(false, SceneId),
			skip;
		R ->
			R2 = R#objs_of_scene{static_npcs = NpcIdList},
			update_objs_of_scene_rd_to_ets(R2)
	end.




%% 获取场景内动态NPC的id列表
get_scene_dynamic_npc_ids(SceneId) when is_integer(SceneId) ->
	case get_objs_of_scene(SceneId) of
		null ->
			?ASSERT(false, SceneId),
			[];
		R ->
			R#objs_of_scene.dynamic_npcs
	end;
get_scene_dynamic_npc_ids(R) ->
	R#objs_of_scene.dynamic_npcs.

% 作废！！
% %% 设置场景内动态NPC的id列表
% set_scene_dynamic_npc_ids(SceneId, DynamicNpcIdList) when is_integer(SceneId), is_list(DynamicNpcIdList) ->
% 	case get_obj(SceneId) of
% 		null ->
% 			?ASSERT(false, SceneId),
% 			skip;
% 		SceneObj ->
% 			SceneObj2 = SceneObj#scene{dynamic_npcs = DynamicNpcIdList},
% 			update_scene_to_ets(SceneObj2)
% 	end;
% set_scene_dynamic_npc_ids(SceneObj, DynamicNpcIdList) when is_record(SceneObj, scene) ->
% 	SceneObj2 = SceneObj#scene{dynamic_npcs = DynamicNpcIdList},
% 	update_scene_to_ets(SceneObj2).





add_to_scene_dynamic_npc_ids(SceneId, NpcId) ->
    % OldList = lib_scene:get_scene_dynamic_npc_ids(SceneId),
    % ?ASSERT(not lists:member(NewDynamicNpcId, OldList), {NewDynamicNpcId, lib_scene:get_id(SceneObj), OldList}),
    % NewList = [NewDynamicNpcId | OldList],
    % lib_scene:set_scene_dynamic_npc_ids(SceneObj, NewList).

    case get_objs_of_scene(SceneId) of
		null ->
			?ASSERT(false, {SceneId, NpcId}),
			skip;
		R ->
			OldList = R#objs_of_scene.dynamic_npcs,
		    ?ASSERT(not lists:member(NpcId, OldList), {NpcId, SceneId, OldList}),
		    NewList = [NpcId | OldList],
		    R2 = R#objs_of_scene{dynamic_npcs = NewList},
		    update_objs_of_scene_rd_to_ets(R2)
	end.


del_from_scene_dynamic_npc_ids(SceneId, NpcId) ->
    case get_objs_of_scene(SceneId) of
		null ->
			?ASSERT(false, {SceneId, NpcId}),
			skip;
		R ->
			OldList = R#objs_of_scene.dynamic_npcs,
		    ?ASSERT(lists:member(NpcId, OldList), {NpcId, SceneId, OldList, erlang:get_stacktrace()}),
		    NewList = OldList -- [NpcId],
		    R2 = R#objs_of_scene{dynamic_npcs = NewList},
		    update_objs_of_scene_rd_to_ets(R2)
	end.







%% 获取场景内的明雷怪id列表
get_scene_mon_ids(SceneId) when is_integer(SceneId) ->
	case get_objs_of_scene(SceneId) of
		null ->
			?ASSERT(false, SceneId),
			[];
		R ->
			R#objs_of_scene.mons
	end;
get_scene_mon_ids(R) ->
	R#objs_of_scene.mons.

%% 设置场景内的明雷怪id列表
set_scene_mon_ids(SceneId, MonIdList) ->
	?ASSERT(is_integer(SceneId)),
	?ASSERT(is_list(MonIdList)),
	case get_objs_of_scene(SceneId) of
		null ->
			?ASSERT(false, SceneId),
			skip;
		R ->
			R2 = R#objs_of_scene{mons = MonIdList},
			update_objs_of_scene_rd_to_ets(R2)
	end.

% set_scene_mon_ids(SceneObj, MonIdList) when is_record(SceneObj, scene) ->
% 	SceneId = get_id(SceneObj),
% 	set_scene_mon_ids(SceneId, MonIdList).

	% SceneObj2 = SceneObj#scene{mons = MonIdList},
	% update_scene_to_ets(SceneObj2).

delete_scene_mons(SceneId) ->
	Lists = get_scene_mon_ids(SceneId),
	F = fun(X) ->
			del_from_scene_mon_ids(SceneId, X)
		end,
	lists:foreach(F, Lists).


add_to_scene_mon_ids(SceneId, MonId) ->
	case get_objs_of_scene(SceneId) of
		null ->
			?ASSERT(false, {SceneId, MonId}),
			skip;
		R ->
			OldList = R#objs_of_scene.mons,
		    ?ASSERT(not lists:member(MonId, OldList), {MonId, SceneId, OldList}),
		    NewList = [MonId | OldList],
		    R2 = R#objs_of_scene{mons = NewList},
		    update_objs_of_scene_rd_to_ets(R2)
	end.


del_from_scene_mon_ids(SceneId, MonId) ->
    case get_objs_of_scene(SceneId) of
		null ->
			?ASSERT(false, {SceneId, MonId}),
			skip;
		R ->
			OldList = R#objs_of_scene.mons,
		    ?ASSERT(lists:member(MonId, OldList), {MonId, SceneId, OldList, erlang:get_stacktrace()}),
		    NewList = OldList -- [MonId],
		    R2 = R#objs_of_scene{mons = NewList},
		    update_objs_of_scene_rd_to_ets(R2)
	end.


%% 获取场景内的明雷怪数量
get_scene_mon_count(SceneId) ->
	length( get_scene_mon_ids(SceneId) ).


%% 获取场景对象中的动态传送点列表
get_dynamic_teleporter_list(SceneId) when is_integer(SceneId) ->
	case get_objs_of_scene(SceneId) of
		null ->
			?ASSERT(false, SceneId),
			[];
		R ->
			R#objs_of_scene.dynamic_teleports
	end;
get_dynamic_teleporter_list(R) ->
	R#objs_of_scene.dynamic_teleports.

% 作废！！
% %% 设置场景对象中的动态传送点列表
% set_dynamic_teleporter_list(SceneObj, TeleporterList) ->
% 	?ASSERT(is_list(TeleporterList)),
% 	SceneObj2 = SceneObj#scene{dynamic_teleports = TeleporterList},
% 	update_scene_to_ets(SceneObj2).


add_to_scene_dynamic_teleporter_list(SceneId, Teleporter) ->
    % OldList = lib_scene:get_dynamic_teleporter_list(SceneId),
    % NewList = [NewTeleporter | OldList],
    % lib_scene:set_dynamic_teleporter_list(SceneObj, NewList).

    ?ASSERT(is_record(Teleporter, teleporter), Teleporter),
    case get_objs_of_scene(SceneId) of
		null ->
			?ASSERT(false, {SceneId, Teleporter}),
			skip;
		R ->
			OldList = R#objs_of_scene.dynamic_teleports,
		    ?ASSERT(not lists:member(Teleporter, OldList), {Teleporter, SceneId, OldList}),
		    NewList = [Teleporter | OldList],
		    R2 = R#objs_of_scene{dynamic_teleports = NewList},
		    update_objs_of_scene_rd_to_ets(R2)
	end.


%% 
del_from_scene_dynamic_teleporter_list(SceneId, Teleporter) ->
    ?ASSERT(is_record(Teleporter, teleporter)),
    % OldList = lib_scene:get_dynamic_teleporter_list(SceneId),
    % ?ASSERT(lists:member(Teleporter, OldList), {Teleporter, OldList, SceneObj}),
    % NewList = OldList -- [Teleporter],
    % lib_scene:set_dynamic_teleporter_list(SceneObj, NewList).

    case get_objs_of_scene(SceneId) of
		null ->
			?ASSERT(false, {SceneId, Teleporter}),
			skip;
		R ->
			OldList = R#objs_of_scene.dynamic_teleports,
		    ?ASSERT(lists:member(Teleporter, OldList), {Teleporter, SceneId, OldList, erlang:get_stacktrace()}),
		    NewList = OldList -- [Teleporter],
		    R2 = R#objs_of_scene{dynamic_teleports = NewList},
		    update_objs_of_scene_rd_to_ets(R2)
	end.






%% 获取场景的暗雷列表
%% @return: [] | [Trap1, Trap2, ...]
get_trap_list(SceneObj) ->
	SceneNo = get_no(SceneObj),
	data_scene_trap:get(SceneNo).




% %% 剧情
% plot(_Scene, PS) ->
% % 	{PlotId, PS1} =
% % 	case Scene of
% % 		101 ->
% % 			if PS#player_status.film == 0 ->
% % %% 				   {99,PS#player_status{film = 1}};
% % 				   {0,PS#player_status{film = 1}};
% % 			   true ->
% % 				   {0,PS}
% % 			end;
% % 		102 ->
% % 			case  PS#player_status.film == 1   andalso lib_task:in_trigger(?PLOT_TASK, PS#player_status.id) of
% % 				true ->
% % %% 					{97,PS#player_status{film = 2}};
% % 					{0, PS#player_status{film = 2}};
% % 				false ->
% % 					{0, PS}
% % 			end;
% % 		_ ->
% % 			{0, PS}
% % 	end,
% % 	if PlotId =/= 0 ->
% % 	   		db:update(player, ["film"], [PS1#player_status.film], "id", PS1#player_status.id);
% % 	   true ->
% % 		   skip
% % 	end,
% % 	{PlotId, PS1}.

% 	{0,PS}.
				
    
	


%% 获取场景的默认起始位置
get_default_xy(SceneObj) when is_record(SceneObj, scene)-> 
	todo_here,
	{18, 15};
get_default_xy(_SceneId) -> 
	todo_here,
	{18, 15}.




%% 后备场景是否存在？（true | false）
is_reserve_scene_exists(SceneId) ->
	case ets:lookup(?ETS_MAP_OF_SCENE_TO_RESERVE_SCENE, SceneId) of
		[] ->
			false;
		[{SceneId, _ReserveSceneId}] ->
			true
	end.

%% 获取后备场景id
get_reserve_scene_id(SceneId) ->
	case ets:lookup(?ETS_MAP_OF_SCENE_TO_RESERVE_SCENE, SceneId) of
		[] ->
			?INVALID_ID;
		[{SceneId, ReserveSceneId}] ->
			ReserveSceneId
	end.

%% 设置后备场景id
set_reserve_scene_id(SceneId, ReserveSceneId) ->
	?ASSERT(get_reserve_scene_id(SceneId) == ?INVALID_ID),
    ets:insert(?ETS_MAP_OF_SCENE_TO_RESERVE_SCENE, {SceneId, ReserveSceneId}).



%% 是否为拷贝场景？（注：副本场景属于拷贝场景的一种）
is_copy_scene(SceneId) when is_integer(SceneId) ->
    SceneId >= ?COPY_SCENE_START_ID;
    
is_copy_scene(SceneObj) when is_record(SceneObj, scene) ->
    get_id(SceneObj) >= ?COPY_SCENE_START_ID.



%% 是否为非拷贝场景？
is_noncopy_scene(SceneId_Or_SceneObj) ->
	not is_copy_scene(SceneId_Or_SceneObj).



%% 是否为后备场景？（true | false）
is_reserve_scene(SceneId) ->
	L = ets:tab2list(?ETS_MAP_OF_SCENE_TO_RESERVE_SCENE),
	lists:keymember(SceneId, 2, L).


% %% 是否为副本场景，唯一id，会检查是否存在这个场景
% %% 注意：目前此接口认为帮派驻地并不是副本场景！！
% is_dungeon_scene(SceneId) when is_integer(SceneId) ->
%     case is_copy_scene(SceneId) of
%         false -> false;
%         true ->
%             case get_obj(SceneId) of
%                 null -> false;
%                 SceneObj -> is_dungeon_scene(SceneObj)
%             end
%     end;
% is_dungeon_scene(SceneObj) when is_record(SceneObj, scene) ->
% 	SceneObj#scene.type == ?SCENE_T_DUNGEON;
% is_dungeon_scene(_Arg) ->
% 	?ASSERT(false, _Arg),
% 	false.
	




%% 判断坐标是否合法？
is_xy_valid(SceneObj, X, Y) ->
	?ASSERT(is_record(SceneObj, scene)),
	Width = get_width(SceneObj),
	Height = get_height(SceneObj),
	(X >= ?X_START) andalso (X < Width) andalso (Y >= ?Y_START) andalso (Y < Height).




to_server_xy_index(SceneObj, X, Y) when is_record(SceneObj, scene) ->
	Y * get_width(SceneObj) + X + 1;

to_server_xy_index(SceneTpl, X, Y) when is_record(SceneTpl, scene_tpl) ->
    Y * SceneTpl#scene_tpl.width + X + 1.




%% 判断场景的某位置是否有阻挡
%% @para: SceneId => 场景唯一id（注意：不是场景编号！！）
%% @return: true | false
is_blocked(SceneId, X, Y) when is_integer(SceneId) ->
	case get_obj(SceneId) of
		null ->
			% ?ASSERT(false, SceneId),
			true;   % 非法情况默认为有阻挡，下同
		SceneObj ->
			is_blocked(SceneObj, X, Y)
	end;
%% @para: SceneObj => 场景对象(存于ets中)，为scene结构体
is_blocked(SceneObj, X, Y) when is_record(SceneObj, scene) ->
 	case is_xy_valid(SceneObj, X, Y) of
 		false ->
 			% ?ASSERT(false, {get_no(SceneObj), X, Y}),
 			true;
 		true ->
 			Index = to_server_xy_index(SceneObj, X, Y),
 			Mask = data_mask:get(get_no(SceneObj)),
 			BlockType = erlang:element(Index, Mask),
 			(BlockType == ?BLOCK_T_NORMAL) orelse (BlockType == ?BLOCK_T_WATER)
 	end.


%% 是否非法位置？
is_bad_pos(SceneId, X, Y) when is_integer(SceneId) ->
	(SceneId == ?INVALID_ID)
  	orelse (not is_exists(SceneId))
  	orelse is_blocked(SceneId, X, Y);

is_bad_pos(SceneObj, X, Y) when is_record(SceneObj, scene) ->
	is_blocked(SceneObj, X, Y).





%% 判断场景的某位置是否为暗雷区
%% @para: SceneId => 场景唯一id（注意：不是场景编号！！）
%% @return: true | false
is_trap_area(SceneId, X, Y) when is_integer(SceneId) ->
	case get_obj(SceneId) of
		null ->
			?ASSERT(false, SceneId),
			false;
		SceneObj ->
			is_trap_area(SceneObj, X, Y)
	end;
%% @para: SceneObj => 场景对象(存于ets中)，为scene结构体
is_trap_area(SceneObj, X, Y) when is_record(SceneObj, scene) ->
	case is_xy_valid(SceneObj, X, Y) of
 		false ->
 			?ASSERT(false, {get_no(SceneObj), X, Y}),
 			false;
 		true ->
 			get_block_type(SceneObj, X, Y) == ?BLOCK_T_TRAP
 	end.



%% 判断场景的某位置是否为擂台去
%% @para: SceneId => 场景唯一id（注意：不是场景编号！！）
%% @return: true | false
is_leitai_area(SceneId, X, Y) when is_integer(SceneId) ->
	case get_obj(SceneId) of
		null ->
			?ASSERT(false, SceneId),
			false;
		SceneObj ->
			is_leitai_area(SceneObj, X, Y)
	end;
%% @para: SceneObj => 场景对象(存于ets中)，为scene结构体
is_leitai_area(SceneObj, X, Y) when is_record(SceneObj, scene) ->
	case is_xy_valid(SceneObj, X, Y) of
 		false ->
 			?ASSERT(false, {get_no(SceneObj), X, Y}),
 			false;
 		true ->
 			get_block_type(SceneObj, X, Y) == ?BLOCK_T_LEITAI
 	end.



get_block_type(SceneObj, X, Y) ->
	Index = to_server_xy_index(SceneObj, X, Y),
 	Mask = data_mask:get(get_no(SceneObj)),
 	BlockType = erlang:element(Index, Mask),
 	BlockType.




% %% (依据场景id)获取场景对应的场景格子ets表名
% decide_ets_scene_grid(SceneId) ->
% 	Remainder = SceneId rem ?ETS_SCENE_GRID_COUNT,
% 	case Remainder < ?HALF_ETS_SCENE_GRID_COUNT of
% 		true ->
% 			case Remainder < ?ONE_QUARTER_ETS_SCENE_GRID_COUNT of
% 				true ->
% 					case Remainder of
% 						0 -> ?ETS_SCENE_GRID_1;
% 						1 -> ?ETS_SCENE_GRID_2;
% 						2 -> ?ETS_SCENE_GRID_3;
% 						3 -> ?ETS_SCENE_GRID_4;
% 						4 -> ?ETS_SCENE_GRID_5;
% 						5 -> ?ETS_SCENE_GRID_6;
% 						6 -> ?ETS_SCENE_GRID_7;
% 						7 -> ?ETS_SCENE_GRID_8
% 					end;
% 				false ->
% 					case Remainder of
% 						8 -> ?ETS_SCENE_GRID_9;
% 						9 -> ?ETS_SCENE_GRID_10;
% 						10 -> ?ETS_SCENE_GRID_11;
% 						11 -> ?ETS_SCENE_GRID_12;
% 						12 -> ?ETS_SCENE_GRID_13;
% 						13 -> ?ETS_SCENE_GRID_14;
% 						14 -> ?ETS_SCENE_GRID_15;
% 						15 -> ?ETS_SCENE_GRID_16
% 					end
% 			end;
% 		false ->
% 			case Remainder < ?THREE_QUARTER_ETS_SCENE_GRID_COUNT of
% 				true ->
% 					case Remainder of
% 						16 -> ?ETS_SCENE_GRID_17;
% 						17 -> ?ETS_SCENE_GRID_18;
% 						18 -> ?ETS_SCENE_GRID_19;
% 						19 -> ?ETS_SCENE_GRID_20;
% 						20 -> ?ETS_SCENE_GRID_21;
% 						21 -> ?ETS_SCENE_GRID_22;
% 						22 -> ?ETS_SCENE_GRID_23;
% 						23 -> ?ETS_SCENE_GRID_24
% 					end;
% 				false ->
% 					case Remainder of
% 						24 -> ?ETS_SCENE_GRID_25;
% 						25 -> ?ETS_SCENE_GRID_26;
% 						26 -> ?ETS_SCENE_GRID_27;
% 						27 -> ?ETS_SCENE_GRID_28;
% 						28 -> ?ETS_SCENE_GRID_29;
% 						29 -> ?ETS_SCENE_GRID_30;
% 						30 -> ?ETS_SCENE_GRID_31;
% 						31 -> ?ETS_SCENE_GRID_32
% 					end
% 			end	
% 	end.


				









			




%% 添加玩家到场景对象所记录的玩家列表
add_to_scene_player_list(SceneId, PlayerId, SceneLine) ->
	R = #scene_ply{
			id = PlayerId, 
			scene_line = SceneLine
			},
	case ets:lookup(?ETS_SCENE_PLAYERS, SceneId) of
		[] ->
			NewScenePlayersRd = #scene_players{
									scene_id = SceneId,
									player_count = 1,
									player_list = [R]
									},
			true = ets:insert_new(?ETS_SCENE_PLAYERS, NewScenePlayersRd);
		[ScenePlayers] ->
			case lists:keymember(PlayerId, #scene_ply.id, ScenePlayers#scene_players.player_list) of
				true ->
					% ?ASSERT(false, {SceneId, PlayerId, player:get_position(PlayerId), ets:tab2list(?ETS_SCENE_PLAYERS)}),
					?ERROR_MSG("[lib_scene] add_to_scene_player_list() error!! SceneId:~p, PlayerId:~p", [SceneId, PlayerId]),
					skip;
				false ->
					NewPlayerCount = ScenePlayers#scene_players.player_count + 1,
					NewPlayerList = [R | ScenePlayers#scene_players.player_list],
					?ASSERT(length(NewPlayerList) == NewPlayerCount),
					ets:insert(?ETS_SCENE_PLAYERS, ScenePlayers#scene_players{
															player_count = NewPlayerCount,
															player_list = NewPlayerList
															})
			end	
	end.

%% 从场景对象所记录的玩家列表删除指定玩家
del_from_scene_player_list(SceneId, PlayerId) ->
	case ets:lookup(?ETS_SCENE_PLAYERS, SceneId) of
		[] ->
			skip;
		[ScenePlayers] ->
			case lists:keymember(PlayerId, #scene_ply.id, ScenePlayers#scene_players.player_list) of
				false ->
					% ?ASSERT(false, {SceneId, PlayerId, player:get_position(PlayerId), ets:tab2list(?ETS_SCENE_PLAYERS)}),
					?ERROR_MSG("[lib_scene] del_from_scene_player_list() error!! SceneId:~p, PlayerId:~p", [SceneId, PlayerId]),
					skip;
				true ->
					NewPlayerCount = erlang:max(ScenePlayers#scene_players.player_count - 1, 0),  % 保险起见，做至少为0的矫正
					NewPlayerList = lists:keydelete(PlayerId, #scene_ply.id, ScenePlayers#scene_players.player_list),
					?ASSERT(length(NewPlayerList) == NewPlayerCount),
					ets:insert(?ETS_SCENE_PLAYERS, ScenePlayers#scene_players{
															player_count = NewPlayerCount,
															player_list = NewPlayerList
															})
			end	
	end.


%% 从ETS_SCENE_PLAYERS删除整个的场景玩家记录
del_scene_players_record_from_ets(SceneId) ->
	ets:delete(?ETS_SCENE_PLAYERS, SceneId).

%% 作废！！
% %% 从ETS_SCENE_GRID删除场景对应的所有九宫格记录
% del_scene_grid_records_from_ets(SceneId) ->
% 	ets:match_delete(?ETS_SCENE_GRID(SceneId), #scene_grid{key = {SceneId, '_'}, _ = '_'}).


% %% 刷新npc任务状态
% refresh_npc_ico(Rid) when is_integer(Rid)->
%     case player:get_online_info_fields(Rid, [pid]) of
%         [] -> ok;
%         [Pid] ->
%             gen_server:cast(Pid, {cast, {?MODULE, refresh_npc_ico, []}})
%     end;
        
% refresh_npc_ico(Status) ->
%     NpcList = get_scene_npc_ids(Status#player_status.scene_id),
%     L = [[NpcId, lib_task:get_npc_state(NpcId, Status)]|| [NpcId | _] <- NpcList],
%     {ok, BinData} = pt_12:write(12020, [L]),
%     lib_send:send_to_sock(Status, BinData).

%% 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



notify_int_info_change_to_aoi(player, PlayerId, KV_TupleList) ->
	?ASSERT(is_integer(PlayerId)),
	case player:is_online(PlayerId) of
		false -> skip;
		true ->
			{ok, BinData} = pt_12:write(?PT_NOTIFY_OBJ_AOI_INFO_CHANGE1, [?OBJ_PLAYER, PlayerId, KV_TupleList]),
		    lib_send:send_to_AOI(PlayerId, BinData)
	end;

notify_int_info_change_to_aoi(npc, NpcObj, KV_TupleList) ->
	NpcId = mod_npc:get_id(NpcObj),
	{ok, BinData} = pt_12:write(?PT_NOTIFY_OBJ_AOI_INFO_CHANGE1, [?OBJ_NPC, NpcId, KV_TupleList]),

	SceneId = mod_npc:get_scene_id(NpcObj),
	{X, Y} = mod_npc:get_xy(NpcObj),
	lib_send:send_to_AOI({SceneId, X, Y}, BinData).
	



notify_string_info_change_to_aoi(PlayerId, KV_TupleList) ->
	case player:is_online(PlayerId) of
		false -> skip;
		true ->
			{ok, BinData} = pt_12:write(?PT_NOTIFY_PLAYER_AOI_INFO_CHANGE2, [PlayerId, KV_TupleList]),
		    lib_send:send_to_AOI(PlayerId, BinData)
	end.



-define(FIND_RADIUS, 10).

%% 查找附近的一个合法位置
%% @return：{ok, {NearbyX, NearbyY}} | fail
find_nearby_legal_pos(SceneId, X, Y) ->
	case get_obj(SceneId) of
		null ->
			fail;
		SceneObj ->
			MinX = max(X - ?FIND_RADIUS, ?X_START),
			MaxX = max(X + ?FIND_RADIUS, ?X_START),
			MinY = max(Y - ?FIND_RADIUS, ?Y_START),
			MaxY = max(Y + ?FIND_RADIUS, ?Y_START),

			FindStartX = MinX,
			FindStartY = MinY,
			find_nearby_legal_pos__(SceneObj, FindStartX, FindStartY, {MinX, MaxX, MinY, MaxY})
	end.


find_nearby_legal_pos__(SceneObj, CurX, CurY, {MinX, MaxX, MinY, MaxY}) when CurX > MaxX ->
	FindStartX = MinX,
	find_nearby_legal_pos__(SceneObj, FindStartX, CurY+1, {MinX, MaxX, MinY, MaxY});

find_nearby_legal_pos__(_SceneObj, _CurX, CurY, {_MinX, _MaxX, _MinY, MaxY}) when CurY > MaxY ->
	fail;

find_nearby_legal_pos__(SceneObj, CurX, CurY, {MinX, MaxX, MinY, MaxY}) ->
	case is_bad_pos(SceneObj, CurX, CurY) of
		true ->
			find_nearby_legal_pos__(SceneObj, CurX+1, CurY, {MinX, MaxX, MinY, MaxY});
		false ->
			{ok, {CurX, CurY}}
	end.





	



%% ====================================================================
%% Internal functions
%% ====================================================================




