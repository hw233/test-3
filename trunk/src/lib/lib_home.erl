%%%-----------------------------------
%%% @Module  : lib_home
%%% @Author  : zhengjy
%%% @Email   : 
%%% @Created : 2018.5.17
%%% @Description: 家园系统相关函数
%%%-----------------------------------
-module(lib_home).
-export([
		 server_start_init/0,
		 request_other_list/1,
		 on_player_login/1,
		 tmp_logout/1,
		 final_logout/1,
		 build_home/2,
		 my_ets_home_data/1,
		 my_ets_home/1,
		 has_home/1,
		 enter_home_scene/3,
		 check_home_scnene_exits/1,
		 get_home_scene_info/1,
		 lvlup/2,
		 job_start/5,
		 get_home/1,
		 grid_data/1,
		 job_action/4,
		 job_action_finish/4,
		 check_grid_state/1,
		 check_grid_state/2,
		 achievement_data/1,
		 achievement_reward/2,
		 add_degree/2,
		 refresh_mon/4,
		 mon_steal/5,
		 get_home_id_from_ets/1,
		 update_home_data/2
		]).

-compile(export_all).

-include("record.hrl").
-include("home.hrl").
-include("prompt_msg_code.hrl").
-include("debug.hrl").
-include("common.hrl").
-include("ets_name.hrl").
-include("log.hrl").
-include("pt_37.hrl").
-include("pt_17.hrl").
-include_lib("stdlib/include/ms_transform.hrl").
-include("goods.hrl").
-include("abbreviate.hrl").
-include("partner.hrl").
-include("record/goods_record.hrl").


server_start_init() ->
	case db:select_all(home, "id", []) of
		List when is_list(List) ->
			[ load_home(RoleId) || [RoleId] <- List];
		Err ->
			?ERROR_MSG("server_start_init Err : ~p~n", [Err])
	end.

% 登录初始化家园数据
on_player_login(PS) ->
	RoleId = player:id(PS),
	load_home(RoleId),
	%% 判断是否在家园场景，是则退出家园场景？飞到主城?
	SceneId = player:get_scene_id(PS),
	case lib_scene:is_home_scene(SceneId) of
		true ->
			{SceneId2, X, Y} = ply_scene:get_adjusted_pos(player:get_race(PS), player:get_lv(PS)),
			gen_server:cast(player:get_pid(PS), {'do_single_teleport', SceneId2, X, Y});
		false ->
			ok
	end,
	ok.


		
duplicate_key_sum_value(List) ->
    List2  =  proplists:get_keys(List),
	F = fun(Key, Acc) ->
			List3 = proplists:lookup_all(Key,List),
			case length(List3) > 1 of
				true ->
					F2 = fun({_Key, Value2},Acc2) ->
								 Acc2 + Value2
						 end,
					Acc ++ [{Key,lists:foldl(F2, 0, List3)}];
				false ->
					
					Acc ++ List3
			end
		end,
	lists:foldl(F, [], List2).

% 临时退出处理
tmp_logout(PS) ->
	ok.

% 最终退出
final_logout(PS) ->
	ok.


%% 请求拜访列表
request_other_list(PS) ->
	PlayerId = player:id(PS),
	Fun = fun({_, Tab}, Acc) ->
				  case ets:tab2list(Tab) of
					  [] ->
						  Acc;
					  Acc2 ->
						  lists:append(Acc, Acc2)
				  end
		  end,
	HomeList0 = lists:foldl(Fun, [], ?ETS_HOME_LIST),
	HomeList = lists:keydelete(PlayerId, #home.id, HomeList0),
	case HomeList of
		[] ->
			[];
		_ ->
			{HomeListData, _} = 
				lists:foldl(fun(_, {Acc, Acc2}) ->
									case Acc2 of
										[] ->
											{Acc, Acc2};
										_ ->
											Home = list_util:rand_pick_one(Acc2),
											{[Home|Acc], lists:delete(Home, Acc2)}
									end
							end, {[], HomeList}, lists:seq(1, 6)),
			HomeListData
	end.

%% 请求总览/建造家园
build_home(PS, 0) ->% 请求总览
	RoleId = player:id(PS),
	case get_home(RoleId) of
		{ok, Home} ->
			{ok, Bin} = home_base_info(Home),
			lib_send:send_to_sock(PS, Bin),
			ok;
		false ->
			%% 没有家园
			{fail, ?PM_HOME_NOT_YET}
	end;

build_home(PS, 1) ->% 建造家园
	%% 检查是否有家园，没有则初始化家园
	RoleId = player:id(PS),
	case has_home(PS) of
		false ->
			case check_build_home(PS) of
				ok ->
					cost_build_home(PS),
					CreateTime = util:unixtime(),
					LvInit = 1,
					Home = #home{id = RoleId, 
								 degree = 0, 
								 lv_home = LvInit, 
								 lv_land = LvInit, 
								 lv_dan = LvInit, 
								 lv_mine = LvInit,
								 achievement_value = [],
								 achievement_reward_nos = [],
					 			 create_time = CreateTime,
								 scene_id = 0
								},
					db_insert_home(Home),
					ets:insert(?MY_ETS_HOME(RoleId), Home),
					add_degree(PS,50),
					NewHome = notify_achi(Home, ?HOME_ACHIEVEMENT_TYPE_LV_HOME, 1),
					NewHome2 = notify_achi(NewHome, ?HOME_ACHIEVEMENT_TYPE_LV_LAND, 1),
					NewHome3 = notify_achi(NewHome2, ?HOME_ACHIEVEMENT_TYPE_LV_DAN, 1),
					NewHome4 = notify_achi(NewHome3, ?HOME_ACHIEVEMENT_TYPE_LV_MINE, 1),
					update_home(Home, NewHome4),
					{ok, Bin} = home_base_info(NewHome4),
					lib_send:send_to_sock(PS, Bin),
					ok;
				{fail, Reason} ->
					{fail, Reason}
			end;
		true ->% 已有家园，不可创建
			{fail, ?PM_HOME_ALREADY_HAS}
	end.



%% 进入家园场景
enter_home_scene(PS, TargetRoleId, Type) ->
	case get_home(TargetRoleId) of
		{ok, Home} ->
			enter_home_scene2(PS, Home, Type);
		false ->
			% 目标角色没有家园?
			{fail, ?PM_HOME_NOT_YET}
	end.

enter_home_scene2(PS, Home, Type) ->
	SceneId = Home#home.scene_id,
	TargetPlayerId = Home#home.id,
	case case check_home_scnene_exits(Home) of
			 true ->
				 {ok, SceneId};
			 false ->
				 case mod_home:create_home(TargetPlayerId) of
					 {ok, SceneId2} ->
						 {ok, SceneId2};
					 fail ->
						 %% 家园不存在
						 {fail, ?PM_HOME_NOT_YET}
				 end
		 end of
		{ok, NewSceneId} ->
			HomeConfig = data_home_config:get(Home#home.lv_home),
			L = [{0, #home_config.home_xy},
				 {1, #home_config.land_xy},
				 {2, #home_config.alchemy_furnace_xy},
				 {3, #home_config.mine_xy}],
			{Type, Pos} = lists:keyfind(Type, 1, L),
			{NewX, NewY} = erlang:element(Pos, HomeConfig),
			ply_scene:do_teleport(PS, NewSceneId, NewX, NewY),
			HomeDatas = get_home_datas(TargetPlayerId),
			{ok, Bin} = pt_37:write(?PT_GET_HOME_INFO, [Home, HomeDatas]),
			lib_send:send_to_sock(PS, Bin),
			ok;
		{fail, Reason} ->
			{fail, Reason}
	end.

%% 请求玩家所在家园场景信息
get_home_scene_info(PS) ->
	PlayerId = player:id(PS),
	SceneId = player:get_scene_id(PS),
	case lib_scene:is_home_scene(SceneId) of
		true ->
			case ets:lookup(?ETS_HOME_SCENE, SceneId) of
				[{SceneId, RoleId}] ->
					case get_home(RoleId) of
						{ok, Home} ->
							HomeDatas = get_home_datas(PlayerId),
							{ok, Bin} = pt_37:write(?PT_GET_HOME_INFO, [Home, HomeDatas]),
							{ok, Bin};
						false ->
							%% 家园数据不存在
							{fail, ?PM_HOME_NOT_YET}
					end;
				[] ->
					%% 家园场景数据不存在
					{fail, ?PM_HOME_NOT_YET}
			end;
		false ->
			%% 当前不在家园场景
			{fail, ?PM_HOME_NOT_IN_SCENE}
	end.
				

%% 升级 return: ok | {fail, Reason}
lvlup(PS, Type) ->
	case has_home(PS) of
		true ->
			RoleId = player:id(PS),
			case get_home(RoleId) of
				{ok, Home} ->
					%% 0家园1土地2炼丹炉3矿井
					lvlup2(PS, Home, Type);
				false ->
					%% 未知错误
					{fail, ?PM_HOME_NULL}
			end;
		false ->
			%% 没有家园
			{fail, ?PM_HOME_NOT_YET}
	end.


%% 0家园1土地2炼丹炉3矿井 
lvlup2(PS, Home, 0) ->
	NextLv = Home#home.lv_home + 1,
	case data_home_config:get(NextLv) of
		#home_config{lv_limit = LvLimit,
					 upgrade_money = {PriceType, Price}} ->
			case player:get_lv(PS) >= LvLimit of 
				true ->
					case player:check_need_price(PS, PriceType, Price) of
						ok ->
							player:cost_money(PS, PriceType, Price, [?LOG_HOME, "lvlup"]),
							?Ifc(NextLv =:=2) 
	                        mod_broadcast:send_sys_broadcast(373, [
					        player:get_name(PS)])
                            ?End,

                            ?Ifc(NextLv =:=3) 
	                        mod_broadcast:send_sys_broadcast(374, [
					        player:get_name(PS)])
                            ?End,

							NewHome = notify_achi(Home#home{lv_home = NextLv}, ?HOME_ACHIEVEMENT_TYPE_LV_HOME, 1),
							update_home(Home, NewHome),
							{ok, NextLv};
						Reason ->
							{fail, Reason}
					end;
				false ->
					%% 角色等级不足
					{fail, ?PM_LV_LIMIT}
			end;
		_ ->
			%% 最高级了
			{fail, ?PM_HOME_LV_MAX}
	end;

lvlup2(PS, Home, Type) ->
	L = [{1, #home.lv_land, data_home_land, #home_land.home_lv_limit, #home_land.upgrade_money, ?HOME_ACHIEVEMENT_TYPE_LV_LAND},
		 {2, #home.lv_dan, data_home_dan, #home_dan.home_lv_limit, #home_dan.upgrade_money, ?HOME_ACHIEVEMENT_TYPE_LV_DAN},
		 {3, #home.lv_mine, data_home_mine, #home_mine.home_lv_limit, #home_mine.upgrade_money, ?HOME_ACHIEVEMENT_TYPE_LV_MINE}],
	case lists:keyfind(Type, 1, L) of
		{Type, PosHome, Mod, PosHomeLvLimit, PosUpgradeMoney, AchiType} ->
			NextLv = erlang:element(PosHome, Home) + 1,
			case Mod:get(NextLv) of
				DataConfig when erlang:is_tuple(DataConfig) ->
					HomeLvLimit = erlang:element(PosHomeLvLimit, DataConfig),
					{PriceType, Price} = erlang:element(PosUpgradeMoney, DataConfig),
					case Home#home.lv_home >= HomeLvLimit of 
						true ->
							case player:check_need_price(PS, PriceType, Price) of
								ok ->
									player:cost_money(PS, PriceType, Price, [?LOG_HOME, "lvlup"]),
									NewHome = notify_achi(erlang:setelement(PosHome, Home, NextLv), AchiType, 1),
									update_home(Home, NewHome),
									{ok, NextLv};
								Reason ->
									{fail, Reason}
							end;
						false ->
							%% 家园等级不足
							{fail, ?PM_HOME_LV_LIMIT}
					end;
				_ ->
					%% 最高级了
					{fail, ?PM_HOME_LV_MAX}
			end;
		false ->
			%% 参数错误
			{fail, ?PM_COUPLE_ERROR_SYS}
	end.



%% 家园开始种植/炼丹/挖矿（土地，炼丹炉，矿井）
job_start(PS,Type,No,GoodsNo,PartnerId) ->
	PlayerId = player:id(PS),
	case check_grid_no(PS, Type, No) of
		true ->
			case check_partner_state_free(PS, PartnerId) of
				ok ->
					IsCanNew = 
						case get_home_data(PlayerId, Type, No) of
							{ok, HomeData} ->
								case HomeData#home_data.goods_no of 
									0 ->
										true;
									_ ->
										false
								end;
							false ->
								true
						end,  
					case IsCanNew of
						true ->
							case data_home_production:get(GoodsNo) of
								#home_production{cost = Cost} ->
									GoodsList = 
										case is_list(Cost) of
											true ->
												Cost;
											false ->
												case is_tuple(Cost) of
													true ->
														[Cost];
													false ->
														[]
												end
										end,
									case mod_inv:check_batch_destroy_goods(PlayerId, GoodsList) of
										ok ->
											mod_inv:destroy_goods_WNC(PlayerId, GoodsList, [?LOG_HOME, "job_start"]),
											Unixtime = util:unixtime(),
											NewHomeData = #home_data{key = {PlayerId, Type, No},
																	 id = PlayerId,
																	 type = Type,
																	 no = No,
																	 goods_no = GoodsNo,
																	 partner_id = PartnerId,
																	 start_time = Unixtime,
																	 time_speedup = 0,
																	 reward_multi = 0,
																	 reward_lvlup = 0,
																	 is_refresh_mon = 0,
																	 is_mon_steal = 0,
																	 is_steal = 0,
																	 create_time = Unixtime													 
																	},
											ets:insert(?MY_ETS_HOME_DATA(PlayerId), NewHomeData),
											Field_Value_List = [
																{id, NewHomeData#home_data.id},
																{type, NewHomeData#home_data.type},
																{no, NewHomeData#home_data.no},
																{goods_no, NewHomeData#home_data.goods_no},
																{partner_id, NewHomeData#home_data.partner_id},
																{start_time, NewHomeData#home_data.start_time},
																{time_speedup, NewHomeData#home_data.time_speedup},
																{reward_multi, NewHomeData#home_data.reward_multi},
																{reward_lvlup, NewHomeData#home_data.reward_lvlup},
																{create_time, NewHomeData#home_data.create_time},
																{is_steal, NewHomeData#home_data.is_steal}],
											%% TODO?这里是否可以优化
											db:replace(home_data, Field_Value_List),
											set_partner_state_work(PS, PartnerId),
											{ok, Home} = lib_home:get_home(player:get_id(PS)),
											{ok, Bin} = pt_37:write(?PT_HOME_JOB_START, [NewHomeData]),
											IdList = lib_scene:get_scene_player_ids(Home#home.scene_id),
											F = fun(X) ->
														case X =:= player:get_id(PS) of
															true -> skip;
															false -> lib_send:send_to_uid(X, Bin)
														end
														
												end,
											lists:foreach(F,IdList),
											lib_send:send_to_sock(PS, Bin),
											add_ripe_timer(NewHomeData),
											ok;
										{fail, Reason} ->
											{fail, Reason}
									end;
								_ ->
									{fail, ?PM_DATA_CONFIG_ERROR}
							end;
						false ->
							% 格子还有东西，不能操作
							{fail, ?PM_HOME_GRID_DO_BAN}
					end;
				{fail, Reason} ->
					{fail, Reason}
			end;
		false ->
			% 格子编号无效
			{fail, ?PM_HOME_GRID_INVALID}
	end.

%% 家园行为 1(浇水/传力/充能) 2(除虫/注入/强化) 3施肥(土地特有)
job_action(PS, Type, No, Action) ->
	PlayerId = player:id(PS),
	case get_home(PlayerId) of
		{ok, Home} ->
			case get_home_data(PlayerId, Type, No) of
				{ok, HomeData} ->
					case check_grid_state(HomeData) of
						{ok, State} when State == ?HOME_DATA_STATE_SEED orelse
											 State == ?HOME_DATA_STATE_GROW ->
							case check_job_action_count(HomeData, Action) of
								{ok, HomeData2} ->
									job_action(PS, Home, HomeData, HomeData2, Type, Action);
								{fail, Reason} ->
									{fail, Reason}
							end;
						_ ->
							{fail, ?PM_HOME_GRID_DO_BAN}
					end;
				false ->
					{fail, ?PM_HOME_GRID_INVALID}
			end;
		false ->
			{fail, ?PM_HOME_NULL}
	end.

%% 特殊处理施肥，其他的统一处理
job_action(PS, Home, OldHomeData, HomeData, 1 = Type, 3 = Action) ->
	case data_home_land:get(Home#home.lv_land) of
		#home_land{reward_upgrade_proba = RewardUpgradeProba} ->
			case data_home_production:get(HomeData#home_data.goods_no) of
				#home_production{reward_upgrade = RewardUpgrade} ->
					ProbaValL = 
						lists:foldl(fun(N, Acc) ->
											[{element(N, RewardUpgradeProba), element(N, RewardUpgrade)}|Acc]
									end, [], lists:seq(1, tuple_size(RewardUpgradeProba))),
					{Proba, Val} = util:rand_by_weight2(ProbaValL, 1),
					NewHomeData = 
						case case lists:keyfind(HomeData#home_data.reward_lvlup, 2, ProbaValL) of
								 {ProbaOld, _} ->
									 Proba < ProbaOld;
								 false ->
									 true 
							 end of
							true ->
								% 保留
								HomeData2 = HomeData#home_data{reward_lvlup = Val},
								HomeData2;
							false ->
								% 不保留
								HomeData
						end,
					update_home_data(OldHomeData, NewHomeData),
					EffNow = Val,
					EffFinal = NewHomeData#home_data.reward_lvlup,
					No = HomeData#home_data.no,
					{ok, Bin} = pt_37:write(?PT_HOME_JOB_ACTION, [Type, No, Action, EffNow, EffFinal]),
					{ok, Home} = lib_home:get_home(player:get_id(PS)),
					IdList = lib_scene:get_scene_player_ids(Home#home.scene_id),
					F = fun(X) ->
								case X =:= player:get_id(PS) of
									true -> skip;
									false -> lib_send:send_to_uid(X, Bin)
								end
						
						end,
					lists:foreach(F,IdList ),
					lib_send:send_to_sock(PS, Bin),
					ok;
				_ ->
					{fail, ?PM_DATA_CONFIG_ERROR}
			end;
		_ ->
			{fail, ?PM_DATA_CONFIG_ERROR}
	end;

job_action(PS, Home, OldHomeData, HomeData, Type, Action) ->
	L = [{{1, 1}, #home.lv_land, #home_data.time_speedup, data_home_land, #home_land.advance_time, #home_land.advance_proba}, %% 浇水
		 {{1, 2}, #home.lv_land, #home_data.reward_multi, data_home_land, #home_land.insecticide_effect, #home_land.insecticide_effect_proba}, %% 除虫
		 {{2, 1}, #home.lv_dan, #home_data.time_speedup, data_home_dan, #home_dan.force_time, #home_dan.force_proba}, %% 传力
		 {{2, 2}, #home.lv_dan, #home_data.reward_multi, data_home_dan, #home_dan.inject_effect, #home_dan.inject_effect_proba}, %% 注入
		 {{3, 1}, #home.lv_mine, #home_data.time_speedup, data_home_mine, #home_mine.charge_time, #home_mine.charge_proba}, %% 充能
		 {{3, 2}, #home.lv_mine, #home_data.reward_multi, data_home_mine, #home_mine.strengthen_effect, #home_mine.strengthen_effect_proba}  %% 强化
		 ],
	case lists:keyfind({Type, Action}, 1, L) of
		{_, LvPos, EffPos, Mod, PosVal, PosProba} ->
			Lv = erlang:element(LvPos, Home),
			case Mod:get(Lv) of
				DataConfig when erlang:is_tuple(DataConfig) ->
					ValTuple = erlang:element(PosVal, DataConfig),
					ProbaTuple = erlang:element(PosProba, DataConfig),
					ProbaValL = 
						lists:foldl(fun(N, Acc) ->
											[{element(N, ProbaTuple), element(N, ValTuple)}|Acc]
									end, [], lists:seq(1, tuple_size(ValTuple))),
					{_, Val} = util:rand_by_weight2(ProbaValL, 1),
					NewEffVal = erlang:element(EffPos, HomeData) + Val,
					NewHomeData = erlang:setelement(EffPos, HomeData, NewEffVal),
					case   NewHomeData#home_data.reward_multi >= 3 of 
						true ->
                                GoodsNo = HomeData#home_data.goods_no,
                               % Goods = lib_goods:get_tpl_data(GoodsNo),
                               % GoodsId = lib_goods:get_id(Goods),
                                Quality = lib_goods:get_quality(GoodsNo),
                                UID = player:id(PS),
                                Name = player:get_name(PS),
								mod_broadcast:send_sys_broadcast(382, [Name, UID, GoodsNo, 0, 1,0]);
					    false -> skip
			%		(data_goods:get(HomeData#home_data.goods_no))#goods_tpl.name
                    end,
					update_home_data(OldHomeData, NewHomeData),
					EffNow = Val,
					EffFinal = erlang:element(EffPos, HomeData),
					No = HomeData#home_data.no,
					{ok, Bin} = pt_37:write(?PT_HOME_JOB_ACTION, [Type, No, Action, EffNow, EffFinal]),
					IdList = lib_scene:get_scene_player_ids(Home#home.scene_id),
					F = fun(X) ->
								case X =:= player:get_id(PS) of
									true -> skip;
									false -> lib_send:send_to_uid(X, Bin)
								end
						
						end,
					lists:foreach(F,IdList ),
					lib_send:send_to_sock(PS, Bin),
					add_ripe_timer(OldHomeData, NewHomeData),
					ok;
				_ ->
					{fail, ?PM_DATA_CONFIG_ERROR}
			end;
		false ->
			{fail, ?PM_DATA_CONFIG_ERROR}
	end.

%%-----------家园 1(铲除/中断/召回) 2收获------------
job_action_finish(PS, Type, No, 1) ->
	PlayerId = player:id(PS),
	case get_home_data(PlayerId, Type, No) of
		{ok, HomeData} ->
			delete_home_data(HomeData),
			free_partner_state(PS, HomeData#home_data.partner_id),
			{ok,0};
		false ->
			{fail, ?PM_HOME_GRID_DO_BAN}
	end;

job_action_finish(PS, Type, No, 2) ->
	Home_id = get_home_id_from_ets(player:id(PS)),
	case  Home_id#home_id.id =:= player:id(PS) of
		true  ->
			PlayerId = player:id(PS),
			case get_home(PlayerId) of
				{ok, Home} ->
					case get_home_data(PlayerId, Type, No) of
						{ok, HomeData} ->
							case check_grid_state(HomeData) of
								{ok, ?HOME_DATA_STATE_RIPE} ->
									RewardGoodsNo = 
										case HomeData#home_data.reward_lvlup of
											0 ->
												HomeData#home_data.goods_no;
											_ ->
												HomeData#home_data.reward_lvlup
										end,
									Count1 = case HomeData#home_data.reward_multi > 0 of
												 true -> %需要获取到花的nohome_data
													 HomeData#home_data.reward_multi * (data_home_production:get(HomeData#home_data.goods_no))#home_production.production_num;
												 false ->
													 (data_home_production:get(HomeData#home_data.goods_no))#home_production.production_num
											 end,
									Count = case HomeData#home_data.is_steal of 
												1 -> case random:uniform(8) of 
														 1 -> util:ceil(Count1 * 0.65 );
														 2 -> util:ceil(Count1 * 0.6 );
														 3 -> util:ceil(Count1 * 0.7);
														 4 -> util:ceil(Count1 * 0.75 );
														 5 -> util:ceil(Count1 * 0.75 );
														 6 -> util:ceil(Count1 * 0.8 );
														 7 -> util:ceil(Count1 * 0.8 );
														 _ -> util:ceil(Count1 * 0.85 )
													 end;
												0 -> Count1
											end,
									Count2 = 
										case HomeData#home_data.is_mon_steal of
											0 ->								
												Count;
											_ ->
												
												util:ceil(Count * 0.8)
										end,
									
									mod_inv:batch_smart_add_new_goods(PlayerId, [{RewardGoodsNo, Count2}], [{bind_state, ?BIND_ALREADY}], [?LOG_HOME, "harvest"]),
									delete_home_data(HomeData),
									free_partner_state(PS, HomeData#home_data.partner_id),
									PartnerNo = 
										case lib_partner:get_partner(HomeData#home_data.partner_id) of
											null ->
												0;
											Partner ->
												lib_partner:get_no(Partner)
										end,
									AchiTypes = get_achi_type_list(PartnerNo),
									Home2 = 
										lists:foldl(fun(AchiType, HomeAcc) ->
															notify_achi(HomeAcc, AchiType, 1)
													end, Home, AchiTypes),
									L = [{?HOME_DATA_TYPE_LAND, ?HOME_ACHIEVEMENT_TYPE_COUNT_REWARD_LAND},
										 {?HOME_DATA_TYPE_DAN, ?HOME_ACHIEVEMENT_TYPE_COUNT_REWARD_DAN},
										 {?HOME_DATA_TYPE_MINE, ?HOME_ACHIEVEMENT_TYPE_COUNT_REWARD_MINE}],
									{Type, AchiTypeReward} = lists:keyfind(Type, 1, L),
									NewHome = notify_achi(Home2, AchiTypeReward, 1),
									update_home(Home, NewHome),
									{ok,0};
								_ ->
									{fail, ?PM_HOME_GRID_DO_BAN}
							end;
						false ->
							{fail, ?PM_HOME_GRID_DO_BAN}
					end;
				false ->
					{fail, ?PM_HOME_NOT_YET}
			end;
		false -> 
			Home_Id = #home_id{player_id =player:id(PS) ,type = Type, no = No, id = Home_id#home_id.id, battle_result=10 },
			lib_home:add_home_id_to_ets(Home_Id),
			case get_home(Home_id#home_id.id) of
				{ok, _} ->
					case get_home_data(Home_id#home_id.id, Type, No) of
						{ok, HomeData} ->
							case HomeData#home_data.is_steal =:= 0 of
								true ->
									%陌生人偷菜必进入战斗，成功则偷取20%，失败则skip
									%好友偷菜
									Fun = fun(E) -> E =:= Home_id#home_id.id end,
									L = lists:filter(Fun,ply_relation:get_friend_id_list(PS)),%不为空表示双方为好友
									case  L  of
										[_L] -> case random:uniform(10) >= 5 of
													true ->  %顺利偷菜
														case check_grid_state(HomeData) of
															{ok, ?HOME_DATA_STATE_RIPE} ->
																RewardGoodsNo = 
																	case HomeData#home_data.reward_lvlup of
																		0 ->
																			HomeData#home_data.goods_no;
																		_ ->
																			HomeData#home_data.reward_lvlup
																	end, 
																Count = case HomeData#home_data.reward_multi > 0 of
																			true -> %需要获取到花的nohome_data
																				util:ceil(HomeData#home_data.reward_multi * (data_home_production:get(HomeData#home_data.goods_no))#home_production.production_num * 0.2);
																			false ->
																				util:ceil( (data_home_production:get(HomeData#home_data.goods_no))#home_production.production_num *0.2 )
																		end,
																mod_inv:batch_smart_add_new_goods(player:id(PS), [{RewardGoodsNo, Count}], [{bind_state, ?BIND_ALREADY}], [?LOG_HOME, "harvest"]),
																NewHomeData = HomeData#home_data{ is_steal =1},
																update_home_data(HomeData,NewHomeData);
															_ ->
																{fail, ?PM_HOME_GRID_DO_BAN}
														end;
													
													false -> case check_grid_state(HomeData) of
																 {ok, ?HOME_DATA_STATE_RIPE} ->
																	 gen_server:cast(player:get_pid(player:id(PS)), {start_steal, Home_id#home_id.id}),
																	
																	 %gen_server:cast(player:get_pid(player:id(PS)), {start_steal, Home_id#home_id.id}),
																	 T_Home_id = lib_home:get_home_id_from_ets(player:id(PS)),
																	 case T_Home_id#home_id.battle_result of
																		 0 -> {fail,?PM_HOME_GOODS_STEAL_FAIL};
																		 _ -> {ok,1}
																	 end;
																 _ ->
																	 {fail, ?PM_HOME_GRID_DO_BAN}
															 end
												end;
										
										[] ->   case check_grid_state(HomeData) of
													{ok, ?HOME_DATA_STATE_RIPE} ->
														gen_server:cast(player:get_pid(player:id(PS)), {start_steal, Home_id#home_id.id}),
														
														%gen_server:cast(player:get_pid(player:id(PS)), {start_steal, Home_id#home_id.id}),
														T_Home_id = lib_home:get_home_id_from_ets(player:id(PS)),
														case T_Home_id#home_id.battle_result of
															0 -> {fail,?PM_HOME_GOODS_STEAL_FAIL};
															_ -> {ok,1}
														end;
													_ ->
														{fail, ?PM_HOME_GRID_DO_BAN}
												end
									
									end;
								false ->
									{fail,?PM_HOME_GOODS_IS_STEAL}
							end;
						false ->
							{fail, ?PM_HOME_GRID_DO_BAN}
					end;
				false ->
					{fail, ?PM_HOME_NOT_YET}
			end
	
	end.

get_home_id_from_ets(PlayerId) ->
    case ets:lookup(?ETS_HOME_ID, PlayerId) of
        [] -> 
            null;
        [R] ->
            R
    end.

add_home_id_to_ets(HomeID) when is_record(HomeID, home_id) ->
    ets:insert(?ETS_HOME_ID, HomeID).





%% 家园成就数据
achievement_data(PS) ->
	case get_home(PS) of
		{ok, #home{achievement_value = AchievementValue, achievement_reward_nos = AchievementRewardNos,degree = Degree}} ->
			case lists:keytake(11, 1, AchievementValue) of 
				{value,_,_} -> {ok, AchievementValue , AchievementRewardNos};
				false ->  {ok,Home} = get_home(PS),
					      NewHome = notify_achi(Home, ?HOME_ACHIEVEMENT_TYPE_DEGREE, Degree),
	                      update_home(Home, NewHome),
						  {ok,AchievementValue, AchievementRewardNos}
			end;
			
		false ->
			{fail, ?PM_HOME_NOT_YET}
	end.


%% 领取成就奖励
achievement_reward(PS, No) ->
	case get_home(PS) of
		{ok, #home{
				   degree = Degree,
				   achievement_value = AchievementValue,
				   achievement_reward_nos = AchievementRewardNos
				  } = Home} ->
			%% 领取奖励先判断是否已领取且达到条件值
			case lists:member(No, AchievementRewardNos) of
				false ->
					case data_home_achievement:get(No) of
						#home_achievement{
										  type = Type,
										  num = Num,
										  reward = RewardNum,
										  goods  = GoodsNo
										 } ->
							IsFinish = 
								case lists:keyfind(Type, 1, AchievementValue) of
									{Type, Value} ->
										Value >= Num;
									false ->
										false
								end,
							case IsFinish of
								true ->
									%新成就
                                    ?Ifc(GoodsNo =/= 0)
									mod_inv:batch_smart_add_new_goods(player:get_id(PS), [GoodsNo], [{bind_state, ?BIND_ALREADY}], [?LOG_HOME, "achievement"])
							        ?End,
									DegreeAdd = RewardNum,
									NewHome = add_degree(PS, Home#home{achievement_reward_nos = [No|AchievementRewardNos]}, DegreeAdd),
									update_home(Home, NewHome),
									%% 通知前端数据有变化
									ok;
								false ->
									% 没达成
									{fail, ?PM_HOME_ACHI_REWARD_UNFINISH}
							end;
						_ ->
							{fail, ?PM_DATA_CONFIG_ERROR}
					end;
				true ->
					{fail, ?PM_HOME_ACHI_REWARD_ALREADY}
			end;
		false ->
			{fail, ?PM_HOME_NOT_YET}
	end.

%% 增加豪华度，更新home，不返回
add_degree(PS, DegreeAdd) ->
	RoleId = player:id(PS),
	case get_home(RoleId) of
		{ok, Home} ->
			NewHome = add_degree(PS, Home, DegreeAdd),
			update_home(Home, NewHome);
		false ->
			lib_send:send_prompt_msg(RoleId, ?PM_HOME_NOT_YET)
	end.

%% 增加豪华度，不更新ets和db，返回给上层函数
add_degree(PS, Home, DegreeAdd) ->

	Degree = Home#home.degree + DegreeAdd,
	?Ifc(Home#home.degree <2500 andalso Degree >= 2500 andalso Degree < 4000  ) 
	mod_broadcast:send_sys_broadcast(362, [
					player:get_name(PS)])
    ?End,

    NewHome = notify_achi(Home, ?HOME_ACHIEVEMENT_TYPE_DEGREE, DegreeAdd),
	update_home(Home, NewHome),

	?Ifc(Home#home.degree <4000 andalso Degree >= 4000 andalso Degree < 5000 ) 
	mod_broadcast:send_sys_broadcast(363, [
					player:get_name(PS)])
    ?End,

	?Ifc(Home#home.degree <5000 andalso Degree >= 5000 ) 
	mod_broadcast:send_sys_broadcast(364, [
					player:get_name(PS)])
    ?End,
	    
	mod_rank:role_home_degree(PS, Degree),
	Home#home{degree = Degree}.



%% 增加成熟定时任务
add_ripe_timer(HomeData) ->
	PlayerId = HomeData#home_data.id,
	Type = HomeData#home_data.type,
	No = HomeData#home_data.no,
	RipeUnixtime = calc_ripe_timer(HomeData),
	mod_home:add_home_timer(PlayerId, Type, No, RipeUnixtime).


add_ripe_timer(OldHomeData, NewHomeData) ->
	PlayerId = OldHomeData#home_data.id,
	Type = OldHomeData#home_data.type,
	No = OldHomeData#home_data.no,
	AbandonUnixtime = calc_ripe_timer(OldHomeData),
	RipeUnixtime = calc_ripe_timer(NewHomeData),
	case AbandonUnixtime of
		RipeUnixtime ->
			skip;
		_ ->
			mod_home:add_home_timer(PlayerId, Type, No, RipeUnixtime, AbandonUnixtime)
	end.

calc_ripe_timer(HomeData) ->
	StartTime = HomeData#home_data.start_time,
	TimeSpeedup = HomeData#home_data.time_speedup,
	#home_production{seedling = Seedling,
					 growth = Growth} = data_home_production:get(HomeData#home_data.goods_no),
	GrowHourSum = (Seedling + Growth),
	RipeUnixtime = StartTime + (GrowHourSum * 3600) - (TimeSpeedup * 60),
	RipeUnixtime.

%% 刷怪逻辑（成熟的时候调用，只记录是否已刷怪）
refresh_mon(PlayerId, Type, No, TimeNow) ->
	case get_home(PlayerId) of
		{ok, Home} ->
			case get_home_data(PlayerId, Type, No) of
				{ok, HomeData} ->
					case HomeData#home_data.is_refresh_mon =/= 1 of
						true ->
							case check_grid_state(HomeData, TimeNow) of %% 这里做个5秒误差?
								{ok, ?HOME_DATA_STATE_RIPE} ->%% 这里是否需要做这个判断呢？因为上层调用保证了此刻已经是成熟时期，为避免状态不同步的情况，HOW？
									%% 刷怪并保存已刷的怪物ID到格子上
									do_refresh_mon(PlayerId, Type, No, TimeNow, Home, HomeData),
									HomeData2 = HomeData#home_data{is_refresh_mon = 1},
									update_home_data(HomeData, HomeData2);
								S ->
									?ERROR_MSG("refresh_mon(PlayerId, Type, No, State) : ~p~n", [{PlayerId, Type, No, S}])
							end;
						_ ->
							skip
					end;
				false ->
					?ERROR_MSG("refresh_mon(PlayerId, Type, No) : ~p~n", [{PlayerId, Type, No}])
			end;
		false ->
			?ERROR_MSG("refresh_mon(PlayerId, Type, No) : ~p~n", [{PlayerId, Type, No}])
	end.


%% 执行刷怪的具体逻辑
%% do_refresh_mon(Home, HomeData) ->
%% 	ok;

do_refresh_mon(PlayerId, Type, No, TimeNow, Home, HomeData) ->
	#home_production{mon_broadcast = MonBroadcast,
					 mon = MonNo,
					 mon_proba = MonProba,
					 mon_xy = MonXy} = data_home_production:get(HomeData#home_data.goods_no),
	SceneId = Home#home.scene_id,
	case MonProba > 0 of
		true ->
			case util:rand(1, 100) > MonProba of
				true ->
					{X, Y} = list_util:rand_pick_one(MonXy),
					case mod_scene:spawn_mon_to_scene_for_public_WNC(MonNo, SceneId, X, Y) of
						{_, MonId} ->
							mod_broadcast:send_sys_broadcast(MonBroadcast, [player:get_name(Home#home.id)]),
							%% 设置30分钟后检查一次？还是读取配置表明雷怪的有效时间，
							case mod_mon_tpl:get_existing_time(MonNo) of
								0 ->
									%% 配置表错误
									?ERROR_MSG("mod_mon_tpl:get_existing_time(MonNo): ~p~n", [{MonNo}]);
								ExpireTime ->
									%% 怪物消失前5秒
                                   
									mod_home:add_mon_timer(PlayerId, Type, No, MonId, TimeNow + ExpireTime - 5)
							end,
							{ok, MonId};
						fail ->
							?ERROR_MSG("refresh mon error {MonNo, SceneId, X, Y}: ~p~n", [{MonNo, SceneId, X, Y}])
					end;
				false ->
					ok
			end;
		false ->
			skip
	end.


mon_steal(PlayerId, Type, No, MonId, TimeNow) ->?DEBUG_MSG("monTestlib_home0= ~p~n",[{Type,No}]),
	case mod_mon:is_exists(MonId) of
		?true ->?DEBUG_MSG("monTestlib_home1= ~p~n",[{Type,No}]),
			case get_home_data(PlayerId, Type, No) of
				{ok, HomeData} ->?DEBUG_MSG("monTestlib_home2= ~p~n",[{Type,No}]),
					?DEBUG_MSG("monTestlib_home943= ~p~n",[MonId]),
					case check_grid_state(HomeData, TimeNow) of %% 这里做个5秒误差?
						{ok, ?HOME_DATA_STATE_RIPE} ->?DEBUG_MSG("monTestlib_home3= ~p~n",[{Type,No}]),%% 这里是否需要做这个判断呢？因为上层调用保证了此刻已经是成熟时期，为避免状态不同步的情况，HOW？
							%% 刷怪并保存已刷的怪物ID到格子上
							HomeData2 = HomeData#home_data{is_mon_steal = 1},
							?DEBUG_MSG("monTestlib_home4= ~p~n",[{Type,No,HomeData2#home_data.is_mon_steal}]),
							%?DEBUG_MSG("monTestlib_home948= ~p~n",[HomeData2#home_data.is_mon_steal]),
							update_home_data(HomeData, HomeData2);
						_ ->?DEBUG_MSG("monTestlib_home5= ~p~n",[{Type,No}]),
							skip
					end;
				false ->?DEBUG_MSG("monTestlib_home6= ~p~n",[{Type,No}]),
					skip
			end;
		false ->?DEBUG_MSG("monTestlib_home7= ~p~n",[{Type,No}]),
			skip
	end.





get_achi_type_list(PartnerNo) ->
	Nos = data_home_achievement:get_nos(),
	Fun = fun(No, Acc) ->
				  case data_home_achievement:get(No) of
					  #home_achievement{type = Type, partner_id = PartnerId} ->
						  case lists:member(Type, Acc) of
							  true ->
								  Acc;
							  false ->
								  PartnerIdL = 
									  case erlang:is_list(PartnerId) of
										  true ->
											  PartnerId;
										  false ->
											  case erlang:is_tuple(PartnerId) of
												  true ->
													  erlang:tuple_to_list(PartnerId);
												  false ->
													  []
											  end
									  end,
								  case lists:member(PartnerNo, PartnerIdL) of
									  true ->
										  [Type|Acc];
									  false ->
										  Acc
								  end;
							  _ ->
								  Acc
						  end
				  end
		  end,
	lists:foldl(Fun, [], Nos).

%% 不保存,返回新home
notify_achi(#home{achievement_value = AchievementValue} = Home, AchiType, Value) ->
	NewAchievementValue = 
		case lists:keytake(AchiType, 1, AchievementValue) of
			{value, {AchiType, OldValue}, AchievementValue2} ->
				[{AchiType, OldValue + Value}|AchievementValue2];
			false ->
				[{AchiType, Value}|AchievementValue]
		end,
	Home2 = Home#home{achievement_value = NewAchievementValue},
	%% 通知前端发生了变化
	Home2.
	


%% 检查格子状态，这里需要区分植物和炼丹还有挖矿的状态差异
check_grid_state(HomeData) ->
	TimeNow = util:unixtime(),
	check_grid_state(HomeData, TimeNow).
	
check_grid_state(#home_data{goods_no = 0}, _TimeNow) ->
	false;

check_grid_state(HomeData, TimeNow) ->
	#home_data{type = Type,
			   goods_no = GoodsNo,
			   start_time = StartTime,
			   time_speedup = TimeSpeedUp} = HomeData,
	case data_home_production:get(GoodsNo) of
		#home_production{seedling = Seedling,
						 growth = Growth,
						 maturity = Maturity} ->
			State = 
				case Type of 
					?HOME_DATA_TYPE_LAND ->
						case TimeNow - StartTime < Seedling * 3600 of
							true ->
								% 幼苗期
								?HOME_DATA_STATE_SEED;
							false ->
								case TimeNow + (TimeSpeedUp * 60) - StartTime < (Seedling + Growth) * 3600 of
									true ->
										% 成长期
										?HOME_DATA_STATE_GROW;
									false ->
										case TimeNow + (TimeSpeedUp * 60) - StartTime < (Seedling + Growth + Maturity) * 3600 of
											true ->
												% 成熟期
												?HOME_DATA_STATE_RIPE;
											false ->
												% 枯萎期
												?HOME_DATA_STATE_DIE
										end
								end
						end;
					_ ->
						case TimeNow + (TimeSpeedUp * 60) - StartTime < Seedling * 3600 of
							true ->
								?HOME_DATA_STATE_GROW;
							false ->
								?HOME_DATA_STATE_RIPE
						end
				end,
			{ok, State};
		_ ->
			false
	end.
	

check_job_action_count(HomeData, Action) ->
	L = [{1, #home_data.count_action_speedup},
		 {2, #home_data.count_action_multi},
		 {3, #home_data.count_action_lvlup}],
	case lists:keyfind(Action, 1, L) of
		{Action, Pos} ->
			Count = erlang:element(Pos, HomeData),
			case Count < 3 of
				true ->
					{ok, erlang:setelement(Pos, HomeData, Count + 1)};
				false ->
					% 次数已达到上限
					{fail, ?PM_HOME_ACTION_COUNT_MAX}
			end;
		false ->
			{fail, ?PM_DATA_CONFIG_ERROR}
	end.


%% 检查格子编号是否有效
check_grid_no(PS, Type, No) ->
	PlayerId = player:id(PS),
	case get_home(PlayerId) of
		{ok, Home} ->
			L = [{1, #home.lv_land, data_home_land, #home_land.lattice_num},
				 {2, #home.lv_dan, data_home_dan, #home_dan.lattice_num},
				 {3, #home.lv_mine, data_home_mine, #home_mine.lattice_num}],
			case lists:keyfind(Type, 1, L) of
				{Type, Pos, DataMod, PosLattice} ->
					Lv = erlang:element(Pos, Home),
					case DataMod:get(Lv) of
						DataConfig when is_tuple(DataConfig) ->
							LatticeNum = erlang:element(PosLattice, DataConfig),
							LatticeNum >= No;
						_ ->
							% 数据不存在
							false
					end;
				false ->
					% 参数错误
					false
			end;
		false ->
			% 没有家园
			false
	end.
	

check_partner_state_free(PS, PartnerId) ->
	Partner = lib_partner:get_partner(PartnerId),
	case Partner of
		null ->
			{fail, ?PM_PAR_NOT_EXISTS};
		_ ->
			case player:has_partner(PS, PartnerId) of
				false ->
					{fail, ?PM_PAR_NOT_EXISTS};
				true ->
					case lib_partner:get_state(Partner) of
						?PAR_STATE_REST_UNLOCKED ->
							ok;
						_ ->
							{fail, ?PM_HOME_PARTNER_EMPLOY_STATE}
					end
			end
	end.

free_partner_state(_PS, 0) -> ok;
free_partner_state(PS, PartnerId) ->
	do_set_partner_state(PS, PartnerId, ?PAR_STATE_REST_UNLOCKED).


set_partner_state_work(_PS, 0) -> ok;
set_partner_state_work(PS, PartnerId) ->
	do_set_partner_state(PS, PartnerId, ?PAR_STATE_HOME_WORK).

do_set_partner_state(PS, PartnerId, State) ->
	case ply_partner:set_partner_state(PS, PartnerId, State) of
        {fail, Reason} ->
            case Reason =:= ?PM_PAR_PLAYER_LV_LIMIT_FOR_BATTLE of
                true -> skip;
                false -> lib_send:send_prompt_msg(PS, Reason)
            end;
        {ok, PartnerId} ->
            {ok, BinData} = pt_17:write(?PT_SET_PARTNER_STATE, [?RES_OK, PartnerId, State]),
            lib_send:send_to_sock(PS, BinData)
    end.


check_home_scnene_exits(#home{scene_id = SceneId}) when is_integer(SceneId) ->
	lib_scene:is_exists(SceneId);


check_home_scnene_exits(PlayerId) when is_integer(PlayerId) ->
	case get_home(PlayerId) of
		{ok, Home} ->
			check_home_scnene_exits(Home);
		false ->
			false
	end;

check_home_scnene_exits(_) ->
	false.
	


%% 检查建造/升级家园是否满足要求
check_build_home(PS) ->
	check_build_home(PS, 1).

check_build_home(PS, LvHome) ->
	case data_home_config:get(LvHome) of
		#home_config{lv_limit = LvLimit, upgrade_money = UpgradeMoney} ->
			case player:get_lv(PS) >= LvLimit of
				?true ->
					{PriceType, Price} = UpgradeMoney,
					case player:check_need_price(PS, PriceType, Price) of
						ok ->
							ok;
						Reason ->
							{fail, Reason}
					end;
				?false ->
					%% 等级不足
					{fail, ?PM_LV_LIMIT}
			end;
		_ ->
			%% 参数错误
			{fail, ?PM_DATA_CONFIG_ERROR}
	end.


%% 建造/升级家园消耗
cost_build_home(PS) ->
	cost_build_home(PS, 1).

cost_build_home(PS, LvHome) ->
	case data_home_config:get(LvHome) of
		#home_config{upgrade_money = UpgradeMoney} ->
			{PriceType, Price} = UpgradeMoney,
			player:cost_money(PS, PriceType, Price, [?LOG_HOME, "lvlup"]),
			ok;
		_ ->
			%% 参数错误
			{fail, ?PM_DATA_CONFIG_ERROR}
	end.

grid_data(HomeData) ->
	#home_data{type = Type,
			   no = No,
			   goods_no = GoodsNo,
			   partner_id = PartnerId,
			   start_time = StartTime,
			   time_speedup = TimeSpeedUp,
			   reward_multi = RewardMulti,
			   reward_lvlup = RewardLvlup,
			   is_steal = IsSteal
			  } = HomeData,
	PartnerNo = 
		case lib_partner:get_partner(PartnerId) of
			null ->
				0;
			Partner ->
				lib_partner:get_no(Partner)
		end,
	<<Type:8,No:16,GoodsNo:32,PartnerNo:32,StartTime:32,TimeSpeedUp:16,RewardMulti:16,RewardLvlup:32,IsSteal:8>>.

%% 返回协议数据包
home_base_info(#home{id = RoleId} = Home) ->
	HomeDatas = get_home_datas(RoleId),
	home_base_info(Home, HomeDatas).

home_base_info(Home, HomeDatas) ->
	pt_37:write(?PT_HOME_BUILD, [Home, HomeDatas]).


get_home(RoleId) when is_integer(RoleId) ->
	case ets:lookup(?MY_ETS_HOME(RoleId), RoleId) of
		[Home] ->
			{ok, Home};
		[] ->
			%% 没有则从db里查询？
			load_home(RoleId),
			case ets:lookup(?MY_ETS_HOME(RoleId), RoleId) of
				[Home] ->
					{ok, Home};
				[] ->
					false
			end
	end;

get_home(PS) ->
	get_home(player:id(PS)).

get_home_data(PlayerId, Type, No) ->
	case ets:lookup(?MY_ETS_HOME_DATA(PlayerId), {PlayerId, Type, No}) of
		[HomeData] ->
			{ok, HomeData};
		[] ->
			false
	end.

get_home_datas(RoleId) ->
	Ms =  ets:fun2ms(fun(R) when RoleId =:= R#home_data.id -> 
							 R 
					 end),
    ets:select(?MY_ETS_HOME_DATA(RoleId), Ms).


update_home(#home{id = RoleId} = OldHome, NewHome) ->
	case lists:foldl(fun({Pos, DbFiled}, {PosValAcc, DbFieldValAcc}) ->
							 NewVal = erlang:element(Pos, NewHome),
							 case erlang:element(Pos, OldHome) =/= NewVal of
								 true ->
									 NewValDb = 
										 case lists:member(DbFiled, ?HOME_DB_FIELD_ESCAPE) of
											 true ->
												 util:term_to_bitstring(NewVal);
											 false ->
												 NewVal
										 end,
									 {[{Pos, NewVal}|PosValAcc], [{DbFiled, NewValDb}|DbFieldValAcc]};
								 _ ->
									 {PosValAcc, DbFieldValAcc}
							 end
					 end, {[], []}, ?HOME_POS_FIELD_LIST) of
		{[], []} ->
			ok;
		{PosValueL, DbFieldValL} ->
			ets:update_element(?MY_ETS_HOME(RoleId), RoleId, PosValueL),
			db:update(home, DbFieldValL, [{id, RoleId}])
	end.



update_home_data(OldHomeData, NewHomeData) ->
	case lists:foldl(fun({Pos, DbFiled}, {PosValAcc, DbFieldValAcc}) ->
							 NewVal = erlang:element(Pos, NewHomeData),
							 case erlang:element(Pos, OldHomeData) =/= NewVal of
								 true ->
									 {[{Pos, NewVal}|PosValAcc], [{DbFiled, NewVal}|DbFieldValAcc]};
								 _ ->
									 {PosValAcc, DbFieldValAcc}
							 end
					 end, {[], []}, ?HOME_DATA_POS_FIELD_LIST) of
		{[], []} ->
			ok;
		{PosValueL, DbFieldValL} ->
			RoleId = OldHomeData#home_data.id,
			Type = OldHomeData#home_data.type,
			No = OldHomeData#home_data.no,
			ets:update_element(?MY_ETS_HOME_DATA(RoleId), {RoleId, Type, No}, PosValueL),
			db:update(home_data, DbFieldValL, [{id, RoleId}, {type, Type}, {no, No}])
	end.


delete_home_data(HomeData) ->
	ets:delete(?MY_ETS_HOME_DATA(HomeData#home_data.id), HomeData#home_data.key),
	db:delete(home_data, [{id,HomeData#home_data.id},{type,HomeData#home_data.type},{no,HomeData#home_data.no}]).


%% 是否有家园，有则返回true
has_home(PS) when erlang:is_record(PS, player_status) ->
	has_home(player:id(PS));
	
has_home(RoleId) when erlang:is_integer(RoleId) ->
	ets:member(?MY_ETS_HOME(RoleId), RoleId).
	



my_ets_home(PlayerId) ->
	Suffix = (PlayerId rem ?ETS_HOME_COUNT) + 1,
	{Suffix, Tab} = lists:keyfind(Suffix, 1, ?ETS_HOME_LIST),
	Tab.

my_ets_home_data({PlayerId, _Type, _No}) ->
	my_ets_home_data(PlayerId);


my_ets_home_data(PlayerId) when erlang:is_integer(PlayerId) ->
	Suffix = (PlayerId rem ?ETS_HOME_DATA_COUNT) + 1,
	{Suffix, Tab} = lists:keyfind(Suffix, 1, ?ETS_HOME_DATA_LIST),
	Tab.

%% @doc 初始化家园数据
load_home(RoleId) ->
	Fields = "degree, lv_home, lv_land, lv_dan, lv_mine, achievement_value, achievement_reward_nos, create_time",
	case db:select_row(home, Fields, [{id, RoleId}]) of
		[] ->
			%% 没有就不管了
			ok;
		[Degree, LvHome, LvLand, LvDan, LvMine, AchievementValue0, AchievementRewardNos0, CreateTime] ->
			AchievementValue00 = util:bitstring_to_term(AchievementValue0),
			AchievementRewardNos00 = util:bitstring_to_term(AchievementRewardNos0),
			AchievementValue =
				case erlang:is_list(AchievementValue00) of
					true ->
						AchievementValue00;
					false ->
						[]
				end,
			AchievementRewardNos =
				case erlang:is_list(AchievementRewardNos00) of
					true ->
						AchievementRewardNos00;
					false ->
						[]
				end,
			Home = #home{
						 id = RoleId, 
						 degree = Degree, 
						 lv_home = LvHome, 
						 lv_land = LvLand, 
						 lv_dan = LvDan, 
						 lv_mine = LvMine, 
						 achievement_value = AchievementValue, 
						 achievement_reward_nos = AchievementRewardNos,
						 create_time = CreateTime
						},
			ets:insert(?MY_ETS_HOME(RoleId), Home),
			Fields_sql = "type, no, goods_no, partner_id, start_time, count_action_speedup, count_action_multi, count_action_lvlup, time_speedup, reward_multi, reward_lvlup, is_refresh_mon, is_mon_steal, create_time, is_steal",
			case db:select_all(home_data, Fields_sql, [{id, RoleId}]) of
				[] ->
					ok;
				DataList ->
					Fun = fun([Type, No, GoodsNo, PartnerId, StartTime, CountActionSpeedup, CountActionMulti, CountActionLvlup, TimeSpeedup, RewardMulti, RewardLvlup, RefreshMon, IsMonSteal, CreateTime, IsSteal], HomeDatasAcc) ->
								  Key = {RoleId, Type, No},
								  HomeData = #home_data{key = Key, 
														id = RoleId, 
														type = Type,
														no = No, 
														goods_no = GoodsNo, 
														partner_id = PartnerId,
														start_time = StartTime,
														count_action_speedup = CountActionSpeedup,
														count_action_multi = CountActionMulti,
														count_action_lvlup = CountActionLvlup,
														time_speedup = TimeSpeedup, 
														reward_multi = RewardMulti,
														reward_lvlup = RewardLvlup, 
														is_refresh_mon = RefreshMon,
														is_mon_steal = IsMonSteal,
														create_time = CreateTime,
														is_steal = IsSteal
														%偷的问题
													   },
								  [HomeData|HomeDatasAcc]
						  end,
					HomeDatas = lists:foldl(Fun, [], DataList),
					ets:insert(?MY_ETS_HOME_DATA(RoleId), HomeDatas)
			end
	end.

%% 插入数据库
db_insert_home(Home) ->
	#home{
		  id = RoleId, 
		  degree = Degree, 
		  lv_home = LvHome, 
		  lv_land = LvLand, 
		  lv_dan = LvDan, 
		  lv_mine = LvMine, 
		  achievement_value = AchievementValue0, 
		  achievement_reward_nos = AchievementRewardNos0,
		  create_time = CreateTime
		 } = Home,
	AchievementValue = util:term_to_bitstring(AchievementValue0),
	AchievementRewardNos = util:term_to_bitstring(AchievementRewardNos0),
	db:insert(home, [id, degree, lv_home, lv_land, lv_dan, lv_mine, achievement_value, achievement_reward_nos, create_time], 
			  [RoleId, Degree, LvHome, LvLand, LvDan, LvMine, AchievementValue, AchievementRewardNos, CreateTime]).

%% db_insert_home_data(HomeData) ->
%% 	#home_data{id = RoleId, 
%% 			   type = Type, 
%% 			   no = No, 
%% 			   goods_no = GoodsNo, 
%% 			   start_time = StartTime,
%% 			   time_speedup = TimeSpeedup, 
%% 			   reward_multi = RewardMulti,
%% 			   reward_lvlup = RewardLvlup, 
%% 			   create_time = CreateTime} = HomeData,
%% 	db:insert(home_data, [id, type, no, goods_no, start_time, time_speedup, reward_multi, reward_lvlup, create_time], 
%% 			  [RoleId, Type, No, GoodsNo, StartTime, TimeSpeedup, RewardMulti, RewardLvlup, CreateTime]).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 成就
%% home_achi() ->














