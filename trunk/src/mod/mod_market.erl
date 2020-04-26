%%%------------------------------------
%%% @Module  : mod_market
%%% @Author  : huangjf zhangwq
%%% @Email   :
%%% @Created : 2011.10.13
%%% @Description: 供应市场
%%%------------------------------------


-module(mod_market).
-behaviour(gen_server).
-export([start_link/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-export([
		sell_goods/1,
		sell_money/1,
		resell_goods/1,
		buy_goods/1,
		query_my_sell_list/1,
		cancel_sell/2,
		search_selling_goods/2,
        search_selling_goods1/2,
		get_back_expired_goods/2,
		get_goods_info_from_market/1
	]).

-include("common.hrl").
-include("record/goods_record.hrl").
-include("market.hrl").
-include("goods.hrl").
-include("protocol/pt_26.hrl").
-include("prompt_msg_code.hrl").
-include("reward.hrl").
-include_lib("stdlib/include/ms_transform.hrl").
-include("ets_name.hrl").
-include("log.hrl").
-include("num_limits.hrl").
-include("proc_name.hrl").

-define(MARKET_LV, 48).  % 等级限制拍卖


%% 挂售物品 玩家进程
sell_goods(Args) ->
	?TRACE("mod_market: sell_goods()...~n"),
	Ret = case try_sell_goods(Args) of
		      {fail, Why}  -> {fail, Why};
		      {error, Why} -> {error, Why};
		      {ok}         -> sell_goods_ok(Args)
		  end,
	Ret.

%% 挂售货币 玩家进程
sell_money(Args) ->
	Ret = case try_sell_money(Args) of
		      {fail, Why}  -> {fail, Why};
		      {error, Why} -> {error, Why};
		      {ok}         -> sell_money_ok(Args)
		  end,
	Ret.
	
	
%% 重新挂售过期的上架物品 拍卖行进程
resell_goods(Args) ->
    [_PS, SellRecordId, _Price, _PriceType, _SellTime] = Args,
    case get_sell_record_from_ets(SellRecordId) of
        null ->
            {fail, ?PM_MK_BUY_FAIL_GOODS_NOT_SELLING};
        _ ->
         	case catch gen_server:call(?MARK_PROCESS, {'resell_goods', Args}) of
                {'EXIT', Reason} ->
                    ?ERROR_MSG("mod_market:resell_goods(), exit for reason: ~w~n", [Reason]),
                    ?ASSERT(false, Reason),
                    {fail, ?PM_MK_FAIL_SERVER_BUSY};
                {fail, Reason} ->
                    {fail, Reason};
                {error, Why} -> 
                	{error, Why};
                {ok, NewPS} ->
                    {ok, NewPS};
                _Any ->
                    ?ERROR_MSG("mod_market:resell_goods(), error!: ~w~n", [_Any]),
                    {fail, ?PM_UNKNOWN_ERR}
            end
    end.

%% 拍卖行进程
buy_goods(Args) ->
    [PS, SellRecordId, StackNum] = Args,
    case player:get_lv(PS) >= ?MARKET_LV of
        true -> 
            case get_sell_record_from_ets(SellRecordId) of
                null ->
                    {fail, ?PM_MK_BUY_FAIL_GOODS_NOT_SELLING};
                BuyTarget ->
                    case BuyTarget#mk_selling.stack_num < StackNum of
                        true -> 
                            {fail, ?PM_GOODS_NOT_ENOUGH};
                        false ->
                            case catch gen_server:call(?MARK_PROCESS, {'buy_goods', Args}) of
                                {'EXIT', Reason} ->
                                    ?ERROR_MSG("mod_market:buy_goods(), exit for reason: ~w~n", [Reason]),
                                    ?ASSERT(false, Reason),
                                    {fail, ?PM_MK_FAIL_SERVER_BUSY};
                                {fail, Reason} ->
                                    {fail, Reason};
                                {ok, SellerId, NewPS} ->
                                    {ok, SellerId, NewPS};
                                _Any ->
                                    ?ERROR_MSG("mod_market:buy_goods(), error!: ~w~n", [_Any]),
                                    {fail, ?PM_UNKNOWN_ERR}
                            end
                    end
            end;
        false ->
            {fail, ?PM_LV_LIMIT}
    end.


%% 查看我的上架物品s 玩家进程
query_my_sell_list(PS) ->
    PlayerId = player:id(PS),
    Ms = ets:fun2ms(fun(T) when PlayerId =:= T#mk_selling.seller_id -> T end),
    MySellList = ets:select(?ETS_MARKET_SELLING, Ms),
    {ok, BinData} = pt_26:write(?PT_MK_QUERY_MY_SELL_LIST, MySellList),
    lib_send:send_to_sock(PS, BinData).
    % gen_server:cast(?MARK_PROCESS, {'query_my_sell_list', PS}).
    
%% 拍卖行进程
cancel_sell(PS, SellRecordId) ->
    case get_sell_record_from_ets(SellRecordId) of
        null -> 
            lib_send:send_prompt_msg(PS, ?PM_MK_BUY_FAIL_GOODS_NOT_SELLING);
        _ -> 
            gen_server:cast(?MARK_PROCESS, {'cancel_sell', PS, SellRecordId})
    end.
    
    
%% 搜索市场的上架物品（分页返回搜索结果）
search_selling_goods(PS, Args) ->
    ?TRY_CATCH(try_search_selling_goods(PS, Args), Err_Reason).
    % gen_server:cast(?MARK_PROCESS, {'search_selling_goods', PS, Args}).

% duan
search_selling_goods1(PS, Args) ->
    ?TRY_CATCH(try_search_selling_goods1(PS, Args), Err_Reason).
    % gen_server:cast(?MARK_PROCESS, {'search_selling_goods', PS, Args}).

%% 取回过期的上架物品
get_back_expired_goods(PS, SellRecordId) ->
    case get_sell_record_from_ets(SellRecordId) of
        null -> skip;
        _ -> gen_server:cast(?MARK_PROCESS, {'get_back_expired_goods', PS, SellRecordId})
    end.

	
	
%% 添加物品信息到市场（用于支持实现查看市场挂售物品的信息的功能）
%% @para: GoodsAttrList => 物品的附加属性信息列表
add_goods_info_to_market(Goods) ->
	?ASSERT(is_record(Goods, goods)),
	gen_server:cast(?MARK_PROCESS, {'add_goods_info_to_market', Goods}).
	
%% 从市场删除物品信息
% del_goods_info_from_market(GoodsId) ->
% 	gen_server:cast(?MARK_PROCESS, {'del_goods_info_from_market', GoodsId}).

%% 从市场的全局缓存获取物品信息
get_goods_info_from_market(GoodsId) ->
    get_goods_info_from_ets(GoodsId).
	% 处理超时的情况
	% case catch gen_server:call(?MARK_PROCESS, {'get_goods_info_from_market', GoodsId}) of
 %        {'EXIT', _Reason} ->
 %        	?ERROR_MSG("get_goods_info_from_market(), exit for reason: ~w~n", [_Reason]),
 %        	?ASSERT(false, {_Reason, GoodsId}),
 %            {fail};
 %        null ->
 %        	% ?ASSERT(false, GoodsId),
 %            {ok, null};
 %        Goods ->
 %        	?TRACE("get_goods_info_from_market ~p~n", [Goods]),
 %        	{ok, Goods}
 %    end.


%% 添加挂售记录到市场
add_sell_record_to_market(SellRecord) ->
	?ASSERT(is_record(SellRecord, mk_selling)),
	gen_server:cast(?MARK_PROCESS, {'add_sell_record_to_market', SellRecord}).
	
%% 更新挂售记录到市场
% update_sell_record_to_market(NewSellRecord) ->
% 	?ASSERT(is_record(NewSellRecord, mk_selling)),
% 	gen_server:cast(?MARK_PROCESS, {'update_sell_record_to_market', NewSellRecord}).


%% 从市场删除挂售记录
% del_sell_record_from_market(SellRecordId) ->
% 	gen_server:cast(?MARK_PROCESS, {'del_sell_record_from_market', SellRecordId}).
	
	
%% 依据挂售记录id查找挂售记录 
%% @return: {fail} | {ok, null} | {ok, SellRecord}
% get_sell_record_from_market(SellRecordId) ->
% 	% 处理超时的情况
% 	case catch gen_server:call(?MARK_PROCESS, {'get_sell_record_from_market', SellRecordId}) of
%         {'EXIT', _Reason} ->
%         	?ERROR_MSG("get_sell_record_from_market(), exit for reason: ~w~n", [_Reason]),
%         	?ASSERT(false, _Reason),
%             {fail};
%         null ->
%         	%%?ASSERT(false),
%             {ok, null};
%         RetSellRecord ->
%         	{ok, RetSellRecord}
%     end.
    
    
	
	
% -------------------------------------------------------------------------

start_link() ->
    gen_server:start_link({local, ?MARK_PROCESS}, ?MODULE, [], []).

init([]) ->
    process_flag(trap_exit, true),
	
	ets:new(?ETS_MARKET_SELLING, [{keypos, #mk_selling.id}, named_table, public, set]),  % 市场上架物品表
	ets:new(?ETS_MARKET_GOODS_ONLINE, [{keypos, #goods.id}, named_table, public, set]),  % 市场的挂售物品信息表

    lib_market:init_market_from_db(),

    % 定时清理过期太久的上架物品
    ExtraRandIntv = util:rand(0, 60 * 1000), % 时间随机一下
    erlang:send_after(?CLEAR_EXPIRED_GOODS_INTV + ExtraRandIntv, self(), {'clear_expired_goods', 0}),
    {ok, none}.
    
    
handle_call(Request, From, State) ->
    try
        handle_call_2(Request, From, State)
    catch
        Err:Reason ->
            ?ERROR_MSG("ERR:~p,Reason:~p, ~w",[Err, Reason, erlang:get_stacktrace()]),
             {reply, error, State}
    end.
	

%% 购买物品
handle_call_2({'buy_goods', Args}, _From, State) ->
    Ret = 
        case try_buy_goods(Args) of
            {fail, Why} -> {fail, Why};
            {ok, TargetGoods} ->  buy_goods_ok(Args, TargetGoods)
        end,
    {reply, Ret, State};


handle_call_2({'resell_goods', Args}, _From, State) ->
	Ret = case try_resell_goods(Args) of
		      {fail, Why}  -> {fail, Why};
		      {error, Why} -> {error, Why};
		      {ok, TargetSellR} -> resell_goods_ok(Args, TargetSellR)
		  end,
	{reply, Ret, State};


%% 获取市场的上架物品信息
% handle_call_2({'get_goods_info_from_market', GoodsId}, _From, State) ->
% 	?TRACE("[MARKET]handle call, get_goods_info_from_market, goods uni id:~p~n", [GoodsId]),
% 	case get_goods_info_from_ets(GoodsId) of
% 		null ->
% 			{reply, null, State};
% 		Goods ->
%     		{reply, Goods, State}
% 	end;
	
	
% handle_call_2({'update_goods_info_to_market', Goods}, _From, State) ->
%     ?TRACE("[MARKET]handle call, update_goods_info_to_market, goods:~p~n", [Goods]),
% 	update_goods_info_to_ets(Goods),
%   {reply, ok, State};


%% 获取市场的挂售记录
% handle_call_2({'get_sell_record_from_market', SellRecordId}, _From, State) ->	
% 	case get_sell_record_from_ets(SellRecordId) of
% 		null ->
% 			{reply, null, State};
% 		SellR ->
% 			?ASSERT(is_record(SellR, mk_selling)),
% 			% 断言验证数据是否正确
% 			?ASSERT(SellR#mk_selling.price > 0), 
% 			case SellR#mk_selling.type =:= ?GOODS_T_VIRTUAL of
% 				true ->
% 					?ASSERT(SellR#mk_selling.goods_id =:= 0),
% 					?ASSERT(SellR#mk_selling.goods_no =:= 0),
% 					?ASSERT(SellR#mk_selling.money_to_sell > 0),
% 					?ASSERT(SellR#mk_selling.money_to_sell_type =/= ?MNY_T_INVALID),
% 					?ASSERT(SellR#mk_selling.money_to_sell_type =/= SellR#mk_selling.price_type);
% 				false ->		
% 					?ASSERT(SellR#mk_selling.goods_id =/= 0),
% 					?ASSERT(SellR#mk_selling.goods_no =/= 0),
% 					?ASSERT(SellR#mk_selling.money_to_sell =:= 0),
% 					?ASSERT(SellR#mk_selling.money_to_sell_type =:= ?MNY_T_INVALID)
% 			end,
% 			{reply, SellR, State}
% 	end;
    		
	
handle_call_2(_Request, _From, State) ->
    {reply, State, State}.
    
 
handle_cast(Request, State) ->
    try
        handle_cast_2(Request, State)
    catch
        Err:Reason ->
            ?ERROR_MSG("ERR:~p,Reason:~p, ~w",[Err, Reason, erlang:get_stacktrace()]),
            {noreply, State}
    end.
   
    

% handle_cast_2({'search_selling_goods', PS, Args}, State) ->
%     ?TRY_CATCH(try_search_selling_goods(PS, Args), Err_Reason),
%     {noreply, State};


% handle_cast_2({'query_my_sell_list', PS}, State) ->
%     PlayerId = player:id(PS),
%     Ms = ets:fun2ms(fun(T) when PlayerId =:= T#mk_selling.seller_id -> T end),
%     MySellList = ets:select(?ETS_MARKET_SELLING, Ms),
%     {ok, BinData} = pt_26:write(?PT_MK_QUERY_MY_SELL_LIST, MySellList),
%     lib_send:send_to_sock(PS, BinData),
%     {noreply, State};


handle_cast_2({'cancel_sell', PS, SellRecordId}, State) ->
	case get_sell_record_from_ets(SellRecordId) of
		null -> %% 刚好被其他玩家买了
			% ?ASSERT(false),
			% ?ERROR_MSG("mod_market:get_sell_record_from_ets error!~p~n", [SellRecordId]),
			lib_send:send_prompt_msg(PS, ?PM_MK_BUY_FAIL_GOODS_NOT_SELLING);
        TargetSellR ->
        	?ASSERT(TargetSellR#mk_selling.id =:= SellRecordId),
            case TargetSellR#mk_selling.seller_id =/= player:id(PS) of
                true -> % 非法：所要取消的挂售物品不是自己的物品
                    ?ASSERT(false),
                    lib_send:send_prompt_msg(PS, ?PM_PARA_ERROR);
                false ->
                    case cancel_sell_ok(PS, TargetSellR) of
                        {fail, Reason} ->
                            lib_send:send_prompt_msg(PS, Reason);
                        {ok, _} ->
                            lib_market:notify_my_sell_list_changed(player:id(PS)),
                            {ok, BinData} = pt_26:write(?PT_MK_CANCEL_SELL, [?RES_OK, SellRecordId]),
                            lib_send:send_to_sock(PS, BinData)
                    end
            end
    end,
    {noreply, State};


handle_cast_2({'get_back_expired_goods', PS, SellRecordId}, State) ->
	case get_sell_record_from_ets(SellRecordId) of
		null -> %% 被买了
			% ?ERROR_MSG("mod_market:get_sell_record_from_ets error!~p~n", [SellRecordId]),
			lib_send:send_prompt_msg(PS, ?PM_MK_BUY_FAIL_GOODS_NOT_SELLING);
        TargetSellR ->
        	?ASSERT(TargetSellR#mk_selling.id =:= SellRecordId),
        	TimeNow = svr_clock:get_unixtime(),
            case TimeNow < TargetSellR#mk_selling.end_time of
            	true ->  % 非法：物品挂售时间还未过期
            		lib_send:send_prompt_msg(PS, ?PM_MK_FAIL_TARGET_GOODS_UNEXPIRED);
            	false ->
            		case TargetSellR#mk_selling.seller_id =/= player:id(PS) of
            			true -> % 非法：所要取回的物品不是自己的物品
            				?ASSERT(false),
            				lib_send:send_prompt_msg(PS, ?PM_PARA_ERROR);
            			false ->
                            case get_back_expired_goods_ok(PS, TargetSellR) of
                            	{fail, Reason} ->
                            		lib_send:send_prompt_msg(PS, Reason);
                            	{ok, _} ->
									{ok, BinData} = pt_26:write(?PT_MK_GET_BACK_EXPIRED_GOODS, [?RES_OK, SellRecordId]),
									lib_send:send_to_sock(PS, BinData)
							end
            		end
            end
    end,
    {noreply, State};


%% 添加物品信息到市场
handle_cast_2({'add_goods_info_to_market', Goods}, State) ->
	% 改位置标记为市场位置，并重置player_id和slot为0
	NewGoods = Goods#goods{location = ?LOC_MARKET, player_id = 0, slot = 0},  
	ets:insert(?ETS_MARKET_GOODS_ONLINE, NewGoods),
    {noreply, State};
    
    
%% 从市场删除物品信息
handle_cast_2({'del_goods_info_from_market', GoodsId}, State) ->
	del_goods_info_from_ets(GoodsId),
    {noreply, State};
    

%% 添加挂售记录到市场
handle_cast_2({'add_sell_record_to_market', SellRecord}, State) ->
	ets:insert(?ETS_MARKET_SELLING, SellRecord),
    {noreply, State};
    
%% 更新挂售记录到市场
% handle_cast_2({'update_sell_record_to_market', NewSellRecord}, State) ->
% 	?TRACE("[MARKET]handle cast, update_sell_record_to_market, sell record id:~p~n", [NewSellRecord#mk_selling.id]),
% 	?ASSERT(ets:lookup(?ETS_MARKET_SELLING, NewSellRecord#mk_selling.id) /= []),
% 	update_sell_record_to_ets(NewSellRecord),
%   {noreply, State}; 
    
%% 从市场删除挂售记录
% handle_cast_2({'del_sell_record_from_market', SellRecordId}, State) ->
% 	?TRACE("[MARKET]handle cast, del_sell_record_from_market, sell record id:~p~n", [SellRecordId]),
% 	del_sell_record_from_ets(SellRecordId),
%     {noreply, State};       



handle_cast_2(_Msg, State) ->
    {noreply, State}.
    

handle_info(Request, State) ->
    try
        handle_info_2(Request, State)
    catch
        Err:Reason->
            ?ERROR_MSG("ERR:~p,Reason:~p,~w",[Err, Reason, erlang:get_stacktrace()]),
            {noreply, State}
    end.
    
%% 定时清理过期时间超过上限（挂售时间已过期太久）的上架物品
handle_info_2({'clear_expired_goods', CurTick}, State) ->
    ?TRY_CATCH(try_clear_expired_goods(), ErrReason),
   	% 投递下一个定时清理
   	ExtraRandIntv = util:rand(0, 60 * 1000), % 时间随机一下
   	erlang:send_after(?CLEAR_EXPIRED_GOODS_INTV + ExtraRandIntv, self(), {'clear_expired_goods', CurTick + 1}),
    {noreply, State};


handle_info_2(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

% %%-------------------------------------------------------------------------------------------------

%% 尝试挂售物品
try_sell_goods(Args) ->
    case catch try_sell_goods(lv_need, Args) of
        {'EXIT', _Reason} ->
            ?DEBUG_MSG("_Reason =~p",[_Reason]),
            ?TRACE("try sell goods(), exit for reason: ~p~n", [_Reason]),
            ?ASSERT(false),
            {fail, ?PM_MK_FAIL_SERVER_BUSY};
        Other ->
            Other
    end.


%% 检查等级是否符合
try_sell_goods(lv_need, Args) ->
    ?TRACE("try_sell_goods(): goods_exist~n"),
    [PS, _GoodsId, _Price, _PriceType, _SellTime, _StackNum] = Args,
    case player:get_lv(PS) >= ?MARKET_LV of
        false ->
            {fail, ?PM_LV_LIMIT};
        true ->
            try_sell_goods(goods_exist, Args)
    end;
    
%% 检查物品是否存在
try_sell_goods(goods_exist, Args) ->
	?TRACE("try_sell_goods(): goods_exist~n"),
	[PS, GoodsId, _Price, _PriceType, _SellTime, StackNum] = Args,
    case mod_inv:find_goods_by_id_from_bag(player:id(PS), GoodsId) of
    	null ->
    		{error, client_msg_illegal};
    	Goods ->
    		% 保险起见，判断物品数量是否大于0
    		case lib_goods:get_count(Goods) >= StackNum of
    			false ->
    				?ASSERT(false, Goods),
    				{error, unknown_err};
    			true ->
    				try_sell_goods(check_price_range, [Goods | Args])
    		end
    end;
    
%% 检测价格范围
try_sell_goods(check_price_range, Args) ->
    ?TRACE("try_sell_goods(): check_price_range~n"),
    [Goods, _PS, _GoodsId, Price, _PriceType, _SellTime, _StackNum] = Args,

    case data_stall_config:get(Goods#goods.no) of
        null ->
            {fail, ?PM_IS_NOT_FOR_MARKET_SELL};
        StallConfig ->
            % 如果价格合理或者是自定义价格道具
            case (( Price =< StallConfig#data_stall_config.price * 4 andalso Price >= StallConfig#data_stall_config.price * 0.2) orelse StallConfig#data_stall_config.price =:= 0) of
                true -> try_sell_goods(check_gem, Args);
                _ -> {fail, ?PM_IS_NOT_RIGHT_PRICE_RANGE}
            end
    end;


%% 检测是否有镶嵌宝石或者强化
try_sell_goods(check_gem, Args) ->
    ?TRACE("try_sell_goods(): check_price_range~n"),
    [Goods, _PS, _GoodsId, _Price, _PriceType, _SellTime, _StackNum] = Args,

    case lib_goods:is_equip(Goods) of
        true -> 

            case  lib_goods:get_stren_lv(Goods) of
                0 -> 
                    case lib_goods:get_gem_id_list(Goods) of
                        [] -> try_sell_goods(check_sell_time, Args);
                        _Other ->  ?DEBUG_MSG("_Other=~p",[_Other]),

                        {fail, ?PM_YOUBAOSHIWUFAJIAOYI}
                    end;
                _ ->
                    {fail, ?PM_QIANGHUAHOUWUFAJIAOYI}
            end;


        false ->
            try_sell_goods(check_sell_time, Args)
    end;

% 检测时间合法性
try_sell_goods(check_sell_time, Args) ->
    ?TRACE("try_sell_goods(): check_sell_time~n"),
    [Goods, _PS, _GoodsId, Price, _PriceType, _SellTime, _StackNum] = Args,

    case data_stall_config:get(Goods#goods.no) of
        null ->
            {fail, ?PM_IS_NOT_FOR_MARKET_SELL};
        StallConfig ->
            TimeNow = util:unixtime(),
            LastSellTime = lib_goods:get_last_sell_time(Goods),
            Interval = TimeNow - LastSellTime,

            % 判断是否可以出售了
            case Interval > ?VALUABLES_SELL_INTERVAL of
                true -> try_sell_goods(bind_already, Args);
                _ -> {fail, ?PM_SELL_TIME_CD}
            end
    end;



%% 判断物品是否已经绑定了
try_sell_goods(bind_already, Args) ->
	?TRACE("try_sell_goods(): bind_already~n"),
	[Goods, _PS, _GoodsId, _Price, _PriceType, _SellTime, _StackNum] = Args,
    case lib_goods:get_bind_state(Goods) of
        ?BIND_ALREADY ->
            {fail, ?PM_MK_SELL_FAIL_BIND_ALREADY};
        _Any ->
            try_sell_goods(enough_custody_fee, Args)
    end;

 
%% 挂售价格类型为游戏币时，判断卖家是否够 托管费
try_sell_goods(enough_custody_fee, Args) ->
	?TRACE("try_sell_goods(): enough_custody_fee~n"),
	[_Goods, PS, _GoodsId, Price, PriceType, SellTime, _StackNum] = Args,
	CustodyFee = lib_market:calc_custody_fee(Price, PriceType, SellTime),
	case player:check_need_price(PS, PriceType ,CustodyFee) of
        ok ->
            try_sell_goods(over_max, Args);
		_Any ->
			{fail, _Any}		
	end;
		   
    
% 检测是否超过了最大可挂售数
try_sell_goods(over_max, Args) ->
	?TRACE("try_sell_goods(): over_max~n"),
	[_Goods, PS, _GoodsId, _Price, _PriceType, _SellTime, _StackNum] = Args,
    case catch lib_market:get_my_sell_count(PS) of
        {'EXIT', _Reason} ->
            {fail, ?PM_MK_FAIL_SERVER_BUSY};
        Count ->
        	?TRACE("try_sell_goods: cur sell count: ~p", [Count]),
            case ?MK_MAX_SELL_GOODS =< Count of
                true ->
                    {fail, ?PM_MK_SELL_FAIL_OVER_SELL_MAX};
                false ->
                	try_sell_goods(over_sell_time, Args)
            end
    end;

%% 是否超过最大可挂售时间
try_sell_goods(over_sell_time, Args) ->
    [_Goods, PS, _GoodsId, _Price, _PriceType, SellTime, _StackNum] = Args,
    MaxSellHour = 
        case lib_vip:welfare(max_selling_hour, PS) of
            null -> 0;
            Hour -> Hour
        end,
    case SellTime > MaxSellHour of
        true -> {fail, ?PM_MK_SELL_FAIL_OVER_SELL_HOUR};
        false -> try_sell_goods(have_stone, Args)
    end;


try_sell_goods(have_stone, Args) ->
    [Goods, _PS, _GoodsId, _Price, _PriceType, _SellTime, _StackNum] = Args,
    case lib_goods:get_gem_id_list(Goods) of
        [] -> {ok};
        _ -> {fail, ?PM_MK_STONE_LIMIT}
    end;

try_sell_goods(can_trade, Args) ->
    [Goods, _PS, _GoodsId, _Price, _PriceType, _SellTime, _StackNum] = Args,
    case lib_goods:is_can_trade(Goods) of
    	false -> {fail, ?PM_GOODS_CANT_TRADE};
    	true -> {ok}
    end;

try_sell_goods(_Other, _Args) ->
    ?ASSERT(false),
	{fail, ?PM_UNKNOWN_ERR}.




%% 将玩家物品挂售到市场
%% @return: {ok, NewSellRecordId, NewPS} | {fail, ?MK_SELL_FAIL_UNKNOWN}
sell_goods_ok(Args) ->
	?TRACE("sell_goods_ok()...~n"),
    try
		do_sell_goods(Args)
	catch
		Err:Reason ->
			[PS, GoodsId, _Price, _PriceType, _SellTime, _StackNum] = Args,
			% 记录错误日志
			?ERROR_MSG("[MARKET_ERR]do_sell_goods() error!! ~w, PlayerId:~p, GoodsId:~p", [{Err, Reason}, player:id(PS), GoodsId]),
			?ASSERT(false),
			{fail, ?PM_UNKNOWN_ERR}
	end.

%% 处理挂售物品 玩家进程
do_sell_goods(Args) ->
	[PS, GoodsId, Price, PriceType, SellTime, SellCnt] = Args,
	
	Goods = mod_inv:find_goods_by_id_from_bag(player:id(PS), GoodsId),
	
	SellerId  = player:id(PS),
	GoodsNo =  lib_goods:get_no(Goods),
	GoodsName = lib_goods:get_name(GoodsNo),
	GoodsType = lib_goods:get_type(Goods),
	GoodsSubType = lib_goods:get_subtype(Goods),
	
	Quality = lib_goods:get_quality(Goods),
	%% 这里获取物品配置表的原始等级数据，传入tpl数据获取原始等级
%% 	Level = lib_goods:get_lv(Goods),
	Level = lib_goods:get_lv(lib_goods:get_tpl_data(Goods#goods.no)),
	
	GoodsCnt = lib_goods:get_count(Goods),

	Race = lib_goods:get_race(Goods),
	Sex = lib_goods:get_sex(Goods),
    TimeNow = svr_clock:get_unixtime(),
    
    EndTime = TimeNow + SellTime * ?SELL_TIME_UNIT_TO_SEC, % 单位转换成秒
    
    % 扣手续费
    NewPS = lib_market:handle_cost_custody_fee(PS, Price, PriceType, SellTime),

    % 更新goods表
    case GoodsCnt > SellCnt of
        false ->
            ?ASSERT(GoodsCnt =:= SellCnt, {GoodsCnt, SellCnt}),
            case GoodsCnt =:= SellCnt of
                true -> skip;
                false -> ?ERROR_MSG("mod_market:PlayerId:~p,{GoodsCnt, SellCnt}~w~n", [player:id(PS), {GoodsCnt, SellCnt}])
            end,
            
            GoodsId1 = GoodsId,
            %% 挂售后物品所有者id设置为 0 物品记录还在，因为拍卖行系统要用
            db:update(?DB_SYS, goods, ["player_id", "location"], [0, ?LOC_MARKET], "id", GoodsId),

            % 从玩家背包删除物品 (拍卖掉的物品可能包含宝石，下面的函数会把宝石在物品栏删除宝石id)
            mod_inv:remove_goods_from_bag(player:id(PS), Goods),
            % 从本地节点的ets缓存删掉所挂售的物品
            mod_inv:del_goods_from_ets_by_goods_id(GoodsId),
            lib_inv:notify_cli_goods_destroyed(player:id(PS), lib_goods:get_id(Goods), lib_goods:get_location(Goods)),

            add_goods_info_to_market(Goods);
        true ->
        	%% 数据库插入一条物品记录到goods表
            GoodsSell = lib_goods:set_count(Goods, SellCnt),
            GoodsSell1 = lib_goods:set_owner_id(GoodsSell, 0),
            GoodsSell2 = lib_goods:set_location(GoodsSell1, ?LOC_MARKET),
            GoodsSellId = lib_goods:db_insert_new_goods(GoodsSell2),
            GoodsSell3 = lib_goods:set_id(GoodsSell2, GoodsSellId),

            add_goods_info_to_market(GoodsSell3),

            GoodsId1 = GoodsSellId,

            Goods_Left = lib_goods:set_count(Goods, GoodsCnt - SellCnt),
            mod_inv:mark_dirty_flag(player:id(PS), Goods_Left),
            lib_inv:notify_cli_goods_info_change(player:id(PS), Goods_Left)
    end,

	% 根据物品构建新挂售记录
	NewSellRecord  = #mk_selling{
							seller_id = SellerId,
							goods_id = GoodsId1,
							goods_no = GoodsNo,
							goods_name = GoodsName,
							type = GoodsType,
							sub_type = GoodsSubType,
							
							quality = Quality,
							level = Level,
							race = Race,
							sex = Sex,
							stack_num = SellCnt,
							price = Price,
							price_type = PriceType,
							start_time = TimeNow,
							end_time = EndTime,
							status = ?MK_SELL_R_STATUS_SELLING
						},
						
    % 插入新记录到market_selling表
    NewRecordId = lib_market:insert_record_get_id(NewSellRecord),

	% 把新挂售记录添加到ets
	add_sell_record_to_market(NewSellRecord#mk_selling{id = NewRecordId}),
	
	% 记录log
	lib_log:statis_market_sell(NewPS, GoodsNo, GoodsId, SellCnt, ?MNY_T_BIND_GAMEMONEY, lib_market:calc_custody_fee(Price, PriceType, SellTime), Price, PriceType),
				
	{ok, NewRecordId, NewPS}.
	
    
	
try_sell_money(Args) ->
	[PS, MoneyToSell, MoneyToSellType, Price, SellTime] = Args,
	case MoneyToSellType of
		?MNY_T_GAMEMONEY -> % 挂售的是银子
            CustodyFee = lib_market:calc_custody_fee(Price, ?MNY_T_BIND_GAMEMONEY, SellTime), 
			case player:has_enough_gamemoney(PS, MoneyToSell*10000) of
				false ->  % 非绑定游戏币不够
					{fail, ?PM_GAMEMONEY_LIMIT};
				true ->
					% 判断手续费是否够？
					case player:has_enough_bind_gamemoney(PS, CustodyFee + MoneyToSell*10000) of
						false ->
							{fail, ?PM_MK_SELL_FAIL_MONEY_NOT_ENOUGH};
						true ->
                            case catch lib_market:get_my_sell_count(PS) of
                                {'EXIT', _Reason} ->
                                    {fail, ?PM_MK_FAIL_SERVER_BUSY};
                                Count ->
                                    ?TRACE("try_sell_goods: cur sell count: ~p", [Count]),
                                    case ?MK_MAX_SELL_GOODS =< Count of
                                        true ->
                                            {fail, ?PM_MK_SELL_FAIL_OVER_SELL_MAX};
                                        false ->
                                            {ok}
                                    end
                            end
					end
			end;
		_Any -> 
			?ASSERT(false),
			{fail, ?PM_PARA_ERROR}
	end.
	
sell_money_ok(Args) ->
	[PS, MoneyToSell, MoneyToSellType, Price, SellTime] = Args,
	
	case MoneyToSellType of
		?MNY_T_GAMEMONEY ->	% 挂售的是银子
			PriceType =  ?MNY_T_YUANBAO;
		_Any ->	%% 目前只能挂售银子
			PriceType = ?MNY_T_INVALID,
			?ERROR_MSG("mod_market:sell_money_ok error!Type:~p~n", [_Any]),
			?ASSERT(false)
	end,
	
	SellerId  = player:id(PS),
	GoodsType = ?GOODS_T_VIRTUAL,
	GoodsSubType = 
        case MoneyToSell of
            ?MONEY_COUNT_1_WAN -> 1;
            ?MONEY_COUNT_5_WAN -> 2;
            ?MONEY_COUNT_20_WAN -> 3;
            ?MONEY_COUNT_100_WAN -> 4
        end,

	StackNum = MoneyToSell, % 对于挂售货币，stack_num也用来表示所挂售的货币的数量（26005, 26006协议返回信息给客户端时用到）
    TimeNow = svr_clock:get_unixtime(),
    EndTime = TimeNow + SellTime * ?SELL_TIME_UNIT_TO_SEC, % 单位转换成秒

	% 扣手续费
    TmpNewPS = lib_market:handle_cost_custody_fee(PS, Price, PriceType, SellTime),

    % 扣对应挂售的钱
    NewPS = 
    	case MoneyToSellType of
            ?MNY_T_GAMEMONEY ->  % 挂售的是银子
                player_syn:cost_money(TmpNewPS, ?MNY_T_GAMEMONEY, MoneyToSell*10000, [circulated, ?LOG_MARKET, "sell_money"]);
            _ ->  
                ?ASSERT(false),
                TmpNewPS
        end,
    
    % 根据物品构建新挂售记录
    NewSellRecord = #mk_selling{
                            id = 0,
                            seller_id = SellerId,
                            goods_id = 0,
                            goods_no = 0,
                    		quality = ?QUALITY_WHITE,
                            type = GoodsType,
                            sub_type = GoodsSubType,
                            
                            price = Price,
                            price_type = PriceType,
                            money_to_sell = MoneyToSell,
                            money_to_sell_type = MoneyToSellType,
                            stack_num = StackNum,
                            start_time = TimeNow,
                            end_time = EndTime,
                            status = ?MK_SELL_R_STATUS_SELLING
                        },

    % 插入新记录到market_selling表
    NewRecordId = lib_market:insert_record_get_id(NewSellRecord),

    % 把新挂售记录添加到ets
    add_sell_record_to_market(NewSellRecord#mk_selling{id = NewRecordId}),

    lib_log:statis_market_sell(NewPS, lib_log:get_log_monery_type(MoneyToSellType), 0, MoneyToSell*10000, ?MNY_T_BIND_GAMEMONEY, lib_market:calc_custody_fee(Price, PriceType, SellTime), Price, PriceType),
    {ok, NewRecordId, NewPS}.
	
	
% 尝试重新挂售过期的上架物品
try_resell_goods(Args) ->
	[PS, SellRecordId, Price, PriceType, SellTime] = Args,
	case get_sell_record_from_ets(SellRecordId) of
		null -> %% 刚好被其他玩家买了
			% ?ASSERT(false),
			% ?ERROR_MSG("mod_market:try_resell_goods can not find record:~p~n", [SellRecordId]),
			{fail, ?PM_MK_BUY_FAIL_GOODS_NOT_SELLING};
		TargetSellR ->
			case TargetSellR#mk_selling.seller_id =/= player:id(PS) of
				true ->  % 不是自己的物品
					?ASSERT(false),
					{error, client_msg_illegal};
				false ->
                    LeftHour = (TargetSellR#mk_selling.end_time - svr_clock:get_unixtime()) div ?SELL_TIME_UNIT_TO_SEC,
					case LeftHour > ?LEFT_HOUR_CAN_BE_RESELL of
						true ->  % 物品还不可以续期
							{fail, ?PM_MK_CANT_BE_RESELLED_NOW};
						false ->
							CustodyFee = lib_market:calc_custody_fee(Price, PriceType, SellTime),
							
							case player:has_enough_money(PS, ?MNY_T_BIND_GAMEMONEY, CustodyFee) of
								false ->  % 托管费不足（绑银）
									{fail, ?PM_BIND_GAMEMONEY_LIMIT};
								true ->
									case TargetSellR#mk_selling.type =:= ?GOODS_T_VIRTUAL of
										true ->
											?ASSERT(TargetSellR#mk_selling.goods_id =:= 0),
											?ASSERT(TargetSellR#mk_selling.goods_no =:= 0),
											?ASSERT(TargetSellR#mk_selling.money_to_sell > 0),
											?ASSERT(TargetSellR#mk_selling.money_to_sell_type =/= TargetSellR#mk_selling.price_type),
											case TargetSellR#mk_selling.money_to_sell_type =:= PriceType of
												true ->  % 对于重新挂售货币，价格类型非法
													?ASSERT(false),
													{error, client_msg_illegal};
												false ->
													{ok, TargetSellR}
											end;
										false ->
											{ok, TargetSellR}
									end
							end
					end
			end
	end.
	
% 重新挂售过期的上架物品 玩家进程
resell_goods_ok(Args, TargetSellR) ->
	[PS, SellRecordId, Price, PriceType, SellTime] = Args,
	?ASSERT(is_record(TargetSellR, mk_selling)),
	?ASSERT(TargetSellR#mk_selling.id =:= SellRecordId),
	?ASSERT(TargetSellR#mk_selling.price > 0),
	?ASSERT(TargetSellR#mk_selling.price_type >= ?MNY_T_MIN andalso TargetSellR#mk_selling.price_type =< ?MNY_T_MAX),
			
	% 现在是统一都挂售24小时
	TimeNow = svr_clock:get_unixtime(),
	EndTime = TimeNow + SellTime * ?SELL_TIME_UNIT_TO_SEC,  % 单位转换成秒
	
	% 更新db的market_selling表
    db:update(?DB_SYS, market_selling, ["price", "price_type", "start_time", "end_time", "status"], 
    	[Price, PriceType, TimeNow, EndTime, ?MK_SELL_R_STATUS_SELLING], "id", SellRecordId),

    % 扣手续费
    NewPS = lib_market:handle_cost_custody_fee(PS, Price, PriceType, SellTime),
	NewSellRecord = TargetSellR#mk_selling{
							price = Price,
							price_type = PriceType,
							start_time = TimeNow,
							end_time = EndTime,
							status = ?MK_SELL_R_STATUS_SELLING
						},
	% 重新挂售
	update_sell_record_to_ets(NewSellRecord),
    {GoodsType, GoodsNum} = 
        case NewSellRecord#mk_selling.type =:= ?GOODS_T_VIRTUAL of
            true -> {?MNY_T_GAMEMONEY, NewSellRecord#mk_selling.stack_num * 10000};
            false -> {NewSellRecord#mk_selling.type, NewSellRecord#mk_selling.stack_num}
        end,

	lib_log:statis_market_renew(PS, GoodsType, NewSellRecord#mk_selling.goods_id, GoodsNum, ?MNY_T_BIND_GAMEMONEY, lib_market:calc_custody_fee(Price, PriceType, SellTime), Price, PriceType),
	{ok, NewPS}.
		

%% 尝试从市场购买物品(包括：银子)
try_buy_goods(Args) ->
    case catch try_buy_goods(goods_exist, Args) of
        {'EXIT', _Reason} ->
            {fail, ?PM_MK_FAIL_SERVER_BUSY};
        Other ->
            Other
    end.        


%% 检查对应的挂售记录是否存在
try_buy_goods(goods_exist, Args) ->
    [_PS, SellRecordId, StackNum] = Args,
    case get_sell_record_from_ets(SellRecordId) of
        null -> % 物品已下架或者被其他玩家抢先买走了
            {fail, ?PM_MK_BUY_FAIL_GOODS_NOT_SELLING};
        BuyTarget ->
            case BuyTarget#mk_selling.stack_num < StackNum of
                true -> {fail, ?PM_GOODS_NOT_ENOUGH};
                false ->
                    case BuyTarget#mk_selling.type =:= ?GOODS_T_VIRTUAL andalso BuyTarget#mk_selling.stack_num =/= StackNum of
                        true -> 
                            {fail, ?PM_PARA_ERROR};
                        false ->
                            case BuyTarget#mk_selling.goods_id =:= ?INVALID_ID of
                                true ->
                                    try_buy_goods(is_expired, [BuyTarget | Args]);
                                false ->
                                	case get_goods_info_from_ets(BuyTarget#mk_selling.goods_id) of
                                		null ->
                                			{fail, ?PM_MK_BUY_FAIL_GOODS_NOT_SELLING};
                                		_Goods ->
                                    		try_buy_goods(is_expired, [BuyTarget | Args])
                                    end
                            end
                    end
            end
    end;
    
%% 检查物品是否已过期下架了
try_buy_goods(is_expired, Args) ->
    [BuyTarget, _PS, _SellRecordId, _StackNum] = Args,
    TimeNow = svr_clock:get_unixtime(),
    case BuyTarget#mk_selling.end_time < TimeNow of
    	true ->
    		{fail, ?PM_MK_BUY_FAIL_GOODS_EXPIRED};
    	false ->
    		try_buy_goods(is_my_own_goods, Args)
    end;
    
%% 检查是否购买自己挂售的物品
try_buy_goods(is_my_own_goods, Args) ->
	[BuyTarget, PS, _SellRecordId, _StackNum] = Args,
    SellerId = BuyTarget#mk_selling.seller_id,
    case SellerId =:= player:id(PS) of
        true->
            {fail, ?PM_MK_BUY_FAIL_MY_OWN_GOODS};
        false->
            try_buy_goods(enough_money, Args)
    end;
    
%% 检查钱是否足够
try_buy_goods(enough_money, Args) ->
	[BuyTarget, PS, _SellRecordId, BuyCount] = Args,
    Price = BuyTarget#mk_selling.price,
    TotalPrice = 
        case BuyTarget#mk_selling.type =:= ?GOODS_T_VIRTUAL of
            false -> Price * BuyCount;
            true -> Price
        end,
    PriceType = BuyTarget#mk_selling.price_type,

    case player:check_need_price(PS,PriceType,TotalPrice) of
        ok ->
            {ok, BuyTarget};
		_Any ->
            {fail, _Any}
	end;

    
try_buy_goods(_Other, _Args) ->
    ?DEBUG_MSG("_Other=~p,_Args=~p",[_Other, _Args]),
	?ASSERT(false),
    {fail, ?PM_UNKNOWN_ERR}. 
  

%% 购买市场上架物品的处理
%% @para: BuyTarget => 目标挂售记录
%% @return: {ok, SellerId, NewPS} | {fail, Reason}
buy_goods_ok(Args, BuyTarget) ->
	[PS, SellRecordId, BuyCount] = Args,
    ?ASSERT(is_record(BuyTarget, mk_selling)),
    ?ASSERT(BuyTarget#mk_selling.id =:= SellRecordId),
    
    try do_buy_goods_or_money(PS, BuyTarget, SellRecordId, BuyCount) of
    	{ok, SellerId, Goods, NewPS} ->
            HaveCount = BuyTarget#mk_selling.stack_num,
            case BuyTarget#mk_selling.type =/= ?GOODS_T_VIRTUAL of
                true ->
                    case HaveCount =:= lib_goods:get_count(Goods) of
                        true -> skip;
                        false -> ?ERROR_MSG("mod_market:buy_goods_ok data error! StackNum:~p, GoodsCnt:~p, goods_no:~w", 
                            [HaveCount, lib_goods:get_count(Goods), {BuyTarget#mk_selling.goods_no, lib_goods:get_no(Goods)}])
                    end;
                false -> skip
            end,
            
            case HaveCount > BuyCount of
                false ->
    		        del_sell_record_from_ets(BuyTarget#mk_selling.id),
                    del_goods_info_from_ets(BuyTarget#mk_selling.goods_id);
                true ->
                    ?ASSERT(BuyTarget#mk_selling.type =/= ?GOODS_T_VIRTUAL, BuyTarget#mk_selling.type),
                    update_sell_record_to_ets(BuyTarget#mk_selling{stack_num = HaveCount - BuyCount}),
                    update_goods_info_to_ets(lib_goods:set_count(Goods, HaveCount - BuyCount))
            end,
            {ok, SellerId, NewPS};
        {fail, Reason} ->
        	{fail, Reason}
	catch
		Err:Reason ->
			case Reason of
				{fail, ?PM_MK_FAIL_SERVER_BUSY} -> % 服务器繁忙
					{fail, ?PM_MK_FAIL_SERVER_BUSY};
				{fail, ?PM_MK_BUY_FAIL_GOODS_NOT_SELLING} -> % 目标物品不在挂售中
					{fail, ?PM_MK_BUY_FAIL_GOODS_NOT_SELLING};
                {error, db_error} ->
                    ?ERROR_MSG("[MARKET_ERR]do_buy_goods_or_money() error!! ~w,~n PlayerId:~p, BuyTarget:~w", [{Err, Reason}, player:id(PS), BuyTarget]),
                    ?ASSERT(false, {Err, Reason}),
                    {fail, ?PM_MK_FAIL_SERVER_BUSY};
				_ ->
					% 记录错误日志
					?ERROR_MSG("[MARKET_ERR]do_buy_goods_or_money() error!! ~w,~n PlayerId:~p, BuyTarget:~w", [{Err, Reason}, player:id(PS), BuyTarget]),
					?ASSERT(false, {Err, Reason}),
					{fail, ?PM_UNKNOWN_ERR}
			end
	end.


%% 执行交易，操作交易双方的数据  玩家进程call拍卖行进程
do_buy_goods_or_money(Buyer, BuyTarget, SellRecordId, BuyCount) ->
	GoodsType = BuyTarget#mk_selling.type,
	GoodsId = BuyTarget#mk_selling.goods_id,
	
	% 如果不是购买货币，则先尝试获取目标物品信息
	case GoodsType =/= ?GOODS_T_VIRTUAL of
		true ->
			case get_goods_info_from_ets(GoodsId) of
				null ->   % 购买失败：无法获取目标物品信息（服务端繁忙）
					Goods = null,
					?ASSERT(false),
					?ERROR_MSG("do_buy_goods_or_money get_goods_info_from_ets null! ~p ~n", [GoodsId]),
					% 直接throw，不需再继续做处理
					throw({fail, ?PM_MK_FAIL_SERVER_BUSY});
				TGoods ->
					?ASSERT(TGoods#goods.location =:= ?LOC_MARKET, TGoods#goods.location),
					Goods = TGoods
			end;
		false ->
			Goods = null
	end,
	
	BuyerId = player:id(Buyer),
  	SellerId = BuyTarget#mk_selling.seller_id,
    
  	Price = BuyTarget#mk_selling.price,  % 单价
  
  	PriceType =  BuyTarget#mk_selling.price_type,
  	
  	MoneyToSell = BuyTarget#mk_selling.money_to_sell,
  	MoneyToSellType = BuyTarget#mk_selling.money_to_sell_type,
  
  	[GoodsName, ExchangeType, TotalPrice, Charge] = 
		case GoodsType =:= ?GOODS_T_VIRTUAL of
		    true ->  % 表示是买钱
		        ?ASSERT(GoodsId =:= 0),
		        ?ASSERT(MoneyToSellType =/= PriceType),
	            case MoneyToSellType of
	                ?MNY_T_GAMEMONEY -> 
	                	?ASSERT(PriceType =:= ?MNY_T_YUANBAO),
	                	[io_lib:format("~w银子", [MoneyToSell*10000]), ?BUY_MONEY, Price, util:floor(Price*0.15)];
	                _MnyType ->
                        ?ERROR_MSG("mod_market:do_buy_goods_or_money error, _MnyType:~p~n", [_MnyType]),
	                    ?ASSERT(false),
                        [io_lib:format("~w货币", [MoneyToSell*10000]), ?BUY_MONEY, Price, util:floor(Price*0.15)]

	            end;
	        false -> % 表示是买物品
	          	?ASSERT(GoodsId =/= 0),
	          	?ASSERT(MoneyToSell =:= 0),
	          	?ASSERT(MoneyToSellType =:= ?MNY_T_INVALID),
	            [BuyTarget#mk_selling.goods_name, ?BUY_GOODS, Price * BuyCount, util:floor(Price * BuyCount*0.15)]
		end,
    
  	Title = <<"摆摊通知: 交易成功">>,
  	case PriceType of
        ?MNY_T_COPPER ->
            GetGoodsNo1 = ?VGOODS_COPPER,
            Content = list_to_binary(io_lib:format(<<"成功出售~s~p个\n获得金币~p,扣除手续费~p（15%）">>, [GoodsName, BuyCount, TotalPrice - Charge, Charge]));
    	?MNY_T_GAMEMONEY ->
      		GetGoodsNo1 = ?VGOODS_GAMEMONEY,
      		Content = list_to_binary(io_lib:format(<<"成功出售~s~p个\n获得银币~p,扣除手续费~p（15%）">>, [GoodsName, BuyCount, TotalPrice - Charge, Charge]));
    	?MNY_T_YUANBAO ->
      		GetGoodsNo1 = ?VGOODS_BIND_YB,
      		Content = 
                case GoodsType =:= ?GOODS_T_VIRTUAL of
                    true ->
                        list_to_binary(io_lib:format(<<"成功出售~s\n获得水玉~p,扣除手续费~p（15%）">>, [GoodsName, TotalPrice - Charge, Charge]));
                    false ->                            
                        list_to_binary(io_lib:format(<<"成功出售~s~p个\n获得水玉~p,扣除手续费~p（15%）">>, [GoodsName, BuyCount, TotalPrice - Charge, Charge]))
                end;
    	_ -> %% 目前只能用银子或者金子在市集买东西
      		GetGoodsNo1 = ?INVALID_NO,
      		Content = <<>>,
      		?ASSERT(false)
  	end,
  
  	% 给卖家钱（通过发系统邮件的方式）
  	case lib_mail:send_sys_mail(SellerId, Title, Content, [{GetGoodsNo1, TotalPrice - Charge}], [?LOG_CRI, ?LOG_CRI]) of
    	{false, _Reason} ->  % 发送系统邮件失败
      		?ASSERT(false, {_Reason, SellerId}),
      		throw({error, send_sys_mail_failed});
    	true ->
      		ok
  	end,
  
  	lib_log:statis_consume_currency_tax(SellerId, PriceType, Charge),
        
  	% 扣买家对应的钱
  	NewPS = player_syn:cost_money(Buyer, PriceType, TotalPrice, [circulated, ?LOG_MARKET, "buy_goods"]),  % 扣铜币

  	% 根据买的是钱还是物品，处理数据库，并对应给予买家东西（通过邮件）
  	PriceVGoodsNo = 
		case PriceType of
			?MNY_T_GAMEMONEY -> ?VGOODS_GAMEMONEY;
			?MNY_T_YUANBAO -> ?VGOODS_YB;
            ?MNY_T_COPPER -> ?VGOODS_COPPER
		end,

  	case ExchangeType of
    	?BUY_GOODS ->
      		% 处理db
      		handle_db_for_buy_goods(Buyer, BuyTarget, SellRecordId, BuyCount),

            % 判断该道具是否是自定义价格道具如果是自定义价格道具则绑定
            GoodsNo = Goods#goods.no,
            StallConfig = data_stall_config:get(GoodsNo),

            TimeNow = util:unixtime(),
            % Interval = TimeNow - LastTansformTime,

            % 设置最后一次出售日期
            Goods1 = case StallConfig#data_stall_config.price of
                0 ->
                    lib_goods:set_last_sell_time(Goods,TimeNow);
                _ ->
                    Goods
            end,

      		% 给买家物品（更新物品的player_id为买家的id），并扣对应的钱
      		NewGoods = lib_goods:set_owner_id(Goods1, BuyerId),
            NewGoods1 = lib_goods:set_count(NewGoods, BuyCount),

      		Content1 = io_lib:format(<<"成功购得~s~p个\n花费金币~p">>, [GoodsName, BuyCount, TotalPrice]),
      		case lib_mail:send_sys_mail(tranfer_goods, player:id(Buyer), Title, Content1, [NewGoods1], [?LOG_CRI, ?LOG_CRI]) of
        		{false, _Reason1} ->  % 发送系统邮件失败
          			?ASSERT(false, {_Reason1, SellerId}),
          			throw({error, send_sys_mail_failed});
        		true ->
            		lib_log:statis_market_buy(NewPS, PriceVGoodsNo, TotalPrice, lib_goods:get_no(NewGoods1), lib_goods:get_id(NewGoods1), BuyCount, PriceType, Charge, SellerId),
            		{ok, SellerId, Goods1, NewPS}
      		end;
    	?BUY_MONEY ->
     	 	% 处理db
      		handle_db_for_buy_money(Buyer, BuyTarget, SellRecordId),

      		Content1 = io_lib:format(<<"成功购得~s\n花费水玉~p">>, [GoodsName, TotalPrice]),
      		case lib_mail:send_sys_mail(player:id(Buyer), Title, Content1, [{?VGOODS_GAMEMONEY, BuyCount*10000}], [?LOG_CRI, ?LOG_CRI]) of
        		{false, _Reason2} ->  % 发送系统邮件失败
          			?ASSERT(false, {_Reason2, SellerId}),
          			throw({error, send_sys_mail_failed});
        		true ->
	        		PriceVGoodsNo = 
		        		case PriceType of
		        			?MNY_T_GAMEMONEY -> ?VGOODS_GAMEMONEY;
		        			?MNY_T_YUANBAO -> ?VGOODS_YB;
                            ?MNY_T_COPPER -> ?VGOODS_COPPER
		        		end,
	            	lib_log:statis_market_buy(NewPS, PriceVGoodsNo, TotalPrice, ?VGOODS_GAMEMONEY, 0, BuyCount*10000, PriceType, Charge, SellerId),
	            	{ok, SellerId, Goods, NewPS}
    		end
  	end.


%% 简单起见，这里直接删掉数据库记录和ets  玩家进程call拍卖行进程
handle_db_for_buy_goods(Buyer, BuyTarget, SellRecordId, BuyCount) ->
    StackNum = BuyTarget#mk_selling.stack_num,
    BuyerId = player:id(Buyer),
    GoodsId = BuyTarget#mk_selling.goods_id,
    Goods = get_goods_info_from_ets(GoodsId),
    case StackNum > BuyCount of
        false ->
        	% 删除挂售记录
            db_delete_market_selling(SellRecordId),
           	% 删除物品
           	lib_goods:db_delete_goods(GoodsId),
            %% 如果有宝石，则宝石转移给买家,因为是先到邮件，所以还没到玩家物品栏
            case lib_goods:is_equip(Goods) of
                false -> skip;
                true ->
                    GemIdList = lib_goods:get_gem_id_list(Goods),
                    F = fun(GemId) -> 
                        case mod_inv:get_goods_from_ets(GemId) of
                            null ->
                                ?ASSERT(false, GemId),
                                ?ERROR_MSG("[mod_market] handle_db_for_buy_goods() get_goods_from_ets error!~p~n", [GemId]);
                            GemGoods ->
                                mod_inv:update_goods_to_ets(lib_goods:set_owner_id(GemGoods, BuyerId))
                        end,
                        db:update(BuyerId, goods, ["player_id"], [BuyerId], "id", GemId)
                    end,
                    [F(X) || X <- GemIdList]
            end;
        true ->
            % 更新goods表(在拍卖行那个物品)
            db:update(?DB_SYS, goods, ["count"], [StackNum - BuyCount], "id", GoodsId),
            
            db:update(?DB_SYS, market_selling, ["stack_num"], [StackNum - BuyCount], "id", SellRecordId)
    end.

    
%% 简单起见，这里直接删掉数据库记录和ets
handle_db_for_buy_money(_Buyer, _BuyTarget, SellRecordId) ->
   	% 删除挂售记录
    db_delete_market_selling(SellRecordId).
    


%% 取消挂售物品
%% @return: {ok, NewPS} | {fail, Reason}
cancel_sell_ok(PS, TargetSellR) ->
	case TargetSellR#mk_selling.type =/= ?GOODS_T_VIRTUAL of
		true ->  % 挂售的是物品，则给回物品
		 	return_goods_to_seller(PS, TargetSellR);
		false -> % 挂售的是货币，则给回货币
			return_money_to_seller(PS, TargetSellR)
	end.

	
%% 取回过期的上架物品
%% @return: {ok, NewPS} | {fail, Reason}
get_back_expired_goods_ok(PS, TargetSellR) ->
    try
    	case TargetSellR#mk_selling.type =/= ?GOODS_T_VIRTUAL of
			true ->  % 挂售的是物品，则给回物品
			 	return_goods_to_seller(PS, TargetSellR);
			false -> % 挂售的是货币，则给回货币
				return_money_to_seller(PS, TargetSellR)
		end	
	catch
		Err:Reason ->
			% 记录错误日志
			?ERROR_MSG("[mod_market]get back goods, return_goods_to_seller() error!! ~w,~n PlayerId:~p, SellRecord:~w", [{Err, Reason}, player:id(PS), TargetSellR]),
			?ASSERT(false),
			{fail, ?PM_UNKNOWN_ERR}
	end.
	
	
	
%% 返还物品给卖家 玩家进程
return_goods_to_seller(PS, TargetSellR) ->
	SellRecordId = TargetSellR#mk_selling.id,
	SellerId = player:id(PS),
	TargetGoodsId = TargetSellR#mk_selling.goods_id,
	TargetGoodsNo = TargetSellR#mk_selling.goods_no,
	StackNum = TargetSellR#mk_selling.stack_num,
	case get_goods_info_from_ets(TargetGoodsId) of
		null ->  % 失败：无法获取上架物品信息（服务端繁忙）
			{fail, ?PM_MK_FAIL_SERVER_BUSY};
		Goods ->
			?ASSERT(lib_goods:get_location(Goods) =:= ?LOC_MARKET),
            case StackNum =:= lib_goods:get_count(Goods) of
                true -> skip;
                false -> ?ERROR_MSG("mod_market:return_goods_to_seller data error! PlayerId:~p, GoodsNo:~p,StackNum:~p, GoodsCnt:~p", [player:id(PS), TargetGoodsNo, StackNum, lib_goods:get_count(Goods)])
            end,
            
			% 删除db的挂售记录
            db_delete_market_selling(SellRecordId),
			
			%则给回物品
			?ASSERT(TargetGoodsId =/= 0),
			?ASSERT(TargetSellR#mk_selling.money_to_sell =:= 0),
			?ASSERT(TargetSellR#mk_selling.money_to_sell_type =:= ?MNY_T_INVALID),
			
   			lib_goods:db_delete_goods(TargetGoodsId),
    		
    		% 从市场删除对应的挂售记录和物品信息
			del_sell_record_from_ets(SellRecordId),
			del_goods_info_from_ets(TargetGoodsId),

            lib_log:statis_market_cancel(PS, TargetSellR#mk_selling.goods_no, TargetGoodsId, StackNum, TargetSellR#mk_selling.price, TargetSellR#mk_selling.price_type),

			% 给玩家物品 通过邮件发送
			NewGoods = lib_goods:set_owner_id(Goods, SellerId),
            NewGoods1 = lib_goods:set_count(NewGoods, StackNum), %% 矫正数量，线上有玩家反馈撤回时物品少了，原因暂时未知
			Title = <<"摆摊通知: 撤回成功">>,
			Content = list_to_binary(io_lib:format(<<"你寄售的~s~p个已撤回">>, [lib_goods:get_name(TargetGoodsNo), lib_goods:get_count(NewGoods1)])),
			case lib_mail:send_sys_mail(tranfer_goods, SellerId, Title, Content, [NewGoods1], [?LOG_CRI, ?LOG_CRI]) of
				{false, _Reason} ->  % 发送系统邮件失败
					?ASSERT(false, {_Reason, SellerId}),
					?ERROR_MSG("mod_market:return_goods_to_seller send mail error!~n",[]),
					{fail, ?PM_MK_FAIL_SERVER_BUSY};
				true ->
					{ok, PS}
			end
	end.




%% 返还货币给卖家
return_money_to_seller(PS, TargetSellR) ->
	SellRecordId = TargetSellR#mk_selling.id,
	SellerId = TargetSellR#mk_selling.seller_id,
	StackNum = TargetSellR#mk_selling.stack_num,
	% 删除db的挂售记录
    db_delete_market_selling(SellRecordId),

	% 从市场删除对应的挂售记录
	del_sell_record_from_ets(SellRecordId),

	?ASSERT(TargetSellR#mk_selling.money_to_sell > 0),
	?ASSERT(TargetSellR#mk_selling.money_to_sell_type =/= TargetSellR#mk_selling.price_type),

    lib_log:statis_market_cancel(PS, ?VGOODS_GAMEMONEY, 0, StackNum*10000, TargetSellR#mk_selling.price, TargetSellR#mk_selling.price_type),

	% 给回玩家钱
	Title = <<"摆摊通知: 撤回成功">>,
	Content = list_to_binary(io_lib:format(<<"你寄售的~p两银子已撤回">>, [StackNum*10000])),
	case lib_mail:send_sys_mail(SellerId, Title, Content, [{?VGOODS_GAMEMONEY, StackNum*10000}], [?LOG_CRI, ?LOG_CRI]) of
		{false, _Reason} ->  % 发送系统邮件失败
			?ASSERT(false, {_Reason, SellerId}),
			?ERROR_MSG("mod_market:return_money_to_seller send mail error!~n",[]),
			{fail, ?PM_MK_FAIL_SERVER_BUSY};
		true ->
			{ok, PS}
	end.
	
	
	


%% TODO: 拼搜索sql字串时不用++， 考虑改用其他好一些的做法
% search_selling_goods_by_db(_PS, SearchArgs) ->
% 	?TRACE("search_selling_goods_by_db~n"),
%     [Type, SubType, Quality, Race, LevelMin, LevelMax, PriceMin, PriceMax, Sex, PageIdx, SortType, SearchName] = SearchArgs,
%     ?ASSERT(SearchName =/= []),
    
%     %注意：不要漏了最前面的空格，下同!
%     SearchCond = " WHERE true", % 搜索条件
	
%     Args = [],
    
%     {SearchCond1, Args1} = 
%     				case SubType =/= 0 of
%     					true ->
%     						?ASSERT(Type =/= 0, [Type, SubType]),
%     						{SearchCond ++ " and type=~p and sub_type=~p", Args ++ [Type, SubType]};
%     				    false ->
%                             case Type =/= 0 andalso Type =/= 100 of
%                                 true ->
%                                     {SearchCond ++ " and type=~p", Args ++ [Type]};
%                                 false ->    
%     				                {SearchCond, Args}
%                             end
%         			end,
%     {SearchCond2, Args2} = case Quality =/= ?QUALITY_INVALID of
%     					true ->
%     					    {SearchCond1 ++ " and quality=~p", Args1 ++ [Quality]};
%     				    false ->
%     				        {SearchCond1, Args1}
%         			end,
%     {SearchCond3, Args3} = case Race =/= 0 of
%     					true ->
%     					    {SearchCond2 ++ " and race=~p", Args2 ++ [Race]};
%     				    false ->
%     				        {SearchCond2, Args2}
%         			end,
%     {SearchCond4, Args4} = case Sex =/= 0 of
%     					true ->
%     					    {SearchCond3 ++ " and race=~p", Args3 ++ [Sex]};
%     				    false ->
%     				        {SearchCond3, Args3}
%         			end,
%     {SearchCond5, Args5} = case LevelMin =/= 0 orelse LevelMax =/= 0 of
%     					true ->
%                             {LevelMin1, LevelMax1} =
%                                 if
%                                     LevelMin =:= 0 andalso LevelMax =/= 0 -> {0, LevelMax};
%                                     LevelMin =/= 0 andalso LevelMax =:= 0 -> {LevelMin, ?MAX_U8};
%                                     true -> {LevelMin, LevelMax}
%                                 end,
%     					    {SearchCond4 ++ " and level between ~p and ~p", Args4 ++ [LevelMin1, LevelMax1]};
%     				    false ->
%     				        {SearchCond4, Args4}
%         			end,
%     {SearchCond6, Args6} = case PriceMin =/= 0 orelse PriceMax =/= 0 of
%     					true ->
%                             {PriceMin1, PriceMax1} =
%                                 if
%                                     PriceMin =:= 0 andalso PriceMax =/= 0 -> {0, PriceMax};
%                                     PriceMin =/= 0 andalso PriceMax =:= 0 -> {PriceMin, ?MAX_U32};
%                                     true -> {PriceMin, PriceMax}
%                                 end,
%     					    {SearchCond5 ++ " and price between ~p and ~p", Args5 ++ [PriceMin1, PriceMax1]};
%     				    false ->
%     				        {SearchCond5, Args5}
%         			end,
        	
%    	TimeNow = svr_clock:get_unixtime(),
    		
% 	{SearchCond7, Args7} = {SearchCond6 ++ " and goods_name LIKE '%~s%' and end_time>~p", Args6 ++ [SearchName, TimeNow]},
    
%     % 获取搜索匹配的记录的数目
%     SqlStr_GetCount = "SELECT count(id) FROM `market_selling`" ++ SearchCond7,
    
%     Sql_GetCount = io_lib:format(list_to_binary(SqlStr_GetCount), Args7),
    
%     TotalCount = case db:select_row(market_selling, Sql_GetCount) of
%    					[] ->
%    						?TRACE("get row []...~n"),
%    						?ASSERT(false), 0;
%    					[RetCount] ->
%    						?ASSERT(is_integer(RetCount)),
%    						RetCount;
%    					_ ->  % db操作出错
%    						?ASSERT(false), 0
%    				 end,
   				 
%    	case TotalCount =:= 0 of
%    		true ->
%    			?TRACE("search by db, total count is 0...~n"),
%    			{0, 0, []};
%    		false ->
%    			?TRACE("search by db, total count: ~p...~n", [TotalCount]),
%    			AdjustedPageIdx = adjust_page_index(TotalCount, PageIdx),
%    			Offset = AdjustedPageIdx * ?MK_GOODS_COUNT_PER_PAGE,
%    			% 依据品质从高到低排序
%             SortCondition = 
%             case SortType of
%                 0 -> "quality DESC";
%                 1 -> "level DESC";
%                 2 -> "quality DESC";
%                 3 -> "price ASC"
%             end,
%     		{SearchCond8, Args8} = {SearchCond7 ++ " ORDER BY " ++ SortCondition ++ " LIMIT ~p OFFSET ~p", Args7 ++ [?MK_GOODS_COUNT_PER_PAGE, Offset]},
    						
%     		SqlStr_DoSearch = ?SQL_QUERY_MK_SELLING2 ++  SearchCond8,
%     		Sql_DoSearch = io_lib:format(list_to_binary(SqlStr_DoSearch), Args8),
    		
%    			case db:select_all(market_selling, Sql_DoSearch) of
%    				[] ->
%    					?ASSERT(false),
%    					{0, 0, []};
%    				SqlRet when is_list(SqlRet) ->
%    					OnePageGoodsList = [lib_market:make_sell_record(X) || X <- SqlRet],
%    					{TotalCount, AdjustedPageIdx, OnePageGoodsList};
%    				_ ->  % db操作出错
%    					?ASSERT(false),
%    					{0, 0, []}
%    			end
%    	end.
			
	
    		
	
search_selling_goods_by_ets(_PS, SearchArgs) ->
	[Type, SubType, Quality, Race, LevelMin, LevelMax, PriceMin, PriceMax, Sex, PageIdx, SortType, SearchName] = SearchArgs,
	% ?ASSERT(SearchName =:= []),
    
	% 按搜索条件过滤挂售记录
	TRetGoodsList = filter_selling_goods([Type, SubType, Quality, Race, LevelMin, LevelMax, PriceMin, PriceMax, Sex]),
	
    F0 = fun(X) ->
        case string:str(binary_to_list(X#mk_selling.goods_name), SearchName) =/= 0 of
            true -> true;
            false -> false
        end
    end,

    RetGoodsList = 
        case SearchName =:= [] of
            true -> TRetGoodsList;
            false -> [X || X <- TRetGoodsList, F0(X)]
        end,

	TotalCount = length(RetGoodsList),
	
	% {GoodsList1, GoodsList2} = lists:partition(fun(Goods) -> Goods#ets_mk_selling.price_type =:= ?MONEY_T_COIN end, RetGoodsList),
	% 依据品质等级进行排序
	F1 = fun(A, B) -> 
        if 
			A#mk_selling.quality > B#mk_selling.quality ->
                true;
            A#mk_selling.quality =:= B#mk_selling.quality ->
                A#mk_selling.level > B#mk_selling.level;
            true ->
                false
		end
    end,

    F2 = fun(A, B) -> 
        if 
            A#mk_selling.level > B#mk_selling.level ->
                true;
            A#mk_selling.level =:= B#mk_selling.level ->
                A#mk_selling.quality > B#mk_selling.quality;
            true ->
                false
        end
    end,

    F3 = fun(A, B) -> 
        if 
            (A#mk_selling.end_time - A#mk_selling.start_time) > (B#mk_selling.end_time - B#mk_selling.start_time) ->
                true;
            (A#mk_selling.end_time - A#mk_selling.start_time) =:= (B#mk_selling.end_time - B#mk_selling.start_time) ->
                if
                    A#mk_selling.quality > B#mk_selling.quality ->
                        true;
                    A#mk_selling.quality =:= B#mk_selling.quality ->
                        A#mk_selling.level > B#mk_selling.level;
                    true ->
                        false
                end;
            true ->
                false
        end
    end,

    F4 = fun(A, B) -> 
        if 
            A#mk_selling.price < B#mk_selling.price ->
                true;
            A#mk_selling.price =:= B#mk_selling.price ->
                if
                    A#mk_selling.quality > B#mk_selling.quality ->
                        true;
                    A#mk_selling.quality =:= B#mk_selling.quality ->
                        A#mk_selling.level > B#mk_selling.level;
                    true ->
                        false
                end;
            true ->
                false
        end
    end,
	
	OrderedGoodsList = 
    case SortType of
        0 ->
            lists:sort(F1, RetGoodsList);
        1 ->
            lists:sort(F2, RetGoodsList);
        2 ->
            lists:sort(F3, RetGoodsList);
        3 ->
            lists:sort(F4, RetGoodsList);
        _Any ->
            ?ASSERT(false, SortType),
            []
    end,
	
	AdjustedPageIdx = adjust_page_index(TotalCount, PageIdx),
	OnePageGoodsList = extract_one_page(OrderedGoodsList, AdjustedPageIdx),
	{TotalCount, AdjustedPageIdx, OnePageGoodsList}.
 

 search_selling_goods_by_ets1(_PS, SearchArgs) ->
    [GoodsNo, PageIdx, SortType] = SearchArgs,
    % ?ASSERT(SearchName =:= []),
    
    % 按搜索条件过滤挂售记录
    TRetGoodsList = filter_selling_goods1([GoodsNo, PageIdx, SortType]),

    ?DEBUG_MSG("TRetGoodsList=~p",[TRetGoodsList]),
    
    TotalCount = length(TRetGoodsList),

    F1 = fun(A, B) -> 
        if 
            A#mk_selling.price < B#mk_selling.price ->
                true;
            A#mk_selling.price =:= B#mk_selling.price ->
                if
                    A#mk_selling.id > B#mk_selling.id ->
                        true;
                    true ->
                        false
                end;
            true ->
                false
        end
    end,

    F2 = fun(A, B) -> 
        if 
            A#mk_selling.price > B#mk_selling.price ->
                true;
            A#mk_selling.price =:= B#mk_selling.price ->
                if
                    A#mk_selling.id < B#mk_selling.id ->
                        true;
                    true ->
                        false
                end;
            true ->
                false
        end
    end,
    
    OrderedGoodsList = lists:sort(F1, TRetGoodsList),
    % case SortType of
    %     _ ->
            % lists:sort(F1, TRetGoodsList);
    %     0 ->
    %         lists:sort(F2, TRetGoodsList)
    % end,

    ?DEBUG_MSG("OrderedGoodsList=~p",[OrderedGoodsList]),
    
    AdjustedPageIdx = adjust_page_index(TotalCount, PageIdx),
    OnePageGoodsList = extract_one_page(OrderedGoodsList, AdjustedPageIdx),
    {TotalCount, AdjustedPageIdx, OnePageGoodsList}.
 

filter_selling_goods1([GoodsNo, PageIdx, SortType]) ->
    GoodsList = filter_selling_goods_by_no(GoodsNo),
    GoodsList.
 
%% 依据搜索条件，过滤市场的挂售记录
%% TODO: 暂时用比较一般的过滤算法，以后视情况决定是否要改进
filter_selling_goods([Type, SubType, Quality, Race, LevelMin, LevelMax, PriceMin, PriceMax, Sex]) ->
	% 按等级范围过滤
	GoodsList = 
	case LevelMin =/= 0 orelse LevelMax =/= 0 of
		true ->  % 限制等级范围
			% {LevelMin, LevelMax} = decide_level_range(Level),
			filter_selling_goods_by_level(LevelMin, LevelMax);
		false -> % 不限等级
			filter_selling_goods_by_end_time()
	end,
	RetGoodsList = 
	case PriceMin =/= 0 orelse PriceMax =/= 0 of
		true ->
			filter_selling_goods_by_price(PriceMin, PriceMax, GoodsList);
		false ->
			GoodsList
	end,
	% 按品质 和 (种族、性别为一组) 过滤
	RetGoodsList1 =
		if
			Quality =/= ?QUALITY_INVALID andalso Race =/= 0 andalso Sex =/= 0 ->
				[X || X <- RetGoodsList, (X#mk_selling.quality >= Quality) andalso (X#mk_selling.race == Race) andalso (X#mk_selling.sex == Sex)];
			Quality =/= ?QUALITY_INVALID ->
				[X || X <- RetGoodsList, X#mk_selling.quality >= Quality];
			Race =/= 0 andalso Sex =/= 0 ->
				[X || X <- RetGoodsList, (X#mk_selling.race == Race) andalso (X#mk_selling.sex == Sex)];
			true ->
				RetGoodsList
		end,
	% 按物品类型和子类型过滤
    MultipleSubType = lists:member(SubType, [100,101,102]),
	RetGoodsList2 = 
		if 
			SubType =/= 0 andalso (not MultipleSubType) ->  % 有限定子类型
				?ASSERT(Type =/= 0),
				[X || X <- RetGoodsList1, (X#mk_selling.sub_type == SubType) andalso (X#mk_selling.type == Type)];
			Type =/= 0 andalso Type =/= 100 andalso (not MultipleSubType) ->  % 没有限定子类型，只限定了主类型
				?TRACE("search condi: only main type!!!!!!!!!...~n~n"),
				[X || X <- RetGoodsList1, X#mk_selling.type == Type];
            Type =:= 100 ->
                [X || X <- RetGoodsList1, X#mk_selling.type == ?GOODS_T_EQ_CONSUME orelse X#mk_selling.type == ?GOODS_T_FUN_PROP];
            SubType =:= 100 ->
                [X || X <- RetGoodsList1, X#mk_selling.type =:= Type andalso util:in_range(X#mk_selling.sub_type, ?EQP_T_WEAPON_BEGIN, ?EQP_T_WEAPON_END)];
            SubType =:= 101 ->
                [X || X <- RetGoodsList1, X#mk_selling.type =:= Type andalso lists:member(X#mk_selling.sub_type, [?EQP_T_HEADWEAR, ?EQP_T_CLOTHES, ?EQP_T_BACKWEAR])];
            SubType =:= 102 ->
                [X || X <- RetGoodsList1, X#mk_selling.type =:= Type andalso lists:member(X#mk_selling.sub_type, [?PARTNER_PROP_T_CONSUME, ?PARTNER_PROP_T_OTHER_BOOK])];
			true  -> 
				RetGoodsList1
		end,
	RetGoodsList2.
	

filter_selling_goods_by_no(GoodsNo) ->
    TimeNow = svr_clock:get_unixtime(),
    Ms = ets:fun2ms(fun(T) when GoodsNo == T#mk_selling.goods_no andalso TimeNow < T#mk_selling.end_time -> T end),
    ets:select(?ETS_MARKET_SELLING, Ms).


filter_selling_goods_by_end_time() ->
	TimeNow = svr_clock:get_unixtime(),
	Ms = ets:fun2ms(fun(T) when TimeNow < T#mk_selling.end_time -> T end),
	ets:select(?ETS_MARKET_SELLING, Ms).
	
%% 从ets表中，查询市场中存在的挂售记录(按等级找), 
%% 注意：这里顺带过滤掉了过期的挂售记录
filter_selling_goods_by_level(LevelMin, LevelMax) ->
	?TRACE("filter_selling_goods_by_level()...~n"),
	TimeNow = svr_clock:get_unixtime(),
    if
	    LevelMin =/= LevelMax andalso LevelMin > 0 andalso LevelMax > 0 ->
			Ms = ets:fun2ms(fun(T) when T#mk_selling.level >= LevelMin 
								 andalso T#mk_selling.level =< LevelMax
								 andalso TimeNow < T#mk_selling.end_time ->
									T
							end);
		LevelMin =/= 0 ->
			Ms = ets:fun2ms(fun(T) when T#mk_selling.level >= LevelMin
								 andalso TimeNow < T#mk_selling.end_time ->
									T
							end);
        LevelMax =/= 0 ->
            Ms = ets:fun2ms(fun(T) when T#mk_selling.level =< LevelMax
                                 andalso TimeNow < T#mk_selling.end_time ->
                                    T
                            end);
        true ->
            Ms = ets:fun2ms(fun(T) when TimeNow < T#mk_selling.end_time ->
                                    T
                            end)

	end,
	ets:select(?ETS_MARKET_SELLING, Ms).
	
	
filter_selling_goods_by_price(PriceMin, PriceMax, GoodsList) ->
	TimeNow = svr_clock:get_unixtime(),
	if
        PriceMin =/= PriceMax andalso PriceMin > 0 andalso PriceMax > 0 ->
            Ms = ets:fun2ms(fun(T) when T#mk_selling.price >= PriceMin 
                                 andalso T#mk_selling.price =< PriceMax
                                 andalso TimeNow < T#mk_selling.end_time ->
                                    T
                            end);
        PriceMin =/= 0 ->
            Ms = ets:fun2ms(fun(T) when T#mk_selling.price >= PriceMin
                                 andalso TimeNow < T#mk_selling.end_time ->
                                    T
                            end);
        PriceMax =/= 0 ->
            Ms = ets:fun2ms(fun(T) when T#mk_selling.price =< PriceMax
                                 andalso TimeNow < T#mk_selling.end_time ->
                                    T
                            end);
        true ->
            Ms = ets:fun2ms(fun(T) when TimeNow < T#mk_selling.end_time ->
                                    T
                            end)

    end,
	TempList = ets:select(?ETS_MARKET_SELLING, Ms),
    [X || X <- TempList, lists:member(X, GoodsList)].


%% 矫正页数索引，如果超出上限则调整为最后一页的索引
adjust_page_index(TotalCount, PageIdx) ->
	AdjustedPageIdx = 
		case TotalCount =< ?MK_GOODS_COUNT_PER_PAGE of
			true ->
				0;
			false ->
				case TotalCount > PageIdx * ?MK_GOODS_COUNT_PER_PAGE of
					true -> % 没有超出上限，不需矫正
						PageIdx;
					false -> % 超出上限，矫正 --> 改为返回空的列表
                        PageIdx
						% case (TotalCount rem ?MK_GOODS_COUNT_PER_PAGE) =:= 0 of
						% 	true ->
						% 		TotalCount div ?MK_GOODS_COUNT_PER_PAGE - 1;
						% 	false ->
						% 		TotalCount div ?MK_GOODS_COUNT_PER_PAGE
						% end
				end
		end,
	AdjustedPageIdx.
	

%% 提取出单页列表数据	
extract_one_page(TotalList, PageIdx) ->
	Start = PageIdx * ?MK_GOODS_COUNT_PER_PAGE + 1,
    case Start > length(TotalList) of
        true -> [];
        false -> lists:sublist(TotalList, Start, ?MK_GOODS_COUNT_PER_PAGE)
    end.
	
get_sell_record_from_ets(SellRecordId) ->
    case ets:lookup(?ETS_MARKET_SELLING, SellRecordId) of
        [] -> null;
        [R] -> R
    end.

%% 从市场删除挂售记录
del_sell_record_from_ets(SellRecordId) ->
	ets:delete(?ETS_MARKET_SELLING, SellRecordId).
	

update_sell_record_to_ets(NewSellRecord) ->
    ets:insert(?ETS_MARKET_SELLING, NewSellRecord).
	
%% 从市场删除物品信息	
del_goods_info_from_ets(GoodsId) ->    
	ets:delete(?ETS_MARKET_GOODS_ONLINE, GoodsId).


get_goods_info_from_ets(GoodsId) ->
    case ets:lookup(?ETS_MARKET_GOODS_ONLINE, GoodsId) of
        [] ->
            null;
        [Goods] ->
            Goods
    end.

update_goods_info_to_ets(Goods) ->
    ets:insert(?ETS_MARKET_GOODS_ONLINE, Goods).


% duan
try_search_selling_goods1(PS, Args) ->
    [GoodsNo,PageIdx, SortType] = Args,

    {TotalCount, AdjustedPageIdx, GoodsList} = search_selling_goods_by_ets1(PS, Args),

    ?ASSERT(is_list(GoodsList)),
    case GoodsList of
        [] ->
            ?ASSERT(TotalCount =:= 0),
            {ok, BinData} = pt_26:write(?PT_MK_QUERY_GOODS, {?RES_OK, AdjustedPageIdx, TotalCount, []}),
            lib_send:send_to_sock(PS, BinData);
        _ ->
            ?ASSERT(TotalCount > AdjustedPageIdx * ?MK_GOODS_COUNT_PER_PAGE),
            {ok, BinData} = pt_26:write(?PT_MK_QUERY_GOODS, {?RES_OK, AdjustedPageIdx, TotalCount, GoodsList}),
            lib_send:send_to_sock(PS, BinData)
    end.

try_search_selling_goods(PS, Args) ->
    [_Type, _SubType, _Quality, _Race, _LevelMin, _LevelMax, _PriceMin, _PriceMax, _Sex, _PageIdx, _SortType, SearchName] = Args,
    ?ASSERT(is_list(SearchName)),
    case is_list(SearchName) of
    	false ->
    		lib_send:send_prompt_msg(PS, ?PM_PARA_ERROR);
    	true ->
		    {TotalCount, AdjustedPageIdx, GoodsList} = search_selling_goods_by_ets(PS, Args),

		    ?ASSERT(is_list(GoodsList)),
		    case GoodsList of
		        [] ->
		            ?ASSERT(TotalCount =:= 0),
		            {ok, BinData} = pt_26:write(?PT_MK_SEARCH_SELLING_GOODS, {?RES_OK, AdjustedPageIdx, TotalCount, []}),
		            lib_send:send_to_sock(PS, BinData);
		        _ ->
		            ?ASSERT(TotalCount > AdjustedPageIdx * ?MK_GOODS_COUNT_PER_PAGE),
		            {ok, BinData} = pt_26:write(?PT_MK_SEARCH_SELLING_GOODS, {?RES_OK, AdjustedPageIdx, TotalCount, GoodsList}),
		            lib_send:send_to_sock(PS, BinData)
		    end
	end.


try_clear_expired_goods() ->
    TimeNow = svr_clock:get_unixtime(),
    AllGoodsList = ets:tab2list(?ETS_MARKET_SELLING),
    % match过期时间超过上限的上架物品
    MatchList = [X || X <- AllGoodsList, (TimeNow - X#mk_selling.end_time) >= ?MAX_EXPIRED_TIME],
    
    F = fun(X) ->
            case X#mk_selling.type =:= ?GOODS_T_VIRTUAL of
                true ->  % 挂售的是钱
                    ?ASSERT(X#mk_selling.money_to_sell > 0),
                    ?ASSERT(X#mk_selling.money_to_sell_type =/= ?MNY_T_INVALID),
                    ?ASSERT(X#mk_selling.money_to_sell_type =/= X#mk_selling.price_type),
                    GoodsId = 0,
                    StackNum = X#mk_selling.money_to_sell,
                    Goods = null;
                false -> % 挂售的是物品
                    ?ASSERT(X#mk_selling.money_to_sell =:= 0),
                    ?ASSERT(X#mk_selling.money_to_sell_type =:= ?MNY_T_INVALID),
                    GoodsId = X#mk_selling.goods_id,
                    StackNum = X#mk_selling.stack_num,
                    Goods = 
                        case get_goods_info_from_ets(GoodsId) of
                            null ->
                                % ?ASSERT(false, GoodsId),
                                ?ERROR_MSG("mod_market:try_clear_expired_goods get_goods_info_from_ets error, GoodsId:~p~n", [GoodsId]),
                                null;
                            TGoods -> 
                                case lib_goods:get_count(TGoods) =:= StackNum of
                                    true ->
                                        lib_goods:set_owner_id(TGoods, X#mk_selling.seller_id);
                                    false ->
                                        ?WARNING_MSG("mod_market:try_clear_expired_goods get_goods_info_from_ets error, {stack_num, GoodsCnt}:~w~n", [{StackNum, lib_goods:get_count(TGoods)}]),
                                        lib_goods:set_owner_id(lib_goods:set_count(TGoods, StackNum), X#mk_selling.seller_id)
                                end
                        end
            end, 
            
            SellerId = X#mk_selling.seller_id,
            % 发系统邮件给卖家， 返回物品
            Title = <<"摆摊通知：物品过期">>,
            Content = <<"您摆摊物品已过期，请在附件取回您的物品">>,
            
            % 给卖家发送邮件   TODO：考虑spawn一个进程专门去发邮件？？
            SendMailRet = 
                case Goods =:= null of
                    true ->
                        lib_mail:send_sys_mail(SellerId, Title, Content, [{?VGOODS_GAMEMONEY, StackNum*10000}], [?LOG_CRI, ?LOG_CRI]);
                    false ->
                        lib_mail:send_sys_mail(tranfer_goods, SellerId, Title, Content, [Goods], [?LOG_CRI, ?LOG_CRI])
                end,

            case SendMailRet of
                {false, _Reason} ->  % 发送系统邮件失败
                    ?ERROR_MSG("[MARKET_ERR]clear_expired_goods send_sys_mail error!! extra info: ~p", [{_Reason, GoodsId, StackNum}]),
                    ?ASSERT(false, {_Reason, GoodsId, StackNum}),
                    skip;
                true ->
                    % 从数据库的market_sellling表删除记录
                    db_delete_market_selling(X#mk_selling.id),
                    
                    % 从ets清除对应的挂售记录
                    del_sell_record_from_ets(X#mk_selling.id),
                    % 从ets清除对应的物品信息
                    case GoodsId =/= 0 of
                        true -> 
                            lib_goods:db_delete_goods(GoodsId),
                            del_goods_info_from_ets(GoodsId);
                        false -> skip
                    end,
                    % 通知卖家更新其上架物品列表
                    lib_market:notify_my_sell_list_changed(SellerId)
            end
        end,
        
    lists:foreach(F, MatchList).

db_delete_market_selling(SellRecordId) ->
    db:delete(?DB_SYS, market_selling, [{id, SellRecordId}]).