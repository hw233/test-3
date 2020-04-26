%%%---------------------------------------------
%%% @Module  : glt_team (game logic test: team)
%%% @Author  : zhangwq
%%% @Email   : 
%%% @Created : 2013.8.1
%%% @Description: 组队系统测试
%%%---------------------------------------------
-module(glt_team).


-include("test_client_base.hrl").
-include("pt_24.hrl").
-include("debug.hrl").


-compile(export_all).



%% 创建队伍
creat_team(TeamId, SceneId, TeamActivityType, TargetMonLevel, TeamName) ->
    Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: create_team  [TeamActivityType, TargetMonLevel, TeamName]: ~p ~p ~p~n", [TeamActivityType, TargetMonLevel, TeamName]),
    NameBin = list_to_binary(TeamName),
    NameLen = byte_size(NameBin),
    Data = <<TeamId:32, SceneId:32, TeamActivityType:8, TargetMonLevel:8, NameLen:16, NameBin/binary>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_TM_CREATE, Data)),
    ok.


%% 查询场景中的队伍列表
get_team_list() ->
    Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: get_team_list~n", []),
    gen_tcp:send(Socket, test_client_base:pack(?PT_TM_QRY_TEAM_LIST, <<>>)),
    ok.


%% 申请入队
apply_join(TeamId) ->
    Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: apply_join~n", []),
    Data = <<TeamId:32>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_TM_APPLY_JOIN, Data)),
    ok.


% 队长允许入队
allow_join(PlayerId, TeamId) ->
    Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: allow_join~n", []),
    Data = <<PlayerId:64, TeamId:32>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_TM_ALLOW_JOIN, Data)),
    ok.


% 队长拒绝入队
refuse_join(ObjPlayerId) ->
    Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: refuse_join~n", []),
    Data = <<ObjPlayerId:64>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_TM_REFUSE_JOIN, Data)),
    ok.


%  玩家退出队伍
quit_team() ->
    Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: quit_team~n", []),
    Data = <<>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_TM_QUIT, Data)),
    ok.

% 邀请玩家归队
invite_return(TargetPlayerId) ->
    Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: invite_return~n", []),
    Data = <<TargetPlayerId:64>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_TM_INVITE_RETURN, Data)),
    ok.    


% 玩家归队
return_team(TeamId) ->
    Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: return_team~n", []),
    Data = <<TeamId:32>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_TM_RETURN_TEAM, Data)),
    ok.    

% 队员暂离队伍
tem_leave_team() ->
    Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: tem_leave_team~n", []),
    Data = <<>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_TM_TEM_LEAVE, Data)),
    ok. 


% 邀请他人加入队伍
invite_others(TargetPlayerId) ->
    Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: invite_others~n", []),
    Data = <<TargetPlayerId:64>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_TM_INVITE_OTHERS, Data)),
    ok.


% 落单玩家同意队长的入队邀请
agree_invite(LeaderId) ->
    Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: agree_invite~n", []),
    Action = 1,
    Data = <<Action:8, LeaderId:64>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_TM_HANDLE_INVITE, Data)),
    ok.

% 落单玩家拒绝队长的入队邀请
disagree_invite(LeaderId) ->
    Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: disagree_invite~n", []),
    Action = 0,
    Data = <<Action:8, LeaderId:64>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_TM_HANDLE_INVITE, Data)),
    ok.


% 队长踢人,请离队伍
kick_out_member(TargetPlayerId) ->
    Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: kick_out_member~n", []),
    Data = <<TargetPlayerId:64>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_TM_KICK_OUT, Data)),
    ok.


% 队长请求提升队员为新队长
ask_promote_member(TargetPlayerId) ->
    Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: ask_promote_member~n", []),
    Data = <<TargetPlayerId:64>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_TM_PROMOTE_MEMBER, Data)),
    ok. 


% 队员同意提升为队长
agree_promote_leader(TeamId) ->
    Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: agree_promote_leader~n", []),
    Action = 0,
    Data = <<Action:8, TeamId:32>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_TM_HANDLE_PROMOTE, Data)),
    ok.


% 队员不同意提升为队长
disagree_promote_leader(TeamId) ->
    Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: disagree_promote_leader~n", []),
    Action = 1,
    Data = <<Action:8, TeamId:32>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_TM_HANDLE_PROMOTE, Data)),
    ok.


% 玩家申当队长
apply_for_leader() ->
    Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: apply_for_leader~n", []),
    Data = <<>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_TM_APPLY_FOR_LEADER, Data)),
    ok.


% 查询队伍的玩家申请列表
query_apply_list(TeamId) ->
    Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: query_apply_list~n", []),
    Data = <<TeamId:32>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_TM_QRY_APPLY_LIST, Data)),
    ok.


% 清空玩家队伍的申请信息
clear_apply_list(TeamId) ->
    Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: clear_apply_list~n", []),
    Data = <<TeamId:32>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_TM_CLEAR_APPLY_LIST, Data)),
    ok.    


get_team_info() ->
    Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: get_team_info~n", []),
    Data = <<>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_TM_QRY_MY_TEAM_INFO, Data)),
    ok.


get_alone_player_list() ->
    Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: get_alone_player_list~n", []),
    Data = <<>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_TM_GET_ALONE_PLAYER_LIST, Data)),
    ok.


get_join_aim() ->
    Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: get_join_aim~n", []),
    Data = <<>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_TM_GET_JOIN_AIM, Data)),
    ok.

    
read(?PT_TM_CREATE, Bin, _Fd) ->
    <<RetCode:8, TeamId:32, SceneId:32, TeamActivityType:8, TargetMonLevel:8, InitPos:8, CurUseTroop:32, NameBin/binary>> = Bin,
    {Name, <<>>} = pt:read_string(NameBin),
    io:format("client read: PT_TM_CREATE, RetCode=~p, TeamId=~p, SceneId=~p, TeamActivityType=~p, TargetMonLevel=~p, InitPos=~p, CurUseTroop=~p, Name=~p~n", 
                    [RetCode, TeamId, SceneId, TeamActivityType, TargetMonLevel, InitPos, CurUseTroop, Name]);


read(?PT_TM_QRY_TEAM_LIST, <<TeamCount:16, TeamListData/binary>>, _Fd) ->
    io:format("client read: Cmd => ~p,  TeamCount: ~p~n", [?PT_TM_QRY_TEAM_LIST, TeamCount]),
    io:format("team list begin:~n"),
    F = fun(Bin0) ->
        <<TeamId:32, MemberCount:8, LeaderId:64, TeamActivityType:8, TargetMonLevel:8, Scene:32, NameBin/binary>> = Bin0,
        {TeamName, Rest} = pt:read_string(NameBin),
        {LeaderName, Rest1} = pt:read_string(Rest),
        io:format("team info: TeamId=~p, MemberCount=~p, LeaderId=~p, TeamActivityType=~p, TargetMonLevel=~p, Scene=~p, TeamName=~p, LeaderName=~p~n",
            [TeamId, MemberCount, LeaderId, TeamActivityType, TargetMonLevel, Scene, TeamName, LeaderName]),

        Rest1
    end,
    test_client_base:for(0, TeamCount, F, TeamListData),
    io:format("team list end.~n");


read(?PT_TM_QRY_MY_TEAM_INFO, <<TeamId:32, MemberData/binary>>, _Fd) ->
    {MemberInfoList, <<>>} = pt:read_array(MemberData, [int64, u16, string, u8, u8, u8, u8, u32, u8, u32, u8]),
    io:format("mb list begin: TeamId = ~p~n", [TeamId]),
    F = fun(MemberInfo) ->
        io:format("[Id,Level,Name,TroopPos,TrainPos,Faction,Sex,SceneId,State,SceneNo,Race] = [~p~n]", [MemberInfo])
    end,
    lists:foreach(F, MemberInfoList),
    io:format("mb list end.~n");


read(?PT_TM_GET_ALONE_PLAYER_LIST, <<RetCode:8, BinData/binary>>, _Fd) ->
    {AlonePlayerList, <<>>} = pt:read_array(BinData, [int64, u8, string, u8, u8, u8, u32, u8]),
    io:format("RetCode = ~p,alone player list begin: ~n", [RetCode]),
    F = fun(PlayerInfo) ->
        io:format("[PlayerId, Sex, Name, Level, Faction, GangId, TeamSceneNo, TeamActivityType] = [~p~n]", [PlayerInfo])
    end,
    lists:foreach(F, AlonePlayerList),
    io:format("alone player list end.~n");


read(?PT_TM_QRY_APPLY_LIST, Bin, _Fd) ->
    {ApplyInfoList, <<>>} = pt:read_array(Bin, [int64, string, u16, u8]),
    io:format("apply list begin: ~n", []),
    F = fun(Info) ->
        io:format("[PlayerId,Name,Lv,Race] = [~p]~n", [Info])
    end,
    lists:foreach(F, ApplyInfoList),
    io:format("apply list end.~n");


read(?PT_TM_NOTIFY_MEMBER_QUIT, Bin, _Fd) ->
    io:format("Bin is ~p~n", [Bin]),
     <<PlayerId:64, NewLeaderId:64>> = Bin,
    io:format("leave player: ~p, NewLeader: ~p~n", [PlayerId, NewLeaderId]);


read(Cmd, Bin, _Fd) ->
    io:format("[glt_team] default read handler!!!!! ", []),
    io:format("client read: Cmd => ~p, Bin: ~p~n", [Cmd, Bin]).