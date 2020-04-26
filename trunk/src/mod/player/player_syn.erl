%%%--------------------------------------
%%% @Module   : player_syn (syn: synchronous)
%%% @Author   : huangjf
%%% @Email    :
%%% @Created  : 2014.1.11
%%% @Description: 同步修改在线玩家数据PS（player_status结构体）的相关接口，
%%%               为了方便上层逻辑进一步做处理，涉及修改PS的接口会统一返回修改后的最新的PS。
%%%               !!!!!注意：本模块的接口因为是同步做修改，故只能在玩家进程中调用，非玩家进程不要调用!!!!!
%%%--------------------------------------
-module(player_syn).
-export([
		update_PS_to_ets/1,

        set_lv/2,
        set_peak_lv/2,
        set_exp/2,
        cost_exp/3,
		set_jingwen/2,
        set_dan/2,
        set_mijing/2,
        set_huanjing/2,
        set_reincarnation/2,

        set_gamemoney/2,
        set_bind_gamemoney/2,
        set_yuanbao/2,
        set_bind_yuanbao/2,
		set_integral/2,
        set_copper/2,
        set_chivalrous/2,
        set_popular/2,
        set_chip/2,
        set_enter_guild_time/2,
        set_vitality/2,
        set_guild_contri/2,
        set_guild_feat/2,
        set_pvp_flee/2,

		set_hp/2,
		set_mp/2,
		set_hp_mp/3,
		set_anger/2,
        set_phy_power/2,

        set_battle_power/2,

        set_base_attrs/2,
        set_equip_add_attrs/2,
        set_xinfa_add_attrs/2,
        set_total_attrs/2,

        set_base_str/2,
        set_base_con/2,
        set_base_stam/2,
        set_base_spi/2,
        set_base_agi/2,
        set_free_talent_points/2,

        add_base_str/2,
        add_base_con/2,
        add_base_stam/2,
        add_base_spi/2,
        add_base_agi/2,
        add_free_talent_points/2,


        set_cur_bhv_state/2,
        set_cur_battle_id/2,
        mark_idle/1,
        mark_battling/2,

        set_showing_equips/2,

        set_store_hp/2,
        set_store_mp/2,
        set_store_par_hp/2,
        set_store_par_mp/2,

        cost_gamemoney/2,
        cost_money/3,
        cost_money/4,


        set_faction/2,
        set_sex/2,
        set_race/2,

        set_soaring/2,
        set_transfiguration_no/2,

        set_guild_id/2,
        set_leave_guild_time/2,
        set_guild_attrs/2,
        set_cultivate_attrs/2,

        set_jingmai_point/2,
        set_jingmai_infos/2,

        set_partner_id_list/2,
        set_partner_capacity/2,
        set_main_partner_id/2,
        set_follow_partner_id/2,
        set_fight_par_capacity/2,

        set_update_mood_count/2,
        set_last_update_mood_time/2,

        set_last_transform_time/2,
		set_day_transform_times/2,
		
        set_team_id/2,
        set_team_target_type/2,
        set_team_condition1/2,
        set_team_condition2/2,
        set_team_lv_range/3,
        set_leader_flag/2,

        set_last_daily_reset_time/2,
        set_last_weekly_reset_time/2,

        set_vip_info/2,

        set_literary/3,
        set_suit_no/2,
        set_name/2,
        set_priv_lv/2

        ,set_xs_task_issue_num/2
        ,set_xs_task_left_issue_num/2
        ,set_xs_task_receive_num/2
        ,set_zf_state/2
        ,set_contri/2
        ,set_mount/2
        ,set_mount_id_list/2
    ]).

-include("common.hrl").
-include("record.hrl").
-include("player.hrl").
-include("attribute.hrl").
-include("obj_info_code.hrl").
-include("num_limits.hrl").
-include("char.hrl").


%% 更新在线玩家数据（player_status结构体）到ets
update_PS_to_ets(PS_Latest) when is_record(PS_Latest, player_status) ->
	mod_svr_mgr:update_online_player_status_to_ets(PS_Latest),
    PS_Latest.


set_lv(#player_status{lv=NewLv}=PS, NewLv) ->  % 参数PS须是当前最新的PS，下同！
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS;
set_lv(PS, NewLv) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 =
        case PS of
            #player_status{lv = OldLv} when NewLv > OldLv ->
                PS1 = PS#player_status{lv=NewLv},
                mod_rank:role_lv(PS1),
                PS1;
            _ ->
                PS#player_status{lv=NewLv}
        end,
    update_PS_to_ets(PS2),
    PS2.  % 返回更新后的PS以便于上层逻辑进一步做处理，下同！

set_peak_lv(#player_status{peak_lv=NewLv}=PS, NewLv) ->  % 参数PS须是当前最新的PS，下同！
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS;
set_peak_lv(PS, NewLv) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 =
        case PS of
            #player_status{peak_lv = OldLv} when NewLv > OldLv ->
                PS1 = PS#player_status{peak_lv=NewLv},
                mod_rank:role_lv(PS1),
                PS1;
            _ ->
                PS#player_status{peak_lv=NewLv}
        end,
    update_PS_to_ets(PS2),
    PS2.  % 返回更新后的PS以便于上层逻辑进一步做处理，下同！

set_exp(#player_status{exp = NewVal}=PS, NewVal) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    update_PS_to_ets(PS),   % 更新世界等级经验
    PS;
set_exp(PS, NewVal) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{exp = NewVal},
    update_PS_to_ets(PS2),
    PS2.

cost_exp(_PS, CostValue, _) when CostValue == 0 ->
    skip;
cost_exp(PS, CostValue, LogInfo) when is_integer(CostValue), CostValue > 0 ->
    NewExp = player:get_exp(PS) - CostValue,
    lib_log:statis_consume_currency(PS, ?MNY_T_EXP, CostValue, LogInfo),
    ply_tips:send_sys_tips(PS, {cost_exp, [CostValue]}),
    player:notify_cli_exp_change(PS, NewExp),
    set_exp(PS, NewExp).

set_gamemoney(#player_status{gamemoney = NewVal}=PS, NewVal) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS;
set_gamemoney(PS, NewVal) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{gamemoney = NewVal},
    mod_rank:role_money(PS2),
    update_PS_to_ets(PS2),
    PS2.

set_copper(PS, NewVal) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{copper = NewVal},
    % mod_rank:role_money(PS2),
    update_PS_to_ets(PS2),
    PS2.

set_chivalrous(PS, NewVal) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{chivalrous = NewVal},
    % mod_rank:role_money(PS2),
    update_PS_to_ets(PS2),
    PS2.

set_jingwen(PS, NewVal) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{jingwen = NewVal},
    % mod_rank:role_money(PS2),
    update_PS_to_ets(PS2),
    PS2.

set_mijing(PS, NewVal) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{mijing = NewVal},
    % mod_rank:role_money(PS2),
    update_PS_to_ets(PS2),
    PS2.

set_huanjing(PS, NewVal) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{huanjing = NewVal},
    % mod_rank:role_money(PS2),
    update_PS_to_ets(PS2),
    PS2.

set_reincarnation(PS, NewVal) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{reincarnation = NewVal},
    % mod_rank:role_money(PS2),
    update_PS_to_ets(PS2),
    PS2.

set_dan(PS, NewVal) when is_record(PS, player_status)->
    PS2 = PS#player_status{dan = NewVal},
    % mod_rank:role_money(PS2),
    update_PS_to_ets(PS2),
    PS2;

set_dan(PlayerId, NewVal) ->
    PS = player:get_PS(PlayerId),
    set_dan(PS, NewVal).


set_popular(PS, NewVal) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{popular = NewVal},
    % mod_rank:role_money(PS2),
    update_PS_to_ets(PS2),

    ply_tips:send_sys_tips(PS, {set_popular, [NewVal]}),
    KV_TupleList = [{?OI_CODE_POPULAR, player:get_popular(PS2)}],
    ?TRACE("player_syn, notify_cli_info_change, KV_TupleList=~p~n", [KV_TupleList]),
    player:notify_cli_info_change(PS2, KV_TupleList),

    PS2.

set_kill_num(PS, NewVal) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{kill_num = NewVal},
    % mod_rank:role_money(PS2),
    update_PS_to_ets(PS2),

    % ply_tips:send_sys_tips(PS, {set_popular, [NewVal]}),
    KV_TupleList = [{?OI_CODE_KILL_NUM, player:get_kill_num(PS2)}],
    ?TRACE("player_syn, notify_cli_info_change, KV_TupleList=~p~n", [KV_TupleList]),
    player:notify_cli_info_change(PS2, KV_TupleList),

    PS2.

set_be_kill_num(PS, NewVal) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{be_kill_num = NewVal},
    % mod_rank:role_money(PS2),
    update_PS_to_ets(PS2),

    % ply_tips:send_sys_tips(PS, {set_popular, [NewVal]}),
    KV_TupleList = [{?OI_CODE_BE_KILL_NUM, player:get_be_kill_num(PS2)}],
    ?TRACE("player_syn, notify_cli_info_change, KV_TupleList=~p~n", [KV_TupleList]),
    player:notify_cli_info_change(PS2, KV_TupleList),

    PS2.

% 设置加入帮派时间
set_enter_guild_time(PS, NewVal) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{enter_guild_time = NewVal},
    update_PS_to_ets(PS2),
    PS2.

% 设置帮派贡献度
set_guild_contri(PS, NewVal) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{guild_contri = NewVal},
    update_PS_to_ets(PS2),
    PS2.

% 设置帮派战功
set_guild_feat(PS, NewVal) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{guild_feat = NewVal},
    update_PS_to_ets(PS2),
    PS2.

set_pvp_flee(PS,NewVal) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{pvp_flee = NewVal},
    update_PS_to_ets(PS2),
    PS2.

set_chip(PS, NewVal) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{chip = NewVal},
    % mod_rank:role_money(PS2),
    update_PS_to_ets(PS2),

    KV_TupleList = [{?OI_CODE_CHIP, player:get_chip(PS2)}],
    ?TRACE("player_syn, notify_cli_info_change, KV_TupleList=~p~n", [KV_TupleList]),
    player:notify_cli_info_change(PS2, KV_TupleList),

    PS2.


set_vitality(PS, NewVal) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{vitality = NewVal},
    update_PS_to_ets(PS2),
    PS2.

set_bind_gamemoney(#player_status{bind_gamemoney = NewVal}=PS, NewVal) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS;
set_bind_gamemoney(PS, NewVal) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{bind_gamemoney = NewVal},
    update_PS_to_ets(PS2).

set_yuanbao(#player_status{yuanbao = NewVal}=PS, NewVal) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS;
set_yuanbao(PS, NewVal) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{yuanbao = NewVal},
    update_PS_to_ets(PS2).

set_bind_yuanbao(#player_status{bind_yuanbao = NewVal}=PS, NewVal) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS;
set_bind_yuanbao(PS, NewVal) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{bind_yuanbao = NewVal},
    update_PS_to_ets(PS2).

set_integral(PS, NewVal) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{integral = NewVal},
    update_PS_to_ets(PS2).



set_hp(PS, Value) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
	Value2 = util:minmax(Value, 0, player:get_hp_lim(PS)), % 避免溢出，下同
	PS2 = PS#player_status{total_attrs = PS#player_status.total_attrs#attrs{hp = Value2}},
	update_PS_to_ets(PS2),
	player:notify_cli_attrs_change(PS, ?ATTR_HP, Value2),  % 顺带通知客户端，下同
	PS2.

set_mp(PS, Value) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
	Value2 = util:minmax(Value, 0, player:get_mp_lim(PS)),
	PS2 = PS#player_status{total_attrs = PS#player_status.total_attrs#attrs{mp = Value2}},
	update_PS_to_ets(PS2),
	player:notify_cli_attrs_change(PS, ?ATTR_MP, Value2),
	PS2.

set_hp_mp(PS, HpVal, MpVal) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
	HpVal2 = util:minmax(HpVal, 0, player:get_hp_lim(PS)),
	MpVal2 = util:minmax(MpVal, 0, player:get_mp_lim(PS)),
	PS2 = PS#player_status{total_attrs = PS#player_status.total_attrs#attrs{hp = HpVal2, mp = MpVal2}},
	update_PS_to_ets(PS2),
	player:notify_cli_attrs_change(PS, [{?ATTR_HP, HpVal2}, {?ATTR_MP, MpVal2}]),
	PS2.

set_anger(PS, Value) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
	Value2 = util:minmax(Value, 0, player:get_anger_lim(PS)),
    PS2 = PS#player_status{total_attrs = PS#player_status.total_attrs#attrs{anger = Value2}},
    update_PS_to_ets(PS2),
    player:notify_cli_attrs_change(PS, ?ATTR_ANGER, Value2),
    PS2.




set_phy_power(PS, Val) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{phy_power = Val},
    update_PS_to_ets(PS2),
    PS2.





set_battle_power(#player_status{battle_power = Val}=PS, Val) ->
    % ?ASSERT(player:this_is_my_own_proc(PS), PS),  % 登录流程会调用此函数，故此断言不合适，屏蔽掉
    PS;
set_battle_power(PS, Val) ->
    % ?ASSERT(player:this_is_my_own_proc(PS), PS),  % 登录流程会调用此函数，故此断言不合适，屏蔽掉
    PS2 = PS#player_status{battle_power = Val},
    mod_rank:role_battle_power(PS2), % 策划高敏要求升降都要在排行上反映
    mod_guild_mgr:try_update_battle_power(PS2),
    update_PS_to_ets(PS2),
    mod_achievement:notify_achi(battle_power_reach, [{num, Val}], PS2),
    PS2.



set_base_attrs(PS, Val) ->
    ?ASSERT(is_record(Val, attrs)),
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{base_attrs = Val},
    update_PS_to_ets(PS2),
    PS2.

set_equip_add_attrs(PS, Val) ->
    ?ASSERT(is_record(Val, attrs)),
    % PS2 = PS#player_status{equip_add_attrs = Val},
    % update_PS_to_ets(PS2),
    % PS2.
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    erlang:put(?PDKN_EQUIP_ADD_ATTRS, Val),
    PS.


set_xinfa_add_attrs(PS, Val) ->
    ?ASSERT(is_record(Val, attrs)),
    % PS2 = PS#player_status{xinfa_add_attrs = Val},
    % update_PS_to_ets(PS2),
    % PS2.
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    erlang:put(?PDKN_XINFA_ADD_ATTRS, Val),
    PS.


set_total_attrs(PS, Val) ->
    ?ASSERT(is_record(Val, attrs)),
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{total_attrs = Val},
    update_PS_to_ets(PS2),
    PS2.


set_base_str(PS, Val) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{base_attrs = PS#player_status.base_attrs#attrs{talent_str = Val}},
    update_PS_to_ets(PS2),
    PS2.  % 返回最新ps，仅仅是为了方便上层函数依赖它做后续处理，下同

set_base_con(PS, Val) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{base_attrs = PS#player_status.base_attrs#attrs{talent_con = Val}},
    update_PS_to_ets(PS2),
    PS2.

set_base_stam(PS, Val) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{base_attrs = PS#player_status.base_attrs#attrs{talent_sta = Val}},
    update_PS_to_ets(PS2),
    PS2.

set_base_spi(PS, Val) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{base_attrs = PS#player_status.base_attrs#attrs{talent_spi = Val}},
    update_PS_to_ets(PS2),
    PS2.

set_base_agi(PS, Val) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{base_attrs = PS#player_status.base_attrs#attrs{talent_agi = Val}},
    update_PS_to_ets(PS2),
    PS2.

set_free_talent_points(PS, Val) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{free_talent_points = Val},
    update_PS_to_ets(PS2),
    PS2.

set_contri(PS, Val) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{contri = Val},
    update_PS_to_ets(PS2),
    PS2.

set_mount(PS, Val) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{mount = Val},
    update_PS_to_ets(PS2),

    PS3 = ply_attr:recount_equip_add_and_total_attrs(imme,PS2),
    PS3.

add_base_str(PS, AddVal) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    OldVal = player:get_base_str(PS),
    NewVal = OldVal + AddVal,
    set_base_str(PS, NewVal).

add_base_con(PS, AddVal) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    OldVal = player:get_base_con(PS),
    NewVal = OldVal + AddVal,
    set_base_con(PS, NewVal).

add_base_stam(PS, AddVal) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    OldVal = player:get_base_stam(PS),
    NewVal = OldVal + AddVal,
    set_base_stam(PS, NewVal).

add_base_spi(PS, AddVal) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    OldVal = player:get_base_spi(PS),
    NewVal = OldVal + AddVal,
    set_base_spi(PS, NewVal).

add_base_agi(PS, AddVal) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    OldVal = player:get_base_agi(PS),
    NewVal = OldVal + AddVal,
    set_base_agi(PS, NewVal).

add_free_talent_points(PS, AddVal) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    OldVal = player:get_free_talent_points(PS),
    NewVal = OldVal + AddVal,
    set_free_talent_points(PS, NewVal).





set_cur_bhv_state(PS, Val) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{cur_bhv_state = Val},
    update_PS_to_ets(PS2),
    PS2.


set_cur_battle_id(PS, Val) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{cur_battle_id = Val},
    update_PS_to_ets(PS2),
    PS2.


mark_idle(PS) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{
                cur_bhv_state = ?BHV_IDLE,
                cur_battle_id = ?INVALID_ID
                },
    update_PS_to_ets(PS2),
    mod_battle_judger:on_unmark_player_battling(PS2),
    PS2.


%% 标记为战斗中（为杜绝玩家同时重复触发战斗，故本接口的实现必须是同步做更新！）
mark_battling(PS, BattleId) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    ?ASSERT(BattleId /= ?INVALID_ID),
    PS2 = PS#player_status{
                cur_bhv_state = ?BHV_BATTLING,
                cur_battle_id = BattleId
                },
    update_PS_to_ets(PS2),
    PS2.



set_showing_equips(PS, Val) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{showing_equips = Val},
    update_PS_to_ets(PS2),
    PS2.



set_store_hp(PS, Value) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    Value2 = util:minmax(Value, 0, ?MAX_U32),
    PS2 = PS#player_status{store_hp = Value2},
    update_PS_to_ets(PS2),
    KV_TupleList = [{?OI_CODE_STORE_HP, player:get_store_hp(PS2)}],
    ?TRACE("player_syn, notify_cli_info_change, KV_TupleList=~p~n", [KV_TupleList]),
    player:notify_cli_info_change(PS2, KV_TupleList),
    PS2.

set_store_mp(PS, Value) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    Value2 = util:minmax(Value, 0, ?MAX_U32),
    PS2 = PS#player_status{store_mp = Value2},
    update_PS_to_ets(PS2),
    KV_TupleList = [{?OI_CODE_STORE_MP, player:get_store_mp(PS2)}],
    ?TRACE("player_syn, notify_cli_info_change, KV_TupleList=~p~n", [KV_TupleList]),
    player:notify_cli_info_change(PS2, KV_TupleList),
    PS2.

set_store_par_hp(PS, Value) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    Value2 = util:minmax(Value, 0, ?MAX_U32),
    PS2 = PS#player_status{store_par_hp = Value2},
    update_PS_to_ets(PS2),
    KV_TupleList = [{?OI_CODE_STORE_PAR_HP, player:get_store_par_hp(PS2)}],
    ?TRACE("player_syn, notify_cli_info_change, KV_TupleList=~p~n", [KV_TupleList]),
    player:notify_cli_info_change(PS2, KV_TupleList),
    PS2.

set_store_par_mp(PS, Value) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    Value2 = util:minmax(Value, 0, ?MAX_U32),
    PS2 = PS#player_status{store_par_mp = Value2},
    update_PS_to_ets(PS2),
    KV_TupleList = [{?OI_CODE_STORE_PAR_MP, player:get_store_par_mp(PS2)}],
    ?TRACE("player_syn, notify_cli_info_change, KV_TupleList=~p~n", [KV_TupleList]),
    player:notify_cli_info_change(PS2, KV_TupleList),
    PS2.


%% 扣钱
%% @return：修改后的PS
cost_gamemoney(PS, CostNum) ->
    cost_money(PS, ?MNY_T_GAMEMONEY, CostNum).

%% 扣钱
%% @return：修改后的PS
cost_money(PS, MoneyType, CostNum) ->
    cost_money(PS, MoneyType, CostNum, []).

%% 扣钱
%% @para: MoneyType => 钱的类型代号（为整数，详见common.hrl）
%% @return：修改后的PS
cost_money(PS, _MoneyType, 0, _) ->
    % ?ASSERT(player:this_is_my_own_proc(PS), PS),
	PS;
cost_money(PS, MoneyType, CostNum, LogInfo) when is_record(PS, player_status), CostNum > 0 ->
    % ?ASSERT(player:this_is_my_own_proc(PS), PS),
	PS2 = case MoneyType of
                ?MNY_T_GUILD_CONTRI -> 
                    cost_money__(PS, guild_contri, util:ceil(CostNum), LogInfo);
                ?MNY_T_GUILD_FEAT ->
                    cost_money__(PS, guild_feat, util:ceil(CostNum), LogInfo);

				?MNY_T_GAMEMONEY ->
                    % lib_log:statis_consume_currency(PS, gamemoney, CostNum, LogInfo),
					cost_money__(PS, gamemoney, util:ceil(CostNum), LogInfo);
				?MNY_T_BIND_GAMEMONEY ->
                    % lib_log:statis_consume_currency(PS, bind_gamemoney, CostNum, LogInfo),
					cost_money__(PS, bind_gamemoney, util:ceil(CostNum), LogInfo);
				?MNY_T_YUANBAO ->
                    % lib_log:statis_consume_currency(PS, yuanbao, CostNum, LogInfo),
					cost_money__(PS, yuanbao, util:ceil(CostNum), LogInfo);
				?MNY_T_BIND_YUANBAO ->
                    % lib_log:statis_consume_currency(PS, bind_yuanbao, CostNum, LogInfo),
					cost_money__(PS, bind_yuanbao, util:ceil(CostNum), LogInfo);
                ?MNY_T_INTEGRAL ->
                    % lib_log:statis_consume_currency(PS, integral, CostNum, LogInfo),
					cost_money__(PS, integral, util:ceil(CostNum), LogInfo);
                ?MNY_T_FEAT ->
                    % lib_log:statis_consume_currency(PS, ?MNY_T_FEAT, CostNum, LogInfo),
                    cost_money__(PS, feat, util:ceil(CostNum), LogInfo);
                ?MNY_T_LITERARY ->
                    cost_money__(PS, literary, util:ceil(CostNum), LogInfo);
                ?MNY_T_VITALITY ->
                    cost_money__(PS, vitality, util:ceil(CostNum), LogInfo);
                ?MNY_T_CHIVALROUS ->
                    cost_money__(PS, chivalrous, util:ceil(CostNum), LogInfo);
			    ?MNY_T_QUJING ->
					cost_money__(PS, jingwen, util:ceil(CostNum), LogInfo);
                ?MNY_T_MYSTERY ->
                  cost_money__(PS, mijing, util:ceil(CostNum), LogInfo);
                ?MNY_T_MIRAGE ->
                  cost_money__(PS, huanjing, util:ceil(CostNum), LogInfo);
                ?MNY_T_REINCARNATION ->
                  cost_money__(PS, reincarnation, util:ceil(CostNum), LogInfo);
                % 消耗筹码
                ?MNY_T_CHIP ->
                    cost_money__(PS, chip, util:ceil(CostNum), LogInfo);
                ?MNY_T_COPPER->
                    cost_money__(PS, copper, util:ceil(CostNum), LogInfo);
                ?MNY_T_EXP -> cost_money__(PS, exp, util:ceil(CostNum), LogInfo)
			end,

	?ASSERT(is_record(PS2, player_status), PS2),
	update_PS_to_ets(PS2), % 同步更新到ets

    % 保存数据库？
    ?TRY_CATCH(player:db_save_data_on_heartbeat(PS2, skip), ErrReason),
	PS2.  % 返回更新后的PS以便于上层逻辑进一步做处理

%% @return: 更改后的PS
cost_money__(PS, MoneyType, CostNum, LogInfo) ->
	?ASSERT(is_record(PS, player_status), PS),
	?ASSERT(util:is_positive_int(CostNum), CostNum),
	?TRACE("[player_syn] cost_money__(), MoneyType=~p, CostNum=~p~n", [MoneyType, CostNum]),
	case MoneyType of
        guild_contri -> 
            ?ASSERT( player:get_guild_contri(PS) >= CostNum),
            NewNum = erlang:max( player:get_guild_contri(PS) - CostNum, 0),  % 稳妥起见，做范围矫正，以免越界，下同
            NewPS = PS#player_status{guild_contri = NewNum},
            player:notify_cli_money_change(NewPS, ?MNY_T_GUILD_CONTRI, NewNum),
            lib_log:statis_consume_currency(PS, ?MNY_T_GUILD_CONTRI, CostNum, LogInfo),
            ply_tips:send_sys_tips(PS, {cost_guild_contri, [CostNum]}),
            NewPS;

        guild_feat ->
            ?ASSERT( player:get_guild_feat(PS) >= CostNum),
            NewNum = erlang:max( player:get_guild_feat(PS) - CostNum, 0),  % 稳妥起见，做范围矫正，以免越界，下同
            NewPS = PS#player_status{guild_feat = NewNum},
            player:notify_cli_money_change(NewPS, ?MNY_T_GUILD_FEAT, NewNum),
            lib_log:statis_consume_currency(PS, ?MNY_T_GUILD_FEAT, CostNum, LogInfo),
            ply_tips:send_sys_tips(PS, {cost_guild_feat, [CostNum]}),
            NewPS;

		gamemoney ->
			?ASSERT( player:get_gamemoney(PS) >= CostNum),
    		NewNum = erlang:max( player:get_gamemoney(PS) - CostNum, 0),  % 稳妥起见，做范围矫正，以免越界，下同
    		NewPS = PS#player_status{gamemoney = NewNum},
            mod_rank:role_money(NewPS),
    		player:notify_cli_money_change(NewPS, ?MNY_T_GAMEMONEY, NewNum),
            ply_tips:send_sys_tips(PS, {cost_gamemoney, [CostNum]}),
            lib_log:statis_consume_currency(NewPS, gamemoney, CostNum, LogInfo),
            NewPS1 = player:check_consume_activity(NewPS, CostNum, gamemoney),
    		NewPS1;
    	bind_gamemoney ->
    		?ASSERT( player:get_bind_gamemoney(PS) >= CostNum),
    		OwnedBindGamemoney = player:get_bind_gamemoney(PS),
            NewNum = OwnedBindGamemoney - CostNum,
            NewPS = PS#player_status{bind_gamemoney = NewNum},
            player:notify_cli_money_change(NewPS, ?MNY_T_BIND_GAMEMONEY, NewNum),
            ply_tips:send_sys_tips(PS, {cost_bind_gamemoney, [CostNum]}),
            lib_log:statis_consume_currency(NewPS, bind_gamemoney, CostNum, LogInfo),
            NewPS1 = player:check_consume_activity(NewPS, CostNum, bind_gamemoney),
            NewPS1;
%%			case OwnedBindGamemoney >= CostNum of
%%				true ->
%%
%%				false ->
%%					% 扣光绑定的游戏币
%%					NewNum = 0,
%%					NewPS = PS#player_status{bind_gamemoney = NewNum},
%%    				player:notify_cli_money_change(NewPS, ?MNY_T_BIND_GAMEMONEY, NewNum),
%%                    case OwnedBindGamemoney > 0 of
%%                        true -> ply_tips:send_sys_tips(PS, {cost_bind_gamemoney, [OwnedBindGamemoney]});
%%                        false -> skip
%%                    end,
%%                    lib_log:statis_consume_currency(NewPS, bind_gamemoney, OwnedBindGamemoney, LogInfo),
%%                    NewPS1 = player:check_consume_activity(NewPS, OwnedBindGamemoney, bind_gamemoney),
%%					% 差额用非绑定的游戏币来补
%%					cost_money__(NewPS1, gamemoney, CostNum - OwnedBindGamemoney, LogInfo)
%%			end;
		yuanbao ->
			?ASSERT( player:get_yuanbao(PS) >= CostNum),
    		NewNum = erlang:max( player:get_yuanbao(PS) - CostNum, 0),
    		NewPS = PS#player_status{yuanbao = NewNum},
    		player:notify_cli_money_change(NewPS, ?MNY_T_YUANBAO, NewNum),
    		player:db_save_yuanbao(NewPS, NewNum), % 对于元宝，即时存到DB
            ply_tips:send_sys_tips(PS, {cost_yuanbao, [CostNum]}),
            lib_log:statis_consume_currency(NewPS, yuanbao, CostNum, LogInfo),
            NewPS1 = player:check_consume_activity(NewPS, CostNum, yuanbao),
    		NewPS1;
    	bind_yuanbao ->
    		?ASSERT( player:get_bind_yuanbao(PS) + player:get_yuanbao(PS) >= CostNum),
    		OwnedBindYB = player:get_bind_yuanbao(PS),
			case OwnedBindYB >= CostNum of
				true ->
					NewNum = OwnedBindYB - CostNum,
    				NewPS = PS#player_status{bind_yuanbao = NewNum},
    				player:notify_cli_money_change(NewPS, ?MNY_T_BIND_YUANBAO, NewNum),
    				player:db_save_bind_yuanbao(NewPS, NewNum),  % 对于绑定元宝，即时存到DB
                    ply_tips:send_sys_tips(PS, {cost_bind_yuanbao, [CostNum]}),
                    lib_log:statis_consume_currency(NewPS, bind_yuanbao, CostNum, LogInfo),
                    NewPS1 = player:check_consume_activity(NewPS, CostNum, bind_yuanbao),
    				NewPS1;
				false ->
					% 扣光绑定的元宝
					NewNum = 0,
					NewPS = PS#player_status{bind_yuanbao = NewNum},
    				player:notify_cli_money_change(NewPS, ?MNY_T_BIND_YUANBAO, NewNum),
    				player:db_save_bind_yuanbao(NewPS, NewNum),  % 对于绑定元宝，即时存到DB
                    case OwnedBindYB > 0 of
                        true -> ply_tips:send_sys_tips(PS, {cost_bind_yuanbao, [OwnedBindYB]});
                        false -> skip
                    end,
                    lib_log:statis_consume_currency(NewPS, bind_yuanbao, OwnedBindYB, LogInfo),
                    NewPS1 = player:check_consume_activity(NewPS, OwnedBindYB, bind_yuanbao),
					% 差额用非绑定的元宝来补
					cost_money__(NewPS1, yuanbao, CostNum - OwnedBindYB, LogInfo)
			end;
        integral ->
            ?ASSERT( player:get_integral(PS) >= CostNum),
            NewNum = erlang:max( player:get_integral(PS) - CostNum, 0),  % 稳妥起见，做范围矫正，以免越界，下同
            NewPS = PS#player_status{integral = NewNum},
            player:notify_cli_money_change(NewPS, ?MNY_T_INTEGRAL, NewNum),
            lib_log:statis_consume_currency(PS, ?MNY_T_INTEGRAL, CostNum, LogInfo),
            ply_tips:send_sys_tips(PS, {cost_integral, [CostNum]}),
		      	player:db_save_integral(NewPS,NewNum),
            NewPS1 = player:check_and_send_integral_reward(NewPS, CostNum);
        feat ->
            ?ASSERT( player:get_feat(PS) >= CostNum),
            NewNum = erlang:max( player:get_feat(PS) - CostNum, 0),  % 稳妥起见，做范围矫正，以免越界，下同
            NewPS = PS#player_status{feat = NewNum},
            player:notify_cli_money_change(NewPS, ?MNY_T_FEAT, NewNum),
            lib_log:statis_consume_currency(PS, ?MNY_T_FEAT, CostNum, LogInfo),
            ply_tips:send_sys_tips(PS, {cost_feat, [CostNum]}),
            NewPS;
        literary ->
            ?ASSERT( player:get_literary(PS) >= CostNum),
            NewNum = erlang:max( player:get_literary(PS) - CostNum, 0),  % 稳妥起见，做范围矫正，以免越界，下同
            NewPS = PS#player_status{literary = NewNum},
            player:notify_cli_money_change(NewPS, ?MNY_T_LITERARY, NewNum),
            ply_tips:send_sys_tips(PS, {cost_literary, [CostNum]}),
            lib_log:statis_consume_currency(PS, ?MNY_T_LITERARY, CostNum, LogInfo),
            NewPS;
        vitality ->
            ?ASSERT( player:get_vitality(PS) >= CostNum),
            NewNum = erlang:max( player:get_vitality(PS) - CostNum, 0),  % 稳妥起见，做范围矫正，以免越界，下同
            NewPS = PS#player_status{vitality = NewNum},
            player:notify_cli_money_change(NewPS, ?MNY_T_VITALITY, NewNum),
            ply_tips:send_sys_tips(PS, {cost_vitality, [CostNum]}),
            lib_log:statis_consume_currency(PS, ?MNY_T_VITALITY, CostNum, LogInfo),
            % player:db_save_vitality(NewPS,NewNum),
            NewPS;

        chivalrous ->
            ?ASSERT( player:get_chivalrous(PS) >= CostNum),
            NewNum = erlang:max( player:get_chivalrous(PS) - CostNum, 0),  % 稳妥起见，做范围矫正，以免越界，下同
            NewPS = PS#player_status{chivalrous = NewNum},
            player:notify_cli_money_change(NewPS, ?MNY_T_CHIVALROUS, NewNum),
            ply_tips:send_sys_tips(PS, {cost_chivalrous, [CostNum]}),
            lib_log:statis_consume_currency(PS, ?MNY_T_CHIVALROUS, CostNum, LogInfo),
            % player:db_save_vitality(NewPS,NewNum),
            NewPS;
        
        chip ->
            ?ASSERT( player:get_chip(PS) >= CostNum),
            NewNum = erlang:max( player:get_chip(PS) - CostNum, 0),  % 稳妥起见，做范围矫正，以免越界，下同            
            NewPS = set_chip(PS,NewNum),
            ply_tips:send_sys_tips(PS, {cost_chip, [CostNum]}),
            lib_log:statis_consume_currency(PS, ?MNY_T_CHIP, CostNum, LogInfo),
            NewPS;

        copper ->
            ?ASSERT( player:get_copper(PS) >= CostNum),
            NewNum = erlang:max( player:get_copper(PS) - CostNum, 0),  % 稳妥起见，做范围矫正，以免越界，下同
            NewPS = PS#player_status{copper = NewNum},
            player:notify_cli_money_change(NewPS, ?MNY_T_COPPER, NewNum),
            ply_tips:send_sys_tips(PS, {cost_copper, [CostNum]}),
            lib_log:statis_consume_currency(PS, ?MNY_T_COPPER, CostNum, LogInfo),
            % player:db_save_copper(NewPS,NewNum),
            NewPS;
		
        jingwen ->
            ?ASSERT( player:get_jingwen(PS) >= CostNum),
            NewNum = erlang:max( player:get_jingwen(PS) - CostNum, 0),  % 稳妥起见，做范围矫正，以免越界，下同
            NewPS = PS#player_status{jingwen = NewNum},
            player:notify_cli_money_change(NewPS, ?MNY_T_QUJING, NewNum),
            ply_tips:send_sys_tips(PS, {cost_jingwen, [CostNum]}),
            lib_log:statis_consume_currency(PS, ?MNY_T_QUJING, CostNum, LogInfo),
            % player:db_save_vitality(NewPS,NewNum),
            NewPS;

        mijing ->
            ?ASSERT( player:get_mijing(PS) >= CostNum),
            NewNum = erlang:max( player:get_mijing(PS) - CostNum, 0),  % 稳妥起见，做范围矫正，以免越界，下同
            NewPS = PS#player_status{mijing = NewNum},
            player:notify_cli_money_change(NewPS, ?MNY_T_MYSTERY, NewNum),
            ply_tips:send_sys_tips(PS, {cost_mijing, [CostNum]}),
            lib_log:statis_consume_currency(PS, ?MNY_T_MYSTERY, CostNum, LogInfo),
            % player:db_save_vitality(NewPS,NewNum),
            NewPS;

        huanjing ->
            ?ASSERT( player:get_huanjing(PS) >= CostNum),
            NewNum = erlang:max( player:get_huanjing(PS) - CostNum, 0),  % 稳妥起见，做范围矫正，以免越界，下同
            NewPS = PS#player_status{huanjing = NewNum},
            player:notify_cli_money_change(NewPS, ?MNY_T_MIRAGE, NewNum),
            ply_tips:send_sys_tips(PS, {cost_huanjing, [CostNum]}),
            lib_log:statis_consume_currency(PS, ?MNY_T_MIRAGE, CostNum, LogInfo),
            % player:db_save_vitality(NewPS,NewNum),
            NewPS;

        reincarnation ->
            ?ASSERT( player:get_reincarnation(PS) >= CostNum),
            NewNum = erlang:max( player:get_reincarnation(PS) - CostNum, 0),  % 稳妥起见，做范围矫正，以免越界，下同
            NewPS = PS#player_status{reincarnation = NewNum},
            player:notify_cli_money_change(NewPS, ?MNY_T_REINCARNATION, NewNum),
            ply_tips:send_sys_tips(PS, {cost_reincarnation, [CostNum]}),
            lib_log:statis_consume_currency(PS, ?MNY_T_REINCARNATION, CostNum, LogInfo),
            % player:db_save_vitality(NewPS,NewNum),
            NewPS;
        exp ->
            cost_exp(PS,CostNum,LogInfo)
	end.


set_faction(PS, Val) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{faction = Val},
    update_PS_to_ets(PS2),
    PS2.

set_sex(PS, Val) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{sex = Val},
    update_PS_to_ets(PS2),
    PS2.

set_soaring(PS, Val) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{soaring = Val},
    update_PS_to_ets(PS2),
    PS2.

set_transfiguration_no(PS, Val) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{transfiguration_no = Val},
    update_PS_to_ets(PS2),
    PS2.

set_race(PS, Val) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{race = Val},
    update_PS_to_ets(PS2),
    PS2.


set_guild_id(PlayerId, GuildId) when is_integer(PlayerId) ->
    case player:get_PS(PlayerId) of
        null ->
            ?ASSERT(false, PlayerId),
            skip;
        PS ->
            set_guild_id(PS, GuildId)
    end;
set_guild_id(PS, GuildId) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{
                guild_id = GuildId
                },
    update_PS_to_ets(PS2),
    gen_server:cast(player:get_pid(PS2), 'send_trigger_msg'),
    PS2.

set_leave_guild_time(PlayerId, LeaveTime) when is_integer(PlayerId) ->
    case player:get_PS(PlayerId) of
        null ->
            ?ASSERT(false, PlayerId),
            skip;
        PS ->
            set_leave_guild_time(PS, LeaveTime)
    end;
set_leave_guild_time(PS, LeaveTime) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{
        leave_guild_time = LeaveTime
    },
    update_PS_to_ets(PS2),
    gen_server:cast(player:get_pid(PS2), 'send_trigger_msg'),
    PS2.


set_guild_attrs(PS, GuildAttrs) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{
                guild_attrs = GuildAttrs
                },
    update_PS_to_ets(PS2),
    PS2.


set_jingmai_point(PS, Point) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{
                jingmai_point = Point
                },
    update_PS_to_ets(PS2),
    PS2.

set_jingmai_infos(PS, JingmaiInfos) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{
                jingmai_infos = JingmaiInfos
                },
    update_PS_to_ets(PS2),
    PS2.

set_cultivate_attrs(PS, GuildAttrs) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{
                cultivate_attrs = GuildAttrs
                },
    update_PS_to_ets(PS2),
    PS2.


set_team_id(PlayerId, TeamId) when is_integer(PlayerId) ->
    case player:get_PS(PlayerId) of
        null ->
            ?ASSERT(false, PlayerId),
            skip;
        PS ->
            set_team_id(PS, TeamId)
    end;
set_team_id(PS, TeamId) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{
                team_id = TeamId
                },
    update_PS_to_ets(PS2),
    PS2.

set_team_target_type(PS, Val) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{team_target_type = Val},
    update_PS_to_ets(PS2),
    PS2.

set_team_condition1(PS, Val) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{team_condition1 = Val},
    update_PS_to_ets(PS2),
    PS2.

set_team_condition2(PS, Val) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{team_condition2 = Val},
    update_PS_to_ets(PS2),
    PS2.


set_team_lv_range(PS, MinLv,MaxLv) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{team_lv_range = {MinLv,MaxLv}},
    update_PS_to_ets(PS2),
    PS2.



set_leader_flag(PlayerId, Flag) when is_integer(PlayerId) ->
    case player:get_PS(PlayerId) of
        null -> skip;
        PS ->
            set_leader_flag(PS, Flag)
    end;
set_leader_flag(PS, Flag) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    ?ASSERT(is_boolean(Flag), Flag),
    PS2 = PS#player_status{
                is_leader = Flag
                },
    update_PS_to_ets(PS2),
    PS2.



set_partner_id_list(PS, PartnerIdList) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{
                partner_id_list = PartnerIdList
                },
    update_PS_to_ets(PS2),
    PS2.

set_mount_id_list(PS, MountIdList) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{
                mount_id_list = MountIdList
                },
    update_PS_to_ets(PS2),
    PS2.


set_partner_capacity(PS, Val) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{partner_capacity = Val},
    update_PS_to_ets(PS2),
    PS2.


set_main_partner_id(PS, Val) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{main_partner_id = Val},
    update_PS_to_ets(PS2),
    PS2.

set_follow_partner_id(PS, Val) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{follow_partner_id = Val},
    update_PS_to_ets(PS2),
    PS2.

set_fight_par_capacity(PS, Val) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{fight_par_capacity = Val},
    update_PS_to_ets(PS2),
    PS2.

set_update_mood_count(PS, Val) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{update_mood_count = Val},
    update_PS_to_ets(PS2),
    PS2.

set_last_update_mood_time(PS, Val) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{last_update_mood_time = Val},
    update_PS_to_ets(PS2),
    PS2.

set_last_transform_time(PS, Val) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{last_transform_time = Val},
    update_PS_to_ets(PS2),
    PS2.

set_day_transform_times(PS, Val) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{day_transform_times = Val},
    update_PS_to_ets(PS2),
    PS2.

set_last_daily_reset_time(PS, Val) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{last_daily_reset_time = Val},
    update_PS_to_ets(PS2),
    PlayerId = player:id(PS),
    db:update(PlayerId, player, [{daily_reset_time, Val}], [{id, PlayerId}]),
    PS2.

set_last_weekly_reset_time(PS, Val) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{last_weekly_reset_time = Val},
    update_PS_to_ets(PS2),
    PS2.


set_vip_info(PS, Val) when is_record(Val, vip) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{vip = Val},
    update_PS_to_ets(PS2),
    PS2.



% 设置学分
set_literary(PS, Literary, Timestamp) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{literary = Literary},
    update_PS_to_ets(PS2),

    % 顺带更新到DB并通知客户端
    PlayerId = player:id(PS),
    db:update(PlayerId, player, [{literary, Literary}, {literary_clear_time, Timestamp}], [{id, PlayerId}]),
    player:notify_cli_money_change(PS, ?MNY_T_LITERARY, Literary),

    PS2.



set_suit_no(PS, Value) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{suit_no = Value},
    update_PS_to_ets(PS2),
    PS2.



set_priv_lv(PS, Value) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{priv_lv = Value},
    update_PS_to_ets(PS2),
    PS2.

set_xs_task_issue_num(PS, Num) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{xs_task_issue_num = Num},
    update_PS_to_ets(PS2),
    PS2.

set_xs_task_left_issue_num(PS, Num) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{xs_task_left_issue_num = Num},
    update_PS_to_ets(PS2),
    PS2.

set_xs_task_receive_num(PS, Num) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{xs_task_receive_num = Num}, 
    update_PS_to_ets(PS2),
    PS2.

set_name(PS, Val) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{nickname = Val},
    update_PS_to_ets(PS2),
    PS2.

set_zf_state(PS, Val) ->
    ?ASSERT(player:this_is_my_own_proc(PS), PS),
    PS2 = PS#player_status{zf_state = Val},
    
    ZfL = lib_team:get_learned_zf_nos(PS),
    L = player:get_zf_state(PS2),
    F = fun(No, Sum) ->
        case lists:member(No, ZfL) of
            true -> Sum;
            false -> Sum + 1
        end
    end,
    case lists:foldl(F, 0, L) > 0 of
        true -> lib_team:notify_team_info_change(PS2, lists:usort(L ++ ZfL));
        false -> skip
    end,
    update_PS_to_ets(PS2),
    PS2.    