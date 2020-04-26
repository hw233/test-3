%%%-----------------------------------
%%% @Module  : mod_dungeon
%%% @Author  : lds
%%% @Email   :
%%% @Created : 2013.11
%%% @Description: 副本协议处理
%%%-----------------------------------
-module(pp_dungeon).

-include("common.hrl").
-include("record.hrl").
-include("dungeon.hrl").
-include("reward.hrl").
-include("prompt_msg_code.hrl").
-include("log.hrl").
-include("proc_name.hrl").

-export([handle/3]).

%% 进入副本
% handle(57001, Status, [?BOSS_DUNGEON_NO]) ->
%     case player:is_in_dungeon(Status) of
%         false -> gen_server:cast(?DUNGEON_MANAGE, {'enter_public_dungeon', ?BOSS_DUNGEON_NO, player:id(Status)});
%         _ -> lib_send:send_prompt_msg(Status, ?PM_DUNGEON_INSIDE)
%     end;

handle(57001, Status, [DunNo]) ->
    case player:is_idle(Status) of
        false -> lib_send:send_prompt_msg(Status, ?PM_BUSY_NOW);
        true -> 
            case player:is_in_dungeon(Status) of
                {true, _} -> lib_send:send_prompt_msg(Status, ?PM_DUNGEON_INSIDE);
                _ -> 
                    case lib_dungeon:get_dungeon_type(DunNo) of
						?DUNGEON_TYPE_NEW_GUILD ->
							gen_server:cast(?DUNGEON_MANAGE, {'enter_guild_dungeon', DunNo, player:id(Status)});			
                        ?DUNGEON_TYPE_BOSS  ->
							case DunNo of
								?BOSS_DUNGEON_NO_MOLONG -> 
                                          gen_server:cast(?DUNGEON_MANAGE, {'enter_public_dungeon', ?BOSS_DUNGEON_NO_MOLONG, player:id(Status)});
								?BOSS_DUNGEON_NO_YIJUN ->
									      gen_server:cast(?DUNGEON_MANAGE, {'enter_public_dungeon', ?BOSS_DUNGEON_NO_YIJUN, player:id(Status)})
							 end;
                        _ ->
                            TeamFlag =
                                case player:is_in_team(Status) of
                                    true ->
                                        case player:is_leader(Status) of
                                            true ->
                                                TeamId = player:get_team_id(Status),
                                                ?BIN_PRED(mod_team:is_all_member_in_normal_state(TeamId), true,true);
                                            false -> {false, ?PM_DUNGEON_NOT_LEADER}
                                        end;
                                    false -> true
                                end,
                            case TeamFlag of
                                {false, ErrCode} -> lib_send:send_prompt_msg(Status, ErrCode);
                                true ->
                                    case lib_dungeon:get_ensure_list() of
                                        null ->
                                            TimeStamp = util:unixtime(),
                                            case lib_dungeon:can_create_dungeon(DunNo, TimeStamp, Status) of
                                                {true, TeamList} ->
                                                    Flag =
                                                        case player:is_in_team(Status) of
                                                            true -> mod_team:get_member_count(player:get_team_id(Status)) > 1;
                                                            false -> false
                                                        end,
                                                    case Flag of
                                                        false ->
                                                            % 扣取道具 lib_dungeon:cost_dungeon_props(Status, DunNo)
                                                            RoleId = player:id(Status),
                                                            case true of
                                                                true -> gen_server:cast(?DUNGEON_MANAGE, {'create_dungeon', DunNo, TimeStamp, RoleId, TeamList});
                                                                {false, Code} -> 
                                                                    {ok, BinData} = pt_57:write(57001, [DunNo, Code]),
                                                                    lib_send:send_to_uid(RoleId, BinData)
                                                            end;
                                                        true ->
                                                            List = lists:delete(player:id(Status), TeamList),
                                                            lib_dungeon:set_ensure_list(DunNo, List),
                                                            lib_dungeon:send_ensure_msg(List, DunNo),
                                                            erlang:start_timer(?ENSURE_WAIT_TIME * 1000, self(), {'dungeon_ensure', List}),

                                                            {ok, BinData} = pt_57:write(57012, []),
                                                            lib_send:send_to_sock(Status#player_status.socket, BinData)
                                                    end;
                                                {false, Code} ->
                                                    ?LDS_TRACE(57001, [Code]),
                                                    {ok, BinData} = pt_57:write(57001, [DunNo, Code]),
                                                    lib_send:send_to_sock(Status#player_status.socket, BinData)
                                            end;
                                        _ -> skip
                                    end
                            end
                    end
            end
    end;


%% 退出副本
handle(57002, Status, _) ->
    lib_dungeon:quit_dungeon(Status),
    ok;

%% 取得npc副本列表
handle(57003, Status, [IdList]) ->
    ?LDS_TRACE(57003, [1,  IdList]),
    RoleId = player:id(Status),
    TimeStamp = util:unixtime(),
    PlayerTimes = (ply_misc:get_player_misc(RoleId))#player_misc.dungeon_reward_time,
    F =
        fun(DunNo, Sum) ->
            Dun = lib_dungeon:get_config_data(DunNo),
            CanRewardTimes =
                case lists:keyfind(Dun#dungeon_data.type, 1, PlayerTimes) of
                    false ->
                        0;
                    RewardTimeData ->
                        {_DungeonType, RewardTimes, LastUnixTime} = RewardTimeData,
                        %%判断是否同一天
                        case util:is_same_day(LastUnixTime) of
                            true ->
                                RewardTimes;
                            false ->
                                0
                        end
                end,
            case lib_dungeon:role_dungeon_limit(Status, Dun) of
                true ->
                    case lib_dungeon:role_dungeon_cd(RoleId, Dun, TimeStamp) of
                        {_, true} ->
                            Times = lib_dungeon:get_dungeon_used_times(RoleId, Dun),
                            IsPass = lib_dungeon:get_dungeon_is_pass(RoleId,Dun),
                            [{DunNo, ?SUCCESS, Times,CanRewardTimes,IsPass} | Sum];
                        {_, ErrCode} ->
                            Times = lib_dungeon:get_dungeon_used_times(RoleId, Dun),
                            IsPass = lib_dungeon:get_dungeon_is_pass(RoleId,Dun),
                            [{DunNo, ErrCode, Times,CanRewardTimes,IsPass} | Sum]
                    end;
                {false, Err} ->
                    [{DunNo, Err, 0} | Sum]
            end
        end,
    CountList = lists:foldl(F, [], IdList),
    ?LDS_TRACE(57003, [CountList]),
    {ok, BinData} = pt_57:write(57003, [CountList]),
    lib_send:send_to_sock(Status#player_status.socket, BinData),
    ok;


%% 进入副本确认
handle(57004, Status, [Flag]) ->
    TeamId = player:get_team_id(Status),
    CaptainId = mod_team:get_leader_id(TeamId),
    case CaptainId =/= player:id(Status) of
        true ->
            case player:get_pid(CaptainId) of
                Pid when is_pid(Pid) ->
                    Pid ! {dungeon_ensure, player:id(Status), Flag};
                _ -> skip
            end;
        false -> skip
    end;


%% 查询副本信息
handle(57006, Status, _) ->
    case Status#player_status.dun_info of
        #dun_info{dun_pid = Pid, state = in} when is_pid(Pid) ->
            gen_server:cast(Pid, {'send_dun_info', player:id(Status)});
        _ -> skip
    end;


%% 再来一箱
handle(57008, Status, _) ->
    case lib_dungeon:get_dungeon_pass_mem() of
        null ->
            {ok, BinData} = pt_57:write(57008, [?ERROR, ?ERROR]),
            lib_send:send_to_sock(Status#player_status.socket, BinData);
        Rd ->
            BoxList = Rd#dungeon_pass_info.box,
            Dun = lib_dungeon:get_config_data(Rd#dungeon_pass_info.no),
            PlayerMiscData= ply_misc:get_player_misc(player:id(Status)),
            PlayerTimes = PlayerMiscData#player_misc.dungeon_reward_time,

            {GetRewardTimes,LastUnixtime2}
                = case lists:keyfind(Dun#dungeon_data.type, 1, PlayerTimes) of
                      false ->
                          {0, 0};
                      RewardTimeData ->
                          {_DungeonType, RewardTimes, LastUnixTime} = RewardTimeData,
                          %%判断是否同一天
                          case util:is_same_day(LastUnixTime) of
                              true ->
                                  {RewardTimes, LastUnixTime};
                              false ->
                                  {0, 0}
                          end
                  end,

            Num = Dun#dungeon_data.more_box_price,
            Discount = Dun#dungeon_data.discount,

            %%应该是先在副本rd记录一个这场副本的唯一id，检测是相同id则不需要再判断次数
            case Dun#dungeon_data.reward_times  >  GetRewardTimes orelse (util:unixtime() - LastUnixtime2) < 90  of
                true ->
                    case
                        case erlang:length(BoxList) >= ?MAX_BOX_NUM of
                            true -> {true, first};
                            false ->
                                Times = erlang:length(BoxList),
                                {_,GoodsNo,Count} = lists:keyfind(?MAX_BOX_NUM - Times + 1, 1, Num),

                                case  player:check_need_price(Status, GoodsNo, Count) of
                                    ok ->
                                        {true, {GoodsNo,Count}};
                                    MsgCode ->
                                        {fail, MsgCode}
                                end

                        end of
                        {true, NeedCost} ->
                            OldData =
                                case lists:keytake(Dun#dungeon_data.type, 1, PlayerTimes) of
                                    false ->
                                        PlayerTimes;
                                    {value, _, SurplusData} ->
                                        SurplusData
                                end,

                            case  (util:unixtime() - LastUnixtime2) < 90 of
                                true ->
                                    skip;
                                false ->
                                    ply_misc:update_player_misc(PlayerMiscData#player_misc{dungeon_reward_time =[{Dun#dungeon_data.type,GetRewardTimes + 1,util:unixtime()}| OldData] })
                            end,

                            case lib_dungeon:get_box_quality_by_points_lv(Rd) of
                                null ->
                                    {ok, BinData} = pt_57:write(57008, [?ERROR, ?ERROR]),
                                    lib_send:send_to_sock(Status#player_status.socket, BinData);
                                Box ->

                                    ?BIN_PRED(NeedCost =:= first, skip, begin  {MoneyType,MoneyCount} = NeedCost,  player:cost_money(Status, MoneyType, MoneyCount,["pp_dungeon", "box"]) end),
                                    lib_dungeon:set_dungeon_pass_box(Box, Rd#dungeon_pass_info.no),
                                    NewList = lists:delete(Box, BoxList),
                                    lib_dungeon:set_dungeon_pass_mem(Rd#dungeon_pass_info{box = NewList}),
                                    {ok, BinData} = pt_57:write(57008, [?SUCCESS, Box]),
                                    lib_send:send_to_sock(Status, BinData)
                            end;
                        {fail, Reason2}-> lib_send:send_prompt_msg(Status, Reason2)
                    end;
                false ->
                    lib_send:send_prompt_msg(Status, ?PM_LEFT_TIME_LIMIT)

            end

    end;


handle(57013, Status, _) ->
    case lib_dungeon:get_dungeon_pass_box() of
        null -> lib_send:send_prompt_msg(Status, ?PM_DUNGEON_BOX_NO_FOUND);
        {Box, DunNo} ->
            case lib_dungeon:get_config_reward_data(DunNo, Box) of
                0 -> skip;
                RewardId when is_integer(RewardId) ->
                    ?DEBUG_MSG("DungeonRewardNo ~p~n",[RewardId]),
                    DunData = lib_dungeon:get_config_data(DunNo),
                    Group = DunData#dungeon_data.group,

                    NewTime = 
                    case lib_dungeon:get_dungeon_cd(player:id(Status), Group) of
                        null ->  0;
                        CdRd ->
                            ?BIN_PRED(CdRd#dungeon_cd.times > 0, CdRd#dungeon_cd.times, 0) + 1
                    end,
%%  RewardRd = lib_reward:give_reward_to_player(dungeon,2,player:get_PS(1000100000000282), 300502, ["aaa", 1]),
                    ?DEBUG_MSG("NewTime=~p",[NewTime]),
                    RewardRd = lib_reward:give_reward_to_player(dungeon,NewTime,Status, RewardId, [?LOG_DUNGEON, DunNo]),
                    % RewardRd = lib_reward:give_reward_to_player(Status, RewardId, [?LOG_DUNGEON, DunNo]),
                    lib_dungeon:reset_dungeon_pass_box(),
                    List = [{No, Num, mod_inv:get_goods_quality_by_id(player:id(Status), Id), Id, mod_inv:get_goods_bind_state_by_id(Id)} 
                        || {Id, No, Num} <- RewardRd#reward_dtl.goods_list],
                    {ok, BinData} = pt_57:write(57013, [List]),
                    lib_send:send_to_sock(Status, BinData);
                _ -> skip
            end
    end;


%% RESUME CD
handle(57009, _Status, [_Group]) -> skip;
    %  case lib_dungeon:resume_dungeon_cd(Status, Group) of
    %     true ->
    %         LeftTime = lib_dungeon:get_left_times_by_group(player:id(Status), Group),
    %         {ok, BinData} = pt_57:write(57009, [Group, LeftTime]),
    %         lib_send:send_to_sock(Status#player_status.socket, BinData);
    %     {false, Err} ->
    %         lib_send:send_prompt_msg(Status, Err)
    % end;


%% 通知进入下一层副本
handle(57011, Status, []) ->
    case player:is_in_dungeon(Status) of
        false -> lib_send:send_prompt_msg(Status, ?PM_DUNGEON_OUSIDE);
        {true, _Pid} ->
            case player:get_dungeon_type(Status) =:= ?DUNGEON_TYPE_TOWER of
                true -> mod_dungeon:notify_event(?NEXT_FLOOR, [], Status);
                false -> skip
            end,
            case player:get_dungeon_type(Status) =:= ?DUNGEON_TYPE_HARD_TOWER of
                true -> mod_dungeon:notify_event(?NEXT_FLOOR, [], Status);
                false -> skip
            end
    end;


%# 世界BOSS血条
handle(57101, Status, []) ->
    case player:is_in_dungeon(Status) of
        false -> lib_send:send_prompt_msg(Status, ?PM_DUNGEON_OUSIDE);
        {true, Pid} -> Pid ! {'broadcast_boss_hp', player:id(Status)}
    end;

%% 世界BOSS参与人数
handle(57102, Status, []) ->
    case player:is_in_dungeon(Status) of
        false -> lib_send:send_prompt_msg(Status, ?PM_DUNGEON_OUSIDE);
        {true, Pid} -> Pid ! {'broadcast_dungeon_player_num', player:id(Status)}
    end;

%% 世界BOSS 副本界面排名信息
handle(57103, Status, []) ->
    case player:is_in_dungeon(Status) of
        false -> lib_send:send_prompt_msg(Status, ?PM_DUNGEON_OUSIDE);
        {true, Pid} -> Pid ! {'broadcast_boss_damage_rank', player:id(Status)}
    end;


handle(_Cmd, _, _Args) ->
    ?LDS_TRACE("57 protol error", [_Cmd, _Args]),
    ?ASSERT(false),
    error.


get_vip_adv(Num, Discount, Status) ->
    case player:get_vip_lv(Status) > 0 of
        true -> util:ceil(Num * (Discount / 100));
        false -> Num
    end.