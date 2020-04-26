-module (mod_dungeon_plot).

-include("common.hrl").
-include("record.hrl").
-include("ets_name.hrl").
-include("dungeon_plot.hrl").
-include("log.hrl").
-include("reward.hrl").
-include("prompt_msg_code.hrl").

-export([
    fetch_dun_plot_info/1
    ,publ_notify_dungeon_pass/2
    ,notify_dungeon_pass/2
    ,login/2
    ,final_logout/1
    ,is_plot_dungeon_pass/2
    ,fix_expand_partner/1
    ]).

%% 获取副本剧情信息
fetch_dun_plot_info(Status) ->
    DunList = data_dungeon_plot:get_dungeons(),
    DataList = get_dungeons_plot_info(player:id(Status)),
    Now = util:unixtime(),
    F = fun(DunNo, Acc) ->
        % DunTimesTmp = lib_dungeon:get_max_dun_times(Status, DunNo) - lib_dungeon:get_update_dungeon_used_times(Status, Now, DunNo),
        DunTimes = lib_dungeon:get_update_dungeon_used_times(Status, Now, DunNo),
        case lists:keyfind(DunNo, 1, DataList) of
            false -> [{DunNo, 0, 0, DunTimes} | Acc];
            {DunNo, Times, Timestamp} -> 
                case data_dungeon_plot:get_dungeon_plot(DunNo) of
                    Plot when is_record(Plot, dungeon_plot) -> 
                        case check_enough_normal_reward_times(Plot, Times, Timestamp, Now, Status) of
                            {true, NewTimes} -> [{DunNo, 1, Plot#dungeon_plot.times - NewTimes, DunTimes} | Acc];
                            false -> [{DunNo, 1, 0, DunTimes} | Acc]
                        end;
                    _ -> ?ASSERT(false, [DunNo]), [{DunNo, 1, 0, DunTimes} | Acc]
                end
        end
    end,
    send_59101(Status, lists:foldl(F, [], DunList)).

send_59101(Status, DataList) when is_record(Status, player_status) ->
    {ok, BinData} = pt_59:write(59101, [DataList]),
    lib_send:send_to_uid(player:id(Status), BinData);
send_59101(RoleId, DataList) when is_integer(RoleId) ->
    {ok, BinData} = pt_59:write(59101, [DataList]),
    lib_send:send_to_uid(RoleId, BinData).


%% 通知副本通关
publ_notify_dungeon_pass(DunNo, RoleId) ->
    gen_server:cast(player:get_pid(RoleId), {notify_dungeon_pass, DunNo}).

notify_dungeon_pass(DunNo, Status) ->
    DunList = data_dungeon_plot:get_dungeons(),
    case lists:member(DunNo, DunList) of
        false -> skip;
        true ->
            case data_dungeon_plot:get_dungeon_plot(DunNo) of
                Plot when is_record(Plot, dungeon_plot) ->
                    Now = util:unixtime(),
                    DataList = get_dungeons_plot_info(player:id(Status)),
                    RoleId = player:id(Status),
                    % DunTimesTmp = lib_dungeon:get_max_dun_times(Status, DunNo) - lib_dungeon:get_update_dungeon_used_times(Status, Now, DunNo),
                    DunTimes = lib_dungeon:get_update_dungeon_used_times(Status, Now, DunNo),
                    case lists:keyfind(DunNo, 1, DataList) of
                        false -> 
                            %% 副本首次通关， 发放首次通关奖励
                            update_dungeon_plot(RoleId, [{DunNo, 0, Now} | DataList]),
                            send_59101(Status, [{DunNo, 1, 0, DunTimes}]),
                            send_dungeon_plot_reward([Plot#dungeon_plot.first_rid], Status, DunNo),
                            % case check_enough_normal_reward_times(Plot, 0, Status) of
                            %     true -> 
                            %         update_dungeon_plot(RoleId, [{DunNo, 1, Now} | DataList]),
                            %         send_59101(Status, [{DunNo, 1, Plot#dungeon_plot.times - 1}]),
                            %         send_dungeon_plot_reward([Plot#dungeon_plot.first_rid, Plot#dungeon_plot.normal_rid], Status, DunNo);
                            %     false -> 
                            %         update_dungeon_plot(RoleId, [{DunNo, 0, Now} | DataList]),
                            %         send_59101(Status, [{DunNo, 1, 0}]),
                            %         send_dungeon_plot_reward([Plot#dungeon_plot.first_rid], Status, DunNo)
                            % end,
                            % 发送额外奖励
                            send_extra_reward(Plot#dungeon_plot.first_extra_rid, Status);
                        {DunNo, Times, Timestamp} ->
                            %% 非首次通关，尝试发放普通奖励
                            case check_enough_normal_reward_times(Plot, Times, Timestamp, Now, Status) of
                                {true, NewTimes} ->
                                    update_dungeon_plot(RoleId, lists:keyreplace(DunNo, 1, DataList, {DunNo, NewTimes + 1, Now})),
                                    send_59101(Status, [{DunNo, 1, Plot#dungeon_plot.times - 1 - NewTimes, DunTimes}]),
                                    send_dungeon_plot_reward([Plot#dungeon_plot.normal_rid], Status, DunNo);
                                false -> skip
                            end
                    end;
                _ -> skip
            end
    end.


%% 发送奖励
send_dungeon_plot_reward(RawRwdList, Status, DunNo) ->
    RwdList = [Rwd || Rwd <- RawRwdList, Rwd =/= 0],
    RoleId = player:id(Status),
    case lib_reward:check_bag_space(Status, RwdList) of
        ok -> skip;
        {fail, Reason} -> lib_send:send_prompt_msg(Status, Reason)
    end,
    F = fun(Rid, Acc) ->
        case lib_reward:give_reward_to_player(Status, Rid, [?LOG_DUNGEON, DunNo]) of
            Rwd when is_record(Rwd, reward_dtl) ->
                List = [{Id, No, Num, mod_inv:get_goods_quality_by_id(RoleId, Id), mod_inv:get_goods_bind_state_by_id(Id)} 
                    || {Id, No, Num} <- Rwd#reward_dtl.goods_list],
                Acc ++ List;
            _ -> Acc
        end
    end,
    RwdData = lists:foldl(F, [], RwdList),
    {ok, BinData} = pt_59:write(59102, [RwdData]),
    lib_send:send_to_uid(RoleId, BinData).
    % lists:foreach(fun(Rid) -> lib_reward:give_reward_to_player(Status, Rid, [?LOG_DUNGEON, DunNo]) end, RwdList).


%% 发放额外奖励
send_extra_reward([], _Status) -> skip; 
send_extra_reward([{add_pet_pos, Num} | Left], Status) ->
    ply_partner:expand_fight_par_capacity(Status, Num),
    send_extra_reward(Left, Status);
send_extra_reward([_T | Left], Status) ->
    ?ASSERT(false, [_T]),
    send_extra_reward(Left, Status).


%% 取得剧情副本信息
%% @return : list()
get_dungeons_plot_info(RoleId) ->
    case ets:lookup(?ETS_DUNGEON_PLOT, RoleId) of
        [] -> [];
        [{RoleId, Data}] when is_list(Data) -> Data;
        _T -> ?ASSERT(false, _T), []
    end.


is_plot_dungeon(DunNo) ->
    DunList = data_dungeon_plot:get_dungeons(),
    lists:member(DunNo, DunList).

%% @return : boolean() | error
is_plot_dungeon_pass(RoleId, DunNo) ->
    case is_plot_dungeon(DunNo) of
        false -> error;
        true -> 
            DataList = get_dungeons_plot_info(RoleId),
            lists:keymember(DunNo, 1, DataList)
    end.


%% 检查是否能发放普通奖励
%% @return : boolean()
% check_enough_normal_reward_times(Plot, Times, _Status) when is_record(Plot, dungeon_plot) -> 
%     Plot#dungeon_plot.times > Times;
% check_enough_normal_reward_times(_, _, _) -> ?ASSERT(false), false.

%% @return : false | {true, NewTimes}
check_enough_normal_reward_times(Plot, Times, Timestamp, Now, _Status) when is_record(Plot, dungeon_plot) -> 
    case Plot#dungeon_plot.times > 0 of
        false -> false;
        true -> 
            case util:is_timestamp_same_week(Timestamp, Now) of
                true -> ?BIN_PRED(Plot#dungeon_plot.times > Times, {true, Times}, false);
                false -> {true, 0}
            end
    end.


%% 更新并保存副本剧情信息
update_dungeon_plot(RoleId, DataList) when is_integer(RoleId) ->
    ets:insert(?ETS_DUNGEON_PLOT, {RoleId, DataList}),
    db:update(RoleId, dungeon_plot_target, [{data, util:term_to_bitstring(DataList)}], [{role_id, RoleId}]);
update_dungeon_plot(_, _) -> ?ASSERT(false).


%% 登录加载
login(RoleId, role_in_cache) -> fix_expand_partner(RoleId);
login(RoleId, _) ->
    case db:select_row(dungeon_plot_target, "data", [{role_id, RoleId}]) of
        [] ->  
            db:insert(RoleId, dungeon_plot_target, [{role_id, RoleId}, {data, util:term_to_bitstring([])}]),
            ets:insert(?ETS_DUNGEON_PLOT, {RoleId, []});
        [Data] -> 
            DataList = util:bitstring_to_term(Data),
            ets:insert(?ETS_DUNGEON_PLOT, {RoleId, DataList});
        _T -> 
            ?ERROR_MSG("[mod_dungeon_plot] load db data error = ~p~n", [_T]),
            erlang:error({load_dungeon_plot, error})
    end,
    fix_expand_partner(RoleId).


final_logout(RoleId) -> 
    ets:delete(?ETS_DUNGEON_PLOT, RoleId).


% 等级 对应出战 实际 副本id
%  12    2       1   1011
%  20    3       2   1021
%  30    4       3   1031
%  40    5       4   1041

fix_expand_partner(RoleId) when is_integer(RoleId) ->
    case player:get_PS(RoleId) of
        Status when is_record(Status, player_status) -> fix_expand_partner(Status);
        _ -> error
    end;
fix_expand_partner(Status) when is_record(Status, player_status) ->
    RoleId = player:id(Status),
    Lv = player:get_lv(Status),
    DataList = get_dungeons_plot_info(RoleId),

    player:get_fight_par_capacity(Status).

    % if  Lv < 10 -> fix_expand_partner_num(Status, DataList, 1, []);
    %     Lv < 20 -> fix_expand_partner_num(Status, DataList, 1, [1011]);
    %     Lv < 30 -> fix_expand_partner_num(Status, DataList, 2, [1021, 1011]);
    %     Lv < 40 -> fix_expand_partner_num(Status, DataList, 3, [1031, 1021, 1011]);
    %     true -> fix_expand_partner_num(Status, DataList, 4, [1041, 1031, 1021, 1011])
    % end.

fix_expand_partner_num(Status, _DataList, Num, []) ->
    RoleId = player:id(Status),
    ActNum = player:get_fight_par_capacity(Status),
    case ActNum > Num of
        true -> 
            update_dungeon_plot(RoleId, []),
            player:set_fight_par_capacity(Status, Num);
        false -> ok
    end; 
fix_expand_partner_num(Status, DataList, Num, [DunNo | Left] = _DunList) -> 
    RoleId = player:id(Status),
    ActNum = player:get_fight_par_capacity(Status),
    case ActNum =< Num of
        true -> ok;
        false -> 
            case ActNum - 1 =:= Num andalso lists:keymember(DunNo, 1, DataList) of
                true -> ok;
                false -> 
                    Now = util:unixtime(),
                    F = fun(No, Count) ->
                        case lists:keyfind(No, 1, DataList) of
                            false -> [{No, 0, Now} | Count];
                            Item -> [Item | Count]
                        end
                    end,
                    NewDataList = lists:foldl(F, [], Left),
                    update_dungeon_plot(RoleId, NewDataList),
                    player:set_fight_par_capacity(Status, Num)
                            % send_59101(Status, [{DunNo, 1, 0, DunTimes}]),
            end
    end.
