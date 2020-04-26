%%%-----------------------------------
%%% @Module  : lib_bt_send
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2013.7.30
%%% @Description: 战斗系统中的发送功能（和客户端通信）
%%%-----------------------------------
-module(lib_bt_send).
-export([
		notify_battle_start/0,
		notify_battle_finish/1,

		notify_battle_field_desc_to/2,
		notify_buff_info_to/2,
		
		notify_bo_is_ready/1,
		notify_bo_show_battle_report_done/1,
		notify_bo_online_flag_changed/2,

		notify_round_action_begin/0,
		notify_round_action_end/0,
		notify_new_round_begin/1,
		notify_battle_finish/2,

		notify_settle_buff_begin/0,
		notify_settle_buff_end/0,

		notify_on_new_round_begin_jobs_done/0,

		send_battle_report/2,
		send_br_to_escaped_player_bo/2,

		resp_prepare_cmd_NOP_ok/2,
		resp_prepare_cmd_NOP_fail/2,

		resp_prepare_cmd_normal_att_ok/2,
		resp_prepare_cmd_normal_att_fail/2,

		resp_prepare_cmd_use_skill_ok/2,
		resp_prepare_cmd_use_skill_fail/2,

		resp_prepare_cmd_use_goods_ok/2,
		resp_prepare_cmd_use_goods_fail/2,

		resp_prepare_cmd_protect_others_ok/2,
		resp_prepare_cmd_protect_others_fail/2,

		resp_prepare_cmd_escape_ok/2,
		resp_prepare_cmd_escape_fail/2,

		resp_prepare_cmd_defend_ok/2,
		resp_prepare_cmd_defend_fail/2,

		resp_prepare_cmd_summon_partner_ok/2,
		resp_prepare_cmd_summon_partner_fail/2,

		resp_prepare_cmd_by_AI_ok/2,
		resp_prepare_cmd_by_AI_fail/2,

		resp_request_auto_battle_ok/1,
		resp_cancel_auto_battle_ok/1,

		notify_bo_buff_added/2,
		notify_bo_buff_removed/2,

		notify_bo_attr_changed_to_all/2,
		notify_bo_died_to_all/2,
		notify_bo_revive_to_all/1,

		notify_bo_capture_to_all/3,

		notify_skill_usable_info_to_bo/3,

		notify_bo_info_to_back_to_battle_bo/2,

		notify_cli_not_need_back_to_battle/1,

		notify_all_bo_cur_round_talk_AI/0,

		notify_next_bmon_group_spawned/4,

		notify_cli_new_bo_spawned/1,

		resp_query_battle_start_time_ok/2,
		resp_query_battle_start_time_fail/1,

		resp_prepare_cmd_capture_ok/2,
		resp_prepare_cmd_capture_fail/2,

		send_to_client/2
        
    ]).



-import(lib_bt_comm, [
			get_battle_state/0,
			get_bo_by_id/1

	]).


-include("common.hrl").
-include("battle.hrl").
-include("record/battle_record.hrl").
-include("pt_20.hrl").
-include("buff.hrl").
-include("battle_AI.hrl").




%% 通知战斗开始
notify_battle_start() ->
	{ok, BinData} = pt_20:write(?PT_BT_NOTIFY_BATTLE_START, dummy),
	send_to_all(BinData).	


%% 通知战斗结束
notify_battle_finish(WinSide) ->
	?TRACE("notify_battle_finish(), WinSide=~p~n", [WinSide]),
	{ok, BinData} = pt_20:write(?PT_BT_NOTIFY_BATTLE_FINISH, WinSide),
	send_to_all(BinData).

%% 通知战斗结束
notify_battle_finish(WinSide,world) ->
	?TRACE("notify_battle_finish(), WinSide=~p~n", [WinSide]),
	{ok, BinData} = pt_20:write(?PT_BT_NOTIFY_BATTLE_FINISH, WinSide),
	send_to_all_world(BinData).

	

%% 通知战场描述信息给玩家
notify_battle_field_desc_to(Bo, BattleFieldDesc_Bin) ->
	{ok, BinData} = pt_20:write(?PT_BT_QRY_BATTLE_FIELD_DESC, BattleFieldDesc_Bin),
	% ?TRACE("notify_battle_field_desc_to(),  PlayerId=~p, BattleFieldDesc_Bin=~p~n", [lib_bo:get_parent_obj_id(Bo), BattleFieldDesc_Bin]),
	send_to_client(Bo, BinData).
	

%% 通知客户端：buff信息
notify_buff_info_to(Bo, {buff_not_exists, BuffOwner_BoId, BuffNo}) ->
	?ASSERT(is_integer(BuffNo)),
	ParaBin = <<0:8, 0:32, 0:8, 0:32>>,
	Bin = <<
			?RES_FAIL : 8,
			BuffOwner_BoId : 16,
			BuffNo : 32,
			0 : 16,
			0 : 8,
			ParaBin / binary
		  >>,
	{ok, Bin2} = pt_20:write(?PT_BT_QRY_BO_BUFF_INFO, Bin),
	send_to_client(Bo, Bin2);

notify_buff_info_to(Bo, {ok, BuffOwner_BoId, Buff}) ->
	?ASSERT(is_record(Buff, bo_buff)),
	Bin = build_buff_info_bin(BuffOwner_BoId, Buff),
	Bin2 = <<
			 ?RES_OK : 8,
			 Bin / binary
		   >>,
	{ok, Bin3} = pt_20:write(?PT_BT_QRY_BO_BUFF_INFO, Bin2),
	?TRACE("notify_buff_info_to(),  PlayerId=~p, BuffInfo_Bin=~p~n", [lib_bo:get_parent_obj_id(Bo), Bin]),
	send_to_client(Bo, Bin3).



build_buff_info_bin(BuffOwner_BoId, Buff) ->
	ParaBin = case lib_bo_buff:can_overlap(Buff) of
				true ->
					% TODO: 对于可叠加buff， 构造参数信息！
					<<0:8, 0:32, 0:8, 0:32>>;
				false ->
					<<0:8, 0:32, 0:8, 0:32>>
			end,
	<<
		BuffOwner_BoId : 16,
		(lib_bo_buff:get_no(Buff)) : 32,
		(lib_bo_buff:get_expire_round(Buff)) : 16,
		(lib_bo_buff:get_cur_overlap(Buff)) : 8,
		ParaBin / binary
	>>.



%% 通知某bo当前回合已准备好了
notify_bo_is_ready(Bo_Latest) ->
	{ok, BinData} = pt_20:write(?PT_BT_NOTIFY_BO_IS_READY, Bo_Latest),
	send_to_all(BinData).
	

%% 通知某bo已经播放完战报了
notify_bo_show_battle_report_done(Bo) ->
	BoId = lib_bo:get_id(Bo),
	{ok, BinData} = pt_20:write(?PT_BT_S2C_NOTIFY_BO_SHOW_BR_DONE, BoId),
	send_to_all(BinData).



%% 通知某bo的在线状态改变了
%% @para: NewOnlineInfo => online | offline
notify_bo_online_flag_changed(Bo, NewOnlineInfo) ->
	BoId = lib_bo:get_id(Bo),
	{ok, BinData} = pt_20:write(?PT_BT_NOTIFY_BO_ONLINE_FLAG_CHANGED, [BoId, NewOnlineInfo]),
	send_to_all_except_one(BinData, BoId). % 不需发给自己



%% 通知当前回合行动开始
notify_round_action_begin() ->
	{ok, BinData} = pt_20:write(?PT_BT_NOTIFY_ROUND_ACTION_BEGIN, dummy),
	send_to_all(BinData).


%% 通知当前回合行动结束
notify_round_action_end() ->
	?TRACE("~n~n  !!!!!!!!!!!!!!!notify_round_action_end()!!!!!!!!!!!~n"),
	{ok, BinData} = pt_20:write(?PT_BT_NOTIFY_ROUND_ACTION_END, dummy),
	send_to_all(BinData).


%% 通知新回合开始
notify_new_round_begin(NewRoundIndex) ->
	{ok, BinData} = pt_20:write(?PT_BT_NOTIFY_NEW_ROUND_BEGIN, NewRoundIndex),
	send_to_all(BinData).




%% 通知buff结算开始
notify_settle_buff_begin() ->
	{ok, BinData} = pt_20:write(?PT_BT_NOTIFY_SETTLE_BUFF_BEGIN, dummy),
	send_to_all(BinData).


%% 通知buff结算结束
notify_settle_buff_end() ->
	{ok, BinData} = pt_20:write(?PT_BT_NOTIFY_SETTLE_BUFF_END, dummy),
	send_to_all(BinData).


%% 
notify_on_new_round_begin_jobs_done() ->
	{ok, BinData} = pt_20:write(?PT_BT_NOTIFY_ON_NEW_ROUND_BEGIN_JOBS_DONE, dummy),
	send_to_all(BinData).



%% 发送战报给客户端
send_battle_report(?BR_T_BO_DO_PHY_ATT, Bin) ->
	{ok, Bin2} = pt_20:write(?PT_BT_NOTIFY_BR_DO_PHY_ATT, Bin),
	send_to_all(Bin2);

send_battle_report(?BR_T_BO_DO_MAG_ATT, Bin) ->
	{ok, Bin2} = pt_20:write(?PT_BT_NOTIFY_BR_DO_MAG_ATT, Bin),
	?BT_LOG(io_lib:format("~nPT_BT_NOTIFY_BR_DO_MAG_ATT: ~p~n~n", [Bin2])),
	send_to_all(Bin2);

send_battle_report(?BR_T_BO_CAST_BUFFS, Bin) ->
	{ok, Bin2} = pt_20:write(?PT_BT_NOTIFY_BR_CAST_BUFFS, Bin),
	send_to_all(Bin2);

send_battle_report(?BR_T_BO_ESCAPE, Bin) ->
	{ok, Bin2} = pt_20:write(?PT_BT_NOTIFY_BR_ESCAPE, Bin),
	send_to_all(Bin2);

send_battle_report(?BR_T_BO_DO_HEAL, Bin) ->
	{ok, Bin2} = pt_20:write(?PT_BT_NOTIFY_BR_HEAL, Bin),
	send_to_all(Bin2);

send_battle_report(?BR_T_BOS_FORCE_DIE, Bin) -> % 强行死亡通过20043协议（PT_BT_NOTIFY_BO_DIED）来发送
	%% old: {ok, Bin2} = pt_20:write(?PT_BT_NOTIFY_BR_FORCE_DIE, Bin),
	{ok, Bin2} = pt_20:write(?PT_BT_NOTIFY_BO_DIED, Bin),
	send_to_all(Bin2);

send_battle_report(?BR_T_BO_USE_GOODS, Bin) ->
	{ok, Bin2} = pt_20:write(?PT_BT_NOTIFY_BR_USE_GOODS, Bin),
	send_to_all(Bin2);

send_battle_report(?BR_T_BO_DO_SUMMON, Bin) ->
	{ok, Bin2} = pt_20:write(?PT_BT_NOTIFY_BR_SUMMON, Bin),
	send_to_all(Bin2);

send_battle_report(?BR_T_SEND_TIPS, Bin) -> % 战斗提示通过PT_BT_TIPS协议来发送
	{ok, Bin2} = pt_20:write(?PT_BT_TIPS, Bin),
	send_to_all(Bin2).   % 目前不管提示是否只是针对个人，都统一发给战场上的所有人




%% 补充发送战报给逃跑成功的玩家 (br: battle_report)
send_br_to_escaped_player_bo(ActionList, BtlReport_Bin) ->
	F = fun(Action_Esc) ->
			case Action_Esc#boa_escape.result of
				?RES_FAIL -> skip;
				?RES_OK ->
					EscapedBo = Action_Esc#boa_escape.bo,
					case lib_bt_comm:is_online_player(EscapedBo) of
						false -> skip;
						true ->
							?BT_LOG(io_lib:format("send_battle_report_to_escaped_player_bo(), EscapedBoId=~p, ActionList=~w~n", [lib_bo:id(EscapedBo), ActionList])),
							{ok, Bin2} = pt_20:write(?PT_BT_NOTIFY_BR_ESCAPE, BtlReport_Bin),
							lib_bt_send:send_to_client(EscapedBo, Bin2)
					end
			end
		end,
	lists:foreach(F, ActionList).



%% 回复客户端：下达指令成功（空指令）
resp_prepare_cmd_NOP_ok(Bo, [ForBoId]) ->
	?ASSERT(lib_bt_comm:is_player(Bo), Bo),
	{ok, Bin} = pt_20:write(?PT_BT_NOP_CMD, [?RES_OK, ForBoId]),
	send_to_client(Bo, Bin).

%% 回复客户端：下达指令失败（空指令）
resp_prepare_cmd_NOP_fail(Bo, [Reason, ForBoId]) ->
	?ASSERT(lib_bt_comm:is_player(Bo), Bo),
	{ok, Bin} = pt_20:write(?PT_BT_NOP_CMD, [Reason, ForBoId]),
	send_to_client(Bo, Bin).


%% 回复客户端：下达指令成功（普通攻击）
resp_prepare_cmd_normal_att_ok(Bo, [ForBoId, TargetBoId]) ->
	?ASSERT(lib_bt_comm:is_player(Bo), Bo),
	SkillId = 0,
	% 借用PT_BT_USE_SKILL协议来发送
	{ok, Bin} = pt_20:write(?PT_BT_USE_SKILL, [?RES_OK, ForBoId, SkillId, TargetBoId]),
	send_to_client(Bo, Bin).

%% 回复客户端：下达指令失败（普通攻击）
resp_prepare_cmd_normal_att_fail(Bo, [Reason, ForBoId, TargetBoId]) ->
	?ASSERT(lib_bt_comm:is_player(Bo), Bo),
	SkillId = 0,
	% 借用PT_BT_USE_SKILL协议来发送
	{ok, Bin} = pt_20:write(?PT_BT_USE_SKILL, [Reason, ForBoId, SkillId, TargetBoId]),
	send_to_client(Bo, Bin).

resp_prepare_cmd_capture_ok(Bo,[ForBoId, TargetBoId]) ->
	?ASSERT(lib_bt_comm:is_player(Bo), Bo),
	{ok, Bin} = pt_20:write(?PT_BT_CMD_CAPTURE_PARTNER, [?RES_OK, ForBoId, TargetBoId]),
	send_to_client(Bo, Bin).

resp_prepare_cmd_capture_fail(Bo,[ForBoId, TargetBoId]) ->
	?ASSERT(lib_bt_comm:is_player(Bo), Bo),
	?DEBUG_MSG("resp_prepare_cmd_capture_fail ForBoId=~p, TargetBoId=~p",[ForBoId, TargetBoId]),
	{ok, Bin} = pt_20:write(?PT_BT_CMD_CAPTURE_PARTNER, [?RES_FAIL, ForBoId, TargetBoId]),
	send_to_client(Bo, Bin).


%% 回复客户端：下达指令成功（使用技能）
resp_prepare_cmd_use_skill_ok(Bo, [ForBoId, SkillId, TargetBoId]) ->
	?ASSERT(lib_bt_comm:is_player(Bo), Bo),
	{ok, Bin} = pt_20:write(?PT_BT_USE_SKILL, [?RES_OK, ForBoId, SkillId, TargetBoId]),
	send_to_client(Bo, Bin).

%% 回复客户端：下达指令失败（使用技能）
resp_prepare_cmd_use_skill_fail(Bo, [Reason, ForBoId, SkillId, TargetBoId]) ->
	?ASSERT(lib_bt_comm:is_player(Bo), Bo),
	{ok, Bin} = pt_20:write(?PT_BT_USE_SKILL, [Reason, ForBoId, SkillId, TargetBoId]),
	send_to_client(Bo, Bin).


%% 回复客户端：下达指令成功（使用物品）
resp_prepare_cmd_use_goods_ok(Bo, [ForBoId, GoodsId, TargetBoId]) ->
	?ASSERT(lib_bt_comm:is_player(Bo), Bo),
	{ok, Bin} = pt_20:write(?PT_BT_USE_GOODS, [?RES_OK, ForBoId, GoodsId, TargetBoId]),
	send_to_client(Bo, Bin).


%% 回复客户端：下达指令失败（使用物品）
resp_prepare_cmd_use_goods_fail(Bo, [Reason, ForBoId, GoodsId, TargetBoId]) ->
	?ASSERT(lib_bt_comm:is_player(Bo), Bo),
	{ok, Bin} = pt_20:write(?PT_BT_USE_GOODS, [Reason, ForBoId, GoodsId, TargetBoId]),
	send_to_client(Bo, Bin).




%% 回复客户端：下达指令成功（保护）
resp_prepare_cmd_protect_others_ok(Bo, [ForBoId, TargetBoId]) ->
	?ASSERT(lib_bt_comm:is_player(Bo), Bo),
	{ok, Bin} = pt_20:write(?PT_BT_PROTECT_OTHERS, [?RES_OK, ForBoId, TargetBoId]),
	send_to_client(Bo, Bin).

%% 回复客户端：下达指令失败（保护）
resp_prepare_cmd_protect_others_fail(Bo, [Reason, ForBoId, TargetBoId]) ->
	?ASSERT(lib_bt_comm:is_player(Bo), Bo),
	{ok, Bin} = pt_20:write(?PT_BT_PROTECT_OTHERS, [Reason, ForBoId, TargetBoId]),
	send_to_client(Bo, Bin).



%% 回复客户端：下达指令成功（逃跑）
resp_prepare_cmd_escape_ok(Bo, [ForBoId]) ->
	?ASSERT(lib_bt_comm:is_player(Bo), Bo),
	{ok, Bin} = pt_20:write(?PT_BT_ESCAPE, [?RES_OK, ForBoId]),
	send_to_client(Bo, Bin).

%% 回复客户端：下达指令失败（逃跑）
resp_prepare_cmd_escape_fail(Bo, [Reason, ForBoId]) ->
	?ASSERT(lib_bt_comm:is_player(Bo), Bo),
	{ok, Bin} = pt_20:write(?PT_BT_ESCAPE, [Reason, ForBoId]),
	send_to_client(Bo, Bin).



%% 回复客户端：下达指令成功（防御）
resp_prepare_cmd_defend_ok(Bo, [ForBoId]) ->
	?ASSERT(lib_bt_comm:is_player(Bo), Bo),
	{ok, Bin} = pt_20:write(?PT_BT_DEFEND, [?RES_OK, ForBoId]),
	send_to_client(Bo, Bin).



%% 回复客户端：下达指令失败（防御）
resp_prepare_cmd_defend_fail(Bo, [Reason, ForBoId]) ->
	?ASSERT(lib_bt_comm:is_player(Bo), Bo),
	{ok, Bin} = pt_20:write(?PT_BT_DEFEND, [Reason, ForBoId]),
	send_to_client(Bo, Bin).



%% 回复客户端：下达指令成功（召唤宠物）
resp_prepare_cmd_summon_partner_ok(Bo, [ForBoId, PartnerId]) ->
	?ASSERT(lib_bt_comm:is_player(Bo), Bo),
	{ok, Bin} = pt_20:write(?PT_BT_SUMMON_PARTNER, [?RES_OK, ForBoId, PartnerId]),
	send_to_client(Bo, Bin).



%% 回复客户端：下达指令失败（召唤宠物）
resp_prepare_cmd_summon_partner_fail(Bo, [Reason, ForBoId, PartnerId]) ->
	?ASSERT(lib_bt_comm:is_player(Bo), Bo),
	{ok, Bin} = pt_20:write(?PT_BT_SUMMON_PARTNER, [Reason, ForBoId, PartnerId]),
	send_to_client(Bo, Bin).





%% 回复客户端：下达指令成功（依据AI）
resp_prepare_cmd_by_AI_ok(Bo, [ForBoId]) ->
	?ASSERT(lib_bt_comm:is_player(Bo), Bo),
	{ok, Bin} = pt_20:write(?PT_BT_REQ_PREPARE_CMD_BY_AI, [?RES_OK, ForBoId]),
	send_to_client(Bo, Bin).

%% 回复客户端：下达指令失败（依据AI）
resp_prepare_cmd_by_AI_fail(Bo, [Reason, ForBoId]) ->
	?ASSERT(lib_bt_comm:is_player(Bo), Bo),
	{ok, Bin} = pt_20:write(?PT_BT_REQ_PREPARE_CMD_BY_AI, [Reason, ForBoId]),
	send_to_client(Bo, Bin).



resp_request_auto_battle_ok(Bo) ->
	{ok, Bin} = pt_20:write(?PT_BT_REQ_AUTO_BATTLE, [?RES_OK]),
	send_to_client(Bo, Bin).


resp_cancel_auto_battle_ok(Bo) ->
	{ok, Bin} = pt_20:write(?PT_BT_CANCEL_AUTO_BATTLE, [?RES_OK]),
	send_to_client(Bo, Bin).



notify_bo_buff_added(Bo_Latest, BuffNo) ->
	BoId = lib_bo:id(Bo_Latest),
	BuffDetails = lib_bt_misc:build_buff_details(Bo_Latest, BuffNo),
	{ok, Bin} = pt_20:write(?PT_BT_NOTIFY_BO_BUFF_CHANGED, [buff_added, BoId, BuffDetails]),
	send_to_all(Bin).
	
	

notify_bo_buff_removed(Bo, BuffNo) ->
	BoId = lib_bo:id(Bo),
	BuffDetails = ?REMOVED_BUFF_DETAILS(BuffNo),
	{ok, Bin} = pt_20:write(?PT_BT_NOTIFY_BO_BUFF_CHANGED, [buff_removed, BoId, BuffDetails]),
	send_to_all(Bin).
	


%% 通知所有玩家：某bo的属性改变了
notify_bo_attr_changed_to_all(Bo_Latest, ChangedAttrInfoList) ->
	{ok, Bin} = pt_20:write(?PT_BT_NOTIFY_BO_ATTR_CHANGED, [Bo_Latest, ChangedAttrInfoList]),
	send_to_all(Bin).


notify_bo_died_to_all(BoId, DieDetails) ->
	?ASSERT(DieDetails#die_details.die_status /= ?DIE_STATUS_LIVING),
	{ok, Bin} = pt_20:write(?PT_BT_NOTIFY_BO_DIED, [BoId, DieDetails]),
	send_to_all(Bin).

% 通知捕捉
notify_bo_capture_to_all(BoId,TargetBoId,Result) ->
	{ok, Bin} = pt_20:write(?PT_BT_CAPTURE_PARTNER, [BoId, TargetBoId, Result]),
	send_to_all(Bin).


notify_bo_revive_to_all(BoId) ->
	Bo = get_bo_by_id(BoId),
	{ok, Bin} = pt_20:write(?PT_BT_NOTIFY_BO_REVIVE, Bo),
	send_to_all(Bin).


%% 通知技能的可使用情况给bo
notify_skill_usable_info_to_bo(Bo, QueryType, UsableInfo_Bin) ->
	?BT_LOG(io_lib:format("notify_skill_usable_info_to_bo(), BoId=~p, QueryType=~p, UsableInfo_Bin:~w~n", [lib_bo:id(Bo), QueryType, UsableInfo_Bin])),
	{ok, Bin} = pt_20:write(?PT_BT_QUERY_SKILL_USABLE_INFO, [QueryType, UsableInfo_Bin]),
	send_to_client(Bo, Bin).



notify_bo_info_to_back_to_battle_bo(Bo, TargetBoInfo_Bin) ->
	?BT_LOG(io_lib:format("notify_bo_info_to_back_to_battle_bo(), BoId=~p, TargetBoInfo_Bin:~w~n", [lib_bo:id(Bo), TargetBoInfo_Bin])),
	{ok, Bin} = pt_20:write(?PT_BT_QUERY_BO_INFO_AFTER_BACK_TO_BATTLE, TargetBoInfo_Bin),
	send_to_client(Bo, Bin).



notify_cli_not_need_back_to_battle(PlayerId) ->
    {ok, Bin} = pt_20:write(?PT_BT_NOTIFY_NOT_NEED_BACK_TO_BATTLE, dummy),
    lib_send:send_to_uid(PlayerId, Bin).



notify_all_bo_cur_round_talk_AI() ->
	L = lib_bt_comm:get_all_bo_id_list(),

	TalkAIInfoL = [build_bo_cur_round_talk_AI_info(X) || X <- L],
	TalkAIInfoL2 = [X || X <- TalkAIInfoL, X /= invalid],

	case TalkAIInfoL2 of
		[] ->
			skip;
		_ ->
			Len = length(TalkAIInfoL2),
			Bin = list_to_binary(TalkAIInfoL2),
			Bin2 = <<Len:16, Bin/binary>>,
			{ok, Bin3} = pt_20:write(?PT_BT_NOTIFY_TALK_AI_INFO, Bin2),
    		send_to_all(Bin3)
	end.


build_bo_cur_round_talk_AI_info(BoId) ->
	Bo = get_bo_by_id(BoId),
	case lib_bo:get_cur_round_talk_AI_list(Bo) of
		[] ->
			invalid;
		AINoList ->
			F = fun(AINo) ->
					AI = lib_bt_AI:get_cfg_data(AINo),
					{?AI_CONT_TALK, WhenToTalk, TalkContNo} = AI#bo_ai.action_content,

					WhenToTalk_Int = case WhenToTalk of
										on_round_begin -> 1;
										on_act -> 2;
										on_be_attack -> 3;% 新增
										on_use_skill -> 4;
										on_attack -> 5;
										on_escape -> 6;
										on_use_goods -> 7;
										on_be_heal -> 8;
										on_summon -> 9;
										_Any -> ?ASSERT(false, _Any), 1  % 容错
									end,

					<<WhenToTalk_Int:8, TalkContNo:16>>
				end,
			Len = length(AINoList),
			AIInfoList_Bin = list_to_binary( [F(X) || X <- AINoList] ),
			<<BoId:16, Len:16, AIInfoList_Bin/binary>>
	end.


%% 通知客户端：下一波怪刷出了			
notify_next_bmon_group_spawned(ForRound, ForSide, NewNthWave, NewMonBoList) ->
	BoInfoList = [lib_bt_misc:build_bo_info_bin(X) || X <- NewMonBoList],
	Bin = <<
			ForRound : 16,
			ForSide : 8,
			NewNthWave : 16,
			(length(NewMonBoList)) : 16,
			(list_to_binary(BoInfoList)) / binary
		>>,
	{ok, Bin2} = pt_20:write(?PT_BT_NOTIFY_NEXT_BMON_GROUP_SPAWNED, Bin),
	send_to_all(Bin2).



%% 通知客户端：新的bo刷出了
notify_cli_new_bo_spawned(Bo) ->
	Bin = build_new_bo_info_bin(Bo),
	{ok, Bin2} = pt_20:write(?PT_BT_NOTIFY_NEW_BO_SPAWNED, Bin),
	send_to_all(Bin2).


resp_query_battle_start_time_ok(Bo, StartTime) ->
	{ok, Bin} = pt_20:write(?PT_BT_QUERY_BATTLE_START_TIME, [?RES_OK, StartTime]),
	send_to_client(Bo, Bin).

resp_query_battle_start_time_fail(PS) ->
	{ok, Bin} = pt_20:write(?PT_BT_QUERY_BATTLE_START_TIME, [?RES_FAIL, 0]),
	lib_send:send_to_sock(PS, Bin).



build_new_bo_info_bin(Bo) ->
	Bin1 = <<
			(lib_bo:get_side(Bo)) : 8
		   >>,
	Bin2 = lib_bt_misc:build_bo_info_bin(Bo),
	<<
	    Bin1 / binary,
	    Bin2 / binary
	>>.



%% 发送给战场上的所有在线玩家
send_to_all(BinData) ->
	L = lib_bt_comm:get_all_online_player_bo_id_list(),
	[send_to_client(BoId, BinData) || BoId <- L].

%% 世界BOSS
send_to_all_world(BinData) ->
	send_to_client(1, BinData).
	

%% 发送给战场上的所有在线玩家，但排除掉BoId对应的玩家
send_to_all_except_one(BinData, ExceptBoId) ->
	?ASSERT(is_integer(ExceptBoId)),
	L = lib_bt_comm:get_all_online_player_bo_id_list(),
	[send_to_client(BoId, BinData) || BoId <- L, BoId /= ExceptBoId].
	



%% 发送消息包给客户端, 战斗系统向客户端发送数据统一用这个接口
send_to_client(PlayerBoId, BinData) when is_integer(PlayerBoId) ->
	case get_bo_by_id(PlayerBoId) of
		null ->
			?ASSERT(false, PlayerBoId),  % 目前严格些，做断言失败！
			skip;
		PlayerBo ->
			send_to_client(PlayerBo, BinData)
	end;
			

send_to_client(PlayerBo, BinData) when is_record(PlayerBo, battle_obj) ->
	?ASSERT(lib_bt_comm:is_online_player(PlayerBo), PlayerBo),
	SendPid = lib_bo:get_sendpid(PlayerBo),
	?ASSERT(is_pid(SendPid), {SendPid, PlayerBo}),
	lib_send:send_to_sid(SendPid , BinData),
	ok.