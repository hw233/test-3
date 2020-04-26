%%%-----------------------------------
%%% @Module  : pp_tve
%%% @Author  : 
%%% @Email   :
%%% @Created : 2014.6
%%% @Description: tve兵临城下
%%%-----------------------------------

-module(pp_tve).

-include("common.hrl").
-include("record.hrl").
-include("pt_16.hrl").
-include("dungeon.hrl").
-include("prompt_msg_code.hrl").
-include("abbreviate.hrl").
-include("tve.hrl").
-include("player.hrl").

-export ([handle/3]).


handle(?PT_TVE_ENTER, PS, [LvStep]) ->
    case check_enter(PS, LvStep) of
        {ok, RetList} ->
			{ok, BinData} = pt_16:write(?PT_TVE_ENTER, RetList),
			case mod_tve:is_team_tve(LvStep) of
				true ->
					% 修改该接口返回给全部队员
					lib_send:send_to_team(PS, BinData),
					
					F0 = fun({RetCode, _Name}, Sum) ->
								 case RetCode =:= ?RES_OK of
									 true -> Sum + 1;
									 false -> Sum
								 end
						 end,
					
					OkCnt = lists:foldl(F0, 0, RetList),
					case OkCnt =:= length(RetList) of
						false -> skip;
						true ->
							TeamIdList = mod_team:get_normal_member_id_list(player:get_team_id(PS)),
							
							lib_team:set_ensure_list(?ACT_TVE_NO, TeamIdList -- [player:id(PS)]),
							erlang:start_timer(?ENSURE_WAIT_TIME * 1000, self(), {'team_ensure', ?ACT_TVE_NO, LvStep, TeamIdList -- [player:id(PS)]}),
							
							FreeTime = (data_tve:get(LvStep))#tve_cfg.times,
							F = fun(Id) ->
										State = 
											case mod_tve:get_player_enter_time(Id) >= FreeTime of
												true -> 0;
												false -> 1
											end,
										
										{ok, Bin} = pt_16:write(?PT_TVE_SHOW_TIPS, [LvStep, State]),
										lib_send:send_to_uid(Id, Bin)
								end,
							
							[F(X) || X <- TeamIdList -- [player:id(PS)]]
					end;
				false ->
					lib_send:send_to_sock(PS, BinData),
					case RetList of
						[{0, _}] ->
							mod_tve_mgr:handle_enter(PS, LvStep);
						_ ->
							skip
					end
			end;
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason)
    end;


handle(?PT_TVE_REPLY, PS, [LvStep, Flag]) ->
    ?DEBUG_MSG("pp_tve: PT_TVE_REPLY begin,{LvStep, Flag}:~w~n", [{LvStep, Flag}]),
    case lists:member(LvStep, data_tve:get_all_lv_step_no_list()) andalso lists:member(Flag, [0, 1, 2]) of
        false ->
            lib_send:send_prompt_msg(PS, ?PM_PARA_ERROR);
        true ->
            case player:get_pid(mod_team:get_leader_id(player:get_team_id(PS))) of
                null -> 
                    skip;
                Pid ->
                    Pid ! {team_ensure, ?ACT_TVE_NO, LvStep, player:id(PS), Flag}
            end
    end;


handle(?PT_TVE_GET_RANK, PS, [LvStep, RankCount]) ->
    ?DEBUG_MSG("pp_tve: PT_TVE_GET_RANK begin,{LvStep, RankCount}:~w~n", [{LvStep, RankCount}]),
	List = mod_tve:get_tve_rank(LvStep),
	{ok, BinData} = pt_16:write(?PT_TVE_GET_RANK, [LvStep, lists:sublist(List, 1, RankCount)]),
	lib_send:send_to_sock(PS, BinData);


handle(?PT_TVE_REFRESH_REWARD, PS, _) ->
    gen_server:cast(?TVE_MGR_PROCESS, {'refresh_reward', PS});



handle(?PT_TVE_GET_ENTER_TIMES, PS, _) ->
	%20190110修改，目前这里不能用
    Time = mod_tve:get_player_enter_time(PS),
    {ok, BinData} = pt_16:write(?PT_TVE_GET_ENTER_TIMES, [Time]),
    lib_send:send_to_sock(PS, BinData);


handle(?PT_TVE_GET_REWARD, PS, _) ->
    gen_server:cast(?TVE_MGR_PROCESS, {'get_reward', PS});


% handle(?PT_TVE_START_MF, PS, [BMonGroupNo]) ->
%     ?DEBUG_MSG("pp_tve: handle PT_TVE_START_MF BMonGroupNo:~p~n", [BMonGroupNo]),
%     case check_start_mf(PS, BMonGroupNo) of
%         {fail, Reason} ->
%             lib_send:send_prompt_msg(PS, Reason);
%         ok ->
%             mod_battle:start_tve_mf(PS, BMonGroupNo, null)
%     end;


handle(_Cmd, _, _) ->
    ?WARNING_MSG("unknown pp ~p", [_Cmd]),
    error.



check_enter(PS, LvStep) ->
    try 
        check_enter__(PS, LvStep)
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

check_enter__(PS, LvStep) ->
	IsTeamTve = mod_tve:is_team_tve(LvStep),
	?Ifc ((not IsTeamTve) andalso player:is_in_team(PS))
        throw(?PM_TM_LEAVE_TEAM_FIRST)
    ?End,

    ?Ifc (IsTeamTve andalso lib_team:get_ensure_list(?ACT_TVE_NO) =/= null)
        throw(?PM_TM_WAIT_MB_CONFIRM)
    ?End,

    ?Ifc (IsTeamTve andalso (not player:is_leader(PS)))
        throw(?PM_NOT_TEAM_LEADER)
    ?End,

    Data = data_tve:get(LvStep),
    ?Ifc (Data =:= null)
        throw(?PM_DATA_CONFIG_ERROR)
    ?End,

    MbList = mod_team:get_normal_member_id_list(player:get_team_id(PS)),

    ?Ifc (IsTeamTve andalso length(MbList) <  Data#tve_cfg.mb_limit)
        throw(?PM_RELA_MEMBER_NOT_ENOUGTH)
    ?End,

%%    ?Ifc (IsTeamTve andalso length(MbList) =/= length(mod_team:get_all_member_id_list(player:get_team_id(PS))))
%%        throw(?PM_DUNGEON_TEAM_STATUS)
%%    ?End,

    ?Ifc (not lists:member(LvStep, data_tve:get_all_lv_step_no_list()))
        throw(?PM_PARA_ERROR)
    ?End,

    MinLv = lists:nth(1, Data#tve_cfg.lv_range),
    MaxLv = lists:nth(2, Data#tve_cfg.lv_range),
    MaxTime = Data#tve_cfg.times + Data#tve_cfg.times_use_goods,
    FreeTime = Data#tve_cfg.times,
    GoodsNo = Data#tve_cfg.use_goods_no,
    ?DEBUG_MSG("pp_tve:get_player_enter_time FreeTime:~p,MaxTime:~p!~n", [FreeTime, MaxTime]),
    F = fun(Id, Acc) ->
        ObjPS = 
            case Id =:= player:id(PS) of
                true -> PS;
                false -> player:get_PS(Id)
            end,

        case ObjPS =:= null of
            true -> Acc;
            false ->
                case player:is_in_dungeon(ObjPS) of
                    false -> 
                        case util:in_range(player:get_lv(ObjPS), MinLv, MaxLv) of
                            false ->
                                [{2, player:get_name(ObjPS)} | Acc];
                            true ->
                                Times = mod_tve:get_player_enter_time(ObjPS),
                                Time = try reset_enter_times(LvStep, Times)
                                       catch _:_ ->?DEBUG_MSG("pp_tve:get_player_enter_time error! ~n", []), 1
                                end,

                                ?DEBUG_MSG("pp_tve:get_player_enter_time Time:~p!~n", [Time]),
                                case Time >= MaxTime of
                                    true ->
                                        [{3, player:get_name(ObjPS)} | Acc];
                                    false ->
                                        case Time >= FreeTime of
                                            true -> 
                                                case mod_inv:has_enough_goods_in_bag(player:id(ObjPS), GoodsNo, 1) of
                                                    false ->
                                                        [{1, player:get_name(ObjPS)} | Acc];
                                                    true ->    
                                                        [{0, player:get_name(ObjPS)} | Acc]
                                                end;
                                            false ->
                                                [{0, player:get_name(ObjPS)} | Acc]
                                        end
                                end
                        end;
                    _ -> 
                        [{4, player:get_name(ObjPS)} | Acc]
                end
        end
    end,

    RetList = 
		case IsTeamTve of
			true ->
				lists:foldl(F, [], MbList);
			false ->
				F(player:id(PS), [])
		end,
    ?DEBUG_MSG("pp_tve: RetList:~w, MbList:~w!~n", [RetList, MbList]),
%%    ?Ifc (IsTeamTve andalso length(RetList) =/= length(MbList))
%%        throw(?PM_DUNGEON_TEAM_STATUS)
%%    ?End,

    {ok, RetList}.

%这是一个兼容，数据乱了，不知道什么原因，重现不了
reset_enter_times(LvStep, Times) ->
	case lists:keyfind(LvStep,1, Times) of
		false ->
			0;
		{_ , HaveValue} -> HaveValue
	end.
    
% % 操作的合法性检测：是否可以打怪？
% check_start_mf(PS, BMonGroupNo) ->
%     try 
%         check_start_mf__(PS, BMonGroupNo)
%     catch 
%         throw: FailReason ->
%             {fail, FailReason}
%     end.


        

% check_start_mf__(PS, BMonGroupNo) ->
%     % 若在队伍中，则只能由队长操作
%     ?Ifc (player:is_in_team_but_not_leader(PS) andalso (not player:is_tmp_leave_team(PS)))
%         throw(?PM_PARA_ERROR)
%     ?End,

%     ?Ifc (not lib_bmon_group:is_valid(BMonGroupNo) )
%         ?ASSERT(false),
%         throw(?PM_UNKNOWN_ERR)
%     ?End, 

%     DunNo = player:get_dungeon_no(PS),
%     ?Ifc (DunNo =:= ?INVALID_NO)
%         throw(?PM_DUNGEON_OUSIDE)
%     ?End,

%     DunType = lib_dungeon:get_dungeon_type(DunNo),
%     if
%         DunType =:= ?DUNGEON_TYPE_TVE ->
%             skip;
%         true ->
%             throw(?PM_DUNGEON_OUSIDE)
%     end,

%     % 玩家当前是否空闲？
%     ?Ifc (not player:is_idle(PS))
%         throw(?PM_BUSY_NOW)
%     ?End,
%     ok.