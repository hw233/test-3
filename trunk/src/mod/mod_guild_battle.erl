%%%-----------------------------------
%%% @Module  : guild_battle
%%% @Author  : 段世和
%%% @Email   : 
%%% @Created : 2015.10.27
%%% @Description: 老虎机
%%%-----------------------------------


-module(mod_guild_battle).

% include
-include("common.hrl").
-include("guild_battle.hrl").
-include("goods.hrl").
-include("record.hrl").
-include("abbreviate.hrl").
-include("player.hrl").
-include("ets_name.hrl").
-include("log.hrl").
-include("sys_code_2.hrl").
-include("prompt_msg_code.hrl").
-include("num_limits.hrl").
-include("reward.hrl").

-include("record/battle_record.hrl").
-include("scene.hrl").
-include("pt_65.hrl").

-compile(export_all).

% sdsdsdsd
% PK回调
pk_callback(PlayerId, Feedback) ->
    MyPs = 
    case player:get_PS(PlayerId) of
        PS_ when is_record(PS_,player_status) -> PS_;
        null -> 
            case ply_tmplogout_cache:get_tmplogout_PS(PlayerId) of
                PS__ when is_record(PS__,player_status) -> PS__;
                null -> null
            end
    end,
    case MyPs of
        null ->
            % 即使完全掉线也要送回城
            ply_scene:teleport_after_die(PlayerId),
            skip;
        PS ->
            case lib_bt_comm:is_guild_pk_battle(Feedback) of
                true ->
                    ?DEBUG_MSG(" Feedback#btl_feedback.result = ~p",[ Feedback#btl_feedback.result]),
                    List = Feedback#btl_feedback.oppo_player_id_list,
                    Len = length(List),

                    F = fun(Pid,Acc) ->                        
                        case Acc of
                            0 ->
                                Pid;
                            _ ->
                                case player:get_PS(Pid) of 
                                    PPS when is_record(PPS,player_status) ->
                                        case (not player:is_in_team(PPS) orelse player:is_leader(PPS)) of
                                            true ->
                                                Pid;
                                            false ->
                                                Acc
                                        end;
                                    _ ->
                                        Acc
                                end
                        end
                    end,

                    KillerId = lists:foldl(F, 0,List),

                    case Feedback#btl_feedback.result of
                        win ->
                            % 增加胜利场数
                            case get_guild_battle_info_by_player_id(PlayerId) of
                                 GuildBattleInfo when is_record(GuildBattleInfo, guild_battle_player_info) ->
                                    % 胜利次数以及连胜次数+1
                                    OldStreak = GuildBattleInfo#guild_battle_player_info.winning_streak,
                                    OldMaxStreak = GuildBattleInfo#guild_battle_player_info.max_winning_streak,
                                    OldWind = GuildBattleInfo#guild_battle_player_info.battle_win,

                                    NewStreak = OldStreak + 1,

                                    NewMaxStreak = 
                                    case NewStreak > OldMaxStreak of
                                        true ->
                                            NewStreak;
                                        false ->
                                            OldMaxStreak
                                    end,

                                    NewGuildBattleInfo = GuildBattleInfo#guild_battle_player_info{
                                        battle_win = OldWind + 1,
                                        winning_streak = NewStreak,
                                        max_winning_streak = NewMaxStreak
                                    },

                                    % 计算胜利的队长
                                    case player:is_in_team(PS) andalso player:is_leader(PS) of
                                        true ->
                                            % 帮派的战斗次数+1
                                            GuildBattleGuldInfo_New = 
                                            case get_guild_battle_info_by_guild_id(player:get_guild_id(PS)) of
                                                GuildBattleGuldInfo when is_record(GuildBattleGuldInfo,guild_battle_guild_info) ->
                                                    GuildBattleGuldInfo#guild_battle_guild_info{
                                                        battle_count = GuildBattleGuldInfo#guild_battle_guild_info.battle_count + 1,
                                                        battle_win_count = GuildBattleGuldInfo#guild_battle_guild_info.battle_win_count + 1
                                                    };
                                                _ ->
                                                    #guild_battle_guild_info{
                                                        guild_id = player:get_guild_id(PS),
                                                        % guild_name = mod_guild:get_name_by_id(player:get_guild_id(PS)),
                                                        rounds = get_rounds(),
                                                        battle_win_count = 1,
                                                        battle_count = 1
                                                    }
                                            end,

                                            update_guild_battle_guild_info_to_ets(GuildBattleGuldInfo_New),

                                            % 连胜广播
                                            case OldStreak + 1 of
                                                ?GUILD_KILLING_SPREE ->
                                                    mod_broadcast:send_sys_broadcast(195, [
                                                        player:get_name(PS)
                                                        ,player:id(PS)]
                                                    );
                                                ?GUILD_RAMPAGE -> 
                                                    mod_broadcast:send_sys_broadcast(196, [
                                                        player:get_name(PS)
                                                        ,player:id(PS)]
                                                    );
                                                ?GUILD_UNSTOPPABLE -> 
                                                    mod_broadcast:send_sys_broadcast(197, [
                                                        player:get_name(PS)
                                                        ,player:id(PS)]
                                                    );
                                                ?GUILD_DOMINATING -> 
                                                    mod_broadcast:send_sys_broadcast(198, [
                                                        player:get_name(PS)
                                                        ,player:id(PS)]
                                                    );
                                                ?GUILD_GOD_LIKE -> 
                                                    mod_broadcast:send_sys_broadcast(199, [
                                                        player:get_name(PS)
                                                        ,player:id(PS)]
                                                    );
                                                ?GUILD_LEGENDARY -> 
                                                    mod_broadcast:send_sys_broadcast(200, [
                                                        player:get_name(PS)
                                                        ,player:id(PS)]
                                                    );
                                                _ ->
                                                    skip
                                            end;


                                        false ->
                                            skip
                                    end,

                                    mod_guild_battle:add_guild_battle_info(NewGuildBattleInfo),
                                    void;
                                _ ->
                                    void
                            end,

                            % 增加战功
                            % player:add_guild_feat(PS,Len * 5,[]);
                            void;
                        lose ->

                            % 计算胜利的队长
                            case player:is_in_team(PS) andalso player:is_leader(PS) of
                                true ->
                                    % 总 帮战PK次数 + 1
                                    set_battle_pk_count(get_battle_pk_count() + 1),

                                    % 帮派的战斗次数+1
                                    GuildBattleGuldInfo_New = 
                                    case get_guild_battle_info_by_guild_id(player:get_guild_id(PS)) of
                                        GuildBattleGuldInfo when is_record(GuildBattleGuldInfo,guild_battle_guild_info) ->
                                            GuildBattleGuldInfo#guild_battle_guild_info{battle_count = GuildBattleGuldInfo#guild_battle_guild_info.battle_count + 1};
                                        _ ->
                                            #guild_battle_guild_info{
                                                rounds = get_rounds(),
                                                guild_id = player:get_guild_id(PS),
                                                battle_count = 1
                                            }
                                    end,

                                    update_guild_battle_guild_info_to_ets(GuildBattleGuldInfo_New),

                                    case lists:member( get_battle_pk_count(),[?GUILD_ALL_BATTLE_COUNT_TIPS1,?GUILD_ALL_BATTLE_COUNT_TIPS10,?GUILD_ALL_BATTLE_COUNT_TIPS50,?GUILD_ALL_BATTLE_COUNT_TIPS100,?GUILD_ALL_BATTLE_COUNT_TIPS200,?GUILD_ALL_BATTLE_COUNT_TIPS500,?GUILD_ALL_BATTLE_COUNT_TIPS1000,?GUILD_ALL_BATTLE_COUNT_TIPS2000,?GUILD_ALL_BATTLE_COUNT_TIPS5000]) of
                                        true ->
                                            mod_broadcast:send_sys_broadcast(202, 
                                                [
                                                    player:get_name(KillerId)
                                                    ,KillerId 
                                                    ,player:get_name(PS)
                                                    ,player:id(PS)
                                                    ,get_battle_pk_count()
                                                ]                                         
                                            );

                                        false ->
                                            skip
                                    end,

                                    skip;
                                false ->
                                    skip
                            end,
                        
                            % 增加胜利场数
                            case get_guild_battle_info_by_player_id(PlayerId) of
                                 GuildBattleInfo when is_record(GuildBattleInfo, guild_battle_player_info) ->
                                    % 原本的连胜次数
                                    OldStreak = GuildBattleInfo#guild_battle_player_info.winning_streak,
                                    OldWind = GuildBattleInfo#guild_battle_player_info.battle_win,

                                    % 终结
                                    case OldStreak > ?GUILD_SHUTDOWN of
                                        true ->
                                            mod_broadcast:send_sys_broadcast(201, [
                                                player:get_name(PS)
                                                ,player:id(PS)
                                                ,player:get_name(KillerId)
                                                ,KillerId]                                     
                                            );
                                        false ->
                                            skip
                                    end,

                                    % 连胜设置为0 失败次数+1
                                    NewGuildBattleInfo = GuildBattleInfo#guild_battle_player_info{
                                        battle_lose =  GuildBattleInfo#guild_battle_player_info.battle_lose + 1,
                                        winning_streak = 0
                                    },

                                    mod_guild_battle:add_guild_battle_info(NewGuildBattleInfo),
                                    void;
                                _ ->
                                    void
                            end,

                            % % 返回帮派
                            lib_guild_battle:enter_to_0(PS),

                            % 增加战功
                            % player:add_guild_feat(PS,Len * 1,[]);
                            void;
                        _ -> 
                            skip

                    end;

                false ->
                    skip
            end            
    end.

try_start_pk(PS, ObjPlayerId) ->
    case check_start_pk(PS, ObjPlayerId) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        ok ->
            case player:get_PS(ObjPlayerId) of
                TPS when is_record(TPS,player_status) ->

                    % 进入战斗将状态修改为闲置
                    case get_guild_battle_npc_by_usr_id(player:id(PS)) of
                        GuildBattleNpc when is_record(GuildBattleNpc,guild_battle_npc) ->
                            NewGuildBattleNpc = GuildBattleNpc#guild_battle_npc{use_player_id = 0,use_guild_id = 0},
                            mod_guild_battle:add_guild_battle_npc(NewGuildBattleNpc);
                        _ ->
                            ?DEBUG_MSG("Npc user id can not find the npc",[]),
                            skip
                    end, 

                    case get_guild_battle_npc_by_usr_id(ObjPlayerId) of
                        GuildBattleNpc1 when is_record(GuildBattleNpc1,guild_battle_npc) ->
                            NewGuildBattleNpc1 = GuildBattleNpc1#guild_battle_npc{use_player_id = 0,use_guild_id = 0},
                            mod_guild_battle:add_guild_battle_npc(NewGuildBattleNpc1);
                        _Other ->
                            ?DEBUG_MSG("Npc user id can not find the npc,~p",[_Other]),
                            skip
                    end, 

                    mod_battle:start_guild_war_pk(PS, TPS, fun pk_callback/2);
                _ ->
                    skip
            end
    end.

check_start_pk(PS, ObjPlayerId) ->
    try check_start_pk__(PS, ObjPlayerId) of
        ok -> ok
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

check_start_pk__(PS, ObjPlayerId) ->
    GuildId = player:get_guild_id(PS),
    ?Ifc (GuildId =:= ?INVALID_ID)
        throw(?PM_NOT_IN_GUILD)
    ?End,

    % 此处修改判断是否在帮战地图
    % ?Ifc (not lib_dungeon:is_in_guild_battle_dungeon(PS))
    %     throw(?PM_DUNGEON_OUSIDE)
    % ?End,

    ObjPS = player:get_PS(ObjPlayerId),
    ?Ifc (ObjPS =:= null)
        throw(?PM_TARGET_PLAYER_NOT_ONLINE)
    ?End,

    % % 此处修改判断是否在帮战地图
    % ?Ifc (not lib_dungeon:is_in_guild_battle_dungeon(ObjPS))
    %     throw(?PM_DUNGEON_OUSIDE)
    % ?End,

    ObjGuildId = player:get_guild_id(ObjPS),
    ?Ifc (ObjGuildId =:= ?INVALID_ID)
        throw(?PM_OBJ_NOT_IN_GUILD)
    ?End, 
    
    ?Ifc (GuildId =:= ObjGuildId)
        throw(?PM_GUILD_OBJ_IS_ONE_OF_US)   
    ?End,

    ok.

% ETS_GUILD_BATTLE_NPC
get_guild_battle_npc_by_id(NpcId) ->
    ?ASSERT(is_integer(NpcId), NpcId),
    Ret = case ets:lookup(?ETS_GUILD_BATTLE_NPC, NpcId) of
        [#guild_battle_npc{} = GuildBattleNpc] -> GuildBattleNpc;
        _ ->  % NPC数据尚未添加
            #guild_battle_npc{id = NpcId}
    end,
    Ret.

get_guild_battle_npc_by_usr_id(PlayerId) ->
    ?ASSERT(is_integer(PlayerId), PlayerId),
    
    TabList = ets:tab2list(?ETS_GUILD_BATTLE_NPC),
    Ret = lists:filter(fun(X) -> X#guild_battle_npc.use_player_id == PlayerId end, TabList),
    Ret1 = case length(Ret) > 0 of
        true ->
            case lists:last(Ret) of
                GuildBattleNpc when is_record(GuildBattleNpc,guild_battle_npc) ->
                    GuildBattleNpc;
                _Other -> 
                    ?DEBUG_MSG("O=~p",[_Other]),
                    null
            end;
        false -> null

    end,

    ?DEBUG_MSG("TabList = ~p,Ret = ~p,Ret1 = ~p,PlayerId=~p,",[TabList,Ret,Ret1,PlayerId]),
    Ret1.

add_guild_battle_npc(GuildBattleNpc) when is_record(GuildBattleNpc, guild_battle_npc) ->
    ets:insert(?ETS_GUILD_BATTLE_NPC, GuildBattleNpc).

%% 删除所有NPC
del_all_npc_data() ->
    List = ets:tab2list(?ETS_GUILD_BATTLE_NPC),

    F = fun(GuildBattleNpc, Acc) when is_record(GuildBattleNpc, guild_battle_npc) ->
        NpcId = GuildBattleNpc#guild_battle_npc.id,
        ets:delete(?ETS_GUILD_BATTLE_NPC, NpcId),

        Acc + 1
    end,

    lists:foldl(F,0,List).

% -------------------------------------------------------
get_guild_battle_history(Rounds) ->
    ?ASSERT(is_integer(Rounds), Rounds),
    Ret = case ets:lookup(?ETS_GUILD_BATTLE_HISTORY, Rounds) of
        [#guild_battle_history{} = GuildBattleHistory] -> GuildBattleHistory;
        _ ->  % 玩家不存在或者下线了
            null
    end,
    Ret.

%% 添加帮派的信息到ETS
add_guild_battle_history(GuildBattleHistory) when is_record(GuildBattleHistory, guild_battle_history) ->
    ets:insert(?ETS_GUILD_BATTLE_HISTORY, GuildBattleHistory).

%% 删除所有非当前轮次的ETS数据
del_all_old_battle_history() ->
    List = ets:tab2list(?ETS_GUILD_BATTLE_HISTORY),

    F = fun(GuildBattleHistory,Acc) when is_record(GuildBattleHistory, guild_battle_history) ->
        Rounds = GuildBattleHistory#guild_battle_history.rounds,
        ?Ifc (get_rounds() - Rounds > 5)
            ets:delete(?ETS_GUILD_BATTLE_HISTORY, Rounds)
        ?End,

        Acc + 1
    end,

    lists:foldl(F,0,List).

% -------------------------------------------------------
% 获取帮战 帮派信息
get_guild_battle_info_by_guild_id(GuildId) ->
    ?ASSERT(is_integer(GuildId), GuildId),
    Ret = case ets:lookup(?ETS_GUILD_BATTLE_GUILD_INFO, GuildId) of
        [#guild_battle_guild_info{} = GuildBattleInfo] -> GuildBattleInfo;
        _ ->  % 玩家不存在或者下线了
            GuildBattleGuldInfo_New = #guild_battle_guild_info{guild_id=GuildId,rounds=get_rounds()},
            add_guild_battle_guild_info(GuildBattleGuldInfo_New),
            GuildBattleGuldInfo_New
    end,
    Ret.

% 获取所有的参与帮派的id
get_all_guild_battle_info_guild_id() ->
    L = ets:tab2list(?ETS_GUILD_BATTLE_GUILD_INFO),
    [X#guild_battle_guild_info.guild_id || X <- L].

% 获取所有的玩家id
get_all_guild_battle_info_guild() ->
    ets:tab2list(?ETS_GUILD_BATTLE_GUILD_INFO).

%% 添加帮派的信息到ETS
add_guild_battle_guild_info(GuildBattleInfo) when is_record(GuildBattleInfo, guild_battle_guild_info) ->
    ets:insert(?ETS_GUILD_BATTLE_GUILD_INFO, GuildBattleInfo).

%% 删除所有非当前轮次的ETS数据
del_all_not_cur_rounds_guild_data() ->
    % 先保存到数据
    sava_all_guild_battle_guild_info_to_db(),
    List = ets:tab2list(?ETS_GUILD_BATTLE_GUILD_INFO),

    F = fun(GuildBattleInfo,Acc) when is_record(GuildBattleInfo, guild_battle_guild_info) ->
        Rounds = GuildBattleInfo#guild_battle_guild_info.rounds,
        GuildId = GuildBattleInfo#guild_battle_guild_info.guild_id,
        ?Ifc (Rounds /= get_rounds())
            ets:delete(?ETS_GUILD_BATTLE_GUILD_INFO, GuildId)
        ?End,

        Acc + 1
    end,

    lists:foldl(F,0,List).

%% 删除所有
del_all_guild_data() ->
    % 先保存到数据
    sava_all_guild_battle_guild_info_to_db(),
    List = ets:tab2list(?ETS_GUILD_BATTLE_GUILD_INFO),

    F = fun(GuildBattleInfo, Acc) when is_record(GuildBattleInfo, guild_battle_guild_info) ->
        GuildId = GuildBattleInfo#guild_battle_guild_info.guild_id,
        ets:delete(?ETS_GUILD_BATTLE_GUILD_INFO, GuildId),

        Acc + 1
    end,

    lists:foldl(F,0,List).

%% 保存数据到数据库
sava_all_guild_battle_guild_info_to_db() ->
    List = get_all_guild_battle_info_guild(),

    F = fun(GuildBattleInfo,Acc) ->
        lib_guild_battle:sava_guild_battle_guild_info_to_db(GuildBattleInfo),
        Acc + 1
    end,

    lists:foldl(F,0,List). 


% %% 更新玩家的帮战信息到ETS·
update_guild_battle_guild_info_to_ets(GuildBattleInfo) when is_record(GuildBattleInfo, guild_battle_guild_info) ->
    ets:insert(?ETS_GUILD_BATTLE_GUILD_INFO, GuildBattleInfo).


% -------------------------------------------------------

% 获取帮战 个人信息
get_guild_battle_info_by_player_id(PlayerId) ->
    ?ASSERT(is_integer(PlayerId), PlayerId),
    Ret = case ets:lookup(?ETS_GUILD_BATTLE_INFO, PlayerId) of
        [#guild_battle_player_info{} = GuildBattleInfo] -> GuildBattleInfo;
        _ ->  % 玩家不存在或者下线了
            GuildBattleInfo_New = #guild_battle_player_info{
            player_id=PlayerId,
            rounds=get_rounds(),
            guild_id = player:get_guild_id(PlayerId),
            guild_name = mod_guild:get_name_by_id(player:get_guild_id(PlayerId))
            },
            add_guild_battle_info(GuildBattleInfo_New),
            GuildBattleInfo_New
    end,
    Ret.

% 获取所有的玩家id
get_all_guild_battle_info_player_id() ->
    L = ets:tab2list(?ETS_GUILD_BATTLE_INFO),
    [X#guild_battle_player_info.player_id || X <- L].

% 获取所有的玩家id
get_all_guild_battle_info_player() ->
    ets:tab2list(?ETS_GUILD_BATTLE_INFO).

%% 添加玩家的信息到ETS
add_guild_battle_info(GuildBattleInfo) when is_record(GuildBattleInfo, guild_battle_player_info) ->
    ets:insert(?ETS_GUILD_BATTLE_INFO, GuildBattleInfo).

%% 删除所有非当前轮次的ETS数据
del_all_not_cur_rounds_data() ->
    % 先保存到数据
    sava_all_guild_battle_to_db(),
    List = ets:tab2list(?ETS_GUILD_BATTLE_INFO),

    F = fun(GuildBattleInfo,Acc) when is_record(GuildBattleInfo, guild_battle_player_info) ->
        Rounds = GuildBattleInfo#guild_battle_player_info.rounds,
        PlayerId = GuildBattleInfo#guild_battle_player_info.player_id,
        ?Ifc (Rounds /= get_rounds())
            ets:delete(?ETS_GUILD_BATTLE_INFO, PlayerId)
        ?End,

        Acc + 1
    end,

    lists:foldl(F,0,List).

%% 删除所有
del_all_data() ->
    % 先保存到数据
    sava_all_guild_battle_to_db(),
    List = ets:tab2list(?ETS_GUILD_BATTLE_INFO),

    F = fun(GuildBattleInfo, Acc) when is_record(GuildBattleInfo, guild_battle_player_info) ->
        % Rounds = GuildBattleInfo#guild_battle_info.rounds,
        PlayerId = GuildBattleInfo#guild_battle_player_info.player_id,
        ets:delete(?ETS_GUILD_BATTLE_INFO, PlayerId),

        Acc + 1
    end,

    lists:foldl(F,0,List).

%% 保存数据到数据库
sava_all_guild_battle_to_db() ->
    List = get_all_guild_battle_info_player(),

    F = fun(GuildBattleInfo,Acc) ->
        lib_guild_battle:sava_guild_battle_info_to_db(GuildBattleInfo),
        Acc + 1
    end,

    lists:foldl(F,0,List). 


% %% 更新玩家的帮战信息到ETS·
update_guild_battle_to_ets(GuildBattleInfo) when is_record(GuildBattleInfo, guild_battle_player_info) ->
    ets:insert(?ETS_GUILD_BATTLE_INFO, GuildBattleInfo).

%--------------------------------------------------------------------------------------------------------%
% -------------------------------------------------------------------------------------------

% 接口 设置帮战系统属性
set_rounds(Rounds) ->
    ets:insert(?ETS_GUILD_BATTLE_SYS, {?GUILD_BATTLE_ROUNDS, Rounds}).

%% 当前轮次
get_rounds() ->
    case ets:lookup(?ETS_GUILD_BATTLE_SYS, ?GUILD_BATTLE_ROUNDS) of
        [] -> 0;
        [{?GUILD_BATTLE_ROUNDS,Rounds}] when is_integer(Rounds) ->
            Rounds;
        _Other ->
            0
    end.

% 设置状态
set_state(State) ->
    ets:insert(?ETS_GUILD_BATTLE_SYS, {?GUILD_BATTLE_STATE, State}).

%% 当前状态
get_state() ->
    case ets:lookup(?ETS_GUILD_BATTLE_SYS, ?GUILD_BATTLE_STATE) of
        [] -> 0;
        [{?GUILD_BATTLE_STATE,State}] when is_integer(State) ->
            State;
        _Other ->
            ?DEBUG_MSG("_Other=~p",[_Other]),
            0
    end.

% 最后胜利帮派ID
set_last_guild_id(GuildId) ->
    ets:insert(?ETS_GUILD_BATTLE_SYS, {?LAST_WIN_GUILD_ID, GuildId}).

%% 最后胜利帮派ID
get_last_guild_id() ->
    case ets:lookup(?ETS_GUILD_BATTLE_SYS, ?LAST_WIN_GUILD_ID) of
        [] -> 0;
        [{?LAST_WIN_GUILD_ID,GuildId}] when is_integer(GuildId) ->
            GuildId;
        _Other ->
            0
    end.

% 最后拿走王座的玩家id
set_last_take_throne_id(PlayerId) ->
    ets:insert(?ETS_GUILD_BATTLE_SYS, {?LAST_TAKE_THRONE_PLAYER_ID, PlayerId}).

%% 获取当前轮次拿走王座的玩家id
get_last_take_throne_id() ->
    case ets:lookup(?ETS_GUILD_BATTLE_SYS, ?LAST_TAKE_THRONE_PLAYER_ID) of
        [] -> 0;
        [{?LAST_TAKE_THRONE_PLAYER_ID,PlayerId}] when is_integer(PlayerId) ->
            PlayerId;
        _Other ->
            0
    end.

% 帮战持续时间或者等待时间
set_time(Time) ->
    ets:insert(?ETS_GUILD_BATTLE_SYS, {?GUILD_BATTLE_TIME, Time}).

%% 当前轮次
get_time() ->
    case ets:lookup(?ETS_GUILD_BATTLE_SYS, ?GUILD_BATTLE_TIME) of
        [] -> 0;
        [{?GUILD_BATTLE_TIME,Time}] when is_integer(Time) ->
            Time;
        _Other ->
            0
    end.


% 帮战持续时间或者等待时间
set_battle_pk_count(Count) ->
    ets:insert(?ETS_GUILD_BATTLE_SYS, {?GUILD_BATTLE_PK_COUNT, Count}).

% 帮战的战斗成次数
get_battle_pk_count() ->
    case ets:lookup(?ETS_GUILD_BATTLE_SYS, ?GUILD_BATTLE_PK_COUNT) of
        [] -> 0;
        [{?GUILD_BATTLE_PK_COUNT,Time}] when is_integer(Time) ->
            Time;
        _Other ->
            0
    end.
    

% --------------------------------------------------------------
db_save() ->
    ?DEBUG_MSG("guild_battle sava",[]),
    mod_data:save(?SYS_GUILD_BATTLE, 
        #guild_battle_sys{
            rounds = get_rounds(),
            battle_state = get_state(),
            last_win_guild_id = get_last_guild_id(),
            last_take_throne_player_id = get_last_take_throne_id(),
            time = get_time()
        }),
    void.

% 加载数据
db_load() ->
    ?DEBUG_MSG("guild_battle load",[]),
    case mod_data:load(?SYS_GUILD_BATTLE) of
        [] ->
            % 如果没有配置信息则 则新增
            % 轮次1
            set_rounds(0),
            % 算结束了
            set_state(2),
            set_last_guild_id(0),
            set_last_take_throne_id(0),
            set_time(0),
            set_battle_pk_count(0),

            ok;

        [#guild_battle_sys{
            rounds=Rounds,
            battle_state=State,
            last_win_guild_id = LastWinGuildId,
            last_take_throne_player_id = LastTakeThronePlayerId,
            time = Time,
            count = Count
        }] ->
            set_rounds(Rounds),
            set_state(State),
            set_last_guild_id(LastWinGuildId),
            set_last_take_throne_id(LastTakeThronePlayerId),
            set_time(Time),
            set_battle_pk_count(Count),

            ok;
        _Other ->
            ?ASSERT(false, _Other),
            fail
    end,

    void.    

% 帮战开始
guild_battle_open() ->
    % 第N界帮派战开始
    mod_broadcast:send_sys_broadcast(182, [get_rounds()]),

    del_all_npc_data(),
    del_all_guild_data(),
    del_all_data(),

    set_state(?GUILD_BATTLE_OPEN),
    void.

% 帮战开始
guild_battle_begin() ->
    % 轮次+1
    Rounds = get_rounds(),

    set_rounds(Rounds + 1),
    set_last_guild_id(0),
    set_last_take_throne_id(0),

    % 删除所有非当前的战报
    del_all_not_cur_rounds_data(),
    set_state(?GUILD_BATTLE_WAIT).

% 随机奖励分配
guild_battle_random_reward(GuildId) ->
    List = get_all_guild_battle_info_player_id(),
    
    F1 = fun(Player_id,Acc) ->
        % 不在线发邮件 在不在线都发邮件
        GuildBattleInfo = get_guild_battle_info_by_player_id(Player_id),
        % 在战场时间
        EnterTime = GuildBattleInfo#guild_battle_player_info.enter1_time + GuildBattleInfo#guild_battle_player_info.enter2_time + GuildBattleInfo#guild_battle_player_info.enter3_time,
        MyGuildId = GuildBattleInfo#guild_battle_player_info.guild_id,

        % 帮派繁荣度增加 战斗胜利 * 2 + 连胜次数 * 5 + 战斗失败 * 1
        AddValue = 
        GuildBattleInfo#guild_battle_player_info.battle_win * 2 +
        GuildBattleInfo#guild_battle_player_info.max_winning_streak * 5 + 
        GuildBattleInfo#guild_battle_player_info.battle_lose * 1,

        % 给帮派增加繁荣度
        mod_guild_mgr:add_prosper(GuildBattleInfo#guild_battle_player_info.guild_id, AddValue),

        % 固定奖励部分 
        RewardExtCount = 
        AddValue * 5 + 
        case MyGuildId of
            GuildId ->
                case mod_guild:is_chief(Player_id) of
                    true ->
                        ?GUILD_BATTLE_KING_CHIEF_CONTRI;
                    false ->
                        ?GUILD_BATTLE_KING_MEN_CONTRI
                end;
            _ ->
                case mod_guild:is_chief(Player_id) of
                    true ->
                        ?GUILD_BATTLE_CHIEF_CONTRI;
                    false ->
                        ?GUILD_BATTLE_MEN_CONTRI
                end
        end,

        RewardId = 
        case EnterTime > ?GUILD_BATTLE_REWARD_NEED_TIME3 of
            true ->
                % ?GUILD_BATTLE_REWARD_ID3;
                lib_guild_battle:calc_reward_by_class(3);
            false ->
                case EnterTime > ?GUILD_BATTLE_REWARD_NEED_TIME2 of
                    true ->
                        lib_guild_battle:calc_reward_by_class(2);
                    false ->
                        case EnterTime > ?GUILD_BATTLE_REWARD_NEED_TIME1 of
                            true ->
                                lib_guild_battle:calc_reward_by_class(1);
                            false ->
                                0
                        end
                end
        end,

        RewardId2 = 
        case EnterTime > ?GUILD_BATTLE_REWARD_NEED_TIME3 of
            true ->
                % ?GUILD_BATTLE_REWARD_ID3;
                lib_guild_battle:calc_reward_by_class(3);
            false ->
                case EnterTime > ?GUILD_BATTLE_REWARD_NEED_TIME2 of
                    true ->
                        lib_guild_battle:calc_reward_by_class(2);
                    false ->
                        case EnterTime > ?GUILD_BATTLE_REWARD_NEED_TIME1 of
                            true ->
                                lib_guild_battle:calc_reward_by_class(1);
                            false ->
                                0
                        end
                end
        end,

        RewardId3 = 
        case EnterTime > ?GUILD_BATTLE_REWARD_NEED_TIME3 of
            true ->
                % ?GUILD_BATTLE_REWARD_ID3;
                lib_guild_battle:calc_reward_by_class(3);
            false ->
                case EnterTime > ?GUILD_BATTLE_REWARD_NEED_TIME2 of
                    true ->
                        lib_guild_battle:calc_reward_by_class(2);
                    false ->
                        case EnterTime > ?GUILD_BATTLE_REWARD_NEED_TIME1 of
                            true ->
                                lib_guild_battle:calc_reward_by_class(1);
                            false ->
                                0
                        end
                end
        end,

        case RewardId of
            0 ->
                skip;
            _ ->
                #reward_dtl{calc_goods_list=GList} = mod_reward_pool:calc_reward(RewardId, Player_id),
                % 帮派战参与奖励翻3倍
                #reward_dtl{calc_goods_list=GList1} = mod_reward_pool:calc_reward(RewardId2, Player_id),
                #reward_dtl{calc_goods_list=GList2} = mod_reward_pool:calc_reward(RewardId3, Player_id),
                % GList = [],
                Goods = GList ++GList1++GList2 ++ [{?VGOODS_CONTRI,RewardExtCount}],

                Title = <<"帮派战奖励">>,
                Content = list_to_binary(
                    io_lib:format(
                        <<"您在~p届帮战中奋战~p分钟,您为帮派做出了突出贡献,特此为您送上奖励！">>, 
                        [
                            get_rounds(), 
                            util:ceil(EnterTime / 60)
                        ]
                    )
                ),

                lib_mail:send_sys_mail(Player_id, Title, 
                Content, 
                Goods, [?LOG_MAIL, "guild_battle"]),

                skip                    
        end,

        Acc
    end,
    lists:foldl(F1, [],List),

    void.

guild_battle_end() ->

    WinGuildName = <<"系统">>,
    GuildId = 0,
    PlayerId = 0,
    PlayerName = <<"系统">>,

    set_last_guild_id(0),
    set_last_take_throne_id(0),
    set_state(?GUILD_BATTLE_END),
    % 发放公告结束
    mod_broadcast:send_sys_broadcast(296, []),

    % 全部玩家发放奖励
    guild_battle_random_reward(-1),

    % 玩家信息处理
    List = get_all_guild_battle_info_player_id(),
    % 帮派信息处理
    GuildList = get_all_guild_battle_info_guild_id(),

    {Scene1,_,_} =  ?GUILD_ENTER1_CONFIG,
    {Scene2,_,_} =  ?GUILD_ENTER2_CONFIG,
    {Scene3,_,_} =  ?GUILD_ENTER3_CONFIG,

    % 传送回城先回去
    FBackfun = fun(Player_id) ->
        % 可能有些已经下线
        case player:get_PS(Player_id) of
            PS when is_record(PS,player_status) ->
                % 传回城
                case lists:member(player:get_scene_id(PS),[Scene1,Scene2,Scene3]) of
                    true ->
                        lib_guild_battle:enter_to_0(PS);    
                    _Other1 ->
                        skip
                end;                
            _ ->
                {SceneId, X, Y} = ?REBORN_POS_OF_MAIN_CITY,

                NewPos = player:remake_position_rd(Player_id, SceneId, X, Y), % 把玩家移到原先保存的位置
                ply_tmplogout_cache:set_position(Player_id, NewPos),
                void
        end
    end,
    lists:foreach(FBackfun,List),

    FPlayerStatistics = fun(Player_id,
        {
            {Better_fighter_player_id_,WinCount},
            {Better_touch_throne_player_id_,TouchCount},
            {Better_trouble_player_id_,InterruptCount},
            {Better_streak_player_id_,MaxStreak},
            {Better_defend_player_id_,Enter3Time},
            {Better_try_player_id_,LostCount}
        } = Acc
    ) ->
        GuildBattleInfo = get_guild_battle_info_by_player_id(Player_id),

        % 战斗胜利次数最多
        {NewBetter_fighter_player_id_,NewWinCount} =
        case GuildBattleInfo#guild_battle_player_info.battle_win > WinCount of
            true ->
                {Player_id,GuildBattleInfo#guild_battle_player_info.battle_win};
            false ->
            {Better_fighter_player_id_,WinCount}
        end,

        % 触摸王座最多
        {NewBetter_touch_throne_player_id_,NewTouchCount} = 
        case GuildBattleInfo#guild_battle_player_info.touch_throne > TouchCount of
            true ->
                {Player_id,GuildBattleInfo#guild_battle_player_info.touch_throne};
            false ->
            {Better_touch_throne_player_id_,TouchCount}
        end,

        % 打断敌人最多
        {NewBetter_trouble_player_id_,NewInterruptCount} = 
        case GuildBattleInfo#guild_battle_player_info.interrupt_load > InterruptCount of
            true ->
                {Player_id,GuildBattleInfo#guild_battle_player_info.interrupt_load};
            false ->
            {Better_trouble_player_id_,InterruptCount}
        end,

        % 最大连杀数
        {NewBetter_streak_player_id_,NewMaxStreak} = 
        case GuildBattleInfo#guild_battle_player_info.max_winning_streak > MaxStreak of
            true ->
                {Player_id,GuildBattleInfo#guild_battle_player_info.max_winning_streak};
            false ->
            {Better_streak_player_id_,MaxStreak}
        end,

        % 第三区域停留时间
        {NewBetter_defend_player_id_,NewEnter3Time} = 
        case GuildBattleInfo#guild_battle_player_info.enter3_time > Enter3Time of
            true ->
                {Player_id,GuildBattleInfo#guild_battle_player_info.enter3_time};
            false ->
            {Better_defend_player_id_,Enter3Time}
        end,

        % 失败次数最多的玩家
        {NewBetter_try_player_id_,NewLostCount} = 
        case GuildBattleInfo#guild_battle_player_info.battle_lose > LostCount of
            true ->
                {Player_id,GuildBattleInfo#guild_battle_player_info.battle_lose};
            false ->
            {Better_try_player_id_,LostCount}
        end,

        % 计算积分
        % 战斗胜利次数
        Battle_win_Point = GuildBattleInfo#guild_battle_player_info.battle_win,
        % 战斗失败次数 
        Battle_lose_Point = GuildBattleInfo#guild_battle_player_info.battle_lose,
        % 打断别人读条次数 
        Interrupt_load_Point = GuildBattleInfo#guild_battle_player_info.interrupt_load,
        % 进入第三区域次数 
        Enter3_count_Point = GuildBattleInfo#guild_battle_player_info.enter3_count,
        % 进入第二区域次数 
        Enter2_count_Point = GuildBattleInfo#guild_battle_player_info.enter2_count,
        % 第三区域停留时间 
        Enter3_time_Point = GuildBattleInfo#guild_battle_player_info.enter3_time,
        % 在第二区域停留时间 
        Enter2_time_Point = GuildBattleInfo#guild_battle_player_info.enter2_time,
        % 最大连杀数
        Max_winning_streak_Point = GuildBattleInfo#guild_battle_player_info.max_winning_streak,
        
        % 计算积分
        Point = 
        util:ceil(
            (Battle_win_Point * 3 + Battle_lose_Point * 2 + 
            Interrupt_load_Point * 2 + 
            Enter3_count_Point * 30 + Enter2_count_Point * 10 +
            Enter3_time_Point * 0.1 + Enter2_time_Point * 0.05) *
            (1 + util:minmax(Max_winning_streak_Point/50,0,1))
        ),

        % 更新积分信息
        NewGuildBattleInfo = GuildBattleInfo#guild_battle_player_info{point = Point},
        update_guild_battle_to_ets(NewGuildBattleInfo),

        {
            {NewBetter_fighter_player_id_,NewWinCount},
            {NewBetter_touch_throne_player_id_,NewTouchCount},
            {NewBetter_trouble_player_id_,NewInterruptCount},
            {NewBetter_streak_player_id_,NewMaxStreak},
            {NewBetter_defend_player_id_,NewEnter3Time},
            {NewBetter_try_player_id_,NewLostCount}
        }
    end,

    % 玩家信息 最佳统计
    {
        {Better_fighter_player_id,_},
        {Better_touch_throne_player_id,_},
        {Better_trouble_player_id,_},
        {Better_streak_player_id,_},
        {Better_defend_player_id,_},
        {Better_try_player_id,_}

    } = lists:foldl(FPlayerStatistics, {{0,-1},
                    {0,-1},
                    {0,-1},
                    {0,-1},
                    {0,-1},
                    {0,-1}}
                    ,List),

    % 帮派信息 最佳统计
    FGuildStatistics = fun(GuildId,
        {
            {
                Join_battle_max_rate_guild_id_,
                Join_battle_max_rate_
            },
            {
                Join_battle_max_count_guild_id_,
                Join_battle_max_count_
            }
        }
        = Acc) ->

        GuildBattleGuildInfo = get_guild_battle_info_by_guild_id(GuildId),

        % 参与率等于参战人数/帮派人数
        MyGuildJoinCount = GuildBattleGuildInfo#guild_battle_guild_info.join_battle_player_count,
        MyGuildRate = MyGuildJoinCount / length(mod_guild:get_member_id_list(GuildId)),

        {NewJoin_battle_max_rate_guild_id,NewJoin_battle_max_rate} = 
        case MyGuildRate > Join_battle_max_rate_ of
            true ->
                {GuildId,MyGuildRate};
            false ->
                {Join_battle_max_rate_guild_id_,Join_battle_max_rate_}
        end,

        {NewJoin_battle_max_count_guild_id,NewJoin_battle_max_count} =
        case MyGuildJoinCount > Join_battle_max_count_ of
            true ->
                {GuildId,MyGuildJoinCount};
            false ->
                {Join_battle_max_count_guild_id_,Join_battle_max_count_}
        end,

        % Battle
        Battle_count =  GuildBattleGuildInfo#guild_battle_guild_info.battle_count,
        Battle_win_count =  GuildBattleGuildInfo#guild_battle_guild_info.battle_win_count,
        Touch_throne =  GuildBattleGuildInfo#guild_battle_guild_info.touch_throne,

        % 计算积分
        Point = 
        util:ceil(
            (MyGuildJoinCount * MyGuildRate) * 100 + Battle_count * 2 + Battle_win_count * 10 + Touch_throne * 20
        ),

        % 更新积分信息
        NewGuildBattleGuildInfo = GuildBattleGuildInfo#guild_battle_guild_info{point = Point},
        update_guild_battle_guild_info_to_ets(NewGuildBattleGuildInfo),

        {
            {NewJoin_battle_max_rate_guild_id,NewJoin_battle_max_rate},
            {NewJoin_battle_max_count_guild_id,NewJoin_battle_max_count}
        }
    end,

    {
        {
            Join_battle_max_rate_guild_id,
            Join_battle_max_rate
        },
        {
            Join_battle_max_count_guild_id,
            Join_battle_max_count
        }
    } = lists:foldl(FGuildStatistics,{{0,-1},{0,-1}},GuildList),

    % 统计帮战信息 这条战报信息要推送给所有在线玩家
    GuildBattleHistory = #guild_battle_history{
        rounds = get_rounds(),
        join_battle_player_count = length(List),
        join_battle_guild_count = length(GuildList),

        better_fighter_name = player:get_name(Better_fighter_player_id),
        better_fighter_player_id = Better_fighter_player_id,

        better_touch_throne_name = player:get_name(Better_touch_throne_player_id),
        better_touch_throne_player_id = Better_touch_throne_player_id,

        better_trouble_name = player:get_name(Better_trouble_player_id),
        better_trouble_player_id = Better_trouble_player_id,

        better_streak_name = player:get_name(Better_streak_player_id),
        better_streak_player_id = Better_streak_player_id,

        better_defend_name = player:get_name(Better_defend_player_id),
        better_defend_player_id = Better_defend_player_id,

        better_try_name = player:get_name(Better_try_player_id),
        better_try_player_id = Better_try_player_id,

        join_battle_max_rate = Join_battle_max_rate,
        join_battle_max_rate_guild_id = Join_battle_max_rate_guild_id,
        join_battle_max_rate_guild_name = mod_guild:get_name_by_id(Join_battle_max_rate_guild_id),
        join_battle_max_count = Join_battle_max_count,
        join_battle_max_count_guild_id = Join_battle_max_count_guild_id,
        join_battle_max_count_guild_name = mod_guild:get_name_by_id(Join_battle_max_count_guild_id),

        win_guild_name = WinGuildName,
        win_guild_id = GuildId,
        take_throne_player_id = PlayerId,
        take_throne_player_name = PlayerName
    },

    % 保存历史记录到数据库
    lib_guild_battle:save_guild_battle_history_to_db(GuildBattleHistory),
    % add_guild_battle_history(GuildBattleHistory),
    lib_guild_battle:send_result_to_all_online_player(GuildBattleHistory),

    % 玩家排序
    ListPlayer = get_all_guild_battle_info_player(),
    % 排序
    F1 = fun(A, B) -> 
        if 
            A#guild_battle_player_info.point > B#guild_battle_player_info.point ->
                true;
            A#guild_battle_player_info.point =:= B#guild_battle_player_info.point ->
                A#guild_battle_player_info.max_winning_streak > B#guild_battle_player_info.max_winning_streak;
            A#guild_battle_player_info.max_winning_streak =:= B#guild_battle_player_info.max_winning_streak ->
                A#guild_battle_player_info.battle_win > B#guild_battle_player_info.battle_win;
            true ->
                false
        end
    end,
    ListPlayer2 = lists:sort(F1, ListPlayer),

    FSetRank = fun(GuildBattleInfo,Acc) ->
        NewGuildBattleInfo = GuildBattleInfo#guild_battle_player_info{rank = Acc},
        update_guild_battle_to_ets(NewGuildBattleInfo),
        Acc + 1
    end,

    lists:foldl(FSetRank,1,ListPlayer2),

    % 帮派排序
    ListGuild = get_all_guild_battle_info_guild(),
    F2 = fun(A, B) -> 
        if 
            A#guild_battle_guild_info.point > B#guild_battle_guild_info.point ->
                true;
            A#guild_battle_guild_info.point =:= B#guild_battle_guild_info.point ->
                A#guild_battle_guild_info.join_battle_player_count > B#guild_battle_guild_info.join_battle_player_count;
            A#guild_battle_guild_info.join_battle_player_count =:= B#guild_battle_guild_info.join_battle_player_count ->
                A#guild_battle_guild_info.battle_win_count > B#guild_battle_guild_info.battle_win_count;
            true ->
                false
        end
    end,

    ListGuild2 = lists:sort(F2, ListGuild),
    FSetGuildRank = fun(GuildBattleGuldInfo,Acc) ->
        NewGuildBattleGulidInfo = GuildBattleGuldInfo#guild_battle_guild_info{rank = Acc},
        update_guild_battle_guild_info_to_ets(NewGuildBattleGulidInfo),
        Acc + 1
    end,
    lists:foldl(FSetGuildRank,1,ListGuild2),    

    del_all_data(), 
    del_all_guild_data(),   
    void.


% 帮战结束
guild_battle_end(GuildId,PlayerId) ->
    set_last_guild_id(GuildId),
    set_last_take_throne_id(PlayerId),
    set_state(?GUILD_BATTLE_END),

    % 队长PS获得王座的
    PS = player:get_PS(PlayerId),
    TeamId = player:get_team_id(PS),
    ListTeam = mod_team:get_all_member_id_list(TeamId),

    % 给玩家发放称号
    FTake = fun(PlayerId) ->
        % 发放称号
        lib_offcast:cast(PlayerId, {add_title, ?GUILD_BATTLE_TITLE_TAKE, util:unixtime()})
    end,
    lists:foreach(FTake,ListTeam),

    % 给获得帮派战胜利的玩家发放称号
    FGuildMem = fun(PlayerId) ->
        % 发放称号 帮主与普通玩家不一样
        case mod_guild:is_chief(PlayerId) of
            true ->
                PoolReward = mod_reward_pool:calc_reward(?GUILD_BATTLE_REWARD_ID_KING, PlayerId),
                ?DEBUG_MSG("PoolReward=~p",[PoolReward]),
                #reward_dtl{calc_goods_list=GList} = PoolReward,
                
                % GList = [],

                Title = <<"帮派战奖励">>,
                Content = list_to_binary(
                    io_lib:format(
                        <<"在您的领导下您的帮派获得了~p届帮战的王座！">>, 
                        [
                            get_rounds()
                        ]
                    )
                ),

                lib_mail:send_sys_mail(PlayerId, Title, 
                Content, 
                GList, [?LOG_MAIL, "guild_battle"]),
                
                lib_offcast:cast(PlayerId, {add_title, ?GUILD_BATTLE_TITLE_KING, util:unixtime()});
            false ->
                PoolReward = mod_reward_pool:calc_reward(?GUILD_BATTLE_REWARD_ID_MEM, PlayerId),
                ?DEBUG_MSG("PoolReward=~p",[PoolReward]),
                #reward_dtl{calc_goods_list=GList} = PoolReward,
                % GList = [],

                Title = <<"帮派战奖励">>,
                Content = list_to_binary(
                    io_lib:format(
                        <<"在~p届帮战中，您的帮派夺得王座！">>, 
                        [
                            get_rounds()
                        ]
                    )
                ),

                lib_mail:send_sys_mail(PlayerId, Title, 
                Content, 
                GList, [?LOG_MAIL, "guild_battle"]),

                lib_offcast:cast(PlayerId, {add_title, ?GUILD_BATTLE_TITLE_MEM, util:unixtime()})
        end
    end,

    % 获得胜利的帮派成员列表
    ListMen = mod_guild:get_member_id_list(GuildId),
    lists:foreach(FGuildMem,ListMen),
    WinGuildName = mod_guild:get_name_by_id(GuildId),

    % 发放公告结束
    mod_broadcast:send_sys_broadcast(189, [WinGuildName,player:get_name(PS),PlayerId]),

    % 全部玩家发放奖励
    guild_battle_random_reward(GuildId),

    % 玩家信息处理
    List = get_all_guild_battle_info_player_id(),
    % 帮派信息处理
    GuildList = get_all_guild_battle_info_guild_id(),

    {Scene1,_,_} =  ?GUILD_ENTER1_CONFIG,
    {Scene2,_,_} =  ?GUILD_ENTER2_CONFIG,
    {Scene3,_,_} =  ?GUILD_ENTER3_CONFIG,

    % 传送回城先回去
    FBackfun = fun(Player_id) ->
        % 可能有些已经下线
        case player:get_PS(Player_id) of
            PS when is_record(PS,player_status) ->
                % 传回城
                case lists:member(player:get_scene_id(PS),[Scene1,Scene2,Scene3]) of
                    true ->
                        lib_guild_battle:enter_to_0(PS);    
                    _Other1 ->
                        skip
                end;                
            _ ->
                {SceneId, X, Y} = ?REBORN_POS_OF_MAIN_CITY,

                NewPos = player:remake_position_rd(Player_id, SceneId, X, Y), % 把玩家移到原先保存的位置
                ply_tmplogout_cache:set_position(Player_id, NewPos),
                void
        end
    end,
    lists:foreach(FBackfun,List),

    FPlayerStatistics = fun(Player_id,
        {
            {Better_fighter_player_id_,WinCount},
            {Better_touch_throne_player_id_,TouchCount},
            {Better_trouble_player_id_,InterruptCount},
            {Better_streak_player_id_,MaxStreak},
            {Better_defend_player_id_,Enter3Time},
            {Better_try_player_id_,LostCount}
        } = Acc
    ) ->
        GuildBattleInfo = get_guild_battle_info_by_player_id(Player_id),

        % 战斗胜利次数最多
        {NewBetter_fighter_player_id_,NewWinCount} =
        case GuildBattleInfo#guild_battle_player_info.battle_win > WinCount of
            true ->
                {Player_id,GuildBattleInfo#guild_battle_player_info.battle_win};
            false ->
            {Better_fighter_player_id_,WinCount}
        end,

        % 触摸王座最多
        {NewBetter_touch_throne_player_id_,NewTouchCount} = 
        case GuildBattleInfo#guild_battle_player_info.touch_throne > TouchCount of
            true ->
                {Player_id,GuildBattleInfo#guild_battle_player_info.touch_throne};
            false ->
            {Better_touch_throne_player_id_,TouchCount}
        end,

        % 打断敌人最多
        {NewBetter_trouble_player_id_,NewInterruptCount} = 
        case GuildBattleInfo#guild_battle_player_info.interrupt_load > InterruptCount of
            true ->
                {Player_id,GuildBattleInfo#guild_battle_player_info.interrupt_load};
            false ->
            {Better_trouble_player_id_,InterruptCount}
        end,

        % 最大连杀数
        {NewBetter_streak_player_id_,NewMaxStreak} = 
        case GuildBattleInfo#guild_battle_player_info.max_winning_streak > MaxStreak of
            true ->
                {Player_id,GuildBattleInfo#guild_battle_player_info.max_winning_streak};
            false ->
            {Better_streak_player_id_,MaxStreak}
        end,

        % 第三区域停留时间
        {NewBetter_defend_player_id_,NewEnter3Time} = 
        case GuildBattleInfo#guild_battle_player_info.enter3_time > Enter3Time of
            true ->
                {Player_id,GuildBattleInfo#guild_battle_player_info.enter3_time};
            false ->
            {Better_defend_player_id_,Enter3Time}
        end,

        % 失败次数最多的玩家
        {NewBetter_try_player_id_,NewLostCount} = 
        case GuildBattleInfo#guild_battle_player_info.battle_lose > LostCount of
            true ->
                {Player_id,GuildBattleInfo#guild_battle_player_info.battle_lose};
            false ->
            {Better_try_player_id_,LostCount}
        end,

        % 计算积分
        % 战斗胜利次数
        Battle_win_Point = GuildBattleInfo#guild_battle_player_info.battle_win,
        % 战斗失败次数 
        Battle_lose_Point = GuildBattleInfo#guild_battle_player_info.battle_lose,
        % 打断别人读条次数 
        Interrupt_load_Point = GuildBattleInfo#guild_battle_player_info.interrupt_load,
        % 进入第三区域次数 
        Enter3_count_Point = GuildBattleInfo#guild_battle_player_info.enter3_count,
        % 进入第二区域次数 
        Enter2_count_Point = GuildBattleInfo#guild_battle_player_info.enter2_count,
        % 第三区域停留时间 
        Enter3_time_Point = GuildBattleInfo#guild_battle_player_info.enter3_time,
        % 在第二区域停留时间 
        Enter2_time_Point = GuildBattleInfo#guild_battle_player_info.enter2_time,
        % 最大连杀数
        Max_winning_streak_Point = GuildBattleInfo#guild_battle_player_info.max_winning_streak,
        
        % 计算积分
        Point = 
        util:ceil(
            (Battle_win_Point * 3 + Battle_lose_Point * 2 + 
            Interrupt_load_Point * 2 + 
            Enter3_count_Point * 30 + Enter2_count_Point * 10 +
            Enter3_time_Point * 0.1 + Enter2_time_Point * 0.05) *
            (1 + util:minmax(Max_winning_streak_Point/50,0,1))
        ),

        % 更新积分信息
        NewGuildBattleInfo = GuildBattleInfo#guild_battle_player_info{point = Point},
        update_guild_battle_to_ets(NewGuildBattleInfo),

        {
            {NewBetter_fighter_player_id_,NewWinCount},
            {NewBetter_touch_throne_player_id_,NewTouchCount},
            {NewBetter_trouble_player_id_,NewInterruptCount},
            {NewBetter_streak_player_id_,NewMaxStreak},
            {NewBetter_defend_player_id_,NewEnter3Time},
            {NewBetter_try_player_id_,NewLostCount}
        }
    end,

    % 玩家信息 最佳统计
    {
        {Better_fighter_player_id,_},
        {Better_touch_throne_player_id,_},
        {Better_trouble_player_id,_},
        {Better_streak_player_id,_},
        {Better_defend_player_id,_},
        {Better_try_player_id,_}

    } = lists:foldl(FPlayerStatistics, {{0,-1},
                    {0,-1},
                    {0,-1},
                    {0,-1},
                    {0,-1},
                    {0,-1}}
                    ,List),

    % 帮派信息 最佳统计
    FGuildStatistics = fun(GuildId,
        {
            {
                Join_battle_max_rate_guild_id_,
                Join_battle_max_rate_
            },
            {
                Join_battle_max_count_guild_id_,
                Join_battle_max_count_
            }
        }
        = Acc) ->

        GuildBattleGuildInfo = get_guild_battle_info_by_guild_id(GuildId),

        % 参与率等于参战人数/帮派人数
        MyGuildJoinCount = GuildBattleGuildInfo#guild_battle_guild_info.join_battle_player_count,
        MyGuildRate = MyGuildJoinCount / length(mod_guild:get_member_id_list(GuildId)),

        {NewJoin_battle_max_rate_guild_id,NewJoin_battle_max_rate} = 
        case MyGuildRate > Join_battle_max_rate_ of
            true ->
                {GuildId,MyGuildRate};
            false ->
                {Join_battle_max_rate_guild_id_,Join_battle_max_rate_}
        end,

        {NewJoin_battle_max_count_guild_id,NewJoin_battle_max_count} =
        case MyGuildJoinCount > Join_battle_max_count_ of
            true ->
                {GuildId,MyGuildJoinCount};
            false ->
                {Join_battle_max_count_guild_id_,Join_battle_max_count_}
        end,

        % Battle
        Battle_count =  GuildBattleGuildInfo#guild_battle_guild_info.battle_count,
        Battle_win_count =  GuildBattleGuildInfo#guild_battle_guild_info.battle_win_count,
        Touch_throne =  GuildBattleGuildInfo#guild_battle_guild_info.touch_throne,

        % 计算积分
        Point = 
        util:ceil(
            (MyGuildJoinCount * MyGuildRate) * 100 + Battle_count * 2 + Battle_win_count * 10 + Touch_throne * 20
        ),

        % 更新积分信息
        NewGuildBattleGuildInfo = GuildBattleGuildInfo#guild_battle_guild_info{point = Point},
        update_guild_battle_guild_info_to_ets(NewGuildBattleGuildInfo),

        {
            {NewJoin_battle_max_rate_guild_id,NewJoin_battle_max_rate},
            {NewJoin_battle_max_count_guild_id,NewJoin_battle_max_count}
        }
    end,

    {
        {
            Join_battle_max_rate_guild_id,
            Join_battle_max_rate
        },
        {
            Join_battle_max_count_guild_id,
            Join_battle_max_count
        }
    } = lists:foldl(FGuildStatistics,{{0,-1},{0,-1}},GuildList),

    % 统计帮战信息 这条战报信息要推送给所有在线玩家
    GuildBattleHistory = #guild_battle_history{
        rounds = get_rounds(),
        join_battle_player_count = length(List),
        join_battle_guild_count = length(GuildList),

        better_fighter_name = player:get_name(Better_fighter_player_id),
        better_fighter_player_id = Better_fighter_player_id,

        better_touch_throne_name = player:get_name(Better_touch_throne_player_id),
        better_touch_throne_player_id = Better_touch_throne_player_id,

        better_trouble_name = player:get_name(Better_trouble_player_id),
        better_trouble_player_id = Better_trouble_player_id,

        better_streak_name = player:get_name(Better_streak_player_id),
        better_streak_player_id = Better_streak_player_id,

        better_defend_name = player:get_name(Better_defend_player_id),
        better_defend_player_id = Better_defend_player_id,

        better_try_name = player:get_name(Better_try_player_id),
        better_try_player_id = Better_try_player_id,

        join_battle_max_rate = Join_battle_max_rate,
        join_battle_max_rate_guild_id = Join_battle_max_rate_guild_id,
        join_battle_max_rate_guild_name = mod_guild:get_name_by_id(Join_battle_max_rate_guild_id),
        join_battle_max_count = Join_battle_max_count,
        join_battle_max_count_guild_id = Join_battle_max_count_guild_id,
        join_battle_max_count_guild_name = mod_guild:get_name_by_id(Join_battle_max_count_guild_id),

        win_guild_name = WinGuildName,
        win_guild_id = GuildId,
        take_throne_player_id = PlayerId,
        take_throne_player_name = player:get_name(PS)
    },

    % 保存历史记录到数据库
    lib_guild_battle:save_guild_battle_history_to_db(GuildBattleHistory),
    % add_guild_battle_history(GuildBattleHistory),
    lib_guild_battle:send_result_to_all_online_player(GuildBattleHistory),

    % 玩家排序
    ListPlayer = get_all_guild_battle_info_player(),
    % 排序
    F1 = fun(A, B) -> 
        if 
            A#guild_battle_player_info.point > B#guild_battle_player_info.point ->
                true;
            A#guild_battle_player_info.point =:= B#guild_battle_player_info.point ->
                A#guild_battle_player_info.max_winning_streak > B#guild_battle_player_info.max_winning_streak;
            A#guild_battle_player_info.max_winning_streak =:= B#guild_battle_player_info.max_winning_streak ->
                A#guild_battle_player_info.battle_win > B#guild_battle_player_info.battle_win;
            true ->
                false
        end
    end,
    ListPlayer2 = lists:sort(F1, ListPlayer),

    FSetRank = fun(GuildBattleInfo,Acc) ->
        NewGuildBattleInfo = GuildBattleInfo#guild_battle_player_info{rank = Acc},
        update_guild_battle_to_ets(NewGuildBattleInfo),
        Acc + 1
    end,

    lists:foldl(FSetRank,1,ListPlayer2),

    % 帮派排序
    ListGuild = get_all_guild_battle_info_guild(),
    F2 = fun(A, B) -> 
        if 
            A#guild_battle_guild_info.point > B#guild_battle_guild_info.point ->
                true;
            A#guild_battle_guild_info.point =:= B#guild_battle_guild_info.point ->
                A#guild_battle_guild_info.join_battle_player_count > B#guild_battle_guild_info.join_battle_player_count;
            A#guild_battle_guild_info.join_battle_player_count =:= B#guild_battle_guild_info.join_battle_player_count ->
                A#guild_battle_guild_info.battle_win_count > B#guild_battle_guild_info.battle_win_count;
            true ->
                false
        end
    end,

    ListGuild2 = lists:sort(F2, ListGuild),
    FSetGuildRank = fun(GuildBattleGuldInfo,Acc) ->
        NewGuildBattleGulidInfo = GuildBattleGuldInfo#guild_battle_guild_info{rank = Acc},
        update_guild_battle_guild_info_to_ets(NewGuildBattleGulidInfo),
        Acc + 1
    end,
    lists:foldl(FSetGuildRank,1,ListGuild2),    

    del_all_data(), 
    del_all_guild_data(),   
    void.

% 检测是否已经进入决战期间
check_is_duel_time() ->
    get_time() >= ?GUILD_DUEL_TIME.

% 检测是否可以进入第三层
check_can_enter3() ->
    get_time() >= ?GUILD_CAN_TAKE_TIME.

% 循环检测
loop_check() ->   
    State = get_state(),
    Rounds = get_rounds(),
    Time = get_time(),

    {Scene1,_,_} =  ?GUILD_ENTER1_CONFIG,
    {Scene2,_,_} =  ?GUILD_ENTER2_CONFIG,
    {Scene3,_,_} =  ?GUILD_ENTER3_CONFIG,

    NextTime = 
    case State of
        % 如果处于等待中
        ?GUILD_BATTLE_WAIT ->
            % 等待20分钟后开始每分钟通知一次 平时5分钟通知一次
            if 
                Time >= ?GUILD_WAIT_TIME ->
                    guild_battle_open(),
                    0;
                Time >= ?GUILD_MORE_POST_WAIT_TIME -> 
                    case Time rem 60 of
                        0 ->
                            % 这里通知一下广播 最后10分钟
                            % 距离帮战开始剩余X分钟
                            mod_broadcast:send_sys_broadcast(183, [util:ceil((?GUILD_WAIT_TIME - Time) / 60)]),
                            skip;
                        _ ->
                            skip
                    end,

                    Time + 1;
                true ->
                    case Time rem 300 of
                        0 ->
                            % 这里通知一下广播
                            mod_broadcast:send_sys_broadcast(183, [util:ceil((?GUILD_WAIT_TIME - Time) / 60)]),
                            skip;
                        _ ->
                            skip
                    end,

                    Time + 1
            end;
        % 如果现在处于开启状态
        ?GUILD_BATTLE_OPEN ->
            if 
                Time > ?GUILD_BATTLE_DURATION ->
                    % 帮战超过持续时间了
                    % 结算
                    guild_battle_end(),

                    Time + 1;
                Time > ?GUILD_BATTLE_DURATION_TIPS ->
                    case Time rem 60 of
                        % 公告帮战即将结束
                        0 -> mod_broadcast:send_sys_broadcast(295, [util:ceil((Time - ?GUILD_BATTLE_DURATION) / 60)]);
                        _ -> skip
                    end,

                    Time + 1;
                Time =:= ?GUILD_DUEL_TIME ->
                    % 广播已经进入决斗期间
                    mod_broadcast:send_sys_broadcast(185, []),

                    Time + 1;
                Time > ?GUILD_DUEL_TIME -> 
                    case Time rem 300 of
                        0 ->
                            % 这里 广播当前剩下的玩家信息
                            % mod_broadcast:send_sys_broadcast(186, []),

                            % 玩家信息处理
                            List1 = get_all_guild_battle_info_player_id(),
                            F1 = fun(Player_id) ->
                                GuildBattleInfo = get_guild_battle_info_by_player_id(Player_id),
                                case player:get_PS(Player_id) of
                                    APS when is_record(APS,player_status) ->
                                        % 提示剩余的队伍信息
                                        case lists:member(player:get_scene_id(APS),[Scene1,Scene2,Scene3]) of
                                            true ->
                                                mod_broadcast:send_sys_broadcast(186, [
                                                    ply_guild:get_guild_name(APS)
                                                    ,player:get_name(APS)
                                                    ,player:id(APS)
                                                    ,player:get_scene_no(APS)
                                                    ]);         

                                            _Other2 ->
                                                skip
                                        end;
                                    _ ->
                                        skip
                                end,

                                void
                            end,

                            lists:foreach(F1,List1),
                            skip;
                        _ ->
                            skip
                    end,

                    Time + 1;
                Time > ?GUILD_DUEL_TIME_TIPS ->
                    case Time rem 60 of
                        0 ->
                            % 这里 每分钟提示一次即将进入决战期间
                            mod_broadcast:send_sys_broadcast(187, [(Time - ?GUILD_DUEL_TIME) / 60]),

                            skip;
                        _ ->
                            skip
                    end,

                    Time + 1;
                true ->
                    case Time rem 300 of
                        0 ->
                            % 普通广播正在进行帮派战
                            mod_broadcast:send_sys_broadcast(188, []),

                            skip;
                        _ ->
                            skip
                    end,

                    Time + 1
            end;

        % 帮战状态处于结束中
        ?GUILD_BATTLE_END ->
            Week = util:get_week(),

            % 判断是否是帮战天
            case lists:member(Week,[?GUILD_BATTLE_BEGIN_WEEK1,?GUILD_BATTLE_BEGIN_WEEK2]) of
                true ->
                    % 判断时间是否符合
                    {Hour, Min, _Sec} = erlang:time(),
                    % ?DEBUG_MSG("Hour~p, Min~p, _Sec~p",[Hour, Min, _Sec]),
                    % 如果是帮战开启时间则
                    case Hour =:= ?GUILD_BATTLE_BEGIN_HOUR andalso Min =:= ?GUILD_BATTLE_BEGIN_MIN of
                        true ->
                            guild_battle_begin();
                        false ->
                            skip
                    end;
                _ ->
                    skip
            end,

            0;
        _ ->
            ?ERROR_MSG("ERROR_MSG",[]),
            0
    end,
    set_time(NextTime),

    % 玩家信息处理
    List = get_all_guild_battle_info_player_id(),
    F = fun(Player_id,Acc) ->
        GuildBattleInfo = get_guild_battle_info_by_player_id(Player_id),
        % 属性
        Cut_step_time = GuildBattleInfo#guild_battle_player_info.cut_step_time,
        Enter1_time = GuildBattleInfo#guild_battle_player_info.enter1_time,
        Enter2_time = GuildBattleInfo#guild_battle_player_info.enter2_time,
        Enter3_time = GuildBattleInfo#guild_battle_player_info.enter3_time,
        Cur_state = GuildBattleInfo#guild_battle_player_info.cur_state,
        % PS = player:get_PS(Player_id),

        % 可能有些已经下线
        case player:get_PS(Player_id) of
            PS when is_record(PS,player_status) ->
                % 判断玩家是否在读条 并且是队长 否则不进入下面的处理
                case lists:member(player:get_scene_id(PS) ,[Scene1,Scene2,Scene3]) of
                    true ->
                        case player:is_in_team(PS) of
                                true ->
                                    TeamId = player:get_team_id(PS),
                                    case player:is_leader(PS) andalso 
                                        % 判断归队状态下玩家数量大于
                                        (mod_team:get_normal_member_count(TeamId) >= ?GUILD_TEAM_PLAYER_COUNT) of
                                        true ->
                                            skip;
                                        false ->
                                            case mod_team:is_player_tmp_leave(PS) of
                                                true ->
                                                    lib_guild_battle:enter_to_0(PS);
                                                false ->
                                                    skip
                                            end
                                    end;
                                false ->
                                    lib_guild_battle:enter_to_0(PS)
                        end;
                    false ->
                        skip
                end,
                        NewGuildBattleInfo = 
                        case lists:member(player:get_scene_id(PS) ,[Scene1,Scene2,Scene3]) of
                            true ->
                                case lists:member(Cur_state, [?GUILD_BATTLE_READ2,?GUILD_BATTLE_READ3,?GUILD_BATTLE_TAKE]) andalso player:is_leader(PS) andalso State =:= ?GUILD_BATTLE_OPEN of
                                    false ->
                                        GuildBattleInfo;
                                    true ->
                                        % 在读条中
                                        % 判断是否足够进入下场景

                                        case Cur_state of
                                            ?GUILD_BATTLE_READ2 ->
                                                case Cut_step_time >= ?GUILD_ENTER2_LOAD_TIME of
                                                    true ->
                                                        % 进入战斗将状态修改为闲置
                                                        NpcId = 
                                                        case get_guild_battle_npc_by_usr_id(Player_id) of
                                                            GuildBattleNpc when is_record(GuildBattleNpc,guild_battle_npc) ->
                                                                GuildBattleNpc#guild_battle_npc.id;
                                                            _ ->
                                                                ?DEBUG_MSG("Npc user id can not find the npc",[]),
                                                                0
                                                        end,

                                                        {ok, BinData} = 
                                                        pt_65:write(?PT_LOAD_TIME, 
                                                            [
                                                                Player_id,
                                                                NpcId,
                                                                0
                                                            ]
                                                        ),

                                                        lib_send:send_to_AOI(Player_id, BinData),

                                                        lib_guild_battle:enter_to_2(PS),
                                                        GuildBattleInfo1 = get_guild_battle_info_by_player_id(Player_id),

                                                        GuildBattleInfo1#guild_battle_player_info{
                                                        cur_state=?GUILD_BATTLE_IDLE
                                                        ,cut_step_time = 0
                                                        };
                                                    false ->
                                                        % 时间加1
                                                        % 时间加1    
                                                        % 进入战斗将状态修改为闲置
                                                        NpcId = 
                                                        case get_guild_battle_npc_by_usr_id(Player_id) of
                                                            GuildBattleNpc when is_record(GuildBattleNpc,guild_battle_npc) ->
                                                                GuildBattleNpc#guild_battle_npc.id;
                                                            _ ->
                                                                ?DEBUG_MSG("Npc user id can not find the npc",[]),
                                                                0
                                                        end,

                                                        {ok, BinData} = 
                                                        pt_65:write(?PT_LOAD_TIME, 
                                                            [
                                                                Player_id,
                                                                NpcId,
                                                                (GuildBattleInfo#guild_battle_player_info.cut_step_time + 1)
                                                            ]
                                                        ),

                                                        lib_send:send_to_AOI(Player_id, BinData),

                                                        GuildBattleInfo#guild_battle_player_info{cut_step_time = Cut_step_time + 1}
                                                end;
                                            ?GUILD_BATTLE_READ3 ->
                                                case Cut_step_time >= ?GUILD_ENTER3_LOAD_TIME of
                                                    true ->
                                                        % 进入战斗将状态修改为闲置
                                                        NpcId = 
                                                        case get_guild_battle_npc_by_usr_id(Player_id) of
                                                            GuildBattleNpc when is_record(GuildBattleNpc,guild_battle_npc) ->
                                                                GuildBattleNpc#guild_battle_npc.id;
                                                            _ ->
                                                                ?DEBUG_MSG("Npc user id can not find the npc",[]),
                                                                0
                                                        end,

                                                        {ok, BinData} = 
                                                        pt_65:write(?PT_LOAD_TIME, 
                                                            [
                                                                Player_id,
                                                                NpcId,
                                                                0
                                                            ]
                                                        ),

                                                        lib_send:send_to_AOI(Player_id, BinData),

                                                        lib_guild_battle:enter_to_3(PS),
                                                        GuildBattleInfo1 = get_guild_battle_info_by_player_id(Player_id),

                                                        GuildBattleInfo1#guild_battle_player_info{
                                                        cur_state=?GUILD_BATTLE_IDLE
                                                        ,cut_step_time = 0
                                                        };                                
                                                    false ->
                                                        % 时间加1
                                                        % 时间加1    
                                                        % 进入战斗将状态修改为闲置
                                                        NpcId = 
                                                        case get_guild_battle_npc_by_usr_id(Player_id) of
                                                            GuildBattleNpc when is_record(GuildBattleNpc,guild_battle_npc) ->
                                                                GuildBattleNpc#guild_battle_npc.id;
                                                            _ ->
                                                                ?DEBUG_MSG("Npc user id can not find the npc",[]),
                                                                0
                                                        end,

                                                        {ok, BinData} = 
                                                        pt_65:write(?PT_LOAD_TIME, 
                                                            [
                                                                Player_id,
                                                                NpcId,
                                                                (GuildBattleInfo#guild_battle_player_info.cut_step_time + 1)
                                                            ]
                                                        ),

                                                        lib_send:send_to_AOI(Player_id, BinData),

                                                        GuildBattleInfo#guild_battle_player_info{cut_step_time = Cut_step_time + 1}
                                                end;

                                            ?GUILD_BATTLE_TAKE ->
                                                case Cut_step_time >= ?GUILD_TAKE_THRONE_TIME of
                                                    true ->
                                                        % 宣布结束了
                                                        guild_battle_end(player:get_guild_id(PS),Player_id),
                                                        GuildBattleInfo;
                                                    false ->
                                                        case GuildBattleInfo#guild_battle_player_info.cut_step_time + 1 rem 10 of
                                                            0 ->
                                                         
                                                                % 提示剩余的队伍信息
                                                                case lists:member(player:get_scene_id(PS),[Scene1,Scene2,Scene3]) of
                                                                    true ->
                                                                        mod_broadcast:send_sys_broadcast(272, [
                                                                            ply_guild:get_guild_name(PS)
                                                                            ,player:get_name(PS)
                                                                            ,player:id(PS)
                                                                            ,(?GUILD_TAKE_THRONE_TIME - (GuildBattleInfo#guild_battle_player_info.cut_step_time + 1))
                                                                            ]);         

                                                                    _Other3 ->
                                                                        skip
                                                                end,                                                    

                                                                skip;
                                                            _ ->
                                                                skip
                                                        end,

                                                        % 时间加1    
                                                        % 进入战斗将状态修改为闲置
                                                        NpcId = 
                                                        case get_guild_battle_npc_by_usr_id(Player_id) of
                                                            GuildBattleNpc when is_record(GuildBattleNpc,guild_battle_npc) ->
                                                                GuildBattleNpc#guild_battle_npc.id;
                                                            _ ->
                                                                ?DEBUG_MSG("Npc user id can not find the npc",[]),
                                                                0
                                                        end,

                                                        {ok, BinData} = 
                                                        pt_65:write(?PT_LOAD_TIME, 
                                                            [
                                                                Player_id,
                                                                NpcId,
                                                                (GuildBattleInfo#guild_battle_player_info.cut_step_time + 1)
                                                            ]
                                                        ),

                                                        lib_send:send_to_AOI(Player_id, BinData),

                                                        GuildBattleInfo#guild_battle_player_info{cut_step_time = Cut_step_time + 1}
                                                end;

                                            _Other ->
                                                GuildBattleInfo
                                        end
                                end;
                            false ->
                                GuildBattleInfo
                        end,

                        % 判断是否在场内 进行时间增加
                        NewGuildBattleInfo1 = case player:get_scene_id(PS) of
                            Scene1 ->
                                NewGuildBattleInfo#guild_battle_player_info{enter1_time = Enter1_time + 1};
                            Scene2 ->
                                NewGuildBattleInfo#guild_battle_player_info{enter2_time = Enter2_time + 1};
                            Scene3 ->
                                NewGuildBattleInfo#guild_battle_player_info{enter3_time = Enter3_time + 1};
                            _Other4 ->
                                NewGuildBattleInfo
                        end,

                        % 判断是否在休息 休息时间减少
                        NewGuildBattleInfo2 =
                        case NewGuildBattleInfo1#guild_battle_player_info.halt_time > 0 of
                            true ->
                                NewGuildBattleInfo1#guild_battle_player_info{halt_time = NewGuildBattleInfo1#guild_battle_player_info.halt_time - 1};
                            false ->
                                NewGuildBattleInfo1#guild_battle_player_info{halt_time = 0}
                        end,

                        % 更新到ETS
                        add_guild_battle_info(NewGuildBattleInfo2);

            _ ->
                void
        end,

        Acc

    end,

    lists:foldl(F, 0,List),
    void.

save_to_db() ->
    gen_server:call(?MODULE, save_to_db).

% start
start() ->
    case erlang:whereis(?MODULE) of
        undefined ->
            case supervisor:start_child(
               sm_sup,
               {?MODULE,
                {?MODULE, start_link, []},
                 permanent, ?GUILD_INTERVAL, worker, [?MODULE]}) of
            {ok, Pid} ->
                Pid;
            {error, R} ->
                ?WARNING_MSG("start error:~p~n", [R]),
                undefined
            end;
        Pid ->
            Pid
    end.

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

% stop
stop() ->
    gen_server:call(?MODULE, save_to_db),
    supervisor:terminate_child(sm_sup, ?MODULE).

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

terminate(_Reason, _State) ->
    ok.

% call 同步调用需要等待结构
do_call(save_to_db, _From, State) ->
    db_save(),
    {reply, ok, State};

% call 同步调用需要等待结构
do_call(_Msg, _From, State) ->
    ?WARNING_MSG("unhandle call ~w", [_Msg]),
    {reply, error, State}.

% 异步调用无需等待
% cast
do_cast(_Msg, State) ->
    ?WARNING_MSG("unhandle cast ~p", [_Msg]),
    {noreply, State}.

%% info
do_info(doloop, State) ->
    loop_check(),
    {noreply, State};

do_info(_Msg, State) ->
    ?WARNING_MSG("unhandle info ~w", [_Msg]),
    {noreply, State}.


% 初始化ETS
init([]) ->
    % 帮战玩家信息ETS
    ets:new(?ETS_GUILD_BATTLE_INFO, [{keypos, #guild_battle_player_info.player_id}, named_table, public, set]),
    ets:new(?ETS_GUILD_BATTLE_GUILD_INFO, [{keypos, #guild_battle_guild_info.guild_id}, named_table, public, set]),

    ets:new(?ETS_GUILD_BATTLE_HISTORY, [{keypos, #guild_battle_history.rounds}, named_table, public, set]),

    ets:new(?ETS_GUILD_BATTLE_NPC, [{keypos, #guild_battle_npc.id}, named_table, public, set]),

    % 帮战信息
    ets:new(?ETS_GUILD_BATTLE_SYS, [named_table, public, set]),   % 服务器杂项信息

    db_load(),
    % 每秒执行一次循环
    mod_timer:reg_loop_msg(self(), ?GUILD_INTERVAL),
    {ok, {}}.


% handle 必须要的部分
handle_call(Request, From, State) ->
    try
        do_call(Request, From, State)
    catch
        Err:Reason->
            ?ERROR_MSG("ERR:~p,Reason:~p, Request:~p",[Err,Reason, Request]),
             {reply, error, State}
    end.

handle_cast(Request, State) ->
    try
        do_cast(Request, State)
    catch
        Err:Reason->
            ?ERROR_MSG("ERR:~p,Reason:~p, Request:~p",[Err,Reason, Request]),
             {noreply, State}
    end.

handle_info(Request, State) ->
    try
        do_info(Request, State)
    catch
        Err:Reason->
            ?ERROR_MSG("ERR:~p,Reason:~p, Request:~p",[Err,Reason, Request]),
             {noreply, State}
    end.