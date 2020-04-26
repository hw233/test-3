-module(pp_cross).
-export([handle/3]).

-include("common.hrl").
-include("record.hrl").
-include("player.hrl").
-include("relation.hrl").
-include("prompt_msg_code.hrl").
-include("log.hrl").
-include("ets_name.hrl").
-include("protocol/pt_43.hrl").
-include("pvp.hrl").

%% 进出跨服
handle(?PT_CROSS_SERVER, PS, [Type]) ->
    ?ylh_Debug("apply_merriage ~p~n", [player:id(PS)]),
    case player:is_idle(PS) of
        _ ->
%% 		?true ->
            case config:get_server_id() == player:get_server_id(PS) of
                ?true ->
                    %% 当前在本服，让玩家进入跨服
                    case Type of
                        1 ->
                            lib_cross:enter_cross(PS);
                        _ ->
                            skip
                    end;
                ?false ->
                    %% 玩家在跨服中，退出跨服节点
                    case Type of
                        0 ->
                            lib_cross:leave_cross(PS);
                        _ ->
                            skip
                    end
            end;
        ?false ->
            lib_send:send_prompt_msg(PS, ?PM_BUSY_NOW)
    end;

%% 跨服3v3排行榜(初始进入系统)
handle(?PT_PVP_CROSS_PLAYER_RANK, PS, [Type, Page]) ->
	PvpRankList =
		case lib_pvp:get_ets_pvp_rank_data_from_ets(pvp_cross_rank_data) of
			null ->
				sm_cross_server:rpc_cast(lib_pvp, send_pvp_3v3_cross_rank, [config:get_server_id()]),
				timer:sleep(2000),
				lib_pvp:get_pvp_3v3_rank(pvp_cross_rank_data);
			R ->
				case R#pvp_rank_data.ranklist =:= [] of
                    true ->
                        sm_cross_server:rpc_cast(lib_pvp, send_pvp_3v3_cross_rank, [config:get_server_id()]),
                        timer:sleep(2000),
                        lib_pvp:get_pvp_3v3_rank(pvp_cross_rank_data);
                    false ->
                        R#pvp_rank_data.ranklist
                end
		end,
	PvpRankList1 =
		case Type =:= 0 of
			true ->         % 本服排行榜数据

                % 根据分数先进行排列
                F = fun({PlayerId, PlayerName, ServerId, _Rank, Dan, Score}, Acc) ->
                        case ServerId =:= config:get_server_id() of
                            true ->
                                [{PlayerId, PlayerName, ServerId, Dan, Score} | Acc];
                            false ->
                                Acc
                        end
                    end,
                List2 = lists:reverse(lists:foldl(F, [], PvpRankList)),
                F2 = fun({PlayerId2,PlayerName2,ServerId2,Dan2,Score2},{Rank2 ,Acc2}) ->
                    case Score2 > 0 of
                        true ->
                            {Rank2 +1 , [{PlayerId2, PlayerName2, ServerId2, Rank2, Dan2, Score2} | Acc2] };
                        false ->
                            {Rank2, Acc2}
                    end
                     end,
                {_Rank3 , List3} = lists:foldl(F2, {1,[]}, List2),
                List3;
%%				Predicate = fun({_PlayerId, _PlayerName, ServerId, _Rank, _Dan, _Score}) -> ServerId =:= config:get_server_id() end,
%%              List2 = lists:filter(Predicate, PvpRankList);
			false ->        % 全服排行榜数据
				PvpRankList
		end,
	lib_pvp:send_pvp_cross_rank_to_client(Page, PS, PvpRankList1);



handle(?PT_MINE_PVP_DATA, PS, []) ->
	%% 个人数据
%%	ServerId = config:get_server_id(),
%%    ?DEBUG_MSG("----------- ServerId -------------~p~n", [ServerId]),
%%	Sex = player:get_sex(PS),
%%    Race = player:get_race(PS),
%%	Name = player:get_name(PS),
%%	Level = player:get_lv(PS),
%%	Faction = player:get_faction(PS),
%%    VipLv = player:get_vip_lv(PS),
%%    ShowEquips = player:get_showing_equips(PS),
%%    {ok, PvpplyInfo} = sm_cross_server:rpc_call(lib_pvp, init_cross_pvp_player_info, [player:get_id(PS), ServerId, Sex, Race,
%%        Name, Level, Faction, VipLv, ShowEquips]),
    PvpPlyInfo_T = pack_pvp_player_data(PS),
    
	try
		{ok, PvpplyInfo} = sm_cross_server:rpc_call(lib_pvp, init_cross_pvp_player_info, [PvpPlyInfo_T]),
		{ok, BinData} = pt_43:write(?PT_MINE_PVP_DATA, [PvpplyInfo]),
		lib_send:send_to_sock(PS, BinData)
	
	catch E:R ->
			  sm_cross_server:rpc_call(player:get_server_id(PS), player, mark_cross_local, [player:get_id(PS)]),
			  ?ERROR_MSG("{E,R,erlang:get_stacktrace()} : ~p~n", [{E,R,erlang:get_stacktrace()}])
	end;


handle(?PT_CROSS_PVP_OTHERS_DATA, PS, [QueryPlayerId]) ->
    case sm_cross_server:rpc_call(lib_pvp, get_pvp_cross_player_info, [QueryPlayerId]) of
        {ok, null} ->
            lib_send:send_prompt_msg(PS, ?PM_QUERY_ERROR);
        {ok, PvpplyInfo} ->
            {ok, BinData} = pt_43:write(?PT_CROSS_PVP_OTHERS_DATA, [PvpplyInfo]),
            lib_send:send_to_sock(PS, BinData)
    end;

%%	sm_cross_server:rpc_cast(lib_pvp, send_pvp_cross_others_info, [player:get_id(PS), config:get_server_id(), QueryPlayerId]);

%% 创建房间
handle(?PT_PVP_CREATE_ROOM, PS, []) ->
    PlayerId = player:get_id(PS),
    sm_cross_server:rpc_cast(mod_pvp, create_room_by_player, [PlayerId]);


%% 显示所有房间列表(额外判断开启时间)
handle(?PT_PVP_CROSS_ROOMS, PS, [Page]) ->
    Hour = util:get_hour(),
    case lib_pvp:is_in_3v3_pvp_activity(Hour) of
        true ->
            case player:is_in_team(PS) of
                true ->
                    lib_send:send_prompt_msg(PS, ?PM_PVP_EXIT_TEAM);
                false ->
                    case sm_cross_server:rpc_call(lib_pvp, display_all_room, []) of
                        {ok, RoomList} ->
                            Size = (Page -1) * (?SPLIT_ROOMLIST) + 1,
                            List = case length(RoomList) >= Size  of
                                       true ->lists:sublist(RoomList, Size, ?SPLIT_ROOMLIST);
                                       false -> []
                                   end,
                            {ok, BinData} = pt_43:write(?PT_PVP_CROSS_ROOMS, [List]),
                            lib_send:send_to_sock(PS, BinData);
                        _ ->
                            skip
                    end
            end;
        false ->
            lib_send:send_prompt_msg(PS, ?PM_PVP_3V3_ACTIVITY_IS_NOT_OPEN)
    end;




%% 邀请他人加入房间
handle(?PT_PVP_3V3_INVITE_TEAMATES, PS, [ObjPlayerId]) ->
    % 对玩家状态先进行判断
    case player:is_online(ObjPlayerId) of
        false ->
            lib_send:send_prompt_msg(PS, ?PM_PLAYER_OFFLINE_OR_NOT_EXISTS);
        _ ->
            case player:is_in_team(ObjPlayerId) of
                true ->
                    lib_send:send_prompt_msg(PS, ?PM_PLAYER_IN_TEAM);
                false ->
                    case player:is_battling(ObjPlayerId) of
                        true ->
                            lib_send:send_prompt_msg(PS, ?PM_PLAYER_IN_BATTLEING);
                        false ->
                            sm_cross_server:rpc_cast(mod_pvp, invite_friends_into_room, [player:get_id(PS), ObjPlayerId])
                    end
            end
    end;


%%handle(?PT_PVP_3V3_HANDLE_INVITE, PS, [Action, CaptainId]) ->
%%  1888800000001751        player:is_battling(ObjPS).   ObjPS = player:get_PS(1888800000001751).
%%    case Action of
%%        0 ->
%%            case mod_pvp:disagree_invite(PS, CaptainId) of
%%                {fail, Reason} ->
%%                    lib_send:send_prompt_msg(PS#player_status.id, Reason);
%%                ok ->
%%                    {ok, BinData} = pt_24:write(?PT_PVP_3V3_HANDLE_INVITE, [?RES_OK, CaptainId]),
%%                    lib_send:send_to_sock(PS, BinData)
%%            end;
%%        1 ->
%%            PvpPlyInfo_T = pack_pvp_player_data(PS),
%%            sm_cross_server:rpc_cast(mod_pvp, do_allow_join_in_room, [CaptainId, PvpPlyInfo_T])
%%
%%    end;


handle(?PT_PVP_PROMOTE_TEAMATE_FOR_CAPTAIN, PS, [ObjPlayerId]) ->
	sm_cross_server:rpc_cast(mod_pvp, ask_promote_teamate, [player:get_id(PS), ObjPlayerId]);
%%	case lib_pvp:ask_promote_teamate(player:get_id(PS), ObjPlayerId) of
%%		{fail, Reason} ->
%%			lib_send:send_prompt_msg(player:get_id(PS), Reason);
%%		ok ->
%%			{ok, BinData} = pt_24:write(?PT_PVP_PROMOTE_TEAMATE_FOR_CAPTAIN, ?RES_OK),
%%			lib_send:send_to_sock(player:get_id(PS), BinData)
%%	end;

handle(?PT_PVP_HANDLE_PROMOTE_PVP_CAPTAIN, PS, [Action, CaptainId]) ->
	case Action of
		0 -> % 同意自己被提升为队长
            sm_cross_server:rpc_cast(mod_pvp, agree_promote_canptain, [player:get_id(PS), CaptainId]);
		1 ->
            sm_cross_server:rpc_cast(mod_pvp, disagree_promote_canptain, [player:get_id(PS), CaptainId])
	end;

handle(?PT_APPLY_JOIN_IN_ROOM, PS, [CaptainId]) ->
    % 考虑到玩家从世界聊天直接加入,对PlayerId数据进行初始化
    PvpPlyInfo = pack_pvp_player_data(PS),
    case lib_pvp:is_sys_open(PS) of
        true ->
            case sm_cross_server:rpc_call(mod_pvp, apply_join_in_room, [PvpPlyInfo, CaptainId]) of
                {ok, {fail, Reason}} ->
                    lib_send:send_prompt_msg(PS, Reason);
                {ok, true} ->
                    {ok, BinData} = pt_43:write(?PT_APPLY_JOIN_IN_ROOM, [?RES_OK]),
                    lib_send:send_to_uid(player:get_id(PS), BinData)
            end;
        false ->
            lib_send:send_prompt_msg(PS, ?PM_PVP_3V3_LV_NOT_SATISFY)
    end;


handle(?PT_PVP_QRY_APPLY_LIST, PS, []) ->   % 这里可以加判断PS是否是房主,筛选申请列表已有房间的玩家
    {ok, ApplyInfoList} = sm_cross_server:rpc_call(lib_pvp, get_apply_list_player_info_list, [player:get_id(PS)]),
    F = fun(PvpPlyInfo, Acc) ->
            [{PvpPlyInfo#pvp_cross_player_data.player_id, PvpPlyInfo#pvp_cross_player_data.player_name, PvpPlyInfo#pvp_cross_player_data.dan, PvpPlyInfo#pvp_cross_player_data.server_id} | Acc]
        end,
    List = lists:foldl(F, [], ApplyInfoList),
    {ok, BinData} = pt_43:write(?PT_PVP_QRY_APPLY_LIST, [List]),
    lib_send:send_to_sock(PS, BinData);

handle(?PT_ALLOW_JOIN_IN_ROOM, PS, [JoinPlayerId, ServerId]) ->
    case sm_cross_server:rpc_call(ServerId, mod_pvp, check_player_status, [JoinPlayerId]) of
        {ok, {false, Reason}} ->
            lib_send:send_prompt_msg(PS, Reason);
        _ ->
            CaptainId = player:get_id(PS),
            sm_cross_server:rpc_cast(mod_pvp, allow_join_in_room, [CaptainId, JoinPlayerId])
    end;
%%    case sm_cross_server:rpc_call(ServerId, player, is_online, [JoinPlayerId]) of
%%        {ok, false} ->
%%            lib_send:send_prompt_msg(PS, ?PM_PLAYER_OFFLINE_OR_NOT_EXISTS);
%%        _ ->
%%            case player:is_in_team(JoinPlayerId) of
%%                true ->
%%                    lib_send:send_prompt_msg(PS, ?PM_PLAYER_IN_TEAM);
%%                false ->
%%                    case player:is_battling(JoinPlayerId) of
%%                        true ->
%%                            lib_send:send_prompt_msg(PS, ?PM_PLAYER_IN_BATTLEING);
%%                        false ->
%%                            CaptainId = player:get_id(PS),
%%                            sm_cross_server:rpc_cast(mod_pvp, allow_join_in_room, [CaptainId, JoinPlayerId])
%%                    end
%%            end
%%    end;

handle(?PT_REJECT_JOIN_IN_ROOM, PS, [ObjPlayerId]) ->
    sm_cross_server:rpc_cast(mod_pvp, reject_join_in_room, [player:get_id(PS), ObjPlayerId]);

handle(?PT_TM_NOTIFY_TEAMATE_OUT_ROOM, PS, []) ->
    sm_cross_server:rpc_cast(mod_pvp, leave_room, [player:get_id(PS)]);

handle(?PT_PVP_KICK_OUT_TM, PS, [ObjPlayerId]) ->
    sm_cross_server:rpc_cast(mod_pvp, kick_out_teamate_from_pvp_room, [player:get_id(PS), ObjPlayerId]);

%%    case mod_pvp:check_add_teammate(CaptainId, JoinPlayerId) of
%%        {fail, Reason} ->
%%            lib_send:send_prompt_msg(CaptainId, Reason);
%%        ok ->
%%            allow_join_in_room(CaptainId, JoinPlayerId)
%%    end,
%%    ok;

handle(?PT_PVP_CAPTAIN_USE_ZF, PS, [No]) ->		% 判断是不是队长
    case mod_pvp:use_zf_in_room(PS, No) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        ok ->
            skip
%%            {ok, BinData} = pt_43:write(?PT_PVP_CAPTAIN_USE_ZF, [No]),
%%            lib_send:send_to_sock(PS, BinData)
    end;

handle(?PT_PVP_MATCHING, PS, [Type]) ->
	Hour = util:get_hour(),
	case lib_pvp:is_in_3v3_pvp_activity(Hour) of
		true ->
			mod_pvp:start_matching(Type, PS);
		false ->
			lib_send:send_prompt_msg(PS, ?PM_PVP_3V3_ACTIVITY_IS_NOT_OPEN)
	end;
%%    sm_cross_server:rpc_cast(mod_pvp, start_matching, [Type, player:get_id(PS)]),
%%    case Type of
%%        0 ->
%%            ok;
%%        1 ->
%%            ok
%%    end;

handle(?PT_PVP_CANCLE_MATCHING, PS, [Type]) ->
    mod_pvp:cancle_match(Type, PS);

handle(?PT_ROOM_CHAT, PS, [CaptainId, Msg]) ->
    case lib_chat:parse_msg_array(Msg) of
        {true, NewMsg} ->
            ?DEBUG_MSG("----------- player:get_dan(PS) ------------~p~n", [player:get_dan(PS)]),
            {ok, BinData} = pt_43:write(?PT_ROOM_CHAT, [player:id(PS), NewMsg,
                lib_chat:get_identify(PS), player:get_name(PS), player:get_race(PS), player:get_sex(PS), config:get_server_id(), player:get_dan(PS)]),
            sm_cross_server:rpc_cast(lib_pvp, send_message_to_all_players_in_room, [CaptainId, BinData]);
        {false, _} ->
            skip
    end;

handle(?PT_CLOSE_CROSS_3V3_RESULT, PS, [Type]) ->
    case sm_cross_server:rpc_call(mod_pvp, close_pvp_cross_interface, [player:get_id(PS), Type]) of
        {ok, {fail, Reason}} ->
            lib_send:send_prompt_msg(PS, Reason);
        _ ->
            {ok, BinData} = pt_43:write(?PT_CLOSE_CROSS_3V3_RESULT, [?RES_OK]),
            lib_send:send_to_sock(PS, BinData)
    end;

%%handle(?PT_ONCE_AGAIN_3V3_PVP, PS, [CaptainId]) ->
%%    ?ASSERT(player:get_id(PS) =/= CaptainId),
%%    {ok, BinData} = pt_43:write(?PT_ONCE_AGAIN_3V3_PVP, [player:id(PS)]),
%%    sm_cross_server:rpc_cast(lib_pvp, send_message_to_all_players_in_room, [CaptainId, BinData]);

handle(?PT_PVP_CROSS_GET_ONLINE_RELA_PLAYERS, PS, [PageSize, PageIndex]) ->

    L1 = ply_relation:get_online_friend_list(PS),
    L2 = mod_guild:get_online_member_PS_list(player:get_guild_id(PS)) -- [PS],
    F = fun(PS1, PS2) -> player:get_lv(PS1) < player:get_lv(PS2) end,
    ListSort = lists:sort(F, lists:usort(L1 ++ L2)),
    % 对ListSort进行处理，跨服筛选符合匹配规则
    F2 = fun(ObjPS, Acc) ->
            case player:get_lv(ObjPS) >= data_special_config:get('3V3_open_lv') of
                true ->
                    ObjPlayerId = player:get_id(ObjPS),
                    [ObjPlayerId | Acc];
                false ->
                    Acc
            end
         end,
    PlyIdList = lists:foldl(F2, [], ListSort),
    ?DEBUG_MSG("----------- PlyIdList -----------~p~n", [PlyIdList]),
    {ok, PlyIdList2} = sm_cross_server:rpc_call(lib_pvp, judge_players_dan, [player:get_id(PS), PlyIdList]),
    ?DEBUG_MSG("----------- PlyIdList2 -----------~p~n", [PlyIdList2]),
    F3 = fun(PlyId, Acc2) ->
            PlyPS = player:get_PS(PlyId),
            [PlyPS | Acc2]
         end,
    NewListSort = lists:foldl(F3, [], PlyIdList2),
    ?DEBUG_MSG("----------- NewListSort -----------~p~n", [NewListSort]),

    AllLen = length(NewListSort),
    Temp = AllLen div PageSize,
    TotalPage =
        case AllLen rem PageSize of
            0 -> Temp;
            _ -> Temp + 1
        end,

    IndexStart = (PageIndex - 1) * PageSize + 1,
    IndexEnd = IndexStart + PageSize - 1,

    RetList =
        case IndexStart > AllLen orelse IndexEnd - IndexStart + 1 < 0 of
            true -> [];
            false ->
                lists:sublist(NewListSort, IndexStart, IndexEnd - IndexStart + 1)
        end,
    ?DEBUG_MSG("----------- RetList -----------~p~n", [RetList]),
    {ok, BinData} = pt_43:write(?PT_PVP_CROSS_GET_ONLINE_RELA_PLAYERS, [TotalPage, PageIndex, RetList, L1, L2]),
    lib_send:send_to_sock(PS, BinData);

handle(?PT_PVP_CROSS_ACCEPT_INVITE, PS, [CaptainId]) ->
    ?DEBUG_MSG("------ CaptainId ------~p~n", [CaptainId]),
    PvpPlyInfo_T = pack_pvp_player_data(PS),
    sm_cross_server:rpc_cast(mod_pvp, accept_invite_in_room, [CaptainId, PvpPlyInfo_T]);
%%    sm_cross_server:rpc_cast(mod_pvp, accept_invite_in_room, [CaptainId, player:get_id(PS)]);


handle(?PT_PVP_CROSS_REFUSE_INVITE, PS, [CaptainId]) ->
    sm_cross_server:rpc_cast(mod_pvp, refuse_invite_in_room, [CaptainId, player:get_id(PS)]);

handle(?PT_PVP_CROSS_PLAYER_PREPARE, PS, [Type]) ->
    case Type of
        0 ->
            sm_cross_server:rpc_cast(mod_pvp, player_prepare_3v3_pvp, [player:get_id(PS)]);
        1 ->
            sm_cross_server:rpc_cast(mod_pvp, player_cancel_prepare_3v3_pvp, [player:get_id(PS)])
    end;

handle(?PT_3V3_PVP_GET_DAYREWARD, PS, [Type]) ->
    case data_ranking3v3_reach_time_reward:get(Type) of
        Rid when is_integer(Rid) ->
            case lib_reward:check_bag_space(PS, Rid) of
                ok ->
                    case sm_cross_server:rpc_call(mod_pvp, get_participate_dayreward, [player:get_id(PS), Type]) of
                        {ok, {fail, Reason}} ->
                            lib_send:send_prompt_msg(PS, Reason);
                        {ok, PvpPlyInfo} when is_record(PvpPlyInfo, pvp_cross_player_data) ->
                            lib_reward:give_reward_to_player(common, PS, Rid, [], [?LOG_OA, "3v3_cross_pvp_dayreward"]),
                            {ok, BinData} = pt_43:write(?PT_MINE_PVP_DATA, [PvpPlyInfo]),
                            lib_send:send_to_sock(PS, BinData)
                    end;
                {fail, Reason} ->
                    lib_send:send_prompt_msg(PS, Reason)
            end;
        _ -> lib_send:send_prompt_msg(PS, ?PM_PVP_3V3_NOT_FOUND_REWARD)
    end;

handle(?PT_PVP_CROSS_UPDATE_TEAM, _PS, [CaptainId]) ->
    sm_cross_server:rpc_cast(lib_pvp, send_room_players_info_to_teammate, [CaptainId]);

handle(?PT_PVP_CROSS_REMOVE_INVITE_LIMIT, _PS, [CaptainId]) ->
    case lib_cross:check_is_mirror() of
        ?true ->
            lib_pvp:remove_invite_limit(CaptainId);
        ?false ->
            sm_cross_server:rpc_cast(lib_pvp, remove_invite_limit, [CaptainId])
    end;

handle(_Msg, _PS, _) ->
    ?WARNING_MSG("unknown handle ~p", [_Msg]),
    error.

pack_pvp_player_data(PS) ->
    PlayerId = player:id(PS),
    ServerId = config:get_server_id(),
    Sex = player:get_sex(PS),
    Race = player:get_race(PS),
    Name = player:get_name(PS),
    Level = player:get_lv(PS),
    Faction = player:get_faction(PS),
    VipLv = player:get_vip_lv(PS),
    ShowEquips = player:get_showing_equips(PS),

    PvpPlyInfo_T = #pvp_cross_player_data{
        player_id = PlayerId,
        player_name = Name,
        server_id = ServerId,
        faction = Faction,
        sex = Sex,
        race = Race,
        lv = Level,
        vip_lv = VipLv,
        showing_equips = ShowEquips
        },
    PvpPlyInfo_T.