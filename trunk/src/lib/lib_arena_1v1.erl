%%%-----------------------------------
%%% @Module  : lib_arena_1v1
%%% @Author  : liuzhongzheng2012@gmail.com
%%% @Email   :
%%% @Created : 2014.6.10
%%% @Description: 1v1在线竞技场(竞技场进程)
%%%-----------------------------------

-module(lib_arena_1v1).

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
    report/2,
    award/3,
    match/1,
    send_reports/2,
    get_week_top/1,
    set_week_top/2,
    weekly_reset/0,
    arena_1v1_close/1,
    do_give_arena_1v1_title/2,
    set_battle_flag/2,
    get_lib_arena_1v1_cache/1,
    put_lib_arena_1v1_cache/2,
    del_lib_arena_1v1_cache/1
	]).


-define(MAX_RECS_LEN, 50).
-define(GIVE_TITLE_ID, 50018).

init() ->
    Top =
        case mod_data:load(?SYS_ARENA_1V1) of
            [Data] ->
                UID = util:get_value(week_top_id, Data, 0),
                Name = util:get_value(week_top_name, Data, <<>>),
                {UID, Name};
            _ ->
                {0, <<>>}
        end,
    State1 = #astate{
            waiters = [],
            recs    = []},
    State2 = set_week_top(Top, State1),
    State2.

join(#waiter{}=Waiter, #astate{waiters=Waiters}=State) ->
    set_cache(Waiter),
    PoolID = pool_id(Waiter),
    Pool1 =
        case lists:keyfind(PoolID, 1, Waiters) of
            {PoolID, Pool} ->
                [Waiter|Pool];
            _ ->
                [Waiter]
        end,
    Waiters1 = lists:keystore(PoolID, 1, Waiters, {PoolID, Pool1}),
    % 检查添加参赛玩家
    NewPlayerInfos = try_add_player(State, Waiter),
	State#astate{waiters=Waiters1, player_infos=NewPlayerInfos}.

leave(#waiter{id=UID}=Waiter, #astate{waiters=Waiters}=State) ->
    PoolID = pool_id(Waiter),
    case lists:keyfind(PoolID, 1, Waiters)  of
        {PoolID, Pool} ->
            Pool1 = lists:keydelete(UID, #waiter.id, Pool),
            Waiters1 = lists:keystore(PoolID, 1, Waiters, {PoolID, Pool1}),
            State#astate{waiters=Waiters1};
        _ ->
            State
    end.

report(#rec{loser=LID, loser_name=LName}=Rec, #astate{recs=Recs}=State) ->
    LName1 = ?IF(LName =:= <<>>, get_cache_name(LID), LName),
    Rec1 = Rec#rec{loser_name=LName1},
    Recs1 = [Rec1|Recs],
    Recs2 = lists:sublist(Recs1, 1, ?MAX_RECS_LEN),
    % 统计更新参赛信息（用于发送离线奖励） -- by yanlh
    PlayerInfos = update_player_infos(State, Rec1),
    State#astate{recs=Recs2, player_infos=PlayerInfos}.

match(#astate{waiters=Waiters}=State) ->
    Waiters1 = [match_pool(P) || P <- Waiters],
    State#astate{waiters=Waiters1}.

match_pool({PoolID, Waiters}) ->
    Waiter1 = lists:sort(fun match_rule/2, Waiters),
    Remain = battle(Waiter1),
    {PoolID, Remain}.

match_rule(#waiter{win=W, win_rate=R, lv=L, rand=RD1}, #waiter{win=W, win_rate=R, lv=L, rand=RD2}) ->
    RD1 > RD2;
match_rule(#waiter{win=W, win_rate=R, lv=L1}, #waiter{win=W, win_rate=R, lv=L2}) ->
    L1 > L2;
match_rule(#waiter{win=W, win_rate=R1}, #waiter{win=W, win_rate=R2}) ->
    R1 > R2;
match_rule(#waiter{win=W1}, #waiter{win=W2}) ->
    W1 > W2.

battle(Waiters) ->
    battle(Waiters, []).

battle([W1, W2|T], Pairs) ->
    battle(T, [{W1, W2}|Pairs]);
battle(Res, Pairs) ->
    proc_lib:spawn(fun() -> start_battle(Pairs) end),
    Res1 = res_piror(Res),
    Res1.

%% 余下的(1或0个waiter), 设置优先级为最高, 提高下次匹配上的机会
res_piror(Res) ->
    [R#waiter{rand=piror} || R <- Res].


start_battle(Pairs) ->
    lists:foreach(fun show_rival/1, Pairs),
    timer:sleep(3000),
    IDPairs = [{ID1, ID2} || {#waiter{id=ID1}, #waiter{id=ID2}} <- Pairs],
    lists:foreach(fun ply_arena_1v1:start_pk/1, IDPairs).

%% 显示对方头像和姓名
show_rival({#waiter{id=ID1}=W1, #waiter{id=ID2}=W2}) ->
    show_rival(ID1, W2),
    show_rival(ID2, W1).

show_rival(UID, #waiter{id=ID, name=Name, sex=Sex, race=Race, lv=Lv}) ->
    %设置玩家为比武准备状态
    put_lib_arena_1v1_cache(UID, ID),
    player:set_cur_bhv_state(player:get_PS(UID), ?BHV_ARENA_1V1_READY),
    {ok, Bin} = pt_27:write(?PT_ARENA_1V1_READY, [ID, Name, Race, Sex, Lv]),
    lib_send:send_to_uid(UID, Bin).

pool_id(#waiter{lv=Lv}) ->
    (Lv - 10) div 20.

%% -------------------------
%% 玩家匹配数据操作
%% -------------------------
get_lib_arena_1v1_cache(PlayerID) ->
    case ets:lookup(?ETS_LIB_ARENA_1V1, PlayerID) of
        [] ->
            null;
        [{PlayerID, OpID}] ->
            OpID
    end.
put_lib_arena_1v1_cache(PlayerID, OpID) ->
    ets:insert(?ETS_LIB_ARENA_1V1, {PlayerID, OpID}).
del_lib_arena_1v1_cache(PlayerID) ->
    ets:delete(?ETS_LIB_ARENA_1V1, PlayerID).

%% 发送全局战报
send_reports(UID, #astate{recs=Recs}) ->
    {ok, Bin} = pt_27:write(?PT_ARENA_1V1_REPORTS, [2, Recs]),
    lib_send:send_to_uid(UID, Bin).


get_week_top(#astate{week_top_id=UID, week_top_name=Name}) ->
    {UID, Name}.

weekly_reset() ->
    % mod_rank:exe(?RANK_ARENA_1V1_WEEK, fun exe_give_title/1), 周日凌晨不再给称号，改为活动结束时刻给予
    mod_rank:exe(?RANK_ARENA_1V1_WEEK, fun exe_weekly_reset/1).

% exe_give_title([#ranker{player_id=UID}|_]) ->
%     lib_offcast:cast(UID, {add_title, ?GIVE_TITLE_ID, util:unixtime()});
% exe_give_title(_) ->
%     ok.

exe_weekly_reset([#ranker{player_id=UID, player_name=Name}|_]) ->
    mod_arena_1v1:set_week_top({UID, Name}),
    mod_rank:reset_board(?RANK_ARENA_1V1_WEEK);
exe_weekly_reset(_) ->
    mod_arena_1v1:set_week_top({0, <<>>}).

set_week_top({UID, Name}, State) ->
    mod_data:save(?SYS_ARENA_1V1, [{week_top_id, UID}, {week_top_name, Name}]),
    State#astate{week_top_id=UID, week_top_name=Name}.

get_cache(UID) ->
    erlang:get({waiter, UID}).

get_cache_name(UID) ->
    case get_cache(UID) of
        #waiter{name=Name} ->
            Name;
        _ ->
            <<>>
    end.

set_cache(#waiter{id=UID}=Waiter) ->
    erlang:put({waiter, UID}, Waiter).

% 添加参赛玩家
try_add_player(#astate{player_infos=PlayerInfos}, #waiter{id=Id}) ->
    case lists:keyfind(Id, #arena_1v1_player.id, PlayerInfos) of
        false -> [#arena_1v1_player{id=Id} | PlayerInfos];
        _ -> PlayerInfos
    end.

get_player_info(Id, PlayerInfos) ->
    case lists:keyfind(Id, #arena_1v1_player.id, PlayerInfos) of
        P when is_record(P, arena_1v1_player) -> P;
        _ -> #arena_1v1_player{id=Id}
    end.

% 更新参赛玩家信息
update_player_infos(#astate{player_infos=PlayerInfos}, 
                    #rec{winer=WId, loser=LId}) ->
    WPlayer     = get_player_info(WId, PlayerInfos),
    NewWPlayer  = WPlayer#arena_1v1_player{day_wins = WPlayer#arena_1v1_player.day_wins + 1, battle_flag = 0},
    LPlayer     = get_player_info(LId, PlayerInfos),
    NewLPlayer  = LPlayer#arena_1v1_player{day_loses = LPlayer#arena_1v1_player.day_loses + 1, battle_flag = 0},
    PlayerInfos1 = lists:keyreplace(WId, #arena_1v1_player.id, PlayerInfos, NewWPlayer),
    PlayerInfos2 = lists:keyreplace(LId, #arena_1v1_player.id, PlayerInfos1, NewLPlayer),
    PlayerInfos2.

% 设置战斗标识
set_battle_flag(Id, #astate{player_infos=PlayerInfos}=State) -> 
    Player = get_player_info(Id, PlayerInfos),
    NewPlayerInfos = lists:keyreplace(Id, #arena_1v1_player.id, PlayerInfos, Player#arena_1v1_player{battle_flag=1}),
    State#astate{player_infos=NewPlayerInfos}.

% 比武大会结束作业
arena_1v1_close(#astate{player_infos=PlayerInfos}=State) ->
    F = fun(#arena_1v1_player{id=Id,day_wins=DWins,day_loses=DLoses,battle_flag=BF}) ->
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
        award(Id, DWins + DLoses, State),
        ok
    end,
    lists:foreach(F, PlayerInfos),
    % 发放称号(延迟10分钟---是为了等排行榜数据刷新、稳定后再发放)
    mod_sys_jobsch:add_schedule(?JSET_GIVE_ARENA_1V1_TITLE, 60*10, fun do_give_arena_1v1_title/2, dummy),

    % 清空参赛玩家列表
    State#astate{player_infos=[]}.


do_give_arena_1v1_title(?JSET_GIVE_ARENA_1V1_TITLE, _) ->
    ?DEBUG_MSG("this is do_give_arena_1v1_title/2, stacktrace:~w", [erlang:get_stacktrace()]),
    mod_rank_gift:daily_title(4002).

% 修改为战斗次数判断给予的奖励
award(Id, Count, #astate{player_infos=PlayerInfos}) ->
    case lists:keyfind(Id, #arena_1v1_player.id, PlayerInfos) of
        false -> skip;
        _Player ->
            % ?ASSERT(_Player#arena_1v1_player.day_wins=:=Wins, {Id, Wins}),
            Wins = _Player#arena_1v1_player.day_wins,
            case data_arena_1v1:get(Count) of
                null ->
                    skip;
                RewardID ->
                    lib_mail:send_sys_mail(Id
                          ,<<"竞技场奖励">>
                          ,<<"这是你的奖励，請笑納！">>
                          % 增加竞技场积分奖励
                          ,[{RewardID, 2, 1},{?VGOODS_FEAT, 1, Wins * 100 + (10 - Wins) * 50}]
                          ,[?LOG_ARENA_1V1, Wins]
                    ),
                    %lib_reward:give_reward_to_player(PS, RewardID, [?LOG_ARENA_1V1, Wins]),
                    ok
            end
    end.
