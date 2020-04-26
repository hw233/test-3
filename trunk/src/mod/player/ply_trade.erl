%%%--------------------------------------
%%% @Module  : ply_trade
%%% @Author  : zhangwqw
%%% @Email   : 
%%% @Created : 2013.11.6
%%% @Description: 玩家物品交易：包括从npc购买物品，从系统回购已卖出的物品
%%%--------------------------------------

-module(ply_trade).

-export([
        on_player_login/1,              % 玩家登陆 把没有过期的回购物品添加到作业计划
        on_player_tmp_logout/1,         % 玩家登陆 把没有过期的回购物品从作业计划删除
        get_goods_list_by_npc/2,        % 在npc获取可以交易的物品列表
        get_goods_list_by_npc_shop_no/1,
        get_buy_back_list/1,            % 获取回购列表
        get_goods_from_buy_back_list/2, % 从回购列表获取物品
        buy_back/3,                     % 回购
        handle_buy_back_goods_expired/2,% 处理回购物品过期
        sell_goods_from_bag/3,          % 从背包卖出物品
        sell_all_goods_from_temp_bag/1,
        get_buy_info/2,                 % 玩家购买信息：如某些物品的购买数量等
        get_player_buy_goods_count/3,   % 获取某个玩家已经在npc商店购买的物品个数
        exchange_goods/3,               % 从npc兑换物品
        buy_goods_from_npc/5,            % 从npc购买物品
        exchange_special_goods/4,
        new_exchange_goods/3,
    credit_buy/3,
    goods_eff_select/3
        ]).


-include("common.hrl").
-include("abbreviate.hrl").
-include("npc.hrl").
-include("prompt_msg_code.hrl").
-include("ets_name.hrl").
-include("goods.hrl").
-include("record/goods_record.hrl").
-include("trade.hrl").
-include("pt_32.hrl").
-include("job_schedule.hrl").
-include("log.hrl").
-include("record.hrl").
-include("inventory.hrl").
-include("exchange.hrl").
-include("effect.hrl").
-include("pt_15.hrl").

credit_buy(PS, Id, Count) ->
    ExchangeData = data_credit_shop:get(Id),
    %先检测背包
    GoodsLists = [{ExchangeData#credit_shop.goods_no, Count}],
    PlayerId = player:id(PS),
    case mod_inv:check_batch_add_goods(PlayerId, GoodsLists) of
        {fail, _Reason} ->
            lib_send:send_prompt_msg(PlayerId, ?PM_US_BAG_FULL);
        ok ->
            [{MoneyType, CostNum}] = ExchangeData#credit_shop.price,
            case player:has_enough_money(PS, MoneyType, Count*CostNum) of
                true ->
                    player:cost_money(PS, MoneyType, Count*CostNum, ["ply_trade", "credit_buy"]),
                    mod_inv:batch_smart_add_new_goods(PlayerId, GoodsLists),
                    {ok, BinData} = pt_32:write(?PT_BUY_GOODS_FROM_CREDIT_NPC, [?RES_OK, Id]),
                    lib_send:send_to_sock(PS, BinData);
                false ->
                    lib_send:send_prompt_msg(PlayerId, ?PM_MONEY_LIMIT)
            end

    end.

goods_eff_select(PS, GoodsId, EffNo) ->
    case mod_inv:check_batch_destroy_goods_by_id(player:id(PS), [{GoodsId, 1}]) of
        ok ->
            case data_goods_eff:get(EffNo) of
                #goods_eff{para = AddGoodsNo} ->
                    GoodsNo = mod_inv:get_goods_no_by_goods_id(player:id(PS),GoodsId),
                    mod_inv:destroy_goods_by_id_WNC(player:id(PS), [{GoodsId, 1}]),
                    lib_reward:give_reward_to_player(PS, AddGoodsNo, ["lib_mystery","flop_reward_goods"]),
                    {ok, BinData} = pt_15:write(?PT_GOODS_EFF_SELECT, [?RES_OK, GoodsId, GoodsNo]),
                    lib_send:send_to_sock(PS, BinData);
                _ ->
                    io:format("Born === ~p,GoodsId === ~p~n",[EffNo,GoodsId]),
                    ?ASSERT(false, EffNo)
            end;
        {fail, Reason} ->
            lib_send:send_prompt_msg(player:id(PS), Reason)
    end.

on_player_login(PlayerId) ->
    case get_buy_back(PlayerId) of
        null -> skip;
        BuyBack ->
            F = fun(Goods, Acc) ->
                TimeNow = svr_clock:get_unixtime(),
                TimeElapsed = TimeNow - lib_goods:get_sell_time(Goods),
                case TimeElapsed >= ?BUY_BACK_TIME_LIMIT of
                    true -> 
                        handle_gem_for_equip(PlayerId, Goods),
                        Acc;
                    false ->
                        DelayTime = ?BUY_BACK_TIME_LIMIT - TimeElapsed,
                        mod_ply_jobsch:add_schedule(?JSET_BUY_BACK_GOODS_EXPIRE, DelayTime, [PlayerId, lib_goods:get_id(Goods)]),
                        [Goods | Acc]
                end
            end,
            NewGoodList = lists:foldl(F, [], BuyBack#buy_back.goods),
            BuyBack1 = BuyBack#buy_back{goods = NewGoodList},
            update_buy_back(BuyBack1)
    end.


on_player_tmp_logout(PlayerId) ->
    ?ASSERT(is_integer(PlayerId)),
    mod_ply_jobsch:remove_one_sch(PlayerId, ?JSET_BUY_BACK_GOODS_EXPIRE).


%% return npc_shop 结构体列表 目前只返回动态物品列表，静态的客户端自己读表
get_goods_list_by_npc(NpcId, ShopNo) ->
    case mod_npc:get_obj(NpcId) of
        null -> 
            ?ASSERT(false, {NpcId, ShopNo}),
            [];
        Npc ->
            _ShopNoList = mod_npc:get_npc_shop_no_list(Npc),
            ?ASSERT(lists:member(ShopNo, _ShopNoList), {ShopNo, _ShopNoList}),
            ?ASSERT(Npc /= null),
            case data_npc_shop:get(ShopNo) of
                null ->
                    ?ASSERT(false),
                    [];
                NpcShopGoodsInfoL ->
                    [X || X <- NpcShopGoodsInfoL, X#shop_goods.goods_type =/= 0]
            end
    end.
    

%% return npc_shop 结构体列表
get_goods_list_by_npc_shop_no(No) ->
    case data_npc_shop:get(No) of
        null ->
            ?ASSERT(false),
            [];
        NpcShopGoodsInfoL ->
            NpcShopGoodsInfoL
    end.

buy_goods_from_npc(PS, NpcId, GoodsNo, Count, ShopNo) ->
    case check_buy_goods_from_npc(PS, NpcId, GoodsNo, Count, ShopNo) of
        {fail, Reason} ->
            {fail, Reason};
        ok ->
            do_buy_goods_from_npc(PS, NpcId, GoodsNo, Count, ShopNo)
    end.


exchange_goods(PS, NpcId, No) ->
    case check_exchange_goods(PS, NpcId, No) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, NeedGoodsList, GetGoodsList,BGoodsList} ->
            do_exchange_goods(PS, NpcId, No, NeedGoodsList, GetGoodsList,BGoodsList)
    end.

%%兑换商店 2019.7.31wjc
new_exchange_goods(PlayerId, GoodIndex, Num ) ->
    ExchangeData = data_exchange:get(GoodIndex),
    %先检测背包
    GoodsLists = [{ExchangeData#exchange.goods_id, Num}],
    case mod_inv:check_batch_add_goods(PlayerId, GoodsLists) of
        {fail, _Reason} ->
            lib_send:send_prompt_msg(PlayerId, ?PM_US_BAG_FULL);
        ok ->
            case ExchangeData#exchange.price_type of %%1消耗货币类型,2消耗物品
                1 ->
                    %%检测是否有足够的货币类型 货币只会消耗一种类型（目前）
                    [{MoneyType, MoneyNum}] = ExchangeData#exchange.num,
                    case player:has_enough_money(player:get_PS(PlayerId), MoneyType, MoneyNum*Num) of
                        true ->
                            %%先消耗货币再添加物品
                            %% 货币消耗
                            player_syn:cost_money(player:get_PS(PlayerId), MoneyType, MoneyNum * Num, ["ply_trade", "new_exchange_goods"]),
                            mod_inv:batch_smart_add_new_goods(PlayerId, GoodsLists),
                            {ok, BinData} = pt_32:write(?PT_EXCHANGE_GOODS_FROM_SHOP, [GoodIndex]),
                            lib_send:send_to_sock(player:get_PS(PlayerId), BinData);
                        false ->
                            lib_send:send_prompt_msg(PlayerId, ?PM_MONEY_LIMIT)
                    end;
                2 ->
                    NeedCostGoods = ExchangeData#exchange.expend,
                    NeedCostGoods2 = lists:foldr(fun({CostGoods,CostNum},CostAcc) ->
                        [{CostGoods,CostNum * Num} | CostAcc]
                            end, [] , NeedCostGoods),
                    case mod_inv:check_batch_destroy_goods(PlayerId, NeedCostGoods2)  of
                        ok ->
                            mod_inv:destroy_goods_WNC(PlayerId, NeedCostGoods2, ["ply_trade", "new_exchange_goods"]),
                            mod_inv:batch_smart_add_new_goods(PlayerId, GoodsLists),
                            {ok, BinData} = pt_32:write(?PT_EXCHANGE_GOODS_FROM_SHOP, [GoodIndex]),
                            lib_send:send_to_sock(player:get_PS(PlayerId), BinData);
                        {fail, Reason} ->
                            lib_send:send_prompt_msg(PlayerId, Reason)
                    end
            end
    end.


exchange_special_goods(PS, NpcId, No,Num) ->
    case check_exchange_special_goods(PS, NpcId, No,Num) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, NeedGoodsList, GetGoodsList,BGoodsList} ->
            do_exchange_goods(PS, NpcId, No, NeedGoodsList, GetGoodsList,BGoodsList)
    end.

% return goods 结构体列表
get_buy_back_list(PS) ->
    case get_buy_back(player:get_id(PS)) of
        null -> [];
        BuyBack -> BuyBack#buy_back.goods
    end.


get_goods_from_buy_back_list(PS, GoodsId) ->
    case get_buy_back_list(PS) of
        null -> null;
        GoodsList ->
            case lists:keyfind(GoodsId, #goods.id, GoodsList) of
                false -> null;
                Goods -> Goods
            end
    end.


% return ok | {fail, Reason}
% para GoodsId 是此物品在回购列表的唯一id与物品系统的id不一样
buy_back(PS, GoodsId, StackCount) ->
    case check_buy_back(PS, GoodsId, StackCount) of
        {fail, Reason} ->
            {fail, Reason};
        ok ->
            do_buy_back(PS, GoodsId, StackCount),
            ok
    end.


sell_goods_from_bag(PS, GoodsId, SellCount) ->
    case check_sell_goods_from_bag(PS, GoodsId, SellCount) of
        {fail, Reason} ->
            {fail, Reason};
        ok ->
            do_sell_goods_from_bag(PS, GoodsId, SellCount),
            ok
    end.


sell_all_goods_from_temp_bag(PS) ->
    case check_sell_all_goods_from_temp_bag(PS) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, GoodsList} ->
            do_sell_all_goods_from_temp_bag(PS, GoodsList)
    end.

handle_buy_back_goods_expired(PlayerId, GoodsId) ->
    BuyBack = get_buy_back(PlayerId),
    ?ASSERT(BuyBack /= null),
    case lists:keyfind(GoodsId, #goods.id, BuyBack#buy_back.goods) of
        false -> 
            ?ASSERT(false),
            skip;
        Goods ->
            %% 这里需要考虑装备上的宝石 规则：装备在 宝石在 装备消失 宝石消失
            handle_gem_for_equip(PlayerId, Goods),
            
            NewGoodList = BuyBack#buy_back.goods -- [Goods],
            BuyBack1 = BuyBack#buy_back{goods = NewGoodList},
            update_buy_back(BuyBack1),
            notify_cli_goods_destroy_in_back_list(PlayerId, GoodsId)
    end.


%% ---------------------------------------------Local------------------------------------------------------

check_sell_all_goods_from_temp_bag(PS) ->
    Inv = mod_inv:get_inventory(player:id(PS)),
    Len = length(Inv#inv.temp_bag_goods),
    case Len =:= 0 of
        true -> {fail, ?PM_GOODS_NOT_EXISTS};
        false ->
            F = fun(GoodsId, Acc) ->
                case mod_inv:get_goods_from_ets(GoodsId) of
                    null -> [null | Acc];
                    Goods -> 
                        case lib_goods:is_can_sell(Goods) of
                            false -> Acc;
                            true -> [Goods | Acc]
                        end
                end
            end,

            GoodsList = lists:foldl(F, [], Inv#inv.temp_bag_goods),
            {ok, GoodsList}
    end.

do_sell_all_goods_from_temp_bag(PS, GoodsList) ->
    mod_inv:destroy_goods_from_temp_bag(player:get_id(PS), GoodsList),
    F = fun(Goods) ->
        case lib_goods:is_equip(Goods) of
            true ->
                player:add_money(PS, lib_goods:get_sell_price_type(Goods), util:ceil(lib_goods:get_sell_price(Goods) * math:pow(3, lib_goods:get_quality(Goods) - 1) * lib_goods:get_count(Goods)), [?LOG_NPC_SHOP, "sell"]);
            false ->
                player:add_money(PS, lib_goods:get_sell_price_type(Goods), util:ceil(lib_goods:get_sell_price(Goods) * lib_goods:get_count(Goods)), [?LOG_NPC_SHOP, "sell"])
        end,
        ply_tips:send_sys_tips(PS, {sell_goods, [lib_goods:get_no(Goods), lib_goods:get_quality(Goods), lib_goods:get_count(Goods),0]})
    end,
    [F(X) || X <- GoodsList],
    ok.


 check_exchange_goods(PS, NpcId, No) ->
    try check_exchange_goods__(PS, NpcId, No) of
        {ok, NeedGoodsList, GetGoodsList,BGoodsList} -> 
            {ok, NeedGoodsList, GetGoodsList,BGoodsList}
    catch 
        throw: FailReason ->
            {fail, FailReason}
    end.

check_exchange_special_goods(PS, NpcId, No,Num) ->
    try check_exchange_special_goods__(PS, NpcId, No ,Num) of
        {ok, NeedGoodsList, GetGoodsList,B} -> 
            {ok, NeedGoodsList, GetGoodsList,B}
    catch 
        throw: FailReason ->
            {fail, FailReason}
    end.



check_exchange_goods__(PS, NpcId, No) ->
    Npc = mod_npc:get_obj(NpcId),
    ?Ifc (Npc =:= null)
        throw(?PM_NPC_NOT_EXISTS)
    ?End,

    Data = data_goods_exchange:get(No),
    ?Ifc (Data =:= null)
        throw(?PM_PARA_ERROR)
    ?End,

    ?Ifc (not lists:member(No, mod_npc:get_npc_exchange_no_list(Npc)))
        throw(?PM_PARA_ERROR)
    ?End,

    NeedGoodsList = Data#goods_exchange.need_goods_list,
    ?Ifc (not is_list(NeedGoodsList))
        throw(?PM_DATA_CONFIG_ERROR)
    ?End,

    GetGoodsList = [{Data#goods_exchange.goods_no, 1}],

    F = fun({NeedNo, Cnt}, {Acc, AccB}) ->
        FisrtCount = mod_inv:get_goods_count_in_bag(player:id(PS), NeedNo, ?BIND_NEVER),
        case FisrtCount >= Cnt of
            true -> {[{NeedNo, Cnt, ?BIND_NEVER} | Acc], AccB};
            false -> {[{NeedNo, FisrtCount, ?BIND_NEVER} | Acc], [{NeedNo, max(Cnt - FisrtCount, 0), ?BIND_ALREADY} | AccB]}
        end
    end,

    {NeedGoodsList1, BGoodsList} = lists:foldl(F, {[], []}, NeedGoodsList),

    case mod_inv:check_batch_destroy_goods(PS, NeedGoodsList) of
        {fail, Reason} ->
            throw(Reason);
        ok ->
            case mod_inv:check_batch_add_goods(player:id(PS), GetGoodsList) of
                {fail, Reason} ->
                    throw(Reason);
                ok ->
                    {ok, NeedGoodsList1, GetGoodsList,BGoodsList}
            end
    end.


check_exchange_special_goods__(PS, NpcId, No2, Num) ->
    Npc = mod_npc:get_obj(NpcId),
    ?Ifc (Npc =:= null)
        throw(?PM_NPC_NOT_EXISTS)
    ?End,

   
     No=  list_to_atom(integer_to_list(No2)),

    Data = data_special_config:get(No),
    ?Ifc (Data =:= null)
        throw(?PM_PARA_ERROR)
    ?End,

    {GetGoodsNo, NeedGoodsNo, NeedGoodsNum2} = Data ,
    
    NeedGoodsNum = NeedGoodsNum2 * Num,


    NeedGoodsList = [{NeedGoodsNo, NeedGoodsNum}],
    ?Ifc (not is_list(NeedGoodsList))
        throw(?PM_DATA_CONFIG_ERROR)
    ?End,

    GetGoodsList = [{GetGoodsNo, Num}],

    F = fun({NeedNo, Cnt}, {Acc, AccB}) ->
        FisrtCount = mod_inv:get_goods_count_in_bag(player:id(PS), NeedNo, ?BIND_NEVER),
        case FisrtCount >= Cnt of
            true -> {[{NeedNo, Cnt, ?BIND_NEVER} | Acc], AccB};
            false -> {[{NeedNo, FisrtCount, ?BIND_NEVER} | Acc], [{NeedNo, max(Cnt - FisrtCount, 0), ?BIND_ALREADY} | AccB]}
        end
    end,

    % {[{62349,0,2}],[{62349,30,1}]}    
    {NeedGoodsList1, BList2} = lists:foldl(F, {[], []}, NeedGoodsList),

    case mod_inv:check_batch_destroy_goods(PS, NeedGoodsList) of
        {fail, Reason} ->
            throw(Reason);
        ok ->
            case mod_inv:check_batch_add_goods(player:id(PS), GetGoodsList) of
                {fail, Reason} ->
                    throw(Reason);
                ok ->
                    {ok, NeedGoodsList1, GetGoodsList,BList2}
            end
    end.


do_exchange_goods(PS, _NpcId, _No, NeedGoodsList, GetGoodsList,BGoodsList) ->
    F1 = fun(Para) ->
        {GNo, GCnt} = case Para of
            {GNo_, GCnt_} -> {GNo_, GCnt_};
            {GNo_, GCnt_,_} -> {GNo_, GCnt_}
        end,
		case GCnt > 0 of
			true -> ply_tips:send_sys_tips(PS, {cost_goods, [GNo, 0, GCnt,0]});
			false -> skip
		end
		 
    end,
    [F1(X) || X <- NeedGoodsList],
    [F1(X) || X <- BGoodsList],

    % 使用绑定道具合成后获得市绑定道具
    case NeedGoodsList =:= [] of
        true -> skip;
        false -> mod_inv:destroy_goods_WNC(PS, NeedGoodsList, [?LOG_GOODS, "exchange"])
    end,

    case BGoodsList =:= [] of
        true -> skip;
        false -> mod_inv:destroy_goods_WNC(PS, BGoodsList, [?LOG_GOODS, "exchange"])
    end,

    BindState = 
        case BGoodsList =:= [] of
            true -> ?BIND_NEVER;
            false -> ?BIND_ALREADY
        end,

    Ret = mod_inv:batch_smart_add_new_goods(player:id(PS), GetGoodsList, [{bind_state, BindState}], [?LOG_GOODS, "exchange"]),
    case Ret of
        {ok, RetGoods} ->
            F = fun({GoodsId, No, GoodsCount}) ->
                ply_tips:send_sys_tips(PS, {get_goods, [No, 0, GoodsCount,GoodsId]})
            end,

            [F(X) || X <- RetGoods];            
        _ -> skip
    end,    
    ok.

check_buy_goods_from_npc(PS, NpcId, GoodsNo, Count, ShopNo) ->
    try check_buy_goods_from_npc__(PS, NpcId, GoodsNo, Count, ShopNo) of
        ok -> 
            ok
    catch 
        throw: FailReason ->
            {fail, FailReason}
    end.


check_buy_goods_from_npc__(PS, NpcId, GoodsNo, Count, ShopNo) ->
    Npc = mod_npc:get_obj(NpcId),
    ?Ifc (Npc =:= null)
        throw(?PM_NPC_NOT_EXISTS)
    ?End,
    ?Ifc (lib_goods:get_tpl_data(GoodsNo) =:= null)
        throw(?PM_GOODS_NOT_EXISTS)
    ?End,
    ?Ifc (Count =< 0)
        throw(?PM_PARA_ERROR)
    ?End,
    ?Ifc (not player:is_online(player:get_id(PS)))
        throw(?PM_UNKNOWN_ERR)
    ?End,

    ?Ifc (not lists:member(ShopNo, mod_npc:get_npc_shop_no_list(Npc)))
        throw(?PM_DATA_CONFIG_ERROR)
    ?End,

    NpcShopGoodsInfoL = data_npc_shop:get(ShopNo),
    
    NpcShop = lists:keyfind(GoodsNo, #shop_goods.goods_no, NpcShopGoodsInfoL),
    ?Ifc (NpcShop =:= false)
        throw(?PM_DATA_CONFIG_ERROR)
    ?End,

    ?Ifc (not lib_goods:is_valid_bind_state(NpcShop#shop_goods.bind_state))
        throw(?PM_DATA_CONFIG_ERROR)
    ?End,

    ?Ifc ( not lists:member(NpcShop#shop_goods.price_type, [?MNY_T_CHIP,?MNY_T_CHIVALROUS,?MNY_T_GAMEMONEY, ?MNY_T_QUJING, ?MNY_T_MYSTERY, ?MNY_T_MIRAGE,?MNY_T_BIND_GAMEMONEY, ?MNY_T_YUANBAO, ?MNY_T_BIND_YUANBAO, ?MNY_T_FEAT, ?MNY_T_LITERARY,
        ?MNY_T_GUILD_CONTRI, ?MNY_T_COPPER,?MNY_T_EXP]) )
        throw(?PM_DATA_CONFIG_ERROR)
    ?End,

    ?Ifc (NpcShop#shop_goods.price_type =:= ?MNY_T_CHIVALROUS andalso (not player:has_enough_chivalrous(PS, NpcShop#shop_goods.price * Count)))
        throw(?PM_CHIVALROUS_LIMIT)
    ?End,

    ?Ifc (NpcShop#shop_goods.price_type =:= ?MNY_T_QUJING andalso (not player:has_enough_jingwen(PS, NpcShop#shop_goods.price * Count)))
        throw(?PM_JINGWEN_LIMIT)
    ?End,

    ?Ifc (NpcShop#shop_goods.price_type =:= ?MNY_T_MYSTERY andalso (not player:has_enough_mijing(PS, NpcShop#shop_goods.price * Count)))
        throw(?PM_MIJING_LIMIT)
    ?End,

    ?Ifc (NpcShop#shop_goods.price_type =:= ?MNY_T_MIRAGE andalso (not player:has_enough_huanjing(PS, NpcShop#shop_goods.price * Count)))
        throw(?PM_HUANJING_LIMIT)
    ?End,

    ?Ifc (NpcShop#shop_goods.price_type =:= ?MNY_T_CHIP andalso (player:get_chip(PS) < NpcShop#shop_goods.discount_price * Count))
        throw(?PM_CHIP_LIMIT)
    ?End,   

    ?Ifc (NpcShop#shop_goods.price_type =:= ?MNY_T_GAMEMONEY andalso (not player:has_enough_gamemoney(PS,  NpcShop#shop_goods.price * Count)))
        throw(?PM_GAMEMONEY_LIMIT)
    ?End,
    ?Ifc (NpcShop#shop_goods.price_type =:= ?MNY_T_BIND_GAMEMONEY andalso (not player:has_enough_bind_gamemoney(PS, NpcShop#shop_goods.price * Count)))
        throw(?PM_BIND_GAMEMONEY_LIMIT)
    ?End,
    ?Ifc (NpcShop#shop_goods.price_type =:= ?MNY_T_YUANBAO andalso (not player:has_enough_yuanbao(PS, NpcShop#shop_goods.price * Count)))
        throw(?PM_YB_LIMIT)
    ?End,
    ?Ifc (NpcShop#shop_goods.price_type =:= ?MNY_T_BIND_YUANBAO andalso (not player:has_enough_bind_yuanbao(PS, NpcShop#shop_goods.price * Count)))
        throw(?PM_BIND_YB_LIMIT)
    ?End,

	?Ifc (NpcShop#shop_goods.price_type =:= ?MNY_T_INTEGRAL andalso player:get_integral(PS) < NpcShop#shop_goods.price * Count)
        throw(?PM_INTEGRAL_LIMIT)
    ?End,

    ?Ifc (NpcShop#shop_goods.price_type =:= ?MNY_T_FEAT andalso player:get_feat(PS) < NpcShop#shop_goods.price * Count)
        throw(?PM_FEAT_LIMIT)
    ?End,
	
    ?Ifc (NpcShop#shop_goods.price_type =:= ?MNY_T_LITERARY andalso player:get_literary(PS) < NpcShop#shop_goods.price * Count)
        throw(?PM_LITERARY_LIMIT)
    ?End,

    ?Ifc (NpcShop#shop_goods.price_type =:= ?MNY_T_EXP andalso player:get_exp(PS) < NpcShop#shop_goods.price * Count)
        throw(?PM_EXP_LIMIT)
    ?End,

    ?Ifc (NpcShop#shop_goods.price_type =:= ?MNY_T_GUILD_CONTRI andalso player:get_guild_contri(PS) < NpcShop#shop_goods.price * Count)
        ?DEBUG_MSG("player:get_guild_contri(PS) = ~p,[~p]",[player:get_guild_contri(PS),NpcShop#shop_goods.price * Count]),
        throw(?PM_GUILD_CONTRI_LIMIT)
    ?End,

    %% 消耗物品
    case NpcShop#shop_goods.price_type =:= 9 of
        false -> skip;
        true ->
            ?Ifc (NpcShop#shop_goods.consumer_goods_list =:= [])
                throw(?PM_PARA_ERROR)
            ?End,
            ?Ifc (not is_tuple(erlang:hd(NpcShop#shop_goods.consumer_goods_list)))
                throw(?PM_PARA_ERROR)
            ?End,
            ConsumerGoodsList = lists:foldl(fun({No, Cnt}, Acc) -> [{No, Cnt * Count} | Acc] end, [], NpcShop#shop_goods.consumer_goods_list),
            case mod_inv:check_batch_destroy_goods(player:id(PS), ConsumerGoodsList) of
                ok -> skip;
                {fail, GoodsNotEnough} -> throw(GoodsNotEnough)
            end
    end,

    ?Ifc (player:get_lv(PS) < NpcShop#shop_goods.lv_need)
        throw(?PM_LV_LIMIT)
    ?End,
    ?Ifc (NpcShop#shop_goods.race_need /= 0 andalso player:get_race(PS) < NpcShop#shop_goods.race_need)
        throw(?PM_RACE_LIMIT)
    ?End,
    
    ?Ifc (NpcShop#shop_goods.faction_need /= 0 andalso player:get_faction(PS) < NpcShop#shop_goods.faction_need)
        throw(?PM_FACTION_LIMIT)
    ?End,
    
    ?Ifc (NpcShop#shop_goods.count_limit_type /= 0 andalso Count  + get_player_buy_goods_count(player:id(PS), NpcShop, ?SHOP_TYPE_NPC) > NpcShop#shop_goods.buy_count_limit_time)
        throw(?PM_BUY_COUNT_LIMIT)
    ?End,
    DyShopGoods = lib_shop:get_dynamic_shop_goods(GoodsNo),
    ?Ifc (NpcShop#shop_goods.goods_type =:= 2 andalso DyShopGoods#shop_goods.left_num < Count)
        throw(?PM_GOODS_SELL_OVER)
    ?End,

    case mod_inv:check_batch_add_goods(player:get_id(PS), [{GoodsNo, Count}]) of
        {fail, Reason} -> throw(Reason);
        ok -> ok
    end.


do_buy_goods_from_npc(PS, _NpcId, GoodsNo, Count, ShopNo) ->
    NpcShopGoodsInfoL = data_npc_shop:get(ShopNo),
    NpcShop = lists:keyfind(GoodsNo, #shop_goods.goods_no, NpcShopGoodsInfoL),
    % ?DEBUG_MSG("ply_trade:do_buy_goods_from_npc:GoodsNo:~p, NpcShop~w", [GoodsNo, NpcShop]),
    CostRet = 
        case NpcShop#shop_goods.price_type of
            ?MNY_T_GAMEMONEY -> % 游戏币
                player:cost_gamemoney(PS, NpcShop#shop_goods.price * Count, [?LOG_NPC_SHOP, "buy"]),
                true;
            ?MNY_T_YUANBAO ->
                player:cost_yuanbao(PS, NpcShop#shop_goods.price * Count, [?LOG_NPC_SHOP, "buy"]),
                true;
            ?MNY_T_BIND_GAMEMONEY ->
                player:cost_bind_gamemoney(PS, NpcShop#shop_goods.price * Count, [?LOG_NPC_SHOP, "buy"]),
                true;
            ?MNY_T_BIND_YUANBAO ->
                player:cost_bind_yuanbao(PS, NpcShop#shop_goods.price * Count, [?LOG_NPC_SHOP, "buy"]),
                true;
            ?MNY_T_INTEGRAL ->
                player:cost_integral(PS, NpcShop#shop_goods.price * Count, [?LOG_NPC_SHOP, "buy"]),
                true;
            ?MNY_T_FEAT ->
                player:cost_feat(PS, NpcShop#shop_goods.price * Count, [?LOG_NPC_SHOP, "buy"]),
                true;
            ?MNY_T_CHIVALROUS ->
                player:cost_chivalrous(PS, NpcShop#shop_goods.price * Count, [?LOG_NPC_SHOP, "buy"]),
                true;
			?MNY_T_QUJING ->
				player:cost_jingwen(PS, NpcShop#shop_goods.price * Count, [?LOG_NPC_SHOP, "buy"]),
                true;
            ?MNY_T_MYSTERY ->
                player:cost_mijing(PS, NpcShop#shop_goods.price * Count, [?LOG_NPC_SHOP, "buy"]),
                true;
            ?MNY_T_MIRAGE ->
                player:cost_huanjing(PS, NpcShop#shop_goods.price * Count, [?LOG_NPC_SHOP, "buy"]),
                true;

            ?MNY_T_CHIP ->
                player:cost_chip(PS, NpcShop#shop_goods.price * Count, [?LOG_NPC_SHOP, "buy"]),
                true;

            ?MNY_T_GUILD_CONTRI ->
                player:cost_guild_contri(PS, NpcShop#shop_goods.price * Count, [?LOG_NPC_SHOP, "buy"]),
                true;
                % case player:cost_guild_contri(PS, NpcShop#shop_goods.price * Count, [?LOG_NPC_SHOP, "buy"]) of
                %     ok -> true;
                %     _Other -> _Other
                % end;

                % case mod_guild_mgr:cost_member_contri(PS, NpcShop#shop_goods.price * Count, [?LOG_NPC_SHOP, "buy"]) of
                %     ok -> true;
                %     _Other -> _Other
                % end;
            ?MNY_T_LITERARY ->
                player:cost_literary(PS, NpcShop#shop_goods.price * Count, [?LOG_NPC_SHOP, "buy"]),
                true;
            ?MNY_T_COPPER ->
                ConsumerGoodsList = lists:foldl(fun({No, Cnt}, Acc) -> [{No, Cnt * Count} | Acc] end, [], NpcShop#shop_goods.consumer_goods_list),
                mod_inv:destroy_goods_WNC(player:id(PS), ConsumerGoodsList, [?LOG_NPC_SHOP, "buy"]),
                true;
            ?MNY_T_EXP ->
                player:cost_exp(PS, NpcShop#shop_goods.price * Count, [?LOG_NPC_SHOP, "buy"]),
                true;
            _Any ->
                ?ASSERT(false, _Any),
                {fail, ?PM_DATA_CONFIG_ERROR}
        end,
    %% 加强判断，防止配错数据，导致bug
    case CostRet of
        {fail, Reason} ->
            {fail, Reason};
        true ->
            ?TRACE("do_buy_goods_from_npc,GoodsNo:~p, Count:~p~n", [GoodsNo, Count]),
            Quality = 
                case lib_goods:is_valid_quality(NpcShop#shop_goods.quality) of
                    false ->
                        case lib_goods:get_tpl_data(GoodsNo) of
                            null -> ?QUALITY_INVALID;
                            GoodsTpl -> lib_goods:get_quality(GoodsTpl)
                        end;
                    true -> NpcShop#shop_goods.quality
                end,
            
            mod_inv:batch_smart_add_new_goods(player:get_id(PS), [{GoodsNo, Count}], [{quality, Quality}, {bind_state, NpcShop#shop_goods.bind_state}], [?LOG_NPC_SHOP, "buy"]),

            case NpcShop#shop_goods.count_limit_type =:= 0 of
                true -> skip;
                false ->
                    lib_shop:update_player_buy_goods(PS, GoodsNo, Count, ?SHOP_TYPE_NPC, NpcShop)
            end,
            case NpcShop#shop_goods.goods_type =:= 2 of
                false -> skip;
                true ->
                    case lib_shop:get_dynamic_shop_goods(GoodsNo) of
                        null -> skip;
                        DyShopGoods ->
                            DyShopGoods1 = DyShopGoods#shop_goods{left_num = DyShopGoods#shop_goods.left_num - Count},
                            lib_shop:update_dynamic_shop_goods(DyShopGoods1)
                    end
            end,
            ply_tips:send_sys_tips(PS, {buy_goods, [GoodsNo, NpcShop#shop_goods.quality, Count,0]}),
            ok
    end.


%% 获取某个玩家的购买情况
%% return null | buy_goods 列表
get_buy_info(PlayerId, ShopType) ->
    case ply_misc:get_player_misc(PlayerId) of
        null -> null;
        PlayerMisc -> 
            case ShopType of
                ?SHOP_TYPE_NPC ->
                    PlayerMisc#player_misc.buy_goods_from_npc;
                ?SHOP_TYPE_SHOP ->
                    PlayerMisc#player_misc.buy_goods_from_shop;
                ?SHOP_TYPE_OP_SHOP ->
                    PlayerMisc#player_misc.buy_goods_from_op_shop
            end
    end.


get_player_buy_goods_count(PlayerId, ShopGoodsCfg, ShopType) ->
    GoodsNo = ShopGoodsCfg#shop_goods.goods_no,
    case get_buy_info(PlayerId, ShopType) of
        null -> 0;
        BuyInfo ->
            case lists:keyfind(GoodsNo, 1, BuyInfo) of
                false -> 0;
                {_GoodsNo1, Count} -> Count;
                {_GoodsNo1, Count, TimeStamp} -> 
                    case ShopGoodsCfg#shop_goods.count_limit_type of
                        1 ->
                            case util:is_same_day(TimeStamp) of
                                true -> Count;
                                false -> 0
                            end;
                        2 ->
                            case util:is_same_week(TimeStamp) of
                                true -> Count;
                                false -> 0
                            end;
                        3 ->
                            case util:is_same_month(TimeStamp) of
                                true -> Count;
                                false -> 0
                            end
                    end
            end
    end.


check_sell_goods_from_bag(PS, GoodsId, SellCount) ->
    case SellCount =< 0 of
        true -> 
            {fail, ?PM_PARA_ERROR};
        false ->
            case mod_inv:find_goods_by_id_from_bag(player:get_id(PS), GoodsId) of
                null -> {fail, ?PM_GOODS_NOT_EXISTS};
                Goods ->
                    case lib_goods:is_can_sell(Goods) of
                        false -> 
                            {fail, ?PM_GOODS_CANT_TRADE};
                        true ->
                            case lib_goods:get_count(Goods) < SellCount of
                                true ->
                                    {fail, ?PM_PARA_ERROR};
                                false ->
                                    case lib_goods:get_slot(Goods) =:= 0 of
                                        true -> {fail, ?PM_PARA_ERROR};
                                        false -> ok
                                    end
                            end
                    end
            end
    end.


do_sell_goods_from_bag(PS, GoodsId, SellCount) ->
    Goods = mod_inv:find_goods_by_id_from_bag(player:get_id(PS), GoodsId),
    ?ASSERT(Goods /= null),
    case mod_inv:destroy_goods_WNC(player:get_id(PS), Goods, SellCount, [?LOG_NPC_SHOP, "sell"]) of
        ok ->
            Goods1 = Goods#goods{sell_time = svr_clock:get_unixtime(), location = ?LOC_INVALID},
            add_goods_to_buy_back_list(PS, Goods1),
            case lib_goods:is_equip(Goods1) of
                true ->
                    player:add_money(PS, lib_goods:get_sell_price_type(Goods), util:ceil(lib_goods:get_sell_price(Goods) * math:pow(3, lib_goods:get_quality(Goods) - 1) * SellCount), [?LOG_NPC_SHOP, "sell"]);
                false ->
                    player:add_money(PS, lib_goods:get_sell_price_type(Goods), util:ceil(lib_goods:get_sell_price(Goods) * SellCount), [?LOG_NPC_SHOP, "sell"])
            end;
        {ok, LeftGoods} ->
            Goods1 = Goods#goods{sell_time = svr_clock:get_unixtime(), count = lib_goods:get_count(Goods) - lib_goods:get_count(LeftGoods), location = ?LOC_INVALID},
            add_goods_to_buy_back_list(PS, Goods1),
            case lib_goods:is_equip(Goods) of
                true ->
                    player:add_money(PS, lib_goods:get_sell_price_type(Goods), util:ceil(lib_goods:get_sell_price(Goods) * math:pow(3, lib_goods:get_quality(Goods) - 1) * SellCount), [?LOG_NPC_SHOP, "sell"]);
                false ->
                    player:add_money(PS, lib_goods:get_sell_price_type(Goods), util:ceil(lib_goods:get_sell_price(Goods) * SellCount), [?LOG_NPC_SHOP, "sell"])
            end;
        _Any ->
            skip
    end,
    ply_tips:send_sys_tips(PS, {sell_goods, [lib_goods:get_no(Goods), lib_goods:get_quality(Goods), SellCount,0]}).


get_buy_back(PlayerId) ->
    case ets:lookup(?ETS_BUY_BACK, PlayerId) of
        [] -> null;
        [BuyBack] -> BuyBack
    end.

update_buy_back(BuyBack) when is_record(BuyBack, buy_back) ->
    ets:insert(?ETS_BUY_BACK, BuyBack).


insert_buy_back(BuyBack) when is_record(BuyBack, buy_back) ->
    ets:insert(?ETS_BUY_BACK, BuyBack).


add_goods_to_buy_back_list(PS, Goods) ->
    NewId = mod_id_alloc:next_comm_id(),
    Goods1 = Goods#goods{id = NewId},
    case get_buy_back_list(PS) of
        [] ->
            BuyBack = #buy_back{player_id = player:get_id(PS), goods = [Goods1]},
            insert_buy_back(BuyBack),
            notify_cli_goods_added_to_buy_back_list(player:get_id(PS), Goods1);
        GoodsList ->
            BuyBack = get_buy_back(player:get_id(PS)),
            ?ASSERT(BuyBack /= null),
            case length(GoodsList) >= ?BUY_BACK_LIST_CAPACITY of %% 需要替换最早卖出的物品
                true -> 
                    GoodsList1 = lib_inv:sort_goods(GoodsList, sort_by_sell_time),
                    GoodsDestroy = erlang:hd(GoodsList1),
                    GoodsList2 = GoodsList1 -- [GoodsDestroy],
                    GoodsList3 = GoodsList2 ++ [Goods1],
                    BuyBack1 = BuyBack#buy_back{goods = GoodsList3},
                    update_buy_back(BuyBack1),
                    notify_cli_goods_destroy_in_back_list(player:get_id(PS), lib_goods:get_id(GoodsDestroy)),
                    notify_cli_goods_added_to_buy_back_list(player:get_id(PS), Goods1);
                false ->
                    GoodsList2 = GoodsList ++ [Goods1],
                    BuyBack1 = BuyBack#buy_back{goods = GoodsList2},
                    update_buy_back(BuyBack1),
                    notify_cli_goods_added_to_buy_back_list(player:get_id(PS), Goods1)
            end
    end.


check_buy_back(PS, GoodsId, StackCount) ->
    case StackCount =< 0 of
        true -> {fail, ?PM_PARA_ERROR};
        false ->
            BuyBack = get_buy_back(player:get_id(PS)),
            ?ASSERT(BuyBack /= null),
            GoodsList = BuyBack#buy_back.goods,
            case lists:keyfind(GoodsId, #goods.id, GoodsList) of
                false ->
                    ?TRACE("ply_trade:check_buy_back goodsId:~p~n", [GoodsId]),
                    {fail, ?PM_GOODS_OVERDUE};
                Goods ->
                    case lib_goods:get_count(Goods) >= StackCount of
                        false -> 
                            {fail, ?PM_PARA_ERROR};
                        true ->
                            Location = lib_goods:decide_bag_location(Goods),
                            case mod_inv:has_enough_empty_slots(player:get_id(PS), Location, 1) of
                                false->
                                    case Location of
                                        ?LOC_BAG_EQ -> {fail, ?PM_EQ_BAG_FULL_PLZ_ARRANGE_TIMELY};
                                        ?LOC_BAG_USABLE -> {fail, ?PM_US_BAG_FULL_PLZ_ARRANGE_TIMELY};
                                        ?LOC_BAG_UNUSABLE -> {fail, ?PM_UNUS_BAG_FULL_PLZ_ARRANGE_TIMELY}
                                    end;
                                true ->
                                    MoneyCount = 
                                        case lib_goods:is_equip(Goods) of
                                            false ->
                                                util:ceil(lib_goods:get_sell_price(Goods) * 1.1) * StackCount;
                                            true ->
                                                util:ceil(lib_goods:get_sell_price(Goods) * math:pow(3, lib_goods:get_quality(Goods) - 1) * 1.1) * StackCount
                                        end,

                                    case player:has_enough_money(PS, lib_goods:get_sell_price_type(Goods), MoneyCount) of
                                        false -> 
                                            Reason = 
                                            case lib_goods:get_sell_price_type(Goods) of
                                                ?MNY_T_GAMEMONEY -> ?PM_GAMEMONEY_LIMIT;
                                                ?MNY_T_BIND_GAMEMONEY -> ?PM_BIND_GAMEMONEY_LIMIT;
                                                ?MNY_T_YUANBAO -> ?PM_YB_LIMIT;
                                                ?MNY_T_BIND_YUANBAO -> ?PM_BIND_YB_LIMIT;
                                                ?MNY_T_INTEGRAL -> ?PM_INTEGRAL_LIMIT;
                                                ?MNY_T_CHIVALROUS -> ?PM_CHIVALROUS_LIMIT;
												?MNY_T_QUJING -> ?PM_JINGWEN_LIMIT;
                                                ?MNY_T_MYSTERY -> ?PM_MIJING_LIMIT;
                                                ?MNY_T_MIRAGE -> ?PM_HUANJING_LIMIT;
                                                ?MNY_T_CHIP -> ?PM_CHIP_LIMIT;
                                                _Any -> 0
                                            end,
                                            {fail, Reason};
                                        true -> ok
                                    end
                            end
                    end
            end
    end.
    

%% 对于非装备，回购价格=读表的卖出价格*1.1 装备的话 回购价格=读表的卖出价格*pow(3,品质-1）*1.1 
do_buy_back(PS, GoodsId, StackCount) ->
    BuyBack = get_buy_back(player:get_id(PS)),
    ?ASSERT(BuyBack /= null),
    GoodsList = BuyBack#buy_back.goods,
    Goods = lists:keyfind(GoodsId, #goods.id, GoodsList),
    ?ASSERT(Goods /= false),
    
    MoneyCost = 
        case lib_goods:is_equip(Goods) of
            false ->
                util:ceil(lib_goods:get_sell_price(Goods) * 1.1) * StackCount;
            true ->
                util:ceil(lib_goods:get_sell_price(Goods) * math:pow(3, lib_goods:get_quality(Goods) - 1) * 1.1) * StackCount
        end,
    player:cost_money(PS, lib_goods:get_sell_price_type(Goods), MoneyCost, [?LOG_NPC_SHOP, "buy"]),

    LeftCount = lib_goods:get_count(Goods) - StackCount,
    case LeftCount > 0 of %% 还有剩余需要更新回购物品栏信息和背包信息
        true ->
            Goods1 = lib_goods:set_count(Goods, StackCount),
            Location = lib_goods:decide_bag_location(Goods1),
            Goods2 = lib_goods:set_slot(Goods1, mod_inv:find_first_empty_slot(player:get_id(PS), Location)), 
            Goods3 = lib_goods:set_location(Goods2, Location),

            mod_inv:add_new_goods_to_bag(player:get_id(PS), Goods3, [?LOG_NPC_SHOP, "back"]),

            GoodsLeft = Goods#goods{count = LeftCount},
            GoodsList1 = GoodsList -- [Goods],
            GoodsList2 = GoodsList1 ++ [GoodsLeft],
            BuyBack1 = BuyBack#buy_back{goods = GoodsList2},
            update_buy_back(BuyBack1); %% 客户端根据此协议返回值自己更新
        false ->
            Location = lib_goods:decide_bag_location(Goods),
            Goods2 = lib_goods:set_slot(Goods, mod_inv:find_first_empty_slot(player:get_id(PS), Location)), 
            Goods3 = lib_goods:set_location(Goods2, Location),
            %% 回购的物品上可能有宝石
            mod_inv:add_new_goods_to_bag(player:get_id(PS), Goods3, [?LOG_NPC_SHOP, "back"]),
            GoodsList1 = GoodsList -- [Goods],
            BuyBack1 = BuyBack#buy_back{goods = GoodsList1},
            update_buy_back(BuyBack1) %% 客户端根据此协议返回值自己更新
    end,
    ply_tips:send_sys_tips(PS, {buy_goods, [lib_goods:get_no(Goods), lib_goods:get_quality(Goods), StackCount,0]}).


%% 玩家回购列表加入物品后，通知客户端
notify_cli_goods_added_to_buy_back_list(PlayerId, GoodsAdded) ->
    {ok, BinData} = pt_32:write(?PT_NOTIFY_BUY_BACK_GOODS_ADDED, [GoodsAdded]),
    lib_send:send_to_uid(PlayerId, BinData).


notify_cli_goods_destroy_in_back_list(PlayerId, GoodsId) ->
    {ok, BinData} = pt_32:write(?PT_NOTIFY_BUY_BACK_GOODS_DESTROYED, [GoodsId]),
    lib_send:send_to_uid(PlayerId, BinData).    


handle_gem_for_equip(PlayerId, Goods) ->
    case lib_goods:is_equip(Goods) of
        false -> skip;
        true ->
            GemStoneList = lib_goods:get_equip_gemstone(Goods),
            F = fun({_Hno, Id}) ->
                case Id =:= ?INVALID_ID of
                    true -> skip;
                    false ->
                        case lib_goods:get_goods_by_id(Id) of
                            null -> skip;
                            GemGoods ->
                                case lib_goods:get_slot(GemGoods) =:= 0 of
                                    true -> 
                                        %% 更新物品栏信息
                                        Inv = mod_inv:get_inventory(PlayerId),
                                        case lib_goods:get_location(GemGoods) of
                                            ?LOC_BAG_EQ ->
                                                case lists:member(lib_goods:get_id(GemGoods), Inv#inv.eq_goods) of
                                                    true ->
                                                        BagEqGoodsList = Inv#inv.eq_goods -- [lib_goods:get_id(GemGoods)],
                                                        mod_inv:update_inventory_to_ets(Inv#inv{eq_goods = BagEqGoodsList});
                                                    false -> skip
                                                end;
                                                
                                            ?LOC_PLAYER_EQP ->
                                                case lists:member(lib_goods:get_id(GemGoods), Inv#inv.player_eq_goods) of
                                                    true ->
                                                        PlayerEqGoodsList = Inv#inv.player_eq_goods -- [lib_goods:get_id(GemGoods)],
                                                        mod_inv:update_inventory_to_ets(Inv#inv{player_eq_goods = PlayerEqGoodsList});
                                                    false -> skip
                                                end;

                                            ?LOC_PARTNER_EQP ->
                                                case lists:member(lib_goods:get_id(GemGoods), Inv#inv.partner_eq_goods) of
                                                    true ->
                                                        PlayerEqGoodsList = Inv#inv.partner_eq_goods -- [lib_goods:get_id(GemGoods)],
                                                        mod_inv:update_inventory_to_ets(Inv#inv{partner_eq_goods = PlayerEqGoodsList});
                                                    false -> skip
                                                end;

                                            _Any ->
                                                ?ASSERT(false, _Any),
                                                ?ERROR_MSG("ply_trade:handle_gem_for_equip error!~p~n", [_Any])
                                        end,
                                        mod_inv:del_goods_from_ets_by_goods_id(Id),
                                        lib_goods:db_delete_goods(PlayerId, Id);
                                    false -> 
                                        ?ERROR_MSG("ply_trade:handle_buy_back_goods_expired error!~n", [])
                                end
                        end
                end
            end,
            lists:foreach(F, GemStoneList)
    end.