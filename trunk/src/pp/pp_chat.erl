%%%--------------------------------------
%%% @Module  : pp_chat
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2011.05.06
%%% @Modified: 2013.10 -- LDS
%%% @Description:  聊天系统
%%%--------------------------------------
-module(pp_chat).
-export([handle/3, notify_follower_chat_info/2]).
-include("common.hrl").
-include("record.hrl").
-include("framework.hrl").
-include("offline_data.hrl").
-include("prompt_msg_code.hrl").
-include("log.hrl").
-include("priv.hrl").
-include("ets_name.hrl").

-include("pt_11.hrl").

% -define(MAX_CONTACTS,10).
% -define(BUGLEID,600100001).

-define(MSG_OVERLENGTH, 0).
-define(DEF_ERROR_STATE, 1).
-define(HORN_COST, 1).

-define(CHAT_WORLD_LV, 40).
-define(CHAT_CROSS_SERVER_LV, 100).
-define(CHAT_CURRENT_LV, 10).

-define(CHAT_WORLD_CONS_VITALITY, 5).

%%世界
handle(?PT_WORLD, Status1, [Type, Msg1]) when is_record(Status1, player_status) ->
    %%%?HANDLE_CHAT_MSG_AS_GM_CMD(Status, Msg),

    F = fun(Status,Msg) ->
			TypeLimit = case Type of
					 		2 -> true;
					 		_ -> false
				 		end,
			%% 如果是组队一键喊话免除等级限制
            case TypeLimit orelse fit_lv(Status, ?CHAT_WORLD_LV) of
                true ->
                    case TypeLimit orelse player:has_enough_vitality(Status,?CHAT_WORLD_CONS_VITALITY) of
                        true ->
							case TypeLimit orelse lib_chat:check_chat_permission(Status) of
								true ->
									case lib_chat:parse_msg_array(Msg) of
										{true, NewMsg} ->
											% ?LDS_TRACE(?PT_WORLD, [NewMsg]),
											Stamp = util:unixtime(),
											case lib_chat:in_chat_cd(?PT_WORLD, Stamp, Status) of
												false ->
													case lib_chat:chat_filter(player:get_id(Status1), NewMsg) of
														ok ->
															% ?LDS_TRACE(?PT_WORLD, "not in cd"),
															case TypeLimit of
																true -> skip;
																false ->
																	player:cost_vitality(Status,?CHAT_WORLD_CONS_VITALITY,[?LOG_CHAT, "world talk"])
															end,
															mod_achievement:notify_achi(world_talk, [{num, 1}], Status),
															lib_chat:set_chat_cd(?PT_WORLD, Stamp),
															{ok, BinData} = pt_11:write(?PT_WORLD, [player:id(Status), NewMsg, 
																									lib_chat:get_identify(Status), player:get_name(Status), ply_priv:get_priv_lv(Status),player:get_race(Status),player:get_sex(Status),player:get_dan(Status)]),
															access_queue_svr:broadcast(BinData),
															
															mod_achievement:notify_achi(talk_world, [], Status),
															
															Channel = ?ENUM_CHAT_TYPE_WORLD,
															mod_udp:chat_monitor(Channel, Msg, Status);
														error ->
															skip
													end;
												% lib_send:send_to_all(BinData);
												true ->
													% ?LDS_TRACE(?PT_WORLD, "in cd"),
													lib_chat:send_error_state(Status, ?PT_WORLD, ?DEF_ERROR_STATE)
											end;
										{false, _} -> 
											lib_chat:send_error_state(Status, ?PT_WORLD, ?MSG_OVERLENGTH)
									end;
								false ->
									%% 没充值
									lib_send:send_prompt_msg(Status, ?PM_CHAT_NEED_RECHARGE)
							end;
                        false -> 
                            % ?DEBUG_MSG("PM_VITALITY_LIMIT",[]),
                            lib_send:send_prompt_msg(Status, ?PM_VITALITY_LIMIT)
                            % lib_chat:send_error_state(Status, ?PT_WORLD, ?PM_VITALITY_LIMIT)
                    end;
                false -> skip
            end
    end,

    % 尝试当gm指令处理
    % case config:can_use_gm_cmd(?APP_SERVER) of
    %     true -> ?TRACE("can gm cmd.....~n"), 
    case ply_priv:get_priv_lv(Status1) of
        2 -> 
            case lib_gm:handle_chat_msg_as_gm_cmd(Status1, Msg1) of
                ok -> skip;
                fail -> 
                    F(Status1,Msg1)
            end;
        _ ->
            case config:can_use_gm_cmd(?APP_SERVER) of
                true -> 
                    case lib_gm:handle_chat_msg_as_gm_cmd(Status1, Msg1) of
                        ok -> skip;
                        fail -> 
                            F(Status1,Msg1)
                    end;
                false ->
                    F(Status1,Msg1) 
            end
    end,
    %     false ->             
    % end,
    
    ok;

%% 跨服聊天
handle(?PT_CHAT_CROSS_SERVER, Status1, [Type, Msg1]) when is_record(Status1, player_status)->
    F = fun(Status,Msg) ->
		TypeLimit = case Type of
						2 -> true;
						_ -> false
					end,
		%% 如果是组队一键喊话免除等级限制
        case TypeLimit orelse fit_lv(Status, ?CHAT_CROSS_SERVER_LV) of
            true ->
                case TypeLimit orelse player:has_enough_vitality(Status,?CHAT_WORLD_CONS_VITALITY) of
                    true ->
                        {_GoodsNo, GoodsNum} = data_special_config:get('server_talk'),
                        case TypeLimit orelse player:has_enough_integral(Status, GoodsNum) of
                            true ->
                                case TypeLimit orelse lib_chat:check_chat_permission(Status) of
                                    true ->
                                        case lib_chat:parse_msg_array(Msg) of
                                            {true, NewMsg} ->
                                                % ?LDS_TRACE(?PT_WORLD, [NewMsg]),
                                                Stamp = util:unixtime(),
                                                case lib_chat:in_chat_cd(?PT_CHAT_CROSS_SERVER, Stamp, Status) of
                                                    false ->
                                                        case lib_chat:chat_filter(player:get_id(Status1), NewMsg) of
                                                            ok ->
                                                                % ?LDS_TRACE(?PT_WORLD, "not in cd"),
                                                                ServerId = config:get_server_id(),
                                                                Id = integer_to_list(Status#player_status.id),
                                                                BeforeMergeServerId = list_to_integer(lists:sublist(Id, 1, 5)),
																case TypeLimit of
																	true -> skip;
																	false ->
																		player:cost_vitality(Status,?CHAT_WORLD_CONS_VITALITY,[?LOG_CHAT, "coss server talk"]),
																		player:cost_integral(Status, GoodsNum, [?LOG_CHAT, "coss server talk"])
																end,

                                                                lib_chat:set_chat_cd(?PT_CHAT_CROSS_SERVER, Stamp),

                                                                {ok, BinData} = pt_11:write(?PT_CHAT_CROSS_SERVER, [player:id(Status), NewMsg,
                                                                    lib_chat:get_identify(Status), player:get_name(Status), ply_priv:get_priv_lv(Status),player:get_race(Status),
                                                                    player:get_sex(Status), ServerId, BeforeMergeServerId, player:get_dan(Status)]),

%%                                                        access_queue_svr:broadcast(BinData),
                                                                sm_cross_server:rpc_cast([], lib_send, send_to_all, [BinData]),

%%                                                        mod_achievement:notify_achi(talk_world, [], Status),
                                                                
																Channel = ?ENUM_CHAT_TYPE_CROSS,
																mod_udp:chat_monitor(Channel, Msg, Status);
                                                            error ->
                                                                skip
                                                        end;
                                                    % lib_send:send_to_all(BinData);
                                                    true ->
                                                        % ?LDS_TRACE(?PT_WORLD, "in cd"),
                                                        lib_chat:send_error_state(Status, ?PT_CHAT_CROSS_SERVER, ?DEF_ERROR_STATE)
                                                end;
                                            {false, _} ->
                                                lib_chat:send_error_state(Status, ?PT_CHAT_CROSS_SERVER, ?MSG_OVERLENGTH)
                                        end;
                                    false ->
                                        %% 没充值
                                        lib_send:send_prompt_msg(Status, ?PM_CHAT_NEED_RECHARGE)
                                end;
                            false ->
                                lib_send:send_prompt_msg(Status, ?PM_INTEGRAL_LIMIT)
                        end;
                    false ->
                        % ?DEBUG_MSG("PM_VITALITY_LIMIT",[]),
                        lib_send:send_prompt_msg(Status, ?PM_VITALITY_LIMIT)
                        % lib_chat:send_error_state(Status, ?PT_WORLD, ?PM_VITALITY_LIMIT)
                end;
            false -> skip
        end
    end,

    % 尝试当gm指令处理
    % case config:can_use_gm_cmd(?APP_SERVER) of
    %     true -> ?TRACE("can gm cmd.....~n"),
    case ply_priv:get_priv_lv(Status1) of
        2 ->
            case lib_gm:handle_chat_msg_as_gm_cmd(Status1, Msg1) of
                ok -> skip;
                fail ->
                    F(Status1,Msg1)
            end;
        _ ->
            case config:can_use_gm_cmd(?APP_SERVER) of
                true ->
                    case lib_gm:handle_chat_msg_as_gm_cmd(Status1, Msg1) of
                        ok -> skip;
                        fail ->
                            F(Status1,Msg1)
                    end;
                false ->
                    F(Status1,Msg1)
            end
    end,
    ok;



%%私聊
handle(?PT_PERSONAL, Status, [ToId, Msg]) ->
    case lib_chat:parse_msg_array(Msg) of
        {true, NewMsg} ->
			case player:get_lv(Status) >= 100 of
				?true ->
					case lib_chat:chat_filter(player:get_id(Status), NewMsg) of
						ok ->
							% ?LDS_TRACE(?PT_PERSONAL, [NewMsg]),
							case player:get_sendpid(ToId) of
								Pid when is_pid(Pid) ->
									{ok, BinData} = pt_11:write(?PT_PERSONAL, [player:id(Status), NewMsg, 
																			   lib_chat:get_identify(Status), player:get_name(Status), ToId, ply_priv:get_priv_lv(Status),player:get_race(Status),player:get_sex(Status)]),
									lib_send:send_to_sid(player:get_sendpid(Status), BinData),
									lib_send:send_to_sid(Pid, BinData),
									
									mod_achievement:notify_achi(talk_personal, [], Status),
									
									Channel = ?ENUM_CHAT_TYPE_PERSON,
									PlayerId2 = ToId,
									mod_udp:chat_monitor(Channel, Msg, Status, PlayerId2);
								
								% lib_send:send_to_sock(Status#player_status.socket, BinData);
								_ ->
									lib_chat:send_error_state(Status, ?PT_PERSONAL, ?DEF_ERROR_STATE)
							end;
						error ->
							skip
					end;
				?false ->
					lib_send:send_prompt_msg(Status, ?PM_LV_LIMIT)
			end;
        {false, _} ->
            lib_chat:send_error_state(Status, ?PT_PERSONAL, ?MSG_OVERLENGTH)
    end;


%%当前
handle(?PT_CURRENT, Status, [Msg]) ->
    case fit_lv(Status, ?CHAT_CURRENT_LV) of
        true ->
            case lib_chat:parse_msg_array(Msg) of
                {true, NewMsg} ->
					case lib_chat:chat_filter(player:get_id(Status), NewMsg) of
						ok ->
							% ?LDS_TRACE(?PT_CURRENT, [NewMsg]),
							{ok, BinData} = pt_11:write(?PT_CURRENT, [player:id(Status), NewMsg, 
																	  lib_chat:get_identify(Status), player:get_name(Status), ply_priv:get_priv_lv(Status),player:get_race(Status),player:get_sex(Status)]),
							lib_send:send_to_AOI(player:id(Status), BinData),
							
							mod_achievement:notify_achi(talk_current, [], Status),
							
							Channel = ?ENUM_CHAT_TYPE_CURRENT,
							mod_udp:chat_monitor(Channel, Msg, Status);
						error ->
							skip
					end;

                {false, _} ->
                    lib_chat:send_error_state(Status, ?PT_CURRENT, ?MSG_OVERLENGTH)
            end;
        false -> skip
    end,
    ok;


%%帮派
handle(?PT_GUILD, Status, [Msg]) ->
    case lib_chat:parse_msg_array(Msg) of
        {true, NewMsg} ->
            case player:is_in_guild(Status) of
                true ->
					case lib_chat:check_chat_permission(Status) of
						true ->
							case lib_chat:chat_filter(player:get_id(Status), NewMsg) of
								ok ->
									{ok, BinData} = pt_11:write(?PT_GUILD, [player:id(Status), NewMsg, 
																			lib_chat:get_identify(Status), player:get_name(Status), ply_priv:get_priv_lv(Status),player:get_race(Status),player:get_sex(Status),mod_guild:get_guild_pos(Status),player:get_dan(Status)]),
									lib_send:send_to_guild(Status, BinData),
									
									mod_achievement:notify_achi(talk_guild, [], Status),
									
									Channel = ?ENUM_CHAT_TYPE_GUILD,
									mod_udp:chat_monitor(Channel, Msg, Status);
								error ->
									skip
							end;
						false ->
							lib_send:send_prompt_msg(Status, ?PM_CHAT_NEED_RECHARGE)
					end;
                false ->
                    lib_chat:send_error_state(Status, ?PT_GUILD, ?DEF_ERROR_STATE)
            end;
        {false, _} ->
            lib_chat:send_error_state(Status, ?PT_GUILD, ?MSG_OVERLENGTH)
    end;


%%队伍
handle(?PT_TEAM, Status, [Msg]) ->
    ?LDS_TRACE(?PT_TEAM, begine),
    case lib_chat:parse_msg_array(Msg) of
        {true, NewMsg} ->
            case player:is_in_team(Status) of
				true ->
					case lib_chat:chat_filter(player:get_id(Status), NewMsg) of
						ok ->
							?LDS_TRACE(?PT_TEAM, NewMsg),
							{ok, BinData} = pt_11:write(?PT_TEAM, [player:id(Status), NewMsg, 
																   lib_chat:get_identify(Status), player:get_name(Status), ply_priv:get_priv_lv(Status),player:get_race(Status),player:get_sex(Status),player:get_dan(Status)]),
							lib_send:send_to_team(Status, BinData),
							
							mod_achievement:notify_achi(talk_team, [], Status),
							
							Channel = ?ENUM_CHAT_TYPE_TEAM,
							mod_udp:chat_monitor(Channel, Msg, Status);
						error ->
							skip
					end;

                false ->
                    lib_chat:send_error_state(Status, ?PT_TEAM, ?DEF_ERROR_STATE)
            end;
        {false, _} ->
            lib_chat:send_error_state(Status, ?PT_TEAM, ?MSG_OVERLENGTH)
    end;

%%喇叭喊话聊天
handle(?PT_HORN, Status, [Msg]) ->
    case lib_chat:parse_msg_array(Msg) of 
        {true, NewMsg} ->
			Ratio = player:recharge_ratio(),
			case Status#player_status.yuanbao_acc > 100 * Ratio of 
				true ->
					Channel = ?ENUM_CHAT_TYPE_TRUMPET,
					PlayerId = player:id(Status),
					PlayerId2 = 0,
					case lib_chat:use_horn(Status, ?HORN_COST) of
						true ->
							%使用喇叭通知成就
							mod_achievement:notify_achi(use_laba, ?HORN_COST, [], Status),
							{ok, BinData} = pt_11:write(?PT_HORN, [player:id(Status), NewMsg, 
																   lib_chat:get_identify(Status), player:get_name(Status), ply_priv:get_priv_lv(Status),player:get_race(Status),player:get_sex(Status)]),
							lib_send:send_to_all(BinData),
							mod_udp:chat_monitor(Channel, Msg, Status);
						_ ->
							RmbCost = data_special_config:get('horn'),
							case player:has_enough_money(Status, ?MNY_T_YUANBAO, RmbCost) of
								true -> 
									%使用喇叭通知成就
									mod_achievement:notify_achi(use_laba, ?HORN_COST, [], Status),
									player:cost_money(Status, ?MNY_T_YUANBAO, RmbCost, [?LOG_CHAT, "horn"]),
									{ok, BinData} = pt_11:write(?PT_HORN, [player:id(Status), NewMsg, 
																		   lib_chat:get_identify(Status), player:get_name(Status), ply_priv:get_priv_lv(Status),player:get_race(Status),player:get_sex(Status)]),
									lib_send:send_to_all(BinData),
									mod_udp:chat_monitor(Channel, Msg, Status);
								false ->
									lib_send:send_prompt_msg(Status, ?PM_MONEY_LIMIT)
							end
					% lib_chat:send_error_state(Status, ?PT_HORN, ?DEF_ERROR_STATE)
					end;
				false -> 
					lib_send:send_prompt_msg(Status, ?PM_HORN_NEED_RECHARGE)
			end;
        {false, _} ->
            lib_chat:send_error_state(Status, ?PT_HORN, ?MSG_OVERLENGTH)
    end;

%%门派聊天
handle(?PT_FACTION, Status, [Msg]) ->
    case lib_chat:parse_msg_array(Msg) of
        {true, NewMsg} ->
            case player:is_in_faction(Status) of
                true ->
                    {ok, BinData} = pt_11:write(?PT_FACTION, [player:id(Status), NewMsg, 
                        lib_chat:get_identify(Status), player:get_name(Status), ply_priv:get_priv_lv(Status),player:get_race(Status),player:get_sex(Status)]),
                    lib_send:send_to_faction(Status, BinData),

                    mod_achievement:notify_achi(talk_faction, [], Status),

					Channel = ?ENUM_CHAT_TYPE_FACTION,
					mod_udp:chat_monitor(Channel, Msg, Status);
                false -> lib_chat:send_error_state(Status, ?PT_FACTION, ?DEF_ERROR_STATE)
            end;
        {false, _} ->
            lib_chat:send_error_state(Status, ?PT_FACTION, ?MSG_OVERLENGTH)
    end;

%% 私聊必要信息查询
handle(11009, Status, [RoleId]) ->
	lib_chat:get_player_info(Status,RoleId);
%%     case player:is_online(RoleId) of
%%         true -> gen_server:cast(player:get_pid(RoleId), {'apply_cast', ?MODULE, notify_follower_chat_info, [RoleId, player:id(Status)]});
%%         false ->
%%             case mod_offline_data:get_offline_role_brief(RoleId) of
%%                 null -> lib_chat:send_error_state(Status, 11009, ?DEF_ERROR_STATE);
%%                 Rd when is_record(Rd, offline_role_brief) ->
%%                     {ok, BinData} = pt_11:write(11009, [RoleId, Rd#offline_role_brief.race, Rd#offline_role_brief.sex,
%%                         Rd#offline_role_brief.lv, Rd#offline_role_brief.name, Rd#offline_role_brief.faction,
%%                         Rd#offline_role_brief.vip_lv, Rd#offline_role_brief.battle_power, 0
%%                         ,ply_guild:get_guild_name(Rd#offline_role_brief.id)
%%                         ]),
%%                     lib_send:send_to_sock(Status, BinData)
%%             end
%%     end;


handle(11201, PS, _) ->
    IdList =  mod_broadcast:get_broadcast_id_list(),
    {ok, BinData} = pt_11:write(11201, IdList),
    lib_send:send_to_sock(PS, BinData);


handle(11202, PS, [IdList]) ->
    BroadcastList = mod_broadcast:get_broadcast_list_by_id_list(IdList),
    {ok, BinData} = pt_11:write(11202, BroadcastList),
    lib_send:send_to_sock(PS, BinData);


%%跨服聊天 个人信息
handle(?PT_SEND_ACCORSS_PLAYAER, PS, [StoreId, ServerId]) ->
	case config:get_server_id() == ServerId of
		true ->
			lib_chat:get_player_info(PS,StoreId);
		false ->
			case ets:lookup(?ETS_CROSS_CHAT_DATA, {StoreId,1}) of
				[{{StoreId,_Type}, Bin, UnixTime}] ->
					case (util:unixtime() - UnixTime) > 1800 of
						true ->
							sm_cross_server:rpc_cast(ServerId,lib_chat, get_player_info2, [StoreId, config:get_server_id(),player:get_id(PS)]);
						false ->
							lib_send:send_to_uid(player:get_id(PS), Bin)
					end;
				[] ->
					sm_cross_server:rpc_cast(ServerId,lib_chat, get_player_info2, [StoreId, config:get_server_id(),player:get_id(PS) ])
			end
	end;


%%跨服聊天 门客信息
handle(?PT_SEND_ACCORSS_PARTNER, PS, [PartnerId, ServerId]) ->
	case config:get_server_id() == ServerId of
		true ->
			case lib_partner:get_partner(PartnerId) of
				null -> lib_send:send_prompt_msg(PS, ?PM_PAR_NOT_EXISTS);
				Partner ->
					{ok, BinData} = pt_17:write(17028, [Partner]),
					lib_send:send_to_sock(PS, BinData)
			end;
		false ->
			case ets:lookup(?ETS_CROSS_CHAT_DATA, {PartnerId, 2}) of
				[{{PartnerId,_Type}, Bin, UnixTime}] ->
					case (util:unixtime() - UnixTime) > 1800 of
						true ->
							sm_cross_server:rpc_cast(ServerId,lib_partner, get_partner_info_from_crossing, [PartnerId, config:get_server_id(),player:get_id(PS)]);
						false ->
							lib_send:send_to_uid(player:get_id(PS), Bin)
					end;
				[] ->
					sm_cross_server:rpc_cast(ServerId,lib_partner, get_partner_info_from_crossing, [PartnerId, config:get_server_id(),player:get_id(PS)])
			end
	end;

%%跨服聊天 物品信息
handle(?PT_SEND_ACCORSS_GOODS, PS, [GoodsId, ServerId]) ->
	case config:get_server_id() == ServerId of
		true ->
			lib_goods:get_goods_data(PS, GoodsId);
		false ->
			case ets:lookup(?ETS_CROSS_CHAT_DATA, {GoodsId, 3}) of
				[{{GoodsId,_Type}, Bin, UnixTime}] ->
					case (util:unixtime() - UnixTime) > 1800 of
						true ->
							sm_cross_server:rpc_cast(ServerId,lib_goods, get_cross_goods_data, [GoodsId, config:get_server_id(),player:get_id(PS)]);
						false ->
							lib_send:send_to_uid(player:get_id(PS), Bin)
					end;
				[] ->
					sm_cross_server:rpc_cast(ServerId,lib_goods, get_cross_goods_data, [GoodsId, config:get_server_id(),player:get_id(PS)])
			end
	end;


handle(11300, PS, TargetPlayerId) ->
    case check_ban_chat(PS, TargetPlayerId) of
        ok ->
            player:forever_ban_chat(TargetPlayerId, <<>>),  % 目前是永久禁言
            {ok, BinData} = pt_11:write(11300, [?RES_OK, TargetPlayerId]),
            lib_send:send_to_sock(PS, BinData);
        {fail, ?PM_UNKNOWN_ERR} ->
            skip;
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason)
    end;

handle(11301, PS, TargetPlayerId) ->
    case ply_priv:can_cancel_ban_chat(PS) of
        true ->
            player:cancel_ban_chat(TargetPlayerId, <<>>),
            {ok, BinData} = pt_11:write(11301, [?RES_OK, TargetPlayerId]),
            lib_send:send_to_sock(PS, BinData);
        false ->
            lib_send:send_prompt_msg(PS, ?PM_PRIVILEGE_LIMIT)
    end;


handle(_Cmd, _, _Msg) ->
    ?LDS_TRACE("11 PROTOL ERROR", [_Cmd, _Msg]),
    ?ASSERT(false).


fit_lv(Status, Lv) ->
    case ply_priv:get_priv_lv(Status) >= ?PRIV_GM of
        true -> true;
        false -> player:get_lv(Status) >= Lv
    end.


notify_follower_chat_info(TargetId, RoleId) ->
    case player:get_PS(TargetId) of
        FriStatus when is_record(FriStatus, player_status) ->
            {ok, BinData} = pt_11:write(11009, [TargetId, player:get_race(FriStatus),
                player:get_sex(FriStatus), player:get_lv(FriStatus), player:get_name(FriStatus), 
                player:get_faction(FriStatus), player:get_vip_lv(FriStatus), ply_attr:get_battle_power(FriStatus), 
                ?BIN_PRED(player:is_chat_banned(RoleId), 1, 0)
                ,ply_guild:get_guild_name(TargetId), player:get_peak_lv(TargetId)]),

            ?DEBUG_MSG("ply_guild:get_guild_name(RoleId)=~p",[ply_guild:get_guild_name(TargetId)]),   
            lib_send:send_to_uid(RoleId, BinData);
        _ -> skip
    end.






check_ban_chat(PS, TargetPlayerId) ->
    case ply_priv:can_ban_chat(PS) of
        true ->
            case ply_priv:get_priv_lv_by_id(TargetPlayerId) of
                error ->
                    {fail, ?PM_UNKNOWN_ERR};
                TargetPlayerPrivLv ->
                    MyPrivLv = ply_priv:get_priv_lv(PS),
                    case MyPrivLv > TargetPlayerPrivLv of
                        true ->
                            ok;
                        false ->
                            {fail, ?PM_PRIVILEGE_LIMIT}
                    end
            end;
        false ->
            {fail, ?PM_PRIVILEGE_LIMIT}
    end.




% handle(?PT_WORLD, PS, [Color, ChatMsg]) ->
%     ?ASSERT(is_list(ChatMsg), ChatMsg),
%     % debug版本下，顺带尝试当做gm指令来处理
%     ?HANDLE_CHAT_MSG_AS_GM_CMD(PS, string:tokens(ChatMsg, "\n")),
%     array:sparse_map(),
%     {ok, BinData} = pt_11:write(?PT_WORLD, [PS, Color, ChatMsg]),
%     lib_send:send_to_all(BinData);


% %%私聊
% %%_Uid:用户ID
% %%_Nick:用户名
% %%Data:内容
% %%_Uid 和 _Nick 任意一个即可
% handle(?PT_PERSONAL, Status, [_Color, _Uid, _Nick, Data])
%  when is_list(Data)->
% 	?TRACE("---personal chat\n"),
%     if  
%         _Uid > 0 ->
% 			%%检测对方是否在线
% 			case lib_player:is_online(_Uid) of
% 				false ->   %%对方不在线,则返回对方不在线消息给私聊发起者
% 					?TRACE("LDS\npp_chat: off line\n"),
% 					Data1 = [0, _Uid, _Nick, Status#player_status.id, Status#player_status.nickname, Data, Status#player_status.identity],
% 					{ok, BinData} = pt_11:write(?PT_PERSONAL, Data1),
% 					lib_send:send_to_uid(Status#player_status.id, BinData);
% 				true ->
% 					Data1 = [1, _Uid, _Nick, Status#player_status.id, Status#player_status.nickname, Data, Status#player_status.identity],
%     				{ok, BinData} = pt_11:write(?PT_PERSONAL, Data1),
%           		  %%判断是否存在黑名单关系(存在则屏蔽,并返回信息)
%            		 	case pp_relationship:export_is_exists(_Uid, Status#player_status.id, 2) of
%                 		{ok, false} -> 
% 							case lib_relationship:add_currently_contact(Status#player_status.id,_Uid) of
% 								true ->
% 									?TRACE("---add_currently_contact 1\n"),
% 									pp_relationship:handle(14033,Status,[Status#player_status.id,4]);
% 								false ->
% 									ok
% 							end,
% 					%%获取对方玩家进程并发送修改ets表通知
% 							PlayerProcessName = misc:player_process_name(_Uid),
% 							case lib_relationship:add_currently_contact(_Uid, Status#player_status.id) of
% 								true ->
% 									?TRACE("---add_currently_contact 2\n"),
% 									gen_server:cast({global, PlayerProcessName}, {apply_cast, pp_relationship, handle, [14033,Status,[_Uid,4]]});
% 								false ->
% 									ok
% 							end,
% 							?TRACE("---send_to_uid ~p~n", [_Uid]),
% 							lib_send:send_to_uid(_Uid, BinData);
%                 		{_, true} -> lib_chat:chat_in_blacklist(_Uid, Status#player_status.sid)
%             		end
% 			end;
%         is_list(_Nick) ->  
% 			skip
% 	end;

% %%场景
% handle(?PT_CURRENT, Status, [_Color, Data])
%  when is_list(Data)->
%     Data1 = [Status#player_status.id, Status#player_status.nickname, Data, Status#player_status.identity],
%     %%io:format("~p~n",[Data1]),
%     {ok, BinData} = pt_11:write(?PT_CURRENT, Data1),
%     lib_send:send_to_scene_all_line(Status#player_status.scene, BinData);

% %%帮派
% handle(?PT_GUILD, Status, [Color, Data])
%  when is_list(Data)->
%     Data1 = [Status#player_status.id, Status#player_status.nickname, Data, Color],
%     {ok, BinData} = pt_11:write(?PT_GUILD, Data1),
%     lib_send:send_to_guild(Status#player_status.guild_id, BinData);

% %%队伍
% handle(?PT_TEAM, Status, [Color, Data])
%  when is_list(Data)->
% 	{ok, BinData} = pt_11:write(?PT_TEAM, [Status#player_status.id, Status#player_status.nickname, Data, Color]),
% 	lib_send:send_to_team(Status, BinData);
% %%      case is_pid(Status#player_status.pid_team) andalso misc:is_process_alive(Status#player_status.pid_team) of
% %%         true ->
% %%             gen_server:cast(Status#player_status.pid_team, {'TEAM_MSG', Status#player_status.id, Status#player_status.nickname, Color, Data});
% %%         false -> ok
% %%     end;


% %% GM命令
% handle(?PT_HORN, Status, [Data]) when is_list(Data)->
%     case mod_gm:gm_command(Status, [Data]) of
%         {ok, NewState} ->
%             {ok, BinData} = pt_11:write(?PT_HORN, [1]),
%             lib_send:send_one(Status#player_status.socket, BinData), 
%             {ok, NewState};
%         _ ->
%             {ok, BinData} = pt_11:write(?PT_HORN, [0]),
%             lib_send:send_one(Status#player_status.socket, BinData), 
%             ok
%     end;

% %%喇叭喊话聊天
% handle(?PT_FACTION, Status, [_Color,Data]) ->
% 	?TRACE("-----handle(?PT_FACTION \n"),
% 	case goods_util:get_type_goods_list(Status#player_status.id, ?BUGLEID, ?LOCATION_BAG) of
% 		[] ->
% 			ChatMSG = [0,Status#player_status.id, Status#player_status.nickname, Data, Status#player_status.identity, Status#player_status.current_title],
% 			{ok, BinData} = pt_11:write(?PT_FACTION, ChatMSG),
% 			lib_send:send_one(Status#player_status.socket, BinData);
% 		[R|_] ->
% 			?TRACE("the bugle id is: ~p~n", [R]),
% 			case gen_server:call(?GET_GOODS_PID(Status), {'delete_one', Status, R#goods.id, 1}) of
% 				[1,_Leavings] ->
% 				ChatMSG = [1,Status#player_status.id, Status#player_status.nickname, Data, Status#player_status.identity, Status#player_status.current_title],
% 				{ok, BinData} = pt_11:write(?PT_FACTION, ChatMSG),
% 				lib_send:send_to_all(BinData);
% 			_ -> 
% 				ChatMSG = [0,Status#player_status.id, Status#player_status.nickname, Data, Status#player_status.identity, Status#player_status.current_title],
% 				{ok, BinData} = pt_11:write(?PT_FACTION, ChatMSG),
% 				lib_send:send_one(Status#player_status.socket, BinData)
% 			end
% 	end;
% 	%%-----------------------联调测试：--------------------------
% %% 	ChatMSG = [1, Status#player_status.id, Status#player_status.nickname, Data, Color],
% %% 	{ok, BinData} = pt_11:write(?PT_FACTION, ChatMSG),
% %%     lib_send:send_to_all(BinData);

% %% 	ChatMSG = [0, Status#player_status.id, Status#player_status.nickname, Data, Color],
% %% 	{ok, BinData} = pt_11:write(?PT_FACTION, ChatMSG),
% %% 	lib_send:send_one(Status#player_status.socket, BinData);
	

% 	%%--------------------------------------------------------

% %%玩家禁言
% handle(11011, Status, []) ->
% 	NowTimeStamp = util:unixtime(),
% 	EndBanTimeStamp = Status#player_status.end_ban_time,
% 	if 
% 		(EndBanTimeStamp == 0) orelse (NowTimeStamp >= EndBanTimeStamp) ->
% 			%%发送玩家被不禁言消息
% 			{ok, BinData} = pt_11:write(11011, [0]),
% 			?TRACE("send ban chat and time = 0 \n"),
% 			lib_send:send_one(Status#player_status.socket, BinData);
% 		true ->
% 			%%发送玩家被禁言消息
% 			LeftTime = (EndBanTimeStamp - NowTimeStamp),
% 			?TRACE("handle 11011 and ban lefttime is ~p~n", [LeftTime]),
% 			{ok, BinData} = pt_11:write(11011, [LeftTime]),
% 			lib_send:send_one(Status#player_status.socket, BinData)
% 	end;


% %%GM指令 普通指令
% handle(11009, Status, [0, Data]) ->
% 	case config:get_can_gmcmd() of
% 		0 ->
% 			skip;
% 		1 ->
% 			Data1 = string:tokens(Data, "\r"),
% 			lib_gm:handle_chat_msg_as_gm_cmd(Status, Data1)
% 	end;

% %%GM指令 代码指令
% handle(11009, Status, [1, Data]) ->
% 	case config:get_can_gmcmd() of
% 		0 ->
% 			skip;
% 		1 ->
% 			Reply = lib_gm_dynamic:gm_execute(Data),
% 			Msg = case Reply of
% 					  success ->
% 						  try 
% 							  gm_dynamic:run()
% 						  catch
% 							  _:Error ->
% 								  Error
% 						  end;
% 					  fail ->
% 						  fail;
% 					  M ->
% 						  M
% 				  end,
% 			lib_gm:send_prompt(Status, Msg)
% 	end;


	
% handle(_Cmd, _Status, _Data) ->
%     ?DEBUG_MSG("pp_chat no match", []),
    % {error, "pp_chat no match"}.

% %%测试
% guild_info_test() ->
% 	List = [[1, "aa", 0],[0, "fuck you", 2]],
% 	send_guild_info([1], List).

% %%发送帮派信息
% %%@GuildIdList:要发送信息到的帮会ID列表
% %%@List:要发送的信息列表
% send_guild_info(GuildIdList, List)
% 	when is_list(List) orelse is_binary(List) ->
% 	?TRACE("@@@LDS: the list is ~p~n", [List]),
% 	Data = tool:to_list(List),
% 	{ok, BinData} = pt_11:write(11014, [Data]),
%     F = fun(GuildId) -> lib_send:send_to_guild(GuildId, BinData) end,
% 	[F(X) || X <- GuildIdList, X /= []].
