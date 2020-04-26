%%%-----------------------------------
%%% @Module  : lib_shop
%%% @Author  : zhangwq
%%% @Email   : 
%%% @Created : 2014.15.12
%%% @Description: 商店
%%%-----------------------------------

-module(lib_shop).

-export([
        init_shop_from_db/0,
        db_save_dynamic_shop_goods/0,
        get_dynamic_shop_goods/1,
        get_op_shop_goods/1,
        update_dynamic_shop_goods/1,
        update_player_buy_goods/5,

        pack_dynamic_goods_list/3,
        check_op_shop_activity_data/1,

        refresh_op_shop_goods/2,
        refresh_shop_goods/2
        ]).


-include("ets_name.hrl").
-include("trade.hrl").
-include("debug.hrl").
-include("trade.hrl").
-include("common.hrl").
-include("record.hrl").

init_shop_from_db() ->
    ?TRACE("init shop from db...~n"),
    
    case db:select_all(shop, "goods_no, last_refresh_time, expire_time, left_num", []) of
        [] ->  % 没有数据
            ?TRACE("[MARKET]There are not any dynamic shop goods!!!~n"),
            skip;
        SqlRet when is_list(SqlRet) ->
            TimeNow = util:unixtime(),
            Records = [make_dynamic_shop_goods_record(X, TimeNow) || X <- SqlRet],
            % 写入ets表中
            [ets:insert(?ETS_DYNAMIC_SHOP_GOODS, X) || X <- Records, X =/= null];
        _ ->  % db读取出错
            ?ASSERT(false),
            skip
    end.


db_save_dynamic_shop_goods() ->
    ShopGoodsL = ets:tab2list(?ETS_DYNAMIC_SHOP_GOODS),
    F = fun(ShopGoods) ->
        db:replace(?DB_SYS, shop, [{goods_no, ShopGoods#shop_goods.goods_no}, {last_refresh_time, ShopGoods#shop_goods.last_refresh_time}, 
            {expire_time, ShopGoods#shop_goods.expire_time}, {left_num, ShopGoods#shop_goods.left_num}])
    end,
    [F(X) || X <- ShopGoodsL],
    ok.

db_delete_dynamic_shop_goods(GoodsNo) ->
    db:delete(?DB_SYS, shop, [{goods_no, GoodsNo}]).

get_dynamic_shop_goods(GoodsNo) ->
    case ets:lookup(?ETS_DYNAMIC_SHOP_GOODS, GoodsNo) of
        [] -> null;
        [ShopGoods] -> ShopGoods
    end.

update_dynamic_shop_goods(DyShopGoods) when is_record(DyShopGoods, shop_goods) ->
    ets:insert(?ETS_DYNAMIC_SHOP_GOODS, DyShopGoods).



get_op_shop_goods(GoodsNo) ->
    case ets:lookup(?ETS_OP_SHOP_GOODS, GoodsNo) of
        [] -> null;
        [ShopGoods] -> ShopGoods
    end.

refresh_op_shop_goods(_CurUnixTime, ShopGoodsL) ->
    ets:delete_all_objects(?ETS_OP_SHOP_GOODS),
    [ets:insert(?ETS_OP_SHOP_GOODS, ShopGoods) || ShopGoods <- ShopGoodsL].


refresh_shop_goods(_CurUnixTime, []) ->
    skip;
refresh_shop_goods(CurUnixTime, [ShopGoods | T]) ->
    DyShopGoodsList = ets:tab2list(?ETS_DYNAMIC_SHOP_GOODS),  % 暂时用转为列表的方式，TODO：构思：是否有更高效的方法
    case ShopGoods#shop_goods.goods_type =:= 0 of %% 普通商品
        true -> 
            refresh_shop_goods(CurUnixTime, T);
        false -> 
            {Type, RefreshTime} = get_dy_shop_goods_refresh_time(ShopGoods),
            OpenSvrDay = util:get_server_open_nth_day(),
            case lists:keyfind(ShopGoods#shop_goods.goods_no, #shop_goods.goods_no, DyShopGoodsList) of
                false -> %% 检查其他物品是否开始开启刷新
                    case {Type, RefreshTime} of
                        {1, {Year, Month, Day, Hour}} -> %% 具体某一天某点开始刷新
                            case can_refresh_now(CurUnixTime, {Year, Month, Day, Hour}) of
                                false ->
                                    skip;
                                true ->
                                    ShopGoods1 = 
                                        case ShopGoods#shop_goods.goods_type =:= 1 of
                                            true -> %% 限时物品
                                                case ShopGoods#shop_goods.continue_day =:= nil of
                                                    true -> %% 没有天数限制刷新
                                                        ShopGoods#shop_goods{
                                                            expire_time = CurUnixTime + ShopGoods#shop_goods.continue_time * ?SECOND_OF_ONE_HOUR, 
                                                            last_refresh_time = CurUnixTime
                                                            };
                                                    false -> %% 有商品在架天数限制，在架时间段内，没有刷新小周期
                                                        ?ASSERT(is_integer(ShopGoods#shop_goods.continue_day), ShopGoods#shop_goods.continue_day),
                                                        ShopGoods#shop_goods{expire_time = CurUnixTime + ShopGoods#shop_goods.continue_day * ?SECOND_OF_ONE_HOUR * 24}
                                                end;
                                            false -> %% 限量物品
                                                ShopGoods#shop_goods{left_num = ShopGoods#shop_goods.goods_count_limit, last_refresh_time = CurUnixTime}
                                        end,
    
                                    ets:insert(?ETS_DYNAMIC_SHOP_GOODS, ShopGoods1)
                            end;
                        {2, {WeekList, Hour}} -> %% 开服后每周几的几点刷新
                            case can_refresh_now(CurUnixTime, {WeekList, Hour}) of
                                false -> 
                                    skip;
                                true ->
                                    ShopGoods1 = 
                                        case ShopGoods#shop_goods.goods_type =:= 1 of
                                            true -> %% 限时物品
                                                ShopGoods#shop_goods{
                                                    expire_time =  CurUnixTime + ShopGoods#shop_goods.continue_time * ?SECOND_OF_ONE_HOUR, 
                                                    last_refresh_time = CurUnixTime
                                                    };
                                            false -> %% 限量物品
                                                ShopGoods#shop_goods{left_num = ShopGoods#shop_goods.goods_count_limit, last_refresh_time = CurUnixTime}
                                        end,
                                    
                                    ets:insert(?ETS_DYNAMIC_SHOP_GOODS, ShopGoods1)
                            end;
                        {3, {StartDay, Hour, ContinueDay}} -> %% 开服第几天后开启,持续多少天
                            case can_refresh_now(CurUnixTime, {StartDay, Hour, ContinueDay}) of
                                false -> 
                                    skip;
                                true ->
                                    ShopGoods1 = 
                                    case ShopGoods#shop_goods.goods_type =:= 1 of
                                        true -> %% 限时物品
                                            ShopGoods#shop_goods{
                                                expire_time = CurUnixTime + ShopGoods#shop_goods.continue_time * ?SECOND_OF_ONE_HOUR, 
                                                last_refresh_time = CurUnixTime
                                                };
                                        false -> %% 限量物品
                                            ShopGoods#shop_goods{left_num = ShopGoods#shop_goods.goods_count_limit, last_refresh_time = CurUnixTime}
                                    end,
                                    
                                    ets:insert(?ETS_DYNAMIC_SHOP_GOODS, ShopGoods1)
                            end;
                        _Any ->
                            skip
                    end;
                DyShopGoods ->
                    if 
                        DyShopGoods#shop_goods.continue_time /= nil andalso DyShopGoods#shop_goods.expire_time /= 0 andalso
                        DyShopGoods#shop_goods.last_refresh_time + DyShopGoods#shop_goods.continue_time * ?SECOND_OF_ONE_HOUR =< CurUnixTime -> %% 限时物品在小周期内下架
                            DyShopGoods1 = DyShopGoods#shop_goods{expire_time = 0}, %% 标记该限时周期内物品过期
                            update_dynamic_shop_goods(DyShopGoods1);

                        DyShopGoods#shop_goods.continue_day /= nil andalso DyShopGoods#shop_goods.server_start_day /= nil andalso 
                        OpenSvrDay > DyShopGoods#shop_goods.continue_day -> %% 持续天数达到，物品下架
                            ets:delete(?ETS_DYNAMIC_SHOP_GOODS, DyShopGoods#shop_goods.goods_no),
                            db_delete_dynamic_shop_goods(DyShopGoods#shop_goods.goods_no);

                        DyShopGoods#shop_goods.continue_day /= nil andalso DyShopGoods#shop_goods.server_start_day =:= nil andalso 
                        CurUnixTime >= DyShopGoods#shop_goods.expire_time -> %% 持续天数达到，物品下架
                            ets:delete(?ETS_DYNAMIC_SHOP_GOODS, DyShopGoods#shop_goods.goods_no),
                            db_delete_dynamic_shop_goods(DyShopGoods#shop_goods.goods_no);

                        DyShopGoods#shop_goods.refresh_interval /= nil andalso 
                        DyShopGoods#shop_goods.last_refresh_time + DyShopGoods#shop_goods.refresh_interval * ?SECOND_OF_ONE_HOUR =< CurUnixTime -> %% 进入下个刷新周期
                            DyShopGoods1 = 
                                case DyShopGoods#shop_goods.goods_type =:= 1 of
                                    true -> %% 限时物品 更新剩余时间
                                        ExpireTime = 
                                            case DyShopGoods#shop_goods.continue_time =:= nil andalso DyShopGoods#shop_goods.refresh_interval /= nil of 
                                                true -> DyShopGoods#shop_goods.refresh_interval * ?SECOND_OF_ONE_HOUR + CurUnixTime; 
                                                false -> DyShopGoods#shop_goods.continue_time * ?SECOND_OF_ONE_HOUR + CurUnixTime 
                                            end,
                                        DyShopGoods#shop_goods{last_refresh_time = CurUnixTime, expire_time = ExpireTime};
                                    false -> %% 限量物品,重新刷出一批物品
                                        ?ASSERT(DyShopGoods#shop_goods.goods_type =:= 2),
                                        DyShopGoods#shop_goods{last_refresh_time = CurUnixTime, left_num = DyShopGoods#shop_goods.goods_count_limit}
                                end,
                            
                            update_dynamic_shop_goods(DyShopGoods1);

                        true ->
                            skip
                    end %% if
            end, %% keyfind
            refresh_shop_goods(CurUnixTime, T)
    end.


%% 更新npc商店或商城，玩家的限量购买信息
update_player_buy_goods(PS, GoodsNo, Count, ShopType, ShopGoodsCfg) ->
    case ply_misc:get_player_misc(player:get_id(PS)) of
        null -> 
            PlayerMisc = 
                case ShopType of
                    ?SHOP_TYPE_NPC ->
                        #player_misc{player_id = player:get_id(PS), buy_goods_from_npc = [{GoodsNo, Count, util:unixtime()}]};
                    ?SHOP_TYPE_SHOP ->
                        #player_misc{player_id = player:get_id(PS), buy_goods_from_shop = [{GoodsNo, Count, util:unixtime()}]};
                    ?SHOP_TYPE_OP_SHOP ->
                        #player_misc{player_id = player:get_id(PS), buy_goods_from_op_shop = [{GoodsNo, Count, util:unixtime()}]}
                end,
            ply_misc:update_player_misc(PlayerMisc);
        PlayerMisc ->
            OldBuyInfo = 
                case ShopType of
                    ?SHOP_TYPE_SHOP -> PlayerMisc#player_misc.buy_goods_from_shop;
                    ?SHOP_TYPE_NPC -> PlayerMisc#player_misc.buy_goods_from_npc;
                    ?SHOP_TYPE_OP_SHOP -> PlayerMisc#player_misc.buy_goods_from_op_shop
                end,
            PlayerMisc1 = 
                case lists:keyfind(GoodsNo, 1, OldBuyInfo) of
                    false -> 
                        case ShopType of
                            ?SHOP_TYPE_SHOP ->
                                PlayerMisc#player_misc{buy_goods_from_shop = OldBuyInfo ++ [{GoodsNo, Count, util:unixtime()}]};
                            ?SHOP_TYPE_NPC ->
                                PlayerMisc#player_misc{buy_goods_from_npc = OldBuyInfo ++ [{GoodsNo, Count, util:unixtime()}]};
                            ?SHOP_TYPE_OP_SHOP ->
                                PlayerMisc#player_misc{buy_goods_from_op_shop = OldBuyInfo ++ [{GoodsNo, Count, util:unixtime()}]}
                        end;
                    {GoodsNo1, CountOld, TimeStamp} ->
                        NowCount = 
                            case ShopGoodsCfg#shop_goods.count_limit_type of
                                1 ->
                                    case util:is_same_day(TimeStamp) of
                                        true -> CountOld + Count;
                                        false -> Count
                                    end;
                                2 ->
                                    case util:is_same_week(TimeStamp) of
                                        true -> CountOld + Count;
                                        false -> Count
                                    end;
                                3 ->
                                    case util:is_same_month(TimeStamp) of
                                        true -> CountOld + Count;
                                        false -> Count
                                    end
                            end,
                        GoodsList = lists:keyreplace(GoodsNo, 1, OldBuyInfo, {GoodsNo1, NowCount, util:unixtime()}),
                        case ShopType of
                            ?SHOP_TYPE_SHOP ->
                                PlayerMisc#player_misc{buy_goods_from_shop = GoodsList};
                            ?SHOP_TYPE_NPC ->
                                PlayerMisc#player_misc{buy_goods_from_npc = GoodsList};
                            ?SHOP_TYPE_OP_SHOP ->
                                PlayerMisc#player_misc{buy_goods_from_op_shop = GoodsList}
                        end
                end,
            ply_misc:update_player_misc(PlayerMisc1)
    end.

%% 打包动态商店物品，返回 <<>> 列表
pack_dynamic_goods_list(PlayerId, ShopType, ShopGoodsL) ->
    F = fun(ShopGoodsInfo, Acc) ->
        % ?DEBUG_MSG("ShopGoodsInfo=~p",[ShopGoodsInfo]),
        
        BuyLimit = 
            case ShopGoodsInfo#shop_goods.buy_count_limit =:= 0 of
                true -> 0;
                false -> 1
            end,

        HaveBuyCount = ply_trade:get_player_buy_goods_count(PlayerId, ShopGoodsInfo, ShopType),

        NumberLimit = 
            case BuyLimit =:= 1 of
                false -> 0;
                true -> ShopGoodsInfo#shop_goods.buy_count_limit
            end,

        {LeftCount, ExpireTime} = 
            case lib_shop:get_dynamic_shop_goods(ShopGoodsInfo#shop_goods.goods_no) of
                null ->
                    case ShopGoodsInfo#shop_goods.goods_type =:= 3 of
                        true ->
                            case ShopGoodsInfo#shop_goods.count_limit_type of
                                0 -> {0, 0};
                                1 -> {ShopGoodsInfo#shop_goods.buy_count_limit_time - HaveBuyCount, 24*3600 + util:calc_today_0_sec()};
                                2 -> {ShopGoodsInfo#shop_goods.buy_count_limit_time - HaveBuyCount, util:get_monday() + 24 * 3600 * 7};
                                3 -> {ShopGoodsInfo#shop_goods.buy_count_limit_time - HaveBuyCount, util:get_unixtime_next_month_begin()}
                            end;
                        false -> {0, 0}
                    end;
                DyShopGoods ->
                    case ShopGoodsInfo#shop_goods.goods_type of
                        2 -> {DyShopGoods#shop_goods.left_num, DyShopGoods#shop_goods.expire_time};
                        _ ->
                            case ShopGoodsInfo#shop_goods.count_limit_type of
                                0 -> {0, DyShopGoods#shop_goods.expire_time};
                                1 -> {ShopGoodsInfo#shop_goods.buy_count_limit_time - HaveBuyCount, DyShopGoods#shop_goods.expire_time};
                                2 -> {ShopGoodsInfo#shop_goods.buy_count_limit_time - HaveBuyCount, DyShopGoods#shop_goods.expire_time};
                                3 -> {ShopGoodsInfo#shop_goods.buy_count_limit_time - HaveBuyCount, DyShopGoods#shop_goods.expire_time}
                            end
                    end
            end,

        case ShopGoodsInfo#shop_goods.goods_type /= 0 andalso ShopGoodsInfo#shop_goods.goods_type =/= 3 andalso (ExpireTime =:= 0 andalso LeftCount =:= 0) of
            true -> %% 过时或卖光的物品不发给客户端
                Acc;
            false ->
                BinRet = 
                    case ShopType of
                        ?SHOP_TYPE_SHOP ->
                            <<
                                (ShopGoodsInfo#shop_goods.goods_no):32,
                                (ShopGoodsInfo#shop_goods.quality):8,          
                                (ShopGoodsInfo#shop_goods.price_type):8,          
                                (ShopGoodsInfo#shop_goods.price):32,
                                (ShopGoodsInfo#shop_goods.discount_price):32,
                                BuyLimit:8,
                                NumberLimit:32,
                                (ShopGoodsInfo#shop_goods.goods_type):8,
                                LeftCount:32,
                                ExpireTime:32,
                                (ShopGoodsInfo#shop_goods.bind_state):8
                            >>;
                        ?SHOP_TYPE_NPC ->
                            <<
                                (ShopGoodsInfo#shop_goods.goods_no):32,
                                (ShopGoodsInfo#shop_goods.quality):8,          
                                (ShopGoodsInfo#shop_goods.price_type):8,          
                                (ShopGoodsInfo#shop_goods.price):32,
                                BuyLimit:8,
                                NumberLimit:32,
                                (ShopGoodsInfo#shop_goods.goods_type):8,
                                LeftCount:32,
                                ExpireTime:32,
                                (ShopGoodsInfo#shop_goods.bind_state):8
                            >>;
                        ?SHOP_TYPE_OP_SHOP ->
                            <<
                                (ShopGoodsInfo#shop_goods.goods_no):32,
                                (ShopGoodsInfo#shop_goods.quality):8,          
                                (ShopGoodsInfo#shop_goods.price_type):8,          
                                (ShopGoodsInfo#shop_goods.discount_price):32,
                                (ShopGoodsInfo#shop_goods.discount):8,
                                (ShopGoodsInfo#shop_goods.goods_type):8,
                                LeftCount:32,
                                ExpireTime:32,
                                (ShopGoodsInfo#shop_goods.bind_state):8
                            >>
                    end,
                [BinRet | Acc]
        end
    end,

    ?DEBUG_MSG("ShopGoodsL=~p",[ShopGoodsL]),
    lists:foldl(F, [], ShopGoodsL).



%% {true, NewData} | false
check_op_shop_activity_data(Data) ->
    ?DEBUG_MSG("lib_shop:check_op_shop_activity_data, Para:~w~n", [Data]),
    case util:bitstring_to_term(Data) of
        DataList when is_list(DataList) ->
            ?DEBUG_MSG("lib_shop:check_op_shop_activity_data, Content:~w~n", [DataList]),
            NoList = sets:to_list(sets:from_list(data_op_shop:get_all_op_shop_no_list())),
            F = fun(Para, Sum)  when is_tuple(Para) ->
                {Day, No} = Para,
                case lists:member(No, NoList) andalso is_integer(Day) of
                    true -> Sum + 1;
                    false -> Sum
                end;
                (_, Sum) -> Sum
            end,

            case length(DataList) =:= lists:foldl(F, 0, DataList) of
                true ->
                    {true, DataList};
                false -> 
                    ?DEBUG_MSG("lib_shop:check_op_shop_activity_data, Data length error!~w~n", [DataList]),
                    false
            end;
        _Any ->
            ?DEBUG_MSG("lib_shop:check_op_shop_activity_data, rfc4627:decode error!~w~n", [_Any]),
            false
    end.


%% ================================ Local fun =============================================


make_dynamic_shop_goods_record(SrcData, TimeNow) ->
    [GoodsNo, LastRefreshTime, ExpireTime, LeftNum] = SrcData,
    CfgShopGoods = 
        case mod_admin_activity:is_festival_activity_alive(10) of
            false -> data_shop:get(GoodsNo);
            true -> data_shop_discount:get(GoodsNo)   
        end,

    case CfgShopGoods =:= null of
        true -> null;
        false ->
            if
                CfgShopGoods#shop_goods.continue_day =/= nil andalso CfgShopGoods#shop_goods.server_start_day =:= nil andalso TimeNow >= ExpireTime ->
                    null;
                true ->
                    ShopGoods = CfgShopGoods,
                    ShopGoods#shop_goods{
                        last_refresh_time = LastRefreshTime,
                        expire_time = ExpireTime,
                        left_num = LeftNum
                    }
            end
    end.


can_refresh_now(_CurUnixTime, {StartDay, Hour, ContinueDay}) when is_integer(StartDay) ->
    OpenSvrDay = util:get_server_open_nth_day(),
    if
        StartDay /= nil andalso Hour /= nil ->
            OpenSvrDay >= StartDay andalso OpenSvrDay =< ContinueDay andalso util:get_hour() >= Hour;
        true ->
            false
    end;
can_refresh_now(_CurUnixTime, {WeekList, Hour}) ->
    if 
        WeekList /= [] andalso Hour /= nil ->
            lists:member(util:get_week(), WeekList) andalso util:get_hour() >= Hour;
        true ->
            false
    end;
can_refresh_now(_CurUnixTime, {Year, Month, Day, Hour}) ->
    if 
        Year =:= nil ->
            lists:member(util:get_month(), Month) andalso lists:member(util:get_day(), Day) andalso util:get_hour() >= Hour;
        Year /= nil ->
            util:get_year() =:= Year andalso lists:member(util:get_month(), Month) andalso 
            lists:member(util:get_day(), Day) andalso util:get_hour() >= Hour;
        true ->
            false
    end.

        
%%{1, {year, month, day, hour}} 具体某一天刷新
%%{2, {weekList, hour}}      开服后每周几几点刷新
%%{3, {StartDay, hour}}  开服第几天几点开始刷新
%%{0, 0} 无效的
get_dy_shop_goods_refresh_time(DyShopGoods) ->
    if
        DyShopGoods#shop_goods.month /= nil andalso DyShopGoods#shop_goods.day /= nil andalso DyShopGoods#shop_goods.hour /= nil ->
            {1, {DyShopGoods#shop_goods.year, DyShopGoods#shop_goods.month, DyShopGoods#shop_goods.day, DyShopGoods#shop_goods.hour}};

        DyShopGoods#shop_goods.week /= nil andalso DyShopGoods#shop_goods.hour /= nil ->
            {2, {DyShopGoods#shop_goods.week, DyShopGoods#shop_goods.hour}};

        DyShopGoods#shop_goods.server_start_day /= nil andalso DyShopGoods#shop_goods.hour /= nil andalso DyShopGoods#shop_goods.continue_day /= nil ->
            {3, {DyShopGoods#shop_goods.server_start_day, DyShopGoods#shop_goods.hour, DyShopGoods#shop_goods.continue_day}};
        true ->
            %?ASSERT(false),
            {0, 0}
    end.