%%%-------------------------------------------------------------------
%%% @author lizhipeng
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 11. 十二月 2018 18:12
%%%-------------------------------------------------------------------
-module(mod_pvp).
-behaviour(gen_server).

%% API
-export([start_link/0]).

%% gen_server callbacks
-export([init/1,
    handle_call/3,
    handle_cast/2,
    handle_info/2,
    terminate/2,
    code_change/3]).
-compile(export_all).

-export([agree_promote_canptain/2, disagree_promote_canptain/2]).

-include("pvp.hrl").
-include("ets_name.hrl").
-include("protocol/pt_43.hrl").
-include("record.hrl").
-include("prompt_msg_code.hrl").
-include("debug.hrl").
-include("common.hrl").
-include("abbreviate.hrl").
-include("activity_degree_sys.hrl").

-define(SERVER, ?MODULE).

-record(state, {is_local_transfer = 0}).

%%%===================================================================
%%% API
%%%===================================================================

%%--------------------------------------------------------------------
%% @doc
%% Starts the server
%%
%% @end
%%--------------------------------------------------------------------
-spec(start_link() ->
    {ok, Pid :: pid()} | ignore | {error, Reason :: term()}).
start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

%%%===================================================================
%%% gen_server callbacks
%%%===================================================================

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Initializes the server
%%
%% @spec init(Args) -> {ok, State} |
%%                     {ok, State, Timeout} |
%%                     ignore |
%%                     {stop, Reason}
%% @end
%%--------------------------------------------------------------------
-spec(init(Args :: term()) ->
    {ok, State :: #state{}} | {ok, State :: #state{}, timeout() | hibernate} |
    {stop, Reason :: term()} | ignore).
init([]) ->
    process_flag(trap_exit, true),
    lib_pvp:server_start_init(),  % 开服初始化数据，未测试先注释掉
    start_timer(),
	start_filter_timer() ,
    {ok, #state{is_local_transfer = 0}}.


%%--------------------------------------------------------------------
%% @private
%% @doc
%% Handling call messages
%%
%% @end
%%--------------------------------------------------------------------
-spec(handle_call(Request :: term(), From :: {pid(), Tag :: term()},
        State :: #state{}) ->
    {reply, Reply :: term(), NewState :: #state{}} |
    {reply, Reply :: term(), NewState :: #state{}, timeout() | hibernate} |
    {noreply, NewState :: #state{}} |
    {noreply, NewState :: #state{}, timeout() | hibernate} |
    {stop, Reason :: term(), Reply :: term(), NewState :: #state{}} |
    {stop, Reason :: term(), NewState :: #state{}}).
handle_call(_Request, _From, State) ->
    {reply, ok, State}.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Handling cast messages
%%
%% @end
%%--------------------------------------------------------------------
-spec(handle_cast(Request :: term(), State :: #state{}) ->
    {noreply, NewState :: #state{}} |
    {noreply, NewState :: #state{}, timeout() | hibernate} |
    {stop, Reason :: term(), NewState :: #state{}}).

handle_cast(Request, State) ->
    try
        do_handle_cast(Request, State)
    catch
        Error:Reason ->
            ?ERROR_MSG("{Error, Reason, erlang:get_stacktrace()} : ~p~n", [{Error, Reason, erlang:get_stacktrace()}]),
            {noreply, State}
    end.

do_handle_cast({refresh_pvp_rank_data, RankList, Flag}, State) ->
    lib_pvp:do_add_pvp_3v3_cross_server_rank_to_ets(RankList, Flag),
    {noreply, State};

do_handle_cast(_Request, State) ->
    {noreply, State}.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Handling all non call/cast messages
%%
%% @spec handle_info(Info, State) -> {noreply, State} |
%%                                   {noreply, State, Timeout} |
%%                                   {stop, Reason, State}
%% @end
%%--------------------------------------------------------------------
-spec(handle_info(Info :: timeout() | term(), State :: #state{}) ->
    {noreply, NewState :: #state{}} |
    {noreply, NewState :: #state{}, timeout() | hibernate} |
    {stop, Reason :: term(), NewState :: #state{}}).
handle_info(Request, State)->
    try
        do_info(Request, State)
    catch
        _Err:_Reason ->
            ?ERROR_MSG("handle_info *** [~p:~p] ~p ***~n", [_Err, _Reason, erlang:get_stacktrace()]),
            {noreply, State}
    end.

do_info({timeout, _TimerRef, timer}, State) ->
    ?DEBUG_MSG("------------------- do_info --------------------~n", []),
    start_timer(),

    %% 检测活动开启排行榜更新，活动不开启则置daytimes=0（每日参与次数）
    case check_is_local_transfer(State) of
        {?true, State2} ->
            ?DEBUG_MSG("------------------- is_local_transfer = 1 --------------------~n", []),
            PvpRankData = case lib_pvp:get_ets_pvp_rank_data_from_ets(pvp_cross_rank_data) of      % 998服取排行榜数据，如果没有，则从数据库读取并且排列，保证PvpRankData是排行榜
                              null ->
                                  lib_pvp:set_pvp_3v3_cross_server_rank(),
                                  lib_pvp:get_ets_pvp_rank_data_from_ets(pvp_cross_rank_data);
                              R -> R
                          end,

            IsDirty = PvpRankData#pvp_rank_data.dirty,
            case IsDirty =:= 1 of
                true ->
                    ?DEBUG_MSG("IsDirty =:= 1~p~n", [{?MODULE, ?LINE}]),
                    lib_pvp:set_pvp_3v3_cross_server_rank(),
                    ServerIds = [],     % 998服排行榜数据更新，全服广播
                    lib_pvp:send_pvp_3v3_cross_rank(ServerIds);
%%                  lib_pvp:send_pvp_3v3_cross_rank([]).
%%                  ets:tab2list(ets_pvp_rank_data).
                false -> skip
            end,
            {noreply, State2};

        ?false ->
            ?DEBUG_MSG("------------------- is_local_transfer = 0 --------------------~n", []),
            {noreply, State}
    end;


do_info({timeout, _TimerRef, filter_timer}, State) ->
	start_filter_timer(),
	
    case check_is_local_transfer(State) of
        {?true, State2} ->
            cross_3v3_match:filter_pool() ,
			cross_3v3_match:check_over_time_match(),
            {noreply, State2};
        ?false ->
            {noreply, State}
    end;

do_info(_Request, State) ->
    {noreply, State}.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% This function is called by a gen_server when it is about to
%% terminate. It should be the opposite of Module:init/1 and do any
%% necessary cleaning up. When it returns, the gen_server terminates
%% with Reason. The return value is ignored.
%%
%% @spec terminate(Reason, State) -> void()
%% @end
%%--------------------------------------------------------------------
-spec(terminate(Reason :: (normal | shutdown | {shutdown, term()} | term()),
        State :: #state{}) -> term()).
terminate(_Reason, _State) ->
    ok.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Convert process state when code is changed
%%
%% @spec code_change(OldVsn, State, Extra) -> {ok, NewState}
%% @end
%%--------------------------------------------------------------------
-spec(code_change(OldVsn :: term() | {down, term()}, State :: #state{},
        Extra :: term()) ->
    {ok, NewState :: #state{}} | {error, Reason :: term()}).
code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================

start_timer() ->
%%    Time = ?RANK_DATA_REFRESH_TIMER * 60 * 1000,
    Time = ?RANK_DATA_REFRESH_TIMER * 60 * 1000,
    erlang:start_timer(Time, self(), timer).


start_filter_timer() ->
	erlang:start_timer(3000, self(), filter_timer).



check_is_local_transfer(#state{is_local_transfer = IsLocalTransfer} = State) ->
    case IsLocalTransfer of
        1 ->
            {?true, State};
        _ ->
            case sm_cross_client_sup:get_child_pids() of
                [] ->
                    ?false;
                _ ->
                    {?true, State#state{is_local_transfer = 1}}
            end
    end.

agree_promote_canptain(PlayerId, CaptainId) ->
    TServerId = (lib_pvp:get_pvp_cross_player_info(PlayerId))#pvp_cross_player_data.server_id,
    case check_agree_promote_captain(PlayerId, CaptainId) of
        {fail, Reason} ->
            sm_cross_server:rpc_cast(TServerId, lib_send, send_prompt_msg, [PlayerId, Reason]);
        {ok, Room} ->
            NewRoom = do_agree_promote_captain(PlayerId, Room),
            ?ASSERT(NewRoom#room.captain =:= PlayerId),
            {ok, BinData} = pt_43:write(?PT_PVP_NOTIFY_CAPTAIN_CHANGED, [PlayerId]),
            lib_pvp:send_message_to_all_players_in_room(NewRoom, BinData),
            F = fun(Teammate, Acc) ->
                    PvpPlyIvnfo = lib_pvp:get_pvp_cross_player_info(Teammate),
                    TeammateId = PvpPlyIvnfo#pvp_cross_player_data.player_id,
                    Status = PvpPlyIvnfo#pvp_cross_player_data.status,
                    [{TeammateId, Status} | Acc]
                end,
            List = lists:foldl(F, [], NewRoom#room.teammates),
            {ok, BinData2} = pt_43:write(?PT_PVP_CROSS_PLAYER_PREPARE, [List]),
            lib_pvp:send_message_to_all_players_in_room(NewRoom, BinData2)
    end.


check_agree_promote_captain(PlayerId, CaptainId) ->
    try check_agree_promote_captain__(PlayerId, CaptainId) of
        {ok, Room} -> {ok, Room}
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

check_agree_promote_captain__(PlayerId, CaptainId) ->
    Room = lib_pvp:get_room_by_captain_id(CaptainId),
    ?Ifc (Room =:= null)
        throw(?PM_PVP_3V3_ROOM_NOT_EXIT)
    ?End,
    ?Ifc (not (lib_pvp:is_in_pvp_3v3_room(CaptainId, PlayerId)))
        throw(?PM_NOT_IN_ROOM)
    ?End,
    {ok, Room}.

do_agree_promote_captain(PlayerId, Room) ->
    ets:delete(?ETS_PVP_3V3_ROOM, Room#room.captain),
%%    Teammates1 = Room#room.teammates -- [PlayerId],
%%    Teammates2 = Teammates1 ++ [Room#room.captain],
    Teammates = [Room#room.captain | lists:delete(PlayerId, Room#room.teammates)],
    NewRoom = #room{captain = PlayerId, teammates = Teammates, counters = Room#room.counters, grade = Room#room.grade},
    F = fun(PlayerId) ->
            PvpPlyInfo = lib_pvp:get_pvp_cross_player_info(PlayerId),
            NewPvpPlyInfo = PvpPlyInfo#pvp_cross_player_data{status = 1},
            lib_pvp:update_pvp_cross_player_data_to_ets(NewPvpPlyInfo)
        end,
    lists:foreach(F, NewRoom#room.teammates ++ [NewRoom#room.captain]),
    lib_pvp:update_room_to_ets(NewRoom),
    NewRoom.

% 队员拒绝队长的提升请求
disagree_promote_canptain(PlayerId, CaptainId) ->
    CPvpPlyInfo = lib_pvp:get_pvp_cross_player_info(CaptainId),
    ?ASSERT(CaptainId =:= CPvpPlyInfo#pvp_cross_player_data.player_id),
    case lib_pvp:get_room_by_captain_id(CaptainId) of
        null ->
            sm_cross_server:rpc_cast(CPvpPlyInfo#pvp_cross_player_data.server_id, lib_send, send_prompt_msg, [CaptainId, ?PM_PVP_3V3_ROOM_NOT_EXIT]);
        _Team ->
            {ok, BinData} = pt_43:write(?PT_PVP_NOTIFY_CAPTAIN_RESULT, [1, CPvpPlyInfo#pvp_cross_player_data.player_name]),
            sm_cross_server:rpc_cast(CPvpPlyInfo#pvp_cross_player_data.server_id, lib_send, send_to_uid, [CaptainId, BinData])
    end.

apply_join_in_room(PvpPlyInfo, CaptainId) ->
    PlayerId = PvpPlyInfo#pvp_cross_player_data.player_id,
    lib_pvp:init_cross_pvp_player_info(PvpPlyInfo),         % 世界喊话进入,对玩家数据进行初始化到跨服
    case check_apply_join_in_room(PlayerId, CaptainId) of
        {fail, Reason} ->
            {fail, Reason};
        ok ->
            do_apply_join_in_room(PlayerId, CaptainId)
    end.


% 检测房间是否可以加入
check_apply_join_in_room(PlayerId, CaptainId) ->

    PvpCapInfo = lib_pvp:get_pvp_cross_player_info(CaptainId),
    PvpPlyInfo = lib_pvp:get_pvp_cross_player_info(PlayerId),
    case lib_pvp:get_room_by_captain_id(CaptainId) of
        null ->
            {fail, ?PM_PVP_3V3_ROOM_NOT_EXIT};
        _ ->
            case PvpPlyInfo =:= null orelse PvpCapInfo =:= null of
                true ->
                    {fail, ?PM_PLAYER_NOT_IN_3V3_PVP};
                false ->
                    case lib_pvp:is_team_full(CaptainId) of
                        true ->
                            {fail, ?PM_PVP_3V3_ROOM_IS_FULL};
                        false ->
                            Room = lib_pvp:get_room_by_captain_id(CaptainId),
                            case lists:member(PlayerId, Room#room.apply_list) of
                                true ->
                                    {fail, ?PM_PVP_ALREADY_APPLY_TO_JOIN_ROOM};
                                false ->
                                    case lib_pvp:judge_two_players_dan(CaptainId, PlayerId) of
                                        true ->
                                            ok;
                                        false ->
                                            {fail, ?PM_PVP_3V3_ROOM_TEAM_NOT_SATISFY}
                                    end
                            end
                    end

            end
    end.


do_apply_join_in_room(PlayerId, CaptainId) ->

    Room = lib_pvp:get_room_by_captain_id(CaptainId),
    ApplyList = Room#room.apply_list ++ [PlayerId],
    NewRoom = Room#room{apply_list = ApplyList},
    lib_pvp:update_room_to_ets(NewRoom),
    ApplyInfoList = lib_pvp:get_apply_list_player_info_list(CaptainId),

    ServerId = (lib_pvp:get_pvp_cross_player_info(CaptainId))#pvp_cross_player_data.server_id,

    F = fun(PvpPlyInfo, Acc) ->
            [{PvpPlyInfo#pvp_cross_player_data.player_id, PvpPlyInfo#pvp_cross_player_data.player_name,
                PvpPlyInfo#pvp_cross_player_data.dan, PvpPlyInfo#pvp_cross_player_data.server_id} | Acc]
        end,
    List = lists:foldl(F, [], ApplyInfoList),
    sm_cross_server:rpc_cast(ServerId, lib_pvp, send_room_apply_info, [CaptainId, List]),
    true.

allow_join_in_room(CaptainId, JoinPlayerId) ->
    ServerId = (lib_pvp:get_pvp_cross_player_info(CaptainId))#pvp_cross_player_data.server_id,
    case check_add_teammate(CaptainId, JoinPlayerId) of
        {fail, Reason} ->
            sm_cross_server:rpc_cast(ServerId, lib_send, send_prompt_msg, [CaptainId, Reason]);
        ok ->
            do_allow_join_in_room(CaptainId, JoinPlayerId)
    end.

do_allow_join_in_room(CaptainId, JoinPlayerId) ->
    PvpPlyInfo = lib_pvp:get_pvp_cross_player_info(JoinPlayerId),
    PlyScore = PvpPlyInfo#pvp_cross_player_data.score,
    Room = lib_pvp:get_room_by_captain_id(CaptainId),
    ApplyList = Room#room.apply_list,
    NewRoom = Room#room{grade = Room#room.grade + PlyScore, counters = Room#room.counters + 1,
        teammates = [JoinPlayerId | Room#room.teammates], apply_list = ApplyList -- [JoinPlayerId]},
    lib_pvp:update_room_to_ets(NewRoom),
    NewPvpPlyInfo = PvpPlyInfo#pvp_cross_player_data{status = 1},
    lib_pvp:update_pvp_cross_player_data_to_ets(NewPvpPlyInfo),
    ?ASSERT(CaptainId =:= NewRoom#room.captain),
    ApplyInfoList = lib_pvp:get_apply_list_player_info_list(CaptainId),
    F = fun(PvpPlyInfo, Acc) ->
            [{PvpPlyInfo#pvp_cross_player_data.player_id, PvpPlyInfo#pvp_cross_player_data.player_name,
                PvpPlyInfo#pvp_cross_player_data.dan, PvpPlyInfo#pvp_cross_player_data.server_id} | Acc]
        end,
    List = lists:foldl(F, [], ApplyInfoList),
    {ok, BinData} = pt_43:write(?PT_PVP_QRY_APPLY_LIST, [List]),
    ServerId = (lib_pvp:get_pvp_cross_player_info(CaptainId))#pvp_cross_player_data.server_id,
    lib_pvp:send_message_to_client(ServerId, CaptainId, BinData),                       % 给队长重新发送申请列表
    lib_pvp:send_room_players_info_to_teammate(Room).   %% 广播给房间所有成员


accept_invite_in_room(CaptainId, PvpPlyInfo_T) ->
    lib_pvp:init_cross_pvp_player_info(PvpPlyInfo_T),
    ObjPlayerId = PvpPlyInfo_T#pvp_cross_player_data.player_id,
    PvpPlyInfo = lib_pvp:get_pvp_cross_player_info(ObjPlayerId),
    PlyScore = PvpPlyInfo#pvp_cross_player_data.score,
    Room = lib_pvp:get_room_by_captain_id(CaptainId),
    NewRoom = Room#room{grade = Room#room.grade + PlyScore, counters = Room#room.counters + 1,
        teammates = [ObjPlayerId | Room#room.teammates], invited_list = Room#room.invited_list -- [ObjPlayerId]},
    lib_pvp:update_room_to_ets(NewRoom),
    NewPvpPlyInfo = PvpPlyInfo#pvp_cross_player_data{status = 1},
    lib_pvp:update_pvp_cross_player_data_to_ets(NewPvpPlyInfo),
    ?ASSERT(CaptainId =:= NewRoom#room.captain),
    {ok, BinData} = pt_43:write(?PT_PVP_CROSS_ACCEPT_INVITE, [?RES_OK]),
    CPvpPlyInfo = lib_pvp:get_pvp_cross_player_info(ObjPlayerId),
    lib_pvp:send_message_to_client(CPvpPlyInfo#pvp_cross_player_data.server_id, CaptainId, BinData),

    lib_pvp:send_room_players_info_to_teammate(NewRoom).   %% 广播给房间所有成员

refuse_invite_in_room(CaptainId, ObjPlayerId) ->
    Room = lib_pvp:get_room_by_captain_id(CaptainId),
    ?ASSERT(Room =/= null),
    NewInvitedL = Room#room.invited_list -- [ObjPlayerId],
    NewRoom = Room#room{invited_list = NewInvitedL},
    lib_pvp:update_room_to_ets(NewRoom),
    CPvpPlyInfo = lib_pvp:get_pvp_cross_player_info(ObjPlayerId),
    {ok, BinData} = pt_43:write(?PT_PVP_CROSS_REFUSE_INVITE, [CPvpPlyInfo#pvp_cross_player_data.player_name, ?RES_FAIL]),
    lib_pvp:send_message_to_client(CPvpPlyInfo#pvp_cross_player_data.server_id, CaptainId, BinData).

reject_join_in_room(CaptainId, ObjPlayerId) ->
    CPvpPlyInfo = lib_pvp:get_pvp_cross_player_info(CaptainId),
    ?ASSERT(CPvpPlyInfo =/= null),
    case lib_pvp:is_captain(CaptainId) of
        true ->
            PvpPlyInfo = lib_pvp:get_pvp_cross_player_info(ObjPlayerId),
            {ok, BinData} = pt_43:write(?PT_REJECT_JOIN_IN_ROOM, [CPvpPlyInfo#pvp_cross_player_data.player_name]),
            ?ASSERT(PvpPlyInfo =/= null),
            lib_pvp:send_message_to_client(PvpPlyInfo#pvp_cross_player_data.server_id, ObjPlayerId, BinData),
            Room = lib_pvp:get_room_by_captain_id(CaptainId),
            ApplyList = Room#room.apply_list,
            NewRoom = Room#room{apply_list = ApplyList -- [ObjPlayerId]},
            lib_pvp:update_room_to_ets(NewRoom),
            ApplyInfoList = lib_pvp:get_apply_list_player_info_list(CaptainId),
            F = fun(PvpPlyInfo, Acc) ->
                [{PvpPlyInfo#pvp_cross_player_data.player_id, PvpPlyInfo#pvp_cross_player_data.player_name,
                    PvpPlyInfo#pvp_cross_player_data.dan, PvpPlyInfo#pvp_cross_player_data.server_id} | Acc]
                end,
            List = lists:foldl(F, [], ApplyInfoList),
            {ok, BinData2} = pt_43:write(?PT_PVP_QRY_APPLY_LIST, [List]),
            ServerId = CPvpPlyInfo#pvp_cross_player_data.server_id,
            lib_pvp:send_message_to_client(ServerId, CaptainId, BinData2);                       % 给队长重新发送申请列表
        false ->
            sm_cross_server:rpc_cast(CPvpPlyInfo#pvp_cross_player_data.server_id, lib_send, send_prompt_msg, [CaptainId, ?PM_NOT_IS_CAPTAIN])
    end.

check_add_teammate(CaptainId, JoinPlayerId) ->
    try check_add_teammate__(CaptainId, JoinPlayerId) of
        ok -> ok
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.


check_add_teammate__(CaptainId, JoinPlayerId) ->
    ServerId = (lib_pvp:get_pvp_cross_player_info(JoinPlayerId))#pvp_cross_player_data.server_id,


    ?Ifc (lib_pvp:is_in_room(JoinPlayerId))
        throw(?PM_PVP_3V3_PLAYER_IS_IN_ROOM)
    ?End,

%%    ?Ifc (sm_cross_server:rpc_call(ServerId, player, get_pid, [JoinPlayerId]) =:= null)
%%        throw(?PM_PLAYER_OFFLINE_OR_NOT_EXISTS)
%%    ?End,

    ?Ifc (not lib_pvp:is_captain(CaptainId))
        throw(?PM_NOT_IS_CAPTAIN)
    ?End,

    Room = lib_pvp:get_room_by_captain_id(CaptainId),

    ?Ifc (not (lists:member(JoinPlayerId, Room#room.apply_list)))
        throw(?PM_PARA_ERROR)
    ?End,

    ?Ifc (lib_pvp:is_team_full(CaptainId))
        throw(?PM_PVP_3V3_ROOM_IS_FULL)
    ?End,

    ok.



% 创建房间，插入进去ets表
create_room_by_player(PlayerId) ->
    PvpPlyInfo = lib_pvp:get_pvp_cross_player_info(PlayerId),
    case lib_pvp:is_in_room(PlayerId) of
        false ->
            Now = util:unixtime(),
            Score = lib_pvp:query_pvp_3v3_player_score(PlayerId),
            ?DEBUG_MSG("---------------- Score ---------------~p~n", [Score]),
            Room = #room{captain = PlayerId, timestamp2 = Now, grade = Score},
            lib_pvp:add_room_to_ets(Room),
            NewPvpPlyInfo = PvpPlyInfo#pvp_cross_player_data{status = 1},
            lib_pvp:update_pvp_cross_player_data_to_ets(NewPvpPlyInfo),
            PlayerId = NewPvpPlyInfo#pvp_cross_player_data.player_id,
            PlayerName = NewPvpPlyInfo#pvp_cross_player_data.player_name,
            Faction = NewPvpPlyInfo#pvp_cross_player_data.faction,
            Sex = NewPvpPlyInfo#pvp_cross_player_data.sex,
            Lv = NewPvpPlyInfo#pvp_cross_player_data.lv,
            Race = NewPvpPlyInfo#pvp_cross_player_data.race,
            ShowEquips = NewPvpPlyInfo#pvp_cross_player_data.showing_equips,
            Dan = NewPvpPlyInfo#pvp_cross_player_data.dan,
            InfoList = [{PlayerId, PlayerName, Faction, Sex, Lv, Race, ShowEquips, Dan}],
            {ok, BinData} = pt_43:write(?PT_PVP_CREATE_ROOM, [Room, InfoList]),
            sm_cross_server:rpc_cast(NewPvpPlyInfo#pvp_cross_player_data.server_id, lib_send, send_to_uid,
                [PlayerId, BinData]);
        true ->
            sm_cross_server:rpc_cast(PvpPlyInfo#pvp_cross_player_data.server_id, lib_send, send_prompt_msg,
                [PlayerId, ?PM_PVP_CREATE_ROOM_FAIL])

    end.

%% 房主踢人
kick_out_teamate_from_pvp_room(CaptainId, PlayerId) ->
    ServerId = (lib_pvp:get_pvp_cross_player_info(CaptainId))#pvp_cross_player_data.server_id,
    case check_kick_out_teamate_from_pvp_room(CaptainId, PlayerId) of
        {fail, Reason} ->
            sm_cross_server:rpc_cast(ServerId, lib_send, send_to_uid, [CaptainId, Reason]);
        ok ->
            Room = lib_pvp:get_room_by_captain_id(CaptainId),
            do_kick_out_teamate_from_pvp_room(CaptainId, PlayerId),
            {ok, BinData} = pt_43:write(?PT_PVP_KICK_OUT_TM , [PlayerId]),
            lib_pvp:send_message_to_all_players_in_room(Room, BinData)
    end.


check_kick_out_teamate_from_pvp_room(CaptainId, PlayerId)  ->
    case lib_pvp:get_room_by_captain_id(CaptainId) of
        null ->
            {fail, ?PM_NOT_IS_CAPTAIN};
        Room ->
            case Room#room.state =:= 0 of
                true ->
                    case lib_pvp:is_in_pvp_3v3_room(CaptainId, PlayerId) of
                        fasle ->
                            {fail,?PM_NOT_IN_ROOM};
                        true ->
                            ok
                    end;
                false ->
                    {fail, ?PM_PVP_ERROR_OPERATE}
            end
    end.

do_kick_out_teamate_from_pvp_room(CaptainId, PlayerId) ->
    Room = lib_pvp:get_room_by_captain_id(CaptainId),
    PvpPlyInfo = lib_pvp:get_pvp_cross_player_info(PlayerId),
    PlyScore = PvpPlyInfo#pvp_cross_player_data.score,
    NewTeamates = Room#room.teammates -- [PlayerId],
    NewRoom = Room#room{teammates = NewTeamates, grade = Room#room.grade - PlyScore, counters = Room#room.counters - 1},
    lib_pvp:update_room_to_ets(NewRoom),
    NewPvpPlyInfo = PvpPlyInfo#pvp_cross_player_data{status = 0},
    lib_pvp:update_pvp_cross_player_data_to_ets(NewPvpPlyInfo).     % 成员状态置为status=0（可加入房间）

%% 主动离开房间
leave_room(PlayerId) ->
    ServerId = (lib_pvp:get_pvp_cross_player_info(PlayerId))#pvp_cross_player_data.server_id,
    case check_leave_room(PlayerId) of
        {fail, Reason} ->
            ?DEBUG_MSG("--------------- fail --------------~n" ,[]),
            sm_cross_server:rpc_cast(ServerId, lib_send, send_prompt_msg, [PlayerId, Reason]);
        {ok, Room} ->
            ?DEBUG_MSG("--------------- ok --------------~n" ,[]),
            case Room#room.captain =:= PlayerId of
                true ->
                    do_leave_room(PlayerId, Room, captain);
                false ->
                    do_leave_room(PlayerId, Room, teammate)
            end
    end.

do_leave_room(PlayerId, Room, captain) ->
%%    ets:delete(?ETS_PVP_3V3_ROOM, Room#room.captain),
    ?DEBUG_MSG("leezp~p~n", [{?MODULE, ?LINE}]),
    ?DEBUG_MSG("-------- captain PlayerId ----------~p~n", [PlayerId]),
    case Room#room.teammates of
        [] ->
            CPvpPlyInfo = lib_pvp:get_pvp_cross_player_info(PlayerId),
            lib_pvp:set_player_status(CPvpPlyInfo);
        TeammateList ->
            {ok, BinData} = pt_43:write(?PT_TM_NOTIFY_TEAMATE_OUT_ROOM , [PlayerId]),
            F = fun(Teammate) ->
                    PvpPlyInfo = lib_pvp:get_pvp_cross_player_info(Teammate),
                    lib_pvp:set_player_status(PvpPlyInfo),
%%                    NewPvpPlyInfo = PvpPlyInfo#pvp_cross_player_data{status = 0},
%%                    lib_pvp:update_pvp_cross_player_data_to_ets(NewPvpPlyInfo), % 房主解散，把成员状态置为status=0（可加入房间）
                    ServerId = PvpPlyInfo#pvp_cross_player_data.server_id,
                    sm_cross_server:rpc_cast(ServerId, lib_send, send_to_uid, [Teammate, BinData])
                end,
            lists:foreach(F, TeammateList ++ [Room#room.captain])
    end,
    ets:delete(?ETS_PVP_3V3_ROOM, Room#room.captain);

do_leave_room(PlayerId, Room, teammate) ->
    ?DEBUG_MSG("-------- teammate PlayerId ----------~p~n", [PlayerId]),
    PvpPlyInfo = lib_pvp:get_pvp_cross_player_info(PlayerId),
    PlyScore = PvpPlyInfo#pvp_cross_player_data.score,
    NewTeamates = Room#room.teammates -- [PlayerId],
    NewRoom = Room#room{teammates = NewTeamates, grade = Room#room.grade - PlyScore, counters = Room#room.counters - 1},
    lib_pvp:update_room_to_ets(NewRoom),
    lib_pvp:set_player_status(PvpPlyInfo),
%%    NewPvpPlyInfo = PvpPlyInfo#pvp_cross_player_data{status = 0},
%%    lib_pvp:update_pvp_cross_player_data_to_ets(NewPvpPlyInfo),
    {ok, BinData} = pt_43:write(?PT_TM_NOTIFY_TEAMATE_OUT_ROOM , [PlayerId]),
    lib_pvp:send_message_to_all_players_in_room(NewRoom, BinData).


check_leave_room(PlayerId) ->
    case lib_pvp:get_player_in_which_room(PlayerId) of
        null ->
            {fail, ?PM_NOT_IN_ROOM};
        Room ->
            {ok, Room}
    end.

% 队长请求提升队员为队长
ask_promote_teamate(CaptainId, TargetPlayerId) ->
    case check_ask_promote_teamate(CaptainId, TargetPlayerId) of
        {fail, Reason} ->
            ?ASSERT(not(Reason =:= ?PM_PVP_ROOM_NOT_EXIST_PLAYER)),
            ServerId = (lib_pvp:get_pvp_cross_player_info(CaptainId))#pvp_cross_player_data.server_id,
            sm_cross_server:rpc_cast(ServerId, lib_send, send_prompt_msg, [CaptainId, Reason]);
        ok ->
            do_ask_promote_teamate(CaptainId, TargetPlayerId)
    end.

check_ask_promote_teamate(CaptainId, TargetPlayerId) ->
    try check_ask_promote_teamate__(CaptainId, TargetPlayerId) of
        ok -> ok
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

check_ask_promote_teamate__(CaptainId, TargetPlayerId) ->

    ?Ifc (lib_pvp:get_pvp_cross_player_info(TargetPlayerId) =:= null)
        throw(?PM_PVP_ROOM_NOT_EXIST_PLAYER)
    ?End,

    ?Ifc (CaptainId =:= TargetPlayerId)
        throw(?PM_PARA_ERROR)
    ?End,

    ServerId = (lib_pvp:get_pvp_cross_player_info(TargetPlayerId))#pvp_cross_player_data.server_id,

    ?Ifc (not lib_pvp:is_online(ServerId, TargetPlayerId))
        throw(?PM_PLAYER_OFFLINE_OR_NOT_EXISTS)
    ?End,

    case lib_pvp:get_room_by_captain_id(CaptainId) of
        null ->
            throw(?PM_NOT_IS_CAPTAIN);
        _Room ->
            ok
    end.

do_ask_promote_teamate(CaptainId, TargetPlayerId) ->

    CServerId = (lib_pvp:get_pvp_cross_player_info(CaptainId))#pvp_cross_player_data.server_id,
    TServerId = (lib_pvp:get_pvp_cross_player_info(TargetPlayerId))#pvp_cross_player_data.server_id,
    {ok, BinData} = pt_43:write(?PT_PVP_PROMOTE_TEAMATE_FOR_CAPTAIN, [?RES_OK]),
    lib_pvp:send_message_to_client(CServerId, CaptainId, BinData),

    {ok, BinData2} = pt_43:write(?PT_TM_PROMOTE_YOU_FOR_CAPTAIN, [CaptainId]),
    lib_pvp:send_message_to_client(TServerId, TargetPlayerId, BinData2).

%% 使用阵法
use_zf_in_room(PS, No) ->
    case check_use_zf_in_room(PS, No) of
        {fail, Reason} ->
            {fail, Reason};
        ok ->
            sm_cross_server:rpc_cast(mod_pvp, do_use_zf_in_room, [player:get_id(PS), No])
    end.

check_use_zf_in_room(PS, No) ->
    try
        check_use_zf_in_room__(PS, No)
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

check_use_zf_in_room__(PS, No) ->
    DataCfg = data_zf:get(No),
    ?Ifc (DataCfg =:= null)
        throw(?PM_PARA_ERROR)
    ?End,

    ?Ifc (not lists:member(No, lib_team:get_learned_zf_nos(PS)))
        throw(?PM_TM_ZF_NOT_USABLE)
    ?End,

    case sm_cross_server:rpc_call(lib_pvp, is_captain, [player:get_id(PS)]) of
        {ok, false} ->
            throw(?PM_NOT_IS_CAPTAIN);
        {ok, true} ->
            ok
    end.

do_use_zf_in_room(PlayerId, No) ->
    Room = lib_pvp:get_room_by_captain_id(PlayerId),
    NewRoom = Room#room{cur_troop = No},
    lib_pvp:update_room_to_ets(NewRoom),
    {ok, BinData} = pt_43:write(?PT_PVP_CAPTAIN_USE_ZF, [No]),
    lib_pvp:send_message_to_all_players_in_room(NewRoom, BinData),
    ok.

create_room_for_single_match(PlayerId) ->
    case lib_pvp:get_room_by_captain_id(PlayerId) of
        null ->
            ?DEBUG_MSG("------------ lzp ------------~p~n", [{?MODULE, ?LINE}]),
            skip;
        Room ->
            ?DEBUG_MSG("------------ lzp ------------~p~n", [{?MODULE, ?LINE}]),
            lib_pvp:delete_room(Room)
    end,
    Now = util:unixtime(),
    case lib_pvp:query_pvp_3v3_player_score(PlayerId) of
        -1 ->
            skip;
        Score ->
            ?DEBUG_MSG("------------ lzp ------------~p~n", [{?MODULE, ?LINE}]),
            NewRoom = #room{captain = PlayerId, timestamp = Now, timestamp2 = Now, grade = Score, state = 1},
            lib_pvp:add_room_to_ets(NewRoom),
            lib_pvp:insert_pvp_room_to_pool_ets(NewRoom)
    end.

% 开始匹配  lib_cross:init_cross(1000300000047253).  ets:delete(?ETS_PVP_MATCH_ROOM, PlayerId)
start_matching(Type, PS) ->
    case Type of
        0 ->
            Hour = util:get_hour(),
            case lib_pvp:is_in_3v3_pvp_activity(Hour) of
                true ->
                    case player:is_in_team(PS) of
                        true ->
                            lib_send:send_prompt_msg(PS, ?PM_PVP_EXIT_TEAM);
                        false ->
                            {ok, BinData} = pt_43:write(?PT_PVP_MATCHING, [?RES_OK]),
                            lib_send:send_to_sock(PS, BinData),
                            lib_cross:init_cross(player:get_id(PS)),
							sm_cross_server:rpc_call(ets, delete, [?ETS_PVP_MATCH_ROOM,player:get_id(PS)]),
                            sm_cross_server:rpc_call(mod_pvp, create_room_for_single_match, [player:get_id(PS)])
                    end;
                false ->
                    lib_send:send_prompt_msg(PS, ?PM_PVP_3V3_ACTIVITY_IS_NOT_OPEN)
            end;
        1 ->% sm_cross_server:rpc_call(lib_pvp, get_room_members, [1888800000001756]).
			PlayerId = player:get_id(PS),
			lib_cross:init_cross(PlayerId),
			{ok,TeamLists} = sm_cross_server:rpc_call(lib_pvp, get_room_members, [PlayerId]),
			F = fun(X) ->
						lib_cross:init_cross(X)
				end,
			lists:foreach(F, TeamLists),
			sm_cross_server:rpc_cast(ets, delete, [?ETS_PVP_MATCH_ROOM,player:get_id(PS)]),
            sm_cross_server:rpc_cast(lib_pvp, insert_pvp_room_to_pool_ets, [player:get_id(PS)])
			
    end.



% 取消匹配
cancle_match(Type, PS) ->
    IsCanCancel = sm_cross_server:rpc_call(lib_pvp, delete_pvp_room_from_pool_ets, [player:get_id(PS)]),
    case IsCanCancel of
		skip ->
			lib_send:send_prompt_msg(player:get_id(PS), ?PM_PVP_HAVE_TAKE);
		_ ->
			case Type of
				0 ->
					sm_cross_server:rpc_call(lib_pvp, cancel_type_pool_ets, [player:get_id(PS)]),					
					sm_cross_server:rpc_call(lib_pvp, delete_pvp_match_room_ets, [player:get_id(PS)]),
					sm_cross_server:rpc_call(lib_pvp, delete_room, [player:get_id(PS)]),
					{ok, BinData} = pt_43:write(?PT_PVP_CANCLE_MATCHING, [?RES_OK]),
					lib_send:send_to_sock(PS, BinData);
				1 ->
					sm_cross_server:rpc_call(lib_pvp, cancel_type_pool_ets, [player:get_id(PS)]),
					sm_cross_server:rpc_call(lib_pvp, delete_pvp_match_room_ets, [player:get_id(PS)]),
					{ok, BinData} = pt_43:write(?PT_PVP_CANCLE_MATCHING, [?RES_OK]),
					sm_cross_server:rpc_cast(lib_pvp, send_message_to_all_players_in_room, [player:get_id(PS), BinData])
			end
	end.

invite_friends_into_room(CaptainId, ObjPlayerId) ->
    CServerId = (lib_pvp:get_pvp_cross_player_info(CaptainId))#pvp_cross_player_data.server_id,
    case check_invite_friends_into_room(CaptainId, ObjPlayerId) of
        {fail, Reason} ->
            sm_cross_server:rpc_cast(CServerId, lib_send, send_prompt_msg, [CaptainId, Reason]);
        ok ->
            do_invite_friends_into_room(CaptainId, ObjPlayerId),
            {ok, BinData} = pt_43:write(?PT_PVP_3V3_INVITE_TEAMATES, [?RES_OK, ObjPlayerId]),
            lib_pvp:send_message_to_client(CServerId, CaptainId, BinData)
    end.

do_invite_friends_into_room(CaptainId, ObjPlayerId) ->
    Room = lib_pvp:get_room_by_captain_id(CaptainId),
    NewInvitedList = Room#room.invited_list ++ [ObjPlayerId],
    NewRoom = Room#room{invited_list = NewInvitedList},
    lib_pvp:update_room_to_ets(NewRoom),
    CPvpPlyInfo = lib_pvp:get_pvp_cross_player_info(CaptainId),
    PvpPlyInfo = lib_pvp:get_pvp_cross_player_info(ObjPlayerId),
    {ok, BinData} = pt_43:write(?PT_PVP_3V3_TEAMATES_GOT_INVITE, [CPvpPlyInfo#pvp_cross_player_data.player_id,
        CPvpPlyInfo#pvp_cross_player_data.player_name, CPvpPlyInfo#pvp_cross_player_data.lv]),
    lib_pvp:send_message_to_client(PvpPlyInfo#pvp_cross_player_data.server_id, ObjPlayerId, BinData).

check_invite_friends_into_room(CaptainId, ObjPlayerId) ->
    try
        check_invite_friends_into_room__(CaptainId, ObjPlayerId)
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

check_invite_friends_into_room__(CaptainId, ObjPlayerId) ->
    ?DEBUG_MSG("ObjPlayerId~p~n", [{?MODULE, ObjPlayerId}]),
    ?DEBUG_MSG("lib_pvp:is_in_room(ObjPlayerId)~p~n", [{?MODULE, lib_pvp:is_in_room(ObjPlayerId)}]),

    ?Ifc (lib_pvp:get_pvp_cross_player_info(CaptainId) =:= null)
        throw(?PM_PLAYER_NOT_IN_3V3_PVP)
    ?End,

    ?Ifc (lib_pvp:get_pvp_cross_player_info(ObjPlayerId) =:= null)
        throw(?PM_PLAYER_NOT_IN_3V3_PVP)
    ?End,

    ?Ifc (lib_pvp:is_in_room(ObjPlayerId))
        throw(?PM_PVP_3V3_PLAYER_IS_IN_ROOM)
    ?End,

%%    ObjPvpPlyInfo = lib_pvp:get_pvp_cross_player_info(ObjPlayerId),
%%    ServerId = ObjPvpPlyInfo#pvp_cross_player_data.server_id,
%%    ObjPlayerLv = ObjPvpPlyInfo#pvp_cross_player_data.lv,
%%
%%    ?Ifc (ObjPlayerLv < data_special_config:get('3V3_open_lv'))
%%        throw(?PM_PVP_3V3_LV_NOT_SATISFY)
%%    ?End,
%%    ?Ifc (sm_cross_server:rpc_call(ServerId, player, get_pid, [ObjPlayerId]) =:= {ok, null})
%%        throw(?PM_PLAYER_OFFLINE_OR_NOT_EXISTS)
%%    ?End,

    ?Ifc (not lib_pvp:is_captain(CaptainId))
        throw(?PM_NOT_IS_CAPTAIN)
    ?End,

    Room = lib_pvp:get_room_by_captain_id(CaptainId),

    ?Ifc (lists:member(ObjPlayerId, Room#room.invited_list))
        throw(?PM_PVP_ALREADY_INVITE_TO_JOIN_ROOM)
    ?End,

%%    ?Ifc (sm_cross_server:rpc_call(ServerId, player, is_in_team, [ObjPlayerId]) =:= {ok, true})
%%        throw(?PM_PLAYER_OFFLINE_OR_NOT_EXISTS)
%%    ?End,

%%    ?Ifc (sm_cross_server:rpc_call(ServerId, player, is_battling, [ObjPlayerId]) =:= {ok, true})
%%        throw(?PM_PLAYER_OFFLINE_OR_NOT_EXISTS)
%%    ?End,

    case lib_pvp:judge_two_players_dan(CaptainId, ObjPlayerId) of
        true ->
            ok;
        false ->
            throw(?PM_PVP_3V3_ROOM_TEAM_NOT_SATISFY)
    end.


disagree_invite(PS, CaptainId) ->
    case sm_cross_server:rpc_call(lib_pvp, get_room_by_captain_id, [CaptainId]) of
        null ->     % 此房间已经不存在 无需告诉队长
            ok;
        Room ->
            NewInvitedList = Room#room.invited_list -- [player:get_id(PS)],
            NewRoom = Room#room{invited_list = NewInvitedList},
            sm_cross_server:rpc_cast(lib_pvp, update_room_to_ets, [NewRoom]),
            {ok, BinData} = pt_43:write(?PT_PVP_NOTIFY_CAPTAIN_INVITE_RESULT, [0, player:get_name(PS)]),
            lib_send:send_to_uid(CaptainId, BinData),
            ok
    end.

close_pvp_cross_interface(PlayerId, Type) ->
    case lib_pvp:get_room_by_captain_id(PlayerId) of
        null ->
            ?DEBUG_MSG("close_pvp_cross_interface~p~n", [{?MODULE, ?LINE}]),
            {fail, ?PM_PVP_3V3_ROOM_NOT_EXIT};
        Room ->
            case Type of
                0 ->
                    PvpPlyInfo = lib_pvp:get_pvp_cross_player_info(PlayerId),
                    NewPvpPlyInfo = PvpPlyInfo#pvp_cross_player_data{status = 0},
                    lib_pvp:update_pvp_cross_player_data_to_ets(NewPvpPlyInfo),
                    lib_pvp:delete_room(Room);      % 单人匹配玩家需要删除房间，否则无法组队房间
                1 ->
                    ?DEBUG_MSG("close_pvp_cross_interface~p~n", [{?MODULE, ?LINE}]),
                    lib_pvp:set_room_state(Room)
            end,
            ok
    end.

player_prepare_3v3_pvp(PlayerId) ->
    PvpPlayInfo = lib_pvp:get_pvp_cross_player_info(PlayerId),
    ?ASSERT(PvpPlayInfo =/= null),
    case PvpPlayInfo#pvp_cross_player_data.status =:= 1 of
        true ->
            NewPvpPlyInfo = PvpPlayInfo#pvp_cross_player_data{status = 2},
            lib_pvp:update_pvp_cross_player_data_to_ets(NewPvpPlyInfo),
            Room = lib_pvp:get_player_in_which_room(PlayerId),
            List = [{PlayerId, ?IS_PREPARE}],
            {ok, BinData} = pt_43:write(?PT_PVP_CROSS_PLAYER_PREPARE, [List]),
            lib_pvp:send_message_to_all_players_in_room(Room, BinData);
        false ->
            sm_cross_server:rpc_cast(PvpPlayInfo#pvp_cross_player_data.server_id, lib_send, send_prompt_msg, [PlayerId, ?PM_NOT_IN_ROOM])
    end.

player_cancel_prepare_3v3_pvp(PlayerId) ->
    PvpPlayInfo = lib_pvp:get_pvp_cross_player_info(PlayerId),
    ?ASSERT(PvpPlayInfo =/= null),
    case PvpPlayInfo#pvp_cross_player_data.status =:= 2 of
        true ->
            NewPvpPlyInfo = PvpPlayInfo#pvp_cross_player_data{status = 1},
            lib_pvp:update_pvp_cross_player_data_to_ets(NewPvpPlyInfo),
            Room = lib_pvp:get_player_in_which_room(PlayerId),
            List = [{PlayerId, ?IN_ROOM}],
            {ok, BinData} = pt_43:write(?PT_PVP_CROSS_PLAYER_PREPARE, [List]),
            lib_pvp:send_message_to_all_players_in_room(Room, BinData);
        false ->
            sm_cross_server:rpc_cast(PvpPlayInfo#pvp_cross_player_data.server_id, lib_send, send_prompt_msg, [PlayerId, ?PM_PVP_3V3_PLAYER_NOT_PREPARE])
    end.

get_participate_dayreward(PlayerId, Type) ->
    PvpPlyInfo = lib_pvp:get_pvp_cross_player_info(PlayerId),
    ?ASSERT(PvpPlyInfo =/= null),
    case lists:member(Type, PvpPlyInfo#pvp_cross_player_data.dayreward) of
        true ->
            {ok, ?PM_PVP_3V3_HAS_GET_REWARD};
        false ->
            lib_pvp:set_dayreward(PlayerId, Type),
            lib_pvp:get_pvp_cross_player_info(PlayerId)
    end.

check_player_status(PlayerId) ->
    case player:is_online(PlayerId) of
        false ->
            {false, ?PM_PLAYER_OFFLINE_OR_NOT_EXISTS};
        _ ->
            case not (player:is_in_team(PlayerId)) of
                true ->
                    case not (player:is_battling(PlayerId)) of
                        true ->
                            PS = player:get_PS(PlayerId),
                            case player:is_in_dungeon(PS) of
                                {true, _Pid} ->
                                    {false, ?PM_PLAYER_IN_SPECIAL_SCENE};
                                false ->
                                    SceneId = player:get_scene_id(PS),
                                    case not (lib_scene:is_home_scene(SceneId)) of
                                        true ->
                                            true;
                                        false ->
                                            {false, ?PM_PLAYER_IN_SPECIAL_SCENE}
                                    end
                            end;
                        false ->
                            {false, ?PM_PLAYER_IN_BATTLEING}
                    end;
                false ->
                    {false, ?PM_PLAYER_IN_TEAM}
            end
    end.

%% 3v3跨服战斗结束
%% 1、每日参与次数置为0  2、发奖励   3、发称号(legend_result处理)
kuafu_3v3_close() ->
%%    活动结束后不保存ets
%%    PvpPlyList = ets:tab2list(?ETS_PVP_CROSS_PLAYER_DATA),
%%    F = fun(PvpPlyInfo) ->
%%            ets:update_element(?ETS_PVP_CROSS_PLAYER_DATA, PvpPlyInfo#pvp_cross_player_data.player_id, [{#pvp_cross_player_data.daytimes, 0}])
%%        end,
%%
	%%    lists:foreach(F, PvpPlyList).
	% 是否需要删除ETS_PVP_CROSS_PLAYER_DATA
	%%    ets:delete(?ETS_PVP_CROSS_PLAYER_DATA),
	%%    ets:delete(?ETS_PVP_3V3_ROOM),
%%	Hour = util:get_hour(),
%%	case lib_pvp:is_in_3v3_pvp_activity(Hour) of
%%		true ->
%%			skip;
%%		false ->
%%			List = ets:tab2list(?ETS_PVP_CROSS_PLAYER_DATA),
%%			F = fun(PvpPlyInfo) when is_record(PvpPlyInfo, pvp_cross_player_data)->
%%                        PlayerId = PvpPlyInfo#pvp_cross_player_data.player_id,
%%						case PvpPlyInfo#pvp_cross_player_data.daytimes < 3 of
%%							true ->
%%								Dan = PvpPlyInfo#pvp_cross_player_data.dan,
%%								Rank3v3Info = data_ranking3v3_score:get(Dan),
%%								Inactive = Rank3v3Info#ranking3v3_score.inactive_minus_points,
%%								{RealScore,RealDan} =
%%									case Inactive < 0 of
%%										true ->
%%											Inactive2 = 0 - (Inactive),
%%											Dan2 = lib_pvp:get_dan_by_score(Inactive2),
%%											{Inactive2, Dan2};
%%										false ->
%%											Inactive2 = case (PvpPlyInfo#pvp_cross_player_data.score - Inactive) < 0  of
%%															true -> 0 ;
%%															false ->PvpPlyInfo#pvp_cross_player_data.score - Inactive
%%														end,
%%											Dan2 = lib_pvp:get_dan_by_score(Inactive2),
%%											{Inactive2,Dan2}
%%									end,
%%								ets:update_element(?ETS_PVP_CROSS_PLAYER_DATA, PlayerId,
%%												   [{#pvp_cross_player_data.daytimes, 0}, {#pvp_cross_player_data.dayreward, []}, {#pvp_cross_player_data.score,RealScore }, {#pvp_cross_player_data.dan, RealDan}]);
%%							false ->
%%								ets:update_element(?ETS_PVP_CROSS_PLAYER_DATA, PlayerId,
%%												   [{#pvp_cross_player_data.daytimes, 0}, {#pvp_cross_player_data.dayreward, []}])
%%						end,
%%                        DayReward = (lib_pvp:get_pvp_cross_player_info(PlayerId))#pvp_cross_player_data.dayreward,
%%						db:update(pvp_cross_player_info, [{daytimes, 0}, {dayreward, util:term_to_bitstring(DayReward)}], [{player_id,PlayerId}])
%%				end,
%%			lists:foreach(F, List)
%%
%%	end.



    List = ets:tab2list(?ETS_PVP_CROSS_PLAYER_DATA),
    F = fun(PvpPlyInfo) when is_record(PvpPlyInfo, pvp_cross_player_data)->
        PlayerId = PvpPlyInfo#pvp_cross_player_data.player_id,
        case PvpPlyInfo#pvp_cross_player_data.daytimes < 3 of
            true ->
                Dan = PvpPlyInfo#pvp_cross_player_data.dan,
                Rank3v3Info = data_ranking3v3_score:get(Dan),
                Inactive = Rank3v3Info#ranking3v3_score.inactive_minus_points,
                {RealScore,RealDan} =
                    case Inactive < 0 of
                        true ->
                            Inactive2 = 0 - (Inactive),
                            Dan2 = lib_pvp:get_dan_by_score(Inactive2),
                            {Inactive2, Dan2};
                        false ->
                            Inactive2 = case (PvpPlyInfo#pvp_cross_player_data.score - Inactive) < 0  of
                                            true -> 0 ;
                                            false ->PvpPlyInfo#pvp_cross_player_data.score - Inactive
                                        end,
                            Dan2 = lib_pvp:get_dan_by_score(Inactive2),
                            {Inactive2,Dan2}
                    end,
                ets:update_element(?ETS_PVP_CROSS_PLAYER_DATA, PlayerId,
                    [{#pvp_cross_player_data.daytimes, 0}, {#pvp_cross_player_data.dayreward, []}, {#pvp_cross_player_data.score,RealScore }, {#pvp_cross_player_data.dan, RealDan}]);
            false ->
                ets:update_element(?ETS_PVP_CROSS_PLAYER_DATA, PlayerId,
                    [{#pvp_cross_player_data.daytimes, 0}, {#pvp_cross_player_data.dayreward, []}])
        end,
        DayReward = (lib_pvp:get_pvp_cross_player_info(PlayerId))#pvp_cross_player_data.dayreward,
        db:update(pvp_cross_player_info, [{daytimes, 0}, {dayreward, util:term_to_bitstring(DayReward)}], [{player_id,PlayerId}])
        end,
    lists:foreach(F, List).



