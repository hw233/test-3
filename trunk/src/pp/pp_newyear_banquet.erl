%%%------------------------------------
%%% @author liufang <529132738@qq.com>
%%% @copyright UCweb 2015.01.07
%%% @doc 年夜宴会
%%% @end
%%%------------------------------------

-module(pp_newyear_banquet).
-export([handle/3]).

-include("common.hrl").
-include("record.hrl").
-include("player.hrl").
-include("prompt_msg_code.hrl").
-include("log.hrl").
-include("ets_name.hrl").
-include("protocol/pt_36.hrl").
-include("newyear_banquet.hrl").
-include("reward.hrl").
-include("ernie.hrl").
-include("admin_activity.hrl").

-define(ERNIE_TIME, {pp_ernie, ernie_time}). % 用来记录玩家上一次抽奖时间

%% 进入新年宴会场景
handle(?PT_NEWYEAR_BANQUET_ENTER_SCENE, PS, []) ->
    ?ylh_Debug("newyear_banquet_enter_scene ~p~n", [player:id(PS)]),
    case player:is_idle(PS) of
        false -> lib_send:send_prompt_msg(PS, ?PM_BUSY_NOW);
        true ->
            case lib_newyear_banquet:get_newyear_banquet_scene_status() of
                Status when Status#ets_newyear_banquet_scene_status.open_status =:= 1 ->
                    lib_newyear_banquet:enter_newyear_banquet_scene(PS);  
                _ ->
                    lib_send:send_prompt_msg(PS, ?PM_NEWYEAR_BANQUET_SCENE_IS_NOT_OPEN) 
            end
    end;       

%% 退出新年宴会场景 
handle(?PT_NEWYEAR_BANQUET_LEAVE_SCENE, PS, []) ->
    lib_newyear_banquet:newyear_banquet_leave_scene(PS);

%% 年夜宴会界面信息
handle(?PT_GET_NEWYEAR_BANQUET, PS, []) ->
    case lib_newyear_banquet:check_newyear_banquet_is_open() of
        {error, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        ok ->
            case catch mod_newyear_banquet:get_newyear_banquet_state() of
                NewyearBanquet = #newyear_banquet_state{} ->
                    case NewyearBanquet#newyear_banquet_state.status =:= ?BANQUET_STATUS_OPEN of
                        true ->
                            Banquet_lv = NewyearBanquet#newyear_banquet_state.banquet_lv,
                            Banquet_exp = NewyearBanquet#newyear_banquet_state.banquet_exp,
                            Refresh_time = NewyearBanquet#newyear_banquet_state.refresh_time,
                            % Player_Banquet = case dict:find(player:id(PS), NewyearBanquet#newyear_banquet_state.add_dish_players) of
                            %                     {ok, Value} ->
                            %                         Value;
                            %                     error ->
                            %                         {player:get_name(PS), 0, 0, 0, 0}
                            %                 end,
                            % {_, My_dish_num1, My_dish_num2, My_dish_num3, _} = Player_Banquet,
                            %求得当前可加菜次数
                            My_dish_num1 = case dict:find(?DISH_1, NewyearBanquet#newyear_banquet_state.add_limit_times) of
                                                {ok, Value1} ->
                                                    Value1;
                                                error ->
                                                    0
                                            end,
                            My_dish_num2 = case dict:find(?DISH_2, NewyearBanquet#newyear_banquet_state.add_limit_times) of
                                                {ok, Value2} ->
                                                    Value2;
                                                error ->
                                                    0
                                            end,
                            My_dish_num3 = case dict:find(?DISH_3, NewyearBanquet#newyear_banquet_state.add_limit_times) of
                                                {ok, Value3} ->
                                                    Value3;
                                                error ->
                                                    0
                                            end,
                            %获得加菜排行榜数据
                            Array1 = lib_newyear_banquet:get_newyear_banquet_rank(NewyearBanquet#newyear_banquet_state.add_dish_players),
                            %获得最新的加菜记录
                            Array2 = lib_newyear_banquet:get_newyear_banquet_log(NewyearBanquet#newyear_banquet_state.add_dish_logs),
                            % ?ylh_Debug("PT_GET_NEWYEAR_BANQUET Array1=~p ~n", [Array1]),
                            % ?ylh_Debug("PT_GET_NEWYEAR_BANQUET Array2=~p ~n", [Array2]),
                            {ok, BinData} = pt_36:write(?PT_GET_NEWYEAR_BANQUET, [Banquet_lv, Banquet_exp, Refresh_time, My_dish_num1, My_dish_num2, My_dish_num3, Array1, Array2]),
                            lib_send:send_to_sock(PS, BinData);
                        false ->
                            lib_send:send_prompt_msg(PS, ?PM_NEWYEAR_BANQUET_IS_NOT_OPEN)
                    end;
                _ ->
                    lib_send:send_prompt_msg(PS, ?PM_NEWYEAR_BANQUET_SYS_ERR)
            end
    end;

handle(?PT_ADD_NEWYEAR_DISHES, PS, [DishesNo, Num]) ->
    ?ASSERT(lists:member(DishesNo, [1,2,3]), DishesNo),
    ?ylh_Debug("PT_ADD_NEWYEAR_DISHES, DishesNo=~p, Num=~p ~n", [DishesNo, Num]),
    case catch lib_newyear_banquet:check_newyear_banquet_add_dishes(PS, DishesNo, Num) of
        {error, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        ok ->
            %计算消耗的绑银或元宝
            case DishesNo of 
                ?DISH_1 ->
                    CostManey = lib_newyear_banquet:get_cfg_need_gamemoney(?DISH_1) * Num,
                    player_syn:cost_money(PS, ?MNY_T_BIND_GAMEMONEY, CostManey, [?LOG_NEWYEAR_BANGQUET, "addDish"]);
                ?DISH_2 ->
                    CostManey = lib_newyear_banquet:get_cfg_need_yuanbao(?DISH_2) * Num,
                    player_syn:cost_money(PS, ?MNY_T_YUANBAO, CostManey, [?LOG_NEWYEAR_BANGQUET, "addDish"]);
                ?DISH_3 ->
                    CostManey = lib_newyear_banquet:get_cfg_need_yuanbao(?DISH_3) * Num,
                    player_syn:cost_money(PS, ?MNY_T_YUANBAO, CostManey, [?LOG_NEWYEAR_BANGQUET, "addDish"])
            end,

            %发放物品奖励
            case data_newyear_banquet:get(DishesNo) of
                D when is_record(D, newyear_dishes) -> 
                    %发放普通奖励
                    NormalGoods = D#newyear_dishes.normal_goods,
                    %物品ID， 数量，品质，绑定状态
                    F = fun(GoodsNo, GoodsCount, Quality, BindState) ->
                           mod_inv:batch_smart_add_new_goods(player:get_id(PS),
                                                      [{GoodsNo, GoodsCount}],
                                                      [{quality, Quality}, {bind_state, BindState}],
                                                      [?LOG_NEWYEAR_BANGQUET, GoodsNo]) 
                    end,
                    [F(GoodsNo, GoodsCount, Quality, BindState) || {GoodsNo, GoodsCount, Quality, BindState} <- NormalGoods],

                    %发放贵重物品
                    SpecialGoods = D#newyear_dishes.special_goods,
                    case SpecialGoods of
                        0 ->
                            %统计玩家加菜信息
                            lib_log:statis_role_action(PS, [], "newyear_banquet", "newyear_banquet_add_dish", [DishesNo, Num, 0]),
                            skip;
                        _ ->
                            % 随机特殊事件 （目前只要求一个事件）
                            {No, _} = util:rand_by_weight(SpecialGoods, 2),
                            case No > 0 of
                                false ->
                                    %统计玩家加菜信息
                                    lib_log:statis_role_action(PS, [], "newyear_banquet", "newyear_banquet_add_dish", [DishesNo, Num, 0]),
                                    skip;
                                true ->
                                    #reward_dtl{calc_goods_list=GList} = mod_reward_pool:calc_reward(No, PS),
                                    F1 = fun({GoodsNo, GoodsCount, Quality, BindState,NeedBroadcast}, _) ->
                                            %全服公告
                                            case NeedBroadcast of
                                                0 -> skip;
                                                _ -> mod_broadcast:send_sys_broadcast(NeedBroadcast, [player:get_name(PS), player:id(PS), GoodsNo, Quality, GoodsCount,0])
                                            end,
                                            % ply_tips:send_sys_tips(PS, {newyear_banquet_get_special_goods, [player:get_name(PS), player:get_id(PS),GoodsNo,Quality,GoodsCount,0]}),
                                            mod_inv:batch_smart_add_new_goods(player:get_id(PS),
                                                                      [{GoodsNo, GoodsCount}],
                                                                      [{quality, Quality}, {bind_state, BindState}],
                                                                      [?LOG_NEWYEAR_BANGQUET, GoodsNo])
                                        end,
                                    lists:foldl(F1, 0, GList),
                                    %统计玩家加菜信息
                                    lib_log:statis_role_action(PS, [], "newyear_banquet", "newyear_banquet_add_dish", [DishesNo, Num, 1])
                            end
                    end;       
                _ -> 
                    ?ASSERT(false),
                    error
            end,

            
            % 已加菜信息
            % 使用金子加菜后，第1次或使用10次加菜时，均会以公告的方式通知全服玩家。
            {_Name, _Dish1, Dish2, Dish3, _} = lib_newyear_banquet:get_newyear_banquet_add_dish_info(PS),

             % 记录加菜信息
            mod_newyear_banquet:newyear_banquet_add_dish(PS, DishesNo, Num),

            NewyearBanquet = mod_newyear_banquet:get_newyear_banquet_state(),    
            Banquet_lv = NewyearBanquet#newyear_banquet_state.banquet_lv,
            Banquet_exp = NewyearBanquet#newyear_banquet_state.banquet_exp,
            {ok, BinData} = pt_36:write(?PT_ADD_NEWYEAR_DISHES, [Banquet_lv, Banquet_exp]),
            lib_send:send_to_sock(PS, BinData),
            case (DishesNo == ?DISH_2 orelse DishesNo == ?DISH_3) andalso Dish2 == 0 andalso Dish3 == 0 of 
                false ->
                    skip;
                true ->
                    ply_tips:send_sys_tips(PS, {newyear_banquet_add_dish, [player:get_name(PS), player:get_id(PS), Num, lib_newyear_banquet:get_cfg_dish_name(DishesNo)]})
            end,

            if
                DishesNo == ?DISH_2 andalso (Dish2+Num) == 30 ->
                    ply_tips:send_sys_tips(PS, {newyear_banquet_add_dish, [player:get_name(PS), player:get_id(PS), 30, lib_newyear_banquet:get_cfg_dish_name(DishesNo)]});
                DishesNo == ?DISH_3 andalso (Dish3+Num) == 10 ->
                    ?ylh_Debug("Dish3=~p~n", [Dish3]),
                    ply_tips:send_sys_tips(PS, {newyear_banquet_add_dish, [player:get_name(PS), player:get_id(PS), 10, lib_newyear_banquet:get_cfg_dish_name(DishesNo)]});
                true ->
                    skip
            end
    end;


%%-----------------------------------------------------------------------------------------------
%% 日常活动幸运转盘
%%-----------------------------------------------------------------------------------------------
%% 打开幸运轮盘抽奖面板
handle(?PT_ERNIE_INFO, PS, []) ->
    case player:is_idle(PS) of
        false -> lib_send:send_prompt_msg(PS, ?PM_BUSY_NOW);
        true ->
            % 得到最近10次抽奖记录
            case lib_ernie:get_ernie_reward_logs() of
                {ok, RewardLogsList} ->
                    RewardList = lib_ernie:get_ernie_reward_goods_info(),
                    ErnieTimes = lib_ernie:get_ernie_player_times(PS),
                    {ok, BinData} = pt_36:write(?PT_ERNIE_INFO, [ErnieTimes, RewardLogsList, RewardList]),
                    lib_send:send_to_sock(PS, BinData);
                {error, not_open} -> lib_send:send_prompt_msg(PS, ?PM_NEWYEAR_BANQUET_SYS_ERR);
                {error, sys_err} -> lib_send:send_prompt_msg(PS, ?PM_F_ACT_NOT_START)
            end
    end;       

%% 抽奖 
handle(?PT_ERNIE_GET, PS, []) ->
    case player:is_idle(PS) of
        false -> lib_send:send_prompt_msg(PS, ?PM_BUSY_NOW);
        true ->
            %防止抽奖时间太快
            CurTime = util:unixtime(),
            IsCan = case get(?ERNIE_TIME) of
                        Value when (CurTime - Value) >= 5 -> true;
                        undefined -> true;
                        _ -> false
                    end,
            case IsCan of
                true ->
%%                     ErnieTimes = lib_ernie:get_ernie_player_times(PS),
%%                     case ErnieTimes > 0 orelse true of %% 不判断次数，改成判断是否有消耗道具 2017.8.28 --zjy
					   case lib_ernie:check_cost(player:id(PS)) of
						   true ->
							   case lib_ernie:do_get_ernie_reward() of
								   {ok, No, Reward} -> 
									   [{GoodsNo, GoodsCount, Quality, BindState}] = Reward,
									   case lib_beauty_contest:check_beauty_contest_give_reward(PS, GoodsNo, GoodsCount) of
										   ok ->
                                               mod_achievement:notify_achi(use_ernie, [], PS),
											   put(?ERNIE_TIME, CurTime),
											   {ok, BinData} = pt_36:write(?PT_ERNIE_GET, [0, No]),
											   lib_send:send_to_sock(PS, BinData),
											   mod_ernie:ernie_counter(PS, GoodsNo, GoodsCount, Quality, BindState),
											   %% 不扣减次数，改为消耗道具
											   %%                                             lib_ernie:sub_ernie(player:id(PS)),
											   lib_ernie:do_cost(player:id(PS)),
											   %% 保存已抽取的物品编号和抽取时间戳
											   lib_ernie:update_ernie_record_data(No),
											   mod_inv:batch_smart_add_new_goods(player:id(PS),
																				 [{GoodsNo, GoodsCount}],
																				 [{quality, Quality}, {bind_state, BindState}],
																				 [?LOG_ERNIE, "ernie"]),
											   %% 发送系统公告
											   case data_ernie:get(No) of
												   #ernie_reward_data{notice = Notice} when Notice > 0 ->
													   ply_tips:send_sys_tips(PS, Notice, [player:get_name(PS), player:id(PS), GoodsNo, Quality, GoodsCount,0]);
												   _ ->
													   ok
											   end,
											   %统计玩家奖励信息
											   lib_log:statis_role_action(PS, [], "ernie", "ernie_reward_info", [player:get_name(PS), player:get_vip_lv(PS), player:get_lv(PS), GoodsNo, CurTime]);
										   {error, _} ->
											   {ok, BinData} = pt_36:write(?PT_ERNIE_GET, [4, 0]),
											   lib_send:send_to_sock(PS, BinData)
									   end;
								   {error, not_open} -> 
									   {ok, BinData} = pt_36:write(?PT_ERNIE_GET, [1, 0]),
									   lib_send:send_to_sock(PS, BinData);
								   {error, sys_err} -> 
									   {ok, BinData} = pt_36:write(?PT_ERNIE_GET, [2, 0]),
									   lib_send:send_to_sock(PS, BinData);
								   _ -> ?ASSERT(false), 
										{ok, BinData} = pt_36:write(?PT_ERNIE_GET, [2, 0]),
										lib_send:send_to_sock(PS, BinData)
							   end;
						   false ->
							   {ok, BinData} = pt_36:write(?PT_ERNIE_GET, [5, 0]),
							   lib_send:send_to_sock(PS, BinData)
					   end;
                false ->
                    {ok, BinData} = pt_36:write(?PT_ERNIE_GET, [3, 0]),
                    lib_send:send_to_sock(PS, BinData)
            end         
     end; 

%% 查看抽奖次数
handle(?PT_ERNIE_NOTIFY, PS, []) ->
    ErnieTimes = lib_ernie:get_ernie_player_times(PS),
    {ok, BinData} = pt_36:write(?PT_ERNIE_NOTIFY, [ErnieTimes]),
    lib_send:send_to_sock(PS, BinData);

handle(?PT_ENTER_LUCKY_DRAW, PS, [Type]) ->
    PlayerId = player:get_id(PS),

    case Type of
        3 ->
            case lib_newyear_banquet:get_player_lottery_info(PS) of
                null ->
                    Lottery = #player_lottery_info{
                        player_id = PlayerId,
                        token = 0,
                        free_time = 0,
                        time = 0,
                        reward = []
                    },
                    lib_newyear_banquet:db_insert_player_lottery(PS, Lottery),
                    lib_newyear_banquet:update_player_lottery(Lottery);
                Lottery ->
                    Lottery
            end,
            Rank = lib_newyear_banquet:get_player_time_limit_rank(player:get_id(PS)),
            {ok, BinData} = pt_36:write(?PT_ENTER_LUCKY_DRAW, [Lottery#player_lottery_info.free_time,
                Lottery#player_lottery_info.token, Rank, Lottery#player_lottery_info.reward]),
            lib_send:send_to_sock(PS, BinData);
        _ ->
            IsOnLottery = lib_newyear_banquet:get_is_on_lottery_data(),
            ?ASSERT(length(IsOnLottery) =:= 1),
            lib_newyear_banquet:do_luck_draw(PS, Type)
    end;

%% 限时转盘排行榜
handle(?PT_LUCKY_PLAYER_RANK, PS, [Type]) ->
    lib_newyear_banquet:send_time_limit_rank_to_client(Type,PS);


%% 发送限时转盘排名奖励展示
handle(?PT_LUCKY_RANK_AWARD, PS, []) ->
     PanList = ets:tab2list(?ETS_ADMIN_SYS_ACTIVITY_BRIEF), 
	 Fp = fun(Activity) -> 
            case util:unixtime() >= Activity#admin_sys_activity_brief.end_time orelse Activity#admin_sys_activity_brief.state =/= 1 of
                true ->
					skip;
                false -> 
					case ets:lookup(?ETS_ADMIN_SYS_ACTIVITY, Activity#admin_sys_activity_brief.order_id) of
						[Activity2] when is_record(Activity2, admin_sys_activity)  ->
							case Activity2#admin_sys_activity.sys =:= 15 of
								true ->
									Content = Activity2#admin_sys_activity.content,
									{_Title, _Cont, Gifts} = Content,
									Fb = fun({{Min, Max}, Goods,TokenCount},AccFb) ->
												 F2 = fun({No,_BindState,Count}, Acc2) ->
															  [{No,Count} | Acc2 ]
													  end,
												 GoodsNo = lists:foldl(F2, [], Goods),
												 [{Min, Max, TokenCount, GoodsNo} | AccFb]
										 end,	 
									GoodsNo = lists:foldl(Fb, [], Gifts),
									{ok, BinData} = pt_36:write(?PT_LUCKY_RANK_AWARD, [GoodsNo]),
									lib_send:send_to_sock(PS, BinData);
								false ->
									skip
							end;
						_T -> 
							?ERROR_MSG("[admin_sys_activity] open admin_activity id = ~p error = ~p~n", [15, _T]),
							?ASSERT(false, [_T])
					end
            end
		  end,
	 
	 lists:foreach(Fp, PanList);
    


handle(?PT_GET_LOTTERY_REWARD, PS, [Step]) ->
    RewardList =
        case lib_newyear_banquet:get_lottery_box_data(15) of
            null ->
                [];
            List ->
                List
        end,
    mod_newyear_banquet:deal_player_lottery_reward(PS, Step, RewardList);


handle(_Msg, _PS, _) ->
    ?WARNING_MSG("unknown handle ~p", [_Msg]),
    error.


