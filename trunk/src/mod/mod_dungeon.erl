%%%-----------------------------------
%%% @Module  : mod_dungeon
%%% @Author  : lds
%%% @Email   : 
%%% @Created : 2013.10
%%% @Description: 副本
%%%-----------------------------------

%% 战斗回合数   治疗量   封印回合数

-module(mod_dungeon).
-include("common.hrl").
-include("record.hrl").
-include("dungeon.hrl").
-include("player.hrl").
-include("activity_degree_sys.hrl").
-include("record/battle_record.hrl").
-include("offline_data.hrl").
-include("sys_code.hrl").
-include("proc_name.hrl").
-include("rank.hrl").
-include("prompt_msg_code.hrl").
% -include("event.hrl").
-include("log.hrl").

-behaviour(gen_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).


%% ====================================================================
%% API functions
%% ====================================================================
-export([start_link/2, notify_event/3, pack_listening/2, notify_battle_feekback/2, set_dungeon_boss_rank/2, feekback_boss_dungeon/2,
         feekback_boss_dungeon_escape/1, statis_boss_damage_rank/3,
         challage_dungeon_boss/4, fetch_dungeon_player_num/1, fetch_dungoen_boss_damage_rank/1, fetch_dungeon_boss_hp/1,
         notify_activity_degree_pass/2,
         notify_public_event/3]).


start_link('create_guild_dungeon', [DunNo, Id, Stamp, StartFloor, MaxFloor, GuildId]) ->
    gen_server:start_link(?MODULE, ['create_guild_dungeon', DunNo, Id, Stamp, StartFloor, MaxFloor, GuildId], []);

start_link('create_tower_dungeon', [DunNo, Id, RoleId, Stamp, Activers, ListenerId]) ->
    gen_server:start_link(?MODULE, ['create_tower_dungeon', DunNo, Id, RoleId, Stamp, Activers, ListenerId], []);

start_link('create_dungeon', [DunNo, Id, RoleId, Stamp, Activers]) ->
    gen_server:start_link(?MODULE, ['create_dungeon', DunNo, Id, RoleId, Stamp, Activers], []);

start_link('create_boss_dungeon', [DunNo, DunId, Stamp]) ->
    gen_server:start_link(?MODULE, ['create_boss_dungeon', DunNo, DunId, Stamp], []);

% start_link(DunNo, DunId, BuilderId, Timestamp, Activers, ListenerId) ->
%     gen_server:start_link(?MODULE, [DunNo, DunId, BuilderId, Timestamp, Activers, ListenerId], []).

start_link('create_guild_prepare_dungeon', [DunNo, DunId, GuildId, Stamp]) ->
    gen_server:start_link(?MODULE, ['create_guild_prepare_dungeon', DunNo, DunId, GuildId, Stamp], []);

start_link('create_guild_battle_dungeon', [DunNo, DunId, GuildId, Stamp]) ->
    gen_server:start_link(?MODULE, ['create_guild_battle_dungeon', DunNo, DunId, GuildId, Stamp], []).

%% ====================================================================
%% Behavioural functions 
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


init(['create_guild_prepare_dungeon', DunNo, DunId, GuildId, Timestamp]) ->
    process_flag(trap_exit, true),
    DunData = lib_dungeon:get_config_data(DunNo),
    State = #dungeon{
         id = DunId
        ,no = DunNo
        ,pid = self()
        ,type = DunData#dungeon_data.type
        ,diff = DunData#dungeon_data.diff
        ,lv = DunData#dungeon_data.lv
        ,builder = sys
        ,actives = []
        ,create_timestamp = Timestamp
        ,living_time = DunData#dungeon_data.timing
        ,listening = pack_listening(DunData#dungeon_data.default_listener, DunData#dungeon_data.listener)
        ,proc_type = ?DUN_PUB
        ,had_pass_reward = DunData#dungeon_data.had_pass_reward
    },
    % mod_guild_mgr:on_guild_war_dun_create(GuildId, [self(), DunNo]),
    erlang:send_after(1000, self(), {'notify_guild_dungeon', GuildId}),
    {ok, State, 1};

init(['create_guild_battle_dungeon', DunNo, DunId, GuildId, Timestamp]) ->
    process_flag(trap_exit, true),
    DunData = lib_dungeon:get_config_data(DunNo),
    State = #dungeon{
         id = DunId
        ,no = DunNo
        ,pid = self()
        ,type = DunData#dungeon_data.type
        ,diff = DunData#dungeon_data.diff
        ,lv = DunData#dungeon_data.lv
        ,builder = sys
        ,actives = []
        ,create_timestamp = Timestamp
        ,living_time = DunData#dungeon_data.timing
        ,listening = pack_listening(DunData#dungeon_data.default_listener, DunData#dungeon_data.listener)
        ,proc_type = ?DUN_PUB
        ,had_pass_reward = DunData#dungeon_data.had_pass_reward
    },
    erlang:send_after(1000, self(), {'notify_guild_dungeon', GuildId}),
    % mod_guild_mgr:on_guild_war_dun_create(GuildId, [self(), DunNo]),
    {ok, State, 1};

init(['create_boss_dungeon', DunNo, DunId, Timestamp]) ->
    process_flag(trap_exit, true),
    DunData = lib_dungeon:get_config_data(DunNo),
    State = #dungeon{
         id = DunId
        ,no = DunNo
        ,pid = self()
        ,type = DunData#dungeon_data.type
        ,diff = DunData#dungeon_data.diff
        ,lv = DunData#dungeon_data.lv
        ,builder = sys
        ,actives = []
        ,create_timestamp = Timestamp
        ,living_time = DunData#dungeon_data.timing
        ,listening = pack_listening(DunData#dungeon_data.default_listener, DunData#dungeon_data.listener)
        ,proc_type = ?DUN_PUB
        ,had_pass_reward = DunData#dungeon_data.had_pass_reward
    },
    % start_dun_init_timer(DunData),
    init_boss_dungeon_info(DunData),
    {ok, State, 1};


init(['create_guild_dungeon', DunNo, DunId, Timestamp, StartFloor, MaxFloor, GuildId]) ->
    process_flag(trap_exit, true),
    ListenerId = ?FLOOR_TO_ID(StartFloor),
    DunData = lib_dungeon:get_config_data(DunNo),
    State = #dungeon{
         id = DunId
        ,no = DunNo
        ,pid = self()
        ,type = DunData#dungeon_data.type
        ,diff = DunData#dungeon_data.diff
        ,lv = DunData#dungeon_data.lv
        ,had_pass_reward = DunData#dungeon_data.had_pass_reward
        ,builder = sys
        ,actives = []
        ,create_timestamp = Timestamp
        ,living_time = DunData#dungeon_data.timing
        ,listening = pack_listening(DunData#dungeon_data.default_listener ++ [ListenerId], DunData#dungeon_data.listener)
        ,proc_type = ?DUN_PUB
    },
    start_dun_init_timer(DunData),
    put(?DUN_GUILD_MAX_FLOOR, MaxFloor),
    put(?DUN_GUILD_Id, GuildId),
    set_guild_floor(ListenerId),
    % lib_guild:update_dungeon_info(GuildId, [GuildId, self(), StartFloor]),
    {ok, State, 1};

init(['create_tower_dungeon', DunNo, DunId, BuilderId, Timestamp, Activers, Floor]) ->
    process_flag(trap_exit, true),
    DunData = lib_dungeon:get_config_data(DunNo),
    State = #dungeon{
         id = DunId
        ,no = DunNo
        ,pid = self()
        ,type = DunData#dungeon_data.type
        ,diff = DunData#dungeon_data.diff
        ,lv = DunData#dungeon_data.lv
        ,builder = BuilderId
        ,actives = Activers
        ,create_timestamp = Timestamp
        ,living_time = DunData#dungeon_data.timing
        ,listening = pack_listening([Floor], DunData#dungeon_data.listener)
        ,proc_type = ?DUN_PRI
        ,had_pass_reward = DunData#dungeon_data.had_pass_reward
    },
    set_dun_info_in_role(BuilderId, DunId, DunNo, Timestamp, self(), ?DUN_PRI, Activers),
    start_dun_init_timer(DunData),
    {ok, State, 1};

init(['create_dungeon', DunNo, DunId, BuilderId, Timestamp, Activers]) ->
    process_flag(trap_exit, true),
    DunData = lib_dungeon:get_config_data(DunNo),
    State = #dungeon{
         id = DunId
        ,no = DunNo
        ,pid = self()
        ,type = DunData#dungeon_data.type
        ,diff = DunData#dungeon_data.diff
        ,lv = DunData#dungeon_data.lv
        ,builder = BuilderId
        ,actives = Activers
        ,create_timestamp = Timestamp
        ,living_time = DunData#dungeon_data.timing
        ,listening = pack_listening(DunData#dungeon_data.default_listener, DunData#dungeon_data.listener)
        ,proc_type = ?DUN_PRI
        ,had_pass_reward = DunData#dungeon_data.had_pass_reward
    },
    set_dun_info_in_role(BuilderId, DunId, DunNo, Timestamp, self(), ?DUN_PRI, Activers),
    start_dun_init_timer(DunData),
    {ok, State, 1}.


start_dun_init_timer(DunData) ->
    case DunData#dungeon_data.timing =:= ?INFINITE_TIME of
        true -> skip;
        false -> 
            Ref = timing(DunData#dungeon_data.timing),
            put(?DUN_TIMER_REF, Ref)
    end.

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


%% 退出副本
handle_cast({'quit_dungeon', Status}, State) ->
    RoleId = player:id(Status),
    %% 如果是帮派副本， 通知成员退出
    case get(?DUN_GUILD_Id) of
        undefined -> skip;
        GuildId -> 
            case get(?DUN_GUILD_FLOOR) of
                undefined -> ?ERROR_MSG("quit_dungeon can not to find guild floor ~n", []);
                Floor -> lib_guild:update_dungeon_info(GuildId, 
                    [State#dungeon.pid, Floor, underway, lists:delete(RoleId, State#dungeon.actives)])
            end
    end,
    List = case player:is_in_team(Status) of
        true -> 
            case player:is_leader(Status) of
                true -> mod_team:get_can_fight_member_id_list(player:get_team_id(Status));
                false -> mod_team:on_player_quit_dungeon(Status), [RoleId]
            end;
        false -> [RoleId]
    end,
    NewState = quit_dungeon(List, State),
    {noreply, NewState};


%% 发送副本信息给客户端
handle_cast({'send_dun_info', RoleId}, State) ->
    lib_dungeon:send_dungeon_info(RoleId, State),
    {noreply, State};


%% 副本内更换队长
handle_cast({'change_captain', NewCaptainId}, State) ->
    case State#dungeon.proc_type =:= ?DUN_PUB of
        true -> {noreply, State};
        false ->
            Activers = State#dungeon.actives,
            case lists:member(NewCaptainId, Activers) of
                true -> 
                    {noreply, State#dungeon{builder = NewCaptainId}};
                false ->
                    ?ERROR_MSG("DUNGEON change_captain id = ~p not in dungeon actives~n", [NewCaptainId]),
                    ?ASSERT(false),
                    {noreply, State}
            end
    end;


%% 通知副本组队里成员退出
handle_cast({'quit_team', RoleId}, State) ->
    case State#dungeon.proc_type =:= ?DUN_PUB of
        true ->
            NewState1 = 
                if
                    State#dungeon.type =:= ?DUNGEON_TYPE_BOSS ->
                        State;
                    true ->
                        quit_dungeon([RoleId], State)
                end,
            {noreply, NewState1};
        false ->

            Activers = State#dungeon.actives,
            case lists:member(RoleId, Activers) of
                false -> 
                    ?ERROR_MSG("mod_dungeon,quit_team error!RoleId:~p not in Activers~n", [RoleId]),
                    {stop, normal, State};
                true ->
                    NewState1 = quit_dungeon([RoleId], State),
                    NewAct = NewState1#dungeon.actives,
                    case erlang:length(NewAct) of
                        0 -> {stop, normal, NewState1};
                        1 -> 
                            [NewBuilder] = NewAct,
                            {noreply, NewState1#dungeon{builder = NewBuilder}};
                        _ -> 
                            case lib_dungeon:get_real_captain_id(NewAct) of
                                false -> 
                                    ?ERROR_MSG("mod_dungeon,quit_team get_real_captain_id error!~n", []),
                                    {stop, normal, NewState1};
                                [Bid] -> {noreply, NewState1#dungeon{builder = Bid}}
                            end
                    end
            end
    end;

handle_cast({'quit_team', RoleId, CaptainId}, State) ->
    case State#dungeon.proc_type =:= ?DUN_PUB of
        true ->
            NewState1 = 
                if
                    State#dungeon.type =:= ?DUNGEON_TYPE_BOSS ->
                        State;
                    true ->
                        quit_dungeon([RoleId], State)
                end,
            {noreply, NewState1};
        false ->
            Activers = State#dungeon.actives,
            case lists:member(RoleId, Activers) of
                false -> 
                    ?ERROR_MSG("mod_dungeon,quit_team error!RoleId:~p not in Activers~n", [RoleId]),
                    {stop, normal, State};
                true ->
                    NewState1 = quit_dungeon([RoleId], State),
                    NewAct = NewState1#dungeon.actives,
                    case erlang:length(NewAct) of
                        0 -> {stop, normal, NewState1};
                        1 -> 
                            [NewBuilder] = NewAct,
                            {noreply, NewState1#dungeon{builder = NewBuilder}};
                        _ -> 
                            {noreply, NewState1#dungeon{builder = CaptainId}}
                    end
            end
    end;


%% 副本内使用传送阵
handle_cast({'dungeon_tp', Status, TpNo}, State) ->
    lib_dungeon:do_dungeon_teleport(Status, TpNo, State),
    {noreply, State};


handle_cast('info', State) ->
    ?LDS_DEBUG(dungeon_info, [State]),
    ?LDS_DEBUG("boss info", [{boss_hp, get(?DUNGEON_BOSS_HP)},
        {dun_player_num, get(?DUNGEON_PLAYER_NUM)},
        {final_kill_boss, get(?FINAL_KILL_BOSS)},
        {boss_damage_rank, get(?BOSS_DAMAGE_RANK)},
        {timer, get(?DUN_TIMER_REF(10))}
        ]),
    {noreply, State};


handle_cast({'transfer_dungeon', ToDunPid, RoleId}, State) ->
    try 
        case clean_role_dun_info(RoleId, State) of
            false ->  {noreply, State};
            {NewDungeon, {SceneId, X, Y}} -> 
                ?LDS_TRACE(clean_role_dun_info, true),
                gen_server:cast(ToDunPid, {'transfer_enter_dungeon', RoleId, SceneId, X, Y}),
                {noreply, NewDungeon}
        end
    catch
        _T:_E -> ?ERROR_MSG("[dungeon] Type = ~p, error = ~p~n", [_T, _E]), {noreply, State}
    end;

handle_cast({'transfer_enter_dungeon', RoleId, SceneId, X, Y}, State) ->
    try 
        case lib_dungeon:get_config_data(State#dungeon.no) of
            DunData when is_record(DunData, dungeon_data) ->
                case lib_dungeon:get_random_pos(DunData#dungeon_data.init_pos) of
                    {MapNo, MX, MY} -> State#dungeon.pid ! {'transfer_enter_dungeon', RoleId, util:unixtime(), MapNo, MX, MY, {SceneId, {X, Y}}};
                    _ -> ?ERROR_MSG("[dungeon] transfer_enter_dungeon can not find init_pos", [])
                end;
            _ -> ?ERROR_MSG("[dungeon] transfer_enter_dungeon can not find config data", [])
        end,
        {noreply, State}
    catch
        _T:_E -> ?ERROR_MSG("[dungeon] Type = ~p, error = ~p~n", [_T, _E]), {noreply, State}
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
%% gen server timeout msg
%% 执行已经初始化加载的监听事件,并通知玩家进入副本
handle_info(timeout, State) ->
    %% 立即执行初始化加载的监听事件
    ?LDS_TRACE("Create dungeon Pid, No, Id", [{State#dungeon.pid, State#dungeon.no, State#dungeon.id}]),
    NewState = exec_listeners(State, State#dungeon.builder, [[], []]),
    put(?DUNGEON_PLAYER_NUM, erlang:length(NewState#dungeon.actives)),
    {noreply, NewState};

%% 副本运行时限到，强行关闭副本，清理玩家出副本
handle_info({timeout, _Ref, 'terminate'}, State) ->
    % redo,  %% 玩家正在进行事件，如战斗等是否要等待?
    % BuilderId = State#dungeon.builder,
    F = fun(RoleId) ->
        case player:is_online(RoleId) of
            true -> 
                case player:get_PS(RoleId) of
                    Status when is_record(Status, player_status) ->
                        case player:is_battling(Status) of
                            true -> mod_battle:force_end_battle(Status);
                            false -> skip
                        end;
                    _ -> skip
                end,
                lib_dungeon:notify_dungeon_time_out(RoleId);
            false -> skip
        end
    end,
    lists:foreach(F, State#dungeon.actives),
    {stop, normal, State};

handle_info({timeout, _Ref, 'check_dungeon_activers'}, State) ->
    Activers = [lib_scene:get_scene_player_ids(SceneId) || {_, SceneId} <- State#dungeon.map_index, is_integer(SceneId)],
    case lists:flatten(Activers) =:= [] orelse State#dungeon.actives =:= [] of
        true -> 
            {stop, normal, State};
        false -> 
            erlang:start_timer(?PASS_WAITING_CLOSE_TIME, self(), 'check_dungeon_activers'),
            {noreply, State}
    end;


%% 计时器到期通知
handle_info({timeout, _Ref, {?ADD_DUN_TIMER, Time}}, State) ->
    % ?LDS_DEBUG("计时器到期通知"),
    NewState = exec_listeners(State, State#dungeon.builder, [?DUN_TIMER_TIMEOUT, [Time]]),
    {noreply, NewState};

%% 回调帮派副本相关信息
handle_info({'notify_guild_dungeon', GuildId}, State) ->
    try
        mod_guild_mgr:on_guild_war_dun_create(GuildId, [State#dungeon.pid, State#dungeon.no]),
        {noreply, State}
    catch
        _T:_E -> ?ERROR_MSG("[dungeon] notify_guild_dungeon error = ~p~n", [{_T, _E}]), {noreply, State}
    end;


%% 广播副本人数
handle_info('broadcast_dungeon_player_num', State) ->
    case State#dungeon.actives =:= [] of
        true -> skip;
        false ->
            Num = case get(?DUNGEON_PLAYER_NUM) of
                Int when is_integer(Int) -> Int;
                _ -> erlang:length(State#dungeon.actives)
            end,
            {ok, BinData} = pt_57:write(57102, [Num]),
            F = fun(RoleId) -> 
                case player:is_online(RoleId) of
                    true -> 
                        case player:get_PS(RoleId) of
                            Status when is_record(Status, player_status) ->
                                case player:is_battling(player:get_PS(RoleId)) of
                                    true -> skip;
                                    false -> lib_send:send_to_uid(RoleId, BinData)
                                end;
                            _ -> skip
                        end;
                    _ -> skip
                end
            end,
            lists:foreach(F, State#dungeon.actives)
    end,
    erlang:send_after(?BROADCAST_DUNGEON_PLAYER_NUM, self(), 'broadcast_dungeon_player_num'),
    {noreply, State};

handle_info({'broadcast_dungeon_player_num', RoleId}, State) ->
    Num = case get(?DUNGEON_PLAYER_NUM) of
        Int when is_integer(Int) -> Int;
        _ -> erlang:length(State#dungeon.actives)
    end,
    {ok, BinData} = pt_57:write(57102, [Num]),
    lib_send:send_to_uid(RoleId, BinData),
    {noreply, State};


%% 广播BOSS血量
handle_info('broadcast_boss_hp', State) ->
    case State#dungeon.actives =:= [] of
        true -> skip;
        false -> 
            case get(?DUNGEON_BOSS_HP) of
                {BossNo, MaxHp, CurHp} -> 
                    {ok, BinData} = pt_57:write(57101, [BossNo, MaxHp, CurHp]),
                    F = fun(RoleId) -> 
                        ?BIN_PRED(player:is_online(RoleId), lib_send:send_to_uid(RoleId, BinData), skip)
                    end,
                    lists:foreach(F, State#dungeon.actives);
                _ -> skip
            end
    end,
    {noreply, State};

handle_info({'broadcast_boss_hp', RoleId}, State) ->
    case get(?DUNGEON_BOSS_HP) of
        {BossNo, MaxHp, CurHp} -> 
            {ok, BinData} = pt_57:write(57101, [BossNo, MaxHp, CurHp]),
            lib_send:send_to_uid(RoleId, BinData);
        _ -> 
            {ok, BinData} = pt_57:write(57101, [0, 0, 0]),
            lib_send:send_to_uid(RoleId, BinData)
    end,
    {noreply, State};


%% 世界BOSS战斗反馈
%% @BossNo : BOSS编号
%% @RawHp : BOSS进战斗前血量
%% @LeftHp : BOSS结束战斗血量
%% @RawTeamList : 进入战斗时队伍成员列表
%% @LeftTeamList : 战斗结束时还在队伍的成员列表
handle_info({'boss_battle_feekback', BossNo, RawHp, LeftHp, RawTeamList, LeftTeamList, HireList}, State) ->
    try
        case get(?DUNGEON_BOSS_HP) of
            {BossNo, MaxHp, OldHp} ->
                case RawHp > LeftHp of
                    true ->
                        ReducesHp = RawHp - LeftHp,
                        % ?LDS_TRACE("[dungeon] poke_boss", ReducesHp),
                        
                        Now = util:unixtime(),
                        TeamNum = ?BIN_PRED(RawTeamList =:= [], 1, erlang:length(RawTeamList)) + erlang:length(HireList),
                        Damage = erlang:round(ReducesHp / TeamNum),
                        F = fun(RoleId, Acc) ->
                            case get(RoleId) of
                                {_, OriDamage} ->
                                    put(RoleId, {Now, (OriDamage + Damage)}), 
                                    [{OriDamage + Damage, RoleId} | Acc];
                                    % sort_boss_damage(RoleId, (OriDamage + Damage));
                                _ -> 
                                    put(RoleId, {Now, Damage}),
                                    [{Damage, RoleId} | Acc]
                                    % sort_boss_damage(RoleId, Damage)
                            end
                        end,
                        Sum = lists:foldl(F, [], LeftTeamList),
                        catch sort_boss_damage(Sum),
                        catch broadcast_boss_damage_rank(?BOSS_RANK_NUM, [Uid || Uid <- State#dungeon.actives, player:is_online(Uid)]),
                        case OldHp > 0 of
                            true -> 
                                NewHp = ?BIN_PRED(OldHp > ReducesHp, OldHp - ReducesHp, 0),
                                put(?DUNGEON_BOSS_HP, {BossNo, MaxHp, NewHp}),
                                catch broadcast_boss_hp(NewHp, BossNo, State, LeftTeamList);
                            false -> skip
                        end;
                    false -> skip
                end;

            _T -> ?LDS_DEBUG("[dungeon] poke_boss error", [_T,   BossNo]), skip
        end,
        {noreply, State}
    catch
        _:_ -> {noreply, State}
    end;

%% 广播世界BOSS伤害排行给个人
handle_info({'broadcast_boss_damage_rank', RoleId}, State) ->
    broadcast_boss_damage_rank(?BOSS_RANK_NUM, [RoleId]),
    {noreply, State};


%% 处理世界BOSS被击杀后事宜
handle_info({'after_dungeon_boss_killed', LeftTeamList}, State) -> 
    put(?FINAL_KILL_BOSS, LeftTeamList),
    case get(?DUNGEON_BOSS_HP) of
        {BossNo, MaxHp, _} -> 
			case BossNo =:= 13200 of
				true ->erlang:send_after(?DUN_BOSS_DELAY_REWARD_TIME, self(), {'delay_send_boss_reward_molong', LeftTeamList});
				false ->erlang:send_after(?DUN_BOSS_DELAY_REWARD_TIME, self(), {'delay_send_boss_reward_yijie', LeftTeamList})
			end,
            Time = case get(?DUNGEON_BOSS_TIME) of
                Int when is_integer(Int) -> util:unixtime() - Int;
                _ -> 0
            end,
            catch lib_log:statis_world_boss(MaxHp, "dead", Time);
        _ -> skip
    end,
    {noreply, State};

%% 时间到世界BOSS还没被击杀
handle_info('clear_dungeon_boss', State) ->
    F = fun(RoleId) ->
        case player:get_PS(RoleId) of
            Status when is_record(Status, player_status) ->
                case player:is_battling(Status) of
                    true -> catch mod_battle:force_end_battle(Status);
                    false -> skip
                end;
            _ -> skip
        end
    end,
    lists:foreach(F, [Uid || Uid <- State#dungeon.actives, player:is_online(Uid)]),
    case get(?DUNGEON_BOSS_HP) of
        {BossNo, MaxHp, _} -> 
            Time = case get(?DUNGEON_BOSS_TIME) of
                Int when is_integer(Int) -> util:unixtime() - Int;
                _ -> 0
            end,
            catch lib_log:statis_world_boss(MaxHp, "live", Time),
            put(?DUNGEON_BOSS_HP, {BossNo, MaxHp, 0});
        _ -> skip
    end,
    erlang:send_after(?DUN_BOSS_DELAY_REWARD_TIME, self(), {'delay_send_boss_reward', []}),
    {noreply, State};


%% @doc 延迟发放奖励
handle_info({'delay_send_boss_reward_molong', TeamList}, State) ->
    RankList = 
        case get(?BOSS_DAMAGE_RANK) of
            L when is_list(L) -> L;
            _ -> []
        end,
    %% 根据排行榜发放奖励
    case get(?DUNGEON_BOSS_HP) of
        {_, MaxHp, _} -> util:actin_new_proc(?MODULE, statis_boss_damage_rank, [RankList, MaxHp,1]);
        _ -> skip
    end,
    %% 发放最终击杀奖励
    catch statis_final_kill_boss(TeamList,1),
    %% 通知排行榜
    util:actin_new_proc(?MODULE, set_dungeon_boss_rank, [RankList, TeamList]),
    erlang:send_after(?BOSS_DUNGEON_WAIT_CLOSE, self(), 'close_dungeon'),
	gen_server:cast(dungeon_manage, {'dungeon_close',1000 , ?BOSS_DUNGEON_NO_MOLONG}),
    {noreply, State};

%% @doc 延迟发放奖励
handle_info({'delay_send_boss_reward_yijie', TeamList}, State) ->
    RankList = 
        case get(?BOSS_DAMAGE_RANK) of
            L when is_list(L) -> L;
            _ -> []
        end,
    %% 根据排行榜发放奖励
    case get(?DUNGEON_BOSS_HP) of
        {_, MaxHp, _} -> util:actin_new_proc(?MODULE, statis_boss_damage_rank, [RankList, MaxHp,2]);
        _ -> skip
    end,
    %% 发放最终击杀奖励
    catch statis_final_kill_boss(TeamList,2),
    %% 通知排行榜
    util:actin_new_proc(?MODULE, set_dungeon_boss_rank, [RankList, TeamList]),
    erlang:send_after(?BOSS_DUNGEON_WAIT_CLOSE, self(), 'close_dungeon'),
    gen_server:cast(dungeon_manage, {'dungeon_close',1000 , ?BOSS_DUNGEON_NO_YIJUN}), 
    {noreply, State};


%% 世界BOSS战斗逃跑反馈
handle_info({'boss_battle_escape', RoleId}, State) ->
    Now = util:unixtime(),
    case get(RoleId) of
        {_, Damage} -> put(Now, Damage);
        _ -> put(Now, 0)
    end,
    {noreply, State};


%% 挑战世界BOSS
handle_info({'challage_boss', TeamList, BossNo, BossId, PlayerId}, State) ->
    case get(?DUNGEON_BOSS_HP) of
        {BossNo, _, CurHp} when CurHp > 0 ->
            Now = util:unixtime(),
            List = lists:foldl(
                fun(RoleId, Acc) -> 
                    case get(RoleId) of
                        {Timestamp, _} -> ?BIN_PRED(Timestamp + ?BOSS_CHAL_CD < Now, Acc, [{RoleId, Timestamp} | Acc]);
                        _ -> Acc
                    end
                end, [], TeamList),
            case erlang:length(List) > 0 of
                true -> 
					case BossNo =:= 13200 of
				        true ->[lib_send:send_prompt_msg(RoleId, ?PM_DUNGEON_BOSS_CD) || RoleId <- TeamList];
				        false ->[lib_send:send_prompt_msg(RoleId, ?PM_DUNGEON_BOSS_YIJIR_CD) || RoleId <- TeamList]
					end;
                false -> 
                    lists:foreach(
                        fun(RoleId) -> 
                            case get(RoleId) of
                                {_, Damage} -> put(RoleId, {Now, Damage});
                                _ -> put(RoleId, {Now, 0})
                            end
                        end, TeamList),
                    %% 调用挑战世界BOSS接口
                    % ?LDS_DEBUG("[dungeon] challage boss CurHp ", [CurHp, BossNo]),
                    catch mod_battle:start_world_boss_mf(player:get_PS(PlayerId), mod_mon:get_obj(BossId), CurHp, null) 
            end;
        _T -> ?LDS_DEBUG("[dungeon] challage boss ", [_T]), skip
    end,
    {noreply, State};


%% 副本事件通知
handle_info({notify_event, [EventType, Args, _Id]}, State) ->
    BuildId = State#dungeon.builder,
    NewState = 
        case is_dungeon_register_event(EventType) of
            true ->  exec_listeners(State, BuildId, [EventType, Args]);
            false ->  State
        end,
    {noreply, NewState};


%% 副本公共事件通知
handle_info({notify_public_event, [EventType, Args]}, State) ->
    NewState = 
        case is_dungeon_public_register_event(EventType) of
            true ->  exec_listeners(State, sys, [EventType, Args]);
            false ->  State
        end,
    {noreply, NewState};


%% 副本内战斗回合反馈
handle_info({'bout_feekback', Bouts}, State) ->
    {noreply, State#dungeon{bouts = State#dungeon.bouts + Bouts}};

%% 副本内战斗死亡反馈
handle_info({'dead_feekback', DeadNum}, State) ->
    {noreply, State#dungeon{deads = State#dungeon.deads + DeadNum}};

%% 玩家传送出副本处理
handle_info({'role_convey_out', RoleId}, State) ->
    NewActives = lists:delete(RoleId, State#dungeon.actives),
    {noreply, State#dungeon{actives = NewActives}};


%% 关闭副本
handle_info('close_dungeon', State) ->
    {stop, normal, State};

%% 临时退出检查副本是否通关,通关则马上关闭副本
handle_info('temp_logout_dungeon', State) ->
    case State#dungeon.pass =:= ?PASS andalso State#dungeon.proc_type =:= ?DUN_PRI of
        true ->  {stop, normal, State};
        false -> {noreply, State}
    end;


%% 检查副本是否还有人,没有则进入准备关闭状态
handle_info('check_dungeon', State) ->
    case State#dungeon.actives =:= [] of
        false -> 
            Activers = [lib_scene:get_scene_player_ids(SceneId) || {_, SceneId} <- State#dungeon.map_index, is_integer(SceneId)], 
            case lists:flatten(Activers) =:= [] of
                true ->
                    {stop, normal, State};
                false -> 
                    {noreply, State}
            end;

        true -> 
            %% 私人副本关闭，公共副本不处理
            case State#dungeon.proc_type =:= ?DUN_PUB of
                true -> skip;
                false -> erlang:start_timer(?CLOSE_WAITING_TIME, self(), 'finanl_check_dungeon')
            end,
            {noreply, State}
    end;
    

handle_info({timeout, _Ref, 'finanl_check_dungeon'}, State) ->
    case State#dungeon.actives =:= [] of
        true ->  self() ! 'close_dungeon';
        false -> skip
    end,
    {noreply, State};

handle_info('ahead_check', State) ->
    NewState = exec_listeners(State, State#dungeon.builder, ?AHEAD_CHECK),
    {noreply, NewState};

handle_info('gm_clean', State) ->
    Dungeon = State,
    F = fun(SceneId) ->
            case lib_scene:is_exists(SceneId) of
                true -> mod_scene:clear_scene(SceneId);
                false -> ?ERROR_MSG("dungeon close clean scene error MapList = ~p~n", [Dungeon#dungeon.map_index])
            end
        end,
    [F(SceneId) || {_, SceneId} <- Dungeon#dungeon.map_index, is_integer(SceneId)],
    %% 清除所有在等待清除队列中的地图数据
    case get(?WAIT_TO_RECLAIM) of
        undefined -> skip;
        WaitMapList ->
            [mod_scene:clear_scene(SceneId) || {_, SceneId} <- WaitMapList, is_integer(SceneId)]
    end,
    {noreply, State};

%% 进入副本（默认位置）
handle_info({'enter_public_dungeon', RoleId, Timestamp}, State) ->
    try 
        ?LDS_TRACE(ok),
        case lib_dungeon:get_config_data(State#dungeon.no) of
            DunData when is_record(DunData, dungeon_data) ->
                case lib_dungeon:get_random_pos(DunData#dungeon_data.init_pos) of
                    {MapNo, X, Y} -> State#dungeon.pid ! {'enter_public_dungeon', RoleId, Timestamp, MapNo, X, Y};
                    _ -> skip
                end;
            _ -> skip
        end,
        {noreply, State}
    catch
        _:_ -> {noreply, State}
    end;

%% 进入副本 (指定位置坐标)
handle_info({'enter_public_dungeon', RoleId, Timestamp, MapNo, X, Y}, State) ->
    try
    case player:get_PS(RoleId) of
        Status when is_record(Status, player_status) ->
            case player:is_in_dungeon(Status) of
                {true, _} -> {noreply, State};
                false ->
                    case State#dungeon.proc_type =:= ?DUN_PUB  of 
                        false -> {noreply, State};
                        true ->
                            case lists:keyfind(MapNo, 1, State#dungeon.map_index) of
                                false -> {noreply, State};
                                {MapNo, SceneId} ->
                                    ?LDS_TRACE("[mod_dungeon] enter_public_dungeon find map", [{MapNo, SceneId}]),
                                    gen_server:cast(player:get_pid(RoleId), {'do_single_teleport', SceneId, X, Y}),
                                    case catch set_dun_info_in_role(sys, State#dungeon.id, State#dungeon.no, Timestamp, State#dungeon.pid, State#dungeon.proc_type, [RoleId]) of
                                        ok ->
                                            NewState = 
                                                case lists:member(RoleId, State#dungeon.actives) of
                                                    true -> State;
                                                    false -> State#dungeon{actives = [RoleId | State#dungeon.actives]}
                                                end,
                                            case get(?DUNGEON_PLAYER_NUM) of
                                                PlayerNum when is_integer(PlayerNum) -> put(?DUNGEON_PLAYER_NUM, PlayerNum + 1);
                                                _ -> put(?DUNGEON_PLAYER_NUM, 1)
                                            end,

                                            {ok, BinData} = pt_57:write(57006, [State#dungeon.no, 0]),
                                            lib_send:send_to_uid(RoleId, BinData),
                                            case get(?DUN_GUILD_Id) of
                                                undefined -> skip;
                                                GuildId -> 
                                                    case get(?DUN_GUILD_FLOOR) of
                                                        undefined -> ?ERROR_MSG("enter_public_dungeon can not to find guild floor ~n", []);
                                                        Floor -> catch lib_guild:update_dungeon_info(GuildId, [NewState#dungeon.pid, Floor, underway, NewState#dungeon.actives])
                                                    end
                                            end,
                                            {noreply,NewState};
                                        _ -> 
                                            {noreply, State}
                                    end
                            end
                    end
            end;
        _ -> {noreply, State}
    end
    catch 
        _:_ -> {noreply, State}
    end;



handle_info({'transfer_enter_dungeon', RoleId, Timestamp, MapNo, X, Y, PrevPos}, State) ->
    try
    ?LDS_TRACE(transfer_enter_dungeon, {RoleId, Timestamp, MapNo, X, Y, PrevPos}),
    case player:get_PS(RoleId) of
        Status when is_record(Status, player_status) ->
            case State#dungeon.proc_type =:= ?DUN_PUB  of 
                false -> {noreply, State};
                true ->
                    case lists:keyfind(MapNo, 1, State#dungeon.map_index) of
                        false -> ?ERROR_MSG("[dungeon] transfer_enter_dungeon can not find map Map=~p, MapList = ~p~n", [MapNo, State#dungeon.map_index]), {noreply, State};
                        {MapNo, SceneId} ->
                            ?LDS_TRACE("[mod_dungeon] enter_public_dungeon find map", [{MapNo, SceneId}]),
                            gen_server:cast(player:get_pid(RoleId), {'do_single_teleport', SceneId, X, Y}),
                            case set_dun_info_in_role_state(sys, State#dungeon.id, State#dungeon.no, Timestamp, State#dungeon.pid, Status, PrevPos) of
                                ok ->
                                    NewState = 
                                        case lists:member(RoleId, State#dungeon.actives) of
                                            true -> State;
                                            false -> State#dungeon{actives = [RoleId | State#dungeon.actives]}
                                        end,
                                    case get(?DUNGEON_PLAYER_NUM) of
                                        PlayerNum when is_integer(PlayerNum) -> put(?DUNGEON_PLAYER_NUM, PlayerNum + 1);
                                        _ -> put(?DUNGEON_PLAYER_NUM, 1)
                                    end,

                                    {ok, BinData} = pt_57:write(57006, [State#dungeon.no, 0]),
                                    lib_send:send_to_uid(RoleId, BinData),
                                    case get(?DUN_GUILD_Id) of
                                        undefined -> skip;
                                        GuildId -> 
                                            case get(?DUN_GUILD_FLOOR) of
                                                undefined -> ?ERROR_MSG("enter_public_dungeon can not to find guild floor ~n", []);
                                                Floor -> catch lib_guild:update_dungeon_info(GuildId, [NewState#dungeon.pid, Floor, underway, NewState#dungeon.actives])
                                            end
                                    end,
                                    {noreply,NewState};
                                _ -> 
                                    {noreply, State}
                            end
                    end
            end
    end
    catch 
        _T:_E -> ?ERROR_MSG("[dungeon] Type = ~p, error = ~p~n", [_T, _E]), {noreply, State}
    end;

%% 退出副本

handle_info('listening', State) ->
    {noreply, State};

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

terminate(_Reason, State) ->
    % 关闭计时器
    case get(?DUN_TIMER_REF) of
        undefined -> skip;
        Ref -> erlang:cancel_timer(Ref)
    end,
    % 发送关闭副本公共
    send_close_dungeon_broadcast(State),
    % 关闭副本 
    close_dungeon(State),
    gen_server:cast(?DUNGEON_MANAGE, {'dungeon_close', State#dungeon.id, State#dungeon.no}),
    ok.


%% code_change/3
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:code_change-3">gen_server:code_change/3</a>
-spec code_change(OldVsn, State :: term(), Extra :: term()) -> Result when
    Result :: {ok, NewState :: term()} | {error, Reason :: term()},
    OldVsn :: Vsn | {down, Vsn},
    Vsn :: term().

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.



%% ====================================================================
%% notify functions
%% ====================================================================
notify_event(EventType, Args, Status) ->
    case is_dungeon_register_event(EventType) of
        true ->
            case Status#player_status.dun_info of
                ?DEF_DUN_INFO -> skip;
                #dun_info{state = out} -> skip;
                #dun_info{dun_pid = Pid, builder = _BuilderId, state = in} when is_pid(Pid) ->
                    %% @redo 暂时仅支持监听对象为副本创建者, 单人副本为玩家本人，组队副本为队长
                    Id = player:id(Status),
                    case player:is_in_team(Status) of
                        true ->
                            case player:is_leader(Status) of 
                                true -> Pid ! {notify_event, [EventType, Args, Id]};
                                false -> skip
                            end;
                        false -> Pid ! {notify_event, [EventType, Args, Id]}
                    end;
                _ -> skip
            end;
        false -> notify_public_event(EventType, Args, Status)
    end.

notify_public_event(EventType, Args, Status) ->
    case is_dungeon_public_register_event(EventType) of
        true ->
            case player:is_in_dungeon(Status) of
                {true, Pid} -> Pid ! {notify_public_event, [EventType, Args]};
                false -> skip
            end;
        false -> skip
    end.

%% @return : boolean()
is_dungeon_public_register_event(EventType) ->
    lists:member(EventType, ?PUBLIC_DUNGEON_EVENT).


notify_battle_feekback(FeekBack, Status) ->
    case player:is_in_dungeon(Status) of
        false -> skip;
        {true, Pid} -> 
            Flag = case player:is_in_team(Status) of
                true -> player:is_leader(Status);
                false -> true
            end,
            case Flag of
                true ->
                    DunNo = player:get_dungeon_no(Status),
                    Dun = lib_dungeon:get_config_data(DunNo),
                    BoutList = Dun#dungeon_data.listen_bout_battle,
                    DeadList = Dun#dungeon_data.listen_dead_battle,
                    MonId = ?BIN_PRED(FeekBack#btl_feedback.mon_no =:= ?INVALID_NO, FeekBack#btl_feedback.bmon_group_no, FeekBack#btl_feedback.mon_no), 
                    case lists:member(MonId, BoutList) of
                        true -> Pid ! {'bout_feekback', FeekBack#btl_feedback.lasting_rounds};
                        false -> skip
                    end,
                    case lists:member(MonId, DeadList) of
                        true -> Pid ! {'dead_feekback', FeekBack#btl_feedback.my_side_dead_player_count};
                        false -> skip
                    end;
                false -> skip
            end
    end.

%% ====================================================================
%% Internal functions
%% ====================================================================
% @return : new #dungeon{}
exec_listeners(Dungeon, RoleId, Event) ->
    NewDun = exec_listeners_condition(Dungeon, RoleId, Event),
    case Event =:= ?AHEAD_CHECK of
        true -> exec_listeners_action_no_ahead_check(NewDun);
        false -> exec_listeners_action(NewDun)
    end.

exec_listeners_condition(Dungeon, RoleId, Event) ->
    ListenStateList = Dungeon#dungeon.listening,
    List = [exec_listener_condition(ListenState, RoleId, Event, Dungeon) || 
            ListenState <- ListenStateList, is_record(ListenState, listen_state)],
    Dungeon#dungeon{listening = List}.


%% retrun new #listen_state{}
exec_listener_condition(ListenState, RoleId, Event, Dungeon) ->
    
    F = fun(Con, R) ->
        case lib_dungeon:exec_condition(Con#condition.type, Con, Dungeon, RoleId, Event) of
            NewCon when NewCon#condition.target =:= [] -> R;
            NewCon -> [NewCon | R]
        end
    end,
    List = lists:foldl(F, [], ListenState#listen_state.condition),

    ListenState#listen_state{condition = lists:reverse(List)}.


exec_listeners_action(Dungeon) ->
    ListenStateList = Dungeon#dungeon.listening,
    F = fun(ListenState, {Dun, Count}) ->
        case ListenState#listen_state.condition =:= [] of
            true -> 
                {NewDun, PushList, PopList} = exec_listener_action(ListenState#listen_state.action, Dun, [], []),
                NewListenStateList = lists:keydelete(ListenState#listen_state.id, 2, NewDun#dungeon.listening),
                D0 = NewDun#dungeon{listening = NewListenStateList},
                D1 = push_id(PushList, D0),
                {pop_id(PopList, D1), [PushList | Count]};
            false -> {Dun, Count}
        end
    end,
    {NewDungeon, Sum} = lists:foldl(F, {Dungeon, []}, ListenStateList),
    case Sum =:= [] of
        true -> skip;
        false -> Dungeon#dungeon.pid ! 'ahead_check'
    end,
    NewDungeon.

exec_listeners_action_no_ahead_check(Dungeon) ->
    ListenStateList = Dungeon#dungeon.listening,
    F = fun(ListenState, {Dun, Count}) ->
        case ListenState#listen_state.condition =:= [] of
            true -> 
                {NewDun, PushList, PopList} = exec_listener_action(ListenState#listen_state.action, Dun, [], []),
                NewListenStateList = lists:keydelete(ListenState#listen_state.id, 2, NewDun#dungeon.listening),
                D0 = NewDun#dungeon{listening = NewListenStateList},
                D1 = push_id(PushList, D0),
                {pop_id(PopList, D1), [PushList | Count]};
            false -> {Dun, Count}
        end
    end,
    {NewDungeon, _Sum} = lists:foldl(F, {Dungeon, []}, ListenStateList),
    NewDungeon.


%% return NewDungeon
exec_listener_action([], Dungeon, PushList, PopList) -> {Dungeon, PushList, PopList};
exec_listener_action([Action | Left], Dungeon, PushList, PopList) ->
    case lib_dungeon:exec_action(Action#action.type, Action, Dungeon) of
        {_, NewDun} -> exec_listener_action(Left, NewDun, PushList, PopList);
        {_, NewDun, {push, PList}} -> exec_listener_action(Left, NewDun, (PList ++ PushList), PopList);
        {_, NewDun, {pop, PList}} -> exec_listener_action(Left, NewDun, PushList, (PList ++ PopList))
    end.


pack_listening(IdList, DataList) ->
    pack_listening(IdList, DataList, []).

pack_listening([], _, R) -> lists:reverse(R);
pack_listening([Id | Left], List, R) ->
    case lists:keyfind(Id, 2, List) of
        false -> pack_listening(Left, List, R);
        Listener ->
            Listen_state = pace_listen_state_by_listener(Listener),
            pack_listening(Left, List, [Listen_state | R])
    end.

pace_listen_state_by_listener(#listener{id = Id, condition = ConList, action = ActionList}) ->
    % Num = erlang:length(ConList),
    % Bit = set_all_bit(Num),
    #listen_state{id = Id, condition = ConList, action = ActionList}.


% %% 取二进制所有Num位都为1的数
% set_all_bit(Num) ->
%     (1 bsl Num) - 1.


% %%设置二进制数Num第Index位为1
% set_bit(Num, Index) ->
%     Num bor (1 bsl (Index - 1)).




%% @设置副本计时器
%% @return #Ref
timing(Sec) ->
    erlang:start_timer(Sec * 1000, self(), 'terminate').
    % erlang:start_timer(?CHECK_CLOSE_INTEVAL, self(), 'check_close').


%% 系统关闭副本
close_dungeon(Dungeon) when is_record(Dungeon, dungeon) ->
    %% 把玩家传送出副本
    catch cleanup_all_player(Dungeon),
    %% 清除当前地图数据
    F = fun(SceneId) ->
            case lib_scene:is_exists(SceneId) of
                true -> catch mod_scene:clear_scene(SceneId);
                false -> ?ERROR_MSG("dungeon close clean scene error MapList = ~p~n", [Dungeon#dungeon.map_index])
            end
        end,
    [F(SceneId) || {_, SceneId} <- Dungeon#dungeon.map_index, is_integer(SceneId)],
    %% 清除所有在等待清除队列中的地图数据
    case get(?WAIT_TO_RECLAIM) of
        undefined -> skip;
        WaitMapList ->
            [mod_scene:clear_scene(SceneId) || {_, SceneId} <- WaitMapList, is_integer(SceneId)]
    end,
    redo;
close_dungeon(_Arg) ->
    ?ASSERT(false),
    ?ERROR_MSG("close dungeon error args = ~p~n", [_Arg]),
    error.


%% 清理所有副本玩家出副本
%% return: new #dungeon{}
cleanup_all_player(Dungeon) ->
    Actives = Dungeon#dungeon.actives,
    quit_dungeon(Actives, Dungeon).


%% 玩家退出副本
%% return: new #dungeon{}
% quit_dungeon(RoleIdList, Dungeon) when is_list(RoleIdList) ->
%     Actives = Dungeon#dungeon.actives,
%     quit_dungeon(RoleIdList, Dungeon, Actives).

quit_dungeon([], Dungeon) -> 
    Dungeon#dungeon.pid ! 'check_dungeon',
    Dungeon;
quit_dungeon([RoleId | Left], Dungeon) when is_integer(RoleId) ->
    Actives = Dungeon#dungeon.actives,
    case lists:member(RoleId, Actives) of
        true ->
            Outer = Dungeon#dungeon.outer,
            DunNo = Dungeon#dungeon.no,
            Diff = Dungeon#dungeon.diff,
            Now = util:unixtime(),
            Ltime = case get(?DUN_ROLE_ENTER_TIME(RoleId)) of
                StayTime when is_integer(StayTime) ->
                    erlang:erase(?DUN_ROLE_ENTER_TIME(RoleId)),
                    Now - StayTime;
                _ -> 0
            end,
            ScoreLv = 
                case get(?PASS_LV) of
                    Lv when is_integer(Lv) -> Lv;
                    _ -> 0
                end,
            case player:is_online(RoleId) of
                true ->
                    Status = player:get_PS(RoleId),
                    case player:is_battling(Status) of
                        true -> mod_battle:force_end_battle(Status);
                        false -> skip
                    end,
                    TeamNum = 
                        case player:is_in_team(Status) of
                            false -> 1;
                            true -> erlang:length(mod_team:get_can_fight_member_id_list(player:get_team_id(Status)))
                        end,
                    %% 退出副本统计
                    lib_log:statis_dungeon_out(Status, Dungeon#dungeon.pass, DunNo, Diff, TeamNum, ScoreLv, Ltime),
                    case player:is_in_dungeon(Status) of
                        {true, _} ->
                            {SceneId, {X, Y}} = Status#player_status.prev_pos,
                            case lib_scene:is_exists(SceneId) of
                                true -> ply_scene:do_single_teleport(Status, SceneId, X, Y);
                                _ -> ply_scene:goto_born_place(Status)
                            end,
                            gen_server:cast(player:get_pid(Status), 'reset_dun_info'),
                            gen_server:cast(player:get_pid(Status), {'quit_dungeon', ?SUCCESS}),
                            ok;
                        false -> 
                            {SceneId, {X, Y}} = Status#player_status.prev_pos,
                            case lib_scene:is_exists(SceneId) of
                                true -> ply_scene:do_single_teleport(Status, SceneId, X, Y);
                                _ -> ply_scene:goto_born_place(Status)
                            end,
                            ?ERROR_MSG("role_id = ~p is_in_team = ~p, not in dungeon but Request quit, actives = ~p, Left = ~p~n", 
                                [RoleId, player:is_in_team(RoleId), Actives, Left])
                    end;
                false -> handle_tmp_logout_dungeon(RoleId, Dungeon, ScoreLv, Ltime)
            end,

            %% 清除角色所有副本任务数据
            lib_task:publ_clean_all_dungeon_task(RoleId),

            NewAct = lists:delete(RoleId, Actives),
            NewOut = lists:delete(RoleId, Outer),
            case get(?DUNGEON_PLAYER_NUM) of
                PlayerNum when is_integer(PlayerNum) -> put(?DUNGEON_PLAYER_NUM, ?BIN_PRED(PlayerNum > 0, PlayerNum - 1, 0));
                _ -> put(?DUNGEON_PLAYER_NUM, erlang:length(NewAct))
            end,
            quit_dungeon(Left, Dungeon#dungeon{actives = NewAct, outer = NewOut});
        false -> 
            case player:get_PS(RoleId) of
                Status when is_record(Status, player_status) ->
                    case player:is_in_dungeon(Status) of
                        {true, _} ->
                            ?ERROR_MSG("role_id = ~p is_in_team = ~p, not in dungeon but Request quit, actives = ~p, Left = ~p~n", 
                                [RoleId, player:is_in_team(RoleId), Actives, Left]),
                            {SceneId, {X, Y}} = Status#player_status.prev_pos,
                            ply_scene:do_single_teleport(Status, SceneId, X, Y),
                            gen_server:cast(player:get_pid(Status), 'reset_dun_info'),
                            gen_server:cast(player:get_pid(Status), {'quit_dungeon', ?SUCCESS}),
                            ok;
                        false -> skip
                    end;
                _ -> skip
            end,
            quit_dungeon(Left, Dungeon#dungeon{actives = lists:delete(RoleId, Actives)})
    end.
    % quit_dungeon(Left, Dungeon#dungeon{actives = NewAct, outer = NewOut}).


%% @return : false | {NewDungeon, {Map, X, Y}}
clean_role_dun_info(RoleId, Dungeon) ->
    Actives = Dungeon#dungeon.actives,
    % Outer = Dungeon#dungeon.outer,
    DunNo = Dungeon#dungeon.no,
    Diff = Dungeon#dungeon.diff,
    Now = util:unixtime(),
    Ltime = case get(?DUN_ROLE_ENTER_TIME(RoleId)) of
        StayTime when is_integer(StayTime) ->
            erlang:erase(?DUN_ROLE_ENTER_TIME(RoleId)),
            Now - StayTime;
        _ -> 0
    end,
    ScoreLv = 
        case get(?PASS_LV) of
            Lv when is_integer(Lv) -> Lv;
            _ -> 0
        end,
    case player:is_online(RoleId) of
        true ->
            case player:get_PS(RoleId) of
                Status when is_record(Status, player_status) -> 
                    ?BIN_PRED(player:is_battling(Status), mod_battle:force_end_battle(Status), skip),
                    TeamNum = 
                        case player:is_in_team(Status) of
                            false -> 1;
                            true -> erlang:length(mod_team:get_can_fight_member_id_list(player:get_team_id(Status)))
                        end,
                    lib_log:statis_dungeon_out(Status, Dungeon#dungeon.pass, DunNo, Diff, TeamNum, ScoreLv, Ltime),
                    %% 清除角色所有副本任务数据
                    lib_task:publ_clean_all_dungeon_task(RoleId),

                    NewAct = lists:delete(RoleId, Actives),
                    % NewOut = lists:delete(RoleId, Outer),
                    case get(?DUNGEON_PLAYER_NUM) of
                        PlayerNum when is_integer(PlayerNum) -> put(?DUNGEON_PLAYER_NUM, ?BIN_PRED(PlayerNum > 0, PlayerNum - 1, 0));
                        _ -> put(?DUNGEON_PLAYER_NUM, erlang:length(NewAct))
                    end,
                    % {Dungeon#dungeon{actives = lists:delete(RoleId, Actives)}, {}}
                    {SceneId, {X, Y}} = Status#player_status.prev_pos,
                    {Dungeon#dungeon{actives = lists:delete(RoleId, Actives)}, {SceneId, X, Y}};
                _ -> false
            end;
        _ -> false
    end.

            


%% 是否在副本注册的事件类型中
is_dungeon_register_event(EventType) ->
    lists:member(EventType, ?DUNGEON_REG_EVENT).


%% @doc 临时缓存退出副本处理
handle_tmp_logout_dungeon(RoleId, Dungeon, ScoreLv, Ltime) ->
    case ply_tmplogout_cache:get_tmplogout_PS(RoleId) of
        Status when is_record(Status, player_status) ->
            % Status = ply_tmplogout_cache:get_tmplogout_PS(RoleId),
            {SceneId, {X, Y}} = ply_tmplogout_cache:get_prev_pos(Status),
            NewPos = player:remake_position_rd(RoleId, SceneId, X, Y), % 把玩家移到原先保存的位置
            ply_tmplogout_cache:set_position(RoleId, NewPos),
            ply_tmplogout_cache:set_dungeon_info(Status, ?DEF_DUN_INFO),

            %% 退出副本统计
            lib_log:statis_dungeon_out(Status, Dungeon#dungeon.pass, Dungeon#dungeon.no, Dungeon#dungeon.diff, 1, ScoreLv, Ltime),

            %% 标记处理副本超时完毕，勿忘！
            mod_lginout_TSL:mark_handle_game_logic_reconn_timeout_done(?SYS_DUNGEON, RoleId);

        _ -> 
            OffData = mod_offline_data:get_offline_role_brief(RoleId),
            lib_log:statis_dungeon_out(RoleId, OffData#offline_role_brief.lv, OffData#offline_role_brief.battle_power,
                OffData#offline_role_brief.faction, Dungeon#dungeon.pass, Dungeon#dungeon.no, Dungeon#dungeon.diff, 1, ScoreLv, Ltime)
    end.


%% return new dungeon
push_id([], Dungeon) -> Dungeon;
push_id(ListenerList, Dungeon) ->
    Data = lib_dungeon:get_config_data(Dungeon#dungeon.no),
    Listening = Dungeon#dungeon.listening,
    F = fun(Id, List) ->
            set_guild_floor(Id),
            case lists:keymember(Id, 2, Listening) orelse lists:member(Id, List) of
                true -> 
                    ?DUN_DEBUG(io_lib:format(<<"push exists id = ~p~n">>, [Id]), Dungeon#dungeon.builder),
                    List;
                false -> 
                    [Id | List]
            end
        end,
    NewList = lists:foldl(F, [], ListenerList),
    NewListenState = pack_listening(lists:reverse(NewList), Data#dungeon_data.listener),
    Dungeon#dungeon{listening = Listening ++ NewListenState}.


%% return new dungeon
pop_id([], Dungeon) -> Dungeon;
pop_id(ListenerList, Dungeon) ->
    NewListening = lib_dungeon:listen_state_list_del(ListenerList, Dungeon#dungeon.listening),
    Dungeon#dungeon{listening = NewListening}.
    


set_dun_info_in_role(_, _, _, _, _, _, []) -> ok;
set_dun_info_in_role(BuilderId, DunId, DunNo, Stamp, DunPid, ProcType, [RoleId | Left]) when is_integer(RoleId) ->
    case player:get_PS(RoleId) of
        Status when is_record(Status, player_status) ->
            DunData = lib_dungeon:get_config_data(DunNo),
            case recheck_dungeon_limit(Status, DunData, Stamp) of
                true -> 
                    ?LDS_TRACE(recheck_dungeon_limit, true),
                    Position = case player:get_position(RoleId) of
                        null -> {S, X, Y} = ply_scene:get_born_place(Status), {S, {X, Y}};
                        Pos -> {Pos#plyr_pos.scene_id, {Pos#plyr_pos.x, Pos#plyr_pos.y}}
                    end,
                    set_dun_info_in_role_state(BuilderId, DunId, DunNo, Stamp, DunPid, Status, Position);
                false -> 
                    ?LDS_TRACE(recheck_dungeon_limit, false),
                    case player:is_in_team(Status) of
                        true -> mod_team_mgr:sys_kick_out_member(player:get_team_id(Status), Status);
                        false -> skip
                    end,
                    lib_dungeon:close_dungeon(DunPid)
            end;
        _ -> skip
    end,
    set_dun_info_in_role(BuilderId, DunId, DunNo, Stamp, DunPid, ProcType, Left).


set_dun_info_in_role_state(BuilderId, DunId, DunNo, Stamp, DunPid, Status, Position) ->
    RoleId = player:id(Status),
    gen_server:cast(player:get_pid(Status), {'reset_dun_info', lib_dungeon:make_dun_info(DunNo, DunId, DunPid, BuilderId, in), Position}),
    DunData = lib_dungeon:get_config_data(DunNo),
    case lib_dungeon:get_role_dungeon(RoleId, DunNo) of
        null -> lib_dungeon:insert_new_role_dungeon(RoleId, DunNo, Stamp);
        _ -> skip
    end, 
    notify_activity_degree(DunData#dungeon_data.type, Status),
    %% 清楚角色所有副本任务数据
    lib_task:publ_clean_all_dungeon_task(RoleId),
    %% 通知玩家进入爬塔
    case DunData#dungeon_data.type =:= ?DUNGEON_TYPE_TOWER of
        true -> lib_event:event(?PASS_TOWER, [?TOWER_DUNGEON_NO, 1], Status);
        false -> skip
    end,

    %% 通知玩家进入噩梦爬塔
    case DunData#dungeon_data.type =:= ?DUNGEON_TYPE_HARD_TOWER of
        true -> lib_event:event(?PASS_TOWER, [DunNo, 1], Status);
        false -> skip
    end,
   
    mod_achievement:notify_achi(join_dun, [{no, DunNo}], Status),
    %% 进入副本统计
    TeamNum = 
        case player:is_in_team(Status) of
            false -> 1;
            true -> mod_team:get_member_count(player:get_team_id(Status))
        end,
    lib_log:statis_dungeon_in(Status, DunNo, DunData#dungeon_data.diff, TeamNum),
    put(?DUN_ROLE_ENTER_TIME(RoleId), Stamp),
    ok.


%% @return : boolean()
% recheck_dungeon_limit(Status, Dun, TimeStamp) when is_record(Dun, dungeon_data) ->
%     case lib_dungeon:role_dungeon_limit(Status, Dun) of
%         true ->
%             case lib_dungeon:role_dungeon_cd(player:id(Status), Dun, TimeStamp) of
%                 {_, true} -> true;
%                 {_, _ErrCode} -> false
%             end;
%         {false, _ErrCode} -> false
%     end;
recheck_dungeon_limit(_, _, _) -> true.


notify_activity_degree(DunType, Status) ->
    case DunType of
        ?DUNGEON_TYPE_TOWER -> lib_activity_degree:publ_add_sys_activity_times(?AD_DUN_TOWER, Status);
        % ?DUNGEON_TYPE_EQUIP -> lib_activity_degree:publ_add_sys_activity_times(?AD_DUN_EQUIP, Status);
        % ?DUNGEON_TYPE_PET   -> lib_activity_degree:publ_add_sys_activity_times(?AD_DUN_PET,   Status);
        _ -> skip
    end.

notify_activity_degree_pass(DunType, RoleId) ->
    case player:get_PS(RoleId) of
        Status when is_record(Status, player_status) ->
            case DunType of
                % ?DUNGEON_TYPE_TOWER -> lib_activity_degree:publ_add_sys_activity_times(?AD_DUN_TOWER, Status);
                ?DUNGEON_TYPE_EQUIP -> lib_activity_degree:publ_add_sys_activity_times(?AD_DUN_EQUIP, Status);
                ?DUNGEON_TYPE_PET   -> lib_activity_degree:publ_add_sys_activity_times(?AD_DUN_PET,   Status);
                _ -> skip
            end;
        _ -> skip
    end.


set_guild_floor(ListenerId) ->
    case (ListenerId rem 10) =:= 0 of
        true -> put(?DUN_GUILD_FLOOR, ?ID_TO_FLOOR(ListenerId));
        false -> skip
    end.


%% @doc 初始化BOSS副本处理
init_boss_dungeon_info(DungeonData) ->
    put(?BOSS_DAMAGE_RANK, []),
    erlang:send_after(?BROADCAST_DUNGEON_PLAYER_NUM, self(), 'broadcast_dungeon_player_num'),
    erlang:send_after(DungeonData#dungeon_data.timing * 1000, self(), 'clear_dungeon_boss').


%% @doc 世界BOSS伤害排行榜维护
sort_boss_damage([]) -> skip;
sort_boss_damage(DamageList) when is_list(DamageList) ->
    case get(?BOSS_DAMAGE_RANK) of
        [] -> put(?BOSS_DAMAGE_RANK, lists:reverse(lists:sort(DamageList)));
        List when is_list(List) ->
            F = fun({Damage, RoleId}, Acc) ->
                case lists:keymember(RoleId, 2, Acc) of
                    true -> lists:keyreplace(RoleId, 2, Acc, {Damage, RoleId});
                    false -> [{Damage, RoleId} | Acc]
                end
            end,
            AccList = lists:foldl(F, List, DamageList),
            SortList = lists:reverse(lists:sort(AccList)),
            put(?BOSS_DAMAGE_RANK, SortList);
        _ -> put(?BOSS_DAMAGE_RANK, lists:reverse(lists:sort(DamageList)))
    end.

%% @doc 广播伤害排行榜
broadcast_boss_damage_rank(Num, BroadList) when Num > 0 ->
	case get(?DUNGEON_BOSS_HP) of
		{_BossNo, MaxHp, _CurHp} -> 
			List = 
				case get(?BOSS_DAMAGE_RANK) of
					L when is_list(L) -> L;
					_ -> []
				end,
			Data = [{RoleId, (mod_offline_data:get_offline_role_brief(RoleId))#offline_role_brief.name, Damage} || 
					{Damage, RoleId} <- broadcast_boss_damage_rank_1(List, Num)],
			
			case length(BroadList) =/= 1 of
				true ->  %将前十名广播给所有在场景的玩家
					{ok, BinData} = pt_57:write(57103, [MaxHp, Data]),
					lists:foreach(fun(RoleId) -> lib_send:send_to_uid(RoleId, BinData) end, BroadList);
				false ->  %广播给玩家个人
					   [RoleId2] = BroadList,
						
						case List =/=[]  of 
							true ->
								Pred = fun({_,PlayerId}) ->
											   RoleId2 =:= PlayerId
									   end,
								SelfDamage = 
									case lists:filter(Pred, List) of
										[] ->
											0;
										[{SelfDamage0, _}|_] ->
											SelfDamage0
									end,
								
								SelfData = [{RoleId2, (mod_offline_data:get_offline_role_brief(RoleId2))#offline_role_brief.name, SelfDamage}],
								
								Data2 = Data ++ SelfData,
								{ok, BinData} = pt_57:write(57103, [MaxHp, Data2]),
								lists:foreach(fun(RoleId) -> lib_send:send_to_uid(RoleId, BinData) end, BroadList);
							
							false -> 
								{ok, BinData} = pt_57:write(57103, [MaxHp, Data]),
								lists:foreach(fun(RoleId) -> lib_send:send_to_uid(RoleId, BinData) end, BroadList)
						
						end
			end;
		
		
		
		
		_T -> 
			{ok, BinData} = pt_57:write(57103, [0, []]),
			lists:foreach(fun(RoleId) -> lib_send:send_to_uid(RoleId, BinData) end, BroadList)
	end;
broadcast_boss_damage_rank(_, _) -> skip.

broadcast_boss_damage_rank_1([], _Num) -> [];
broadcast_boss_damage_rank_1(_, Num) when Num =< 0 -> [];
broadcast_boss_damage_rank_1([{Damage, RoleId} | Left], Num) ->
    [{Damage, RoleId} | broadcast_boss_damage_rank_1(Left, Num - 1)].


%% 广播BOSS血量
broadcast_boss_hp(0, BossNo, State, LeftTeamList) ->
    State#dungeon.pid ! 'broadcast_boss_hp',
    State#dungeon.pid ! {notify_public_event, [?DUNGEON_BOSS_KILLED, [BossNo]]},
    F = fun(RoleId) ->
        case player:get_PS(RoleId) of
            Status when is_record(Status, player_status) ->
                case player:is_battling(Status) of
                    true -> mod_battle:force_end_battle(Status);
                    false -> skip
                end;
            _ -> skip
        end
    end,
    lists:foreach(F, [Uid || Uid <- State#dungeon.actives, player:is_online(Uid)]),

    NameList = lists:foldl(
        fun(RoleId, Acc) -> 
            case mod_offline_data:get_offline_role_brief(RoleId) of
                Brief when is_record(Brief, offline_role_brief) -> Acc ++ tool:to_list(Brief#offline_role_brief.name) ++ " 、";
                _ -> Acc
            end
        end, "", LeftTeamList),
	case BossNo of 
		13200 ->mod_broadcast:send_sys_broadcast(78, [NameList]);
		13201 -> mod_broadcast:send_sys_broadcast(376, [NameList])
	end,
    
    State#dungeon.pid ! {'after_dungeon_boss_killed', LeftTeamList};
broadcast_boss_hp(_, _, State, _) ->
    State#dungeon.pid ! 'broadcast_boss_hp'.


%% 统计排行帮发放奖励
statis_boss_damage_rank(RankList, BossHp,Type) ->
    send_rank_reward(RankList,Type),
   % send_damage_reward(RankList, BossHp),

   % send_random_reward(RankList),  %神秘奖暂时不需要
    ok.

%% 随机给一个玩家发幸运奖
send_random_reward([]) ->
    skip;
    
send_random_reward(RankList) ->
    {{_Damage, RoleId},Right} = tool:list_random(RankList),

    Title = <<"[系统]幸运奖励">>,
    Content = <<"你在挑战世界BOSS[逆天魔龙]获得幸运奖。请提取附件奖励">>,

    Name = case mod_offline_data:get_offline_role_brief(RoleId) of
        Brief when is_record(Brief, offline_role_brief) -> tool:to_list(Brief#offline_role_brief.name);
        _ -> tool:to_list("神秘人")
    end,

    mod_broadcast:send_sys_broadcast(166, [Name]),
    lib_mail:send_sys_mail(RoleId, tool:to_binary(Title), tool:to_binary(Content),data_dungeon_boss:get_boss_rank_reward(1) , [?LOG_MAIL, "recv_worldboss"]).



send_rank_reward(RankList,Type) -> 
    ConfigDataList = pack_list_with_tuple(data_dungeon_boss:get_boss_ranks(), data_dungeon_boss:get_boss_ranks_right()),
    send_rank_reward(RankList, ConfigDataList, 1, 1,Type).

pack_list_with_tuple(LeftList, RightList) ->
    pack_list_with_tuple(LeftList, RightList, []).

pack_list_with_tuple([], _, List) -> lists:reverse(List);
pack_list_with_tuple(_, [], List) -> lists:reverse(List);
pack_list_with_tuple([Elm1 | Left], [Elm2 | Right], List) -> 
    pack_list_with_tuple(Left, Right, [{Elm1, Elm2} | List]).


send_rank_reward(_, [], _, _,_) -> skip;
send_rank_reward([], _, _, _,_) -> skip;
send_rank_reward([{_Damage, RoleId}], [{LeftRank, RightRank} | Left], Rank, Add,Type) ->
    case Rank >= LeftRank andalso Rank =< RightRank of
        true -> 
            send_rank_reward_mail(RoleId, Rank, LeftRank,Type);
        false ->
            send_rank_reward([{_Damage, RoleId}], Left, Rank, Add,Type)
    end;

send_rank_reward([{Damage, RoleId}, {NextDamage, NextRoleId} | LeftDamageList], ConfigList, Rank, Add,Type) ->
    case get_fit_config_rank(Rank, ConfigList) of
        [{LeftRank, _RightRank} | _LeftConfigList] = NewConfigList -> 
            send_rank_reward_mail(RoleId, Rank, LeftRank,Type),
            case Damage =:= NextDamage of
                true -> 
                    send_rank_reward([{NextDamage, NextRoleId} | LeftDamageList], NewConfigList, Rank, Add + 1,Type);
                false -> 
                    send_rank_reward([{NextDamage, NextRoleId} | LeftDamageList], NewConfigList, Rank + Add, 1,Type)
            end;
        [] -> skip
    end.

get_fit_config_rank(_Rank, []) -> [];
get_fit_config_rank(Rank, [{Left, Right} | List]) ->
    case Rank >= Left andalso Rank =< Right of
        true -> [{Left, Right} | List];
        false -> get_fit_config_rank(Rank, List)
    end.


send_rank_reward_mail(RoleId, Rank, LeftRank,Type) ->
	%获得过X次世界BOSS的排名小于等于N通知成就系统
	mod_achievement:notify_achi(world_boss, [{rank, Rank},{num, 1}], player:get_PS(RoleId)), 
	Title = io_lib:format(<<"[系统]伤害第~p名奖励">>, [Rank]),
	case Type of
		1 ->
			Content = io_lib:format(<<"你在挑战世界BOSS[逆天魔龙]的活动中，对[逆天魔龙]造成了大量的伤害，居于排行榜第~p名。请提取附件奖励">>, [Rank]),
			Attach = data_dungeon_boss:get_boss_rank_reward(LeftRank),
			lib_mail:send_sys_mail(RoleId, tool:to_binary(Title), tool:to_binary(Content), Attach, [?LOG_MAIL, "recv_worldboss"]);
		2 ->Content = io_lib:format(<<"你在挑战世界BOSS[异界统领]的活动中，对[异界统领]造成了大量的伤害，居于排行榜第~p名。请提取附件奖励">>, [Rank]),
			Attach = data_dungeon_boss:get_boss_rank_reward(LeftRank + 14),
			lib_mail:send_sys_mail(RoleId, tool:to_binary(Title), tool:to_binary(Content), Attach, [?LOG_MAIL, "recv_worldboss"])
	end.


send_damage_reward(RankList, BossHp) ->
    send_damage_reward(RankList, lists:sort(data_dungeon_boss:get_boss_damage_rates()), BossHp).


send_damage_reward([], _, _) -> skip;
send_damage_reward([{Damage, RoleId} | Left], DamageList, MaxHp) ->
    Rate = erlang:trunc((Damage / MaxHp) * 1000),
    Attach = data_dungeon_boss:get_boss_damage_rate_reward(get_damage_list_gap(Rate, DamageList)),
    Content = io_lib:format(<<"你在挑战世界BOSS[逆天魔龙]的活动中，对[逆天魔龙]造成了大量的伤害，造成了~p%的伤害。请提取附件奖励">>, [(Rate / 10)]),
    lib_mail:send_sys_mail(RoleId, <<"[系统]伤害排行奖励">>, tool:to_binary(Content), Attach, [?LOG_MAIL, "recv_worldboss"]),
    send_damage_reward(Left, DamageList, MaxHp).


get_damage_list_gap(_Rate, []) -> ?ASSERT(false);
get_damage_list_gap(_, [Elem]) -> Elem;
get_damage_list_gap(Rate, [Elem1, Elem2 | Left]) ->
    case Rate >= Elem1 andalso Rate < Elem2 of
        true -> Elem1;
        false -> get_damage_list_gap(Rate, [Elem2 | Left])
    end.


%% 统计并发放最终击杀奖励
statis_final_kill_boss([],Type) -> skip;
statis_final_kill_boss([RoleId | Left],Type) ->
	case Type of
		1 ->
			lib_mail:send_sys_mail(RoleId, <<"[系统]最后击杀奖励">>, 
								   <<"你在挑战世界BOSS逆天魔龙的活动中，成功击退世界BOSS[逆天魔龙]！请提取附件奖励">>, 
								   data_dungeon_boss:get_boss_damage_kill_reward(1), [?LOG_MAIL, "recv_worldboss"]),
			statis_final_kill_boss(Left,Type);
		2 ->
			lib_mail:send_sys_mail(RoleId, <<"[系统]最后击杀奖励">>, 
								   <<"你在挑战世界BOSS异界领军的活动中，成功击退世界BOSS[异界领军]！请提取附件奖励">>, 
								   data_dungeon_boss:get_boss_damage_kill_reward(2), [?LOG_MAIL, "recv_worldboss"]),
			statis_final_kill_boss(Left,Type)
	end.


%% 挑战世界BOSS
challage_dungeon_boss(BossNo, BossId, TeamList, Status) ->
    case player:is_in_dungeon(Status) of
        {true, Pid} -> 
            case player:get_dungeon_type(Status) of
                ?DUNGEON_TYPE_BOSS ->
                    case player:is_in_team(Status) of
                        false -> Pid ! {'challage_boss', TeamList, BossNo, BossId, player:id(Status)};
                        true -> 
                            case player:is_leader(Status) of
                                true -> Pid ! {'challage_boss', TeamList, BossNo, BossId, player:id(Status)};
                                false -> skip
                            end
                    end;
                _ -> skip
            end;
        _ -> skip
    end.

%% 世界BOSS战斗反馈
feekback_boss_dungeon(_Status, null) -> skip;
feekback_boss_dungeon(Status, FeekBack) when is_record(FeekBack, wb_mf_info) ->
    case player:is_in_dungeon(Status) of
        {true, Pid} -> 
            case player:get_dungeon_type(Status) of
                ?DUNGEON_TYPE_BOSS ->
                    case player:is_in_team(Status) of
                        false -> Pid ! {'boss_battle_feekback', FeekBack#wb_mf_info.boss_no, FeekBack#wb_mf_info.init_hp, 
                                            FeekBack#wb_mf_info.left_hp, FeekBack#wb_mf_info.init_player_id_list, 
                                            FeekBack#wb_mf_info.left_player_id_list, FeekBack#wb_mf_info.hired_player_id_list};
                        true -> 
                            case player:is_leader(Status) of
                                true -> Pid ! {'boss_battle_feekback', FeekBack#wb_mf_info.boss_no, FeekBack#wb_mf_info.init_hp, 
                                            FeekBack#wb_mf_info.left_hp, FeekBack#wb_mf_info.init_player_id_list, 
                                            FeekBack#wb_mf_info.left_player_id_list, FeekBack#wb_mf_info.hired_player_id_list};
                                false -> skip
                            end
                    end;
                _ -> skip
            end;
        _ -> skip
    end;
feekback_boss_dungeon(_, _) -> skip.

 %% 世界BOSS战斗逃跑反馈   
feekback_boss_dungeon_escape(Status) ->
	case player:is_in_dungeon(Status) of
		{true, Pid} -> 
			case player:get_dungeon_type(Status) of
				?DUNGEON_TYPE_BOSS ->
					case player:is_in_team(Status) of
						false -> Pid ! {'boss_battle_escape', player:id(Status)}, %前端用于计时
                                  {ok, Bin} = pt_20:write(20110, e),			  
			                      lib_send:send_to_sock(Status, Bin);
						true -> 
							case player:is_leader(Status) of
								true -> Pid ! {'boss_battle_escape', player:id(Status)};%前端用于计时
								false -> skip
							end
					end;
				_ -> skip
			end;
		_ -> skip
	end.


%% 请求副本人数
fetch_dungeon_player_num(Status) ->
    case player:is_in_dungeon(Status) of
        {true, Pid} -> Pid ! {'broadcast_dungeon_player_num', player:id(Status)};
        _ -> skip
    end.

%% 请求排行榜
fetch_dungoen_boss_damage_rank(Status) ->
    case player:is_in_dungeon(Status) of
        {true, Pid} -> Pid ! {'broadcast_boss_damage_rank', player:id(Status)};
        _ -> skip
    end.

%% 请求boss血量
fetch_dungeon_boss_hp(Status) ->
    case player:is_in_dungeon(Status) of
        {true, Pid} -> Pid ! {'broadcast_boss_hp', player:id(Status)};
        _ -> skip
    end.


%% 设置副本排行榜
set_dungeon_boss_rank(RankList, LeftTeamList) ->
    ?LDS_DEBUG("[dungeon] set_dungeon_boss_rank", [RankList, LeftTeamList]),
    mod_rank:reset_board(?RANK_ROLE_WORLD_BOSS),
    mod_rank:reset_board(?RANK_ROLE_WORLD_BOSS_KILL),
    lists:foreach(fun({Damage, RoleId}) -> mod_rank:world_boss(RoleId, Damage) end, RankList),
    lists:foreach(fun(RoleId) -> mod_rank:world_boss_kill(RoleId, 1) end, LeftTeamList),
    mod_rank:release(?RANK_ROLE_WORLD_BOSS),
    mod_rank:release(?RANK_ROLE_WORLD_BOSS_KILL).

%% mod_dungeon:set_dungeon_boss_rank([{1531250,1000100000000002},{1531250,1000100000000001}], [1000100000000002,1000100000000001]).
%% mod_rank:world_boss(1000100000000002, 1531250).

%% 发送关闭副本公告
send_close_dungeon_broadcast(Dungeon) ->
    case Dungeon#dungeon.type =:= ?DUNGEON_TYPE_BOSS of
        true -> 
            gen_server:cast(mod_activity, {'sys_close', ?AD_DUNGEON_BOSS}),
			case Dungeon#dungeon.no of
				110001-> mod_broadcast:send_sys_broadcast(79, []);
				110002 ->mod_broadcast:send_sys_broadcast(377, [])
			end;
            
        false -> skip
    end.