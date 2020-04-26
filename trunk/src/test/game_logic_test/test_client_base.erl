%%%---------------------------------------------
%%% @Module  : test_client_base
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2013.7.22
%%% @Description: 基础客户端测试程序
%%%---------------------------------------------
-module(test_client_base).

-compile(export_all).

-include("common.hrl").
-include("test_client_base.hrl").
-include("pt_10.hrl").
-include("pt_12.hrl").
-include("pt_13.hrl").
-include("pt_comm.hrl").
-include("abbreviate.hrl").
-include("debug.hrl").
-include("player.hrl").

%% *******************************************
%% 账户登录游戏并创建一个角色，然后进入游戏的正常流程：
%  (1) 开服，然后打开Erlang shell，然后在shell中进行下面的操作：
%  (2) 切换到项目的ebin目录（路径据自己的实际情况做调整）：
%      cd("E:/work/server/trunk/simple_server/smserver/ebin").
%  (3) 连接服务器（参数为服务器ip和端口）:
%      test_client_base:connect_server("127.0.0.1", 9999).
%  (4) 登录账户（参数为账户名）：
%      test_client_base:login("uc_xProj9527").
%  (5) 获取账户的角色列表（即使是新账户，角色列表为空，这一步也需要，因为代码中有严格检查登录的流程是否正确）：
%      test_client_base:get_role_list().
%  (6) 创建角色（参数为：种族，性别，名字），如果已有角色，则可跳过此步，直接到第7步：
%      test_client_base:create_role(1, 1, "name1").
%  (7) 选择角色进入游戏（参数为角色id）：
%      test_client_base:enter_game(18).
%  (8) 进入游戏成功后，可以按需发送协议给服务器以做相应的测试，比如走路：
%      test_client_base:move_to(20, 15).
%
%  注: 对于已有角色的账户，快速进入游戏的流程是直接在shell中执行：
%      test_client_base:fast_enter_game("127.0.0.1", 9999, "uc_xProj9527", 18).
%      其中参数为：账户名，角色id
%% *******************************************


for(Max, Max, _F, X) ->
    X;
for(Min, Max, F, X) ->
    X2 = F(X),
    for(Min+1, Max, F, X2).



for(Max, Max, _F) ->
    [];
for(Min, Max, F) ->
    [F(Min) | for(Min+1, Max, F)].


 % sleep_send({T, S}) ->
 %    receive
 %    after T -> handle(run, a, S)
 %    end.


%% （进游戏成功后）获取玩家数据
get_client_ps() ->
    % [PS] = ets:tab2list(ets_client_ps),
    % PS.
    PlayerId = get(?PDKN_LOGIN_PLAYERID),
    % io:format("get_client_ps(), PlayerId = ~p~n", [PlayerId]),
    case ets:lookup(ets_client_ps, PlayerId) of
        [] -> null;
        [PS] -> PS
    end.


%% （进游戏成功后）更新玩家数据
set_client_ps(PS_Latest) ->
    ?ASSERT(is_record(PS_Latest, client_ps)),
    ets:insert(ets_client_ps, PS_Latest).


%% 初始化玩家数据
%% 注：创建ets来存玩家的数据,是为了方便：主进程和接收服务端消息的进程都可以通过ets来获取或更新自己的数据。
init_client_ps(PlayerId) ->
    % case get(?PDKN_ALREADY_CREATED_PS_ETS) of
    %     true ->
    %         true = ets:insert_new(ets_client_ps, #client_ps{id = PlayerId});
    %     undefined ->
    %         ets:new(ets_client_ps, [{keypos, #client_ps.id}, named_table, public, set]),
    %         put(?PDKN_ALREADY_CREATED_PS_ETS, true),
    %         true = ets:insert_new(ets_client_ps, #client_ps{id = PlayerId})
    % end.
    % io:format("init_client_ps(), PlayerId=~p~n", [PlayerId]),
    case ets:info(ets_client_ps) of
        undefined ->
            % io:format("ets_client_ps undefined~n"),
            ets:new(ets_client_ps, [{keypos, #client_ps.id}, named_table, public, set]),
            true = ets:insert_new(ets_client_ps, #client_ps{id = PlayerId});
        _Any ->
            % io:format("ets_client_ps exists~n"),
            true = ets:insert_new(ets_client_ps, #client_ps{id = PlayerId})
    end.


%% 打印出玩家数据
show_client_ps() ->
    case get_client_ps() of
        null ->
            io:format("PS is null ~n");
        PS ->
            FieldList = record_info(fields, client_ps),

            io:format("********************:~n"),

            F = fun(Field) ->
                    Index = list_util:get_ele_pos(Field, FieldList) + 1,
                    io:format("~p = ~p~n", [Field, erlang:element(Index, PS)])
                end,
            lists:foreach(F, FieldList),

            io:format("********************~n")
    end.



%% 快速进入游戏（按正常流程在账户下创建好角色后，后续即可通过此接口直接进入游戏）
fast_create_role(Host, Port, AccName, RoleName) ->
    ?ASSERT(is_list(RoleName)),
    connect_server(Host, Port),
    timer:sleep(50),  % 让接收进程先运行，故sleep
    login(AccName),
    get_role_list(),
    create_role(1, 1, RoleName).


%% 快速进入游戏（按正常流程在账户下创建好角色后，后续即可通过此接口直接进入游戏）
fast_enter_game(Host, Port, AccName, PlayerId) ->
    connect_server(Host, Port),
    timer:sleep(50),  % 让接收进程先运行，故sleep
    login(AccName),
    get_role_list(),
    enter_game(PlayerId).
    
    



%% 连接服务器
connect_server(Host, Port) ->
    case gen_tcp:connect(Host, Port, [binary, {packet, 2}], 100000) of
        {ok, Socket} ->
            io:format("connect server ok, Socket: ~p~n", [Socket]),

            put(?PDKN_CONN_SOCKET, Socket),  % 记录连接的socket

            ParentPid = self(),
            {ok, FileDesc} = open_file(?TEST_CLIENT_LOG_FILE), % TODO: 注意：因为路径是用windows系统的路径的写法，故目前只适用于windows平台， 有待完善以适用于linux系统！！

            % spawn接收服务端返回的消息的进程
            RecvPid = spawn_link(fun() -> recv(Socket, ParentPid, FileDesc) end),

            % spawn发送心跳包给服务端的进程
            spawn_link(fun() -> send_heartbeat(Socket) end),

            ok = gen_tcp:controlling_process(Socket, RecvPid), % 勿忘：转交Socket的控制给接收进程！
            {ok, Socket};
        {error, Reason} ->
            io:format("connect server failed!! Reason: ~p~n", [Reason]),
            {fail, Reason}
    end.





%% 登录账号
login(AccName) ->
    ?ASSERT(is_list(AccName)),
    Socket = get(?PDKN_CONN_SOCKET),

    % 登录
    UnixTime = util:unixtime(),  %%1273027133,
    Tick = AccName ++ integer_to_list(UnixTime) ++ ?TICKET,
    TickMd5 = util:md5(Tick),
    TickMd5Bin = list_to_binary(TickMd5),
    ?ASSERT(byte_size(TickMd5Bin) == 32),
    AccNameLen = byte_size(list_to_binary(AccName)),
    AccNameBin = list_to_binary(AccName),
    PhoneModel = <<"">>,
    PhoneMAC = <<"">>,
    FromServerId = 0,
    Data = <<UnixTime:32, AccNameLen:16, AccNameBin/binary, 32:16, TickMd5Bin/binary, 
            (byte_size(PhoneModel)):16, PhoneModel/binary, 
            (byte_size(PhoneMAC)):16, PhoneMAC/binary,
            FromServerId:32
            >>,
    
    %%Len = byte_size(Data) + 4,
    %%gen_tcp:send(Socket, <<Len:16, ?PT_LOGIN_REQ:16, Data/binary>>),

    io:format("client send: login, UnixTime : ~p~n AccName: ~p~n TickMd5: ~p~n", [UnixTime, AccName, TickMd5]),

    gen_tcp:send(Socket, pack(?PT_LOGIN_REQ, Data)),
    ok.



get_cur_proto_seq_num() ->
    case erlang:get(?PDKN_C2S_CUR_PROTO_SEQ_NUM) of
        undefined ->
            0;
        Val ->
            Val
    end.

set_cur_proto_seq_num(Num) ->
    erlang:put(?PDKN_C2S_CUR_PROTO_SEQ_NUM, Num).


pack(Cmd, RawCmdBody) ->
    ProtoSeqNum = get_cur_proto_seq_num() + 1,
    set_cur_proto_seq_num(ProtoSeqNum),
    CheckCode = pt:calc_check_code(Cmd, <<ProtoSeqNum:32, RawCmdBody/binary>>),
    <<Cmd:16, ProtoSeqNum:32, RawCmdBody/binary, CheckCode:32>>.









%% 获取账号的角色列表
get_role_list() ->
    Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: get_role_list~n", []),
    gen_tcp:send(Socket, pack(?PT_GET_ACC_ROLE_LIST, <<>>)),
    ok.



%% 创建角色
create_role(Race, Sex, Name) when is_list(Name) ->
    NameBin = list_to_binary(Name),
    create_role(Race, Sex, NameBin);
create_role(Race, Sex, Name) when is_binary(Name) ->
    Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: create_role, [Race, Sex, Name]: ~p ~p ~p~n", [Race, Sex, binary_to_list(Name)]),
    NameLen = byte_size(Name),
    Data = <<Race:8, Sex:8, NameLen:16, Name/binary>>,
    %%Len = byte_size(Data) + 4,
    gen_tcp:send(Socket, pack(?PT_CREATE_ROLE, Data)),
    ok.

    


%% 选择角色进入游戏
enter_game(PlayerId) ->
    Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: enter_game, PlayerId: ~p~n", [PlayerId]),
    Data = <<PlayerId:64>>,
    gen_tcp:send(Socket, pack(?PT_ENTER_GAME, Data)),
    receive 
        {enter_game_success, PlayerId, _SceneId, _X, _Y} ->
            put(?PDKN_LOGIN_PLAYERID, PlayerId),  % 主进程中记录玩家id
            glt_player:get_my_brief_info(),
            glt_player:get_my_detail_info(),
            glt_player:get_my_day_reward_info()
        after 1500 ->
            skip
    end,
    ok.

    



%% (进入游戏后)玩家移动，终点为坐标{X, Y}
move_to(X, Y) ->
    Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: move_to (~p,~p)~n", [X, Y]),

    CliPS = get_client_ps(),
    SceneId = CliPS#client_ps.scene_id,
    Data = <<SceneId:32, X:16, Y:16>>,
    gen_tcp:send(Socket, pack(?PT_PLAYER_MOVE, Data)),
    ok.



% %% 循环测试
% ct(N) ->
%     F = fun(N1) ->
%             spawn(fun() -> connect_server(), login( integer_to_list(N1 + 10000)) end),
%             timer:sleep(500)
%         end,
%     for(1, N+1, F),
%     ok.


% pack(Cmd, Data) ->
%     ?ASSERT(is_binary(Data), Data),
%     <<Cmd:16, Data/binary>>.



%% 接收服务端返回的消息
read0(<<Cmd:16, _IsCompress:8, DataBody/binary>>, Fd, PlayerPid) ->
    ?ASSERT(_IsCompress == 0),    % 暂时断言协议包都不压缩
    read_routing(Cmd, DataBody, Fd, PlayerPid).

read_routing(Cmd, DataBody, Fd, PlayerPid) ->
    io:format("read Cmd : ~p~n", [Cmd]),
    case Cmd of
        ?PT_SEND_PROMPT_MSG ->
            read(Cmd, DataBody, Fd, PlayerPid);
        ?PT_DEBUG_ERR_MSG_ECHO ->
            read(Cmd, DataBody, Fd, PlayerPid);
        ?PT_PLAYER_MOVE ->
            read(Cmd, DataBody, Fd, PlayerPid);
        _ ->
            ?ASSERT(Cmd >= 10000, Cmd),  % 其他情况则暂时断言协议号都 >= 10000
            case Cmd div 1000 of
                11 ->
                    glt_chat:read(Cmd, DataBody, Fd);
                12 ->
                    glt_scene:read(Cmd, DataBody, Fd, PlayerPid);
                13 ->
                    glt_player:read(Cmd, DataBody, Fd);
                15 ->
                    glt_goods:read(Cmd, DataBody, Fd);
                17 ->
                    glt_partner:read(Cmd, DataBody, Fd);
                20 ->
                    glt_battle:read(Cmd, DataBody, Fd);
                21 ->
                    glt_xinfa:read(Cmd, DataBody, Fd);
                24 ->
                    glt_team:read(Cmd, DataBody, Fd);
                32 when Cmd >= 32050 ->
                    glt_mon_interact:read(Cmd, DataBody, Fd);
                32 ->
                    glt_npc:read(Cmd, DataBody, Fd);
                40 ->
                    glt_guild:read(Cmd, DataBody, Fd);
                41 ->
                    glt_hire:read(Cmd, DataBody, Fd);
                _ ->
                    read(Cmd, DataBody, Fd, PlayerPid)
            end
    end.


%% 提示信息
read(?PT_SEND_PROMPT_MSG, <<_Type:8, PromptMsgCode:32>>, _Fd, _PlayerPid) ->
    io:format("client read: PT_SEND_PROMPT_MSG, PromptMsgCode: ~p~n", [PromptMsgCode]); 


%% 报错信息回显
read(?PT_DEBUG_ERR_MSG_ECHO, Bin, _Fd, _PlayerPid) ->
     {ErrMsg, <<>>} = pt:read_string(Bin),
    io:format("client read: PT_DEBUG_ERR_MSG_ECHO!!!!!~n~s~n", [ErrMsg]); 


%% 登录
read(?PT_LOGIN_REQ, <<RetCode:8>>, _Fd, _PlayerPid) ->
    io:format("client read: PT_LOGIN_REQ, RetCode: ~p~n", [RetCode]);
    


%% 获取账号的角色列表
read(?PT_GET_ACC_ROLE_LIST, <<RetCode:8, RoleCount:16, RoleListData/binary>>, _Fd, _PlayerPid) ->
    io:format("client read: PT_GET_ACC_ROLE_LIST, RetCode: ~p, RoleCount: ~p~n", [RetCode, RoleCount]),
    io:format("role list begin:~n"),
    F = fun(Bin0) ->
        <<Id:64, LocalId:32, IsBanned:8, Race:8, Faction:8, Sex:8, Lv:8, NameBin/binary>> = Bin0,
        {Name, Rest} = pt:read_string(NameBin),
        io:format("role info: Id=~p LocalId=~p IsBanned=~p Race=~p Faction=~p Sex=~p Lv=~p Name=~p~n", [Id, LocalId, IsBanned, Race, Faction, Sex, Lv, Name]),
        Rest
    end,
    for(0, RoleCount, F, RoleListData),
    io:format("role list end.~n");

%% 创建角色
read(?PT_CREATE_ROLE, Bin, _Fd, _PlayerPid) ->
    <<RetCode:8, NewRoleId:64, NewRoleLocalId:32, Race:8, Sex:8, NameBin/binary>> = Bin,
    {Name, <<>>} = pt:read_string(NameBin),
    io:format("client read: PT_CREATE_ROLE, RetCode=~p, NewRoleId=~p, NewRoleLocalId=~p, Race=~p, Sex=~p, Name=~p~n", 
                    [RetCode, NewRoleId, NewRoleLocalId, Race, Sex, Name]);


%% 角色进入游戏
read(?PT_ENTER_GAME, Bin, _Fd, PlayerPid) ->
    <<RetCode:8, PlayerId:64>> = Bin,

    DefaultSceneId =
    case get(?PDKN_LOGIN_SCENE_ID) of  % 何处put(PDKN_LOGIN_SCENE_ID, xxx)？ ---- 见glt_player模块的read(?PT_PLYR_GET_MY_BRIEF, Bin, _Fd)
        undefined -> ?BORN_SCENE_NO;
        SceneId -> SceneId
    end,

    io:format("client read: PT_ENTER_GAME, RetCode=~p, PlayerId=~p~n", [RetCode, PlayerId]),
    ?Ifc (RetCode == ?RES_OK)
        put(?PDKN_LOGIN_PLAYERID, PlayerId),  % recv进程中记录玩家id

        init_client_ps(PlayerId),

        % 通知主进程进入游戏成功
        PlayerPid ! {enter_game_success, PlayerId, DefaultSceneId, 18, 15} % 暂时写死进入地图点{18, 15}
    ?End;


%% 玩家移动到{X, Y}
read(?PT_PLAYER_MOVE, Bin, _Fd, _PlayerPid) ->
    <<PlayerId:64, X:16, Y:16>> = Bin,
    io:format("client read: PT_PLAYER_MOVE, PlayerId=~p, (X,Y)=(~p, ~p)~n", [PlayerId, X, Y]),
    PS = get_client_ps(),
    set_client_ps(PS#client_ps{x = X, y = Y});


read(?PT_NOTIFY_ACC_RELOGIN, Bin, _Fd, _PlayerPid) ->
    <<>> = Bin,
    io:format("client read: PT_NOTIFY_ACC_RELOGIN~n");


read(Cmd, Bin, _Fd, _PlayerPid) ->
    io:format("[test_client_base] default read handler!!!!! ", []),
    io:format("client read: Cmd => ~p, Bin: ~p~n", [Cmd, Bin]).




open_file(FileName) ->
    case file:open(FileName, [append, raw]) of
        {ok, FileDesc} ->
            {ok, FileDesc};
        Error ->
            io:format("open file(~s) failed!!!! Error=~w~n", [FileName, Error]),
            Error
    end.


%% 接收服务端返回的数据包
recv(Socket, PlayerPid, FileDesc) ->
    % process_flag(trap_exit, true),
    receive
        {tcp, Socket, Bin} ->
            % io:format("test_client_base, recv() , Bin=~p,,,~n", [Bin]),
            read0(Bin, FileDesc, PlayerPid);
        {tcp_closed, Socket} ->
            io:format("client recv tcp_closed!~n"),
            file:close(FileDesc),
            gen_tcp:close(Socket);
        % {handle, Cmd, Data} ->
        %     ?ASSERT(false),
        %     handle(Cmd, Data, Socket);
        % {handle, Cmd} ->
        %     ?ASSERT(false),
        %     handle(Cmd, 0, Socket);
        % close ->
        %     ?ASSERT(false),
        %     gen_tcp:close(Socket);
        _Any ->
            % file:write(FileDesc, io_lib:format("client recv error!~p~n", [Any])),
            % ?ASSERT(false, _Any)
            io:format("recv(), _Any!!!!! ~p~n", [_Any]),
            skip
            
            %%io:format("client recv error=======================>: ~p~n",[Any])
%        after 15000 ->
%            io:format("circle send: heart 10006~n"),
%            gen_tcp:send(Socket, <<4:16, 10006:16>>),
%            recv(Socket)
    end,
    recv(Socket, PlayerPid, FileDesc).


%% 定时循环发送心跳包
send_heartbeat(_Socket) ->
    % io:format("client send: heartbeat~n"),
    % gen_tcp:send(Socket, pack(?PT_CONNECTION_HEARTBEAT, <<>>)),
    % timer:sleep(60000),
    % send_heartbeat(Socket).

    do_nothing.
