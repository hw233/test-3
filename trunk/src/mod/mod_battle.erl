%%%------------------------------------
%%% @Module  : mod_battle
%%% @Author  : huangjf
%%% @Email   :
%%% @Created : 2013.7.26
%%% @Description: 战斗系统主模块
%%%------------------------------------
-module(mod_battle).
-behaviour(gen_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([
  start/1,                  % 开启战斗进程
  stop/2,       			  % 终止战斗进程
  start_mf/3, start_mf/4, start_mf/5, start_mf/6, do_start_mf/1,
  start_world_boss_mf/4,
  start_melee_mf/3,
  start_tve_mf/3,
  start_offline_arena/2,
  start_hijack/3,
  start_road/3,
  start_steal/3,
  add_one_cross_robot_player/3,
  start_pk/4, do_start_pk/4,
  start_1v1_online_arena_pk/3, % 在线1v1竞技场（比武大会）pk
  start_guild_war_pk/3, % 帮派争夺战pk
  start_melee_pk/3,     % 女妖乱斗活动pk
  start_3v3_online_arena_pk/3, %在线3v3竞技场
  start_cross_3v3_pk/3,
  init_try_add_all_my_partners_for_road/2,
  add_one_offline_partner_for_road/4,
check_and_handle_bo_die/2,
  force_end_battle_no_win_side/1,   % 强行结束战斗（战斗结果认为是平手）
  force_end_battle/1,   % 强行结束战斗（战斗结果认为是失败）
try_apply_reborn_eff/1,
  query_battle_field_desc/2,
  query_bo_buff_info/4,

  query_skill_usable_info/3,
  query_bo_info_after_back_to_battle/3,

  c2s_notify_show_battle_report_done/2,

  prepare_cmd_NOP/3,
  start_guild_dungeon_boss/3,

  prepare_cmd_normal_att/4,
  prepare_cmd_use_skill/5,
  prepare_cmd_use_goods/5,
  prepare_cmd_protect_others/4,
  prepare_cmd_capture/4,
  prepare_cmd_escape/3,
  prepare_cmd_defend/3,
  prepare_cmd_summon_partner/4,

  start_3v3_robot/3,

  req_prepare_cmd_by_AI/3,
  get_guild_boss_left_hp/0,

  request_auto_battle/2,
  cancel_auto_battle/2,

  on_player_logout/2,
  get_guild_boss_left_hp/0,
collect_battle_report/2,

  player_try_go_back_to_battle/2,

  query_battle_start_time/2,
  
  captain_project/3,

  decide_att_targets/1,  % 导出只是给lib_bo模块调用

  % 以下接口仅仅用于调试！
  dbg_force_win_battle/2, dbg_force_lose_battle/2,
  dbg_force_set_attr/4,
  dbg_force_set_do_fix_dam/3,
  dbg_normalize_dam/2,
  dbg_set_mp/3,
  dbg_get_buff_info/3,
  dbg_fast_kill_mon/2,
  start_limited_battle/5,
  do_start_limit_task/1
]).

-import(lib_bt_comm, [
get_battle_state/0,
set_battle_state/1,
get_bo_by_id/1,
get_bo_by_pos/2,

get_bo_by_player_id/1,
get_bo_by_partner_id/1,

get_bo_id_list/1, set_bo_id_list/2,
get_all_bo_id_list/0,

get_all_player_bo_list/0,

get_all_online_living_player_bo_list/0,

get_all_online_player_bo_id_list/0,

to_enemy_side/1,

get_win_side/0,
set_win_side/1,

mark_battle_finish/0,
is_battle_finish/0,

is_dead/1,
is_living/1,
is_bo_exists/1,

is_player/1,
is_hired_player/1,
is_partner/1,
is_monster/1,

can_attack/2,
can_attack/3,

get_player_bo_id_list/1,
get_player_bo_list/1,
get_online_player_bo_id_list/1,
is_online/1
]).

-include("common.hrl").
-include("record.hrl").
-include("road.hrl").
-include("battle.hrl").
-include("record/battle_record.hrl").
-include("skill.hrl").
-include("monster.hrl").
-include("num_limits.hrl").
-include("pt_20.hrl").
-include("pt_38.hrl").
-include("effect.hrl").
-include("abbreviate.hrl").
-include("prompt_msg_code.hrl").
-include("attribute.hrl").
-include("offline_data.hrl").
-include("partner.hrl").
-include("obj_info_code.hrl").
-include("log.hrl").
-include("sys_code.hrl").
-include("pt.hrl").
-include("relation.hrl").
-include("buff.hrl").
-include("scene.hrl").
-include("ets_name.hrl").
-include("pvp.hrl").
-include("limitedtask.hrl").
-include("five_elements.hrl").
-include("fabao.hrl").


-define(BOID(Bo), lib_bo:get_id(Bo)).




%% 开启战斗进程
start(BattleId) ->
  gen_server:start(?MODULE, [BattleId], []).


%% 终止战斗进程
stop(BattlePid, Reason) ->
  gen_server:cast(BattlePid, {'stop', Reason}).



%% 触发打怪
%% @para: BMonGroupNo => 战斗怪物组编号
%%        Callback => 处理战斗反馈时调用的回调函数，如果没有，则传入null
start_mf(PS, BMonGroupNo, Callback) ->
  start_mf(PS, null, BMonGroupNo, ?BTL_SUB_T_NORMAL_MF, Callback, []) % 默认子类型为普通打怪
.


start_mf(PS, MonObj, BattleSubType, Callback) ->
	start_mf(PS, MonObj, BattleSubType, Callback, 1).

start_mf(PS, MonObj, BattleSubType, Callback, Difficulty) ->
  ?ASSERT(is_record(MonObj, mon)),
  BMonGroupNo = ply_battle:pick_bmon_group_for_battle(PS, MonObj, Difficulty),
  start_mf(PS, MonObj, BMonGroupNo, BattleSubType, Callback, []).

%% para: ExtraInfo => 额外信息，proplist类型（形如：[{Key, Value}, ...]），如果没有，则传入[]
start_mf(PS, MonObj, BMonGroupNo, BattleSubType, Callback, ExtraInfo) ->
  ?ASSERT(lib_bmon_group:is_valid(BMonGroupNo)),
  ?ASSERT(lib_bt_misc:is_battle_subtype_valid(BattleSubType)),
  % 为了彻底避免重复触发战斗，故cast回玩家进程去做进一步的判断和处理
  gen_server:cast( player:get_pid(PS), {'ready_to_start_mf', fun mod_battle:do_start_mf/1, [PS, MonObj, BMonGroupNo, BattleSubType, Callback, ExtraInfo]}).

%限时任务的打怪
start_limited_battle(PS, BMonGroupNo, Type ,Callback,Index) ->
  ?ASSERT(lib_bmon_group:is_valid(BMonGroupNo)),
  ?ASSERT(lib_bt_misc:is_battle_subtype_valid(Type)),
  % 为了彻底避免重复触发战斗，故cast回玩家进程去做进一步的判断和处理
  gen_server:cast( player:get_pid(PS), {'ready_to_start_mf', fun mod_battle:do_start_limit_task/1, [PS, null, BMonGroupNo, Type, Callback, [], Index]}).


%% @return: {ok, NewBattleId}
do_start_mf([PS, MonObj, BMonGroupNo, BattleSubType, Callback, ExtraInfo]) ->
  ?TRACE("do_start_mf(), PlayerId:~p, BMonGroupNo:~p", [player:id(PS), BMonGroupNo]),
  PlayerId = player:id(PS),
  {ok, NewBattleId, NewBattlePid} = mod_battle_mgr:create_battle(PlayerId),

  ?Ifc (MonObj /= null)
  mod_mon:mark_battling(MonObj)
?End,

gen_server:cast(NewBattlePid, {'start_mf', NewBattleId, [PS, MonObj, BMonGroupNo, BattleSubType, Callback, ExtraInfo]}),
ply_scene:notify_bhv_state_changed_to_aoi(PlayerId, ?BHV_BATTLING),

{ok, NewBattleId}.


%% @return: {ok, NewBattleId}
do_start_limit_task([PS, MonObj, BMonGroupNo, BattleSubType, Callback, ExtraInfo,Index]) ->
  ?TRACE("do_start_mf(), PlayerId:~p, BMonGroupNo:~p", [player:id(PS), BMonGroupNo]),
  PlayerId = player:id(PS),

  {ok, NewBattleId, NewBattlePid} = mod_battle_mgr:create_battle(PlayerId),

  gen_server:cast(NewBattlePid, {'set_index', Index}),


  ?Ifc (MonObj /= null)
  mod_mon:mark_battling(MonObj)
?End,
gen_server:cast(NewBattlePid, {'start_mf', NewBattleId, [PS, MonObj, BMonGroupNo, BattleSubType, Callback, ExtraInfo]}),
ply_scene:notify_bhv_state_changed_to_aoi(PlayerId, ?BHV_BATTLING),

{ok, NewBattleId}.



%% 打世界boss
%% @para: PS => 发起战斗的玩家
%%        BossObj => 世界boss对应的明雷怪对象
%%        BossHp => 世界boss的血量
%%        Callback => 处理战斗反馈时调用的回调函数，如果没有，则传入null
start_world_boss_mf(PS, BossObj, BossHp, Callback) ->
	start_world_boss_mf(PS, BossObj, BossHp, Callback, 1).

start_world_boss_mf(PS, BossObj, BossHp, Callback, Difficulty) ->
  ?ASSERT(is_record(BossObj, mon)),
  ?ASSERT(mod_mon:is_world_boss(BossObj), BossObj),

  ?DEBUG_MSG("start_world_boss_mf()...", []),

  BMonGroupNo = ply_battle:pick_bmon_group_for_battle(PS, BossObj, Difficulty),
  BattleSubType = ?BTL_SUB_T_WORLD_BOSS_MF,
  start_mf(PS, BossObj, BMonGroupNo, BattleSubType, Callback, [{world_boss_hp, BossHp}]).

%打帮派副本boss
start_guild_dungeon_boss(PS,BossObj,BossHp) ->
	start_guild_dungeon_boss(PS,BossObj,BossHp,1).

start_guild_dungeon_boss(PS,BossObj,BossHp, Difficulty) ->

  ?ASSERT(is_record(BossObj, mon)),

  ?DEBUG_MSG("start_world_boss_mf()...", []),

  BMonGroupNo = ply_battle:pick_bmon_group_for_battle(PS, BossObj, Difficulty),
  BattleSubType = ?BTL_SUB_T_GUILD_BOSS_MF,
  start_mf(PS, BossObj, BMonGroupNo, BattleSubType, null, [{guild_dungeon_boss_hp, BossHp}]).



%% 女妖乱斗活动mf
%% @para: PS => 发起战斗的玩家
%%        MonObj => 所打的明雷怪对象
%%        Callback => 处理战斗反馈时调用的回调函数，如果没有，则传入null
start_melee_mf(PS, MonObj, Callback) ->
  start_mf(PS, MonObj, ?BTL_SUB_T_MELEE_MF, Callback).


%% 三界副本打怪
%% @para: PS => 发起战斗的玩家
%%        MonObj => 所打的明雷怪对象
%%        Callback => 处理战斗反馈时调用的回调函数，如果没有，则传入null
start_tve_mf(PS, MonObj, Callback) ->
  start_mf(PS, MonObj, ?BTL_SUB_T_TVE_MF, Callback).



%% 离线竞技场战斗
start_offline_arena(PS, Opponent) when is_record(Opponent, player_status)
  orelse is_record(Opponent, offline_bo) ->
  ?TRACE("mod_battle, start_offline_arena()...~n"),
  % 保险起见， 这里再判断一次是否空闲
  case player:is_idle(PS) of
    false ->
      ?DEBUG_MSG("[mod_battle] start_offline_arena(), is NOT idle!! PlayerId=~p", [player:id(PS)]),
      skip;
    true ->
      PlayerId = player:id(PS),
      {ok, NewBattleId, NewBattlePid} = mod_battle_mgr:create_battle(PlayerId),

      player:mark_battling(PlayerId, NewBattleId),

      gen_server:cast(NewBattlePid, {'start_offline_arena', NewBattleId, PS, Opponent}),

      ply_scene:notify_bhv_state_changed_to_aoi(PlayerId, ?BHV_BATTLING)
  end.


%% 劫镖
%% @para: Callback => 处理战斗反馈时调用的回调函数，如果没有，则传入null
start_hijack(PS, Opponent, Callback) when is_record(Opponent, player_status)
  orelse is_record(Opponent, offline_bo) ->
  ?TRACE("mod_battle, start_hijack()...~n"),
  % 保险起见， 这里再判断一次是否空闲
  case player:is_idle(PS) of
    false ->
      ?DEBUG_MSG("[mod_battle] start_hijack(), is NOT idle!! PlayerId=~p", [player:id(PS)]),
      skip;
    true ->
      PlayerId = player:id(PS),
      {ok, NewBattleId, NewBattlePid} = mod_battle_mgr:create_battle(PlayerId),

      player:mark_battling(PlayerId, NewBattleId),

      gen_server:cast(NewBattlePid, {'start_hijack', NewBattleId, PS, Opponent, Callback}),

      ply_scene:notify_bhv_state_changed_to_aoi(PlayerId, ?BHV_BATTLING)
  end.

%% 偷菜
%% @para: Callback => 处理战斗反馈时调用的回调函数，如果没有，则传入null
start_steal(PS, Opponent, Callback) when is_record(Opponent, player_status)
  orelse is_record(Opponent, offline_bo) ->
  ?TRACE("mod_battle, start_hijack()...~n"),
  % 保险起见， 这里再判断一次是否空闲
  case player:is_idle(PS) of
    false ->
      ?DEBUG_MSG("[mod_battle] start_hijack(), is NOT idle!! PlayerId=~p", [player:id(PS)]),
      skip;
    true ->
      PlayerId = player:id(PS),
      {ok, NewBattleId, NewBattlePid} = mod_battle_mgr:create_battle(PlayerId),

      player:mark_battling(PlayerId, NewBattleId),

      gen_server:cast(NewBattlePid, {'start_steal', NewBattleId, PS, Opponent, Callback}),

      ply_scene:notify_bhv_state_changed_to_aoi(PlayerId, ?BHV_BATTLING)
  end.


%% 取经之路
%% @para: Callback => 处理战斗反馈时调用的回调函数，如果没有，则传入null
start_road(PS, Opponent, Callback) when is_record(Opponent, player_status)
  orelse is_record(Opponent, offline_bo) ->
  ?TRACE("mod_battle, start_hijack()...~n"),
  % 保险起见， 这里再判断一次是否空闲
  case player:is_idle(PS) of
    false ->
      ?DEBUG_MSG("[mod_battle] start_road(), is NOT idle!! PlayerId=~p", [player:id(PS)]),
      skip;
    true ->
      PlayerId = player:id(PS),
      {ok, NewBattleId, NewBattlePid} = mod_battle_mgr:create_battle(PlayerId),

      player:mark_battling(PlayerId, NewBattleId),

      gen_server:cast(NewBattlePid, {'start_road', NewBattleId, PS, Opponent, Callback}),

      ply_scene:notify_bhv_state_changed_to_aoi(PlayerId, ?BHV_BATTLING)
  end.


%% PK
%% @para: Callback => 处理战斗反馈时调用的回调函数，如果没有，则传入null
start_pk(PS, OpponentPS, PK_Type, Callback) ->
  % 为避免玩家与多个其他玩家同时触发多场PK战斗，故统一cast到battle judger进程
  mod_battle_judger:req_start_pk(PS, OpponentPS, PK_Type, Callback).

%%跨服3v3机器人
start_3v3_robot(PS, Opponent, Callback) when is_record(Opponent, player_status)
  orelse is_record(Opponent, offline_bo) ->
  ?TRACE("mod_battle, start_3v3_robot()...~n"),
  % 保险起见， 这里再判断一次是否空闲
  case player:is_idle(PS) of
    false ->
      ?DEBUG_MSG("[mod_battle] start_hijack(), is NOT idle!! PlayerId=~p", [player:id(PS)]),
      skip;
    true ->
      ServerId = player:get_server_id(PS),
      PlayerId = player:id(PS),

      [MatchRoom] = ets:lookup(?ETS_PVP_MATCH_ROOM, PlayerId),
      case length(MatchRoom#match_room.teammates) > 0  of
        true ->
          F = fun(X) ->
            [PlayerData2] = ets:lookup(?ETS_PVP_CROSS_PLAYER_DATA, X),
            ServerId2  =  PlayerData2#pvp_cross_player_data.server_id,
            sm_cross_server:rpc_call(ServerId2, player, mark_cross_remote, [X])
              end,

          lists:foreach(F, MatchRoom#match_room.teammates);
        false ->
          skip
      end,


      sm_cross_server:rpc_call(ServerId, player, mark_cross_remote, [PlayerId]),
      {ok, NewBattleId, NewBattlePid} = mod_battle_mgr:create_battle(PlayerId),

      player:mark_battling(PlayerId, NewBattleId),

      gen_server:cast(NewBattlePid, {'start_3v3_robot', NewBattleId, PS, Opponent, Callback}),

      ply_scene:notify_bhv_state_changed_to_aoi(PlayerId, ?BHV_BATTLING)
  end.


do_start_pk(PS, OpponentPS, PK_Type, Callback) ->
  {SceneType1,SceneType2} = case PK_Type =:= ?PK_T_CROSS_3V3 of
                              true ->
                                {false,false};
                              false ->
                                {mod_scene_tpl:get_scene_type(player:get_scene_no(PS)), mod_scene_tpl:get_scene_type(player:get_scene_no(OpponentPS))}
                            end,
  Ret =
    case PK_Type of
      ?PK_T_FORCE ->  SceneType1 =:= ?SCENE_T_WILD andalso SceneType2 =:= ?SCENE_T_WILD;
      _ -> true
    end,

  case Ret of
    true ->
      PlayerId = player:id(PS),
      OpponentPlayerId = player:id(OpponentPS),
      {ok, NewBattleId, NewBattlePid} = mod_battle_mgr:create_battle(PlayerId),

      player:mark_battling(PlayerId, NewBattleId),
      player:mark_battling(OpponentPlayerId, NewBattleId),
      case PK_Type == ?PK_T_CROSS_3V3 of
        true ->
          gen_server:cast(NewBattlePid, {'start_cross_3v3', NewBattleId, PS, OpponentPS, PK_Type, Callback});
        false ->
          gen_server:cast(NewBattlePid, {'start_pk', NewBattleId, PS, OpponentPS, PK_Type, Callback})
      end,

      ply_scene:notify_bhv_state_changed_to_aoi(PlayerId, ?BHV_BATTLING),
      ply_scene:notify_bhv_state_changed_to_aoi(OpponentPlayerId, ?BHV_BATTLING);
    false ->
      % lib_send:send_prompt_msg(player:id(PS), ?PM_BT_START_FORCE_PK_FAIL)
      lib_send:send_prompt_msg(player:id(PS), ?PM_BT_TARGET_CANNOT_FIGHT_WITH_YOU)
  end.


%% 在线1v1竞技场（比武大会）pk
%% @para: 	PS => 玩家自己（主动发起pk）
%%			OpponentPS => pk的对手（被动接受pk）
%%			Callback => 处理战斗反馈时调用的回调函数，如果没有，则传入null
start_1v1_online_arena_pk(PS, OpponentPS, Callback) ->
  start_pk(PS, OpponentPS, ?PK_T_1V1_ONLINE_ARENA, Callback).


%% 帮派争夺战PK
%% @para: 	PS => 玩家自己（主动发起pk）
%%			OpponentPS => pk的对手（被动接受pk）
%%			Callback => 处理战斗反馈时调用的回调函数，如果没有，则传入null
start_guild_war_pk(PS, OpponentPS, Callback) ->
  start_pk(PS, OpponentPS, ?PK_T_GUILD_WAR, Callback).



%% 女妖乱斗活动PK
%% @para: 	PS => 玩家自己（主动发起pk）
%%			OpponentPS => pk的对手（被动接受pk）
%%			Callback => 处理战斗反馈时调用的回调函数，如果没有，则传入null
start_melee_pk(PS, OpponentPS, Callback) ->
  start_pk(PS, OpponentPS, ?PK_T_MELEE, Callback).


%% 在线3v3竞技场（比武大会）pk
%% @para: 	PS => 玩家自己（主动发起pk）
%%			OpponentPS => pk的对手（被动接受pk）
%%			Callback => 处理战斗反馈时调用的回调函数，如果没有，则传入null
start_3v3_online_arena_pk(PS, OpponentPS, Callback) ->
  ?ylh_Debug("start_3v3_online_arena_pk~n"),
  start_pk(PS, OpponentPS, ?PK_T_3V3_ONLINE_ARENA, Callback).



%% 跨服3v3   pk
%% @para: 	PS => 玩家自己（主动发起pk）
%%			OpponentPS => pk的对手（被动接受pk）
%%			Callback => 处理战斗反馈时调用的回调函数，如果没有，则传入null
start_cross_3v3_pk(PS, OpponentPS, Callback) ->
  start_pk(PS, OpponentPS, ?PK_T_CROSS_3V3, Callback).

%% 强行结束战斗（战斗结果认为是失败）
force_end_battle(PS) ->
  case player:get_cur_battle_pid(PS) of
    null ->
      skip;
    CurBattlePid ->
      ?ASSERT(is_pid(CurBattlePid), CurBattlePid),
      gen_server:cast(CurBattlePid, {'force_end_battle', PS})
  end.

%%强行结束战斗（战斗结果认为是平手）
force_end_battle_no_win_side(PS) ->
  case player:get_cur_battle_pid(PS) of
    null ->
      skip;
    CurBattlePid ->
      ?ASSERT(is_pid(CurBattlePid), CurBattlePid),
      gen_server:cast(CurBattlePid, 'force_end_battle_no_win_side')
  end.

%% 查询战场描述信息
query_battle_field_desc(PlayerId, CurBattlePid) ->
  case erlang:is_process_alive(CurBattlePid) of
    true ->
      gen_server:cast(CurBattlePid, {'query_battle_field_desc', PlayerId});
    false ->
      lib_bt_send:notify_cli_not_need_back_to_battle(PlayerId)
  end.


query_bo_buff_info(PS, TargetBoId, BuffNo, CurBattlePid) ->
  PlayerId = player:id(PS),
  gen_server:cast(CurBattlePid, {'query_bo_buff_info', PlayerId, TargetBoId, BuffNo}).



%% 查询自己或主宠的技能的可使用情况
query_skill_usable_info(PS, CurBattlePid, TargetBoId) ->
  PlayerId = player:id(PS),
  gen_server:cast(CurBattlePid, {'query_skill_usable_info', PlayerId, TargetBoId}).


query_bo_info_after_back_to_battle(PS, CurBattlePid, TargetBoId) ->
  PlayerId = player:id(PS),
  gen_server:cast(CurBattlePid, {'query_bo_info_after_back_to_battle', PlayerId, TargetBoId}).


%% 客户端通知服务端：播放战报完毕（c2s: client to server）
c2s_notify_show_battle_report_done(PlayerId, CurBattlePid) ->
  gen_server:cast(CurBattlePid, {'c2s_notify_show_battle_report_done', PlayerId}).




%% 下达指令：空指令
prepare_cmd_NOP(PS, ForBoId, CurBattlePid) ->
  % BattlePid = player:get_cur_battle_pid(PS),
  % ?ASSERT(is_pid(BattlePid)),
  gen_server:cast(CurBattlePid, {'prepare_cmd_NOP', PS, ForBoId}).


%% 下达指令：普通攻击
prepare_cmd_normal_att(PS, ForBoId, TargetBoId, CurBattlePid) ->
  % BattlePid = player:get_cur_battle_pid(PS),
  % ?ASSERT(is_pid(BattlePid)),
  gen_server:cast(CurBattlePid, {'prepare_cmd_normal_att', [PS, ForBoId, TargetBoId]}).

%% 下达指令：使用技能
prepare_cmd_use_skill(PS, ForBoId, SkillId, TargetBoId, CurBattlePid) ->
  % BattlePid = player:get_cur_battle_pid(PS),
  % ?ASSERT(is_pid(BattlePid)),
  gen_server:cast(CurBattlePid, {'prepare_cmd_use_skill', [PS, ForBoId, SkillId, TargetBoId]}).

%% 下达指令：使用物品
prepare_cmd_use_goods(PS, ForBoId, Goods, TargetBoId, CurBattlePid) ->
  gen_server:cast(CurBattlePid, {'prepare_cmd_use_goods', [PS, ForBoId, Goods, TargetBoId]}).


%% 下达指令：保护
prepare_cmd_protect_others(PS, ForBoId, TargetBoId, CurBattlePid) ->
  % BattlePid = player:get_cur_battle_pid(PS),
  % ?ASSERT(is_pid(BattlePid)),
  gen_server:cast(CurBattlePid, {'prepare_cmd_protect_others', [PS, ForBoId, TargetBoId]}).

%% 下达指令：保护
prepare_cmd_capture(PS, ForBoId, TargetBoId, CurBattlePid) ->
  % BattlePid = player:get_cur_battle_pid(PS),
  % ?ASSERT(is_pid(BattlePid)),
  gen_server:cast(CurBattlePid, {'prepare_cmd_capture', [PS, ForBoId, TargetBoId]}).




%% 下达指令：逃跑
prepare_cmd_escape(PS, ForBoId, CurBattlePid) ->
  % BattlePid = player:get_cur_battle_pid(PS),
  % ?ASSERT(is_pid(BattlePid)),
  gen_server:cast(CurBattlePid, {'prepare_cmd_escape', PS, ForBoId}).

%% 下达指令：防御
prepare_cmd_defend(PS, ForBoId, CurBattlePid) ->
  gen_server:cast(CurBattlePid, {'prepare_cmd_defend', PS, ForBoId}).


%% 下达指令：召唤宠物
prepare_cmd_summon_partner(PS, ForBoId, PartnerId, CurBattlePid) ->
  gen_server:cast(CurBattlePid, {'prepare_cmd_summon_partner', [PS, ForBoId, PartnerId]}).


%% 下达指令：请求依据按AI下指令
req_prepare_cmd_by_AI(PS, ForBoId, CurBattlePid) ->
  gen_server:cast(CurBattlePid, {'req_prepare_cmd_by_AI', PS, ForBoId}).


%% 请求自动战斗
request_auto_battle(PS, CurBattlePid) ->
  gen_server:cast(CurBattlePid, {'request_auto_battle', PS}).

%% 取消自动战斗
cancel_auto_battle(PS, CurBattlePid) ->
  gen_server:cast(CurBattlePid, {'cancel_auto_battle', PS}).


%% 处理玩家在战斗中下线
on_player_logout(PS, BattlePid) ->
  gen_server:cast(BattlePid, {'player_logout', PS}).


player_try_go_back_to_battle(PS, BattlePid) ->
  gen_server:cast(BattlePid, {'player_try_go_back_to_battle', PS}).


query_battle_start_time(PS, BattlePid) ->
  gen_server:cast(BattlePid, {'query_battle_start_time', PS}).


captain_project(BattlePid, PS, BinData) ->
	gen_server:cast(BattlePid, {'captain_project', PS, BinData}).


%% 直接结束战斗并获得战斗的胜利， 注意：仅仅用于调试！
dbg_force_win_battle(PS, CurBattlePid) ->
  gen_server:cast(CurBattlePid, {'dbg_force_win_battle', PS}).

%% 直接结束战斗并获得战斗的失败， 注意：仅仅用于调试！
dbg_force_lose_battle(PS, _CurBattlePid) ->
  % gen_server:cast(CurBattlePid, {'dbg_force_lose_battle', PS}).
  force_end_battle(PS).



%% 战斗中强行设置属性，注意：仅仅用于调试！
dbg_force_set_attr(AttrType, PS, CurBattlePid, NewVal) ->
  gen_server:cast(CurBattlePid, {'dbg_force_set_attr', AttrType, PS, NewVal}).



%% 战斗中强行设置所造成的伤害值为一个固定值， 注意：仅仅用于调试！
dbg_force_set_do_fix_dam(PS, CurBattlePid, FixDamVal) ->
  gen_server:cast(CurBattlePid, {'dbg_force_set_do_fix_dam', PS, FixDamVal}).


%% 战斗中使伤害计算回归正常（用于取消原先所用的bt_set_do_fix_dam之类的gm指令），注意：仅仅用于调试！
dbg_normalize_dam(PS, CurBattlePid) ->
  gen_server:cast(CurBattlePid, {'dbg_normalize_dam', PS}).


dbg_set_mp(PS, CurBattlePid, Val) ->
  gen_server:cast(CurBattlePid, {'dbg_set_mp', PS, Val}).


dbg_get_buff_info(PS, CurBattlePid, TargetBoId) ->
  gen_server:call(CurBattlePid, {'dbg_get_buff_info', PS, TargetBoId}).


dbg_fast_kill_mon(PS, CurBattlePid) ->
  %%% gen_server:cast(CurBattlePid, {'dbg_fast_kill_mon', PS}).
  dbg_force_set_do_fix_dam(PS, CurBattlePid, 99999999).


% %% 通用检查是否可以发起打怪
% %% @return: ok | {fail, Reason}
% comm_check_start_mf(PS, BMonGroupNo, BattleSubType) ->
% 	% 怪物组编号是否有效？
% 	case lib_bmon_group:is_valid(BMonGroupNo) of
% 		false ->
% 			?ASSERT(false, BMonGroupNo),
% 			{fail, ?PM_UNKNOWN_ERR};
% 		true ->
% 			case lib_bt_misc:is_battle_subtype_valid(BattleSubType) of
% 				false ->
% 					?ASSERT(false, BattleSubType),
% 					{fail, ?PM_UNKNOWN_ERR};
% 				true ->
% 					case not player:is_idle(PS) of
% 						true ->
% 							{fail, ?PM_BUSY_NOW};
% 						false ->
% 							ok
% 					end
% 			end
% 	end.











%% ==================================================================================================

init([BattleId]) ->
  process_flag(trap_exit, true),
  InitBtlState = #btl_state{id = BattleId}, % 设置战斗id
  set_battle_state(InitBtlState),
  {ok, null}.



%% 打怪
handle_cast({'start_mf', NewBattleId, [PS, MonObj, BMonGroupNo, BattleSubType, Callback, ExtraInfo]} , _State) ->
  ?ASSERT(NewBattleId == (get_battle_state())#btl_state.id),

  case MonObj of
    null ->
      MonId = ?INVALID_ID,
      MonNo = ?INVALID_NO;
    _ ->
      MonId = mod_mon:get_id(MonObj),
      MonNo = mod_mon:get_no(MonObj)
  end,

  init_battle(for_mf, [PS, Callback, NewBattleId, BattleSubType, MonId, MonNo, BMonGroupNo]),   % 初始化

  % 添加主队方：玩家
  init_add_players(for_mf, [PS, ?HOST_SIDE, NewBattleId, lib_bmon_group:is_hire_prohibited(BMonGroupNo)]),

  % 添加主队方：宠物
  init_add_partners(for_mf, [PS, ?HOST_SIDE]),

  % 添加客队方：怪物
  init_add_monsters(PS, BMonGroupNo, ?GUEST_SIDE, ExtraInfo),

  % 大秘境buff添加
  BtlState = get_battle_state(),
  case (BtlState#btl_state.subtype =:= ?BTL_SUB_T_MYSTREY) andalso (BtlState#btl_state.round_counter =:= 1) of
    true ->
      MonBuffList = data_damijing_mon_add_buff:get(BtlState#btl_state.bmon_group_no),
      case MonBuffList =/= 0 of
        true ->
          Week = util:get_week(),
          BuffList = element(2, lists:nth(Week, MonBuffList)),
          BoIds = get_bo_id_list(?GUEST_SIDE),
          SkillId = 21,
          F = fun(X) ->
            [handle_skill_add_buff(ActorId, SkillId, X, [ActorId]) || ActorId <- BoIds],
            [lib_bt_send:notify_bo_buff_added(get_bo_by_id(ActorId), X) || ActorId <- BoIds]
              end,
          lists:foreach(F, BuffList);
        false ->
          skip
      end;
    false ->
      skip
  end,

  % 通知战斗内的所有客户端，战斗开始
  lib_bt_send:notify_battle_start(),

  post_battle_start(),

  {noreply, _State};

handle_cast({'set_index', Index} , _State) ->

  BtlState =  get_battle_state(),

  set_battle_state(BtlState#btl_state{limit_task_key = Index}),

  {noreply, _State};


%% 离线竞技场战斗
handle_cast({'start_offline_arena', NewBattleId, PS, Opponent} , _State) ->
  ?ASSERT(NewBattleId == (get_battle_state())#btl_state.id),

  init_battle(for_offline_arena, [NewBattleId, PS, Opponent]),

  % 添加玩家
  init_add_players(for_offline_arena, [PS, Opponent]),

  % 添加宠物
  init_add_partners(for_offline_arena, [PS, Opponent]),

  % 通知战斗内的所有客户端，战斗开始
  lib_bt_send:notify_battle_start(),

  post_battle_start(),

  {noreply, _State};


%% 劫镖
handle_cast({'start_hijack', NewBattleId, PS, Opponent, Callback} , _State) ->
  ?ASSERT(NewBattleId == (get_battle_state())#btl_state.id),

  init_battle(for_hijack, [NewBattleId, PS, Opponent, Callback]),

  % 添加玩家
  init_add_players(for_hijack, [PS, Opponent]),

  % 添加宠物
  init_add_partners(for_hijack, [PS, Opponent]),

  % 通知战斗内的所有客户端，战斗开始
  lib_bt_send:notify_battle_start(),

  post_battle_start(),

  {noreply, _State};


%% 偷菜
handle_cast({'start_steal', NewBattleId, PS, Opponent, Callback} , _State) ->
  ?ASSERT(NewBattleId == (get_battle_state())#btl_state.id),

  init_battle(for_hijack, [NewBattleId, PS, Opponent, Callback]),

  % 添加玩家
  init_add_players(for_offline_arena, [PS, Opponent]),

  % 添加宠物
  init_add_partners(for_offline_arena, [PS, Opponent]),

  % 通知战斗内的所有客户端，战斗开始
  lib_bt_send:notify_battle_start(),

  post_battle_start(),

  {noreply, _State};


%%取经之路

handle_cast({'start_road', NewBattleId, PS, Opponent, Callback} , _State) ->
  ?ASSERT(NewBattleId == (get_battle_state())#btl_state.id),

  init_battle(for_hijack, [NewBattleId, PS, Opponent, Callback]),


%% 	init_add_players(for_offline_arena, [PS, Opponent]),
% 添加玩家
  init_add_players(for_road_battle, [PS, Opponent]),

  % 添加宠物
  init_add_partners(for_road_battle, [PS, Opponent]),
  RoadData = mod_road:get_road_from_ets(player:get_id(PS)),

  RoadData2 = RoadData#road_info{is_road = 1},

  mod_road:update_road_to_ets(RoadData2),

  {ok, Bin} = pt_38:write(?PT_START_BATTLE, [0]),
  lib_send:send_to_sock(PS, Bin),

  % 通知战斗内的所有客户端，战斗开始
  lib_bt_send:notify_battle_start(),

  post_battle_start(),

  {noreply, _State};


%% 跨服3v3 pvp 与机器人战斗
handle_cast({'start_3v3_robot', NewBattleId, PS, Opponent, Callback} , _State) ->
  ?ASSERT(NewBattleId == (get_battle_state())#btl_state.id),
  comm_init_battle__(PS, ?BTL_T_PVP, ?BTL_SUB_T_CROSS_3V3_ROBORT, NewBattleId, Callback),

  % 添加玩家
  init_add_players(cross_3v3_robot, [PS, Opponent,NewBattleId]),

  % 添加宠物
  init_add_partners(cross_3v3_robot, [PS, Opponent]),

  % 通知战斗内的所有客户端，战斗开始
  lib_bt_send:notify_battle_start(),

  post_battle_start_3v3_robot(player:get_id(PS)),

  {noreply, _State};



%% PK
handle_cast({'start_pk', NewBattleId, PS, OpponentPS, PK_Type, Callback} , _State) ->
  ?ASSERT(NewBattleId == (get_battle_state())#btl_state.id),
  init_battle(for_pk, [Callback, NewBattleId, PS, OpponentPS, PK_Type]),

  % 添加玩家
  init_add_players(for_pk, [PS, OpponentPS, NewBattleId]),

  % 添加宠物
  init_add_partners(for_pk, [PS, OpponentPS]),

  % 通知战斗内的所有客户端，战斗开始
  lib_bt_send:notify_battle_start(),

  post_battle_start(),

  {noreply, _State};


%% 跨服3v3PK
handle_cast({'start_cross_3v3', NewBattleId, PS, OpponentPS, PK_Type, Callback} , _State) ->
  ?ASSERT(NewBattleId == (get_battle_state())#btl_state.id),
  init_battle(for_cross_3v3, [Callback, NewBattleId, PS, OpponentPS, PK_Type]),


  % 添加玩家
  init_add_players(cross_3v3, [PS, OpponentPS, NewBattleId]),

  % 添加宠物
  init_add_partners(cross_3v3, [PS, OpponentPS]),


  % 通知战斗内的所有客户端，战斗开始
  lib_bt_send:notify_battle_start(),

  post_battle_start_3v3(player:get_id(PS),player:get_id(OpponentPS)),

  {noreply, _State};



% %%
% handle_cast({'notify_par_cannot_goto_fight', OwnerPlayerId, PartnerId}, _State) ->
% 	case get_bo_by_player_id(OwnerPlayerId) of
% 		null ->
% 			skip;
% 		OwnerPlayerBo ->
% 			Bin = <<>>,

% 	end,
% 	{noreply, _State};


%% 查询战场描述信息
handle_cast({'query_battle_field_desc', PlayerId}, _State) ->
  ?TRACE("query_battle_field_desc..~n"),
  case is_battle_finish() of
    true ->
      lib_bt_send:notify_cli_not_need_back_to_battle(PlayerId);
    false ->
      case get_bo_by_player_id(PlayerId) of
        null ->
          ?ASSERT(false, PlayerId),
          skip;
        Bo ->
          Bin = build_battle_field_desc( ?BOID(Bo) ),
          ?TRACE("ready to notify_battle_field_desc , PlayerId = ~p, Bin=~p..~n", [PlayerId, Bin]),
          lib_bt_send:notify_battle_field_desc_to(Bo, Bin)
      end
  end,
  {noreply, _State};


%% 查询bo的buff信息
handle_cast({'query_bo_buff_info', PlayerId, TargetBoId, BuffNo}, _State) ->
  ?TRACE("query_bo_buff_info..~n"),
  case get_bo_by_player_id(PlayerId) of
    null ->
      ?ASSERT(false, PlayerId),
      skip;
    MyBo ->
      case get_bo_by_id(TargetBoId) of
        null ->
          ?ASSERT(false, TargetBoId),
          skip;
        TargetBo ->
          case lib_bo:find_buff_by_no(TargetBo, BuffNo) of
            null ->
              % ?ASSERT(false, {BuffNo, TargetBo}),
              lib_bt_send:notify_buff_info_to(MyBo, {buff_not_exists, TargetBoId, BuffNo});
            Buff ->
              lib_bt_send:notify_buff_info_to(MyBo, {ok, TargetBoId, Buff})
          end
      end
  end,
  {noreply, _State};


%% 查询自己可操控的bo的技能可使用情况
handle_cast({'query_skill_usable_info', PlayerId, TargetBoId}, _State) ->
  ?TRACE("query_skill_usable_info..~n"),

  PlayerBo = get_bo_by_player_id(PlayerId),
  TargetBo = get_bo_by_id(TargetBoId),
  ?ASSERT(PlayerId == lib_bo:get_parent_obj_id(PlayerBo), {PlayerId, PlayerBo}),

  case (PlayerBo == null) orelse (TargetBo == null) of
    true ->
      % ?ASSERT(false, {PlayerId, TargetBoId, PlayerBo, TargetBo}),
      skip;
    false ->
      case (TargetBoId == lib_bo:id(PlayerBo))  % 查询自己？
        orelse (TargetBoId == lib_bo:get_my_main_partner_bo_id(PlayerBo))  % 查询自己的主宠？
        orelse (TargetBoId == lib_bo:get_my_hired_player_bo_id(PlayerBo))  % 查询自己的雇佣玩家？
        orelse (lib_bt_comm:is_plot_bo(TargetBo) andalso lib_bo:can_be_ctrled(TargetBo) andalso (lib_bo:get_side(TargetBo) == lib_bo:get_side(PlayerBo))) of % 查询可操控的剧情bo？
        true ->
          UsableInfo_Bin = lib_bt_skill:pack_skill_usable_info(TargetBo),
          % ?DEBUG_MSG("PlayerBo=~p,TargetBo=~p,UsableInfo_Bin=~p",[PlayerBo,TargetBo,UsableInfo_Bin]),
          lib_bt_send:notify_skill_usable_info_to_bo(PlayerBo, TargetBoId, UsableInfo_Bin);
        false ->
          % ?DEBUG_MSG("query_skill_usable_info Err =~p,TargetBo=~p",[PlayerBo,TargetBo]),
          skip
      end
  end,
  {noreply, _State};



%% 查询自己或主宠的技能的可使用情况
handle_cast({'query_bo_info_after_back_to_battle', PlayerId, TargetBoId}, _State) ->
  ?TRACE("query_bo_info_after_back_to_battle..~n"),
  case get_bo_by_player_id(PlayerId) of
    null ->
      ?ASSERT(false, PlayerId),
      skip;
    PlayerBo ->
      ?ASSERT(PlayerId == lib_bo:get_parent_obj_id(PlayerBo), {PlayerId, PlayerBo}),
      case get_bo_by_id(TargetBoId) of
        null ->
          skip;
        TargetBo ->
          F = fun(Buff) ->
            <<
              (lib_bo_buff:get_no(Buff)) : 32,
              (lib_bo_buff:get_expire_round(Buff)) : 16
            >>
              end,
          BuffList = lib_bo:get_buff_list(TargetBo),
          BuffInfo_Bin = list_to_binary( [F(X) || X <- BuffList] ),
          BuffInfo_Bin2 = <<
            (length(BuffList)) : 16,
            BuffInfo_Bin / binary
          >>,

          AlreadyJoinBattleParIdListInfo_Bin = case is_player(TargetBo) of
                                                 true ->
                                                   _TmpL = lib_bo:get_my_already_joined_battle_par_id_list(TargetBo),
                                                   _TmpBin = list_to_binary( [<<X:64>> || X <- _TmpL] ),
                                                   <<(length(_TmpL)):16, _TmpBin/binary>>;
                                                 false ->
                                                   <<0:16>>
                                               end,

          TargetBoInfo_Bin =  <<
            (lib_bo:get_id(TargetBo)) : 16,
            (lib_bo:get_die_status(TargetBo)) : 8,
            (lib_bo:get_online_flag(TargetBo)) : 8,
            (lib_bo:get_acc_summon_par_times(TargetBo)) : 8,
            BuffInfo_Bin2 / binary,
            AlreadyJoinBattleParIdListInfo_Bin / binary
          >>,
          lib_bt_send:notify_bo_info_to_back_to_battle_bo(PlayerBo, TargetBoInfo_Bin)
      end
  end,
  {noreply, _State};



%% 客户端通知服务端：播放战报完毕（c2s: client to server）
handle_cast({'c2s_notify_show_battle_report_done', PlayerId}, _State) ->
  case get_bo_by_player_id(PlayerId) of
    null ->
      ?ASSERT(false, PlayerId),
      skip;
    Bo ->
      case is_server_waiting_clients(for_show_br_done) of
        true ->
          ?BT_LOG(io_lib:format("handle_cast, c2s_notify_show_battle_report_done, BoId=~p...~n", [?BOID(Bo)])),
          % ?DEBUG_MSG("c2s_notify_show_battle_report_done ok, PlayerId:~p, cur_round:~p, battle_id:~p", [PlayerId, lib_bt_comm:get_cur_round(), lib_bt_comm:get_battle_id()]),
          handle_c2s_notify_show_battle_report_done(Bo);
        false ->
          % ?DEBUG_MSG("c2s_notify_show_battle_report_done failed for not waiting ...! PlayerId:~p, cur_round:~p, battle_id:~p", [PlayerId, lib_bt_comm:get_cur_round(), lib_bt_comm:get_battle_id()]),
          lib_send:send_prompt_msg(PlayerId, ?PM_BT_SERVER_NOT_WAITING_CLIENTS_FOR_SHOW_BR_DONE),

          % ?ASSERT(false, {get_cur_battle_bhv(), get_battle_state()}),

          skip
      end
  end,
  {noreply, _State};






handle_cast( {'prepare_cmd_NOP', PS, ForBoId}, _State) ->
  PlayerId = player:id(PS),

  PlayerBo = get_bo_by_player_id(PlayerId),
  ForBo = get_bo_by_id(ForBoId),
  case (PlayerBo == null) orelse (ForBo == null) of
    true ->
      ?WARNING_MSG("[mod_battle] prepare_cmd_NOP error!! PlayerId:~p, ForBoId:~p, PlayerBo:~w, ForBo:~w, BtlState:~w",
        [PlayerId, ForBoId, PlayerBo, ForBo, get_battle_state()]),
      ?ASSERT(false, {PlayerId, ForBoId, PlayerBo, ForBo}),
      skip;
    false ->
      case derive_prepare_cmd_for_type(PlayerBo, ForBo) of
        error ->
          ?ASSERT(false, {PlayerId, ForBoId, PlayerBo, ForBo}),
          skip;
        Type ->
          % 辅助调试
          case Type of
            ?PREPARE_CMD_FOR_PLAYER_SELF ->
              ?ASSERT(ForBo =:= PlayerBo, {ForBo, PlayerBo});
            ?PREPARE_CMD_FOR_MAIN_PARTNER ->
              ?ASSERT(lib_bt_comm:is_main_partner(ForBo), ForBo),
              ?BT_LOG(io_lib:format("Main partner prepare to use NOP cmd, MainParBoId=~p~n", [ForBoId]));
            ?PREPARE_CMD_FOR_HIRED_PLAYER ->
              ?ASSERT(lib_bt_comm:is_hired_player(ForBo), ForBo),
              ?BT_LOG(io_lib:format("Hired player prepare to use NOP cmd, HiredPlyBoId=~p~n", [ForBoId]));
            _ ->
              skip
          end,

          case check_prepare_cmd_NOP(ForBo) of
            {fail, Reason} ->
              lib_bt_send:resp_prepare_cmd_NOP_fail(PlayerBo, [Reason, ForBoId]);
            ok ->
              lib_bt_cmd:prepare_cmd_for_bo_NOP(ForBo, PlayerBo)
          end
      end
  end,
  {noreply, _State};




handle_cast({'prepare_cmd_normal_att', [PS, ForBoId, TargetBoId]}, _State) ->
  PlayerId = player:id(PS),

  PlayerBo = get_bo_by_player_id(PlayerId),
  ForBo = get_bo_by_id(ForBoId),
  case (PlayerBo == null) orelse (ForBo == null) of
    true ->
      ?WARNING_MSG("[mod_battle] prepare_cmd_normal_att error!! PlayerId:~p, ForBoId:~p, TargetBoId:~p, PlayerBo:~w, ForBo:~w, BtlState:~w",
        [PlayerId, ForBoId, TargetBoId, PlayerBo, ForBo, get_battle_state()]),
      ?ASSERT(false, {PlayerId, ForBoId, PlayerBo, ForBo}),
      skip;
    false ->
      case derive_prepare_cmd_for_type(PlayerBo, ForBo) of
        error ->
          ?ASSERT(false, {PlayerId, ForBoId, PlayerBo, ForBo}),
          skip;
        Type ->
          % 辅助调试
          case Type of
            ?PREPARE_CMD_FOR_PLAYER_SELF ->
              ?ASSERT(ForBo =:= PlayerBo, {ForBo, PlayerBo});
            ?PREPARE_CMD_FOR_MAIN_PARTNER ->
              ?ASSERT(lib_bt_comm:is_main_partner(ForBo), ForBo),
              ?BT_LOG(io_lib:format("Main partner prepare to use normal att, MainParBoId=~p~n", [ForBoId]));
            ?PREPARE_CMD_FOR_HIRED_PLAYER ->
              ?ASSERT(lib_bt_comm:is_hired_player(ForBo), ForBo),
              ?BT_LOG(io_lib:format("Hired player prepare to use normal att, HiredPlyBoId=~p~n", [ForBoId]));
            ?PREPARE_CMD_FOR_PLOT_BO ->
              ?ASSERT(lib_bt_comm:is_plot_bo(ForBo), ForBo),
              ?BT_LOG(io_lib:format("plot bo prepare to use normal att, BoId=~p~n", [ForBoId]));
            _ ->
              skip
          end,

          case check_prepare_cmd_normal_att(ForBo, TargetBoId) of
            {fail, Reason} ->
              lib_bt_send:resp_prepare_cmd_normal_att_fail(PlayerBo, [Reason, ForBoId, TargetBoId]);
            ok ->
              lib_bt_cmd:prepare_cmd_for_bo_normal_att(ForBo, TargetBoId, PlayerBo)
          end
      end
  end,
  {noreply, _State};



handle_cast( {'prepare_cmd_use_skill', [PS, ForBoId, SkillId, TargetBoId]}, _State) ->
  PlayerId = player:id(PS),

  PlayerBo = get_bo_by_player_id(PlayerId),
  ForBo = get_bo_by_id(ForBoId),
  case (PlayerBo == null) orelse (ForBo == null) of
    true ->
      ?WARNING_MSG("[mod_battle] prepare_cmd_use_skill error!! PlayerId:~p, ForBoId:~p, TargetBoId:~p, PlayerBo:~w, ForBo:~w, BtlState:~w, SkillId:~p",
        [PlayerId, ForBoId, TargetBoId, PlayerBo, ForBo, get_battle_state(), SkillId]),
      ?ASSERT(false, {PlayerId, ForBoId, PlayerBo, ForBo, SkillId}),
      skip;
    false ->
      case derive_prepare_cmd_for_type(PlayerBo, ForBo) of
        error ->
          ?ASSERT(false, {PlayerId, ForBoId, PlayerBo, ForBo}),
          skip;
        Type ->
          % 辅助调试
          case Type of
            ?PREPARE_CMD_FOR_PLAYER_SELF -> % 玩家使用技能
              ?ASSERT(ForBo =:= PlayerBo, {ForBo, PlayerBo});
            ?PREPARE_CMD_FOR_MAIN_PARTNER -> % 主宠使用技能
              ?ASSERT(lib_bt_comm:is_main_partner(ForBo), ForBo),
              ?BT_LOG(io_lib:format("Main partner prepare to use skill, SkillId=~p, MainParBoId=~p~n", [SkillId, ForBoId]));
            ?PREPARE_CMD_FOR_HIRED_PLAYER ->
              ?ASSERT(lib_bt_comm:is_hired_player(ForBo), ForBo),
              ?BT_LOG(io_lib:format("Hired player prepare to use skill, SkillId=~p, HiredPlyBoId=~p~n", [SkillId, ForBoId]));
            _ ->
              skip
          end,

          case check_prepare_cmd_use_skill(ForBo, SkillId, TargetBoId) of
            {fail, Reason} ->
              lib_bt_send:resp_prepare_cmd_use_skill_fail(PlayerBo, [Reason, ForBoId, SkillId, TargetBoId]);
            ok ->
              lib_bt_cmd:prepare_cmd_for_bo_use_skill(ForBo, SkillId, TargetBoId, PlayerBo)
          end
      end
  end,
  {noreply, _State};




handle_cast( {'prepare_cmd_use_goods', [PS, ForBoId, Goods, TargetBoId]}, _State) ->
  PlayerId = player:id(PS),
  GoodsId = lib_goods:get_id(Goods),

  PlayerBo = get_bo_by_player_id(PlayerId),
  ForBo = get_bo_by_id(ForBoId),
  case (PlayerBo == null) orelse (ForBo == null) of
    true ->
      ?WARNING_MSG("[mod_battle] prepare_cmd_normal_att error!! PlayerId:~p, ForBoId:~p, TargetBoId:~p, PlayerBo:~w, ForBo:~w, BtlState:~w",
        [PlayerId, ForBoId, TargetBoId, PlayerBo, ForBo, get_battle_state()]),
      ?ASSERT(false, {PlayerId, ForBoId, PlayerBo, ForBo}),
      skip;
    false ->
      PlayerBoLv = lib_bo:get_lv(PlayerBo),

      case derive_prepare_cmd_for_type(PlayerBo, ForBo) of
        error ->
          ?ASSERT(false, {PlayerId, ForBoId, PlayerBo, ForBo}),
          skip;
        Type ->
          % 辅助调试
          case Type of
            ?PREPARE_CMD_FOR_PLAYER_SELF -> % 玩家使用物品
              ?ASSERT(ForBo =:= PlayerBo, {ForBo, PlayerBo});
            ?PREPARE_CMD_FOR_MAIN_PARTNER -> % 主宠使用物品
              ?ASSERT(lib_bt_comm:is_main_partner(ForBo), ForBo),
              ?BT_LOG(io_lib:format("Main partner prepare to use goods, GoodsId=~p, MainParBoId=~p~n", [GoodsId, ForBoId]));
            ?PREPARE_CMD_FOR_HIRED_PLAYER ->
              ?ASSERT(lib_bt_comm:is_hired_player(ForBo), ForBo),
              ?BT_LOG(io_lib:format("Hired player prepare to use goods, GoodsId=~p, HiredPlyBoId=~p~n", [GoodsId, ForBoId]));
            _ ->
              skip
          end,

          case check_prepare_cmd_use_goods(ForBo, Goods, TargetBoId, PlayerBoLv) of
            {fail, Reason} ->
              lib_bt_send:resp_prepare_cmd_use_goods_fail(PlayerBo, [Reason, ForBoId, GoodsId, TargetBoId]);
            ok ->
              lib_bo:record_goods_info(?BOID(PlayerBo), Goods),
              lib_bt_cmd:prepare_cmd_for_bo_use_goods(ForBo, GoodsId, TargetBoId, PlayerBo)
          end
      end
  end,
  {noreply, _State};



handle_cast( {'prepare_cmd_protect_others', [PS, ForBoId, TargetBoId]}, _State) ->
  PlayerId = player:id(PS),

  PlayerBo = get_bo_by_player_id(PlayerId),
  ForBo = get_bo_by_id(ForBoId),
  case (PlayerBo == null) orelse (ForBo == null) of
    true ->
      ?WARNING_MSG("[mod_battle] prepare_cmd_protect_others error!! PlayerId:~p, ForBoId:~p, TargetBoId:~p, PlayerBo:~w, ForBo:~w, BtlState:~w",
        [PlayerId, ForBoId, TargetBoId, PlayerBo, ForBo, get_battle_state()]),
      ?ASSERT(false, {PlayerId, ForBoId, PlayerBo, ForBo}),
      skip;
    false ->
      case derive_prepare_cmd_for_type(PlayerBo, ForBo) of
        error ->
          ?ASSERT(false, {PlayerId, ForBoId, PlayerBo, ForBo}),
          skip;
        Type ->
          % 辅助调试
          case Type of
            ?PREPARE_CMD_FOR_PLAYER_SELF -> % 玩家使用保护
              ?ASSERT(ForBo =:= PlayerBo, {ForBo, PlayerBo});
            ?PREPARE_CMD_FOR_MAIN_PARTNER -> % 主宠使用保护
              ?ASSERT(lib_bt_comm:is_main_partner(ForBo), ForBo),
              ?BT_LOG(io_lib:format("Main partner prepare_cmd_protect_others, MainParBoId=~p~n", [ForBoId]));
            ?PREPARE_CMD_FOR_HIRED_PLAYER ->
              ?ASSERT(lib_bt_comm:is_hired_player(ForBo), ForBo),
              ?BT_LOG(io_lib:format("Hired player prepare_cmd_protect_others, HiredPlyBoId=~p~n", [ForBoId]));
            _ ->
              skip
          end,

          case check_prepare_cmd_protect_others(ForBo, TargetBoId) of
            {fail, Reason} ->
              lib_bt_send:resp_prepare_cmd_protect_others_fail(PlayerBo, [Reason, ForBoId, TargetBoId]);
            ok ->
              lib_bt_cmd:prepare_cmd_for_bo_protect_others(ForBo, TargetBoId, PlayerBo)
          end
      end
  end,
  {noreply, _State};


handle_cast( {'prepare_cmd_capture', [PS, ForBoId, TargetBoId]}, _State) ->
  PlayerId = player:id(PS),

  PlayerBo = get_bo_by_player_id(PlayerId),
  ForBo = get_bo_by_id(ForBoId),
  case (PlayerBo == null) orelse (ForBo == null) of
    true ->
      ?WARNING_MSG("[mod_battle] prepare_cmd_capture error!! PlayerId:~p, ForBoId:~p, TargetBoId:~p, PlayerBo:~w, ForBo:~w, BtlState:~w",
        [PlayerId, ForBoId, TargetBoId, PlayerBo, ForBo, get_battle_state()]),
      ?ASSERT(false, {PlayerId, ForBoId, PlayerBo, ForBo}),
      skip;
    false ->
      case derive_prepare_cmd_for_type(PlayerBo, ForBo) of
        error ->
          ?ASSERT(false, {PlayerId, ForBoId, PlayerBo, ForBo}),
          skip;
        Type ->
          % 辅助调试
          case Type of
            ?PREPARE_CMD_FOR_PLAYER_SELF -> % 玩家使用保护
              ?ASSERT(ForBo =:= PlayerBo, {ForBo, PlayerBo});
            ?PREPARE_CMD_FOR_MAIN_PARTNER -> % 主宠使用保护
              ?ASSERT(lib_bt_comm:is_main_partner(ForBo), ForBo),
              ?BT_LOG(io_lib:format("Main partner prepare_cmd_protect_others, MainParBoId=~p~n", [ForBoId]));
            ?PREPARE_CMD_FOR_HIRED_PLAYER ->
              ?ASSERT(lib_bt_comm:is_hired_player(ForBo), ForBo),
              ?BT_LOG(io_lib:format("Hired player prepare_cmd_protect_others, HiredPlyBoId=~p~n", [ForBoId]));
            _ ->
              skip
          end,

          case check_prepare_cmd_capture(ForBo, TargetBoId) of
            {fail, Reason} ->
              lib_bt_send:resp_prepare_cmd_capture_fail(PlayerBo, [ForBoId, TargetBoId]);
            ok ->
              lib_bt_cmd:prepare_cmd_for_bo_capture(ForBo, TargetBoId, PlayerBo)
          end
      end
  end,
  {noreply, _State};




handle_cast( {'prepare_cmd_escape', PS, ForBoId}, _State) ->
  PlayerId = player:id(PS),

  PlayerBo = get_bo_by_player_id(PlayerId),
  ForBo = get_bo_by_id(ForBoId),
  case (PlayerBo == null) orelse (ForBo == null) of
    true ->
      ?WARNING_MSG("[mod_battle] prepare_cmd_escape error!! PlayerId:~p, ForBoId:~p, PlayerBo:~w, ForBo:~w, BtlState:~w",
        [PlayerId, ForBoId, PlayerBo, ForBo, get_battle_state()]),
      ?ASSERT(false, {PlayerId, ForBoId, PlayerBo, ForBo}),
      skip;
    false ->
      case derive_prepare_cmd_for_type(PlayerBo, ForBo) of
        error ->
          ?ASSERT(false, {PlayerId, ForBoId, PlayerBo, ForBo}),
          skip;
        Type ->
          % 辅助调试
          case Type of
            ?PREPARE_CMD_FOR_PLAYER_SELF -> % 玩家逃跑
              ?ASSERT(ForBo =:= PlayerBo, {ForBo, PlayerBo});
            ?PREPARE_CMD_FOR_MAIN_PARTNER -> % 主宠逃跑
              ?ASSERT(lib_bt_comm:is_main_partner(ForBo), ForBo),
              ?BT_LOG(io_lib:format("Main partner prepare_cmd_escape, MainParBoId=~p~n", [ForBoId]));
            ?PREPARE_CMD_FOR_HIRED_PLAYER ->
              ?ASSERT(lib_bt_comm:is_hired_player(ForBo), ForBo),
              ?BT_LOG(io_lib:format("Hired player prepare_cmd_escape, HiredPlyBoId=~p~n", [ForBoId]));
            _ ->
              skip
          end,

          case Type of
            ?PREPARE_CMD_FOR_PLOT_BO ->  % 不允许操控剧情bo逃跑
              ?ASSERT(false, {PlayerId, ForBoId, PlayerBo, ForBo}),
              skip;
            _ ->
              case check_prepare_cmd_escape(ForBo) of
                {fail, Reason} ->
                  lib_bt_send:resp_prepare_cmd_escape_fail(PlayerBo, [Reason, ForBoId]);
                ok ->
                  lib_bt_cmd:prepare_cmd_for_bo_escape(ForBo, PlayerBo)
              end
          end
      end
  end,
  {noreply, _State};




handle_cast( {'prepare_cmd_defend', PS, ForBoId}, _State) ->
  PlayerId = player:id(PS),

  PlayerBo = get_bo_by_player_id(PlayerId),
  ForBo = get_bo_by_id(ForBoId),
  case (PlayerBo == null) orelse (ForBo == null) of
    true ->
      ?WARNING_MSG("[mod_battle] prepare_cmd_defend error!! PlayerId:~p, ForBoId:~p, PlayerBo:~w, ForBo:~w, BtlState:~w",
        [PlayerId, ForBoId, PlayerBo, ForBo, get_battle_state()]),
      ?ASSERT(false, {PlayerId, ForBoId, PlayerBo, ForBo}),
      skip;
    false ->
      case derive_prepare_cmd_for_type(PlayerBo, ForBo) of
        error ->
          ?DEBUG_MSG("wjctestcmd ~p~n",[{ForBoId,PlayerBo}]),
          ?ASSERT(false, {PlayerId, ForBoId, PlayerBo, ForBo}),
          skip;
        Type ->
          % 辅助调试
          case Type of
            ?PREPARE_CMD_FOR_PLAYER_SELF -> % 玩家使用防御
              ?ASSERT(ForBo =:= PlayerBo, {ForBo, PlayerBo});
            ?PREPARE_CMD_FOR_MAIN_PARTNER -> % 主宠使用防御
              ?ASSERT(lib_bt_comm:is_main_partner(ForBo), ForBo),
              ?BT_LOG(io_lib:format("Main partner prepare_cmd_defend, MainParBoId=~p~n", [ForBoId]));
            ?PREPARE_CMD_FOR_HIRED_PLAYER ->
              ?ASSERT(lib_bt_comm:is_hired_player(ForBo), ForBo),
              ?BT_LOG(io_lib:format("Hired player prepare_cmd_defend, HiredPlyBoId=~p~n", [ForBoId]));
            _ ->
              skip
          end,

          case check_prepare_cmd_defend(ForBo) of
            {fail, Reason} ->
              lib_bt_send:resp_prepare_cmd_defend_fail(PlayerBo, [Reason, ForBoId]);
            ok ->
              lib_bt_cmd:prepare_cmd_for_bo_defend(ForBo, PlayerBo)
          end
      end
  end,
  {noreply, _State};



handle_cast( {'prepare_cmd_summon_partner', [PS, ForBoId, PartnerId]}, _State) ->
  PlayerId = player:id(PS),

  PlayerBo = get_bo_by_player_id(PlayerId),
  ForBo = get_bo_by_id(ForBoId),
  case (PlayerBo == null) orelse (ForBo == null) of
    true ->
      ?WARNING_MSG("[mod_battle] prepare_cmd_defend error!! PlayerId:~p, ForBoId:~p, PlayerBo:~w, ForBo:~w, BtlState:~w",
        [PlayerId, ForBoId, PlayerBo, ForBo, get_battle_state()]),
      ?ASSERT(false, {PlayerId, ForBoId, PlayerBo, ForBo}),
      skip;
    false ->
      Type = derive_prepare_cmd_for_type(PlayerBo, ForBo),

      if
        (Type == ?PREPARE_CMD_FOR_PLAYER_SELF)
          orelse (Type == ?PREPARE_CMD_FOR_HIRED_PLAYER) ->
          case check_prepare_cmd_summon_partner(PS, ForBo, PartnerId) of
            {fail, Reason} ->
              lib_bt_send:resp_prepare_cmd_summon_partner_fail(PlayerBo, [Reason, ForBoId, PartnerId]);
            ok ->
              ?BT_LOG(io_lib:format("prepare_cmd_summon_partner, ForType:~p, ForBoId=~p~n", [Type, ForBoId])),
              lib_bt_cmd:prepare_cmd_for_bo_summon_partner(ForBo, PartnerId, PlayerBo)
          end;
        true ->
          ?ASSERT(false, {Type, PlayerId, ForBoId, PlayerBo, ForBo}),
          skip
      end
  end,
  {noreply, _State};


handle_cast( {'req_prepare_cmd_by_AI', PS, ForBoId}, _State) ->
  PlayerId = player:id(PS),

  PlayerBo = get_bo_by_player_id(PlayerId),
  ForBo = get_bo_by_id(ForBoId),
  case (PlayerBo == null) orelse (ForBo == null) of
    true ->
      ?WARNING_MSG("[mod_battle] req_prepare_cmd_by_AI error!! PlayerId:~p, ForBoId:~p, PlayerBo:~w, ForBo:~w, BtlState:~w",
        [PlayerId, ForBoId, PlayerBo, ForBo, get_battle_state()]),
      ?ASSERT(false, {PlayerId, ForBoId, PlayerBo, ForBo}),
      skip;
    false ->
      case derive_prepare_cmd_for_type(PlayerBo, ForBo) of
        error ->
          ?ASSERT(false, {PlayerId, ForBoId, PlayerBo, ForBo}),
          skip;
        Type ->
          % 辅助调试
          case Type of
            ?PREPARE_CMD_FOR_PLAYER_SELF -> % 玩家使用防御
              ?ASSERT(ForBo =:= PlayerBo, {ForBo, PlayerBo});
            ?PREPARE_CMD_FOR_MAIN_PARTNER -> % 主宠使用防御
              ?ASSERT(lib_bt_comm:is_main_partner(ForBo), ForBo),
              ?BT_LOG(io_lib:format("Main partner prepare_cmd_defend, MainParBoId=~p~n", [ForBoId]));
            ?PREPARE_CMD_FOR_HIRED_PLAYER ->
              ?ASSERT(lib_bt_comm:is_hired_player(ForBo), ForBo),
              ?BT_LOG(io_lib:format("Hired player prepare_cmd_defend, HiredPlyBoId=~p~n", [ForBoId]));
            _ ->
              skip
          end,

          case check_req_prepare_cmd_by_AI(ForBo) of
            {fail, Reason} ->
              lib_bt_send:resp_prepare_cmd_by_AI_fail(PlayerBo, [Reason, ForBoId]);
            ok ->
              lib_bt_cmd:prepare_cmd_for_bo_by_AI(ForBo, PlayerBo)
          end
      end
  end,
  {noreply, _State};




%% 请求自动战斗
handle_cast({'request_auto_battle', PS}, _State) ->
  PlayerId = player:id(PS),
  case get_bo_by_player_id(PlayerId) of
    null ->
      ?ASSERT(false, PlayerId),
      skip;
    Bo ->
      BoId = lib_bo:id(Bo),
      case lib_bo:is_auto_battle(Bo) of
        true ->
          ?BT_LOG(io_lib:format("mod_battle, request_auto_battle, send prompt msg: PM_BT_ALRDY_AUTO_BATTLE (BoId=~p)~n", [BoId])),
          lib_send:send_prompt_msg(PS, ?PM_BT_ALRDY_AUTO_BATTLE);
        false ->

          lib_bo:set_auto_battle(BoId, true),

          lib_bt_send:resp_request_auto_battle_ok(Bo),

          case lib_bo:is_ready(Bo) of
            true ->
              ?BT_LOG(io_lib:format("mod_battle, request_auto_battle, is ready so skip (BoId=~p)~n", [BoId])),
              skip;
            false ->
              ?BT_LOG(io_lib:format("mod_battle, request_auto_battle, NOT ready so prepare normal att (BoId=~p)~n", [BoId])),
              % TODO：自动战斗暂时都是用普通攻击
              lib_bo:prepare_cmd_normal_att(BoId, ?INVALID_ID),

              % mark_cmd_prepared

              Bo_Latest = get_bo_by_id(BoId),
              lib_bt_send:notify_bo_is_ready(Bo_Latest),

              lib_bt_cmd:post_bo_ready(BoId)
          end
      end
  end,
  {noreply, _State};




%% 取消自动战斗
handle_cast({'cancel_auto_battle', PS}, _State) ->
  PlayerId = player:id(PS),
  case get_bo_by_player_id(PlayerId) of
    null ->
      ?ASSERT(false, PlayerId),
      skip;
    Bo ->


%			case is_auto_battle(Bo) of
% 				false ->
% 					skip;
% 				true ->
% 					?DEBUG_MSG("CANCEL_AUTO_BATTLE!!!!@...~n", []),
% 					put(Bo#battle_obj.bo_id, Bo#battle_obj{is_auto_battle = false})
% 			end


      BoId = lib_bo:id(Bo),

      case lib_bo:is_auto_battle(Bo) of
        false ->
          ?BT_LOG(io_lib:format("mod_battle, cancel_auto_battle, send prompt msg: PM_BT_NOT_AUTO_BATTLE (BoId=~p)~n", [BoId])),
          lib_send:send_prompt_msg(PS, ?PM_BT_NOT_AUTO_BATTLING);
        true ->

          lib_bo:set_auto_battle(BoId, false),

          lib_bt_send:resp_cancel_auto_battle_ok(Bo)

        % TODO： 确认----是否需要做其他处理？？ 目前暂时感觉不需要！
        % ...



        % case lib_bo:is_ready(Bo) of
        % 	true ->
        % 		?DEBUG_MSG("mod_battle, request_auto_battle, is ready so skip (BoId=~p)", [BoId]),
        % 		skip;
        % 	false ->
        % 		?DEBUG_MSG("mod_battle, request_auto_battle, NOT ready so prepare normal att (BoId=~p)", [BoId]),
        % 		% TODO：自动战斗暂时都是用普通攻击
        % 		Bo_Latest = get_bo_by_id(BoId),
        % 		lib_bo:prepare_cmd_normal_att(BoId, ?INVALID_ID),

        % 		handle_bo_ready(BoId)
        % end
      end
  end,
  {noreply, _State};



%% 处理玩家在战斗过程中下线的情况
handle_cast({'player_logout', PS}, _State) ->
  ?TRACE("battlepid got player_logout, battle pid=~p, PlayerId=~p~n", [self(), player:id(PS)]),
  ?BT_LOG(io_lib:format("battlepid got player_logout, battle pid=~p, PlayerId=~p~n", [self(), player:id(PS)])),
  handle_player_logout(PS),
  {noreply, _State};


%% （断线重连后）尝试回归战场
handle_cast({'player_try_go_back_to_battle', PS}, _State) ->
  ?TRACE("player_try_go_back_to_battle, PlayerId:~p~n", [player:id(PS)]),
  ?BT_LOG(io_lib:format("player_try_go_back_to_battle, PlayerId=~p~n", [player:id(PS)])),

  ?TRY_CATCH(handle_player_try_go_back_to_battle(PS), ErrReason),
  {noreply, _State};



%% 查询战斗的开始时间
handle_cast({'query_battle_start_time', PS}, _State) ->
  ?TRACE("query_battle_start_time, PlayerId:~p~n", [player:id(PS)]),
  ?TRY_CATCH(handle_query_battle_start_time(PS), ErrReason),
  {noreply, _State};



%% 队长作战方针
handle_cast({'captain_project', PS, BinData}, _State) ->
	PlayerId = player:id(PS),
  	PlayerBo = get_bo_by_player_id(PlayerId),
	L = get_bo_id_list(PlayerBo#battle_obj.side),
	List = lists:delete(PlayerBo#battle_obj.id, L),
	lists:foreach(fun(BoId) ->
						  %% 只发给在线的
						  case lib_bt_comm:is_online_player(get_bo_by_id(BoId)) of
							  ?true ->
								  lib_bt_send:send_to_client(BoId, BinData);
							  ?false ->
								  skip
						  end
				  end, List),
	{noreply, _State};


%% 直接结束战斗并获得战斗的胜利， 仅仅用于调试！
handle_cast({'dbg_force_win_battle', PS}, _State) ->
  ?TRACE("dbg_force_win_battle.....~n"),
  PlayerId = player:id(PS),
  case get_bo_by_player_id(PlayerId) of
    null ->
      skip;
    Bo ->
      Side = lib_bo:get_side(Bo),
      set_win_side(Side),
      mark_battle_finish(),
      schedule_battle_finish()
  end,
  {noreply, _State};


% %% 直接结束战斗并获得战斗的失败， 仅仅用于调试！
% handle_cast({'dbg_force_lose_battle', PS}, _State) ->
% 	?TRACE("dbg_force_lose_battle.....~n"),
% 	PlayerId = player:id(PS),
% 	case get_bo_by_player_id(PlayerId) of
% 		null ->
% 			skip;
% 		Bo ->
% 			Side = lib_bo:get_side(Bo),
% 			set_win_side( to_enemy_side(Side) ),
% 			mark_battle_finish(),
% 			schedule_battle_finish()
% 	end,
% 	{noreply, _State};



%% 强行结束战斗（战斗结果认为是失败）
handle_cast({'force_end_battle', PS}, _State) ->
  ?TRACE("force_end_battle.....~n"),
  PlayerId = player:id(PS),
  case get_bo_by_player_id(PlayerId) of
    null ->
      ?ASSERT(false, PlayerId),
      skip;
    Bo ->
      Side = lib_bo:get_side(Bo),
      set_win_side( to_enemy_side(Side) ),
      mark_battle_finish(),
      schedule_battle_finish()
  end,
  {noreply, _State};

%% 强行结束战斗（战斗结果为平手）
handle_cast('force_end_battle_no_win_side', _State) ->
  case is_battle_finish() of
    true -> skip;
    false ->
      set_win_side(?NO_SIDE),
      mark_battle_finish(),
      schedule_battle_finish()
  end,
  {noreply, _State};



%% 战斗中强行设置属性， 仅仅用于调试！
handle_cast({'dbg_force_set_attr', AttrType, PS, NewVal}, _State) ->
  ?TRACE("dbg_force_set_attr, AttrType=~p, NewVal=~p.....~n", [AttrType, NewVal]),
  PlayerId = player:id(PS),
  case get_bo_by_player_id(PlayerId) of
    null ->
      ?ASSERT(false, PlayerId),
      skip;
    Bo ->
      OldAttrs = Bo#battle_obj.attrs,
      Bo2 = 	case AttrType of
               ?ATTR_PHY_ATT ->
                 NewAttrs = OldAttrs#attrs{phy_att = NewVal},
                 Bo#battle_obj{attrs = NewAttrs};
               ?ATTR_MAG_ATT ->
                 NewAttrs = OldAttrs#attrs{mag_att = NewVal},
                 Bo#battle_obj{attrs = NewAttrs};
               ?ATTR_PHY_DEF ->
                 NewAttrs = OldAttrs#attrs{phy_def = NewVal},
                 Bo#battle_obj{attrs = NewAttrs};
               ?ATTR_MAG_DEF ->
                 NewAttrs = OldAttrs#attrs{mag_def = NewVal},
                 Bo#battle_obj{attrs = NewAttrs};

               ?ATTR_ACT_SPEED ->
                 NewAttrs = OldAttrs#attrs{act_speed = NewVal},
                 Bo#battle_obj{attrs = NewAttrs};

               _ ->
                 ?ASSERT(false, AttrType),
                 Bo
             end,

      lib_bt_comm:update_bo(Bo2)
  end,
  {noreply, _State};




%% 战斗中强行设置所造成的伤害值为一个固定值， 仅仅用于调试！
handle_cast({'dbg_force_set_do_fix_dam', PS, FixDamVal}, _State) ->
  ?TRACE("dbg_force_set_do_fix_dam, FixDamVal=~p.....~n", [FixDamVal]),
  PlayerId = player:id(PS),
  case get_bo_by_player_id(PlayerId) of
    null ->
      ?ASSERT(false, PlayerId),
      skip;
    PlayerBo ->
      L = get_bo_id_list(lib_bo:get_side(PlayerBo)),
      F = fun(X) ->
        Bo = get_bo_by_id(X),
        Bo2 = Bo#battle_obj{dbg_force_fix_dam = FixDamVal},
        lib_bt_comm:update_bo(Bo2)
          end,
      lists:foreach(F, L)
  end,
  {noreply, _State};

handle_cast({'dbg_add_anger', PS, Anger}, State) ->
  PlayerId = player:id(PS),
  case get_bo_by_player_id(PlayerId) of
    null ->
      skip;
    PlayerBo ->
      lib_bo:add_anger(PlayerBo, Anger)
  end,
  {noreply, State};

handle_cast({'dbg_normalize_dam', PS}, _State) ->
  ?TRACE("dbg_normalize_dam.....~n"),
  PlayerId = player:id(PS),
  case get_bo_by_player_id(PlayerId) of
    null ->
      ?ASSERT(false, PlayerId),
      skip;
    Bo ->
      Bo2 = Bo#battle_obj{dbg_force_fix_dam = invalid},
      lib_bt_comm:update_bo(Bo2)
  end,
  {noreply, _State};



handle_cast({'dbg_set_mp', PS, NewVal}, _State) ->
  ?TRACE("dbg_set_mp.....~n"),
  PlayerId = player:id(PS),
  case get_bo_by_player_id(PlayerId) of
    null ->
      ?ASSERT(false, PlayerId),
      skip;
    Bo ->
      OldVal = lib_bo:get_mp(Bo),
      Diff = NewVal - OldVal,
      lib_bo:add_mp(?BOID(Bo), Diff)
  end,
  {noreply, _State};

% handle_cast({'dbg_fast_kill_mon', PS}, _State) ->
% 	?TRACE("dbg_fast_kill_mon.....~n"),
% 	PlayerId = player:id(PS),
% 	case get_bo_by_player_id(PlayerId) of
% 		null ->
% 			?ASSERT(false, PlayerId),
% 			skip;
% 		_PlayerBo ->
% 			?TRACE("set all mon to 1 hp.....~n"),
% 			% 把所有怪都调为剩下1血
% 			L = get_bo_id_list(?MON_DFL_SIDE),
% 			F = fun(BoId) ->
% 					lib_bo:set_hp(BoId, 1)
% 				end,
% 			lists:foreach(F, L)
% 	end,
% 	{noreply, _State};

%% 终止战斗
handle_cast({'stop', Reason}, _State) ->
  {stop, Reason, _State};







handle_cast(_R, _State) ->
  ?ASSERT(false, _R),
  {noreply, _State}.



% 作废！！
% %% 获取战斗对象信息（gm指令做调试用）
% handle_call({'get_bo_info', BoId}, _From, _State) ->
% 	Ret = 	case get(BoId) of
% 				undefined -> null;
% 				Bo -> Bo
% 			end,
%     {reply, Ret, _State};


%% 获取战斗对象信息，仅用于调试！
handle_call({'debug_get_bo_info', BoId}, _From, _State) ->
  Ret = case is_bo_exists(BoId) of
          false ->
            {fail, ?PM_BT_TARGET_BO_NOT_EXISTS};
          true ->
            Bo = get_bo_by_id(BoId),
            FieldList = record_info(fields, battle_obj),
            F = fun(Field, AccInfo_Str) ->
              Index = list_util:get_ele_pos(Field, FieldList) + 1,
              InfoStr = io_lib:format("~p = ~p~n", [Field, erlang:element(Index, Bo)]),
              AccInfo_Str ++ [InfoStr]
                end,
            BoInfo_Str = lists:foldl(F, [], FieldList),
            {ok, list_to_binary(BoInfo_Str)}
        end,
  {reply, Ret, _State};



handle_call({'dbg_get_buff_info', _PS, TargetBoId}, _From, _State) ->
  ?TRACE("dbg_get_buff_info.....~n"),
  Ret = case get_bo_by_id(TargetBoId) of
          null ->
            null;
          Bo ->
            lib_bo:get_buff_list(Bo)
        end,
  {reply, Ret, _State};



handle_call(_R, _From, _State) ->
  {reply, ok, _State}.





%% 新回合开始
handle_info({'new_round_begin'}, _State) ->
  new_round_begin(),
  {noreply, _State};



%% 回合的行为开始（双方所有bo都准备好后，开始处理当前回合的战斗）
handle_info({'round_action_begin'}, _State) ->
  % ?DEBUG_MSG("round_action_begin....", []),

  % 标记战斗的当前状态为“正在处理当前回合的行为”
  set_cur_battle_bhv(?BHV_HANDLING_ROUND_ACTIONS),

%%     lib_battle_common:set_half_turn_battling(),
  %%State = get(battle_state),


  %%CurAerSide = State#state.aer_side,

  %%atter_auto_sel_skill(CurAerSide),




  %%FightOrderList = lib_chessboard:sort_boid_list(AerList),
  %%lib_battle:set_aer_turn_list(FightOrderList),


  %1. 重算各单位的乱敏
  %%% recalc_bo_tmp_rand_act_speed(),

  %2. 依据行动速度以及各buff状态， 拼装战斗单位行动列表
  %%% reorder_cur_actor_list(),

  reset_cur_actor_list(),

  % 记录战斗对象的保护信息
  record_bo_protecting_info(),

  lib_bt_send:notify_round_action_begin(),   % 通知客户端：回合行动开始

  %%排序一下干扰顺序
  L = get_all_bo_id_list(),

  F =
    fun(X) ->
      Bo = get_bo_by_id(X),

      BuffSquential = case lib_bo:find_buff_by_name(Bo,?BFN_ADD_ACT_SPEED_SEQ) of
                        null ->
                          0;
                        BeProtBuff ->
                          BuffData = data_buff:get(BeProtBuff#bo_buff.buff_no),
                          BuffData#buff_tpl.para
                      end,
      case lib_bo:is_using_normal_att(Bo) orelse lib_bo:get_cur_skill_cfg(Bo) == null of
        true ->  % 表示普通攻击
          Bo2 =
            Bo#battle_obj{
              tmp_status =Bo#battle_obj.tmp_status#bo_tmp_stat{bo_act_speed = BuffSquential}
            },
          lib_bt_comm:update_bo(Bo2);
        false ->
          CurSklCfg = lib_bo:get_cur_skill_cfg(Bo),
          ?DEBUG_MSG("wjctestSpeed ~p~n",[{CurSklCfg,Bo,11111111111111,CurSklCfg#skl_cfg.sequential_interference}]),

          SequentialInterference =
            case lib_bo:can_use_skill_on_real_act(Bo, CurSklCfg) of
              true ->
                max(CurSklCfg#skl_cfg.sequential_interference,BuffSquential);
              {false,_} ->
                BuffSquential
            end,
          Bo2 =
            Bo#battle_obj{
              tmp_status =Bo#battle_obj.tmp_status#bo_tmp_stat{bo_act_speed = SequentialInterference}
            },
          lib_bt_comm:update_bo(Bo2)
      end
    end,
  lists:foreach(F,L),

  handle_one_round_actions(),

  {noreply, _State};



%% 为下一个回合刷出下一波怪
%% @para: SpawnReason => 刷出下一波怪的原因(normal | mon_died_for_dot)
handle_info({'spawn_next_bmon_group_for_next_round', BMonGroupNo, SpawnReason, Lv}, State) ->
  ?ASSERT(lib_bmon_group:is_valid(BMonGroupNo), BMonGroupNo),

  ?DEBUG_MSG("nextbmon ~p~n" , [State]),

  BMonGroup = lib_bmon_group:get_cfg_data(BMonGroupNo),
  SpawnMonCount0 = decide_spawn_mon_count(BMonGroup),

  % AvgLv = mod_team:get_member_average_lv(player:get_id(PS)),
  % MaxLv = mod_team:get_member_max_lv(PS),

  % % 怪物等级大概为平均等级与最高等级 相加除以2
  % Lv = erlang:round((AvgLv + MaxLv)/2),

  % 判断并容错
  SpawnMonCount = case SpawnMonCount0 < 1 of
                    true -> ?ASSERT(false, {BMonGroup, SpawnMonCount0}), ?MAX_BO_COUNT_PER_SIDE;
                    false -> SpawnMonCount0
                  end,

  ?BT_LOG(io_lib:format("do spawn_next_bmon_group_for_next_round, BMonGroupNo:~p, SpawnMonCount:~p, cur_round:~p~n", [BMonGroupNo, SpawnMonCount, lib_bt_comm:get_cur_round()])),

  ?DEBUG_MSG("handle_info, spawn_next_bmon_group_for_next_round, BMonGroupNo:~p, SpawnMonCount:~p, cur_round:~p, battle_id:~p",
    [BMonGroupNo, SpawnMonCount, lib_bt_comm:get_cur_round(), lib_bt_comm:get_battle_id()]),

  % % 调试代码
  % L__ = lib_bt_comm:get_bo_id_list(?MON_DFL_SIDE),
  %    %%?TRACE("LLLLLL: ~p~n", [L]),
  %    CurOccupyPosList = [lib_bo:get_pos(get_bo_by_id(BoId)) || BoId <- L__],

  %    ?BT_LOG(io_lib:format("handle info, spawn_next_bmon_group_for_next_round, L__:~p, CurOccupyPosList:~p, hp:~p, DieStatus:~p~n",
  %                [L__, CurOccupyPosList,
  %                		[lib_bo:get_hp(get_bo_by_id(X)) || X <- L__],
  %                		[lib_bo:get_die_status(get_bo_by_id(X)) || X <- L__]
  %                		])
  % 	),


  ForSide = ?MON_DFL_SIDE,  % 固定刷在怪物方
  NewMonBoList = do_add_monsters(Lv,BMonGroup, SpawnMonCount, ForSide, []),
  ?ASSERT(NewMonBoList /= [], {BMonGroupNo, SpawnMonCount}),

  lib_bt_dict:set_cur_bmon_group_no(BMonGroupNo),
  {ok, NewNthWave} = lib_bt_dict:incr_nth_wave_bmon_group(),

  % 通知客户端
  ForRound = lib_bt_comm:get_cur_round() + 1,  % 目前固定是为下一个回合所刷
  lib_bt_send:notify_next_bmon_group_spawned(ForRound, ForSide, NewNthWave, NewMonBoList),

  [lib_bo:adjust_when_spawn_round(?BOID(X), ForRound) || X <- NewMonBoList],


  ?Ifc (SpawnReason == mon_died_for_dot)
% 注意：按目前和客户端约定的实现方法，这里需要更改bhv状态，
%       并且，该情况下客户端无需播放战斗（因为没有战报），故预cast一个较短时间的cli_notify_show_br_done_timeout
set_cur_battle_bhv(?BHV_WAITING_CLIENTS_FOR_SHOW_BR_DONE),
Intv = 25000,
erlang:send_after(Intv, self(), {'cli_notify_show_br_done_timeout', lib_bt_comm:get_cur_round()}),
?BT_LOG(io_lib:format("do spawn_next_bmon_group_for_next_round, mon_died_for_dot, cur round:~p...~n", [lib_bt_comm:get_cur_round()])),
?DEBUG_MSG("handle_info, spawn_next_bmon_group_for_next_round, mon_died_for_dot, cur_round:~p, battle_id:~p",
[lib_bt_comm:get_cur_round(), lib_bt_comm:get_battle_id()])
?End,

{noreply, State};



%% 战斗结束
handle_info({'battle_finish'}, _State) ->
handle_battle_finish(),
{noreply, _State};






%% 模拟使用普通攻击
handle_info({'simu_prepare_cmd_normal_att', BoId}, _State) ->
_Bo = get_bo_by_id(BoId),
?ASSERT(_Bo /= null, BoId),
% PlayerId = lib_bo:get_parent_obj_id(Bo),

% SendPid = Bo#battle_obj.send_pid,
% self() ! {'SEL_SKILL', simu_sel, 0, 0, 0, SendPid}.



% 注意到：目标bo id参数传入的是?INVALID_ID
lib_bo:prepare_cmd_normal_att(BoId, ?INVALID_ID),

lib_bo:mark_cmd_prepared(BoId),  %%lib_bo:mark_ready_flag(Bo2),

% lib_bt_send:notify_use_skill_ok(Bo3, Type, SkillId, TargetBoId),

% % 通知所有玩家：某某已经准备好了
% lib_bt_send:notify_bo_is_ready(Bo3),

lib_bt_cmd:post_bo_ready(BoId),

{noreply, _State};




%% 模拟客户端通知服务端：播放战报完毕
handle_info({'simu_c2s_notify_show_battle_report_done', BoId}, _State) ->
Bo = get_bo_by_id(BoId),
?ASSERT(Bo /= null, BoId),

?BT_LOG(io_lib:format("[battle] simu_c2s_notify_show_battle_report_done, BoId=~p~n", [BoId])),
handle_c2s_notify_show_battle_report_done(Bo),
{noreply, _State};




%% 处理客户端下达指令超时，以免卡住战斗流程
%% @para: RoundCountThen => 投递该消息当时的回合数
handle_info({'prepare_cmd_timeout', RoundCountThen}, _State)  ->
CurRoundCount = lib_bt_comm:get_cur_round(),
?ASSERT(CurRoundCount >= RoundCountThen),

case CurRoundCount > RoundCountThen of
true -> % 当前回合数大于当时的回合数，说明战斗没卡住，故不需做处理
?BT_LOG(io_lib:format("prepare_cmd_timeout, CurRoundCount(~p) > RoundCountThen(~p), so it is ok!~n", [CurRoundCount, RoundCountThen])),
skip;
false ->
% 是否在等待客户端下指令？
case is_server_waiting_clients(for_prepare_cmd_done) of
false ->
skip;
true ->
% ?WARNING_MSG("[mod_battle] prepare_cmd_timeout!!! CurRoundCount:~p, RoundCountThen:~p, BattleState:~w", [CurRoundCount, RoundCountThen, get_battle_state()]),
%%?ASSERT(is_server_waiting_clients(for_prepare_cmd_done), get_cur_battle_bhv()),  %% TODO：查原因：本地测试组队战斗的断线重连时，发现此断言有可能失败！ get_cur_battle_bhv()返回2
L = get_all_bo_id_list(),
F = fun(BoId) ->
Bo = get_bo_by_id(BoId),
case lib_bo:is_ready(Bo) of
true ->
skip;
false ->
%%?ERROR_MSG("prepare_cmd_timeout, BoId:~p, Bo:~w", [BoId, Bo]),
lib_bo:prepare_default_cmd(BoId)  % 未准备好的bo统一用默认指令
end
end,
lists:foreach(F, L),
?ASSERT(lib_bt_cmd:are_all_ready()),
lib_bt_cmd:schedule_round_action_begin()
end
end,
{noreply, _State};





%% 处理客户端通知播放战报完毕超时，以免卡住战斗流程
%% @para: RoundCountThen => 投递该消息当时的回合数
handle_info({'cli_notify_show_br_done_timeout', RoundCountThen}, _State)  ->
CurRoundCount = lib_bt_comm:get_cur_round(),
?ASSERT(CurRoundCount >= RoundCountThen),

case CurRoundCount > RoundCountThen of
true -> % 当前回合数大于当时的回合数，说明战斗没卡住，故不需做处理
?BT_LOG(io_lib:format("cli_notify_show_br_done_timeout, CurRoundCount(~p) > RoundCountThen(~p), so it is ok!~n", [CurRoundCount, RoundCountThen])),
skip;
false ->
% case are_all_show_battle_report_done() of
% 	false ->
?DEBUG_MSG("[mod_battle] cli_notify_show_br_done_timeout!!! CurRoundCount:~p, RoundCountThen:~p, BattleState:~w", [CurRoundCount, RoundCountThen, get_battle_state()]),
?ASSERT(is_server_waiting_clients(for_show_br_done), get_cur_battle_bhv()),
L = get_all_online_player_bo_id_list(),
F = fun(BoId) ->
Bo = get_bo_by_id(BoId),
case lib_bo:is_show_battle_report_done(Bo) of
true ->
skip;
false ->
%%?ERROR_MSG("cli_notify_show_br_done_timeout, BoId:~p, Bo:~w", [BoId, Bo]),
lib_bo:mark_show_battle_report_done(BoId)  % 强行标记为已播放战报完毕
end
end,
lists:foreach(F, L),
?ASSERT(are_all_show_battle_report_done()),
?DEBUG_MSG("handle_info, cli_notify_show_br_done_timeout and schedule_new_round_begin... cur_round:~p, battle_id:~p", [lib_bt_comm:get_cur_round(), lib_bt_comm:get_battle_id()]),
schedule_new_round_begin()

% 	true ->
% 		skip
% end
end,
{noreply, _State};




handle_info(_Msg, _State) ->
{noreply, _State}.




terminate(Reason, _State) ->
  ?TRY_CATCH(terminate__(Reason), ErrReason).






code_change(_OldVsn, State, _Extra)->
  {ok, State}.





post_battle_start_3v3_robot(PlayerId) ->
  lib_bt_plot:handle_plot(),  % 处理剧情战斗的剧情

  try_apply_sworn_eff(),


  apply_zf_eff_for_side_3v3_robot(?HOST_SIDE,PlayerId),
  apply_zf_eff_for_side_3v3_robot(?GUEST_SIDE,PlayerId),

  bo_prepare_cmd_by_AI(),

  decide_all_bo_cur_round_talk_AI(),

  lib_bt_send:notify_all_bo_cur_round_talk_AI(),

  BtlState = get_battle_state(),
  % 世界Boss战斗相关处理
  ?Ifc (lib_bt_comm:is_world_boss_mf_battle(BtlState))
  lib_bt_dict:record_world_boss_mf_info()
?End,
% 离线竞技场相关处理
?Ifc (lib_bt_comm:is_offline_arena_battle(BtlState))
% 客队属性加成 - 配置o2o战斗类型码为1
o2o_battle_guest_attribute_add(?O2O_BT_TYPE_OFFLINE_ARENA)
?End,
% 劫镖战斗相关处理
?Ifc (lib_bt_comm:is_hijack_battle(BtlState))
% 客队属性加成 - 配置o2o战斗类型码为2
o2o_battle_guest_attribute_add(?O2O_BT_TYPE_HIJACK)
?End,

?Ifc (lib_bt_comm:is_melee_battle(BtlState))
lib_bt_dict:record_melee_init_player_id_list(?HOST_SIDE),
lib_bt_dict:record_melee_init_player_id_list(?GUEST_SIDE)
?End,

init_tmp_rand_act_speed_for_all(),  % 初始化所有bo的乱敏

lib_bt_rela:init_intimacy_info_for_all_bo(), % 初始化好友度信息
lib_bt_rela:init_couple_info_for_all_bo(),   % 初始化配偶信息（包括夫妻技能）

% 预cast一个下达指令超时，以防止战斗卡住
Intv = ?MAX_WAIT_TIME_FOR_PREPARE_CMD_SEC * 1000 + 5000, % 允许5秒的延迟
erlang:send_after(Intv, self(), {'prepare_cmd_timeout', lib_bt_comm:get_cur_round()}).

post_battle_start_3v3(PlayerId,OppPlayerId) ->
  lib_bt_plot:handle_plot(),  % 处理剧情战斗的剧情

  try_apply_sworn_eff(),


  apply_zf_eff_for_side_3v3(?HOST_SIDE,PlayerId,OppPlayerId),
  apply_zf_eff_for_side_3v3(?GUEST_SIDE,PlayerId,OppPlayerId),

  bo_prepare_cmd_by_AI(),

  decide_all_bo_cur_round_talk_AI(),

  lib_bt_send:notify_all_bo_cur_round_talk_AI(),

  BtlState = get_battle_state(),
  % 世界Boss战斗相关处理
  ?Ifc (lib_bt_comm:is_world_boss_mf_battle(BtlState))
  lib_bt_dict:record_world_boss_mf_info()
?End,
% 离线竞技场相关处理
?Ifc (lib_bt_comm:is_offline_arena_battle(BtlState))
% 客队属性加成 - 配置o2o战斗类型码为1
o2o_battle_guest_attribute_add(?O2O_BT_TYPE_OFFLINE_ARENA)
?End,
% 劫镖战斗相关处理
?Ifc (lib_bt_comm:is_hijack_battle(BtlState))
% 客队属性加成 - 配置o2o战斗类型码为2
o2o_battle_guest_attribute_add(?O2O_BT_TYPE_HIJACK)
?End,

?Ifc (lib_bt_comm:is_melee_battle(BtlState))
lib_bt_dict:record_melee_init_player_id_list(?HOST_SIDE),
lib_bt_dict:record_melee_init_player_id_list(?GUEST_SIDE)
?End,

init_tmp_rand_act_speed_for_all(),  % 初始化所有bo的乱敏

lib_bt_rela:init_intimacy_info_for_all_bo(), % 初始化好友度信息
lib_bt_rela:init_couple_info_for_all_bo(),   % 初始化配偶信息（包括夫妻技能）

% 预cast一个下达指令超时，以防止战斗卡住
Intv = ?MAX_WAIT_TIME_FOR_PREPARE_CMD_SEC * 1000 + 5000, % 允许5秒的延迟
erlang:send_after(Intv, self(), {'prepare_cmd_timeout', lib_bt_comm:get_cur_round()}).

%% ===============================================================

post_battle_start() ->
  lib_bt_plot:handle_plot(),  % 处理剧情战斗的剧情

  try_apply_sworn_eff(),

  try_apply_zf_eff(),

  bo_prepare_cmd_by_AI(),

  decide_all_bo_cur_round_talk_AI(),

  lib_bt_send:notify_all_bo_cur_round_talk_AI(),

  BtlState = get_battle_state(),
  % 世界Boss战斗相关处理
  ?Ifc (lib_bt_comm:is_world_boss_mf_battle(BtlState))
  lib_bt_dict:record_world_boss_mf_info()
?End,
% 离线竞技场相关处理
?Ifc (lib_bt_comm:is_offline_arena_battle(BtlState))
% 客队属性加成 - 配置o2o战斗类型码为1
o2o_battle_guest_attribute_add(?O2O_BT_TYPE_OFFLINE_ARENA)
?End,
% 劫镖战斗相关处理
?Ifc (lib_bt_comm:is_hijack_battle(BtlState))
% 客队属性加成 - 配置o2o战斗类型码为2
o2o_battle_guest_attribute_add(?O2O_BT_TYPE_HIJACK)
?End,

?Ifc (lib_bt_comm:is_melee_battle(BtlState))
lib_bt_dict:record_melee_init_player_id_list(?HOST_SIDE),
lib_bt_dict:record_melee_init_player_id_list(?GUEST_SIDE)
?End,

init_tmp_rand_act_speed_for_all(),  % 初始化所有bo的乱敏

lib_bt_rela:init_intimacy_info_for_all_bo(), % 初始化好友度信息
lib_bt_rela:init_couple_info_for_all_bo(),   % 初始化配偶信息（包括夫妻技能）

%%处理回合开始时buff
BeginBuffFun =
fun(X) ->
BeEffList1 = lib_bo:find_passi_eff_by_name_all(get_bo_by_id(X), ?EN_ADD_BUFF_BEGIN_FRIEND_SURVIVAL),
AddBuffDetail = lib_bo_buff:trigger_passi_buff_begin_friend_survival(get_bo_by_id(X), 0, BeEffList1),
NotifyFun =
fun(X2) ->
BuffsAdded = X2#update_buffs_rule_dtl.atter_buffs_added,
NotifyDetailBuffFun =
fun(X3) ->
lib_bt_send:notify_bo_buff_added(get_bo_by_id(X2#update_buffs_rule_dtl.bo_id), X3)
end,
lists:foreach(NotifyDetailBuffFun, BuffsAdded)
end,

lists:foreach(NotifyFun, AddBuffDetail)

end,
lists:foreach(BeginBuffFun, get_all_bo_id_list() ),


BeginBuffFun2 =
fun(X) ->
BeEffList1 = lib_bo:find_passi_eff_by_name_all(get_bo_by_id(X), ?EN_ADD_BUFF_BEGIN_ENEMY_SURVIVAL),
AddBuffDetail = lib_bo_buff:trigger_passi_buff_begin_enemy_survival(get_bo_by_id(X), 0, BeEffList1),
NotifyFun =
fun(X2) ->
BuffsAdded = X2#update_buffs_rule_dtl.atter_buffs_added,
NotifyDetailBuffFun =
fun(X3) ->
lib_bt_send:notify_bo_buff_added(get_bo_by_id(X2#update_buffs_rule_dtl.bo_id), X3)
end,
lists:foreach(NotifyDetailBuffFun, BuffsAdded)
end,

lists:foreach(NotifyFun, AddBuffDetail)

end,
lists:foreach(BeginBuffFun2, get_all_bo_id_list() ),

% 预cast一个下达指令超时，以防止战斗卡住
Intv = ?MAX_WAIT_TIME_FOR_PREPARE_CMD_SEC * 1000 + 5000, % 允许5秒的延迟
erlang:send_after(Intv, self(), {'prepare_cmd_timeout', lib_bt_comm:get_cur_round()}).

%% 尝试应用结拜效果
try_apply_sworn_eff() ->
  try_apply_sworn_eff_for_side(?HOST_SIDE),
  State = get_battle_state(),
  case lib_bt_comm:is_mf_battle(State) of
    true ->
      skip;
    false ->
      try_apply_sworn_eff_for_side(?GUEST_SIDE)
  end.


try_apply_sworn_eff_for_side(Side) ->
  L = lib_bt_comm:get_player_bo_id_list_except_hired_player(Side),
  case length(L) =< 1 of
    true ->
      skip;
    false ->
      try_apply_sworn_eff_for_player_bos(L, L)
  end.

try_apply_sworn_eff_for_player_bos([], _L) ->
  done;
try_apply_sworn_eff_for_player_bos([CurBoId | T], L) ->
  try_apply_sworn_eff_for_one_player_bo(CurBoId, L),
  try_apply_sworn_eff_for_player_bos(T, L).

try_apply_sworn_eff_for_one_player_bo(BoId, L) ->
  Bo = get_bo_by_id(BoId),
  PlayerId = lib_bo:get_parent_obj_id(Bo),
  case ply_relation:get_sworn_id(PlayerId) of
    ?INVALID_ID ->
      skip;
    SwornId ->
      SwornType = lib_relation:get_sworn_type_by_id(SwornId),
      case SwornType of
        ?RELA_SWORN_TYPE_NONE ->
          ?ERROR_MSG("SwornType is none! PlayerId:~p, SwornId:~p", [PlayerId, SwornId]),
          % ?ASSERT(false, {PlayerId, SwornId}),
          skip;
        _ ->
          SrcPlayerIdList = [lib_bo:get_parent_obj_id( get_bo_by_id(X) ) || X <- L],
          OtherPlayerIdList = SrcPlayerIdList -- [PlayerId],
          OtherPlayerIdList_SameSworn = [X || X <- OtherPlayerIdList, ply_relation:get_sworn_id(X) == SwornId],
          case length(OtherPlayerIdList_SameSworn) of
            0 ->
              skip;
            Count ->
              SameSwornPlayerCount = Count + 1,

              SwornAddAttr = ply_relation:get_sworn_attr_add(SwornType, SameSwornPlayerCount),
              lib_bo:apply_sworn_add_attr(BoId, SwornAddAttr),

              BuffNo = get_dummy_buff_no_by_sworn_type_and_count(SwornType, SameSwornPlayerCount),
              ?ASSERT(BuffNo /= ?INVALID_NO, {PlayerId, SwornId, SwornType, SameSwornPlayerCount}),
              lib_bo:add_dummy_buff(BoId, BuffNo, ?PERMANENT_LASTING_ROUND),

              ?BT_LOG(io_lib:format("try_apply_sworn_eff_for_one_player_bo(), BoId:~p, PlayerId:~p, SwornId:~p, SwornType:~p, SameSwornPlayerCount:~p, SwornAddAttr:~w, BuffNo:~p, BoNewBuffList:~w~n",
                [BoId, PlayerId, SwornId, SwornType, SameSwornPlayerCount, SwornAddAttr, BuffNo, lib_bo:get_buff_list(get_bo_by_id(BoId))])),
              ok
          end
      end
  end.

%% 尝试应用阵法效果
try_apply_zf_eff() ->
  try_apply_zf_eff_for_side(?HOST_SIDE),
  try_apply_zf_eff_for_side(?GUEST_SIDE).


apply_zf_eff_for_side_3v3_robot(Side,PlayerId) ->
  L = lib_bt_comm:get_bo_id_list(Side),
  [RoomData] =  ets:lookup(?ETS_PVP_MATCH_ROOM, PlayerId),


  ZfNo =case  RoomData#match_room.cur_troop of
          0 ->
            ply_zf:get_common_zf();
          _ ->RoomData#match_room.cur_troop
        end,

  OppZfNo = case  RoomData#match_room.cur_troop of
              0 ->
                ply_zf:get_common_zf();
              _ ->RoomData#match_room.cur_troop
            end,
  ?DEBUG_MSG("mod_battle:try_apply_zf_eff_for_side,{ZfNo, OppZfNo}:~w~n", [{ZfNo, OppZfNo}]),
  try_apply_zf_eff_for_bos(L, ZfNo, OppZfNo),

  BtlState = get_battle_state(),
  NewBtlState =
    case Side of
      ?HOST_SIDE -> BtlState#btl_state{host_zf = ZfNo};
      ?GUEST_SIDE -> BtlState#btl_state{guest_zf = ZfNo}
    end,
  set_battle_state(NewBtlState).

apply_zf_eff_for_side_3v3(Side,PlayerId,OppPlayerId) ->
  L = lib_bt_comm:get_bo_id_list(Side),
  [RoomData] =  ets:lookup(?ETS_PVP_MATCH_ROOM, PlayerId),
  [RoomData2] =  ets:lookup(?ETS_PVP_MATCH_ROOM, OppPlayerId),



  ZfNo =case  RoomData#match_room.cur_troop of
          0 ->
            ply_zf:get_common_zf();
          _ ->RoomData#match_room.cur_troop
        end,

  OppZfNo = case  RoomData2#match_room.cur_troop of
              0 ->
                ply_zf:get_common_zf();
              _ ->RoomData2#match_room.cur_troop
            end,
  ?DEBUG_MSG("mod_battle:try_apply_zf_eff_for_side,{ZfNo, OppZfNo}:~w~n", [{ZfNo, OppZfNo}]),
  try_apply_zf_eff_for_bos(L, ZfNo, OppZfNo),

  BtlState = get_battle_state(),
  NewBtlState =
    case Side of
      ?HOST_SIDE -> BtlState#btl_state{host_zf = ZfNo};
      ?GUEST_SIDE -> BtlState#btl_state{guest_zf = OppZfNo}
    end,
  set_battle_state(NewBtlState).



try_apply_zf_eff_for_side(Side) ->
  L = lib_bt_comm:get_bo_id_list(Side),
  ZfNo = lib_bt_misc:get_zf_no_by_side(Side),
  OppSide = lib_bt_comm:to_enemy_side(Side),
  OppZfNo = lib_bt_misc:get_zf_no_by_side(OppSide),
  ?DEBUG_MSG("mod_battle:try_apply_zf_eff_for_side,{ZfNo, OppZfNo}:~w~n", [{ZfNo, OppZfNo}]),
  try_apply_zf_eff_for_bos(L, ZfNo, OppZfNo),

  BtlState = get_battle_state(),
  NewBtlState =
    case Side of
      ?HOST_SIDE -> BtlState#btl_state{host_zf = ZfNo};
      ?GUEST_SIDE -> BtlState#btl_state{guest_zf = ZfNo}
    end,
  set_battle_state(NewBtlState).


try_apply_zf_eff_for_bos([], _ZfNo, _OppZfNo) ->
  done;
try_apply_zf_eff_for_bos([CurBoId | T], ZfNo, OppZfNo) ->
  try_apply_zf_eff_for_one_bo(CurBoId, ZfNo, OppZfNo),
  try_apply_zf_eff_for_bos(T, ZfNo, OppZfNo).


try_apply_zf_eff_for_one_bo(BoId, ZfNo, OppZfNo) ->
  Bo = get_bo_by_id(BoId),
  Pos = lib_bt_misc:server_logic_pos_to_cfg_pos(lib_bo:get_pos(Bo)), % 注意：需对应转为策划所认为的站位,

  AddAttr = lib_team:get_zf_attr_add(ZfNo, OppZfNo, Pos),
  lib_bo:apply_zf_add_attr(BoId, AddAttr).


% init_magic_key_info_for_all_bo() ->
% 	init_magic_key_info_for_side(?HOST_SIDE),
% 	init_magic_key_info_for_side(?GUEST_SIDE).


% init_magic_key_info_for_side(Side) ->
%     case lib_bt_comm:get_living_player_bo_id_list(Side) of
%     	[] ->
%     		skip;
%     	L ->
%     		init_magic_key_info_for_bos(L)
%     end.

% init_magic_key_info_for_bos([]) ->
% 	done;
% init_magic_key_info_for_bos([BoId | T]) ->
% 	do_init_magic_key_info_for_one_bo(lib_bt_comm:get_bo_by_id(BoId)),
% 	init_magic_key_info_for_bos(T).

% %% 目前只初始化了怒气相关信息
% do_init_magic_key_info_for_one_bo(Bo) ->
% 	MyPlayerId = lib_bo:get_parent_obj_id(Bo),

% 	SkillList = ply_skill:get_magic_key_skill_list(MyPlayerId),

% 	?BT_LOG(io_lib:format("do_init_magic_key_info_for_one_bo(), BoId:~p, MyPlayerId:~p, SkillList:~p", [lib_bo:id(Bo), MyPlayerId, SkillList])),

% 	InitiativeSkillList = [X || X <- SkillList, mod_skill:is_initiative(X)],
% 	PassiSkillList      = [X || X <- SkillList, mod_skill:is_passive(X)],

% 	NewAttrs = Bo#battle_obj.attrs#attrs{anger = ?ANGER_INIT, anger_lim = ?ANGER_LIM},
% 	Bo2 = Bo#battle_obj{
% 				% 法宝技能附加到主动技能或被动技能列表中
% 				initiative_skill_list = Bo#battle_obj.initiative_skill_list ++ [lib_bt_skill:to_bo_skill_brief(X) || X <- InitiativeSkillList],
% 				passi_skill_list      = Bo#battle_obj.passi_skill_list ++ [lib_bt_skill:to_bo_skill_brief(X) || X <- PassiSkillList],
% 				attrs = NewAttrs
% 				},

% 	lib_bt_comm:update_bo(Bo2).


get_dummy_buff_no_by_sworn_type_and_count(Type, Count) ->
  case Type of
    ?RELA_SWORN_TYPE_COM ->
      case Count of
        2 -> 3502;
        3 -> 3503;
        4 -> 3504;
        5 -> 3505;
        _ -> ?INVALID_NO  % 容错
      end;
    ?RELA_SWORN_TYPE_HIGH ->
      case Count of
        2 -> 3512;
        3 -> 3513;
        4 -> 3514;
        5 -> 3515;
        _ -> ?INVALID_NO  % 容错
      end;
    _ ->  % 容错
      ?INVALID_NO
  end.



terminate__(Reason) ->
  ?TRACE("@@@@@@@@@@@ [mod_battle] terminate for reason:~w @@@@@@@@@~nbattle state:~w~n", [Reason, get_battle_state()]),

  State = get_battle_state(),
  ?TRACE("~nState in terminate(): ~p~n", [State]),

  % 如果非正常终止，则记录错误日志
  ?Ifc (Reason /= normal)
  ?ERROR_MSG("[mod_battle] !!!!!terminate for reason:~w~nbattle state:~w", [Reason, get_battle_state()])
  ?End,

  WinSide = State#btl_state.win_side,
  lib_bt_send:notify_battle_finish(WinSide),

  battle_feedback(to_players, State),
  battle_feedback(to_monster, State),

  % 保险起见，再次主动删一下战斗记录，避免数据残余
  BattleId = State#btl_state.id,
  ?TRACE("mod_battle:  terminate__(),  BattleId:~p~n", [BattleId]),
  mod_battle_mgr:del_battle_create_log(BattleId),
  ?ASSERT(mod_battle_mgr:get_battle_pid_by_id(BattleId) == null),

  ?TRACE("BTLogFileFd: ~w~n", [lib_bt_dict:get_battle_log_file_fd()]),

  _CloseBtLogFileRes = ?CLOSE_BT_LOG_FILE(),
  ?TRACE("_CloseBtLogFileRes: ~p~n", [_CloseBtLogFileRes]),
  ok.





%% 推导是为哪个bo而下指令？
derive_prepare_cmd_for_type(PlayerBo, ForBo) ->
  PlayerBoId = lib_bo:id(PlayerBo),
  ForBoId = lib_bo:id(ForBo),
  % 是否为玩家自己下指令？
  case ForBoId == PlayerBoId of
    true ->
      ?PREPARE_CMD_FOR_PLAYER_SELF;
    false ->
      % 是否为主宠下指令？
      case ForBoId == lib_bo:get_my_main_partner_bo_id(PlayerBo) of
        true ->
          ?PREPARE_CMD_FOR_MAIN_PARTNER;
        false ->
          % 是否为雇佣玩家下指令？
          case ForBoId == lib_bo:get_my_hired_player_bo_id(PlayerBo) of
            true ->
              ?PREPARE_CMD_FOR_HIRED_PLAYER;
            false ->
              % 是否为剧情bo下指令？
              case lib_bt_comm:is_plot_bo(ForBo)
                andalso lib_bo:can_be_ctrled(ForBo)
                andalso (lib_bo:get_side(ForBo) == lib_bo:get_side(PlayerBo)) of
                true ->
                  ?PREPARE_CMD_FOR_PLOT_BO;
                false ->
                  error
              end
          end
      end
  end.



%% 下达指令的通用检查
common_check_prepare_cmd(Bo) ->
  % 服务端当前是否正在等待客户端下指令？
  ?Ifc (not is_server_waiting_clients(for_prepare_cmd_done))
throw(?PC_FAIL_SERVER_NOT_WAITING_CLIENTS_FOR_PREPARE_CMD_DONE)
?End,

% 是否已经下过指令了？
?Ifc (lib_bo:is_cmd_prepared(Bo))
throw(?PC_FAIL_ALRDY_DONE)
?End.




check_prepare_cmd_NOP(Bo) ->
  ?ASSERT(is_player(Bo)
    orelse lib_bt_comm:is_main_partner(Bo)
    orelse lib_bo:can_be_ctrled(Bo), Bo),
  try
    check_prepare_cmd_NOP__(Bo)
  catch
    throw: FailReason ->
      {fail, FailReason}
  end.


check_prepare_cmd_NOP__(Bo) ->
  ?Ifc(not is_server_waiting_clients(for_prepare_cmd_done))
throw(?PC_FAIL_SERVER_NOT_WAITING_CLIENTS_FOR_PREPARE_CMD_DONE)
?End,

?Ifc (lib_bo:is_cmd_prepared(Bo))
throw(?PC_FAIL_ALRDY_DONE)
?End,

Bool1 = lib_bo:is_auto_battle(Bo),
Bool2 = lib_bo:cannot_act(Bo),
Bool3 = lib_bo:is_force_auto_attack(Bo),
Bool4 = is_dead(Bo),
?Ifc (not (Bool1 orelse Bool2 orelse Bool3 orelse Bool4))
?TRACE("Bool1, Bool2, Bool3, Bool4: ~p~n", [{Bool1, Bool2, Bool3, Bool4}]),
throw(?PC_FAIL_SHOULD_NOT_NOP)
?End,

ok.









check_prepare_cmd_normal_att(Bo, TargetBoId) ->
  ?ASSERT(is_player(Bo)
    orelse lib_bt_comm:is_main_partner(Bo)
    orelse lib_bo:can_be_ctrled(Bo), Bo),
  try
    check_prepare_cmd_normal_att__(Bo, TargetBoId)
  catch
    throw: FailReason ->
      {fail, FailReason}
  end.


check_prepare_cmd_normal_att__(Bo, _TargetBoId) ->
  common_check_prepare_cmd(Bo),

  % % 是否已经下过指令了？
  % ?Ifc (lib_bo:is_ready(Bo))
  % 	?ASSERT(false, Bo),
  % 	throw(?PM_UNKNOWN_ERR)
  % ?End,

  % % 目标bo是否存在？
  % ?Ifc (not is_bo_exists(TargetBoId))
  % 	throw(?PM_BT_TARGET_BO_NOT_EXISTS)
  % ?End,

  % % bo是否处于昏睡状态？
  % ?Ifc (lib_bo:is_trance(Bo))
  % 	throw(?PM_REQ_USE_SKL_FAIL_IS_TRANCE)
  % ?End,

  % case Type of
  % 	1 ->  % 玩家使用普通攻击
  % 		% 玩家是否死了？
  % 		% ?Ifc (is_dead(Bo))
  % 		% 	throw(?PM_BT_FAIL_FOR_ALRDY_DEAD)
  % 		% ?End;

  % 		ok;



  % 	2 ->  % 宠物使用普通攻击

  % 		% 宠物战斗对象是否存在？
  % 		FightingParId = player:get_fighting_partner_id(PS),

  % 		_ParBo = get_bo_by_partner_id(FightingParId),
  % 		?Ifc (not is_bo_exists(xxx))
  % 			?ASSERT(false),
  % 			throw(?PM_UNKNOWN_ERR)
  % 		?End

  % 		% % 宠物是否死了？
  % 		% ?Ifc (is_dead(ParBo))
  % 		% 	throw(?PM_BT_FAIL_FOR_ALRDY_DEAD)
  % 		% ?End
  % end,

  % 其他检测。。。
  % ...

  ok.




%% @return: ok | {fail, Reason}
check_prepare_cmd_use_skill(Bo, SkillId, TargetBoId) ->  %% rename to: prepare_cmd(use_skill, PS, SkillId) ??
  ?ASSERT(is_player(Bo)
    orelse lib_bt_comm:is_main_partner(Bo)
    orelse lib_bo:can_be_ctrled(Bo), Bo),
  ?ASSERT(mod_skill:is_valid_skill_id(SkillId), SkillId),
  try
    check_prepare_cmd_use_skill__(Bo, SkillId, TargetBoId)
  catch
    throw: FailReason ->
      {fail, FailReason}
  end.



check_prepare_cmd_use_skill__(Bo, SkillId, _TargetBoId) ->
  common_check_prepare_cmd(Bo),

  % % 是否已经下过指令了？
  % ?Ifc (lib_bo:is_ready(Bo))
  % 	?ASSERT(false, Bo),
  % 	throw(?PM_UNKNOWN_ERR)
  % ?End,


  % TODO： 有需要判断目标bo是否存在时，才判断，目前先注释掉，不判断！
  % % 目标bo是否存在？
  % ?Ifc (not is_bo_exists(TargetBoId))
  % 	throw(?PM_BT_TARGET_BO_NOT_EXISTS)
  % ?End,

  % % bo是否处于昏睡状态？
  % ?Ifc (lib_bo:is_trance(Bo))
  % 	throw(?PM_REQ_USE_SKL_FAIL_IS_TRANCE)
  % ?End,


  % 是否有该技能？
  ?Ifc (not lib_bo:has_initiative_skill(Bo, SkillId))
%%?ASSERT(false, {SkillId, Bo}),
throw(?PC_FAIL_HAS_NOT_SUCH_SKILL)
?End,

% case Type of
% 	?PLAYER_PREPARE_CMD ->  % 玩家使用技能
% 		% 玩家是否死了？
% 		% ?Ifc (is_dead(Bo))
% 		% 	throw(?PM_BT_FAIL_FOR_ALRDY_DEAD)
% 		% ?End,



% 		% % 是否满足技能的使用条件？ --- TODO： 改为在实际行动前才判断
% 		% case ply_skill:check_use_conditions(PS, SkillId) of
% 		% 	ok ->
% 		% 		skip;
% 		% 	{fail, Reason} ->
% 		% 		throw(Reason)
% 		% end;


% 	?MAIN_PARTNER_PREPARE_CMD ->  % 宠物使用技能

% 		% % 宠物战斗对象是否存在？
% 		% FightingParId = player:get_fighting_partner_id(PS),

% 		% ParBo = get_bo_by_partner_id(FightingParId),
% 		% ?Ifc (not is_bo_exists(FightingParId))
% 		% 	?ASSERT(false),
% 		% 	throw(?PM_UNKNOWN_ERR)
% 		% ?End
% 		skip

% 		% % 宠物是否死了？
% 		% ?Ifc (is_dead(ParBo))
% 		% 	throw(?PM_BT_FAIL_FOR_ALRDY_DEAD)
% 		% ?End
% end,

% TODO：Bo或宠物（依据Type）是否拥有对应的技能？  是否满足技能的使用条件？
% ...


% 其他检测。。。
% ...

ok.






%% @return: ok | {fail, Reason}
check_prepare_cmd_use_goods(Bo, Goods, TargetBoId, PlayerBoLv) ->
  ?ASSERT(is_player(Bo)
    orelse lib_bt_comm:is_main_partner(Bo)
    orelse lib_bo:can_be_ctrled(Bo), Bo),
  try
    check_prepare_cmd_use_goods__(Bo, Goods, TargetBoId, PlayerBoLv)
  catch
    throw: FailReason ->
      {fail, FailReason}
  end.


check_prepare_cmd_use_goods__(Bo, Goods, TargetBoId, PlayerBoLv) ->
  common_check_prepare_cmd(Bo),

  BtlState = get_battle_state(),

  ?Ifc (lib_bt_comm:is_offline_arena_battle(BtlState))
throw(?PC_FAIL_CANNOT_USE_GOODS_IN_OFFLINE_ARENA)
?End,

?Ifc (lib_bt_comm:is_hijack_battle(BtlState))
throw(?PC_FAIL_CANNOT_USE_GOODS_IN_HIJACK)
?End,

% 目标bo是否存在？
?Ifc (not is_bo_exists(TargetBoId))
throw(?PC_FAIL_TARGET_NOT_EXISTS)
?End,

% 等级是否够？
case PlayerBoLv >= lib_goods:get_lv(Goods) of
true -> skip;
false ->
throw(?PC_FAIL_LV_LIMIT_FOR_USE_GOODS)
end,

TargetBo = get_bo_by_id(TargetBoId),

% 检查物品所针对的阵营
MySide = lib_bo:get_side(Bo),
TargetBoSide = lib_bo:get_side(TargetBo),
case MySide == TargetBoSide of
true ->
case lib_goods:is_can_use_on_ally(Goods) of
true -> skip;
false ->
?ASSERT(false),
throw(?PC_FAIL_WRONG_CAMP_FOR_USE_GOODS)
end;
false ->
case lib_goods:is_can_use_on_enemy(Goods) of
true -> skip;
false ->
?ASSERT(false),
throw(?PC_FAIL_WRONG_CAMP_FOR_USE_GOODS)
end
end,

% 检查物品所针对的目标类型
TargetBoMainType = lib_bo:get_main_type(TargetBo),
case lib_goods:is_can_use_on_obj_type(Goods, TargetBoMainType) of
true -> skip;
false ->
?ASSERT(false, {TargetBoMainType, Goods}),
throw(?PC_FAIL_WRONG_TARGET_OBJ_TYPE_FOR_USE_GOODS)
end,

% TODO: 确认：需要判断目标bo是否处于昏睡，冰冻等控制状态？？
% ...

ok.


%% @return: ok | {fail, Reason}
check_prepare_cmd_capture(Bo, TarBoId) ->
  try
    check_prepare_cmd_capture__(Bo, TarBoId)
  catch
    throw: FailReason ->
      {fail, FailReason}
  end.


check_prepare_cmd_capture__(Bo, TarBoId) ->
  common_check_prepare_cmd(Bo),

  TarBo = get_bo_by_id(TarBoId),
  % 目标是否存在？
  ?Ifc (TarBo == null)
throw(?PC_FAIL_TARGET_NOT_EXISTS)
?End,

% 目标是否为自己？
?Ifc (TarBoId == lib_bo:id(Bo))
throw(?PC_FAIL_WRONG_PROTEGE)
?End,

ok.


%% @return: ok | {fail, Reason}
check_prepare_cmd_protect_others(Bo, TarBoId) ->
  try
    check_prepare_cmd_protect_others__(Bo, TarBoId)
  catch
    throw: FailReason ->
      {fail, FailReason}
  end.


check_prepare_cmd_protect_others__(Bo, TarBoId) ->
  common_check_prepare_cmd(Bo),

  TarBo = get_bo_by_id(TarBoId),
  % 目标是否存在？
  ?Ifc (TarBo == null)
throw(?PC_FAIL_TARGET_NOT_EXISTS)
?End,

% 目标是否为自己？
?Ifc (TarBoId == lib_bo:id(Bo))
throw(?PC_FAIL_WRONG_PROTEGE)
?End,

% 目标是否为盟友？
?Ifc (lib_bo:get_side(TarBo) /= lib_bo:get_side(Bo))
throw(?PC_FAIL_WRONG_PROTEGE)
?End,


% ?Ifc (is_dead(Bo))
% 	throw({fail, ?PM_BT_FAIL_FOR_ALRDY_DEAD})
% ?End,

% ?Ifc (lib_bo:is_ready(Bo))
% 	?ASSERT(false),
% 	throw({fail, ?PM_UNKNOWN_ERR})
% ?End,

% % 是否处于昏睡状态？
% ?Ifc (lib_bo:is_trance(Bo))
% 	throw({fail, ?PM_PROTECT_FAIL_IS_TRANCE})
% ?End,

% TarBo = get_bo_by_id(TarBoId),
% ?Ifc (is_dead(TarBo))
% 	throw({fail, ?PM_BT_TARGET_BO_ALRDY_DEAD})
% ?End,

ok.



check_prepare_cmd_escape(Bo) ->
  try
    check_prepare_cmd_escape__(Bo)
  catch
    throw: FailReason ->
      {fail, FailReason}
  end.

check_prepare_cmd_escape__(Bo) ->
  common_check_prepare_cmd(Bo),

  % ?Ifc (is_dead(Bo))
  % 	throw({fail, ?PM_BT_FAIL_FOR_ALRDY_DEAD})
  % ?End,

  % ?Ifc (lib_bo:is_ready(Bo))
  % 	?ASSERT(false),
  % 	throw({fail, ?PM_UNKNOWN_ERR})
  % ?End,

  ok.


check_prepare_cmd_defend(Bo) ->
  try
    check_prepare_cmd_defend__(Bo)
  catch
    throw: FailReason ->
      {fail, FailReason}
  end.

check_prepare_cmd_defend__(Bo) ->
  common_check_prepare_cmd(Bo),

  % ?Ifc (is_dead(Bo))
  % 	throw({fail, ?PM_BT_FAIL_FOR_ALRDY_DEAD})
  % ?End,
  ok.


%% @return: ok | {fail, Reason}
check_prepare_cmd_summon_partner(PS, Bo, TargetParId) ->
  ?ASSERT(is_player(Bo), Bo),
  try
    check_prepare_cmd_summon_partner__(PS, Bo, TargetParId)
  catch
    throw: FailReason ->
      {fail, FailReason}
  end.


check_prepare_cmd_summon_partner__(PS, Bo, TargetParId) ->
  common_check_prepare_cmd(Bo),

  State = get_battle_state(),

  ?Ifc (lib_bt_comm:is_offline_arena_battle(State))
throw(?PC_FAIL_CANNOT_SUMMON_PAR_IN_OFFLINE_ARENA)
?End,

?Ifc (lib_bt_comm:is_hijack_battle(State))
throw(?PC_FAIL_CANNOT_SUMMON_PAR_IN_HIJACK)
?End,

?Ifc (lib_bo:get_acc_summon_par_times(Bo) >= ?MAX_SUMMON_PARTNER_TIMES)
throw(?PC_FAIL_CANNOT_SUMMON_PAR_FOR_TIMES_LIMIT)
?End,

% 是否有这个宠物？
case is_hired_player(Bo) of
true ->
HiredPlyrId = lib_bo:get_parent_obj_id(Bo),
case mod_offline_data:get_offline_bo(HiredPlyrId, ?OBJ_PLAYER, ?SYS_HIRE) of
null ->
throw(?PC_FAIL_NO_SUCH_PARTNER);  % 离线玩家数据不存在，也统一返回PC_FAIL_NO_SUCH_PARTNER
OfflineHiredPlyr ->
OwnedParIdList = mod_offline_bo:get_partner_id_list(OfflineHiredPlyr),
?Ifc (not lists:member(TargetParId, OwnedParIdList))
throw(?PC_FAIL_NO_SUCH_PARTNER)
?End
end;
false ->
?Ifc (not player:has_partner(PS, TargetParId))
throw(?PC_FAIL_NO_SUCH_PARTNER)
?End
end,

% 宠物是否已经出战过了？
L = lib_bo:get_my_already_joined_battle_par_id_list(Bo),
?Ifc (lists:member(TargetParId, L))
throw(?PC_FAIL_PARTNER_ALRDY_JOINED_BATTLE)
?End,

ok.



check_req_prepare_cmd_by_AI(Bo) ->
  try
    check_req_prepare_cmd_by_AI__(Bo)
  catch
    throw: FailReason ->
      {fail, FailReason}
  end.

check_req_prepare_cmd_by_AI__(Bo) ->
  common_check_prepare_cmd(Bo),
  ok.



%% @return: ok | fail
init_try_add_teammate(MemberId, BattleId, Side) ->
  % 队员是否在线
  case player:is_online(MemberId) of
    true ->
      ?TRACE("mod_battle, member is online, MemberId=~p", [MemberId]),
      MemberPS = player:get_PS(MemberId),
      % 保险起见，再次判断是否空闲
      case (MemberPS /= null) andalso player:is_idle(MemberPS) of
        true ->
          player:mark_battling(MemberId, BattleId),
          ply_scene:notify_bhv_state_changed_to_aoi(MemberId, ?BHV_BATTLING),
          IsLeader = false,
          add_one_player(MemberPS, Side, IsLeader),
          ok;
        false ->
          fail
      end;
    false ->
      ?TRACE("mod_battle, member is NOT online, MemberId=~p", [MemberId]),
      % 尝试从离线缓存获取PS数据
      MemberPS = ply_tmplogout_cache:get_tmplogout_PS(MemberId),
      case MemberPS /= null of
        true ->
          % todo: 核查并确认：是否漏了什么处理？？
          IsLeader = false,
          IsHiredPlayer = false,
          add_one_offline_player(MemberPS, Side, IsLeader, IsHiredPlayer),
          ok;
        false ->
          fail
      end
  end.

%% @return: ok | fail
init_try_add_cross_teammate(MemberId, BattleId, Side) ->
  % 队员是否在线
  case player:is_online(MemberId) of
    true ->
      ?TRACE("mod_battle, member is online, MemberId=~p", [MemberId]),
      MemberPS = player:get_PS(MemberId),
      % 保险起见，再次判断是否空闲
      case (MemberPS /= null) andalso player:is_idle(MemberPS) of
        true ->
          player:mark_battling(MemberId, BattleId),
          ply_scene:notify_bhv_state_changed_to_aoi(MemberId, ?BHV_BATTLING),
          IsLeader = false,
          add_one_cross_player(MemberPS, Side, IsLeader),
          ok;
        false ->
          fail
      end;
    false ->
      ?TRACE("mod_battle, member is NOT online, MemberId=~p", [MemberId]),
      % 尝试从离线缓存获取PS数据
      MemberPS = ply_tmplogout_cache:get_tmplogout_PS(MemberId),
      case MemberPS /= null of
        true ->
          % todo: 核查并确认是否漏了什么处理？？
          IsLeader = false,
          IsHiredPlayer = false,
          add_one_offline_player(MemberPS, Side, IsLeader, IsHiredPlayer),
          ok;
        false ->
          fail
      end
  end.


%% @return: ok | fail
init_try_add_cross_robot_teammate(MemberId, BattleId, Side) ->
  % 队员是否在线
  case player:is_online(MemberId) of
    true ->
      ?TRACE("mod_battle, member is online, MemberId=~p", [MemberId]),
      MemberPS = player:get_PS(MemberId),
      % 保险起见，再次判断是否空闲
      case (MemberPS /= null) andalso player:is_idle(MemberPS) of
        true ->
          player:mark_battling(MemberId, BattleId),
          ply_scene:notify_bhv_state_changed_to_aoi(MemberId, ?BHV_BATTLING),
          IsLeader = false,
          add_one_cross_player(MemberPS, Side, IsLeader),
          ok;
        false ->
          fail
      end;
    false ->
      ?TRACE("mod_battle, member is NOT online, MemberId=~p", [MemberId]),
      % 尝试从离线缓存获取PS数据
      MemberPS = ply_tmplogout_cache:get_tmplogout_PS(MemberId),
      case MemberPS /= null of
        true ->
          % todo: 核查并确认：是否漏了什么处理？？
          IsLeader = false,
          IsHiredPlayer = false,
          add_one_offline_player(MemberPS, Side, IsLeader, IsHiredPlayer),
          ok;
        false ->

          case ets:lookup(ets_offline_bo, {MemberId, 1, 26})  of
            null -> ?ERROR_MSG("cross_3v3_match:matching_overtime mod_offline_data:get_offline_bo is null  error!~n", []),fail;
            [Bo] ->
              IsLeader = false,
              IsHiredPlayer = false,
              add_one_offline_player(Bo, Side, IsLeader, IsHiredPlayer),
              ok;
            [] -> ?ERROR_MSG("cross_3v3_match:matching_overtime mod_offline_data:get_offline_bo is null  error!~n", []),fail

          end
      end
  end.


init_add_players(for_mf, [PS, Side, BattleId, IsHireProhibited]) ->
  case player:is_in_team_and_not_tmp_leave(PS) of
    true ->
      % 处理组队的情况
      ?ASSERT(player:is_leader(PS), PS),
      LeaderId = player:id(PS),
      MemberIdList = mod_team:get_can_fight_member_id_list( player:get_team_id(PS)),

      ?TRACE("mod_battle, MemberIdList = ~p", [MemberIdList]),
      ?ASSERT(MemberIdList /= []),
      ?ASSERT(lists:member(LeaderId, MemberIdList)),

      F = fun(MemberId) ->
        case MemberId == LeaderId of
          true ->
            IsLeader = true,
            add_one_player(PS, Side, IsLeader);
          false ->
            init_try_add_teammate(MemberId, BattleId, Side)
        end
          end,
      lists:foreach(F, MemberIdList);
    false ->
      % 单人战斗， 固定当做是队长
      IsLeader = true,
      {ok, NewBoId} = add_one_player(PS, Side, IsLeader),

      ?Ifc (not IsHireProhibited)
init_try_add_hired_player(PS, Side, NewBoId)
?End
end;

init_add_players(for_offline_arena, [PS, Opponent]) ->
% 单人战斗， 固定当做是队长
IsLeader = true,
{ok, _NewBoId} = add_one_player(PS, ?HOST_SIDE, IsLeader),
%%%init_try_add_hired_player(PS, ?HOST_SIDE, NewBoId),

% 添加对手（玩家）
add_one_offline_arena_oppo_player(Opponent);


init_add_players(for_road_battle, [PS, Opponent]) ->
% 单人战斗， 固定当做是队长
Road = mod_road:get_road_from_ets(player:get_id(PS)),
IsLeader = true,
{ok, _NewBoId} = add_one_player(PS, ?HOST_SIDE, IsLeader),
NowPoint = Road#road_info.now_point,
Lv = player:get_lv(player:get_id(PS)),
% 添加对手（玩家）
add_one_battle_road_oppo_player(Opponent,NowPoint,Lv);


init_add_players(for_hijack, [PS, Opponent]) ->
% 单人战斗， 固定当做是队长
IsLeader = true,
{ok, _NewBoId} = add_one_player(PS, ?HOST_SIDE, IsLeader),

% 添加对手（玩家）
add_one_hijack_oppo_player(Opponent);

init_add_players(for_pk, [PS, OpponentPS, BattleId]) ->
init_add_one_side_players(for_pk, ?HOST_SIDE, PS, BattleId),
init_add_one_side_players(for_pk, ?GUEST_SIDE, OpponentPS, BattleId);

init_add_players(cross_3v3, [PS, OpponentPS, BattleId]) ->
init_add_one_side_players_cross(cross_3v3, ?HOST_SIDE, PS, BattleId),
init_add_one_side_players_cross(cross_3v3, ?GUEST_SIDE, OpponentPS, BattleId);

init_add_players(cross_3v3_robot, [PS, Opponent,BattleId]) ->
init_add_one_side_players_cross(cross_3v3_robot, ?HOST_SIDE, PS, BattleId ,player:get_id(PS)),
init_add_one_side_players_cross(cross_3v3_robot, ?GUEST_SIDE, Opponent, BattleId ,player:get_id(PS)).


init_add_one_side_players(for_pk, Side, PS, BattleId) ->
  case player:is_in_team_and_not_tmp_leave(PS) of
    true ->
      % 处理组队的情况
      % ?ASSERT(player:is_leader(PS), PS),
      LeaderId = player:id(PS),
      MemberIdList = mod_team:get_can_fight_member_id_list( player:get_team_id(PS)),

      ?TRACE("mod_battle, MemberIdList = ~p", [MemberIdList]),
      ?ASSERT(MemberIdList /= []),
      ?ASSERT(lists:member(LeaderId, MemberIdList)),

      F = fun(MemberId) ->
        case MemberId == LeaderId of
          true ->
            IsLeader = true,
            add_one_player(PS, Side, IsLeader),
            lib_bt_dict:add_to_pvp_player_id_list(MemberId, Side);
          false ->
            Res = init_try_add_teammate(MemberId, BattleId, Side),
            case Res of
              ok -> lib_bt_dict:add_to_pvp_player_id_list(MemberId, Side);
              fail -> skip
            end
        end
          end,
      lists:foreach(F, MemberIdList);
    false ->
      IsLeader = true,
      add_one_player(PS, Side, IsLeader),
      lib_bt_dict:add_to_pvp_player_id_list(player:id(PS), Side)
  end.



init_add_one_side_players_cross(cross_3v3_robot, Side, PS, BattleId, MatchPlayerId) ->
  % 处理组队的情况
  % ?ASSERT(player:is_leader(PS), PS),
  [MatchRoom] = ets:lookup(?ETS_PVP_MATCH_ROOM,  MatchPlayerId ),

  case Side of
    ?HOST_SIDE ->
      LeaderId = player:id(PS),

      MemberIdList =case MatchRoom#match_room.counters of
                      1 ->
                        [LeaderId, LeaderId + 10000000, LeaderId + 20000000];
                      2->  [PlayerData] = ets:lookup(?ETS_PVP_CROSS_PLAYER_DATA, LeaderId ),
                        Score = PlayerData#pvp_cross_player_data.score,

                        [Teammates] = MatchRoom#match_room.teammates,
                        [PlayerData2] = ets:lookup(?ETS_PVP_CROSS_PLAYER_DATA, Teammates ),
                        Score2 = PlayerData2#pvp_cross_player_data.score,
                        %匹配一个菜的队友当主队
                        case Score > Score2 of
                          true ->
                            [LeaderId, Teammates, LeaderId + 40000000];
                          false ->
                            [LeaderId, Teammates, LeaderId + 20000000]
                        end;
                      3 ->
                        Teammates = MatchRoom#match_room.teammates,
                        [LeaderId | Teammates]
                    end,
      ?TRACE("mod_battle, MemberIdList = ~p", [MemberIdList]),
      ?ASSERT(MemberIdList /= []),
      ?ASSERT(lists:member(LeaderId, MemberIdList)),
      io:format("wujiancheng test battle ~p ~n", [MemberIdList]),

      F = fun(MemberId) ->
        case MemberId == LeaderId of
          true ->
            IsLeader = true,
            add_one_cross_player(PS, Side, IsLeader),
            lib_bt_dict:add_to_pvp_player_id_list(MemberId, Side);
          false ->
            Res = init_try_add_cross_robot_teammate(MemberId, BattleId, Side),
            case Res of
              ok -> lib_bt_dict:add_to_pvp_player_id_list(MemberId, Side);
              fail -> skip
            end
        end
          end,
      lists:foreach(F, MemberIdList);
    ?GUEST_SIDE ->

      {LeaderId, _, _} = PS#offline_bo.key,
      MemberIdList = case MatchRoom#match_room.counters of
                       1 ->
                         [LeaderId, LeaderId + 10000000, LeaderId + 20000000];
                       2 ->
                         [PlayerData] = ets:lookup(?ETS_PVP_CROSS_PLAYER_DATA, MatchPlayerId ),
                         Score = PlayerData#pvp_cross_player_data.score,

                         [Teammates] = MatchRoom#match_room.teammates,
                         [PlayerData2] = ets:lookup(?ETS_PVP_CROSS_PLAYER_DATA, Teammates ),
                         Score2 = PlayerData2#pvp_cross_player_data.score,
                         %匹配一个菜的队友当主队
                         case Score > Score2 of
                           true ->
                             [LeaderId, LeaderId - 10000000, LeaderId - 20000000];
                           false ->
                             [LeaderId, LeaderId + 10000000, LeaderId - 20000000]
                         end;
                       3 ->
                         [LeaderId, LeaderId - 10000000, LeaderId - 20000000]
                     end,

      F = fun(MemberId) ->
        case MemberId ==LeaderId of
          true ->
            IsLeader = true,
            add_one_cross_robot_player(PS, Side, IsLeader),
            lib_bt_dict:add_to_pvp_player_id_list(MemberId, Side);
          false ->
            Res = init_try_add_cross_robot_teammate(MemberId, BattleId, Side),
            case Res of
              ok -> lib_bt_dict:add_to_pvp_player_id_list(MemberId, Side);
              fail -> skip
            end
        end
          end,
      lists:foreach(F, MemberIdList)
  end.

init_add_one_side_players_cross(cross_3v3, Side, PS, BattleId) ->

  % 处理组队的情况
  % ?ASSERT(player:is_leader(PS), PS),
  LeaderId = player:id(PS),
  [MatchRoom] = ets:lookup(?ETS_PVP_MATCH_ROOM, LeaderId),
  MemberIdList = MatchRoom#match_room.teammates ++ [LeaderId]  ,

  ?TRACE("mod_battle, MemberIdList = ~p", [MemberIdList]),
  ?ASSERT(MemberIdList /= []),
  ?ASSERT(lists:member(LeaderId, MemberIdList)),
  io:format("wujiancheng test battle ~p ~n", [MemberIdList]),

  F = fun(MemberId) ->
    case MemberId == LeaderId of
      true ->
        IsLeader = true,
        add_one_cross_player(PS, Side, IsLeader),
        lib_bt_dict:add_to_pvp_player_id_list(MemberId, Side);
      false ->
        Res = init_try_add_cross_teammate(MemberId, BattleId, Side),
        case Res of
          ok -> lib_bt_dict:add_to_pvp_player_id_list(MemberId, Side);
          fail -> skip
        end
    end
      end,
  lists:foreach(F, MemberIdList).








%% 尝试添加雇佣玩家到战场
init_try_add_hired_player(PS, Side, PlayerBoId) ->
  % 是否有雇佣玩家？
  case ply_hire:has_fighting_hired_player(PS) of
    true ->
      HiredPlayerId = ply_hire:get_fighting_hired_player_id(PS),
      case mod_offline_data:get_offline_bo(HiredPlayerId, ?OBJ_PLAYER, ?SYS_HIRE) of
        null ->
          ?ASSERT(false, {HiredPlayerId, PS}),
          ?ERROR_MSG("[mod_battle] init_try_add_hired_player() error!!! HiredPlayerId=~p, PS=~w", [HiredPlayerId, PS]),
          skip;
        OfflineBo ->
          add_one_hired_player(OfflineBo, Side, PlayerBoId)
      end;
    false ->
      ?BT_LOG(io_lib:format("init_try_add_hired_player(), No fighting hired player!!~n", [])),
      skip
  end.


% PlayerId = player:id(PS),
init_add_partners(for_mf, [PS, Side]) ->

  ?BT_LOG(io_lib:format("init_add_partners(),  PlayerId: ~p~n", [player:id(PS)])),

  % TODO: 此处代码稍乱，考虑重构下
  PlayerCount = case player:is_in_team_and_not_tmp_leave(PS) of
                  true ->
%%                    __MemberIdList = mod_team:get_can_fight_member_id_list( player:get_team_id(PS)),
%%                    length(__MemberIdList);
                      2;  %%应策划要求，只要是组队就是多人的
                  false ->
                    1
                end,

  case PlayerCount > 1 of %%player:is_in_team(PS) of
    true -> % 多人组队打怪
      % ?ASSERT(player:is_leader(PS), PS),
      MemberIdList = mod_team:get_can_fight_member_id_list( player:get_team_id(PS)),

      ?BT_LOG(io_lib:format("mod_battle, MemberIdList = ~p~n", [MemberIdList])),
      ?ASSERT(MemberIdList /= []),
      ?ASSERT(lists:member( player:id(PS), MemberIdList)),

      F = fun(MemberId) ->
        init_try_add_main_partner_of_player(MemberId, Side)
          end,
      lists:foreach(F, MemberIdList),

      % 如果还有空位，则尝试让更多的出战宠物上场
      init_try_add_more_partners(PS, Side);

    false -> % 单人打怪

      % 先尝试添加雇佣玩家的宠物
      init_try_add_hired_partners(PS, Side),

      % 所有出战宠物都尝试上场
      init_try_add_all_my_partners(PS, Side)
  end;


%% init_add_partners(for_battle_road, [PS, Opponent]) ->
%% 	% PlayerId = player:id(PS),
%%
%% 	?BT_LOG(io_lib:format("init_add_partners(for_battle_road, ..),  PlayerId: ~p~n", [player:id(PS)])),
%%
%% 	% 先尝试添加雇佣玩家的宠物
%% 	%%%init_try_add_hired_partners(PS, ?HOST_SIDE),
%%
%% 	% 所有参战宠物都尝试上场
%% 	init_try_add_all_my_partners_for_road(PS, ?HOST_SIDE),
%%
%% 	% 最后，尝试添加对手的宠物
%% 	init_try_add_battle_road_oppo_partners(PS,Opponent);


init_add_partners(for_offline_arena, [PS, Opponent]) ->
  % PlayerId = player:id(PS),

  ?BT_LOG(io_lib:format("init_add_partners(for_offline_arena, ..),  PlayerId: ~p~n", [player:id(PS)])),

  % 先尝试添加雇佣玩家的宠物
  %%%init_try_add_hired_partners(PS, ?HOST_SIDE),

  % 所有参战宠物都尝试上场
  init_try_add_all_my_partners(PS, ?HOST_SIDE),

  % 最后，尝试添加对手的宠物
  init_try_add_offline_arena_oppo_partners(Opponent);


%取经之路
init_add_partners(for_road_battle, [PS, Opponent]) ->
  % PlayerId = player:id(PS),
  Road = mod_road:get_road_from_ets(player:get_id(PS)),
  OpponentInfo = Road#road_info.pk_info,
  NowPoint = Road#road_info.now_point,
  Lv = player:get_lv(player:get_id(PS)),

  NowOpponent = lists:sublist(OpponentInfo, NowPoint, 1),
  %{PlayerId,Name,Faction,Lv,Sex,FivePartner}
  [{_Opponentd,_OpponentName,_Faction,_OpponentLv,_OpponentSex,ParInfoLists}] = NowOpponent,
  %{PartnerId,Hp,Mp,Hp,Mp,IsMain}
  ?BT_LOG(io_lib:format("init_add_partners(for_offline_arena, ..),  PlayerId: ~p~n", [player:id(PS)])),

  % 先尝试添加雇佣玩家的宠物
  %%%init_try_add_hired_partners(PS, ?HOST_SIDE),

  % 所有参战宠物都尝试上场
  init_try_add_all_my_partners_for_road(PS, ?HOST_SIDE),

  % 最后，尝试添加对手的宠物
  init_try_add_battle_road_oppo_partners(Opponent,ParInfoLists,NowPoint,Lv);






init_add_partners(for_hijack, [PS, Opponent]) ->
  % PlayerId = player:id(PS),

  ?BT_LOG(io_lib:format("init_add_partners(for_hijack, ..),  PlayerId: ~p~n", [player:id(PS)])),

  % 所有参战宠物都尝试上场
  init_try_add_all_my_partners(PS, ?HOST_SIDE),

  % 最后，尝试添加对手的宠物
  init_try_add_hijack_oppo_partners(Opponent);



init_add_partners(for_pk, [PS, OpponentPS]) ->
  %%% init_try_add_all_my_partners(PS, ?HOST_SIDE),
  %%% init_try_add_all_my_partners(OpponentPS, ?GUEST_SIDE).
  init_add_one_side_partners(for_pk, ?HOST_SIDE, PS),
  init_add_one_side_partners(for_pk, ?GUEST_SIDE, OpponentPS);

init_add_partners(cross_3v3_robot, [PS, OpponentPS]) ->
  %%% init_try_add_all_my_partners(PS, ?HOST_SIDE),
  %%% init_try_add_all_my_partners(OpponentPS, ?GUEST_SIDE).
  init_add_one_side_partners_cross(for_cross_robot, ?HOST_SIDE, PS),
  init_add_one_side_partners_cross(for_cross_robot_offline, ?GUEST_SIDE, OpponentPS,player:get_id(PS));



init_add_partners(cross_3v3, [PS, OpponentPS]) ->
  %%% init_try_add_all_my_partners(PS, ?HOST_SIDE),
  %%% init_try_add_all_my_partners(OpponentPS, ?GUEST_SIDE).
  init_add_one_side_partners_cross(for_cross, ?HOST_SIDE, PS),
  init_add_one_side_partners_cross(for_cross, ?GUEST_SIDE, OpponentPS).

init_add_one_side_partners_cross(for_cross_robot, Side, PS) ->
  PlayerId = player:get_id(PS),
  [MatchRoom] = ets:lookup(?ETS_PVP_MATCH_ROOM, PlayerId),
  MemberIdList =
    case MatchRoom#match_room.counters of
      1 ->
        [PlayerId + 10000000,PlayerId + 20000000];
      2 ->
        [PlayerData] = ets:lookup(?ETS_PVP_CROSS_PLAYER_DATA, PlayerId),
        Score = PlayerData#pvp_cross_player_data.score,
        [Teammates] = MatchRoom#match_room.teammates,
        [PlayerData2] = ets:lookup(?ETS_PVP_CROSS_PLAYER_DATA, Teammates),
        Score2 = PlayerData2#pvp_cross_player_data.score,
        init_try_add_main_partner_of_player(Teammates, Side),
        case Score > Score2 of
          true ->
            [PlayerId + 40000000];
          false ->
            [PlayerId + 20000000]
        end;
      3 ->
        [Teammates1,Teammates2] = MatchRoom#match_room.teammates,
        init_try_add_main_partner_of_player(Teammates1, Side),
        init_try_add_main_partner_of_player(Teammates2, Side),
        []
    end,


  ?BT_LOG(io_lib:format("mod_battle, init_add_one_side_partners(), MemberIdList = ~p~n", [MemberIdList])),
  init_try_add_main_partner_of_player(PlayerId, Side),
  F = fun(MemberId) ->
    init_try_add_main_partner_of_player_robot(MemberId, Side)
      end,
  lists:foreach(F, MemberIdList),

  % 如果还有空位，则尝试让更多的出战宠物上场
  skip;



init_add_one_side_partners_cross(for_cross, Side, PS) ->

  [MatchRoom] = ets:lookup(?ETS_PVP_MATCH_ROOM, player:get_id(PS) ),
  MemberIdList = MatchRoom#match_room.teammates ++ [ player:get_id(PS)],

  ?BT_LOG(io_lib:format("mod_battle, init_add_one_side_partners(), MemberIdList = ~p~n", [MemberIdList])),
  ?ASSERT(MemberIdList /= []),
  ?ASSERT(lists:member( player:id(PS), MemberIdList)),

  F = fun(MemberId) ->
    init_try_add_main_partner_of_player(MemberId, Side)
      end,
  lists:foreach(F, MemberIdList),

  % 如果还有空位，则尝试让更多的出战宠物上场
  skip.


init_add_one_side_partners_cross(for_cross_robot_offline, Side, OfflineBo,HostPlayerId) ->
  {PlayerId, _ ,_ } = OfflineBo#offline_bo.key,
  [MatchRoom] = ets:lookup(?ETS_PVP_MATCH_ROOM, HostPlayerId),
  MemberIdList =
    case MatchRoom#match_room.counters of
      1 ->
        [ PlayerId, PlayerId + 10000000,PlayerId + 20000000];
      2 ->
        [PlayerData] = ets:lookup(?ETS_PVP_CROSS_PLAYER_DATA, HostPlayerId),
        Score = PlayerData#pvp_cross_player_data.score,
        [Teammates] = MatchRoom#match_room.teammates,
        [PlayerData2] = ets:lookup(?ETS_PVP_CROSS_PLAYER_DATA, Teammates),
        Score2 = PlayerData2#pvp_cross_player_data.score,
        case Score > Score2 of
          true ->
            [PlayerId, PlayerId - 10000000 , PlayerId - 20000000 ];
          false ->
            [PlayerId, PlayerId - 20000000 , PlayerId + 10000000 ]
        end;
      3 ->
        [PlayerId, PlayerId - 10000000,PlayerId - 20000000]
    end,



  ?BT_LOG(io_lib:format("mod_battle, init_add_one_side_partners(), MemberIdList = ~p~n", [MemberIdList])),

  F = fun(MemberId) ->
    init_try_add_main_partner_of_player_robot(MemberId, Side)
      end,
  lists:foreach(F, MemberIdList),

  % 如果还有空位，则尝试让更多的出战宠物上场
  skip.



init_add_one_side_partners(for_pk, Side, PS) ->
  PlayerCount = case player:is_in_team_and_not_tmp_leave(PS) of
                  true ->
                    2;
                  false ->
                    1
                end,

  case PlayerCount > 1 of
    true -> % 多人组队
      MemberIdList = mod_team:get_can_fight_member_id_list( player:get_team_id(PS)),

      ?BT_LOG(io_lib:format("mod_battle, init_add_one_side_partners(), MemberIdList = ~p~n", [MemberIdList])),
      ?ASSERT(MemberIdList /= []),
      ?ASSERT(lists:member( player:id(PS), MemberIdList)),

      F = fun(MemberId) ->
        init_try_add_main_partner_of_player(MemberId, Side)
          end,
      lists:foreach(F, MemberIdList);

%%      % 如果还有空位，则尝试让更多的出战宠物上场
%%      init_try_add_more_partners(PS, Side);

    false -> % 非组队或单人组队

      % 所有出战宠物都尝试上场
      init_try_add_all_my_partners(PS, Side)
  end.


%% 尝试添加玩家的主宠
init_try_add_main_partner_of_player(PlayerId, Side) ->
  PlayerBo = get_bo_by_player_id(PlayerId),
  case player:is_online(PlayerId)
    andalso (PlayerBo /= null) of  % 对应的玩家需要已经加到战场，其宠物才会也加到战场，故稳妥起见，判断PlayerBo是否为null
    true ->
      ?BT_LOG(io_lib:format("mod_battle, init_try_add_main_partner_of_player(), player is online, PlayerId=~p~n", [PlayerId])),
      PS = player:get_PS(PlayerId),
      case mod_partner:get_main_partner_obj(PlayerId) of
        null ->
          skip;
        MainParObj ->
          case lib_partner:is_fighting(MainParObj) of
            false ->
              skip;
            true ->
              case lib_partner:can_goto_fight_once(MainParObj) of
                true ->
                  add_one_partner(PS, MainParObj, Side);
                false ->
                  ?BT_LOG(io_lib:format("Main Partner cannot goto fight! MainParObj:~w~n", [MainParObj])),
                  skip  %%delay_notify_par_cannot_goto_fight(PlayerId, lib_partner:get_id(MainParObj))
              end
          end
      end;
    false ->
      ?BT_LOG(io_lib:format("mod_battle, init_try_add_main_partner_of_player(), player is NOT online or PlayerBo==null, PlayerId=~p~n", [PlayerId])),
      skip
  end.


%% 尝试添加玩家的主宠
init_try_add_main_partner_of_player_robot(PlayerId, Side) ->
  PlayerBo = get_bo_by_player_id(PlayerId),
  case (PlayerBo /= null) of  % 对应的玩家需要已经加到战场，其宠物才会也加到战场，故稳妥起见，判断PlayerBo是否为null
    true ->
      [PlayerOffline] = ets:lookup(ets_offline_bo,{PlayerId , 1, 26} ),
      [PartnerId] = PlayerOffline#offline_bo.partners,
      PartnerOffline = lib_partner:get_partner(PartnerId),
      ?BT_LOG(io_lib:format("mod_battle, init_try_add_main_partner_of_player(), player is online, PlayerId=~p~n", [PlayerId])),
      case PartnerOffline of
        null ->
          skip;
        MainParObj ->
          case lib_partner:is_fighting(MainParObj) of
            false ->
              skip;
            true ->
              case lib_partner:can_goto_fight_once(MainParObj) of
                true ->
                  add_one_partner_for_cross_robot(PlayerId, MainParObj, Side);
                false ->
                  ?BT_LOG(io_lib:format("Main Partner cannot goto fight! MainParObj:~w~n", [MainParObj])),
                  skip  %%delay_notify_par_cannot_goto_fight(PlayerId, lib_partner:get_id(MainParObj))
              end
          end
      end;
    false ->
      ?BT_LOG(io_lib:format("mod_battle, init_try_add_main_partner_of_player(), player is NOT online or PlayerBo==null, PlayerId=~p~n", [PlayerId])),
      skip
  end.



%% 如果还有空位，则尝试让更多的出战宠物上场
init_try_add_more_partners(_PS, Side) ->
  EmptyPosL = [X || X <- ?BATTLE_POS_ORDER_FOR_PARTNER, lib_bt_comm:is_pos_empty(Side, X)],
  case EmptyPosL of
    [] ->
      skip;
    _ ->
      []
  %%改为了组队战斗则只出战主宠 2019.10.15
%%      FightingParL = mod_partner:get_fighting_partner_list(PS),
%%      FightingDeputyParL = [X || X <- FightingParL, not lib_partner:is_main_partner(X)],
%%      case FightingDeputyParL of
%%        [] ->
%%          skip;
%%        _ ->
%%          FightingDeputyParL2 = sort_partner_by_battle_power_desc(FightingDeputyParL),
%%          EmptyPosCount = length(EmptyPosL),
%%          FightingDeputyParL3 = lists:sublist(FightingDeputyParL2, EmptyPosCount),
%%          ?BT_LOG(io_lib:format("init_try_add_more_partners(), FightingDeputyParL2:~w, EmptyPosCount:~p, FightingDeputyParL3:~w~n", [FightingDeputyParL2, EmptyPosCount, FightingDeputyParL3])),
%%
%%          F = fun(ParObj) ->
%%            add_one_partner(PS, ParObj, Side)
%%              end,
%%
%%          lists:foreach(F, FightingDeputyParL3)
%%      end
  end.


%% 按战力降序排序宠物
sort_partner_by_battle_power_desc(ParObjL) ->
  F = fun(A, B) ->
    lib_partner:get_battle_power(A) > lib_partner:get_battle_power(B)
      end,
  lists:sort(F, ParObjL).








% delay_notify_par_cannot_goto_fight(OwnerPlayerId, PartnerId) ->
% 	gen_server:cast( self(), {'notify_par_cannot_goto_fight', OwnerPlayerId, PartnerId}).



%% 玩家的所有参战宠物都尝试上场
init_try_add_all_my_partners(PS, Side) when is_record(PS, player_status) ->
  ParObjList = mod_partner:get_fighting_partner_list(PS),
  ?BT_LOG(io_lib:format("init_try_add_all_my_partners(PS, ..),  ParObjList: ~w~n", [ParObjList])),
  F = fun(ParObj) ->
    case lib_partner:can_goto_fight_once(ParObj) of
      true ->
        add_one_partner(PS, ParObj, Side);
      false ->
        ?BT_LOG(io_lib:format("Partner cannot goto fight! ParObj:~w~n", [ParObj])),
        skip %%delay_notify_par_cannot_goto_fight( player:id(PS), lib_partner:get_id(ParObj))
    end
      end,
  lists:foreach(F, ParObjList).


%%取经之路特殊处理
init_try_add_all_my_partners_for_road(PS, Side) when is_record(PS, player_status) ->
  RoadData = mod_road:get_road_from_ets(player:get_id(PS)),
  ParInfo0 = RoadData#road_info.now_battle_partner, %PartnerId,Hp,Mp,Hp,Mp,IsMain
  ParInfo = lists:keydelete(0, 2, ParInfo0),
  ParObjList = [{X,IsMain}|| {X,_Hp,_Mp,_MaxHp,_MaxMp,IsMain} <- ParInfo],
  ?BT_LOG(io_lib:format("init_try_add_all_my_partners(PS, ..),  ParObjList: ~w~n", [ParObjList])),
  F = fun({ParObj,IsMain}) ->
    case lib_partner:can_goto_fight_once(ParObj) of
      true ->
        Partner = lib_partner:get_partner(ParObj),
        add_one_partner_for_road(PS, Partner,IsMain, Side);
      false ->
        ?BT_LOG(io_lib:format("Partner cannot goto fight! ParObj:~w~n", [ParObj])),
        skip %%delay_notify_par_cannot_goto_fight( player:id(PS), lib_partner:get_id(ParObj))
    end
      end,
  lists:foreach(F, ParObjList).


%% 离线玩家（比如竞技场的离线对手）的所有参战宠物都尝试上场
init_try_add_all_my_partners_for_road(PS,OfflinePlyr, Side, SysType) when is_record(OfflinePlyr, offline_bo) ->
  ?ASSERT(mod_offline_bo:is_player(OfflinePlyr)),
  PlayerId = mod_offline_bo:get_id(OfflinePlyr),
  ParIdList = mod_offline_bo:get_partner_id_list(OfflinePlyr),
  ?BT_LOG(io_lib:format("init_try_add_all_my_partners(OfflinePlyr, ..),  ParIdList: ~w~n", [ParIdList])),

%% 	ParIdList = mod_offline_bo:get_partner_id_list(OfflinePlyr),
%% 	RoadData = mod_road:get_road_from_ets(player:get_id(PS)),
%% 	PkerData = RoadData#road_info.pk_info,
%% 	NowPoint = RoadData#road_info.now_point,
%% 	OpponentInfo =
%% 		case length(PkerData) >= NowPoint of
%% 			true -> lists:sublist(PkerData, NowPoint, 1);
%% 			false -> ?ASSERT(false,NowPoint)
%% 		end,
%% 	[TargetId,_PlayerName,_Faction,_PlayerLv,_Sex,FivePartner] =OpponentInfo,
  %  ParIdList = [PartnerId || {PartnerId,_Hp,_Mp,_MaxHp,_MaxMp,_IsMain} <- FivePartner ],

  F = fun(ParId) ->
    case mod_offline_data:get_offline_bo(ParId, ?OBJ_PARTNER, SysType) of
      null ->
        ?ASSERT(false, {ParId, SysType, OfflinePlyr}),
        skip;
      OfflinePar ->add_one_offline_partner(OfflinePar, Side, PlayerId)
    end
      end,
  lists:foreach(F, ParIdList).


%% 离线玩家（比如竞技场的离线对手）的所有参战宠物都尝试上场
init_try_add_all_my_partners(OfflinePlyr, Side, SysType) when is_record(OfflinePlyr, offline_bo) ->
  ?ASSERT(mod_offline_bo:is_player(OfflinePlyr)),
  PlayerId = mod_offline_bo:get_id(OfflinePlyr),
  ParIdList = mod_offline_bo:get_partner_id_list(OfflinePlyr),
  ?BT_LOG(io_lib:format("init_try_add_all_my_partners(OfflinePlyr, ..),  ParIdList: ~w~n", [ParIdList])),

  F = fun(ParId) ->
    case mod_offline_data:get_offline_bo(ParId, ?OBJ_PARTNER, SysType) of
      null ->
        ?ASSERT(false, {ParId, SysType, OfflinePlyr}),
        skip;
      OfflinePar ->
        case mod_offline_bo:is_par_fighting(OfflinePar)
          andalso mod_offline_bo:can_par_goto_fight_once(OfflinePar)  of
          true -> add_one_offline_partner(OfflinePar, Side, PlayerId);
          false -> ?BT_LOG(io_lib:format("Partner cannot goto fight! OfflinePar:~w~n", [OfflinePar])), skip
        end
    end
      end,
  lists:foreach(F, ParIdList).

%% 离线玩家（比如竞技场的离线对手）的所有参战宠物都尝试上场
init_try_add_all_my_partners_qujing(OfflinePlyr, Side, SysType,ParInfoLists,NowPoint,Lv) when is_record(OfflinePlyr, offline_bo) ->
  ?ASSERT(mod_offline_bo:is_player(OfflinePlyr)),
  PlayerId = mod_offline_bo:get_id(OfflinePlyr),
  %{PartnerId,Hp,Mp,Hp,Mp,IsMain}
  F2 = fun(X2,Acc2) ->
    {_PartnerId,Hp,_Mp,_MHp,_MMp,_IsMain} = X2,
    case Hp =:= 0 of
      true -> Acc2;
      false -> [X2|Acc2]
    end
       end,
  UseParInfo = lists:foldl(F2, [], ParInfoLists),
  %ParIdList = mod_offline_bo:get_partner_id_list(OfflinePlyr),
  ?BT_LOG(io_lib:format("init_try_add_all_my_partners(OfflinePlyr, ..),  ParIdList: ~w~n", [ParIdList])),

  F = fun({ParId,TrueHp,TrueMp,MaxHp,MaxMp,TrueIsMain}) ->
    case mod_offline_data:get_offline_bo(ParId, ?OBJ_PARTNER, SysType) of
      null ->
        ?ASSERT(false, {ParId, SysType, OfflinePlyr}),
        skip;
      OfflinePar ->
        case  mod_offline_bo:can_par_goto_fight_once(OfflinePar)  of
          true -> add_one_offline_partner_qujing(OfflinePar, Side, PlayerId, TrueHp,TrueMp,MaxHp,MaxMp,TrueIsMain,NowPoint,Lv);
          false -> ?BT_LOG(io_lib:format("Partner cannot goto fight! OfflinePar:~w~n", [OfflinePar])), skip
        end
    end
      end,
  lists:foreach(F, UseParInfo).



add_one_par_and_force_mark_offline(ParObj, OwnerPS) ->
  case lib_partner:can_goto_fight_once(ParObj) of
    true ->
      case add_one_partner(OwnerPS, ParObj, ?GUEST_SIDE) of
        {ok, NewParBoId} ->
          lib_bo:set_online(NewParBoId, false);  % 勿忘：统一调整为非在线！
        fail ->
          skip
      end;
    false ->
      ?BT_LOG(io_lib:format("add_one_par_and_force_mark_offline(), Partner cannot goto fight! ParObj:~w~n", [ParObj])),
      skip
  end.


%% 尝试添加取经之路对手的宠物
init_try_add_battle_road_oppo_partners(Opponent,ParInfoLists,NowPoint,Lv) when is_record(Opponent, offline_bo) ->
  init_try_add_all_my_partners_qujing(Opponent, ?GUEST_SIDE, ?SYS_OFFLINE_ARENA,ParInfoLists,NowPoint,Lv),
  void.


%% 尝试添加离线竞技场对手的宠物
init_try_add_offline_arena_oppo_partners(OpponentPS) when is_record(OpponentPS, player_status) ->
  ParObjList = mod_partner:get_fighting_partner_list(OpponentPS),
  ?BT_LOG(io_lib:format("init_try_add_offline_arena_oppo_partners(OpponentPS, ..),  ParObjList: ~w~n", [ParObjList])),
  [add_one_par_and_force_mark_offline(Par, OpponentPS) || Par <- ParObjList],
  void;

init_try_add_offline_arena_oppo_partners(Opponent) when is_record(Opponent, offline_bo) ->
  init_try_add_all_my_partners(Opponent, ?GUEST_SIDE, ?SYS_OFFLINE_ARENA),
  void.




%% 尝试添加劫镖对手的宠物
init_try_add_hijack_oppo_partners(OpponentPS) when is_record(OpponentPS, player_status) ->
  ParObjList = mod_partner:get_fighting_partner_list(OpponentPS),
  ?BT_LOG(io_lib:format("init_try_add_hijack_oppo_partners(OpponentPS, ..),  ParObjList: ~w~n", [ParObjList])),
  [add_one_par_and_force_mark_offline(Par, OpponentPS) || Par <- ParObjList],
  void;

init_try_add_hijack_oppo_partners(Opponent) when is_record(Opponent, offline_bo) ->
  init_try_add_all_my_partners(Opponent, ?GUEST_SIDE, ?SYS_TRANSPORT),
  void.




%% 尝试添加雇佣玩家的宠物到战场， 目前实际上只尝试添加其主宠
init_try_add_hired_partners(PS, Side) ->
  % 是否有雇佣玩家？
  case ply_hire:has_fighting_hired_player(PS) of
    true ->
      HiredPlayerId = ply_hire:get_fighting_hired_player_id(PS),
      case mod_offline_data:get_offline_bo(HiredPlayerId, ?OBJ_PLAYER, ?SYS_HIRE) of
        null ->
          ?ASSERT(false, {HiredPlayerId, PS}),
          ?ERROR_MSG("[mod_battle] init_try_add_hired_partners() error!!! HiredPlayerId=~p, PS=~w", [HiredPlayerId, PS]),
          skip;
        HiredPly ->
          case mod_offline_bo:get_partner_id_list(HiredPly) of
            [] ->
              skip;
            ParIdList ->
              init_try_add_hired_main_par(ParIdList, PS, Side, HiredPlayerId)
          end
      end;
    false ->
      ?BT_LOG(io_lib:format("init_try_add_hired_partners(), No fighting hired player!!~n", [])),
      skip
  end.



init_try_add_hired_main_par([ParId | T], PS, Side, HiredPlayerId) ->
  case mod_offline_data:get_offline_bo(ParId, ?OBJ_PARTNER, ?SYS_HIRE) of
    null ->
      ?ASSERT(false, {ParId, HiredPlayerId, PS}),
      ?ERROR_MSG("[mod_battle] init_try_add_hired_main_par() error!!! ParId=~p, HiredPlayerId=~p, PS=~w", [ParId, HiredPlayerId, PS]),
      skip;
    HiredPar ->
      case mod_offline_bo:is_main_partner(HiredPar)
        andalso mod_offline_bo:can_par_goto_fight_once(HiredPar) of
        true ->
          add_one_hired_partner(PS, Side, HiredPlayerId, HiredPar);
        false ->
          % ?BT_LOG(io_lib:format("Hired Partner cannot goto fight! HiredPar:~w~n", [HiredPar])),

          init_try_add_hired_main_par(T, PS, Side, HiredPlayerId)
      end
  end;

init_try_add_hired_main_par([], _PS, _Side, _HiredPlayerId) ->
  done.












%% 查找第一个空闲的站位给玩家
find_first_empty_pos_for_player(Side, IsLeader) ->
  case IsLeader andalso (not lib_bt_comm:is_pos_occupied(Side, ?BATTLE_POS_FOR_LEADER)) of
    true ->
      ?BATTLE_POS_FOR_LEADER;
    false ->
      L = get_bo_id_list(Side),
      %%?TRACE("LLLLLL: ~p~n", [L]),
      CurOccupyPosList = [lib_bo:get_pos(get_bo_by_id(BoId)) || BoId <- L],

      EmptyPosList = ?BATTLE_POS_ORDER_FOR_NORMAL_TEAM_MEMBERS -- CurOccupyPosList,   %%?BATTLE_POS_ORDER_FOR_PLAYER -- CurOccupyPosList,

      case EmptyPosList == [] of
        true -> null;    % 位置已被占满，返回null
        false -> erlang:hd(EmptyPosList)
      end
  end.

find_first_empty_pos_for_player(Side, IsLeader, PS) ->
  case mod_team:get_team_troop(player:get_team_id(PS)) of
    ?INVALID_NO -> find_first_empty_pos_for_player(Side, IsLeader);
    _ZfNo ->
      ZfPos = mod_team:get_member_troop_pos(player:get_team_id(PS), player:id(PS)),
      case ZfPos =:= ?INVALID_NO of
        true -> find_first_empty_pos_for_player(Side, IsLeader);
        false -> lib_bt_misc:cfg_pos_to_server_logic_pos(ZfPos)
      end
  end.

%% 查找第一个空闲的站位给副宠
find_first_empty_pos_for_deputy_partner(Side) ->
  L = get_bo_id_list(Side),
  %%?TRACE("LLLLLL: ~p~n", [L]),
  CurOccupyPosList = [lib_bo:get_pos(get_bo_by_id(BoId)) || BoId <- L],

  EmptyPosList = ?BATTLE_POS_ORDER_FOR_DEPUTY_PARTNER -- CurOccupyPosList,

  case EmptyPosList == [] of
    true -> null;    % 位置已被占满，返回null
    false -> erlang:hd(EmptyPosList)
  end.







%% 添加一个玩家到战场
%% 上层函数需保证战场上还有对应的空位!
add_one_player(PS, Side, IsLeader) ->
  % Pos = case player:is_leader(PS) of
  % 	true ->
  % 		?ASSERT(not lib_bt_comm:is_pos_occupied(Side, ?BATTLE_POS_FOR_LEADER)),
  % 		?BATTLE_POS_FOR_LEADER;
  % 	false ->
  % 		find_first_empty_pos_for_player(Side)
  % end,
  Pos =
    case mod_team:get_team_troop(player:get_team_id(PS)) of
      ?INVALID_NO -> find_first_empty_pos_for_player(Side, IsLeader);
      _ZfNo ->
        ZfPos = mod_team:get_member_troop_pos(player:get_team_id(PS), player:id(PS)),
        case ZfPos =:= ?INVALID_NO of
          true -> find_first_empty_pos_for_player(Side, IsLeader);
          false -> lib_bt_misc:cfg_pos_to_server_logic_pos(ZfPos)
        end
    end,

  ?ASSERT(Pos /= null andalso Pos /= ?INVALID_NO),

  % 生成player bo
  {NewBoId, NewBo} = lib_bt_misc:generate_player_bo(PS, [Side, Pos, online]),

  % 添加bo到战场
  lib_bt_dict:add_bo_to_battle_field(NewBoId, NewBo, Side),

  % % TODO: 如果玩家有出战的宠物，则添加宠物
  % ?Ifc (player:has_fighting_partner(PS))
  % 	Partner = player:get_fighting_partner(PS),
  % 	Pos2 = get_first_empty_battle_pos(Side),
  % 	add_one_partnder(Partner, [Side, Pos2])
  % ?End,

  %%保存这个玩家用于支援的门客顺序
  AllPartner = mod_partner:get_fighting_partner_list(PS),
  F = fun(PartnerData,Acc) ->
    [{PartnerData#partner.join_battle_order,PartnerData#partner.id}|Acc]
      end,
  JoinBattleOrder = lists:foldl(F ,[] ,AllPartner),
  put({battle_order,player:get_id(PS)},JoinBattleOrder ),

  {ok, NewBoId}.

%% 添加一个玩家到战场
%% 上层函数需保证战场上还有对应的空位!
add_one_cross_player(PS, Side, IsLeader) ->
  % Pos = case player:is_leader(PS) of
  % 	true ->
  % 		?ASSERT(not lib_bt_comm:is_pos_occupied(Side, ?BATTLE_POS_FOR_LEADER)),
  % 		?BATTLE_POS_FOR_LEADER;
  % 	false ->
  % 		find_first_empty_pos_for_player(Side)
  % end,
  Pos =find_first_empty_pos_for_player(Side, IsLeader),
  ?ASSERT(Pos /= null andalso Pos /= ?INVALID_NO),

  % 生成player bo
  {NewBoId, NewBo} = lib_bt_misc:generate_player_bo(PS, [Side, Pos, online]),

  % 添加bo到战场
  lib_bt_dict:add_bo_to_battle_field(NewBoId, NewBo, Side),

  % % TODO: 如果玩家有出战的宠物，则添加宠物
  % ?Ifc (player:has_fighting_partner(PS))
  % 	Partner = player:get_fighting_partner(PS),
  % 	Pos2 = get_first_empty_battle_pos(Side),
  % 	add_one_partnder(Partner, [Side, Pos2])
  % ?End,

  {ok, NewBoId}.

%% 添加一个玩家到战场
%% 上层函数需保证战场上还有对应的空位!
add_one_cross_robot_player(OfflineBo, Side, IsLeader) ->
  % Pos = case player:is_leader(PS) of
  % 	true ->
  % 		?ASSERT(not lib_bt_comm:is_pos_occupied(Side, ?BATTLE_POS_FOR_LEADER)),
  % 		?BATTLE_POS_FOR_LEADER;
  % 	false ->
  % 		find_first_empty_pos_for_player(Side)
  % end,
  Pos =find_first_empty_pos_for_player(Side, IsLeader),
  ?ASSERT(Pos /= null andalso Pos /= ?INVALID_NO),

  % 生成player bo
  {NewBoId, NewBo} = lib_bt_misc:generate_player_bo(OfflineBo, [Side, Pos, false]),

  % 添加bo到战场
  lib_bt_dict:add_bo_to_battle_field(NewBoId, NewBo, Side),

  % % TODO: 如果玩家有出战的宠物，则添加宠物
  % ?Ifc (player:has_fighting_partner(PS))
  % 	Partner = player:get_fighting_partner(PS),
  % 	Pos2 = get_first_empty_battle_pos(Side),
  % 	add_one_partnder(Partner, [Side, Pos2])
  % ?End,

  {ok, NewBoId}.


%% 添加一个宠物到战场
%% @return: {ok, NewParBoId} | fail
add_one_partner(PS, PartnerObj, Side) ->
  PlayerId = player:id(PS),
  PlayerBo = get_bo_by_player_id(PlayerId),
  ?ASSERT(PlayerBo /= null, PlayerId),

  IsMainPar = lib_partner:is_main_partner(PartnerObj),
  PartnerId = lib_partner:get_id(PartnerObj),

  % 确定站位
  Pos = case IsMainPar of
          true ->
            ?BT_LOG(io_lib:format("add_one_partner(), is_main_partner, PartnerId=~p~n", [PartnerId])),
            lib_bo:decide_my_main_partner_pos(PlayerBo);
          false ->
            find_first_empty_pos_for_deputy_partner(Side)
        end,

  % 宠物个数有可能超出（比如：雇佣玩家的主宠也可能出战，从而占用了一个位置），同时，保险起见，对Pos做合法性判断
  case lib_bt_comm:is_pos_occupied(Side, Pos) orelse (Pos == null) of
    true ->
      fail;
    false ->
      ?BT_LOG(io_lib:format("add_one_partner(), Pos=~p, PlayerId=~p, PartnerId=~p~n", [Pos, PlayerId, PartnerId])),

      % 生成bo
      {NewParBoId, NewBo} = lib_bt_misc:generate_partner_bo(PartnerObj, [Side, Pos]),

      put({get_player_id_by_bo, NewParBoId},PlayerId),

      % 添加bo到战场
      lib_bt_dict:add_bo_to_battle_field(NewParBoId, NewBo, Side),

      % PlayerBoId = lib_bo:id(PlayerBo),


      lib_bt_misc:post_add_partner_to_battle_field(PartnerId, NewParBoId, PlayerBo, IsMainPar),

      {ok, NewParBoId}
  end.


%% 添加一个宠物到战场
%% @return: {ok, NewParBoId} | fail
add_one_partner_for_cross_robot(PlayerId, PartnerObj, Side) ->
  PlayerBo = get_bo_by_player_id(PlayerId),
  ?ASSERT(PlayerBo /= null, PlayerId),

  IsMainPar = lib_partner:is_main_partner(PartnerObj),
  PartnerId = lib_partner:get_id(PartnerObj),

  % 确定站位
  Pos = case IsMainPar of
          true ->
            ?BT_LOG(io_lib:format("add_one_partner(), is_main_partner, PartnerId=~p~n", [PartnerId])),
            lib_bo:decide_my_main_partner_pos(PlayerBo);
          false ->
            find_first_empty_pos_for_deputy_partner(Side)
        end,

  % 宠物个数有可能超出（比如：雇佣玩家的主宠也可能出战，从而占用了一个位置），同时，保险起见，对Pos做合法性判断
  case lib_bt_comm:is_pos_occupied(Side, Pos) orelse (Pos == null) of
    true ->
      fail;
    false ->
      ?BT_LOG(io_lib:format("add_one_partner(), Pos=~p, PlayerId=~p, PartnerId=~p~n", [Pos, PlayerId, PartnerId])),

      % 生成bo
      {NewParBoId, NewBo} = lib_bt_misc:generate_partner_bo_robot(PartnerObj, [Side, Pos]),

      % 添加bo到战场
      lib_bt_dict:add_bo_to_battle_field(NewParBoId, NewBo, Side),

      % PlayerBoId = lib_bo:id(PlayerBo),


      lib_bt_misc:post_add_partner_to_battle_field(PartnerId, NewParBoId, PlayerBo, IsMainPar),

      {ok, NewParBoId}
  end.

%% 添加一个宠物到战场
%% @return: {ok, NewParBoId} | fail
add_one_partner_for_road(PS, PartnerObj , IsMain, Side) ->

  IsMainPar = (IsMain =:= 1),
  PlayerId = player:id(PS),
  PlayerBo = get_bo_by_player_id(PlayerId),
  ?ASSERT(PlayerBo /= null, PlayerId),


  %IsMainPar = lib_partner:is_main_partner(PartnerObj),
  PartnerId = lib_partner:get_id(PartnerObj),

  % 确定站位
  Pos = case IsMainPar of
          true ->
            ?BT_LOG(io_lib:format("add_one_partner(), is_main_partner, PartnerId=~p~n", [PartnerId])),
            lib_bo:decide_my_main_partner_pos(PlayerBo);
          false ->
            find_first_empty_pos_for_deputy_partner(Side)
        end,

  % 宠物个数有可能超出（比如：雇佣玩家的主宠也可能出战，从而占用了一个位置），同时，保险起见，对Pos做合法性判断
  case lib_bt_comm:is_pos_occupied(Side, Pos) orelse (Pos == null) of
    true ->
      fail;
    false ->
      ?BT_LOG(io_lib:format("add_one_partner(), Pos=~p, PlayerId=~p, PartnerId=~p~n", [Pos, PlayerId, PartnerId])),

      % 生成bo
      {NewParBoId, NewBo} = lib_bt_misc:generate_battle_road_partner_bo(PS,PartnerObj, [Side, Pos],1),

      % 添加bo到战场
      lib_bt_dict:add_bo_to_battle_field(NewParBoId, NewBo, Side),

      % PlayerBoId = lib_bo:id(PlayerBo),


      lib_bt_misc:post_add_partner_to_battle_field(PartnerId, NewParBoId, PlayerBo, IsMainPar),

      {ok, NewParBoId}
  end.







%% 添加一个雇佣玩家的宠物到战场
%% @return: {ok, NewParBoId} | fail
add_one_hired_partner(_PS, Side, HiredPlayerId, HiredPar) ->
  case get_bo_by_player_id(HiredPlayerId) of
    null -> %% 此分支属正常逻辑，目前有些怪物组不允许雇佣玩家出战
      % ?ERROR_MSG("[mod_battle] add_one_hired_partner() error!! HiredPlayerBo not exists! PlayerId:~p, Side:~p, HiredPlayerId:~p, BoIdList of Side:~w",
      % [player:id(PS), Side, HiredPlayerId, get_bo_id_list(Side)]),
      skip;
    _HiredPlayerBo ->
      ?ASSERT(is_hired_player(_HiredPlayerBo), _HiredPlayerBo),
      add_one_offline_partner(HiredPar, Side, HiredPlayerId)
  end.



%% @return: {ok, NewParBoId} | fail
add_one_offline_partner_for_road(PS,OfflinePar, Side, OwnerPlayerId) ->
  ?ASSERT(is_record(OfflinePar, offline_bo)),
  ?ASSERT(mod_offline_bo:is_partner(OfflinePar)),

  RoadData = mod_road:get_road_from_ets(player:get_id(PS)),
  NowPoint = RoadData#road_info.now_point,
  ParInfo = RoadData#road_info.pk_info,
  %{PlayerId,Name,Faction,Lv,Sex,FivePartner}
  [{_PlayerID,_Name,_Faction,_Lv,_Sex,FivePartner}] = lists:sublist(ParInfo, NowPoint, 1),
  %{IsMainPar,_,_} = lists:sublist([FivePartner], 1, 1), %前端发过来的第一zhi为主宠
  %有个问题出战的还是按照战力第一的

  IsMain  = case lists:keyfind(1, 6, FivePartner) of
              false -> false;
              _R -> true
            end,

  OwnerPlayerBo = get_bo_by_player_id(OwnerPlayerId),
  ?ASSERT(OwnerPlayerBo /= null, OwnerPlayerId),


  ParId = mod_offline_bo:get_id(OfflinePar),

  % 确定站位
  Pos = 	case IsMain of
           true ->
             ?BT_LOG(io_lib:format("add_one_offline_partner(), it is main partner! ParId=~p~n", [ParId])),
             lib_bo:decide_my_main_partner_pos(OwnerPlayerBo);

           false ->
             find_first_empty_pos_for_deputy_partner(Side)
         end,

  % 宠物个数有可能超出（比如：雇佣玩家的主宠也可能出战，从而占用了一个位置），同时，保险起见，对Pos做合法性判断
  case lib_bt_comm:is_pos_occupied(Side, Pos) orelse (Pos == null) of
    true ->
      fail;
    false ->
      ?BT_LOG(io_lib:format("add_one_offline_partner(), Pos=~p, OwnerPlayerId=~p, ParId=~p~n", [Pos, OwnerPlayerId, ParId])),

      % 生成bo
      {NewParBoId, NewParBo} = lib_bt_misc:generate_battle_road_partner_bo(PS,OfflinePar, [Side, Pos],2),

      % 添加bo到战场
      lib_bt_dict:add_bo_to_battle_field(NewParBoId, NewParBo, Side),

      % PlayerBoId = lib_bo:id(PlayerBo),

      lib_bt_misc:post_add_partner_to_battle_field(ParId, NewParBoId, OwnerPlayerBo, IsMain),

      {ok, NewParBoId}
  end.






%% @return: {ok, NewParBoId} | fail
add_one_offline_partner(OfflinePar, Side, OwnerPlayerId) ->
  ?ASSERT(is_record(OfflinePar, offline_bo)),
  ?ASSERT(mod_offline_bo:is_partner(OfflinePar)),

  OwnerPlayerBo = get_bo_by_player_id(OwnerPlayerId),
  ?ASSERT(OwnerPlayerBo /= null, OwnerPlayerId),

  IsMainPar = mod_offline_bo:is_main_partner(OfflinePar),
  ParId = mod_offline_bo:get_id(OfflinePar),

  % 确定站位
  Pos = 	case IsMainPar of
           true ->
             ?BT_LOG(io_lib:format("add_one_offline_partner(), it is main partner! ParId=~p~n", [ParId])),
             lib_bo:decide_my_main_partner_pos(OwnerPlayerBo);
           false ->
             find_first_empty_pos_for_deputy_partner(Side)
         end,

  % 宠物个数有可能超出（比如：雇佣玩家的主宠也可能出战，从而占用了一个位置），同时，保险起见，对Pos做合法性判断
  case lib_bt_comm:is_pos_occupied(Side, Pos) orelse (Pos == null) of
    true ->
      fail;
    false ->
      ?BT_LOG(io_lib:format("add_one_offline_partner(), Pos=~p, OwnerPlayerId=~p, ParId=~p~n", [Pos, OwnerPlayerId, ParId])),

      % 生成bo
      {NewParBoId, NewParBo} = lib_bt_misc:generate_partner_bo(OfflinePar, [Side, Pos]),

      % 添加bo到战场
      lib_bt_dict:add_bo_to_battle_field(NewParBoId, NewParBo, Side),

      % PlayerBoId = lib_bo:id(PlayerBo),

      lib_bt_misc:post_add_partner_to_battle_field(ParId, NewParBoId, OwnerPlayerBo, IsMainPar),

      {ok, NewParBoId}
  end.

%% @return: {ok, NewParBoId} | fail
add_one_offline_partner_qujing(OfflinePar, Side, OwnerPlayerId,TrueHp,TrueMp,MaxHp,MaxMp,TrueIsMain,NowPoint,Lv) ->
  ?ASSERT(is_record(OfflinePar, offline_bo)),
  ?ASSERT(mod_offline_bo:is_partner(OfflinePar)),

  OwnerPlayerBo = get_bo_by_player_id(OwnerPlayerId),
  ?ASSERT(OwnerPlayerBo /= null, OwnerPlayerId),

  IsMainPar = (TrueIsMain =:= 1),
  ParId = mod_offline_bo:get_id(OfflinePar),
  OppLv = player:get_lv(OwnerPlayerId),

  % 确定站位
  Pos = 	case IsMainPar of
           true ->
             ?BT_LOG(io_lib:format("add_one_offline_partner(), it is main partner! ParId=~p~n", [ParId])),
             lib_bo:decide_my_main_partner_pos(OwnerPlayerBo);
           false ->
             find_first_empty_pos_for_deputy_partner(Side)
         end,

  % 宠物个数有可能超出（比如：雇佣玩家的主宠也可能出战，从而占用了一个位置），同时，保险起见，对Pos做合法性判断
  case lib_bt_comm:is_pos_occupied(Side, Pos) orelse (Pos == null) of
    true ->
      fail;
    false ->
      ?BT_LOG(io_lib:format("add_one_offline_partner(), Pos=~p, OwnerPlayerId=~p, ParId=~p~n", [Pos, OwnerPlayerId, ParId])),

      % 生成bo
      {NewParBoId, NewParBo} = lib_bt_misc:generate_partner_bo_qujing(OfflinePar, [Side, Pos],TrueHp,TrueMp,MaxHp,MaxMp,IsMainPar,NowPoint,Lv,OppLv),

      % 添加bo到战场
      lib_bt_dict:add_bo_to_battle_field(NewParBoId, NewParBo, Side),

      % PlayerBoId = lib_bo:id(PlayerBo),

      lib_bt_misc:post_add_partner_to_battle_field(ParId, NewParBoId, OwnerPlayerBo, IsMainPar),

      {ok, NewParBoId}
  end.







%% 添加一个雇佣玩家到战场
add_one_hired_player(OfflineBo, Side, OwnerPlayerBoId) ->
  ?ASSERT(is_record(OfflineBo, offline_bo), OfflineBo),
  IsLeader = false,
  IsHiredPlayer = true,
  {ok, NewBoId} = add_one_offline_player(OfflineBo, Side, IsLeader, IsHiredPlayer),

  % 记录所属的玩家bo
  lib_bo:set_my_owner_player_bo_id(NewBoId, OwnerPlayerBoId),

  % 记录所拥有的雇佣玩家
  lib_bo:set_my_hired_player_bo_id(OwnerPlayerBoId, NewBoId).

% HiredPlyrId = mod_offline_bo:get_id(OfflineBo),
% lib_bt_dict:record_hired_player_id(HiredPlyrId, Side).




%% 添加离线竞技场对手（玩家）
add_one_offline_arena_oppo_player(Opponent) when is_record(Opponent, player_status) ->
  IsLeader = true,  % 当做是队长
  IsHiredPlayer = false,
  add_one_offline_player(Opponent, ?GUEST_SIDE, IsLeader, IsHiredPlayer);

add_one_offline_arena_oppo_player(Opponent) when is_record(Opponent, offline_bo) ->
  IsLeader = true,
  IsHiredPlayer = false,
  add_one_offline_player(Opponent, ?GUEST_SIDE, IsLeader, IsHiredPlayer).

add_one_battle_road_oppo_player(Opponent,Point,Lv) when is_record(Opponent, offline_bo) ->
  IsLeader = true,
  IsHiredPlayer = false,
  add_one_offline_player_qujing(Opponent, ?GUEST_SIDE, IsLeader, IsHiredPlayer,Point,Lv).



%% 添加劫镖的对手（玩家）
add_one_hijack_oppo_player(Opponent) when is_record(Opponent, player_status) ->
  IsLeader = true,  % 当做是队长
  IsHiredPlayer = false,
  add_one_offline_player(Opponent, ?GUEST_SIDE, IsLeader, IsHiredPlayer);
add_one_hijack_oppo_player(Opponent) when is_record(Opponent, offline_bo) ->
  IsLeader = true,
  IsHiredPlayer = false,
  add_one_offline_player(Opponent, ?GUEST_SIDE, IsLeader, IsHiredPlayer).







add_one_offline_player(PlayerStat, Side, IsLeader, _IsHiredPlayer) when is_record(PlayerStat, player_status) ->
  Pos = find_first_empty_pos_for_player(Side, IsLeader, PlayerStat),
  ?ASSERT(Pos /= null),
  % 生成离线玩家bo
  {NewBoId, NewBo} = lib_bt_misc:generate_player_bo(PlayerStat, [Side, Pos, offline]),

  % 添加bo到战场
  lib_bt_dict:add_bo_to_battle_field(NewBoId, NewBo, Side),

  {ok, NewBoId};

add_one_offline_player(OfflineBo, Side, IsLeader, IsHiredPlayer) when is_record(OfflineBo, offline_bo) ->
  Pos = find_first_empty_pos_for_player(Side, IsLeader),
  ?ASSERT(Pos /= null),
  % 生成离线玩家bo
  {NewBoId, NewBo} = lib_bt_misc:generate_player_bo(OfflineBo, [Side, Pos, IsHiredPlayer]),

  % 添加bo到战场
  lib_bt_dict:add_bo_to_battle_field(NewBoId, NewBo, Side),

  {ok, NewBoId}.


add_one_offline_player_qujing(OfflineBo, Side, IsLeader, IsHiredPlayer,Point,Lv) when is_record(OfflineBo, offline_bo) ->
  Pos = find_first_empty_pos_for_player(Side, IsLeader),
  ?ASSERT(Pos /= null),
  % 生成离线玩家bo
  {NewBoId, NewBo} = lib_bt_misc:generate_battle_road_player_bo(OfflineBo, [Side, Pos, IsHiredPlayer],Point,Lv),

  % 添加bo到战场
  lib_bt_dict:add_bo_to_battle_field(NewBoId, NewBo, Side),

  {ok, NewBoId}.


%% 判定刷怪的数量
decide_spawn_mon_count(BMonGroup) ->
  case lib_bmon_group:get_force_spawn_mon_count(BMonGroup) of
    0 ->
      BoIdList = get_bo_id_list(?PLAYER_DFL_SIDE),

      F = fun(BoId,Acc) ->
        Bo = get_bo_by_id(BoId),

        case is_player(Bo) of
          true -> Acc + 1;
          _ -> Acc
        end
          end,

      % 玩家单位数量
      PlayerCount = lists:foldl(F,0,BoIdList),

      % FightingObjCount = length( get_bo_id_list(?PLAYER_DFL_SIDE) ),

      RetCount = util:rand( util:ceil(PlayerCount * 1.8), util:ceil(PlayerCount * 2.5) ),
      % ?BT_LOG(io_lib:format("decide_spawn_mon_count(), FightingObjCount:~p, RetCount:~p~n", [FightingObjCount, RetCount])),
      util:minmax(RetCount, 1, ?MAX_BO_COUNT_PER_SIDE);

    ForceSpawnCount ->
      % ?ASSERT(util:is_positive_int(ForceSpawnCount), BMonGroup),
      util:floor(ForceSpawnCount)
  end.


% 等级加成系数
get_lv_add_coef(Lv) ->

  PredicateList = lists:filter(fun(E) -> E > Lv end, data_add_lv_coef:get_key_no()),
  TakeOneElem = lists:min(PredicateList),
  case data_add_lv_coef:get(TakeOneElem) of
    null ->
      1;
    COEF ->COEF
  end.

init_add_monsters(PS, BMonGroupNo, Side, ExtraInfo) ->
  BMonGroup = lib_bmon_group:get_cfg_data(BMonGroupNo),
  MonCount = decide_spawn_mon_count(BMonGroup),
  % Lv = player:get_lv(PS),

  AvgLv = mod_team:get_member_average_lv(player:get_id(PS)),
  MaxLv = mod_team:get_member_max_lv(PS),
  ?DEBUG_MSG("TestStreng AvgLv - MaxLv ~p",[{AvgLv, MaxLv}]),


  % 怪物等级大概为平均等级与最高等级 相加除以2
%%  Lv = erlang:round(((AvgLv + MaxLv) * MaxLv)/MaxLv/2),
  do_add_monsters2(AvgLv,MaxLv,BMonGroup, MonCount, Side, ExtraInfo).

do_add_monsters(Lv,BMonGroup, MonCount, Side, ExtraInfo) ->
  MonL = lib_bt_misc:pick_mon_from_group(BMonGroup, MonCount),
  ?TRACE("do_add_monsters(), MonL=~p~n", [MonL]),

  AttrRandomRange = BMonGroup#bmon_group.attr_random_range,
  AttrStreng = case BMonGroup#bmon_group.attr_streng of
                 0 ->	?DEBUG_MSG("TestStreng 1 ~p", [{get_lv_add_coef(Lv),BMonGroup#bmon_group.attr_streng}]), 1;
                 {fixed,DigitalVal} ->
                   DigitalVal;
                 {mixed,DigitalVal} ->
                   DigitalVal*get_lv_add_coef(Lv);
                 _ ->	get_lv_add_coef(Lv) * BMonGroup#bmon_group.attr_streng
               end,
  ?DEBUG_MSG("TestStreng get_lv_add_coef(Lv) AttrStreng  bmon_group.attr_streng  ~p", [{get_lv_add_coef(Lv),AttrStreng,BMonGroup#bmon_group.attr_streng}]),

  % 1 + Lv * BMonGroup#bmon_group.attr_streng,

  ?DEBUG_MSG("Lv = ~p,AttrRandomRange =~p,AttrStreng = ~p",[Lv,AttrRandomRange,AttrStreng]),

  F = fun({BtlMonNo, Pos}, AccNewBoList) ->
    Pos2 = lib_bt_misc:cfg_pos_to_server_logic_pos(Pos),
    case lib_bt_misc:add_one_monster(BtlMonNo, Side, Pos2,AttrRandomRange, AttrStreng,[{bmon_lv,Lv},{bmon_group_no, lib_bmon_group:get_no(BMonGroup)} | ExtraInfo]) of
      {ok, NewBo} ->
        [NewBo | AccNewBoList];
      fail ->
        AccNewBoList
    end
      end,

  lists:foldl(F, [], MonL).


do_add_monsters2(Lv,MaxLV,BMonGroup, MonCount, Side, ExtraInfo) ->
  MonL = lib_bt_misc:pick_mon_from_group(BMonGroup, MonCount),
  ?TRACE("do_add_monsters(), MonL=~p~n", [MonL]),

  AttrRandomRange = BMonGroup#bmon_group.attr_random_range,
  AttrStreng = case BMonGroup#bmon_group.attr_streng of
                 0 ->	?DEBUG_MSG("TestStreng 1 ~p", [{get_lv_add_coef(Lv),BMonGroup#bmon_group.attr_streng}]), 1;
                 {fixed,DigitalVal} ->
                   DigitalVal;
                 {mixed,DigitalVal} ->
                   DigitalVal*get_lv_add_coef(MaxLV);
                 _ ->	get_lv_add_coef(Lv) * BMonGroup#bmon_group.attr_streng
               end,
  ?DEBUG_MSG("TestStreng get_lv_add_coef(Lv) AttrStreng  bmon_group.attr_streng  ~p", [{get_lv_add_coef(Lv),AttrStreng,BMonGroup#bmon_group.attr_streng}]),

  % 1 + Lv * BMonGroup#bmon_group.attr_streng,

  ?DEBUG_MSG("Lv = ~p,AttrRandomRange =~p,AttrStreng = ~p",[Lv,AttrRandomRange,AttrStreng]),

  F = fun({BtlMonNo, Pos}, AccNewBoList) ->
    Pos2 = lib_bt_misc:cfg_pos_to_server_logic_pos(Pos),
    case lib_bt_misc:add_one_monster(BtlMonNo, Side, Pos2,AttrRandomRange, AttrStreng,[{bmon_lv,Lv},{bmon_group_no, lib_bmon_group:get_no(BMonGroup)} | ExtraInfo]) of
      {ok, NewBo} ->
        [NewBo | AccNewBoList];
      fail ->
        AccNewBoList
    end
      end,

  lists:foldl(F, [], MonL).

do_add_monsters(BMonGroup, MonCount, Side, ExtraInfo) ->
  MonL = lib_bt_misc:pick_mon_from_group(BMonGroup, MonCount),
  ?TRACE("do_add_monsters(), MonL=~p~n", [MonL]),

  % AttrRandomRange = BMonGroup#bmon_group.attr_random_range,
  % AttrStreng = BMonGroup#bmon_group.attr_streng,

  % ?DEBUG_MSG("AttrRandomRange =~p,AttrStreng = ~p",[AttrRandomRange,AttrStreng]),

  F = fun({BtlMonNo, Pos}, AccNewBoList) ->
    Pos2 = lib_bt_misc:cfg_pos_to_server_logic_pos(Pos),
    case lib_bt_misc:add_one_monster(BtlMonNo, Side, Pos2,[{bmon_group_no, lib_bmon_group:get_no(BMonGroup)} | ExtraInfo]) of
      {ok, NewBo} ->
        [NewBo | AccNewBoList];
      fail ->
        AccNewBoList
    end
      end,
  lists:foldl(F, [], MonL).


init_battle(for_mf, [PS, Callback, BattleId, BattleSubType, MonId, MonNo, BMonGroupNo]) ->
  ?BT_LOG(io_lib:format("!!!!!init_battle(for_mf, ..), MonId: ~p, MonNo:~p~n", [MonId, MonNo])),
  comm_init_battle__(PS, ?BTL_T_PVE, BattleSubType, BattleId, Callback),
  BtlState = get_battle_state(),

  BMonGrp = lib_bmon_group:get_cfg_data(BMonGroupNo),
  BtlState2 = BtlState#btl_state{
    mon_id = MonId,
    mon_no = MonNo,
    bmon_group_no = BMonGroupNo,
    plot_no = BMonGrp#bmon_group.bt_plot_no,
    nth_wave_bmon_group = 1  % 波数从1开始算起
  },
  set_battle_state(BtlState2);


init_battle(for_offline_arena, [BattleId, PS, Opponent]) ->
  comm_init_battle__(PS, ?BTL_T_PVP, ?BTL_SUB_T_OFFLINE_ARENA, BattleId),
  %%BtlState = get_battle_state(),
  OppoPlayerId = 	if
                    is_record(Opponent, player_status) ->
                      ?BT_LOG(io_lib:format("init_battle(for_offline_arena, ..), it is player_status!~n", [])),
                      player:get_id(Opponent);
                    is_record(Opponent, offline_bo) ->
                      ?BT_LOG(io_lib:format("init_battle(for_offline_arena, ..), it is offline_bo!~n", [])),
                      mod_offline_bo:get_id(Opponent)
                  end,

  lib_bt_dict:add_to_pvp_player_id_list(player:id(PS), ?HOST_SIDE),
  lib_bt_dict:add_to_pvp_player_id_list(OppoPlayerId, ?GUEST_SIDE);


init_battle(for_hijack, [BattleId, PS, Opponent, Callback]) ->
  comm_init_battle__(PS, ?BTL_T_PVP, ?BTL_SUB_T_HIJACK, BattleId, Callback),
  %%BtlState = get_battle_state(),
  OppoPlayerId = 	if
                    is_record(Opponent, player_status) ->
                      ?BT_LOG(io_lib:format("init_battle(for_hijack, ..), it is player_status!~n", [])),
                      player:get_id(Opponent);
                    is_record(Opponent, offline_bo) ->
                      ?BT_LOG(io_lib:format("init_battle(for_hijack, ..), it is offline_bo!~n", [])),
                      mod_offline_bo:get_id(Opponent)
                  end,

  lib_bt_dict:add_to_pvp_player_id_list(player:id(PS), ?HOST_SIDE),
  lib_bt_dict:add_to_pvp_player_id_list(OppoPlayerId, ?GUEST_SIDE);


init_battle(for_pk, [Callback, BattleId, PS, _OpponentPS, PK_Type]) ->
  BtlSubType = pk_type_to_battle_sub_type(PK_Type),
  comm_init_battle__(PS, ?BTL_T_PVP, BtlSubType, BattleId, Callback);

init_battle(for_cross_3v3, [Callback, BattleId, PS, _OpponentPS, PK_Type]) ->
  BtlSubType = pk_type_to_battle_sub_type(PK_Type),
  comm_init_battle__(PS, ?BTL_T_PVP, BtlSubType, BattleId, Callback).


pk_type_to_battle_sub_type(PK_Type) ->
  case PK_Type of
    ?PK_T_QIECUO -> ?BTL_SUB_T_PK_QIECUO;
    ?PK_T_FORCE -> ?BTL_SUB_T_PK_FORCE;
    ?PK_T_1V1_ONLINE_ARENA -> ?BTL_SUB_T_1V1_ONLINE_ARENA;
    ?PK_T_GUILD_WAR -> ?BTL_SUB_T_GUILD_WAR;
    ?PK_T_MELEE -> ?BTL_SUB_T_MELEE_PK;
    ?PK_T_3V3_ONLINE_ARENA -> ?BTL_SUB_T_3V3_ONLINE_ARENA;
    ?PK_T_CROSS_3V3 -> ?BTL_SUB_T_CROSS_3V3
  end.




comm_init_battle__(PS, BattleType, BattleSubType, BattleId) ->
  comm_init_battle__(PS, BattleType, BattleSubType, BattleId, null).

comm_init_battle__(PS, BattleType, BattleSubType, _BattleId, Callback) ->
  % 打开战斗日志文件，专用于记录战斗日志
  ?OPEN_BT_LOG_FILE(_BattleId),

  BtlState = get_battle_state(),
  ?ASSERT(BtlState /= undefined),


  {SceneId, SceneType} =
    case BattleSubType == 14 orelse BattleSubType == 15 of
      false ->
        decide_scene_id_and_type(PS);
      true ->
        {0,0}
    end,

  BtlState2 = BtlState#btl_state{
    type = BattleType,
    subtype = BattleSubType,
    start_time = util:unixtime(),
    scene_id = SceneId,
    scene_type = SceneType,
    callback = Callback
  },

  set_battle_state(BtlState2),

  init_collected_reports(),

  lib_bt_dict:init_spawned_bmon_list(),

  init_both_side_bo_id_list(),

  % 初始化预安排的随机站位顺序，用于随机集火原则
  PosList = lists:seq(?MIN_BATTLE_POS, 2 * ?MAX_BATTLE_POS_PER_SIDE),
  Len = length(PosList),
  % set_rand_pos_order(?HOST_SIDE, tool:shuffle(PosList, Len)),
  % set_rand_pos_order(?GUEST_SIDE, tool:shuffle(PosList, Len)).
  lib_bt_dict:set_preset_rand_pos_order(tool:shuffle(PosList, Len)).


decide_scene_id_and_type(PS) ->
  SceneId = player:get_scene_id(PS),
  case lib_scene:get_obj(SceneId) of
    null ->
      ?ERROR_MSG("decide_scene_id_and_type() error!! SceneId:~p, PS:~w", [SceneId, PS]),
      ?ASSERT(false, {SceneId, PS}),
      {SceneId, ?SCENE_T_INVALID};
    SceneObj ->
      {SceneId, lib_scene:get_type(SceneObj)}
  end.


%% 初始化战场双方的bo id列表为空
init_both_side_bo_id_list() ->
  put(?KN_HOST_SIDE_BO_ID_LIST, []),
  put(?KN_GUEST_SIDE_BO_ID_LIST, []).


% get_rand_pos_order(Side) ->
% 	case Side of
% 		?HOST_SIDE ->
% 			get(?KN_HOST_SIDE_RAND_POS_ORDER);
% 		?GUEST_SIDE ->
% 			get(?KN_GUEST_SIDE_RAND_POS_ORDER)
% 	end.


% set_rand_pos_order(Side, PosList) ->
% 	case Side of
% 		?HOST_SIDE ->
% 			put(?KN_HOST_SIDE_RAND_POS_ORDER, PosList);
% 		?GUEST_SIDE ->
% 			put(?KN_GUEST_SIDE_RAND_POS_ORDER, PosList)
% 	end.















build_battle_field_desc(MyBoId) ->
  BtlState = get_battle_state(),

  BoCount_HostSide = lib_bt_comm:get_bo_count(?HOST_SIDE),
  BoInfo_HostSide = build_bo_info_of_side(?HOST_SIDE),

  BoCount_GuestSide = lib_bt_comm:get_bo_count(?GUEST_SIDE),
  BoInfo_GuestSide = build_bo_info_of_side(?GUEST_SIDE),
  <<
    (BtlState#btl_state.id) : 32,
    (BtlState#btl_state.type) : 8,
    (BtlState#btl_state.subtype) : 8,
    MyBoId : 16,
    (BtlState#btl_state.host_zf) : 32,
    (BtlState#btl_state.guest_zf) : 32,
    BoCount_HostSide : 16,
    BoInfo_HostSide /binary,
    BoCount_GuestSide : 16,
    BoInfo_GuestSide /binary
  >>.



%% 构造某一方全体bo的信息，返回binary类型
build_bo_info_of_side(Side) ->
  BoIdList = get_bo_id_list(Side),

  F = fun(BoId) ->
    Bo = get_bo_by_id(BoId),
    lib_bt_misc:build_bo_info_bin(Bo)
      end,
  InfoList = [F(X) || X <- BoIdList],
  list_to_binary(InfoList).






%% schedule battle finish
schedule_battle_finish() ->
  self() ! {'battle_finish'}.


schedule_new_round_begin() ->
  BtlState = get_battle_state(),

  %限时任务
  case BtlState#btl_state.subtype =:= ?BTL_SUB_T_TIMEBATTLE of
    true ->
      %多少回合内胜利
      [LimitTaskData] = ets:lookup(ets_limited_time_data, BtlState#btl_state.limit_task_key),
      case BtlState#btl_state.round_counter >= LimitTaskData#limited_time_data.arg of
        true ->
          [BattleLog] = ets:lookup(?ETS_BATTLE_CREATE_LOG, BtlState#btl_state.id),
          PlayerId = BattleLog#btl_create_log.creator,
          mod_battle:force_end_battle(player:get_PS(PlayerId));
        false ->
          skip
      end;
    false ->
      %坚持多少回合
      case BtlState#btl_state.subtype =:= ?BTL_SUB_T_DEFENSE of
        true ->
          [LimitTaskData] = ets:lookup(ets_limited_time_data, BtlState#btl_state.limit_task_key),
          case BtlState#btl_state.round_counter >= LimitTaskData#limited_time_data.arg of
            true ->
              [BattleLog] = ets:lookup(?ETS_BATTLE_CREATE_LOG, BtlState#btl_state.id),
              ?DEBUG_MSG("wujianchengTest ~p ~n", [{ player:get_cur_battle_pid(player:get_PS(BattleLog#btl_create_log.creator)),BattleLog}]),
              PlayerId = BattleLog#btl_create_log.creator,
              mod_battle:dbg_force_win_battle(player:get_PS(PlayerId), player:get_cur_battle_pid(player:get_PS(PlayerId)));
            false ->
              skip
          end;
        false ->
          skip
      end
  end,

  case BtlState#btl_state.subtype =:= ?BTL_SUB_T_CROSS_3V3 orelse BtlState#btl_state.subtype =:= ?BTL_SUB_T_CROSS_3V3_ROBORT of
    true ->
      case BtlState#btl_state.round_counter >= 50 of
        true ->
          [H|_] = BtlState#btl_state.pvp_player_id_list_host,
          Fun = fun(X) ->
            ets:delete(?ETS_PVP_MATCH_ROOM, X)
                end,
          lists:foreach(Fun,  BtlState#btl_state.pvp_player_id_list_host),

          Fun2 = fun(X) ->
            ets:delete(?ETS_PVP_MATCH_ROOM, X)
                 end,
          lists:foreach(Fun2,  BtlState#btl_state.pvp_player_id_list_guest),

          mod_battle:force_end_battle_no_win_side(player:get_PS(H));
        false ->
          case BtlState#btl_state.round_counter == 19 of
            true ->%% 跨服3v3第20回合加buff
              BoIds = get_all_bo_id_list(),
              EffNo = 4000106,
              SkillId = 30047,
              Eff = lib_skill_eff:get_cfg_data(4000106),
              [handle_skill_add_buff_eff(ActorId, SkillId, Eff, [ActorId]) || ActorId <- BoIds];
            false ->
              skip
          end,
          self() ! {'new_round_begin'}
      end;
    false ->
      self() ! {'new_round_begin'}
  end.



%% 回合结束时的处理
round_finish() ->
  % 标记战斗此时的状态为“等待客户端播放完战报”
  set_cur_battle_bhv(?BHV_WAITING_CLIENTS_FOR_SHOW_BR_DONE),

  % 通知客户端：回合行动结束
  lib_bt_send:notify_round_action_end(),

  % ?DEBUG_MSG("round_finish(), cur_round:~p, battle_id:~p", [lib_bt_comm:get_cur_round(), lib_bt_comm:get_battle_id()]),

  % 预cast一个处理超时，以防止战斗卡住
  Intv = ?MAX_WAIT_TIME_FOR_SHOW_BR_SEC * 1000 + 10000, % 允许10秒的延迟
  erlang:send_after(Intv, self(), {'cli_notify_show_br_done_timeout', lib_bt_comm:get_cur_round()}).












% %% 获取当前反击者id
% get_cur_reactor_id() ->
% 	get(?KN_CUR_REACTOR_ID).


% %% 设置当前反击者id
% set_cur_reactor_id(BoId) ->
% 	?ASSERT(is_integer(BoId), BoId),
% 	?ASSERT(BoId /= ?INVALID_ID),
% 	put(?KN_CUR_REACTOR_ID, BoId).

% %% 清除当前反击者id
% clear_cur_reactor_id() ->
% 	put(?KN_CUR_REACTOR_ID, ?INVALID_ID).



%% 初始化所有bo的乱敏
init_tmp_rand_act_speed_for_all() ->
  L = get_all_bo_id_list(),
  F = fun(BoId) ->
    lib_bo:init_tmp_rand_act_speed(BoId)
      end,
  lists:foreach(F, L).



% %% 重算各单位的乱敏
% recalc_bo_tmp_rand_act_speed() ->
% 	L = get_all_bo_id_list(),
% 	F = fun(BoId) ->
% 			Bo = get_bo_by_id(BoId),
% 			?ASSERT(Bo /= null, BoId),
% 			Val = lib_bt_calc:calc_tmp_rand_act_speed_once(Bo),
% 			?ASSERT(is_integer(Val), Val),
% 			lib_bo:set_tmp_rand_act_speed(BoId, Val)
% 		end,
% 	lists:foreach(F, L).




%% 重新设置当前的行动者列表
reset_cur_actor_list() ->
  L = get_all_bo_id_list(),
  lib_bt_dict:set_cur_actor_list(L).


%% 找出出手速度最高的bo
find_highest_act_speed_from(BoIdList) ->
  %%新增了速度干扰,每次都重新再算一次
  F =
    fun(X) ->
      Bo = get_bo_by_id(X),

      BuffSquential = case lib_bo:find_buff_by_name(Bo,?BFN_ADD_ACT_SPEED_SEQ) of
                        null ->
                          0;
                        BeProtBuff ->
                          BuffData = data_buff:get(BeProtBuff#bo_buff.buff_no),
                          BuffData#buff_tpl.para
                      end,
      case lib_bo:is_using_normal_att(Bo) orelse lib_bo:get_cur_skill_cfg(Bo) == null of
        true ->  % 表示普通攻击
          Bo2 =
            Bo#battle_obj{
              tmp_status =Bo#battle_obj.tmp_status#bo_tmp_stat{bo_act_speed = BuffSquential}
            },
          lib_bt_comm:update_bo(Bo2);
        false ->
          CurSklCfg = lib_bo:get_cur_skill_cfg(Bo),
          ?DEBUG_MSG("wjctestSpeed ~p~n",[{CurSklCfg,Bo,11111111111111,CurSklCfg#skl_cfg.sequential_interference}]),

          SequentialInterference =
            case lib_bo:can_use_skill_on_real_act(Bo, CurSklCfg) of
              true ->
                max(CurSklCfg#skl_cfg.sequential_interference,BuffSquential);
              {false, _} ->
                BuffSquential
            end,
          Bo2 =
            Bo#battle_obj{
              tmp_status =Bo#battle_obj.tmp_status#bo_tmp_stat{bo_act_speed = SequentialInterference}
            },
          lib_bt_comm:update_bo(Bo2)
      end
    end,
  lists:foreach(F,BoIdList),
  ?ASSERT(BoIdList /= []),
  BoIdList2 = sort_bo_list_by_act_speed_desc(BoIdList),
  ?DEBUG_MSG("wjcTestspeed3 ~p~n",[BoIdList2]),
  erlang:hd(BoIdList2).



% %% 重新计算和排列当前回合的行动者列表
% reorder_cur_actor_list() ->
% 	L = get_all_bo_id_list(), %%get_bo_id_list(?HOST_SIDE) ++ get_bo_id_list(?GUEST_SIDE),
% 	% F = fun(BoId_A, BoId_B) ->
% 	% 		A = get_bo_by_id(BoId_A),
% 	% 		B = get_bo_by_id(BoId_B),
% 	% 		?BT_LOG(io_lib:format("reorder_cur_actor_list(), BoId:~p, TotalActSpeed:~p, RawActSpeed:~p, TmpRandActSpeed:~p~n",
% 	% 								[BoId_A, lib_bo:get_act_speed(A),  A#battle_obj.attrs#attrs.act_speed, lib_bo:get_tmp_rand_act_speed(A)])),
% 	% 		lib_bo:get_act_speed(A) > lib_bo:get_act_speed(B)
% 	% 	end,
% 	% L2 = lists:sort(F, L),

% 	L2 = sort_bo_list_by_act_speed_desc(L),

% 	?BT_LOG(io_lib:format("reorder_cur_actor_list(), CurRound=~p, L=~p, L2=~p~n", [lib_bt_comm:get_cur_round(), L, L2])),
% 	lib_bt_dict:set_cur_actor_list(L2).



%% 依据出手速度降序排序bo列表（注：按策划的需求，昏睡的bo固定排在非昏睡的bo的后面）
sort_bo_list_by_act_speed_desc(BoIdList) ->
  F = fun(BoId_A, BoId_B) ->
    A = get_bo_by_id(BoId_A),
    B = get_bo_by_id(BoId_B),
    ?DEBUG_MSG("wjctestspeed2 ~p~n",[{{A#battle_obj.tmp_status#bo_tmp_stat.bo_act_speed,A#battle_obj.id},{B#battle_obj.tmp_status#bo_tmp_stat.bo_act_speed,B#battle_obj.id}}]),
    ?BT_LOG(io_lib:format("sort_bo_list_by_act_speed_desc(), BoId:~p, TotalActSpeed:~p, RawActSpeed:~p, TmpRandActSpeed:~p~n",
      [BoId_A, lib_bo:get_act_speed(A),  A#battle_obj.attrs#attrs.act_speed, lib_bo:get_tmp_rand_act_speed(A)])),
    %%% lib_bo:get_act_speed(A) > lib_bo:get_act_speed(B)

    IsDeadOrCannotActByTrance_A = lib_bo:cannot_act_by_trance(A),
    IsDeadOrCannotActByTrance_B = lib_bo:cannot_act_by_trance(B),

    case (not IsDeadOrCannotActByTrance_A) andalso IsDeadOrCannotActByTrance_B of
      true ->
        true;
      false ->
        case IsDeadOrCannotActByTrance_A andalso (not IsDeadOrCannotActByTrance_B) of
          true ->
            false;
          false ->
            case A#battle_obj.tmp_status#bo_tmp_stat.bo_act_speed  ==   B#battle_obj.tmp_status#bo_tmp_stat.bo_act_speed of
              true ->
                lib_bo:get_act_speed(A) > lib_bo:get_act_speed(B);
              false ->
                A#battle_obj.tmp_status#bo_tmp_stat.bo_act_speed  >  B#battle_obj.tmp_status#bo_tmp_stat.bo_act_speed
            end
    end
      end
    end,
  lists:sort(F, BoIdList).




%% 记录各单位的保护信息
record_bo_protecting_info() ->
  L = get_all_bo_id_list(),
  F = fun(BoId) ->
    Bo = get_bo_by_id(BoId),
    ?ASSERT(Bo /= null, BoId),
    case lib_bo:get_cmd_type(Bo) of
      ?CMD_T_PROTECT ->
        Protege_BoId = lib_bo:get_cur_pick_target(Bo),

        ?BT_LOG(io_lib:format("record_bo_protecting_info(), Protege_BoId=~p, Protector_BoId=~p~n", [Protege_BoId, ?BOID(Bo)])),
        lib_bo:add_regular_protector(Protege_BoId, ?BOID(Bo));
      _ ->
        ?BT_LOG(io_lib:format("record_bo_protecting_info(), BoId=~p, CmdType=~p~n", [?BOID(Bo), lib_bo:get_cmd_type(Bo)])),
        skip
    end
      end,
  lists:foreach(F, L).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 针对所有战斗对象的特定被动效果处理，递归所有战斗对象进入下一层进行处理，不要按被动效果名称来处理，判断条件类型和条件值是否达到触发条件来处理效果就可以了，方便策划扩展新的组合效果
handle_passi_buff_list(TriggerType) ->
	BoIdList = get_all_bo_id_list(),
	Fun = fun(BoId) ->
				  Bo = get_bo_by_id(BoId),
				  handle_passi_buff(Bo, TriggerType)
		  end,
	lists:foreach(Fun, BoIdList).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 针对单个战斗对象的被动效果处理，检查对象列表的在上层递归一下进来，不要按被动效果名称来处理，判断条件类型和条件值是否达到触发条件来处理效果就可以了，方便策划扩展新的组合效果
handle_passi_buff(Bo, TriggerType) ->
	% 获取同类型的被动效果列表
	 PassiEffs = lib_bo:get_passi_effs(Bo, TriggerType),
	 handle_passi_buff(Bo, TriggerType, PassiEffs).


handle_passi_buff(Bo, TriggerType, [PassiEff|PassiEffs]) ->
	do_handle_passi_buff(Bo, PassiEff),
	handle_passi_buff(Bo, TriggerType, PassiEffs);


handle_passi_buff(Bo, TriggerType, []) ->
	Bo.


%% BUFF目标行动时存在指定层数的指定BUFF时加BUFF
%% do_handle_passi_buff(Bo, ?EN_ACTIVE_ACTION_BEGIN_BUFF_LAYER) ->
%% 	ok;
%% 
%% % 当敌方存活单位数量达到条件时触发向特定对象施加buff
%% do_handle_passi_buff(Bo, ?EN_ACTIVE_ACTION_BEGIN_ENEMY_ALIVE) ->
%% 	ok;
%% 
%% % 当敌方阵亡单位数量达到条件时触发向特定对象施加buff
%% do_handle_passi_buff(Bo, ?EN_ACTIVE_ACTION_BEGIN_ENEMY_DEAD) ->
%% 	ok;
%% 
%% % 当友方存活单位数量达到条件时触发向特定对象施加buff
%% do_handle_passi_buff(Bo, ?EN_ACTIVE_ACTION_BEGIN_SELF_ALIVE) ->
%% 	ok;
%% 
%% % 当友方阵亡单位数量达到条件时触发向特定对象施加buff
%% do_handle_passi_buff(Bo, ?EN_ACTIVE_ACTION_BEGIN_SELF_DEAD) ->
%% 	ok;

 
do_handle_passi_buff(_Bo, _Buff) ->
	ok.




%% 处理一回合的战斗行为
%% 对攻击列表中的玩家进行循环攻击操作
handle_one_round_actions() ->
	%% 处理存活单位身上的回合开始前触发的被动buff效果
%% 	TriggerType = 1,
%% 	handle_passi_buff_list(TriggerType),
	do_handle_one_round_actions().

do_handle_one_round_actions() ->
  case is_battle_finish() of  % 战斗是否已结束，战斗结束表明该场战斗即将被终止
    true ->
      schedule_battle_finish();
    false ->
      case lib_bt_dict:should_cur_round_force_finish() of
        true ->  % 强行结束
          ?BT_LOG(io_lib:format("round force finish! cur round:~p~n", [lib_bt_comm:get_cur_round()])),
          round_finish();
        false ->
          CurActorList = lib_bt_dict:get_cur_actor_list(),   % get(aer_list_this_half_turn), % 当前半回合内等待出手的战斗对象id列表
          case CurActorList == [] of
            true ->  % 当前回合已处理完毕
              round_finish();
            false ->
              CurActorId = find_highest_act_speed_from(CurActorList),    %%erlang:hd(CurActorList),  %%[CurAerId | _RemainAerList] = AerList,
              lib_bt_dict:set_cur_actor_id(CurActorId),

              %%CurAer = get_bo_by_id(CurAerId),
              %%lib_battle:sub_half_turn_aer(CurAerId),

              handle_bo_cmd(CurActorId),

              % 处理完后从行动列表删除
              lib_bt_dict:remove_bo_from_cur_actor_list(CurActorId),

              % 考虑： 需要clear_cur_actor() ???
              % ...

              do_handle_one_round_actions()  % 尾递归，循环处理当前回合的战斗
          end
      end
  end.



-ifdef(debug).
dbg_is_collected_reports_empty() ->
  get_collected_reports() =:= #cbrs{}.
-endif.


%% 处理单个bo的指令
%% @return: 无用
handle_bo_cmd(CurActorId) ->
%% 	?ASSERT(dbg_is_collected_reports_empty()),
  case is_bo_exists(CurActorId) of
    false ->  % bo不存在（死亡后消失、逃跑等原因导致），则不做处理
      io:format("wujianchengTestBattle ~p ~n", [{?LINE}]), skip;
    true ->
      CurActor = get_bo_by_id(CurActorId),
      ?ASSERT(CurActor /= null, CurActorId),
      %%判断行动时是否会触发被动buff
      case lib_bo:cannot_act(CurActor) of
        true ->  skip;
        false->
          %%行动前加buff
          BeEffList1 = lib_bo:find_passi_eff_by_name_all(CurActor , ?EN_ADD_BUFF_ACTION_FRIEND_SURVIVAL),
          BeEffList1_1 = [BeEffListSub1 || BeEffListSub1 <- BeEffList1, BeEffListSub1#bo_peff.judge_action_moment == 1 ],
          AddBuffDetail = lib_bo_buff:trigger_passi_buff_begin_friend_survival(CurActor, 0, BeEffList1_1),

          BeEffList2 = lib_bo:find_passi_eff_by_name_all(CurActor, ?EN_ADD_BUFF_ACTION_ENEMY_SURVIVAL),
          BeEffList1_2= [BeEffListSub2 || BeEffListSub2 <- BeEffList2, BeEffListSub2#bo_peff.judge_action_moment == 1 ],
          AddBuffDetail2 = lib_bo_buff:trigger_passi_buff_begin_enemy_survival(CurActor, 0, BeEffList1_2),

          %%这个是buff层数暂时不管
          BeEffList3 = lib_bo:find_passi_eff_by_name_all(CurActor , ?EN_BUFF_ARRIVE_LAYER),
          AddBuffDetail3 = lib_bo_buff:trigger_passi_buff_while_arrive_layer(CurActor,0, BeEffList3),

          NotifyFun =
            fun(X2) ->
              BuffsAdded = X2#update_buffs_rule_dtl.atter_buffs_added,
              NotifyDetailBuffFun =
                fun(X3) ->
                  lib_bt_send:notify_bo_buff_added(get_bo_by_id(X2#update_buffs_rule_dtl.bo_id), X3)
                end,
              lists:foreach(NotifyDetailBuffFun, BuffsAdded)
            end,
          lists:foreach(NotifyFun, AddBuffDetail ++ AddBuffDetail2 ++ AddBuffDetail3)

      end,

      % 强行PK将被控制将无法逃跑
      case lib_bo:get_cmd_type(CurActor) == ?CMD_T_ESCAPE of
        true -> % bo在任意状态下都可以逃跑
          State = get_battle_state(),
          case lib_bt_comm:is_force_pk_battle(State) of
            true ->
              case lib_bo:cannot_act(CurActor) of
                true -> skip;
                false-> do_handle_bo_cmd(CurActorId)
              end;
            false -> do_handle_bo_cmd(CurActorId)
          end;
        false ->
          case lib_bo:is_trance(CurActor) of  % 针对昏睡做特殊判定处理
            true ->
              case lib_bo:cannot_act_by_trance(CurActor) of
                true -> skip;
                false -> do_handle_bo_cmd(CurActorId)
              end;
            false ->
              case lib_bo:cannot_act(CurActor) of
                true ->  skip;
                false-> do_handle_bo_cmd(CurActorId)
              end
          end
      end
  end.


do_handle_bo_cmd(CurActorId) ->
  reinit_collected_reports(CurActorId),  % 重新初始化，以备重新收集

  try
    handle_bo_cmd__(CurActorId)
  catch
    throw: handle_bo_cmd_done ->  % 处理指令完毕
      %%put(?KN_JUST_FOR_DEBUG_I_CATCH_BO_ACTION_FINISH, true), % 标记进入过了此流程，仅仅是为了调试
      ok;
    throw: bo_nothing_to_do -> % bo当前回合放空，没事可做
      ok;
    throw: battle_finish -> % 战斗结束
      ok
  end,

  %%?ASSERT(get(?KN_JUST_FOR_DEBUG_I_CATCH_BO_ACTION_FINISH)),
  %%put(?KN_JUST_FOR_DEBUG_I_CATCH_BO_ACTION_FINISH, false),

  % 拼装、发送战报    TODO ：确认:在这里处理战报是否ok？？
  pack_and_send_battle_report(),

  % 发送后清空战报
  clear_collected_reports().



%% 是否需要强行转为普通攻击？
need_force_change_to_normal_att(Bo) ->
  case lib_bo:get_cmd_type(Bo) of
    ?CMD_T_NORMAL_ATT ->
      false;
    ?CMD_T_ESCAPE ->
      false;
    _ ->
      case
      lib_bo:is_chaos(Bo)
        orelse lib_bo:is_be_taunt(Bo)  % 被嘲讽时也强行转为普通攻击
        orelse lib_bo:is_force_auto_attack(Bo)  of
        true ->
          true;
        false ->
          case lib_bo:get_cmd_type(Bo) == ?CMD_T_DEFEND of
            true ->
              false;
            false ->
              lib_bo:is_silence(Bo)
      end
      end
  end.

%% 判断Bo是宠物并且身上有那个特定的buff   case lib_bo:find_buff_by_name(Bo, ?BFN_REVEVI_ONE_ROUND) of
need_force_change_to_escape(Bo) ->
  case lib_bt_comm:is_partner(Bo) of
    false -> false;
    true ->
      case lib_bo:find_buff_by_name(Bo, ?BFN_FORCE_PARTNER_ESCAPE) of
        null -> false;
        _ -> true
      end
  end.


handle_bo_cmd__(BoId) ->
  Bo = get_bo_by_id(BoId),
  case need_force_change_to_normal_att(Bo) of
    true ->
      update_collected_reports_real_cmd_type_and_para(?CMD_T_NORMAL_ATT, ?INVALID_INT_PARA),
      lib_bo:mark_force_change_to_normal_att(BoId),
      handle_bo_cmd(normal_attack, BoId);
    false ->
      case need_force_change_to_escape(Bo) of
        true ->
          update_collected_reports_real_cmd_type_and_para(?CMD_T_ESCAPE, ?INVALID_INT_PARA),
          handle_bo_cmd(escape, BoId);
        false ->
			%% 判断回合开始前触发机制的被动buff，是否需要做成按触发事件类型来处理？
%%         	TriggerType = 2,
%% 			handle_passi_buff(Bo, TriggerType),
          case lib_bo:get_cmd_type(Bo) of
            ?CMD_T_NORMAL_ATT ->
              handle_bo_cmd(normal_attack, BoId);
            ?CMD_T_USE_SKILL ->
              handle_bo_cmd(use_skill, BoId);
            ?CMD_T_USE_GOODS ->
              handle_bo_cmd(use_goods, BoId);
            ?CMD_T_ESCAPE ->
              handle_bo_cmd(escape, BoId);
            ?CMD_T_DEFEND ->
              do_nothing;
            ?CMD_T_PROTECT ->
              do_nothing;
            ?CMD_T_SUMMON_PARTNER ->
              handle_bo_cmd(summon_partner, BoId);
            ?CMD_T_CAPTURE_PARTNER ->
              handle_bo_cmd(capture_partner, BoId);
            ?CMD_T_SUMMON_MON ->
              handle_bo_cmd(summon_mon,BoId)
          end
      end
  end.



%% 处理指令：逃跑
%% TODO: 测试并确认 ---- 组队战斗中， 如果某玩家下线了，那么其留在战场上的对应bo以及其主宠bo是否可以依旧正常执行逃跑？？！！
handle_bo_cmd(escape, BoId) ->
  Bo = get_bo_by_id(BoId),
  case lib_bo:can_escape(Bo) of
    true ->
      handle_bo_escape(escape_success, Bo);
    false ->
      handle_bo_escape(escape_failed, Bo)
  end;

%% 处理指令：捕捉宠物
handle_bo_cmd(capture_partner, BoId) ->
  Bo = get_bo_by_id(BoId),
  % ?ASSERT(is_player(Bo), Bo),

  TargetBoId = lib_bo:get_cur_pick_target(Bo),
  TargetBo = get_bo_by_id(TargetBoId),

  % ?DEBUG_MSG("BoId=~p,Bo=~p,TargetBoId=~p,TargetBo=~p",[BoId,Bo,TargetBoId,TargetBo]),

  case TargetBo of
    null -> skip;

    _ ->
      MonNo = lib_bo:get_parent_obj_id(TargetBo),
      BMonTpl = lib_Bmon_tpl:get_tpl_data(MonNo),

      ?DEBUG_MSG("MonNo=~p,can_be_capture=~p",[MonNo,lib_Bmon_tpl:can_be_captured(BMonTpl)]),

      case lib_Bmon_tpl:can_be_captured(BMonTpl) of
        % 可以捕捉
        1 ->
          Hit = erlang:min( (lib_bo:get_lv(Bo) * 0.3) / lib_bo:get_lv(TargetBo),1),

          case util:decide_proba_once(Hit) of
            fail -> lib_bt_send:notify_bo_capture_to_all(BoId,TargetBoId,?RES_FAIL);
            success ->
              lib_bt_send:notify_bo_capture_to_all(BoId,TargetBoId,?RES_OK) ,
              lib_bt_dict:remove_bo_from_battle_field(TargetBoId)
          end;
        % 不可以捕捉
        __ -> lib_bt_send:notify_bo_capture_to_all(BoId,TargetBoId,?RES_FAIL)
      end

  end,

  void;


%% 处理指令：召唤怪物
handle_bo_cmd(summon_mon, BoId) ->
  Bo = get_bo_by_id(BoId),
  % ?ASSERT(is_monster(Bo), Bo),

  MonL = lib_bo:get_cmd_para(Bo),
  ?TRACE("handle_bo_cmd() summon_mon, MonL=~p~n", [MonL]),

  F = fun({BtlMonNo, Pos}, AccNewBoList) ->
    Pos2 = lib_bt_misc:cfg_pos_to_server_logic_pos(Pos),
    case lib_bt_misc:add_one_monster(BtlMonNo, ?GUEST_SIDE, Pos2,[]) of
      {ok, NewBo} ->
        lib_bt_send:notify_cli_new_bo_spawned(NewBo),
        [NewBo | AccNewBoList];
      fail ->
        AccNewBoList
    end
      end,

  lists:foldl(F, [], MonL);


%% 处理指令：召唤宠物
handle_bo_cmd(summon_partner, BoId) ->
  Bo = get_bo_by_id(BoId),
  ?ASSERT(is_player(Bo), Bo),
  TargetParId = lib_bo:get_cmd_para(Bo),
  ?ASSERT(is_integer(TargetParId), TargetParId),

  TargetParObj =  case is_hired_player(Bo) of
                    true ->
                      mod_offline_data:get_offline_bo(TargetParId, ?OBJ_PARTNER, ?SYS_HIRE);
                    false ->
                      lib_partner:get_partner(TargetParId)
                  end,

  ?ASSERT(is_record(TargetParObj, partner) orelse is_record(TargetParObj, offline_bo) orelse TargetParObj == null),

  case TargetParObj of
    null ->
      ?DEBUG_MSG("handle_bo_cmd(summon_partner, ..), TargetParObj is null!! BoId=~p, TargetParId=~p, Bo=~w", [BoId, TargetParId, Bo]),
      skip;
    _ ->
      case lib_bt_cmd:handle_bo_summon_partner(Bo, TargetParObj) of
        {ok, SummonDtl} ->
          lib_bo:incr_acc_summon_par_times(BoId),
          Action = #boa_summon{
            actor_id = BoId,
            result = ?RES_OK,
            details = SummonDtl
          },
          collect_battle_report(boa_summon, Action);
        {fail, is_under_control} ->  % 直接skip，目前不做提示
          skip;
        {fail, _Reason} ->
          % Tips = lib_bt_tips:build_tips(summon_partner_failed, [BoId, TargetParId, Reason]),
          % ?ASSERT(is_record(Tips, btl_tips)),
          % collect_battle_report(tips, Tips)

          Action = #boa_summon{
            actor_id = BoId,
            result = ?RES_FAIL
          },
          collect_battle_report(boa_summon, Action)
      end
  end;


%% 处理指令：普通攻击
handle_bo_cmd(normal_attack, BoId) ->
  Bo = get_bo_by_id(BoId),

  case decide_att_targets_for_normal_att(Bo) of
    [] ->
      throw(bo_nothing_to_do);
    TargetBoIdList ->
      ?ASSERT(is_list(TargetBoIdList), TargetBoIdList),
      TargetBoId = erlang:hd(TargetBoIdList),  % 选第一个
      do_normal_attack(BoId, TargetBoId)
  end;

%% 处理指令：使用技能
handle_bo_cmd(use_skill, BoId) ->
  Bo = get_bo_by_id(BoId),
  case lib_bo:is_using_normal_att(Bo) of
    true ->  % 表示普通攻击
      % ?ASSERT(false, Bo),
      skip;
    false ->
      CurSklCfg = lib_bo:get_cur_skill_cfg(Bo),
      ?ASSERT(CurSklCfg /= null, Bo),

      case lib_bo:can_use_skill_on_real_act(Bo, CurSklCfg) of
        true ->
          % 先扣消耗，再使用，最后再记录技能的cd
          lib_bo:apply_use_skill_costs(BoId, CurSklCfg),
          do_use_skill(Bo),
          case is_bo_exists(BoId) of  % 使用技能的过程中，bo有可能被弹死并且被清除，故这里要加此判断！
            true -> lib_bo:update_skill_cd_info(BoId, CurSklCfg);
            false -> skip
          end;
        {false, Reason} ->
          ?DEBUG_MSG("handle_bo_cmd Reason ~p",[Reason]),
          case Reason of
            skill_effs_target_empty ->
              skip;  % 目前不针对此情况做提示，故skip  -- huangjf
            {need_pre_buff,SkillNo} ->
              % 需要前置BUFF 暂时只有变身
              % 修改当前释放的技能为变身
              CurSklCfg2 = mod_skill:get_cfg_data(SkillNo),
              Bo2 = lib_bo:prepare_cmd_use_skill( BoId, SkillNo, lib_bo:get_cur_att_target(Bo)),

              update_collected_reports_real_cmd_type_and_para(?CMD_T_USE_SKILL, SkillNo),
              handle_bo_cmd(use_skill, BoId);
            % ?DEBUG_MSG("set_cur_skill_brief ~p",[CurSklCfg2]),
            % lib_bo:apply_use_skill_costs(BoId, CurSklCfg2),

            % do_use_skill(Bo2),
            % case is_bo_exists(BoId) of  % 使用技能的过程中，bo有可能被弹死并且被清除，故这里要加此判断！
            % 	true -> lib_bo:update_skill_cd_info(BoId, CurSklCfg2);
            % 	false -> skip
            % end;
            _ ->
              Tips = lib_bt_tips:build_cannot_use_skill_tips(Bo, CurSklCfg, Reason),
              ?BT_LOG(io_lib:format("cannot use skill tips: ~w, BoId:~p~n", [Tips, BoId])),
              collect_battle_report(tips, Tips)
          end,

          NeedNormalATT = case Reason of
                            {need_pre_buff,_} -> false;
                            _ -> true
                          end,

          % 使用失败则转为普通攻击
          if
            NeedNormalATT ->
              ?BT_LOG(io_lib:format("use skill failed and force change to normal att, BoId:~p, SkillId:~p~n", [BoId, mod_skill:get_id(CurSklCfg)])),
              update_collected_reports_real_cmd_type_and_para(?CMD_T_NORMAL_ATT, ?INVALID_INT_PARA),
              lib_bo:mark_force_change_to_normal_att(BoId),
              handle_bo_cmd(normal_attack, BoId);
            true ->
              skip
          end
      end
  end;

%% 处理指令：使用物品
handle_bo_cmd(use_goods, BoId) ->
  Bo = get_bo_by_id(BoId),
  GoodsId = lib_bo:get_cmd_para(Bo),
  TargetBoId = lib_bo:get_cur_pick_target(Bo),
  case lib_bt_goods:check_use_goods_on_bo(Bo, GoodsId, TargetBoId) of
    {fail, _, is_under_control} -> % 使用者处于控制状态（冰冻，昏睡...），目前直接skip，不做提示
      skip;
    {fail, _, no_such_goods} -> % 物品不存在，目前直接skip，不做提示
      skip;
    {fail, Goods, Reason} ->  % 注意：如果程序出bug，则Goods有可能为null
      Tips = lib_bt_tips:build_use_goods_failed_tips(Bo, Goods, TargetBoId, Reason),
      ?BT_LOG(io_lib:format("use goods failed, tips: ~w, BoId:~p~n", [Tips, BoId])),
      collect_battle_report(tips, Tips);
    {ok, Goods} ->
      case lib_bt_goods:use_goods_on_bo(Bo, Goods, TargetBoId) of
        do_nothing ->
          ?ASSERT(false, {TargetBoId, Bo, Goods}),
          skip;
        {ok, UseGoodsDtl} ->
          ?ASSERT(is_record(UseGoodsDtl, use_goods_dtl)),

          % 重新获取，以保证是最新的
          Bo2 = get_bo_by_id(BoId),

          % 扣除物品
          OwnerPlayerBo = lib_bt_misc:find_my_owner_player_bo(Bo2),
          OwnerPlayerId = lib_bo:get_parent_obj_id(OwnerPlayerBo),
          UseCount = 1,  % 目前都是固定使用1个

          %删除物品
          gen_server:cast( player:get_pid(OwnerPlayerId), {'destroy_goods_WNC', Goods, UseCount} ),

          % 更新bo的物品信息
          lib_bo:update_goods_info_after_use(?BOID(OwnerPlayerBo), GoodsId, UseCount),

          % 收集战报
          Action = #boa_use_goods{
            actor_id = BoId,
            details = UseGoodsDtl
          },
          collect_battle_report(boa_use_goods, Action)
      end
  end.

%% TODO: 以后添加处理怪物逃跑的情况
handle_bo_escape(escape_success, Bo) ->
  ?TRACE("handle_bo_escape(), escape_success, BoId=~p...~n", [?BOID(Bo)]),
  case lib_bo:get_type(Bo) of
    ?OBJ_PLAYER ->
      bo_escape(player, Bo);
    ?OBJ_HIRED_PLAYER ->
      bo_escape(hired_player, Bo);
    ?OBJ_PARTNER ->
      bo_escape(partner, Bo);
    ?OBJ_MONSTER ->
      bo_escape(monster, Bo);
    ?OBJ_NORMAL_BOSS ->
      bo_escape(monster, Bo);
    _Any ->
      ?ASSERT(false, _Any),
      skip
  end,
  post_bo_escape(Bo),
  throw(handle_bo_cmd_done);

handle_bo_escape(escape_failed, Bo) ->
  ?TRACE("handle_bo_escape(), escape_failed, BoId=~p...~n", [?BOID(Bo)]),
  Action = build_action_escape_failed(Bo),
  collect_battle_report(boa_escape, Action),
  throw(handle_bo_cmd_done).



%% 玩家逃跑
bo_escape(player, Bo) ->
  ?ASSERT(is_player(Bo), Bo),

  % 先收集战报
  Action = build_action_escape_success(Bo),
  collect_battle_report(boa_escape, Action),

  BoId = lib_bo:id(Bo),

  % 处理宠物跟随主人逃跑
  F = fun(MyParBoId) ->
    ?BT_LOG(io_lib:format("partner follow escape, PlayerBoId=~p, MyParBoId=~p~n", [BoId, MyParBoId])),
    MyParBo = get_bo_by_id(MyParBoId),
    ?ASSERT(MyParBo /= null, {MyParBoId, Bo}),
    bo_escape(partner, MyParBo)
      end,
  MyParBoIdList = lib_bo:find_my_existing_par_bo_id_list(Bo),
  ?BT_LOG(io_lib:format("bo_escape(), PlayerBoId=~p, MyParBoIdList=~p~n", [BoId, MyParBoIdList])),
  lists:foreach(F, MyParBoIdList),

  BtlState = get_battle_state(),
  battle_feedback(to_monster,BtlState),
  case BtlState#btl_state.subtype =:= 15 orelse BtlState#btl_state.subtype =:= 14 of
    true ->
      PlayeId = Bo#battle_obj.parent_obj_id,
      ets:insert(ets_3v3_escape, {PlayeId, 1}),
      lib_pvp:update_pvp_player_info_from_battle(PlayeId, 2, 0, 0,[],0);
    false ->
      skip
  end,


  % % 拼装、发送战报 -- 这里不按正常流程来，而是在这里就提前主动发送逃跑的战报， 是因为希望玩家从战场中被移除之前就通知他，否则，从战场中移除玩家后，战报无法通知到他
  % pack_and_send_battle_report(),
  % % 发送后清空战报
  % clear_collected_reports(),

  % 从战场中移除玩家
  lib_bt_dict:remove_bo_from_battle_field(BoId),

  % 勿忘：对于在线玩家，做逃跑后的必要处理（如：重置为空闲，重置计步器）
  ?Ifc (is_online(Bo))
  PlayerId = lib_bo:get_parent_obj_id(Bo),
Pid = player:get_pid(PlayerId),
BtlFeedback = lib_bt_misc:build_battle_feedback_for_escaped_bo(Bo),
gen_server:cast(Pid, {'after_escape_from_battle', BtlFeedback})
?End;



%% 雇佣玩家逃跑
bo_escape(hired_player, Bo) ->
?ASSERT(is_hired_player(Bo), Bo),

% 先收集战报
Action = build_action_escape_success(Bo),
collect_battle_report(boa_escape, Action),

BoId = lib_bo:id(Bo),

% 处理其主宠跟随逃跑
case lib_bo:get_my_main_partner_bo(Bo) of
null ->
skip;
MainParBo ->
?BT_LOG(io_lib:format("partner follow escape, HiredPlayerBoId=~p, MainParBoId=~p~n", [BoId, ?BOID(MainParBo)])),
bo_escape(partner, MainParBo)
end,

% 从战场中移除雇佣玩家
lib_bt_dict:remove_bo_from_battle_field(BoId),

% 通知玩家进程
OwnerPlayerBoId = lib_bo:get_my_owner_player_bo_id(Bo),
OwnerPlayerBo = get_bo_by_id(OwnerPlayerBoId),
OwnerPlayerId = lib_bo:get_parent_obj_id(OwnerPlayerBo),
Pid = player:get_pid(OwnerPlayerId),
gen_server:cast(Pid, {'after_my_hired_player_escape_from_battle'});



%% 宠物逃跑
bo_escape(partner, Bo) ->
?ASSERT(is_partner(Bo), Bo),
% 收集战报
Action = build_action_escape_success(Bo),
collect_battle_report(boa_escape, Action),

BoId = lib_bo:id(Bo),
% Side = lib_bo:get_side(Bo),

% 从战场中移除宠物
lib_bt_dict:remove_bo_from_battle_field(BoId),

case lib_bo:get_my_owner_player_bo(Bo) of
null ->
skip;
OwnerPlayerBo ->
case is_online(OwnerPlayerBo)
andalso (not is_hired_player(OwnerPlayerBo)) of
true ->
PartnerId = lib_bo:get_parent_obj_id(Bo),
OwnerPlayerId = lib_bo:get_parent_obj_id(OwnerPlayerBo),
Pid = player:get_pid(OwnerPlayerId),
gen_server:cast(Pid, {'after_my_partner_escape_from_battle', PartnerId});
false ->
skip
end
end;
% ?Ifc (is_partner(Bo))
% 	PartnerId = lib_bo:get_parent_obj_id(Bo),
% 	lib_partner:mark_idle(PartnerId)
% ?End,


%% 怪物逃跑
bo_escape(monster, Bo) ->
?ASSERT(is_monster(Bo), Bo),
% 先收集战报
Action = build_action_escape_success(Bo),
collect_battle_report(boa_escape, Action),

BoId = lib_bo:id(Bo),

% 从战场中移除
lib_bt_dict:remove_bo_from_battle_field(BoId).




%% bo逃跑后，处理战斗是否结束
post_bo_escape(EscapedBo) ->
  _BoId = lib_bo:id(EscapedBo),

  % ?DEBUG_MSG("lib_bo:get_side(EscapedBo) =~p",[lib_bo:get_side(EscapedBo)]),
  % % 怪物一定是客队
  Side = lib_bo:get_side(EscapedBo),

  ?DEBUG_MSG("Side =~p,is_monster=~p,[~p]",[Side,is_monster(EscapedBo),get_bo_id_list(Side)]),

  case get_bo_id_list(Side) of
    [] ->  % 进入此分支的另一个可能性是：怪物方的怪物都跑光了
      ?BT_LOG(io_lib:format("post_bo_escape(), EscapedBoId=~p, BoType=~p, Side=~p... there is not any bo at my side, so schedule battle finish~n", [_BoId, lib_bo:get_type(EscapedBo), Side])),
      set_win_side( to_enemy_side(Side)),
      mark_battle_finish();
    List ->
      % 判断是否是怪物 若果是怪物则不过滤掉只是玩家的列表
      L = case is_monster(EscapedBo) of
            true -> List;
            _ -> get_online_player_bo_id_list(Side)
          end,

      case lib_bt_comm:are_all_dead(Side)
        orelse lib_bt_comm:are_all_just_back_to_battle(L) of
        true ->
          ?BT_LOG(io_lib:format("post_bo_escape(), EscapedBoId=~p, BoType=~p, Side=~p... all are dead or just back to battle, so schedule battle finish~n", [_BoId, lib_bo:get_type(EscapedBo), Side])),
          set_win_side( to_enemy_side(Side)),
          mark_battle_finish();
        false ->
          case L of  %%get_player_bo_id_list(Side) of
            [] -> % 一方的在线玩家跑光了，则准备结束战斗
              ?BT_LOG(io_lib:format("post_bo_escape(), EscapedBoId=~p, BoType=~p, Side=~p... all online players of my side escaped, so schedule battle finish~n", [_BoId, lib_bo:get_type(EscapedBo), Side])),
              set_win_side( to_enemy_side(Side)),
              mark_battle_finish();
            %% schedule_battle_finish();  % 这里不需schedule战斗结束，因为上层处理回合行动的循环会检测战斗是否结束，故注释掉此行代码！
            _ ->
              ?BT_LOG(io_lib:format("post_bo_escape(), EscapedBoId=~p, BoType=~p, Side=~p... battle NOT finish yet!!!~n", [_BoId, lib_bo:get_type(EscapedBo), Side])),
              skip
          end
      end
  end.







build_action_escape_success(Bo) ->
  #boa_escape{
    bo = Bo, %%lib_bo:id(Bo),
    result = ?RES_OK
  }.


build_action_escape_failed(Bo) ->
  #boa_escape{
    bo = Bo, %%lib_bo:id(Bo),
    result = ?RES_FAIL
  }.






%% 拼装、发送战报
pack_and_send_battle_report() ->
  % CBRs: collected battle reports
  CBRs = get_collected_reports(),

  ?TRACE("pack_and_send_battle_report(), ReportList:~p~n", [CBRs#cbrs.report_list]),


  case CBRs#cbrs.report_list of
    [] ->  % 行为为空，则跳过
      skip;
    _ ->
      ?ASSERT(CBRs#cbrs.cur_actor_id == lib_bt_dict:get_cur_actor_id(), {CBRs#cbrs.cur_actor_id, lib_bt_dict:get_cur_actor_id()}),

      % Bin = pack_battle_report(CBRs),
      % lib_bt_send:send_battle_report(Bin)

      ReportList = lists:reverse(CBRs#cbrs.report_list),  % reverse一下，因为收集时是逆序的
      ReportList_List = grouping_report_list(ReportList),



      F = fun(ReportList__) ->
        ?ASSERT(ReportList__ /= []),
        ?ASSERT(  % 断言列表中所有战报的类型相同
          begin
            [__H | __T] = ReportList__,
            __ReportType = decide_report_type(__H),
            lists:duplicate(length(ReportList__), __ReportType) =:= [decide_report_type(X) || X <- ReportList__]
          end,
          ReportList__
        ),
        ReportType = decide_report_type( erlang:hd(ReportList__)),


        % % 调试验证，后面可以删掉
        % case ReportType of
        % 	?BR_T_BO_DO_PHY_ATT ->
        % 		F1111 = fun(Actn) ->
        % 					DamDtl = Actn#boa_do_phy_att.dam_details,
        % 					?BT_LOG(io_lib:format("pack_and_send_battle_report(), do phy att, atter_id=~p, defer_id=~p, dam_to_defer=~p, atter_hp_left=~p, defer_hp_left=~p~n",
        % 							[DamDtl#phy_dam_dtl.atter_id, DamDtl#phy_dam_dtl.defer_id, DamDtl#phy_dam_dtl.dam_to_defer,
        % 							 DamDtl#phy_dam_dtl.atter_hp_left, DamDtl#phy_dam_dtl.defer_hp_left]))
        % 				end,
        % 		[F1111(X) || X <- ReportList__];
        % 	_ ->
        % 		skip
        % end,




        ReportCount = length(ReportList__),
        ReportsDetails = build_reports_details(ReportList__),

        case ReportType of
          ?BR_T_BOS_FORCE_DIE ->  % 强行死亡通过20043协议（PT_BT_NOTIFY_BO_DIED）来发送
            ?ASSERT(ReportCount == 1, ReportCount),   % 注意：目前不会同时收集多个强行死亡的战报，故断言！ 如果要支持允许同时收集多个，则需调整相关代码！
            ?BT_LOG(io_lib:format("pack_and_send_battle_report(), BR_T_BOS_FORCE_DIE, ReportsDetails=~w~n", [ReportsDetails])),
            PackedReports_Bin = <<ReportsDetails/binary>>;
          ?BR_T_SEND_TIPS ->
            ?BT_LOG(io_lib:format("pack_and_send_battle_report(), BR_T_SEND_TIPS, ReportCount:~p, ReportsDetails=~w~n", [ReportCount, ReportsDetails])),
            PackedReports_Bin = <<ReportCount:16, ReportsDetails/binary>>;
          ?BR_T_BO_DO_SUMMON ->
            HeadBin = <<
              ((erlang:hd(ReportList__))#boa_summon.actor_id) : 16,
              0 : 8,   %%(lib_bo:get_cmd_type(CurActor)) : 8,
              (CBRs#cbrs.real_cmd_para) : 64,   %%(lib_bo:get_cmd_para(CurActor)) : 32,
              (CBRs#cbrs.cur_pick_target) : 16   %%(lib_bo:get_target_bo_id(CurActor)) : 16,
            >>,
            PackedReports_Bin = <<HeadBin/binary, ReportCount:16, ReportsDetails/binary>>;
          _ ->
            % 战报协议固定的头部
            HeadBin = <<
              (CBRs#cbrs.cur_actor_id) : 16,
              (CBRs#cbrs.real_cmd_type) : 8,   %%(lib_bo:get_cmd_type(CurActor)) : 8,
              (CBRs#cbrs.real_cmd_para) : 64,   %%(lib_bo:get_cmd_para(CurActor)) : 32,
              (CBRs#cbrs.cur_pick_target) : 16   %%(lib_bo:get_target_bo_id(CurActor)) : 16,
            >>,
            PackedReports_Bin = <<HeadBin/binary, ReportCount:16, ReportsDetails/binary>>
        end,

        lib_bt_send:send_battle_report(ReportType, PackedReports_Bin),

        % 补充发送逃跑战报给逃跑成功的玩家（因为玩家逃跑后，已从战场上移除，故上面的lib_bt_send:send_battle_report()并不会把战报发送给他）
        ?Ifc(ReportType == ?BR_T_BO_ESCAPE)
        lib_bt_send:send_br_to_escaped_player_bo(ReportList__, PackedReports_Bin)
?End
end,

lists:foreach(F, ReportList_List)
end.


%% 对战报列表分组： 遍历列表，把连续的、类型相同的战报归并为一组
%% @return: [ [战报1, 战报2, ...], ... ]    其中战报1和战报2是连续的同类型的战报
grouping_report_list(ReportList) ->
  [H | T] = ReportList,
  ReportType = decide_report_type(H),
  grouping_report_list(T, ReportType, [H], []).


grouping_report_list([CurReport | T], LastReportType, Acc_SameTypeReportList, Acc_ReportList_List) ->
  CurReportType = decide_report_type(CurReport),
  case CurReportType == LastReportType of
    true ->
      grouping_report_list(T, LastReportType, [CurReport | Acc_SameTypeReportList], Acc_ReportList_List);
    false ->
      grouping_report_list(T, CurReportType, [CurReport], [lists:reverse(Acc_SameTypeReportList) | Acc_ReportList_List])
  end;
grouping_report_list([], _LastReportType, Acc_SameTypeReportList, Acc_ReportList_List) ->
  ?ASSERT(Acc_SameTypeReportList /= []),
  L = [lists:reverse(Acc_SameTypeReportList) | Acc_ReportList_List],
  lists:reverse(L).


%% 判定战报类型
decide_report_type(Report) when is_record(Report, boa_do_phy_att) ->
  ?BR_T_BO_DO_PHY_ATT;
decide_report_type(Report) when is_record(Report, boa_do_mag_att) ->
  ?BR_T_BO_DO_MAG_ATT;
decide_report_type(Report) when is_record(Report, boa_cast_buffs) ->
  ?BR_T_BO_CAST_BUFFS;
decide_report_type(Report) when is_record(Report, boa_escape) ->
  ?BR_T_BO_ESCAPE;
decide_report_type(Report) when is_record(Report, boa_heal) ->
  ?BR_T_BO_DO_HEAL;
decide_report_type(Report) when is_record(Report, boa_force_die) ->
  ?BR_T_BOS_FORCE_DIE;
decide_report_type(Report) when is_record(Report, boa_use_goods) ->
  ?BR_T_BO_USE_GOODS;
decide_report_type(Report) when is_record(Report, boa_summon) ->
  ?BR_T_BO_DO_SUMMON;
decide_report_type(Report) when is_record(Report, br_send_tips) ->
  ?BR_T_SEND_TIPS.




% pack_battle_report(BtlReport) ->
% 	% BtlReport = get_collected_reports(),
% 	% ?ASSERT(BtlReport#cbrs.cur_actor_id == get_cur_actor_id(), {BtlReport#cbrs.cur_actor_id, get_cur_actor_id()}),
% 	%%CurActor = get_bo_by_id(get_cur_actor_id()),  % 注意：这里获取的CurActor有可能为null，因为可能被反弹死了，或者被反击死了！

% 	ReportList = lists:reverse(BtlReport#cbrs.report_list),  % 注意：reverse一下，因为收集时是逆序的

% 	ReportCount = length(ReportList),
% 	ReportsDetails = build_reports_details(ReportList),
% 	<<
% 		(BtlReport#cbrs.cur_actor_id) : 16,
% 		(BtlReport#cbrs.cmd_type) : 8,   %%(lib_bo:get_cmd_type(CurActor)) : 8,
% 		(BtlReport#cbrs.cmd_para) : 32,   %%(lib_bo:get_cmd_para(CurActor)) : 32,
% 		(BtlReport#cbrs.target_bo_id) : 16,   %%(lib_bo:get_target_bo_id(CurActor)) : 16,
% 		ReportCount : 16,
% 		ReportsDetails /binary
% 	>>.



build_reports_details(ReportList) ->
  build_reports_details__(ReportList, <<>>).


build_reports_details__([Report | T], AccDetails) ->
  ReportDetails = build_one_report_details(Report),
  AccDetails_2 = <<AccDetails/binary, ReportDetails/binary>>,
  build_reports_details__(T, AccDetails_2);
build_reports_details__([], AccDetails) ->
  AccDetails.



build_one_report_details(Report) ->
  ReportType = decide_report_type(Report),
  ?BT_LOG(io_lib:format("build_one_report_details, ReportType:~p~n", [ReportType])),
  build_one_report_details(ReportType, Report).


build_one_report_details(?BR_T_BO_DO_PHY_ATT, Action) ->  % bo执行物理攻击
  % when is_record(Action, boa_do_phy_att) -> % 执行物理攻击

  ?ASSERT(Action#boa_do_phy_att.att_type == ?ATT_T_PHY),

  DamDtl = Action#boa_do_phy_att.dam_details,

  lib_bt_util:dbg_check_phy_dam_details(DamDtl),


  AtterId = DamDtl#phy_dam_dtl.atter_id,
  DeferId = DamDtl#phy_dam_dtl.defer_id,
  ProtectorId = DamDtl#phy_dam_dtl.protector_id,

  F  = fun(BuffNo) -> <<BuffNo:32>> end,

  F2 = fun(BuffOwner_BoId, BuffNo) -> lib_bt_misc:build_buff_details(BuffOwner_BoId, BuffNo) end,

  F3 =
    fun({BoId, MultBuffs}) ->
      F4 =
        fun(BuffDetail) ->
          <<BuffDetail:32>>
        end,
      BuffDetailBin = list_to_binary([F4(X3) || X3 <- MultBuffs]),
      <<BoId:16, (length(MultBuffs)):16,  BuffDetailBin/binary >>
    end,

  F5 =
    fun({BoId, BuffNos}) ->
      F6 =
        fun(BuffDetail) ->
          lib_bt_misc:build_buff_details(BoId, BuffDetail)
        end,
      BuffDetailBin = list_to_binary([F6(X5) || X5 <- BuffNos]),

      ?DEBUG_MSG("wjcbufftest ~p~n",[{BuffNos, length(BuffNos),BoId, DamDtl}]),
      <<BoId:16, (length(BuffNos)):16,BuffDetailBin/binary >>
    end,

  F7 =
    fun({additional_dtl,BoId, Type,Dam_Hp,BoHpLeft,DieStaues,Reborn}) ->
      <<BoId:16, Type:8, Dam_Hp:32, BoHpLeft:32,DieStaues:8, Reborn:8>>
    end,


  BinDamDetail = list_to_binary( [F7(X) || X <- lists:reverse(DamDtl#phy_dam_dtl.additional_eff) ] ),

  BuffsAdded_Bin       = list_to_binary( [F5(X) || X <- DamDtl#phy_dam_dtl.atter_buffs_added] ),
  BuffsRemoved_Bin     = list_to_binary( [F3(X)  			|| X <- DamDtl#phy_dam_dtl.atter_buffs_removed] ),
  DeferBuffsUpdated_Bin     = list_to_binary( [F2(DeferId, X) || X <- DamDtl#phy_dam_dtl.defer_buffs_updated] ),
  ProtectorBuffsRemoved_Bin = list_to_binary( [F(X)  			|| X <- DamDtl#phy_dam_dtl.protector_buffs_removed] ),
  {ok, SplashInfoListBin}   = lib_bt_splash:pack_splash_dtl_list_bin(DamDtl#phy_dam_dtl.splash_dtl_list), % 封包溅射信息
  <<
    ?BR_T_BO_DO_PHY_ATT : 8,
    % (Action#boa_do_phy_att.att_type) : 8,
    (Action#boa_do_phy_att.att_subtype) : 8,
    (Action#boa_do_phy_att.att_result) : 8,

    AtterId : 16,
    DeferId : 16,
    ProtectorId : 16,

    (DamDtl#phy_dam_dtl.dam_to_defer) : 32/signed-integer,
    (DamDtl#phy_dam_dtl.dam_to_defer_mp) : 32/signed-integer,
    (DamDtl#phy_dam_dtl.dam_to_defer_anger) : 32/signed-integer,
    (DamDtl#phy_dam_dtl.dam_to_protector) : 32,
    (DamDtl#phy_dam_dtl.dam_to_protector_anger) : 32/signed-integer,
    (DamDtl#phy_dam_dtl.ret_dam) : 32,
    (DamDtl#phy_dam_dtl.ret_dam_anger) : 32/signed-integer,
    (DamDtl#phy_dam_dtl.absorbed_hp) : 32,

    (DamDtl#phy_dam_dtl.atter_hp_left) : 32,
    (DamDtl#phy_dam_dtl.atter_mp_left) : 32,
    (DamDtl#phy_dam_dtl.atter_anger_left) : 32,
    (DamDtl#phy_dam_dtl.atter_die_status) : 8,
    (util:bool_to_oz(DamDtl#phy_dam_dtl.is_atter_apply_reborn)) : 8,


    (DamDtl#phy_dam_dtl.defer_hp_left) : 32,
    (DamDtl#phy_dam_dtl.defer_mp_left) : 32,
    (DamDtl#phy_dam_dtl.defer_anger_left) : 32,
    (DamDtl#phy_dam_dtl.defer_die_status) : 8,
    (util:bool_to_oz(DamDtl#phy_dam_dtl.is_defer_apply_reborn)) : 8,

    (DamDtl#phy_dam_dtl.protector_hp_left) : 32,
    (DamDtl#phy_dam_dtl.protector_anger_left) : 32,
    (DamDtl#phy_dam_dtl.protector_die_status) : 8,
    (util:bool_to_oz(DamDtl#phy_dam_dtl.is_protector_apply_reborn)) : 8,

    (length(DamDtl#phy_dam_dtl.atter_buffs_added)) : 16,
    BuffsAdded_Bin /binary,
    (length(DamDtl#phy_dam_dtl.atter_buffs_removed)) : 16,
    BuffsRemoved_Bin /binary,

    (length(DamDtl#phy_dam_dtl.defer_buffs_updated)) : 16,
    DeferBuffsUpdated_Bin /binary,

    (length(DamDtl#phy_dam_dtl.protector_buffs_removed)) : 16,
    ProtectorBuffsRemoved_Bin /binary,
    (length( DamDtl#phy_dam_dtl.additional_eff)): 16,
    BinDamDetail/binary,
    (length(DamDtl#phy_dam_dtl.splash_dtl_list)) : 16,
    SplashInfoListBin /binary
  >>;


build_one_report_details(?BR_T_BO_DO_MAG_ATT, Action) -> % bo执行法术攻击
  % when is_record(Action, boa_do_mag_att) -> % 执行法术攻击

  ?ASSERT(Action#boa_do_mag_att.att_type == ?ATT_T_MAG),

  AtterId = Action#boa_do_mag_att.atter_id,

  F  = fun(BuffNo) -> <<BuffNo:32>> end,
  F2 = fun(BuffOwner_BoId, BuffNo) -> lib_bt_misc:build_buff_details(BuffOwner_BoId, BuffNo) end,


  F3 = fun(DamDtl) ->
    DeferId = DamDtl#mag_dam_dtl.defer_id,

    F3_1 =
      fun({BoId, MultBuffs}) ->
        F3_2 =
          fun(BuffDetail) ->
            <<BuffDetail:32>>
          end,
        BuffDetailBin = list_to_binary([F3_2(X) || X <- MultBuffs]),
        <<BoId:16, (length(MultBuffs)):16,  BuffDetailBin/binary >>
      end,

    F3_3 =
      fun({BoId, BuffNos}) ->
        F3_4 =
          fun(BuffDetail) ->
            lib_bt_misc:build_buff_details(BoId, BuffDetail)
          end,
        BuffDetailBin = list_to_binary([F3_4(X) || X <- BuffNos]),
        <<BoId:16, (length(BuffNos)):16,BuffDetailBin/binary >>
      end,

    F3_5 =
      fun({additional_dtl ,BoId, Type,Dam_Hp,BoHpLeft,DieStaues,Reborn}) ->
        <<BoId:16, Type:8, Dam_Hp:32, BoHpLeft:32,DieStaues:8, Reborn:8>>
      end,

    BinDamDetail = list_to_binary( [F3_5(X) || X <- lists:reverse(DamDtl#mag_dam_dtl.additional_eff)] ),

    AtterBuffsAdded_Bin   = list_to_binary( [F3_3(X) || X <- DamDtl#mag_dam_dtl.atter_buffs_added] ),
    AtterBuffsRemoved_Bin = list_to_binary( [F3_1(X) 			|| X <- DamDtl#mag_dam_dtl.atter_buffs_removed] ),
%%    DeferBuffsAdded_Bin     = list_to_binary( [F2(DeferId, X) || X <- DamDtl#mag_dam_dtl.defer_buffs_added] ),
%%    DeferBuffsRemoved_Bin   = list_to_binary( [F(X) 			|| X <- DamDtl#mag_dam_dtl.defer_buffs_removed] ),
    DeferBuffsUpdated_Bin   = list_to_binary( [F2(DeferId, X) || X <- DamDtl#mag_dam_dtl.defer_buffs_updated] ),
    <<
      DeferId : 16,
      (DamDtl#mag_dam_dtl.att_result) : 8,
      (DamDtl#mag_dam_dtl.dam_to_defer) : 32/signed-integer,
      (DamDtl#mag_dam_dtl.dam_to_defer_mp) : 32/signed-integer,
      (DamDtl#mag_dam_dtl.dam_to_defer_anger) : 32/signed-integer,
      (DamDtl#mag_dam_dtl.absorbed_hp) : 32,    %%吸血
      (DamDtl#mag_dam_dtl.atter_hp_left) : 32,
      (DamDtl#mag_dam_dtl.atter_mp_left) : 32,
      (DamDtl#mag_dam_dtl.atter_anger_left) : 32,
      (DamDtl#mag_dam_dtl.atter_die_status) : 8,
      (util:bool_to_oz(DamDtl#mag_dam_dtl.is_atter_apply_reborn)) : 8,

      (DamDtl#mag_dam_dtl.ret_dam) : 32,
      %(DamDtl#mag_dam_dtl.ret_dam_anger) : 32/signed-integer,

      (DamDtl#mag_dam_dtl.defer_hp_left) : 32,
      (DamDtl#mag_dam_dtl.defer_mp_left) : 32,
      (DamDtl#mag_dam_dtl.defer_anger_left) : 32,
      (DamDtl#mag_dam_dtl.defer_die_status) : 8,
      (util:bool_to_oz(DamDtl#mag_dam_dtl.is_defer_apply_reborn)) : 8,

      (length(DamDtl#mag_dam_dtl.atter_buffs_added)) : 16,
      AtterBuffsAdded_Bin /binary,
      (length(DamDtl#mag_dam_dtl.atter_buffs_removed)) : 16,
      AtterBuffsRemoved_Bin /binary,

%%      (length(DamDtl#mag_dam_dtl.defer_buffs_added)) : 16,
%%      DeferBuffsAdded_Bin /binary,
%%      (length(DamDtl#mag_dam_dtl.defer_buffs_removed)) : 16,
%%      DeferBuffsRemoved_Bin /binary,
      (length(DamDtl#mag_dam_dtl.defer_buffs_updated)) : 16,
      DeferBuffsUpdated_Bin /binary,
      (length( DamDtl#mag_dam_dtl.additional_eff)) :16,
      BinDamDetail/binary
    >>
       end,

  DamDtlList = Action#boa_do_mag_att.dam_dtl_list,
  DamDtl_Bin = list_to_binary( [F3(X) || X <- DamDtlList] ),



  F4 = fun(DamDtl, {Acc_AtterBuffsAdded, Acc_AtterBuffsRemoved}) ->
    AtterBuffsAdded=
      case lists:keyfind(AtterId, 1,  DamDtl#mag_dam_dtl.atter_buffs_added) of
      false ->
        [];
      {AtterId, BuffNoLists} ->
        BuffNoLists
    end,

    AtterBuffsMoved=
      case lists:keyfind(AtterId, 1,  DamDtl#mag_dam_dtl.atter_buffs_removed) of
        false ->
          [];
        {AtterId, BuffNoLists2} ->
          BuffNoLists2
      end,
    {Acc_AtterBuffsAdded ++ AtterBuffsAdded,
        Acc_AtterBuffsRemoved ++ AtterBuffsMoved}
       end,

  {AtterBuffsAdded, AtterBuffsRemoved} = lists:foldl(F4, {[], []}, DamDtlList),

  % TODO: 测试是否有bug？！

  % 去掉重复的
  AtterBuffsAdded2 = sets:to_list( sets:from_list(AtterBuffsAdded) ),
  AtterBuffsRemoved2 = sets:to_list( sets:from_list(AtterBuffsRemoved) ),

  % 求实际所添加的buff列表和所移除的buff列表
  AtterBuffsAdded_Actual = AtterBuffsAdded2 -- AtterBuffsRemoved2,
  AtterBuffsRemoved_Actual = AtterBuffsRemoved2 -- AtterBuffsAdded_Actual,

  AtterBuffsAdded_Bin   = list_to_binary( [F2(AtterId, X) || X <- AtterBuffsAdded_Actual] ),
  AtterBuffsRemoved_Bin = list_to_binary( [F(X) 			|| X <- AtterBuffsRemoved_Actual] ),

  % 封包溅射信息
  F5 = fun(DamDtl, Acc_SplashDtlList) ->
    lib_bt_splash:sum_two_splash_dtl_list(DamDtl#mag_dam_dtl.splash_dtl_list, Acc_SplashDtlList)
       end,
  MagSplashDtlList = lists:foldl(F5, [], DamDtlList),
  {ok, SplashInfoListBin} = lib_bt_splash:pack_splash_dtl_list_bin(MagSplashDtlList),

  <<
    ?BR_T_BO_DO_MAG_ATT : 8,
    (util:bool_to_oz(Action#boa_do_mag_att.is_combo_att)) : 8,
    AtterId : 16,
    (length(AtterBuffsAdded_Actual)) : 16,
    AtterBuffsAdded_Bin / binary,
    (length(AtterBuffsRemoved_Actual)) : 16,
    AtterBuffsRemoved_Bin / binary,
    (length(DamDtlList)) : 16,
    DamDtl_Bin / binary,

    (length(MagSplashDtlList)) : 16,
    SplashInfoListBin / binary
  >>;



build_one_report_details(?BR_T_BO_CAST_BUFFS, Action) -> % bo施法（释放或驱散buff）
  % when is_record(Action, boa_cast_buffs) -> % 施法（释放或驱散buff）

  % 此case语句为调试验证代码，以后可以删掉
  case Action#boa_cast_buffs.cast_result of
    ?RES_OK ->   ?ASSERT(Action#boa_cast_buffs.details_list /= [], Action);
    ?RES_FAIL -> ?ASSERT(Action#boa_cast_buffs.details_list == [], Action)
  end,

  ?BT_LOG(io_lib:format("build_one_report_details(?BR_T_BO_CAST_BUFFS,,   Action:~p~n", [Action])),


  F  = fun(BuffNo) -> <<BuffNo:32>> end,
  F2 = fun(BuffOwner_BoId, BuffNo) -> lib_bt_misc:build_buff_details(BuffOwner_BoId, BuffNo) end,
  F3 = fun(CastDtl) ->
    ?ASSERT(CastDtl#cast_buffs_dtl.caster_id == Action#boa_cast_buffs.caster_id),

    TargetBoId = CastDtl#cast_buffs_dtl.target_bo_id,

    BuffsAdded_Bin   = list_to_binary( [F2(TargetBoId, X) || X <- CastDtl#cast_buffs_dtl.buffs_added] ),
    BuffsRemoved_Bin = list_to_binary( [F(X) 			  || X <- CastDtl#cast_buffs_dtl.buffs_removed] ),
    BuffsUpdated_Bin = list_to_binary( [F2(TargetBoId, X) || X <- CastDtl#cast_buffs_dtl.buffs_updated] ),
    <<
      TargetBoId : 16,
      (length(CastDtl#cast_buffs_dtl.buffs_added)) : 16,
      BuffsAdded_Bin /binary,
      (length(CastDtl#cast_buffs_dtl.buffs_removed)) : 16,
      BuffsRemoved_Bin /binary,
      (length(CastDtl#cast_buffs_dtl.buffs_updated)) : 16,
      BuffsUpdated_Bin /binary
    >>
       end,

  CastDetails_Bin = list_to_binary( [F3(X) || X <- Action#boa_cast_buffs.details_list] ),

  <<
    ?BR_T_BO_CAST_BUFFS : 8,
    (Action#boa_cast_buffs.caster_id) : 16,
    (Action#boa_cast_buffs.cast_result) : 8,
    (Action#boa_cast_buffs.need_perf_casting) : 8,
    (Action#boa_cast_buffs.caster_hp_left) : 32,
    (Action#boa_cast_buffs.caster_mp_left) : 32,
    (Action#boa_cast_buffs.caster_anger_left) : 32,
    (length(Action#boa_cast_buffs.details_list)) : 16,
    CastDetails_Bin /binary
  >>;



build_one_report_details(?BR_T_BO_DO_HEAL, Action) -> % bo执行治疗
  % when is_record(Action, boa_cast_buffs) -> % 施法（释放或驱散buff）
  ?BT_LOG(io_lib:format("build_one_report_details, BR_T_BO_DO_HEAL, boa_heal.details_list:~w~n", [Action#boa_heal.details_list])),
  % 此case语句为调试验证代码，以后可以删掉
  case Action#boa_heal.cast_result of
    ?RES_OK ->   ?ASSERT(Action#boa_heal.details_list /= []);
    ?RES_FAIL -> ?ASSERT(Action#boa_heal.details_list == [])
  end,

  F  = fun(BuffNo) -> <<BuffNo:32>> end,
  F2 = fun(BuffOwner_BoId, BuffNo) -> lib_bt_misc:build_buff_details(BuffOwner_BoId, BuffNo) end,
  F3 = fun(HealDtl) ->
    TargetBoId = HealDtl#heal_dtl.target_bo_id,

    BuffsAdded_Bin   = list_to_binary( [F2(TargetBoId, X) || X <- HealDtl#heal_dtl.buffs_added] ),
    BuffsRemoved_Bin = list_to_binary( [F(X) 			  || X <- HealDtl#heal_dtl.buffs_removed] ),

    <<
      TargetBoId : 16,
      (util:bool_to_oz(HealDtl#heal_dtl.is_cannot_be_heal)) : 8,
      (HealDtl#heal_dtl.heal_value) : 32,
      (HealDtl#heal_dtl.new_hp) : 32,
      (HealDtl#heal_dtl.new_mp) : 32,
      (HealDtl#heal_dtl.new_anger) : 32,
      (length(HealDtl#heal_dtl.buffs_added)) : 16,
      BuffsAdded_Bin / binary,
      (length(HealDtl#heal_dtl.buffs_removed)) : 16,
      BuffsRemoved_Bin / binary
    >>
       end,

  HealDetails_Bin = list_to_binary( [F3(X) || X <- Action#boa_heal.details_list] ),

  <<
    ?BR_T_BO_DO_HEAL : 8,
    (util:bool_to_oz(Action#boa_heal.has_revive_eff)) : 8,
    (Action#boa_heal.heal_type) : 8,
    (Action#boa_heal.cast_result) : 8,
    (Action#boa_heal.healer_hp_left) : 32,
    (Action#boa_heal.healer_mp_left) : 32,
    (Action#boa_heal.healer_anger_left) : 32,
    (length(Action#boa_heal.details_list)) : 16,
    HealDetails_Bin /binary
  >>;



build_one_report_details(?BR_T_BOS_FORCE_DIE, Action) -> % 一或多个bo强行死亡
  F  = fun(BuffNo) -> <<BuffNo:32>> end,
  F2 = fun(Dtl) ->
    BuffsRemoved = Dtl#force_die_dtl.buffs_removed,
    BuffsRemoved_Bin = list_to_binary( [F(X) || X <- BuffsRemoved] ),
    <<
      (Dtl#force_die_dtl.bo_id) : 16,
      (Dtl#force_die_dtl.die_status) : 8,
      (length(BuffsRemoved)) : 16,
      BuffsRemoved_Bin / binary
    >>
       end,
  ForceDieDtl_Bin = list_to_binary( [F2(X) || X <- Action#boa_force_die.details_list] ),

  % 返回的二进制流格式和20043协议（PT_BT_NOTIFY_BO_DIED）对应！因为强行死亡是通过此协议发送给客户端
  <<
    (length(Action#boa_force_die.details_list)) : 16,
    ForceDieDtl_Bin /binary
  >>;


build_one_report_details(?BR_T_BO_ESCAPE, Action) -> % bo逃跑
  Bo = Action#boa_escape.bo,
  ?ASSERT(is_record(Bo, battle_obj), Action),
  BoId = lib_bo:id(Bo),
  <<
    ?BR_T_BO_ESCAPE : 8,
    BoId : 16,
    (Action#boa_escape.result) : 8
  >>;

build_one_report_details(?BR_T_BO_USE_GOODS, Action) -> % bo使用物品
  ?ASSERT(Action#boa_use_goods.actor_id == lib_bt_dict:get_cur_actor_id(), {Action#boa_use_goods.actor_id, lib_bt_dict:get_cur_actor_id()}),

  Dtl = Action#boa_use_goods.details,

  F  = fun(BuffNo) -> <<BuffNo:32>> end,
  F2 = fun(BuffOwner_BoId, BuffNo) -> lib_bt_misc:build_buff_details(BuffOwner_BoId, BuffNo) end,

  TargetBoId = Dtl#use_goods_dtl.target_bo_id,
  BuffsAdded_Bin   = list_to_binary( [F2(TargetBoId, X) || X <- Dtl#use_goods_dtl.buffs_added] ),
  BuffsRemoved_Bin = list_to_binary( [F(X) 			  || X <- Dtl#use_goods_dtl.buffs_removed] ),

  BuffsAddedMySelf_Bin   = list_to_binary( [F2(TargetBoId, X) || X <- Dtl#use_goods_dtl.buffs_added_myself] ),
  BuffsRemovedMySelf_Bin = list_to_binary( [F(X) 			  || X <- Dtl#use_goods_dtl.buffs_removed_myself] ),

  <<
    ?BR_T_BO_USE_GOODS : 8,
    (Dtl#use_goods_dtl.goods_id) : 64,
    (Dtl#use_goods_dtl.goods_no) : 32,
    (util:bool_to_oz(Dtl#use_goods_dtl.has_revive_eff)) : 8,
    TargetBoId : 16,
    (Dtl#use_goods_dtl.heal_val_hp) : 32,
    (Dtl#use_goods_dtl.heal_val_mp) : 32,
    (Dtl#use_goods_dtl.heal_val_anger) : 32,
    (Dtl#use_goods_dtl.hp_new) : 32,
    (Dtl#use_goods_dtl.mp_new) : 32,
    (Dtl#use_goods_dtl.anger_new) : 32,
    (length(Dtl#use_goods_dtl.buffs_added)) : 16,
    BuffsAdded_Bin / binary,
    (length(Dtl#use_goods_dtl.buffs_removed)) : 16,
    BuffsRemoved_Bin / binary,

    (length(Dtl#use_goods_dtl.buffs_added_myself)) : 16,
    BuffsAddedMySelf_Bin / binary,
    (length(Dtl#use_goods_dtl.buffs_removed_myself)) : 16,
    BuffsRemovedMySelf_Bin / binary
  >>;


build_one_report_details(?BR_T_BO_DO_SUMMON, Action) -> % bo执行召唤
%%  ?ASSERT(Action#boa_summon.actor_id == lib_bt_dict:get_cur_actor_id(), {Action#boa_summon.actor_id, lib_bt_dict:get_cur_actor_id()}),
  F = fun(NewBoId) ->
    ?ASSERT(is_bo_exists(NewBoId), {NewBoId, Action}),
    Bo = get_bo_by_id(NewBoId),
    NameBin = lib_bo:get_name(Bo),

    ParExtra_Bin = lib_bt_misc:build_partner_bo_extra_bin(Bo),
    IsMainPar = lib_bt_comm:is_main_partner(Bo),
    ?BT_LOG(io_lib:format("build_one_report_details(), NewBoId:~p, IsMainPar:~p", [NewBoId, IsMainPar])),

    {IsInvisible, InvisibleExpireRound} =
      case lib_bo:is_invisible(Bo) of
        true -> {true, lib_bo:get_invisible_expire_round(Bo)};
        false -> {false, 0}
      end,

    ShowingEqs = lib_bo:get_showing_equips(Bo),

    LookIdx = case is_monster(Bo) of
                true ->
                  lib_bo:get_look_idx(Bo);
                false ->
                  0
              end,

    F1 = fun(Buff) ->

      ?DEBUG_MSG("buffNo=~p,rand=~p",[(lib_bo_buff:get_no(Buff)) ,(lib_bo_buff:get_expire_round(Buff))]),

      <<
        (lib_bo_buff:get_no(Buff)) : 32,
        (lib_bo_buff:get_expire_round(Buff)) : 16
      >>
         end,
    BuffsInfo_List = [F1(X) || X <- lib_bo:get_buff_list(Bo)],
    BuffsInfo_Bin = list_to_binary(BuffsInfo_List),

    ?DEBUG_MSG("BLIST = ~p",[BuffsInfo_List]),
    % ?DEBUG_MSG("BuffsInfo_Bin = ~p",[BuffsInfo_Bin]),

    <<
      (lib_bo:get_id(Bo)) : 16,
      (lib_bo:get_side(Bo)) : 8,
      (lib_bo:get_type(Bo)) : 8,
      (lib_bo:get_my_owner_player_bo_id(Bo)) : 16,
      (lib_bo:get_pos(Bo)) : 8,
      (byte_size(NameBin)) : 16,
      NameBin / binary,
      (lib_bo:get_sex(Bo)) : 8,
      (lib_bo:get_race(Bo)) : 8,
      (lib_bo:get_faction(Bo)) : 8,
      (lib_bo:get_lv(Bo)) : 16,
      (lib_bo:get_parent_obj_id(Bo)) : 64,
      (lib_bo:get_parent_partner_no(Bo)) : 32,
      (lib_bo:get_hp(Bo)) : 32,
      (lib_bo:get_hp_lim(Bo)) : 32,
      (lib_bo:get_mp(Bo)) : 32,
      (lib_bo:get_mp_lim(Bo)) : 32,
      (lib_bo:get_anger(Bo)) : 32,
      (lib_bo:get_anger_lim(Bo)) : 32,
      ParExtra_Bin / binary,
      (util:bool_to_oz(IsMainPar)) : 8,
      (util:bool_to_oz(IsInvisible)) : 8,
      InvisibleExpireRound : 16,
      (ShowingEqs#showing_equip.weapon) : 32,
      (ShowingEqs#showing_equip.headwear) : 32,
      (ShowingEqs#showing_equip.clothes) : 32,
      (ShowingEqs#showing_equip.backwear) : 32,
      (lib_bo:get_phy_att(Bo)) :32,
      (lib_bo:get_mag_att(Bo)) :32,
      (lib_bo:get_phy_def(Bo)) :32,
      (lib_bo:get_mag_def(Bo)) :32,
      (lib_bo:get_heal_value(Bo)) :32,
      (length(BuffsInfo_List)) : 16,
      BuffsInfo_Bin / binary,
      LookIdx : 8
    >>
      end,

  case Action#boa_summon.result of
    ?RES_OK ->
      Dtl = Action#boa_summon.details,
      NewBoIdList = Dtl#summon_dtl.new_bo_id_list,
      SummonDtl_Bin = list_to_binary( [F(X) || X <- NewBoIdList] ),
      <<
        ?BR_T_BO_DO_SUMMON : 8,
        ?RES_OK : 8,
        (length(NewBoIdList)) : 16,
        SummonDtl_Bin / binary
      >>;
    ?RES_FAIL ->
      <<
        ?BR_T_BO_DO_SUMMON : 8,
        ?RES_FAIL : 8,
        0 : 16  % 空数组
      >>
  end;



build_one_report_details(?BR_T_SEND_TIPS, BR_SendTips) -> % 发送战斗提示
  Tips = BR_SendTips#br_send_tips.tips,
  % 返回的二进制流格式和PT_BT_TIPS协议对应！因为战斗提示是通过此协议发送给客户端
  <<
    (Tips#btl_tips.to_bo_id) : 16,
    (Tips#btl_tips.tips_code) : 32,
    (Tips#btl_tips.para1) : 32,
    (Tips#btl_tips.para2) : 32
  >>.








% void fsBattle::DoNormalAtk(stDoDamageDesc* desc)
% {
% #ifdef _DEBUG
% 	if(desc->pAtt->IsPlayerShadow())
% 	{
% 		INT D  =10;
% 	}
% #endif
% 	fsBattle::WuAtkTest(desc);
% 	if(desc->mAtkResult == ar_Hit)
% 	{
% 		fsBattle::GenNormalAttackDam(desc);
% 		fsBattle::DoWuDamageTo(desc);
% 		fsBattle::CheckEquipLostEndure(desc);

% 		//设置条件标记
% 		desc->pAtt->SetCondiFlag(flgPostCondiCheck_DoNormalAtk,TRUE);
% 		desc->pDef->SetCondiFlag(flgPostCondiCheck_BeNormalAtk,TRUE);
% 	}
% 	else if(desc->mAtkResult == ar_Dodge)
% 	{
% 		//设置条件标记
% 		desc->pDef->SetCondiFlag(flgPostCondiCheck_DodgeSuccess,TRUE);
% 	}
% }


%% 获取/设置当前已收集的战报
get_collected_reports() ->
  get(?KN_COLLECTED_REPORTS).

set_collected_reports(CollectedBtlRps) ->
  ?ASSERT(is_record(CollectedBtlRps, cbrs), CollectedBtlRps),
  put(?KN_COLLECTED_REPORTS, CollectedBtlRps).


update_collected_reports_real_cmd_type_and_para(RealCmdType, RealCmdPara) ->
  CBRs = get_collected_reports(),
  CBRs2 = CBRs#cbrs{
    real_cmd_type = RealCmdType,
    real_cmd_para = RealCmdPara
  },
  set_collected_reports(CBRs2).


reinit_collected_reports(CurActorId) ->
  CurActor = get_bo_by_id(CurActorId),

  case is_monster(CurActor) of
    true ->
      % 重新计算AI
      lib_bt_AI:bo_prepare_cmd_by_AI(CurActorId);
    false ->
      skip
  end,

  CurActor2 = get_bo_by_id(CurActorId),

  put(?KN_COLLECTED_REPORTS, #cbrs{
    cur_actor_id = CurActorId,
    cmd_type = lib_bo:get_cmd_type(CurActor2),
    cmd_para = lib_bo:get_cmd_para(CurActor2),
    real_cmd_type = lib_bo:get_cmd_type(CurActor2),
    real_cmd_para = lib_bo:get_cmd_para(CurActor2),
    cur_pick_target = lib_bo:get_cur_pick_target(CurActor2),
    report_list = []
  }).


init_collected_reports() ->
  put(?KN_COLLECTED_REPORTS, #cbrs{}).


clear_collected_reports() ->
  put(?KN_COLLECTED_REPORTS, #cbrs{}).



%% 收集战报
%% boa: battle object's action

% collect_battle_report(boa_normal_att, ?AR_DODGE, [IsStrikeBack, AtterId, DeferId]) ->
% 	collect_battle_report(boa_normal_att, ?AR_DODGE, [IsStrikeBack, AtterId, DeferId, 0, 0]);

% collect_battle_report(boa_normal_att, AttResult, [IsStrikeBack, AtterId, DeferId, Dam, RetDam]) ->
% 	CBRs = get_collected_reports(),

% 	ReportList = CBRs#cbrs.report_list,
% 	?ASSERT(is_list(ReportList)),


% 	AtterHpLeft = case get_bo_by_id(AtterId) of
% 					null -> 0;  % 表明已经死亡（被打死或被反弹死）
% 					Atter -> lib_bo:get_hp(Atter)
% 				end,
% 	DeferHpLeft = case get_bo_by_id(DeferId) of
% 					null -> 0;
% 					Defer -> lib_bo:get_hp(Defer)
% 				end,
% 	NewAction = #boa_normal_att{
% 					is_strike_back = IsStrikeBack,
% 					atter_id = AtterId,
% 					defer_id = DeferId,
% 					att_result = AttResult,
% 					dam = Dam,
% 					ret_dam = RetDam,
% 					atter_hp_left = AtterHpLeft,
% 					defer_hp_left = DeferHpLeft %%lib_bo:get_hp( get_bo_by_id(DeferId) )
% 					},

% 	NewReportList = [NewAction | ReportList],  % 逆序插入，在打包战报的时候再统一reverse

% 	NewCBRs = CBRs#cbrs{report_list = NewReportList},

% 	set_collected_reports(NewCBRs).


collect_battle_report(boa_do_phy_att, Action) ->
  % AtterHpLeft = case get_bo_by_id(AtterId) of
  % 				null -> 0;  % 表明已经死亡（被打死或被反弹死）
  % 				Atter -> lib_bo:get_hp(Atter)
  % 			end,
  % DeferHpLeft = case get_bo_by_id(DeferId) of
  % 				null -> 0;
  % 				Defer -> lib_bo:get_hp(Defer)
  % 			end,

  % DamDetails = DoAttDesc#do_att_desc.dam_details,

  % NewAction = #boa_do_att{
  % 				att_type = DoAttDesc#do_att_desc.att_type,
  % 				att_subtype = DoAttDesc#do_att_desc.att_subtype,
  % 				att_result = DoAttDesc#do_att_desc.att_result,

  % 				atter_id = DamDetails#dam_details.atter_id,
  % 				defer_id = DamDetails#dam_details.defer_id,
  % 				protector_id = DamDetails#dam_details.protector_id,

  % 				dam_to_defer = DamDetails#dam_details.dam_to_defer,
  % 				dam_to_protector = DamDetails#dam_details.dam_to_protector,
  % 				ret_dam = DamDetails#dam_details.ret_dam,

  % 				atter_hp_left = DamDetails#dam_details.atter_hp_left,
  % 				atter_mp_left = DamDetails#dam_details.atter_mp_left,
  % 				atter_anger_left = DamDetails#dam_details.atter_anger_left,

  % 				defer_hp_left = DamDetails#dam_details.defer_hp_left,
  % 				defer_mp_left = DamDetails#dam_details.defer_mp_left,

  % 				protector_hp_left = DamDetails#dam_details.protector_hp_left,

  % 				atter_buffs_added = DamDetails#dam_details.atter_buffs_added,
  % 				defer_buffs_added = DamDetails#dam_details.defer_buffs_added,
  % 				defer_buffs_removed = DamDetails#dam_details.defer_buffs_removed
  % 				},

  ?ASSERT(is_record(Action, boa_do_phy_att)),
  collect_battle_report__(Action);




collect_battle_report(boa_cast_buffs, Action) ->
  ?ASSERT(is_record(Action, boa_cast_buffs)),
  collect_battle_report__(Action);

collect_battle_report(boa_escape, Action) ->
  ?ASSERT(is_record(Action, boa_escape)),
  collect_battle_report__(Action);

collect_battle_report(boa_heal, Action) ->
  ?ASSERT(is_record(Action, boa_heal)),
  collect_battle_report__(Action);

collect_battle_report(boa_force_die, Action) ->
  ?ASSERT(is_record(Action, boa_force_die)),
  collect_battle_report__(Action);

collect_battle_report(boa_use_goods, Action) ->
  ?ASSERT(is_record(Action, boa_use_goods)),
  collect_battle_report__(Action);

collect_battle_report(boa_summon, Action) ->
  ?ASSERT(is_record(Action, boa_summon)),
  collect_battle_report__(Action);

collect_battle_report(tips, Tips) ->   % 战斗提示
  ?ASSERT(is_record(Tips, btl_tips)),
  BR_SendTips = #br_send_tips{tips = Tips},
  collect_battle_report__(BR_SendTips).




collect_battle_report(boa_do_mag_att, AtterId, IsComboAtt, MagDamDtlList) ->
  ?ASSERT(is_boolean(IsComboAtt), IsComboAtt),
  ?ASSERT(is_list(MagDamDtlList), MagDamDtlList),
  ?ASSERT(begin
            F = fun(MagDamDtl) ->
              ?ASSERT(MagDamDtl#mag_dam_dtl.atter_id == AtterId, {MagDamDtl#mag_dam_dtl.atter_id, AtterId})
                end,
            lists:foreach(F, MagDamDtlList),
            true
          end),

  NewAction = #boa_do_mag_att{
    att_type = ?ATT_T_MAG,
    is_combo_att = IsComboAtt,
    atter_id = AtterId,
    dam_dtl_list = MagDamDtlList
  },

  collect_battle_report__(NewAction).


collect_battle_report__(NewReport) ->
  CollectedBtlRps = get_collected_reports(),

  OldReportList = CollectedBtlRps#cbrs.report_list,
  ?ASSERT(is_list(OldReportList)),

  NewReportList = [NewReport | OldReportList],  % 注意：逆序插入，在打包战报的时候再统一reverse

  NewCollectedBtlRps = CollectedBtlRps#cbrs{report_list = NewReportList},

  set_collected_reports(NewCollectedBtlRps).





% repick_target__([CurTargetBoId | T]) ->
% 	CurTargetBo = get_bo_by_id(CurTargetBoId),
% 	case is_dead(CurTargetBo) of  % 已死亡则不作为目标
% 		true ->
% 			repick_target__(T);
% 		false ->
% 			CurTargetBo
% 	end;

% repick_target__([]) ->
% 	?ASSERT(false),
% 	null.













%% 普通攻击（非反击）
%%do_normal_attack(AtterId, DeferId) ->
%%	do_normal_attack__(AtterId, DeferId, false).

do_normal_attack(AtterId, DeferId) ->  % 普通攻击即不含技能的单体物理攻击
  try
    do_single_target_phy_attack(AtterId, DeferId)
  catch
    throw: handle_attack_eff_done ->  % 处理技能的攻击效果完毕
      %%put(?KN_JUST_FOR_DEBUG_I_CATCH_BO_ACTION_FINISH, true), % 标记进入过了此流程，仅仅是为了调试
      ok;
    throw: battle_finish -> % 战斗结束
      throw(battle_finish)
  end.





%% 单体物理攻击
do_single_target_phy_attack(AtterId, DeferId) ->
  % ?ASSERT(is_record(CurSkill, skl_brief) orelse CurSkill == no_skill),
  ?ASSERT(can_attack(AtterId, DeferId), {AtterId, DeferId}),

  lib_bo:set_cur_att_target(AtterId, DeferId),
  lib_bo:set_cur_bhv(AtterId, ?BHV_DOING_SINGLE_TARGET_PHY_ATT),  % 标记行为，反击流程中会用到
  into_single_target_phy_attack_flow(AtterId, DeferId, ?ATT_SUB_T_NORMAL).


%% 多目标物理攻击中的一击
do_multi_target_phy_attack_each(AtterId, DeferId) ->
  ?ASSERT(can_attack(AtterId, DeferId), {AtterId, DeferId}),

  lib_bo:set_cur_att_target(AtterId, DeferId),
  lib_bo:set_cur_bhv(AtterId, ?BHV_DOING_MULTI_TARGET_PHY_ATT),  % 标记行为，反击流程中会用到
  into_multi_target_phy_attack_flow(AtterId, DeferId).







%% 追击
%% OldDefer： 上次所打的目标
do_pursue_attack(AtterId, OldDefer) ->
  % 减追击次数
  % lib_bo:decr_left_pursue_att_times(AtterId),


  lib_bo:incr_acc_pursue_att_times(AtterId),


  % 清除连击状态，清零累计的物理连击次数
  lib_bo:clear_phy_combo_att_status(AtterId),
  lib_bo:clear_acc_phy_combo_att_times(AtterId), %%lib_bo:reset_left_phy_combo_att_times(AtterId),

  % 确定攻击目标，如果没有目标，则终止
  case redecide_att_targets_for_pursue_att(AtterId, OldDefer) of
    [] ->
      throw(handle_attack_eff_done); %%throw(handle_bo_cmd_done);
    NewTargetBoIdList ->
      ?ASSERT(is_list(NewTargetBoIdList), NewTargetBoIdList),
      NewTargetBoId = erlang:hd(NewTargetBoIdList), % 选第一个
      lib_bo:set_cur_att_target(AtterId, NewTargetBoId),
      into_single_target_phy_attack_flow(AtterId, NewTargetBoId, ?ATT_SUB_T_PURSUE)
  end.


%% 物理连击
do_phy_combo_attack(AtterId, DeferId) ->
  ?ASSERT(is_bo_exists(AtterId), AtterId),
  ?ASSERT(is_bo_exists(DeferId), DeferId),
  ?ASSERT(is_living(AtterId), AtterId),
  ?ASSERT(is_living(DeferId), DeferId),
  ?ASSERT(lib_bo:get_cur_att_target( get_bo_by_id(AtterId)) == DeferId, {AtterId, DeferId}),

  % 减次数
  % lib_bo:decr_left_phy_combo_att_times(AtterId),

  lib_bo:incr_acc_phy_combo_att_times(AtterId),

  % 扣除连击的消耗
  lib_bo:apply_phy_combo_att_costs(AtterId),

  into_single_target_phy_attack_flow(AtterId, DeferId, ?ATT_SUB_T_COMBO).

%% 物理连击2
do_phy_2_combo_attack(AtterId, DeferIdList) ->

  % 减次数
  % lib_bo:decr_left_phy_combo_att_times(AtterId),

  lib_bo:incr_acc_phy_combo_att_times(AtterId),

  % 扣除连击的消耗
  lib_bo:apply_phy_combo_att_costs(AtterId),
  Bo = get_bo_by_id(AtterId),
  try_phy_2_attack(Bo).
%do_magic_attack(AtterId, DeferIdList, true).


%% 法术连击
do_mag_combo_attack(AtterId, DeferIdList) ->

  % 当前累计法术连击次数加1.
  lib_bo:incr_acc_mag_combo_att_times(AtterId),

  % 记录连击衰减
  % update_mag_combo_att_decay(),

  % 扣除连击消耗
  lib_bo:apply_mag_combo_att_costs(AtterId),

  % 获得战斗对象
  Bo = get_bo_by_id(AtterId),
  % 调整法术连击
  try_magic_attack(Bo).
%do_magic_attack(AtterId, DeferIdList, true).


%% 毒连击
do_poison_combo_attack(AtterId, DeferIdList) ->

  % 当前累计法术连击次数加1.
  lib_bo:incr_acc_mag_combo_att_times(AtterId),

  % 记录连击衰减
  % update_mag_combo_att_decay(),

  % 扣除连击消耗
  lib_bo:apply_mag_combo_att_costs(AtterId),

  % 获得战斗对象
  Bo = get_bo_by_id(AtterId),
  % 调整法术连击
  try_poison_attack(Bo).
%do_magic_attack(AtterId, DeferIdList, true).







%% 反击
do_strikeback(AtterId, DeferId) ->
  % ?ASSERT(lib_bt_dict:get_cur_actor_id() == DeferId, {lib_bt_dict:get_cur_actor_id(), DeferId}),

  pause_cur_actor(),

  do_strikeback__(AtterId, DeferId),

  ?Ifc (is_battle_finish())
throw(battle_finish)
?End,

resume_cur_actor().


do_strikeback__(AtterId, DeferId) ->
  case can_attack(AtterId, DeferId, strikeback) of
    true ->
      apply_phy_damage(AtterId, DeferId, ?ATT_SUB_T_STRIKEBACK);
    false ->
      skip
  end.

% 收集战报（改为在do_single_target_phy_attack__（）中收集）
%collect_battle_report(),









% %% 反击
% do_strikeback(AtterId, DeferId) ->
% 	%%set_cur_reactor(AtterId),  % 记录当前的反击者

% 	%%?ASSERT(DeferId == get_cur_actor_id(), {DeferId, get_cur_actor_id()}), % 反击的目标即为当前行动者
% 	%%do_normal_attack__(AtterId, DeferId, true),

% 	into_single_target_phy_attack_flow(),

% 	resume_cur_actor().




%% (防守者触发反击而导致)暂停当前行动者的行动
pause_cur_actor() ->  %  pause_cur_actor(_and_start_defer_strike_back() ->
  nothing_to_do.  % 暂时不需做什么处理



%% (反击结束后)恢复当前行动者的行动
resume_cur_actor()  -> %   resume_cur_actor(_since_defer_strike_back_finished() ->
  CurActorId = lib_bt_dict:get_cur_actor_id(),
  ?Ifc (is_dead(CurActorId))
throw(handle_attack_eff_done) %%throw(handle_bo_cmd_done)
?End,

case lib_bo:get_cur_bhv( get_bo_by_id(CurActorId)) of
?BHV_DOING_SINGLE_TARGET_PHY_ATT ->
resume_cur_actor(CurActorId, for_single_target_phy_att);
?BHV_DOING_MULTI_TARGET_PHY_ATT ->
resume_cur_actor(CurActorId, for_multi_target_phy_att)
end.




resume_cur_actor(CurActorId, for_single_target_phy_att) ->

  CurActor = get_bo_by_id(CurActorId),

  TargetBoId = lib_bo:get_cur_att_target(CurActor),
  case is_dead(TargetBoId) of
    true ->
      % 防守者在反击过程中被弹死，则不再考虑攻击者是否可以追击，直接throw
      throw(handle_attack_eff_done); %%throw(handle_bo_cmd_done)
    false ->
      % ?Ifc (not lib_bo:in_phy_combo_att_status(CurActor))
      % 	lib_bo:try_get_into_phy_combo_att_status(CurActorId)
      % ?End,

      % 是否可以继续连击？
      case lib_bo:can_phy_combo_attack(CurActorId) of
        true ->
          do_phy_combo_attack(CurActorId, TargetBoId);
        false ->
          throw(handle_attack_eff_done) %%throw(handle_bo_cmd_done)
      end
  end;

% % 是否在连击状态？
% case lib_bo:in_phy_combo_att_status(CurActor) of
% 	true ->
% 		% 是否可以继续连击？
% 		case lib_bo:can_phy_combo_attack(CurActorId) of
% 			true ->
% 				do_phy_combo_attack(CurActorId, TargetBoId);
% 			false ->
% 				throw(handle_bo_cmd_done)
% 		end;
% 	false ->
% 		% 是否可以进入连击状态？
% 		case lib_bo:can_get_into_combo_att_status(CurActorId) of
% 			true ->
% 				lib_bo:mark_combo_att_status(CurActorId),
% 				do_phy_combo_attack(CurActorId, TargetBoId);
% 			false ->
% 				throw(handle_bo_cmd_done)
% 		end
% end.



resume_cur_actor(CurActorId, for_multi_target_phy_att) ->

  % ?Ifc (is_dead(CurActorId))
  % 	throw(handle_attack_eff_done) %%throw(handle_bo_cmd_done)
  % ?End,

  % 是否可以继续打下一个目标？
  case can_go_on_for_multi_target_phy_att(CurActorId) of
    {true, NextTarBoId} ->
      do_multi_target_phy_attack_each(CurActorId, NextTarBoId);
    false ->
      throw(handle_attack_eff_done) %%throw(handle_bo_cmd_done)
  end.








%% 进入单体物理攻击流程
into_single_target_phy_attack_flow(AtterId, DeferId, AttSubType) ->

  case can_attack(AtterId, DeferId) of
    false -> throw(handle_attack_eff_done);
    true ->
      Defer = get_bo_by_id(DeferId),

      % 实施伤害
      apply_phy_damage(AtterId, DeferId, AttSubType),

      ?Ifc (is_battle_finish())
    throw(battle_finish)  % 战斗结束，行动也即终止， 为写代码简单起见，直接throw，由上层去catch
    ?End,

    ?Ifc (is_dead(AtterId))
    throw(handle_attack_eff_done)  %%throw(handle_bo_cmd_done)
    ?End,

    case is_dead(DeferId) of
      true ->
      % ?ASSERT(get_bo_by_id(DeferId) == null), --- 断言不再合适，故注释掉

      % 是否可以追击？
       case lib_bo:can_pursue_attack(AtterId) of
         true ->
           do_pursue_attack(AtterId, Defer);
         false ->
           throw(handle_attack_eff_done)  %%throw(handle_bo_cmd_done)
       end;
      false ->
      % 防守者是否触发反击？
      case (can_strikeback(AtterId, DeferId)) of
        true ->
          do_strikeback(DeferId, AtterId);
        false ->
        % Atter = get_bo_by_id(AtterId),
        % ?Ifc (not lib_bo:in_phy_combo_att_status(Atter))
        % 	lib_bo:try_get_into_phy_combo_att_status(AtterId)
        % ?End,

        % 是否可以连击？
    % 判断是否可以法术连击？
    SklCfg = lib_bo:get_cur_skill_cfg(get_bo_by_id(AtterId)),
    IsCanCombo =
    case SklCfg of
    null ->
    true;
    SklCfg ->
    mod_skill:is_can_combo(SklCfg)
    end,

        case lib_bo:can_phy_combo_attack(AtterId) andalso IsCanCombo of
          true ->
            lib_bo:mark_phy_combo_att_status(AtterId),
            do_phy_combo_attack(AtterId, DeferId);
          false ->
            throw(handle_attack_eff_done)  %%throw(handle_bo_cmd_done)
        end
      end
    end
  end.


%%case get_cur_reactor() == AtterId  of
% case IsStrikeBack of
% 	true -> % 此次为反击
% 		skip;  %% clear_cur_reactor()   % 勿忘：执行反击后，清除当前反击者的记录!!

% 	false -> % 此次攻击并非反击



% end





%% 进入多目标物理攻击流程
into_multi_target_phy_attack_flow(AtterId, DeferId) ->
  ?ASSERT(can_attack(AtterId, DeferId)),

  % 实施伤害
  apply_phy_damage(AtterId, DeferId, ?ATT_SUB_T_NORMAL),

  ?Ifc (is_battle_finish())
throw(battle_finish)  % 战斗结束，行动也即终止
?End,

?Ifc (is_dead(AtterId))
throw(handle_attack_eff_done)  %%throw(handle_bo_cmd_done)
?End,

% 标记为已打过
lib_bo:mark_already_attacked(AtterId, DeferId),

% 递增已打对象的个数
lib_bo:incr_acc_hit_obj_count(AtterId),

% 处理是否触发反击
case can_strikeback(AtterId, DeferId) of
true ->
do_strikeback(DeferId, AtterId);
false ->
% 是否可以继续攻击下一个目标？
case can_go_on_for_multi_target_phy_att(AtterId) of
{true, NextTarBoId} ->
do_multi_target_phy_attack_each(AtterId, NextTarBoId);
false ->
throw(handle_attack_eff_done)  %%throw(handle_bo_cmd_done)
end
end.



%% （多目标物理攻击流程）攻击者是否可以继续攻击下一个目标？  注意返回值的格式！
%% TODO：考虑把函数移到lib_bo.erl？？
%% return: false | {true, NewTargetBoId}
can_go_on_for_multi_target_phy_att(AtterId) ->
  case is_dead(AtterId) of
    true ->
      false;
    false ->
      Atter = get_bo_by_id(AtterId),
      % 攻击次数是否已达上限？
      %%case Atter#battle_obj.acc_hit_obj_count >= Atter#battle_obj.max_hit_obj_count of
      case lib_bo:get_acc_hit_obj_count(Atter) >= lib_bo:get_max_hit_obj_count(Atter) of
        true ->
          false;
        false ->
          % 是否还能找到有效目标？
          case redecide_att_targets(AtterId) of
            [] ->
              false;
            NewTargetBoIdList ->
              ?ASSERT(is_list(NewTargetBoIdList), NewTargetBoIdList),
              NewTargetBoId = erlang:hd(NewTargetBoIdList), % 选第一个
              {true, NewTargetBoId}
          end
      end
  end.


is_strikeback(AttSubType) ->
  AttSubType == ?ATT_SUB_T_STRIKEBACK.


%% 尝试实施物理攻击所带来的伤害
apply_phy_damage(AtterId, DeferId, AttSubType) ->
  ?TRACE("apply_phy_damage(), AtterId=~p DeferId=~p AttSubType=~p~n", [AtterId, DeferId, AttSubType]),

  put(is_be_att,{AtterId,DeferId}),

  ?ASSERT(is_bo_exists(AtterId) andalso is_bo_exists(DeferId)),

  Atter = get_bo_by_id(AtterId),
  Defer = get_bo_by_id(DeferId),
  ?DEBUG_MSG("wjcTestDefer~p  ,,,, ~p ~n",[Atter,Defer]),
  % ?ASSERT(lib_bo:get_side(Atter) /= lib_bo:get_side(Defer)), % 混乱状态下有可能会攻击自己人，故这里屏蔽掉断言！

  IsStrikeback = is_strikeback(AttSubType),

  % 命中，闪避判定
  % AttResult = decide_att_result(Atter, Defer, IsStrikeback),

  %% 	AttResult = decide_phy_att_result(Atter, Defer),20180903现在需要加入闪避计算
  AttResult =
    case decide_att_result(Atter, Defer, IsStrikeback) of
      ?AR_DODGE ->
        ?AR_DODGE;
      _ ->
        %%为本次技能所首选的单位添加BUFF
        case Atter#battle_obj.cur_pick_target == Defer#battle_obj.id of
          true ->
            ?DEBUG_MSG("wjcTestpicktarget ~p~n",[ {Defer#battle_obj.id,Atter#battle_obj.cur_pick_target}]),
            case Atter#battle_obj.tmp_status#bo_tmp_stat.select_first_add_buff of
              0 ->
                skip;
              SelectFirstBuff ->
                {DefBuffsAdded, DefBuffsRemoved} =
                  case lib_bo:add_buff(AtterId, DeferId, SelectFirstBuff, (lib_bo:get_cur_skill_brief(Atter))#bo_skl_brf.id, 1) of % 幽影冥王技能编号33 作用目标为1
                    fail ->
                      {[], []};
                    {ok, nothing_to_do} ->
                      {[], []};
                    {ok, new_buff_added} ->
                      {[SelectFirstBuff], []};
                    {ok, old_buff_replaced, OldBuffNo} ->
                      {[SelectFirstBuff], [OldBuffNo]};
                    {passi, RemovedBuffNo} ->
                      {[], RemovedBuffNo}
                  end,
                lists:foreach(fun(SendAddBuff) ->
                  lib_bt_send:notify_bo_buff_removed(get_bo_by_id(DeferId), SendAddBuff) end, DefBuffsRemoved),
                lists:foreach(fun(SendAddBuff) ->
                  lib_bt_send:notify_bo_buff_added(get_bo_by_id(DeferId), SendAddBuff) end, DefBuffsAdded),
                lib_bo:set_tmp_select_target_add_buff(AtterId, 0)
            end;
          false ->
            skip
        end,

        decide_phy_att_result(Atter, Defer)
    end,

  {DamDetails__,SupoortDet__} = 	case AttResult of
                    ?AR_HIT -> % 命中 (ar: attack result)
                      ?TRACE("apply_phy_damage(), ar_hit!!~n"),
                      %Dam = lib_bt_calc:calc_phy_damage(Atter, Defer, not_crit, AttSubType),
                      Dam0 = lib_bt_calc:calc_phy_damage_duan(Atter, Defer, not_crit, AttSubType),

                      Dam1 =case lib_bo:get_cur_skill_cfg(Atter) of
                              null ->
                                Dam0;
                              SkillCfgData ->
                                {FiveElement, FiveElementLv} = Atter#battle_obj.five_elements,
                                case FiveElement == SkillCfgData#skl_cfg.five_elements of
                                  true ->
                                    case FiveElementLv of
                                      0 ->
                                        Dam0;
                                      1 ->
                                        FiveElementData= data_five_elements_level:get(FiveElement,FiveElementLv),
                                        util:floor(Dam0 *(1+ FiveElementData#five_elements_level.effect_num));
                                      _ ->
                                        FiveElementData= data_five_elements_level:get(FiveElement, 1),
                                        FiveElementData2= data_five_elements_level:get(FiveElement,2),
                                        util:floor(Dam0 *(1 +FiveElementData#five_elements_level.effect_num+ FiveElementData2#five_elements_level.effect_num))
                                    end;
                                  false ->
                                    Dam0
                                end

                            end,

                      Dam2 = adjust_phy_dam(Atter, Defer, Dam1),

                      % 考虑到抵挡伤害的护盾， RealDam和Dam不一定相同！
                      %%{RealDam, RetDam} =
                      % 伤害详情
                      {DamDetails,SupoortDet} = do_apply_phy_dam(Atter, Defer, Dam2, IsStrikeback, not_crit),

                      OnHitSuccessDtl = lib_bo:on_event(Atter, phy_att_hit_success, [DeferId]),

                      % 收集战报
                      % collect_battle_report(boa_normal_att, ?AR_HIT, [IsStrikeback, AtterId, DeferId, RealDam, RetDam]);

                      {merge_on_hit_success_dtl_to_phy_dam_dtl(DamDetails, OnHitSuccessDtl), SupoortDet};

                    ?AR_DODGE -> % 闪避
                      ?TRACE("apply_phy_damage(), ar_dodge!!~n"),

                      % collect_battle_report(boa_normal_att, ?AR_DODGE, [IsStrikeback, AtterId, DeferId]);

                      lib_bo:on_event(DeferId, dodge_success),

                      {build_phy_dam_details(for_dodge_success, AtterId, DeferId), []};

                    ?AR_CRIT -> % 暴击
                      ?TRACE("apply_phy_damage(), ar_crit!!~n"),
                      %Dam = lib_bt_calc:calc_phy_damage(Atter, Defer, crit, AttSubType),
                      Dam0 = lib_bt_calc:calc_phy_damage_duan(Atter, Defer, crit, AttSubType),

                      Dam1 =
                        case AttSubType == ?ATT_SUB_T_NORMAL of
                          true ->
                            Dam0;
                          false ->
                            %检测当前使用的技能五行
                            case lib_bo:get_cur_skill_cfg(Atter) of
                              null ->
                                Dam0;
                              SkillCfgData ->
                                {FiveElement, FiveElementLv} = Atter#battle_obj.five_elements,
                                case FiveElement == SkillCfgData#skl_cfg.five_elements of
                                  true ->
                                    case FiveElementLv of
                                      0 ->
                                        Dam0;
                                      1 ->
                                        FiveElementData= data_five_elements_level:get(FiveElement,FiveElementLv),
                                        util:floor(Dam0 *(1+ FiveElementData#five_elements_level.effect_num));
                                      _ ->
                                        FiveElementData= data_five_elements_level:get(FiveElement,1),
                                        FiveElementData2= data_five_elements_level:get(FiveElement,2),
                                        util:floor(Dam0 *(1 +FiveElementData#five_elements_level.effect_num+ FiveElementData2#five_elements_level.effect_num))
                                    end;
                                  false ->
                                    Dam0
                                end

                            end

                        end,

                      Dam2 = adjust_phy_dam(Atter, Defer, Dam1),

                      % 考虑到抵挡伤害的护盾， RealDam和Dam不一定相同！
                      % {RealDam, RetDam} =
                      {DamDetails,SupoortDet} = do_apply_phy_dam(Atter, Defer, Dam2, is_strikeback(AttSubType), crit),

                      % 收集战报
                      % collect_battle_report(boa_normal_att, ?AR_CRIT, [IsStrikeback, AtterId, DeferId, RealDam, RetDam])

                      OnHitSuccessDtl = lib_bo:on_event(Atter, phy_crit_success, [DeferId]),

                      {merge_on_hit_success_dtl_to_phy_dam_dtl(DamDetails, OnHitSuccessDtl), SupoortDet}
                  end,

  ?ASSERT(is_record(DamDetails__, phy_dam_dtl), DamDetails__),

  collect_battle_report(boa_do_phy_att, #boa_do_phy_att{
    att_type = ?ATT_T_PHY,
    att_subtype = AttSubType,
    att_result = AttResult,
    dam_details = DamDetails__
  }),
  SupoortDetFun =
    fun(SupoortAction) ->
    collect_battle_report(boa_summon,SupoortAction)
    end,
  lists:foreach(SupoortDetFun , SupoortDet__).


merge_on_hit_success_dtl_to_phy_dam_dtl(PhyDamDtl, OnHitSuccessDtl) ->
  %%对攻击者和防御者特殊处理一下
  DeferId =  PhyDamDtl#phy_dam_dtl.defer_id,
  AtterId =  PhyDamDtl#phy_dam_dtl.atter_id,

  NewAddBuff =
    case lists:keytake(DeferId, 1, PhyDamDtl#phy_dam_dtl.atter_buffs_added ) of
      false ->
        [{DeferId,OnHitSuccessDtl#on_hit_success_dtl.defer_buffs_added}| PhyDamDtl#phy_dam_dtl.atter_buffs_added ];
      {value, {DeferId, OldBuffLists}, RemainBuffs1 } ->
        [{DeferId, OldBuffLists  ++ OnHitSuccessDtl#on_hit_success_dtl.defer_buffs_added}|RemainBuffs1]
    end,

  NewAddBuff2 =
    case lists:keytake(AtterId, 1, NewAddBuff ) of
      false ->
        [{AtterId,OnHitSuccessDtl#on_hit_success_dtl.atter_buffs_added}| NewAddBuff];
      {value, {AtterId, OldBuffLists2}, RemainBuffs2 } ->
        [{AtterId, OldBuffLists2  ++ OnHitSuccessDtl#on_hit_success_dtl.atter_buffs_added}|RemainBuffs2]
    end,

  NewRemoveBuff =
    case lists:keytake(DeferId, 1,PhyDamDtl#phy_dam_dtl.atter_buffs_removed ) of
      false ->
        [{DeferId, OnHitSuccessDtl#on_hit_success_dtl.defer_buffs_removed}| PhyDamDtl#phy_dam_dtl.atter_buffs_removed ];
      {value, {DeferId, OldBuffLists3}, RemainBuffs3 } ->
        [{DeferId, OldBuffLists3 ++ OnHitSuccessDtl#on_hit_success_dtl.defer_buffs_removed}|RemainBuffs3]
    end,

  PhyDamDtl#phy_dam_dtl{
    atter_buffs_added = NewAddBuff2,
    atter_buffs_removed = NewRemoveBuff,
    dam_to_defer = PhyDamDtl#phy_dam_dtl.dam_to_defer + OnHitSuccessDtl#on_hit_success_dtl.dam_to_defer,
    defer_anger_left = max(0, PhyDamDtl#phy_dam_dtl.defer_anger_left - OnHitSuccessDtl#on_hit_success_dtl.dam_to_anger)
  }.




%% 构造闪避成功时的物理伤害详情
build_phy_dam_details(for_dodge_success, AtterId, DeferId) ->
  Atter = get_bo_by_id(AtterId),
  Defer = get_bo_by_id(DeferId),
  ?ASSERT(Atter /= null, AtterId),
  ?ASSERT(Defer /= null, DeferId),
  #phy_dam_dtl{
    atter_id = AtterId,             % 攻击者的bo id
    defer_id = DeferId,             % 防守者的bo id
    protector_id = 0,         % 保护者的bo id，如果没有保护者，则统一为0

    % att_result = 0,           % 攻击结果（命中， 闪避，暴击。。）

    dam_to_defer =  0,        % 对防守者的伤害值
    dam_to_protector = 0,     % 对保护者的伤害值
    ret_dam = 0,              % 反弹的伤害值



    atter_hp_left = lib_bo:get_hp(Atter),        % 攻击者的剩余血量
    atter_mp_left = lib_bo:get_mp(Atter),        % 攻击者的剩余魔法（连击时可能会消耗魔法）
    atter_anger_left = lib_bo:get_anger(Atter),     % 攻击者的剩余怒气（连击时可能会消耗怒气）

    defer_hp_left = lib_bo:get_hp(Defer),        % 防守者的剩余血量
    defer_mp_left = lib_bo:get_mp(Defer),
    defer_anger_left = lib_bo:get_anger(Defer),
    protector_hp_left = 0,     % 保护者的剩余血量，如果没有保护者，则统一为0

    atter_buffs_added = [],   % 攻击者新增的buff列表（通常是增益buff）
    atter_buffs_removed = [],

    defer_buffs_added = [],   % 受击者新增的buff列表（通常是减益buff）
    defer_buffs_removed = [], % 受击者移除的buff列表（通常只能是护盾类的buff）
    defer_buffs_updated = [],

    protector_buffs_removed = []

  };

%% 构造免疫伤害成功时的物理伤害详情
build_phy_dam_details(for_immu_dam_success, Atter, Defer) ->
  AtterId = lib_bo:id(Atter),
  DeferId = lib_bo:id(Defer),
  ?BT_LOG(io_lib:format("build_phy_dam_details(for_immu_dam_success, ...), AtterId=~p, DeferId=~p~n", [AtterId, DeferId])),
  #phy_dam_dtl{
    atter_id = AtterId,             % 攻击者的bo id
    defer_id = DeferId,             % 防守者的bo id
    protector_id = 0,         % 保护者的bo id，如果没有保护者，则统一为0

    % att_result = 0,           % 攻击结果（命中， 闪避，暴击。。）

    dam_to_defer = 0,         % 对防守者的伤害值
    dam_to_protector = 0,     % 对保护者的伤害值
    ret_dam = 0,              % 反弹的伤害值

    atter_hp_left = lib_bo:get_hp(Atter),        % 攻击者的剩余血量
    atter_mp_left = lib_bo:get_mp(Atter),        %
    atter_anger_left = lib_bo:get_anger(Atter),     %

    defer_hp_left = lib_bo:get_hp(Defer),        % 防守者的剩余血量
    defer_mp_left = lib_bo:get_mp(Defer),        %
    defer_anger_left = lib_bo:get_anger(Defer),
    protector_hp_left = 0,

    atter_buffs_added = [],   % 攻击者新增的buff列表（通常是增益buff）
    atter_buffs_removed = [],

    defer_buffs_added = [],   % 防守者新增的buff列表（通常是减益buff）
    defer_buffs_removed = [],  % 防守者移除的buff列表（通常是护盾类的buff和死亡后移除的buff）
    defer_buffs_updated = [],   % 防守者更新的buff列表

    protector_buffs_removed = [] % 保护者移除的buff列表
  }.


%% 尝试实施毒性攻所带来的伤害
apply_poison_damage(AtterId, DeferId, TargetCount) ->
  ?TRACE("apply_mag_damage(), AtterId=~p DeferId=~p, TargetCount=~p~n", [AtterId, DeferId, TargetCount]),

  ?ASSERT(is_bo_exists(AtterId) andalso is_bo_exists(DeferId)),

  Atter = get_bo_by_id(AtterId),
  Defer = get_bo_by_id(DeferId),
  % ?ASSERT(lib_bo:get_side(Atter) /= lib_bo:get_side(Defer), {Atter, Defer}),

  % 命中、闪避、暴击判定
  %
  % AttResult = decide_att_result(Atter, Defer, false),
  % 直接命中
  AttResult =
    case decide_att_result(Atter, Defer, null) of
      ?AR_DODGE ->
        ?AR_DODGE;
      _ ->
        ?AR_HIT
    end,

  {DamDetails__,SupoortDet__} = 	case AttResult of
                    ?AR_HIT -> % 命中 (ar: attack result)
                      ?TRACE("apply_mag_damage(), ar_hit!!~n"),
                      %Dam = lib_bt_calc:calc_mag_damage(Atter, Defer, TargetCount, not_crit),
                      Dam = lib_bt_calc:calc_poison_damage_duan(Atter, Defer,TargetCount, not_crit),
                      Dam1 =
                        %检测当前使用的技能五行
                      case lib_bo:get_cur_skill_cfg(Atter) of
                        null ->
                          Dam;
                        SkillCfgData ->
                          {FiveElement, FiveElementLv} = Atter#battle_obj.five_elements,
                          case FiveElement == SkillCfgData#skl_cfg.five_elements of
                            true ->
                              case FiveElementLv of
                                0 ->
                                  Dam;
                                1 ->
                                  FiveElementData= data_five_elements_level:get(FiveElement,FiveElementLv),
                                  util:floor(Dam *(1+ FiveElementData#five_elements_level.effect_num));
                                _ ->
                                  FiveElementData= data_five_elements_level:get(FiveElement,1),
                                  FiveElementData2= data_five_elements_level:get(FiveElement,2),
                                  util:floor(Dam *(1 +FiveElementData#five_elements_level.effect_num+ FiveElementData2#five_elements_level.effect_num))
                              end;
                            false ->
                              Dam
                          end

                      end,

                      Dam2 = adjust_mag_dam(Atter, Defer, Dam1),

                      % 考虑到抵挡伤害的护盾， RealDam和Dam不一定相同！
                      %%{RealDam, RetDam} =
                      % 伤害详情
                      {DamDetails,SupoortDet} = do_apply_mag_dam(Atter, Defer, Dam2 ,not_crit),
                      OnHitSuccessDtl = lib_bo:on_event(Atter, mag_att_hit_success, [DeferId]),  % 也许会加某些buff，这里返回添加的buff列表，用于后续构造伤害详情， 下同

                      % 收集战报
                      % collect_battle_report(boa_normal_att, ?AR_HIT, [IsStrikeback, AtterId, DeferId, RealDam, RetDam]);
                      {merge_on_hit_success_dtl_to_mag_dam_dtl(DamDetails, OnHitSuccessDtl), SupoortDet};

                    ?AR_DODGE -> % 闪避
                      ?TRACE("apply_mag_damage(), ar_dodge!!~n"),
                      % collect_battle_report(boa_normal_att, ?AR_DODGE, [IsStrikeback, AtterId, DeferId]);
                      lib_bo:on_event(DeferId, dodge_success),
                      {build_mag_dam_details(for_dodge_success, AtterId, DeferId),[]};
                    ?AR_CRIT -> % 暴击
                      ?TRACE("apply_mag_damage(), ar_crit!!~n"),
                      %Dam = lib_bt_calc:calc_mag_damage(Atter, Defer, TargetCount, crit),
                      Dam = lib_bt_calc:calc_poison_damage_duan(Atter, Defer,TargetCount, crit),
                      Dam1 =
                        %检测当前使用的技能五行
                      case lib_bo:get_cur_skill_cfg(Atter) of
                        null ->
                          Dam;
                        SkillCfgData ->
                          {FiveElement, FiveElementLv} = Atter#battle_obj.five_elements,
                          case FiveElement == SkillCfgData#skl_cfg.five_elements of
                            true ->
                              case FiveElementLv of
                                0 ->
                                  Dam;
                                1 ->
                                  FiveElementData= data_five_elements_level:get(FiveElement,FiveElementLv),
                                  util:floor(Dam *(1+ FiveElementData#five_elements_level.effect_num));
                                _ ->
                                  FiveElementData= data_five_elements_level:get(FiveElement,1),
                                  FiveElementData2= data_five_elements_level:get(FiveElement,2),
                                  util:floor(Dam *(1 +FiveElementData#five_elements_level.effect_num+ FiveElementData2#five_elements_level.effect_num))
                              end;
                            false ->
                              Dam
                          end

                      end,
                      Dam2 = adjust_mag_dam(Atter, Defer, Dam1),

                      % 考虑到抵挡伤害的护盾， RealDam和Dam不一定相同！
                      % {RealDam, RetDam} =
                      {DamDetails,SupoortDet}  = do_apply_mag_dam(Atter, Defer, Dam2, crit),
                      % 收集战报
                      % collect_battle_report(boa_normal_att, ?AR_CRIT, [IsStrikeback, AtterId, DeferId, RealDam, RetDam])
                      OnHitSuccessDtl = lib_bo:on_event(Atter, mag_crit_success, [DeferId]),

                      {merge_on_hit_success_dtl_to_mag_dam_dtl(DamDetails, OnHitSuccessDtl), SupoortDet}
                  end,

  ?ASSERT(is_record(DamDetails__, mag_dam_dtl), DamDetails__),

  % 补充记录攻击结果并返回!!!
  {DamDetails__#mag_dam_dtl{
    att_result = AttResult
  }, SupoortDet__}
   .

%% 尝试实施物理攻击同时群攻所带来的伤害
apply_phy_2_damage(AtterId, DeferId, TargetCount) ->
  ?TRACE("apply_mag_damage(), AtterId=~p DeferId=~p, TargetCount=~p~n", [AtterId, DeferId, TargetCount]),

  ?ASSERT(is_bo_exists(AtterId) andalso is_bo_exists(DeferId)),
  put(is_be_att,{AtterId,DeferId}),
  Atter = get_bo_by_id(AtterId),
  Defer = get_bo_by_id(DeferId),
  % ?ASSERT(lib_bo:get_side(Atter) /= lib_bo:get_side(Defer), {Atter, Defer}),

  % 命中、闪避、暴击判定
  %
  % AttResult = decide_att_result(Atter, Defer, false),
%% 	AttResult = decide_mag_att_result(Atter, Defer),20180903现在需要加入闪避计算
  AttResult =
    case decide_att_result(Atter, Defer, false) of
      ?AR_DODGE ->
        ?AR_DODGE;
      _ ->
        %%为本次技能所首选的单位添加BUFF
        case Atter#battle_obj.cur_pick_target == Defer#battle_obj.id of
          true ->
            case Atter#battle_obj.tmp_status#bo_tmp_stat.select_first_add_buff of
              0 ->
                skip;
              SelectFirstBuff ->
                {DefBuffsAdded, DefBuffsRemoved} =
                  case lib_bo:add_buff(AtterId, DeferId, SelectFirstBuff, (lib_bo:get_cur_skill_brief(Atter))#bo_skl_brf.id, 1) of % 幽影冥王技能编号33 作用目标为1
                    fail ->
                      {[], []};
                    {ok, nothing_to_do} ->
                      {[], []};
                    {ok, new_buff_added} ->
                      {[SelectFirstBuff], []};
                    {ok, old_buff_replaced, OldBuffNo} ->
                      {[SelectFirstBuff], [OldBuffNo]};
                    {passi, RemovedBuffNo} ->
                      {[], RemovedBuffNo}
                  end,
                lists:foreach(fun(SendAddBuff) ->
                  lib_bt_send:notify_bo_buff_removed(get_bo_by_id(DeferId), SendAddBuff) end, DefBuffsRemoved),
                lib_bo:set_tmp_select_target_add_buff(AtterId, 0),
                lists:foreach(fun(SendAddBuff) ->
                  lib_bt_send:notify_bo_buff_added(get_bo_by_id(DeferId), SendAddBuff) end, DefBuffsAdded)
            end;
          false ->skip
        end,
        decide_phy_att_result(Atter, Defer)
    end,
  {DamDetails__,SupoortDet__} = 	case AttResult of
                                   ?AR_HIT -> % 命中 (ar: attack result)
                                     ?TRACE("apply_mag_damage(), ar_hit!!~n"),
                                     %Dam = lib_bt_calc:calc_mag_damage(Atter, Defer, TargetCount, not_crit),
                                     Dam0 = lib_bt_calc:calc_phy_damage_duan(Atter, Defer, not_crit,1),

                                     io:format("TestDam0 DeferId: ~p, DamVal: ~p ~n",[DeferId,Dam0]),

                                     Dam1 =
                                       %检测当前使用的技能五行
                                     case lib_bo:get_cur_skill_cfg(Atter) of
                                       null ->
                                         Dam0;
                                       SkillCfgData ->
                                         {FiveElement, FiveElementLv} = Atter#battle_obj.five_elements,
                                         case FiveElement == SkillCfgData#skl_cfg.five_elements of
                                           true ->
                                             case FiveElementLv of
                                               0 ->
                                                 Dam0;
                                               1 ->
                                                 FiveElementData= data_five_elements_level:get(FiveElement,FiveElementLv),
                                                 util:floor(Dam0 *(1 +FiveElementData#five_elements_level.effect_num));
                                               _ ->
                                                 FiveElementData= data_five_elements_level:get(FiveElement,1 ),
                                                 FiveElementData2= data_five_elements_level:get(FiveElement,2),
                                                 util:floor(Dam0 *(1 +FiveElementData#five_elements_level.effect_num+ FiveElementData2#five_elements_level.effect_num))
                                             end;
                                           false ->
                                             Dam0
                                         end

                                     end,
                                     Dam2 = adjust_mag_dam(Atter, Defer, Dam1),

                                     % 考虑到抵挡伤害的护盾， RealDam和Dam不一定相同！
                                     %%{RealDam, RetDam} =
                                     % 伤害详情
                                     {DamDetails,SupoortDet}  = do_apply_mag_dam(Atter, Defer, Dam2 ,not_crit),

                                     OnHitSuccessDtl = lib_bo:on_event(Atter, phy_crit_success, [DeferId]),  % 也许会加某些buff，这里返回添加的buff列表，用于后续构造伤害详情， 下
                                     % 收集战报
                                     % collect_battle_report(boa_normal_att, ?AR_HIT, [IsStrikeback, AtterId, DeferId, RealDam, RetDam]);

                                     {merge_on_hit_success_dtl_to_mag_dam_dtl(DamDetails, OnHitSuccessDtl),SupoortDet} ;

                                   ?AR_DODGE -> % 闪避
                                     ?TRACE("apply_mag_damage(), ar_dodge!!~n"),

                                     % collect_battle_report(boa_normal_att, ?AR_DODGE, [IsStrikeback, AtterId, DeferId]);

                                     lib_bo:on_event(DeferId, dodge_success),

                                     {build_mag_dam_details(for_dodge_success, AtterId, DeferId),[]};

                                   ?AR_CRIT -> % 暴击
                                     ?TRACE("apply_mag_damage(), ar_crit!!~n"),
                                     %Dam = lib_bt_calc:calc_mag_damage(Atter, Defer, TargetCount, crit),
                                     Dam0 = lib_bt_calc:calc_phy_damage_duan(Atter, Defer, crit,1),

                                     Dam1 =
                                       %检测当前使用的技能五行
                                     case lib_bo:get_cur_skill_cfg(Atter) of
                                       null ->
                                         Dam0;
                                       SkillCfgData ->
                                         {FiveElement, FiveElementLv} = Atter#battle_obj.five_elements,
                                         case FiveElement == SkillCfgData#skl_cfg.five_elements of
                                           true ->
                                             case FiveElementLv of
                                               0 ->
                                                 Dam0;
                                               1 ->
                                                 FiveElementData= data_five_elements_level:get(FiveElement,FiveElementLv),
                                                 util:floor(Dam0 *(1 +FiveElementData#five_elements_level.effect_num));
                                               _ ->
                                                 FiveElementData= data_five_elements_level:get(FiveElement,1 ),
                                                 FiveElementData2= data_five_elements_level:get(FiveElement,2),
                                                 util:floor(Dam0 *(1 + FiveElementData#five_elements_level.effect_num+ FiveElementData2#five_elements_level.effect_num))
                                             end;
                                           false ->
                                             Dam0
                                         end

                                     end,

                                     Dam2 = adjust_mag_dam(Atter, Defer, Dam1),

                                     % 考虑到抵挡伤害的护盾， RealDam和Dam不一定相同！
                                     % {RealDam, RetDam} =
                                     {DamDetails,SupoortDet}  = do_apply_mag_dam(Atter, Defer, Dam2, crit),

                                     % 收集战报
                                     % collect_battle_report(boa_normal_att, ?AR_CRIT, [IsStrikeback, AtterId, DeferId, RealDam, RetDam])

                                     OnHitSuccessDtl = lib_bo:on_event(Atter, phy_crit_success, [DeferId]),

                                     {merge_on_hit_success_dtl_to_mag_dam_dtl(DamDetails, OnHitSuccessDtl),SupoortDet}
                                 end,

  ?ASSERT(is_record(DamDetails__, mag_dam_dtl), DamDetails__),

  % 补充记录攻击结果并返回!!!
  {DamDetails__#mag_dam_dtl{
    att_result = AttResult
  }, SupoortDet__}.

%% 尝试实施法术攻击所带来的伤害
apply_mag_damage(AtterId, DeferId, TargetCount) ->
  ?TRACE("apply_mag_damage(), AtterId=~p DeferId=~p, TargetCount=~p~n", [AtterId, DeferId, TargetCount]),

  ?ASSERT(is_bo_exists(AtterId) andalso is_bo_exists(DeferId)),
  put(is_be_att,{AtterId,DeferId}),
  Atter = get_bo_by_id(AtterId),
  Defer = get_bo_by_id(DeferId),
  % ?ASSERT(lib_bo:get_side(Atter) /= lib_bo:get_side(Defer), {Atter, Defer}),

  % 命中、闪避、暴击判定
  %
  % AttResult = decide_att_result(Atter, Defer, false),
%% 	AttResult = decide_mag_att_result(Atter, Defer),20180903现在需要加入闪避计算
  AttResult =
    case decide_att_result(Atter, Defer, false) of
      ?AR_DODGE ->
        ?AR_DODGE;
      _ ->
        %%为本次技能所首选的单位添加BUFF
        case Atter#battle_obj.cur_pick_target == Defer#battle_obj.id of
          true ->
        case Atter#battle_obj.tmp_status#bo_tmp_stat.select_first_add_buff of
          0 ->
            skip;
          SelectFirstBuff ->
            {DefBuffsAdded, DefBuffsRemoved} =
              case lib_bo:add_buff(AtterId, DeferId, SelectFirstBuff, (lib_bo:get_cur_skill_brief(Atter))#bo_skl_brf.id, 1) of % 幽影冥王技能编号33 作用目标为1
                fail ->
                  {[], []};
                {ok, nothing_to_do} ->
                  {[], []};
                {ok, new_buff_added} ->
                  {[SelectFirstBuff], []};
                {ok, old_buff_replaced, OldBuffNo} ->
                  {[SelectFirstBuff], [OldBuffNo]};
                {passi, RemovedBuffNo} ->
                  {[], RemovedBuffNo}
              end,
            lists:foreach(fun(SendAddBuff) ->
              lib_bt_send:notify_bo_buff_removed(get_bo_by_id(DeferId), SendAddBuff) end, DefBuffsRemoved),
            lib_bo:set_tmp_select_target_add_buff(AtterId, 0),
            lists:foreach(fun(SendAddBuff) ->
              lib_bt_send:notify_bo_buff_added(get_bo_by_id(DeferId), SendAddBuff) end, DefBuffsAdded)
        end;
          false ->skip
        end,
        decide_mag_att_result(Atter, Defer)
    end,
  {DamDetails__,SupoortDet__} = 	case AttResult of
                    ?AR_HIT -> % 命中 (ar: attack result)
                      ?TRACE("apply_mag_damage(), ar_hit!!~n"),
                      %Dam = lib_bt_calc:calc_mag_damage(Atter, Defer, TargetCount, not_crit),
                      Dam0 = lib_bt_calc:calc_mag_damage_duan(Atter, Defer, not_crit),

                      io:format("TestDam0 DeferId: ~p, DamVal: ~p ~n",[DeferId,Dam0]),

                      Dam1 =
                        %检测当前使用的技能五行
                      case lib_bo:get_cur_skill_cfg(Atter) of
                        null ->
                          Dam0;
                        SkillCfgData ->
                          {FiveElement, FiveElementLv} = Atter#battle_obj.five_elements,
                          case FiveElement == SkillCfgData#skl_cfg.five_elements of
                            true ->
                              case FiveElementLv of
                                0 ->
                                  Dam0;
                                1 ->
                                  FiveElementData= data_five_elements_level:get(FiveElement,FiveElementLv),
                                  util:floor(Dam0 *(1 +FiveElementData#five_elements_level.effect_num));
                                _ ->
                                  FiveElementData= data_five_elements_level:get(FiveElement,1 ),
                                  FiveElementData2= data_five_elements_level:get(FiveElement,2),
                                  util:floor(Dam0 *(1 +FiveElementData#five_elements_level.effect_num+ FiveElementData2#five_elements_level.effect_num))
                              end;
                            false ->
                              Dam0
                          end

                      end,
                      Dam2 = adjust_mag_dam(Atter, Defer, Dam1),

                      % 考虑到抵挡伤害的护盾， RealDam和Dam不一定相同！
                      %%{RealDam, RetDam} =
                      % 伤害详情
                      {DamDetails,SupoortDet}  = do_apply_mag_dam(Atter, Defer, Dam2 ,not_crit),

                      OnHitSuccessDtl = lib_bo:on_event(Atter, mag_att_hit_success, [DeferId]),  % 也许会加某些buff，这里返回添加的buff列表，用于后续构造伤害详情， 下
                      % 收集战报
                      % collect_battle_report(boa_normal_att, ?AR_HIT, [IsStrikeback, AtterId, DeferId, RealDam, RetDam]);

                      {merge_on_hit_success_dtl_to_mag_dam_dtl(DamDetails, OnHitSuccessDtl),SupoortDet} ;

                    ?AR_DODGE -> % 闪避
                      ?TRACE("apply_mag_damage(), ar_dodge!!~n"),

                      % collect_battle_report(boa_normal_att, ?AR_DODGE, [IsStrikeback, AtterId, DeferId]);

                      lib_bo:on_event(DeferId, dodge_success),

                      {build_mag_dam_details(for_dodge_success, AtterId, DeferId),[]};

                    ?AR_CRIT -> % 暴击
                      ?TRACE("apply_mag_damage(), ar_crit!!~n"),
                      %Dam = lib_bt_calc:calc_mag_damage(Atter, Defer, TargetCount, crit),
                      Dam0 = lib_bt_calc:calc_mag_damage_duan(Atter, Defer, crit),

                      Dam1 =
                        %检测当前使用的技能五行
                      case lib_bo:get_cur_skill_cfg(Atter) of
                        null ->
                          Dam0;
                        SkillCfgData ->
                          {FiveElement, FiveElementLv} = Atter#battle_obj.five_elements,
                          case FiveElement == SkillCfgData#skl_cfg.five_elements of
                            true ->
                              case FiveElementLv of
                                0 ->
                                  Dam0;
                                1 ->
                                  FiveElementData= data_five_elements_level:get(FiveElement,FiveElementLv),
                                  util:floor(Dam0 *(1 +FiveElementData#five_elements_level.effect_num));
                                _ ->
                                  FiveElementData= data_five_elements_level:get(FiveElement,1 ),
                                  FiveElementData2= data_five_elements_level:get(FiveElement,2),
                                  util:floor(Dam0 *(1 + FiveElementData#five_elements_level.effect_num+ FiveElementData2#five_elements_level.effect_num))
                              end;
                            false ->
                              Dam0
                          end

                      end,

                      Dam2 = adjust_mag_dam(Atter, Defer, Dam1),

                      % 考虑到抵挡伤害的护盾， RealDam和Dam不一定相同！
                      % {RealDam, RetDam} =
                      {DamDetails,SupoortDet}  = do_apply_mag_dam(Atter, Defer, Dam2, crit),

                      % 收集战报
                      % collect_battle_report(boa_normal_att, ?AR_CRIT, [IsStrikeback, AtterId, DeferId, RealDam, RetDam])

                      OnHitSuccessDtl = lib_bo:on_event(Atter, mag_crit_success, [DeferId]),

                      {merge_on_hit_success_dtl_to_mag_dam_dtl(DamDetails, OnHitSuccessDtl),SupoortDet}
                  end,

  ?ASSERT(is_record(DamDetails__, mag_dam_dtl), DamDetails__),

  % 补充记录攻击结果并返回!!!
  {DamDetails__#mag_dam_dtl{
    att_result = AttResult
  }, SupoortDet__}.



merge_on_hit_success_dtl_to_mag_dam_dtl(MagDamDtl, OnHitSuccessDtl) ->
  %%对攻击者和防御者特殊处理一下
  DeferId =  MagDamDtl#mag_dam_dtl.defer_id,
  AtterId =  MagDamDtl#mag_dam_dtl.atter_id,

  NewAddBuff =
    case lists:keytake(DeferId, 1, MagDamDtl#mag_dam_dtl.atter_buffs_added ) of
      false ->
        [{DeferId,OnHitSuccessDtl#on_hit_success_dtl.defer_buffs_added}| MagDamDtl#mag_dam_dtl.atter_buffs_added ];
      {value, {DeferId, OldBuffLists}, RemainBuffs1 } ->
        [{DeferId, OldBuffLists  ++ OnHitSuccessDtl#on_hit_success_dtl.defer_buffs_added}|RemainBuffs1]
    end,

  NewAddBuff2 =
    case lists:keytake(AtterId, 1, NewAddBuff ) of
      false ->
        [{AtterId,OnHitSuccessDtl#on_hit_success_dtl.atter_buffs_added}| NewAddBuff];
      {value, {AtterId, OldBuffLists2}, RemainBuffs2 } ->
        [{AtterId, OldBuffLists2  ++ OnHitSuccessDtl#on_hit_success_dtl.atter_buffs_added}|RemainBuffs2]
    end,

  NewRemoveBuff =
    case lists:keytake(DeferId, 1,MagDamDtl#mag_dam_dtl.atter_buffs_removed ) of
      false ->
        [{DeferId, OnHitSuccessDtl#on_hit_success_dtl.defer_buffs_removed}| MagDamDtl#mag_dam_dtl.atter_buffs_removed ];
      {value, {DeferId, OldBuffLists3}, RemainBuffs3 } ->
        [{DeferId, OldBuffLists3 ++ OnHitSuccessDtl#on_hit_success_dtl.defer_buffs_removed}|RemainBuffs3]
    end,
  MagDamDtl#mag_dam_dtl{
    atter_buffs_added = NewAddBuff2,
    atter_buffs_removed = NewRemoveBuff,
    dam_to_defer = MagDamDtl#mag_dam_dtl.dam_to_defer + OnHitSuccessDtl#on_hit_success_dtl.dam_to_defer,
    defer_anger_left = max(0, MagDamDtl#mag_dam_dtl.defer_anger_left - OnHitSuccessDtl#on_hit_success_dtl.dam_to_anger)
  }.


%% 构造闪避时的法术伤害详情
build_mag_dam_details(for_dodge_success, AtterId, DeferId) ->
  Atter = get_bo_by_id(AtterId),
  Defer = get_bo_by_id(DeferId),
  ?ASSERT(Atter /= null, AtterId),
  ?ASSERT(Defer /= null, DeferId),
  #mag_dam_dtl{
    atter_id = AtterId,             % 攻击者的bo id
    defer_id = DeferId,             % 防守者的bo id


    %%% att_result = ?AR_DODGE,           % 攻击结果（命中， 闪避，暴击。。）
    dam_to_defer =  0,        % 对防守者的伤害值


    atter_hp_left = lib_bo:get_hp(Atter),        % 攻击者的剩余血量
    atter_mp_left = lib_bo:get_mp(Atter),        % 攻击者的剩余魔法（连击时可能会消耗魔法）
    atter_anger_left = lib_bo:get_anger(Atter),     % 攻击者的剩余怒气（连击时可能会消耗怒气）

    defer_hp_left = lib_bo:get_hp(Defer),        % 防守者的剩余血量
    defer_mp_left = lib_bo:get_mp(Defer),
    defer_anger_left = lib_bo:get_anger(Defer),

    atter_buffs_added = [],   % 攻击者新增的buff列表（通常是增益buff）
    atter_buffs_removed = [],

    defer_buffs_added = [],   % 受击者新增的buff列表（通常是减益buff）
    defer_buffs_removed = [], % 受击者移除的buff列表（通常只能是护盾类的buff）
    defer_buffs_updated = []

  };

%% 构造免疫伤害成功时的法术伤害详情
build_mag_dam_details(for_immu_dam_success, Atter, Defer) ->
  AtterId = lib_bo:id(Atter),
  DeferId = lib_bo:id(Defer),
  ?BT_LOG(io_lib:format("build_mag_dam_details(for_immu_dam_success, ...), AtterId=~p, DeferId=~p~n", [AtterId, DeferId])),
  #mag_dam_dtl{
    atter_id = AtterId,             % 攻击者的bo id
    defer_id = DeferId,             % 防守者的bo id

    %%% att_result = ?AR_HIT,           % 这里不管是命中还是暴击，都统一为命中
    dam_to_defer = 0,         % 对防守者的伤害值

    atter_hp_left = lib_bo:get_hp(Atter),        % 攻击者的剩余血量
    atter_mp_left = lib_bo:get_mp(Atter),        %
    atter_anger_left = lib_bo:get_anger(Atter),     %

    defer_hp_left = lib_bo:get_hp(Defer),        % 防守者的剩余血量
    defer_mp_left = lib_bo:get_mp(Defer),        %
    defer_anger_left = lib_bo:get_anger(Defer),
    atter_buffs_added = [],   % 攻击者新增的buff列表（通常是增益buff）
    atter_buffs_removed = [],

    defer_buffs_added = [],   % 防守者新增的buff列表（通常是减益buff）
    defer_buffs_removed = [],  % 防守者移除的buff列表（通常是护盾类的buff和死亡后移除的buff）
    defer_buffs_updated = []   % 防守者更新的buff列表
  }.








% to_att_subtype_code(AttSubType) ->
% 	case AttSubType of
% 		normal_att ->
% 			?ATT_SUB_T_NORMAL;
% 		strike_back ->
% 			?ATT_SUB_T_STRIKEBACK;
% 		combo_att ->
% 			?ATT_SUB_T_COMBO;
% 		pursue_att ->
% 			?ATT_SUB_T_PURSUE
% 	end.













% %% 普通攻击
% %% @para: IsStrikeback => 此次攻击是否为反击
% do_normal_attack__(AtterId, DeferId, IsStrikeback) ->
% 	?TRACE("do_normal_attack__(), AtterId=~p DeferId=~p IsStrikeback=~p~n", [AtterId, DeferId, IsStrikeback]),

% 	Atter = get_bo_by_id(AtterId),



% 	Defer = case is_bo_exists(DeferId) of
% 				true ->
% 					get_bo_by_id(DeferId);
% 				false ->
% 					repick_attack_target(Atter)
% 			end,

% 	?ASSERT(lib_bo:get_side(Atter) /= lib_bo:get_side(Defer)),

% 	% 命中，闪避判定
% 	case decide_attack_result(Atter, Defer) of
% 		?AR_HIT -> % 命中 (ar: attack result)
% 			?TRACE("do_normal_attack(), ar_hit!!~n"),
% 			Dam = calc_normal_attack_dam(Atter, Defer, false),

% 			% 考虑到抵挡伤害的护盾， RealDam和Dam不一定相同！
% 			{RealDam, RetDam} = do_damage_to(Atter, Defer, Dam),

% 			% 收集战报
% 			collect_battle_report(boa_normal_att, ?AR_HIT, [IsStrikeback, AtterId, DeferId, RealDam, RetDam]);



% 		?AR_DODGE -> % 闪避
% 			?TRACE("do_normal_attack(), ar_dodge!!~n"),

% 			collect_battle_report(boa_normal_att, ?AR_DODGE, [IsStrikeback, AtterId, DeferId]);

% 		?AR_CRIT -> % 暴击
% 			?TRACE("do_normal_attack(), ar_crit!!~n"),
% 			Dam = calc_normal_attack_dam(Atter, Defer, true),

% 			% 考虑到抵挡伤害的护盾， RealDam和Dam不一定相同！
% 			{RealDam, RetDam} = do_damage_to(Atter, Defer, Dam),

% 			% 收集战报
% 			collect_battle_report(boa_normal_att, ?AR_CRIT, [IsStrikeback, AtterId, DeferId, RealDam, RetDam])
% 	end,

% 	case is_battle_finish() of
% 				true ->
% 					throw(battle_finish);  % 战斗结束，行动也即终止， 为写代码简单起见，直接throw，由上层去catch
% 				false ->
% 					%%case get_cur_reactor() == AtterId  of
% 					case IsStrikeback of
% 						true -> % 此次为反击
% 							skip;  %% clear_cur_reactor()   % 勿忘：执行反击后，清除当前反击者的记录!!

% 						false -> % 此次攻击并非反击
% 							?Ifc (can_strikeback(AtterId, DeferId))  % der是否触发反击？
% 								do_strikeback(DeferId, AtterId)
% 							?End
% 					end
% 	end.




%% 判定攻击结果（命中？闪避？。。。）
%% @para: IsStrikeback => 此次攻击是否为反击
decide_att_result(Atter, Defer, _IsStrikeback) ->
  % 是否命中？
  % random(0,命中值) < ((抗命中-命中值)/10)
  AtterHit = lib_bo:get_hit(Atter),
  DeferDodge = lib_bo:get_dodge(Defer),

  case util:rand(0, AtterHit) < (max(0, DeferDodge-AtterHit) / 10) of
    true ->
      ?AR_DODGE;
    false ->
      % 命中后判定是否暴击？
      AtterCrit = lib_bo:get_crit(Atter),
      DeferTen = lib_bo:get_ten(Defer),
      ?ASSERT(util:is_nonnegative_int(AtterCrit), {AtterCrit, Atter}),
      ?ASSERT(util:is_nonnegative_int(DeferTen), {DeferTen, Defer}),
      % random(0,抗暴击值) < ((暴击-抗暴击值)/10)
      case util:rand(0, DeferTen) < (max(0, AtterCrit-DeferTen) / 10) of
        true ->
          ?AR_CRIT;
        false ->
          ?AR_HIT
      end
  end.

%% 判断物理攻击是否暴击
decide_phy_att_result(Atter,Defer) ->
  AtterCrit = lib_bo:get_phy_crit(Atter),
  DeferTen = lib_bo:get_phy_ten(Defer),
  % ?DEBUG_MSG("AtterCrit= ~p,DeferTen = ~p",[lib_bo:get_phy_crit(Atter),lib_bo:get_phy_ten(Defer)]),

  CritPro = erlang:min(erlang:max((AtterCrit - DeferTen) / 1000,0),1),

  % 计算是否闪避
  % 闪避返回 ?AR_DODGE;
  % ?DEBUG_MSG("decide_mag_att_result CritPro ~p",[CritPro]),
  case util:decide_proba_once(CritPro) of
    fail ->
      case Atter#battle_obj.tmp_status#bo_tmp_stat.select_first_cause_crit == 1 andalso Atter#battle_obj.cur_pick_target == Defer#battle_obj.id of
        true ->
          lib_bo:set_tmp_select_target_cause_crite(Atter,0),
          ?AR_CRIT;
        false ->
          ?AR_HIT
      end;
    success ->
      ?AR_CRIT
  end.

%% 判断法术攻击是否暴击
decide_mag_att_result(Atter,Defer) ->
  AtterCrit = lib_bo:get_mag_crit(Atter),
  DeferTen = lib_bo:get_mag_ten(Defer),

  CritPro = erlang:min(erlang:max((AtterCrit - DeferTen) / 1000,0),1),

  % 计算是否闪避
  % 闪避返回 ?AR_DODGE;
  % ?DEBUG_MSG("decide_mag_att_result CritPro ~p",[CritPro]),
  case util:decide_proba_once(CritPro) of
    fail ->
      case Atter#battle_obj.tmp_status#bo_tmp_stat.select_first_cause_crit == 1 andalso Atter#battle_obj.cur_pick_target == Defer#battle_obj.id of
        true ->
          lib_bo:set_tmp_select_target_cause_crite(Atter,0),
          ?AR_CRIT;
        false ->
          ?AR_HIT
      end;
    success ->
      ?AR_CRIT
  end.



% %% 计算物理攻击的伤害值
% %% @para: CritInfo => 是否暴击（crit：是，not_crit：否）
% calc_phy_damage(Atter, Defer, CritInfo) ->
% 	% TODO: 临时性十分简单的计算：
% 	% ?TRACE("calc_phy_damage(), Atter:~p, phy att: ~p, Defer:~p,  phy def: ~p~n",
% 	% 				[?BOID(Atter), lib_bo:get_total_phy_att(Atter), ?BOID(Defer), lib_bo:get_total_phy_def(Defer)]),
% 	Dam = max(lib_bo:get_total_phy_att(Atter) - lib_bo:get_total_phy_def(Defer), 0),  % 改为max矫正至少为1？

% 	Dam2 = case CritInfo of
% 		crit -> Dam * 2;
% 		not_crit -> Dam
% 	end,
% 	RandDam = util:rand(0, 20),
% 	Dam3 = case util:rand(1, 2) of
% 		1 ->
% 			max(Dam2 + RandDam, 1);
% 		2 ->
% 			max(Dam2 - RandDam, 1)
% 	end,

% 	% TODO: 处理atter的伤害增加， defer的受伤害增加的buff效果。。
% 	% ...

% 	DoDamEnhance = lib_bo:calc_do_phy_dam_enhance(Atter),
% 	BeDamEnhance = lib_bo:calc_be_phy_dam_enhance(Defer),

% 	% ?TRACE("calc_phy_damage(), Dam=~p Dam2=~p, RandDam=~p, Dam3=~p, DoDamEnhance=~p, BeDamEnhance=~p~n", [Dam, Dam2, RandDam, Dam3, DoDamEnhance, BeDamEnhance]),
% 	Dam3 + DoDamEnhance + BeDamEnhance.








%% 保护者固定分摊70%的伤害
-define(PROTECTOR_SHARE_DAM_RATE, 0.7).

%% 尝试应用保护流程
try_apply_protection(AtterId, DeferId, DamVal, IsStrikeback) ->
  Atter = get_bo_by_id(AtterId),
  Defer = get_bo_by_id(DeferId),
  Protector = lib_bo:get_one_protector(Defer),
  ?BT_LOG(io_lib:format("try_apply_protection(), DeferId=~p, IsStrikeback=~p, DamVal=~p, Protector=~w~n", [DeferId, IsStrikeback, DamVal, Protector])),
  % 注意：考虑到反转伤害的情况，DamVal有可能为负数，故添加DamVal > 0的判断
  case (not IsStrikeback) andalso (Protector /= null) andalso DamVal > 0 of
    true ->
      ProtectorId = lib_bo:id(Protector),

      % 常规保护者在一回合内只能保护一次，故保护后移除掉
      lib_bo:maybe_remove_regular_protector(DeferId, ProtectorId),

      % 保护者固定分摊一定比例的伤害
      TDamShared = util:ceil(DamVal * ?PROTECTOR_SHARE_DAM_RATE), %%lib_bt_calc:calc_phy_damage_to_protector(Atter, Defer, CritInfo),     %%util:ceil(DamVal * 0.3),

      DamShared = case lib_bo:is_dam_full(Atter) of
                    true -> TDamShared;
                    false -> lib_bo:try_apply_passi_eff_on_dam_for_hp(Protector, TDamShared, ?EN_PROTECT_HP_BY_RATE_BASE_LIM)
                  end,

      lib_bo:add_hp(ProtectorId, - DamShared),

      RebornDtl = try_apply_reborn_eff(ProtectorId),

      Protector2 = get_bo_by_id(ProtectorId),

      DieDtl = case is_dead(Protector2) of
                 true ->
                   ProtectorHpLeft = 0,
                   ProtectorAngerLeft = 0,
                   lib_bo:bo_die(Protector2, Atter);
                 false ->
                   ProtectorHpLeft = lib_bo:get_hp(Protector2),
                   ProtectorAngerLeft = lib_bo:get_anger(Protector2),
                   #die_details{}
               end,

      #protection_dtl{
        protector_id = lib_bo:get_id(Protector),
        dam_shared = DamShared,
        dam_anger = lib_bo:get_anger(Protector) - lib_bo:get_anger(Protector2),
        % dam_left = DamVal - DamShared,
        protector_hp_left = ProtectorHpLeft,
        protector_anger_left = ProtectorAngerLeft,
        protector_die_status = DieDtl#die_details.die_status,
        protector_buffs_removed = DieDtl#die_details.buffs_removed,
        reborn_dtl = RebornDtl
      };
    false ->
      #protection_dtl{
        % dam_left = DamVal
      }
  end.

%% 尝试应用溅射效果
% @return SplashDtlList = [#splash_dtl{}, ...]
try_apply_splash_eff(AtterId, DeferId, DamVal, SplashPatternNo, Scale) ->
  Atter = get_bo_by_id(AtterId),
  Defer = get_bo_by_id(DeferId),
  SplashTarList = lib_bt_splash:get_splash_target(Defer, SplashPatternNo),
  ?BT_LOG(io_lib:format("try_apply_splash_eff(), AtterIdPos:~w, DeferIdPos=~p, DamVal=~p, SplashPatternNo:~p, SplashTarList=~w~n", [{lib_bo:get_id(Atter),lib_bo:get_pos(Atter)}, {lib_bo:get_id(Defer),lib_bo:get_pos(Defer)}, DamVal, SplashPatternNo, SplashTarList])),
  % 注意：考虑到反转伤害的情况，DamVal有可能为负数，故添加DamVal > 0的判断
  case (SplashTarList /= []) andalso DamVal > 0 of
    true ->
      F = fun(SplashTarget) ->
        SplashTarId = lib_bo:id(SplashTarget),
        % 溅射目标受到的伤害
        SplashDam_ = util:ceil(DamVal * Scale),
        TSplashDam = lib_bt_calc:adjust_damage(SplashTarget, SplashDam_),

        SplashDam = case lib_bo:is_dam_full(Atter) of
                      true -> TSplashDam;
                      false -> lib_bo:try_apply_passi_eff_on_dam_for_hp(SplashTarget, TSplashDam, ?EN_PROTECT_HP_BY_RATE_BASE_LIM)
                    end,

        ?BT_LOG(io_lib:format("try_apply_splash_eff:SplashTarId=~p,SplashDam=~p~n", [SplashTarId, SplashDam])),
        lib_bo:add_hp(SplashTarId, - SplashDam),
        % 判断重生
        RebornDtl = try_apply_reborn_eff(SplashTarId),
        % 判断死亡
        SplashTarget2 = get_bo_by_id(SplashTarId),
        DieDtl = case is_dead(SplashTarget2) of
                   true ->
                     SplashTarHpLeft = 0,
                     lib_bo:bo_die(SplashTarget2, Atter);
                   false ->
                     SplashTarHpLeft = lib_bo:get_hp(SplashTarget2),
                     #die_details{}
                 end,
        % 溅射详情
        #splash_dtl{
          defer_id = SplashTarId,                                 % 防守者（即：被溅射者）的bo id
          dam_val_hp = SplashDam,                                 % 对防守者的伤害值（伤血）
          dam_val_mp = 0,                                         % 对防守者的伤害值（伤蓝） % 目前不伤蓝 --- yanlh
          dam_val_anger = lib_bo:get_anger(SplashTarget) - lib_bo:get_anger(SplashTarget2),
          defer_hp_left = SplashTarHpLeft,                        % 防守者的剩余血量
          defer_mp_left = lib_bo:get_mp(SplashTarget2),           % 防守者的剩余蓝量
          defer_anger_left = lib_bo:get_anger(SplashTarget2),
          defer_die_status = DieDtl#die_details.die_status,       % 防守者的死亡状态，默认为未死亡
          defer_buffs_removed = DieDtl#die_details.buffs_removed, % 防守者移除的buff列表（如：因被溅射导致死亡，从而移除的buff）
          reborn_dtl = RebornDtl                                  % 重生详情
        }
          end,
      SplashDtlList = [ F(S) || S <- SplashTarList ],
      {ok, SplashDtlList};
    false ->
      {ok, []}
  end.


%% 是否可以反弹伤害给攻击者？
can_return_dam_to_attacker(Atter, Defer) ->
  RetDamProba = lib_bo:get_ret_dam_proba(Defer),
  RetDamProba2 = RetDamProba - Atter#battle_obj.attrs#attrs.neglect_ret_dam,
  ?DEBUG_MSG("wjctestretdam ~p~n", [{RetDamProba,Atter#battle_obj.attrs#attrs.neglect_ret_dam}]),
  case lib_bt_util:test_proba(RetDamProba2) of
    success ->
      true;
    fail ->
      false
  end.


%% 尝试应用反震（反弹伤害）流程
try_apply_return_dam_to_attacker(AtterId, DeferId, RealDamToDefer, _IsStrikeback) ->
  case RealDamToDefer =< 0 of
    true -> % 伤害为0或负数时不处理反震
      #ret_dam_dtl{};
    false ->
      Atter = get_bo_by_id(AtterId),
      Defer = get_bo_by_id(DeferId),
      case can_return_dam_to_attacker(Atter, Defer) of
        false ->
          #ret_dam_dtl{};
        true ->
          TRetDam = lib_bt_calc:calc_ret_damage(Atter, Defer, RealDamToDefer),

          RetDam = case lib_bo:is_dam_full(Atter) of
                     true -> TRetDam;
                     false -> lib_bo:try_apply_passi_eff_on_dam_for_hp(Atter, TRetDam, ?EN_PROTECT_HP_BY_RATE_BASE_LIM)
                   end,

          Atter2 = lib_bo:add_hp(AtterId, - RetDam),
          #ret_dam_dtl{
            dam_returned = RetDam,
            dam_returned_anger = lib_bo:get_anger(Atter) - lib_bo:get_anger(Atter2)
          }
      end
  end.


%% 尝试应用重生效果
%% @return: reborn_dtl结构体
try_apply_reborn_eff(BoId) ->
  Bo = get_bo_by_id(BoId),
  case is_dead(Bo) of
    false ->
      #reborn_dtl{};
    true ->
      ?DEBUG_MSG("Bo#battle_obj.buffs=~p",[Bo#battle_obj.buffs]),

      % 玄机的复活buff无视锁魂
      case (
          (lib_bo:has_reborn_prep_status(Bo) andalso (not lib_bo:is_soul_shackled(Bo)) andalso (not lib_bo:is_max_reborn_count(Bo)))
            orelse (lib_bo:has_reborn_buff(Bo)  andalso  (not lib_bo:is_revive_forbid(Bo))  ) )
      of
        false ->
          #reborn_dtl{};
        true ->
          case lib_bo:find_buff_by_name(Bo,?BFN_REVIVE_ADD_DAM) of
            ShieldBuff when is_record(ShieldBuff, bo_buff) ->
              ?DEBUG_MSG("ShieldBuff=~p",[ShieldBuff]),

              lib_bo:set_hp(BoId, lib_bo:get_hp_lim(Bo)),
              % lib_bo:set_reborn_count(BoId,3),

              lib_bo:remove_buff(BoId, ShieldBuff),
              % 触发复活后出发事件
              lib_bo:handle_buff_expire_events(BoId,ShieldBuff),

              #reborn_dtl{
                is_reborn_applied = true,
                new_hp = lib_bo:get_hp_lim(Bo)
              };

            _ ->
              case lib_bo:find_buff_by_name(Bo,?BFN_REVEVI_ONE_ROUND) of
                ShieldBuff when is_record(ShieldBuff, bo_buff) ->
                  ?DEBUG_MSG("ShieldBuff=~p",[ShieldBuff]),
                  BuffTpl = lib_buff_tpl:get_tpl_data(ShieldBuff#bo_buff.buff_no),
                  RevivalBuffRule = BuffTpl#buff_tpl.para,
                  NewHp = case RevivalBuffRule of
                            {fixed, HpValue} ->
                              HpValue;
                            {rate, HpRate} ->
                              util:ceil(lib_bo:get_hp_lim(Bo) * HpRate / 100)
                          end,
                  lib_bo:set_hp(BoId, NewHp),
                  lib_bo:remove_buff(BoId, ShieldBuff),
                  lib_bt_send:notify_bo_buff_removed(Bo, lib_bo_buff:get_no(ShieldBuff)),
                  #reborn_dtl{
                    is_reborn_applied = true,
                    new_hp = lib_bo:get_hp_lim(Bo)
                  };
                _ ->

                  RebornEff = lib_bo:find_reborn_prep_status_eff(Bo),
                  Proba = RebornEff#bo_peff.reborn_proba,
                  ?ASSERT(util:is_positive_int(Proba), RebornEff),
                  % 判定重生的概率
                  case lib_bt_util:test_proba(Proba) of
                    fail ->
                      #reborn_dtl{};
                    success ->
                      HpRate = RebornEff#bo_peff.hp_rate_on_revive,
                      ?ASSERT(0 < HpRate andalso HpRate =< 1, RebornEff),
                      InitHpLim = lib_bo:get_init_hp_lim(Bo),
                      NewHp = max( util:ceil(InitHpLim * HpRate), 1),

                      lib_bo:set_hp(BoId, NewHp),
                      lib_bo:add_reborn_count(BoId),

                      #reborn_dtl{
                        is_reborn_applied = true,
                        new_hp = NewHp
                      }
                  end
              end
          end
      end
  end.



%% 调整伤害值
adjust_phy_dam(_Atter, Defer, DamVal) ->
  lib_bt_calc:adjust_damage(Defer, DamVal).

adjust_mag_dam(_Atter, Defer, DamVal) ->
  lib_bt_calc:adjust_damage(Defer, DamVal).



%% 实施物理伤害
%% !!!!!!!!注意：考虑到反转伤害的情况，参数DamVal有可能为负数，此时不是给目标造成伤害，而是反之给他加血!!!!!!!
%% @return: phy_dam_dtl(物理伤害详情）结构体
do_apply_phy_dam(Atter, Defer, DamVal, IsStrikeback, CritInfo) ->
  ?ASSERT(is_integer(DamVal), DamVal),
  DeferId = lib_bo:get_id(Defer),
  AtterId = lib_bo:get_id(Atter),
  case DamVal == 0 orelse  get_bo_by_id(DeferId) == null orelse  get_bo_by_id(AtterId)== null  of
    true ->
      {build_phy_dam_details(for_immu_dam_success, Atter, Defer),[]};
    false ->

      {AtterFiveElement, AtterFiveElementLv} = Atter#battle_obj.five_elements,

      {DeferFiveElement, DeferFiveElementLv} = Defer#battle_obj.five_elements,


      FiveElementCoef =
        case lib_bo:get_cur_skill_cfg(Atter) of
          null ->
            1;
          SkillCfgData ->
            AtterFiveElement2 =  SkillCfgData#skl_cfg.five_elements,
            AtterFiveElementData = data_five_elements:get(AtterFiveElement2),
            case lists:member(DeferFiveElement,AtterFiveElementData#five_elements.restraint) of
              true ->
                AtterFiveElementData#five_elements.re_num;
              false ->
                case lists:member(DeferFiveElement,AtterFiveElementData#five_elements.berestraint) of
                  true ->
                    AtterFiveElementData#five_elements.be_num;
                  false ->
                    1
                end
            end


        end,
      %% 受击时解除昏睡状态的buff
      OnBeDamDtl = lib_bo:on_event(DeferId, be_phy_dam),

      % 尝试应用幽影冥王技能所引发的buff效果
      {PurgeBuffsDtl, AddBuffsDtl} = lib_bo:try_apply_youying_mingwang_buff_eff_by_do_phy_dam(AtterId, DeferId, DamVal),
      ?ASSERT(is_record(PurgeBuffsDtl, purge_buffs_dtl)),

      AbsorbDamToMpDtl = lib_bo:try_apply_absorb_dam_to_mp_shield_once(DeferId, DamVal),
      ?ASSERT(is_record(AbsorbDamToMpDtl, absorb_dam_to_mp_dtl)),

      ReduceDamDtl = lib_bo:try_apply_reduce_phy_dam_shield_once(DeferId, DamVal), %%根本就没用到。。。wjc
      ?ASSERT(is_record(ReduceDamDtl, reduce_dam_dtl)),

      % TODO: 如有必要，处理其他护盾
      % ...


      % 尝试应用保护流程
      ProtcDtl = try_apply_protection(AtterId, DeferId, DamVal, IsStrikeback),
      ?ASSERT(is_record(ProtcDtl, protection_dtl)),

      % 应该注意到：DamVal_Left有可能为0
      DamVal_Left = DamVal - ProtcDtl#protection_dtl.dam_shared,

      TRealDamToDefer = DamVal_Left,

      RealDamToDefer0 = case lib_bo:is_dam_full(Atter) of
                          true -> TRealDamToDefer;
                          false -> lib_bo:try_apply_passi_eff_on_dam_for_hp(Defer, TRealDamToDefer, ?EN_PROTECT_HP_BY_RATE_BASE_LIM)
                        end,

      %%五行的幽灵五级要特殊处理，根据攻击者的血量分别有不同的伤害
      YouLingCoef =
        case  AtterFiveElement == 6 andalso AtterFiveElementLv ==5 of
          true ->
            AtterHpLim = Atter#battle_obj.attrs#attrs.hp_lim,
            AtterHp = Atter#battle_obj.attrs#attrs.hp,
            if (AtterHp/AtterHpLim) =< 0.2 -> 1.2;
              (AtterHp/AtterHpLim) =< 0.5 -> 1.15;
              (AtterHp/AtterHpLim) =< 0.8 -> 1.1;
              true -> 1
            end;
          false ->
            1
        end,
      RealDamToDefer = util:floor(RealDamToDefer0 * FiveElementCoef * YouLingCoef)   ,

      Atter2 = get_bo_by_id(AtterId),  % 重新获取最新的
      Defer2 = lib_bo:add_hp(DeferId, - RealDamToDefer),

      % 防御者实际血量变化
      DeferRealHpChange = lib_bo:get_hp(Defer) - lib_bo:get_hp(Defer2),

      ApplyUndeadEffDtl = lib_bo:try_apply_undead_eff(Defer2),
      ?ASSERT(is_record(ApplyUndeadEffDtl, apply_undead_eff_dtl)),

      DamSubDtl = try_handle_skill_in_effs(Atter2, Defer2, RealDamToDefer, IsStrikeback),

      %% 增加攻击中特殊条件触发 例如暴击时
      DamCritSubDtl = try_handle_crit_in_effs(get_bo_by_id(AtterId),get_bo_by_id(DeferId), CritInfo,RealDamToDefer),
      ?ASSERT(is_record(DamSubDtl, dam_sub_dtl), DamSubDtl),

      % 尝试应用反震（反弹伤害）流程
      RetDamDtl = try_apply_return_dam_to_attacker(AtterId, DeferId, DeferRealHpChange, IsStrikeback),



      % 判断是否是群体技能如果是群体技能吸血量调整为33%

      % 反弹伤害等于
      RetDam = RetDamDtl#ret_dam_dtl.dam_returned,
      ?DEBUG_MSG("phy_dam RetDam = ~p",[RetDam]),
      % 吸血
      AbsorbedHp = lib_bo:try_apply_absorb_hp(AtterId, DeferId, DamVal * get_cur_skill_count_type(AtterId)),


      %%  护盾类技能抵挡反弹伤害
      AtterReduceDamDtl = lib_bo:try_apply_reduce_phy_dam_shield_once2(lib_bo:id(Atter), RetDam),
      %?DEBUG_MSG("phy_dam AtterReduceDamDtl = ~p",[AtterReduceDamDtl]),
      ?ASSERT(is_record(AtterReduceDamDtl, reduce_dam_dtl)),

%%      [AdditionalEff,_]  = check_and_handle_hp_buff(DeferId, AtterId),
      % 尝试应用重生效果
      RebornDtl_Defer = try_apply_reborn_eff(DeferId),
      RebornDtl_Atter = try_apply_reborn_eff(AtterId),
      % 再次重新获取最新的
      Atter3 = get_bo_by_id(AtterId),
      Defer3 = get_bo_by_id(DeferId),
      BeEffList1 = lib_bo:find_passi_eff_by_name_all(Defer, ?EN_ADD_BUFF_ON_HP_LOW),
      %% 伤害低于某个百分比时是否要释放技能？ wjc2019.9.18
      %%返回对象和buff表的数组
      OnHPLowDtl =lib_bo_buff:trigger_passi_buff_on_lowHP(lib_bo:get_hp(Defer3),Defer3,AtterId,BeEffList1),
      ?DEBUG_MSG("wujianchengtestBuff2 = ~p",[OnHPLowDtl]),
%%      #update_buffs_rule_dtl{
%%        bo_id = TargetBoId,
%%        atter_buffs_added = BuffsAdded,
%%        atter_buffs_removed = BuffsRemoved
%%      },
      %%这种方法最后别传如结构体数据之类，很容易把老的数据传进去，导致前面的操作失效，非常难查的bug wjc
      DieTriggerBuffDtl = die_trriger_passi_buff( get_bo_by_id(AtterId),get_bo_by_id(DeferId),AtterId,DeferId),
      SkillkillDeferDtl =
        case is_dead(get_bo_by_id(DeferId)) of
          false ->
            [];
          true ->
            case Atter#battle_obj.tmp_status#bo_tmp_stat.kill_target_add_buff of
              0 ->
                [];
              PassiEffNo ->
                lib_bo:set_tmp_kill_target_add_buff(AtterId, 0),
                PassiEffData = data_passi_eff:get(PassiEffNo),
                BeBuffPassi = lib_bt_misc:apply_add_buff_on_kill_bo( (lib_bo:get_cur_skill_brief(Atter))#bo_skl_brf.id,PassiEffData),
                case  BeBuffPassi of
                  [] ->
                    [];
                  _ ->
                    lib_bo:try_apply_passi_eff_add_buff_on_condition(get_bo_by_id(AtterId),DeferId , BeBuffPassi)
                end

            end
        end,
      Atter4 = get_bo_by_id(AtterId),
      Defer4 = get_bo_by_id(DeferId),
      {DeferHpLeft, DieDtl_Defer} = check_and_handle_bo_die(Defer4, Atter4),
      {AtterHpLeft, DieDtl_Atter} = check_and_handle_bo_die(Atter4, Defer4), % 攻击者有可能被反弹死

      %%检测是否有额外扣血或着回血的buff
      AdditionalEff =
        case get(extra_buff_eff) of
          undefined ->
            [];
          BuffEff ->
            put(extra_buff_eff,[]),
            BuffEff
        end,
      ?DEBUG_MSG("wjctestatonce ~p~n",[AdditionalEff]),
      AtterBuffF =
        fun(AtterBuffX, AtterBuffAcc) ->
          AtterBuffBoId = AtterBuffX#update_buffs_rule_dtl.bo_id,
          AtterBuffAdded = AtterBuffX#update_buffs_rule_dtl.atter_buffs_added,
          case lists:keytake(AtterBuffBoId, 1 ,AtterBuffAcc) of
            false ->
              [{AtterBuffBoId, AtterBuffAdded} | AtterBuffAcc];
            {value ,{AtterBuffBoId, OldAtterBuffAdded}, RemainAtterBuffAcc} ->
              [{AtterBuffBoId, OldAtterBuffAdded ++ AtterBuffAdded}|RemainAtterBuffAcc]
          end
        end,
      AtterBuffsAdded = lists:foldl(AtterBuffF, [], OnHPLowDtl ++ DieTriggerBuffDtl ++ SkillkillDeferDtl), %% [{Boid,BuffLists},···]

      AtterRemovedBuffF =
        fun(AtterBuffX, AtterBuffAcc) ->
          AtterBuffBoId = AtterBuffX#update_buffs_rule_dtl.bo_id,
          AtterBuffAdded = AtterBuffX#update_buffs_rule_dtl.atter_buffs_removed,
          case lists:keytake(AtterBuffBoId, 1 ,AtterBuffAcc) of
            false ->
              [{AtterBuffBoId, AtterBuffAdded} | AtterBuffAcc];
            {value ,{AtterBuffBoId, OldAtterBuffAdded}, RemainAtterBuffAcc} ->
              [{AtterBuffBoId, OldAtterBuffAdded ++ AtterBuffAdded}|RemainAtterBuffAcc]
          end
        end,
      BuffsRemoved = lists:foldl(AtterRemovedBuffF, [], OnHPLowDtl ++ DieTriggerBuffDtl ++ SkillkillDeferDtl),

      %%对攻击者和防御者做特殊处理，比其他人多出buff
      AtterBuffsAdded2 = case lists:keytake(AtterId, 1, AtterBuffsAdded) of
                           false ->
                             [{AtterId, DamSubDtl#dam_sub_dtl.atter_buffs_added   % 攻击者新增的buff列表（通常是增益buff）
                               ++ AddBuffsDtl#add_buffs_dtl.atter_buffs_added
                               ++ DamCritSubDtl#dam_sub_dtl.atter_buffs_added}] ++ AtterBuffsAdded ;
                           {value ,{AtterId, AtterHaveBuffAdded}, RemainAtterBuff} ->
                             [{AtterId, DamSubDtl#dam_sub_dtl.atter_buffs_added   % 攻击者新增的buff列表（通常是增益buff）
                               ++ AddBuffsDtl#add_buffs_dtl.atter_buffs_added
                               ++ DamCritSubDtl#dam_sub_dtl.atter_buffs_added ++AtterHaveBuffAdded }] ++ RemainAtterBuff
                         end,
      BuffsRemoved2 = case lists:keytake(DeferId, 1, BuffsRemoved) of
                            false ->
                              [{DeferId,  DamSubDtl#dam_sub_dtl.atter_buffs_removed
                                ++ DieDtl_Atter#die_details.buffs_removed
                                ++ PurgeBuffsDtl#purge_buffs_dtl.atter_buffs_removed
                                ++ AtterReduceDamDtl#reduce_dam_dtl.defer_buffs_removed
                                ++ DamCritSubDtl#dam_sub_dtl.atter_buffs_removed ++ ReduceDamDtl#reduce_dam_dtl.defer_buffs_removed}] ++ AtterBuffsAdded ;
                            {value ,{DeferId, HaveBuffAdded}, RemainBuff} ->
                              [{DeferId,  DamSubDtl#dam_sub_dtl.atter_buffs_removed
                                ++ DieDtl_Atter#die_details.buffs_removed
                                ++ PurgeBuffsDtl#purge_buffs_dtl.atter_buffs_removed
                                ++ AtterReduceDamDtl#reduce_dam_dtl.defer_buffs_removed
                                ++ DamCritSubDtl#dam_sub_dtl.atter_buffs_removed ++HaveBuffAdded  ++ ReduceDamDtl#reduce_dam_dtl.defer_buffs_removed}] ++ RemainBuff
                          end,

      %% 增加死亡时触发 重生不算死亡
      % DeadTriggerDtl = try_apply_dead_trigger(AtterId, DeferId, DeferHpLeft),
      SupportDet = die_trriger_passi_support([Atter4,Defer4]),
      % 返回伤害详情是为了后续的收集战报
      RetDtl = #phy_dam_dtl{
        atter_id = AtterId,             % 攻击者的bo id
        defer_id = DeferId,             % 防守者的bo id
        protector_id = ProtcDtl#protection_dtl.protector_id,         % 保护者的bo id，如果没有保护者，则统一为0

        % att_result = 0,           % 攻击结果（命中， 闪避，暴击。。）

        dam_to_defer = RealDamToDefer,         % 对防守者的伤害值
        dam_to_defer_mp = DamSubDtl#dam_sub_dtl.dam_to_mp, % 对防守者的伤害值（伤蓝）
        dam_to_defer_anger = (lib_bo:get_anger(Defer) - lib_bo:get_anger(Defer3)), % 对防守者的伤害值（增加怒气）
        dam_to_protector = ProtcDtl#protection_dtl.dam_shared,     % 对保护者的伤害值
        dam_to_protector_anger = ProtcDtl#protection_dtl.dam_anger,% 对保护者的怒气改变
        ret_dam = RetDamDtl#ret_dam_dtl.dam_returned,              % 反弹的伤害值h
        ret_dam_anger = RetDamDtl#ret_dam_dtl.dam_returned_anger,  % 反弹的怒气变化
        absorbed_hp = AbsorbedHp,

        atter_hp_left = AtterHpLeft,        % 攻击者的剩余血量
        atter_mp_left = lib_bo:get_mp(Atter3),
        atter_anger_left = lib_bo:get_anger(Atter3),
        atter_die_status = DieDtl_Atter#die_details.die_status,
        is_atter_apply_reborn = RebornDtl_Atter#reborn_dtl.is_reborn_applied,

        defer_hp_left = DeferHpLeft,        % 防守者的剩余血量
        defer_mp_left = lib_bo:get_mp(Defer3),
        defer_anger_left = lib_bo:get_anger(Defer3),
        defer_die_status = DieDtl_Defer#die_details.die_status,
        is_defer_apply_reborn = RebornDtl_Defer#reborn_dtl.is_reborn_applied,

        protector_hp_left = ProtcDtl#protection_dtl.protector_hp_left,
        protector_anger_left = ProtcDtl#protection_dtl.protector_anger_left,
        protector_die_status = ProtcDtl#protection_dtl.protector_die_status,
        is_protector_apply_reborn = ProtcDtl#protection_dtl.reborn_dtl#reborn_dtl.is_reborn_applied,

        atter_buffs_added = AtterBuffsAdded2,

        atter_buffs_removed = BuffsRemoved2,

        additional_eff = AdditionalEff,

%%        defer_buffs_added = 	   DamSubDtl#dam_sub_dtl.defer_buffs_added   % 防守者新增的buff列表（通常是减益buff）
%%        ++ AddBuffsDtl#add_buffs_dtl.defer_buffs_added
%%          ++ DamCritSubDtl#dam_sub_dtl.defer_buffs_added
%%        ,
%%
%%        defer_buffs_removed = 	   OnBeDamDtl#on_be_dam_dtl.buffs_removed
%%        ++ AbsorbDamToMpDtl#absorb_dam_to_mp_dtl.buffs_removed
%%          ++ ReduceDamDtl#reduce_dam_dtl.defer_buffs_removed
%%          ++ DamSubDtl#dam_sub_dtl.defer_buffs_removed
%%          ++ ApplyUndeadEffDtl#apply_undead_eff_dtl.buffs_removed
%%          ++ DieDtl_Defer#die_details.buffs_removed
%%          ++ PurgeBuffsDtl#purge_buffs_dtl.defer_buffs_removed  % 防守者移除的buff列表（通常是护盾类的buff和死亡后移除的buff）
%%          ++ DamCritSubDtl#dam_sub_dtl.defer_buffs_removed
%%        ,
        defer_buffs_updated = 	   AbsorbDamToMpDtl#absorb_dam_to_mp_dtl.buffs_updated ++  ReduceDamDtl#reduce_dam_dtl.defer_buffs_updated
        ++ ReduceDamDtl#reduce_dam_dtl.defer_buffs_updated
          ++ DamSubDtl#dam_sub_dtl.defer_buffs_updated
          ++ ApplyUndeadEffDtl#apply_undead_eff_dtl.buffs_updated  % 防守者更新的buff列表
          ++ DamCritSubDtl#dam_sub_dtl.defer_buffs_updated
        ,

        protector_buffs_removed = ProtcDtl#protection_dtl.protector_buffs_removed, % 保护者移除的buff列表

        splash_dtl_list = lib_bt_splash:sum_two_splash_dtl_list(DamSubDtl#dam_sub_dtl.splash_dtl_list,DamCritSubDtl#dam_sub_dtl.splash_dtl_list)    % 溅射详情列表
      },


      ?BT_LOG(io_lib:format("CurRound=~p, AtterId=~p, DeferId=~p, AtterHpLeft=~p, RealDamToDefer=~p, DeferOldHp=~p, DeferHpLeft=~p~n",
        [lib_bt_comm:get_cur_round(), AtterId, DeferId, AtterHpLeft, RealDamToDefer, lib_bo:get_hp(Defer), DeferHpLeft])),

      {RetDtl,SupportDet}
  end.

%%死亡触发支援
die_trriger_passi_support(ObjIdList) ->
  SupportFun =
    fun(Bo,SupportAcc) ->
      %%死去的bo必须是门客
      case  Bo#battle_obj.type  == ?OBJ_PARTNER andalso Bo#battle_obj.attrs#attrs.hp < 1 of
        true ->
          %%检测该死亡的bo是否触发支援
          BeEffList = lib_bo:find_passi_eff_by_name_all(Bo, ?EN_DIE_TRRIGER_SUPPORT),
          ?DEBUG_MSG("getsupport ~p~n",[BeEffList]),
          case length(BeEffList) == 0 of
            true ->
              SupportAcc;
            false ->
              [PassiEff|_] = BeEffList,
              Proba = PassiEff#bo_peff.trigger_proba,
              case lib_bt_util:test_proba(Proba) of
                fail ->
                  ?DEBUG_MSG("fail suppory  ~p ~n",[PassiEff#bo_peff.buff_no]),
                  SupportAcc;
                success ->
                  Side = lib_bo:get_side(Bo),
                  Pos = Bo#battle_obj.pos,
                  %% 得到应该支援的门客
                  %% 允许副宠上阵的战斗中，若触发支援，上阵支援顺序按未出战的宠物战力降序进行支援
                  PlayerId =get({get_player_id_by_bo, Bo#battle_obj.id}),
                  PlayerBoId = get({get_bo_id_by_player_id,PlayerId }),
                  PlayerBo = get_bo_by_id(PlayerBoId),
%%
                  case player:is_online(PlayerId)  andalso not player:is_in_team_and_not_tmp_leave(player:get_PS(PlayerId))   of
                    true ->
                      %%拿出所有门客
                      AllParIdList = mod_partner:get_all_partner_id_by_battle_power(PlayerId)  -- PlayerBo#battle_obj.my_already_joined_battle_par_id_list,
                      ?DEBUG_MSG("wujiancheng ~p", [{PlayerBo#battle_obj.my_already_joined_battle_par_id_list,AllParIdList}]),

                      case length(AllParIdList) > 0 of
                        true ->
                          [PartnerIdH|_] = AllParIdList,
                          %%减去已经出战过的门客id
                          %%根据战力排列
                          {NewParBoId, NewParBo} = lib_bt_misc:generate_partner_bo2(lib_partner:get_partner(PartnerIdH), [Side, Pos],Bo#battle_obj.is_main_partner),
                          NewParBo2 = case Bo#battle_obj.is_main_partner of
                                        true ->
                                          NewParBo#battle_obj{is_main_partner = true};
                                        false ->
                                          NewParBo
                                      end,
                          case lib_bt_cmd:comm_handle_bo_summon_partner2__(PlayerBo, PartnerIdH, [Side, Pos], [NewParBoId, NewParBo2],Bo#battle_obj.is_main_partner) of
                            {ok, SummonDtl} ->
                              [#boa_summon{
                                actor_id = PlayerBoId,
                                result = ?RES_OK,
                                details = SummonDtl
                              } | SupportAcc];
                            {fail, _Reason} ->
                              SupportAcc
                          end;
                        false ->
                          SupportAcc
                      end;
                    false -> case player:is_online(PlayerId) of
                               true ->
                                 %% 禁止副宠上阵的战斗中，若触发支援，上阵顺序按副宠编号升序支援，若无可上阵副宠则按未出战的宠物战力降序进行支援
                                 IsBattlePartnerList =case  get({battle_order, PlayerId}) of
                                                        undefined ->
                                                          [];
                                                        GetPartList ->
                                                          case length(GetPartList) > 0 of
                                                            true ->
                                                              SortFun = fun({IndexA,_},{IndexB,_}) ->
                                                                IndexA > IndexB
                                                                        end,
                                                              NewIndexPartList = lists:sort(SortFun,GetPartList),
                                                              GetIndexParFun = fun({_,IndexPartnerId},IndexPartnerAcc) ->
                                                                [IndexPartnerId|IndexPartnerAcc]
                                                                               end,
                                                              lists:foldl(GetIndexParFun,[],NewIndexPartList);
                                                            false ->
                                                              []
                                                          end
                                                      end,
                                 PriBattleLists = IsBattlePartnerList -- PlayerBo#battle_obj.my_already_joined_battle_par_id_list,
                                 MidBattleLists= mod_partner:get_all_partner_id_by_battle_power(PlayerId)  -- PlayerBo#battle_obj.my_already_joined_battle_par_id_list,
                                 [PartnerIdH|_] = PriBattleLists ++ (MidBattleLists -- PriBattleLists),
                                 case length(PriBattleLists ++ (MidBattleLists -- PriBattleLists)) > 0 of
                                   true ->
                                     {NewParBoId, NewParBo} = lib_bt_misc:generate_partner_bo2(lib_partner:get_partner(PartnerIdH), [Side, Pos],Bo#battle_obj.is_main_partner),
                                     NewParBo2 = case Bo#battle_obj.is_main_partner of
                                                   true ->
                                                     NewParBo#battle_obj{is_main_partner = true};
                                                   false ->
                                                     NewParBo
                                                 end,
                                     case lib_bt_cmd:comm_handle_bo_summon_partner2__(PlayerBo, PartnerIdH, [Side, Pos], [NewParBoId, NewParBo2],Bo#battle_obj.is_main_partner) of
                                       {ok, SummonDtl} ->
                                         [#boa_summon{
                                           actor_id = PlayerBoId,
                                           result = ?RES_OK,
                                           details = SummonDtl
                                         } | SupportAcc];
                                       {fail, _Reason} ->
                                         SupportAcc
                                     end;
                                   false ->
                                     SupportAcc
                                 end;
                               false ->
                                 SupportAcc
                             end
                  end;
                false ->
                  SupportAcc
              end
          end;
        false ->
          SupportAcc
      end
    end,
  lists:foldl(SupportFun,[],ObjIdList).

%%  case get_bo_by_id(ObjId) of
%%    null ->
%%      [];
%%    Bo ->
%%      %%死去的bo必须是门客
%%      case  Bo#battle_obj.type  == ?OBJ_PARTNER of
%%        true ->
%%          %%检测该死亡的bo是否触发支援
%%          BeEffList = lib_bo:find_passi_eff_by_name_all(Bo, ?EN_DIE_TRRIGER_SUPPORT),
%%          case length(BeEffList) == 0 of
%%            true ->
%%              [];
%%            false ->
%%              [PassiEff|_] = BeEffList,
%%              Proba = PassiEff#bo_peff.trigger_proba,
%%              case lib_bt_util:test_proba(Proba) of
%%                fail ->
%%                  ?DEBUG_MSG("fail suppory  ~p ~n",[PassiEff#bo_peff.buff_no]),
%%                  [];
%%                success ->
%%                  Side = lib_bo:get_side(Bo),
%%                  Pos = lib_bo:decide_my_main_partner_pos(Bo),
%%
%%                  %%得到应该支援的门客
%%%%                  允许副宠上阵的战斗中，若触发支援，上阵支援顺序按未出战的宠物战力降序进行支援
%%                  PlayerId = Bo#battle_obj.my_owner_player_bo_id,
%%                  case player:is_online(PlayerId) andalso player:is_in_team_and_not_tmp_leave(player:get_PS(PlayerId)) of
%%                    true ->
%%                      %% 禁止副宠上阵的战斗中，若触发支援，上阵顺序按副宠编号升序支援，若无可上阵副宠则按未出战的宠物战力降序进行支援
%%                      IsBattlePartnerList =case  get({battle_order, PlayerId}) of
%%                                             undefined ->
%%                                               [];
%%                                             GetPartList ->
%%                                               case length(GetPartList) > 0 of
%%                                                 true ->
%%                                                   SortFun = fun({IndexA,_},{IndexB,_}) ->
%%                                                     IndexA > IndexB
%%                                                     end,
%%                                                   NewIndexPartList = lists:sort(SortFun,GetPartList),
%%                                                   GetIndexParFun = fun({_,IndexPartnerId},IndexPartnerAcc) ->
%%                                                     [IndexPartnerId|IndexPartnerAcc]
%%                                                       end,
%%                                                    lists:foldl(GetIndexParFun,[],NewIndexPartList);
%%                                                 false ->
%%                                                   []
%%                                               end
%%                                           end,
%%                      %%拿出所有门客
%%                      PlayerBoId = get({get_bo_id_by_player_id,PlayerId }),
%%                      PlayerBo = get_bo_by_id(PlayerBoId),
%%                      AllParIdList = player:get_all_partner_id_by_battle_power(player:get_PS(PlayerId)) -- IsBattlePartnerList -- PlayerBo#battle_obj.my_already_joined_battle_par_id_list,
%%                      [PartnerIdH|_] = IsBattlePartnerList --PlayerBo#battle_obj.my_already_joined_battle_par_id_list ++ AllParIdList,
%%                      %%减去已经出战过的门客id
%%                      %%根据战力排列
%%                      {NewParBoId, NewParBo} = lib_bt_misc:generate_partner_bo(lib_partner:get_partner(PartnerIdH), [Side, Pos]),
%%                      case lib_bt_cmd:comm_handle_bo_summon_partner__(PlayerBo, PartnerIdH, [Side, Pos], [NewParBoId, NewParBo]) of
%%                        {ok, SummonDtl} ->
%%                          [#boa_summon{
%%                            actor_id = PlayerBoId,
%%                            result = ?RES_OK,
%%                            details = SummonDtl
%%                          }];
%%                        {fail, _Reason} ->
%%                          % Tips = lib_bt_tips:build_tips(summon_partner_failed, [BoId, TargetParId, Reason]),
%%                          % ?ASSERT(is_record(Tips, btl_tips)),
%%                          % collect_battle_report(tips, Tips)
%%                          []
%%                      end;
%%                    false -> []
%%                  end
%%              end
%%          end;
%%            false ->
%%              []
%%          end
%%  end.


die_trriger_passi_support_test(ObjIdList) ->
  SupportFun =
    fun(Bo,SupportAcc) ->

      %%死去的bo必须是门客
      case  Bo#battle_obj.type  == ?OBJ_PARTNER andalso Bo#battle_obj.attrs#attrs.hp < 1 of
        true ->

          Side = lib_bo:get_side(Bo),
          Pos = Bo#battle_obj.pos,

          %%得到应该支援的门客
%%                  允许副宠上阵的战斗中，若触发支援，上阵支援顺序按未出战的宠物战力降序进行支援
          PlayerId =get({get_player_id_by_bo, Bo#battle_obj.id}),
%%              andalso player:is_in_team_and_not_tmp_leave(player:get_PS(PlayerId))
          case player:is_online(PlayerId)  of
            true ->
              %% 禁止副宠上阵的战斗中，若触发支援，上阵顺序按副宠编号升序支援，若无可上阵副宠则按未出战的宠物战力降序进行支援
              IsBattlePartnerList =case  get({battle_order, PlayerId}) of
                                     undefined ->
                                       [];
                                     GetPartList ->
                                       case length(GetPartList) > 0 of
                                         true ->
                                           SortFun = fun({IndexA,_},{IndexB,_}) ->
                                             IndexA > IndexB
                                                     end,
                                           NewIndexPartList = lists:sort(SortFun,GetPartList),
                                           GetIndexParFun = fun({_,IndexPartnerId},IndexPartnerAcc) ->
                                             [IndexPartnerId|IndexPartnerAcc]
                                                            end,
                                           lists:foldl(GetIndexParFun,[],NewIndexPartList);
                                         false ->
                                           []
                                       end
                                   end,
              %%拿出所有门客
              PlayerBoId = get({get_bo_id_by_player_id,PlayerId }),
              PlayerBo = get_bo_by_id(PlayerBoId),
              AllParIdList = mod_partner:get_all_partner_id_by_battle_power(PlayerId) -- IsBattlePartnerList -- PlayerBo#battle_obj.my_already_joined_battle_par_id_list,
              ?DEBUG_MSG("wujiancheng ~p", [{IsBattlePartnerList,  PlayerBo#battle_obj.my_already_joined_battle_par_id_list,AllParIdList}]),
              [PartnerIdH|_] = (IsBattlePartnerList --PlayerBo#battle_obj.my_already_joined_battle_par_id_list) ++ AllParIdList,
              %%减去已经出战过的门客id
              %%根据战力排列
              {NewParBoId, NewParBo} = lib_bt_misc:generate_partner_bo(lib_partner:get_partner(PartnerIdH), [Side, Pos]),
              case lib_bt_cmd:comm_handle_bo_summon_partner__(PlayerBo, PartnerIdH, [Side, Pos], [NewParBoId, NewParBo]) of
                {ok, SummonDtl} ->
                  [#boa_summon{
                    actor_id = PlayerBoId,
                    result = ?RES_OK,
                    details = SummonDtl
                  } | SupportAcc];
                {fail, _Reason} ->
                  % Tips = lib_bt_tips:build_tips(summon_partner_failed, [BoId, TargetParId, Reason]),
                  % ?ASSERT(is_record(Tips, btl_tips)),
                  % collect_battle_report(tips, Tips)
                  SupportAcc
              end;
            false -> SupportAcc

          end;
        false ->
          SupportAcc
      end
    end,
  lists:foldl(SupportFun,[],ObjIdList).



check_and_handle_hp_buff_Test(DeferId, AtterId) ->
  AllBoId = lib_bt_comm:get_all_bo_id_list(),
  F =
    fun(X, Acc) ->
      case get_bo_by_id(X) of
        null ->
          Acc;
        Bo ->
          HurtValue = 180,
          lib_bo:add_hp(X,  HurtValue),
          %%是这两个B就不需要计算他们的死亡和重生了以及其他情况
          HurtDetail =
            case X == DeferId orelse  X == AtterId  of
              true ->
                [#additional_dtl{boid = X, type = 1 , dam_hp = HurtValue}];
              false ->
                %%判断玩家是否重生
                RebornDtl = try_apply_reborn_eff(X),
                IsReborn =
                  case RebornDtl#reborn_dtl.is_reborn_applied of
                    true ->
                      1;
                    false ->
                      0
                  end,
                {HpLeft, DieDtl} = check_and_handle_bo_die(get_bo_by_id(X), Bo),
                [ #additional_dtl{boid = X, type = 1 , dam_hp = HurtValue, be_bo_is_apply_reborn = IsReborn,bo_hp_left = HpLeft, be_bo_dieStatus = DieDtl#die_details.die_status} ]
            end,

          case get_bo_by_id(X) of
            null ->
              HurtDetail ++ Acc;
            Bo2 ->
              HealValue =750,
              lib_bo:add_hp(X, -HealValue),
              %%是这两个B就不需要计算他们的死亡和重生了以及其他情况
              case X == DeferId orelse  X == AtterId  of
                true ->
                  [#additional_dtl{boid = X, type = 2 , dam_hp = HealValue}] ++  HurtDetail ++ Acc;
                false ->
                  %%判断玩家是否重生
                  RebornDtl2 = try_apply_reborn_eff(X),
                  IsReborn2 =
                    case RebornDtl2#reborn_dtl.is_reborn_applied of
                      true ->
                        1;
                      false ->
                        0
                    end,
                  {HpLeft2, DieDtl2} = check_and_handle_bo_die(get_bo_by_id(X), Bo2),
                  [ #additional_dtl{boid = X, type = 2 , dam_hp = HealValue, be_bo_is_apply_reborn = IsReborn2,bo_hp_left = HpLeft2, be_bo_dieStatus = DieDtl2#die_details.die_status} ] ++ HurtDetail ++ Acc
              end

          end
      end
    end,
  RetDetailInfo = lists:foldl(F, [], AllBoId),
  [RetDetailInfo, []].

%%#update_buffs_rule_dtl{
%%bo_id = TargetBoId,
%%atter_buffs_added = BuffsAdded,
%%atter_buffs_removed = BuffsRemoved
%%}
check_and_handle_hp_buff(DeferId, AtterId) ->
  AllBoId = lib_bt_comm:get_all_bo_id_list(),
  F =
    fun(X, [Acc, Acc2]) ->
      case get_bo_by_id(X) of
        null ->
          [Acc,Acc2];
        Bo ->
          [HurtDetail, HurtRemovedBuff] =
            case lib_bo:find_buff_by_name(Bo, ?BFN_HEAL_HP_AT_ONCE) of
              null ->
                [[], []];
              HealBuff ->
                HealValue = lib_bo_buff:get_eff_real_value(HealBuff),
                lib_bo:add_hp(X, HealValue),
                lib_bo:remove_buff(X, HealBuff),
                %%是这两个B就不需要计算他们的死亡和重生了以及其他情况
                case X == DeferId orelse  X == AtterId  of
                  true ->
                    [[#additional_dtl{boid = X, type = 1 , dam_hp = HealValue}],  [#update_buffs_rule_dtl{
                      bo_id = X,
                      atter_buffs_removed = [HealBuff#bo_buff.buff_no]
                    }] ];
                  false ->
                    %%判断玩家是否重生
                    RebornDtl = try_apply_reborn_eff(X),
                    IsReborn =
                      case RebornDtl#reborn_dtl.is_reborn_applied of
                        true ->
                          1;
                        false ->
                          0
                      end,
                    {HpLeft, DieDtl} = check_and_handle_bo_die(get_bo_by_id(X), Bo),
                    [ [#additional_dtl{boid = X, type = 1 , dam_hp = HealValue, be_bo_is_apply_reborn = IsReborn,bo_hp_left = HpLeft, be_bo_dieStatus = DieDtl#die_details.die_status}],  [#update_buffs_rule_dtl{
                      bo_id = X,
                      atter_buffs_removed = [HealBuff#bo_buff.buff_no]
                    }] ]
                end
            end,

%%          [HurtDetail2, HurtRemovedBuff2] = case lib_bo:find_buff_by_name(Bo, ?BFN_HEAL_ANGER_AT_ONCE ) of
%%            null ->
%%              [Acc ++ HurtDetail,Acc2 ++ HurtRemovedBuff];
%%            AngerBuff ->
%%              AngerValue = lib_bo_buff:get_eff_real_value(AngerBuff),
%%              lib_bo:add_anger(X, AngerValue),
%%              lib_bo:remove_buff(X, AngerBuff),
%%                  [ [#additional_dtl{boid = X, type = 3 , dam_hp = AngerValue, bo_hp_left = lib_bo:get_anger(Bo) + AngerValue}] ++ HurtDetail ++ Acc  ,  [#update_buffs_rule_dtl{
%%                    bo_id = X,
%%                    atter_buffs_removed = [AngerBuff#bo_buff.buff_no]
%%                  }] ++ HurtRemovedBuff ++ Acc2  ]
%%          end,

          case lib_bo:find_buff_by_name(Bo, ?BFN_HURT_HP_AT_ONCE ) of
            null ->
              [Acc ++ HurtDetail,Acc2 ++ HurtRemovedBuff];
            HurtlBuff ->
              HurtValue = lib_bo_buff:get_eff_real_value(HurtlBuff),
              lib_bo:add_hp(X, -HurtValue),
              lib_bo:remove_buff(X, HurtlBuff),
              %%是这两个B就不需要计算他们的死亡和重生了以及其他情况
              case X == DeferId orelse  X == AtterId  of
                true ->
                  [ [#additional_dtl{boid = X, type = 2 , dam_hp = HurtValue}] ++ HurtDetail ++ Acc  ,  [#update_buffs_rule_dtl{
                    bo_id = X,
                    atter_buffs_removed = [HurtlBuff#bo_buff.buff_no]
                  }] ++ HurtRemovedBuff ++ Acc2  ];
                false ->
                  %%判断玩家是否重生
                  RebornDtl2 = try_apply_reborn_eff(X),
                  IsReborn2 =
                    case RebornDtl2#reborn_dtl.is_reborn_applied of
                      true ->
                        1;
                      false ->
                        0
                    end,
                  {HpLeft2, DieDtl2} = check_and_handle_bo_die(get_bo_by_id(X), Bo),
                  [ [#additional_dtl{boid = X, type = 2 , dam_hp = HurtValue, be_bo_is_apply_reborn = IsReborn2,bo_hp_left = HpLeft2, be_bo_dieStatus = DieDtl2#die_details.die_status} ] ++ HurtDetail ++ Acc ,[#update_buffs_rule_dtl{
                    bo_id = X,
                    atter_buffs_removed = [HurtlBuff#bo_buff.buff_no]
                  }] ++ HurtRemovedBuff ++ Acc2 ]
              end
          end
      end
    end,
  lists:foldl(F, [[],[]], AllBoId).




check_and_handle_bo_die(Bo, Killer) ->
  case is_dead(Bo) of
    true ->
      HpLeft = 0,
      DieDtl = lib_bo:bo_die(Bo, Killer);
    false ->
      HpLeft = lib_bo:get_hp(Bo),
      DieDtl = #die_details{}
  end,
  ?ASSERT(is_record(DieDtl, die_details)),
  {HpLeft, DieDtl}.


%% 实施法术伤害
%% !!!!!!!!注意：考虑到反转伤害的情况，参数DamVal有可能为负数，此时不是给目标造成伤害，而是反之给他加血!!!!!!!
do_apply_mag_dam(Atter, Defer, DamVal,CritInfo) ->
  ?ASSERT(is_integer(DamVal), DamVal),

  case DamVal == 0 of
    true ->
      build_mag_dam_details(for_immu_dam_success, Atter, Defer);
    false ->
      AtterId = lib_bo:get_id(Atter),
      DeferId = lib_bo:get_id(Defer),

      io:format("TestDam DeferId: ~p, DamVal: ~p ~n",[DeferId,DamVal]),

      {AtterFiveElement, AtterFiveElementLv} = Atter#battle_obj.five_elements,

      {DeferFiveElement, DeferFiveElementLv} = Defer#battle_obj.five_elements,

      FiveElementCoef =
        case lib_bo:get_cur_skill_cfg(Atter) of
          null ->
            1;
          SkillCfgData ->
            AtterFiveElement2 =  SkillCfgData#skl_cfg.five_elements,
            AtterFiveElementData = data_five_elements:get(AtterFiveElement2),
            case lists:member(DeferFiveElement,AtterFiveElementData#five_elements.restraint) of
              true ->
                AtterFiveElementData#five_elements.re_num;
              false ->
                case lists:member(DeferFiveElement,AtterFiveElementData#five_elements.berestraint) of
                  true ->
                    AtterFiveElementData#five_elements.be_num;
                  false ->
                    1
                end
            end
        end,

      OnBeDamDtl = lib_bo:on_event(DeferId, be_mag_dam),

      % TODO: 处理护盾（反弹伤害， 抵挡伤害）
      % ...

      TRealDamToDefer = DamVal,

      RealDamToDefer0 = case lib_bo:is_dam_full(Atter) of
                          true -> TRealDamToDefer;
                          false -> lib_bo:try_apply_passi_eff_on_dam_for_hp(Defer, TRealDamToDefer, ?EN_PROTECT_HP_BY_RATE_BASE_LIM)
                        end,

      %%五行的幽灵五级要特殊处理，根据攻击者的血量分别有不同的伤害
      YouLingCoef =
        case  AtterFiveElement == 6 andalso AtterFiveElementLv ==5 of
          true ->
            AtterHpLim = Atter#battle_obj.attrs#attrs.hp_lim,
            AtterHp = Atter#battle_obj.attrs#attrs.hp,
            if (AtterHp/AtterHpLim) =< 0.2 -> 1.2;
              (AtterHp/AtterHpLim) =< 0.5 -> 1.15;
              (AtterHp/AtterHpLim) =< 0.8 -> 1.1;
              true -> 1
            end;
          false ->
            1
        end,

      RealDamToDefer = util:floor(FiveElementCoef * RealDamToDefer0 * YouLingCoef),

      % RealDamToDefer = lib_bo:try_apply_passi_eff_on_dam_for_hp(Defer, TRealDamToDefer, ?EN_PROTECT_HP_BY_RATE_BASE_LIM),

      Atter2 = Atter,

      Defer2 = lib_bo:add_hp(DeferId, - RealDamToDefer),

      DamSubDtl = try_handle_skill_in_effs(Atter2, Defer2, RealDamToDefer, false),

      %% 增加攻击中特殊条件触发 例如暴击时
      DamCritSubDtl = try_handle_crit_in_effs(get_bo_by_id(AtterId), get_bo_by_id(DeferId), CritInfo,RealDamToDefer),

      ?ASSERT(is_record(DamSubDtl, dam_sub_dtl), DamSubDtl),
      % ?BT_LOG(io_lib:format("do_apply_mag_dam(), DamSubDtl:~p~n", [DamSubDtl])),

      %% 防御者实际血量变化
      DeferRealHpChange = lib_bo:get_hp(Defer) - lib_bo:get_hp(Defer2),

      % 尝试应用反震（反弹伤害）流程
      RetDamDtl = try_apply_return_dam_to_attacker(AtterId, DeferId, DeferRealHpChange, false),

      % 反弹伤害等于
      RetDam = RetDamDtl#ret_dam_dtl.dam_returned,

      %%吸血
      AbsorbedHp = lib_bo:try_apply_absorb_hp(AtterId, DeferId, DamVal * get_cur_skill_count_type(AtterId)),
      ?DEBUG_MSG("magbattleabsorbedhp ~p ~n",[AbsorbedHp]),
      % ?DEBUG_MSG("mag_dam RetDam = ~p",[RetDam]),
      %%伤害护盾的更新
      ReduceDamDtl = lib_bo:try_apply_reduce_mag_dam_shield_once(DeferId, DamVal), %%wjc

      %%  攻击者被反弹反震的BUFF消除
      AtterReduceDamDtl = lib_bo:try_apply_reduce_mag_dam_shield_once(lib_bo:id(Atter), RetDam),
      ?ASSERT(is_record(AtterReduceDamDtl, reduce_dam_dtl)),




%%      %%检测是否有额外扣血或着回血的buff
%%      [AdditionalEff, AdditionalRemoveBuff]  = check_and_handle_hp_buff(DeferId, AtterId),

      % ?DEBUG_MSG("mag_dam AtterReduceDamDtl = ~p",[AtterReduceDamDtl]),

      % 尝试应用重生效果
      RebornDtl_Defer = try_apply_reborn_eff(DeferId),
      RebornDtl_Atter = try_apply_reborn_eff(AtterId),

      % 重新获取， 以保证是最新的
      Atter3 = get_bo_by_id(AtterId),
      Defer3 = get_bo_by_id(DeferId),
      BeEffList1 = lib_bo:find_passi_eff_by_name_all(Defer3, ?EN_ADD_BUFF_ON_HP_LOW),
      OnHPLowDtl =lib_bo_buff:trigger_passi_buff_on_lowHP(lib_bo:get_hp(Defer3),get_bo_by_id(DeferId),AtterId,BeEffList1),

      %%获取死亡时被动触发的buff
      DieTriggerBuffDtl = die_trriger_passi_buff( get_bo_by_id(AtterId), get_bo_by_id(DeferId),AtterId,DeferId),
      SkillkillDeferDtl =
        case is_dead(get_bo_by_id(DeferId)) of
          false ->
            [];
          true ->
            case Atter#battle_obj.tmp_status#bo_tmp_stat.kill_target_add_buff of
              0 ->
                [];
              PassiEffNo ->
                lib_bo:set_tmp_kill_target_add_buff(AtterId, 0),
                PassiEffData = data_passi_eff:get(PassiEffNo),
                BeBuffPassi = lib_bt_misc:apply_add_buff_on_kill_bo( (lib_bo:get_cur_skill_brief(Atter))#bo_skl_brf.id,PassiEffData),
                case  BeBuffPassi of
                  [] ->
                    [];
                  _ ->
                    lib_bo:try_apply_passi_eff_add_buff_on_condition(get_bo_by_id(AtterId),DeferId , BeBuffPassi)
                end

            end
        end,
      {DeferHpLeft, DieDtl_Defer} = check_and_handle_bo_die(get_bo_by_id(DeferId), get_bo_by_id(AtterId)),
      {AtterHpLeft, DieDtl_Atter} = check_and_handle_bo_die( get_bo_by_id(AtterId), get_bo_by_id(DeferId)),% 攻击者有可能被反弹死

      %% 伤害低于某个百分比时是否要释放技能？ wjc2019.9.18
      %% 伤害低于某个百分比时是否要释放技能？ wjc2019.9.18
      %%返回对象和buff表的数组
      SupportDet = die_trriger_passi_support([Atter3,Defer3]),
      AtterBuffF =
        fun(AtterBuffX, AtterBuffAcc) ->
          AtterBuffBoId = AtterBuffX#update_buffs_rule_dtl.bo_id,
          AtterBuffAdded = AtterBuffX#update_buffs_rule_dtl.atter_buffs_added,
          case lists:keytake(AtterBuffBoId, 1 ,AtterBuffAcc) of
            false ->
              [{AtterBuffBoId, AtterBuffAdded} | AtterBuffAcc];
            {value ,{AtterBuffBoId, OldAtterBuffAdded}, RemainAtterBuffAcc} ->
              [{AtterBuffBoId, OldAtterBuffAdded ++ AtterBuffAdded}|RemainAtterBuffAcc]
          end
        end,
      AtterBuffsAdded = lists:foldl(AtterBuffF, [], OnHPLowDtl ++DieTriggerBuffDtl ++ SkillkillDeferDtl ), %% [{Boid,BuffLists},···]

      AtterRemovedBuffF =
        fun(AtterBuffX, AtterBuffAcc) ->
          AtterBuffBoId = AtterBuffX#update_buffs_rule_dtl.bo_id,
          AtterBuffAdded = AtterBuffX#update_buffs_rule_dtl.atter_buffs_removed,
          case lists:keytake(AtterBuffBoId, 1 ,AtterBuffAcc) of
            false ->
              [{AtterBuffBoId, AtterBuffAdded} | AtterBuffAcc];
            {value ,{AtterBuffBoId, OldAtterBuffAdded}, RemainAtterBuffAcc} ->
              [{AtterBuffBoId, OldAtterBuffAdded ++ AtterBuffAdded}|RemainAtterBuffAcc]
          end
        end,
      BuffsRemoved = lists:foldl(AtterRemovedBuffF, [], OnHPLowDtl ++ DieTriggerBuffDtl  ++ SkillkillDeferDtl),

      AdditionalEff =
        case get(extra_buff_eff) of
          undefined ->
            [];
          BuffEff ->
            put(extra_buff_eff,[]),
            BuffEff
        end,
      %%对攻击者和防御者做特殊处理，比其他人多出buff
      AtterBuffsAdded2 = case lists:keytake(AtterId, 1, AtterBuffsAdded) of
                           false ->
                             [{AtterId, DamSubDtl#dam_sub_dtl.atter_buffs_added   % 攻击者新增的buff列表（通常是增益buff）
                               ++ DamCritSubDtl#dam_sub_dtl.atter_buffs_added}] ++ AtterBuffsAdded ;
                           {value ,{AtterId, AtterHaveBuffAdded}, RemainAtterBuff} ->
                             [{AtterId, DamSubDtl#dam_sub_dtl.atter_buffs_added   % 攻击者新增的buff列表（通常是增益buff）
                               ++ DamCritSubDtl#dam_sub_dtl.atter_buffs_added ++AtterHaveBuffAdded }] ++ RemainAtterBuff
                         end,
      BuffsRemoved2 = case lists:keytake(DeferId, 1, BuffsRemoved) of
                        false ->
                          [{DeferId,  DamSubDtl#dam_sub_dtl.atter_buffs_removed
                            ++ DieDtl_Atter#die_details.buffs_removed
                          ++  ReduceDamDtl#reduce_dam_dtl.defer_buffs_removed
                            ++ AtterReduceDamDtl#reduce_dam_dtl.defer_buffs_removed
                            ++ DamCritSubDtl#dam_sub_dtl.atter_buffs_removed}] ++ AtterBuffsAdded ;
                        {value ,{DeferId, HaveBuffAdded}, RemainBuff} ->
                          [{DeferId,  DamSubDtl#dam_sub_dtl.atter_buffs_removed
                            ++ DieDtl_Atter#die_details.buffs_removed
                            ++  ReduceDamDtl#reduce_dam_dtl.defer_buffs_removed
                            ++ AtterReduceDamDtl#reduce_dam_dtl.defer_buffs_removed
                            ++ DamCritSubDtl#dam_sub_dtl.atter_buffs_removed ++HaveBuffAdded }] ++ RemainBuff
                      end,
      % 返回伤害详情是为了后续的收集战报
      {#mag_dam_dtl{
        atter_id = AtterId,             % 攻击者的bo id
        defer_id = DeferId,             % 防守者的bo id

        dam_to_defer = RealDamToDefer,         % 对防守者的伤害值
        dam_to_defer_mp = DamSubDtl#dam_sub_dtl.dam_to_mp,  % 对防守者的伤害值（伤蓝）
        dam_to_defer_anger = (lib_bo:get_anger(Defer) - lib_bo:get_anger(Defer3)),  % 对防守者的伤害值（伤蓝）
        atter_hp_left = AtterHpLeft,        % 攻击者的剩余血量
        atter_mp_left = lib_bo:get_mp(Atter3),
        atter_anger_left = lib_bo:get_anger(Atter3),
        atter_die_status = DieDtl_Atter#die_details.die_status,

        additional_eff = AdditionalEff,
        absorbed_hp =   AbsorbedHp,
        is_atter_apply_reborn = RebornDtl_Atter#reborn_dtl.is_reborn_applied,

        ret_dam = RetDamDtl#ret_dam_dtl.dam_returned,              % 反弹的伤害值
        ret_dam_anger = RetDamDtl#ret_dam_dtl.dam_returned_anger,  % 反弹的怒气变化

        defer_hp_left = DeferHpLeft,        % 防守者的剩余血量
        defer_mp_left = lib_bo:get_mp(Defer3),
        defer_anger_left = lib_bo:get_anger(Defer3),
        defer_die_status = DieDtl_Defer#die_details.die_status,
        is_defer_apply_reborn = RebornDtl_Defer#reborn_dtl.is_reborn_applied,

        atter_buffs_added = AtterBuffsAdded2,

        atter_buffs_removed = BuffsRemoved2,

        defer_buffs_updated = DamSubDtl#dam_sub_dtl.defer_buffs_updated ++  ReduceDamDtl#reduce_dam_dtl.defer_buffs_updated ++  DamCritSubDtl#dam_sub_dtl.defer_buffs_updated,   % 防守者更新的buff列表

        % splash_dtl_list = DamSubDtl#dam_sub_dtl.splash_dtl_list            % 溅射详情列表
        splash_dtl_list = lib_bt_splash:sum_two_splash_dtl_list(DamSubDtl#dam_sub_dtl.splash_dtl_list,DamCritSubDtl#dam_sub_dtl.splash_dtl_list)    % 溅射详情列表
      },SupportDet}
  end.

%%死亡时被动触发的buff 2019.10.11 wjc
die_trriger_passi_buff(Atter3,Defer3,AtterId,DeferId) ->


  %%自身死亡
  SelfDieEffList = lib_bo:find_passi_eff_by_name_all(Defer3, ?EN_SELF_WHILE_DIE),

  %%自身死亡
  SelfDieEffList2 = lib_bo:find_passi_eff_by_name_all(Atter3, ?EN_SELF_WHILE_DIE),

  %%敌方死亡时加buff
  DietriggerBuffDtl =
    case is_dead(Defer3) of
      false ->
        [];
      true ->
        MySideAllBoId = lib_bt_comm:get_bo_id_list(lib_bo:get_side(Atter3)),
        EnemySideDieFun =
          fun(MySideDieX, MySideDieAcc) ->
            EnemyDieEffList2 = lib_bo:find_passi_eff_by_name_all(get_bo_by_id(MySideDieX), ?EN_ENEMY_WHILE_DIE),
            MySideDieAcc ++ lib_bo_buff:trigger_passi_buff_while_enemy_die(get_bo_by_id(MySideDieX),AtterId,EnemyDieEffList2)
          end,
        lists:foldl(EnemySideDieFun, [], MySideAllBoId)
    end,

  %%敌方死亡时加buff
  DietriggerBuffDtl2 =
    case is_dead(Atter3) of
      false ->
        [];
      true ->
        MySideAllBoId2 = lib_bt_comm:get_bo_id_list(lib_bo:get_side(Defer3)),
        EnemySideDieFun2 =
          fun(MySideDieX, MySideDieAcc) ->
            EnemyDieEffList2 = lib_bo:find_passi_eff_by_name_all(get_bo_by_id(MySideDieX), ?EN_ENEMY_WHILE_DIE),
            MySideDieAcc ++ lib_bo_buff:trigger_passi_buff_while_enemy_die(get_bo_by_id(MySideDieX),AtterId,EnemyDieEffList2)
          end,
        lists:foldl(EnemySideDieFun2, [], MySideAllBoId2)
    end,


  %自身死亡加buff
  DietriggerBuffDtl3 =
    case is_dead(Defer3) of
      false ->
        [];
      true ->
        lib_bo_buff:trigger_passi_buff_while_enemy_die(Defer3,AtterId,SelfDieEffList)
    end,

  %自身死亡加buff2
  DietriggerBuffDtl4 =
    case is_dead(Atter3) of
      false ->
        [];
      true ->
        lib_bo_buff:trigger_passi_buff_while_enemy_die(Atter3,DeferId,SelfDieEffList2)
    end,

  %%队友死亡时加buff,需要遍历出所有队友
  MySideDieDtl=
    case is_dead(Defer3) of
      false ->
        [];
      true ->
        MySideBoIdList = lib_bt_comm:get_bo_id_list(lib_bo:get_side(Defer3)),
        MySideDieFun =
          fun(MySideDieX, MySideDieAcc) ->

                TeamDieEffList = lib_bo:find_passi_eff_by_name_all(get_bo_by_id(MySideDieX), ?EN_FRIEND_WHILE_DIE),
                MySideDieAcc ++ lib_bo_buff:trigger_passi_buff_while_enemy_die(get_bo_by_id(MySideDieX),AtterId,TeamDieEffList)
          end,
        lists:foldl(MySideDieFun, [], MySideBoIdList)
    end,

  MySideDieDtl2=
    case is_dead(Atter3) of
      false ->
        [];
      true ->
        MySideBoIdList2 = lib_bt_comm:get_bo_id_list(lib_bo:get_side(Atter3)),
        MySideDieFun2 =
          fun(MySideDieX, MySideDieAcc) ->
            TeamDieEffList = lib_bo:find_passi_eff_by_name_all(get_bo_by_id(MySideDieX), ?EN_FRIEND_WHILE_DIE),
            MySideDieAcc ++ lib_bo_buff:trigger_passi_buff_while_enemy_die(get_bo_by_id(MySideDieX),DeferId,TeamDieEffList)
          end,
        lists:foldl(MySideDieFun2, [], MySideBoIdList2)
    end,

  BeEffList1 = lib_bo:find_passi_eff_by_name_all(Atter3 , ?EN_ADD_BUFF_ACTION_FRIEND_SURVIVAL),
  BeEffList1_1 = [BeEffListSub1 || BeEffListSub1 <- BeEffList1, BeEffListSub1#bo_peff.judge_action_moment > 1 ],
  AddBuffDetail = lib_bo_buff:trigger_passi_buff_begin_friend_survival(Atter3, 0, BeEffList1_1),

  BeEffList2 = lib_bo:find_passi_eff_by_name_all(Atter3, ?EN_ADD_BUFF_ACTION_ENEMY_SURVIVAL),
  BeEffList1_2= [BeEffListSub2 || BeEffListSub2 <- BeEffList2, BeEffListSub2#bo_peff.judge_action_moment > 1],
  AddBuffDetail2 = lib_bo_buff:trigger_passi_buff_begin_enemy_survival(Atter3, 0, BeEffList1_2),

  MySideDieDtl2 ++ MySideDieDtl ++ DietriggerBuffDtl4 ++ DietriggerBuffDtl3 ++ DietriggerBuffDtl2 ++ DietriggerBuffDtl ++ AddBuffDetail ++ AddBuffDetail2.

%% 处理战斗结束
handle_battle_finish() ->
  ?TRACE("handle_battle_finish()..~n"),
  State = get_battle_state(),
  case State#btl_state.already_handle_battle_finish of
    true ->
      skip;
    false ->
      set_battle_state(State#btl_state{
        already_handle_battle_finish = true  % 标记为已处理过战斗结束
      }),
      BattleId = State#btl_state.id,
      ?ASSERT(mod_battle_mgr:get_battle_pid_by_id(BattleId) =:= self()),
      mod_battle_mgr:destroy_battle(BattleId, normal)
  end.




calc_mon_left_can_be_killed_times(State) ->
  case State#btl_state.mon_id of
    ?INVALID_ID ->
      0;
    MonId ->
      case mod_mon:get_obj(MonId) of
        null ->
          0;
        MonObj ->
          case mod_mon:get_left_can_be_killed_times(MonObj) of
            infinite ->
              ?INFINITE_CAN_BE_KILLED_TIMES;
            Times ->
              case State#btl_state.win_side of
                ?HOST_SIDE ->
                  erlang:max(Times - 1, 0);  % 保险起见，做至少为0的矫正
                _ ->
                  Times
              end

          end
      end
  end.


build_world_boss_mf_info() ->
  Info = lib_bt_dict:get_world_boss_mf_info(),

  LeftHp = case lib_bt_misc:find_world_boss_bo() of
             null ->
               0;
             WorldBossBo ->
               lib_bo:get_hp(WorldBossBo)
           end,

  %%% PlayerBoList = lib_bt_comm:get_player_bo_list(?HOST_SIDE),
  %%% PlayerIdList = [lib_bo:get_parent_obj_id(X) || X <- PlayerBoList],

  PlayerIdList = lib_bt_comm:get_player_id_list_except_hired_player(?HOST_SIDE),

  Info#wb_mf_info{
    left_hp = LeftHp,
    left_player_id_list = PlayerIdList
  }.

get_guild_boss_left_hp() ->
  LeftHp  = case lib_bt_misc:find_guild_boss_bo() of
              null ->
                0;
              GuildBossBo ->
                lib_bo:get_hp(GuildBossBo)
            end.



build_comm_feedback_for_player(State) ->
  MonLeftCanBeKilledTimes = calc_mon_left_can_be_killed_times(State),

  WorldBossMfInfo = case lib_bt_comm:is_world_boss_mf_battle(State) of
                      true -> build_world_boss_mf_info();
                      false -> null
                    end,

  GuildBossHp = get_guild_boss_left_hp(),

  ?BT_LOG(io_lib:format("build_comm_feedback_for_player(), WorldBossMfInfo:~w~n", [WorldBossMfInfo])),

  #btl_feedback{
    battle_type = State#btl_state.type,
    battle_subtype = State#btl_state.subtype,
    mon_id = State#btl_state.mon_id,
    mon_no = State#btl_state.mon_no,
    bmon_group_no = State#btl_state.bmon_group_no,
    mon_left_can_be_killed_times = MonLeftCanBeKilledTimes,

    nth_wave_bmon_group = State#btl_state.nth_wave_bmon_group,

    spawned_bmon_list = lib_bt_dict:get_spawned_bmon_list(),
    lasting_time = max(svr_clock:get_unixtime() - State#btl_state.start_time, 1),
    lasting_rounds = State#btl_state.round_counter,

    world_boss_mf_info = WorldBossMfInfo,

    callback = State#btl_state.callback,
    guild_boss_hp = GuildBossHp
  }.






feedback_to_one_player(PlayerBoId, WinSide, Fb,RoadPlayerId) ->



  PlayerBo = get_bo_by_id(PlayerBoId),
  PlayerId = lib_bo:get_parent_obj_id(PlayerBo),
  LeftHp = lib_bo:get_hp(PlayerBo),
  LeftMp = lib_bo:get_mp(PlayerBo),
  MySide = lib_bo:get_side(PlayerBo),
  ParInfoList = build_partner_info_list_for_battle_feedback(PlayerBo),

  RoadData = mod_road:get_road_from_ets(RoadPlayerId),
  try
    case RoadData =:= null  of
      true -> skip;
      false ->

        IsRoad = RoadData#road_info.is_road,
        MyPartnerInfo = RoadData#road_info.partner_info,
        MyNowBattlePar = RoadData#road_info.now_battle_partner,
        TargetInfo = RoadData#road_info.pk_info,
        NowPoint = RoadData#road_info.now_point,

        %取经
        case IsRoad =:= 1 of
          true -> case MySide of   %1为主队，2为客队
                    1 ->
                      F = fun(X , Acc) ->
                        {PartnerId ,Hp ,Mp }  = X,
                        case lists:keyfind(PartnerId, 1, MyNowBattlePar) of
                          false ->Acc;
                          {_PartnerId,_Hp,_Mp,MaxHp,MaxMp,IsMain} -> [{PartnerId,Hp,Mp,MaxHp,MaxMp,IsMain}|Acc]
                        end

                          end,


                      NewMyNowBattlePar = lists:foldl (F, [], ParInfoList),

                      F2 = fun(X2,Acc2) ->
                        {PartnerId2 ,Hp2 ,Mp2 }  = X2,
                        {_PartnerId,_Hp,_Mp,MaxHp,MaxMp} = lists:keyfind(PartnerId2, 1, MyPartnerInfo),

                        case Acc2 of
                          [] ->  lists:keyreplace(PartnerId2, 1, MyPartnerInfo, {PartnerId2 ,Hp2 ,Mp2,MaxHp, MaxMp});
                          _  ->  lists:keyreplace(PartnerId2, 1, Acc2, {PartnerId2 ,Hp2 ,Mp2,MaxHp, MaxMp})
                        end
                           end,
                      NewMyPartnerInfo = case length(ParInfoList) =:= 0 of
                                           true -> MyPartnerInfo;
                                           false ->lists:foldl(F2, [], ParInfoList)
                                         end,

                      RoadData2 = RoadData#road_info{partner_info = NewMyPartnerInfo, now_battle_partner = NewMyNowBattlePar },
                      mod_road:update_road_to_ets(RoadData2);
                    2 ->
                      NowPKPlayer  = lists:sublist( TargetInfo , NowPoint , 1),
                      [{OpponentsPlayerId2,Name,Faction,Lv,Sex,FivePartner}]  =  NowPKPlayer,
                      %	DelTargetInfo = lists:keydelete(PlayerId, 1, TargetInfo),

                      F = fun(X,Acc) ->
                        {PartnerId,Hp,Mp} = X,
                        {_PartnerId,_Hp,_Mp,MaxHp,MaxMp,IsMain} = lists:keyfind(PartnerId, 1, FivePartner),
                        [{PartnerId,Hp,Mp,MaxHp,MaxMp,IsMain} | Acc]
                          end,

                      NewFivePartner = lists:foldl(F, [], ParInfoList),

                      NewNowPKPlayer = {OpponentsPlayerId2,Name,Faction,Lv,Sex,NewFivePartner},

                      NewTargetInfo  = lists:keyreplace(OpponentsPlayerId2, 1, TargetInfo, NewNowPKPlayer),

                      %% 							NewTargetInfo = case NowPoint of
                      %% 												1 ->  lists:merge(NewNowPKPlayer,DelTargetInfo);
                      %% 												10 -> lists:merge(DelTargetInfo,NewNowPKPlayer);
                      %% 												_ -> RDelTargetInfo = lists:sublist( DelTargetInfo ,NowPoint  , 10 - NowPoint),
                      %% 													 LDelTargetInfo = lists:sublist( DelTargetInfo , 1  , NowPoint -1),
                      %% 													 lists:merge3(LDelTargetInfo,NewNowPKPlayer,RDelTargetInfo)
                      %% 											end,
                      RoadData2 = RoadData#road_info{pk_info = NewTargetInfo , is_road = 0 },
                      mod_road:update_road_to_ets(RoadData2)

                  end;
          false -> skip
        end
    end
  catch
    _:_ ->
      mod_road:del_road_from_ets(RoadPlayerId),
      skip
  end,




%% 				ParInfoList = [{1000400000039454,12772,8234},
%%                  {1000400000035524,4647,2638},
%%                  {1000400000007329,6627,2024}]     {X,Hp,Mp,Hp,Mp}
%%

  ?BT_LOG(io_lib:format("battle_feedback, PlayerBoId=~p, ParInfoList=~w~n", [?BOID(PlayerBo), ParInfoList])),

  MySideDeadPlayerCount = lib_bt_calc:calc_dead_player_count_of_side(MySide),

  Result = case WinSide of
             ?NO_SIDE ->
               draw;
             _ ->
               case WinSide == MySide of
                 true -> win;
                 false -> lose
               end
           end,

  Fb2 = Fb#btl_feedback{
    player_id = PlayerId,
    side = MySide,
    result = Result,
    left_hp = LeftHp,
    left_mp = LeftMp,
    partner_info_list = ParInfoList,
    oppo_player_id_list = lib_bo:get_my_pvp_oppo_player_id_list(PlayerBo),
    teammate_id_list = lib_bt_comm:get_player_id_list_except_hired_player(MySide) -- [PlayerId],
    hired_player_id = lib_bo:get_my_hired_player_id(PlayerBo),
    my_side_dead_player_count = MySideDeadPlayerCount
  },
  ?DEBUG_MSG("Fb2: mon_id: ~p, mon_no:~p, bmon_group_no:~p, lasting_time:~p, lasting_rounds:~p, my_side_dead_player_count:~p, oppo_player_id_list:~p, hired_player_id:~p~n",
    [Fb2#btl_feedback.mon_id, Fb2#btl_feedback.mon_no, Fb2#btl_feedback.bmon_group_no, Fb2#btl_feedback.lasting_time, Fb2#btl_feedback.lasting_rounds, Fb2#btl_feedback.my_side_dead_player_count,
      Fb2#btl_feedback.oppo_player_id_list, Fb2#btl_feedback.hired_player_id]),
  ?DEBUG_MSG("lib_bt_comm:is_online(PlayerBo)=~p,player:in_tmplogout_cache(PlayerId)=~p",[lib_bt_comm:is_online(PlayerBo),player:in_tmplogout_cache(PlayerId)]),

  case lib_bt_comm:is_online(PlayerBo) of
    true ->
      mod_player:battle_feedback(PlayerId, Fb2);
    false ->
      case player:in_tmplogout_cache(PlayerId) of
        true ->
          ply_tmplogout_cache:battle_feedback(PlayerId, Fb2);
        false ->

          % 如果完全掉线
          % Result = Fb2#btl_feedback.result,
          IsForcePk = lib_bt_comm:is_force_pk_battle(Fb2),
          % IsStartBattler = lib_bt_comm:is_start_battle_side(Fb2),

          % ?ERROR_MSG("Pk offline [~p,~p,~p,~p,~p,~p]",[PlayerId,Result,IsForcePk,lib_bt_comm:is_qiecuo_pk_battle(Fb2), lib_bt_comm:is_1v1_online_arena_battle(Fb2), lib_bt_comm:is_3v3_online_arena_battle(Fb2)]),
          case lib_bt_comm:is_qiecuo_pk_battle(Fb2) orelse lib_bt_comm:is_1v1_online_arena_battle(Fb2) orelse lib_bt_comm:is_3v3_online_arena_battle(Fb2) of
            true ->
              skip;
            false ->
              % 完全掉线并且是偷袭PVP 则标记为逃兵
              case ( Result == lose andalso IsForcePk) of
                true ->
                  lib_player_ext:try_update_data(PlayerId,pvp_flee,1);
                false ->
                  skip
              end
          end,



          skip
      end
  end,

  maybe_feedback_to_team_of_side(MySide, {PlayerBo, PlayerId}, Fb2).


%% 战斗反馈被某一方的队伍（一个队伍最多只反馈一次！）
maybe_feedback_to_team_of_side(Side, {PlayerBo, PlayerId}, Fb) ->
  case already_feekback_to_team_of_side(Side) of
    true ->
      skip;
    false ->
      case lib_bt_comm:is_online(PlayerBo)
        andalso player:is_in_team(PlayerId) of
        true ->
          ?BT_LOG(io_lib:format("maybe_feedback_to_team_of_side(), yes, PlayerId:~p, Side:~p", [PlayerId, Side])),
          mod_team_mgr:battle_feedback(Fb),
          mark_already_feekback_to_team_of_side(Side);
        false ->
          %% 单人战斗判断是否三界
          case lib_bt_comm:is_tve_mf_battle(Fb) of
            false -> skip;
            true -> mod_tve_mgr:tve_mf_callback(Fb)
          end,
          ?BT_LOG(io_lib:format("maybe_feedback_to_team_of_side(), not, PlayerId:~p, Side:~p", [PlayerId, Side])),
          skip
      end
  end.


already_feekback_to_team_of_side(Side) ->
  case erlang:get({?KN_ALREADY_FEEDBACK_TO_TEAM_OF_SIDE, Side}) of
    undefined ->
      false;
    BoolVal ->
      BoolVal
  end.

mark_already_feekback_to_team_of_side(Side) ->
  erlang:put({?KN_ALREADY_FEEDBACK_TO_TEAM_OF_SIDE, Side}, true).


% 不管是否在线都要反馈
get_player_bo_id_list_for_bt_feedback(Side) ->
  L = lib_bt_comm:get_player_bo_id_list(Side),
  L.
% F = fun(BoId) ->
% 		Bo = get_bo_by_id(BoId),
% 		case lib_bt_comm:is_online(Bo) of
% 			true ->
% 				true;
% 			false ->
% 				PlayerId = lib_bo:get_parent_obj_id(Bo),
% 				player:in_tmplogout_cache(PlayerId)
% 		end
% 	end,

% [X || X <- L, F(X)].



%% 战斗反馈给玩家
battle_feedback(to_players, State) ->
  WinSide = State#btl_state.win_side,
  ?TRACE("battle_feedback(to_players, ..), WinSide=~p, SpawnedBMonList=~p...~n", [WinSide, lib_bt_dict:get_spawned_bmon_list()]),
  ?TRACE("State#btl_state.mon_id: ~p~n", [State#btl_state.mon_id]),

  FbInfo = build_comm_feedback_for_player(State),
  ?TRACE("!!!!!!!FbInfo: ~p~n", [FbInfo]),

  % 反馈给主队的玩家
  FbPlayerBoIdL = get_player_bo_id_list_for_bt_feedback(?HOST_SIDE),
  FbPlayerBoIdL_Shuffled = tool:shuffle(FbPlayerBoIdL, length(FbPlayerBoIdL)),
  TeamMbL_Shuffled = [lib_bo:get_parent_obj_id(get_bo_by_id(X)) || X <- FbPlayerBoIdL_Shuffled],

  %%这里灵力值小于5将自动卸下法宝
  try lists:foreach(fun(HostPlayerId) ->
    RealPlayerId = lib_bo:get_parent_obj_id(get_bo_by_id(HostPlayerId)),
    case lib_fabao:get_fabao_battle(RealPlayerId) of
      [] -> [];
      FaBaoId ->
        case lib_fabao:get_fabao_info(FaBaoId) of
          [] ->
            lib_send:send_prompt_msg(RealPlayerId, ?PM_NO_HAVE_THIS),
            [];
          RecordData  ->
            SpValue = RecordData#fabao_info.sp_value,
            case SpValue < 5 of
              true ->
                lib_send:send_prompt_msg(RealPlayerId, ?PM_FABAO_AOTU_DOWN_BATTLE),
                lib_fabao:delete_fabao_battle(RealPlayerId),
                lib_fabao:update_fabao_info(RecordData#fabao_info{battle = 2}),
                lib_scene:notify_int_info_change_to_aoi(player, RealPlayerId, [{?OI_CODE_BATTLE_FABAO, 0}]),
                ply_attr:recount_all_attrs(player:get_PS(RealPlayerId));
              false ->
                skip
            end
        end
    end
                    end, FbPlayerBoIdL)
  catch T:E ->
    ?ERROR_MSG("[mod_battle] fabao wear occur error:~p", [{T, E  }])
  end,

  FbInfo2 = FbInfo#btl_feedback{
    shuffled_team_mb_list = TeamMbL_Shuffled
  },
  [RoadPlayerId] = lists:sublist(TeamMbL_Shuffled, 1, 1),
  [feedback_to_one_player(X, WinSide, FbInfo2, RoadPlayerId) || X <- FbPlayerBoIdL],


  % 反馈给客队的玩家(gs: guest side)
  FbPlayerBoIdL_gs = get_player_bo_id_list_for_bt_feedback(?GUEST_SIDE),
  FbPlayerBoIdL_Shuffled_gs = tool:shuffle(FbPlayerBoIdL_gs, length(FbPlayerBoIdL_gs)),
  TeamMbL_Shuffled_gs = [lib_bo:get_parent_obj_id(get_bo_by_id(X)) || X <- FbPlayerBoIdL_Shuffled_gs],

  FbInfo2_gs = FbInfo#btl_feedback{
    shuffled_team_mb_list = TeamMbL_Shuffled_gs
  },
  [feedback_to_one_player(X, WinSide, FbInfo2_gs,RoadPlayerId) || X <- FbPlayerBoIdL_gs],


  ?Ifc (lib_bt_comm:is_melee_battle(State))
  lib_melee:battle_feedback(
    WinSide,
    lib_bt_dict:get_melee_init_player_id_list(?HOST_SIDE),
    lib_bt_dict:get_melee_init_player_id_list(?GUEST_SIDE),
    State
)
?End;


%% 战斗反馈给明雷怪
battle_feedback(to_monster, State) ->
% BattleType = State#btl_state.type,
MonId = State#btl_state.mon_id,
?Ifc (lib_bt_comm:is_mf_battle(State) andalso MonId /= ?INVALID_ID)
WinSide = State#btl_state.win_side,
?TRACE("battle_feedback(to_monster, ..), WinSide=~p, SpawnedBMonList=~p...~n", [WinSide, lib_bt_dict:get_spawned_bmon_list()]),

Result = case WinSide of
?HOST_SIDE -> lose;
?GUEST_SIDE -> win;
?NO_SIDE -> draw
% undefine -> draw  % 异常错误导致战斗中途结束！算平局
end,

FbInfo = #btl_feedback{
% battle_type = BattleType,
% battle_subtype = State#btl_state.subtype,
result = Result
},

mod_mon:battle_feedback(MonId, FbInfo)
?End.




build_partner_info_list_for_battle_feedback(PlayerBo) ->
  L = lib_bo:get_my_partner_bo_info_list(PlayerBo),
  F = fun({PartnerBoId, PartnerId}) ->
    case get_bo_by_id(PartnerBoId) of
      null ->  % 不存在，表明宠物已死亡
        LeftHp = 0,
        LeftMp = lib_bt_dict:get_dead_partner_left_mp(PartnerBoId);
      PartnerBo ->
        LeftHp = lib_bo:get_hp(PartnerBo),
        LeftMp = lib_bo:get_mp(PartnerBo)
    end,
    % {宠物id， 剩余血量，剩余蓝量}
    {PartnerId, LeftHp, LeftMp}
      end,
  [F(X) || X <- L].




%% 是否可以触发反击？
can_strikeback(AtterId, DeferId) ->
  % Atter = get_bo_by_id(AtterId),
  % Defer = get_bo_by_id(DeferId),
  case is_dead(AtterId) orelse is_dead(DeferId) of
    true -> false;
    false ->
      Defer = get_bo_by_id(DeferId),
      Proba = lib_bo:get_strikeback_proba(Defer),  %%300,
      Atter = get_bo_by_id(AtterId),
      ?DEBUG_MSG("strikeback = ~p",[Proba]),
      Proba2 =Proba - lib_bo:get_neglect_ret_dam(Atter),
      ?DEBUG_MSG("strikeback2 = ~p",[Proba2]),
      case lib_bt_util:test_proba(Proba2) of
        fail ->
          ?BT_LOG(io_lib:format("can_strikeback(), AtterId=~p, DeferId=~p, failed for proba (~p)!!~n", [AtterId, DeferId, Proba])),
          false;
        success ->
          ?BT_LOG(io_lib:format("can_strikeback(), AtterId=~p, DeferId=~p, success for proba (~p)!!~n", [AtterId, DeferId, Proba])),

          case lib_bo:get_side(Atter) == lib_bo:get_side(Defer) andalso not lib_bo:is_chaos(Defer) of
            true -> false;  % 不能反击自己人（混乱攻击自己人时，不能反击他）
            false ->
              case lib_bo:cannot_act(Defer) of
                true -> false;  % 无法行动时不能反击
                false ->
                  true
              end
          end
      end
  end.






%% 使用技能
do_use_skill(Bo) ->
  BoId = lib_bo:get_id(Bo),

  handle_skill_pre_effs(BoId),

  try
    handle_skill_att_eff(BoId)
  catch
    throw: handle_attack_eff_done ->  % 处理技能的攻击效果完毕
      %%put(?KN_JUST_FOR_DEBUG_I_CATCH_BO_ACTION_FINISH, true), % 标记进入过了此流程，仅仅是为了调试
      ok;
    throw: battle_finish -> % 战斗结束
      throw(battle_finish)
  end,

  ?Ifc (is_living(BoId))  % bo攻击时有可能被反弹死，故这里判断（注：目前认为bo未死亡才需处理技能的攻击之后的效果）！
handle_skill_post_effs(BoId)
?End.



%% 处理技能的攻击前的效果
handle_skill_pre_effs(BoId) ->
  Bo = get_bo_by_id(BoId),

  % CurSkl = lib_bo:get_cur_skill_brief(Bo),
  % SklId = CurSkl#skl_brief.id,

  CurSklCfg = lib_bo:get_cur_skill_cfg(Bo),  %%lib_bt_comm:get_skill_cfg_data(CurSkl),
  ?ASSERT(CurSklCfg /= null, {lib_bo:get_cur_skill_brief(Bo), Bo}),

  case mod_skill:get_pre_effs(CurSklCfg) of
    PreEffList ->
      % ?ASSERT(is_list(PreEffList), CurSklCfg),
      CurSklId = mod_skill:get_id(CurSklCfg),
      BuffPreEff =
        case lib_bo:find_buff_by_name(Bo, ?BFN_ADD_SKILL_EFF) of
          null ->
            [];
          AddEffBuff ->
            AllEffList = lib_bo_buff:get_buff_tpl_para(AddEffBuff),
            PreList = case lists:keyfind(pre_effs, 1,AllEffList) of
                        false ->
                          [];
                        {pre_effs,PreList2} ->
                          PreList2
                      end
        end,
      List2 =  lists:merge(PreEffList,[2]),
      ?DEBUG_MSG("wjcPreEffBuff = ~p, PreList = ~p",[lib_bo:find_buff_by_name(Bo, ?BFN_ADD_SKILL_EFF),BuffPreEff]),
      handle_skill_pre_effs(BoId, CurSklId,List2 ++ BuffPreEff)
  end.



handle_skill_pre_effs(BoId, SkillId, [EffNo | T]) ->
  handle_one_skill_pre_eff(BoId, SkillId, EffNo),
  handle_skill_pre_effs(BoId, SkillId, T);

handle_skill_pre_effs(_BoId, _SkillId, []) ->
  done.











handle_one_skill_pre_eff(ActorId, SkillId, EffNo) ->
  Eff = lib_skill_eff:get_cfg_data(EffNo),
  ?ASSERT(Eff /= null, EffNo),
  % 确定作用目标
  case lib_bt_skill:decide_skill_eff_targets(ActorId, Eff) of
    [] ->
      skip;
    TarBoIdList ->
      handle_one_skill_pre_eff__(ActorId, SkillId, Eff, Eff#skl_eff.name, TarBoIdList)
  end.



% %% 设置物理连击数，不需收集战报!
% handle_one_skill_pre_eff__(ActorId, _SkillId, Eff, ?EN_SET_PHY_COMBO_ATT_TIMES, TarBoIdList) ->
% 	% 目前断言: 设置物理连击数只针对行动者自己，以后此断言可能不一定成立！
%     ?ASSERT(TarBoIdList =:= [ActorId], {TarBoIdList, ActorId, _SkillId, Eff}),

% 	% 判断概率是否成功？
% 	case lib_bt_util:test_proba(Eff#skl_eff.trigger_proba) of
%         fail ->
%             skip;
%         success ->
%         	F = fun(TarBoId) ->
%         			?ASSERT(get_bo_by_id(TarBoId) /= null, TarBoId),
% 					Times = Eff#skl_eff.para,
% 					?ASSERT(is_integer(Times), {Times, _SkillId, Eff}),
% 					lib_bo:set_base_phy_combo_att_times(TarBoId, Times),
% 					lib_bo:reset_left_phy_combo_att_times(TarBoId)
%         		end,

%         	lists:foreach(F, TarBoIdList)
%     end;


%% 临时强行设置物理连击数，不需收集战报!
handle_one_skill_pre_eff__(_ActorId, _SkillId, Eff, ?EN_TMP_FORCE_SET_PHY_COMBO_ATT_TIMES, TarBoIdList) ->
  % 注：目前断言设置物理连击数只针对行动者自己，以后此断言可能不一定成立！
  ?ASSERT(TarBoIdList =:= [_ActorId], {TarBoIdList, _ActorId, _SkillId, Eff}),


  case lib_bt_util:test_proba(Eff#skl_eff.trigger_proba) of
    fail ->
      skip;
    success ->
      F = fun(TarBoId) ->
        ?ASSERT(get_bo_by_id(TarBoId) /= null, TarBoId),
        Times = Eff#skl_eff.para,
        ?ASSERT(util:is_nonnegative_int(Times), {_SkillId, Eff}),

        lib_bo:set_tmp_force_phy_combo_att_proba(TarBoId, ?PROBABILITY_BASE), % 设为必定触发
        lib_bo:set_tmp_force_max_phy_combo_att_times(TarBoId, Times)
      % lib_bo:mark_phy_combo_att_status(TarBoId)
          end,

      lists:foreach(F, TarBoIdList)
  end;

%% 当前行动单位本次攻击击杀目标后加BUFF，不需收集战报!
handle_one_skill_pre_eff__(_ActorId, _SkillId, Eff, ?EN_TMP_KILL_TARGET_ADD_BUFF, TarBoIdList) ->
  ?ASSERT(TarBoIdList =:= [_ActorId], {TarBoIdList, _ActorId, _SkillId, Eff}),
  case lib_bt_util:test_proba(Eff#skl_eff.trigger_proba) of
    fail ->
      skip;
    success ->
      F = fun(TarBoId) ->
        ?ASSERT(get_bo_by_id(TarBoId) /= null, TarBoId),
        BuffNo = Eff#skl_eff.para,
        ?DEBUG_MSG("EN_TMP_KILL_TARGET_ADD_BUFF ~p~n",[BuffNo]),
        lib_bo:set_tmp_kill_target_add_buff(TarBoId, BuffNo)
      % lib_bo:mark_phy_combo_att_status(TarBoId)
          end,
      lists:foreach(F, TarBoIdList)
  end;

%% 当前行动单位本次攻击击杀目标后加BUFF，不需收集战报!
handle_one_skill_pre_eff__(_ActorId, _SkillId, Eff, ?EN_TMP_SELECT_FIRST_ADD_BUFF, TarBoIdList) ->
  ?ASSERT(TarBoIdList =:= [_ActorId], {TarBoIdList, _ActorId, _SkillId, Eff}),
  case lib_bt_util:test_proba(Eff#skl_eff.trigger_proba) of
    fail ->
      skip;
    success ->
      F = fun(TarBoId) ->
        ?ASSERT(get_bo_by_id(TarBoId) /= null, TarBoId),
        BuffNo = Eff#skl_eff.para,
        ?DEBUG_MSG("EN_TMP_SELECT_FIRST_ADD_BUFF ~p~n",[BuffNo]),
        lib_bo:set_tmp_select_target_add_buff(TarBoId, BuffNo)
      % lib_bo:mark_phy_combo_att_status(TarBoId)
          end,
      lists:foreach(F, TarBoIdList)
  end;

%% 当前行动单位本次攻击击杀目标后加BUFF，不需收集战报!
handle_one_skill_pre_eff__(_ActorId, _SkillId, Eff, ?EN_TMP_SELECT_FIRST_CAUSE_CRIT, TarBoIdList) ->
  ?ASSERT(TarBoIdList =:= [_ActorId], {TarBoIdList, _ActorId, _SkillId, Eff}),
  case lib_bt_util:test_proba(Eff#skl_eff.trigger_proba) of
    fail ->
      skip;
    success ->
      F = fun(TarBoId) ->
        ?ASSERT(get_bo_by_id(TarBoId) /= null, TarBoId),
        State = Eff#skl_eff.para,
        ?DEBUG_MSG("EN_TMP_SELECT_FIRST_CAUSE_CRIT ~p~n",[State]),
        lib_bo:set_tmp_select_target_cause_crite(get_bo_by_id(TarBoId), State)
      % lib_bo:mark_phy_combo_att_status(TarBoId)
          end,
      lists:foreach(F, TarBoIdList)
  end;



%% 临时强行设置追击概率，不需收集战报!
handle_one_skill_pre_eff__(_ActorId, _SkillId, Eff, ?EN_TMP_FORCE_SET_PURSUE_ATT_PROBA, TarBoIdList) ->
  % 注：目前断言只针对行动者自己，以后此断言可能不一定成立！
  ?ASSERT(TarBoIdList =:= [_ActorId], {TarBoIdList, _ActorId, _SkillId, Eff}),

  % 判断概率是否成功？
  case lib_bt_util:test_proba(Eff#skl_eff.trigger_proba) of
    fail ->
      skip;
    success ->
      F = fun(TarBoId) ->
        ?ASSERT(get_bo_by_id(TarBoId) /= null, TarBoId),
        Proba = Eff#skl_eff.para,
        ?ASSERT(util:is_nonnegative_int(Proba), {_SkillId, Eff}),
        lib_bo:set_tmp_force_pursue_att_proba(TarBoId, Proba)
          end,

      lists:foreach(F, TarBoIdList)
  end;


%% 临时强行设置追击次数上限，不需收集战报!
handle_one_skill_pre_eff__(_ActorId, _SkillId, Eff, ?EN_TMP_FORCE_SET_MAX_PURSUE_ATT_TIMES, TarBoIdList) ->
  % 注：目前断言只针对行动者自己，以后此断言可能不一定成立！
  ?ASSERT(TarBoIdList =:= [_ActorId], {TarBoIdList, _ActorId, _SkillId, Eff}),

  % 判断概率是否成功？
  case lib_bt_util:test_proba(Eff#skl_eff.trigger_proba) of
    fail ->
      skip;
    success ->
      F = fun(TarBoId) ->
        ?ASSERT(get_bo_by_id(TarBoId) /= null, TarBoId),
        Times = Eff#skl_eff.para,
        ?ASSERT(util:is_nonnegative_int(Times), {_SkillId, Eff}),
        lib_bo:set_tmp_force_max_pursue_att_times(TarBoId, Times)
          end,

      lists:foreach(F, TarBoIdList)
  end;


%% 临时强行设置追击伤害系数，不需收集战报!
handle_one_skill_pre_eff__(_ActorId, _SkillId, Eff, ?EN_TMP_FORCE_SET_PURSUE_ATT_DAM_COEF, TarBoIdList) ->
  % 注：目前断言只针对行动者自己，以后此断言可能不一定成立！
  ?ASSERT(TarBoIdList =:= [_ActorId], {TarBoIdList, _ActorId, _SkillId, Eff}),

  % 判断概率是否成功？
  case lib_bt_util:test_proba(Eff#skl_eff.trigger_proba) of
    fail ->
      skip;
    success ->
      F = fun(TarBoId) ->
        ?ASSERT(get_bo_by_id(TarBoId) /= null, TarBoId),
        PursueAttDamCoef = Eff#skl_eff.para,
        ?ASSERT(erlang:is_number(PursueAttDamCoef) andalso PursueAttDamCoef > 0, {_SkillId, Eff}),
        lib_bo:set_tmp_force_pursue_att_dam_coef(TarBoId, PursueAttDamCoef)
          end,

      lists:foreach(F, TarBoIdList)
  end;


%% 标记当前回合攻击时所造成的hp伤害为固定的伤害（具体值与心法等级相关），不需收集战报！
handle_one_skill_pre_eff__(_ActorId, _SkillId, Eff, ?EN_TMP_MARK_DO_FIX_HP_DAM_BY_XINFA_LV, TarBoIdList) ->
  % 目前断言: 此效果只针对行动者自己，以后此断言可能不一定成立！
  ?ASSERT(TarBoIdList =:= [_ActorId], {TarBoIdList, _ActorId, _SkillId, Eff}),

  % 判断概率是否成功？
  case lib_bt_util:test_proba(Eff#skl_eff.trigger_proba) of
    fail ->
      skip;
    success ->
      F = fun(TarBoId) ->
        ?ASSERT(get_bo_by_id(TarBoId) /= null, TarBoId),
        lib_bo:tmp_mark_do_fix_Hp_dam_by_xinfa_lv(TarBoId)
          end,

      lists:foreach(F, TarBoIdList)
  end;


%% 标记当前回合攻击时所造成的mp伤害为固定的伤害（具体值与心法等级相关），不需收集战报！
handle_one_skill_pre_eff__(_ActorId, _SkillId, Eff, ?EN_TMP_MARK_DO_FIX_MP_DAM_BY_XINFA_LV, TarBoIdList) ->
  % 目前断言: 此效果只针对行动者自己，以后此断言可能不一定成立！
  ?ASSERT(TarBoIdList =:= [_ActorId], {TarBoIdList, _ActorId, _SkillId, Eff}),

  % 判断概率是否成功？
  case lib_bt_util:test_proba(Eff#skl_eff.trigger_proba) of
    fail ->
      skip;
    success ->
      F = fun(TarBoId) ->
        ?ASSERT(get_bo_by_id(TarBoId) /= null, TarBoId),
        lib_bo:tmp_mark_do_fix_Mp_dam_by_xinfa_lv(TarBoId)
          end,

      lists:foreach(F, TarBoIdList)
  end;


handle_one_skill_pre_eff__(_ActorId, _SkillId, Eff, ?EN_TMP_MARK_DO_TWICE_PHY_ATT_BUT_REDUCE_PHY_ATT_BY_RATE, TarBoIdList) ->
  % 目前断言: 此效果只针对行动者自己，以后此断言可能不一定成立！
  ?ASSERT(TarBoIdList =:= [_ActorId], {TarBoIdList, _ActorId, _SkillId, Eff}),

  % 判断概率是否成功？
  case lib_bt_util:test_proba(Eff#skl_eff.trigger_proba) of
    fail ->
      ?BT_LOG(io_lib:format("handle_one_skill_pre_eff__(), EN_TMP_MARK_DO_TWICE_PHY_ATT_BUT_REDUCE_PHY_ATT_BY_RATE failed for proba!! Proba=~p~n", [Eff#skl_eff.trigger_proba])),
      skip;
    success ->
      F = fun(TarBoId) ->
        ?ASSERT(get_bo_by_id(TarBoId) /= null, TarBoId),

        PhyAttReduceRate = Eff#skl_eff.para,
        ?ASSERT(PhyAttReduceRate >= 0 andalso PhyAttReduceRate =< 1, {PhyAttReduceRate, Eff}),
        PhyAttReduceRate2 = util:minmax(PhyAttReduceRate, 0, 1), % 容错，做矫正

        lib_bo:set_tmp_force_phy_combo_att_proba(TarBoId, ?PROBABILITY_BASE), % 设为必定触发
        lib_bo:set_tmp_force_max_phy_combo_att_times(TarBoId, 1),
        lib_bo:set_tmp_phy_att_reduce_rate(TarBoId, PhyAttReduceRate2)
          end,

      lists:foreach(F, TarBoIdList)
  end;


%%
handle_one_skill_pre_eff__(_ActorId, _SkillId, Eff, ?EN_TMP_MARK_DO_DAM_BY_DEFER_HP_RATE_WITH_LIMIT, TarBoIdList) ->
  % 目前断言: 此效果只针对行动者自己，以后此断言可能不一定成立！
  ?ASSERT(TarBoIdList =:= [_ActorId], {TarBoIdList, _ActorId, _SkillId, Eff}),

  % 判断概率是否成功？
  case lib_bt_util:test_proba(Eff#skl_eff.trigger_proba) of
    fail ->
      skip;
    success ->
      F = fun(TarBoId) ->
        ?ASSERT(get_bo_by_id(TarBoId) /= null, TarBoId),
        lib_bo:tmp_mark_do_dam_by_defer_hp_rate_with_limit(TarBoId, Eff#skl_eff.para)
          end,

      lists:foreach(F, TarBoIdList)
  end;


%废弃！

% %% 设置多目标物理攻击时的攻击目标数量上限，不需收集战报!
% handle_one_skill_pre_eff__(ActorId, _SkillId, Eff, ?EN_SET_MAX_HIT_OBJ_COUNT, TarBoIdList) ->
% 	% 判断概率是否成功？
% 	case util:decide_proba_once(Eff#eff.trigger_proba) of
%         fail ->
%             skip;
%         success ->
%         	F = fun(TarBoId) ->
%         			TarBo = get_bo_by_id(TarBoId),
%         			?ASSERT(TarBo /= null, TarBoId),
% 					MaxCount = Eff#eff.para,
% 					?ASSERT(is_integer(MaxCount), {MaxCount, Eff}),
% 					lib_bo:set_max_hit_obj_count(TarBoId, MaxCount)
%         		end,

%         	% 目前断言: 设置物理连击数只针对行动者自己，以后此断言可能不一定成立！
%         	?ASSERT(TarBoIdList =:= [ActorId], {TarBoIdList, ActorId}),

%         	lists:foreach(F, TarBoIdList)
%     end;

%% 添加指定编号的buff，需收集战报！
handle_one_skill_pre_eff__(ActorId, SkillId, Eff, ?EN_ADD_BUFF, TarBoIdList) ->
  ?TRACE("handle_one_skill_pre_eff__(), EN_ADD_BUFF, TarBoIdList=~p~n", [TarBoIdList]),
  handle_skill_add_buff_eff(ActorId, SkillId, Eff, TarBoIdList);

%% 添加多个指定编号的buff，需收集战报！
handle_one_skill_pre_eff__(ActorId, SkillId, Eff, ?EN_ADD_MULTI_BUFFS, TarBoIdList) ->
  ?TRACE("handle_one_skill_pre_eff__(), EN_ADD_MULTI_BUFFS, TarBoIdList=~p~n", [TarBoIdList]),
  handle_skill_add_multi_buffs_eff(ActorId, SkillId, Eff, TarBoIdList);

%% 驱散规定规则的buff，需收集战报！ {by_no, BuffNo, Num} or {by_category, BuffCategory, Num} or {by_eff_type, EffType, Num}
handle_one_skill_pre_eff__(ActorId, SkillId, Eff, ?EN_PURGE_BUFF, TarBoIdList) ->
  handle_skill_purge_buff_pre_eff(ActorId, SkillId, Eff, TarBoIdList);

%% 治疗----加血，需收集战报！
handle_one_skill_pre_eff__(ActorId, SkillId, Eff, ?EN_HEAL_HP, TarBoIdList) ->
  ?TRACE("handle_one_skill_pre_eff__(), EN_HEAL_HP, TarBoIdList=~p~n", [TarBoIdList]),
  handle_skill_heal_hp_eff(ActorId, SkillId, Eff, TarBoIdList);

%% 治疗----加血并添加buff（通常是hot类buff），需收集战报！
handle_one_skill_pre_eff__(ActorId, SkillId, Eff, ?EN_HEAL_HP_AND_ADD_BUFF, TarBoIdList) ->
  ?TRACE("handle_one_skill_pre_eff__(), EN_HEAL_HP_AND_ADD_BUFF, TarBoIdList=~p~n", [TarBoIdList]),
  handle_skill_heal_HP_and_add_buff_eff(ActorId, SkillId, Eff, TarBoIdList);

%% 治疗----加蓝并添加buff（通常是hot类buff），需收集战报！
handle_one_skill_pre_eff__(ActorId, SkillId, Eff, ?EN_HEAL_MP_AND_ADD_BUFF, TarBoIdList) ->
  ?TRACE("handle_one_skill_pre_eff__(), EN_HEAL_MP_AND_ADD_BUFF, TarBoIdList=~p~n", [TarBoIdList]),
  handle_skill_heal_MP_and_add_buff_eff(ActorId, SkillId, Eff, TarBoIdList);

%% 治疗----复活，需收集战报！
handle_one_skill_pre_eff__(ActorId, SkillId, Eff, ?EN_REVIVE, TarBoIdList) ->
  ?BT_LOG(io_lib:format("handle_one_skill_pre_eff__(), EN_REVIVE, SkillId=~p,TarBoIdList=~p~n", [SkillId, TarBoIdList])),
  handle_skill_revive_eff(ActorId, SkillId, Eff, TarBoIdList);

handle_one_skill_pre_eff__(ActorId, SkillId, Eff, ?EN_REDUCE_TARGET_ANGER_BY_DO_SKILL_ATT, TarBoIdList) ->
  ?BT_LOG(io_lib:format("handle_one_skill_pre_eff__, EN_REDUCE_TARGET_ANGER_BY_DO_SKILL_ATT:~w~n", [TarBoIdList])),
  handle_skill_heal_anger_eff(ActorId, SkillId, Eff, TarBoIdList);

handle_one_skill_pre_eff__(_ActorId, _SkillId, _Eff, _EffName, _TarBoIdList) ->
  ?ERROR_MSG("[mod_battle] handle_one_skill_pre_eff__() error!!! SkillId:~p~nActor: ~w~nEff: ~w", [_SkillId, get_bo_by_id(_ActorId), _Eff]),
  ?ASSERT(false, {_SkillId, _Eff}),
  error.





%% 构建action：施法失败
build_action_cast_buffs_failed(CasterId, SklEff) ->
  #boa_cast_buffs{
    caster_id = CasterId,
    cast_result = ?RES_FAIL,
    need_perf_casting = SklEff#skl_eff.need_perf_casting,
    caster_hp_left = lib_bo:get_hp_by_id(CasterId),
    caster_mp_left = lib_bo:get_mp_by_id(CasterId),
    caster_anger_left = lib_bo:get_anger_by_id(CasterId),
    details_list = []  % 固定为空列表
  }.



%% 尝试给目标添加一个buff
%% @return: invalid | cast_buffs_dtl结构体
try_add_buff__(ActorId, TarBoId, BuffNo, SkillId, TargetCount) ->
  % ?ASSERT(get_bo_by_id(TarBoId) /= null, TarBoId),


  ?ASSERT(is_integer(BuffNo), {BuffNo, SkillId}),
  ?ASSERT(lib_buff_tpl:get_tpl_data(BuffNo) /= null, {BuffNo, SkillId}),

  CastBuffsDtl = #cast_buffs_dtl{caster_id = ActorId, target_bo_id = TarBoId},
  case lib_bo:add_buff(ActorId, TarBoId, BuffNo, SkillId, TargetCount) of
    fail ->
      CastBuffsDtl#cast_buffs_dtl{buffs_added = []};  % 这里故意赋为空列表，让客户端对应的处理是目标bo有受施法的特效表现， 但没有实际添加buff的效果。
    {ok, nothing_to_do} ->
      CastBuffsDtl#cast_buffs_dtl{buffs_added = []};  % 这里故意赋为空列表，让客户端对应的处理是目标bo有受施法的特效表现， 但没有实际添加buff的效果。
    {ok, new_buff_added} ->
      CastBuffsDtl#cast_buffs_dtl{buffs_added = [BuffNo]};
    {ok, old_buff_replaced, OldBuffNo} ->
      CastBuffsDtl#cast_buffs_dtl{buffs_added = [BuffNo], buffs_removed = [OldBuffNo]};
    {passi, RemovedBuffNo} ->
      CastBuffsDtl#cast_buffs_dtl{buffs_removed = RemovedBuffNo}
    % {ok, old_buff_overlapped, OldBuffNo} ->
    % 	CastBuffsDtl#cast_buffs_dtl{buffs_added = [BuffNo], buffs_removed = [OldBuffNo]} %%buffs_updated = [BuffNo]}
  end.



%% 尝试给目标添加多个buff
%% @return: invalid | cast_buffs_dtl结构体
try_add_multi_buffs__(ActorId, TarBoId, BuffNoList, SkillId, TargetCount) ->
  L = [try_add_buff__(ActorId, TarBoId, BuffNo, SkillId, TargetCount) || BuffNo <- BuffNoList],
  L2 = [X || X <- L, X /= invalid],
  case L2 == [] of
    true ->
      invalid;
    false ->
      Dtl = combine_cast_buff_details_list(L2),
      Dtl#cast_buffs_dtl{
        caster_id = ActorId,
        target_bo_id = TarBoId
      }
  end.

%% 尝试给目标驱散buff, 按配置规则驱散
%% @return: invalid | cast_buffs_dtl结构体
try_purge_buff__(ActorId, TarBoId, PurgeBuffRule) ->
  {ok, PurgeBuffsDtl} = lib_bo:purge_buff(TarBoId, PurgeBuffRule),
  #cast_buffs_dtl{
    caster_id = ActorId
    ,target_bo_id = TarBoId
    ,buffs_removed = PurgeBuffsDtl#purge_buffs_dtl.defer_buffs_removed
  }.



%% 多个cast_buffs_dtl结构体的buff相关的字段相加，返回结果
%% @return: cast_buffs_dtl结构体
combine_cast_buff_details_list([CastBuffDtl]) ->
  ?ASSERT(is_record(CastBuffDtl, cast_buffs_dtl)),
  CastBuffDtl;
combine_cast_buff_details_list([Dtl1, Dtl2 | T]) ->
  TmpDtl = combine_two_cast_buff_details(Dtl1, Dtl2),
  combine_cast_buff_details_list([TmpDtl | T]).


combine_two_cast_buff_details(Dtl1, Dtl2) ->
  #cast_buffs_dtl{
    buffs_added = Dtl1#cast_buffs_dtl.buffs_added ++ Dtl2#cast_buffs_dtl.buffs_added,
    buffs_removed = Dtl1#cast_buffs_dtl.buffs_removed ++ Dtl2#cast_buffs_dtl.buffs_removed,
    buffs_updated = Dtl1#cast_buffs_dtl.buffs_updated ++ Dtl2#cast_buffs_dtl.buffs_updated
  }.


handle_skill_add_buff_eff(ActorId, SkillId, Eff, TarBoIdList) ->
  ?ASSERT(is_record(Eff, skl_eff), Eff),
  ?ASSERT(Eff#skl_eff.name == ?EN_ADD_BUFF),
  % 判断概率是否成功？
  Bo = get_bo_by_id(ActorId),
  SkillCfg= mod_skill:get_cfg_data(SkillId),
  {FiveElement, FiveElementLv} =Bo#battle_obj.five_elements,
  SkillFiveElement = SkillCfg#skl_cfg.five_elements,
  FiveElementCoef =
    case FiveElement == SkillFiveElement of
      true ->
        case FiveElementLv of
          0 ->
            0;
          1 ->
            FiveElementData = data_five_elements_level:get(FiveElement,1),
            FiveElementData#five_elements_level.effect_num;
          _ ->
            FiveElementData = data_five_elements_level:get(FiveElement,1),
            FiveElementData2 = data_five_elements_level:get(FiveElement,2),
            FiveElementData#five_elements_level.effect_num + FiveElementData2#five_elements_level.effect_num
        end;
      false ->
        0
    end,

  AddBuffFun =
    fun(FunBoId,Acc) ->
      {_, SuccessBoIdList} = Acc,
      case lib_bt_util:test_proba(Eff#skl_eff.trigger_proba *(1 +FiveElementCoef) ) of
        fail ->
          Acc;
        _ ->
          {true,[FunBoId|SuccessBoIdList]}
      end
    end,

    {BuffState, BuffBoIdList} = lists:foldl(AddBuffFun,{false,[]},TarBoIdList),

  case BuffState of
    false ->
      % 收集施法失败的战报
      Action = build_action_cast_buffs_failed(ActorId, Eff),
      collect_battle_report(boa_cast_buffs, Action);
    _ ->
      % ?DEBUG_MSG("handle_skill_add_buff_eff(), Eff=~w", [Eff]),

      TargetCount = length(BuffBoIdList),

      BuffNo = Eff#skl_eff.para,
      ?ASSERT(is_integer(BuffNo), {BuffNo, Eff}),

      DetailsList  = [try_add_buff__(ActorId, X, BuffNo, SkillId, TargetCount) || X <- BuffBoIdList],
      DetailsList2 = [X || X <- DetailsList, X /= invalid],

      Action = case DetailsList2 of
                 [] ->
                   #boa_cast_buffs{
                     caster_id = ActorId,
                     cast_result = ?RES_FAIL,
                     need_perf_casting = Eff#skl_eff.need_perf_casting,
                     caster_hp_left = lib_bo:get_hp_by_id(ActorId),
                     caster_mp_left = lib_bo:get_mp_by_id(ActorId),
                     caster_anger_left = lib_bo:get_anger_by_id(ActorId),
                     details_list = []
                   };
                 _ ->
                   #boa_cast_buffs{
                     caster_id = ActorId,
                     cast_result = ?RES_OK,
                     need_perf_casting = Eff#skl_eff.need_perf_casting,
                     caster_hp_left = lib_bo:get_hp_by_id(ActorId),
                     caster_mp_left = lib_bo:get_mp_by_id(ActorId),
                     caster_anger_left = lib_bo:get_anger_by_id(ActorId),
                     details_list = DetailsList2
                   }
               end,

      % 收集施法成功的战报
      collect_battle_report(boa_cast_buffs, Action)
  end.

% 大秘境添加buff
handle_skill_add_buff(ActorId, SkillId, BuffNo, TarBoIdList) ->
  % ?DEBUG_MSG("handle_skill_add_buff(), Eff=~w", [Eff]),

  TargetCount = length(TarBoIdList),

  ?ASSERT(is_integer(BuffNo), BuffNo),

  DetailsList  = [try_add_buff__(ActorId, X, BuffNo, SkillId, TargetCount) || X <- TarBoIdList],
  DetailsList2 = [X || X <- DetailsList, X /= invalid],

  Action = case DetailsList2 of
             [] ->
               #boa_cast_buffs{
                 caster_id = ActorId,
                 cast_result = ?RES_FAIL,
                 need_perf_casting = 0,
                 caster_hp_left = lib_bo:get_hp_by_id(ActorId),
                 caster_mp_left = lib_bo:get_mp_by_id(ActorId),
                 caster_anger_left = lib_bo:get_anger_by_id(ActorId),
                 details_list = []
               };
             _ ->
               #boa_cast_buffs{
                 caster_id = ActorId,
                 cast_result = ?RES_OK,
                 need_perf_casting = 0,
                 caster_hp_left = lib_bo:get_hp_by_id(ActorId),
                 caster_mp_left = lib_bo:get_mp_by_id(ActorId),
                 caster_anger_left = lib_bo:get_anger_by_id(ActorId),
                 details_list = DetailsList2
               }
           end,

  % 收集施法成功的战报
  collect_battle_report(boa_cast_buffs, Action).



handle_skill_add_multi_buffs_eff(ActorId, SkillId, Eff, TarBoIdList) ->
  ?ASSERT(is_record(Eff, skl_eff), Eff),
  ?ASSERT(Eff#skl_eff.name == ?EN_ADD_MULTI_BUFFS),
  % 判断概率是否成功？
  AddBuffFun =
    fun(FunBoId,Acc) ->
      {_, SuccessBoIdList} = Acc,
      case lib_bt_util:test_proba(Eff#skl_eff.trigger_proba) of
        fail ->
          Acc;
        _ ->
          {true,[FunBoId|SuccessBoIdList]}
      end
    end,

  {BuffState, BuffBoIdList} = lists:foldl(AddBuffFun,{false,[]},TarBoIdList),

  case BuffState of
    false ->
      % 收集施法失败的战报
      Action = build_action_cast_buffs_failed(ActorId, Eff),
      collect_battle_report(boa_cast_buffs, Action);
    _ ->
      % ?DEBUG_MSG("handle_skill_add_multi_buffs_eff(), Eff=~w", [Eff]),

      TargetCount = length(BuffBoIdList),

      BuffNoList = Eff#skl_eff.para,
      ?ASSERT(util:is_integer_list(BuffNoList), {BuffNoList, Eff}),

      DetailsList  = [try_add_multi_buffs__(ActorId, X, BuffNoList, SkillId, TargetCount) || X <- BuffBoIdList],
      DetailsList2 = [X || X <- DetailsList, X /= invalid],


      Action = #boa_cast_buffs{
        caster_id = ActorId,
        cast_result = ?RES_OK,
        need_perf_casting = Eff#skl_eff.need_perf_casting,
        caster_hp_left = lib_bo:get_hp_by_id(ActorId),
        caster_mp_left = lib_bo:get_mp_by_id(ActorId),
        caster_anger_left = lib_bo:get_anger_by_id(ActorId),
        details_list = DetailsList2
      },


      ?BT_LOG(io_lib:format("handle_skill_add_multi_buffs_eff(), DetailsList2:~p~n", [DetailsList2])),

      % 收集施法成功的战报
      collect_battle_report(boa_cast_buffs, Action)
  end.

handle_skill_purge_buff_pre_eff(ActorId, _SkillId, Eff, TarBoIdList) ->
  ?ASSERT(is_record(Eff, skl_eff), Eff),
  ?ASSERT(Eff#skl_eff.name == ?EN_PURGE_BUFF),

  AddBuffFun =
    fun(FunBoId,Acc) ->
      {_, SuccessBoIdList} = Acc,
      case lib_bt_util:test_proba(Eff#skl_eff.trigger_proba) of
        fail ->
          Acc;
        _ ->
          {true,[FunBoId|SuccessBoIdList]}
      end
    end,

  {BuffState, BuffBoIdList} = lists:foldl(AddBuffFun,{false,[]},TarBoIdList),

  % 判断概率是否成功？
  case BuffState of
    false ->
      % 收集施法失败的战报
      Action = build_action_cast_buffs_failed(ActorId, Eff),
      collect_battle_report(boa_cast_buffs, Action);
    _ ->
      % ?DEBUG_MSG("handle_skill_purge_buff_pre_eff(), Eff=~w", [Eff]),

      % 配置参数是驱散buff的规则
      % {by_no, BuffNo, Num}          : 按指定编号驱散buff，随机数量Num
      % {by_category, Category, Num}  : 按类别驱散buff，随机数量Num
      % {by_eff_type, EffType, Num}   : 按效果类型驱散buff，随机数量Num
      % {by_no_list, [BuffNo, ...]}   : 驱散列表中的所有buff（如果有的话），随机数量固定为1
      PurgeBuffRule = Eff#skl_eff.para,

      DetailsList  = [try_purge_buff__(ActorId, X, PurgeBuffRule) || X <- BuffBoIdList],
      DetailsList2 = [X || X <- DetailsList, X /= invalid],

      Action = case DetailsList2 of
                 [] ->
                   #boa_cast_buffs{
                     caster_id = ActorId,
                     cast_result = ?RES_FAIL,
                     need_perf_casting = Eff#skl_eff.need_perf_casting,
                     caster_hp_left = lib_bo:get_hp_by_id(ActorId),
                     caster_mp_left = lib_bo:get_mp_by_id(ActorId),
                     caster_anger_left = lib_bo:get_anger_by_id(ActorId),
                     details_list = []
                   };
                 _ ->
                   #boa_cast_buffs{
                     caster_id = ActorId,
                     cast_result = ?RES_OK,
                     need_perf_casting = Eff#skl_eff.need_perf_casting,
                     caster_hp_left = lib_bo:get_hp_by_id(ActorId),
                     caster_mp_left = lib_bo:get_mp_by_id(ActorId),
                     caster_anger_left = lib_bo:get_anger_by_id(ActorId),
                     details_list = DetailsList2
                   }
               end,

      % 收集施法成功的战报
      collect_battle_report(boa_cast_buffs, Action)
  end.




%% 构建action：治疗失败
build_action_heal_failed(HealType, ActorId, _SklEff) ->
  % ?ASSERT(SklEff#skl_eff.name == ?EN_, SklEff),
  #boa_heal{
    has_revive_eff = false,
    heal_type = HealType,
    cast_result = ?RES_FAIL,
    healer_hp_left = lib_bo:get_hp_by_id(ActorId),
    healer_mp_left = lib_bo:get_mp_by_id(ActorId),
    healer_anger_left = lib_bo:get_anger_by_id(ActorId),
    details_list = []  % 固定为空列表
  }.


%% 构建action：复活失败
build_action_revive_failed(HealType, ActorId, _SklEff) ->
  % ?ASSERT(SklEff#skl_eff.name == ?EN_, SklEff),
  #boa_heal{
    has_revive_eff = true,
    heal_type = HealType,
    cast_result = ?RES_FAIL,
    healer_hp_left = lib_bo:get_hp_by_id(ActorId),
    healer_mp_left = lib_bo:get_mp_by_id(ActorId),
    healer_anger_left = lib_bo:get_anger_by_id(ActorId),
    details_list = []  % 固定为空列表
  }.




%% 判断是否可以对目标执行治疗
%% @return: true  | {false, Reason}
can_do_heal_to(TargetBo, SkillEff) ->
  case lib_bo:cannot_be_heal(TargetBo) of
    true ->
      {false, target_cannot_be_heal};
    false ->
      case is_living(TargetBo) of
        true ->
          true;
        false ->
          case lib_bo:in_ghost_status(TargetBo) of
            true ->
              {false, target_cannot_be_heal};  %%lib_bt_skill:has_revive_eff(SkillEff) andalso (not lib_bo:is_soul_shackled(TargetBo));
            false ->
              case lib_bo:in_fallen_status(TargetBo) of
                true ->
                  case lib_bt_skill:has_revive_eff(SkillEff) andalso (not lib_bo:is_soul_shackled(TargetBo)) of
                    true ->
                      true;
                    false ->
                      {false, target_cannot_be_heal}
                  end;
                false ->
                  ?ASSERT(false, TargetBo),
                  true
              end
          end
      end
  end.



%% TODO: 统计治疗量，以辅助实现副本通关评价的功能
do_heal_to_one_bo(HealType, ActorId, TarBoId, SkillId, TotalTargetCount) ->
  TarBo = get_bo_by_id(TarBoId),
  ActorBo = get_bo_by_id(ActorId),
  SkillCfg = mod_skill:get_cfg_data(SkillId),
  HealVal1 = lib_bt_calc:calc_heal_value_duan(ActorId, TarBo, SkillId, TotalTargetCount), %% Eff#skl_eff.para,
  ActorFiveElement = SkillCfg#skl_cfg.five_elements,
  {_, ActorFiveElementLv}  = ActorBo#battle_obj.five_elements ,
  {TarFiveElement, _TarFiveElementLv}  = TarBo#battle_obj.five_elements ,
  ActorFiveElementData = data_five_elements:get(ActorFiveElement),

  Coef =
    case is_dead(TarBo) of
      true ->
        case lists:member(TarFiveElement,ActorFiveElementData#five_elements.restraint) of
          true ->
            ActorFiveElementData#five_elements.be_num  * (0.08 + (lib_bo:get_revive_heal_coef(ActorBo)));
          false ->
            case lists:member(TarFiveElement,ActorFiveElementData#five_elements.berestraint) of
              true ->
                ActorFiveElementData#five_elements.re_num * (0.08 + (lib_bo:get_revive_heal_coef(ActorBo)));
              false ->
                0.08 + (lib_bo:get_revive_heal_coef(ActorBo))
            end
        end;
      false ->
        case lists:member(TarFiveElement,ActorFiveElementData#five_elements.restraint) of
          true ->
            ActorFiveElementData#five_elements.be_num;
          false ->
            case lists:member(TarFiveElement,ActorFiveElementData#five_elements.berestraint) of
              true ->
                ActorFiveElementData#five_elements.re_num;
              false ->
                1
            end
        end
    end,

  %判断技能和五行

  Coef2 = case SkillCfg#skl_cfg.five_elements == ActorFiveElement of
            true ->
              case ActorFiveElementLv of
                0 ->
                  Coef;
                1 ->
                  ElementData = data_five_elements_level:get(ActorFiveElement,ActorFiveElementLv),
                  (1 + ElementData#five_elements_level.effect_num) * Coef;
                _ ->
                  ElementData = data_five_elements_level:get(ActorFiveElement,1),
                  ElementData2 = data_five_elements_level:get(ActorFiveElement,2),
                  (1 +ElementData#five_elements_level.effect_num + ElementData2#five_elements_level.effect_num) * Coef
              end;
            false ->
              Coef
          end,

  % 如果是用于复活的治疗量将降低至8%
  HealVal = util:ceil(HealVal1 * Coef2),

  ?ASSERT(is_integer(HealVal), {HealVal, SkillId}),
  ?BT_LOG(io_lib:format("do_heal_to_one_bo(), ActorId=~p, TarBoId=~p, HealVal=~p~n", [ActorId, TarBoId, HealVal])),
  TarBo_New = case HealType of
                ?HEAL_T_HP ->
                  lib_bo:add_hp(TarBoId, HealVal);
                ?HEAL_T_MP ->
                  lib_bo:add_mp(TarBoId, HealVal);
                ?HEAL_T_HP_MP ->
                  lib_bo:add_hp(TarBoId, HealVal),
                  lib_bo:add_mp(TarBoId, HealVal)
              end,
  ?ASSERT(is_record(TarBo_New, battle_obj)),

  case is_dead(TarBo) andalso is_living(TarBo_New) of
    true -> % 复活后重置死亡状态为未死亡
      lib_bo:reset_die_status(TarBoId);
    false ->
      skip
  end,

  {TarBo_New, HealVal}.

do_heal_to_one_bo(HealType, ActorId, TarBoId, SkillId, TotalTargetCount, SkillEff) ->
  TarBo = get_bo_by_id(TarBoId),
  ActorBo = get_bo_by_id(ActorId),
  SkillCfg = mod_skill:get_cfg_data(SkillId),
  HealVal1 =
    case SkillEff#skl_eff.para of
      {hp_lim, Rate} -> util:ceil(lib_bo:get_hp_lim(TarBo) * Rate);
      _ ->
        case HealType =:= ?HEAL_T_ANGER of
          true ->
            if
              SkillEff#skl_eff.name =:= ?EN_REDUCE_TARGET_ANGER_BY_DO_SKILL_ATT -> -SkillEff#skl_eff.para;
              true -> SkillEff#skl_eff.para
            end;
          false -> lib_bt_calc:calc_heal_value_duan(ActorId, TarBo, SkillId, TotalTargetCount) %% Eff#skl_eff.para,
        end
    end,
  ActorFiveElement= 	SkillCfg#skl_cfg.five_elements,
  {ActorFiveElement2 , ActorFiveElementLv}  = ActorBo#battle_obj.five_elements ,
  {TarFiveElement, _TarFiveElementLv}  = TarBo#battle_obj.five_elements ,
  ActorFiveElementData = data_five_elements:get(ActorFiveElement),

  Coef =
    case is_dead(TarBo) of
      true ->
        case lists:member(TarFiveElement,ActorFiveElementData#five_elements.restraint) of
          true ->
            ActorFiveElementData#five_elements.be_num  * (0.08 + (lib_bo:get_revive_heal_coef(ActorBo)));
          false ->
            case lists:member(TarFiveElement,ActorFiveElementData#five_elements.berestraint) of
              true ->
                ActorFiveElementData#five_elements.re_num * (0.08 + (lib_bo:get_revive_heal_coef(ActorBo)));
              false ->
                0.08 + (lib_bo:get_revive_heal_coef(ActorBo))
            end
        end;
      false ->
        case lists:member(TarFiveElement,ActorFiveElementData#five_elements.restraint) of
          true ->
            ActorFiveElementData#five_elements.be_num;
          false ->
            case lists:member(TarFiveElement,ActorFiveElementData#five_elements.berestraint) of
              true ->
                ActorFiveElementData#five_elements.re_num;
              false ->
                1
            end
        end
    end,

  %判断技能和五行

  Coef2 =
    case SkillCfg#skl_cfg.five_elements == ActorFiveElement2 of
      true ->
        case ActorFiveElementLv of
          0 ->
            Coef;
          1 ->
            ElementData = data_five_elements_level:get(ActorFiveElement,ActorFiveElementLv),
            (1 + ElementData#five_elements_level.effect_num) * Coef;
          _ ->
            ElementData = data_five_elements_level:get(ActorFiveElement,1),
            ElementData2 = data_five_elements_level:get(ActorFiveElement,2),
            (1 +ElementData#five_elements_level.effect_num + ElementData2#five_elements_level.effect_num) * Coef
        end;
      false ->
        Coef
    end,

  % 如果是用于复活的治疗量将降低至8%
  HealVal = util:ceil(HealVal1 * Coef2),
  ?DEBUG_MSG("kezhicoef: ~p,  jinengcoef2:~p,  before~p,  after~p  ~n ",[Coef,Coef2,HealVal1,HealVal]),
  ?ASSERT(is_integer(HealVal), {HealVal, SkillId}),
  ?BT_LOG(io_lib:format("do_heal_to_one_bo(), ActorId=~p, TarBoId=~p, HealVal=~p~n", [ActorId, TarBoId, HealVal])),
  TarBo_New = case HealType of
                ?HEAL_T_HP ->
                  lib_bo:add_hp(TarBoId, HealVal);
                ?HEAL_T_MP ->
                  lib_bo:add_mp(TarBoId, HealVal);
                ?HEAL_T_HP_MP ->
                  lib_bo:add_hp(TarBoId, HealVal),
                  lib_bo:add_mp(TarBoId, HealVal);
                ?HEAL_T_ANGER ->
                  lib_bo:add_anger(TarBoId, HealVal)
              end,
  ?ASSERT(is_record(TarBo_New, battle_obj)),

  case is_dead(TarBo) andalso is_living(TarBo_New) of
    true -> % 复活后重置死亡状态为未死亡
      lib_bo:reset_die_status(TarBoId);
    false ->
      skip
  end,

  {TarBo_New, HealVal}.


%% 尝试治疗
%% @return: heal_dtl结构体列表
try_heal(HealType, ActorId, TarBoIdList, SkillId, SkillEff) ->
  TargetCount = length(TarBoIdList),
  F = fun(TarBoId) ->
    TarBo = get_bo_by_id(TarBoId),
    ?ASSERT(TarBo /= null, TarBoId),

    case can_do_heal_to(TarBo, SkillEff) of
      {false, target_cannot_be_heal} ->
        #heal_dtl{
          target_bo_id = TarBoId,
          is_cannot_be_heal = true
        };
      {false, _OtherReason} ->
        invalid;
      true ->
        {TarBo2, HealVal} = do_heal_to_one_bo(HealType, ActorId, TarBoId, SkillId, TargetCount, SkillEff),
        #heal_dtl{
          target_bo_id = TarBoId,
          heal_value = HealVal,
          new_hp = lib_bo:get_hp(TarBo2),
          new_mp = lib_bo:get_mp(TarBo2),
          new_anger = lib_bo:get_anger(TarBo2)
        }
    end
      end,

  HealDtlList = [F(X) || X <- TarBoIdList],
  [X || X <- HealDtlList, X /= invalid].


%% 尝试治疗并添加buff
try_heal_and_add_buff(HealType, ActorId, TarBoIdList, SkillId, SkillEff) ->
  TargetCount = length(TarBoIdList),

  F = fun(TarBoId) ->
    TarBo = get_bo_by_id(TarBoId),
    ?ASSERT(TarBo /= null, TarBoId),

    case can_do_heal_to(TarBo, SkillEff) of
      {false, target_cannot_be_heal} ->
        #heal_dtl{
          target_bo_id = TarBoId,
          is_cannot_be_heal = true
        };
      {false, _OtherReason} ->
        invalid;
      true ->
        {TarBo2, HealVal} = do_heal_to_one_bo(HealType, ActorId, TarBoId, SkillId, TargetCount),

        % 加buff
        BuffNo = SkillEff#skl_eff.para,
        ?ASSERT(lib_buff_tpl:is_exists(BuffNo), SkillEff),

        case lib_bo:add_buff(ActorId, TarBoId, BuffNo, SkillId, TargetCount) of
          fail ->
            BuffsAdded = [],
            BuffsRemoved = [];
          {ok, nothing_to_do} ->
            BuffsAdded = [],
            BuffsRemoved = [];
          {ok, new_buff_added} ->
            BuffsAdded = [BuffNo],
            BuffsRemoved = [];
          {ok, old_buff_replaced, OldBuffNo} ->
            BuffsAdded = [BuffNo],
            BuffsRemoved = [OldBuffNo];
          {passi, RemovedBuffNo} ->
            BuffsAdded = [],
            BuffsRemoved = RemovedBuffNo
        end,

        #heal_dtl{
          target_bo_id = TarBoId,
          heal_value = HealVal,
          new_hp = lib_bo:get_hp(TarBo2),
          new_mp = lib_bo:get_mp(TarBo2),
          new_anger = lib_bo:get_anger(TarBo2),
          buffs_added = BuffsAdded,
          buffs_removed = BuffsRemoved
        }
    end
      end,

  HealDtlList = [F(X) || X <- TarBoIdList],
  [X || X <- HealDtlList, X /= invalid].





%% 治疗：加血
handle_skill_heal_hp_eff(ActorId, SkillId, Eff, TarBoIdList) ->
  ?ASSERT(is_record(Eff, skl_eff), Eff),
  ?ASSERT(Eff#skl_eff.name == ?EN_HEAL_HP),
  % 判断概率是否成功？
  case lib_bt_util:test_proba(Eff#skl_eff.trigger_proba) of
    fail ->
      % 收集治疗失败的战报
      Action = build_action_heal_failed(?HEAL_T_HP, ActorId, Eff),
      collect_battle_report(boa_heal, Action);
    success ->
      % ?DEBUG_MSG("handle_skill_heal_hp_eff(), Eff=~w", [Eff]),

      DetailsList  = try_heal(?HEAL_T_HP, ActorId, TarBoIdList, SkillId, Eff),
      ?ASSERT(is_list(DetailsList)),
      % DetailsList2 = [X || X <- DetailsList, X /= invalid],

      CastResult = case DetailsList of
                     [] -> ?RES_FAIL;
                     _ -> ?RES_OK
                   end,

      Action = #boa_heal{
        has_revive_eff = false,
        heal_type = ?HEAL_T_HP,
        cast_result = CastResult,
        healer_hp_left = lib_bo:get_hp_by_id(ActorId),
        healer_mp_left = lib_bo:get_mp_by_id(ActorId),
        healer_anger_left = lib_bo:get_anger_by_id(ActorId),
        % need_perf_casting = Eff#skl_eff.need_perf_casting,
        details_list = DetailsList
      },

      % 收集施法成功的战报
      collect_battle_report(boa_heal, Action)
  end.

%% 治疗：加怒气
handle_skill_heal_anger_eff(ActorId, SkillId, Eff, TarBoIdList) ->
  ?ASSERT(is_record(Eff, skl_eff), Eff),
  ?ASSERT(Eff#skl_eff.name == ?EN_REDUCE_TARGET_ANGER_BY_DO_SKILL_ATT),
  % 判断概率是否成功？
  case lib_bt_util:test_proba(Eff#skl_eff.trigger_proba) of
    fail ->
      % 收集治疗失败的战报
      Action = build_action_heal_failed(?HEAL_T_ANGER, ActorId, Eff),
      collect_battle_report(boa_heal, Action);
    success ->
      % ?DEBUG_MSG("handle_skill_heal_hp_eff(), Eff=~w", [Eff]),

      DetailsList  = try_heal(?HEAL_T_ANGER, ActorId, TarBoIdList, SkillId, Eff),
      ?ASSERT(is_list(DetailsList)),
      % DetailsList2 = [X || X <- DetailsList, X /= invalid],

      CastResult = case DetailsList of
                     [] -> ?RES_FAIL;
                     _ -> ?RES_OK
                   end,

      Action = #boa_heal{
        has_revive_eff = false,
        heal_type = ?HEAL_T_ANGER,
        cast_result = CastResult,
        healer_hp_left = lib_bo:get_hp_by_id(ActorId),
        healer_mp_left = lib_bo:get_mp_by_id(ActorId),
        healer_anger_left = lib_bo:get_anger_by_id(ActorId),
        % need_perf_casting = Eff#skl_eff.need_perf_casting,
        details_list = DetailsList
      },

      % 收集施法成功的战报
      collect_battle_report(boa_heal, Action)
  end.




%% 治疗（加血）并添加buff（通常是HOT类buff）
handle_skill_heal_HP_and_add_buff_eff(ActorId, SkillId, Eff, TarBoIdList) ->
  ?ASSERT(is_record(Eff, skl_eff), Eff),
  ?ASSERT(Eff#skl_eff.name == ?EN_HEAL_HP_AND_ADD_BUFF),
  handle_skill_heal_and_add_buff_eff(?HEAL_T_HP, ActorId, SkillId, Eff, TarBoIdList).


%% 治疗（加蓝）并添加buff（通常是HOT类buff）
handle_skill_heal_MP_and_add_buff_eff(ActorId, SkillId, Eff, TarBoIdList) ->
  ?ASSERT(is_record(Eff, skl_eff), Eff),
  ?ASSERT(Eff#skl_eff.name == ?EN_HEAL_MP_AND_ADD_BUFF),
  handle_skill_heal_and_add_buff_eff(?HEAL_T_MP, ActorId, SkillId, Eff, TarBoIdList).



%% 治疗并添加buff（通常是HOT类buff）
handle_skill_heal_and_add_buff_eff(HealType, ActorId, SkillId, Eff, TarBoIdList) ->
  ?ASSERT(is_record(Eff, skl_eff), Eff),

  % 判断概率是否成功？
  case lib_bt_util:test_proba(Eff#skl_eff.trigger_proba) of
    fail ->
      % 收集治疗失败的战报
      Action = build_action_heal_failed(HealType, ActorId, Eff),
      collect_battle_report(boa_heal, Action);
    success ->
      % ?DEBUG_MSG("handle_skill_heal_and_add_buff_eff(), Eff=~w", [Eff]),

      DetailsList  = try_heal_and_add_buff(HealType, ActorId, TarBoIdList, SkillId, Eff),
      ?ASSERT(is_list(DetailsList)),
      % DetailsList2 = [X || X <- DetailsList, X /= invalid],

      CastResult = case DetailsList of
                     [] -> ?RES_FAIL;
                     _ -> ?RES_OK
                   end,

      Action = #boa_heal{
        has_revive_eff = false,
        heal_type = HealType,
        cast_result = CastResult,
        healer_hp_left = lib_bo:get_hp_by_id(ActorId),
        healer_mp_left = lib_bo:get_mp_by_id(ActorId),
        healer_anger_left = lib_bo:get_anger_by_id(ActorId),
        % need_perf_casting = Eff#skl_eff.need_perf_casting,
        details_list = DetailsList
      },

      % 收集施法成功的战报
      collect_battle_report(boa_heal, Action)
  end.




%% 复活
handle_skill_revive_eff(ActorId, SkillId, Eff, TarBoIdList) ->
  ?ASSERT(is_record(Eff, skl_eff), Eff),
  ?ASSERT(Eff#skl_eff.name == ?EN_REVIVE),
  % 判断概率是否成功？
  case lib_bt_util:test_proba(Eff#skl_eff.trigger_proba) of
    fail ->
      % 收集复活失败的战报
      Action = build_action_revive_failed(?HEAL_T_HP, ActorId, Eff),
      collect_battle_report(boa_heal, Action);
    success ->
      % ?DEBUG_MSG("handle_skill_revive_eff(), Eff=~w", [Eff]),

      DetailsList  = try_heal(?HEAL_T_HP, ActorId, TarBoIdList, SkillId, Eff),
      ?ASSERT(is_list(DetailsList)),

      CastResult = case DetailsList of
                     [] -> ?RES_FAIL;
                     _ -> ?RES_OK
                   end,

      % DetailsList2 = [X || X <- DetailsList, X /= invalid],
      Action = #boa_heal{
        has_revive_eff = true,  % 带复活效果！
        heal_type = ?HEAL_T_HP,
        cast_result = CastResult,
        healer_hp_left = lib_bo:get_hp_by_id(ActorId),
        healer_mp_left = lib_bo:get_mp_by_id(ActorId),
        healer_anger_left = lib_bo:get_anger_by_id(ActorId),
        % need_perf_casting = Eff#skl_eff.need_perf_casting,
        details_list = DetailsList
      },

      % 收集施法成功的战报
      collect_battle_report(boa_heal, Action)
  end.





%% 处理技能的攻击效果（如果有的话）
handle_skill_att_eff(BoId) ->
  Bo = get_bo_by_id(BoId),
  % CurSkl = lib_bo:get_cur_skill_brief(Bo),

  % SkillId = CurSkl#skl_brief.id,
  % SkillLv = CurSkl#skl_brief.lv,

  % SklCfg = mod_skill:get_cfg_data(SkillId, SkillLv),




  SklCfg = lib_bo:get_cur_skill_cfg(Bo),
  % ?DEBUG_MSG("SklCfg=~p",[SklCfg,mod_skill:get_att_type(SklCfg)]),

  % TODO: 如有必要，判断一下攻击效果的触发概率
  % ...
  case mod_skill:get_att_type(SklCfg) of
    ?ATT_T_PHY ->  % 物理攻击
      case mod_skill:get_target_count_type(SklCfg) of
        ?TARGET_COUNT_SINGLE ->
          try_single_target_phy_attack(Bo);
        _ ->
          try_multi_target_phy_attack(Bo)
      end;
    ?ATT_T_MAG ->  % 法术攻击
      try_magic_attack(Bo);
    ?ATT_T_PHY_2 ->  % 物理攻击同时群攻 wjc
      try_phy_2_attack(Bo);
    ?ATT_T_POISON ->  % 毒攻击
      try_poison_attack(Bo);
    %?ATT_T_NONE -> % 无攻击
    _ ->
      throw(handle_attack_eff_done) %%skip
  end.


%% 获取当前使用技能的目标类型是否是单体群体
get_cur_skill_count_type(BoId) ->
  Bo = get_bo_by_id(BoId),
  {SingleCoef, MultiCoef}  = data_special_config:get(total_target_count_absorb_hp),
  case lib_bo:get_cur_skill_cfg(Bo) of
    SklCfg when is_record(SklCfg,skl_cfg) ->
      case mod_skill:get_target_count_type(SklCfg) of
        ?TARGET_COUNT_SINGLE ->
          SingleCoef;
        _ ->
          MultiCoef
      end;
    _ ->	SingleCoef
  end.




% 处理暴击过程中的效果
%% 注意：须确保传入的参数Atter, Defer是当前最新的!!
%% 为了配合收集战报， 返回对应的details结构体！！

try_handle_crit_in_effs(Atter, Defer, CritInfo,RealDamToDefer) ->
  case Atter of
    null -> #dam_sub_dtl{};
    Atter_ when is_record(Atter_,battle_obj) ->
      case lib_bo:is_using_normal_att(Atter) of
        true ->
          #dam_sub_dtl{};
        false ->
          case CritInfo of
            crit ->
              CurSklCfg = lib_bo:get_cur_skill_cfg(Atter),
              % ?ASSERT(CurSklCfg /= null, {lib_bo:get_cur_skill_brief(Atter), Atter}),
              case lib_bo:get_cur_skill_cfg(Atter) of
                CurSklCfg when is_record(CurSklCfg,skl_cfg) ->
                  BuffCritEff =
                    case lib_bo:find_buff_by_name(Atter, ?BFN_ADD_SKILL_EFF) of
                      null ->
                        [];
                      AddEffBuff ->
                        AllEffList = lib_bo_buff:get_buff_tpl_para(AddEffBuff),
                        CritList = case lists:keyfind(crit_effs, 1,AllEffList) of
                                     false ->
                                       [];
                                     {crit_effs,PreList2} ->
                                       PreList2
                                   end
                    end,
                  CurSklId = mod_skill:get_id(CurSklCfg),
                  handle_skill_crit_effs(Atter, Defer, CurSklId, mod_skill:get_crit_effs(CurSklCfg) ++ BuffCritEff,RealDamToDefer);

                true ->
                  #dam_sub_dtl{}
              end;
            _ -> #dam_sub_dtl{}
          end
      end

  end.

%% 为了配合收集战报， 返回对应的details！！
handle_skill_crit_effs(Atter, Defer, SkillId, CritEffList,RealDamToDefer) ->
  handle_skill_crit_effs__(Atter, Defer, SkillId, CritEffList,RealDamToDefer, #dam_sub_dtl{}).


handle_skill_crit_effs__(Atter, Defer, SkillId, [EffNo | T], RealDamToDefer, Acc_DamSubDetails) ->
  Details = handle_one_skill_crit_eff(Atter, Defer, SkillId, EffNo, RealDamToDefer),
  ?ASSERT(is_record(Details, dam_sub_dtl), {Details, SkillId, EffNo}),
  Acc_DamSubDetails_2 = sum_two_dam_sub_details(Details, Acc_DamSubDetails),
  handle_skill_crit_effs__(Atter, Defer, SkillId, T, RealDamToDefer, Acc_DamSubDetails_2);

handle_skill_crit_effs__(_Atter, _Defer, _SkillId, [], RealDamToDefer,  Acc_DamSubDetails) ->
  Acc_DamSubDetails.



%% 处理技能的攻击过程中的效果
%% 注意：须确保传入的参数Atter, Defer是当前最新的!!
%% 为了配合收集战报， 返回对应的details结构体！！
try_handle_skill_in_effs(Atter, Defer, RealDamToDefer, IsStrikeback) ->
  % 应注意到： Atter，Defer都有可能已经死亡。 另外，因为此函数是在check_and_handle_bo_die()前被调用，故攻防双方的bo肯定还存在进程字典中
  case IsStrikeback orelse lib_bo:is_using_normal_att(Atter) of
    true ->
      #dam_sub_dtl{};
    false ->
      % CurSkl = lib_bo:get_cur_skill_brief(Atter),
      % case CurSkl#skl_brief.id of
      CurSklCfg = lib_bo:get_cur_skill_cfg(Atter),
      ?ASSERT(CurSklCfg /= null, {lib_bo:get_cur_skill_brief(Atter), Atter}),
      % SklCfg = get_skill_cfg_data(CurSkl),
      BuffInEff =
        case lib_bo:find_buff_by_name(Atter, ?BFN_ADD_SKILL_EFF) of
          null ->
            [];
          AddEffBuff ->
            AllEffList = lib_bo_buff:get_buff_tpl_para(AddEffBuff),
            InEffList = case lists:keyfind(in_effs, 1,AllEffList) of
                        false ->
                          [];
                        {in_effs,PreList2} ->
                          PreList2
                      end
        end,
      MergeEffList = mod_skill:get_in_effs(CurSklCfg) ++ BuffInEff,
      CurSklId = mod_skill:get_id(CurSklCfg),
      handle_skill_in_effs(Atter, Defer, CurSklId, MergeEffList, RealDamToDefer)

  end.





%% 为了配合收集战报， 返回对应的details！！
handle_skill_in_effs(Atter, Defer, SkillId, InEffList, RealDamToDefer) ->
  handle_skill_in_effs__(Atter, Defer, SkillId, InEffList, RealDamToDefer, #dam_sub_dtl{}).


handle_skill_in_effs__(Atter, Defer, SkillId, [EffNo | T], RealDamToDefer, Acc_DamSubDetails) ->
  Details = handle_one_skill_in_eff(Atter, Defer, SkillId, EffNo, RealDamToDefer),
  ?ASSERT(is_record(Details, dam_sub_dtl), {Details, SkillId, EffNo}),
  Acc_DamSubDetails_2 = sum_two_dam_sub_details(Details, Acc_DamSubDetails),
  handle_skill_in_effs__(Atter, Defer, SkillId, T, RealDamToDefer, Acc_DamSubDetails_2);

handle_skill_in_effs__(_Atter, _Defer, _SkillId, [], _RealDamToDefer, Acc_DamSubDetails) ->
  Acc_DamSubDetails.




%% 多个dam_sub_dtl结构体的对应字段相加，返回结果
%% @return: dam_sub_dtl结构体
sum_dam_sub_details_list([]) ->
  #dam_sub_dtl{};
sum_dam_sub_details_list([Dtl]) ->
  ?ASSERT(is_record(Dtl, dam_sub_dtl)),
  Dtl;
sum_dam_sub_details_list([Dtl1, Dtl2 | T]) ->
  ?ASSERT(is_record(Dtl1, dam_sub_dtl)),
  ?ASSERT(is_record(Dtl2, dam_sub_dtl)),
  TmpDtl = sum_two_dam_sub_details(Dtl1, Dtl2),
  sum_dam_sub_details_list([TmpDtl | T]).




%% 融合两个dam_sub_dtl结构体
sum_two_dam_sub_details(Details1, Details2) ->
  #dam_sub_dtl{
    atter_buffs_added = Details1#dam_sub_dtl.atter_buffs_added ++ Details2#dam_sub_dtl.atter_buffs_added,
    defer_buffs_added = Details1#dam_sub_dtl.defer_buffs_added ++ Details2#dam_sub_dtl.defer_buffs_added,
    defer_buffs_removed = Details1#dam_sub_dtl.defer_buffs_removed ++ Details2#dam_sub_dtl.defer_buffs_removed,
    dam_to_mp = Details1#dam_sub_dtl.dam_to_mp + Details2#dam_sub_dtl.dam_to_mp,
    splash_dtl_list = lib_bt_splash:sum_two_splash_dtl_list(Details1#dam_sub_dtl.splash_dtl_list, Details2#dam_sub_dtl.splash_dtl_list)
  }.



%% @return: dam_sub_dtl结构体 暴击时触发效果
handle_one_skill_crit_eff(Atter, Defer, SkillId, EffNo, RealDamToDefer) ->
  Eff = lib_skill_eff:get_cfg_data(EffNo),
  ?ASSERT(Eff /= null, EffNo),
  % 判断概率是否成功
  case lib_bt_util:test_proba(Eff#skl_eff.trigger_proba) of
    fail ->
      ?BT_LOG(io_lib:format("handle_one_skill_in_eff() failed for proba! TriggerProba=~p, AtterId=~p, EffNo=~p, SkillId=~p~n",
        [Eff#skl_eff.trigger_proba, lib_bo:id(Atter), EffNo, SkillId])),
      #dam_sub_dtl{};
    success ->
      AtterId = lib_bo:get_id(Atter),
      DeferId = lib_bo:get_id(Defer),

      ?DEBUG_MSG("Eff=~p",[Eff]),

      % 确定作用目标
      case lib_bt_skill:decide_skill_eff_targets(AtterId, Eff) of
        [] ->
          #dam_sub_dtl{};
        TarBoIdList ->
          % ?ASSERT(TarBoIdList =:= [AtterId] orelse TarBoIdList =:= [DeferId], {TarBoIdList, Eff}), % 注：目前暂时固定认为攻击过程中的效果的作用目标个数最多为1个（要么为攻击者自己，要么为当前的防守者）!!
          TotalTargetCount = length(TarBoIdList),
          F = fun(TarBoId) ->
            % 写代码时应注意到：目标有可能已死亡
            % 调用技能添加BUFF效果
            apply_one_skill_in_eff_to(TarBoId, Eff, SkillId, {AtterId, DeferId}, TotalTargetCount, RealDamToDefer)
              end,

          DamSubDtlList = [F(X) || X <- TarBoIdList],
          sum_dam_sub_details_list(DamSubDtlList)
      end

    % case BuffEffRecord#data_buff_eff.eff_name == ?EN_EXTRA_DAM of
    %     true ->   handle_trigger_light_eff(AerId, SkillId);
    %     false ->  skip
    % end,
    % lib_battle_buff:apply_skill_buff_to_bo(AerId, BoId, SkillId, BuffEffRecord)
  end.


%% @return: dam_sub_dtl结构体
handle_one_skill_in_eff(Atter, Defer, SkillId, EffNo, RealDamToDefer) ->
  Eff = lib_skill_eff:get_cfg_data(EffNo),
  ?ASSERT(Eff /= null, EffNo),
  % 判断概率是否成功
  case lib_bt_util:test_proba(Eff#skl_eff.trigger_proba) of
    fail ->
      ?BT_LOG(io_lib:format("handle_one_skill_in_eff() failed for proba! TriggerProba=~p, AtterId=~p, EffNo=~p, SkillId=~p~n",
        [Eff#skl_eff.trigger_proba, lib_bo:id(Atter), EffNo, SkillId])),
      #dam_sub_dtl{};
    success ->
      AtterId = lib_bo:get_id(Atter),
      DeferId = lib_bo:get_id(Defer),
      % 确定作用目标
      case lib_bt_skill:decide_skill_eff_targets(AtterId, Eff) of
        [] ->
          #dam_sub_dtl{};
        TarBoIdList ->
          % ?ASSERT(TarBoIdList =:= [AtterId] orelse TarBoIdList =:= [DeferId], {TarBoIdList, Eff}), % 注：目前暂时固定认为攻击过程中的效果的作用目标个数最多为1个（要么为攻击者自己，要么为当前的防守者）!!
          TotalTargetCount = length(TarBoIdList),
          F = fun(TarBoId) ->
            % 写代码时应注意到：目标有可能已死亡
            apply_one_skill_in_eff_to(TarBoId, Eff, SkillId, {AtterId, DeferId}, TotalTargetCount, RealDamToDefer)
              end,

          DamSubDtlList = [F(X) || X <- TarBoIdList],
          sum_dam_sub_details_list(DamSubDtlList)
      end

    % case BuffEffRecord#data_buff_eff.eff_name == ?EN_EXTRA_DAM of
    %     true ->   handle_trigger_light_eff(AerId, SkillId);
    %     false ->  skip
    % end,
    % lib_battle_buff:apply_skill_buff_to_bo(AerId, BoId, SkillId, BuffEffRecord)
  end.

%% 当前行动单位本次攻击击杀目标后加BUFF
handle_one_skill_kill_eff(Atter, Defer, SkillId, EffNo) ->
  Eff = lib_skill_eff:get_cfg_data(EffNo),
  ?ASSERT(Eff /= null, EffNo),
  % 判断概率是否成功
  case lib_bt_util:test_proba(Eff#skl_eff.trigger_proba) of
    fail ->
      ?BT_LOG(io_lib:format("handle_one_skill_kill_eff() failed for proba! TriggerProba=~p, AtterId=~p, EffNo=~p, SkillId=~p~n",
        [Eff#skl_eff.trigger_proba, lib_bo:id(Atter), EffNo, SkillId])),
      #dam_sub_dtl{};
    success ->
      AtterId = lib_bo:get_id(Atter),
      DeferId = lib_bo:get_id(Defer),
      % 确定作用目标
      case lib_bt_skill:decide_skill_eff_targets(AtterId, Eff) of
        [] ->
          #dam_sub_dtl{};
        TarBoIdList ->
          % ?ASSERT(TarBoIdList =:= [AtterId] orelse TarBoIdList =:= [DeferId], {TarBoIdList, Eff}), % 注：目前暂时固定认为攻击过程中的效果的作用目标个数最多为1个（要么为攻击者自己，要么为当前的防守者）!!
          TotalTargetCount = length(TarBoIdList),
          F = fun(TarBoId) ->
            % 写代码时应注意到：目标有可能已死亡
            apply_one_skill_in_eff_to(TarBoId, Eff, SkillId, {AtterId, DeferId}, TotalTargetCount, 0)
              end,

          DamSubDtlList = [F(X) || X <- TarBoIdList],
          sum_dam_sub_details_list(DamSubDtlList)
      end

    % case BuffEffRecord#data_buff_eff.eff_name == ?EN_EXTRA_DAM of
    %     true ->   handle_trigger_light_eff(AerId, SkillId);
    %     false ->  skip
    % end,
    % lib_battle_buff:apply_skill_buff_to_bo(AerId, BoId, SkillId, BuffEffRecord)
  end.


%% @return: dam_sub_dtl结构体
apply_one_skill_in_eff_to(TarBoId, Eff, SkillId, {AtterId, DeferId}, TotalTargetCount, RealDamToDefer) ->
  apply_one_skill_in_eff_to__(TarBoId, Eff, Eff#skl_eff.name, SkillId, {AtterId, DeferId}, TotalTargetCount, RealDamToDefer).




apply_one_skill_in_eff_to__(TarBoId, Eff, ?EN_ADD_BUFF, SkillId, {AtterId, DeferId}, TotalTargetCount, _RealDamToDefer) -> % 添加指定编号的buff
  BuffNo = Eff#skl_eff.para,
  ?ASSERT(is_integer(BuffNo), {BuffNo, Eff}),

  % 目标有可能已死亡
  case is_dead(TarBoId) of
    true ->
      #dam_sub_dtl{};
    false ->
      case lib_bo:add_buff(AtterId, TarBoId, BuffNo, SkillId, TotalTargetCount) of
        fail ->
          #dam_sub_dtl{};

        {ok, nothing_to_do} ->
          #dam_sub_dtl{};

        {ok, new_buff_added} ->
          ?BT_LOG(io_lib:format("apply_one_skill_in_eff_to__(), new_buff_added, AtterId=~p, DeferId=~p, TarBoId=~p, BuffNo=~p~n", [AtterId, DeferId, TarBoId, BuffNo])),
          case TarBoId of  % 目前认为目标bo要么是攻击者， 要么是防守者，不存在其他的情况!! 下同
            AtterId ->
              #dam_sub_dtl{atter_buffs_added = [BuffNo]};
            DeferId ->
              #dam_sub_dtl{defer_buffs_added = [BuffNo]};
            _ ->
              ?ASSERT(false, {SkillId, AtterId, DeferId, TarBoId}),
              ?ERROR_MSG("[mod_battle] apply_one_skill_in_eff_to__() error! info:~w", [{SkillId, AtterId, DeferId, TarBoId}]),
              #dam_sub_dtl{}
          end;

        {ok, old_buff_replaced, OldBuffNo} ->
          ?BT_LOG(io_lib:format("apply_one_skill_in_eff_to__(), old_buff_replaced, AtterId=~p, DeferId=~p, TarBoId=~p, BuffNo=~p, OldBuffNo=~p~n", [AtterId, DeferId, TarBoId, BuffNo, OldBuffNo])),
          case TarBoId of
            AtterId ->
              #dam_sub_dtl{atter_buffs_added = [BuffNo], atter_buffs_removed = [OldBuffNo]};
            DeferId ->
              #dam_sub_dtl{defer_buffs_added = [BuffNo], defer_buffs_removed = [OldBuffNo]};
            _ ->
              ?ASSERT(false, {SkillId, AtterId, DeferId, TarBoId}),
              ?ERROR_MSG("[mod_battle] apply_one_skill_in_eff_to__() error! info:~w", [{SkillId, AtterId, DeferId, TarBoId}]),
              #dam_sub_dtl{}
          end;
        {passi, RemovedBuffNo} ->
          case TarBoId of
            AtterId ->
              #dam_sub_dtl{ atter_buffs_removed =RemovedBuffNo};
            DeferId ->
              #dam_sub_dtl{defer_buffs_removed =RemovedBuffNo};
            _ ->
              ?ASSERT(false, {SkillId, AtterId, DeferId, TarBoId}),
              ?ERROR_MSG("[mod_battle] apply_one_skill_in_eff_to__() error! info:~w", [{SkillId, AtterId, DeferId, TarBoId}]),
              #dam_sub_dtl{}
          end

        % {ok, old_buff_overlapped, OldBuffNo} ->  % 目前针对buff叠加的处理和buff替换的情况是一样的
        % 	case TarBoId of
        % 		AtterId ->
        % 			#dam_sub_dtl{atter_buffs_added = [BuffNo], atter_buffs_removed = [OldBuffNo]};
        % 		DeferId ->
        % 			#dam_sub_dtl{defer_buffs_added = [BuffNo], defer_buffs_removed = [OldBuffNo]};
        % 		_ ->
        % 			?ASSERT(false, {SkillId, AtterId, DeferId, TarBoId}),
        % 			?ERROR_MSG("[mod_battle] apply_one_skill_in_eff_to__() error! info:~w", [{SkillId, AtterId, DeferId, TarBoId}]),
        % 			#dam_sub_dtl{}
        % 	end
      end
  end;



apply_one_skill_in_eff_to__(TarBoId, Eff, ?EN_PURGE_BUFF, _SkillId, {_AtterId, _DeferId}, _TotalTargetCount, _RealDamToDefer) -> % 按驱散规则驱散相应的buff
  PurgeBuffRule = Eff#skl_eff.para,
  {ok, PurgeBuffsDtl} = lib_bo:purge_buff(TarBoId, PurgeBuffRule),
  #dam_sub_dtl{
    atter_buffs_removed = PurgeBuffsDtl#purge_buffs_dtl.atter_buffs_removed,
    defer_buffs_removed = PurgeBuffsDtl#purge_buffs_dtl.defer_buffs_removed
  };




apply_one_skill_in_eff_to__(TarBoId, _Eff, ?EN_REDUCE_TARGET_MP_BY_DO_SKILL_ATT, SkillId, {AtterId, _DeferId}, _TotalTargetCount, _RealDamToDefer) -> % 减少目标的mp（具体减少的数值和心法等级相关）
  ?ASSERT(TarBoId == _DeferId, {TarBoId, _DeferId}), % 注：目前暂时固定认为针对的目标就是当前防守者
  case get_bo_by_id(TarBoId) of
    null ->
      ?ASSERT(false, {TarBoId, AtterId, _DeferId, _Eff}),
      DamageToMp = 0,
      skip;
    _TarBo ->
      Atter = get_bo_by_id(AtterId),
      ?ASSERT(Atter /= null, AtterId),
      DamageToMp = case lib_bo:is_do_fix_Mp_dam_by_xinfa_lv(Atter) of
                     true ->
                       ?BT_LOG(io_lib:format("apply in eff, EN_REDUCE_TARGET_MP_BY_DO_SKILL_ATT, do fix mp dam! AtterId:~p, SkillId:~p~n", [AtterId, SkillId])),
                       lib_bt_calc:calc_fix_dam_to_mp_on_do_skill_att(Atter, SkillId);
                     false ->
                       ?BT_LOG(io_lib:format("apply in eff, EN_REDUCE_TARGET_MP_BY_DO_SKILL_ATT, NOT do fix mp dam! AtterId:~p, SkillId:~p~n", [AtterId, SkillId])),
                       lib_bt_calc:calc_damage_to_mp_on_do_skill_att(Atter, SkillId)
                   end,
      ?BT_LOG(io_lib:format("apply in eff, EN_REDUCE_TARGET_MP_BY_DO_SKILL_ATT, AtterId=~p, SkillId:~p, TarBoId=~p, DamageToMp=~p~n", [AtterId, SkillId, TarBoId, DamageToMp])),
      lib_bo:add_mp(TarBoId, - DamageToMp)
  end,

  #dam_sub_dtl{dam_to_mp = DamageToMp};

apply_one_skill_in_eff_to__(_TarBoId, _Eff, ?EN_REDUCE_TARGET_ANGER_BY_DO_SKILL_ATT, _SkillId, {_AtterId, _DeferId}, _TotalTargetCount, _RealDamToDefer) ->
  #dam_sub_dtl{};


apply_one_skill_in_eff_to__(_TarBoId, Eff, ?EN_RECOVER_SELF_HP_BY_RATE, _SkillId, {AtterId, _DeferId}, _TotalTargetCount, _RealDamToDefer) ->
  ?ASSERT(_TarBoId == AtterId, {_TarBoId, AtterId, Eff}),
  case is_dead(AtterId) of
    true ->  % 如果已死，则不恢复血
      skip;
    false ->
      RecoverRate = Eff#skl_eff.para,
      ?ASSERT(is_number(RecoverRate) andalso RecoverRate >= 0 andalso RecoverRate =< 1, Eff),

      Atter = get_bo_by_id(AtterId),
      ?ASSERT(Atter /= null, AtterId),
      InitHpLim = lib_bo:get_init_hp_lim(Atter),
      HpToAdd = util:ceil(InitHpLim * RecoverRate),
      lib_bo:add_hp(AtterId, HpToAdd)
  end,

  % 不涉及buff，故返回“空的”伤害子详情
  #dam_sub_dtl{};

% 溅射
apply_one_skill_in_eff_to__(TarBoId, Eff, ?EN_SPLASH, _SkillId, {AtterId, _DeferId}, _TotalTargetCount, RealDamToDefer) -> % 溅射效果
  DamVal = RealDamToDefer,
  {SplashPatternNo, Scale} = Eff#skl_eff.para,

  ?DEBUG_MSG("DamVal=~p,SplashPatternNo=~p,Scale=~p,",[DamVal,SplashPatternNo,Scale]),

  {ok, SplashDtlList} = try_apply_splash_eff(AtterId, TarBoId, DamVal, SplashPatternNo, Scale),
  #dam_sub_dtl{
    splash_dtl_list = SplashDtlList
  };


apply_one_skill_in_eff_to__(_Bo, _Eff, EffName, _SkillId, {_AtterId, _DeferId}, _TotalTargetCount, _RealDamToDefer) -> % 容错
  case EffName of



    _Any ->
      ?ERROR_MSG("[mod_battle] apply_one_skill_in_eff_to__() error!!! SkillId:~p~nBo: ~w~nEff: ~w", [_SkillId, _Bo, _Eff]),
      ?ASSERT(false, {_SkillId, _Eff}),
      skip
  end,
  #dam_sub_dtl{}.



% apply_one_skill_in_eff_to__(_Bo, _Eff, _EffName, _SkillId) ->
% 	?ERROR_MSG("[mod_battle] apply_one_skill_in_eff_to__() error!!! SkillId:~p~nBo: ~w~nEff: ~w", [_SkillId, _Bo, _Eff]),
% 	?ASSERT(false, {_SkillId, _Eff}),
% 	error.










%% 处理技能的攻击后的效果
handle_skill_post_effs(ActorId) ->
  % ?DEBUG_MSG("handle_skill_post_effs(), ActorId=~p", [ActorId]),
  Actor = get_bo_by_id(ActorId),

  % CurSkl = lib_bo:get_cur_skill_brief(Actor),
  % SklId = CurSkl#skl_brief.id,

  CurSklCfg = lib_bo:get_cur_skill_cfg(Actor),  %%lib_bt_comm:get_skill_cfg_data(CurSkl),
  ?ASSERT(CurSklCfg /= null, {lib_bo:get_cur_skill_brief(Actor), Actor}),

  BuffPostEff =
    case lib_bo:find_buff_by_name(Actor, ?BFN_ADD_SKILL_EFF) of
      null ->
        [];
      AddEffBuff ->
        AllEffList = lib_bo_buff:get_buff_tpl_para(AddEffBuff),
        PostList = case lists:keyfind(post_effs, 1,AllEffList) of
                     false ->
                       [];
                     {post_effs,PostList2} ->
                       PostList2
                   end
    end,
  CurSklId = mod_skill:get_id(CurSklCfg),
  handle_skill_post_effs(ActorId, CurSklId, mod_skill:get_post_effs(CurSklCfg)  ++ BuffPostEff).


handle_skill_post_effs(_ActorId, _SkillId, []) ->
  done;
handle_skill_post_effs(ActorId, SkillId, [EffNo | T]) ->
  handle_one_skill_post_eff(ActorId, SkillId, EffNo),
  handle_skill_post_effs(ActorId, SkillId, T).



% handle_one_skill_post_eff(_ActorId, _SkillId, _EffNo) ->
% 	todo_here.

handle_one_skill_post_eff(ActorId, SkillId, EffNo) ->
  Eff = lib_skill_eff:get_cfg_data(EffNo),
  ?ASSERT(Eff /= null, EffNo),
  % 确定作用目标
  case lib_bt_skill:decide_skill_eff_targets(ActorId, Eff) of
    [] ->
      skip;
    TarBoIdList ->
      handle_one_skill_post_eff__(ActorId, SkillId, Eff, Eff#skl_eff.name, TarBoIdList)
  end.


handle_one_skill_post_eff__(ActorId, SkillId, Eff, ?EN_ADD_BUFF, TarBoIdList) ->
  ?TRACE("handle_one_skill_post_eff__(), EN_ADD_BUFF, TarBoIdList=~p~n", [TarBoIdList]),
  handle_skill_add_buff_eff(ActorId, SkillId, Eff, TarBoIdList);

%% 添加多个指定编号的buff，需收集战报！
handle_one_skill_post_eff__(ActorId, SkillId, Eff, ?EN_ADD_MULTI_BUFFS, TarBoIdList) ->
  ?TRACE("handle_one_skill_post_eff__(), EN_ADD_MULTI_BUFFS, TarBoIdList=~p~n", [TarBoIdList]),
  handle_skill_add_multi_buffs_eff(ActorId, SkillId, Eff, TarBoIdList);

%% 驱散规定规则的buff，需收集战报！ {by_no, BuffNo, Num} or {by_category, BuffCategory, Num} or {by_eff_type, EffType, Num}
handle_one_skill_post_eff__(ActorId, SkillId, Eff, ?EN_PURGE_BUFF, TarBoIdList) ->
  handle_skill_purge_buff_pre_eff(ActorId, SkillId, Eff, TarBoIdList);

%% 治疗----加血，需收集战报！
handle_one_skill_post_eff__(ActorId, SkillId, Eff, ?EN_HEAL_HP, TarBoIdList) ->
  ?TRACE("handle_one_skill_post_eff__(), EN_HEAL_HP, TarBoIdList=~p~n", [TarBoIdList]),
  handle_skill_heal_hp_eff(ActorId, SkillId, Eff, TarBoIdList);

%% 治疗----加血并添加buff（通常是hot类buff），需收集战报！
handle_one_skill_post_eff__(ActorId, SkillId, Eff, ?EN_HEAL_HP_AND_ADD_BUFF, TarBoIdList) ->
  ?TRACE("handle_one_skill_post_eff__(), EN_HEAL_HP_AND_ADD_BUFF, TarBoIdList=~p~n", [TarBoIdList]),
  handle_skill_heal_HP_and_add_buff_eff(ActorId, SkillId, Eff, TarBoIdList);

%% 治疗----加蓝并添加buff（通常是hot类buff），需收集战报！
handle_one_skill_post_eff__(ActorId, SkillId, Eff, ?EN_HEAL_MP_AND_ADD_BUFF, TarBoIdList) ->
  ?TRACE("handle_one_skill_post_eff__(), EN_HEAL_MP_AND_ADD_BUFF, TarBoIdList=~p~n", [TarBoIdList]),
  handle_skill_heal_MP_and_add_buff_eff(ActorId, SkillId, Eff, TarBoIdList);

%% 治疗----复活，需收集战报！
handle_one_skill_post_eff__(ActorId, SkillId, Eff, ?EN_REVIVE, TarBoIdList) ->
  ?BT_LOG(io_lib:format("handle_one_skill_post_eff__(), EN_REVIVE, SkillId=~p,TarBoIdList=~p~n", [SkillId, TarBoIdList])),
  handle_skill_revive_eff(ActorId, SkillId, Eff, TarBoIdList);

handle_one_skill_post_eff__(ActorId, SkillId, Eff, ?EN_REDUCE_TARGET_ANGER_BY_DO_SKILL_ATT, TarBoIdList) ->
  ?BT_LOG(io_lib:format("handle_one_skill_post_eff__, EN_REDUCE_TARGET_ANGER_BY_DO_SKILL_ATT:~w~n", [TarBoIdList])),
  handle_skill_heal_anger_eff(ActorId, SkillId, Eff, TarBoIdList);


%% 强行死亡并离开战斗，需收集战报！
handle_one_skill_post_eff__(_ActorId, _SkillId, Eff, ?EN_FORCE_DIE_AND_LEAVE_BATTLE, TarBoIdList) ->
  ?BT_LOG(io_lib:format("handle_one_skill_post_eff__(),   EN_FORCE_DIE_AND_LEAVE_BATTLE,  TarBoIdList=~p~n", [TarBoIdList])),

  ?ASSERT(TarBoIdList == [_ActorId]),  % 目前临时断言强行死亡只是针对行动者自己

  % 判断概率是否成功？
  case lib_bt_util:test_proba(Eff#skl_eff.trigger_proba) of
    fail ->
      skip;
    success ->
      F = fun(TarBoId) ->
        lib_bo:set_hp(TarBoId, 0),
        TarBo = get_bo_by_id(TarBoId),
        ?ASSERT(TarBo /= null, TarBoId),
        DieDtl = lib_bo:bo_die_and_force_leave_battle(TarBo),
        #force_die_dtl{
          bo_id = TarBoId,
          die_status = DieDtl#die_details.die_status,
          buffs_removed = DieDtl#die_details.buffs_removed
        }
          end,

      ForceDieDtlList = [F(X) || X <- TarBoIdList],
      Action = #boa_force_die{
        details_list = ForceDieDtlList
      },

      % 收集战报
      collect_battle_report(boa_force_die, Action)
  end;




handle_one_skill_post_eff__(_ActorId, _SkillId, _Eff, _EffName, _TarBoIdList) ->
  ?ERROR_MSG("[BATTLE] handle_one_skill_post_eff__() ERROR!!! SkillId:~p~nActor: ~w~nEff: ~w~n _EffName:~w", [_SkillId, get_bo_by_id(_ActorId), _Eff,_EffName]),
  ?ASSERT(false, {_SkillId, _Eff}),
  error.







% %% 如果需要，重新选择攻击目标
% %% @return: null | 目标bo id
% maybe_repick_att_target(Atter) ->
% 	TargetBoId = lib_bo:get_cur_pick_target(Atter),

% 	AtterId = lib_bo:get_id(Atter),
% 	% 确定攻击目标
% 	case can_attack(AtterId, TargetBoId) of
% 		true ->
% 			TargetBoId;
% 		false ->
% 			repick_att_target(AtterId)
% 	end.



%% 判定普通攻击的攻击目标的规则列表
-define(RULES_FILTER_TARGET_FOR_NORMAL_ATT, [?RDT_NOT_INVINCIBLE, ?RDT_ENEMY_SIDE,?RDT_UNDEAD]).
-define(RULES_FILTER_TARGET_FOR_NORMAL_ATT_ON_BE_TAUNT, [?RDT_NOT_INVINCIBLE, ?RDT_HE_WHO_TAUNT_ME]).  % 被嘲讽时，只挑选嘲讽我的bo
-define(RULES_FILTER_TARGET_FOR_NORMAL_ATT_ON_CHAOS, [?RDT_NOT_INVINCIBLE, ?RDT_UNDEAD]).  % 混乱状态下敌我不分，随机选一个未死亡的目标

% 攻击敌人
-define(RULES_FILTER_TARGET_FOR_NORMAL_ATT_ON_CHAOS1, [?RDT_NOT_INVINCIBLE, ?RDT_ENEMY_SIDE,?RDT_UNDEAD]).
% 攻击自己人以及敌人
-define(RULES_FILTER_TARGET_FOR_NORMAL_ATT_ON_CHAOS2, [?RDT_NOT_INVINCIBLE,?RDT_UNDEAD]).
-define(RULES_FILTER_TARGET_FOR_NORMAL_ATT_BY_ONLINE_PLAYER_OR_MAIN_PAR, [?RDT_NOT_INVINCIBLE, ?RDT_UNDEAD]). % 针对在线玩家或主宠的普通攻击的目标筛选规则（允许攻击自己人）

% !!! 注意 选择“对我身上释放指定类别buff”的bo优先级最高，故要放最前面
-define(RULES_SORT_TARGET_FOR_NORMAL_ATT, [{?RDT_SPEC_CATEGORY_BUFF_FROM_FIRST, 1000}, ?RDT_CUR_PICK_TARGET_FIRST, ?RDT_SJJH_PRINCIPLE, ?RDT_NOT_FROZEN_FIRST]).
-define(RULES_SORT_TARGET_FOR_MONSTER_DO_NORMAL_ATT, [?RDT_RE_DISORDER, {?RDT_SPEC_CATEGORY_BUFF_FROM_FIRST, 1000}, ?RDT_CUR_PICK_TARGET_FIRST, ?RDT_NOT_FROZEN_FIRST]).  % 怪物普通攻击时随机选一个目标，不遵循随机集火原则！



%% 判定普通攻击的攻击目标
%% @return: [] | 目标战斗对象id列表
decide_att_targets_for_normal_att(Atter) ->
  decide_att_targets_for_normal_att(Atter, dummy).


%% 注意：ExtraInfo目前仅用于追击的情况，以保证追击的目标和追击前所打的目标是属于同一方  -- huangjf
decide_att_targets_for_normal_att(Atter, ExtraInfo) ->
  ?ASSERT(is_record(Atter, battle_obj), Atter),
  case lib_bo:is_chaos(Atter) of
    true ->
      % 降低攻击自己的几率
      RandNum = util:rand(1, ?PROBABILITY_BASE),
      Rdt_Filter =
        case (RandNum =< (lib_bo:get_be_chaos_att_team_paoba(Atter)+300))  of
          true -> ?RULES_FILTER_TARGET_FOR_NORMAL_ATT_ON_CHAOS2;
          false -> ?RULES_FILTER_TARGET_FOR_NORMAL_ATT_ON_CHAOS1
        end,

      % Rdt_Filter = ?RULES_FILTER_TARGET_FOR_NORMAL_ATT_ON_CHAOS,
      Rdt_Sort = [];
    false ->
      case lib_bo:is_be_taunt(Atter) of
        true ->
          Rdt_Filter = ?RULES_FILTER_TARGET_FOR_NORMAL_ATT_ON_BE_TAUNT,
          Rdt_Sort = [];
        false ->
          Rdt_Filter = case (lib_bt_comm:is_online_player(Atter) orelse lib_bt_comm:is_online_main_partner(Atter))
            andalso lib_bo:is_original_using_normal_att(Atter) % 必须是本意是用普攻，被强行矫正为普攻的不算
            andalso (lib_bo:get_cur_pick_target(Atter) /= ?INVALID_ID)
            andalso is_living(lib_bo:get_cur_pick_target(Atter)) of % 而且所选目标须活着（避免：自动战斗时，普攻打死一个目标后，可能一直打另一个自己人（随机集火刚好优先选到自己人））
                         true ->
                           ?RULES_FILTER_TARGET_FOR_NORMAL_ATT_BY_ONLINE_PLAYER_OR_MAIN_PAR;
                         false->
                           ?RULES_FILTER_TARGET_FOR_NORMAL_ATT
                       end,
          Rdt_Sort = 	case is_monster(Atter) of
                        true ->
                          ?RULES_SORT_TARGET_FOR_MONSTER_DO_NORMAL_ATT;
                        false ->
                          ?RULES_SORT_TARGET_FOR_NORMAL_ATT
                      end
      end
  end,
  ?TRACE("decide_att_targets_for_normal_att(), AtterId: ~p, IsChaos:~p, Rdt_Filter:~p, Rdt_Sort:~p~n", [?BOID(Atter), lib_bo:is_chaos(Atter), Rdt_Filter, Rdt_Sort]),

  % 做适当矫正，以保证追击的目标和追击前所打的目标是属于同一方
  Rdt_Filter2 = case ExtraInfo of
                  {is_pursue_att, OldDeferSide} ->
                    (Rdt_Filter -- [?RDT_ENEMY_SIDE, ?RDT_ALLY_SIDE])
                    ++ [{specific_side, OldDeferSide}];  % TODO:  改为统一用宏 -- huangjf
                  _ ->
                    Rdt_Filter
                end,

  Eff = #skl_eff{
    no = 0,  % 效果编号实际上没用到，目前先随意默认填0
    name = ?EN_DO_ATTACK,  % 效果名为执行攻击
    trigger_proba = ?PROBABILITY_BASE,    % 必定触发
    rules_filter_target = Rdt_Filter2,
    rules_sort_target = Rdt_Sort,
    target_count = 1,          % 普通攻击的目标个数固定为1个
    para = null                % 参数没用
  },
  RetL = decide_att_targets__(Atter, Eff),
  ?ASSERT(util:is_integer_list(RetL), {RetL, Eff, Atter}),
  ?BT_LOG(io_lib:format("decide_att_targets_for_normal_att(), AtterId=~p, RetL=~p~n", [?BOID(Atter), RetL])),
  RetL.



%% 判定攻击目标
%% @return: [] | 目标战斗对象id列表
decide_att_targets(AtterId) ->
  decide_att_targets(AtterId, dummy).

%% 注意：ExtraInfo目前仅用于追击的情况，以保证追击的目标和追击前所打的目标是属于同一方  -- huangjf
decide_att_targets(AtterId, ExtraInfo) ->
  ?ASSERT(is_integer(AtterId), AtterId),
  ?ASSERT(is_living(AtterId), AtterId),


  Atter = get_bo_by_id(AtterId),
  % CurSklBrf = lib_bo:get_cur_skill_brief(Atter),

  % 如果是混乱状态下，或者强行攻击，或者当前回合选择了普通攻击，则转为针对普通攻击的判定
  % TODO: 确认放在这里处理是否ok？ 是否漏了什么东西？？

  % case lib_bo:is_chaos(Atter)
  % orelse lib_bo:is_force_auto_attack(Atter)     % 注意： 如果以后强行自动攻击不一定都是转为普通攻击，则需对应做调整！ -- huangjf
  % orelse lib_bo:is_using_normal_att(Atter) of
  case lib_bo:is_using_normal_att(Atter) of
    true ->
      decide_att_targets_for_normal_att(Atter, ExtraInfo);
    false ->
      decide_att_targets__(Atter) % 使用技能（非普攻）时，技能的筛选目标效果可以保证两次判定选的目标是同一方
  end.



decide_att_targets__(Atter) when is_record(Atter, battle_obj) ->
  CurSklCfg = lib_bo:get_cur_skill_cfg(Atter),
  ?ASSERT(CurSklCfg /= null, Atter),

  AttEffNo = mod_skill:get_att_eff(CurSklCfg),
  ?ASSERT(AttEffNo /= ?INVALID_EFF_NO, {CurSklCfg, lib_bo:get_cur_skill_brief(Atter)}),
  Eff = lib_skill_eff:get_cfg_data(AttEffNo),
  ?ASSERT(Eff /= null, {AttEffNo, CurSklCfg}),
  decide_att_targets__(Atter, Eff).

decide_att_targets__(Atter, SklAttEff) when is_record(SklAttEff, skl_eff) ->
  ?ASSERT(is_record(Atter, battle_obj), Atter),
  lib_bt_skill:decide_skill_eff_targets(?BOID(Atter), SklAttEff).


% case Eff#skl_eff.rules_decide_target of
% 	[cur_pick_target_first] ->
% 		CurPickTar = lib_bo:get_cur_pick_target(Atter),
% 		AtterId = lib_bo:get_id(Atter),

% 		case can_attack(AtterId, CurPickTar) of
% 			true ->
% 				CurPickTar;
% 			false ->
% 				repick_att_target(AtterId)
% 		end;
% 	_Any ->
% 		?ASSERT(false, _Any),
% 		null
% end.



% %% 重新判定攻击目标  TODO: 应用目标选定规则、随机集火，宠物宝宝排后等原则。。
% %% @return: null | 战斗对象id
% redecide_att_targets(AtterId) -> % RENAME TO: decide_att_target_again() ??
%     Atter = get_bo_by_id(AtterId),
%     EnemySide = to_enemy_side( lib_bo:get_side(Atter)),

%     L = case lib_bo:is_chaos(Atter) of
%             true -> get_all_bo_id_list();  % 混乱状态下随意攻击（包括己方）
%             false -> get_bo_id_list(EnemySide)
%         end,

%     L2 = L -- [AtterId],  % 排除掉自己

%     redecide_att_targets__(AtterId, L2).



% redecide_att_targets__(AtterId, [CurBoId | T]) ->
%     case can_attack(AtterId, CurBoId) of
%         true ->
%             CurBoId;
%         false ->
%             redecide_att_targets__(AtterId, T)
%     end;
% redecide_att_targets__(_AtterId, []) ->
%     null.



%% 专用于重新判定追击的目标
redecide_att_targets_for_pursue_att(AtterId, OldDefer) ->
  OldDeferSide = lib_bo:get_side(OldDefer),
  redecide_att_targets(AtterId, {is_pursue_att, OldDeferSide}).


%% 重新判定攻击目标
%% @return: null | 战斗对象id列表
redecide_att_targets(AtterId) -> % RENAME TO: decide_att_target_again() ??
  redecide_att_targets(AtterId, dummy).

redecide_att_targets(AtterId, ExtraInfo) ->
  decide_att_targets(AtterId, ExtraInfo).





try_single_target_phy_attack(Atter) ->
  % TargetBoId = lib_bo:get_target_bo_id(Atter),

  % AtterId = lib_bo:get_id(Atter),
  % % 确定攻击目标
  % case can_attack(AtterId, TargetBoId) of
  % 	true ->
  % 		do_single_target_phy_attack(AtterId, TargetBoId);
  % 	false ->
  % 		case repick_attack_target(AtterId) of
  % 			null ->
  % 				skip;
  % 			NewTargetBoId ->
  % 				% lib_bo:set_cur_attack_target(Bo, NewTargetBoId),
  % 				do_single_target_phy_attack(AtterId, NewTargetBoId)
  % 		end
  % end.


  % ?ASSERT(begin
  % 			CurSklCfg = lib_bo:get_cur_skill_cfg(Atter),
  % 			AttEffNo = mod_skill:get_att_eff(CurSklCfg),
  % 			case AttEffNo of
  % 				?INVALID_EFF_NO -> false;
  % 				_ ->
  % 					case lib_skill_eff:get_cfg_data(AttEffNo) of
  % 						null -> false;
  % 						Eff -> (Eff#skl_eff.name == ?EN_DO_ATTACK) andalso (Eff#skl_eff.target_count == 1)
  % 					end
  % 			end
  % 		end, CurSklCfg),

  %%case maybe_repick_att_target(Atter) of
  case decide_att_targets(?BOID(Atter)) of
    [] ->  % 没有合适的目标可打
      throw(handle_attack_eff_done);  %%skip;
    TargetBoIdL ->
      ?ASSERT(is_list(TargetBoIdL), TargetBoIdL),
      TargetBoId = erlang:hd(TargetBoIdL),  % 选第一个
      do_single_target_phy_attack( ?BOID(Atter), TargetBoId)
  end.



try_multi_target_phy_attack(Atter) ->
  CurSklCfg = lib_bo:get_cur_skill_cfg(Atter),

  AttEffNo = mod_skill:get_att_eff(CurSklCfg),
  ?ASSERT(AttEffNo /= ?INVALID_EFF_NO, CurSklCfg),

  _AttEff = lib_skill_eff:get_cfg_data(AttEffNo),
  ?ASSERT(_AttEff /= null, CurSklCfg),

  ?ASSERT(_AttEff#skl_eff.name == ?EN_DO_ATTACK, _AttEff),
  % ?ASSERT(is_integer(AttEff#skl_eff.target_count)
  % 		andalso (AttEff#skl_eff.target_count > 1), AttEff),

  AtterId = lib_bo:id(Atter),

  % % 设置可攻击的最大目标个数
  % MaxCount = AttEff#skl_eff.target_count,
  % lib_bo:set_max_hit_obj_count(AtterId, MaxCount),

  %%case maybe_repick_att_target(Atter) of
  %%case decide_att_targets(Atter, CurSklCfg) of
  %%case decide_att_targets(Atter, AttEff) of
  case decide_att_targets(AtterId) of
    [] ->  % 没有合适的目标可打
      throw(handle_attack_eff_done); %%skip;
    TargetBoIdL ->
      ?ASSERT(is_list(TargetBoIdL), TargetBoIdL),

      ?BT_LOG(io_lib:format("try_multi_target_phy_attack(), TargetBoIdL: ~p~n", [TargetBoIdL])),
      put({cur_att_target,AtterId}, TargetBoIdL),

      % 以第一次所匹配出的目标数作为此次多目标攻击的目标数上限
      lib_bo:set_max_hit_obj_count(AtterId, length(TargetBoIdL)),

      TargetBoId = erlang:hd(TargetBoIdL),  % 选第一个
      do_multi_target_phy_attack_each(AtterId, TargetBoId)
  end.





% decide_magic_att_targets(_Atter) ->
% 	todo_here.


% ---------------------------------------
try_poison_attack(Atter) ->
  % 确定目标列表
  % case decide_magic_att_targets(Atter) of
  AtterId = lib_bo:id(Atter),
  case decide_att_targets(AtterId) of
    [] ->  % 没有合适的攻击目标，则跳过
      throw(handle_attack_eff_done); %%skip;
    TargetBoIdL ->
      ?ASSERT(is_list(TargetBoIdL), TargetBoIdL),
      % 确定连击次数上限与当前衰减..
      % ...
      put({cur_att_target,AtterId}, TargetBoIdL),
      do_poison_attack(AtterId, TargetBoIdL, false)
  end.


%% 执行一轮毒攻击
%% @para: IsComboAtt => 此轮攻击是否为法术连击？
do_poison_attack(AtterId, DeferIdList, IsComboAtt) ->
  ?ASSERT(DeferIdList /= []),
  do_poison_attack__(AtterId, DeferIdList, IsComboAtt, DeferIdList, []).


do_poison_attack__(AtterId, [CurDeferId | T], IsComboAtt, Old_DeferIdList, Acc_MagDamDtlList) ->

  ?ASSERT(can_attack(AtterId, CurDeferId)),

  % 记录当前所攻击的目标
  lib_bo:set_cur_att_target(AtterId, CurDeferId),

  TargetCount = length(Old_DeferIdList),

  {MagDamDtl,SupoortDet__} = apply_poison_damage(AtterId, CurDeferId, TargetCount),
  ?ASSERT(is_record(MagDamDtl, mag_dam_dtl), MagDamDtl),

  % 标记为已打过
  % lib_bo:mark_already_attacked(AtterId, DeferId),

  Acc_MagDamDtlList_2 = Acc_MagDamDtlList ++ [MagDamDtl],

  ?Ifc (is_battle_finish())
collect_battle_report(boa_do_mag_att, AtterId, IsComboAtt, Acc_MagDamDtlList_2),
throw(battle_finish)
?End,

?Ifc (is_dead(AtterId))
collect_battle_report(boa_do_mag_att, AtterId, IsComboAtt, Acc_MagDamDtlList_2),
throw(handle_attack_eff_done)  %%throw(handle_bo_cmd_done)
?End,
SupoortDetFun =
fun(SupoortAction) ->
collect_battle_report(boa_summon,SupoortAction)
end,
lists:foreach(SupoortDetFun , SupoortDet__),
% Bo = get_bo_by_id(CurDeferId),
% ?DEBUG_MSG("Bo = ~p,BUFF LIST223 = ~p",[Bo,lib_bo:get_buff_list(Bo)]),

do_poison_attack__(AtterId, T, IsComboAtt, Old_DeferIdList, Acc_MagDamDtlList_2);


do_poison_attack__(AtterId, [], IsComboAtt, Old_DeferIdList, Acc_MagDamDtlList) ->
% 对多个目标打完一轮后，收集战报
collect_battle_report(boa_do_mag_att, AtterId, IsComboAtt, Acc_MagDamDtlList),
throw(handle_attack_eff_done).

% --------------------------------------


try_magic_attack(Atter) ->
  % 确定目标列表
  % case decide_magic_att_targets(Atter) of
  AtterId = lib_bo:id(Atter),
  case decide_att_targets(AtterId) of
    [] ->  % 没有合适的攻击目标，则跳过
      throw(handle_attack_eff_done); %%skip;
    TargetBoIdL ->
      ?ASSERT(is_list(TargetBoIdL), TargetBoIdL),
      % 确定连击次数上限与当前衰减..
      % ...
      %%判断下是否有对象因为中途触发buff导致飞出战斗了，这样子的对象需要移除掉，无法攻击
      F =
        fun(X, Acc) ->
          case can_attack(AtterId, X) of
            true ->
              [X|Acc];
            false ->
              Acc
          end
        end,
      TargetBoIdL2 = lists:foldl(F, [], TargetBoIdL),
      case TargetBoIdL2 of
        [] ->
          throw(handle_attack_eff_done);
        _ ->
          put({cur_att_target,AtterId}, TargetBoIdL2),
          do_magic_attack(AtterId, TargetBoIdL2, false)
      end

  end.


try_phy_2_attack(Atter) ->
  % 确定目标列表
  % case decide_magic_att_targets(Atter) of
  AtterId = lib_bo:id(Atter),
  case decide_att_targets(AtterId) of
    [] ->  % 没有合适的攻击目标，则跳过
      throw(handle_attack_eff_done); %%skip;
    TargetBoIdL ->
      ?ASSERT(is_list(TargetBoIdL), TargetBoIdL),
      % 确定连击次数上限与当前衰减..
      % ...
      %%判断下是否有对象因为中途触发buff导致飞出战斗了，这样子的对象需要移除掉，无法攻击
      F =
        fun(X, Acc) ->
          case can_attack(AtterId, X) of
            true ->
              [X|Acc];
            false ->
              Acc
          end
        end,
      TargetBoIdL2 = lists:foldl(F, [], TargetBoIdL),
      case TargetBoIdL2 of
        [] ->
          throw(handle_attack_eff_done);
        _ ->
          put({cur_att_target,AtterId}, TargetBoIdL2),
          do_phy_2_attack(AtterId, TargetBoIdL2, false)
      end

  end.


%% 执行一轮法术攻击
%% @para: IsComboAtt => 此轮攻击是否为法术连击？
do_magic_attack(AtterId, DeferIdList, IsComboAtt) ->
  ?ASSERT(DeferIdList /= []),
  do_magic_attack__(AtterId, DeferIdList, IsComboAtt, DeferIdList, [],[]).


do_magic_attack__(AtterId, [CurDeferId | T], IsComboAtt, Old_DeferIdList, Acc_MagDamDtlList,Acc_SupoortAction) ->

  ?ASSERT(can_attack(AtterId, CurDeferId)),  %%这里报错了

  % 记录当前所攻击的目标
  lib_bo:set_cur_att_target(AtterId, CurDeferId),

  TargetCount = length(Old_DeferIdList),

  {MagDamDtl,SupoortDet__}  = apply_mag_damage(AtterId, CurDeferId, TargetCount),
  ?ASSERT(is_record(MagDamDtl, mag_dam_dtl), MagDamDtl),

  % 标记为已打过
  % lib_bo:mark_already_attacked(AtterId, DeferId),

  Acc_MagDamDtlList_2 = Acc_MagDamDtlList ++ [MagDamDtl],

  ?Ifc (is_battle_finish())
collect_battle_report(boa_do_mag_att, AtterId, IsComboAtt, Acc_MagDamDtlList_2),
throw(battle_finish)
?End,

?Ifc (is_dead(AtterId))
collect_battle_report(boa_do_mag_att, AtterId, IsComboAtt, Acc_MagDamDtlList_2),
throw(handle_attack_eff_done)  %%throw(handle_bo_cmd_done)
?End,


Acc_SupoortAction2 = SupoortDet__ ++ Acc_SupoortAction,

% Bo = get_bo_by_id(CurDeferId),
% ?DEBUG_MSG("Bo = ~p,BUFF LIST223 = ~p",[Bo,lib_bo:get_buff_list(Bo)]),

do_magic_attack__(AtterId, T, IsComboAtt, Old_DeferIdList, Acc_MagDamDtlList_2, Acc_SupoortAction2);


do_magic_attack__(AtterId, [], IsComboAtt, Old_DeferIdList, Acc_MagDamDtlList,SupoortDet__) ->
% 对多个目标打完一轮后，收集战报
collect_battle_report(boa_do_mag_att, AtterId, IsComboAtt, Acc_MagDamDtlList),

SupoortDetFun =
fun(SupoortAction) ->
collect_battle_report(boa_summon,SupoortAction)
end,
lists:foreach(SupoortDetFun , SupoortDet__),
% 判断是否可以法术连击？
SklCfg = lib_bo:get_cur_skill_cfg(get_bo_by_id(AtterId)),
IsCanCombo =
case SklCfg of
null ->
 false;
SklCfg ->
mod_skill:is_can_combo(SklCfg)
end,
case IsCanCombo of
true ->
case lib_bo:can_mag_combo_attack(AtterId, Old_DeferIdList) of
{true, Left_DeferIdList} ->
?ASSERT(Left_DeferIdList /= []),
do_mag_combo_attack(AtterId, Left_DeferIdList);
false ->
throw(handle_attack_eff_done)  %%throw(handle_bo_cmd_done)
end;
false ->
skip
end.


%% 执行一轮物理群攻
%% @para: IsComboAtt => 此轮攻击是否为法术连击？
do_phy_2_attack(AtterId, DeferIdList, IsComboAtt) ->
  ?ASSERT(DeferIdList /= []),
  do_phy_2_attack__(AtterId, DeferIdList, IsComboAtt, DeferIdList, [],[]).


do_phy_2_attack__(AtterId, [CurDeferId | T], IsComboAtt, Old_DeferIdList, Acc_MagDamDtlList,Acc_SupoortAction) ->

  ?ASSERT(can_attack(AtterId, CurDeferId)),  %%这里报错了

  % 记录当前所攻击的目标
  lib_bo:set_cur_att_target(AtterId, CurDeferId),

  TargetCount = length(Old_DeferIdList),

  {MagDamDtl,SupoortDet__}  = apply_phy_2_damage(AtterId, CurDeferId, TargetCount),
  ?ASSERT(is_record(MagDamDtl, mag_dam_dtl), MagDamDtl),

  % 标记为已打过
  % lib_bo:mark_already_attacked(AtterId, DeferId),

  Acc_MagDamDtlList_2 = Acc_MagDamDtlList ++ [MagDamDtl],

  ?Ifc (is_battle_finish())
collect_battle_report(boa_do_mag_att, AtterId, IsComboAtt, Acc_MagDamDtlList_2),
throw(battle_finish)
?End,

?Ifc (is_dead(AtterId))
collect_battle_report(boa_do_mag_att, AtterId, IsComboAtt, Acc_MagDamDtlList_2),
throw(handle_attack_eff_done)  %%throw(handle_bo_cmd_done)
?End,


Acc_SupoortAction2 = SupoortDet__ ++ Acc_SupoortAction,

% Bo = get_bo_by_id(CurDeferId),
% ?DEBUG_MSG("Bo = ~p,BUFF LIST223 = ~p",[Bo,lib_bo:get_buff_list(Bo)]),

do_phy_2_attack__(AtterId, T, IsComboAtt, Old_DeferIdList, Acc_MagDamDtlList_2, Acc_SupoortAction2);


do_phy_2_attack__(AtterId, [], IsComboAtt, Old_DeferIdList, Acc_MagDamDtlList,SupoortDet__) ->
% 对多个目标打完一轮后，收集战报
collect_battle_report(boa_do_mag_att, AtterId, IsComboAtt, Acc_MagDamDtlList),

SupoortDetFun =
fun(SupoortAction) ->
collect_battle_report(boa_summon,SupoortAction)
end,
lists:foreach(SupoortDetFun , SupoortDet__),
% 判断是否可以法术连击？
SklCfg = lib_bo:get_cur_skill_cfg(get_bo_by_id(AtterId)),
IsCanCombo =
case SklCfg of
null ->
false;
SklCfg ->
mod_skill:is_can_combo(SklCfg)
end,
case IsCanCombo of
true ->
case lib_bo:can_mag_combo_attack(AtterId, Old_DeferIdList) of
{true, Left_DeferIdList} ->
?ASSERT(Left_DeferIdList /= []),
do_phy_2_combo_attack(AtterId, Left_DeferIdList);
false ->
throw(handle_attack_eff_done)  %%throw(handle_bo_cmd_done)
end;
false ->
skip
end.




%% 处理bo依据AI下达指令
%% TODO: 确认 --- 是否需要处理雇佣玩家？ 目前暂时没必要！
bo_prepare_cmd_by_AI() ->
  State = get_battle_state(),
  ?Ifc (lib_bt_comm:is_PVE_battle(State))  %%%(State#btl_state.type == ?BTL_T_PVE)
monsters_prepare_cmd_by_AI()
?End,

partners_prepare_cmd_by_AI(),

players_prepare_cmd_by_AI().


%% 确定所有bo的当前回合的对话气泡ai
decide_all_bo_cur_round_talk_AI() ->
  L = get_all_bo_id_list(),
  F = fun(BoId) ->
    lib_bt_AI:decide_bo_cur_round_talk_AI(BoId)
      end,
  lists:foreach(F, L).





%% TODO: AI暂时都是普通攻击，有待后续完善
monsters_prepare_cmd_by_AI() ->
  % L = get_bo_id_list(?GUEST_SIDE),   % 注意：固定认为怪物只在客队方
  % F = fun(BoId) ->
  % 		MonBo = get_bo_by_id(BoId),
  % 		?ASSERT(is_monster(MonBo), MonBo),
  % 		?BT_LOG(io_lib:format("monster pick cmd by AI, BoId=~p~n", [f])),
  % 		TargetBoId = ?INVALID_ID,
  % 		lib_bo:prepare_cmd_normal_att(MonBo, TargetBoId)
  % 	end,
  % lists:foreach(F, L).

  L = get_all_bo_id_list(), %%%get_bo_id_list(?GUEST_SIDE),   % 注意：剧情战斗中，怪物有可能出现在主队方
  F = fun(BoId) ->
    Bo = get_bo_by_id(BoId),
    case is_monster(Bo) of %%% andalso is_living(Bo) of   % TODO: 这里考虑去掉is_living()的判断， 死亡也可以照样下指令？！
      false ->
        skip;
      true ->
        case lib_bt_comm:is_plot_bo(Bo) andalso lib_bo:can_be_ctrled(Bo) of
          true ->
            skip;
          false ->
            ?BT_LOG(io_lib:format("monster prepare cmd by AI, BoId=~p~n", [BoId])),
            lib_bt_AI:bo_prepare_cmd_by_AI(BoId)
        end
    end
      end,
  lists:foreach(F, L).





%%
partners_prepare_cmd_by_AI() ->
  L = get_all_bo_id_list(),
  F = fun(BoId) ->
    Bo = get_bo_by_id(BoId),
    case lib_bt_comm:is_deputy_partner(Bo)
      orelse (lib_bt_comm:is_main_partner(Bo) andalso lib_bt_comm:is_offline(Bo)) of   %%andalso is_living(Bo) of
      false ->
        skip;
      true ->
        ?BT_LOG(io_lib:format("partner prepare cmd by AI, BoId=~p~n", [BoId])),
        % TargetBoId = ?INVALID_ID,
        % lib_bo:prepare_cmd_normal_att(Bo, TargetBoId)

        lib_bt_AI:bo_prepare_cmd_by_AI(BoId)
    end
      end,
  lists:foreach(F, L).







%%
players_prepare_cmd_by_AI() ->
  % State = get_battle_state(),
  % case lib_bt_comm:is_offline_arena_battle(State) orelse lib_bt_comm:is_hijack_battle(State) of
  % 	false ->
  % 		skip;
  % 	true ->
  L = get_all_bo_id_list(), %%get_bo_id_list(?GUEST_SIDE),
  F = fun(BoId) ->
    Bo = get_bo_by_id(BoId),
    case lib_bt_comm:is_offline_player(Bo) andalso (not lib_bt_comm:is_hired_player(Bo)) of
      false ->
        skip;
      true ->
        ?BT_LOG(io_lib:format("offline player(but not hired player) prepare cmd by AI, BoId=~p~n", [BoId])),
        lib_bt_AI:bo_prepare_cmd_by_AI(BoId)
    end
      end,
  lists:foreach(F, L).
% end.








%% 是否所有客户端都播放战报完毕了？
are_all_show_battle_report_done() ->
  % 只需判断在线的玩家
  L = get_all_online_player_bo_id_list(),
  are_all_show_battle_report_done__(L).


are_all_show_battle_report_done__([BoId | T]) ->
  Bo = get_bo_by_id(BoId),
  case lib_bo:is_show_battle_report_done(Bo) of
    true ->
      are_all_show_battle_report_done__(T);
    false ->
      false
  end;
are_all_show_battle_report_done__([]) ->
  true.



decide_win_side_on_exceed_max_rounds() ->
  State = get_battle_state(),
  % PVE超回合，则认为主队失败
  WinSide = case lib_bt_comm:is_PVE_battle(State) of
              true ->
                ?GUEST_SIDE;
              false ->
                % 对于PVP超回合，如果是离线竞技场或劫镖战斗，则认为主队失败，其他情况认为是平局
                case lib_bt_comm:is_offline_arena_battle(State)
                  orelse lib_bt_comm:is_hijack_battle(State) of
                  true ->
                    ?GUEST_SIDE;
                  false ->
                    ?NO_SIDE
                end
            end,
  WinSide.


%% 判定战斗的回合数上限
decide_max_battle_round() ->
  State = get_battle_state(),
  case lib_bt_comm:is_tve_mf_battle(State) of
    true ->
      1199;   % 返回一个较大数值，表示不限回合数
    false ->
      ?DFL_MAX_BATTLE_ROUND
  end.


%% 新回合开始
new_round_begin() ->
  % 更新回合数
  NewRoundNum = incr_round_counter(),
  {_,_, AddAngerValue} = data_special_config:get('anger_resume_set'),
  %%每回合的开始会恢复怒气值
  case NewRoundNum > 1 of
    true ->
      AddAngerF = fun(X,Acc) ->
          case get_bo_by_id(X) of
            null ->
              skip;
            Bo ->
              ExtraAngerRate =
                case lib_bo:find_buff_by_name(Bo, ?BFN_RECOVER_SELF_ANGER_BY_RATE ) of
                null ->
                 0;
                AngerBuff ->
                  BuffData = data_buff:get(AngerBuff#bo_buff.buff_no),
                  BuffData#buff_tpl.para
                  end,
              NewAddAngerValue = util:ceil(AddAngerValue * (1 + Bo#battle_obj.init_attrs#attrs.anger_eff_coef)),
              OldAnger = lib_bo:get_anger(Bo),
              _ExtraAnger = util:ceil(ExtraAngerRate * OldAnger), %%功能重复了ri
              lib_bo:add_anger(X, NewAddAngerValue),
              IsOnline = (Bo#battle_obj.is_online andalso Bo#battle_obj.type == 1),
              [{X,NewAddAngerValue,IsOnline}|Acc]
          end
        end,
      AngerInfo = lists:foldl(AddAngerF, [],get_all_bo_id_list()),
      NotifyAngerF = fun(X) ->
        {BoId,_AddAngerVaule,IsOnline} = X,
        case IsOnline of
          true ->
            {ok,Bin} = pt_20:write(?PT_BT_NOTIFI_ANGER_CHANGE_INFO, [AngerInfo]),
            Atter = get_bo_by_id(BoId),
            ?DEBUG_MSG("wjcTestnotifyanger~p~n",[{ Atter#battle_obj.parent_obj_id,Bin}]),
            lib_send:send_to_uid( Atter#battle_obj.parent_obj_id, Bin);
          false ->
            skip
            end
        end,
      lists:foreach(NotifyAngerF, AngerInfo);
    false ->
      skip
  end,
  BeginBuffFun =
    fun(X) ->
      BeEffList1 = lib_bo:find_passi_eff_by_name_all(get_bo_by_id(X), ?EN_ADD_BUFF_BEGIN_FRIEND_SURVIVAL),
      AddBuffDetail = lib_bo_buff:trigger_passi_buff_begin_friend_survival(get_bo_by_id(X), 0, BeEffList1),
      NotifyFun =
        fun(X2) ->
          BuffsAdded = X2#update_buffs_rule_dtl.atter_buffs_added,
          NotifyDetailBuffFun =
            fun(X3) ->
              lib_bt_send:notify_bo_buff_added(get_bo_by_id(X2#update_buffs_rule_dtl.bo_id), X3)
            end,
          lists:foreach(NotifyDetailBuffFun, BuffsAdded)
        end,

      lists:foreach(NotifyFun, AddBuffDetail)

    end,
  lists:foreach(BeginBuffFun, get_all_bo_id_list() ),

  BeginBuffFun2 =
    fun(X) ->
      BeEffList1 = lib_bo:find_passi_eff_by_name_all(get_bo_by_id(X), ?EN_ADD_BUFF_BEGIN_ENEMY_SURVIVAL),
      AddBuffDetail = lib_bo_buff:trigger_passi_buff_begin_enemy_survival(get_bo_by_id(X), 0, BeEffList1),
      NotifyFun =
        fun(X2) ->
          BuffsAdded = X2#update_buffs_rule_dtl.atter_buffs_added,
          NotifyDetailBuffFun =
            fun(X3) ->
              lib_bt_send:notify_bo_buff_added(get_bo_by_id(X2#update_buffs_rule_dtl.bo_id), X3)
            end,
          lists:foreach(NotifyDetailBuffFun, BuffsAdded)
        end,

      lists:foreach(NotifyFun, AddBuffDetail)

    end,
  lists:foreach(BeginBuffFun2, get_all_bo_id_list() ),


  lib_bt_dict:unmark_cur_round_should_force_finish(),

  % 标记战斗的当前状态为“等待客户端下完指令”
  set_cur_battle_bhv(?BHV_WAITING_CLIENTS_FOR_PREPARE_CMD_DONE),

  % 回合数是否已经达到上限
  case NewRoundNum > decide_max_battle_round() of
    true ->
      WinSide = decide_win_side_on_exceed_max_rounds(),
      set_win_side(WinSide),
      mark_battle_finish(),
      schedule_battle_finish();
    false ->
      % 通知所有客户端：新回合开始
      lib_bt_send:notify_new_round_begin(NewRoundNum),

      % ?DEBUG_MSG("notify_new_round_begin().. NewRoundNum:~p", [NewRoundNum]),

      % 处理剧情战斗的剧情
      lib_bt_plot:handle_plot(),

      % 通知所有客户端：buff结算开始
      lib_bt_send:notify_settle_buff_begin(),

      L = get_all_bo_id_list(),
      lists:foreach(fun lib_bo:on_new_round_begin/1, L),

      % 通知所有客户端：buff结算结束
      lib_bt_send:notify_settle_buff_end(),


      case is_battle_finish() of
        true ->
          schedule_battle_finish();
        false ->
          % 通知所有客户端：新回合开始
          % lib_bt_send:notify_new_round_begin(NewRoundNum)

          bo_prepare_cmd_by_AI(),

          decide_all_bo_cur_round_talk_AI(),

          lib_bt_send:notify_all_bo_cur_round_talk_AI(),

          lib_bt_send:notify_on_new_round_begin_jobs_done(),

          % 预cast一个下达指令超时，以防止战斗卡住
          Intv = ?MAX_WAIT_TIME_FOR_PREPARE_CMD_SEC * 1000 + 9000, % 允许9秒的延迟
          erlang:send_after(Intv, self(), {'prepare_cmd_timeout', lib_bt_comm:get_cur_round()})


        % case need_auto_start_new_round() of
        % 	true ->
        % 		?TRACE("need_auto_start_new_round()? TRUE!!!!!!!~n"),
        % 		schedule_round_action_begin();
        % 	false ->
        % 		?TRACE("need_auto_start_new_round()? FALSE!!!!!!!~n"),
        % 		skip
        % end
      end
  end.






incr_round_counter() ->
  State = get_battle_state(),
  NewRoundNum = State#btl_state.round_counter + 1,
  set_battle_state( State#btl_state{round_counter = NewRoundNum} ),
  NewRoundNum.





%% ##########################################@



get_cur_battle_bhv() ->
  State = get_battle_state(),
  State#btl_state.cur_bhv_state.


set_cur_battle_bhv(Bhv) ->
  State = get_battle_state(),
  State2 = State#btl_state{cur_bhv_state = Bhv},
  set_battle_state(State2).


%% 是否正在等待客户端播放完战报？
is_server_waiting_clients(for_show_br_done) ->
  get_cur_battle_bhv() == ?BHV_WAITING_CLIENTS_FOR_SHOW_BR_DONE;

%% 是否正在等待客户端下达完指令？
is_server_waiting_clients(for_prepare_cmd_done) ->
  get_cur_battle_bhv() == ?BHV_WAITING_CLIENTS_FOR_PREPARE_CMD_DONE.






%% 处理玩家在战斗过程中下线的情况
handle_player_logout(PS) ->
  PlayerId = player:id(PS),
  ?BT_LOG(io_lib:format("handle_player_logout(), PlayerId=~p~n", [PlayerId])),

  % State = get_battle_state(),
  case get_bo_by_player_id(PlayerId) of
    null ->
      ?ASSERT(false, PlayerId),
      skip;
    Bo ->
      ?ASSERT(is_player(Bo), Bo),
      Side = lib_bo:get_side(Bo),
      BoId = lib_bo:get_id(Bo),
      % % 并且设置为自动战斗 -- 按目前策划的需求，不设置为自动战斗，故注释掉代码 -- huangjf 2013.12.17
      lib_bo:set_auto_battle(BoId, true),

      % case are_all_player_offline_or_just_back_to_battle_except(Bo, Side) of
      % 	true ->  % 所有玩家都下线了，则战斗立即结束
      % 		?BT_LOG(io_lib:format("[mod_battle] handle_player_logout(), all players are offline or just back to battle, so schedule_battle_finish!~n", [])),
      % 		set_win_side( to_enemy_side(Side)),
      % 		mark_battle_finish(),
      % 		schedule_battle_finish();
      % 	false ->
      % 通知其他玩家：xxx下线了
      lib_bt_send:notify_bo_online_flag_changed(Bo, offline),
      post_bo_logout(BoId),

      % 处理主宠
      case lib_bo:get_my_main_partner_bo(Bo) of
        null ->
          skip;
        MainPartnerBo ->
          handle_main_partner_logout(MainPartnerBo)
      end
    % end
  end.


handle_main_partner_logout(Bo) ->
  ?ASSERT(lib_bt_comm:is_main_partner(Bo), Bo),

  BoId = lib_bo:get_id(Bo),
  %%lib_bo:set_online(BoId, false),

  post_bo_logout(BoId).


post_bo_logout(BoId) ->
  Bo = get_bo_by_id(BoId),
  ?ASSERT(Bo /= null, BoId),
  ?ASSERT(is_player(Bo) orelse lib_bt_comm:is_main_partner(Bo), Bo),

  % case is_player(Bo) of
  % 	true ->
  % 		State = get_battle_state(),
  % 	    case lib_bt_comm:is_PVP_battle(State) of
  % 	    	true ->
  % 	    		case lib_bt_comm:is_qiecuo_pk_battle(State) orelse lib_bt_comm:is_1v1_online_arena_battle(State) orelse lib_bt_comm:is_3v3_online_arena_battle(State) of
  % 	    			true  ->
  % 	    				% 如果是PVP强行退出要受到惩罚
  % 		    			lib_player_ext:try_update_data(lib_bo:get_parent_obj_id(Bo),pvp_flee,1);
  % 		    		false ->
  % 		    			skip
  % 	    		end;
  % 		    false ->
  % 		    	skip
  % 	    end;
  % 	_ ->
  % 		skip
  % end,

  ?BT_LOG(io_lib:format("post_bo_logout(), is_server_waiting_clients(for_show_br_done):~p, is_server_waiting_clients(for_prepare_cmd_done):~p, Bo:~w~n",
    [is_server_waiting_clients(for_show_br_done), is_server_waiting_clients(for_prepare_cmd_done), Bo])),

  % 服务端根据具体情况做一些必要的模拟操作，以避免玩家下线后战斗流程被卡住
  % TODO: 为避免因bug而导致战斗流程卡住，仔细思考： 是否疏漏考虑了什么细节？！！
  case is_server_waiting_clients(for_show_br_done) of
    true ->
      case is_player(Bo) of
        true ->
          ?BT_LOG(io_lib:format("post_bo_logout(), simu_c2s_notify_show_battle_report_done... Bo:~w~n", [Bo])),
          simu_c2s_notify_show_battle_report_done(BoId);
        false ->
          skip
      end;
    false ->
      % case is_server_waiting_clients(for_prepare_cmd_done) of
      % 	true ->
      % 		% case lib_bo:get_cur_bhv(Bo) of
      % 		% 	_Any ->
      % 				% TODO: 构思完善，确认这里的处理是否正确---- 目前只是简单处理，是否漏掉了什么情况？？
      % 				case lib_bo:is_ready(Bo) of
      % 					true ->
      %                            skip;
      % 					false ->
      %                            ?BT_LOG(io_lib:format("post_bo_logout(), simu_prepare_cmd_normal_att... Bo=~w~n", [Bo])),
      % 						simu_prepare_cmd_normal_att(BoId)
      % 				end;
      % 		% end;
      % 	false ->
      % 		skip
      % end

      skip
  end,

  case is_server_waiting_clients(for_prepare_cmd_done) of %%lib_bo:is_ready(Bo) of
    false ->
      skip;
    true ->
      ?BT_LOG(io_lib:format("post_bo_logout(), simu_prepare_cmd_normal_att... Bo=~w~n", [Bo])),
      simu_prepare_cmd_normal_att(BoId)
  end,

  % 最后标记为非在线
  lib_bo:set_online(BoId, false).


%% 死亡后重连战斗是否会卡主流程？？  -- 目前觉得不会！
handle_player_try_go_back_to_battle(PS) ->
  ?BT_LOG(io_lib:format("handle_player_try_go_back_to_battle(), PlayerId:~p~n", [player:id(PS)])),
  case is_battle_finish() of
    true ->
      ply_battle:on_try_go_back_to_battle_failed(PS),
      skip;
    false ->
      PlayerId = player:id(PS),
      case get_bo_by_player_id(PlayerId) of
        null ->
          ?ASSERT(false, PlayerId),
          ply_battle:on_try_go_back_to_battle_failed(PS),
          skip;
        Bo ->
          ply_battle:notify_cli_try_go_back_to_battle_result(PS, ?RES_OK),

          % 标记自己不是逃兵
          % lib_player_ext:try_update_data(PlayerId,pvp_flee,0),

          BoId = lib_bo:get_id(Bo),
          lib_bo:set_online(BoId, true),
          lib_bo:set_sendpid(BoId, player:get_sendpid(PS)),
          lib_bo:mark_just_back_to_battle(BoId),

          % 标记为战斗中，勿忘！
          player:mark_battling(PS, lib_bt_comm:get_battle_id()),

          % lib_bo:mark_show_battle_report_done(BoId),  % 为了不卡住战斗流程！
          % lib_bo:mark_cmd_not_prepared(BoId),

          case lib_bo:get_my_main_partner_bo(Bo) of
            null ->
              skip;
            MainPartnerBo ->
              % 标记主宠为在线
              ?BT_LOG(io_lib:format("handle_player_try_go_back_to_battle(), PlayerId:~p, MainPartnerBo=~w~n", [PlayerId, MainPartnerBo])),
              lib_bo:set_online( ?BOID(MainPartnerBo), true),
              lib_bo:mark_just_back_to_battle(?BOID(MainPartnerBo))
          end,

          % 通知其他玩家：我上线了
          lib_bt_send:notify_bo_online_flag_changed(Bo, online),

          % 容错，避免卡战斗
          case is_server_waiting_clients(for_prepare_cmd_done) of
            true ->
              ?DEBUG_MSG("[mod_battle] handle_player_try_go_back_to_battle(), waiting clients for prepare cmd done!! Bo:~w, BattleState:~w", [Bo, get_battle_state()]),
              simu_prepare_cmd_normal_att(BoId);
            false ->
              skip
          end
      end
  end.


handle_query_battle_start_time(PS) ->
  PlayerId = player:id(PS),
  case get_bo_by_player_id(PlayerId) of
    null ->
      ?ASSERT(false, PlayerId),
      lib_bt_send:resp_query_battle_start_time_fail(PS);
    Bo ->
      BtlState = get_battle_state(),
      lib_bt_send:resp_query_battle_start_time_ok(Bo, BtlState#btl_state.start_time)
  end.



%% 模拟使用普通攻击
simu_prepare_cmd_normal_att(BoId) ->
  self() ! {'simu_prepare_cmd_normal_att', BoId}.


simu_c2s_notify_show_battle_report_done(BoId) ->
  self() ! {'simu_c2s_notify_show_battle_report_done', BoId}.








%% 检查左方或右方的玩家是否全部离线或刚回归战斗（排除掉指定的Bo）
%% @return: true => 是， false => 否
are_all_player_offline_or_just_back_to_battle_except(Bo, Side) ->
  ?ASSERT(Side == ?HOST_SIDE orelse Side == ?GUEST_SIDE, Side),

  L = get_player_bo_id_list(Side),
  L2 = L -- [lib_bo:get_id(Bo)],

  % [dummy || X <- L2, is_online(get_bo_by_id(X))] == [].


  F = fun(BoId__) ->
    Bo__ = get_bo_by_id(BoId__),
    lib_bt_comm:is_offline(Bo__) orelse lib_bo:is_just_back_to_battle(Bo__)
      end,

  length( [dummy || X <- L2,  F(X)] ) == length(L2).










handle_c2s_notify_show_battle_report_done(Bo) ->
  lib_bo:mark_show_battle_report_done( ?BOID(Bo)),

  % 通知给其他bo
  lib_bt_send:notify_bo_show_battle_report_done(Bo),

  case are_all_show_battle_report_done() of
    true ->
      ?BT_LOG(io_lib:format("handle_c2s_notify_show_battle_report_done(), all show battle br done , so schedule_new_round_begin, BoId=~p...~n", [?BOID(Bo)])),
      % ?DEBUG_MSG("handle_c2s_notify_show_battle_report_done() and schedule_new_round_begin... cur_round:~p, battle_id:~p", [lib_bt_comm:get_cur_round(), lib_bt_comm:get_battle_id()]),
      schedule_new_round_begin();
    false ->
      skip
  end.


% 在线对离线战斗，客队（即离线方）属性加成
o2o_battle_guest_attribute_add(O2O_BT_TypeCode) ->
  F = fun(BoId) ->
    Bo = lib_bt_comm:get_bo_by_id(BoId),
    ?ASSERT(Bo /= null, BoId),
    NewAttrs = lib_bt_calc:calc_o2o_battle_guest_attribute_add(Bo#battle_obj.attrs, O2O_BT_TypeCode),
    %?TRACE("init_offline_arena_battle_guest_attribute ~p:~n ~p~n~p~n~n",
    %    [Bo, util:record_to_proplist(Bo#battle_obj.attrs, record_info(fields, attrs)), util:record_to_proplist(NewAttrs, record_info(fields, attrs))]),
    Bo2 = Bo#battle_obj{attrs = NewAttrs},
    lib_bt_comm:update_bo(Bo2)
      end,
  [F(Id) || Id <- lib_bt_comm:get_bo_id_list(?GUEST_SIDE)].
