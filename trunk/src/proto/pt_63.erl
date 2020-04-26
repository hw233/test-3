%%%-----------------------------------
%%% @Module  : pt_63
%%% @Author  : 段世和
%%% @Email   : 
%%% @Created : 2015.7
%%% @Description: 商会
%%%-----------------------------------
-module(pt_63).
-compile(export_all).
-include("common.hrl").
-include("pt_63.hrl").

-include("business.hrl").

%%
%%客户端 -> 服务端 ----------------------------
%%
read(?PT_GET_BUSINESS_ALL_INFO, <<Type:8, SubType:32>>) ->
    {ok, [Type,SubType]};

read(?PT_BUY_BUSINESS_GOODS, <<No:32, BuyCount:32>>) ->
    {ok, [No, BuyCount]};

read(?PT_SELL_BUSINESS_GOODS, <<GoodsId:64, SellCount:32>>) ->
    {ok, [GoodsId, SellCount]};

read(?PT_GET_BUSINESS_SINGLE_INFO, <<No:32>>) ->
    {ok, [No]};

read(?PT_DIAMOND_TRANSFER_INFO, <<CostId:64 , Count:32, GetNo:32>>) ->
    {ok, [CostId, Count, GetNo ]};




read(_Cmd, _Data) ->
    ?ASSERT(false, [_Cmd]),
    error.


%%
%%服务端 -> 客户端 ----------------------------
%%

write(?PT_GET_BUSINESS_ALL_INFO, [Type,SubType,ServerPersistence, PlayerPersistence]) ->

     F = fun(X) ->
            No = X#business_server_persistence.no,
            %Version = X#business_server_persistence.version,
            SellCount = X#business_server_persistence.sell_count,
            BuyCount = X#business_server_persistence.buy_count,
            TotalSellCount = X#business_server_persistence.total_sell_count,
            TotalBuyCount = X#business_server_persistence.total_buy_count,
            Stock = X#business_server_persistence.stock,
            
            <<
                No : 32 ,
                SellCount : 32 ,
                BuyCount : 32 ,
                TotalSellCount : 32 ,
                TotalBuyCount : 32 ,
                Stock : 32 
            >>
        end,

    ServerPersistenceList = [F(X) || X <- ServerPersistence],

    F1 = fun(X) ->
            No = X#business_player_persistence.no,
            % Version = X#business_server_persistence.version,
            SellCount = X#business_player_persistence.sell_count,
            BuyCount = X#business_player_persistence.buy_count,

            <<
                No : 32 ,
                SellCount : 32 ,
                BuyCount : 32 
            >>
        end,

    PlayerPersistenceList = [F1(X) || X <- PlayerPersistence],

    %?DEBUG_MSG("ServerPersistenceList=~p,PlayerPersistenceList=~p",[ServerPersistenceList,PlayerPersistenceList]),

    BServerPersistenceList = list_to_binary(ServerPersistenceList),
    BPlayerPersistenceList = list_to_binary(PlayerPersistenceList),

    %?DEBUG_MSG("BServerPersistenceList=~p,BPlayerPersistenceList=~p",[BServerPersistenceList,BPlayerPersistenceList]),

    BinData = <<
        Type : 8,
        SubType : 32,
        (length(ServerPersistenceList)) : 16,
        BServerPersistenceList /binary,
        (length(PlayerPersistenceList)) : 16,
        BPlayerPersistenceList /binary
    >>,

    % ?DEBUG_MSG("BinData=~p",[BinData]),

    {ok, pt:pack(?PT_GET_BUSINESS_ALL_INFO, BinData)};

write(?PT_BUY_BUSINESS_GOODS, [Code]) ->
    {ok, pt:pack(?PT_BUY_BUSINESS_GOODS, <<Code:8>>)};

write(?PT_SELL_BUSINESS_GOODS, [Code]) ->
    {ok, pt:pack(?PT_SELL_BUSINESS_GOODS, <<Code:8>>)};

write(?PT_DIAMOND_TRANSFER_INFO, [Code]) ->
    {ok, pt:pack(?PT_DIAMOND_TRANSFER_INFO, <<Code:8>>)};

write(?PT_GET_BUSINESS_SINGLE_INFO, [ServerPersistence, PlayerPersistence]) ->

     F = fun(X) ->
            No = X#business_server_persistence.no,
            %Version = X#business_server_persistence.version,
            SellCount = X#business_server_persistence.sell_count,
            BuyCount = X#business_server_persistence.buy_count,
            TotalSellCount = X#business_server_persistence.total_sell_count,
            TotalBuyCount = X#business_server_persistence.total_buy_count,
            Stock = X#business_server_persistence.stock,
            
            <<
                No : 32 ,
                SellCount : 32 ,
                BuyCount : 32 ,
                TotalSellCount : 32 ,
                TotalBuyCount : 32 ,
                Stock : 32 
            >>
        end,

    ServerPersistenceList = [F(X) || X <- ServerPersistence],

    F1 = fun(X) ->
            No = X#business_player_persistence.no,
            % Version = X#business_server_persistence.version,
            SellCount = X#business_player_persistence.sell_count,
            BuyCount = X#business_player_persistence.buy_count,

            <<
                No : 32 ,
                SellCount : 32 ,
                BuyCount : 32 
            >>
        end,

    PlayerPersistenceList = [F1(X) || X <- PlayerPersistence],

    %?DEBUG_MSG("ServerPersistenceList=~p,PlayerPersistenceList=~p",[ServerPersistenceList,PlayerPersistenceList]),

    BServerPersistenceList = list_to_binary(ServerPersistenceList),
    BPlayerPersistenceList = list_to_binary(PlayerPersistenceList),

    %?DEBUG_MSG("BServerPersistenceList=~p,BPlayerPersistenceList=~p",[BServerPersistenceList,BPlayerPersistenceList]),

    BinData = <<
        (length(ServerPersistenceList)) : 16,
        BServerPersistenceList /binary,
        (length(PlayerPersistenceList)) : 16,
        BPlayerPersistenceList /binary
    >>,

    % ?DEBUG_MSG("BinData=~p",[BinData]),

    {ok, pt:pack(?PT_GET_BUSINESS_SINGLE_INFO, BinData)};



write(_Cmd, _) ->
    ?ASSERT(false, [_Cmd]),
    error.