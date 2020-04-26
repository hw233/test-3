%%%------------------------------------
%%% @Module  : mod_shop
%%% @Author  : zhangwq
%%% @Email   :
%%% @Created : 2014.2.17
%%% @Description: 商城
%%%------------------------------------


-module(mod_shop).
-behaviour(gen_server).
-export([start_link/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-export([
        new_day_comes/0,
        on_op_shop_activity_open/3,
        get_op_shop_goods_list/1,           %% 获取运营后台商店可购买列表
        buy_op_shop_goods/3,                %% 购买运营后台商店物品

        buy_goods/3,
        get_dynamic_goods_list/1
    ]).


-include("trade.hrl").
-include("prompt_msg_code.hrl").
-include("ets_name.hrl").
-include("debug.hrl").
-include("abbreviate.hrl").
-include("common.hrl").
-include("goods.hrl").
-include("log.hrl").
-include("record.hrl").
-include("pt_52.hrl").
-include_lib("stdlib/include/ms_transform.hrl").


-record(state, {
        start_time = 0,
        end_time = 0,
        script = []         % [{Day1, 商店编号1},{Day2, 商店编号2}...]   其中 Day1 Day2指活动第几天，如：活动今天开始卖商店1的物品，则Day为1商店编号1 
                            % 商店编号2 从表 S商城配置表\运营限时限购商店配置表.xls 的 商店编号 字段
    }).


get_op_shop_goods_list(PS) ->
    Lv = player:get_lv(PS),
    % Ms = ets:fun2ms(fun(T) when ( (Lv >= T#shop_goods.lv_need andalso Lv =< T#shop_goods.lv_need_max) orelse 
        % (T#shop_goods.lv_need =< 0 andalso T#shop_goods.lv_need_max =< 0) ) -> T end),
    List = ets:tab2list(?ETS_OP_SHOP_GOODS),
    Ret = [T || T <- List, ( (Lv >= T#shop_goods.lv_need andalso Lv =< T#shop_goods.lv_need_max) orelse (T#shop_goods.lv_need =< 0 andalso T#shop_goods.lv_need_max =< 0)
           orelse (T#shop_goods.lv_need =< Lv andalso T#shop_goods.lv_need_max =< 0) )],
    ?DEBUG_MSG("mod_shop:get_op_shop_goods_list:~w~n", [Ret]),
    Ret.
    % ets:select(?ETS_OP_SHOP_GOODS, Ms).


buy_op_shop_goods(PS, GoodsNo, Count) ->
    case check_buy_op_shop_goods(PS, GoodsNo, Count) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, ShopGoods} ->
            do_buy_op_shop_goods(PS, ShopGoods, Count)
    end.


buy_goods(PS, GoodsNo, Count) ->
    ActivityFlag = mod_admin_activity:is_festival_activity_alive(10),

    TypeList =
        case ActivityFlag of
            false -> data_shop:get_shop_goods_type_list();
            true -> data_shop_discount:get_shop_goods_type_list()  
        end,

    F = fun(Type, Acc) ->
        case Type =:= 0 of
            true -> Acc;
            false ->
                case lists:member(Type, TypeList) of
                    false -> Acc;
                    true -> 
                        case ActivityFlag of
                            false ->
                                data_shop:get_shop_goods_no_list_by_type(Type) ++ Acc;
                            true ->
                                data_shop_discount:get_shop_goods_no_list_by_type(Type) ++ Acc
                        end
                end
        end
    end,

    DynamicShopGoodsNoL = lists:foldl(F, [], TypeList),

    case lists:member(GoodsNo, DynamicShopGoodsNoL) of
        true ->
            case Count > 0 of
                false -> skip;
                true ->
                    case catch gen_server:call(?SHOP_PROCESS, {'buy_goods', PS, GoodsNo, Count}) of
                        {'EXIT', Reason} ->
                            ?ERROR_MSG("buy_goods(), exit for reason: ~p~n", [Reason]),
                            ?ASSERT(false, Reason),
                            {fail, Reason};
                        {fail, Reason} ->
                            {fail, Reason};
                        ok ->
                            ok
                    end
            end;
        false ->
            case check_buy_goods(PS, GoodsNo, Count) of
                {fail, Reason} ->
                    {fail, Reason};
                {ok, ShopGoods} ->
                    do_buy_goods(PS, ShopGoods, Count)
            end
    end.


get_dynamic_goods_list(PS) ->
    gen_server:cast(?SHOP_PROCESS, {'get_dynamic_goods_list', PS}).


new_day_comes() ->
    gen_server:cast(?SHOP_PROCESS, {'new_day_comes'}).    


%%  Content --> 活动内容脚本，运营配置, 
%%  StartStamp, EndStamp  活动开始与结束时间戳
on_op_shop_activity_open(Content, StartStamp, EndStamp) ->
    ?ASSERT(is_list(Content), Content),
    case is_list(Content) of
        false ->
            ?ERROR_MSG("mod_shop:on_op_shop_activity_open error!~n", []);
        true ->
            gen_server:cast(?SHOP_PROCESS, {'on_op_shop_activity_open', Content, StartStamp, EndStamp})
    end.

% -------------------------------------------------------------------------

check_buy_op_shop_goods(PS, GoodsNo, Count) ->
    try check_buy_op_shop_goods__(PS, GoodsNo, Count) of
        {ok, ShopGoods} -> 
            {ok, ShopGoods}
    catch 
        throw: FailReason ->
            {fail, FailReason}
    end.


check_buy_op_shop_goods__(PS, GoodsNo, Count) ->
    ?Ifc (lib_goods:get_tpl_data(GoodsNo) =:= null)
        throw(?PM_GOODS_NOT_EXISTS)
    ?End,

    ?Ifc (Count =< 0)
        throw(?PM_PARA_ERROR)
    ?End,

    ?Ifc (not player:is_online(player:get_id(PS)))
        throw(?PM_UNKNOWN_ERR)
    ?End,

    ShopGoods = lib_shop:get_op_shop_goods(GoodsNo),

    ?Ifc (ShopGoods =:= null)
        throw(?PM_GOODS_NOT_EXISTS)
    ?End,
    
    ?Ifc (not lib_goods:is_valid_bind_state(ShopGoods#shop_goods.bind_state))
        throw(?PM_PARA_ERROR)
    ?End,

    ?Ifc (not lists:member(ShopGoods#shop_goods.price_type, [?MNY_T_CHIP,?MNY_T_CHIVALROUS,?MNY_T_COPPER,?MNY_T_GAMEMONEY, ?MNY_T_BIND_GAMEMONEY, ?MNY_T_YUANBAO, ?MNY_T_BIND_YUANBAO, ?MNY_T_QUJING, ?MNY_T_MYSTERY, ?MNY_T_MIRAGE, ?MNY_T_INTEGRAL]))
        throw(?PM_DATA_CONFIG_ERROR)
    ?End,

    ?Ifc (ShopGoods#shop_goods.price_type =:= ?MNY_T_GAMEMONEY andalso (not player:has_enough_gamemoney(PS, ShopGoods#shop_goods.discount_price * Count)))
        throw(?PM_GAMEMONEY_LIMIT)
    ?End,
    ?Ifc (ShopGoods#shop_goods.price_type =:= ?MNY_T_BIND_GAMEMONEY andalso (not player:has_enough_bind_gamemoney(PS, ShopGoods#shop_goods.discount_price * Count)))
        throw(?PM_BIND_GAMEMONEY_LIMIT)
    ?End,
    ?Ifc (ShopGoods#shop_goods.price_type =:= ?MNY_T_YUANBAO andalso (not player:has_enough_yuanbao(PS, ShopGoods#shop_goods.discount_price * Count)))
        throw(?PM_YB_LIMIT)
    ?End,
    ?Ifc (ShopGoods#shop_goods.price_type =:= ?MNY_T_BIND_YUANBAO andalso (not player:has_enough_bind_yuanbao(PS, ShopGoods#shop_goods.discount_price * Count)))
        throw(?PM_BIND_YB_LIMIT)
    ?End,
	
	?Ifc (ShopGoods#shop_goods.price_type =:= ?MNY_T_INTEGRAL andalso (not player:has_enough_integral(PS, ShopGoods#shop_goods.discount_price * Count)))
        throw(?PM_INTEGRAL_LIMIT)
    ?End,

    ?Ifc (ShopGoods#shop_goods.price_type =:= ?MNY_T_COPPER andalso (not player:has_enough_copper(PS, ShopGoods#shop_goods.discount_price * Count)))
        throw(?PM_COPPER_LIMIT)
    ?End,
	
    ?Ifc (ShopGoods#shop_goods.price_type =:= ?MNY_T_CHIVALROUS andalso (not player:has_enough_chivalrous(PS, ShopGoods#shop_goods.discount_price * Count)))
        throw(?PM_CHIVALROUS_LIMIT)
    ?End,

    ?Ifc (ShopGoods#shop_goods.price_type =:= ?MNY_T_QUJING andalso (not player:has_enough_jingwen(PS, ShopGoods#shop_goods.discount_price * Count)))
        throw(?PM_JINGWEN_LIMIT)
    ?End,

    ?Ifc (ShopGoods#shop_goods.price_type =:= ?MNY_T_MYSTERY andalso (not player:has_enough_mijing(PS, ShopGoods#shop_goods.discount_price * Count)))
        throw(?PM_MIJING_LIMIT)
    ?End,

    ?Ifc (ShopGoods#shop_goods.price_type =:= ?MNY_T_MIRAGE andalso (not player:has_enough_huanjing(PS, ShopGoods#shop_goods.discount_price * Count)))
        throw(?PM_HUANJING_LIMIT)
    ?End,

    ?Ifc (ShopGoods#shop_goods.price_type =:= ?MNY_T_CHIP andalso (player:get_chip(PS) < ShopGoods#shop_goods.discount_price * Count))
        throw(?PM_CHIP_LIMIT)
    ?End,   

    ?Ifc ( (ShopGoods#shop_goods.lv_need > 0 andalso ShopGoods#shop_goods.lv_need_max > 0) andalso 
    (player:get_lv(PS) < ShopGoods#shop_goods.lv_need orelse player:get_lv(PS) > ShopGoods#shop_goods.lv_need_max) )
        throw(?PM_LV_LIMIT)
    ?End,

    ?Ifc (player:get_vip_lv(PS) < ShopGoods#shop_goods.vip_lv_need)
        throw(?PM_VIP_LV_LIMIT)
    ?End,

    ?Ifc (ShopGoods#shop_goods.race_need /= 0 andalso player:get_race(PS) < ShopGoods#shop_goods.race_need)
        throw(?PM_RACE_LIMIT)
    ?End,
    
    ?Ifc (ShopGoods#shop_goods.faction_need /= 0 andalso player:get_faction(PS) < ShopGoods#shop_goods.faction_need)
        throw(?PM_FACTION_LIMIT)
    ?End,
    
    ?Ifc (ShopGoods#shop_goods.count_limit_type =/= 0 andalso 
    Count  + ply_trade:get_player_buy_goods_count(player:id(PS), ShopGoods, ?SHOP_TYPE_OP_SHOP) > ShopGoods#shop_goods.buy_count_limit_time)
        throw(?PM_BUY_COUNT_LIMIT)
    ?End,
    
    ?Ifc (ShopGoods#shop_goods.goods_type =:= 2 andalso ShopGoods#shop_goods.left_num < Count)
        throw(?PM_GOODS_SELL_OVER)
    ?End,

    ?Ifc (ShopGoods#shop_goods.goods_type =:= 1 andalso ShopGoods#shop_goods.expire_time =:= 0)
        throw(?PM_MK_BUY_FAIL_GOODS_EXPIRED)
    ?End,

    case mod_inv:check_batch_add_goods(player:get_id(PS), [{GoodsNo, Count}]) of
        {fail, Reason} -> throw(Reason);
        ok -> {ok, ShopGoods}
    end.


do_buy_op_shop_goods(PS, ShopGoods, Count) ->
    case ShopGoods#shop_goods.price_type of
        ?MNY_T_GAMEMONEY -> % 游戏币
            player:cost_gamemoney(PS, ShopGoods#shop_goods.discount_price * Count, [?LOG_SHOP, "buy"]);
        ?MNY_T_YUANBAO ->
            player:cost_yuanbao(PS, ShopGoods#shop_goods.discount_price * Count, [?LOG_SHOP, "buy"]);
        ?MNY_T_BIND_GAMEMONEY ->
            player:cost_bind_gamemoney(PS, ShopGoods#shop_goods.discount_price * Count, [?LOG_SHOP, "buy"]);
        ?MNY_T_BIND_YUANBAO ->
            player:cost_bind_yuanbao(PS, ShopGoods#shop_goods.discount_price * Count, [?LOG_SHOP, "buy"]);

        ?MNY_T_INTEGRAL ->
            player:cost_integral(PS, ShopGoods#shop_goods.discount_price * Count, [?LOG_SHOP, "buy"]);

        ?MNY_T_CHIVALROUS ->
            player:cost_chivalrous(PS, ShopGoods#shop_goods.discount_price * Count, [?LOG_SHOP, "buy"]);
        ?MNY_T_QUJING ->
            player:cost_jingwen(PS, ShopGoods#shop_goods.discount_price * Count, [?LOG_SHOP, "buy"]);
        ?MNY_T_MYSTERY ->
            player:cost_mijing(PS, ShopGoods#shop_goods.discount_price * Count, [?LOG_SHOP, "buy"]);
        ?MNY_T_MIRAGE ->
            player:cost_huanjing(PS, ShopGoods#shop_goods.discount_price * Count, [?LOG_SHOP, "buy"]);

        ?MNY_T_CHIP ->
            player:cost_chip(PS, ShopGoods#shop_goods.discount_price * Count, [?LOG_SHOP, "buy"]);
            
        _Any -> % 判断函数已经做了判断，这个分支不会出现
            ?ASSERT(false)
    end,

    GoodsNo = ShopGoods#shop_goods.goods_no,
    case ShopGoods#shop_goods.count_limit_type =:= 0 of
        true -> skip;
        false -> %% 有限制某个时间段内购买个数
            lib_shop:update_player_buy_goods(PS, GoodsNo, Count, ?SHOP_TYPE_OP_SHOP, ShopGoods)
    end,

    GoodsTpl = lib_goods:get_tpl_data(GoodsNo),
    GoodsType = lib_goods:get_type(GoodsTpl),
    GoodsSubType = lib_goods:get_subtype(GoodsTpl),
    if 
        GoodsType =:= ?GOODS_T_VIRTUAL andalso GoodsSubType =:= ?VGOODS_T_GAMEMONEY ->
            Num = lib_goods:get_max_stack(GoodsTpl) * Count,
            lib_log:statis_shop_produce_money(PS, ?VGOODS_GAMEMONEY, Num, ShopGoods#shop_goods.price_type, ShopGoods#shop_goods.discount_price * Count, [?LOG_SHOP, "buy"]),
            player:add_gamemoney(PS, Num, [?LOG_SKIP]);
        true ->
            case mod_inv:batch_smart_add_new_goods(player:get_id(PS), [{ShopGoods#shop_goods.goods_no, Count}], 
            [{quality, ShopGoods#shop_goods.quality}, {bind_state, ShopGoods#shop_goods.bind_state}], [?LOG_SKIP]) of
                {fail, _} ->
                    ?ASSERT(false),
                    ?ERROR_MSG("mod_shop do_buy_op_shop_goods error!~n", []);
                {ok, RetGoods} ->
                    F = fun({GoodsId, No, GoodsCount}) ->
                        lib_log:statis_shop_produce_goods(PS, GoodsId, No, GoodsCount, ShopGoods#shop_goods.price_type, ShopGoods#shop_goods.discount_price * GoodsCount, 
                            [?LOG_SHOP, "buy"])
                    end,
                    [F(X) || X <- RetGoods]
            end
    end,
    ply_tips:send_sys_tips(PS, {buy_goods, [GoodsNo, ShopGoods#shop_goods.quality, Count,0]}),
    ok.


check_buy_goods(PS, GoodsNo, Count) ->
    try check_buy_goods__(PS, GoodsNo, Count) of
        {ok, ShopGoods} -> 
            {ok, ShopGoods}
    catch 
        throw: FailReason ->
            {fail, FailReason}
    end.


check_buy_goods__(PS, GoodsNo, Count) ->
    ?Ifc (lib_goods:get_tpl_data(GoodsNo) =:= null)
        throw(?PM_GOODS_NOT_EXISTS)
    ?End,
    ?Ifc (Count =< 0)
        throw(?PM_PARA_ERROR)
    ?End,
    ?Ifc (not player:is_online(player:get_id(PS)))
        throw(?PM_UNKNOWN_ERR)
    ?End,
    ShopGoodsCfg = 
        case mod_admin_activity:is_festival_activity_alive(10) of
            false -> data_shop:get(GoodsNo);
            true -> data_shop_discount:get(GoodsNo)   
        end,
        
    ?Ifc (ShopGoodsCfg =:= null)
        throw(?PM_GOODS_NOT_EXISTS)
    ?End,

    ShopGoods = 
        case ShopGoodsCfg#shop_goods.goods_type =:= 0 orelse ShopGoodsCfg#shop_goods.goods_type =:= 3 of
            true -> ShopGoodsCfg;
            false -> lib_shop:get_dynamic_shop_goods(GoodsNo)
        end,

    ?Ifc (ShopGoods =:= null)
        throw(?PM_GOODS_NOT_EXISTS)
    ?End,
    
    ?Ifc (not lib_goods:is_valid_bind_state(ShopGoods#shop_goods.bind_state))
        throw(?PM_PARA_ERROR)
    ?End,

    ?Ifc (not lists:member(ShopGoods#shop_goods.price_type, [?MNY_T_CHIP,?MNY_T_CHIVALROUS,?MNY_T_QUJING,?MNY_T_MYSTERY,?MNY_T_MIRAGE,?MNY_T_COPPER,?MNY_T_GAMEMONEY, ?MNY_T_BIND_GAMEMONEY, ?MNY_T_YUANBAO, ?MNY_T_INTEGRAL]))
        throw(?PM_DATA_CONFIG_ERROR)
    ?End,

    ?Ifc (ShopGoods#shop_goods.price_type =:= ?MNY_T_GAMEMONEY andalso (not player:has_enough_gamemoney(PS, ShopGoods#shop_goods.discount_price * Count)))
        throw(?PM_GAMEMONEY_LIMIT)
    ?End,
    ?Ifc (ShopGoods#shop_goods.price_type =:= ?MNY_T_BIND_GAMEMONEY andalso (not player:has_enough_bind_gamemoney(PS, ShopGoods#shop_goods.discount_price * Count)))
        throw(?PM_BIND_GAMEMONEY_LIMIT)
    ?End,
    ?Ifc (ShopGoods#shop_goods.price_type =:= ?MNY_T_YUANBAO andalso (not player:has_enough_yuanbao(PS, ShopGoods#shop_goods.discount_price * Count)))
        throw(?PM_YB_LIMIT)
    ?End,
    ?Ifc (ShopGoods#shop_goods.price_type =:= ?MNY_T_BIND_YUANBAO andalso (not player:has_enough_bind_yuanbao(PS, ShopGoods#shop_goods.discount_price * Count)))
        throw(?PM_BIND_YB_LIMIT)
    ?End,

	?Ifc (ShopGoods#shop_goods.price_type =:= ?MNY_T_INTEGRAL andalso (not player:has_enough_integral(PS, ShopGoods#shop_goods.discount_price * Count)))
        throw(?PM_INTEGRAL_LIMIT)
    ?End,

    ?Ifc (ShopGoods#shop_goods.price_type =:= ?MNY_T_COPPER andalso (not player:has_enough_copper(PS, ShopGoods#shop_goods.discount_price * Count)))
        throw(?PM_COPPER_LIMIT)
    ?End,

    ?Ifc (ShopGoods#shop_goods.price_type =:= ?MNY_T_CHIVALROUS andalso (not player:has_enough_chivalrous(PS, ShopGoods#shop_goods.discount_price * Count)))
        throw(?PM_CHIVALROUS_LIMIT)
    ?End,

    ?Ifc (ShopGoods#shop_goods.price_type =:= ?MNY_T_QUJING andalso (not player:has_enough_jingwen(PS, ShopGoods#shop_goods.discount_price * Count)))
        throw(?PM_JINGWEN_LIMIT)
    ?End,

    ?Ifc (ShopGoods#shop_goods.price_type =:= ?MNY_T_MYSTERY andalso (not player:has_enough_mijing(PS, ShopGoods#shop_goods.discount_price * Count)))
        throw(?PM_MIJING_LIMIT)
    ?End,

    ?Ifc (ShopGoods#shop_goods.price_type =:= ?MNY_T_MIRAGE andalso (not player:has_enough_huanjing(PS, ShopGoods#shop_goods.discount_price * Count)))
        throw(?PM_HUANJING_LIMIT)
    ?End,


    % 筹码不足
    ?Ifc (ShopGoods#shop_goods.price_type =:= ?MNY_T_CHIP andalso (player:get_chip(PS) < ShopGoods#shop_goods.discount_price * Count))
        throw(?PM_CHIP_LIMIT)
    ?End,   
    
    ?Ifc (player:get_lv(PS) < ShopGoods#shop_goods.lv_need)
        throw(?PM_LV_LIMIT)
    ?End,
    ?Ifc (player:get_vip_lv(PS) < ShopGoods#shop_goods.vip_lv_need)
        throw(?PM_VIP_LV_LIMIT)
    ?End,
    ?Ifc (ShopGoods#shop_goods.race_need /= 0 andalso player:get_race(PS) < ShopGoods#shop_goods.race_need)
        throw(?PM_RACE_LIMIT)
    ?End,
    % ?Ifc (player:get_repu(PS) < ShopGoods#shop_goods.repu_need)
    %     throw(?PM_REPU_LIMIT)
    % ?End,
    ?Ifc (ShopGoods#shop_goods.faction_need /= 0 andalso player:get_faction(PS) < ShopGoods#shop_goods.faction_need)
        throw(?PM_FACTION_LIMIT)
    ?End,
    
    ?Ifc (ShopGoods#shop_goods.count_limit_type =/= 0 andalso Count  + ply_trade:get_player_buy_goods_count(player:id(PS), ShopGoods, ?SHOP_TYPE_SHOP) > ShopGoods#shop_goods.buy_count_limit_time)
        throw(?PM_BUY_COUNT_LIMIT)
    ?End,
    
    ?Ifc (ShopGoods#shop_goods.goods_type =:= 2 andalso ShopGoods#shop_goods.left_num < Count)
        throw(?PM_GOODS_SELL_OVER)
    ?End,

    ?Ifc (ShopGoods#shop_goods.goods_type =:= 1 andalso ShopGoods#shop_goods.expire_time =:= 0)
        throw(?PM_MK_BUY_FAIL_GOODS_EXPIRED)
    ?End,

    case mod_inv:check_batch_add_goods(player:get_id(PS), [{GoodsNo, Count}]) of
        {fail, Reason} -> throw(Reason);
        ok -> {ok, ShopGoods}
    end.


do_buy_goods(PS, ShopGoods, Count) ->
    case ShopGoods#shop_goods.price_type of
        ?MNY_T_GAMEMONEY -> % 游戏币
            player:cost_gamemoney(PS, ShopGoods#shop_goods.discount_price * Count, [?LOG_SHOP, "buy"]);
        ?MNY_T_YUANBAO ->
            player:cost_yuanbao(PS, ShopGoods#shop_goods.discount_price * Count, [?LOG_SHOP, "buy"]);
        ?MNY_T_BIND_GAMEMONEY ->
            player:cost_bind_gamemoney(PS, ShopGoods#shop_goods.discount_price * Count, [?LOG_SHOP, "buy"]);
        ?MNY_T_BIND_YUANBAO ->
            player:cost_bind_yuanbao(PS, ShopGoods#shop_goods.discount_price * Count, [?LOG_SHOP, "buy"]);
				
		?MNY_T_INTEGRAL ->
            player:cost_integral(PS, ShopGoods#shop_goods.discount_price * Count, [?LOG_SHOP, "buy"]);

        ?MNY_T_COPPER ->
            player:cost_copper(PS, ShopGoods#shop_goods.discount_price * Count, [?LOG_SHOP, "buy"]);

        ?MNY_T_CHIVALROUS ->
            player:cost_chivalrous(PS, ShopGoods#shop_goods.discount_price * Count, [?LOG_SHOP, "buy"]);

        ?MNY_T_QUJING ->
            player:cost_jingwen(PS, ShopGoods#shop_goods.discount_price * Count, [?LOG_SHOP, "buy"]);

        ?MNY_T_MYSTERY ->
            player:cost_mijing(PS, ShopGoods#shop_goods.discount_price * Count, [?LOG_SHOP, "buy"]);

        ?MNY_T_MIRAGE ->
            player:cost_huanjing(PS, ShopGoods#shop_goods.discount_price * Count, [?LOG_SHOP, "buy"]);

        ?MNY_T_CHIP ->
            player:cost_chip(PS, ShopGoods#shop_goods.discount_price * Count, [?LOG_SHOP, "buy"]);
            
        _Any -> % 判断函数已经做了判断，这个分支不会出现
            ?ASSERT(false)
    end,

    GoodsNo = ShopGoods#shop_goods.goods_no,
    case ShopGoods#shop_goods.count_limit_type =:= 0 of
        true ->
            skip;
        false -> %% 有限制某个时间段内购买个数
            lib_shop:update_player_buy_goods(PS, GoodsNo, Count, ?SHOP_TYPE_SHOP, ShopGoods)
    end,

    case ShopGoods#shop_goods.goods_type =:= 2 of
        false -> 
            skip;
        true -> %% 限量物品记录当前剩余个数
            case lib_shop:get_dynamic_shop_goods(GoodsNo) of
                null ->
                    skip;
                DyShopGoods ->
                    DyShopGoods1 = DyShopGoods#shop_goods{left_num = DyShopGoods#shop_goods.left_num - Count},
                    lib_shop:update_dynamic_shop_goods(DyShopGoods1)
            end
    end,

    GoodsTpl = lib_goods:get_tpl_data(GoodsNo),
    GoodsType = lib_goods:get_type(GoodsTpl),
    GoodsSubType = lib_goods:get_subtype(GoodsTpl),
    if 
        GoodsType =:= ?GOODS_T_VIRTUAL andalso GoodsSubType =:= ?VGOODS_T_GAMEMONEY ->
            Num = lib_goods:get_max_stack(GoodsTpl) * Count,
            lib_log:statis_shop_produce_money(PS, ?VGOODS_GAMEMONEY, Num, ShopGoods#shop_goods.price_type, ShopGoods#shop_goods.discount_price * Count, [?LOG_SHOP, "buy"]),
            player:add_gamemoney(PS, Num, [?LOG_SKIP]);
        true ->
            case mod_inv:batch_smart_add_new_goods(player:get_id(PS), [{ShopGoods#shop_goods.goods_no, Count}], 
            [{quality, ShopGoods#shop_goods.quality}, {bind_state, ShopGoods#shop_goods.bind_state}], [?LOG_SKIP]) of
                {fail, _} ->
                    ?ASSERT(false),
                    ?ERROR_MSG("mod_shop add goods error!~n", []);
                {ok, RetGoods} ->
                    F = fun({GoodsId, No, GoodsCount}) ->
                        lib_log:statis_shop_produce_goods(PS, GoodsId, No, GoodsCount, ShopGoods#shop_goods.price_type, ShopGoods#shop_goods.discount_price * GoodsCount, 
                            [?LOG_SHOP, "buy"])
                    end,
                    [F(X) || X <- RetGoods]
            end
    end,
    ply_tips:send_sys_tips(PS, {buy_goods, [GoodsNo, ShopGoods#shop_goods.quality, Count,0]}),
    %商城消费多少金通知成就
    case ShopGoods#shop_goods.price_type of
        ?MNY_T_YUANBAO ->
            mod_achievement:notify_achi(shopcost, ShopGoods#shop_goods.discount_price * Count, [], PS);
        _ ->
            skip
    end,
    ok.


% -------------------------------------------------------------------------

start_link() ->
    gen_server:start_link({local, ?SHOP_PROCESS}, ?MODULE, [], []).


init([]) ->
    process_flag(trap_exit, true),
    
    lib_shop:init_shop_from_db(),

    % 定时刷新商城的动态物品
    erlang:send_after(?REFRESH_DYNAMIC_GOODS_INTV, self(), {'refresh_dynamic_goods', 0}),
    {ok, #state{}}.


handle_call(Request, From, State) ->
    try
        handle_call_2(Request, From, State)
    catch
        Err:Reason ->
            ?ERROR_MSG("ERR:~p,Reason:~p",[Err,Reason]),
             {reply, error, State}
    end.


handle_call_2({'buy_goods', PS, GoodsNo, Count}, _From, State) ->
    Ret = 
    case check_buy_goods(PS, GoodsNo, Count) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, ShopGoods} ->
            do_buy_goods(PS, ShopGoods, Count)
    end,
    {reply, Ret, State};


handle_call_2(_Request, _From, State) ->
    {reply, State, State}.

handle_cast(Request, State) ->
    try
        handle_cast_2(Request, State)
    catch
        Err:Reason ->
            ?ERROR_MSG("ERR:~p,Reason:~p",[Err,Reason]),
            {noreply, State}
    end.

handle_cast_2({'get_dynamic_goods_list', PS}, State) ->
    ?TRY_CATCH(try_get_dynamic_goods_list(PS), ErrReason),
    {noreply, State};


handle_cast_2({'on_op_shop_activity_open', Content, StartStamp, EndStamp}, State) ->
    NewState = State#state{start_time = StartStamp, end_time = EndStamp, script = Content},
    NewState1 = refresh_op_shop_goods(util:unixtime(), NewState),
    {noreply, NewState1};    

handle_cast_2({'new_day_comes'}, State) ->
    NewState = refresh_op_shop_goods(util:unixtime(), State),
    {noreply, NewState};    

handle_cast_2(_Msg, State) ->
    {noreply, State}.


handle_info(Request, State) ->
    try
        handle_info_2(Request, State)
    catch
        Err:Reason->
            ?ERROR_MSG("ERR:~p,Reason:~p",[Err,Reason]),
             {noreply, State}
    end.

handle_info_2({'refresh_dynamic_goods', CurTick}, State) ->
    CurUnixTime = util:unixtime(),

    ?TRY_CATCH(refresh_shop_goods(CurUnixTime), ErrReason),

    erlang:send_after(?REFRESH_DYNAMIC_GOODS_INTV, self(), {'refresh_dynamic_goods', CurTick + 1}),
    {noreply, State};


handle_info_2(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

% %%-------------------------------------------------------------------------------------------------


refresh_op_shop_goods(CurUnixTime, State) ->
    case State#state.start_time =:= 0 of
        true -> State;
        false ->
            Day = util:get_nth_day_from_time_to_now(State#state.start_time),
            ?DEBUG_MSG("mod_shop:refresh_op_shop_goods Day:~p, State:~w ~n", [Day, State]),
            case lists:keyfind(Day, 1, State#state.script) of
                false -> 
                    case State#state.end_time > 0 andalso CurUnixTime > State#state.end_time of
                        true -> 
                            ets:delete_all_objects(?ETS_OP_SHOP_GOODS),
                            State#state{start_time = 0, end_time = 0, script = []};
                        false -> 
                            State
                    end;
                {_, No} ->
                    ExpireTime = 24*3600 + util:calc_today_0_sec(),
                    F = fun(ShopGoods, Acc) ->
                        [ShopGoods#shop_goods{expire_time = ExpireTime} | Acc]
                    end,
                    ShopGoodsL = lists:foldl(F, [], data_op_shop:get(No)),
                    lib_shop:refresh_op_shop_goods(CurUnixTime, ShopGoodsL),
                    State
            end
    end.


refresh_shop_goods(CurUnixTime) ->
    ActivityFlag = mod_admin_activity:is_festival_activity_alive(10),

    F0 = fun(GoodsNo) ->
        case ActivityFlag of
            false ->
                data_shop:get(GoodsNo);
            true ->
                data_shop_discount:get(GoodsNo)
        end
    end,

    TypeList = 
        case ActivityFlag of
            false ->
                data_shop:get_shop_goods_type_list();
            true ->
                data_shop_discount:get_shop_goods_type_list()
        end,

    F = fun(Type, Acc) ->
        case Type =:= 0 of
            true -> Acc;
            false ->
                case lists:member(Type, TypeList) of
                    false -> Acc;
                    true -> 
                        case ActivityFlag of
                            false ->
                                data_shop:get_shop_goods_no_list_by_type(Type) ++ Acc;
                            true ->
                                data_shop_discount:get_shop_goods_no_list_by_type(Type) ++ Acc
                        end
                end
        end
    end,

    DynamicShopGoodsNoL = lists:foldl(F, [], TypeList),

    ShopGoodsL = [F0(X) || X <- DynamicShopGoodsNoL],
    lib_shop:refresh_shop_goods(CurUnixTime, ShopGoodsL).


try_get_dynamic_goods_list(PS) ->
    ActivityFlag = mod_admin_activity:is_festival_activity_alive(10),

    TypeList = 
        case ActivityFlag of
            false -> data_shop:get_shop_goods_type_list();
            true -> data_shop_discount:get_shop_goods_type_list() 
        end,
        
    F = fun(Type, Acc) ->
        case Type =:= 0 of
            true -> Acc;
            false ->
                case lists:member(Type, TypeList) of
                    false -> Acc;
                    true -> 
                        case ActivityFlag of
                            false ->
                                data_shop:get_shop_goods_no_list_by_type(Type) ++ Acc;
                            true ->
                                data_shop_discount:get_shop_goods_no_list_by_type(Type) ++ Acc
                        end
                end
        end
    end,

    DynamicShopGoodsNoL = lists:foldl(F, [], TypeList),
    F1 = fun(GoodsNo, Acc) ->
        case lib_shop:get_dynamic_shop_goods(GoodsNo) of
            null ->
                GoodsShop = 
                    case ActivityFlag of
                        false -> data_shop:get(GoodsNo);
                        true -> data_shop_discount:get(GoodsNo)
                    end,

                case GoodsShop =:= null of
                    true -> Acc;
                    false -> 
                        case GoodsShop#shop_goods.vip_lv_need =:= -1 andalso player:get_vip_lv(PS) > 0 of
                            true -> Acc;
                            false -> [GoodsShop | Acc]
                        end
                end;
            GoodsShop -> [GoodsShop | Acc]
        end
    end,

    ShopGoodsInfoL = lists:foldl(F1, [], DynamicShopGoodsNoL),

    {ok, BinData} = pt_52:write(?PT_QUERY_DYNAMIC_GOODS_IN_SHOP, [player:get_id(PS), ShopGoodsInfoL]),
    lib_send:send_to_sock(PS, BinData).