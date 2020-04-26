%%%-----------------------------------
%%% @Module  : pt_26
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2011.10.13
%%% @Description: 市场交易系统
%%%-----------------------------------
-module(pt_26).
-export([read/2, write/2]).


-include("common.hrl").
-include("record.hrl").
-include("market.hrl").
-include("protocol/pt_26.hrl").

%%
%%客户端 -> 服务端 ----------------------------
%%

%% 挂售物品
read(?PT_MK_SELL_GOODS, <<GoodsId:64, Price:32, PriceType:8, SellTime:8, StackNum:16>>) ->
	?TRACE("got PT_MK_SELL_GOODS...~n"),
    {ok, [GoodsId, Price, PriceType, SellTime, StackNum]};
    
    
%% 挂售货币
read(?PT_MK_SELL_MONEY, <<MoneyToSell:32, MoneyToSellType:8, Price:32, SellTime:8>>) ->
    {ok, [MoneyToSell, MoneyToSellType, Price, SellTime]};
    
    
%% 重新挂售过期的上架物品
read(?PT_MK_RESELL_EXPIRED_GOODS, <<SellRecordId:64, Price:32, PriceType:8, SellTime:8>>) ->
    {ok, [SellRecordId, Price, PriceType, SellTime]};
    
%% 查看我的上架物品
read(?PT_MK_QUERY_MY_SELL_LIST, _) ->
    {ok, myself};
    
%% 取消挂售物品 
read(?PT_MK_CANCEL_SELL, <<SellRecordId:64>>) ->
	{ok, [SellRecordId]};
    

%% 搜索上架物品（分页返回搜索结果）
read(?PT_MK_SEARCH_SELLING_GOODS, <<Type:8, SubType:8, Quality:8, Race:8, LevelMin:16, LevelMax:16, PriceMin:32, PriceMax:32, Sex:8, PageIdx:16, SortType:8, Bin/binary>>) ->
    {SearchName, _} = pt:read_string(Bin),
    {ok, [Type, SubType, Quality, Race, LevelMin, LevelMax, PriceMin, PriceMax, Sex, PageIdx, SortType, SearchName]};

%% 搜索上架物品（分页返回搜索结果）
read(?PT_MK_QUERY_GOODS, <<GoodsNo:32,PageIdx:16, SortType:8>>) ->
    {ok, [GoodsNo, PageIdx, SortType]};
   
%% 购买上架物品 
read(?PT_MK_BUY_GOODS, <<SellRecordId:64, StackNum:16>>) ->
	{ok, [SellRecordId, StackNum]};

%% 取回过期的上架物品	
read(?PT_MK_GET_BACK_EXPIRED_GOODS, <<SellRecordId:64>>) ->
	{ok, SellRecordId};
    
read(_Cmd, _R) ->
    ?ASSERT(false, {_Cmd, _R}),
    {error, not_match}.

%%
%%服务端 -> 客户端 ------------------------------------
%%

%% 挂售物品
write(?PT_MK_SELL_GOODS, [RetCode, GoodsId, SellRecordId, StackNum]) ->
    Data = <<RetCode:8, GoodsId:64, SellRecordId:64, StackNum:16>>,
    {ok, pt:pack(?PT_MK_SELL_GOODS, Data)};
    
%% 挂售货币
write(?PT_MK_SELL_MONEY, [RetCode, MoneyToSell, MoneyToSellType, SellRecordId]) ->
    Data = <<RetCode:8, MoneyToSell:32, MoneyToSellType:8, SellRecordId:64>>,
    {ok, pt:pack(?PT_MK_SELL_MONEY, Data)};
    
    
%% 重新挂售过期的上架物品
write(?PT_MK_RESELL_EXPIRED_GOODS, [RetCode, SellRecordId]) ->
    Data = <<RetCode:8, SellRecordId:64>>,
    {ok, pt:pack(?PT_MK_RESELL_EXPIRED_GOODS, Data)};
    
    
%% 查看我的上架物品
write(?PT_MK_QUERY_MY_SELL_LIST, MySellList) ->
	Len = length(MySellList),
	?TRACE("PT_MK_QUERY_MY_SELL_LIST: my sell count: ~p~n", [Len]),
	TimeNow = svr_clock:get_unixtime(),
	Data = pack_my_sell_list(MySellList, <<>>, TimeNow),
	?TRACE("my sell list data: ~p~n", [Data]),
    {ok, pt:pack(?PT_MK_QUERY_MY_SELL_LIST, <<Len:16, Data/binary>>)};
    
%% 搜索上架物品（分页返回搜索结果）
write(?PT_MK_SEARCH_SELLING_GOODS, {RetCode, PageIdx, TotalCount, SinglePageGoodsList}) ->
	ShowCount = length(SinglePageGoodsList),
	case TotalCount =:= 0 of
		true -> ?ASSERT(ShowCount =:= 0);
 		false -> ?ASSERT(ShowCount =< TotalCount)
	end,
    TimeNow = svr_clock:get_unixtime(),
	GoodsData = pack_single_page_goods_list(SinglePageGoodsList, <<>>, TimeNow),
	Data = <<RetCode:8, PageIdx:16, TotalCount:16, ShowCount:16, GoodsData/binary>>,
    {ok, pt:pack(?PT_MK_SEARCH_SELLING_GOODS, Data)};

%% 搜索上架物品（分页返回搜索结果）
write(?PT_MK_QUERY_GOODS, {RetCode, PageIdx, TotalCount, SinglePageGoodsList}) ->
    ShowCount = length(SinglePageGoodsList),
    case TotalCount =:= 0 of
        true -> ?ASSERT(ShowCount =:= 0);
        false -> ?ASSERT(ShowCount =< TotalCount)
    end,
    TimeNow = svr_clock:get_unixtime(),
    ?DEBUG_MSG("SinglePageGoodsList=~p",[SinglePageGoodsList]),
    GoodsData = pack_single_page_goods_list(SinglePageGoodsList, <<>>, TimeNow),
    Data = <<RetCode:8, PageIdx:16, TotalCount:16, ShowCount:16, GoodsData/binary>>,
    {ok, pt:pack(?PT_MK_QUERY_GOODS, Data)};

    
%% 取消挂售物品
write(?PT_MK_CANCEL_SELL, [RetCode, SellRecordId]) ->
	Data = <<RetCode:8, SellRecordId:64>>,
    {ok, pt:pack(?PT_MK_CANCEL_SELL, Data)};
	
%% 购买上架物品	
write(?PT_MK_BUY_GOODS, [RetCode, SellRecordId, StackNum]) ->
	Data = <<RetCode:8, SellRecordId:64, StackNum:16>>,
	{ok, pt:pack(?PT_MK_BUY_GOODS, Data)};

%% 取回过期的上架物品
write(?PT_MK_GET_BACK_EXPIRED_GOODS, [RetCode, SellRecordId]) ->
	Data = <<RetCode:8, SellRecordId:64>>,
    {ok, pt:pack(?PT_MK_GET_BACK_EXPIRED_GOODS, Data)};
	    

write(_Cmd, _R) ->
	?ASSERT(false, {_Cmd, _R}),
    {error, not_match}.



%% 打包我的上架物品列表信息
pack_my_sell_list([H | T], Bin, TimeNow) ->
	?ASSERT(is_record(H, mk_selling)),
	EndTime = H#mk_selling.end_time,
	LeftTime = EndTime - TimeNow,  % 挂售剩余时间（单位：秒）
	SellTime = (EndTime - H#mk_selling.start_time) div ?SELL_TIME_UNIT_TO_SEC, % 原挂售时间（单位：小时）
	?TRACE("pack_my_sell_list(), sellTime: ~p, lefttime: ~p, goods_id: ~p, goodsNo: ~p, type: ~p~n", [SellTime, LeftTime, H#mk_selling.goods_id, H#mk_selling.goods_no, H#mk_selling.type]),
    NewBin = <<
    			Bin/binary,
             	(H#mk_selling.id)           :   64,
             	(H#mk_selling.goods_id)     :   64,
             	(H#mk_selling.goods_no)     :   32,
             	(H#mk_selling.stack_num)    :   16,
             	(H#mk_selling.price)        :   32,
             	(H#mk_selling.price_type)   :   8,
             	SellTime				    :   8,
             	LeftTime                    :   32,
                (H#mk_selling.quality)      :   8,
                (H#mk_selling.level)        :   16,
             	(H#mk_selling.type)         :   8
             >>,
    pack_my_sell_list(T, NewBin, TimeNow);
pack_my_sell_list([], Bin, _TimeNow) ->
    Bin.
    
%% 打包单页显示的物品列表
pack_single_page_goods_list([H | T], Bin, TimeNow) ->
	?ASSERT(is_record(H, mk_selling)),
	EndTime = H#mk_selling.end_time,
    LeftTime = EndTime - TimeNow,  % 挂售剩余时间（单位：秒）
    SellTime = (EndTime - H#mk_selling.start_time) div ?SELL_TIME_UNIT_TO_SEC, % 原挂售时间（单位：小时）
	?ASSERT(svr_clock:get_unixtime() < EndTime),
	?TRACE("pack_single_page_goods_list(), id: ~p, No : ~p, type: ~p~n", [H#mk_selling.goods_id, H#mk_selling.goods_no, H#mk_selling.type]),
    NewBin = <<
    			Bin/binary,
             	(H#mk_selling.id)           :   64,
             	(H#mk_selling.goods_id)     :   64,
             	(H#mk_selling.goods_no)     :   32,
                (H#mk_selling.stack_num)    :   16,
             	(H#mk_selling.price)        :   32,
             	(H#mk_selling.price_type)   :   8,
                SellTime                    :   8,
                LeftTime                    :   32,
             	(H#mk_selling.quality)      :   8,
                (H#mk_selling.level)        :   16,
             	(H#mk_selling.type)         :   8
             >>,
    pack_single_page_goods_list(T, NewBin, TimeNow);
pack_single_page_goods_list([], Bin, _TimeNow) ->
    Bin. 