%%%-------------------------------------- 
%%% @Module: lib_bt_dict
%%% @Author: huangjf
%%% @Created: 2013.11.30
%%% @Description: 战斗进程的进程字典的相关函数
%%%-------------------------------------- 


-module(lib_bt_dict).
-export([
        add_bo_to_battle_field/3,
		remove_bo_from_battle_field/1,

        get_preset_rand_pos_order/0,
        set_preset_rand_pos_order/1,

        init_spawned_bmon_list/0,
        get_spawned_bmon_list/0,
        add_to_spawned_bmon_list/2,

        record_melee_init_player_id_list/1,
        get_melee_init_player_id_list/1,

        get_cur_actor_list/0,
        set_cur_actor_list/1,

        get_cur_actor_id/0,
        set_cur_actor_id/1,

        remove_bo_from_cur_actor_list/1,

        add_to_pvp_player_id_list/2,
        get_pvp_player_id_list/1,

        
        get_cur_bmon_group_no/0,
        set_cur_bmon_group_no/1,

        incr_nth_wave_bmon_group/0,

        get_dead_partner_left_mp/1,
        set_dead_partner_left_mp/2,

        get_world_boss_mf_info/0,
        record_world_boss_mf_info/0,

        should_cur_round_force_finish/0,
        mark_cur_round_should_force_finish/0,
        unmark_cur_round_should_force_finish/0,
        

        get_battle_log_file_fd/0,
        set_battle_log_file_fd/1



        
    ]).
    
-include("common.hrl").
-include("buff.hrl").
% -include("record.hrl").
% -include("skill.hrl").
-include("battle.hrl").
-include("record/battle_record.hrl").
% -include("battle_buff.hrl").
% -include("effect.hrl").



-import(lib_bt_comm, [
            get_bo_by_id/1,
            is_dead/1,
            is_bo_exists/1
            ]).




%% 添加bo到战场
add_bo_to_battle_field(NewBoId, NewBo, Side) ->
    put(NewBoId, NewBo),      % 注意：方便起见，直接以战斗对象id作为key，把bo加到进程字典！！
    % 添加到对应方的bo id列表
    add_bo_id_to_side(NewBoId, Side).





%% 从战场移除bo
remove_bo_from_battle_field(BoId) ->

    % 从当前行动者列表中移除  TODO: 确认-- 放在此处是否ok？？
    try_remove_bo_from_cur_actor_list(BoId),

    Bo = erase(BoId), % TODO: 确认要erase掉？ 对于怪物如果不erase掉是否会让代码写起来更方便些？？
    ?ASSERT(is_record(Bo, battle_obj), {BoId, Bo}),

    Side = lib_bo:get_side(Bo),
    remove_bo_id_from_side(BoId, Side).




get_preset_rand_pos_order() ->
    get(?KN_PRESET_RAND_POS_ORDER).

set_preset_rand_pos_order(RandPosList) ->
    put(?KN_PRESET_RAND_POS_ORDER, RandPosList).




init_spawned_bmon_list() ->
    put(?KN_SPAWNED_BMON_LIST, []).

get_spawned_bmon_list() ->
    L = get(?KN_SPAWNED_BMON_LIST),
    ?ASSERT(is_list(L), L),
    L.

set_spawned_bmon_list(L) ->
    ?TRACE("set_spawned_bmon_list(), L=~p~n", [L]),
    put(?KN_SPAWNED_BMON_LIST, L).


add_to_spawned_bmon_list(BMonNo, Count) ->
    OldList = get_spawned_bmon_list(),
    NewList =
        case lists:keyfind(BMonNo, 1, OldList) of
            false ->
                [{BMonNo, Count} | OldList];
            {BMonNo, OldCount} ->
                lists:keyreplace(BMonNo, 1, OldList, {BMonNo, OldCount + Count})
        end,
    set_spawned_bmon_list(NewList).


%% 记录女妖乱斗活动的战斗开始时某一方的玩家id列表（不包括雇佣的玩家）
record_melee_init_player_id_list(Side) ->
    ?ASSERT(Side == ?HOST_SIDE orelse Side == ?GUEST_SIDE),
    L = lib_bt_comm:get_player_id_list_except_hired_player(Side),
    erlang:put({?KN_MELEE_INIT_PLAYER_ID_LIST, Side}, L).


%% 获取女妖乱斗活动的战斗开始时某一方的玩家id列表（不包括雇佣的玩家）
get_melee_init_player_id_list(Side) ->
    ?ASSERT(Side == ?HOST_SIDE orelse Side == ?GUEST_SIDE),
    case erlang:get({?KN_MELEE_INIT_PLAYER_ID_LIST, Side}) of
        undefined ->
            [];
        Val ->
            ?ASSERT(util:is_integer_list(Val), {Side, Val}),
            Val
    end.



%% 获取当前的行动者列表（战斗对象id的列表）
get_cur_actor_list() ->
    get(?KN_CUR_ACTOR_LIST).


set_cur_actor_list(L) ->
    ?ASSERT(util:is_integer_list(L), L),
    put(?KN_CUR_ACTOR_LIST, L).


% update_cur_actor_list(List_New) ->
%     set_cur_actor_list(List_New).


%% 获取当前行动者id
get_cur_actor_id() ->
    get(?KN_CUR_ACTOR_ID).


%% 设置当前行动者id
set_cur_actor_id(BoId) ->
    ?ASSERT(is_integer(BoId), BoId),
    put(?KN_CUR_ACTOR_ID, BoId).



add_bo_id_to_side(NewBoId, Side) ->
    L = lib_bt_comm:get_bo_id_list(Side),
    lib_bt_comm:set_bo_id_list(Side, L ++ [NewBoId]).



remove_bo_id_from_side(BoId, Side) ->
    L = lib_bt_comm:get_bo_id_list(Side),
    lib_bt_comm:set_bo_id_list(Side,  L -- [BoId]).





%% 从当前行动者列表删除指定的bo
remove_bo_from_cur_actor_list(BoId) ->
    L = get_cur_actor_list(),
    ?ASSERT(lists:member(BoId, L) 
                orelse (not is_bo_exists(BoId))  
                orelse is_dead(get_bo_by_id(BoId)), {BoId, L}),
    set_cur_actor_list(L -- [BoId]).



%% 尝试从当前行动者列表删除指定的bo
try_remove_bo_from_cur_actor_list(BoId) ->
    L = get_cur_actor_list(),
    case lists:member(BoId, L) of
        true ->
            remove_bo_from_cur_actor_list(BoId);
        false ->
            skip
    end.






%% 添加到pvp战斗中某一方的玩家id列表， 注：添加之后，目前不受玩家战斗过程中逃跑的影响，会一直记录在案
add_to_pvp_player_id_list(PlayerId, Side) ->
    State = lib_bt_comm:get_battle_state(),
    State2 = case Side of
                ?HOST_SIDE ->
                    OldList = State#btl_state.pvp_player_id_list_host,
                    State#btl_state{pvp_player_id_list_host = OldList ++ [PlayerId]};
                ?GUEST_SIDE ->
                    OldList = State#btl_state.pvp_player_id_list_guest,
                    State#btl_state{pvp_player_id_list_guest = OldList ++ [PlayerId]}
            end,

    ?BT_LOG(io_lib:format("add_to_pvp_player_id_list(), PlayerId:~p, Side:~p, NewList_Host:~w, NewList_Guest:~w~n", [PlayerId, Side, State2#btl_state.pvp_player_id_list_host, State2#btl_state.pvp_player_id_list_guest])),

    % 断言列表中没有重复的元素        
    ?ASSERT( length(gb_sets:to_list(gb_sets:from_list(State2#btl_state.pvp_player_id_list_host))) == length(State2#btl_state.pvp_player_id_list_host), State2),
    ?ASSERT( length(gb_sets:to_list(gb_sets:from_list(State2#btl_state.pvp_player_id_list_guest))) == length(State2#btl_state.pvp_player_id_list_guest), State2),

    lib_bt_comm:set_battle_state(State2).

    
%% 获取pvp战斗中某一方的玩家id
get_pvp_player_id_list(Side) ->
    State = lib_bt_comm:get_battle_state(),
    case Side of
        ?HOST_SIDE ->
            State#btl_state.pvp_player_id_list_host;
        ?GUEST_SIDE ->
            State#btl_state.pvp_player_id_list_guest
    end.





get_cur_bmon_group_no() ->
    State = lib_bt_comm:get_battle_state(),
    State#btl_state.bmon_group_no.

set_cur_bmon_group_no(BMonGroupNo) ->
    ?ASSERT(is_integer(BMonGroupNo)),
    State = lib_bt_comm:get_battle_state(),
    State2 = State#btl_state{bmon_group_no = BMonGroupNo},
    lib_bt_comm:set_battle_state(State2).



incr_nth_wave_bmon_group() ->
    State = lib_bt_comm:get_battle_state(),
    NewVal = State#btl_state.nth_wave_bmon_group + 1,
    State2 = State#btl_state{nth_wave_bmon_group = NewVal},
    lib_bt_comm:set_battle_state(State2),
    {ok, NewVal}.



get_dead_partner_left_mp(ParBoId) ->
    case get({?KN_DEAD_PARTNER_LEFT_MP, ParBoId}) of
        undefined ->
            0;
        Val ->
            ?ASSERT(util:is_nonnegative_int(Val), Val),
            Val
    end.
    
set_dead_partner_left_mp(ParBoId, Val) ->
    ?ASSERT(util:is_nonnegative_int(Val), Val),
    put({?KN_DEAD_PARTNER_LEFT_MP, ParBoId}, Val).






get_world_boss_mf_info() ->
    erlang:get(?KN_WORLD_BOSS_MF_INFO).


record_world_boss_mf_info() ->
    BtlState = lib_bt_comm:get_battle_state(),
    WorldBossBo = lib_bt_misc:find_world_boss_bo(),
    ?ASSERT(WorldBossBo /= null),
    %%% PlayerBoList = lib_bt_comm:get_player_bo_list(?HOST_SIDE),
    %%% ?ASSERT(PlayerBoList /= []),
    %%% PlayerIdList = [lib_bo:get_parent_obj_id(X) || X <- PlayerBoList],
    PlayerIdList = lib_bt_comm:get_player_id_list_except_hired_player(?HOST_SIDE),
    ?ASSERT(PlayerIdList /= []),
    HiredPlayerIdList = lib_bt_comm:get_hired_player_id_list(?HOST_SIDE),
    Info = #wb_mf_info{
                boss_no = BtlState#btl_state.mon_no,
                init_hp = lib_bo:get_hp(WorldBossBo),
                init_player_id_list = PlayerIdList,
                hired_player_id_list = HiredPlayerIdList
                },
    erlang:put(?KN_WORLD_BOSS_MF_INFO, Info).



%% 当前回合是否需要强行立即结束？（默认为false）
should_cur_round_force_finish() ->
    case erlang:get(?KN_SHOULD_CUR_ROUND_FORCE_FINISH) of
        undefined -> false;
        Val -> ?ASSERT(is_boolean(Val)), Val
    end.

%% 标记当前回合需要强行立即结束
mark_cur_round_should_force_finish() ->
    erlang:put(?KN_SHOULD_CUR_ROUND_FORCE_FINISH, true).

%% 清除当前回合需要强行立即结束的标记
unmark_cur_round_should_force_finish() ->
    erlang:put(?KN_SHOULD_CUR_ROUND_FORCE_FINISH, false).


            
%% 作废！！
% %% 记录出战的雇佣玩家id， 注：记录之后，不受玩家战斗过程中逃跑的影响，会一直记录在案
% record_hired_player_id(HiredPlayerId, Side) ->
%     State = lib_bt_comm:get_battle_state(),
%     State2 = case Side of
%                 ?HOST_SIDE ->
%                     State#btl_state{hired_player_id_host = HiredPlayerId};
%                 ?GUEST_SIDE ->
%                     State#btl_state{hired_player_id_guest = HiredPlayerId}
%             end,
%     lib_bt_comm:set_battle_state(State2).
    
 
% %% 获取出战的雇佣玩家id
% get_hired_player_id(Side) ->
%     State = lib_bt_comm:get_battle_state(),
%     case Side of
%         ?HOST_SIDE ->
%             State#btl_state.hired_player_id_host;
%         ?GUEST_SIDE ->
%             State#btl_state.hired_player_id_guest
%     end.


get_battle_log_file_fd() ->
    get(?KN_BATTLE_LOG_FILE_FD).


set_battle_log_file_fd(Fd) ->
    put(?KN_BATTLE_LOG_FILE_FD, Fd).
