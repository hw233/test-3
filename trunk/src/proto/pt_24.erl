%%%------------------------------------
%%% @Module  : pt_24
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2013.06.26
%%% @Description: 组队协议
%%%------------------------------------

-module(pt_24).
-export([read/2, write/2]).

-include("common.hrl").
% -include("record.hrl").
% -include("team.hrl").
-include("debug.hrl").
-include("protocol/pt_24.hrl").
-include("team.hrl").
-include("zf.hrl").
-include("record.hrl").

% %%
% %%客户端 -> 服务端 ----------------------------
% %%

%% 创建队伍
read(?PT_TM_CREATE, <<TeamId:32, SceneNo:32, TeamActivityType:8, Condition1:8, Condition2:32,MinLv:32, MaxLv:32, TeamName/binary>>) ->
    {TeamName1, _} = pt:read_string(TeamName),
    {ok, [TeamId, SceneNo, TeamActivityType, Condition1, Condition2,MinLv,MaxLv, TeamName1]};
    

read(?PT_TM_CHANGE_POS, <<PlayerId1:64, PlayerId2:64>>) ->
    {ok, [PlayerId1, PlayerId2]};


%%暂离队伍 
read(?PT_TM_TEM_LEAVE, _) ->
	{ok, []};


read(?PT_TM_QUIT, _) ->
	{ok, []};


read(?PT_TM_HANDLE_PROMOTE, <<Action:8, TeamId:32, LeaderId:64>>) ->
	{ok, [Action, TeamId, LeaderId]};


read(?PT_TM_GET_ALONE_PLAYER_LIST, _) ->
	{ok, []};


read(?PT_TM_APPLY_FOR_LEADER, _) ->
	{ok, []};


read(?PT_TM_HANDLE_INVITE, <<Action:8, LeaderId:64>>) ->
    {ok, [Action, LeaderId]};


read(?PT_TM_QRY_TEAM_LIST, <<PageSize:8, PageIndex:16, TeamActivityType:8, Condition1:8, Condition2:32>>) ->
    {ok, [PageSize, PageIndex, TeamActivityType, Condition1, Condition2]};


read(?PT_TM_APPLY_JOIN, <<LeaderId:64>>) ->
    {ok, [LeaderId]};


read(?PT_TM_ALLOW_JOIN, <<PlayerId:64, TeamId:32>>) ->
    {ok, [PlayerId, TeamId]};


read(?PT_TM_RETURN_TEAM, <<TeamId:32>>) ->
    {ok, [TeamId]};


read(?PT_TM_INVITE_RETURN, <<PlayerId:64>>) ->
    {ok, [PlayerId]};


read(?PT_TM_REFUSE_JOIN, <<ObjPlayerId:64>>) ->
    {ok, [ObjPlayerId]};


read(?PT_TM_QRY_APPLY_LIST, <<TeamId:32>>) ->
    {ok, [TeamId]};


%%邀请他人加入队伍
read(?PT_TM_INVITE_OTHERS, <<ObjPlayerId:64>>) ->
    {ok, [ObjPlayerId]};


%%踢出队伍
read(?PT_TM_KICK_OUT, <<ObjPlayerId:64>>) ->
    {ok, [ObjPlayerId]};
    
%% 查询队伍信息
read(?PT_TM_QRY_MY_TEAM_INFO, _) ->
    {ok, []};


%% 提升队员为队长
read(?PT_TM_PROMOTE_MEMBER, <<ObjPlayerId:64>>) ->
    {ok, [ObjPlayerId]};
    

read(?PT_TM_HANDLE_APPLY_FOR, <<Action:8, ObjPlayerId:64>>) ->
	{ok, [Action, ObjPlayerId]};


read(?PT_TM_CLEAR_APPLY_LIST, <<TeamId:32>>) ->
    {ok, [TeamId]};


read(?PT_TM_SET_JOIN_AIM, <<TeamActivityType:8, Condition1:8, Condition2:32,MinLv:32,MaxLv:32>>) ->
    {ok, [TeamActivityType, Condition1, Condition2,MinLv,MaxLv]};


read(?PT_TM_GET_JOIN_AIM, _) ->
    {ok, []};


read(?PT_TM_GET_MEMBER_POS, _) ->
    {ok, []};


read(?PT_TM_GET_LEADER_POS, _) ->
    {ok, []};


read(?PT_TM_GET_ONLINE_RELA_PLAYERS, <<PageSize:8, PageIndex:16>>) ->
    {ok, [PageSize, PageIndex]};
    

read(?PT_TM_QRY_TEAM_BRIEF_INFO, <<TeamId:32>>) ->
    {ok, [TeamId]};

read(?PT_TM_USE_ZF, <<No:32>>) ->
    {ok, [No]};


read(?PT_TM_SET_ZF_POS, <<Bin/binary>>) ->
    {IdPosList, _} = pt:read_array(Bin, [u64, u8]),
    {ok, [IdPosList]};

read(?PT_TM_IS_EXAM, <<No:8>>) ->
    {ok, [No]};

read(_Cmd, _R) ->
	?ASSERT(false, {_Cmd, _R}),
    {error, not_match}.

% %%
% %%服务端 -> 客户端 ------------------------------------
% %%

%% 邀请归队
write(?PT_TM_INVITE_YOU_RETURN, [TeamId]) ->
	Data = <<TeamId:32>>,
	{ok, pt:pack(?PT_TM_INVITE_YOU_RETURN, Data)};
	
%% 创建队伍
write(?PT_TM_CREATE, [RetCode, TeamId, SceneNo, TeamActivityType, Condition1, Condition2,InitPos, CurUseTroop,MinLv,MaxLv,  TeamName, ZfL]) ->
	?TRACE("write PT_TM_CREATE, init pos in troop: ~p, CurUseTroop:~p~n", [InitPos, CurUseTroop]),
    TeamName1 = list_to_binary(TeamName),
    F2 = fun(X) ->
        <<X:32>>
    end,
    BinInfo = list_to_binary([F2(X) || X <- ZfL]),


    Data = <<RetCode:8, TeamId:32, SceneNo:32, TeamActivityType:8, Condition1:8, Condition2:32, InitPos:8, CurUseTroop:32,MinLv:32,MaxLv:32, (byte_size(TeamName1)):16, TeamName1/binary,
    (length(ZfL)):16, BinInfo/binary>>,
    {ok, pt:pack(?PT_TM_CREATE, Data)};
    
    
write(?PT_TM_NOTIFY_MEMBER_CHANGE_POS, [PlayerId1, PlayerId2]) ->
    Data = <<PlayerId1:64, PlayerId2:64>>,
    {ok, pt:pack(?PT_TM_NOTIFY_MEMBER_CHANGE_POS, Data)};


write(?PT_TM_NOTIFY_MEMBER_TEMP_LEAVE, [SwornType, PlayerId]) ->
    Data = <<PlayerId:64, SwornType:8>>,
    {ok, pt:pack(?PT_TM_NOTIFY_MEMBER_TEMP_LEAVE, Data)};


write(?PT_TM_TEM_LEAVE, [RetCode]) ->
	Data = <<RetCode:8>>,
	{ok, pt:pack(?PT_TM_TEM_LEAVE, Data)};


write(?PT_TM_PROMOTE_YOU, [TeamId, LeaderId]) ->
	Data = <<TeamId:32, LeaderId:64>>,
	{ok, pt:pack(?PT_TM_PROMOTE_YOU, Data)};


write(?PT_TM_MEM_APPLY_FOR_LEADER, [PlayerId, PlayerName]) ->
	Data = <<PlayerId:64, (byte_size(PlayerName)):16, PlayerName/binary>>,
	{ok, pt:pack(?PT_TM_MEM_APPLY_FOR_LEADER, Data)};

write(?PT_TM_GET_ALONE_PLAYER_LIST, [RetCode, PlayerList]) ->
	Count = length(PlayerList),
    F = fun([Id, Sex, Name, Lv, Faction, GuildName, SceneNo, TeamActivityType, Condition1, Condition2, VipLv,BattlePower]) ->
            NameLen = byte_size(Name),
            <<
            	Id				        : 64, 
            	Sex				        : 8, 
            	NameLen			        : 16, 
            	Name			        / binary,
            	Lv 				        : 16,
            	Faction			        : 8,
                (byte_size(GuildName))  : 16,
            	GuildName 			    / binary,
                SceneNo                 : 32,
                TeamActivityType        : 8,
                Condition1 : 8,
                Condition2 : 32,
                VipLv:8,
                BattlePower:32
            >>
    	end,
    BinInfo = list_to_binary([F(X) || X <- PlayerList]),
    RespData = <<RetCode:8, Count:16, BinInfo/binary>>,
    {ok, pt:pack(?PT_TM_GET_ALONE_PLAYER_LIST, RespData)};


write(?PT_TM_QRY_TEAM_LIST, [_PS, TotalPage, PageIndex, TeamList]) ->
    TeamCount = length(TeamList),
    F = fun(Team) ->
        TeamName1 = Team#team.team_name,
        TeamNameLen = byte_size(TeamName1),
        LeaderName1 = Team#team.leader_name,
        LeaderNameLen = byte_size(LeaderName1),
        ?ASSERT(Team#team.leader_id /= 0, Team#team.leader_id),
        SceneNo = 
        case player:get_scene_id(Team#team.leader_id) of
            ?INVALID_ID -> Team#team.scene;
            SceneId -> lib_scene:get_no_by_id(SceneId)
        end,
        VipLv = 
            case player:get_PS(Team#team.leader_id) of
                null -> 0;
                LeaderPS -> player:get_vip_lv(LeaderPS)
            end,
        ?TRACE("pt_24:write(PT_TM_QRY_TEAM_LIST): LeaderId:~p, SceneNo:~p", [Team#team.leader_id, SceneNo]),

        {MinLv,MaxLv} = Team#team.lv_range,
        MemberIdS = [Mem#mb.id  || Mem <- Team#team.members] ,
        MemberInfoBin =
            list_to_binary([<<GetPlayerId:64, (player:get_lv(GetPlayerId)):16,
                (byte_size(player:get_name(GetPlayerId))):16 ,  (player:get_name(GetPlayerId))/binary,
                (player:get_faction(GetPlayerId)) :8, (player:get_sex(GetPlayerId)) :8 >>|| GetPlayerId <- MemberIdS]),
        <<
            (Team#team.team_id)               : 32,
            (length(Team#team.members))       : 8,
            (Team#team.leader_id)             : 64,
            (Team#team.team_activity_type)    : 8,
            (Team#team.condition1)            : 8,
            (Team#team.condition2)            : 32,

            MinLv : 32,
            MaxLv : 32,

            SceneNo                           : 32,
            TeamNameLen                       : 16,
            TeamName1                         / binary,
            LeaderNameLen                     : 16,
            LeaderName1                       / binary,
            VipLv : 8,
            (length(MemberIdS)) :16,
            MemberInfoBin /binary
        >>
    end,
    BinInfo = list_to_binary([F(X) || X <- TeamList]),
    Data = <<TotalPage:16, PageIndex:16, TeamCount:16, BinInfo/binary>>,
    {ok, pt:pack(?PT_TM_QRY_TEAM_LIST, Data)};


write(?PT_TM_QRY_APPLY_LIST, ApplyList) ->
    ApplyCount = length(ApplyList),
    F = fun(ApplyObj) ->
        NameLen = byte_size(ApplyObj#apply.player_name),
        <<
            (ApplyObj#apply.player_id)          : 64,
            NameLen                             : 16,
            (ApplyObj#apply.player_name)        / binary,
            (ApplyObj#apply.lv)                 : 16,
            (ApplyObj#apply.race)               : 8,
            (ApplyObj#apply.sex)                : 8,        
            (ApplyObj#apply.faction)            : 8,
            (ApplyObj#apply.weapon)             : 32,
            (ApplyObj#apply.back_wear)          : 32,
            (ApplyObj#apply.suit_no)            : 8,
            (ApplyObj#apply.headwear)           : 32,
            (ApplyObj#apply.clothes)            : 32,
            (ApplyObj#apply.magic_key)          : 32,
            (ApplyObj#apply.battle_power)       : 32
        >>
    end,
    BinInfo = list_to_binary([F(X) || X <- ApplyList]),
    Data = <<ApplyCount:16, BinInfo/binary>>,
    {ok, pt:pack(?PT_TM_QRY_APPLY_LIST, Data)};



write(?PT_TM_APPLY_FOR_LEADER, [RetCode]) ->
	Data = <<RetCode:8>>,
	{ok, pt:pack(?PT_TM_APPLY_FOR_LEADER, Data)};


write(?PT_TM_HANDLE_APPLY_FOR, [RetCode]) ->
	Data = <<RetCode:8>>,
	{ok, pt:pack(?PT_TM_HANDLE_APPLY_FOR, Data)};


write(?PT_TM_NOTIFY_LEADER_INVITE_RESULT, [Result, PlayerName]) ->
    Data = <<Result:8, (byte_size(PlayerName)):16, PlayerName/binary>>,
    {ok, pt:pack(?PT_TM_NOTIFY_LEADER_INVITE_RESULT, Data)};


write(?PT_TM_NOTIFY_KICK_OUT_MEMBER, [SwornType, PlayerId]) ->
    Data = <<PlayerId:64, SwornType:8>>,
    {ok, pt:pack(?PT_TM_NOTIFY_KICK_OUT_MEMBER, Data)};


write(?PT_TM_NOTIFY_PROMOTE_RESULT, [Result, PlayerName]) ->
    Data = <<Result:8, (byte_size(PlayerName)):16, PlayerName/binary>>,
    {ok, pt:pack(?PT_TM_NOTIFY_PROMOTE_RESULT, Data)};


write(?PT_TM_NOTIFY_MEMBER_RETURN, [SwornType, PlayerId]) ->
    Data = <<PlayerId:64, SwornType:8>>,
    {ok, pt:pack(?PT_TM_NOTIFY_MEMBER_RETURN, Data)};
    

write(?PT_TM_NOTIFY_MEMBER_OFFLINE, [SwornType, PlayerId]) ->
    Data = <<PlayerId:64, SwornType:8>>,
    {ok, pt:pack(?PT_TM_NOTIFY_MEMBER_OFFLINE, Data)};
    

write(?PT_TM_SET_JOIN_AIM, [RetCode, TeamActivityType, Condition1, Condition2,MinLv,MaxLv]) ->
    Data = <<RetCode:8, TeamActivityType:8, Condition1:8, Condition2:32,MinLv:32,MaxLv:32>>,
    {ok, pt:pack(?PT_TM_SET_JOIN_AIM, Data)};


write(?PT_TM_GET_JOIN_AIM, [TeamActivityType, Condition1, Condition2,MinLv,MaxLv]) ->
    Data = <<TeamActivityType:8, Condition1:8, Condition2:32,MinLv:32,MaxLv:32>>,
    {ok, pt:pack(?PT_TM_GET_JOIN_AIM, Data)};


write(?PT_TM_APPLY_JOIN, [RetCode]) ->
    Data = <<RetCode:8>>,
    {ok, pt:pack(?PT_TM_APPLY_JOIN, Data)};


%% 退出队伍
write(?PT_TM_QUIT, [RetCode])->
    Data = <<RetCode:8>>,
    {ok, pt:pack(?PT_TM_QUIT, Data)};
    

%%邀请他人加入队伍
write(?PT_TM_INVITE_OTHERS, [RetCode, ObjPlayerId])->
    Data = <<RetCode:8, ObjPlayerId:64>>,
    {ok, pt:pack(?PT_TM_INVITE_OTHERS, Data)};


write(?PT_TM_GOT_INVITE, [FromPlayerId, FromPlayerName, FromPlayerLv, TeamActivityType, SceneNo, Condition1, Condition2]) ->
    Data = <<FromPlayerId:64, (byte_size(FromPlayerName)):16, FromPlayerName/binary, FromPlayerLv:16, TeamActivityType:8, 
    SceneNo:32, Condition1:8, Condition2:32>>,
    {ok, pt:pack(?PT_TM_GOT_INVITE, Data)};


%%踢出队员
write(?PT_TM_KICK_OUT, [RetCode, ObjPlayerId]) ->
    Data = <<RetCode:8, ObjPlayerId:64>>,
    {ok, pt:pack(?PT_TM_KICK_OUT, Data)};


write(?PT_TM_QRY_MY_TEAM_INFO, [TeamId, MemberInfoList, Team]) ->
	?ASSERT(is_list(MemberInfoList)),
    TeamName = 
        case Team =:= null of
            true -> <<>>;
            false -> Team#team.team_name
        end,
    TeamActivityType = 
        case Team =:= null of
            true -> 0;
            false -> Team#team.team_activity_type
        end,
    Condition1 = case Team =:= null of true -> 0; false -> Team#team.condition1 end,
    Condition2 = case Team =:= null of true -> 0; false -> Team#team.condition2 end,

    LvRange = case Team =:= null of true -> {0,100}; false -> Team#team.lv_range end,
    {MinLv,MaxLv} = LvRange,

    ZfNo = case Team =:= null of true -> ply_zf:get_common_zf(); false -> Team#team.troop_no end,
    NeedAudit = case Team =:= null of true ->0; false -> Team#team.is_exam end,

    MemberCount = length(MemberInfoList),
    TeamNameLen = byte_size(TeamName),
    F = fun([Id, Lv, Name, TroopPos, TrainPos, Faction, Sex, SceneId, State, SceneNo, Race, Weapon, BackWear, SwornId, SwornType, SuitNo, Headwear, Clothes, MagicKey, BtPower]) ->
            NameLen = byte_size(Name),
            <<
            	Id				: 64, 
            	Lv				: 16, 
            	NameLen			: 16, 
            	Name			/ binary,
            	TroopPos	    : 8,
                TrainPos        : 8,
            	Faction			: 8,
            	Sex				: 8,
            	SceneId			: 32,
                State           : 8,
                SceneNo         : 32,
                Race            : 8,
                Weapon          : 32,
                BackWear        : 32,
                SwornId         : 64,
                SwornType       : 8,
                SuitNo          : 8,
                Headwear        : 32, 
                Clothes         : 32,
                MagicKey        : 32,
                BtPower         : 32
            >>
    	end,
    BinInfo = list_to_binary([F(X) || X <- MemberInfoList]),

    ZfL = case Team =:= null of true -> []; false -> lib_team:get_learned_zf_nos(Team) end,

    F2 = fun(X) -> <<X:32>> end,
    BinZf = list_to_binary([F2(X) || X <- ZfL]),

    RespData = <<TeamId:32, MemberCount:16, BinInfo/binary, TeamNameLen:16, TeamName/binary, TeamActivityType:8, Condition1:8, Condition2:32,
    MinLv:32,MaxLv:32,
     (length(ZfL)):16, BinZf/binary, ZfNo:32, NeedAudit:8>>,
    {ok, pt:pack(?PT_TM_QRY_MY_TEAM_INFO, RespData)};


write(?PT_TM_NOTIFY_MEMBER_JOIN, [PlayerId, Lv, Name, TroopPos, TrainPos, Faction, Sex, SceneId, State, SceneNo, Race, Weapon, BackWear, SwornId, SwornType, SuitNo, Headwear, Clothes, MagicKey, BtPower]) ->    
    NameLen = byte_size(Name),
    Data = <<
                PlayerId        : 64, 
                Lv              : 16, 
                NameLen         : 16, 
                Name            / binary,
                TroopPos        : 8,
                TrainPos        : 8,
                Faction         : 8,
                Sex             : 8,
                SceneId         : 32,
                State           : 8,
                SceneNo         : 32,
                Race            : 8,
                Weapon          : 32,
                BackWear        : 32,
                SwornId         : 64,
                SwornType       : 8,
                SuitNo          : 8,
                Headwear        : 32, 
                Clothes         : 32,
                MagicKey        : 32,
                BtPower         : 32
            >>,
    {ok, pt:pack(?PT_TM_NOTIFY_MEMBER_JOIN, Data)};


%%向队员发送有人离队的信息
write(?PT_TM_NOTIFY_MEMBER_QUIT, [PlayerId, NewLeaderId]) ->
    Data = <<
    		PlayerId  		: 64,
    		NewLeaderId     : 64
    	   >>,
    {ok, pt:pack(?PT_TM_NOTIFY_MEMBER_QUIT, Data)};


%%向队员发送更换队长的信息
write(?PT_TM_NOTIFY_LEADER_CHANGED, [NewLeaderId]) ->
    Data = <<NewLeaderId:64>>,
    {ok, pt:pack(?PT_TM_NOTIFY_LEADER_CHANGED, Data)};


%% 队长发送提升队员为队长请求
write(?PT_TM_PROMOTE_MEMBER, RetCode) ->
    Data = <<RetCode:8>>,
    {ok, pt:pack(?PT_TM_PROMOTE_MEMBER, Data)};
    

write(?PT_TM_RETURN_TEAM, [RetCode]) ->
    Data = <<RetCode:8>>,
    {ok, pt:pack(?PT_TM_RETURN_TEAM, Data)};


write(?PT_TM_INVITE_RETURN, [RetCode]) ->
    Data = <<RetCode:8>>,
    {ok, pt:pack(?PT_TM_INVITE_RETURN, Data)};


write(?PT_TM_REFUSE_JOIN, [RetCode, ObjPlayerId]) ->
    Data = <<RetCode:8, ObjPlayerId:64>>,
    {ok, pt:pack(?PT_TM_REFUSE_JOIN, Data)};


write(?PT_TM_CLEAR_APPLY_LIST, [RetCode, TeamId]) ->
    Data = <<RetCode:8, TeamId:32>>,
    {ok, pt:pack(?PT_TM_CLEAR_APPLY_LIST, Data)};


write(?PT_TM_GET_MEMBER_POS, [IdList]) ->
    F = fun(X) ->
        {X1, Y1} = player:get_xy(X),
        <<X:64, (player:get_scene_no(X)):32, X1:32, Y1:32>>
    end,
    BinInfo = list_to_binary([F(X) || X <- IdList]),
    Data = <<(length(IdList)):16, BinInfo/binary>>,
    {ok, pt:pack(?PT_TM_GET_MEMBER_POS, Data)};


write(?PT_TM_GET_LEADER_POS, [PlayerId]) ->
    {X1, Y1} = player:get_xy(PlayerId),
    Data = <<PlayerId:64, (player:get_scene_no(PlayerId)):32, X1:32, Y1:32>>,
    {ok, pt:pack(?PT_TM_GET_LEADER_POS, Data)};


write(?PT_TM_HANDLE_INVITE, [RetCode, LeaderId]) ->
    Data = <<RetCode:8, LeaderId:64>>,
    {ok, pt:pack(?PT_TM_HANDLE_INVITE, Data)};


write(?PT_TM_NOTIFY_TEAM_INFO_CHANGE, [Team, ZfL]) ->
    TeamId = Team#team.team_id,
    SceneNo = Team#team.scene, 
    TeamActivityType = Team#team.team_activity_type, 
    Condition1 = Team#team.condition1, 
    Condition2 = Team#team.condition2, 
    CurUseTroop = Team#team.troop_no, 
    TeamName = Team#team.team_name,

    {MinLv,MaxLv} = Team#team.lv_range,

    F2 = fun(X) ->
        <<X:32>>
    end,
    BinInfo = list_to_binary([F2(X) || X <- ZfL]),

    Data = <<TeamId:32, SceneNo:32, TeamActivityType:8, Condition1:8, Condition2:32,MinLv:32,MaxLv:32, CurUseTroop:32, (byte_size(TeamName)):16, TeamName/binary, (length(ZfL)):16, BinInfo/binary>>,
    {ok, pt:pack(?PT_TM_NOTIFY_TEAM_INFO_CHANGE, Data)};


write(?PT_TM_NOTIFY_MB_INFO_CHANGE, [PlayerId, KV_TupleList]) -> 
    F = fun({ObjInfoCode, NewValue}) ->
            <<ObjInfoCode:8, NewValue:32>>
        end,
    Bin = list_to_binary([F(X) || X <- KV_TupleList]),
    Bin2 = <<
            PlayerId               : 64,
            (length(KV_TupleList)) : 16,
            Bin / binary
           >>,
    {ok, pt:pack(?PT_TM_NOTIFY_MB_INFO_CHANGE, Bin2)};
    

write(?PT_TM_GET_ONLINE_RELA_PLAYERS, [TotalPage, PageIndex, RetList, ListFriend, _ListGuildMb]) ->
    F = fun(PS) ->
            Rela = 
                case lists:member(PS, ListFriend) of
                    true -> 1;
                    false -> 2
                end,
            Name = player:get_name(PS),
            <<
                (player:id(PS)) : 64,
                (player:get_faction(PS)) : 8,
                (player:get_lv(PS)) : 16,
                Rela : 8,
                (player:get_vip_lv(PS)) : 8,
                (byte_size(Name)) : 16,
                Name /binary,
                (player:get_sex(PS)) :8 ,
                (PS#player_status.battle_power) : 32
            >>
        end,
    Bin = list_to_binary([F(X) || X <- RetList]),
    Len = length(RetList),
    {ok, pt:pack(?PT_TM_GET_ONLINE_RELA_PLAYERS, <<TotalPage:16, PageIndex:16, Len:16, Bin/binary>>)};

write(?PT_TM_QRY_TEAM_BRIEF_INFO, [TeamId, TeamName, LeaderId, List]) ->
    F = fun({Id, State, Name}) ->
            <<  
                Id : 64,
                State : 8,
                (byte_size(Name)) : 16,
                Name /binary
            >>
        end,
    Bin = list_to_binary([F(X) || X <- List]),
    Len = length(List),
    {ok, pt:pack(?PT_TM_QRY_TEAM_BRIEF_INFO, <<TeamId:32, (byte_size(TeamName)):16, TeamName/binary, LeaderId:64, Len:16, Bin/binary>>)};    


write(?PT_TM_NOTIFY_SWORN_INFO_CHANGE, [PlayerId, SwornId, SwornType]) ->
    {ok, pt:pack(?PT_TM_NOTIFY_SWORN_INFO_CHANGE, <<PlayerId:64, SwornId:64, SwornType:8>>)};        


write(?PT_TM_USE_ZF, [No]) ->
    {ok, pt:pack(?PT_TM_USE_ZF, <<No:32>>)};


write(?PT_TM_SET_ZF_POS, [IdPosL]) ->
     F = fun({Id, Pos}) ->
            <<  
                Id : 64,
                Pos : 8
            >>
        end,
    Bin = list_to_binary([F(X) || X <- IdPosL]),
    Len = length(IdPosL),
    {ok, pt:pack(?PT_TM_SET_ZF_POS, <<Len:16, Bin/binary>>)};

write(?PT_TM_IS_EXAM, [No]) ->
    {ok, pt:pack(?PT_TM_IS_EXAM, <<No:8>>)};


write(_Cmd, _R) ->
	?ASSERT(false, {_Cmd, _R}),
    {error, not_match}.
    
    
% %% ============================================================================

