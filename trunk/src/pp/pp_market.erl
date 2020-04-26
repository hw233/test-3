%%%--------------------------------------
%%% @Module  : pp_market
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2011.10.13
%%% @Description: 市场
%%%--------------------------------------
-module(pp_market).
-export([handle/3]).
-include("common.hrl").
-include("record.hrl").
-include("market.hrl").
-include("goods.hrl").
-include("protocol/pt_26.hrl").
-include("num_limits.hrl").
-include("prompt_msg_code.hrl").
-include("player.hrl").
-include("sys_code.hrl").

% %%
% %% API Functions
% %%

%% desc: 等级检查
handle(Cmd, PS, Data) ->
    case ply_sys_open:is_open(PS, ?SYS_MARKET) of
        true -> handle_cmd(Cmd, PS, Data);
        false -> lib_send:send_prompt_msg(PS, ?PM_LV_LIMIT)
    end.


%% 挂售物品
handle_cmd(?PT_MK_SELL_GOODS, PS, Args) ->
   ?TRACE("handle PT_MK_SELL_GOODS: ~p~n", [Args]),
   case check_client_msg(?PT_MK_SELL_GOODS, Args) of
   	client_msg_illegal ->
   		skip;
   	ok ->
   		[GoodsId, _Price, _PriceType, _SellTime, StackNum] = Args,
   		case mod_market:sell_goods([PS | Args]) of
   			{fail, Reason} ->
               lib_send:send_prompt_msg(PS, Reason);
   			{error, _Reason} -> % 通常是由于客户端消息非法，直接跳过，不做处理。
   				skip;
   			{ok, SellRecordId, NewPS} ->
   				?TRACE("sell goods ok at last...~n"),
   				{ok, BinData} = pt_26:write(?PT_MK_SELL_GOODS, [?RES_OK, GoodsId, SellRecordId, StackNum]),
   				lib_send:send_to_sock(PS, BinData),
   				% 更新玩家状态
   				{ok, NewPS}
   		end
   end;
   	
%% 挂售货币
handle_cmd(?PT_MK_SELL_MONEY, PS, Args) ->     
   case check_client_msg(?PT_MK_SELL_MONEY, Args) of
   	client_msg_illegal ->
   		skip;
   	ok ->
			[MoneyToSell, MoneyToSellType, _Price, _SellTime] = Args,
			case mod_market:sell_money([PS | Args]) of
				{fail, Reason} ->
               lib_send:send_prompt_msg(PS, Reason);
 			   {error, _Why} -> % 通常是由于客户端消息非法，直接跳过，不做处理。
 				   skip;
				{ok, SellRecordId, NewPS} ->
					{ok, BinData} = pt_26:write(?PT_MK_SELL_MONEY, [?RES_OK, MoneyToSell, MoneyToSellType, SellRecordId]),
					lib_send:send_to_sock(PS, BinData),
					% 更新玩家状态
					{ok, NewPS}
			end
   end;

%% 重新挂售过期的上架物品
handle_cmd(?PT_MK_RESELL_EXPIRED_GOODS, PS, Args) ->
	case check_client_msg(?PT_MK_RESELL_EXPIRED_GOODS, Args) of
		  client_msg_illegal ->
			   skip;
  		ok ->
    			[SellRecordId, _Price, _PriceType, _SellTime] = Args,
    			case mod_market:resell_goods([PS | Args]) of
       				{fail, Reason} ->
       				  lib_send:send_prompt_msg(PS, Reason);
        			{error, _Why} -> % 通常是由于客户端消息非法，直接跳过，不做处理。
        				skip;
       				{ok, NewPS} ->
       					{ok, BinData} = pt_26:write(?PT_MK_RESELL_EXPIRED_GOODS, [?RES_OK, SellRecordId]),
       					lib_send:send_to_sock(PS, BinData),
       					% 更新玩家状态
       					{ok, NewPS}
       			end
	end;
   		

%% 查看我的上架物品
handle_cmd(?PT_MK_QUERY_MY_SELL_LIST, PS, _) -> 
    mod_market:query_my_sell_list(PS);
   			
   	
%% 取消挂售物品
handle_cmd(?PT_MK_CANCEL_SELL, PS, [SellRecordId]) ->
	mod_market:cancel_sell(PS, SellRecordId);

   	
%% 搜索上架物品（分页返回搜索结果）
handle_cmd(?PT_MK_SEARCH_SELLING_GOODS, PS, Args) ->
	?TRACE("search arg: ~p~n", [Args]),
	TimeNow = util:longunixtime(),
	% 检查搜索的时间间隔，以避免玩家搜索太频繁
   case (TimeNow - get_last_search_mk_goods_time()) > ?SEARCH_MK_GOODS_CD_TIME of
        false ->
            ?TRACE("search market goods is cooling down!!!!!!!!!!!~n~n~n"),
            lib_send:send_prompt_msg(PS, ?PM_MK_PLEASE_WAIT_TO_SEARCH);
        true ->
        	% 检查职业，颜色，类型，子类型等是否合法
      			case check_client_msg(?PT_MK_SEARCH_SELLING_GOODS, Args) of
      				  client_msg_illegal ->
      					    skip;
        				ok ->
        					 mod_market:search_selling_goods(PS, Args),
           					
        					 % 记录上次搜索的时间
        					 set_last_search_mk_goods_time(TimeNow)
         		end
    end; 


%% 搜索上架物品（分页返回搜索结果）
handle_cmd(?PT_MK_QUERY_GOODS, PS, Args) ->
  ?TRACE("search arg: ~p~n", [Args]),
  TimeNow = util:longunixtime(),
  % 检查搜索的时间间隔，以避免玩家搜索太频繁
   case (TimeNow - get_last_search_mk_goods_time()) > ?SEARCH_MK_GOODS_CD_TIME of
        false ->
            ?TRACE("search market goods is cooling down!!!!!!!!!!!~n~n~n"),
            lib_send:send_prompt_msg(PS, ?PM_MK_PLEASE_WAIT_TO_SEARCH);
        true ->
          % 检查职业，颜色，类型，子类型等是否合法
            case check_client_msg(?PT_MK_QUERY_GOODS, Args) of
                client_msg_illegal ->
                    skip;
                ok ->
                   mod_market:search_selling_goods1(PS, Args),
                    
                   % 记录上次搜索的时间
                   set_last_search_mk_goods_time(TimeNow)
            end
    end; 
      
			
   
%% 购买上架的物品
handle_cmd(?PT_MK_BUY_GOODS, PS, [SellRecordId, StackNum]) ->
    case SellRecordId =< 0 orelse StackNum =< 0 of
        true -> skip;
        false ->
        	case mod_market:buy_goods([PS, SellRecordId, StackNum]) of
        		{fail, Reason} ->
        			lib_send:send_prompt_msg(PS, Reason);
        		{ok, SellerId, NewPS} ->
        			{ok, BinData} = pt_26:write(?PT_MK_BUY_GOODS, [?RES_OK, SellRecordId, StackNum]),
        			lib_send:send_to_sock(PS, BinData),
        			
        			% 通知卖家更新其上架物品列表
        			lib_market:notify_my_sell_list_changed(SellerId),
        			% 更新玩家状态
        			{ok, NewPS}
           	end
    end;
   	
	
%% 取回过期的上架物品
handle_cmd(?PT_MK_GET_BACK_EXPIRED_GOODS, PS, SellRecordId) ->
	mod_market:get_back_expired_goods(PS, SellRecordId);
   		

%% 容错处理
handle_cmd(_Cmd, _Status, _Data) ->
    ?ASSERT(false, _Data),
    ?DEBUG_MSG("pp_market no match", []),
    {error, "pp_market no match"}.

% %% ------------------------------------------

%% 检查客户端发过来的消息是否合法
check_client_msg(?PT_MK_SELL_GOODS, Args) ->
	?TRACE("check_client_msg: PT_MK_SELL_GOODS~n"),
	[_GoodsId, Price, PriceType, SellTime, StackNum] = Args,
    case is_sell_time_invalid(SellTime) of
        true ->
            ?ASSERT(false),
            client_msg_illegal;  % 挂售时间非法
        false ->
        	if
        		PriceType =/= ?MNY_T_GAMEMONEY andalso PriceType =/= ?MNY_T_COPPER andalso PriceType =/= ?MNY_T_YUANBAO ->
        			?ASSERT(false),
        			client_msg_illegal;
        		(Price =< 0) orelse (not is_integer(Price)) ->  % 价格非法
        			?ASSERT(false),
        			client_msg_illegal;
                (StackNum =< 0) orelse (not is_integer(StackNum)) ->
                    ?ASSERT(false),
                    client_msg_illegal;
        		true ->
        			ok
        	end
    end;
        	
check_client_msg(?PT_MK_SELL_MONEY, Args) ->
	[MoneyToSell, MoneyToSellType, Price, SellTime] = Args,
    case is_sell_time_invalid(SellTime) of
        true ->
            ?ASSERT(false),
            client_msg_illegal;  % 挂售时间非法
        false ->
        	if
        		MoneyToSellType =/= ?MNY_T_GAMEMONEY ->
        			?ASSERT(false),
        			client_msg_illegal;  % 挂售的货币类型非法
        		(MoneyToSell =/= ?MONEY_COUNT_1_WAN) andalso (MoneyToSell =/= ?MONEY_COUNT_5_WAN) andalso 
              (MoneyToSell =/= ?MONEY_COUNT_20_WAN) andalso (MoneyToSell =/= ?MONEY_COUNT_100_WAN) ->
        			?ASSERT(false),
        			client_msg_illegal;  % 挂售的货币数量非法
        		(Price =< 0) orelse (not is_integer(Price)) ->	
        			?ASSERT(false),
        			client_msg_illegal;  % 价格非法
        		true ->
        			ok
        	end
    end;
	
check_client_msg(?PT_MK_RESELL_EXPIRED_GOODS, Args) ->
	[_SellRecordId, Price, PriceType, SellTime] = Args,
    case is_sell_time_invalid(SellTime) of
        true ->
            ?ASSERT(false),
            client_msg_illegal;  % 挂售时间非法
        false ->
        	if
        		(Price =< 0) orelse (not is_integer(Price)) ->  
        			?ASSERT(false),
        			client_msg_illegal; % 价格非法
        		PriceType =/= ?MNY_T_GAMEMONEY andalso PriceType =/= ?MNY_T_COPPER andalso PriceType =/= ?MNY_T_YUANBAO -> 
        			?ASSERT(false),
        			client_msg_illegal; % 价格类型非法
        		true ->
        			ok
        	end
    end;


check_client_msg(?PT_MK_QUERY_GOODS, Args) ->
  [GoodsNo,PageIdx, SortType] = Args,
  if 
    0 > PageIdx ->
            ?ASSERT(false),
            client_msg_illegal;
    SortType =/= 0 andalso SortType =/= 1 andalso SortType =/= 2 andalso SortType =/= 3 ->
            ?ASSERT(false),
            client_msg_illegal;
    % lib_market:is_can_sell(GoodsNo ->
    %         ?ASSERT(false),
    %         client_msg_illegal;
    true -> ok
  end;


check_client_msg(?PT_MK_SEARCH_SELLING_GOODS, Args) ->
	[Type, SubType, Quality, Race, LevelMin, LevelMax, PriceMin, PriceMax, Sex, PageIdx, SortType, SearchName] = Args,
	if
		Type =:= 0 andalso SubType =/= 0 ->
			?ASSERT(false),
			client_msg_illegal; % 主类型或子类型非法：Type和SubType要么同时起作用， 要么同时不起作用
		?QUALITY_MAX < Quality ->
			?ASSERT(false),
			client_msg_illegal;
		?RACE_MAX < Race orelse Race < ?RACE_NONE ->
			?ASSERT(false),
			client_msg_illegal;
       ?SEX_FEMALE < Sex orelse Sex < ?SEX_NONE ->
            ?ASSERT(false),
            client_msg_illegal;
	    0 > LevelMin orelse LevelMax < 0 ->
	    	?ASSERT(false),
	    	client_msg_illegal; 
        0 > PriceMin orelse PriceMax < 0 ->
            ?ASSERT(false),
            client_msg_illegal; 
        0 > PageIdx ->
            ?ASSERT(false),
            client_msg_illegal;
        SortType =/= 0 andalso SortType =/= 1 andalso SortType =/= 2 andalso SortType =/= 3 ->
            ?ASSERT(false),
            client_msg_illegal;
	    length(SearchName) > ?MK_MAX_SEARCH_NAME_LEN ->
	    	?ASSERT(false),
	    	client_msg_illegal; % 搜索名字太长
	    true ->
	    	ok
	end.


get_last_search_mk_goods_time() ->
	case erlang:get(?PDKN_LAST_SEARCH_MK_GOODS_TIME) of
        undefined ->
            0;
        Time ->
            Time
    end.

set_last_search_mk_goods_time(Time) ->
	erlang:put(?PDKN_LAST_SEARCH_MK_GOODS_TIME, Time).



is_sell_time_invalid(SellTime) ->
    SellTime =/= 6 andalso SellTime =/= 12 andalso SellTime =/= 24.