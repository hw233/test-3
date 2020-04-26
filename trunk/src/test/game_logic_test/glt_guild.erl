%%%---------------------------------------------
%%% @Module  : glt_guild (game logic test: guild)
%%% @Author  : zhangwq
%%% @Email   : 
%%% @Created : 2013.10.16
%%% @Description: 帮派系统系统测试
%%%---------------------------------------------
-module(glt_guild).

-include("test_client_base.hrl").
-include("pt_40.hrl").
-include("debug.hrl").


-compile(export_all).

create_guild(GuildName) ->
    Socket = get(?PDKN_CONN_SOCKET),
    NameBin = list_to_binary(GuildName),
    NameLen = byte_size(NameBin),
    Data = <<NameLen:16, NameBin/binary>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_CREATE_GUILD, Data)),
    ok.


disband_guild(GuildId) ->
    Socket = get(?PDKN_CONN_SOCKET),
    Data = <<GuildId:64>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_DISBAND_GUILD, Data)),
    ok.


apply_join_guild(GuildId) ->
    Socket = get(?PDKN_CONN_SOCKET),
    Data = <<GuildId:64>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_APPLY_JOIN_GUILD, Data)),
    ok.


handle_apply(PlayerId, Choise) ->
    Socket = get(?PDKN_CONN_SOCKET),
    Data = <<PlayerId:64, Choise:8>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_HANDLE_APPLY, Data)),
    ok.


invite_join(ObjPlayerId) ->
    Socket = get(?PDKN_CONN_SOCKET),
    Data = <<ObjPlayerId:64>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_INVITE_JOIN_GUILD, Data)),
    ok.


kick_out_from_guild(GuildId, ObjPlayerId) ->
    Socket = get(?PDKN_CONN_SOCKET),
    Data = <<GuildId:64, ObjPlayerId:64>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_KICK_OUT_FROM_GUILD, Data)),
    ok.


quit_guild(GuildId) ->
    Socket = get(?PDKN_CONN_SOCKET),
    Data = <<GuildId:64>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_QUIT_GUILD, Data)),
    ok.


get_guild_list(PageSize, PageNum) ->
    Socket = get(?PDKN_CONN_SOCKET),
    Data = <<PageSize:8, PageNum:16>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_GET_GUILD_LIST, Data)),
    ok.


get_req_join_list(GuildId, PageSize, PageNum) ->
    Socket = get(?PDKN_CONN_SOCKET),
    Data = <<GuildId:64, PageSize:8, PageNum:16>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_GET_REQ_JOIN_LIST, Data)),
    ok.
    

modify_guild_tenet(GuildId, Tenet) ->
    Socket = get(?PDKN_CONN_SOCKET),
    Tenet1 = list_to_binary(Tenet),
    Data = <<GuildId:64, (byte_size(Tenet1)):16, Tenet1/binary>>,
    gen_tcp:send(Socket, test_client_base:pack(?MODIFY_GUILD_TENET, Data)),
    ok.


appoint_position(ObjPlayerId, Position) ->
    Socket = get(?PDKN_CONN_SOCKET),
    Data = <<ObjPlayerId:64, Position:8>>,
    gen_tcp:send(Socket, test_client_base:pack(?APPOINT_GUILD_POSITION, Data)),
    ok.


get_general_info(GuildId) ->
    Socket = get(?PDKN_CONN_SOCKET),
    Data = <<GuildId:64>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_BASE_GUILD_INFO, Data)),
    ok.


reply_invite(GuildId, Choise) ->
    Socket = get(?PDKN_CONN_SOCKET),
    Data = <<GuildId:64, Choise:8>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_REPLY_INVITE, Data)),
    ok.


read(?PT_CREATE_GUILD, Bin, _Fd) ->
    <<RetCode:8, GuildId:64, NameBin/binary>> = Bin,
    {Name, <<>>} = pt:read_string(NameBin),
    io:format("client read: PT_CREATE_GUILD, RetCode=~p, GuildId=~p, Name=~p~n", [RetCode, GuildId, Name]);


read(?PT_DISBAND_GUILD, Bin, _Fd) ->
    <<RetCode:8>> = Bin,
    io:format("client read: PT_DISBAND_GUILD, RetCode=~p~n", [RetCode]);


read(?PT_APPLY_JOIN_GUILD, Bin, _Fd) ->
    <<RetCode:8>> = Bin,
    io:format("client read: PT_APPLY_JOIN_GUILD, RetCode=~p~n", [RetCode]);


read(?PT_HANDLE_APPLY, Bin, _Fd) ->
    <<RetCode:8, Choise:8, NameBin/binary>> = Bin,
    {PlayerName, <<>>} = pt:read_string(NameBin),
    io:format("client read: PT_HANDLE_APPLY, RetCode=~p, Choise=~p, PlayerName~p~n", [RetCode, Choise, PlayerName]);


read(?PT_INVITE_JOIN_GUILD, Bin, _Fd) ->
    <<RetCode:8>> = Bin,
    io:format("client read: PT_INVITE_JOIN_GUILD, RetCode=~p~n", [RetCode]);


read(?PT_KICK_OUT_FROM_GUILD, Bin, _Fd) ->
    <<RetCode:8>> = Bin,
    io:format("client read: PT_KICK_OUT_FROM_GUILD, RetCode=~p~n", [RetCode]);


read(?PT_QUIT_GUILD, Bin, _Fd) ->
    <<RetCode:8>> = Bin,
    io:format("client read: PT_QUIT_GUILD, RetCode=~p~n", [RetCode]);


read(?PT_GET_GUILD_LIST, Bin, _Fd) ->
    <<RetCode:8, _TotalPage:16, _PageNum:16, GuildData/binary>> = Bin,
    {GuildList, <<>>} = pt:read_array(GuildData, [u32, string, u16, int64, string, u16, u8, u16, string]),

    io:format("client read: PT_GET_GUILD_LIST, RetCode=~p~n", [RetCode]),
    io:format("guild list begin: ~n", []),
    F = fun(PlayerInfo) ->
        io:format("[GuildId, GuildName, Lv, ChiefId, ChiefName, Rank, CurMbCount, MbCapacity, Notice] = [~p~n]", [PlayerInfo])
    end,
    lists:foreach(F, GuildList),
    io:format("guild list end.~n");


read(?PT_GET_REQ_JOIN_LIST, Bin, _Fd) ->
    <<RetCode:8, _TotalPage:16, _PageNum:16, JoinListData/binary>> = Bin,
    {ReqJoinList, <<>>} = pt:read_array(JoinListData, [int64, string, u16, u8, u32]),

    io:format("client read: PT_GET_REQ_JOIN_LIST, RetCode=~p~n", [RetCode]),
    io:format("ReqJoin list begin: ~n", []),
    F = fun(Info) ->
        io:format("[PlayerId, Name, Lv, Sex, ReqTime] = [~p~n]", [Info])
    end,
    lists:foreach(F, ReqJoinList),
    io:format("ReqJoin list end.~n");


read(?MODIFY_GUILD_TENET, Bin, _Fd) ->
    <<RetCode:8>> = Bin,
    io:format("client read: MODIFY_GUILD_TENET, RetCode=~p~n", [RetCode]);


read(?APPOINT_GUILD_POSITION, Bin, _Fd) ->
    <<RetCode:8>> = Bin,
    io:format("client read: APPOINT_GUILD_POSITION, RetCode=~p~n", [RetCode]);


read(?PT_BASE_GUILD_INFO, Bin, _Fd) ->
    <<GuildId:64, BinRemain/binary>> = Bin,
    {GuildName, BinRemain1} = pt:read_string(BinRemain),
    <<Lv:16, BinRemain2/binary>> = BinRemain1,
    {Notice, BinRemain3} = pt:read_string(BinRemain2),
    <<ChiefId:64, BinRemain4/binary>> = BinRemain3,
    {ChiefName, BinRemain5} = pt:read_string(BinRemain4),
    <<Rank:16, CurMbCount:16, MbCapacity:16, Contri:32, Prosperity:32>> = BinRemain5,

    io:format("client read: PT_BASE_GUILD_INFO, [GuildId,GuildName,Lv,Notice,ChiefId,ChiefName,Rank,CurMbCount,MbCapacity,Contri,Prosperity]= [~p,~p,~p,~p,~p,~p,~p,~p,~p,~p,~p]~n", 
        [GuildId,GuildName,Lv,Notice,ChiefId,ChiefName,Rank,CurMbCount,MbCapacity,Contri,Prosperity]);


read(?PT_REPLY_INVITE, Bin, _Fd) ->
    <<RetCode:8>> = Bin,
    io:format("client read: PT_REPLY_INVITE, RetCode=~p~n", [RetCode]);


read(Cmd, Bin, _Fd) ->
    io:format("[glt_guild] default read handler!!!!! ", []),
    io:format("client read: Cmd => ~p, Bin: ~p~n", [Cmd, Bin]).