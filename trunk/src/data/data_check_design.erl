%% Author: Administrator
%% Created: 2012-3-16
%% Description: TODO: Add description to data_check_design
-module(data_check_design).

% %%
% %% Include files
% %%
% -include("common.hrl").
% -include("record.hrl").
% %%
% %% Exported Functions
% %%
% -export([
% 		 get_exp_by_scene_id/1,
% 		 get_mon_not_exist/0,
% 		 get_mon_not_exist1/0,
% 		 get_pass_lv_not_match/0,
% 		 get_enter_levels/0,
% 		 get_orphan_task/0
% 		 ]).




% get_exp_by_scene_id(Sid)->
% 	Sinfo = data_scene:get(Sid),
% 	MonL = Sinfo#ets_scene.mon,
% 	F = fun(MoveMon)->
% 				Minfo = data_mon:get(MoveMon),
% 				{MoveMon, Minfo#mon.exp}
% 		end,
% 	MData = [F(D)||[D|_]<-MonL],
% %% 	io:format("SceneId:~p MonL&Exp: ~p~n",[Sid, MData]).
% 	{ok,L} = file:open("mon&exp.txt",[write,append]),
% 	io:format(L,"~p-~n~p.~n",[Sid,MData]),
% 	file:close(L).

% %% 获得不存在的怪物
% get_mon_not_exist() ->
% 	SL = data_scene:get_id_list(),
% 	F = fun(Sidf,MonLf) ->
% 				Sinfo = data_scene:get(Sidf),
% 				MonL = Sinfo#ets_scene.mon,
% 				F1 = fun(MoveMon)->
% 							 case data_mon:get(MoveMon) of
% 								 [] ->
% 									 true;
% 								 _ ->
% 									 false
% 							 end
% 					 end,
% 				case [D||[D|_]<-MonL, F1(D)] of 
% 					[] ->
% 						MonLf;
% 					ML ->
% 						[{Sidf,ML}| MonLf]
% 				end
% 		end,
% 	Reply = lists:foldl(F, [], SL),
% 	{ok,L} = file:open("mon.txt",[write,append]),
% 	io:format(L,"~p.~n",[Reply]),
% 	file:close(L).

% %% 获得不存在的怪物1
% get_mon_not_exist1() ->
% 	List = lists:seq(1,100000),
% 	F = fun(Mid) ->
% 				case data_mon:get(Mid) of
% 					[] ->
% 						false;
% 					_ ->
% 						try lib_mon:get_hp_by_mon_id(Mid,move) of
% 							_ ->
% 								false
% 						catch _T:_Err ->
% 								  true
% 						end
% 				end
% 		end,
% 	Reply = [Id||Id<-List, F(Id)],
% 	{ok,L} = file:open("mon1.txt",[write,append]),
% 	io:format(L,"~p.~n",[Reply]),
% 	file:close(L).

% %% 计算出接取任务后不能达到等级要求的项
% get_pass_lv_not_match() ->
% 	IdL = data_task:get_ids(),
% 	{ok,L} = file:open("task.txt",[write,append]),
% 	F = fun(Tidf) ->
% 				TaskInfo = data_task:get(Tidf,#player_status{}),
% 				case [1||[_Statef, _Finish, Event | _]<- TaskInfo#task.content, Event == pass_finish] of
% 					[] ->
% 						false;
% 					_PassL0 ->
% 						PassL = [Pid||[_Statef, _Finish, Event, Pid | _]<- TaskInfo#task.content, Event == pass_finish],
% 						F1 = fun(Passf1) ->
% 											Pinfo = data_pass:get(Passf1),
% 											F2= fun(Df2) ->
% 														Sinfof2 = data_scene:get(Df2),
% 														case [Lv||{lv,Lv}<- Sinfof2#ets_scene.requirement] of
% 															[] ->
% 																false;
% 															[Lvf2] ->
% 																if Lvf2 > TaskInfo#task.level ->
% 																	   io:format(L,"task ~p: ~p <  scene ~p ~s: ~p~n",[Tidf,TaskInfo#task.level,Df2,binary_to_list(Sinfof2#ets_scene.name),Lvf2]),
% 																	   true;
% 																   true ->
% 																	   false
% 																end
% 														end
% 												end,
% 											[D||{_career,D}<-Pinfo#ets_pass.dungeon_id,F2(D) ]
% 							 end,
% 						[F1(P) || P<- PassL]
% 				end
% 		end,
% 	[F(Id)||Id<-IdL],
% 	file:close(L).

% %% 获得孤儿任务
% get_orphan_task()->
% 	TaskL = data_task:get_ids(),
% 	F = fun(Tf) ->
% 				Ti = data_task:get(Tf,#player_status{}),
% 				Ti#task.type == 0 andalso not(lists:member(Ti#task.prev,TaskL) orelse lists:member(Ti#task.next,TaskL))
% 		end,
% 	TL = [T||T<-TaskL,F(T)],
% 	{ok,L} = file:open("orphan.txt",[write,append]),
% 	io:format(L,"~p-~n",[TL]),
% 	file:close(L).

% %% 输出场景进入要求的文本工具for策划
% get_enter_levels()->
% 	SL = data_scene:get_id_list(),
% 	{ok,L} = file:open("scene&req.txt",[write,append]),
% 	F = fun(Sid)->
% 				Sinfo = data_scene:get(Sid),
% 				if Sinfo#ets_scene.requirement =/= [] ->
% 					   io:format(L,"~s~n~p.~n",[binary_to_list(Sinfo#ets_scene.name),Sinfo#ets_scene.requirement]);
% 				   true ->
% 					   skip
% 				end
% 		end,
% 	[F(D)||D<-SL],
% %% 	io:format("SceneId:~p MonL&Exp: ~p~n",[Sid, MData]).
% 	file:close(L).