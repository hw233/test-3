%%%------------------------------------
%%% @author 严利宏 <542430172@qq.com>
%%% @copyright UCweb 2014.12.5
%%% @doc 圣诞活动 29.
%%% @end
%%%------------------------------------

-module(pp_christmas).
-export([handle/3]).

-include("common.hrl").
-include("record.hrl").
-include("player.hrl").
-include("prompt_msg_code.hrl").
-include("log.hrl").
-include("ets_name.hrl").
-include("pt_29.hrl").
-include("horse_race.hrl").

%%---------------------------------------------
% 290 跑马场
%%---------------------------------------------
%% 跑马场界面信息
handle(?PT_HORSE_RACE_INFO, PS, []) ->
    case lib_horse_race:get_ets_horse_race() of
        H=#ets_horse_race{} ->
            case catch mod_horse_race:get_horse_race_state() of
                HorseRace=#horse_race_state{} ->
                    % 自己的奖励信息、
                    {RewardHorseNo, RewardNum} = 
                        case dict:find(player:id(PS), HorseRace#horse_race_state.reward_players) of
                            error -> {0, 0};
                            {ok, {HorseNo, Num}} -> {HorseNo, Num}
                        end,
                    %上轮中奖马号
                    FirstHorseNo = HorseRace#horse_race_state.first_horse_no,
                    %当前是否可以竞猜
                    IsCanGambel = case lib_horse_race:check_horse_race_is_gamble(PS) of
                        ok ->
                            1;
                        {error, _} ->
                            0
                    end,
                    %当前已经竞猜了多少次
                    % CurGambelTime = case dict:find(player:id(PS), HorseRace#horse_race_state.player_gamble_times) of
                    %     error -> 0;
                    %     {ok, Value} -> Value
                    % end,
                    CurGambelTime = lib_horse_race:get_horse_race_already_join_times(PS),
                    % 基础信息
                    PassTime = max(util:unixtime()-H#ets_horse_race.time, 0),
                    {ok, BinData} = pt_29:write(?PT_HORSE_RACE_INFO, [H#ets_horse_race.status
                                                                     ,PassTime
                                                                     ,H#ets_horse_race.rank_type
                                                                     ,H#ets_horse_race.event_list
                                                                     ,RewardHorseNo
                                                                     ,RewardNum
                                                                     ,FirstHorseNo
                                                                     ,IsCanGambel
                                                                     ,CurGambelTime
                                                                 ]),
                    lib_send:send_to_sock(PS, BinData),
                    ?ylh_Debug("29000 ~p~n", [[player:id(PS), RewardHorseNo, RewardNum, PassTime, IsCanGambel, CurGambelTime]]),
                    ok;
                _ ->
                    lib_send:send_prompt_msg(PS, ?PM_HORSE_RACE_ERROR_SYS)
            end;
        _ ->
            lib_send:send_prompt_msg(PS, ?PM_HORSE_RACE_ERROR_NO_OPEN)
    end;

%% 跑马场竞猜
handle(?PT_HORSE_RACE_GAMBLE, PS, [HorseNo, Num]) ->
    ?ASSERT(lists:member(HorseNo, [1,2,3]), HorseNo),
    % 检查竞猜合法性
    case lib_horse_race:check_horse_race_gamble(PS, Num) of
        {error, ErrCode} -> 
            ?ylh_Debug("handle 29001 error~n"),
            lib_send:send_prompt_msg(PS, ErrCode);
        {ok, GoodsNum, YBNum} ->
            GoodsNo = data_horse_race:config(goods_no),
            % 消耗
            mod_inv:destroy_goods_WNC(player:id(PS), [{GoodsNo, GoodsNum}], [?LOG_HORSE_RACE, "gamble"]),
            player_syn:cost_money(PS, ?MNY_T_YUANBAO, YBNum, [?LOG_HORSE_RACE, "gamble"]),
            % 记录竞猜信息
            mod_horse_race:horse_race_gamble(PS, HorseNo, Num),
            % 将竞猜信息写入数据库中
            lib_horse_race:incr_horse_race_join_times(PS),
            % 回复客户端
            {ok, BinData} = pt_29:write(?PT_HORSE_RACE_GAMBLE, [0]),
            lib_send:send_to_sock(PS, BinData),
            %%统计玩家参与数
            lib_log:statis_role_action(PS, [], "horse_race", "join_horse_race", [1]),
            %%统计玩家对小马竞猜的数量
            lib_log:statis_role_action(PS, [], "horse_race", "gamble_horse_goods", [Num]),
            ok
    end;

%% 跑马场使用道具 （10sCD时间，前端也做一下预判）
handle(?PT_HORSE_RACE_USE_PROP, PS, [HorseNo, PropType, Num]) ->
    ?ASSERT(lists:member(HorseNo, [1,2,3]), HorseNo),
    ?ASSERT(lists:member(PropType, [1,2]), PropType),
    % 检查使用道具的合法性
    case lib_horse_race:check_horse_race_use_prop(PS, Num) of
        {error, ErrCode} ->
            lib_send:send_prompt_msg(PS, ErrCode);
        {ok, GoodsNum, RealNum, YBNum} ->
            GoodsNo = data_horse_race:config(goods_no),
            % 消耗
            mod_inv:destroy_goods_WNC(player:id(PS), [{GoodsNo, GoodsNum}], [?LOG_HORSE_RACE, "use_prop"]),
            case YBNum > 0 of
                true ->
                   player_syn:cost_money(PS, ?MNY_T_YUANBAO, YBNum, [?LOG_HORSE_RACE, "use_prop"]);
                false -> 
                    ok
            end,
            % 记录使用道具信息
            mod_horse_race:horse_race_use_prop(PS,HorseNo, PropType, RealNum),
            % 广播信息
            % 回复客户端
            {ok, BinData} = pt_29:write(?PT_HORSE_RACE_USE_PROP, [0, player:get_name(PS), HorseNo, PropType, Num]),
            case Num >= 100 of
                true ->
                    lib_send:send_to_all(BinData);
                false ->
                    lib_send:send_to_sock(PS, BinData)
            end,
            %%统计玩家对小马使用道具的数量
            lib_log:statis_role_action(PS, [], "horse_race", "use_horse_goods", [PropType, Num]),
            ok
    end;

%% 跑马场领取奖励
handle(?PT_HORSE_RACE_REWARD, PS, [RewardType]) ->
    ?ASSERT(lists:member(RewardType, [1,2]), RewardType),
    case lib_horse_race:check_horse_race_get_reward(PS, RewardType) of
        {error, ErrCode} ->
            lib_send:send_prompt_msg(PS, ErrCode);
        {ok, GoodsNo, GoodsNum} when RewardType=:=1 -> % 发物品
            % 发奖励
            mod_inv:batch_smart_add_new_goods(player:get_id(PS), [{GoodsNo, GoodsNum}], [{bind_state, 1}], [?LOG_HORSE_RACE, "reward"]),
            mod_horse_race:horse_race_get_reward(PS),
            % 判断是否可以竞猜
            IsCanGambel = case lib_horse_race:check_horse_race_is_gamble(PS) of
                        ok ->
                            1;
                        {error, _} ->
                            0
                    end,
            % 回复客户端
            {ok, BinData} = pt_29:write(?PT_HORSE_RACE_REWARD, [IsCanGambel]),
            lib_send:send_to_sock(PS, BinData),
            %%统计玩家胜负数
            lib_log:statis_role_action(PS, [], "horse_race", "win_horse_race", [RewardType, 1]),
            ok;
        {ok, BGamemoney} -> %  发绑银
            player:add_bind_gamemoney(PS, BGamemoney, [?LOG_HORSE_RACE, "reward"]),
            mod_horse_race:horse_race_get_reward(PS),
            % 判断是否可以竞猜
            IsCanGambel = case lib_horse_race:check_horse_race_is_gamble(PS) of
                        ok ->
                            1;
                        {error, _} ->
                            0
                    end,
            % 回复客户端
            {ok, BinData} = pt_29:write(?PT_HORSE_RACE_REWARD, [IsCanGambel]),
            lib_send:send_to_sock(PS, BinData),
            %%统计玩家胜负数
            lib_log:statis_role_action(PS, [], "horse_race", "win_horse_race", [RewardType, 1]),
            ok;
        _Reason ->
            ?ERROR_MSG("horse_race reward error!Reason:~p~n", [_Reason]),
            ?ASSERT(false, {player:id(PS), RewardType}),
            skip
    end,
    ok;

%% 获取各马的支持数
handle(?PT_HORSE_RACE_GET_HOSER_GAMBLE_INFO, PS, []) ->
    case catch mod_horse_race:get_horse_race_state() of
        HorseRace=#horse_race_state{} ->
            RacePlayers = case lib_horse_race:get_ets_horse_race() of
                                #ets_horse_race{status=?STATUS_GAMBLE} ->
                                    HorseRace#horse_race_state.race_players;
                                _ ->
                                    HorseRace#horse_race_state.next_race_players
                        end,
            %RacePlayers = HorseRace#horse_race_state.race_players,
            ?ylh_Debug("get_horse_gamble_info ~p~n", [RacePlayers]),
            {S1,S2,S3} = lib_horse_race:calc_suport_num(dict:to_list(RacePlayers), {0,0,0}),
            ?ylh_Debug("get_horse_info ~p~n", [[S1,S2,S3, dict:to_list(RacePlayers)]]),
            {ok, BinData} = pt_29:write(?PT_HORSE_RACE_GET_HOSER_GAMBLE_INFO, [S1,S2,S3]),
            lib_send:send_to_sock(PS, BinData),
            ok;
        _ ->
            lib_send:send_prompt_msg(PS, ?PM_HORSE_RACE_ERROR_SYS)
    end;

%% 购买跑马卷数量
handle(?PT_HORSE_RACE_BUY_GOOD, PS, [Num]) ->
    %%检测购买跑马卷所需要的元宝是否足够
    case lib_horse_race:check_horse_race_buy_good(PS, Num) of
        {error, ErrCode} ->
            lib_send:send_prompt_msg(PS, ErrCode);
        {ok, GoodsNum, YBNum} -> 
            GoodsNo = data_horse_race:config(goods_no),
            mod_inv:batch_smart_add_new_goods(player:get_id(PS), [{GoodsNo, GoodsNum}], [{bind_state, 1}], [?LOG_HORSE_RACE, "buyGood"]),
            player_syn:cost_money(PS, ?MNY_T_YUANBAO, YBNum, [?LOG_HORSE_RACE, "buyGood"]),
            % 回复客户端
            {ok, BinData} = pt_29:write(?PT_HORSE_RACE_BUY_GOOD, [0]),
            lib_send:send_to_sock(PS, BinData),
            %统计玩家购买跑马券的数量
            lib_log:statis_role_action(PS, [], "horse_race", "buy_horse_goods", [Num]),
            ok;
        _Reason ->
            ?ERROR_MSG("horse_race reward error!Reason:~p~n", [_Reason]),
            skip
    end,
    ok;
%%---------------------------------------------
% 291 xxx
%%---------------------------------------------

handle(29101, Status, _) ->
    mod_global_collection:query_snowman(Status),
    ok;

handle(29102, Status, _) ->
    mod_global_collection:collection_snowman(Status),
    ok;


handle(_Msg, _PS, _) ->
    ?WARNING_MSG("unknown handle ~p", [_Msg]),
    error.



