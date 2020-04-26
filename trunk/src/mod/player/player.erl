%%%--------------------------------------
%%% @Module   : player
%%% @Author   :
%%% @Email    :
%%% @Created  : 2011.05.10
%%% @Modified : 2013.6.5  -- huangjf
%%% @Description: 玩家相关的常用接口（部分独立系统的接口定义在其他文件，如：ply_xinfa, ply_scene, ply_guild, mod_inv等）
%%%--------------------------------------
-module(player).
-export([
	get_PS/1,
	mark_cross_remote/1, mark_cross_local/1, mark_cross_mirror/1,
	this_is_player_proc/0,
	this_is_my_own_proc/1,
	% --- interfaces about base info ---
	my_ets_online/1,
	id/1, get_id/1,
	local_id/1, get_local_id/1,
	get_server_id/1, get_accname/1, get_from_server_id/1, get_race/1,
	get_faction/1, set_faction/2, is_in_faction/1,
	get_sex/1, get_guild_id/1, set_guild_id/2, get_guild_attrs/1, set_guild_attrs/2,

	get_cultivate_attrs/1, set_cultivate_attrs/2,
	get_unlimited_data/1,

	get_soaring/1,
	set_soaring/2,
	db_save_soaring/2,
	buy_unlimited_resource/3,

	db_save_jingwen/2,
	db_save_dan/2,
	db_save_mijing/2,
	db_save_huanjing/2,
	db_save_reincarnation/2,

	get_transfiguration_no/1,
	set_transfiguration_no/2,
	set_month_card_recharge/2,
	refresh_recharge_accum_data/1,
	refresh_recharge_one/1,
	refresh_consume_activity/2,
	refresh_recharge_accum_day_data/1,

	select_recharge_one_reward/2,
	query_consume_acitvity_open/2,

	get_player_max_lv/1,
	get_player_peak_max_lv/0,
	add_jingwen/3,
	add_mijing/3,
	add_huanjing/3,
	add_reincarnation/3,
	% 成长基金
	reward_growth_fund/3,
	%成长基金
	query_growth_fund_data/1,
	use_grow_fund/3,

	% 设置性别
	set_sex/2,
	db_save_sex/2,
	set_race/2,
	db_save_race/2,

	get_lv/1,get_peak_lv/1,
	get_socket/1, get_sendpid/1,
	get_pid/1, get_name/1, get_login_time/1, get_last_logout_time/1,get_last_transform_time/1,get_day_transform_times/1, get_create_time/1,
	init_position/2, get_position/1, set_position/2, delete_position/1, my_ets_player_position/1, remake_position_rd/4,
	get_prev_pos/1,
	get_scene_id/1, get_xy/1, get_scene_no/1,
	fast_get_my_cur_scene_no/1,
	get_scene_line/1,
	get_move_speed/1,
	get_cur_bhv_state/1, set_cur_bhv_state/2,
	get_phy_power/1, add_phy_power/2,
	get_store_hp/1, add_store_hp/2,
	get_store_mp/1, add_store_mp/2,
	get_store_par_hp/1, add_store_par_hp/2,
	get_store_par_mp/1, add_store_par_mp/2,
	get_update_mood_count/1, set_update_mood_count/2,
	get_last_update_mood_time/1, set_last_update_mood_time/2,
	get_last_daily_reset_time/1, set_last_daily_reset_time/2,
	get_last_weekly_reset_time/1, set_last_weekly_reset_time/2,
	set_last_transform_time/2,
	set_day_transform_times/2,
	
	get_graph_title/1,
	get_text_title/1,
	get_user_def_title/1,

	get_last_proto/0,
	get_accum_online_time/1,
	% get_rela_list/1, set_rela_list/2,

	% --- interfaces about exp and upgrade ---
	get_exp_lim/1, get_exp/1,
	get_peak_exp_lim/1,
	add_exp/2, add_exp/3,
	add_exp_to_main_par/3,
	add_exp_to_fighting_deputy_pars/3,
	add_all_exp/3, add_all_exp/4,
	cost_exp/2, cost_exp/3,
	cost_exp_by_flee/1,
	can_upgrade/1, do_upgrade/1,
	notify_cli_exp_change/2, notify_cli_upgrade/2,
	notify_cli_peak_upgrade/2,
	db_save_exp/2,
	db_save_for_upgrade/1,
	db_save_for_peak_upgrade/1,

	% --- interfaces about money ---
	add_money/4, cost_money/4,
	get_gamemoney/1,  get_bind_gamemoney/1,
	get_yuanbao/1,    get_bind_yuanbao/1,
	add_gamemoney/3,  add_bind_gamemoney/3,
	add_yuanbao/3,    add_bind_yuanbao/3,
	cost_gamemoney/3, cost_bind_gamemoney/3,
	cost_yuanbao/3,   cost_bind_yuanbao/3,

	add_integral/3,	  cost_integral/3,
	get_integral/1,

	% 新增铜币相关接口
	get_copper/1,
	add_copper/3,
	cost_copper/3,
	has_enough_copper/2,

	check_and_send_integral_reward/2,

	% 侠义值
	get_chivalrous/1,
	add_chivalrous/3,
	cost_chivalrous/3,
	cost_jingwen/3,
	cost_mijing/3,
	cost_huanjing/3,
	cost_reincarnation/3,
	has_enough_chivalrous/2,
	has_enough_integral/2,
	has_enough_jingwen/2,
	has_enough_mijing/2,
	has_enough_huanjing/2,
	has_enough_reincarnation/2,

	get_popular/1,
	set_popular/2,
	get_kill_num/1,
	set_kill_num/2,
	get_be_kill_num/1,
	set_be_kill_num/2,

	get_enter_guild_time/1,
	set_enter_guild_time/2,

	get_chip/1,
	set_chip/2,
	add_chip/3,

	cost_chip/3,

	db_save_popular/2,
	db_save_chip/2,

	% 活力值
	get_vitality/1,
	add_vitality/3,
	cost_vitality/3,
	has_enough_vitality/2,

	is_in_guild_battle_scene/1,
	get_jingwen/1,
	get_dan/1,
	get_mijing/1,
	get_huanjing/1,
	get_reincarnation/1,

	has_enough_money/3,
	check_need_price/3,
	check_money_list/2,
	has_enough_gamemoney/2, has_enough_bind_gamemoney/2,
	has_enough_yuanbao/2, has_enough_bind_yuanbao/2,
	notify_cli_money_change/3, db_save_yuanbao/2, db_save_bind_yuanbao/2,

	db_save_gamemoney/2,

	db_save_integral/2,

	db_save_vitality/2,db_save_copper/2,db_save_chivalrous/2,

	get_feat/1, add_feat/2, cost_feat/3, add_feat/3,
	get_guild_contri/1,add_guild_contri/3,cost_guild_contri/3,
	get_guild_feat/1,add_guild_feat/3,cost_guild_feat/3,
	get_leave_guild_time/1,set_leave_guild_time/2,


	get_literary/1, add_literary/3, cost_literary/3, set_literary/3,

	% --- interfaces about talents ---
	get_base_str/1, get_base_agi/1, get_base_stam/1, get_base_con/1, get_base_spi/1,
	get_total_str/1, get_total_agi/1, get_total_stam/1, get_total_con/1, get_total_spi/1,
	get_free_talent_points/1, add_free_talent_points/2, set_free_talent_points/2,
	add_base_str/2, add_base_con/2, add_base_stam/2, add_base_spi/2, add_base_agi/2,
	get_total_talents/1,
	build_talents_bitstring/1,
	db_save_talents/1, db_save_talents/2,db_save_talents/3, db_save_guild_attrs/1, db_save_guild_attrs/2,
	db_save_jingmai/1,db_save_jingmai/2,

	db_save_cultivate_attrs/1, db_save_cultivate_attrs/2,


	% --- interfaces about attributes ---
	get_hp_lim/1, get_base_hp_lim/1,
	get_hp/1, set_hp/2, add_hp/2,
	get_mp_lim/1, get_base_mp_lim/1,
	get_mp/1, set_mp/2, add_mp/2,
	set_hp_mp/3, set_full_hp_mp/1,
	get_phy_att/1, get_mag_att/1,
	get_phy_def/1, get_mag_def/1,
	get_hit/1, get_dodge/1, get_crit/1, get_ten/1,
	get_anger/1, get_anger_lim/1, add_anger/2,
	get_act_speed/1, get_luck/1,
	get_frozen_hit/1, get_frozen_resis/1,
	get_trance_hit/1, get_trance_resis/1,
	get_chaos_hit/1, get_chaos_resis/1,
	get_seal_hit/1, get_seal_resis/1,

	get_phy_crit/1,
	get_phy_ten/1,
	get_mag_crit/1,
	get_mag_ten/1,
	get_phy_crit_coef/1,
	get_mag_crit_coef/1,
	get_heal_value/1,

	% set_phy_crit/2,
	% set_phy_ten/2,
	% set_mag_crit/2,
	% set_mag_ten/2,
	% set_phy_crit_coef/2,
	% set_mag_crit_coef/2,

	get_yuanbao_acc/1,

	get_do_phy_dam_scaling/1, get_do_mag_dam_scaling/1,
	get_crit_coef/1,
	% get_ret_dam_proba/1, get_ret_dam_coef/1,

	notify_cli_talents_change/1,
	notify_cli_attrs_change/2, notify_cli_attrs_change/3,
	notify_cli_info_change/2, notify_cli_info_change/3, notify_cli_info_change_2/3,

	% --- interfaces abount partner ---
	% has_fighting_partner/1,
	% get_fighting_partner_id/1,
	% set_fighting_partner_id/2,
	% clear_fighting_partner_id/1,
	% get_fighting_partner/1,
	get_partner_id_list/1, set_partner_id_list/2,
	get_partner_capacity/1, set_partner_capacity/2, add_partner_capacity/2,
	get_main_partner_id/1, set_main_partner_id/2,
	get_follow_partner_id/1, set_follow_partner_id/2,
	get_fight_par_capacity/1, set_fight_par_capacity/2,
	has_partner/2,


	is_online/1, set_online/2,
	in_tmplogout_cache/1,  force_mark_not_in_tmplogout_cache/1,
	is_in_team/1, is_leader/1, is_tmp_leave_team/1, is_in_team_but_not_leader/1, is_in_team_and_not_tmp_leave/1,
	are_in_same_team/2,
	get_team_id/1, clear_team_id/1, set_team_id/2,
	get_leader_id/1,
	get_team_target_type/1, get_team_condition1/1, set_team_target_type/2, set_team_condition1/2, get_team_condition2/1, set_team_condition2/2,
	get_team_lv_range/1,set_team_lv_range/3,
	mark_leader_flag/1, clear_leader_flag/1,
	is_vip/1, get_vip_lv/1,
	get_vip_expire_time/1, is_vip_experience/1,
	set_vip_info/2,
	get_suit_no/1,set_suit_no/2,

	is_in_dungeon/1,
	get_dungeon_no/1,
	get_dungeon_type/1,
	get_check_dungeon_no/1,
	% is_in_mf_dungeon/1,
	is_in_guild/1,
	is_in_guild_scene/1,
	is_in_melee_scene/1,
	is_auto_battle/1,
	is_in_melee/1,

	is_player_exist/1,

	already_learned_troop/2,
	already_learned_anyone_troop/1,
	already_activate_troop/1,


	notify_equip_changed_to_neig/2,

	%% 经脉
	get_jingmai_infos/1,
	set_jingmai_infos/2,
	set_jingmai_infos/3,

	get_jingmai_point/1,
	set_jingmai_point/2,
	set_jingmai_point/3,

	is_battling/1,
	mark_battling/2,
	get_cur_battle_pid/1,
	get_cur_battle_id/1,

	mark_busy/1, mark_idle/1,
	is_idle/1, is_offline_guaji/1,is_arena_1v1_waiting/1,is_arena_1v1_ready/1,is_arena_3v3_waiting/1,is_arena_3v3_ready/1,

	rename/2,

	db_save_base_data/1,
	db_save_data_on_heartbeat/2,
	db_save_position/4,

	get_showing_equips/1, set_showing_equips/2, get_showing_equips_base_setting/1,

	get_final_logout_delay/0, set_final_logout_delay/1,
	get_admin_callback_pid/0, set_admin_callback_pid/1,

	%% === recharge ===
	admin_recharge/5, notify_player_recharge/1, recharge/1, send_first_recharge_reward/1, notify_recharge_state/1,
	recharge_feedback/1, recharge_feedback_add_money/2, parse_web_recharge_data/1, parse_web_recharge_data2/1, parse_lotto_data/1, set_recharge_accum/3, set_recharge_accum/4,
	check_consume_activity/3,  query_accum_activity_amount/2, use_month_card/2,

	forever_ban_chat/2, cancel_ban_chat/2, ban_chat/3, offline_ban_chat/3, ban_role/3, is_role_banned/1, is_chat_banned/1,
	kick_role_offline_immediate/1, kick_role_offline/1

	,get_xs_task_issue_num/1,set_xs_task_issue_num/2
	,get_xs_task_left_issue_num/1,set_xs_task_left_issue_num/2
	,get_xs_task_receive_num/1,set_xs_task_receive_num/2

	,get_zf_state/1, set_zf_state/2
	,get_contri/1, set_contri/2, notify_cli_contri_change/1, db_save_contri/1, db_save_contri/2
	,set_recharge_accum_day/4
	,get_mount/1, set_mount/2, notify_cli_mount_change/1, db_save_mount/1, db_save_mount/2
	,get_mount_id_list/1,set_mount_id_list/2
	,recharge_ratio/0
	,query_month_card_data/1
	,reward_month_card/2
	,get_recharge_accum/2
	,first_recharge_reward/2
	,notify_recharge_sum/1
	,add_recharge_sum/2
	,update_first_recharge/2
	,notice_first_recharge/1
	,login_reward_day/1
	,give_first_recharge_reward/1
	,create_role_reward/2
	,recharge_accumulated/2
]).

-compile({inline, [get_PS/1, id/1, get_id/1, get_socket/1,
	%%get_position/1, set_position/2,
	get_race/1, get_faction/1, get_sex/1,
	get_hp/1,get_hp_lim/1,
	get_mp/1, get_mp_lim/1,
	get_phy_att/1, get_mag_att/1, get_phy_def/1, get_mag_def/1,
	get_hit/1, get_dodge/1, get_crit/1, get_ten/1,
	get_anger/1, get_anger_lim/1,
	get_act_speed/1, get_luck/1,
	get_move_speed/1,
	get_exp/1, get_exp_lim/1, get_peak_exp_lim/1,
	get_gamemoney/1, get_bind_gamemoney/1, get_yuanbao/1, get_bind_yuanbao/1
]
}).

-include("common.hrl").
-include("record.hrl").
-include("player.hrl").
-include("arena.hrl").
-include("goods.hrl").
-include("num_limits.hrl").
-include("attribute.hrl").
-include("ets_name.hrl").
-include("ban.hrl").
-include("pt_13.hrl").
-include("skill.hrl").
-include("obj_info_code.hrl").
-include("scene.hrl").
-include("abbreviate.hrl").
-include("record/goods_record.hrl").
-include("bo.hrl").
-include("scene_line.hrl").
-include("log.hrl").
-include("xinfa.hrl").
-include("char.hrl").
-include("guild_battle.hrl").
-include("prompt_msg_code.hrl").
-include("growth_fund.hrl").
-include("global_sys_var.hrl").
-include("reward.hrl").
-include("admin_activity.hrl").
-include("reincarnation.hrl").

% %% 检查协议处理的cd（对于部分协议，如果想避免太频繁去做处理，可以调用该接口做下判断）
% %% @para: PS => 玩家状态（player_status结构体）
% %%        TimeNow_MS => 当前的时间戳（毫秒）
% %%        CDTime_MS => 协议处理的cd（毫秒），由函数调用者针对不同的协议，灵活决定
% %% @return: fail | ok
% check_handle_proto_cd(PS, TimeNow_MS, CDTime_MS) ->
% 	case TimeNow_MS >= (PS#player_status.last_handle_proto_time + CDTime_MS) of
% 		true ->
% 			ok;
% 		false ->
% 			fail
% 	end.



% %% 记录玩家上次处理协议的时间戳（毫秒）
% record_last_handle_proto_time(PS, TimeNow_MS) ->
% 	asyn_update_PS_fields(PS, ?PSF_LAST_HANDLE_PROTO_TIME, TimeNow_MS).



%% 获取在线玩家结构体
%% @return: null | player_status结构体
get_PS(PlayerId) ->
	mod_svr_mgr:get_online_player_status(PlayerId).


%% 作废！！
% %% 获取离线玩家结构体
% %% @return: null | player_status结构体
% get_offline_PS(PlayerId) ->
% 	mod_svr_mgr:get_offline_player_status(PlayerId).


% %% 更新离线玩家结构体
% update_offline_PS(PS_Latest)
%   when is_record(PS_Latest, player_status) ->
% 	mod_svr_mgr:update_offline_player_status(PS_Latest).



%% 本进程是否为玩家进程？
%% @return: true | false
this_is_player_proc() ->
	case erlang:get(?PDKN_PLAYER_PROC_FLAG) of
		undefined -> false;
		_ -> true
	end.


%% 本进程是否为玩家自己对应的玩家进程？
%% @return: true | false
this_is_my_own_proc(MyId) when is_integer(MyId) ->
	this_is_player_proc() andalso (erlang:get(?PDKN_PLAYER_ID) =:= MyId);

this_is_my_own_proc(MyPS) when is_record(MyPS, player_status) ->
	MyId = get_id(MyPS),
	this_is_my_own_proc(MyId).



%% ------------------ functions abount player's base info BEGIN -----------------------

%% 等价于get_id(PS)
id(PlayerId) when is_integer(PlayerId) -> PlayerId;
id(PS) -> PS#player_status.id.

%% 获取玩家id
get_id(PS) -> PS#player_status.id.


%% 等价于get_local_id(PS)
local_id(PS) -> PS#player_status.local_id.

get_local_id(PS) -> PS#player_status.local_id.


%% 获取玩家所在服务器的id
get_server_id(PS) -> PS#player_status.server_id.


%% 获取账户名
get_accname(PS) -> PS#player_status.accname.


get_from_server_id(PS) -> PS#player_status.from_server_id.

%% 获取名字
get_name(PlayerId) when is_integer(PlayerId) ->
	case get_PS(PlayerId) of
		null ->
			mod_offline_data:get_name(PlayerId);
		PS ->
			PS#player_status.nickname
	end;

get_name(PS) ->
	PS#player_status.nickname.


%% 获取当前图片的称号
get_graph_title(PS) ->
	UID = id(PS),
	ply_title:get_graph_title(UID).

%% 获取当前文字称号
get_text_title(PS) ->
	UID = id(PS),
	ply_title:get_text_title(UID).

%% 获取当前自定义的称号
get_user_def_title(PS) ->
	UID = id(PS),
	ply_title:get_user_def_title(UID).



%% 获取种族
get_race(PlayerId) when is_integer(PlayerId) ->
	case get_PS(PlayerId) of
		null ->
			mod_offline_data:get_race(PlayerId);
		PS ->
			get_race(PS)
	end;
get_race(PS) -> PS#player_status.race.


%% 获取门派
get_faction(PlayerId) when is_integer(PlayerId) ->
	case get_PS(PlayerId) of
		null ->
			mod_offline_data:get_faction(PlayerId);
		PS ->
			get_faction(PS)
	end;
get_faction(PS) ->
	PS#player_status.faction.

set_faction(PS, Faction) ->
	asyn_update_PS_fields(PS, ?PSF_FACTION, Faction).

set_sex(PS, Sex) ->
	asyn_update_PS_fields(PS, ?PSF_SEX, Sex).

db_save_sex(PlayerId, NewSex) when is_integer(PlayerId) ->
	db:update(player, ["sex"], [NewSex], "id", PlayerId).




set_race(PS, Race) ->
	asyn_update_PS_fields(PS, ?PSF_RACE, Race).

db_save_race(PlayerId, NewRace) when is_integer(PlayerId) ->
	db:update(player, ["race"], [NewRace], "id", PlayerId).


%% 是否在门派中（即是否已经加入门派了）？
is_in_faction(PS) ->
	get_faction(PS) /= ?FACTION_NONE.


%[{基金编号,购买基金时间戳,[{领取等级，领取时间}]},...]
%% 设置经济基金
set_fund_recharge(Status, Type) ->
	NowTime = util:unixtime(),
	GrowFundState = Status#player_misc.grow_fund,
	NewState =
		case lists:keyfind(Type, 1, GrowFundState) of
			false -> [{Type, NowTime, []} | GrowFundState];
			{Type, _, _} ->
				lists:keyreplace(Type, 1, GrowFundState, {Type, NowTime, []})
		end,
	Status#player_misc{grow_fund = NewState}.


%% @成长基金功能
%% ! 玩家进程执行
%% @return : boolean()
use_grow_fund(PSStatus,Misc_Status, Type) when is_record(Misc_Status, player_misc)  ->
	try

		MiscStatus2 = set_fund_recharge(Misc_Status, Type),
		db:update(player_misc,
			[{grow_fund, util:term_to_bitstring(MiscStatus2#player_misc.grow_fund)}],
			[{player_id, MiscStatus2#player_misc.player_id}]),
		send_first_recharge_reward(PSStatus),
		notify_recharge_state(PSStatus),

		ply_misc:update_player_misc(MiscStatus2),
		query_growth_fund_data(PSStatus),
		true

	catch
		_T:_E -> ?ERROR_MSG("use_fund_card error = ~p~n", [{_T, _E}]), false
	end.

%% 查询成长基金的数据
query_growth_fund_data(Status) ->
	Misc_Status = ply_misc:get_player_misc(player:id(Status)),
	FundState = Misc_Status#player_misc.grow_fund,
	%成长基金，格式如：[{基金编号,购买基金时间戳,[{领取等级,领取时间}]},...]
	Fun = fun({Type, _TimeUnix, L}, Acc) ->
		StateL = lists:foldl(fun({Lv, _Time}, A) ->
			[{Lv, 1}|A]
												 end, [], L),
		[{Type, StateL}|Acc]
				end,
	Datas = lists:foldl(Fun, [], FundState),
	{ok, BinData} = pt_13:write(?PT_PLYR_CHECK_FUND, [Datas]),
	lib_send:send_to_uid(player:get_id(Status), BinData),
	ok.

%% 领取成长基金奖励
reward_growth_fund(Status, Type,Lv) ->
	RoleId = player:get_id(Status),
	Misc_Status = ply_misc:get_player_misc(player:id(Status)),
	NowTime = util:unixtime(),
	case lists:keytake(Type, 1, Misc_Status#player_misc.grow_fund) of
		{value, {Type, BuyTime, L},FundState } ->
			%%             StateL = lists:foldl(fun({Lv, _Time}, A) ->
			%% 											0
			%% 									   end, [], L),
			case lists:keymember(Lv, 1, L) of
				true ->%% 已领
					{ok, BinData} = pt_13:write(?PT_PLYR_GET_FUND, [998]),
					lib_send:send_to_uid(RoleId, BinData),
					ok;

				false ->
					case data_growth_fund:get(Type, Lv) of
						null ->
							err;
						GrowthFun ->
							NewMisc_Status = [{Type, BuyTime, [{Lv,NowTime}|L]}| FundState],
							Misc_Status2 = Misc_Status#player_misc{grow_fund = NewMisc_Status},
							db:update(player_misc,
								[{grow_fund, util:term_to_bitstring(Misc_Status2#player_misc.grow_fund)}],
								[{player_id, player:id(Status)}]),
							ply_misc:update_player_misc(Misc_Status2),
							lists:foreach(fun({MoneyType,MoneyCount}) ->
								player:add_money(Status, MoneyType, MoneyCount, [?LOG_GIF, "grow"])
														end, GrowthFun#growth_fund.reward),
							%%                 player:add_yuanbao(Status, MoneyCount, [?LOG_GIF, "grow"]),
							%% 				   player:add_money(PS, MoneyType, AddNum, LogInfo)
							%[{基金编号,购买基金时间戳,[{领取等级，领取时间}]},...]
							%% 					NewMisc_Status = [{No,BuyTime, [{Lv,NowTime}]| FundState],
							{ok, BinData} = pt_13:write(?PT_PLYR_GET_FUND, [0]),
							lib_send:send_to_uid(RoleId, BinData),
							ok
					end
			end;
		false ->
			%% 无
			{ok, BinData} = pt_13:write(?PT_PLYR_GET_FUND, [998]),
			lib_send:send_to_uid(RoleId, BinData),
			ok
	end.



%% 获取等级
get_lv(PlayerId) when is_integer(PlayerId) ->
	case get_PS(PlayerId) of
		null ->
			mod_offline_data:get_lv(PlayerId);
		PS -> PS#player_status.lv
	end;
get_lv(PS) ->
	PS#player_status.lv.

%% 获取巅峰等级
get_peak_lv(PlayerId) when is_integer(PlayerId) ->
	case get_PS(PlayerId) of
		null ->
			mod_offline_data:get_peak_lv(PlayerId);
		PS -> PS#player_status.peak_lv
	end;
get_peak_lv(PS) ->
	PS#player_status.peak_lv.


%% 获取性别
get_sex(PlayerId) when is_integer(PlayerId) ->
	case get_PS(PlayerId) of
		null ->
			mod_offline_data:get_sex(PlayerId);
		PS ->
			get_sex(PS)
	end;
get_sex(PS) -> PS#player_status.sex.

% 获取飞升
get_soaring(PS) -> PS#player_status.soaring.

get_transfiguration_no(PS) -> PS#player_status.transfiguration_no.


% 返回最大等级上限 为飞升等级*10 + 基础等级限制
get_player_max_lv(PS) ->
	Soaring = get_soaring(PS),
	case data_soaring_config:get(Soaring) of
		#soaring_config{
			% id = Id,
			% goods = Goods,
			% need_lv = Need_lv,
			lv_limit = Lv_limit
		} -> Lv_limit;
		_ -> ?PLAYER_MAX_LV
	end.

% 返回巅峰最大等级上限
get_player_peak_max_lv() ->
	data_special_config:get('reincarnation_upper_limit').

% ?PLAYER_MAX_LV + Soaring * 10.

% 飞升
set_soaring(PS, Soaring) ->
	asyn_update_PS_fields(PS, ?PSF_SOARING, Soaring).

set_transfiguration_no(PS, TransfigurationNo) ->
	asyn_update_PS_fields(PS, ?PSF_TRANSFIGURATION_NO, TransfigurationNo).

db_save_soaring(PlayerId, NewSoaring) when is_integer(PlayerId) ->
	lib_player_ext:try_update_data(PlayerId,soaring,NewSoaring).
% db:update(player, ["soaring"], [NewSoaring], "id", PlayerId).


get_guild_id(PlayerId) when is_integer(PlayerId) ->
	case get_PS(PlayerId) of
		null ->
			?INVALID_ID;
		PS ->
			get_guild_id(PS)
	end;
get_guild_id(PS) ->
	PS#player_status.guild_id.


set_guild_id(PlayerId, GuildId) when is_integer(PlayerId) ->
	case get_PS(PlayerId) of
		null -> skip;
		PS -> set_guild_id(PS, GuildId)
	end;
set_guild_id(PS, GuildId) ->
	?ASSERT(is_record(PS, player_status)),
	asyn_update_PS_fields(PS, ?PSF_GUILD_ID, GuildId).

get_leave_guild_time(PlayerId) when is_integer(PlayerId) ->
	case get_PS(PlayerId) of
		null ->
			?INVALID_ID;
		PS ->
			get_leave_guild_time(PS)
	end;
get_leave_guild_time(PS) ->
	PS#player_status.leave_guild_time.


set_leave_guild_time(PlayerId, LeaveTime) when is_integer(PlayerId) ->
	case get_PS(PlayerId) of
		null -> skip;
		PS -> set_leave_guild_time(PS, LeaveTime)
	end;
set_leave_guild_time(PS, LeaveTime) ->
	?ASSERT(is_record(PS, player_status)),
	asyn_update_PS_fields(PS, ?PSF_LEAVE_GUILD_TIME, LeaveTime).

set_popular(PlayerId,Value) when is_integer(PlayerId) ->
	lib_player_ext:try_update_data(PlayerId,popular,Value);

set_popular(PS,Value) ->
	?ASSERT(is_record(PS, player_status)),
	V = erlang:max(Value,0),
	asyn_update_PS_fields(PS, ?PSF_POPULAR, V).


set_kill_num(PS,Value) ->
	?ASSERT(is_record(PS, player_status)),
	V = erlang:max(Value,0),
	asyn_update_PS_fields(PS, ?PSF_KILL_NUM, V).

set_be_kill_num(PS,Value) ->
	?ASSERT(is_record(PS, player_status)),
	V = erlang:max(Value,0),
	asyn_update_PS_fields(PS, ?PSF_BE_KILL_NUM, V).

set_enter_guild_time(PS,Value) ->
	?ASSERT(is_record(PS, player_status)),
	V = erlang:max(Value,0),
	asyn_update_PS_fields(PS, ?PSF_ENTER_GUILD_TIME, V).


set_chip(PS,Value) ->
	?ASSERT(is_record(PS, player_status)),
	V = erlang:max(Value,0),
	asyn_update_PS_fields(PS, ?PSF_CHIP, V).


get_guild_attrs(PS) ->
	PS#player_status.guild_attrs.


set_guild_attrs(PS, GuildAttrs) ->
	?ASSERT(is_record(PS, player_status)),
	?ASSERT(is_list(GuildAttrs), GuildAttrs),
	asyn_update_PS_fields(PS, ?PSF_GUILD_ATTRS, GuildAttrs).


get_jingmai_infos(PS) ->
	case PS#player_status.jingmai_infos of
		[] -> [{1,0},{2,0},{3,0},{4,0},{5,0},{6,0},{7,0}];
		_ -> PS#player_status.jingmai_infos
	end.

set_jingmai_infos(PS, JingmaiInfos) ->
	?ASSERT(is_record(PS, player_status)),
	?ASSERT(is_list(JingmaiInfos), JingmaiInfos),
	asyn_update_PS_fields(PS, ?PSF_JINGMAI_INFOS, JingmaiInfos).

set_jingmai_infos(PS, JingmaiInfos,now) ->
	?ASSERT(is_record(PS, player_status)),
	?ASSERT(player:this_is_my_own_proc(PS), PS),
	PS2 = PS#player_status{
		jingmai_infos = JingmaiInfos
	},
	player_syn:update_PS_to_ets(PS2),
	PS2.

get_jingmai_point(PS) ->
	PS#player_status.jingmai_point.
set_jingmai_point(PS, Point) ->
	?ASSERT(is_record(PS, player_status)),
	?ASSERT(is_integer(Point), Point),
	asyn_update_PS_fields(PS, ?PSF_JINGMAI_POINT, Point).


set_jingmai_point(PS, Point,now) ->
	?ASSERT(is_record(PS, player_status)),
	?ASSERT(player:this_is_my_own_proc(PS), PS),
	PS2 = PS#player_status{
		jingmai_point = Point
	},
	player_syn:update_PS_to_ets(PS2),
	PS2.

get_cultivate_attrs(PS) ->
	PS#player_status.cultivate_attrs.

set_cultivate_attrs(PS, CultivateAttrs) ->
	?ASSERT(is_record(PS, player_status)),
	?ASSERT(is_list(CultivateAttrs), CultivateAttrs),
	asyn_update_PS_fields(PS, ?PSF_CULTIVATE_ATTRS, CultivateAttrs).

%% 获取声望
% get_repu(PS) -> PS#player_status.repu.


% %% 增加声望（参数Num为负数则表示扣声望）
% %% @return:
% add_repu(_PS, Num) when Num == 0 ->
% 	skip;
% add_repu(_PS, _Num) ->
%  	todo_here.


get_phy_power(PS) -> PS#player_status.phy_power.

% （参数Num为负数则表示扣体力）
add_phy_power(PS, Num) ->
	?ASSERT(is_record(PS, player_status)),
	asyn_update_PS_fields(PS, ?PSF_PHY_POWER, get_phy_power(PS) + Num).

%% 获取玩家进程pid，注意：若玩家不在线则返回null
%% @return: null | 玩家进程pid
get_pid(PlayerId) when is_integer(PlayerId) ->
	case mod_svr_mgr:get_online_player_brief(PlayerId) of
		null ->  % 没有这个玩家，或者该玩家下线了
			null;
		PlayerBrf ->
			PlayerBrf#plyr_brief.pid
	end;
get_pid(PS) ->
	PS#player_status.pid.


% 获取本次登录时间
get_login_time(PS) ->
	PS#player_status.login_time.


% 上次退出游戏的时间（unix时间戳）
get_last_logout_time(PlayerId) when is_integer(PlayerId) ->
	case get_PS(PlayerId) of
		null ->
			%% @return: null | Time
			case db:select_one(player, "last_logout_time", [{id, PlayerId}], [], [1]) of
				null -> 0;
				Time -> Time
			end;
		PS ->
			get_last_logout_time(PS)
	end;
get_last_logout_time(PS) ->
	PS#player_status.last_logout_time.

% 获取最后一次转换职业时间
get_last_transform_time(PS) ->
	PS#player_status.last_transform_time.

% 获取当天已转换门派次数
get_day_transform_times(PS) ->
	case util:is_same_day(get_last_transform_time(PS)) of
		?true ->
			%% 同一天不管
			PS#player_status.day_transform_times;
		?false ->
			0
	end.


get_create_time(PS) ->
	PS#player_status.create_time.


%% 获取与客户端连接的socket
get_socket(PS) ->
	PS#player_status.socket.

get_login_ip(PS) ->
	PS#player_status.login_ip.


%% 获取专用于发送消息给客户端的进程pid，若玩家不在线则返回null
%% @return: null | 进程pid
get_sendpid(PlayerId) when is_integer(PlayerId) ->
	case mod_svr_mgr:get_online_player_brief(PlayerId) of
		null ->  % 没有这个玩家，或者该玩家下线了
			null;
		PlayerBrief ->
			PlayerBrief#plyr_brief.sendpid
	end;
get_sendpid(PS) ->
	PS#player_status.sendpid.


%% 获取玩家对应的ets_player_position表名
my_ets_player_position(PlayerId) ->
	Remainder = PlayerId rem ?ETS_PLAYER_POSITION_COUNT,
	case Remainder < ?HALF_ETS_PLAYER_POSITION_COUNT of
		true ->
			case Remainder < ?ONE_QUARTER_ETS_PLAYER_POSITION_COUNT of
				true ->
					case Remainder of
						0 -> ?ETS_PLAYER_POSITION_1;
						1 -> ?ETS_PLAYER_POSITION_2;
						2 -> ?ETS_PLAYER_POSITION_3;
						3 -> ?ETS_PLAYER_POSITION_4;
						4 -> ?ETS_PLAYER_POSITION_5;
						5 -> ?ETS_PLAYER_POSITION_6;
						6 -> ?ETS_PLAYER_POSITION_7;
						7 -> ?ETS_PLAYER_POSITION_8;
						8 -> ?ETS_PLAYER_POSITION_9;
						9 -> ?ETS_PLAYER_POSITION_10;
						10 -> ?ETS_PLAYER_POSITION_11;
						11 -> ?ETS_PLAYER_POSITION_12;
						12 -> ?ETS_PLAYER_POSITION_13;
						13 -> ?ETS_PLAYER_POSITION_14;
						14 -> ?ETS_PLAYER_POSITION_15;
						15 -> ?ETS_PLAYER_POSITION_16
					end;
				false ->
					case Remainder of
						16 -> ?ETS_PLAYER_POSITION_17;
						17 -> ?ETS_PLAYER_POSITION_18;
						18 -> ?ETS_PLAYER_POSITION_19;
						19 -> ?ETS_PLAYER_POSITION_20;
						20 -> ?ETS_PLAYER_POSITION_21;
						21 -> ?ETS_PLAYER_POSITION_22;
						22 -> ?ETS_PLAYER_POSITION_23;
						23 -> ?ETS_PLAYER_POSITION_24;
						24 -> ?ETS_PLAYER_POSITION_25;
						25 -> ?ETS_PLAYER_POSITION_26;
						26 -> ?ETS_PLAYER_POSITION_27;
						27 -> ?ETS_PLAYER_POSITION_28;
						28 -> ?ETS_PLAYER_POSITION_29;
						29 -> ?ETS_PLAYER_POSITION_30;
						30 -> ?ETS_PLAYER_POSITION_31;
						31 -> ?ETS_PLAYER_POSITION_32
					end
			end;
		false ->
			case Remainder < ?THREE_QUARTER_ETS_PLAYER_POSITION_COUNT of
				true ->
					case Remainder of
						32 -> ?ETS_PLAYER_POSITION_33;
						33 -> ?ETS_PLAYER_POSITION_34;
						34 -> ?ETS_PLAYER_POSITION_35;
						35 -> ?ETS_PLAYER_POSITION_36;
						36 -> ?ETS_PLAYER_POSITION_37;
						37 -> ?ETS_PLAYER_POSITION_38;
						38 -> ?ETS_PLAYER_POSITION_39;
						39 -> ?ETS_PLAYER_POSITION_40;
						40 -> ?ETS_PLAYER_POSITION_41;
						41 -> ?ETS_PLAYER_POSITION_42;
						42 -> ?ETS_PLAYER_POSITION_43;
						43 -> ?ETS_PLAYER_POSITION_44;
						44 -> ?ETS_PLAYER_POSITION_45;
						45 -> ?ETS_PLAYER_POSITION_46;
						46 -> ?ETS_PLAYER_POSITION_47;
						47 -> ?ETS_PLAYER_POSITION_48
					end;
				false ->
					case Remainder of
						48 -> ?ETS_PLAYER_POSITION_49;
						49 -> ?ETS_PLAYER_POSITION_50;
						50 -> ?ETS_PLAYER_POSITION_51;
						51 -> ?ETS_PLAYER_POSITION_52;
						52 -> ?ETS_PLAYER_POSITION_53;
						53 -> ?ETS_PLAYER_POSITION_54;
						54 -> ?ETS_PLAYER_POSITION_55;
						55 -> ?ETS_PLAYER_POSITION_56;
						56 -> ?ETS_PLAYER_POSITION_57;
						57 -> ?ETS_PLAYER_POSITION_58;
						58 -> ?ETS_PLAYER_POSITION_59;
						59 -> ?ETS_PLAYER_POSITION_60;
						60 -> ?ETS_PLAYER_POSITION_61;
						61 -> ?ETS_PLAYER_POSITION_62;
						62 -> ?ETS_PLAYER_POSITION_63;
						63 -> ?ETS_PLAYER_POSITION_64
					end
			end
	end.



%% 重构造位置信息
remake_position_rd(PlayerId, SceneId, X, Y) ->
	%%SceneGridIdx = lib_scene:calc_grid_index(SceneId, X, Y),
	SceneLine = ply_scene:decide_my_scene_line(SceneId),
	remake_position_rd__(PlayerId, SceneId, dummy, X, Y, SceneLine).

remake_position_rd__(PlayerId, SceneId, _SceneGridIdx, X, Y, SceneLine) ->
	#plyr_pos{
		player_id = PlayerId,         % 玩家id
		scene_id = SceneId,           % 所在场景的唯一id
		x = X,                        % x坐标
		y = Y,                        % y坐标
		%%scene_grid_index = SceneGridIdx, % 所在场景格子的索引
		scene_line = SceneLine,
		% 重置计步器
		step_counter = {0, util:rand(?REGEN_STEP_COUNT_MIN, ?REGEN_STEP_COUNT_MAX)}
	}.


%% 初始化玩家的位置信息
%% @return: 位置信息
init_position(PlayerId, {SceneId, X, Y}) ->
	%%SceneGridIdx = lib_scene:calc_grid_index(SceneId, X, Y),
	Pos = remake_position_rd(PlayerId, SceneId, X, Y),
	%%?DEBUG_MSG("init_position(), PlayerId:~p, my scene line: ~p", [PlayerId, Pos#plyr_pos.scene_line]),
	set_position(PlayerId, Pos),
	Pos.


%% 获取玩家的位置信息
%% @return： null | plyr_pos结构体
get_position(PS) when is_record(PS, player_status) ->
	get_position(PS#player_status.id);
get_position(PlayerId) when is_integer(PlayerId) ->
	case ets:lookup(?MY_ETS_PLAYER_POSITION(PlayerId), PlayerId) of
		[] -> null;
		[Pos] -> Pos
	end.

%% 设置玩家的位置信息
set_position(PlayerId, Pos) ->
	?ASSERT(is_record(Pos, plyr_pos)),
	?ASSERT(PlayerId == Pos#plyr_pos.player_id),
	ets:insert(?MY_ETS_PLAYER_POSITION(PlayerId), Pos).


%% 删除玩家的位置信息
delete_position(PlayerId) ->
	ets:delete(?MY_ETS_PLAYER_POSITION(PlayerId), PlayerId).


%% 获取进入副本前的位置
get_prev_pos(PS) ->
	PS#player_status.prev_pos.


%% 获取玩家所在的场景id
get_scene_id(PlayerId) when is_integer(PlayerId) ->
	case get_position(PlayerId) of
		null -> ?INVALID_SCENE_ID;
		Pos -> Pos#plyr_pos.scene_id
	end;
get_scene_id(PS) ->
	get_scene_id(PS#player_status.id).


%% 获取玩家所在的场景id
get_scene_no(PlayerId) when is_integer(PlayerId) ->
	case get_position(PlayerId) of
		null -> ?INVALID_SCENE_NO;
		Pos ->
			case lib_scene:get_obj(Pos#plyr_pos.scene_id) of
				null -> ?INVALID_SCENE_NO;
				SceneObj -> lib_scene:get_no(SceneObj)
			end
	end;
get_scene_no(PS) ->
	get_scene_no(PS#player_status.id).




%% 快速获取自己当前所在的场景编号， 注意：只能在玩家自己的进程中调用！
fast_get_my_cur_scene_no(CurSceneId) ->
	case get(?PDKN_CUR_SCENE_ID_AND_NO) of
		undefined ->
			CurSceneObj = lib_scene:get_obj(CurSceneId),
			CurSceneNo = lib_scene:get_no(CurSceneObj),
			put(?PDKN_CUR_SCENE_ID_AND_NO, {CurSceneId, CurSceneNo}),
			CurSceneNo;

		{CurSceneId, SceneNo} ->
			SceneNo;

		{_OldSceneId, _OldSceneNo} ->
			CurSceneObj = lib_scene:get_obj(CurSceneId),
			CurSceneNo = lib_scene:get_no(CurSceneObj),
			put(?PDKN_CUR_SCENE_ID_AND_NO, {CurSceneId, CurSceneNo}),
			CurSceneNo
	end.



% init_scene_line(PlayerId) ->
% 	?ASSERT(is_integer(PlayerId)),
% 	case mod_svr_mgr:get_online_player_brief(PlayerId) of
% 		null ->
% 			?ASSERT(false, PlayerId),
% 			skip;
% 		PB ->
% 			CurSceneId = get_scene_id(PlayerId),
% 			SceneLine = ply_scene:decide_my_scene_line(CurSceneId),
% 			?TRACE("init_scene_line(), CurSceneId:~p, SceneLine:~p~n", [CurSceneId, SceneLine]),
% 			PB2 = PB#plyr_brief{scene_line = SceneLine},
% 			mod_svr_mgr:update_online_player_brief_to_ets(PB2)
% 	end.


get_scene_line(PlayerId) ->
	?ASSERT(is_integer(PlayerId)),
	case get_position(PlayerId) of
		null -> ?INVALID_SCENE_LINE;
		Pos -> Pos#plyr_pos.scene_line
	end.

% set_scene_line(PlayerId, Line) ->
% 	?ASSERT(is_integer(PlayerId)),
% 	?ASSERT(is_integer(Line)),
% 	case get_position(PlayerId) of
% 		null -> ?ASSERT(false, PlayerId), skip;
% 		Pos -> set_position(Pos#plyr_pos{scene_line = Line})
% 	end.




%% 获取玩家的xy坐标
%% @return: {X坐标, Y坐标}
get_xy(PlayerId) when is_integer(PlayerId) ->
	case get_position(PlayerId) of
		null -> {0, 0};
		Pos -> {Pos#plyr_pos.x, Pos#plyr_pos.y}
	end;
get_xy(PS) ->
	get_xy(PS#player_status.id).



%% 判断是否在队伍中
%% @return: true => 是， false => 否
is_in_team(PlayerId) when is_integer(PlayerId) ->
	case get_PS(PlayerId) of
		null ->
			case ply_tmplogout_cache:get_tmplogout_PS(PlayerId) of
				null -> false;
				TPS -> ply_tmplogout_cache:is_in_team(TPS)
			end;
		PS ->
			is_in_team(PS)
	end;
is_in_team(PS) ->
	PS#player_status.team_id /= ?INVALID_ID.


is_tmp_leave_team(PS) when is_record(PS, player_status) ->
	case is_in_team(PS) of
		false -> false;
		true -> mod_team:is_player_tmp_leave(PS)
	end;
is_tmp_leave_team(PlayerId) when is_integer(PlayerId) ->
	case get_PS(PlayerId) of
		null ->
			?ASSERT(false, PlayerId),
			false;
		PS ->
			is_tmp_leave_team(PS)
	end.


%% 在队伍中并且不是队长？
is_in_team_but_not_leader(PS) ->
	is_in_team(PS) andalso (not is_leader(PS)).


%% 在队伍中并且没有暂离？
is_in_team_and_not_tmp_leave(PS) ->
	is_in_team(PS) andalso (not is_tmp_leave_team(PS)).


%% 两个玩家是否在同一个队伍中？
are_in_same_team(PS_A, PS_B) ->
	is_in_team(PS_A)
		andalso is_in_team(PS_B)
		andalso (get_team_id(PS_A) == get_team_id(PS_B)).


%% 获取队伍id
get_team_id(PlayerId) when is_integer(PlayerId) ->
	case get_PS(PlayerId) of
		null ->
			case ply_tmplogout_cache:get_tmplogout_PS(PlayerId) of
				null ->
					?INVALID_ID;
				TPS ->
					get_team_id(TPS)
			end;
		PS ->
			get_team_id(PS)
	end;
get_team_id(PS) ->
	PS#player_status.team_id.


%% % 玩家组队目标类型
get_team_target_type(PlayerId) when is_integer(PlayerId) ->
	case get_PS(PlayerId) of
		null ->
			?ASSERT(false, PlayerId);
		PS ->
			get_team_target_type(PS)
	end;
get_team_target_type(PS) ->
	PS#player_status.team_target_type.


set_team_target_type(PS, TargetType) ->
	?ASSERT(is_record(PS, player_status)),
	asyn_update_PS_fields(PS, ?PSF_TEAM_TAGET_TYPE, TargetType).

% 玩家组队目的之条件1
get_team_condition1(PlayerId) when is_integer(PlayerId) ->
	case get_PS(PlayerId) of
		null ->
			?ASSERT(false, PlayerId);
		PS ->
			get_team_condition1(PS)
	end;
get_team_condition1(PS) ->
	PS#player_status.team_condition1.

set_team_condition1(PS, Value) ->
	?ASSERT(is_record(PS, player_status)),
	asyn_update_PS_fields(PS, ?PSF_TEAM_CONDITION1, Value).

% 玩家组队目的之条件1
get_team_condition2(PlayerId) when is_integer(PlayerId) ->
	case get_PS(PlayerId) of
		null ->
			?ASSERT(false, PlayerId);
		PS ->
			get_team_condition2(PS)
	end;
get_team_condition2(PS) ->
	PS#player_status.team_condition2.

get_team_lv_range(PlayerId) when is_integer(PlayerId) ->
	case get_PS(PlayerId) of
		null ->
			?ASSERT(false, PlayerId);
		PS ->
			get_team_lv_range(PS)
	end;
get_team_lv_range(PS) ->
	PS#player_status.team_lv_range.


set_team_condition2(PS, Value) ->
	?ASSERT(is_record(PS, player_status)),
	asyn_update_PS_fields(PS, ?PSF_TEAM_CONDITION2, Value).

set_team_lv_range(PS, MinLv,MaxLv) ->
	?ASSERT(is_record(PS, player_status)),
	asyn_update_PS_fields(PS, ?PSF_TEAM_LV_RANGE, {MinLv,MaxLv}).

%% 清除队伍id
clear_team_id(PS_Or_PlayerId) ->
	set_team_id(PS_Or_PlayerId, ?INVALID_ID).


%% 设置队伍id
set_team_id(PlayerId, TeamId) when is_integer(PlayerId) ->
	case get_PS(PlayerId) of
		null ->
			?ASSERT(false, PlayerId),
			skip;
		PS ->
			set_team_id(PS, TeamId)
	end;
set_team_id(PS, TeamId) ->
	?ASSERT(is_record(PS, player_status)),
	asyn_update_PS_fields(PS, ?PSF_TEAM_ID, TeamId).


%% 获取所属队伍的队长id，如果不在队伍中，则返回INVALID_ID
get_leader_id(PS) ->
	case is_in_team(PS) of
		false ->
			?INVALID_ID;
		true ->
			TeamId = get_team_id(PS),
			mod_team:get_leader_id(TeamId)
	end.


%% 判断是否队长
%% @return: true => 是， false => 否
is_leader(PlayerId) when is_integer(PlayerId) ->
	case get_PS(PlayerId) of
		null ->
			% ?ASSERT(false, PlayerId),
			false;
		PS ->
			is_leader(PS)
	end;
is_leader(PS) ->
	PS#player_status.is_leader.


%% 标记为队长
mark_leader_flag(PS_Or_PlayerId) ->
	set_leader_flag(PS_Or_PlayerId, true).

%% 清除队长标记
clear_leader_flag(PS_Or_PlayerId) ->
	set_leader_flag(PS_Or_PlayerId, false).


%% 设置队长标记
%% @para: Flag => true表示设为队长，false表示设为非队长
%% @return: 无用
set_leader_flag(PlayerId, Flag) when is_integer(PlayerId) ->
	case get_PS(PlayerId) of
		null ->
			% ?ASSERT(false, PlayerId), 处理情况：2个人一队，队长掉线的同时另一个退出队伍的情况，有待验证
			case ply_tmplogout_cache:get_tmplogout_PS(PlayerId) of
				null ->
					skip;
				TmpLogoutPS ->
					ply_tmplogout_cache:set_leader_flag(TmpLogoutPS, Flag)
			end;
		PS ->
			set_leader_flag(PS, Flag)
	end;
set_leader_flag(PS, Flag) ->
	?ASSERT(is_boolean(Flag), Flag),
	asyn_update_PS_fields(PS, ?PSF_IS_LEADER, Flag).


%% 设置最后一次转职时间
% PSF_LAST_TRANSFORM_FACTION_TIME
set_last_transform_time(PS,Value) ->
	?ASSERT(is_integer(Value), Value),
	asyn_update_PS_fields(PS, ?PSF_LAST_TRANSFORM_FACTION_TIME, Value).


%% 设置当天已经转换门派次数
% PSF_DAY_TRANSFORM_FACTION_TIMES
set_day_transform_times(PS,Value) ->
	?ASSERT(is_integer(Value), Value),
	asyn_update_PS_fields(PS, ?PSF_DAY_TRANSFORM_FACTION_TIMES, Value).


get_suit_no(PS) ->
	PS#player_status.suit_no.

set_suit_no(PS, Value) ->
	asyn_update_PS_fields(PS, ?PSF_SUIT_NO, Value).

%% 玩家结构体所在的ets_online表名
my_ets_online(PlayerId) when is_integer(PlayerId) ->
	Remainder = PlayerId rem 128,
	case Remainder < 64 of
		true ->
			case Remainder < 32 of
				true->
					case Remainder < 16 of
						true ->
							case Remainder of
								0 -> ets_online_1;
								1 -> ets_online_2;
								2 -> ets_online_3;
								3 -> ets_online_4;
								4 -> ets_online_5;
								5 -> ets_online_6;
								6 -> ets_online_7;
								7 -> ets_online_8;
								8 -> ets_online_9;
								9 -> ets_online_10;
								10 -> ets_online_11;
								11 -> ets_online_12;
								12 -> ets_online_13;
								13 -> ets_online_14;
								14 -> ets_online_15;
								15 -> ets_online_16
							end;
						false ->
							case Remainder of
								16 -> ets_online_17;
								17 -> ets_online_18;
								18 -> ets_online_19;
								19 -> ets_online_20;
								20 -> ets_online_21;
								21 -> ets_online_22;
								22 -> ets_online_23;
								23 -> ets_online_24;
								24 -> ets_online_25;
								25 -> ets_online_26;
								26 -> ets_online_27;
								27 -> ets_online_28;
								28 -> ets_online_29;
								29 -> ets_online_30;
								30 -> ets_online_31;
								31 -> ets_online_32
							end
					end;
				false ->
					case Remainder < 48 of
						true ->
							case Remainder of
								32 -> ets_online_33;
								33 -> ets_online_34;
								34 -> ets_online_35;
								35 -> ets_online_36;
								36 -> ets_online_37;
								37 -> ets_online_38;
								38 -> ets_online_39;
								39 -> ets_online_40;
								40 -> ets_online_41;
								41 -> ets_online_42;
								42 -> ets_online_43;
								43 -> ets_online_44;
								44 -> ets_online_45;
								45 -> ets_online_46;
								46 -> ets_online_47;
								47 -> ets_online_48
							end;
						false ->
							case Remainder of
								48 -> ets_online_49;
								49 -> ets_online_50;
								50 -> ets_online_51;
								51 -> ets_online_52;
								52 -> ets_online_53;
								53 -> ets_online_54;
								54 -> ets_online_55;
								55 -> ets_online_56;
								56 -> ets_online_57;
								57 -> ets_online_58;
								58 -> ets_online_59;
								59 -> ets_online_60;
								60 -> ets_online_61;
								61 -> ets_online_62;
								62 -> ets_online_63;
								63 -> ets_online_64
							end
					end
			end;

		false ->
			case Remainder < 96 of
				true->
					case Remainder < 80 of
						true ->
							case Remainder of
								64 -> ets_online_65;
								65 -> ets_online_66;
								66 -> ets_online_67;
								67 -> ets_online_68;
								68 -> ets_online_69;
								69 -> ets_online_70;
								70 -> ets_online_71;
								71 -> ets_online_72;
								72 -> ets_online_73;
								73 -> ets_online_74;
								74 -> ets_online_75;
								75 -> ets_online_76;
								76 -> ets_online_77;
								77 -> ets_online_78;
								78 -> ets_online_79;
								79 -> ets_online_80
							end;
						false ->
							case Remainder of
								80 -> ets_online_81;
								81 -> ets_online_82;
								82 -> ets_online_83;
								83 -> ets_online_84;
								84 -> ets_online_85;
								85 -> ets_online_86;
								86 -> ets_online_87;
								87 -> ets_online_88;
								88 -> ets_online_89;
								89 -> ets_online_90;
								90 -> ets_online_91;
								91 -> ets_online_92;
								92 -> ets_online_93;
								93 -> ets_online_94;
								94 -> ets_online_95;
								95 -> ets_online_96
							end
					end;
				false ->
					case Remainder < 112 of
						true ->
							case Remainder of
								96 -> ets_online_97;
								97 -> ets_online_98;
								98 -> ets_online_99;
								99 -> ets_online_100;
								100 -> ets_online_101;
								101 -> ets_online_102;
								102 -> ets_online_103;
								103 -> ets_online_104;
								104 -> ets_online_105;
								105 -> ets_online_106;
								106 -> ets_online_107;
								107 -> ets_online_108;
								108 -> ets_online_109;
								109 -> ets_online_110;
								110 -> ets_online_111;
								111 -> ets_online_112
							end;
						false ->
							case Remainder of
								112 -> ets_online_113;
								113 -> ets_online_114;
								114 -> ets_online_115;
								115 -> ets_online_116;
								116 -> ets_online_117;
								117 -> ets_online_118;
								118 -> ets_online_119;
								119 -> ets_online_120;
								120 -> ets_online_121;
								121 -> ets_online_122;
								122 -> ets_online_123;
								123 -> ets_online_124;
								124 -> ets_online_125;
								125 -> ets_online_126;
								126 -> ets_online_127;
								127 -> ets_online_128
							end
					end
			end
	end;
my_ets_online(PS) ->
	my_ets_online(PS#player_status.id).


% %% 获取快捷栏
% get_shortcut_bar(PS) ->
% 	PS#player_status.shortcut_bar.

% set_shortcut_bar(PS, NewShortcutBar) ->
% 	asyn_update_PS_fields(PS, ?PSF_SHORTCUT_BAR, NewShortcutBar).

%% 获取移动速度
get_move_speed(PS) -> PS#player_status.move_speed.

% %% 获取攻击距离
% get_att_distance(PS) -> PS#player_status.att_distance.

%% 获取当前行为状态
get_cur_bhv_state(PS) -> PS#player_status.cur_bhv_state.

set_cur_bhv_state(PS, BhvState) ->
	asyn_update_PS_fields(PS, ?PSF_CUR_BHV_STATE, BhvState).


%% 获取玩家的系统设置
%%%% get_sys_set(PS) -> PS#player_status.sys_set.

%% 获取当前的新手指导阶段
% get_newbie_guide_step(PS) -> PS#player_status.newbie_guide_step.


%% 取得功勋值
get_feat(PS) -> PS#player_status.feat.
%% 获得帮派贡献
get_guild_contri(PlayerId) when is_integer(PlayerId) ->
	case get_PS(PlayerId) of
		null ->
			mod_offline_data:get_guild_contri(PlayerId);
		PS ->
			PS#player_status.guild_contri
	end;

get_guild_contri(PS) ->
	PS#player_status.guild_contri.


% PS#player_status.guild_contri.
% ply_guild:get_left_contri(player:id(PS)).

add_guild_contri(_, 0, _) -> skip;
add_guild_contri(RoleId, Num, LogInfo) when is_integer(RoleId) ->
	case player:get_PS(RoleId) of
		PS when is_record(PS, player_status) -> add_guild_contri(PS, Num, LogInfo);
		_ -> skip
	end;
add_guild_contri(PS, Num, LogInfo) when is_record(PS, player_status) andalso is_integer(Num) andalso Num > 0 ->
	add_money(PS, ?MNY_T_GUILD_CONTRI, Num, LogInfo);
add_guild_contri(_, _, _) -> ?ASSERT(false).

%% 获得帮派战功
get_guild_feat(PS) ->
	PS#player_status.guild_feat.

add_guild_feat(_, 0, _) -> skip;
add_guild_feat(RoleId, Num, LogInfo) when is_integer(RoleId) ->
	case player:get_PS(RoleId) of
		PS when is_record(PS, player_status) -> add_guild_feat(PS, Num, LogInfo);
		_ -> skip
	end;
add_guild_feat(PS, Num, LogInfo) when is_record(PS, player_status) andalso is_integer(Num) andalso Num > 0 ->
	add_money(PS, ?MNY_T_GUILD_FEAT, Num, LogInfo);
add_guild_feat(_, _, _) -> ?ASSERT(false).


%% 增加功勋
% add_feat(PS, 0) -> skip;
add_feat(RoleId, Num) when is_integer(RoleId) ->
	case player:get_PS(RoleId) of
		PS when is_record(PS, player_status) -> add_feat(PS, Num);
		_ -> skip
	end;
add_feat(PS, Num) when is_record(PS, player_status) andalso is_integer(Num) andalso Num > 0 ->
	add_money(PS, ?MNY_T_FEAT, Num, [?LOG_OA, "battle"]);
% add_money__(PlayerId_Or_PS, feat, Num);
add_feat(_, _) -> skip.

add_feat(PS, Num, LogInfo) when is_record(PS, player_status) andalso is_integer(Num) andalso Num > 0 ->
	add_money(PS, ?MNY_T_FEAT, Num, LogInfo);

add_feat(_, _, _) -> skip.


%% 取得学分
get_literary(PS) -> PS#player_status.literary.

add_literary(_, 0, _) -> skip;
add_literary(RoleId, Num, LogInfo) when is_integer(RoleId) ->
	case player:get_PS(RoleId) of
		PS when is_record(PS, player_status) -> add_literary(PS, Num, LogInfo);
		_ -> skip
	end;
add_literary(PS, Num, LogInfo) when is_record(PS, player_status) andalso is_integer(Num) andalso Num > 0 ->
	add_money(PS, ?MNY_T_LITERARY, Num, LogInfo);
add_literary(_, _, _) -> ?ASSERT(false).


%% 设置学分
set_literary(PS, Literary, Timestamp) when is_record(PS, player_status) ->
	Pid = get_pid(PS),
	gen_server:cast(Pid, {'reset_literary', Timestamp, Literary}).

%% ------------------ functions abount player's base info END -----------------------





%% --------------------------- functions about player's money BEGIN --------------------------------------------

%% 加钱
%% @para: MoneyType => 钱的类型（为整数代号，详见common.hrl）
%%        AddNum => 添加的数量（整数，须大于或等于0）
%% @return: 无用
add_money(_PS, _MoneyType, 0, _) ->
	skip;
add_money(PS, MoneyType, AddNum, LogInfo) when is_integer(AddNum), AddNum > 0 ->
	lib_log:statis_produce_currency(PS, MoneyType, AddNum, LogInfo),
	case MoneyType of
		?MNY_T_GUILD_CONTRI ->
			add_money__(PS, guild_contri, AddNum);
		?MNY_T_GUILD_FEAT ->
			add_money__(PS, guild_feat, AddNum);
		?MNY_T_GAMEMONEY ->
			add_money__(PS, gamemoney, AddNum);
		?MNY_T_BIND_GAMEMONEY ->
			add_money__(PS, bind_gamemoney, AddNum);
		?MNY_T_YUANBAO ->
			add_money__(PS, yuanbao, AddNum);
		?MNY_T_BIND_YUANBAO ->
			add_money__(PS, bind_yuanbao, AddNum);
		?MNY_T_INTEGRAL ->
			add_money__(PS, integral, AddNum);
		?MNY_T_FEAT ->
			add_money__(PS, feat, AddNum);
		?MNY_T_VITALITY ->
			add_money__(PS, vitality, AddNum);
		?MNY_T_LITERARY ->
			add_money__(PS, literary, AddNum);
		?MNY_T_CHIVALROUS ->
			add_money__(PS, chivalrous, AddNum);
		?MNY_T_QUJING ->
			add_money__(PS, jingwen, AddNum);
		?MNY_T_CHIP ->
			add_money__(PS, chip, AddNum);
		?MNY_T_COPPER ->
			add_money__(PS, copper, AddNum);
		?MNY_T_MYSTERY ->
			add_money__(PS, mijing ,AddNum);
		?MNY_T_MIRAGE ->
			add_money__(PS, huanjing, AddNum);
		?MNY_T_REINCARNATION ->
			add_money__(PS, reincarnation, AddNum)
	end.


%% 获取元宝
get_yuanbao(PS) -> PS#player_status.yuanbao.

%% 获取绑定的元宝
get_bind_yuanbao(PS) -> PS#player_status.bind_yuanbao.

%% 获取游戏币
get_gamemoney(PS) -> PS#player_status.gamemoney.

%% 获取积分
get_integral(PS) -> PS#player_status.integral.


%% 获取专用游戏币
get_copper(PS) -> PS#player_status.copper.

get_chivalrous(PS) -> PS#player_status.chivalrous.

%经文
get_jingwen(PS) -> PS#player_status.jingwen.

%秘境
get_mijing(PS) -> PS#player_status.mijing.

%幻境
get_huanjing(PS) ->PS#player_status.huanjing.

%转生
get_reincarnation(PS) ->PS#player_status.reincarnation.

% 人气值
get_popular(PlayerId) when is_integer(PlayerId) -> lib_player_ext:try_load_data(PlayerId,popular);
get_popular(PS) -> PS#player_status.popular.

% 杀人数
get_kill_num(PS) -> PS#player_status.kill_num.
get_be_kill_num(PS) -> PS#player_status.be_kill_num.
get_enter_guild_time(PS) -> PS#player_status.enter_guild_time.

%段位
get_dan(PS) -> PS#player_status.dan.

get_chip(PS) -> PS#player_status.chip.

%% 获取专用游戏币
get_vitality(PS) -> PS#player_status.vitality.

%% 获取绑定的游戏币
get_bind_gamemoney(PS) -> PS#player_status.bind_gamemoney.


%% 增加游戏币
%% @para: PlayerId_Or_PS => 玩家id或player_status结构体，下同
%% @return: 无用
add_gamemoney(_PlayerId_Or_PS, 0, _) ->
	skip;
add_gamemoney(PlayerId_Or_PS, AddNum, LogInfo) when is_integer(AddNum), AddNum > 0 ->
	lib_log:statis_produce_currency(PlayerId_Or_PS, gamemoney, AddNum, LogInfo),
	add_money__(PlayerId_Or_PS, gamemoney, AddNum).

%% 增加积分
%% @para: PlayerId_Or_PS => 玩家id或player_status结构体，下同
%% @return: 无用
add_integral(_PlayerId_Or_PS, 0, _) ->
	skip;
add_integral(PlayerId_Or_PS, AddNum, LogInfo) when is_integer(AddNum), AddNum > 0 ->
	lib_log:statis_produce_currency(PlayerId_Or_PS, integral, AddNum, LogInfo),
	add_money__(PlayerId_Or_PS, integral, AddNum).


%% 增加专用游戏币
%% @para: PlayerId_Or_PS => 玩家id或player_status结构体，下同
%% @return: 无用
add_copper(_PlayerId_Or_PS, 0, _) ->
	skip;
add_copper(PlayerId_Or_PS, AddNum, LogInfo) when is_integer(AddNum), AddNum > 0 ->
	lib_log:statis_produce_currency(PlayerId_Or_PS, copper, AddNum, LogInfo),
	add_money__(PlayerId_Or_PS, copper, AddNum).

% 增加龙头小票
add_chip(_PlayerId_Or_PS, 0, _) ->
	skip;
add_chip(PlayerId_Or_PS, AddNum, LogInfo) when is_integer(AddNum), AddNum > 0 ->
	lib_log:statis_produce_currency(PlayerId_Or_PS, chip, AddNum, LogInfo),
	add_money__(PlayerId_Or_PS, chip, AddNum).


% 增加侠义值
%% @para: PlayerId_Or_PS => 玩家id或player_status结构体，下同
%% @return: 无用
add_chivalrous(_PlayerId_Or_PS, 0, _) ->
	skip;
add_chivalrous(PlayerId_Or_PS, AddNum, LogInfo) when is_integer(AddNum), AddNum > 0 ->
	lib_log:statis_produce_currency(PlayerId_Or_PS, chivalrous, AddNum, LogInfo),
	add_money__(PlayerId_Or_PS, chivalrous, AddNum).

% 增加经文
%% @para: PlayerId_Or_PS => 玩家id或player_status结构体，下同
%% @return: 无用
add_jingwen(_PlayerId_Or_PS, 0, _) ->
	skip;
add_jingwen(PlayerId_Or_PS, AddNum, LogInfo) when is_integer(AddNum), AddNum > 0 ->
	lib_log:statis_produce_currency(PlayerId_Or_PS, jingwen, AddNum, LogInfo),
	add_money__(PlayerId_Or_PS, jingwen, AddNum).

% 增加秘境点数
%% @para: PlayerId_Or_PS => 玩家id或player_status结构体，下同
%% @return: 无用
add_mijing(_PlayerId_Or_PS, 0, _) ->
	skip;
add_mijing(PlayerId_Or_PS, AddNum, LogInfo) when is_integer(AddNum), AddNum > 0 ->
	lib_log:statis_produce_currency(PlayerId_Or_PS, mijing, AddNum, LogInfo),
	add_money__(PlayerId_Or_PS, mijing, AddNum).

% 增加幻境点数
%% @para: PlayerId_Or_PS => 玩家id或player_status结构体，下同
%% @return: 无用
add_huanjing(_PlayerId_Or_PS, 0, _) ->
	skip;
add_huanjing(PlayerId_Or_PS, AddNum, LogInfo) when is_integer(AddNum), AddNum > 0 ->
	lib_log:statis_produce_currency(PlayerId_Or_PS, huanjing, AddNum, LogInfo),
	add_money__(PlayerId_Or_PS, huanjing, AddNum).

% 增加转生点数
%% @para: PlayerId_Or_PS => 玩家id或player_status结构体，下同
%% @return: 无用
add_reincarnation(_PlayerId_Or_PS, 0, _) ->
	skip;
add_reincarnation(PlayerId_Or_PS, AddNum, LogInfo) when is_integer(AddNum), AddNum > 0 ->
	lib_log:statis_produce_currency(PlayerId_Or_PS, reincarnation, AddNum, LogInfo),
	add_money__(PlayerId_Or_PS, reincarnation, AddNum).

%% 增加活力值
%% @para: PlayerId_Or_PS => 玩家id或player_status结构体，下同
%% @return: 无用
add_vitality(_PlayerId_Or_PS, 0, _) ->
	skip;
add_vitality(PlayerId_Or_PS, AddNum, LogInfo) when is_integer(AddNum), AddNum > 0 ->
	lib_log:statis_produce_currency(PlayerId_Or_PS, vitality, AddNum, LogInfo),
	add_money__(PlayerId_Or_PS, vitality, AddNum).


%% 增加绑定的游戏币
%% @return: 无用
add_bind_gamemoney(_PlayerId_Or_PS, 0, _) ->
	skip;
add_bind_gamemoney(PlayerId_Or_PS, AddNum, LogInfo) when is_integer(AddNum), AddNum > 0 ->
	lib_log:statis_produce_currency(PlayerId_Or_PS, bind_gamemoney, AddNum, LogInfo),
	add_money__(PlayerId_Or_PS, bind_gamemoney, AddNum).


%% 增加元宝
%% @return: 无用
add_yuanbao(_PlayerId_Or_PS, 0, _) ->
	skip;
add_yuanbao(PlayerId_Or_PS, AddNum, LogInfo) when is_integer(AddNum), AddNum > 0 ->
	lib_log:statis_produce_currency(PlayerId_Or_PS, yuanbao, AddNum, LogInfo),
	add_money__(PlayerId_Or_PS, yuanbao, AddNum).


%% 增加绑定的元宝
%% @return: 无用
add_bind_yuanbao(_PlayerId_Or_PS, 0, _) ->
	skip;
add_bind_yuanbao(PlayerId_Or_PS, AddNum, LogInfo) when is_integer(AddNum), AddNum > 0 ->
	lib_log:statis_produce_currency(PlayerId_Or_PS, bind_yuanbao, AddNum, LogInfo),
	add_money__(PlayerId_Or_PS, bind_yuanbao, AddNum).



add_money__(PlayerId, MoneyType, AddNum) when is_integer(PlayerId) ->
	case get_PS(PlayerId) of
		null ->
			?ASSERT(false, PlayerId),
			skip;
		PS ->
			add_money__(PS, MoneyType, AddNum)
	end;
add_money__(PS, MoneyType, AddNum) when is_record(PS, player_status) ->
	?ASSERT(util:is_positive_int(AddNum), AddNum),
	gen_server:cast(PS#player_status.pid, {'add_money', MoneyType, AddNum}),
	void.


%% @doc 扣游戏币（注意：上层函数需确保玩家有相应足够的钱!!!）
%% 	本函数是异步cast玩家进程去处理扣钱，可能会存在扣钱判断不同步的情况
%%	建议：玩家进程执行扣钱调用player_syn:cost_money/4，非玩家进程调用player:cost_money/4
%% @para: MoneyType => 钱的类型代号（为整数，详见common.hrl）
%% @return: 无用
cost_money(_PS, _MoneyType, 0, _) ->
	skip;
cost_money(PS, MoneyType, CostNum, LogInfo) when CostNum > 0 ->
	% case MoneyType of
	% 	?MNY_T_GAMEMONEY ->
	% 		cost_money__(PS, gamemoney, CostNum);
	% 	?MNY_T_BIND_GAMEMONEY ->
	% 		cost_money__(PS, bind_gamemoney, CostNum);
	% 	?MNY_T_YUANBAO ->
	% 		cost_money__(PS, yuanbao, CostNum);
	% 	?MNY_T_BIND_YUANBAO ->
	% 		cost_money__(PS, bind_yuanbao, CostNum)
	% end.
	% lib_log:statis_consume_currency(PS, MoneyType, CostNum, LogInfo),
	cost_money__(PS, MoneyType, util:ceil(CostNum), LogInfo).

%%消耗玩家的帮派贡献
cost_guild_contri(PlayerId_Or_PS,Num,LogInfo) when is_integer(Num) andalso Num > 0 ->
	cost_money__(PlayerId_Or_PS, ?MNY_T_GUILD_CONTRI, Num, LogInfo);
cost_guild_contri(_, _, _) -> skip.


cost_guild_feat(PlayerId_Or_PS,Num,LogInfo) when is_integer(Num) andalso Num > 0 ->
	cost_money__(PlayerId_Or_PS, ?MNY_T_GUILD_FEAT, Num, LogInfo);
cost_guild_feat(_, _, _) -> skip.


cost_feat(PlayerId_Or_PS, Num, LogInfo) when is_integer(Num) andalso Num > 0 ->
	cost_money__(PlayerId_Or_PS, ?MNY_T_FEAT, Num, LogInfo);
cost_feat(_, _, _) -> skip.


cost_literary(PlayerId_Or_PS, Num, LogInfo) when Num > 0 ->
	cost_money__(PlayerId_Or_PS, ?MNY_T_LITERARY, util:ceil(Num), LogInfo);
cost_literary(_, _, _) -> skip.

cost_gamemoney(_PlayerId_Or_PS, 0, _) ->
	skip;
cost_gamemoney(PlayerId_Or_PS, CostNum, LogInfo) when CostNum > 0 ->
	% lib_log:statis_consume_currency(PlayerId_Or_PS, gamemoney, CostNum, LogInfo),
	cost_money__(PlayerId_Or_PS, ?MNY_T_GAMEMONEY, util:ceil(CostNum), LogInfo).

cost_integral(_PlayerId_Or_PS, 0, _) ->
	skip;
cost_integral(PlayerId_Or_PS, CostNum, LogInfo) when CostNum > 0 ->
	% lib_log:statis_consume_currency(PlayerId_Or_PS, integral, CostNum, LogInfo),
	cost_money__(PlayerId_Or_PS, ?MNY_T_INTEGRAL, util:ceil(CostNum), LogInfo).


cost_copper(_PlayerId_Or_PS, 0, _) ->
	skip;
cost_copper(PlayerId_Or_PS, CostNum, LogInfo) when CostNum > 0 ->
	% lib_log:statis_consume_currency(PlayerId_Or_PS, gamemoney, CostNum, LogInfo),
	cost_money__(PlayerId_Or_PS, ?MNY_T_COPPER, util:ceil(CostNum), LogInfo).

cost_chivalrous(_PlayerId_Or_PS, 0, _) ->
	skip;
cost_chivalrous(PlayerId_Or_PS, CostNum, LogInfo) when CostNum > 0 ->
	% lib_log:statis_consume_currency(PlayerId_Or_PS, gamemoney, CostNum, LogInfo),
	cost_money__(PlayerId_Or_PS, ?MNY_T_CHIVALROUS, util:ceil(CostNum), LogInfo).


cost_jingwen(_PlayerId_Or_PS, 0, _) ->
	skip;
cost_jingwen(PlayerId_Or_PS, CostNum, LogInfo) when CostNum > 0 ->
	% lib_log:statis_consume_currency(PlayerId_Or_PS, gamemoney, CostNum, LogInfo),
	cost_money__(PlayerId_Or_PS, ?MNY_T_QUJING, util:ceil(CostNum), LogInfo).


cost_mijing(_PlayerId_Or_PS, 0, _) ->
	skip;
cost_mijing(PlayerId_Or_PS, CostNum, LogInfo) when CostNum > 0 ->
	% lib_log:statis_consume_currency(PlayerId_Or_PS, gamemoney, CostNum, LogInfo),
	cost_money__(PlayerId_Or_PS, ?MNY_T_MYSTERY, util:ceil(CostNum), LogInfo).


cost_huanjing(_PlayerId_Or_PS, 0, _) ->
	skip;
cost_huanjing(PlayerId_Or_PS, CostNum, LogInfo) when CostNum > 0 ->
	% lib_log:statis_consume_currency(PlayerId_Or_PS, gamemoney, CostNum, LogInfo),
	cost_money__(PlayerId_Or_PS, ?MNY_T_MIRAGE, util:ceil(CostNum), LogInfo).

cost_reincarnation(_PlayerId_Or_PS, 0, _) ->
	skip;
cost_reincarnation(PlayerId_Or_PS, CostNum, LogInfo) when CostNum > 0 ->
	% lib_log:statis_consume_currency(PlayerId_Or_PS, gamemoney, CostNum, LogInfo),
	cost_money__(PlayerId_Or_PS, ?MNY_T_REINCARNATION, util:ceil(CostNum), LogInfo).

cost_chip(_PlayerId_Or_PS, 0, _) ->
	skip;
cost_chip(PlayerId_Or_PS, CostNum, LogInfo) when CostNum > 0 ->
	% lib_log:statis_consume_currency(PlayerId_Or_PS, gamemoney, CostNum, LogInfo),
	cost_money__(PlayerId_Or_PS, ?MNY_T_CHIP, util:ceil(CostNum), LogInfo).



cost_vitality(_PlayerId_Or_PS, 0, _) ->
	skip;
cost_vitality(PlayerId_Or_PS, CostNum, LogInfo) when CostNum > 0 ->
	% lib_log:statis_consume_currency(PlayerId_Or_PS, gamemoney, CostNum, LogInfo),
	cost_money__(PlayerId_Or_PS, ?MNY_T_VITALITY, util:ceil(CostNum), LogInfo).





%% 扣绑定的游戏币（注意：上层函数需确保玩家有相应足够的钱!!!）
%% @return: 无用
cost_bind_gamemoney(_PlayerId_Or_PS, 0, _) ->
	skip;
cost_bind_gamemoney(PlayerId_Or_PS, CostNum, LogInfo) when CostNum > 0 ->
	% lib_log:statis_consume_currency(PlayerId_Or_PS, bind_gamemoney, CostNum, LogInfo),
	cost_money__(PlayerId_Or_PS, ?MNY_T_BIND_GAMEMONEY, util:ceil(CostNum), LogInfo).


%% 扣元宝（注意：上层函数需确保玩家有相应足够的钱!!!）
%% @return: 无用
cost_yuanbao(_PlayerId_Or_PS, 0, _) ->
	skip;
cost_yuanbao(PlayerId_Or_PS, CostNum, LogInfo) when CostNum > 0 ->
	% lib_log:statis_consume_currency(PlayerId_Or_PS, yuanbao, CostNum, LogInfo),
	cost_money__(PlayerId_Or_PS, ?MNY_T_YUANBAO, util:ceil(CostNum), LogInfo).


%% 扣绑定的元宝（注意：上层函数需确保玩家有相应足够的钱!!!）
%% @return: 无用
cost_bind_yuanbao(_PlayerId_Or_PS, 0, _) ->
	skip;
cost_bind_yuanbao(PlayerId_Or_PS, CostNum, LogInfo) when CostNum > 0 ->
	% lib_log:statis_consume_currency(PlayerId_Or_PS, bind_yuanbao, CostNum, LogInfo),
	cost_money__(PlayerId_Or_PS, ?MNY_T_BIND_YUANBAO, util:ceil(CostNum), LogInfo).



cost_money__(PlayerId, MoneyType, CostNum, LogInfo) when is_integer(PlayerId) ->
	case get_PS(PlayerId) of
		null ->
			?ASSERT(false, PlayerId),
			skip;
		PS ->
			cost_money__(PS, MoneyType, CostNum, LogInfo)
	end;

% cost_money__(PS, ?MNY_T_GUILD_CONTRI, CostNum, LogInfo) when is_record(PS, player_status) ->
% 	?ASSERT(util:is_positive_int(CostNum), CostNum),
% 	mod_guild_mgr:cost_member_contri(PS, CostNum, LogInfo),
% 	%gen_server:cast(PS#player_status.pid, {'cost_money', MoneyType, CostNum, LogInfo}),
% 	void;

cost_money__(PS, MoneyType, CostNum, LogInfo) when is_record(PS, player_status) ->
	?ASSERT(util:is_positive_int(CostNum), CostNum),
	gen_server:cast(PS#player_status.pid, {'cost_money', MoneyType, CostNum, LogInfo}),
	void.



%% 通知客户端：更新玩家的金钱信息
notify_cli_money_change(PS, MoneyType, NewNum) ->
	{ok, BinData} = pt_13:write(?PT_PLYR_NOTIFY_MONEY_CHANGE, [MoneyType, NewNum]),
	lib_send:send_to_sock(PS, BinData).


%% 保存玩家的元宝信息到DB
db_save_yuanbao(PlayerId, NewYuanbao) when is_integer(PlayerId) ->
	db:update(player, ["yuanbao"], [NewYuanbao], "id", PlayerId);
db_save_yuanbao(PS, NewYuanbao) ->
	db:update(player, ["yuanbao"], [NewYuanbao], "id", get_id(PS)).


db_save_gamemoney(PlayerId, NewYuanbao) when is_integer(PlayerId) ->
	db:update(player, ["gamemoney"], [NewYuanbao], "id", PlayerId);
db_save_gamemoney(PS, NewYuanbao) ->
	db:update(player, ["gamemoney"], [NewYuanbao], "id", get_id(PS)).

db_save_integral(PlayerId, Value) when is_integer(PlayerId) ->
	db:update(player, ["integral"], [Value], "id", PlayerId);
db_save_integral(PS, Value) ->
	db:update(player, ["integral"], [Value], "id", get_id(PS)).

db_save_vitality(PlayerId, Value) when is_integer(PlayerId) ->
	db:update(player, ["vitality"], [Value], "id", PlayerId);
db_save_vitality(PS, Value) ->
	db:update(player, ["vitality"], [Value], "id", get_id(PS)).

db_save_copper(PlayerId, Value) when is_integer(PlayerId) ->
	db:update(player, ["copper"], [Value], "id", PlayerId);
db_save_copper(PS, Value) ->
	db:update(player, ["copper"], [Value], "id", get_id(PS)).

db_save_jingwen(PS, Value) ->
	db:update(player, ["jingwen"], [Value], "id", get_id(PS));
db_save_jingwen(PlayerId, Value) when is_integer(PlayerId) ->
	db:update(player, ["jingwen"], [Value], "id", PlayerId).

db_save_dan(PlayerId, Value) ->
	db:update(player, ["dan"], [Value], "id", PlayerId).

db_save_mijing(PS, Value) ->
	db:update(player, ["mijing"], [Value], "id", get_id(PS));
db_save_mijing(PlayerId, Value) when is_integer(PlayerId) ->
	db:update(player, ["mijing"], [Value], "id", PlayerId).

db_save_huanjing(PS, Value) ->
	db:update(player, ["huanjing"], [Value], "id", get_id(PS));
db_save_huanjing(PlayerId, Value) when is_integer(PlayerId) ->
	db:update(player, ["huanjing"], [Value], "id", PlayerId).

db_save_reincarnation(PS, Value) ->
	db:update(player, ["reincarnation"], [Value], "id", get_id(PS));
db_save_reincarnation(PlayerId, Value) when is_integer(PlayerId) ->
	db:update(player, ["reincarnation"], [Value], "id", PlayerId).

db_save_chivalrous(PlayerId, Value) when is_integer(PlayerId) ->
	db:update(player, ["chivalrous"], [Value], "id", PlayerId);
db_save_chivalrous(PS, Value) ->
	db:update(player, ["chivalrous"], [Value], "id", get_id(PS)).





%% 保存玩家的绑定元宝信息到DB
db_save_bind_yuanbao(PlayerId, NewBindYuanbao) when is_integer(PlayerId) ->
	db:update(player, ["bind_yuanbao"], [NewBindYuanbao], "id", PlayerId);
db_save_bind_yuanbao(PS, NewBindYuanbao) ->
	db:update(player, ["bind_yuanbao"], [NewBindYuanbao], "id", get_id(PS)).


%% 保存玩家的绑定元宝信息到DB
db_save_popular(PlayerId, NewPopular) when is_integer(PlayerId) ->
	?DEBUG_MSG("db_save_popular = ~p",[NewPopular]),
	lib_player_ext:try_update_data(PlayerId,popular,NewPopular);
db_save_popular(PS, NewPopular) ->
	?DEBUG_MSG("db_save_popular = ~p",[NewPopular]),
	lib_player_ext:try_update_data(PS,popular,NewPopular).

db_save_chip(PlayerId, NewPopular) when is_integer(PlayerId) ->
	?DEBUG_MSG("db_save_popular = ~p",[NewPopular]),
	lib_player_ext:try_update_data(PlayerId,chip,NewPopular);
db_save_chip(PS, NewPopular) ->
	?DEBUG_MSG("db_save_popular = ~p",[NewPopular]),
	lib_player_ext:try_update_data(PS,chip,NewPopular).


db_save_kill_num(PlayerId, NewPopular) when is_integer(PlayerId) ->
	?DEBUG_MSG("db_save_popular = ~p",[NewPopular]),
	lib_player_ext:try_update_data(PlayerId,kill_num,NewPopular);
db_save_kill_num(PS, NewPopular) ->
	?DEBUG_MSG("db_save_popular = ~p",[NewPopular]),
	lib_player_ext:try_update_data(PS,kill_num,NewPopular).

db_save_be_kill_num(PlayerId, NewPopular) when is_integer(PlayerId) ->
	?DEBUG_MSG("db_save_popular = ~p",[NewPopular]),
	lib_player_ext:try_update_data(PlayerId,be_kill_num,NewPopular);
db_save_be_kill_num(PS, NewPopular) ->
	?DEBUG_MSG("db_save_popular = ~p",[NewPopular]),
	lib_player_ext:try_update_data(PS,be_kill_num,NewPopular).

db_save_enter_guild_time(PlayerId, NewPopular) when is_integer(PlayerId) ->
	?DEBUG_MSG("db_save_enter_guild_time = ~p",[NewPopular]),
	lib_player_ext:try_update_data(PlayerId,enter_guild_time,NewPopular);
db_save_enter_guild_time(PS, NewPopular) ->
	?DEBUG_MSG("db_save_enter_guild_time = ~p",[NewPopular]),
	lib_player_ext:try_update_data(PS,enter_guild_time,NewPopular).

db_save_guild_contri(PlayerId, NewPopular) when is_integer(PlayerId) ->
	?DEBUG_MSG("db_save_popular = ~p",[NewPopular]),
	lib_player_ext:try_update_data(PlayerId,guild_contri,NewPopular);
db_save_guild_contri(PS, NewPopular) ->
	?DEBUG_MSG("db_save_popular = ~p",[NewPopular]),
	lib_player_ext:try_update_data(PS,guild_contri,NewPopular).

db_save_guild_feat(PlayerId, NewPopular) when is_integer(PlayerId) ->
	?DEBUG_MSG("db_save_popular = ~p",[NewPopular]),
	lib_player_ext:try_update_data(PlayerId,guild_feat,NewPopular);
db_save_guild_feat(PS, NewPopular) ->
	?DEBUG_MSG("db_save_popular = ~p",[NewPopular]),
	lib_player_ext:try_update_data(PS,guild_feat,NewPopular).





arrange_money_list([], Acc) -> Acc;
arrange_money_list([{PriceType,Price}|MoneyList], Acc) ->
	NewAcc =
		case lists:keyfind(PriceType, 1, Acc) of
			{PriceType, OldC} ->
				lists:keystore(PriceType, 1, Acc, {PriceType, OldC+Price});
			false ->
				[{PriceType,Price}|Acc]
		end,
	arrange_money_list(MoneyList, NewAcc).


%% @spec check_money_list(PS, MoneyList) -> ok | {fail, MsgCode}.
%%		PS	=	#player_status{}
%%		MoneyList 	=	[{PriceType,Price}]
%%		MsgCode		=	integer()
%%
%% @doc 检测需要的货币是否足够
%%
check_money_list(PS, [{PriceType,Price}|MoneyList]) ->
	NewMoneyList = arrange_money_list([{PriceType,Price}|MoneyList], []),
	check_money_list(PS, NewMoneyList, null).

check_money_list(_PS, [], Acc) -> Acc;
check_money_list(PS, [{PriceType,Price}|MoneyList], Acc) ->
	case check_need_price(PS, PriceType, Price) of
		ok -> check_money_list(PS, MoneyList, ok);
		MsgCode -> {fail, MsgCode}
	end.


%% @spec check_need_price(PS, PriceType,Price) -> ok | MsgCode.
%%		PS	=	#player_status{}
%%		PriceType 	=	integer()
%%		Price	=	integer()
%%		MsgCode		=	integer()
%%
%% @doc 检测需要的货币是否足够
%%
check_need_price(PS, PriceType,Price) ->
	?DEBUG_MSG("PriceType=~p,Price=~p",[PriceType,Price]),
	Ret = case has_enough_money(PS,PriceType,Price) of
					false ->
						case PriceType of
							?MNY_T_GAMEMONEY -> ?PM_GAMEMONEY_LIMIT;
							?MNY_T_YUANBAO -> ?PM_YB_LIMIT;
							?MNY_T_BIND_GAMEMONEY -> ?PM_BIND_GAMEMONEY_LIMIT;
							?MNY_T_BIND_YUANBAO -> ?PM_BIND_YB_LIMIT;
							?MNY_T_INTEGRAL -> ?PM_INTEGRAL_LIMIT;
							?MNY_T_VITALITY -> ?PM_VITALITY_LIMIT;
							?MNY_T_COPPER -> ?PM_COPPER_LIMIT;
							?MNY_T_CHIVALROUS -> ?PM_CHIVALROUS_LIMIT;
							?MNY_T_EXP -> ?PM_EXP_LIMIT;
							?MNY_T_GUILD_CONTRI -> ?PM_GUILD_CONTRI_LIMIT;
							?MNY_T_QUJING        -> ?PM_JINGWEN_LIMIT;
							?MNY_T_MYSTERY -> ?PM_MIJING_LIMIT;
							?MNY_T_MIRAGE -> ?PM_HUANJING_LIMIT;
							?MNY_T_REINCARNATION -> ?PM_REINCARNATION_LIMIT
						end;
					true ->
						ok
				end,
	Ret.

%% 判断玩家是否有足够数量的游戏币
%% @return: true | false
has_enough_money(_PS, _MoneyType, Num) when Num == 0 ->
	true;
has_enough_money(PS, MoneyType, Num) when Num > 0 ->
	case MoneyType of
		?MNY_T_GAMEMONEY ->
			has_enough_gamemoney(PS, Num);
		?MNY_T_BIND_GAMEMONEY ->
			has_enough_bind_gamemoney(PS, Num);
		?MNY_T_YUANBAO ->
			has_enough_yuanbao(PS, Num);
		?MNY_T_BIND_YUANBAO ->
			has_enough_bind_yuanbao(PS, Num);
		?MNY_T_INTEGRAL ->	% 积分
			get_integral(PS) >= Num;
		?MNY_T_FEAT ->	% 功勋值
			get_feat(PS) >= Num;
		?MNY_T_GUILD_CONTRI ->	% 帮派贡献度
			get_guild_contri(PS)  >= Num;
		?MNY_T_GUILD_FEAT -> % 帮派战功
			get_guild_feat(PS) >= Num;
		?MNY_T_EXP ->	% 经验
			get_exp(PS) >= Num;
		?MNY_T_LITERARY ->	% 学分
			get_literary(PS) >= Num;
		?MNY_T_VITALITY ->	% 活力值
			get_vitality(PS) >= Num;

		?MNY_T_CHIVALROUS->	% 活力值
			get_chivalrous(PS) >= Num;

		?MNY_T_QUJING->	% 经文
			get_jingwen(PS) >= Num;

		?MNY_T_MYSTERY -> %秘境
			get_mijing(PS) >= Num;

		?MNY_T_MIRAGE -> %幻境
			get_huanjing(PS) >= Num;

		?MNY_T_REINCARNATION -> %转生
			get_reincarnation(PS) >= Num;

		?MNY_T_CHIP ->	% 筹码
			get_chip(PS) >= Num;
		?MNY_T_EXP -> get_exp(PS) >= Num;

		?MNY_T_COPPER ->	% 铜币
			get_copper(PS) >= Num
	end.

has_enough_gamemoney(PlayerId_Or_PS, Num) ->
	?ASSERT(Num >= 0),
	has_enough_money__(PlayerId_Or_PS, gamemoney, Num).

has_enough_copper(PlayerId_Or_PS, Num) ->
	?ASSERT(Num >= 0),
	has_enough_money__(PlayerId_Or_PS, copper, Num).

has_enough_vitality(PlayerId_Or_PS, Num) ->
	?ASSERT(Num >= 0),
	has_enough_money__(PlayerId_Or_PS, vitality, Num).

has_enough_chivalrous(PlayerId_Or_PS, Num) ->
	?ASSERT(Num >= 0),
	has_enough_money__(PlayerId_Or_PS, chivalrous, Num).

has_enough_jingwen(PlayerId_Or_PS, Num) ->
	?ASSERT(Num >= 0),
	has_enough_money__(PlayerId_Or_PS, jingwen, Num).

has_enough_mijing(PlayerId_Or_PS, Num) ->
	?ASSERT(Num >= 0),
	has_enough_money__(PlayerId_Or_PS, mijing, Num).

has_enough_huanjing(PlayerId_Or_PS, Num) ->
	?ASSERT(Num >= 0),
	has_enough_money__(PlayerId_Or_PS, huanjing, Num).

has_enough_reincarnation(PlayerId_Or_PS, Num) ->
	?ASSERT(Num >= 0),
	has_enough_money__(PlayerId_Or_PS, reincarnation, Num).

has_enough_integral(PlayerId_Or_PS, Num) ->
	?ASSERT(Num >= 0),
	has_enough_money__(PlayerId_Or_PS, integral, Num).




%% 判断玩家是否有足够数量的绑定游戏币
%% @return: true | false
has_enough_bind_gamemoney(PlayerId_Or_PS, Num) ->
	?ASSERT(Num >= 0),
	has_enough_money__(PlayerId_Or_PS, bind_gamemoney, Num).


%% 判断玩家是否有足够数量的元宝
%% @return: true | false
has_enough_yuanbao(PlayerId_Or_PS, Num) ->
	?ASSERT(Num >= 0),
	has_enough_money__(PlayerId_Or_PS, yuanbao, Num).


%% 判断玩家是否有足够数量的绑定元宝
%% @return: true | false
has_enough_bind_yuanbao(PlayerId_Or_PS, Num) ->
	?ASSERT(Num >= 0),
	has_enough_money__(PlayerId_Or_PS, bind_yuanbao, Num).


has_enough_money__(PlayerId, MoneyType, Num) when is_integer(PlayerId) ->
	case get_PS(PlayerId) of
		null ->
			?ASSERT(false, PlayerId),
			false;
		PS ->
			has_enough_money__(PS, MoneyType, Num)
	end;

has_enough_money__(PS, MoneyType, Num) when is_record(PS, player_status) ->
	case MoneyType of
		gamemoney ->
			get_gamemoney(PS) >= Num;
		bind_gamemoney ->
			get_bind_gamemoney(PS) >= Num; % 非绑定游戏币也可以算进绑定游戏币
		yuanbao ->
			get_yuanbao(PS) >= Num;
		bind_yuanbao ->
			get_bind_yuanbao(PS) + get_yuanbao(PS) >= Num;     % 非绑定元宝也可以算进绑定元宝
		integral ->
			get_integral(PS) >= Num;     %  积分是否足够
		copper ->
			get_copper(PS) >= Num;     % 铜币是否足够
		chivalrous ->
			get_chivalrous(PS) >= Num;     % 侠义值
		vitality ->
			get_vitality(PS) >= Num ;
		jingwen ->
			get_jingwen(PS) >= Num;
		mijing ->
			get_mijing(PS) >= Num;     %秘境点数
		huanjing ->
			get_huanjing(PS) >= Num;    %幻境点数
		reincarnation ->
			get_reincarnation(PS) >= Num    % 转生点数
	end.


%% 获取上次所收到的协议号（限玩家进程内部调用）
get_last_proto() ->
	erlang:get(?PDKN_LAST_PROTO).


%% 取得玩家累计在线时长
get_accum_online_time(PS) ->
	PS#player_status.accum_online_time.

% 是否在帮战场景
is_in_guild_battle_scene(PS) ->
	{SceneNo1,_,_} = ?GUILD_ENTER1_CONFIG,
	{SceneNo2,_,_} = ?GUILD_ENTER2_CONFIG,
	{SceneNo3,_,_} = ?GUILD_ENTER3_CONFIG,

	List = [SceneNo1,SceneNo2,SceneNo3],
	lists:member(get_scene_no(PS), List).



%% --------------------------- functions about player's money END --------------------------------------------


%% 保存玩家的所有数据到DB
% db_save_all_data(PS_Latest) ->
% 	todo_here_if_necessary.




% get_save_exp_hb_intv_count() ->
% 	util:ceil(Intv div ?server_colck_tick_intv). back here...


%% 玩家心跳时定时保存部分数据到DB
db_save_data_on_heartbeat(PS_Latest, _NewHBCount) ->
	% 存物品栏
	mod_inv:db_save_inventory(get_id(PS_Latest)),

	% 存人气值
	db_save_popular(PS_Latest,get_popular(PS_Latest)),
	% 存筹码
	db_save_chip(PS_Latest,get_chip(PS_Latest)),

	% 击杀信息数据
	db_save_kill_num(PS_Latest,get_kill_num(PS_Latest)),
	db_save_be_kill_num(PS_Latest,get_be_kill_num(PS_Latest)),

	% 保存帮派信息
	db_save_guild_contri(PS_Latest,get_guild_contri(PS_Latest)),
	db_save_guild_feat(PS_Latest,get_guild_feat(PS_Latest)),

	% 存经验、金钱
	db_save_misc_data_on_HB(PS_Latest).




%% 定时存经验和金钱（由于元宝是即时存到DB的，故这里不需存元宝）
db_save_misc_data_on_HB(PS) ->
	PlayerId = get_id(PS),

	% db_save_popular(PS),
	db:update(PlayerId, player,
		["exp", "gamemoney","vitality","copper","jingwen","mijing","huanjing","chivalrous", "bind_gamemoney", "feat", "literary", "fight_par_capacity", "exp_slot", "reincarnation"],
		[get_exp(PS),  get_gamemoney(PS),get_vitality(PS),get_copper(PS),get_jingwen(PS),get_mijing(PS),get_huanjing(PS),get_chivalrous(PS), get_bind_gamemoney(PS), get_feat(PS), get_literary(PS), get_fight_par_capacity(PS),
			util:term_to_bitstring(PS#player_status.exp_slot),get_reincarnation(PS)],
		"id",
		PlayerId
	).

% 保存位置信息 --处理离线数据
db_save_position(PlayerId,SceneId,X,Y) ->
	SceneType = case lib_scene:get_obj(SceneId) of
								null -> ?SCENE_T_INVALID;
								SceneObj -> lib_scene:get_type(SceneObj)
							end,

	db:update(PlayerId, player,
		["scene_type", "scene_id", "x", "y"],
		[SceneType, SceneId, X, Y],
		"id",
		PlayerId
	).



%% 保存玩家的基础数据到DB（举例：玩家下线时调用）
%% 注意：传入的参数PS须是最新！
db_save_base_data(PS_Latest)->
	PlayerId = get_id(PS_Latest),

	Pos = get_position(PlayerId),
	SceneId = Pos#plyr_pos.scene_id,
	X = Pos#plyr_pos.x,
	Y = Pos#plyr_pos.y,
	TimeNow = svr_clock:get_unixtime(),

	SceneType = case lib_scene:get_obj(SceneId) of
								null -> ?SCENE_T_INVALID;
								SceneObj -> lib_scene:get_type(SceneObj)
							end,

	?TRACE("get_login_ip(): ~p~n", [get_login_ip(PS_Latest)]),

	AccTime = ?BIN_PRED(TimeNow >= get_login_time(PS_Latest), TimeNow - get_login_time(PS_Latest), get_login_time(PS_Latest) - TimeNow),
	AccOnlineTime = get_accum_online_time(PS_Latest) + AccTime,
	RechargeAccum = util:term_to_bitstring(PS_Latest#player_status.recharge_accum),
	ConsumeState = util:term_to_bitstring(PS_Latest#player_status.consume_state),
	RoleAdminAct = util:term_to_bitstring(PS_Latest#player_status.admin_acitvity_state),
	SlotExp = util:term_to_bitstring(PS_Latest#player_status.exp_slot),
	RechargeAccumDay = util:term_to_bitstring(PS_Latest#player_status.recharge_accum_day),
	FirstRechargeReward = util:term_to_bitstring(PS_Latest#player_status.first_recharge_reward),


	db:update(PlayerId, player,
		["scene_type", "scene_id", "x", "y",
			"hp",
			"mp",
			"exp",
			% "newbie_guide_step",
			"last_login_time",
			"last_login_ip",
			"last_logout_time",
			"gamemoney",
			"bind_gamemoney",

			"vitality",
			"copper",
			"jingwen",
			"dan",
			"mijing",
			"huanjing",
			"chivalrous",

			"team_target_type",
			"team_condition1",
			"team_condition2",
			"guild_id",
			"dun_info",
			"prev_pos",

			"bag_eq_capacity",
			"bag_usable_capacity",
			"bag_unusable_capacity",
			"storage_capacity",

			"battle_power",
			"feat",
			"literary",
			"store_hp",
			"store_mp",
			"store_par_hp",
			"store_par_mp",
			"update_mood_count",
			"last_update_mood_time",
			"accum_online_time",
			"yuanbao_acc",
			"recharge_accum",
			"consume_state",
			"admin_acitvity_state",
			"exp_slot",

			"daily_reset_time",
			"weekly_reset_time",
			"partner_capacity",
			"fight_par_capacity",
			"xs_task_issue_num",
			"xs_task_left_issue_num",
			"xs_task_receive_num",
			"zf_state",
			"contri",
			"faction",
			"recharge_accum_day",
			"mount",
			"last_transform_time",
			"day_transform_times",
			"first_recharge_reward",
			"login_reward_day",
			"login_reward_time",
			"peak_lv",
			"reincarnation",
			"unlimited_resources",
			"faction_skills"
		],

		[SceneType, SceneId, X, Y,
			get_hp(PS_Latest),
			get_mp(PS_Latest),
			get_exp(PS_Latest),
			%%get_newbie_guide_step(PS_Latest),
			get_login_time(PS_Latest),
			misc:get_ip(get_socket(PS_Latest)),
			get_last_logout_time(PS_Latest),
			get_gamemoney(PS_Latest),
			get_bind_gamemoney(PS_Latest),

			get_vitality(PS_Latest),
			get_copper(PS_Latest),
			get_jingwen(PS_Latest),
			get_dan(PS_Latest),
			get_mijing(PS_Latest),
			get_huanjing(PS_Latest),
			get_chivalrous(PS_Latest),

			get_team_target_type(PS_Latest),
			get_team_condition1(PS_Latest),
			get_team_condition2(PS_Latest),
			get_guild_id(PS_Latest),
			util:term_to_bitstring(lib_dungeon:tranform_dun_info_to_save(PS_Latest#player_status.dun_info)),
			util:term_to_bitstring(PS_Latest#player_status.prev_pos),

			mod_inv:get_bag_capacity(PlayerId, ?LOC_BAG_EQ),
			mod_inv:get_bag_capacity(PlayerId, ?LOC_BAG_USABLE),
			mod_inv:get_bag_capacity(PlayerId, ?LOC_BAG_UNUSABLE),
			mod_inv:get_storage_capacity(PlayerId),

			ply_attr:get_battle_power(PS_Latest),
			get_feat(PS_Latest),
			get_literary(PS_Latest),
			get_store_hp(PS_Latest),
			get_store_mp(PS_Latest),
			get_store_par_hp(PS_Latest),
			get_store_par_mp(PS_Latest),
			get_update_mood_count(PS_Latest),
			get_last_update_mood_time(PS_Latest),
			AccOnlineTime,
			get_yuanbao_acc(PS_Latest),
			RechargeAccum,
			ConsumeState,
			RoleAdminAct,
			SlotExp,

			get_last_daily_reset_time(PS_Latest),
			get_last_weekly_reset_time(PS_Latest),
			get_partner_capacity(PS_Latest),
			get_fight_par_capacity(PS_Latest),
			get_xs_task_issue_num(PS_Latest),
			get_xs_task_left_issue_num(PS_Latest),
			get_xs_task_receive_num(PS_Latest),
			util:term_to_bitstring(get_zf_state(PS_Latest)),
			get_contri(PS_Latest),
			get_faction(PS_Latest),
			RechargeAccumDay,
			get_mount(PS_Latest),
			get_last_transform_time(PS_Latest),
			get_day_transform_times(PS_Latest),
			FirstRechargeReward,
			PS_Latest#player_status.login_reward_day,
			PS_Latest#player_status.login_reward_time,
			PS_Latest#player_status.peak_lv,
			PS_Latest#player_status.reincarnation,
			util:term_to_bitstring(PS_Latest#player_status.unlimited_resources),
			util:term_to_bitstring(PS_Latest#player_status.faction_skills)
		],
		"id",
		PlayerId
	).





% %% 保存玩家（包括出战的武将）的战斗数据到数据库的battle_data表，用于辅助实现竞技场的离线pk功能
% db_save_battle_data(PS) ->
% 	case PS#player_status.lv >= ?MIN_LV_TO_OPEN_PK_OFFLINE of
% 		true ->
% 			%%?TRACE("save battle data(), player id :~p, lv:~p...~n", [PS#player_status.id, PS#player_status.lv]),
% 			% 保存玩家的战斗数据
% 			db_save_player_battle_data(PS),
% 			% 保存武将的战斗数据
% 			mod_partner:db_save_partner_battle_data(PS);
% 		false ->
% 			%%?TRACE("NOT Need to save battle data, lv : ~p...~n", [PS#player_status.lv]),
% 			skip
% 	end.


%% 保存玩家的战斗数据
% db_save_player_battle_data(_PS) ->
%     todo_here.







% %% 是否有效的玩家等级？
% is_valid_lv(Lv) ->
% 	?PLAYER_BORN_LV =< Lv andalso Lv =< ?PLAYER_MAX_LV.



%% 设置玩家的在线标记
%% @para: Bool => true表示在线，false表示不在线
set_online(PlayerId, Bool) when is_boolean(Bool) ->
	case mod_svr_mgr:get_online_player_brief(PlayerId) of
		null ->
			?ASSERT(false, {PlayerId, Bool, erlang:get_stacktrace()}),
			skip;
		PB ->
			PB2 = PB#plyr_brief{is_online = Bool},
			mod_svr_mgr:update_online_player_brief_to_ets(PB2)
	end.


%% 判断玩家是否在线
%% @return: true | false
is_online(PlayerId) ->
	?ASSERT(is_integer(PlayerId)),
	case mod_svr_mgr:get_online_player_brief(PlayerId) of
		null -> false;
		PB -> PB#plyr_brief.is_online
	end.



%% 角色是否在临时退出缓存中？(true | false)
in_tmplogout_cache(PlayerId) ->
	?ASSERT(is_integer(PlayerId)),
	PB = ply_tmplogout_cache:get_tmplogout_PBrf(PlayerId),
	(PB /= null) andalso (not PB#plyr_brief.force_mark_not_in_tmplogout_cache)
		orelse (not (mod_svr_mgr:get_tmplogout_player_status(PlayerId) == null)).

%% 强行标记为不在临时退出缓存中
force_mark_not_in_tmplogout_cache(PlayerId) ->
	%%%%mod_svr_mgr:del_tmplogout_player_brief_from_ets(PlayerId).

	case ply_tmplogout_cache:get_tmplogout_PBrf(PlayerId) of
		null ->
			skip;
		PB ->
			PB2 = PB#plyr_brief{force_mark_not_in_tmplogout_cache = true},
			ply_tmplogout_cache:update_tmplogout_PBrf(PB2)
	end.




% %% 标记临时退出的处理流程已完成
% mark_tmplogout_done(PlayerId) ->
% 	PB = mod_svr_mgr:get_tmplogout_player_brief(PlayerId),
% 	?ASSERT(PB /= null, PlayerId),
% 	PB2 = PB#plyr_brief{is_tmplogout_done = true},
% 	mod_svr_mgr:update_tmplogout_player_brief_to_ets(PB2).



%% 是否自动战斗模式
is_auto_battle(PS) ->
	PS#player_status.is_auto_battle.


%% 判断玩家是否在副本中
%% @return: {true, DungeonPid} | false
is_in_dungeon(Status) when is_record(Status, player_status) ->
	case Status#player_status.dun_info of
		#dun_info{dun_pid = Pid, state = State} when is_pid(Pid) ->
			case State =:= in andalso is_process_alive(Pid) of
				true -> {true, Pid};
				false -> false
			end;
		_ -> false
	end;
is_in_dungeon(_Arg) -> ?ASSERT(false, [_Arg]), false.


%% 取得玩家所在副本no
%% @return null | DunNo
get_dungeon_no(Status) when is_record(Status, player_status) ->
	case is_in_dungeon(Status) of
		{true, _} ->
			#dun_info{dun_no = DunNo} = Status#player_status.dun_info,
			?BIN_PRED(DunNo =:= 0, null, DunNo);
		_ -> null
	end;
get_dungeon_no(_Arg) -> ?ASSERT(false, [_Arg]), null.


%% 取得玩家所在副本类型
%% @return null | Type
get_dungeon_type(Status) when is_record(Status, player_status) ->
	case get_dungeon_no(Status) of
		null -> null;
		DunNo when is_integer(DunNo) ->
			lib_dungeon:get_dungeon_type(DunNo);
		_ -> null

	end;
get_dungeon_type(_Arg) -> ?ASSERT(false, [_Arg]), null.


%% 取得并检查玩家所在副本no合法性
%% @return null | DunNo
get_check_dungeon_no(Status) ->
	case Status#player_status.dun_info of
		#dun_info{dun_pid = Pid, state = State, dun_no = DunNo} when is_pid(Pid) ->
			case State =:= in andalso DunNo > 0 andalso is_process_alive(Pid) of
				true -> DunNo;
				false -> null
			end;
		_ -> null
	end.


%% 检查玩家ID是否存在
%% @return boolean()
is_player_exist(RoleId) ->
	case is_online(RoleId) of
		true -> true;
		false ->
			case in_tmplogout_cache(RoleId) of
				true -> true;
				false ->
					case db:select_one(player, "id", [{id, RoleId}]) of
						RoleId -> true;
						_ -> false
					end
			end
	end.





%% 判断是否已加入了帮派
%% @return: true=> 已加入了帮派， false=> 未加入帮派
is_in_guild(PlayerId) when is_integer(PlayerId) ->
	case get_PS(PlayerId) of
		null ->
			?ASSERT(false),
			?ERROR_MSG("player:is_in_guild not online!!~p~n", [PlayerId]),
			case mod_guild:db_get_guild_id_by_player_id(PlayerId) =:= ?INVALID_ID of
				true -> false;
				false -> true
			end;
		PS ->
			is_in_guild(PS)
	end;
is_in_guild(PS) ->
	case PS =:= null of
		false -> PS#player_status.guild_id =/= ?INVALID_ID;
		true -> ?ERROR_MSG("player:is_in_guild not online!!~n", [])
	end.


%% 判断是否在帮派场景中
is_in_guild_scene(PS) ->
	case is_in_guild(PS) of
		false ->
			false;
		true ->
			GuildId = get_guild_id(PS),
			GuildSceneId = mod_guild:get_guild_scene_id(GuildId, false),
			get_scene_id(PS) == GuildSceneId
	end.

%% 判断是否在女妖乱斗场景
is_in_melee(PS) ->
	lib_scene:is_melee_scene(get_scene_id(PS)).

%% 判断是否在女妖乱斗活动场景中
is_in_melee_scene(PS) ->
	SceneId = get_scene_id(PS),
	case lib_scene:get_obj(SceneId) of
		null ->
			?ERROR_MSG("is_in_melee_scene() error!! SceneId:~p, PS:~w", [SceneId, PS]),
			?ASSERT(false, {SceneId, PS}),
			false;
		SceneObj ->
			lib_scene:is_melee_scene(SceneObj)
	end.




% %% 判断玩家是否处于自动挂机模式
% is_in_auto_mf_mode(_PS) ->
% 	%%PS#player_status.is_in_auto_mf_mode.
% 	todo_here.

%% 判断玩家是否已经学习了指定的阵法
%% @return: true | false
already_learned_troop(_PS, _TroopNo) ->
	%%lists:keymember(TroopTypeId, 2, PS#player_status.troops).
	todo_here.

%% 判断玩家是否已经学习过阵法了
%% @return: true | false
already_learned_anyone_troop(_PS) ->
	%%PS#player_status.troops /= [].
	todo_here.


%% 判断玩家是否已经启用了阵法
%%has_active_troop(PS) ->
already_activate_troop(_PS) ->
	%%PS#player_status.cur_troop =/= {0, 0, 0}.
	todo_here.

% %% 判断玩家是否已经学习了指定编号的技能
% %% @return: true | false
% already_learned_skill(PS, SkillId) ->
% 	lists:keymember(SkillId, #skl_brief.id, PS#player_status.skills).




%% 判断玩家是否在战斗中
is_battling(PS) when is_record(PS, player_status)->
	PS#player_status.cur_bhv_state =:= ?BHV_BATTLING;

is_battling(PlayerId) ->
	PS = player:get_PS(PlayerId),
	is_battling(PS).


%% 标记为战斗中
mark_battling(PlayerId, BattleId) when is_integer(PlayerId) ->
	case get_pid(PlayerId) of
		null -> skip;
		Pid -> gen_server:cast(Pid, {'mark_battling', BattleId})
	end;
mark_battling(PS, BattleId) ->
	gen_server:cast(PS#player_status.pid, {'mark_battling', BattleId}).



get_cur_battle_id(PS) ->
	PS#player_status.cur_battle_id.


%% @return: null | 战斗进程pid
get_cur_battle_pid(PS) ->
	case PS#player_status.cur_battle_id of
		?INVALID_ID -> null;
		BattleId -> mod_battle_mgr:get_battle_pid_by_id(BattleId)
	end.





%% 设置玩家为忙状态
mark_busy(PS) ->
	set_cur_bhv_state(PS, ?BHV_BUSY_WITH_SOMETHING).



%% 设置玩家为空闲状态
mark_idle(PlayerId) when is_integer(PlayerId) ->
	case get_pid(PlayerId) of
		null -> skip;
		Pid -> gen_server:cast(Pid, 'mark_idle')
	end;
mark_idle(PS) ->
	gen_server:cast(PS#player_status.pid, 'mark_idle').


%% 设置玩家跨服状态
mark_cross_local(PlayerId) when is_integer(PlayerId)->
	PS = player:get_PS(PlayerId),
	mark_cross(PS, set_cross_local);
mark_cross_local(PS) ->
	mark_cross(PS, set_cross_local).

mark_cross_remote(PlayerId) when is_integer(PlayerId)->
	PS = player:get_PS(PlayerId),
	mark_cross(PS, set_cross_remote);

mark_cross_remote(PS) ->
	mark_cross(PS, set_cross_remote).

mark_cross_mirror(PS) ->
	mark_cross(PS, set_cross_mirror).


mark_cross(PlayerId, Request) when is_integer(PlayerId) ->
	mark_cross(player:get_PS(PlayerId), Request);

mark_cross(PS, Request) when is_record(PS, player_status) ->
	gen_server:cast(PS#player_status.pid, Request);

mark_cross(Pid, Request) when is_pid(Pid) ->
	gen_server:cast(Pid, Request);

mark_cross(PS, Request) ->
	?ERROR_MSG("Err : ~p~n", [{Request, PS}]),
	ok.
%% 	gen_server:cast(PS#player_status.pid, set_cross_false).


%% 是否为空闲状态？(true | false)
is_idle(PS) ->
	PS#player_status.cur_bhv_state == ?BHV_IDLE.

%% 是否为离线挂机？(true | false)
is_offline_guaji(PS) ->
	PS#player_status.cur_bhv_state =:= ?BHV_OFFLINE_GUAJI.

%% 是否1v1等待状态？
is_arena_1v1_waiting(PS) ->
	PS#player_status.cur_bhv_state =:= ?BHV_ARENA_1V1_WAITING.

%% 是否1v1准备状态？（true | false）
is_arena_1v1_ready(PS) ->
	PS#player_status.cur_bhv_state =:= ?BHV_ARENA_1V1_READY.

%% 是否1v1等待状态？
is_arena_3v3_waiting(PS) ->
	PS#player_status.cur_bhv_state =:= ?BHV_ARENA_3V3_WAITING.

%% 是否1v1准备状态？（true | false）
is_arena_3v3_ready(PS) ->
	PS#player_status.cur_bhv_state =:= ?BHV_ARENA_3V3_READY.


%% ------------------ functions about partner BEGIN --------------------------

% %% 是否有出战的武将？ (true | false)
% has_fighting_partner(PS) ->
% 	PS#player_status.fighting_partner_id /= 0.

% %% 获取/设置出战宠物的id
% get_fighting_partner_id(PS) ->
% 	PS#player_status.fighting_partner_id.
% set_fighting_partner_id(PS, PartnerId) ->
% 	asyn_update_PS_fields(PS, ?PSF_FIGHTING_PARTNER_ID, PartnerId).


% %% 重置出战的宠物id为0
% clear_fighting_partner_id(PS) ->
% 	asyn_update_PS_fields(PS, ?PSF_FIGHTING_PARTNER_ID, 0).

%% 获取出战的宠物对象
%% @return: null | partner结构体
get_main_partner_id(PS) ->
	PS#player_status.main_partner_id.

set_main_partner_id(PS, PartnerId) when is_record(PS, player_status) ->
	?ASSERT(is_integer(PartnerId)),
	asyn_update_PS_fields(PS, ?PSF_MAIN_PARTNER_ID, PartnerId).

get_follow_partner_id(PS) ->
	PS#player_status.follow_partner_id.

set_follow_partner_id(PS, PartnerId) when is_record(PS, player_status) ->
	?ASSERT(is_integer(PartnerId)),
	asyn_update_PS_fields(PS, ?PSF_FOLLOW_PARTNER_ID, PartnerId).

get_partner_id_list(PS) when is_record(PS, player_status) ->
	PS#player_status.partner_id_list;
get_partner_id_list(PlayerId) when is_integer(PlayerId) ->
	case get_PS(PlayerId) of
		null ->
			?ASSERT(false),
			[];
		PS ->
			get_partner_id_list(PS)
	end.

set_partner_id_list(PS, PartnerIdList) when is_record(PS, player_status) ->
	?ASSERT(is_list(PartnerIdList)),
	asyn_update_PS_fields(PS, ?PSF_PARTNER_ID_LIST, PartnerIdList).

get_mount_id_list(PS) when is_record(PS, player_status) ->
	PS#player_status.mount_id_list;
get_mount_id_list(PlayerId) when is_integer(PlayerId) ->
	case get_PS(PlayerId) of
		null ->
			?ASSERT(false),
			[];
		PS ->
			get_mount_id_list(PS)
	end.

set_mount_id_list(PS, MountIdList) when is_record(PS, player_status) ->
	?ASSERT(is_list(MountIdList)),
	asyn_update_PS_fields(PS, ?PSF_MOUNT_ID_LIST, MountIdList).

get_partner_capacity(PS) when is_record(PS, player_status) ->
	50;
% PS#player_status.partner_capacity;
get_partner_capacity(PlayerId) when is_integer(PlayerId) ->
	case get_PS(PlayerId) of
		null ->
			?ASSERT(false),
			0;
		PS ->
			get_partner_capacity(PS)
	end.

set_partner_capacity(PS, Count) when is_record(PS, player_status) ->
	asyn_update_PS_fields(PS, ?PSF_PARTNER_CAPACITY, Count);
set_partner_capacity(PlayerId, Count) ->
	case get_PS(PlayerId) of
		null ->
			?ASSERT(false),
			skip;
		PS ->
			set_partner_capacity(PS, Count)
	end.

add_partner_capacity(PS, Add) ->
	gen_server:cast(PS#player_status.pid, {'add_partner_capacity', Add}).

get_fight_par_capacity(PS) when is_record(PS, player_status) ->
	Lv = get_lv(PS),

	BattleCount = 5,
%%		if
%%			Lv > 69 ->
%%				5;
%%			Lv > 59 ->
%%				4;
%%			Lv > 49 ->
%%				3;
%%			Lv > 30 ->
%%				2;
%%			true ->
%%				1
%%		end,

	erlang:min(BattleCount,5);

get_fight_par_capacity(PlayerId) when is_integer(PlayerId) ->
	case get_PS(PlayerId) of
		null ->
			?ASSERT(false),
			0;
		PS ->
			get_fight_par_capacity(PS)
	end.

set_fight_par_capacity(PS, Count) when is_record(PS, player_status) ->
	asyn_update_PS_fields(PS, ?PSF_FIGHT_PAR_CAPACITY, Count);
set_fight_par_capacity(PlayerId, Count) ->
	case get_PS(PlayerId) of
		null ->
			?ASSERT(false),
			skip;
		PS ->
			set_fight_par_capacity(PS, Count)
	end.

has_partner(PS, PartnerId) ->
	lists:member(PartnerId, get_partner_id_list(PS)).

%% ------------------ functions about partner BEGIN END --------------------------






%% ---------------- funcitons abount talents BEGIN -----------------------

%% 获取基础天赋
%% @return: talents结构体
get_base_talents(PS) ->
	lib_attribute:to_talents_record(PS#player_status.base_attrs).

%% 获取总天赋
%% @return: talents结构体
get_total_talents(PS) ->
	lib_attribute:to_talents_record(PS#player_status.total_attrs).


%% 获取基础天赋：力量（strength）
get_base_str(PS) -> PS#player_status.base_attrs#attrs.talent_str.
%% 获取基础天赋：% 体质（constitution）
get_base_con(PS) -> PS#player_status.base_attrs#attrs.talent_con.
%% 获取基础天赋：% 耐力（stamina）
get_base_stam(PS) -> PS#player_status.base_attrs#attrs.talent_sta.
%% 获取基础天赋：% 灵力（spirit）
get_base_spi(PS) -> PS#player_status.base_attrs#attrs.talent_spi.
%% 获取基础天赋：敏捷（agility）
get_base_agi(PS) -> PS#player_status.base_attrs#attrs.talent_agi.


%% 添加基础天赋：力量（若AddNum为负数，表示减力量，!!!!注意：除非是gm指令的处理，否则正常逻辑不会出现减天赋的情况!!!! ）
add_base_str(_PS, AddNum) when AddNum == 0 ->
	skip;
add_base_str(PS, AddNum) when is_integer(AddNum) ->
	gen_server:cast(PS#player_status.pid, {'add_base_str', AddNum}).

%% 添加基础天赋：体质（若AddNum为负数，表示减体质）
add_base_con(_PS, AddNum) when AddNum == 0 ->
	skip;
add_base_con(PS, AddNum) when is_integer(AddNum) ->
	gen_server:cast(PS#player_status.pid, {'add_base_con', AddNum}).

%% 添加基础天赋：耐力（若AddNum为负数，表示减耐力）
add_base_stam(_PS, AddNum) when AddNum == 0 ->
	skip;
add_base_stam(PS, AddNum) when is_integer(AddNum) ->
	gen_server:cast(PS#player_status.pid, {'add_base_stam', AddNum}).

%% 添加基础天赋：灵力（若AddNum为负数，表示减灵力）
add_base_spi(_PS, AddNum) when AddNum == 0 ->
	skip;
add_base_spi(PS, AddNum) when is_integer(AddNum) ->
	gen_server:cast(PS#player_status.pid, {'add_base_spi', AddNum}).

%% 添加基础天赋：敏捷（若AddNum为负数，表示减敏捷）
add_base_agi(_PS, AddNum) when AddNum == 0 ->
	skip;
add_base_agi(PS, AddNum) when is_integer(AddNum) ->
	gen_server:cast(PS#player_status.pid, {'add_base_agi', AddNum}).



%% 获取总天赋：力量（strength）
get_total_str(PS) -> PS#player_status.total_attrs#attrs.talent_str.

%% 获取总天赋：% 体质（constitution）
get_total_con(PS) -> PS#player_status.total_attrs#attrs.talent_con.

%% 获取总天赋：% 耐力（stamina）
get_total_stam(PS) -> PS#player_status.total_attrs#attrs.talent_sta.

%% 获取总天赋：% 灵力（spirit）
get_total_spi(PS) -> PS#player_status.total_attrs#attrs.talent_spi.

%% 获取总天赋：敏捷（agility）
get_total_agi(PS) -> PS#player_status.total_attrs#attrs.talent_agi.



%% 获取自由（未分配的）天赋点数
get_free_talent_points(PS) -> PS#player_status.free_talent_points.


%% 添加自由（未分配的）天赋点数
add_free_talent_points(PS, AddNum) when AddNum > 0 ->
	add_free_talent_points__(PS, AddNum);
%% 扣自由（未分配的）天赋点数
add_free_talent_points(PS, AddNum) when AddNum < 0 ->
	?ASSERT(get_free_talent_points(PS) >= abs(AddNum)),
	add_free_talent_points__(PS, AddNum).

add_free_talent_points__(PS, AddNum) ->
	% NewNum = max(get_free_talent_points(PS) + AddNum, 0), % 做max矫正，是为了防止：扣点时因bug而导致数据溢出，玩家从而得到一个非常大的点数
	% asyn_update_PS_fields(PS, ?PSF_FREE_TALENT_POINTS, NewNum). %% 旧的方法：循环调用有bug
	gen_server:cast(PS#player_status.pid, {'add_free_talent_points', AddNum}).

set_free_talent_points(PS, Value) ->
	?ASSERT(Value >= 0, Value),
	asyn_update_PS_fields(PS, ?PSF_FREE_TALENT_POINTS, Value).

build_talents_bitstring(Talents) ->
	?ASSERT(is_record(Talents, talents)),
	% 顺序：{力量，体质，耐力，灵力， 敏捷}， 顺序不要调换，因为存到DB时默认是这个顺序！
	Tup = {Talents#talents.str, Talents#talents.con, Talents#talents.sta, Talents#talents.spi, Talents#talents.agi},
	util:term_to_bitstring(Tup).


%% 通知客户端：天赋点数改了（包括通知自由天赋点数）
notify_cli_talents_change(PS) ->
	gen_server:cast(PS#player_status.pid, 'notify_cli_talents_change').

%% 保存天赋信息到DB（异步）
db_save_talents(PS) ->
	gen_server:cast(PS#player_status.pid, 'db_save_talents').

%% 保存天赋信息到DB（即时），注意：传入的玩家PS须是最新的！
db_save_talents(imme, PS_Latest) ->  % imme: immediately
	PlayerId = get_id(PS_Latest),
	db:update(
		PlayerId,
		player,
		["base_talents", "free_talent_points"],
		[build_talents_bitstring(get_base_talents(PS_Latest)), get_free_talent_points(PS_Latest)],
		"id",
		PlayerId
	).


% 保存加点信息
db_save_talents(PlayerId, BaseTalents, FreeTalentPoints) ->
	db:update(
		PlayerId,
		player,
		["base_talents", "free_talent_points"],
		[build_talents_bitstring(BaseTalents), FreeTalentPoints],
		"id",
		PlayerId
	).


db_save_guild_attrs(PS) ->
	gen_server:cast(PS#player_status.pid, 'db_save_guild_attrs').

%% 保存天赋信息到DB（即时），注意：传入的玩家PS须是最新的！
db_save_guild_attrs(imme, PS_Latest) ->  % imme: immediately
	PlayerId = get_id(PS_Latest),

	% ?DEBUG_MSG("db_save_guild_attrs = ~p",[ util:term_to_bitstring(player:get_guild_attrs(PS_Latest) ]),

	db:update(
		PlayerId,
		player,
		["guild_attrs"],
		[util:term_to_bitstring(player:get_guild_attrs(PS_Latest))],
		"id",
		PlayerId
	).


db_save_jingmai(PS) ->
	gen_server:cast(PS#player_status.pid, 'db_save_jingmai').

%% 保存天赋信息到DB（即时），注意：传入的玩家PS须是最新的！
db_save_jingmai(imme, PS_Latest) ->  % imme: immediately
	PlayerId = get_id(PS_Latest),

	db:update(
		PlayerId,
		player,
		["jingmai_infos","jingmai_point"],
		[util:term_to_bitstring(player:get_jingmai_infos(PS_Latest)),player:get_jingmai_point(PS_Latest)],
		"id",
		PlayerId
	).

db_save_cultivate_attrs(PS) ->
	gen_server:cast(PS#player_status.pid, 'db_save_cultivate_attrs').

%% 保存天赋信息到DB（即时），注意：传入的玩家PS须是最新的！
db_save_cultivate_attrs(imme, PS_Latest) ->  % imme: immediately
	PlayerId = get_id(PS_Latest),

	% ?DEBUG_MSG("db_save_cultivate_attrs = ~p",[ util:term_to_bitstring(player:get_cultivate_attrs(PS_Latest) ]),

	db:update(
		PlayerId,
		player,
		["cultivate_attrs"],
		[util:term_to_bitstring(player:get_cultivate_attrs(PS_Latest))],
		"id",
		PlayerId
	).


%% ------------------ funcitons abount talents END -----------------------

%% 玩家成就功绩值
get_contri(PS) -> PS#player_status.contri.

%% 玩家设置成就功绩值
set_contri(PS, Num) -> gen_server:cast(PS#player_status.pid, {'set_contri', Num}).

%% 通知客户端:成就战绩修改了
notify_cli_contri_change(PS) ->
	gen_server:cast(PS#player_status.pid, 'notify_cli_contri_change').

%% 保存天赋信息到DB（异步）
db_save_contri(PS) ->
	gen_server:cast(PS#player_status.pid, 'db_save_contri').

%% 保存成就战绩信息到DB（即时），注意：传入的玩家PS须是最新的！
db_save_contri(imme, PS_Latest) ->  % imme: immediately
	PlayerId = get_id(PS_Latest),
	db:update(
		PlayerId,
		player,
		["contri"],
		[get_contri(PS_Latest)],
		"id",
		PlayerId
	).

%% -------------------------functions about mount ----------------------------
%% 得到玩家坐骑
get_mount(PS) -> PS#player_status.mount.

%% 设置玩家坐骑
set_mount(PS, Value) ->gen_server:cast(PS#player_status.pid, {'set_mount', Value}).

%% 通知客户端，玩家更换坐骑
notify_cli_mount_change(PS) ->
	gen_server:cast(PS#player_status.pid, 'notify_cli_mount_change').

%% 保存坐骑信息到DB（异步）
db_save_mount(PS) ->
	gen_server:cast(PS#player_status.pid, 'db_save_mount').

%% 保存坐骑信息到DB（即时），注意：传入的玩家PS须是最新的！
db_save_mount(imme, PS_Latest) ->  % imme: immediately
	PlayerId = get_id(PS_Latest),
	db:update(
		PlayerId,
		player,
		["mount"],
		[get_mount(PS_Latest)],
		"id",
		PlayerId
	).

%% ---------------------------------- functions about attributes BEGIN --------------------------------


%% 通知客户端：更新玩家的某个属性
%% @para: AttrName => 属性名
%%        NewValue => 新的值
notify_cli_attrs_change(PS, AttrName, NewValue) ->
	notify_cli_attrs_change(PS, [{AttrName, NewValue}]).

%% 通知客户端：更新玩家的一个或多个属性
%% @para: KV_TupleList => 格式如：[{属性名，新的值}, ...]
notify_cli_attrs_change(PS, KV_TupleList) ->
	?TRACE("notify_cli_attrs_change(),  PlayerId=~p, KV_TupleList=~p~n", [player:id(PS), KV_TupleList]),
	?ASSERT(util:is_tuple_list(KV_TupleList)),
	KV_TupleList2 = [{lib_attribute:attr_name_to_obj_info_code(AttrName), NewValue}
		|| {AttrName, NewValue} <- KV_TupleList],
	notify_cli_info_change(PS, KV_TupleList2).



%% 通知客户端：更新玩家的某个信息
%% @para: ObjInfoCode => 信息代号
%%        NewValue => 新的值
notify_cli_info_change(PS, ObjInfoCode, NewValue) ->
	notify_cli_info_change(PS, [{ObjInfoCode, NewValue}]).

%% 通知客户端：更新玩家的一个或多个信息
%% @para: KV_TupleList => 格式如：[{信息代号，新的值}, ...]
notify_cli_info_change(PS, KV_TupleList) ->
	?ASSERT(util:is_tuple_list(KV_TupleList)),
	{ok, BinData} = pt_13:write(?PT_PLYR_NOTIFY_INFO_CHANGE, KV_TupleList),
	lib_send:send_to_sock(PS, BinData).


%% 通知客户端：更新玩家的某个信息
%% @para: ObjInfoCode => 信息代号
%%        NewValue => 新的值(64位)
notify_cli_info_change_2(PS, ObjInfoCode, NewValue) ->
	notify_cli_info_change_2(PS, [{ObjInfoCode, NewValue}]).

notify_cli_info_change_2(PS, KV_TupleList) ->
	?ASSERT(util:is_tuple_list(KV_TupleList)),
	{ok, BinData} = pt_13:write(?PT_PLYR_NOTIFY_INFO_CHANGE_2, KV_TupleList),
	lib_send:send_to_sock(PS, BinData).


%% 获取血量上限
get_hp_lim(PS) -> PS#player_status.total_attrs#attrs.hp_lim.

%% 获取基础血量上限
get_base_hp_lim(PS) -> PS#player_status.base_attrs#attrs.hp_lim.

%% 获取/设置当前血量
get_hp(PS) -> PS#player_status.total_attrs#attrs.hp.
set_hp(PS, Value) ->
	gen_server:cast(PS#player_status.pid, {'set_hp', Value}).


%% 加/减血（如果是减血，则参数HpAdd传入负值）
add_hp(_PS, HpAdd) when HpAdd == 0 ->
	skip;
add_hp(PS, HpAdd) ->
	% NewHp = util:minmax(get_hp(PS) + HpAdd, 0, get_hp_lim(PS)), % 避免溢出
	% set_hp(PS, NewHp).
	gen_server:cast(PS#player_status.pid, {'add_hp', HpAdd}).


%% 获取魔法上限
get_mp_lim(PS) -> PS#player_status.total_attrs#attrs.mp_lim.

%% 获取基础魔法上限
get_base_mp_lim(PS) -> PS#player_status.base_attrs#attrs.mp_lim.

%% 获取/设置当前魔法值
get_mp(PS) -> PS#player_status.total_attrs#attrs.mp.
set_mp(PS, Value) ->
	gen_server:cast(PS#player_status.pid, {'set_mp', Value}).


%% 加/减魔法值（如果是减魔法值，则参数MpAdd传入负值）
add_mp(_PS, MpAdd) when MpAdd == 0 ->
	skip;
add_mp(PS, MpAdd) ->
	% NewMp = util:minmax(get_mp(PS) + MpAdd, 0, get_mp_lim(PS)), % 避免溢出
	% set_mp(PS, NewMp).
	gen_server:cast(PS#player_status.pid, {'add_mp', MpAdd}).


%% 设置当前hp和mp
set_hp_mp(PS, HpVal, MpVal) ->
	gen_server:cast(PS#player_status.pid, {'set_hp_mp', HpVal, MpVal}).


%% 设置为满血满魔
set_full_hp_mp(PS) ->
	gen_server:cast(PS#player_status.pid, 'set_full_hp_mp').

%% 获取累计充值元宝 TODO: 未实现!
get_yuanbao_acc(PS) ->
	?TRACE("============== not implement =============="),
	PS#player_status.yuanbao_acc.

%% 获取物理攻击
get_phy_att(PS) -> PS#player_status.total_attrs#attrs.phy_att.
%% 获取法术攻击
get_mag_att(PS) -> PS#player_status.total_attrs#attrs.mag_att.
%% 获取物理防御
get_phy_def(PS) -> PS#player_status.total_attrs#attrs.phy_def.
%% 获取法术防御
get_mag_def(PS) -> PS#player_status.total_attrs#attrs.mag_def.

%% 获取命中
get_hit(PS) -> PS#player_status.total_attrs#attrs.hit.
%% 获取闪避
get_dodge(PS) -> PS#player_status.total_attrs#attrs.dodge.
%% 获取暴击
get_crit(PS) -> PS#player_status.total_attrs#attrs.crit.
%% 获取坚韧（抗暴击）
get_ten(PS) -> PS#player_status.total_attrs#attrs.ten.


%% 获取物理暴击
get_phy_crit(PS) -> PS#player_status.total_attrs#attrs.phy_crit.
%% 获取物理（抗暴击）
get_phy_ten(PS) -> PS#player_status.total_attrs#attrs.phy_ten.
%% 获取法术暴击
get_mag_crit(PS) -> PS#player_status.total_attrs#attrs.mag_crit.
%% 获取法术（抗暴击）
get_mag_ten(PS) -> PS#player_status.total_attrs#attrs.mag_ten.

%% 获取物理暴击程度
get_phy_crit_coef(PS) ->
	PS#player_status.total_attrs#attrs.phy_crit_coef.
%% 获取法术暴击程度
get_mag_crit_coef(PS) ->
	PS#player_status.total_attrs#attrs.mag_crit_coef.

get_heal_value(PS) ->
	PS#player_status.total_attrs#attrs.heal_value.




%% 获取怒气
get_anger(PS) -> PS#player_status.total_attrs#attrs.anger.

%% 加/减怒气值（如果是减怒气值，则参数AngerAdd传入负值）
add_anger(PS, AngerAdd) ->
	gen_server:cast(PS#player_status.pid, {'add_anger', AngerAdd}).

%% 获取怒气上限
get_anger_lim(PS) -> PS#player_status.total_attrs#attrs.anger_lim.

%% 获取战斗中的出手速度
get_act_speed(PS) -> PS#player_status.total_attrs#attrs.act_speed.

%% 获取幸运
get_luck(PS) -> PS#player_status.total_attrs#attrs.luck.


%% 冰冻命中/抗性
get_frozen_hit(PS) -> PS#player_status.total_attrs#attrs.frozen_hit + get_seal_hit(PS).
get_frozen_resis(PS) -> PS#player_status.total_attrs#attrs.frozen_resis + get_seal_resis(PS).

%% 昏睡命中/抗性
get_trance_hit(PS) -> PS#player_status.total_attrs#attrs.trance_hit + get_seal_hit(PS).
get_trance_resis(PS) -> PS#player_status.total_attrs#attrs.trance_resis + get_seal_resis(PS).

%% 混乱命中/抗性
get_chaos_hit(PS) -> PS#player_status.total_attrs#attrs.chaos_hit + get_seal_hit(PS).
get_chaos_resis(PS) -> PS#player_status.total_attrs#attrs.chaos_resis + get_seal_resis(PS).

%% 封印命中/抗性
get_seal_hit(PS) -> PS#player_status.total_attrs#attrs.seal_hit.
get_seal_resis(PS) -> PS#player_status.total_attrs#attrs.seal_resis.

%% 获取物理伤害放缩系数
get_do_phy_dam_scaling(PS) ->
	PS#player_status.total_attrs#attrs.do_phy_dam_scaling.

%% 获取法术伤害放缩系数
get_do_mag_dam_scaling(PS) ->
	PS#player_status.total_attrs#attrs.do_mag_dam_scaling.

%% 获取暴击系数
get_crit_coef(PS) ->
	PS#player_status.total_attrs#attrs.crit_coef.

% %% 反震概率
% get_ret_dam_proba(PS) ->
% 	PS#player_status.total_attrs#attrs.ret_dam_proba.

% get_ret_dam_coef(PS) ->
% 	PS#player_status.total_attrs#attrs.ret_dam_coef.

get_store_hp(PS) ->
	PS#player_status.store_hp.

add_store_hp(PS, Add) ->
	gen_server:cast(PS#player_status.pid, {'add_store_hp', Add}).

get_store_mp(PS) ->
	PS#player_status.store_mp.

add_store_mp(PS, Add) ->
	gen_server:cast(PS#player_status.pid, {'add_store_mp', Add}).

get_store_par_hp(PS) ->
	PS#player_status.store_par_hp.

add_store_par_hp(PS, Add) ->
	gen_server:cast(PS#player_status.pid, {'add_store_par_hp', Add}).

get_store_par_mp(PS) ->
	PS#player_status.store_par_mp.

add_store_par_mp(PS, Add) ->
	gen_server:cast(PS#player_status.pid, {'add_store_par_mp', Add}).

get_update_mood_count(PS) ->
	if
		PS#player_status.last_update_mood_time =:= 0 -> 0;
		true ->
			case util:is_same_day(get_last_update_mood_time(PS)) of
				true -> PS#player_status.update_mood_count;
				false ->
					set_update_mood_count(PS, 0),
					0
			end
	end.

set_update_mood_count(PS, Value) ->
	?ASSERT(Value >= 0, Value),
	asyn_update_PS_fields(PS, ?PSF_UPDATE_MOOD_COUNT, Value).

get_last_update_mood_time(PS) ->
	PS#player_status.last_update_mood_time.

set_last_update_mood_time(PS, Value) ->
	?ASSERT(Value >= 0, Value),
	asyn_update_PS_fields(PS, ?PSF_LAST_UPDATE_MOOD_TIME, Value).


get_last_daily_reset_time(PS) ->
	PS#player_status.last_daily_reset_time.

set_last_daily_reset_time(PS, Timestamp) ->
	asyn_update_PS_fields(PS, ?PSF_LAST_DAILY_RESET_TIME, Timestamp).


get_last_weekly_reset_time(PS) ->
	PS#player_status.last_weekly_reset_time.

set_last_weekly_reset_time(PS, Timestamp) ->
	asyn_update_PS_fields(PS, ?PSF_LAST_WEEKLY_RESET_TIME, Timestamp).

get_xs_task_issue_num(PS) ->
	PS#player_status.xs_task_issue_num.

set_xs_task_issue_num(PS, Num) ->
	asyn_update_PS_fields(PS, ?PSF_XS_TASK_ISSUE_NUM, Num).

get_xs_task_left_issue_num(PS) ->
	PS#player_status.xs_task_left_issue_num.

set_xs_task_left_issue_num(PS, Num) ->
	asyn_update_PS_fields(PS, ?PSF_XS_TASK_LEFT_ISSUE_NUM, Num).

get_xs_task_receive_num(PS) ->
	PS#player_status.xs_task_receive_num.

set_xs_task_receive_num(PS, Num) ->
	asyn_update_PS_fields(PS, ?PSF_XS_TASK_RECEIVE_NUM, Num).

%玩家阵法信息
get_zf_state(PS) ->
	PS#player_status.zf_state.

set_zf_state(PS, Value) ->
	asyn_update_PS_fields(PS, ?PSF_ZF_STATE, Value).

% get_rela_list(PS) ->
% 	PS#player_status.rela_list.

% set_rela_list(PS, List) ->
% 	?ASSERT(is_list(List), List),
% 	asyn_update_PS_fields(PS, ?PSF_RELA_LIST, List).


%% ---------------------------------- functions about attributes END --------------------------------




%% ---------------------------------- functions about exp and upgrade BEGIN --------------------------------

%% 获取经验上限
get_exp_lim(PS) ->
	data_exp:get(PS#player_status.lv).
% R#lv_exp_lim.exp_lim.

%% 获取巅峰等级经验上限
get_peak_exp_lim(PS) ->
	case data_peak_level_limit:get(PS#player_status.peak_lv) of
		#peak_level_limit{
			d_exp_lim = ExpLimit
		} -> ExpLimit;
		_ -> ?MAX_U32
	end.


%% 获取/设置当前经验值 离线
get_exp(PlayerId) when is_integer(PlayerId) ->
	case db:select_one(player, "exp", [{id, PlayerId}], [], [1]) of
		null -> 0;
		Exp -> Exp
	end;

get_exp(PS) -> PS#player_status.exp.

% set_exp(PS, NewExp) ->
% 	?ASSERT(is_record(PS, player_status)),
% 	asyn_update_PS_fields(PS, ?PSF_EXP, NewExp).


%% 通知客户端：当前经验更改了
notify_cli_exp_change(PS, NewExp) ->
	notify_cli_info_change(PS, ?OI_CODE_EXP, NewExp).


%% 通知客户端：玩家升级了
notify_cli_upgrade(PS, NewLv) ->
	MyId = get_id(PS),
	?TRACE("notify_cli_upgrade(), Id=~p, NewLv=~p~n", [MyId, NewLv]),
	{ok, BinData} = pt_13:write(?PT_PLYR_NOTIFY_UPGRADE, [MyId, NewLv]),
	lib_send:send_to_sock(PS, BinData),
	%% 通知aoi范围内的其他玩家
	lib_scene:notify_int_info_change_to_aoi(player, MyId, [{?OI_CODE_LV, NewLv}]).


%% 通知客户端：玩家升级了
notify_cli_peak_upgrade(PS, NewLv) ->
	MyId = get_id(PS),
	?TRACE("notify_cli_peak_upgrade(), Id=~p, NewLv=~p~n", [MyId, NewLv]),
	{ok, BinData} = pt_13:write(?PT_PLYR_NOTIFY_PEAK_UPGRADE, [MyId, NewLv]),
	lib_send:send_to_sock(PS, BinData),
	%% 通知aoi范围内的其他玩家
	lib_scene:notify_int_info_change_to_aoi(player, MyId, [{?OI_CODE_PEAK_LV, NewLv}]).


%% 升级后保存玩家的相关信息（如等级、当前经验）到DB
db_save_for_upgrade(PS_Latest) ->
	PlayerId = get_id(PS_Latest),
	db:update(
		PlayerId,
		player,
		["lv", "exp", "base_talents", "free_talent_points"],
		[get_lv(PS_Latest), get_exp(PS_Latest), build_talents_bitstring(get_base_talents(PS_Latest)), get_free_talent_points(PS_Latest)],
		"id",
		PlayerId
	).


%% 巅峰等级升级后保存玩家的相关信息（如等级、当前经验）到DB
db_save_for_peak_upgrade(PS_Latest) ->
	PlayerId = get_id(PS_Latest),
	db:update(
		PlayerId,
		player,
		["peak_lv", "exp", "base_talents", "free_talent_points"],
		[get_peak_lv(PS_Latest), get_exp(PS_Latest), build_talents_bitstring(get_base_talents(PS_Latest)), get_free_talent_points(PS_Latest)],
		"id",
		PlayerId
	).


%% （加经验后）保存经验到DB
db_save_exp(PlayerId, NewExp) ->
	?ASSERT(is_integer(PlayerId)),
	db:update(
		PlayerId,
		player,
		["exp"],
		[NewExp],
		"id",
		PlayerId
	).



% %% 保存玩家的当前经验到DB
% db_save_player_exp(PlayerId, NewExp) ->
% 	db:update(player, ["exp"], [NewExp], "id", PlayerId).


%% 加经验
%% @return: 无用
add_exp(PS, AddValue) ->
	add_exp(PS, AddValue, []).

add_exp(PS, AddValue, LogInfo) when is_integer(AddValue) ->
	% lib_log:statis_produce_currency(PS, ?MNY_T_EXP, AddValue, _LogInfo),
	gen_server:cast(PS#player_status.pid, {'add_exp', AddValue, LogInfo}).



%% 给主宠加经验
add_exp_to_main_par(_PS, AddVal, _LogInfo) when AddVal == 0 ->
	skip;
add_exp_to_main_par(PS, AddVal, LogInfo) when is_integer(AddVal) andalso AddVal >= 0 ->
	gen_server:cast(PS#player_status.pid, {'add_exp_to_main_par', AddVal, LogInfo});
add_exp_to_main_par(_PS, _AddVal, _LogInfo) ->
	?ASSERT(false, {_AddVal, _PS, _LogInfo}),
	skip.


%% 给所有出战的副宠加经验
add_exp_to_fighting_deputy_pars(_PS, AddVal, _LogInfo) when AddVal == 0 ->
	skip;
add_exp_to_fighting_deputy_pars(PS, AddVal, LogInfo) when is_integer(AddVal) andalso AddVal >= 0 ->
	gen_server:cast(PS#player_status.pid, {'add_exp_to_fighting_deputy_pars', AddVal, LogInfo});
add_exp_to_fighting_deputy_pars(_PS, _AddVal, _LogInfo) ->
	?ASSERT(false, {_AddVal, _PS, _LogInfo}),
	skip.


%% @doc 同时加人物/宠物经验
add_all_exp(_PS, 0, _LogInfo) -> skip;
add_all_exp(PS, AddVal, LogInfo) ->
	add_all_exp(PS, AddVal, 1, LogInfo).

add_all_exp(_PS, 0, _Coef, _LogInfo) -> skip;
add_all_exp(PS, AddVal, Coef, LogInfo) ->
	add_exp(PS, AddVal, LogInfo),
	add_exp_to_main_par(PS, AddVal, LogInfo),
	add_exp_to_fighting_deputy_pars(PS, util:ceil(AddVal * Coef), LogInfo).


%% 扣经验
%% @return: 无用
cost_exp(PS, CostValue) ->
	cost_exp(PS, CostValue, []).

cost_exp(_PS, CostValue, _) when CostValue == 0 ->
	skip;

% 离线
cost_exp(PlayerId, CostValue, LogInfo) when is_integer(PlayerId) ->
	% 记录日志
	% lib_log:statis_consume_currency(PlayerId, ?MNY_T_EXP, CostValue, LogInfo),

	NewExp = erlang:max(get_exp(PlayerId) - CostValue,0),
	db:update(player, [{exp, NewExp}], [{id, PlayerId}]),

	skip;

cost_exp(PS, CostValue, LogInfo) when is_integer(CostValue), CostValue > 0 ->
	% lib_log:statis_consume_currency(PS, ?MNY_T_EXP, CostValue, LogInfo),
	gen_server:cast(PS#player_status.pid, {'add_exp', - CostValue, LogInfo}).


cost_exp_by_flee(PS) ->
	PvpFlee = case lib_player_ext:try_load_data(id(PS),pvp_flee) of
							fail ->
								0;
							{ok,PvpFlee_} ->
								PvpFlee_
						end,

	?DEBUG_MSG("PvpFlee=~p",[PvpFlee]),
	case PvpFlee of
		1 ->
			lib_player_ext:try_update_data(id(PS),pvp_flee,0),
			% player_syn:update_PS_to_ets(NewPS),

			lib_mail:send_sys_mail(id(PS)
				,<<"我不要做懦夫">>
				,<<"在一次偷袭战中您逃跑了，所以您的经验值减少了！请强大起来！">>
				,[]
				,[?LOG_FORCE_PK, lose]
			),

			cost_exp(PS,util:ceil(player:get_exp(PS)*?KILL_SUB_EXT_COEF*2),[?LOG_FORCE_PK,lose]);
		0 ->
			skip
	end.


% 作废！！
% %% 增加经验
% %% @return: 无用
% do_add_exp(PS, ExpToAdd) ->
%     NewExp = get_exp(PS) + ExpToAdd,
%     ExpLim = get_exp_lim(PS),
%     Lv = get_lv(PS),
%     if
%         ExpLim > NewExp orelse Lv >= ?MANUAL_UPGRADE_START_LV ->  % 未能升级，或者玩家已达到了10级
%         	set_exp(PS, NewExp),
%         	notify_cli_exp_change(PS, NewExp),
%         	% 若大于一定的阀值（暂定为4000），则即时更新到DB
%         	?Ifc (NewExp > 4000)
%         		db_save_exp(PS#player_status.id, NewExp)
%         	?End;

%         true ->  % 前10级自动升级
%             set_exp(PS, NewExp),
%             % 因上面更新经验是异步的，故这里cast回玩家进程以准备自动升级!
%             gen_server:cast(PS#player_status.pid, 'auto_upgrade')
%     end.



%% 是否可以升级？
%% @return: true | false
can_upgrade(PS) ->
	MaxLv = player:get_player_max_lv(PS),

	get_lv(PS) < MaxLv
		andalso get_exp(PS) >= get_exp_lim(PS)
		andalso check_break(PS).

%% 检查角色突破
check_break(PS) ->
	ID = get_id(PS),
	Lv = get_lv(PS),
	case data_lv_break:get(Lv) of
		#lv_break{master_xinfa_lv_need=MasterXF,
			slave_xinfa_lv_need=SlaveXF} ->
			F = fun(#xinfa_brief{lv=XfLv}) -> XfLv >= SlaveXF end,

			MasterOK = ply_xinfa:get_player_master_xinfa_lv(ID) >= MasterXF,
			MasterOK andalso lists:all(F, ply_xinfa:get_player_slave_xinfa_brief_list(ID));
		_ ->
			?true
	end.




%% 升级
do_upgrade(PS) ->
	% ?ASSERT(can_upgrade(PS_Latest)),
	% CurExp = get_exp(PS_Latest),
	% ExpLim = get_exp_lim(PS_Latest),
	% NewLv = get_lv(PS_Latest) + 1,
	%    LeftExp = max(CurExp - ExpLim, 0),   % 升级扣去相应经验后的剩余经验。 这里做max矫正，是为了防止：万一出bug的话，玩家会得到一个数值很大的经验值
	%    set_lv(PS_Latest, NewLv),
	%    set_exp(PS_Latest, LeftExp),

	% % 处理天赋属性点
	% handle_talent_points_on_upgrade(PS_Latest, NewLv),

	% % 通知客户端
	% notify_cli_upgrade(PS_Latest, NewLv),

	% % 最后，cast回玩家进程，准备做升级后的后续处理
	% gen_server:cast(PS_Latest#player_status.pid, 'post_upgrade').

	gen_server:cast(PS#player_status.pid, 'do_upgrade').




% %% 升级时处理天赋属性点
% handle_talent_points_on_upgrade(PS, NewLv) ->
% 	% 每提升一级各个天赋点都增加一点（体质和耐力除外，是0.5），
% 	% 另外有额外5点给玩家自己任意加（10级前则自动帮玩家加）
% 	AddPoint_Con = 	case util:is_odd(NewLv) of  % 体质每级加0.5，等价于每两级加1，下面的耐力同理
% 						true -> 1;
% 						false -> 0
% 					end,
% 	AddPoint_Stam = case util:is_odd(NewLv) of
% 						true -> 1;
% 						false -> 0
% 					end,
% 	AddPoint_Str = 1,
% 	AddPoint_Spi = 1,
% 	AddPoint_Agi = 1,

% 	case NewLv < ?MANUAL_UPGRADE_START_LV of
% 		true ->
% 			case get_race(PS) of
% 				?RACE_REN ->  % 人族：额外5点的自动分配规则———— 4力量1体质
% 					add_base_str(PS, AddPoint_Str + 4),
% 					add_base_con(PS, AddPoint_Con + 1),
% 					add_base_stam(PS, AddPoint_Stam),
% 					add_base_spi(PS, AddPoint_Spi),
% 					add_base_agi(PS, AddPoint_Agi);
% 				?RACE_MO ->  % 魔族：额外5点的自动分配规则———— 4力量1体质
% 					add_base_str(PS, AddPoint_Str + 4),
% 					add_base_con(PS, AddPoint_Con + 1),
% 					add_base_stam(PS, AddPoint_Stam),
% 					add_base_spi(PS, AddPoint_Spi),
% 					add_base_agi(PS, AddPoint_Agi);
% 				?RACE_XIAN -> % 仙族：额外5点的自动分配规则———— 4灵力1体质
% 					add_base_str(PS, AddPoint_Str),
% 					add_base_con(PS, AddPoint_Con + 1),
% 					add_base_stam(PS, AddPoint_Stam),
% 					add_base_spi(PS, AddPoint_Spi + 4),
% 					add_base_agi(PS, AddPoint_Agi);
% 				?RACE_YAO ->
% 					?ASSERT(false),
% 					todo_here   % 待定
% 			end;
% 		false ->
% 			add_base_str(PS, AddPoint_Str),
% 			add_base_con(PS, AddPoint_Con),
% 			add_base_stam(PS, AddPoint_Stam),
% 			add_base_spi(PS, AddPoint_Spi),
% 			add_base_agi(PS, AddPoint_Agi),
% 			add_free_talent_points(PS, 5)
% 	end.





% %% 手动升级
% handle_manual_upgrade(PS_Latest) ->
% 	?ASSERT(can_upgrade(PS_Latest)),
% 	do_upgrade(PS_Latest).






%% 下线时是否延迟执行final_logout()？
%% @return boolean()
get_final_logout_delay() ->
	case erlang:get(?PDKN_DELAY_DO_FINAL_LOGOUT) of
		undefined -> true;
		Val -> Val
	end.

%% @Bool::boolean()
set_final_logout_delay(Bool) when is_boolean(Bool) ->
	erlang:put(?PDKN_DELAY_DO_FINAL_LOGOUT, Bool).


%% 获取后台回调PID
%% @return null | Pid
get_admin_callback_pid() ->
	case erlang:get(?PDKN_ADMIN_CALLBACK_PID) of
		undefined -> null;
		Val when is_pid(Val) -> Val;
		_ -> null
	end.

%% 设置后台回调PID
set_admin_callback_pid(Pid) ->
	erlang:put(?PDKN_ADMIN_CALLBACK_PID, Pid).



%% ---------------------------------- functions about exp and upgrade END --------------------------------





%%重命名玩家
rename(Id, Name) ->
	db:update(player, ["nickname"], [Name], "id", Id).





% %% 获取玩家已学的技能id列表
% get_learned_skill_id_list(PS) ->
% 	[SkillId || {SkillId, _SkillLv, _Grid} <- PS#player_status.skill].


% %% 获取玩家已装备的技能id列表
% get_equipped_skill_id_list(PS) ->
% 	[SkillId || {SkillId, _SkillLv, _Grid} <- PS#player_status.eq_skill].








%% 通知角色的装备更换（仅限会改变角色外形显示的装备）给邻近玩家
notify_equip_changed_to_neig(_PS, _CurrentEquipList) ->
	% ?TRACE("notify equip changed: playerid: ~p, equip list: ~p~n", [PS#player_status.id, CurrentEquipList]),
	% [Weapon, Clothes, Wings, Mount] = CurrentEquipList,
	% {ok, BinData} = pt_13:write(13012, {PS#player_status.id, Weapon, Clothes, Wings, Mount, PS#player_status.wings_show, PS#player_status.wings_stren}),
	% lib_send:send_to_area_scene(PS#player_status.scene_id, PS#player_status.line_id, PS#player_status.x, PS#player_status.y, BinData).
	todo_here.



is_vip(PS) ->
	lib_vip:lv(PS) > 0.

is_vip_experience(PS) ->
	lib_vip:is_experience(PS).

get_vip_lv(PlayerId) when is_integer(PlayerId) ->
	case get_PS(PlayerId) of
		null ->
			mod_offline_data:get_vip_lv(PlayerId);
		PS ->
			get_vip_lv(PS)
	end;
get_vip_lv(PS) ->
	lib_vip:lv(PS).

get_vip_expire_time(PS) ->
	lib_vip:expire_time(PS).


set_vip_info(PS, VipInfo) when is_record(VipInfo, vip) ->
	asyn_update_PS_fields(PS, ?PSF_VIP_INFO, VipInfo).



%% 更新玩家结构体的单个字段到ets（ 注意：为了避免同步问题，统一cast到玩家进程做处理，下同）
%% @return: 无
asyn_update_PS_fields(PlayerId, Field, NewValue) when is_integer(PlayerId) ->
	gen_server:cast(get_pid(PlayerId), {'update_PS_fields', [{Field, NewValue}]} ),
	void;

%% 更新玩家结构体的单个字段到ets
asyn_update_PS_fields(PS, Field, NewValue) ->
	?ASSERT(is_record(PS, player_status), PS),
	gen_server:cast(PS#player_status.pid, {'update_PS_fields', [{Field, NewValue}]} ),
	void.



%% 更新玩家结构体的多个字段到ets
%% @para: FieldValueList => 格式为：[{字段名, 新的值}, ...]
asyn_update_PS_fields(PlayerId, FieldValueList) when is_integer(PlayerId) ->
	?ASSERT(is_list(FieldValueList), FieldValueList),
	gen_server:cast(get_pid(PlayerId), {'update_PS_fields', FieldValueList}),
	void;

%% 更新玩家结构体的多个字段到ets
asyn_update_PS_fields(PS, FieldValueList) ->
	?ASSERT(is_record(PS, player_status), PS),
	?ASSERT(is_list(FieldValueList), FieldValueList),
	gen_server:cast(PS#player_status.pid, {'update_PS_fields', FieldValueList}),
	void.

 

%% 会影响外形的装备信息
get_showing_equips(PS) ->
	PS#player_status.showing_equips.

set_showing_equips(PS, ShowingEquips) when is_record(ShowingEquips, showing_equip) ->
	asyn_update_PS_fields(PS, ?PSF_SHOWING_EQUIPS, ShowingEquips).


get_showing_equips_base_setting(PS) ->
	ShowingEquips = get_showing_equips(PS),
	PlayerId = id(PS),
	ShowingEquips#showing_equip{
		headwear = case ply_setting:is_headwear_hide(PlayerId) of true -> ?INVALID_NO; false -> ShowingEquips#showing_equip.headwear end,
		clothes = case ply_setting:is_clothes_hide(PlayerId) of true -> ?INVALID_NO; false -> ShowingEquips#showing_equip.clothes end,
		backwear = case ply_setting:is_backwear_hide(PlayerId) of true -> ?INVALID_NO; false -> ShowingEquips#showing_equip.backwear end
	}.  


%% 永久禁言
forever_ban_chat(RoleId, Reason) ->
	ban_chat(RoleId, -1, Reason).

%% 解除禁言
cancel_ban_chat(RoleId, Reason) ->
	ban_chat(RoleId, 0, Reason).

%% 禁言
ban_chat(RoleId, Time, Reason) ->
	EndTime =
		if  Time =:= -1 -> ?FORVER_BAN_TIME;
			Time =:= 0 -> ?CANCEL_BAN_TIME;
			true -> util:unixtime() + Time
		end,
	case player:is_online(RoleId) of
		true -> gen_server:cast(player:get_pid(RoleId), {'ban_chat', EndTime, Reason});
		false -> offline_ban_chat(RoleId, EndTime, Reason)
	end.

%% 离线禁言
offline_ban_chat(RoleId, EndTime, Reason) ->
	db:replace(t_ban_chat, [{role_id, RoleId}, {end_time, EndTime}, {reason, Reason}]).


%% 封禁角色
ban_role(RoleId, Time, Reason) ->
	EndTime =
		if  Time =:= -1 -> ?FORVER_BAN_TIME;
			Time =:= 0 -> ?CANCEL_BAN_TIME;
			true -> util:unixtime() + Time
		end,
	case player:is_online(RoleId) of
		true -> kick_role_offline(RoleId);
		false -> skip
	end,
	db:replace(t_ban_role, [{role_id, RoleId}, {end_time, EndTime}, {reason, Reason}]),
	ets:insert(?ETS_BANNED_ROLE, #banned_role{role_id = RoleId, end_time = EndTime}).


%% @doc取得角色封禁状态
%% @return boolean()
is_role_banned(RoleId) ->
	case ets:lookup(?ETS_BANNED_ROLE, RoleId) of
		[] -> false;
		[Rd | _] ->
			EndTime = Rd#banned_role.end_time,
			if  EndTime =:= ?CANCEL_BAN_TIME ->
				ets:delete(?ETS_BANNED_ROLE, RoleId),
				false;
				EndTime =:= ?FORVER_BAN_TIME -> true;
				true -> EndTime > util:unixtime()
			end
	end.


%% @doc 查询角色是否被禁言  !! 只能在该玩家进程执行
%% @return boolean()
is_chat_banned(_RoleId) ->
	case get(?BAN_CHAT) of
		undefined -> false;
		{?FORVER_BAN_TIME, _Reason} -> true;
		{?CANCEL_BAN_TIME, _} -> erase(?BAN_CHAT), false;
		{Time, _Reason} ->
			Now = util:unixtime(),
			case Now >= Time of
				true -> erase(?BAN_CHAT), false;
				false -> true
			end
	end.


% case db:select_row(t_ban_role, "end_time", [{role_id, RoleId}]) of
% 	[] -> false;
% 	[EndTime] ->
% 		if  EndTime =:= ?CANCEL_BAN_TIME -> false;
% 			EndTime =:= ?FORVER_BAN_TIME -> true;
% 			true -> EndTime > util:unixtime()
% 		end
% end.


%% 踢玩家下线
kick_role_offline(RoleId) ->
	case player:is_online(RoleId) of
		true ->
			PS = get_PS(RoleId),
			AccName = get_accname(PS),
			FromServerId = get_from_server_id(PS),
			Pid = get_pid(PS),
			mod_login:force_disconnect(AccName, FromServerId, RoleId, Pid);
		false ->
			skip
	end.

%% 立即踢玩家下线,马上保存清理缓存
%% @return ok | wait
kick_role_offline_immediate(RoleId) ->
	case is_online(RoleId) of
		true ->
			gen_server:cast(player:get_pid(RoleId), {'kick_role_offline_immediate', self()}),
			wait;
		false ->
			case in_tmplogout_cache(RoleId) of
				true -> mod_ply_jobsch:force_handle_reconnect_timeout_sch(RoleId);
				false -> skip
			end,
			ok
	end.




%% @doc 玩家充值
%% @RoleId::integer() 玩家ID
%% @Money::integer() 玩家充值所花费的真实货币
%% @GameMoney::integer() 后台根据真实货币和汇率转换成要充值的游戏币，这里为元宝
%% @return : true | {false, Code}
admin_recharge(RoleId, Money, GameMoney, OrderId, Timestamp) ->
	try db:select_row(recharge_order, "order_id", [{order_id, OrderId}]) of
		[] ->
			try db:insert(recharge_order, [{order_id, OrderId}, {role_id, RoleId}, {amount, Money}, {timestamp, Timestamp}, {state, ?RECHARGE_UN_DEAL}]) of
				_R ->
					catch notify_player_recharge(RoleId),
					true
			catch
				Type:Err ->
					?ERROR_MSG("[recharge] admin_recharge insert recharge order type = ~p, error = ~p~n", [Type, Err]),
					{false, 5}
			end;
		_ -> {false, 2}
	catch
		SelectType:SelectErr ->
			?ERROR_MSG("[recharge] admin_recharge select recharge order type = ~p, error = ~p~n", [SelectType, SelectErr]),
			{false, 5}
	end.
% case db:select_row(recharge, "amount, state", [{role_id, RoleId}]) of
% 	[] ->
% 		db:insert(recharge, [{role_id, RoleId}, {amount, GameMoney}, {state, ?RECHARGE_UN_DEAL}]),
% 		notify_player_recharge(RoleId),
% 		true;
% 	[Amount, State] ->
% 		NewAmount = ?BIN_PRED(State =:= ?RECHARGE_UN_DEAL, Amount + GameMoney, GameMoney),
% 		db:update(recharge, [{amount, NewAmount}, {state, ?RECHARGE_UN_DEAL}], [{role_id, RoleId}]),
% 		notify_player_recharge(RoleId),
% 		true;
% 	_ -> false
% end.
% player:admin_recharge(2000100000000001, 1, 100, 99, 101).
% player:admin_recharge(1000100000000001, 1, 39).

%% @doc 通知玩家处理充值订单
notify_player_recharge(RoleId) when is_integer(RoleId) ->
	case player:is_online(RoleId) of
		true ->
			case player:get_pid(RoleId) of
				Pid when is_pid(Pid) -> gen_server:cast(Pid, 'handle_recharge');
				_ -> skip
			end;
		false -> skip
	end;
notify_player_recharge(Status) when is_record(Status, player_status) ->
	gen_server:cast(player:get_pid(Status), 'handle_recharge');
notify_player_recharge(_) -> ?ASSERT(false).

% 获取充值配置表人民币和元宝的兑换比例
recharge_ratio() ->
	case data_recharge:get_normal_card_nos() of
		[No|_] ->
			case data_recharge:get_data_by_no(No) of
				#recharge{money = Money, yuanbao = Yuanbao} ->
					erlang:round(Yuanbao / Money);
				_ ->
					?ERROR_MSG("recharge config data has err!!!!!!!!!", []),
					%% 找不到，默认填个10倍
					10
			end;
		_ ->
			?ERROR_MSG("recharge config data has err!!!!!!!!!", []),
			%% 找不到，默认填个10倍
			10
	end.

% 充值检测
recharge(Status) when is_record(Status, player_status) ->
	RoleId = player:id(Status),

	case db:select_all(recharge_order, "order_id, amount", [{role_id, RoleId}, {state, ?RECHARGE_UN_DEAL}]) of
		[] -> skip;
		[[OrderId, Amount] | Left] ->
			RecharePS =
				case data_recharge:get_data_by_money(Amount) of
					Recharge when is_record(Recharge, recharge) ->
						%%连充
						%%判断活动是否开启
						%%先判断玩家今天是否领过
						try begin
									PlyMisc = ply_misc:get_player_misc(RoleId),
									{LastUnixTime, LastIndex} = PlyMisc#player_misc.recharge_unixtime,
									case util:is_same_day(LastUnixTime) of
										true ->
											skip;
										false ->
											case db:select_row(admin_sys_activity, "order_id", [{sys,  19}, {state,1}]) of
												[] ->
													skip;
												[NewOrderId] ->
													case ets:lookup(ets_admin_sys_activity, NewOrderId) of
														[] ->
															skip;
														[Day_Recharge_R] ->
															%%判断充值是否隔天了
															LastIndex2 =
																case util:get_differ_days_by_timestamp(util:unixtime() ,LastUnixTime) > 1 of
																	true ->
																		0;
																	false ->
																		LastIndex
																end,
															{Title,Content, RewardList} = Day_Recharge_R#admin_sys_activity.content,
															case lists:keyfind(LastIndex2 + 1, 1, RewardList) of
																false ->
																	ply_misc:update_player_misc(PlyMisc#player_misc{recharge_unixtime = {util:unixtime(),0}});
																{NewIndex,GoodsList} ->
																	lib_mail:send_sys_mail(RoleId, Title, Content, GoodsList, ["log_mail", "day_fanli"]),
																	NewIndex2 = case NewIndex > 6 of
																								true ->
																									0;
																								false ->
																									NewIndex
																							end,
																	ply_misc:update_player_misc(PlyMisc#player_misc{recharge_unixtime = {util:unixtime(),NewIndex2}})
															end
													end
											end
									end
								end
						catch RE:RT ->
							?ERROR_MSG("{rechargeunix,erlang:get_stacktrace()} : ~p~n", [{RE,RT,erlang:get_stacktrace()}])
						end,

						case is_first_rechargeactivity_open() andalso is_first_recharge(Status, Recharge#recharge.no) of
							true ->
								mark_recharge_order(OrderId),
								Status1 = recharge_add_money(?MNY_T_YUANBAO, Status, Recharge#recharge.yuanbao),
								Status2 = recharge_add_money(Recharge#recharge.normal_feekback_type, Status1, Recharge#recharge.normal_feekback_num),
								Status3 = set_frist_recharge(Status2, Recharge#recharge.no),

								db:update(player,
									[{yuanbao, player:get_yuanbao(Status3)},
										{recharge_state, util:term_to_bitstring(Status3#player_status.recharge_state)}],
									[{id, player:id(Status3)}]),

								catch send_first_recharge_reward(Status3),
								catch notify_recharge_state(Status3),
								%普通首充送无限金币

								case Recharge#recharge.type == 1 of
									true ->
										UnlimitedResources = Status3#player_status.unlimited_resources,
										case lists:member(1, UnlimitedResources) of
											true ->
												Status3;
											false ->
												player:get_unlimited_data(Status3#player_status{unlimited_resources = [1|UnlimitedResources]}),
												Status3#player_status{unlimited_resources = [1|UnlimitedResources]}
										end;
									false ->
										Status3
								end;

							false ->
								mark_recharge_order(OrderId),
								Status1 = recharge_add_money(?MNY_T_YUANBAO, Status, Recharge#recharge.yuanbao),
								db:update(player,
									[{yuanbao, player:get_yuanbao(Status1)}],
									[{id, player:id(Status1)}]),

								catch send_first_recharge_reward(Status1),
								catch notify_recharge_state(Status1),
								Status1
						end;
					_ ->
						%% 找不到对应的充值数据，按配置表倍率换算水玉
						mark_recharge_order(OrderId),
						Ratio = recharge_ratio(),
						Status1 = recharge_add_money(?MNY_T_YUANBAO, Status, Amount * Ratio),
						db:update(player,
							[{yuanbao, player:get_yuanbao(Status1)}],
							[{id, player:id(Status1)}]),

						catch send_first_recharge_reward(Status1),
						catch notify_recharge_state(Status1),
						Status1
				end,

			try handle_after_recharge(Amount, RecharePS) of
				AfterPS ->
					case AfterPS of
						#player_status{} ->
							player_syn:update_PS_to_ets(AfterPS);
						_ ->
							?ERROR_MSG("~n~n~n~nAfterPS : ~p~n~n~n", [AfterPS]),
							player_syn:update_PS_to_ets(RecharePS)
					end
			catch E:T ->
				?ERROR_MSG("{E,T,erlang:get_stacktrace()} : ~p~n", [{E,T,erlang:get_stacktrace()}])			end,
			?BIN_PRED(Left =:= [], skip, notify_player_recharge(RecharePS));

		_Ohter -> ?ERROR_MSG("[recharge] handle recharge load recharge order err = ~p~n", [_Ohter])
	end;

recharge(_) -> ?ASSERT(false).


%% @doc 充值订单处理完毕后续处理
%% 玩家进程处理，返回更新PS，后续处理必须保存PS
%% 所调用的函数必须只操作传入的PS参数，并把最新的PS参数同步返回，不可自己获取PS更新！！！
%% @return : NewPS
handle_after_recharge(Amount, Status) when is_record(Status, player_status) ->
	YuanBao = case data_recharge:get_data_by_money(Amount) of
							#recharge{yuanbao = YuanBao0} ->
								YuanBao0;
							_ ->
								Ratio = recharge_ratio(),
								Amount * Ratio
						end,
	%% 	BinYuanBao = Status#player_status.bind_yuanbao  +  Amount,

	{ok, Value} = lib_player_ext:try_load_data(player:get_id(Status),tuhaobang),
	mod_rank:role_RMB(Status, Value + Amount),
	lib_player_ext:try_update_data(player:get_id(Status),tuhaobang, Value +  Amount),
	Status1 = lib_vip:pay(YuanBao, Status),
	Status2 = Status1#player_status{yuanbao_acc = (Status1#player_status.yuanbao_acc + YuanBao)},
	Status3 = case Status2#player_status.first_recharge_reward_state =:= 0 of
							true ->
								RoleId = player:id(Status2),
								db:update(RoleId, player, [{first_recharge_reward_state, 1}], [{id, RoleId}]),
								%% 发条信息让自己自动领取首充礼包奖励
								gen_server:cast(get_pid(Status), {apply_cast, ?MODULE, give_first_recharge_reward, [get_id(Status)]}),
								Status2#player_status{first_recharge_reward_state = 1};
							false -> Status2
						end,

	% 累积充值100送无限金币
	AccAmount = round(Status3#player_status.yuanbao_acc / recharge_ratio()),
	Status4 = case AccAmount >= data_special_config:get('unlimit_jinbi_price') of
							true ->
								UnlimitedResources = Status3#player_status.unlimited_resources,
								case lists:member(9, UnlimitedResources) of
									true ->
										Status3;
									false ->
										player:get_unlimited_data(Status3#player_status{unlimited_resources = [9|UnlimitedResources]}),
										Status3#player_status{unlimited_resources = [9|UnlimitedResources]}
								end;
							false ->
								Status3
						end,
	% 充值刷怪
	case data_recharge:get_data_by_money(Amount) of
		Recharge when is_record(Recharge, recharge) ->
			?DEBUG_MSG("Recharge#recharge.mabey_mon=~p",[Recharge#recharge.mabey_mon]),
			case Recharge#recharge.mabey_mon of
				0 ->
					skip;
				{Proba,List} when is_list(List) ->
					case util:decide_proba_once(Proba) of
						fail -> skip  ;
						success ->
							Nth = util:rand(1, length(List)),
							DigNo = lists:nth(Nth, List),
							mod_dig_treasure:test_dig(DigNo, Status)
					end;
				_ -> skip
			end;
		___O ->
			?DEBUG_MSG("___O=~p",[___O]),
			skip
	end,


	% 累计充值活动
	NewPS =
		case catch get_recharge_accum(Amount, Status4) of
			AccStatus when is_record(AccStatus, player_status) -> AccStatus;
			_ -> Status4
		end,
	% 单笔充值活动
	NewPS1 =
		case get_recharge_one(Amount, NewPS) of
			TStatus when is_record(TStatus, player_status) -> TStatus;
			_ -> NewPS
		end,

	% 累计充值每日活动
	NewPS2 =
		case get_recharge_accum_day(Amount, NewPS1) of
			DStatus when is_record(DStatus, player_status) -> DStatus;
			_ -> NewPS1
		end,

	% 充值获得积分
	IntegralRatio = case data_special_config:get('integral_ratio') of
										IntegralRatio0 when erlang:is_number(IntegralRatio0) ->
											IntegralRatio0;
										_Null ->
											?ERROR_MSG("Error data_special_config:get('integral_ratio')", []),
											10
									end,
	Integral = Amount * IntegralRatio,
	player:add_bind_gamemoney(NewPS2, Integral, [?LOG_PAY, Amount]),
	%% 通知前端累计充值金额
	RechargeSum = add_recharge_sum(player:id(NewPS2), Amount),
	notify_recharge_sum(NewPS2, RechargeSum),
	%% 发送累充奖励
	recharge_accumulated(NewPS2, RechargeSum),
	%% 20191213zjy 需求更改，屏蔽三次首冲
%% 	NewPS3 = update_first_recharge(NewPS2, Amount),
%% 	notice_first_recharge(NewPS3),
	% 充值获取幸运转盘次数
%% 	ErnieAmount = data_special_config:get('ernie_count'),
%% 	case Amount < ErnieAmount of
%% 		true ->
%% 			skip;
%% 		false ->
%% 			ErnieCount = util:ceil(Amount / ErnieAmount),
%% 			lib_ernie:add_ernie(player:id(NewPS3), ErnieCount)
%% 	end,
	NewPS2;

handle_after_recharge(_Amount, _BadArg) ->
	?ERROR_MSG("[recharge] handle_after_recharge error, amout = ~p, ps = ~p~n", [_Amount, _BadArg]),
	error.


mark_recharge_order(OrderId) ->
	db:update(recharge_order, [{state, ?RECHARGE_DEAL}], [{order_id, OrderId}]).

recharge_add_money(?MNY_T_YUANBAO, Status, Num) ->
	Captical = player:get_yuanbao(Status),
	NewYuanbao = erlang:min(Captical + Num, ?MAX_U32),
	% player:db_save_yuanbao(Status, NewYuanbao),
	lib_log:statis_produce_currency(Status, ?MNY_T_YUANBAO, Num, [?LOG_PAY, "buy"]),
	notify_cli_money_change(Status, ?MNY_T_YUANBAO, NewYuanbao),
	Status#player_status{yuanbao = NewYuanbao};
% player_syn:set_yuanbao(Status, NewValue),
% notify_cli_money_change(Status, ?MNY_T_YUANBAO, NewYuanbao),

recharge_add_money(?MNY_T_BIND_YUANBAO, Status, Num) ->
	Captical = player:get_yuanbao(Status),
	NewYuanbao = erlang:min(Captical + Num, ?MAX_U32),
	lib_log:statis_produce_currency(Status, ?MNY_T_BIND_YUANBAO, Num, [?LOG_PAY, "buy"]),
	% player:db_save_bind_yuanbao(Status, NewYuanbao),
	notify_cli_money_change(Status, ?MNY_T_BIND_YUANBAO, NewYuanbao),
	Status#player_status{bind_yuanbao = NewYuanbao};

recharge_add_money(?MNY_T_GAMEMONEY, Status, Num) ->
	gen_server:cast(player:get_pid(Status), {'recharge_add_gamemoney', ?MNY_T_GAMEMONEY, Num}),
	Status;

recharge_add_money(?MNY_T_BIND_GAMEMONEY, Status, Num) ->
	gen_server:cast(player:get_pid(Status), {'recharge_add_gamemoney', ?MNY_T_BIND_GAMEMONEY, Num}),
	Status;

recharge_add_money(Type, Status, Num) ->
	add_money(Status, Type, Num, [?LOG_GIF, "recharge_add_money"]),
%% 	?ASSERT(false),
	?ERROR_MSG("[recharge] recharge add money error type = ~p, Num =~p~n", [Type, Num]),
	Status.

recharge_feedback_add_money(Status, Num) ->
	Captical = player:get_yuanbao(Status),
	NewYuanbao = erlang:min(Captical + Num, ?MAX_U32),
	% player:db_save_yuanbao(Status, NewYuanbao),
	lib_log:statis_produce_currency(Status, ?MNY_T_YUANBAO, Num, [?LOG_PAY, "gift"]),
	notify_cli_money_change(Status, ?MNY_T_YUANBAO, NewYuanbao),
	db:update(player, [{yuanbao, NewYuanbao}], [{id, player:id(Status)}]),
	Status#player_status{yuanbao = NewYuanbao}.

% save_recharge_money(Status) when is_record(Status, player_status) ->
% 	db:update(player, [{yuanbao, player:get_yuanbao(Status)}, {bind_yuanbao, player:get_bind_yuanbao(Status)}], [{id, player:id(Status)}]);
% save_recharge_money(_) -> ?ASSERT(false), ?ERROR_MSG("[recharge] save_recharge_money error", []).



%% 判断该档次是否首充
is_first_recharge(Status, No) ->
	not lists:keymember(No, 1, Status#player_status.recharge_state).

%% 设置首充标志
set_frist_recharge(Status, No) ->
	Status#player_status{recharge_state = [{No, util:unixtime(), 0} | Status#player_status.recharge_state]}.

%% 设置月卡充值
set_month_card_recharge(Status, #recharge{type = ?MONTH_CARD} = Recharge) ->
	Type = Recharge#recharge.type,
	NowDays = util:get_now_days(),
	MonthCardState = Status#player_status.month_card_state,
	ValidDays = 30,
	NewState =
		case lists:keyfind(Type, 1, MonthCardState) of
			false -> [{Type, NowDays + ValidDays, 0} | MonthCardState];
			{Type, EndDayNum, RewardDays} ->
				ExpireDays =
					case EndDayNum > NowDays of
						?true ->
							EndDayNum + ValidDays;
						?false ->
							NowDays + ValidDays
					end,
				lists:keyreplace(Type, 1, MonthCardState, {Type, ExpireDays, RewardDays})
		end,
	Status#player_status{month_card_state = NewState};

%% 设置终身卡充值
set_month_card_recharge(Status, #recharge{type = ?MONTH_CARD_LIFE} = Recharge) ->
	Type = Recharge#recharge.type,
	NowDays = util:get_now_days(),
	MonthCardState = Status#player_status.month_card_state,
	ValidDays = 9999,
	NewState =
		case lists:keyfind(Type, 1, MonthCardState) of
			false -> [{Type, NowDays + ValidDays, 0} | MonthCardState];
			{Type, EndDayNum, RewardDays} ->
				ExpireDays =
					case EndDayNum > NowDays of
						?true ->
							EndDayNum + ValidDays;
						?false ->
							NowDays + ValidDays
					end,
				lists:keyreplace(Type, 1, MonthCardState, {Type, ExpireDays, RewardDays})
		end,
	Status#player_status{month_card_state = NewState};

%% 设置周卡充值
set_month_card_recharge(Status, #recharge{type = ?MONTH_CARD_WEEK} = Recharge) ->
	Type = Recharge#recharge.type,
	NowDays = util:get_now_days(),
	MonthCardState = Status#player_status.month_card_state,
	ValidDays = 7,
	NewState =
		case lists:keyfind(Type, 1, MonthCardState) of
			false -> [{Type, NowDays + ValidDays, 0} | MonthCardState];
			{Type, EndDayNum, RewardDays} ->
				ExpireDays =
					case EndDayNum > NowDays of
						?true ->
							EndDayNum + ValidDays;
						?false ->
							NowDays + ValidDays
					end,
				lists:keyreplace(Type, 1, MonthCardState, {Type, ExpireDays, RewardDays})
		end,
	Status#player_status{month_card_state = NewState}.




%% @月卡功能
%% ! 玩家进程执行
%% @return : boolean()
use_month_card(Status, Type) when is_record(Status, player_status) -> %% andalso Amount > 0 ->
	try
		[No|_] = case Type of
							 ?MONTH_CARD ->
								 data_recharge:get_month_card_nos();
							 ?MONTH_CARD_LIFE ->
								 data_recharge:get_life_card_nos();
							 ?MONTH_CARD_WEEK ->
								 data_recharge:get_week_card_nos()
						 end, 
		case data_recharge:get_data_by_no(No) of
			Recharge when is_record(Recharge, recharge) ->
				Status2 = set_month_card_recharge(Status, Recharge),
				db:update(player,
					[{month_card_state, util:term_to_bitstring(Status2#player_status.month_card_state)}],
					[{id, player:id(Status2)}]),
				send_first_recharge_reward(Status2),
				notify_recharge_state(Status2),
				% case catch handle_after_recharge(Amount, Status2) of
				% 	AfterPS when is_record(AfterPS, player_status) ->
				% 		player_syn:update_PS_to_ets(AfterPS);
				% 	_ ->
				% 		player_syn:update_PS_to_ets(Status2)
				% end,
				player_syn:update_PS_to_ets(Status2),
				true;
			_ -> ?ASSERT(false), false
		end
	catch
		_T:_E -> ?ERROR_MSG("use_month_card error = ~p~n", [{_T, _E}]), false
	end;
use_month_card(_S, _A) -> ?ASSERT(false, [_S, _A]), false.



%% 查询各档次月卡类活动数据
query_month_card_data(Status) ->
	MonthCardState = Status#player_status.month_card_state,
	DaysNow = util:get_now_days(),
	Fun = fun({Type, ValidDays, RewardDays}, Acc) ->
		{Days, State} =
			case ValidDays > DaysNow of
				?true ->
					State0 =
						case RewardDays of
							DaysNow ->
								1;
							_ ->
								0
						end,
					{ValidDays - DaysNow, State0};
				?false ->
					{0, 0}
			end,
		[{Type, Days, State}|Acc]
				end,
	Datas = lists:foldl(Fun, [], MonthCardState),
	{ok, BinData} = pt_13:write(?PT_PLYR_CHECK_MONTH_CARD, [Datas]),
	lib_send:send_to_uid(player:get_id(Status), BinData),
	ok.


%% 领取月卡类活动奖励
reward_month_card(Status, Type) ->
	RoleId = player:get_id(Status),
	DaysNow = util:get_now_days(),
	case lists:keytake(Type, 1, Status#player_status.month_card_state) of
		{value, {Type, ValidDays, RewardDays}, MonthCardState} ->
			case ValidDays >= DaysNow andalso DaysNow =/= RewardDays of
				?true ->
					[No|_] = case Type of
										 ?MONTH_CARD ->
											 data_recharge:get_month_card_nos();
										 ?MONTH_CARD_LIFE ->
											 data_recharge:get_life_card_nos();
										 ?MONTH_CARD_WEEK ->
											 data_recharge:get_week_card_nos()
									 end,
					Recharge = data_recharge:get_data_by_no(No),
					case mod_inv:check_batch_add_goods(RoleId, Recharge#recharge.first_feekback_num) of
						ok ->
							%% 可以领取
							MonthCardState2 = [{Type, ValidDays, DaysNow}|MonthCardState],
							Status2 = Status#player_status{month_card_state = MonthCardState2},
							db:update(player,
								[{month_card_state, util:term_to_bitstring(Status2#player_status.month_card_state)}],
								[{id, player:id(Status2)}]),
							player_syn:update_PS_to_ets(Status2),
							mod_inv:batch_smart_add_new_goods(RoleId, Recharge#recharge.first_feekback_num),
							{ok, BinData} = pt_13:write(?PT_PLYR_REWARD_MONTH_CARD, [0]),
							lib_send:send_to_uid(RoleId, BinData),
							ok;
						_ ->
							%% 背包满
							{fail, ?PM_US_BAG_FULL}
					end;
				?false ->
					%% 不可领取
					{ok, BinData} = pt_13:write(?PT_PLYR_REWARD_MONTH_CARD, [0]),
					lib_send:send_to_uid(RoleId, BinData),
					ok
			end;
		false ->
			%% 无
			{ok, BinData} = pt_13:write(?PT_PLYR_REWARD_MONTH_CARD, [0]),
			lib_send:send_to_uid(RoleId, BinData),
			ok
	end;

reward_month_card(Status, Type) ->
	ok.


%% 发送首充奖励
send_first_recharge_reward(Status) ->
	gen_server:cast(player:get_pid(Status), 'first_recharge_reward').

%% 通知首充各档次状态
notify_recharge_state(Status) ->
	List = data_recharge:get_normal_card_nos(),
	RechargeState = Status#player_status.recharge_state,
	BitNum = lists:foldl(
		fun(No, Bit) ->
			case lists:keymember(No, 1, RechargeState) of
				true -> (1 bsl (No - 1)) + Bit;
				false -> Bit
			end
		end, 0, List),

	First_Unix = case mod_svr_mgr:get_global_sys_var(?SEND_FIRST_RECHARGE) of
								 null -> 0;
								 _ ->mod_svr_mgr:get_global_sys_var(?SEND_FIRST_RECHARGE)
							 end,


	SendRet = lists:foldl(
		fun(Item,Ret) ->
			case Ret of
				0 ->
					{_No,SendTime,_} = Item,
					case First_Unix > SendTime of
						true -> player_syn:update_PS_to_ets(Status#player_status{recharge_state = []}), Ret + 1;
						false -> Ret
					end;
				_ -> Ret
			end

		end,0,RechargeState),

	RechargeState2 = case SendRet of
										 0 -> RechargeState;
										 _ -> RechargeState3 = Status#player_status{recharge_state = []},RechargeState3#player_status.recharge_state
									 end,


	AlrPayNos = lists:foldl(
		fun(Item,Ret) ->
			{No,_,_} = Item,
			[No | Ret]
		end,[],RechargeState2),

	?DEBUG_MSG("AlrPayNos=~p",[AlrPayNos]),

	MonthCardList = data_recharge:get_month_card_nos(),
	MonthCardState = Status#player_status.month_card_state,
	NowDays = util:get_now_days(),
	MonthCardData = lists:foldl(
		fun(No, Acc) ->
			case lists:keyfind(No, 1, MonthCardState) of
				false -> [{No, 1, 0} | Acc];
				{No, LeftSendDay, FeekbackDay} ->
					case NowDays > FeekbackDay + LeftSendDay of
						true -> [{No, 1, 0} | Acc];
						false ->
							LeftDay = FeekbackDay + LeftSendDay - NowDays + 1,
							case data_recharge:get_data_by_no(No) of
								RechargeData when is_record(RechargeData, recharge) ->
									[{No, ?BIN_PRED(LeftDay > RechargeData#recharge.show_days, 0, 1), LeftDay} | Acc];
								_ -> [{No, 0, LeftDay} | Acc]
							end
					end
			end
		end, [], MonthCardList),
	{ok, BinData} = pt_13:write(13095, [AlrPayNos, MonthCardData]),
	lib_send:send_to_uid(player:id(Status), BinData).


%% 预充值返还
recharge_feedback(Status) ->
	case config:recharge_feekback_switch() of
		false -> skip;
		true -> gen_server:cast(player:get_pid(Status), 'recharge_feedback')
	end.


%% 充值累积活动
%% @return: newPS
get_recharge_accum(Amount, Status) ->
	Now = util:unixtime(),
	RoleId = player:id(Status),
	case mod_svr_mgr:check_recharge_accum_activity_open(Now) of
		{true, Activity} when is_record(Activity, recharge_accum) ->
			#player_status{recharge_accum = RechargeAccum} = refresh_recharge_accum_data(Status),
			RechargeAccum2 = RechargeAccum#r_accum{num = RechargeAccum#r_accum.num + Amount, timestamp = Now},
			Ret = db:update(RoleId, player, [{recharge_accum, util:term_to_bitstring(RechargeAccum2)}], [{id, RoleId}]),
			?INFO_MSG("~n~n~nRet : ~p~n~n", [Ret]),
			%% 通知前端当前进度值
			ActIdValueL = [{3, RechargeAccum2#r_accum.num, RechargeAccum2#r_accum.reward_yet}],
			mod_admin_activity:notify_value_admin_sys_activity(Status, ActIdValueL),
			Status#player_status{recharge_accum = RechargeAccum2};
		_ ->
			Status
	end.


refresh_recharge_accum_data(Status) ->
	Now = util:unixtime(),
	NewRechargeAccum = #r_accum{activity_id = 0,
		num = 0,
		timestamp = Now,
		reward_yet = []},
	case mod_svr_mgr:check_recharge_accum_activity_open(Now) of
		{true, Activity} when is_record(Activity, recharge_accum) ->
			RechargeAccum =
				case Status#player_status.recharge_accum of
					#r_accum{activity_id = ActId,
						timestamp = Timestamp} = RechargeAccum0 ->
						%% 判断时间戳是否符合活动期间内，否则刷新
						case Activity#recharge_accum.id =:= ActId andalso Timestamp > Activity#recharge_accum.start_time andalso Timestamp =< Activity#recharge_accum.end_time of
							true ->
								RechargeAccum0;
							false ->
								NewRechargeAccum
						end;
					_ ->
						NewRechargeAccum
				end,
			Status#player_status{recharge_accum = RechargeAccum#r_accum{activity_id = Activity#recharge_accum.id}};
		_ ->
			case Status#player_status.recharge_accum of
				#r_accum{} ->
					Status#player_status{recharge_accum = NewRechargeAccum};
				_ ->
					Status#player_status{recharge_accum = NewRechargeAccum}
			end
	end.


%% 单笔充值活动, 隔天刷新
%% @return: newPS
get_recharge_one(Amount, NewPS0) ->
	?DEBUG_MSG("player:get_recharge_one:Amount:~p~n", [Amount]),
	#player_status{one_recharge_reward = OneRecharge} = NewPS = refresh_recharge_one(NewPS0),
	Now = util:unixtime(),
	RoleId = player:id(NewPS),
	case mod_svr_mgr:check_recharge_one_activity_open(Now) of
		{true, Activity} when is_record(Activity, recharge_one) ->
%% 			case lists:member(Amount, OneRecharge#r_accum_one.reward_valid) of
%% 				?true ->
%% 					%% 已经充了该笔充值, 可以充值很多次
%% 					NewPS;
%% 				?false ->
			{Title, MailContent, RankList} = Activity#recharge_one.content,
			?DEBUG_MSG("player:get_recharge_one:{Title, MailContent, RankList}:~w~n", [{Title, MailContent, RankList}]),
			case select_recharge_one_reward(Amount, RankList) of
				[] ->
					?DEBUG_MSG("select_recharge_one_reward:~w~n", [{Title, MailContent, RankList}]),
					NewPS;
				SendList ->
					{Num, ValidTimes} =
						case erlang:hd(SendList) of
							{Num0, _} ->
								{Num0, 1};
							{Num0, ValidTimes0, _} ->
								{Num0, ValidTimes0}
						end,
					%% 更新已充值次数
					{RewardValidData, IsNotce, RechargeTimesN, TimesRewardN} =
						case lists:keytake(Num, 1, OneRecharge#r_accum_one.reward_valid) of
							{value, {Num, TimesRecharge, TimesReward}, RewardValid0} ->
								RechargeTimes = erlang:min(TimesRecharge + 1, ValidTimes),
								{[{Num, RechargeTimes, TimesReward}|RewardValid0], RechargeTimes > TimesReward, RechargeTimes, TimesReward};
							?false ->
								{[{Num, 1, 0}|OneRecharge#r_accum_one.reward_valid], ?true, 1, 0}
						end,
					OneRecharge2 = OneRecharge#r_accum_one{reward_valid = RewardValidData},
%% 							OneRecharge2 = OneRecharge#r_accum_one{reward_valid = [Amount|lists:delete(Amount, OneRecharge#r_accum_one.reward_valid)]},
					Ret = db:update(RoleId, player, [{one_recharge_reward, util:term_to_bitstring(OneRecharge2)}], [{id, RoleId}]),
					?INFO_MSG("~n~n~nRet : ~p~n~n", [Ret]),
					%% 通知前端当前进度值, 如果已充值次数大于已领取次数
					ActIdValueL = [{13, Num, [ValidTimes, RechargeTimesN, TimesRewardN]}],
					mod_admin_activity:notify_value_admin_sys_activity(NewPS, ActIdValueL),
					NewPS#player_status{one_recharge_reward = OneRecharge2}
%% 					end
			end;
		_ ->
			?DEBUG_MSG("check_recharge_one_activity_open:finish!~n", []),
			NewPS
	end.

refresh_recharge_one(Status) ->
	Now = util:unixtime(),
	NewRechargeOne = #r_accum_one{activity_id = 0,
		timestamp = Now,
		reward_valid = [],
		reward_yet = []},
	case mod_svr_mgr:check_recharge_one_activity_open(Now) of
		{true, Activity} when is_record(Activity, recharge_one) ->
			RechargeOne =
				case Status#player_status.one_recharge_reward of
					#r_accum_one{activity_id = ActId,
						timestamp = Timestamp} = RechargeOne0 ->
						%% 判断时间戳是否符合活动期间内，否则刷新
						case Activity#recharge_one.id =:= ActId
							andalso Timestamp > Activity#recharge_one.start_time
							andalso Timestamp =< Activity#recharge_one.end_time
							andalso util:is_same_day(Timestamp) of
							true ->
								RechargeOne0;
							false ->
								NewRechargeOne
						end;
					_ ->
						NewRechargeOne
				end,
			Status#player_status{one_recharge_reward = RechargeOne#r_accum_one{activity_id = Activity#recharge_one.id}};
		_ ->
			case Status#player_status.one_recharge_reward of
				#r_accum_one{} ->
					Status;
				_ ->
					Status#player_status{one_recharge_reward = NewRechargeOne}
			end
	end.

%% 每日充值累积活动
%% @return: newPS
get_recharge_accum_day(Amount, Status) ->
	Now = util:unixtime(),
	RoleId = player:id(Status),
	case mod_svr_mgr:check_recharge_accum_day_activity_open(Now) of
		{true, Activity} when is_record(Activity, recharge_accum_day) ->
			#player_status{recharge_accum_day = RechargeDay} = refresh_recharge_accum_day_data(Status),
			RechargeDay2 = RechargeDay#r_accum_day{num = RechargeDay#r_accum_day.num + Amount, timestamp = Now},
			Ret = db:update(RoleId, player, [{recharge_accum_day, util:term_to_bitstring(RechargeDay2)}], [{id, RoleId}]),
			?INFO_MSG("~n~n~nRet : ~p~n~n", [Ret]),
			%% 通知前端当前进度值
			ActIdValueL = [{14, RechargeDay2#r_accum_day.num, RechargeDay2#r_accum_day.reward_yet}],
			mod_admin_activity:notify_value_admin_sys_activity(Status, ActIdValueL),
			Status#player_status{recharge_accum_day = RechargeDay2};
		_ ->
			Status
	end.

refresh_recharge_accum_day_data(Status) ->
	Now = util:unixtime(),
	NewRechargeDay = #r_accum_day{activity_id = 0,
		num = 0,
		timestamp = Now,
		reward_yet = []},
	case mod_svr_mgr:check_recharge_accum_day_activity_open(Now) of
		{true, Activity} when is_record(Activity, recharge_accum_day) ->
			RechargeDay =
				case Status#player_status.recharge_accum_day of
					#r_accum_day{activity_id = ActId,
						timestamp = Timestamp} = RechargeDay0 ->
						%% 判断时间戳是否符合活动期间内，否则刷新
						case Activity#recharge_accum_day.id =:= ActId
							andalso Timestamp > Activity#recharge_accum_day.start_time
							andalso Timestamp =< Activity#recharge_accum_day.end_time
							andalso util:is_same_day(Timestamp) of
							true ->
								RechargeDay0;
							false ->
								NewRechargeDay
						end;
					_ ->
						NewRechargeDay
				end,
			Status#player_status{recharge_accum_day = RechargeDay#r_accum_day{activity_id = Activity#recharge_accum_day.id}};
		_ ->
			case Status#player_status.recharge_accum_day of
				#r_accum_day{} ->
					Status;
				_ ->
					Status#player_status{recharge_accum_day = NewRechargeDay}
			end
	end.


%% 选择要发放的单笔充值奖励 return [{Num, GoodsList}]
select_recharge_one_reward(Num, RankList) ->
	?DEBUG_MSG("player:select_recharge_one_reward:Num:~p, RankList:~w~n", [Num, RankList]),
%% 	NumList = [No || {No, _GoodsList} <- RankList],
	NumList =
		lists:foldl(fun({No, _GoodsList}, Acc) ->
			[No|Acc];
			({No, _ValidTimes, _GoodsList}, Acc) ->
				[No|Acc]
								end, [], RankList),
	RetList = lists:sort(NumList),
	RetList1 = lists:reverse(RetList),
	Index = get_recharge_one_index(RetList1, Num),
	case lists:keyfind(Index, 1, RankList) of
		false -> [];
		{No, GoodsList} -> [{No, GoodsList}];
		{No, ValidTimes, GoodsList} ->
			[{No, ValidTimes, GoodsList}]
	end.


get_recharge_one_index([], _Num) ->
	?INVALID_NO;
get_recharge_one_index([No | T], Num) ->
	case Num >= No of
		true -> No;
		false -> get_recharge_one_index(T, Num)
	end.


select_recharge_rank_list(Min, Max, List) when Min =< Max ->
	select_right_rank(Max, select_left_rank(Min, List));
select_recharge_rank_list(_, _, _) -> [].

select_left_rank(_Min, []) -> [];
select_left_rank(Min, [{Num, _} | Left] = List) ->
	case Min >= Num of
		true -> select_left_rank(Min, Left);
		false -> List
	end.

select_right_rank(_Max, []) -> [];
select_right_rank(Max, [{Num, Elm} | Left]) ->
	case Max >= Num of
		true -> [{Num, Elm} | select_right_rank(Max, Left)];
		false -> []
	end.


send_recharge_accum_reward(_Status, _, _, []) -> skip;
send_recharge_accum_reward(Status, Title, Content, [{_Rank, GoodsList} | Left]) ->
	lib_mail:send_sys_mail(player:id(Status), Title, Content, GoodsList, [?LOG_MAIL, "recv_paybag"]),
	send_recharge_accum_reward(Status, Title, Content, Left);
send_recharge_accum_reward(Status, Title, Content, [{_Rank, _ValidTimes, GoodsList} | Left]) ->
	lib_mail:send_sys_mail(player:id(Status), Title, Content, GoodsList, [?LOG_MAIL, "recv_paybag"]),
	send_recharge_accum_reward(Status, Title, Content, Left).



%% 设置充值累积
%% @return : new num
set_recharge_accum(PS, Num, Timestamp) ->
	case mod_svr_mgr:check_recharge_accum_activity_open(util:unixtime()) of
		{true, Activity} when is_record(Activity, recharge_accum) ->
			case Timestamp > Activity#recharge_accum.start_time andalso Timestamp =< Activity#recharge_accum.end_time of
				true -> Num;
				false -> gen_server:cast(player:get_pid(PS), {'set_recharge_accum', {0, Timestamp, 0}}), 0
			end;
		_ -> gen_server:cast(player:get_pid(PS), {'set_recharge_accum', {0, Timestamp, 0}}), 0
	end.

set_recharge_accum(Status, Num, Timestamp, ActId) ->
	case mod_svr_mgr:check_recharge_accum_activity_open(util:unixtime()) of
		{true, Activity} when is_record(Activity, recharge_accum) ->
			case (Timestamp > Activity#recharge_accum.start_time andalso Timestamp =< Activity#recharge_accum.end_time) andalso
				ActId =:= Activity#recharge_accum.id of
				true -> Num;
				false -> gen_server:cast(player:get_pid(Status), {'set_recharge_accum', {0, Timestamp, 0}}), 0
			end;
		_ -> gen_server:cast(player:get_pid(Status), {'set_recharge_accum', {0, Timestamp, 0}}), 0
	end.

set_recharge_accum_day(Status, Num, Timestamp, ActId) ->
	case mod_svr_mgr:check_recharge_accum_day_activity_open(util:unixtime()) of
		{true, Activity} when is_record(Activity, recharge_accum_day) ->
			case (Timestamp > Activity#recharge_accum_day.start_time andalso Timestamp =< Activity#recharge_accum_day.end_time) andalso
				ActId =:= Activity#recharge_accum_day.id andalso util:is_timestamp_same_day(util:unixtime(), Timestamp) of
				true -> Num;
				false -> gen_server:cast(player:get_pid(Status), {'set_recharge_accum_day', {0, Timestamp, ActId}}), 0
			end;
		_ -> gen_server:cast(player:get_pid(Status), {'set_recharge_accum_day', {0, Timestamp, ActId}}), 0
	end.


find(Key, {obj, List}) ->
	{_, Val} = lists:keyfind(Key, 1, List),
	Val.

%% @doc 检查积分消费活动顺便发送奖励
check_and_send_integral_reward(PS, Count) ->
	%%检查活动是否开启
	case db:select_row(admin_sys_activity, "order_id", [{sys,  20}, {state,1}]) of
		[] ->
			PS;
		[OrderId] ->
			case ets:lookup(ets_admin_sys_activity, OrderId) of
				[] ->
					PS;
				[CostIntegralR] ->
					{Title,Content, RewardList} = CostIntegralR#admin_sys_activity.content,
					ConsumeState = PS#player_status.consume_state,
					case lists:keytake(20, 1, ConsumeState) of
						{value,{_,{LastCount, LastUnixTime}},Plus} ->
							%%发邮件以及累计值
							case LastUnixTime >= CostIntegralR#admin_sys_activity.timestamp andalso  LastUnixTime =< CostIntegralR#admin_sys_activity.end_time of
								true ->
									F =
										fun({LimitValue,RewardGoods}) ->
											case LastCount >= LimitValue of
												true ->
													skip;
												false ->
													case (LastCount + Count) >= LimitValue of
														true ->
															lib_mail:send_sys_mail(player:get_id(PS), Title, Content, RewardGoods, ["log_mail", "cost_integral"]);
														false ->
															skip
													end
											end
										end,
									lists:foreach(F, RewardList),
									mod_admin_activity:notify_value_admin_sys_activity(PS, [{20, LastCount + Count, []}]),
									PS#player_status{consume_state =[ {20, {LastCount + Count,  util:unixtime()}} | Plus]};
								false -> %%清楚掉上次的值重新算
									F =
										fun({LimitValue,RewardGoods}) ->
											case Count >= LimitValue of
												true ->
													lib_mail:send_sys_mail(player:get_id(PS), Title, Content, RewardGoods, ["log_mail", "cost_integral"]);
												false ->
													skip
											end
										end,
									lists:foreach(F, RewardList),
									mod_admin_activity:notify_value_admin_sys_activity(PS, [{20, Count, []}]),
									PS#player_status{consume_state =[ {20, {Count,  util:unixtime()}} | Plus]}
							end;
						false ->
							F =
								fun({LimitValue,RewardGoods}) ->
									case Count >= LimitValue of
										true ->
											lib_mail:send_sys_mail(player:get_id(PS), Title, Content, RewardGoods, ["log_mail", "cost_integral"]);
										false ->
											skip
									end
								end,
							lists:foreach(F, RewardList),
							mod_admin_activity:notify_value_admin_sys_activity(PS, [{20, Count, []}]),
							PS#player_status{consume_state =[ {20, {Count,  util:unixtime()}} | 	PS#player_status.consume_state ]}
					end
			end
	end.

%% @doc 检查消费累积，修改为只增加累计值的修改，不发送邮件奖励
%% @return : new #player_status{}
check_consume_activity(Status, Money, MoneyType) when is_record(Status, player_status) andalso is_atom(MoneyType) andalso Money > 0 ->
	try
		Now = util:unixtime(),
		case query_consume_acitvity_open(transfer_money_type_to_activity(MoneyType), Now) of
			{true, Activity, No} ->
				Status2 = refresh_consume_activity(Status, [MoneyType]),
				NewPS = handle_consume_activity(Status2, Money, No, Activity, Now),
				NewPS;
			_ -> Status
		end
	catch
		Err:Reason ->
			?ERROR_MSG("{Err,Reason,erlang:get_stacktrace()} : ~p~n", [{Err,Reason,erlang:get_stacktrace()}]),
			Status
	end;
check_consume_activity(_T, _, _) -> _T.


refresh_consume_activity(Status) ->
	Types = [gamemoney, yuanbao],
	refresh_consume_activity(Status, Types).

refresh_consume_activity(Status, []) ->
	Status;

refresh_consume_activity(Status, [MoneyType|L]) ->
	Now = util:unixtime(),
	Status2 =
		case query_consume_acitvity_open(transfer_money_type_to_activity(MoneyType), Now) of
			{true, Activity, No} ->
				case lists:keytake(No, #r_consume.type, Status#player_status.consume_state) of
					{value, #r_consume{timestamp = OldTime}, ConsumeState} ->
						%% 这里判断是否符合活动时间
						case Activity#consume_activity.start_time =< OldTime andalso Activity#consume_activity.end_time >= OldTime of
							true -> Status;
							false -> Status#player_status{consume_state = ConsumeState}
						end;
					false ->
						Status
				end;
			_ ->
				case lists:keytake(MoneyType, #r_consume.type, Status#player_status.consume_state) of
					{value, _Old, ConsumeState} ->
						Status#player_status{consume_state = ConsumeState};
					false ->
						Status
				end
		end,
	refresh_consume_activity(Status2, L).

%% @return : new #player_status{}
handle_consume_activity(Status, Money, No, Activity, Timestamp) ->
	ConsumeState = Status#player_status.consume_state,
	{ConsumeState3, Value, RewardYet} =
		case lists:keytake(No, #r_consume.type, ConsumeState) of
			{value, #r_consume{num = Num} = Rconsume, ConsumeState2} ->
				%% 这里不做重置处理，直接累加值并通知前端即可
				Num2 = Num + Money,
				Rconsume2 = Rconsume#r_consume{num = Num2, timestamp = Timestamp},
				{[Rconsume2|ConsumeState2], Num2, Rconsume2#r_consume.reward_yet};
			false ->
				Rconsume = #r_consume{type = No, num = Money, timestamp = Timestamp},
				{[Rconsume|ConsumeState], Money, Rconsume#r_consume.reward_yet}
		end,
	Status2 = Status#player_status{consume_state = ConsumeState3},
	ActIdValueL = [{No, Value, RewardYet}],
	mod_admin_activity:notify_value_admin_sys_activity(Status2, ActIdValueL),
	Status2.


%% @doc 充值反馈是否开启
is_first_rechargeactivity_open() -> true.


%% @return : false | {true, #consume_activity{}, No::integer()}
query_consume_acitvity_open([], _) -> false;
query_consume_acitvity_open([No | Left], Now) ->
	case mod_svr_mgr:check_consume_activity_open(No, Now) of
		{true, Activity} when is_record(Activity, consume_activity) -> {true, Activity, No};
		false -> query_consume_acitvity_open(Left, Now)
	end.

transfer_money_type_to_activity(MoneyType) ->
	case MoneyType of
		gamemoney -> [7, 6];
		bind_gamemoney -> [7];
		yuanbao -> [9, 8];
		bind_yuanbao -> [9];
		integral -> [20]
	end.

% transfer_actno_to_money_type(No) ->
% 	case No of
% 		6 -> gamemoney;
% 		7 -> bind_gamemoney;
% 		8 -> yuanbao;
% 		9 -> bind_yuanbao
% 	end.


%% @doc 解析充值json数据
%% @return:false | {true, parseData}
parse_web_recharge_data(Json) ->
	try
		?LDS_DEBUG(parse_web_recharge_data, Json),
		{ok, Obj1, _} = rfc4627:decode(Json),
		Cont = find("content", Obj1),
		Title = find("title", Obj1),
		Json2 = find("attach", Obj1),
		{ok, [Objs2], _} = rfc4627:decode(Json2),
		F = fun(Key, Obj) -> util:bitstring_to_term(find(Key, Obj)) end,
		Gifts = lists:sort([{F("rank", Ob), F("attach", Ob)} || Ob <- Objs2]),
		?DEBUG_MSG("player:parse_web_recharge_data: return:~w~n", [{Title, Cont, Gifts}]),
		{true, {Title, Cont, Gifts}}
	catch
		_:_ -> false
	end.




%% @doc 解析充值json数据, 做个有效次数兼容处理，在人物身上记录某档次已领次数2018.2.6 by zhengjy 
%% @return:false | {true, parseData}
parse_web_recharge_data2(Json) ->
	try
		?LDS_DEBUG(parse_web_recharge_data, Json),
		{ok, Obj1, _} = rfc4627:decode(Json),
		Cont = find("content", Obj1),
		Title = find("title", Obj1),
		Json2 = find("attach", Obj1),
		{ok, [Objs2], _} = rfc4627:decode(Json2),
		F = fun
%% 			   ("valid", {obj, List}) ->
%% 					%% 兼容一下valid字段，如果没有就取1?
%% 					ValidVal = 
%% 						case lists:keyfind("valid", 1, List) of
%% 							{_, Valid} ->
%% 								Valid;
%% 							false ->
%% 								1
%% 						end,
%% 					util:bitstring_to_term(ValidVal);
					(Key, Obj) ->
						util:bitstring_to_term(find(Key, Obj))
				end,
		Gifts = lists:sort([{F("rank", Ob), F("valid", Ob), F("attach", Ob)} || Ob <- Objs2]),
		?DEBUG_MSG("player:parse_web_recharge_data: return:~w~n", [{Title, Cont, Gifts}]),
		{true, {Title, Cont, Gifts}}
	catch
		_:_ -> false
	end.

%% @doc 解析限时转盘数据
%% @return:false | {true, parseData}
parse_lotto_data(Json) ->
	try
		?LDS_DEBUG(parse_lotto_data, Json),
		{ok, Obj1, _} = rfc4627:decode(Json),
		Cont = find("content", Obj1),
		Title = find("title", Obj1),
		Json2 = find("attach", Obj1),
		{ok, [Objs2], _} = rfc4627:decode(Json2),
		F = fun(Key, Obj) -> util:bitstring_to_term(find(Key, Obj)) end,
		Gifts = lists:sort([{F("rank", Ob), F("attach", Ob), F("integral", Ob)} || Ob <- Objs2]),
		?DEBUG_MSG("player:parse_web_recharge_data: return:~w~n", [{Title, Cont, Gifts}]),
		{true, {Title, Cont, Gifts}}
	catch
		_:_ -> false
	end.




%% @doc 查询累积活动的累积额度
%% @return : integer()
query_accum_activity_amount(Status, 3) ->
	case Status#player_status.recharge_accum of
		{Num, Timestamp} when Num > 0 -> player:set_recharge_accum(Status, Num, Timestamp);
		{Num, Timestamp, ActId} when Num > 0 -> player:set_recharge_accum(Status, Num, Timestamp, ActId);
		_ -> 0
	end;

%% @doc 查询每日累积活动的累积额度
%% @return : integer()
query_accum_activity_amount(Status, 14) ->
	case Status#player_status.recharge_accum_day of
		{Num, Timestamp, ActId} when Num > 0 -> player:set_recharge_accum_day(Status, Num, Timestamp, ActId);
		_ -> 0
	end;

% case Num > 0 of
%     false -> 0;
%     true -> player:set_recharge_accum(Status, Num, Timestamp)
% end;
query_accum_activity_amount(Status, Type) when Type >= 6 andalso Type =< 9 ->
	% MoneyType = transfer_actno_to_money_type(Type),
	case lists:keyfind(Type, 1, Status#player_status.consume_state) of
		{Type, {Num, Timestamp}} ->
			Now = util:unixtime(),
			case mod_svr_mgr:check_consume_activity_open(Type, Now) of
				{true, Activity} when is_record(Activity, consume_activity) ->
					case Activity#consume_activity.start_time =< Timestamp andalso Activity#consume_activity.end_time >= Timestamp of
						true -> Num;
						false -> clear_consume_accum(Status, Type), 0
					end;
				_ -> clear_consume_accum(Status, Type), 0
			end;
		{Type, {Num, Timestamp}, ActST} ->
			Now = util:unixtime(),
			case mod_svr_mgr:check_consume_activity_open(Type, Now) of
				{true, Activity} when is_record(Activity, consume_activity) ->
					case (Activity#consume_activity.start_time =< Timestamp andalso Activity#consume_activity.end_time >= Timestamp) andalso
						ActST =:= Activity#consume_activity.start_time of
						true -> Num;
						false -> clear_consume_accum(Status, Type), 0
					end;
				_ -> clear_consume_accum(Status, Type), 0
			end;
		_ -> 0
	end;
query_accum_activity_amount(_, _) -> 0.


clear_consume_accum(Status, Type) ->
	gen_server:cast(player:get_pid(Status), {'clear_consume_accum', Type}).


%% 更新累计充值金额
add_recharge_sum(PlayerId, Amount) ->
	Key = recharge_sum,
	case lib_player_ext:try_load_data(PlayerId, Key) of
		{ok, RechargeSum} ->
			Value = RechargeSum + Amount,
			lib_player_ext:try_update_data(PlayerId, Key, Value),
			Value;
		E ->
			?ERROR_MSG("Error : ~p~n", [E]),
			0
	end.


%% 通知前端累计充值金额
notify_recharge_sum(PS) ->
	Key = recharge_sum,
	case lib_player_ext:try_load_data(PS, Key) of
		{ok, RechargeSum} ->
			notify_recharge_sum(PS, RechargeSum);
		_ ->
			ok
	end.

notify_recharge_sum(PS, RechargeSum) ->
	{ok, BinData} = pt_13:write(?PT_RECHARGE_SUM, [RechargeSum]),
	lib_send:send_to_sock(PS, BinData).

give_first_recharge_reward(PlayerId) when is_integer(PlayerId) ->
	PS = get_PS(PlayerId),
	give_first_recharge_reward(PS);

give_first_recharge_reward(PS) ->
	case PS#player_status.first_recharge_reward_state of
		0 -> lib_send:send_prompt_msg(PS, ?PM_RECHARGE_NOT_RECHARGE);
		1 ->
			Rid = data_recharge:get_first_recharge_reward(),
			case lib_reward:check_bag_space(PS, Rid) of
				{fail, Reason} -> lib_send:send_prompt_msg(PS, Reason);
				ok ->
					db:update(player:id(PS), player, [{first_recharge_reward_state, 2}], [{id, player:id(PS)}]),
					player_syn:update_PS_to_ets(PS#player_status{first_recharge_reward_state = 2}),
					catch lib_reward:give_reward_to_player(PS, Rid, [?LOG_PAY, "firstpay_bag"]),
					{ok, BinData} = pt_13:write(?PT_PLYR_RECHARGE_REWARD, [0]),
					lib_send:send_to_uid(player:id(PS), BinData),
					{ok, BinData2} = pt_13:write(?PT_PLYR_RECHARGE_REWARD_STATE, [2]),
					lib_send:send_to_uid(player:id(PS), BinData2)
			end;
		_ -> lib_send:send_prompt_msg(PS, ?PM_HAVE_GET_THE_REWARD)
	end.



%% 更新首冲数据
update_first_recharge(#player_status{first_recharge_reward = FirstRechargeReward} = PS, Money) ->
	case lists:keymember(Money, 1, FirstRechargeReward) of
		?false ->
			%% 2019/7/22 去除首充礼包限制条件（不需要匹配）
%%			case find_first_recharge_reward_data(Money, 1) of
%%				{ok, _RewardNo} ->
			FirstRechargeList = data_recharge:get_first_recharge_price(),
			F = fun(X, FirstRecharge) ->
				case (not lists:keymember(X, 1, FirstRecharge)) andalso (X =< Money) of
					?false ->
						FirstRecharge;
					?true ->
						[{X, 0, 0}|FirstRecharge]
				end
					end,
			FirstRechargeReward2 = lists:foldl(F, FirstRechargeReward, FirstRechargeList),
			PS#player_status{first_recharge_reward = FirstRechargeReward2};
%%				_ ->%% 找不到配置？跳过
%%					PS
%%			end;
		?true ->
			%% 已充值，忽略
			PS
	end.

notice_first_recharge(PS) ->
	RewardList = PS#player_status.first_recharge_reward,
	{ok, BinData} = pt_13:write(?PT_FIRST_RECHARGE_REWARD_ALREADY, [RewardList]),
	lib_send:send_to_sock(PS, BinData).

%% 首充次充三充礼包
%% @return ok | {fail, ReasonCode}
first_recharge_reward(#player_status{first_recharge_reward = FirstRechargeReward} = PS, Money) ->
	case case lists:keytake(Money, 1, FirstRechargeReward) of
				 {value, {Money, Days, UnixTime}, FirstRechargeReward2} ->
					 case util:is_same_day(UnixTime) of
						 ?true ->% 今天已领过了
							 false;
						 ?false ->
							 {true, Days + 1, FirstRechargeReward2}
					 end;
				 false ->%% 没充值
					 false
			 end of
		{true, DaysNext, FirstRechargeReward3} ->
			case find_first_recharge_reward_data(Money, DaysNext) of
				{ok, RewardNo} ->
					case lib_reward:check_bag_space(PS, RewardNo) of
						ok ->
							lib_reward:give_reward_to_player(PS, RewardNo, [?LOG_AD, "first_recharge_reward"]),
							FirstRechargeReward4 = [{Money, DaysNext, util:unixtime()}|FirstRechargeReward3],
							PS2 = PS#player_status{first_recharge_reward = FirstRechargeReward4},
							player_syn:update_PS_to_ets(PS2),
							ok;
						{fail, Reason} ->
							{fail, Reason}
					end;
%% 					Datapkg = data_reward_pkg:get(RewardNo),
%% 					GoodsList = Datapkg#reward_pkg.goods_list,
%% 					F = fun({_Q, GoodsNo, Count, _Z , _B}, Acc) ->
%% 								[{GoodsNo,Count}|Acc];
%% 						   ({_Q, GoodsNo, Count, _Z , _B,_S}, Acc) ->
%% 								[{GoodsNo,Count}|Acc]
%% 						end,	
%% 					GoodsList2 = lists:foldl(F, [], GoodsList),
%% 					PlayerId = player:id(PS),
%% 					
%% 					case mod_inv:check_batch_add_goods(PlayerId, GoodsList2) of
%% 						{fail, _Reason} ->
%% 							{fail, ?PM_US_BAG_FULL};
%% 						ok ->
%% 							mod_inv:batch_smart_add_new_goods(PlayerId, GoodsList2, [{bind_state, ?BIND_ALREADY}], [?LOG_PAY, "first_recharge_reward"]),
%% 							FirstRechargeReward4 = [{Money, DaysNext, util:unixtime()}|FirstRechargeReward3],
%% 							PS2 = PS#player_status{first_recharge_reward = FirstRechargeReward4},
%% 							player_syn:update_PS_to_ets(PS2),
%% 							ok
%% 					end;
				_ ->%% 找不到配置？
					{fail, ?PM_DATA_CONFIG_ERROR}
			end;
		false ->%% 领过了，不能领，正常情况下不会出现的情况
			{fail, ?PM_RECHARGE_FIRST_REWARD_ALREADY}
	end.

find_first_recharge_reward_data(Money, Days) ->
	Nos = data_recharge:get_first_recharge_reward_nos(),
	find_first_recharge_reward_data(Money, Days, Nos).

find_first_recharge_reward_data(Money, Days, [No|List]) ->
	case data_recharge:get_first_recharge_reward(No) of
		#first_recharge_reward{money = Money, day = Days, reward_no = RewardNo} ->
			{ok, RewardNo};
		_ ->
			find_first_recharge_reward_data(Money, Days, List)
	end;
	
find_first_recharge_reward_data(_Money, _Days, []) ->
	false.




%% 领取连续登录赠送代金券
login_reward_day(PS) ->
	Unixtime = util:unixtime(),
	case util:is_same_day(PS#player_status.login_reward_time) of
		?false ->% 可领
			Days = PS#player_status.login_reward_day + 1,
			RewardCfg =
				case data_cumulative_login_reward:get(Days) of
					#data_cumulative_login_reward{} = Cfg ->
						Cfg;
					_ ->
						data_cumulative_login_reward:get(1)
				end,
			GoodsList = RewardCfg#data_cumulative_login_reward.goods_no,
			F = fun({GoodsNo, Count}, Acc) ->
				[{GoodsNo,Count}|Acc];
				({GoodsNo, Count, _B}, Acc) ->
					[{GoodsNo,Count}|Acc]
					end,
			GoodsList2 = lists:foldl(F, [], GoodsList),
			PlayerId = player:id(PS),

			case mod_inv:check_batch_add_goods(PlayerId, GoodsList2) of
				{fail, _Reason} ->
					{fail, ?PM_US_BAG_FULL};
				ok ->
					mod_inv:batch_smart_add_new_goods(PlayerId, GoodsList2, [{bind_state, ?BIND_ALREADY}], [?LOG_PAY, "first_recharge_reward"]),
					PS2 = PS#player_status{login_reward_day = Days, login_reward_time = Unixtime},
					player_syn:update_PS_to_ets(PS2),
					{ok, PS2}
			end;
		?true ->% 今天领过了
			{fail, ?PM_RECHARGE_FIRST_REWARD_ALREADY}
	end.

%获取无线资源页面的数据
get_unlimited_data(PS) ->
	UnlimitedResources = PS#player_status.unlimited_resources,
	% 首充送无限银币
	AccAmount = round(PS#player_status.yuanbao_acc / recharge_ratio()),
	UnlimitedResources1 = case AccAmount > 0 andalso (not lists:member(1, UnlimitedResources)) of
													true ->
														player_syn:update_PS_to_ets(PS#player_status{unlimited_resources = [1|UnlimitedResources]}),
														[1|UnlimitedResources];
													false -> UnlimitedResources
												end,
	% 累积充值100送无限金币
	UnlimitedResources2 = case AccAmount >= data_special_config:get('unlimit_jinbi_price') andalso (not lists:member(9, UnlimitedResources1)) of
													true ->
														player_syn:update_PS_to_ets(PS#player_status{unlimited_resources = [9|UnlimitedResources1]}),
														[9|UnlimitedResources1];
													false -> UnlimitedResources1
												end,
	{ok, BinData} =pt_13:write(?PT_INFINITE_RESOURCES, [UnlimitedResources2]),
	lib_send:send_to_sock(PS, BinData).


buy_unlimited_resource(PS, Type, Value) ->
	case Value of
		2 ->
			{_,Count} = case Type of
										2 ->
											data_special_config:get('unlimit_shuiyu_price');
										_ ->
											data_special_config:get('unlimit_xiulian_price')
									end,
			case player:has_enough_integral(PS, Count)  of
				true ->
					UnlimitedResources = PS#player_status.unlimited_resources,
					case  lists:member(Type,UnlimitedResources) of
						true ->
							lib_send:send_prompt_msg(player:get_id(PS), ?PM_SINGLE_BUY_MAX_LIMIT);
						false ->
							case (not lists:member(Type, [1,2,9])) andalso (lists:member(element(4,data_special_config:get('unlimit_money_type')),UnlimitedResources) orelse
								lists:member(element(5,data_special_config:get('unlimit_money_type')),UnlimitedResources) orelse
								lists:member(element(6,data_special_config:get('unlimit_money_type')),UnlimitedResources)) of
								true ->
									lib_send:send_prompt_msg(player:get_id(PS), ?PM_SINGLE_BUY_MAX_LIMIT);
								false ->
									player:cost_integral(PS, Count, ["player", "bug_unlimited_resource"]),
									NewPS = PS#player_status{unlimited_resources = [Type|UnlimitedResources]},
									player_syn:update_PS_to_ets(NewPS),
									get_unlimited_data(NewPS)
							end
					end;
				false -> lib_send:send_prompt_msg(player:get_id(PS), ?PM_INTEGRAL_LIMIT)
			end;
		3 ->
			%	类型(银币为1,2水玉 ，金币为9,武勋为5,侠义为11)
			Max = 4294967295,
			UnlimitedResources = PS#player_status.unlimited_resources,
			case  lists:member(Type,UnlimitedResources) of
				true ->
					case Type of
						1 ->
							OldValue = player:get_gamemoney(PS),
							if
								OldValue >= Max ->
									lib_send:send_prompt_msg(player:get_id(PS), ?PM_GET_LIMIT_RESOURCE);
								OldValue < Max ->
									Diff = Max - OldValue,
									player:add_gamemoney(PS, Diff, ["unlimited_resource"]);
								true ->
									skip
							end;
						2 ->
							OldValue = player:get_yuanbao(PS),
							if
								OldValue >= Max ->
									lib_send:send_prompt_msg(player:get_id(PS), ?PM_GET_LIMIT_RESOURCE);
								OldValue < Max ->
									Diff = Max - OldValue,
									player:add_yuanbao(PS, Diff, ["unlimited_resource"]);
								true ->
									skip
							end;
						9 ->
							OldValue = player:get_copper(PS),
							if
								OldValue >= Max ->
									lib_send:send_prompt_msg(player:get_id(PS), ?PM_GET_LIMIT_RESOURCE);
								OldValue < Max ->
									Diff = Max - OldValue,
									player:add_copper(PS, Diff, ["unlimited_resource"]);
								true ->
									skip
							end;
						_ ->
							GoodsCount = 99999,
							PlayerId = player:get_id(PS),
							case mod_inv:check_batch_add_goods(PlayerId, [{Type,GoodsCount}]) of
								{fail, _Reason} ->
									lib_send:send_prompt_msg(PlayerId, ?PM_US_BAG_FULL);
								_ ->
									mod_inv:batch_smart_add_new_goods(PlayerId, [{Type,GoodsCount}], [{bind_state, 1}], ["player", "unlimited_resource"])
							end

					end;
				false ->
					lib_send:send_prompt_msg(player:get_id(PS), ?PM_PRIVILEGE_LIMIT)
			end


	end.



%% 创号奖励查询|领取
create_role_reward(PS, 0) ->
	PlayerId = id(PS),
	PlayerMisc = ply_misc:get_player_misc(PlayerId),
	State = PlayerMisc#player_misc.create_role_reward,
	{ok, State};

create_role_reward(PS, 1) ->
	PlayerId = id(PS),
	PlayerMisc = ply_misc:get_player_misc(PlayerId),
	case PlayerMisc#player_misc.create_role_reward of
		0 ->
			case data_special_config:get(create_role_reward) of
				RewardId when is_integer(RewardId) ->
					lib_reward:give_reward_to_player(PS, RewardId, [?LOG_PAY, "create_role_reward"]),
					PlayerMisc2 = PlayerMisc#player_misc{create_role_reward = 1},
					ply_misc:update_player_misc(PlayerMisc2),
					ply_misc:db_save_player_misc(PlayerId),
					{ok, 1};
				_ ->
					{fail, ?PM_DATA_CONFIG_ERROR}
			end;
		1 -> 
			%% 已领取
			{fail, ?PM_CLI_MSG_ILLEGAL}
	end.



%% 领取常驻累充奖励
recharge_accumulated(PS, Money) ->
	PlayerId = id(PS),
	PlayerMisc = ply_misc:get_player_misc(PlayerId),
	case get_recharge_accumulated_data(Money) of
		[] ->
			skip;
		Configs ->
			Fun = fun(#recharge_accumulated{need_recharge = MoneyConfig, reward_no = RewardNo}, PlayerMiscAcc) ->
						  case lists:member(MoneyConfig, PlayerMiscAcc#player_misc.recharge_accumulated) of
							  ?true ->
								  %% 已领取
								  PlayerMiscAcc;
							  ?false ->
								  %% 发邮件给奖励
								  Datapkg = data_reward_pkg:get(RewardNo),
								  F = fun({_Q, GoodsNo, Count, _Z , _B,_S}, Acc) ->
											  [{GoodsNo,Count}|Acc]
									  end,	
								  GoodsList = lists:foldl(F, [], Datapkg#reward_pkg.goods_list),
								  Title = <<"累计充值奖励">>,
								  Content = list_to_binary(io_lib:format(<<"您的累计充值已达到~p元，感谢您的大力支持，以下为您奉上的累充奖励，请注意查收！">>, [MoneyConfig])),
								  lib_mail:send_sys_mail(PlayerId, Title, Content, GoodsList , [?LOG_PAY, "recharge_accumulated"]),
								  RechargeAccumulated = [MoneyConfig|PlayerMiscAcc#player_misc.recharge_accumulated],
								  PlayerMiscAcc#player_misc{recharge_accumulated = RechargeAccumulated}
						  end
				  end,
			PlayerMisc2 = lists:foldl(Fun, PlayerMisc, Configs),
			ply_misc:update_player_misc(PlayerMisc2)
	end.


 
%% 因为是自动发放，这里按区间来取
get_recharge_accumulated_data(Money) ->
	Nos = data_recharge_accumulated:get_all_no_list(),
	get_recharge_accumulated_data(lists:reverse(Nos), Money, []).

get_recharge_accumulated_data([No|Nos], Money, Acc) ->
	case data_recharge_accumulated:get(No) of
		#recharge_accumulated{need_recharge = MoneyConfig} = Config when Money >= MoneyConfig  ->
			get_recharge_accumulated_data(Nos, Money, [Config|Acc]);
		_ ->
			get_recharge_accumulated_data(Nos, Money, Acc)
	end;

get_recharge_accumulated_data([], _Moeny, Acc) ->
	Acc.


%% ==================================== Local Functions =================================


%% 被禁言的截止时间
% get_chat_banned_end_time(PS) ->
% 	PS#player_status.chat_banned_end_time.






% %% 进入战斗初始化
% %% 参数：Cur_bid - 当前的战斗进程Pid
% enter_battle(Status, Cur_bid) ->
% 	Status#player_status{cur_state = ?PS_BATTLING, cur_battle_pid = Cur_bid}.





% %% desc: 修改玩家称号
% change_title(PS, Flag, Title) ->
% 	?TRACE("change_title, flag:~p, title:~p ~n", [Flag, Title]),
% 	case Flag =:= 0 of
% 		true ->
% 			% 删除称号
% 			db:update(player, ["current_title"], [0], "id", PS#player_status.id),
% 			NewPS = PS#player_status{current_title = 0},
% 			mod_player:save_online(NewPS),
% 			lib_scene:notify_title_chg(PS, 0),
% 			{?RES_OK, NewPS};
% 		false ->
% 			% 修改称号
% 			db:update(player, ["current_title"], [Title], "id", PS#player_status.id),
% 			NewPS = PS#player_status{current_title = Title},
% 			mod_player:save_online(NewPS),
% 			lib_scene:notify_title_chg(NewPS, 1),
% 			{?RES_OK, NewPS}
% 	end.









% %% exports
% %% desc: buff打怪经验可以加成
% extra_buff_exp(_PS, _Exp) ->
%     %%%%trunc(Exp * ( PS#player_status.buff_exp ) / 100) + extra_activity_exp(PS, Exp).
%     0.

% %% exports
% %% desc: 活动期经验加成
% extra_activity_exp(_PS, _Exp) ->
%     % case mod_p2_activity:handle_check_festival_expmul(PS) andalso not lib_player:is_in_team(PS) of
%     %     true ->
%     %         trunc(Exp * (data_chaos:get_nation_festival_mul() - 1));
%     %     false ->
%     %         0
%     % end.
%     0.






% %% desc: 游戏升级触发其他系统
% trigger_game_func(PS) ->
%     % 成长礼包提示
%     mod_gift:grow_up_gift_prompt(PS),
%     % 送元宝提示
%     mod_activity:upg_lv_prompt(PS),
%     % 增加一条通缉令日志
%     mod_wanted:add_init_wanted_log(PS),
%     % 增加活动日志
%     lib_activity:add_activity_record(PS),
%     % 检测玩家是否有可以升级/学习的奇术
%     pp_magic:handle(37004, PS, []).


% %% 获取玩家的总战斗力（玩家战斗力 + 各个参战武将的战斗力）
% %% 注： 暂时只支持获取在线玩家的总战斗力（因为获取武将时调用的是get_alive_partner()接口）！
% get_total_battle_capacity(PS) ->
% 	% BattlerList = PS#player_status.battler_list,
% 	% F = fun({BoType, Id, _Pos}, AccValue) ->
% 	% 		case BoType of
% 	% 			?BO_PLAYER ->
% 	% 				AccValue + PS#player_status.battle_capacity;
% 	% 			?BO_PARTNER ->
% 	% 				case lib_partner:get_alive_partner(Id) of
% 	% 					null ->
% 	% 						?ASSERT(false, Id),
% 	% 						AccValue;
% 	% 					Partner ->
% 	% 						AccValue + Partner#ets_partner.battle_capacity
% 	% 				end
% 	% 		end
% 	% 	end,
% 	% TotalBattleCapacity = lists:foldl(F, 0, BattlerList),
% 	% TotalBattleCapacity.

% 	todo_here.





% %% 玩家上线设置预约状态
% init_booking(Status) ->
% 	case db:select_row(booking, "accid", [{accid, Status#player_status.accid}]) of
% 		[] -> Status#player_status{booking = 0};
% 		_ -> Status#player_status{booking = 1}
% 	end.



% %%获得物品/经验/货币/武将显示
% display_gain_item(_Status, _Type, Num) when Num == 0 ->
% 	skip;
% display_gain_item(Status, Type, Num) when is_record(Status, player_status) ->
% 	{ok, BinData} = pt_13:write(13080, [Type, Num, 0]),
% 	lib_send:send_one(Status, BinData);
% display_gain_item(PlayerId, Type, Num) when is_integer(PlayerId) ->
% 	{ok, BinData} = pt_13:write(13080, [Type, Num, 0]),
% 	lib_send:send_to_uid(PlayerId, BinData);
% display_gain_item(_Other, _Type, _Num) ->
% 	skip.

% display_gain_item(_Status, _Type, Num, _Id) when Num == 0 ->
% 	skip;
% display_gain_item(Status, Type, Num, Id) when is_record(Status, player_status) ->
% 	{ok, BinData} = pt_13:write(13080, [Type, Num, Id]),
% 	lib_send:send_one(Status, BinData);
% display_gain_item(PlayerId, Type, Num, Id) when is_integer(PlayerId) ->
% 	{ok, BinData} = pt_13:write(13080, [Type, Num, Id]),
% 	lib_send:send_to_uid(PlayerId, BinData);
% display_gain_item(_Other, _Type, _Num, _Id) ->
% 	skip.

