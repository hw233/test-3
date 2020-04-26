%%%-----------------------------------
%%% @Module  : lib_market
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2011.10.17
%%% @Description: 市场交易系统
%%%-----------------------------------

-module(lib_market).

% %%
% %% Include files
% %%
-include("common.hrl").
% -include("record.hrl").
-include("market.hrl").
-include("goods.hrl").
-include("record/goods_record.hrl").
-include("abbreviate.hrl").
-include("ets_name.hrl").
-include("log.hrl").

% %%
% %% Exported Functions
% %%
-export([init_market_from_db/0,
		notify_my_sell_list_changed/1,
		calc_custody_fee/3,
		handle_cost_custody_fee/4,
		make_sell_record/1,   
		insert_record_get_id/1,
		get_my_sell_count/1,
        is_can_sell/1
		]).

% %%
% %% API Functions
% %%


%% 从数据库加载市场挂售记录和上架物品信息到ets
init_market_from_db() ->
	?TRACE("init market from db...~n"),
	
	case db:select_all(market_selling, ?SQL_QUERY_MK_SELLING, []) of
		[] ->  % 没有数据
			?TRACE("[MARKET]There are not any selling goods!!!~n"),
			skip;
		SqlRet when is_list(SqlRet) ->
			SellRecords = [make_sell_record(X) || X <- SqlRet],
			% 写入ets表中
			[ets:insert(?ETS_MARKET_SELLING, X) || X <- SellRecords, X =/= null],

			% 从goods表 load市场上架物品信息到ets
			[load_market_goods_info_from_db(X#mk_selling.goods_id) || X <- SellRecords, X =/= null];
		Other ->  % db读取出错
            ?ERROR_MSG("[MARKET_ERR]init_market_from_db() error!! sql ret: ~p", [Other]),
			?ASSERT(false, Other),
			skip
	end.
	

insert_record_get_id(SellRecord) ->
	SellerId = SellRecord#mk_selling.seller_id,
	GoodsId = SellRecord#mk_selling.goods_id,
	GoodsNo = SellRecord#mk_selling.goods_no,
	GoodsName = SellRecord#mk_selling.goods_name,
	GoodsType = SellRecord#mk_selling.type,
	GoodsSubType = SellRecord#mk_selling.sub_type,
	Quality = SellRecord#mk_selling.quality,
	Level = SellRecord#mk_selling.level,
	Race = SellRecord#mk_selling.race,
	Sex = SellRecord#mk_selling.sex,
	StackNum = SellRecord#mk_selling.stack_num,
	Price = SellRecord#mk_selling.price,
	PriceType = SellRecord#mk_selling.price_type,
	StartTime = SellRecord#mk_selling.start_time,
	EndTime = SellRecord#mk_selling.end_time,

	TId = db:insert_get_id(market_selling, 
                        [seller_id, goods_id, goods_no, goods_name, type, sub_type, quality, level, race, sex, stack_num, money_to_sell, money_to_sell_type, price, price_type, 
                            start_time, end_time, status],
                        [SellerId, GoodsId, GoodsNo, GoodsName, GoodsType, GoodsSubType, Quality, Level, Race, Sex, StackNum, SellRecord#mk_selling.money_to_sell,
                        SellRecord#mk_selling.money_to_sell_type, Price, PriceType, StartTime, EndTime, ?MK_SELL_R_STATUS_SELLING]),
    Id = 
        case lib_account:is_global_uni_id(TId) of 
            true -> TId; 
            false -> 
                GlobalId = lib_account:to_global_uni_id(TId),
                db:update(?DB_SYS, market_selling, ["id"], [GlobalId], "id", TId), 
                GlobalId
        end,
    Id.


make_sell_record(SrcData) ->
	[Id, SellerId, GoodsId, GoodsNo, GoodsName, Type, SubType, Quality, Level, Race, Sex, StackNum, 
	Price, PriceType, MoneyToSell, MoneyToSellType, StartTime, EndTime, Status] = SrcData,
    case SellerId =:= ?INVALID_ID of
        true -> null;
        false ->
        	?TRACE("MK_RcdId: ~p, goodsType: ~p, GoodsId: ~p, money: ~p~n", [Id, Type, GoodsId, MoneyToSell]),
        	%% 检验数据的合法性
        	?ASSERT(is_binary(GoodsName), GoodsName),
        	?ASSERT(SellerId =/= 0),
        	?ASSERT(Price > 0),
        	?ASSERT(PriceType >= ?MNY_T_MIN andalso PriceType =< ?MNY_T_MAX),
        	?ASSERT(Status =:= ?MK_SELL_R_STATUS_SELLING),

        	case GoodsId =/= 0 of
        		true ->   % 表示对应的挂售记录是物品
        			?ASSERT(Type =/= ?GOODS_T_VIRTUAL),
        			?ASSERT(MoneyToSell =:= 0),
        			?ASSERT(MoneyToSellType =:= ?MNY_T_INVALID);
        		false ->  % 表示对应的挂售记录是货币
        			?ASSERT(Type =:= ?GOODS_T_VIRTUAL),
        			?ASSERT(GoodsId =:= 0),
        			?ASSERT(MoneyToSell > 0),
        			?ASSERT(MoneyToSellType =/= ?MNY_T_INVALID),
        			?ASSERT(MoneyToSellType =/= PriceType)
        	end,
        	#mk_selling{
        			id = adust_id(Id),
        			seller_id = SellerId,
        			goods_id = case lib_account:is_global_uni_id(GoodsId) of true -> GoodsId; false -> lib_account:to_global_uni_id(GoodsId) end,
        			goods_no = GoodsNo,
        			goods_name = GoodsName,
          			type = Type,      
          			sub_type = SubType,
          
          			quality = Quality,
          			level = Level,
          			race = Race,
          			sex = Sex,
          			stack_num = StackNum,
        			price = Price,
        			price_type = PriceType,
        			money_to_sell = MoneyToSell,
        			money_to_sell_type = MoneyToSellType,
        			start_time = StartTime,
        			end_time = EndTime,
        			status = Status
        		}
    end.


adust_id(TId) ->
    Id = 
        case lib_account:is_global_uni_id(TId) of 
            true -> TId; 
            false -> 
                GlobalId = lib_account:to_global_uni_id(TId),
                db:update(?DB_SYS, market_selling, ["id"], [GlobalId], "id", TId), 
                GlobalId
        end,
    Id.


%% 计算挂售物品时对应需扣的托管费
%% @para: Price => 挂售价格， 
%%        PriceType => 挂售价格的类型， 
%%        SellTime_Hour => 挂售时间（单位：小时）
calc_custody_fee(_Price, _PriceType, SellTime_Hour) ->
	0.
	
%% 扣托管费
%% @return：玩家的新状态
handle_cost_custody_fee(PS, Price, PriceType, SellTime) ->
	CustodyFee = calc_custody_fee(Price, PriceType, SellTime),
	NewPS = player_syn:cost_money(PS, PriceType, CustodyFee, [?LOG_MARKET, "grounding"]),
	NewPS.
	
		
% 通知玩家更新其上架物品列表	
notify_my_sell_list_changed(PlayerId) ->
	?TRACE("notify_my_sell_list_changed(),  playerid: ~p~n", [PlayerId]),
	case player:get_pid(PlayerId) of
		null ->
			skip;
		Pid ->
   			gen_server:cast(Pid, 'notify_my_sell_list_changed')
   	end.

is_can_sell(GoodsNo) ->
    case data_stall_config:get(GoodsNo) of
        null -> false;
        _ -> true
    end.
	
	
%% 获取玩家的上架物品的件数
%% 注: 目前是利用db做统计 
%%     如果改为用ets匹配做统计，则注意需要用call
get_my_sell_count(PS) ->
    case db:select_one(market_selling, "COUNT(*)", [{seller_id, player:id(PS)}]) of
        Count when is_integer(Count) ->
        	?TRACE("my market sell count: ~p~n", [Count]),
            Count;
        _Any -> % db出错
        	?ASSERT(false, _Any),
        	?MK_MAX_SELL_GOODS
    end.


% %% ==================================== local function ==================================	
	
%% 从数据库load市场物品信息到ets
load_market_goods_info_from_db(GoodsId) ->
	?Ifc (GoodsId /= 0)
		% 从数据库load物品基础数据，并插入ets
    	case db:select_row(goods, ?SQL_QRY_GOODS_INFO, [{id, GoodsId}, {location, ?LOC_MARKET}]) of
    		[] -> % load失败，加错误日志
                case db:select_row(goods, ?SQL_QRY_GOODS_INFO, [{id, lib_account:to_local_id(GoodsId)}, {location, ?LOC_MARKET}]) of
                    [] ->
    			         ?ERROR_MSG("[MARKET_ERR]load_market_goods_info_from_db() err!! goods uni id:~p~n", [GoodsId]),
    			         skip;
                    GoodsInfo when is_list(GoodsInfo) ->
                        Goods = mod_inv:to_goods_record(GoodsInfo),
                        ?ASSERT(is_record(Goods, goods)),
                        ?ASSERT(Goods#goods.player_id =:= 0),
                        ?ASSERT(Goods#goods.location =:= ?LOC_MARKET),
                        ets:insert(?ETS_MARKET_GOODS_ONLINE, Goods)
                end;
    		GoodsInfo when is_list(GoodsInfo) ->
    			Goods = mod_inv:to_goods_record(GoodsInfo),
    			?ASSERT(is_record(Goods, goods)),
    			?ASSERT(Goods#goods.player_id =:= 0),
    			?ASSERT(Goods#goods.location =:= ?LOC_MARKET),
    			ets:insert(?ETS_MARKET_GOODS_ONLINE, Goods);
    		_ ->  % db操作出错
    			?ASSERT(false),
    			skip
    	end
    ?End.
