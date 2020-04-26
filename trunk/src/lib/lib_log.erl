%%%-----------------------------------
%%% @Module  : lib_log
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2011.06.23
%%%-----------------------------------
-module(lib_log).
-include("record.hrl").
-include("common.hrl").
-include("log.hrl").
-include("offline_data.hrl").
-include("record/battle_record.hrl").
-compile(export_all).

-define(SERVER_ID, config:get_server_id()).
-define(PACK_LOG(Module, Data), ?ADMIN_MSG(admin_log_format([{"file", Module}, admin_log_time() | Data]))).

-define(PACK_ROLE_LOG(Data), ?ADMIN_MSG(admin_log_format([{"service", "ny"}, admin_log_time(), {"server_id", ?SERVER_ID} | Data]))).
% -define(PACK_LOG(Module, Data), skip).


%% =======================================
%% 上下线
%% =======================================
-define(LOG_File_LOGIN, "login").
login(Status) when is_record(Status, player_status) ->
    ?PACK_LOG(?LOG_File_LOGIN, 
        [
         {"server_id", ?SERVER_ID},
         {"rid", player:id(Status)},
         {"name", player:get_name(Status)},
         {"account", player:get_accname(Status)}
        ]);
login(_Arg) -> 
    ?ERROR_MSG("log login Arg is not player_status, Arg = ~p~n", [_Arg]), 
    skip.

-define(LOG_File_LOGOUT, "logout").
logout(Status) when is_record(Status, player_status) ->
    ?PACK_LOG(?LOG_File_LOGOUT, 
        [
         {"server_id", ?SERVER_ID},
         {"rid", player:id(Status)},
         {"name", player:get_name(Status)},
         {"account", player:get_accname(Status)}
        ]);
logout(_Arg) ->
    ?ERROR_MSG("log logout Arg is not player_status, Arg = ~p~n", [_Arg]),
    skip.


%% =======================================
%% 战斗记录
%% ======================================= 
-define(LOG_FILE_BATTLE, "battle").

statis_battle(Status, FeekBack) ->
    ?PACK_LOG(?LOG_FILE_BATTLE, 
        [
        {"server_id", ?SERVER_ID},
        {"rid", player:id(Status)},
        {"lv", player:get_lv(Status)},
        {"faction", player:get_faction(Status)},
        {"battle_power", ply_attr:get_battle_power(Status)},
        {"action", FeekBack#btl_feedback.battle_subtype},
        {"team_id", case player:get_team_id(Status) of 0 -> ""; Int -> Int end},
        {"opponent_id", get_opponent_id(FeekBack)},
        {"employee_rid", FeekBack#btl_feedback.hired_player_id},
        {"round_num", FeekBack#btl_feedback.lasting_rounds},
        {"is_win", ?BIN_PRED(FeekBack#btl_feedback.result == win, 1, 0)}
        ]).

get_opponent_id(FeekBack) ->
    try get_opponent_id_(FeekBack) of
        Val -> Val
    catch
        _:_ -> "error"
    end.

get_opponent_id_(FeekBack) ->
    if  FeekBack#btl_feedback.battle_subtype == 3 orelse FeekBack#btl_feedback.battle_subtype == 2 -> 
            [Id | _] = FeekBack#btl_feedback.oppo_player_id_list,
            Id;
        FeekBack#btl_feedback.battle_subtype == 5 orelse FeekBack#btl_feedback.battle_subtype == 6 -> 
            [Id | _] = FeekBack#btl_feedback.oppo_player_id_list,
            case player:get_team_id(Id) of
                ?INVALID_ID -> Id;
                Int -> Int
            end;
        FeekBack#btl_feedback.battle_subtype == 1 orelse FeekBack#btl_feedback.battle_subtype == 7 -> 
            FeekBack#btl_feedback.bmon_group_no;
        true -> ""
    end.


%% =======================================
%% 宝石镶嵌摘取
%% ======================================= 
-define(LOG_GEMSTONE_INLAY_UNLOAD, stonelog).
%% 镶嵌
statis_inlay_gemstone(Status, StoneNo, StoneId, EquipId, HoleNo, EquipNo) ->
    ?PACK_LOG(?LOG_GEMSTONE_INLAY_UNLOAD, 
        [
         {"server_id", ?SERVER_ID},
         {"rid", player:id(Status)},
         {"lv", player:get_lv(Status)},
         {"action", 1},
         {"stone_no", StoneNo},
         {"stone_id", StoneId},
         {"equip_no", EquipNo},
         {"equip_id", EquipId},
         {"hole_no", HoleNo}
        ]).

%% 摘取
statis_unload_gemstone(Status, StoneNo, StoneId, EquipId, HoleNo) ->
    ?PACK_LOG(?LOG_GEMSTONE_INLAY_UNLOAD, 
        [
         {"server_id", ?SERVER_ID},
         {"rid", player:id(Status)},
         {"lv", player:get_lv(Status)},
         {"action", 0},
         {"stone_no", StoneNo},
         {"stone_id", StoneId},
         {"equip_id", EquipId},
         {"hole_no", HoleNo}
        ]).


%% =======================================
%% 任务
%% =======================================
-define(LOG_File_TASK, "task").

task_accept(TaskId, Status) ->
    task(TaskId, Status, 1).

task_finish(TaskId, Status) ->
    task(TaskId, Status, 2).

task_submit(TaskId, Status) ->
    task(TaskId, Status, 3).

task(TaskId, Status, Action) ->
    ?PACK_LOG(?LOG_File_TASK, 
        [{"rid", player:id(Status)},
         {"lv", player:get_lv(Status)},
         {"server_id", ?SERVER_ID},
         {"activity_id", TaskId},
         {"action", Action}
        ]).
    % ?ADMIN_MSG(Data).


%% =======================================
%% 宠物
%% =======================================
-define(LOG_FILE_PARTNER, "partnerlog").

partner_get(PetId, PetNo, Status, Activity) ->
    partner(PetId, PetNo, Status, 1, Activity).

partner_release(PetId, PetNo, Status) ->
    partner(PetId, PetNo, Status, 0, "release").



partner(PetId, PetNo, Status, Action, Activity) ->
    ?PACK_LOG(?LOG_FILE_PARTNER,
        [{"server_id", ?SERVER_ID}, {"action", Action}, {"partner_id", PetId}, {"rid", player:id(Status)},
         {"activity", Activity}, {"partner_no", PetNo}
        ]).


%% =======================================
%% 在线统计
%% =======================================
-define(LOG_FILE_ONLINE, "online").

statis_online(Num) ->
    ?PACK_LOG(?LOG_FILE_ONLINE, [{"server_id", ?SERVER_ID}, {"num", Num}]).


%% =======================================
%% 活动统计
%% =======================================
-define(LOG_FILE_ACTIVITY, "activity").

%% 女妖乱斗
statis_melee(Status, DragonBalls, Time, SceneId) ->
    ?PACK_LOG(?LOG_FILE_ACTIVITY, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", player:id(Status)},
         {"lv", player:get_lv(Status)},
         {"battle_power", ply_attr:get_battle_power(Status)},
         {"faction", player:get_faction(Status)},
         {"activity_type", "melee"},
         {"activity", SceneId},
         {"state", DragonBalls},
         {"state_type", 4},
         {"team_num", ""},
         {"team_id", ""},
         {"ltime", Time}
         ]).
statis_melee(Id, Lv, BattlePower, Faction, DragonBalls, Time, SceneId) ->
    ?PACK_LOG(?LOG_FILE_ACTIVITY, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", Id},
         {"lv", Lv},
         {"battle_power", BattlePower},
         {"faction", Faction},
         {"activity_type", "melee"},
         {"activity", SceneId},
         {"state", DragonBalls},
         {"state_type", 4},
         {"team_num", ""},
         {"team_id", ""},
         {"ltime", Time}
         ]).


%% 装备进阶
statis_equip_upgrade_quality(Status, EqNo, State) ->
    ?PACK_LOG(?LOG_FILE_ACTIVITY, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", player:id(Status)},
         {"lv", player:get_lv(Status)},
         {"battle_power", ply_attr:get_battle_power(Status)},
         {"faction", player:get_faction(Status)},
         {"activity_type", "equip_evolve"},
         {"activity", EqNo},
         {"state", State},
         {"state_type", 0},
         {"team_num", ""},
         {"team_id", ""},
         {"ltime", ""}
         ]).


%% 女妖选美抽奖
statis_beauty_contest(Status, RewardNo, Index) ->
    ?PACK_LOG(?LOG_FILE_ACTIVITY, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", player:id(Status)},
         {"lv", player:get_lv(Status)},
         {"battle_power", ply_attr:get_battle_power(Status)},
         {"faction", player:get_faction(Status)},
         {"activity_type", "beauty_contest"},
         {"activity", RewardNo},
         {"state", Index},
         {"state_type", 1},
         {"team_num", ""},
         {"team_id", ""},
         {"ltime", ""}
         ]).

%% 女妖选美刷新
statis_beauty_refresh(Status) ->
    ?PACK_LOG(?LOG_FILE_ACTIVITY, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", player:id(Status)},
         {"lv", player:get_lv(Status)},
         {"battle_power", ply_attr:get_battle_power(Status)},
         {"faction", player:get_faction(Status)},
         {"activity_type", "beauty_contest"},
         {"activity", "fresh"},
         {"state", 1},
         {"state_type", 2},
         {"team_num", ""},
         {"team_id", ""},
         {"ltime", ""}
         ]).


%% 宠物技能学习
%% @State : 1->新开格子 0->替换技能
statis_partner_get_skill(Status, SkillNo, State) ->
    ?PACK_LOG(?LOG_FILE_ACTIVITY, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", player:id(Status)},
         {"lv", player:get_lv(Status)},
         {"battle_power", ply_attr:get_battle_power(Status)},
         {"faction", player:get_faction(Status)},
         {"activity_type", "pet_skill"},
         {"activity", SkillNo},
         {"state", State},
         {"state_type", 4},
         {"team_num", ""},
         {"team_id", ""},
         {"ltime", ""}
         ]).


%% 爬塔
statis_tower(Status, Type, Floor) ->
    ?PACK_LOG(?LOG_FILE_ACTIVITY, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", player:id(Status)},
         {"lv", player:get_lv(Status)},
         {"battle_power", ply_attr:get_battle_power(Status)},
         {"faction", player:get_faction(Status)},
         {"activity_type", "tower"},
         {"activity", Type},
         {"state", Floor},
         {"state_type", 1},
         {"team_num", ""},
         {"team_id", ""},
         {"ltime", ""}
         ]).
%% 活跃度
statis_activity_degree(Status, Point) ->
    TeamId = case player:get_team_id(Status) of 0 -> ""; Int -> Int end,
    TeamNum = ?BIN_PRED(TeamId =:= "", 1, mod_team:get_member_count(TeamId)),
    ?PACK_LOG(?LOG_FILE_ACTIVITY, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", player:id(Status)},
         {"lv", player:get_lv(Status)},
         {"battle_power", ply_attr:get_battle_power(Status)},
         {"faction", player:get_faction(Status)},
         {"activity_type", "activity_degree"},
         {"activity", "get"},
         {"state", Point},
         {"state_type", 2},
         {"team_num", TeamNum},
         {"team_id", TeamId},
         {"ltime", ""}
         ]).
%% 竞技场
statis_offline_arena(Status, Group, Rank) when is_record(Status, player_status) ->
    ?PACK_LOG(?LOG_FILE_ACTIVITY, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", player:id(Status)},
         {"lv", player:get_lv(Status)},
         {"battle_power", ply_attr:get_battle_power(Status)},
         {"faction", player:get_faction(Status)},
         {"activity_type", "offline_arena"},
         {"activity", Group},
         {"state", Rank},
         {"state_type", 0},
         {"team_num", ""},
         {"team_id", ""},
         {"ltime", ""}
         ]);
statis_offline_arena(RoleId, Group, Rank) when is_integer(RoleId) ->
    case player:get_PS(RoleId) of
        Status when is_record(Status, player_status) -> 
            statis_offline_arena(Status, Group, Rank);
        _ -> skip
    end.
%% 答题
%% @Result:: boolean()
statis_answer(Status, Result) ->
    Activity = ?BIN_PRED(Result, "right", "wrong"),
    TeamId = case player:get_team_id(Status) of 0 -> ""; Int -> Int end,
    TeamNum = ?BIN_PRED(TeamId =:= "", 1, mod_team:get_member_count(TeamId)),
    ?PACK_LOG(?LOG_FILE_ACTIVITY, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", player:id(Status)},
         {"lv", player:get_lv(Status)},
         {"battle_power", ply_attr:get_battle_power(Status)},
         {"faction", player:get_faction(Status)},
         {"activity_type", "answer"},
         {"activity", Activity},
         {"state", case Activity =:= "right" of true -> 1; false -> 0 end},
         {"state_type", 2},
         {"team_num", TeamNum},
         {"team_id", TeamId},
         {"ltime", ""}
         ]).

%% 比武大会
%% @Result :: "win"|"lose"
statis_arena_1v1(Status, Result, RivalFaction) when is_record(Status, player_status) ->
    ?PACK_LOG(?LOG_FILE_ACTIVITY, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", player:id(Status)},
         {"lv", player:get_lv(Status)},
         {"battle_power", ply_attr:get_battle_power(Status)},
         {"faction", player:get_faction(Status)},
         {"activity_type", "arena_1v1"},
         {"activity", RivalFaction},
         {"state", Result},
         {"state_type", 4},
         {"team_num", ""},
         {"team_id", ""},
         {"ltime", ""}
         ]);
statis_arena_1v1(SelfId, Result, RivalId) -> 
    case mod_offline_data:get_offline_role_brief(SelfId) of
        Brief when is_record(Brief, offline_role_brief) ->
            case mod_offline_data:get_offline_role_brief(RivalId) of
                Rival when is_record(Rival, offline_role_brief) ->
                    ?PACK_LOG(?LOG_FILE_ACTIVITY, 
                        [{"server_id", ?SERVER_ID}, 
                         {"rid", SelfId},
                         {"lv", Brief#offline_role_brief.lv},
                         {"battle_power", Brief#offline_role_brief.battle_power},
                         {"faction", Brief#offline_role_brief.faction},
                         {"activity_type", "arena_1v1"},
                         {"activity", Rival#offline_role_brief.faction},
                         {"state", Result},
                         {"state_type", 4},
                         {"team_num", ""},
                         {"team_id", ""},
                         {"ltime", ""}
                         ]);
                _ -> skip
            end;
        _ -> skip
    end.

% 世界BOSS
statis_world_boss(BossHp, IsDead, LastTime) ->
    ?PACK_LOG(?LOG_FILE_ACTIVITY, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", ""},
         {"lv", ""},
         {"battle_power", ""},
         {"faction", ""},
         {"activity_type", "world_boss"},
         {"activity", BossHp},
         {"state", IsDead},
         {"state_type", 0},
         {"team_num", ""},
         {"team_id", ""},
         {"ltime", LastTime}
         ]).

%% 开始运镖
start_transport(Status, TruckLv) ->
    ?PACK_LOG(?LOG_FILE_ACTIVITY, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", player:id(Status)},
         {"lv", player:get_lv(Status)},
         {"battle_power", ply_attr:get_battle_power(Status)},
         {"faction", player:get_faction(Status)},
         {"activity_type", "transport"},
         {"activity", "begin"},
         {"state", TruckLv},
         {"state_type", 4},
         {"team_num", 1},
         {"team_id", ""},
         {"ltime", ""}
         ]).


hijack_transport_win(RoleId, TruckLv) when is_integer(RoleId) ->
    case player:get_PS(RoleId) of
        Status when is_record(Status, player_status) -> hijack_transport_win(Status, TruckLv);
        _ -> skip
    end;
hijack_transport_win(Status, TruckLv) when is_record(Status, player_status) ->
    ?PACK_LOG(?LOG_FILE_ACTIVITY, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", player:id(Status)},
         {"lv", player:get_lv(Status)},
         {"battle_power", ply_attr:get_battle_power(Status)},
         {"faction", player:get_faction(Status)},
         {"activity_type", "transport"},
         {"activity", "rob_win"},
         {"state", TruckLv},
         {"state_type", 4},
         {"team_num", 1},
         {"team_id", ""},
         {"ltime", ""}
         ]).


hijack_transport_lose(RoleId, TruckLv) when is_integer(RoleId) ->
    case player:get_PS(RoleId) of
        Status when is_record(Status, player_status) -> hijack_transport_lose(Status, TruckLv);
        _ -> skip
    end;
hijack_transport_lose(Status, TruckLv) when is_record(Status, player_status) ->
    ?PACK_LOG(?LOG_FILE_ACTIVITY, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", player:id(Status)},
         {"lv", player:get_lv(Status)},
         {"battle_power", ply_attr:get_battle_power(Status)},
         {"faction", player:get_faction(Status)},
         {"activity_type", "transport"},
         {"activity", "rob_lose"},
         {"state", TruckLv},
         {"state_type", 4},
         {"team_num", 1},
         {"team_id", ""},
         {"ltime", ""}
         ]).


%% 装备重铸
statis_equip_recast(Status, EquipId, PreAttr, NowAttr) ->
    Act = tool:to_list(PreAttr) ++ "_" ++ tool:to_list(NowAttr),
    ?PACK_LOG(?LOG_FILE_ACTIVITY, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", player:id(Status)},
         {"lv", player:get_lv(Status)},
         {"battle_power", ply_attr:get_battle_power(Status)},
         {"faction", player:get_faction(Status)},
         {"activity_type", "recast"},
         {"activity", Act},
         {"state", EquipId},
         {"state_type", 0},
         {"team_num", ""},
         {"team_id", ""},
         {"ltime", ""}
         ]).
    

%% 装备精炼
statis_equip_refine(Status, EquipId, Attr, PreLv, NowLv) ->
    Act = tool:to_list(Attr) ++ "_" ++ tool:to_list(PreLv) ++ "_" ++ tool:to_list(NowLv),
    ?PACK_LOG(?LOG_FILE_ACTIVITY, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", player:id(Status)},
         {"lv", player:get_lv(Status)},
         {"battle_power", ply_attr:get_battle_power(Status)},
         {"faction", player:get_faction(Status)},
         {"activity_type", "refine"},
         {"activity", Act},
         {"state", EquipId},
         {"state_type", 0},
         {"team_num", ""},
         {"team_id", ""},
         {"ltime", ""}
         ]).


%% 装备升级
statis_equip_upgrade(Status, EquipId, PreLv, NowLv) ->
    Act = tool:to_list(PreLv) ++ "_" ++ tool:to_list(NowLv),
    ?PACK_LOG(?LOG_FILE_ACTIVITY, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", player:id(Status)},
         {"lv", player:get_lv(Status)},
         {"battle_power", ply_attr:get_battle_power(Status)},
         {"faction", player:get_faction(Status)},
         {"activity_type", "upgrade_lv"},
         {"activity", Act},
         {"state", EquipId},
         {"state_type", ""},
         {"team_num", ""},
         {"team_id", ""},
         {"ltime", ""}
         ]).


%% =======================================
%% 剧情跳过记录
%% ======================================= 
plot_skip_record(RoleId, State) ->
    ?PACK_LOG(?LOG_FILE_ACTIVITY, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", RoleId},
         % {"lv", player:get_lv(Status)},
         % {"battle_power", ply_attr:get_battle_power(Status)},
         % {"faction", player:get_faction(Status)},
         {"activity_type", "flash"},
         {"activity", State}
         % {"state", ""},
         % {"state_type", 0},
         % {"team_num", ""},
         % {"team_id", ""},
         % {"ltime", ""}
         ]).

%% =======================================
%% 装备销毁统计
%% =======================================
-define(LOG_FILE_EQUIP_DTY, "equip_destroy").
statis_equip_dty(RoleId, RoleLv, GoodsId) ->
    ?PACK_LOG(?LOG_FILE_EQUIP_DTY, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", RoleId},
         {"lv", RoleLv},
         {"equip_id", GoodsId}
         ]).

%% =======================================
%% 帮派创建/解散统计
%% =======================================
-define(LOG_FILE_GUILD_STATE, "guildlog").

%% 帮战
%% @State 帮战状态 ："sign" 报名  "pitch" 竞标成功  "battle" 备战 "win" 胜利 "lose" 失败
statis_guild_war(GuildId, GuildLv, State) ->
    ?PACK_LOG(?LOG_FILE_GUILD_STATE, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", ""},
         {"lv", ""},
         {"action", "guild_battle"},
         {"state", State},
         {"guild_id", GuildId},
         {"guild_lv", GuildLv}
         ]).


%% 创建帮派
statis_guild_create(RoleId, Lv, GuildId, GuildLv) ->
    ?PACK_LOG(?LOG_FILE_GUILD_STATE, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", RoleId},
         {"lv", Lv},
         {"action", 1},
         {"state", ""},
         {"guild_id", GuildId},
         {"guild_lv", GuildLv}
         ]).

%% 主动解散帮派
statis_guild_diss(RoleId, Lv, GuildId, GuildLv) ->
    ?PACK_LOG(?LOG_FILE_GUILD_STATE, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", RoleId},
         {"lv", Lv},
         {"action", 0},
         {"state", 1},
         {"guild_id", GuildId},
         {"guild_lv", GuildLv}
         ]).

%% 被动解散帮派
statis_guild_pasi_diss(GuildId, GuildLv) ->
    ?PACK_LOG(?LOG_FILE_GUILD_STATE, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", ""},
         {"lv", ""},
         {"action", 0},
         {"state", 2},
         {"guild_id", GuildId},
         {"guild_lv", GuildLv}
         ]).

%% 完成帮派副本
statis_pass_guild_dungeon(GuildId, GuildLv, Floor) ->
    ?PACK_LOG(?LOG_FILE_GUILD_STATE, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", ""},
         {"lv", ""},
         {"action", "fb"},
         {"state", Floor},
         {"guild_id", GuildId},
         {"guild_lv", GuildLv}
         ]).

%% 帮派加菜
statis_guild_party(RoleId, Lv, GuildId, GuildLv, PartyLv) ->
    ?PACK_LOG(?LOG_FILE_GUILD_STATE, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", RoleId},
         {"lv", Lv},
         {"action", "party"},
         {"state", PartyLv},
         {"guild_id", GuildId},
         {"guild_lv", GuildLv}
         ]).


%% =======================================
%% 副本统计
%% =======================================
-define(LOG_FILE_DUNGEON, "dungeon").
statis_dungeon_in(Status, DunNo, Diff, TeamNum) ->
    ?PACK_LOG(?LOG_FILE_DUNGEON, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", player:id(Status)},
         {"lv", player:get_lv(Status)},
         {"battle_power", ply_attr:get_battle_power(Status)},
         {"faction", player:get_faction(Status)},
         {"action", 1},
         {"dungeon_id", DunNo},
         {"is_pass", ""},
         {"diff", Diff},
         {"team_num", TeamNum},
         {"team_id", case player:get_team_id(Status) of 0 -> ""; Int -> Int end},
         {"score", ""},
         {"ltime", ""}
         ]).

statis_dungeon_out(Status, Pass, DunNo, Diff, TeamNum, ScoreLv, Ltime) ->
    ?PACK_LOG(?LOG_FILE_DUNGEON, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", player:id(Status)},
         {"lv", player:get_lv(Status)},
         {"battle_power", ply_attr:get_battle_power(Status)},
         {"faction", player:get_faction(Status)},
         {"action", 0},
         {"dungeon_id", DunNo},
         {"is_pass", Pass},
         {"diff", Diff},
         {"team_num", TeamNum},
         {"team_id", case player:get_team_id(Status) of 0 -> ""; Int -> Int end},
         {"score", ScoreLv},
         {"ltime", Ltime}
         ]).

statis_dungeon_out(RoleId, RoleLv, BattlePower, Faction, Pass, DunNo, Diff, TeamNum, ScoreLv, Ltime) ->
    ?PACK_LOG(?LOG_FILE_DUNGEON, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", RoleId},
         {"lv", RoleLv},
         {"battle_power", BattlePower},
         {"faction", Faction},
         {"action", 0},
         {"dungeon_id", DunNo},
         {"is_pass", Pass},
         {"diff", Diff},
         {"team_num", TeamNum},
         {"team_id", ""},
         {"score", ScoreLv},
         {"ltime", Ltime}
         ]).

%% =======================================
%% 拍卖行统计
%% =======================================
-define(LOG_FILE_MARKET, "sell").
%% 寄售物品
statis_market_sell(Status, GoodsNo, GoodsId, GoodsNum, ManFreeType, ManFree, SellPrice, PriceType) ->
    ?PACK_LOG(?LOG_FILE_MARKET, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", player:id(Status)},
         {"lv", player:get_lv(Status)},
         {"action", 1},
         {"item_type", GoodsNo},
         {"item_id", GoodsId},
         {"item_num", GoodsNum},
         {"trans_item_type", get_log_monery_type(PriceType)},
         {"trans_item_id", ""},
         {"trans_item_num", SellPrice},
         {"tax_type", get_log_monery_type(ManFreeType)},
         {"tax_num", ManFree},
         {"from_rid", ""}
         ]).
%% 续费
statis_market_renew(Status, GoodsNo, GoodsId, GoodsNum, ManFreeType, ManFree, SellPrice, PriceType) ->
    ?PACK_LOG(?LOG_FILE_MARKET, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", player:id(Status)},
         {"lv", player:get_lv(Status)},
         {"action", 2},
         {"item_type", GoodsNo},
         {"item_id", GoodsId},
         {"item_num", GoodsNum},
         {"trans_item_type", PriceType},
         {"trans_item_id", ""},
         {"trans_item_num", SellPrice},
         {"tax_type", get_log_monery_type(ManFreeType)},
         {"tax_num", ManFree},
         {"from_rid", ""}
         ]).
%% 购买
statis_market_buy(Status, MoneyType, MoneyNum, GoodsNo, GoodsId, GoodsNum, TaxType, Tax, FromId) ->
    ?PACK_LOG(?LOG_FILE_MARKET, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", player:id(Status)},
         {"lv", player:get_lv(Status)},
         {"action", 3},
         {"item_type", get_log_monery_type(MoneyType)},
         {"item_id", ""},
         {"item_num", MoneyNum},
         {"trans_item_type", GoodsNo},
         {"trans_item_id", GoodsId},
         {"trans_item_num", GoodsNum},
         {"tax_type", get_log_monery_type(TaxType)},
         {"tax_num", Tax},
         {"from_rid", FromId}
         ]).

%% 撤回
statis_market_cancel(Status, GoodsNo, GoodsId, GoodsNum, SellPrice, PriceType) ->
    ?PACK_LOG(?LOG_FILE_MARKET, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", player:id(Status)},
         {"lv", player:get_lv(Status)},
         {"action", 4},
         {"item_type", GoodsNo},
         {"item_id", GoodsId},
         {"item_num", GoodsNum},
         {"trans_item_type", get_log_monery_type(PriceType)},
         {"trans_item_id", ""},
         {"trans_item_num", SellPrice},
         {"tax_type", ""},
         {"tax_num", ""},
         {"from_rid", ""}
         ]).


%% 送花
%% @Goods :: 花   @Points :: 好友度点数  @ToRoleId :: 收礼者Id
statis_give_flower(Status, GoodsNo, GoodsId, GoodsNum, Points, ToRoleId) ->
    ?PACK_LOG(?LOG_FILE_MARKET, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", player:id(Status)},
         {"lv", player:get_lv(Status)},
         {"action", "giff"},
         {"item_type", GoodsNo},
         {"item_id", GoodsId},
         {"item_num", GoodsNum},
         {"trans_item_type", "haoyoudu"},
         {"trans_item_id", ""},
         {"trans_item_num", Points},
         {"tax_type", ""},
         {"tax_num", ""},
         {"from_rid", ToRoleId}
         ]).


%% 装备强化转移
statis_equip_transfer(Status, MaterialNo, MaterialId, MaterialLv, EqNo, EqId, EqLv, MoneyType, MoneyNum) ->
    ?PACK_LOG(?LOG_FILE_MARKET, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", player:id(Status)},
         {"lv", player:get_lv(Status)},
         {"action", "equip_trans_stren"},
         {"item_type", MaterialNo},
         {"item_id", MaterialId},
         {"item_num", MaterialLv},
         {"trans_item_type", EqNo},
         {"trans_item_id", EqId},
         {"trans_item_num", EqLv},
         {"tax_type", MoneyType},
         {"tax_num", MoneyNum},
         {"from_rid", ""}
         ]).

%% =======================================
%% 雇佣统计
%% =======================================
-define(LOG_FILE_HIRE, "hire").
%% 报名
statis_hire_sign_up(Status, HireTimes, Num) ->
    ?PACK_LOG(?LOG_FILE_HIRE, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", player:id(Status)},
         {"lv", player:get_lv(Status)},
         {"battle_power", ply_attr:get_battle_power(Status)},
         {"activity", 1},
         {"faction", player:get_faction(Status)},
         {"employee_rid", ""},
         {"employee_lv", ""},
         {"employee_faction", ""},
         {"employee_battle_power", ""},
         {"hire_times", HireTimes},
         {"item_num", Num}
         ]).
%% 雇佣
statis_hire(Status, Eid, Elv, Efaction, Ebp, HireTimes, Num) ->
    ?PACK_LOG(?LOG_FILE_HIRE, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", player:id(Status)},
         {"lv", player:get_lv(Status)},
         {"battle_power", ply_attr:get_battle_power(Status)},
         {"activity", 2},
         {"faction", player:get_faction(Status)},
         {"employee_rid", Eid},
         {"employee_lv", Elv},
         {"employee_faction", Efaction},
         {"employee_battle_power", Ebp},
         {"hire_times", HireTimes},
         {"item_num", Num}
         ]).
%% 领取收益
statis_hire_get_pay(Status, HireTimes, Num) ->
    ?PACK_LOG(?LOG_FILE_HIRE, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", player:id(Status)},
         {"lv", player:get_lv(Status)},
         {"battle_power", ply_attr:get_battle_power(Status)},
         {"activity", 3},
         {"faction", player:get_faction(Status)},
         {"employee_rid", ""},
         {"employee_lv", ""},
         {"employee_faction", ""},
         {"employee_battle_power", ""},
         {"hire_times", HireTimes},
         {"item_num", Num}
         ]).

-define(LOG_FILE_CURRENCY_ITEM, "item_log").
%% =======================================
%% 重要物品产出回收统计
%% =======================================
statis_produce_goods(Status, GoodsId, GoodsNo, GoodsNum, []) -> 
    statis_produce_goods(Status, GoodsId, GoodsNo, GoodsNum, [?LOG_UNDEFINED, ?LOG_UNDEFINED]);
statis_produce_goods(_Status, _GoodsId, _GoodsNo, _GoodsNum, [?LOG_SKIP | _]) -> skip;
    % statis_produce_goods(Status, GoodsId, GoodsNo, GoodsNum, [?LOG_UNDEFINED, ?LOG_UNDEFINED]);
statis_produce_goods(_, _, _, _, [circulated | _]) -> skip;
statis_produce_goods(RoleId, GoodsId, GoodsNo, GoodsNum, LogInfo) when is_integer(RoleId) ->
    case player:get_PS(RoleId) of
        Status when is_record(Status, player_status) ->
            statis_produce_goods(Status, GoodsId, GoodsNo, GoodsNum, LogInfo);
        _ -> 
            statis_produce_goods_offline(RoleId, GoodsId, GoodsNo, GoodsNum, LogInfo)
    end;
statis_produce_goods(Status, GoodsId, GoodsNo, GoodsNum, [Module]) when is_record(Status, player_status) ->
    statis_produce_goods(Status, GoodsId, GoodsNo, GoodsNum, [Module, ""]);
statis_produce_goods(Status, GoodsId, GoodsNo, GoodsNum, [Module, Arg | _]) when is_record(Status, player_status) ->
    ?PACK_LOG(?LOG_FILE_CURRENCY_ITEM, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", player:id(Status)},
         {"lv", player:get_lv(Status)},
         {"activity_type", Module},
         {"activity", Arg},
         {"state", 1},
         {"item_type", GoodsNo},
         {"item_id", GoodsId},
         {"item_num", GoodsNum},
         {"coin_type", ""},
         {"coin_num", ""}
         ]);
statis_produce_goods(_, _, _, _, _) -> ?ASSERT(false).


statis_shop_produce_goods(Status, GoodsId, GoodsNo, GoodsNum, MoneyType, MoneyNum, [Module, Arg | _]) ->
    ?PACK_LOG(?LOG_FILE_CURRENCY_ITEM, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", player:id(Status)},
         {"lv", player:get_lv(Status)},
         {"activity_type", Module},
         {"activity", Arg},
         {"state", 1},
         {"item_type", GoodsNo},
         {"item_id", GoodsId},
         {"item_num", GoodsNum},
         {"coin_type", get_log_monery_type(MoneyType)},
         {"coin_num", MoneyNum}
         ]).

statis_shop_produce_money(Status, PmoneyType, PmoneyNum, UmoneyType, UmoneyNum, [Module, Arg | _]) ->
    ?PACK_LOG(?LOG_FILE_CURRENCY_ITEM, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", player:id(Status)},
         {"lv", player:get_lv(Status)},
         {"activity_type", Module},
         {"activity", Arg},
         {"state", 1},
         {"item_type", get_log_monery_type(PmoneyType)},
         {"item_id", ""},
         {"item_num", PmoneyNum},
         {"coin_type", get_log_monery_type(UmoneyType)},
         {"coin_num", UmoneyNum}
         ]).


statis_produce_goods_offline(RoleId, GoodsId, GoodsNo, GoodsNum, [Module, Arg | _]) ->
    ?PACK_LOG(?LOG_FILE_CURRENCY_ITEM, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", RoleId},
         {"lv", ""},
         {"activity_type", Module},
         {"activity", Arg},
         {"state", 1},
         {"item_type", GoodsNo},
         {"item_id", GoodsId},
         {"item_num", GoodsNum},
         {"coin_type", ""},
         {"coin_num", ""}
         ]);
statis_produce_goods_offline(_, _, _, _, _) -> ?ASSERT(false).


statis_reclaim_goods(Status, GoodsId, GoodsNo, GoodsNum, []) -> 
    statis_reclaim_goods(Status, GoodsId, GoodsNo, GoodsNum, [?LOG_UNDEFINED, ?LOG_UNDEFINED]);
statis_reclaim_goods(_Status, _GoodsId, _GoodsNo, _GoodsNum, [?LOG_SKIP | _]) -> skip;
    % statis_reclaim_goods(Status, GoodsId, GoodsNo, GoodsNum, [?LOG_UNDEFINED, ?LOG_UNDEFINED]);
statis_reclaim_goods(_, _, _, _, [circulated | _]) -> skip;
% statis_reclaim_goods(_, _, _, _, [skip | _]) -> skip;
statis_reclaim_goods(RoleId, GoodsId, GoodsNo, GoodsNum, LogInfo) when is_integer(RoleId) ->
    statis_reclaim_goods(player:get_PS(RoleId), GoodsId, GoodsNo, GoodsNum, LogInfo);
statis_reclaim_goods(Status, GoodsId, GoodsNo, GoodsNum, [Module]) when is_record(Status, player_status) ->
    statis_reclaim_goods(Status, GoodsId, GoodsNo, GoodsNum, [Module, ""]);
statis_reclaim_goods(Status, GoodsId, GoodsNo, GoodsNum, [Module, Arg | _]) when is_record(Status, player_status) ->
    ?PACK_LOG(?LOG_FILE_CURRENCY_ITEM, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", player:id(Status)},
         {"lv", player:get_lv(Status)},
         {"activity_type", Module},
         {"activity", Arg},
         {"state", 0},
         {"item_type", GoodsNo},
         {"item_id", GoodsId},
         {"item_num", GoodsNum},
         {"coin_type", ""},
         {"coin_num", ""}
         ]);
statis_reclaim_goods(_, _, _, _, _) -> ?ASSERT(false).


%% =======================================
%% 货币流水统计
%% =======================================
%% @LogInfo:: [] | [SysNo] | [SysNo, Action]

statis_produce_currency(Status, MoneyType, AddNum, []) -> statis_produce_currency(Status, MoneyType, AddNum, [?LOG_UNDEFINED, ?LOG_UNDEFINED]);
statis_produce_currency(_, _, 0, _) -> skip;
statis_produce_currency(_Status, _MoneyType, _AddNum, [circulated | _]) ->
    redo;
% statis_produce_currency(_Status, _MoneyType, _AddNum, [skip | _]) ->
%     redo;
statis_produce_currency(_Status, _MoneyType, _AddNum, [?LOG_SKIP | _]) -> skip;
    % statis_produce_currency(Status, MoneyType, AddNum, [?LOG_UNDEFINED, ?LOG_UNDEFINED]);
statis_produce_currency(RoleId, MoneyType, AddNum, LogInfo) when is_integer(RoleId) ->
    statis_produce_currency(player:get_PS(RoleId), MoneyType, AddNum, LogInfo);

statis_produce_currency(Status, MoneyType, AddNum, [Module]) when is_record(Status, player_status) ->
    statis_produce_currency(Status, MoneyType, AddNum, [Module, ""]);
statis_produce_currency(Status, MoneyType, AddNum, [Module, Arg | _]) when is_record(Status, player_status) ->
    ?PACK_LOG(?LOG_FILE_CURRENCY_ITEM, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", player:id(Status)},
         {"lv", player:get_lv(Status)},
         {"activity_type", Module},
         {"activity", Arg},
         {"state", 1},
         {"item_type", get_log_monery_type(MoneyType)},
         {"item_id", ""},
         {"item_num", AddNum},
         {"coin_type", ""},
         {"coin_num", ""}
         ]);
statis_produce_currency(_Status, _MoneyType, _AddNum, _) -> ?ASSERT(false).


statis_consume_currency(Status, MoneyType, CostNum, []) -> statis_consume_currency(Status, MoneyType, CostNum, [?LOG_UNDEFINED, ?LOG_UNDEFINED]);
statis_consume_currency(_, _, 0, _) -> skip;
statis_consume_currency(RoleId, MoneyType, CostNum, LogInfo) when is_integer(RoleId) ->
    statis_consume_currency(player:get_PS(RoleId), MoneyType, CostNum, LogInfo);
statis_consume_currency(_Status, _MoneyType, _CostNum, [circulated | _]) ->
    redo;
% statis_consume_currency(_Status, _MoneyType, _CostNum, [skip | _]) ->
%     redo;
statis_consume_currency(_Status, _MoneyType, _CostNum, [?LOG_SKIP | _]) -> skip;
    % statis_consume_currency(Status, MoneyType, CostNum, [?LOG_UNDEFINED, ?LOG_UNDEFINED]);
statis_consume_currency(Status, MoneyType, CostNum, [Module]) when is_record(Status, player_status) ->
    statis_consume_currency(Status, MoneyType, CostNum, [Module, ""]);
statis_consume_currency(Status, MoneyType, CostNum, [Module, Arg | _]) when is_record(Status, player_status) ->
    ?PACK_LOG(?LOG_FILE_CURRENCY_ITEM, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", player:id(Status)},
         {"lv", player:get_lv(Status)},
         {"activity_type", Module},
         {"activity", Arg},
         {"state", 0},
         {"item_type", get_log_monery_type(MoneyType)},
         {"item_id", ""},
         {"item_num", CostNum},
         {"coin_type", ""},
         {"coin_num", ""}
         ]);
statis_consume_currency(_Status, _MoneyType, _AddNum, _) -> ?ASSERT(false).

statis_consume_currency_tax(RoleId, MoneyType, CostNum) ->
    Lv = 
        case player:in_tmplogout_cache(RoleId) of
            true -> player:get_lv(RoleId);
            false -> 
                case mod_offline_data:get_offline_role_brief(RoleId) of
                    null -> 0;
                    Rd -> Rd#offline_role_brief.lv
                end
        end,
    ?PACK_LOG(?LOG_FILE_CURRENCY_ITEM, 
        [{"server_id", ?SERVER_ID}, 
         {"rid", RoleId},
         {"lv", Lv},
         {"activity_type", ?LOG_MARKET},
         {"activity", "tax"},
         {"state", 0},
         {"item_type", get_log_monery_type(MoneyType)},
         {"item_id", ""},
         {"item_num", CostNum},
         {"coin_type", ""},
         {"coin_num", ""}
         ]).


%% 玩家行为日志
statis_role_action(Role, Desc, System, Action, Args) ->
    try 
        statis_role_action__(Role, Desc, System, Action, Args)
    catch
        _T:_E -> ?ERROR_MSG("[log] statis_role_action error = ~p~n", [{_T, _E}])
    end.


statis_role_action__(sys, _Desc, System, Action, Args) ->
    ?PACK_ROLE_LOG(
        [
         {"uid", 0},
         {"rid", 0},
         {"lv",  0},
         {"role_desc", ""},
         {"system", System},
         {"action", Action} |
         pack_action_args(Args)
        ]
        );
statis_role_action__(RoleId, Desc, System, Action, Args) when is_integer(RoleId) ->
    case player:get_PS(RoleId) of
        Status when is_record(Status, player_status) -> 
            statis_role_action__(Status, Desc, System, Action, Args);
        _ -> error
    end;
statis_role_action__(Status, Desc, System, Action, Args) when is_record(Status, player_status) ->
    ?PACK_ROLE_LOG(
        [
         {"uid", player:get_accname(Status)},
         {"rid", player:id(Status)},
         {"lv",  player:get_lv(Status)},
         {"role_desc", pack_role_desc(Status, Desc)},
         {"system", System},
         {"action", Action} |
         pack_action_args(Args)
        ]
        );
statis_role_action__(_, _, _, _, _) -> ?ASSERT(false), error.

%% lib_log:statis_role_action(tst_test:id(1), [faction, battle_power, team_id, teammate], "test", "test", [1,2]).
%% lib_log:pack_role_desc(player:get_PS(tst_test:id(1)), [nickname]).
%% ========================================

get_log_monery_type(MoneyType) ->
    if  MoneyType =:= gamemoney orelse MoneyType =:= ?MNY_T_GAMEMONEY -> 89000;
        MoneyType =:= bind_gamemoney orelse MoneyType =:= ?MNY_T_BIND_GAMEMONEY -> 89001;
        MoneyType =:= yuanbao orelse MoneyType =:= ?MNY_T_YUANBAO -> 89002;
        MoneyType =:= bind_yuanbao orelse MoneyType =:= ?MNY_T_BIND_YUANBAO -> 89003;
		MoneyType =:= integral orelse MoneyType =:= ?MNY_T_INTEGRAL -> 89058;
        MoneyType =:= feat orelse MoneyType =:= ?MNY_T_FEAT -> 89010;
        MoneyType =:= ?MNY_T_GUILD_CONTRI -> 89011;
        MoneyType =:= ?MNY_T_EXP -> 89004;
        MoneyType =:= ?MNY_T_LITERARY -> 89016;
        MoneyType =:= ?MNY_T_COPPER -> 89020;    
        MoneyType =:= ?MNY_T_VITALITY -> 89021; 
        MoneyType =:= ?MNY_T_CHIVALROUS -> 89027;
        MoneyType =:= ?MNY_T_QUJING -> 89060;
        MoneyType =:= ?MNY_T_MYSTERY -> 89070;
        MoneyType =:= ?MNY_T_MIRAGE -> 89071;

        true -> MoneyType
    end.


%% @return : string()
pack_role_desc(Status, Fields) ->
    rfc4627:encode(pack_json([role_desc(Status, Field) || Field <- Fields])).

role_desc(Status, Field) ->
    if  
        Field == faction -> {"faction", player:get_faction(Status)};
        Field == power -> {"power", ply_attr:get_battle_power(Status)};
        Field == team_id -> {"team_id", player:get_team_id(Status)};
        Field == vip_lv -> {"vip_lv", player:get_vip_lv(Status)};
        Field == teammate -> 
            TeamId = player:get_team_id(Status),
            Mates = lists:delete(player:id(Status), mod_team:get_all_member_id_list(TeamId)),
            {"teammate", pack_json(pack_log_args(Mates, 117, 49))};
        true -> {?LOG_UNDEFINED, ?LOG_UNDEFINED}
    end.


%% @return : list()
pack_action_args([]) -> [];
pack_action_args(Args) -> pack_log_args(Args, 97, 49).

pack_log_args([], _, _) -> []; 
pack_log_args([Arg | ArgLeft], PR, Flag) ->
    [{[PR, Flag], Arg} | pack_log_args(ArgLeft, PR, Flag + 1)].


admin_log_format([]) -> [];
admin_log_format([{Key, Value}]) when is_list(Key) -> 
    [pack_log_key_value_end(Key, Value)];
admin_log_format([{Key, Value} | Left]) when is_list(Key) ->
    [pack_log_key_value(Key, Value) | admin_log_format(Left)].


admin_log_time() ->
    {{Y, M, D}, {H, Min, Sec}} = erlang:localtime(),
    {"t", lists:flatten(io_lib:format("~4..0B-~2..0B-~2..0B ~2..0B:~2..0B:~2..0B", [Y, M, D, H, Min, Sec]))}.


pack_log_key_value(Key, Value) ->
    Key ++ "=" ++ tool:to_list(Value) ++ "`".
pack_log_key_value_end(Key, Value) ->
    Key ++ "=" ++ tool:to_list(Value) ++ "\n".

pack_json(Data) when is_list(Data) ->
    {obj, Data};
pack_json(Data) -> 
    ?ASSERT(false, [Data]),
    {obj, []}.