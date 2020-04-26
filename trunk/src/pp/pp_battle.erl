%%%--------------------------------------
%%% @Module  : pp_battle
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2013.7.29
%%% @Description: 战斗相关协议
%%%--------------------------------------
-module(pp_battle).
-export([handle/3]).

-include("common.hrl").
% -include("record.hrl").
-include("pt_20.hrl").
-include("battle.hrl").
% -include("battle_record.hrl").
-include("abbreviate.hrl").
-include("prompt_msg_code.hrl").
-include("player.hrl").
-include("goods.hrl").
-include("event.hrl").
-include("monster.hrl").
-include("sys_code.hrl").
-include("buff.hrl").


%% 玩家触发战斗：打明雷怪
handle(?PT_BT_START_MF, PS, [MonId, Difficulty]) ->
	% ?DEBUG_MSG("PT_BT_START_MF, MonId:~p~n",[MonId]),
	case check_start_mf(PS, MonId) of
		{fail, cli_msg_illegal} ->
			?ASSERT(false),
			skip;
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason);
		ok ->
			% ?DEBUG_MSG("PT_BT_START_MF, MonId:~p, check ok!!~n",[MonId]),
			MonObj = mod_mon:get_obj(MonId),
			% 世界boss活动mf复用了此协议，故细化判断
			case mod_mon:is_world_boss(MonObj) of
				true ->
					TeamMbList = case player:is_in_team(PS) of
									false -> [player:id(PS)];
									true -> mod_team:get_can_fight_member_id_list(player:get_team_id(PS))
								end,
					MonNo = mod_mon:get_no(MonObj),
					io:format("MonNo=====~p,MonId======~p~n",[MonNo,MonId]),
					mod_dungeon:challage_dungeon_boss(MonNo, MonId, TeamMbList, PS);
				false ->
					MonNo = mod_mon:get_no(MonObj),
					case MonNo of
						35171 ->
							mod_guild_dungeon:challage_guild_dungeon_boss(MonNo, MonId, PS);
						_ -> % 女妖乱斗活动mf复用了此协议，故细化判断
							case player:is_in_melee_scene(PS) of
								true ->
									mod_battle:start_melee_mf(PS, MonObj, fun lib_melee:melee_mf_callback/2);
								false ->
									case mod_tve:is_in_tve_dungeon(PS) of
										false ->
											mod_battle:start_mf(PS, MonObj, ?BTL_SUB_T_NORMAL_MF, null, Difficulty);
										true ->
											case mod_tve:check_start_tve_mf(PS) of %% 处理断线重连副本保护时间内，需要继续判断次数
												{fail, ReasonTve} ->
													lib_send:send_prompt_msg(PS, ReasonTve);
												ok ->
													?DEBUG_MSG("pp_battle: handle PT_BT_START_MF MonNo:~p~n", [mod_mon:get_no(MonObj)]),
													mod_battle:start_tve_mf(PS, MonObj, null)
											end
									end
							end
					end

			end
	end;





%% 玩家发起PK邀请
handle(?PT_BT_START_PK, PS, [TargetPlayerId, PK_Type]) ->
	?TRACE("PT_BT_START_PK, PK_Type: ~p~n", [PK_Type]),

	case check_start_pk(PS, TargetPlayerId, PK_Type) of
		{fail, cli_msg_illegal} ->
			?ASSERT(false, PK_Type),
			skip;
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason);
		{ok, TargetPS} ->
			{ok, Bin} = pt_20:write(?PT_BT_START_PK, [?RES_OK, TargetPlayerId, PK_Type]),
			lib_send:send_to_sock(PS, Bin),

			case PK_Type of
				?PK_T_QIECUO ->
					ask_if_accept_pk(PS, TargetPS, PK_Type);
				?PK_T_FORCE ->
					TargetPS2 =
						case player:is_in_team_but_not_leader(TargetPS) andalso (not player:is_tmp_leave_team(TargetPS)) of
							true ->
								% 转为向目标的队长pk
								TargetLeaderId = player:get_leader_id(TargetPS),
								player:get_PS(TargetLeaderId);
							false ->
								TargetPS
						end,

					case TargetPS2 of
						null ->
							skip;
						_ ->
							% 女妖乱斗pk复用了此协议，故细化判断
							case player:is_in_melee_scene(PS) of
								true ->
									mod_battle:start_melee_pk(PS, TargetPS2, fun lib_melee:melee_pk_callback/2);
								false ->
									case player:is_in_guild_battle_scene(PS) of
										true ->
											mod_guild_battle:try_start_pk(PS,TargetPlayerId);
										false ->
											mod_battle:start_pk(PS, TargetPS2, PK_Type, null)
									end
							end
					end
			end
	end;


%% 玩家回复PK邀请
handle(?PT_BT_REPLY_PK_INVITE, PS, [ReplyCode, FromPlayerId, PK_Type]) ->
	case ReplyCode of
		1 ->  % 同意
			case check_start_pk(PS, FromPlayerId, PK_Type) of
				{fail, cli_msg_illegal} ->
        			?ASSERT(false, PK_Type),
        			skip;
				{fail, Reason} ->
					lib_send:send_prompt_msg(PS, Reason);
				{ok, FromPS} ->
					mod_battle:start_pk(FromPS, PS, PK_Type, null)
			end;
		2 ->  % 拒绝
			notify_pk_invite_refused(FromPlayerId, PS, PK_Type);
		_ ->
			?ASSERT(false, ReplyCode),
			skip
	end;


%% 查询战场描述信息
handle(?PT_BT_QRY_BATTLE_FIELD_DESC, PS, _) ->
	case player:get_cur_battle_pid(PS) of
		null ->
			%%?ASSERT(false),
			skip;
		CurBattlePid ->
			?ASSERT(is_pid(CurBattlePid)),
			% BattleId = player:get_cur_battle_id(PS),
			% BattlePid = mod_battle_mgr:get_battle_pid_by_id(BattleId),
			% BattlePid = player:get_cur_battle_pid(PS),
			% ?ASSERT(is_process_alive(BattlePid)),
			mod_battle:query_battle_field_desc( player:id(PS), CurBattlePid)
	end;



%% 客户端通知服务端：播放战报完毕
handle(?PT_BT_C2S_NOTIFY_SHOW_BR_DONE, PS, _) ->
	PlayerId = player:id(PS),
	case player:get_cur_battle_pid(PS) of
		null ->
			%%?ASSERT(false, PlayerId),
			skip;
		CurBattlePid ->
			?ASSERT(is_pid(CurBattlePid)),
			% BattleId = player:get_cur_battle_id(PS),
			% BattlePid = mod_battle_mgr:get_battle_pid_by_id(BattleId),
			% BattlePid = player:get_cur_battle_pid(PS),
			% ?ASSERT(is_process_alive(BattlePid)),
			mod_battle:c2s_notify_show_battle_report_done(PlayerId, CurBattlePid)
	end;



%% 下达指令：空指令
handle(?PT_BT_NOP_CMD, PS, ForBoId) ->
			case player:get_cur_battle_pid(PS) of
				null ->
					?ASSERT(false),
					skip;
				CurBattlePid ->
					mod_battle:prepare_cmd_NOP(PS, ForBoId, CurBattlePid)
			end;






%% 下达指令：使用技能
handle(?PT_BT_USE_SKILL, PS, [ForBoId, SkillId, TargetBoId]) ->
			case SkillId == 0 orelse mod_skill:is_valid_skill_id(SkillId) of
				false ->
					?TRACE("PT_BT_USE_SKILL, skill id(~p) invalid...~n", [SkillId]),
					{ok, BinData} = pt_20:write(?PT_BT_USE_SKILL, [?PC_FAIL_SKILL_ID_INVALID, ForBoId, SkillId, TargetBoId]),
					lib_send:send_to_sock(PS, BinData);
				true ->
					case player:get_cur_battle_pid(PS) of
						null ->
							% ?ASSERT(false, {player:id(PS), Type, SkillId, TargetBoId}),
							skip;
						CurBattlePid ->
							?ASSERT(is_pid(CurBattlePid)),
							case SkillId of
								0 ->  % 表示使用普通攻击
									mod_battle:prepare_cmd_normal_att(PS, ForBoId, TargetBoId, CurBattlePid);
								_ ->
									mod_battle:prepare_cmd_use_skill(PS, ForBoId, SkillId, TargetBoId, CurBattlePid)
							end
					end
			end;








% %% 战斗外使用技能
% handle(?PT_BT_USE_SKILL_OUTSIDE_BATTLE, _PS, _SkillId) ->
% 	todo_here;



%% 下达指令：使用物品
handle(?PT_BT_USE_GOODS, PS, [ForBoId, GoodsId, TargetBoId]) ->
			case player:get_cur_battle_pid(PS) of
				null ->
					%%?ASSERT(false, Type),
					skip;
				CurBattlePid ->
					?ASSERT(is_pid(CurBattlePid)),
					case check_prepare_cmd_use_goods(PS, ForBoId, GoodsId) of
						{fail, Reason} ->
							{ok, BinData} = pt_20:write(?PT_BT_USE_GOODS, [Reason, ForBoId, GoodsId, TargetBoId]),
							lib_send:send_to_sock(PS, BinData);
						{ok, Goods} ->
							mod_battle:prepare_cmd_use_goods(PS, ForBoId, Goods, TargetBoId, CurBattlePid)
					end
			end;






%% 下达指令：保护
handle(?PT_BT_PROTECT_OTHERS, PS, [ForBoId, TargetBoId]) ->
			case player:get_cur_battle_pid(PS) of
				null ->
					%%?ASSERT(false, Type),
					skip;
				CurBattlePid ->
					mod_battle:prepare_cmd_protect_others(PS, ForBoId, TargetBoId, CurBattlePid)
			end;


%% 下达指令：捕捉
handle(?PT_BT_CMD_CAPTURE_PARTNER, PS, [ForBoId, TargetBoId]) ->
			case player:get_cur_battle_pid(PS) of
				null ->
					skip;
				CurBattlePid ->
					mod_battle:prepare_cmd_capture(PS, ForBoId, TargetBoId, CurBattlePid)
			end;






%% 下达指令：逃跑
handle(?PT_BT_ESCAPE, PS, ForBoId) ->
			case player:get_cur_battle_pid(PS) of
				null ->
					%%?ASSERT(false),
					skip;
				CurBattlePid ->
					mod_battle:prepare_cmd_escape(PS, ForBoId, CurBattlePid)
			end;





%% 下达指令：防御
handle(?PT_BT_DEFEND, PS, ForBoId) ->
			case player:get_cur_battle_pid(PS) of
				null ->
					%%?ASSERT(false),
					skip;
				CurBattlePid ->
					mod_battle:prepare_cmd_defend(PS, ForBoId, CurBattlePid)
			end;


%% 下达指令：召唤宠物
handle(?PT_BT_SUMMON_PARTNER, PS, [ForBoId, PartnerId]) ->
			case player:get_cur_battle_pid(PS) of
				null ->
					%%?ASSERT(false),
					skip;
				CurBattlePid ->
					% case check_prepare_cmd_summon_partner(PS, PartnerId) of
					% 	{fail, Reason} ->
					% 		{ok, BinData} = pt_20:write(?PT_BT_SUMMON_PARTNER, [Reason, Type, PartnerId]),
					% 		lib_send:send_to_sock(PS, BinData);
					% 	ok ->
					% 		mod_battle:prepare_cmd_summon_partner(PS, Type, PartnerId, CurBattlePid)
					% end

					mod_battle:prepare_cmd_summon_partner(PS, ForBoId, PartnerId, CurBattlePid)
			end;


%% 下达指令：请求依据按AI下指令
handle(?PT_BT_REQ_PREPARE_CMD_BY_AI, PS, ForBoId) ->
	case player:get_cur_battle_pid(PS) of
		null ->
			skip;
		CurBattlePid ->
			mod_battle:req_prepare_cmd_by_AI(PS, ForBoId, CurBattlePid)
	end;


%% 查询bo身上指定buff的信息
handle(?PT_BT_QRY_BO_BUFF_INFO, PS, [TargetBoId, BuffNo]) ->
	case player:get_cur_battle_pid(PS) of
		null ->
			?ASSERT(false),
			skip;
		CurBattlePid ->
			mod_battle:query_bo_buff_info(PS, TargetBoId, BuffNo, CurBattlePid)
	end;





%% 请求自动战斗
handle(?PT_BT_REQ_AUTO_BATTLE, PS, _) ->
	% ?ASSERT(not lib_player:is_in_auto_mf_mode(Status)), % 自动挂机状态下本身就是自动战斗，不需请求



			case player:is_auto_battle(PS) of
				true -> % 已经是自动战斗了，跳过
					skip;
				false ->
					case player:get_cur_battle_pid(PS) of
						null ->
							?TRACE("NOT in battle when req auto battle ...~n"),
							?ASSERT(false),
							skip;
						CurBattlePid ->
							mod_battle:request_auto_battle(PS, CurBattlePid)
							% Status#player_status.cur_bid ! {'REQ_AUTO_BATTLE', Status#player_status.id}
					end

					% NewStatus  = Status#player_status{is_auto_battle = true},
					% {ok, no_save_online, NewStatus}
			end;


%% 取消自动战斗
handle(?PT_BT_CANCEL_AUTO_BATTLE, PS, _) ->
			% case PS#player_status.is_auto_battle of
			% 	false ->
			% 		%%?ASSERT(false),
			% 		skip;
			% 	true ->
					% 取消自动战斗时，同时也会取消自动挂机
					% mod_player:set_in_auto_mf_mode_flag(Status#player_status.pid, false),

					case player:get_cur_battle_pid(PS) of
						null ->
							?TRACE("NOT in battle when cancel auto battle ...~n"),
							?ASSERT(false),
							skip;
						CurBattlePid ->
							mod_battle:cancel_auto_battle(PS, CurBattlePid)
							% Status#player_status.cur_bid ! {'CANCEL_AUTO_BATTLE', Status#player_status.id}
					end;
					% NewStatus  = Status#player_status{is_auto_battle = false},
					% {ok, no_save_online, NewStatus}
			% end;





handle(?PT_BT_QUERY_SKILL_USABLE_INFO, PS, TargetBoId) ->
	% case QueryType == 1
	% orelse QueryType == 2
	% orelse QueryType == 3 of
	% 	false ->
	% 		?ASSERT(false, QueryType),
	% 		skip;
	% 	true ->
			case player:get_cur_battle_pid(PS) of
				null ->
					skip;
				CurBattlePid ->
					mod_battle:query_skill_usable_info(PS, CurBattlePid, TargetBoId)
			end;
	% end;



handle(?PT_BT_QUERY_BO_INFO_AFTER_BACK_TO_BATTLE, PS, TargetBoId) ->
	case player:get_cur_battle_pid(PS) of
		null ->
			skip;
		CurBattlePid ->
			mod_battle:query_bo_info_after_back_to_battle(PS, CurBattlePid, TargetBoId)
	end;


handle(?PT_BT_TRY_GO_BACK_TO_BATTLE, PS, _) ->
	ply_battle:try_go_back_to_battle(PS),
	void;


handle(?PT_BT_QUERY_BATTLE_START_TIME, PS, _) ->
	case player:get_cur_battle_pid(PS) of
		null ->
			lib_bt_send:resp_query_battle_start_time_fail(PS);
		CurBattlePid ->
			mod_battle:query_battle_start_time(PS, CurBattlePid)
	end;





%% 强行退出战斗，仅用于调试！
handle(?PT_BT_DBG_FORCE_QUIT_BATTLE, PS, _) ->
	% case player:get_cur_battle_pid(PS) of
	% 	null ->
	% 		?TRACE("PT_BT_DBG_FORCE_QUIT_BATTLE, not in battle!!!~n"),
	% 		% ?ASSERT(false),
	% 		skip;
	% 	Pid ->
	% 		mod_battle:stop(Pid, normal)
	% end;

	mod_battle:force_end_battle(PS);







%% 获取战斗对象的信息，仅用于调试！
handle(?PT_BT_DBG_GET_BO_INFO, PS, BoId) ->
	case player:is_battling(PS) of
		false ->
			?ASSERT(false),
			skip;
		true ->
			BattlePid = player:get_cur_battle_pid(PS),
			case gen_server:call(BattlePid, {'debug_get_bo_info', BoId}) of
				{fail, Reason} ->
					lib_send:send_prompt_msg(PS, Reason);
				{ok, BoInfo_Bin} ->
					Len = byte_size(BoInfo_Bin),
					Data = <<Len:16, BoInfo_Bin/binary>>,
					Data2 = pt:pack(?PT_BT_DBG_GET_BO_INFO, Data),
					lib_send:send_to_sock(PS, Data2)
			end
	end;



handle(?PT_BT_CAPTAIN_PROJECT, PS, [BoId, Cmd]) ->
	% 如果在队伍中，是否为队长？
	 ?Ifc (player:is_in_team(PS) andalso (not player:is_leader(PS)))
	 	throw(?PM_NOT_TEAM_LEADER)
	 ?End,
	case player:get_cur_battle_pid(PS) of
		null ->
			%%?ASSERT(false, Type),
			skip;
		CurBattlePid ->
			{ok, BinData} = pt_20:write(?PT_BT_CAPTAIN_PROJECT, [BoId, Cmd]),
			mod_battle:captain_project(CurBattlePid, PS, BinData)
	end;



%% 客户端通知服务端：客户端战斗结束
handle(?PT_BT_C2S_NOTIFY_BATTLE_END, PS, _) ->
	%% 通知副本
	% ?LDS_TRACE("client battle end"),
	case player:is_in_dungeon(PS) of
        false -> skip;
        {true, _Pid} -> mod_dungeon:notify_event(?CLIENT_BATTLE_END, [], PS)
    end,
	ok;







% %%发动攻击 - 玩家VS玩家
% %%Id:玩家ID
% %%Sid:玩家技能id
% handle(20002, Status, Id) ->
%     case lib_player:is_in_battle(Status) == true orelse Status#player_status.hp == 0 orelse Status#player_status.id == Id of
%         true ->   skip; % To-Do: 自己对自己施加技能现在暂时不实现
%         false->

%             DataList = ets:lookup(?ETS_ONLINE, Id),
%             IsInSafeScene = false,   %%case lib_scene:is_safe(Data#ets_online.scene) of
%             case DataList == [] orelse IsInSafeScene == true of
%                 true ->   skip;
%                 false ->

%                     Data = hd(DataList),
%                     case catch gen_server:call(Data#ets_online.pid, 'LOCK_PLAYER', 2000) of % 获得被攻击玩家数据，同时锁住该玩家进程
%                         {'EXIT', Reason} ->
%                             ?ERROR_MSG("handle 2002-call fail:id=~p,reason:~w", [Id,Reason]),
%                             skip;
%                         locked -> % 该玩家进程已被锁住，发动战斗失败
%                             skip;
%                         Player ->

%                             Result = 
%                                 case lib_player:is_in_battle(Player) == false andalso Player#player_status.hp > 0 of
%                                     true ->    handle_battle_pk_type(Status, Player);
%                                     false ->   mod_battle:battle_fail(Status#player_status.socket, <<"对方正在战斗中">>)
%                                 end,
%                             gen_server:cast(Player#player_status.pid, 'UNLOCK_PLAYER'), % 解锁被攻击玩家进程
%                             Result
%                     end
%             end
%     end;

% handle(20004, _Status, _D) -> skip;

% %%发动辅助技能
% %%Id:玩家ID
% %%Sid:玩家技能id
% handle(20006, _Status, [_Id, _Sid]) ->
%     skip; % by Skyman

% %%选择技能
% handle(20009, Status, [_BattleObjId, SkillId, SkillLv, SkillGrid]) ->
%     ?TRACE("===== 20009: BattleObjId=~p, SkillId=~p, SkillLv=~p, SkillGrid=~p, cur_bid=~p =====~n", [_BattleObjId, SkillId, SkillLv, SkillGrid, Status#player_status.cur_bid]),
%     Time = util:longunixtime(),
%     case Time - Status#player_status.last_sel_skill_time >= ?SKILL_CD_TIME of
%         false ->
%             ?TRACE("+++++++++++++++ skill is cooling down +++++++++++++++~n"),
%             skip;
%         true ->
%         	CurBattlePid = Status#player_status.cur_bid,
%             case is_pid(CurBattlePid) of
%             	false ->   % 战斗进程没有了（原因可能是：战斗结束，或者未曾开始，或者战斗进程所属的玩家突然下线了）
%             		?TRACE("recv 20009 from client but cur_bid is: ~p", [CurBattlePid]),
%             		skip;
%             	true ->
% %%                     mod_battle:stop_cur_battle(Status#player_status.id),
%             		Status#player_status.cur_bid ! {'SEL_SKILL', cmd_sel, SkillId, SkillLv, SkillGrid, Status#player_status.sid},
%             		{ok, no_save_online, Status#player_status{seled_skill = true, last_sel_skill_time = Time}}
%             end
%     end;

% %%准备下一回合战斗
% handle(20011, Status, BattleObjId) ->
% 	?ASSERT(false),
%     ?TRACE("===== 20011: BattleObjId=~p =====~n", [BattleObjId]),
%     % 要选择了技能才能准备战斗
%     case Status#player_status.seled_skill of
%         true ->
%             Status#player_status.cur_bid ! {ready_turn, BattleObjId, Status#player_status.sid},
%             {ok, Status#player_status{seled_skill = false}};
%         false ->
%             ?TRACE("### ERROR: Must select skill first!!!~n"),
%             {ok, Status}
%     end;

% %%给玩家复活点设置
% handle(20013, _Status, _D) -> skip;
% %%     ?TRACE("========== 20013 ==========~n"),
%     %%  广播给附近玩家
% %%     {ok, BinData} = pt_12:write(12009, [Status#player_status.id, Status#player_status.hp, Status#player_status.hp_lim, Status#player_status.battle_capacity]),
% %%     lib_send:send_to_area_scene(Status#player_status.scene, Status#player_status.line_id, Status#player_status.x, Status#player_status.y, BinData),
% %%     pp_scene:handle(12001, Status, [Status#player_status.x, Status#player_status.y]);


% %% 请求播放剧情战斗CG
% %%para： CGSeqNum => 剧情CG的序号
% handle(20015, Status, [CGSeqNum, MonObjId]) ->
% 	?TRACE("20015!!!!!!!!!!, ~p, ~p~n", [CGSeqNum, MonObjId]),
% 	case mod_CG:play_CG(Status, CGSeqNum, MonObjId) of
% 		{fail} ->
% 			%%?ASSERT(false, CGSeqNum),
% 			skip;
% 		{ok, NewStatus} ->
% 			% 更新玩家状态
% 			{ok, NewStatus}
% 	end;


% %% 客户端通知服务端：剧情战斗CG播放完毕
% %%para： CGSeqNum => 剧情CG的序号
% %%handle(20016, Status, CGSeqNum) ->
% %%	?TRACE("20016!!!!!!!!!!!!!!!~p~n", [CGSeqNum]),
% %%	% 清理CG临时武将和怪物
% %%	mod_CG:do_clear_jobs(Status),
% %%	CGInfo = Status#player_status.cg_info,
% %%	NewStatus = Status#player_status{
% %%					% 回归到空闲状态
% %%					cur_state = ?PS_IDLE,
% %%					cur_bid = none,
% %%					% 恢复战斗前的数据
% %%					hp = CGInfo#role_CG.original_hp,
% %%					anger = CGInfo#role_CG.original_anger,
% %%					battler_list = CGInfo#role_CG.original_battler_list,
% %%					% 更新当前剧情CG的进展
% %%					cg_info = CGInfo#role_CG{cur_CG_step = CGSeqNum}
% %%					},
% %%	% 更新当前剧情CG进展到db
% %%	%%mod_CG:save_cur_CG_step(NewStatus),
% %%	{ok, NewStatus};


% %% 客户端通知服务端：玩家处理QTE的结果
% handle(?PT_BT_QTE_RESULT, Status, [BattleObjId, Result, CheckCode]) -> 
% 	?TRACE("recv PT_BT_QTE_RESULT, curbid: ~p, boid: ~p,  ~p ~p~n", [Status#player_status.cur_bid, BattleObjId, Result, CheckCode]),
% 	?DEBUG_MSG("recv PT_BT_QTE_RESULT,boid: ~p, ~p ~p", [BattleObjId, Result, CheckCode]),
% 	%%?ASSERT(is_pid(Status#player_status.cur_bid), Status#player_status.cur_bid), 
% 	% mod_player.erl对战斗结束的处理中会把cur_bid字段重置为none，故这里加is_pid()的判断
% 	?IFC (is_pid(Status#player_status.cur_bid))
% 		Status#player_status.cur_bid ! {'QTE_RESULT', BattleObjId, Result, CheckCode, Status#player_status.sid}
% 	?END,
% 	void;


% %% 客户端通知服务端：客户端倒计时开始了
% handle(?PT_BT_CLIENT_COUNT_DOWN_START, Status, BattleObjId) ->
% 	?TRACE("PT_BT_CLIENT_COUNT_DOWN_START, bo id: ~p...~n", [BattleObjId]),
% 	?ASSERT(is_pid(Status#player_status.cur_bid), Status#player_status.cur_bid),
% 	% 这里为了做容错，判断一下
% 	?IFC (is_pid(Status#player_status.cur_bid))
% 		Status#player_status.cur_bid ! {'CLIENT_COUNT_DOWN_START', BattleObjId, Status#player_status.sid}
% 	?END,
% 	void;





% %% 中途加入战斗（此协议目前没用！）
% %% @para: TargetPlayerId => 目标玩家id（表示要加入谁的战斗）
% %%handle(?PT_BT_JOIN_BATTLE_MIDWAY, Status, TargetPlayerId) ->
% %%	?ASSERT(false),
% %%	% 自己是否在队伍中？
% %%	case lib_player:is_in_team(Status) of
% %%		false ->
% %%			?ASSERT(false),
% %%			skip;
% %%		true ->
% %%			% 自己是否在战斗中？
% %%			case lib_player:is_in_battle(Status) of
% %%				true ->
% %%					?ASSERT(false),
% %%					skip;
% %%				false ->
% %%					case lib_player:get_local_online_info(TargetPlayerId) of
% %%						null ->  % 对方不在线
% %%							skip;
% %%						R ->
% %%							MyTeamPid = Status#player_status.pid_team,
% %%							% 是否和对方在同一个队伍？
% %%							case MyTeamPid == R#ets_online.pid_team of
% %%								false ->
% %%									?ASSERT(false),
% %%									skip;
% %%								true ->
% %%									% 对方是否正在战斗中？
% %%    								case lib_player:is_in_battle(R) of
% %%    									false ->
% %%    										?ASSERT(false, TargetPlayerId),
% %%    										skip;
% %%    									true ->
% %%    										% 获取自己在队伍中的位置
% %%    										TeamInfo = mod_team_new:get_team_info(MyTeamPid),
% %%    										MyPosInTeamTroop = lib_team:get_pos_in_team_troop(TeamInfo, Status#player_status.id),
% %%    										% 发送消息给目标战斗进程
% %%    										TargetBattlePid = R#ets_online.cur_bid,
% %%    										?ASSERT(is_pid(TargetBattlePid), TargetBattlePid),
% %%    										TargetBattlePid ! {'JOIN_BATTLE_MIDWAY', ...}
% %%    								end
% %%							end
% %%					end
% %%			end
% %%	end;


% %% 请求自动战斗
% handle(?PT_BT_REQ_AUTO_BATTLE, Status, _) ->
% 	?ASSERT(not lib_player:is_in_auto_mf_mode(Status)), % 自动挂机状态下本身就是自动战斗，不需请求



% 			case Status#player_status.is_auto_battle of
% 				true -> % 已经是自动战斗了，跳过
% 					skip;
% 				false ->
% 					case lib_player:is_in_battle(Status)
% 					andalso is_pid(Status#player_status.cur_bid) of
% 						false ->
% 							?TRACE("not in battle when req auto battle ...~n"),
% 							skip;
% 						true ->
% 							Status#player_status.cur_bid ! {'REQ_AUTO_BATTLE', Status#player_status.id}
% 					end,
% 					NewStatus  = Status#player_status{is_auto_battle = true},
% 					{ok, no_save_online, NewStatus}
% 			end;


% %% 取消自动战斗
% handle(?PT_BT_CANCEL_AUTO_BATTLE, Status, _) ->

% 			case Status#player_status.is_auto_battle of
% 				false -> % 错误：不是自动战斗状态
% 					%%?ASSERT(false),
% 					skip;
% 				true ->
% 					% 取消自动战斗时，同时也会取消自动挂机
% 					mod_player:set_in_auto_mf_mode_flag(Status#player_status.pid, false),

% 					case lib_player:is_in_battle(Status) 
% 					andalso is_pid(Status#player_status.cur_bid) of
% 						false ->
% 							?TRACE("not in battle when cancel auto battle ...~n"),
% 							skip;
% 						true ->
% 							Status#player_status.cur_bid ! {'CANCEL_AUTO_BATTLE', Status#player_status.id}
% 					end,
% 					NewStatus  = Status#player_status{is_auto_battle = false},
% 					{ok, no_save_online, NewStatus}
% 			end;



% %% 查询挂机的技能组合
% handle(?PT_AM_QUERY_SKILL_COMB, Status, CombId) ->
% 	SkillComb = lib_hang:get_skill_comb(Status, CombId),
% 	{ok, BinData} = pt_20:write(?PT_AM_QUERY_SKILL_COMB, [Status, CombId, SkillComb]),
% 	lib_send:send_one(Status#player_status.socket, BinData);


% %% 查询玩家的自动挂机设置信息
% handle(?PT_AM_QUERY_MY_SET_INFO, Status, _) ->
% 	CombId = lib_hang:get_cur_use_skl_comb_id(Status),
% 	IsAutoBuyHpBag = lib_hang:is_auto_buy_hp_bag(Status),
% 	{ok, BinData} = pt_20:write(?PT_AM_QUERY_MY_SET_INFO, [CombId, IsAutoBuyHpBag]),
% 	lib_send:send_one(Status#player_status.socket, BinData);



% %% 设置挂机的技能组合
% handle(?PT_AM_SET_SKILL_COMB, Status, [CombId, SkillCount, SkillCombBin]) ->
% 	BinSize = byte_size(SkillCombBin),
% 	MaxBytes = 5 * ?MAX_SKILL_IN_COMB,  % 数字5表示：4字节的技能id和1字节的格子位置的字节之和
% 	case (BinSize > MaxBytes)
% 	orelse (BinSize /= 5 * SkillCount) of
% 		true ->
% 			?ASSERT(false, SkillCombBin),
% 			skip;
% 		false ->
% 			SkillComb = bin_to_skill_comb(SkillCombBin, SkillCount, []),
% 			case check_set_skill_combo(Status, CombId, SkillComb) of
% 				fail ->
% 					skip;
% 				ok ->
% 					?TRACE("PT_AM_SET_SKILL_COMB, SkillComb: ~p~n", [SkillComb]),
% 					NewStatus = lib_hang:set_skill_comb(Status, CombId, SkillComb),

% 					{ok, BinData} = pt_20:write(?PT_AM_SET_SKILL_COMB, [?RESULT_OK, CombId]),
% 					lib_send:send_one(Status#player_status.socket, BinData),

% 					% 更新玩家状态
% 					{ok, NewStatus}
% 			end
% 	end;





% %% 清空挂机的技能组合
% %%handle(?PT_AM_CLEAR_SKILL_COMB, Status, CombId) ->
% %%	case util:is_in_range(CombId, 1, ?MAX_SKILL_COMB_COUNT) of
% %%		false ->
% %%			?ASSERT(false, CombId),
% %%			skip;
% %%		true ->
% %%			NewStatus = lib_hang:clear_skill_comb(Status, CombId),
% %%			%%{ok, BinData} = pt_20:write(?PT_AM_CLEAR_SKILL_COMB, [?RESULT_OK, CombId]),
% %%			%%lib_send:send_one(Status#player_status.socket, BinData),
% %%			% 更新玩家状态
% %%			{ok, NewStatus}
% %%	end;


% %% 选择挂机所使用的技能组合
% handle(?PT_AM_SELECT_SKILL_COMB, Status, CombId) ->
% 	case util:is_in_range(CombId, 1, ?MAX_SKILL_COMB_COUNT) of
% 		false ->
% 			?ASSERT(false, CombId),
% 			skip;
% 		true ->
% 			NewStatus = lib_hang:select_skill_comb(Status, CombId),
% 			%%{ok, BinData} = pt_20:write(?PT_AM_SELECT_SKILL_COMB, [?RESULT_OK, CombId]),
% 			%%lib_send:send_one(Status#player_status.socket, BinData),
% 			% 更新玩家状态
% 			{ok, NewStatus}
% 	end;


% %% 设置挂机的怒气上限
% %%handle(?PT_AM_SET_ANGER_LIM, Status, AngerLim) ->
% %%	case util:is_in_range(AngerLim, 1, ?MAX_BO_ANGER) of
% %%		false ->
% %%			?ASSERT(false, AngerLim),
% %%			skip;
% %%			%%{ok, BinData} = pt_20:write(?PT_AM_SET_ANGER_LIM, [?RESULT_FAIL, AngerLim]),
% %%			%%lib_send:send_one(Status#player_status.socket, BinData);
% %%		true ->
% %%			NewStatus = lib_hang:set_anger_lim(Status, AngerLim),
% %%			%%{ok, BinData} = pt_20:write(?PT_AM_SET_ANGER_LIM, [?RESULT_OK, AngerLim]),
% %%			%%lib_send:send_one(Status#player_status.socket, BinData),
% %%			% 更新玩家状态
% %%			{ok, NewStatus}
% %%	end;



% %% 尝试添加新的已学技能到技能组合中
% handle(?PT_AM_TRY_ADD_NEW_SKILLS_TO_COMB, Status, [CombId, SkillCount, SkillIdList_Bin]) ->
% 	case util:is_in_range(CombId, 1, ?MAX_SKILL_COMB_COUNT) of
% 		false ->
% 			?ASSERT(false, CombId),
% 			skip;
% 			%%{ok, BinData} = pt_20:write(?PT_AM_SET_ANGER_LIM, [?RESULT_FAIL, AngerLim]),
% 			%%lib_send:send_one(Status#player_status.socket, BinData);
% 		true ->
% 			BinSize = byte_size(SkillIdList_Bin),
% 			MaxBytes = 4 * ?MAX_SKILL_IN_COMB,  % 数字4表示：协议中的技能id为4字节
% 			case (BinSize > MaxBytes)
% 			orelse (BinSize /= 4 * SkillCount) of
% 				true ->
% 					?ASSERT(false),
% 					skip;
% 				false ->
% 					CurSkillIdList = bin_to_skill_id_list(SkillIdList_Bin, SkillCount, []),
% 					?TRACE("PT_AM_TRY_ADD_NEW_SKILLS_TO_COMB, CurSkillIdList: ~p~n", [CurSkillIdList]),
% 					% 获取可添加到组合的新的技能id
% 					CanAddSkillIdList = lib_hang:get_can_add_to_comb_recommend_skills(Status, CurSkillIdList),
% 					?TRACE("CanAddSkillIdList: ~p~n", [CanAddSkillIdList]),
% 					{ok, BinData} = pt_20:write(?PT_AM_TRY_ADD_NEW_SKILLS_TO_COMB, [Status, CombId, CanAddSkillIdList]),
% 					lib_send:send_one(Status#player_status.socket, BinData)
% 			end
% 	end;


% %% 设置是否自动购买气血包
% handle(?PT_AM_SET_AUTO_BUY_HP_BAG, Status, Flag) ->
% 	?ASSERT(Flag == 1 orelse Flag == 0),
% 	case lib_player:is_vip(Status) of
% 		false ->
% 			?ASSERT(false),
% 			skip;
% 		true ->
% 			Flag_Bool = util:int_to_bool(Flag),
% 			NewStatus = lib_hang:set_auto_buy_hp_bag(Status, Flag_Bool),
% 			{ok, BinData} = pt_20:write(?PT_AM_SET_AUTO_BUY_HP_BAG, [?RESULT_OK, Flag]),
% 			lib_send:send_one(Status#player_status.socket, BinData),
% 			% 更新玩家状态
% 			{ok, NewStatus}
% 	end;



% %% @desc: 获取玩家的技能球选择结果
% handle(?PT_BT_SKILL_BALL_RESULT, Status, [SkillBallId, Lv]) -> 
%     case is_pid( Status#player_status.cur_bid ) andalso lib_battle:check_skill_ball_lv(Lv) of
%         false -> 
%             skip;
%         true ->  
%             Status#player_status.cur_bid ! {'SKILL_BALL_RESULT', SkillBallId, Lv, Status#player_status.sid, {}, ?RESULT_OK}
%     end,
%     void;

% %% @desc: 
% handle(?PT_AM_FORCE_EXIT_BATTLE, Status, _) ->
%     mod_battle:stop_cur_battle(Status);


handle(_Cmd, _PS, _Data) ->
	?ASSERT(false, _Cmd),
    {error, not_match}.










% %% ========================================== Local Functions =========================================    







%% 操作的合法性检测：是否可以打怪？
check_start_mf(PS, MonId) ->
	try
		check_start_mf__(PS, MonId)
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.




check_start_mf__(PS, MonId) ->
	% 若在队伍中，则只能由队长操作
	?Ifc (player:is_in_team_but_not_leader(PS) andalso (not player:is_tmp_leave_team(PS)))
        throw(cli_msg_illegal)
    ?End,

	% 怪物是否存在？
	?Ifc (not mod_mon:is_exists(MonId))
		?ASSERT(false),
		throw(?PM_UNKNOWN_ERR)
	?End,

    ?Ifc(lib_scene:is_home_scene(player:get_scene_id(PS))  andalso (lib_home:get_home(player:id(PS)) =:= false) )
         throw(?PM_HOME_NOT_YET)
    ?End,



	% 玩家与怪物是否在同一场景？
	PlayerPos = player:get_position(PS),
	Mon = mod_mon:get_obj(MonId),
	?Ifc (PlayerPos#plyr_pos.scene_id /= mod_mon:get_scene_id(Mon))
		% ?ASSERT(false),
		% throw(?PM_UNKNOWN_ERR)
		pass   % 直接通过，不再对此做检测
	?End,

	% 玩家和怪物的距离是否过远？
	{MonX, MonY} = mod_mon:get_xy(Mon),
	AttDist = ?PLAYER_ATT_DISTANCE * 2,  % 为了放宽限制，故放大两倍         %%player:get_att_distance(PS),
	?Ifc (abs(MonX - PlayerPos#plyr_pos.x) > AttDist
	orelse abs(MonY - PlayerPos#plyr_pos.y) > AttDist)
		?ASSERT(false, {MonX, MonY, PlayerPos}),
		throw(?PM_UNKNOWN_ERR)
	?End,

	% 玩家当前是否空闲？
	?Ifc (not player:is_idle(PS))
		throw(?PM_BUSY_NOW)
	?End,


	% % 如果在队伍中，是否为队长？
	% ?Ifc (player:is_in_team(PS) andalso (not player:is_leader(PS)))
	% 	throw(?PM_NOT_TEAM_LEADER)
	% ?End,

	% % 怪物当前是否在战斗中？
	% ?Ifc (mod_mon:is_battling(Mon))
	% 	throw(?PM_BT_MON_BATTLING)
	% ?End,

	?Ifc (mod_mon:is_battling(Mon) andalso (not mod_mon:can_concurrent_battle(Mon)))
		throw(?PM_BT_MON_BATTLING)
	?End,

	% ?Ifc (mod_mon:is_expired(Mon))
	% 	throw(?PM_BT_MON_ALRDY_EXPIRED)
	% ?End,

	ok.



is_valid_pk_type(PK_Type) ->
	PK_Type == ?PK_T_QIECUO orelse PK_Type == ?PK_T_FORCE.


check_start_pk(PS, TargetPlayerId, PK_Type) ->
	try
		check_start_pk__(PS, TargetPlayerId, PK_Type)
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

check_start_pk__(PS, TargetPlayerId, PK_Type) ->
	?Ifc (not is_valid_pk_type(PK_Type))
		?ASSERT(false),
		throw(cli_msg_illegal)
	?End,

	?Ifc (TargetPlayerId =:= player:id(PS))
		?ASSERT(false),
		throw(cli_msg_illegal)
	?End,

	?Ifc (player:is_in_team_but_not_leader(PS) andalso (not player:is_tmp_leave_team(PS)))
		?ASSERT(false),
		throw(cli_msg_illegal)
	?End,

	?Ifc (not player:is_idle(PS))
		throw(?PM_BUSY_NOW)
	?End,

	?Ifc (not player:is_online(TargetPlayerId))
		throw(?PM_TARGET_PLAYER_NOT_ONLINE)
	?End,

	TargetPS = player:get_PS(TargetPlayerId),
	?Ifc (not player:is_idle(TargetPS))
		throw(?PM_BT_TARGET_CANNOT_FIGHT_WITH_YOU)
	?End,

	?Ifc (player:are_in_same_team(PS, TargetPS))
		throw(?PM_BT_CANNOT_START_PK_TO_TEAMMATE)
	?End,

	case PK_Type of
		?PK_T_QIECUO ->
			?Ifc (not ply_setting:accept_pk(TargetPlayerId))
				throw(?PM_BT_TARGET_NOT_ACCEPT_QIECUO_PK)
			?End,

			?Ifc (not ply_scene:is_in_leitai_area(PS))
				throw(?PM_BT_NOT_IN_LEITAI_AREA)
			?End,

			?Ifc (not ply_scene:is_in_leitai_area(TargetPS))
				throw(?PM_BT_TARGET_NOT_IN_LEITAI_AREA)
			?End;

			% ?Ifc (player:is_in_team_but_not_leader(TargetPS) andalso (not player:is_tmp_leave_team(TargetPS)))
			% 	throw(?PM_BT_START_QIECUO_FAIL_FOR_TARGET_IN_TEAM_BUT_NOT_LEADER)
			% ?End;
		?PK_T_FORCE ->
			?Ifc (not ply_sys_open:is_open(PS, ?SYS_FORCE_PK))
				throw(?PM_BT_PK_LV_LIMIT)
			?End,

			?Ifc (not ply_sys_open:is_open(TargetPS, ?SYS_FORCE_PK))
				throw(?PM_BT_TARGET_PK_LV_LIMIT)
			?End,

			% ?Ifc (player:is_in_team_and_not_tmp_leave(PS))
		 %        ?TRACE("in team and not tmp leave, so cannot start force pk.....~n"),
		 %        throw(?PM_BT_START_FORCE_PK_FAIL_FOR_IN_TEAM)
		 %    ?End,

		 %    ?Ifc (player:is_in_team_and_not_tmp_leave(TargetPS))
			% 	throw(?PM_BT_START_FORCE_PK_FAIL_FOR_TARGET_IN_TEAM)
			% ?End,
			%% 野外等级差超过10级无法决斗
			% ?Ifc (not player:is_in_melee_scene(PS))
			% 	case player:is_in_dungeon(PS) of
			% 		false -> throw(?PM_BT_PK_DELTA_LV_LIMIT);
			% 		_ -> skip
			% 	end
			% ?End,
            % 女妖乱斗 离队后1分钟内无法发起决斗
            ?Ifc (mod_buff:has_buff(player, player:id(PS), ?BNO_MELEE_LEAVE_TEAM))
				throw(?PM_MELEE_ERROR_LEAVE_TEAM_CANT_BATTLE)
			?End,

            % 女妖乱斗 踢出队员后1分钟内无法发起决斗
            ?Ifc (mod_buff:has_buff(player, player:id(PS), ?BNO_MELEE_TICK_OUT_MEMBER))
				throw(?PM_MELEE_ERROR_TICK_TEAM_MEMBER_CANT_BATTLE)
			?End,

			?Ifc (mod_buff:has_buff(player, TargetPlayerId, ?BFN_PK_PROTECT))
				throw(?PM_BT_TARGET_PK_PROTECT)
			?End
			end,
			% 以后需要优化，玩家在房间状态需要同步到本服
			case sm_cross_client_sup:get_child_pids() of
         	[] ->
	            {ok, TargetPS};
         	_ ->
	           case lib_cross:check_is_mirror() of
                 	?true ->
	                    case lib_pvp:is_in_room(TargetPlayerId) of
	                        false ->
                             	{ok, TargetPS};
	                        true ->
	                            throw(?PM_IS_IN_3V3_PVP)
                    	end;
	                ?false ->
                    	case sm_cross_server:rpc_call(lib_pvp, is_in_room, [TargetPlayerId]) of
	                         {ok, false} ->
	                             {ok, TargetPS};
	                         {ok, true} ->
	                             throw(?PM_IS_IN_3V3_PVP)
                    	end
	           end
	    end .





check_prepare_cmd_use_goods(PS, _ForBoId, GoodsId) ->
	% 是否有这个物品？
	case mod_inv:find_goods_by_id(PS, GoodsId, ?LOC_BAG_USABLE) of
		null ->
			?ASSERT(false, GoodsId),
			{fail, ?PC_FAIL_NO_SUCH_GOODS};
		Goods ->
			% 物品是否可以在战斗中使用？
			case lib_goods:is_can_use_in_battle(Goods) of
				false ->
					?ASSERT(false, Goods),
					{fail, ?PC_FAIL_GOODS_CANNOT_USE_IN_BATTLE};
				true ->
					{ok, Goods}
			end
	end.



ask_if_accept_pk(FromPS, TargetPS, PK_Type) ->
	{ok, Bin} = pt_20:write(?PT_BT_ASK_IF_ACCPET_PK, [FromPS, PK_Type]),
	case player:is_in_team_but_not_leader(TargetPS) andalso (not player:is_tmp_leave_team(TargetPS)) of
		true ->
			% 转为发给队长
			LeaderId = player:get_leader_id(TargetPS),
			lib_send:send_to_uid(LeaderId, Bin);
		false ->
			lib_send:send_to_sock(TargetPS, Bin)
	end.



notify_pk_invite_refused(FromPlayerId, PS, PK_Type) ->
	{ok, Bin} = pt_20:write(?PT_BT_NOTIFY_PK_INVITE_REFUSED, [PS, PK_Type]),
	lib_send:send_to_uid(FromPlayerId, Bin).



% check_prepare_cmd_summon_partner(PS, PartnerId) ->
% 	% 是否有这个宠物
% 	case player:has_partner(PS, PartnerId) of
% 		false ->
% 			{fail, ?PC_FAIL_NO_SUCH_PARTNER};
% 		true ->
% 			ok
% 	end.



% check_use_normal_att(_PS) ->
% 	todo_here,
% 	ok.

% % TODO: 合法性检测：  技能是否已解锁等
% check_use_skill(_PS, _SkillId) ->
% 	todo_here,

% 	ok.




% %%获得重生点的坐标
% get_revive_pos(Scene, Status) ->
%     L =Scene#ets_scene.revive,
%     case L of
%         [] ->
%             [Status#player_status.x, Status#player_status.y];
%         [[X,Y]|T] ->
%             F = fun([X1, Y1], [X2, Y2]) ->
%                     if abs(X1 - Status#player_status.x) < abs(X2 - Status#player_status.x) ->
%                             [X1, Y1];
%                         true ->
%                             [X2, Y2]
%                     end
%             end,
%             lists:foldl(F, [X,Y], T)
%     end.

% %% 怪物是世界BOSS
% is_mon_world(_Mon) ->
% 	false.
% %% 	Mon#ets_mon.type == ?BMON_WORLD_BOSS.




% %% 强行在线pk（仅仅用于方便测试）
% %%force_pk(PlayerA, PlayerB) ->
% %%	?TRACE("force Pk!!!!!~n"),
% %%	mod_player:enter_battle(PlayerB#player_status.pid, PlayerA#player_status.bid),
% %%	mod_battle:pk_online(PlayerA#player_status.bid, [PlayerA, PlayerB], ?BAT_SUB_T_NONE),
% %%	NewStatus = lib_player:enter_battle(PlayerA, PlayerA#player_status.bid),
% %%	{ok, lib_player:set_pk_der_id(NewStatus, PlayerB#player_status.id)}.




% %% 对设置挂机技能组合做合法性检查
% %% @return: fail | ok	
% check_set_skill_combo(PS, CombId, SkillComb) ->
% 	case util:is_in_range(CombId, 1, ?MAX_SKILL_COMB_COUNT) of
% 		false ->
% 			?ASSERT(false, CombId),
% 			fail;
% 		true ->
% 			case length(SkillComb) =< ?MAX_SKILL_IN_COMB of
% 				false ->
% 					?ASSERT(false, SkillComb),
% 					fail;
% 				true ->
% 					SkillIdList = [SkillId || {SkillId, _Grid} <- SkillComb],
% 					GridList = [Grid || {_SkillId, Grid} <- SkillComb],
% 					% 判断玩家是否学习了对应的技能，防止客户端欺骗
% 					List1 = [X || X <- SkillIdList, not lib_player:already_learned_skill(PS, X)],
% 					List2 = [X || X <- GridList, (X < 1) orelse (X > ?MAX_SKILL_IN_COMB)],
% 					case List1 /= [] orelse List2 /= [] of
% 						true ->
% 							?ASSERT(false, {List1, List2}),
% 							fail;
% 						false ->
% 							ok
% 					end
% 			end
% 	end.


% %% desc: 设置死亡复活位置
% change_pos_when_dead(Status, 0) ->
%     Scene = data_scene:get(lib_scene:get_res_id(Status#player_status.scene)),
%     [X, Y] = pp_battle:get_revive_pos(Scene, Status),
%     Status#player_status{x = X, y = Y};
% change_pos_when_dead(Status, _) -> Status.

% %% internal
% %% @desc: 处理pk分类
% %% 传递参数进行战斗类型的判断，只能同时进行一场类型的战斗
% %% 这种做法将导致至少有一场战斗发生
% handle_battle_pk_type(MyStatus, ObjState) ->
%     % 帮会PVP检查及战斗
%     {IsGuildPk, Result} = battle_guild_pk(MyStatus, ObjState),

%     % 大富翁检查及战斗，返回 (前一次类型是否战斗 orelse 是否大富翁PK)
%     {IsRichPk, Result1} = battle_rich_pk(MyStatus, ObjState, IsGuildPk, Result),

%     %% 诸神PVP检查及战斗 返回 (前一次类型是否战斗 orelse 是否诸神PK)
%     {IsGodsPk, Result2} = battle_gods_pk(MyStatus, ObjState, IsRichPk, Result1),

%     % gm指令战斗/普通pk
%     case IsGodsPk == ?BOOL_FALSE of 
%         true ->       
%             Dict = lib_battle:get_dict_gm_before_battle(),
%             case is_record(Dict, gm_before_battle) andalso Dict#gm_before_battle.pk_state == ?TURN_ON of
%                 true ->
%                     set_pk_state(MyStatus, ObjState, ?BAT_SUB_T_GUILD_PK_ONLINE);   
%                 false ->
%                     Result2
%             end;
%         false ->      
%             Result2
%     end.

% %% internal
% %% @desc: 帮会战在线PK
% %% @returns: {PkState, Ret}
% %% PkState: 是否帮会在线PK
% %% Ret: skip | {ok, NewPS}
% battle_guild_pk(MyStatus, ObjState) ->
%     case lib_player:is_in_guild_pvp(MyStatus) of   
%         true ->
%             case catch gen_server:call(mod_guild_pvp:rand_pid(), {'can_pvp_battle', MyStatus, ObjState}, 2000) of
%                 {'EXIT', Reason} ->
%                     ?ERROR_MSG("=== 20002 guild_pvp can_pvp_battle EXIT:~p ===~n", [Reason]), ?ASSERT(false),
%                     {?BOOL_TRUE, skip};
%                 {false, Reason} ->
%                     mod_battle:battle_fail(MyStatus#player_status.socket, Reason),
%                     {?BOOL_TRUE, skip};
%                 true ->
%                     Res = set_pk_state(MyStatus, ObjState, ?BAT_SUB_T_GUILD_PK_ONLINE),
%                     {?BOOL_TRUE, Res}
%             end;
%         false ->
%             {?BOOL_FALSE, skip}
%     end.


% %% internal
% %% @desc: 诸神在线PK
% %% @returns: {PkState, Ret}
% %% PkState: 是否帮会在线PK
% %% Ret: skip | {ok, NewPS}
% battle_gods_pk(MyStatus, ObjState, IsPrevPkMatch, Result) ->
%     case IsPrevPkMatch == ?BOOL_FALSE andalso lib_player:is_in_gods_pvp_scene(MyStatus) of   
%         true ->
%             case catch gen_server:call(mod_gods_pvp:rand_pid(), {'can_pvp_battle', MyStatus, ObjState}, 2000) of
%                 {'EXIT',_Reason} ->
%                     ?TRACE("=== 20002 gods_pvp can_pvp_battle EXIT:~p ===~n", [_Reason]),
%                     {?BOOL_TRUE, skip};
%                 {true} ->
%                      Res = set_pk_state(MyStatus, ObjState, ?BAT_SUB_T_GODS_PK_ONLINE),
%                      {?BOOL_TRUE, Res};
%                 {false, Reason} ->
%                     ?TRACE_W("=== 20002 gods_pvp can_pvp_battle false:~s ===~n", [Reason]),
%                     mod_battle:battle_fail(MyStatus#player_status.socket, Reason),
%                     {?BOOL_TRUE, skip}
%             end;                     
%         false ->
%             case lib_player:is_in_gods_pvp_scene(MyStatus) of
%                 true  -> ?ASSERT(false),
%                          ?ERROR_MSG("should be gods pvp: mystatus: ~p, ObjState: ~p ~n", [MyStatus, ObjState]);
%                 false -> skip
%             end,
%             {IsPrevPkMatch, Result}
%     end.

% %% internal
% %% @desc: 大富翁在线pk
% battle_rich_pk(MyStatus, ObjState, IsGuildPk, Result) ->
%     IsRichPk = util:bool_to_int( lib_player:is_in_rich(MyStatus) ),
%     case IsGuildPk == ?BOOL_FALSE andalso IsRichPk == ?BOOL_TRUE of   
%         true ->
%             Res1 = set_pk_state(MyStatus, ObjState, ?BAT_SUB_T_RICH_PK_ONLINE),
%             {?BOOL_TRUE, Res1};
%         false ->
%             {IsGuildPk, Result}
%     end.

% %% internal
% %% @desc: pk设置
% set_pk_state(MyStatus, ObjState, BattleSubType) ->
%     mod_player:enter_battle(ObjState#player_status.pid, MyStatus#player_status.bid),
%     NewMyStatus = lib_player:enter_battle(MyStatus, MyStatus#player_status.bid),

%     mod_battle:pk_online(NewMyStatus#player_status.cur_bid, [NewMyStatus, ObjState], BattleSubType),
%     {ok, lib_player:set_pk_der_id(NewMyStatus, ObjState#player_status.id)}.


% %% 
% bin_to_skill_comb(BinData, N, AccList) when N > 0 ->
% 	<<SkillId:32, Grid:8, Tail/binary>> = BinData,
% 	NewAccList = AccList ++ [{SkillId, Grid}],
% 	bin_to_skill_comb(Tail, N - 1, NewAccList);
% bin_to_skill_comb(_BinData, _N, AccList) ->
% 	AccList.




% bin_to_skill_id_list(BinData, N, AccList) when N > 0 ->
% 	<<SkillId:32, Tail/binary>> = BinData,
% 	NewAccList = AccList ++ [SkillId],
% 	bin_to_skill_id_list(Tail, N - 1, NewAccList);
% bin_to_skill_id_list(_BinData, _N, AccList) ->
% 	AccList.
	
