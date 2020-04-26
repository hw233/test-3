%%%-----------------------------------
%%% @Module  : mod_offline_arena
%%% @Author  : lds
%%% @Email   :
%%% @Created : 2013.12
%%% @Description: 离线竞技场
%%%-----------------------------------

-module(mod_offline_arena).

-behaviour(gen_server).

-include("common.hrl").
-include("record.hrl").
-include("offline_arena.hrl").
-include("ets_name.hrl").
-include("log.hrl").

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([start_link/1
        ,get_ranking_stamp/1
        ,daily_notify/0
        ,delete_ranking_stamp/1
        ,update_last_ranking/2
        ,db_save_all_daily_rank/0
        ,db_load_all_daily_rank/0
        ,set_except_ranking/3
        ,battle_feekback/3
        ,create_arena_table/0
        ,save_final_ranking/0
        ,load_final_ranking/0
        % ,notify_currect_battle_feekback/7
        ]).

-record(state, {group = 0, last_rank = 1, cal_ranking_status = ?CAL_RANKING_END, child_proc = []}).

% -record(man_state, {child_proc = []}).

%% ====================================================================
%% API functions
%% ====================================================================

%% init/1
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:init-1">gen_server:init/1</a>
-spec init(Args :: term()) -> Result when
    Result :: {ok, State}
            | {ok, State, Timeout}
            | {ok, State, hibernate}
            | {stop, Reason :: term()}
            | ignore,
    State :: term(),
    Timeout :: non_neg_integer() | infinity.
%% ====================================================================
init([Name]) ->
    ?LDS_DEBUG("offline_arena init", [Name]),
    case Name =:= ?OA_MANAGE of
        true ->
            case load_ranking() of     %% 加载排行榜
                ok ->
                    case lists:foldl(
                            fun(Group, {Count, List}) ->
                                case gen_server:start_link({local, ?GET_PROC_NAME(Group)}, ?MODULE, [Group], []) of
                                    {ok, Pid} -> {Count, [{?GET_PROC_NAME(Group), Pid} | List]};
                                    _ -> {Count + 1, List}
                                end
                            end,
                            {0, []}, ?GROUP_NAME_LIST) of
                        {0, ProcList} -> 
                            {ok, #state{child_proc = ProcList, group = Name}};
                        _ -> {error, fail}
                    end;
                fail -> {error, fail}
            end;
        false ->
            case load_last_ranking(Name) of
                null -> {error, fail};
                LastRank -> {ok, #state{group = Name, last_rank = LastRank}}
            end
    end.
    %% 加载排行榜
    % load_ranking(Group),
    % {ok, #state{group = Group}}.


%% handle_call/3
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:handle_call-3">gen_server:handle_call/3</a>
-spec handle_call(Request :: term(), From :: {pid(), Tag :: term()}, State :: term()) -> Result when
    Result :: {reply, Reply, NewState}
            | {reply, Reply, NewState, Timeout}
            | {reply, Reply, NewState, hibernate}
            | {noreply, NewState}
            | {noreply, NewState, Timeout}
            | {noreply, NewState, hibernate}
            | {stop, Reason, Reply, NewState}
            | {stop, Reason, NewState},
    Reply :: term(),
    NewState :: term(),
    Timeout :: non_neg_integer() | infinity,
    Reason :: term().
%% ====================================================================

handle_call(_Request, _From, State) ->
    Reply = ok,
    {reply, Reply, State}.


%% handle_cast/2
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:handle_cast-2">gen_server:handle_cast/2</a>
-spec handle_cast(Request :: term(), State :: term()) -> Result when
    Result :: {noreply, NewState}
            | {noreply, NewState, Timeout}
            | {noreply, NewState, hibernate}
            | {stop, Reason :: term(), NewState},
    NewState :: term(),
    Timeout :: non_neg_integer() | infinity.
%% ====================================================================


handle_cast('info', State) ->
    ?LDS_TRACE(info, {self(), State}),
    {noreply, State};


%% @doc 新进入排行榜
handle_cast({novice_enter, RoleId}, State) ->
    try
        case lib_offline_arena:get_offline_arena_rd(RoleId) of
            Arena when is_record(Arena, offline_arena) -> 
                {noreply, State};
            _ ->
                Group = State#state.group,
                LastRank = State#state.last_rank,
                Ranking =
                    case LastRank > ?MAX_RANk_COUNT orelse LastRank =:= ?OVER_MAX_RANKING of
                        true -> ?RANKING_OUTER_VAL;
                        false -> LastRank
                    end,
                Arena = lib_offline_arena:make_new_offline_arena_record(RoleId, Group, Ranking),
                lib_offline_arena:update_offline_arena(Arena),
                lib_offline_arena:spawn_save_offline_arena(Arena),
                case Ranking =:= ?RANKING_OUTER_VAL of
                    true -> {noreply, State};
                    false ->
                        % update_all_ranking(Group, RoleId, Ranking),
                        update_change_ranking(Group, Ranking, RoleId, ?RANKING_OUTER_VAL),
                        if  LastRank =:= ?OVER_MAX_RANKING ->
                                {noreply, State};
                            LastRank >= ?MAX_RANk_COUNT ->
                                spawn_update_last_ranking(Group, ?OVER_MAX_RANKING),
                                {noreply, State#state{last_rank = ?OVER_MAX_RANKING}};
                            true ->
                                NewLastRank = LastRank + 1,
                                spawn_update_last_ranking(Group, NewLastRank),
                                {noreply, State#state{last_rank = NewLastRank}}
                            end
                end
        end
    catch
        _T:_E -> 
            ?ERROR_MSG("[mod_offline_arena] novice_enter error = ~p~n", [{_T, _E}]),
            {noreply, State}
    end;



%% @doc 切换排行榜
handle_cast({change_group, RoleId}, State) ->
    LastRank = State#state.last_rank,
    Group = State#state.group,
    try
        Ranking =
            case LastRank > ?MAX_RANk_COUNT orelse LastRank =:= ?OVER_MAX_RANKING of
                true -> ?RANKING_OUTER_VAL;
                false -> LastRank
            end,
        Arena = lib_offline_arena:make_new_offline_arena_record(RoleId, Group, Ranking),
        gen_server:cast(player:get_pid(RoleId), {'update_offline_arena_rd', Arena}),
        % ?LDS_DEBUG(change_group, {1, LastRank, Ranking}),
        case Ranking =:= ?RANKING_OUTER_VAL of
            true ->
                update_change_ranking(Group, ?RANKING_BLANK_VAL, ?RANKING_OUTER_VAL, RoleId, lib_offline_arena:get_ranking_by_role_id(RoleId, Group)),
                gen_server:cast(player:get_pid(RoleId), 'refresh_offline_arena'),
                {noreply, State};
            false ->
                case lib_offline_arena:get_role_id_by_ranking(Ranking, Group) of
                    Tid when is_integer(Tid) andalso Tid =/= ?RANKING_BLANK_VAL ->
                        % ?LDS_DEBUG(change_group, {2, Tid, lib_offline_arena:get_ranking_by_role_id(RoleId, Group)}),
                        update_change_ranking(Group, ?RANKING_BLANK_VAL, ?RANKING_OUTER_VAL, RoleId, lib_offline_arena:get_ranking_by_role_id(RoleId, Group)),
                        gen_server:cast(player:get_pid(RoleId), 'refresh_offline_arena');
                    _ ->
                        % update_all_ranking(Group, RoleId, Ranking),
                        % ?LDS_DEBUG(change_group, {3, lib_offline_arena:get_ranking_by_role_id(RoleId, Group)}),
                        update_change_ranking(Group, ?RANKING_BLANK_VAL, Ranking, RoleId, lib_offline_arena:get_ranking_by_role_id(RoleId, Group)),
                        gen_server:cast(player:get_pid(RoleId), 'refresh_offline_arena')
                end,
                if  LastRank =:= ?OVER_MAX_RANKING ->
                        {noreply, State};
                    LastRank >= ?MAX_RANk_COUNT ->
                        spawn_update_last_ranking(Group, ?OVER_MAX_RANKING),
                        {noreply, State#state{last_rank = ?OVER_MAX_RANKING}};
                    true ->
                        NewLastRank = LastRank + 1,
                        spawn_update_last_ranking(Group, NewLastRank),
                        {noreply, State#state{last_rank = NewLastRank}}
                    end
        end
    catch 
        _T:_E -> 
            ?ERROR_MSG("[mod_offline_arena] novice_enter error = ~p~n", [{_T, _E}]),
            {noreply, State}
    end;

    % {noreply, State};


%% @doc 离开排行榜组
%% @wanning 暂不保存玩家竞技场信息，配合切换排行榜change_group函数使用(先离开再切换)，由该函数保存
handle_cast({group_graduation, RoleId, _Ranking}, State) ->
    try 
        Group = State#state.group,
        % Ranking = lib_offline_arena:get_ranking_by_role_id(RoleId, Group),
        % update_all_ranking(Group, RoleId, ?RANKING_OUTER_VAL),
        % update_all_ranking(Group, ?RANKING_BLANK_VAL, Ranking),
        catch update_change_ranking(Group, ?RANKING_BLANK_VAL, ?RANKING_OUTER_VAL, RoleId, lib_offline_arena:get_ranking_by_role_id(RoleId, Group)),
        gen_server:cast(?GET_PROC_NAME(Group + 1), {change_group, RoleId}),
        {noreply, State}
    catch 
        _T:_E -> 
            ?ERROR_MSG("[mod_offline_arena] error = ~p~n", [{_T,_E}]),
            {noreply, State}
    end;

handle_cast({'span_group', RoleId, _Ranking, NextGroup}, State) ->
    try 
        Group = State#state.group,
        % Ranking = lib_offline_arena:get_ranking_by_role_id(RoleId, Group),
        % update_all_ranking(Group, RoleId, ?RANKING_OUTER_VAL),
        % update_all_ranking(Group, ?RANKING_BLANK_VAL, Ranking),
        update_change_ranking(Group, ?RANKING_BLANK_VAL, ?RANKING_OUTER_VAL, RoleId, lib_offline_arena:get_ranking_by_role_id(RoleId, Group)),
        gen_server:cast(?GET_PROC_NAME(NextGroup), {change_group, RoleId}),
        {noreply, State}
    catch 
        _T:_E -> ?ERROR_MSG("[mod_offline_arena] error = ~p~n", [{_T,_E}]),
        {noreply, State}
    end;


%% @doc 占坑
handle_cast({occupy_ranking, {InivRank, InivRoleId, Pid}, {PasiRank, ?RANKING_BLANK_VAL}}, State) ->
    try
        Group = State#state.group,
        case lib_offline_arena:get_role_id_by_ranking(PasiRank, Group) of
            null -> ?ASSERT(false), skip;
            ?RANKING_BLANK_VAL ->
                % update_all_ranking(Group, InivRoleId, PasiRank),
                % update_all_ranking(Group, ?RANKING_BLANK_VAL, InivRank),
                update_change_ranking(Group, ?RANKING_BLANK_VAL, PasiRank, InivRoleId, lib_offline_arena:get_ranking_by_role_id(InivRoleId, Group)),
                lib_log:statis_offline_arena(InivRoleId, Group, make_log_rank(InivRank, PasiRank)),
                gen_server:cast(Pid, {occupy_ranking, PasiRank, ?OA_SUCCESS});
            _ ->
                gen_server:cast(Pid, {occupy_ranking, PasiRank, ?OA_ERROR})
        end
    catch
        _T:_E -> ?ERROR_MSG("[mod_offline_arena] error = ~p~n", [{_T,_E}])
    end,
    {noreply, State};



%% @doc 保存每天凌晨玩家排名
handle_cast('save_daily_ranking', State) ->
    try
        Group = State#state.group,
    % 通知各子进程结算排名中
        % notify_child_proc_cal_ranking(?CAL_RANKING_START),
        % 清空排名快照表
        % ets:delete_all_objects(?ETS_RANKING_STAMP),
        % 结算新排名
        List = ets:tab2list(?ETS_OFFLINE_ARENA_ROLE_RANKING(Group)),
        lists:foreach(
            fun(#offline_arena_role_ranking{id = RoleId, rank = Ranking}) ->
                case Ranking =:= ?RANKING_BLANK_VAL orelse Ranking =:= ?RANKING_OUTER_VAL of
                    true -> skip;
                    false -> ets:insert(?ETS_RANKING_STAMP, #ranking_stamp{id = RoleId, rank = Ranking, group = Group})
                end
            end,
            List
        ),
        gen_server:cast(?OA_MANAGE, {'cal_ranking_end', Group})
    catch
        _T:_E -> 
            ?ERROR_MSG("[mod_offline_arena] save_daily_ranking error = ~p~n", [{_T, _E}]),
            gen_server:cast(?OA_MANAGE, {'cal_ranking_end', State#state.group})
    end,
    {noreply, State};


handle_cast({'notify_cal_ranking', Flag}, State) ->
    {noreply, State#state{cal_ranking_status = Flag}};

handle_cast({'query_cal_ranking', From}, State) when State#state.group == ?OA_MANAGE ->
    try
        From ! {'return_cal_ranking_state', State#state.cal_ranking_status =/= ?CAL_RANKING_START},
        {noreply, State}
    catch 
        _T:_E -> 
            ?ERROR_MSG("[mod_offline_arena] save_daily_ranking error = ~p~n", [{_T, _E}]),
            {noreply, State}
    end;


handle_cast('save_daily_ranking_manage', State) when State#state.group == ?OA_MANAGE ->
    try
    % 清空排名快照表
        ets:delete_all_objects(?ETS_RANKING_STAMP),
        lists:foreach(
            fun(Group) -> gen_server:cast(?GET_PROC_NAME(Group), 'save_daily_ranking') end,
            ?GROUP_NAME_LIST
            ),
        erlang:send_after(7200000, self(), 'db_save_daily_ranking'),
        put('cal_ranking_group', ?GROUP_NAME_LIST),
        erlang:send_after(300000, self(), 'force_end_cal_ranking'),
        {noreply, State#state{cal_ranking_status = ?CAL_RANKING_START}}
    catch
        _T:_E ->
        ?ERROR_MSG("[mod_offline_arena_manage] error = ~p~n", [{_T,_E}]),
        {noreply, State}
    end;


handle_cast({'cal_ranking_end', Group}, State) when State#state.group == ?OA_MANAGE ->
    try
        case get('cal_ranking_group') of
            List when is_list(List) -> 
                NewList = lists:delete(Group, List),
                case NewList =:= [] of
                    true ->
                        erase('cal_ranking_group'),
                        {noreply, State#state{cal_ranking_status = ?CAL_RANKING_END}};
                    false ->
                        put('cal_ranking_group', NewList),
                        {noreply, State}
                end;
            _ -> {noreply, State#state{cal_ranking_status = ?CAL_RANKING_END}}
        end
    catch
        _T:_E ->
            ?ERROR_MSG("[mod_offline_arena_manage] error = ~p~n", [{_T,_E}]),
            {noreply, State#state{cal_ranking_status = ?CAL_RANKING_END}}
    end;


handle_cast({'fix_ranking_error', RoleId, Rank, FromPid}, State) ->
    try
        Group = State#state.group,
        case lib_offline_arena:get_role_id_by_ranking(Rank, Group) of
            RoleId -> skip;
            OtherId -> 
                ?ERROR_MSG("[mod_offline_arena] ranking error info = ~p~n", [{RoleId, Rank, Group, OtherId}]),
                NewRank = 
                    case ets:match(?ETS_OFFLINE_ARENA_RANKING(Group), {'_', '$1', RoleId}, 1) of
                        {[[Ranking]], _} -> Ranking;
                        _ -> ?RANKING_OUTER_VAL
                    end,
                ets:insert(?ETS_OFFLINE_ARENA_ROLE_RANKING(Group), #offline_arena_role_ranking{id = RoleId, rank = NewRank}),
                gen_server:cast(FromPid, 'notify_fix_ranking_error')
        end,
        {noreply, State}
    catch 
        _T:_E ->   
            ?ERROR_MSG("[mod_offline_arena_manage] error = ~p~n", [{_T,_E}]),
            {noreply, State}
    end;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% @doc 战斗反馈
handle_cast({'handle_battle_feekback', ChallengerId, RivalId, win}, State) -> 
    try 
        handle_battle_feekback(win, ChallengerId, RivalId, State#state.group),
        {noreply, State}
    catch 
        _T:_E -> 
        ?ERROR_MSG("[mod_offline_arena_manage] error = ~p~n", [{_T,_E}]),
        {noreply, State}
    end;


handle_cast({'handle_battle_feekback', ChallengerId, RivalId, _}, State) ->
    try 
        handle_battle_feekback(lose, ChallengerId, RivalId, State#state.group),
        {noreply, State}
    catch 
        _T:_E -> 
        ?ERROR_MSG("[mod_offline_arena_manage] error = ~p~n", [{_T,_E}]),
        {noreply, State}
    end;


handle_cast(_Msg, State) ->
    {noreply, State}.


%% handle_info/2
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:handle_info-2">gen_server:handle_info/2</a>
-spec handle_info(Info :: timeout | term(), State :: term()) -> Result when
    Result :: {noreply, NewState}
            | {noreply, NewState, Timeout}
            | {noreply, NewState, hibernate}
            | {stop, Reason :: term(), NewState},
    NewState :: term(),
    Timeout :: non_neg_integer() | infinity.
%% ====================================================================
handle_info(timeout, State) ->
    {noreply, State};

handle_info('db_save_daily_ranking', State) ->
    try 
        db_save_all_daily_rank()
    catch
        _T:_E ->
            ?ERROR_MSG("[mod_offline_arena_manage] error = ~p~n", [{_T,_E}])
    end,
    {noreply, State};

handle_info('force_end_cal_ranking', State) when State#state.group == ?OA_MANAGE ->
    {noreply, State#state{cal_ranking_status = ?CAL_RANKING_END}};
    

handle_info(_Info, State) ->
    {noreply, State}.


%% terminate/2
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:terminate-2">gen_server:terminate/2</a>
-spec terminate(Reason, State :: term()) -> Any :: term() when
    Reason :: normal
            | shutdown
            | {shutdown, term()}
            | term().
%% ====================================================================
terminate(_Reason, _State) ->
    ok.


%% code_change/3
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:code_change-3">gen_server:code_change/3</a>
-spec code_change(OldVsn, State :: term(), Extra :: term()) -> Result when
    Result :: {ok, NewState :: term()} | {error, Reason :: term()},
    OldVsn :: Vsn | {down, Vsn},
    Vsn :: term().
%% ====================================================================
code_change(_OldVsn, State, _Extra) ->
    {ok, State}.


%% ====================================================================
%% Interface functions
%% ====================================================================

%% @doc 不同组别分别启动相应的进程管理
start_link(Name) ->
    gen_server:start_link({local, Name}, ?MODULE, [Name], []).
    % [gen_server:start_link({local, ?GET_PROC_NAME(Group)}, ?MODULE, [Group], []) || Group <- ?GROUP_NAME_LIST].


%% @doc


%% ====================================================================
%% Internal functions
%% ====================================================================

%% @doc 加载排行榜
%% @return ok | fail
load_ranking() ->
    TableList = [?ETS_OFFLINE_ARENA_RANKING(TbGroup) || TbGroup <- ?GROUP_NAME_LIST],
    RankList = lists:seq(1, ?MAX_RANk_COUNT),
    [ets:new(EtsTable, [{keypos, #offline_arena_ranking.rank}, named_table, set, public]) || EtsTable <- TableList],
    [ets:new(?ETS_OFFLINE_ARENA_ROLE_RANKING(Group), [{keypos, #offline_arena_role_ranking.id}, named_table, set, public]) || Group <- ?GROUP_NAME_LIST],
    [init_rank(Table, RankList) || Table <- TableList],
    case db:select_all(offline_arena, "`id`, `arena_group`, `rank`", []) of
        List when is_list(List) ->
            F = fun([RoleId, Group, Rank]) ->
                    case Rank =:= ?RANKING_OUTER_VAL of
                        true -> skip;
                        false -> update_all_ranking(Group, RoleId, Rank)
                    end
                end,
            lists:foreach(F, List);
            % check_last_ranking_table();
        _Err ->
            ?ASSERT(false, [_Err]),
            ?ERROR_MSG("load_all_ranking error~p~n", [_Err]),
            fail
    end.


%% @doc 加载组别最后的排名
%% @return  rank::integer() | null
load_last_ranking(Group) ->
    % get_group_last_ranking(Group).
    case db:select_one(offline_arena_group_rank, "`rank`", [{arena_group, Group}]) of
        null ->
            db:insert(?DB_SYS, offline_arena_group_rank, [{arena_group, Group}, {rank, 1}]),
            1;
        Rank when is_integer(Rank) ->
            ?BIN_PRED(Rank >= ?MAX_RANk_COUNT, ?OVER_MAX_RANKING, Rank);
        _ -> null
    end.


%% @doc 更新总排名表
update_all_ranking(Group, RoleId, Rank) ->
    case RoleId =:= ?RANKING_BLANK_VAL of
        true -> skip;
        false ->
            case lib_offline_arena:get_role_id_by_ranking(Rank, Group) of
                null -> skip;
                ?RANKING_BLANK_VAL -> skip;
                TmpRoleId ->  ets:delete(?ETS_OFFLINE_ARENA_ROLE_RANKING(Group), TmpRoleId)
            end
    end,
    ets:insert(?ETS_OFFLINE_ARENA_RANKING(Group), #offline_arena_ranking{rank = Rank, id = RoleId}),
    ets:insert(?ETS_OFFLINE_ARENA_ROLE_RANKING(Group), #offline_arena_role_ranking{id = RoleId, rank = Rank}).


%% @Rank : 要占领的排位   @Sponsor：占领者   @SponRank：占领者原排位
update_change_ranking(_Group, Rank, _Sponsor, SponRank) when Rank =:= SponRank -> skip;
update_change_ranking(Group, Rank, Sponsor, SponRank) ->
    case lib_offline_arena:get_role_id_by_ranking(Rank, Group) of
        RoleId when is_integer(RoleId) ->
            ets:insert(?ETS_OFFLINE_ARENA_RANKING(Group), #offline_arena_ranking{rank = Rank, id = Sponsor}),
            ets:insert(?ETS_OFFLINE_ARENA_ROLE_RANKING(Group), #offline_arena_role_ranking{id = Sponsor, rank = Rank}),
            ets:insert(?ETS_OFFLINE_ARENA_RANKING(Group), #offline_arena_ranking{rank = SponRank, id = RoleId}),
            ets:insert(?ETS_OFFLINE_ARENA_ROLE_RANKING(Group), #offline_arena_role_ranking{id = RoleId, rank = SponRank});
        _ -> skip
    end.
update_change_ranking(Group, RoleId, Rank, Sponsor, SponRank) ->
    ets:insert(?ETS_OFFLINE_ARENA_RANKING(Group), #offline_arena_ranking{rank = Rank, id = Sponsor}),
    ets:insert(?ETS_OFFLINE_ARENA_ROLE_RANKING(Group), #offline_arena_role_ranking{id = Sponsor, rank = Rank}),
    ets:insert(?ETS_OFFLINE_ARENA_RANKING(Group), #offline_arena_ranking{rank = SponRank, id = RoleId}),
    ets:insert(?ETS_OFFLINE_ARENA_ROLE_RANKING(Group), #offline_arena_role_ranking{id = RoleId, rank = SponRank}).

%% 交换排名
exchange_ranking(Group, InivRoleId, InivRank, PosiRoleId, PosiRank) ->
    update_change_ranking(Group, PosiRoleId, PosiRank, InivRoleId, InivRank).


%% @doc 更新组别最后排名
spawn_update_last_ranking(Group, Rank) ->
    % util:actin_new_proc(?MODULE, update_last_ranking, [Group, Rank]).
    update_last_ranking(Group, Rank).

update_last_ranking(Group, Rank) ->
    db:update(?DB_SYS, offline_arena_group_rank, [{rank, Rank}], [{arena_group, Group}]).


%% @doc 初始化排行榜
init_rank(Table, List) ->
    [ets:insert(Table, #offline_arena_ranking{rank = Rank, id = ?RANKING_BLANK_VAL}) || Rank <- List].


% 通知排名变化
% notify_currect_battle_feekback(InivRoleId, InivRank, NewInivRank, PasiRoleId, PasiRank, NewPasiRank, Group) ->
%     gen_server:cast(player:get_pid(InivRoleId), {'currect_battle_feekback', InivRoleId,
%         InivRank, NewInivRank, PasiRoleId, PasiRank, NewPasiRank, Group}).


%% @doc 每天凌晨通知事件
daily_notify() ->
    gen_server:cast(?OA_MANAGE, 'save_daily_ranking_manage').
    


%% 通知子进程结算排名状态
% notify_child_proc_cal_ranking(State) ->
%     [gen_server:cast(?GET_PROC_NAME(Group), {'notify_cal_ranking', State}) || Group <- ?GROUP_NAME_LIST].


%% 取得排名快照
%% @return null | #ranking_stamp{}
get_ranking_stamp(RoleId) ->
    case ets:lookup(?ETS_RANKING_STAMP, RoleId) of
        [] -> null;
        [Rd | _] when is_record(Rd, ranking_stamp) -> Rd
    end.

%% 删除指定排名快照
delete_ranking_stamp(RoleId) ->
    ets:delete(?ETS_RANKING_STAMP, RoleId).



%% @doc 关服保存每天凌晨竞技场排名表
db_save_all_daily_rank() -> 
    db:delete(offline_arena_daily_rank, []),
    F = fun(RankStamp) when is_record(RankStamp, ranking_stamp) andalso RankStamp#ranking_stamp.id =/= ?RANKING_BLANK_VAL ->
        db:insert(RankStamp#ranking_stamp.id, offline_arena_daily_rank, 
            [{role_id, RankStamp#ranking_stamp.id} ,{rank, RankStamp#ranking_stamp.rank}, {arena_group, RankStamp#ranking_stamp.group}]);
        (_) -> skip
    end,
    lists:foreach(F, ets:tab2list(?ETS_RANKING_STAMP)),
    ok.


%% @doc 开服加载排名表
db_load_all_daily_rank() ->
    case db:select_all(offline_arena_daily_rank, "role_id, rank, arena_group", []) of
        [] -> skip;
        List when is_list(List) ->
            lists:foreach(
                fun([RoleId, Rank, Group]) -> 
                    ets:insert(?ETS_RANKING_STAMP, #ranking_stamp{id = RoleId, rank = Rank, group = Group})
                end, List);
        _ -> skip
    end,
    ok.


% send_rank_drop_mail(RoleId) ->
%     lib_mail:send_sys_mail(RoleId, <<"竞技场排名下降">>, <<"主人，您在竞技场中不幸被挑战成功，排名下降，主人快去竞技场反击吧！">>, [], []).


%% @doc 取得排名异常状态
%% @return : 0 | 1
get_except_ranking(ChallengerId, RivalId, RivalRank) -> 
    case ets:lookup(?ETS_RANKING_EXCEPT_STATE, {ChallengerId, RivalId}) of
        [{_, RivalRank}] -> ?OA_RANK_NORMAL;
        _ -> ?OA_RANK_EXCEPT
    end.

set_except_ranking(ChallengerId, RivalId, RivalRank) ->
    ets:insert(?ETS_RANKING_EXCEPT_STATE, {{ChallengerId, RivalId}, RivalRank}).


del_except_ranking(ChallengerId, RivalId) ->
    ets:delete(?ETS_RANKING_EXCEPT_STATE, {ChallengerId, RivalId}).


make_battle_history(RivalId, Ranking, State, CombatType, ExceptState, Time, Feat, Group, Result) ->
    #battle_history{
        timestamp = Time
        ,challenger = player:get_name(RivalId)
        ,combat_type = CombatType
        ,result = Result
        ,state = State
        ,rank = Ranking
        ,feat = Feat
        ,group = Group
        ,except = ExceptState
    }.

update_role_arena_data(RoleId, Ranking, Bh) ->
    case player:is_online(RoleId) of
        true -> gen_server:cast(player:get_pid(RoleId), {'update_offline_arena_data', Ranking, Bh});
        false -> 
            case lib_offline_arena:get_offline_arena_rd(RoleId) of
                Arena when is_record(Arena, offline_arena) ->
                    lib_offline_arena:update_offline_arena(Arena#offline_arena{rank = Ranking, 
                        battle_history = lib_offline_arena:add_bh(Arena#offline_arena.battle_history, Bh)});
                _ -> skip
            end,
            lib_offline_arena:db_save_offline_arena(RoleId, Ranking, Bh)
    end.

update_role_arena_data_win(RoleId, Ranking, Bh) ->
    case player:is_online(RoleId) of
        true -> gen_server:cast(player:get_pid(RoleId), {'update_offline_arena_data_win', Ranking, Bh});
        false -> 
            case lib_offline_arena:get_offline_arena_rd(RoleId) of
                Arena when is_record(Arena, offline_arena) ->
                    WS = Arena#offline_arena.winning_streak,
                    lib_offline_arena:broadcast_win_streak(RoleId, WS + 1),
                    lib_offline_arena:update_offline_arena(Arena#offline_arena{rank = Ranking, 
                        winning_streak = WS + 1, 
                        battle_history = lib_offline_arena:add_bh(Arena#offline_arena.battle_history, Bh)});
                _ -> skip
            end,
            lib_offline_arena:db_save_offline_arena(RoleId, Ranking, Bh)
    end.

update_role_arena_data_lose(RoleId, Ranking, Bh) ->
    case player:is_online(RoleId) of
        true -> gen_server:cast(player:get_pid(RoleId), {'update_offline_arena_data_lose', Ranking, Bh});
        false -> 
            case lib_offline_arena:get_offline_arena_rd(RoleId) of
                Arena when is_record(Arena, offline_arena) ->
                    lib_offline_arena:update_offline_arena(Arena#offline_arena{rank = Ranking, 
                        winning_streak = 0, 
                        battle_history = lib_offline_arena:add_bh(Arena#offline_arena.battle_history, Bh)});
                _ -> skip
            end,
            lib_offline_arena:db_save_offline_arena(RoleId, Ranking, Bh)
    end.


notify_change([]) -> ok;
notify_change([RoleId | Left]) ->   
    case player:is_online(RoleId) of
        true -> gen_server:cast(player:get_pid(RoleId), 'offline_arena_change');
        _ -> skip
    end,
    notify_change(Left).


check_group(_ChallengerId, RivalId, Group) ->
    case lib_offline_arena:get_offline_arena_rd(RivalId) of
        RivalArena when is_record(RivalArena, offline_arena) ->
            % ?LDS_DEBUG("check_group 1", RivalArena#offline_arena.group),
            RivalArena#offline_arena.group =:= Group;
        _ -> 
            % ?LDS_DEBUG("check_group 2", {lib_offline_arena:get_ranking_by_role_id(RivalId, Group), {RivalId, Group}}),
            lib_offline_arena:get_ranking_by_role_id(RivalId, Group) =/= ?RANKING_OUTER_VAL
    end.


battle_feekback(ChallengerId, RivalId, Result) ->
    lib_offline_arena:release_lock(?OA_LOCK),
    case lib_offline_arena:get_offline_arena_rd(ChallengerId) of
        Arena when is_record(Arena, offline_arena) -> 
            gen_server:cast(?GET_PROC_NAME(Arena#offline_arena.group), {'handle_battle_feekback', ChallengerId, RivalId, ?BIN_PRED(Result =:= win, win, lose)});
        _ -> skip
    end.



handle_battle_feekback(win, ChallengerId, RivalId, Group) ->
    ChallengerRank = lib_offline_arena:get_ranking_by_role_id(ChallengerId, Group),
    RivalRank = lib_offline_arena:get_ranking_by_role_id(RivalId, Group),
    ExceptState = get_except_ranking(ChallengerId, RivalId, RivalRank),
    Now = util:unixtime(),
    case check_group(ChallengerId, RivalId, Group) of
        true ->
            case (ChallengerRank > RivalRank andalso RivalRank =/= ?RANKING_OUTER_VAL) orelse 
                (ChallengerRank =:= ?RANKING_OUTER_VAL andalso RivalRank =/= ?RANKING_OUTER_VAL) of
                true -> 
                    NewChallengerRank = RivalRank,
                    NewRivalRank = ChallengerRank,
                    exchange_ranking(Group, ChallengerId, ChallengerRank, RivalId, RivalRank),
                    Money = lib_offline_arena:send_battle_reward(ChallengerId, 1, Group),
                    ChallengerBh = make_battle_history(RivalId, NewChallengerRank, ?OA_RANK_ASC, ?INIV_BATTLE, ExceptState, Now, Money, Group, ?OA_BATTLE_WIN),
                    RivalBh = make_battle_history(ChallengerId, NewRivalRank, ?OA_RANK_DESC, ?PASI_BATTLE, ExceptState, Now, 0, Group, ?OA_BATTLE_LOSE),
                    update_role_arena_data_win(ChallengerId, NewChallengerRank, ChallengerBh),
                    update_role_arena_data(RivalId, NewRivalRank, RivalBh),
                    ?BIN_PRED(NewChallengerRank =:= 1, lib_offline_arena:broadcast_first_place_change(Group, RivalId, ChallengerId), skip),
                    lib_log:statis_offline_arena(ChallengerId, Group, make_log_rank(ChallengerRank, NewChallengerRank)),
                    redo;
                false ->    
                    % ?LDS_DEBUG("[mod_offline_arena] 1"),
                    Money = lib_offline_arena:send_battle_reward(ChallengerId, 1, Group),
                    ChallengerBh = make_battle_history(RivalId, ChallengerRank, ?OA_RANK_STATIC, ?INIV_BATTLE, ExceptState, Now, Money, Group, ?OA_BATTLE_WIN),
                    RivalBh = make_battle_history(ChallengerId, RivalRank, ?OA_RANK_STATIC, ?PASI_BATTLE, ExceptState, Now, 0, Group, ?OA_BATTLE_LOSE),
                    update_role_arena_data_win(ChallengerId, ChallengerRank, ChallengerBh),
                    update_role_arena_data(RivalId, RivalRank, RivalBh),
                    lib_log:statis_offline_arena(ChallengerId, Group, make_log_rank(ChallengerRank, ChallengerRank)),
                    redo
            end;
        false -> 
            % ?LDS_DEBUG("[mod_offline_arena] 2"),
            Money = lib_offline_arena:send_battle_reward(ChallengerId, 1, Group),
            ChallengerBh = make_battle_history(RivalId, ChallengerRank, ?OA_RANK_STATIC, ?INIV_BATTLE, ExceptState, Now, Money, Group, ?OA_BATTLE_WIN),
            RivalBh = make_battle_history(ChallengerId, RivalRank, ?OA_RANK_STATIC, ?PASI_BATTLE, ExceptState, Now, 0, Group, ?OA_BATTLE_LOSE),
            update_role_arena_data_win(ChallengerId, ChallengerRank, ChallengerBh),
            update_role_arena_data(RivalId, RivalRank, RivalBh),
            lib_log:statis_offline_arena(ChallengerId, Group, make_log_rank(ChallengerRank, ChallengerRank)),
            redo
    end,
    notify_change([ChallengerId, RivalId]),
    lib_offline_arena:publ_update_arena_offline_data(ChallengerId),
    del_except_ranking(ChallengerId, RivalId),
    mod_achievement:notify_achi(join_offline_arena, [], ChallengerId),
    mod_achievement:notify_achi(win_offline_arena, [], ChallengerId),
    ok;


handle_battle_feekback(_, ChallengerId, RivalId, Group) ->
    Now = util:unixtime(),
    Money = lib_offline_arena:send_battle_reward(ChallengerId, 0, Group),
    ChallengerRank = lib_offline_arena:get_ranking_by_role_id(ChallengerId, Group),
    RivalRank = lib_offline_arena:get_ranking_by_role_id(RivalId, Group),
    ChallengerBh = make_battle_history(RivalId, 0, ?OA_RANK_STATIC, ?INIV_BATTLE, ?OA_RANK_NORMAL, Now, Money, Group, ?OA_BATTLE_LOSE),
    RivalBh = make_battle_history(ChallengerId, 0, ?OA_RANK_STATIC, ?PASI_BATTLE, ?OA_RANK_NORMAL, Now, Money, Group, ?OA_BATTLE_WIN),
    update_role_arena_data_lose(ChallengerId, ChallengerRank, ChallengerBh),
    update_role_arena_data(RivalId, RivalRank, RivalBh),
    notify_change([ChallengerId, RivalId]),
    del_except_ranking(ChallengerId, RivalId),
    lib_log:statis_offline_arena(ChallengerId, Group, make_log_rank(ChallengerRank, ChallengerRank)),
    catch mod_achievement:notify_achi(join_offline_arena, [], ChallengerId),
    ok.


make_log_rank(Rank1, Rank2) ->
    tool:to_list(Rank1) ++ "_" ++ tool:to_list(Rank2).


%% @doc 保存总排名
save_final_ranking() ->
    db:delete(offline_arena_final_rank, []),
    save_final_ranking(?GROUP_NAME_LIST).


save_final_ranking([]) -> ok;
save_final_ranking([Group | Left]) ->
    F = fun(Ranking) when is_record(Ranking, offline_arena_ranking) andalso Ranking#offline_arena_ranking.id =/= ?RANKING_BLANK_VAL ->
        db:insert(offline_arena_final_rank, [{rank, Ranking#offline_arena_ranking.rank}, {arena_group, Group}, {role_id, Ranking#offline_arena_ranking.id}]);
        (_) -> error
    end,
    lists:foreach(F, ets:tab2list(?ETS_OFFLINE_ARENA_RANKING(Group))),
    save_final_ranking(Left).


%% @doc 开服加载总排名
load_final_ranking() ->
    RankList = lists:seq(1, ?MAX_RANk_COUNT),
    [init_Group_rank(Group, RankList) || Group <- ?GROUP_NAME_LIST],
    case db:select_all(offline_arena_final_rank, "rank, arena_group, role_id", []) of 
        [] -> 
            ?LDS_TRACE(offline_arena, load_role_data),
            case db:select_all(offline_arena, "`id`, `arena_group`, `rank`", []) of
                List when is_list(List) ->
                    F = fun([RoleId, Group, Rank]) ->
                            case Rank =:= ?RANKING_OUTER_VAL of
                                true -> skip;
                                false -> update_all_ranking(Group, RoleId, Rank)
                            end
                        end,
                    lists:foreach(F, List);
                _Err ->
                    ?ASSERT(false, [_Err]),
                    ?ERROR_MSG("load_all_ranking error~p~n", [_Err]),
                    fail
            end;
        List when is_list(List) -> ?LDS_TRACE(offline_arena, load_sys_data), ok = load_final_ranking(List);
        _ -> erlang:error({offline_arena, load_final_ranking})
    end.

init_Group_rank(Group, RankList) ->
    lists:foreach(fun(Rank) -> update_all_ranking(Group, ?RANKING_BLANK_VAL, Rank) end, RankList).
    


load_final_ranking([]) -> ok;
load_final_ranking([[Rank, Group, RoleId] | Left]) ->
    update_all_ranking(Group, RoleId, Rank),
    load_final_ranking(Left).


create_arena_table() ->
    F = fun(Group) ->
        ets:new(?ETS_OFFLINE_ARENA_RANKING(Group), [{keypos, #offline_arena_ranking.rank}, named_table, set, public]),
        ets:new(?ETS_OFFLINE_ARENA_ROLE_RANKING(Group), [{keypos, #offline_arena_role_ranking.id}, named_table, set, public])
    end,
    lists:foreach(F, ?GROUP_NAME_LIST).