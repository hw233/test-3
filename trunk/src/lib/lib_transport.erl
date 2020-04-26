-module(lib_transport).

-include("common.hrl").
-include("record.hrl").
-include("transport.hrl").
-include("prompt_msg_code.hrl").
-include("log.hrl").
-include("ets_name.hrl").
-include("activity_degree_sys.hrl").
-include("offline_data.hrl").

-export([
    get_all_transport_truck_info/1,
    push_role_transport_info/1,
    push_single_truck_info/2,
    evolve_truck_with_money/1,
    evolve_truck_with_goods/1,
    direct_evolve_truck/1,
    update_role_transport/1,
    get_role_transport/1,
    update_truck_info/1,
    delete_truck_info/1,
    get_truck_info/1,
    start_transport/1,
    hijack_truck/2,
    login_init/2,
    final_logout/1,
    open_transport_system/1,
    get_config_data/2,
    get_config_data/1,
    add_truck_to_transport_cache/1,
    publ_add_news/2,
    add_news/2,
    make_transport_new_by_event/1,
    make_transport_new/4,
    refresh_truck/1,
    get_already_join_times/1,
    get_max_join_times/1,
    evolve_truck_free/1
    ]).
% -compile(export_all).



%% @doc 上线初始化
login_init(_, role_in_cache) -> skip;
login_init(Status, _) ->
    case player:get_lv(Status) >= (ply_sys_open:get_sys_open_lv(?TS_TRUCK_SYSCODE) - 1) of
        false -> skip;
        true -> 
            RoleId = player:id(Status),
            case db:select_row(role_transport, "truck_lv, transport_times, hijack_times, refresh_times, days_count, news, attentives, free_times", 
                [{role_id, RoleId}]) of
                [] -> init_role_transport(Status);
                [TruckLv, TsTimes, HijackTimes, Rtimes, Days, News, Attentives, FreeTimes] ->
                    update_role_transport(
                        #role_transport{
                            role_id = RoleId
                            ,truck_lv = TruckLv                           % 镖车等级
                            ,transport_times = TsTimes                    % 运输次数
                            ,hijack_times = HijackTimes                       % 劫车次数
                            ,refresh_times = Rtimes                      % 刷新次数
                            ,days_count = Days                          % 日数
                            ,news = util:bitstring_to_term(News)                              % 新闻
                            ,attentives = util:bitstring_to_term(Attentives)         % 关注列表 (玩家ID)
                            ,free_times = FreeTimes
                        })
            end
    end.


%% @doc 下线保存
final_logout(Status) ->
    case player:get_lv(Status) >= ply_sys_open:get_sys_open_lv(?TS_TRUCK_SYSCODE) of
        false -> skip;
        true -> 
            case get_role_transport(player:id(Status)) of
                Transport when is_record(Transport, role_transport) -> 
                    del_role_transport(player:id(Status)),
                    db_update_role_transport(Transport);
                _ -> skip
            end
    end.


%% @doc 等级到达开启运镖
open_transport_system(Status) -> 
    case ply_sys_open:is_open(Status, ?TS_TRUCK_SYSCODE) of
        false -> skip;
        true -> 
            ?LDS_TRACE(open_transport_system),
            case get_role_transport(player:id(Status)) of
                Transport when is_record(Transport, role_transport) -> skip;
                _ -> init_role_transport(Status)
            end
    end.



update_role_transport(Transport) when is_record(Transport, role_transport) ->
    ets:insert(?ETS_ROLE_TRANSPORT, Transport).


%% @doc 取得个人运镖信息
%% @return : #role_transport{} | null
get_role_transport(RoleId) ->
    case ets:lookup(?ETS_ROLE_TRANSPORT, RoleId) of
        [Transport | _] when is_record(Transport, role_transport) -> 
            NowDays = util:get_now_days(),
            case Transport#role_transport.days_count =:= NowDays of
                true -> Transport;
                false -> 
                    NewTransport = Transport#role_transport{days_count = NowDays, refresh_times = 0, 
                        hijack_times = 0, transport_times = 0, free_times = 0},
                    update_role_transport(NewTransport),
                    NewTransport
            end;
        _ -> null
    end.


%% @doc 推送个人运镖信息
push_role_transport_info(Status) when is_record(Status, player_status) ->
    case get_role_transport(player:id(Status)) of
        Transport when is_record(Transport, role_transport) -> 
            FreeTimes = get_max_free_times(Status) - Transport#role_transport.free_times,
            {ok, BinData} = pt_42:write(42005, [Transport#role_transport.truck_lv, Transport#role_transport.transport_times, 
                ?TS_MAX_TRANSPORT_TIMES, get_transport_goods_num(Status), get_transport_state(player:id(Status)), 
                ?BIN_PRED(FreeTimes >= 0, FreeTimes, 0)]),
            % ?LDS_TRACE(push_role_transport_info, [BinData]),
            lib_send:send_to_uid(player:id(Status), BinData);
        _ -> lib_send:send_prompt_msg(Status, ?PM_TS_INFO_NOTEXISTS)
    end.


%% @doc 取得镖车信息
%% @return : #truck{} | null
get_truck_info(RoleId) ->
    case ets:lookup(?ETS_TRUCK_INFO, RoleId) of
        [Truck | _] when is_record(Truck, truck) -> Truck;
        _ -> null
    end.


%% @doc 推送指定镖车协议信息
push_single_truck_info(Status, Truck) when is_record(Truck, truck) ->
    {ok, BinData} = pt_42:write(42004, [pack_truck_info(Truck)]),
    lib_send:send_to_uid(player:id(Status), BinData).


%% @doc 刷新镖车
refresh_truck(Status) -> 
    case get_role_transport(player:id(Status)) of
        Transport when is_record(Transport, role_transport) -> 
            case get_config_data(player:get_lv(Status), Transport#role_transport.truck_lv) of
                ConfigData when is_record(ConfigData, transport_data) ->
                    case player:has_enough_money(Status, ConfigData#transport_data.refresh_money_type, ConfigData#transport_data.refresh_money_num) of 
                        true ->
                            player:cost_money(Status, ConfigData#transport_data.refresh_money_type, 
                                ConfigData#transport_data.refresh_money_num, [?LOG_TRANSPORT, "fresh"]),
                            NewSets = get_rand_trucks_info(Status, ?TS_TRUCK_LIMIT_NUM),
                            update_role_transport(Transport#role_transport{attentives = NewSets}),
                            get_all_transport_truck_info(Status, 42011);
                        false -> lib_send:send_prompt_msg(Status, ?PM_MONEY_LIMIT)
                    end;
                _ -> lib_send:send_prompt_msg(Status, ?PM_DATA_CONFIG_ERROR)
            end;
        _ -> lib_send:send_prompt_msg(Status, ?PM_TS_INFO_NOTEXISTS)
    end.


%% 免费进阶镖车
evolve_truck_free(Status) ->
    case get_role_transport(player:id(Status)) of
        Transport when is_record(Transport, role_transport) -> 
            case Transport#role_transport.truck_lv < ?TS_TRUCK_LIMIT_LV of
                true ->
                    case Transport#role_transport.free_times >= get_max_free_times(Status) of
                        true -> lib_send:send_prompt_msg(Status, ?PM_TS_FREE_TIMESOUT);
                        false ->
                            case get_config_data(player:get_lv(Status), Transport#role_transport.truck_lv) of
                                ConfigData when is_record(ConfigData, transport_data) ->
                                    case can_evolve_truck(money, ConfigData) of
                                        true -> 
                                            ?LDS_TRACE(evolve_truck_free, true),
                                            update_role_transport(Transport#role_transport{truck_lv = Transport#role_transport.truck_lv + 1, 
                                                free_times = Transport#role_transport.free_times + 1}),
                                            {ok, BinData} = pt_42:write(42012, [1]),
                                            lib_send:send_to_uid(player:id(Status), BinData);
                                        false -> 
                                            ?LDS_TRACE(evolve_truck_free, false),
                                            update_role_transport(Transport#role_transport{free_times = Transport#role_transport.free_times + 1}),
                                            {ok, BinData} = pt_42:write(42012, [0]),
                                            lib_send:send_to_uid(player:id(Status), BinData)
                                    end;
                                _ -> lib_send:send_prompt_msg(Status, ?PM_DATA_CONFIG_ERROR)
                            end
                    end;
                _ -> lib_send:send_prompt_msg(Status, ?PM_TS_MAX_LV)
            end;
        _ -> lib_send:send_prompt_msg(Status, ?PM_TS_INFO_NOTEXISTS)
    end.





%% 进阶镖车
evolve_truck_with_money(Status) ->
    case get_role_transport(player:id(Status)) of
        Transport when is_record(Transport, role_transport) -> 
            case Transport#role_transport.truck_lv < ?TS_TRUCK_LIMIT_LV of
                true ->
                    case get_config_data(player:get_lv(Status), Transport#role_transport.truck_lv) of
                        ConfigData when is_record(ConfigData, transport_data) ->
                            case player:check_need_price(Status, ConfigData#transport_data.evolve_money_type, ConfigData#transport_data.evolve_money_num) of
                                ok -> 
                                    player:cost_money(Status, ConfigData#transport_data.evolve_money_type, 
                                        ConfigData#transport_data.evolve_money_num, [?LOG_TRANSPORT, "upgrade"]),
                                    case can_evolve_truck(money, ConfigData) of
                                        true -> 
                                            ?LDS_TRACE(evolve_success),
                                            update_role_transport(Transport#role_transport{truck_lv = Transport#role_transport.truck_lv + 1}),
                                            {ok, BinData} = pt_42:write(42007, [1]),
                                            lib_send:send_to_uid(player:id(Status), BinData);
                                        false ->
                                            % 失败等级不降低
                                            % LowLv = ?BIN_PRED(Transport#role_transport.truck_lv =:= 0, 0, Transport#role_transport.truck_lv - 1),
                                            % update_role_transport(Transport#role_transport{truck_lv = LowLv}),
                                            {ok, BinData} = pt_42:write(42007, [0]),
                                            lib_send:send_to_uid(player:id(Status), BinData)
                                    end;
                                Res -> 
                                    lib_send:send_prompt_msg(Status, Res)
                            end;
                        _ -> lib_send:send_prompt_msg(Status, ?PM_DATA_CONFIG_ERROR)
                    end;
                false -> lib_send:send_prompt_msg(Status, ?PM_TS_MAX_LV)
            end;
        _ -> lib_send:send_prompt_msg(Status, ?PM_TS_INFO_NOTEXISTS)
    end.


evolve_truck_with_goods(Status) ->
    RoleId = player:id(Status),
    case get_role_transport(RoleId) of
        Transport when is_record(Transport, role_transport) -> 
            case Transport#role_transport.truck_lv < ?TS_TRUCK_LIMIT_LV of
                true ->
                    case get_transport_goods_num(Status) > 0 of
                        true -> 
                            use_transport_goods(Status, 1),
                            case can_evolve_truck(goods, Status, Transport#role_transport.truck_lv) of
                                true -> 
                                    update_role_transport(Transport#role_transport{truck_lv = Transport#role_transport.truck_lv + 1}),
                                    {ok, BinData} = pt_42:write(42008, [1]),
                                    lib_send:send_to_uid(player:id(Status), BinData);
                                false ->
                                    LowLv = ?BIN_PRED(Transport#role_transport.truck_lv =:= 0, 0, Transport#role_transport.truck_lv - 1),
                                    update_role_transport(Transport#role_transport{truck_lv = LowLv}),
                                    {ok, BinData} = pt_42:write(42008, [0]),
                                    lib_send:send_to_uid(RoleId, BinData)
                            end;
                        false -> 
                            lib_send:send_prompt_msg(Status, ?PM_GOODS_NOT_ENOUGH)
                    end;
                false -> 
                    lib_send:send_prompt_msg(Status, ?PM_TS_MAX_LV)
            end;
        _ -> lib_send:send_prompt_msg(Status, ?PM_TS_INFO_NOTEXISTS)
    end.


%% 直接进阶到最高级
direct_evolve_truck(Status) ->
    RoleId = player:id(Status),
    case get_role_transport(RoleId) of
        Transport when is_record(Transport, role_transport) -> 
            TargetLv = ?TS_TRUCK_LIMIT_LV - 1,
            case Transport#role_transport.truck_lv >= TargetLv of
                true -> skip;
                false ->
                    case get_config_data(player:get_lv(Status), Transport#role_transport.truck_lv) of
                        ConfigData when is_record(ConfigData, transport_data) ->
                            case player:check_need_price(Status, ConfigData#transport_data.direct_evolve_money_type, ConfigData#transport_data.direct_evolve_money_num) of
                                ok -> 
                                    player:cost_money(Status, ConfigData#transport_data.direct_evolve_money_type, 
                                        ConfigData#transport_data.direct_evolve_money_num, [?LOG_TRANSPORT, "upgrade"]),
                                    update_role_transport(Transport#role_transport{truck_lv = TargetLv}),
                                    {ok, BinData} = pt_42:write(42009, [1]),
                                    lib_send:send_to_uid(player:id(Status), BinData);
                                Res -> lib_send:send_prompt_msg(Status, Res)
                            end;
                        _ -> lib_send:send_prompt_msg(Status, ?PM_DATA_CONFIG_ERROR)
                    end
            end;
        _ -> lib_send:send_prompt_msg(Status, ?PM_TS_INFO_NOTEXISTS)
    end.




%% @doc 开始运镖
%% @return : boolean()
start_transport(Status) ->
    RoleId = player:id(Status),

    case get_role_transport(RoleId) of
        Transport when is_record(Transport, role_transport) -> 
            case get_transport_state(RoleId) =:= 0 of
                true ->
                    case Transport#role_transport.transport_times < ?TS_MAX_TRANSPORT_TIMES of
                        true ->
                            case get_config_data(player:get_lv(Status), Transport#role_transport.truck_lv) of
                                ConfigData when is_record(ConfigData, transport_data) ->
                                    case player:check_need_price(Status, ConfigData#transport_data.ts_money_type, ConfigData#transport_data.ts_money_num) of
                                        ok ->
                                            player:cost_money(Status, ConfigData#transport_data.ts_money_type, 
                                                ConfigData#transport_data.ts_money_num, [?LOG_TRANSPORT, "deposit"]),
                                            case make_new_truck(Status, Transport) of
                                                Truck when is_record(Truck, truck) ->
                                                    update_role_transport(Transport#role_transport{
                                                        truck_lv = 0,
                                                        transport_times = Transport#role_transport.transport_times + 1}),
                                                    catch update_transport_offline_bo(Status),
                                                    add_truck_to_transport_cache(Truck),
                                                    catch lib_activity_degree:publ_add_sys_activity_times(?AD_TRANSPORT, Status),
                                                    catch lib_log:start_transport(Status, Truck#truck.truck_lv),
                                                    catch mod_achievement:notify_achi(start_transport, [], Status),
                                                    %完成运镖通知成就
                                                    catch mod_achievement:notify_achi(start_transport_ex, [{no, Truck#truck.truck_lv}], Status),
                                                    true;
                                                _ -> lib_send:send_prompt_msg(Status, ?PM_UNKNOWN_ERR), false
                                            end;
                                        Res -> lib_send:send_prompt_msg(Status, Res), false
                                    end;
                                _ -> lib_send:send_prompt_msg(Status, ?PM_DATA_CONFIG_ERROR)
                            end;
                        false -> lib_send:send_prompt_msg(Status, ?PM_TS_MAX_TRANSPORT), false
                    end;
                false -> lib_send:send_prompt_msg(Status, ?PM_TS_NOT_IN_FREE), false
            end;
        _ -> lib_send:send_prompt_msg(Status, ?PM_TS_INFO_NOTEXISTS), false
    end.


%% @doc 打劫镖车
hijack_truck(Status, TruckId) ->
    RoleId = player:id(Status),
    case player:is_in_team(Status) of
        true -> lib_send:send_prompt_msg(Status, ?PM_TS_TEAM), false;
        false -> 
            case TruckId =:= RoleId of
                true -> lib_send:send_prompt_msg(Status, ?PM_TS_SELF_TRUCK);
                false -> 
                    case get_role_transport(RoleId) of
                        Transport when is_record(Transport, role_transport) -> 
                            case Transport#role_transport.hijack_times >= ?TS_MAX_HIJACK_TIMES of
                                true -> lib_send:send_prompt_msg(Status, ?PM_TS_MAX_HIJACK);
                                false -> 
                                    case get_truck_info(TruckId) of
                                        Truck when is_record(Truck, truck) ->
                                            case lists:member(?TS_EVENT_1, Truck#truck.cur_event) of
                                                true -> lib_send:send_prompt_msg(Status, ?PM_TS_IMMUNE_ATTACK);
                                                false ->
                                                    case Truck#truck.be_hijacked_times >= ?TS_MAX_BE_HIJACKED_TIMES of
                                                        true -> 
                                                            push_single_truck_info(Status, Truck),
                                                            lib_send:send_prompt_msg(Status, ?PM_TS_MAX_BEHIJACK);
                                                        false -> gen_server:cast(mod_transport, {'hijack_truck', TruckId, RoleId})
                                                    end
                                            end;
                                        _ -> lib_send:send_prompt_msg(Status, ?PM_TS_TRUCK_NOTEXISTS)
                                    end
                            end;
                        _ -> lib_send:send_prompt_msg(Status, ?PM_TS_INFO_NOTEXISTS)
                    end
            end
    end.


%% @doc 取得免费次数
get_max_free_times(Status) -> 
    lib_vip:welfare(transport_free_times, Status).


%% @doc 取得运镖界面所有信息
get_all_transport_truck_info(RoleId) when is_integer(RoleId) ->
    case player:get_PS(RoleId) of
        Status when is_record(Status, player_status) -> get_all_transport_truck_info(Status);
        _ -> skip
    end;
get_all_transport_truck_info(Status) when is_record(Status, player_status) ->
    get_all_transport_truck_info(Status, 42001);
get_all_transport_truck_info(_T) -> ?LDS_DEBUG("42001", [{_T, is_record(_T, player_status)}]).

get_all_transport_truck_info(Status, Protocol) ->
    RoleId = player:id(Status),
    case get_role_transport(RoleId) of
         Transport when is_record(Transport, role_transport) ->
            TruckList = get_self_trucks_info(Status, Transport),
            case get_truck_info(RoleId) of
                Truck when is_record(Truck, truck) ->
                    {ok, BinData} = pt_42:write(Protocol, [TruckList, Transport#role_transport.news, Truck#truck.cur_event, 
                        Transport#role_transport.hijack_times, get_max_hijack_times(Status), Transport#role_transport.transport_times, 
                        ?TS_MAX_TRANSPORT_TIMES]),
                    lib_send:send_to_uid(RoleId, BinData);
                _ ->
                    {ok, BinData} = pt_42:write(Protocol, [TruckList, Transport#role_transport.news, [], 
                        Transport#role_transport.hijack_times, get_max_hijack_times(Status), Transport#role_transport.transport_times, 
                        ?TS_MAX_TRANSPORT_TIMES]),
                    lib_send:send_to_uid(RoleId, BinData)
            end;
        _ -> lib_send:send_prompt_msg(Status, ?PM_TS_INFO_NOTEXISTS)
    end.



%% @doc 更新镖车信息
update_truck_info(Truck) when is_record(Truck, truck) ->
    ets:insert(?ETS_TRUCK_INFO, Truck).


%% @doc 删除镖车信息
delete_truck_info(TruckId) when is_integer(TruckId) ->
    ets:delete(?ETS_TRUCK_INFO, TruckId),
    case ets:lookup(?ETS_TRUCK_ID_SET, ?TS_TRUCK_ID_SET_KEY) of
        [] -> ?ERROR_MSG("[lib_transport] delete_truck_info truck id = ~p not in id Sets", [TruckId]);
        [{_, IdSets} | _] -> ets:insert(?ETS_TRUCK_ID_SET, {?TS_TRUCK_ID_SET_KEY, ordsets:del_element(TruckId, IdSets)})
    end;
delete_truck_info(#truck{role_id = TruckId} = _Truck) when is_integer(TruckId) ->
    delete_truck_info(TruckId).


%% @doc 取得配置表相关数据
%% @return : #transport_data{} | null
get_config_data(RoleLv, TruckLv) ->
    LvGap = get_matching_gap(RoleLv, data_transport:get_lv_gap()),
    data_transport:get(LvGap, TruckLv).

get_config_data(Truck) when is_record(Truck, truck) ->
    get_config_data(Truck#truck.role_lv, Truck#truck.truck_lv).


get_matching_gap(RoleLv, [Elem]) when RoleLv >= Elem -> Elem;
get_matching_gap(RoleLv, [Elem1, Elem2 | Left]) ->
    case RoleLv >= Elem1 andalso RoleLv < Elem2 of
        true -> Elem1;
        false -> get_matching_gap(RoleLv, [Elem2 | Left])
    end;
get_matching_gap(_, _) -> null.



%% @doc 添加镖车到管理池
add_truck_to_transport_cache(Truck) when is_record(Truck, truck) ->
    ets:insert(?ETS_TRUCK_INFO, Truck),
    case ets:lookup(?ETS_TRUCK_ID_SET, ?TS_TRUCK_ID_SET_KEY) of
        [] -> ets:insert(?ETS_TRUCK_ID_SET, {?TS_TRUCK_ID_SET_KEY, ordsets:add_element(Truck#truck.role_id, ordsets:new())});
        [{_, IdSets} | _] -> ets:insert(?ETS_TRUCK_ID_SET, {?TS_TRUCK_ID_SET_KEY, ordsets:add_element(Truck#truck.role_id, IdSets)})
    end.


%% ===================================================================================
%% inner function
%% ===================================================================================

%% @doc 删除个人运镖信息
del_role_transport(RoleId) ->
    ets:delete(?ETS_ROLE_TRANSPORT, RoleId).

%% @doc 更新离线战斗数据 (没有则创建)
update_transport_offline_bo(Status) ->
    case mod_offline_data:get_offline_bo(player:id(Status), ?OBJ_PLAYER, ?SYS_TRANSPORT) of
        null -> mod_offline_data:db_replace_role_offline_bo(Status, ?SYS_TRANSPORT);
        OfflineBo -> 
            mod_offline_data:db_update_role_offline_bo(Status, ?SYS_TRANSPORT),
            NewPartnerList = player:get_partner_id_list(Status),
            lists:foreach(
                fun(PartnerId) ->
                    Partner = lib_partner:get_partner(PartnerId),
                    mod_offline_data:db_replace_partner_offline_bo(Partner, ?SYS_TRANSPORT)
                end,
                NewPartnerList
            ),
            lists:foreach(
                fun(ParId) -> 
                    mod_offline_data:db_del_offline_bo(ParId, ?OBJ_PARTNER, ?SYS_TRANSPORT)
                end,
                lists:subtract(OfflineBo#offline_bo.partners, NewPartnerList)
            )
    end.


%% @doc 取得随机镖车id
%% @return : list()
get_rand_trucks_id(RoleId, Transport) ->
    case ets:lookup(?ETS_TRUCK_ID_SET, ?TS_TRUCK_ID_SET_KEY) of
        [] -> [];
        [{_, IdSets} | _] ->  
            % AliveTruck = [Id || Id <- Transport#role_transport.attentives, lists:member(Id, IdList)],
            AliveTruck = ordsets:filter(fun(Id) -> ordsets:is_element(Id, IdSets) end, Transport#role_transport.attentives),
            Len = ordsets:size(AliveTruck),
            case Len >= ?TS_TRUCK_THRES of
                true -> AliveTruck;
                false -> ordsets:union(AliveTruck, 
                            ordsets:del_element(RoleId, random_select_trucks(ordsets:subtract(IdSets, AliveTruck), ?TS_TRUCK_LIMIT_NUM - Len)))
                % lists:usort(AliveTruck ++ lists:delete(RoleId, random_select_trucks(IdList, ?TS_TRUCK_LIMIT_NUM - Len)))
            end
    end.


%% @doc 取得随机镖车ID
%% @return : ordsets()
get_rand_trucks_info(Status, Num) ->
    IdSets = 
        case ets:lookup(?ETS_TRUCK_ID_SET, ?TS_TRUCK_ID_SET_KEY) of
            [{_, Sets} | _] -> Sets;
            _ -> []
        end,
    RoleId = player:id(Status),
    NewSets = random_select_trucks(IdSets, Num),
    % NewSets1 = 
    case get_truck_info(RoleId) of
        Truck when is_record(Truck, truck) ->
            ?BIN_PRED(ordsets:is_element(RoleId, NewSets), NewSets, ordsets:add_element(Truck#truck.role_id, NewSets));
        _ -> NewSets
    end.



%% @doc 取得个人镖车协议信息并更新关注列表
%% @return : ordsets()
get_self_trucks_info(Status, Transport) when is_record(Transport, role_transport) ->
    RoleId = player:id(Status),
    NewSets = get_rand_trucks_id(RoleId, Transport),
    ?LDS_TRACE("10", [NewSets]),
    NewSets1 = 
        case get_truck_info(RoleId) of
            Truck when is_record(Truck, truck) ->
                ?BIN_PRED(ordsets:is_element(RoleId, NewSets), NewSets, ordsets:add_element(Truck#truck.role_id, NewSets));
            _ -> NewSets
        end,
    update_role_transport(Transport#role_transport{attentives = NewSets1}),
    ?LDS_TRACE("11", [NewSets1]),
    ordsets:fold(fun(TruckId, Sum) -> [pack_truck_info(TruckId) | Sum] end, [], NewSets1).



% get_alive_trucks([]) -> [];
% get_alive_trucks([Id | Left]) ->
%     case 


%% @doc 随机选择指定数量的镖车ID
%% Sets::ordsets()
%% @return : ordsets()
random_select_trucks(_Sets, Num) when Num =< 0 -> [];
random_select_trucks(Sets, Num) ->
    Len = ordsets:size(Sets),
    case Len =< Num of
        true -> Sets;
        false -> 
            Rand = util:rand(1, Len - Num),
            lists:sublist(Sets, Rand, Num)
    end.


%% @doc 取得实际参与次数
get_already_join_times(Status) ->
    RoleId = player:id(Status),
    case get_role_transport(RoleId) of
        Transport when is_record(Transport, role_transport) -> 
            Transport#role_transport.transport_times;
        _ -> 0
    end.

get_max_join_times(_Status) ->
    ?TS_MAX_TRANSPORT_TIMES.


db_update_role_transport(Transport) when is_record(Transport, role_transport) ->
    db:update(Transport#role_transport.role_id, role_transport, 
        [{truck_lv, Transport#role_transport.truck_lv},
         {transport_times, Transport#role_transport.transport_times},
         {hijack_times, Transport#role_transport.hijack_times},
         {refresh_times, Transport#role_transport.refresh_times},
         {days_count, Transport#role_transport.days_count},
         {news, util:term_to_bitstring(Transport#role_transport.news)},
         {attentives, util:term_to_bitstring(Transport#role_transport.attentives)},
         {free_times, Transport#role_transport.free_times}
        ], 
        [{role_id, Transport#role_transport.role_id}]).


db_replace_role_transport(Transport) when is_record(Transport, role_transport) ->
    db:replace(Transport#role_transport.role_id, role_transport, 
        [{role_id, Transport#role_transport.role_id},
         {truck_lv, Transport#role_transport.truck_lv},
         {transport_times, Transport#role_transport.transport_times},
         {hijack_times, Transport#role_transport.hijack_times},
         {refresh_times, Transport#role_transport.refresh_times},
         {days_count, Transport#role_transport.days_count},
         {news, util:term_to_bitstring(Transport#role_transport.news)},
         {attentives, util:term_to_bitstring(Transport#role_transport.attentives)},
         {free_times, Transport#role_transport.free_times}
        ]
        ).


%% @doc 取得最大抢劫次数
%% @return : integer()
get_max_hijack_times(_Status) ->
    ?TS_MAX_HIJACK_TIMES.


%% @doc 镖书数量
get_transport_goods_num(Status) ->
    mod_inv:get_goods_count_in_bag_by_no(player:id(Status), ?TS_EVOLVE_GOODS).

%% @doc 使用镖书
use_transport_goods(Status, Num) ->
    mod_inv:destroy_goods_WNC(player:id(Status), [{?TS_EVOLVE_GOODS, Num}], [?LOG_TRANSPORT, "upgrade"]).


%% @doc 取得进阶概率
can_evolve_truck(Type, Status, TruckLv) ->
    can_evolve_truck(Type, get_config_data(player:get_lv(Status), TruckLv)).


can_evolve_truck(Type, ConfigData) when is_record(ConfigData, transport_data) ->
    Seed = util:rand(1, 1000),
    LvProb = ?BIN_PRED(Type == money, ConfigData#transport_data.evolve_rate_money, ConfigData#transport_data.evolve_rate_goods),
    Seed =< LvProb.


%% @doc 打包镖车信息
%% @return : list()
pack_truck_info(TruckId) when is_integer(TruckId) ->
    case get_truck_info(TruckId) of
        Truck when is_record(Truck, truck) -> pack_truck_info(Truck);
        _ -> []
    end;
pack_truck_info(Truck) when is_record(Truck, truck) ->
    RoleId = Truck#truck.role_id,
    [RoleId, tool:to_binary(player:get_name(RoleId)), Truck#truck.role_lv, Truck#truck.truck_lv, 0, Truck#truck.be_hijacked_times, ?TS_MAX_BE_HIJACKED_TIMES,
     Truck#truck.cur_stage, Truck#truck.cur_stage_timestamp, Truck#truck.cur_event].


%% @doc 根据玩家信息生成镖车信息
%% @return : #truck{}
make_new_truck(Status, Transport) ->
    Now = util:unixtime(),
    Truck = #truck{
        role_id = player:id(Status)                         % 所属人物ID
        ,role_lv = player:get_lv(Status)                    % 所属人物等级
        ,truck_lv = Transport#role_transport.truck_lv       % 镖车等级
        % ,is_employ = ply_hire:has_hired_player(Status)      % 是否被雇佣
        ,be_hijacked_times = 0                              % 被劫持次数
        ,start_timestamp = Now                              % 开始运镖时间戳
        ,cur_stage = 0                                      % 当前阶段 (0 - 3)
        ,cur_stage_timestamp = Now                          % 当前阶段开始时的时间戳
        ,cur_event = []                                     % 当前发生的事件集合
    },
    Truck#truck{cur_event = mod_transport:random_transport_event(Truck)}.


%% @return : #role_transport{}
make_new_transport_info(Status) ->
    #role_transport{
        role_id = player:id(Status)
        ,truck_lv = 0                           % 镖车等级
        ,transport_times = 0                    % 运输次数
        ,hijack_times = 0                       % 劫车次数
        ,refresh_times = 0                      % 刷新次数
        ,days_count = util:get_now_days()       % 日数
        ,news = []                              % 新闻
        ,attentives = ordsets:new()         % 关注列表 (玩家ID)
        ,free_times = 0
        % ,state = 0                              % 运镖状态(0:空闲 1:运镖中)
    }.


%% @doc 初始化并持久化玩家运镖信息
%% @return : #role_transport{}
init_role_transport(Status) ->
    Transport = make_new_transport_info(Status),
    update_role_transport(Transport),
    ?LDS_TRACE(init_role_transport),
    db_replace_role_transport(Transport),
    Transport.


%% @doc 取得运镖空闲状态 (0->free 1->busy)
get_transport_state(RoleId) ->
    case get_truck_info(RoleId) of
        Truck when is_record(Truck, truck) -> 1;
        _ -> 0
    end.


%% 构造新闻
make_transport_new(No, Timestamp) ->
    #transport_news{
        no = No
        ,performer = 0
        ,performer_name = <<>>
        ,timestamp = Timestamp
    }.

make_transport_new(No, Performer, Name, Timestamp) ->
    #transport_news{
        no = No
        ,performer = Performer
        ,performer_name = tool:to_binary(Name)
        ,timestamp = Timestamp
    }.

make_transport_new_by_event(?TS_EVENT_0) ->
    make_transport_new(?TS_NEWS_0, util:unixtime());
make_transport_new_by_event(?TS_EVENT_1) -> 
    make_transport_new(?TS_NEWS_1, util:unixtime()).


publ_add_news(RoleId, News) when is_record(News, transport_news) ->
    case player:is_online(RoleId) of
        true -> gen_server:cast(player:get_pid(RoleId), {apply_cast, ?MODULE, add_news, [RoleId, News]});
        false ->    
            case get_role_transport(RoleId) of
                Transport when is_record(Transport, role_transport) ->
                    update_role_transport(Transport#role_transport{news = append_new(News, Transport#role_transport.news)});
                _ -> 
                    case db:select_row(role_transport, "news", [{role_id, RoleId}]) of
                        [RawNews] -> 
                            case util:bitstring_to_term(RawNews) of
                                Term when is_list(Term) ->
                                    db:update(RoleId, role_transport, [{news, util:term_to_bitstring(append_new(News, Term))}], [{role_id, RoleId}]);
                                _ -> 
                                    db:update(RoleId, role_transport, [{news, util:term_to_bitstring([News])}], [{role_id, RoleId}])
                            end;
                        _ -> error
                    end
            end
    end;
publ_add_news(_, _N) -> ?ASSERT(false, [_N]).


add_news(RoleId, News) ->
    case get_role_transport(RoleId) of
        Transport when is_record(Transport, role_transport) ->
            update_role_transport(Transport#role_transport{news = append_new(News, Transport#role_transport.news)}),
            {ok, BinData} = pt_42:write(42002, [News#transport_news.no, News#transport_news.timestamp, 
                News#transport_news.performer, News#transport_news.performer_name]),
            lib_send:send_to_uid(RoleId, BinData);
        _ -> error
    end.


append_new(News, NewsList) -> 
    lists:sublist([News | NewsList], ?TS_MAX_NEWS).