%%%--------------------------------------
%%% @Module  : pp_troop
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2011.09.08
%%% @Description: 阵法和武将
%%%--------------------------------------
-module(pp_troop).
% -export([handle/3]).
% -include("common.hrl").
% -include("record.hrl").
% -include("partner.hrl").
% -include("player.hrl").
% -include("protocol/pt_17.hrl").
% -include("abbreviate.hrl").

% %%
% %% API Functions
% %%

% %% ========================================== 阵法的相关协议 ==================================================

% %% 获取已有阵法
% handle(?PT_GET_TROOP_LIST, Status, _) ->
% 	{ok, BinData} = pt_17:write(?PT_GET_TROOP_LIST, Status),
%     lib_send:send_one(Status#player_status.socket, BinData);

% %% 升级阵法
% handle(?PT_UPGRADE_TROOP, Status, TroopTypeId) ->
% 	case lib_troop:upgrade_troop(Status, TroopTypeId) of
% 	    {ok, CDTime, NewStatus} -> % 成功
% 	        {ok, BinData} = pt_17:write(?PT_UPGRADE_TROOP, {TroopTypeId, ?RES_OK, CDTime}),
% 	    	lib_send:send_one(Status#player_status.socket, BinData),
% 	    	% 更新玩家状态
% 	    	{ok, NewStatus}; 
% 	    {fail, Why} -> % 失败
% 	    	{ok, BinData} = pt_17:write(?PT_UPGRADE_TROOP, {TroopTypeId, Why, 0}),
% 	    	lib_send:send_one(Status#player_status.socket, BinData);
% 	    {error, _Why} ->
% 	        ?ASSERT(false, _Why),
% 	        skip
% 	end;
  
% %% 启用阵法
% handle(?PT_ACTIVATE_TROOP, Status, TroopTypeId) ->
% 	?Ifc (TroopTypeId /= 0)
% 		case lib_troop:activate_troop(TroopTypeId, Status) of
% 			{ok, NewStatus} ->
% 				{ok, BinData} = pt_17:write(?PT_ACTIVATE_TROOP, {TroopTypeId, ?RES_OK}),
%     			lib_send:send_one(Status#player_status.socket, BinData),
%     			lib_player:notify_player_attr_changed(NewStatus), % 主要用于通知总的战斗力改了
%     			% 更新玩家状态
% 		    	{ok, NewStatus}; 
% 			{error, _Why} ->
% 				{ok, BinData} = pt_17:write(?PT_ACTIVATE_TROOP, {TroopTypeId, ?RES_FAIL}),
%     			lib_send:send_one(Status#player_status.socket, BinData)
% 		end
% 	?End;

% %% 排布阵法
% handle(?PT_ARRANGE_TROOP, Status, Bin) ->
%     <<TroopTypeId:32, N:16, Bin2/binary>> = Bin,
%     if 	(byte_size(Bin2) rem 6) /= 0 ->
%     		?ASSERT(false),	% 客户端发过来的阵法排布信息的二进制数据的长度不对
%     		skip;
%     	N == 0 orelse Bin2 == <<>> ->
%     		?ASSERT(false), % 排布信息不应为空
%     		skip;
%     	true ->
%     		ArrangeInfo = bin_to_arrange_info(Bin2, N, []),
%     		?ASSERT(ArrangeInfo /= []),
% 			%%?TRACE("pt: PT_ARRANGE_TROOP, arrange list:~p~n", [ArrangeInfo]),
% 			?Ifc (ArrangeInfo /= [])
% 				case lib_troop:arrange_troop(Status, TroopTypeId, ArrangeInfo) of
% 					{fail} ->
% 					    {ok, BinData} = pt_17:write(?PT_ARRANGE_TROOP, {TroopTypeId, ?RES_FAIL}),
% 						lib_send:send_one(Status#player_status.socket, BinData);
% 					{ok, NewStatus} ->
% 						{ok, BinData} = pt_17:write(?PT_ARRANGE_TROOP, {TroopTypeId, ?RES_OK}),
% 						lib_send:send_one(Status#player_status.socket, BinData),
% 						lib_player:notify_player_attr_changed(NewStatus), % 主要用于通知总的战斗力改了
% 						%%?TRACE("~nafter arrange troop......order list : ~p ~n~n~n", [NewStatus#player_status.battler_list]),
% 						% 更新玩家状态
% 						{ok, NewStatus}
% 				end 
% 			?End
%     end;
			
	
	
% %% 获取阵法详细信息（主要是阵法排布信息）
% handle(?PT_GET_TROOP_DETAIL, Status, TroopTypeId) ->
% 	?TRACE("PT_GET_TROOP_DETAIL: TroopTypeId: ~p~n", [TroopTypeId]),
% 	%%case lists:keyfind(TroopTypeId, 2, Status#player_status.troops) of
% 	case lib_troop:get_my_troop_info(Status, TroopTypeId) of
% 		null ->
% 			?ASSERT(false, TroopTypeId),
% 			skip;
% 		TroopDetail ->
% 			%%case ets:lookup(?ETS_PLAYER_TROOP, TroopId) of
%     		%%	[] ->  % 找不到对应的ets
%     		%%		?ASSERT(false),
%     		%%		void;
%     		%%	[TroopDetail] ->
%     				?ASSERT(TroopDetail#ets_player_troop.player_id =:= Status#player_status.id),
%     				{ok, BinData} = pt_17:write(?PT_GET_TROOP_DETAIL, TroopDetail),
% 					lib_send:send_one(Status#player_status.socket, BinData)
%     		%%end
% 	end;
			
% %% 查询阵法升级cd的剩余时间
% handle(?PT_QRY_UPGRADE_TROOP_CD_LEFT_TIME, Status, _) ->
% 	TimeNow = util:unixtime(),
% 	NextCanUpgradeTroopTime = Status#player_status.next_can_upgrade_troop_time,
% 	case NextCanUpgradeTroopTime =< TimeNow of
% 		true ->
% 			CDLeftTime = 0;
% 		false ->
% 			CDLeftTime = NextCanUpgradeTroopTime - TimeNow
% 	end,
% 	{ok, BinData} = pt_17:write(?PT_QRY_UPGRADE_TROOP_CD_LEFT_TIME, CDLeftTime),
%     lib_send:send_one(Status#player_status.socket, BinData);



% %% 查询当前是否有阵法可以升级（当有变化时，服务端会主动通知）
% handle(?PT_QRY_IF_ANY_TROOP_CAN_UPGRADE, Status, _) ->
% 	lib_troop:check_if_any_troop_can_upg(Status);




% %% ======================================== 武将的相关协议 =========================================================


% %% 从客栈招募武将
% handle(?PT_RECRUIT_PARTNER, Status, PartnerId) ->
% 	?TRACE("recurit par id: ~p~n", [PartnerId]),
%     case lib_partner:recruit_partner_from_hotel(Status, PartnerId) of
%         {fail, Why} ->
%             {ok, BinData} = pt_17:write(?PT_RECRUIT_PARTNER, {Why, 0, 0}),
%     		lib_send:send_one(Status#player_status.socket, BinData),
%             void;
%         {ok, NewPS, PartnerTypeId} ->
%             {ok, BinData} = pt_17:write(?PT_RECRUIT_PARTNER, {?RES_OK, PartnerTypeId, PartnerId}),
%     		lib_send:send_one(Status#player_status.socket, BinData),
%             {ok, NewPS}     
%     end;
	
% %% 获取玩家携带的武将列表（不包括在客栈的）
% handle(?PT_GET_ALIVE_PARTNER_LIST, Status, TargetPlayerId) ->
% 	?TRACE("17051, player id: ~p~n", [TargetPlayerId]),
% 	{ok, BinData} = pt_17:write(?PT_GET_ALIVE_PARTNER_LIST, [Status, TargetPlayerId]),
%     lib_send:send_one(Status#player_status.socket, BinData);
    
% %% 获取玩家放在客栈的武将列表
% handle(?PT_GET_HOTEL_PARTNER_LIST, Status, _) ->
% 	{ok, BinData} = pt_17:write(?PT_GET_HOTEL_PARTNER_LIST, Status),
%     lib_send:send_one(Status#player_status.socket, BinData);

% %% 获取玩家的单个武将的属性信息(暂时只针对携带中的武将，不针对客栈中的)
% handle(?PT_GET_PARTNER_ATTR_INFO, Status, PartnerId) ->
%     case lib_partner:get_partner(PartnerId) of
%         null ->  % 不存在该武将，则不做任何处理
%             ?ASSERT(false, {Status#player_status.id, PartnerId}),
%             skip;
%         PartnerInfo ->
%         	TargetPlayerId = PartnerInfo#ets_partner.player_id,
%         	case TargetPlayerId == Status#player_status.id of
%         		true -> % 查看自己的武将
%         			{ok, BinData} = pt_17:write(?PT_GET_PARTNER_ATTR_INFO, [Status, PartnerInfo]),
%     				lib_send:send_one(Status#player_status.socket, BinData);
%         		false -> % 查看其他人的武将
%         			case lib_player:get_user_info_by_id(TargetPlayerId) of
%             		     [] ->
%             		     	skip;
%             		     TargetStatus ->
%             		     	{ok, BinData} = pt_17:write(?PT_GET_PARTNER_ATTR_INFO, [TargetStatus, PartnerInfo]),
%     						lib_send:send_one(Status#player_status.socket, BinData)
%             		end
%         	end
%     end;
    
    
% %% 获取武将的装备列表
% handle(?PT_GET_PARTNER_EQUIP_LIST, Status, PartnerId) ->
% 	?TRACE("PT_GET_PARTNER_EQUIP_LIST, PartnerId: ~p~n", [PartnerId]),
%     case lib_partner:get_alive_partner(PartnerId) of
%         null ->  % 不存在该武将，则不做任何处理
%             ?ASSERT(false, {Status#player_status.id, PartnerId}),
%             skip;
%         PartnerInfo ->
%             OwnerId = PartnerInfo#ets_partner.player_id,
% 			EquipList = goods_util:get_partner_equip_list(OwnerId, PartnerId),
%             {ok, BinData} = pt_17:write(?PT_GET_PARTNER_EQUIP_LIST, {PartnerId, EquipList}),
%     		lib_send:send_one(Status#player_status.socket, BinData)
%     end;
    
% %% 获取武将的配置数据
% handle(?PT_GET_PARTNER_CFG_DATA, Status, PartnerTypeId) ->
%     case data_partner:get(PartnerTypeId) of
%         null ->  % 不存在该武将，则跳过
%             skip;
%         ParData ->
%             {ok, BinData} = pt_17:write(?PT_GET_PARTNER_CFG_DATA, ParData),
%     		lib_send:send_one(Status#player_status.socket, BinData)
%     end;
    
    
% %% 武将离队（把武将寄放到客栈）
% handle(?PT_DEPOSIT_PARTNER, Status, PartnerId) ->
%     case lib_partner:get_alive_partner(PartnerId) of
%         null ->  % 非法：武将不存在
%             ?ASSERT(false, {Status#player_status.id, PartnerId}),
%             skip;
%         ParInfo ->
%         	if
%         		ParInfo#ets_partner.player_id =/= Status#player_status.id -> % 非法：武将不是玩家自己的
%         			?ASSERT(false),
%         			skip;
%         		ParInfo#ets_partner.state =/= ?PAR_STATE_ALIVE ->  % 非法：武将状态不是被玩家携带中
%         			?ASSERT(false, ParInfo#ets_partner.state),
%         			skip;
%         		%%length(Status#player_status.par_alive) =:= 1 ->  % 最后一个携带中的武将不能离队
%         		%%	?TRACE("can not deposit: it is the last alive partner.~n"),
%         		%%	skip;
%         		true ->
%         			case lib_partner:deposit_partner_to_hotel(Status, ParInfo) of
%         				{ok, NewStatus} ->
%         					{ok, BinData} = pt_17:write(?PT_DEPOSIT_PARTNER, [?RES_OK, ParInfo]),
%     						lib_send:send_one(Status#player_status.socket, BinData),
%     						lib_player:notify_player_attr_changed(NewStatus), % 主要用于通知总的战斗力改了
%     						% 更新玩家状态
%     						{ok, NewStatus};
%         				{fail} ->
%         					{ok, BinData} = pt_17:write(?PT_DEPOSIT_PARTNER, [?RES_FAIL, ParInfo]),
%     						lib_send:send_one(Status#player_status.socket, BinData)
%         			end
%         	end
%     end;
    
    
% %% 武将归队（从客栈取回武将）
% handle(?PT_WITHDRAW_PARTNER, Status, PartnerId) ->
%     case lib_partner:get_hotel_partner(PartnerId) of
%         null ->  % 非法：武将不存在
%             ?ASSERT(false),
%             skip;
%         ParInfo ->
%         	?ASSERT(PartnerId =:= ParInfo#ets_partner.id),
%         	case lib_partner:get_my_alive_partner_count(Status) < ?MAX_ALIVE_PARTNER_COUNT of
%         		false -> % 当前携带的武将数量已达上限
%         			{ok, BinData} = pt_17:write(?PT_WITHDRAW_PARTNER, [?PAR_WITHDRAW_FAIL_ALIVE_PAR_COUNT_MAX, ParInfo]),
%     				lib_send:send_one(Status#player_status.socket, BinData);
%         		true ->
%         			if
%         				ParInfo#ets_partner.player_id =/= Status#player_status.id -> % 非法：武将不是玩家自己的
%         					?ASSERT(false), skip;
%         				ParInfo#ets_partner.state =/= ?PAR_STATE_DORMANT ->  % 非法：武将不是离队状态
%         					?ASSERT(false), skip;
%         				true ->
%         					case lib_partner:withdraw_partner_from_hotel(Status, ParInfo) of
%         						{ok, NewStatus} ->
%         							{ok, BinData} = pt_17:write(?PT_WITHDRAW_PARTNER, [?RES_OK, ParInfo]),
%     								lib_send:send_one(Status#player_status.socket, BinData),
%     								% 更新玩家状态
%     								{ok, NewStatus};
%         						{fail} ->
%         							{ok, BinData} = pt_17:write(?PT_WITHDRAW_PARTNER, [?RES_FAIL, ParInfo]),
%     								lib_send:send_one(Status#player_status.socket, BinData)
%         					end
%         			end
%         	end
%     end;

% %%武将精力检测
% handle(?PT_ENERGY_NOT_ENOUGH, Status, []) ->
% 	lib_partner:check_partner_energy(Status);

% %%武将喂食
% handle(?PT_FEED, Status, [PartnerId]) ->
% 	case lib_partner:get_alive_partner(PartnerId) of
%         null ->  % 非法：武将不存在
% 			?ERROR_MSG("Partner: feed partner id = ~p not exist", [PartnerId]),
% 			?ASSERT(false),
% 			{ok, BinData} = pt_17:write(?PT_FEED, [2, 0, 0, ?INIT_MAX_ENERGY, 0]),
% 			lib_send:send_one(Status#player_status.socket, BinData);
% 		Partner ->
% 			{Flag, EneLim, EneCur} = lib_partner:feed_partner(Status, Partner),
% 			ItemId = lib_partner:get_food_by_partner_quality(Partner#ets_partner.quality),
% 			{ok, BinData} = pt_17:write(?PT_FEED, [Flag, PartnerId, ItemId, EneLim, EneCur]),
% 			lib_send:send_one(Status#player_status.socket, BinData)
% 	end;


% %% ======================================== 武将训练 ===============================================

% %%武将列表
% handle(?PT_PARTNER_LIST, Status, []) ->
% 	PartnerList = lib_partner:get_my_alive_partner_list(Status),
% 	FightList = lib_partner:get_my_fighting_partner_list(Status),
% 	RestList = PartnerList -- FightList,
% 	?TRACE("~p  partner list is ~p~n", [?PT_PARTNER_LIST, PartnerList]),
% 	Length = length(PartnerList),
% 	{ok, BinData} = pt_17:write(?PT_PARTNER_LIST, [Length, RestList, FightList]),
% 	lib_send:send_one(Status#player_status.socket, BinData);

% %%新训练武将信息
% handle(?PT_TRAINING_PARTNER_INFO, Status, [PartnerId, TimeType]) ->
% 	{Partner, _Time, _SoureExp, ExpType, Exp, ForecastLv, Coin} = 
% 		lib_partner:get_training_info(Status, PartnerId, TimeType),
% 	?TRACE("~p  Partner=~p, _Time=~p, _SoureExp=~p, ExpType=~p, Exp=~p, ForecastLv=~p, Coin=~p~n", 
% 		   [?PT_TRAINING_PARTNER_INFO, Partner, _Time, _SoureExp, ExpType, Exp, ForecastLv, Coin]),
% 	Flag = case lib_partner:is_fighting(Status, PartnerId) of
% 			   true ->
% 				   3;
% 			   _ ->
% 				   case Partner#ets_partner.training of
% 					   0 ->
% 						   1;
% 					   1 ->
% 						   2;
% 					   2 ->
% 						   4
% 				   end
% 		   end,
% 	NowTime = util:unixtime(),
% 	LeftTime = case Partner#ets_partner.end_training_time >= NowTime of
% 				   true ->
% 					   Partner#ets_partner.end_training_time - NowTime;
% 				   _ ->
% 					   0
% 			   end,
% 	{ok, BinData} = pt_17:write(?PT_TRAINING_PARTNER_INFO, [Partner, ForecastLv, Exp, ExpType, Coin, Flag, LeftTime]),
% 	lib_send:send_one(Status#player_status.socket, BinData);

% %%开始训练武将
% handle(?PT_TRAINING_PARTNER, Status, [PartnerId, TimeType]) ->
% 	{Training, _Resting} = lib_partner:get_training_partner(Status),
% 	case length(Training) >= Status#player_status.training_position_num of
% 		true ->
% 			{ok, BinData} = pt_17:write(?PT_TRAINING_PARTNER, [4]),
% 			lib_send:send_one(Status#player_status.socket, BinData),
% 			{ok, Status};
% 		_ ->
% 			{Partner, Time, _SoureExp, _ExpType, _Exp, ForecastLv, Coin} = 
% 				lib_partner:get_training_info(Status, PartnerId, TimeType),
% %% 			TempTime = util:ceil(Time / 360),
% 			{Flag, NewStatus} = lib_partner:training_partner(Status, Partner, Time, ForecastLv, Coin),
			
% 			%% 训练武将任务
% 			lib_task:event(partner_train, 1, NewStatus),
% 			?TRACE("~p  the Flag is ~p~n", [?PT_TRAINING_PARTNER, Flag]),
% 			{ok, BinData} = pt_17:write(?PT_TRAINING_PARTNER, [Flag]),
% 			lib_send:send_one(NewStatus#player_status.socket, BinData),
% 			{ok, NewStatus}
% 	end;


% %%训练位信息
% handle(?PT_TRAINING_PARTNER_PANEL, Status, []) ->
% 	PositionLimit = data_partner_training:get_training_position_limit(),
% 	PositionNum = Status#player_status.training_position_num,
% 	Gold = data_partner_training:expand_position_gold(),
% 	{Training, _Resting} = lib_partner:get_training_partner(Status),
% 	UsePosition = length(Training),
% 	?TRACE("~p  PositionLimit=~p, PositionNum=~p, Gold=~p, UsePosition=~p", 
% 		   [?PT_TRAINING_PARTNER_PANEL, PositionLimit, PositionNum, Gold, UsePosition]),
% 	{ok, BinData} = pt_17:write(?PT_TRAINING_PARTNER_PANEL, [PositionLimit, PositionNum, UsePosition, Gold]),
% 	lib_send:send_one(Status#player_status.socket, BinData);


% %%开启新训练位
% handle(?PT_OPEN_NEW_TRAINING, Status, [Type]) ->
% 	{Flag, NewStatus} = lib_partner:open_training_position(Status, Type),
% 	?TRACE("~p  Flag=~p", [?PT_OPEN_NEW_TRAINING, Flag]),
% 	{ok, BinData} = pt_17:write(?PT_OPEN_NEW_TRAINING, [Flag]),
% 	lib_send:send_one(NewStatus#player_status.socket, BinData),
% 	{ok, NewStatus};

% %%获取训练中的武将在当前时间可获得的经验
% handle(?PT_GET_PARTNER_EXP, Status, [PartnerId]) ->
% 	?TRACE("?PT_GET_PARTNER_EXPG\n"),
% 	Partner = lib_partner:get_partner(PartnerId),
% 	Exp = lib_partner:get_current_exp(Partner, Status#player_status.lv),
% 	{ok, BinData} = pt_17:write(?PT_GET_PARTNER_EXP, [Exp]),
% 	lib_send:send_one(Status#player_status.socket, BinData);


% %%结束训练武将 
% handle(?PT_STOP_TRAINING, Status, [PartnerId]) ->
% 	?TRACE("?PT_STOP_TRAINING\n"),
% 	Partner = lib_partner:get_partner(PartnerId),
% 	{Flag, Exp} = lib_partner:stop_training(Status, Partner),
% 	?TRACE("~p  Flag=~p, Exp=~p~n", [?PT_STOP_TRAINING, Flag, Exp]),
% 	{ok, BinData} = pt_17:write(?PT_STOP_TRAINING, [Flag, Exp]),
% 	lib_send:send_one(Status#player_status.socket, BinData);


% %%查询当前时间快速完成训练需要的元宝数
% handle(?PT_QUERY_TRAINING_GOLD, Status, [PartnerId]) ->
% 	Partner = lib_partner:get_partner(PartnerId),
% 	Gold = lib_partner:get_gold_by_fast_training(Partner),
% 	{ok, BinData} = pt_17:write(?PT_QUERY_TRAINING_GOLD, [Gold]),
% 	lib_send:send_one(Status#player_status.socket, BinData);


% %%快速训练
% handle(?PT_FAST_TRAINING, Status, [PartnerId, Type]) ->
% 	?TRACE("17088\n"),
% 	Partner = lib_partner:get_partner(PartnerId),
% 	{Flag, Exp, NewStatus} = lib_partner:fast_training(Status, Partner, Type),
% 	{ok, BinData} = pt_17:write(?PT_FAST_TRAINING, [Flag, Exp]),
% 	lib_send:send_one(NewStatus#player_status.socket, BinData),
% 	{ok, NewStatus};


% %%训练完成 
% handle(?PT_CONCULE_TRAINING, Status, [PartnerId]) ->
% 	Partner = lib_partner:get_partner(PartnerId),
% 	{Flag, LeftTime} = lib_partner:time_up_training(Partner),
% 	?TRACE("17089  Flag=~p, LeftTime=~p~n", [Flag, LeftTime]),
% 	{ok, BinData} = pt_17:write(?PT_CONCULE_TRAINING, [Flag, LeftTime]),
% 	lib_send:send_one(Status#player_status.socket, BinData);


% %%幸运签
% handle(?PT_LUCKY_TICKET, Status, [AutoBuy]) ->
% 	{Flag, NewStatus} = lib_partner:use_lucky_ticket(Status, AutoBuy),
% 	?TRACE("~p  Flag=~p~n", [?PT_LUCKY_TICKET, Flag]),
% 	{ok, BinData} = pt_17:write(?PT_LUCKY_TICKET, [Flag]),
% 	lib_send:send_one(NewStatus#player_status.socket, BinData),
% 	{ok, NewStatus};


% %%玩家操作完成训练 
% handle(?PT_OPERATE_CONCULE, Status, [PartnerId]) ->
% 	Partner = lib_partner:get_partner(PartnerId),
% 	{Flag, Exp} = lib_partner:finish_training(Status, Partner),
% 	?TRACE("17091  Flag=~p, Exp=~p~n", [Flag, Exp]),
% 	{ok, BinData} = pt_17:write(?PT_OPERATE_CONCULE, [Flag, Exp]),
% 	lib_send:send_one(Status#player_status.socket, BinData);



% %% ======================================== 武将跟随 ===============================================

% %%-------------- 选择武将跟随 ----------------
% handle(?PT_FOLLOW, Status, [PartnerId]) ->
% 	?TRACE("17095\n"),
% 	Vip = Status#player_status.vip,
% 	FollowNum = lib_partner:get_follow_partner_num_limit(Vip),
% 	Partner = lib_partner:get_alive_partner(PartnerId),
% 	case FollowNum > 0 andalso Partner =/= [] of
% 		true ->
% 			?TRACE("can follow\n"),
% 			{Flag, CancelId, NewStatus} = lib_partner:partner_follow(Status, PartnerId, FollowNum),
% 			?TRACE("Flag=~p, CancelId=~p PartnerId=~p~n", [Flag, CancelId, PartnerId]),
% 			{ok, BinData} = pt_17:write(?PT_FOLLOW, 
% 										[Flag, PartnerId, Partner#ets_partner.name, 
% 										 Partner#ets_partner.par_type_id, CancelId]),
% 			lib_send:send_one(Status#player_status.socket, BinData),
% 			lib_partner:notify_follow_partner(NewStatus),
% 			{ok, NewStatus};
% 		_ ->
% 			{ok, BinData} = pt_17:write(?PT_FOLLOW, 2, 0, <<>>, 0, 0),
% 			lib_send:send_one(Status#player_status.socket, BinData),
% 			{ok, Status}
% 	end;


% %%-------------- 取消武将跟随 ----------------	
% handle(?PT_FOLLOW_CANCEL, Status, [PartnerId]) ->	
% 	?TRACE("17096\n"),
% 	{Flag, NewStatus} = lib_partner:cancel_partner_follow(Status, PartnerId),
% 	{ok, BinData} = pt_17:write(?PT_FOLLOW_CANCEL, [Flag, PartnerId]),
% 	lib_send:send_one(Status#player_status.socket, BinData),
% 	lib_partner:notify_follow_partner(NewStatus),
% 	{ok, NewStatus};

% handle(_, _Status, _) ->
% 	?ASSERT(false),
% 	void.
  
    







% %%
% %%================================= Local Functions ==============================================
% %%

% bin_to_arrange_info(Data, N, R) when N > 0 ->
% 	<<Type:8, Id:32, Pos:8, Tail/binary>> = Data,
% 	R1 = [{Type, Id, Pos} | R],
% 	bin_to_arrange_info(Tail,N-1,R1);
% bin_to_arrange_info(_Data, _N, R) ->
% 	lists:reverse(R).

