%%%------------------------------------
%%% @author 段世和 
%%% @doc 帮派战.
%%% @end
%%%------------------------------------

-module(pp_guild_battle).
-export([handle/3]).

-include("common.hrl").
-include("record.hrl").
-include("player.hrl").
-include("prompt_msg_code.hrl").
-include("log.hrl").
-include("ets_name.hrl").
-include("guild_battle.hrl").
-include("pt_65.hrl").

%% 所有信息更新
handle(?PT_ENTER1, PS, []) -> 
    % 判断活动是否开启
    case mod_guild_battle:get_state() of
        ?GUILD_BATTLE_OPEN ->
            % 判断是否是决战期间
            case mod_guild_battle:check_is_duel_time() of
                true ->
                    lib_send:send_prompt_msg(PS, ?PM_GUILD_IN_DUEL),
                    skip;
                false ->
                    % 获取该玩家的帮战信息
                    case mod_guild_battle:get_guild_battle_info_by_player_id(player:id(PS)) of
                        GuildBattleInfo when is_record(GuildBattleInfo, guild_battle_player_info) ->
                            % 判断该玩家的帮战信息冷却时间
                            case GuildBattleInfo#guild_battle_player_info.halt_time of 
                                0 ->
                                    % 判断是否在队伍中
                                    case player:is_in_team(PS) of
                                        true ->
                                            % 可以进入
                                            % 这里让玩家直接进入 判断队伍人数是否大于指定人数
                                            TeamId = player:get_team_id(PS),
                                            case player:is_leader(PS) andalso 
                                                (mod_team:get_normal_member_count(TeamId) >= ?GUILD_TEAM_PLAYER_COUNT) of
                                                true ->
                                                    % 获取正常状态的队员列表
                                                    List = mod_team:get_normal_member_id_list(TeamId),
                                                    F = fun(PlayerId,Acc) ->
                                                        case mod_guild_battle:get_guild_battle_info_by_player_id(PlayerId) of
                                                            GuildBattleInfo1 when is_record(GuildBattleInfo1, guild_battle_player_info) ->
                                                                % 计算冷却时间
                                                                case Acc < GuildBattleInfo1#guild_battle_player_info.halt_time of
                                                                    true ->
                                                                        GuildBattleInfo1#guild_battle_player_info.halt_time;
                                                                    false ->
                                                                        Acc
                                                                end;
                                                            _ ->
                                                                Acc
                                                        end
                                                    end,

                                                    % 检测等级
                                                    FCheckLv = fun(PlayerId,Acc) ->
                                                        LvNeed = player:get_lv(PlayerId) >= ?ENTER_GUILD_LV,
                                                        case LvNeed of
                                                            true ->
                                                                skip;
                                                            false ->
                                                                {ok, BinData} = pt_65:write(?PT_SEND_PLAYER_LV_LIMIT, [PlayerId,player:get_name(PlayerId),player:get_lv(PlayerId)]),
                                                                lib_send:send_to_sock(PS, BinData) 
                                                        end,

                                                        Acc andalso LvNeed
                                                    end,

                                                    % 判断等级是否足够进入
                                                    LvCheck = lists:foldl(FCheckLv,true,List),
                                                    HaltTime = lists:foldl(F,0,List),

                                                    % ?DEBUG_MSG("~p,sddsd",[HaltTime]),

                                                    case HaltTime of
                                                        0 ->
                                                            % 进入
                                                            case LvCheck of
                                                                true ->
                                                                    lib_guild_battle:enter_to_1(PS);
                                                                false ->
                                                                    skip
                                                            end;
                                                        _ ->
                                                           {ok, BinData} = pt_65:write(?PT_ENTER1, HaltTime),
                                                            lib_send:send_to_sock(PS, BinData) 
                                                    end;

                                                false ->
                                                    lib_send:send_prompt_msg(PS, ?PM_RELA_MEMBER_NOT_ENOUGTH) 
                                            end;
                                        false ->
                                            % 将玩家传回基地
                                            % lib_guild_battle:enter_to_0(PS),
                                            lib_send:send_prompt_msg(PS, ?PM_RELA_MEMBER_NOT_ENOUGTH) 
                                    end,

                                    skip;
                                HaltTime1 ->
                                    % 提示冷却时间
                                    {ok, BinData} = pt_65:write(?PT_ENTER1, HaltTime1),
                                    lib_send:send_to_sock(PS, BinData)
                            end;
                        _ ->
                            lib_send:send_prompt_msg(PS, ?PM_PARA_ERROR)
                    end
            end;
        _ ->
            % lib_guild_battle:enter_to_0(PS),
            lib_send:send_prompt_msg(PS, ?PM_GUILD_BATTLE_NOT_OPEN)
    end,
    void;

handle(?PT_ENTER2, PS, [NpcId]) -> 
    case mod_guild_battle:get_state() of
        ?GUILD_BATTLE_OPEN ->
            case mod_guild_battle:get_guild_battle_info_by_player_id(player:id(PS)) of
                GuildBattleInfo when is_record(GuildBattleInfo, guild_battle_player_info) ->
                    % 这里处理一些事情
                    GuildBattleNpc = mod_guild_battle:get_guild_battle_npc_by_id(NpcId),

                    case player:is_in_team(PS) of
                        true ->
                            TeamId = player:get_team_id(PS),
                            case player:is_leader(PS) andalso 
                                (mod_team:get_normal_member_count(TeamId) >= ?GUILD_TEAM_PLAYER_COUNT) of
                                    true ->

                                    case GuildBattleNpc#guild_battle_npc.use_player_id of
                                        0 -> 
                                            % 没有被人使用则 开始使用
                                            NewGuildBattleNpc = GuildBattleNpc#guild_battle_npc{use_player_id = player:id(PS),use_guild_id=player:get_guild_id(PS)},
                                            mod_guild_battle:add_guild_battle_npc(NewGuildBattleNpc),
                                            NewGuildBattleInfo = GuildBattleInfo#guild_battle_player_info{cur_state = ?GUILD_BATTLE_READ2, cut_step_time = 0},
                                            mod_guild_battle:add_guild_battle_info(NewGuildBattleInfo),

                                            {ok, BinData} = pt_65:write(?PT_ENTER2, 0),
                                            lib_send:send_to_sock(PS, BinData);

                                        UsePlayerId ->
                                            case player:is_online(UsePlayerId) of
                                                true -> 
                                                    MyGuildId = player:get_guild_id(PS),
                                                    % 判断该玩家 是否跟自己是相同帮派
                                                    case GuildBattleNpc#guild_battle_npc.use_guild_id of                                
                                                        MyGuildId -> 
                                                            lib_send:send_prompt_msg(PS, ?PM_YOU_GUILD_INUSE);
                                                        _ ->

                                                            {ok, BinData1} = 
                                                            pt_65:write(?PT_LOAD_TIME, 
                                                                [
                                                                    UsePlayerId,
                                                                    GuildBattleNpc#guild_battle_npc.id,
                                                                    0
                                                                ]
                                                            ),

                                                            lib_send:send_to_AOI(UsePlayerId, BinData1),

                                                            % 进入战斗
                                                            TargetGuildBattleInfo = mod_guild_battle:get_guild_battle_info_by_player_id(UsePlayerId),
                                                            % 将正在使用传送门的玩家修改为闲置状态
                                                            NewTargetGuildBattleInfo = TargetGuildBattleInfo#guild_battle_player_info{cur_state = ?GUILD_BATTLE_IDLE,cut_step_time = 0},
                                                            mod_guild_battle:add_guild_battle_info(NewTargetGuildBattleInfo),

                                                            % 打断读条次数加1
                                                            NewGuildBattleInfo1 = GuildBattleInfo#guild_battle_player_info{interrupt_load = GuildBattleInfo#guild_battle_player_info.interrupt_load + 1},
                                                            mod_guild_battle:add_guild_battle_info(NewGuildBattleInfo1),

                                                            mod_guild_battle:try_start_pk(PS,UsePlayerId)
                                                    end,

                                                    {ok, BinData} = pt_65:write(?PT_ENTER2, 0),
                                                    lib_send:send_to_sock(PS, BinData);
                                                false ->
                                                    NewGuildBattleNpc = GuildBattleNpc#guild_battle_npc{use_player_id = player:id(PS),use_guild_id=player:get_guild_id(PS)},
                                                    mod_guild_battle:add_guild_battle_npc(NewGuildBattleNpc),
                                                    NewGuildBattleInfo = GuildBattleInfo#guild_battle_player_info{cur_state = ?GUILD_BATTLE_READ2, cut_step_time = 0},
                                                    mod_guild_battle:add_guild_battle_info(NewGuildBattleInfo),

                                                    {ok, BinData} = pt_65:write(?PT_ENTER2, 0),
                                                    lib_send:send_to_sock(PS, BinData)
                                            end
                                    end;
                                false ->
                                    lib_guild_battle:enter_to_0(PS),
                                    lib_send:send_prompt_msg(PS, ?PM_RELA_MEMBER_NOT_ENOUGTH) 
                            end;
                        false ->
                            lib_guild_battle:enter_to_0(PS)
                    end,

                    skip;
                _ ->
                    {ok, BinData} = pt_65:write(?PT_ENTER2, 1),
                    lib_send:send_to_sock(PS, BinData),
                    lib_send:send_prompt_msg(PS, ?PM_PARA_ERROR)
            end;
        _ ->
            lib_guild_battle:enter_to_0(PS),
            {ok, BinData} = pt_65:write(?PT_ENTER2, 1),
            lib_send:send_to_sock(PS, BinData),            
            lib_send:send_prompt_msg(PS, ?PM_GUILD_BATTLE_NOT_OPEN)
    end,
    void;

handle(?PT_ENTER3, PS, [NpcId]) -> 
    case mod_guild_battle:get_state() of
        ?GUILD_BATTLE_OPEN ->
            case mod_guild_battle:check_can_enter3() of
                true -> 
                    case mod_guild_battle:get_guild_battle_info_by_player_id(player:id(PS)) of
                        GuildBattleInfo when is_record(GuildBattleInfo, guild_battle_player_info) ->
                            % 这里处理一些事情
                            GuildBattleNpc = mod_guild_battle:get_guild_battle_npc_by_id(NpcId),

                            case player:is_in_team(PS) of
                                true ->
                                    TeamId = player:get_team_id(PS),
                                    case player:is_leader(PS) andalso 
                                        (mod_team:get_normal_member_count(TeamId) >= ?GUILD_TEAM_PLAYER_COUNT) of
                                        true ->
                                            case GuildBattleNpc#guild_battle_npc.use_player_id of
                                                0 -> 
                                                    % 没有被人使用则 开始使用
                                                    NewGuildBattleNpc = GuildBattleNpc#guild_battle_npc{use_player_id = player:id(PS),use_guild_id=player:get_guild_id(PS)},
                                                    mod_guild_battle:add_guild_battle_npc(NewGuildBattleNpc),
                                                    NewGuildBattleInfo = GuildBattleInfo#guild_battle_player_info{cur_state = ?GUILD_BATTLE_READ3, cut_step_time = 0},
                                                    mod_guild_battle:add_guild_battle_info(NewGuildBattleInfo),

                                                    {ok, BinData} = pt_65:write(?PT_ENTER3, 0),
                                                    lib_send:send_to_sock(PS, BinData);
                                                UsePlayerId ->
                                                    case player:is_online(UsePlayerId) of
                                                        true -> 
                                                            % 判断该玩家 是否跟自己是相同帮派
                                                            MyGuildId = player:get_guild_id(PS),
                                                            case GuildBattleNpc#guild_battle_npc.use_guild_id of
                                                                MyGuildId -> 
                                                                    lib_send:send_prompt_msg(PS, ?PM_YOU_GUILD_INUSE);
                                                                _ ->
                                                                    % 进入战斗
                                                                    {ok, BinData1} = 
                                                                    pt_65:write(?PT_LOAD_TIME, 
                                                                        [
                                                                            UsePlayerId,
                                                                            GuildBattleNpc#guild_battle_npc.id,
                                                                            0
                                                                        ]
                                                                    ),

                                                                    lib_send:send_to_AOI(UsePlayerId, BinData1),

                                                                    TargetGuildBattleInfo = mod_guild_battle:get_guild_battle_info_by_player_id(UsePlayerId),
                                                                    % 将正在使用传送门的玩家修改为闲置状态
                                                                    NewTargetGuildBattleInfo = TargetGuildBattleInfo#guild_battle_player_info{cur_state = ?GUILD_BATTLE_IDLE,cut_step_time = 0},
                                                                    mod_guild_battle:add_guild_battle_info(NewTargetGuildBattleInfo),

                                                                    mod_guild_battle:try_start_pk(PS,UsePlayerId)
                                                            end,

                                                            {ok, BinData} = pt_65:write(?PT_ENTER3, 0),
                                                            lib_send:send_to_sock(PS, BinData);
                                                        false ->
                                                            % 没有被人使用则 开始使用
                                                            NewGuildBattleNpc = GuildBattleNpc#guild_battle_npc{use_player_id = player:id(PS),use_guild_id=player:get_guild_id(PS)},
                                                            mod_guild_battle:add_guild_battle_npc(NewGuildBattleNpc),
                                                            NewGuildBattleInfo = GuildBattleInfo#guild_battle_player_info{cur_state = ?GUILD_BATTLE_READ3, cut_step_time = 0},
                                                            mod_guild_battle:add_guild_battle_info(NewGuildBattleInfo),

                                                            {ok, BinData} = pt_65:write(?PT_ENTER3, 0),
                                                            lib_send:send_to_sock(PS, BinData)
                                                    end
                                            end;
                                        false ->
                                            lib_guild_battle:enter_to_0(PS),
                                            lib_send:send_prompt_msg(PS, ?PM_RELA_MEMBER_NOT_ENOUGTH) 
                                    end;
                                false ->
                                    lib_guild_battle:enter_to_0(PS)
                            end,

                            skip;
                        _ ->
                            {ok, BinData} = pt_65:write(?PT_ENTER3, 1),
                            lib_send:send_to_sock(PS, BinData),

                            lib_send:send_prompt_msg(PS, ?PM_PARA_ERROR)
                    end;
                false ->
                    lib_send:send_prompt_msg(PS, ?PM_NOT_YET_ENTER_3)
            end;
        _ ->
            lib_guild_battle:enter_to_0(PS),
            lib_send:send_prompt_msg(PS, ?PM_GUILD_BATTLE_NOT_OPEN)
    end,
    void;

handle(?PT_TAKE, PS, [NpcId]) -> 
    case mod_guild_battle:get_state() of
        ?GUILD_BATTLE_OPEN ->
            case mod_guild_battle:get_guild_battle_info_by_player_id(player:id(PS)) of
                GuildBattleInfo when is_record(GuildBattleInfo, guild_battle_player_info) ->
                    % 这里处理一些事情
                    GuildBattleNpc = mod_guild_battle:get_guild_battle_npc_by_id(NpcId),

                    case player:is_in_team(PS) of
                        true ->
                            TeamId = player:get_team_id(PS),
                            case player:is_leader(PS) andalso 

                                (mod_team:get_normal_member_count(TeamId) >= ?GUILD_TEAM_PLAYER_COUNT) of
                                true ->
                                    case GuildBattleNpc#guild_battle_npc.use_player_id of
                                        0 -> 
                                            % 没有被人使用则 开始使用
                                            NewGuildBattleNpc = GuildBattleNpc#guild_battle_npc{use_player_id = player:id(PS),use_guild_id=player:get_guild_id(PS)},
                                            mod_guild_battle:add_guild_battle_npc(NewGuildBattleNpc),
                                            NewGuildBattleInfo = GuildBattleInfo#guild_battle_player_info{cur_state = ?GUILD_BATTLE_TAKE, cut_step_time = 0},
                                            mod_guild_battle:add_guild_battle_info(NewGuildBattleInfo),

                                            {ok, BinData} = pt_65:write(?PT_TAKE, 0),
                                            lib_send:send_to_sock(PS, BinData);

                                        UsePlayerId ->
                                            case player:is_online(UsePlayerId) of
                                                true -> 
                                                        % 判断该玩家 是否跟自己是相同帮派
                                                        MyGuildId = player:get_guild_id(PS),
                                                        case GuildBattleNpc#guild_battle_npc.use_guild_id of
                                                            MyGuildId -> 
                                                                lib_send:send_prompt_msg(PS, ?PM_YOU_GUILD_INUSE);
                                                            _ ->
                                                                % 触摸王座次数+1 避免中途取消所以进入战斗才算
                                                                GuildBattleGuldInfo_New = 
                                                                case mod_guild_battle:get_guild_battle_info_by_guild_id(player:get_guild_id(PS)) of
                                                                    GuildBattleGuldInfo when is_record(GuildBattleGuldInfo,guild_battle_guild_info) ->
                                                                        GuildBattleGuldInfo#guild_battle_guild_info{touch_throne = GuildBattleGuldInfo#guild_battle_guild_info.touch_throne + 1};
                                                                    _ ->
                                                                        #guild_battle_guild_info{touch_throne = 1}
                                                                end,

                                                                mod_guild_battle:update_guild_battle_guild_info_to_ets(GuildBattleGuldInfo_New),

                                                                TGuildBattleGuldInfo_New = 
                                                                case mod_guild_battle:get_guild_battle_info_by_guild_id(player:get_guild_id(UsePlayerId)) of
                                                                    TGuildBattleGuldInfo when is_record(TGuildBattleGuldInfo,guild_battle_guild_info) ->
                                                                        TGuildBattleGuldInfo#guild_battle_guild_info{touch_throne = TGuildBattleGuldInfo#guild_battle_guild_info.touch_throne + 1};
                                                                    _ ->
                                                                        #guild_battle_guild_info{touch_throne = 1}
                                                                end,

                                                                mod_guild_battle:update_guild_battle_guild_info_to_ets(TGuildBattleGuldInfo_New),

                                                                {ok, BinData1} = 
                                                                pt_65:write(?PT_LOAD_TIME, 
                                                                    [
                                                                        UsePlayerId,
                                                                        GuildBattleNpc#guild_battle_npc.id,
                                                                        0
                                                                    ]
                                                                ),

                                                                lib_send:send_to_AOI(UsePlayerId, BinData1),

                                                                % 进入战斗
                                                                TargetGuildBattleInfo = mod_guild_battle:get_guild_battle_info_by_player_id(UsePlayerId),
                                                                % 将正在使用传送门的玩家修改为闲置状态
                                                                NewTargetGuildBattleInfo = TargetGuildBattleInfo#guild_battle_player_info{cur_state = ?GUILD_BATTLE_IDLE,cut_step_time = 0},
                                                                mod_guild_battle:add_guild_battle_info(NewTargetGuildBattleInfo),

                                                                mod_guild_battle:try_start_pk(PS,UsePlayerId)
                                                        end,

                                                        {ok, BinData} = pt_65:write(?PT_TAKE, 0),
                                                        lib_send:send_to_sock(PS, BinData);
                                                    false ->
                                                         % 没有被人使用则 开始使用
                                                            NewGuildBattleNpc = GuildBattleNpc#guild_battle_npc{use_player_id = player:id(PS),use_guild_id=player:get_guild_id(PS)},
                                                            mod_guild_battle:add_guild_battle_npc(NewGuildBattleNpc),
                                                            NewGuildBattleInfo = GuildBattleInfo#guild_battle_player_info{cur_state = ?GUILD_BATTLE_TAKE, cut_step_time = 0},
                                                            mod_guild_battle:add_guild_battle_info(NewGuildBattleInfo),

                                                            {ok, BinData} = pt_65:write(?PT_TAKE, 0),
                                                            lib_send:send_to_sock(PS, BinData)
                                                end
                                    end;
                                false ->
                                    % 将玩家传回基地
                                    lib_guild_battle:enter_to_0(PS),
                                    lib_send:send_prompt_msg(PS, ?PM_RELA_MEMBER_NOT_ENOUGTH) 
                            end;
                        false ->
                            lib_guild_battle:enter_to_0(PS)
                    end,

                    skip;
                _ ->
                    {ok, BinData} = pt_65:write(?PT_TAKE, 1),
                            lib_send:send_to_sock(PS, BinData),
                    lib_send:send_prompt_msg(PS, ?PM_PARA_ERROR)
            end;
        _ ->
            {ok, BinData} = pt_65:write(?PT_TAKE, 1),
                            lib_send:send_to_sock(PS, BinData),
            lib_guild_battle:enter_to_0(PS),
            lib_send:send_prompt_msg(PS, ?PM_GUILD_BATTLE_NOT_OPEN)
    end,
    void;


handle(?PT_QUICK_CLEAR, PS, []) -> 
    case mod_guild_battle:get_state() of
        ?GUILD_BATTLE_OPEN ->
            case mod_guild_battle:get_guild_battle_info_by_player_id(player:id(PS)) of
                GuildBattleInfo when is_record(GuildBattleInfo, guild_battle_player_info) ->
                    % 这里处理一些事情
                    skip;
                _ ->
                    lib_send:send_prompt_msg(PS, ?PM_PARA_ERROR)
            end;
        _ ->
            lib_send:send_prompt_msg(PS, ?PM_GUILD_BATTLE_NOT_OPEN)
    end,
    void;

handle(?PT_QUICK_ENETR2, PS, []) -> 
    case mod_guild_battle:get_state() of
        ?GUILD_BATTLE_OPEN ->
            case mod_guild_battle:get_guild_battle_info_by_player_id(player:id(PS)) of
                GuildBattleInfo when is_record(GuildBattleInfo, guild_battle_player_info) ->
                    % 这里处理一些事情
                    skip;
                _ ->
                    lib_send:send_prompt_msg(PS, ?PM_PARA_ERROR)
            end;
        _ ->
            lib_send:send_prompt_msg(PS, ?PM_GUILD_BATTLE_NOT_OPEN)
    end,
    void;

handle(?PT_CANCEL_ENTER, PS, []) -> 
    case mod_guild_battle:get_state() of
        ?GUILD_BATTLE_OPEN ->
            case mod_guild_battle:get_guild_battle_info_by_player_id(player:id(PS)) of
                GuildBattleInfo when is_record(GuildBattleInfo, guild_battle_player_info) ->
                    
                    NewGuildBattleInfo = GuildBattleInfo#guild_battle_player_info{cur_state = ?GUILD_BATTLE_IDLE, cut_step_time = 0},

                    % 把NPC的使用玩家去掉
                    case mod_guild_battle:get_guild_battle_npc_by_usr_id(player:id(PS)) of
                        GuildBattleNpc when is_record(GuildBattleNpc,guild_battle_npc) ->
                            NewGuildBattleNpc = GuildBattleNpc#guild_battle_npc{use_player_id = 0,use_guild_id = 0},

                            {ok, BinData1} = 
                            pt_65:write(?PT_LOAD_TIME, 
                                [
                                    player:id(PS),
                                    GuildBattleNpc#guild_battle_npc.id,
                                    0
                                ]
                            ),

                            lib_send:send_to_AOI(player:id(PS), BinData1),
                            mod_guild_battle:add_guild_battle_npc(NewGuildBattleNpc);
                        Ot_ ->
                            ?DEBUG_MSG("Npc user id can not find the npc,~p",[Ot_]),
                            skip
                    end,



                    mod_guild_battle:add_guild_battle_info(NewGuildBattleInfo);

                _ ->
                    lib_send:send_prompt_msg(PS, ?PM_PARA_ERROR)
            end;
        _ ->
            lib_send:send_prompt_msg(PS, ?PM_GUILD_BATTLE_NOT_OPEN)
    end,
    void;

handle(?PT_GUILD_END_SEND, PS, [Rounds]) -> 
    % ?DEBUG_MSG("Rounds=~p,~p,[~p]",[Rounds,mod_guild_battle:get_rounds(),mod_guild_battle:get_state()]),

    GuildBattleHistory =
    case (Rounds < mod_guild_battle:get_rounds() andalso Rounds > 0) of
        true ->
            ?DEBUG_MSG("--------------------5",[]),
            lib_guild_battle:guild_battle_history_by_rounds(Rounds);
        false ->
            case (Rounds == mod_guild_battle:get_rounds() andalso mod_guild_battle:get_state() == ?GUILD_BATTLE_END) of
                true ->
                    ?DEBUG_MSG("--------------------4",[]),
                    lib_guild_battle:guild_battle_history_by_rounds(Rounds);
                false ->
                    ?DEBUG_MSG("--------------------3",[]),
                    null
            end
    end,

    % ?DEBUG_MSG("GuildBattleHistory=~p",[GuildBattleHistory]),

    case GuildBattleHistory of 
        null -> skip;
        _GuildBattleHistory when is_record(_GuildBattleHistory, guild_battle_history) ->
            GuildBattleInfo = case lib_guild_battle:guild_battle_info_load_by_rounds_and_player_id(Rounds,player:id(PS)) of 
                null -> #guild_battle_player_info{};
                GuildBattleInfo_ when is_record(GuildBattleInfo_,guild_battle_player_info) -> GuildBattleInfo_;
                _ -> #guild_battle_player_info{}
            end,
            ?DEBUG_MSG("GuildBattleInfo=~p",[GuildBattleInfo]),

            case GuildBattleInfo of
                null -> skip;
                _GuildBattleInfo when is_record(_GuildBattleInfo,guild_battle_player_info) ->

                    {ok, BinData} = pt_65:write(?PT_GUILD_END_SEND, [1,GuildBattleHistory,GuildBattleInfo]),
                    lib_send:send_to_sock(PS, BinData)
            end
    end,

    void;

handle(?PT_GET_CUR_GUILD_INFO, PS, []) -> 
    Rounds = mod_guild_battle:get_rounds(),
    State = mod_guild_battle:get_state(),
    Time = mod_guild_battle:get_time(),

    ?DEBUG_MSG("Rounds=~p,State=~p,Time=~p",[Rounds,State,Time]),

    {ok, BinData} = pt_65:write(?PT_GET_CUR_GUILD_INFO, [Rounds,State,Time]),
    lib_send:send_to_sock(PS, BinData),

    void;

handle(?PT_GET_GUILD_BATTLE_PLAYER_RANK, PS, [Rounds]) -> 
    List = lib_guild_battle:guild_battle_info_load(Rounds),
    PlayerCount = lib_guild_battle:get_guild_battle_player_count(Rounds),
    MyRank = lib_guild_battle:get_guild_battle_my_rank(Rounds,player:id(PS)),

    ?DEBUG_MSG("PlayerCount=~p,MyRank=~p",[PlayerCount,MyRank]),

    {ok, BinData} = pt_65:write(?PT_GET_GUILD_BATTLE_PLAYER_RANK, [Rounds,PlayerCount,MyRank,List]),
    lib_send:send_to_sock(PS, BinData),

    void;

% 帮派排行信息
handle(?PT_GET_GUILD_BATTLE_GUILD_RANK, PS, [Rounds]) -> 
    List = lib_guild_battle:guild_battle_guild_info_load(Rounds),
    GuildCount = lib_guild_battle:get_guild_battle_guild_count(Rounds),
    MyRank = case player:get_guild_id(PS) of
        ?INVALID_ID -> 0;
        GuildId -> lib_guild_battle:get_guild_battle_my_guild_rank(Rounds,GuildId)
    end,

    ?DEBUG_MSG("GuildCount=~p,MyRank=~p",[GuildCount,MyRank]),

    {ok, BinData} = pt_65:write(?PT_GET_GUILD_BATTLE_GUILD_RANK, [Rounds,GuildCount,MyRank,List]),
    lib_send:send_to_sock(PS, BinData),

    void;

handle(_Msg, _PS, _) ->
    ?WARNING_MSG("unknown handle ~p", [_Msg]),
    error.