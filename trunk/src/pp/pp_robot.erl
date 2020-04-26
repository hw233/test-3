%%%-----------------------------------
%%% @Module  : pp_robot
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2012.06.10
%%% @Description: 
%%%-----------------------------------
-module(pp_robot).
% -export([handle/3
% 		]).
% -include("common.hrl").
% -include("record.hrl").


% %% 自动挂机怪物数据
% handle(55000, Status, _)->
% 	{SceneL, MonL} = lib_mon:get_mon_list_by_scene(lib_scene:get_res_id(Status#player_status.scene), Status),
% 	F = fun(Mid) ->
% 				case data_mon:get(Mid) of
% 					Minfo when is_record(Minfo, ets_mon) ->
% 						Minfo#ets_mon.name;
% 					_ ->
% 						<<"未知怪物">>
% 				end
% 		end,
% 	F1 = fun(Mid, SL) ->
% 				 [S||S<-SL, lib_mon:check_mon_exist(S,Mid,move)]
% 		 end,
% 	Reply = [{Mid,F(Mid),Type,F1(Mid,SceneL)}||{Mid,Type}<-MonL],
% 	?TRACE("-------55000 reply :~p~n",[Reply]),
% 	{ok, BinData} = pt_55:write(55000,Reply),
% 	lib_send:send_one(Status#player_status.socket, BinData);

% %% 自动挂机副本路线(仅适用于无环的情况)
% handle(55001, Status, _)->
% 	Reply = mod_dungeon:dungeon_graph(lib_scene:get_res_id(Status#player_status.scene)),
% 	?TRACE("-------55001 reply :~p~n",[Reply]),
% 	{ok, BinData} = pt_55:write(55001,Reply),
% 	lib_send:send_one(Status#player_status.socket, BinData);
	
	
	
% %% 请求开始自动挂机
% handle(55002, Status, _)->
% 	case check_start_auto_mf(Status) of
% 		{fail, Reason} ->
% 			{ok, BinData} = pt_55:write(55002, Reason),
% 			lib_send:send_one(Status#player_status.socket, BinData);
% 		{ok} ->
% 			{ok, BinData} = pt_55:write(55002, ?RESULT_OK),
% 			lib_send:send_one(Status#player_status.socket, BinData),
% 			% 更新为处于自动挂机模式
% 			mod_player:set_in_auto_mf_mode_flag(Status#player_status.pid, true),
% 			void
% 	end;
	


% %% 中止自动挂机
% handle(55003, Status, _)->
% 	case lib_player:is_in_auto_mf_mode(Status) of
% 		false ->
% 			skip;
% 		true ->
% 			% 重置为处于非自动挂机模式
% 			mod_player:set_in_auto_mf_mode_flag(Status#player_status.pid, false),
% 			void
% 	end;
		

	
% handle(_Cmd, _PlayerStatus, _Data) ->
%     {error, bad_request}.
    
    
    

% %% =================================================================

    

% %% 检查是否可以开始自动挂机
% %% @return: {fail, Reason} | {ok}
% check_start_auto_mf(Status) ->
% 	case lib_player:is_in_battle(Status) of
% 		true ->
% 			{fail, 2}; % 失败：当前在战斗中
% 		false ->
% 			case lib_player:is_in_shuangxiu(Status) of
% 				true ->
% 					{fail, 3}; % 失败，当前在双修中
% 				false ->
% 					% TODO: 做其他检查
% 					%。。。
% 					{ok}
% 			end
% 	end.