%%%-----------------------------------
%%% @Module  : lib_guild_battle
%%% @Author  : 段世和
%%% @Email   : 
%%% @Created : 2015.12.25
%%% @Description: 帮战
%%%-----------------------------------

-module(lib_guild_battle).

% include
-include("common.hrl").
-include("guild_battle.hrl").
-include("goods.hrl").
-include("ets_name.hrl").
-include("abbreviate.hrl").
-include("log.hrl").

-include("record.hrl").
-include("debug.hrl").
-include("pt_65.hrl").
-include("scene.hrl").
-include("record/guild_record.hrl").

-compile(export_all).

% 从数据库加载帮战个人信息
get_guild_battle_player_count(Rounds) ->
    try
        Ret = db:select_count(guild_battle_player_info, [{rounds, Rounds}]),
        ?DEBUG_MSG("Ret=~p",[Ret]),
        Ret
    catch
        _:Reason ->
            ?DEBUG_MSG("Reason~p",[Reason]),
            0
    end.

% 获取自己的排名
get_guild_battle_my_rank(Rounds,PlayerId) ->
    try 
        case db:select_one(guild_battle_player_info, "`rank`", [{rounds, Rounds},{player_id,PlayerId}]) of
            Rank when is_integer(Rank) ->
                Rank;
            _ -> 0
        end
    catch
        _:Reason ->
            0
    end.


guild_battle_info_load(Rounds) ->
	 try 
        All = case db:select_all(guild_battle_player_info, "*", [{rounds, Rounds}]) of
            [] -> [];
            List -> 
                F = fun([_,PlayerId, Rounds, GuildId, GuildName,
                    HaltTime, Enter1_count,Enter1_time,Enter2_count,Enter2_time,Enter3_count,Enter3_time,
                    TouchThrone,Interrupt_load,Battle_win,Battle_lose,Max_winning_streak,
                	QuickEnetr2Count,QuickClearHaltTimeCount,Point,Rank], Acc) ->

                    [#guild_battle_player_info{
                    	player_id = PlayerId,
						rounds = Rounds,
						guild_id = GuildId,
                        guild_name = GuildName,

						halt_time = HaltTime,
						enter1_count = Enter1_count,
						enter1_time = Enter1_time,
						enter2_count = Enter2_count,
						enter2_time = Enter2_time,
						enter3_count = Enter3_count,
						enter3_time = Enter3_time,

						touch_throne = TouchThrone,
                        interrupt_load = Interrupt_load,
						battle_win = Battle_win,
						battle_lose = Battle_lose,
						max_winning_streak = Max_winning_streak,

						quick_enetr2_count = QuickEnetr2Count,
						quick_clear_halt_time_count = QuickClearHaltTimeCount,
                        point = Point,
                        rank = Rank

					} | Acc]
                end,

                lists:foldl(F, [],List)
        end
    catch
        _:Reason ->
            fail
    end.

% 从数据库加载帮战个人信息
guild_battle_info_load_by_rounds_and_player_id(Rounds,PlayerId) ->
     try 
        case db:select_all(guild_battle_player_info, "*", [{rounds, Rounds},{player_id,PlayerId}]) of
            [GuildBattleInfo] ->

            [_,PlayerId, Rounds, GuildId, GuildName,
            HaltTime, Enter1_count,Enter1_time,Enter2_count,Enter2_time,Enter3_count,Enter3_time,
            TouchThrone,Interrupt_load,Battle_win,Battle_lose,Max_winning_streak,
            QuickEnetr2Count,QuickClearHaltTimeCount,Point,Rank] = GuildBattleInfo,

                    #guild_battle_player_info{
                        player_id = PlayerId,
                        rounds = Rounds,
                        guild_id = GuildId,
                        guild_name = GuildName,

                        halt_time = HaltTime,
                        enter1_count = Enter1_count,
                        enter1_time = Enter1_time,
                        enter2_count = Enter2_count,
                        enter2_time = Enter2_time,
                        enter3_count = Enter3_count,
                        enter3_time = Enter3_time,

                        touch_throne = TouchThrone,
                        interrupt_load = Interrupt_load,
                        battle_win = Battle_win,
                        battle_lose = Battle_lose,
                        max_winning_streak = Max_winning_streak,

                        quick_enetr2_count = QuickEnetr2Count,
                        quick_clear_halt_time_count = QuickClearHaltTimeCount,
                        point = Point,
                        rank = Rank

                    };
            _Ot ->
                ?DEBUG_MSG("not find data _Ot=~p",[_Ot]),
                null
        end
    catch
        _:Reason ->
            fail
    end.

% 保存或者更新
sava_guild_battle_info_to_db(GuildBattleInfo) when is_record(GuildBattleInfo, guild_battle_player_info) ->
    try
        Player_id = GuildBattleInfo#guild_battle_player_info.player_id,
		Rounds = GuildBattleInfo#guild_battle_player_info.rounds,
		Guild_id = GuildBattleInfo#guild_battle_player_info.guild_id,
        Guild_name = GuildBattleInfo#guild_battle_player_info.guild_name,

		Halt_time = GuildBattleInfo#guild_battle_player_info.halt_time,
		Enter1_count = GuildBattleInfo#guild_battle_player_info.enter1_count,
		Enter1_time = GuildBattleInfo#guild_battle_player_info.enter1_time,
		Enter2_count = GuildBattleInfo#guild_battle_player_info.enter2_count,
		Enter2_time = GuildBattleInfo#guild_battle_player_info.enter2_time,
		Enter3_count = GuildBattleInfo#guild_battle_player_info.enter3_count,
		Enter3_time = GuildBattleInfo#guild_battle_player_info.enter3_time,
		Touch_throne = GuildBattleInfo#guild_battle_player_info.touch_throne,

        Interrupt_load = GuildBattleInfo#guild_battle_player_info.interrupt_load,

		Battle_win = GuildBattleInfo#guild_battle_player_info.battle_win,
		Battle_lose = GuildBattleInfo#guild_battle_player_info.battle_lose,
		Winning_streak = GuildBattleInfo#guild_battle_player_info.max_winning_streak,
		Quick_enetr2_count = GuildBattleInfo#guild_battle_player_info.quick_enetr2_count,
		Quick_clear_halt_time_count = GuildBattleInfo#guild_battle_player_info.quick_clear_halt_time_count,

        Point = GuildBattleInfo#guild_battle_player_info.point,
        Rank = GuildBattleInfo#guild_battle_player_info.rank,

        % 打印数据信息
        ?DEBUG_MSG("Player_id=~p,Rounds=~p, Guild_id=~p,Guild_name=~p,
                Halt_time=~p,Enter1_count=~p,Enter1_time=~p,Enter2_count=~p,Enter2_time=~p,Enter3_count=~p,Enter3_time=~p,
                Touch_throne=~p,Battle_win=~p,Battle_lose=~p,Winning_streak=~p,
                Quick_enetr2_count=~p,Quick_clear_halt_time_count=~p,Point=~p,Rank=~p",[Player_id,Rounds, Guild_id,Guild_name,
                Halt_time,Enter1_count,Enter1_time,Enter2_count,Enter2_time,Enter3_count,Enter3_time,
                Touch_throne,Battle_win,Battle_lose,Winning_streak,
                Quick_enetr2_count,Quick_clear_halt_time_count,Point,Rank]),

        db:insert_or_update(guild_battle_player_info,
            [
            	player_id,rounds,guild_id,guild_name,
                halt_time,enter1_count,enter1_time,enter2_count,enter2_time,enter3_count,enter3_time,
            	touch_throne,interrupt_load,battle_win,battle_lose,max_winning_streak,
                quick_enetr2_count,quick_clear_halt_time_count,point,rank
            ], 
        	[
                Player_id,Rounds, Guild_id,Guild_name,
                Halt_time,Enter1_count,Enter1_time,Enter2_count,Enter2_time,Enter3_count,Enter3_time,
    			Touch_throne,Interrupt_load,Battle_win,Battle_lose,Winning_streak,
                Quick_enetr2_count,Quick_clear_halt_time_count,Point,Rank
            ])
    catch
        _:Reason ->
            fail
    end.

% -------------------------------------------------------
% 从数据库加载帮战个人信息
get_guild_battle_guild_count(Rounds) ->
    try
        Ret = db:select_count(guild_battle_guild_info, [{rounds, Rounds}]),
        ?DEBUG_MSG("Ret=~p",[Ret]),

        Ret
    catch
        _:Reason ->
            ?DEBUG_MSG("Reason~p",[Reason]),
            0
    end.

% 获取自己的排名
get_guild_battle_my_guild_rank(Rounds,GuildId) ->
    try 
        case db:select_one(guild_battle_guild_info, "`rank`", [{rounds, Rounds},{guild_id,GuildId}]) of
            Rank when is_integer(Rank) ->
                Rank;
            _ -> 0
        end
    catch
        _:Reason ->
            0
    end.

% 从数据库加载帮战帮派信息
guild_battle_guild_info_load(Rounds) ->
     try 
        All = case db:select_all(guild_battle_guild_info, "*", [{rounds, Rounds}]) of
            [] -> [];
            List -> 
                F = fun(
                    [_,
                        Rounds,
                        Guild_id,
                        Guild_name,
                        Rank,
                        Join_battle_player_count,
                        Battle_count,
                        Battle_win_count,
                        Touch_throne,
                        Point
                    ], Acc) ->

                    [#guild_battle_guild_info{
                        rounds = Rounds,
                        guild_id = Guild_id,
                        guild_name = Guild_name,
                        rank = Rank,
                        join_battle_player_count = Join_battle_player_count,
                        battle_count = Battle_count,
                        battle_win_count = Battle_win_count,
                        touch_throne = Touch_throne,
                        point = Point
                    } | Acc]
                end,

                lists:foldl(F, [],List)
        end
    catch
        _:Reason ->
            fail
    end.

% 保存或者更新
sava_guild_battle_guild_info_to_db(GuildBattleGuildInfo) when is_record(GuildBattleGuildInfo, guild_battle_guild_info) ->
    try
        Rounds = GuildBattleGuildInfo#guild_battle_guild_info.rounds,
        Guild_id = GuildBattleGuildInfo#guild_battle_guild_info.guild_id,
        % Guild_name = ply_guild:try_fast_get_guild_name(Guild_id),

        Guild_name = 
            case ply_guild:try_fast_get_guild_name(Guild_id) of  % 处理AOI时会获取玩家的帮派名，故这里尝试快速获取！
                {ok, GuildName} ->
                    GuildName;
                fail ->
                    case mod_guild:get_info(Guild_id) of
                        null ->
                            <<"">>;
                        Guild ->
                            ply_guild:cache_map_of_guild_id_to_guild_name(Guild_id, Guild#guild.name),
                            Guild#guild.name
                    end
            end,

        Rank = GuildBattleGuildInfo#guild_battle_guild_info.rank,
        Join_battle_player_count = GuildBattleGuildInfo#guild_battle_guild_info.join_battle_player_count,
        Battle_count = GuildBattleGuildInfo#guild_battle_guild_info.battle_count,
        Battle_win_count = GuildBattleGuildInfo#guild_battle_guild_info.battle_win_count,
        Touch_throne = GuildBattleGuildInfo#guild_battle_guild_info.touch_throne,
        Point = GuildBattleGuildInfo#guild_battle_guild_info.point,

        ?DEBUG_MSG("Rounds~p,Guild_id~p,Guild_name~p,Rank~p,Join_battle_player_count~p,Battle_count~p,Battle_win_count~p,Touch_throne~p,Point~p",[Rounds,Guild_id,Guild_name,Rank,Join_battle_player_count,Battle_count,Battle_win_count,Touch_throne,Point]),

        db:insert_or_update(guild_battle_guild_info,
            [
                rounds,
                guild_id,
                guild_name,
                rank,
                join_battle_player_count,
                battle_count,
                battle_win_count,
                touch_throne,
                point
            ], 
            [
                Rounds,
                Guild_id,
                Guild_name,
                Rank,
                Join_battle_player_count,
                Battle_count,
                Battle_win_count,
                Touch_throne,
                Point
            ])
    catch
        _:Reason ->
            fail
    end.

% 从数据库加载历史记录到ets
guild_battle_history_by_rounds(Rounds) ->
    try 
        case db:select_all(guild_battle_history, "*", [{rounds,Rounds}]) of            
            [GuildBattleInfo] ->
            % ?DEBUG_MSG("XX=~p",XX),

            [
                Rounds,Join_battle_player_count,Join_battle_guild_count,
                Better_fighter_name,Better_fighter_player_id,Better_touch_throne_name,
                Better_touch_throne_player_id,Better_trouble_name,Better_trouble_player_id,
                Better_streak_name,Better_streak_player_id,Better_try_name,Better_try_player_id,
                Better_defend_name,Better_defend_player_id,
                Join_battle_max_rate,Join_battle_max_rate_guild_id,Join_battle_max_rate_guild_name,
                Join_battle_max_count,Join_battle_max_count_guild_id,Join_battle_max_count_guild_name,Win_guild_id,
                Win_guild_name,Take_throne_player_id,Take_throne_player_name
            ] = GuildBattleInfo,

            #guild_battle_history{
                rounds = Rounds,
                join_battle_player_count = Join_battle_player_count,
                join_battle_guild_count = Join_battle_guild_count,
                better_fighter_name = Better_fighter_name,
                better_fighter_player_id = Better_fighter_player_id,
                better_touch_throne_name = Better_touch_throne_name,
                better_touch_throne_player_id = Better_touch_throne_player_id,
                better_trouble_name = Better_trouble_name,
                better_trouble_player_id = Better_trouble_player_id,
                better_streak_name = Better_streak_name,
                better_streak_player_id = Better_streak_player_id,
                better_try_name = Better_try_name,
                better_try_player_id = Better_try_player_id,

                better_defend_name = Better_defend_name,
                better_defend_player_id = Better_defend_player_id,

                join_battle_max_rate = Join_battle_max_rate,
                join_battle_max_rate_guild_id = Join_battle_max_rate_guild_id,
                join_battle_max_rate_guild_name = Join_battle_max_rate_guild_name,
                join_battle_max_count = Join_battle_max_count,
                join_battle_max_count_guild_id = Join_battle_max_count_guild_id,
                join_battle_max_count_guild_name = Join_battle_max_count_guild_name,
                win_guild_id = Win_guild_id,
                win_guild_name = Win_guild_name,
                take_throne_player_id = Take_throne_player_id,
                take_throne_player_name = Take_throne_player_name
            } ;
            _Ot -> 
                ?DEBUG_MSG("_Ot = ~p,",[_Ot]),
                null
        end
    catch
        _:Reason ->
            ?DEBUG_MSG("Reason = ~p,",[Reason]),
            null
    end.

% 从数据库加载历史记录到ets
guild_battle_history_load() ->
    try 
        All = case db:select_all(guild_battle_history, "*", [],[{"rounds desc"}],[5]) of
            [] -> [];
            List -> 
                F = fun([
                        Rounds,Join_battle_player_count,Join_battle_guild_count,
                        Better_fighter_name,Better_fighter_player_id,Better_touch_throne_name,
                        Better_touch_throne_player_id,Better_trouble_name,Better_trouble_player_id,
                        Better_streak_name,Better_streak_player_id,Better_try_name,Better_try_player_id,
                        Better_defend_name,Better_defend_player_id,
                        Join_battle_max_rate,Join_battle_max_rate_guild_id,Join_battle_max_rate_guild_name,
                        Join_battle_max_count,Join_battle_max_count_guild_id,Join_battle_max_count_guild_name,Win_guild_id,
                        Win_guild_name,Take_throne_player_id,Take_throne_player_name
                    ], Acc) ->

                    [#guild_battle_history{
                        rounds = Rounds,
                        join_battle_player_count = Join_battle_player_count,
                        join_battle_guild_count = Join_battle_guild_count,
                        better_fighter_name = Better_fighter_name,
                        better_fighter_player_id = Better_fighter_player_id,
                        better_touch_throne_name = Better_touch_throne_name,
                        better_touch_throne_player_id = Better_touch_throne_player_id,
                        better_trouble_name = Better_trouble_name,
                        better_trouble_player_id = Better_trouble_player_id,
                        better_streak_name = Better_streak_name,
                        better_streak_player_id = Better_streak_player_id,
                        better_try_name = Better_try_name,
                        better_try_player_id = Better_try_player_id,

                        better_defend_name = Better_defend_name,
                        better_defend_player_id = Better_defend_player_id,


                        join_battle_max_rate = Join_battle_max_rate,
                        join_battle_max_rate_guild_id = Join_battle_max_rate_guild_id,
                        join_battle_max_rate_guild_name = Join_battle_max_rate_guild_name,
                        join_battle_max_count = Join_battle_max_count,
                        join_battle_max_count_guild_id = Join_battle_max_count_guild_id,
                        join_battle_max_count_guild_name = Join_battle_max_count_guild_name,
                        win_guild_id = Win_guild_id,
                        win_guild_name = Win_guild_name,
                        take_throne_player_id = Take_throne_player_id,
                        take_throne_player_name = Take_throne_player_name
                    } | Acc]
                end,

                lists:foldl(F, [],List)
        end
    catch
        _:Reason ->
            fail
    end.

% 插入历史记录
save_guild_battle_history_to_db(Guild_battle_history) when is_record(Guild_battle_history,guild_battle_history) ->
    try
        % 插入历史数据到数据库
        db:insert_or_update(guild_battle_history, [
            rounds,
            join_battle_player_count,
            join_battle_guild_count,
            better_fighter_name,
            better_fighter_player_id,
            better_touch_throne_name,
            better_touch_throne_player_id,
            better_trouble_name,
            better_trouble_player_id,
            better_streak_name,
            better_streak_player_id,
            better_try_name,
            better_try_player_id,

            better_defend_name,
            better_defend_player_id,

            join_battle_max_rate,
            join_battle_max_rate_guild_id,
            join_battle_max_rate_guild_name,
            join_battle_max_count,
            join_battle_max_count_guild_id,
            join_battle_max_count_guild_name,
            win_guild_id,
            win_guild_name,
            take_throne_player_id,
            take_throne_player_name
            ], [
                Guild_battle_history#guild_battle_history.rounds,
                Guild_battle_history#guild_battle_history.join_battle_player_count,
                Guild_battle_history#guild_battle_history.join_battle_guild_count,
                Guild_battle_history#guild_battle_history.better_fighter_name,
                Guild_battle_history#guild_battle_history.better_fighter_player_id,
                Guild_battle_history#guild_battle_history.better_touch_throne_name,
                Guild_battle_history#guild_battle_history.better_touch_throne_player_id,
                Guild_battle_history#guild_battle_history.better_trouble_name,
                Guild_battle_history#guild_battle_history.better_trouble_player_id,
                Guild_battle_history#guild_battle_history.better_streak_name,
                Guild_battle_history#guild_battle_history.better_streak_player_id,
                Guild_battle_history#guild_battle_history.better_try_name,
                Guild_battle_history#guild_battle_history.better_try_player_id,

                Guild_battle_history#guild_battle_history.better_defend_name,
                Guild_battle_history#guild_battle_history.better_defend_player_id,

                Guild_battle_history#guild_battle_history.join_battle_max_rate,
                Guild_battle_history#guild_battle_history.join_battle_max_rate_guild_id,
                Guild_battle_history#guild_battle_history.join_battle_max_rate_guild_name,
                Guild_battle_history#guild_battle_history.join_battle_max_count,
                Guild_battle_history#guild_battle_history.join_battle_max_count_guild_id,
                Guild_battle_history#guild_battle_history.join_battle_max_count_guild_name,
                Guild_battle_history#guild_battle_history.win_guild_id,
                Guild_battle_history#guild_battle_history.win_guild_name,
                Guild_battle_history#guild_battle_history.take_throne_player_id,
                Guild_battle_history#guild_battle_history.take_throne_player_name
            ])
    catch
        _:Reason ->
            fail
    end.

%% -s上面是数据库操作------------------------------------------------------------------------------------------------------------------------------------------------------

% 返回帮派
enter_to_0(PS) when is_record(PS,player_status) ->
    TelepCfg = ply_scene:get_teleport_cfg_data(202),
    case ply_guild:try_teleport_to_guild_scene(PS, TelepCfg#teleport.target_scene_no, TelepCfg#teleport.target_xy) of
        ok -> done;
        {fail, Reason} -> lib_send:send_prompt_msg(PS, Reason)
    end,

    case mod_guild_battle:get_guild_battle_info_by_player_id(player:id(PS)) of
        GuildBattleInfo when is_record(GuildBattleInfo, guild_battle_player_info) ->
            % 设置玩家状态为休息 每次进入帮派将冷却90秒
            NewGuildBattleInfo = GuildBattleInfo#guild_battle_player_info{
                cur_state = ?GUILD_BATTLE_IDLE,
                halt_time = ?GUILD_BALT_TIME
            },
            mod_guild_battle:add_guild_battle_info(NewGuildBattleInfo),

            void;
        _ ->
            void
    end,

    case mod_guild_battle:get_guild_battle_npc_by_usr_id(player:id(PS)) of
        GuildBattleNpc when is_record(GuildBattleNpc,guild_battle_npc) ->
            NewGuildBattleNpc = GuildBattleNpc#guild_battle_npc{use_player_id = 0,use_guild_id = 0},
            mod_guild_battle:add_guild_battle_npc(NewGuildBattleNpc);
        Ot_ ->
            ?DEBUG_MSG("Npc user id can not find the npc,~p",[Ot_]),
            skip
    end,

    void.

% 进入第1区域
enter_to_1(PS) when is_record(PS,player_status) -> 
    case player:is_in_team(PS) andalso player:is_leader(PS) of
        true ->
            TeamId = player:get_team_id(PS),
            List = mod_team:get_all_member_id_list(TeamId),

            F = fun(PlayerId) ->
                case mod_guild_battle:get_guild_battle_info_by_player_id(PlayerId) of
                    GuildBattleInfo when is_record(GuildBattleInfo, guild_battle_player_info) ->
                        NewGuildBattleInfo = GuildBattleInfo#guild_battle_player_info{
                            cur_state = ?GUILD_BATTLE_IDLE,
                            enter1_count = GuildBattleInfo#guild_battle_player_info.enter1_count + 1
                        },

                        mod_guild_battle:add_guild_battle_info(NewGuildBattleInfo),

                        GuildBattleGuldInfo_New =
                        case mod_guild_battle:get_guild_battle_info_by_guild_id(player:get_guild_id(PS)) of
                            GuildBattleGuldInfo when is_record(GuildBattleGuldInfo,guild_battle_guild_info) ->
                                GuildBattleGuldInfo#guild_battle_guild_info{
                                    battle_count = GuildBattleGuldInfo#guild_battle_guild_info.battle_count + 1,
                                    battle_win_count = GuildBattleGuldInfo#guild_battle_guild_info.battle_win_count + 1
                                };
                            _ ->
                                #guild_battle_guild_info{
                                    guild_id = player:get_guild_id(PS),
                                    % guild_name = mod_guild:get_name_by_id(player:get_guild_id(PS)),
                                    rounds = mod_guild_battle:get_rounds(),
                                    battle_win_count = 1,
                                    battle_count = 1
                                }
                        end,

                        mod_guild_battle:update_guild_battle_guild_info_to_ets(GuildBattleGuldInfo_New),
                        void;
                    _ ->
                        void
                end
            end,

            lists:foreach(F,List),
            void;
        false ->
            void
    end,

    case mod_guild_battle:get_guild_battle_npc_by_usr_id(player:id(PS)) of
        GuildBattleNpc when is_record(GuildBattleNpc,guild_battle_npc) ->
            NewGuildBattleNpc = GuildBattleNpc#guild_battle_npc{use_player_id = 0,use_guild_id = 0},
            mod_guild_battle:add_guild_battle_npc(NewGuildBattleNpc);
        _ ->
            ?DEBUG_MSG("Npc user id can not find the npc",[]),
            skip
    end,

    {SceneId,X,Y} = ?GUILD_ENTER1_CONFIG,
    ?DEBUG_MSG("teleport ~p,~p,~p",[SceneId,X,Y]),
    ply_scene:do_teleport(PS, SceneId, X, Y).   

% 进入第2区域
enter_to_2(PS) when is_record(PS,player_status) ->
        case player:is_in_team(PS) andalso player:is_leader(PS) of
        true ->
            TeamId = player:get_team_id(PS),
            List = mod_team:get_all_member_id_list(TeamId),

            F = fun(PlayerId) ->
                case mod_guild_battle:get_guild_battle_info_by_player_id(PlayerId) of
                    GuildBattleInfo when is_record(GuildBattleInfo, guild_battle_player_info) ->
                        NewGuildBattleInfo = GuildBattleInfo#guild_battle_player_info{
                            cur_state = ?GUILD_BATTLE_IDLE,
                            enter1_count = GuildBattleInfo#guild_battle_player_info.enter2_count + 1
                        },

                        mod_guild_battle:add_guild_battle_info(NewGuildBattleInfo),
                        void;
                    _ ->
                        void
                end
            end,

            lists:foreach(F,List),
            void;
        false ->
            void
    end,

    case mod_guild_battle:get_guild_battle_npc_by_usr_id(player:id(PS)) of
        GuildBattleNpc when is_record(GuildBattleNpc,guild_battle_npc) ->
            NewGuildBattleNpc = GuildBattleNpc#guild_battle_npc{use_player_id = 0,use_guild_id = 0},
            mod_guild_battle:add_guild_battle_npc(NewGuildBattleNpc);
        _ ->
            ?DEBUG_MSG("Npc user id can not find the npc",[]),
            skip
    end,

    {SceneId,X,Y} = ?GUILD_ENTER2_CONFIG,
    ply_scene:do_teleport(PS, SceneId, X, Y). 

    
% 进入第3区域
enter_to_3(PS) when is_record(PS,player_status) ->
        case player:is_in_team(PS) andalso player:is_leader(PS) of
        true ->
            TeamId = player:get_team_id(PS),
            List = mod_team:get_all_member_id_list(TeamId),

            F = fun(PlayerId) ->
                case mod_guild_battle:get_guild_battle_info_by_player_id(PlayerId) of
                    GuildBattleInfo when is_record(GuildBattleInfo, guild_battle_player_info) ->
                        NewGuildBattleInfo = GuildBattleInfo#guild_battle_player_info{
                            cur_state = ?GUILD_BATTLE_IDLE,
                            enter1_count = GuildBattleInfo#guild_battle_player_info.enter3_count + 1
                        },

                        mod_guild_battle:add_guild_battle_info(NewGuildBattleInfo),
                        void;
                    _ ->
                        void
                end
            end,

            lists:foreach(F,List),
            void;
        false ->
            void
    end,

    case mod_guild_battle:get_guild_battle_npc_by_usr_id(player:id(PS)) of
        GuildBattleNpc when is_record(GuildBattleNpc,guild_battle_npc) ->
            NewGuildBattleNpc = GuildBattleNpc#guild_battle_npc{use_player_id = 0,use_guild_id = 0},
            mod_guild_battle:add_guild_battle_npc(NewGuildBattleNpc);
        _ ->
            ?DEBUG_MSG("Npc user id can not find the npc",[]),
            skip
    end,

    {SceneId,X,Y} = ?GUILD_ENTER3_CONFIG,
    ply_scene:do_teleport(PS, SceneId, X, Y).   


% ----------------发送战报给所有在线玩家
send_result_to_all_online_player(GuildBattleHistory) ->
    % skip.
    F2 = fun(PlayerID) -> 
        PS = player:get_PS(PlayerID),
        % ?DEBUG_MSG("open_slotmachine~p",[14]),
        % 如果该玩家在线的话
        case player:is_online(PlayerID) of
            true ->
                GuildBattleInfo = mod_guild_battle:get_guild_battle_info_by_player_id(PlayerID),

                {ok, BinData} = pt_65:write(?PT_GUILD_END_SEND, [0,GuildBattleHistory,GuildBattleInfo]),
                lib_send:send_to_uid(PlayerID, BinData);
            false ->
                skip
        end
    end,
    lists:foreach(F2, mod_svr_mgr:get_all_online_player_ids()),

    void.



% 计算奖励
calc_reward_by_class(Class) ->
    NoList = data_guild_battle_reward:get_no_list_by_class(Class),
    weight_list_rand(NoList).

weight_list_rand(List) ->    
    Range = 
    lists:foldl(
        fun(No, A) -> 
            #guild_battle_reward_cfg{widget=W} = data_guild_battle_reward:get(No),
            A+W 
        end, 0, List),

    RandNum = util:rand(1, Range),

    weight_list_rand(List,RandNum).

% 获取随机特效信息
weight_list_rand(List, RandNum) ->
    weight_list_rand(List, RandNum, 0).

weight_list_rand([H | T], RandNum, SumToCompare) ->
    #guild_battle_reward_cfg{reward_pool_no=PoolNo,widget=W} = data_guild_battle_reward:get(H),

    SumToCompare_2 = W + SumToCompare,

    case RandNum =< SumToCompare_2 of
        true -> 
            PoolNo;
        false ->
            weight_list_rand(T, RandNum, SumToCompare_2)
    end;

weight_list_rand([], _RandNum, _SumToCompare) ->
    0.
