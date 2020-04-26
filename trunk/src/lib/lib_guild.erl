%%%-----------------------------------
%%% @Module  : lib_guild
%%% @Author  : zwq
%%% @Email   : 
%%% @Created : 2014.5.22
%%% @Description: 帮派副本\宴会\帮派争夺战函数
%%%-----------------------------------
-module(lib_guild).

-include("common.hrl").
-include("record/guild_record.hrl").
-include("prompt_msg_code.hrl").
-include("log.hrl").
-include("reward.hrl").
-include("dungeon.hrl").
-include("guild.hrl").
-include("ets_name.hrl").
-include("record.hrl").
-include("pt_40.hrl").
-include("debug.hrl").
-include("activity_degree_sys.hrl").
-include("business.hrl").

-export ([
    get_party_from_ets/1,
    add_party_to_ets/1,
    update_party_to_ets/1,
    del_party_from_ets/1,

    get_guild_war_from_ets/1,
    add_guild_war_to_ets/1,
    update_guild_war_to_ets/1,
    del_guild_war_from_ets/1,

    can_join_guild_dungeon/1,

    get_party_last_time/0,
    get_guild_dungeon_rd/1,
    update_dungeon_info/2,
    notify_dungeon_close/1,
    get_guild_dungeon_info/1,
    notify_add_dungeon_kill_mon/2,
    notify_dungeon_cellect/2,
    refresh_script/3,
    give_reward_and_notify_result_success/2,
    notify_result_fail/1,
    notify_dungeon_info_change/1,
    get_random_make_goods_no/1,

    check_activity_data/1,
    get_range_shop_goods/2
    ]).


%% return true | false
can_join_guild_dungeon(PS) ->
    case player:get_guild_id(PS) of
        ?INVALID_ID -> false;
        GuildId ->
            case get_guild_dungeon_rd(GuildId) of
                null -> false;
                _Any -> true
            end
    end.


get_party_last_time() ->
    case mod_activity:publ_get_activity_duration(?AD_GUILD_ACTIVITY) of
        null -> 0;
        Time -> Time
    end.

%% return guild_dungeon 结构体
get_guild_dungeon_info(PS) ->
    case is_in_guild_dungeon(PS) of
        true ->
            GuildId = player:get_guild_id(PS),
            case get_guild_dungeon_rd(GuildId) of
                GuildDungeon when is_record(GuildDungeon, guild_dungeon) ->
                    GuildDungeon;
                _ -> ?ASSERT(false)
            end;
        false -> null
    end.

notify_dungeon_close(GuildId) ->
    % ?DEBUG_MSG("lib_guild:notify_dungeon_close GuildId:~p ~n", [GuildId]),
    case get_guild_dungeon_rd(GuildId) of
        null -> skip;
        _Dungeon -> del_dungeon_from_ets(GuildId)
    end.


%% InfoList: [DungeonPid, floor, State] State --> win,lose,underway
update_dungeon_info(GuildId, [DungeonPid, Floor, State, JoinIdList]) ->
    % ?DEBUG_MSG("lib_guild:update_dungeon_info GuildId:~p ~w ~n", [GuildId, {DungeonPid, Floor, State, JoinIdList}]),
    case get_guild_dungeon_rd(GuildId) of
        null ->
            MaxFloor = 
                case mod_guild:get_info(GuildId) of
                    null ->
                        ?ASSERT(false, GuildId), 0;
                    Guild ->
                        lists:nth(2, (data_guild_lv:get(mod_guild:get_lv(Guild)))#guild_lv_data.layer)
                end,
    
            Rd = #guild_dungeon{
                guild_id = GuildId,
                dungeon_pid = DungeonPid,
                floor = Floor,
                collect = 0,
                kill_mon = 0,
                start_time = svr_clock:get_unixtime(),
                max_floor = MaxFloor,
                join_id_list = JoinIdList
            },
            update_dungeon_to_ets(Rd),
            notify_dungeon_info_change(Rd);
        GuildDungeon ->
            case State of
                lose -> 
                    spawn(fun() -> lib_guild:notify_result_fail(JoinIdList) end),
                    lib_log:statis_pass_guild_dungeon(GuildDungeon#guild_dungeon.guild_id, mod_guild:get_lv(GuildDungeon#guild_dungeon.guild_id), GuildDungeon#guild_dungeon.floor),
                    mod_activity:notify_close_activity(mod_guild:get_member_id_list(GuildId), ?AD_GUILD_DUNGEON),
                    del_dungeon_from_ets(GuildId);
                win ->
                    case GuildDungeon#guild_dungeon.floor =:= Floor of
                        true -> %% 通关了顶层
                            % ?INFO_MSG("lib_guild:update_dungeon_info() two floor:~p, GuildId:~p~n", [{GuildDungeon#guild_dungeon.floor,Floor}, GuildId]),
                            spawn(fun() -> lib_guild:give_reward_and_notify_result_success(Floor, JoinIdList) end), 
                            ply_tips:send_sys_tips(mod_guild:get_info(GuildId), {get_guild_dungeon_top, [mod_guild:get_name_by_id(GuildId)]}),
                            lib_log:statis_pass_guild_dungeon(GuildDungeon#guild_dungeon.guild_id, mod_guild:get_lv(GuildDungeon#guild_dungeon.guild_id), Floor),
                            mod_activity:notify_close_activity(mod_guild:get_member_id_list(GuildId), ?AD_GUILD_DUNGEON),
                            del_dungeon_from_ets(GuildId);     
                        false ->
                            ?ASSERT(Floor > GuildDungeon#guild_dungeon.floor, {Floor, GuildDungeon#guild_dungeon.floor}),
                            spawn(fun() -> lib_guild:give_reward_and_notify_result_success(GuildDungeon#guild_dungeon.floor, JoinIdList) end), 
                            GuildDungeon1 = GuildDungeon#guild_dungeon{
                                floor = Floor,
                                collect = 0,
                                kill_mon = 0,
                                % start_time = svr_clock:get_unixtime(),
                                join_id_list = JoinIdList
                            },
                            update_dungeon_to_ets(GuildDungeon1),
                            notify_dungeon_info_change(GuildDungeon1)
                    end;
                underway -> 
                    GuildDungeon1 = GuildDungeon#guild_dungeon{
                        join_id_list = JoinIdList
                    },
                    update_dungeon_to_ets(GuildDungeon1);
                    % notify_dungeon_info_change(GuildDungeon1);
                _Any -> ?ASSERT(false, _Any)
            end
    end.


notify_add_dungeon_kill_mon(GuildId, Num) ->
    case get_guild_dungeon_rd(GuildId) of
        null ->
            ?ASSERT(false);
        GuildDungeon ->
            GuildDungeon1 = GuildDungeon#guild_dungeon{kill_mon = GuildDungeon#guild_dungeon.kill_mon + Num}, 
            update_dungeon_to_ets(GuildDungeon1),
            notify_dungeon_info_change(GuildId)
    end.


notify_dungeon_cellect(GuildId, Num) ->
    case get_guild_dungeon_rd(GuildId) of
        null ->
            ?ASSERT(false);
        GuildDungeon ->
            GuildDungeon1 = GuildDungeon#guild_dungeon{collect = GuildDungeon#guild_dungeon.collect + Num}, 
            update_dungeon_to_ets(GuildDungeon1),
            notify_dungeon_info_change(GuildId)
    end.


%% return [{monId, monNO}]
refresh_script([Script | List], State, SceneId) ->
    refresh_script([Script | List], State, SceneId, []).


refresh_script([], _, _, RetList) -> RetList;
refresh_script([Script | List], State, SceneId, RetList) ->
    MonList = refresh_script__(Script, State, SceneId),
    refresh_script(List, State, SceneId, RetList ++ MonList).


refresh_script__([Type | _] = Script, State, SceneId) when Type =:= single orelse Type =:= random ->
    refresh_monster(Script, State, SceneId);
refresh_script__(_, _, _) -> [], ?ASSERT(false).


%% @return null | #guild_party{}
get_party_from_ets(GuildId) ->
    case ets:lookup(?ETS_GUILD_PARTY, GuildId) of
        [Rd] when is_record(Rd, guild_party) -> Rd;
        _ -> null
    end.

update_party_to_ets(GuildParty) when is_record(GuildParty, guild_party) ->
    ets:insert(?ETS_GUILD_PARTY, GuildParty).


add_party_to_ets(GuildParty) when is_record(GuildParty, guild_party) ->
    ets:insert(?ETS_GUILD_PARTY, GuildParty).

del_party_from_ets(GuildId) ->
    ets:delete(?ETS_GUILD_PARTY, GuildId).


get_guild_war_from_ets(GuildId) ->
    case ets:lookup(?ETS_GUILD_WAR, GuildId) of
        [Rd] when is_record(Rd, guild_war) -> Rd;
        _ -> null
    end.

update_guild_war_to_ets(GuildWar) when is_record(GuildWar, guild_war) ->
    ets:insert(?ETS_GUILD_WAR, GuildWar).


add_guild_war_to_ets(GuildWar) when is_record(GuildWar, guild_war) ->
    ets:insert(?ETS_GUILD_WAR, GuildWar).

del_guild_war_from_ets(GuildId) ->
    ets:delete(?ETS_GUILD_WAR, GuildId).


%% {true, NewData} | false
check_activity_data(JosonData) ->
    case rfc4627:decode(JosonData) of
        {ok, Data, _} ->
            {obj, List} = Data,
            case length(List) =:= 4 of
                true ->
                    {"Lv", BLv} = lists:nth(1, List),
                    Lv = list_to_integer(binary_to_list(BLv)),

                    {"attach", BGoodsList} = lists:nth(2, List),

                    GoodsList = util:string_to_term(binary_to_list(BGoodsList)),

                    {"content", BContent} = lists:nth(3, List),
                    {"title", BTitle} = lists:nth(4, List),
                    {true, [Lv, GoodsList, BTitle, BContent]};
                false -> false
            end;
        _Any ->
            false
    end.


%% -------------------------------------------------Local fun--------------------------------------

notify_dungeon_info_change(Dungeon) when is_record(Dungeon, guild_dungeon) ->
    F = fun(PlayerId) ->
        case player:get_PS(PlayerId) of
            null -> skip;
            PS ->
                {ok, BinData} = pt_40:write(?PT_GUILD_GET_DUNGEON_INFO, [Dungeon]),
                lib_send:send_to_sock(PS, BinData)
        end
    end,
    [F(X) || X <- Dungeon#guild_dungeon.join_id_list];

notify_dungeon_info_change(GuildId) ->
    % ?DEBUG_MSG("lib_guild:notify_dungeon_info_change GuildId:~p ~n", [GuildId]),
    case get_guild_dungeon_rd(GuildId) of
        null ->
            ?DEBUG_MSG("lib_guild:notify_dungeon_info_change null ~n", []),
            skip;
        Dungeon ->
            F = fun(PlayerId) ->
                case player:get_PS(PlayerId) of
                    null -> 
                        ?DEBUG_MSG("lib_guild:notify_dungeon_info_change null ~n", []),
                        skip;
                    PS ->
                        {ok, BinData} = pt_40:write(?PT_GUILD_GET_DUNGEON_INFO, [Dungeon]),
                        lib_send:send_to_sock(PS, BinData)
                end
            end,
            [F(X) || X <- Dungeon#guild_dungeon.join_id_list]
    end.


give_reward_and_notify_result_success(Floor, JoinIdList) ->
    ?DEBUG_MSG("lib_guild:give_reward_and_notify_result_success Floor:~p, JoinIdList:~p ~n", [Floor, JoinIdList]),
    case data_guild_dungeon:get(Floor) of
        null ->
            ?ASSERT(false, Floor),
            skip;
        Data ->
            RewardPkgNo = Data#guild_dungeon_cfg.reward_no,
            F = fun(PlayerId) ->
                case player:get_PS(PlayerId) of
                    null -> skip;
                    PS ->
                        %曾经在帮派副本通过第N层
                        mod_achievement:notify_achi(guild_dungeon_pass, [{floor, Floor},{num, 1}], PS), 
                        case lib_reward:check_bag_space(PS, RewardPkgNo) of
                            {fail, Reason} ->
                                lib_send:send_prompt_msg(PS, Reason),
                                Reward = lib_reward:give_reward_to_player(PS, RewardPkgNo, [?LOG_GUILD, "fb"]),
                                {ok, BinData} = pt_40:write(?PT_GUILD_NOTIFY_DUNGEON_RET, [PlayerId, 1, Reward#reward_dtl.goods_list]),
                                ?DEBUG_MSG("lib_guild:give_reward_and_notify_result_success begin send: ~p~n", [BinData]),
                                lib_send:send_to_sock(PS, BinData);
                            ok ->
                                Reward = lib_reward:give_reward_to_player(PS, RewardPkgNo, [?LOG_GUILD, "fb"]),
                                {ok, BinData} = pt_40:write(?PT_GUILD_NOTIFY_DUNGEON_RET, [PlayerId, 1, Reward#reward_dtl.goods_list]),
                                ?DEBUG_MSG("lib_guild:give_reward_and_notify_result_success begin send: ~p~n", [BinData]),
                                lib_send:send_to_sock(PS, BinData)
                        end
                end
            end,
            [F(X) || X <- JoinIdList]
    end.


notify_result_fail(JoinIdList) ->
    % ?DEBUG_MSG("lib_guild:notify_result_fail~n", []),
    F = fun(PlayerId) ->
        case player:get_PS(PlayerId) of
            null -> skip;
            PS ->
                {ok, BinData} = pt_40:write(?PT_GUILD_NOTIFY_DUNGEON_RET, [PlayerId, 0, []]),
                lib_send:send_to_sock(PS, BinData)
        end
    end,
    [F(X) || X <- JoinIdList].



%% @doc 是否在帮派副本中
%% @return boolean()
is_in_guild_dungeon(Status) ->
    case player:is_in_dungeon(Status) of
        {true, _} -> player:get_dungeon_type(Status) =:= ?DUNGEON_TYPE_GUILD;
        false -> false
    end.


%% @return null | #guild_dungeon{}
get_guild_dungeon_rd(GuildId) ->
    case ets:lookup(?ETS_GUILD_DUNGEON, GuildId) of
        [GuildDungeon] when is_record(GuildDungeon, guild_dungeon) -> GuildDungeon;
        _ -> null
    end.

%% 计算需要随机的范围
get_random_range_make_goods_no(GoodsList) ->
    F = fun({Lv,GoodsNo, Widget},Sum) ->
        Widget + Sum
    end,

    lists:foldl(F, 0, GoodsList).

%% 随机
get_random_make_goods_no(GoodsList) ->    
    Range = get_random_range_make_goods_no(GoodsList),
    RandNum = util:rand(1, Range),

    get_random_make_goods_no(GoodsList,RandNum).


% 获取随机特效信息
get_random_make_goods_no(GoodsList, RandNum) ->
    get_random_make_goods_no(GoodsList, RandNum, 0).

get_random_make_goods_no([H | T], RandNum, SumToCompare) ->
    {_Lv,GoodsNo, Widget} = H,
    SumToCompare_2 = Widget + SumToCompare,

    case RandNum =< SumToCompare_2 of
        true -> 
            GoodsNo;
        false ->
            get_random_make_goods_no(T, RandNum, SumToCompare_2)
    end;

get_random_make_goods_no([], _RandNum, _SumToCompare) ->
    null.



update_dungeon_to_ets(GuildDungeon) when is_record(GuildDungeon, guild_dungeon) ->
    ets:insert(?ETS_GUILD_DUNGEON, GuildDungeon).

del_dungeon_from_ets(GuildId) ->
    ets:delete(?ETS_GUILD_DUNGEON, GuildId).

%% return [{monId, monNO}]
refresh_monster([single, SceneNo, CoordList, MonRanList, 1], State, SceneId) ->
    [refresh_single(SceneNo, CoordList, MonRanList, State, SceneId)];
refresh_monster([single, SceneNo, CoordList, MonRanList, Times], State, SceneId) ->
    [refresh_single(SceneNo, CoordList, MonRanList, State, SceneId) |
     refresh_monster([single, SceneNo, CoordList, MonRanList, Times - 1], State, SceneId)];

refresh_monster([random, SceneNoList, MonRanList, 1], State, SceneId) ->
    [refresh_random(SceneNoList, MonRanList, State, SceneId)];
refresh_monster([random, SceneNoList, MonRanList, Times], State, SceneId) ->
    [refresh_random(SceneNoList, MonRanList, State, SceneId) |
    refresh_monster([random, SceneNoList, MonRanList, Times - 1], State, SceneId)].


refresh_random(SceneNoList, MonRanList, State, SceneId) ->
    SeedCoor = get_mon_seed(),
    Length = erlang:length(SceneNoList),
    {_SceneNo, AreaId} = lists:nth(util:rand(1, Length), SceneNoList),
    MonNo = get_val_by_random(SeedCoor, MonRanList),
    case State of
        sys -> 
            case mod_scene:spawn_mon_to_scene_for_public_WNC(MonNo, SceneId, AreaId) of
                {_, MonId} -> {MonId, MonNo};
                _ -> ?ASSERT(false), {0, 0}
            end;
        PS when is_record(PS, player_status) ->
            case mod_scene:spawn_mon_to_scene_for_player_WNC(PS, MonNo, SceneId, AreaId) of
                {_, MonId} -> {MonId, MonNo};
                _ -> ?ASSERT(false), {0, 0}
            end;
        _ -> ?ASSERT(false), {0, 0}
    end.

refresh_single(_SceneNo, CoordList, MonRanList, State, SceneId) ->
    SeedCoor = get_mon_seed(),
    Length = erlang:length(CoordList),
    {X, Y} = lists:nth(util:rand(1, Length), CoordList),
    MonNo = get_val_by_random(SeedCoor, MonRanList),
    case State of
        sys -> 
            case mod_scene:spawn_mon_to_scene_for_public_WNC(MonNo, SceneId, X, Y) of
                {_, MonId} -> {MonId, MonNo};
                _ -> ?ASSERT(false), {0, 0}
            end;
        Status when is_record(Status, player_status) ->
            case mod_scene:spawn_mon_to_scene_for_player_WNC(Status, MonNo, SceneId, X, Y) of
                {_, MonId} -> {MonId, MonNo};
                _ -> ?ASSERT(false), {0, 0}
            end;
        _ -> ?ASSERT(false), {0, 0}
    end.

get_val_by_random(Seed, List) ->
    get_val_by_random(Seed, List, 0).

get_val_by_random(_, [], _) ->
    ?ASSERT(false), error;
get_val_by_random(Seed, [{Val, Num} | Left], Count) ->
    Next = Num + Count,
    case Seed > Count andalso Seed =< Next of
        true -> Val;
        false -> get_val_by_random(Seed, Left, Next)
    end.

get_mon_seed() ->
    util:rand(1, ?MON_SEED).

get_range_shop_goods(_GuildLv, IdList) ->
    F = fun(Id, Acc) ->
            case data_guild_shop:get(Id) of
                null -> Acc;
                #data_guild_shop{shop_no = No, weight = Weight} ->
                            case lists:keyfind(No, 1, Acc) of
                                {_No, OldWeight} ->
                                    lists:keyreplace(No, 1, Acc, {No, OldWeight + Weight});
                                false ->
                                    [{No, Weight} | Acc]
                            end
            end
        end,
    NoList = lists:foldl(F, [], IdList),
    F2 = fun(X, NoAcc) ->
            {OldNo, TotalWeigth} = X,
            RandNum = util:rand(1, TotalWeigth),
            lists:keyreplace(OldNo, 1, NoAcc, {OldNo, RandNum})
        end,
    WeightList = lists:foldl(F2, NoList, NoList),
    F3 = fun({N,W}, A) ->
            A ++ get_shop_goods_by_weigth(IdList, W, 0, N)
        end,
    lists:foldr(F3, [], WeightList).

get_shop_goods_by_weigth([H|T], RandNum, Total, N) ->
    case data_guild_shop:get(H) of
        null -> ?ASSERT(false, H);
        #data_guild_shop{shop_no = N} = GuildShop ->
            NewTotal = Total + GuildShop#data_guild_shop.weight,
            case NewTotal >= RandNum of
                true ->
                    [{GuildShop#data_guild_shop.id, GuildShop#data_guild_shop.shop_no, GuildShop#data_guild_shop.count_limit}];
                false ->
                    get_shop_goods_by_weigth(T, RandNum, NewTotal, N)
            end;
        _ ->
            get_shop_goods_by_weigth(T, RandNum, Total, N)
    end;

get_shop_goods_by_weigth([], _R, _T, _N) ->
    ?DEBUG_MSG("RandNum is error : ~p~n",[_R]),
    [].
