%%%-----------------------------------
%%% @Module  : lib_npc
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2013.6.17
%%% @Description: npc的采集动态商店刷新相关函数
%%%-----------------------------------
-module(lib_npc).
-export([
        collect_from_npc/2,
        refresh_npc_shop/2
    ]).

-include("npc.hrl").
-include("prompt_msg_code.hrl").
-include("debug.hrl").
-include("common.hrl").
-include("ets_name.hrl").
-include("trade.hrl").
-include("log.hrl").


collect_from_npc(PS, NpcId) ->
    case check_collect_from_npc(PS, NpcId) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, GoodsNo, GoodsCount} ->
            do_collect_from_npc(PS, NpcId, GoodsNo, GoodsCount);
        {ok, GoodsNo, GoodsCount, ExtraInfoL} ->
            do_collect_from_npc(PS, NpcId, GoodsNo, GoodsCount, ExtraInfoL)
    end.

refresh_npc_shop(_CurUnixTime, []) ->
    skip;
refresh_npc_shop(CurUnixTime, [NpcShopNo | T]) ->
    case ply_trade:get_goods_list_by_npc_shop_no(NpcShopNo) of
        [] -> 
            refresh_npc_shop(CurUnixTime, T);
        NpcShopGoodsList->
            lib_shop:refresh_shop_goods(CurUnixTime, NpcShopGoodsList),
            refresh_npc_shop(CurUnixTime, T)
    end.

%% ================================ Local fun =============================================


%% 
check_collect_from_npc(PS, NpcId) ->
    % GoodsCount = util:rand(1, 3),
    GoodsCount = 1,
    case mod_npc:get_obj(NpcId) of
        null ->
            {fail, ?PM_NPC_NOT_EXISTS};
        Npc ->
            case mod_npc:get_npc_collect_info(Npc) of
                null -> 
                    ?TRACE("lib_npc:check_collect_from_npc() get_npc_collect_info null\n"),
                    {fail, ?PM_PARA_ERROR};
                {TaskIdList, GoodsNo} when is_list(TaskIdList) ->
                    case is_collect_data_valid(PS, TaskIdList) andalso data_goods:get(GoodsNo) /= null of
                        false ->
                            ?TRACE("lib_npc:check_collect_from_npc() is_collect_data_valid false TaskIdList:~p, GoodsNo:~p~n", [TaskIdList, GoodsNo]),
                            {fail, ?PM_PARA_ERROR};
                        true ->
                            case mod_inv:check_batch_add_goods(player:get_id(PS), [{GoodsNo, GoodsCount}]) of
                                {fail, Reason} -> {fail, Reason};
                                ok -> {ok, GoodsNo, GoodsCount}
                            end
                    end;
                {CntLimit, GoodsNo} ->
                    case data_goods:get(GoodsNo) of
                        null ->
                            {fail, ?PM_PARA_ERROR};
                        _ -> 
                            lib_festival_act:get_goods_by_firework(PS, GoodsNo, CntLimit, NpcId)
                    end
            end
    end.


do_collect_from_npc(PS, _NpcId, GoodsNo, GoodsCount) ->
    mod_inv:batch_smart_add_new_goods(player:get_id(PS), [{GoodsNo, GoodsCount}], [?LOG_GOODS, "gather"]),
    ok.

do_collect_from_npc(PS, _NpcId, GoodsNo, GoodsCount, ExtraInfoL) ->
    mod_inv:batch_smart_add_new_goods(player:get_id(PS), [{GoodsNo, GoodsCount}], ExtraInfoL, [?LOG_GOODS, "spring_fes_act"]),
    ok.


is_collect_data_valid(_PS, []) ->
    false;
is_collect_data_valid(PS, [TaskId | T]) ->
    ?TRACE("lib_task:publ_is_accepted_no_complete_list(PS) :~p~n", [lib_task:publ_is_accepted_no_complete_list(PS)]),
    case lists:member(TaskId, lib_task:publ_is_accepted_no_complete_list(PS)) of
        true -> true;
        false -> is_collect_data_valid(PS, T)
    end.


