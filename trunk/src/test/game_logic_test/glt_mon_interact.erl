%%%---------------------------------------------
%%% @Module  : glt_mon_interact (game logic test: monster interactive)
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2013.12.3
%%% @Description: 玩家与怪物的交互测试
%%%---------------------------------------------
-module(glt_mon_interact).


%%然后调整glt_battle(应20041协议的调整), 重导技能数据，测试技能37，然后继续技能逻辑。。


-include("test_client_base.hrl").
-include("pt_32.hrl").
-include("debug.hrl").

-compile(export_all).



%% 对话明雷怪
talk_to_mon(MonId) ->
	Socket = get(?PDKN_CONN_SOCKET),
    Data = <<MonId:32>>,
	gen_tcp:send(Socket, test_client_base:pack(?PT_TALK_TO_MON, Data)),
    ok.





read(?PT_TALK_TO_MON, Bin, _Fd) ->
    <<RetCode:8, MonId:32>> = Bin,
    io:format("client read: PT_TALK_TO_MON, RetCode:~p, MonId:~p~n", [RetCode, MonId]);



read(Cmd, Bin, _Fd) ->
    io:format("[glt_mon_interact] default read handler!!!!! "),
    io:format("client read: Cmd => ~p, Bin: ~p~n", [Cmd, Bin]).


