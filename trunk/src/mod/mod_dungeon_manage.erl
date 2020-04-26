%%%-----------------------------------
%%% @Module  : mod_dungeon
%%% @Author  : lds
%%% @Email   : 
%%% @Created : 2013.10
%%% @Description: 副本管理进程
%%%-----------------------------------
-module(mod_dungeon_manage).

-behaviour(gen_server).

-include("common.hrl").
-include("record.hrl").
-include("dungeon.hrl").
-include("player.hrl").
-include("proc_name.hrl").
-include("prompt_msg_code.hrl").
-include("activity_degree_sys.hrl").
-include("guild_dungeon.hrl").
-include("ets_name.hrl").

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([start_link/0, reclaim/2,
    enter_public_dungeon/2,
    create_guild_prepare_dungeon/2,
    create_guild_battle_dungeon/2
    ]).

-record(state, {
     id = 1
    ,dungeon_list = []
    }).

%% ====================================================================
%% API functions
%% ====================================================================

start_link() ->
    gen_server:start_link({local, ?DUNGEON_MANAGE}, ?MODULE, [], []).


% %% @spec create_dungeon -> true | {false, ErrCode}
% create_dungeon(DunNo, Status) ->
%     ?LDS_TRACE(create_dungeon, [DunNo]),
%     TimeStamp = util:unixtime(),
%     ?LDS_TRACE(create_dungeon, [TimeStamp]),
%     case lib_dungeon:can_create_dungeon(DunNo, TimeStamp, Status) of
%         {true, ResultSet} ->
%             gen_server:cast(?DUNGEON_MANAGE, {'create_dungeon', DunNo, TimeStamp, player:id(Status), ResultSet}),
%             {true, ?SUCCESS};
%         {false, Resaon} ->
%             {false, Resaon}
%     end.

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
%% ====================================================================
init([]) ->
    ?LDS_DEBUG("mod_dungeon_manage init"),
    process_flag('trap_exit', true),
    start_reclaim(),
    {ok, #state{}, 1000}.


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

handle_call({'get_dungeon_pid', Id}, _, State) ->
    Pid = case get(Id) of
        P when is_pid(P) -> P;
        _ -> 0
    end,
    {reply, Pid, State};

handle_call(_Request, _From, State) ->
    {reply, ok, State}.


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

handle_cast({'create_dungeon', DunNo, Stamp, RoleId, IdList}, State) ->
    {Id, State1} = allot_id(State),
    Activers = [Activer || Activer <- IdList, is_integer(Activer)],
    case mod_dungeon:start_link('create_dungeon', [DunNo, Id, RoleId, Stamp, Activers]) of
        {ok, Pid} ->
            List = State1#state.dungeon_list,
            NewState = State1#state{dungeon_list = [{Id, Pid, Stamp} | List]},
            put(Id, Pid),
            {noreply, NewState};
        Error ->
            % ?ASSERT(false, Error),
            ?ERROR_MSG("module = ~p, fun = ~p, error = ~p~n", 
                [?MODULE, "'create_dungeon'", Error]),
            {noreply, State}
    end;

handle_cast({'create_tower_dungeon', DunNo, Stamp, RoleId, ListenerId}, State) ->
    {Id, State1} = allot_id(State),
    Activers = [RoleId],
    case mod_dungeon:start_link('create_tower_dungeon', [DunNo, Id, RoleId, Stamp, Activers, ListenerId]) of
        {ok, Pid} ->
            List = State1#state.dungeon_list,
            NewState = State1#state{dungeon_list = [{Id, Pid, Stamp} | List]},
            put(Id, Pid),
            {noreply, NewState};
        Error ->
            % ?ASSERT(false, Error),
            ?ERROR_MSG("module = ~p, fun = ~p, error = ~p~n", 
                [?MODULE, "'create_tower_dungeon'", Error]),
            {noreply, State}
    end;

handle_cast({'create_guild_dungeon', DunNo, Stamp, StartFloor, MaxFloor, GuildId}, State) ->
    {Id, State1} = allot_id(State),
    case mod_dungeon:start_link('create_guild_dungeon', [DunNo, Id, Stamp, StartFloor, MaxFloor, GuildId]) of
        {ok, Pid} ->
            List = State1#state.dungeon_list,
            NewState = State1#state{dungeon_list = [{Id, Pid, Stamp} | List]},
            put(Id, Pid),
            put(?PUBLIC_DUN(DunNo), Pid),
            {noreply, NewState};
        Error ->
            ?ERROR_MSG("module = ~p, fun = ~p, error = ~p~n", 
                [?MODULE, "'create_guild_dungeon'", Error]),
            {noreply, State}
    end;

handle_cast({'create_boss_dungeon', DunNo, Stamp}, State) ->
    {Id, State1} = allot_id(State),
    case mod_dungeon:start_link('create_boss_dungeon', [DunNo, Id, Stamp]) of
        {ok, Pid} ->
            List = State1#state.dungeon_list,
            NewState = State1#state{dungeon_list = [{Id, Pid, Stamp} | List]},
            put(Id, Pid),
            put(?PUBLIC_DUN(DunNo), Pid),
            gen_server:cast(mod_activity, {'sys_open', ?AD_DUNGEON_BOSS}),
            {noreply, NewState};
        Error ->
            ?ERROR_MSG("module = ~p, fun = ~p, error = ~p~n", 
                [?MODULE, "'create_boss_dungeon'", Error]),
            {noreply, State}
    end;


handle_cast({'create_guild_prepare_dungeon', DunNo, GuildId, Stamp}, State) ->
    try 
        {Id, State1} = allot_id(State),
        case mod_dungeon:start_link('create_guild_prepare_dungeon', [DunNo, Id, GuildId, Stamp]) of
            {ok, Pid} ->
                List = State1#state.dungeon_list,
                NewState = State1#state{dungeon_list = [{Id, Pid, Stamp} | List]},
                put(Id, Pid),
                put(?PUBLIC_DUN(DunNo), Pid),
                {noreply, NewState};
            Error ->
                ?ERROR_MSG("module = ~p, fun = ~p, error = ~p~n", 
                    [?MODULE, "'create_guild_prepare_dungeon'", Error]),
                {noreply, State}
        end
    catch
        _:_ -> {noreply, State}
    end;

handle_cast({'create_guild_battle_dungeon', DunNo, GuildId, Stamp}, State) ->
    try 
        {Id, State1} = allot_id(State),
        case mod_dungeon:start_link('create_guild_battle_dungeon', [DunNo, Id, GuildId, Stamp]) of
            {ok, Pid} ->
                List = State1#state.dungeon_list,
                NewState = State1#state{dungeon_list = [{Id, Pid, Stamp} | List]},
                put(Id, Pid),
                put(?PUBLIC_DUN(DunNo), Pid),
                {noreply, NewState};
            Error ->
                ?ERROR_MSG("module = ~p, fun = ~p, error = ~p~n", 
                    [?MODULE, "'create_guild_battle_dungeon'", Error]),
                {noreply, State}
        end
    catch
        _:_ -> {noreply, State}
    end;


handle_cast({'dungeon_close', DunId, DunNo}, State) ->
    List = State#state.dungeon_list,
    NewList = lists:keydelete(DunId, 1, List),
    erase(DunId),
    erase(?PUBLIC_DUN(DunNo)),
    {noreply, State#state{dungeon_list = NewList}};


handle_cast('info', State) ->
    ?LDS_TRACE(dungeon_manage_info, [State]),
    _Dict = get(),
    ?LDS_TRACE(dungeon_manage_dict, [_Dict]),
    {noreply, State};

handle_cast({'enter_public_dungeon', DunNo, RoleId}, State) -> 
    try 
        case get(?PUBLIC_DUN(DunNo)) of
            Pid when is_pid(Pid) -> 
                case is_process_alive(Pid) of
                    true ->
                        ?LDS_TRACE(enter_public_dungeon, [Pid]),
                        DunData = lib_dungeon:get_config_data(DunNo),
                        case player:get_PS(RoleId) of
                            Status when is_record(Status, player_status) ->
                                case player:get_lv(Status) >= DunData#dungeon_data.lv of
                                    true ->
                                        case lib_dungeon:get_random_pos(DunData#dungeon_data.init_pos) of
                                            {MapNo, X, Y} -> 
                                                if  DunData#dungeon_data.type =:= ?DUNGEON_TYPE_GUILD orelse 
                                                        DunData#dungeon_data.type =:= ?DUNGEON_TYPE_GUILD_PREPARE orelse
                                                        DunData#dungeon_data.type =:= ?DUNGEON_TYPE_GUILD_BATTLE ->
                                                        Pid ! {'enter_public_dungeon', RoleId, util:unixtime(), MapNo, X, Y};
                                                    DunData#dungeon_data.type =:= ?DUNGEON_TYPE_BOSS ->
                                                        List = case player:is_in_team(Status) of
                                                            true -> 
                                                                case player:is_leader(Status) of
                                                                    true -> mod_team:get_normal_member_id_list(player:get_team_id(Status));
                                                                    false -> [RoleId]
                                                                end;
                                                            false -> [RoleId]
                                                        end,
                                                        [Pid ! {'enter_public_dungeon', EnterId, util:unixtime(), MapNo, X, Y} || EnterId <- List];
                                                    true -> lib_send:send_prompt_msg(RoleId, ?PM_DATA_CONFIG_ERROR)
                                                end;
                                            _ -> lib_send:send_prompt_msg(RoleId, ?PM_DATA_CONFIG_ERROR)
                                        end;
                                    false -> lib_send:send_prompt_msg(RoleId, ?PM_LV_LIMIT)
                                end;
                            _ -> lib_send:send_prompt_msg(RoleId, ?PM_UNKNOWN_ERR)
                        end;
                    _ -> lib_send:send_prompt_msg(RoleId, ?PM_DUNGEON_NOT_EXISTS)
                end;
            _T -> lib_send:send_prompt_msg(RoleId, ?PM_DUNGEON_NOT_EXISTS)
        end,
        {noreply, State}
    catch 
        _:_ -> {noreply, State}
	end;


handle_cast({'enter_guild_dungeon', DunNo, RoleId}, State) -> 
	DunCfg  = data_dungeon:get(DunNo),
	Point = DunCfg#dungeon_data.pass_group,
	try 	
		DunData = lib_dungeon:get_config_data(DunNo),
		case player:get_PS(RoleId) of
			Status when is_record(Status, player_status) ->
				case player:get_lv(Status) >= DunData#dungeon_data.lv of
					true ->
						case lib_guild_dungeon:enter_dungeon(Status, Point) of
							ok ->  {ok, BinData} = pt_57:write(57006, [DunNo, 0]),
								   lib_send:send_to_uid(RoleId, BinData);
							_ -> skip
						end;
					false -> lib_send:send_prompt_msg(RoleId, ?PM_LV_LIMIT)
				end;
			_ -> lib_send:send_prompt_msg(RoleId, ?PM_UNKNOWN_ERR)
		end,	
		{noreply, State}
	catch 
		_:_ -> {noreply, State}
	end;

handle_cast({'publ_close_dungeon', DunNo}, State) ->
    case get(?PUBLIC_DUN(DunNo)) of
        Pid when is_pid(Pid) -> Pid ! 'close_dungeon';
        _ -> skip
    end,
    {noreply, State};

handle_cast(_Msg, State) ->
    ?LDS_TRACE("unknow cast msg", [_Msg]),
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

handle_info(timeout, State) ->
    {noreply, State};

handle_info({timeout, _TimerRef, 'reclaim'}, State) ->
    try 
        reclaim(State#state.dungeon_list),
        start_reclaim(),
        {noreply, State}
    catch 
        _:_ -> {noreply, State}
    end;

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

terminate(_Reason, _State) ->
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
%% Internal functions
%% ====================================================================

%% @return {Id, NewState}
allot_id(State) ->
    Id = State#state.id,
    {Id, State#state{id = Id + 1}}.


start_reclaim() ->
    erlang:start_timer(?RECLAIM_INTERVAL, self(), 'reclaim').

reclaim(List) ->
    NowStamp = util:unixtime(),
    util:actin_new_proc(?MODULE, reclaim, [List, NowStamp]).

reclaim([], _) -> ok;
reclaim([{_, Pid, Stamp} | Left], NowStamp) ->
    case Stamp + ?RECLAIM_INTERVAL =< NowStamp of
        true ->  %% reclaim dungeon res
            Pid ! 'close_dungeon';
        false ->
            skip
    end,
    reclaim(Left, NowStamp).


%% @进入公共副本
enter_public_dungeon(RoleId, DunNo) ->
    gen_server:cast(?DUNGEON_MANAGE, {'enter_public_dungeon', DunNo, RoleId}).


create_guild_prepare_dungeon(DunNo, GuildId) -> 
    gen_server:cast(?DUNGEON_MANAGE, {'create_guild_prepare_dungeon', DunNo, GuildId, util:unixtime()}).


create_guild_battle_dungeon(DunNo, GuildId) -> 
    gen_server:cast(?DUNGEON_MANAGE, {'create_guild_battle_dungeon', DunNo, GuildId, util:unixtime()}).