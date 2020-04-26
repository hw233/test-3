%%%---------------------------------------------
%%% @Module  : test_rich 
%%% @Author  : hmy 
%%% @Email   : 44232841@qq.com 
%%% @Created : 2011.10.18
%%% @Description: 大富翁副本 
%%%---------------------------------------------
-module(tst_rich).
-include("common.hrl").
-compile(export_all).

for(Max, Max, _F, X) ->
    X;
for(Min, Max, F, X) ->
    F(X),
    for(Min+1, Max, F, X).

sleep_send({T, S}) ->
    receive
    after T -> handle(run, a, S)
    end.

loop(N) ->
    case gen_tcp:connect("localhost", 6666, [binary, {packet, 0}], 100000) of
        {ok, Socket} ->
            io:format("connect ok: ~p~n", [N]),
            sleep(10),
            case N  of 
                1 ->
                    % 登录消息10000
                    handle(login, {123, integer_to_list(123620)}, Socket),
                    sleep(100),
                    handle(enter_player, {1}, Socket),
                    sleep(100);
                2 ->
                    handle(login, {1234, integer_to_list(321)}, Socket),
                    sleep(100),
                    handle(enter_player, {2}, Socket),
                    sleep(100)
            end,
            %% 取得大富翁基础房间列表
%%            handle(base_list, {}, Socket),
%%            sleep(100),
%%            %% 进入基础房间列表
%%            handle(enter_base_room, {1}, Socket),
%%            sleep(100),
            %% 取得房间信息
            handle(get_gameroom_info, {1}, Socket),
            sleep(100),
            handle(create_room, {1, <<"测试">>}, Socket),
            sleep(100),
            rec(Socket);
        {error, Reason} ->
            io:format("connect failed: ~p~n", [Reason])   
    end.

for(Max, Max, _F) ->
    [];
for(Min, Max, F) ->
    [F(Min) | for(Min+1, Max, F)].

%% 循环测试
ct(N) ->
    F = fun(N1) ->
            spawn(fun() -> loop(N1+10000) end),
            sleep(500)
    end,
    for(1, N+1, F),
    ok.


%%心跳包
handle(heart, _, Socket) ->
    io:format("client send: heart Cmd=[10006]~n"),
    gen_tcp:send(Socket, <<4:16, 10006:16>>),
    ok;%rec(Socket);
%%登陆
handle(login, {Accid, AccName}, Socket) ->
    io:format("client send: login Cmd=[10000], Accid=[~p], AccName=[~p] ~n", [Accid, AccName]),
    AccStamp = 1273027133,
    Tick = integer_to_list(Accid) ++ AccName ++ integer_to_list(AccStamp) ++ ?TICKET,
    TickMd5 = util:md5(Tick),
    TickMd5Bin = list_to_binary(TickMd5),
    AccNameLen = byte_size(list_to_binary(AccName)),
    AccNameBin = list_to_binary(AccName),
    Data = <<Accid:32, AccStamp:32, AccNameLen:16, AccNameBin/binary, 32:16, TickMd5Bin/binary>>,
    Len = byte_size(Data) + 4,
    gen_tcp:send(Socket, <<Len:16, 10000:16, Data/binary>>),
    ok;%rec(Socket);
%%创建用户
handle(create_player, {Pro, Sex, Name}, Socket) ->
    io:format("client send: create_player Cmd=[10003], Pro=[~p], Sex=[~p], Name[~p] ~n", [Pro, Sex, Name]),
    NameBin = list_to_binary(Name),
    NameLen = byte_size(NameBin),
    Data = <<Pro:16, Sex:16, NameLen:16, NameBin/binary>>,
    Len = byte_size(Data) + 4,
    gen_tcp:send(Socket, <<Len:16, 10003:16, Data/binary>>),
    ok;%%rec(Socket);
%%玩家列表
handle(list_player, _, Socket) ->
    io:format("client send: list_player Cmd=[10002]~n"),
    gen_tcp:send(Socket, <<6:16, 10002:16, 1:16>>),
    rec(Socket);
%%选择角色进入
handle(enter_player, {PlayerId}, Socket) ->
    io:format("client send: enter_player Cmd=[10004], PlayerId=[~p] ~n", [PlayerId]),
    gen_tcp:send(Socket, <<8:16, 10004:16, PlayerId:32>>),
    ok;%rec(Socket);

%% 取得基础房间列表
handle(base_list, {}, Socket) ->
    io:format("client send: get_list Cmd=[43001]~n", []),
    MsgLen = byte_size(<<1:16,43001:16>>),
    gen_tcp:send(Socket, <<MsgLen:16, 43001:16>>),
    ok;%rec(Socket);

%% 进入基础房间
handle(enter_base_room, {RoomId}, Socket) ->
    io:format("client send: get_list Cmd=[43002]~n", []),
    MsgLen = byte_size(<<1:16,43002:16,RoomId:16>>),
    gen_tcp:send(Socket, <<MsgLen:16, 43002:16, RoomId:16>>),
    ok;%rec(Socket);

%% 取游戏房间信息
handle(get_gameroom_info, {RoomId}, Socket) ->
    io:format("client send: get_list Cmd=[43002]~n", []),
    MsgLen = byte_size(<<1:16,43003:16,RoomId:16>>),
    gen_tcp:send(Socket, <<MsgLen:16, 43003:16, RoomId:16>>),
    ok;%rec(Socket);

%% 取游戏房间信息
handle(create_room, {RoomId, _RoomName}, Socket) ->
    io:format("client send: get_list Cmd=[43002]~n", []),
    MsgLen = byte_size(<<1:16,43003:16,RoomId:16>>),
    gen_tcp:send(Socket, <<MsgLen:16, 43003:16, RoomId:16>>),
    ok;%rec(Socket);

handle(Handle, Data, Socket) ->
    io:format("hadle error: ~p ~p~n", [Handle, Data]),
    {reply, handle_no_match, Socket}.

%%玩家列表
read(<<L:16, 10002:16, Num:16, Bin/binary>>) ->
    io:format("client read: ~p ~p ~p~n", [L, 10002, Num]),
    F = fun(Bin1) ->
            <<Id:32, S:16, C:16, Sex:16, Lv:16, Bin2/binary>> = Bin1,
            {Name, Rest} = read_string(Bin2),
            io:format("player list: Id=~p Status=~p Pro=~p Sex=~p Lv=~p Name=~p~n", [Id, S, C, Sex, Lv, Name]),
            Rest
    end,
    for(0, Num, F, Bin),
    io:format("player list end.~n");

read(<<L:16, Cmd:16>>) ->
    io:format("client read: ~p ~p~n", [L, Cmd]);
read(<<L:16, Cmd:16, Status:16>>) ->
    io:format("client read: ~p ~p ~p~n", [L, Cmd, Status]);
read(<<L:16, Cmd:16, Bin/binary>>) ->
    io:format("client read: ~p ~p ~p~n", [L, Cmd, Bin]);
read(<<L:16, Cmd:16, Status:16, Bin/binary>>) ->
    io:format("client read: ~p ~p ~p ~p~n", [L, Cmd, Status, Bin]);
read(Bin) ->
    io:format("client rec: ~p~n", [Bin]).


rec(Socket) ->
    receive
        %%flash安全沙箱
        {tcp, Socket, <<"<cross-domain-policy><allow-access-from domain='*' to-ports='*' /></cross-domain-policy>">>} ->
            io:format("rec: ~p~n", ["flash_file"]);
        {tcp, Socket, Bin} ->
            io:format("rec: ~p~n", [Bin]),
            read(Bin);
        {tcp_closed, Socket} ->
            io:format("client recv error!~n");
        {handle, Cmd, Data} ->
            handle(Cmd, Data, Socket);
        {handle, Cmd} ->
            handle(Cmd, 0, Socket);
        close ->
            gen_tcp:close(Socket);
        Any ->
            io:format("client recv error=======================>: ~p~n",[Any])
    end,
    rec(Socket).

%%读取字符串
read_string(Bin) ->
    case Bin of
        <<Len:16, Bin1/binary>> ->
            case Bin1 of
                <<Str:Len/binary-unit:8, Rest/binary>> ->
                    {binary_to_list(Str), Rest};
                _R1 ->
                    {[],<<>>}
            end;
        _R1 ->
            {[],<<>>}
    end.

sleep(T) ->
    receive
    after T -> ok
    end.
