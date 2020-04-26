%%%------------------------------------
%%% @Module  : mod_npc_mgr
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2011.07.02
%%% @Modified : 2013.6.16 -- huangjf
%%% @Description: NPC管理
%%%------------------------------------
-module(mod_npc_mgr).
-behaviour(gen_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([start_link/0, 
        % get_next_id/0,
        do_clear_npc/1,

        add_to_dyn_npc_id_set/1,
        del_from_dyn_npc_id_set/1,

        on_server_clock_tick/2,
        dbg_assert_no_npcs_in_scene/1
        ]).

-include("common.hrl").
-include("record.hrl").
-include("ets_name.hrl").
-include("npc.hrl").
-include("abbreviate.hrl").

-record(state, {
        % auto_id = ?DYNAMIC_NPC_START_ID, 

        dyn_npc_id_set = undefined,  % 全服的动态npc对象id的集合
        npc_shop_no_list = [],
        time_to_update_npcs_bhv = 0,
        time_to_clear_expired_npcs = 0,
        time_to_refresh_npc_shop = 0
        }).


start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).


% %% 快速创建NPC， 注：快速的意思是创建时只是做了最简单的初始化工作。  如有需要，上层函数可以用返回值做进一步的初始化!
% %% @return: {ok, 新创建的npc} | fail
% fast_create_npc([NpcNo, SceneId, X, Y]) ->
%     gen_server:call(?MODULE, {'fast_create_npc', [NpcNo, SceneId, X, Y]}).


%% 作废！！
% %% 获取下一个有效的NPC id
% %% @return: fail | {ok, NewNpcId}
% get_next_id()->
%     case catch gen_server:call(?MODULE, 'get_next_id') of
%         {'EXIT', _Reason} ->
%             ?ERROR_MSG("[mod_npc_mgr] get_next_id() failed!! reason: ~w", [_Reason]),
%             fail;
%         NewNpcId when is_integer(NewNpcId) ->
%             {ok, NewNpcId}
%     end.



%% 清除NPC， 注：直接从ets删除，而没有先做其他清理工作。  上层函数可以先做其他一些必要的清理工作，然后再调用此接口。
do_clear_npc(NpcId) ->
    gen_server:cast(?MODULE, {'do_clear_npc', NpcId}).







%% 添加动态npc对象id到集合
add_to_dyn_npc_id_set(NpcId) ->
    ?ASSERT(mod_npc:is_dynamic_npc_id(NpcId), NpcId),
    gen_server:cast(?MODULE, {'add_to_dyn_npc_id_set', NpcId}).

del_from_dyn_npc_id_set(NpcId) ->
    ?ASSERT(mod_npc:is_dynamic_npc_id(NpcId), NpcId),
    gen_server:cast(?MODULE, {'del_from_dyn_npc_id_set', NpcId}).





-ifdef(debug).
%% （场景清除后）断言没有npc属于某个场景， 仅仅用于调试！
dbg_assert_no_npcs_in_scene(SceneId) ->
    gen_server:cast(?MODULE, {'dbg_assert_no_npcs_in_scene', SceneId}).

-else.

dbg_assert_no_npcs_in_scene(_SceneId) ->
    void.

-endif.



on_server_clock_tick(CurTickCount, CurUnixTime) ->
    gen_server:cast(?MODULE, {'on_server_clock_tick', CurTickCount, CurUnixTime}).



%% =========================================================================================
    
init([]) ->
    process_flag(trap_exit, true),
    State = #state{
                % auto_id = ?DYNAMIC_NPC_START_ID, % 从动态npc的起始id开始
                dyn_npc_id_set = sets:new(),
                npc_shop_no_list = sets:to_list(sets:from_list(data_npc_shop:get_all_npc_shop_no_list())),
                time_to_update_npcs_bhv = 0,
                time_to_clear_expired_npcs = 0,
                time_to_refresh_npc_shop = 0
                },  
    {ok, State}.

% handle_cast({'RESET', _Id} , State) ->
%     {noreply, State};



%% 更新npc行为的时间间隔（单位：秒）
-define(UPDATE_NPCS_BHV_INTV, 6).

%% 清除过期的npc的时间间隔（单位：秒）
-define(CLEAR_EXPIRED_NPCS_INTV, 20).

%% 清除过期的npc的时间间隔的浮动范围（单位：秒）
-define(CLEAR_EXPIRED_NPCS_INTV_FLOATING, 15).

%% 刷新npc商店的时间间隔（单位：秒）
-define(REFRESH_NPC_SHOP_INTV, 60).



handle_cast({'do_clear_npc', NpcId} , State) ->
    do_clear_npc__(NpcId),
    {noreply, State};



handle_cast({'dbg_assert_no_npcs_in_scene', _SceneId}, State) ->
    ?ASSERT(ets:match_object(?ETS_STATIC_NPC, #npc{scene_id = _SceneId, _ = '_'}) =:= []),
    ?ASSERT(ets:match_object(?ETS_DYNAMIC_NPC, #npc{scene_id = _SceneId, _ = '_'}) =:= []),
    {noreply, State};




handle_cast({'add_to_dyn_npc_id_set', NpcId} , State) ->
    OldSet = State#state.dyn_npc_id_set,
    ?ASSERT(not sets:is_element(NpcId, OldSet), {NpcId, sets:to_list(OldSet)}),
    NewSet = sets:add_element(NpcId, OldSet),
    ?DEBUG_MSG("add_to_dyn_npc_id_set, NpcId:~p, NewSetSize:~p", [NpcId, sets:size(NewSet)]),
    NewState = State#state{dyn_npc_id_set = NewSet},
    {noreply, NewState};


handle_cast({'del_from_dyn_npc_id_set', NpcId} , State) ->
    OldSet = State#state.dyn_npc_id_set,
    ?ASSERT(sets:is_element(NpcId, OldSet), {NpcId, sets:to_list(OldSet)}),
    NewSet = sets:del_element(NpcId, OldSet),
    ?DEBUG_MSG("del_from_dyn_npc_id_set, NpcId:~p, NewSetSize:~p", [NpcId, sets:size(NewSet)]),
    NewState = State#state{dyn_npc_id_set = NewSet},
    {noreply, NewState};





handle_cast({'on_server_clock_tick', _CurTickCount, CurUnixTime} , State) ->
    NewState =  case CurUnixTime >= State#state.time_to_update_npcs_bhv of
                    true ->
                        % ?TRACE("mod_npc_mgr, on_server_clock_tick...~n"),

                        % 只需处理动态npc
                        %%% NpcList = ets:tab2list(?ETS_DYNAMIC_NPC),  % 目前先简单用直接转为列表的方式


                        ?TRY_CATCH(foreach_npc(State, CurUnixTime), ErrReason),

                        State2 = State#state{time_to_update_npcs_bhv = CurUnixTime + ?UPDATE_NPCS_BHV_INTV},
                        State3 = case CurUnixTime >= State#state.time_to_clear_expired_npcs of
                                    true ->
                                        NextTimeToClearExpiredNpcs = CurUnixTime + ?CLEAR_EXPIRED_NPCS_INTV +  util:rand(0, ?CLEAR_EXPIRED_NPCS_INTV_FLOATING),
                                        State2#state{time_to_clear_expired_npcs = NextTimeToClearExpiredNpcs};
                                    false ->
                                        State2
                                end,
                        State4 = case CurUnixTime >= State#state.time_to_refresh_npc_shop of
                                    true ->
                                        ?TRY_CATCH(lib_npc:refresh_npc_shop(CurUnixTime, State#state.npc_shop_no_list), ErrReason_2),
                                        NextTimeToRefreshNpcShop = CurUnixTime + ?REFRESH_NPC_SHOP_INTV,
                                        State3#state{time_to_refresh_npc_shop = NextTimeToRefreshNpcShop};
                                    false ->
                                        State3
                                end,

                        State4;

                    false ->
                        State
                end,
    {noreply, NewState};



handle_cast(_R , State) ->
    ?ASSERT(false, _R),
    {noreply, State}.


% %% 创建NPC
% %% @return: {ok, 新创建的npc} | fail
% handle_call({'fast_create_npc', [NpcNo, SceneId, X, Y]} , _From, State) ->
%     case mod_npc_tpl:get_tpl_data(NpcNo) of
%         null ->
%             ?ASSERT(false, NpcNo),
%             {reply, fail, State};
%         NpcTpl ->
%             NewNpcId = State#state.auto_id,
%             NewNpc = NpcTpl#npc{
%                         id = NewNpcId,
%                         x = X,
%                         y = Y,
%                         scene_id = SceneId
%                         },
%             lib_npc:add_npc_to_ets(NewNpc),
%             {reply, {ok, NewNpc}, State#state{auto_id = NewNpcId + 1}}
%     end;



% %% 获取下一个有效的NPC id
% handle_call('get_next_id' , _From, State) ->
%     NewNpcId = State#state.auto_id,
%     {reply, NewNpcId, State#state{auto_id = NewNpcId + 1}};
            

handle_call(_R , _From, State) ->
    ?ASSERT(false, _R),
    {reply, ok, State}.

% %%todo:查询mid为none的NPC重新启动
% handle_info({'EXIT', _Mid, _Reason}, State) ->
%     {noreply, State};

handle_info(_Reason, State) ->
    {noreply, State}.

terminate(Reason, _State) ->
    case Reason of
        normal -> skip;
        shutdown -> skip;
        {shutdown, _} -> skip;
        _ ->
            ?ERROR_MSG("[~p] !!!!!terminate!!!!! for reason: ~w", [?MODULE, Reason])
    end,
    ok.

code_change(_OldVsn, State, _Extra)->
	{ok, State}.











foreach_npc(State, CurUnixTime) ->
    DynNpcIdSet = State#state.dyn_npc_id_set,

    % ?TRACE("[mod_npc_mgr] foreach_npc, DynNpcIdSet:~w~n", [sets:to_list(DynNpcIdSet)]),

    ?Ifc (sets:size(DynNpcIdSet) > 3000 andalso (erlang:get('__already_warn_so_many_npcs__') == undefined))
        ?WARNING_MSG("[mod_npc_mgr] npc count > 3000!!!!!!!!", []),
        erlang:put('__already_warn_so_many_npcs__', true)
    ?End,

    F = fun(NpcId, _Acc) ->
            ?ASSERT(is_integer(NpcId), NpcId),
            ?ASSERT(mod_npc:is_dynamic_npc_id(NpcId), NpcId),
            case mod_npc:get_obj(NpcId) of
                null ->
                    skip;
                NpcObj ->
                    handle_one_npc(NpcObj, State, CurUnixTime)
            end,
            void
        end,

    sets:fold(F, void, DynNpcIdSet).




handle_one_npc(NpcObj, State, CurUnixTime) ->

    update_npc_bhv(NpcObj),

    case CurUnixTime >= State#state.time_to_clear_expired_npcs of
        true -> try_clear_expired_npc(NpcObj);
        false -> skip
    end.

                        




% update_npcs_behavior(_NpcList) ->
%     todo_here.


update_npc_bhv(_NpcObj) ->
    % ?TRACE("[mod_npc_mgr] update_npc_bhv(), NpcId:~p~n", [mod_npc:get_id(_NpcObj)]),
    todo_here.


% %% 清除过期的npc
% clear_expired_npcs(NpcList) ->
%     lists:foreach(fun try_clear_expired_npc/1, NpcList).




try_clear_expired_npc(NpcObj) ->
    case mod_npc:is_expired(NpcObj) of
        true ->     
            NpcId = mod_npc:get_id(NpcObj),
            ?DEBUG_MSG("[mod_npc_mgr] clear expired npc!!! NpcId:~p, TimeNow:~p, NpcExpireTime:~p", [NpcId, svr_clock:get_unixtime(), NpcObj#npc.expire_time]),
            mod_scene:clear_dynamic_npc_from_scene_WNC(NpcId);      
        false ->
            % ?DEBUG_MSG("[mod_npc_mgr] try_clear_expired_npc(), not expired yet! NpcId:~p, TimeNow:~p, NpcExpireTime:~p", [mod_npc:get_id(Npc), svr_clock:get_unixtime(), Npc#npc.expire_time]),
            skip
    end.



do_clear_npc__(NpcId) ->
    ?ASSERT(mod_npc:is_exists(NpcId), NpcId),
    mod_npc:del_npc_from_ets(NpcId).
