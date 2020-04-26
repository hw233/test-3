%%%-------------------------------------------------------------------
%%% @author ningwenbin
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%     经验找回
%%% @end
%%% Created : 24. 2月 2020 15:10
%%%-------------------------------------------------------------------
-module(lib_jingyan).
-author("ningwenbin").
-include("ets_name.hrl").
-include("debug.hrl").
-include("prompt_msg_code.hrl").
-include("common.hrl").
-include("jingyan.hrl").
-include("reward.hrl").
-include("protocol/pt_58.hrl").

-define(DICT_KEY_DAY(No),           {?MODULE, no, No}).   % 日常活动完成次数记录[{绝对天数,count, 是否已领取0|1}]

%%-record(act_jingyan,{
%%    role_id,
%%    list = []       % {绝对天数，日常活动完成次数记录[{no,count}]}
%%}).

%% API
-export([
    login/2,
    tmp_logout/1,
    final_logout/1,
    update_times/2,
    send_panel/1,
    get_award/3,
    daily_reset/1,
    get_first_login_flag/1
]).


%% @doc 登录时，初始化信息
login(PS, role_in_cache) ->
    check_first_login(PS),
    case ets:lookup(?ETS_JINGYAN_TMP_CACHE, player:id(PS)) of
        [{RoleId, List}] ->
            set_all_info(List),
            ets:delete(?ETS_JINGYAN_TMP_CACHE, RoleId);
        _ ->
            ?ASSERT(false, [player:id(PS)])
    end;
login(PS, _) ->
    check_first_login(PS),
    case db:select_row(act_jingyan, "`info`", [{id, player:id(PS)}]) of
        [] ->
            set_all_info([]),
            db:insert(player:id(PS), act_jingyan,
                [{info, util:term_to_bitstring([])},
                    {id, player:id(PS)}]);
        [Info0] ->
            Info = util:bitstring_to_term(Info0),
            set_all_info(Info);
        Err ->
            ?ERROR_MSG("load act_jingyan RoleId = ~p error = ~p~n", [player:id(PS), Err]),
            ?ASSERT(false, [player:id(PS), Err])
    end.

tmp_logout(RoleId) ->
    List = pack_jingyan_info(),
    ets:insert(?ETS_JINGYAN_TMP_CACHE, {RoleId, List}),
    ok.

final_logout(RoleId) ->
    case ets:lookup(?ETS_JINGYAN_TMP_CACHE, RoleId) of
        [{RoleId, List}] ->
            db:update(RoleId, [{id, RoleId},{info, util:term_to_bitstring(List)}], [{id, RoleId}]),
            ets:delete(?ETS_JINGYAN_TMP_CACHE, RoleId);
        [] ->
            skip
    end.

daily_reset(PS) ->

    send_panel(PS),
    ok.

check_first_login(PS) ->
    Time = player:get_last_daily_reset_time(PS),
    case util:is_same_day(Time) of
        ?false ->
            put({?MODULE, first_lg_flag}, 2);
        ?true ->
            put({?MODULE, first_lg_flag}, 1)
    end.

%% @doc 同步更新进度
update_times(Sys, FitNum) ->
    case lists:member(Sys, data_jingyan:get_all_no()) of
        true ->
            set_no(Sys, util:get_now_days(), FitNum);
        false ->
            skip
    end,
    ok.

send_panel(PS) ->
    Data = lists:map(fun(Sys) ->
        Days = can_award_day(PS, Sys),
        OldL = get_no(Sys),
        Times = calc_times(Sys, Days, OldL),
        #jingyan{reward = AwardId} = data_jingyan:get_jingyan(Sys),
        #reward_dtl{calc_goods_list = CalcList} = lib_reward:calc_reward_to_player(PS, AwardId, Times),
        GoodList = [{GId, GNum} || {GId, GNum, _Qua, _BinState, _NeedBroadcast} <- CalcList],
        {Sys, Times, GoodList}
              end, data_jingyan:get_all_no()),
    {ok, BinData} = pt_58:write(?PT_ACT_JINGYAN, [Data]),
    lib_send:send_to_sock(PS, BinData),
    ok.

get_first_login_flag(PS) ->
    {ok, BinData} = pt_58:write(?PT_ACT_JINGYAN_RESET, [get({?MODULE, first_lg_flag})]),
    lib_send:send_to_sock(PS, BinData).

get_award(0, PS, Type) -> % 一键找回
    List = lists:foldl(fun(Sys,Acc) ->
        case get_one_award(Sys, PS, Type) of
            ok ->
                [{Sys,Type}|Acc];
            {fail, _Reason} ->
                Acc
        end
        end, [], data_jingyan:get_all_no()),
    case List of
        [] ->
            lib_send:send_prompt_msg(player:id(PS), ?PM_JINGYAN_NULL);
        _ ->
            {ok, BinData} = pt_58:write(?PT_ACT_JINGYAN_AWARD, [List, 0]),
            lib_send:send_to_sock(PS, BinData)
    end,
    ok;
get_award(Sys, PS, Type) ->
    case get_one_award(Sys, PS, Type) of
        ok ->
            {ok, BinData} = pt_58:write(?PT_ACT_JINGYAN_AWARD, [[{Sys,Type}],Sys]),
            lib_send:send_to_sock(PS, BinData);
        {fail, Reason} ->
            lib_send:send_prompt_msg(player:id(PS), Reason)
    end.

get_one_award(Sys, PS, Type) ->
    case check_get_award(Sys, PS, Type) of
        ok ->
            Days = can_award_day(PS, Sys),
            OldL = get_no(Sys),
            % 计算可领取的次数
            Times = calc_times(Sys, Days, OldL),

            #jingyan{retrieve_costs = {Id, Num}, retrieve_rate = RateL, reward = AwardId} = data_jingyan:get_jingyan(Sys),
            NeedCost  = [{Id, Num * Times}],
            {_, Rate} = lists:keyfind(Type, 1, RateL),
            #reward_dtl{calc_goods_list = CalcList} = lib_reward:calc_reward_to_player(PS, AwardId, Times),
            GoodList = [{GId, util:ceil(GNum * Rate)} || {GId, GNum, _Qua, _BinState} <- CalcList],
            case Type of
                1 ->    % 免费
                    mod_inv:batch_smart_add_new_goods(player:id(PS), GoodList, ["lib_jingyan", "get_award"]),
                    set_award_state(Sys, Days),
                    ok;
                2 ->    % 付费
                    case mod_inv:check_batch_add_goods(player:id(PS), GoodList) of
                        ok ->
                            case mod_inv:check_batch_destroy_goods(player:id(PS), NeedCost)  of
                                ok ->
                                    mod_inv:destroy_goods_WNC(player:id(PS), NeedCost, ["lib_jingyan", "get_award"]),
                                    mod_inv:batch_smart_add_new_goods(player:id(PS), GoodList, ["lib_jingyan", "get_award"]),
                                    set_award_state(Sys, Days),
                                    ok;
                                {fail, Reason} ->
                                    {fail, Reason}
                            end;
                        {fail, Reason} ->
                            {fail, Reason}
                    end
            end;
        {fail, Reason} ->
            {fail, Reason}
    end.


check_get_award(Sys, PS, _Type) ->
    case lists:member(Sys, data_jingyan:get_all_no()) of
        true ->
            case is_open(Sys, PS) of
                true ->
                    ok;
                false ->
                    {fail, ?PM_JINGYAN_NO_OPEN}
            end;
        false ->
            {fail, ?PM_JINGYAN_NOT_ALLOW}
    end.

calc_times(Sys, Days, List) ->
    lists:foldl(fun(Day, Acc) ->
        case lists:keyfind(Day, 1, List) of
            {Day, Count, State} when State == 0 ->
                max(get_max_times(Sys) - Count, 0) + Acc;
            false ->
                get_max_times(Sys) + Acc;
            _ ->
                Acc
        end
                        end, 0, Days).

is_open(Sys, PS) ->
    LvLimit = data_activity_degree:get_activity_open_lv(Sys),
    player:get_lv(PS) >= LvLimit.

%% @doc 获取可以找回经验的绝对天数，需要根据开服天数和创角时间计算
can_award_day(PS, Sys) ->
    CreateDays = util:get_differ_days_by_timestamp(player:get_create_time(PS), util:unixtime()) + 1,
    CurrentDay0 = min(CreateDays, util:get_server_open_nth_day()),
    #jingyan{day = CurrentDay1} = data_jingyan:get_jingyan(Sys),
    NowDays = util:get_now_days(),

    CurrentDay2 = min(CurrentDay0-1, CurrentDay1),
    lists:seq(NowDays-CurrentDay2, NowDays-1).



get_max_times(Sys) ->
    lib_activity_degree:get_sys_max_times(Sys).

set_all_info(List) ->
    NowDay = util:get_now_days(),
    MinDay = NowDay - 5,
    lists:foreach(fun({No, Info}) ->
        NewInfo = lists:filter(fun({Day,_Count, _State}) -> Day >= MinDay end, Info),
        put(?DICT_KEY_DAY(No), NewInfo)
        end, List),
    ok.


get_no(No) ->
    case get(?DICT_KEY_DAY(No)) of
        undefined -> [];
        L -> L
    end.

set_no(No, Day, Count) ->
    L = get_no(No),
    case lists:keyfind(Day, 1 , L) of
        {Day, OldCount, State} when OldCount < Count, State == 0 ->
            NewL = lists:keystore(Day, 1, L, {Day, Count, State}),
            put(?DICT_KEY_DAY(No), NewL);
        [] ->
            NewL = [{Day, Count, 0}|L],
            put(?DICT_KEY_DAY(No), NewL);
        _ ->
            skip
    end.

set_award_state(Sys, Days) ->
    L = get_no(Sys),
    NewL = lists:foldl(fun(Day, Acc) ->
        case lists:keyfind(Day, 1, Acc) of
            {Day, OldCount, _State} ->
                lists:keystore(Day, 1, Acc, {Day, OldCount, 1});
            false ->
                lists:keystore(Day, 1, Acc, {Day, 0, 1})
        end
        end, L, Days),
%%    NewL = [begin
%%         ?IF(lists:member(Day, Days),
%%             {Day, OldCount, 1},
%%             {Day, OldCount, State}
%%         )
%%     end || {Day, OldCount, State} <- L],

    put(?DICT_KEY_DAY(Sys), NewL).

pack_jingyan_info() ->
    lists:map(fun(No) ->
        {No, get_no(No)}
            end, data_jingyan:get_all_no()).
