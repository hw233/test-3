%%%-------------------------------------------------------------------
%%% @author lizhipeng
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 11. 十二月 2018 18:14
%%%-------------------------------------------------------------------
-module(lib_pvp).

-compile(export_all).
-include("pvp.hrl").
-include("ets_name.hrl").
-include("protocol/pt_43.hrl").
-include("record.hrl").
-include("prompt_msg_code.hrl").
-include("debug.hrl").
-include("abbreviate.hrl").
-include("activity_degree_sys.hrl").
-include("obj_info_code.hrl").

server_start_init() ->
    case db:select_all(pvp_cross_player_info, "player_id", []) of
        List when is_list(List) ->
            [ load_pvp_info(RoleId) || [RoleId] <- List];
        Err ->
            ?ERROR_MSG("server_start_init Err : ~p~n", [Err])
    end.

load_pvp_info(RoleId) ->
    set_pvp_3v3_cross_server_rank(),
    case db:select_row(pvp_cross_player_info, ?CROSS_PVP_PLAYER_QRY_SQL, [{player_id, RoleId}]) of
        [] ->
            null;
        [PlayerId, ServerId, Name, Sex, Race, Faction, Win, Lose, Escape, Daytimes, Timestamp, Dan, Score, Reward, DayReward] ->
            Rank = get_player_pvp_3v3_rank(PlayerId),
%%                    {ok, [Sex, Race, Name, Level, Faction, VipLv, ShowEquips]} =
%%                        sm_cross_server:rpc_call(ServerId, lib_pvp, incoming_player_pvp_info_to_corss_server, [PlayerId]),

            PvpPlyInfo = #pvp_cross_player_data{
                player_id = PlayerId,
                player_name = Name,
                server_id = ServerId,
                faction = Faction,
                sex = Sex,
                race = Race,
                win = Win,
                lose = Lose,
                escape = Escape,
                daytimes = Daytimes,
                timestamp = Timestamp,
                dan = Dan,
                score = Score,
                rank = Rank,
                reward = util:bitstring_to_term(Reward),
                dayreward = util:bitstring_to_term(DayReward)
            },
            update_pvp_cross_player_data_to_ets(PvpPlyInfo)
    end.


init_cross_pvp_player_info(PvpPlyInfo_T) ->
    PlayerId = PvpPlyInfo_T#pvp_cross_player_data.player_id,
    case get_pvp_cross_player_info(PlayerId) of
        null ->
            create_cross_pvp_player_info(PvpPlyInfo_T);
        PvpPlyInfo ->
            % 每次都更新pvp_cross_player_data
            % 考虑到合服情况(serverId会改变),每次检查serverId,不同则更新db
            case PvpPlyInfo#pvp_cross_player_data.server_id =/= PvpPlyInfo_T#pvp_cross_player_data.server_id of
                true ->
                    db:update(pvp_cross_player_info, [{server_id, PvpPlyInfo_T#pvp_cross_player_data.server_id}], [{player_id, PlayerId}]);
                false ->
                    skip
            end,
            Rank = lib_pvp:get_player_pvp_3v3_rank(PlayerId),
            NewPvpPlyInfo = PvpPlyInfo#pvp_cross_player_data{
                server_id = PvpPlyInfo_T#pvp_cross_player_data.server_id ,
                sex = PvpPlyInfo_T#pvp_cross_player_data.sex,
                race = PvpPlyInfo_T#pvp_cross_player_data.race,
                player_name = PvpPlyInfo_T#pvp_cross_player_data.player_name,
                lv = PvpPlyInfo_T#pvp_cross_player_data.lv,
                faction = PvpPlyInfo_T#pvp_cross_player_data.faction,
                vip_lv = PvpPlyInfo_T#pvp_cross_player_data.vip_lv,
                showing_equips = PvpPlyInfo_T#pvp_cross_player_data.showing_equips,
                rank = Rank },
            update_pvp_cross_player_data_to_ets(NewPvpPlyInfo),
            NewPvpPlyInfo
    end.

create_cross_pvp_player_info(PvpPlyInfo_T) ->
    update_cross_pvp_player_info(PvpPlyInfo_T),
    PvpPlyInfo_T.

get_pvp_cross_player_info(PlayerId) ->
    case ets:lookup(?ETS_PVP_CROSS_PLAYER_DATA, PlayerId) of
        [PvpplyInfo] when is_record(PvpplyInfo, pvp_cross_player_data) -> PvpplyInfo;
        _ ->
            case db:select_row(pvp_cross_player_info, ?CROSS_PVP_PLAYER_QRY_SQL, [{player_id, PlayerId}]) of
                [] ->
                    null;
                [PlayerId, ServerId, Name, Sex, Race, Faction, Win, Lose, Escape, Daytimes, Timestamp, Dan, Score, Reward, DayReward] ->
                    Rank = get_player_pvp_3v3_rank(PlayerId),
%%                    {ok, [Sex, Race, Name, Level, Faction, VipLv, ShowEquips]} =
%%                        sm_cross_server:rpc_call(ServerId, lib_pvp, incoming_player_pvp_info_to_corss_server, [PlayerId]),

                    PvpPlyInfo = #pvp_cross_player_data{
                        player_id = PlayerId,
                        player_name = Name,
                        server_id = ServerId,
                        faction = Faction,
                        sex = Sex,
                        race = Race,
                        win = Win,
                        lose = Lose,
                        escape = Escape,
                        daytimes = Daytimes,
                        timestamp = Timestamp,
                        dan = Dan,
                        score = Score,
                        rank = Rank,
						reward = util:bitstring_to_term(Reward),
                        dayreward = util:bitstring_to_term(DayReward)
                    },
                    update_pvp_cross_player_data_to_ets(PvpPlyInfo),
                    PvpPlyInfo
            end
    end.

update_cross_pvp_player_info(PvpPlayerInfo) when is_record(PvpPlayerInfo, pvp_cross_player_data) ->
    update_pvp_cross_player_data_to_ets(PvpPlayerInfo),
    db_insert_new_pvp_cross_player_info(PvpPlayerInfo).


set_pvp_3v3_cross_server_rank() ->
    List = db:select_all(pvp_cross_player_info, "player_id, player_name, server_id, dan, score, tiemstamp ", []),
    % 根据分数先进行排列
    F = fun([_PlayerIdA,_PlayerNameA,_ServerIdA,_DanA,ScoreA,UnixTimeA],[_PlayerIdB,_PlayerNameB,_ServerIdB,_DanB,ScoreB,UnixTimeB]) ->
            case ScoreA =:= ScoreB of
                true -> UnixTimeA < UnixTimeB;
                false -> ScoreA > ScoreB
            end
        end,
    List2 = lists:sort(F, List),
    F2 = fun([PlayerId,PlayerName,ServerId,Dan,Score,_UnixTime],{Rank ,Acc}) ->
            case Score > 0 of
                true ->
                    {Rank +1 , [{PlayerId, PlayerName, ServerId, Rank, Dan, Score} | Acc] };
                false ->
                    {Rank, Acc}
            end
         end,
    {_Rank2 , List3} = lists:foldl(F2, {1,[]}, List2),
    Pvp3V3Rank = #pvp_rank_data{id = pvp_cross_rank_data, ranklist = List3, dirty = 0 },
    add_pvp_3v3_rank_to_ets(Pvp3V3Rank).

add_pvp_3v3_rank_to_ets(Pvp3V3Rank) when is_record(Pvp3V3Rank, pvp_rank_data) ->
    ets:insert(?ETS_PVP_RANK_DATA, Pvp3V3Rank).

add_pvp_3v3_cross_server_rank_to_ets(RankList, Flag) ->     % Flag=1 数据已传输完成;   Flag=0 数据未传输完成

    gen_server:cast(mod_pvp, {refresh_pvp_rank_data, RankList, Flag}).

do_add_pvp_3v3_cross_server_rank_to_ets(RankList, Flag) ->
    NewRankList_T = get_pvp_3v3_rank(pvp_cross_rank_data_tmp) ++ RankList,
    Pvp3V3Rank_T = #pvp_rank_data{id = pvp_cross_rank_data_tmp, ranklist = NewRankList_T, dirty = 0},
    add_pvp_3v3_rank_to_ets(Pvp3V3Rank_T),

    case Flag of
        0 ->
            skip;
        1 ->
            clear_pvp_rank_data(pvp_cross_rank_data),
            NewRankList = get_pvp_3v3_rank(pvp_cross_rank_data_tmp),
            F = fun({_PlayerId1, _PlayerName1, _ServerId1, Rank1, _Dan1, _Score1},{_PlayerId2, _PlayerName2, _ServerId2, Rank2, _Dan2, _Score2}) ->
                Rank1 < Rank2
                end,
            List2 = lists:sort(F, NewRankList),
            Pvp3V3Rank = #pvp_rank_data{id = pvp_cross_rank_data, ranklist = List2, dirty = 0 },
            add_pvp_3v3_rank_to_ets(Pvp3V3Rank),
            ets:delete(?ETS_PVP_RANK_DATA, pvp_cross_rank_data_tmp)
    end.

%%do_send_pvp_3v3_cross_rank(ServerId, RankList, Part, Rem) ->
%%    case is_integer(ServerId) of
%%        true ->
%%            case Part =:= 0 of
%%                true ->
%%                    MaxPart = erlang:length(RankList) div (?SPLIT_RANKLIST),
%%                    ?DEBUG_MSG("MaxPart length~p~n", [MaxPart]),
%%                    RankList1 = lists:sublist(RankList, MaxPart * (?SPLIT_RANKLIST) + 1, MaxPart * (?SPLIT_RANKLIST) + Rem),
%%                    sm_cross_server:rpc_cast(ServerId, ?MODULE, add_pvp_3v3_cross_server_rank_to_ets, [RankList1, 1]);
%%                false ->
%%                    RankList1 = lists:sublist(RankList, (Part - 1) * (?SPLIT_RANKLIST) + 1, Part * (?SPLIT_RANKLIST)),
%%                    sm_cross_server:rpc_cast(ServerId, ?MODULE, add_pvp_3v3_cross_server_rank_to_ets, [RankList1, 0]),
%%                    do_send_pvp_3v3_cross_rank(ServerId, RankList, Part - 1, Rem)
%%            end;
%%        false ->
%%            ?DEBUG_MSG("do_send_pvp_3v3_cross_rank false~p~n", [{?MODULE, ?LINE}]),
%%            ?ASSERT(ServerId =:= []),
%%            case Part =:= 0 of
%%                true ->
%%                    ?DEBUG_MSG("case Part =:= 0 of true~p~n", [{?MODULE, ?LINE}]),
%%                    MaxPart = erlang:length(RankList) div (?SPLIT_RANKLIST),
%%                    ?DEBUG_MSG("MaxPart length~p~n", [MaxPart]),
%%                    RankList1 = lists:sublist(RankList, MaxPart * (?SPLIT_RANKLIST) + 1, MaxPart * (?SPLIT_RANKLIST) + Rem),
%%                    ?DEBUG_MSG("RankList1~p~n", [{?LINE, RankList1}]),
%%                    sm_cross_server:rpc_cast([], ?MODULE, add_pvp_3v3_cross_server_rank_to_ets, [RankList1, 1]);
%%                false ->
%%                    ?DEBUG_MSG("case Part =:= 0 of false~p~n", [{?MODULE, ?LINE}]),
%%                    RankList1 = lists:sublist(RankList, (Part - 1) * (?SPLIT_RANKLIST) + 1, Part * (?SPLIT_RANKLIST)),
%%                    ?DEBUG_MSG("RankList1~p~n", [{?LINE, RankList1}]),
%%                    sm_cross_server:rpc_cast([], ?MODULE, add_pvp_3v3_cross_server_rank_to_ets, [RankList1, 0]),
%%%%                    sm_cross_server:rpc_cast([], lib_pvp, add_pvp_3v3_cross_server_rank_to_ets, []).
%%%%                    sm_cross_server:rpc_cast([], io, format, ["adsfa",[]]).
%%                    do_send_pvp_3v3_cross_rank(ServerId, RankList, Part - 1, Rem)
%%            end
%%    end.

do_send_pvp_3v3_cross_rank(ServerId, RankList) when erlang:length(RankList) > ?SPLIT_RANKLIST ->
    {RankList1, RankList2} = lists:split(?SPLIT_RANKLIST, RankList),
    sm_cross_server:rpc_cast(ServerId, ?MODULE, add_pvp_3v3_cross_server_rank_to_ets, [RankList1, 0]),
    do_send_pvp_3v3_cross_rank(ServerId, RankList2);

do_send_pvp_3v3_cross_rank(ServerId, RankList) ->
    sm_cross_server:rpc_cast(ServerId, ?MODULE, add_pvp_3v3_cross_server_rank_to_ets, [RankList, 1]).

get_pvp_3v3_rank(Id) ->
    case get_ets_pvp_rank_data_from_ets(Id) of
        null -> [];
        R ->
            case R#pvp_rank_data.ranklist of
                [] -> [];
                RankList -> RankList
            end
    end.
%%    case get_ets_pvp_rank_data_from_ets() of
%%        null -> [];
%%        R -> R#pvp_rank_data.ranklist
%%    end.

%% 998服对于其他服请求排行榜信息的处理
send_pvp_3v3_cross_rank(ServerId) ->
    RankList =
        case get_pvp_3v3_rank(pvp_cross_rank_data) of
            [] ->
                set_pvp_3v3_cross_server_rank(),
                get_pvp_3v3_rank(pvp_cross_rank_data);
            R -> R
        end,
    Len = erlang:length(RankList),
    Part = Len div (?SPLIT_RANKLIST),
    Rem = Len rem (?SPLIT_RANKLIST),
    ?DEBUG_MSG("Len:~p      Part:~p     Rem:~p~n", [Len,Part,Rem]),
    do_send_pvp_3v3_cross_rank(ServerId, RankList).
%%    do_send_pvp_3v3_cross_rank(ServerId, RankList, Part, Rem).

get_ets_pvp_rank_data_from_ets(Id) ->
    case ets:lookup(?ETS_PVP_RANK_DATA, Id) of
        [] ->
            null;
        [R] ->
            R
    end.

set_player_pvp_3v3_rank(PlayerId) ->
    Rank = get_player_pvp_3v3_rank(PlayerId),
    PvpPlyInfo = get_pvp_cross_player_info(PlayerId),
    NewPvpPlyInfo = PvpPlyInfo#pvp_cross_player_data{rank = Rank},
    update_pvp_cross_player_data_to_ets(NewPvpPlyInfo).


get_player_pvp_3v3_rank(PlayerId) ->
    TupleList = get_pvp_3v3_rank(pvp_cross_rank_data),
    case lists:keyfind(PlayerId, 1, TupleList) of
        false -> 0;
        {_PlayerId, _PlayerName, _ServerId, Rank, _Dan, _Score} -> Rank
    end.

send_pvp_cross_rank_to_client(Page, PS, RankList) ->
    Size = (Page -1) * 10 + 1,
    List2 = lists:keysort(4, RankList),
    List = case length(List2) >= Size of
               true ->lists:sublist(List2, Size, 10);
               false -> []
           end,
    {ok, BinData} = pt_43:write(?PT_PVP_CROSS_PLAYER_RANK, [List]),
    lib_send:send_to_sock(PS, BinData).

% 添加房间到匹配池(点击匹配时)
insert_pvp_room_to_pool_ets(Room) when is_record(Room, room) ->
    CaptainId = Room#room.captain,
    case is_teammates_prepare(Room) of
        true ->
            Teammates = Room#room.teammates,
            NewRoom = Room#room{state = 1},      % 房间标记为不可加入
            update_room_to_ets(NewRoom),
            {ok, BinData} = pt_43:write(?PT_PVP_MATCHING, [0]),
            send_message_to_all_players_in_room(NewRoom, BinData),
            FT = fun(X) ->
                [PlayerData] = ets:lookup(?ETS_PVP_CROSS_PLAYER_DATA, X),
                ServerId = PlayerData#pvp_cross_player_data.server_id,
                sm_cross_server:rpc_call(ServerId, lib_cross, init_cross, [X])
                 end,
            lists:foreach(FT, Teammates),
            case query_pvp_3v3_player_dan(CaptainId) of
                null -> ?DEBUG_MSG("leezp~p~n", [{?MODULE, ?LINE}]),skip;
                CaptainDan ->
                    ?DEBUG_MSG("leezp~p~n", [{?MODULE, ?LINE}]),
                    DanPool = get_dan_pool_by_dan(CaptainDan),
                    ?DEBUG_MSG("------------- DanPool --------------~p~n", [DanPool]),
                    case ets:lookup(?ETS_PVP_3V3_SUP_POOL, DanPool) of
                        [] ->
                            ?DEBUG_MSG("leezp~p~n", [{?MODULE, ?LINE}]),
                            NewSupPool = #sup_pool{dan = DanPool, pool = [NewRoom]},
                            ets:insert(?ETS_PVP_3V3_SUP_POOL, NewSupPool);
                        [SupPool] when is_record(SupPool, sup_pool) ->
                            ?DEBUG_MSG("leezp~p~n", [{?MODULE, ?LINE}]),
                            OldPool = SupPool#sup_pool.pool,
                            ?DEBUG_MSG("------------- SupPool --------------~p~n", [SupPool#sup_pool.pool]),
                            NewPool = [NewRoom | OldPool],
                            ets:update_element(?ETS_PVP_3V3_SUP_POOL, DanPool, [{#sup_pool.pool, NewPool}])
                    end
            end;
        false ->
            CPvpPlyInfo = get_pvp_cross_player_info(CaptainId),
            sm_cross_server:rpc_cast(CPvpPlyInfo#pvp_cross_player_data.server_id, lib_send, send_prompt_msg, [CaptainId, ?PM_HAS_PLAYER_NOT_PREPARE])
    end;

insert_pvp_room_to_pool_ets(CaptainId) when is_integer(CaptainId) ->
    Room = lib_pvp:get_room_by_captain_id(CaptainId),
    ?ASSERT(Room =/= null),
    Now = util:unixtime(),
    NewRoom = Room#room{timestamp = Now},
    update_room_to_ets(NewRoom),
    insert_pvp_room_to_pool_ets(NewRoom).

is_teammates_prepare(Room) when is_record(Room, room)->
    Teammates = Room#room.teammates,
    case Teammates of
        [] ->
            true;
        _ ->
            is_teammates_prepare(Teammates)
    end;

is_teammates_prepare([H | T])->
    case (get_pvp_cross_player_info(H))#pvp_cross_player_data.status =:= 2 of
        true ->
            case T of
                [] ->
                    true;
                _ ->
                    is_teammates_prepare(T)
            end;
        false ->
            false
    end.

% 从匹配池删除房间
delete_pvp_room_from_pool_ets(Room) when is_record(Room, room) ->
	CaptainId = Room#room.captain,
	CDan = query_pvp_3v3_player_dan(CaptainId),
    DanPool = get_dan_pool_by_dan(CDan),
	case ets:lookup(?ETS_PVP_3V3_SUP_POOL, DanPool) of
		[] ->
			skip;
		[SupPool] when is_record(SupPool, sup_pool) ->
			NewRoom = Room#room{state = 0},      % 房间标记为可加入
			update_room_to_ets(NewRoom),
			OldPool = SupPool#sup_pool.pool,
			NewPool = lists:delete(Room, OldPool),
			ets:update_element(?ETS_PVP_3V3_SUP_POOL, DanPool, [{#sup_pool.pool, NewPool}])
	end;

delete_pvp_room_from_pool_ets(CaptainId) when is_integer(CaptainId) ->
    ?DEBUG_MSG("----------------- Room CaptainId -----------------~p~n", [CaptainId]),
    Room = lib_pvp:get_room_by_captain_id(CaptainId),
    ?ASSERT(Room =/= null),
    delete_pvp_room_from_pool_ets(Room).

delete_pvp_match_room_ets(CaptainId) ->
	ets:delete(?ETS_PVP_MATCH_ROOM, CaptainId).
	

delete_room(Room) when is_record(Room, room) ->
    delete_room(Room#room.captain);

delete_room(CaptainId) when is_integer(CaptainId) ->
    ets:delete(?ETS_PVP_3V3_ROOM, CaptainId).

% 获得玩家段位
get_dan_by_score(Score) ->
    DanList = data_ranking3v3_score:get_no(),
    get_player_dan(Score, DanList).

get_player_dan(Score, [H | T]) ->
    Min = (data_ranking3v3_score:get(H))#ranking3v3_score.min,
    Max = (data_ranking3v3_score:get(H))#ranking3v3_score.max,
    case Score >= Min andalso Score =< Max of
        true ->
            (data_ranking3v3_score:get(H))#ranking3v3_score.no;
        false ->
            get_player_dan(Score, T)
    end.

get_dan_pool_by_dan(Dan) ->
    % 增加无段位处理，直接放入青铜池
    case Dan =:= 0 of
        true ->
            ?BRONZE;
        false ->
            case Dan =:= 32 of
                true ->
                    ?KING;
                false ->
                    List = data_ranking3v3_section:get_no(),
                    get_player_dan_pool(Dan, List)
            end
    end.

get_player_dan_pool(Dan, [H | T]) ->
    DanPool = (data_ranking3v3_section:get(H))#ranking3v3_section.section,
    case lists:member(Dan, DanPool) of
        true ->
            H;
        false ->
            get_player_dan_pool(Dan, T)
    end.

cancel_type_pool_ets(PlayerId) ->
	PlayerData  = get_pvp_cross_player_info(PlayerId),
    [RoomData] = ets:lookup(?ETS_PVP_3V3_ROOM, PlayerId),
    Counter = RoomData#room.counters,
	case PlayerData of
		null -> skip;
		_ -> Dan = get_dan_pool_by_dan(PlayerData#pvp_cross_player_data.dan),
			 case ets:lookup(?CROSS_TYPE_POOL, {Dan,Counter}) of
				 [] ->
					 null;   
				 [R] ->
					 PlayerList = R#type_pool.player_id,
					 NewPlayerLists = lists:delete(PlayerId, PlayerList),
					 ets:insert(?CROSS_TYPE_POOL, R#type_pool{player_id = NewPlayerLists})
			 end
	end.

% 显示所有房间(可加入,根据创建时间戳排序)
display_all_room() ->
    RoomList = ets:tab2list(?ETS_PVP_3V3_ROOM),
    F = fun(Room, Acc) ->
            case Room#room.state =:= 0 of
                true ->
                    [Room] ++ Acc;
                false ->
                    Acc
            end
        end,
    JoinRoomList = lists:foldl(F, [], RoomList),
    F2 = fun(Room1, Room2) ->
            Room1#room.timestamp2 < Room2#room.timestamp2
        end,
    lists:sort(F2, JoinRoomList).

add_room_to_ets(Room) when is_record(Room, room)->
    ets:insert(?ETS_PVP_3V3_ROOM, Room).

get_room_by_captain_id(CaptainId) ->
    case ets:lookup(?ETS_PVP_3V3_ROOM, CaptainId) of
        [] -> null;
        [Room] -> Room
    end.

update_room_to_ets(Room) when is_record(Room, room) ->
    ets:insert(?ETS_PVP_3V3_ROOM, Room).

update_pvp_cross_player_data_to_ets(PvpPlayerInfo) when is_record(PvpPlayerInfo, pvp_cross_player_data) ->
    ets:insert(?ETS_PVP_CROSS_PLAYER_DATA, PvpPlayerInfo).

db_update_pvp_player_info(PvpPlayerInfo) ->
    db:update(pvp_cross_player_info,
        [
            {win, PvpPlayerInfo#pvp_cross_player_data.win}
            ,{lose, PvpPlayerInfo#pvp_cross_player_data.lose}
            ,{escape, PvpPlayerInfo#pvp_cross_player_data.escape}
            ,{daytimes, PvpPlayerInfo#pvp_cross_player_data.daytimes}
            ,{dan, PvpPlayerInfo#pvp_cross_player_data.dan}
            ,{score, PvpPlayerInfo#pvp_cross_player_data.score}
			,{reward, util:term_to_bitstring(PvpPlayerInfo#pvp_cross_player_data.reward)}
            ,{dayreward, util:term_to_bitstring(PvpPlayerInfo#pvp_cross_player_data.dayreward)}
        ],
        [{player_id, PvpPlayerInfo#pvp_cross_player_data.player_id}]
    ).

db_insert_new_pvp_cross_player_info(PvpPlayerInfo) when is_record(PvpPlayerInfo, pvp_cross_player_data) ->
	PlayerId = PvpPlayerInfo#pvp_cross_player_data.player_id,
	db:insert(PlayerId, pvp_cross_player_info,
			  [{player_id, PlayerId},
			   {server_id, PvpPlayerInfo#pvp_cross_player_data.server_id},
               {player_name, PvpPlayerInfo#pvp_cross_player_data.player_name},
               {sex, PvpPlayerInfo#pvp_cross_player_data.sex},
               {race, PvpPlayerInfo#pvp_cross_player_data.race},
               {faction, PvpPlayerInfo#pvp_cross_player_data.faction},
			   {win, PvpPlayerInfo#pvp_cross_player_data.win},
			   {lose, PvpPlayerInfo#pvp_cross_player_data.lose},
			   {escape, PvpPlayerInfo#pvp_cross_player_data.escape},
			   {daytimes, PvpPlayerInfo#pvp_cross_player_data.daytimes},
			   {tiemstamp, PvpPlayerInfo#pvp_cross_player_data.timestamp},
			   {dan, PvpPlayerInfo#pvp_cross_player_data.dan},
			   {score, PvpPlayerInfo#pvp_cross_player_data.score},
			   {reward,util:term_to_bitstring(PvpPlayerInfo#pvp_cross_player_data.reward)},
               {dayreward,util:term_to_bitstring(PvpPlayerInfo#pvp_cross_player_data.dayreward)}
			  ]).

%% 判断队伍是否满人了
%% @return: true | false
is_team_full(CaptainId)  ->
    get_member_count(CaptainId) =:= ?ROOM_MEMBER_MAX.

%% @return: counters
get_member_count(CaptainId) ->
    (get_room_by_captain_id(CaptainId))#room.counters.

%% @return: [] | 队员id列表
get_room_members(CaptainId) ->
    (get_room_by_captain_id(CaptainId))#room.teammates.

%% @return: true | false
is_in_pvp_3v3_room(CaptainId, PlayerId) ->
    lists:member(PlayerId, get_room_members(CaptainId)).

is_sys_open(PS) ->
    Lv = player:get_lv(PS),
    Lv >= data_special_config:get('3V3_open_lv').

% 查询某个玩家的分数
query_pvp_3v3_player_score(PlayerId) ->
    case get_pvp_cross_player_info(PlayerId) of
        null ->
            -1;
        PvpPlyInfo ->
            PvpPlyInfo#pvp_cross_player_data.score
    end.
%%    case ets:lookup_element(?ETS_PVP_CROSS_PLAYER_DATA, PlayerId, #pvp_cross_player_data.score) of
%%        badarg ->
%%            -1;
%%        Score ->
%%            Score
%%    end.

% 查询某个玩家段位
query_pvp_3v3_player_dan(PlayerId) ->
    case get_pvp_cross_player_info(PlayerId) of
        null ->
            null;
        PvpPlyInfo ->
            PvpPlyInfo#pvp_cross_player_data.dan
    end.

%%    case ets:lookup_element(?ETS_PVP_CROSS_PLAYER_DATA, PlayerId, #pvp_cross_player_data.dan) of
%%        badarg ->
%%            null;
%%        Dan ->
%%            Dan
%%    end.


% 判断某个成员在哪个房间(不是队长)
get_teammate_in_which_room(PlayerId, [Room | RemainRooms]) ->
    case lists:member(PlayerId, Room#room.teammates) of
        true ->
            Room;
        false ->
            case RemainRooms =:= [] of
                true ->
                    null;
                false ->
                    get_teammate_in_which_room(PlayerId, RemainRooms)
            end
    end.

% 判断某个成员在哪个房间(不确定是不是队长)
get_player_in_which_room(PlayerId) ->
    case get_room_by_captain_id(PlayerId) of
        null ->
            RoomLists = ets:tab2list(?ETS_PVP_3V3_ROOM),
            case RoomLists =:= [] of
                true ->
                    null;
                false ->
                    get_teammate_in_which_room(PlayerId, RoomLists)
            end;
        Room ->
            Room
    end.

% 获取房间成员的PVP数据
get_room_pvp_players_info_list(CapatainId) when is_integer(CapatainId)->
    IdList = [CapatainId] ++ get_room_members(CapatainId),
    F = fun(Id, Acc) ->
            PvpPlyInfo = get_pvp_cross_player_info(Id),
            [PvpPlyInfo | Acc]
        end,
    lists:foldl(F, [], IdList);

get_room_pvp_players_info_list(Room) when is_record(Room, room) ->
    IdList = [Room#room.captain] ++ Room#room.teammates,
    F = fun(Id, Acc) ->
        PvpPlyInfo = get_pvp_cross_player_info(Id),
        [PvpPlyInfo | Acc]
        end,
    lists:foldl(F, [], IdList).

% 获取房间申请人员PVP数据
get_apply_list_player_info_list(CapatainId) ->
    ApplyList = (get_room_by_captain_id(CapatainId))#room.apply_list,
    F = fun(Id, Acc) ->
            case get_pvp_cross_player_info(Id) of
                null ->
                    Acc;
                PlayInfo ->
                    case PlayInfo#pvp_cross_player_data.status =:= 0 of
                        true ->
                            [PlayInfo|Acc];
                        false ->
                            Acc
                    end
            end
        end,
    lists:foldl(F, [], ApplyList).

send_room_apply_info(PlayerId, ApplyList) ->
    {ok, BinData} = pt_43:write(?PT_PVP_QRY_APPLY_LIST, [ApplyList]),
    lib_send:send_to_uid(PlayerId, BinData).

send_room_players_info_to_teammate(Room) when is_record(Room, room)->
    PvpInfoList = lib_pvp:get_room_pvp_players_info_list(Room#room.captain),
    F = fun(PvpPlyInfo, Acc) ->
        PlayerId = PvpPlyInfo#pvp_cross_player_data.player_id,
        PlayerName = PvpPlyInfo#pvp_cross_player_data.player_name,
        Faction = PvpPlyInfo#pvp_cross_player_data.faction,
        Sex = PvpPlyInfo#pvp_cross_player_data.sex,
        Lv = PvpPlyInfo#pvp_cross_player_data.lv,
        Race = PvpPlyInfo#pvp_cross_player_data.race,
        ShowEquips = PvpPlyInfo#pvp_cross_player_data.showing_equips,
        Dan = PvpPlyInfo#pvp_cross_player_data.dan,
        [{PlayerId, PlayerName, Faction, Sex, Lv, Race, ShowEquips, Dan} | Acc]
        end,
    List = lists:foldl(F, [], PvpInfoList),
    {ok, BinData} = pt_43:write(?PT_PVP_CREATE_ROOM , [Room, List]),

    F2 = fun(PvpPlyInfo) ->
            sm_cross_server:rpc_cast(PvpPlyInfo#pvp_cross_player_data.server_id, lib_send, send_to_uid,
                [PvpPlyInfo#pvp_cross_player_data.player_id, BinData])
         end,
    lists:foreach(F2, PvpInfoList);

send_room_players_info_to_teammate(CaptainId)->
    case get_room_by_captain_id(CaptainId) of
		Room when is_record(Room, room)->
			?ASSERT(Room =/= null),
			send_room_players_info_to_teammate(Room);
		_ ->
			skip
	end.

send_message_to_client(ServerId, PlayerId, BinData) ->
    sm_cross_server:rpc_cast(ServerId, lib_send, send_to_uid, [PlayerId, BinData]).

send_message_to_all_players_in_room(Room, BinData) when is_record(Room, room)->
    PvpInfoList = lib_pvp:get_room_pvp_players_info_list(Room),

    F = fun(PvpPlyInfo) ->
            send_message_to_client(PvpPlyInfo#pvp_cross_player_data.server_id, PvpPlyInfo#pvp_cross_player_data.player_id, BinData)
        end,
    lists:foreach(F, PvpInfoList);

send_message_to_all_players_in_room(CaptainId, BinData) when is_integer(CaptainId)->
    Room = lib_pvp:get_room_by_captain_id(CaptainId),
    ?ASSERT(Room =/= null),
    send_message_to_all_players_in_room(Room, BinData).

is_captain(PlayerId) ->
    case get_room_by_captain_id(PlayerId) of
        null ->
            false;
        _Room ->
            true
    end.

%% 判断某个玩家是否在线
is_online(ServerId, PlayerId) ->
    case sm_cross_server:rpc_call(ServerId, player, is_online, [PlayerId]) of
        {ok, false} ->
            false;
        {ok, true} ->
            true
    end.

%% 判断一个玩家是否在房间
is_in_room(PlayerId) ->
    case get_pvp_cross_player_info(PlayerId) of
        null ->
            false;
        PvpPlyInfo ->
            case PvpPlyInfo#pvp_cross_player_data.status of
                0 ->
                    false;
                _ ->
                    true
            end
    end.

%% 判断两个玩家段位是否满足匹配规则
judge_two_players_dan(CaptainId, ObjPlayerId) ->
    CaptainDan = lib_pvp:query_pvp_3v3_player_dan(CaptainId),
    ?DEBUG_MSG("------ CaptainDan ----~p~n", [CaptainDan]),
    PlayerDan= lib_pvp:query_pvp_3v3_player_dan(ObjPlayerId),
    ?DEBUG_MSG("------ PlayerDan ----~p~n", [PlayerDan]),

    {Ls, Rs} = (data_ranking3v3_team_match_range:get(CaptainDan))#ranking3v3_team_match_range.team_match_range,

    case PlayerDan >= Ls andalso PlayerDan =< Rs of
        true ->
            true;
        false ->
            false
    end.

judge_players_dan(CaptainId, ObjPlyList) ->
    F = fun(ObjPlyId, Acc) ->
            case get_pvp_cross_player_info(ObjPlyId) of
                null ->
                    Acc;
                _ ->
                    case get_player_in_which_room(ObjPlyId) of
                        null ->
                            case judge_two_players_dan(CaptainId, ObjPlyId) of
                                true ->
                                    [ObjPlyId | Acc];
                                false ->
                                    Acc
                            end;
                        _Room ->
                            Acc
                    end
            end
        end,
    lists:foldl(F, [], ObjPlyList).

%% 把房间状态置为0
set_room_state(Room) when is_record(Room, room) ->
    NewRoom = Room#room{state = 0},      % 房间标记为可加入
    update_room_to_ets(NewRoom).

set_player_status(PvpPlyInfo) when is_record(PvpPlyInfo, pvp_cross_player_data) ->
    NewPvpPlyInfo = PvpPlyInfo#pvp_cross_player_data{status = 0},      % 玩家可加入
    update_pvp_cross_player_data_to_ets(NewPvpPlyInfo).

set_dayreward(PlayerId, Type) ->
    PvpPlyInfo = get_pvp_cross_player_info(PlayerId),
    NewPvpPlyInfo = PvpPlyInfo#pvp_cross_player_data{dayreward = [Type | PvpPlyInfo#pvp_cross_player_data.dayreward]},
    update_pvp_cross_player_data_to_ets(NewPvpPlyInfo),
    db_update_pvp_player_info(NewPvpPlyInfo).

on_player_tmp_logout(PlayerId) ->
    ?DEBUG_MSG("------------ RoomLists -----------~p~n", [ets:tab2list(?ETS_PVP_3V3_ROOM)]),
    ?DEBUG_MSG("------------ PlayerId -----------~p~n", [PlayerId]),
    case ets:tab2list(?ETS_PVP_3V3_ROOM) of
        [] ->
            skip;
        RoomLists ->
            case get_room_by_captain_id(PlayerId) of
                null ->
                    case get_teammate_in_which_room(PlayerId, RoomLists) of
                        null ->
                            skip;   % 暂不处理，可以发998协议告诉前端
                        Room ->
                            ?DEBUG_MSG("------------ teammate -----------~n", []),
                            mod_pvp:do_leave_room(PlayerId, Room, teammate)
                    end;
                Room ->
                    ?DEBUG_MSG("------------ captain -----------~n", []),
                    mod_pvp:do_leave_room(PlayerId, Room, captain)
                    end
    end.



on_pvp_player_tmp_logout(PS) ->
    PlayerId = player:get_id(PS),
    sm_cross_server:rpc_cast(lib_pvp, on_player_tmp_logout, [PlayerId]).

%% 判断当前时间是否在开启时间
is_in_3v3_pvp_activity(Hour) ->
    ?DEBUG_MSG("Hour~p~n", [?MODULE, Hour]),
    StartTime = data_special_config:get('3V3_start_time'),
    EndTime = data_special_config:get('3V3_end_time'),
    case Hour >= StartTime andalso Hour < EndTime of
        true ->
            true;
        false ->
            false
    end.

%% 根据每场战斗反馈结果，更新玩家数据  (0：赢    1：输     2：逃跑)
update_pvp_player_info_from_battle(PlayerId, Type, Dan, Score,Reward,DayTimes) ->
    PvpPlyInfo = lib_pvp:get_pvp_cross_player_info(PlayerId),
    OldDan = PvpPlyInfo#pvp_cross_player_data.dan,
    Win = PvpPlyInfo#pvp_cross_player_data.win,
    Lose = PvpPlyInfo#pvp_cross_player_data.lose,
    Escape = PvpPlyInfo#pvp_cross_player_data.escape,
    Times = PvpPlyInfo#pvp_cross_player_data.daytimes,
    NewPlyInfo =
        case Type of
            0 ->
                PvpPlyInfo#pvp_cross_player_data{win = Win + 1, dan = Dan, score = Score, daytimes = Times + DayTimes,reward = Reward};
            1 ->
                PvpPlyInfo#pvp_cross_player_data{lose = Lose + 1, dan = Dan, score = Score, daytimes = Times + DayTimes};
            2 ->
                PvpPlyInfo#pvp_cross_player_data{escape = Escape + 1}
        end,
    update_pvp_cross_player_data_to_ets(NewPlyInfo),
    db_update_pvp_player_info(NewPlyInfo),
    case lib_pvp:get_ets_pvp_rank_data_from_ets(pvp_cross_rank_data) of
        null -> [];
        R -> R2 = R#pvp_rank_data{dirty = 1},
            lib_pvp:add_pvp_3v3_rank_to_ets(R2)
    end,
    % 若玩家段位发生改变则回传player结构体更新
    case Dan =:= OldDan of
        true ->
            skip;
        false ->
            sm_cross_server:rpc_cast(PvpPlyInfo#pvp_cross_player_data.server_id, lib_pvp, notify_dan_change, [PlayerId, Dan])
    end.

clear_pvp_rank_data(Id) ->
    ets:delete(?ETS_PVP_RANK_DATA, Id).

remove_invite_limit(CaptainId) ->
    % 此处对于队长邀请列表清空下
    Room = lib_pvp:get_room_by_captain_id(CaptainId),
    ?ASSERT(Room =/= null),
    NewRoom = Room#room{invited_list = []},
    lib_pvp:update_room_to_ets(NewRoom).

%% 段位改变同步到本服
notify_dan_change(PlayerId, Dan) ->
    player_syn:set_dan(PlayerId, Dan),
    lib_scene:notify_int_info_change_to_aoi(player, PlayerId, [{?OI_CODE_DAN, Dan}]).

%% gm调用的函数
set_score(PlayerId, NewValue) ->
    PvpPlyInfo = lib_pvp:get_pvp_cross_player_info(PlayerId),
    Dan = lib_pvp:get_dan_by_score(NewValue),
    NewPvpPlyInfo = PvpPlyInfo#pvp_cross_player_data{score = NewValue, dan = Dan},
    lib_pvp:update_pvp_cross_player_data_to_ets(NewPvpPlyInfo),
    lib_pvp:db_update_pvp_player_info(NewPvpPlyInfo).



	


