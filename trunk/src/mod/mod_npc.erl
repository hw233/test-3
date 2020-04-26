%%%------------------------------------
%%% @Module  : mod_npc
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2013.6.16
%%% @Description: （内存中的）NPC对象
%%%------------------------------------
-module(mod_npc).
-export([
        create_static_npc/1,
        create_dynamic_npc/1, create_dynamic_npc/2,
        clear_npc/1,

        get_obj/1,
        is_exists/1,

        add_npc_to_ets/1,
        del_npc_from_ets/1,
        % update_npc_to_ets/1,
        get_scene_id/1,
        get_id/1,
        get_no/1,
        get_no_by_id/1,

        get_extra/1,
        
        get_name/1,
        get_xy/1,
        set_xy/2,
        get_func_list/1,
        % get_teleport_list/1,
        get_teach_skill_list/1,
        get_dungeon_no_list/1,
        get_npc_shop_no_list/1,
        get_npc_exchange_no_list/1,
        get_npc_collect_info/1,
        get_trigger_mf_func_list/1,

        get_bhv_state/1,
        set_bhv_state/2,

        is_waiting_player_to_join_cruise/1,
        is_cruising/1,

        is_expired/1,

        is_static_npc/1,
        is_dynamic_npc/1,
        is_patrol_npc/1,
        is_cruise_activity_npc/1,

        is_static_npc_id/1,
        is_dynamic_npc_id/1,

        is_moveable/1,

        notify_bhv_state_changed_to_aoi/2
    ]).

% -compile({inline, [
%                     get_id/1, get_no/1,
%                     get_xy/1
%                   ]
%         }).

-include("common.hrl").
-include("record.hrl").
-include("npc.hrl").
-include("char.hrl").
-include("scene.hrl").
-include("ets_name.hrl").
-include("prompt_msg_code.hrl").
-include("abbreviate.hrl").
-include("obj_info_code.hrl").




%% 创建静态NPC对象
%% @return: {ok, 新创建的NPC对象} | fail
create_static_npc([NpcNo, SceneId, X, Y]) ->
    NewNpcId = NpcNo,  % 规定：静态npc的id和其编号相同！
    ?ASSERT(is_static_npc_id(NewNpcId), {NpcNo, SceneId, X, Y}),
    case mod_npc_tpl:get_tpl_data(NpcNo) of
        null ->
            ?ASSERT(false, NpcNo),
            fail;
        NpcTpl ->
            NewNpc = create_npc__(NpcTpl, NewNpcId, SceneId, X, Y, []),
            {ok, NewNpc}  
    end.


%% 创建动态NPC对象
%% @return: {ok, 新创建的NPC对象} | fail
create_dynamic_npc([NpcNo, SceneId, X, Y]) ->
    create_dynamic_npc([NpcNo, SceneId, X, Y], []).
    
%% @para: ExtraInitInfo => 额外的初始化信息， 格式如： [{Key, Value}, ...]
create_dynamic_npc([NpcNo, SceneId, X, Y], ExtraInitInfo) ->
    case mod_npc_tpl:get_tpl_data(NpcNo) of
        null ->
            ?ASSERT(false, NpcNo),
            fail;
        NpcTpl ->
            ExistingTime =  case NpcTpl#npc_tpl.existing_time == 0 of
                                true ->  % 容错
                                    % ?ASSERT(false, NpcTpl),
                                    ?ERROR_MSG("[mod_npc] create_dynamic_npc() error!! existing time forever! NpcNo:~p", [NpcNo]),
                                    ?NPC_DEFAULT_EXISTING_TIME;
                                false ->
                                    NpcTpl#npc_tpl.existing_time
                            end,

            % 动态获取新id
            NewNpcId = mod_id_alloc:next_npc_id(),
            ?ASSERT(is_dynamic_npc_id(NewNpcId), {NewNpcId, NpcNo, SceneId, X, Y}),
            NewNpc = create_npc__(NpcTpl, NewNpcId, SceneId, X, Y, ExtraInitInfo),
            ExpireTime = svr_clock:get_unixtime() + ExistingTime,
            NewNpc2 = NewNpc#npc{
                            existing_time = ExistingTime,
                            expire_time = ExpireTime
                            },
            {ok, NewNpc2}  
    end.

create_npc__(NpcTpl, NewNpcId, SceneId, X, Y, ExtraInitInfo) ->
    NewNpc = #npc{
                id = NewNpcId,
                no = NpcTpl#npc_tpl.no,
                type = NpcTpl#npc_tpl.type,
                % name = NpcTpl#npc_tpl.name,
                % func_list = NpcTpl#npc_tpl.func_list,
                bhv_state = ?BHV_IDLE,
                scene_id = SceneId,
                x = X,
                y = Y
                },

    NewNpc2 = case lists:keyfind(bhv_state, 1, ExtraInitInfo) of  % 判断是否指定了初始行为状态
                {bhv_state, BhvState} ->
                    NewNpc#npc{bhv_state = BhvState, extra = ExtraInitInfo -- [{bhv_state, BhvState}]};
                false ->
                    NewNpc#npc{extra = ExtraInitInfo}
            end,

    NewNpc2.
    





%% 清除NPC
clear_npc(NpcId) ->
    ?ASSERT(is_exists(NpcId), NpcId),

    % 做一些必要的清理工作，目前暂时没有
    % 。。。

    mod_npc_mgr:do_clear_npc(NpcId).







%% 废弃！！
% further_init_npc(NewNpc) ->
%     % TODO: 
%     % ...如有必要，做进一步的初始化
%     % ...
%     NewNpc.





%% 从ets获取npc对象
%% @para: NpcId => npc唯一id
%% @return：null | npc结构体
get_obj(NpcId) ->
    case is_dynamic_npc_id(NpcId) of
        true ->
            case ets:lookup(?ETS_DYNAMIC_NPC, NpcId) of
                [] -> null;
                [Npc] -> Npc
            end;
        false ->
            case ets:lookup(?ETS_STATIC_NPC, NpcId) of
                [] -> null;
                [Npc] -> Npc
            end
    end.

            


%% npc对象是否存在？（true | false）
is_exists(NpcId) ->
    ?ASSERT(is_integer(NpcId), NpcId),
    case is_dynamic_npc_id(NpcId) of
        true ->
            ets:member(?ETS_DYNAMIC_NPC, NpcId);
        false ->
            ets:member(?ETS_STATIC_NPC, NpcId)
    end.


%% 添加npc对象到ets
add_npc_to_ets(NewNpc) when is_record(NewNpc, npc) ->
    case is_dynamic_npc(NewNpc) of
        true ->
            case ets:insert_new(?ETS_DYNAMIC_NPC, NewNpc) of
                true ->
                    mod_npc_mgr:add_to_dyn_npc_id_set( get_id(NewNpc)),
                    ok;
                false ->
                    ?ERROR_MSG("[mod_npc] add_npc_to_ets() error!!! stacktrace: ~w~n NewNpc: ~w~n ets_npc:~w", [erlang:get_stacktrace(), NewNpc, ets:tab2list(?ETS_DYNAMIC_NPC)]),
                    ?ASSERT(false),
                    fail
            end;
        false ->
            % 目前对于静态npc，是取其编号作为id，故重复插入相同id的静态npc对象是有可能的，故这里不用ets:insert_new()
            ets:insert(?ETS_STATIC_NPC, NewNpc),
            ok
    end.
    


%% 从ets删除npc对象
del_npc_from_ets(NpcId) ->
    ?ASSERT(is_integer(NpcId), NpcId), 
    case is_dynamic_npc_id(NpcId) of
        true ->
            mod_npc_mgr:del_from_dyn_npc_id_set(NpcId),
            ets:delete(?ETS_DYNAMIC_NPC, NpcId);
        false ->
            ets:delete(?ETS_STATIC_NPC, NpcId)
    end.

            


%% 更新npc对象到ets
update_npc_to_ets(Npc_Latest) when is_record(Npc_Latest, npc) ->
    case is_dynamic_npc(Npc_Latest) of
        true ->
            ets:insert(?ETS_DYNAMIC_NPC, Npc_Latest);
        false ->
            ets:insert(?ETS_STATIC_NPC, Npc_Latest)
    end.

            



%% 获取唯一id
get_id(Npc) -> Npc#npc.id.

%% 获取编号
get_no(Npc) -> Npc#npc.no.

%% 依据唯一id获取编号
get_no_by_id(NpcId) ->
    case get_obj(NpcId) of
        null -> ?ASSERT(false, NpcId), 0;
        Npc -> Npc#npc.no
    end.

%% 获取资源id
% get_res_id(Npc) -> Npc#npc.res_id.

%% 获取坐标
get_xy(Npc) -> {Npc#npc.x, Npc#npc.y}.

%% 设置坐标
set_xy(Npc, {X, Y}) ->
    Npc2 = Npc#npc{x = X, y = Y},
    update_npc_to_ets(Npc2).


%% 获取名字
%% @para: NpcId => npc唯一id
get_name(NpcId) when is_integer(NpcId) ->
    case get_obj(NpcId) of
        Npc when is_record(Npc, npc) ->
            get_name(Npc);
        _Any ->
            ?ASSERT(false, {NpcId, _Any}),
            <<"">>
    end;
get_name(Npc) when is_record(Npc, npc) ->
    NpcNo = get_no(Npc),
    NpcTpl = mod_npc_tpl:get_tpl_data(NpcNo),
    mod_npc_tpl:get_name(NpcTpl).

get_extra(Npc) -> Npc#npc.extra.

get_type(Npc) -> Npc#npc.type.


%% 获取NPC所在的场景id
%% @para: NpcId => npc唯一id
get_scene_id(NpcId) when is_integer(NpcId) ->
    case get_obj(NpcId) of
        null -> ?ASSERT(false, NpcId), 0;
        Npc -> Npc#npc.scene_id
    end;
get_scene_id(Npc) ->
    Npc#npc.scene_id.




%% 获取功能列表
get_func_list(Npc) ->
    NpcNo = get_no(Npc),
    NpcTpl = mod_npc_tpl:get_tpl_data(NpcNo),
    mod_npc_tpl:get_func_list(NpcTpl).
    


%% 获取触发打怪的功能列表
get_trigger_mf_func_list(Npc) ->
    FuncList = get_func_list(Npc),
    % case find_one_func_by_name(FuncList, ?NPCF_TRIGGER_MF) of
    %     null ->
    %         null;
    %     {?NPCF_TRIGGER_MF, BMonGroupNo, ConditionList} ->
    %         ?ASSERT(is_list(ConditionList), Npc),
    %         {?NPCF_TRIGGER_MF, BMonGroupNo, ConditionList}
    % end.

    find_all_func_by_name(FuncList, ?NPCF_TRIGGER_MF).


%% 获取行为状态
get_bhv_state(Npc) ->
    Npc#npc.bhv_state.


%% 设置行为状态
set_bhv_state(NpcId, BhvState) when is_integer(NpcId) ->
    case get_obj(NpcId) of
        null ->
            ?ASSERT(false, NpcId),
            skip;
        Npc ->
            Npc2 = Npc#npc{bhv_state = BhvState},
            update_npc_to_ets(Npc2),
            notify_bhv_state_changed_to_aoi(Npc, BhvState)
    end;
    
%% 注意：传入的Npc对象参数须是最新的
set_bhv_state(Npc, BhvState) ->
    Npc2 = Npc#npc{bhv_state = BhvState},
    update_npc_to_ets(Npc2),
    notify_bhv_state_changed_to_aoi(Npc, BhvState).





%% 当前是否正在等待玩家报名参与巡游活动？
is_waiting_player_to_join_cruise(Npc) ->
    get_bhv_state(Npc) == ?BHV_WAITING_PLAYER_TO_JOIN_CRUISE.
   
%% 当前是否正在巡游中？
is_cruising(Npc) ->
    get_bhv_state(Npc) == ?BHV_CRUISING.


%% 刷出后的持续时间是否为永久？
is_existing_time_forever(Npc) ->
    Npc#npc.existing_time == 0.


%% 判断npc对象是否已过期
is_expired(Npc) ->
    case is_existing_time_forever(Npc) of
        true ->
            false;
        false ->
            svr_clock:get_unixtime() >= Npc#npc.expire_time
    end.



% %% 获取npc的传送列表
% %% @return: 传送编号列表
% get_teleport_list(Npc) ->
%     FuncList = get_func_list(Npc),
%     case find_one_func_by_name(FuncList, ?NPCF_TELEPORT) of
%         null ->
%             ?ASSERT(false, Npc),
%             [];
%         {?NPCF_TELEPORT, TeleportNoList} ->
%             ?ASSERT(is_list(TeleportNoList), Npc),
%             TeleportNoList
%     end.


%% 获取npc的教授技能列表
%% @return: 技能id列表
get_teach_skill_list(Npc) ->
    FuncList = get_func_list(Npc),
    case find_one_func_by_name(FuncList, ?NPCF_TEACH_SKILLS) of
        null ->
            ?ASSERT(false, Npc),
            [];
        {?NPCF_TEACH_SKILLS, SkillIdList} ->
            ?ASSERT(is_list(SkillIdList), Npc),
            SkillIdList
    end.


%% 获取副本编号列表
get_dungeon_no_list(Npc) ->
    FuncList = get_func_list(Npc),
    case find_one_func_by_name(FuncList, ?NPCF_DUNGEON) of
        null ->
            ?ASSERT(false, Npc),
            [];
        {?NPCF_DUNGEON, DungeonNoList,_} ->
            ?ASSERT(is_list(DungeonNoList), Npc),
            DungeonNoList
    end.


%% 获取npc的商店编号列表
%% @return: NpcShopNoList
get_npc_shop_no_list(Npc) ->
    FuncList = get_func_list(Npc),
    L1 = 
    case find_one_func_by_name(FuncList, ?NPCF_SELL_GOODS) of
        null ->
            [];
        {?NPCF_SELL_GOODS, NpcShopNo} ->
            [NpcShopNo]
    end,

    L2 = 
    case find_one_func_by_name(FuncList, ?NPCF_OA_FEAT_EXCHANGE) of
        null ->
            [];
        {?NPCF_OA_FEAT_EXCHANGE, NpcShopNo1} ->
            [NpcShopNo1]
    end,
    L3 = 
    case find_one_func_by_name(FuncList, ?NPCF_LITERARY_EXCHANGE) of
        null ->
            [];
        {?NPCF_LITERARY_EXCHANGE, NpcShopNo2} ->
            [NpcShopNo2]
    end,
    L1 ++ L2 ++ L3.

get_npc_exchange_no_list(Npc) ->
    FuncList = get_func_list(Npc),
    List = find_all_func_by_name(FuncList, ?NPCF_GOODS_EXCHANGE),
    [No || {_, No} <- List].


%% 获取npc采集信息
%% return: {Para, GoodsNo}  其中 Para可以是 任务id列表 或 每天可以采集的物品数量上限
get_npc_collect_info(Npc) ->
    FuncList = get_func_list(Npc),
    case find_one_func_by_name(FuncList, ?NPCF_COLLECT) of
        null ->
            ?ASSERT(false, Npc),
            null;
        {?NPCF_COLLECT, Para, GoodsNo} ->
            {Para, GoodsNo}
    end.

find_one_func_by_name(FuncList, FuncName) ->
    case lists:keyfind(FuncName, 1, FuncList) of
        false -> null;
        Func -> Func
    end. 


find_all_func_by_name(FuncList, FuncName) ->
    [Func || Func <- FuncList, element(1, Func) == FuncName].







%% 是否静态npc？
is_static_npc(Npc) when is_record(Npc, npc) ->
    get_id(Npc) < ?DYNAMIC_NPC_START_ID.


%% 是否属于动态npc？
is_dynamic_npc(Npc) when is_record(Npc, npc) ->
    % Npc#npc.type == ?NPC_T_DUNGEON
    % orelse Npc#npc.type == ?NPC_T_ACTIVITY
    % orelse Npc#npc.type == ?NPC_T_PATROL.

    get_id(Npc) >= ?DYNAMIC_NPC_START_ID.
    


%% 是否巡逻npc？
is_patrol_npc(Npc) ->
    get_type(Npc) == ?NPC_T_PATROL.
    

%% 是否巡游活动npc
is_cruise_activity_npc(Npc) ->
    get_type(Npc) == ?NPC_T_CRUISE_ACTIVITY.

is_couple_cruise_npc(Npc) ->
    get_type(Npc) == ?NPC_T_COUPLE_CRUISE.


is_static_npc_id(NpcId) ->
    NpcId < ?DYNAMIC_NPC_START_ID.


is_dynamic_npc_id(NpcId) ->
    NpcId >= ?DYNAMIC_NPC_START_ID.



%% 是否可移动？
is_moveable(NpcId) when is_integer(NpcId)  ->
    case get_obj(NpcId) of
        null ->
            ?ASSERT(false, NpcId),
            false;
        Npc ->
            is_moveable(Npc)
    end;
is_moveable(Npc) when is_record(Npc, npc) ->
    is_patrol_npc(Npc) orelse is_cruise_activity_npc(Npc) orelse is_couple_cruise_npc(Npc).





notify_bhv_state_changed_to_aoi(NpcObj, NewBhvState) ->
    lib_scene:notify_int_info_change_to_aoi(npc, NpcObj, [{?OI_CODE_BHV_STATE, NewBhvState}]).
            


% %% 找寻副本中的npc信息
% get_scene_by_npc_id1([], _NpcId) ->
%   [];
% get_scene_by_npc_id1([Scene|T], NpcId) ->
%   case data_scene:get(Scene) of
%       Sinfo when is_record(Sinfo, scene) ->
%           NpcL = Sinfo#scene.npcs,
%           case [[Nid,X,Y]||[Nid,X,Y]<-NpcL, Nid == NpcId] of
%               [[NpcId,X,Y]|_] ->
%                   [Scene, X, Y];
%               _R ->
%                   get_scene_by_npc_id1(T, NpcId)
%           end;
%       _ ->
%           get_scene_by_npc_id1(T, NpcId)
%   end.


                    
% %% 根据美女级别来获得名字
% get_protect_npc(Level) ->
%   if Level >= 1 andalso Level =< 5 ->
%          Nid = 9006 + Level,
%          case data_npc:get(Nid) of
%              Info when is_record(Info, npc) ->
%                  {Nid, Info#npc.name, Info#npc.icon};
%              _ ->
%                  {0,<<>>,0}
%          end;
%      true ->
%          {0,<<>>,0}
%   end.
          
%% -----------------------------------------------Locale---------------------------------------
