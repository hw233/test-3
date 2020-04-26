%%%-------------------------------------- 
%%% @Module: lib_bt_cmd
%%% @Author: huangjf
%%% @Created: 2014.1.21
%%% @Description: 处理战斗对象所下达的指令的相关业务逻辑
%%%-------------------------------------- 

-module(lib_bt_cmd).
-export([
        prepare_cmd_for_bo_NOP/2,
        prepare_cmd_for_bo_normal_att/3,
        prepare_cmd_for_bo_use_skill/4,
        prepare_cmd_for_bo_use_goods/4,
        prepare_cmd_for_bo_protect_others/3,
        prepare_cmd_for_bo_capture/3,
        prepare_cmd_for_bo_escape/2,
        prepare_cmd_for_bo_defend/2,
        prepare_cmd_for_bo_summon_partner/3,
        prepare_cmd_for_bo_by_AI/2,
comm_handle_bo_summon_partner__/4,comm_handle_bo_summon_partner2__/5,
        post_bo_ready/1,
        schedule_round_action_begin/0,

        are_all_ready/0,


        handle_bo_summon_partner/2
        
    ]).
    
-include("common.hrl").
-include("offline_data.hrl").
% -include("buff.hrl").
% % -include("record.hrl").
% % -include("skill.hrl").
-include("battle.hrl").
-include("partner.hrl").
-include("record/battle_record.hrl").
% % -include("battle_buff.hrl").
% % -include("effect.hrl").


-import(lib_bt_comm, [
            get_bo_by_id/1,
            is_dead/1,
            is_dead2/2,
            is_player/1,
            is_hired_player/1,
            is_partner/1
            % is_bo_exists/1
            ]).




% handle_bo_summon_partner(Actor, TargetParObj) when is_record(TargetParObj, offline_bo) ->
%     TargetParObj2 = lib_bt_misc:to_battle_obj_rd(TargetParObj),
%     handle_bo_summon_partner(Actor, TargetParObj2);






% is_valid_prepare_cmd_type(Type) ->
%     % 要么是玩家下达指令，要么是主宠或雇佣玩家下达指令
%     (Type == ?PLAYER_PREPARE_CMD) 
%     orelse (Type == ?MAIN_PARTNER_PREPARE_CMD)
%     orelse (Type == ?HIRED_PLAYER_PREPARE_CMD).







prepare_cmd_for_bo_NOP(ForBo, OwnerPlayerBo) ->
    % ?ASSERT(is_valid_prepare_cmd_type(Type), Type),
    ForBoId = lib_bo:id(ForBo),
    lib_bt_send:resp_prepare_cmd_NOP_ok(OwnerPlayerBo, [ForBoId]),
    lib_bo:mark_cmd_prepared(ForBoId),
    post_bo_ready(ForBoId).



                            
                            
                                    


prepare_cmd_for_bo_normal_att(ForBo, TargetBoId, OwnerPlayerBo) ->
    % ?ASSERT(is_valid_prepare_cmd_type(Type), Type),
    ForBoId = lib_bo:id(ForBo),
    _ForBo2 = lib_bo:prepare_cmd_normal_att(ForBoId, TargetBoId),
    ForBo3 = lib_bo:mark_cmd_prepared(ForBoId),
    lib_bt_send:resp_prepare_cmd_normal_att_ok(OwnerPlayerBo, [ForBoId, TargetBoId]),
    lib_bt_send:notify_bo_is_ready(ForBo3), % 通知战场上所有玩家：某bo已经准备好了
    post_bo_ready(ForBoId).



prepare_cmd_for_bo_use_skill(ForBo, SkillId, TargetBoId, OwnerPlayerBo) ->
    % ?ASSERT(is_valid_prepare_cmd_type(Type), Type),
    ForBoId = lib_bo:id(ForBo),
    _ForBo2 = lib_bo:prepare_cmd_use_skill(ForBoId, SkillId, TargetBoId),
    ForBo3 = lib_bo:mark_cmd_prepared(ForBoId),
    lib_bt_send:resp_prepare_cmd_use_skill_ok(OwnerPlayerBo, [ForBoId, SkillId, TargetBoId]),
    lib_bt_send:notify_bo_is_ready(ForBo3),  % 通知战场上所有玩家：某bo已经准备好了
    post_bo_ready(ForBoId).


prepare_cmd_for_bo_use_goods(ForBo, GoodsId, TargetBoId, OwnerPlayerBo) ->
    ForBoId = lib_bo:id(ForBo),       
    _ForBo2 = lib_bo:prepare_cmd_use_goods(ForBoId, GoodsId, TargetBoId),
    ForBo3 = lib_bo:mark_cmd_prepared(ForBoId),
    lib_bt_send:resp_prepare_cmd_use_goods_ok(OwnerPlayerBo, [ForBoId, GoodsId, TargetBoId]),
    lib_bt_send:notify_bo_is_ready(ForBo3), % 通知战场上所有玩家：某bo已经准备好了
    post_bo_ready(ForBoId).


    




    
prepare_cmd_for_bo_protect_others(ForBo, TargetBoId, OwnerPlayerBo) ->
    % ?ASSERT(is_valid_prepare_cmd_type(Type), Type),
    ForBoId = lib_bo:id(ForBo),
    _ForBo2 = lib_bo:prepare_cmd_protect_others(ForBoId, TargetBoId),
    ForBo3 = lib_bo:mark_cmd_prepared(ForBoId),
    lib_bt_send:resp_prepare_cmd_protect_others_ok(OwnerPlayerBo, [ForBoId, TargetBoId]),
    lib_bt_send:notify_bo_is_ready(ForBo3),  % 通知战场上所有玩家：某bo已经准备好了
    post_bo_ready(ForBoId).


prepare_cmd_for_bo_capture(ForBo, TargetBoId, OwnerPlayerBo) ->
    % ?ASSERT(is_valid_prepare_cmd_type(Type), Type),
    ForBoId = lib_bo:id(ForBo),
    _ForBo2 = lib_bo:prepare_cmd_capture_partner(ForBoId, TargetBoId),
    ForBo3 = lib_bo:mark_cmd_prepared(ForBoId),
    lib_bt_send:resp_prepare_cmd_capture_ok(OwnerPlayerBo, [ForBoId, TargetBoId]),
    lib_bt_send:notify_bo_is_ready(ForBo3),  % 通知战场上所有玩家：某bo已经准备好了
    post_bo_ready(ForBoId).




prepare_cmd_for_bo_escape(ForBo, OwnerPlayerBo) ->
    % ?ASSERT(is_valid_prepare_cmd_type(Type), Type),
    ForBoId = lib_bo:id(ForBo),
    _ForBo2 = lib_bo:prepare_cmd_escape(ForBoId),
    ForBo3 = lib_bo:mark_cmd_prepared(ForBoId),
    lib_bt_send:resp_prepare_cmd_escape_ok(OwnerPlayerBo, [ForBoId]),
    lib_bt_send:notify_bo_is_ready(ForBo3),  % 通知战场上所有玩家：某bo已经准备好了
    post_bo_ready(ForBoId).




prepare_cmd_for_bo_defend(ForBo, OwnerPlayerBo) ->
    % ?ASSERT(is_valid_prepare_cmd_type(Type), Type),
    ForBoId = lib_bo:id(ForBo),
    _ForBo2 = lib_bo:prepare_cmd_defend(ForBoId),
    ForBo3 = lib_bo:mark_cmd_prepared(ForBoId),
    lib_bt_send:resp_prepare_cmd_defend_ok(OwnerPlayerBo, [ForBoId]),
    lib_bt_send:notify_bo_is_ready(ForBo3),  % 通知战场上所有玩家：某bo已经准备好了
    post_bo_ready(ForBoId).



prepare_cmd_for_bo_summon_partner(ForBo, PartnerId, OwnerPlayerBo) ->
    % ?ASSERT(is_valid_prepare_cmd_type(Type), Type),
    ForBoId = lib_bo:id(ForBo),
    _ForBo2 = lib_bo:prepare_cmd_summon_partner(ForBoId, PartnerId),
    ForBo3 = lib_bo:mark_cmd_prepared(ForBoId),
    lib_bt_send:resp_prepare_cmd_summon_partner_ok(OwnerPlayerBo, [ForBoId, PartnerId]),
    lib_bt_send:notify_bo_is_ready(ForBo3),  % 通知战场上所有玩家：某bo已经准备好了
    post_bo_ready(ForBoId).



prepare_cmd_for_bo_by_AI(ForBo, OwnerPlayerBo) ->
    ForBoId = lib_bo:id(ForBo),
    lib_bt_AI:bo_prepare_cmd_by_AI(ForBoId),
    ForBo2 = lib_bo:mark_cmd_prepared(ForBoId),
    lib_bt_send:resp_prepare_cmd_by_AI_ok(OwnerPlayerBo, [ForBoId]),
    lib_bt_send:notify_bo_is_ready(ForBo2),  % 通知战场上所有玩家：某bo已经准备好了
    post_bo_ready(ForBoId).
         

    
%% bo做好当前回合的准备之后的处理
post_bo_ready(_BoId) ->
    % _Bo = get_bo_by_id(BoId),

    case are_all_ready() of
        false ->
            skip;
        true ->
            schedule_round_action_begin()
    end.


schedule_round_action_begin() ->
    self() ! {'round_action_begin'}.







%% 是否所有的bo都准备好了？
are_all_ready() ->
    % L = get_all_online_player_bo_id_list(),
    % []



    %%%% 只需判断在线的玩家和主宠
    %%%L = lib_bt_comm:get_all_online_player_and_main_partner_bo_list(), %%get_all_bo_id_list(),  %%get_all_online_living_player_bo_list(),


    L = lib_bt_comm:get_all_bo_id_list(),
                        
    %%BoIdList = lib_battle:get_dict_side_idlist(Side),
    
    %%[dummy || X <- BoIdList, is_handling_coopr_skill_QTE(get(X))] == []   % 这一句目前永远为true

    are_all_ready__(L).

    
are_all_ready__([]) ->
    true;
are_all_ready__([BoId | T]) ->
    Bo = get_bo_by_id(BoId),
    case lib_bo:is_ready(Bo) of
        true ->
            are_all_ready__(T);
        false ->
            false
    end.





%% @return: {ok, SummonDtl} | {fail, Reason}
handle_bo_summon_partner(Actor, TargetParObj) when is_record(TargetParObj, partner) ->
    ?ASSERT(is_player(Actor), Actor),
    case comm_check_bo_summon_partner(Actor) of
        {fail, Reason} ->
            {fail, Reason};
        ok ->
            % 判定一次是否可以实际出战？
            case lib_partner:can_goto_fight_once(TargetParObj) of
                false ->
                    ?BT_LOG(io_lib:format("handle_bo_summon_partner(), can NOT goto fight once!! ActorId=~p, TargetParObj:~w~n", [lib_bo:id(Actor), TargetParObj])),
                    {fail, cannot_goto_fight};
                true ->
                    % 依据par对象生成对应的bo
                    Side = lib_bo:get_side(Actor),
                    Pos = lib_bo:decide_my_main_partner_pos(Actor),
                    {NewParBoId, NewParBo} = lib_bt_misc:generate_partner_bo(TargetParObj, [Side, Pos]),

                    TargetParId = lib_partner:get_id(TargetParObj),

                    comm_handle_bo_summon_partner__(Actor, TargetParId, [Side, Pos], [NewParBoId, NewParBo])
            end
    end;

handle_bo_summon_partner(Actor, TargetParObj) when is_record(TargetParObj, offline_bo) ->
    ?ASSERT(is_player(Actor), Actor),
    case comm_check_bo_summon_partner(Actor) of
        {fail, Reason} ->
            {fail, Reason};
        ok ->
            % 判定一次是否可以实际出战？
            case mod_offline_bo:can_par_goto_fight_once(TargetParObj) of
                false ->
                    ?BT_LOG(io_lib:format("handle_bo_summon_partner(), offline par bo can NOT goto fight once!! ActorId=~p, TargetParObj:~w~n", [lib_bo:id(Actor), TargetParObj])),
                    {fail, cannot_goto_fight};
                true ->
                    % 依据par对象生成对应的bo
                    Side = lib_bo:get_side(Actor),
                    Pos = lib_bo:decide_my_main_partner_pos(Actor),
                    {NewParBoId, NewParBo} = lib_bt_misc:generate_partner_bo(TargetParObj, [Side, Pos]),

                    TargetParId = mod_offline_bo:get_id(TargetParObj),

                    comm_handle_bo_summon_partner__(Actor, TargetParId, [Side, Pos], [NewParBoId, NewParBo])
            end
    end.

            

comm_check_bo_summon_partner(Actor) ->
    case lib_bo:is_under_strong_control(Actor) of  % 稳妥起见，这里判断一次行动者是否处于控制状态
        true ->
            {fail, is_under_control};
        false ->
            ok
    end.



% can_goto_fight_once(ParObj) when is_record(ParObj, partner) ->
%     lib_partner:can_goto_fight_once(ParObj);

% can_goto_fight_once(ParObj) when is_record(ParObj, offline_bo) ->
%     TmpDummyPar = #partner{
%                     loyalty = mod_offline_bo:get_par_loyalty(ParObj),
%                     quality = mod_offline_bo:get_par_quality(ParObj)
%                     },
%     lib_partner:can_goto_fight_once(TmpDummyPar).

    


comm_handle_bo_summon_partner__(Actor, TargetParId, [Side, Pos], [NewParBoId, NewParBo]) ->

    % 如果Pos位置上有bo，则先移除它
    case lib_bt_comm:get_bo_by_pos(Side, Pos) of
        null ->
            skip;
        OldBo ->
            ?ASSERT(is_partner(OldBo), OldBo),
            ?ASSERT(lib_bo:get_my_owner_player_bo_id(OldBo) == lib_bo:id(Actor), {Actor, OldBo}),

            OldBoId = lib_bo:id(OldBo),
            lib_bt_dict:remove_bo_from_battle_field(OldBoId),
            lib_bt_misc:post_replace_old_par_from_battle_field(OldBoId, Actor)
    end,
    
    % 添加新bo到战场
    lib_bt_dict:add_bo_to_battle_field(NewParBoId, NewParBo, Side),
    lib_bt_misc:post_add_partner_to_battle_field(TargetParId, NewParBoId, Actor, true),

    % 初始化乱敏
    lib_bo:init_tmp_rand_act_speed(NewParBoId),

    % 额外处理
    extra_handle_after_par_summoned(Actor, NewParBoId),

    SummonDtl = #summon_dtl{
                    new_bo_id_list = [NewParBoId]
                    },
    {ok, SummonDtl}.

comm_handle_bo_summon_partner2__(Actor, TargetParId, [Side, Pos], [NewParBoId, NewParBo],IsMainPar) ->

    % 如果Pos位置上有bo，则先移除它
    case lib_bt_comm:get_bo_by_pos(Side, Pos) of
        null ->
            skip;
        OldBo ->
            ?ASSERT(is_partner(OldBo), OldBo),
            ?ASSERT(lib_bo:get_my_owner_player_bo_id(OldBo) == lib_bo:id(Actor), {Actor, OldBo}),

            OldBoId = lib_bo:id(OldBo),
            lib_bt_dict:remove_bo_from_battle_field(OldBoId),
            lib_bt_misc:post_replace_old_par_from_battle_field(OldBoId, Actor)
    end,

    % 添加新bo到战场
    lib_bt_dict:add_bo_to_battle_field(NewParBoId, NewParBo, Side),
    lib_bt_misc:post_add_partner_to_battle_field(TargetParId, NewParBoId, Actor, IsMainPar),

    % 初始化乱敏
    lib_bo:init_tmp_rand_act_speed(NewParBoId),

    case IsMainPar of
        true ->
            lib_bo:set_online(NewParBoId, true),
            lib_bo:mark_as_main_partner(NewParBoId);
        false ->
            skip
    end,

    SummonDtl = #summon_dtl{
        new_bo_id_list = [NewParBoId]
    },
    {ok, SummonDtl}.

extra_handle_after_par_summoned(Actor, NewParBoId) ->
    case is_hired_player(Actor) of
        true ->
            % 雇佣玩家新召唤的宠物固定设为非在线
            lib_bo:set_online(NewParBoId, false);
        false ->
            % 在线玩家新召唤的宠物固定设为在线并且作为主宠！
            lib_bo:set_online(NewParBoId, true),
            lib_bo:mark_as_main_partner(NewParBoId)
    end.



% build_battle_tips() ->
%     todo_here.