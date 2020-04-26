-module(pp_chapter_target).

-include("common.hrl").
-include("chapter_target.hrl").
-include("record.hrl").
-include("log.hrl").
-include("task.hrl").
-include("prompt_msg_code.hrl").

-export([handle/3]).


handle(59001, Status, [ChapterNo]) ->
    mod_chapter_target:get_chapter_info(Status, ChapterNo),
    ok;

handle(59002, Status, [ChapterNo]) ->
    mod_chapter_target:get_chapter_reward(Status, ChapterNo),
    ok;

handle(59003, Status, []) ->
    mod_chapter_target:get_all_chapter_info(Status),
    ok;

handle(59005, Status, [Type]) ->
	case Type of
		0 ->
			
			mod_chapter_target:get_chapter_achive_reward(player:get_id(Status));
		1 ->
			mod_chapter_target:take_chapter_achive_reward(player:get_id(Status));
		_ -> skip
	end,
    ok;

handle(59006, Status, [No, Type]) ->
%% 	type                   u8    0查询，1购买，2充值
%   flag_buy               u32    0为不可购买，其实数值为今日还可购买的数量
%   flag_recharge          u8    1为可充值/2为不可充值
	case Type of
		0 ->
			
			mod_chapter_target:query_day_welfare(player:get_id(Status), No);
		1 ->
			mod_chapter_target:buy_day_welfare(player:get_id(Status), No);
		
		2 -> 
			ets:insert(ets_player_chapter_recharge, {player:get_id(Status), No})
	end,
    ok;



handle(59007, PS, []) ->
    %玩家登录时发送七日盛典的红点
    case ets:lookup(ets_chapter_target, player:get_id(PS)) of
		[ChapterInfo] when is_record(ChapterInfo, chapter_target) ->
			ChapterF = fun(CNo) ->
							   case lists:keyfind(CNo, 1, ChapterInfo#chapter_target.reward_info) of
								   {_, 0} -> 
									   {ok, BinData} = pt_59:write(59007, [1]),
									   lib_send:send_to_sock(PS, BinData);
								   _ ->
									   case  lists:keyfind(2, 2, ChapterInfo#chapter_target.chapter_achievement) of
										   false ->
											   skip;
										   _ ->
											   {ok, BinData} = pt_59:write(59007, [1]),
											   lib_send:send_to_sock(PS, BinData)
									   
									   end
							   end
					   end,
			lists:foreach(ChapterF, ChapterInfo#chapter_target.finish_chapter);
			
		_ -> skip
	end,
    ok;



% 副本剧情目标信息
handle(59101, Status, []) ->
    mod_dungeon_plot:fetch_dun_plot_info(Status),
    ok;

handle(59200, Status, []) ->
    AcceptTaskIdL = lib_task:get_accepted_list(),
    F = fun(TaskId, Acc) ->
            case lib_task:get_task_type(TaskId) =:= 0 of
                true ->
                    [TaskId | Acc];
                false ->
                    Acc
            end
        end,

    {PackCount, Lilian} =
        case lists:foldl(F, [], AcceptTaskIdL) of
            [] ->
                CompleteTaskId = (lib_task:get_unrepeat_completed(0))#completed_unrepeat.id,
                mod_chapter_target:get_lilian_chapter(CompleteTaskId, 1, Status);
            [AcceptTaskId] ->
                mod_chapter_target:get_lilian_chapter(AcceptTaskId, 0, Status)
        end,
	?DEBUG_MSG("{PackCount, Lilian}~p~n", [{PackCount, Lilian}]),
    {ok, BinData} = pt_59:write(59200, [PackCount, Lilian]),
    lib_send:send_to_sock(Status, BinData);


%%mod_chapter_target:get_up_lv_list(data_lilian_task_no:get_no(), 84, []).

handle(59201, Status, [No]) ->
	AcceptTaskIdL = lib_task:get_accepted_list(),
	F = fun(TaskId, Acc) ->
				case lib_task:get_task_type(TaskId) =:= 0 of
					true ->
						[TaskId | Acc];
					false ->
						Acc
				end
		end,
	{PackCount, Lilian2} =
		case lists:foldl(F, [], AcceptTaskIdL) of
			[] ->
				CompleteTaskId = (lib_task:get_unrepeat_completed(0))#completed_unrepeat.id,
				mod_chapter_target:get_lilian_chapter(CompleteTaskId, 1, Status);
			[AcceptTaskId] ->
				mod_chapter_target:get_lilian_chapter(AcceptTaskId, 0, Status)
		end,
	
	FinishStates = mod_chapter_target:big_num_to_list(PackCount, []),
	case length(FinishStates) >=  No  of
		true ->
			FinishStates2 = lists:reverse(FinishStates),
			[IsFinishState] = lists:sublist(FinishStates2, No, 1),
			case IsFinishState == 1 of
				true ->
				    GetStates = mod_chapter_target:big_num_to_list(Lilian2, []),
					
					case No > length(GetStates) of
						true ->
							PlayerMisc = ply_misc:get_player_misc(player:get_id(Status)),
							Lilian = PlayerMisc#player_misc.lilian,
							NewLilian = Lilian + erlang:trunc(math:pow(2, No-1)),
							?DEBUG_MSG("handle(59201, Status, [No]) NewLilian~p~n", [NewLilian]),
							RewardNo = (data_lilian_sys_open:get(No))#lilian_sys_open.reward,
							case lib_reward:check_bag_space(Status, RewardNo) of
								{fail, _Reason} ->
									lib_send:send_prompt_msg(player:get_id(Status), ?PM_US_BAG_FULL);
								ok ->
									ply_misc:update_player_misc(PlayerMisc#player_misc{lilian = NewLilian}),
									ply_misc:db_save_player_misc(player:get_id(Status)),
									lib_reward:give_reward_to_player(Status, RewardNo, [?LOG_LILIAN, "reward"])
							end,
							{ok, BinData} = pt_59:write(59200, [PackCount, NewLilian]),
							lib_send:send_to_sock(Status, BinData);
						false ->
							GetStates2 = lists:reverse(GetStates),
							[IsGetState] = lists:sublist(GetStates2, No, 1),
							io:format("wujianchengNewLilian~p~n", [{PackCount,FinishStates,IsFinishState,
																	Lilian2,GetStates, IsGetState }]),
							case IsGetState == 1 of
								true ->
									lib_send:send_prompt_msg(player:get_id(Status), ?PM_AD_REPEAT_GET);
								false ->
									PlayerMisc = ply_misc:get_player_misc(player:get_id(Status)),
									Lilian = PlayerMisc#player_misc.lilian,
									NewLilian = Lilian + erlang:trunc(math:pow(2, No-1)),
									?DEBUG_MSG("handle(59201, Status, [No]) NewLilian~p~n", [NewLilian]),
									
									RewardNo = (data_lilian_sys_open:get(No))#lilian_sys_open.reward,
									case lib_reward:check_bag_space(Status, RewardNo) of
										{fail, _Reason} ->
											lib_send:send_prompt_msg(player:get_id(Status), ?PM_US_BAG_FULL);
										ok ->
											ply_misc:update_player_misc(PlayerMisc#player_misc{lilian = NewLilian}),
											ply_misc:db_save_player_misc(player:get_id(Status)),
											lib_reward:give_reward_to_player(Status, RewardNo, [?LOG_LILIAN, "reward"])
									end,
									{ok, BinData} = pt_59:write(59200, [PackCount, NewLilian]),
									lib_send:send_to_sock(Status, BinData)
							end
					end;
							
     
						
				false ->
					lib_send:send_prompt_msg(player:get_id(Status), ?PM_MK_FAIL_SERVER_BUSY)
			end;
		false ->
			lib_send:send_prompt_msg(player:get_id(Status), ?PM_MK_FAIL_SERVER_BUSY)
	end;
	
	
					
					
			
	

	

handle(_Cmd, _, _) ->
    ?ASSERT(false, [_Cmd]),
    not_match.




