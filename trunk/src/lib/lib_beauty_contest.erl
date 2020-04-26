%%%------------------------------------
%%% @author 严利宏 <542430172@qq.com>
%%% @copyright UCweb 2014.10.13
%%% @doc 女妖选美 抽奖活动 函数库.
%%% @end
%%%------------------------------------

-module(lib_beauty_contest).

-include("common.hrl").
-include("record.hrl").
-include("prompt_msg_code.hrl").
-include("log.hrl").
-include("goods.hrl").
-include("beauty_contest.hrl").
-include("activity_degree_sys.hrl").
-include("ets_name.hrl").

-compile(export_all).
-export([]).

% 玩家登陆---加载数据（在玩家进程中执行）
login(PS) ->
    PlayerID = player:id(PS),
    case get_beauty_contest_cache(PlayerID) of
        null -> % 无ets缓存则从数据库加载
            BeautyContestDataDB = 
            case db:kv_lookup(beauty_contest, PlayerID) of
                [] -> [];
                [List] -> List
            end,
            erlang:put(?BEAUTY_CONTEST_DATA, BeautyContestDataDB),
            ok;
        BeautyContestDatas when is_list(BeautyContestDatas) ->
            erlang:put(?BEAUTY_CONTEST_DATA, BeautyContestDatas),
            ok
    end.

% 玩家临时退出操作---缓存数据
tmp_logout(PS) ->
    case erlang:get(?BEAUTY_CONTEST_DATA) of
        undefined -> skip;
        BeautyContestDatas -> % 把玩家的抽奖信息缓存到ets
            put_beauty_contest_cache( player:id(PS), BeautyContestDatas)
    end.

% 玩家最终退出操作---写数据库
final_logout(PS) ->
    PlayerID = player:id(PS),
    case get_beauty_contest_cache(PlayerID) of
        null -> 
            skip;
        BeautyContestDatas when is_list(BeautyContestDatas) ->
            case db:kv_insert(beauty_contest, PlayerID, BeautyContestDatas) of
                1 -> % 执行成功
                    del_beauty_contest_cache(PlayerID);
                _ -> 
                    skip
            end
    end.

%% -------------------------
%% 抽奖信息数据操作
%% -------------------------
% 缓存操作
get_beauty_contest_cache(PlayerID) ->
    case ets:lookup(?ETS_BEAUTY_CONTEST_CACHE, PlayerID) of
        [] ->
            null;
        [{PlayerID, DataList}] ->
            DataList
    end.
put_beauty_contest_cache(PlayerID, BeautyContestData) ->
    ets:insert(?ETS_BEAUTY_CONTEST_CACHE, {PlayerID, BeautyContestData}).
del_beauty_contest_cache(PlayerID) ->
    ets:delete(?ETS_BEAUTY_CONTEST_CACHE, PlayerID).

% 字典操作
get_dict(ActId) ->
    case erlang:get(?BEAUTY_CONTEST_DATA) of
        undefined -> null;
        DataList -> 
            case lists:keyfind(ActId, 1, DataList) of
                false -> null;
                {ActId, Data} -> Data
            end
    end.
put_dict(ActId, Data) ->
    OldDataList = 
    case erlang:get(?BEAUTY_CONTEST_DATA) of
        undefined -> [];
        DataList__ -> DataList__
    end,
    NewDataList = lists:keystore(ActId, 1, OldDataList, {ActId, Data}),
    erlang:put(?BEAUTY_CONTEST_DATA, NewDataList).

% 配置操作
get_cfg_cost_goods(No) ->
    case data_beauty_contest:get(No) of
        D when is_record(D, data_beauty_contest) -> D#data_beauty_contest.cost_goods;
        _ -> error
    end.
get_cfg_cost_byuanbao(No) ->
    case data_beauty_contest:get(No) of
        D when is_record(D, data_beauty_contest) -> D#data_beauty_contest.cost_byuanbao;
        _ -> error
    end.
get_cfg_cost_reset(No) ->
    case data_beauty_contest:get(No) of
        D when is_record(D, data_beauty_contest) -> D#data_beauty_contest.cost_reset;
        _ -> error
    end.



%% -------------------------
%% 抽奖面板信息
%% -------------------------
beauty_contest_info(PS) ->
    BCInfo = get_gamble_info(PS),
    % 返回新数据
    case is_record(BCInfo, beauty_contest_info) of
        false -> skip;
        true ->
            case ets:lookup(?ETS_BEAUTY_CONTEST_STATUS, ?ACTID) of
                [] -> skip;
                [BCStatus] ->
                    Now = util:unixtime(),
                    NextBigRewardTime = mod_beauty_contest:get_next_big_reward_time(), 
                    NextResetTime = max(BCInfo#beauty_contest_info.last_reset_time + ?BEAUTY_CONTEST_RESET_TIME - Now, 0), 
                    Array = [{G#beauty_contest_goods.no
                             ,G#beauty_contest_goods.goods_id
                             ,G#beauty_contest_goods.num
                             ,G#beauty_contest_goods.quality
                             ,G#beauty_contest_goods.bind
                             ,G#beauty_contest_goods.get_flag
                        } || G <- BCInfo#beauty_contest_info.goods_info],
                    % 幸运玩家列表
                    LuckyPlayerList = BCStatus#ets_beauty_contest_status.import_goods_record,
                    ?ylh_Debug("beauty_contest_info ~p~n", [[player:id(PS), Array]]),
                    {ok, BinData} = pt_31:write(31100, [NextBigRewardTime, NextResetTime, Array, LuckyPlayerList]),
                    lib_send:send_to_sid(PS, BinData)
            end
    end.

%% -------------------------
%% 抽奖
%% -------------------------
beauty_contest_gamble(PS, CostType) ->
    % 判断是否是活动开启时间
    ErrCode = 
    case is_beauty_contest_open(?ACTID) of
        false -> ?PM_BEAUTY_CONTEST_ERROR_NO_OPEN;
        true -> 
            BCInfo = get_gamble_info(PS),
            case is_record(BCInfo, beauty_contest_info) of
                false -> 0;  % 这种情况是玩家等级不在配置范围内
                true ->
                    % 过滤出未抽得的物品
                    GambleGoodsList = [G || G<-BCInfo#beauty_contest_info.goods_info, G#beauty_contest_goods.get_flag=:=0 ],
                    % 抽奖
                    GiveGoods = util:rand_by_weight(GambleGoodsList, #beauty_contest_goods.weight),
                    % 计算本轮已经抽取的次数
                    HasGetNum = length([G || G<-BCInfo#beauty_contest_info.goods_info, G#beauty_contest_goods.get_flag=:=1 ]),
                    % 验证
                    case check_beauty_contest_gamble(PS, CostType, HasGetNum, BCInfo, GiveGoods) of
                        {error, ErrCode__} -> ErrCode__;
                        {ok, CostInfoList} ->
                            do_beauty_contest_gamble_cost(PS, CostInfoList),
                            % 发送抽奖结果信息（这个要先于发物品协议-客户端逻辑要求）
                            {ok, BinData} = pt_31:write(31101, [0, GiveGoods#beauty_contest_goods.no]),
                            lib_send:send_to_sid(PS, BinData),
                            % 发抽奖物品
                            do_beauty_contest_gamble_give_reward(PS, GiveGoods), 
                            % 保存数据
                            NewGoodsList = lists:keyreplace(GiveGoods#beauty_contest_goods.no, 
                                                         #beauty_contest_goods.no, 
                                                         BCInfo#beauty_contest_info.goods_info, 
                                                         GiveGoods#beauty_contest_goods{get_flag=1}
                                                     ),
                            NewBCInfo = BCInfo#beauty_contest_info{goods_info=NewGoodsList},
                            put_dict(?ACTID, NewBCInfo), 
                            % 抽奖统计
                            ActId = ?ACTID, 
                            {_,AddCount} = get_cfg_cost_goods(BCInfo#beauty_contest_info.no), 
                            mod_beauty_contest:beauty_contest_counter(ActId, PS, GiveGoods, AddCount*(HasGetNum + 1)),
                            % 日志
                            lib_log:statis_beauty_contest(PS, BCInfo#beauty_contest_info.bag_no, HasGetNum+1),
                            0
                    end
            end
    end,
    case ErrCode =/=0 of
        false -> skip;
        true ->  
            % 发送错误信息
            lib_send:send_prompt_msg(PS, ErrCode),
            {ok, ErrBinData} = pt_31:write(31101, [ErrCode, 0]),
            lib_send:send_to_sid(PS, ErrBinData)
    end,
    ok.

% 验证抽奖
check_beauty_contest_gamble(PS, _CostType, HasGetNum, BCInfo, GiveGoods) ->
    PlayerId = player:id(PS),
    {CostGoodsNo, BaseCostGoodsNum} = get_cfg_cost_goods(BCInfo#beauty_contest_info.no),
    CostGoodsNum = BaseCostGoodsNum * (HasGetNum + 1),
    HasCostGoodsNum = mod_inv:get_goods_count_in_bag_by_no(PlayerId, CostGoodsNo),
    case HasCostGoodsNum >= CostGoodsNum of
        false -> % 道具不足则先消耗拥有的道具再消耗绑金
            BaseCostBY = get_cfg_cost_byuanbao(BCInfo#beauty_contest_info.no),
            OweCostGoodsNum = CostGoodsNum - HasCostGoodsNum,
            % 计算多余需要消耗的绑金
            ShouldCostBY = OweCostGoodsNum * (BaseCostBY div BaseCostGoodsNum),
            case player:has_enough_money(PS, ?MNY_T_BIND_YUANBAO, ShouldCostBY) of
                false -> {error, ?PM_BEAUTY_CONTEST_GAMBLE_ERROR_BYUANBAO_NO_ENOUGH}; % 绑金不足
                true -> 
                    case check_beauty_contest_give_reward(PS, GiveGoods#beauty_contest_goods.goods_id, GiveGoods#beauty_contest_goods.num) of
                        {error, ErrCode__} -> {error, ErrCode__};
                        ok -> {ok, [{byuanbao, ShouldCostBY}, {goods, CostGoodsNo, HasCostGoodsNum}]}
                    end
            end;
        true -> 
            case check_beauty_contest_give_reward(PS, GiveGoods#beauty_contest_goods.goods_id, GiveGoods#beauty_contest_goods.num) of
                {error, ErrCode__} -> {error, ErrCode__};
                ok -> {ok, [{goods, CostGoodsNo, CostGoodsNum}]}
            end
    end.

check_beauty_contest_give_reward(PS, GoodsNo, Count) ->
    % 新加判断条件-3种类型的格子至少要有一个空格 
    case mod_inv:calc_empty_slots(player:get_id(PS), ?LOC_BAG_EQ) > 1 andalso
         mod_inv:calc_empty_slots(player:get_id(PS), ?LOC_BAG_USABLE) > 1 andalso
         mod_inv:calc_empty_slots(player:get_id(PS), ?LOC_BAG_UNUSABLE) > 1 of
         false -> {error, ?PM_BEAUTY_CONTEST_GAMBLE_ERROR_BAG_FULL};
         true ->
             case mod_inv:check_batch_add_goods(player:get_id(PS), [{GoodsNo, Count}]) of
                 {fail, _Reason} -> {error, ?PM_BEAUTY_CONTEST_GAMBLE_ERROR_BAG_FULL};
                 ok -> ok
             end
    end.

% 扣消耗
do_beauty_contest_gamble_cost(_PS, []) -> ok;
do_beauty_contest_gamble_cost(PS, [Cost|CostLeft]) ->
    case Cost of
        {goods, CostGoodsNo, CostGoodsNum} -> 
            mod_inv:destroy_goods_WNC(player:id(PS), [{CostGoodsNo, CostGoodsNum}], [?LOG_BEAUTY_CONTEST, "vote"]),
            do_beauty_contest_gamble_cost(PS, CostLeft);
        {byuanbao, CostNum} ->
            player_syn:cost_money(PS, ?MNY_T_BIND_YUANBAO, CostNum, [?LOG_BEAUTY_CONTEST, "vote"]),
            do_beauty_contest_gamble_cost(PS, CostLeft)
    end.

% 发抽奖奖励
do_beauty_contest_gamble_give_reward(PS, GiveGoods) ->         
    #beauty_contest_goods{no        = _No
                         ,goods_id  = GiveGoodsNo
                         ,num       = GiveGoodsNum
                         ,quality   = _Quality
                         ,bind      = Bind
    } = GiveGoods,
    RetAddGoods = mod_inv:batch_smart_add_new_goods(player:get_id(PS), [{GiveGoodsNo, GiveGoodsNum}], 
            [{bind_state, Bind}], [?LOG_BEAUTY_CONTEST, "vote"]),
    case RetAddGoods of
        {fail, _Reason} -> 
            ?ERROR_MSG("lib_beauty_contest:do_beauty_contest_gamble_give_reward add_goods error!Reason:~p~n", [_Reason]),
            ?ASSERT(false, {RetAddGoods, GiveGoods}),
            skip;
        {ok, RetGoods} ->
            F = fun({Id, No, Cnt}) ->
                    case mod_inv:find_goods_by_id_from_bag(player:id(PS), Id) of
                        null -> skip;
                        Goods ->
                            ply_tips:send_sys_tips(PS, {get_goods, [No, lib_goods:get_quality(Goods), Cnt,Id]})
                    end
            end,
            [F(X) || X <- RetGoods]
    end.

    
%% -------------------------
%% 手动重置抽奖面板
%% -------------------------
beauty_contest_reset(PS) ->
    BCInfo = get_gamble_info(PS),
    % 判断是否是活动开启时间
    ErrCode = 
    case is_record(BCInfo, beauty_contest_info) of
        false -> 0;  % 这种情况是玩家等级不在配置范围内
        true ->
            case is_beauty_contest_open(?ACTID) of
                false -> ?PM_BEAUTY_CONTEST_ERROR_NO_OPEN;
                true ->
                    Cost = get_cfg_cost_reset(BCInfo#beauty_contest_info.no),
                    case check_beauty_contest_reset(PS, Cost) of
                        {error, ErrCode__} -> ErrCode__;
                        ok ->
                            case do_beauty_contest_reset(PS, Cost) of
                                true -> 
                                    lib_log:statis_beauty_refresh(PS),
                                    0;
                                false -> ?PM_BEAUTY_CONTEST_RESET_ERROR_UNKNOWN
                            end
                    end
            end
    end,
    case ErrCode of
        0 -> % 成功返回31100 
            beauty_contest_info(PS);
        _ ->
            lib_send:send_prompt_msg(PS, ErrCode)
    end.

% 验证手动面板重置消耗 
check_beauty_contest_reset(PS, Cost) ->
    case player:has_enough_money(PS, ?MNY_T_BIND_YUANBAO, Cost) of
        false -> {error, ?PM_BEAUTY_CONTEST_RESET_ERROR_BYUANBAO_NO_ENOUGH};
        true -> ok
    end.
% 执行面板重置
do_beauty_contest_reset(PS, Cost) ->
    player:cost_money(PS, ?MNY_T_BIND_YUANBAO, Cost, [?LOG_BEAUTY_CONTEST, "fresh"]),
    case reset_beauty_contest_info(PS) of
        Info__ when is_record(Info__, beauty_contest_info) -> true;  % 刷新成功
        _ -> false
    end.

%% -------------------------
%% 私有接口
%% -------------------------
% 是否女妖选美活动开启 
is_beauty_contest_open(ActId) ->
    case ets:lookup(?ETS_BEAUTY_CONTEST_STATUS, ActId) of
        [] -> false;
        [BCStatus] when is_record(BCStatus, ets_beauty_contest_status) ->
            BCStatus#ets_beauty_contest_status.open_status=:=1;
        _ -> false
    end.

%% 获取玩家抽奖信息
get_gamble_info(PS) ->
    PlayerId = player:id(PS),
    {IsNeedReset, OldBCInfo} = 
    case get_dict(?ACTID) of
        null -> % 第一次请求则刷新一次
            {true, null};
        BCInfo__ when is_record(BCInfo__, beauty_contest_info) ->
            Now = util:unixtime(),
                            % 重置时间到了
            IsNeedReset__ = (BCInfo__#beauty_contest_info.last_reset_time + ?BEAUTY_CONTEST_RESET_TIME =< Now) orelse
                            % 全部物品都被抽走了
                            ([] =:= [G || G<-BCInfo__#beauty_contest_info.goods_info, G#beauty_contest_goods.get_flag=:=0 ]),
            {IsNeedReset__, BCInfo__} ;
        _ -> % 错误数据
            ?ERROR_MSG("beauty_contest_info error error_data , id= ~p", [PlayerId]),
            {true, null}
    end,
    case IsNeedReset of
        true -> 
            reset_beauty_contest_info(PS);
        false -> 
            OldBCInfo
    end.

% 重置面板信息
reset_beauty_contest_info(PS) ->
    % 根据玩家等级抽出对应的配置信息
    Lv = player:get_lv(PS),
    Datas = [data_beauty_contest:get(ID) || ID <- data_beauty_contest:get_ids()],
    SelectDatas = [D || #data_beauty_contest{lv_limit={Min,Max}}=D <- Datas,
                                                     Min =< Lv, Lv =< Max],
    case SelectDatas of
        [Data| _] -> 
            % 根据权重随机出一个奖励包
            {BagNo, _} = util:rand_by_weight(Data#data_beauty_contest.reward_bags, 2),
            case data_beauty_contest_reward_bag:get(BagNo) of
                null -> ?ASSERT(false), skip; % 无效的配置Id
                Bag ->
                    % 根据配置随机抽取物品数量 版本1--随机从包里面取N个物品
%                    GoodsList = util:shuffle(Bag#data_beauty_contest_reward_bag.reward_goods),
%                    GoodsList1 =
%                    case length(GoodsList) > Bag#data_beauty_contest_reward_bag.reward_num of
%                        true -> lists:sublist(GoodsList, 1, Bag#data_beauty_contest_reward_bag.reward_num);
%                        false -> GoodsList
%                    end,
                    % 根据配置随机抽取物品数量 版本2--根据权重取N个物品
%                    GoodsList1 = util:rand_by_weight(Bag#data_beauty_contest_reward_bag.reward_goods, 2, Bag#data_beauty_contest_reward_bag.reward_num),
                    % 根据配置随机抽取物品数量 版本3--详情看代码，说多都是泪...
                    GoodsList1 = rand_beauty_contest_reward_goods(Bag),
                    % 构造抽奖数据
                    Bind = Bag#data_beauty_contest_reward_bag.bind,
                    {_No, GoodsInfo} =
                    lists:foldl(
                        fun({{GoodsId, Num, Quality}, Weight}, {AccNo, AccGoodsInfo}) -> 
                                {AccNo+1, 
                                [#beauty_contest_goods{
                                    no = AccNo
                                    ,goods_id=GoodsId
                                    ,num = Num
                                    ,quality = Quality
                                    ,bind = Bind
                                    ,get_flag = 0
                                    ,weight = Weight
                                } | AccGoodsInfo]}
                        end, {1, []}, GoodsList1),
                    RetData = #beauty_contest_info{
                        no = Data#data_beauty_contest.no
                        ,last_reset_time = util:unixtime()
                        ,bag_no = BagNo
                        ,goods_info = GoodsInfo
                    },
                    % 保存数据
                    put_dict(?ACTID, RetData ),
                    % 返回数据
                    RetData
            end;
        _ -> % 对应等级无配置信息
            skip
    end.

% 根据配置随机抽取物品数量 
rand_beauty_contest_reward_goods(Bag) ->
    #data_beauty_contest_reward_bag{
        very_expensive_reward_goods = GoodsList1    % 非常珍贵的奖励包列表
        ,very_expensive_reward_num = GoodsNumR1     % 非常珍贵的奖励包抽取随机数量
        ,expensive_reward_goods = GoodsList2        % 珍贵的奖励包列表
        ,expensive_reward_num = GoodsNumR2          % 珍贵的奖励包抽取随机数量
        ,normal_reward_goods = GoodsList3           % 普通的奖励包列表
        ,normal_reward_num = GoodsNumR3             % 普通的奖励包抽取随机数量
        ,very_normal_reward_goods = GoodsList4      % 非常普通的奖励包列表 （抽取数量=总抽取数量-上面3个随机数量）
        ,all_reward_num = AllGoodsNum       
    } = Bag,
    % 确定随机抽取数量
    {GoodsNum1,_} = util:rand_by_weight(GoodsNumR1, 2),
    {GoodsNum2,_} = util:rand_by_weight(GoodsNumR2, 2),
    {GoodsNum3,_} = util:rand_by_weight(GoodsNumR3, 2),
    ?ASSERT( (AllGoodsNum>(GoodsNum1+GoodsNum2+GoodsNum3))),
    GoodsNum4 = AllGoodsNum - GoodsNum1 - GoodsNum2 - GoodsNum3,
    % 抽取随机物品
    GoodsListPick1 = util:rand_by_weight(GoodsList1, 2, GoodsNum1),
    GoodsListPick2 = util:rand_by_weight(GoodsList2, 2, GoodsNum2),
    GoodsListPick3 = util:rand_by_weight(GoodsList3, 2, GoodsNum3),
    GoodsListPick4 = util:rand_by_weight(GoodsList4, 2, GoodsNum4),
    util:shuffle(GoodsListPick1 ++ GoodsListPick2 ++ GoodsListPick3 ++ GoodsListPick4).



%% -------------------------
%% 解析后台传过来的数据格式函数。 
%% -------------------------
%% Return : {true, NewData} | false
check_activity_data(JosonData) ->
    case rfc4627:decode(JosonData) of
        {ok, Data, _} ->
            {obj, List} = Data,
            case length(List) =:= 3 of
                true -> 
                    {"attach", BGoodsList} = lists:nth(1, List),
                    GoodsList = util:string_to_term(binary_to_list(BGoodsList)),
                    {"content", BContent} = lists:nth(2, List),
                    {"title", BTitle} = lists:nth(3, List),                    
                    {true, [GoodsList, BContent, BTitle]};
                false -> false
            end;
        _Any ->
            false
    end.

