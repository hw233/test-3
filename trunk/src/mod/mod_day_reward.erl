%%%-----------------------------------
%%% @Module  : mod_day_reward
%%% @Author  : zhangwq
%%% @Email   : 
%%% @Created : 2013.11.4
%%% @Description: 玩家每日签到与在线奖励接口
%%%-----------------------------------
-module(mod_day_reward).
-export([
        db_insert_player_day_reward/1,
        db_load_player_day_reward/1,
        db_save_player_day_reward/1,
        
        get_day_reward/1,
        get_day_reward_from_ets/1,
        add_day_reward_to_ets/1,
        update_day_reward_to_ets/1,
        del_day_reward_from_ets/1,
        mark_day_reward_dirty/1
    ]).

-include("common.hrl").
-include("reward.hrl").
-include("ets_name.hrl").


db_insert_player_day_reward(DayReward) ->
    LvRewardNoList_BS = util:term_to_bitstring(list_to_tuple(DayReward#day_reward.lv_reward_no_list)),
    db:insert(DayReward#day_reward.player_id, day_reward, [player_id, sign_info, sign_reward_info, last_sign_time, cur_no, last_get_reward_time, seven_day_reward, lv_reward_no_list], 
    [DayReward#day_reward.player_id, DayReward#day_reward.sign_info, DayReward#day_reward.sign_reward_info, DayReward#day_reward.last_sign_time, 
    DayReward#day_reward.cur_no, DayReward#day_reward.last_get_reward_time, DayReward#day_reward.seven_day_reward, LvRewardNoList_BS]).


db_load_player_day_reward(PlayerId) ->
    case db:select_row(day_reward, "player_id, sign_info, sign_reward_info, last_sign_time, cur_no, last_get_reward_time, seven_day_reward, lv_reward_no_list", [{player_id, PlayerId}], [], [1]) of
        [] ->
            NoList = data_day_reward:get_no_by_type(2),
            ?ASSERT(NoList /= []),
            DayReward = #day_reward{player_id = PlayerId, cur_no = erlang:hd(NoList), lv_reward_no_list = []},
            db_insert_player_day_reward(DayReward),
            add_day_reward_to_ets(DayReward),
            DayReward;
        [PlayerId, SignInfo, SignRewardInfo, LastSignTime, CurNo, LastGetRewardTime, SevenDayReward, LvRewardNoList_BS] ->
            DayReward = #day_reward{
                player_id = PlayerId,
                sign_info = SignInfo,
                sign_reward_info = SignRewardInfo,
                last_sign_time = LastSignTime,
                cur_no = CurNo,
                last_get_reward_time = LastGetRewardTime,
                seven_day_reward = SevenDayReward,
                lv_reward_no_list = case util:bitstring_to_term(LvRewardNoList_BS) of undefined -> []; Info -> tuple_to_list(Info) end
            },
            add_day_reward_to_ets(DayReward),
            DayReward
    end.


db_save_player_day_reward(PlayerId) ->
    ?ASSERT(is_integer(PlayerId), PlayerId),
    case get_day_reward_from_ets(PlayerId) of
        null -> skip;
        DayReward ->
            case is_dirty(DayReward) of
                false -> skip;
                true ->
                    LvRewardNoList_BS = util:term_to_bitstring(list_to_tuple(DayReward#day_reward.lv_reward_no_list)),
                    db:update(PlayerId, day_reward, ["sign_info", "sign_reward_info", "last_sign_time", "cur_no", "last_get_reward_time", "seven_day_reward", "lv_reward_no_list"], 
                    [DayReward#day_reward.sign_info, DayReward#day_reward.sign_reward_info, DayReward#day_reward.last_sign_time, 
                     DayReward#day_reward.cur_no, DayReward#day_reward.last_get_reward_time, DayReward#day_reward.seven_day_reward, LvRewardNoList_BS], 
                    "player_id", PlayerId)
            end
    end.


add_day_reward_to_ets(DayReward) when is_record(DayReward, day_reward) ->
    ets:insert(?ETS_DAY_REWARD, DayReward).


update_day_reward_to_ets(DayReward) when is_record(DayReward, day_reward) ->
    ets:insert(?ETS_DAY_REWARD, DayReward).


get_day_reward_from_ets(PlayerId) ->
    case ets:lookup(?ETS_DAY_REWARD, PlayerId) of
        [] -> null;
        [DayReward] -> DayReward
    end.

get_day_reward(PlayerId) ->
    case ets:lookup(?ETS_DAY_REWARD, PlayerId) of
        [] -> 
            db_load_player_day_reward(PlayerId);
        [DayReward] -> DayReward
    end.    

del_day_reward_from_ets(PlayerId) ->
    ets:delete(?ETS_DAY_REWARD, PlayerId).


mark_day_reward_dirty(DayReward) ->
    DayReward#day_reward{is_dirty = true}.

%% -------------------------------------------------------------Local Fun------------------------------------


is_dirty(DayReward) ->
    DayReward#day_reward.is_dirty.
