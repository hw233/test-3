%%%-----------------------------------
%%% @Module  : mod_business
%%% @Author  : 段世和
%%% @Email   : 
%%% @Created : 2015.07.06
%%% @Description: 商会交易系统
%%%-----------------------------------



%% 所有的buy 都是只玩家买入 所有的sell都是玩家卖出

-module(mod_business).

% include
-include("common.hrl").
-include("business.hrl").
% -include("goods.hrl").
% -include("record/goods_record.hrl").
-include("abbreviate.hrl").
-include("player.hrl").
-include("ets_name.hrl").
-include("log.hrl").
-include("sys_code_2.hrl").
-include("prompt_msg_code.hrl").
-include("num_limits.hrl").

-export([init/1, handle_cast/2, handle_call/3, handle_info/2, terminate/2, code_change/3]).
-export([start/0, start_link/0, stop/0]).

-export([
    save_to_db/0,
	db_save/0,
    check_can_sell_global/2,
    check_can_buy_global/2,
    check_can_sell_single/3,
    check_can_buy_single/3,
    check_stock/2,
    sell_global/2,
    buy_global/2,
    sell_single/3,
    buy_single/3,

    business_buy_goods/3,
    business_sell_goods/3,
    get_all_persistence/0,
    get_server_persistence_by_type/2,
    get_server_persistence_by_no/1,
    check_refresh_single/1,
    calculate_real_price/1,
    calculate_sell_price/2
]).

% function body
% 循环检测
loop_check() ->
    Now = lib_business:build_now(),
    %?DEBUG_MSG("loop_check Now=~p",[Now]),
    ets:foldl(fun loop_check/2, Now, ?ETS_BUSINESS_SERVER),
    %?DEBUG_MSG("ets foldl",[]),
    db_save().

% 递归检测
loop_check(#business_server_persistence{no=No} = BusinessServerPer, Now) ->
    %?DEBUG_MSG("loop_check Now=~p,No=~p,BusinessServerPer=~p",[Now,No,BusinessServerPer]),
    case data_business_config:get(No) of
        BusinessConfig when is_record(BusinessConfig,data_business_config) ->
            case lib_business:is_should_refresh(BusinessConfig, Now) of
                true ->
                    refresh(BusinessServerPer);
                _ ->
                    skip
            end;
        _ -> 
            ets:delete(?ETS_BUSINESS_SERVER, No)
    end,
    Now.

% 刷新持久化数据
% 将版本号+1，当前出售次数跟购买次数都设置为0
refresh(#business_server_persistence{no=No,version=OldVersion,stock=Stock,total_sell_count=OldTolalSellCount, total_buy_count=OldTolalBuyCount} = BusinessServerPer) ->
    BusinessConfig = data_business_config:get(No),
    RefreshNum = BusinessConfig#data_business_config.refresh_num,
    % 避免溢出
    NewStock = erlang:min(?MAX_U32,Stock + RefreshNum),

    Difference = OldTolalBuyCount - OldTolalSellCount,
    CorrectValue = util:floor(Difference * 0.3),
    % 每次刷新将兼容30%
    
    % 系统刷新的数量将直接影响价格
    NewBusinessServerPer = BusinessServerPer#business_server_persistence{sell_count=0,buy_count=0,version=OldVersion+1,stock=NewStock,total_sell_count=OldTolalSellCount + CorrectValue},

    % ?DEBUG_MSG("NewBusinessServerPer = ~p | BusinessServerPer = ~p | CorrectValue = ~p",[NewBusinessServerPer,BusinessServerPer,CorrectValue]),
    update_to_ets(NewBusinessServerPer).

% 检测全局限制是否有足够的数量进行出售
check_can_sell_global(#business_server_persistence{no=No,sell_count=SellCount},Count) ->
    BusinessConfig = data_business_config:get(No),

    Ret = case BusinessConfig#data_business_config.global_sell_count_limit of 
        0 -> true;
        ConfigSellCount -> SellCount + Count < ConfigSellCount
    end,

    Ret.

% 检测全局限制是否还能收购
check_can_buy_global(#business_server_persistence{no=No,buy_count=BuyCount},Count) ->
    BusinessConfig = data_business_config:get(No),

    Ret = case BusinessConfig#data_business_config.global_buy_count_limit of 
        0 -> true;
        ConfigBuyCount -> BuyCount + Count < ConfigBuyCount
    end,

    Ret.

% 检测个人是否可以
check_can_sell_single(PS,No,Count) ->
    % 获取对应的配置信息
    BusinessConfig = data_business_config:get(No),

    % 获取当前编号的商会信息
    BusinessPlayerPer = lib_business:get_business_player_persistence(PS,No),

    % 获取当前的出售数量
    SellCount = BusinessPlayerPer#business_player_persistence.sell_count,

    % 获取配置文件中的限制出售数量
    Ret = case BusinessConfig#data_business_config.sell_count_limit of 
        0 -> true;
        ConfigSellCount -> SellCount + Count =< ConfigSellCount
    end,

    Ret.

% 检测个人是否可以
check_can_buy_single(PS,No,Count) ->
    % 获取对应的配置信息
    BusinessConfig = data_business_config:get(No),

    % 获取当前编号的商会信息
    BusinessPlayerPer = lib_business:get_business_player_persistence(PS,No),

    % 获取当前的出售数量
    BuyCount = BusinessPlayerPer#business_player_persistence.buy_count,

    % 获取配置文件中的限制出售数量
    Ret = case BusinessConfig#data_business_config.buy_count_limit of 
        0 -> true;
        ConfigBuyCount -> BuyCount + Count =< ConfigBuyCount
    end,

    Ret.

% 全局出售1个 库存+1
sell_global(#business_server_persistence{sell_count=SellCount,total_sell_count=TotalSellCount,stock=Stock} = BusinessServerPer,Count) ->
    NewBusinessServerPer = BusinessServerPer#business_server_persistence{sell_count=SellCount + Count,total_sell_count = TotalSellCount + Count , stock=Stock + Count},    
    update_to_ets(NewBusinessServerPer).

% 全局购买
buy_global(#business_server_persistence{buy_count=BuyCount,total_buy_count=TotalBuyCount,stock=Stock} = BusinessServerPer,Count) ->
    NewBusinessServerPer = BusinessServerPer#business_server_persistence{buy_count=BuyCount + Count ,total_buy_count = TotalBuyCount + Count , stock=Stock - Count},
    ?DEBUG_MSG("NewBusinessServerPer=~p,Stock=~p,Count=~p",[NewBusinessServerPer,Stock,Count]),
    update_to_ets(NewBusinessServerPer).

% 检查个人是否需要更新
check_refresh_single(PS) ->
    % BusinessInfo = player:get_business_info(PS),
    Nos = data_business_config:get_ids(),
    check_refresh_single_no(PS,Nos).

check_refresh_single_no(_PS,[]) ->
    void;

check_refresh_single_no(PS,[H|T]) ->
    BusinessPlayerPer = lib_business:get_business_player_persistence(PS,H),
    BusinessServerPer = get_business_persistence(H),

    PlayerVersion = BusinessPlayerPer#business_player_persistence.version,
    ServerVersion = BusinessServerPer#business_server_persistence.version,

    if 
        PlayerVersion < ServerVersion ->
            NewBusinessPlayerPer = BusinessPlayerPer#business_player_persistence{sell_count = 0,buy_count = 0,version = ServerVersion},
            lib_business:set_business_player_persistence(PS,H,NewBusinessPlayerPer);
        true -> nothing
    end,

    check_refresh_single_no(PS,T).


% 个人出售1个
sell_single(PS,No,Count) ->
    BusinessPlayerPer = lib_business:get_business_player_persistence(PS,No),
    OldSellCount = BusinessPlayerPer#business_player_persistence.sell_count,
    case check_can_sell_single(PS,No,Count) of
        true -> 
            NewBusinessPlayerPer = BusinessPlayerPer#business_player_persistence{sell_count = OldSellCount + Count},
            % 替换
            lib_business:set_business_player_persistence(PS,No,NewBusinessPlayerPer),
            true;
        false -> false
        % 无法出售
    end.

% 个人收购1个
buy_single(PS,No,Count) ->
    BusinessPlayerPer = lib_business:get_business_player_persistence(PS,No),
    %?DEBUG_MSG("BusinessPlayerPer=~p",[BusinessPlayerPer]),
    OldBuyCount = BusinessPlayerPer#business_player_persistence.buy_count,
    %?DEBUG_MSG("OldBuyCount=~p",[OldBuyCount]),
    case check_can_buy_single(PS,No,Count) of
        true -> 
            NewBusinessPlayerPer = BusinessPlayerPer#business_player_persistence{buy_count = OldBuyCount + Count},
            % 替换
            %?DEBUG_MSG("NewBusinessPlayerPer=~p",[NewBusinessPlayerPer]),
            lib_business:set_business_player_persistence(PS,No,NewBusinessPlayerPer),
            true;
        false -> false
        % 无法出售
    end.


% 检测库存是否有
check_stock(#business_server_persistence{stock=Stock},Num) when is_integer(Stock) andalso is_integer(Num) ->
    ?DEBUG_MSG("Stock=~p,Num=~p",[Stock,Num]),
    Stock >= Num.

% 更新到ETS
update_to_ets(BusinessServerPer) when is_record(BusinessServerPer, business_server_persistence) ->
    ets:insert(?ETS_BUSINESS_SERVER, BusinessServerPer).

% 商会购买物品
business_buy_goods(PS, No, BuyCount) ->
    case check_buy_cons_and_capacity(PS, No, BuyCount) of
        {fail, Reason} ->
             ?DEBUG_MSG("Reason=~p",[Reason]),
            {fail, Reason};
        ok ->
            buy_and_give_goods(PS, No, BuyCount)
    end.

% 商会出售物品
business_sell_goods(PS, GoodsId, SellCount) ->
    case check_sell_cons_and_capacity(PS, GoodsId, SellCount) of
        {fail, Reason} ->
            {fail, Reason};
        ok ->
            sell_and_give_money(PS, GoodsId, SellCount)
    end.

% 检测是否有足够的钱与背包格子
check_buy_cons_and_capacity(PS,No,BuyCount) ->
    try check_buy_cons_and_capacity__(PS, No, BuyCount) of
        ok ->
            ok
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

% 检测是是否可以出售足够多的物品
check_sell_cons_and_capacity(PS,GoodsId,SellCount) ->
    try check_sell_cons_and_capacity__(PS, GoodsId, SellCount) of
        ok ->
            ok
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

% 计算实际价格
calculate_real_price(BusinessServerPer) ->
    No = BusinessServerPer#business_server_persistence.no,
    BusinessConfig = data_business_config:get(No),

    Price = BusinessConfig#data_business_config.price,
    ?DEBUG_MSG("BasePrice = ~p",[Price]),

    Extent = BusinessConfig#data_business_config.extent,
    TotalBuyCount = BusinessServerPer#business_server_persistence.total_buy_count - BusinessServerPer#business_server_persistence.total_sell_count,
    RealPrice = Price * (1 + erlang:max(TotalBuyCount * Extent,-0.7)),
    ?DEBUG_MSG("RealPrice = ~p",[RealPrice]),

    util:ceil(erlang:max(RealPrice,0)).

% 计算贩卖价格
calculate_sell_price(GoodsId,BusinessServerPer) ->
    No = BusinessServerPer#business_server_persistence.no,
    BusinessConfig = data_business_config:get(No),

    Goods = lib_goods:get_goods_by_id(GoodsId),
    
    BuyPirce = case lib_goods:get_purchase_price(Goods) of
        0 -> BusinessConfig#data_business_config.price;
        BuyPirce_ -> BuyPirce_
    end,

    Price = BusinessConfig#data_business_config.price,
    ?DEBUG_MSG("BasePrice = ~p",[Price]),
    ?DEBUG_MSG("BuyPirce = ~p",[BuyPirce]),

    Extent = BusinessConfig#data_business_config.extent,
    TotalBuyCount = BusinessServerPer#business_server_persistence.total_buy_count - BusinessServerPer#business_server_persistence.total_sell_count,
    
    % 基础价格计算涨跌幅度*折扣
    RealPrice = Price * (1 + erlang:max(TotalBuyCount * Extent,-0.7)) * ?SELL_DISCOUNT,
    ?DEBUG_MSG("RealPrice = ~p",[RealPrice]),

    % 取小值
    RealPrice1 = erlang:min(RealPrice,BuyPirce),

    ?DEBUG_MSG("RealPrice1 = ~p",[RealPrice1]),
    util:ceil(erlang:max(RealPrice1,0)).


% 检测购买消耗
check_buy_cons_and_capacity__(PS,No,BuyCount) ->
    % 获取配置信息
    BusinessConfig = data_business_config:get(No),
    % ?DEBUG_MSG("BusinessConfig=~p",[BusinessConfig]),
    ?Ifc(BusinessConfig =:= null)
        throw(?PM_PARA_ERROR)
    ?End,

    BusinessServerPer = get_business_persistence(No),

    % 检查
    % ?DEBUG_MSG("BusinessServerPer=~p",[BusinessServerPer]),
    ?Ifc(BusinessServerPer =:= null orelse not(is_record(BusinessServerPer, business_server_persistence)))
        throw(?PM_PARA_ERROR)
    ?End,

    % 检查库存
    ?Ifc(not(check_stock(BusinessServerPer,BuyCount)))
        throw(?PM_NOT_STOCK)
    ?End,

    % 检查全局限制
    ?Ifc(not(check_can_buy_global(BusinessServerPer,BuyCount)))
        throw(?PM_GLOBAL_BUY_MAX_LIMIT)
    ?End,

    % 检查个人限制
    ?Ifc(not(check_can_buy_single(PS,No,BuyCount)))
        throw(?PM_SINGLE_BUY_MAX_LIMIT)
    ?End,

    % 获取几个必要字段
    % GoodsNo = BusinessConfig#data_business_config.no,
    PriceType = BusinessConfig#data_business_config.price_type,
    % Price = BusinessConfig#data_business_config.price,
    Price = calculate_real_price(BusinessServerPer) * BuyCount, 

    % 检测金额是否足够
    RetMoney = player:check_need_price(PS, PriceType,Price),

    ?Ifc (RetMoney =/= ok)
        throw(RetMoney)
    ?End,

    % 检测是否可以添加物品
    case mod_inv:check_batch_add_goods(player:id(PS), [{No, BuyCount}]) of
        {fail, Reason} ->
            throw(Reason);
        ok ->
            ok
    end.

% 检测贩卖
check_sell_cons_and_capacity__(PS,GoodsId,SellCount) ->
    % 获取配置信息
    No = lib_goods:get_no_by_id(GoodsId),

    % ?DEBUG_MSG("[sell item] id=~p,no=~p,SellCount=~p",[GoodsId,No,SellCount]),
    BusinessConfig = data_business_config:get(No),
    ?Ifc(BusinessConfig =:= null)
        throw(?PM_PARA_ERROR)
    ?End,
    % ?DEBUG_MSG("[sell item] BusinessConfig=~p",[BusinessConfig]),

    BusinessServerPer = get_business_persistence(No),
    % ?DEBUG_MSG("[sell item] BusinessServerPer=~p",[BusinessServerPer]),
    % 检查
    ?Ifc(BusinessServerPer =:= null orelse not(is_record(BusinessServerPer, business_server_persistence)))
        throw(?PM_PARA_ERROR)
    ?End,

    % 检查全局限制
    ?Ifc(not(check_can_sell_global(BusinessServerPer,SellCount)))
        throw(?PM_GLOBAL_SELL_MAX_LIMIT)
    ?End,

    % 检查个人限制
    ?Ifc(not(check_can_sell_single(PS,No,SellCount)))
        throw(?PM_SINGLE_SELL_MAX_LIMIT)
    ?End,

    % 检测是否可以删除物品
    case mod_inv:check_batch_destroy_goods_by_id(player:id(PS), [{GoodsId,SellCount}]) of
        {fail, Reason} ->
            throw(Reason);
        ok ->
            ok
    end.

% 购买并给予物品
buy_and_give_goods(PS,No,BuyCount) ->
    % 获取对应的配置信息
    BusinessConfig = data_business_config:get(No),
    PriceType = BusinessConfig#data_business_config.price_type,
    
    % GoodsNo = BusinessConfig#data_business_config.no,
    BindState = BusinessConfig#data_business_config.bind_state,

    BusinessServerPer = get_business_persistence(No),
    Price = calculate_real_price(BusinessServerPer) * BuyCount,   
    
    ?DEBUG_MSG("BusinessServerPer=~p",[BusinessServerPer]),
    %全局购买
    buy_global(BusinessServerPer,BuyCount),
    %个人购买
    buy_single(PS,No,BuyCount),

    % 消耗货币
    player:cost_money(PS, PriceType, Price, [?LOG_BUSINESS, "buy_goods"]),
    % 添加道具
    case mod_inv:batch_smart_add_new_goods(player:id(PS), [{No, BuyCount}], [{bind_state, BindState}], [?LOG_BUSINESS, "buy_goods"]) of
    {ok, RetGoods} ->

        F = fun({Id, _No, _Cnt}) ->
                case mod_inv:find_goods_by_id_from_bag(player:id(PS), Id) of
                    null -> skip;
                    Goods ->
                        % 记录买入价格跟买入价格类型
                        case lib_goods:get_purchase_price(Goods) of
                            0 -> 
                                Goods1 = lib_goods:set_purchase_price(Goods,util:ceil(Price/BuyCount)),
                                Goods2 = lib_goods:set_purchase_price_type(Goods1,PriceType),
                                mod_inv:mark_dirty_flag(player:get_id(PS), Goods2),
                                lib_inv:notify_cli_goods_info_change(player:id(PS), Goods2);
                            _ -> skip
                        end
                end
        end,

        [F(X) || X <- RetGoods];
        
    _ ->
        ?ERROR_MSG("buy_and_give_goods() failed:~p", [])
    end,
    ok.

% 出售并给予货币删除物品
sell_and_give_money(PS,GoodsId,SellCount) ->
    No = lib_goods:get_no_by_id(GoodsId),
    BusinessConfig = data_business_config:get(No),
    PriceType = BusinessConfig#data_business_config.price_type,

    BusinessServerPer = get_business_persistence(No),
    Price = calculate_sell_price(GoodsId,BusinessServerPer) * SellCount, 

    % 全局出售
    sell_global(BusinessServerPer,SellCount),

    % 个人出售
    sell_single(PS,No,SellCount),

    % 删除道具
    mod_inv:destroy_goods_by_id_WNC(player:id(PS), [{GoodsId, SellCount}], [?LOG_BUSINESS, "sell_goods"]),

    % 添加货币
    player:add_money(PS, PriceType, Price, [?LOG_BUSINESS, "sell_goods"]),
    ok.

% 保存数据
db_save() ->
    All = ets_to_list(),
    % ?DEBUG_MSG("business sava ALL=~p",[All]),
    mod_data:save(?SYS_BUSINESS, All).

% 获取全部business persistence
get_all_persistence() ->
    All = ets_to_list(),
    All.

% 获取全部business persistence
get_server_persistence_by_type(Type,SubType) ->
    All = ets_to_list(),

    % ?DEBUG_MSG("get_server_persistence_by_type All=~p",[All]),
    
    List = lists:filter(
        fun(P) -> 
            No = P#business_server_persistence.no,
            BusinessConfig = data_business_config:get(No),

            if 
                is_record(BusinessConfig,data_business_config) ->
                % ?DEBUG_MSG("filter sava Type=~p,SubType=~p,No=~p,P=~p,BusinessConfig=~p,t=~p,st=~p",[Type,SubType,No,P,BusinessConfig,BusinessConfig#data_business_config.type,BusinessConfig#data_business_config.sub_type]),

                BusinessConfig#data_business_config.type =:= Type  andalso
                BusinessConfig#data_business_config.sub_type =:= SubType;
                true -> false
            end
        end
    , All),

    List.

% 获取对应编号的信息
get_server_persistence_by_no(No) ->
    All = ets_to_list(),
    
    List = lists:filter(
        fun(P) -> 
            P#business_server_persistence.no =:= No
        end
    , All),

    List.



% 加载数据
db_load() ->
    case mod_data:load(?SYS_BUSINESS) of
        [] ->
            ok;
        [All] ->
            ets:insert(?ETS_BUSINESS_SERVER, All)
    end.

% 从ets获取所有的数据
ets_to_list() ->
    ets:foldl(fun(I, A) -> [I|A] end, [], ?ETS_BUSINESS_SERVER).

save_to_db() ->
    gen_server:call(?MODULE, save_to_db).

% start
start() ->
    case erlang:whereis(?MODULE) of
        undefined ->
            case supervisor:start_child(
               sm_sup,
               {?MODULE,
                {?MODULE, start_link, []},
                 permanent, 10000, worker, [?MODULE]}) of
            {ok, Pid} ->
                Pid;
            {error, R} ->
                ?WARNING_MSG("start error:~p~n", [R]),
                undefined
            end;
        Pid ->
            Pid
    end.

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

% stop
stop() ->
    gen_server:call(?MODULE, save_to_db),
    supervisor:terminate_child(sm_sup, ?MODULE).


code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

terminate(_Reason, _State) ->
    ok.

% call 同步调用需要等待结构
do_call(save_to_db, _From, State) ->
    %?DEBUG_MSG("business sava 1",[]),
    db_save(),
    %?DEBUG_MSG("business sava 2",[]),
    {reply, ok, State};

do_call(_Msg, _From, State) ->
    ?WARNING_MSG("unhandle call ~w", [_Msg]),
    {reply, error, State}.

% 异步调用无需等待
% cast
do_cast(_Msg, State) ->
    ?WARNING_MSG("unhandle cast ~p", [_Msg]),
    {noreply, State}.

%% info
do_info(doloop, State) ->
    %?DEBUG_MSG("doloop 1",[]),
    loop_check(),
    %?DEBUG_MSG("doloop 2",[]),
    {noreply, State};

do_info(_Msg, State) ->
    ?WARNING_MSG("unhandle info ~w", [_Msg]),
    {noreply, State}.

% 执行初始化
do_init() ->
    db_load(),
    Nos = data_business_config:get_ids(),
    lists:foreach(fun init_item/1, Nos).

% 初始化一个
init_item(No) ->
    % ?DEBUG_MSG("init business no,~p",[No]),
    case ets:lookup(?ETS_BUSINESS_SERVER, No) of
        [#business_server_persistence{}] ->
            skip;
        _ ->
            BusinessConfig = data_business_config:get(No), 
            BusinessServerPer = #business_server_persistence{
                no = No,                                
                version = 0,                            
                sell_count = 0,                         
                buy_count = 0,                         
                total_sell_count = 0,                   
                total_buy_count = 0,  
                stock = BusinessConfig#data_business_config.init_num           
            },

            ets:insert(?ETS_BUSINESS_SERVER, BusinessServerPer)
    end.

% 获取一个配置
get_business_persistence(No) ->
    case ets:lookup(?ETS_BUSINESS_SERVER, No) of
        [#business_server_persistence{} = BP] -> BP;
        _ -> null
    end.


init([]) ->
    ets:new(?ETS_BUSINESS_SERVER, [{keypos, #business_server_persistence.no}, named_table, public, set]), % 商会ETS初始化

    mod_timer:reg_loop_msg(self(), 60000),
    % ?DEBUG_MSG("init business1",[]),
    do_init(),
    % ?DEBUG_MSG("init business2",[]),
    {ok, #state{}}.


% handle
handle_call(Request, From, State) ->
    try
        do_call(Request, From, State)
    catch
        Err:Reason->
            ?ERROR_MSG("ERR:~p,Reason:~p, Request:~p",[Err,Reason, Request]),
             {reply, error, State}
    end.


handle_cast(Request, State) ->
    try
        do_cast(Request, State)
    catch
        Err:Reason->
            ?ERROR_MSG("ERR:~p,Reason:~p, Request:~p",[Err,Reason, Request]),
             {noreply, State}
    end.



handle_info(Request, State) ->
    try
        do_info(Request, State)
    catch
        Err:Reason->
            ?ERROR_MSG("ERR:~p,Reason:~p, Request:~p",[Err,Reason, Request]),
             {noreply, State}
    end.