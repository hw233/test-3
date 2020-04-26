%%%------------------------------------
%%% @author 段世和 
%%% @copyright UCweb 2015.07.09
%%% @doc 商会.
%%% @end
%%%------------------------------------

-module(pp_business).
-export([handle/3]).

-include("common.hrl").
-include("record.hrl").
-include("player.hrl").
-include("prompt_msg_code.hrl").
-include("log.hrl").
-include("ets_name.hrl").
-include("business.hrl").
-include("pt_63.hrl").
-include("equip_diamond_transfer.hrl").


%% 查询
handle(?PT_GET_BUSINESS_ALL_INFO, PS, [Type,SubType]) -> 
    % 获取服务器的信息
    ServerPersistence = mod_business:get_server_persistence_by_type(Type,SubType),
    % 检测刷新对应的商会信息
    mod_business:check_refresh_single(PS),    

    F = fun(X) ->
        No = X#business_server_persistence.no,
        % ?DEBUG_MSG("PT_GET_BUSINESS_ALL_INFO No=~p ,X=~p",[No,X]),
        lib_business:get_business_player_persistence(PS,No)
    end,

    PlayerPersistence = [F(X) || X <- ServerPersistence],

    % 封装后返回给客户端

    % ?DEBUG_MSG("PT_GET_BUSINESS_ALL_INFO ServerPersistence=~p ,PlayerPersistence=~p",[ServerPersistence,PlayerPersistence]),

    {ok, BinData} = pt_63:write(?PT_GET_BUSINESS_ALL_INFO, [Type,SubType,ServerPersistence, PlayerPersistence]),
    lib_send:send_to_sid(PS, BinData);
    % void;

%% 查询
handle(?PT_GET_BUSINESS_SINGLE_INFO, PS, [No_]) -> 
    % 获取服务器的信息
    ServerPersistence = mod_business:get_server_persistence_by_no(No_),
    % 检测刷新对应的商会信息
    mod_business:check_refresh_single(PS),    

    F = fun(X) ->
        No = X#business_server_persistence.no,
        lib_business:get_business_player_persistence(PS,No)
    end,

    PlayerPersistence = [F(X) || X <- ServerPersistence],

    % 封装后返回给客户端
    {ok, BinData} = pt_63:write(?PT_GET_BUSINESS_SINGLE_INFO, [ServerPersistence, PlayerPersistence]),
    lib_send:send_to_sid(PS, BinData);


%% 购买
handle(?PT_BUY_BUSINESS_GOODS, PS, [No, BuyCount]) ->
    case mod_business:business_buy_goods(PS, No, BuyCount) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        _ ->
			mod_achievement:notify_achi(business_buy, [{num, 1}], PS),
            {ok, BinData} = pt_63:write(?PT_BUY_BUSINESS_GOODS, [0]),
            lib_send:send_to_sid(PS, BinData)
    end;

%% 出售
handle(?PT_SELL_BUSINESS_GOODS, PS, [GoodsId, SellCount]) ->
    case mod_business:business_sell_goods(PS, GoodsId, SellCount) of
        {fail, Reason} ->
            ?DEBUG_MSG("PT_SELL_BUSINESS_GOODS Reason=~p",[Reason]),
            lib_send:send_prompt_msg(PS, Reason);
        _ ->
            ?DEBUG_MSG("PT_SELL_BUSINESS_GOODS Reason=~p",[ok]),
            {ok, BinData} = pt_63:write(?PT_SELL_BUSINESS_GOODS, [0]),
            lib_send:send_to_sid(PS, BinData)
    end;

%% 宝石转换
handle(?PT_DIAMOND_TRANSFER_INFO, PS, [CostId, Count, GetNo]) ->
	%先判断背包空间是否足够
    case  mod_inv:check_batch_add_goods(player:id(PS), [{GetNo, Count}]) of
		ok ->
			%检测是否有足够的水玉消耗
            TransferCost = data_equip_diamond_transfer:get(GetNo),
			TransferCost2 = TransferCost#equip_diamond_transfer_data_cfg.money, 
            case player:has_enough_bind_yuanbao(PS, TransferCost2 * Count) of
				true ->  
                    %检测要消耗的物品
                    case mod_inv:check_batch_destroy_goods_by_id(player:get_id(PS), [{CostId, Count}]) of
					     ok ->
							 Goods = mod_inv:get_goods_from_ets(CostId),
							 BindState = lib_goods:get_bind_state(Goods),
							 mod_inv:destroy_goods_WNC(player:get_id(PS), Goods, Count, ["business", "TransferCostItem"]),
							 player:cost_yuanbao(PS, TransferCost2 * Count, ["business","TransferCost"]),
							 mod_inv:batch_smart_add_new_goods(player:get_id(PS), [{GetNo, Count}],[{bind_state, BindState}], ["transfer", "get"]),
							 {ok, BinData} = pt_63:write(?PT_DIAMOND_TRANSFER_INFO, [1]),
							 lib_send:send_to_sid(PS, BinData);
						{fail, Reason2} ->
							lib_send:send_prompt_msg(PS, Reason2)
					end;
					
					
				false -> lib_send:send_prompt_msg(player:get_id(PS), ?PM_YB_LIMIT)
			end;
            
		{fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason)
	end;

handle(_Msg, _PS, _) ->
    ?WARNING_MSG("unknown handle ~p", [_Msg]),
    error.



