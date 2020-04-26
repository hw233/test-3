%%%---------------------------------------------
%%% @Module  : glt_xinfa (game logic test: xinfa)
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2013.11.19
%%% @Description: 心法系统测试
%%%---------------------------------------------
-module(glt_xinfa).


-include("test_client_base.hrl").
-include("pt_21.hrl").
-include("debug.hrl").

-compile(export_all).



%% 查询自己的心法信息
query_xinfa_info() ->
	Socket = get(?PDKN_CONN_SOCKET),
    Data = <<>>,
	gen_tcp:send(Socket, test_client_base:pack(?PT_QUERY_XF_INFO, Data)),
    ok.




%% 升级心法
upgrade_xinfa(XinfaId) ->
    Socket = get(?PDKN_CONN_SOCKET),
    Data = <<XinfaId:32>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_UPGRADE_XF, Data)),
    ok.



%% 激活从属心法
activate_slave_xinfa(SlaveXinfaId) ->
    Socket = get(?PDKN_CONN_SOCKET),
    Data = <<SlaveXinfaId:32>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_ACTIVATE_SLAVE_XF, Data)),
    ok.







read(?PT_QUERY_XF_INFO, Bin, _Fd) ->
    io:format("client read: PT_QUERY_XF_INFO~n"),
    {EleList, <<>>} = pt:read_array(Bin, [u32, u8, u8, u32, u8, u32]),
    F = fun({XinfaId, XinfaLv, ParaType1, ParaValue1, ParaType2, ParaValue2}) ->
            io:format("    XinfaId=~p XinfaLv=~p, ParaType1=~p, ParaValue1=~p, ParaType2=~p, ParaValue2=~p~n", 
                        [XinfaId, XinfaLv, ParaType1, ParaValue1, ParaType2, ParaValue2])
        end,
    io:format("**********:~n"),
    lists:foreach(F, EleList),
    io:format("***********~n");


read(?PT_UPGRADE_XF, Bin, _Fd) ->
    <<RetCode:8, XinfaId:32>> = Bin,
    io:format("client read: PT_UPGRADE_XF, RetCode=~p XinfaId=~p~n", [RetCode, XinfaId]);
    

read(?PT_ACTIVATE_SLAVE_XF, Bin, _Fd) ->
    <<RetCode:8, SlaveXinfaId:32>> = Bin,
    io:format("client read: PT_ACTIVATE_SLAVE_XF, RetCode=~p SlaveXinfaId=~p~n", [RetCode, SlaveXinfaId]);


read(Cmd, Bin, _Fd) ->
    io:format("[glt_xinfa] default read handler!!!!! "),
    io:format("client read: Cmd => ~p, Bin: ~p~n", [Cmd, Bin]).


