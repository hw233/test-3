%%%------------------------------------
%%% @Module  : mod_guild_war
%%% @Author  : zhangwq
%%% @Email   :
%%% @Created : 2014.10.15
%%% @Description: server    帮派战 一场战斗实例 （包括处理战斗开始之前进入准备副本，由准备副本进入战斗副本，以及战斗过程、战斗评判等）
%%%------------------------------------


-module(mod_guild_war).
-behaviour(gen_server).
-export([start/1]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-export([
        stop/1,
        check_start_pk/2,
        on_player_login/1,                  %% 监听玩家上线
        on_player_logout/1,                 %% 监听玩家下线
        check_enter_war_pre_dungeon/1,
        batch_enter_war_dun/2,              %% 批量把玩家从准备副本转入战斗副本
        batch_enter_war_dun/3,              %% 批量把玩家从准备副本转入战斗副本
        test_get_info/1,
        pk_callback/2
    ]).


-include("guild.hrl").
-include("prompt_msg_code.hrl").
-include("ets_name.hrl").
-include("debug.hrl").
-include("abbreviate.hrl").
-include("common.hrl").
-include("log.hrl").
-include("pt_40.hrl").
-include("record/guild_record.hrl").
-include("obj_info_code.hrl").
-include("job_schedule.hrl").
-include("scene.hrl").
-include("record/battle_record.hrl").
-include("dungeon.hrl").
-include("reward.hrl").
-include("buff.hrl").
-include("goods.hrl").

-record(state, {
        turn = 0,                   %% 第几届（每届四轮比赛）
        round = 0,                  %% 比赛轮数
        slot = 0,
        guild_id = 0,
        obj_slot = 0,
        obj_guild_id = 0,
        finish = 0,                 %% 争夺战是否结束 1表示结束
        pre_start_time = 0,         %% 帮派战准备副本开始时间
        war_start_time = 0,         %% 帮派战开始时间
        pre_time = 0,               %% 预备区时长，单位是秒
        war_time = 0                %% 挑战区时长，单位是秒
    }).

-record(player_info, {
        state = 0,      %% 1表示正在战斗中 0 表示有空
        battle_power = 0,
        phy_power = 0   %% 当前剩余体力
    }).

-record(guild_info, {
        obj_guild_id = 0,       %% 对手帮派id
        obj_guild_name = <<>>,  %% 对手帮派名字
        battle_power = 0,       %% 开战时的帮派战力
        sign_in_id_list = [],   %% 当前在准备副本的玩家
        player_id_list = [],    %% 进入过战场副本的玩家
        left_id_list = []       %% 当前剩余在战场副本的玩家
    }).

%% 进程字典的key名
-define(PDKN_PLAYER_INFO, pdkn_player_info).                %% 玩家信息
-define(PDKN_GUILD_INFO, pdkn_guild_info).                  %% 帮派信息

stop(Pid) ->
    gen_server:cast(Pid, {'stop'}).


on_player_login(PS) ->
    case lib_dungeon:is_in_guild_prepare_dungeon(PS) of
        false ->
            case lib_dungeon:is_in_guild_battle_dungeon(PS) of
                false -> skip;
                true ->
                    case lib_guild:get_guild_war_from_ets(player:get_guild_id(PS)) of
                        null ->
                            skip;
                        GuildWar ->
                            ?DEBUG_MSG("mod_guild_war: on_player_login cast add_left_player...~n", []),
                            case is_pid_ok(GuildWar#guild_war.war_handle_pid) of
                                true -> gen_server:cast(GuildWar#guild_war.war_handle_pid, {'add_left_player', PS});
                                false -> skip
                            end
                    end
            end;
        true ->
            %% 尝试进入帮派战斗副本(登录时有副本保护时间)
            case lib_guild:get_guild_war_from_ets(player:get_guild_id(PS)) of
                null ->
                    skip;
                GuildWar ->
                    case is_pid_ok(GuildWar#guild_war.war_dun_pid) of
                        true -> %% 战斗副本已经开始
                            ?DEBUG_MSG("mod_guild_war: on_player_login cast try_enter_war_dungeon...~n", []),
                            case is_pid_ok(GuildWar#guild_war.war_handle_pid) of
                                true -> gen_server:cast(GuildWar#guild_war.war_handle_pid, {'try_enter_war_dungeon', PS});
                                false -> skip
                            end;
                        false ->
                            case is_pid_ok(GuildWar#guild_war.war_handle_pid) of
                                true -> gen_server:cast(GuildWar#guild_war.war_handle_pid, {'add_sign_in_player', PS});
                                false -> skip
                            end
                    end
            end
    end.


on_player_logout(PS) ->
    case lib_dungeon:is_in_guild_prepare_dungeon(PS) of
        false ->
            case lib_dungeon:is_in_guild_battle_dungeon(PS) of
                false -> skip;
                true ->
                    case lib_guild:get_guild_war_from_ets(player:get_guild_id(PS)) of
                        null -> skip;
                        GuildWar -> 
                            ?DEBUG_MSG("mod_guild_war: on_player_logout cast del_left_player...~n", []),
                            case is_pid_ok(GuildWar#guild_war.war_handle_pid) of
                                true -> gen_server:cast(GuildWar#guild_war.war_handle_pid, {'del_left_player', PS});
                                false -> skip
                            end
                    end
            end;
        true ->
            case lib_guild:get_guild_war_from_ets(player:get_guild_id(PS)) of
                null -> skip;
                GuildWar ->
                    ?DEBUG_MSG("mod_guild_war: on_player_logout cast del_sign_in_player...~n", []),
                    case is_pid_ok(GuildWar#guild_war.war_handle_pid) of
                        true -> gen_server:cast(GuildWar#guild_war.war_handle_pid, {'del_sign_in_player', PS});
                        false -> skip
                    end
            end
    end.


batch_enter_war_dun(GuildId, ObjGuildId) ->
    ?DEBUG_MSG("mod_guild_war: batch_enter_war_dun cast begin~n", []),
    case lib_guild:get_guild_war_from_ets(GuildId) of
        null -> skip;
        GuildWar ->   
            gen_server:cast(GuildWar#guild_war.war_handle_pid, {'batch_enter_war_dun', GuildId, ObjGuildId})
    end.


batch_enter_war_dun(Pid, GuildId, ObjGuildId) ->
    ?DEBUG_MSG("mod_guild_war: batch_enter_war_dun cast begin~n", []),   
    gen_server:cast(Pid, {'batch_enter_war_dun', GuildId, ObjGuildId}).


pk_callback(PlayerId, Feedback) ->
    ?DEBUG_MSG("mod_guild_war: pk_callback begin~n", []), 
    case player:get_PS(PlayerId) of
        null ->
            skip;
        PS ->
            GuildId = player:get_guild_id(PS),
            case lib_guild:get_guild_war_from_ets(GuildId) of
                null ->
                    skip;
                GuildWar ->
                    ?DEBUG_MSG("mod_guild_war: pk_callback cast begin~n", []), 
                    gen_server:cast(GuildWar#guild_war.war_handle_pid, {'pk_callback', PS, Feedback})
            end
    end.


test_get_info(PS) ->
    GuildId = player:get_guild_id(PS),
    case lib_guild:get_guild_war_from_ets(GuildId) of
        null ->
            skip;
        GuildWar ->
            ?DEBUG_MSG("mod_guild_war: test_get_info cast begin~n", []), 
            gen_server:cast(GuildWar#guild_war.war_handle_pid, {'test_get_info'})
    end.


check_start_pk(PS, ObjPlayerId) ->
    try check_start_pk__(PS, ObjPlayerId) of
        {ok, HandlePid} -> {ok, HandlePid}
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

check_enter_war_pre_dungeon(PS) ->
    try check_enter_war_pre_dungeon__(PS) of
        {ok, HandlePid} -> {ok, HandlePid}
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.    


% -------------------------------------------------------------------------
%% {ok, Pid}
start([Turn, Round, Slot1, GuildId, Name, BattleP, Slot2, ObjGuildId, ObjName, ObjBattleP]) ->
    gen_server:start(?MODULE, [Turn, Round, Slot1, GuildId, Name, BattleP, Slot2, ObjGuildId, ObjName, ObjBattleP], []).


init([Turn, Round, Slot1, GuildId, Name, BattleP, Slot2, ObjGuildId, ObjName, ObjBattleP]) ->
    process_flag(trap_exit, true),
    Now = util:unixtime(),
    {PreTime, WarTime} = 
        case data_guild_sys_cfg:get(guild_war) of
            null ->
                ?ASSERT(false), {20*60, 60*60};
            SysCfg -> {SysCfg#guild_sys_cfg.pre_war_time, SysCfg#guild_sys_cfg.war_time}
        end,

    State = #state
        {
        pre_start_time = Now,
        slot = Slot1, 
        guild_id = GuildId, 
        obj_slot = Slot2, 
        obj_guild_id = ObjGuildId,
        turn = Turn,
        round = Round,
        pre_time = PreTime,
        war_time = WarTime
        }, 

    Guild = #guild_info{obj_guild_id = ObjGuildId, obj_guild_name = ObjName, battle_power = BattleP},
    Guild1 = #guild_info{obj_guild_id = GuildId, obj_guild_name = Name, battle_power = ObjBattleP},
    set_guild_info(GuildId, Guild),
    set_guild_info(ObjGuildId, Guild1),

    {ok, State}.


handle_call(Request, From, State) ->
    try
        handle_call_2(Request, From, State)
    catch
        Err:Reason ->
            ?ERROR_MSG("ERR:~p,Reason:~p",[Err,Reason]),
             {reply, error, State}
    end.


handle_call_2(_Request, _From, State) ->
    {reply, State, State}.

handle_cast(Request, State) ->
    try
        handle_cast_2(Request, State)
    catch
        Err:Reason ->
            ?ERROR_MSG("ERR:~p,Reason:~p, ~w",[Err, Reason, erlang:get_stacktrace()]),
            {noreply, State}
    end.

   

handle_cast_2({'stop'}, State) ->
    {stop, normal, State};


handle_cast_2({'start_pk', PS, ObjPlayerId}, State) ->
    ?TRY_CATCH(try_start_pk(PS, ObjPlayerId), ErrReason),
    {noreply, State};    


handle_cast_2({'pk_callback', PS, Feedback}, State) ->
    PlayerId = player:id(PS),
    Player = get_player_info(PlayerId),
    Guild = get_guild_info(player:get_guild_id(PS)),
    NewState = 
    case Player =:= null orelse Guild =:= null of
        true -> 
            ?ERROR_MSG("mod_guild_war:pk_callback error!~n", []),
            State;
        false ->
            ?DEBUG_MSG("mod_guild_war: handle pk_callback begin PlayerId:~p, Ret:~p ~n", [PlayerId, Feedback#btl_feedback.result]),
            {FailPhypower, AttedSuccPhypower} = 
                case data_guild_sys_cfg:get(guild_war) of
                    null ->
                        ?ASSERT(false),
                        {20, 5};
                    SysCfg -> {SysCfg#guild_sys_cfg.fail_phy_power, SysCfg#guild_sys_cfg.atted_succ_phy_power}
                end,

            %% 添加buff
            case Feedback#btl_feedback.side =:= ?HOST_SIDE of
                true -> %% 发起挑战的
                    lib_buff:player_add_buff(player:id(PS), ?BNO_GUILD_WAR_PK_CD);
                false -> %% 被挑战的
                    lib_buff:player_add_buff(player:id(PS), ?BNO_GUILD_WAR_PK_PROTECT)
            end,

            case Feedback#btl_feedback.result of
                win ->
                    case Feedback#btl_feedback.side =:= ?HOST_SIDE of
                        false -> %% 被挑战但胜利
                            ?DEBUG_MSG("mod_guild_war: handle pk_callback begin PlayerName:~p, AttedSucc...~n", [player:get_name(PS)]),
                            NewPlayer = Player#player_info{state = 0, phy_power = max(0, Player#player_info.phy_power - AttedSuccPhypower)},
                            set_player_info(PlayerId, NewPlayer),
                            pk_callback_more(player:get_guild_id(PS), Guild, PS, NewPlayer, State),
                            check_finish(State);
                        true -> %% 发起挑战且胜利，检查体力是否是0了
                            ?DEBUG_MSG("mod_guild_war: handle pk_callback begin PlayerName:~p, AttSucc...~n", [player:get_name(PS)]),
                            NewPlayer = Player#player_info{state = 0},
                            set_player_info(PlayerId, NewPlayer),
                            pk_callback_more(player:get_guild_id(PS), Guild, PS, NewPlayer, State),
                            check_finish(State)
                    end;
                lose ->
                    ?DEBUG_MSG("mod_guild_war: handle pk_callback begin PlayerName:~p, lose...~n", [player:get_name(PS)]),
                    NewPlayer = 
                        case Feedback#btl_feedback.side =:= ?HOST_SIDE of
                            true -> %% 发起挑战的,不用扣了
                                Player#player_info{state = 0};
                            false ->
                                Player#player_info{state = 0, phy_power = max(0, Player#player_info.phy_power - FailPhypower)}
                        end,
                    
                    set_player_info(PlayerId, NewPlayer),
                    pk_callback_more(player:get_guild_id(PS), Guild, PS, NewPlayer, State),
                    check_finish(State);
                draw ->
                    ?DEBUG_MSG("mod_guild_war: handle pk_callback begin PlayerName:~p, draw...~n", [player:get_name(PS)]),
                    %% 平局不扣除体力（只扣除发起挑战的体力）
                    NewPlayer = Player#player_info{state = 0},
                    set_player_info(PlayerId, NewPlayer),
                    pk_callback_more(player:get_guild_id(PS), Guild, PS, Player, State),
                    check_finish(State);
                _ -> 
                    ?ASSERT(false),
                    ?ERROR_MSG("mod_guild_war:error!~n", []),
                    State
            end
    end,

    {noreply, NewState};        


%% 玩家从客户端请求进入签到区
handle_cast_2({'enter_war_pre_dungeon', PS, PlayerMisc}, State) ->
    case mod_guild_war:check_enter_war_pre_dungeon(PS) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        {ok, _HandlePid} ->
            case State#state.finish =:= 1 of
                true ->
                    lib_send:send_prompt_msg(PS, ?PM_GUILD_WAR_OVER);
                false ->
                    case can_join_the_turn(PS, PlayerMisc, State) of %% 是否已经参加过本届争霸赛（防止在其他帮派参加过了，然后加入胜利的帮派）
                        false ->
                            lib_send:send_prompt_msg(PS, ?PM_GUILD_HAVE_JOINED_THE_TURN_WAR);
                        true ->
                            GuildId = player:get_guild_id(PS),
                            case lib_guild:get_guild_war_from_ets(GuildId) of
                                null ->
                                    ?ASSERT(false),
                                    ?ERROR_MSG("mod_guild_war:error!~n", []),
                                    skip;
                                GuildWar ->
                                    InitPhypower = 
                                        case data_guild_sys_cfg:get(guild_war) of
                                            null ->
                                                ?ASSERT(false), 100;
                                            SysCfg -> SysCfg#guild_sys_cfg.init_phy_power
                                        end,
                                    Player = #player_info{state = 0, phy_power = InitPhypower, battle_power = ply_attr:get_battle_power(PS)},

                                    case is_pid_ok(GuildWar#guild_war.war_dun_pid) of
                                        true -> %% 如果此时战斗时间已经开始，则进入战斗副本
                                            lib_dungeon:enter_public_dungeon(GuildWar#guild_war.war_dun_pid, player:id(PS)),
                                            NewGuild = 
                                                case get_guild_info(GuildId) of
                                                    null ->
                                                        #guild_info{left_id_list = [player:id(PS)], player_id_list = [player:id(PS)]};
                                                    GuildInfo ->
                                                        GuildInfo#guild_info{
                                                        left_id_list = sets:to_list(sets:from_list([player:id(PS) | GuildInfo#guild_info.left_id_list])),
                                                        player_id_list = sets:to_list(sets:from_list([player:id(PS) | GuildInfo#guild_info.player_id_list]))
                                                        }
                                                end,

                                            set_guild_info(GuildId, NewGuild),
                                            set_player_info(player:id(PS), Player),
                                            % player:mark_busy(PS),
                                            gen_server:cast(player:get_pid(PS), {'update_player_misc_for_guild_war', State#state.turn}),
                                            notify_player_change(NewGuild#guild_info.left_id_list, NewGuild#guild_info.obj_guild_id, NewGuild#guild_info.obj_guild_name, State);
                                        false ->
                                            lib_dungeon:enter_public_dungeon(GuildWar#guild_war.war_pre_dun_pid, player:id(PS)),
                                            case get_guild_info(GuildId) of
                                                null ->
                                                    GuildInfo = #guild_info{sign_in_id_list = [player:id(PS)]},
                                                    set_guild_info(GuildId, GuildInfo);
                                                GuildInfo ->
                                                    set_guild_info(GuildId, GuildInfo#guild_info{sign_in_id_list = sets:to_list(sets:from_list([player:id(PS) | GuildInfo#guild_info.sign_in_id_list]))})
                                            end,

                                            set_player_info(player:id(PS), Player),
                                            gen_server:cast(player:get_pid(PS), {'update_player_misc_for_guild_war', State#state.turn}),
                                            broadcast_pre_war_info(PS, State),
                                            % player:mark_busy(PS),

                                            {ok, BinData} = pt_40:write(?PM_GUILD_SIGN_IN_FOR_GB, [?RES_OK]),
                                            lib_send:send_to_sock(PS, BinData)
                                    end
                            end
                    end
            end
    end,

    {noreply, State};


handle_cast_2({'leave_war_pre_dungeon', PS}, State) ->
    case lib_dungeon:is_in_guild_prepare_dungeon(PS) of
        true ->
            lib_dungeon:quit_dungeon(PS),
            player:mark_idle(PS);
        false -> skip
    end,

    GuildId = player:get_guild_id(PS),
    case get_guild_info(GuildId) of
        null ->
            ?ASSERT(false),
            ?ERROR_MSG("mod_guild_war: leave_war_pre_dungeon error!~n", []);
        GuildInfo ->
            set_guild_info(GuildId, GuildInfo#guild_info{sign_in_id_list = GuildInfo#guild_info.sign_in_id_list -- [player:id(PS)]}),
            broadcast_pre_war_info(PS, State)
    end,
    {noreply, State};   


handle_cast_2({'leave_war_dungeon', PS}, State) ->
    case lib_dungeon:is_in_guild_battle_dungeon(PS) of
        true ->
            lib_dungeon:quit_dungeon(PS),
            player:mark_idle(PS);
        false -> skip
    end,

    GuildId = player:get_guild_id(PS),
    case get_guild_info(GuildId) of
        null ->
            ?ASSERT(false),
            ?ERROR_MSG("mod_guild_war: leave_war_dungeon error!~n", []);
        GuildInfo ->
            NewGuild = GuildInfo#guild_info{left_id_list = GuildInfo#guild_info.left_id_list -- [player:id(PS)]},
            set_guild_info(GuildId, NewGuild),
            notify_player_change(NewGuild#guild_info.left_id_list, NewGuild#guild_info.obj_guild_id, NewGuild#guild_info.obj_guild_name, State)
    end,
    NewState = check_finish(State),
    {noreply, NewState};    


%% 更新 战斗场景的玩家个数
handle_cast_2({'add_left_player', PS}, State) ->
    case get_player_info(player:id(PS)) of
        null ->
            ?ASSERT(false),
            ?ERROR_MSG("add_left_player error!~n", []);
        Player ->
            case Player#player_info.phy_power =< 0 of
                true -> 
                    set_player_info(player:id(PS), Player#player_info{state = 0});
                false ->
                    %% 断线重连，玩家不在战斗保护时间，则设置为空闲状态
                    set_player_info(player:id(PS), Player#player_info{state = 0}),

                    GuildId = player:get_guild_id(PS),
                    case get_guild_info(GuildId) of
                        null ->
                            ?ASSERT(false),
                            ?ERROR_MSG("mod_guild_war: add_left_player error!~n", []);
                        GuildInfo ->
                            LeftIdList = sets:to_list(sets:from_list([player:id(PS) | GuildInfo#guild_info.left_id_list])),
                            set_guild_info(GuildId, GuildInfo#guild_info{left_id_list = LeftIdList}),
                            notify_player_change(LeftIdList, GuildInfo#guild_info.obj_guild_id, GuildInfo#guild_info.obj_guild_name, State)
                    end
            end
    end,

    {noreply, State};        


%% 在战斗副本中掉线
handle_cast_2({'del_left_player', PS}, State) ->
    NewState = 
        case get_player_info(player:id(PS)) of
            null ->
                ?ASSERT(false),
                ?ERROR_MSG("del_left_player error!~n", []),
                State;
            _Player ->
                GuildId = player:get_guild_id(PS),
                case get_guild_info(GuildId) of
                    null ->
                        ?ASSERT(false),
                        ?ERROR_MSG("mod_guild_war: del_left_player error!~n", []),
                        State;
                    GuildInfo ->
                        LeftIdList = GuildInfo#guild_info.left_id_list -- [player:id(PS)],
                        set_guild_info(GuildId, GuildInfo#guild_info{left_id_list = LeftIdList}),
                        notify_player_change(LeftIdList, GuildInfo#guild_info.obj_guild_id, GuildInfo#guild_info.obj_guild_name, State),
                        check_finish(State)
                end
        end,
    {noreply, NewState};        


%% 玩家在预备副本掉线
handle_cast_2({'del_sign_in_player', PS}, State) ->
    case get_guild_info(player:get_guild_id(PS)) of
        null ->
            skip;
        Guild ->
            set_guild_info(player:get_guild_id(PS), Guild#guild_info{sign_in_id_list = Guild#guild_info.sign_in_id_list -- [player:id(PS)]})
    end,
    broadcast_pre_war_info(PS, State),
    {noreply, State};        


handle_cast_2({'add_sign_in_player', PS}, State) ->
    case get_guild_info(player:get_guild_id(PS)) of
        null ->
            skip;
        Guild ->
            NewSignInIdlist = sets:to_list(sets:from_list([player:id(PS) | Guild#guild_info.sign_in_id_list])),
            set_guild_info(player:get_guild_id(PS), Guild#guild_info{sign_in_id_list = NewSignInIdlist})
    end,
    broadcast_pre_war_info(PS, State),
    {noreply, State};            


handle_cast_2({'get_guild_war_info', PS}, State) ->
    ?DEBUG_MSG("mod_guild_war:get_guild_war_info...~n", []),
    case get_guild_info(player:get_guild_id(PS)) of
        null -> 
            skip;
        Guild ->
            Length = length(Guild#guild_info.left_id_list),
            ObjGuildName = Guild#guild_info.obj_guild_name,
            ObjGuild = get_guild_info(Guild#guild_info.obj_guild_id),
            OtherPlayerCnt = 
                case ObjGuild =:= null of
                    true -> 0;
                    false -> length(ObjGuild#guild_info.left_id_list)
                end,
            LeftTime = State#state.war_start_time + State#state.war_time - util:unixtime(),
                    
            CurPhyPower = 
                case get_player_info(player:id(PS)) of
                    null -> 0;
                    Player -> Player#player_info.phy_power
                end,
            ?DEBUG_MSG("mod_guild_war:get_guild_war_info send..~n", []),
            {ok, BinData} = pt_40:write(?PM_GUILD_GET_INFO_IN_GB, [CurPhyPower, ?GUILD_TOTAL_PHYPOWER, Length, OtherPlayerCnt, LeftTime, ObjGuildName]),
            lib_send:send_to_sock(PS, BinData)
    end,

    {noreply, State};        


handle_cast_2({'get_pre_guild_war_info', PS}, State) ->
    case get_guild_info(player:get_guild_id(PS)) of
        null -> 
            skip;
        Guild ->
            Length = length(Guild#guild_info.sign_in_id_list),
            
            StartTime = State#state.pre_start_time + State#state.pre_time,
                    
            CurPhyPower = 
                case get_player_info(player:id(PS)) of
                    null -> 0;
                    Player -> Player#player_info.phy_power
                end,
            {ok, BinData} = pt_40:write(?PM_GUILD_GET_INFO_BEFORE_GB, [CurPhyPower, ?GUILD_TOTAL_PHYPOWER, Length, StartTime]),
            lib_send:send_to_sock(PS, BinData)
    end,    
    {noreply, State};            


%% 尝试把帮派预备副本的玩家拉入战斗副本（用于处理在帮派战预备区的玩家掉线，同时帮派争夺战开始时）
handle_cast_2({'try_enter_war_dungeon', PS}, State) ->
    case State#state.finish =:= 1 of
        true ->
            ?DEBUG_MSG("try_enter_war_dungeon msg pk finish..~n", []);
        false ->
            case lib_dungeon:is_in_guild_battle_dungeon(PS) of
                true -> 
                    ?DEBUG_MSG("try_enter_war_dungeon msg has in war..~n", []),
                    skip;
                false ->
                    case lib_guild:get_guild_war_from_ets(player:get_guild_id(PS)) of
                        null ->
                            ?ERROR_MSG("try_enter_war_dungeon error..~n", []),
                            skip;
                        GuildWar ->
                            lib_dungeon:transfer_dungeon(PS, GuildWar#guild_war.war_dun_pid),
                            % player:mark_busy(PS),

                            %% 断线重连，玩家不在战斗保护时间(单人pk没有战斗保护)
                            case get_player_info(player:id(PS)) of
                                null ->
                                    ?ASSERT(false),
                                    ?ERROR_MSG("mod_guild_war:find player error!~n", []);
                                Player ->
                                    set_player_info(player:id(PS), Player#player_info{state = 0})
                            end,

                            case get_guild_info(player:get_guild_id(PS)) of
                                null ->
                                    ?ERROR_MSG("try_enter_war_dungeon error..~n", []);
                                Guild ->
                                    NewGuild = 
                                        case lists:member(player:id(PS), Guild#guild_info.left_id_list) of
                                            false ->
                                                Guild#guild_info{sign_in_id_list = Guild#guild_info.sign_in_id_list -- [player:id(PS)], 
                                                left_id_list = [player:id(PS) | Guild#guild_info.left_id_list]};
                                            true ->
                                                Guild#guild_info{sign_in_id_list = Guild#guild_info.sign_in_id_list -- [player:id(PS)]}
                                        end,
                                    set_guild_info(player:get_guild_id(PS), NewGuild),
                                    notify_player_change(NewGuild#guild_info.left_id_list, NewGuild#guild_info.obj_guild_id, NewGuild#guild_info.obj_guild_name, State)
                            end
                    end
            end
    end,

    {noreply, State};


%% 批量玩家进入战斗副本，标记争霸赛开始
handle_cast_2({'batch_enter_war_dun', GuildId, ObjGuildId}, State) -> 
    ?INFO_MSG("mod_guild_war: batch_enter_war_dun begin~n", []),   
    case get_guild_info(GuildId) of
        null ->
            ?ERROR_MSG("mod_guild_war: batch_enter_war_dun error..~n", []);
        Guild ->
            case lib_guild:get_guild_war_from_ets(GuildId) of
                null ->
                    ?ERROR_MSG("mod_guild_war: batch_enter_war_dun error..~n", []);
                GuildWar ->
                    F = fun(Id, Acc) ->
                        case player:get_PS(Id) of
                            null ->
                                Acc;
                            PS ->
                                case lib_dungeon:is_in_guild_prepare_dungeon(PS) of
                                    false -> 
                                        ?DEBUG_MSG("mod_guild_war: batch_enter_war_dun not in prepare_dungeon PlayerId:~p~n", [Id]),
                                        Acc;
                                    true ->
                                        ?DEBUG_MSG("mod_guild_war: batch_enter_war_dun PlayerId:~p~n", [Id]),
                                        lib_dungeon:transfer_dungeon(PS, GuildWar#guild_war.war_dun_pid),
                                        % player:mark_busy(PS), %% 这有并发问题，还需要考虑
                                        [Id | Acc]
                                end
                        end
                    end,
                    RetList = lists:foldl(F, [], Guild#guild_info.sign_in_id_list),
                    LeftL = Guild#guild_info.sign_in_id_list -- RetList,
                    set_guild_info(GuildId, Guild#guild_info{sign_in_id_list = LeftL, player_id_list = RetList, left_id_list = RetList})
            end
    end,

    case get_guild_info(ObjGuildId) of
        null ->
            ?ERROR_MSG("mod_guild_war: batch_enter_war_dun error..~n", []);
        ObjGuild ->
            case lib_guild:get_guild_war_from_ets(ObjGuildId) of
                null ->
                    ?ERROR_MSG("mod_guild_war: batch_enter_war_dun error..~n", []);
                ObjGuildWar ->
                    F1 = fun(Id, Acc) ->
                        case player:get_PS(Id) of
                            null ->
                                Acc;
                            PS1 ->
                                case lib_dungeon:is_in_guild_prepare_dungeon(PS1) of
                                    false -> 
                                        ?DEBUG_MSG("mod_guild_war: batch_enter_war_dun not in prepare_dungeon PlayerId:~p~n", [Id]),
                                        Acc;
                                    true ->
                                        ?DEBUG_MSG("mod_guild_war: batch_enter_war_dun PlayerId:~p~n", [Id]),
                                        lib_dungeon:transfer_dungeon(PS1, ObjGuildWar#guild_war.war_dun_pid),
                                        % player:mark_busy(PS1), %% 与组队系统判定矛盾,组队判定是否空闲,现在副本可以组队
                                        [Id | Acc]
                                end
                        end
                    end,
                    RetList1 = lists:foldl(F1, [], ObjGuild#guild_info.sign_in_id_list),
                    LeftL1 = ObjGuild#guild_info.sign_in_id_list -- RetList1,
                    set_guild_info(ObjGuildId, ObjGuild#guild_info{sign_in_id_list = LeftL1, player_id_list = RetList1, left_id_list = RetList1})
            end
    end,

    {noreply, State#state{war_start_time = util:unixtime()}};    


handle_cast_2({'test_get_info'}, State) ->
    GuildId = State#state.guild_id,
    ObjGuildId = State#state.obj_guild_id,

    Guild = get_guild_info(GuildId),
    ObjGuild = get_guild_info(ObjGuildId),

    ?DEBUG_MSG("get_guild_info:~p,~w:~n", [GuildId, Guild]),
    ?DEBUG_MSG("get_guild_info:~p,~w:~n", [ObjGuildId, ObjGuild]),

    F = fun(_Id) ->
        ?DEBUG_MSG("get_player_info:~p,~w~n", [_Id, get_player_info(_Id)])
    end,
    [F(X) || X <- Guild#guild_info.player_id_list],
    [F(X) || X <- ObjGuild#guild_info.player_id_list],
    
    ?DEBUG_MSG("State:~w~n", [State]),

    {noreply, State};


handle_cast_2({'force_finish_war'}, State) ->
    NewState = 
        case is_finish(State) of
            true -> State;
            false -> force_finish_war(State)
        end,

    {noreply, NewState};    


handle_cast_2({'check_finish_war'}, State) ->
    ?DEBUG_MSG("mod_guild_war check_finish_war:~n", []),
    NewState = check_finish(State),
    {noreply, NewState};        


handle_cast_2(_Msg, State) ->
    {noreply, State}.


handle_info(Request, State) ->
    try
        handle_info_2(Request, State)
    catch
        Err:Reason->
            ?ERROR_MSG("ERR:~p,Reason:~p",[Err,Reason]),
             {noreply, State}
    end.

handle_info_2(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

% %%-------------------------------------------------------------------------------------------------


set_player_info(PlayerId, Info) ->
    erlang:put( {?PDKN_PLAYER_INFO, PlayerId}, Info ).

get_player_info(PlayerId) ->
    case erlang:get({?PDKN_PLAYER_INFO, PlayerId}) of
        undefined -> null;
        Rd -> Rd
    end.

set_guild_info(GuildId, Info) ->
    erlang:put( {?PDKN_GUILD_INFO, GuildId}, Info ).

get_guild_info(GuildId) ->
    case erlang:get({?PDKN_GUILD_INFO, GuildId}) of
        undefined -> null;
        Rd -> Rd
    end.


check_start_pk__(PS, ObjPlayerId) ->
    GuildId = player:get_guild_id(PS),
    ?Ifc (GuildId =:= ?INVALID_ID)
        throw(?PM_NOT_IN_GUILD)
    ?End,

    ?Ifc (not lib_dungeon:is_in_guild_battle_dungeon(PS))
        throw(?PM_DUNGEON_OUSIDE)
    ?End,

    ObjPS = player:get_PS(ObjPlayerId),
    ?Ifc (ObjPS =:= null)
        throw(?PM_TARGET_PLAYER_NOT_ONLINE)
    ?End,

    ?Ifc (not lib_dungeon:is_in_guild_battle_dungeon(ObjPS))
        throw(?PM_DUNGEON_OUSIDE)
    ?End,

    ObjGuildId = player:get_guild_id(ObjPS),
    ?Ifc (ObjGuildId =:= ?INVALID_ID)
        throw(?PM_OBJ_NOT_IN_GUILD)
    ?End, 
    
    ?Ifc (GuildId =:= ObjGuildId)
        throw(?PM_GUILD_OBJ_IS_ONE_OF_US)   
    ?End,

    GuildWar = lib_guild:get_guild_war_from_ets(GuildId),
    ?Ifc (GuildWar =:= null)
        throw(?PM_GUILD_WAR_NOT_OPENED)
    ?End,

    ?Ifc (mod_buff:has_buff(player, player:id(PS), ?BFN_GUILD_WAR_PK_CD))
        throw(?PM_BT_PK_IN_CD)
    ?End,

    ?Ifc (mod_buff:has_buff(player, ObjPlayerId, ?BFN_GUILD_WAR_PK_PROTECT))
        throw(?PM_BT_TARGET_PK_PROTECT)
    ?End,

    F = fun(Id, Acc) ->
        case mod_buff:has_buff(player, Id, ?BFN_GUILD_WAR_PK_CD) of
            true -> Acc + 1;
            false -> Acc
        end
    end,

    F1 = fun(Id, Acc) ->
        case mod_buff:has_buff(player, Id, ?BFN_GUILD_WAR_PK_PROTECT) of
            true -> Acc + 1;
            false -> Acc
        end
    end,

    TeamId = player:get_team_id(PS),
    ?Ifc ((not player:is_tmp_leave_team(PS)) andalso lists:foldl(F, 0, mod_team:get_normal_member_id_list(TeamId) -- [player:id(PS)]) =/= 0)
        throw(?PM_BT_PK_IN_CD)
    ?End,

    ObjTeamId = player:get_team_id(ObjPS),
    ?Ifc ((not player:is_tmp_leave_team(ObjPS)) andalso lists:foldl(F1, 0, mod_team:get_normal_member_id_list(ObjTeamId) -- [ObjPlayerId]) =/= 0)
        throw(?PM_BT_TARGET_PK_PROTECT)
    ?End,

    {ok, GuildWar#guild_war.war_handle_pid}.


%% 战场管理进程调用
check_start_pk_further(PS, ObjPlayerId) ->
    try 
        check_start_pk_further__(PS, ObjPlayerId)
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

check_start_pk_further__(PS, ObjPlayerId) ->
    PlayerInfo = get_player_info(player:id(PS)),
    ?Ifc (PlayerInfo =:= null)
        throw(?PM_UNKNOWN_ERR)
    ?End,

    ?Ifc (PlayerInfo#player_info.state =:= 1)
        throw(?PM_BUSY_NOW)
    ?End,

    F1 = fun(Id, Acc) ->
        case get_player_info(Id) of
            null -> Acc;
            Player ->
                case Player#player_info.state =:= 1 of
                    true -> Acc + 1;
                    false -> Acc
                end
        end
    end,
    TeamId = player:get_team_id(PS),
    ?Ifc ((not player:is_tmp_leave_team(PS)) andalso lists:foldl(F1, 0, mod_team:get_normal_member_id_list(TeamId) -- [player:id(PS)]) =/= 0)
        throw(?PM_BUSY_NOW)
    ?End,

    AttPhypower = 
        case data_guild_sys_cfg:get(guild_war) of
            null ->
                ?ASSERT(false), 10;
            SysCfg -> SysCfg#guild_sys_cfg.att_phy_power
        end,        
    ?Ifc (PlayerInfo#player_info.phy_power < AttPhypower)
        throw(?PM_PHY_POWER_LIMIT)
    ?End,

    F2 = fun(Id, Acc) ->
        case get_player_info(Id) of
            null -> Acc;
            Player ->
                case Player#player_info.phy_power < AttPhypower of
                    true -> Acc + 1;
                    false -> Acc
                end
        end
    end,
    ?Ifc ((not player:is_tmp_leave_team(PS)) andalso lists:foldl(F2, 0, mod_team:get_normal_member_id_list(TeamId) -- [player:id(PS)]) =/= 0)
        throw(?PM_GUILD_MB_PHY_POWER_LIMIT)
    ?End,


    ObjPlayer = get_player_info(ObjPlayerId),
    ?Ifc (ObjPlayer =:= null)
        throw(?PM_UNKNOWN_ERR)
    ?End,

    ?Ifc (ObjPlayer#player_info.state =:= 1)
        throw(?PM_GUILD_OBJ_BUSY_NOW)
    ?End,

    ObjPS = player:get_PS(ObjPlayerId),
    TargetPS2 = 
        case player:is_in_team_but_not_leader(ObjPS) andalso (not player:is_tmp_leave_team(ObjPS)) of
            true ->
                % 转为向目标的队长pk
                TargetLeaderId = mod_team:get_leader_id(player:get_team_id(ObjPS)),
                player:get_PS(TargetLeaderId);
            false ->
                ObjPS
        end,

    ?Ifc (TargetPS2 =:= null)
        throw(?PM_TARGET_PLAYER_NOT_ONLINE)
    ?End,

    F3 = fun(Id, Acc) ->
        case get_player_info(Id) of
            null -> Acc;
            Player ->
                case Player#player_info.state =:= 1 of
                    true -> Acc + 1;
                    false -> Acc
                end
        end
    end,
    ObjTeamId = player:get_team_id(TargetPS2),
    ?Ifc ((not player:is_tmp_leave_team(TargetPS2)) andalso lists:foldl(F3, 0, mod_team:get_normal_member_id_list(ObjTeamId) -- [ObjPlayerId]) =/= 0)
        throw(?PM_GUILD_OBJ_BUSY_NOW)
    ?End,

    ?Ifc (player:get_guild_id(PS) =:= player:get_guild_id(TargetPS2))
        throw(?PM_GUILD_OBJ_IS_ONE_OF_US)
    ?End,

    {ok, PlayerInfo, ObjPlayer, TargetPS2}.


check_enter_war_pre_dungeon__(PS) ->
    GuildId = player:get_guild_id(PS),
    ?Ifc (GuildId =:= ?INVALID_ID)
        throw(?PM_NOT_IN_GUILD)
    ?End,

    ?Ifc (lib_dungeon:is_in_guild_prepare_dungeon(PS))
        throw(?PM_DUNGEON_INSIDE)
    ?End,

    GuildWar = lib_guild:get_guild_war_from_ets(GuildId),
    ?Ifc (GuildWar =:= null)
        throw(?PM_GUILD_PRE_WAR_NOT_OPENED)
    ?End,

    ?Ifc (GuildWar#guild_war.bid_id_list =:= [])
        throw(?PM_GUILD_NOT_SIGN_IN)
    ?End,

    ?Ifc (not is_pid_ok(GuildWar#guild_war.war_handle_pid))
        throw(?PM_GUILD_PRE_WAR_NOT_OPENED)
    ?End,

    ?Ifc ( (not is_pid_ok(GuildWar#guild_war.war_pre_dun_pid)) andalso (is_pid_ok(GuildWar#guild_war.war_dun_pid)) )
        throw(?PM_GUILD_PRE_WAR_END)
    ?End,

    ?Ifc (not is_pid_ok(GuildWar#guild_war.war_pre_dun_pid))
        throw(?PM_GUILD_PRE_WAR_NOT_OPENED)
    ?End,

    ?Ifc (player:is_in_team(PS))
        throw(?PM_GUILD_CANT_ENTER_WAR_IN_TEAM)
    ?End,

    {ok, GuildWar#guild_war.war_handle_pid}.




try_start_pk(PS, ObjPlayerId) ->
    case check_start_pk(PS, ObjPlayerId) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        {ok, _HandlePid} ->
            case check_start_pk_further(PS, ObjPlayerId) of
                {fail, Reason} ->
                    lib_send:send_prompt_msg(PS, Reason);
                {ok, PlayerInfo, ObjPlayer, TargetPS} ->
                    AttPhypower = 
                        case data_guild_sys_cfg:get(guild_war) of
                            null ->
                                ?ASSERT(false), 10;
                            SysCfg -> SysCfg#guild_sys_cfg.att_phy_power
                        end,
                    case player:get_team_id(PS) of
                        ?INVALID_ID ->
                            set_player_info(player:id(PS), PlayerInfo#player_info{phy_power = PlayerInfo#player_info.phy_power - AttPhypower, state = 1});
                        TeamId ->
                            case player:is_tmp_leave_team(PS) of
                                true ->
                                    set_player_info(player:id(PS), PlayerInfo#player_info{phy_power = PlayerInfo#player_info.phy_power - AttPhypower, state = 1});
                                false ->
                                    F = fun(Id) ->
                                        case get_player_info(Id) of
                                            null -> skip;
                                            Player ->
                                                set_player_info(Id, Player#player_info{phy_power = Player#player_info.phy_power - AttPhypower, state = 1})
                                        end
                                    end,
                                    [F(X) || X <- mod_team:get_normal_member_id_list(TeamId)]
                            end
                    end,
                    case player:get_team_id(TargetPS) of
                        ?INVALID_ID ->
                            set_player_info(ObjPlayerId, ObjPlayer#player_info{state = 1});
                        ObjTeamId ->
                            case player:is_tmp_leave_team(TargetPS) of
                                true ->
                                    set_player_info(ObjPlayerId, ObjPlayer#player_info{state = 1});
                                false ->
                                    F1 = fun(Id) ->
                                        case get_player_info(Id) of
                                            null -> skip;
                                            Player ->
                                                set_player_info(Id, Player#player_info{state = 1})
                                        end
                                    end,
                                    [F1(X) || X <- mod_team:get_normal_member_id_list(ObjTeamId)]
                            end
                    end,

                    mod_battle:start_guild_war_pk(PS, TargetPS, fun pk_callback/2)
            end
    end.


notify_player_change(LeftIdList, ObjGuildId, ObjGuildName, State) ->
    Length = length(LeftIdList),
    ObjGuild = get_guild_info(ObjGuildId),
    OtherPlayerCnt = 
        case ObjGuild =:= null of
            true -> 0;
            false -> length(ObjGuild#guild_info.left_id_list)
        end,
    LeftTime = State#state.war_start_time + State#state.war_time - util:unixtime(),
    F = fun(Id) ->
        CurPhyPower = 
            case get_player_info(Id) of
                null -> 0;
                Player -> Player#player_info.phy_power
            end,
        {ok, BinData} = pt_40:write(?PM_GUILD_GET_INFO_IN_GB, [CurPhyPower, ?GUILD_TOTAL_PHYPOWER, Length, OtherPlayerCnt, LeftTime, ObjGuildName]),
        lib_send:send_to_uid(Id, BinData)
    end,
    [F(X) || X <- LeftIdList],

    case ObjGuild =:= null of
        true -> skip;
        false ->
            F1 = fun(Id) ->
                CurPhyPower1 = 
                    case get_player_info(Id) of
                        null -> 0;
                        Player -> Player#player_info.phy_power
                    end,
                {ok, BinData1} = pt_40:write(?PM_GUILD_GET_INFO_IN_GB, [CurPhyPower1, ?GUILD_TOTAL_PHYPOWER, OtherPlayerCnt, Length, LeftTime, ObjGuild#guild_info.obj_guild_name]),
                lib_send:send_to_uid(Id, BinData1)
            end,
            [F1(X) || X <- ObjGuild#guild_info.left_id_list]
    end.


pk_callback_more(GuildId, Guild, PS, NewPlayer, State) ->
    case NewPlayer#player_info.phy_power =< 0 of
        false ->
            notify_player_change(Guild#guild_info.left_id_list, Guild#guild_info.obj_guild_id, Guild#guild_info.obj_guild_name, State);
        true ->
            case player:is_leader(PS) of
                true -> mod_team_mgr:do_quit_team(PS, false, true);
                false -> lib_dungeon:quit_dungeon(PS)
            end,
            NewGuild = Guild#guild_info{left_id_list = Guild#guild_info.left_id_list -- [player:id(PS)]},
            set_guild_info(GuildId, NewGuild),
            notify_player_change(NewGuild#guild_info.left_id_list, NewGuild#guild_info.obj_guild_id, NewGuild#guild_info.obj_guild_name, State)
    end.

check_finish(State) ->
    Guild = get_guild_info(State#state.guild_id),
    ObjGuild = get_guild_info(State#state.obj_guild_id),
    case Guild =:= null orelse ObjGuild =:= null of
        true -> 
            ?ERROR_MSG("mod_guild_war:check_finish error!~n", []),
            State;
        false ->
            if
                Guild#guild_info.left_id_list =:= [] andalso ObjGuild#guild_info.left_id_list =:= [] -> %% 两队无人去打则投标金额多的赢
                    case is_finish(State) of
                        true -> State;
                        false -> 
                            TotalBid = 
                                case lib_guild:get_guild_war_from_ets(State#state.guild_id) of
                                    null -> 0;
                                    GuildWar -> GuildWar#guild_war.total_bid
                                end,
                            ObjTotalBid = 
                                case lib_guild:get_guild_war_from_ets(State#state.obj_guild_id) of
                                    null -> 0;
                                    ObjGuildWar -> ObjGuildWar#guild_war.total_bid
                                end,
                            
                            WinGuildId = 
                                if
                                    TotalBid > ObjTotalBid ->
                                        State#state.guild_id;
                                    TotalBid < ObjTotalBid ->
                                        State#state.obj_guild_id;
                                    true ->
                                        State#state.guild_id
                                end,

                            %% 自动胜利 和 自动失败
                            handle_result(WinGuildId, State, true)
                    end;
                Guild#guild_info.left_id_list =:= [] ->
                    case is_finish(State) of
                        true -> State;
                        false -> handle_result(State#state.obj_guild_id, State)
                    end;
                ObjGuild#guild_info.left_id_list =:= [] ->
                    case is_finish(State) of
                        true -> State;
                        false -> handle_result(State#state.guild_id, State)
                    end;
                true ->
                    State
            end
    end.


force_finish_war(State) ->
    NewState = check_finish(State),
    case is_finish(NewState) of
        true -> 
            NewState;
        false ->
            Guild = get_guild_info(State#state.guild_id),
            ObjGuild = get_guild_info(State#state.obj_guild_id),
            case Guild =:= null orelse ObjGuild =:= null of
                true -> 
                    ?ERROR_MSG("mod_guild_war:check_finish error!~n", []),
                    NewState;
                false ->
                    SumPlayer = length(Guild#guild_info.left_id_list),
                    SumObjPlayer = length(ObjGuild#guild_info.left_id_list),
                    %% 先判断剩余人数
                    if
                        SumPlayer > SumObjPlayer ->
                            handle_result(State#state.guild_id, NewState);
                        SumPlayer < SumObjPlayer ->
                            handle_result(State#state.obj_guild_id, NewState);
                        true ->
                            F = fun(Id, Acc) ->
                                case get_player_info(Id) of
                                    null -> Acc;
                                    Player -> Player#player_info.phy_power + Acc
                                end
                            end,
                            SumPhyPower = lists:foldl(F, 0, Guild#guild_info.left_id_list),
                            SumObjPhyPower = lists:foldl(F, 0, ObjGuild#guild_info.left_id_list),
                            if %% 判断体力总和
                                SumPhyPower > SumObjPhyPower ->
                                    handle_result(State#state.guild_id, NewState);
                                SumPhyPower < SumObjPhyPower -> 
                                    handle_result(State#state.obj_guild_id, NewState);
                                true ->
                                    % F1 = fun(Id, Acc) ->
                                    %     case get_player_info(Id) of
                                    %         null -> Acc;
                                    %         Player -> Player#player_info.battle_power + Acc
                                    %     end
                                    % end,
                                    SumBattlePower = Guild#guild_info.battle_power,
                                    SumObjBattlePower = ObjGuild#guild_info.battle_power,
                                    ?DEBUG_MSG("mod_guild_war:force_finish_war:GuildName:~p,SumBattlePower:~p", [ObjGuild#guild_info.obj_guild_name, SumBattlePower]),
                                    ?DEBUG_MSG("mod_guild_war:force_finish_war:GuildName:~p,SumObjBattlePower:~p", [Guild#guild_info.obj_guild_name, SumObjBattlePower]),
                                    if  %% 判断战力和
                                        SumBattlePower > SumObjBattlePower ->
                                            handle_result(State#state.guild_id, NewState);
                                        SumBattlePower < SumObjBattlePower ->
                                            handle_result(State#state.obj_guild_id, NewState);
                                        true ->
                                            ?ERROR_MSG("mod_guild_war: force_finish_war error!~n", []),
                                            handle_result(State#state.guild_id, NewState)
                                    end
                            end
                    end
            end
    end.


%% 发奖励，告诉管理进程比赛结果
%% return NewState
handle_result(WinGuildId, State) ->
    handle_result(WinGuildId, State, false).

handle_result(WinGuildId, State, AutoRet) ->
    case is_finish(State) of
        true -> State;
        false ->
            ?DEBUG_MSG("mod_guild_war:handle_result begin!~n", []),
            %% 发奖励
            {RewardWin, RewardLose} = 
                case State#state.round of
                    1 -> {data_guild_war_reward:get(7), data_guild_war_reward:get(8)};
                    2 -> {data_guild_war_reward:get(5), data_guild_war_reward:get(6)};
                    3 -> {data_guild_war_reward:get(3), data_guild_war_reward:get(4)};
                    4 -> {data_guild_war_reward:get(1), data_guild_war_reward:get(2)};
                    _ ->
                        ?ERROR_MSG("mod_guild_war:data error!~n", []),
                        {null, null}
                end,

            ?ASSERT(RewardWin =/= null andalso RewardLose =/= null, {RewardWin, RewardLose}),
            
            {WinSlot, LoseGuildId} = 
                case State#state.guild_id =:= WinGuildId of
                    true -> {State#state.slot, State#state.obj_guild_id};
                    false -> {State#state.obj_slot, State#state.guild_id}
                end,

            mod_guild_mgr:add_prosper(WinGuildId, RewardWin#guild_war_reward.prosper),
            mod_guild_mgr:add_prosper(LoseGuildId, RewardLose#guild_war_reward.prosper),
            
            Title = <<"帮派争霸通知">>,
            ContentWin = <<"恭喜主人在帮派争霸中获得比赛的胜利，下面是主人获得的战利品，请主人查收哦！">>,
            ContentLose = <<"非常遗憾主人在帮派争霸中不幸落败，不要气馁下次帮派争霸再展雄风，下面是主人获得的奖励，请主人查收哦！">>,

            {ok, BinWin} = pt_40:write(?PM_GUILD_WAR_RET, [?RES_OK]),
            WinGuildChiefId = mod_guild:get_chief_id(WinGuildId),
            F = fun(Id) ->
                WinGoodsL = 
                    case State#state.round =:= 4 andalso Id =:= WinGuildChiefId of
                        true -> [{RewardWin#guild_war_reward.goods_no, ?BIND_ALREADY, 1}, {RewardWin#guild_war_reward.boss_goods_no, ?BIND_ALREADY, 1}];
                        false -> [{RewardWin#guild_war_reward.goods_no, ?BIND_ALREADY, 1}]
                    end,
                lib_mail:send_sys_mail(Id, Title, ContentWin, WinGoodsL, [?LOG_GUILD_BATTLE, "win_prize"]),
                lib_send:send_to_uid(Id, BinWin),
                ply_tips:send_sys_tips(Id, {guild_war_win, []})
            end,

            {ok, BinLose} = pt_40:write(?PM_GUILD_WAR_RET, [?RES_FAIL]),
            LoseGuildChiefId = mod_guild:get_chief_id(LoseGuildId),
            F1 = fun(Id) ->
                LoseGoodsL = 
                    case (State#state.round =:= 4 orelse State#state.round =:= 3) andalso Id =:= LoseGuildChiefId of
                        true -> [{RewardLose#guild_war_reward.goods_no, ?BIND_ALREADY, 1}, {RewardLose#guild_war_reward.boss_goods_no, ?BIND_ALREADY, 1}];
                        false -> [{RewardLose#guild_war_reward.goods_no, ?BIND_ALREADY, 1}]
                    end,
                lib_mail:send_sys_mail(Id, Title, ContentLose, LoseGoodsL, [?LOG_GUILD_BATTLE, "lose_prize"]),
                lib_send:send_to_uid(Id, BinLose),
                ply_tips:send_sys_tips(Id, {guild_war_lose, []})
            end,
            case get_guild_info(WinGuildId) of
                null ->
                    ?ERROR_MSG("mod_guild_war: give reward error!~n", []);
                WinGuild ->
                    [F(X) || X <- WinGuild#guild_info.player_id_list]
            end,
            case get_guild_info(LoseGuildId) of
                null ->
                    ?ERROR_MSG("mod_guild_war: give reward error!~n", []);
                LoseGuild ->
                    [F1(X) || X <- LoseGuild#guild_info.player_id_list]
            end,

            gen_server:cast(?GUILD_PROCESS, {'war_result', WinGuildId, WinSlot}),

            case AutoRet of %% 注意：如果比赛的轮回过程，解散了帮派，则等级是0
                true ->
                    lib_log:statis_guild_war(WinGuildId, mod_guild:get_lv(WinGuildId), "win_0"),
                    lib_log:statis_guild_war(LoseGuildId, mod_guild:get_lv(LoseGuildId), "lose_0");
                false ->
                    lib_log:statis_guild_war(WinGuildId, mod_guild:get_lv(WinGuildId), "win_1"),
                    lib_log:statis_guild_war(LoseGuildId, mod_guild:get_lv(LoseGuildId), "lose_1")
            end,

            State#state{finish = 1}
    end.


is_finish(State) ->
    State#state.finish =:= 1.


can_join_the_turn(PS, PlayerMisc, State) ->
    GuildId = player:get_guild_id(PS),
    GuildWarId = PlayerMisc#player_misc.guild_war_id,
    GuildWarTurn = PlayerMisc#player_misc.guild_war_turn,
    if
        GuildWarId =:= 0 andalso GuildWarTurn =:= 0 ->
            true;
        true ->
            if
                GuildWarTurn =/= State#state.turn ->
                    true;
                GuildWarId =:= GuildId ->
                    true;
                true -> %% 届数相等，帮派id不一样，说明换了帮派
                    false
            end
    end.
        
broadcast_pre_war_info(PS, State) ->
    case get_guild_info(player:get_guild_id(PS)) of
        null -> 
            skip;
        Guild ->
            Length = length(Guild#guild_info.sign_in_id_list),
            StartTime = State#state.pre_start_time + State#state.pre_time,

            F = fun(Id) ->     
                CurPhyPower = 
                    case get_player_info(Id) of
                        null -> 0;
                        Player -> Player#player_info.phy_power
                    end,
                {ok, BinData} = pt_40:write(?PM_GUILD_GET_INFO_BEFORE_GB, [CurPhyPower, ?GUILD_TOTAL_PHYPOWER, Length, StartTime]),
                lib_send:send_to_uid(Id, BinData)
            end,
            [F(X) || X <- Guild#guild_info.sign_in_id_list]
    end.

is_pid_ok(Pid) ->
    is_pid(Pid) andalso is_process_alive(Pid).    