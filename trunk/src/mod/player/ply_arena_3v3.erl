%%%-----------------------------------
%%% @Module  : ply_arena_3v3
%%% @Author  : liuzhongzheng2012@gmail.com
%%% @Email   :
%%% @Created : 2014.6.10
%%% @Description: 在线1v1竞技场(玩家进程)
%%%-----------------------------------

-module(ply_arena_3v3).

-include("battle.hrl").
-include("record.hrl").
-include("record/battle_record.hrl").
-include("common.hrl").
-include("arena_1v1.hrl").
-include("activity_degree_sys.hrl").
-include("rank.hrl").
-include("pt_27.hrl").
-include("char.hrl").
-include("log.hrl").
-include("prompt_msg_code.hrl").

-export([
	join/1,
    leave/1,
    start_pk/1,
    daily_reset/1,
    weekly_reset/1,
    send_info/1,
    send_report/1,
    send_week_top/1,
    award/2,
    on_player_tmp_logout/1,
    arena_3v3_close/0,
    get_arena_3v3_result/1
    % get_cur_arena_3v3_state/1,
    % set_cur_arena_3v3_state/2
	]).

-define(ACTID, ?AD_ARENA_3V3).
-define(BCAST_ID, 59).
-define(ARENA_3V3_PLAYER_STATE, arena_3v3_player_state). %% 玩家当前行为

% 活动结束回调
arena_3v3_close() ->
    mod_arena_3v3:arena_3v3_close().

% get_cur_arena_3v3_state(PlayerId) ->
%     ?ASSERT(is_integer(PlayerId), PlayerId),
%     case erlang:get({?ARENA_3V3_PLAYER_STATE, PlayerId}) of
%         undefined -> ?BHV_IDLE;
%         Val -> Val
%     end.

% set_cur_arena_3v3_state(PlayerId, Val) ->
%     ?ASSERT(is_integer(PlayerId), PlayerId),
%     erlang:put({?ARENA_3V3_PLAYER_STATE, PlayerId}, Val).

%判断队伍成员中是否有玩家已达到最大次数
get_arena_3v3_member_max(TeamId) ->
    MemberId = mod_team:get_all_member_id_list(TeamId),
    F = fun(PlayerId, Acc) ->
        case get_arena_3v3(PlayerId) of
            Arena when is_record(Arena, arena1) ->
                % case Arena#arena1.day_wins >= ?MAX_DAY_WIN orelse Arena#arena1.day_all - Arena#arena1.day_wins >= ?MAX_DAY_LOST of
                case Arena#arena1.day_all >= ?MAX_DAY_WIN of
                    true -> Acc1 = Acc+1, Acc1;
                    false -> Acc
                end;
            _ ->
                Acc
        end
    end,
    IsOverTimes = lists:foldl(F, 0, MemberId),
    case IsOverTimes =:= 0 of
        true -> true;
        false -> false
    end.

%%得到队伍成员的平均战斗力
get_arena_3v3_member_avg_power(TeamId) ->
    MemberId = mod_team:get_all_member_id_list(TeamId),
    F = fun(PlayerId, Acc) ->
        Acc1 = ply_attr:get_battle_power(PlayerId) + Acc,
        Acc1
    end,
    AllPower = lists:foldl(F, 0, MemberId),
    AvgPower = AllPower div 3,
    AvgPower.

%%判断是否可以参加3v3比武大会
arena_3v3_join(PS) ->
    ?ylh_Debug("arena_3v3_join id=~p~n", [player:get_id(PS)]),
    TeamFlag = 
        case mod_activity:publ_is_activity_alive(?ACTID) of
            false -> {false, ?PM_ARENA_3V3_NOT_OPEN};
            true ->
                case player:is_in_team(PS) of
                true ->
                    case player:is_leader(PS) of
                        false -> % 在队伍中但是不是队长
                            {false, ?PM_ARENA_3V3_NOT_LEADER};
                        true -> 
                            TeamId = player:get_team_id(PS),
                            case mod_team:is_all_member_in_normal_state(TeamId) of
                                false -> % 队伍中有队员状态异常
                                    {false, ?PM_ARENA_3V3_TEAM_STATUS};
                                true ->
                                    case mod_team:get_member_count(TeamId) =:= ?MAX_PLAYERS of
                                        false -> {false, ?PM_ARENA_3V3_NOT_ENOUGH_PLAYERS};
                                        true ->
                                            LvLimitList = [{30, 200}],
                                            case mod_team:is_all_member_in_lv_limit(TeamId, LvLimitList) of
                                                false -> % 队伍中有队员等级不符合
                                                    {false, ?PM_ARENA_3V3_TEAM_LV_LIMIT};
                                                true -> 
                                                    %判断队伍成员中是否有玩家已达到最大次数
                                                    case get_arena_3v3_member_max(TeamId)of
                                                        false -> {false, ?PM_ARENA_3V3_NOT_ENOUGH_TIMES};
                                                        true ->
                                                            case check_is_already_join(PS) of
                                                                false -> {false, ?PM_ARENA_3V3_ALREADY_JOIN};
                                                                true -> 
                                                                    AvgPower = get_arena_3v3_member_avg_power(TeamId),
                                                                    {true, TeamId, AvgPower}
                                                            end
                                                    end
                                            end
                                    end    
                            end
                    end;
                false -> {false, ?PM_ARENA_3V3_NOT_IN_TEAM}
            end
        end,     
    TeamFlag.

%% 判断是否有加入
check_is_already_join(PS) ->
    case mod_arena_3v3:get_arena_3v3_state() of
        ArenaState when is_record(ArenaState, arena_3v3_state) ->
            Waiters = ArenaState#arena_3v3_state.waiters,
            case Waiters =:= [] of
                true -> true;
                _ -> 
                    case lists:keyfind(player:id(PS), #arena_3v3_waiter.id, Waiters) of
                        #arena_3v3_waiter{} -> false;
                        _ -> true
                    end
            end

    end.

%% 参加比武
join(PS) ->
    case arena_3v3_join(PS) of
        {false, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        {true, TeamId, AvgPower} ->
            do_join(PS, TeamId, AvgPower),
            [ begin init_arena(player:get_PS(X)), {ok, Bin} = pt_27:write(?PT_ARENA_3V3_JOIN, 0),
                    lib_send:send_to_uid(X, Bin) end || X <- mod_team:get_all_member_id_list(TeamId)]
    end.

do_join(PS, TeamId, AvgPower) ->
    Waiter = build_waiter(PS, TeamId, AvgPower),
    player:set_cur_bhv_state(PS, ?BHV_ARENA_3V3_WAITING),
    mod_arena_3v3:join(Waiter).

init_arena(PS) ->
    UID = player:id(PS),
    case get_arena_3v3(UID) of
        null ->
            set_arena_3v3(UID, #arena1{id=UID});
        _ ->
            ok
    end.

build_waiter(PS, TeamId, AvgPower) ->
    UID = player:id(PS),
    Name = mod_team:get_team_name(TeamId),
    Waiter = #arena_3v3_waiter{id=UID, team_id=TeamId, team_name=Name, team_power = AvgPower},
    Waiter.

%% 玩家离开，判断是否在3V3比武竞技中掉线,并返回队长的状态
is_in_arena_3v3(PS) ->
    case player:get_cur_bhv_state(PS) of
        ?BHV_IDLE ->
            case player:is_in_team(PS) of
                false ->
                    ?BHV_IDLE;
                true ->
                    TeamId = player:get_team_id(PS),
                    TeamLeader = mod_team:get_leader_id(TeamId),
                    case player:get_PS(TeamLeader) of
                        null -> null;
                        PS1 ->
                           State = player:get_cur_bhv_state(PS1),
                           {PS1, State} 
                    end
            end;
        Val -> {PS,Val}
    end.

%% 离开比武
leave(PS) ->
    case is_in_arena_3v3(PS) of
        {PS1,?BHV_ARENA_3V3_WAITING} ->
            player:set_cur_bhv_state(PS1, ?BHV_IDLE),
            [begin  
                case get_arena_3v3(X) of
                    Arena1 when is_record(Arena1, arena1) ->
                        mod_rank:arena_3v3(Arena1);
                    _  -> skip
                end
            end || X <- mod_team:get_all_member_id_list(player:get_team_id(PS))],
            TeamId = player:get_team_id(PS),
            AvgPower = get_arena_3v3_member_avg_power(TeamId),
            Waiter = build_waiter(PS1, TeamId, AvgPower),
            mod_arena_3v3:leave(Waiter),
            [begin {ok, Bin} = pt_27:write(?PT_ARENA_3V3_LEAVE, 0),
                    lib_send:send_to_uid(X, Bin) end || X <- mod_team:get_all_member_id_list(player:get_team_id(PS))];
        %% 玩家已经匹配，准备战斗状态
        {PS1, ?BHV_ARENA_3V3_READY} ->
            % [arena_count_add(X)|| X <- mod_team:get_all_member_id_list(player:get_team_id(PS))],
            % player:set_cur_bhv_state(PS, ?BHV_IDLE),
            % set_cur_arena_3v3_state(player:id(PS), ?BHV_IDLE),
            player:set_cur_bhv_state(PS1, ?BHV_IDLE),
            arena_count_add(player:id(PS)),
            mod_arena_3v3:set_player_all_times(player:id(PS)),
            case get_arena_3v3(player:id(PS)) of
                Arena1 when is_record(Arena1, arena1) ->
                    mod_rank:arena_3v3(Arena1);
                _  -> skip
            end,
           
            TeamId = player:get_team_id(PS),
            AvgPower = get_arena_3v3_member_avg_power(TeamId),
            Waiter = build_waiter(PS1, TeamId, AvgPower),
            mod_arena_3v3:leave(Waiter),
            % OppoID = erlang:get({ply_arena_1v1, player:id(PS)}),
            % {OppoID,_} = lib_arena_3v3:get_lib_arena_3v3_cache(player:id(PS)),
            % ?ylh_Debug("leave ply_arena_3v3 OppoID= ~p ~n",[OppoID]),
            % case OppoID of
            %     null ->
            %         skip;
            %     _ ->
            %         player:set_cur_bhv_state(player:get_PS(OppoID), ?BHV_ARENA_3V3_WAITING)
            % end,
            {OppoID,_} = lib_arena_3v3:get_lib_arena_3v3_cache(player:id(PS)),
            [begin {ok, Bin} = pt_27:write(?PT_ARENA_3V3_LEAVE, 1),
                    lib_send:send_to_uid(X, Bin) end || X <- mod_team:get_all_member_id_list(player:get_team_id(OppoID))],
            [begin {ok, Bin} = pt_27:write(?PT_ARENA_3V3_LEAVE, 1),
                    lib_send:send_to_uid(X, Bin) end || X <- mod_team:get_all_member_id_list(player:get_team_id(PS))];
        _ ->
            ok
    end.

%% 发送周榜首
send_week_top(PS) ->
    MyID = player:id(PS),
    {UID, Name} = mod_arena_3v3:get_week_top(),
    {ok, Bin} = pt_27:write(?PT_ARENA_3V3_WEEK_TOP, [UID, Name]),
    lib_send:send_to_uid(MyID, Bin).

%% 日重置
daily_reset(PS) ->
    UID = player:id(PS),
    case get_arena_3v3(UID) of
        #arena1{}=Arena ->
            Arena1 = Arena#arena1{day_wins=0, day_all=0},
            set_arena_3v3(UID, Arena1);
        _ ->
            pass
    end,
    ok.

%% 周重置
weekly_reset(PS) ->
    UID = player:id(PS),
    case get_arena_3v3(UID) of
        #arena1{}=Arena ->
            Arena1 = Arena#arena1{week_wins=0, week_all=0, recs=[]},
            set_arena_3v3(UID, Arena1);
        _ ->
            pass
    end,
    ok.

%% 战斗中掉线的补丁...
on_player_tmp_logout(PS) ->
    leave(PS),
    ok.

%% 向客户端发胜负情况
send_info(PS) ->
    UID = player:id(PS),
    Arena = get_arena_3v3(UID),
    send_info(UID, Arena).

send_info(UID, #arena1{day_wins=DW,
                    day_all=DA,
                    week_wins=WW,
                    week_all=WA
                    }) ->
    DL = DA - DW,
    WL = WA - WW,
    JF = DW * ?WIN_JIFEN + DL * ?LOSE_JIFEN,
    JF1 = case JF > 0 of
        true -> JF;
        false -> 0
    end,
    {ok, Bin} = pt_27:write(?PT_ARENA_3V3_INFO, [DW, DL, WW, WL, JF1]),
    lib_send:send_to_uid(UID, Bin);
send_info(UID, _) ->
    {ok, Bin} = pt_27:write(?PT_ARENA_3V3_INFO, [0, 0, 0, 0, 0]),
    lib_send:send_to_uid(UID, Bin).

%% 向客户端发个人战报
send_report(PS) ->
    UID = player:id(PS),
    Arena = get_arena_3v3(UID),
    send_report(UID, Arena).

send_report(UID, #arena1{recs=Recs}) ->
    {ok, Bin} = pt_27:write(?PT_ARENA_3V3_REPORTS, [1, Recs]),
    lib_send:send_to_uid(UID, Bin);
send_report(UID, _) ->
    {ok, Bin} = pt_27:write(?PT_ARENA_3V3_REPORTS, [1, []]),
    lib_send:send_to_uid(UID, Bin).

%% 开始PK
start_pk({ID1, ID2}) ->
    ?ylh_Debug("start_pk ID1=~p, ID2=~p~n", [ID1, ID2]),
    PS1 = player:get_PS(ID1),
    PS2 = player:get_PS(ID2),
    case is_record(PS1, player_status) andalso
         is_record(PS2, player_status) andalso
         player:is_online(player:id(PS1)) andalso
         player:is_online(player:id(PS2)) andalso
         player:is_arena_3v3_ready(PS1) andalso
         player:is_arena_3v3_ready(PS2) of
         true ->
            %恢复玩家为等待状态
            player:set_cur_bhv_state(PS1, ?BHV_IDLE),
            player:set_cur_bhv_state(PS2, ?BHV_IDLE),
            [begin  
                % set_cur_arena_3v3_state(X, ?BHV_ARENA_3V3_WAITING), 
                arena_count_add(X),
                case get_arena_3v3(X) of
                    Arena1 when is_record(Arena1, arena1) ->
                        mod_rank:arena_3v3(Arena1);
                    _  -> skip
                end, 
                mod_arena_3v3:set_battle_flag(X),
                mod_arena_3v3:set_player_all_times(X)
            end || X <- mod_team:get_all_member_id_list(player:get_team_id(ID1))],
            [begin 
                % set_cur_arena_3v3_state(X, ?BHV_ARENA_3V3_WAITING),
                arena_count_add(X),
                case get_arena_3v3(X) of
                    Arena1 when is_record(Arena1, arena1) ->
                        mod_rank:arena_3v3(Arena1);
                    _  -> skip
                end,  
                mod_arena_3v3:set_battle_flag(X),
                mod_arena_3v3:set_player_all_times(X)
            end || X <- mod_team:get_all_member_id_list(player:get_team_id(ID2))],
            mod_battle:start_3v3_online_arena_pk(PS1, PS2, fun pk_callback/2);
        false ->
            case player:get_cur_bhv_state(PS1) of
                %%有玩家离开
                ?BHV_ARENA_3V3_READY ->
                    player:set_cur_bhv_state(PS1, ?BHV_IDLE);
                _ ->
                    ok
            end,
            case player:get_cur_bhv_state(PS2) of
                %%有玩家离开
                ?BHV_ARENA_3V3_READY ->
                    player:set_cur_bhv_state(PS2, ?BHV_IDLE);
                _ ->
                    ok
            end,
            ?ERROR_MSG("ply_arena_3v3 start_pk error ~n", []),
            skip
    end.

%% 处理PK结果
% pk_callback(UID, Feedback) ->
%     ?ylh_Debug("btl_feedback=~p~n", [Feedback]),
%     F = fun(PlayerId) ->
%         case get_arena_3v3(PlayerId) of
%             #arena1{day_wins=Wins, day_all=All}=Arena
%                         when Wins < ?MAX_DAY_WIN
%                         andalso All - Wins =< ?MAX_DAY_LOST ->
%                             % 因类all是一进入就加的, 因此这里要允许等号
%                 Rec = make_rec(Feedback),
%                 Arena1 = update_arena_3v3(PlayerId, Rec, Arena),
%                 % report(PlayerId, Rec, Arena1),
%                 bcast(PlayerId, Arena1),
               
%                 % award_exp(UID, Feedback),
%                 mod_rank:arena_3v3(Arena1),
%                 set_arena_3v3(PlayerId, Arena1);
%             _ ->
%                 ?WARNING_MSG("arena_3v3 battle too many times", [])
%         end
%     end,
%     [F(X)|| X <- mod_team:get_all_member_id_list(player:get_team_id(UID))],
%     Rec = make_rec(Feedback),
%     report(UID, Rec).

%% 处理PK结果
pk_callback(UID, Feedback) ->
    case get_arena_3v3(UID) of
        #arena1{day_wins=Wins, day_all=All}=Arena
                    when All =< ?MAX_DAY_WIN ->
                    %andalso All - Wins =< ?MAX_DAY_LOST ->
                        % 因类all是一进入就加的, 因此这里要允许等号
            Rec = make_rec(Feedback),
            Arena1 = update_arena_3v3(UID, Rec, Arena),
            report(UID, Rec, Arena1),
            % bcast(UID, Arena1),
            % 修改为统一活动结束后才发奖，去掉失败3场或赢最大10场发放奖励
            % award(UID, Arena1, Feedback), 
            % award_exp(UID, Feedback),
            mod_rank:arena_3v3(Arena1),
            set_arena_3v3(UID, Arena1);
        _ ->
            ?WARNING_MSG("arena_3v3 battle too many times", [])
    end.


%% 生成战报
make_rec(#btl_feedback{player_id=UID, oppo_player_id_list=OppoPlayerIdList, result=win}) ->
    [TID|_T] = OppoPlayerIdList,
    Rec = #rec{winer=UID, loser=TID, time=util:unixtime()},
    make_rec_name(Rec);
make_rec(#btl_feedback{player_id=UID, oppo_player_id_list=OppoPlayerIdList}) ->
    [TID|_T] = OppoPlayerIdList,
    Rec = #rec{winer=TID, loser=UID, time=util:unixtime()},
    make_rec_name(Rec). % 平当双输

make_rec_name(#rec{winer=WID, loser=LID}=Rec) ->
    {_, WName} = lib_arena_3v3:get_lib_arena_3v3_cache(WID),
    {_, LName} = lib_arena_3v3:get_lib_arena_3v3_cache(LID),
    Rec#rec{winer_name=WName, loser_name=LName}.

arena_count_add(UID) ->
    Arena = get_arena_3v3(UID),
    Arena1 = arena_count_add_1(Arena),
    set_arena_3v3(UID, Arena1).
arena_count_add_1(#arena1{day_all=DA, week_all=WA}=Arena) ->
    Arena#arena1{day_all=DA+1, week_all=WA+1}.

update_arena_3v3(UID,
             #rec{winer=UID}=Rec,
             #arena1{day_wins=DWins, week_wins=WWins, recs=Recs}=Arena) ->
            Arena#arena1{day_wins=DWins+1, week_wins=WWins+1, recs=[Rec|Recs]};
update_arena_3v3(_UID,
             Rec,
             #arena1{recs=Recs}=Arena) ->
    Arena#arena1{recs=[Rec|Recs]};
update_arena_3v3(UID, Rec, _NotArena) ->
    update_arena_3v3(UID, Rec, #arena1{id=UID}).

%% 系统公告
bcast(UID, #arena1{day_wins=10}) ->
    Name = player:get_name(UID),
    mod_broadcast:send_sys_broadcast(?BCAST_ID, [Name, UID]); % 走马灯
bcast(_UID, _) ->
    ok.

%% 向竞技场进程发战报
report(UID, #rec{winer=UID}=Rec, #arena1{day_wins=DWins}) -> % 胜方发战报
    Rec1 = Rec#rec{winer_wins=DWins},
    mod_arena_3v3:report(UID, Rec1);
report(UID, #rec{loser=UID}=Rec, _Arena1) -> % 败方发战报
    mod_arena_3v3:report(UID, Rec);
report(_, _, _) ->
    ok.

%%% 发奖 版本1 -- 每次战斗后都发奖励
%award(UID, #arena1{day_wins=Wins}, #btl_feedback{result=win}) ->
%    award(UID, Wins);
%award(UID, _, _) ->
%    award(UID, 0).

%% 发奖 版本2 -- 奖励发放方式为玩家达到3负或者10胜时，发放一次奖励
%%已经10胜
award(UID, #arena1{day_wins=?MAX_DAY_WIN}, #btl_feedback{result=win}) ->
    award(UID, ?MAX_DAY_WIN); 
% 已经完成10场
award(UID, #arena1{day_wins=Wins, day_all=All}, _) when All=:=10 ->
    award(UID, Wins);
award(_UID, _Arena1, _BtlFeedback) ->
    skip.

award(UID, Wins) ->
    % 统一到mod_arena_1v1进程结算奖励
    mod_arena_3v3:award(UID, Wins).

% 经验奖励 (每次战斗后都发)
% 胜利
% award_exp(UID, #btl_feedback{result=win}) -> 
%     WinExpAdd = data_arena_1v1:get_win_exp(player:get_lv(UID)),
%     player:add_exp(player:get_PS(UID), WinExpAdd, [?LOG_ARENA_1V1, "battle_1"]);
% % 失败或者平手
% award_exp(UID, _) ->
%     LoseExpAdd = data_arena_1v1:get_lose_exp(player:get_lv(UID)),
%     player:add_exp(player:get_PS(UID), LoseExpAdd, [?LOG_ARENA_1V1, "battle_0"]).

% calc_win_rate(#arena1{day_wins=0}) ->
%     0;
% calc_win_rate(#arena1{day_all=0}) ->
%     10000;
% calc_win_rate(#arena1{day_wins=Wins, day_all=All}) ->
%     round(Wins/All*10000).

get_arena_3v3(UID) ->
	ply_activity:get(UID, ?ACTID).

set_arena_3v3(UID, Data) ->
	ply_activity:set(UID, ?ACTID, Data).

get_arena_3v3_result(UID) ->
    case get_arena_3v3(UID) of
        Arena1 when is_record(Arena1, arena1) ->
            {Arena1#arena1.day_wins, Arena1#arena1.day_all};
        _ -> {0, 0}
    end.