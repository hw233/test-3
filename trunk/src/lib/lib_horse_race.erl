%%%------------------------------------
%%% @author 严利宏 <542430172@qq.com>
%%% @copyright UCweb 2014.12.5
%%% @doc 跑马场 函数库.
%%% @end
%%%------------------------------------

-module(lib_horse_race).

-include("common.hrl").
-include("record.hrl").
-include("prompt_msg_code.hrl").
-include("ets_name.hrl").
-include("log.hrl").
-include("goods.hrl").
-include("task.hrl").
-include("horse_race.hrl").
-include("activity_degree_sys.hrl").
-include("abbreviate.hrl").
-include("pt_29.hrl").
-include("sys_code_2.hrl").

-compile(export_all).
-export([]).

%%------------------------------------
%% 跑马场竞猜
%%------------------------------------
check_horse_race_gamble(PS, Num) ->
    case get_ets_horse_race() of
        null ->
            % 活动未开启
            {error, ?PM_HORSE_RACE_ERROR_NO_OPEN};
        #ets_horse_race{status=?STATUS_CLOSE} ->
            % 活动已经结束
            {error, ?PM_HORSE_RACE_ERROR_CLOSE};
%        #ets_horse_race{status=?STATUS_RACE} ->
%            % 比赛阶段不能竞猜
%            {error, ?PM_HORSE_RACE_ERROR_RACE};
        _ ->
            case catch mod_horse_race:get_horse_race_state() of
                _HorseRace=#horse_race_state{} ->
                    % CurGambelTime = case dict:find(player:id(PS), HorseRace#horse_race_state.player_gamble_times) of
                    %     error -> 0;
                    %     {ok, Value} -> Value
                    % end,
                    %从数据库中读取已参加跑马次数，主要是防上活动中重启服务导致内存清除，数据不对问题
                    CurGambelTime = get_horse_race_already_join_times(PS),
                    % CurGambelTime1 = case CurGambelTime == AlreadyGambelTime of
                    %                         true ->
                    %                             CurGambelTime;
                    %                         false ->
                    %                             %重新将数据写入内存中
                    %                             mod_horse_race:set_horse_gamble_time(PS, AlreadyGambelTime),
                    %                             AlreadyGambelTime
                    % end,
                    MaxGambelTime = data_horse_race:config(max_gamble_times),
                    case CurGambelTime =< MaxGambelTime of
                        true ->
                            case can_join_horse_race_gamble(PS) of
                                {error, ErrCode} -> {error, ErrCode};
                                ok ->
                                    CostGoodsNo = data_horse_race:config(goods_no),
                                    BaseYB = data_horse_race:config(base_yuanbao),
                                    PlayerId = player:id(PS),
                                    HasCostGoodsNum = mod_inv:get_goods_count_in_bag_by_no(PlayerId, CostGoodsNo),
                                    case HasCostGoodsNum >= Num of
                                        true -> {ok, Num, 0};
                                        false -> % 道具不足则先消耗拥有的道具再消耗金子
                                            ShouldCostYB = (Num - HasCostGoodsNum) * BaseYB,
                                            case player:has_enough_money(PS, ?MNY_T_YUANBAO, ShouldCostYB) of
                                                false -> {error, ?PM_HORSE_RACE_ERROR_MONEY_LIMIT};
                                                true -> 
                                                    %%统计玩家使用跑马券的购买量
                                                    lib_log:statis_role_action(PS, [], "horse_race", "buy_horse_goods", [Num - HasCostGoodsNum]),
                                                    {ok, HasCostGoodsNum, ShouldCostYB}       
                                            end
                                    end
                            end;
                        false ->
                            {error, ?PM_HORSE_RACE_ERROR_MAX_LIMIT} 
                    end;
                _ ->
                    {error, ?PM_HORSE_RACE_ERROR_SYS}  
            end
            % case can_join_horse_race_gamble(PS) of
            %     {error, ErrCode} -> {error, ErrCode};
            %     ok ->
            %         CostGoodsNo = data_horse_race:config(goods_no),
            %         BaseYB = data_horse_race:config(base_yuanbao),
            %         PlayerId = player:id(PS),
            %         HasCostGoodsNum = mod_inv:get_goods_count_in_bag_by_no(PlayerId, CostGoodsNo),
            %         case HasCostGoodsNum >= Num of
            %             true -> {ok, Num, 0};
            %             false -> % 道具不足则先消耗拥有的道具再消耗金子
            %                 ShouldCostYB = (Num - HasCostGoodsNum) * BaseYB,
            %                 case player:has_enough_money(PS, ?MNY_T_YUANBAO, ShouldCostYB) of
            %                     false -> {error, ?PM_HORSE_RACE_ERROR_MONEY_LIMIT};
            %                     true -> {ok, HasCostGoodsNum, ShouldCostYB}
            %                 end
            %         end
            % end
    end.

% 检查跑马场状态信息
can_join_horse_race_gamble(PS) ->
    PlayerId = player:id(PS),
    case catch mod_horse_race:get_horse_race_state() of
        HorseRace=#horse_race_state{} ->
            Players = case get_ets_horse_race() of
                                #ets_horse_race{status=?STATUS_GAMBLE} ->
                                    HorseRace#horse_race_state.race_players;
                                _ ->
                                    HorseRace#horse_race_state.next_race_players
                        end,
            %case dict:find(PlayerId, HorseRace#horse_race_state.race_players) of
            case dict:find(PlayerId, Players) of
                {ok, _} -> 
                    % 已经竞猜过了不能再竞猜
                    {error, ?PM_HORSE_RACE_ERROR_ALREADY_JOIN};
                error ->
                    case dict:find(PlayerId, HorseRace#horse_race_state.reward_players) of
                        {ok, _} -> 
                            % 有奖励未领取不能竞猜
                            {error, ?PM_HORSE_RACE_ERROR_HAS_REWARD};
                        error -> 
                            case player:get_lv(PS) < data_horse_race:config(min_lv) of
                                true -> {error, ?PM_HORSE_RACE_ERROR_LV_LIMIT};
                                false -> ok
                            end
                    end
            end;
        _ -> 
            {error, ?PM_HORSE_RACE_ERROR_SYS}
    end.

% 检查跑马场比赛阶段信息
can_join_horse_next_race_gamble(PS) ->
    PlayerId = player:id(PS),
    case catch mod_horse_race:get_horse_race_state() of
        HorseRace=#horse_race_state{} ->
            case dict:find(PlayerId, HorseRace#horse_race_state.next_race_players) of
                {ok, _} -> 
                    % 已经竞猜过了不能再竞猜
                    {error, ?PM_HORSE_RACE_ERROR_ALREADY_JOIN};
                error ->
                    case dict:find(PlayerId, HorseRace#horse_race_state.reward_players) of
                        {ok, _} -> 
                            % 有奖励未领取不能竞猜
                            {error, ?PM_HORSE_RACE_ERROR_HAS_REWARD};
                        error -> 
                            case player:get_lv(PS) < data_horse_race:config(min_lv) of
                                true -> {error, ?PM_HORSE_RACE_ERROR_LV_LIMIT};
                                false -> ok
                            end
                    end
            end;
        _ -> 
            {error, ?PM_HORSE_RACE_ERROR_SYS}
    end.

%%------------------------------------
%% 检查跑马场是否有竞猜过
%%------------------------------------
check_horse_race_is_gamble(PS) ->
    case get_ets_horse_race() of
        null ->
            % 活动未开启
            {error, ?PM_HORSE_RACE_ERROR_NO_OPEN};
        #ets_horse_race{status=?STATUS_CLOSE} ->
            % 活动已经结束
            {error, ?PM_HORSE_RACE_ERROR_CLOSE};
       #ets_horse_race{status=?STATUS_GAMBLE} ->
           % 竞猜阶段
           ?ylh_Debug("check_horse_race_is_gamble, STATUS_GAMBLE~n"),
           case can_join_horse_race_gamble(PS) of
                {error, ErrCode} -> {error, ErrCode};
                ok -> ok
           end;
        #ets_horse_race{status=?STATUS_RACE} ->
            %比赛阶段
            ?ylh_Debug("check_horse_race_is_gamble, STATUS_RACE~n"),
            case can_join_horse_next_race_gamble(PS) of
                {error, ErrCode} -> {error, ErrCode};
                ok -> ok
           end;
        _ ->
            {error, ?PM_HORSE_RACE_ERROR_SYS}
    end.

%%------------------------------------
%% 跑马场使用道具
%%------------------------------------
check_horse_race_use_prop(PS, Num) ->
    case get_ets_horse_race() of
        null ->
            % 活动未开启
            {error, ?PM_HORSE_RACE_ERROR_NO_OPEN};
        #ets_horse_race{status=?STATUS_GAMBLE} ->
            % 竞猜阶段不能使用道具
            {error, ?PM_HORSE_RACE_ERROR_USE_PROP_IN_GAMBLE};
        _ ->
            case catch mod_horse_race:get_horse_race_state() of
                HorseRace=#horse_race_state{} ->
                    % 自己的奖励信息、
                    LastUsePropTime = 
                        case dict:find(player:id(PS), HorseRace#horse_race_state.use_prop_time) of
                            error -> 0;
                            {ok, Value} -> Value
                        end,
                    CurUsePropTime = util:unixtime(),
                    MaxUseCDTime = data_horse_race:config(max_use_prop_time),
                    case (CurUsePropTime - LastUsePropTime) > MaxUseCDTime of
                        true->
                            CostGoodsNo = data_horse_race:config(goods_no),
                            BaseYB = data_horse_race:config(base_yuanbao),
                            PlayerId = player:id(PS),
                            HasCostGoodsNum = mod_inv:get_goods_count_in_bag_by_no(PlayerId, CostGoodsNo),
                            case HasCostGoodsNum < Num of
                                true -> 
                                    % 跑马卷不足
                                    % {error, ?PM_HORSE_RACE_ERROR_USE_PROP_GOODS_LIMIT};
                                    ShouldCostYB = (Num - HasCostGoodsNum) * BaseYB,
                                    case player:has_enough_money(PS, ?MNY_T_YUANBAO, ShouldCostYB) of
                                        false -> {error, ?PM_HORSE_RACE_ERROR_MONEY_LIMIT};
                                        true ->
                                            %%统计玩家使用跑马券的购买量
                                            lib_log:statis_role_action(PS, [], "horse_race", "buy_horse_goods", [Num - HasCostGoodsNum]),
                                            {ok, HasCostGoodsNum, Num, ShouldCostYB}
                                    end;
                                false ->
                                    {ok, Num, Num, 0}
                            end;
                        false ->
                          {error, ?PM_HORSE_RACE_ERROR_MAX_USE_PROP_CD_TIME}  
                    end;
                _ ->
                    {error, ?PM_HORSE_RACE_ERROR_SYS}
            end
            % CostGoodsNo = data_horse_race:config(goods_no),
            % PlayerId = player:id(PS),
            % HasCostGoodsNum = mod_inv:get_goods_count_in_bag_by_no(PlayerId, CostGoodsNo),
            % case HasCostGoodsNum < Num of
            %     true -> 
            %         % 跑马卷不足
            %         {error, ?PM_HORSE_RACE_ERROR_USE_PROP_GOODS_LIMIT};
            %     false ->
            %         ok
            % end
    end.

%%------------------------------------
%% 跑马场结束处理
%%------------------------------------
% 单场结束结算
horse_race_end(?STATUS_RACE, State, EtsHorseRace) ->
    RankType = EtsHorseRace#ets_horse_race.rank_type,
    FirstHorseNo = get_first_horse_by_rank_type(RankType),
    RacePlayerList = dict:to_list(State#horse_race_state.race_players),
    WinPlayerList = [ P || P={_, {HorseNo, _}} <- RacePlayerList, HorseNo=:=FirstHorseNo],
    Fun = fun(_Key, _V1, V2) -> V2 end,
    NewRewardPlayers = dict:merge(Fun, State#horse_race_state.reward_players, dict:from_list(WinPlayerList)),
    State#horse_race_state{reward_players=NewRewardPlayers,first_horse_no=FirstHorseNo};
% 活动结束结算
horse_race_end(?STATUS_CLOSE, State, _EtsHorseRace) ->
    State.

%%------------------------------------
%% 跑马场领取奖励
%%------------------------------------
check_horse_race_get_reward(PS, RewardType) ->
    case catch mod_horse_race:get_horse_race_state() of
        HorseRace=#horse_race_state{} ->
            case dict:find(player:id(PS), HorseRace#horse_race_state.reward_players) of
                error -> 
                    % 没有奖励信息
                    {error, ?PM_HORSE_RACE_ERROR_NO_REWARD};
                {ok, {_HorseNo, Num}} when RewardType=:=1 -> %选择跑马券
                    % 选择跑马券则判断格子数
                    GoodsNo = data_horse_race:config(goods_no),
                    GoodsNum = proplists:get_value(Num, data_horse_race:config(reward_goods), 0),
                    case mod_inv:check_batch_add_goods(player:get_id(PS), [{GoodsNo, GoodsNum}]) of
                        {fail, _Reason} -> {error, _Reason};
                        ok -> {ok, GoodsNo, GoodsNum}
                    end;
                {ok, {_HorseNo, Num}} when RewardType=:=2 -> % 选择绑银
                    BGamemoney = proplists:get_value(Num, data_horse_race:config(reward_bgamemoney), 0),
                    {ok, BGamemoney};
                _ ->
                    {error, ?PM_HORSE_RACE_ERROR_SYS}
            end;
        _ -> 
            {error, ?PM_HORSE_RACE_ERROR_SYS}
    end.

%%------------------------------------
%% 跑马场购买跑马卷
%%------------------------------------
check_horse_race_buy_good(PS, Num) ->
    case get_ets_horse_race() of
        null ->
            % 活动未开启
            {error, ?PM_HORSE_RACE_ERROR_NO_OPEN};
        _ ->
            BaseYB = data_horse_race:config(base_yuanbao),
            ShouldCostYB = Num * BaseYB,
            case player:has_enough_money(PS, ?MNY_T_YUANBAO, ShouldCostYB) of
                false -> {error, ?PM_HORSE_RACE_ERROR_MONEY_LIMIT};
                true -> {ok, Num, ShouldCostYB}
            end
    end.
%%------------------------------------
%% 跑马场比赛结果计算
%%------------------------------------
%@return {NewState, RankType, EventList}
get_horse_race_result(State=#horse_race_state{race_players       = Players
                                             ,race_props_good    = PropsGood
                                             ,race_props_bad     = PropsBad 
                                             ,last_event_ratio   = RatioLastEvent
                                         }) ->
    % 计算基础概率
    {BaseRatio1, BaseRatio2, BaseRatio3} = 
        case dict:size(Players) of
            0 -> {33333, 33333, 33333};
            _ ->
                calc_base_ratio(dict:to_list(Players))
        end,
    % 随机特殊事件
    EventList = rand_event_list(),
    {{RatioEvent1, RatioEvent2, RatioEvent3}, NextRoundEventRatio} = calc_ratio_event(EventList),
    % 上次特殊事件产生的概率变化
    {RatioLast1, RatioLast2, RatioLast3} = RatioLastEvent,
    % 使用道具产生的概率变化
    {RatioProp1, RatioProp2, RatioProp3} = calc_prop_ratio(PropsGood, PropsBad),

    %计算第一匹马的胜率
    Ratio1 = if 
                BaseRatio1+RatioEvent1+RatioLast1+RatioProp1 =< 0 -> 0;
                BaseRatio1+RatioEvent1+RatioLast1+RatioProp1 > 100000 -> 100000;
                true -> BaseRatio1+RatioEvent1+RatioLast1+RatioProp1
            end,
    %计算第二匹马的胜率
    Ratio2 = if 
                BaseRatio2+RatioEvent2+RatioLast2+RatioProp2 =< 0 -> 0;
                BaseRatio2+RatioEvent2+RatioLast2+RatioProp2 > 100000 -> 100000;
                true -> BaseRatio2+RatioEvent2+RatioLast2+RatioProp2
            end,
    %计算第三匹马的胜率
    Ratio3 = if 
                BaseRatio3+RatioEvent3+RatioLast3+RatioProp3 =< 0 -> 0;
                BaseRatio3+RatioEvent3+RatioLast3+RatioProp3 > 100000 -> 100000;
                true -> BaseRatio3+RatioEvent3+RatioLast3+RatioProp3
            end,
    % RatioList = [{?HORSE_1, BaseRatio1+RatioEvent1+RatioLast1+RatioProp1}
    %             ,{?HORSE_2, BaseRatio2+RatioEvent2+RatioLast2+RatioProp2}
    %             ,{?HORSE_3, BaseRatio3+RatioEvent3+RatioLast3+RatioProp3}
    %         ],
    RatioList = [{?HORSE_1, Ratio1}
                ,{?HORSE_2, Ratio2}
                ,{?HORSE_3, Ratio3}
            ],
    % 计算排名类型
    RankType = calc_rank_type(RatioList, EventList),
    % 保存对下次影响的概率
    NewState = State#horse_race_state{last_event_ratio = NextRoundEventRatio},
    {NewState, RankType, EventList};
get_horse_race_result(_State) ->
    ?ASSERT(false, _State),
    {0, []}.


% 计算基础胜率
calc_base_ratio(PlayerList) ->
    {V1, V2, V3} = calc_suport_num(PlayerList, {0,0,0}),
    MaxV = min(min(V1,V2), V3), %支持人数越少概率越大
    if
        MaxV =:= V1 -> {40000, 30000, 30000};
        MaxV =:= V2 -> {30000, 40000, 30000};
        MaxV =:= V3 -> {30000, 30000, 40000}
    end.

calc_suport_num([], Ret) -> Ret;
calc_suport_num([{_, {?HORSE_1, Value}}|Rest], {A,B,C}) -> 
    calc_suport_num(Rest, {A+Value, B, C});
calc_suport_num([{_, {?HORSE_2, Value}}|Rest], {A,B,C}) -> 
    calc_suport_num(Rest, {A, B+Value, C});
calc_suport_num([{_, {?HORSE_3, Value}}|Rest], {A,B,C}) -> 
    calc_suport_num(Rest, {A, B, C+Value});
calc_suport_num([_|Rest], {A,B,C}) -> 
    calc_suport_num(Rest, {A, B, C}).

% 计算特殊事件概率
calc_ratio_event([{?HORSE_1, ?HORSE_EVENT_WING}]) -> {{20000, -10000, -10000}, {0, 0, 0}};
calc_ratio_event([{?HORSE_1, ?HORSE_EVENT_LOSE}]) -> {{-20000, 10000, 10000}, {0, 0, 0}};
calc_ratio_event([{?HORSE_1, ?HORSE_EVENT_SAVE}]) -> {{-10000, 0, 0}, {10000, 0, 0}};
calc_ratio_event([{?HORSE_1, ?HORSE_EVENT_RUSH}]) -> {{10000, 0, 0}, {-10000, 0, 0}};
calc_ratio_event([{?HORSE_2, ?HORSE_EVENT_WING}]) -> {{-10000, 20000, -10000}, {0, 0, 0}};
calc_ratio_event([{?HORSE_2, ?HORSE_EVENT_LOSE}]) -> {{10000, -20000, 10000}, {0, 0, 0}};
calc_ratio_event([{?HORSE_2, ?HORSE_EVENT_SAVE}]) -> {{0, -10000, 0}, {0, 10000, 0}};
calc_ratio_event([{?HORSE_2, ?HORSE_EVENT_RUSH}]) -> {{0, 10000, 0}, {0, -10000, 0}};
calc_ratio_event([{?HORSE_3, ?HORSE_EVENT_WING}]) -> {{-10000, -10000, 20000}, {0, 0, 0}};
calc_ratio_event([{?HORSE_3, ?HORSE_EVENT_LOSE}]) -> {{10000, 10000, -20000}, {0, 0, 0}};
calc_ratio_event([{?HORSE_3, ?HORSE_EVENT_SAVE}]) -> {{0, 0, -10000}, {0, 0, 10000}};
calc_ratio_event([{?HORSE_3, ?HORSE_EVENT_RUSH}]) -> {{0, 0, 10000}, {0, 0, -10000}};
calc_ratio_event(_EventList) -> {{0,0,0}, {0,0,0}}. 

    

% 计算道具影响胜率
calc_prop_ratio(PropsGood, PropsBad) ->
    Good1   = get_value(?HORSE_1, PropsGood),
    Good2   = get_value(?HORSE_2, PropsGood),
    Good3   = get_value(?HORSE_3, PropsGood),
    Bad1    = get_value(?HORSE_1, PropsBad),
    Bad2    = get_value(?HORSE_2, PropsBad),
    Bad3    = get_value(?HORSE_3, PropsBad),
    {(Good1-Bad1)*10 + (Bad2+Bad3)*5 - (Good2+Good3)*5
    ,(Good2-Bad2)*10 + (Bad1+Bad3)*5 - (Good1+Good3)*5
    ,(Good3-Bad3)*10 + (Bad2+Bad1)*5 - (Good2+Good1)*5
    }.

get_value(Key, Dict) ->
    case dict:find(Key, Dict) of
        error -> 0;
        {ok, V} -> V
    end.

% 随机特殊事件 （目前只要求一个事件）
rand_event_list() -> 
    List = data_horse_race:config(event_ratio),
    SumRatio = lists:sum([R || {_, R} <- List]),
    List1 = [{null, max(100-SumRatio, 0)} | List],
    {EventType, _} = util:rand_by_weight(List1, 2),
    case EventType of
        null -> [];
        _ -> 
            HorseNo = list_util:rand_pick_one(?HORSE_LIST),
            [{HorseNo, EventType}]
    end.


% 计算排名类型
calc_rank_type(RatioList, EvenList) ->
    {First, _} = util:rand_by_weight(RatioList, 2),
    RatioList1 = lists:keydelete(First, 1, RatioList),
    {Second, _} = util:rand_by_weight(RatioList1, 2),
    RatioList2 = lists:keydelete(Second, 1, RatioList1),
    {Third, _} = util:rand_by_weight(RatioList2, 2),
    % 罢赛的马去掉对应的排名
    RankList = case EvenList of
        [{?HORSE_1, ?HORSE_EVENT_STRIKE}] -> [Second, Third];
        [{?HORSE_2, ?HORSE_EVENT_STRIKE}] -> [First, Third];
        [{?HORSE_3, ?HORSE_EVENT_STRIKE}] -> [First, Second];
        _ -> [First, Second, Third]
    end,
    % 转成对应的排名类型码
    to_client_rank_type(RankList).

% 排名类型转换与客户端对应的类型码
to_client_rank_type([1,2,3]) -> 1;
to_client_rank_type([1,3,2]) -> 2;
to_client_rank_type([2,1,3]) -> 3;
to_client_rank_type([2,3,1]) -> 4;
to_client_rank_type([3,1,2]) -> 5;
to_client_rank_type([3,2,1]) -> 6;
to_client_rank_type([1,2]) -> 7;
to_client_rank_type([2,1]) -> 8;
to_client_rank_type([1,3]) -> 9;
to_client_rank_type([3,1]) -> 10;
to_client_rank_type([2,3]) -> 11;
to_client_rank_type([3,2]) -> 12;
to_client_rank_type(_) -> 0.

% 根据排名类型获取获胜马号
get_first_horse_by_rank_type(1) -> 1;
get_first_horse_by_rank_type(2) -> 1;
get_first_horse_by_rank_type(3) -> 2;
get_first_horse_by_rank_type(4) -> 2;
get_first_horse_by_rank_type(5) -> 3;
get_first_horse_by_rank_type(6) -> 3;
get_first_horse_by_rank_type(7) -> 1;
get_first_horse_by_rank_type(8) -> 2;
get_first_horse_by_rank_type(9) -> 1;
get_first_horse_by_rank_type(10) -> 3;
get_first_horse_by_rank_type(11) -> 2;
get_first_horse_by_rank_type(12) -> 3;
get_first_horse_by_rank_type(_RankType) -> 0.


%% 递增当天已参加跑马活动的次数
incr_horse_race_join_times(PS) ->
    Data2 = case get_horse_race_activity_data(PS) of
                null ->
                    #player_gamble_times_state{player_gamble_times = 1, last_gamble_time = util:unixtime()};
                Data ->
                    OldTimes = Data#player_gamble_times_state.player_gamble_times,
                    Data#player_gamble_times_state{player_gamble_times = OldTimes + 1, last_gamble_time = util:unixtime()}
            end,
    set_horse_race_activity_data(PS, Data2).

get_horse_race_activity_data(PS) ->
    PlayerId = player:id(PS),
    ply_activity:get(PlayerId, ?SYS_HORSE_RACE).

set_horse_race_activity_data(PS, Data) when is_record(Data, player_gamble_times_state) ->
    PlayerId = player:id(PS),
    ply_activity:set(PlayerId, ?SYS_HORSE_RACE, Data).    

%% 重置玩家已参加跑马活动次数
set_horse_gamble_time(PS, Value) ->
    ?ylh_Debug("set_horse_gamble_time=~p~n", [Value]),
    Data = #player_gamble_times_state{player_gamble_times = Value, last_gamble_time = util:unixtime()},
    set_horse_race_activity_data(PS, Data).   

%% 得到玩家已经参加跑马的次数
get_horse_race_already_join_times(PS) ->
    case get_horse_race_activity_data(PS) of
        null ->
            0;
        Data ->
            %判断是否是同一天了，否的话清除所有数据
            case util:is_timestamp_same_day(Data#player_gamble_times_state.last_gamble_time, util:unixtime()) of
                true ->
                    Data#player_gamble_times_state.player_gamble_times;
                false ->
                    Data2 = Data#player_gamble_times_state{player_gamble_times = 0, last_gamble_time = util:unixtime()},
                    set_horse_race_activity_data(PS, Data2),
                    0
            end 
    end.


%%------------------------------------
%% 跑马场数据操作
%%------------------------------------
get_ets_horse_race() ->
    case ets:lookup(?ETS_HORSE_RACE, horse_race) of
        [H] -> H;
        _ -> null
    end.
