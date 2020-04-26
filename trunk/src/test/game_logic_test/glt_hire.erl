%%%---------------------------------------------
%%% @Module  : glt_hire (game logic test: NPC)
%%% @Author  : zhangwq, huangjf
%%% @Email   : 
%%% @Created : 2014.2.18
%%% @Description: 雇佣天将系统测试
%%%---------------------------------------------
-module(glt_hire).

-compile(export_all).

-include("common.hrl").
-include("test_client_base.hrl").
-include("pt_41.hrl").
-include("hire.hrl").




%% 报名
sign_up(Price) ->
    Socket = get(?PDKN_CONN_SOCKET),
    Data = <<Price:32>>,
    gen_tcp:send(Socket, test_client_base:pack(?SIGN_UP, Data)),
    ok.


%% 雇佣天将
hire_player(TargetPlayerId, Price) ->
    Socket = get(?PDKN_CONN_SOCKET),
    Count = 100,
    Data = <<TargetPlayerId:64, Count:8, Price:32>>,
    gen_tcp:send(Socket, test_client_base:pack(?HIRE_PLAYER, Data)),
    ok.



%% 让雇佣天将出战
let_hired_player_fighting() ->
    Socket = get(?PDKN_CONN_SOCKET),
    Data = <<>>,
    gen_tcp:send(Socket, test_client_base:pack(?FIGHT_MY_HIRE, Data)),
    ok.








read(?SIGN_UP, Bin, _Fd) ->
    <<RetCode:8>> = Bin,
    io:format("client read: SIGN_UP, RetCode=~p~n", [RetCode]);



read(?HIRE_PLAYER, Bin, _Fd) ->
    <<RetCode:8, PlayerId:64, Count:8>> = Bin,
    io:format("client read: HIRE_PLAYER, RetCode=~p, PlayerId=~p, Count=~p~n", [RetCode, PlayerId, Count]);




read(Cmd, Bin, _Fd) ->
    io:format("[glt_hire] default read handler!!!!!~n", []),
    io:format("client read: Cmd => ~p, Bin: ~p~n", [Cmd, Bin]).
