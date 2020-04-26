%%%--------------------------------------
%%% @Module   : ply_battle
%%% @Author   : huangjf
%%% @Email    : 
%%% @Created  : 2014.4.22
%%% @Description: 玩家与战斗相关的业务逻辑
%%%--------------------------------------

-module(ply_battle).
-export([
        get_last_battle_start_time/0, set_last_battle_start_time/1,
        get_last_battle_finish_time/0, set_last_battle_finish_time/1,
        try_go_back_to_battle/1,
        notify_cli_try_go_back_to_battle_result/2,
        on_try_go_back_to_battle_failed/1,
        pick_bmon_group_for_battle/2,
		pick_bmon_group_for_battle/3,
        pick_bmon_group_by_fit_lv/2
    ]).

-include("common.hrl").
-include("monster.hrl").
-include("debug.hrl").
-include("player.hrl").
-include("pt_20.hrl").




get_last_battle_start_time() ->
    ?ASSERT(player:this_is_player_proc()),
    case erlang:get(?PDKN_LAST_BATTLE_START_TIME) of
        undefined ->
            0;
        Val ->
            Val
    end.

set_last_battle_start_time(Unixtime) ->
    ?ASSERT(player:this_is_player_proc()),
    erlang:put(?PDKN_LAST_BATTLE_START_TIME, Unixtime).


get_last_battle_finish_time() ->
    ?ASSERT(player:this_is_player_proc()),
    case erlang:get(?PDKN_LAST_BATTLE_FINISH_TIME) of
        undefined ->
            0;
        Val ->
            Val
    end.

set_last_battle_finish_time(Unixtime) ->
    ?ASSERT(player:this_is_player_proc()),
    erlang:put(?PDKN_LAST_BATTLE_FINISH_TIME, Unixtime).


try_go_back_to_battle(PS) ->
    case player:get_cur_battle_pid(PS) of
        null ->
            % on_try_go_back_to_battle_failed(PS);

            notify_cli_try_go_back_to_battle_result(PS, ?RES_FAIL),
            case player:is_offline_guaji(PS) of
                true ->
                    skip;  % 避免干扰离线挂机状态
                false ->
                    player:mark_idle(PS)
            end; 
        BattlePid ->
            case erlang:is_process_alive(BattlePid) of
                true ->
                    mod_battle:player_try_go_back_to_battle(PS, BattlePid);
                false ->
                    on_try_go_back_to_battle_failed(PS)
            end
    end.


on_try_go_back_to_battle_failed(PS) ->
    notify_cli_try_go_back_to_battle_result(PS, ?RES_FAIL),
    player:mark_idle(PS).




notify_cli_try_go_back_to_battle_result(PS, Result) ->
    % ?DEBUG_MSG("notify_cli_try_go_back_to_battle_result(), PlayerId:~p, Result:~p", [player:id(PS), Result]),
    {ok, Bin} = pt_20:write(?PT_BT_TRY_GO_BACK_TO_BATTLE, Result),
    lib_send:send_to_sock(PS, Bin).



pick_bmon_group_for_battle(PS, MonObj) ->
	%% 默认难度1
	pick_bmon_group_for_battle(PS, MonObj, 1).

pick_bmon_group_for_battle(PS, MonObj, Difficulty) ->
    L = mod_mon:get_bmon_group_no_list(MonObj),
	Pred = fun(Term) ->
				   erlang:is_integer(Term)
		   end,
	case lists:all(Pred, L) of
		?true ->
			%% 旧的筛选方式
    		AvgLv = 
				case player:is_in_team(PS) of
                	true ->
                    	mod_team:get_normal_member_average_lv(PS);
                	false ->
                    	player:get_lv(PS)
            	end,
    		?ASSERT(is_list(L) andalso L /= []),
    		do_pick_bmon_group_by_fit_lv(L, L, AvgLv);
		?false ->
			do_pick_bmon_group_by_difficulty(L, Difficulty)
	end.



%% 从怪物组列表中，挑选出等级适配的怪物组进行战斗，如果没有任何适配的怪物组，则固定挑选第一个
pick_bmon_group_by_fit_lv(FitLv, BMonGroupNoList) when is_list(BMonGroupNoList), BMonGroupNoList /= [] ->
    do_pick_bmon_group_by_fit_lv(BMonGroupNoList, BMonGroupNoList, FitLv).




do_pick_bmon_group_by_fit_lv([], OriginalBMonGroupList, FitLv) ->
    ?DEBUG_MSG("do_pick_bmon_group_by_fit_lv() failed!! OriginalBMonGroupList:~w, FitLv:~p", [OriginalBMonGroupList, FitLv]),
    erlang:hd(OriginalBMonGroupList);

do_pick_bmon_group_by_fit_lv([GroupNo | T], OriginalBMonGroupList, FitLv) ->
    case lib_bmon_group:get_cfg_data(GroupNo) of
        null ->
            do_pick_bmon_group_by_fit_lv(T, OriginalBMonGroupList, FitLv);
        BMonGrp ->
            case FitLv >= BMonGrp#bmon_group.lv_range_min
            andalso FitLv =< BMonGrp#bmon_group.lv_range_max of
                true ->
                    GroupNo;
                false ->
                    do_pick_bmon_group_by_fit_lv(T, OriginalBMonGroupList, FitLv)
            end
    end.



do_pick_bmon_group_by_difficulty(L, Difficulty) ->
	L2 = lists:keysort(1, L),
	case lists:nth(Difficulty, L2) of
		{_, GroupNo} ->
			GroupNo;
		GroupNo ->
			GroupNo
	end.


    
