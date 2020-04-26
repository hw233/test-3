-module(mod_transport).
-behaviour(gen_server).
-export([init/1, handle_cast/2, handle_call/3, handle_info/2, terminate/2, code_change/3]).
-export([
    start_link/0,
    save_all_truck/0,
    random_transport_event/1,
    handle_hijack_feedback/2
    ]).

-include("common.hrl").
-include("record.hrl").
-include("transport.hrl").
-include("log.hrl").
-include("ets_name.hrl").
-include("prompt_msg_code.hrl").
-include("reward.hrl").
-include("record/battle_record.hrl").

-record(state, {}).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).


init([]) ->
    process_flag('trap_exit', true),
    load_all_truck(),
    start_check_truck_timer(),
    {ok, #state{}, 1000}.


handle_call(_Msg, _From, State) ->
    {reply, badmatch, State}.


handle_cast({'hijack_truck', TruckId, Hijacker}, State) ->
    try
        case lib_transport:get_truck_info(TruckId) of
            Truck when is_record(Truck, truck) ->
                case Truck#truck.be_hijacked_times >= ?TS_MAX_BE_HIJACKED_TIMES of
                    true -> lib_send:send_prompt_msg(Hijacker, ?PM_TS_MAX_BEHIJACK);
                    false -> 
                        % ?LDS_DEBUG(hijack_truck, {TruckId, Hijacker, lib_transport:get_role_transport(Hijacker)}),
                        case lib_transport:get_role_transport(Hijacker) of
                            Transport when is_record(Transport, role_transport) -> 
                                case Transport#role_transport.hijack_times >= ?TS_MAX_HIJACK_TIMES of
                                    true -> lib_send:send_prompt_msg(Hijacker, ?PM_TS_MAX_HIJACK);
                                    false ->
                                        % lib_transport:update_role_transport(Transport#role_transport{hijack_times = Transport#role_transport.hijack_times + 1}),
                                        % lib_transport:update_truck_info(Truck#truck{be_hijacked_times = Truck#truck.be_hijacked_times + 1}),
                                        gen_server:cast(player:get_pid(Hijacker), {start_hijack, TruckId})
                                        % begin_to_hijack_battle,
                                        % ?BIN_PRED(util:rand(0, 1) >= 0, gen_server:cast(self(), {'hijack_feedback', TruckId, win, Hijacker}),
                                        %     gen_server:cast(self(), {'hijack_feedback', TruckId, lose, Hijacker})),
                                        % redo
                                end;
                            _T -> lib_send:send_prompt_msg(Hijacker, ?PM_UNKNOWN_ERR)
                        end
                end;
            _T ->
                ?ERROR_MSG("[~p] hijack_truck TruckId = ~p  Hijacker = ~p~ndata = ~p~n", [TruckId, Hijacker, _T]),
                lib_send:send_prompt_msg(Hijacker, ?PM_TS_TRUCK_NOTEXISTS)
        end
    catch
        _:_ -> ?ERROR_MSG("[mod_transport] hijack_truck error", [])
    end,
    {noreply, State};


%% @TruckId : targetRoleId
handle_cast({'hijack_feedback', TruckId, Result, Hijacker}, State) ->
    try
        case Result of
            win ->  handle_hijack_win(TruckId, Hijacker);
            _ ->  handle_hijack_lose(TruckId, Hijacker)
        end,
        gen_server:cast(player:get_pid(Hijacker), {'apply_cast', lib_transport, get_all_transport_truck_info, [Hijacker]})
    catch 
        _:_ -> ?ERROR_MSG("[mod_transport] hijack_feedback error", [])
    end,
    {noreply, State};


handle_cast(_Msg, State) ->
    {noreply, State}.


handle_info('check_truck', State) ->
    try
        Now = util:unixtime(),
        case ets:tab2list(?ETS_TRUCK_INFO) of
            [] -> skip;
            TruckList ->
                try check_truck(Now, TruckList) of
                    _ -> ok
                catch
                    T:E -> ?ERROR_MSG("[mod_transport] check_truck error = ~p~n", [{T, E}])
                end
        end,
        start_check_truck_timer()
    catch
        _:_ -> ?ERROR_MSG("[mod_transport] check_truck error", [])
    end,
    {noreply, State};

handle_info(timeout, State) ->
    try 
        load_all_truck()
    catch
        _:_ -> ?ERROR_MSG("[mod_transport] timeout error", [])
    end,
    {noreply, State};

handle_info(_Msg, State) ->
    {noreply, State}.


code_change(_OldVsn, State, _Extra) ->
    {ok, State}.


terminate(_Reason, _State) ->
    ok.



%% @doc 开始检查计时器
start_check_truck_timer() -> 
    erlang:send_after(?TS_CHECK_TRUCK_INTEVAL, self(), 'check_truck').


%% 检查镖车
check_truck(_Now, []) -> skip;
check_truck(Now, [Truck | Left]) when is_record(Truck, truck) ->
    case Now - Truck#truck.cur_stage_timestamp >= get_truck_stage_time(Truck) of
        true -> enter_next_stage(Truck, Now);
        false -> skip
    end,
    check_truck(Now, Left);
check_truck(Now, [Elem | Left]) -> 
    interrupt_transport(Elem),
    check_truck(Now, Left).


%% @doc 取得镖车一阶段所需时间
get_truck_stage_time(Truck) ->
    case lib_transport:get_config_data(Truck#truck.role_lv, Truck#truck.truck_lv) of
        ConfigData when is_record(ConfigData, transport_data) ->
            ConfigTime = ConfigData#transport_data.ts_time,
            case lists:member(?TS_EVENT_0, Truck#truck.cur_event) of
                true -> ConfigTime div 2;
                false -> ConfigTime
            end;
        _ -> ?ERROR_MSG("[mod_transport] get_config_data error ~p~n", [Truck]), 999999
    end.


%% @doc 镖车进入下一阶段
enter_next_stage(Truck, Timestamp) ->
    case Truck#truck.cur_stage >= ?TS_TRUCK_MAX_STAGE of
        true -> ?LDS_DEBUG("transport, end_off_transport"), end_off_transport(Truck);
        false -> 
            ?LDS_DEBUG("transport, enter_next_stage"), 
            lib_transport:update_truck_info(Truck#truck{cur_stage = Truck#truck.cur_stage + 1, 
                cur_stage_timestamp = Timestamp, cur_event = random_transport_event(Truck)})
    end,
    notify_role_truck_change(Truck).


%% @doc 结束运镖
end_off_transport(Truck) when is_record(Truck, truck) ->
    lib_transport:delete_truck_info(Truck),
    case lib_transport:get_config_data(Truck#truck.role_lv, Truck#truck.truck_lv) of
        ConfigData when is_record(ConfigData, transport_data) ->
            Coef = case Truck#truck.be_hijacked_times =< 0 of
                true -> 1;
                false -> 
                    Deduct = Truck#truck.be_hijacked_times * ConfigData#transport_data.deduct_coef,
                    ?BIN_PRED(Deduct >= 1, 0, 1 - Deduct)
            end,
            Multi = mod_svr_mgr:get_server_reward_multi(19),
            GoodsList = [{get_monery_type(ConfigData#transport_data.reward_money_type), 
                util:floor(ConfigData#transport_data.reward_money_num * Coef * Multi)}],
            Content = io_lib:format(<<"恭喜大侠押镖完成，途中被劫镖~p次，虽历尽艰辛，但最终还是达到了目的地，以下就是给主人的报酬哦">>, 
                [Truck#truck.be_hijacked_times]),
            lib_mail:send_sys_mail(Truck#truck.role_id, <<"运镖奖励">>, Content, GoodsList, [?LOG_TRANSPORT, "over"]);
        _ -> error
    end.


%% @doc 随机运输事件
random_transport_event(Truck) when is_record(Truck, truck) ->
    case lib_transport:get_config_data(Truck#truck.role_lv, Truck#truck.truck_lv) of
        ConfigData when is_record(ConfigData, transport_data) ->
            Rate = ConfigData#transport_data.event_rate,
            Events = [Event || Event <- ?TS_EVENTS, util:rand(1, 1000) =< Rate],
            {ok, BinData} = pt_42:write(42003, [Events]),
            lib_send:send_to_uid(Truck#truck.role_id, BinData),
            [catch lib_transport:publ_add_news(Truck#truck.role_id, lib_transport:make_transport_new_by_event(Event)) || Event <- Events],
            Events;
        _ -> []
    end.


interrupt_transport(_Elem) -> redo.


%% @关服保存镖车数据
save_all_truck() -> 
    case ets:tab2list(?ETS_TRUCK_INFO) of
        [] -> skip;
        TruckList -> 
            db:delete(?DB_SYS, truck_info, []),
            save_all_truck(TruckList)
    end.

save_all_truck([]) -> ok;
save_all_truck([Truck | Left]) when is_record(Truck, truck) ->
    db:insert(?DB_SYS, truck_info, [
        {role_id, Truck#truck.role_id},
        {role_lv, Truck#truck.role_lv},
        {truck_lv, Truck#truck.truck_lv},
        {start_timestamp, Truck#truck.start_timestamp},
        {be_hijacked_times, Truck#truck.be_hijacked_times},
        {cur_stage, Truck#truck.cur_stage},
        {cur_stage_timestamp, Truck#truck.cur_stage_timestamp},
        {cur_event, util:utf8_list_to_binary(Truck#truck.cur_event)}
        ]),
    save_all_truck(Left);
save_all_truck([_ | Left]) -> save_all_truck(Left).

%% @开服加载镖车数据
load_all_truck() ->
    case db:select_all(truck_info, "role_id, role_lv, truck_lv, start_timestamp, be_hijacked_times, cur_stage, cur_stage_timestamp, cur_event", []) of
        [] -> skip;
        TruckList when is_list(TruckList) -> 
            load_truck(TruckList),
            db:delete(?DB_SYS, truck_info, [])
    end.


load_truck([]) -> ok;
load_truck([[RoleId, RoleLv, TruckLv, StartTime, BeHijackTimes, CurStage, CurStageTime, CurEvent] | Left]) ->
    lib_transport:add_truck_to_transport_cache(#truck{
        role_id = RoleId                 
        ,role_lv = RoleLv                
        ,truck_lv = TruckLv                  
        ,be_hijacked_times = BeHijackTimes     
        ,start_timestamp = StartTime        
        ,cur_stage = CurStage              
        ,cur_stage_timestamp = CurStageTime    
        ,cur_event = util:utf8_binary_to_list(CurEvent)                     
        }),
    load_truck(Left);
load_truck([_ | Left]) -> load_truck(Left).



handle_hijack_win(TruckId, Hijacker) ->
    
    case lib_transport:get_truck_info(TruckId) of
        Truck when is_record(Truck, truck) ->
            catch lib_log:hijack_transport_win(Hijacker, Truck#truck.truck_lv),
            case Truck#truck.be_hijacked_times >= ?TS_MAX_BE_HIJACKED_TIMES of
                true -> lib_send:send_prompt_msg(Hijacker, ?PM_TS_LOST_TRUCK);
                false ->
                    case lib_transport:get_role_transport(Hijacker) of
                        Transport when is_record(Transport, role_transport) ->
                            case Transport#role_transport.hijack_times < ?TS_MAX_HIJACK_TIMES of
                                true ->
                                    case is_immune_attack_state(Truck) of
                                        true -> skip;
                                        false ->
                                            lib_transport:update_truck_info(Truck#truck{be_hijacked_times = 
                                                ?BIN_PRED(Truck#truck.be_hijacked_times >= ?TS_MAX_BE_HIJACKED_TIMES, ?TS_MAX_BE_HIJACKED_TIMES, 
                                                    Truck#truck.be_hijacked_times + 1)}),
                                            catch lib_transport:publ_add_news(TruckId, 
                                                lib_transport:make_transport_new(?TS_NEWS_2, Hijacker, player:get_name(Hijacker), util:unixtime()))
                                    end,
                                    lib_transport:update_role_transport(Transport#role_transport{hijack_times = Transport#role_transport.hijack_times + 1}),
                                    case lib_transport:get_config_data(Truck) of
                                        ConfigData when is_record(ConfigData, transport_data) ->
                                            player:add_money(Hijacker, ConfigData#transport_data.reward_money_type, 
                                                util:floor(ConfigData#transport_data.reward_money_num * ConfigData#transport_data.deduct_coef), 
                                                [?LOG_TRANSPORT, "rob"]);
                                        _ -> error
                                    end;
                                false -> lib_send:send_prompt_msg(Hijacker, ?PM_TS_MAX_HIJACK)
                            end;
                        _ -> skip
                    end
            end;
        _ -> lib_send:send_prompt_msg(Hijacker, ?PM_TS_TRUCK_OUT)
    end.


handle_hijack_lose(TruckId, Hijacker) -> 
    case lib_transport:get_truck_info(TruckId) of
        Truck when is_record(Truck, truck) ->
            catch lib_log:hijack_transport_lose(Hijacker, Truck#truck.truck_lv);
        _ -> skip
    end.


get_monery_type(MoneyType) ->
    if  MoneyType =:= gamemoney orelse MoneyType =:= ?MNY_T_GAMEMONEY -> 89000;
        MoneyType =:= bind_gamemoney orelse MoneyType =:= ?MNY_T_BIND_GAMEMONEY -> 89001;
        MoneyType =:= yuanbao orelse MoneyType =:= ?MNY_T_YUANBAO -> 89002;
        MoneyType =:= bind_yuanbao orelse MoneyType =:= ?MNY_T_BIND_YUANBAO -> 89003;
        MoneyType =:= feat orelse MoneyType =:= ?MNY_T_FEAT -> 89010;
        MoneyType =:= integral orelse MoneyType =:= ?MNY_T_INTEGRAL -> 89058;
        MoneyType =:= ?MNY_T_GUILD_CONTRI -> 89011;
        MoneyType =:= ?MNY_T_EXP -> 89004;
        true -> MoneyType
    end.


%% @doc 是否处于免疫攻击状态
%% @return : boolean()
is_immune_attack_state(Truck) when is_record(Truck, truck) ->
    lists:member(?TS_EVENT_1, Truck#truck.cur_event).


%% @doc 通知玩家镖车改变
notify_role_truck_change(Truck) ->
    RoleId = Truck#truck.role_id,
    case player:is_online(RoleId) of
        true -> gen_server:cast(player:get_pid(RoleId), {apply_cast, lib_transport, get_all_transport_truck_info, [RoleId]});
        false -> skip
    end.


handle_hijack_feedback(Hijacker, FeedBack) ->
    case FeedBack#btl_feedback.oppo_player_id_list of
        [] -> error;
        [TargetId | _] -> gen_server:cast(?MODULE, {'hijack_feedback', TargetId, FeedBack#btl_feedback.result, Hijacker})
    end.