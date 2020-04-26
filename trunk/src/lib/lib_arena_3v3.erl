%%%-----------------------------------
%%% @Module  : lib_arena_3v3
%%% @Author  : liuzhongzheng2012@gmail.com
%%% @Email   :
%%% @Created : 2014.6.10
%%% @Description: 3v3在线竞技场(竞技场进程)
%%%-----------------------------------

-module(lib_arena_3v3).

-include("record.hrl").
-include("arena_1v1.hrl").
-include("rank.hrl").
-include("common.hrl").
-include("pt_27.hrl").
-include("log.hrl").
-include("sys_code.hrl").
-include("job_schedule.hrl").
-include("char.hrl").
-include("ets_name.hrl").
-include("goods.hrl").

-export([
    init/0,
	join/2,
    leave/2,
    report/3,
    award/3,
    match/1,
    send_reports/2,
    get_week_top/1,
    set_week_top/2,
    weekly_reset/0,
    arena_3v3_close/1,
    do_give_arena_3v3_title/2,
    set_battle_flag/2,
    get_lib_arena_3v3_cache/1,
    put_lib_arena_3v3_cache/3,
    del_lib_arena_3v3_cache/1,
    set_player_state/3,
    get_player_state/2,
    get_reward_id/3,
    set_player_all_times/2
	]).


-define(MAX_RECS_LEN, 50).
-define(GIVE_TITLE_ID, 50018).

init() ->
    Top =
        case mod_data:load(?SYS_ARENA_3V3) of
            [Data] ->
                UID = util:get_value(week_top_id, Data, 0),
                Name = util:get_value(week_top_name, Data, <<>>),
                {UID, Name};
            _ ->
                {0, <<>>}
        end,
    State1 = #arena_3v3_state{
            waiters = [],
            recs    = []},
    State2 = set_week_top(Top, State1),
    State2.

join(#arena_3v3_waiter{}=Waiter, #arena_3v3_state{waiters=Waiters}=State) ->
    Waiters1 = [Waiter|Waiters],
    % 检查添加参赛玩家
    NewPlayerInfos = try_add_player(State, Waiter),
	State#arena_3v3_state{waiters=Waiters1, player_infos=NewPlayerInfos}.

leave(#arena_3v3_waiter{id=UID}=_Waiter, #arena_3v3_state{waiters=Waiters}=State) ->
    % PoolID = pool_id(Waiter),
    % case lists:keyfind(PoolID, 1, Waiters)  of
    %     {PoolID, Pool} ->
    %         Pool1 = lists:keydelete(UID, #waiter.id, Pool),
    %         Waiters1 = lists:keystore(PoolID, 1, Waiters, {PoolID, Pool1}),
    %         State#arena_3v3_state{waiters=Waiters1};
    %     _ ->
    %         State
    % end.
    case lists:keyfind(UID, #arena_3v3_waiter.id, Waiters) of
        #arena_3v3_waiter{} ->
            Waiters1 = lists:keydelete(UID, #arena_3v3_waiter.id, Waiters),
            State#arena_3v3_state{waiters=Waiters1};
        _ ->
            State
    end.

report(UID, #rec{loser=_LID, loser_name=_LName}=Rec, #arena_3v3_state{recs=Recs}=State) ->
    % LName1 = ?IF(LName =:= <<>>, get_cache_name(LID), LName),
    % Rec1 = Rec#rec{loser_name=LName1},
    Recs1 = [Rec|Recs],
    Recs2 = lists:sublist(Recs1, 1, ?MAX_RECS_LEN),
    % 统计更新参赛信息（用于发送离线奖励） -- by yanlh
    PlayerInfos = update_player_infos(UID, State, Rec),
    State#arena_3v3_state{recs=Recs2, player_infos=PlayerInfos}.

% match(#arena_3v3_state{waiters=Waiters}=State) ->
%     Waiters1 = match_pool(Waiters),
%     State#arena_3v3_state{waiters=Waiters1}.

% match_pool(Waiters) ->
%     Waiter1 = lists:sort(fun match_rule/2, Waiters),
%     Remain = battle(Waiter1),
%     Remain.

% match_rule(#arena_3v3_waiter{team_power = TP1}, #arena_3v3_waiter{team_power = TP2}) ->
%     TP1 > TP2.

% battle(Waiters) ->
%     battle(Waiters, []).

% battle([W1, W2|T], Pairs) ->
%     battle(T, [{W1, W2}|Pairs]);
% battle(Res, Pairs) ->
%     proc_lib:spawn(fun() -> start_battle(Pairs) end),
%     Res1 = res_piror(Res),
%     Res1.

% %% 余下的(1或0个waiter), 设置优先级为最高, 提高下次匹配上的机会
% res_piror(Res) ->
%     % [R#waiter{rand=piror} || R <- Res].
%     Res.
match(#arena_3v3_state{waiters = Waiters} = State) ->
    %计算准备匹配队伍的数量
    ListLength = erlang:length(Waiters),
    case ListLength =< 1 of
        true ->
            State;
        false ->
           IsListLength = ListLength rem 2,
            {WaitList, State1} = 
                case IsListLength =:= 0 of
                    true -> {Waiters, State#arena_3v3_state{waiters = []}};
                    false -> 
                        [H|Tail] = Waiters,
                        {Tail, State#arena_3v3_state{waiters = [H]}}
                end,
            WaitBattleTeam = lists:sort(fun match_rule/2, WaitList),
            battle(WaitBattleTeam),
            State1
    end.
    
   
%匹配规则，平均战力相近的
match_rule(#arena_3v3_waiter{team_power = TP1}, #arena_3v3_waiter{team_power=TP2}) ->
    TP1 > TP2.
    
battle(WaitBattleTeam) -> 
    battle(WaitBattleTeam, []).

battle([W1, W2|T], Pairs) ->
    battle(T, [{W1, W2}|Pairs]);
battle([], Pairs) ->
    proc_lib:spawn(fun() -> start_battle(Pairs) end).


start_battle(Pairs) ->
    lists:foreach(fun show_rival/1, Pairs),
    timer:sleep(3000),
    IDPairs = [{ID1, ID2} || {#arena_3v3_waiter{id=ID1}, #arena_3v3_waiter{id=ID2}} <- Pairs],
    lists:foreach(fun ply_arena_3v3:start_pk/1, IDPairs).

%% 显示对方头像和姓名
show_rival({#arena_3v3_waiter{id=ID1, team_id=TID1, team_name=MyTeamName1}=W1, #arena_3v3_waiter{id=ID2, team_id=TID2, team_name=MyTeamName2}=W2}) ->
    show_rival(ID1, TID1, MyTeamName1, W2),
    show_rival(ID2, TID2, MyTeamName2, W1).

show_rival(UID, TID1, MyTeamName, #arena_3v3_waiter{id=ID, team_id=TID2, team_name=Name}) ->
    %设置玩家为比武准备状态
    % put_lib_arena_3v3_cache(UID, ID),
    player:set_cur_bhv_state(player:get_PS(UID), ?BHV_ARENA_3V3_READY),
    List = [{X, player:get_name(X),player:get_race(X), player:get_sex(X), player:get_lv(X)} || X <- mod_team:get_all_member_id_list(TID2)],
    F = fun(PlayerId) ->
        % ply_arena_3v3:set_cur_arena_3v3_state(PlayerId, ?BHV_ARENA_3V3_READY),
        put_lib_arena_3v3_cache(PlayerId, ID, MyTeamName),
        {ok, Bin} = pt_27:write(?PT_ARENA_3V3_READY, [ID, Name, List]),
        lib_send:send_to_uid(PlayerId, Bin)
    end,
    [F(X) || X <- mod_team:get_all_member_id_list(TID1)].

%% -------------------------
%% 玩家匹配数据操作
%% -------------------------
get_lib_arena_3v3_cache(PlayerID) ->
    case ets:lookup(?ETS_LIB_ARENA_3V3, PlayerID) of
        [] ->
            null;
        [{PlayerID, OpID, MyName}] ->
            {OpID,MyName}
    end.
put_lib_arena_3v3_cache(PlayerID, OpID, MyName) ->
    ets:insert(?ETS_LIB_ARENA_3V3, {PlayerID, OpID, MyName}).
del_lib_arena_3v3_cache(PlayerID) ->
    ets:delete(?ETS_LIB_ARENA_3V3, PlayerID).

%% 发送全局战报
send_reports(UID, #arena_3v3_state{recs=Recs}) ->
    {ok, Bin} = pt_27:write(?PT_ARENA_3V3_REPORTS, [2, Recs]),
    lib_send:send_to_uid(UID, Bin).


get_week_top(#arena_3v3_state{week_top_id=UID, week_top_name=Name}) ->
    {UID, Name}.

weekly_reset() ->
    % mod_rank:exe(?RANK_ARENA_3V3_WEEK, fun exe_give_title/1), 周日凌晨不再给称号，改为活动结束时刻给予
    mod_rank:exe(?RANK_ARENA_3V3_WEEK, fun exe_weekly_reset/1).

% exe_give_title([#ranker{player_id=UID}|_]) ->
%     lib_offcast:cast(UID, {add_title, ?GIVE_TITLE_ID, util:unixtime()});
% exe_give_title(_) ->
%     ok.

exe_weekly_reset([#ranker{player_id=UID, player_name=Name}|_]) ->
    mod_arena_3v3:set_week_top({UID, Name}),
    mod_rank:reset_board(?RANK_ARENA_3V3_WEEK);
exe_weekly_reset(_) ->
    mod_arena_3v3:set_week_top({0, <<>>}).

set_week_top({UID, Name}, State) ->
    mod_data:save(?SYS_ARENA_3V3, [{week_top_id, UID}, {week_top_name, Name}]),
    State#arena_3v3_state{week_top_id=UID, week_top_name=Name}.

% get_cache(UID) ->
%     erlang:get({waiter, UID}).

% get_cache_name(UID) ->
%     case get_cache(UID) of
%         #waiter{name=Name} ->
%             Name;
%         _ ->
%             <<>>
%     end.

% set_cache(#waiter{id=UID}=Waiter) ->
%     erlang:put({waiter, UID}, Waiter).

% 添加参赛玩家
try_add_player(#arena_3v3_state{player_infos=PlayerInfos}, #arena_3v3_waiter{id=_Id, team_id = TeamId}) ->
    F = fun(PlayerId, Acc) ->
        case lists:keyfind(PlayerId, #arena_3v3_player.id, Acc) of
            false -> [#arena_3v3_player{id=PlayerId} | Acc];
            _ -> Acc
        end
    end,
    lists:foldl(F, PlayerInfos, mod_team:get_all_member_id_list(TeamId)).

get_player_info(Id, PlayerInfos) ->
    case lists:keyfind(Id, #arena_3v3_player.id, PlayerInfos) of
        P when is_record(P, arena_3v3_player) -> P;
        _ -> #arena_3v3_player{id=Id}
    end.

% 更新参赛玩家信息
% update_player_infos(#arena_3v3_state{player_infos=PlayerInfos}, 
%                     #rec{winer=WId, loser=LId}) ->
%     F = fun(Id, Acc) ->
%         Player = get_player_info(Id, Acc),
%         NewPlayer  = Player#arena_3v3_player{day_wins = Player#arena_3v3_player.day_wins + 1, battle_flag = 0},
%         Acc1 = lists:keyreplace(Id, #arena_3v3_player.id, Acc, NewPlayer),
%         Acc1
%     end,
%     PlayerInfos1 = lists:foldl(F, PlayerInfos, mod_team:get_all_member_id_list(WId)),
%     PlayerInfos2 = lists:foldl(F, PlayerInfos1, mod_team:get_all_member_id_list(LId)),
%     PlayerInfos2.

% 更新参赛玩家信息
% update_player_infos(#arena_3v3_state{player_infos=PlayerInfos}, 
%                     #rec{winer=WId, loser=LId}) ->
%     WPlayer     = get_player_info(WId, PlayerInfos),
%     NewWPlayer  = WPlayer#arena_3v3_player{day_wins = WPlayer#arena_3v3_player.day_wins + 1, battle_flag = 0},
%     LPlayer     = get_player_info(LId, PlayerInfos),
%     NewLPlayer  = LPlayer#arena_3v3_player{day_loses = LPlayer#arena_3v3_player.day_loses + 1, battle_flag = 0},
%     PlayerInfos1 = lists:keyreplace(WId, #arena_3v3_player.id, PlayerInfos, NewWPlayer),
%     PlayerInfos2 = lists:keyreplace(LId, #arena_3v3_player.id, PlayerInfos1, NewLPlayer),
%     PlayerInfos2.

% 更新参赛玩家信息
update_player_infos(UID, #arena_3v3_state{player_infos=PlayerInfos}, 
                    #rec{winer=UID}) ->
    WPlayer     = get_player_info(UID, PlayerInfos),
    NewWPlayer  = WPlayer#arena_3v3_player{day_wins = WPlayer#arena_3v3_player.day_wins + 1, battle_flag = 0},
    PlayerInfos1 = lists:keyreplace(UID, #arena_3v3_player.id, PlayerInfos, NewWPlayer),
    PlayerInfos1;
update_player_infos(UID,#arena_3v3_state{player_infos=PlayerInfos}, 
                    #rec{loser=UID}) ->
    WPlayer     = get_player_info(UID, PlayerInfos),
    NewWPlayer  = WPlayer#arena_3v3_player{day_loses = WPlayer#arena_3v3_player.day_loses + 1, battle_flag = 0},
    PlayerInfos1 = lists:keyreplace(UID, #arena_3v3_player.id, PlayerInfos, NewWPlayer),
    PlayerInfos1.

% 设置战斗标识
set_battle_flag(Id, #arena_3v3_state{player_infos=PlayerInfos}=State) -> 
    Player = get_player_info(Id, PlayerInfos),
    NewPlayerInfos = lists:keyreplace(Id, #arena_3v3_player.id, PlayerInfos, Player#arena_3v3_player{battle_flag=1}),
    State#arena_3v3_state{player_infos=NewPlayerInfos}.

% 设置玩家战斗整的次数+1
set_player_all_times(Id, #arena_3v3_state{player_infos=PlayerInfos}=State) ->
    Player = get_player_info(Id, PlayerInfos),
    Day_all = Player#arena_3v3_player.day_all + 1,
    NewPlayerInfos = lists:keyreplace(Id, #arena_3v3_player.id, PlayerInfos, Player#arena_3v3_player{day_all = Day_all}),
    State#arena_3v3_state{player_infos=NewPlayerInfos}.

% 设置玩家比武状态
set_player_state(Id, Value, #arena_3v3_state{player_infos=PlayerInfos} = State) ->
    Player = get_player_info(Id, PlayerInfos),
    NewPlayerInfos = lists:keyreplace(Id, #arena_3v3_player.id, PlayerInfos, Player#arena_3v3_player{player_status = Value}),
    State#arena_3v3_state{player_infos=NewPlayerInfos}.

% 得到玩家比武状态
get_player_state(Id, #arena_3v3_state{player_infos=PlayerInfos} = _State) ->
    Player = get_player_info(Id, PlayerInfos),
    Player#arena_3v3_player.player_status.

% 比武大会结束作业
arena_3v3_close(#arena_3v3_state{player_infos=PlayerInfos}=State) ->
    F = fun(#arena_3v3_player{id=Id,day_wins=DWins,day_loses=_DLoses,battle_flag=BF}) ->
        % 强制结束玩家战斗
        case BF =:= 1 of
            false -> skip;
            true ->
                case player:get_PS(Id) of
                    PS when is_record(PS, player_status) ->
                        mod_battle:force_end_battle_no_win_side(PS);
                    _ -> skip
                end
        end,
        % 过滤掉已经发奖励的
        % case DWins=:=?MAX_DAY_WIN orelse DLoses>=?MAX_DAY_LOST of
        %     true -> skip;
        %     false ->
        %         % 发送奖励邮件
        %         award(Id, DWins, State),
        %         ok
        % end,
        % 统一结束后发奖励
        award(Id, DWins, State),
        ok
    end,
    lists:foreach(F, PlayerInfos),
    % 发放称号(延迟10分钟---是为了等排行榜数据刷新、稳定后再发放)
    mod_sys_jobsch:add_schedule(?JSET_GIVE_ARENA_3V3_TITLE, 60*10, fun do_give_arena_3v3_title/2, dummy),

    % 清空参赛玩家列表
    State#arena_3v3_state{player_infos=[]}.


do_give_arena_3v3_title(?JSET_GIVE_ARENA_3V3_TITLE, _) ->
    ?DEBUG_MSG("this is do_give_arena_3v3_title/2, stacktrace:~w", [erlang:get_stacktrace()]),
    mod_rank_gift:daily_title(6001).


award(Id, Wins, #arena_3v3_state{player_infos=PlayerInfos}) ->
    case lists:keyfind(Id, #arena_3v3_player.id, PlayerInfos) of
        false -> skip;
        _Player ->
            ?ASSERT(_Player#arena_3v3_player.day_wins=:=Wins, {Id, Wins}),
            % {Day_wins, Day_all} = ply_arena_3v3:get_arena_3v3_result(Id),
            Day_wins = _Player#arena_3v3_player.day_wins,
            Day_all = _Player#arena_3v3_player.day_all,
            case get_reward_id(Id, Day_wins, Day_all - Day_wins) of
                0 ->
                    skip;
                RewardID ->
                    lib_mail:send_sys_mail(Id
                          ,<<"论剑奖励">>
                          ,<<"这是你的奖励，請笑納！">>
                          ,[{RewardID, 2, 1},{?VGOODS_FEAT, 1, Wins * 100 + (10 - Wins) * 50}]
                          ,[?LOG_ARENA_3V3, Wins]
                    ),
                    %lib_reward:give_reward_to_player(PS, RewardID, [?LOG_ARENA_1V1, Wins]),
                    ok
            end
    end.

get_reward_id(Id, Wins, Loses) ->
    JiFen = Wins * ?WIN_JIFEN + Loses * ?LOSE_JIFEN,
    Nos = data_arena_3v3:get_all_no(),
    F = fun(No,Acc0) ->
        case data_arena_3v3:get(No) of
                Reward when is_record(Reward, arena_3v3_reward) ->
                    if Reward#arena_3v3_reward.min =< JiFen andalso JiFen =< Reward#arena_3v3_reward.max -> Acc1 = Reward#arena_3v3_reward.goods_id, Acc1;
                        true -> Acc0
                    end;
                null -> Acc0
             end     
    end,
    RewardID = lists:foldl(F, 0, Nos),
    ?DEBUG_MSG("get_reward_id Id=~p,Wins=~p,Loses=~p ~p~n", [Id, Wins, Loses, RewardID]),
    RewardID.