%%%--------------------------------------------------------
%%% @author Lzz <liuzhongzheng2012@gmail.com>
%%% @doc 轮盘抽奖活动
%%%
%%% @end
%%%--------------------------------------------------------

-module(lib_ernie).

-export([get_ernie/1, 
%% 		 add_ernie/1, add_ernie/2, add_ernie_gm/2, sub_ernie/1, 
		 load_ernie/1, login/2, init_login/1,
		 check_cost/1, do_cost/1, update_ernie_record_data/1]).
-export([tmp_login/1, tmp_logout/1, final_logout/1, update_db_ernie/2]).
-export([get_ernie_player_times/1, get_ernie_reward_goods_info/0, get_ernie_reward_logs/0,do_get_ernie_reward/0]).

-include("common.hrl").
-include("effect.hrl").
-include("reward.hrl").
-include("pt_36.hrl").
-include("goods.hrl").
-include("sys_code.hrl").
-include("log.hrl").
-include("ets_name.hrl").
-include("ernie.hrl").
-compile(export_all).
-define(ERNIE_DATA, {ernie, data}).

%% @doc 得到玩家转盘数据
get_ernie(_RoleId) ->
	get_ernie_data().
%%     case get(?ERNIE_DATA) of
%%         Ernie when is_record(Ernie, ernie_data) -> Ernie;
%%         _ -> null
%%     end.

%% 2017.8.28 修改转盘消耗，次数作废 --zjy
%% @doc 增加玩家转盘次数
%% add_ernie(RoleId) ->
%% 	add_ernie(RoleId, 1).
%% 
%% add_ernie(RoleId, Count) when Count >= 1 ->
%%     case get_ernie(RoleId) of
%%         Ernie when is_record(Ernie, ernie_data) ->
%%             case util:is_timestamp_same_day(Ernie#ernie_data.ernie_add_time, util:unixtime()) andalso false of
%%                 true ->
%%                     skip;
%%                 false ->
%%                     Ernie1 = Ernie#ernie_data{ernie_times = Ernie#ernie_data.ernie_times + Count, ernie_add_time = util:unixtime()},
%%                     put(?ERNIE_DATA, Ernie1),
%%                     ErnieTimes = Ernie1#ernie_data.ernie_times,
%%                     {ok, BinData} = pt_36:write(?PT_ERNIE_NOTIFY, [ErnieTimes]),
%%                     lib_send:send_to_sock(player:get_PS(RoleId), BinData)
%%             end;
%%         _ -> %玩家不在线，直接写入数据库中 
%%            case db:select_row(ernie, "ernie_times, ernie_add_time", [{role_id, RoleId}]) of
%%                 [] ->
%%                     Ernie_data = #ernie_data{ernie_times = Count,  ernie_add_time = util:unixtime()},
%%                     db:insert(ernie, [role_id, ernie_times, ernie_add_time], [RoleId, Ernie_data#ernie_data.ernie_times, Ernie_data#ernie_data.ernie_add_time]);
%%                 [ErnieTime, ErnieAddTime] ->
%%                     case util:is_timestamp_same_day(ErnieAddTime, util:unixtime()) andalso false of
%%                         true ->
%%                             skip;
%%                         false ->
%%                             Ernie_data1 = #ernie_data{ernie_times = ErnieTime + Count, ernie_add_time = ErnieAddTime},
%%                             update_db_ernie(RoleId, Ernie_data1)
%%                     end
%%             end 
%%     end;
%% 
%% add_ernie(_RoleId, _Count) ->
%% 	skip.
%% 
%% %% @doc gm指令增加转盘次数
%% add_ernie_gm(RoleId, Value) ->
%%     case get_ernie(RoleId) of
%%         Ernie when is_record(Ernie, ernie_data) ->
%%             Ernie1 = Ernie#ernie_data{ernie_times = Ernie#ernie_data.ernie_times + Value, ernie_add_time = util:unixtime()},
%%             put(?ERNIE_DATA, Ernie1);
%%         _ ->
%%             skip
%%     end.
%% 
%% %% @doc 减少玩家转盘次数
%% sub_ernie(RoleId) ->
%%     case get_ernie(RoleId) of
%%         Ernie when is_record(Ernie, ernie_data) ->
%%             Ernie1 = Ernie#ernie_data{ernie_times = Ernie#ernie_data.ernie_times - 1, ernie_sub_time = util:unixtime()},
%%             put(?ERNIE_DATA, Ernie1);
%%         _ ->
%%             ?ASSERT(false, "sub_ernie fail")
%%     end.

%% @doc 初始化数据
load_ernie(RoleId) ->
    case db:select_row(ernie, "ernie_times, ernie_add_time, data", [{role_id, RoleId}]) of
        [] ->
            Ernie_data = #ernie_data{data = init_ernie_record_data()},
            db:insert(RoleId, ernie, [{role_id, RoleId}, {ernie_times, 0}, {ernie_add_time, 0}, {ernie_sub_time, 0}, {data, util:term_to_bitstring(Ernie_data#ernie_data.data)}]),
            put(?ERNIE_DATA, Ernie_data);
        [ErnieTime, ErnieAddTime, Data] ->
			NewData = 
				case util:bitstring_to_term(Data) of
					Data0 when erlang:is_record(Data0, ernie_record_data) ->
						Data0;
					_ ->
						init_ernie_record_data()
				end,
            ?ylh_Debug("load_ernie ~p, ~p, ~p~n", [ErnieTime, ErnieAddTime, NewData]),
            Ernie_data1 = #ernie_data{ernie_times = ErnieTime, ernie_add_time = ErnieAddTime, data = NewData},
            put(?ERNIE_DATA, Ernie_data1)
    end.

%% =========================================
%% login/logout
%% =========================================   
login(RoleId, role_in_cache) ->
    tmp_login(RoleId);
login(RoleId, _) ->
    init_login(RoleId).

%% @doc 初始化上线
init_login(RoleId) ->
    load_ernie(RoleId).

%% @doc 临时上线
tmp_login(RoleId) ->
    case ets:lookup(?ETS_ERNIE_TMP_CACHE, RoleId) of
        [] -> load_ernie(RoleId);
        [{RoleId, Ernie}] when is_record(Ernie, ernie_data) -> put(?ERNIE_DATA, Ernie);
        _ -> ?ASSERT(false)
    end.

%% @doc 临时退出
tmp_logout(RoleId) ->
    case get_ernie(RoleId) of
        null -> skip;
        Ernie when is_record(Ernie, ernie_data) ->
            update_db_ernie(RoleId, Ernie),
            ets:insert(?ETS_ERNIE_TMP_CACHE, {RoleId, Ernie}),
            erase(?ERNIE_DATA);
        _ -> ?ASSERT(false)
    end.

%% @doc 最终退出
final_logout(RoleId) ->
    case ets:lookup(?ETS_ERNIE_TMP_CACHE, RoleId) of
        [] -> ?ASSERT(false, [RoleId]), skip;
        [{RoleId, Ernie}] when is_record(Ernie, ernie_data) ->
            update_db_ernie(RoleId, Ernie),
            ets:delete(?ETS_ERNIE_TMP_CACHE, RoleId);
        _ -> ets:delete(?ETS_ERNIE_TMP_CACHE, RoleId)
    end.

%% @doc 更新玩家幸运转盘次数
update_db_ernie(RoleId, Ernie) when is_record(Ernie, ernie_data) ->
    db:update(RoleId, ernie, [{ernie_times, Ernie#ernie_data.ernie_times}, 
							  {ernie_add_time, Ernie#ernie_data.ernie_add_time}, 
							  {ernie_sub_time, Ernie#ernie_data.ernie_sub_time},
							  {data, util:term_to_bitstring(Ernie#ernie_data.data)}], [{role_id, RoleId}]).


%% @doc 得到幸运转盘玩家信息
get_ernie_player_times(PS) ->
    RoleId = player:id(PS),
    case get_ernie(RoleId) of
        Ernie when is_record(Ernie, ernie_data) -> Ernie#ernie_data.ernie_times;
        null -> ?ASSERT(false), 0
    end.

%% @doc 得到幸运转盘转盘奖励物品的信息
get_ernie_reward_goods_info() ->
    %% 保存已获得的物品记录
%% 	Gains = case get_ernie_data() of
%% 				#ernie_data{data = Data} ->
%% 					Data#ernie_record_data.data;
%% 				null ->
%% 					%% 不会出现此种情况
%% 					[]
%% 			end,
	#ernie_data{data = Data} = get_ernie_data(),
	Gains = Data#ernie_record_data.data,
    List = [data_ernie:get(I) || I <- get_no_from_pool(Data#ernie_record_data.type)],
	List1 = [{No, GoodsNo, Num, Quality, BindState, case lists:member(No, Gains) of true -> 1; false -> 0 end} || #ernie_reward_data{no=No, reward=[{GoodsNo, Num, Quality, BindState}]} <- List],
    List1.

%% @doc 得到最近10项抽奖记录
get_ernie_reward_logs() ->
    case mod_ernie:get_ernie_state() of
        ErnieState when is_record(ErnieState, ernie_state) ->
            case ErnieState#ernie_state.status =:= 1 of
                true ->
                    Len = length(ErnieState#ernie_state.reward_logs),
                    case Len =< 10 of
                        true -> {ok, ErnieState#ernie_state.reward_logs};
                        false ->
                            {List, _} = lists:split(10, ErnieState#ernie_state.reward_logs), 
                            {ok, List}
                    end;
                false ->
                    {error, not_open}
            end;
        _ -> {error, sys_err}
    end.

%% @doc 抽奖
do_get_ernie_reward() ->
    case mod_ernie:get_ernie_state() of
        ErnieState when is_record(ErnieState, ernie_state) ->
            case ErnieState#ernie_state.status =:= 1 of
                true ->
                    Treasure = rand_treasure(),
					%% 保存更新抽到的东西和当前时间戳
                    {ok, Treasure#ernie_reward_data.no, Treasure#ernie_reward_data.reward};
                false ->
                    {error, not_open}
            end;
        _ ->
            {error, sys_err}
    end.

rand_treasure() ->
	%% 不直接从配置表获取抽奖池数据，从玩家身上保存的数据里抽取，计算消耗
%% 	Gains = 
%% 		case get_ernie_data() of
%% 			#ernie_data{data = Data} ->
%% 				Data#ernie_record_data.data;
%% 			null ->
%% 				?ERROR_MSG("not found error", []),
%% 				[]
%% 		end,
    #ernie_data{data = Data} = get_ernie_data(),
	Gains = Data#ernie_record_data.data,
	List = [data_ernie:get(I) || I <- get_no_from_pool(Data#ernie_record_data.type), not lists:member(I, Gains)],
    util:rand_by_weight2(List, #ernie_reward_data.prob).



get_ernie_data() ->
	[{vsn,[Vsn]}] = erlang:get_module_info(util, attributes),
	case get(?ERNIE_DATA) of
        #ernie_data{data = Data} = Ernie when is_record(Ernie, ernie_data) ->
			case case Data of
				#ernie_record_data{last_time = LastTime} ->
					case util:is_same_day(LastTime) of
						true ->
							case Data#ernie_record_data.data_vsn of
								Vsn ->
									%% 判断是否抽完了重置已抽取数据
									Len = erlang:length(get_no_from_pool(Data#ernie_record_data.type)),
									Len2 = erlang:length(Data#ernie_record_data.data),
									case Len =:= Len2 of
										true ->
											Ernie#ernie_data{data = init_ernie_record_data(Vsn)};
										false ->
											Ernie
									end;
								_ ->
									Ernie#ernie_data{data = init_ernie_record_data(Vsn)}
							end;
						false ->
							Ernie#ernie_data{data = init_ernie_record_data(Vsn)}
					end;
				_ ->
					Ernie#ernie_data{data = init_ernie_record_data(Vsn)}
			end of
				Ernie ->
					Ernie;
				Ernie2 ->
					erlang:put(?ERNIE_DATA, Ernie2),
					Ernie2
			end;
        _ ->
			Ernie = init_ernie_record_data(),
			erlang:put(?ERNIE_DATA, Ernie),
			Ernie
    end.

init_ernie_record_data() ->
	[{vsn,[Vsn]}] = erlang:get_module_info(util, attributes),
	init_ernie_record_data(Vsn).

init_ernie_record_data(Vsn) ->
	Nos = data_ernie:get_all_event_no(),
	N = util:rand(1, erlang:length(Nos)),
	No = lists:nth(N, Nos),
	#ernie_reward_data{type = Type} = data_ernie:get(No),
	#ernie_record_data{type = Type, last_time = util:unixtime(), data_vsn = Vsn, data = []}.


check_cost(RoleId) -> 
	Count = 
		case get_ernie_data() of
			#ernie_data{data = ErnieRecordData} ->
				Data = ErnieRecordData#ernie_record_data.data,
				erlang:length(Data);
			null ->
				0
		end,
	CountCost = data_zhuanpan_cost:get(Count),
	CostGoodsNo = data_special_config:get('ernie_no'),
	CountHas = mod_inv:get_goods_count_in_bag_by_no(RoleId, CostGoodsNo),
	CountHas >= CountCost.

do_cost(RoleId) ->
	Count = 
		case get_ernie_data() of
			#ernie_data{data = ErnieRecordData} ->
				erlang:length(ErnieRecordData#ernie_record_data.data);
			null ->
				0
		end,
	CountCost = data_zhuanpan_cost:get(Count),
	CostGoodsNo = data_special_config:get('ernie_no'),
	true == mod_inv:destroy_goods_WNC(RoleId, [{CostGoodsNo, CountCost}], [?LOG_ERNIE, "use"]).

update_ernie_record_data(No) ->
	case get_ernie_data() of
		#ernie_data{data = ErnieRecordData} = Ernie ->
			ErnieRecordData2 = ErnieRecordData#ernie_record_data{last_time = util:unixtime(), data = [No|ErnieRecordData#ernie_record_data.data]},
			Ernie2 = Ernie#ernie_data{data = ErnieRecordData2},
			put(?ERNIE_DATA, Ernie2);
		null ->
			false
	end.


get_no_from_pool() ->
	Nos = data_ernie:get_all_event_no(),
	Types = 
		lists:foldl(fun(No, Acc) ->
							#ernie_reward_data{type = Type} = data_ernie:get(No),
							[Type|lists:delete(Type, Acc)]
					end, [], Nos),
	N = util:rand(1, erlang:length(Types)),
	Type = lists:nth(N, Types),
	get_no_from_pool(Type).

get_no_from_pool(Type) ->
	Nos = data_ernie:get_all_event_no(),
	lists:filter(fun(No) ->
						 #ernie_reward_data{type = TypeNo} = data_ernie:get(No),
						 TypeNo =:= Type
				 end, Nos).
