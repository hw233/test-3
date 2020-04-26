%%%--------------------------------------
%%% @Module   : ply_setting 
%%% @Author   : zhangwq
%%% @Email    : 
%%% @Created  : 2014.3.11

%%%--------------------------------------
-module(ply_setting).
-export([
        is_auto_add_store_hp_mp/1, 
        set_auto_add_store_hp_mp/2,

        is_auto_add_store_par_hp_mp/1, 
        set_auto_add_store_par_hp_mp/2,

        is_cant_be_leader/1,
        set_can_be_leader_state/2,

        accept_team_invite/1,
        set_accept_team_invite_state/2,

        accept_friend_invite/1,
        set_accept_friend_state/2,

        accept_pk/1,
        set_accept_pk_state/2,

        is_par_clothes_hide/1,
        set_par_clothes_hide/2,

        is_headwear_hide/1,
        set_headwear_hide/2,

        is_backwear_hide/1,
        set_backwear_hide/2,

        is_clothes_hide/1,
        set_clothes_hide/2,

		get_paodian_type/1,
        set_paodian_type/2,
		
        db_save_player_setting/1,
        del_sys_setting_from_ets/1
    ]).

-include("common.hrl").
-include("sys_set.hrl").
-include("ets_name.hrl").
-include("record.hrl").
-include("obj_info_code.hrl").

%% return true | false
is_auto_add_store_hp_mp(PlayerId) ->
    ?ASSERT(is_integer(PlayerId), PlayerId),
    SysSet = get_sys_set_from_ets(PlayerId),
    SysSet#sys_set.is_auto_add_hp_mp =:= 1.
    

%% para State：1--是，0--否
set_auto_add_store_hp_mp(PlayerId, State) ->
    ?ASSERT(is_integer(PlayerId), PlayerId),
    SysSet = get_sys_set_from_ets(PlayerId),
    NewSysSet = SysSet#sys_set{is_auto_add_hp_mp = State},
    update_sys_set_to_ets(mark_sys_set_dirty(NewSysSet)).


is_auto_add_store_par_hp_mp(PlayerId) ->
    ?ASSERT(is_integer(PlayerId), PlayerId),
    SysSet = get_sys_set_from_ets(PlayerId),
    SysSet#sys_set.is_auto_add_par_hp_mp =:= 1.

%% para State：1--是，0--否
set_auto_add_store_par_hp_mp(PlayerId, State) ->
    ?ASSERT(is_integer(PlayerId), PlayerId),
    SysSet = get_sys_set_from_ets(PlayerId),
    NewSysSet = SysSet#sys_set{is_auto_add_par_hp_mp = State},
    update_sys_set_to_ets(mark_sys_set_dirty(NewSysSet)).


is_cant_be_leader(PlayerId) ->
    ?ASSERT(is_integer(PlayerId), PlayerId),
    SysSet = get_sys_set_from_ets(PlayerId),
    SysSet#sys_set.is_accepted_leader =:= 0.

set_can_be_leader_state(PlayerId, State) ->
    ?ASSERT(is_integer(PlayerId), PlayerId),
    SysSet = get_sys_set_from_ets(PlayerId),
    NewSysSet = SysSet#sys_set{is_accepted_leader = State},
    update_sys_set_to_ets(mark_sys_set_dirty(NewSysSet)).


accept_team_invite(PlayerId) ->
    SysSet = get_sys_set_from_ets(PlayerId),
    SysSet#sys_set.is_accepted_team_mb =:= 0.

set_accept_team_invite_state(PlayerId, State) ->
    ?ASSERT(is_integer(PlayerId), PlayerId),
    SysSet = get_sys_set_from_ets(PlayerId),
    NewSysSet = SysSet#sys_set{is_accepted_team_mb = State},
    update_sys_set_to_ets(mark_sys_set_dirty(NewSysSet)).


accept_friend_invite(PlayerId) ->
    ?ASSERT(is_integer(PlayerId), PlayerId),
    SysSet = get_sys_set_from_ets(PlayerId),
    SysSet#sys_set.is_accepted_friend =:= 0.


set_accept_friend_state(PlayerId, State) ->
    ?ASSERT(is_integer(PlayerId), PlayerId),
    SysSet = get_sys_set_from_ets(PlayerId),
    NewSysSet = SysSet#sys_set{is_accepted_friend = State},
    update_sys_set_to_ets(mark_sys_set_dirty(NewSysSet)).


accept_pk(PlayerId) ->
    ?ASSERT(is_integer(PlayerId), PlayerId),
    SysSet = get_sys_set_from_ets(PlayerId),
    SysSet#sys_set.is_accepted_pk =:= 0.


set_accept_pk_state(PlayerId, State) ->
    ?ASSERT(is_integer(PlayerId), PlayerId),
    SysSet = get_sys_set_from_ets(PlayerId),
    NewSysSet = SysSet#sys_set{is_accepted_pk = State},
    update_sys_set_to_ets(mark_sys_set_dirty(NewSysSet)).

is_par_clothes_hide(PlayerId) ->
    ?ASSERT(is_integer(PlayerId), PlayerId),
    SysSet = get_sys_set_from_ets(PlayerId),
    SysSet#sys_set.is_par_clothes_hide =:= 1.

set_par_clothes_hide(PS, State) ->
    SysSet = get_sys_set_from_ets(player:id(PS)),
    NewSysSet = SysSet#sys_set{is_par_clothes_hide = State},
    update_sys_set_to_ets(mark_sys_set_dirty(NewSysSet)),
    case player:get_follow_partner_id(PS) of
        ?INVALID_ID -> skip;
        PartnerId ->
            case lib_partner:get_partner(PartnerId) of
                null -> skip;
                Partner ->
                    ShowEquips = lib_partner:get_showing_equips(Partner),
                    case State of
                        0 -> %% 0--展示，1--不展示
                            case ShowEquips#showing_equip.clothes =:= ?INVALID_NO of
                                true -> skip;
                                false -> lib_partner:notify_main_partner_info_change_to_AOI(PS, Partner)
                            end;
                        1 ->
                            case ShowEquips#showing_equip.clothes =:= ?INVALID_NO of
                                true -> skip;
                                false -> lib_partner:notify_main_partner_info_change_to_AOI(PS, Partner)
                            end
                    end
            end
    end.


is_headwear_hide(PlayerId) ->
    ?ASSERT(is_integer(PlayerId), PlayerId),
    SysSet = get_sys_set_from_ets(PlayerId),
    SysSet#sys_set.is_headwear_hide =:= 1.

set_headwear_hide(PS, State) ->
    SysSet = get_sys_set_from_ets(player:id(PS)),
    NewSysSet = SysSet#sys_set{is_headwear_hide = State},
    update_sys_set_to_ets(mark_sys_set_dirty(NewSysSet)),
    ShowEquips = player:get_showing_equips(PS),
    case State of
        0 ->
            case ShowEquips#showing_equip.headwear =:= ?INVALID_NO of
                true -> skip;
                false -> lib_scene:notify_int_info_change_to_aoi(player, player:get_id(PS), [{?OI_CODE_HEADWEAR, ShowEquips#showing_equip.headwear}])
            end;
        1 ->
            case ShowEquips#showing_equip.headwear =:= ?INVALID_NO of
                true -> skip;
                false -> lib_scene:notify_int_info_change_to_aoi(player, player:get_id(PS), [{?OI_CODE_HEADWEAR, ?INVALID_NO}])
            end
    end.


is_backwear_hide(PlayerId) ->
    ?ASSERT(is_integer(PlayerId), PlayerId),
    SysSet = get_sys_set_from_ets(PlayerId),
    SysSet#sys_set.is_backwear_hide =:= 1.

set_backwear_hide(PS, State) ->
    SysSet = get_sys_set_from_ets(player:id(PS)),
    NewSysSet = SysSet#sys_set{is_backwear_hide = State},
    update_sys_set_to_ets(mark_sys_set_dirty(NewSysSet)),
    ShowEquips = player:get_showing_equips(PS),
    case State of
        0 ->
            case ShowEquips#showing_equip.backwear =:= ?INVALID_NO of
                true -> skip;
                false -> lib_scene:notify_int_info_change_to_aoi(player, player:get_id(PS), [{?OI_CODE_BACKWEAR, ShowEquips#showing_equip.backwear}])
            end;
        1 ->
            case ShowEquips#showing_equip.backwear =:= ?INVALID_NO of
                true -> skip;
                false -> lib_scene:notify_int_info_change_to_aoi(player, player:get_id(PS), [{?OI_CODE_BACKWEAR, ?INVALID_NO}])
            end
    end.

is_clothes_hide(PlayerId) ->
    ?ASSERT(is_integer(PlayerId), PlayerId),
    SysSet = get_sys_set_from_ets(PlayerId),
    SysSet#sys_set.is_clothes_hide =:= 1.


set_clothes_hide(PS, State) ->
    SysSet = get_sys_set_from_ets(player:id(PS)),
    NewSysSet = SysSet#sys_set{is_clothes_hide = State},
    update_sys_set_to_ets(mark_sys_set_dirty(NewSysSet)),
    ShowEquips = player:get_showing_equips(PS),
    case State of
        0 ->
            case ShowEquips#showing_equip.clothes =:= ?INVALID_NO of
                true -> skip;
                false -> lib_scene:notify_int_info_change_to_aoi(player, player:get_id(PS), [{?OI_CODE_CLOTHES, ShowEquips#showing_equip.clothes}])
            end;
        1 ->
            case ShowEquips#showing_equip.clothes =:= ?INVALID_NO of
                true -> skip;
                false -> lib_scene:notify_int_info_change_to_aoi(player, player:get_id(PS), [{?OI_CODE_CLOTHES, ?INVALID_NO}])
            end
    end.


get_paodian_type(PlayerId) ->
    ?ASSERT(is_integer(PlayerId), PlayerId),
    SysSet = get_sys_set_from_ets(PlayerId),
    SysSet#sys_set.paodian_type.

set_paodian_type(PS, Type) ->
    SysSet = get_sys_set_from_ets(player:id(PS)),
    NewSysSet = SysSet#sys_set{paodian_type = Type},
    update_sys_set_to_ets(mark_sys_set_dirty(NewSysSet)),

    % 通知场景中该玩家的泡点模式改变
    lib_scene:notify_int_info_change_to_aoi(player, player:get_id(PS), [{?OI_CODE_PAODIAN_TYPE, Type}]).


db_save_player_setting(PlayerId) ->
    ?ASSERT(is_integer(PlayerId), PlayerId),
    case get_sys_set_from_ets(PlayerId) of
        null -> skip;
        SysSet ->
            case is_dirty(SysSet) of
                false -> skip;
                true ->
                    db:replace(PlayerId, sys_set, 
                    [{player_id, SysSet#sys_set.player_id}, 
                     {is_auto_add_hp_mp, SysSet#sys_set.is_auto_add_hp_mp}, 
                     {is_auto_add_par_hp_mp, SysSet#sys_set.is_auto_add_par_hp_mp}, 
                     {is_accepted_leader, SysSet#sys_set.is_accepted_leader},
                     {is_accepted_team_mb, SysSet#sys_set.is_accepted_team_mb}, 
                     {is_accepted_friend, SysSet#sys_set.is_accepted_friend}, 
                     {is_accepted_pk, SysSet#sys_set.is_accepted_pk},
                     {is_par_clothes_hide, SysSet#sys_set.is_par_clothes_hide},
                     {is_headwear_hide, SysSet#sys_set.is_headwear_hide},
                     {is_backwear_hide, SysSet#sys_set.is_backwear_hide},
                     {is_clothes_hide, SysSet#sys_set.is_clothes_hide},
					 {paodian_type, SysSet#sys_set.paodian_type}
                     ])
            end
    end.


% on_player_final_logout(PlayerId) ->
%     del_sys_set_from_ets(PlayerId).

del_sys_setting_from_ets(PlayerId) ->
    ?ASSERT(is_integer(PlayerId)),
    ets:delete(?ETS_SYS_SET, PlayerId).



%% ------------------------------------------------------Local fun----------------------------------------

% db_insert_player_sys_set(SysSet) when is_record(SysSet, sys_set) ->
%     db:insert(SysSet#sys_set.player_id, sys_set, [player_id, is_auto_add_hp_mp, is_auto_add_par_hp_mp, is_accepted_leader, is_accepted_team_mb, is_accepted_friend, is_accepted_pk], 
%     [SysSet#sys_set.player_id, SysSet#sys_set.is_auto_add_hp_mp, SysSet#sys_set.is_auto_add_par_hp_mp, SysSet#sys_set.is_accepted_leader, 
%     SysSet#sys_set.is_accepted_team_mb, SysSet#sys_set.is_accepted_friend, SysSet#sys_set.is_accepted_pk]).


db_load_player_setting(PlayerId) ->
    ?ASSERT(is_integer(PlayerId), PlayerId),
    case db:select_row(sys_set, "player_id, is_auto_add_hp_mp, is_auto_add_par_hp_mp, is_accepted_leader, is_accepted_team_mb, is_accepted_friend, is_accepted_pk,
        is_par_clothes_hide, is_headwear_hide, is_backwear_hide, is_clothes_hide,paodian_type", [{player_id, PlayerId}], [], [1]) of
        [PlayerId, IsAutoAddHpMp, IsAutoAddParHpMp, IsAcceptedLeader, IsAcceptedTeamMb, IsAcceptedFriend, IsAcceptedPK, 
        IsParClothesHide, IsHeadwearHide, IsBackwearHide, IsClothesHide,PaodianType] ->
            SysSet = #sys_set{
                player_id = PlayerId,
                is_auto_add_hp_mp = IsAutoAddHpMp,
                is_auto_add_par_hp_mp = IsAutoAddParHpMp,
                is_accepted_leader = IsAcceptedLeader,
                is_accepted_team_mb = IsAcceptedTeamMb,
                is_accepted_friend = IsAcceptedFriend,
                is_accepted_pk = IsAcceptedPK,
                is_par_clothes_hide = IsParClothesHide,
                is_headwear_hide = IsHeadwearHide,
                is_backwear_hide = IsBackwearHide,
                is_clothes_hide = IsClothesHide,
                paodian_type = PaodianType
            },
            
            SysSet;
        _ ->
            DefSysSet = #sys_set{player_id = PlayerId},
            DefSysSet
    end.


add_sys_set_to_ets(SysSet) when is_record(SysSet, sys_set) ->
    ets:insert(?ETS_SYS_SET, SysSet).


update_sys_set_to_ets(SysSet) when is_record(SysSet, sys_set) ->
    ets:insert(?ETS_SYS_SET, SysSet).


%% 动态加载玩家设置，return sys_set 结构体
get_sys_set_from_ets(PlayerId) ->
    ?ASSERT(is_integer(PlayerId), PlayerId),
    case ets:lookup(?ETS_SYS_SET, PlayerId) of
        [] -> 
            SysSet = db_load_player_setting(PlayerId),
            add_sys_set_to_ets(SysSet),
            SysSet;
        [SysSet] ->
            SysSet
    end.




mark_sys_set_dirty(SysSet) ->
    SysSet#sys_set{is_dirty = true}.


is_dirty(SysSet) ->
    SysSet#sys_set.is_dirty.