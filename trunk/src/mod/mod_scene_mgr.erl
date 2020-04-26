%%%------------------------------------
%%% @Module  : mod_scene_mgr
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2011.05.13
%%% @Modified: 2013.6.16  -- huangjf
%%% @Description: 场景管理
%%%------------------------------------
-module(mod_scene_mgr).
-behaviour(gen_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([
        start_link/0, 
        
        create_scene/1,
        clear_scene/1,

        add_to_scene_mon_id_list/2,
        add_to_scene_dynamic_npc_id_list/2,
        add_to_scene_dynamic_teleporter_list/2,

        add_to_scene_player_list/3,
        del_from_scene_player_list/2,

        clear_mon_from_scene/1,
        clear_mon_from_scene_WNC/1,

        clear_dynamic_npc_from_scene/1,
        clear_dynamic_npc_from_scene_WNC/1,

        clear_dynamic_teleporter_from_scene_WNC/1,

        restart_go_proc/1,
        force_clear_dynamic_npc_from_scene_WNC/1,

        create_reserve_scene/1
        ]).

-include("common.hrl").
-include("record.hrl").
-include("scene.hrl").
-include("monster.hrl").
-include("ets_name.hrl").
-include("npc.hrl").
-include("pt_12.hrl").
-include("abbreviate.hrl").

-record(state, {
            % auto_scene_id = ?COPY_SCENE_START_ID   % 自动递增的场景唯一id（以拷贝场景的起始id为起始点，以避免和普通场景的id冲突!）
        }).





start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).
    

%% 创建场景
%% @para: SceneNo => 场景编号
%% @return：fail | {ok, NewSceneId}
create_scene(SceneNo) ->
    case catch gen_server:call(?MODULE, {'create_scene', SceneNo}) of
        {'EXIT', Reason} ->
            ?ERROR_MSG("[mod_scene_mgr] create_scene failed!! SceneNo:~p, Reason: ~w", [SceneNo, Reason]),
            ?ASSERT(false, {SceneNo, Reason}),
            fail;
        fail ->
            fail;
        {ok, NewSceneId} when is_integer(NewSceneId) ->
            {ok, NewSceneId}
    end.




% %% 获取下一个有效的场景id
% %% @return: fail | {ok, NewSceneId}
% get_next_id()->
%     case catch gen_server:call(?MODULE, 'get_next_id') of
%         {'EXIT', Reason} ->
%             ?ERROR_MSG("[mod_scene_mgr] get_next_id() failed!! Reason: ~w", [Reason]),
%             ?ASSERT(false, Reason),
%             fail;
%         NewSceneId when is_integer(NewSceneId) ->
%             {ok, NewSceneId}
%     end.


%% 清除场景
clear_scene(SceneId) ->
    gen_server:cast(?MODULE, {'clear_scene', SceneId}).



add_to_scene_mon_id_list(SceneId, NewMonId) ->
    gen_server:cast(?MODULE, {'add_to_scene_mon_id_list', SceneId, NewMonId}).



add_to_scene_dynamic_npc_id_list(SceneId, NewDynamicNpcId) ->
    gen_server:cast(?MODULE, {'add_to_scene_dynamic_npc_id_list', SceneId, NewDynamicNpcId}).


add_to_scene_dynamic_teleporter_list(SceneId, NewTeleporter) ->
    gen_server:cast(?MODULE, {'add_to_scene_dynamic_teleporter_list', SceneId, NewTeleporter}).
    



add_to_scene_player_list(SceneId, PlayerId, SceneLine) ->
    gen_server:cast(?MODULE, {'add_to_scene_player_list', SceneId, PlayerId, SceneLine}).


del_from_scene_player_list(SceneId, PlayerId) ->
    gen_server:cast(?MODULE, {'del_from_scene_player_list', SceneId, PlayerId}).



clear_mon_from_scene(MonId) ->
    gen_server:cast(?MODULE, {'clear_mon_from_scene', MonId}).

clear_mon_from_scene_WNC(MonId) ->
    gen_server:cast(?MODULE, {'clear_mon_from_scene_WNC', MonId}).



clear_dynamic_npc_from_scene(NpcId) ->
    gen_server:cast(?MODULE, {'clear_dynamic_npc_from_scene', NpcId}).

clear_dynamic_npc_from_scene_WNC(NpcId) ->
    gen_server:cast(?MODULE, {'clear_dynamic_npc_from_scene_WNC', NpcId}).


clear_dynamic_teleporter_from_scene_WNC(Teleporter) ->
    gen_server:cast(?MODULE, {'clear_dynamic_teleporter_from_scene_WNC', Teleporter}).


%% 重新开启场景对应的go进程
restart_go_proc(SceneObj) ->
    gen_server:cast(?MODULE, {'restart_go_proc', SceneObj}).
    


%% 创建后备场景
create_reserve_scene(SceneId) ->
    gen_server:cast(?MODULE, {'create_reserve_scene', SceneId}).

    



% %% 排定：刷出明雷怪到场景(WNC: with notify client)
% schedule_spawn_mon_to_scene_WNC(MonNo, SceneId, X, Y) ->
%     gen_server:cast(?MODULE, {'spawn_mon_to_scene_WNC', MonNo, SceneId, X, Y}).


% %% old: 清除场景
% clear_scene(Id) ->
%     mod_mon_create:clear_scene_mon(Id),    % 清除怪物
%     ets:match_delete(?ETS_NPC, #npc{scene=Id, _ = '_'}),%% 清除npc
%     ets:delete(?ETS_SCENE, Id).         % 清除场景            



%% ===================================================================================================================



init([]) ->
    ?TRACE("[mod_scene_mgr] init()...~n"),
    process_flag(trap_exit, true),
	
    %%% create_ets_scene_grid(),

    % 加载场景
    SceneNoList = data_scene:get_no_list(),
    init_load_normal_scenes(SceneNoList),

    State = #state{},
    {ok, State}.


% %% 统一模块+过程调用(call)
% handle_call({apply_call, Module, Method, Args}, _From, State) ->
%     Reply  = 
%     case (catch apply(Module, Method, Args)) of
%          {'EXIT', Info} ->
%              ?WARNING_MSG("mod_scene_apply_call error: Module=~p, Method=~p, Reason=~p",[Module, Method,Info]),
%              error;
%          DataRet -> 
%              DataRet
%     end,
%     {reply, Reply, State};



% %% 获取下一个有效的场景id
% handle_call('get_next_id', _From, State) ->
%     NewSceneId = State#state.auto_scene_id,        
%     {reply, NewSceneId, State#state{auto_scene_id = NewSceneId + 1}};




%% 创建场景
handle_call({'create_scene', SceneNo}, _From, State) ->
    case mod_scene_tpl:get_tpl_data(SceneNo) of
        null ->
            ?ASSERT(false, SceneNo),
            {reply, fail, State};
        SceneTpl ->
            IdForNewScene = mod_id_alloc:next_scene_id(),  %%State#state.auto_scene_id,
            force_create_scene(SceneTpl, IdForNewScene),
            {reply, {ok, IdForNewScene}, State}
    end;
    

handle_call(_Request, _From, State) ->
    {reply, State, State}.

% %% 统一模块+过程调用(cast)
% handle_cast({apply_cast, Module, Method, Args}, State) ->
% 	case (catch apply(Module, Method, Args)) of
% 		 {'EXIT', Info} ->	
% 			 ?WARNING_MSG("mod_scene__apply_cast error: Module=~p, Method=~p, Reason=~p",[Module, Method, Info]),
% 			 error;
% 		 _ -> skip
% 	end,
%     {noreply, State};


%% 清除场景
handle_cast({'clear_scene', SceneId}, State) ->
    case lib_scene:is_exists(SceneId) of
        false ->
            ?ERROR_MSG("[mod_scene_mgr] clear_scene error!! scene not exists!! SceneId=~p, stacktrace=~w", [SceneId, erlang:get_stacktrace()]),
            %%?ASSERT(false, SceneId),
            skip;
        true ->
            ?TRY_CATCH(force_clear_scene(SceneId), ErrReason)
    end,   
    {noreply, State};



%% 添加新刷出的明雷怪的id到场景对象所记录的明雷怪列表
handle_cast({'add_to_scene_mon_id_list', SceneId, NewMonId}, State) ->
    case lib_scene:is_exists(SceneId) of
        false ->
            ?ASSERT(false, {SceneId, NewMonId}),
            skip;
        true ->
            ?TRY_CATCH(lib_scene:add_to_scene_mon_ids(SceneId, NewMonId), ErrReason)
    end,   
    {noreply, State};




%% 添加新刷出的动态npc的id到场景对象所记录的动态npc列表
handle_cast({'add_to_scene_dynamic_npc_id_list', SceneId, NewDynamicNpcId}, State) ->
    case lib_scene:is_exists(SceneId) of
        false ->
            ?ASSERT(false, {SceneId, NewDynamicNpcId}),
            skip;
        true ->
            ?TRY_CATCH(lib_scene:add_to_scene_dynamic_npc_ids(SceneId, NewDynamicNpcId), ErrReason)
    end,   
    {noreply, State};


%% 添加新刷出的传送点到场景对象所记录的动态传送点列表
handle_cast({'add_to_scene_dynamic_teleporter_list', SceneId, NewTeleporter}, State) ->
    ?ASSERT(is_record(NewTeleporter, teleporter)),
    case lib_scene:is_exists(SceneId) of
        false ->
            ?ASSERT(false, {SceneId, NewTeleporter}),
            skip;
        true ->
            ?TRY_CATCH(lib_scene:add_to_scene_dynamic_teleporter_list(SceneId, NewTeleporter), ErrReason)
    end,   
    {noreply, State};



% 作废！！
% %% 添加玩家到场景对象所记录的玩家列表
% handle_cast({'add_to_scene_player_id_list', SceneId, PlayerId}, State) ->
%     ?TRACE("mod_scene_mgr,  add_to_scene_player_id_list, SceneId:~p, PlayerId:~p~n", [SceneId, PlayerId]),
%     case lib_scene:get_obj(SceneId) of
%         null ->
%             ?ASSERT(false, {SceneId, PlayerId}),
%             skip;
%         _SceneObj ->
%             lib_scene:add_player_to_ets_scene_players(SceneId, PlayerId)
%     end,   
%     {noreply, State};


% %% 从场景对象所记录的玩家列表删除玩家
% handle_cast({'del_from_scene_player_id_list', SceneId, PlayerId}, State) ->
%     ?TRACE("mod_scene_mgr,  del_from_scene_player_id_list, SceneId:~p, PlayerId:~p~n", [SceneId, PlayerId]),
%     ?ASSERT(lib_scene:is_exists(SceneId), {SceneId, PlayerId}),
%     lib_scene:del_player_from_ets_scene_players(SceneId, PlayerId),
%     {noreply, State};




%% 添加玩家到场景对象所记录的玩家列表
handle_cast({'add_to_scene_player_list', SceneId, PlayerId, SceneLine}, State) ->
    % ?TRACE("mod_scene_mgr,  add_to_scene_player_list, SceneId:~p, PlayerId:~p, SceneLine:~p~n", [SceneId, PlayerId, SceneLine]),
    case lib_scene:is_exists(SceneId) of
        false ->  % 因为此操作是异步的，故执行到此分支是可能的！
            skip;
        true ->
            ?TRY_CATCH(lib_scene:add_to_scene_player_list(SceneId, PlayerId, SceneLine), ErrReason)
    end,   
    {noreply, State};



%% 从场景对象所记录的玩家列表删除玩家
handle_cast({'del_from_scene_player_list', SceneId, PlayerId}, State) ->
    % ?TRACE("mod_scene_mgr,  del_from_scene_player_list, SceneId:~p, PlayerId:~p~n", [SceneId, PlayerId]),
    ?TRY_CATCH(lib_scene:del_from_scene_player_list(SceneId, PlayerId), ErrReason),
    {noreply, State};


%% 
handle_cast({'clear_mon_from_scene', MonId}, State) ->
    case mod_mon:is_exists(MonId) of
        false ->
            skip;
        true ->
            % 稳妥起见，用了try...catch，下同
            ?TRY_CATCH(force_clear_mon_from_scene(MonId), ErrReason)
    end,   
    {noreply, State};



%% 
handle_cast({'clear_mon_from_scene_WNC', MonId}, State) ->
    case mod_mon:is_exists(MonId) of
        false ->
            skip;
        true ->
            catch force_clear_mon_from_scene_WNC(MonId) % 目前的逻辑，重复删除怪是可能的，故这里不记录错误日志，只是简单catch
    end,   
    {noreply, State};




%% 
handle_cast({'clear_dynamic_npc_from_scene', NpcId}, State) ->
    case mod_npc:is_exists(NpcId) of
        false ->
            skip;
        true ->
            ?TRY_CATCH(force_clear_dynamic_npc_from_scene(NpcId), ErrReason)
    end,   
    {noreply, State};


%% 
handle_cast({'clear_dynamic_npc_from_scene_WNC', NpcId}, State) ->
    case mod_npc:is_exists(NpcId) of
        false ->
            skip;
        true ->
            ?TRY_CATCH(force_clear_dynamic_npc_from_scene_WNC(NpcId), ErrReason)
    end,   
    {noreply, State};




handle_cast({'clear_dynamic_teleporter_from_scene_WNC', Teleporter}, State) ->
    ?TRY_CATCH(force_clear_dynamic_teleporter_from_scene_WNC(Teleporter), ErrReason),   
    {noreply, State};






% handle_cast({'spawn_mon_to_scene_WNC', MonNo, SceneId, X, Y}, State) ->
%     case lib_scene:get_obj(SceneId) of
%         null ->
%             skip;
%         _SceneObj ->
%             mod_scene:spawn_mon_to_scene_WNC(MonNo, SceneId, X, Y)
%     end,
%     {noreply, State};




handle_cast({'restart_go_proc', SceneObj}, State) ->
    ?TRY_CATCH(restart_go_proc__(SceneObj), ErrReason),
    {noreply, State};

            

handle_cast({'create_reserve_scene', SceneId}, State) ->
    IdForNewScene = mod_id_alloc:next_scene_id(), %%State#state.auto_scene_id,
    case catch create_reserve_scene__(SceneId, IdForNewScene) of
        do_nothing ->
            skip;
        ok ->
            skip;
        fail ->
            skip;
        Error ->
            ?ERROR_MSG("[mod_scene_mgr] maybe_create_reserve_scene() error!!! SceneId:~p, details: ~w", [SceneId, Error]),
            skip
    end,
    {noreply, State};




handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(Reason, _State) ->
    ?TRACE("[mod_scene_mgr] terminate for reason: ~w~n", [Reason]),
    case Reason of
        normal -> skip;
        shutdown -> skip;
        {shutdown, _} -> skip;
        _ ->
            ?ERROR_MSG("[~p] !!!!!terminate!!!!! for reason: ~w", [?MODULE, Reason])
    end,
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.



% %% 创建N个ets，用于记录场景格子内的对象（玩家，怪物，巡逻npc）
% create_ets_scene_grid() ->
%     F = fun(SeqNum) ->
%             EtsName = list_to_atom(lists:concat([ets_scene_grid_, SeqNum])),
%             ets:new(EtsName, [{keypos,#scene_grid.key}, named_table, public, set])
%         end,
%     lists:foreach(F, lists:seq(1, ?ETS_SCENE_GRID_COUNT)).



%% 开服时初始化加载普通场景
init_load_normal_scenes([]) ->
    ok;
init_load_normal_scenes([SceneNo | T]) ->
    ?ASSERT(SceneNo /= ?INVALID_SCENE_NO),
	case mod_scene_tpl:get_tpl_data(SceneNo) of
        null ->
            ?ASSERT(false, SceneNo),
            skip;
        SceneTpl ->
            case mod_scene_tpl:is_normal_scene(SceneTpl) of
                false -> % 非普通场景，不加载
                    skip;
                true ->
                    % 规定：普通场景的唯一id和编号相同!! 故第二个参数直接传入SceneNo
                    force_create_scene(SceneTpl, SceneNo)
            end
    end,
    init_load_normal_scenes(T).






%% 直接强行创建场景
%% @para: SceneTpl => 场景模板， SceneId => 新建场景的id
%% @return: ok
force_create_scene(SceneTpl, SceneId) ->     
    NewSceneObj = #scene{
                    id = SceneId,
                    no = SceneTpl#scene_tpl.no,

                    % npcs = NpcIdL,
                    % mons = MonIdL,
                    % dynamic_npcs = [],    % 场景中的动态NPC初始为空

                    %%res_id = SceneTpl#scene_tpl.res_id,
                    %%name = SceneTpl#scene_tpl.name,
                    type = SceneTpl#scene_tpl.type,
                    subtype = SceneTpl#scene_tpl.subtype,

                    width = SceneTpl#scene_tpl.width,
                    height = SceneTpl#scene_tpl.height

                    % x0 = SceneTpl#scene_tpl.x0,
                    % y0 = SceneTpl#scene_tpl.y0,

                    %%elem = SceneTpl#scene_tpl.elem,

                    %%requirement = SceneTpl#scene_tpl.requirement,
                    % is_safe = SceneTpl#scene_tpl.is_safe
                    %%revive_xy = SceneTpl#scene_tpl.revive_xy
                            
                    },

    lib_scene:add_scene_to_ets(NewSceneObj),
    lib_scene:init_objs_of_scene_rd(SceneId),

    % 创建对应的go进程
    mod_go:on_scene_created(NewSceneObj),

    % 加载静态NPC和明雷怪
    NpcIdL = load_scene_static_npcs(SceneTpl, SceneId),
    MonIdL = load_scene_static_mons(SceneTpl, SceneId),
    ?ASSERT(is_list(NpcIdL) andalso is_list(MonIdL)),

    lib_scene:set_scene_static_npc_ids(SceneId, NpcIdL),
    lib_scene:set_scene_mon_ids(SceneId, MonIdL),

    ok.



%% 加载场景的静态NPC
%% @return：新创建npc的唯一id列表
load_scene_static_npcs(SceneTpl, SceneId) ->
    case (mod_scene_tpl:is_normal_scene(SceneTpl) andalso (not lib_scene:is_copy_scene(SceneId)))
    orelse mod_scene_tpl:is_melee_scene(SceneTpl) orelse mod_scene_tpl:is_newyear_banquat_scene(SceneTpl) of  % 特殊对待女妖乱斗活动的副本场景  -- huangjf
        true ->
            load_scene_static_npcs__( mod_scene_tpl:get_cfg_static_npc_list(SceneTpl), SceneId, []);
        false ->
            []
    end.
    
   
load_scene_static_npcs__([], _SceneId, AccNpcIdL) ->
    AccNpcIdL;
load_scene_static_npcs__([{NpcNo, X, Y} | T], SceneId, AccNpcIdL) ->
    ?ASSERT(NpcNo < ?DYNAMIC_NPC_START_ID, {NpcNo, SceneId}),
    {ok, NewNpc} = mod_npc:create_static_npc([NpcNo, SceneId, X, Y]),

    % 添加到ets
    mod_npc:add_npc_to_ets(NewNpc),

    % case mod_npc:is_cruise_activity_npc(NewNpc) of
    %     true -> ...
    %     false -> skip
    % end,


    NewNpcId = mod_npc:get_id(NewNpc),
    % ?TRACE("load_scene_static_npcs__() success, NewNpcId: ~p, NpcNo:~p, SceneId:~p~n", [NewNpcId, NpcNo, SceneId]),
    load_scene_static_npcs__(T, SceneId, [NewNpcId | AccNpcIdL]).



%% 作废！！
% %% 加载非普通场景的NPC（id需动态设置）
% %% @return：新创建npc的唯一id列表
% load_nonnormal_scene_npcs([], _SceneId, AccNpcIdL) ->
%     AccNpcIdL;
% load_nonnormal_scene_npcs([{_, NpcNo, X, Y} | T], SceneId, AccNpcIdL) ->
%     {ok, NewNpcId} = mod_npc:create_npc([invalid_npc_id, NpcNo, SceneId, X, Y]),
%     ?ASSERT(NewNpcId >= ?DYNAMIC_NPC_START_ID, {NewNpcId, NpcNo, SceneId}),
%     ?TRACE("load_nonnormal_scene_npcs() success, NpcId: ~p, NpcNo:~p, SceneId:~p~n", [NewNpcId, NpcNo, SceneId]),
%     load_nonnormal_scene_npcs(T, SceneId, [NewNpcId | AccNpcIdL]).







%% 加载场景的静态明雷怪
%% @return：新创建明雷怪的唯一id列表
load_scene_static_mons(SceneTpl, SceneId) ->
    load_scene_static_mons__( mod_scene_tpl:get_cfg_static_mon_list(SceneTpl), SceneId, []).

load_scene_static_mons__([], _SceneId, AccMonIdL) ->
    AccMonIdL;
load_scene_static_mons__([{MonNo, X, Y} | T], SceneId, AccMonIdL) ->
    {ok, NewMon} = mod_mon:create_mon([MonNo, SceneId, X, Y]),
    % 静态明雷怪没有时限，故断言
    ?ASSERT(mod_mon:is_existing_time_forever(NewMon), {MonNo, SceneId}),

    NewMonId = mod_mon:get_id(NewMon),

    % 添加到ets
    mod_mon:add_mon_to_ets(NewMon),

    % 加到场景格子
    ?TRACE("load_scene_static_mons__(), add mon to scene grid: NewMonId=~p, SceneId=~p, X=~p, Y=~p~n", [NewMonId, SceneId, X, Y]),
    mod_go:mon_enter_scene(NewMonId, SceneId, X, Y),

    load_scene_static_mons__(T, SceneId, [NewMonId | AccMonIdL]).




%% 从场景清除明雷怪
force_clear_mon_from_scene(MonId) ->
    ?ASSERT(mod_mon:is_exists(MonId), MonId),

    MonObj = mod_mon:get_obj(MonId),

    % 先从场景对象所记录的明雷怪列表中删除
    SceneId = mod_mon:get_scene_id(MonObj),
    % SceneObj = lib_scene:get_obj(SceneId),
    % List_Old = lib_scene:get_scene_mon_ids(SceneObj),
    % ?ASSERT(lists:member(MonId, List_Old), {MonId, List_Old, SceneObj, erlang:get_stacktrace()}),
    % List_New = List_Old -- [MonId],
    % lib_scene:set_scene_mon_ids(SceneObj, List_New),
    lib_scene:del_from_scene_mon_ids(SceneId, MonId),


    % 从场景格子移除
    % SceneId = mod_mon:get_scene_id(MonObj),
    % {X, Y} = mod_mon:get_xy(MonObj),
    mod_go:mon_leave_scene(MonObj),

    % 删除位置记录
    mod_scene:delete_mon_position(MonObj),

    % 清除怪本身
    mod_mon:clear_mon(MonId),

    ok.

%% 同上，只是多了通知客户端的处理（WNC: with notify client）
force_clear_mon_from_scene_WNC(MonId) ->
    case mod_mon:is_exists(MonId) of
        true ->
            ?ASSERT(mod_mon:is_exists(MonId), MonId),
            ?TRACE("force_clear_mon_from_scene_WNC(), MonId=~p~n", [MonId]),
            MonObj = mod_mon:get_obj(MonId),
            ?ASSERT(MonObj /= null, {MonId, mod_mon:is_exists(MonId), erlang:get_stacktrace()}),
            mod_go:notify_mon_cleared_to_AOI(MonObj),
            force_clear_mon_from_scene(MonId),
            ok;
        false -> skip
    end.

%% 从场景清除动态npc
force_clear_dynamic_npc_from_scene(NpcId) ->
    ?ASSERT(mod_npc:is_exists(NpcId), NpcId),
    Npc = mod_npc:get_obj(NpcId),
    ?ASSERT(mod_npc:is_dynamic_npc(Npc), Npc),
    
    % 先从场景对象所记录的动态npc列表中删除
    SceneId = mod_npc:get_scene_id(Npc),
    % SceneObj = lib_scene:get_obj(SceneId),
    % List_Old = lib_scene:get_scene_dynamic_npc_ids(SceneObj),
    % ?ASSERT(lists:member(NpcId, List_Old), {NpcId, List_Old, SceneObj}),
    % List_New = List_Old -- [NpcId],
    % lib_scene:set_scene_dynamic_npc_ids(SceneObj, List_New),
    lib_scene:del_from_scene_dynamic_npc_ids(SceneId, NpcId),


    ?Ifc (mod_npc:is_moveable(Npc))
        % 从场景格子移除
        % SceneId = mod_npc:get_scene_id(Npc),
        % {X, Y} = mod_npc:get_xy(Npc),
        mod_go:npc_leave_scene(Npc)
    ?End,

    % 清除npc本身
    mod_npc:clear_npc(NpcId),

    ok.



%% 同上， 只是多了通知客户端的处理（WNC: with notify client）
force_clear_dynamic_npc_from_scene_WNC(NpcId) ->
    ?ASSERT(mod_npc:is_exists(NpcId), NpcId),
    ?TRACE("force_clear_dynamic_npc_from_scene_WNC(), NpcId=~p~n", [NpcId]),
    NpcObj = mod_npc:get_obj(NpcId),
    mod_scene:notify_dynamic_npc_cleared_to_players(NpcObj),
    force_clear_dynamic_npc_from_scene(NpcId),
    ok.



force_clear_dynamic_teleporter_from_scene_WNC(Teleporter) ->
    ?ASSERT(is_record(Teleporter, teleporter), Teleporter),
    SceneId = Teleporter#teleporter.scene_id,
    case lib_scene:is_exists(SceneId) of
        false ->
            ?ASSERT(false, Teleporter),
            skip;
        true ->
            lib_scene:del_from_scene_dynamic_teleporter_list(SceneId, Teleporter),
            mod_scene:notify_dynamic_teleporter_cleared_from_scene(Teleporter)
    end,
    ok.




%% 直接强行清除场景
force_clear_scene(SceneId) ->
    ?ASSERT(lib_scene:is_exists(SceneId), SceneId),
    Scene = lib_scene:get_obj(SceneId),

    fast_clear_scene_npcs(Scene),    % 清除场景npc，采用快速清除的方式
    fast_clear_scene_mons(Scene),    % 清除场景怪物，采用快速清除的方式

    % clear_scene_grids_data(Scene),    % 清除场景的九宫格记录数据
    clear_scene_players_record(SceneId),   % 清除场景的玩家记录，勿忘！


    mod_go:on_scene_destroyed(SceneId),

    lib_scene:del_objs_of_scene_rd_from_ets(SceneId),
    lib_scene:del_scene_from_ets(SceneId).     % 清除场景本身
            








%% 清除场景所有npc
fast_clear_scene_npcs(Scene) ->
    fast_clear_scene_static_npcs(Scene),
    fast_clear_scene_dynamic_npcs(Scene),
    % 数据一致性的断言（用于调试）
    case lib_scene:is_melee_scene(Scene) of
        true ->
            skip;
        false ->
            mod_npc_mgr:dbg_assert_no_npcs_in_scene( lib_scene:get_id(Scene) )
    end.
                



%% 清除场景的静态npc
fast_clear_scene_static_npcs(Scene) ->
    case lib_scene:is_melee_scene(Scene) of  % 特殊对待女妖乱斗活动的副本场景  -- huangjf
        true ->
            skip;
        false ->
            SceneId = lib_scene:get_id(Scene),
            NpcIdL = lib_scene:get_scene_static_npc_ids(SceneId),

            % TODO: 确认：这里采用快速清除的方法，是否ok？？
            lists:foreach(fun fast_clear_one_npc_from_scene/1, NpcIdL)  %%%% old:  ets:match_delete(?ETS_NPC, #npc{scene_id = SceneId, _ = '_'}). 
    end,   
    ok.



%% 清除场景的动态npc
fast_clear_scene_dynamic_npcs(Scene) ->
    SceneId = lib_scene:get_id(Scene),
    DynamicNpcIdL = lib_scene:get_scene_dynamic_npc_ids(SceneId),
    % TODO: 确认：这里采用快速清除的方法，并且和清除普通npc是同样的处理，是否ok？？
    lists:foreach(fun fast_clear_one_npc_from_scene/1, DynamicNpcIdL),
    ok.



%% 快速从场景清除npc，使用于清除场景时。故意忽略如下的处理：1. AOI通知， 2. 从场景对象所记录的npc列表中删除，3.（巡逻npc的）场景九宫格相关数据的删除
fast_clear_one_npc_from_scene(NpcId) ->
    mod_npc:clear_npc(NpcId).



%% 清除场景所有怪物
fast_clear_scene_mons(Scene) ->
    SceneId = lib_scene:get_id(Scene),
    MonIdL = lib_scene:get_scene_mon_ids(SceneId),
    % TODO: 确认：这里采用快速清除的方法，是否ok？？
    lists:foreach(fun fast_clear_one_mon_from_scene/1, MonIdL),
    % 数据一致性的断言（仅调试用）
    mod_mon_mgr:dbg_assert_no_mons_in_scene( lib_scene:get_id(Scene) ),
    ok.


%% 快速从场景清除明雷怪，使用于清除场景时。故意忽略如下的处理：1. AOI通知， 2. 从场景对象所记录的明雷怪列表中删除， 3.场景九宫格相关数据的删除
fast_clear_one_mon_from_scene(MonId) ->
    case mod_mon:get_obj(MonId) of
        null ->
            ?ASSERT(false, MonId),
            ?ERROR_MSG("[mod_scene_mgr] fast_clear_one_mon_from_scene() error!!! MonId:~p", [MonId]),
            skip;
        MonObj ->
            ?DEBUG_MSG("fast_clear_one_mon_from_scene(), MonId:~p", [MonId]),
            mod_scene:delete_mon_position(MonObj),  % 删除位置记录，勿忘！
            mod_mon:clear_mon(MonId)
    end.

            



% %%  清除场景的九宫格对象记录
% clear_scene_grids_data(SceneObj) ->
%     mod_go:clear_scene_grids_data(SceneObj).  %%lib_scene:del_scene_grid_records_from_ets(SceneId).



%% 清除场景的玩家列表记录
clear_scene_players_record(SceneId) ->
    lib_scene:del_scene_players_record_from_ets(SceneId).











% %% 加载自动适应Mon
% load_mon1([], _, Reply, _Lv) ->
%     Reply;
% load_mon1([[LevelMonId, X, Y] | T], SceneId,Reply, Lv) ->
% 	MonId = lib_mon:get_level_mon(LevelMonId, Lv),
%     Id = mod_mon_create:create_mon([MonId, SceneId, X, Y, 0, 0]),
%     load_mon1(T, SceneId,[Id|Reply], Lv);
% load_mon1([[LevelMonId, X, Y, PassFinish] | T], SceneId,Reply, Lv) ->
% 	MonId = lib_mon:get_level_mon(LevelMonId, Lv),
%     Id = mod_mon_create:create_mon([MonId, SceneId, X, Y, 0, PassFinish]),
%     load_mon1(T, SceneId,[Id|Reply], Lv);
% load_mon1([[LevelMonId, X, Y, Type, PassFinish] | T], SceneId,Reply, Lv) ->
% 	MonId = lib_mon:get_level_mon(LevelMonId, Lv),
%     Id = mod_mon_create:create_mon([MonId, SceneId, X, Y, Type, PassFinish]),
%     load_mon1(T, SceneId,[Id|Reply], Lv).


% %% 从地图的mask中构建ETS坐标表，表中存放的是可移动的坐标
% %% load_mask(Mask,0,0)，参数1表示地图的mask列表，参数2和3为当前产生的X,Y坐标
% load_mask([], _, _, _) ->
%     null;
% load_mask([H|T], X, Y, SceneId) ->
%     case H of
%         10 -> % 等于\n
%             load_mask(T, 0, Y+1, SceneId);
%         13 -> % 等于\r
%             load_mask(T, X, Y, SceneId);
%         48 -> % 0
%             load_mask(T, X+1, Y, SceneId);
%         49 -> % 1
%             ets:insert(?ETS_SCENE_POSES, {{SceneId, X, Y}}),
%             load_mask(T, X+1, Y, SceneId);
%         50 -> % 2
%             load_mask(T, X+1, Y, SceneId);
%         Other ->
%             ?ERROR_MSG("场景Mask里面含有未知元素: ~w", [Other])
%     end.





create_reserve_scene__(SceneId, IdForReserveScene) ->
    case lib_scene:get_obj(SceneId) of
        null ->
            ?DEBUG_MSG("[mod_scene_mgr] scene obj not exists! SceneId:~p", [SceneId]),
            do_nothing;
        SceneObj ->
            case lib_scene:is_reserve_scene_exists(SceneId) of
                true ->
                    ?DEBUG_MSG("[mod_scene_mgr] reserve scene already exists! SceneId:~p", [SceneId]),
                    do_nothing;
                false ->
                    case catch do_create_reserve_scene(SceneObj, IdForReserveScene) of
                        ok ->
                            ?DEBUG_MSG("[mod_scene_mgr] do_create_reserve_scene() ok!  SceneId:~p, ReserveSceneId:~p", [SceneId, IdForReserveScene]),
                            lib_scene:set_reserve_scene_id(SceneId, IdForReserveScene),
                            ok;
                        Error ->
                            ?ERROR_MSG("[mod_scene_mgr] do_create_reserve_scene() error!! SceneId:~p, details:~w", [SceneId, Error]),
                            fail
                    end
            end
    end. 


% is_reserve_scene_already_created(SceneId) ->
%     case erlang:get({?PDKN_RESERVE_SCENE, SceneId}) of
%         undefined ->
%             false;
%         _ReserveSceneId ->
%             ?ASSERT(is_integer(_ReserveSceneId), {SceneId, _ReserveSceneId}),
%             true
%     end.



do_create_reserve_scene(ParentSceneObj, IdForReserveScene) ->
    ?DEBUG_MSG("[mod_scene_mgr] do_create_reserve_scene()! ParentSceneId:~p, IdForReserveScene:~p", [lib_scene:get_id(ParentSceneObj), IdForReserveScene]),
    SceneNo = lib_scene:get_no(ParentSceneObj),
    SceneTpl = mod_scene_tpl:get_tpl_data(SceneNo),    
    force_create_scene(SceneTpl, IdForReserveScene),
    ok.
    



restart_go_proc__(SceneObj) ->
    SceneId = lib_scene:get_id(SceneObj),
    % 确认场景对象是否存在，如果不存在，则不需做处理
    case lib_scene:is_exists(SceneId) of
        true ->
            mod_go:on_scene_created(SceneObj);
        false ->
            skip
    end.