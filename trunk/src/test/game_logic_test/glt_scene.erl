%%%---------------------------------------------
%%% @Module  : glt_scene (game logic test: scene)
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2013.8.1
%%% @Description: 场景系统测试
%%%---------------------------------------------
-module(glt_scene).


-include("test_client_base.hrl").
-include("pt_12.hrl").
-include("debug.hrl").

-compile(export_all).



%% 获取场景内的明雷怪列表（仅用于调试！）
dbg_get_mon_list(SceneId) ->
	Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: get_scene_mon_list~n", []),
    Data = <<SceneId:32>>,
	gen_tcp:send(Socket, test_client_base:pack(?PT_DBG_GET_SCENE_MON_LIST, Data)),
    ok.


%% 请求传送
req_teleport(TeleportNo) ->
    Socket = get(?PDKN_CONN_SOCKET),
    Data = <<TeleportNo:32>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_REQ_TELEPORT, Data)),
    ok.



%% 普通场景之间跳转
switch_between_normal_scenes(NewSceneId) ->
    Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: switch_between_normal_scenes, NewSceneId=~p~n", [NewSceneId]),
    Data = <<NewSceneId:32>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_SWITCH_BETWEEN_NORMAL_SCENES, Data)),
    ok.


% %% 获取场景内的普通npc（不包括智能npc）列表
% get_normal_npc_list(NewSceneId) ->
%     Socket = get(?PDKN_CONN_SOCKET),
%     io:format("client send: get_normal_npc_list of sceneId ~p~n", [NewSceneId]),
%     Data = <<NewSceneId:32>>,
%     gen_tcp:send(Socket, test_client_base:pack(?PT_GET_SCENE_NORMAL_NPC_LIST, Data)),
%     ok.


%% 加载场景：获取场景AOI范围的信息
get_scene_aoi_info(NewSceneId) ->
    Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: get_scene_aoi_info of sceneId ~p~n", [NewSceneId]),
    Data = <<NewSceneId:32>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_GET_SCENE_AOI_INFO, Data)),
    ok.



get_scene_dynamic_teleporter_list(SceneId) ->
    Socket = get(?PDKN_CONN_SOCKET),
    Data = <<SceneId:32>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_GET_SCENE_DYNAMIC_TELEPORTER_LIST, Data)),
    ok.





% dbg_spawn_mon_to_scene_for_player_WNC(MonNo, SceneId) ->
%     Socket = get(?PDKN_CONN_SOCKET),
%     Data = <<MonNo:32, SceneId:32>>,
%     gen_tcp:send(Socket, test_client_base:pack(?PT_DBG_SPAWN_MON_TO_SCENE_FOR_PLAYER_WNC, Data)),
%     ok.


scene_create_clear() ->
    F = fun(X) ->  
        mod_scene:create_scene(3000),
        mod_scene:spawn_dynamic_npc_to_scene(1001, 999999+X, 10, 11),
        mod_scene:spawn_mon_to_scene(1, 999999+X, 13, 15),
        mod_scene:clear_scene(999999+X)
    end,
    lists:foreach(F, lists:seq(1, 1000)).



%% 获取场景内的明雷怪列表
read(?PT_DBG_GET_SCENE_MON_LIST, <<SceneId:32, MonCount:16, MonListData/binary>>, _Fd, _PlayerPid) ->
    io:format("client read: PT_DBG_GET_SCENE_MON_LIST, SceneId: ~p, MonCount: ~p~n", [SceneId, MonCount]),
    io:format("**********:~n"),
    F = fun(Bin0) ->
        <<MonId:32, MonNo:32, X:16, Y:16, Lv:8, BMonGroupNo:32, NameBin/binary>> = Bin0,
        {Name, Rest} = pt:read_string(NameBin),
        io:format("mon info: Id=~p No=~p X=~p Y=~p Lv=~p BMonGroupNo=~p Name=~w~n", [MonId, MonNo, X, Y, Lv, BMonGroupNo, Name]),
        Rest
    end,
    test_client_base:for(0, MonCount, F, MonListData),
    io:format("***********~n");



%% 通知客户端：切换到新场景
read(?PT_NOTIFY_SWITCH_TO_NEW_SCENE, Bin, _Fd, PlayerPid) ->
    <<NewSceneId:32, NewSceneNo:32, NewX:16, NewY:16>> = Bin,
    io:format("client read: PT_NOTIFY_SWITCH_TO_NEW_SCENE, NewSceneId=~p, NewSceneNo=~p, (X,Y)=(~p, ~p)~n", [NewSceneId, NewSceneNo, NewX, NewY]),
    PS = test_client_base:get_client_ps(),
    test_client_base:set_client_ps(PS#client_ps{scene_id = NewSceneId, scene_no = NewSceneNo, x = NewX, y = NewY}),
    PlayerPid ! {change_scene_ok, NewSceneId, NewX, NewY};


% read(?PT_GET_SCENE_NORMAL_NPC_LIST, <<NpcCount:16, NpcListData/binary>>, _Fd) ->
%     io:format("client read: PT_GET_SCENE_NORMAL_NPC_LIST, NpcCount: ~p~n", [NpcCount]),
%     io:format("NPC list begin:~n"),
%     F = fun(Bin0) ->
%         <<NpcId:32, NpcNo:32, X:16, Y:16, RestBin/binary>> = Bin0,
%         io:format("NPC INFO: NpcId=~p, NpcNo=~p, X=~p, Y=~p~n", [NpcId, NpcNo, X, Y]),
%         RestBin
%     end,
%     test_client_base:for(0, NpcCount, F, NpcListData),
%     io:format("npc list end.~n");


read(?PT_NOTIFY_PLAYERS_ENTER_MY_AOI, <<PlayerCount:16, PlayerListData/binary>>, _Fd, _PlayerPid) ->
    io:format("client read: PT_NOTIFY_PLAYERS_ENTER_MY_AOI, PlayerCount: ~p~n", [PlayerCount]),
    io:format("*********:~n"),
    F = fun(Bin0) ->
        <<Id:64, X:16, Y:16, Race:8, Faction:8, Lv:8, Sex:8, RestBin/binary>> = Bin0,
        io:format("Player INFO: Id=~p, X=~p, Y=~p, Race=~p, Faction=~p, Lv=~p, Sex=~p~n", [Id, X, Y, Race, Faction, Lv, Sex]),
        RestBin
    end,
    test_client_base:for(0, PlayerCount, F, PlayerListData),
    io:format("*********~n");


read(?PT_NOTIFY_PLAYERS_LEAVE_MY_AOI, Bin, _Fd, _PlayerPid) ->
    io:format("client read: PT_NOTIFY_PLAYERS_LEAVE_MY_AOI:~n"),
    {PlayerIdList, <<>>} = pt:read_array(Bin, [u64]),
    io:format("*********:~n"),
    io:format("    PlayerIdList:~p~n", [PlayerIdList]),
    io:format("*********~n");



read(?PT_NOTIFY_OBJS_ENTER_MY_AOI, <<ObjCount:16, ObjListData/binary>>, _Fd, _PlayerPid) ->
    io:format("client read: PT_NOTIFY_OBJS_ENTER_MY_AOI, ObjCount: ~p~n", [ObjCount]),
    io:format("*********:~n"),
    F = fun(Bin0) ->
        <<ObjType:8, ObjId:32, ObjNo:32, X:16, Y:16, TeamId:32, OwnerId:64, LeftCanBeKilledTimes:8, RestBin/binary>> = Bin0,
        io:format("Obj INFO: ObjType=~p, ObjId=~p, ObjNo=~p, X=~p, Y=~p, TeamId=~p, OwnerId=~p, LeftCanBeKilledTimes=~p~n", [ObjType, ObjId, ObjNo, X, Y, TeamId, OwnerId, LeftCanBeKilledTimes]),
        RestBin
    end,
    test_client_base:for(0, ObjCount, F, ObjListData),
    io:format("**********~n");


read(?PT_NOTIFY_OBJS_LEAVE_MY_AOI, Bin, _Fd, _PlayerPid) ->
    <<ObjCount:16, _/binary>> = Bin,
    io:format("client read: PT_NOTIFY_OBJS_LEAVE_MY_AOI, ObjCount=~p~n", [ObjCount]),
    {ObjInfoList, <<>>} = pt:read_array(Bin, [u8, u32]),
    io:format("*********:~n"),

    F = fun({ObjType, ObjId}) ->
            io:format("      Obj INFO: ObjType=~p, ObjId=~p~n", [ObjType, ObjId])
        end,
    lists:foreach(F, ObjInfoList),

    io:format("**********~n");



read(?PT_GET_SCENE_DYNAMIC_TELEPORTER_LIST, Bin, _Fd, _PlayerPid) ->
    <<SceneId:32, Bin2/binary>> = Bin,
    <<TeleporterCount:16, _/binary>> = Bin2,
    io:format("client read: PT_GET_SCENE_DYNAMIC_TELEPORTER_LIST, SceneId=~p, TeleporterCount=~p~n", [SceneId, TeleporterCount]),
    {EleList, <<>>} = pt:read_array(Bin2, [u32, u16, u16]),
    io:format("*********:~n"),

    F = fun({TeleportNo, X, Y}) ->
            io:format("      Teleporter INFO: TeleportNo=~p, X=~p, Y=~p~n", [TeleportNo, X, Y])
        end,
    lists:foreach(F, EleList),

    io:format("**********~n");




read(?PT_NOTIFY_OBJ_SPAWNED, Bin, _Fd, _PlayerPid) ->
    io:format("client read: PT_NOTIFY_OBJ_SPAWNED~n"),
    {ObjInfoList, <<>>} = pt:read_array(Bin, [u8, u32, u32, u16, u16, u32, u64, u16]),
    io:format("*********:~n"),
    F = fun(ObjInfo) ->
            {ObjType, ObjId, ObjNo, X, Y, TeamId, OwnerId, LeftCanBeKilledTimes} = ObjInfo,
            io:format("      Obj INFO: ObjType=~p, ObjId=~p, ObjNo=~p, X=~p, Y=~p, TeamId=~p, OwnerId=~p, LeftCanBeKilledTimes=~p~n", [ObjType, ObjId, ObjNo, X, Y, TeamId, OwnerId, LeftCanBeKilledTimes])
        end,
    lists:foreach(F, ObjInfoList),
    io:format("**********~n");
    



read(?PT_NOTIFY_OBJ_CLEARED, <<ObjType:8, ObjId:32>>, _Fd, _PlayerPid) ->
    io:format("client read: PT_NOTIFY_OBJ_CLEARED, ObjType=~p ObjId=~p~n", [ObjType, ObjId]);




read(?PT_NOTIFY_DYNAMIC_TELEPORTER_SPAWNED, Bin, _Fd, _PlayerPid) ->
    <<SceneId:32, TeleportNo:32, X:16, Y:16>> = Bin,
    io:format("client read: PT_NOTIFY_DYNAMIC_TELEPORTER_SPAWNED, SceneId=~p, TeleportNo=~p, X=~p, Y=~p~n", [SceneId, TeleportNo, X, Y]);


read(?PT_NOTIFY_DYNAMIC_TELEPORTER_CLEARED, Bin, _Fd, _PlayerPid) ->
    <<SceneId:32, TeleportNo:32, X:16, Y:16>> = Bin,
    io:format("client read: PT_NOTIFY_DYNAMIC_TELEPORTER_CLEARED, SceneId=~p, TeleportNo=~p, X=~p, Y=~p~n", [SceneId, TeleportNo, X, Y]);
    

    

    
read(Cmd, Bin, _Fd, _PlayerPid) ->
    io:format("[glt_scene] default read handler!!!!! ", []),
    io:format("client read: Cmd => ~p, Bin: ~p~n", [Cmd, Bin]).


