%%%------------------------------------
%%% @Module  : mod_team
%%% @Author  : huangjf, zhangwq
%%% @Email   :
%%% @Created : 2013.6
%%% @Description: 组队系统
%%%------------------------------------
-module(mod_team).

-export([
		modify_team/9,					% 修改队伍信息

		set_join_team_aim/6,			% 玩家设置组队目的

		change_member_pos/3,			% 队长交换两个队员的位置

		apply_join/2,					% 玩家申请入队
		refuse_join/2,					% 队长拒绝其他玩家入队

		return_team/2,					% 玩家归队
		invite_return/2,				% 队长邀请玩家归队,玩家收到邀请后，寻路到符合归队条件，发送归队协议到服务器，由return_team处理

 		quit_team/1,           			% 玩家退出队伍
 		tem_leave_team/1,				% 队员暂离队伍

 		invite_others/2,       			% 邀请他人加入队伍
 		disagree_invite/2,				% 落单玩家拒绝队长的入队邀请

 		kick_out_member/2,     			% 队长踢人,请离队伍

		ask_promote_member/2,      		% 队长请求提升队员为新队长
		agree_promote_leader/3,			% 队员同意自己被提升为队长
		disagree_promote_leader/2,		% 队员不同意自己被提升为队长

		apply_for_leader/1,				% 玩家申当队长
		agree_apply_for/2,				% 队长同意队员申当队长的请求
		disagree_apply_for/2,			% 队长不同意队员申当队长的请求

		query_apply_list/2,				% 查询队伍的玩家申请列表
		clear_apply_list/2,				% 清空玩家队伍的申请信息

		get_team_by_id/1,
		get_team_name/1,
		get_leader_id/1,				% 获取某个队的队长id即队长玩家id
		get_team_info/1,				% 获取队伍信息
		get_team_troop/1,

		get_all_member_id_list/1,       % 获取队伍的所有队员id列表
		get_normal_member_id_list/1,	% 获取队伍在队在线的队员id列表（队员id即玩家id）
		get_can_fight_member_id_list/1,	% 获取允许进入战斗的队员id列表（队员id即玩家id）
		get_normal_member_count/1,		% 获取队伍在队在线的队员人数
		get_member_count/1,             % 获取队伍的人数
		get_online_member_count/1,		% 获取在线队伍成员人数
        get_alone_player_list/1,		% 获取落单玩家信息
        get_team_list/0,				% 获取队伍的信息
        get_member_average_lv/1,		% 获取队伍平均等级，如果没有队伍则返回玩家自己等级
        get_normal_member_average_lv/1, % 获取队伍在队在线的队员平均等级，如果没有队伍则返回玩家自己等级
        get_member_max_lv/1,
        get_member_min_lv/1,
        get_member_state/2,
        get_member_troop_pos/2,
        
        is_all_member_in_normal_state/1,% 是否所有队员在队在线
        % get_member_in_normal_state_count/1, % 判断在队伍归队状态的玩家数量
        is_all_member_in_lv_limit/2,    % 是否所有队员都在要求的等级段内
        is_player_tmp_leave/1,			% 判断某个玩家是否暂离，如果没有队伍返回false
        refresh_team_list/4,			% 刷新队伍信息,每10秒只能按一次

        add_mon/3,						% 队长给队伍添加怪物
        get_mon/2,						% 队长获取怪物列表
        try_del_mon/2,					% 尝试清除怪物

        team_reconn_timeout/1,			% 处理队伍重连超时（目前是系统把队长或队员踢出队伍）
        on_player_login/1,				% 处理玩家登陆同步移除踢出队伍作业计划
        on_player_tmp_logout/1,			% 处理若玩家在队则添加踢出队伍作业计划任务
		on_mirage_tmp_logout/1,         % 处理玩家幻境玩法离线则退出队伍
        on_escape_from_battle/1,		% 队员战斗中逃跑
        on_player_upgrade/1,			% 队员升级反馈给各成员
        on_player_quit_dungeon/1,

        is_team_name_valid/1,
		is_player_in_apply_list/2,
		is_team_full/1,

		pick_first_member/2,			% 从列表选出第一个在队在线的队员
		sort_member_by_train_pos/2,
		set_member_no_team_state/1,
do_return_team/2,
        add_team_to_ets/1,
        delete_team_from_ets/1,
        update_team_to_ets/1,
        check_add_mb/0, 				%% 队长进程调用 (主要用于判断限制在队员确认过程中，不能添加成员)	
        on_leader_confirm/2, 			%% 队长进程确认 玩家这个时候 能否 能接受邀请

        leader_change_scene/1
     ]).


-include("common.hrl").
-include("record.hrl").
-include("team.hrl").
-include("protocol/pt_24.hrl").
-include("abbreviate.hrl").
-include("ets_name.hrl").
-include("prompt_msg_code.hrl").
-include("job_schedule.hrl").
-include("goods.hrl").
-include("sys_code.hrl").
-include_lib("stdlib/include/ms_transform.hrl").
-include("dungeon.hrl").
-include("proc_name.hrl").
-include("activity_degree_sys.hrl").
-include("char.hrl").

-include("guild_battle.hrl").

change_member_pos(PS, PlayerId1, PlayerId2) ->
	case check_change_member_pos(PS, PlayerId1, PlayerId2) of
		{fail, Reason} ->
			{fail, Reason};
		ok ->
			do_change_member_pos(PS, PlayerId1, PlayerId2)
	end.


modify_team(PS, TeamId, SceneNo, TeamActivityType, Condition1, Condition2,MinLv,MaxLv, TeamName) ->
	case check_modify_team(PS, TeamId, SceneNo, TeamActivityType, Condition1, Condition2, TeamName) of
		{fail, Reason} ->
			{fail, Reason};
		ok ->
			do_modify_team(PS, TeamId, SceneNo, TeamActivityType, Condition1, Condition2,MinLv,MaxLv, TeamName)
	end.


set_join_team_aim(PS, TeamActivityType, Condition1, Condition2,MinLv,MaxLv) ->
	case check_set_join_team_aim(PS, TeamActivityType, Condition1, Condition2) of
		{fail, Reason} ->
			{fail, Reason};
		ok ->
			do_set_join_team_aim(PS, TeamActivityType, Condition1, Condition2,MinLv,MaxLv)
	end.


%% 查询全服的队伍列表
get_team_list() ->
	ets:tab2list(?ETS_TEAM).


% 刷新队伍信息,每10秒只能按一次，刷新新建立、队伍未满的队伍 增加场景判断 判断队长所在场景
% return 未满的队伍列表
refresh_team_list(SceneId, TeamActivityType, Condition1, Condition2) ->
	?DEBUG_MSG("SceneId=~p",[SceneId]),
	Ms =
		if
			TeamActivityType =/= 0 andalso Condition1 =/= 0 andalso Condition2 =/= 0 ->
				ets:fun2ms(fun(T) when (T#team.team_activity_type =:= TeamActivityType andalso T#team.condition1 =:= Condition1 andalso T#team.condition2 =:= Condition2 andalso
				length(T#team.members) > 0 andalso length(T#team.members) < ?TEAM_MEMBER_MAX) -> T end);
			TeamActivityType =/= 0 andalso Condition1 =/= 0 ->
				ets:fun2ms(fun(T) when (T#team.team_activity_type =:= TeamActivityType andalso T#team.condition1 =:= Condition1 andalso
				length(T#team.members) > 0 andalso length(T#team.members) < ?TEAM_MEMBER_MAX) -> T end);
			TeamActivityType =/= 0 andalso Condition2 =/= 0 ->
				ets:fun2ms(fun(T) when (T#team.team_activity_type =:= TeamActivityType andalso T#team.condition2 =:= Condition2 andalso
				length(T#team.members) > 0 andalso length(T#team.members) < ?TEAM_MEMBER_MAX) -> T end);
			TeamActivityType =/= 0 ->
				ets:fun2ms(fun(T) when (T#team.team_activity_type =:= TeamActivityType andalso length(T#team.members) > 0 andalso length(T#team.members) < ?TEAM_MEMBER_MAX) -> T end);
			true ->
				ets:fun2ms(fun(T) when (length(T#team.members) > 0 andalso length(T#team.members) < ?TEAM_MEMBER_MAX) -> T end)
		end,

 	ets:select(?ETS_TEAM, Ms).


%% return {fail, Reason} | ok
apply_join(PS, LeaderId) ->
	case check_apply_join(PS, LeaderId) of
		{fail, Reason} ->
			{fail, Reason};
		{ok, TeamId} ->
			do_apply_join(PS, TeamId)
	end.


disagree_invite(PS, LeaderId) ->
	% 通知队长邀请结果
	case get_team_info(player:get_team_id(LeaderId)) of
		null -> %% 此队伍已经不存在 无需告诉队长
			ok;
		Team ->
			NewInvitedList = Team#team.invited_list -- [player:get_id(PS)],
			NewTeam = Team#team{invited_list = NewInvitedList},
			update_team_to_ets(NewTeam),
			lib_team:notify_leader_invite_result(LeaderId, 0, player:get_name(PS)),
			ok
	end.


refuse_join(PS, TargetPlayerId) ->
	case check_refuse_join(PS, TargetPlayerId) of
		{fail, Reason} ->
			{fail, Reason};
		ok ->
			do_refuse_join(PS, TargetPlayerId)
	end.


% 玩家归队
return_team(PS, TeamId) ->
	case check_return_team(PS, TeamId) of
		{fail, Reason} ->
			{fail, Reason};
		ok ->
			do_return_team(PS, TeamId),
			ok
	end.


invite_return(PS, TargetPlayerId) ->
	case check_invite_return(PS, TargetPlayerId) of
		{fail, Reason} ->
			{fail, Reason};
		ok ->
			do_invite_return(PS, TargetPlayerId)
	end.


% 队长请求提升队员为队长
ask_promote_member(PS, TargetPlayerId) ->
	case check_ask_promote_member(PS, TargetPlayerId) of
		{fail, Reason} ->
			{fail, Reason};
		ok ->
			do_ask_promote_member(PS, TargetPlayerId)
	end.


agree_promote_leader(PS, TeamId, SendMsgLeaderId) ->
	case check_agree_promote_leader(PS, TeamId) of
		{fail, Reason} ->
			lib_send:send_prompt_msg(player:get_id(PS),Reason ),
			{fail, Reason};
		ok ->
			do_agree_promote_leader(PS, TeamId, SendMsgLeaderId)
	end.


% 队员拒绝队长的提升请求
disagree_promote_leader(PS, TeamId) ->
	case get_team_by_id(TeamId) of
		null ->
			{fail, ?PM_TEAM_NOT_EXISTS};
		Team ->
			case player:id(PS) =:= Team#team.leader_id of
				true -> ok;
				false ->
					{ok, BinData} = pt_24:write(?PT_TM_NOTIFY_PROMOTE_RESULT, [1, player:get_name(PS)]),
					lib_send:send_to_uid(Team#team.leader_id, BinData),
					ok
			end
	end.


% 队长同意队员申当队长的请求
agree_apply_for(PS, TargetPlayerId) ->
	case check_agree_apply_for(PS, TargetPlayerId) of
		{fail, Reason} ->
			{fail, Reason};
		ok ->
			do_agree_apply_for(PS, TargetPlayerId)
	end.


disagree_apply_for(PS, TargetPlayerId) ->
	case player:is_leader(PS) of
		false ->
			{fail, ?PM_NOT_TEAM_LEADER};
		true ->
			case player:id(PS) =:= TargetPlayerId of
				true -> ok;
				false ->
					lib_send:send_prompt_msg(TargetPlayerId, ?PM_REFUSE_YOUR_LEADER_APPLY),
					ok
			end
	end.


%% 玩家申当队长
apply_for_leader(PS) ->
	case check_apply_for_leader(PS) of
		{fail, Reason} ->
			{fail, Reason};
		ok ->
			do_apply_for_leader(PS)
	end.


%% 退出队伍（正常退出队伍）
quit_team(PS) ->
	?TRACE("quit team()~n"),
	case check_quit_team(PS) of
		{fail, Reason} ->
			{fail, Reason};
		ok ->
			do_quit_team(PS, false),
			ok
	end.

%% 退出队伍（正常退出队伍）
quit_team2(PS) ->
	?TRACE("quit team()~n"),
	case check_quit_team(PS) of
		{fail, Reason} ->
			{fail, Reason};
		ok ->
			do_quit_team(PS, false),
			ok
	end.


kick_out_member(PS, TargetPlayerId) ->
	case check_kick_out_member(PS, TargetPlayerId) of
		{fail, Reason} ->
			{fail, Reason};
		ok ->
			do_kick_out_member(PS, TargetPlayerId)
	end.


tem_leave_team(PS) ->
	case check_tem_leave_team(PS) of
		{fail, Reason} ->
			{fail, Reason};
		ok ->
			do_tem_leave_team(PS),
			ok
	end.

query_apply_list(PS, TeamId) ->
	case check_query_apply_list(PS, TeamId) of
		{fail, Reason} ->
			{fail, Reason};
		ok ->
			do_query_apply_list(PS, TeamId)
	end.


clear_apply_list(PS, TeamId) ->
	case TeamId =:= player:get_team_id(PS) of
		false -> {fail, ?PM_NOT_TEAM_LEADER};
		true ->
			case player:is_leader(PS) of
				false ->
					{fail, ?PM_NOT_TEAM_LEADER};
				true ->
					gen_server:cast(?TEAM_PROCESS, {'clear_apply_list', TeamId}),
					ok
			end
	end.


% 获取跟队长同一个场景的最多20个玩家信息
% return 玩家信息列表
get_alone_player_list(PS) ->
	case get_team_by_id(player:get_team_id(PS)) of
		null ->
			[];
		_Team ->
			?ASSERT(player:is_leader(PS), player:get_id(PS)),
			?ASSERT(player:get_id(PS) =:= _Team#team.leader_id, _Team#team.leader_id),
			ScenePlayerIdList = lib_scene:get_scene_player_ids(player:get_scene_id(PS)) -- [player:get_id(PS)],
			
			LvLimit = ply_sys_open:get_sys_open_lv(?SYS_TEAM),
			F0 = fun(Id, Acc) ->
				case player:is_online(Id) of
					false -> Acc;
					true ->
						case player:get_team_id(Id) =:= ?INVALID_ID andalso player:get_lv(Id) >= LvLimit of
							false -> Acc;
							true -> [Id | Acc]
						end
				end
			end,

			ScenePlayerIdList1 = lists:foldl(F0, [], ScenePlayerIdList),
			PlayerCount =
			case length(ScenePlayerIdList1) > ?PLAYER_COUNT_ALONE_LIST of
				false -> length(ScenePlayerIdList1);
				true -> ?PLAYER_COUNT_ALONE_LIST
			end,
			TargetIdList = tool:shuffle(ScenePlayerIdList1, PlayerCount),
			F = fun(PlayerId) ->
				Sex = player:get_sex(PlayerId),
				Name = player:get_name(PlayerId),
				Level = player:get_lv(PlayerId),
				Faction = player:get_faction(PlayerId),
				GuildName = ply_guild:get_guild_name(PlayerId),
				SceneNo = player:get_scene_no(PlayerId),
				% 组队目的
				TeamActivityType = player:get_team_target_type(PlayerId),
				Condition1 = player:get_team_condition1(PlayerId),
				Condition2 = player:get_team_condition2(PlayerId),
				VipLv = player:get_vip_lv(PlayerId),
				BattlePower = ply_attr:get_battle_power(PlayerId),
				[PlayerId, Sex, Name, Level, Faction, GuildName, SceneNo, TeamActivityType, Condition1, Condition2, VipLv,BattlePower]
			end,
			[F(X) || X <- TargetIdList]
	end.


invite_others(PS, TargetPlayerId) ->
	case check_invite_others(PS, TargetPlayerId) of
		{fail, Reason} ->
			{fail, Reason};
		ok ->
			do_invite_others(PS, TargetPlayerId)
	end.


%% 玩家获取自己的队伍信息
%% @return: null | team结构体
get_team_info(PS) when is_record(PS, player_status) ->
	get_team_by_id(player:get_team_id(PS));

%% 依据队伍id获取队伍信息
%% @return: null | team结构体
get_team_info(TeamId) when is_integer(TeamId) ->
	get_team_by_id(TeamId).


% 获取某个队的队长id即队长玩家id
get_leader_id(TeamId) when is_integer(TeamId) ->
	case get_team_info(TeamId) of
		null ->
			?INVALID_ID;
		Team ->
			Team#team.leader_id
	end;
get_leader_id(Team) ->
	Team#team.leader_id.

get_team_name(TeamId) ->
	case get_team_info(TeamId) of
		null ->
			?ASSERT(false),
			error;
		Team ->
			Team#team.team_name
	end.

get_team_troop(TeamId) when is_integer(TeamId) ->
	case TeamId =:= ?INVALID_ID of
		true -> ?INVALID_NO;
		false ->
			case get_team_info(TeamId) of
				null ->
					?ASSERT(false),
					?INVALID_NO;
				Team ->
					Team#team.troop_no
			end
	end;
get_team_troop(Team) ->
	Team#team.troop_no.

is_player_tmp_leave(PS) ->
	case get_team_info(player:get_team_id(PS)) of
		null ->
			false;
		Team ->
			case lib_team:get_member_by_id(player:get_id(PS), Team#team.members) of
				null -> false;
				Mb -> Mb#mb.state =:= ?MB_STATE_TEM_LEAVE
			end
	end.

is_all_member_in_normal_state(TeamId) when is_integer(TeamId) ->
	case get_team_info(TeamId) of
		null ->
			?ASSERT(false),
			false;
		Team ->
			is_all_member_in_normal_state(Team#team.members)
	end;
is_all_member_in_normal_state([Mb | T]) ->
	case Mb#mb.state /= ?MB_STATE_IN of
		true -> false;
		false -> is_all_member_in_normal_state(T)
	end;
is_all_member_in_normal_state([]) ->
	true.


% get_member_in_normal_state_count(TeamId) when is_integer(TeamId) ->
% 	case get_team_info(TeamId) of
% 		null ->
% 			?ASSERT(false),
% 			false;
% 		Team ->
% 			get_member_in_normal_state_count(Team#team.members,0)
% 	end;
% get_member_in_normal_state_count([Mb | T],Count) ->
% 	case Mb#mb.state == ?MB_STATE_IN of
% 		true -> get_member_in_normal_state_count(T,Count + 1);
% 		false -> get_member_in_normal_state_count(T,Count)
% 	end;
% get_member_in_normal_state_count([],Count) ->
% 	Count.


% 判断队伍里每个人的等级是否都在要求的等级段内 LimitList = [{MinLv, MaxLv}, ... ]
is_all_member_in_lv_limit(TeamId, LimitList) when is_integer(TeamId) ->
    case get_team_info(TeamId) of
        null -> 
            ?ASSERT(false),
            false;
        Team ->
            is_all_member_in_lv_limit(Team#team.members, LimitList)
    end;

is_all_member_in_lv_limit(_Mbs, []) ->    false;
is_all_member_in_lv_limit(Mbs, [{MinLv, MaxLv} | LimitRest]) ->
    case is_all_member_in_lv_limit__(Mbs, {MinLv, MaxLv}) of
        true -> true;
        false -> is_all_member_in_lv_limit(Mbs, LimitRest)
    end.


is_all_member_in_lv_limit__([Mb | T], {MinLv, MaxLv}) ->
    MemberLv = player:get_lv(Mb#mb.id),
    case MinLv > MemberLv orelse MemberLv > MaxLv of
        true -> false;
        false -> is_all_member_in_lv_limit__(T, {MinLv, MaxLv})
    end;
is_all_member_in_lv_limit__([], {_,_}) ->
    true.


get_member_average_lv(PlayerId) ->
	case get_team_info(player:get_team_id(PlayerId)) of
		null -> player:get_lv(PlayerId);
		Team ->
			IdList = get_all_member_id_list(Team),
			LvTotal = lists:foldl(fun(X, Sum) -> player:get_lv(X) + Sum end, 0, IdList),
			util:ceil(LvTotal / length(IdList))
	end.

get_normal_member_average_lv(PlayerId) when is_integer(PlayerId) ->
	case get_team_info(player:get_team_id(PlayerId)) of
		null -> player:get_lv(PlayerId);
		Team ->
			IdList = get_normal_member_id_list(Team),
			LvTotal = lists:foldl(fun(X, Sum) -> player:get_lv(X) + Sum end, 0, IdList),
			util:ceil(LvTotal / length(IdList))
	end;

get_normal_member_average_lv(PS) ->
	case get_team_info(player:get_team_id(PS)) of
		null -> player:get_lv(PS);
		Team ->
			IdList = get_normal_member_id_list(Team),
			LvTotal = lists:foldl(fun(X, Sum) -> player:get_lv(X) + Sum end, 0, IdList),
			util:ceil(LvTotal / length(IdList))
	end.


get_member_max_lv(PS) ->
	case get_team_info(player:get_team_id(PS)) of
		null -> player:get_lv(PS);
		Team ->
			IdList = get_all_member_id_list(Team),
			LvList = [player:get_lv(X) || X <- IdList],
			LvList1 = lists:sort(LvList),
			Index = length(LvList1),
			lists:nth(Index, LvList1)
	end.

get_member_min_lv(PS) ->
	case get_team_info(player:get_team_id(PS)) of
		null -> player:get_lv(PS);
		Team ->
			IdList = get_all_member_id_list(Team),
			LvList = [player:get_lv(X) || X <- IdList],
			LvList1 = lists:sort(LvList),
			lists:nth(1, LvList1)
	end.

%% 获取队伍的所有队员id列表（队员id即玩家id）
%% @return: [] | 队员id列表
get_all_member_id_list(Team) when is_record(Team, team) ->
	[Mb#mb.id || Mb <- Team#team.members];

get_all_member_id_list(TeamId) when is_integer(TeamId) ->
	case get_team_info(TeamId) of
		null ->
			[];
		Team ->
			[Mb#mb.id || Mb <- Team#team.members]
	end;
get_all_member_id_list(_) ->
	[].


%% 获取队伍在队在线队员id列表（队员id即玩家id）
%% @return: [] | 队员id列表
get_normal_member_id_list(Team) when is_record(Team, team) ->
	[Mb#mb.id || Mb <- Team#team.members, Mb#mb.state =:= ?MB_STATE_IN];

get_normal_member_id_list(TeamId) when is_integer(TeamId) ->
	case get_team_info(TeamId) of
		null ->
			[];
		Team ->
			get_normal_member_id_list(Team)
	end;
get_normal_member_id_list(_) ->
	[].

get_can_fight_member_id_list(Team) when is_record(Team, team) ->
	[Mb#mb.id || Mb <- Team#team.members, Mb#mb.state =:= ?MB_STATE_IN orelse Mb#mb.state =:= ?MB_STATE_OFFLINE];

get_can_fight_member_id_list(TeamId) when is_integer(TeamId) ->
	case get_team_info(TeamId) of
		null ->
			[];
		Team ->
			get_can_fight_member_id_list(Team)
	end.

get_normal_member_count(TeamId) when is_integer(TeamId) ->
	length(get_normal_member_id_list(TeamId));

get_normal_member_count(Team) ->
	length(get_normal_member_id_list(Team)).

get_online_member_count(Team) when is_record(Team, team) ->
	L = [Mb#mb.id || Mb <- Team#team.members, Mb#mb.state =:= ?MB_STATE_IN orelse Mb#mb.state =:= ?MB_STATE_TEM_LEAVE],
	length(L).


%% 获取队伍的队员id列表（队员id即玩家id）
%% @return: [] | 队员id列表
get_member_count(Team) when is_record(Team, team) ->
	length(Team#team.members);

get_member_count(TeamId) when is_integer(TeamId) ->
	case get_team_info(TeamId) of
		null ->
			?ASSERT(false, TeamId),
			0;
		Team ->
			length(Team#team.members)
	end.



%% 判断队伍是否满人了
%% @return: true | false
is_team_full(Team_Or_TeamId)  ->
	get_member_count(Team_Or_TeamId) == ?TEAM_MEMBER_MAX.


% 处理队伍重连超时（目前是系统把队长或队员踢出队伍）
team_reconn_timeout(PS) ->
	TeamId = player:get_team_id(PS),
	PlayerId = player:id(PS),
	case ply_tmplogout_cache:is_in_team(PS) of
        true ->
			mod_team_mgr:sys_kick_out_member(TeamId, PS);
        false ->
            case TeamId =:= ?INVALID_ID of
            	true ->
            		% 不在队伍，则直接标记处理队伍重连超时完毕，勿忘！
            		mod_lginout_TSL:mark_handle_game_logic_reconn_timeout_done(?SYS_TEAM, PlayerId);
            	false -> %% 进一步判断处理，避免队伍数据残余
            		mod_team_mgr:sys_kick_out_member(TeamId, PS)
            end
    end.



	


% 处理若玩家在队则添加踢出队伍作业计划任务
on_player_tmp_logout(PS) ->
	?Ifc (player:is_in_team(PS))
		% 通知队伍自己离线了
		mod_team_mgr:offline(PS)
	?End.

% 处理若玩家在队则添加踢出队伍作业计划任务
on_mirage_tmp_logout(PS) ->
	?Ifc (player:is_in_team(PS))
	% 通知队伍自己离线了
	lib_mystery:handle_leave_team(PS)
?End.

% 处理玩家登陆同步移除踢出队伍作业计划
on_player_login(PS) ->
	case player:is_in_team(PS) of
		false -> skip;
		true ->
			% 玩家上线如果是队长则立刻归队，若果是队员则处于暂离状态,如果队伍只有一个人，则为队长
			case player:is_leader(PS) of
				false ->
					case get_member_count(player:get_team_id(PS)) =:= 1 of
						false ->
							case get_normal_member_count(player:get_team_id(PS)) > 0 of
								true ->
									?TRACE("mod_team:on_player_login Id:~p do_tem_leave_team~n", [player:get_id(PS)]),
									do_tem_leave_team(PS);
								false ->
									may_change_team_leader(PS),
									?TRACE("mod_team:on_player_login Id:~p return_team~n", [player:get_id(PS)]),
									do_return_team(PS, player:get_team_id(PS))
							end;
						true ->
							may_change_team_leader(PS),
							?TRACE("mod_team:on_player_login Id:~p return_team~n", [player:get_id(PS)]),
							do_return_team(PS, player:get_team_id(PS))
					end;
				true ->
					do_return_team(PS, player:get_team_id(PS)),
					?TRACE("mod_team:on_player_login Id:~p return_team~n", [player:get_id(PS)])
			end
	end.


%% MonList --> [{MonId, MonNo} ...]
add_mon(_PS, _TaskId, []) ->
	skip;
add_mon(PS, TaskId, MonList) ->
	[{_MonId, _MonNo} | _T] = MonList,
	case player:is_leader(PS) of
		false ->
			?ASSERT(false, player:get_id(PS)),
			skip;
		true ->
			case get_team_info(player:get_team_id(PS)) of
				null ->
					?ASSERT(false, player:get_team_id(PS)),
					skip;
				Team ->
					TaskMonList =
						case lists:keyfind(TaskId, 1, Team#team.task_mon_list) of
							false ->
								[{TaskId, MonList} | Team#team.task_mon_list];
							{_TaskId, OldMonList} ->
								lists:keyreplace(TaskId, 1, Team#team.task_mon_list, {TaskId, OldMonList ++ MonList})
						end,
					NewTeam = Team#team{task_mon_list = TaskMonList},
					update_team_to_ets(NewTeam)
			end
	end.


%% return [{MonId, MonNo} ...]
get_mon(PS, TaskId) ->
	case get_team_info(player:get_team_id(PS)) of
		null ->
			?ASSERT(false, player:get_team_id(PS)),
			[];
		Team ->
			case lists:keyfind(TaskId, 1, Team#team.task_mon_list) of
				false -> [];
				{_TaskId, MonList} ->
					F = fun({MonId, MonNo}, AccList) ->
						Mon = mod_mon:get_obj(MonId),
						case (Mon /= null) andalso (not mod_mon:is_expired(Mon)) of
							true -> [{MonId, MonNo} | AccList];
							false -> AccList
						end
					end,
					RetList = lists:foldl(F, [], MonList),
					%% 检查是否需要清理数据
					case RetList =:= [] of
						false ->
							skip;
						true ->
							NewTaskMonList = lists:keydelete(TaskId, 1, Team#team.task_mon_list),
							NewTeam = Team#team{task_mon_list = NewTaskMonList},
							update_team_to_ets(NewTeam)
					end,
					RetList
			end
	end.


try_del_mon(PS, MonId) ->
	case player:is_leader(PS) of
		false ->
			skip;
		true ->
			case get_team_info(player:get_team_id(PS)) of
				null ->
					skip;
				Team ->
					F = fun({TaskId, MonList}, AccList) ->
						case lists:keyfind(MonId, 1, MonList) of
							false ->
								[{TaskId, MonList} | AccList];
							{MonId1, MonNo} ->
								NewMonList = MonList -- [{MonId1, MonNo}],
								case NewMonList =:= [] of
									true -> AccList;
									false -> [{TaskId, NewMonList} | AccList]
								end
						end
					end,
					NewTaskMonList = lists:foldl(F, [], Team#team.task_mon_list),
					NewTeam = Team#team{task_mon_list = NewTaskMonList},
					update_team_to_ets(NewTeam)
			end
	end.


on_escape_from_battle(PlayerId) ->
	case player:get_PS(PlayerId) of
		null ->
			skip;
		PS ->
			case get_team_info(player:get_team_id(PS)) of
				null ->
					skip;
				Team ->
					case player:id(PS) =:= mod_team:get_leader_id(Team) of
						false ->
							case player:is_in_dungeon(PS) of
								false -> 
									do_tem_leave_team(PS);
								{true, _Pid} -> 
									DunType = lib_dungeon:get_dungeon_type(player:get_dungeon_no(PS)),
								    if
								        DunType =:= ?DUNGEON_TYPE_GUILD_PREPARE ->
								            do_tem_leave_team(PS);
								        DunType =:= ?DUNGEON_TYPE_GUILD_BATTLE ->
								            do_tem_leave_team(PS);
								        true ->
								            mod_team_mgr:do_quit_team(PS, true)
								    end
							end;
						true ->
							do_quit_team(PS, true)
					end
			end
	end.


on_player_upgrade(PS) ->
	case get_team_info(player:get_team_id(PS)) of
		null ->
			skip;
		Team ->
			lib_team:notify_member_info_change(Team, player:id(PS), [{?TM_OI_CODE_LV, player:get_lv(PS)}])
	end.


% ---------------------------------------------------------Local Function------------------------------------------------

do_quit_team(PS, IsEscape) ->
	case player:is_in_dungeon(PS) of
		false ->
			mod_team_mgr:do_quit_team(PS, IsEscape);
		{true, _Pid} ->
			DunType = lib_dungeon:get_dungeon_type(player:get_dungeon_no(PS)),
		    if
		        DunType =:= ?DUNGEON_TYPE_GUILD_PREPARE ->
		            mod_team_mgr:do_quit_team(PS, IsEscape, false);
		        DunType =:= ?DUNGEON_TYPE_GUILD_BATTLE ->
		            mod_team_mgr:do_quit_team(PS, IsEscape, false);
		        true ->
		            mod_team_mgr:do_quit_team(PS, IsEscape)
		    end
	end.	


%% 因所有队员几乎同时下线，那个先上线，那个就是队长
may_change_team_leader(PS) ->
	TeamId = player:get_team_id(PS),
	case get_team_info(TeamId) of
		null -> skip;
		Team ->
			case lib_team:get_member_by_id(player:get_id(PS), Team#team.members) of
				null -> skip;
				_HMb ->
					case player:id(PS) =:= get_leader_id(Team) of
						true ->
							player:mark_leader_flag(PS),
							lib_team:notify_leader_changed(Team, ?INVALID_ID),
							skip;
						false ->
							gen_server:cast(?TEAM_PROCESS, {'change_leader_on_player_login', PS}),
							player:mark_leader_flag(PS)
					end
			end
	end.


check_change_member_pos(PS, PlayerId1, PlayerId2) ->
	try check_change_member_pos__(PS, PlayerId1, PlayerId2) of
		ok ->
			ok
	catch
		throw: FailReason ->
			{fail, FailReason}
	end.


check_change_member_pos__(PS, PlayerId1, PlayerId2) ->
	?Ifc (not player:is_leader(PS))
		throw(?PM_NOT_TEAM_LEADER)
	?End,
	TeamId = player:get_team_id(PS),
	TeamId1 = player:get_team_id(PlayerId1),
	TeamId2 = player:get_team_id(PlayerId2),
	?Ifc (TeamId /= TeamId1)
		throw(?PM_PARA_ERROR)
	?End,
	?Ifc (TeamId /= TeamId2)
		throw(?PM_PARA_ERROR)
	?End,
	ok.


check_modify_team(PS, TeamId, SceneNo, TeamActivityType, Condition1, Condition2, TeamName) ->
	try check_modify_team__(PS, TeamId, SceneNo, TeamActivityType, Condition1, Condition2, TeamName) of
        ok ->
            ok
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.


check_modify_team__(PS, TeamId, _SceneNo, TeamActivityType, Condition1, Condition2, TeamName) ->
	?Ifc (not util:in_range(TeamActivityType, ?TM_TYPE_MIN, ?TM_TYPE_MAX))
		throw(?PM_PARA_ERROR)
	?End,

	?Ifc (not util:in_range(Condition1, ?TM_CON1_MIN, ?TM_CON1_MAX))
		throw(?PM_PARA_ERROR)
	?End,

	?Ifc ( (not util:in_range(Condition2, ?TM_MON_LV_STEP_MIN, ?TM_MON_LV_STEP_MAX)) andalso (lib_dungeon:get_config_data(Condition2) =:= null) )
		throw(?PM_PARA_ERROR)
	?End,

	?ASSERT(is_list(TeamName), TeamName),
	Team = get_team_info(PS),
	?Ifc (Team =:= null)
		throw(?PM_TEAM_NOT_EXISTS)
	?End,

	?Ifc (Team#team.team_id =/= TeamId)
		throw(?PM_UNKNOWN_ERR)
	?End,

	case is_team_name_valid(TeamName) of
		{false, len_error} ->
			throw(?PM_TEAM_NAME_LEN_ERROR);
		{false, char_illegal} ->
			throw(?PM_TEAM_NAME_CHAR_ILLEGEL);
		true ->
			ok
	end.


check_set_join_team_aim(_PS, TeamActivityType, Condition1, _Condition2) ->
	case util:in_range(TeamActivityType, ?TM_TYPE_MIN, ?TM_TYPE_MAX) andalso util:in_range(Condition1, ?TM_CON1_MIN, ?TM_CON1_MAX) of
		false ->
			{fail, ?PM_PARA_ERROR};
		true ->
			ok
	end.


do_set_join_team_aim(PS, TeamActivityType, Condition1, Condition2,MinLv,MaxLv) ->
	player:set_team_target_type(PS, TeamActivityType),
	player:set_team_condition1(PS, Condition1),
	player:set_team_condition2(PS, Condition2),
	player:set_team_lv_range(PS,MinLv,MaxLv),
	case mod_team:get_team_info(PS) of
		null ->
			skip;
		Team ->
			NewTeam = Team#team{condition1=Condition1, condition2 = Condition2, lv_range = {MinLv, MaxLv}},
			update_team_to_ets(NewTeam),
			{ok, BinData} = pt_24:write(?PT_TM_NOTIFY_TEAM_INFO_CHANGE, [NewTeam, lib_team:get_learned_zf_nos(NewTeam)]),
			lib_send:send_to_team(NewTeam, BinData)
	end,
	ok.


%% 检查队名长度是否合法
%% @return: true | {false, Reason}
is_team_name_valid(TeamName) ->
	case asn1rt:utf8_binary_to_list(list_to_binary(TeamName)) of
       	{ok, CharList} ->
           	Len = util:string_width(CharList),
           	% 队名最大长度：最多能输入9个汉字
           	case Len < 19 andalso Len > 1 of
               	true ->
                   	case util:has_illegal_char(CharList) of % 是否包含非法字符（如：空格，反斜杠）
                   		true ->
                   			{false, char_illegal};
                   		false ->
                   			true
                   	end;
               false ->
                   % 队伍名称长度为1~9个汉字
                   	{false, len_error}
           end;
       	{error, _Reason} ->
           % 非法字符
           	{false, char_illegal}
   end.


do_change_member_pos(PS, PlayerId1, PlayerId2) ->
	case get_team_info(PS) of
		null ->
			?ASSERT(false);
		Team ->
			case lists:keyfind(PlayerId1, #mb.id, Team#team.members) of
				false -> ?ASSERT(false);
				Mb1 ->
					case lists:keyfind(PlayerId2, #mb.id, Team#team.members) of
						false -> ?ASSERT(false);
						Mb2 ->
							Mb11 = Mb1#mb{train_pos = Mb2#mb.train_pos},
							Mb22 = Mb2#mb{train_pos = Mb1#mb.train_pos},
							MembersList1 = lists:keyreplace(PlayerId1, #mb.id, Team#team.members, Mb11),
							MembersList2 = lists:keyreplace(PlayerId2, #mb.id, MembersList1, Mb22),
							NewTeam = Team#team{members = MembersList2},
							update_team_to_ets(NewTeam),
							lib_team:notify_member_change_pos(NewTeam, PlayerId1, PlayerId2),
							ok
					end
			end
	end.

% 队长切换场景
leader_change_scene(PS) ->
	case get_team_info(PS) of
		null ->
			skip;
		Team ->
			% 如果该玩家是队长
			case Team#team.leader_id =:= player:id(PS) of
				true ->
					NewTeam = Team#team{scene = player:get_scene_id(PS)},
					update_team_to_ets(NewTeam);
				false ->
					skip
			end
	end.

do_modify_team(PS, _TeamId, SceneNo, TeamActivityType, Condition1, Condition2,MinLv,MaxLv, TeamName) ->
	case get_team_info(PS) of
		null ->
			?ASSERT(false),
			{ok, null};
		Team ->
			?ASSERT(Team#team.team_id =:= _TeamId),
			NewTeam = Team#team{
								scene = SceneNo,
								team_activity_type = TeamActivityType,
    							condition1 = Condition1,
    							condition2 = Condition2,
    							lv_range = {MinLv,MaxLv},
    							team_name = list_to_binary(TeamName)
								},
			update_team_to_ets(NewTeam),

			{ok, NewTeam}
	end.


check_invite_others(PS, TargetPlayerId) ->
	try check_invite_others__(PS, TargetPlayerId) of
		ok -> ok
	catch
		throw: FailReason ->
			{fail, FailReason}
	end.


check_invite_others__(PS, TargetPlayerId) ->
	?Ifc (not player:is_leader(PS))
		throw(?PM_NOT_TEAM_LEADER)
	?End,
	ObjTeamId = player:get_team_id(TargetPlayerId),
	?Ifc (ObjTeamId =:= player:get_team_id(PS))
		throw(?PM_TM_OBJ_IN_TEAM)
	?End,

	?Ifc (ObjTeamId =/= player:get_team_id(PS) andalso ObjTeamId =/= 0)
		throw(?PM_ALREADY_IN_OTHER_TEAM)
	?End,

	?Ifc (is_team_full( player:get_team_id(PS)))
		throw(?PM_TEAM_IS_FULL)
	?End,
	Team = get_team_info(PS),
	?Ifc (Team =:= null)
		throw(?PM_TEAM_NOT_EXISTS)
	?End,

	ObjPS = player:get_PS(TargetPlayerId),
	?Ifc (ObjPS =:= null)
		throw(?PM_TARGET_PLAYER_NOT_ONLINE)
	?End,

	?Ifc (not ply_sys_open:is_open(ObjPS, ?SYS_TEAM))
		throw(?PM_TEAM_NEED_LV_LIMIT)
	?End,

	?Ifc (not ply_setting:accept_team_invite(TargetPlayerId))
		throw(?PM_TM_OBJ_REFUSE_TEAM)
	?End,

	% ?Ifc (lists:member(player:get_id(PS), Team#team.invited_list))
	% 	throw(?PM_HAVE_INVITED)
	% ?End,
%%
%%	?Ifc (not player:is_idle(ObjPS))
%%        throw(?PM_OBJ_BUSY_NOW)
%%    ?End,

%%    ?Ifc (player:is_offline_guaji(ObjPS))
%%    	throw(?PM_PLAYER_STATE_OFFLINE_GUAJI)
%%    ?End,

    CurBhvState = player:get_cur_bhv_state(PS),
	if
		CurBhvState =:= ?BHV_COUPLE_HIDE ->
			throw(?PM_BUSY_NOW);
		true ->
			skip
	end,
	ok.
%%	mod_team_mgr:check_add_mb(PS, ObjPS).


do_invite_others(PS, TargetPlayerId) ->
	case get_team_info(PS) of
		null ->
			?ASSERT(false);
		Team ->
			NewInvitedList = Team#team.invited_list ++ [TargetPlayerId],
			NewTeam = Team#team{invited_list = NewInvitedList},
			update_team_to_ets(NewTeam),

			{ok, BinData} = pt_24:write(?PT_TM_GOT_INVITE, [player:get_id(PS), player:get_name(PS), player:get_lv(PS), NewTeam#team.team_activity_type,
				NewTeam#team.scene, NewTeam#team.condition1, NewTeam#team.condition2]),
			lib_send:send_to_uid(TargetPlayerId, BinData)
			%% 如果自身有抓鬼任务，让对方自动接取
%% 			PlayerId = player:get_id(PS),
%% 			case lib_task:get_task_ghost_id(PlayerId) of
%% 				{ok, TaskId} ->
%% 					lib_task:force_accept_ghost_task(TargetPlayerId, TaskId);
%% 				_ ->
%% 					ok
%% 			end
	end,
	ok.


check_apply_join(PS, LeaderId) ->
	try check_apply_join__(PS, LeaderId) of
		{ok, TeamId} -> {ok, TeamId}
	catch
		throw: FailReason ->
			{fail, FailReason}
	end.


check_apply_join__(PS, LeaderId) ->
	?Ifc (player:is_in_team(PS))
		throw(?PM_ALREADY_IN_TEAM)
	?End,

	LeaderPS = player:get_PS(LeaderId),
	?Ifc (LeaderPS =:= null)
		throw(?PM_TM_LEADER_OFFLINE)
	?End,

	TeamId = player:get_team_id(LeaderPS),
	Team = get_team_by_id(TeamId),
	?Ifc (Team == null)
		throw(?PM_TEAM_NOT_EXISTS)
	?End,

	?Ifc (is_team_full(TeamId))
		throw(?PM_TEAM_IS_FULL)
	?End,
	
	?Ifc (is_player_in_apply_list(player:get_id(PS), TeamId))
		throw(?PM_HAVE_APPLIED)
	?End,

	?Ifc (not player:is_idle(PS))
        throw(?PM_BUSY_NOW)
    ?End,

    CurBhvState = player:get_cur_bhv_state(LeaderPS),
	if
		CurBhvState =:= ?BHV_COUPLE_HIDE ->
			throw(?PM_TM_BUSY_NOW);
		true ->
			skip
	end,

	%% 判断队长是否在幻境中(申请入队)
	PlayerList = case ets:lookup(ets_mirage_player,mirage_player) of
						[] ->
							[];
						[{mirage_player,MiragePlayer}] ->
							MiragePlayer
				 end,
	?Ifc (lists:member(LeaderId, PlayerList))
		throw(?PM_MIRAGE_APPLY_JOIN)
	?End,

	mod_team_mgr:check_add_mb(PS, LeaderPS, ?PM_CANT_APPLY_WHEN_IN_DUNGEON),
	{ok, TeamId}.


%% return ok | fail
do_apply_join(PS, TeamId) ->
	gen_server:cast(?TEAM_PROCESS, {'do_apply_join', PS, TeamId}),
	ok.


check_refuse_join(PS, TargetPlayerId) ->
	try check_refuse_join__(PS, TargetPlayerId) of
		ok -> ok
	catch
		throw: FailReason ->
			{fail, FailReason}
	end.

check_refuse_join__(PS, TargetPlayerId) ->
	?Ifc (not player:is_leader(PS))
		throw(?PM_NOT_TEAM_LEADER)
	?End,
	Team = get_team_by_id(player:get_team_id(PS)),
	?Ifc (Team =:= null)
		throw(?PM_TEAM_NOT_EXISTS)
	?End,
	?Ifc (lists:keyfind(TargetPlayerId, #apply.player_id, Team#team.apply_list) =:= false)
		throw(?PM_PARA_ERROR)
	?End,
	ok.


do_refuse_join(PS, TargetPlayerId) ->
	case get_team_by_id(player:get_team_id(PS)) of
		null ->
			fail;
		Team ->
			NewApplyList = lists:keydelete(TargetPlayerId, #apply.player_id, Team#team.apply_list),
  			NewTeam = Team#team{apply_list = NewApplyList},
  			update_team_to_ets(NewTeam),
			ok
	end.


check_return_team(PS, TeamId) ->
	try check_return_team__(PS, TeamId) of
		ok -> ok
	catch
		throw: FailReason ->
			{fail, FailReason}
	end.

check_return_team__(PS, TeamId) ->
	?Ifc (not player:is_idle(PS))
        throw(?PM_BUSY_NOW)
    ?End,
    
	Team = get_team_by_id(TeamId),
	?Ifc (Team =:= null)
		throw(?PM_TEAM_NOT_EXISTS)
	?End,

	?Ifc (get_member_state(Team, player:id(PS)) =:= ?MB_STATE_IN)
		throw(?PM_HAVE_RETURN_TEAM_OK)
	?End,

	?Ifc (player:get_team_id(PS) /= TeamId)
		throw(?PM_PARA_ERROR)
	?End,

	TPS = player:get_PS(Team#team.leader_id),
	?Ifc (TPS =:= null)
		throw(?PM_UNKNOWN_ERR)
	?End,

	?Ifc (not player:is_idle(TPS))
        throw(?PM_TM_BUSY_NOW)
    ?End,
    
	% 队长在乱斗场景中，我不在则不能归队
	?Ifc (player:is_in_melee(TPS) andalso (player:get_scene_id(PS) =/= player:get_scene_id(TPS)) )
		throw(?PM_CANT_RETURN_WHEN_LEADER_IN_MELEE)
	?End,

	{Scene1,_,_} =  ?GUILD_ENTER1_CONFIG,
    {Scene2,_,_} =  ?GUILD_ENTER2_CONFIG,
    {Scene3,_,_} =  ?GUILD_ENTER3_CONFIG,

    case lists:member(player:get_scene_id(TPS),[Scene1,Scene2,Scene3]) of
    	true ->
    		throw(?PM_GUILD_BATTLE_YOU_TEAM_IS_IN_BATTLE);
    	false ->
    		skip
    end,

	case player:is_in_dungeon(PS) of
		{true, _DungeonPid} ->
			DunType = lib_dungeon:get_dungeon_type(player:get_dungeon_no(PS)),
			if
				DunType =:= ?DUNGEON_TYPE_BOSS orelse DunType =:= ?DUNGEON_TYPE_GUILD_BATTLE orelse DunType =:= ?DUNGEON_TYPE_GUILD_PREPARE ->
					case player:is_in_dungeon(TPS) of
						{true, _} ->
							DunType1 = lib_dungeon:get_dungeon_type(player:get_dungeon_no(TPS)),
							if
								DunType1 =:= ?DUNGEON_TYPE_BOSS ->
									ok;
								(DunType =:= DunType1) andalso (DunType1 =:= ?DUNGEON_TYPE_GUILD_BATTLE orelse DunType1 =:= ?DUNGEON_TYPE_GUILD_PREPARE) ->
									ok;
								true ->
									throw(?PM_CANT_RETURN_TM_WHEN_YOU_IN_DUNGEON)
							end;
						false -> throw(?PM_CANT_RETURN_TM_WHEN_YOU_IN_DUNGEON)
					end;
				true ->
					throw(?PM_CANT_RETURN_TM_WHEN_YOU_IN_DUNGEON)
			end;
		false ->
			% 判断队伍是否在副本中，在副本不能归队
			case player:is_in_dungeon(TPS) of
				{true, _DungeonPid} ->
					throw(?PM_CANT_RETURN_TM_WHEN_TM_IN_DUNGEON);
				false ->
					ok
			end
	end.

	% ?Ifc (player:get_scene_id(PS) /= player:get_scene_id(mod_team:get_leader_id(TeamId)))
	% 	throw(?PM_NOT_IN_SAME_SCENE)
	% ?End,
	% {X1, Y1} = player:get_xy(PS),
	% {X2, Y2} = player:get_xy(mod_team:get_leader_id(TeamId)),
	% ?Ifc (util:calc_manhattan_distance(X1, Y1, X2, Y2) > ?DISTANCE_RETURN_TEAM)
	% 	throw(?PM_PARA_ERROR)
	% ?End,
	% ok.


do_return_team(PS, TeamId) ->
	gen_server:cast(?TEAM_PROCESS, {'do_return_team', PS, TeamId}).


check_invite_return(PS, TargetPlayerId) ->
	case player:is_leader(PS) =:= false of
		true -> {fail, ?PM_NOT_TEAM_LEADER};
		false ->
			case player:is_online(TargetPlayerId) =:= false of
				true -> {fail, ?PM_PLAYER_OFFLINE_OR_NOT_EXISTS};
				false -> ok
			end
	end.


do_invite_return(PS, TargetPlayerId) ->
	case player:get_sendpid(TargetPlayerId) of
		null ->
			fail;
		Pid ->
			{ok, BinData} = pt_24:write(?PT_TM_INVITE_YOU_RETURN, [player:get_team_id(PS)]),
			lib_send:send_to_sid(Pid, BinData),
			ok
	end.


check_ask_promote_member(PS, TargetPlayerId) ->
	try check_ask_promote_member__(PS, TargetPlayerId) of
		ok -> ok
	catch
		throw: FailReason ->
			{fail, FailReason}
	end.

check_ask_promote_member__(PS, TargetPlayerId) ->
	?Ifc (player:get_id(PS) == TargetPlayerId)
		throw(?PM_PARA_ERROR)
	?End,
	?Ifc (not player:is_leader(PS))
		throw(?PM_NOT_TEAM_LEADER)
	?End,
	?Ifc (not player:is_online(TargetPlayerId))
		throw(?PM_PLAYER_OFFLINE_OR_NOT_EXISTS)
	?End,
	?Ifc (get_member_state(player:get_team_id(PS), TargetPlayerId) /= ?MB_STATE_IN)
		throw(?PM_PLAYER_TMP_LEAVE)
	?End,
	?Ifc (not ply_setting:is_cant_be_leader(TargetPlayerId))
		throw(?PM_TM_OBJ_REFUSE_LEADER)
	?End,
	
	CurBhvState = player:get_cur_bhv_state(PS),
	if
		CurBhvState =:= ?BHV_COUPLE_HIDE ->
			throw(?PM_BUSY_NOW);
		true ->
			ok
	end.


do_ask_promote_member(PS, TargetPlayerId) ->
	case player:get_sendpid(TargetPlayerId) of
		null ->
			fail;
		Pid ->
			TeamId = player:get_team_id(PS),
			{ok, BinData} = pt_24:write(?PT_TM_PROMOTE_YOU, [TeamId, player:id(PS)]),
			lib_send:send_to_sid(Pid, BinData),
			ok
	end.


check_agree_promote_leader(PS, TeamId) ->
	try check_agree_promote_leader__(PS, TeamId) of
		ok -> ok
	catch
		throw: FailReason ->
			{fail, FailReason}
	end.

check_agree_promote_leader__(PS, TeamId) ->
	?Ifc (get_team_by_id(TeamId) == null)
		throw(?PM_TEAM_NOT_EXISTS)
	?End,
	?Ifc (not player:is_in_team(PS))
		throw(?PM_NOT_IN_TEAM)
	?End,
	?Ifc (get_member_state(TeamId, player:get_id(PS)) /= ?MB_STATE_IN)
		throw(?PM_PLAYER_TMP_LEAVE)
	?End,
	%% 判断队长是否在幻境中(同意当队长)
	PlayerList = case ets:lookup(ets_mirage_player,mirage_player) of
					[] ->
						[];
					[{mirage_player,MiragePlayer}] ->
						MiragePlayer
				 end,
	LeaderId = player:get_leader_id(PS),
	?Ifc (lists:member(LeaderId, PlayerList))
		throw(?PM_MIRAGE_APPLY_FOR_LEADER)
	?End,
	ok.


check_agree_apply_for(PS, TargetPlayerId) ->
	try check_agree_apply_for__(PS, TargetPlayerId) of
		ok -> ok
	catch
		throw: FailReason ->
			{fail, FailReason}
	end.

check_agree_apply_for__(PS, TargetPlayerId) ->
	?Ifc (not player:is_leader(PS))
		throw(?PM_NOT_TEAM_LEADER)
	?End,
	?Ifc (not player:is_online(TargetPlayerId))
		throw(?PM_TARGET_PLAYER_NOT_ONLINE)
	?End,
	?Ifc (not player:is_in_team(TargetPlayerId))
		throw(?PM_OBJ_NOT_IN_TEAM)
	?End,
	?Ifc (player:get_team_id(TargetPlayerId) /= player:get_team_id(PS))
		throw(?PM_ALREADY_IN_OTHER_TEAM)
	?End,
	?Ifc (get_member_state(player:get_team_id(PS), TargetPlayerId) /= ?MB_STATE_IN)
		throw(?PM_PLAYER_TMP_LEAVE)
	?End,
	ok.


do_agree_apply_for(PS, TargetPlayerId) ->
	case get_team_by_id(player:get_team_id(PS)) of
		null -> fail;
		Team ->
			case lib_team:get_member_by_id(TargetPlayerId, Team#team.members) of
				null ->
					fail;
				Mb ->
					% 取消原队长的资格
					OldLeaderId = Team#team.leader_id,
					OldLeaderMb = lib_team:get_member_by_id(OldLeaderId, Team#team.members),
					?ASSERT(OldLeaderMb /= null),
					% 交换阵法和拖火车站位
					Mb1 = Mb#mb{troop_pos = OldLeaderMb#mb.troop_pos, train_pos = OldLeaderMb#mb.train_pos},
					OldLeaderMb1 = OldLeaderMb#mb{troop_pos = Mb#mb.troop_pos, train_pos = Mb#mb.train_pos},
					% 队长站在最前，其他的依次后移一个位置
					NewMemberList = lists:keydelete(Mb#mb.id, #mb.id, Team#team.members), % 先把新队长删除
					NewMemberList1 = [Mb1] ++ NewMemberList, % 把新队长放在首位
					% 更新原队长的站位
					NewMemberList2 = lists:keyreplace(OldLeaderMb1#mb.id, #mb.id, NewMemberList1, OldLeaderMb1),
					NewTeam = Team#team{
										leader_id = Mb#mb.id,
										leader_pid = Mb#mb.pid,
										leader_name = Mb#mb.name,
										team_name = list_to_binary(binary_to_list(Mb#mb.name) ++ binary_to_list(<<"的队伍">>)),
										members = NewMemberList2
										},
					update_team_to_ets(NewTeam),

					player:clear_leader_flag(OldLeaderId),
					player:mark_leader_flag(TargetPlayerId),

					lib_team:notify_leader_changed(NewTeam, OldLeaderId),
					ok
			end
	end.


check_apply_for_leader(PS) ->
	try check_apply_for_leader__(PS) of
		ok -> ok
	catch
		throw: FailReason ->
			{fail, FailReason}
	end.

check_apply_for_leader__(PS) ->
	?Ifc (get_team_by_id(player:get_team_id(PS)) == null)
		throw(?PM_TEAM_NOT_EXISTS)
	?End,
	?Ifc (not player:is_in_team(PS))
		throw(?PM_NOT_IN_TEAM)
	?End,
	?Ifc (get_member_state(player:get_team_id(PS), player:get_id(PS)) /= ?MB_STATE_IN)
		throw(?PM_PLAYER_TMP_LEAVE)
	?End,
	?Ifc (player:is_leader(PS))
		throw(?PM_IS_ALREADY_LEADER)
	?End,
	%% 判断队长是否在幻境中(申请队长)
	PlayerList = case ets:lookup(ets_mirage_player,mirage_player) of
		[] ->
			[];
		[{mirage_player,MiragePlayer}] ->
			MiragePlayer
				 end,
	LeaderId = player:get_leader_id(PS),
	?Ifc (lists:member(LeaderId, PlayerList))
		throw(?PM_MIRAGE_APPLY_FOR_LEADER)
	?End,
	CurBhvState = player:get_cur_bhv_state(PS),
	if
		CurBhvState =:= ?BHV_COUPLE_HIDE ->
			throw(?PM_BUSY_NOW);
		true ->
			ok
	end.


do_apply_for_leader(PS) ->
	case get_team_by_id(player:get_team_id(PS)) of
		null ->
			fail;
		Team ->
			case player:get_sendpid(Team#team.leader_id) of
				null ->
					fail;
				Pid ->
					{ok, BinData} = pt_24:write(?PT_TM_MEM_APPLY_FOR_LEADER, [player:get_id(PS), player:get_name(PS)]),
					lib_send:send_to_sid(Pid, BinData),
					ok
			end
	end.


do_agree_promote_leader(PS, TeamId, SendMsgLeaderId) ->
	gen_server:cast(?TEAM_PROCESS, {'do_agree_promote_leader', PS, TeamId, SendMsgLeaderId}).


check_quit_team(PS) ->
	case player:is_online(player:get_id(PS)) andalso (not player:is_in_team(PS)) of
		true -> {fail, ?PM_NOT_IN_TEAM};
		false ->
			case get_team_by_id(player:get_team_id(PS)) of
				null -> {fail, ?PM_TEAM_NOT_EXISTS};
				_Any -> 
					CurBhvState = player:get_cur_bhv_state(PS),
					if
						CurBhvState =:= ?BHV_COUPLE_HIDE ->
							{fail, ?PM_BUSY_NOW};
						true ->
							ok
					end
			end
	end.


check_kick_out_member(PS, TargetPlayerId) ->
	try check_kick_out_member__(PS, TargetPlayerId) of
		ok -> ok
	catch
		throw: FailReason ->
			{fail, FailReason}
	end.

check_kick_out_member__(PS, TargetPlayerId) ->
	?Ifc (not player:is_leader(PS))
		throw(?PM_NOT_TEAM_LEADER)
	?End,

	TargetPS = player:get_PS(TargetPlayerId),
	?Ifc (TargetPS =/= null andalso not player:is_in_team(TargetPS))
		throw(?PM_NOT_IN_TEAM)
	?End,

	CurBhvState = player:get_cur_bhv_state(PS),
	if
		CurBhvState =:= ?BHV_COUPLE_HIDE ->
			throw(?PM_BUSY_NOW);
		true -> skip
	end,
	ok.


check_tem_leave_team(PS) ->
	try check_tem_leave_team__(PS) of
		ok -> ok
	catch
		throw: FailReason ->
			{fail, FailReason}
	end.

check_tem_leave_team__(PS) ->
	?Ifc (player:is_leader(PS))
		throw(?PM_LEADER_CANT_TMP_LEAVE)
	?End,

	%% 判断队长是否在幻境中(暂时离队)
	PlayerList = case ets:lookup(ets_mirage_player,mirage_player) of
		[] ->
			[];
		[{mirage_player,MiragePlayer}] ->
			MiragePlayer
				 end,
	LeaderId = player:get_leader_id(PS),
	?Ifc (lists:member(LeaderId, PlayerList))
		throw(?PM_MIRAGE_LEAVE_TEAM)
	?End,
	
	% 判断是否在副本中，在副本不能暂离
	case player:is_in_dungeon(PS) of
		{true, _DungeonPid} ->
			DunType = lib_dungeon:get_dungeon_type(player:get_dungeon_no(PS)),
			if
				DunType =:= ?DUNGEON_TYPE_BOSS orelse DunType =:= ?DUNGEON_TYPE_GUILD_PREPARE orelse DunType =:= ?DUNGEON_TYPE_GUILD_BATTLE ->
					ok;
				true ->
					throw(?PM_CANT_TMP_LEAVE_WHEN_IN_DUNGEON)
			end;
		false ->
			ok
	end.


do_kick_out_member(PS, TargetPlayerId) ->
	case get_team_by_id(player:get_team_id(PS)) of
		null -> ok;
		Team ->
			OldMbList = Team#team.members,
			case lists:keyfind(TargetPlayerId, #mb.id, OldMbList) of
				false -> ok;
				Mb ->
					NewMbList = OldMbList -- [Mb],
					case NewMbList =:= [] of %% 检测队伍人数，如果没人了，及时解散队伍，避免内存泄漏
						true ->
							lib_team:notify_member_quit(Team, player:get_id(PS), 0),
							% 更新队员玩家状态,设置is_leader为false,team_id为0
							set_member_no_team_state(Team),
							% 解散队伍
							delete_team_from_ets(Team#team.team_id),
							ok;
						false ->
							NewTeam = Team#team{members = NewMbList},

							case player:is_online(TargetPlayerId) of
								true -> 
									player:clear_team_id(TargetPlayerId),
									case player:get_PS(TargetPlayerId) of
										null -> ok;
										TmpPS -> 
											case player:get_dungeon_no(PS) of
												null -> skip;
												DunNo ->
													DunType = lib_dungeon:get_dungeon_type(DunNo),
												    if
												        DunType =:= ?DUNGEON_TYPE_GUILD_PREPARE orelse DunType =:= ?DUNGEON_TYPE_GUILD_BATTLE ->
												            skip;
												        true ->
															lib_dungeon:notify_dungeon_quit_team(TmpPS, get_leader_id(NewTeam))
													end
											end,
											%% 让被踢玩家放弃其身上的抓鬼任务
											lib_task:force_abandon_ghost_task(TargetPlayerId)
									end;
								false ->
									case player:in_tmplogout_cache(TargetPlayerId) of
										false -> ok;
										true ->
											TmpLogoutPS = ply_tmplogout_cache:get_tmplogout_PS(TargetPlayerId),
											ply_tmplogout_cache:set_team_id(TmpLogoutPS, ?INVALID_ID)
									end
							end,
							% 向组队成员提示：XXX已被请离队伍！向请离对象发出提示：你已经被请离队伍！
							lib_team:notify_kick_out_member(Team, TargetPlayerId),
							update_team_to_ets(NewTeam),
							lib_team:notify_member_aoi_change(NewTeam, TargetPlayerId),
							ok
					end
			end
	end.


do_tem_leave_team(PS) ->
	gen_server:cast(?TEAM_PROCESS, {'do_tem_leave_team', PS}).

%% 非队长玩家主动退出副本，调用
%% 玩家主动退出副本的回调 当队伍有两个人以上，则让这个玩家退出队伍
on_player_quit_dungeon(PS) ->
	gen_server:cast(?TEAM_PROCESS, {'on_player_quit_dungeon', PS}).

check_query_apply_list(PS, TeamId) ->
	case player:is_in_team(PS) of
		false -> {fail, ?PM_NOT_IN_TEAM};
		true ->
			case player:get_team_id(PS) /= TeamId of
				true -> {fail, ?PM_PARA_ERROR};
				false ->
					case player:is_leader(PS) == false of
						true -> {fail, ?PM_NOT_TEAM_LEADER};
						false -> ok
					end
			end
	end.


do_query_apply_list(_PS, TeamId) ->
	?ASSERT(player:get_team_id(_PS) =:= TeamId),
	case get_team_by_id(TeamId) of
		null ->
			fail;
		Team ->
			Team#team.apply_list
	end.


% 更新队员玩家状态,设置is_leader为false,team_id为0
set_member_no_team_state(Team) ->
	case lib_team:get_team_member_list(Team) of
		[] ->
			skip;
		MbList ->
			MbIdList = [Mb#mb.id || Mb <- MbList],
    		F = fun(Id) ->
            	case player:is_online(Id) of
					true ->
						% player_syn:set_team_id(Id, ?INVALID_ID),
						% player_syn:set_leader_flag(Id, false);
						player:set_team_id(Id, ?INVALID_ID),
						player:clear_leader_flag(Id);
					false ->
						case player:in_tmplogout_cache(Id) of
							false -> skip;
							true ->
								TmpLogoutPS = ply_tmplogout_cache:get_tmplogout_PS(Id),
								ply_tmplogout_cache:set_team_id(TmpLogoutPS, ?INVALID_ID),
								ply_tmplogout_cache:set_leader_flag(TmpLogoutPS, false)
						end
				end
        	end,
    		lists:foreach(F, MbIdList)
    end.


% return
% -define(MB_STATE_TEM_LEAVE, 1). % 暂离
% -define(MB_STATE_IN, 2). % 在队在线
% -define(MB_STATE_OFFLINE, 3). % 在队离线
% | 0
get_member_state(TeamId, MemberId) when is_integer(TeamId) ->
	case get_team_by_id(TeamId) of
		null -> ?INVALID_NO;
		Team -> get_member_state(Team, MemberId)
	end;
get_member_state(Team, MemberId) ->
	case lists:keyfind(MemberId, #mb.id, Team#team.members) of
		false -> ?INVALID_NO;
		Mb -> Mb#mb.state
	end.


get_member_troop_pos(TeamId, PlayerId) ->
	case get_team_by_id(TeamId) of
		null -> ?INVALID_NO;
		Team ->
			case lists:keyfind(PlayerId, #mb.id, Team#team.members) of
				false -> ?INVALID_NO;
				Mb -> Mb#mb.troop_pos
			end
	end.

%% 依据队伍id获取队伍信息
%% return: null | team结构体
get_team_by_id(TeamId) ->
	case ets:lookup(?ETS_TEAM, TeamId) of
        [] -> null;
        [Team] -> Team
    end.


%% 玩家是否在某个队的申请队列中
%% return false | true
is_player_in_apply_list(PlayerId, TeamId) ->
	case get_team_by_id(TeamId) of
		null ->
			false;
		Team ->
			case lists:keyfind(PlayerId, #apply.player_id, Team#team.apply_list) of
				false -> false;
				_ApplyInfo -> true
			end
	end.


%% 获取队伍阵型中最正面（依据出手顺序的先后）的空位
% get_head_empty_pos_in_troop(Team) ->
% 	TroopNo = Team#team.troop_no,
% 	MemberList = Team#team.members,
% 	AllPosList = lib_troop:get_troop_pos_list(TroopNo),
% 	CurOccupyPosList = [X#mb.troop_pos || X <- MemberList],
% 	EmptyPosList = AllPosList -- CurOccupyPosList,
% 	?TRACE("empty pos list: ~p~n", [EmptyPosList]),
% 	case EmptyPosList =:= [] of
% 		true -> ?INVALID_NO; %% 容错，正常情况下不会触发此分支
% 		false ->
% 			[HeadEmptyPos | _T] = EmptyPosList,
% 			HeadEmptyPos
% 	end.


%% 添加一条队伍概要信息到ets
add_team_to_ets(NewTeam) when is_record(NewTeam, team) ->
	true = ets:insert_new(?ETS_TEAM, NewTeam).


update_team_to_ets(NewTeam) when is_record(NewTeam, team) ->
	ets:insert(?ETS_TEAM, NewTeam).


%% 从ets删除一条队伍信息
delete_team_from_ets(TeamId) ->
	ets:delete(?ETS_TEAM, TeamId).


%% 从列表选出第一个在队在线的队员
%% @return: null | mb结构体
pick_first_member([Mb | T_MbList], State) ->
	case Mb == none of
		true ->
			pick_first_member(T_MbList, State);
		false ->
			case Mb#mb.state =:= State of
				false -> pick_first_member(T_MbList, State);
				true -> Mb
			end
	end;
pick_first_member([], _State) ->
	null.


sort_member_by_train_pos(MbList, TypeSortBy) ->
	F =
	case TypeSortBy of
		train_pos -> fun(Mb1, Mb2) -> Mb1#mb.train_pos < Mb2#mb.train_pos end;
		_Any -> skip
	end,
	lists:sort(F, MbList).


on_leader_confirm(PS, LeaderId) ->
	case check_add_mb() of
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason);
		ok ->
			mod_team_mgr:agree_invite(PS, LeaderId)
	end.


%% 队长进程调用 (主要用于判断限制在队员确认过程中，不能添加成员)
check_add_mb() ->
    try 
        check_add_mb__()
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.


check_add_mb__() ->
	?Ifc (lib_dungeon:get_ensure_list() =/= null)
		throw(?PM_TM_WAIT_MB_CONFIRM)
	?End,

	?Ifc (lib_team:get_ensure_list(?AD_TVE) =/= null)
        throw(?PM_TM_WAIT_MB_CONFIRM)
    ?End,

    ok.
