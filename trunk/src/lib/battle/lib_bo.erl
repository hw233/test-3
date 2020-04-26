%%%--------------------------------------
%%% @Module  : lib_bo (bo: battle object)
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2013.7.27
%%% @Description : 战斗对象（战场中的战斗单位）
%%%--------------------------------------
-module(lib_bo).

-export([
        id/1, get_id/1,  get_type/1, get_main_type/1,
        get_side/1, get_pos/1, calc_virtual_pos_for_sjjh/1,
        get_name/1, get_sex/1, get_race/1, get_faction/1,
        get_lv/1, get_bmon_group_no/1,
        get_parent_obj_id/1,
        get_parent_partner_no/1,
        get_sendpid/1, set_sendpid/2,
        get_spouse_bo_id/1,
        get_intimacy_with_spouse/1,
        get_showing_equips/1,
        get_hp/1, set_hp/2, get_hp_lim/1, add_hp/2,
        get_mp/1, get_mp_lim/1, add_mp/2,
        get_anger/1, get_anger_lim/1, add_anger/2,
        get_hp_by_id/1, get_mp_by_id/1, get_anger_by_id/1,
        get_gamemoney/1, add_gamemoney/2,
        try_apply_passi_eff_add_buff_on_condition/3,

        get_transfiguration_no/1,

        get_par_extra/1,

        get_be_chaos_att_team_paoba/1,
        get_be_chaos_att_team_phy_dam/1,
        get_neglect_seal_resis/1,
        get_seal_hit_to_partner/1,
        get_seal_hit_to_mon/1,
        get_phy_dam_to_partner/1,
        get_phy_dam_to_mon/1,
        get_mag_dam_to_partner/1,
        get_mag_dam_to_mon/1,
        get_be_chaos_round_repair/1,
        get_chaos_round_repair/1,
        get_be_froze_round_repair/1,
        get_froze_round_repair/1,
        get_neglect_phy_def/1,
        get_neglect_mag_def/1,

        get_phy_dam_to_speed_1/1,
        get_phy_dam_to_speed_2/1,
        get_mag_dam_to_speed_1/1,
        get_mag_dam_to_speed_2/1,
        get_seal_hit_to_speed/1,
		is_revive_forbid/1,

        get_revive_heal_coef/1,

        get_init_hp_lim/1, get_init_mp_lim/1, get_init_anger_lim/1,
        get_init_phy_att/1, get_init_mag_att/1,
        get_init_phy_def/1, get_init_mag_def/1,
        get_init_hit/1, get_init_dodge/1,
        get_init_crit/1, get_init_ten/1,
        get_init_act_speed/1,
        get_init_seal_hit/1, get_init_seal_resis/1,

        get_hit/1, get_dodge/1,get_raw_seal_hit/1,
        get_crit/1, get_ten/1,

        get_phy_att/1, get_mag_att/1,
        get_phy_def/1, get_mag_def/1,
        % get_phy_att/1, get_mag_att/1,
        % get_phy_def/1, get_mag_def/1,
        get_heal_value/1,

        get_act_speed/1, get_luck/1,get_neglect_ret_dam/1,
        get_do_phy_dam_scaling/1, get_do_mag_dam_scaling/1, get_crit_coef/1,
        get_be_phy_dam_reduce_coef/1,
        get_be_mag_dam_reduce_coef/1,
        get_be_phy_dam_shrink/1,
        get_be_mag_dam_shrink/1,
        get_phy_dam_absorb/1,
        get_mag_dam_absorb/1,
        get_be_heal_eff_coef/1,
        get_qugui_coef/1,

        get_strikeback_proba/1,
        get_ret_dam_proba/1, get_ret_dam_coef/1,

        get_frozen_hit/1, get_frozen_resis/1,
        get_trance_hit/1, get_trance_resis/1,
        get_chaos_hit/1, get_chaos_resis/1,
        get_seal_hit/1, get_seal_resis/1,

        get_cmd_type/1, get_cmd_para/1,
        find_passi_eff_no_by_eff_name/2,

        get_when_spawn_round/1,
        adjust_when_spawn_round/2,

        get_my_owner_player_bo_id/1,
        set_my_owner_player_bo_id/2,
        get_my_owner_player_bo/1,

        get_my_main_partner_bo/1,
        get_my_main_partner_bo_id/1,
        set_my_main_partner_bo_id/2,
        find_my_existing_par_bo_id_list/1,
        get_my_partner_bo_info_list/1,
        add_to_my_partner_bo_info_list/2,
        remove_from_my_partner_bo_info_list/2,
        get_my_already_joined_battle_par_id_list/1,
        add_to_my_already_joined_battle_par_list/2,

        get_my_hired_player_bo/1,
        get_my_hired_player_bo_id/1,
        set_my_hired_player_bo_id/2,
        get_my_hired_player_id/1,


        get_my_pvp_oppo_player_id_list/1,

        get_suit_no/1,
        get_graph_title/1,
        get_text_title/1,
        get_user_def_title/1,

        get_online_flag/1,

        get_xinfa_lv/2,

        get_initiative_skill_list/1,
        get_skill_brief/2,
        is_skill_cding/2,
        get_skill_left_cd_rounds/2,

        has_initiative_skill/2,
        has_passive_skill/2,
        has_skill/2,


        set_online/2,
        set_auto_battle/2,
        mark_as_main_partner/1,


        has_spec_no_buff/2,
        find_buff_list_by_no/2,
        find_buff_by_no/2,
        find_buff_by_name/2,
        find_buff_list_by_category/2,
        find_buff_by_category/2,
        has_spec_category_buff/2,
        has_spec_eff_type_buff/2,

        find_mingwang_buffs/1,

        % has_HOT_buff/1,
        % has_DOT_buff/1,

        find_passi_eff_by_name/2,


        get_cur_skill_brief/1,
        set_cur_skill_brief/3,
        get_cur_skill_cfg/1,
        get_cur_pick_target/1,
        get_cur_att_target/1, set_cur_att_target/2,

        get_cur_bhv/1, set_cur_bhv/2,

        get_acc_summon_par_times/1,
        incr_acc_summon_par_times/1,

        decide_my_main_partner_pos/1,

        on_event/2, on_event/3,

        bo_die/2, bo_die_and_force_leave_battle/1,

        apply_sworn_add_attr/2,
        apply_zf_add_attr/2,

        get_buff_list/1,
		get_passi_effs/2,
        add_dummy_buff/3,
        add_buff/5,
        remove_buff/2,
        purge_buff/2,


        handle_buff_expire_events/2,


        % mark_ready_flag/1,

        mark_force_change_to_normal_att/1,

        mark_cmd_prepared/1,
        is_cmd_prepared/1,

        mark_show_battle_report_done/1,
        is_show_battle_report_done/1,

        mark_just_back_to_battle/1,
        is_just_back_to_battle/1,

        cannot_be_attacked/1,
        % can_only_use_goods/1,
        cannot_act/1,
        can_be_ctrled/1,
        is_ready/1,

        is_auto_battle/1,


        is_original_using_normal_att/1,
        is_using_normal_att/1,
        is_using_defend/1,
        is_using_single_target_phy_att/1,
        % have_to_use_normal_att/1,

        is_frozen/1,
        is_trance/1, cannot_act_by_trance/1,
        has_reborn_buff/1,
        is_chaos/1,is_silence/1,
        is_under_control/1,
        is_under_strong_control/1,
        is_immu_damage/1,
        is_force_attack/1,
        is_force_auto_attack/1,
        is_cding/1,
        is_xuliing/1,
        is_soul_shackled/1,

        is_invisible/1,
        is_invincible/1,
        is_avatar/1,
        is_immu_control/1,
        is_dam_full/1,
        get_invisible_expire_round/1,
        can_anti_invisible/1,
        can_qugui/1,
        can_prevent_inverse_dam/1,
        cannot_be_heal/1,

        get_die_status/1,


        find_reborn_prep_status_eff/1,
        has_reborn_prep_status/1,
        has_ghost_prep_status/1,
        add_reborn_count/1,
        set_reborn_count/2,
        is_max_reborn_count/1,
        get_reborn_count/1,


        in_ghost_status/1,
        in_fallen_status/1,
        reset_die_status/1,

        test_immu_dam_once/1,
        try_apply_youying_mingwang_buff_eff_by_do_phy_dam/3,
        try_apply_absorb_dam_to_mp_shield_once/2,
        try_apply_reduce_phy_dam_shield_once/2,
try_apply_reduce_mag_dam_shield_once/2,try_apply_reduce_phy_dam_shield_once2/2,
        try_apply_absorb_hp/3,
        try_apply_undead_eff/1,


        calc_do_mag_dam_enhance/1,
        calc_be_mag_dam_enhance/1,


        mark_already_attacked/2,
        is_already_attacked/2,

        get_he_who_taunt_me/1,
        set_he_who_taunt_me/2,
        is_be_taunt/1,

        get_max_hit_obj_count/1,
        set_max_hit_obj_count/2,
        get_acc_hit_obj_count/1,
        incr_acc_hit_obj_count/1,


        get_one_protector/1,
        add_regular_protector/2,
        maybe_remove_regular_protector/2,

        % try_get_into_phy_combo_att_status/1,
        in_phy_combo_att_status/1,
        can_phy_combo_attack/1,
        mark_phy_combo_att_status/1,
        clear_phy_combo_att_status/1,

        init_tmp_rand_act_speed/1,
        get_tmp_rand_act_speed/1,
        set_tmp_rand_act_speed/2,


        tmp_mark_do_fix_Hp_dam_by_xinfa_lv/1,
        tmp_mark_do_fix_Mp_dam_by_xinfa_lv/1,
        tmp_mark_do_dam_by_defer_hp_rate_with_limit/2,
        get_do_dam_by_defer_hp_rate_with_limit_para/1,
        is_do_fix_Hp_dam_by_xinfa_lv/1,
        is_do_fix_Mp_dam_by_xinfa_lv/1,
        is_do_dam_by_defer_hp_rate_with_limit/1,


  set_tmp_force_pursue_att_proba/2, set_tmp_force_max_pursue_att_times/2, set_tmp_force_pursue_att_dam_coef/2,
  set_tmp_force_phy_combo_att_proba/2, set_tmp_force_max_phy_combo_att_times/2,set_tmp_kill_target_add_buff/2,
  set_tmp_select_target_add_buff/2,set_tmp_select_target_cause_crite/2,
  set_tmp_force_escape_success_proba/2,

  set_tmp_phy_att_reduce_rate/2,


        can_mag_combo_attack/2,
        set_max_mag_combo_att_times/2,


        apply_phy_combo_att_costs/1,
        apply_mag_combo_att_costs/1,

        can_use_skill/2,
        can_use_skill_on_real_act/2,
        apply_use_skill_costs/2,
        update_skill_cd_info/2,

        % set_left_pursue_att_times/2,
        can_pursue_attack/1,
        get_pursue_att_dam_coef/1,

        % decr_left_phy_combo_att_times/1,
        get_acc_phy_combo_att_times/1,
        incr_acc_phy_combo_att_times/1,
        incr_acc_mag_combo_att_times/1,
        % decr_left_pursue_att_times/1,
        incr_acc_pursue_att_times/1,

        % reset_left_phy_combo_att_times/1,
        clear_acc_phy_combo_att_times/1,
        % set_base_phy_combo_att_times/2,


        on_new_round_begin/1,

        % on_hit_success/1,
        % on_dodge_success/1,
        % on_crit_success/1,


        can_escape/1,
        can_revive/1,


        get_AI_no_list/1,
        get_talk_AI_no_list/1,

        get_cur_round_talk_AI_list/1,
        set_cur_round_talk_AI_list/2,


        prepare_default_cmd/1,
        % convert_to_normal_att/1,
        prepare_cmd_normal_att/2,
        prepare_cmd_use_skill/3,
        prepare_cmd_use_goods/3,
        prepare_cmd_protect_others/2,
        prepare_cmd_escape/1,
        prepare_cmd_capture_partner/2,
        prepare_cmd_defend/1,
        prepare_cmd_summon_partner/2,
        prepare_cmd_summon_mon/2,

        get_goods_info/2,
        record_goods_info/2,
        update_goods_info_after_use/3,
        try_apply_passi_eff_on_dam/3,           %% 战斗中每次伤血应用被动效果(除单次受到伤害不超过生命上限的x%外)
        try_apply_passi_eff_on_dam_for_hp/3,    %% 战斗中每次伤血应用被动效果(单次受到伤害不超过生命上限的x%)
        %%其他 ...

        get_look_idx/1,

        get_dbg_force_fix_dam/1,

        get_phy_crit/1,
        get_phy_ten/1,
        get_mag_crit/1,
        get_mag_ten/1,
        get_phy_crit_coef/1,
        get_mag_crit_coef/1,

        find_passi_eff_by_name_all/2   % 获取身上被动效果列表

    ]).

-import(lib_bt_comm, [
            get_bo_by_id/1,
            update_bo/1,
            is_dead/1,
is_dead2/2,
            is_living/1,
            get_enemy_side/1,
            get_all_bo_id_list/0,
            get_bo_id_list/1,
            can_attack/2,
            get_cur_round/0,
            is_player/1,
            is_hired_player/1,
            is_partner/1,
            is_monster/1,
            is_online_player/1,
            is_online_main_partner/1,
            is_offline/1

    ]).


-include("common.hrl").
-include("record.hrl").
-include("record/battle_record.hrl").
-include("effect.hrl").
-include("buff.hrl").
-include("skill.hrl").
-include("xinfa.hrl").
-include("abbreviate.hrl").
-include("attribute.hrl").
-include("monster.hrl").
-include("num_limits.hrl").
-include("log.hrl").
-include("five_elements.hrl").


%%　　　　　　 ┏┓       ┏┓
%%　　　　　　┏┛┻━━━━━━━┛┻┓
%%　　　　　　┃　　　　　　 ┃
%%　　　　　　┃　　　━　　　┃
%%　　　　　 █████━█████  ┃
%%　　　　　　┃　　　　　　 ┃
%%　　　　　　┃　　　┻　　　┃
%%　　　　　　┃　　　　　　 ┃
%%　　　　　　┗━━┓　　　 ┏━┛
%%              ┃　　  ┃
%%　　　　　　　　┃　　  ┃
%%　　　　　　　　┃　　　┃　Code is far away from bug with the animal protecting
%%　　　　　　　　┃　　　┃  　　　　         神兽保佑,代码无bug
%%　　　　　　　　┃　　　j
%%　　　　　　　　┃　　　┃　　   +
%%　　　　　　　　┃　 　 ┗━━━┓ ++
%%　　　　　　　　┃ 　　　　　┣┓
%%　　　　　　　　┃ 　　　　　┏┛
%%　　　　　　　　┗┓┓┏━━━┳┓┏┛
%%　　　　　　　　 ┃┫┫　 ┃┫┫
%%　　　　　　　　 ┗┻┛　 ┗┻┛

%% 等价于get_id(Bo)
id(Bo) -> Bo#battle_obj.id.

get_id(Bo) -> Bo#battle_obj.id.

get_type(Bo) -> Bo#battle_obj.type.


%% bo所属的主体类型
get_main_type(Bo) ->
    case get_type(Bo) of
        ?OBJ_HIRED_PLAYER ->  % 雇佣玩家的主体类型归为玩家
            ?OBJ_PLAYER;
        ?OBJ_NORMAL_BOSS ->  % 普通boss归为怪物
            ?OBJ_MONSTER;
        ?OBJ_WORLD_BOSS ->   % 世界boss也归为怪物
            ?OBJ_MONSTER;
        Other ->
            Other
    end.


get_side(Bo) -> Bo#battle_obj.side.

get_pos(Bo) -> Bo#battle_obj.pos.

get_look_idx(Bo) -> Bo#battle_obj.look_idx.

%% 获取所属的怪物组
get_bmon_group_no(Bo) -> Bo#battle_obj.bmon_group_no.

%% 计算虚拟位置（仅为了配合实现随机集火原则）, sjjh：随机集火
calc_virtual_pos_for_sjjh(Bo) ->
    case get_side(Bo) of
        ?HOST_SIDE ->
            get_pos(Bo);
        ?GUEST_SIDE ->
            get_pos(Bo) + ?MAX_BATTLE_POS_PER_SIDE
    end.


get_name(Bo) -> Bo#battle_obj.name.

get_sex(Bo) -> Bo#battle_obj.sex.

get_race(Bo) -> Bo#battle_obj.race.

get_faction(Bo) -> Bo#battle_obj.faction.

get_lv(Bo) -> Bo#battle_obj.lv.

get_parent_obj_id(Bo) -> Bo#battle_obj.parent_obj_id.

get_parent_partner_no(Bo) -> Bo#battle_obj.parent_partner_no.

get_sendpid(Bo) -> Bo#battle_obj.sendpid.

set_sendpid(BoId, SendPid) ->
    ?ASSERT(is_pid(SendPid), SendPid),
    Bo = get_bo_by_id(BoId),
    Bo2 = Bo#battle_obj{sendpid = SendPid},
    ?DEBUG_MSG("wjctestbo",[]),
    update_bo(Bo2),
    void.

get_spouse_bo_id(Bo) -> Bo#battle_obj.spouse_bo_id.

get_intimacy_with_spouse(Bo) -> Bo#battle_obj.intimacy_with_spouse.

get_showing_equips(Bo) -> Bo#battle_obj.showing_equips.

get_hp(Bo) -> Bo#battle_obj.attrs#attrs.hp.

set_hp(BoId, NewHp0) ->
    ?ASSERT(util:is_nonnegative_int(NewHp0), NewHp0),
    Bo = get_bo_by_id(BoId),
    NewHp = min(NewHp0, get_hp_lim(Bo)),
    OldAttrs = Bo#battle_obj.attrs,
    NewAttrs = OldAttrs#attrs{hp = NewHp},
    Bo2 = Bo#battle_obj{attrs = NewAttrs},
    update_bo(Bo2),
    void.


get_hp_lim(Bo) -> Bo#battle_obj.attrs#attrs.hp_lim.

%% 加血。如果是减血，则参数Val传负值
%% 每次损失血量获得的怒气值=MIN(MAX(int（损失血量/最大血量*100）,1),25)
%% 每次获得血量损失的怒气值=MIN(MAX(int（获得血量/最大血量*60),1),25)
add_hp(BoId, Value) ->
    ?ASSERT(is_integer(Value)),

    Bo = get_bo_by_id(BoId),
    ?ASSERT(Bo /= null, BoId),

    try_apply_passi_eff_on_dam(Bo, Value, ?EN_CHANGE_PHY_ATT_WHEN_HP_CHANGE),
    try_apply_passi_eff_on_dam(Bo, Value, ?EN_CHANGE_MAG_ATT_WHEN_HP_CHANGE),
    try_apply_passi_eff_on_dam(Bo, Value, ?EN_CHANGE_PHY_DEF_WHEN_HP_CHANGE_BY_RATE),
    try_apply_passi_eff_on_dam(Bo, Value, ?EN_CHANGE_MAG_DEF_WHEN_HP_CHANGE_BY_RATE),

    Bo1 = get_bo_by_id(BoId), %% 这里必须重新获取bo，因为经过上面函数后bo已经发生变化
    OldHp = get_hp(Bo1),

    % 增加治疗减益
    % Round = lib_bt_comm:get_cur_round(),
    NewHp = util:minmax(OldHp + Value, 0, get_hp_lim(Bo1)),

%%    AddAnger =
%%        if
%%            Value =:= 0 -> 0;
%%            Value > 0 -> 0;
%%            true -> util:minmax(util:floor(-Value/get_hp_lim(Bo1)*60), 3, 29)
%%        end,

    NewAttrs = Bo1#battle_obj.attrs#attrs{hp = NewHp},

  Bo2 = Bo1#battle_obj{attrs = NewAttrs},
  update_bo(Bo2),Bo2.
%%    add_anger(Bo2, AddAnger).

get_mp(Bo) -> Bo#battle_obj.attrs#attrs.mp.

get_mp_lim(Bo) -> Bo#battle_obj.attrs#attrs.mp_lim.

%% 加魔法。如果是减魔法，则参数Val传负值
add_mp(BoId, Val) ->
    ?ASSERT(is_integer(Val)),

    Bo = get_bo_by_id(BoId),
    ?ASSERT(Bo /= null, BoId),

    OldMp = get_mp(Bo),
    NewMp = util:minmax(OldMp + Val, 0, get_mp_lim(Bo)),
    NewAttrs = Bo#battle_obj.attrs#attrs{mp = NewMp},
    Bo2 = Bo#battle_obj{attrs = NewAttrs},
    update_bo(Bo2),
    Bo2.



get_anger(Bo) -> Bo#battle_obj.attrs#attrs.anger.

get_transfiguration_no(Bo) -> Bo#battle_obj.transfiguration_no.

get_anger_lim(Bo) -> Bo#battle_obj.attrs#attrs.anger_lim.


add_anger(BoId, AddVal) when is_integer(BoId) ->
    ?ASSERT(is_integer(AddVal)),

    case get_bo_by_id(BoId) of
        null ->
            null;
        Bo -> add_anger(Bo, AddVal)
    end;

%% 加怒气。如果是减怒气，则参数Val传负值
add_anger(Bo, AddVal) ->
    OldVal = get_anger(Bo),
    NewVal = util:minmax(OldVal + AddVal, 0, get_anger_lim(Bo)),
    NewAttrs = Bo#battle_obj.attrs#attrs{anger = NewVal},
    Bo2 = Bo#battle_obj{attrs = NewAttrs},
    update_bo(Bo2),
    % DelVal = NewVal - OldVal,
    % lib_bt_send:notify_bo_attr_changed_to_all(Bo2, [{?ATTR_ANGER, DelVal}]),
    Bo2.

get_gamemoney(Bo) -> Bo#battle_obj.gamemoney.
add_gamemoney(BoId, Val) ->
    ?ASSERT(is_integer(Val)),

    Bo = get_bo_by_id(BoId),
    ?ASSERT(Bo /= null, BoId),

    Old = get_gamemoney(Bo),
    New = util:minmax(Old + Val, 0, ?MAX_U64),

    Bo2 = Bo#battle_obj{gamemoney = New},
    update_bo(Bo2),
    CostNum = Old - New,
    player:cost_gamemoney(get_parent_obj_id(Bo), CostNum, [?LOG_BATTLE, "use_skill"]),
    Bo2.

%% 获取hp，如果对应的bo不存在，则返回0
get_hp_by_id(BoId) ->
    case get_bo_by_id(BoId) of
        null -> 0;
        Bo -> get_hp(Bo)
    end.


%% 获取mp，如果对应的bo不存在，则返回0
get_mp_by_id(BoId) ->
    case get_bo_by_id(BoId) of
        null -> 0;
        Bo -> get_mp(Bo)
    end.


get_anger_by_id(BoId) ->
    case get_bo_by_id(BoId) of
        null -> 0;
        Bo -> get_anger(Bo)
    end.

%% 宠物bo的额外特性
get_par_extra(Bo) ->
    Bo#battle_obj.par_extra.



%% 获取总命中
get_hit(Bo) ->
    max(raw_get_hit__(Bo), 1).  % 最低值为1

%% 获取总命中
get_raw_seal_hit(Bo) ->
  max(raw_get_seal_hit__(Bo), 1).  % 最低值为1



%% 获取总闪避
get_dodge(Bo) ->
    max(raw_get_dodge__(Bo), 0).


% 加闪避（如果是减闪避，则AddValue传入负值）
add_dodge(BoId, AddValue) ->
    Bo = get_bo_by_id(BoId),
    OldValue = raw_get_dodge__(Bo),
    NewValue = OldValue + AddValue,  % 注意：这里不需做最少为0的矫正（考虑到buff的影响，临时呈现为负值是有可能的）
    NewAttrs = Bo#battle_obj.attrs#attrs{dodge = NewValue},
    Bo2 = Bo#battle_obj{attrs = NewAttrs},
    update_bo(Bo2),
    void.




%% 获取总暴击
get_crit(Bo) ->
    max(raw_get_crit__(Bo), 0).

get_phy_crit(Bo) ->
    max(raw_get_phy_crit__(Bo), 0).
get_phy_ten(Bo) ->
    max(raw_get_phy_ten__(Bo), 0).
get_mag_crit(Bo) ->
    max(raw_get_mag_crit__(Bo), 0).
get_mag_ten(Bo) ->
    max(raw_get_mag_ten__(Bo), 0).
get_phy_crit_coef(Bo) ->
    max(raw_get_phy_crit_coef__(Bo), 0).
get_mag_crit_coef(Bo) ->
    max(raw_get_mag_crit_coef__(Bo), 0).

get_heal_value(Bo) ->
    max(raw_get_heal_value__(Bo), 0).

% 加物理暴击（如果是减，则AddValue传入负值）
add_phy_crit(BoId, AddValue) ->
    Bo = get_bo_by_id(BoId),
    OldValue = raw_get_phy_crit__(Bo),
  %%这里移除buff的时候会导致移除的数据大于加上去的。所以导致数据错乱（变小）
    NewValue = max(OldValue + AddValue, 0),  % 注意：这里不需做最少为0的矫正（考虑到buff的影响，临时呈现为负值是有可能的）
  ?DEBUG_MSG("testcritbuff ~p~n",[NewValue]),
  NewAttrs = Bo#battle_obj.attrs#attrs{phy_crit = NewValue},
  Bo2 = Bo#battle_obj{attrs = NewAttrs},
    update_bo(Bo2),
    void.

% 加物理暴击（如果是减，则AddValue传入负值）
add_phy_ten(BoId, AddValue) ->
    Bo = get_bo_by_id(BoId),
    OldValue = raw_get_phy_ten__(Bo),
    NewValue = OldValue + AddValue,  % 注意：这里不需做最少为0的矫正（考虑到buff的影响，临时呈现为负值是有可能的）
    NewAttrs = Bo#battle_obj.attrs#attrs{phy_ten = NewValue},
    Bo2 = Bo#battle_obj{attrs = NewAttrs},
    update_bo(Bo2),
    void.

% 加物理暴击（如果是减，则AddValue传入负值）
add_mag_crit(BoId, AddValue) ->
    Bo = get_bo_by_id(BoId),
    OldValue = raw_get_mag_crit__(Bo),
    NewValue = OldValue + AddValue,  % 注意：这里不需做最少为0的矫正（考虑到buff的影响，临时呈现为负值是有可能的）
    NewAttrs = Bo#battle_obj.attrs#attrs{mag_crit = NewValue},
    Bo2 = Bo#battle_obj{attrs = NewAttrs},
    update_bo(Bo2),
    void.

% 加物理暴击（如果是减，则AddValue传入负值）
add_mag_ten(BoId, AddValue) ->
    Bo = get_bo_by_id(BoId),
    OldValue = raw_get_mag_ten__(Bo),
    NewValue = OldValue + AddValue,  % 注意：这里不需做最少为0的矫正（考虑到buff的影响，临时呈现为负值是有可能的）
    NewAttrs = Bo#battle_obj.attrs#attrs{mag_ten = NewValue},
    Bo2 = Bo#battle_obj{attrs = NewAttrs},
    update_bo(Bo2),
    void.


% 加物理暴击程度（如果是减，则AddValue传入负值）
add_phy_crit_coef(BoId, AddValue) ->
    Bo = get_bo_by_id(BoId),
    OldValue = raw_get_phy_crit_coef__(Bo),
    NewValue = OldValue + AddValue,  % 注意：这里不需做最少为0的矫正（考虑到buff的影响，临时呈现为负值是有可能的）
    NewAttrs = Bo#battle_obj.attrs#attrs{phy_crit_coef = NewValue},
    Bo2 = Bo#battle_obj{attrs = NewAttrs},
    update_bo(Bo2),
    void.

% 加法术暴击程度（如果是减，则AddValue传入负值）
add_mag_crit_coef(BoId, AddValue) ->
    Bo = get_bo_by_id(BoId),
    OldValue = raw_get_mag_crit_coef__(Bo),
    NewValue = OldValue + AddValue,  % 注意：这里不需做最少为0的矫正（考虑到buff的影响，临时呈现为负值是有可能的）
    NewAttrs = Bo#battle_obj.attrs#attrs{mag_crit_coef = NewValue},
    Bo2 = Bo#battle_obj{attrs = NewAttrs},
    update_bo(Bo2),
    void.

% 添加法术强度
add_heal_value(BoId, AddValue) ->
    Bo = get_bo_by_id(BoId),
    OldValue = raw_get_heal_value__(Bo),
    NewValue = OldValue + AddValue,  % 注意：这里不需做最少为0的矫正（考虑到buff的影响，临时呈现为负值是有可能的）
    NewAttrs = Bo#battle_obj.attrs#attrs{heal_value = NewValue},
    Bo2 = Bo#battle_obj{attrs = NewAttrs},
    update_bo(Bo2),
    void.


% 加暴击（如果是减，则AddValue传入负值）
add_crit(BoId, AddValue) ->
    Bo = get_bo_by_id(BoId),
    OldValue = raw_get_crit__(Bo),
    NewValue = OldValue + AddValue,  % 注意：这里不需做最少为0的矫正（考虑到buff的影响，临时呈现为负值是有可能的）
    NewAttrs = Bo#battle_obj.attrs#attrs{crit = NewValue},
    Bo2 = Bo#battle_obj{attrs = NewAttrs},
    update_bo(Bo2),
    void.


%% 获取总坚韧（抗暴击）
get_ten(Bo) ->
    max(raw_get_ten__(Bo), 1).  % 最低值为1


% 加坚韧（如果是减，则AddValue传入负值）
add_ten(BoId, AddValue) ->
    Bo = get_bo_by_id(BoId),
    OldValue = raw_get_ten__(Bo),
    NewValue = OldValue + AddValue,  % 注意：这里不需做最少为0的矫正（考虑到buff的影响，临时呈现为负值是有可能的）
    NewAttrs = Bo#battle_obj.attrs#attrs{ten = NewValue},
    Bo2 = Bo#battle_obj{attrs = NewAttrs},
    update_bo(Bo2),
    void.


% get_total_strikeback_proba(Bo) ->
%     get_strikeback_proba(Bo).

get_strikeback_proba(Bo) ->
    max(raw_get_strikeback_proba__(Bo), 0).



% 加反击率（如果是减，则AddValue传入负值）
add_strikeback_proba(BoId, AddValue) ->
    Bo = get_bo_by_id(BoId),
    OldValue = raw_get_strikeback_proba__(Bo),
    NewValue = min(OldValue + AddValue, ?PROBABILITY_BASE),  % 注意：这里不需做最少为0的矫正（考虑到buff的影响，临时呈现为负值是有可能的）
    OldAttrs = Bo#battle_obj.attrs,
    NewAttrs = OldAttrs#attrs{strikeback_proba = NewValue},
    Bo2 = Bo#battle_obj{attrs = NewAttrs},
    update_bo(Bo2),
    void.


% 添加反震几率的buff
%            ...
add_ret_dam_proba(BoId, AddValue) ->
    Bo = get_bo_by_id(BoId),
    OldValue = raw_get_ret_dam_proba__(Bo),
    NewValue = min(OldValue + AddValue, ?PROBABILITY_BASE),  % 注意：这里不需做最少为0的矫正（考虑到buff的影响，临时呈现为负值是有可能的）
    OldAttrs = Bo#battle_obj.attrs,
    NewAttrs = OldAttrs#attrs{ret_dam_proba = NewValue},
    Bo2 = Bo#battle_obj{attrs = NewAttrs},
    update_bo(Bo2),
    void.


%% 获取总的物理攻击（包含单回合临时增加的物攻等）
get_phy_att(Bo) ->
    max(
        max(raw_get_phy_att__(Bo), 0) + get_tmp_phy_att_add(Bo) - get_tmp_phy_att_reduce(Bo),
        0
       ).

get_mag_att(Bo) ->
    max(raw_get_mag_att__(Bo), 0) + get_tmp_mag_att_add(Bo).

get_phy_def(Bo) ->
    max(raw_get_phy_def__(Bo), 0) + get_tmp_phy_def_add(Bo).
    % case is_using_defend(Bo) of
    %     true ->
    %         % ?DEBUG_MSG("get_phy_def(), using defend, Def=~p", [Value + 100]),
    %         Value + 100;  % TODO： 临时写死加100防
    %     false ->
    %         Value
    % end.

get_mag_def(Bo) ->
    ?DEBUG_MSG("testbo ~p ~n", [Bo]),
    max(raw_get_mag_def__(Bo), 0) + get_tmp_mag_def_add(Bo).
    % case is_using_defend(Bo) of
    %     true ->
    %         % ?DEBUG_MSG("get_mag_def(), using defend, Def=~p", [Value + 100]),
    %         Value + 100;  % TODO： 临时写死加100防
    %     false ->
    %         Value
    % end.


%% 获取单回合临时增加的物攻
get_tmp_phy_att_add(Bo) ->
    TmpStatus = Bo#battle_obj.tmp_status,
    TmpStatus#bo_tmp_stat.phy_att_add.

%% 获取单回合临时增加的法攻（目前暂时没有）
get_tmp_mag_att_add(_Bo) ->
    0.

%% 获取单回合临时增加的物防（目前暂时没有）
get_tmp_phy_def_add(_Bo) ->
    0.

%% 获取单回合临时增加的法防（目前暂时没有）
get_tmp_mag_def_add(_Bo) ->
    0.


%% 获取单回合临时降低的物攻
get_tmp_phy_att_reduce(Bo) ->
    InitPhyAtt = get_init_phy_att(Bo),
    ReduceRate = get_tmp_phy_att_recude_rate(Bo),
    round(InitPhyAtt * ReduceRate).



get_tmp_phy_att_recude_rate(Bo) ->
    TmpStatus = Bo#battle_obj.tmp_status,
    TmpStatus#bo_tmp_stat.phy_att_reduce_rate.

set_tmp_phy_att_reduce_rate(BoId, Rate) ->
    ?ASSERT(Rate >= 0 andalso Rate =< 1, Rate),
    Bo = get_bo_by_id(BoId),
    OldTmpStatus = Bo#battle_obj.tmp_status,
    NewTmpStatus = OldTmpStatus#bo_tmp_stat{phy_att_reduce_rate = Rate},
    Bo2 = Bo#battle_obj{tmp_status = NewTmpStatus},
    update_bo(Bo2),
    void.





%% 初始（刚进入战斗时）的hp上限
get_init_hp_lim(Bo) -> Bo#battle_obj.init_attrs#attrs.hp_lim.

get_init_mp_lim(Bo) -> Bo#battle_obj.init_attrs#attrs.mp_lim.

get_init_anger_lim(Bo) -> Bo#battle_obj.init_attrs#attrs.anger_lim.

%% 获取初始（刚进入战斗时）的物攻
get_init_phy_att(Bo) ->
    Bo#battle_obj.init_attrs#attrs.phy_att.

get_init_mag_att(Bo) ->
    Bo#battle_obj.init_attrs#attrs.mag_att.

%% 获取初始的物防
get_init_phy_def(Bo) ->
    Bo#battle_obj.init_attrs#attrs.phy_def.

get_init_mag_def(Bo) ->
    Bo#battle_obj.init_attrs#attrs.mag_def.


get_init_hit(Bo) ->
    Bo#battle_obj.init_attrs#attrs.hit.

get_init_dodge(Bo) ->
    Bo#battle_obj.init_attrs#attrs.dodge.


get_init_crit(Bo) ->
    Bo#battle_obj.init_attrs#attrs.crit.

get_init_ten(Bo) ->
    Bo#battle_obj.init_attrs#attrs.ten.

get_init_act_speed(Bo) ->
    Bo#battle_obj.init_attrs#attrs.act_speed.

get_init_seal_hit(Bo) ->
    Bo#battle_obj.init_attrs#attrs.seal_hit.

get_init_seal_resis(Bo) ->
    Bo#battle_obj.init_attrs#attrs.seal_resis.



%% 作废！！
% %% 获取当前的物攻（不含单回合临时增加的物攻）
% get_phy_att(Bo) ->
%     max(raw_get_phy_att__(Bo), 0).

% get_mag_att(Bo) ->
%     max(raw_get_mag_att__(Bo), 0).

% get_phy_def(Bo) ->
%     max(raw_get_phy_def__(Bo), 0).

% get_mag_def(Bo) ->
%     max(raw_get_mag_def__(Bo), 0).



%% raw get的意思是：直接获取并返回原始值（没有先矫正，然后才再返回）
%% 注：考虑到多个buff的增、删顺序，返回值有可能为负数
raw_get_phy_att__(Bo) -> Bo#battle_obj.attrs#attrs.phy_att.
raw_get_mag_att__(Bo) -> Bo#battle_obj.attrs#attrs.mag_att.
raw_get_phy_def__(Bo) -> Bo#battle_obj.attrs#attrs.phy_def.
raw_get_mag_def__(Bo) -> Bo#battle_obj.attrs#attrs.mag_def.


raw_get_hit__(Bo) -> Bo#battle_obj.attrs#attrs.hit.
raw_get_dodge__(Bo) -> Bo#battle_obj.attrs#attrs.dodge.
raw_get_crit__(Bo) -> Bo#battle_obj.attrs#attrs.crit.
raw_get_ten__(Bo) -> Bo#battle_obj.attrs#attrs.ten.


raw_get_phy_crit__(Bo) -> Bo#battle_obj.attrs#attrs.phy_crit.
raw_get_phy_ten__(Bo) -> Bo#battle_obj.attrs#attrs.phy_ten.
raw_get_mag_crit__(Bo) -> Bo#battle_obj.attrs#attrs.mag_crit.
raw_get_mag_ten__(Bo) -> Bo#battle_obj.attrs#attrs.mag_ten.

raw_get_phy_crit_coef__(Bo) -> Bo#battle_obj.attrs#attrs.phy_crit_coef.
raw_get_mag_crit_coef__(Bo) -> Bo#battle_obj.attrs#attrs.mag_crit_coef.

raw_get_heal_value__(Bo) -> Bo#battle_obj.attrs#attrs.heal_value.

raw_get_act_speed__(Bo) -> Bo#battle_obj.attrs#attrs.act_speed.

raw_get_strikeback_proba__(Bo) -> Bo#battle_obj.attrs#attrs.strikeback_proba.
raw_get_ret_dam_proba__(Bo) -> Bo#battle_obj.attrs#attrs.ret_dam_proba.
raw_get_ret_dam_coef__(Bo) -> Bo#battle_obj.attrs#attrs.ret_dam_coef.

raw_get_frozen_hit__(Bo) -> Bo#battle_obj.attrs#attrs.frozen_hit.
raw_get_trance_hit__(Bo) -> Bo#battle_obj.attrs#attrs.trance_hit.
raw_get_chaos_hit__(Bo) -> Bo#battle_obj.attrs#attrs.chaos_hit.
raw_get_seal_hit__(Bo) -> Bo#battle_obj.attrs#attrs.seal_hit.

raw_get_frozen_resis__(Bo) -> Bo#battle_obj.attrs#attrs.frozen_resis.
raw_get_trance_resis__(Bo) -> Bo#battle_obj.attrs#attrs.trance_resis.
raw_get_chaos_resis__(Bo) -> Bo#battle_obj.attrs#attrs.chaos_resis.
raw_get_seal_resis__(Bo) -> Bo#battle_obj.attrs#attrs.seal_resis.

raw_get_crit_coef__(Bo) -> Bo#battle_obj.attrs#attrs.crit_coef.

raw_get_phy_combo_att_proba__(Bo) -> Bo#battle_obj.attrs#attrs.phy_combo_att_proba.
raw_get_mag_combo_att_proba__(Bo) -> Bo#battle_obj.attrs#attrs.mag_combo_att_proba.

raw_get_do_phy_dam_scaling__(Bo) -> Bo#battle_obj.attrs#attrs.do_phy_dam_scaling.
raw_get_do_mag_dam_scaling__(Bo) -> Bo#battle_obj.attrs#attrs.do_mag_dam_scaling.

raw_get_be_phy_dam_reduce_coef__(Bo) -> Bo#battle_obj.attrs#attrs.be_phy_dam_reduce_coef.
raw_get_be_mag_dam_reduce_coef__(Bo) -> Bo#battle_obj.attrs#attrs.be_mag_dam_reduce_coef.

raw_get_be_phy_dam_shrink__(Bo) -> Bo#battle_obj.attrs#attrs.be_phy_dam_shrink.
raw_get_be_mag_dam_shrink__(Bo) -> Bo#battle_obj.attrs#attrs.be_mag_dam_shrink.

raw_get_be_heal_eff_coef__(Bo) -> Bo#battle_obj.attrs#attrs.be_heal_eff_coef.

raw_get_heal_eff_coef__(Bo) ->Bo#battle_obj.attrs#attrs.heal_eff_coef.


raw_get_absorb_hp_coef__(Bo) -> Bo#battle_obj.attrs#attrs.absorb_hp_coef.

raw_get_qugui_coef__(Bo) -> Bo#battle_obj.attrs#attrs.qugui_coef.


raw_get_max_phy_combo_att_times__(Bo) -> Bo#battle_obj.max_phy_combo_att_times.
raw_get_max_mag_combo_att_times__(Bo) -> Bo#battle_obj.max_mag_combo_att_times.

raw_get_reduce_pursue_att_dam_coef__(Bo) -> Bo#battle_obj.attrs#attrs.reduce_pursue_att_dam_coef.

% 新增属性
raw_get_be_chaos_att_team_paoba__(Bo) -> Bo#battle_obj.attrs#attrs.be_chaos_att_team_paoba.
raw_get_be_chaos_att_team_phy_dam__(Bo) -> max(1,Bo#battle_obj.attrs#attrs.be_chaos_att_team_phy_dam) / 10000.
raw_get_neglect_seal_resis__(Bo) -> max(1,Bo#battle_obj.attrs#attrs.neglect_seal_resis) / 10000.
raw_get_seal_hit_to_partner__(Bo) -> max(1,Bo#battle_obj.attrs#attrs.seal_hit_to_partner) / 10000.
raw_get_seal_hit_to_mon__(Bo) -> max(1,Bo#battle_obj.attrs#attrs.seal_hit_to_mon) / 10000.
raw_get_phy_dam_to_partner__(Bo) -> max(1,Bo#battle_obj.attrs#attrs.phy_dam_to_partner) / 10000.
raw_get_phy_dam_to_mon__(Bo) -> max(1,Bo#battle_obj.attrs#attrs.phy_dam_to_mon) / 10000.
raw_get_mag_dam_to_partner__(Bo) -> max(1,Bo#battle_obj.attrs#attrs.mag_dam_to_partner) / 10000.
raw_get_mag_dam_to_mon__(Bo) -> max(1,Bo#battle_obj.attrs#attrs.mag_dam_to_mon) / 10000.
raw_get_be_chaos_round_repair__(Bo) -> max(1,Bo#battle_obj.attrs#attrs.be_chaos_round_repair) / 10000.
raw_get_chaos_round_repair__(Bo) -> max(1,Bo#battle_obj.attrs#attrs.chaos_round_repair) / 10000.
raw_get_be_froze_round_repair__(Bo) -> max(1,Bo#battle_obj.attrs#attrs.be_froze_round_repair) / 10000.
raw_get_froze_round_repair__(Bo) -> max(1,Bo#battle_obj.attrs#attrs.froze_round_repair) / 10000.
raw_get_neglect_phy_def__(Bo) -> max(1,Bo#battle_obj.attrs#attrs.neglect_phy_def) / 10000.
raw_get_neglect_mag_def__(Bo) -> max(1,Bo#battle_obj.attrs#attrs.neglect_mag_def) / 10000.
raw_get_phy_dam_to_speed_1__(Bo) -> max(1,Bo#battle_obj.attrs#attrs.phy_dam_to_speed_1) / 10000.
raw_get_phy_dam_to_speed_2__(Bo) -> max(1,Bo#battle_obj.attrs#attrs.phy_dam_to_speed_2) / 10000.
raw_get_mag_dam_to_speed_1__(Bo) -> max(1,Bo#battle_obj.attrs#attrs.mag_dam_to_speed_1) / 10000.
raw_get_mag_dam_to_speed_2__(Bo) -> max(1,Bo#battle_obj.attrs#attrs.mag_dam_to_speed_2) / 10000.
raw_get_seal_hit_to_speed__(Bo) -> max(1,Bo#battle_obj.attrs#attrs.seal_hit_to_speed) / 10000.
raw_get_revive_heal_coef__(Bo) -> max(1,Bo#battle_obj.attrs#attrs.revive_heal_coef) / 10000.

% 加物攻（如果是减物攻，则AddValue传入负值）
add_phy_att(BoId, AddValue) ->
    Bo = get_bo_by_id(BoId),
    OldValue = raw_get_phy_att__(Bo),
    NewValue = OldValue + AddValue,  % 注意：这里不需做最少为0的矫正（考虑到buff的影响，临时呈现为负值是有可能的）
    NewAttrs = Bo#battle_obj.attrs#attrs{phy_att = NewValue},
    Bo2 = Bo#battle_obj{attrs = NewAttrs},
    update_bo(Bo2),
    void.


% 加法攻（如果是减法攻，则AddValue传入负值）
add_mag_att(BoId, AddValue) ->
    Bo = get_bo_by_id(BoId),
    OldValue = raw_get_mag_att__(Bo),
    NewValue = OldValue + AddValue,  % 注意：这里不需做最少为0的矫正（考虑到buff的影响，临时呈现为负值是有可能的）
    NewAttrs = Bo#battle_obj.attrs#attrs{mag_att = NewValue},
    Bo2 = Bo#battle_obj{attrs = NewAttrs},
    update_bo(Bo2),
    void.



add_be_phy_dam_shrink(BoId, AddValue) ->
    Bo = get_bo_by_id(BoId),
    OldValue = raw_get_be_phy_dam_shrink__(Bo),
    NewValue = OldValue + AddValue,  % 注意：这里不需做最少为0的矫正（考虑到buff的影响，临时呈现为负值是有可能的）
    NewAttrs = Bo#battle_obj.attrs#attrs{be_phy_dam_shrink = NewValue},
    Bo2 = Bo#battle_obj{attrs = NewAttrs},
    update_bo(Bo2),
    void.
add_be_mag_dam_shrink(BoId, AddValue) ->
    Bo = get_bo_by_id(BoId),
    OldValue = raw_get_be_mag_dam_shrink__(Bo),
    NewValue = OldValue + AddValue,  % 注意：这里不需做最少为0的矫正（考虑到buff的影响，临时呈现为负值是有可能的）
    NewAttrs = Bo#battle_obj.attrs#attrs{be_mag_dam_shrink = NewValue},
    Bo2 = Bo#battle_obj{attrs = NewAttrs},
    update_bo(Bo2),
    void.

% 加物防（如果是减物防，则AddValue传入负值）
add_phy_def(BoId, AddValue) ->
    Bo = get_bo_by_id(BoId),
    OldValue = raw_get_phy_def__(Bo),
    NewValue = OldValue + AddValue,  % 注意：这里不需做最少为0的矫正（考虑到buff的影响，临时呈现为负值是有可能的）
    NewAttrs = Bo#battle_obj.attrs#attrs{phy_def = NewValue},
    Bo2 = Bo#battle_obj{attrs = NewAttrs},
    update_bo(Bo2),
    void.



% 加法防（如果是减法防，则AddValue传入负值）
add_mag_def(BoId, AddValue) ->
    Bo = get_bo_by_id(BoId),
    OldValue = raw_get_mag_def__(Bo),
    NewValue = OldValue + AddValue,  % 注意：这里不需做最少为0的矫正（考虑到buff的影响，临时呈现为负值是有可能的）
    NewAttrs = Bo#battle_obj.attrs#attrs{mag_def = NewValue},
    Bo2 = Bo#battle_obj{attrs = NewAttrs},
    update_bo(Bo2),
    void.



% %% 设置物理攻击和防御
% set_phy_att_and_phy_def(BoId, NewPhyAtt, NewPhyDef) ->
%     Bo = get_bo_by_id(BoId),
%     NewAttrs = Bo#battle_obj.attrs#attrs{phy_att = NewPhyAtt, phy_def = NewPhyDef},
%     Bo2 = Bo#battle_obj{attrs = NewAttrs},
%     update_bo(Bo2),
%     void.




%% 获取总出手速度
get_act_speed(Bo) ->
    max(raw_get_act_speed__(Bo) + get_tmp_rand_act_speed(Bo), 0).


% 加出手速度（如果是减出手速度，则AddValue传入负值）
add_act_speed(BoId, AddValue) ->
    Bo = get_bo_by_id(BoId),
    OldValue = raw_get_act_speed__(Bo),
    NewValue = OldValue + AddValue,  % 注意：这里不需做最少为0的矫正（考虑到buff的影响，临时呈现为负值是有可能的）
    NewAttrs = Bo#battle_obj.attrs#attrs{act_speed = NewValue},
    Bo2 = Bo#battle_obj{attrs = NewAttrs},
    update_bo(Bo2),
    void.


%% 初始化乱敏
%% @return: #battle_obj{}
init_tmp_rand_act_speed(BoId) ->
    Bo = get_bo_by_id(BoId),
    ?ASSERT(Bo /= null, BoId),
    Val = lib_bt_calc:calc_tmp_rand_act_speed_once(Bo),
    ?ASSERT(is_integer(Val), Val),
    set_tmp_rand_act_speed(BoId, Val).


%% 获取/设置当前回合的乱敏
get_tmp_rand_act_speed(Bo) ->
    Bo#battle_obj.tmp_status#bo_tmp_stat.rand_act_speed.

%% @return: #battle_obj{}
set_tmp_rand_act_speed(BoId, Val) ->
    ?ASSERT(is_integer(Val), Val),
    Bo = get_bo_by_id(BoId),
    OldTmpStatus = Bo#battle_obj.tmp_status,
    NewTmpStatus = OldTmpStatus#bo_tmp_stat{rand_act_speed = Val},
    Bo2 = Bo#battle_obj{tmp_status = NewTmpStatus},
    update_bo(Bo2),
    Bo2.


get_luck(Bo) -> Bo#battle_obj.attrs#attrs.luck.

get_neglect_ret_dam(Bo) -> Bo#battle_obj.attrs#attrs.neglect_ret_dam.


get_do_phy_dam_scaling(Bo) ->
    Val = raw_get_do_phy_dam_scaling__(Bo),
    case is_invisible(Bo) of
        true ->
            case find_passi_eff_by_name(Bo, ?EN_REDUCE_DO_PHY_DAM_SCALING_WHEN_INVISIBLE) of
                null ->
                    max(Val, 0);
                Eff ->
                    max(Val - Eff#bo_peff.do_phy_dam_scaling_reduce, 0)
            end;
        false ->
            max(Val, 0)
    end.


get_do_mag_dam_scaling(Bo) ->
    max(raw_get_do_mag_dam_scaling__(Bo), 0).



%% 提升物理伤害放缩系数（如果是降低系数，则AddRate传入负值）
add_do_phy_dam_scaling(BoId, AddRate) ->
    Bo = get_bo_by_id(BoId),

    OldAttrs = Bo#battle_obj.attrs,
    OldDoDamScaling_Phy = raw_get_do_phy_dam_scaling__(Bo),

    ?DEBUG_MSG("AddRate=~p,OldDoDamScaling_Phy=~p",[AddRate,OldDoDamScaling_Phy]),

    NewDoDamScaling_Phy = OldDoDamScaling_Phy + AddRate,  % 不需矫正
    NewAttrs = OldAttrs#attrs{do_phy_dam_scaling = NewDoDamScaling_Phy},

    Bo2 = Bo#battle_obj{attrs = NewAttrs},
    update_bo(Bo2),
    void.


%% 提升法术伤害放缩系数（如果是降低系数，则AddRate传入负值）
add_do_mag_dam_scaling(BoId, AddRate) ->
    Bo = get_bo_by_id(BoId),

    OldAttrs = Bo#battle_obj.attrs,
    OldDoDamScaling_Mag = raw_get_do_mag_dam_scaling__(Bo),

    ?DEBUG_MSG("AddRate=~p,OldDoDamScaling_Mag=~p",[AddRate,OldDoDamScaling_Mag]),

    NewDoDamScaling_Mag = OldDoDamScaling_Mag + AddRate,  % 不需矫正
    NewAttrs = OldAttrs#attrs{do_mag_dam_scaling = NewDoDamScaling_Mag},

    Bo2 = Bo#battle_obj{attrs = NewAttrs},
    update_bo(Bo2),
    void.


get_crit_coef(Bo) ->
    max(raw_get_crit_coef__(Bo), ?MIN_CRIT_COEF).






%%　（受）物理伤害减免系数
get_be_phy_dam_reduce_coef(Bo) ->
    min(raw_get_be_phy_dam_reduce_coef__(Bo), ?MAX_BE_DAM_REDUCE_COEF).  % 保险起见，做矫正

%% （受）法术伤害减免系数
get_be_mag_dam_reduce_coef(Bo) ->
    min(raw_get_be_mag_dam_reduce_coef__(Bo), ?MAX_BE_DAM_REDUCE_COEF).  % 保险起见，做矫正


%% （受）物理伤害缩小数值
get_be_phy_dam_shrink(Bo) ->
    max(raw_get_be_phy_dam_shrink__(Bo), 0).

%% （受）法术伤害缩小数值
get_be_mag_dam_shrink(Bo) ->
    max(raw_get_be_mag_dam_shrink__(Bo), 0).




%% 提升物理伤害减免系数（如果是降低系数，则AddRate传入负值）
add_be_phy_dam_reduce_coef(BoId, AddRate) ->
    % ?ASSERT( (AddRate < 0)
    %           orelse (AddRate > 0 andalso AddRate =< ?MAX_BE_DAM_REDUCE_COEF),
    %           AddRate
    %        ),

    Bo = get_bo_by_id(BoId),
  ?DEBUG_MSG("wjc2AddRate = ~p ~n",[AddRate]),
    OldBeDamReduceCoef_Phy = raw_get_be_phy_dam_reduce_coef__(Bo),
    NewBeDamReduceCoef_Phy = OldBeDamReduceCoef_Phy + AddRate,
  ?DEBUG_MSG("wjc2AddRate = ~p ~n",[AddRate]),
    NewBeDamReduceCoef_Phy2 = case NewBeDamReduceCoef_Phy > 0 of
                                true ->
                                    erlang:min(NewBeDamReduceCoef_Phy, ?MAX_BE_DAM_REDUCE_COEF);  % 正值不应超过1
                                false ->
                                    NewBeDamReduceCoef_Phy
                            end,

    ?DEBUG_MSG("OldBeDamReduceCoef_Phy=~p,NewBeDamReduceCoef_Phy=~p,NewBeDamReduceCoef_Phy2=~p",[OldBeDamReduceCoef_Phy,NewBeDamReduceCoef_Phy,NewBeDamReduceCoef_Phy2]),

    OldAttrs = Bo#battle_obj.attrs,
    NewAttrs = OldAttrs#attrs{be_phy_dam_reduce_coef = NewBeDamReduceCoef_Phy2},
    Bo2 = Bo#battle_obj{attrs = NewAttrs},
    update_bo(Bo2),
    void.


%% 提升法术伤害减免系数（如果是降低系数，则AddRate传入负值）
add_be_mag_dam_reduce_coef(BoId, AddRate) ->
    ?ASSERT( (AddRate < 0)
              orelse (AddRate > 0 andalso AddRate =< ?MAX_BE_DAM_REDUCE_COEF),
              AddRate
           ),
    Bo = get_bo_by_id(BoId),
    OldBeDamReduceCoef_Mag = raw_get_be_mag_dam_reduce_coef__(Bo),
    NewBeDamReduceCoef_Mag = OldBeDamReduceCoef_Mag + AddRate,

    NewBeDamReduceCoef_Mag2 = case NewBeDamReduceCoef_Mag > 0 of
                                true ->
                                    erlang:min(NewBeDamReduceCoef_Mag, ?MAX_BE_DAM_REDUCE_COEF);  % 正值不应超过1
                                false ->
                                    NewBeDamReduceCoef_Mag
                            end,

    ?DEBUG_MSG("OldBeDamReduceCoef_Mag=~p,NewBeDamReduceCoef_Mag=~p,NewBeDamReduceCoef_Mag2=~p",[OldBeDamReduceCoef_Mag,NewBeDamReduceCoef_Mag,NewBeDamReduceCoef_Mag2]),

    OldAttrs = Bo#battle_obj.attrs,
    NewAttrs = OldAttrs#attrs{be_mag_dam_reduce_coef = NewBeDamReduceCoef_Mag2},
    Bo2 = Bo#battle_obj{attrs = NewAttrs},
    update_bo(Bo2),
    void.


% %% 提升物理伤害减免系数和法术伤害减免系数（如果是降低系数，则AddRate传入负值）
% add_be_dam_reduce_coef(BoId, AddRate) ->
%     ?ASSERT(erlang:abs(AddRate) =< 1, AddRate),
%     Bo = get_bo_by_id(BoId),
%     OldBeDamReduceCoef_Phy = get_be_phy_dam_reduce_coef(Bo),
%     NewBeDamReduceCoef_Phy = util:minmax(OldBeDamReduceCoef_Phy + AddRate, 0, 1),

%     OldBeDamReduceCoef_Mag = get_be_mag_dam_reduce_coef(Bo),
%     NewBeDamReduceCoef_Mag = util:minmax(OldBeDamReduceCoef_Mag + AddRate, 0, 1),

%     Bo2 = Bo#battle_obj{
%                 be_phy_dam_reduce_coef = NewBeDamReduceCoef_Phy,
%                 be_mag_dam_reduce_coef = NewBeDamReduceCoef_Mag
%                 },

%     update_bo(Bo2),
%     void.






%% 物理伤害吸收值
%% TODO: rename to  get_be_phy_dam_absorb() ???
get_phy_dam_absorb(Bo) ->
  SumDamToReduce =
    case find_buff_by_name(Bo, ?BFN_REDUCE_BE_PHY_DAM_SHIELD) of
      null ->
        0;
      Buff ->
        DamToReduce = lib_bo_buff:get_eff_real_value(Buff),
        ?ASSERT(util:is_nonnegative_int(DamToReduce), Buff),
        DamToReduce
    end,
  SumDamToReduce2 = case find_buff_by_name(Bo, ?BFN_REDUCE_BE_DAM_SHIELD) of
    null ->
      0;
    Buff2 ->
      DamToReduce2 = lib_bo_buff:get_eff_real_value(Buff2),
      ?ASSERT(util:is_nonnegative_int(DamToReduce2), Buff2),
      DamToReduce2
  end,
  SumDamToReduce + SumDamToReduce2.

%% 法术伤害吸收值 BFN_REVEVI_ONE_ROUND
get_mag_dam_absorb(Bo) ->
  SumDamToReduce =
    case find_buff_by_name(Bo, ?BFN_REDUCE_BE_MAG_DAM_SHIELD) of
      null ->
        0;
      Buff ->
        DamToReduce = lib_bo_buff:get_eff_real_value(Buff),
        ?ASSERT(util:is_nonnegative_int(DamToReduce), Buff),
        DamToReduce
    end,
  SumDamToReduce2 = case find_buff_by_name(Bo, ?BFN_REDUCE_BE_DAM_SHIELD) of
                      null ->
                        0;
                      Buff2 ->
                        DamToReduce2 = lib_bo_buff:get_eff_real_value(Buff2),
                        ?ASSERT(util:is_nonnegative_int(DamToReduce2), Buff2),
                        DamToReduce2
                    end,
  ?DEBUG_MSG("fashu absorb: ~p~n",[SumDamToReduce2]),
  SumDamToReduce + SumDamToReduce2.



%% 作废！
% %% 法术伤害吸收系数
% %% TODO:
% get_mag_dam_absorb_coef(Bo) ->
%     0.



%% 被治疗效果系数
get_be_heal_eff_coef(Bo) ->
    max(raw_get_be_heal_eff_coef__(Bo), ?MIN_BE_HEAL_EFF_COEF).

%% 加被治疗效果系数（如果是减，则AddValue传入负值）
add_be_heal_eff_coef(BoId, AddValue) ->
    Bo = get_bo_by_id(BoId),
    OldValue = raw_get_be_heal_eff_coef__(Bo),
    NewValue = OldValue + AddValue,  % 注意：这里不需做最少为0的矫正（考虑到buff的影响，临时呈现为负值是有可能的）

    OldAttrs = Bo#battle_obj.attrs,
    NewAttrs = OldAttrs#attrs{be_heal_eff_coef = NewValue},
    Bo2 = Bo#battle_obj{attrs = NewAttrs},
    update_bo(Bo2),
    void.

%% 加治疗效果系数（如果是减，则AddValue传入负值）
add_heal_eff_coef(BoId, AddValue) ->
  Bo = get_bo_by_id(BoId),
  OldValue = raw_get_heal_eff_coef__(Bo),
  NewValue = OldValue + AddValue,  % 注意：这里不需做最少为0的矫正（考虑到buff的影响，临时呈现为负值是有可能的）

  OldAttrs = Bo#battle_obj.attrs,
  NewAttrs = OldAttrs#attrs{heal_eff_coef = NewValue},
  Bo2 = Bo#battle_obj{attrs = NewAttrs},
  update_bo(Bo2),
  void.

add_revive_heal_coef(BoId, AddValue) ->
  Bo = get_bo_by_id(BoId),
  OldValue = raw_get_revive_heal_coef__(Bo),
  NewValue = OldValue + AddValue,  % 注意：这里不需做最少为0的矫正（考虑到buff的影响，临时呈现为负值是有可能的）

  OldAttrs = Bo#battle_obj.attrs,
  NewAttrs = OldAttrs#attrs{revive_heal_coef  = NewValue},
  Bo2 = Bo#battle_obj{attrs = NewAttrs},
  update_bo(Bo2),
  void.

add_reduce_purse_att_dam_coef(BoId, AddValue) ->
  Bo = get_bo_by_id(BoId),
  OldValue = raw_get_reduce_pursue_att_dam_coef__(Bo),
  NewValue = OldValue + AddValue,  % 注意：这里不需做最少为0的矫正（考虑到buff的影响，临时呈现为负值是有可能的）

  OldAttrs = Bo#battle_obj.attrs,
  NewAttrs = OldAttrs#attrs{reduce_pursue_att_dam_coef  = NewValue},
  Bo2 = Bo#battle_obj{attrs = NewAttrs},
  update_bo(Bo2),
  void.



% 添加反震程度的buff
%
add_ret_dam_coef(BoId, AddValue) ->
    Bo = get_bo_by_id(BoId),
    OldValue = raw_get_ret_dam_coef__(Bo),
    NewValue = OldValue + AddValue,  % 注意：这里不需做最少为0的矫正（考虑到buff的影响，临时呈现为负值是有可能的）
    ?DEBUG_MSG("testRetDam2 ~p~n",[{OldValue,AddValue}]),
    OldAttrs = Bo#battle_obj.attrs,
    NewAttrs = OldAttrs#attrs{ret_dam_coef = NewValue},
    Bo2 = Bo#battle_obj{attrs = NewAttrs},
    update_bo(Bo2),
    void.

% 添加暴击系数
add_crit_coef(BoId, AddValue) ->
    Bo = get_bo_by_id(BoId),
    OldValue = raw_get_crit_coef__(Bo),
    NewValue = OldValue + AddValue,  % 注意：这里不需做最少为0的矫正（考虑到buff的影响，临时呈现为负值是有可能的）

    OldAttrs = Bo#battle_obj.attrs,
    NewAttrs = OldAttrs#attrs{crit_coef = NewValue},
    Bo2 = Bo#battle_obj{attrs = NewAttrs},
    update_bo(Bo2),
    void.


%% 获取反震（即反弹伤害）的概率
get_ret_dam_proba(Bo) ->
    max(raw_get_ret_dam_proba__(Bo), 0).

    % 临时矫正最低为10%的概率（概率基数为1000）， 用于测试
    % max(raw_get_ret_dam_proba__(Bo), round(0.1 * ?PROBABILITY_BASE)).



% % 加反震概率（如果是减，则AddValue传入负值）
% add_ret_dam_proba(BoId, AddValue) ->
%     Bo = get_bo_by_id(BoId),
%     OldValue = raw_get_ret_dam_proba__(Bo),
%     NewValue = min(OldValue + AddValue, ?PROBABILITY_BASE),  % 注意：这里不需做最少为0的矫正（考虑到buff的影响，临时呈现为负值是有可能的）

%     OldAttrs = Bo#battle_obj.attrs,
%     NewAttrs = OldAttrs#attrs{ret_dam_proba = NewValue},
%     Bo2 = Bo#battle_obj{attrs = NewAttrs},
%     update_bo(Bo2),
%     void.




%% 获取反弹伤害系数
get_ret_dam_coef(Bo) ->
    max(raw_get_ret_dam_coef__(Bo), 0).



%% 吸血系数
get_absorb_hp_coef(Bo) ->
    max(raw_get_absorb_hp_coef__(Bo), ?MIN_ABSORB_HP_COEF).

add_absorb_hp_coef(BoId, AddValue) ->
    Bo = get_bo_by_id(BoId),
    OldValue = raw_get_absorb_hp_coef__(Bo),  %%%#battle_obj.absorb_hp_coef,
    NewValue = OldValue + AddValue,  % 注意：这里不需做最少为0的矫正（考虑到buff的影响，临时呈现为负值是有可能的）

    OldAttrs = Bo#battle_obj.attrs,
    NewAttrs = OldAttrs#attrs{absorb_hp_coef = NewValue},
    Bo2 = Bo#battle_obj{attrs = NewAttrs},  %%%absorb_hp_coef = NewValue},
    update_bo(Bo2),
    void.



%% 驱鬼系数
get_qugui_coef(Bo) ->
    max(raw_get_qugui_coef__(Bo), ?MIN_QUGUI_COEF).




%% 暂时没用，注释掉
% add_qugui_coef(BoId, AddValue) ->
%     Bo = get_bo_by_id(BoId),
%     OldValue = raw_get_qugui_coef__(Bo),
%     NewValue = OldValue + AddValue,

%     OldAttrs = Bo#battle_obj.attrs,
%     NewAttrs = OldAttrs#attrs{qugui_coef = NewValue},
%     Bo2 = Bo#battle_obj{attrs = NewAttrs},
%     update_bo(Bo2),
%     void.









%% 冰冻命中
get_frozen_hit(Bo) ->
    max(raw_get_frozen_hit__(Bo) + get_seal_hit(Bo), 1).

%% 昏睡命中
get_trance_hit(Bo) ->
    max(raw_get_trance_hit__(Bo) + get_seal_hit(Bo), 1).

%% 混乱命中
get_chaos_hit(Bo) ->
    max(raw_get_chaos_hit__(Bo) + get_seal_hit(Bo), 1).


%% 冰封抗性
get_frozen_resis(Bo) ->
    max(raw_get_frozen_resis__(Bo) + get_seal_resis(Bo), 1).  % 按策划的意思，抗性至少为1（因为涉及除以抗性的公式运算，故不能为0）

%% 昏睡抗性
get_trance_resis(Bo) ->
    max(raw_get_trance_resis__(Bo) + get_seal_resis(Bo), 1).  % 按策划的意思，抗性至少为1（因为涉及除以抗性的公式运算，故不能为0）

%% 混乱抗性
get_chaos_resis(Bo) ->
    max(raw_get_chaos_resis__(Bo) + get_seal_resis(Bo), 1).   % 按策划的意思，抗性至少为1（因为涉及除以抗性的公式运算，故不能为0）



%% 作废！！
% get_total_frozen_hit(Bo) ->
%     get_frozen_hit(Bo). %  + 临时的加成

% get_total_trance_hit(Bo) ->
%     get_trance_hit(Bo). %  + 临时的加成

% get_total_chaos_hit(Bo) ->
%     get_chaos_hit(Bo). %  + 临时的加成

% get_total_frozen_resis(Bo) ->
%     get_frozen_resis(Bo). %  + 临时的加成

% get_total_trance_resis(Bo) ->
%     get_trance_resis(Bo). %  + 临时的加成

% get_total_chaos_resis(Bo) ->
%     get_chaos_resis(Bo). %  + 临时的加成



get_be_chaos_att_team_paoba(Bo) ->
    raw_get_be_chaos_att_team_paoba__(Bo).
get_be_chaos_att_team_phy_dam(Bo) ->
    raw_get_be_chaos_att_team_phy_dam__(Bo).
get_neglect_seal_resis(Bo) ->
    raw_get_neglect_seal_resis__(Bo).
get_seal_hit_to_partner(Bo) ->
    raw_get_seal_hit_to_partner__(Bo).
get_seal_hit_to_mon(Bo) ->
    raw_get_seal_hit_to_mon__(Bo).
get_phy_dam_to_partner(Bo) ->
    raw_get_phy_dam_to_partner__(Bo).
get_phy_dam_to_mon(Bo) ->
    raw_get_phy_dam_to_mon__(Bo).
get_mag_dam_to_partner(Bo) ->
    raw_get_mag_dam_to_partner__(Bo).
get_mag_dam_to_mon(Bo) ->
    raw_get_mag_dam_to_mon__(Bo).
get_be_chaos_round_repair(Bo) ->
    raw_get_be_chaos_round_repair__(Bo).
get_chaos_round_repair(Bo) ->
    raw_get_chaos_round_repair__(Bo).
get_be_froze_round_repair(Bo) ->
    raw_get_be_froze_round_repair__(Bo).
get_froze_round_repair(Bo) ->
    raw_get_froze_round_repair__(Bo).
get_neglect_phy_def(Bo) ->
    raw_get_neglect_phy_def__(Bo).
get_neglect_mag_def(Bo) ->
    raw_get_neglect_mag_def__(Bo).

get_phy_dam_to_speed_1(Bo) ->
    raw_get_phy_dam_to_speed_1__(Bo).
get_phy_dam_to_speed_2(Bo) ->
    raw_get_phy_dam_to_speed_2__(Bo).
get_mag_dam_to_speed_1(Bo) ->
    raw_get_mag_dam_to_speed_1__(Bo).
get_mag_dam_to_speed_2(Bo) ->
    raw_get_mag_dam_to_speed_2__(Bo).
get_seal_hit_to_speed(Bo) ->
    raw_get_seal_hit_to_speed__(Bo).

get_revive_heal_coef(Bo) ->
    raw_get_revive_heal_coef__(Bo).

get_seal_hit(Bo) ->
    max(raw_get_seal_hit__(Bo), 1).


% get_total_seal_resis(Bo) ->
%     get_seal_resis(Bo).

get_seal_resis(Bo) ->
    % max(Bo#battle_obj.attrs#attrs.seal_resis, 0).
    max(raw_get_seal_resis__(Bo), 1).


% 加封印抗性（如果是减，则AddValue传入负值）
add_seal_resis(BoId, AddValue) ->
    Bo = get_bo_by_id(BoId),
    OldValue = raw_get_seal_resis__(Bo),
    NewValue = OldValue + AddValue,  % 注意：这里不需做最少为0的矫正（考虑到buff的影响，临时呈现为负值是有可能的）
    NewAttrs = Bo#battle_obj.attrs#attrs{seal_resis = NewValue},
    Bo2 = Bo#battle_obj{attrs = NewAttrs},
    update_bo(Bo2),
    void.

% 加忽视封印抗性（如果是减，则AddValue传入负值）
add_neglect_seal_resis(BoId, AddValue) ->
  Bo = get_bo_by_id(BoId),
  OldValue = raw_get_neglect_seal_resis__(Bo),
  NewValue = OldValue + AddValue,  % 注意：这里不需做最少为0的矫正（考虑到buff的影响，临时呈现为负值是有可能的）
  NewAttrs = Bo#battle_obj.attrs#attrs{neglect_seal_resis = NewValue},
  Bo2 = Bo#battle_obj{attrs = NewAttrs},
  update_bo(Bo2),
  void.


% 加封印抗性（如果是减，则AddValue传入负值）
add_seal_hit(BoId, AddValue) ->
    Bo = get_bo_by_id(BoId),
    OldValue = raw_get_seal_hit__(Bo),
    NewValue = OldValue + AddValue,  % 注意：这里不需做最少为0的矫正（考虑到buff的影响，临时呈现为负值是有可能的）
    NewAttrs = Bo#battle_obj.attrs#attrs{seal_hit = NewValue},
    Bo2 = Bo#battle_obj{attrs = NewAttrs},
    update_bo(Bo2),
    void.







get_cmd_type(Bo) -> Bo#battle_obj.cmd_type.
get_cmd_para(Bo) -> Bo#battle_obj.cmd_para.

% get_real_cmd_type(Bo) -> Bo#battle_obj.real_cmd_type.
% get_real_cmd_para(Bo) -> Bo#battle_obj.real_cmd_para.

% update_real_cmd_type(BoId, CmdType) ->
%     Bo = get_bo_by_id(BoId),
%     Bo2 = Bo#battle_obj{real_cmd_type = CmdType},
%     upadte_bo(Bo2),
%     void.


%% 是在第几个回合刷出的？
get_when_spawn_round(Bo) ->
    Bo#battle_obj.when_spawn_round.

adjust_when_spawn_round(BoId, Round) ->
    ?ASSERT(util:is_positive_int(Round), Round),
    Bo = get_bo_by_id(BoId),
    Bo2 = Bo#battle_obj{when_spawn_round = Round},
    update_bo(Bo2),
    void.


%% 获取bo对应所属的玩家bo的id
get_my_owner_player_bo_id(Bo) ->
    Bo#battle_obj.my_owner_player_bo_id.


%% 设置bo对应所属的玩家bo的id
set_my_owner_player_bo_id(BoId, MyOwnerPlayerBoId) ->
    ?ASSERT(is_player( get_bo_by_id(MyOwnerPlayerBoId)), MyOwnerPlayerBoId),
    Bo = get_bo_by_id(BoId),
    ?ASSERT(is_partner(Bo) orelse is_hired_player(Bo), Bo),  % 目前断言是针对宠物或雇佣的玩家
    Bo2 = Bo#battle_obj{my_owner_player_bo_id = MyOwnerPlayerBoId},
    update_bo(Bo2),
    void.



%% 获取bo对应所属的玩家bo
%% @return: null | battle_obj结构体
get_my_owner_player_bo(Bo) ->
    OwnerPlayerBoId = get_my_owner_player_bo_id(Bo),
    get_bo_by_id(OwnerPlayerBoId).


%% 获取玩家bo对应的主宠bo
%% @return: null | battle_obj结构体
get_my_main_partner_bo(PlayerBo) ->
    ?ASSERT(is_player(PlayerBo), PlayerBo),
    case PlayerBo#battle_obj.my_main_partner_bo_id of
        ?INVALID_ID ->
            null;
        MainParBoId ->
            get_bo_by_id(MainParBoId)
    end.


%% 获取玩家bo对应的主宠bo的id
get_my_main_partner_bo_id(PlayerBo) ->
    ?ASSERT(is_player(PlayerBo), PlayerBo),
    PlayerBo#battle_obj.my_main_partner_bo_id.

%% 设置玩家bo对应的主宠bo的id
set_my_main_partner_bo_id(PlayerBoId, MyMainPartnerBoId) ->
    Bo = get_bo_by_id(PlayerBoId),
    ?ASSERT(is_player(Bo), PlayerBoId),
    Bo2 = Bo#battle_obj{my_main_partner_bo_id = MyMainPartnerBoId},
    update_bo(Bo2),
    void.


% %% 查找玩家的宠物bo id列表
% %% @return: [] | 宠物bo id列表
% find_my_partner_bo_id_list(PlayerBo) ->
%     ?ASSERT(is_player(PlayerBo), PlayerBo),
%     PlayerBoId = get_id(PlayerBo),
%     Side = get_side(PlayerBo),
%     BoIdList = get_bo_id_list(Side),
%     F = fun(BoId) ->
%             Bo = get_bo_by_id(BoId),
%             is_partner(Bo) andalso (get_my_owner_player_bo_id(Bo) == PlayerBoId)
%         end,

%     [X || X <- BoIdList, F(X)].





%% 查找玩家的当前仍在战场中的宠物bo id列表
%% @return: [] | 宠物bo id列表
find_my_existing_par_bo_id_list(PlayerBo) ->
    ?ASSERT(is_player(PlayerBo), PlayerBo),
    PlayerBoId = get_id(PlayerBo),
    Side = get_side(PlayerBo),
    BoIdList = get_bo_id_list(Side),
    F = fun(BoId) ->
            Bo = get_bo_by_id(BoId),
            is_partner(Bo) andalso (get_my_owner_player_bo_id(Bo) == PlayerBoId)
        end,

    [X || X <- BoIdList, F(X)].



% %% 获取宠物bo id列表， 注意：返回的列表可能包含已死亡的宠物！
% get_my_partner_bo_id_list(Bo) ->
%     ?ASSERT(is_player(Bo), Bo),
%     [ParBoId || {ParBoId, _ParId} <- Bo#battle_obj.my_partner_bo_info_list].


%% 获取宠物信息列表，注意：返回的列表可能包含已死亡并且已被移除的宠物！
get_my_partner_bo_info_list(Bo) ->
    ?ASSERT(is_player(Bo), Bo),
    Bo#battle_obj.my_partner_bo_info_list.


%% 添加宠物到玩家bo所记录的宠物信息列表
add_to_my_partner_bo_info_list(OwnerPlayerBoId, {PartnerBoId, PartnerId}) ->
    Bo = get_bo_by_id(OwnerPlayerBoId),
    ?ASSERT(is_player(Bo), OwnerPlayerBoId),

    OldList = get_my_partner_bo_info_list(Bo),
    ?ASSERT(util:is_tuple_list(OldList), OldList),
    NewList = [{PartnerBoId, PartnerId} | OldList],

    Bo2 = Bo#battle_obj{my_partner_bo_info_list = NewList},
    update_bo(Bo2),
    void.

%% 从玩家bo所记录的宠物信息列表移除某宠物
remove_from_my_partner_bo_info_list(OwnerPlayerBoId, PartnerBoId) ->
    Bo = get_bo_by_id(OwnerPlayerBoId),
    ?ASSERT(is_player(Bo), OwnerPlayerBoId),

    L = get_my_partner_bo_info_list(Bo),
    ?ASSERT(lists:keyfind(PartnerBoId, 1, L) /= false, {PartnerBoId, L}),
    L2 = lists:keydelete(PartnerBoId, 1, L),

    Bo2 = Bo#battle_obj{my_partner_bo_info_list = L2},
    update_bo(Bo2),
    void.













% mark_already_joined_battle(Bo) ->
%     case is_partner(Bo) of
%         true ->

%         false ->
%             ?ASSERT(false),
%             skip
%     end.




%% 获取玩家的本次战斗中已出战过的宠物id列表
get_my_already_joined_battle_par_id_list(PlayerBo) ->
    ?ASSERT(is_player(PlayerBo), PlayerBo),
    PlayerBo#battle_obj.my_already_joined_battle_par_id_list.


add_to_my_already_joined_battle_par_list(OwnerPlayerBoId, PartnerId) ->
    Bo = get_bo_by_id(OwnerPlayerBoId),
    L = Bo#battle_obj.my_already_joined_battle_par_id_list,
    ?ASSERT(util:is_integer_list(L), L),
    L2 = [PartnerId | L],
    Bo2 = Bo#battle_obj{my_already_joined_battle_par_id_list = L2},
    update_bo(Bo2),
    void.


%% @return: null | battle_obj结构体
get_my_hired_player_bo(Bo) ->
    MyHiredPlayerBoId = get_my_hired_player_bo_id(Bo),
    get_bo_by_id(MyHiredPlayerBoId).


get_my_hired_player_bo_id(Bo) ->
    Bo#battle_obj.my_hired_player_bo_id.


set_my_hired_player_bo_id(BoId, MyHiredPlayerBoId) ->
    %%%?ASSERT(is_hired_player( get_bo_by_id(MyHiredPlayerBoId)), MyHiredPlayerBoId),
    Bo = get_bo_by_id(BoId),
    ?ASSERT(is_player(Bo) andalso (not is_hired_player(Bo)), Bo),
    Bo2 = Bo#battle_obj{my_hired_player_bo_id = MyHiredPlayerBoId},
    update_bo(Bo2),
    void.


%% 获取雇佣玩家的id，如果没有，则返回INVALID_ID
get_my_hired_player_id(Bo) ->
    case get_my_hired_player_bo(Bo) of
        null ->
            ?INVALID_ID;
        MyHiredPlyBo ->
            get_parent_obj_id(MyHiredPlyBo)
    end.



%% 获取竞技场对手（玩家）的id，如果不是竞技场战斗，则实际上固定返回INVALID_ID
get_my_pvp_oppo_player_id_list(Bo) ->
    MySide = get_side(Bo),
    EnemySide = lib_bt_comm:to_enemy_side(MySide),
    lib_bt_dict:get_pvp_player_id_list(EnemySide).


get_suit_no(Bo) ->
    Bo#battle_obj.suit_no.

get_graph_title(Bo) ->
    Titles = Bo#battle_obj.titles,
    Titles#bo_titles.graph_title.

get_text_title(Bo) ->
    Titles = Bo#battle_obj.titles,
    Titles#bo_titles.text_title.

get_user_def_title(Bo) ->
    Titles = Bo#battle_obj.titles,
    Titles#bo_titles.user_def_title.


-define(FLAG_ONLINE, 1).
-define(FLAG_OFFLINE, 2).

%% 获取在线标记
get_online_flag(Bo) ->
    case lib_bt_comm:is_online(Bo) of
        true -> ?FLAG_ONLINE;
        false -> ?FLAG_OFFLINE
    end.


%% @return: 等级 | error
get_xinfa_lv(Bo, XinfaId) ->
    XfBriefL = Bo#battle_obj.xinfa_brief_list,
    case lists:keyfind(XinfaId, #xinfa_brief.id, XfBriefL) of
        false ->
            % ?ASSERT(false, {XinfaId, Bo}),
            % error;
            get_lv(Bo);
        XfBrief ->
            XfBrief#xinfa_brief.lv
    end.



%% 是否有指定的主动技？
has_initiative_skill(Bo, SkillId) ->
    L = get_initiative_skill_list(Bo),
    case lists:keyfind(SkillId, #bo_skl_brf.id, L) of
        false -> false;
        _SklBrief -> true
    end.

%% 是否有指定的被动技？
has_passive_skill(Bo, SkillId) ->
    L = get_passive_skill_list(Bo),
    case lists:keyfind(SkillId, #bo_skl_brf.id, L) of
        false -> false;
        _SklBrief -> true
    end.


%% 是否有指定的技能（主动技或被动技）？
has_skill(Bo, SkillId) ->
    L = get_all_skill_list(Bo),
    case lists:keyfind(SkillId, #bo_skl_brf.id, L) of
        false -> false;
        _SklBrief -> true
    end.


%% 主动技列表（包括夫妻技能，如果有的话）
%% @return: [] | bo_skl_brf结构体列表
get_initiative_skill_list(Bo) ->
    Bo#battle_obj.initiative_skill_list.

%% 被动技列表（包括夫妻技能，如果有的话）
%% @return: [] | bo_skl_brf结构体列表
get_passive_skill_list(Bo) ->
    Bo#battle_obj.passi_skill_list.

%% 主动+被动技列表
%% @return: [] | bo_skl_brf结构体列表
get_all_skill_list(Bo) ->
    % Bo#battle_obj.skill_list.
    Bo#battle_obj.initiative_skill_list ++ Bo#battle_obj.passi_skill_list.





%% 设置在线标记
set_online(BoId, Bool) when is_boolean(Bool) ->
    Bo = get_bo_by_id(BoId),
    Bo2 = Bo#battle_obj{is_online = Bool},
    update_bo(Bo2),
    void.


%% 设置自动战斗标记
set_auto_battle(BoId, Bool) when is_boolean(Bool) ->
    Bo = get_bo_by_id(BoId),
    Bo2 = Bo#battle_obj{is_auto_battle = Bool},
    update_bo(Bo2),
    void.


%% 标记为主宠
mark_as_main_partner(BoId) ->
    Bo = get_bo_by_id(BoId),
    Bo2 = Bo#battle_obj{is_main_partner = true},
    update_bo(Bo2),
    void.



%% 获取bo的指定技能的简要信息
%% @return: null | bo_skl_brf结构体
get_skill_brief(Bo, SkillId) ->
    SkillList = get_all_skill_list(Bo),
    case lists:keyfind(SkillId, #bo_skl_brf.id, SkillList) of
        false ->
            null;
        BoSklBrief ->
            BoSklBrief
    end.



%% 获取bo当前所用技能的简要信息
%% @return: null | bo_skl_brf结构体
get_cur_skill_brief(Bo) -> Bo#battle_obj.cur_skill_brief.

set_cur_skill_brief(Bo,SkillId,SkillLv) ->
    Bo2 = Bo#battle_obj{cur_skill_brief = lib_bt_skill:to_bo_skill_brief({SkillId, SkillLv})},
    update_bo(Bo2),  % 更新到进程字典！
    Bo2.


%% 获取bo当前所使用的技能的配置数据
%% @return: null | skl_cfg结构体
get_cur_skill_cfg(Bo) ->
    case get_cur_skill_brief(Bo) of
        null ->
            null;
        CurSklBrf ->
            SkillId = CurSklBrf#bo_skl_brf.id,
            % SkillLv = CurSklBrf#bo_skl_brf.lv,
            mod_skill:get_cfg_data(SkillId)
    end.





get_cur_pick_target(Bo) -> Bo#battle_obj.cur_pick_target.




%% 是否无法被攻击？
cannot_be_attacked(_Bo) ->
    is_invincible(_Bo).       % 目前都是可以被攻击 无敌状态不可以被攻击



% %% 是否只能使用物品而不能下达其他的指令？
% can_only_use_goods(Bo) ->
%     is_trance(Bo).


%% bo在当前回合是否无法行动？
cannot_act(Bo) ->
    % ?TRACE("is_cding:~p, is_xuliing:~p~n", [is_cding(Bo), is_xuliing(Bo)]),
    CmdType = get_cmd_type(Bo),
    io:format("wujianchengtestbattle2 ~p ~n" , [{ is_dead(Bo),is_xuliing(Bo),is_frozen(Bo) , (is_cding(Bo) andalso (CmdType /= ?CMD_T_USE_GOODS) andalso (CmdType /= ?CMD_T_SUMMON_PARTNER)), CmdType, Bo}]),

    % 修改成CD中可以使用召唤以及道具
  is_dead2(Bo,act) orelse is_xuliing(Bo) orelse is_frozen(Bo) orelse (is_cding(Bo) andalso (CmdType /= ?CMD_T_USE_GOODS) andalso (CmdType /= ?CMD_T_SUMMON_PARTNER)).

    % CmdType = get_cmd_type(Bo),
    % is_trance(Bo)
    % andalso (CmdType /= ?CMD_T_USE_GOODS)
    % andalso (CmdType /= ?CMD_T_SUMMON_PARTNER).



%% 标记为已经下达过指令
mark_cmd_prepared(BoId) ->
    ?ASSERT(is_integer(BoId)),
    Bo = get_bo_by_id(BoId),
    Bo2 = Bo#battle_obj{is_cmd_prepared = true},
    update_bo(Bo2),
    Bo2.

% %% 标记为未下达指令
% mark_cmd_not_prepared(BoId) ->
%     ?ASSERT(is_integer(BoId)),
%     Bo = get_bo_by_id(BoId),
%     Bo2 = Bo#battle_obj{is_cmd_prepared = false},
%     update_bo(Bo2),
%     Bo2.


%% 当前回合是否已经下达过指令了？
is_cmd_prepared(Bo) ->
    Bo#battle_obj.is_cmd_prepared.



%% 标记为已经播放战报完毕
mark_show_battle_report_done(BoId) ->
    ?ASSERT(is_integer(BoId), BoId),
    Bo = get_bo_by_id(BoId),
    Bo2 = Bo#battle_obj{is_show_battle_report_done = true},
    update_bo(Bo2),  % 更新到进程字典！
    void.


%% 是否已经播放战报完毕？
is_show_battle_report_done(Bo) ->
    case is_just_back_to_battle(Bo) of
        true ->
            true;
        false ->
            case is_online_player(Bo) of
                true ->
                    Bo#battle_obj.is_show_battle_report_done;
                false ->
                    true  % 非在线玩家则都固定返回true
            end
    end.






%% 标记为刚刚回归战斗
mark_just_back_to_battle(BoId) ->
    Bo = get_bo_by_id(BoId),
    Bo2 = Bo#battle_obj{is_just_back_to_battle = true},
    update_bo(Bo2),
    void.

is_just_back_to_battle(Bo) ->
    Bo#battle_obj.is_just_back_to_battle.



mark_force_change_to_normal_att(BoId) ->
    Bo = get_bo_by_id(BoId),
    Bo2 = Bo#battle_obj{is_force_change_to_normal_att = true},
    update_bo(Bo2),
    void.

is_force_change_to_normal_att(Bo) ->
    Bo#battle_obj.is_force_change_to_normal_att.





% 作废！！
% %% 是否临时强行自动攻击？
% is_tmp_force_auto_attack(Bo) ->
%     TmpStatus = Bo#battle_obj.tmp_status,
%     TmpStatus#bo_tmp_stat.force_auto_attack.


%% 是否强行自动攻击？
is_force_auto_attack(Bo) ->
    find_buff_by_name(Bo, ?BFN_FORCE_AUTO_ATTACK) /= null.



%% 所属的玩家bo是否在线？
is_my_owner_player_bo_online(Bo) ->
    case get_my_owner_player_bo(Bo) of
        null ->
            false;
        OwnerPlayerBo ->
            lib_bt_comm:is_online(OwnerPlayerBo)
    end.




%% 是否可操控？
can_be_ctrled(Bo) ->
    Bo#battle_obj.can_be_ctrled.


%% 判断bo当前回合是否已经准备好了（是否已经下达指令了？  如果在bo当前回合无法行动，也认为是准备好了）
is_ready(Bo) ->
    ?Ifc (lib_bt_comm:is_player(Bo))
        ?TRACE("is_ready(), is_cmd_prepared: ~p, is_auto_battle: ~p, cannot_act: ~p, is_force_auto_attack: ~p~n",
                    [is_cmd_prepared(Bo), is_auto_battle(Bo), cannot_act(Bo), is_force_auto_attack(Bo)])
    ?End,

    case is_just_back_to_battle(Bo) of
        true ->
            true;
        false ->
            ?DEBUG_MSG("wjctestlibbo ~p~n" , [{is_online_player(Bo),is_online_main_partner(Bo),lib_bt_comm:is_plot_bo(Bo),can_be_ctrled(Bo),Bo#battle_obj.id}]),
            case is_online_player(Bo)   % 在线的玩家必须下达过指令才算准备好。  在线死亡玩家也要这样么？ ---- 是的
            orelse is_online_main_partner(Bo)   % 在线的主宠同样是必须下达过指令才算准备好
            orelse (lib_bt_comm:is_plot_bo(Bo) andalso can_be_ctrled(Bo)) of  % 可操控的剧情bo同样是...
                true ->
                    is_cmd_prepared(Bo);
                false ->
                    case is_hired_player(Bo) andalso is_my_owner_player_bo_online(Bo) of
                        true ->
                            is_cmd_prepared(Bo);
                        false ->
                            % TODO: 完善断言...
                            ?ASSERT(is_auto_battle(Bo) orelse is_offline(Bo), {is_offline(Bo), Bo}),
                            %         orelse cannot_act(Bo)
                            %         orelse is_dead(Bo)
                            %         orelse is_force_auto_attack(Bo)),


true   % 其他的则都固定认为是准备好了
                    end
            end
    end.





% clear_ready_flag(Bo) ->
%     set_ready_flag(Bo, false).

% set_ready_flag(Bo, Bool) when is_boolean(Bool) ->
%     Bo2 = Bo#battle_obj{is_ready = Bool},
%     update_bo(Bo2),  % 更新到进程字典！
%     Bo2.


%% bo是否自动战斗？
is_auto_battle(Bo) ->
    Bo#battle_obj.is_auto_battle.




% %% 检测bo是否有指定的状态？
% has_status(Bo, stat_undead) -> % 不死状态
%     case find_buff_by_name(Bo, ?BFN_UNDEAD) of
%         null -> false;
%         _BoBuff -> true
%     end;

% has_status(_Bo, _Status) ->
%     ?ASSERT(false, _Status),
%     false.



% %% bo在当前回合是否必须为使用普通攻击？
% have_to_use_normal_att(Bo) ->
%     is_using_normal_att(Bo)
%     orelse is_chaos(Bo)
%     orelse is_force_auto_attack(Bo).  % 目前认为当强行自动攻击时，也是只能使用普通攻击。



%% 是否本来用的就是普通攻击（是否当前回合所下达的指令为普通攻击）？ 被强行矫正为普通攻击的不算
is_original_using_normal_att(Bo) ->
    get_cmd_type(Bo) == ?CMD_T_NORMAL_ATT.


%% 当前回合是否为普通攻击（被强行矫正为普通攻击的也算是）？
is_using_normal_att(Bo) ->
    get_cmd_type(Bo) == ?CMD_T_NORMAL_ATT
    orelse is_force_change_to_normal_att(Bo).



%% 当前回合是否选择防御？
is_using_defend(Bo) ->
    get_cmd_type(Bo) == ?CMD_T_DEFEND.




% %% 是否处于不死状态？
% is_undead(Bo) ->
%     find_buff_by_name(Bo, ?BFN_UNDEAD) /= null.



%% 作废！！
% %% 测试一次不死buff是否起效？
% %% @return: success（起效） | fail（不起效）
% test_undead_once(Bo) ->
%     case find_buff_by_name(Bo, ?BFN_UNDEAD) of
%         null ->
%             fail;
%         UndeadBuff ->
%             % 判断概率
%             Proba = lib_bo_buff:get_buff_tpl_para(UndeadBuff),
%             ?ASSERT(util:is_nonnegative_int(Proba), {Proba, UndeadBuff}),
%             case lib_bt_util:test_proba(Proba) of
%                 success ->
%                     ?DEBUG_MSG("test_undead_once() success!! Proba=~p............. BoId=~p~n", [Proba, get_id(Bo)]),
%                     success;
%                 fail ->
%                     fail
%             end
%     end.



%% 测试一次免疫伤害是否起效？
%% @return: success（起效） | fail（不起效）
test_immu_dam_once(Bo) ->
            case find_buff_by_name(Bo, ?BFN_IMMU_DAMAGE) of
                null ->
                    fail;
                ImmuDamBuff ->
                    % 判断概率 (从对应的buff模板的参数获取概率)
                    {proba, Proba} = lib_bo_buff:get_buff_tpl_para(ImmuDamBuff),
                    ?ASSERT(util:is_nonnegative_int(Proba), {Proba, ImmuDamBuff}),
                    case lib_bt_util:test_proba(Proba) of
                        success ->
                            ?DEBUG_MSG("test_immu_damage_once() success!! Proba=~p............. BoId=~p~n", [Proba, get_id(Bo)]),
                            success;
                        fail ->
                            fail
                    end
            end.




%% 尝试应用物理攻击时幽影冥王技能所引发的buff效果
%% @return: purge_buffs_dtl结构体
try_apply_youying_mingwang_buff_eff_by_do_phy_dam(AtterId, DeferId, DamVal) ->
    case DamVal =< 0 of
        true ->
            {#purge_buffs_dtl{}, #add_buffs_dtl{}};
        false ->
            Atter = get_bo_by_id(AtterId),
            case find_buff_by_name(Atter, ?BFN_YOUYING_MINGWANG) of
                null ->
                    {#purge_buffs_dtl{}, #add_buffs_dtl{}};
                Buff ->
                    % Defer = get_bo_by_id(DeferId),

                    % 判定概率(目前的做法是从对应的buff模板获取)
                    BuffTplPara = lib_bo_buff:get_buff_tpl_para(Buff),
                    {{proba, Proba}, {purge_count, PurgeCount}, _, {add_buff_by_no, AddBuffNo}} = BuffTplPara,

                    % 给对方加buff
                    {DefBuffsAdded__, DefBuffsRemoved__} =
                      case add_buff(AtterId, DeferId, AddBuffNo, 33, 1) of % 幽影冥王技能编号33 作用目标为1
                        fail ->
                          {[], []};
                        {ok, nothing_to_do} ->
                          {[], []};
                        {ok, new_buff_added} ->
                          {[AddBuffNo], []};
                        {ok, old_buff_replaced, OldBuffNo} ->
                          {[AddBuffNo], [OldBuffNo]};
                        {passi, RemovedBuffNo} ->
                          {[], RemovedBuffNo}
                      end,
                    AddBuffsDtl = #add_buffs_dtl{atter_buffs_added = []
                                                ,defer_buffs_added = DefBuffsAdded__
                                            },
                    % Proba = lib_bo_buff:get_eff_real_value(Buff),

                    ?ASSERT(util:is_positive_int(Proba), {Proba, AtterId, Buff}),
                    ?ASSERT(util:is_positive_int(PurgeCount), {PurgeCount, Buff}),

                    % Proba2 = Proba / ?PROBABILITY_BASE,
                    case lib_bt_util:test_proba(Proba) of
                        fail ->
                            {#purge_buffs_dtl{defer_buffs_removed=DefBuffsRemoved__},
                             AddBuffsDtl
                            };
                        success ->
                            % PurgeCount = lib_bo_buff:get_eff_real_value_2(Buff),

                            BuffsRemoved = remove_good_buffs_from_bo(DeferId, PurgeCount),
                            ?ASSERT(util:is_integer_list(BuffsRemoved)),

                            {#purge_buffs_dtl{
                                atter_buffs_removed = [],
                                defer_buffs_removed = BuffsRemoved ++ DefBuffsRemoved__
                                },
                             AddBuffsDtl
                            }
                    end
            end
    end.





remove_good_buffs_from_bo(BoId, RemoveCount) ->
    remove_good_buffs_from_bo__(BoId, RemoveCount, []).


remove_good_buffs_from_bo__(_BoId, 0, AccBuffsRemoved) ->
    AccBuffsRemoved;
remove_good_buffs_from_bo__(BoId, RemoveCount, AccBuffsRemoved) ->
    Bo = get_bo_by_id(BoId),
    case rand_find_good_buff_one(Bo) of
        null ->  % 没有增益buff，提前返回
            AccBuffsRemoved;
        GoodBuff ->
            remove_buff(BoId, GoodBuff),
            BuffNo = lib_bo_buff:get_no(GoodBuff),
            remove_good_buffs_from_bo__(BoId, RemoveCount - 1, [BuffNo | AccBuffsRemoved])
    end.





% %% 查找一个增益buff
% %% @return: null | bo_buff结构体
% find_good_buff_one(Bo) ->
%     BuffList = Bo#battle_obj.buffs,
%     find_good_buff_one__(BuffList).

% find_good_buff_one__([Buff | T]) ->
%     case lib_bo_buff:is_good(Buff) of
%         true ->
%             Buff;
%         false ->
%             find_good_buff_one__(T)
%     end;
% find_good_buff_one__([]) ->
%     null.



%% 随机查找一个增益buff
%% @return: null | bo_buff结构体
rand_find_good_buff_one(Bo) ->
    BuffList = Bo#battle_obj.buffs,
    GoodBuffList = [X || X <- BuffList, lib_bo_buff:is_good(X)],
    case GoodBuffList of
        [] ->
            null;
        _ ->
            list_util:rand_pick_one(GoodBuffList)
    end.










%% 尝试应用受到攻击时增加一定mp的护盾的效果
%% @return: absorb_dam_to_mp_dtl结构体
try_apply_absorb_dam_to_mp_shield_once(DeferId, DamVal) ->
    case DamVal =< 0 of
        true ->
            #absorb_dam_to_mp_dtl{};
        false ->
            Defer = get_bo_by_id(DeferId),
            case find_buff_by_name(Defer, ?BFN_ABSORB_PHY_DAM_TO_MP_SHIELD) of
                null ->
                    #absorb_dam_to_mp_dtl{};
                ShieldBuff ->
                    BuffNo = lib_bo_buff:get_no(ShieldBuff),
                    MpToAdd = lib_bo_buff:get_eff_real_value(ShieldBuff),
                    CurLayer = lib_bo_buff:get_shield_buff_layer(ShieldBuff),
                    ?ASSERT(is_integer(MpToAdd), {MpToAdd, DeferId}),

                    add_mp(DeferId, MpToAdd),

                    % 新的剩余的层数
                    NewLayer = CurLayer - 1,

                    ?TRACE("try_apply_absorb_dam_to_mp_shield_once(), DeferId=~p, MpToAdd=~p, NewLayer=~p~n", [DeferId, MpToAdd, NewLayer]),

                    case NewLayer =< 0 of
                        true ->
                            remove_buff(DeferId, ShieldBuff),
                            #absorb_dam_to_mp_dtl{
                                mp_added = MpToAdd,
                                buffs_removed = [BuffNo],
                                buffs_updated = []
                                };
                        false ->
                            % 更新护盾的层数
                            update_shield_buff_layer(DeferId, ShieldBuff, NewLayer),
                            #absorb_dam_to_mp_dtl{
                                mp_added = MpToAdd,
                                buffs_removed = [],
                                buffs_updated = [BuffNo]
                                }
                    end
            end
    end.




%% 尝试应用一次减轻物理伤害的护盾的效果 用于反弹
%% @return: reduce_dam_dtl结构体
% try_apply_reduce_phy_dam_shield_once(OldDamVal, DeferId) ->
try_apply_reduce_phy_dam_shield_once2(DeferId, DamVal) ->
  % case OldDamVal > 0 of
  %     false ->
  %         #reduce_dam_dtl{}; %%{dam_left = OldDamVal};
  %     true ->

  F = fun(Name,Acc) ->
    case DamVal =< 0 of
      true ->
        Acc;
      false ->
        Defer = get_bo_by_id(DeferId),
        case find_buff_by_name(Defer, Name) of
          null ->
            Acc; %%{dam_left = OldDamVal};
          ShieldBuff ->
            BuffNo = lib_bo_buff:get_no(ShieldBuff),

            CurLayer = lib_bo_buff:get_shield_buff_layer(ShieldBuff),

            NewLayer = CurLayer - 1,

            ?DEBUG_MSG("NewLayer = ~p , BuffNo = ~p",[NewLayer,BuffNo]),

            case NewLayer =< 0 of
              true ->
                % 层数减为0后就移除
                remove_buff(DeferId, ShieldBuff),
                % 触发BUFF到期事件
                handle_buff_expire_events(DeferId,ShieldBuff),

                % ?DEBUG_MSG("[lib_bo] NewLayer=~p, OldDamVal=~p, DamToReduce=~p, DamLeft=~p", [NewLayer, OldDamVal, DamToReduce, DamLeft]),
                ?BT_LOG(io_lib:format("[lib_bo] try_apply_reduce_phy_dam_shield_once(), NewLayer == 0, so remove shield, new buff list: ~w~n", [dbg_get_buff_list__(DeferId)])),
                Acc#reduce_dam_dtl{defer_buffs_removed = [ BuffNo |Acc#reduce_dam_dtl.defer_buffs_removed]};

              false ->
                % 更新层数
                update_shield_buff_layer(DeferId, ShieldBuff, NewLayer),

                % ?DEBUG_MSG("[lib_bo] NewLayer=~p, OldDamVal=~p, DamToReduce=~p, DamLeft=~p", [NewLayer, OldDamVal, DamToReduce, DamLeft]),
                ?BT_LOG(io_lib:format("[lib_bo] try_apply_reduce_phy_dam_shield_once(), NewLayer > 0, new buff list: ~w~n", [dbg_get_buff_list__(DeferId)])),
                Acc#reduce_dam_dtl{defer_buffs_updated = [ BuffNo |Acc#reduce_dam_dtl.defer_buffs_updated]}
            end
        end
    end
      end,
  lists:foldl(F,#reduce_dam_dtl{}, [?BFN_REDUCE_BE_PHY_DAM_SHIELD,?BFN_REDUCE_BE_DAM_SHIELD]).





%% 尝试应用一次减轻物理伤害的护盾的效果
%% @return: reduce_dam_dtl结构体
% try_apply_reduce_phy_dam_shield_once(OldDamVal, DeferId) ->
try_apply_reduce_phy_dam_shield_once(DeferId, _DamVal) ->
  % case OldDamVal > 0 of
  %     false ->
  %         #reduce_dam_dtl{}; %%{dam_left = OldDamVal};
  %     true ->
  F = fun(Name,Acc) ->
    Defer = get_bo_by_id(DeferId),
    case find_buff_by_name(Defer, Name) of
      null ->
        Acc; %%{dam_left = OldDamVal};
      ShieldBuff ->
        BuffNo = lib_bo_buff:get_no(ShieldBuff),

        CurLayer = lib_bo_buff:get_shield_buff_layer(ShieldBuff),

        NewLayer = CurLayer - 1,

        ?DEBUG_MSG("NewLayer = ~p , BuffNo = ~p",[NewLayer,BuffNo]),

        case NewLayer =< 0 of
          true ->
            % 层数减为0后就移除
            remove_buff(DeferId, ShieldBuff),
            % 触发BUFF到期事件
            handle_buff_expire_events(DeferId,ShieldBuff),

            % ?DEBUG_MSG("[lib_bo] NewLayer=~p, OldDamVal=~p, DamToReduce=~p, DamLeft=~p", [NewLayer, OldDamVal, DamToReduce, DamLeft]),
            ?BT_LOG(io_lib:format("[lib_bo] try_apply_reduce_phy_dam_shield_once(), NewLayer == 0, so remove shield, new buff list: ~w~n", [dbg_get_buff_list__(DeferId)])),
            ?DEBUG_MSG("NewwjcLayer2 = ~p , BuffNo = ~p",[NewLayer,BuffNo]),
            Acc#reduce_dam_dtl{defer_buffs_removed = [ BuffNo |Acc#reduce_dam_dtl.defer_buffs_removed]};
          false ->
            % 更新层数
            update_shield_buff_layer(DeferId, ShieldBuff, NewLayer),

            % ?DEBUG_MSG("[lib_bo] NewLayer=~p, OldDamVal=~p, DamToReduce=~p, DamLeft=~p", [NewLayer, OldDamVal, DamToReduce, DamLeft]),
            ?BT_LOG(io_lib:format("[lib_bo] try_apply_reduce_phy_dam_shield_once(), NewLayer > 0, new buff list: ~w~n", [dbg_get_buff_list__(DeferId)])),
            Acc#reduce_dam_dtl{defer_buffs_updated = [ BuffNo |Acc#reduce_dam_dtl.defer_buffs_updated]}
        end

    end
      end,
  lists:foldl(F,#reduce_dam_dtl{}, [?BFN_REDUCE_BE_PHY_DAM_SHIELD,?BFN_REDUCE_BE_DAM_SHIELD]).



%% 尝试应用一次减轻法术伤害的护盾的效果 wjc
%% @return: reduce_dam_dtl结构体
try_apply_reduce_mag_dam_shield_once(DeferId, DamVal) ->
  % case OldDamVal > 0 of
  %     false ->
  %         #reduce_dam_dtl{}; %%{dam_left = OldDamVal};
  %     true ->

  F = fun(Name,Acc) ->
    case DamVal =< 0 of
      true ->
        Acc;
      false ->
        Defer = get_bo_by_id(DeferId),
        case find_buff_by_name(Defer, Name) of
          null ->
            Acc; %%{dam_left = OldDamVal};
          ShieldBuff ->
            BuffNo = lib_bo_buff:get_no(ShieldBuff),

            CurLayer = lib_bo_buff:get_shield_buff_layer(ShieldBuff),

            NewLayer = CurLayer - 1,

            ?DEBUG_MSG("NewLayer = ~p , BuffNo = ~p",[NewLayer,BuffNo]),

            case NewLayer =< 0 of
              true ->
                % 层数减为0后就移除
                remove_buff(DeferId, ShieldBuff),
                % 触发BUFF到期事件
                handle_buff_expire_events(DeferId,ShieldBuff),

                % ?DEBUG_MSG("[lib_bo] NewLayer=~p, OldDamVal=~p, DamToReduce=~p, DamLeft=~p", [NewLayer, OldDamVal, DamToReduce, DamLeft]),
                ?BT_LOG(io_lib:format("[lib_bo] try_apply_reduce_phy_dam_shield_once(), NewLayer == 0, so remove shield, new buff list: ~w~n", [dbg_get_buff_list__(DeferId)])),
                Acc#reduce_dam_dtl{defer_buffs_removed = [ BuffNo |Acc#reduce_dam_dtl.defer_buffs_removed]};

              false ->
                % 更新层数
                update_shield_buff_layer(DeferId, ShieldBuff, NewLayer),

                % ?DEBUG_MSG("[lib_bo] NewLayer=~p, OldDamVal=~p, DamToReduce=~p, DamLeft=~p", [NewLayer, OldDamVal, DamToReduce, DamLeft]),
                ?BT_LOG(io_lib:format("[lib_bo] try_apply_reduce_phy_dam_shield_once(), NewLayer > 0, new buff list: ~w~n", [dbg_get_buff_list__(DeferId)])),
                Acc#reduce_dam_dtl{defer_buffs_updated = [ BuffNo |Acc#reduce_dam_dtl.defer_buffs_updated]}
            end
        end
    end
      end,
  lists:foldl(F,#reduce_dam_dtl{}, [?BFN_REDUCE_BE_MAG_DAM_SHIELD,?BFN_REDUCE_BE_DAM_SHIELD]).



    % end.


% %% 计算总的吸血比率
% calc_total_absorb_hp_rate(Bo) ->
%     case find_buff_by_name(Bo, ?BFN_SHIXUE_MINGWANG) of
%         null ->
%             0;
%         Buff ->
%             % 从对应的buff模板的参数获取
%             {rate, Rate} = lib_bo_buff:get_buff_tpl_para(Buff),
%             Rate
%     end.



%% 尝试应用吸血效果
%% @return: 吸血值
try_apply_absorb_hp(AtterId, _DeferId, DamVal) ->
    case DamVal =< 0 of
        true ->
            0;
        false ->
            Atter = get_bo_by_id(AtterId),
            % case calc_total_absorb_hp_rate(Atter) of
            %     0 ->
            %         skip;
            %     AbsorbRate ->
            %         HpToAdd = util:ceil(DamVal * AbsorbRate),
            %         add_hp(AtterId, HpToAdd)
            % end

            AbsorbHpCoef = get_absorb_hp_coef(Atter),
%%            % 乘以治疗减益
%%            BeHealEffCoef = lib_bo:get_be_heal_eff_coef(Atter),
            HpToAbsorb = util:ceil(DamVal * AbsorbHpCoef ),

            case HpToAbsorb > 0 of
                true ->
                    add_hp(AtterId, HpToAbsorb);
                false ->
                    skip
            end,

            HpToAbsorb
    end.




%% 尝试应用不死效果, 参数Bo应是当前最新的
%% @return: apply_undead_eff_dtl结构体
try_apply_undead_eff(Bo) ->
    BoId = get_id(Bo),

    case is_dead(Bo) of
        false ->
            #apply_undead_eff_dtl{};
        true ->
            case find_buff_by_name(Bo, ?BFN_UNDEAD_BUT_HEAL_HP_SHIELD) of
                null ->
                    case find_buff_by_name(Bo, ?BFN_UNDEAD) of
                        null ->
                            #apply_undead_eff_dtl{};
                        UndeadBuff ->
                            Proba = lib_bo_buff:get_proba_of_undead_buff(UndeadBuff),
                            % TODO: 计算实际的概率
                            % Proba2 = lib_bt_calc:calc_real_proba(),

                            case lib_bt_util:test_proba(Proba) of
                                fail ->
                                    #apply_undead_eff_dtl{};
                                success ->
                                    ?BT_LOG(io_lib:format("apply undead buff success!! Proba=~p, BoId=~p~n", [Proba, BoId])),
                                    add_hp(BoId, 1),   % 保留1点血
                                    #apply_undead_eff_dtl{}
                            end
                    end;
                Buff ->
                    Proba = lib_bo_buff:get_proba_of_undead_but_heal_hp_shield(Buff),
                    % TODO: 计算实际的概率
                    % Proba2 = lib_bt_calc:calc_real_proba(),

                    case lib_bt_util:test_proba(Proba) of
                        fail ->
                            #apply_undead_eff_dtl{};
                        success ->
                            BuffNo = lib_bo_buff:get_no(Buff),

                            EffRealVal = lib_bo_buff:get_eff_real_value(Buff),
                            ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, Buff}),

                            HpToAdd = max(EffRealVal, 1),  % 矫正：至少加1点血，以保证不死
                            add_hp(BoId, HpToAdd),
                            ?ASSERT(is_living(get_bo_by_id(BoId)), Bo),

                            CurLayer = lib_bo_buff:get_shield_buff_layer(Buff),
                            NewLayer = CurLayer - 1,
                            case NewLayer =< 0 of
                                true ->
                                    remove_buff(BoId, Buff),
                                    #apply_undead_eff_dtl{
                                        buffs_removed = [BuffNo],
                                        buffs_updated = []
                                        };
                                false ->
                                    update_shield_buff_layer(BoId, Buff, NewLayer),
                                    #apply_undead_eff_dtl{
                                        buffs_removed = [],
                                        buffs_updated = [BuffNo]
                                        }
                            end
                    end
            end
    end.






%% 更新护盾的剩余层数
update_shield_buff_layer(BoId, OldShieldBuff, NewLayer) ->
    ?ASSERT(dbg_has_buff__(BoId, OldShieldBuff)),

    % remove_buff(BoId, OldShieldBuff),

    % {_OldLayer, RecudeDamRate} = lib_bo_buff:get_eff_real_value_2(OldShieldBuff),

    % NewShieldBuff = OldShieldBuff#bo_buff{
    %                         eff_real_val = {NewLayer, RecudeDamRate}
    %                         },

    NewShieldBuff = lib_bo_buff:set_shield_buff_layer(OldShieldBuff, NewLayer),

    update_buff(BoId, NewShieldBuff).





dbg_has_buff__(BoId, Buff) ->
    Bo = get_bo_by_id(BoId),
    BuffList = Bo#battle_obj.buffs,
    lists:member(Buff, BuffList).

dbg_get_buff_list__(BoId) ->
    Bo = get_bo_by_id(BoId),
    Bo#battle_obj.buffs.





%% 是否处于冰冻状态？
is_frozen(Bo) ->
  case lib_bo:get_cur_skill_cfg(Bo) of
    null ->
      find_buff_by_name(Bo, ?BFN_FROZEN) /= null;
    SkillCfgData ->
      case find_buff_by_name(Bo, ?BFN_FROZEN) of
        null ->
          false;
        _ ->
          case lib_bo:can_use_skill(Bo, SkillCfgData) of
            true ->   not lists:member(?BFN_FROZEN ,SkillCfgData#skl_cfg.special_state_can_use);
            {false, _Reason} -> true
          end
      end
  end.


%% 是否处于昏睡状态？
is_trance(Bo) ->
  case lib_bo:get_cur_skill_cfg(Bo) of
    null ->
      find_buff_by_name(Bo, ?BFN_TRANCE) /= null;
    SkillCfgData ->
      case find_buff_by_name(Bo, ?BFN_TRANCE) of
        null ->
          false;
        _ ->
          case lib_bo:can_use_skill(Bo, SkillCfgData) of
            true ->   not lists:member(?BFN_TRANCE ,SkillCfgData#skl_cfg.special_state_can_use);
            {false, _Reason} -> true
          end
      end
  end.



%% 是否拥有复活BUFF
has_reborn_buff(Bo) ->
    find_buff_by_name(Bo, ?BFN_REVIVE_ADD_DAM) /= null orelse  find_buff_by_name(Bo, ?BFN_REVEVI_ONE_ROUND) /= null  .


%% 是否由于昏睡而导致无法行动？（昏睡状态下只允许使用物品和召唤宠物）
cannot_act_by_trance(Bo) ->
    CmdType = get_cmd_type(Bo),
    is_trance(Bo)
    andalso (CmdType /= ?CMD_T_USE_GOODS)
    andalso (CmdType /= ?CMD_T_SUMMON_PARTNER).



%% 是否处于混乱状态？
is_chaos(Bo) ->
  case lib_bo:get_cur_skill_cfg(Bo) of
    null ->
      find_buff_by_name(Bo, ?BFN_CHAOS) /= null;
    SkillCfgData ->
      case find_buff_by_name(Bo, ?BFN_CHAOS) of
        null ->
          false;
        _ ->
          case lib_bo:can_use_skill(Bo, SkillCfgData) of
            true ->   not lists:member(?BFN_CHAOS ,SkillCfgData#skl_cfg.special_state_can_use);
            {false, _Reason} -> true
          end

      end

  end.


%% 是否处于沉默状态？
is_silence(Bo) ->
  case lib_bo:get_cur_skill_cfg(Bo) of
    null ->
  find_buff_by_name(Bo, ?BFN_SILENCE) /= null;
    SkillCfgData ->
      case find_buff_by_name(Bo, ?BFN_SILENCE) of
        null ->
          false;
        _ ->
          case lib_bo:can_use_skill(Bo, SkillCfgData) of
            true ->   not lists:member(?BFN_SILENCE ,SkillCfgData#skl_cfg.special_state_can_use);
            {false, _Reason} -> true
          end
      end
  end.


%% 是否处于任意一种控制状态（冰冻|昏睡|混乱|冷却|蓄力）？
is_under_control(Bo) ->
    is_frozen(Bo) orelse is_trance(Bo) orelse is_chaos(Bo)
    orelse is_cding(Bo) orelse is_xuliing(Bo) .

%% 是否处于任意一种强控制状态（冰冻|混乱|冷却|蓄力）？
is_under_strong_control(Bo) ->
    is_frozen(Bo) orelse is_chaos(Bo)
    orelse is_cding(Bo) orelse is_xuliing(Bo) .



%% 是否免疫伤害？
is_immu_damage(Bo) ->
    find_buff_by_name(Bo, ?BFN_IMMU_DAMAGE) /= null.




%% 是否强行攻击（只能执行攻击而不能做其他操作）？
is_force_attack(Bo) ->
    TmpStatus = Bo#battle_obj.tmp_status,
    TmpStatus#bo_tmp_stat.force_attack
    orelse is_force_auto_attack(Bo).  %%TmpStatus#bo_tmp_stat.force_auto_attack.


%% bo是否正在冷却中？
is_cding(Bo) ->
  case lib_bo:get_cur_skill_cfg(Bo) of
    null ->
      find_buff_by_name(Bo, ?BFN_CD) /= null;
    SkillCfgData ->
      case find_buff_by_name(Bo, ?BFN_CD) of
        null ->
          false;
        _ ->
          case lib_bo:can_use_skill(Bo, SkillCfgData) of
            true ->   not lists:member(?BFN_CD ,SkillCfgData#skl_cfg.special_state_can_use);
            {false, _Reason} -> true
          end
      end

  end.


%% 是否正在蓄力中？
is_xuliing(Bo) ->
    % case find_buff_by_name(Bo, ?BFN_XULI) of
    %     null ->
    %         false;
    %     XuliBuff ->
    %         % 蓄力类buff，为配合客户端的表现需要，到期后延迟一回合才删除，故这里加如下判断
    %         not lib_bo_buff:is_expired(XuliBuff, get_cur_round())
    % end.

    find_buff_by_name(Bo, ?BFN_XULI) /= null.


%% 是否灵魂被禁锢？
is_soul_shackled(Bo) ->
    find_buff_by_name(Bo, ?BFN_SOUL_SHACKLE) /= null.

%% 是否被封印被动？
is_revive_forbid(Bo) ->
    find_buff_by_name(Bo, ?REVIVE_FORBID) /= null.



%% 是否处于隐身状态？
is_invisible(Bo) ->
    (find_buff_by_name(Bo, ?BFN_INVISIBLE) /= null)
    orelse (find_passi_eff_by_name(Bo, ?EN_ADD_INVISIBLE_STATUS) /= null).


%% 是否处于无敌状态?
is_invincible(Bo) ->
    (find_buff_by_name(Bo, ?BFN_INVINCIBLE) /= null) .

%% 是否处于封印增强状态
is_avatar(Bo) ->
    (find_buff_by_name(Bo, ?BFN_AVATAR) /= null).

%% 是否处于封印增强状态
is_immu_control(Bo) ->
    (find_buff_by_name(Bo, ?BFN_IMMUNITY_CONTROL) /= null).



%% 是否是满额伤害
is_dam_full(Bo) ->
    (find_passi_eff_by_name(Bo, ?EN_DAM_IS_FULL) /= null).


%% 获取隐身状态的到期回合
get_invisible_expire_round(Bo) ->
    Round1 = case find_buff_by_name(Bo, ?BFN_INVISIBLE) of
                null ->
                    0;
                Buff ->
                    lib_bo_buff:get_expire_round(Buff)
            end,
    Round2 = case find_passi_eff_by_name(Bo, ?EN_ADD_INVISIBLE_STATUS) of
                null ->
                    0;
                Eff ->
                    Eff#bo_peff.expire_round
            end,

    max(Round1, Round2).






%% 是否具备反隐身能力？
can_anti_invisible(Bo) ->
    % case find_buff_by_name(Bo, ?BFN_ANTI_INVISIBLE) of
    %     null ->
    %         false;
    %     _Buff ->
    %         true
    % end.
    (find_buff_by_name(Bo, ?BFN_ANTI_INVISIBLE) /= null)
    orelse (find_buff_by_name(Bo, ?BFN_ANTI_INVISIBLE_AND_ADD_PHY_MAG_ATT) /= null)
    orelse (find_passi_eff_by_name(Bo, ?EN_ADD_ANTI_INVISIBLE_STATUS) /= null).


%% 是否具备驱鬼能力？
can_qugui(Bo) ->
    find_passi_eff_by_name(Bo, ?EN_ADD_QUGUI_STATUS) /= null.

%% 是否具备防御“反转伤害”能力？
can_prevent_inverse_dam(Bo) ->
    find_passi_eff_by_name(Bo, ?EN_ADD_PREVENT_INVERSE_DAM_STATUS) /= null.


%% 是否无法被治疗（免疫治疗）？
cannot_be_heal(Bo) ->
    is_frozen(Bo) orelse (find_buff_by_name(Bo, ?BFN_CANNOT_BE_HEAL) /= null).




get_die_status(Bo) ->
    Bo#battle_obj.die_status.

set_die_status(BoId, DieStatus) ->
    Bo = get_bo_by_id(BoId),
    Bo2 = Bo#battle_obj{die_status = DieStatus},
    update_bo(Bo2),
    void.

%% 重置死亡状态为未死亡
reset_die_status(BoId) ->
    set_die_status(BoId, ?DIE_STATUS_LIVING).



find_reborn_prep_status_eff(Bo) ->
    find_passi_eff_by_name(Bo, ?EN_ADD_REBORN_PREP_STATUS).

%% 是否有重生预备状态？
has_reborn_prep_status(Bo) ->
    find_passi_eff_by_name(Bo, ?EN_ADD_REBORN_PREP_STATUS) /= null.

% 增加重生次数
add_reborn_count(BoId) ->
    Bo = get_bo_by_id(BoId),
    ?ASSERT(is_record(Bo, battle_obj), Bo),
    Bo2 = Bo#battle_obj{reborn_count = get_reborn_count(Bo) + 1},
    update_bo(Bo2),
    void.

set_reborn_count(BoId,Count) ->
    Bo = get_bo_by_id(BoId),
    ?ASSERT(is_record(Bo, battle_obj), Bo),
    Bo2 = Bo#battle_obj{reborn_count = Count},
    update_bo(Bo2),
    void.

% 是否已经是重生次数最大次数
is_max_reborn_count(Bo) ->
    get_reborn_count(Bo) >= ?MAX_REBORN_COUNT.

get_reborn_count(Bo) ->
    Bo#battle_obj.reborn_count.


%% 是否有鬼魂预备状态？
has_ghost_prep_status(Bo) ->
    Bo#battle_obj.has_ghost_prep_status
    orelse (find_passi_eff_by_name(Bo, ?EN_ADD_GHOST_PREP_STATUS) /= null).

%% 是否有倒地预备状态？  duanshihe 添加副宠都可以留场
has_fallen_prep_status(Bo) ->
    is_player(Bo)  % 玩家固定有
    orelse Bo#battle_obj.has_fallen_prep_status orelse lib_bt_comm:is_deputy_partner(Bo).



%% 是否处于鬼魂状态？
in_ghost_status(Bo) ->
    get_die_status(Bo) == ?DIE_STATUS_GHOST.


%% 是否处于倒地状态？
in_fallen_status(Bo) ->
    get_die_status(Bo) == ?DIE_STATUS_FALLEN.



% %% 标记为处于鬼魂状态（针对怪物）
% mark_ghost_status_flag(BoId) when is_integer(BoId) ->
%     Bo = get_bo_by_id(BoId),
%     ?ASSERT(Bo /= null, BoId),
%     mark_ghost_status_flag(Bo);
% mark_ghost_status_flag(Bo_Latest) when is_record(Bo_Latest, battle_obj) ->
%     Bo_Latest2 = Bo_Latest#battle_obj{in_ghost_status = true},
%     update_bo(Bo_Latest2),
%     void.


% %% 清除处于鬼魂状态的标记
% clear_ghost_status_flag(BoId) when is_integer(BoId) ->
%     Bo = get_bo_by_id(BoId),
%     ?ASSERT(Bo /= null, BoId),
%     clear_ghost_status_flag(Bo);
% clear_ghost_status_flag(Bo_Latest) when is_record(Bo_Latest, battle_obj) ->
%     Bo_Latest2 = Bo_Latest#battle_obj{in_ghost_status = false},
%     update_bo(Bo_Latest2),
%     void.






% %% 标记为处于倒地状态
% mark_fallen_status_flag(BoId) when is_integer(BoId) ->
%     Bo = get_bo_by_id(BoId),
%     ?ASSERT(Bo /= null, BoId),
%     mark_fallen_status_flag(Bo);
% mark_fallen_status_flag(Bo_Latest) when is_record(Bo_Latest, battle_obj) ->
%     Bo_Latest2 = Bo_Latest#battle_obj{in_fallen_status = true},
%     update_bo(Bo_Latest2),
%     void.


% %% 清除处于倒地状态的标记
% clear_fallen_status_flag(BoId) when is_integer(BoId) ->
%     Bo = get_bo_by_id(BoId),
%     ?ASSERT(Bo /= null, BoId),
%     clear_fallen_status_flag(Bo);
% clear_fallen_status_flag(Bo_Latest) when is_record(Bo_Latest, battle_obj) ->
%     Bo_Latest2 = Bo_Latest#battle_obj{in_fallen_status = false},
%     update_bo(Bo_Latest2),
%     void.






    % clear_fallen_status_flag(BoId),
    % clear_ghost_status_flag(BoId).












% %% 计算物防的加成
% calc_phy_def_add(Bo) ->
%     case is_using_defend(Bo) of
%         true ->
%             100;  % TODO： 临时写死加100防
%         false ->
%             0
%     end.



% %% 计算bo执行物理伤害的加成
% calc_do_phy_dam_enhance(Bo) ->
%     case find_buff_by_name(Bo, ?BFN_DO_PHY_DAM_ENHANCE) of
%         null ->
%             0;
%         Buff ->
%             DoDamEnhance = lib_bo_buff:get_eff_real_value(Buff), %%lib_bo_buff:get_eff_para(Buff),
%             ?ASSERT(is_integer(DoDamEnhance), {DoDamEnhance, Buff}),
%             % ?ASSERT(util:is_rate())
%             DoDamEnhance
%     end.


% %% 计算bo受物理伤害的加成
% calc_be_phy_dam_enhance(Bo) ->
%     case find_buff_by_name(Bo, ?BFN_BE_PHY_DAM_ENHANCE) of
%         null ->
%             0;
%         Buff ->
%             BeDamEnhance = lib_bo_buff:get_eff_real_value(Buff),  %%get_eff_para(Buff),
%             ?ASSERT(is_integer(BeDamEnhance), {BeDamEnhance, Buff}),
%             % ?ASSERT(util:is_rate())
%             BeDamEnhance
%     end.



%% TODO here
calc_do_mag_dam_enhance(_Atter) ->
    0.

%% TODO here
calc_be_mag_dam_enhance(_Defer) ->
    0.


% %% 计算受到法术伤害增加的百分比
% calc_be_mag_dam_enhance_rate(Defer) ->
%     case find_buff_by_name(Defer, ?BFN_BE_MAG_DAM_ENHANCE_BY_RATE) of
%         null ->
%             0;
%         Buff ->
%             % TODO: 改为调用get_eff_real_value()
%             Rate = lib_bo_buff:get_eff_para(Buff),
%             % ?ASSERT(util:is_rate())
%             Rate
%     end.




%% 查找bo身上的指定效果名的buff，返回第一个匹配的buff，否则返回null
%% @return: null | bo_buff结构体
find_buff_by_name(Bo, BuffName) ->
    find_buff_by_name__(Bo#battle_obj.buffs, BuffName).



find_buff_by_name__([Buff | T], BuffName) ->
    case lib_bo_buff:get_name(Buff) == BuffName of
        true -> Buff;
        false -> find_buff_by_name__(T, BuffName)
    end;
find_buff_by_name__([], _BuffName) ->
    null.




%% 是否有指定编号的buff？
has_spec_no_buff(Bo, BuffNo) ->
    find_buff_by_no(Bo, BuffNo) /= null.

%% 指定buff是否有足够多的层数
has_buff_lap(Bo, BuffNo,Lap) ->
    case find_buff_by_no__(Bo#battle_obj.buffs, BuffNo) of
        null -> false;
        Buff when is_record(Buff,bo_buff) -> lib_bo_buff:get_cur_overlap(Bo,Buff) >= Lap;
        _ -> false
    end.

%% 依据编号查找buff，用列表形式返回所有匹配的buff，否则返回[]
find_buff_list_by_no(Bo, BuffNo) ->
    [Buff || Buff<-Bo#battle_obj.buffs, Buff#bo_buff.buff_no==BuffNo].


%% 依据编号查找buff，返回第一个匹配的buff，否则返回null
find_buff_by_no(Bo, BuffNo) ->
    find_buff_by_no__(Bo#battle_obj.buffs, BuffNo).

find_buff_by_no__([Buff | T], BuffNo) ->
    case lib_bo_buff:get_no(Buff) == BuffNo of
        true -> Buff;
        false -> find_buff_by_no__(T, BuffNo)
    end;
find_buff_by_no__([], _BuffNo) ->
    null.


%% 依据编号查找buff，如果有多个匹配的buff，则随机返回其中一个，如果没有匹配的buff，则返回null
rand_find_buff_by_no(Bo, BuffNo) ->
    L = [X || X <- Bo#battle_obj.buffs, lib_bo_buff:get_no(X) == BuffNo],
    case L of
        [] ->
            null;
        _ ->
            list_util:rand_pick_one(L)
    end.


dbg_find_all_buff_by_no(Bo, BuffNo) ->
    [X || X <- Bo#battle_obj.buffs, lib_bo_buff:get_no(X) == BuffNo].




%% 是否有指定类别的buff？
has_spec_category_buff(Bo, Category) ->
    find_buff_by_category(Bo, Category) /= null.


%% 是否有指定效果类型（增益|减益|中性）的buff？
has_spec_eff_type_buff(Bo, EffType) ->
    ?ASSERT(EffType == good orelse EffType == bad orelse EffType == neutral, EffType),
    find_buff_by_eff_type(Bo, EffType) /= null.



%% 依据类别查找buff，用列表形式返回所有匹配的buff，否则返回[]
find_buff_list_by_category(Bo, Category) ->
    [Buff || Buff<-Bo#battle_obj.buffs, lib_bo_buff:get_category(Buff)==Category].
%% 依据类别查找buff，返回第一个匹配的buff，否则返回null
find_buff_by_category(Bo, Category) ->
    find_buff_by_category__(Bo#battle_obj.buffs, Category).

find_buff_by_category__([Buff | T], Category) ->
    case lib_bo_buff:get_category(Buff) == Category of
        true -> Buff;
        false -> find_buff_by_category__(T, Category)
    end;
find_buff_by_category__([], _Category) ->
    null.


%% 依据效果类型查找buff，用列表形式返回所有匹配的buff，否则返回[]
find_buff_list_by_eff_type(Bo, EffType) ->
  [Buff || Buff<-Bo#battle_obj.buffs, lib_bo_buff:get_eff_type(Buff)==EffType].

%%根据buff名查找
find_buff_list_by_buff_name(Bo, BuffName) ->
  [Buff || Buff<-Bo#battle_obj.buffs, lib_bo_buff:get_name(Buff)==BuffName].

%% 依据效果类型查找buff，返回第一个匹配的buff，否则返回null
find_buff_by_eff_type(Bo, EffType) ->
   find_buff_by_eff_type__(Bo#battle_obj.buffs, EffType).

find_buff_by_eff_type__([Buff | T], EffType) ->
   case lib_bo_buff:get_eff_type(Buff) == EffType of
       true -> Buff;
       false -> find_buff_by_eff_type__(T, EffType)
   end;
find_buff_by_eff_type__([], _EffType) ->
   null.




%% 查找bo身上的冥王buff（幽影冥王|嗜血冥王|大力冥王）， 返回对应的buff列表，若没有，则返回空列表
find_mingwang_buffs(Bo) ->
    [Buff || Buff <- Bo#battle_obj.buffs, lib_bo_buff:get_name(Buff) == ?BFN_YOUYING_MINGWANG
                                          orelse lib_bo_buff:get_name(Buff) == ?BFN_SHIXUE_MINGWANG
                                          orelse lib_bo_buff:get_name(Buff) == ?BFN_DALI_MINGWANG
                                          ].




%% 查找bo身上的指定效果名的buff，返回第一个匹配的buff，否则返回null
%% @return: null | #bo_peff{}
find_passi_eff_by_name(Bo, EffName) ->
    find_passi_eff_by_name__(Bo#battle_obj.passi_effs, EffName).

find_passi_eff_by_name__([Eff | T], EffName) ->
    case Eff#bo_peff.eff_name == EffName of
        true -> Eff;
        false -> find_passi_eff_by_name__(T, EffName)
    end;
find_passi_eff_by_name__([], _EffName) ->
    null.



%% 查找bo身上的指定效果名的所有buff
%% @return: [] | #bo_peff{}列表
find_passi_eff_by_name_all(Bo, EffName) ->
    L = Bo#battle_obj.passi_effs,
    [X || X <- L, X#bo_peff.eff_name == EffName].




%% 是否有HOT类buff？
% has_HOT_buff(Bo) ->
%     find_buff_by_name(Bo, ?BFN_HOT) /= null.


% %% 是否有DOT类buff？
% has_DOT_buff(Bo) ->
%     find_buff_by_name(Bo, ?BFN_DOT) /= null.




% find_all_buffs_by_name(Bo, BuffName) ->
%   BuffList = Bo#battle_obj.buffs,
%   [Buff || Buff <- BuffList, lib_bo_buff:get_name(Buff) == BuffName].


get_cur_att_target(Bo) ->
    Bo#battle_obj.cur_att_target.


set_cur_att_target(AtterId, TargetBoId) ->
    Atter = get_bo_by_id(AtterId),
    Atter2 = Atter#battle_obj{cur_att_target = TargetBoId},
    update_bo(Atter2),
    Atter2.



get_cur_bhv(Bo) ->
    Bo#battle_obj.cur_bhv.


set_cur_bhv(BoId, NewBhv) ->
    Bo = get_bo_by_id(BoId),
    Bo2 = Bo#battle_obj{cur_bhv = NewBhv},
    update_bo(Bo2),
    void.


%% 获取累计已召唤宠物的次数
get_acc_summon_par_times(Bo) ->
    Bo#battle_obj.acc_summon_par_times.

%% 递增累计已召唤宠物的次数
incr_acc_summon_par_times(BoId) ->
    Bo = get_bo_by_id(BoId),
    NewTimes = get_acc_summon_par_times(Bo) + 1,
    Bo2 = Bo#battle_obj{acc_summon_par_times = NewTimes},
    update_bo(Bo2),
    void.



%% 确定玩家的主宠的站位
decide_my_main_partner_pos(PlayerBo) ->
    ?ASSERT(is_player(PlayerBo)),
    PlayerPos = get_pos(PlayerBo),
    % 主宠是站在所属玩家的正前方
    case PlayerPos of
        6 ->  1;
        7 ->  2;
        8 ->  3;
        9 ->  4;
        10 -> 5
    end.



% on_event(BoId, Event) ->
%     case Event of
%         % new_round_begin ->  % 新回合开始
%         %     on_event__(BoId, new_round_begin);
%         be_phy_dam -> % 受到物理伤害
%             on_event__(BoId, be_phy_dam);
%         dodge_success -> % 闪避成功
%             on_event__(BoId, dodge_success)
%     end.




% on_event__(BoId, new_round_begin) ->
%     todo_here.




on_event(BoId, be_phy_dam) ->
    on_event__(BoId, be_dam);

on_event(BoId, be_mag_dam) ->
    on_event__(BoId, be_dam);


on_event(_BoId, dodge_success) ->
    todo_here;

on_event(_BoId, _Event) ->
    ?ASSERT(false, _Event),
    void.



%% 受击时解除昏睡状态
on_event__(BoId, be_dam) ->
    Bo = get_bo_by_id(BoId),
    case is_trance(Bo) of
        false ->
            #on_be_dam_dtl{};
        true ->
            case remove_trance_buff(Bo) of
                do_nothing ->
                    #on_be_dam_dtl{};
                {ok, BuffsRemoved} ->
                    ?ASSERT(util:is_integer_list(BuffsRemoved)),
                    #on_be_dam_dtl{
                        buffs_removed = BuffsRemoved
                        }
            end
    end.



on_event(Atter, phy_crit_success, [DeferId]) ->
    % ?BT_LOG(io_lib:format("on_event(), phy_crit_success, AtterId:~p, DeferId:~p~n", [get_id(Atter), DeferId])),
    on_event(Atter, phy_att_hit_success, [DeferId]);

on_event(Atter, mag_crit_success, [DeferId]) ->
    % ?BT_LOG(io_lib:format("on_event(), mag_crit_success, AtterId:~p, DeferId:~p~n", [get_id(Atter), DeferId])),
    on_event(Atter, mag_att_hit_success, [DeferId]);

%% 注意：Atter和Defer均有可能已经死亡并且被清除！！！
on_event(Atter, phy_att_hit_success, [DeferId]) ->
    % 如果目标是队友则是战术攻击队友
    %?DEBUG_MSG("DeferId = ~p",[DeferId]),
    Defer = get_bo_by_id(DeferId),

    %?DEBUG_MSG("Defer = ~p",[Defer]),
    %?DEBUG_MSG("Atter = ~p",[Atter]),

    % 避免连击附加BUFF类技能对队友放的时候触发
    IsAlli =
        if Defer == null ->
            true;
        true ->
            lib_bo:get_side(Defer) =:= lib_bo:get_side(Atter)
        end,

    IsChaos = lib_bo:is_chaos(Atter),

    IsSilence = is_silence(Atter),

  % 如果处于混乱状态则不管那么多了
    if
        IsAlli =:= true andalso not IsChaos andalso not IsSilence ->
            #on_hit_success_dtl{};
        true ->
            EffList1 = find_passi_eff_by_name_all(Atter, ?EN_ADD_BUFF_ON_PHY_ATT_HIT),
            DtlList1 = [try_apply_passi_eff_add_buff_on_hit(Atter, DeferId, X) || X <- EffList1],

            EffList2 = find_passi_eff_by_name_all(Atter, ?EN_ADD_BUFF_ON_ATT_HIT),
            % ?BT_LOG(io_lib:format("on_event(), phy_att_hit_success, AtterId:~p, DeferId:~p, EffList2:~p", [get_id(Atter), DeferId, EffList2])),
            DtlList2 = [try_apply_passi_eff_add_buff_on_hit(Atter, DeferId, X) || X <- EffList2],

            DtlList3 = [try_apply_passi_eff_on_hit(Atter, DeferId, ?EN_REDUCE_ANGER_ON_PHY_ATT_HIT)],

            DtlList4 = [try_apply_passi_eff_on_hit(Atter, DeferId, ?EN_REDUCE_HP_ON_PHY_ATT_HIT_BASE_TARGET_MG_LIM)],

            DtlList5 = [try_apply_passi_eff_on_hit(Atter, DeferId, ?EN_REDUCE_HP_ON_PHY_ATT_HIT_BASE_MG)],

            case get_bo_by_id(DeferId) of
	    		Defer when is_record(Defer,battle_obj) ->
				    % ?DEBUG_MSG("DeferId = ~p List = ~p",[DeferId,Defer#battle_obj.passi_effs]),

				    % 被法术攻击命中目标附加效果
				    BeEffList1 = find_passi_eff_by_name_all(Defer, ?EN_ADD_BUFF_ON_BE_PHY_ATT_HIT),
				    % 被法术攻击命中目标附加效果战报

				    F = fun(Eff, Acc) ->
				    	try_apply_passi_eff_add_buff_on_be_hit(Defer, Atter, Eff) ++ Acc
				    end,

				    BeDtlList1 = lists:foldl(F,[#on_hit_success_dtl{}], BeEffList1),

				    % ?DEBUG_MSG("BeEffList1 = ~p,BeDtlList1 = ~p",[BeEffList1,BeDtlList1]),

				    % 被任何攻击命中目标附加效果
				    BeEffList2 = find_passi_eff_by_name_all(Defer, ?EN_ADD_BUFF_ON_BE_ATT_HIT),
				    % 被任何攻击命中目标附加效果战报
				    BeDtlList2 = lists:foldl(F,[#on_hit_success_dtl{}], BeEffList2),

				    sum_on_hit_success_dtl(DtlList1 ++ DtlList2 ++ DtlList3 ++ DtlList4 ++ DtlList5 ++ BeDtlList1 ++ BeDtlList2);
				_ ->
					sum_on_hit_success_dtl(DtlList1 ++ DtlList2 ++ DtlList3 ++ DtlList4 ++ DtlList5)
			end
    end;

on_event(Atter, mag_att_hit_success, [DeferId]) ->
	% 魔法攻击命中附加效果
    EffList1 = find_passi_eff_by_name_all(Atter, ?EN_ADD_BUFF_ON_MAG_ATT_HIT),
    % 魔法攻击命中附加效果战报
    DtlList1 = [try_apply_passi_eff_add_buff_on_hit(Atter, DeferId, X) || X <- EffList1],

    % 所有攻击命中附加效果
    EffList2 = find_passi_eff_by_name_all(Atter, ?EN_ADD_BUFF_ON_ATT_HIT),
    % 所有攻击命中附加效果战报
    DtlList2 = [try_apply_passi_eff_add_buff_on_hit(Atter, DeferId, X) || X <- EffList2],

    % 法术攻击减怒气
    DtlList3 = [try_apply_passi_eff_on_hit(Atter, DeferId, ?EN_REDUCE_ANGER_ON_MAG_ATT_HIT)],
    % 基于自己的法力值给予目标伤害
    DtlList4 = [try_apply_passi_eff_on_hit(Atter, DeferId, ?EN_REDUCE_HP_ON_MAG_ATT_HIT_BASE_MG)],

    % 被攻击的触发
    case get_bo_by_id(DeferId) of
    	Defer when is_record(Defer,battle_obj) ->
		    ?DEBUG_MSG("DeferId = ~p List = ~p",[DeferId,Defer#battle_obj.passi_effs]),

		    % 被法术攻击命中目标附加效果
		    BeEffList1 = find_passi_eff_by_name_all(Defer, ?EN_ADD_BUFF_ON_BE_MAG_ATT_HIT),
		    % 被法术攻击命中目标附加效果战报
		    % BeDtlList1 = [try_apply_passi_eff_add_buff_on_be_hit(Defer, Atter, X) || X <- BeEffList1],

		    F = fun(Eff, Acc) ->
		    	try_apply_passi_eff_add_buff_on_be_hit(Defer, Atter, Eff) ++ Acc
		    end,

		    BeDtlList1 = lists:foldl(F,[#on_hit_success_dtl{}], BeEffList1),

		    ?DEBUG_MSG("BeEffList1 = ~p,BeDtlList1 = ~p",[BeEffList1,BeDtlList1]),

		    % 被任何攻击命中目标附加效果
		    BeEffList2 = find_passi_eff_by_name_all(Defer, ?EN_ADD_BUFF_ON_BE_ATT_HIT),
		    % 被任何攻击命中目标附加效果战报
		    %BeDtlList2 = [try_apply_passi_eff_add_buff_on_be_hit(Defer, Atter, X) || X <- BeEffList2],
		    BeDtlList2 = lists:foldl(F,[#on_hit_success_dtl{}], BeEffList2),

		    sum_on_hit_success_dtl(DtlList1 ++ DtlList2 ++ DtlList3 ++ DtlList4 ++ BeDtlList1 ++ BeDtlList2);
		_ ->
			sum_on_hit_success_dtl(DtlList1 ++ DtlList2 ++ DtlList3 ++ DtlList4)
	end.

%%修改为效果对象根据筛选规则来 2019.9.18 wjc 这个攻击者就是释放技能的
try_apply_passi_eff_add_buff_on_condition(Atter,DeferId, Eff) ->
  AtterId = get_id(Atter),
  BuffNo = Eff#bo_peff.buff_no,
  TarBoIdList =
    case Eff#bo_peff.op ==3 of
      true ->
        %按照规则筛选目标
        AllSideBo =lib_bt_comm:get_bo_id_list((get_side(Atter))) ++ lib_bt_comm:get_other_bo_id_list(get_side(Atter)),
        % 先筛选 --增加过滤无敌状态的单位
        RuleList_Filter = lists:merge(Eff#bo_peff.rules_filter_target,[?RDT_NOT_INVINCIBLE]),
        %%这个eff传过去并没什么用
        BoIdList_Filtered = lib_bt_skill:filter_skill_eff_targets__(Atter, Eff, RuleList_Filter, AllSideBo),

        % ?DEBUG_MSG("decide_skill_eff_targets(), BoIdList_Filtered: ~w", [BoIdList_Filtered]),

        % 然后对筛选出的目标做排序
        RuleList_Sort = Eff#bo_peff.rules_sort_target,
        BoIdList_Sorted = lib_bt_skill:sort_skill_eff_targets__(Atter, Eff, RuleList_Sort, BoIdList_Filtered),

        % ?DEBUG_MSG("decide_skill_eff_targets(), BoIdList_Sorted: ~w", [BoIdList_Sorted]),
        % 处理排序规则时可能做了拆分， 故要flatten一下
        lists:flatten(BoIdList_Sorted);
      false ->

        case Eff#bo_peff.target_for_add_buff of
          myself ->
            [AtterId];
          atter ->
            [DeferId];
          all_enemy ->
            lib_bt_comm:get_other_bo_id_list(get_side(Atter));
          all_ally ->
            lib_bt_comm:get_bo_id_list(get_side(Atter));
          _Other ->
            ?ASSERT(false, Eff),
            ?ERROR_MSG("[lib_bo] unknown target for add buff!! Eff:~w", [Eff]),
            []
        end
    end,
  TargetCount =  Eff#bo_peff.target_count,
  TarBoIdList2 = lists:sublist(TarBoIdList,1,TargetCount),
  F = fun(TargetBoId, Acc) ->
    case TargetBoId of
      ?INVALID_ID ->
        Acc;
      _ ->
        % 如果目标已死亡，则不添加
        case is_dead(TargetBoId) of
          true ->
            Acc;
          false ->
            ?DEBUG_MSG("success about buffno ~p ~n",[Eff#bo_peff.buff_no]),
            {BuffsAdded, BuffsRemoved} =
              case add_buff(AtterId, TargetBoId, BuffNo, Eff#bo_peff.from_skill_id, TargetCount) of
                fail ->
                  {[], []};
                {ok, nothing_to_do} ->
                  {[], []};
                {ok, new_buff_added} ->
                  {[BuffNo], []};
                {ok, old_buff_replaced, OldBuffNo} ->
                  {[BuffNo], [OldBuffNo]};
                {passi, RemovedBuffNo} ->
                  {[], RemovedBuffNo}
              end,
            [#update_buffs_rule_dtl{
              bo_id = TargetBoId,
              atter_buffs_added = BuffsAdded,
              atter_buffs_removed = BuffsRemoved
            }] ++ Acc
        end
    end
      end,
  lists:foldl(F,[], TarBoIdList2).

% 被命中添加效果
try_apply_passi_eff_add_buff_on_be_hit(Defer,Atter,Eff) ->
	AtterId = get_id(Atter),
	DeferId = get_id(Defer),

	% ?DEBUG_MSG("AtterId = ~p,DeferId = ~p",[AtterId,DeferId]),

	Proba = Eff#bo_peff.trigger_proba,
	case lib_bt_util:test_proba(Proba) of
        fail ->
            [#on_hit_success_dtl{}];
        success ->
        	MySide = get_side(Defer),
    		EnemySide = lib_bt_comm:to_enemy_side(MySide),

    		% ?DEBUG_MSG("EnemySide = ~p,MySide = ~p,target_for_add_buff=~p",[EnemySide,MySide,Eff#bo_peff.target_for_add_buff]),

            BuffNo = Eff#bo_peff.buff_no,
            TarBoIdList = case Eff#bo_peff.target_for_add_buff of
                            myself ->
                                [DeferId];
                            atter ->
                                [AtterId];
                            all_enemy ->
                            	lib_bt_comm:get_bo_id_list(EnemySide);
                            all_ally ->
                            	lib_bt_comm:get_bo_id_list(MySide);
                            _Other ->
                                ?ASSERT(false, Eff),
                                ?ERROR_MSG("[lib_bo] unknown target for add buff!! Eff:~w", [Eff]),
                                []
                        end,

            TargetCount = 1,  % 用于计算BUFF效果

            F = fun(TargetBoId, Acc) ->
    			case TargetBoId of
                	?INVALID_ID ->
                    	Acc;
               		_ ->
                    % 如果目标已死亡，则不添加
	                    case is_dead(TargetBoId) of
	                        true ->
	                            Acc;
	                        false ->
	                            {BuffsAdded, BuffsRemoved} =
	                                    case add_buff(DeferId, TargetBoId, BuffNo, Eff#bo_peff.from_skill_id, TargetCount) of
	                                        fail ->
	                                            {[], []};
	                                        {ok, nothing_to_do} ->
	                                            {[], []};
	                                        {ok, new_buff_added} ->
	                                            {[BuffNo], []};
	                                        {ok, old_buff_replaced, OldBuffNo} ->
	                                            {[BuffNo], [OldBuffNo]};
                                        {passi, RemovedBuffNo} ->
                                          {[], RemovedBuffNo}
	                                    end,

	                            case TargetBoId of
	                                AtterId ->
	                                    [#on_hit_success_dtl{
	                                            atter_buffs_added = BuffsAdded,
	                                            atter_buffs_removed = BuffsRemoved
	                                            }] ++ Acc;
	                                _ ->
	                                    [#on_hit_success_dtl{
	                                            defer_buffs_added = BuffsAdded,
	                                            defer_buffs_removed = BuffsRemoved
	                                            }] ++ Acc
	                            end
	                    end
                end
    		end,

        	lists:foldl(F,[#on_hit_success_dtl{}], TarBoIdList)
    end.

% 命中敌人添加效果
try_apply_passi_eff_add_buff_on_hit(Atter, DeferId, Eff) ->
    AtterId = get_id(Atter),
    Proba = Eff#bo_peff.trigger_proba,
    case lib_bt_util:test_proba(Proba) of
        fail ->
            #on_hit_success_dtl{};
        success ->
            BuffNo = Eff#bo_peff.buff_no,
            TargetBoId = case Eff#bo_peff.target_for_add_buff of
                            myself ->
                                AtterId;
                            cur_att_target ->
                                DeferId;
                            _Other ->
                                ?ASSERT(false, Eff),
                                ?ERROR_MSG("[lib_bo] unknown target for add buff!! Eff:~w", [Eff]),
                                ?INVALID_ID
                        end,

            TargetCount = 1,  % 目前固定只有1个

            case TargetBoId of
                ?INVALID_ID ->
                    #on_hit_success_dtl{};
                _ ->
                    % 如果目标已死亡，则不添加
                    case is_dead(TargetBoId) of
                        true ->
                            #on_hit_success_dtl{};
                        false ->
                            {BuffsAdded, BuffsRemoved} =
                                    case add_buff(AtterId, TargetBoId, BuffNo, Eff#bo_peff.from_skill_id, TargetCount) of
                                        fail ->
                                            {[], []};
                                        {ok, nothing_to_do} ->
                                            {[], []};
                                        {ok, new_buff_added} ->
                                            {[BuffNo], []};
                                        {ok, old_buff_replaced, OldBuffNo} ->
                                            {[BuffNo], [OldBuffNo]};
                                      {passi, RemovedBuffNo} ->
                                        {[], RemovedBuffNo}
                                    end,

                            case TargetBoId of
                                AtterId ->
                                    #on_hit_success_dtl{
                                            atter_buffs_added = BuffsAdded,
                                            atter_buffs_removed = BuffsRemoved
                                            };
                                DeferId ->
                                    #on_hit_success_dtl{
                                            defer_buffs_added = BuffsAdded,
                                            defer_buffs_removed = BuffsRemoved
                                            };
                                _ -> % 容错
                                    #on_hit_success_dtl{}
                            end
                    end
            end
    end.

%% DamVal 表示伤害值 正数表示减血，负数表示加血
try_apply_passi_eff_on_dam_for_hp(Bo, DamVal, EffName) ->
    case DamVal =< 0 of
        true -> DamVal;
        false ->
            List = get_all_skill_list(Bo),
            F = fun(BoSklBrf, Acc) ->
                case mod_skill:get_cfg_data(BoSklBrf#bo_skl_brf.id) of
                    null -> Acc;
                    SklCfg -> mod_skill:get_passive_effs(SklCfg) ++ Acc
                end
            end,

            PassiveEffs = lists:foldl(F, [], List),
          %%这里再实现一个受到伤害时，有一定概率抵挡伤害的被动
           Dam1 = case find_passi_eff_no_by_eff_name(PassiveEffs, EffName) of
                ?INVALID_ID ->
                    DamVal;
                SklEffNo ->
                    case data_passi_eff:get(SklEffNo) of
                        null ->
                            ?ASSERT(false, {SklEffNo, EffName}),
                            DamVal;
                        DataCfg ->
                            case lib_bt_util:test_proba(DataCfg#passi_eff.para2) of
                                fail ->
                                    DamVal;
                                success ->
                                    case EffName of
                                        ?EN_PROTECT_HP_BY_RATE_BASE_LIM ->
                                            ?ASSERT(util:is_percent(DataCfg#passi_eff.para), DataCfg#passi_eff.para),
                                            ValCmp = erlang:round(get_hp_lim(Bo) * DataCfg#passi_eff.para),
                                            case DamVal > ValCmp of
                                                true -> ValCmp;
                                                false -> DamVal
                                            end;
                                        _Any ->
                                            ?ASSERT(false, _Any),
                                            ?ERROR_MSG("lib_bo, try_apply_passi_eff_on_dam_for_hp, EffName=~p~n", [EffName]),
                                            DamVal
                                    end
                            end
                    end
            end,
          case find_passi_eff_no_by_eff_name(PassiveEffs, ?EN_REDUCE_DAM_BY_RATE_BASE_LIM) of
            ?INVALID_ID ->
              Dam1;
            SklEffNo2 ->
              case data_passi_eff:get(SklEffNo2) of
                null ->
                  Dam1;
                DataCfg2 ->
                  case lib_bt_util:test_proba(DataCfg2#passi_eff.para2) of
                    fail ->
                      Dam1;
                    success ->
                      ValCmp2 = erlang:round(get_hp_lim(Bo) * DataCfg2#passi_eff.para),
                      case (Dam1 - ValCmp2) >=0 of
                        true -> (Dam1 - ValCmp2);
                        false -> 0
                      end;
                    _Any2 ->
                      Dam1
                  end
              end
          end
    end.

%% Val 表示血量 正数表示加血，负数表示扣血    限时任务伤害
try_apply_passi_eff_on_dam(Bo, Val, EffName) ->
    case ( (Val >= 0 andalso EffName =:= ?EN_PROTECT_HP_BY_RATE_BASE_LIM) orelse (not is_partner(Bo)) ) of
        true -> Val;
        false ->
            List = get_all_skill_list(Bo),
            F = fun(BoSklBrf, Acc) ->
                case mod_skill:get_cfg_data(BoSklBrf#bo_skl_brf.id) of
                    null -> Acc;
                    SklCfg -> mod_skill:get_passive_effs(SklCfg) ++ Acc
                end
            end,

            PassiveEffs = lists:foldl(F, [], List),
            case find_passi_eff_no_by_eff_name(PassiveEffs, EffName) of
                ?INVALID_ID ->
                    Val;
                SklEffNo ->
                    case data_passi_eff:get(SklEffNo) of
                        null ->
                            ?ASSERT(false, {SklEffNo, EffName}),
                            Val;
                        DataCfg ->
                            case lib_bt_util:test_proba(DataCfg#passi_eff.para2) of
                                fail ->
                                    Val;
                                success ->
                                    case EffName of
                                        ?EN_CHANGE_PHY_ATT_WHEN_HP_CHANGE -> % 效果表 para 表示 x点生命值 para2 表示 概率  是放大了1000倍的整数 para3 表示 x点加成
                                            ?ASSERT(util:is_positive_int(DataCfg#passi_eff.para), DataCfg#passi_eff.para),
                                            ?ASSERT(util:is_positive_int(DataCfg#passi_eff.para3), DataCfg#passi_eff.para3),
                                            if
                                                Val > 0 andalso Val >= DataCfg#passi_eff.para ->
                                                    ChangeVal = -DataCfg#passi_eff.para3 * util:floor(Val/DataCfg#passi_eff.para),
                                                    add_phy_att(get_id(Bo), ChangeVal),
                                                    ?DEBUG_MSG("BoId=~p,try_apply_passi_eff_on_dam(), change_phy_att_when_hp_change, ChangeVal:~p, CurVal=~p~n", [get_id(Bo), ChangeVal, get_phy_att(get_bo_by_id(get_id(Bo)))]),
                                                    lib_bt_send:notify_bo_attr_changed_to_all( get_bo_by_id(get_id(Bo)), [{?ATTR_PHY_ATT, ChangeVal}] );
                                                Val < 0 andalso -Val >= DataCfg#passi_eff.para ->
                                                    ChangeVal = DataCfg#passi_eff.para3 * util:floor((-Val)/DataCfg#passi_eff.para),
                                                    add_phy_att(get_id(Bo), ChangeVal),
                                                    ?DEBUG_MSG("BoId=~p,try_apply_passi_eff_on_dam(), change_phy_att_when_hp_change, ChangeVal:~p, CurVal=~p~n", [get_id(Bo), ChangeVal, get_phy_att(get_bo_by_id(get_id(Bo)))]),
                                                    lib_bt_send:notify_bo_attr_changed_to_all( get_bo_by_id(get_id(Bo)), [{?ATTR_PHY_ATT, ChangeVal}] );
                                                true -> skip
                                            end;
                                        ?EN_CHANGE_MAG_ATT_WHEN_HP_CHANGE ->
                                            ?ASSERT(util:is_positive_int(DataCfg#passi_eff.para), DataCfg#passi_eff.para),
                                            ?ASSERT(util:is_positive_int(DataCfg#passi_eff.para3), DataCfg#passi_eff.para3),
                                            if
                                                Val > 0 andalso Val >= DataCfg#passi_eff.para ->
                                                    ChangeVal = -DataCfg#passi_eff.para3 * util:floor(Val/DataCfg#passi_eff.para),
                                                    add_mag_att(get_id(Bo), ChangeVal),
                                                    ?DEBUG_MSG("BoId=~p,try_apply_passi_eff_on_dam(), change_mag_att_when_hp_change, add_hp=~p, ChangeVal:~p, CurVal=~p~n", [get_id(Bo), Val, ChangeVal, get_mag_att(get_bo_by_id(get_id(Bo)))]),
                                                    lib_bt_send:notify_bo_attr_changed_to_all( get_bo_by_id(get_id(Bo)), [{?ATTR_MAG_ATT, ChangeVal}] );
                                                Val < 0 andalso -Val >= DataCfg#passi_eff.para ->
                                                    ChangeVal = DataCfg#passi_eff.para3 * util:floor((-Val)/DataCfg#passi_eff.para),
                                                    add_mag_att(get_id(Bo), ChangeVal),
                                                    ?DEBUG_MSG("BoId=~p,try_apply_passi_eff_on_dam(), change_mag_att_when_hp_change, add_hp=~p, ChangeVal:~p, CurVal=~p~n", [get_id(Bo), Val, ChangeVal, get_mag_att(get_bo_by_id(get_id(Bo)))]),
                                                    lib_bt_send:notify_bo_attr_changed_to_all( get_bo_by_id(get_id(Bo)), [{?ATTR_MAG_ATT, ChangeVal}] );
                                                true -> skip
                                            end;
                                        ?EN_CHANGE_PHY_DEF_WHEN_HP_CHANGE_BY_RATE ->
                                            ?ASSERT(util:is_percent(DataCfg#passi_eff.para), DataCfg#passi_eff.para),
                                            ?ASSERT(util:is_percent(DataCfg#passi_eff.para3), DataCfg#passi_eff.para3),
                                            InitHpLim = get_init_hp_lim(Bo),
                                            CmpVal = erlang:round(DataCfg#passi_eff.para * InitHpLim),
                                            if
                                                Val > 0 andalso Val >= CmpVal ->
                                                    Times = util:floor(Val/CmpVal),
                                                    ChangeVal = -erlang:round(DataCfg#passi_eff.para3 * Times * get_init_phy_def(Bo)),
                                                    add_phy_def(get_id(Bo), ChangeVal),
                                                    ?BT_LOG(io_lib:format("BoId=~p,try_apply_passi_eff_on_dam(), change_phy_def_when_hp_change_by_rate, ChangeVal:~p, CurVal=~p~n", [get_id(Bo), ChangeVal, get_phy_def(get_bo_by_id(get_id(Bo)))])),
                                                    lib_bt_send:notify_bo_attr_changed_to_all( get_bo_by_id(get_id(Bo)), [{?ATTR_PHY_DEF, ChangeVal}] );
                                                Val < 0 andalso -Val >= CmpVal ->
                                                    Times = util:floor((-Val)/CmpVal),
                                                    ChangeVal = erlang:round(DataCfg#passi_eff.para3 * Times * get_init_phy_att(Bo)),
                                                    add_phy_def(get_id(Bo), ChangeVal),
                                                    ?BT_LOG(io_lib:format("BoId=~p,try_apply_passi_eff_on_dam(), change_phy_def_when_hp_change_by_rate, ChangeVal:~p, CurVal=~p~n", [get_id(Bo), ChangeVal, get_phy_def(get_bo_by_id(get_id(Bo)))])),
                                                    lib_bt_send:notify_bo_attr_changed_to_all( get_bo_by_id(get_id(Bo)), [{?ATTR_PHY_DEF, ChangeVal}] );
                                                true -> skip
                                            end;
                                        ?EN_CHANGE_MAG_DEF_WHEN_HP_CHANGE_BY_RATE ->
                                            ?ASSERT(util:is_percent(DataCfg#passi_eff.para), DataCfg#passi_eff.para),
                                            ?ASSERT(util:is_percent(DataCfg#passi_eff.para3), DataCfg#passi_eff.para3),
                                            InitHpLim = get_init_hp_lim(Bo),
                                            CmpVal = erlang:round(DataCfg#passi_eff.para * InitHpLim),
                                            if
                                                Val > 0 andalso Val >= CmpVal ->
                                                    Times = util:floor(Val/CmpVal),
                                                    ChangeVal = -erlang:round(DataCfg#passi_eff.para3 * Times * get_init_mag_def(Bo)),
                                                    add_mag_def(get_id(Bo), ChangeVal),
                                                    ?BT_LOG(io_lib:format("BoId=~p,try_apply_passi_eff_on_dam(), change_mag_def_when_hp_change_by_rate, ChangeVal:~p, CurVal=~p~n", [get_id(Bo), ChangeVal, get_mag_def(get_bo_by_id(get_id(Bo)))])),
                                                    lib_bt_send:notify_bo_attr_changed_to_all( get_bo_by_id(get_id(Bo)), [{?ATTR_MAG_DEF, ChangeVal}] );
                                                Val < 0 andalso -Val >= CmpVal ->
                                                    Times = util:floor((-Val)/CmpVal),
                                                    ChangeVal = erlang:round(DataCfg#passi_eff.para3 * Times * get_init_mag_att(Bo)),
                                                    add_mag_def(get_id(Bo), ChangeVal),
                                                    ?BT_LOG(io_lib:format("BoId=~p,try_apply_passi_eff_on_dam(), change_mag_def_when_hp_change_by_rate, ChangeVal:~p, CurVal=~p~n", [get_id(Bo), ChangeVal, get_mag_def(get_bo_by_id(get_id(Bo)))])),
                                                    lib_bt_send:notify_bo_attr_changed_to_all( get_bo_by_id(get_id(Bo)), [{?ATTR_MAG_DEF, ChangeVal}] );
                                                true -> skip
                                            end;
                                        _Any ->
                                            ?ERROR_MSG("lib_bo, try_apply_passi_eff_on_dam, EffName=~p~n", [EffName]),
                                            skip
                                    end
                            end
                    end
            end
    end.


%% 攻击命中时给目标掉怒气 目前只有掉的
%% return #on_hit_success_dtl{}
try_apply_passi_eff_on_hit(Atter, DeferId, EffName) ->
    case get_bo_by_id(DeferId) of
        null -> #on_hit_success_dtl{};
        _ ->
            List = get_all_skill_list(Atter),
            F = fun(BoSklBrf, Acc) ->
                case mod_skill:get_cfg_data(BoSklBrf#bo_skl_brf.id) of
                    null -> Acc;
                    SklCfg -> mod_skill:get_passive_effs(SklCfg) ++ Acc
                end
            end,

            PassiveEffs = lists:foldl(F, [], List),
            case find_passi_eff_no_by_eff_name(PassiveEffs, EffName) of
                ?INVALID_ID ->
                    case is_partner(Atter) of
                        true ->
                            ?BT_LOG(io_lib:format("lib_bo:find_passi_eff_no_by_eff_name fail,EffName=~p,PassiveEffs=~p, PassiveList=~w~n", [EffName, PassiveEffs, List]));
                        false ->
                            skip
                    end,
                    #on_hit_success_dtl{};
                SklEffNo ->
                    case data_passi_eff:get(SklEffNo) of
                        null ->
                            ?ASSERT(false, {SklEffNo, EffName}),
                            #on_hit_success_dtl{};
                        DataCfg ->
                            case lib_bt_util:test_proba(DataCfg#passi_eff.para2) of
                                fail ->
                                    case EffName =:= reduce_hp_on_phy_att_hit_base_mg of
                                        true ->
                                            ?BT_LOG(io_lib:format("lib_bo:test_proba fail,EffName=~p~n", [EffName]));
                                        false -> skip
                                    end,
                                    #on_hit_success_dtl{};
                                success ->
                                    case EffName of
                                        ?EN_REDUCE_ANGER_ON_PHY_ATT_HIT ->
                                            add_anger(DeferId, - DataCfg#passi_eff.para),
                                            ?BT_LOG(io_lib:format("lib_bo:try_apply_passi_eff_anger_on_hit(), DataCfg#passi_eff.para:~p, Defer anger:~p~n", [DataCfg#passi_eff.para, get_anger(get_bo_by_id(DeferId))])),
                                            #on_hit_success_dtl{dam_to_anger = DataCfg#passi_eff.para};
                                        ?EN_REDUCE_ANGER_ON_MAG_ATT_HIT ->
                                            add_anger(DeferId, - DataCfg#passi_eff.para),
                                            #on_hit_success_dtl{dam_to_anger = DataCfg#passi_eff.para};
                                        ?EN_REDUCE_HP_ON_PHY_ATT_HIT_BASE_TARGET_MG_LIM ->
                                            ?ASSERT(util:is_percent(DataCfg#passi_eff.para), DataCfg#passi_eff.para),
                                            Val = erlang:round(get_mp_lim(get_bo_by_id(DeferId)) * DataCfg#passi_eff.para),
                                            add_hp(DeferId, -Val),
                                            ?BT_LOG(io_lib:format("lib_bo:reduce_hp_on_phy_att_hit_base_target_mg_lim DataCfg#passi_eff.para:~p, Val:~p~n", [DataCfg#passi_eff.para, Val])),
                                            #on_hit_success_dtl{dam_to_defer = Val};
                                        ?EN_REDUCE_HP_ON_PHY_ATT_HIT_BASE_MG ->
                                            ?ASSERT(util:is_percent(DataCfg#passi_eff.para), DataCfg#passi_eff.para),
                                            Val = erlang:round(get_mp(Atter) * DataCfg#passi_eff.para),
                                            add_hp(DeferId, -Val),
                                            ?BT_LOG(io_lib:format("lib_bo:reduce_hp_on_phy_att_hit_base_mg DataCfg#passi_eff.para:~p, Val:~p~n", [DataCfg#passi_eff.para, Val])),
                                            #on_hit_success_dtl{dam_to_defer = Val};
                                        ?EN_REDUCE_HP_ON_MAG_ATT_HIT_BASE_MG ->
                                            ?ASSERT(util:is_percent(DataCfg#passi_eff.para), DataCfg#passi_eff.para),
                                            Val = erlang:round(get_mp(Atter) * DataCfg#passi_eff.para),
                                            ?BT_LOG(io_lib:format("lib_bo:reduce_hp_on_mag_att_hit_base_mg DataCfg#passi_eff.para:~p, Val:~p~n", [DataCfg#passi_eff.para, Val])),
                                            add_hp(DeferId, -Val),
                                            #on_hit_success_dtl{dam_to_defer = Val};
                                        _Any ->
                                            ?ASSERT(false, _Any),
                                            #on_hit_success_dtl{}
                                    end
                            end
                    end
            end
    end.

find_passi_eff_no_by_eff_name([], _EffName) ->
    ?INVALID_ID;
find_passi_eff_no_by_eff_name([H | T], EffName) ->
    case data_passi_eff:get(H) of
        null -> find_passi_eff_no_by_eff_name(T, EffName);
        DataCfg ->
            case DataCfg#passi_eff.name =:= EffName of
                true -> DataCfg#passi_eff.no;
                false -> find_passi_eff_no_by_eff_name(T, EffName)
            end
    end.


%% 多个on_hit_success_dtl结构体的对应字段相加，返回结果
%% @return: #on_hit_success_dtl{}
sum_on_hit_success_dtl([]) ->
    #on_hit_success_dtl{};
sum_on_hit_success_dtl([Dtl]) ->
    ?ASSERT(is_record(Dtl, on_hit_success_dtl)),
    Dtl;
sum_on_hit_success_dtl([Dtl1, Dtl2 | T]) ->
    TmpDtl = sum_two_on_hit_success_dtl(Dtl1, Dtl2),
    sum_on_hit_success_dtl([TmpDtl | T]).

sum_two_on_hit_success_dtl(Dtl1, Dtl2) ->
    #on_hit_success_dtl{
            atter_buffs_added = Dtl1#on_hit_success_dtl.atter_buffs_added ++ Dtl2#on_hit_success_dtl.atter_buffs_added,
            defer_buffs_added = Dtl1#on_hit_success_dtl.defer_buffs_added ++ Dtl2#on_hit_success_dtl.defer_buffs_added,
            defer_buffs_removed = Dtl1#on_hit_success_dtl.defer_buffs_removed ++ Dtl2#on_hit_success_dtl.defer_buffs_removed,
            dam_to_defer = Dtl1#on_hit_success_dtl.dam_to_defer + Dtl2#on_hit_success_dtl.dam_to_defer,
            dam_to_anger = Dtl1#on_hit_success_dtl.dam_to_anger + Dtl2#on_hit_success_dtl.dam_to_anger
            }.


%% 移除昏睡buff
remove_trance_buff(Bo) ->
    BuffList = get_buff_list(Bo),
    remove_trance_buff__(Bo, BuffList).

remove_trance_buff__(_Bo, []) ->
    do_nothing;
remove_trance_buff__(Bo, [Buff | T]) ->
    case lib_bo_buff:is_trance(Buff) of
        true ->
            remove_buff( get_id(Bo), Buff),
            BuffNo = lib_bo_buff:get_no(Buff),
            {ok, [BuffNo]};
        false ->
            remove_trance_buff__(Bo, T)
    end.





% %% @desc: 添加一个buff到战斗对象
% %% NewBuff: #bo_buff{}
% %% @return: 没用
% add_buff_to_bo(BoId, NewBuff) when is_record(NewBuff, bo_buff) ->
%   SkillId = NewBuff#bo_buff.skill_id,
%   EffName = NewBuff#bo_buff.eff_name,
%   Bo = get(BoId),

%   case is_can_only_have_one_buff(NewBuff) of
%     true ->
%       case get_bo_buff_by_eff_name(Bo, EffName) of
%         [] ->
%           do_add_buff_to_bo(BoId, NewBuff);
%         [OldBuff] ->
%           handle_replace_old_buff(BoId, NewBuff, OldBuff);
%         _Any ->
%           ?ERROR_MSG("add_buff_to_bo() ERR!!! _Any: ~p, bo: ~p", [_Any, Bo]),
%           ?ASSERT(false, {_Any, Bo}),
%           skip
%       end;
%     false ->
%       case get_same_buff_from(Bo, {SkillId, EffName}) of
%         null -> % 没有同类buff，直接添加
%           do_add_buff_to_bo(BoId, NewBuff);
%         OldBuff -> % 有同类buff，则判断是否可以叠加
%           case is_can_overlap(OldBuff) of
%             false -> % 不可叠加，则处理buff替换规则
%               handle_replace_old_buff(BoId, NewBuff, OldBuff);
%             true -> % 可叠加，判断是否叠加满了
%               case OldBuff#bo_buff.cur_overlap >= OldBuff#bo_buff.max_overlap of
%                 true -> % 已达最大叠加层数，跳过
%                   skip;
%                 false -> % 未叠加满，则叠加
%                   % 先移除旧的
%                   remove_buff_from_bo(BoId, OldBuff, ?RB_REPLACED),

%                   % 再加新的
%                   NewOverLap = OldBuff#bo_buff.cur_overlap + 1,  % 叠加层数加1
%                   ?ASSERT(NewOverLap =< OldBuff#bo_buff.max_overlap),
%                   NewBuff2 = OldBuff#bo_buff{cur_overlap = NewOverLap},

%                   do_add_buff_to_bo(BoId, NewBuff2)
%               end
%           end
%       end
%   end.


%% 应用结拜的属性加成
apply_sworn_add_attr(BoId, SwornAddAttr) ->
    Bo = get_bo_by_id(BoId),
    NewInitAttrs = lib_attribute:sum_two_attrs(Bo#battle_obj.init_attrs , SwornAddAttr),
    NewAttrs = lib_attribute:sum_two_attrs(Bo#battle_obj.attrs , SwornAddAttr),
    % 矫正，勿忘！
    NewInitAttrs2 = lib_attribute:adjust_attrs(NewInitAttrs),
    NewAttrs2 = lib_attribute:adjust_attrs(NewAttrs),

    Bo2 = Bo#battle_obj{
                    init_attrs = NewInitAttrs2,
                    attrs = NewAttrs2
                    },
    update_bo(Bo2).


%% 应用阵法的属性加成
apply_zf_add_attr(BoId, AddAttr) ->
    Bo = get_bo_by_id(BoId),
    NewInitAttrs = lib_attribute:sum_two_attrs(Bo#battle_obj.init_attrs, AddAttr),
    NewAttrs = lib_attribute:sum_two_attrs(Bo#battle_obj.attrs, AddAttr),

    % 矫正，勿忘！
    NewInitAttrs1 = lib_attribute:calc_rate_attrs(NewInitAttrs, AddAttr),
    NewAttrs1 = lib_attribute:calc_rate_attrs(NewAttrs, AddAttr),

    NewInitAttrs2 = lib_attribute:adjust_attrs(NewInitAttrs1),
    NewAttrs2 = lib_attribute:adjust_attrs(NewAttrs1),

    Bo2 = Bo#battle_obj{
                    init_attrs = NewInitAttrs2,
                    attrs = NewAttrs2
                    },
    update_bo(Bo2).



get_buff_list(Bo) ->
    Bo#battle_obj.buffs.


%% 获取特定触发事件类型的被动效果列表
get_passi_effs(Bo, TriggerType) ->
	Bo#battle_obj.passi_effs.


%% 添加伪buff，仅用于做客户端显示
add_dummy_buff(ToBoId, BuffNo, ExpireRound) ->
    case lib_buff_tpl:get_tpl_data(BuffNo) of
        null ->
            ?ASSERT(false, BuffNo),
            skip;
        BuffTpl when is_record(BuffTpl, buff_tpl) ->
            ?ASSERT(lib_buff_tpl:get_name(BuffTpl) == ?BFN_DUMMY, {ToBoId, BuffNo, ExpireRound, BuffTpl}),
            NewBuff = #bo_buff{
                        buff_no = BuffNo,
                        buff_name = ?BFN_DUMMY,
                        expire_round = ExpireRound
                        },

            ToBo = get_bo_by_id(ToBoId),
            NewBuffList = [NewBuff | ToBo#battle_obj.buffs],
            ToBo2 = ToBo#battle_obj{buffs = NewBuffList},
            update_bo(ToBo2)
    end.



%% 添加一个buff到战斗对象
%% @return: fail => 失败
%%          {ok, nothing_to_do} => 成功，不需做处理
%%          {ok, new_buff_added} => 成功，新buff已经添加
%%          {ok, old_buff_replaced, OldBuffNo} => 成功，旧buff已经被替换（OldBuffNo: 被替换的buff编号）
add_buff(FromBoId, ToBoId, NewBuffNo, FromSkillId, TotalTargetCount) when is_integer(NewBuffNo) ->
    ?ASSERT(mod_skill:is_valid_skill_id(FromSkillId), {FromBoId, NewBuffNo, FromSkillId}),
    case lib_bt_comm:is_bo_exists(FromBoId)
    andalso lib_bt_comm:is_bo_exists(ToBoId) of  % 稳妥起见，判断双方是否存在
        false ->
            fail;
        true ->
            case lib_buff_tpl:get_tpl_data(NewBuffNo) of
                null ->
                    ?ASSERT(false, NewBuffNo),
                    fail;
                BuffTpl when is_record(BuffTpl, buff_tpl) ->
                    LastingRound = lib_bt_calc:calc_buff_lasting_round_on_add(FromBoId, ToBoId, FromSkillId, BuffTpl, TotalTargetCount),
                    case LastingRound > 0 of
                        false ->
                            fail;
                        true ->
                            ?DEBUG_MSG("wjctestbuff2 ~p",[{LastingRound,get_cur_round() }]),
                            ExpireRound = get_cur_round() + LastingRound,
                            NewBuff = #bo_buff{
                                        buff_no = lib_buff_tpl:get_no(BuffTpl),
                                        buff_name = lib_buff_tpl:get_name(BuffTpl),
                                        from_bo_id = FromBoId,
                                        from_skill_id = FromSkillId,
                                        eff_type = lib_buff_tpl:get_eff_type(BuffTpl),
                                        eff_para = lib_buff_tpl:get_para(BuffTpl),
                                        expire_round = ExpireRound,
                                        cur_overlap = 1,    % 当前叠加层数初始时固定为1
                                        max_overlap = lib_buff_tpl:get_max_overlap(BuffTpl)
                                        },
                            add_buff(FromBoId, ToBoId, NewBuff)
                    end
            end
    end.




add_buff(FromBoId, ToBoId, NewBuff) when is_record(NewBuff, bo_buff) ->
    ToBo = get_bo_by_id(ToBoId),

    CanAddBuff = case lib_bo_buff:get_category(NewBuff) of
        2 -> % 控制类BUFF都是2
            not lib_bo:is_immu_control(ToBo);
        _ ->
            true
    end,

    case CanAddBuff of
        true ->
            % 是否已有相同的buff？
          case NewBuff#bo_buff.eff_type of
            passi ->
              %%可以根据buffname再细分类
              case NewBuff#bo_buff.buff_name == ?BFN_AT_ONCE_PURGE_BUFF of
                true ->
                  BuffTpl = lib_buff_tpl:get_tpl_data(NewBuff#bo_buff.buff_no),
                  PurgeBuffRule = BuffTpl#buff_tpl.para,
                  {ok, PurgeBuffsDtl} = lib_bo:purge_buff(ToBoId, PurgeBuffRule),
                  {passi, PurgeBuffsDtl#purge_buffs_dtl.defer_buffs_removed};
                false ->
                  %% 目前只有立即驱散buff这一个
                  {ok, nothing_to_do}
              end;
            _ ->
              case find_same_buff(ToBo, NewBuff) of
                null ->
                  % 是否已有同类型的buff？
                  case find_same_type_buff_one(ToBo, NewBuff) of
                    null ->
                      do_add_buff(FromBoId, ToBoId, NewBuff), % 直接添加
                      {ok, new_buff_added};
                    OldSameTypeBuff ->
                      add_buff__(has_same_type_buff, FromBoId, ToBoId, NewBuff, OldSameTypeBuff)
                  end;
                OldSameBuff ->
                  add_buff__(has_same_buff, FromBoId, ToBoId, NewBuff, OldSameBuff)
              end
          end;
        false ->
            {ok, nothing_to_do}
    end.






add_buff__(has_same_buff, FromBoId, ToBoId, NewBuff, OldSameBuff) ->
    case lib_bo_buff:get_replacement_rule(OldSameBuff) of
        occupy ->
            {ok, nothing_to_do};
        _ ->
            % 判断是否是可以叠加BUFF 如果是则叠加
            case lib_bo_buff:get_max_overlap(OldSameBuff) of
                1 -> replace_old_buff(FromBoId, ToBoId, NewBuff, OldSameBuff);
                Num ->
                    NewOverlap = erlang:min(OldSameBuff#bo_buff.cur_overlap + 1,OldSameBuff#bo_buff.max_overlap),
                    NewBuff1 = NewBuff#bo_buff{cur_overlap = NewOverlap},
                    replace_old_buff(FromBoId, ToBoId, NewBuff1, OldSameBuff)
            end,

            % 直接替换


            {ok, old_buff_replaced, lib_bo_buff:get_no(OldSameBuff)}
    end;

add_buff__(has_same_type_buff, FromBoId, ToBoId, NewBuff, OldSameTypeBuff) ->
    ?BT_LOG(io_lib:format("[lib_bo] add_buff__(has_same_type_buff, ..), OldSameTypeBuff:~w~n    NewBuff:~w~n", [OldSameTypeBuff, NewBuff])),
    Rule = lib_bo_buff:get_replacement_rule(OldSameTypeBuff),
    case Rule of
        coexist -> % 共存
            do_add_buff(FromBoId, ToBoId, NewBuff),
            {ok, new_buff_added};
        _ ->
            OldBuffNo = lib_bo_buff:get_no(OldSameTypeBuff),
            % 比较优先级
            case lib_bo_buff:compare_buff(NewBuff, OldSameTypeBuff) of
                higher ->
                    replace_old_buff(FromBoId, ToBoId, NewBuff, OldSameTypeBuff),
                    {ok, old_buff_replaced, OldBuffNo};
                lower ->
                    {ok, nothing_to_do};
                equal ->
                    case Rule of
                        occupy ->
                            {ok, nothing_to_do};
                        replace ->
                          %% 剩余回合数最大的成功替换或保留该BUFF
                          case NewBuff#bo_buff.expire_round >= OldSameTypeBuff#bo_buff.expire_round of
                            true ->
                              replace_old_buff(FromBoId, ToBoId, NewBuff, OldSameTypeBuff),
                              {ok, old_buff_replaced, OldBuffNo};
                            false ->
                              {ok, nothing_to_do}
                          end
                    end
            end
    end.







%% 查找相同的buff（依据buff编号匹配）
find_same_buff(Bo, BuffToMatch) ->
    BuffNo = lib_bo_buff:get_no(BuffToMatch),
    case find_buff_by_no(Bo, BuffNo) of
        null ->
            null;
        SameBuff ->
            % 断言不同时存在多个同编号的buff（要么没有，要么只有一个）
            ?ASSERT(dbg_find_all_buff_by_no(Bo, BuffNo) == [SameBuff]),

            SameBuff
    end.







%% 查找一个同类的buff（依据buff类别匹配）
find_same_type_buff_one(Bo, BuffToMatch) ->

    Category = lib_bo_buff:get_category(BuffToMatch),
    case find_buff_by_category(Bo, Category) of
        null ->
            null;
        SameTypeBuff ->
            SameTypeBuff
    end.



% %% 查找同类型的一个buff
% %% @return: null | bo_buff结构体
% find_same_type_buff_one(Bo, BuffToMatch) ->
%     % 暂时只匹配buff名
%     BuffName = BuffToMatch#bo_buff.buff_name,
%     % SkillId = BuffToMatch#bo_buff.skill_id,
%     case find_buff_by_name(Bo, BuffName) of
%         null ->
%             null;
%         SameBuff ->
%             SameBuff
%     end.


% %% 查找同类型的buff列表
% find_same_type_buff_all(_Bo, _BuffToMatch) ->
%     todo_here,
%     [].




% %% 叠加buff（简单起见，叠加buff的处理其实是先移除旧的，再添加新的!）
% do_overlap_buff(BoId, NewBuff, OldSameTypeBuff) ->
%     ?ASSERT(lib_bo_buf:two_are_same_type(NewBuff, OldSameTypeBuff)),

%     % 1. 先移除旧的
%     remove_buff(BoId, OldSameTypeBuff),

%     % 2. 再加新的
%     NewCurOverlap = lib_bo_buff:get_cur_overlap(OldSameTypeBuff) + 1,  % 叠加层数加1
%     ?ASSERT(NewCurOverlap =< lib_bo_buff:get_max_overlap(OldSameTypeBuff)),

%     % TODO: 考虑：需要比较两个buff的max_overlap，然后更新为较大的那个值？？
%     % NewMaxOverlap = ....


%     % 重算eff para， 因为叠加的各层buff的eff_para不一定相同， 所以无法简单通过 (eff_para * 叠加层数) 来计算最终的eff_para
%     NewEffPara = lib_bo_buff:sum_eff_para(NewBuff, OldSameTypeBuff),  %%    OldSameTypeBuff#bo_buff.eff_para + NewBuff#bo_buff.eff_para,

%     NewBuff2 = OldSameTypeBuff#bo_buff{
%                     cur_overlap = NewCurOverlap,
%                     eff_para = NewEffPara
%                     },
%     do_add_buff(BoId, NewBuff2).



% %% 尝试替换（同类型的）旧buff
% try_replace_old_buff(BoId, NewBuff, OldSameTypeBuff) ->
%     case lib_bo_buff:compare_buff(NewBuff, OldSameTypeBuff) of
%         diff ->
%             ?ASSERT(false, {BoId, NewBuff, OldSameTypeBuff}),
%             fail;
%         equal ->  % 新buff和旧buff完全相等，则不替换
%             ?TRACE("~n~n.........try_replace_old_buff(),  two buffs are equal (name: ~p).....~n~n", [lib_bo_buff:get_name(NewBuff)]),
%             {ok, nothing_to_do};
%         lower ->   % 新buff比旧buff低级，则不替换
%             {ok, nothing_to_do};
%         higher -> % 新buff比旧buff高级，则执行替换
%             ?TRACE("~n~n.........try_replace_old_buff(),  new buff is HIGHER (name: ~p).....~n~n", [lib_bo_buff:get_name(NewBuff)]),
%             % 先移除旧的
%             remove_buff(BoId, OldSameTypeBuff),

%             %%NewBo = get(BoId),

%             % 再加新的
%             do_add_buff(BoId, NewBuff),

%             {ok, old_buff_replaced}
%     end.








%% 直接添加buff到bo
do_add_buff(FromBoId, ToBoId, NewBuff) ->
    ?ASSERT(is_record(NewBuff, bo_buff), NewBuff),

    FromBo = get_bo_by_id(FromBoId),
    ToBo = get_bo_by_id(ToBoId),

    % 按公式计算实际的效果值
    EffPara = lib_bt_calc:calc_buff_eff_para(FromBo, ToBo, NewBuff),
    ?ASSERT(is_record(EffPara, buff_eff_para), EffPara),

    % 记录实际的效果值
    NewBuff2 = NewBuff#bo_buff{
                    eff_para = EffPara
                    },

    % 添加新buff到bo
    NewBuffList = [NewBuff2 | ToBo#battle_obj.buffs],
    ToBo2 = ToBo#battle_obj{buffs = NewBuffList},
    update_bo(ToBo2),

    % 应用buff效果到bo
    apply_buff_eff_to_bo_pre(FromBoId,ToBoId, NewBuff2),

    void.



% 应用BUFF效果到战斗对象身上
apply_buff_eff_to_bo_pre(FromBoId,BoId, NewBuff) ->
  BuffName = lib_bo_buff:get_name(NewBuff),
  SkillId = NewBuff#bo_buff.from_skill_id,
  SkillCfgData = data_skill:get(SkillId),
  SkillElement = SkillCfgData#skl_cfg.five_elements,
  Bo = get_bo_by_id(FromBoId),
  {FiveElement, FiveElementLv} = Bo#battle_obj.five_elements,
  ElementCoef =  %%技能与施放者五行相同才生效
  case FiveElement == SkillElement of
    true ->
      case FiveElementLv of
        0 ->
          1;
        1 ->
          FiveElementData  = data_five_elements_level:get(FiveElement,FiveElementLv),
          1 + FiveElementData#five_elements_level.effect_num;
        2 ->
          FiveElementData1  = data_five_elements_level:get(FiveElement,1),
          FiveElementData2  = data_five_elements_level:get(FiveElement,2),
          1 + FiveElementData1#five_elements_level.effect_num + FiveElementData2#five_elements_level.effect_num;
        _ ->
          FiveElementData1  = data_five_elements_level:get(FiveElement,1),
          FiveElementData2  = data_five_elements_level:get(FiveElement,2),
          1 + FiveElementData1#five_elements_level.effect_num + FiveElementData2#five_elements_level.effect_num
      end;
    false ->
      1
  end,

  %% 更新五行效果  降低对方的暂时不写,有些无法归纳有比较少见的也先不写
  BuffNameList =
    [
      {?BFN_TRANS_PHY_DEF_TO_PHY_ATT,1},
      {?BFN_TRANS_PHY_MAG_DEF_TO_PHY_ATT,1},
      {?BFN_ADD_PHY_ATT , 1},
      {?BFN_ADD_MAG_ATT , 1},
      {?BFN_ADD_BE_PHY_DAM_SHRINK, 1},
      {?BFN_ADD_BE_MAG_DAM_SHRINK,1},
      {?BFN_ADD_PHY_DEF,1},
      {?BFN_ADD_MAG_DEF,1},
      {?BFN_ADD_PHY_MAG_DEF, 0},
      {?BFN_ADD_DODGE, 1},
      {?BFN_ADD_CRIT, 1},
      {?BFN_ADD_PHY_CRIT,1},
      {?BFN_ADD_MAG_CRIT,1},
      {?BFN_ADD_ACT_SPEED,1},
      {?BFN_YOUYING_MINGWANG,1},
      {?BFN_ADD_SEAL_RESIS,1},
      {?BFN_ADD_SEAL_HIT,1},
      {?BFN_ADD_BE_PHY_DAM_REDUCE_COEF,1},
      {?BFN_ADD_BE_MAG_DAM_REDUCE_COEF, 1},
      {?BFN_ADD_DO_PHY_DAM_SCALING,1},
      {?BFN_ADD_DO_MAG_DAM_SCALING,1},
      {?BFN_ADD_DO_DAM_SCALING, 1},
      {?BFN_ADD_BE_HEAL_EFF_COEF, 1},
      {?BFN_ADD_RET_DAM_COEF,1},
      {?BFN_ABSORB_HP_COEF, 1},
      {?BFN_ADD_CRIT_COEF, 1},
      {?BFN_ANTI_INVISIBLE_AND_ADD_PHY_MAG_ATT,0}
    ],

  case lists:keyfind(BuffName,1, BuffNameList) of
    false ->
      apply_buff_eff_to_bo(BuffName, BoId, NewBuff);
    {_, Type} ->
      ApplayBo = get_bo_by_id(BoId),
      update_bo(ApplayBo#battle_obj{eff_buff_name = [{BuffName,ElementCoef}|ApplayBo#battle_obj.eff_buff_name]}),
      case Type of
        0 ->
          OldValue = NewBuff#bo_buff.eff_para#buff_eff_para.eff_real_value,
          OldValue2 = NewBuff#bo_buff.eff_para#buff_eff_para.eff_real_value_2,
          NewBuff2 = NewBuff#bo_buff{eff_para = #buff_eff_para{eff_real_value =(ElementCoef * OldValue ) , eff_real_value_2 =(ElementCoef * OldValue2 ) }},
          apply_buff_eff_to_bo(BuffName, BoId, NewBuff2);
        1 ->
          OldValue = NewBuff#bo_buff.eff_para#buff_eff_para.eff_real_value,
          case add_be_dam_reduce_coef ==  BuffName of
            true ->
              ?DEBUG_MSG("wujianchengtestBattle ~p~n",[ {NewBuff#bo_buff.eff_para#buff_eff_para.eff_real_value, ElementCoef , util:ceil(ElementCoef * OldValue )}]);
            false ->
              skip
          end,
          NewBuff2 = NewBuff#bo_buff{eff_para = #buff_eff_para{eff_real_value = ElementCoef * OldValue }} ,
          apply_buff_eff_to_bo(BuffName, BoId, NewBuff2)

      end
  end.
%%% 播放加血
%%apply_buff_eff_to_bo(?BFN_HEAL_HP_AT_ONCE, BoId, NewBuff) ->
%%  EffRealVal = lib_bo_buff:get_eff_real_value(NewBuff),
%%  put({BoId,heal_hp}, EffRealVal),
%%  void;
%%
%%% 播放扣血
%%apply_buff_eff_to_bo(?BFN_HURT_HP_AT_ONCE, BoId, NewBuff) ->
%%  EffRealVal = lib_bo_buff:get_eff_real_value(NewBuff),
%%  put({BoId,hurt_hp}, EffRealVal),
%%  void;

% 强行死亡并离开战斗 这个不需要清楚buff吧？
apply_buff_eff_to_bo(?BFN_FORCE_DIE_AND_LEAVE_BATTLE, BoId, NewBuff) ->
  lib_bo:set_hp(BoId, 0),
  TarBo = get_bo_by_id(BoId),
  ?ASSERT(TarBo /= null, BoId),
  DieDtl = lib_bo:bo_die_and_force_leave_battle(TarBo),
  Action = #boa_force_die{
    details_list = [#force_die_dtl{
      bo_id = BoId,
      die_status = DieDtl#die_details.die_status,
      buffs_removed = DieDtl#die_details.buffs_removed
    }]
  },
  % 收集战报
  mod_battle:collect_battle_report(boa_force_die, Action),
  void;

% 临时标记当前回合攻击时，伤害值为受击方生命的一定比例，并有一个伤害上限
apply_buff_eff_to_bo(?BFN_TMP_MARK_DO_DAM_BY_DEFER_HP_RATE_WITH_LIMIT, BoId, NewBuff) ->
  Para = lib_bo_buff:get_buff_tpl_para(NewBuff),
  lib_bo:tmp_mark_do_dam_by_defer_hp_rate_with_limit(BoId, Para),
  void;

% 临时强行设置可触发XX次物理连击
apply_buff_eff_to_bo(?BFN_TMP_FORCE_SET_PHY_COMBO_ATT_TIMES, BoId, NewBuff) ->
  Times = lib_bo_buff:get_buff_tpl_para(NewBuff),
  lib_bo:set_tmp_force_phy_combo_att_proba(BoId,  ?PROBABILITY_BASE), % 设为必定触发
  lib_bo:set_tmp_force_max_phy_combo_att_times(BoId, Times),
  void;

% 临时强行设置追击概率
apply_buff_eff_to_bo(?BFN_TMP_FORCE_SET_PURSUE_ATT_PROBA, BoId, NewBuff) ->
  Proba = lib_bo_buff:get_buff_tpl_para(NewBuff),
  lib_bo:set_tmp_force_pursue_att_proba(BoId, Proba),
  void;




% 临时强行设置追击次数上限
apply_buff_eff_to_bo(?BFN_TMP_FORCE_SET_MAX_PURSUE_ATT_TIMES, BoId, NewBuff) ->
  Times = lib_bo_buff:get_buff_tpl_para(NewBuff),
  lib_bo:set_tmp_force_max_pursue_att_times(BoId, Times),
  void;

% 临时强行设置追击伤害系数
apply_buff_eff_to_bo(?BFN_TMP_FORCE_SET_PURSUE_ATT_DAM_COEF, BoId, NewBuff) ->
  PursueAttDamCoef = lib_bo_buff:get_buff_tpl_para(NewBuff),
  lib_bo:set_tmp_force_pursue_att_dam_coef(BoId, PursueAttDamCoef),
  void;

% 应用buff效果到战斗对象身上 效果为 转换物理防御为物理攻击
apply_buff_eff_to_bo(?BFN_TRANS_PHY_DEF_TO_PHY_ATT, BoId, NewBuff) ->
  Bo = get_bo_by_id(BoId),
  {rate, PhyRate, AttRate}= lib_bo_buff:get_buff_tpl_para(NewBuff),
  PhyDefToTrans = erlang:round(get_init_phy_def(Bo) * AttRate),
  add_phy_def(BoId, - PhyDefToTrans),
  AddPhyAtt =util:ceil( PhyDefToTrans * PhyRate),

  add_phy_att(BoId, AddPhyAtt),
  void;

% 应用buff效果到战斗对象身上 效果为 转换法术防御为法术攻击
apply_buff_eff_to_bo(?BFN_TRANS_MAG_DEF_TO_MAG_ATT, BoId, NewBuff) ->
  Bo = get_bo_by_id(BoId),
  {rate, MagRate, AttRate}= lib_bo_buff:get_buff_tpl_para(NewBuff),
  MagDefToTrans = erlang:round(get_init_mag_def(Bo) * AttRate),
  add_mag_def(BoId, - MagDefToTrans),
  AddMagAtt =util:ceil( MagDefToTrans * MagRate),
  add_mag_att(BoId, AddMagAtt),
  void;


apply_buff_eff_to_bo(?BFN_TRANS_PHY_MAG_DEF_TO_PHY_ATT, BoId, NewBuff) ->
  Bo = get_bo_by_id(BoId),
  {rate, Rate} = lib_bo_buff:get_buff_tpl_para(NewBuff),
  ?ASSERT(Rate > 0 andalso Rate =< 1, {Rate, NewBuff}),
  PhyDefToTrans = erlang:round(get_init_phy_def(Bo) * Rate),
  MagDefToTrans = erlang:round(get_init_mag_def(Bo) * Rate),
  add_phy_def(BoId, - PhyDefToTrans),
  add_mag_def(BoId, - MagDefToTrans),

  EffRealVal = lib_bo_buff:get_eff_real_value(NewBuff),
  ?ASSERT(util:is_positive_int(EffRealVal), EffRealVal),
  add_phy_att(BoId, EffRealVal),

  ?BT_LOG( io_lib:format("apply BFN_TRANS_PHY_MAG_DEF_TO_PHY_ATT, BoId=~p, PhyDefToTrans=~p, MagDefToTrans=~p, EffRealVal=~p, OldPhyAtt=~p, OldPhyDef=~p, OldMagDef=~p, NewPhyAtt=~p, NewPhyDef=~p, NewMagDef=~p~n",
    [BoId, PhyDefToTrans, MagDefToTrans, EffRealVal,
      get_phy_att(Bo), get_phy_def(Bo), get_mag_def(Bo),
      get_phy_att(get_bo_by_id(BoId)), get_phy_def(get_bo_by_id(BoId)), get_mag_def(get_bo_by_id(BoId))
    ]
  )
  ),
  void;


apply_buff_eff_to_bo(?BFN_ADD_PHY_ATT, BoId, NewBuff) ->
  EffRealVal = lib_bo_buff:get_eff_real_value(NewBuff),
  % ?ASSERT(util:is_positive_int(EffRealVal), EffRealVal),
  add_phy_att(BoId, EffRealVal);



apply_buff_eff_to_bo(?BFN_ADD_MAG_ATT, BoId, NewBuff) ->
  EffRealVal = lib_bo_buff:get_eff_real_value(NewBuff),
  ?DEBUG_MSG("apply_buff_eff_to_bo BFN_ADD_MAG_ATT ~p ",[EffRealVal]),
  % ?ASSERT(util:is_positive_int(EffRealVal), EffRealVal),
  add_mag_att(BoId, EffRealVal);


apply_buff_eff_to_bo(?BFN_ADD_BE_PHY_DAM_SHRINK, BoId, NewBuff) ->
  EffRealVal = lib_bo_buff:get_eff_real_value(NewBuff),
  % ?ASSERT(util:is_positive_int(EffRealVal), EffRealVal),
  add_be_phy_dam_shrink(BoId, EffRealVal);

apply_buff_eff_to_bo(?BFN_ADD_BE_MAG_DAM_SHRINK, BoId, NewBuff) ->
  EffRealVal = lib_bo_buff:get_eff_real_value(NewBuff),
  % ?DEBUG_MSG("apply_buff_eff_to_bo BFN_ADD_BE_MAG_DAM_SHRINK ~p ",[EffRealVal]),
  % ?ASSERT(util:is_positive_int(EffRealVal), EffRealVal),
  add_be_mag_dam_shrink(BoId, EffRealVal);



apply_buff_eff_to_bo(?BFN_ADD_PHY_DEF, BoId, NewBuff) ->
  EffRealVal = lib_bo_buff:get_eff_real_value(NewBuff),
  ?DEBUG_MSG("TestFiveBuff  BFN_ADD_PHY_DEF ~p~n", [EffRealVal]),
  ?ASSERT(util:is_positive_int(EffRealVal), EffRealVal),
  add_phy_def(BoId, EffRealVal);

apply_buff_eff_to_bo(?BFN_ADD_MAG_DEF, BoId, NewBuff) ->
  EffRealVal = lib_bo_buff:get_eff_real_value(NewBuff),
  ?DEBUG_MSG("TestFiveBuff  BFN_ADD_MAG_DEF ~p~n", [EffRealVal]),
  ?ASSERT(util:is_positive_int(EffRealVal), EffRealVal),
  add_mag_def(BoId, EffRealVal);


apply_buff_eff_to_bo(?BFN_ADD_PHY_MAG_DEF, BoId, NewBuff) ->
  EffRealVal = lib_bo_buff:get_eff_real_value(NewBuff),
  EffRealVal_2 = lib_bo_buff:get_eff_real_value_2(NewBuff),
  ?ASSERT(is_integer(EffRealVal), EffRealVal),
  ?ASSERT(is_integer(EffRealVal_2), EffRealVal_2),

  add_phy_def(BoId, EffRealVal),
  add_mag_def(BoId, EffRealVal_2);



apply_buff_eff_to_bo(?BFN_REDUCE_PHY_ATT, BoId, NewBuff) ->
  EffRealVal = lib_bo_buff:get_eff_real_value(NewBuff),
  ?ASSERT(util:is_positive_int(EffRealVal), EffRealVal),
  add_phy_att(BoId, - EffRealVal);

apply_buff_eff_to_bo(?BFN_REDUCE_MAG_ATT, BoId, NewBuff) ->
  EffRealVal = lib_bo_buff:get_eff_real_value(NewBuff),
  ?ASSERT(util:is_positive_int(EffRealVal), EffRealVal),
  add_mag_att(BoId, - EffRealVal);


apply_buff_eff_to_bo(?BFN_REDUCE_TEN, BoId, NewBuff) ->
  EffRealVal = lib_bo_buff:get_eff_real_value(NewBuff),
  ?ASSERT(util:is_positive_int(EffRealVal), EffRealVal),
  add_ten(BoId, - EffRealVal);


apply_buff_eff_to_bo(?BFN_REDUCE_PHY_DEF, BoId, NewBuff) ->
  EffRealVal = lib_bo_buff:get_eff_real_value(NewBuff),
  ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, NewBuff}),
  ?BT_LOG(io_lib:format("apply_buff_eff_to_bo, BFN_REDUCE_PHY_DEF, BoId=~p, EffRealVal=~p~n", [BoId, EffRealVal])),
  add_phy_def(BoId, - EffRealVal);



apply_buff_eff_to_bo(?BFN_REDUCE_PHY_DEF_BY_RATE, BoId, NewBuff) ->
  Bo = get_bo_by_id(BoId),
  ReduceRate = lib_bo_buff:get_buff_tpl_para(NewBuff),
  ?ASSERT(ReduceRate >= 0 andalso ReduceRate =< 1, {ReduceRate, NewBuff}),
  InitPhyDef = get_init_phy_def(Bo),
  ReduceVal = round(InitPhyDef * ReduceRate),
  add_phy_def(BoId, - ReduceVal);

apply_buff_eff_to_bo(?BFN_ADD_PHY_DEF_BY_RATE, BoId, NewBuff) ->
  Bo = get_bo_by_id(BoId),
  ReduceRate = lib_bo_buff:get_buff_tpl_para(NewBuff),
  ?ASSERT(ReduceRate >= 0 andalso ReduceRate =< 1, {ReduceRate, NewBuff}),
  InitPhyDef = get_init_phy_def(Bo),
  ReduceVal = round(InitPhyDef * ReduceRate),
  add_phy_def(BoId, ReduceVal);

apply_buff_eff_to_bo(?BFN_REDUCE_MAG_ATT_BY_RATE, BoId, NewBuff) ->
  Bo = get_bo_by_id(BoId),
  ReduceRate = lib_bo_buff:get_buff_tpl_para(NewBuff),
  ?ASSERT(ReduceRate >= 0 andalso ReduceRate =< 1, {ReduceRate, NewBuff}),
  InitPhyDef = get_init_mag_att(Bo),
  ReduceVal = round(InitPhyDef * ReduceRate),
  add_mag_att(BoId, - ReduceVal);

apply_buff_eff_to_bo(?BFN_ADD_MAG_ATT_BY_RATE, BoId, NewBuff) ->
  Bo = get_bo_by_id(BoId),
  ReduceRate = lib_bo_buff:get_buff_tpl_para(NewBuff),
  ?ASSERT(ReduceRate >= 0 andalso ReduceRate =< 1, {ReduceRate, NewBuff}),
  InitPhyDef = get_init_mag_att(Bo),
  ReduceVal = round(InitPhyDef * ReduceRate),
  add_mag_att(BoId, ReduceVal);

apply_buff_eff_to_bo(?BFN_REDUCE_PHY_ATT_BY_RATE, BoId, NewBuff) ->
  Bo = get_bo_by_id(BoId),
  ReduceRate = lib_bo_buff:get_buff_tpl_para(NewBuff),
  ?ASSERT(ReduceRate >= 0 andalso ReduceRate =< 1, {ReduceRate, NewBuff}),
  InitPhyDef = get_init_phy_att(Bo),
  ReduceVal = round(InitPhyDef * ReduceRate),
  add_phy_att(BoId, - ReduceVal);

apply_buff_eff_to_bo(?BFN_ADD_PHY_ATT_BY_RATE, BoId, NewBuff) ->
  Bo = get_bo_by_id(BoId),
  ReduceRate = lib_bo_buff:get_buff_tpl_para(NewBuff),
  ?ASSERT(ReduceRate >= 0 andalso ReduceRate =< 1, {ReduceRate, NewBuff}),
  InitPhyDef = get_init_phy_att(Bo),
  ReduceVal = round(InitPhyDef * ReduceRate),
  add_phy_att(BoId, ReduceVal);

%%apply_buff_eff_to_bo(?BFN_REDUCE_HP_LIM_BY_RATE, BoId, NewBuff) ->
%%  Bo = get_bo_by_id(BoId),
%%  ReduceRate = lib_bo_buff:get_buff_tpl_para(NewBuff),
%%  ?ASSERT(ReduceRate >= 0 andalso ReduceRate =< 1, {ReduceRate, NewBuff}),
%%  InitPhyDef = get_init_hp_lim(Bo),
%%  ReduceVal = round(InitPhyDef * ReduceRate),
%%  add_hp(BoId, - ReduceVal);

apply_buff_eff_to_bo(?BFN_ADD_HEAL_EFF_COEF, BoId, NewBuff) ->
  ReduceRate = lib_bo_buff:get_buff_tpl_para(NewBuff),
  ?ASSERT(ReduceRate >= 0 andalso ReduceRate =< 1, {ReduceRate, NewBuff}),
  add_heal_eff_coef(BoId, ReduceRate);

apply_buff_eff_to_bo(?BFN_REDUCE_HEAL_EFF_COEF, BoId, NewBuff) ->
  ReduceRate = lib_bo_buff:get_buff_tpl_para(NewBuff),
  ?ASSERT(ReduceRate >= 0 andalso ReduceRate =< 1, {ReduceRate, NewBuff}),
  add_heal_eff_coef(BoId, -ReduceRate);

apply_buff_eff_to_bo(?BFN_ADD_REVIVE_HEAL_COEF, BoId, NewBuff) ->
  ReduceRate = lib_bo_buff:get_buff_tpl_para(NewBuff),
  add_revive_heal_coef(BoId, ReduceRate);

apply_buff_eff_to_bo(?BFN_REDUCE_PURSUE_ATT_DAM_COEF, BoId, NewBuff) ->
  ReduceRate = lib_bo_buff:get_buff_tpl_para(NewBuff),
  add_reduce_purse_att_dam_coef(BoId, -ReduceRate);

apply_buff_eff_to_bo(?BFN_REDUCE_PHY_CRIT_COEF, BoId, NewBuff) ->
  ReduceRate = lib_bo_buff:get_buff_tpl_para(NewBuff),
  add_phy_crit_coef(BoId, -ReduceRate);

apply_buff_eff_to_bo(?BFN_REDUCE_MAG_CRIT_COEF, BoId, NewBuff) ->
  ReduceRate = lib_bo_buff:get_buff_tpl_para(NewBuff),
  add_mag_crit_coef(BoId, -ReduceRate);

apply_buff_eff_to_bo(?BFN_ADD_PHY_CRIT_COEF, BoId, NewBuff) ->
  ReduceRate = lib_bo_buff:get_buff_tpl_para(NewBuff),
  add_phy_crit_coef(BoId, ReduceRate);

apply_buff_eff_to_bo(?BFN_ADD_MAG_CRIT_COEF, BoId, NewBuff) ->
  ReduceRate = lib_bo_buff:get_buff_tpl_para(NewBuff),
  add_mag_crit_coef(BoId, ReduceRate);







apply_buff_eff_to_bo(?BFN_ADD_SEAL_HIT_BY_RATE, BoId, NewBuff) ->
  Bo = get_bo_by_id(BoId),
  Rate = lib_bo_buff:get_buff_tpl_para(NewBuff),
  InitSealHit = get_init_seal_hit(Bo),
  Val = round(InitSealHit * Rate),
  add_seal_hit(BoId, Val);

apply_buff_eff_to_bo(?BFN_REDUCE_SEAL_HIT_BY_RATE, BoId, NewBuff) ->
  Bo = get_bo_by_id(BoId),
  Rate = lib_bo_buff:get_buff_tpl_para(NewBuff),
  InitSealHit = get_init_seal_hit(Bo),
  Val = round(InitSealHit * Rate),
  add_seal_hit(BoId, -Val);

apply_buff_eff_to_bo(?BFN_ADD_SEAL_RESIS_BY_RATE, BoId, NewBuff) ->
  Bo = get_bo_by_id(BoId),
  Rate = lib_bo_buff:get_buff_tpl_para(NewBuff),
  InitSealResis = get_init_seal_resis(Bo),
  Val = round(InitSealResis * Rate),
  add_seal_resis(BoId, Val);

apply_buff_eff_to_bo(?BFN_REDUCE_SEAL_RESIS_BY_RATE, BoId, NewBuff) ->
  Bo = get_bo_by_id(BoId),
  Rate = lib_bo_buff:get_buff_tpl_para(NewBuff),
  InitSealResis = get_init_seal_resis(Bo),
  Val = round(InitSealResis * Rate),
  add_seal_resis(BoId, -Val);

apply_buff_eff_to_bo(?BFN_REDUCE_ACT_SPEED_BY_RATE, BoId, NewBuff) ->
  Bo = get_bo_by_id(BoId),
  Rate = lib_bo_buff:get_buff_tpl_para(NewBuff),
  InitSealResis = get_init_act_speed(Bo),
  Val = round(InitSealResis * Rate),
  add_act_speed(BoId, -Val);


apply_buff_eff_to_bo(?BFN_ADD_ACT_SPEED_BY_RATE, BoId, NewBuff) ->
  Bo = get_bo_by_id(BoId),
  Rate = lib_bo_buff:get_buff_tpl_para(NewBuff),
  InitSealResis = get_init_act_speed(Bo),
  Val = round(InitSealResis * Rate),
  add_act_speed(BoId, Val);

apply_buff_eff_to_bo(?BFN_REDUCE_MAG_DEF_BY_RATE, BoId, NewBuff) ->
  Bo = get_bo_by_id(BoId),
  Rate = lib_bo_buff:get_buff_tpl_para(NewBuff),
  InitSealResis = get_init_mag_def(Bo),
  Val = round(InitSealResis * Rate),
  add_mag_def(BoId, -Val);


apply_buff_eff_to_bo(?BFN_ADD_MAG_DEF_BY_RATE, BoId, NewBuff) ->
  Bo = get_bo_by_id(BoId),
  Rate = lib_bo_buff:get_buff_tpl_para(NewBuff),
  InitSealResis = get_init_mag_def(Bo),
  Val = round(InitSealResis * Rate),
  add_mag_def(BoId, Val);




apply_buff_eff_to_bo(?BFN_REDUCE_MAG_DEF, BoId, NewBuff) ->
  EffRealVal = lib_bo_buff:get_eff_real_value(NewBuff),
  ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, NewBuff}),
  add_mag_def(BoId, - EffRealVal);



apply_buff_eff_to_bo(?BFN_REDUCE_PHY_MAG_DEF, BoId, NewBuff) ->
  EffRealVal = lib_bo_buff:get_eff_real_value(NewBuff),
  EffRealVal_2 = lib_bo_buff:get_eff_real_value_2(NewBuff),
  ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, NewBuff}),
  ?ASSERT(util:is_nonnegative_int(EffRealVal_2), {EffRealVal_2, NewBuff}),
  ?BT_LOG(io_lib:format("apply_buff_eff_to_bo(), BFN_REDUCE_PHY_MAG_DEF, BoId=~p, EffRealVal=~p, EffRealVal_2=~p~n", [BoId, EffRealVal, EffRealVal_2])),
  add_phy_def(BoId, - EffRealVal),
  add_mag_def(BoId, - EffRealVal_2);




apply_buff_eff_to_bo(?BFN_WEAK, BoId, NewBuff) ->
  % 目前只是减物防
  EffRealVal = lib_bo_buff:get_eff_real_value(NewBuff),
  ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BoId, NewBuff}),
  add_phy_def(BoId, - EffRealVal);



apply_buff_eff_to_bo(?BFN_ADD_DODGE, BoId, NewBuff) ->
  EffRealVal = lib_bo_buff:get_eff_real_value(NewBuff),
  ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BoId, NewBuff}),
  add_dodge(BoId, EffRealVal);


apply_buff_eff_to_bo(?BFN_REDUCE_DODGE, BoId, NewBuff) ->
  EffRealVal = lib_bo_buff:get_eff_real_value(NewBuff),
  ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BoId, NewBuff}),
  add_dodge(BoId, - EffRealVal);


apply_buff_eff_to_bo(?BFN_ADD_CRIT, BoId, NewBuff) ->
  EffRealVal = lib_bo_buff:get_eff_real_value(NewBuff),
  ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BoId, NewBuff}),
  add_crit(BoId, EffRealVal);

apply_buff_eff_to_bo(?BFN_ADD_PHY_CRIT, BoId, NewBuff) ->
  EffRealVal = lib_bo_buff:get_eff_real_value(NewBuff),
  ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BoId, NewBuff}),
  add_phy_crit(BoId, EffRealVal);

apply_buff_eff_to_bo(?BFN_REDUCE_PHY_CRIT, BoId, NewBuff) ->
  EffRealVal = lib_bo_buff:get_eff_real_value(NewBuff),
  ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BoId, NewBuff}),
  add_phy_crit(BoId, -EffRealVal);

apply_buff_eff_to_bo(?BFN_ADD_PHY_TEN, BoId, NewBuff) ->
  EffRealVal = lib_bo_buff:get_eff_real_value(NewBuff),
  ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BoId, NewBuff}),
  add_phy_ten(BoId, EffRealVal);

apply_buff_eff_to_bo(?BFN_REDUCE_PHY_TEN, BoId, NewBuff) ->
  EffRealVal = lib_bo_buff:get_eff_real_value(NewBuff),
  ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BoId, NewBuff}),
  add_phy_ten(BoId, -EffRealVal);

apply_buff_eff_to_bo(?BFN_REDUCE_MAG_CRIT, BoId, NewBuff) ->
  EffRealVal = lib_bo_buff:get_eff_real_value(NewBuff),
  ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BoId, NewBuff}),
  add_mag_crit(BoId, -EffRealVal);

apply_buff_eff_to_bo(?BFN_ADD_MAG_TEN, BoId, NewBuff) ->
  EffRealVal = lib_bo_buff:get_eff_real_value(NewBuff),
  ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BoId, NewBuff}),
  add_mag_ten(BoId, EffRealVal);

apply_buff_eff_to_bo(?BFN_REDUCE_MAG_TEN, BoId, NewBuff) ->
  EffRealVal = lib_bo_buff:get_eff_real_value(NewBuff),
  ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BoId, NewBuff}),
  add_mag_ten(BoId, -EffRealVal);





apply_buff_eff_to_bo(?BFN_ADD_MAG_CRIT, BoId, NewBuff) ->
  EffRealVal = lib_bo_buff:get_eff_real_value(NewBuff),
  ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BoId, NewBuff}),
  add_mag_crit(BoId, EffRealVal);

apply_buff_eff_to_bo(?BFN_ADD_STRIKEBACK_PROBA, BoId, NewBuff) ->
  {proba, AddProba} = lib_bo_buff:get_buff_tpl_para(NewBuff),
  ?ASSERT(util:is_positive_int(AddProba), NewBuff),
  add_strikeback_proba(BoId, AddProba);


% TODO:  处理BFN_ADD_RET_DAM_PROBA
%          ...

apply_buff_eff_to_bo(?BFN_ADD_RET_DAM_PROBA, BoId, NewBuff) ->
  {proba, AddProba} = lib_bo_buff:get_buff_tpl_para(NewBuff),
  ?ASSERT(util:is_positive_int(AddProba), NewBuff),
  add_ret_dam_proba(BoId, AddProba);



apply_buff_eff_to_bo(?BFN_ADD_PHY_COMBO_ATT_PROBA, BoId, NewBuff) ->
  {{proba, AddProba}, {max_combo_att_times, AddTimes}} = lib_bo_buff:get_buff_tpl_para(NewBuff),
%%  ?ASSERT(util:is_positive_int(AddProba), NewBuff),
  % ?ASSERT(util:is_nonnegative_int(AddTimes), NewBuff),
  add_phy_combo_att_proba(BoId, AddProba),
  add_max_phy_combo_att_times(BoId, AddTimes);


apply_buff_eff_to_bo(?BFN_ADD_MAG_COMBO_ATT_PROBA, BoId, NewBuff) ->
  {{proba, AddProba}, {max_combo_att_times, AddTimes}} = lib_bo_buff:get_buff_tpl_para(NewBuff),
%%  ?ASSERT(util:is_positive_int(AddProba), NewBuff),
  % ?ASSERT(util:is_nonnegative_int(AddTimes), NewBuff),
  add_mag_combo_att_proba(BoId, AddProba),
  add_max_mag_combo_att_times(BoId, AddTimes);


apply_buff_eff_to_bo(?BFN_ADD_ACT_SPEED, BoId, NewBuff) ->
  EffRealVal = lib_bo_buff:get_eff_real_value(NewBuff),
  ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BoId, NewBuff}),
  add_act_speed(BoId, EffRealVal);


apply_buff_eff_to_bo(?BFN_REDUCE_ACT_SPEED, BoId, NewBuff) ->
  EffRealVal = lib_bo_buff:get_eff_real_value(NewBuff),
  ?ASSERT(util:is_positive_int(EffRealVal), {EffRealVal, BoId, NewBuff}),
  add_act_speed(BoId, - EffRealVal);

apply_buff_eff_to_bo(?BFN_YOUYING_MINGWANG, BoId, NewBuff) ->
  EffRealVal = lib_bo_buff:get_eff_real_value(NewBuff),
  ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BoId, NewBuff}),
  add_act_speed(BoId, EffRealVal);



apply_buff_eff_to_bo(?BFN_SHIXUE_MINGWANG, BoId, NewBuff) ->
  % 加抗封能力
  EffRealVal = lib_bo_buff:get_eff_real_value(NewBuff),
  ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BoId, NewBuff}),
  add_seal_resis(BoId, EffRealVal),
  % 加吸血系数，从对应的buff模板的参数获取
  {{rate, Rate}, _} = lib_bo_buff:get_buff_tpl_para(NewBuff),
  add_absorb_hp_coef(BoId, Rate);



apply_buff_eff_to_bo(?BFN_DALI_MINGWANG, BoId, NewBuff) ->
  % EffRealVal = lib_bo_buff:get_eff_real_value(NewBuff),
  % ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BoId, NewBuff}),
  % add_crit(BoId, EffRealVal),
  % 大力冥王增加物理伤害缩放效果
  % Scaling = lib_bo_buff:get_dlmw_add_phy_dam_scaling(NewBuff),
  % add_do_phy_dam_scaling(BoId, Scaling);
  void;


apply_buff_eff_to_bo(?BFN_REDUCE_SEAL_RESIS, BoId, NewBuff) ->
  EffRealVal = lib_bo_buff:get_eff_real_value(NewBuff),
  ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BoId, NewBuff}),
  add_seal_resis(BoId, - EffRealVal);


apply_buff_eff_to_bo(?BFN_ADD_SEAL_RESIS, BoId, NewBuff) ->
  % 加抗封能力
  EffRealVal = lib_bo_buff:get_eff_real_value(NewBuff),
  ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BoId, NewBuff}),
  add_seal_resis(BoId, EffRealVal);

apply_buff_eff_to_bo(?BFN_ADD_NEGLECT_SEAL_RESIS, BoId, NewBuff) ->
  % 加忽视抗封能力
  EffRealVal = lib_bo_buff:get_eff_real_value(NewBuff),
  ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BoId, NewBuff}),
  add_neglect_seal_resis(BoId, EffRealVal);




apply_buff_eff_to_bo(?BFN_REDUCE_SEAL_HIT, BoId, NewBuff) ->
  EffRealVal = lib_bo_buff:get_eff_real_value(NewBuff),
  ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BoId, NewBuff}),
  add_seal_hit(BoId, - EffRealVal);


apply_buff_eff_to_bo(?BFN_ADD_SEAL_HIT, BoId, NewBuff) ->
  % 加抗封能力
  EffRealVal = lib_bo_buff:get_eff_real_value(NewBuff),
  ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BoId, NewBuff}),
  add_seal_hit(BoId, EffRealVal);

apply_buff_eff_to_bo(?BFN_ADD_BE_PHY_DAM_REDUCE_COEF, BoId, NewBuff) ->
  AddRate = lib_bo_buff:get_eff_real_value(NewBuff),
  % ?ASSERT(AddRate > 0 andalso AddRate =< 1, {AddRate, NewBuff}),
  add_be_phy_dam_reduce_coef(BoId, AddRate);


apply_buff_eff_to_bo(?BFN_ADD_BE_MAG_DAM_REDUCE_COEF, BoId, NewBuff) ->
  AddRate = lib_bo_buff:get_eff_real_value(NewBuff),
  % ?ASSERT(AddRate > 0 andalso AddRate =< 1, {AddRate, NewBuff}),
  add_be_mag_dam_reduce_coef(BoId, AddRate);


apply_buff_eff_to_bo(?BFN_ADD_BE_DAM_REDUCE_COEF, BoId, NewBuff) ->
  % AddRate = lib_bo_buff:get_buff_tpl_para(NewBuff),
  AddRate = lib_bo_buff:get_eff_real_value(NewBuff),
  % ?ASSERT(AddRate > 0 andalso AddRate =< 1, {AddRate, NewBuff}),
  add_be_phy_dam_reduce_coef(BoId, AddRate),
  add_be_mag_dam_reduce_coef(BoId, AddRate);


apply_buff_eff_to_bo(?BFN_REDUCE_BE_PHY_DAM_REDUCE_COEF, BoId, NewBuff) ->
  ReduceRate = lib_bo_buff:get_eff_real_value(NewBuff),
  % ?ASSERT(ReduceRate > 0, {ReduceRate, NewBuff}),
  add_be_phy_dam_reduce_coef(BoId, - ReduceRate);


apply_buff_eff_to_bo(?BFN_REDUCE_BE_MAG_DAM_REDUCE_COEF, BoId, NewBuff) ->
  ReduceRate = lib_bo_buff:get_eff_real_value(NewBuff),
  % ?ASSERT(ReduceRate > 0, {ReduceRate, NewBuff}),
  add_be_mag_dam_reduce_coef(BoId, - ReduceRate);


apply_buff_eff_to_bo(?BFN_REDUCE_BE_DAM_REDUCE_COEF, BoId, NewBuff) ->
  ReduceRate = lib_bo_buff:get_eff_real_value(NewBuff),

  ?DEBUG_MSG("wjcAddRate = ~p ------------- ~p ~n",[ReduceRate,NewBuff]),
  % ?ASSERT(ReduceRate > 0, {ReduceRate, NewBuff}),
  add_be_phy_dam_reduce_coef(BoId, - ReduceRate),
  add_be_mag_dam_reduce_coef(BoId, - ReduceRate);



%% 提升法术伤害减免系数，但同时降低物理伤害减免系数
apply_buff_eff_to_bo(?BFN_ADD_BMDR_COEF_BUT_REDUCE_BPDR_COEF, BoId, NewBuff) ->
  {{add, AddRate}, {reduce, ReduceRate}} = lib_bo_buff:get_eff_real_value(NewBuff),
  ?ASSERT(AddRate > 0 andalso AddRate =< 1, {AddRate, NewBuff}),
  ?ASSERT(ReduceRate > 0 andalso ReduceRate =< 1, {ReduceRate, NewBuff}),
  add_be_mag_dam_reduce_coef(BoId, AddRate),
  add_be_phy_dam_reduce_coef(BoId, - ReduceRate);



%% 提升物理伤害减免系数，但同时降低法术伤害减免系数
apply_buff_eff_to_bo(?BFN_ADD_BPDR_COEF_BUT_REDUCE_BMDR_COEF, BoId, NewBuff) ->
  {{add, AddRate}, {reduce, ReduceRate}} = lib_bo_buff:get_eff_real_value(NewBuff),
  ?ASSERT(AddRate > 0 andalso AddRate =< 1, {AddRate, NewBuff}),
  ?ASSERT(ReduceRate > 0 andalso ReduceRate =< 1, {ReduceRate, NewBuff}),
  add_be_phy_dam_reduce_coef(BoId, AddRate),
  add_be_mag_dam_reduce_coef(BoId, - ReduceRate);




apply_buff_eff_to_bo(?BFN_ADD_DO_PHY_DAM_SCALING, BoId, NewBuff) ->
  % AddRate = lib_bo_buff:get_buff_tpl_para(NewBuff),
  % 物理伤害能力提高
  AddRate = lib_bo_buff:get_eff_real_value(NewBuff),
  ?DEBUG_MSG("AddRate = ~p",[AddRate]),
  % ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BoId, NewBuff}),
  % ?ASSERT(AddRate > 0, {AddRate, NewBuff}),
  add_do_phy_dam_scaling(BoId, AddRate);


apply_buff_eff_to_bo(?BFN_ADD_DO_MAG_DAM_SCALING, BoId, NewBuff) ->
  % AddRate = lib_bo_buff:get_buff_tpl_para(NewBuff),
  % ?ASSERT(AddRate > 0, {AddRate, NewBuff}),
  AddRate = lib_bo_buff:get_eff_real_value(NewBuff),
  add_do_mag_dam_scaling(BoId, AddRate);


apply_buff_eff_to_bo(?BFN_ADD_DO_DAM_SCALING, BoId, NewBuff) ->
  AddRate = lib_bo_buff:get_eff_real_value(NewBuff),
  % ?ASSERT(AddRate > 0, {AddRate, NewBuff}),
  add_do_phy_dam_scaling(BoId, AddRate),
  add_do_mag_dam_scaling(BoId, AddRate);


apply_buff_eff_to_bo(?BFN_REDUCE_DO_PHY_DAM_SCALING, BoId, NewBuff) ->
  ReduceRate = lib_bo_buff:get_eff_real_value(NewBuff),
  % ?ASSERT(ReduceRate > 0, {ReduceRate, NewBuff}),
  add_do_phy_dam_scaling(BoId, - ReduceRate);


apply_buff_eff_to_bo(?BFN_REDUCE_DO_MAG_DAM_SCALING, BoId, NewBuff) ->
  ReduceRate = lib_bo_buff:get_eff_real_value(NewBuff),
  % ?ASSERT(ReduceRate > 0, {ReduceRate, NewBuff}),
  add_do_mag_dam_scaling(BoId, - ReduceRate);


apply_buff_eff_to_bo(?BFN_REDUCE_DO_DAM_SCALING, BoId, NewBuff) ->
  ReduceRate = lib_bo_buff:get_eff_real_value(NewBuff),
  % ?ASSERT(ReduceRate > 0, {ReduceRate, NewBuff}),
  add_do_phy_dam_scaling(BoId, - ReduceRate),
  add_do_mag_dam_scaling(BoId, - ReduceRate);


apply_buff_eff_to_bo(?BFN_ADD_BE_HEAL_EFF_COEF, BoId, NewBuff) ->
  Rate = lib_bo_buff:get_eff_real_value(NewBuff),
  ?ASSERT(Rate > 0, {Rate, NewBuff}),
  add_be_heal_eff_coef(BoId, Rate);


%应用增加反震系数的BUFF
apply_buff_eff_to_bo(?BFN_ADD_RET_DAM_COEF, BoId, NewBuff) ->
  Rate = lib_bo_buff:get_eff_real_value(NewBuff),
  ?DEBUG_MSG("TestRetDamCoef ~p~n",[Rate]),
  ?ASSERT(Rate > 0, {Rate, NewBuff}),
  add_ret_dam_coef(BoId, Rate);

% 应用增加吸血
apply_buff_eff_to_bo(?BFN_ABSORB_HP_COEF, BoId, NewBuff) ->
  Rate = lib_bo_buff:get_eff_real_value(NewBuff),
  ?ASSERT(Rate > 0, {Rate, NewBuff}),
  add_absorb_hp_coef(BoId, Rate);


% 增加暴击程度
apply_buff_eff_to_bo(?BFN_ADD_CRIT_COEF, BoId, NewBuff) ->
  Rate = lib_bo_buff:get_eff_real_value(NewBuff),
  add_crit_coef(BoId, Rate);


% 减少暴击程度
apply_buff_eff_to_bo(?BFN_REDUCE_CRIT_COEF, BoId, NewBuff) ->
  Rate = lib_bo_buff:get_eff_real_value(NewBuff),
  add_crit_coef(BoId, -Rate);


apply_buff_eff_to_bo(?BFN_REDUCE_BE_HEAL_EFF_COEF, BoId, NewBuff) ->
  Rate = lib_bo_buff:get_eff_real_value(NewBuff),
  add_be_heal_eff_coef(BoId, - Rate);

apply_buff_eff_to_bo(?BFN_ANTI_INVISIBLE_AND_ADD_PHY_MAG_ATT, BoId, NewBuff) ->
  EffRealVal = lib_bo_buff:get_eff_real_value(NewBuff),
  EffRealVal_2 = lib_bo_buff:get_eff_real_value_2(NewBuff),
  ?ASSERT(is_integer(EffRealVal), EffRealVal),
  ?ASSERT(is_integer(EffRealVal_2), EffRealVal_2),
  add_phy_att(BoId, EffRealVal),
  add_mag_att(BoId, EffRealVal_2);

apply_buff_eff_to_bo(?BFN_BE_TAUNT, BoId, NewBuff) ->
  FromBoId = lib_bo_buff:get_from_bo_id(NewBuff),
  ?ASSERT(lib_bt_comm:is_bo_exists(FromBoId), {FromBoId, BoId, NewBuff}),
  ?BT_LOG(io_lib:format("apply_buff_eff_to_bo, BFN_BE_TAUNT, BoId=~p, FromBoId=~p~n", [BoId, FromBoId])),
  set_he_who_taunt_me(BoId, FromBoId);

% apply_buff_eff_to_bo(?BFN_FORCE_PARTNER_ESCAPE, BoId, _NewBuff) ->
%     % ForBo = get_bo_by_id(BoId),
%     % PlayerBo = lib_bt_comm:get_bo_by_player_id(PlayerId),
%     % lib_bt_cmd:prepare_cmd_for_bo_escape(ForBo, PlayerBo);
%     todo;

%%四个新增的buff实现，额外扣血，加血，加怒气
apply_buff_eff_to_bo(?BFN_HEAL_HP_AT_ONCE, BoId, NewBuff) ->
  FromBoId = lib_bo_buff:get_from_bo_id(NewBuff),
  ?DEBUG_MSG("NewBuffSpecial ~p ~n",[NewBuff]),
  HealValue = lib_bo_buff:get_eff_real_value(NewBuff),
  lib_bo:add_hp(BoId, HealValue),
  lib_bo:remove_buff(BoId, NewBuff),
  %%是这两个B就不需要计算他们的死亡和重生了以及其他情况
  {BeAttBo1,BeattBo2} = case get(is_be_att) of
                          undefined ->
                            {0,0};
                          HavaBeatt ->
                            HavaBeatt
                        end,

  BuffEff2 =
    case get(extra_buff_eff) of
      undefined ->
        [];
      BuffEff ->
        BuffEff
    end,
  case BoId == BeAttBo1 orelse  BoId == BeattBo2  of
    true ->
      put(extra_buff_eff,[#additional_dtl{boid = BoId, type = 1 , dam_hp = HealValue} | BuffEff2]);
    false ->
      %%判断玩家是否重生
      RebornDtl =  mod_battle:try_apply_reborn_eff(BoId),
      IsReborn =
        case RebornDtl#reborn_dtl.is_reborn_applied of
          true ->
            1;
          false ->
            0
        end,
      {HpLeft, DieDtl} =  mod_battle:check_and_handle_bo_die(get_bo_by_id(BoId), get_bo_by_id(FromBoId)),
      put(extra_buff_eff,[ #additional_dtl{boid = BoId, type = 1 , dam_hp = HealValue, be_bo_is_apply_reborn = IsReborn,bo_hp_left = HpLeft, be_bo_dieStatus = DieDtl#die_details.die_status} |  BuffEff2]
      )
  end;
apply_buff_eff_to_bo(?BFN_HURT_HP_AT_ONCE, BoId, NewBuff) ->
  FromBoId = lib_bo_buff:get_from_bo_id(NewBuff),
  ?DEBUG_MSG("NewBuffSpecial ~p ~n",[NewBuff]),
  HealValue = lib_bo_buff:get_eff_real_value(NewBuff),
  lib_bo:add_hp(BoId, -HealValue),
  lib_bo:remove_buff(BoId, NewBuff),
  %%是这两个B就不需要计算他们的死亡和重生了以及其他情况
  {BeAttBo1,BeattBo2} = case get(is_be_att) of
    undefined ->
      {0,0};
    HavaBeatt ->
      HavaBeatt
  end,

  BuffEff2 =
    case get(extra_buff_eff) of
      undefined ->
        [];
      BuffEff ->
        BuffEff
    end,
  case BoId == BeAttBo1 orelse  BoId == BeattBo2  of
    true ->
      put(extra_buff_eff,[#additional_dtl{boid = BoId, type = 2 , dam_hp = HealValue} | BuffEff2]);
    false ->
      %%判断玩家是否重生
      RebornDtl =  mod_battle:try_apply_reborn_eff(BoId),
      IsReborn =
        case RebornDtl#reborn_dtl.is_reborn_applied of
          true ->
            1;
          false ->
            0
        end,
      {HpLeft, DieDtl} =  mod_battle:check_and_handle_bo_die(get_bo_by_id(BoId), get_bo_by_id(FromBoId)),
      put(extra_buff_eff,[ #additional_dtl{boid = BoId, type = 2 , dam_hp = HealValue, be_bo_is_apply_reborn = IsReborn,bo_hp_left = HpLeft, be_bo_dieStatus = DieDtl#die_details.die_status} |  BuffEff2]
      )
        end;
%%  %%判断玩家是否重生
%%  RebornDtl = mod_battle:try_apply_reborn_eff(BoId),
%%  IsReborn =
%%    case RebornDtl#reborn_dtl.is_reborn_applied of
%%      true ->
%%        1;
%%      false ->
%%        0
%%    end,
%%
%%
%%  {HpLeft, DieDtl} = mod_battle:check_and_handle_bo_die(get_bo_by_id(BoId), get_bo_by_id(FromBoId)),
%%
%%  put(extra_buff_eff, [ #additional_dtl{boid = BoId, type = 2 , dam_hp = HealValue, be_bo_is_apply_reborn = IsReborn,bo_hp_left = HpLeft, be_bo_dieStatus = DieDtl#die_details.die_status}|BuffEff2]),
%%  [ #additional_dtl{boid = BoId, type = 2 , dam_hp = HealValue, be_bo_is_apply_reborn = IsReborn,bo_hp_left = HpLeft, be_bo_dieStatus = DieDtl#die_details.die_status}|BuffEff2];

apply_buff_eff_to_bo(?BFN_HEAL_ANGER_AT_ONCE, BoId, NewBuff) ->
  FromBoId = lib_bo_buff:get_from_bo_id(NewBuff),
  ?DEBUG_MSG("NewBuffSpecial ~p ~n",[NewBuff]),
  HealValue = lib_bo_buff:get_eff_real_value(NewBuff),
  lib_bo:add_anger(BoId, HealValue),
  lib_bo:remove_buff(BoId, NewBuff),
  %%是这两个B就不需要计算他们的死亡和重生了以及其他情况
  {BeAttBo1,BeattBo2} = case get(is_be_att) of
                          undefined ->
                            {0,0};
                          HavaBeatt ->
                            HavaBeatt
                        end,

  BuffEff2 =
    case get(extra_buff_eff) of
      undefined ->
        [];
      BuffEff ->
        BuffEff
    end,
  case BoId == BeAttBo1 orelse  BoId == BeattBo2  of
    true ->
      put(extra_buff_eff,[#additional_dtl{boid = BoId, type = 3 , dam_hp = HealValue} | BuffEff2]);
    false ->
      %%判断玩家是否重生
      RebornDtl =  mod_battle:try_apply_reborn_eff(BoId),
      IsReborn =
        case RebornDtl#reborn_dtl.is_reborn_applied of
          true ->
            1;
          false ->
            0
        end,
      {HpLeft, DieDtl} =  mod_battle:check_and_handle_bo_die(get_bo_by_id(BoId), get_bo_by_id(FromBoId)),
      put(extra_buff_eff,[ #additional_dtl{boid = BoId, type = 3 , dam_hp = HealValue, be_bo_is_apply_reborn = IsReborn,bo_hp_left = HpLeft, be_bo_dieStatus = DieDtl#die_details.die_status} |  BuffEff2]
      )
  end;

apply_buff_eff_to_bo(?BFN_HURT_ANGER_AT_ONCE, BoId, NewBuff) ->
  FromBoId = lib_bo_buff:get_from_bo_id(NewBuff),
  ?DEBUG_MSG("NewBuffSpecial ~p ~n",[NewBuff]),
  HealValue = lib_bo_buff:get_eff_real_value(NewBuff),
  NewBo = lib_bo:add_anger(BoId, -HealValue),
  lib_bo:remove_buff(BoId, NewBuff),
  %%是这两个B就不需要计算他们的死亡和重生了以及其他情况 wjc
  {BeAttBo1,BeattBo2} = case get(is_be_att) of
                          undefined ->
                            {0,0};
                          HavaBeatt ->
                            HavaBeatt
                        end,

  BuffEff2 =
    case get(extra_buff_eff) of
      undefined ->
        [];
      BuffEff ->
        BuffEff
    end,
  case BoId == BeAttBo1 orelse  BoId == BeattBo2  of
    true ->
      put(extra_buff_eff,[#additional_dtl{boid = BoId, type = 4 , dam_hp = HealValue, bo_hp_left =NewBo#battle_obj.attrs#attrs.anger } | BuffEff2]);
    false ->
      %%判断玩家是否重生
      RebornDtl =  mod_battle:try_apply_reborn_eff(BoId),
      IsReborn =
        case RebornDtl#reborn_dtl.is_reborn_applied of
          true ->
            1;
          false ->
            0
        end,
      {_HpLeft, DieDtl} =  mod_battle:check_and_handle_bo_die(get_bo_by_id(BoId), get_bo_by_id(FromBoId)),
      put(extra_buff_eff,[ #additional_dtl{boid = BoId, type = 4 , dam_hp = HealValue, be_bo_is_apply_reborn = IsReborn,bo_hp_left = NewBo#battle_obj.attrs#attrs.anger, be_bo_dieStatus = DieDtl#die_details.die_status} |  BuffEff2]
      )
  end;


apply_buff_eff_to_bo(_BuffName, _BoId, _NewBuff) ->
  skip.




cleanup_buff_eff_from_bo(BoId, BuffToRemove) ->
    % ?DEBUG_MSG("cleanup_buff_eff_from_bo(), BoId=~p, BuffNo=~p, BuffName=~p",
    %                 [BoId, lib_bo_buff:get_no(BuffToRemove), lib_bo_buff:get_name(BuffToRemove)]),
    BuffName = lib_bo_buff:get_name(BuffToRemove),
  Bo = get_bo_by_id(BoId),
  BuffNames = Bo#battle_obj.eff_buff_name,
  ?DEBUG_MSG("testFiveElement ~p~n",[BuffNames]),
  ElementCoef=
    case lists:keyfind(BuffName,1,BuffNames) of
    {_,ElementCoef2} ->
      ElementCoef2;
    false ->
      1
  end,

  %% 更新五行效果  降低对方的暂时不写,有些无法归纳有比较少见的也先不写
  BuffNameList =
    [
      {?BFN_TRANS_PHY_DEF_TO_PHY_ATT,1},
      {?BFN_TRANS_PHY_MAG_DEF_TO_PHY_ATT,1},
      {?BFN_ADD_PHY_ATT , 1},
      {?BFN_ADD_MAG_ATT , 1},
      {?BFN_ADD_BE_PHY_DAM_SHRINK, 1},
      {?BFN_ADD_BE_MAG_DAM_SHRINK,1},
      {?BFN_ADD_PHY_DEF,1},
      {?BFN_ADD_MAG_DEF,1},
      {?BFN_ADD_PHY_MAG_DEF, 0},
      {?BFN_ADD_DODGE, 1},
      {?BFN_ADD_CRIT, 1},
      {?BFN_ADD_PHY_CRIT,1},
      {?BFN_ADD_MAG_CRIT,1},
      {?BFN_ADD_ACT_SPEED,1},
      {?BFN_YOUYING_MINGWANG,1},
      {?BFN_ADD_SEAL_RESIS,1},
      {?BFN_ADD_SEAL_HIT,1},
      {?BFN_ADD_BE_PHY_DAM_REDUCE_COEF,1},
      {?BFN_ADD_BE_MAG_DAM_REDUCE_COEF, 1},
      {?BFN_ADD_DO_PHY_DAM_SCALING,1},
      {?BFN_ADD_DO_MAG_DAM_SCALING,1},
      {?BFN_ADD_DO_DAM_SCALING, 1},
      {?BFN_ADD_BE_HEAL_EFF_COEF, 1},
      {?BFN_ADD_RET_DAM_COEF,1},
      {?BFN_ABSORB_HP_COEF, 1},
      {?BFN_ADD_CRIT_COEF, 1},
      {?BFN_ANTI_INVISIBLE_AND_ADD_PHY_MAG_ATT,0}
    ],

  case lists:keyfind(BuffName,1, BuffNameList) of
    false ->
      cleanup_buff_eff_from_bo(BuffName, BoId, BuffToRemove);
    {_, Type} ->
      case Type of
        0 ->

          OldValue = BuffToRemove#bo_buff.eff_para#buff_eff_para.eff_real_value,
          OldValue2 = BuffToRemove#bo_buff.eff_para#buff_eff_para.eff_real_value_2,
          NewBuff2 = BuffToRemove#bo_buff{eff_para = #buff_eff_para{ eff_real_value =(ElementCoef * OldValue ) , eff_real_value_2 =(ElementCoef * OldValue2 + OldValue2) }},
          cleanup_buff_eff_from_bo(BuffName, BoId, NewBuff2);
        1 ->

          OldValue = BuffToRemove#bo_buff.eff_para#buff_eff_para.eff_real_value,
          NewBuff2 = BuffToRemove#bo_buff{eff_para = #buff_eff_para{eff_real_value =(ElementCoef * OldValue )}},
          cleanup_buff_eff_from_bo(BuffName, BoId, NewBuff2)

      end
  end.


cleanup_buff_eff_from_bo(?BFN_TMP_MARK_DO_DAM_BY_DEFER_HP_RATE_WITH_LIMIT, BoId, _BuffToRemove) ->

  lib_bo:tmp_mark_do_dam_by_defer_hp_rate_with_limit(BoId, invalid),
  void;

cleanup_buff_eff_from_bo(?BFN_TMP_FORCE_SET_PHY_COMBO_ATT_TIMES, BoId, _BuffToRemove) ->
  lib_bo:set_tmp_force_phy_combo_att_proba(BoId, invalid), % 设为必定触发
  lib_bo:set_tmp_force_max_phy_combo_att_times(BoId, invalid),
  void;

% 临时强行设置追击概率
cleanup_buff_eff_from_bo(?BFN_TMP_FORCE_SET_PURSUE_ATT_PROBA, BoId, _BuffToRemove) ->
  lib_bo:set_tmp_force_pursue_att_proba(BoId, invalid),
  void;

% 临时强行设置追击次数上限
cleanup_buff_eff_from_bo(?BFN_TMP_FORCE_SET_MAX_PURSUE_ATT_TIMES, BoId, _BuffToRemove) ->
  lib_bo:set_tmp_force_max_pursue_att_times(BoId, invalid),
  void;

% 临时强行设置追击伤害系数
cleanup_buff_eff_from_bo(?BFN_TMP_FORCE_SET_PURSUE_ATT_DAM_COEF, BoId, _BuffToRemove) ->
  lib_bo:set_tmp_force_pursue_att_dam_coef(BoId, invalid),
  void;


cleanup_buff_eff_from_bo(?BFN_TRANS_PHY_DEF_TO_PHY_ATT, BoId, BuffToRemove) ->
    % 加回原先所减的物防
    Bo = get_bo_by_id(BoId),
    {rate, PhyRate, AttRate} = lib_bo_buff:get_buff_tpl_para(BuffToRemove),

    PhyDef_Trans = erlang:round(get_init_phy_def(Bo) * PhyRate),
    add_phy_def(BoId, PhyDef_Trans),

    % 减去原先所加的物攻
    EffRealVal = util:ceil(PhyDef_Trans * AttRate),
    ?ASSERT(util:is_positive_int(EffRealVal), EffRealVal),
    add_phy_att(BoId, - EffRealVal),
    ?BT_LOG( io_lib:format("cleanup BFN_TRANS_PHY_DEF_TO_PHY_ATT, BoId=~p, PhyDef_Trans=~p, EffRealVal=~p, OldPhyAtt=~p, OldPhyDef=~p, NewPhyAtt=~p, NewPhyDef=~p~n",
                    [BoId, PhyDef_Trans, EffRealVal,
                        get_phy_att(Bo), get_phy_def(Bo),
                        get_phy_att(get_bo_by_id(BoId)), get_phy_def(get_bo_by_id(BoId))]) ),
    void;

cleanup_buff_eff_from_bo(?BFN_TRANS_MAG_DEF_TO_MAG_ATT, BoId, BuffToRemove) ->
  % 加回原先所减的物防
  Bo = get_bo_by_id(BoId),
  {rate, MagRate, AttRate} = lib_bo_buff:get_buff_tpl_para(BuffToRemove),

  MagDef_Trans = erlang:round(get_init_mag_def(Bo) * MagRate),
  add_mag_def(BoId, MagDef_Trans),

  % 减去原先所加的物攻
  EffRealVal = util:ceil(MagDef_Trans * AttRate),
  ?ASSERT(util:is_positive_int(EffRealVal), EffRealVal),
  add_mag_att(BoId, - EffRealVal),
  void;


cleanup_buff_eff_from_bo(?BFN_TRANS_PHY_MAG_DEF_TO_PHY_ATT, BoId, BuffToRemove) ->
    Bo = get_bo_by_id(BoId),
    {rate, Rate} = lib_bo_buff:get_buff_tpl_para(BuffToRemove),
    ?ASSERT(Rate > 0 andalso Rate =< 1, {Rate, BuffToRemove}),
    PhyDef_Trans = erlang:round(get_init_phy_def(Bo) * Rate),
    MagDef_Trans = erlang:round(get_init_mag_def(Bo) * Rate),
    add_phy_def(BoId, PhyDef_Trans),
    add_mag_def(BoId, MagDef_Trans),

    EffRealVal = lib_bo_buff:get_eff_real_value(BuffToRemove),
    ?ASSERT(util:is_positive_int(EffRealVal), EffRealVal),
    add_phy_att(BoId, - EffRealVal),

    ?BT_LOG( io_lib:format("apply BFN_TRANS_PHY_MAG_DEF_TO_PHY_ATT, BoId=~p, PhyDef_Trans=~p, MagDef_Trans=~p, EffRealVal=~p, OldPhyAtt=~p, OldPhyDef=~p, OldMagDef=~p, NewPhyAtt=~p, NewPhyDef=~p, NewMagDef=~p~n",
                            [BoId, PhyDef_Trans, MagDef_Trans, EffRealVal,
                             get_phy_att(Bo), get_phy_def(Bo), get_mag_def(Bo),
                             get_phy_att(get_bo_by_id(BoId)), get_phy_def(get_bo_by_id(BoId)), get_mag_def(get_bo_by_id(BoId))
                            ]
                          )
           ),
    void;


cleanup_buff_eff_from_bo(?BFN_ADD_PHY_ATT, BoId, BuffToRemove) ->
    EffRealVal = lib_bo_buff:get_eff_real_value(BuffToRemove),
    % ?ASSERT(util:is_positive_int(EffRealVal), EffRealVal),
    add_phy_att(BoId, - EffRealVal);


cleanup_buff_eff_from_bo(?BFN_ADD_MAG_ATT, BoId, BuffToRemove) ->
    EffRealVal = lib_bo_buff:get_eff_real_value(BuffToRemove),
    % ?ASSERT(util:is_positive_int(EffRealVal), EffRealVal),
    add_mag_att(BoId, - EffRealVal);


cleanup_buff_eff_from_bo(?BFN_ADD_BE_PHY_DAM_SHRINK, BoId, BuffToRemove) ->
    EffRealVal = lib_bo_buff:get_eff_real_value(BuffToRemove),
    % ?ASSERT(util:is_positive_int(EffRealVal), EffRealVal),
    add_be_phy_dam_shrink(BoId, - EffRealVal);


cleanup_buff_eff_from_bo(?BFN_ADD_BE_MAG_DAM_SHRINK, BoId, BuffToRemove) ->
    EffRealVal = lib_bo_buff:get_eff_real_value(BuffToRemove),
    % ?ASSERT(util:is_positive_int(EffRealVal), EffRealVal),
    add_be_mag_dam_shrink(BoId, - EffRealVal);


cleanup_buff_eff_from_bo(?BFN_ADD_PHY_DEF, BoId, BuffToRemove) ->
    EffRealVal = lib_bo_buff:get_eff_real_value(BuffToRemove),
    ?ASSERT(util:is_positive_int(EffRealVal), EffRealVal),
    add_phy_def(BoId, - EffRealVal);


cleanup_buff_eff_from_bo(?BFN_ADD_MAG_DEF, BoId, BuffToRemove) ->
    EffRealVal = lib_bo_buff:get_eff_real_value(BuffToRemove),
    ?ASSERT(util:is_positive_int(EffRealVal), EffRealVal),
    add_mag_def(BoId, - EffRealVal);


cleanup_buff_eff_from_bo(?BFN_ADD_PHY_MAG_DEF, BoId, BuffToRemove) ->
    EffRealVal = lib_bo_buff:get_eff_real_value(BuffToRemove),
    EffRealVal_2 = lib_bo_buff:get_eff_real_value_2(BuffToRemove),
    ?ASSERT(is_integer(EffRealVal), EffRealVal),
    ?ASSERT(is_integer(EffRealVal_2), EffRealVal_2),

    add_phy_def(BoId, - EffRealVal),
    add_mag_def(BoId, - EffRealVal_2);


cleanup_buff_eff_from_bo(?BFN_REDUCE_PHY_ATT, BoId, BuffToRemove) ->
    EffRealVal = lib_bo_buff:get_eff_real_value(BuffToRemove),
    ?ASSERT(util:is_positive_int(EffRealVal), EffRealVal),
    add_phy_att(BoId, EffRealVal);


cleanup_buff_eff_from_bo(?BFN_REDUCE_MAG_ATT, BoId, BuffToRemove) ->
    EffRealVal = lib_bo_buff:get_eff_real_value(BuffToRemove),
    ?ASSERT(util:is_positive_int(EffRealVal), EffRealVal),
    add_mag_att(BoId, EffRealVal);


cleanup_buff_eff_from_bo(?BFN_REDUCE_TEN, BoId, BuffToRemove) ->
    EffRealVal = lib_bo_buff:get_eff_real_value(BuffToRemove),
    ?ASSERT(util:is_positive_int(EffRealVal), EffRealVal),
    add_ten(BoId, EffRealVal);


cleanup_buff_eff_from_bo(?BFN_REDUCE_PHY_DEF, BoId, BuffToRemove) ->
    EffRealVal = lib_bo_buff:get_eff_real_value(BuffToRemove),
    ?ASSERT(util:is_nonnegative_int(EffRealVal), EffRealVal),
    ?BT_LOG(io_lib:format("cleanup_buff_eff_from_bo, BFN_REDUCE_PHY_DEF, BoId=~p, EffRealVal=~p~n", [BoId, EffRealVal])),
    add_phy_def(BoId, EffRealVal);


cleanup_buff_eff_from_bo(?BFN_REDUCE_PHY_DEF_BY_RATE, BoId, BuffToRemove) ->
    Bo = get_bo_by_id(BoId),
    ReduceRate = lib_bo_buff:get_buff_tpl_para(BuffToRemove),
    ?ASSERT(ReduceRate >= 0 andalso ReduceRate =< 1, {ReduceRate, BuffToRemove}),
    InitPhyDef = get_init_phy_def(Bo),
    ReduceVal = round(InitPhyDef * ReduceRate),
    add_phy_def(BoId, ReduceVal);

cleanup_buff_eff_from_bo(?BFN_ADD_PHY_DEF_BY_RATE, BoId, BuffToRemove) ->
  Bo = get_bo_by_id(BoId),
  ReduceRate = lib_bo_buff:get_buff_tpl_para(BuffToRemove),
  ?ASSERT(ReduceRate >= 0 andalso ReduceRate =< 1, {ReduceRate, BuffToRemove}),
  InitPhyDef = get_init_phy_def(Bo),
  ReduceVal = round(InitPhyDef * ReduceRate),
  add_phy_def(BoId, -ReduceVal);


cleanup_buff_eff_from_bo(?BFN_REDUCE_MAG_ATT_BY_RATE, BoId, BuffToRemove) ->
  Bo = get_bo_by_id(BoId),
  ReduceRate = lib_bo_buff:get_buff_tpl_para(BuffToRemove),
  ?ASSERT(ReduceRate >= 0 andalso ReduceRate =< 1, {ReduceRate, BuffToRemove}),
  InitPhyDef = get_init_mag_att(Bo),
  ReduceVal = round(InitPhyDef * ReduceRate),
  add_mag_att(BoId, ReduceVal);

cleanup_buff_eff_from_bo(?BFN_ADD_MAG_ATT_BY_RATE, BoId, BuffToRemove) ->
  Bo = get_bo_by_id(BoId),
  ReduceRate = lib_bo_buff:get_buff_tpl_para(BuffToRemove),
  ?ASSERT(ReduceRate >= 0 andalso ReduceRate =< 1, {ReduceRate, BuffToRemove}),
  InitPhyDef = get_init_mag_att(Bo),
  ReduceVal = round(InitPhyDef * ReduceRate),
  add_mag_att(BoId, -ReduceVal);

cleanup_buff_eff_from_bo(?BFN_REDUCE_PHY_ATT_BY_RATE, BoId, BuffToRemove) ->
  Bo = get_bo_by_id(BoId),
  ReduceRate = lib_bo_buff:get_buff_tpl_para(BuffToRemove),
  ?ASSERT(ReduceRate >= 0 andalso ReduceRate =< 1, {ReduceRate, BuffToRemove}),
  InitPhyDef = get_init_phy_att(Bo),
  ReduceVal = round(InitPhyDef * ReduceRate),
  add_phy_att(BoId, ReduceVal);

cleanup_buff_eff_from_bo(?BFN_ADD_PHY_ATT_BY_RATE, BoId, BuffToRemove) ->
  Bo = get_bo_by_id(BoId),
  ReduceRate = lib_bo_buff:get_buff_tpl_para(BuffToRemove),
  ?ASSERT(ReduceRate >= 0 andalso ReduceRate =< 1, {ReduceRate, BuffToRemove}),
  InitPhyDef = get_init_phy_att(Bo),
  ReduceVal = round(InitPhyDef * ReduceRate),
  add_phy_att(BoId, -ReduceVal);

cleanup_buff_eff_from_bo(?BFN_ADD_SEAL_HIT_BY_RATE, BoId, BuffToRemove) ->
  Bo = get_bo_by_id(BoId),
  Rate = lib_bo_buff:get_buff_tpl_para(BuffToRemove),
  InitSealHit = get_init_seal_hit(Bo),
  Val = round(InitSealHit * Rate),
  add_seal_hit(BoId, -Val);

cleanup_buff_eff_from_bo(?BFN_REDUCE_SEAL_RESIS_BY_RATE, BoId, BuffToRemove) ->
  Bo = get_bo_by_id(BoId),
  Rate = lib_bo_buff:get_buff_tpl_para(BuffToRemove),
  InitSealResis = get_init_seal_resis(Bo),
  Val = round(InitSealResis * Rate),
  add_seal_resis(BoId, Val);

cleanup_buff_eff_from_bo(?BFN_REDUCE_HEAL_EFF_COEF, BoId, BuffToRemove) ->
  ReduceRate = lib_bo_buff:get_buff_tpl_para(BuffToRemove),
  ?ASSERT(ReduceRate >= 0 andalso ReduceRate =< 1, {ReduceRate, BuffToRemove}),
  add_heal_eff_coef(BoId, ReduceRate);

cleanup_buff_eff_from_bo(?BFN_ADD_HEAL_EFF_COEF, BoId, BuffToRemove) ->
  ReduceRate = lib_bo_buff:get_buff_tpl_para(BuffToRemove),
  ?ASSERT(ReduceRate >= 0 andalso ReduceRate =< 1, {ReduceRate, BuffToRemove}),
  add_heal_eff_coef(BoId, -ReduceRate);

cleanup_buff_eff_from_bo(?BFN_ADD_REVIVE_HEAL_COEF, BoId, BuffToRemove) ->
  ReduceRate = lib_bo_buff:get_buff_tpl_para(BuffToRemove),
  add_revive_heal_coef(BoId, -ReduceRate);

cleanup_buff_eff_from_bo(?BFN_REDUCE_PURSUE_ATT_DAM_COEF, BoId, BuffToRemove) ->
  ReduceRate = lib_bo_buff:get_buff_tpl_para(BuffToRemove),
  add_reduce_purse_att_dam_coef(BoId, -ReduceRate);


cleanup_buff_eff_from_bo(?BFN_REDUCE_MAG_CRIT_COEF, BoId, BuffToRemove) ->
  ReduceRate = lib_bo_buff:get_buff_tpl_para(BuffToRemove),
  add_mag_crit_coef(BoId, ReduceRate);

cleanup_buff_eff_from_bo(?BFN_REDUCE_PHY_CRIT_COEF, BoId, BuffToRemove) ->
  ReduceRate = lib_bo_buff:get_buff_tpl_para(BuffToRemove),
  add_phy_crit_coef(BoId, ReduceRate);

cleanup_buff_eff_from_bo(?BFN_ADD_MAG_CRIT_COEF, BoId, BuffToRemove) ->
  ReduceRate = lib_bo_buff:get_buff_tpl_para(BuffToRemove),
  add_mag_crit_coef(BoId, -ReduceRate);

cleanup_buff_eff_from_bo(?BFN_ADD_PHY_CRIT_COEF, BoId, BuffToRemove) ->
  ReduceRate = lib_bo_buff:get_buff_tpl_para(BuffToRemove),
  add_phy_crit_coef(BoId, -ReduceRate);



cleanup_buff_eff_from_bo(?BFN_ADD_ACT_SPEED_BY_RATE, BoId, BuffToRemove) ->
  Bo = get_bo_by_id(BoId),
  Rate = lib_bo_buff:get_buff_tpl_para(BuffToRemove),
  InitSealHit = get_init_act_speed(Bo),
  Val = round(InitSealHit * Rate),
  add_act_speed(BoId, -Val);


cleanup_buff_eff_from_bo(?BFN_REDUCE_ACT_SPEED_BY_RATE, BoId, BuffToRemove) ->
  Bo = get_bo_by_id(BoId),
  Rate = lib_bo_buff:get_buff_tpl_para(BuffToRemove),
  InitSealResis = get_init_act_speed(Bo),
  Val = round(InitSealResis * Rate),
  add_act_speed(BoId, Val);

cleanup_buff_eff_from_bo(?BFN_ADD_MAG_DEF_BY_RATE, BoId, BuffToRemove) ->
  Bo = get_bo_by_id(BoId),
  Rate = lib_bo_buff:get_buff_tpl_para(BuffToRemove),
  InitSealHit = get_init_mag_def(Bo),
  Val = round(InitSealHit * Rate),
  add_mag_def(BoId, -Val);


cleanup_buff_eff_from_bo(?BFN_REDUCE_MAG_DEF_BY_RATE, BoId, BuffToRemove) ->
  Bo = get_bo_by_id(BoId),
  Rate = lib_bo_buff:get_buff_tpl_para(BuffToRemove),
  InitSealResis = get_init_mag_def(Bo),
  Val = round(InitSealResis * Rate),
  add_mag_def(BoId, Val);






cleanup_buff_eff_from_bo(?BFN_ADD_SEAL_RESIS_BY_RATE, BoId, BuffToRemove) ->
  Bo = get_bo_by_id(BoId),
  Rate = lib_bo_buff:get_buff_tpl_para(BuffToRemove),
  InitSealResis = get_init_seal_resis(Bo),
  Val = round(InitSealResis * Rate),
  add_seal_resis(BoId, -Val);


cleanup_buff_eff_from_bo(?BFN_REDUCE_SEAL_HIT_BY_RATE, BoId, BuffToRemove) ->
  Bo = get_bo_by_id(BoId),
  Rate = lib_bo_buff:get_buff_tpl_para(BuffToRemove),
  InitSealHit = get_init_seal_hit(Bo),
  Val = round(InitSealHit * Rate),
  add_seal_hit(BoId, Val);



cleanup_buff_eff_from_bo(?BFN_REDUCE_MAG_DEF, BoId, BuffToRemove) ->
    EffRealVal = lib_bo_buff:get_eff_real_value(BuffToRemove),
    ?ASSERT(util:is_nonnegative_int(EffRealVal), EffRealVal),
    add_mag_def(BoId, EffRealVal);


cleanup_buff_eff_from_bo(?BFN_REDUCE_PHY_MAG_DEF, BoId, BuffToRemove) ->
    EffRealVal = lib_bo_buff:get_eff_real_value(BuffToRemove),
    EffRealVal_2 = lib_bo_buff:get_eff_real_value_2(BuffToRemove),
    ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BuffToRemove}),
    ?ASSERT(util:is_nonnegative_int(EffRealVal_2), {EffRealVal_2, BuffToRemove}),
    ?BT_LOG(io_lib:format("cleanup_buff_eff_from_bo, BFN_REDUCE_PHY_MAG_DEF, BoId=~p, EffRealVal=~p, EffRealVal_2=~p~n", [BoId, EffRealVal, EffRealVal_2])),
    add_phy_def(BoId, EffRealVal),
    add_mag_def(BoId, EffRealVal_2);


cleanup_buff_eff_from_bo(?BFN_WEAK, BoId, BuffToRemove) -> % 虚弱
    % 加回原先所减的物防
    EffRealVal = lib_bo_buff:get_eff_real_value(BuffToRemove),
    ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BoId, BuffToRemove}),
    add_phy_def(BoId, EffRealVal);



cleanup_buff_eff_from_bo(?BFN_ADD_DODGE, BoId, BuffToRemove) ->
    EffRealVal = lib_bo_buff:get_eff_real_value(BuffToRemove),
    ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BoId, BuffToRemove}),
    add_dodge(BoId, - EffRealVal);


cleanup_buff_eff_from_bo(?BFN_REDUCE_DODGE, BoId, BuffToRemove) ->
    EffRealVal = lib_bo_buff:get_eff_real_value(BuffToRemove),
    ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BoId, BuffToRemove}),
    add_dodge(BoId, EffRealVal);


cleanup_buff_eff_from_bo(?BFN_ADD_CRIT, BoId, BuffToRemove) ->
    EffRealVal = lib_bo_buff:get_eff_real_value(BuffToRemove),
    ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BoId, BuffToRemove}),
    add_crit(BoId, - EffRealVal);

cleanup_buff_eff_from_bo(?BFN_ADD_PHY_CRIT, BoId, BuffToRemove) ->
  EffRealVal = lib_bo_buff:get_eff_real_value(BuffToRemove),
  ?DEBUG_MSG("removeeff ~p~n",[EffRealVal]),
  ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BoId, BuffToRemove}),
  add_phy_crit(BoId, - EffRealVal);

cleanup_buff_eff_from_bo(?BFN_REDUCE_PHY_CRIT, BoId, BuffToRemove) ->
  EffRealVal = lib_bo_buff:get_eff_real_value(BuffToRemove),
  ?DEBUG_MSG("removeeff ~p~n",[EffRealVal]),
  ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BoId, BuffToRemove}),
  add_phy_crit(BoId, EffRealVal);

cleanup_buff_eff_from_bo(?BFN_ADD_PHY_TEN, BoId, BuffToRemove) ->
  EffRealVal = lib_bo_buff:get_eff_real_value(BuffToRemove),
  ?DEBUG_MSG("removeeff ~p~n",[EffRealVal]),
  ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BoId, BuffToRemove}),
  add_phy_ten(BoId, -EffRealVal);

cleanup_buff_eff_from_bo(?BFN_REDUCE_PHY_TEN, BoId, BuffToRemove) ->
  EffRealVal = lib_bo_buff:get_eff_real_value(BuffToRemove),
  ?DEBUG_MSG("removeeff ~p~n",[EffRealVal]),
  ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BoId, BuffToRemove}),
  add_phy_ten(BoId, EffRealVal);



cleanup_buff_eff_from_bo(?BFN_ADD_MAG_CRIT, BoId, BuffToRemove) ->
    EffRealVal = lib_bo_buff:get_eff_real_value(BuffToRemove),
    ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BoId, BuffToRemove}),
    add_mag_crit(BoId, - EffRealVal);


cleanup_buff_eff_from_bo(?BFN_REDUCE_MAG_CRIT, BoId, BuffToRemove) ->
  EffRealVal = lib_bo_buff:get_eff_real_value(BuffToRemove),
  ?DEBUG_MSG("removeeff ~p~n",[EffRealVal]),
  ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BoId, BuffToRemove}),
  add_mag_crit(BoId, EffRealVal);

cleanup_buff_eff_from_bo(?BFN_ADD_MAG_TEN, BoId, BuffToRemove) ->
  EffRealVal = lib_bo_buff:get_eff_real_value(BuffToRemove),
  ?DEBUG_MSG("removeeff ~p~n",[EffRealVal]),
  ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BoId, BuffToRemove}),
  add_mag_ten(BoId, -EffRealVal);

cleanup_buff_eff_from_bo(?BFN_REDUCE_MAG_TEN, BoId, BuffToRemove) ->
  EffRealVal = lib_bo_buff:get_eff_real_value(BuffToRemove),
  ?DEBUG_MSG("removeeff ~p~n",[EffRealVal]),
  ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BoId, BuffToRemove}),
  add_mag_ten(BoId, EffRealVal);


cleanup_buff_eff_from_bo(?BFN_ADD_STRIKEBACK_PROBA, BoId, BuffToRemove) ->
    {proba, AddProba} = lib_bo_buff:get_buff_tpl_para(BuffToRemove),
    ?ASSERT(util:is_positive_int(AddProba), BuffToRemove),
    add_strikeback_proba(BoId, - AddProba);


% TODO:  处理BFN_ADD_RET_DAM_PROBA
%          ...
cleanup_buff_eff_from_bo(?BFN_ADD_RET_DAM_PROBA, BoId, BuffToRemove) ->
    {proba, AddProba} = lib_bo_buff:get_buff_tpl_para(BuffToRemove),
    ?ASSERT(util:is_positive_int(AddProba), BuffToRemove),
    add_ret_dam_proba(BoId, - AddProba);


cleanup_buff_eff_from_bo(?BFN_ADD_PHY_COMBO_ATT_PROBA, BoId, BuffToRemove) ->
    {{proba, AddProba}, {max_combo_att_times, AddTimes}} = lib_bo_buff:get_buff_tpl_para(BuffToRemove),
    add_phy_combo_att_proba(BoId, - AddProba),
    add_max_phy_combo_att_times(BoId, - AddTimes);


cleanup_buff_eff_from_bo(?BFN_ADD_MAG_COMBO_ATT_PROBA, BoId, BuffToRemove) ->
    {{proba, AddProba}, {max_combo_att_times, AddTimes}} = lib_bo_buff:get_buff_tpl_para(BuffToRemove),
    add_mag_combo_att_proba(BoId, - AddProba),
    add_max_mag_combo_att_times(BoId, - AddTimes);


cleanup_buff_eff_from_bo(?BFN_ADD_ACT_SPEED, BoId, BuffToRemove) ->
    EffRealVal = lib_bo_buff:get_eff_real_value(BuffToRemove),
    ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BoId, BuffToRemove}),
    add_act_speed(BoId, - EffRealVal);


cleanup_buff_eff_from_bo(?BFN_REDUCE_ACT_SPEED, BoId, BuffToRemove) ->
    EffRealVal = lib_bo_buff:get_eff_real_value(BuffToRemove),
    ?ASSERT(util:is_positive_int(EffRealVal), {EffRealVal, BoId, BuffToRemove}),
    add_act_speed(BoId, EffRealVal);


cleanup_buff_eff_from_bo(?BFN_YOUYING_MINGWANG, BoId, BuffToRemove) ->
    EffRealVal = lib_bo_buff:get_eff_real_value(BuffToRemove),
    ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BoId, BuffToRemove}),
    add_act_speed(BoId, - EffRealVal);


cleanup_buff_eff_from_bo(?BFN_SHIXUE_MINGWANG, BoId, BuffToRemove) ->
    % 抗封能力
    EffRealVal = lib_bo_buff:get_eff_real_value(BuffToRemove),
    ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BoId, BuffToRemove}),
    add_seal_resis(BoId, - EffRealVal),
    % 吸血系数
    {{rate, Rate}, _} = lib_bo_buff:get_buff_tpl_para(BuffToRemove),
    add_absorb_hp_coef(BoId, - Rate);


cleanup_buff_eff_from_bo(?BFN_DALI_MINGWANG, BoId, BuffToRemove) ->
    % EffRealVal = lib_bo_buff:get_eff_real_value(BuffToRemove),
    % ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BoId, BuffToRemove}),
    % add_crit(BoId, - EffRealVal),
    % % 去掉大力冥王的物理攻击缩放效果
    % Scaling = lib_bo_buff:get_dlmw_add_phy_dam_scaling(BuffToRemove),
    % add_do_phy_dam_scaling(BoId, -Scaling);
    void;

cleanup_buff_eff_from_bo(?BFN_REDUCE_SEAL_RESIS, BoId, BuffToRemove) ->
    EffRealVal = lib_bo_buff:get_eff_real_value(BuffToRemove),
    ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BoId, BuffToRemove}),
    add_seal_resis(BoId, EffRealVal);


cleanup_buff_eff_from_bo(?BFN_ADD_SEAL_RESIS, BoId, NewBuff) ->
    % 加抗封能力
    EffRealVal = lib_bo_buff:get_eff_real_value(NewBuff),
    ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BoId, NewBuff}),
    add_seal_resis(BoId, -EffRealVal);

cleanup_buff_eff_from_bo(?BFN_ADD_NEGLECT_SEAL_RESIS, BoId, NewBuff) ->
  % 加抗封能力
  EffRealVal = lib_bo_buff:get_eff_real_value(NewBuff),
  ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BoId, NewBuff}),
  add_neglect_seal_resis(BoId, -EffRealVal);

cleanup_buff_eff_from_bo(?BFN_REDUCE_SEAL_HIT, BoId, BuffToRemove) ->
    EffRealVal = lib_bo_buff:get_eff_real_value(BuffToRemove),
    ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BoId, BuffToRemove}),
    add_seal_hit(BoId, EffRealVal);

cleanup_buff_eff_from_bo(?BFN_ADD_SEAL_HIT, BoId, NewBuff) ->
    % 加抗封能力
    EffRealVal = lib_bo_buff:get_eff_real_value(NewBuff),
    ?ASSERT(util:is_nonnegative_int(EffRealVal), {EffRealVal, BoId, NewBuff}),
    add_seal_hit(BoId, -EffRealVal);



cleanup_buff_eff_from_bo(?BFN_ADD_BE_PHY_DAM_REDUCE_COEF, BoId, BuffToRemove) ->
    AddRate = lib_bo_buff:get_eff_real_value(BuffToRemove),
    % ?ASSERT(AddRate > 0 andalso AddRate =< 1, {AddRate, BuffToRemove}),
    add_be_phy_dam_reduce_coef(BoId, - AddRate);


cleanup_buff_eff_from_bo(?BFN_ADD_BE_MAG_DAM_REDUCE_COEF, BoId, BuffToRemove) ->
    AddRate = lib_bo_buff:get_eff_real_value(BuffToRemove),
    % ?ASSERT(AddRate > 0 andalso AddRate =< 1, {AddRate, BuffToRemove}),
    add_be_mag_dam_reduce_coef(BoId, - AddRate);


cleanup_buff_eff_from_bo(?BFN_ADD_BE_DAM_REDUCE_COEF, BoId, BuffToRemove) ->
    % AddRate = lib_bo_buff:get_buff_tpl_para(BuffToRemove),
    AddRate = lib_bo_buff:get_eff_real_value(BuffToRemove),
    ?ASSERT(AddRate > 0 andalso AddRate =< 1, {AddRate, BuffToRemove}),
    add_be_phy_dam_reduce_coef(BoId, - AddRate),
    add_be_mag_dam_reduce_coef(BoId, - AddRate);


cleanup_buff_eff_from_bo(?BFN_REDUCE_BE_PHY_DAM_REDUCE_COEF, BoId, BuffToRemove) ->
    ReduceRate = lib_bo_buff:get_buff_tpl_para(BuffToRemove),
    ?ASSERT(ReduceRate > 0, {ReduceRate, BuffToRemove}),
    add_be_phy_dam_reduce_coef(BoId, ReduceRate);


cleanup_buff_eff_from_bo(?BFN_REDUCE_BE_MAG_DAM_REDUCE_COEF, BoId, BuffToRemove) ->
    ReduceRate = lib_bo_buff:get_buff_tpl_para(BuffToRemove),
    ?ASSERT(ReduceRate > 0, {ReduceRate, BuffToRemove}),
    add_be_mag_dam_reduce_coef(BoId, ReduceRate);

cleanup_buff_eff_from_bo(?BFN_REDUCE_BE_DAM_REDUCE_COEF, BoId, BuffToRemove) ->
  ReduceRate = lib_bo_buff:get_eff_real_value(BuffToRemove),
    ?ASSERT(ReduceRate > 0, {ReduceRate, BuffToRemove}),
    add_be_phy_dam_reduce_coef(BoId, ReduceRate),
    add_be_mag_dam_reduce_coef(BoId, ReduceRate);


cleanup_buff_eff_from_bo(?BFN_ADD_BMDR_COEF_BUT_REDUCE_BPDR_COEF, BoId, BuffToRemove) ->
    {{add, AddRate}, {reduce, ReduceRate}} = lib_bo_buff:get_buff_tpl_para(BuffToRemove),
    ?ASSERT(AddRate > 0 andalso AddRate =< 1, {AddRate, BuffToRemove}),
    ?ASSERT(ReduceRate > 0 andalso ReduceRate =< 1, {ReduceRate, BuffToRemove}),
    % 扣回原先所加的比例
    add_be_mag_dam_reduce_coef(BoId, - AddRate),
    % 加回原先所扣的比例
    add_be_phy_dam_reduce_coef(BoId, ReduceRate);


cleanup_buff_eff_from_bo(?BFN_ADD_BPDR_COEF_BUT_REDUCE_BMDR_COEF, BoId, BuffToRemove) ->
    {{add, AddRate}, {reduce, ReduceRate}} = lib_bo_buff:get_buff_tpl_para(BuffToRemove),
    ?ASSERT(AddRate > 0 andalso AddRate =< 1, {AddRate, BuffToRemove}),
    ?ASSERT(ReduceRate > 0 andalso ReduceRate =< 1, {ReduceRate, BuffToRemove}),
    % 扣回原先所加的比例
    add_be_phy_dam_reduce_coef(BoId, - AddRate),
    % 加回原先所扣的比例
    add_be_mag_dam_reduce_coef(BoId, ReduceRate);



cleanup_buff_eff_from_bo(?BFN_ADD_DO_PHY_DAM_SCALING, BoId, BuffToRemove) ->
    % AddRate = lib_bo_buff:get_buff_tpl_para(BuffToRemove),
    AddRate = lib_bo_buff:get_eff_real_value(BuffToRemove),
    % ?ASSERT(AddRate > 0, {AddRate, BuffToRemove}),
    % 扣去原先所加的值
    add_do_phy_dam_scaling(BoId, - AddRate);


cleanup_buff_eff_from_bo(?BFN_ADD_DO_MAG_DAM_SCALING, BoId, BuffToRemove) ->
    AddRate = lib_bo_buff:get_eff_real_value(BuffToRemove),
    ?ASSERT(AddRate > 0, {AddRate, BuffToRemove}),
    % 扣去原先所加的值
    add_do_mag_dam_scaling(BoId, - AddRate);


cleanup_buff_eff_from_bo(?BFN_ADD_DO_DAM_SCALING, BoId, BuffToRemove) ->
    AddRate = lib_bo_buff:get_eff_real_value(BuffToRemove),
    %?ASSERT(AddRate > 0, {AddRate, BuffToRemove}),
    % 扣去原先所加的值
    add_do_phy_dam_scaling(BoId, - AddRate),
    add_do_mag_dam_scaling(BoId, - AddRate);



cleanup_buff_eff_from_bo(?BFN_REDUCE_DO_PHY_DAM_SCALING, BoId, BuffToRemove) ->
    ReduceRate = lib_bo_buff:get_eff_real_value(BuffToRemove),
    % ?ASSERT(ReduceRate > 0, {ReduceRate, BuffToRemove}),
    % 加回原先所扣的值
    add_do_phy_dam_scaling(BoId, ReduceRate);


cleanup_buff_eff_from_bo(?BFN_REDUCE_DO_MAG_DAM_SCALING, BoId, BuffToRemove) ->
    ReduceRate = lib_bo_buff:get_eff_real_value(BuffToRemove),
    % ?ASSERT(ReduceRate > 0, {ReduceRate, BuffToRemove}),
    % 加回原先所扣的值
    add_do_mag_dam_scaling(BoId, ReduceRate);


cleanup_buff_eff_from_bo(?BFN_REDUCE_DO_DAM_SCALING, BoId, BuffToRemove) ->
    ReduceRate = lib_bo_buff:get_eff_real_value(BuffToRemove),
    % ?ASSERT(ReduceRate > 0, {ReduceRate, BuffToRemove}),
    % 加回原先所扣的值
    add_do_phy_dam_scaling(BoId, ReduceRate),
    add_do_mag_dam_scaling(BoId, ReduceRate);


cleanup_buff_eff_from_bo(?BFN_ADD_BE_HEAL_EFF_COEF, BoId, BuffToRemove) ->
    Rate = lib_bo_buff:get_eff_real_value(BuffToRemove),
    add_be_heal_eff_coef(BoId, - Rate);


% 清除增加反震程度buff
cleanup_buff_eff_from_bo(?BFN_ADD_RET_DAM_COEF, BoId, BuffToRemove) ->
    Rate = lib_bo_buff:get_eff_real_value(BuffToRemove),
    add_ret_dam_coef(BoId, - Rate);

cleanup_buff_eff_from_bo(?BFN_ABSORB_HP_COEF, BoId, BuffToRemove) ->
    Rate = lib_bo_buff:get_eff_real_value(BuffToRemove),
    add_absorb_hp_coef(BoId, - Rate);


    % 增加暴击系数BUFF清除
cleanup_buff_eff_from_bo(?BFN_ADD_CRIT_COEF, BoId, BuffToRemove) ->
    Rate = lib_bo_buff:get_eff_real_value(BuffToRemove),
    add_crit_coef(BoId,- Rate);

    % 减少暴击系数BUFF清除
cleanup_buff_eff_from_bo(?BFN_REDUCE_CRIT_COEF, BoId, BuffToRemove) ->
    Rate = lib_bo_buff:get_eff_real_value(BuffToRemove),
    add_crit_coef(BoId, Rate);


cleanup_buff_eff_from_bo(?BFN_REDUCE_BE_HEAL_EFF_COEF, BoId, BuffToRemove) ->
    Rate = lib_bo_buff:get_eff_real_value(BuffToRemove),
    add_be_heal_eff_coef(BoId, Rate);


cleanup_buff_eff_from_bo(?BFN_ANTI_INVISIBLE_AND_ADD_PHY_MAG_ATT, BoId, BuffToRemove) ->
    EffRealVal = lib_bo_buff:get_eff_real_value(BuffToRemove),
    EffRealVal_2 = lib_bo_buff:get_eff_real_value_2(BuffToRemove),
    ?ASSERT(is_integer(EffRealVal), EffRealVal),
    ?ASSERT(is_integer(EffRealVal_2), EffRealVal_2),
    add_phy_att(BoId, - EffRealVal),
    add_mag_att(BoId, - EffRealVal_2);


cleanup_buff_eff_from_bo(?BFN_BE_TAUNT, BoId, _BuffToRemove) ->
    % FromBoId = lib_bo_buff:get_from_bo_id(BuffToRemove),
    ?BT_LOG(io_lib:format("cleanup_buff_eff_from_bo, BFN_BE_TAUNT, BoId=~p, FromBoId=~p~n", [BoId, lib_bo_buff:get_from_bo_id(_BuffToRemove)])),
    set_he_who_taunt_me(BoId, ?INVALID_ID);

cleanup_buff_eff_from_bo(_BuffName, _BoId, _BuffToRemove) ->
    skip.


%% 替换buff
replace_old_buff(FromBoId, ToBoId, NewBuff, OldBuff) ->
    %%?DEBUG_MSG("~n~n....replace_old_buff(),  NewBuff: ~w, OldBuff: ~w", [NewBuff, OldBuff]),

    % OldBuffNo = lib_bo_buff:get_no(OldBuff),

    % 先移除旧的
    remove_buff(ToBoId, OldBuff),

    %%NewBo = get(BoId),

    % 再加新的
    do_add_buff(FromBoId, ToBoId, NewBuff).



%% 更新buff
update_buff(BoId, BuffNew) ->
    Bo = get_bo_by_id(BoId),
    BuffList = Bo#battle_obj.buffs,
    BuffNo = lib_bo_buff:get_no(BuffNew),
    BuffList2 = lists:keyreplace(BuffNo, #bo_buff.buff_no, BuffList, BuffNew),
    Bo2 = Bo#battle_obj{buffs = BuffList2},
    update_bo(Bo2),
    void.







% old:
%         % 数值*攻击
%         EffName == ?EN_PHY_ATT_ADD  % 提升xx点物理攻击
%         orelse EffName == ?EN_MAG_ATT_ADD -> % 提升xx点法术攻击
%           ?ASSERT(OverlapNum == 1, OverlapNum), % 目前断言不可叠加!
%           ?ASSERT(is_integer(TotalEffVal), NewBuff),  % 配置表中的效果值须填整数!
%           NewAtt = Bo#battle_obj.com_att + TotalEffVal,
%           {
%             TotalEffVal,
%             Bo#battle_obj{com_att = NewAtt}
%           };
%         EffName == ?EN_STU_ATT_ADD -> % 提升xx点绝技攻击
%           ?ASSERT(OverlapNum == 1, OverlapNum), % 目前断言不可叠加!
%           ?ASSERT(is_integer(TotalEffVal), NewBuff),  % 配置表中的效果值须填整数!
%           NewStuAtt = Bo#battle_obj.stu_att + TotalEffVal,
%           {
%             TotalEffVal,
%             Bo#battle_obj{stu_att = NewStuAtt}
%           };
%                 % 百分比*攻击
%                 EffName == ?EN_ADD_PHY_ATT_RATE_BY_BLOCK
%                   orelse EffName == ?EN_ADD_PHY_ATT_RATE_BY_DODGE
%                   orelse EffName == ?EN_PHY_ATT_ADD_RATE ->
%                     change_comm_att_by_buff(Bo, phy_att, TotalEffVal);
%                 EffName == ?EN_MAG_ATT_ADD_RATE ->
%                     change_comm_att_by_buff(Bo, mag_att, TotalEffVal);
% %%                 EffName == ?EN_STU_ATT_ADD_RATE ->
% %%                     SklAdd = lib_battle:get_dict_bo_skl_add(Bo#battle_obj.bo_id),
% %%                     BuffAdd = SklAdd#bo_skl_add.buff,
% %%
% %%                     NewBuffAdd = BuffAdd#batt_attr{ stu_att = BuffAdd#batt_attr.stu_att + TotalEffVal },
% %%                     lib_battle:set_dict_bo_skl_add_buff(Bo#battle_obj.bo_id, NewBuffAdd),
% %%                     {TotalEffVal, Bo};
%         EffName == ?EN_STU_ATT_ADD_RATE ->  % 提升xx%的绝技攻击
%           ?ASSERT(is_float(TotalEffVal), NewBuff),  % 配置表中的效果值须填小数!
%           OldAtt = Bo#battle_obj.stu_att,
%           NewAtt = OldAtt + util:ceil(Bo#battle_obj.init_stu_att * TotalEffVal),
%           {
%             NewAtt - OldAtt,
%             Bo#battle_obj{stu_att = NewAtt}
%           };
%         % 数值*防御
%         EffName == ?EN_PHY_DEF_ADD -> % 提升xx点物理防御
%           ?ASSERT(OverlapNum == 1, OverlapNum), % 目前断言不可叠加!
%           ?ASSERT(is_integer(TotalEffVal), NewBuff),  % 配置表中的效果值须填整数!
%           NewPhyDef = Bo#battle_obj.phy_def + TotalEffVal,
%           {
%             TotalEffVal,
%             Bo#battle_obj{phy_def = NewPhyDef}
%           };
%         EffName == ?EN_MAG_DEF_ADD ->   % 提升xx点法术防御
%           ?ASSERT(is_integer(TotalEffVal), NewBuff),  % 配置表中的效果值须填整数!
%           NewMagDef = Bo#battle_obj.mag_def + TotalEffVal,
%           {
%             TotalEffVal,
%             Bo#battle_obj{mag_def = NewMagDef}
%           };
%         EffName == ?EN_STU_DEF_ADD ->
%           ?ASSERT(is_integer(TotalEffVal), NewBuff),  % 配置表中的效果值须填整数!
%           NewStuDef = Bo#battle_obj.stu_def + TotalEffVal,
%           {
%             TotalEffVal,
%             Bo#battle_obj{stu_def = NewStuDef}
%           };
%                 % 百分比*防御
%         EffName == ?EN_PHY_DEF_ADD_RATE -> % 提升xx%的物理防御
%           ?ASSERT(is_float(TotalEffVal), NewBuff),  % 配置表中的效果值须填小数!
%           OldPhyDef = Bo#battle_obj.phy_def,
%           NewPhyDef = OldPhyDef + util:ceil(Bo#battle_obj.init_phy_def * TotalEffVal),
%           {
%             NewPhyDef - OldPhyDef,
%             Bo#battle_obj{phy_def = NewPhyDef}
%           };
%         EffName == ?EN_MAG_DEF_ADD_RATE -> % 提升xx%的法术防御
%           ?ASSERT(is_float(TotalEffVal), NewBuff),  % 配置表中的效果值须填小数!
%           OldMagDef = Bo#battle_obj.mag_def,
%           NewMagDef = OldMagDef + util:ceil(Bo#battle_obj.init_mag_def * TotalEffVal),
%           {
%             NewMagDef - OldMagDef,
%             Bo#battle_obj{mag_def = NewMagDef}
%           };
%         EffName == ?EN_STU_DEF_ADD_RATE -> % 提升xx%的绝技防御
%           ?ASSERT(is_float(TotalEffVal), NewBuff),  % 配置表中的效果值须填小数!
%           OldStuDef = Bo#battle_obj.stu_def,
%           NewStuDef = OldStuDef + util:ceil(Bo#battle_obj.init_stu_def * TotalEffVal),
%           {
%             NewStuDef - OldStuDef,
%             Bo#battle_obj{stu_def = NewStuDef}
%           };
%                 % 百分比*血上限
%         EffName == ?EN_HP_LIM_ADD_RATE ->  % 增加血上限
%           ?ASSERT(is_float(EffValue), NewBuff),  % 配置表中的效果值须填小数!
%           OldHpLim = Bo#battle_obj.hp_lim,
%           NewHpLim = OldHpLim + util:ceil(Bo#battle_obj.init_hp_lim * TotalEffVal),
%           Diff = NewHpLim - OldHpLim,
%           % 同时对应调整当前血量
%           NewHp = case Diff >= 0 of
%                 true ->
%                   Bo#battle_obj.hp + Diff;
%                 false ->
%                   min(Bo#battle_obj.hp, NewHpLim)
%               end,
%           {
%             Diff,
%             Bo#battle_obj{hp = NewHp, hp_lim = NewHpLim}
%           };
%                 EffName == ?EN_HP_ADD_RATE ->   % 持续加xx%当前血（以初始血量上限为基准）
%                     TAddHp = util:ceil(Bo#battle_obj.init_hp_lim * TotalEffVal),
%                     AddHp = min(Bo#battle_obj.hp_lim - Bo#battle_obj.hp, TAddHp),
%                     {
%                          AddHp,
%                          Bo#battle_obj{hp = Bo#battle_obj.hp + AddHp}
%                      };
%                 % 数值*增加血量
%                 EffName == ?EN_HP_ADD ->
%                     NewHp = util:minmax(Bo#battle_obj.hp + TotalEffVal, 1, Bo#battle_obj.hp_lim),
%                     NewBo1 = Bo#battle_obj{hp = NewHp},
%                     {TotalEffVal, NewBo1};
%         EffName == ?EN_ADD_DAM_RATE_BY_CRIT ->
%           ?ASSERT(is_float(TotalEffVal), NewBuff),  % 配置表中的效果值须填小数!
%           {TotalEffVal, Bo};
%         EffName == ?EN_BE_DAM_ADD_RATE ->
%           ?ASSERT(is_float(TotalEffVal), NewBuff),  % 配置表中的效果值须填小数!
%           {TotalEffVal, Bo};
%         EffName == ?EN_WARD_OFF_DAM_SHIELD ->
%           ?ASSERT(is_float(TotalEffVal), NewBuff),  % 配置表中的效果值须填小数!
%           {
%             util:ceil(Bo#battle_obj.init_hp_lim * TotalEffVal), % 勿忘做取整的处理!!!!
%             Bo
%           };
%                 EffName == ?EN_CRIT_RATE_ADD ->
%                     NewVal = Bo#battle_obj.buff_crit_rate_add + TotalEffVal,
%                     {
%                         TotalEffVal,
%                         Bo#battle_obj{buff_crit_rate_add = NewVal}
%                      };
%                 EffName == ?EN_EXTRA_DAM ->   % 每回合对对象造成伤害，保低血量1点
%                     NewHp = util:minmax(Bo#battle_obj.hp - TotalEffVal, 1, Bo#battle_obj.hp_lim),
%                     NewBo1 = Bo#battle_obj{hp = NewHp},
%                     {TotalEffVal, NewBo1};
%         EffName == ?EN_RETURN_DAM_SHIELD ->
%           ?ASSERT(is_integer(TotalEffVal), NewBuff),  % 配置表中的效果值须填整数!
%           {TotalEffVal, Bo};
%                 EffName == ?EN_FREEZE_ANGER_ADD ->   % 冻结怒气增长
%                     {TotalEffVal, Bo};
%                 % TODO: 测试下是否正确？
%                 EffName == ?EN_TRANS_DAM_TO_PHY_ATT -> % 将造成的伤害按百分比转换为自身的物理攻击力
%                     ?ASSERT(is_float(TotalEffVal), NewBuff),  % 配置表中的效果值须填小数!
%                     OldAtt = Bo#battle_obj.com_att,
%                     % 勿忘做取整的处理!!!!
%                     NewAtt = OldAtt + util:ceil(Bo#battle_obj.last_hit_dam * TotalEffVal),
%                     {
%                         NewAtt - OldAtt,
%                         Bo#battle_obj{com_att = NewAtt}
%                     };








% %% @desc: 移除战斗对象身上的一个buff
% %% @para: RmvReason => 移除buff的原因（详见buff.hrl中的宏）
% %% @para: BuffToRemove => #bo_buff结构体
% %% @para: Helper => 帮助战斗对象消除debuff的对象ID
% %% @return: 更新后的bo
% remove_buff_from_bo(BoId, BuffToRemove, RmvReason) ->
%     remove_buff_from_bo(BoId, BuffToRemove, RmvReason, 0).
% remove_buff_from_bo(BoId, BuffToRemove, RmvReason, HelperBoId) ->
%   ?ASSERT(is_record(BuffToRemove, bo_buff)),
%   Bo = get(BoId),
%   BuffList = Bo#battle_obj.buffs,
%   ?ASSERT(lists:member(BuffToRemove, BuffList)),
%   NewBuffList = BuffList -- [BuffToRemove],

%   % 还原bo的效果值
%   NewBo = recalc_bo_for_remove_buff(Bo, BuffToRemove),
%   NewBo2 = NewBo#battle_obj{buffs = NewBuffList},
%   % 更新到进程字典
%   put(BoId, NewBo2),
%   % 通知客户端
%   notify_bo_remove_buff(NewBo2, BuffToRemove, RmvReason, HelperBoId),

%   case need_notify_attr_changed(BuffToRemove) of
%         true -> notify_bo_attr_changed_to_all(NewBo2, ?ACR_REMOVE_BUFF);
%         false -> skip
%     end,
%   NewBo2.

% 按驱散规则驱散buff
% @return: {ok, RetPurgeBuffDtl#purge_buffs_dtl{}}
purge_buff(BoId, PurgeBuffRule) ->
%%    ?ASSERT(begin
%%                case PurgeBuffRule of
%%                    {by_no, _BuffNo, _Num} when is_integer(_BuffNo) andalso is_integer(_Num) -> true;
%%                    {by_category, _Category, _Num} when is_integer(_Category) andalso is_integer(_Num) -> true;
%%                    {by_eff_type, good, _Num} when is_integer(_Num) -> true;
%%                    {by_eff_type, bad, _Num} when is_integer(_Num) -> true;
%%                    {by_eff_type, neutral, _Num} when is_integer(_Num) -> true;
%%                    {by_no_list, _BuffNoList} when is_list(_BuffNoList) -> true;
%%                    _ -> false
%%                end
%%            end, {PurgeBuffRule}),

    TarBo = get_bo_by_id(BoId),
    ?ASSERT(TarBo /= null, BoId),
    PurgeBuffList = select_purge_buff_by_rule(PurgeBuffRule, TarBo),
    [remove_buff( id(TarBo), Buff) || Buff <- PurgeBuffList],
    BuffNoList = [Buff#bo_buff.buff_no || Buff <- PurgeBuffList],
    RetPurgeBuffDtl = #purge_buffs_dtl{
        atter_buffs_removed = [] % 攻击者被清除的buff，目前无用，暂时保留方便以后拓展
        ,defer_buffs_removed = BuffNoList
    },
    {ok, RetPurgeBuffDtl}.


select_purge_buff_by_rule({by_no_list, BuffNoList}, Bo) ->
    ?ASSERT(BuffNoList /= []),
    ?ASSERT(util:is_integer_list(BuffNoList), BuffNoList),
    BuffList = [rand_find_buff_by_no(Bo, X) || X <- BuffNoList],
    [X || X <- BuffList, X /= null];
select_purge_buff_by_rule({RuleType, X, SelectNum}, Bo) ->
    % 抽取符合条件的buff
    PurgeBuffList = case RuleType of
        by_no       -> find_buff_list_by_no(Bo, X);         %% 通过编号选取
        by_category -> find_buff_list_by_category(Bo, X);   %% 通过类别选取
        by_eff_type -> find_buff_list_by_eff_type(Bo, X);   %% 通过效果类型选取
        by_buff_name -> find_buff_list_by_buff_name(Bo, X); %% 通过buff名选取
        _ ->
            ?ASSERT(false, {RuleType, X, SelectNum, Bo}),
            []
    end,
    % 随机取要求的数量
    RandPurgeBuffList = util:shuffle(PurgeBuffList),
    case RandPurgeBuffList == [] of
        true -> [];
        false -> lists:sublist(RandPurgeBuffList, 1, SelectNum)
    end;
select_purge_buff_by_rule(_Rule, _Bo) ->
    ?ASSERT(false, {_Rule, _Bo}),
    [].


remove_buff(BoId, BuffToRemove) ->
    ?ASSERT(is_record(BuffToRemove, bo_buff)),

    % 清除先前应用到bo身上的buff效果
    cleanup_buff_eff_from_bo(BoId, BuffToRemove),

    Bo = get_bo_by_id(BoId),
    BuffList = Bo#battle_obj.buffs,
    ?ASSERT(lists:member(BuffToRemove, BuffList)),

    BuffNo = lib_bo_buff:get_no(BuffToRemove), %%BuffToRemove#bo_buff.buff_no,
    NewBuffList = lists:keydelete(BuffNo, #bo_buff.buff_no, BuffList),
    Bo2 = Bo#battle_obj{buffs = NewBuffList},
    update_bo(Bo2),

    void.





% 已作废！！
% %% !!!!!! TODO:  buff涉及的具体数值按公式算！！！！！！！！！！！！！！！！！！！

% %% 添加buff时重算bo的属性
% %% @return：{更新后的bo, 更新后的NewBuff}
% %% 注意：勿忘对一些情况的计算结果做必要的取整处理，因为这个数值有可能会通过协议发给客户端，如果
% %%       数值类型不对，则打包二进制数据消息包时会引发错误！！

% %% TODO: 确认：是否需要对一些数值结果做数值范围的矫正？？！!
% recalc_bo_for_buff_added(FromBo, ToBo, NewBuff) ->
%   % EffName = NewBuff#bo_buff.eff_name,

%     ?ASSERT(is_record(NewBuff, bo_buff), NewBuff),
%     ?DEBUG_MSG("~nrecalc_bo_for_buff_added(), BoId:~p, NewBuff:~p~n", [get_id(ToBo), NewBuff]),

%     BuffName = lib_bo_buff:get_name(NewBuff),

%     % _EffPara = NewBuff#bo_buff.eff_para,

%     % _CurOverlap = NewBuff#bo_buff.cur_overlap, % 当前的叠加层数

%     {ToBo2, NewBuff2} = recalc_bo_for_buff_added__(FromBo, ToBo, NewBuff, BuffName),

%     ?ASSERT(is_record(ToBo2, battle_obj), {ToBo2, BuffName}),
%     ?ASSERT(is_record(NewBuff2, bo_buff), {NewBuff2, BuffName}),
%     {ToBo2, NewBuff2}.



% recalc_bo_for_buff_added__(FromBo, ToBo, NewBuff, ?BFN_TRANS_PHY_DEF_TO_ATT_TILL_DIE) -> % 物防转为物攻
%     % 计算要转换的物防和物攻
%     case lib_bo_buff:get_eff_para(NewBuff) of
%         {rate_to_rate, Rate1, Rate2} ->
%             ?ASSERT(0 < Rate1 andalso Rate1 =< 1, {Rate1, NewBuff}),
%             ?ASSERT(0 < Rate2 andalso Rate2 =< 1, {Rate2, NewBuff}),
%             PhyDef_Sub = util:ceil( get_init_phy_def(ToBo) * Rate1 ),
%             PhyAtt_Add = util:ceil( get_init_phy_att(ToBo) * Rate2 );

%         _Any ->
%             ?ASSERT(false, _Any),
%             PhyDef_Sub = 0,
%             PhyAtt_Add = 0

%         % {int_to_int, Int1, Int2} ->
%         %     ?ASSERT(is_integer(Int1) andalso is_integer(Int2), {Int1, Int2, NewBuff}),
%         %     ?ASSERT(Int1 > 0 andalso Int2 > 0, {Int1, Int2, NewBuff}),
%         %     PhyDef_Sub = min( get_init_phy_def(Bo), Int1 ),  % 矫正！以避免超出bo当前的物防
%         %     PhyAtt_Add = Int2
%     end,

%     ToBoId = get_id(ToBo),
%     add_phy_def(ToBoId, - PhyDef_Sub), % 减物防
%     add_phy_att(ToBoId, PhyAtt_Add), % 加物攻

%     % 记录实际的效果值
%     NewBuff2 = NewBuff#bo_buff{
%                     eff_real_value = PhyDef_Sub,
%                     eff_real_value_2 = PhyAtt_Add
%                     },

%     ?DEBUG_MSG("~n@@recalc_bo_for_buff_added__(), BFN_TRANS_PHY_DEF_TO_ATT_TILL_DIE, CurRound=~p ToBoId=~p OldPhyDef=~p NewPhyDef=~p OldPhyAtt=~p NewPhyAtt=~p~n",
%                     [get_cur_round(), ToBoId,
%                     raw_get_phy_def__(ToBo), raw_get_phy_def__(get_bo_by_id(ToBoId)),
%                     raw_get_phy_att__(ToBo), raw_get_phy_att__(get_bo_by_id(ToBoId))]
%                     ),

%     {get_bo_by_id(ToBoId), NewBuff2};


% recalc_bo_for_buff_added__(FromBo, ToBo, NewBuff, _BuffName) ->
%     ToBoId = get_id(ToBo),

%     % 按公式计算实际的效果值
%     {EffRealVal, EffRealVal_2} = lib_bt_calc:calc_buff_eff_real_value(FromBo, ToBo, NewBuff),

%     ?DEBUG_MSG("~n@@recalc_bo_for_buff_added__(), default handler, CurRound=~p ToBoId=~p EffRealVal=~p EffRealVal_2=~p~n",
%                     [get_cur_round(), ToBoId, EffRealVal, EffRealVal_2]),



%     % 记录实际的效果值
%     NewBuff2 = NewBuff#bo_buff{
%                     eff_real_value = EffRealVal,
%                     eff_real_value_2 = EffRealVal_2
%                     },


%     {get_bo_by_id(ToBoId), NewBuff2}.















% %% 移除buff时还原战斗对象的相应属性
% %% 注意：需确保传入的参数Bo是当前最新的
% %% @return: 无用
% recalc_bo_for_buff_removed(Bo, BuffRemoved) ->
%     BuffName = lib_bo_buff:get_name(BuffRemoved),  %%#bo_buff.buff_name,
%     ?TRACE("~n~nrecalc_bo_for_buff_removed(), BoId:~p, BuffRemoved:~p~n", [id(Bo), BuffRemoved]),

%     ?DEBUG_MSG("recalc_bo_for_buff_removed(), boid: ~p, BuffName:~p, EffPara: ~p, CurOverlap: ~p",
%                 [Bo#battle_obj.id, BuffName, BuffRemoved#bo_buff.eff_para, BuffRemoved#bo_buff.cur_overlap]),

%     recalc_bo_for_buff_removed__(Bo, BuffRemoved, BuffName),
%     void.


% recalc_bo_for_buff_removed__(Bo, BuffRemoved, ?BFN_TRANS_PHY_DEF_TO_ATT_TILL_DIE) -> % 物防转为物攻
%     PhyDef_Subed = lib_bo_buff:get_eff_real_value(BuffRemoved), %%#bo_buff.eff_real_value,   % 原先被扣的物防
%     PhyAtt_Added = lib_bo_buff:get_eff_real_value_2(BuffRemoved),  %%#bo_buff.eff_real_value_2, % 原先增加的物攻

%     ?ASSERT(is_integer(PhyDef_Subed) andalso is_integer(PhyAtt_Added), {PhyDef_Subed, PhyAtt_Added, BuffRemoved}),
%     ?ASSERT(PhyDef_Subed > 0 andalso PhyAtt_Added > 0, {PhyDef_Subed, PhyAtt_Added, BuffRemoved}),

%     % NewPhyDef和NewPhyAtt都有可能为负值，故注释掉无用的断言
%     % ?ASSERT(begin
%     %             NewPhyDef = get_phy_def(Bo) + PhyDef_Subed,
%     %             NewPhyDef >= 0
%     %         end, NewPhyDef),
%     % ?ASSERT(begin
%     %             NewPhyAtt = get_phy_att(Bo) - PhyAtt_Added,
%     %             NewPhyAtt >= 0
%     %         end, NewPhyAtt),


%     % set_phy_att_and_phy_def(BoId, NewPhyAtt, NewPhyDef);

%     BoId = get_id(Bo),
%     % 恢复物防与物攻
%     add_phy_def(BoId, PhyDef_Subed),
%     add_phy_att(BoId, - PhyAtt_Added),

%     ?DEBUG_MSG("~n@@recalc_bo_for_buff_removed__(), BFN_TRANS_PHY_DEF_TO_ATT_TILL_DIE, CurRound=~p BoId=~p OldPhyDef=~p NewPhyDef=~p OldPhyAtt=~p NewPhyAtt=~p~n",
%                     [get_cur_round(), BoId,
%                     raw_get_phy_def__(Bo), raw_get_phy_def__(get_bo_by_id(BoId)),
%                     raw_get_phy_att__(Bo), raw_get_phy_att__(get_bo_by_id(BoId))]
%                     ),
%     void;

% recalc_bo_for_buff_removed__(_Bo, _BuffRemoved, _BuffName) ->
%     skip.





      % % 还原物攻或法攻
      % BuffName == ?EN_PHY_ATT_ADD
      % orelse BuffName == ?EN_MAG_ATT_ADD
      % orelse BuffName == ?EN_TRANS_DAM_TO_PHY_ATT ->
      %     NewAtt = Bo#battle_obj.com_att - EffRealValue,
      %     ?ASSERT(NewAtt > 0, NewAtt),
      %     Bo#battle_obj{com_att = NewAtt};
      % % 还原绝攻
      % BuffName == ?EN_STU_ATT_ADD ->
      %     NewStuAtt = Bo#battle_obj.stu_att - EffRealValue,
      %     ?ASSERT(NewStuAtt > 0, NewStuAtt),
      %     Bo#battle_obj{stu_att = NewStuAtt};
      % % 还原物防
      % BuffName == ?EN_PHY_DEF_ADD
      % orelse BuffName == ?EN_PHY_DEF_ADD_RATE ->
      %     NewPhyDef = Bo#battle_obj.phy_def - EffRealValue,
      %     Bo#battle_obj{phy_def = NewPhyDef};
      % % 还原法防
      % BuffName == ?EN_MAG_DEF_ADD
      % orelse BuffName == ?EN_MAG_DEF_ADD_RATE ->
      %     NewMagDef = Bo#battle_obj.mag_def - EffRealValue,
      %     Bo#battle_obj{mag_def = NewMagDef};
      % % 还原绝防
      % BuffName == ?EN_STU_DEF_ADD
      % orelse BuffName == ?EN_STU_DEF_ADD_RATE ->
      %     NewStuDef = Bo#battle_obj.stu_def - EffRealValue,
      %     Bo#battle_obj{stu_def = NewStuDef};

      %   BuffName == ?EN_STU_ATT_ADD_RATE ->
      %       NewStuDef = Bo#battle_obj.stu_att - EffRealValue,
      %       Bo#battle_obj{stu_att = NewStuDef};

      %   BuffName == ?EN_PHY_ATT_ADD_RATE
      %      orelse BuffName == ?EN_MAG_ATT_ADD_RATE
      %    orelse BuffName == ?EN_ADD_PHY_ATT_RATE_BY_DODGE
      %      orelse BuffName == ?EN_ADD_PHY_ATT_RATE_BY_BLOCK ->
      %       SklAdd = lib_battle:get_dict_bo_skl_add(Bo#battle_obj.bo_id),
      %       BuffAdd = SklAdd#bo_skl_add.buff,

      %       NewBuffAdd = BuffAdd#batt_attr{ comm_att = BuffAdd#batt_attr.comm_att - EffRealValue },
      %       lib_battle:set_dict_bo_skl_add_buff(Bo#battle_obj.bo_id, NewBuffAdd),
      %       Bo;
      % % 还原血量上限
      % BuffName == ?EN_HP_LIM_ADD_RATE ->
      %     NewHpLim = Bo#battle_obj.hp_lim - EffRealValue,
      %     ?ASSERT(NewHpLim > 0),
      %     % 勿忘矫正当前气血!
      %     NewCurHp = min(Bo#battle_obj.hp, NewHpLim),
      %     Bo#battle_obj{hp_lim = NewHpLim, hp = NewCurHp};

      % BuffName == ?EN_CRIT_RATE_ADD    ->
      %       NewVal = Bo#battle_obj.buff_crit_rate_add - EffRealValue,
      %       Bo#battle_obj{buff_crit_rate_add = NewVal};

      % BuffName == ?EN_ADD_DAM_RATE_BY_CRIT ->
      %     Bo;
      % BuffName == ?EN_BE_DAM_ADD_RATE ->
      %     Bo;
      % BuffName == ?EN_STUN ->
      %     Bo;
      % BuffName == ?EN_WARD_OFF_DAM_SHIELD ->
      %     Bo;
      % BuffName == ?EN_RETURN_DAM_SHIELD ->
      %     Bo;
      % % 其他值还原
      % % ...




%% bo死亡后移除相关的buff
%% TODO: 构思： 移除buff的信息如何收集到战报中？？！ % 返回dam_sub_dtl结构体？？.........
%% @return: {ok, 被移除的buff编号列表}
remove_buffs_for_died(BoId) ->
    Bo = get_bo_by_id(BoId),

    BuffList = Bo#battle_obj.buffs,

    BuffsRemoved = remove_buffs_for_died__(BuffList, BoId, []),
    % ?ASSERT(is_list(BuffsRemoved)),
    ?ASSERT(util:is_integer_list(BuffsRemoved), BuffsRemoved),

        % case find_buff_by_name(Bo, ?BFN_TRANS_PHY_DEF_TO_ATT_TILL_DIE) of
        %     null ->
        %         [];
        %     Buff ->
        %         remove_buff(BoId, Buff),
        %         [Buff#bo_buff.buff_no]
        % end,

    % 移除其他相关buff， 并累计移除的buff列表，用于作为返回值...
    % ...



    {ok, BuffsRemoved}.




remove_buffs_for_died__([], _BoId, AccBuffsRemoved) ->
    AccBuffsRemoved;
remove_buffs_for_died__([Buff | T], BoId, AccBuffsRemoved) ->
    case lib_bo_buff:is_removed_after_died(Buff) of
        true ->
            remove_buff(BoId, Buff),
            AccBuffsRemoved_2 = [lib_bo_buff:get_no(Buff) | AccBuffsRemoved],
            remove_buffs_for_died__(T, BoId, AccBuffsRemoved_2);
        false ->
            remove_buffs_for_died__(T, BoId, AccBuffsRemoved)
    end.









% %% 强行转为普通攻击
% convert_to_normal_att(BoId) ->
%     Bo = get_bo_by_id(BoId),
%     ?ASSERT(Bo /= null, BoId),
%     SkillId = ?NORMAL_ATT_SKILL_ID,
%     TargetBoId = ?INVALID_ID,     % todo: 目标目前实际上没用，故设为INVALID_ID，以后如有必要，可以再做调整
%     prepare_cmd_use_skill(Bo, SkillId, TargetBoId).


% %% 确定逃跑成功的概率
% %% 注：逃跑的成功率区分为PVE与PVP两个版本，规定PVE战斗的逃跑必然成功，而PVP战斗的逃跑成功率遵循以下公式：
% %%    （我方所有玩家的平均等级-对方所有玩家的平均等级）/200+0.5
decide_escape_success_proba(Bo) ->
    case get_tmp_force_escape_success_proba(Bo) of
        invalid ->
            BtlState = lib_bt_comm:get_battle_state(),
            case lib_bt_comm:is_PVE_battle(BtlState) of
                true ->
                    ?PROBABILITY_BASE;
                false ->
                    MySide = get_side(Bo),
                    EnemySide = lib_bt_comm:to_enemy_side(MySide),
                    MySideAvgPlayerLv = lib_bt_calc:calc_avg_player_lv_of_side(MySide),
                    EnemySideAvgPlayerLv = lib_bt_calc:calc_avg_player_lv_of_side(EnemySide),
                    Proba = erlang:max((MySideAvgPlayerLv - EnemySideAvgPlayerLv) / 200 + 0.5, 0),
                    ?BT_LOG(io_lib:format("decide_escape_success_proba(), MySide:~p, MySideAvgPlayerLv:~p, EnemySideAvgPlayerLv:~p, Proba:~p~n", [MySide, MySideAvgPlayerLv, EnemySideAvgPlayerLv, Proba])),
                    case Proba >= 1 of
                        true ->
                            ?PROBABILITY_BASE;
                        false ->
                            erlang:round(Proba * ?PROBABILITY_BASE)
                    end
            end;
        TmpForceProba ->
            ?ASSERT(util:is_nonnegative_int(TmpForceProba), TmpForceProba),
            TmpForceProba
    end.



%% 是否可以逃跑？(true | false)
can_escape(Bo) ->
    CannotEscape = is_dead(Bo)
                   orelse is_frozen(Bo)
                   orelse is_trance(Bo)
                   orelse is_chaos(Bo)
                   orelse is_cding(Bo)
                   orelse is_xuliing(Bo),
                   % orelse (lib_bt_comm:is_offline_player(Bo))  % 目前处理：对于玩家或主宠，下线了则不能逃跑
                   % orelse (lib_bt_comm:is_offline_main_partner(Bo)),
    case CannotEscape of
        true ->
            false;
        false ->
            Proba = decide_escape_success_proba(Bo),
            case lib_bt_util:test_proba(Proba) of
                success -> true;
                fail -> false
            end

            % true
    end.






%% 是否可以复活
%% TODO：
can_revive(_Bo) ->
    false.







%% 获取战斗对象的技能等级（目前是借助该函数来获取追击技的等级）
%% @return: 没有对应的技能则返回0级，否则返回对应的技能等级
get_skill_lv(Bo, SkillId) ->      % get_skill_lv_by_skill_id

     case lists:keyfind(SkillId, #bo_skl_brf.id, Bo#battle_obj.initiative_skill_list) of
       false ->
           1;
       SklBrief ->
           SklBrief#bo_skl_brf.lv
     end.



get_AI_no_list(Bo) ->
    Bo#battle_obj.ai_list.



get_talk_AI_no_list(Bo) ->
    L = get_AI_no_list(Bo),
    [X || X <- L, lib_bt_AI:is_talk_AI(X)].



get_cur_round_talk_AI_list(Bo) ->
    Bo#battle_obj.cur_round_talk_ai_list.


set_cur_round_talk_AI_list(BoId, L) ->
    Bo = get_bo_by_id(BoId),
    Bo2 = Bo#battle_obj{cur_round_talk_ai_list = L},
    update_bo(Bo2),
    void.



%% 下达默认的指令（目前即普通攻击）
prepare_default_cmd(BoId) ->
    Bo = get_bo_by_id(BoId),
    case is_monster(Bo) of
        true ->
            do_prepare_default_cmd_for_mon(Bo);
        false ->
            do_prepare_default_cmd(Bo)
    end.



do_prepare_default_cmd_for_mon(MonBo) ->
    % 随机挑敌方的一个目标
    Side = get_side(MonBo),
    EnemySide = lib_bt_comm:to_enemy_side(Side),
    TargetBoId = case lib_bt_comm:get_bo_id_list(EnemySide) of
                    [] ->  % 容错
                        ?ASSERT(false),
                        ?ERROR_MSG("[lib_bo] do_prepare_default_cmd_for_mon() error!! bo id list empty!", []),
                        ?INVALID_ID;
                    L ->
                        list_util:rand_pick_one(L)
                end,
    prepare_cmd_normal_att( get_id(MonBo), TargetBoId).


do_prepare_default_cmd(Bo) ->
    TargetBoId = ?INVALID_ID,
    prepare_cmd_normal_att( get_id(Bo), TargetBoId).







%% 下达指令：普通攻击
prepare_cmd_normal_att(BoId, TargetBoId) ->
    % prepare_cmd_use_skill(Bo_Latest, ?NORMAL_ATT_SKILL_ID, TargetBoId).

    % SkillLv = case SkillId of
    %             ?NORMAL_ATT_SKILL_ID -> 0;  % 表示普通攻击，等级无意义，目前设为0
    %             _ -> get_skill_lv(Bo_Latest, SkillId)
    %         end,

    io:format("testbattle ~p~n", [{BoId}]),

    ?ASSERT(lib_bt_comm:is_bo_exists(BoId), BoId),
    Bo = get_bo_by_id(BoId),

    Bo2 = Bo#battle_obj{
                cmd_type = ?CMD_T_NORMAL_ATT,
                cmd_para = 0, % 参数无意义，统一为0
                cur_pick_target = TargetBoId,

                is_cmd_prepared = true  % 同时标记为已下达过指令
                },

    update_bo(Bo2),  % 更新到进程字典！
    Bo2.



%% 下达指令：使用技能
prepare_cmd_use_skill(BoId, SkillId, TargetBoId) ->
    ?ASSERT(lib_bt_comm:is_bo_exists(BoId), BoId),
    ?ASSERT(SkillId /= 0),
    Bo = get_bo_by_id(BoId),

    SkillLv =case SkillId of
               0 -> 0;  % 表示普通攻击，等级无意义，目前设为0
               _ -> get_skill_lv(Bo, SkillId)
           end,

    Bo2 = Bo#battle_obj{
                cmd_type = ?CMD_T_USE_SKILL,
                cmd_para = SkillId,
    cur_pick_target = TargetBoId,
    cur_skill_brief = lib_bt_skill:to_bo_skill_brief({SkillId, SkillLv})
  },

    update_bo(Bo2),  % 更新到进程字典！
    Bo2.


%% 下达指令：使用物品
prepare_cmd_use_goods(BoId, GoodsId, TargetBoId) ->
    ?ASSERT(lib_bt_comm:is_bo_exists(BoId), BoId),
    Bo = get_bo_by_id(BoId),
    Bo2 = Bo#battle_obj{
                cmd_type = ?CMD_T_USE_GOODS,
                cmd_para = GoodsId,
                cur_pick_target = TargetBoId
                },
    update_bo(Bo2),  % 更新到进程字典！
    Bo2.


%% 下达指令：保护盟友
prepare_cmd_protect_others(BoId, TargetBoId) ->
    ?ASSERT(lib_bt_comm:is_bo_exists(BoId), BoId),
    Bo = get_bo_by_id(BoId),
    Bo2 = Bo#battle_obj{
                cmd_type = ?CMD_T_PROTECT,
                cmd_para = 0,  % 参数无意义，统一为0
                cur_pick_target = TargetBoId
                },
    update_bo(Bo2),  % 更新到进程字典！
    Bo2.

%% 下达指令：捕捉宠物
prepare_cmd_capture_partner(BoId, TargetBoId) ->
    ?ASSERT(lib_bt_comm:is_bo_exists(BoId), BoId),
    Bo = get_bo_by_id(BoId),
    Bo2 = Bo#battle_obj{
                cmd_type = ?CMD_T_CAPTURE_PARTNER,
                cmd_para = 0,  % 参数无意义，统一为0
                cur_pick_target = TargetBoId
                },
    update_bo(Bo2),  % 更新到进程字典！
    Bo2.


%% 下达指令：逃跑
prepare_cmd_escape(BoId) ->
    ?ASSERT(lib_bt_comm:is_bo_exists(BoId), BoId),
    Bo = get_bo_by_id(BoId),
    Bo2 = Bo#battle_obj{
                cmd_type = ?CMD_T_ESCAPE,
                cmd_para = 0,  % 参数无意义，统一为0
                cur_pick_target = ?INVALID_ID  % 逃跑只针对自己，无目标
                },
    update_bo(Bo2),  % 更新到进程字典！
    Bo2.




%% 下达指令：防御
prepare_cmd_defend(BoId) ->
    ?ASSERT(lib_bt_comm:is_bo_exists(BoId), BoId),
    Bo = get_bo_by_id(BoId),
    Bo2 = Bo#battle_obj{
                cmd_type = ?CMD_T_DEFEND,
                cmd_para = 0,  % 参数无意义，统一为0
                cur_pick_target = ?INVALID_ID  % 逃跑只针对自己，无目标
                },
    update_bo(Bo2),  % 更新到进程字典！
    Bo2.


%% 下达指令：召唤宠物
prepare_cmd_summon_partner(BoId, PartnerId) ->
    ?ASSERT(lib_bt_comm:is_bo_exists(BoId), BoId),
    Bo = get_bo_by_id(BoId),
    Bo2 = Bo#battle_obj{
                cmd_type = ?CMD_T_SUMMON_PARTNER,
                cmd_para = PartnerId
                },
    update_bo(Bo2),  % 更新到进程字典！
    Bo2.


%% 下达指令：召唤怪物
prepare_cmd_summon_mon(BoId, MonL) ->
    ?ASSERT(lib_bt_comm:is_bo_exists(BoId), BoId),
    Bo = get_bo_by_id(BoId),
    Bo2 = Bo#battle_obj{
                cmd_type = ?CMD_T_SUMMON_MON,
                cmd_para = MonL
                },
    update_bo(Bo2),  % 更新到进程字典！
    Bo2.


%% 是否处于物理连击状态？
in_phy_combo_att_status(Bo) ->
    Bo#battle_obj.tmp_status#bo_tmp_stat.in_phy_combo_att_status.



%% 标记为物理连击状态
mark_phy_combo_att_status(BoId) when is_integer(BoId) ->
    Bo = get_bo_by_id(BoId),
    ?ASSERT(Bo /= null, BoId),
    mark_phy_combo_att_status(Bo);
mark_phy_combo_att_status(Bo_Latest) when is_record(Bo_Latest, battle_obj) ->
    OldTmpStatus = Bo_Latest#battle_obj.tmp_status,
    NewTmpStatus = OldTmpStatus#bo_tmp_stat{in_phy_combo_att_status = true},
    update_bo( Bo_Latest#battle_obj{tmp_status = NewTmpStatus} ),
    void.




%% 清除物理连击状态
clear_phy_combo_att_status(BoId) when is_integer(BoId) ->
    Bo = get_bo_by_id(BoId),
    ?ASSERT(Bo /= null, BoId),
    clear_phy_combo_att_status(Bo);
clear_phy_combo_att_status(Bo_Latest) when is_record(Bo_Latest, battle_obj) ->
    OldTmpStatus = Bo_Latest#battle_obj.tmp_status,
    NewTmpStatus = OldTmpStatus#bo_tmp_stat{in_phy_combo_att_status = false},
    update_bo( Bo_Latest#battle_obj{tmp_status = NewTmpStatus} ),
    void.




%% 获取追击伤害系数
get_pursue_att_dam_coef(Bo) ->
    RetVal = case get_tmp_force_pursue_att_dam_coef(Bo) of
                invalid ->
                    Bo#battle_obj.attrs#attrs.pursue_att_dam_coef;
                TmpForceVal ->
                    ?ASSERT(erlang:is_number(TmpForceVal) andalso TmpForceVal > 0, TmpForceVal),
                    TmpForceVal
            end,

    min(RetVal, ?MAX_PURSUE_ATT_DAM_COEF).


get_acc_pursue_att_times(Bo) ->
    Bo#battle_obj.tmp_status#bo_tmp_stat.acc_pursue_att_times.


get_max_pursue_att_times(Bo) ->
    % Bo#battle_obj.base_pursue_att_times.

    case get_tmp_force_max_pursue_att_times(Bo) of
        invalid ->
            Bo#battle_obj.max_pursue_att_times;
        TmpForceTimes ->
            ?ASSERT(util:is_nonnegative_int(TmpForceTimes)),
            TmpForceTimes
    end.




% %% 递减可追击的剩余次数
% decr_left_pursue_att_times(BoId) ->
%     Bo = get_bo_by_id(BoId),
%     ?ASSERT(Bo /= null, BoId),
%     NewTimes = Bo#battle_obj.left_pursue_att_times - 1,
%     update_bo( Bo#battle_obj{left_pursue_att_times = NewTimes} ),
%     void.

%% 递增单回合内累计已追击的次数
incr_acc_pursue_att_times(BoId) ->
    Bo = get_bo_by_id(BoId),
    ?ASSERT(Bo /= null, BoId),
    NewTimes = get_acc_pursue_att_times(Bo) + 1, %%       Bo#battle_obj.left_pursue_att_times - 1,
    OldTmpStatus = Bo#battle_obj.tmp_status,
    NewTmpStatus = OldTmpStatus#bo_tmp_stat{acc_pursue_att_times = NewTimes},
    update_bo( Bo#battle_obj{tmp_status = NewTmpStatus} ),
    void.




% %% 获取/设置可追击的剩余次数
% get_left_pursue_att_times(Bo) ->
%     Bo#battle_obj.left_pursue_att_times.
% set_left_pursue_att_times(BoId, Times) ->
%     Bo = get_bo_by_id(BoId),
%     ?ASSERT(Bo /= null, BoId),
%     update_bo( Bo#battle_obj{left_pursue_att_times = Times} ),
%     void.



%% 获取追击概率（数值是放大了1000倍的）
get_pursue_att_proba(Bo) ->
    case get_tmp_force_pursue_att_proba(Bo) of
        invalid ->
            Bo#battle_obj.attrs#attrs.pursue_att_proba;
        TmpForceProba ->
            % ?ASSERT(util:is_probability(TmpForceProba), TmpForceProba),
            ?ASSERT(util:is_nonnegative_int(TmpForceProba)),
            TmpForceProba
    end.



%% 是否可以追击？
can_pursue_attack(BoId) ->
    case is_dead(BoId) of
        true -> false;
        false ->
            Bo = get_bo_by_id(BoId),
            % AccComboAttTimes = get_acc_phy_combo_att_times(Bo),
            % 已经连击的就不能触发追击
            % case AccComboAttTimes > 0 of
            %    true -> false;
            %    false ->
                    AccTimes = get_acc_pursue_att_times(Bo),
                    MaxTimes = get_max_pursue_att_times(Bo),

                    CanCombo =
                    case is_using_normal_att(Bo) of
                        true ->
                            true;
                        false ->

                             case get_cur_skill_cfg(Bo) of
                                 null ->
                                     false;
                                 CurSklCfg ->
                                     mod_skill:is_can_combo(CurSklCfg)
                             end
                    end,

                    case AccTimes < MaxTimes andalso CanCombo of
                        false -> false;
                        true ->
                            Proba = get_pursue_att_proba(Bo),
                            % 判定概率
                            case lib_bt_util:test_proba(Proba) of
                                success -> true;
                                fail -> false
                            end
                    end
            %end
    end.



% %% 递减剩余物理连击次数
% decr_left_phy_combo_att_times(BoId) ->
%     Bo = get_bo_by_id(BoId),
%     ?ASSERT(Bo /= null, BoId),
%     NewTimes = Bo#battle_obj.left_phy_combo_att_times - 1,
%     update_bo( Bo#battle_obj{left_phy_combo_att_times = NewTimes} ),
%     void.



%% 获取物品信息
%% @return: null | #bo_goods_info{}
get_goods_info(Bo, GoodsId) ->
    case lists:keyfind(GoodsId, #bo_goods_info.goods_id, Bo#battle_obj.goods_info_list) of
        false -> null;
        Val -> Val
    end.


%% 记录物品信息
record_goods_info(BoId, Goods) ->
    Bo = get_bo_by_id(BoId),
    GoodsId = lib_goods:get_id(Goods),
    Info = #bo_goods_info{
                goods_id = GoodsId,
                count = lib_goods:get_count(Goods)
                },

    TmpNewInfoList = lists:keydelete(GoodsId, #bo_goods_info.goods_id, Bo#battle_obj.goods_info_list),
    NewInfoList = TmpNewInfoList ++ [Info],
    Bo2 = Bo#battle_obj{goods_info_list = NewInfoList},
    update_bo(Bo2).


%% 使用物品后更新物品信息
update_goods_info_after_use(BoId, GoodsId, UseCount) ->
    ?ASSERT(util:is_positive_int(UseCount)),
    Bo = get_bo_by_id(BoId),
    case get_goods_info(Bo, GoodsId) of
        null ->
            ?ASSERT(false, {BoId, GoodsId}),
            skip;
        Info ->
            NewCount = max(Info#bo_goods_info.count - UseCount, 0),
            NewInfo = Info#bo_goods_info{count = NewCount},
            NewInfoList = lists:keyreplace(GoodsId, #bo_goods_info.goods_id, Bo#battle_obj.goods_info_list, NewInfo),
            ?BT_LOG(io_lib:format("update_goods_info_after_use(), BoId:~p, GoodsId:~p, NewInfoList:~w~n", [BoId, GoodsId, NewInfoList])),
            Bo2 = Bo#battle_obj{goods_info_list = NewInfoList},
            update_bo(Bo2)
    end.





get_dbg_force_fix_dam(Bo) ->
    Bo#battle_obj.dbg_force_fix_dam.





% get_bo_ids_already_attacked(Bo) ->
%     Bo#battle_obj.bo_ids_already_attacked.


%% 标记某bo为当前回合已经攻击过了
mark_already_attacked(AtterId, DeferId) ->
    Atter = get_bo_by_id(AtterId),
    OldList = Atter#battle_obj.bo_ids_already_attacked,
    NewList = [DeferId | OldList],
    Atter2 = Atter#battle_obj{bo_ids_already_attacked = NewList},
    update_bo(Atter2),
    void.




%% Atter本回合中是否已经打过DeferId了？
is_already_attacked(Atter, DeferId) ->
    lists:member(DeferId, Atter#battle_obj.bo_ids_already_attacked).


%% 获取当前嘲讽我的bo id
get_he_who_taunt_me(Bo) ->
    Bo#battle_obj.he_who_taunt_me.


%% 设置当前嘲讽我的bo id
set_he_who_taunt_me(MyBoId, BoId_TauntMaker) ->
    MyBo = get_bo_by_id(MyBoId),
    MyBo2 = MyBo#battle_obj{he_who_taunt_me = BoId_TauntMaker},
    update_bo(MyBo2),
    void.


%% 是否被嘲讽？
is_be_taunt(Bo) ->
    RetBool = (find_buff_by_name(Bo, ?BFN_BE_TAUNT) /= null),
    ?ASSERT(begin
                case RetBool of
                    true -> get_he_who_taunt_me(Bo) /= ?INVALID_ID;
                    false -> get_he_who_taunt_me(Bo) == ?INVALID_ID
                end
            end, {RetBool, Bo}),
    RetBool.





get_max_hit_obj_count(Bo) ->
    Bo#battle_obj.tmp_status#bo_tmp_stat.max_hit_obj_count.

%% 设置（多目标物理攻击时）攻击目标数量上限
set_max_hit_obj_count(BoId, Count) ->
    Bo = get_bo_by_id(BoId),
    OldTmpStatus = Bo#battle_obj.tmp_status,
    NewTmpStatus = OldTmpStatus#bo_tmp_stat{max_hit_obj_count = Count},
    update_bo( Bo#battle_obj{tmp_status = NewTmpStatus} ),
    void.


%% 获取（多目标物理攻击时）当前已经攻击过多少个目标了
get_acc_hit_obj_count(Bo) ->
    Bo#battle_obj.tmp_status#bo_tmp_stat.acc_hit_obj_count.

incr_acc_hit_obj_count(BoId) ->
    Bo = get_bo_by_id(BoId),
    NewCount = get_acc_hit_obj_count(Bo) + 1, %%Bo#battle_obj.acc_hit_obj_count + 1,
    OldTmpStatus = Bo#battle_obj.tmp_status,
    NewTmpStatus = OldTmpStatus#bo_tmp_stat{acc_hit_obj_count = NewCount},
    update_bo( Bo#battle_obj{tmp_status = NewTmpStatus} ),
    void.






%% 是否可以保护他人？
can_do_protect(Bo) ->
    is_living(Bo) andalso (not is_under_control(Bo)).


%% 获取一个保护者
%% @return: null | battle_obj结构体
get_one_protector(Bo) ->
    case get_one_regular_protector(Bo) of
        null ->
            case get_one_protector_by_intimacy(Bo) of
                null ->
                    get_one_protector_by_buff(Bo);
                Protector_Bo ->
                    Protector_Bo
            end;
        Protector_Bo ->
            Protector_Bo
    end.


get_one_regular_protector(Bo) ->
    BoIdList = Bo#battle_obj.regular_protector_list,
    ?BT_LOG(io_lib:format("get_one_regular_protector(), BoId=~p, Protector_BoIdList=~p~n", [get_id(Bo), BoIdList])),
    get_one_regular_protector__(BoIdList).

get_one_regular_protector__([H | T]) ->
    case get_bo_by_id(H) of
        null ->
            get_one_regular_protector__(T);
        Bo ->
            case can_do_protect(Bo) of
                true -> Bo;
                false -> get_one_regular_protector__(T)
            end
    end;
get_one_regular_protector__([]) ->
    null.



get_ratio(hp_vs_hp_lim, Bo) ->
    get_hp(Bo) / get_hp_lim(Bo).


%% 根据好友度挑选一个可以保护我的bo，若没有，则返回null
%% @return: null | battle_obj结构体
get_one_protector_by_intimacy(Bo) ->
    case get_ratio(hp_vs_hp_lim, Bo) < 0.15 of
        false ->
            null;
        true ->
            MySide = lib_bo:get_side(Bo),
            L = lib_bt_comm:get_living_player_bo_id_list_except_hired_player(MySide),
            L2 = L -- [get_id(Bo)],   % 过滤掉自己
            case L2 of
                [] ->
                    null;
                _ ->
                    L3 = sort_list_by_intimacy_desc(Bo, L2),
                    get_one_protector_by_intimacy__(Bo, L3)
            end
    end.

get_one_protector_by_intimacy__(Bo, [TargetBoId | T]) ->
    TargetBo = get_bo_by_id(TargetBoId),
    Proba = lib_bt_rela:get_protect_proba_by_intimacy(Bo, TargetBo),
    ?BT_LOG(io_lib:format("get_one_protector_by_intimacy__(), BoId:~p, TargetBoId:~p, Intimacy:~p, Proba:~p",
                                [get_id(Bo), TargetBoId, lib_bt_rela:get_intimacy(Bo, TargetBo), Proba])),
    case util:decide_proba_once(Proba) of
        success ->
            case can_do_protect(TargetBo) of
                true ->
                    TargetBo;
                false ->
                    get_one_protector_by_intimacy__(Bo, T)
            end;
        fail ->
            get_one_protector_by_intimacy__(Bo, T)
    end;

get_one_protector_by_intimacy__(_Bo, []) ->
    null.


%% 按好友度降序排序bo id列表
sort_list_by_intimacy_desc(Bo, TargetBoIdList) ->
    F = fun(BoId_A, BoId_B) ->
            A = get_bo_by_id(BoId_A),
            B = get_bo_by_id(BoId_B),
            IntimacyWith_A = lib_bt_rela:get_intimacy(Bo, A),
            IntimacyWith_B = lib_bt_rela:get_intimacy(Bo, B),
            if
                IntimacyWith_A > IntimacyWith_B ->
                    true;
                IntimacyWith_A < IntimacyWith_B ->
                    false;
                true -> % 好友度相同，则优先选择血量高的
                    get_hp(A) > get_hp(B)
            end
        end,
    lists:sort(F, TargetBoIdList).




%% 单个回合内允许因buff而受到保护的次数上限（目前为1次）
-define(MAX_BE_PROTECT_BY_BUFF_TIMES_PER_ROUND, 1).

%% 根据受保护buff挑选一个可以保护我的bo，若没有，则返回null
%% @return: null | battle_obj结构体
get_one_protector_by_buff(Bo) ->
    Ret =   case get_acc_be_protect_by_buff_times(Bo) >= ?MAX_BE_PROTECT_BY_BUFF_TIMES_PER_ROUND of
                true ->
                    ?BT_LOG(io_lib:format("get_one_protector_by_buff(), BoId:~p, got max be protect times!", [get_id(Bo)])),
                    null;
                false ->
                    case find_buff_by_name(Bo, ?BFN_BE_PROTECT) of
                        null ->
                            null;
                        BeProtBuff ->
                            FromBoId = lib_bo_buff:get_from_bo_id(BeProtBuff),
                            case get_bo_by_id(FromBoId) of
                                null ->
                                    null;
                                FromBo ->
                                    case can_do_protect(FromBo) of
                                        true -> FromBo;
                                        false -> null
                                    end
                            end
                    end
            end,

    case Ret of
        null -> skip;
        _ -> incr_acc_be_protect_by_buff_times( get_id(Bo) ) % 注意：简单起见，不管上层逻辑是否实际应用了保护流程，在此处即递增了次数
    end,

    ?BT_LOG(io_lib:format("get_one_protector_by_buff(), BoId:~p, Ret:~p", [get_id(Bo), Ret])),
    Ret.




%% 获取当前回合累计因buff而受到保护的次数
get_acc_be_protect_by_buff_times(Bo) ->
    Bo#battle_obj.tmp_status#bo_tmp_stat.acc_be_protect_by_buff_times.

%% 递增当前回合累计因buff而受到保护的次数
incr_acc_be_protect_by_buff_times(BoId) ->
    Bo = get_bo_by_id(BoId),
    ?ASSERT(Bo /= null, BoId),
    NewTimes = get_acc_be_protect_by_buff_times(Bo) + 1,
    OldTmpStatus = Bo#battle_obj.tmp_status,
    NewTmpStatus = OldTmpStatus#bo_tmp_stat{acc_be_protect_by_buff_times = NewTimes},
    update_bo( Bo#battle_obj{tmp_status = NewTmpStatus} ),
    void.







%% 新增一个常规保护者（常规保护者：通过下达保护指令来保护我的bo）
add_regular_protector(Protege_BoId, Protector_BoId) ->
    ?ASSERT(is_integer(Protector_BoId)),

    Protege_Bo = get_bo_by_id(Protege_BoId),
    ?ASSERT(is_record(Protege_Bo, battle_obj), Protege_BoId),

    OldList = Protege_Bo#battle_obj.regular_protector_list,

    NewList = [Protector_BoId | OldList],

    % 依据出手速度，重排序NewList
    NewList2 = reorder_by_act_speed(NewList),

    ?BT_LOG(io_lib:format("add_regular_protector(), Protege_BoId=~p, Protector_BoId=~p, NewList2=~p~n", [Protege_BoId, Protector_BoId, NewList2])),

    Protege_Bo2 = Protege_Bo#battle_obj{regular_protector_list = NewList2},
    update_bo(Protege_Bo2),
    void.



%% 移除一个常规保护者
maybe_remove_regular_protector(Protege_BoId, Protector_BoId) ->
    ?ASSERT(is_integer(Protector_BoId)),

    Protege_Bo = get_bo_by_id(Protege_BoId),
    ?ASSERT(is_record(Protege_Bo, battle_obj), Protege_BoId),

    OldList = Protege_Bo#battle_obj.regular_protector_list,

    case lists:member(Protector_BoId, OldList) of
        true ->
            NewList = OldList -- [Protector_BoId],
            Protege_Bo2 = Protege_Bo#battle_obj{regular_protector_list = NewList},
            update_bo(Protege_Bo2);
        false ->
            skip
    end,

    void.




reorder_by_act_speed(BoIdList) ->
    ?ASSERT(util:is_integer_list(BoIdList)),
    F = fun(IdA, IdB) ->
            BoA = get_bo_by_id(IdA),
            BoB = get_bo_by_id(IdB),
            get_act_speed(BoA) =< get_act_speed(BoB)
        end,
    lists:sort(F, BoIdList).





%% 扣除物理连击所带来的消耗
apply_phy_combo_att_costs(_BoId) ->
    todo_here.


%% 扣除法术连击所带来的消耗
apply_mag_combo_att_costs(_BoId) ->
    todo_here.






%% 判断技能是否在CD中？
is_skill_cding(Bo, SkillId) ->
    % case get_skill_brief(Bo, SkillId) of
    %     null ->
    %         ?ASSERT(false, {SkillId, Bo}),
    %         false;
    %     BoSklBrief ->
    %         CurRound = lib_bt_comm:get_cur_round(),
    %         BoSklBrief#bo_skl_brf.cd_over_round > CurRound
    % end.

    get_skill_left_cd_rounds(Bo, SkillId) > 0.




get_skill_left_cd_rounds(Bo, SkillId) ->
    case get_skill_brief(Bo, SkillId) of
        null ->
            ?ASSERT(false, {SkillId, Bo}),
            0;
        BoSklBrief ->
            CurRound = lib_bt_comm:get_cur_round(),
            CDLeftRounds = BoSklBrief#bo_skl_brf.cd_over_round - CurRound,
            case CDLeftRounds > 0 of
                true -> CDLeftRounds;
                false -> 0
            end
    end.






%% @return: true | {false, Reason}
can_use_skill(Bo, SkillId) when is_integer(SkillId) ->
    SklCfg = mod_skill:get_cfg_data(SkillId),
    ?ASSERT(SklCfg /= null, {SkillId, Bo}),
    can_use_skill(Bo, SklCfg);

can_use_skill(Bo, SklCfg) when is_record(SklCfg, skl_cfg) ->
    case mod_skill:is_initiative(SklCfg) of
        false ->
            {false, not_initiative_skill};  % 非主动技固定不能使用
        true ->
            SkillId = mod_skill:get_id(SklCfg),
            % 是否有这个技能？
            case has_skill(Bo, SkillId) of
                false ->
                    %%%%?ASSERT(false, {SkillId, Bo}),
                    {false, has_not_such_skill};
                true ->
                    case check_use_skill_conditions(Bo, SklCfg) of
                        {fail, Reason} ->
                            {false, Reason};
                        ok ->
                            case check_use_skill_costs(Bo, SklCfg) of
                                {fail, Reason} ->
                                    {false, Reason};
                                ok ->
                                    case is_skill_cding(Bo, SkillId) of
                                        true ->
                                            {false, cding};
                                        false ->
                                            true
                                    end
                            end
                    end
            end
    end.


%% 判断bo实际行动时是否可使用某技能
can_use_skill_on_real_act(Bo, SklCfg) ->
    case can_use_skill(Bo, SklCfg) of
        {false, Reason} ->
            {false, Reason};
        true ->
            % 附加判断技能的效果的当前作用目标是否都为空
            case are_skill_effs_target_empty(Bo, SklCfg) of
                true ->
                    {false, skill_effs_target_empty};
                false ->
                    true
            end
    end.




%% 判断技能的效果的当前作用目标是否都为空
are_skill_effs_target_empty(Bo, SklCfg) ->
    % 判断pre_effs, att_eff和post_effs, 不需判断in_effs
    are_skill_pre_effs_target_empty(Bo, SklCfg)
    andalso is_skill_att_eff_target_empty(Bo, SklCfg)
    andalso are_skill_post_effs_target_empty(Bo, SklCfg).


are_skill_pre_effs_target_empty(Bo, SklCfg) ->
    SklEffNoList = mod_skill:get_pre_effs(SklCfg),
    are_skill_effs_target_empty__(Bo, SklEffNoList).

is_skill_att_eff_target_empty(Bo, SklCfg) ->
    case mod_skill:get_att_eff(SklCfg) of
        ?INVALID_EFF_NO ->
            true;
        _SklAttEffNo ->
            mod_battle:decide_att_targets( get_id(Bo)) == []
    end.

are_skill_post_effs_target_empty(Bo, SklCfg) ->
    SklEffNoList = mod_skill:get_post_effs(SklCfg),
    are_skill_effs_target_empty__(Bo, SklEffNoList).


are_skill_effs_target_empty__(_Bo, []) ->
    true;
are_skill_effs_target_empty__(Bo, [SklEffNo | T]) ->
    SklEff = lib_skill_eff:get_cfg_data(SklEffNo),
    ?ASSERT(SklEff /= null, SklEffNo),
    case lib_bt_skill:decide_skill_eff_targets( get_id(Bo), SklEff) of
        [] ->
            are_skill_effs_target_empty__(Bo, T);
        _TarBoIdList ->
            false
    end.




%% 检查是否满足技能的使用条件
%% @return: ok | {fail, Reason}
check_use_skill_conditions(Bo, SklCfg) ->
    ConditionList = mod_skill:get_use_condition_list(SklCfg),
    check_use_skill_conditions__(ConditionList, Bo).

check_use_skill_conditions__([], _Bo) ->
    ok;
check_use_skill_conditions__([Condition | T], Bo) ->
    case check_one_use_skill_condition(Condition, Bo) of
        ok ->
            check_use_skill_conditions__(T, Bo);
        {fail, Reason} ->
            {fail, Reason}
    end.


check_one_use_skill_condition({hp_rate_less_than, Rate}, Bo) ->
    ?ASSERT(Rate >= 0 andalso Rate =< 1, Rate),
    CurHp = get_hp(Bo),
    InitHpLim = get_init_hp_lim(Bo),
    case (CurHp / InitHpLim) < Rate of
        true -> ok;
        false -> {fail, hp_rate_too_high}
    end;

check_one_use_skill_condition({hp_rate_more_than, Rate}, Bo) ->
    ?ASSERT(Rate >= 0 andalso Rate =< 1, Rate),
    CurHp = get_hp(Bo),
    InitHpLim = get_init_hp_lim(Bo),
    case (CurHp / InitHpLim) > Rate of
        true -> ok;
        false -> {fail, hp_rate_too_low}
    end;

check_one_use_skill_condition(i_am_not_invisible, Bo) ->   % 不处于隐身状态
    case is_invisible(Bo) of
        true -> {fail, in_invisible_status};
        false -> ok
    end;

% 需要BUFF
check_one_use_skill_condition({need_pre_buff,BuffNo,SkillNo}, Bo) ->   % 需要知道buff
    ?ASSERT(util:is_positive_int(BuffNo), BuffNo),
    case has_spec_no_buff(Bo, BuffNo) of
        false -> {fail, {need_pre_buff,SkillNo}};  % in_special_status: 处于特殊的状态中
        true -> ok
    end;

% 需要前置BUFF层数
check_one_use_skill_condition({need_pre_buff_and_overlap,BuffNo,Lap}, Bo) ->   % 需要知道buff
    ?ASSERT(util:is_positive_int(BuffNo), BuffNo),
    case has_buff_lap(Bo, BuffNo,Lap) of
        false -> {fail, need_pre_buff};  % in_special_status: 处于特殊的状态中
        true -> ok
    end;


check_one_use_skill_condition({has_not_spec_no_buff, BuffNo}, Bo) ->   % 无指定编号的buff
    ?ASSERT(util:is_positive_int(BuffNo), BuffNo),
    case has_spec_no_buff(Bo, BuffNo) of
        true -> {fail, in_special_status};  % in_special_status: 处于特殊的状态中
        false -> ok
    end;

check_one_use_skill_condition(_Other, _Bo) ->
    ?ASSERT(false, _Other),
    {fail, unknown_err}.



%% 检查是否满足技能的使用消耗
%% @return: ok | {fail, Reason}
check_use_skill_costs(Bo, SklCfg) ->
    CostHp = lib_bt_calc:calc_use_skill_cost_hp(Bo, SklCfg),
    CostMp = lib_bt_calc:calc_use_skill_cost_mp(Bo, SklCfg),
    CostAnger = lib_bt_calc:calc_use_skill_cost_anger(Bo, SklCfg),
    CostGamemoney = lib_bt_calc:calc_use_skill_cost_gamemoney(Bo, SklCfg),
    case get_hp(Bo) > CostHp of
        false -> {fail, hp_not_enough};
        true ->
            case get_mp(Bo) >= CostMp of
                false -> {fail, mp_not_enough};
                true ->
                    case get_anger(Bo) >= CostAnger of
                        false -> {fail, anger_not_enough};
                        true ->
                            case get_gamemoney(Bo) >= CostGamemoney of
                                false -> {fail, gamemoney_not_enough};
                                true -> ok
                            end
                    end
            end
    end.


%% 处理使用技能时的相关消耗
apply_use_skill_costs(BoId, CurSklCfg) ->
    Bo = get_bo_by_id(BoId),

    CostHp = lib_bt_calc:calc_use_skill_cost_hp(Bo, CurSklCfg),
    CostMp = lib_bt_calc:calc_use_skill_cost_mp(Bo, CurSklCfg),
    CostAnger = lib_bt_calc:calc_use_skill_cost_anger(Bo, CurSklCfg),
    CostGamemoney = lib_bt_calc:calc_use_skill_cost_gamemoney(Bo, CurSklCfg),

    ?ASSERT(get_hp(Bo) > CostHp, {CostHp, Bo}),
    ?ASSERT(get_mp(Bo) >= CostMp, {CostMp, Bo}),
    ?ASSERT(get_anger(Bo) >= CostAnger, {CostAnger, Bo}),
    ?ASSERT(get_gamemoney(Bo) >= CostGamemoney, {CostGamemoney, Bo}),
    ?BT_LOG(io_lib:format("apply_use_skill_costs(), BoId=~p, OldHp=~p, OldMp=~p, OldAnger=~p~n", [BoId, get_hp(Bo), get_mp(Bo), get_anger(Bo)])),
    ?BT_LOG(io_lib:format("apply_use_skill_costs(), BoId=~p, CostHp=~p, CostMp=~p, CostAnger=~p, CostGamemoney:~p~n", [BoId, CostHp, CostMp, CostAnger, CostGamemoney])),

    add_hp(BoId, - CostHp),
    add_mp(BoId, - CostMp),
    add_anger(BoId, - CostAnger),
    add_gamemoney(BoId, - CostGamemoney),
    ?BT_LOG(io_lib:format("apply_use_skill_costs(), BoId=~p, NewHp=~p, NewMp=~p, NewAnger=~p~n", [BoId, get_hp(get_bo_by_id(BoId)), get_mp(get_bo_by_id(BoId)), get_anger(get_bo_by_id(BoId))])),

    void.



%% （使用技能后）更新技能的冷却信息， cd：cool down
update_skill_cd_info(BoId, SklCfg) ->
    ?ASSERT(mod_skill:is_initiative(SklCfg)),
    CdRounds = mod_skill:get_cd_rounds(SklCfg),
    ?ASSERT(is_integer(CdRounds), SklCfg),
    case CdRounds > 0 of
        false ->
            skip;
        true ->
            NewCdOverRound = get_cur_round() + CdRounds + 1,
            Bo = get_bo_by_id(BoId),
            SkillId = mod_skill:get_id(SklCfg),
            case get_skill_brief(Bo, SkillId) of
                null ->
                    ?ASSERT(false, {SkillId, Bo}),
                    skip;
                SklBrief ->
                    NewSklBrief = SklBrief#bo_skl_brf{cd_over_round = NewCdOverRound},
                    OldList = get_initiative_skill_list(Bo),
                    NewList = lists:keyreplace(SkillId, #bo_skl_brf.id, OldList, NewSklBrief),

                    Bo2 = Bo#battle_obj{initiative_skill_list = NewList},
                    update_bo(Bo2)
            end
    end.





  %%%  void.













%%        is_do_dam_by_defer_hp_rate_with_limit = false,
%%        do_dam_by_defer_hp_rate_with_limit_para = Para
%% 新回合开始时重置bo的单回合有效的临时标记
on_new_round_begin(BoId) ->
  Bo = get_bo_by_id(BoId),
  OldTmpRandActSpeed = get_tmp_rand_act_speed(Bo),
  %%这里要特殊处理下wjc
  {OldTmpDO_DAM_BY_DEFER_HP_RATE_WITH_LIMIT, OldTmpdo_dam_by_defer_hp_rate_with_limit_para} =
    case find_buff_by_name(Bo, ?BFN_TMP_MARK_DO_DAM_BY_DEFER_HP_RATE_WITH_LIMIT) /= null of
      true ->
        {Bo#battle_obj.tmp_status#bo_tmp_stat.is_do_dam_by_defer_hp_rate_with_limit, Bo#battle_obj.tmp_status#bo_tmp_stat.do_dam_by_defer_hp_rate_with_limit_para};
      false ->
        {false, invalid}
    end,
  OldTmpforce_pursue_att_dam_coef =
    case find_buff_by_name(Bo, ?BFN_TMP_FORCE_SET_PURSUE_ATT_DAM_COEF) /= null of
      true ->
        Bo#battle_obj.tmp_status#bo_tmp_stat.force_pursue_att_dam_coef;
      false ->
        invalid
    end,

  Oldforce_max_pursue_att_times =
    case find_buff_by_name(Bo, ?BFN_TMP_FORCE_SET_MAX_PURSUE_ATT_TIMES) /= null of
      true ->
        Bo#battle_obj.tmp_status#bo_tmp_stat.force_max_pursue_att_times;
      false ->
        invalid
    end,

  Oldforce_pursue_att_proba =
    case find_buff_by_name(Bo, ?BFN_TMP_FORCE_SET_PURSUE_ATT_PROBA) /= null of
      true ->
        Bo#battle_obj.tmp_status#bo_tmp_stat.force_pursue_att_proba;
      false ->
        invalid
    end,
  {PhyComboMaxTimes, MagComboMaxTimes }= data_special_config:get(combo_att_time),
  {OldTmpforce_phy_combo_att_proba, OldTmpforce_max_phy_combo_att_times} =
    case find_buff_by_name(Bo, ?BFN_TMP_FORCE_SET_PHY_COMBO_ATT_TIMES) /= null of
      true ->
        {Bo#battle_obj.tmp_status#bo_tmp_stat.force_phy_combo_att_proba, max(Bo#battle_obj.tmp_status#bo_tmp_stat.force_max_phy_combo_att_times,PhyComboMaxTimes)};
      false ->

        {invalid, invalid}
    end,


  Bo2 = Bo#battle_obj{
    cur_bhv = ?BHV_IDLE,
    % is_ready = false,
    is_cmd_prepared = false,
    is_show_battle_report_done = false,

    is_just_back_to_battle = false,  % 新回合开始，即清除刚回归战斗的标记！

    is_force_change_to_normal_att = false,

    bo_ids_already_attacked = [],
    % in_phy_combo_att_status = false,

    % base_phy_combo_att_times = 2,  % TODO: 清零基准可连击次数， 这里为了方便测试， 不清掉，而是写死2
    % left_phy_combo_att_times = 0,

    % 重置剩余可追击次数为基准次数
    % left_pursue_att_times = Bo#battle_obj.base_pursue_att_times,


    % is_force_attack = false,  % 强行攻击（只能攻击，不能做其他事情）

    % max_hit_obj_count = 0,  % todo: is it ok???
    % acc_hit_obj_count = 0,


    % max_mag_combo_att_times = 0,
    % acc_mag_combo_att_times = 0,



    % TODO: 确认--有必要???  -- 目前严格一些，新回合开始时都会重置以下字段

    % cur_skill_brief = null,

    % todo: 这个字段也许不需要！
    last_pick_target = Bo#battle_obj.cur_pick_target,

    % TODO： 确认---不重置cur_pick_target，使得其保存的就是上一次所选取的目标， 是否ok？？ 有其他东西需要对应做调整？
    % cur_pick_target = ?INVALID_ID,


    % TODO: 确认： 为了容错，重置指令为普通攻击而不是无效指令。   是否漏了什么东西没做对应的调整？？
    cmd_type = ?CMD_T_NORMAL_ATT,
    cmd_para = 0,

    cur_att_target = ?INVALID_ID,
    cur_skill_brief = null,  %%lib_bt_comm:to_skill_brief({?NORMAL_ATT_SKILL_ID, 0}), %%SkillId,



    regular_protector_list = [],


    tmp_status = #bo_tmp_stat{rand_act_speed = OldTmpRandActSpeed,
      is_do_dam_by_defer_hp_rate_with_limit = OldTmpDO_DAM_BY_DEFER_HP_RATE_WITH_LIMIT,
      do_dam_by_defer_hp_rate_with_limit_para =  OldTmpdo_dam_by_defer_hp_rate_with_limit_para,
      force_pursue_att_dam_coef = OldTmpforce_pursue_att_dam_coef,
      force_max_pursue_att_times = Oldforce_max_pursue_att_times,
      force_pursue_att_proba = Oldforce_pursue_att_proba,
      force_phy_combo_att_proba = OldTmpforce_phy_combo_att_proba,
      force_max_phy_combo_att_times = OldTmpforce_max_phy_combo_att_times,
      force_max_mag_combo_att_times = max(Bo#battle_obj.max_mag_combo_att_times,MagComboMaxTimes)
      }  % 除乱敏外，重置其余单回合的临时状态

    % TODO: 清除bo的其他单回合有效的临时标记
    % ...
  },

    update_bo(Bo2),

    % 结算被动效果
    settle_passi_effs_for_new_round_begin(BoId),

    % 结算buff
    settle_buffs_for_new_round_begin(BoId),

    % TODO: 结算倒地状态
    % settle_fallen_status(BoId),

    ?Ifc (lib_bt_comm:is_bo_exists(BoId))  % 结算buff时，bo有可能因DOT而死亡并且被清掉，故加此判断
        % 结算鬼魂状态
        settle_ghost_status(BoId)
    ?End,

    void.



settle_passi_effs_for_new_round_begin(BoId) ->
    % 先移除过期的被动效果
    remove_expired_passi_effs(BoId),
    % 处理hot类被动效果
    settle_hot_passi_effs_for_nrb(BoId).


%% nrb: new round begin （第一回合不会调用这个函数）
 settle_hot_passi_effs_for_nrb(BoId) ->
    Bo = get_bo_by_id(BoId),
    % 不在死亡时触发的hot

    HotPassiEffList = find_hot_passi_eff_all(Bo),
    BoLv = get_lv(Bo),
    case is_frozen(Bo) orelse is_dead(Bo) of
        true ->
            skip;
        false ->
            F = fun(Eff) ->
                    PassiEffCfg = lib_passi_eff:get_cfg_data(Eff#bo_peff.eff_no),
              ?DEBUG_MSG("wjctestbopeff ~p~n",[PassiEffCfg]),
                    % 暂时认为只有加血、加蓝的hot
                    case Eff#bo_peff.eff_name of
                        ?EN_HOT_HP ->
                            % 目前统一以bo的等级去取心法标准值，策划以后可能会调整规则
                            Val = lib_passi_eff:calc_passi_eff_value_duan2(PassiEffCfg, BoLv),
                            ?BT_LOG(io_lib:format("settle_hot_passi_effs_for_nrb(), add HP, BoId=~p, Val=~p~n", [BoId, Val])),
                          ?DEBUG_MSG("wjctestbopeff2 ~p~n",[{BoLv,Val}]),
                          add_hp(BoId, Val),
                            lib_bt_send:notify_bo_attr_changed_to_all( get_bo_by_id(BoId), [{?ATTR_HP, Val}] );
                        ?EN_HOT_MP ->
                            % 目前统一以bo的等级去取心法标准值，策划以后可能会调整规则
                            Val = lib_passi_eff:calc_passi_eff_add_value(PassiEffCfg, BoLv, ?ATTR_MP),
                            ?BT_LOG(io_lib:format("settle_hot_passi_effs_for_nrb(), add MP, BoId=~p, Val=~p~n", [BoId, Val])),
                            add_mp(BoId, Val),
                            lib_bt_send:notify_bo_attr_changed_to_all( get_bo_by_id(BoId), [{?ATTR_MP, Val}] );
                        _Any ->
                            % ?ERROR_MSG("[lib_bo] settle_hot_passi_effs_for_nrb() error!! unknown hot passi eff:~p", [_Any]),
                            skip
                    end
                end,

            case HotPassiEffList of
                [] ->
                    skip;
                _ ->
                    lists:foreach(F, HotPassiEffList),
                    ?ASSERT(is_living(BoId), BoId), % 处理hot肯定不会导致bo死亡
                    done
            end
    end,

    % 处理可以在死亡时计算的hot
    F1 = fun(Eff) ->
            PassiEffCfg = lib_passi_eff:get_cfg_data(Eff#bo_peff.eff_no),
            % 暂时认为只有加血、加蓝的hot
            case Eff#bo_peff.eff_name of
                % Hot
                ?EN_HOT_PHY_ATT ->
                    Para = PassiEffCfg#passi_eff.para,
                    ?ASSERT(util:is_percent(Para), Para),
                    Round = lib_bt_comm:get_cur_round(),
                    {Rate, DelVal} =
                        case Round rem 5 of
                            0 ->
                                {5 * Para, 0};
                            1 ->
                                case Round > 5 of
                                    false -> {Para, 0};
                                    true ->
                                        case Round =:= 6 of
                                            true ->
                                                {Para, erlang:round(get_init_phy_att(Bo) * 14 * Para)};
                                            false ->
                                                {Para, erlang:round(get_init_phy_att(Bo) * 15 * Para)}
                                        end
                                end;
                            Ret ->
                                {Ret * Para, 0}
                        end,

                    RetVal = erlang:round(get_init_phy_att(Bo) * Rate) - DelVal,
                    add_phy_att(BoId, RetVal),
                    ?BT_LOG(io_lib:format("settle_hot_passi_effs_for_nrb(), EN_HOT_PHY_ATT, Round=~p, BoId=~p, RetVal=~p~n", [Round, BoId, RetVal])),
                    lib_bt_send:notify_bo_attr_changed_to_all( get_bo_by_id(BoId), [{?ATTR_PHY_ATT, RetVal}] );
                ?EN_HOT_MAG_ATT ->
                    Para = PassiEffCfg#passi_eff.para,
                    ?ASSERT(util:is_percent(Para), Para),
                    Round = lib_bt_comm:get_cur_round(),
                    {Rate, DelVal} =
                        case Round rem 5 of
                            0 ->
                                {5 * Para, 0};
                            1 ->
                                case Round > 5 of
                                    false -> {Para, 0};
                                    true ->
                                        case Round =:= 6 of
                                            true ->
                                                {Para, erlang:round(get_init_mag_att(Bo) * 14 * Para)};
                                            false ->
                                                {Para, erlang:round(get_init_mag_att(Bo) * 15 * Para)}
                                        end
                                end;
                            Ret ->
                                {Ret * Para, 0}
                        end,

                    RetVal = erlang:round(get_init_mag_att(Bo) * Rate) - DelVal,
                    add_mag_att(BoId, RetVal),
                    ?BT_LOG(io_lib:format("settle_hot_passi_effs_for_nrb(), EN_HOT_MAG_ATT, Round=~p, BoId=~p, RetVal=~p, CurVal=~p~n", [Round, BoId, RetVal, get_mag_att(get_bo_by_id(BoId))])),
                    lib_bt_send:notify_bo_attr_changed_to_all( get_bo_by_id(BoId), [{?ATTR_MAG_ATT, RetVal}] );
                _Any ->
                    % ?ERROR_MSG("[lib_bo] settle_hot_passi_effs_for_nrb() error!! unknown hot passi eff:~p", [_Any]),
                    skip
            end
        end,

    case HotPassiEffList of
        [] ->
            skip;
        _ ->
            lists:foreach(F1, HotPassiEffList),
            done
    end.





remove_expired_passi_effs(BoId) ->
    Bo = get_bo_by_id(BoId),
    EffList = Bo#battle_obj.passi_effs,
    CurRound = lib_bt_comm:get_cur_round(),
    remove_expired_passi_effs(BoId, EffList, CurRound).


remove_expired_passi_effs(_BoId, [], _CurRound) ->
    done;
remove_expired_passi_effs(BoId, [Eff | T], CurRound) ->
    case CurRound >= Eff#bo_peff.expire_round of
        true -> remove_one_expired_passi_eff(BoId, Eff);
        false -> skip
    end,
    remove_expired_passi_effs(BoId, T, CurRound).






remove_one_expired_passi_eff(BoId, Eff) ->
    Bo = get_bo_by_id(BoId),
    EffList = Bo#battle_obj.passi_effs,
    ?ASSERT(lists:member(Eff, EffList)),
    NewEffList = lists:keydelete(Eff#bo_peff.eff_no, #bo_peff.eff_no, EffList),
    Bo2 = Bo#battle_obj{passi_effs = NewEffList},
    update_bo(Bo2).




find_hot_passi_eff_all(Bo) ->
    EffList = Bo#battle_obj.passi_effs,
    [X || X <- EffList, lib_passi_eff:is_hot(X#bo_peff.eff_no)].







% settle_fallen_status(BoId) ->
%     Bo = get_bo_by_id(BoId),
%     case in_fallen_status(Bo) of
%         true ->
%             do_settle_fallen_status
%         false ->
%             skip
%     end.



settle_ghost_status(BoId) ->
    Bo = get_bo_by_id(BoId),
    case in_ghost_status(Bo)
    andalso (not is_soul_shackled(Bo)) of
        true ->
            do_settle_ghost_status(Bo);
        false ->
            skip
    end.



get_round_when_die(Bo) ->
    Bo#battle_obj.round_when_die.

set_round_when_die(BoId, Round) ->
    ?ASSERT(is_integer(Round)),
    Bo = get_bo_by_id(BoId),
    Bo2 = Bo#battle_obj{round_when_die = Round},
    update_bo(Bo2),
    void.


do_settle_ghost_status(Bo) ->
    case find_passi_eff_by_name(Bo, ?EN_ADD_GHOST_PREP_STATUS) of
        null ->
            ?ASSERT(false, Bo),
            skip;
        Eff ->
            BoId = get_id(Bo),
            CurRound = lib_bt_comm:get_cur_round(),
            WhenDieRound = get_round_when_die(Bo),
            WaitRound = Eff#bo_peff.wait_revive_round_count,

            case CurRound >= WhenDieRound + WaitRound of
                false ->
                    skip;
                true ->
                    HpRate = Eff#bo_peff.hp_rate_on_revive,
                    NewHp = max(util:ceil(HpRate * get_init_hp_lim(Bo)), 1),
                    set_hp(BoId, NewHp),
                    reset_die_status(BoId),  % 勿忘！

                    ?BT_LOG(io_lib:format("do_settle_ghost_status(), bo revive, BoId:~p, HpRate:~p, NewHp:~p~n", [BoId, HpRate, NewHp])),
                    ?BT_LOG(io_lib:format("do_settle_ghost_status(), bo revive, CurRound:~p, WhenDieRound:~p, WaitRound:~p~n", [CurRound, WhenDieRound, WaitRound])),

                    % 通知客户端
                    lib_bt_send:notify_bo_revive_to_all(BoId)
            end
    end.




new_round_begin_buff_eff(BoId) ->  % 添加buff
    % 添加BUFF
    % 删除BUFF

    void.


%% (新回合开始后)结算buff
settle_buffs_for_new_round_begin(BoId) ->
    % old: 废弃
    % % 处理蓄力类的buff
    % handle_xuli_buffs_for_nrb(BoId),

    % % 处理hot，dot类buff
    % handle_hot_and_dot_buffs(BoId),

    % % 统一移除到期的buff
    % remove_expired_buffs(BoId).

    Bo = get_bo_by_id(BoId),

    % 先结算hot， 再结算dot
    settle_hot_buffs_for_nrb(BoId),
    settle_dot_buffs_for_nrb(BoId),

    % 然后再移除到期的buff
    CurRound = lib_bt_comm:get_cur_round(),

    F = fun(Buff) ->
            case lib_bo_buff:is_expired(Buff, CurRound) of
                true ->  % 到期
                    % buff 到期事件
                    handle_buff_expire_events(BoId, Buff),
                    ?TRACE("[lib_bo] settle_buffs_for_new_round_begin(), remove buff for expired, BoId: ~p, Buff:~w~n", [BoId, Buff]),
                    ?BT_LOG(io_lib:format("[lib_bo] settle_buffs_for_new_round_begin(), remove buff for expired, BoId: ~p, Buff:~w~n", [BoId, Buff])),

                    % ?Ifc (lib_bo_buff:can_be_removed(Buff, CurRound))
                        remove_buff(BoId, Buff);
                    % ?End;
                false -> % 未到期
                    skip
            end
        end,

    lists:foreach(F, Bo#battle_obj.buffs),
    mod_battle:try_apply_reborn_eff(BoId),
    % 新回合开始有几率触发的效果
    % new_round_begin_buff_eff(BoId),
    Bo_Latest = get_bo_by_id(BoId),

    % DOT是否导致bo死亡？
    case is_living(Bo) andalso is_dead(Bo_Latest) of
        true ->
            DieDtl = bo_die(Bo_Latest, no_killer, ?DIE_REASON_DOT),
            lib_bt_send:notify_bo_died_to_all(BoId, DieDtl);
        false ->
            skip
    end.



find_hot_buff_all(Bo) ->
    BuffList = Bo#battle_obj.buffs,
    [X || X <- BuffList, lib_bo_buff:is_hot(X)].


find_dot_buff_all(Bo) ->
    BuffList = Bo#battle_obj.buffs,
    [X || X <- BuffList, lib_bo_buff:is_dot(X)].


%% nrb: new round begin
settle_hot_buffs_for_nrb(BoId) ->
    Bo = get_bo_by_id(BoId),
    case is_frozen(Bo) orelse is_dead(Bo) of
        true ->
            skip;
        false ->
            HotBuffList = find_hot_buff_all(Bo),

          F = fun(HotBuff) ->
            %%% EffRealVal = lib_bo_buff:get_eff_para(HotBuff),
            EffRealVal = lib_bo_buff:get_eff_real_value(HotBuff),

            ?ASSERT(is_integer(EffRealVal) andalso EffRealVal >= 0, {EffRealVal, HotBuff, Bo}),

            % hot类BUF也要计算是否禁疗
            AddVal =
              case cannot_be_heal(Bo) of
                true -> 0;
                false -> erlang:round(EffRealVal * get_be_heal_eff_coef(Bo))
              end,
            EffRealVal_2 = lib_bo_buff:get_eff_real_value_2(HotBuff),
            MpAddVal = erlang:round(EffRealVal_2 * get_be_heal_eff_coef(Bo)),

            ActorBoId = HotBuff#bo_buff.from_bo_id,
            ActorSkillId = HotBuff#bo_buff.from_skill_id,
            ActorBo = get_bo_by_id(ActorBoId),
            SkillCfg = data_skill:get(ActorSkillId),
            {FiveElement, FiveElementLv} =case ActorBo of
                                            null ->
                                              {SkillCfg#skl_cfg.five_elements, 1};
                                            _ ->
                                              ActorBo#battle_obj.five_elements
                                          end,
            %%根据五行等级加强技能效果
            {AddVal_1, MpAddVal_1} =
              case SkillCfg#skl_cfg.five_elements == FiveElement of
                true ->
                  case FiveElementLv of
                    0 ->
                      {AddVal,MpAddVal};
                    1 ->
                      ElementData = data_five_elements_level:get(FiveElement,FiveElementLv),
                      {AddVal * (ElementData#five_elements_level.effect_num + 1), MpAddVal* (ElementData#five_elements_level.effect_num + 1)};
                    _ ->
                      ElementData = data_five_elements_level:get(FiveElement,1),
                      ElementData2 = data_five_elements_level:get(FiveElement,2),
                      {AddVal * (ElementData#five_elements_level.effect_num + 1 + ElementData2#five_elements_level.effect_num ),
                        MpAddVal * (ElementData#five_elements_level.effect_num + 1 + ElementData2#five_elements_level.effect_num )}

                  end;
                false ->
                  {AddVal,MpAddVal}
              end,
            %%根据五行相生加强效果
            {TarFiveElement,_} = Bo#battle_obj.five_elements,
            ActorFiveElementData = data_five_elements:get(SkillCfg#skl_cfg.five_elements),

            {AddVal_2,MpAddVal_2} =
              case lists:member(TarFiveElement,ActorFiveElementData#five_elements.restraint) of
                true ->
                  {util:ceil(ActorFiveElementData#five_elements.be_num * AddVal_1), util:ceil(ActorFiveElementData#five_elements.be_num * MpAddVal_1)};
                false ->
                  case lists:member(TarFiveElement,ActorFiveElementData#five_elements.berestraint) of
                    true ->
                      {util:ceil(ActorFiveElementData#five_elements.re_num *AddVal_1), util:ceil(ActorFiveElementData#five_elements.re_num *MpAddVal_1)};
                    false ->
                      {util:ceil(AddVal_1), util:ceil(MpAddVal_1)}
                  end
              end,

            % 暂时认为只有加血、加蓝的hot
            case lib_bo_buff:get_name(HotBuff) of
              ?BFN_HOT_HP ->
                ?BT_LOG(io_lib:format("settle_hot_buffs_for_nrb(), add HP, BoId=~p, EffRealVal=~p~n", [BoId, EffRealVal])),
                add_hp(BoId, AddVal_2),
                lib_bt_send:notify_bo_attr_changed_to_all( get_bo_by_id(BoId), [{?ATTR_HP, AddVal}] );
              ?BFN_HOT_MP ->
                ?BT_LOG(io_lib:format("settle_hot_buffs_for_nrb(), add MP, BoId=~p, EffRealVal=~p~n", [BoId, EffRealVal])),
                add_mp(BoId, AddVal_2),
                lib_bt_send:notify_bo_attr_changed_to_all( get_bo_by_id(BoId), [{?ATTR_MP, AddVal}] );
              ?BFN_HOT_HP_MP -> ?ASSERT(is_integer(EffRealVal_2) andalso EffRealVal_2 >= 0, {EffRealVal_2, HotBuff, Bo}),
                ?BT_LOG(io_lib:format("settle_hot_buffs_for_nrb(), add HP and MP, BoId=~p, EffRealVal=~p, EffRealVal_2=~p~n", [BoId, EffRealVal, EffRealVal_2])),
                add_hp(BoId, AddVal),
                add_mp(BoId, MpAddVal_2),
                lib_bt_send:notify_bo_attr_changed_to_all( get_bo_by_id(BoId), [{?ATTR_HP, AddVal}, {?ATTR_MP, AddVal_2}] );

              % ?BFN_PURGE_BUFF_BY_ROUND_START ->
              % {BaseAdd,QualityAdd,PurgeBuffRule} = Eff#goods_eff.para,
              % {ok, PurgeBuffsDtl} = lib_bo:purge_buff(TargetBoId, PurgeBuffRule),

              _Any ->
                ?ERROR_MSG("[lib_bo] settle_hot_buffs_for_nrb() error!! unknown hot buff:~p", [_Any]),
                skip
            end
              end,

          case HotBuffList of
                [] ->
                    skip;
                _ ->
                    lists:foreach(F, HotBuffList),
                    ?ASSERT(is_living(BoId), BoId), % 处理hot肯定不会导致bo死亡
                    done
            end
    end.




%% nrb: new round begin
settle_dot_buffs_for_nrb(BoId) ->
    Bo = get_bo_by_id(BoId),
    case is_frozen(Bo) orelse is_dead(Bo) of
        true ->
            skip;
        false ->
            DotBuffList = find_dot_buff_all(Bo),

            F = fun(DotBuff) ->
                    EffRealVal = lib_bo_buff:get_eff_real_value(DotBuff),
                    ?ASSERT(is_integer(EffRealVal) andalso EffRealVal >= 0, {EffRealVal, DotBuff, Bo}),
                    case lib_bo_buff:get_name(DotBuff) of
                        ?BFN_DOT_HP ->
                            ?BT_LOG(io_lib:format("settle_dot_buffs_for_nrb(), reduce hp, BoId=~p, EffRealVal=~p~n", [BoId, EffRealVal])),
                            add_hp(BoId, - EffRealVal),
                            lib_bt_send:notify_bo_attr_changed_to_all( get_bo_by_id(BoId), [{?ATTR_HP, - EffRealVal}] );
                        ?BFN_DOT_MP ->
                            add_mp(BoId, - EffRealVal),
                            lib_bt_send:notify_bo_attr_changed_to_all( get_bo_by_id(BoId), [{?ATTR_MP, - EffRealVal}] );
                        ?BFN_DOT_HP_MP ->
                            EffRealVal_2 = lib_bo_buff:get_eff_real_value_2(DotBuff),
                            ?ASSERT(is_integer(EffRealVal_2) andalso EffRealVal_2 >= 0, {EffRealVal_2, DotBuff, Bo}),
                            ?BT_LOG(io_lib:format("settle_dot_buffs_for_nrb(), reduce HP and MP, BoId=~p, EffRealVal=~p, EffRealVal_2=~p~n", [BoId, EffRealVal, EffRealVal_2])),
                            add_hp(BoId, - EffRealVal),
                            add_mp(BoId, - EffRealVal_2),
                            lib_bt_send:notify_bo_attr_changed_to_all( get_bo_by_id(BoId), [{?ATTR_HP, - EffRealVal}, {?ATTR_MP, - EffRealVal_2}] );
                        _Any ->
                            ?ERROR_MSG("[lib_bo] settle_dot_buffs_for_nrb() error!! unknown dot buff:~p", [_Any]),
                            skip
                    end
                end,

            case DotBuffList of
                [] ->
                    skip;
                _ ->
                    ?BT_LOG(io_lib:format("settle_dot_buffs_for_nrb(), BoId=~p, DotBuffList:~w~n", [BoId, DotBuffList])),
                    lists:foreach(F, DotBuffList),
                    done
            end
    end.





bo_die_and_force_leave_battle(Bo) ->
    bo_die__(Bo, true, no_killer, ?DIE_REASON_NORMAL).




bo_die(Bo, Killer) ->
    bo_die(Bo, Killer, ?DIE_REASON_NORMAL).  % 死亡原因默认是：正常死亡


%% 处理bo死亡
%% @para: Bo => 死亡的bo
%%        Killer => no_killer | 造成Bo死亡的bo
%%        DieReason => 死亡原因（详见DIE_REASON_XXX宏）
bo_die(Bo, Killer, DieReason) ->
  ?ASSERT(Killer == no_killer orelse is_record(Killer, battle_obj), Killer),
  %%应策划要求，只要是门客死亡就要离开战场 2019.10.15
  bo_die__(Bo, Bo#battle_obj.type  == ?OBJ_PARTNER, Killer, DieReason).




%% 死亡后更新死亡状态
%% @return: 最新的死亡状态
update_die_status_for_died(BoId, IsForceLeaveBattle, Killer) ->
    NewDieStatus =  case IsForceLeaveBattle of
                        true ->
                            ?DIE_STATUS_DISAPPEAR;
                        false ->
                            Bo = get_bo_by_id(BoId),

                            % 是否携带鬼魂状态
                            case has_ghost_prep_status(Bo) of
                                false ->
                                    % 如果有倒地状态
                                    case has_fallen_prep_status(Bo) of
                                        true ->
                                            ?DIE_STATUS_FALLEN;
                                        false ->  ?DIE_STATUS_DISAPPEAR
                                    end;
                                true ->
                                    case Killer of
                                        no_killer ->
                                            ?DIE_STATUS_GHOST;
                                        _ ->
                                            % 伤害来源是否附带驱鬼效果？
                                            case can_qugui(Killer) of
                                                true ->
                                                    case has_fallen_prep_status(Bo) of
                                                        true ->
                                                            ?DIE_STATUS_FALLEN;
                                                        false ->  ?DIE_STATUS_DISAPPEAR
                                                    end;
                                                false ->
                                                    ?DIE_STATUS_GHOST
                                            end
                                    end
                            end


                    end,
    set_die_status(BoId, NewDieStatus),
    NewDieStatus.








%% @return: die_details结构体
bo_die__(Bo__, IsForceLeaveBattle, Killer, DieReason) ->
    BoId = get_id(Bo__),

    % 记录死亡时的回合数
    CurRound = lib_bt_comm:get_cur_round(),
    set_round_when_die(BoId, CurRound),

    % 重新获取，以确保是最新的
    Bo = get_bo_by_id(BoId),


  ?DEBUG_MSG("wjc test2 ~p~n", [Killer] ),

    ?Ifc (is_partner(Bo))
        lib_bt_dict:set_dead_partner_left_mp(BoId, get_mp(Bo))
    ?End,

    % 死亡后是否需要重置bo的行为状态？？ 目前暂时没必要!
    %% reset_bo_behavior_state(BoId),

    {ok, BuffsRemoved} = remove_buffs_for_died(BoId),


    NewDieStatus = update_die_status_for_died(BoId, IsForceLeaveBattle, Killer),

    ?Ifc (NewDieStatus == ?DIE_STATUS_DISAPPEAR)
        clear_bo_for_died(BoId)  % 从战场清除掉
    ?End,


    KillerLv =
    try
    Killer#battle_obj.lv
    catch
    Error:Reason ->
    ?ERROR_MSG("{Error, Reason, erlang:get_stacktrace()} : ~p~n", [{Error, Reason, erlang:get_stacktrace(),Killer}]),
    250                %未知原因导致Killer偶尔传过来是空的， 如果是空的就默认250
    end,

    do_more_for_bo_died(Bo, DieReason,KillerLv),

    #die_details{
        bo_id = BoId,
        buffs_removed = BuffsRemoved,
        die_status = NewDieStatus
        }.







clear_bo_for_died(BoId) ->
    ?BT_LOG(io_lib:format("clear_bo_after_died(), BoId=~p, BoType=~p~n", [BoId, get_type(get_bo_by_id(BoId))])),
    lib_bt_dict:remove_bo_from_battle_field(BoId).



do_more_for_bo_died(DiedBo, DieReason,Lv) ->
    check_if_battle_finish_for_bo_died(DiedBo, DieReason,Lv).



%% bo死亡后，检测战斗是否结束
check_if_battle_finish_for_bo_died(DiedBo, DieReason, Lv) ->
    case lib_bt_comm:is_world_boss(DiedBo) of
        true ->  % 世界boss bo死亡后则立即判玩家赢
            ?BT_LOG(io_lib:format("world boss died, so mark player win!~n", [])),
            do_mark_battle_finish(?HOST_SIDE);
        false ->
            Side = get_side(DiedBo),

            ?DEBUG_MSG("wjcTest ~p~n", [DiedBo]),

            % 如果死亡对象所在方的全部对象都死了，则判定胜利方是哪一方（考虑到反弹伤害，故有可能平局）
            case lib_bt_comm:are_all_dead(Side) of
                true ->
                    EnemySide = lib_bt_comm:to_enemy_side(Side),
                    case lib_bt_comm:are_all_dead(EnemySide) of
                        true ->  % 平局
                            do_mark_battle_finish(?NO_SIDE);
                        false ->
                            BtlState = lib_bt_comm:get_battle_state(),
                            case lib_bt_comm:is_mf_battle(BtlState) andalso (Side == ?MON_DFL_SIDE) of
                                true ->
                                    CurBMonGrpNo = lib_bt_dict:get_cur_bmon_group_no(),
                                    ?ASSERT(CurBMonGrpNo /= ?INVALID_NO),
                                    CurBMonGrp = lib_bmon_group:get_cfg_data(CurBMonGrpNo),
                                    % 是否有下一波怪？
                                    case decide_next_bmon_group_no(CurBMonGrp) of
                                        ?INVALID_NO ->
                                            do_mark_battle_finish(EnemySide);
                                        NextBMonGrpNo ->
                                            lib_bt_dict:mark_cur_round_should_force_finish(),
                                            ?BT_LOG(io_lib:format("schedule_spawn_next_bmon_group_for_next_round, CurBMonGrpNo:~p, NextBMonGrpNo:~p~n", [CurBMonGrpNo, NextBMonGrpNo])),
                                            schedule_spawn_next_bmon_group_for_next_round(NextBMonGrpNo, DieReason,Lv)
                                    end;
                                false ->
                                    do_mark_battle_finish(EnemySide)
                            end

                            % do_mark_battle_finish(EnemySide)
                    end;
                false ->
                    skip
            end
    end.



do_mark_battle_finish(WinSide) ->
    lib_bt_comm:set_win_side(WinSide),
    lib_bt_comm:mark_battle_finish().




decide_next_bmon_group_no(CurBMonGrp) ->
    L = CurBMonGrp#bmon_group.next_bmon_group_no,
    ?ASSERT(is_list(L), CurBMonGrp),
    case L of
        [] ->
            ?INVALID_NO;
        _ ->
            list_util:rand_pick_one(L)
    end.



schedule_spawn_next_bmon_group_for_next_round(NextBMonGrpNo, DieReason, Lv) ->
    SpawnReason = case DieReason of
                    ?DIE_REASON_DOT -> mon_died_for_dot;
                    _ -> normal
                  end,
    self() ! {'spawn_next_bmon_group_for_next_round', NextBMonGrpNo, SpawnReason,Lv}.



% %% 检查并处理到期的buff
% check_and_handle_expired_buffs(Bo2) ->
%     CurRound = lib_bt_comm:get_cur_round(),
%     F = fun(Buff) ->
%             case lib_bo_buff:is_xuli_buff(Buff) of
%                 true -> % 蓄力类buff单独做处理，故这里跳过
%                     skip;
%                 false ->

%             end
%         end,
%     lists:foreach(F, Bo2#battle_obj.buffs).






% find_xuli_buffs(Bo) ->
%     [BoBuff || BoBuff <- Bo#battle_obj.buffs, BoBuff#bo_buff.buff_name == ?BFN_XULI].




% handle_xuli_buffs_for_new_round_begin(Bo) ->
%     XuliBuffList = find_xuli_buffs(Bo),
%     F = fun(XuliBuff) ->
%             handle_one_xuli_buff(Bo#battle_obj.id, XuliBuff)
%         end,
%     lists:foreach(F, XuliBuffList).




% handle_one_xuli_buff(BoId, XuliBuff) ->
%     case XuliBuff#bo_buff.expire_round > lib_bt_comm:get_cur_round() of
%         true ->
%             skip;
%         false ->  % 蓄力buff已到期
%             handle_buff_expire_events(BoId, XuliBuff)
%     end.



%% 处理buff到期所触发的事件（通常是针对蓄力类型的buff）
handle_buff_expire_events(BoId, Buff) ->
    ExpireEventList = lib_bo_buff:get_expire_events(Buff),
    F = fun(Event) ->
            %%?DEBUG_MSG("[lib_bo] handle_buff_one_expire_event, BoId: ~p, Event: ~p, Buff:~w", [BoId, Event, Buff]),
            handle_buff_one_expire_event(BoId, Buff, Event)
        end,
    lists:foreach(F, ExpireEventList).




handle_buff_one_expire_event(BoId, _Buff, {?BEE_TMP_ADD_PHY_ATT, Value}) ->  % 临时增加物理攻击
    ?ASSERT(is_integer(Value), Value),
    Bo = get_bo_by_id(BoId),

    OldTmpStats = Bo#battle_obj.tmp_status,

    NewTmpPhyAttAdd = max(OldTmpStats#bo_tmp_stat.phy_att_add + Value, 0),


    NewTmpStats = OldTmpStats#bo_tmp_stat{phy_att_add = NewTmpPhyAttAdd},

    update_bo(Bo#battle_obj{tmp_status = NewTmpStats}),
    void;


handle_buff_one_expire_event(BoId, _Buff, {?BEE_TMP_ADD_ACT_SPEED, Value}) -> % 临时提升出手速度
    ?ASSERT(is_integer(Value), Value),
    Bo = get_bo_by_id(BoId),

    OldTmpStats = Bo#battle_obj.tmp_status,

    NewTmpActSpeedAdd = max(OldTmpStats#bo_tmp_stat.act_speed_add + Value, 0),

    NewTmpStats = OldTmpStats#bo_tmp_stat{act_speed_add = NewTmpActSpeedAdd},

    update_bo(Bo#battle_obj{tmp_status = NewTmpStats}),
    void;




% handle_buff_one_expire_event(BoId, {?EN_TMP_FORCE_AUTO_ATTACK}) ->  % 临时强行自动攻击
%     Bo = get_bo_by_id(BoId),
%     OldTmpStats = Bo#battle_obj.tmp_status,
%     NewTmpStats = OldTmpStats#bo_tmp_stat{force_auto_attack = true},

%     Bo2 = Bo#battle_obj{tmp_status = NewTmpStats},
%     update_bo(Bo2),

%     % TODO： 这里的规则有可能会调整，后面再看策划的需求
%     TargetBoId = Bo#battle_obj.last_pick_target,
%     prepare_cmd_use_normal_att(Bo2, TargetBoId),

%     void;


handle_buff_one_expire_event(BoId, Buff, {?BEE_ADD_BUFF, BuffNo}) ->  % 添加buff
    ?ASSERT(lib_buff_tpl:is_exists(BuffNo), BuffNo),

    % Bo = get_bo_by_id(BoId),

    % 目前断言不能叠加
    % ?ASSERT(begin
    %             _BuffTpl = lib_buff_tpl:get_tpl_data(BuffNo),
    %             lib_buff_tpl:get_max_overlap(_BuffTpl) == 1
    %         end, BuffNo),

    %%?DEBUG_MSG("[lib_bo] handle_buff_one_expire_event(), BEE_ADD_BUFF, BuffNo=~p", [BuffNo]),

    FromSkillId = lib_bo_buff:get_from_skill_id(Buff),
    TargetCount = 1,  % 作用目标数固定为1
    case add_buff(BoId, BoId, BuffNo, FromSkillId, TargetCount) of
        {ok, nothing_to_do} ->
            skip;
        {ok, new_buff_added} ->
            ?BT_LOG(io_lib:format("[lib_bo] handle_buff_one_expire_event(), {ok, new_buff_added}, BoId:~p, BuffNo=~p~n", [BoId, BuffNo])),

            Bo_Latest = get_bo_by_id(BoId),

            % 通知客户端移除自己
            lib_bt_send:notify_bo_buff_removed(Bo_Latest, lib_bo_buff:get_no(Buff)),
            lib_bt_send:notify_bo_buff_added(Bo_Latest, BuffNo);
        {ok, old_buff_replaced, OldBuffNo} ->
            Bo_Latest = get_bo_by_id(BoId),
            lib_bt_send:notify_bo_buff_removed(Bo_Latest, OldBuffNo),
            lib_bt_send:notify_bo_buff_added(Bo_Latest, BuffNo);
        _Any ->
            ?ASSERT(false, {_Any, BuffNo}),
            skip
    end,

    void;

% 增加删除BUFF到期事件 用于驱散控制类技能
handle_buff_one_expire_event(BoId, Buff, {?BEE_DEL_BUFF, BuffNo}) ->  % 添加buff
    ?ASSERT(lib_buff_tpl:is_exists(BuffNo), BuffNo),
    Bo_Latest = get_bo_by_id(BoId),

    case find_buff_by_no(Bo_Latest,BuffNo) of
        null ->  % 没有增益buff，提前返回
            skip;
        Buff ->
            remove_buff(BoId, Buff),
            lib_bt_send:notify_bo_buff_removed(Bo_Latest, lib_bo_buff:get_no(Buff))
    end,

    void;



handle_buff_one_expire_event(_BoId, _Buff, _Event) ->
    %%?ERROR_MSG("[lib_bo] handle_buff_one_expire_event() error!!! _BoId:~p, _Event:~w", [_BoId, _Event]),
    ?ASSERT(false, {_BoId, _Event}),
    error.





% clear_bo_ids_already_attacked(Bo) ->
%     Bo#battle_obj{bo_ids_already_attacked = []}.


% clear_bo_ready_flag() ->
%     L = get_all_player_bo_list(),
%     lists:foreach(fun(Bo) -> clear_ready_flag(Bo) end, L).




% %% 命中成功时处理相关的事件
% on_hit_success(_BoId) ->
%     todo_here.

% %% 命中成功时处理相关的事件
% on_dodge_success(_BoId) ->
%     todo_here.

% %% 暴击成功时处理相关的事件
% on_crit_success(_BoId) ->
%     todo_here.





%% 临时标记当前回合攻击时所造成的hp伤害为固定伤害（具体值和心法等级相关）
tmp_mark_do_fix_Hp_dam_by_xinfa_lv(BoId) ->
    ?ASSERT(is_integer(BoId)),
    Bo = get_bo_by_id(BoId),
    OldTmpStatus = Bo#battle_obj.tmp_status,
    NewTmpStatus = OldTmpStatus#bo_tmp_stat{is_do_fix_Hp_dam_by_xinfa_lv = true},
    update_bo( Bo#battle_obj{tmp_status = NewTmpStatus} ),
    void.

%% 临时标记当前回合攻击时所造成的mp伤害为固定伤害（具体值和心法等级相关）
tmp_mark_do_fix_Mp_dam_by_xinfa_lv(BoId) ->
    ?ASSERT(is_integer(BoId)),
    Bo = get_bo_by_id(BoId),
    OldTmpStatus = Bo#battle_obj.tmp_status,
    NewTmpStatus = OldTmpStatus#bo_tmp_stat{is_do_fix_Mp_dam_by_xinfa_lv = true},
    update_bo( Bo#battle_obj{tmp_status = NewTmpStatus} ),
    void.

tmp_mark_do_dam_by_defer_hp_rate_with_limit(BoId, Para) ->
    ?ASSERT(is_integer(BoId)),
    Bo = get_bo_by_id(BoId),
    OldTmpStatus = Bo#battle_obj.tmp_status,
    case Para == invalid of
      true ->
        NewTmpStatus = OldTmpStatus#bo_tmp_stat{
          is_do_dam_by_defer_hp_rate_with_limit = false,
          do_dam_by_defer_hp_rate_with_limit_para = Para
        };
      false ->
        NewTmpStatus = OldTmpStatus#bo_tmp_stat{
          is_do_dam_by_defer_hp_rate_with_limit = true,
          do_dam_by_defer_hp_rate_with_limit_para = Para
        }
    end,
    update_bo( Bo#battle_obj{tmp_status = NewTmpStatus} ),
    void.


get_do_dam_by_defer_hp_rate_with_limit_para(Bo) ->
    TmpStatus = Bo#battle_obj.tmp_status,
    TmpStatus#bo_tmp_stat.do_dam_by_defer_hp_rate_with_limit_para.


is_do_fix_Hp_dam_by_xinfa_lv(Bo) ->
    TmpStatus = Bo#battle_obj.tmp_status,
    TmpStatus#bo_tmp_stat.is_do_fix_Hp_dam_by_xinfa_lv.

is_do_fix_Mp_dam_by_xinfa_lv(Bo) ->
    TmpStatus = Bo#battle_obj.tmp_status,
    TmpStatus#bo_tmp_stat.is_do_fix_Mp_dam_by_xinfa_lv.

is_do_dam_by_defer_hp_rate_with_limit(Bo) ->
    TmpStatus = Bo#battle_obj.tmp_status,
    TmpStatus#bo_tmp_stat.is_do_dam_by_defer_hp_rate_with_limit.




%% 追击
get_tmp_force_pursue_att_proba(Bo) ->
    Bo#battle_obj.tmp_status#bo_tmp_stat.force_pursue_att_proba.

set_tmp_force_pursue_att_proba(BoId, Proba) ->
    Bo = get_bo_by_id(BoId),
    OldTmpStatus = Bo#battle_obj.tmp_status,
    NewTmpStatus = OldTmpStatus#bo_tmp_stat{force_pursue_att_proba = Proba},
    update_bo( Bo#battle_obj{tmp_status = NewTmpStatus} ),
    void.


get_tmp_force_max_pursue_att_times(Bo) ->
    Bo#battle_obj.tmp_status#bo_tmp_stat.force_max_pursue_att_times.

set_tmp_force_max_pursue_att_times(BoId, Times) ->
    Bo = get_bo_by_id(BoId),
    OldTmpStatus = Bo#battle_obj.tmp_status,
    NewTmpStatus = OldTmpStatus#bo_tmp_stat{force_max_pursue_att_times = Times},
    update_bo( Bo#battle_obj{tmp_status = NewTmpStatus} ),
    void.


get_tmp_force_pursue_att_dam_coef(Bo) ->
    Bo#battle_obj.tmp_status#bo_tmp_stat.force_pursue_att_dam_coef.

set_tmp_force_pursue_att_dam_coef(BoId, Val) ->
    Bo = get_bo_by_id(BoId),
    OldTmpStatus = Bo#battle_obj.tmp_status,
    NewTmpStatus = OldTmpStatus#bo_tmp_stat{force_pursue_att_dam_coef = Val},
    update_bo( Bo#battle_obj{tmp_status = NewTmpStatus} ),
    void.



%% 物理连击
get_tmp_force_phy_combo_att_proba(Bo) ->
    Bo#battle_obj.tmp_status#bo_tmp_stat.force_phy_combo_att_proba.

set_tmp_force_phy_combo_att_proba(BoId, Proba) ->
    Bo = get_bo_by_id(BoId),
    OldTmpStatus = Bo#battle_obj.tmp_status,
    NewTmpStatus = OldTmpStatus#bo_tmp_stat{force_phy_combo_att_proba = Proba},
    update_bo( Bo#battle_obj{tmp_status = NewTmpStatus} ),
    void.


get_tmp_force_max_phy_combo_att_times(Bo) ->
    Bo#battle_obj.tmp_status#bo_tmp_stat.force_max_phy_combo_att_times.

set_tmp_kill_target_add_buff(BoId, BuffNo) ->
    Bo = get_bo_by_id(BoId),
    OldTmpStatus = Bo#battle_obj.tmp_status,
    NewTmpStatus = OldTmpStatus#bo_tmp_stat{kill_target_add_buff = BuffNo},
    update_bo( Bo#battle_obj{tmp_status = NewTmpStatus} ),
    void.

set_tmp_select_target_add_buff(BoId, BuffNo) ->
  Bo = get_bo_by_id(BoId),
  OldTmpStatus = Bo#battle_obj.tmp_status,
  NewTmpStatus = OldTmpStatus#bo_tmp_stat{select_first_add_buff = BuffNo},
  update_bo( Bo#battle_obj{tmp_status = NewTmpStatus} ),
  void.

set_tmp_select_target_cause_crite(Bo, State) ->
  OldTmpStatus = Bo#battle_obj.tmp_status,
  NewTmpStatus = OldTmpStatus#bo_tmp_stat{select_first_cause_crit  = State},
  update_bo( Bo#battle_obj{tmp_status = NewTmpStatus} ),
  void.

set_tmp_force_max_phy_combo_att_times(BoId, Times) ->
  Bo = get_bo_by_id(BoId),
  OldTmpStatus = Bo#battle_obj.tmp_status,
  NewTmpStatus = OldTmpStatus#bo_tmp_stat{force_max_phy_combo_att_times = Times},
  update_bo( Bo#battle_obj{tmp_status = NewTmpStatus} ),
  void.


%% 法术连击
get_tmp_force_mag_combo_att_proba(Bo) ->
    Bo#battle_obj.tmp_status#bo_tmp_stat.force_mag_combo_att_proba.

% set_tmp_force_mag_combo_att_proba(BoId, Proba) ->
%     ?ASSERT(util:is_probability(Proba), Proba),
%     Bo = get_bo_by_id(BoId),
%     OldTmpStatus = Bo#battle_obj.tmp_status,
%     NewTmpStatus = OldTmpStatus#bo_tmp_stat{force_mag_combo_att_proba = Proba},
%     update_bo( Bo#battle_obj{tmp_status = NewTmpStatus} ),
%     void.


get_tmp_force_max_mag_combo_att_times(Bo) ->
    Bo#battle_obj.tmp_status#bo_tmp_stat.force_max_mag_combo_att_times.

% set_tmp_force_max_mag_combo_att_times(BoId, Times) ->
%     ?ASSERT(is_integer(Times), Times),
%     Bo = get_bo_by_id(BoId),
%     OldTmpStatus = Bo#battle_obj.tmp_status,
%     NewTmpStatus = OldTmpStatus#bo_tmp_stat{force_max_mag_combo_att_times = Times},
%     update_bo( Bo#battle_obj{tmp_status = NewTmpStatus} ),
%     void.






% %% 获取当前的剩余物理连击次数
% get_left_phy_combo_att_times(Bo) ->
%     Bo#battle_obj.left_phy_combo_att_times.


%% 获取当前回合累计已执行的物理连击次数
get_acc_phy_combo_att_times(Bo) ->
    Bo#battle_obj.tmp_status#bo_tmp_stat.acc_phy_combo_att_times.



%% 递增累计的物理连击次数
incr_acc_phy_combo_att_times(BoId) ->
    Bo = get_bo_by_id(BoId),
    ?ASSERT(Bo /= null, BoId),
    NewTimes = get_acc_phy_combo_att_times(Bo) + 1,  %%Bo#battle_obj.left_phy_combo_att_times - 1,
    OldTmpStatus = Bo#battle_obj.tmp_status,
    NewTmpStatus = OldTmpStatus#bo_tmp_stat{acc_phy_combo_att_times = NewTimes},
    update_bo( Bo#battle_obj{tmp_status = NewTmpStatus} ),
    void.


% %%
% reset_left_phy_combo_att_times(BoId) ->
%     Bo = get_bo_by_id(BoId),
%     Bo2 = Bo#battle_obj{left_phy_combo_att_times = Bo#battle_obj.base_phy_combo_att_times},
%     update_bo(Bo2),
%     Bo2.


%% 清零单回合内累计的物理连击次数
%% @return: 更新后的bo
clear_acc_phy_combo_att_times(BoId) ->
    Bo = get_bo_by_id(BoId),
    OldTmpStatus = Bo#battle_obj.tmp_status,
    NewTmpStatus = OldTmpStatus#bo_tmp_stat{acc_phy_combo_att_times = 0},
    Bo2 = Bo#battle_obj{tmp_status = NewTmpStatus},
    update_bo(Bo2),
    Bo2.



% set_base_phy_combo_att_times(BoId, Times) ->
%     Bo = get_bo_by_id(BoId),
%     Bo2 = Bo#battle_obj{base_phy_combo_att_times = Times},
%     update_bo(Bo2),
%     void.


% %% 临时强行设置的逃跑成功的概率
get_tmp_force_escape_success_proba(Bo) ->
    Bo#battle_obj.tmp_status#bo_tmp_stat.force_escape_success_proba.

set_tmp_force_escape_success_proba(BoId, Proba) ->
    ?ASSERT(util:is_nonnegative_int(Proba), Proba),
    Bo = get_bo_by_id(BoId),
    OldTmpStatus = Bo#battle_obj.tmp_status,
    NewTmpStatus = OldTmpStatus#bo_tmp_stat{force_escape_success_proba = Proba},
    update_bo( Bo#battle_obj{tmp_status = NewTmpStatus} ),
    void.




is_using_single_target_phy_att(Bo) ->
    case is_using_normal_att(Bo) of
        true ->
            true;
        false ->
            case get_cur_skill_cfg(Bo) of
                null ->
                    false;
                CurSklCfg ->
                    % 是主动技， 并且是单体物理攻击
                    RetBool = mod_skill:is_initiative(CurSklCfg) andalso mod_skill:is_single_target_phy_att_skill(CurSklCfg),

                    % % 此case语句仅用于调试
                    % case RetBool of
                    %     true -> ?ASSERT(get_cur_bhv(Bo) == ?BHV_DOING_SINGLE_TARGET_PHY_ATT, {get_cur_bhv(Bo), get_id(Bo), CurSklCfg});
                    %     false -> skip
                    % end,


                    RetBool
            end
    end.


%% 获取物理连击概率（数值放大了1000倍）
get_phy_combo_att_proba(Bo) ->
    RetProba =  case get_tmp_force_phy_combo_att_proba(Bo) of
                    invalid ->
                        RawProba = raw_get_phy_combo_att_proba__(Bo),
                        case is_using_single_target_phy_att(Bo) of
                            true ->
                                % 大力冥王buff的影响
                                case find_buff_by_name(Bo, ?BFN_DALI_MINGWANG) of
                                    null ->
                                        RawProba;
                                    DLMW_Buff ->
                                        AddProba = lib_bo_buff:get_dlmw_add_phy_combo_att_proba(DLMW_Buff),
                                        RawProba + AddProba
                                end;
                            false ->
                                RawProba
                        end;
                    TmpForceProba ->
                        ?ASSERT(util:is_nonnegative_int(TmpForceProba), {TmpForceProba, Bo}),
                        TmpForceProba
                end,

    max(RetProba, 0).  % 保险起见，做矫正



% 加物理连击概率（如果是减，则AddValue传入负值）
add_phy_combo_att_proba(BoId, AddValue) ->
    ?ASSERT(is_integer(AddValue), {AddValue, get_bo_by_id(BoId)}),
    Bo = get_bo_by_id(BoId),
    OldValue = raw_get_phy_combo_att_proba__(Bo),
    NewValue = min(OldValue + AddValue, ?PROBABILITY_BASE),  % 注意：这里不需做最少为0的矫正（考虑到buff的影响，临时呈现为负值是有可能的）
    OldAttrs = Bo#battle_obj.attrs,
    NewAttrs = OldAttrs#attrs{phy_combo_att_proba = NewValue},
    Bo2 = Bo#battle_obj{attrs = NewAttrs},
    update_bo(Bo2),
    void.







%% 获取物理连击次数上限
get_max_phy_combo_att_times(Bo) ->
    RetTimes =
        case get_tmp_force_max_phy_combo_att_times(Bo) of
            invalid ->
                case is_using_single_target_phy_att(Bo) of
                    true ->
                        % 大力冥王buff的影响
                        case find_buff_by_name(Bo, ?BFN_DALI_MINGWANG) of
                            null ->
                                raw_get_max_phy_combo_att_times__(Bo);
                            DLMW_Buff ->
                                AddTimes = lib_bo_buff:get_dlmw_add_max_combo_att_times(Bo,DLMW_Buff),
                                raw_get_max_phy_combo_att_times__(Bo) + AddTimes
                        end;
                    false ->
                        raw_get_max_phy_combo_att_times__(Bo)
                end;

            TmpForceTimes ->
                ?ASSERT(util:is_nonnegative_int(TmpForceTimes), {TmpForceTimes, Bo}),
                TmpForceTimes
        end,

    ?ASSERT(is_integer(RetTimes), RetTimes),
  {PhyMaxTimes, _ } = data_special_config:get(combo_att_time),
    max(RetTimes, PhyMaxTimes).


add_max_phy_combo_att_times(BoId, AddValue) ->
    ?ASSERT(is_integer(AddValue), {AddValue, get_bo_by_id(BoId)}),
    Bo = get_bo_by_id(BoId),
    OldValue = raw_get_max_phy_combo_att_times__(Bo),
    NewValue = OldValue + AddValue,
    Bo2 = Bo#battle_obj{max_phy_combo_att_times = NewValue},
    update_bo(Bo2),
    void.





%% 获取当前回合累计已执行的法术连击次数
get_acc_mag_combo_att_times(Bo) ->
    Bo#battle_obj.tmp_status#bo_tmp_stat.acc_mag_combo_att_times.




incr_acc_mag_combo_att_times(BoId) ->
    Bo = get_bo_by_id(BoId),
    NewTimes = get_acc_mag_combo_att_times(Bo) + 1,  %% Bo#battle_obj.acc_mag_combo_att_times + 1,

    OldTmpStatus = Bo#battle_obj.tmp_status,
    NewTmpStatus = OldTmpStatus#bo_tmp_stat{acc_mag_combo_att_times = NewTimes},

    update_bo( Bo#battle_obj{tmp_status = NewTmpStatus} ),
    void.



%% 获取法术连击概率
get_mag_combo_att_proba(Bo) ->
    RetProba =  case get_tmp_force_mag_combo_att_proba(Bo) of
                    invalid ->
                        raw_get_mag_combo_att_proba__(Bo);
                    TmpForceProba ->
                        ?ASSERT(util:is_nonnegative_int(TmpForceProba), {TmpForceProba, Bo}),
                        TmpForceProba
                end,

    max(RetProba, 0).  % 保险起见，做矫正



% 加法术连击概率（如果是减，则AddValue传入负值）
add_mag_combo_att_proba(BoId, AddValue) ->
    ?ASSERT(is_integer(AddValue), {AddValue, get_bo_by_id(BoId)}),
    Bo = get_bo_by_id(BoId),
    OldValue = raw_get_mag_combo_att_proba__(Bo),
    NewValue = min(OldValue + AddValue, ?PROBABILITY_BASE),  % 注意：这里不需做最少为0的矫正（考虑到buff的影响，临时呈现为负值是有可能的）
    OldAttrs = Bo#battle_obj.attrs,
    NewAttrs = OldAttrs#attrs{mag_combo_att_proba = NewValue},
    Bo2 = Bo#battle_obj{attrs = NewAttrs},
    update_bo(Bo2),
    void.


%% 获取法术连击次数上限
get_max_mag_combo_att_times(Bo) ->
    RetTimes =
        case get_tmp_force_max_mag_combo_att_times(Bo) of
            invalid ->
                raw_get_max_mag_combo_att_times__(Bo);
            TmpForceTimes ->
                ?ASSERT(util:is_nonnegative_int(TmpForceTimes), {TmpForceTimes, Bo}),
                TmpForceTimes
        end,

    ?ASSERT(is_integer(RetTimes), RetTimes),
  {_, MagMaxTimes } = data_special_config:get(combo_att_time),
    max(RetTimes, MagMaxTimes).



set_max_mag_combo_att_times(BoId, Times) ->
    Bo = get_bo_by_id(BoId),
    Bo2 = Bo#battle_obj{max_mag_combo_att_times = Times},
    update_bo(Bo2),
    void.


add_max_mag_combo_att_times(BoId, AddValue) ->
    ?ASSERT(is_integer(AddValue), {AddValue, get_bo_by_id(BoId)}),
    Bo = get_bo_by_id(BoId),
    OldValue = raw_get_max_mag_combo_att_times__(Bo),
    NewValue = OldValue + AddValue,
    Bo2 = Bo#battle_obj{max_mag_combo_att_times = NewValue},
    update_bo(Bo2),
    void.



%% 是否可以物理连击（是否满足连击的条件）？
%% @return: true | false
can_phy_combo_attack(BoId) ->
    % 是否死了？
    case is_dead(BoId) of
        true -> false;
        false ->
            Bo = get_bo_by_id(BoId),
            % AccPursurAttTimes = get_acc_pursue_att_times(Bo),
            % 已经追击的就不能触发连击
            % case AccPursurAttTimes > 0 of
            %    true -> false;
            %    false ->

                    % 当前连击次数是否已达上限？
                    AccTimes = get_acc_phy_combo_att_times(Bo),
                    MaxTimes = get_max_phy_combo_att_times(Bo),

                    CanCombo =
                    case is_using_normal_att(Bo) of
                        true ->
                            true;
                        false ->
                            %
                            case get_cur_skill_cfg(Bo) of
                                null ->
                                    false;
                                CurSklCfg ->
                                    mod_skill:is_can_combo(CurSklCfg)
                            end
                    end,

                    case AccTimes < MaxTimes andalso CanCombo of
                        false -> false;
                        true ->
                            % 是否满足连击消耗？（如mp是否足够）
                            case check_phy_combo_att_costs(Bo) of
                                fail -> false;
                                ok ->
                                    % 是否在物理连击状态？如果是，则不需再判定概率
                                    case in_phy_combo_att_status(Bo) of
                                        true -> true;
                                        false ->
                                            Proba = get_phy_combo_att_proba(Bo),
                                            ?TRACE("can_phy_combo_attack(), BoId=~p, Proba=~p~n", [BoId, Proba]),
                                            case lib_bt_util:test_proba(Proba) of
                                                fail -> ?TRACE("failed for proba!~n"), false;
                                                success ->
                                                    true
                                            end
                                    end
                            end
                    end
            %end
    end.



%% 是否可以法术连击（是否满足连击的条件）？
%% @return: {true, 剩余可打的目标bo id列表} | false
can_mag_combo_attack(AtterId, Old_DeferIdList) ->
    Bo = get_bo_by_id(AtterId),
    % 是否死了？
    case is_dead(AtterId) of
        true -> false;
        false ->
            % 法术连击次数是否已达上限？
            AccTimes = get_acc_mag_combo_att_times(Bo),
            MaxTimes = get_max_mag_combo_att_times(Bo),
            case AccTimes >= MaxTimes of  %%Bo#battle_obj.acc_mag_combo_att_times >= Bo#battle_obj.max_mag_combo_att_times of
                true -> false;
                false ->
                    % 是否满足法术连击的消耗？
                    case check_mag_combo_att_costs(Bo) of
                        fail -> false;
                        ok ->
                            % 判定概率
                            Proba = get_mag_combo_att_proba(Bo),
                            case lib_bt_util:test_proba(Proba) of
                                fail -> false;
                                success ->
                                    % 是否还有合适的目标可打？
                                    Left_DeferIdList = [X || X <- Old_DeferIdList, can_attack(AtterId, X)],
                                    case Left_DeferIdList of
                                        [] -> false;
                                        _ ->
                                            {true, Left_DeferIdList}
                                    end
                            end
                    end
            end
    end.




%% 废弃！！
% %% 尝试进入物理连击状态
% try_get_into_phy_combo_att_status(BoId) ->
%     Bo = get_bo_by_id(BoId),
%     ?ASSERT(Bo /= null, BoId),
%     case can_get_into_phy_combo_att_status(Bo) of
%         true ->
%             Bo2 = clear_acc_phy_combo_att_times(BoId), %%reset_left_phy_combo_att_times(BoId),
%             mark_phy_combo_att_status(Bo2);
%         false ->
%             skip
%     end.




% can_get_into_phy_combo_att_status(_Bo) ->
%     % TODO: 临时随便写， 一半的概率
%     case lib_bt_util:test_proba(500) of
%         success -> true;
%         fail -> false
%     end.




%% 检测物理连击的消耗
%% @return: ok | fail
check_phy_combo_att_costs(_Bo) ->
    ok.   % 目前不需检测，直接返回ok


%% 检测法术连击的消耗
%% @return: ok | fail
check_mag_combo_att_costs(_Bo) ->
    ok.   % 目前不需检测，直接返回ok
