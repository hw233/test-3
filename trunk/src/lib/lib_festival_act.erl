%%%------------------------------------
%%  lib_festival_act.erl

%%% @author zhangwq
%%% @copyright UCweb 2015.1.19
%%% @doc 节日小活动相关逻辑处理
%%% @end
%%%------------------------------------

-module(lib_festival_act).

-include("abbreviate.hrl").
-include("activity_degree_sys_2.hrl").
-include("prompt_msg_code.hrl").
-include("admin_activity.hrl").
-include("log.hrl").
-include("debug.hrl").
-include("common.hrl").
-include("pt_34.hrl").
-include("goods.hrl").

-compile(export_all).


%%***************************************** 采集场景红包**************************************
%% return {fail, Reason} | {ok, GoodsNo, GoodsCount}
get_goods_by_firework(PS, GoodsNo, CntLimit, NpcId) ->
    case catch check_get_goods_by_firework(PS, GoodsNo, CntLimit) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, ActSet} ->
            do_get_goods_by_firework(PS, GoodsNo, NpcId, ActSet)
    end.


check_get_goods_by_firework(PS, GoodsNo, CntLimit) ->
    ActSet = check_common(PS, ?AD_FIREWORKS),
    
    Now = util:unixtime(),
    ?Ifc (Now - get_last_get_goods_by_fireworks_time() < 3)
        throw({fail, ?PM_F_ACT_PLEASE_WAIT})
    ?End,

    ?Ifc (get_goods_cnt_by_fw(?AD_FIREWORKS, player:id(PS)) >= CntLimit)
        throw({fail, ?PM_F_ACT_CNT_LIMIT})
    ?End,

    case mod_inv:check_batch_add_goods(player:get_id(PS), [{GoodsNo, 1}]) of
        {fail, Reason} -> throw({fail, Reason});
        ok -> {ok, ActSet}
    end.

do_get_goods_by_firework(PS, GoodsNo, NpcId, ActSet) ->
    set_last_get_goods_by_fireworks_time(util:unixtime()),
    mod_scene:clear_dynamic_npc_from_scene_WNC(NpcId),

    PlobLData = [{goods_cnt, get_goods_cnt_by_fw(?AD_FIREWORKS, player:id(PS)) + 1}],
    ply_activity:set(player:id(PS), ?AD_FIREWORKS, PlobLData), %% 需要用宏

    {ok, GoodsNo, 1, [{expire_time, ActSet#admin_sys_set.end_time}, {bind_state, ?BIND_ALREADY}]}.


get_goods_cnt_by_fw(ActNo, PlayerId) ->
    case ply_activity:get(PlayerId, ActNo) of %% 需要用宏
        null -> 0;
        PlobList ->
            case lists:keyfind(goods_cnt, 1, PlobList) of
                false -> 0;
                {_, Cnt} -> Cnt
            end
    end.


daily_reset(PS) ->
    ply_activity:set(player:id(PS), ?AD_FIREWORKS, []),
    ply_activity:set(player:id(PS), ?AD_BRESS, []).


get_last_get_goods_by_fireworks_time() ->
    case get(get_goods_by_fireworks_time) of
        undefined -> 0;
        Rd -> Rd
    end.

set_last_get_goods_by_fireworks_time(TimeStamp) ->
    put(get_goods_by_fireworks_time, TimeStamp).


%% 为放礼花执行脚本 （从活动开始后的第二天才再次执行）
new_day_comes() ->
    case mod_admin_activity:get_admin_set_rd(?AD_FIREWORKS - 1000) of
        null ->
            ?DEBUG_MSG("lib_festival_act,Act:~p over ~n", [?AD_FIREWORKS - 1000]);
        ActSet ->
            case util:is_same_day(ActSet#admin_sys_set.start_time) of
                true ->
                    ?DEBUG_MSG("lib_festival_act,Act:~p is_same_day ~n", [?AD_FIREWORKS - 1000]);
                false ->
                    Now = util:unixtime(),
                    case Now < ActSet#admin_sys_set.end_time andalso ActSet#admin_sys_set.start_time < Now of
                        true ->
                            ?CRITICAL_MSG("lib_festival_act:new_day_comes Act:~p~n", [?AD_FIREWORKS - 1000]),
                            mod_admin_activity:exec_script_for_act(?AD_FIREWORKS - 1000);
                        false ->
                            ?DEBUG_MSG("lib_festival_act,Act:~p over ~n", [?AD_FIREWORKS - 1000])
                    end
            end
    end.    


%% **************************************领取拜年红包***********************************8

get_year_goods(PS) ->
    case catch check_get_year_goods(PS) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, ActSet} ->
            do_get_year_goods(PS, ActSet)
    end.

check_get_year_goods(PS) ->
    ActSet = check_common(PS, ?AD_BAINIAN),

    Ret = lists:keyfind(give_goods, 1, ActSet#admin_sys_set.script),
    ?Ifc (Ret =:= false)
        throw({fail, ?PM_DATA_CONFIG_ERROR})
    ?End,

    {give_goods, GoodsNo, CntLimit} = Ret,

    ?Ifc (get_goods_cnt_by_fw(?AD_BAINIAN, player:id(PS)) >= CntLimit)
        throw({fail, ?PM_HAVE_GET_THE_REWARD})
    ?End,

    case mod_inv:check_batch_add_goods(player:get_id(PS), [{GoodsNo, 1}]) of
        {fail, Reason} -> throw({fail, Reason});
        ok -> {ok, ActSet}
    end.

do_get_year_goods(PS, ActSet) ->
    {give_goods, GoodsNo, _CntLimit} = lists:keyfind(give_goods, 1, ActSet#admin_sys_set.script),
    ExpireTime = ActSet#admin_sys_set.end_time,
    mod_inv:batch_smart_add_new_goods(player:get_id(PS), [{GoodsNo, 1}], [{bind_state, ?BIND_ALREADY}, {expire_time, ExpireTime}], [?LOG_GOODS, "spring_fes_act"]),

    PlobLData = [{goods_cnt, get_goods_cnt_by_fw(?AD_BAINIAN, player:id(PS)) + 1}],
    ply_activity:set(player:id(PS), ?AD_BAINIAN, PlobLData), %% 需要用宏
    ok.


%% *******************************************节日祝福*************************************************

give_gift(PS, PlayerId, BlessingNo, Type) ->
    case catch check_give_gift(PS, PlayerId, BlessingNo, Type) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, GoodsNo} ->
            do_give_gift(PS, PlayerId, BlessingNo, Type, GoodsNo)
    end.


check_give_gift(PS, PlayerId, _BlessingNo, Type) ->
    ?Ifc (not lists:member(Type, [1,2]))
        throw({fail, ?PM_PARA_ERROR})
    ?End,

    ?Ifc (PlayerId =< 0)
        throw({fail, ?PM_PARA_ERROR})
    ?End,

    ActSet = check_common(PS, ?AD_BRESS),

    Ret = lists:keyfind(give_goods, 1, ActSet#admin_sys_set.script),
    ?Ifc (Ret =:= false)
        throw({fail, ?PM_DATA_CONFIG_ERROR})
    ?End,

    RetHigh = lists:keyfind(give_goods_high, 1, ActSet#admin_sys_set.script),
    ?Ifc (RetHigh =:= false)
        throw({fail, ?PM_DATA_CONFIG_ERROR})
    ?End,

    ?Ifc (not lists:member(PlayerId, ply_relation:get_friend_id_list(PS)))
        throw({fail, ?PM_RELA_PLEASE_ADD_FRDS})
    ?End,
    
    TargetPS = player:get_PS(PlayerId), 
    ?Ifc (TargetPS =:= null)
        throw({fail, ?PM_TARGET_PLAYER_NOT_ONLINE})
    ?End,

    ?Ifc (player:get_guild_id(TargetPS) =:= ?INVALID_ID)
        throw({fail, ?PM_F_NO_GUILD})
    ?End,

    {_, GoodsNo, CntLimit} = case Type =:= 1 of true -> Ret; false -> RetHigh end,

    SendList = get_gived_gift(player:id(PS)),
    ?Ifc (length(SendList) >= CntLimit)
        throw({fail, ?PM_F_ACT_DAY_CNT_LIMIT})
    ?End,

    RetFindFrd = lists:keyfind(PlayerId, 1, SendList),
    ?Ifc(RetFindFrd =/= false)
        throw({fail, ?PM_F_ACT_CNT_LIMIT_BETWEEN_FRDS})
    ?End,

    F = fun({_Id, State}, Sum) ->
        case State =:= 0 of
            true -> Sum + 1;
            false -> Sum
        end
    end,
    Counter = lists:foldl(F, 0, SendList),
    ?Ifc (Counter >= 2)
        throw({fail, ?PM_F_ACT_BLESS_WAIT})
    ?End,

    case catch gen_server:call(player:get_pid(PlayerId), {apply_call, ?MODULE, check_gift_count, [PlayerId, Type]}) of
        {fail, ErrCode} -> throw({fail, ErrCode});
        ok -> {ok, GoodsNo};
        _ -> throw({fail, ?PM_MK_FAIL_SERVER_BUSY})
    end.


do_give_gift(PS, PlayerId, BlessingNo, Type, GoodsNo) ->
    case Type of
        1 -> player:cost_money(PS, ?MNY_T_BIND_GAMEMONEY, 200000, []);
        2 -> player:cost_money(PS, ?MNY_T_YUANBAO, 100, [])
    end,
    
    %% 设置我送出的礼物数据
    case ply_activity:get(player:id(PS), ?AD_BRESS) of %% 需要用宏
        null -> 
            ply_activity:set(player:id(PS), ?AD_BRESS, [{gived_gift, [{PlayerId, 0}]}]);
        PlobList ->    
            NewInfo = 
                case lists:keyfind(gived_gift, 1, PlobList) of
                    false -> {gived_gift, [{PlayerId, 0}]};
                    {_, List} -> {gived_gift, [{PlayerId, 0} | List]}
                end,
            NewActData = lists:keystore(gived_gift, 1, PlobList, NewInfo),
            ply_activity:set(player:id(PS), ?AD_BRESS, NewActData)
    end,
    lib_offcast:cast(PlayerId, {'update_act_data', ?AD_BRESS, [{add_my_gift, GoodsNo, BlessingNo, player:id(PS), Type}]}),
    Title = <<"通知">>,
    Content = list_to_binary(io_lib:format(<<"~s 给您寄了一份节日礼物，赶快到帮派里的吉祥树领取吧。(没有收取的礼物，在当天晚上24点将会被系统自动回收)">>, [player:get_name(PS)])),
    lib_mail:send_sys_mail(PlayerId, Title, Content, [], []),

    lib_log:statis_role_action(PS, [], ?LOG_SPRING_FES_ACT, "bress", [Type, player:id(PS), PlayerId]),
    ok.


get_gift(PS) ->
    case catch check_get_gift(PS) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, GiftL, ActSet} ->
            do_get_gift(PS, GiftL, ActSet)
    end.


check_common(PS, ActNo) ->
    ActCfg = mod_admin_activity:get_festival_config_data(ActNo - 1000),
    ?Ifc (ActCfg =:= null)  
        throw({fail, ?PM_DATA_CONFIG_ERROR})
    ?End,

    ?Ifc (player:get_lv(PS) < ActCfg#festival_activity_data.lv)
        throw({fail, ?PM_LV_LIMIT})
    ?End,

    %% 时间判断
    Now = util:unixtime(),
    ActSet = mod_admin_activity:get_admin_set_rd(ActNo - 1000),
    ?Ifc (ActSet =:= null)
        throw({fail, ?PM_F_ACT_NOT_START})
    ?End,

    ?Ifc (ActSet#admin_sys_set.end_time < Now)
        throw({fail, ?PM_F_ACT_NOT_START})
    ?End,

    ?Ifc (ActSet#admin_sys_set.start_time > Now)
        throw({fail, ?PM_F_ACT_NOT_START})
    ?End,
    ActSet.


check_get_gift(PS) ->
    ActSet = check_common(PS, ?AD_BRESS),
    GiftL = get_my_gift(player:id(PS)),
    ?DEBUG_MSG("lib_festival_act:GiftL~p~n", [GiftL]),
    ?Ifc (GiftL =:= [])
        throw({fail, ?PM_F_ACT_GIFT_OVER})
    ?End,

    GoodsL = [{GoodsNo, 1} || {GoodsNo, _BlessingNo, _FromPlayerId} <- GiftL],

    case mod_inv:check_batch_add_goods(player:get_id(PS), GoodsL) of
        {fail, Reason} -> throw({fail, Reason});
        ok -> {ok, GiftL, ActSet}
    end.



do_get_gift(PS, GiftL, ActSet) ->
    case ply_activity:get(player:id(PS), ?AD_BRESS) of %% 需要用宏
        null -> 
            ?ERROR_MSG("lib_festival_act:get data error!~p~n", [player:id(PS)]);
        PlobList ->    
            NewInfo = 
                case lists:keyfind(my_gift, 1, PlobList) of
                    false -> 
                        ?ERROR_MSG("lib_festival_act:get data error!~p~n", [player:id(PS)]),
                        {my_gift, [], 0, 0};
                    {_, _List, Counter1, Counter2} -> {my_gift, [], Counter1, Counter2}
                end,
            NewActData = lists:keystore(my_gift, 1, PlobList, NewInfo),
            ply_activity:set(player:id(PS), ?AD_BRESS, NewActData)
    end,

    ExpireTime = ActSet#admin_sys_set.end_time,
    PlayerName = player:get_name(PS),
    Title = <<"通知">>,
    F = fun({GoodsNo, BlessingNo, FromPlayerId}) ->
        lib_offcast:cast(FromPlayerId, {'update_act_data', ?AD_BRESS, [{flag_gived_gift, player:id(PS)}]}),
        mod_inv:batch_smart_add_new_goods(player:get_id(PS), [{GoodsNo, 1}], [{expire_time, ExpireTime}, {extra, {gift, [FromPlayerId, BlessingNo]}}, {bind_state, ?BIND_ALREADY}], [?LOG_GOODS, "spring_fes_act"]),
        Content = list_to_binary(io_lib:format(<<"您的朋友 ~s 已经收取了礼物，如果您今天送出的礼物未达到10份的话，可以继续包装礼物赠送朋友啦！">>, [PlayerName])),
        lib_mail:send_sys_mail(FromPlayerId, Title, Content, [], [])
    end,
    [F(X) || X <- GiftL],
    ok.


tst_set_gived_cnt(PS, Type, Cnt) ->
    PlayerId = player:id(PS),
    case ply_activity:get(PlayerId, ?AD_BRESS) of %% 需要用宏
            null -> 
                case Type of
                    1 ->
                        ply_activity:set(PlayerId, ?AD_BRESS, [{my_gift, [], Cnt, 0}]);
                    2 ->
                        ply_activity:set(PlayerId, ?AD_BRESS, [{my_gift, [], 0, Cnt}])
                end;
            PlobList ->    
                NewInfo = 
                    case lists:keyfind(my_gift, 1, PlobList) of
                        false -> 
                            case Type of
                                1 -> {my_gift, [], Cnt, 0};
                                2 -> {my_gift, [], 0, Cnt}
                            end;
                        {_, List, Counter1, Counter2} -> 
                            case Type of
                                1 -> {my_gift, List, Cnt, Counter2};
                                2 -> {my_gift, List, Counter1, Cnt}
                            end
                    end,
                NewActData = lists:keystore(my_gift, 1, PlobList, NewInfo),
                ply_activity:set(PlayerId, ?AD_BRESS, NewActData)
        end.


update_act_data(PlayerId, ProbListPara) ->
    F = fun(Para) ->
        case Para of
            {add_my_gift, GoodsNo, BlessingNo, FromPlayerId, Type} ->
                case ply_activity:get(PlayerId, ?AD_BRESS) of %% 需要用宏
                    null -> 
                        case Type of
                            1 ->
                                ply_activity:set(PlayerId, ?AD_BRESS, [{my_gift, [{GoodsNo, BlessingNo, FromPlayerId}], 1, 0}]);
                            2 ->
                                ply_activity:set(PlayerId, ?AD_BRESS, [{my_gift, [{GoodsNo, BlessingNo, FromPlayerId}], 0, 1}])
                        end;
                    PlobList ->    
                        NewInfo = 
                            case lists:keyfind(my_gift, 1, PlobList) of
                                false -> 
                                    case Type of
                                        1 -> {my_gift, [{GoodsNo, BlessingNo, FromPlayerId}], 1, 0};
                                        2 -> {my_gift, [{GoodsNo, BlessingNo, FromPlayerId}], 0, 1}
                                    end;
                                {_, List, Counter1, Counter2} -> 
                                    case Type of
                                        1 -> {my_gift, [{GoodsNo, BlessingNo, FromPlayerId} | List], Counter1 + 1, Counter2};
                                        2 -> {my_gift, [{GoodsNo, BlessingNo, FromPlayerId} | List], Counter1, Counter2+1}
                                    end
                            end,
                        NewActData = lists:keystore(my_gift, 1, PlobList, NewInfo),
                        ply_activity:set(PlayerId, ?AD_BRESS, NewActData)
                end;
            {flag_gived_gift, Id} ->
                case ply_activity:get(PlayerId, ?AD_BRESS) of %% 需要用宏
                    null -> 
                        skip;
                    PlobList ->    
                        NewInfo = 
                            case lists:keyfind(gived_gift, 1, PlobList) of
                                false -> {gived_gift, []};
                                {_, List} -> {gived_gift, lists:keyreplace(Id, 1, List, {Id, 1})}
                            end,
                        NewActData = lists:keystore(gived_gift, 1, PlobList, NewInfo),
                        ply_activity:set(PlayerId, ?AD_BRESS, NewActData)
                end;
            _ -> skip
        end
    end,
    [F(X) || X <- ProbListPara].


%% 获取已经送出的礼物列表 [{PlayerId, State}]  其中State=0表示对方还没有领取，1表示对方已经领取
get_gived_gift(PlayerId) ->
    case ply_activity:get(PlayerId, ?AD_BRESS) of %% 需要用宏
        null -> [];
        PlobList ->
            case lists:keyfind(gived_gift, 1, PlobList) of
                false -> [];
                {_, List} -> List
            end
    end.

%% 获取我的礼物列表 [{GoodsNo, BlessingNo, FromPlayerId}]
get_my_gift(PlayerId) ->
    case ply_activity:get(PlayerId, ?AD_BRESS) of %% 需要用宏
        null -> [];
        PlobList ->
            case lists:keyfind(my_gift, 1, PlobList) of
                false -> [];
                {_, List, _Counter1, _Counter2} -> List
            end
    end.

show_bress(PS, BlessingNo, FromPlayerId) ->
    FromPlayerName = player:get_name(FromPlayerId),
    {ok, BinData} = pt_34:write(?PT_AD_SHOW_BRESS, [BlessingNo, FromPlayerId, FromPlayerName]),
    lib_send:send_to_sock(PS, BinData).


check_gift_count(PlayerId, Type) ->
    case ply_activity:get(PlayerId, ?AD_BRESS) of %% 需要用宏
        null -> ok;
        PlobList ->
            case lists:keyfind(my_gift, 1, PlobList) of
                false -> ok;
                {_, _List, Counter1, Counter2} -> 
                    case Type of
                        1 -> 
                            case Counter1 >= 20 of
                                false -> ok;
                                true -> {fail, ?PM_F_GIFT_COUNT_LIMIT_1}
                            end;
                        2 ->
                            case Counter2 >= 20 of
                                false -> ok;
                                true -> {fail, ?PM_F_GIFT_COUNT_LIMIT_2}
                            end
                    end
            end
    end.