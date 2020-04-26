%%%---------------------------------------------
%%% @Module  : glt_partner (game logic test: partner)
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2013.12.18
%%% @Description: 宠物系统测试
%%%---------------------------------------------
-module(glt_partner).

-compile(export_all).

-include("common.hrl").
-include("test_client_base.hrl").
-include("pt_17.hrl").





%% 设置为主宠
set_as_main_partner(PartnerId) ->
    Socket = get(?PDKN_CONN_SOCKET),
    Data = <<PartnerId:64>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_SET_MAIN_PARTNER, Data)),
    ok.


%% 设置宠物状态
set_partner_state(PartnerId, NewState) ->
    Socket = get(?PDKN_CONN_SOCKET),
    Data = <<PartnerId:64, NewState:8>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_SET_PARTNER_STATE, Data)),
    ok.








%% 
read(?PT_SET_MAIN_PARTNER, Bin, _Fd) ->
    <<RetCode:8, PartnerId:64>> = Bin,
    io:format("client read: PT_SET_MAIN_PARTNER, RetCode=~p, PartnerId=~p~n", [RetCode, PartnerId]);


%% 
read(?PT_SET_PARTNER_STATE, Bin, _Fd) ->
    <<RetCode:8, PartnerId:64, State:8>> = Bin,
    io:format("client read: PT_SET_PARTNER_STATE, RetCode=~p, PartnerId=~p, State=~p~n", [RetCode, PartnerId, State]);

    

read(Cmd, Bin, _Fd) ->
    io:format("[glt_partner] default read handler!!!!!~n", []),
    io:format("client read: Cmd => ~p, Bin: ~p~n", [Cmd, Bin]).
