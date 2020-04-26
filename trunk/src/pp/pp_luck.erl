%% @author wujiancheng
%% @doc @todo Add description to pp_luck.


-module(pp_luck).

%% ====================================================================
%% API functions
%% ====================================================================
-export([handle/3]).

-include("common.hrl"). 
-include("prompt_msg_code.hrl").
-include("ets_name.hrl").
-include("pt_54.hrl").
-include("optional_turntable.hrl").



%%--------开始寻宝 -------------
handle(?PT_START_AWARD_HUNTING, PS, [Type]) ->
    lib_luck:start_hunting(player:get_id(PS), Type);

%%--------领取每周累积奖励 -------------
handle(?PT_GET_WEEKLY_AWARD, PS, [Type]) ->
	 lib_luck:receive_weekly_reward(player:get_id(PS), Type);

%%--------玩家打开寻宝界面 -------------
handle(?PT_ON_AWARD_HUNTING_PANEL_OPEN, PS, [Type]) ->
	 lib_luck:open_hunting_interface(player:get_id(PS),Type);

%%--------玩家关闭寻宝界面 -------------
handle(?PT_ON_AWARD_HUNTING_PANEL_CLOSE, PS, [Type]) ->
	 lib_luck:close_hunting_interface(player:get_id(PS),Type);


%%--------玩家打开许愿界面 -------------
handle(?PT_ON_AWARD_TREASURE_PANEL_OPEN, PS, [Type]) ->
	 lib_luck:open_hunting_interface(player:get_id(PS),Type);

%%--------玩家开始许愿 -------------
handle(?PT_START_AWARD_TREASURE, PS, [Type]) ->
	 lib_luck:start_desire(player:get_id(PS),Type);

%%--------领取许愿一百次的奖励 -------------
handle(?PT_GET_FULL_TREASURE, PS, [No]) ->
	 lib_luck:take_xuyuanchi_extra_reward(player:get_id(PS),No);

%%--------玩家关闭许愿界面 -------------
handle(?PT_ON_AWARD_TREASURE_PANEL_CLOSE, PS, [Type]) ->
	 lib_luck:close_hunting_interface(player:get_id(PS),Type);

%%--------玩家打开大富翁界面 -------------
handle(?PT_ENTER_CHESS_CHECK_PANEL, PS , []) ->
	lib_luck:open_face(player:get_id(PS));

%%--------玩家进入大富翁游戏 -------------
handle(?PT_REQUEST_ENTER_CHESS_GAME, PS , []) ->
	lib_luck:enter_game(player:get_id(PS));

%%--------玩家免费次数不足 -------------
handle(?PT_CHESS_ENTER_INVALID, PS , [Type]) ->
	lib_luck:free_time_no_enough(player:get_id(PS),Type);

%%--------队长掷骰子 -------------
handle(?PT_CHESS_THROW_DICE, PS , [Type]) ->
	lib_luck:team_leader_dice(player:get_id(PS),Type);

%%--------玩家走到某个格子 -------------
handle(?PT_CHESS_STAND_ON_CELL, PS , [Type]) ->
	lib_luck:stand_on_chess(player:get_id(PS),Type);


%%自选转盘
handle(?PT_OPEN_AWARD_OPTIONAL, PS , []) ->
	case ets:lookup(ets_player_optional_reward,player:get_id(PS)) of
		[] ->
			{ok, Bin} =pt_54:write(?PT_OPEN_AWARD_OPTIONAL, []),
			lib_send:send_to_sock(PS, Bin);
		[R] ->
			Data = R#player_optional_data.optional_list,
			F = fun({_Pro,No}, Acc) ->
				[No | Acc]
				end,
			NotifyData = lists:foldl(F , [] , Data),
			{ok, Bin} =pt_54:write(?PT_OPEN_AWARD_OPTIONAL, NotifyData),
			lib_send:send_to_sock(PS, Bin)
	end;


handle(?PT_START_AWARD_OPTIONAL, PS , [Type]) ->
	case get("optional_time")  of
		undefined ->
			put("optional_time",util:unixtime()),
			lib_luck:check_optional(player:get_id(PS),Type);
		Times ->
			case util:unixtime() - Times >=3 of
				true ->
					put("optional_time",util:unixtime()),
					lib_luck:check_optional(player:get_id(PS),Type);
				false ->
					lib_send:send_prompt_msg(player:get_id(PS), ?PM_DUNGEON_BOX_NO_FOUND)
			end

	end;


handle(?PT_RESET_FULL_TREASURE, PS , [_]) ->
	ets:delete(ets_player_optional_reward,player:get_id(PS));

handle(?PT_OPTIONAL_TREASURE_NO, PS , [NoList]) ->
	%判断下玩家数据是否为空，为空才让玩家选择
	case ets:lookup(ets_player_optional_reward,player:get_id(PS)) of
		[] ->
			F = fun(X, Acc) ->
				OpDataRec = data_optional_turntable:get(X),
				[{OpDataRec#optional_turntable.trigger_prob, X}|Acc]
				end,
			ETSOpData = lists:foldl(F, [] ,NoList),

			F2 = fun(X2,Acc2) ->
				OpDataRec = data_optional_turntable:get(X2),
				OpDataRec#optional_turntable.trigger_prob + Acc2
				 end,
			TotalRate  = lists:foldl(F2, 0 ,NoList),
			ets:insert(ets_player_optional_reward,#player_optional_data{player_id = player:get_id(PS), optional_list = ETSOpData, total_rate =TotalRate }),
			{ok, Bin} =pt_54:write(?PT_OPTIONAL_TREASURE_NO, 1),
			lib_send:send_to_sock(PS, Bin);
		_ ->
			lib_send:send_prompt_msg(player:get_id(PS), ?PM_BEAUTY_CONTEST_RESET_ERROR_UNKNOWN),
			{ok, Bin} =pt_54:write(?PT_OPTIONAL_TREASURE_NO, 0),
			lib_send:send_to_sock(PS, Bin)
	end;

%% desc: 容错
handle(_Cmd, _PS, _Data) ->
    ?DEBUG_MSG("pp_hire no match", []),
    {error, "pp_hire no match"}.


