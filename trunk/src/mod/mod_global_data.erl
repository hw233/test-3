%%%-------------------------------------------------
%%% @Module  : mod_global_data
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2014.3.13
%%% @Description: 全局的数据（通常是静态数据，除玩家id列表外）  
%%%-------------------------------------------------

-module(mod_global_data).
-behaviour(gen_server).
-export([start_link/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-export([
        get_main_city_scene_no/0,
		get_city_scene_no_list/0,
        get_equip_add_sum_weight/0,                  
        get_cruise_activity_npc_no/0,
        is_player_deleted/1,
        add_player_id/1
	   ]).

-include("ets_name.hrl").
-include("record/goods_record.hrl").
-include("common.hrl").
-include("scene.hrl").

-define(GLOBAL_DATA_PROCESS, global_data_process).

-define(KN_CITY_SCENE_NO_LIST, kn_city_scene_no_list).
-define(KN_EQUIP_ADD_SUM_WEIGHT, kn_equip_add_sum_weight).
-define(KN_CRUISE_ACTIVITY_NPC_NO, kn_cruise_activity_npc_no).
-define(KN_PLAYER_IDS, kn_player_ids).                              %% 全服玩家id


add_player_id(PlayerId) ->
    gen_server:cast(?GLOBAL_DATA_PROCESS, {'add_player_id', PlayerId}).    

start_link() ->
    gen_server:start_link({local, ?GLOBAL_DATA_PROCESS}, ?MODULE, [], []).

init([]) ->
    ets:new(?ETS_GLOBAL_DATA, [named_table, public, set, {read_concurrency, true}]),
    init_city_scene_no_list(),
    init_equip_add_sum_weight(),
    init_cruise_activity_npc_no(),
    %% @doc 加载IP白名单
    misc:load_security_ips(),
    init_player_ids(),
    {ok, none}.


handle_call(Request, From, State) ->
    try
        handle_call_2(Request, From, State)
    catch
        Err:Reason ->
            ?ERROR_MSG("ERR:~p,Reason:~p",[Err,Reason]),
             {reply, error, State}
    end.


handle_call_2(_Request, _From, State) ->
    {reply, State, State}.


handle_cast(Request, State) ->
    try
        handle_cast_2(Request, State)
    catch
        Err:Reason ->
            ?ERROR_MSG("ERR:~p,Reason:~p",[Err,Reason]),
            {noreply, State}
    end.


handle_cast_2({'add_player_id', PlayerId}, State) ->
    case ets:lookup(?ETS_GLOBAL_DATA, ?KN_PLAYER_IDS) of
        [] ->
            ?ERROR_MSG("mod_global_data,load global data error~n", []);
        [{?KN_PLAYER_IDS, GbSets}] ->
            ets:insert(?ETS_GLOBAL_DATA, {?KN_PLAYER_IDS, gb_sets:add_element(PlayerId, GbSets)})
    end,  
    {noreply, State};

handle_cast_2(_Msg, State) ->
    {noreply, State}.


handle_info(_Info, State) ->
    {noreply, State}.

terminate(Reason, _State) ->
    case Reason of
        normal -> skip;
        shutdown -> skip;
        _ -> ?ERROR_MSG("[mod_global_data] !!!!!terminate!!!!! for reason: ~w", [Reason])
    end,
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.
    


%% 获取主城的场景编号
get_main_city_scene_no() ->
    ?MAIN_CITY_SCENE_NO.


%% 获取城市场景的编号列表
get_city_scene_no_list() ->
    case ets:lookup(?ETS_GLOBAL_DATA, ?KN_CITY_SCENE_NO_LIST) of
        [] ->
            [];
        [{?KN_CITY_SCENE_NO_LIST, L}] ->
            L
    end.
    

%% 获取计算装备附加属性用到的权重之和
get_equip_add_sum_weight() ->
    case ets:lookup(?ETS_GLOBAL_DATA, ?KN_EQUIP_ADD_SUM_WEIGHT) of
        [] ->
            error;
        [{?KN_EQUIP_ADD_SUM_WEIGHT, Sum}] ->
            Sum
    end.

is_player_deleted(PlayerId) ->
    case ets:lookup(?ETS_GLOBAL_DATA, ?KN_PLAYER_IDS) of
        [] ->
            false;
        [{?KN_PLAYER_IDS, GbSets}] ->
            not gb_sets:is_element(PlayerId, GbSets)
    end.    


%% 获取巡游活动npc的编号
get_cruise_activity_npc_no() ->
    case ets:lookup(?ETS_GLOBAL_DATA, ?KN_CRUISE_ACTIVITY_NPC_NO) of
        [] ->
            error;
        [{?KN_CRUISE_ACTIVITY_NPC_NO, NpcNo}] ->
            NpcNo
    end.





%% ===============================================================================================================



%% 初始化城市场景列表
init_city_scene_no_list() ->
    L = data_scene:get_no_list(), 
    F = fun(SceneNo) ->
            SceneTpl = mod_scene_tpl:get_tpl_data(SceneNo),
            mod_scene_tpl:is_city_scene(SceneTpl)
        end,
    CitySceneNoList = [X || X <- L, F(X)],
    ets:insert(?ETS_GLOBAL_DATA, {?KN_CITY_SCENE_NO_LIST, CitySceneNoList}).


%% 初始化计算装备附加属性用到的权重之和
init_equip_add_sum_weight() ->
    F = fun(Lv, Sum) ->
        Data = data_equip_add_lv:get(Lv),
        Sum + Data#equip_add_lv.weight
    end,
    SumRet = util:ceil(lists:foldl(F, 0, data_equip_add_lv:get_all_lv_list())),
    ?ASSERT(SumRet >= 1, SumRet),
    ets:insert(?ETS_GLOBAL_DATA, {?KN_EQUIP_ADD_SUM_WEIGHT, SumRet}).    


init_player_ids() ->
    GbSets = gb_sets:new(),
    GbSets1 = 
        case db:select_all(player, "id", []) of
            InfoList_List when is_list(InfoList_List) ->
                F = fun([Id], Acc) ->
                    gb_sets:add_element(Id, Acc)
                end,
                lists:foldl(F, GbSets, InfoList_List);
            _Any ->
                GbSets
        end,
    ets:insert(?ETS_GLOBAL_DATA, {?KN_PLAYER_IDS, GbSets1}).    


%% 初始化巡游活动npc的编号
init_cruise_activity_npc_no() ->
    L = data_npc:get_all_npc_no_list(),
    init_cruise_activity_npc_no__(L).


init_cruise_activity_npc_no__([]) ->
    ?ERROR_MSG("[mod_global_data] init_cruise_activity_npc_no__() error!! no such npc!", []),
    error;
init_cruise_activity_npc_no__([NpcNo | T]) ->
    NpcTpl = mod_npc_tpl:get_tpl_data(NpcNo),
    case mod_npc_tpl:is_cruise_activity_npc(NpcTpl) of
        true ->
            NpcNo = mod_npc_tpl:get_no(NpcTpl),
            ?TRACE("~n~ncruise activity npc no:~p~n~n", [NpcNo]),
            ets:insert(?ETS_GLOBAL_DATA, {?KN_CRUISE_ACTIVITY_NPC_NO, NpcNo}),
            ok;
        false ->
            init_cruise_activity_npc_no__(T)
    end.

    



