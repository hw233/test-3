%%%--------------------------------------------------------
%%% @author Lzz <liuzhongzheng2012@gmail.com>
%%% @doc 挖宝
%%%
%%% @end
%%%--------------------------------------------------------

-module(mod_dig_treasure).

-export([dig/2]).
-export([test_dig/2, test_dig/3]).

-include("common.hrl").
-include("effect.hrl").
-include("reward.hrl").
-include("pt_15.hrl").
-include("goods.hrl").
-include("sys_code.hrl").
-include("log.hrl").
-include("monster.hrl").


-define(BATTLE_DELAY, 5).
-define(MAX_ALLOW_MON, 170).

dig(Goods_no, PS) ->
    UID = player:id(PS),
    case ply_sys_open:is_open(UID, ?SYS_DIG_TREASURE) of
        ?true ->
            Treasure = rand_treasure(Goods_no),
            effect(Goods_no, Treasure, PS),
            %挖宝通知成就
            mod_achievement:notify_achi(dig, [], PS);
        _ ->
            skip
    end.

% 1.奖励包
% 2.奖励池
% 3.战斗
% 4.触发刷出明雷怪

effect(GoodsNo, #dig_treasure{event=1, reward=Pkg}, PS) ->
    #reward_dtl{calc_goods_list=GList} = lib_reward:calc_reward_to_player(PS, Pkg),
    send_result(1, GList, 0, GoodsNo, PS),
    % bcast_item_dig(GList, PS),
    give_reward(GoodsNo, GList, PS);

effect(GoodsNo, #dig_treasure{event=2, reward=No}, PS) ->
    #reward_dtl{calc_goods_list=GList} = mod_reward_pool:calc_reward(No, PS),
    send_result(2, GList, 0, GoodsNo, PS),
    % bcast_item_dig(GList, PS),
    give_reward(GoodsNo, GList, PS);

effect(GoodsNo, #dig_treasure{event=3, para=BMonGroupNos}, PS) ->
    Lv = player:get_lv(PS),
    BMonGroupNo = ply_battle:pick_bmon_group_by_fit_lv(Lv, BMonGroupNos),
    send_result(3, [], 0, GoodsNo, PS),
    mod_battle:start_mf(PS, BMonGroupNo, null);

effect(GoodsNo, #dig_treasure{event=EID, reward=No ,para={MonNos, Num, Locs}}, PS)
        when EID =:= 4 orelse EID =:= 5 orelse EID =:= 6 ->  

    case No of
        0 ->
            nothing;
        _ ->
            #reward_dtl{calc_goods_list=GList} = mod_reward_pool:calc_reward(No, PS),
            send_result(2, GList, 0, GoodsNo, PS),
            % bcast_item_dig(GList, PS),
            give_reward(GoodsNo, GList, PS)
    end,

    Mon = list_rand(MonNos),

    [SceneId|Area] = list_rand(Locs),
    case lib_scene:get_scene_mon_count(SceneId) of
        MonCount when MonCount < ?MAX_ALLOW_MON ->
            F = fun() -> mod_scene:spawn_mon_to_scene_for_public_WNC(Mon, SceneId, list_rand(Area)) end,
            SpawnNum = min(Num, ?MAX_ALLOW_MON - MonCount),
            [F() || _ <- lists:seq(1, SpawnNum)];
        _ ->
            skip
    end,

    case data_mon:get(Mon) of
        null ->
            ?ERROR_MSG("lib_goods_eff:data error!MonNo:~p~n", [Mon]);
        MonInfo when is_record(MonInfo,mon_tpl) ->
           bcast_monster_release(EID,MonInfo#mon_tpl.name, SceneId, PS) ;
        _O ->
            ?ERROR_MSG("lib_goods_eff:data error!MonNo:~p,~p~n", [Mon,_O])
    end,

    send_result(EID, [], SceneId, GoodsNo, PS);

effect(_GoodsNo, _E, _PS) ->
    ?WARNING_MSG("Invalid dig effect ~p", [_E]).


give_reward(CostGoodsNo, GList, PS) ->
    UID = player:id(PS),
    ?DEBUG_MSG("GList~p",[GList]), 
    F = fun(Para, _) ->
            case Para of
                {GoodsNo, GoodsCount, Quality, BindState,NeedBroadcast} ->
                    Goods = mod_inv:batch_smart_add_new_goods(UID,
                                              [{GoodsNo, GoodsCount}],
                                              [{quality, Quality}, {bind_state, BindState}],
                                              [?LOG_DIG_TREASURE, CostGoodsNo]),

                    case Goods of
                        {ok, RetGoods} ->
                            % Goods1 = lists:last(RetGoods),
                            % % ?DEBUG_MSG("Goods1=~p",[Goods1]),
                            % {GoodsId ,_,_ }=Goods1,
                            case NeedBroadcast of
                                0 -> skip;
                                _ -> mod_broadcast:send_sys_broadcast(NeedBroadcast, [player:get_name(PS), player:id(PS), GoodsNo, Quality, GoodsCount,0])
                            end;
                        _ -> skip
                    end,

                    Goods;
                    
                {GoodsNo, GoodsCount, Quality, BindState} ->
                    Goods = mod_inv:batch_smart_add_new_goods(UID,
                                              [{GoodsNo, GoodsCount}],
                                              [{quality, Quality}, {bind_state, BindState}],
                                              [?LOG_DIG_TREASURE, CostGoodsNo]),
                    Goods
            end
        end,
    lists:foldl(F, 0, GList).

rand_treasure(Goods_no) ->
    List = [data_dig_treasure:get(I) || I <- data_dig_treasure:get_all_event_no()],
    List1 = [G || #dig_treasure{gid=GID}=G <- List, GID =:= Goods_no],
    util:rand_by_weight(List1, #dig_treasure.prob).

send_result(Event, GList, SceneID, GoodsNo, PS) ->
    UID = player:id(PS),
    {ok, Bin} = pt_15:write(?PT_DIG_TREASURE_RESULT, [Event, GList, SceneID, GoodsNo]),
    lib_send:send_to_uid(UID, Bin).

bcast_monster_release(EID, MonName,SceneID, PS) ->
    UID = player:id(PS),
    Name = player:get_name(PS),
    case EID of
        4 ->
            mod_broadcast:send_sys_broadcast(106, [Name, UID,MonName, SceneID]); % 挖宝的时候放妖了
        5 ->
            mod_broadcast:send_sys_broadcast(108, [Name, UID,MonName, SceneID]); % 挖宝放BB了
        6 ->
            mod_broadcast:send_sys_broadcast(293, [Name, UID,MonName, SceneID]) % 充值放妖
    end.


bcast_item_dig([Goods|T], PS) ->
    GoodsNo = lib_goods:get_no(Goods),
    Quality = lib_goods:get_quality(Goods),
    GoodsId = lib_goods:get_id(Goods),

    UID = player:id(PS),
    Name = player:get_name(PS),

    case lists:member(GoodsNo, [60177, 60178, 60179, 60180, 60181]) of
        true ->
            % 挖宝挖到以下ID的物品：60177、60178、60179、60180、60181
            mod_broadcast:send_sys_broadcast(107, [Name, UID, GoodsNo, Quality, 1,GoodsId]);
        false ->
            case Quality >= ?QUALITY_PURPLE of
                true ->
                    % 挖宝挖到紫色以上的物品，item需要显示对应品质的颜色和显示数量。同时要有过滤ID的功能，遇到以下ID则发此条消息：60177、60178、60179、60180、60181
                    mod_broadcast:send_sys_broadcast(109, [Name, UID, GoodsNo, Quality, 1]); 
                _ ->
                    skip
            end
    end,

    bcast_item_dig(T, PS);
bcast_item_dig([], _) ->
    ok.

list_rand(List) ->
    lists:nth(util:rand(1, length(List)), List).

test_dig(No, PS) ->
    Data = data_dig_treasure:get(No),
    effect(No, Data, PS).

test_dig(No, GoodsNo, PS) ->
    _Data = data_dig_treasure:get(No),
    dig(GoodsNo, PS).