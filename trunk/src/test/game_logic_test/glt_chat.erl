%%%---------------------------------------------
%%% @Module  : glt_chat (game logic test: chat)
%%% @Author  : huangjf, LDS
%%% @Email   : 
%%% @Created : 2013.10.14
%%% @Description: 聊天系统测试
%%%---------------------------------------------
-module(glt_chat).

-compile(export_all).

-include("common.hrl").
-include("test_client_base.hrl").
% -include("pt_11.hrl").


%% 世界聊天
chat_world(ChatMsg) ->
    ?ASSERT(is_list(ChatMsg)),
    Socket = get(?PDKN_CONN_SOCKET),
    ChatMsg_Bin = list_to_binary(ChatMsg),
    ChatMsgLen = byte_size(ChatMsg_Bin),
    Data = <<ChatMsgLen:16, ChatMsg_Bin/binary>>,
    gen_tcp:send(Socket, test_client_base:pack(11001, Data)),
    ok.



read(11001, Bin, _Fd) ->
    io:format("client read: 11001 (chat world)~n"),
    <<PlayerId:64, Bin2/binary>> = Bin,
    {ChatMsg, Bin3} = pt:read_string(Bin2),
    <<Identity:8, Bin4/binary>> = Bin3,
    {PlayerName, <<>>} = pt:read_string(Bin4),
    io:format("    Identity=~p PlayerId=~p PlayerName=~s~n    ChatMsg=~s~n", [Identity, PlayerId, PlayerName, ChatMsg]);


% read(11205, Bin, _Fd) ->
%     <<No:32, Type:8, Priority:8, Bin1/binary>> = Bin,
%     io:format("[No, Type, Priority] = [~p~p~p~n]", [No, Type, Priority]),
%     {IntInfoList, Bin2} = pt:read_array(Bin1, [u8, u32]),
%     {StringInfoList, <<>>} = pt:read_array(Bin2, [u8, string]),
%     F = fun(Info) ->
%         io:format("[Idex, Value] = [~p~n]", [Info])
%     end,
%     lists:foreach(F, IntInfoList),
%     io:format("~n"),
%     lists:foreach(F, StringInfoList);

read(Cmd, Bin, _Fd) ->
    io:format("[glt_chat] default read handler!!!!!~n", []),
    io:format("client read: Cmd => ~p, Bin: ~p~n", [Cmd, Bin]).
