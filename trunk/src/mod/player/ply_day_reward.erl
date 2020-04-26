%%%--------------------------------------
%%% @Module  : ply_day_reward
%%% @Author  : zhangwq
%%% @Email   : 
%%% @Created : 2014.03.14
%%% @Description: 玩家的每日签到与在线奖励相关的业务逻辑
%%%--------------------------------------

-module(ply_day_reward).
-export([
        get_day_sign_in_info/1,             %% 询本月的每日签到以及奖励领取情况
        sign_in/1,                          %% 每日签到
        get_sign_in_reward/2,               %% 领取每日签到的奖励 

        get_online_reward_info/1,           %% 查询当前的在线奖励情况
        get_online_reward/2,                %% 领取当前的在线奖励

        get_seven_day_reward_info/1,        %% 查询当前的7天礼包奖励情况
        get_seven_day_reward/2,             %% 领取当前的7天登陆奖励

        get_lv_reward_info/1,
        get_lv_reward/2,
        
        gm_do_sign_in/2
    ]).

-include("common.hrl").
-include("reward.hrl").
-include("prompt_msg_code.hrl").
-include("abbreviate.hrl").
-include("log.hrl").
-include("goods.hrl").


%% return null | day_reward 结构体
get_day_sign_in_info(PS) ->
    PlayerId = player:id(PS),
    DayReward = mod_day_reward:get_day_reward(PlayerId),
    if
        DayReward#day_reward.last_sign_time =:= 0 ->
            DayReward;
        true ->
            MonthNow = util:get_month(),
            {{_Y, M, _D}, _} = util:stamp_to_date(DayReward#day_reward.last_sign_time, 5),
            case MonthNow =:= M of
                true -> DayReward;
                false -> 
                    NewDayReward = DayReward#day_reward{sign_info = 0, sign_reward_info = 0},
                    mod_day_reward:update_day_reward_to_ets(mod_day_reward:mark_day_reward_dirty(NewDayReward)),
                    NewDayReward
            end
    end.


sign_in(PS) ->
    case check_sign_in(PS) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, DayReward, FestivalRewardNo} ->
            do_sign_in(PS, DayReward, FestivalRewardNo)
    end.


get_sign_in_reward(PS, No) ->
    case check_get_sign_in_reward(PS, No) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, DayReward} ->
            do_get_sign_in_reward(PS, No, DayReward)
    end.


get_online_reward_info(PS) ->
    PlayerId = player:id(PS),
    NoList = data_day_reward:get_no_by_type(2),
    ?ASSERT(NoList /= []),
    DayReward = mod_day_reward:get_day_reward(PlayerId),

    if
        DayReward#day_reward.last_get_reward_time =:= 0 ->
            NewDayReward = DayReward#day_reward{cur_no = erlang:hd(NoList)},
            mod_day_reward:update_day_reward_to_ets(mod_day_reward:mark_day_reward_dirty(NewDayReward)),
            NewDayReward;
        true ->
            case util:is_same_day(DayReward#day_reward.last_get_reward_time) of
                true -> DayReward;
                false -> 
                    NewDayReward = DayReward#day_reward{cur_no = erlang:hd(NoList), last_get_reward_time = 0},
                    mod_day_reward:update_day_reward_to_ets(mod_day_reward:mark_day_reward_dirty(NewDayReward)),
                    NewDayReward
            end
    end.



get_online_reward(PS, CurNo) ->
    case check_get_online_reward(PS, CurNo) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, DayReward} ->
            do_get_online_reward(PS, CurNo, DayReward)
    end.


get_seven_day_reward_info(PS) ->
    PlayerId = player:id(PS),
    DayReward = mod_day_reward:get_day_reward(PlayerId), 
    DayReward.


get_lv_reward_info(PS) ->
    PlayerId = player:id(PS),
    mod_day_reward:get_day_reward(PlayerId).


get_seven_day_reward(PS, CurNo) ->
    case check_get_seven_day_reward(PS, CurNo) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, DayReward} ->
            do_get_seven_day_reward(PS, CurNo, DayReward)
    end.

get_lv_reward(PS, No) ->
    case check_get_lv_reward(PS, No) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, DayReward} ->
            do_get_lv_reward(PS, No, DayReward)
    end.    


gm_do_sign_in(PS, Day) ->
    PlayerId = player:id(PS),
    DayReward = get_day_sign_in_info(PS),
    case DayReward of
        null ->
            NewDayReward = #day_reward{
                        player_id = PlayerId, 
                        sign_info = 0 bor util:ceil(math:pow(2, Day - 1)),
                        last_sign_time = svr_clock:get_unixtime()
                        },
            mod_day_reward:add_day_reward_to_ets(NewDayReward),
            mod_day_reward:db_insert_player_day_reward(NewDayReward);
        _DayReward ->
            NewDayReward = DayReward#day_reward{
                        sign_info = DayReward#day_reward.sign_info bor util:ceil(math:pow(2, Day - 1)),
                        last_sign_time = svr_clock:get_unixtime()
                        },
            mod_day_reward:update_day_reward_to_ets(mod_day_reward:mark_day_reward_dirty(NewDayReward))
    end,
    ok.

%% -----------------------------------------------Local Fun----------------------------------------


check_get_lv_reward(PS, No) ->
    DayReward = get_lv_reward_info(PS),
    case data_lv_reward:get(No) of
        null -> {fail, ?PM_DATA_CONFIG_ERROR};
        Data ->
            case lists:member(No, DayReward#day_reward.lv_reward_no_list) of
                true -> {fail, ?PM_HAVE_GET_THE_REWARD};
                false ->
                    case player:get_lv(PS) < Data#lv_reward.lv of
                        true -> {fail, ?PM_LV_LIMIT};
                        false ->
                            case data_reward_pkg:get(Data#lv_reward.reward_no) of
                                null -> {fail, ?PM_DATA_CONFIG_ERROR};
                                _ ->
                                    case lib_reward:check_bag_space(PS, Data#lv_reward.reward_no) of
                                        ok -> {ok, DayReward};
                                        {fail, Reason} -> {fail, Reason}
                                    end
                            end
                    end
            end
    end.


do_get_lv_reward(PS, No, DayReward) ->
    lib_reward:give_reward_to_player(PS, (data_lv_reward:get(No))#lv_reward.reward_no, [?LOG_ROLE, "leveling"]),

    NewDayReward = DayReward#day_reward{lv_reward_no_list = [No | DayReward#day_reward.lv_reward_no_list]},
    NewDayReward1 = mod_day_reward:mark_day_reward_dirty(NewDayReward),
    mod_day_reward:update_day_reward_to_ets(NewDayReward1),
    mod_day_reward:db_save_player_day_reward(player:id(PS)),
    ok.

check_get_seven_day_reward(PS, CurNo) ->
    try check_get_seven_day_reward__(PS, CurNo) of
        {ok, DayReward} -> 
            {ok, DayReward}
    catch 
        throw: FailReason ->
            {fail, FailReason}
    end.


check_get_seven_day_reward__(PS, CurNo) ->
    DayReward = get_seven_day_reward_info(PS),
    ?Ifc (DayReward =:= null)
        throw(?PM_UNKNOWN_ERR)
    ?End,

    DataCfg = data_day_reward:get(CurNo),
    ?Ifc (DataCfg =:= null)
        throw(?PM_PARA_ERROR)
    ?End,

    CreateTime = player:get_create_time(PS),
    Day = util:get_nth_day_from_time_to_now(CreateTime),
    ?Ifc (DataCfg#day_reward_cfg.condition < Day)
        throw(?PM_SEVEN_DAY_REWARD_EXPIRE)
    ?End,

    ?Ifc (DataCfg#day_reward_cfg.condition > Day)
        throw(?PM_GET_SEVEN_DAY_REWARD_TIME_LIMIT)
    ?End,

    case DayReward#day_reward.seven_day_reward band util:ceil(math:pow(2, Day - 1)) of
        0 -> 
            case lib_reward:check_bag_space(PS, DataCfg#day_reward_cfg.reward_no) of
                {fail, Reason} -> throw(Reason);
                ok -> {ok, DayReward};
                _Any ->
                    ?ASSERT(false, _Any),
                    throw(?PM_UNKNOWN_ERR)
            end;
        _Any -> throw(?PM_HAVE_GET_THE_REWARD)
    end.



check_get_online_reward(PS, CurNo) ->
    try check_get_online_reward__(PS, CurNo) of
        {ok, DayReward} -> 
            {ok, DayReward}
    catch 
        throw: FailReason ->
            {fail, FailReason}
    end.

check_get_online_reward__(PS, CurNo) ->
    DayReward = get_online_reward_info(PS),
    ?Ifc (DayReward =:= null)
        throw(?PM_UNKNOWN_ERR)
    ?End,

    ?Ifc (DayReward#day_reward.cur_no =/= CurNo)
        throw(?PM_HAVE_GET_THE_REWARD)
    ?End,

    ?Ifc (DayReward#day_reward.cur_no > CurNo)
        throw(?PM_HAVE_GET_THE_REWARD)
    ?End,
    
    ?Ifc (CurNo =:= ?INVALID_NO)
        throw(?PM_GET_ONLINE_REWARD_OVER)
    ?End,
    
    DataCfg = data_day_reward:get(CurNo),
    ?Ifc (DataCfg =:= null)
        throw(?PM_PARA_ERROR)
    ?End,

    NoList = data_day_reward:get_no_by_type(2),
    ?Ifc (NoList =:= [])
        throw(?PM_PARA_ERROR)
    ?End,

    Time = DataCfg#day_reward_cfg.condition,
    ?Ifc (svr_clock:get_unixtime() < Time + DayReward#day_reward.last_get_reward_time)
        throw(?PM_GET_REWARD_ONLINE_TIME_LIMIT)
    ?End,

    case lib_reward:check_bag_space(PS, DataCfg#day_reward_cfg.reward_no) of
        {fail, Reason} -> throw(Reason);
        ok -> {ok, DayReward}
    end.


do_get_online_reward(PS, CurNo, DayReward) ->
    DataCfg = data_day_reward:get(CurNo),
    NoList = data_day_reward:get_no_by_type(2),
    ?ASSERT(NoList /= []),
    NewCurNo = 
        case lists:last(NoList) =:= CurNo of
            true -> ?INVALID_NO;
            false -> CurNo + 1
        end,
    NewDayReward = DayReward#day_reward{last_get_reward_time = svr_clock:get_unixtime(), cur_no = NewCurNo},
    NewDayReward1 = mod_day_reward:mark_day_reward_dirty(NewDayReward),
    mod_day_reward:update_day_reward_to_ets(NewDayReward1),
    mod_day_reward:db_save_player_day_reward(player:id(PS)),
    lib_reward:give_reward_to_player(PS, DataCfg#day_reward_cfg.reward_no, [?LOG_ONLINE_PRIZE, "prize"]),
    {ok, NewDayReward1}.


do_get_seven_day_reward(PS, CurNo, DayReward) ->
    DataCfg = data_day_reward:get(CurNo),
    Day = DataCfg#day_reward_cfg.condition,
    ?ASSERT(Day >= 1 andalso Day =< 7, Day),
    NewDayReward = DayReward#day_reward{seven_day_reward = DayReward#day_reward.seven_day_reward bor util:ceil(math:pow(2, Day - 1))},
    mod_day_reward:update_day_reward_to_ets(mod_day_reward:mark_day_reward_dirty(NewDayReward)),
    mod_day_reward:db_save_player_day_reward(player:id(PS)),
    lib_reward:give_reward_to_player(PS, DataCfg#day_reward_cfg.reward_no, [?LOG_ONLINE_PRIZE, "prize"]),
    {ok, NewDayReward}.


check_get_sign_in_reward(PS, No) ->
    try check_get_sign_in_reward__(PS, No) of
        {ok, DayReward} -> 
            {ok, DayReward}
    catch 
        throw: FailReason ->
            {fail, FailReason}
    end.

check_get_sign_in_reward__(PS, No) ->
    DayReward = get_day_sign_in_info(PS),
    ?Ifc (DayReward =:= null)
        throw(?PM_HAVE_NOT_SIGN_IN)
    ?End,

    DataCfg = data_day_reward:get(No),
    ?Ifc (DataCfg =:= null)
        throw(?PM_PARA_ERROR)
    ?End,

    Count = DataCfg#day_reward_cfg.condition,
    NumOf1 = get_num_of_1_in_binary(DayReward#day_reward.sign_info),
    ?TRACE("NumOf1:~p~n", [NumOf1]),
    ?Ifc (Count > NumOf1)
        throw(?PM_GET_SIGN_REWARD_TIME_LIMIT)
    ?End,

    case DayReward#day_reward.sign_reward_info band util:ceil(math:pow(2, Count - 1)) of
        0 -> 
            case lib_reward:check_bag_space(PS, DataCfg#day_reward_cfg.reward_no) of
                {fail, Reason} -> throw(Reason);
                ok -> {ok, DayReward}
            end;
        _Any -> throw(?PM_HAVE_GET_THE_REWARD)
    end.


do_get_sign_in_reward(PS, No, DayReward) ->
    DataCfg = data_day_reward:get(No),
    Count = DataCfg#day_reward_cfg.condition,
    NewDayReward = DayReward#day_reward{sign_reward_info = DayReward#day_reward.sign_reward_info bor util:ceil(math:pow(2, Count - 1))},
    mod_day_reward:update_day_reward_to_ets(mod_day_reward:mark_day_reward_dirty(NewDayReward)),
    mod_day_reward:db_save_player_day_reward(player:id(PS)),
    lib_reward:give_reward_to_player(PS, DataCfg#day_reward_cfg.reward_no, [?LOG_ONLINE_PRIZE, "prize"]),
    ok.


check_sign_in(PS) ->
    DateInt = list_to_integer(binary_to_list(util:stamp_to_date(util:unixtime(), 4))),
    No = get_festival_reward_no(DateInt),
    GoodsList = 
        case No =:= ?INVALID_NO of
            true ->
                Day = util:get_day(),
                Data = data_day_reward_com:get(Day),
                [{Data#data_reward_cfg_1.goods_no, Data#data_reward_cfg_1.goods_count}];
            false ->
                Data = data_festival_reward:get(No),
                [{Data#data_reward_cfg_1.goods_no, Data#data_reward_cfg_1.goods_count}]
        end,

    case get_day_sign_in_info(PS) of
        null -> 
            case mod_inv:check_batch_add_goods(player:get_id(PS), GoodsList) of
                {fail, Reason} -> {fail, Reason};
                ok -> {ok, null, No}
            end;
        DayReward ->
            if 
                DayReward#day_reward.last_sign_time =:= 0 ->
                    case mod_inv:check_batch_add_goods(player:get_id(PS), GoodsList) of
                        {fail, Reason} -> {fail, Reason};
                        ok -> {ok, DayReward, No}
                    end;
                true ->
                    case util:is_same_day(DayReward#day_reward.last_sign_time) of
                        true -> {fail, ?PM_HAVE_SIGN_IN_TODAY};
                        false -> 
                            case mod_inv:check_batch_add_goods(player:get_id(PS), GoodsList) of
                                {fail, Reason} -> {fail, Reason};
                                ok -> {ok, DayReward, No}
                            end
                    end
            end
    end.


do_sign_in(PS, DayReward, FestivalRewardNo) ->
    PlayerId = player:id(PS),
    Day = util:get_day(),
    case DayReward of
        null ->
            NewDayReward = #day_reward{
                        player_id = PlayerId, 
                        sign_info = 0 bor util:ceil(math:pow(2, Day - 1)),
                        last_sign_time = svr_clock:get_unixtime()
                        },
            mod_day_reward:add_day_reward_to_ets(NewDayReward),
            mod_day_reward:db_insert_player_day_reward(NewDayReward);
        _DayReward ->
            NewDayReward = DayReward#day_reward{
                        sign_info = DayReward#day_reward.sign_info bor util:ceil(math:pow(2, Day - 1)),
                        last_sign_time = svr_clock:get_unixtime()
                        },
            mod_day_reward:update_day_reward_to_ets(mod_day_reward:mark_day_reward_dirty(NewDayReward))
    end,
    give_day_reward_to_player(PS, Day, FestivalRewardNo),
    ok.


%% 求一个整数的二进制中1的个数
get_num_of_1_in_binary(Value) ->
    get_num_of_1_in_binary(Value, 0).

get_num_of_1_in_binary(0, Count) ->
    Count;
get_num_of_1_in_binary(Value, Count) ->
    TValue = (Value - 1) band Value,
    get_num_of_1_in_binary(TValue, Count + 1).


get_festival_reward_no(DateInt) ->
    get_festival_reward_no(DateInt, data_festival_reward:get_all_festival()).

get_festival_reward_no(_DateInt, []) ->
    ?INVALID_NO;
get_festival_reward_no(DateInt, [H | T]) ->
    case DateInt =:= H of
        true -> H;
        false -> get_festival_reward_no(DateInt, T)
    end.

give_day_reward_to_player(PS, Day, FestivalRewardNo) ->
    Data = 
        case FestivalRewardNo =:= ?INVALID_NO of
            true ->
                data_day_reward_com:get(Day);
            false ->
                data_festival_reward:get(FestivalRewardNo)
        end,

    case Data =:= null of
        true -> skip;
        false ->
            GoodsList = [{Data#data_reward_cfg_1.goods_no, Data#data_reward_cfg_1.goods_count}],
            mod_inv:batch_smart_add_new_goods(player:get_id(PS), GoodsList, [{bind_state, ?BIND_ALREADY}], [?LOG_ONLINE_PRIZE, "prize"]),

            % 修改为铜币
            player:add_copper(PS, Data#data_reward_cfg_1.bind_gold, [?LOG_ONLINE_PRIZE, "prize"]),
            player:add_bind_gamemoney(PS, Data#data_reward_cfg_1.bind_silver, [?LOG_ONLINE_PRIZE, "prize"])
    end.

