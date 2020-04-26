%%%------------------------------------
%%% @Module  : lib_team
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2011.12
%%% @Description: 组队系统相关接口
%%%------------------------------------

-module(lib_team).

-export([
		get_teammate_id_list/1,
 		get_member_by_id/2,
 		get_team_member_list/1,

 		pack_member/2,  				% 组装队员信息列表（用于发给客户端）
 		pack_brief_member/2,

 		set_ensure_list/2,
 		del_ensure_list/2,
 		get_ensure_list/1,
 		cancel_ensure/1,

        get_troop_no_by_player_id/1,    % 获取玩家所在队伍能用的阵法编号
        get_zf_attr_add/3,              % 获取阵法加成效果
        get_usable_zf_nos/1,            % 获取队伍当前可用的阵法编号列表
        get_learned_zf_nos/1,           % 获取队伍当前已经学习的阵法编号列表
        adjust_cur_zf/2,                % 检查当前阵法是否还生效

		notify_leader_invite_result/3,
		notify_member_join/2,
		notify_member_offline/2,
		notify_leader_changed/2,
		notify_member_quit/3,
		notify_kick_out_member/2,
		notify_member_change_pos/3,
		notify_member_temp_leave/2,
		notify_member_return/2,
		notify_member_info_change/3,
		notify_player_enter_team_aoi/2,
		notify_sworn_info_change/3,
		notify_member_aoi_change/2,
        notify_team_info_change/2,
        notify_team_zf_pos_change/2
		]).

-include("common.hrl").
-include("pt_24.hrl").
-include("pt_12.hrl").
-include("goods.hrl").
-include("faction.hrl").
-include("team.hrl").
-include("debug.hrl").
-include("obj_info_code.hrl").
-include("record.hrl").
-include("zf.hrl").

get_troop_no_by_player_id(PlayerId) ->
    case player:get_team_id(PlayerId) of
        ?INVALID_ID ->
            ply_zf:get_common_zf();
        TeamId ->
            case mod_team:get_team_info(TeamId) of
                null ->
                    ply_zf:get_common_zf();
                Team ->
                    ZfNo = Team#team.troop_no,
                    case ZfNo =:= ?INVALID_NO of
                        true -> ply_zf:get_common_zf();
                        false ->
                            case data_zf:get(ZfNo) of
                                null -> ply_zf:get_common_zf();
                                DataCfg ->
                                    case DataCfg#zf_cfg.cnt_limit =< length(mod_team:get_can_fight_member_id_list(Team)) of
                                        true -> 
                                            case lists:member(ZfNo, get_learned_zf_nos(Team)) of
                                                true -> ZfNo;
                                                false -> ply_zf:get_common_zf()
                                            end;
                                        false -> ply_zf:get_common_zf()
                                    end
                            end
                    end
            end
    end.



%% para :
%%  ZfNo --> 本方阵法编号, 
%%  OppZfNo --> 对方阵法编号，
%%  Pos -->     自己站的位置
%% return --> #attrs{}
get_zf_attr_add(ZfNo, OppZfNo, Pos) ->
    DataCfg = data_zf:get(ZfNo),

    % 类型
    ZfType = case DataCfg of
        null -> 0;
        DataCfg -> 
            DataCfg#zf_cfg.type
    end,

    OppDataCfg = data_zf:get(OppZfNo),

    OppZfType = case OppDataCfg of
        null -> 0;
        OppDataCfg -> 
            OppDataCfg#zf_cfg.type
    end,
    
    CorrectValue = 
        case data_zf_def_attr:get(ZfType, OppZfType) of
            null -> 0;
            DataDefCfg -> DataDefCfg#zf_def_attr_cfg.zf_def_attr
        end,

    AttrNameValueL2 = #attrs{do_phy_dam_scaling = CorrectValue,do_mag_dam_scaling = CorrectValue},

    AttrNameValueL1 = 
        case DataCfg of
            null -> [];
            DataCfg -> 
                case Pos of
                    1 -> DataCfg#zf_cfg.pos_attr_1;
                    2 -> DataCfg#zf_cfg.pos_attr_2;
                    3 -> DataCfg#zf_cfg.pos_attr_3;
                    4 -> DataCfg#zf_cfg.pos_attr_4;
                    5 -> DataCfg#zf_cfg.pos_attr_5;
                    _ -> []
                end
        end,

    lib_attribute:attr_bonus(AttrNameValueL2,AttrNameValueL1).


get_learned_zf_nos(Team) when is_record(Team, team) ->
    case player:get_PS(Team#team.leader_id) of
        PS when is_record(PS,player_status) -> player:get_zf_state(PS);
        _ -> []
    end;

get_learned_zf_nos(PS) when is_record(PS, player_status) ->
    player:get_zf_state(PS);

    
get_learned_zf_nos(_Other) ->
    ?ASSERT(false, _Other),
    [].

get_usable_zf_nos(Team) ->
    ZfL = get_learned_zf_nos(Team),
    MbCnt = mod_team:get_normal_member_count(Team),

    F1 = fun(No, Acc) ->
        case data_zf:get(No) of
            null -> Acc;
            Data ->
                case MbCnt >= Data#zf_cfg.cnt_limit of
                    true -> [No | Acc];
                    false -> Acc
                end
        end
    end,
    lists:foldl(F1, [], ZfL).


adjust_cur_zf(Team, ZfL) ->
    case lists:member(Team#team.troop_no, ZfL) of
        true -> Team;
        false -> Team#team{troop_no = ply_zf:get_common_zf()}
    end.


%% 获取队友id列表（不包括自己）
get_teammate_id_list(PlayerId) when is_integer(PlayerId) ->
	case player:get_PS(PlayerId) of
		null -> [];
		PS -> get_teammate_id_list(PS)
	end;
get_teammate_id_list(PS) ->
	case player:is_in_team(PS) of
		true ->
			MyId = player:id(PS),
			TeamId = player:get_team_id(PS),
			mod_team:get_all_member_id_list(TeamId) -- [MyId];
		false ->
			[] 
	end.



%% 组装队员信息列表（用于发给客户端）
pack_member(Team, MemberList) when is_record(Team, team) ->
    F = fun(Mb) ->
    		PS = 
	    		case player:get_PS(Mb#mb.id) of
	            	null ->
	            		ply_tmplogout_cache:get_tmplogout_PS(Mb#mb.id);
	            	PS__ ->
	            		PS__
	            end,
	        case PS =:= null of
	        	true -> %% 容错
	        		[Mb#mb.id, 1, <<"">>, Mb#mb.troop_pos, Mb#mb.train_pos, ?FACTION_XMD, ?SEX_MALE, 0, Mb#mb.state, 0, ?RACE_REN, ?INVALID_NO, ?INVALID_NO, ?INVALID_ID, 
	        		?INVALID_NO, ?INVALID_NO, ?INVALID_NO, ?INVALID_NO, ?INVALID_NO, 0];
                false ->
                	?ASSERT(Mb#mb.id =:= player:get_id(PS)),
                	?ASSERT(Mb#mb.name =:= player:get_name(PS)),
                	SwornId = ply_relation:get_sworn_id(Mb#mb.id),
                	ShowEquips = player:get_showing_equips(PS),
                    SceneNo = 
                        case lib_scene:get_obj(player:get_scene_id(PS)) of
                            null -> ?INVALID_NO;
                            SceneObj -> lib_scene:get_id(SceneObj)
                        end,
                	[
                		Mb#mb.id,
                		player:get_lv(PS),
                		player:get_name(PS),
                		Mb#mb.troop_pos,
                		Mb#mb.train_pos,
                		player:get_faction(PS), 
                		player:get_sex(PS),
                		player:get_scene_id(PS),
                		Mb#mb.state,
                		SceneNo,
                		player:get_race(PS),

					    ShowEquips#showing_equip.weapon,
					    ShowEquips#showing_equip.backwear,

					    SwornId,
					    lib_relation:get_sworn_type_by_id(SwornId),
					    player:get_suit_no(PS),
					    ShowEquips#showing_equip.headwear,
						ShowEquips#showing_equip.clothes,
                        ShowEquips#showing_equip.magic_key,
                        ply_attr:get_battle_power(PS)
                	]
			end
    end,
   
    [F(Mb) || Mb <- MemberList].

pack_brief_member(Team, MemberList) when is_record(Team, team) ->
    F = fun(Mb, AccList) ->
    		[{Mb#mb.id, Mb#mb.state, Mb#mb.name} | AccList]
    end,
   	lists:foldl(F, [], MemberList).



%% 获取队伍的队员列表
%% @return: [] | mb结构体列表（返回空列表表示获取失败）
get_team_member_list(Team) when is_record(Team, team) ->
	Team#team.members.


% 服务器通知队长邀请玩家入队结果-
%%		Result 			u8     0表示拒绝，1表示同意
%% 		Name 			string 玩家名
notify_leader_invite_result(LeaderId, Result, PlayerName) ->
	{ok, BinData} = pt_24:write(?PT_TM_NOTIFY_LEADER_INVITE_RESULT, [Result, PlayerName]),
	lib_send:send_to_uid(LeaderId, BinData).



% 服务器主动通知所有队员某个玩家加入队伍
notify_member_join(Team, NewMember) ->
	[MemberData] = pack_member(Team, [NewMember]),
    {ok, BinData} = pt_24:write(?PT_TM_NOTIFY_MEMBER_JOIN, MemberData),
    lib_send:send_to_team(Team, BinData),
    lib_scene:notify_int_info_change_to_aoi(player, NewMember#mb.id, [{?OI_CODE_TEAM_ID, Team#team.team_id}]).


% 服务器主动通知所有队员某个玩家离线
notify_member_offline(Team, PlayerId) ->
	{ok, BinData} = pt_24:write(?PT_TM_NOTIFY_MEMBER_OFFLINE, [0, PlayerId]),
	lib_send:send_to_team(Team, BinData).

%% 通知队伍成员：队长更改了
notify_leader_changed(Team, OldLeaderId) ->
	?TRACE("notify_leader_changed()...new leader: ~p~n", [Team#team.leader_id]),
	{ok, BinData} = pt_24:write(?PT_TM_NOTIFY_LEADER_CHANGED, [Team#team.leader_id]),
	lib_send:send_to_team(Team, BinData),
	case player:get_PS(Team#team.leader_id) of
		null -> skip;
		PS -> lib_dungeon:notify_dungeon_change_captain(PS)
	end,
	case OldLeaderId =:= ?INVALID_ID of
		true -> skip;
		false -> lib_scene:notify_int_info_change_to_aoi(player, OldLeaderId, [{?OI_CODE_LEADER_FLAG, 0}])
	end,
	lib_scene:notify_int_info_change_to_aoi(player, Team#team.leader_id, [{?OI_CODE_LEADER_FLAG, 1}]).




% 通知队员有人离队，队长变化等
%%     	QPlayerId        int64     离队队员id
%%		NewLeaderId		 int64	   新队长id，如果队长没有变化则为0
notify_member_quit(Team, QPlayerId, NewLeaderId) ->
	?TRACE("leave player: ~p, NewLeader: ~p ~n", [QPlayerId, NewLeaderId]),
	{ok, BinData} = pt_24:write(?PT_TM_NOTIFY_MEMBER_QUIT, [QPlayerId, NewLeaderId]),
	% 系统向组队成员提示：XX离开了队
	lib_send:send_to_team(Team, BinData),
	lib_scene:notify_int_info_change_to_aoi(player, QPlayerId, [{?OI_CODE_TEAM_ID, ?INVALID_ID}]),
	case NewLeaderId =:= 0 of
		false ->
			case player:get_PS(NewLeaderId) of
				null -> skip;
				PS -> lib_dungeon:notify_dungeon_change_captain(PS)
			end,
			lib_scene:notify_int_info_change_to_aoi(player, QPlayerId, [{?OI_CODE_LEADER_FLAG, 0}]),
			lib_scene:notify_int_info_change_to_aoi(player, NewLeaderId, [{?OI_CODE_LEADER_FLAG, 1}]);
		true ->
			skip
	end.


notify_kick_out_member(Team, TargetPlayerId) ->
	{ok, BinData} = pt_24:write(?PT_TM_NOTIFY_KICK_OUT_MEMBER, [0, TargetPlayerId]),
	lib_send:send_to_team(Team, BinData).


% 服务器主动通知所有队员更新某两个队员的站位-
notify_member_change_pos(Team, PlayerId1, PlayerId2) ->
	{ok, BinData} = pt_24:write(?PT_TM_NOTIFY_MEMBER_CHANGE_POS, [PlayerId1, PlayerId2]),
	lib_send:send_to_team(Team, BinData).


% 服务器主动通知所有队员某个队员暂离队伍
notify_member_temp_leave(Team, PlayerId) ->
	{ok, BinData} = pt_24:write(?PT_TM_NOTIFY_MEMBER_TEMP_LEAVE, [0, PlayerId]),
	lib_send:send_to_team(Team, BinData).



% 服务器主动通知所有队员某个玩家归队
notify_member_return(Team, PlayerId) ->
	{ok, BinData} = pt_24:write(?PT_TM_NOTIFY_MEMBER_RETURN, [0, PlayerId]),
	lib_send:send_to_team(Team, BinData).



%% 通知队伍成员：更新队员的一个或多个信息
%% @para: KV_TupleList => 格式如：[{信息代号，新的值}, ...]
notify_member_info_change(Team, PlayerId, KV_TupleList) ->
	?ASSERT(util:is_tuple_list(KV_TupleList)),
	{ok, BinData} = pt_24:write(?PT_TM_NOTIFY_MB_INFO_CHANGE, [PlayerId, KV_TupleList]),
	lib_send:send_to_team(Team, BinData).



notify_player_enter_team_aoi(Team, PlayerId) ->
	?TRACE("~n~n~n!!!!!!!!!lib_team, notify_player_enter_team_aoi(), PlayerId:~p~n", [PlayerId]),
	% AOI处理统一cast到go进程去做
	mod_go:notify_player_enter_team_aoi(Team, PlayerId).





%% Para 注意：Team 里面的成员已经不包含PlayerId
notify_member_aoi_change(Team, PlayerId) ->
	case player:is_online(PlayerId) of
		false -> skip;
		true ->
			SceneLine = player:get_scene_line(PlayerId),
			SceneId = player:get_scene_id(PlayerId),
		    {ok, Bin_LeaveNotice} = pt_12:write(?PT_NOTIFY_PLAYERS_LEAVE_MY_AOI, [PlayerId]),
		    IdList = [X#mb.id || X <- Team#team.members],

		    F = fun(X, AccList) ->
		    	case player:is_online(X) of
		    		false -> AccList;
		    		true ->
		    			case player:get_scene_id(X) =/= SceneId of
		    				true -> AccList;
		    				false ->
		    					case player:get_scene_line(X) =:= SceneLine of
		    						true -> AccList;
		    						false -> [X | AccList]
		    					end
		    			end
		    	end
		    end,
		    IdList1 = lists:foldl(F, [], IdList),
		    %% 通知剩余的队员
		    [lib_send:send_to_uid(Id, Bin_LeaveNotice) || Id <- IdList1],

		    %% 通知离开的那个人
		    case IdList1 =:= [] of
		    	true -> skip;
		    	false ->
				    {ok, Bin_LeaveNotice1} = pt_12:write(?PT_NOTIFY_PLAYERS_LEAVE_MY_AOI, IdList1),
				    lib_send:send_to_uid(PlayerId, Bin_LeaveNotice1)
			end
	end.


notify_sworn_info_change(PlayerId, SwornId, SwornType) ->
	case player:get_PS(PlayerId) of
		null -> skip;
		PS ->
			{ok, BinData} = pt_24:write(?PT_TM_NOTIFY_SWORN_INFO_CHANGE, [PlayerId, SwornId, SwornType]),
			lib_send:send_to_team(PS, BinData)
	end.


%% 从队员列表中获取id为Id的队员
%% @return: null | mb结构体
get_member_by_id(Id, MemberList) ->
	% 勿忘：先判断Mb是否不为none!
	case [X || X <- MemberList, (X /= none) andalso (X#mb.id == Id)] of
		[] ->
			null;
		[Mb] ->
			Mb;
		_Any ->
			?ERROR_MSG("[lib_team] get_member_by_id() error!! ~w ~n", [MemberList])
	end.


%% 队长进程处理
set_ensure_list(ActNo, List) ->
    put({ActNo, ?TEAM_ENSURE_LIST}, {ActNo, List}).


del_ensure_list(ActNo, Elm) ->
    case get_ensure_list(ActNo) of
        null -> skip;
        {ActNo, List} ->
            NewList = lists:delete(Elm, List),
            set_ensure_list(ActNo, NewList)
    end.


get_ensure_list(ActNo) ->
    case get({ActNo,?TEAM_ENSURE_LIST}) of
        undefined -> null;
        Rd -> Rd
    end.

cancel_ensure(ActNo) -> 
    erlang:erase({ActNo, ?TEAM_ENSURE_LIST}).


notify_team_info_change(Team, ZfL) when is_record(Team, team) ->
    {ok, BinData} = pt_24:write(?PT_TM_NOTIFY_TEAM_INFO_CHANGE, [Team, ZfL]),
    lib_send:send_to_team(Team, BinData);
    
notify_team_info_change(PS, ZfL) ->
    case player:get_team_id(PS) of
        ?INVALID_NO -> 
            skip;
        TeamId ->
            case mod_team:get_team_by_id(TeamId) of
                null -> skip;
                Team -> notify_team_info_change(Team, ZfL)
            end
    end.


notify_team_zf_pos_change(Team, IdPosList) ->
    {ok, BinData} = pt_24:write(?PT_TM_SET_ZF_POS, [IdPosList]),
    lib_send:send_to_team(Team, BinData).    