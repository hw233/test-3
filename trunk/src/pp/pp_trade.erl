%%%-----------------------------------
%%% @Module  : pp_trade
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2014.02.17
%%% @Description: 商城交易相关协议的处理
%%%-----------------------------------
-module(pp_trade).
-export([handle/3
        ]).
-include("common.hrl").
-include("record.hrl").
-include("ets_name.hrl").
-include("trade.hrl").
-include("protocol/pt_52.hrl").
-include("prompt_msg_code.hrl").


handle(?PT_BUY_GOODS_FROM_SHOP, PS, [GoodsNo, Count]) ->
    case mod_shop:buy_goods(PS, GoodsNo, Count) of
        ok ->
            {ok, BinData} = pt_52:write(?PT_BUY_GOODS_FROM_SHOP, [?RES_OK, GoodsNo, Count]),
            lib_send:send_to_sock(PS, BinData);
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason),
            RetCode = 
            case Reason of
                ?PM_GOODS_SELL_OVER -> 1;
                ?PM_BUY_COUNT_LIMIT -> 2;
                _Any -> 0
            end,
            {ok, BinData} = pt_52:write(?PT_BUY_GOODS_FROM_SHOP, [RetCode, GoodsNo, Count]),
            lib_send:send_to_sock(PS, BinData)
    end;


handle(?PT_QUERY_DYNAMIC_GOODS_IN_SHOP, PS, _) ->
    mod_shop:get_dynamic_goods_list(PS);


handle(?PT_QUERY_GOODS_IN_OP_SHOP, PS, _) ->
    ShopGoodsL = mod_shop:get_op_shop_goods_list(PS),
    {ok, BinData} = pt_52:write(?PT_QUERY_GOODS_IN_OP_SHOP, [player:get_id(PS), ShopGoodsL]),
    lib_send:send_to_sock(PS, BinData);


handle(?PT_BUY_GOODS_FROM_OP_SHOP, PS, [GoodsNo, Count]) ->
    case mod_shop:buy_op_shop_goods(PS, GoodsNo, Count) of
        ok ->
            {ok, BinData} = pt_52:write(?PT_BUY_GOODS_FROM_OP_SHOP, [?RES_OK, GoodsNo, Count]),
            lib_send:send_to_sock(PS, BinData);
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason),
            RetCode = 
                case Reason of
                    ?PM_GOODS_SELL_OVER -> 1;
                    ?PM_BUY_COUNT_LIMIT -> 2;
                    _Any -> 0
                end,
            {ok, BinData} = pt_52:write(?PT_BUY_GOODS_FROM_OP_SHOP, [RetCode, GoodsNo, Count]),
            lib_send:send_to_sock(PS, BinData)
    end;


handle(_Cmd, _PS, _Data) ->
    ?ASSERT(false, _Cmd),
    {error, bad_request}.
