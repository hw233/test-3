%%%-----------------------------------
%%% @Module  : pt_52
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2014.02.17
%%% @Description: 52 商城模块
%%%-----------------------------------
-module(pt_52).
-export([read/2, write/2]).

-include("protocol/pt_52.hrl").
-include("debug.hrl").
-include("record/goods_record.hrl").
-include("trade.hrl").

%%
%%客户端 -> 服务端 ----------------------------
%%

read(?PT_BUY_GOODS_FROM_SHOP, <<GoodsNo:32, Count:32>>) ->
    {ok, [GoodsNo, Count]};


read(?PT_QUERY_DYNAMIC_GOODS_IN_SHOP, <<>>) ->
    {ok, null};


read(?PT_BUY_GOODS_FROM_OP_SHOP, <<GoodsNo:32, Count:16>>) ->
    {ok, [GoodsNo, Count]};


read(?PT_QUERY_GOODS_IN_OP_SHOP, <<>>) ->
    {ok, null};    

read(_Cmd, _R) ->
    ?ASSERT(false, {_Cmd, _R}),
    {error, no_match}.


write(?PT_BUY_GOODS_FROM_SHOP, [RetCode, GoodsNo, Count]) ->
    {ok, pt:pack(?PT_BUY_GOODS_FROM_SHOP, <<RetCode:8, GoodsNo:32, Count:32>>)};


write(?PT_BUY_GOODS_FROM_OP_SHOP, [RetCode, GoodsNo, Count]) ->
    {ok, pt:pack(?PT_BUY_GOODS_FROM_OP_SHOP, <<RetCode:8, GoodsNo:32, Count:16>>)};


write(?PT_QUERY_DYNAMIC_GOODS_IN_SHOP, [PlayerId, ShopGoodsInfoL]) ->
    List = lib_shop:pack_dynamic_goods_list(PlayerId, ?SHOP_TYPE_SHOP, ShopGoodsInfoL),
    Len = length(List),
    Bin = list_to_binary(List),
    BinData = <<Len:16, Bin/binary>>,
    {ok, pt:pack(?PT_QUERY_DYNAMIC_GOODS_IN_SHOP, BinData)};


write(?PT_QUERY_GOODS_IN_OP_SHOP, [PlayerId, ShopGoodsInfoL]) ->
    List = lib_shop:pack_dynamic_goods_list(PlayerId, ?SHOP_TYPE_OP_SHOP, ShopGoodsInfoL),
    Len = length(List),
    Bin = list_to_binary(List),
    BinData = <<Len:16, Bin/binary>>,
    {ok, pt:pack(?PT_QUERY_GOODS_IN_OP_SHOP, BinData)};


write(_Cmd, _R) ->
    ?ASSERT(false, {_Cmd, _R}),
    {ok, pt:pack(0, <<>>)}.