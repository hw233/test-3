%%%---------------------------------------------
%%% @Module  : glt_goods (game logic test: goods)
%%% @Author  : zhangwq
%%% @Email   : 
%%% @Created : 2013.8.6
%%% @Description: 物品系统测试
%%%---------------------------------------------
-module(glt_goods).


-include("test_client_base.hrl").
-include("pt_15.hrl").
-include("goods.hrl").
-include("debug.hrl").
-include("pt_32.hrl").

-compile(export_all).


%% 此处只能发协议到服务器添加物品，不能直接调用服务器相关代码，涉及到相关cookie问题
% add_goods(PlayerId, GoodsNo) ->
% 	io:format("client send: add_goods~n", []),
% 	mod_inv:add_new_goods_to_bag(PlayerId, GoodsNo).


get_bag_goods_list() ->
	Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: get_bag_goods_list~n", []),
    Location = ?LOC_BAG_USABLE,
    Data = <<Location:8>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_QRY_INVENTORY, Data)),
    ok.


% get_task_bag_goods_list() ->
%     Socket = get(?PDKN_CONN_SOCKET),
%     io:format("client send: get_task_bag_goods_list~n", []),
%     Location = ?LOC_TASK_BAG,
%     Data = <<Location:8>>,
%     gen_tcp:send(Socket, test_client_base:pack(?PT_QRY_INVENTORY, Data)),
%     ok.


get_storage_goods_list() ->
	Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: get_storage_goods_list~n", []),
    Location = ?LOC_STORAGE,
    Data = <<Location:8>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_QRY_INVENTORY, Data)),
    ok.	


get_player_eqp_goods_list() ->
    Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: get_player_eqp_goods_list~n", []),
    Location = ?LOC_PLAYER_EQP,
    Data = <<Location:8>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_QRY_INVENTORY, Data)),
    ok. 


%% 查看某物品的详细信息
get_goods_detail(GoodsId) ->
	Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: get_goods_detail~n", []),
    Data = <<GoodsId:64>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_GET_GOODS_DETAIL, Data)),
    ok.	


%% 扩充背包仓库容量
extend_bag_capacity(SlotNum) ->
	Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: extend_bag_capacity~n", []),
    Location = ?LOC_BAG_EQ,
    Data = <<Location:8, SlotNum:8>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_EXTEND_CAPACITY, Data)),
    ok.	


%% 扩充背包仓库容量
extend_storage_capacity(SlotNum) ->
	Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: extend_bag_capacity~n", []),
    Location = ?LOC_STORAGE,
    Data = <<Location:8, SlotNum:8>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_EXTEND_CAPACITY, Data)),
    ok.	


put_on_equip(Type, GoodsId) ->
	Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: put_on_equip~n", []),
    Data = <<Type:8, GoodsId:64>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_PUTON_EQUIP, Data)),
    ok.


take_off_equip(Type, EquipPos) ->
	Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: take_off_equip~n", []),
    Data = <<Type:8, EquipPos:8>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_TAKEOFF_EQUIP, Data)),
    ok.


use_goods(GoodsId) ->
	Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: use_goods~n", []),
    Data = <<GoodsId:64>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_USE_GOODS, Data)),
    ok.


discard_goods(Location, GoodsId) ->
	Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: discard_goods~n", []),
    Data = <<Location:8, GoodsId:64>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_DISCARD_GOODS, Data)),
    ok.

	
drag_goods(Location, GoodsId, ToSlot) ->
	Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: drag_goods~n", []),
    Data = <<Location:8, GoodsId:64, ToSlot:8>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_DRAG_GOODS, Data)),
    ok.


move_goods(GoodsId, FromLoc, ToLoc) ->
	Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: move_goods~n", []),
    Data = <<GoodsId:64, FromLoc:8, ToLoc:8>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_MOVE_GOODS, Data)),
    ok.


arrage_bag() ->
	Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: arrage_bag~n", []),
    Data = <<>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_ARRANGE_BAG, Data)),
    ok.


sell_goods(GoodsId, SellCount) ->
    Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: sell_goods~n", []),
    Data = <<GoodsId:64, SellCount:16>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_SELL_GOODS_FROM_BAG, Data)),
    ok.
    

get_buy_back_list() ->
    Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: get_buy_back_list~n", []),
    Data = <<>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_QRY_BUY_BACK_LIST, Data)),
    ok.

buy_back(GoodsId, StackCount) ->
    Socket = get(?PDKN_CONN_SOCKET),
    io:format("client send: buy_back~n", []),
    Data = <<GoodsId:64, StackCount:16>>,
    gen_tcp:send(Socket, test_client_base:pack(?PT_BUY_BACK, Data)),
    ok.
    

read(?PT_QRY_INVENTORY, <<Location:8, Capacity:16, Length:16, Bin/binary>>, _Fd) ->
    io:format("client read: Cmd => ~p,  Location: ~p,Capacity:~p ~n", [?PT_QRY_INVENTORY, Location, Capacity]),
    io:format("goods list begin:~n"),
    F = fun(Bin0) ->
        <<GoodsId:64, GoodsNo:32, Slot:8, Count:8, BindState:8, Quality:8, UsableTimes:16, RestBin/binary>> = Bin0,
        io:format("goods info: GoodsId=~p, GoodsNo=~p, Slot=~p, Count=~p, BindState=~p, Quality=~p,UsableTimes=~p~n",
            [GoodsId, GoodsNo, Slot, Count, BindState, Quality, UsableTimes]),
        RestBin
    end,
    test_client_base:for(0, Length, F, Bin),
    io:format("goods list end.~n");


read(?PT_GET_GOODS_DETAIL, Bin, _Fd) ->
    <<Location:8, GoodsId:64, GoodsNo:32, Slot:8, Count:8, BindState:8, Quality:8, UsableTimes:16, BattlePower:32, Bin1/binary>> = Bin,
    {AttrList, <<>>} = pt:read_array(Bin1, [u8, u8, u32]),
    io:format("Goods detail: GoodsId:~p,GoodsNo:~p,Location:~p,Slot:~p, Count:~p, BindState:~p, Quality~p,UsableTimes=~p,BattlePower=~p~n", [Location, GoodsId, GoodsNo, Slot, Count, BindState, Quality, UsableTimes, BattlePower]),
    io:format("Attr begin~n", []),
    F = fun(Attr) ->
        io:format("[InfoType, ObjInfoCode, Value]~p~n", [Attr])
    end,
    lists:foreach(F, AttrList),
    io:format("Attr end~n", []);


read(Cmd, Bin, _Fd) ->
    io:format("[glt_goods] default read handler!!!!! ", []),
    io:format("client read: Cmd => ~p, Bin: ~p~n", [Cmd, Bin]).