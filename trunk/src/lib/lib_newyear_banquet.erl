%%%------------------------------------
%%% @author liufang <529132738@qq.com>
%%% @copyright UCweb 2015.01.08
%%% @doc 新年宴会 函数库.
%%% @end
%%%------------------------------------

-module(lib_newyear_banquet).

-include("common.hrl").
-include("record.hrl").
-include("prompt_msg_code.hrl").
-include("ets_name.hrl").
-include("log.hrl").
-include("goods.hrl").
-include("task.hrl").
-include("player.hrl").
-include("newyear_banquet.hrl").
-include("activity_degree_sys.hrl").
-include("abbreviate.hrl").
-include("protocol/pt_36.hrl").
-include("sys_code_2.hrl").
-include("admin_activity.hrl").

-compile(export_all).
-export([send_time_limit_rank_to_client/2,
		 get_player_time_limit_rank/1,
		 get_time_limit_rank/0,
		 set_time_limit_rank/0]).

% 配置操作
%绑银
get_cfg_need_gamemoney(No) ->
    case data_newyear_banquet:get(No) of
        D when is_record(D, newyear_dishes) -> D#newyear_dishes.need_gamemoney;
        _ -> error
    end.
%元宝
get_cfg_need_yuanbao(No) ->
    case data_newyear_banquet:get(No) of
        D when is_record(D, newyear_dishes) -> D#newyear_dishes.need_yuanbao;
        _ -> error
    end.
%加菜限制
get_cfg_dish_limit(No) ->
    case data_newyear_banquet:get(No) of
        D when is_record(D, newyear_dishes) -> D#newyear_dishes.dish_limit;
        _ -> error
    end.
%加菜宴会经验增加值
get_cfg_exp_add(No) ->
    case data_newyear_banquet:get(No) of
        D when is_record(D, newyear_dishes) -> D#newyear_dishes.exp_add;
        _ -> error
    end.

%得到菜名
get_cfg_dish_name(No) ->
    case data_newyear_banquet:get(No) of
        D when is_record(D, newyear_dishes) -> D#newyear_dishes.name;
        _ -> error
    end.


%当前档次宴会所需要经验
get_cfg_banquet_exp(Lv) ->
    case data_newyear_banquet:config(Lv) of
        D when is_record(D, newyear_banquet_lv) -> D#newyear_banquet_lv.banquet_exp;
        _ -> error
    end.

%当前宴会档次系统增加经验临界值
get_cfg_banquet_exp_limit(Lv) ->
    case data_newyear_banquet:config(Lv) of
        D when is_record(D, newyear_banquet_lv) -> D#newyear_banquet_lv.banquet_exp_limit;
        _ -> error
    end.

%得到当前档次物品奖励
get_cfg_banquet_items(Lv) ->
    case data_newyear_banquet:config(Lv) of
        D when is_record(D, newyear_banquet_lv) -> D#newyear_banquet_lv.banquet_player_item;
        _ -> error
    end.

%得到当前发放物品人数的事件
get_cfg_banquet_even(Lv) ->
    case data_newyear_banquet:config(Lv) of
        D when is_record(D, newyear_banquet_lv) -> D#newyear_banquet_lv.banquet_even;
        _ -> error
    end.

%得到npc
get_cfg_banquet_npc(Lv) ->
    case data_newyear_banquet:config(Lv) of
        D when is_record(D, newyear_banquet_lv) -> D#newyear_banquet_lv.npc;
        _ -> error
    end.

%判断当前经验属于哪一个档次
get_banquet_lv_by_exp(Exp) ->
    Exp6 = get_cfg_banquet_exp(?BANQUET_LV6),
    Exp5 = get_cfg_banquet_exp(?BANQUET_LV5),
    Exp4 = get_cfg_banquet_exp(?BANQUET_LV4),
    Exp3 = get_cfg_banquet_exp(?BANQUET_LV3),
    Exp2 = get_cfg_banquet_exp(?BANQUET_LV2),
    Exp1 = get_cfg_banquet_exp(?BANQUET_LV1),
    if
        Exp >= Exp6 -> ?BANQUET_LV6;
        Exp >= Exp5 -> ?BANQUET_LV5;
        Exp >= Exp4 -> ?BANQUET_LV4;
        Exp >= Exp3 -> ?BANQUET_LV3;
        Exp >= Exp2 -> ?BANQUET_LV2;
        Exp >= Exp1 -> ?BANQUET_LV1;
        true -> 1
    end.

%查看是否开启活动
get_newyear_banquet_is_open() ->
    case ets:lookup(?ETS_NEWYEAR_BANQUET, newyear_banquet) of
        [] ->
            0;
        [{newyear_banquet,IsOpen}] ->
            IsOpen
    end.
put_newyear_banquet_open(IsOpen) ->
    ets:insert(?ETS_NEWYEAR_BANQUET, {newyear_banquet, IsOpen}).
del_newyear_banquet_open() ->
    ets:delete(?ETS_NEWYEAR_BANQUET, newyear_banquet).

check_newyear_banquet_is_open() ->
    case get_newyear_banquet_is_open() of
        0 ->
            {error, ?PM_NEWYEAR_BANQUET_IS_NOT_OPEN};
        1 ->
            ok
    end.

%得到自己新年宴会加菜信息
get_newyear_banquet_add_dish_info(PS) ->
    case get_newyear_banquet_is_open() of
        1 ->
           case catch mod_newyear_banquet:get_newyear_banquet_state() of
                NewyearBanquet = #newyear_banquet_state{} ->
                    case NewyearBanquet#newyear_banquet_state.status =:= ?BANQUET_STATUS_OPEN of
                        true ->
                            case dict:find(player:id(PS), NewyearBanquet#newyear_banquet_state.add_dish_players) of
                                {ok, Value} ->
                                    Value;
                                error ->
                                    {player:get_name(PS), 0, 0, 0, 0}
                            end;
                        false ->
                            {error, ?PM_NEWYEAR_BANQUET_IS_NOT_OPEN}
                    end;
                _ ->
                    {error, ?PM_NEWYEAR_BANQUET_SYS_ERR}
            end;
        0 ->
            {error, ?PM_NEWYEAR_BANQUET_IS_NOT_OPEN}
    end. 

%得到总的加菜限制次数
get_newyear_banquet_add_limit_info(DishesNo) ->
    case get_newyear_banquet_is_open() of
        1 ->
           case catch mod_newyear_banquet:get_newyear_banquet_state() of
                NewyearBanquet = #newyear_banquet_state{} ->
                    case NewyearBanquet#newyear_banquet_state.status =:= ?BANQUET_STATUS_OPEN of
                        true ->
                            case dict:find(DishesNo, NewyearBanquet#newyear_banquet_state.add_limit_times) of
                                {ok, Value} ->
                                    Value;
                                error ->
                                    0
                            end;
                        false ->
                            {error, ?PM_NEWYEAR_BANQUET_IS_NOT_OPEN}
                    end;
                _ ->
                    {error, ?PM_NEWYEAR_BANQUET_SYS_ERR}
            end;
        0 ->
            {error, ?PM_NEWYEAR_BANQUET_IS_NOT_OPEN}
    end.  

%检测加菜是否可以
check_newyear_banquet_add_dishes(PS, DishesNo, Num) ->
    Data = data_newyear_banquet:get(DishesNo),
    ?Ifc (Data =:= null)
        throw({error,?PM_PARA_ERROR})
    ?End,
    case get_newyear_banquet_is_open() of
        1 ->
            skip;
        0 ->
            throw({error, ?PM_NEWYEAR_BANQUET_IS_NOT_OPEN})
    end,

    %判断宴会已经最大档次了
    case catch mod_newyear_banquet:get_newyear_banquet_state() of
        NewyearBanquet = #newyear_banquet_state{} ->
            case NewyearBanquet#newyear_banquet_state.banquet_lv =:= ?BANQUET_LV6 of
                true ->
                    throw({error, ?PM_NEWYEAR_BANQUET_ALREADY_MAX});
                false ->
                    skip
            end;
        _ ->
            throw({error, ?PM_NEWYEAR_BANQUET_SYS_ERR})
    end,

    case DishesNo of 
       ?DISH_1 -> 
            ?Ifc (not player:has_enough_bind_gamemoney(PS, Data#newyear_dishes.need_gamemoney * Num))
                throw({error, ?PM_BIND_GAMEMONEY_LIMIT})
            ?End;
        ?DISH_2 ->
            ?Ifc (not player:has_enough_yuanbao(PS, Data#newyear_dishes.need_yuanbao * Num))
                throw({error, ?PM_YB_LIMIT})
            ?End;
        ?DISH_3 ->
            ?Ifc (not player:has_enough_yuanbao(PS, Data#newyear_dishes.need_yuanbao * Num))
                throw({error, ?PM_YB_LIMIT})
            ?End;
        _Any ->
            ?ASSERT(false, _Any)
    end,
    % %得到新年自己已经加菜的信息
    % case get_newyear_banquet_add_dish_info(PS) of
    %         {error, Reason} ->
    %             {error, Reason};
    %         {_Name, Dish1, Dish2, Dish3, _} ->
    %             check_add_dishes_times_is_ok(DishesNo, Dish1, Dish2, Dish3, Num)
    % end.
    % 判断是否可以加菜
    case get_newyear_banquet_add_limit_info(DishesNo) of
        {error, Reason} ->
            {error, Reason};
        Value ->
            ValueLimit = get_cfg_dish_limit(DishesNo),
            case (Value + Num) > ValueLimit of
                true ->
                    throw({error, ?PM_NEWYEAR_BANQUET_TIMES_NOT_ENOUGH});
                false ->
                    ok
            end
    end.


%判断加菜次数是否OK
check_add_dishes_times_is_ok(DishesNo, Dish1, Dish2, Dish3, Num) ->
    Limit1 = get_cfg_dish_limit(?DISH_1),
    Limit2 = get_cfg_dish_limit(?DISH_2),
    Limit3 = get_cfg_dish_limit(?DISH_3),
    if
        DishesNo =:= ?DISH_1 andalso (Dish1 + Num) > Limit1 ->
            {error, ?PM_NEWYEAR_BANQUET_TIMES_NOT_ENOUGH};
        DishesNo =:= ?DISH_2 andalso (Dish2 + Num) > Limit2 ->
            {error, ?PM_NEWYEAR_BANQUET_TIMES_NOT_ENOUGH};
        DishesNo =:= ?DISH_3 andalso (Dish3 + Num) > Limit3 ->
            {error, ?PM_NEWYEAR_BANQUET_TIMES_NOT_ENOUGH};
        true ->
            % {ok, {Dish1, Dish2, Dish3}}
            ok
    end.

%=====================================
%加菜排行榜
%=====================================
get_newyear_banquet_rank(AddDishPlayers) ->
    AddDishList = dict:to_list(AddDishPlayers),
    case length(AddDishList) of
        0 ->
            [];
        _ ->
            AddDishList1 = [{PlayerId, Name, Dish1, Dish2, Dish3, Time} || {PlayerId, {Name, Dish1, Dish2, Dish3, Time}} <- AddDishList],
            SortAddDishList = lists:sort(fun add_dish_rank_sort_fun/2, AddDishList1), 
            %取提名前10的玩家发回给客户端  
            SubAddDishList = lists:sublist(SortAddDishList, 1, 10),
            SubAddDishList
    end.

%加菜排序算法
add_dish_rank_sort_fun(A, B) ->
    {_, _, DishNumA1, DishNumA2, DishNumA3, TimeA} = A,
    {_, _, DishNumB1, DishNumB2, DishNumB3, TimeB} = B,
    ExpA = get_all_dish_exp(DishNumA1, DishNumA2, DishNumA3),
    ExpB = get_all_dish_exp(DishNumB1, DishNumB2, DishNumB3),
    if 
        %玩家加菜贡献值
        ExpA > ExpB -> true;
        ExpA < ExpB -> false;

        %玩家加菜时间
        TimeA < TimeB -> true;
        TimeA > TimeB -> false;
        true -> false
    end.

%得到加菜整的经验
get_all_dish_exp(DishNum1, DishNum2, DishNum3) ->
    Exp = DishNum1 * get_cfg_exp_add(1) + DishNum2 * get_cfg_exp_add(2) + DishNum3 * get_cfg_exp_add(3),
    Exp.

%加菜记录
get_newyear_banquet_log(AddDishLogList) ->
    case length(AddDishLogList) of
        0 ->
            [];
        _ ->
            SubAddDishLogList = lists:sublist(AddDishLogList, 1, 5),
            SubAddDishLogList
    end.

%得到当前年夜宴会场景配置
get_newyear_banquet_scene_no_config() ->
    {30, 20, 8001}.

%进入年夜宴会场景
enter_newyear_banquet_scene(PS) ->
    case get_newyear_banquet_scene_status() of
        null ->
            lib_send:send_prompt_msg(PS, ?PM_NEWYEAR_BANQUET_SCENE_IS_NOT_OPEN);
        EnterScene ->
            case player:is_in_team(PS) of
                true ->
                    lib_send:send_prompt_msg(PS, ?PM_NEWYEAR_BANQUET_IN_TEAM);
                false ->
                    case player:get_lv(PS) < 15 of
                        true ->
                            lib_send:send_prompt_msg(PS, ?PM_NEWYEAR_BANQUET_LEVEL_LIMIT);
                        false ->
                            % 得到年夜场景id
                            {X, Y, _} = get_newyear_banquet_scene_no_config(),
                            % 设置原来位置
                            PrevPos = case player:get_position(player:id(PS)) of
                                null -> ply_scene:get_born_place(PS);
                                Pos -> {Pos#plyr_pos.scene_id, Pos#plyr_pos.x, Pos#plyr_pos.y}
                            end,
                            put('newyear_banquet_prev_pos', PrevPos),
                            % 传送进活动场景
                            gen_server:cast(player:get_pid(PS), {'do_teleport', EnterScene#ets_newyear_banquet_scene_status.scene_id, X, Y})
                    end
            end
    end.
    

%% --------------------------------
%% 退出年夜宴会场景 
%% --------------------------------
newyear_banquet_leave_scene(PS) ->
    ?ylh_Debug("leave_scene ~p~n", [player:id(PS)]),
    % 场景类型判断 
    case lib_scene:is_newyear_banquat_scene(player:get_scene_id(PS)) of
        false -> skip;
        true ->
            {SceneId, X, Y} = 
                case get('newyear_banquet_prev_pos') of
                    undefined -> ply_scene:get_adjusted_pos(player:get_race(PS), player:get_lv(PS));
                    _D -> _D
                end,
            gen_server:cast(player:get_pid(PS), {'do_single_teleport', SceneId, X, Y})
    end,
    ok.

% 创建年夜宴会场景
% 距离活动开启还有10分钟时调用
create_newyear_banquet_scene() ->
    ?ylh_Debug("create_newyear_banquet_scene ~n"),
    case get_newyear_banquet_scene_status() of
        Status when Status#ets_newyear_banquet_scene_status.open_status =:= 1  -> skip;
        _ ->
            {_, _, SceneNo} = get_newyear_banquet_scene_no_config(),
            case mod_scene:create_scene(SceneNo) of
                {ok, SceneId} ->
                    SceneStatus = #ets_newyear_banquet_scene_status{
                        open_status = 1 
                        ,scene_id = SceneId       
                        ,scene_no = SceneNo
                        ,dishes_npc = []
                        },
                    ets:insert(?ETS_NEWYEAR_BANQUET_SCENE_STATUS, SceneStatus);   
                _ ->
                    ?ERROR_MSG("newyear_banquet create scene [~p] fail!!! ", [SceneNo]),
                    skip     
            end
    end.
 
% 活动结束，关闭场景
close_newyear_banquet_scene()->
    case get_newyear_banquet_scene_status() of
        null -> skip;
        Status ->
            %得到当前场景的所有玩家
            PlayerIds = lib_scene:get_scene_player_ids(Status#ets_newyear_banquet_scene_status.scene_id),
            % 踢出场景                                  
            F1 = fun(X) ->
                case player:get_PS(X) of
                    null -> skip;
                    PS ->
                        {SceneId, X1, Y1} = {mod_global_data:get_main_city_scene_no(), 163, 135},
                        gen_server:cast(player:get_pid(PS), {'do_single_teleport', SceneId, X1, Y1})
                end
            end,
            [F1(X) || X <- PlayerIds],
            [mod_scene:clear_dynamic_npc_from_scene_WNC(NpcId) || NpcId <- Status#ets_newyear_banquet_scene_status.dishes_npc],
            mod_scene:clear_scene(Status#ets_newyear_banquet_scene_status.scene_id),
            ets:insert(?ETS_NEWYEAR_BANQUET_SCENE_STATUS, Status#ets_newyear_banquet_scene_status{
                open_status = 0
                ,scene_id = 0       
                ,scene_no = 0
                ,dishes_npc = []
                })
    end.

%% %设置限时转盘的排名
set_time_limit_rank() ->
	%从数据库取到list(PlayerId,PlayerName,Token,UnixTime)
    List = db:select_all(lottery, "player_id, token, time ", []),
	%先进行排列
    F = fun([_PlayerIdA,TokenA,UnixTimeA],[_PlayerIdB,TokenB,UnixTimeB]) ->
				case TokenA =:= TokenB of
					true -> UnixTimeA < UnixTimeB;
					false -> TokenA > TokenB
				end
		end,
    List2 = lists:sort(F, List),
	
	F2 = fun([PlayerId,Token,_UnixTime],{Rank ,Acc}) ->
				case Token > 0 of
					true ->
						{Rank +1 , [ {PlayerId, player:get_name(PlayerId), Rank, Token} | Acc] };
					false ->
						{Rank, Acc}
				end
		 end,
				
	{_Rank2 , List3} = lists:foldl(F2, {1,[]}, List2),
	TimeLimitRank = #ets_time_limit_rank{id = time_limit_rank,ranklist = List3, dirty = 0 },
	mod_newyear_banquet:add_time_limit_from_ets(TimeLimitRank). 

%获取限时转盘的排名
get_time_limit_rank() ->
	case mod_newyear_banquet:get_ets_time_limit_from_ets(time_limit_rank) of
		null -> [];
		R -> R#ets_time_limit_rank.ranklist
	end.

get_player_time_limit_rank(PlayerId) ->
	TupleList = get_time_limit_rank(),
	case lists:keyfind(PlayerId, 1, TupleList) of
		false -> 0;
		{_PlayerId, _PlayerName, Rank, _Token} -> Rank
	end.

send_time_limit_rank_to_client(Type,PS) ->
	Size = (Type -1) * 10 + 1,
	List1 = get_time_limit_rank(),
	List2 = lists:keysort(3, List1),
	List = case length(List2) >= Size  of
		true ->lists:sublist(List2, Size, 10);
		false -> []
	end,
			
	{ok, BinData} = pt_36:write(?PT_LUCKY_PLAYER_RANK, [List]),
	lib_send:send_to_sock(PS, BinData).
	

% 得到新年宴会场景
get_newyear_banquet_scene_status() ->
    case ets:lookup(?ETS_NEWYEAR_BANQUET_SCENE_STATUS, ?NEWYEAR_BANQUET_SCENE_KEY) of
        [Status] when is_record(Status, ets_newyear_banquet_scene_status) -> Status;
        _ -> null
    end.

%%-------------------------------------------------------------------------------------

get_player_lottery_info(PS) ->
    RoleId = player:get_id(PS),
    case ets:lookup(?ETS_PLAYER_LOTTERY_INFO, RoleId) of
        [Rd] when is_record(Rd, player_lottery_info) -> Rd;
        _ ->
            case db:select_all(lottery, "player_id, token, free_time, time, reward",
                [{player_id, RoleId}]) of
                [] ->
                    null;
                PlayerLottery ->
                    F = fun([PlayerId, Token, FreeTime, Time, Reward_BS]) ->
                        Reward = util:bitstring_to_term(Reward_BS),
                        update_player_lottery(
                            #player_lottery_info{
                                player_id = PlayerId
                                , token = Token
                                , free_time = FreeTime
                                , time = Time
                                , reward = Reward
                            })
                        end,
                    lists:foreach(F, PlayerLottery),
                    get_player_lottery_info(PS)
            end
    end.

get_player_token(PS) ->
    case get_player_lottery_info(PS) of
        null ->
            0;
        PlyLottery ->
            PlyLottery#player_lottery_info.token
    end.

get_player_reward(PS) ->
    case get_player_lottery_info(PS) of
        null ->
            [];
        PlyLottery ->
            PlyLottery#player_lottery_info.reward
    end.

get_player_lottery_free_time(PS) ->
    case get_player_lottery_info(PS) of
        null ->
            0;
        PlyLottery ->
            PlyLottery#player_lottery_info.free_time
    end.

update_player_lottery(Lottery) when is_record(Lottery, player_lottery_info) ->
    ets:insert(?ETS_PLAYER_LOTTERY_INFO, Lottery).

db_insert_player_lottery(PS, Lottery) when is_record(Lottery, player_lottery_info) ->
    RoleId = player:get_id(PS),
    db:insert(RoleId, lottery,
        [{player_id, RoleId}, {token, Lottery#player_lottery_info.token},
            {free_time, Lottery#player_lottery_info.free_time}, {time, Lottery#player_lottery_info.time},
            {reward, util:term_to_bitstring(Lottery#player_lottery_info.reward)}]).


luck_draw(Type) ->

    LotteryLists = data_model_lottery:get_no(),
    F = fun(X, Acc) ->
        [{_, _, Count, _, _}] = (data_model_lottery:get(X))#lottery_data.reward,
        Count + Acc
        end,
    Range = lists:foldl(F, 0, LotteryLists),


    F1 = fun(X, AccList) ->
        (data_model_lottery:get(X))#lottery_data.reward ++ AccList
         end,
    RewardPool = lists:foldl(F1, [], LotteryLists),

    case Type=:= 2 of
        true ->
            F2 = fun(_, Acc2) ->
                    RandNum = util:rand(1, Range),
                    Reward = decide_par_no_by_prob(RewardPool, RandNum),
                    [Reward] ++ Acc2
                 end,
            lists:foldl(F2, [], lists:seq(1,10));
        false ->
            RandNum = util:rand(1, Range),
            Reward = decide_par_no_by_prob(RewardPool, RandNum),
            [Reward]
    end.

decide_par_no_by_prob(Pool, RandNum) ->
    decide_par_no_by_prob(Pool, RandNum, 0).

decide_par_no_by_prob([H | T], RandNum, SumToCompare) ->
    SumToCompare_2 = element(3, H) + SumToCompare,
    case RandNum =< SumToCompare_2 of
        true ->
            GoodsId = element(1, H),
            GoodNum = element(2, H),
            {GoodsId, GoodNum};
        false ->
            decide_par_no_by_prob(T, RandNum, SumToCompare_2)
    end;
decide_par_no_by_prob([], _RandNum, _) ->
    ?ASSERT(false),
    ?INVALID_NO.
	
%% 9/30 修改。。。。。
get_lottery_box_data(OrderId) ->
	PanList = ets:tab2list(?ETS_ADMIN_SYS_ACTIVITY),
	case lists:keyfind(OrderId, #admin_sys_activity.sys, PanList) of
		#admin_sys_activity{} = Activity ->
			case rfc4627:decode(Activity#admin_sys_activity.show_panel) of
				{ok, {obj, ObjList},_} ->
					{_, RewardList_BS} = lists:keyfind("attach", 1, ObjList),
					util:bitstring_to_term(RewardList_BS);
				_ ->
					null
			end;
		false ->
			null
	end.

get_is_on_lottery_data() ->
    PanList = ets:tab2list(?ETS_ADMIN_SYS_ACTIVITY_BRIEF),

    Fp = fun(Activity, Acc) ->
            case Activity#admin_sys_activity_brief.state =:= 1 of
                true ->
                    case ets:lookup(?ETS_ADMIN_SYS_ACTIVITY, Activity#admin_sys_activity_brief.order_id) of
                        [Activity2] when is_record(Activity2, admin_sys_activity) ->
                            case Activity2#admin_sys_activity.sys =:= 15 of
                                true ->
                                    [Activity2 | Acc];
                                false ->
                                    Acc
                            end
                    end;
                false ->
                    Acc
            end
         end,
    lists:foldl(Fp, [], PanList).

do_luck_draw(PS, Type) ->
    PlayerId = player:get_id(PS),
    LastFreeEnterTime = util:unixtime(),
    Token = lib_newyear_banquet:get_player_token(PS),
    StepList = lib_newyear_banquet:get_player_reward(PS),
    RewardList = lib_newyear_banquet:luck_draw(Type),
    ?DEBUG_MSG("--------------------------- RewardList -----------------------------~p~n", [RewardList]),

    case mod_inv:check_batch_add_goods(PlayerId, RewardList) of
        ok ->
            case Type of
                0 ->
                    FreeTime = ets:lookup_element(?ETS_PLAYER_LOTTERY_INFO, PlayerId, #player_lottery_info.free_time),
                    case LastFreeEnterTime - FreeTime >= 86400 of
                        true ->
                            AddToken = data_special_config:get('one_draw_point'),
                            ets:update_element(?ETS_PLAYER_LOTTERY_INFO, PlayerId, [{#player_lottery_info.free_time, LastFreeEnterTime},
                                {#player_lottery_info.time,  LastFreeEnterTime}, {#player_lottery_info.token, Token+AddToken}]),
                            db:update(lottery, [{free_time, LastFreeEnterTime}, {time, LastFreeEnterTime}, {token, Token+AddToken}], [{player_id, PlayerId}]),

                            Rank = lib_newyear_banquet:get_player_time_limit_rank(player:get_id(PS)),
                            {ok, BinData} = pt_36:write(?PT_ENTER_LUCKY_DRAW, [LastFreeEnterTime, Token+AddToken, Rank, StepList]),
                            lib_send:send_to_sock(PS, BinData),

                            {ok, RetGoods} = mod_inv:batch_smart_add_new_goods(PlayerId,
                                RewardList, [{bind_state, ?BIND_ON_GET}], [?LOG_LOTTERY, "free lottery"]),
                            % 增加获取提示
                            F2 = fun({Id, No, Cnt}) ->
                                case mod_inv:find_goods_by_id_from_bag(player:id(PS), Id) of
                                    null ->
                                        skip;
                                    Goods ->
                                        ply_tips:send_sys_tips(PS, {get_goods, [No, lib_goods:get_quality(Goods), Cnt, Id]})
                                end
                                 end,
                            [F2(X) || X <- RetGoods];
                        false ->
                            lib_send:send_prompt_msg(PS, ?PM_LOTTERY_FREE_TIMES_LIMIT)
                    end;
                1 ->
                    AddToken = data_special_config:get('one_draw_point'),
                    {GoodsNo, GoodsNum} = data_special_config:get('one_draw_cost'),
                    PlayerLottery = lib_newyear_banquet:get_player_lottery_info(PS),
                    case mod_inv:get_goods_count_in_bag_by_no(PlayerId, GoodsNo) >= GoodsNum of
                        true ->
                            case mod_inv:destroy_goods_WNC(PlayerId, [{GoodsNo, GoodsNum}], [?LOG_LOTTERY, "one lottery"]) of
                                true ->
                                    ets:update_element(?ETS_PLAYER_LOTTERY_INFO, PlayerId, [{#player_lottery_info.time, LastFreeEnterTime},
                                        {#player_lottery_info.token, Token+AddToken}]),
                                    db:update(lottery, [{time, LastFreeEnterTime}, {token, Token+AddToken}], [{player_id, PlayerId}]),
                                    Rank = lib_newyear_banquet:get_player_time_limit_rank(player:get_id(PS)),
                                    {ok, BinData} = pt_36:write(?PT_ENTER_LUCKY_DRAW, [PlayerLottery#player_lottery_info.free_time, Token+AddToken, Rank, StepList]),
                                    lib_send:send_to_sock(PS, BinData),

                                    {ok, RetGoods} = mod_inv:batch_smart_add_new_goods(PlayerId,
                                        RewardList, [{bind_state, ?BIND_ON_GET}], [?LOG_LOTTERY, "one lottery"]),
                                    % 增加获取提示
                                    F2 = fun({Id, No, Cnt}) ->
                                            case mod_inv:find_goods_by_id_from_bag(player:id(PS), Id) of
                                                null ->
                                                    skip;
                                                Goods ->
                                                    ply_tips:send_sys_tips(PS, {get_goods, [No, lib_goods:get_quality(Goods), Cnt, Id]})
                                            end
                                         end,
                                    [F2(X) || X <- RetGoods];
                                _ ->
                                    lib_send:send_prompt_msg(PS, ?PM_UNKNOWN_ERR)
                            end;
                        false ->
                            lib_send:send_prompt_msg(PS, ?PM_LOTTERY_LIMIT)
                    end;

                2 ->
                    AddToken = data_special_config:get('ten_draw_point'),
                    {GoodsNo, GoodsNum} = data_special_config:get('ten_draw_cost'),
                    PlayerLottery = lib_newyear_banquet:get_player_lottery_info(PS),
                    case mod_inv:get_goods_count_in_bag_by_no(PlayerId, GoodsNo) >= GoodsNum of
                        true ->
                            case mod_inv:destroy_goods_WNC(PlayerId, [{GoodsNo, GoodsNum}], [?LOG_LOTTERY, "one lottery"]) of
                                true ->
                                    ets:update_element(?ETS_PLAYER_LOTTERY_INFO, PlayerId, [{#player_lottery_info.time, LastFreeEnterTime},
                                        {#player_lottery_info.token, Token+AddToken}]),
                                    db:update(lottery, [{time, LastFreeEnterTime}, {token, Token+AddToken}], [{player_id, PlayerId}]),
                                    Rank = lib_newyear_banquet:get_player_time_limit_rank(player:get_id(PS)),
                                    {ok, BinData} = pt_36:write(?PT_ENTER_LUCKY_DRAW, [PlayerLottery#player_lottery_info.free_time, Token+AddToken, Rank, StepList]),
                                    lib_send:send_to_sock(PS, BinData),

                                    ?ASSERT(length(RewardList) =:= 10),
                                    {ok, RetGoods} = mod_inv:batch_smart_add_new_goods(PlayerId,
                                        RewardList, [{bind_state, ?BIND_ON_GET}], [?LOG_LOTTERY, "ten lottery"]),
                                    % 增加获取提示
                                    F2 = fun({Id, No, Cnt}) ->
                                            case mod_inv:find_goods_by_id_from_bag(player:id(PS), Id) of
                                                null ->
                                                    skip;
                                                Goods ->
                                                    ply_tips:send_sys_tips(PS, {get_goods, [No, lib_goods:get_quality(Goods), Cnt, Id]})
                                            end
                                         end,
                                    [F2(X) || X <- RetGoods];
                                false ->
                                    lib_send:send_prompt_msg(PS, ?PM_UNKNOWN_ERR)
                            end;
                        false ->
                            lib_send:send_prompt_msg(PS, ?PM_LOTTERY_LIMIT)
                    end
            end,
            case mod_newyear_banquet:get_ets_time_limit_from_ets(time_limit_rank) of
                null -> [];
                R -> R2 = R#ets_time_limit_rank{dirty = 1},
                    mod_newyear_banquet:add_time_limit_from_ets(R2)
            end;
        _ ->
            lib_send:send_prompt_msg(PlayerId, ?PM_US_BAG_FULL)
    end.



