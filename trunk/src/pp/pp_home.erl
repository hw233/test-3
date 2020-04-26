%%%-------------------------------------- 
%%% @Module: pp_hire
%%% @Author: zwq
%%% @Created: 2013-12-31
%%% @Description: 
%%%-------------------------------------- 


-module(pp_home).


-export([handle/3]).

-include("common.hrl"). 
-include("pt_37.hrl").
-include("prompt_msg_code.hrl").
-include("hire.hrl").
-include("sys_code.hrl").
-include("home.hrl").
-include("offline_data.hrl").
-include("ets_name.hrl").

%% 请求总览信息/建造家园
handle(?PT_HOME_BUILD, PS, [Type]) ->
%%     {Len, L} = ply_hire:get_hire_list(PS, Faction, StartIndex, EndIndex, SortType),
%%     {ok, BinData} = pt_41:write(?GET_HIRE_LIST, [?RES_OK, Len, L]),
%%     lib_send:send_to_sock(PS, BinData);
	case lib_home:build_home(PS, Type) of
		ok ->
			ok;
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason)
	end;


%% 请求进入家园场景
handle(?PT_HOME_ENTER_SCENE, PS, [RoleID, Type]) ->
	case (player:is_in_team(PS)) of
		true ->  lib_send:send_prompt_msg(PS, ?PM_TASK_CAN_NO_IN_TEAM);
		false -> 
						 PlayerId = player:id(PS),
						 Home_Id =  #home_id{player_id =PlayerId ,id = RoleID},
						 lib_home:add_home_id_to_ets(Home_Id),
						 {TargetRoleId, GoType} = 
							 case RoleID == PlayerId orelse RoleID == 0 of
								 true ->
									 {PlayerId, Type};
								 false ->
									 {RoleID, 0}
							 end,
						 case lib_home:enter_home_scene(PS, TargetRoleId, GoType) of
							 ok ->
								 ok;
							 {fail, Reason} ->
								 lib_send:send_prompt_msg(PS, Reason)
						 end
	end;
		
       
	

%% 请求退出家园场景
handle(?PT_HOME_LEAVE_SCENE, PS, []) ->
	% 传出场景
	{SceneId, X, Y} = ply_scene:get_adjusted_pos(player:get_race(PS), player:get_lv(PS)),
	gen_server:cast(player:get_pid(PS), {'do_single_teleport', SceneId, X, Y}),
	ok;


%% 请求当前所在玩家家园场景信息
handle(?PT_GET_HOME_INFO, PS, []) ->
	case lib_home:get_home_scene_info(PS) of
		{ok, Bin} ->
			lib_send:send_to_sock(PS, Bin);
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason)
	end;


%% 家园升级
handle(?PT_HOME_LEVEL_UP, PS, [Type]) ->
	{ok, Home} = lib_home:get_home(player:get_id(PS)),
	case lib_home:lvlup(PS, Type) of
		{ok, Lv} ->
			{ok, Bin} = pt_37:write(?PT_HOME_LEVEL_UP, [Type, Lv]),
			IdList = lib_scene:get_scene_player_ids(Home#home.scene_id),
			F = fun(X) ->
						case X =:= player:get_id(PS) of
							true -> skip;
							false -> lib_send:send_to_uid(X, Bin)
						end
				
				end,
			lists:foreach(F,IdList ),
		
			lib_send:send_to_sock(PS, Bin);
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason)
	end;
			

%% 家园开始种植/炼丹/挖矿（土地，炼丹炉，矿井）
handle(?PT_HOME_JOB_START, PS, [Type,No,GoodsNo,PartnerId]) ->
	case lib_home:job_start(PS,Type,No,GoodsNo,PartnerId) of
		ok ->
			lib_offline_arena:update_arena_offline_data(PS), %更新宠物携带数据
			ok;
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason)
	end;
			


%% 家园行为 1(浇水/传力/充能) 2(除虫/注入/强化) 3施肥(土地特有)
handle(?PT_HOME_JOB_ACTION, PS, [Type,No,Action]) ->
	case lib_home:job_action(PS, Type, No, Action) of
		ok ->
			ok;
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason)
	end;
			

%% 家园 1(铲除/中断/召回) 2收获
handle(?PT_HOME_JOB_ACTION_FINISH, PS, [Type,No,Action]) ->
	case player:has_enough_money(PS,?MNY_T_VITALITY,20) orelse Action =:= 2 of
		false -> lib_send:send_prompt_msg(PS, ?PM_VITALITY_LIMIT);
		true  -> case lib_home:job_action_finish(PS, Type, No, Action) of
		             {ok,Master} -> 
						  case Action =:= 1 of 
							  true ->  player:cost_vitality(PS,20,["home", "back"]);
							  false -> skip
						  end,                    
			              {ok, Bin} = pt_37:write(?PT_HOME_JOB_ACTION_FINISH, [Type, No, Action,Master]),
						  {ok, Home} = lib_home:get_home(player:get_id(PS)),
						  IdList = lib_scene:get_scene_player_ids(Home#home.scene_id),
						  F = fun(X) ->
									  case X =:= player:get_id(PS) of
										  true -> skip;
										  false -> lib_send:send_to_uid(X, Bin)
									  end
							  
							  end,
						  lists:foreach(F,IdList ),
			              lib_send:send_to_sock(PS, Bin);
		             {fail, Reason} ->
			             lib_send:send_prompt_msg(PS, Reason)
	             end
	end;
		
	
			


%%--------------家园成就数据----------------------
handle(?PT_HOME_ACHIEVEMENT_DATA, PS, []) ->
	case lib_home:achievement_data(PS) of
		{ok, AchievementValue, AchievementRewardNos} ->
			{ok, Bin} = pt_37:write(?PT_HOME_ACHIEVEMENT_DATA, [AchievementValue, AchievementRewardNos]),
			lib_send:send_to_sock(PS, Bin);
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason)
	end;
			

%% 领取成就奖励
handle(?PT_HOME_ACHIEVEMENT_REWARD, PS, [No]) ->
	case lib_home:achievement_reward(PS, No) of
		ok ->
			{ok, Bin} = pt_37:write(?PT_HOME_ACHIEVEMENT_REWARD, [No]),
			lib_send:send_to_sock(PS, Bin);
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason)
	end;
			
			

%% 请求家园拜访界面
handle(?PT_HOME_VISIT_LIST, PS, []) ->
	HomeList = lib_home:request_other_list(PS),
	HomeListData = 
		lists:foldl(fun(#home{id = PlayerId, degree = Degree}, Acc) ->
							case mod_offline_data:get_offline_role_brief(PlayerId) of
								Brief when is_record(Brief, offline_role_brief) ->
									Name = Brief#offline_role_brief.name,
									Faction = Brief#offline_role_brief.faction,
									Lv = Brief#offline_role_brief.lv,
									[{PlayerId, Name, Faction, Lv, Degree}|Acc];
								_ ->
									[Acc]
							end
					end, [], HomeList),
	io:format("HomeListData L ~p~n", [HomeListData]),
	{ok, Bin} = pt_37:write(?PT_HOME_VISIT_LIST, [HomeListData]),
	lib_send:send_to_sock(PS, Bin);
		

			

%% 搜索玩家家园
handle(?PT_HOME_VISIT_SEARCH, PS, [PlayerName]) ->
	 
	case  db:select_row(player, "id", [{nickname, PlayerName}], [], [1])  of
		[PlayerId] ->  
			Fun = fun({_, Tab}, Acc) ->
						  case ets:tab2list(Tab) of
							  [] ->
								  Acc;
							  Acc2 ->
								  lists:append(Acc, Acc2)
						  end
				  end,
			HomeList0 = lists:foldl(Fun, [], ?ETS_HOME_LIST),
			HomeList = lists:keyfind(PlayerId, #home.id, HomeList0),
			case HomeList#home.degree > 0 of
				true -> case mod_offline_data:get_offline_role_brief(PlayerId) of
							Brief when is_record(Brief, offline_role_brief) ->
								Name = Brief#offline_role_brief.name,
								Faction = Brief#offline_role_brief.faction,
								Lv = Brief#offline_role_brief.lv,
								{ok, Bin} = pt_37:write(?PT_HOME_VISIT_SEARCH,  [{PlayerId, Name, Faction, Lv, HomeList#home.degree }]),
								lib_send:send_to_sock(PS, Bin);
							_ -> lib_send:send_prompt_msg(PS, ?PM_HOME_SERCH_NAME)
						
						end;
				false -> lib_send:send_prompt_msg(PS, ?PM_HOME_SERCH_NO_EXIST)
			end;
		
		
		[] -> lib_send:send_prompt_msg(PS, ?PM_HOME_SERCH_NAME)
	end;
	
		
%% desc: 容错
handle(_Cmd, _PS, _Data) ->
    ?DEBUG_MSG("pp_hire no match", []),
    {error, "pp_hire no match"}.








