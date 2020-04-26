%%%--------------------------------------
%%% @Module  : pp_team
%%% @Author  : huangjf
%%% @Modify	 :  zhangwq
%%% @Email   : 
%%% @Created : 2013.6.27
%%% @Description:  组队功能管理
%%%--------------------------------------
-module(pp_team).
-export([handle/3]).
-include("record.hrl").
-include("common.hrl").
-include("team.hrl").
-include("protocol/pt_24.hrl").
-include("sys_code.hrl").
-include("debug.hrl").
-include("prompt_msg_code.hrl").

%% desc: 等级检查
handle(Cmd, PS, Data) ->
    case ply_sys_open:is_open(PS, ?SYS_TEAM) of
        true -> handle_cmd(Cmd, PS, Data);
        false -> skip
    end.


%% 创建队伍
handle_cmd(?PT_TM_CREATE, PS, [TeamId, SceneNo, TeamActivityType, Condition1, Condition2,MinLv,MaxLv, TeamName]) ->
	%% 如果玩家没有指定队伍名则自动以 玩家名+“的队伍”
	TeamName1 = 
	case TeamName of
		[] ->
			NameSuffix = <<"的队伍">>,
			binary_to_list(player:get_name(PS)) ++ binary_to_list(NameSuffix);
		_ ->
			TeamName
	end,

	case TeamId =:= 0 of
		true ->
			mod_team_mgr:create_team(PS, SceneNo, TeamActivityType, Condition1, Condition2,MinLv,MaxLv, TeamName1);
		false ->
			case mod_team:modify_team(PS, TeamId, SceneNo, TeamActivityType, Condition1, Condition2,MinLv,MaxLv, TeamName1) of
				{fail, Reason} ->
					lib_send:send_prompt_msg(PS, Reason);
				{ok, Team} ->
					{ok, BinData} = pt_24:write(?PT_TM_NOTIFY_TEAM_INFO_CHANGE, [Team, lib_team:get_learned_zf_nos(Team)]),
					lib_send:send_to_team(Team, BinData)
			end
	end;
    		
	
handle_cmd(?PT_TM_SET_JOIN_AIM, PS, [TeamActivityType, Condition1, Condition2,MinLv,MaxLv]) ->
	case mod_team:set_join_team_aim(PS, TeamActivityType, Condition1, Condition2,MinLv,MaxLv) of
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason);
		ok ->
			{ok, BinData} = pt_24:write(?PT_TM_SET_JOIN_AIM, [?RES_OK, TeamActivityType, Condition1, Condition2,MinLv,MaxLv]),
			lib_send:send_to_sock(PS, BinData)
	end;


handle_cmd(?PT_TM_GET_JOIN_AIM, PS, _) ->
	TeamActivityType = player:get_team_target_type(PS),
	Condition1 = player:get_team_condition1(PS),
	Condition2 = player:get_team_condition2(PS),

	{MinLv,MaxLv} = player:get_team_lv_range(PS),

	?TRACE("get join aim :~p, ~p ~p ~p ,~p ~n", [TeamActivityType, Condition1, Condition2,MinLv,MaxLv]),
	{ok, BinData} = pt_24:write(?PT_TM_GET_JOIN_AIM, [TeamActivityType, Condition1, Condition2,MinLv,MaxLv]),
	lib_send:send_to_sock(PS, BinData);


handle_cmd(?PT_TM_CHANGE_POS, PS, [PlayerId1, PlayerId2]) ->
	case mod_team:change_member_pos(PS, PlayerId1, PlayerId2) of
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason);
		ok ->
			void
	end;

	
handle_cmd(?PT_TM_TEM_LEAVE, PS, _) ->
	case mod_team:tem_leave_team(PS) of
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason);
		ok ->
            % 女妖乱斗暂离后1分钟内无法发起决斗
            lib_melee:add_leave_team_buff(PS),
			void
	end;

	  
%% 查询场景中的队伍列表
handle_cmd(?PT_TM_QRY_TEAM_LIST, PS, [PageSize, PageIndex, TeamActivityType, Condition1, Condition2]) ->
	TeamList = mod_team:refresh_team_list(player:get_scene_id(PS),TeamActivityType, Condition1, Condition2),

	?TRACE("team list len: ~p~n", [length(TeamList)]),
	AllTeamLen = length(TeamList),
	Temp = AllTeamLen div PageSize,
    TotalPage = 
	    case AllTeamLen rem PageSize of
	        0 -> Temp;
	        _ -> Temp + 1
	    end,

    IndexStart = (PageIndex - 1) * PageSize + 1,
    IndexEnd = IndexStart + PageSize - 1,

    RetTeamList = 
	    case IndexStart > AllTeamLen orelse IndexEnd - IndexStart + 1 < 0 of
	        true -> [];
	        false ->
	            lists:sublist(TeamList, IndexStart, IndexEnd - IndexStart + 1)
	    end,

	{ok, BinData} = pt_24:write(?PT_TM_QRY_TEAM_LIST, [PS, TotalPage, PageIndex, RetTeamList]),
	lib_send:send_to_sock(PS, BinData);
                    

%% 退出队伍
handle_cmd(?PT_TM_QUIT, PS, _) ->
	case mod_team:quit_team(PS) of
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason);
		ok ->
            % 女妖乱斗 离队后1分钟内无法发起决斗
            lib_melee:add_leave_team_buff(PS),
			void
	end;
	

%% 邀请他人加入队伍
handle_cmd(?PT_TM_INVITE_OTHERS, PS, [ObjPlayerId]) ->
	case mod_team:check_add_mb() of
		{fail, _Reason} ->
			lib_send:send_prompt_msg(PS, _Reason);
		ok ->
			case mod_team:invite_others(PS, ObjPlayerId) of
				{fail, Reason} ->
					lib_send:send_prompt_msg(PS, Reason);
				ok ->
					{ok, BinData} = pt_24:write(?PT_TM_INVITE_OTHERS, [?RES_OK, ObjPlayerId]),
					lib_send:send_to_sock(PS, BinData)
			end
	end;
	

%% 踢出队伍（队长权限）
%% @TargetId: 被踢队员id
handle_cmd(?PT_TM_KICK_OUT, PS, [ObjPlayerId]) ->
	case mod_team:kick_out_member(PS, ObjPlayerId) of
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason);
		ok ->
            % 女妖乱斗 踢出队员后1分钟内无法发起决斗
            lib_melee:add_tick_out_member_buff(PS),
			void
	end;
	

%% 查询队伍信息  mod_team:get_team_info(player:get_PS(1000100000000107)).
handle_cmd(?PT_TM_QRY_MY_TEAM_INFO, PS, _) ->
	case mod_team:get_team_info(PS) of
		null ->
			{ok, BinData} = pt_24:write(?PT_TM_QRY_MY_TEAM_INFO, [?INVALID_ID, [], null]),
			lib_send:send_to_sock(PS, BinData);
		Team ->
			Data = lib_team:pack_member(Team, Team#team.members),
			{ok, BinData} = pt_24:write(?PT_TM_QRY_MY_TEAM_INFO, [player:get_team_id(PS), Data, Team]),
			lib_send:send_to_sock(PS, BinData)
	end;
    

handle_cmd(?PT_TM_QRY_TEAM_BRIEF_INFO, PS, [TeamId]) ->
	case mod_team:get_team_info(TeamId) of
		null ->
			{ok, BinData} = pt_24:write(?PT_TM_QRY_TEAM_BRIEF_INFO, [?INVALID_ID, <<>>, ?INVALID_ID, []]),
			lib_send:send_to_sock(PS, BinData);
		Team ->
			DataList = lib_team:pack_brief_member(Team, Team#team.members),
			{ok, BinData} = pt_24:write(?PT_TM_QRY_TEAM_BRIEF_INFO, [TeamId, Team#team.team_name, Team#team.leader_id, DataList]),
			lib_send:send_to_sock(PS, BinData)
	end;

%% 提升队员为队长（队长权限），需要队员确认
handle_cmd(?PT_TM_PROMOTE_MEMBER, PS, [ObjPlayerId]) ->
	case mod_team:ask_promote_member(PS, ObjPlayerId) of
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS#player_status.id, Reason);
		ok ->
			{ok, BinData} = pt_24:write(?PT_TM_PROMOTE_MEMBER, ?RES_OK),
    		lib_send:send_to_sock(PS, BinData)
	end;
    

handle_cmd(?PT_TM_HANDLE_PROMOTE, PS, [Action, TeamId, SendMsgLeaderId]) ->
	?ASSERT(TeamId =:= PS#player_status.team_id),
	case Action of
		0 -> % 同意自己被提升为队长
			mod_team:agree_promote_leader(PS, TeamId, SendMsgLeaderId);
		1 ->
			mod_team:disagree_promote_leader(PS, TeamId)
	end;


handle_cmd(?PT_TM_GET_ALONE_PLAYER_LIST, PS, _) ->
	?TRACE("begin refresh alone player list", []),
	case player:is_leader(PS) of
		false ->
			skip;
		true ->
			{ok, BinData} = pt_24:write(?PT_TM_GET_ALONE_PLAYER_LIST, [?RES_OK, mod_team:get_alone_player_list(PS)]),
			lib_send:send_to_sock(PS, BinData)
	end;


handle_cmd(?PT_TM_APPLY_FOR_LEADER, PS, _) ->
	case mod_team:apply_for_leader(PS) of
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS#player_status.id, Reason);
		ok ->
			{ok, BinData} = pt_24:write(?PT_TM_APPLY_FOR_LEADER, [?RES_OK]),
			lib_send:send_to_sock(PS, BinData)
	end;


handle_cmd(?PT_TM_HANDLE_APPLY_FOR, PS, [Action, ObjPlayerId]) ->
	case player:id(PS) =:= ObjPlayerId of
		true -> skip;
		false ->
			case Action of
				1 ->
					case mod_team:agree_apply_for(PS, ObjPlayerId) of
						{fail, Reason} ->
							lib_send:send_prompt_msg(PS#player_status.id, Reason);
						ok ->
							void
					end;
				0 ->
					case mod_team:disagree_apply_for(PS, ObjPlayerId) of
						{fail, Reason} ->
							lib_send:send_prompt_msg(PS#player_status.id, Reason);
						ok ->
							{ok, BinData} = pt_24:write(?PT_TM_HANDLE_APPLY_FOR, [?RES_OK]),
							lib_send:send_to_sock(PS, BinData)
					end
			end
	end;


handle_cmd(?PT_TM_HANDLE_INVITE, PS, [Action, LeaderId]) ->
	case Action of
		0 -> 
			case mod_team:disagree_invite(PS, LeaderId) of
				{fail, Reason} ->
					lib_send:send_prompt_msg(PS#player_status.id, Reason);
				ok ->
					{ok, BinData} = pt_24:write(?PT_TM_HANDLE_INVITE, [?RES_OK, LeaderId]),
					lib_send:send_to_sock(PS, BinData)
			end;
		1 ->
			%% 发送信息给队长进程确认
			case player:get_pid(LeaderId) of
				null -> skip;
				Pid -> gen_server:cast(Pid, {'confirm_add_tm_mb', PS})
			end
	end;


handle_cmd(?PT_TM_APPLY_JOIN, PS, [LeaderId]) ->
	case mod_team:apply_join(PS, LeaderId) of
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS#player_status.id, Reason);
		ok ->
			mod_achievement:notify_achi(join_team, [], PS),
			{ok, BinData} = pt_24:write(?PT_TM_APPLY_JOIN, [?RES_OK]),
			lib_send:send_to_sock(PS, BinData)
	end;


handle_cmd(?PT_TM_ALLOW_JOIN, PS, [PlayerId, TeamId]) ->
	case mod_team:check_add_mb() of
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS#player_status.id, Reason);
		ok ->
			mod_team_mgr:allow_join(PS, PlayerId, TeamId)
	end;


handle_cmd(?PT_TM_RETURN_TEAM, PS, [TeamId]) ->
	case mod_team:return_team(PS, TeamId) of
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS#player_status.id, Reason),
			?TRACE("mod_team:return_team fail,reason:~p~n", [Reason]),
			{ok, BinData} = pt_24:write(?PT_TM_RETURN_TEAM, [?RES_FAIL]),
			lib_send:send_to_sock(PS, BinData);
		ok ->
			{ok, BinData} = pt_24:write(?PT_TM_RETURN_TEAM, [?RES_OK]),
			lib_send:send_to_sock(PS, BinData)
	end;


handle_cmd(?PT_TM_INVITE_RETURN, PS, [PlayerId]) ->
	case mod_team:invite_return(PS, PlayerId) of
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS#player_status.id, Reason);
		ok ->
			{ok, BinData} = pt_24:write(?PT_TM_INVITE_RETURN, [?RES_OK]),
			lib_send:send_to_sock(PS, BinData)
	end;


handle_cmd(?PT_TM_REFUSE_JOIN, PS, [ObjPlayerId]) ->
	case mod_team:refuse_join(PS, ObjPlayerId) of
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS#player_status.id, Reason);
		ok ->
			{ok, BinData} = pt_24:write(?PT_TM_REFUSE_JOIN, [?RES_OK, ObjPlayerId]),
			lib_send:send_to_sock(PS, BinData)
	end;


handle_cmd(?PT_TM_QRY_APPLY_LIST, PS, [TeamId]) ->
	case mod_team:query_apply_list(PS, TeamId) of
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS#player_status.id, Reason);
		ApplyList ->
			{ok, BinData} = pt_24:write(?PT_TM_QRY_APPLY_LIST, ApplyList),
			lib_send:send_to_sock(PS, BinData)
	end;


handle_cmd(?PT_TM_CLEAR_APPLY_LIST, PS, [TeamId]) ->
	case mod_team:clear_apply_list(PS, TeamId) of
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason);
		ok ->
			{ok, BinData} = pt_24:write(?PT_TM_CLEAR_APPLY_LIST, [?RES_OK, TeamId]),
			lib_send:send_to_sock(PS, BinData)
	end;


handle_cmd(?PT_TM_GET_MEMBER_POS, PS, _) ->
	case mod_team:get_all_member_id_list(player:get_team_id(PS)) of
		[] -> skip;
		IdList ->
			{ok, BinData} = pt_24:write(?PT_TM_GET_MEMBER_POS, [IdList -- [player:get_id(PS)]]),
			lib_send:send_to_sock(PS, BinData)
	end;


handle_cmd(?PT_TM_GET_LEADER_POS, PS, _) ->
	case player:get_team_id(PS) of
		0 -> skip;
		TeamId ->
			{ok, BinData} = pt_24:write(?PT_TM_GET_LEADER_POS, [mod_team:get_leader_id(TeamId)]),
			lib_send:send_to_sock(PS, BinData)
	end;


handle_cmd(?PT_TM_GET_ONLINE_RELA_PLAYERS, PS, [PageSize, PageIndex]) ->
	L1 = ply_relation:get_online_friend_list(PS),
	L2 = mod_guild:get_online_member_PS_list(player:get_guild_id(PS)) -- [PS],

	F = fun(PS1, PS2) -> player:get_lv(PS1) < player:get_lv(PS2) end,
    ListSort = lists:sort(F, lists:usort(L1 ++ L2)),

	AllLen = length(ListSort),
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
	            lists:sublist(ListSort, IndexStart, IndexEnd - IndexStart + 1)
	    end,

	{ok, BinData} = pt_24:write(?PT_TM_GET_ONLINE_RELA_PLAYERS, [TotalPage, PageIndex, RetList, L1, L2]),
	lib_send:send_to_sock(PS, BinData);


handle_cmd(?PT_TM_USE_ZF, PS, [No]) ->
	case ply_zf:use_zf(PS, No) of
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason);
		ok ->
			{ok, BinData} = pt_24:write(?PT_TM_USE_ZF, [No]),
			lib_send:send_to_sock(PS, BinData)
	end;

handle_cmd(?PT_TM_SET_ZF_POS, PS, [IdPosList]) ->
	case ply_zf:set_zf_pos(PS, IdPosList) of
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason);
		ok -> 
			skip
	end;

%% 改变加入队伍是否需要审核的状态
handle_cmd(?PT_TM_IS_EXAM, PS, [No]) ->
	TeamId = player:get_team_id(PS),
	Team = mod_team:get_team_by_id(TeamId),
	case TeamId =:= ?INVALID_ID of
		true ->
			lib_send:send_prompt_msg(PS, ?PM_NOT_TEAM_LEADER);
		false ->
			case Team =:= null of
				true ->
					lib_send:send_prompt_msg(PS, ?PM_TEAM_NOT_EXISTS);
				false ->
					case mod_team:get_leader_id(Team) =/= player:id(PS) of
						true ->
							lib_send:send_prompt_msg(PS, ?PM_NOT_TEAM_LEADER);
						false ->
							mod_team_mgr:use_exam(TeamId, No)
					end
			end
	end;

handle_cmd(_Cmd, _Status, _Data) ->
	?ASSERT(false),
    ?TRACE("pp_team_new no match", []),
    {error, "pp_team_new no match"}.
    
    
    
% %% =========================================================================================
