%%%-----------------------------------
%%% @Author  : lds
%%% @Email   : 
%%% @Created : 2013.11
%%% @Description: 事件
%%%-----------------------------------
-ifndef (EVENT_HRL).
-define(EVENT_HRL, event_hrl).

-define(NIL, nil).      %%不存在的事件

-define(KILL_SUCCESS, kill).
-define(KILL_FAIL, kill_fail).
-define(BUY, buy).
-define(GO, go).
-define(TASK_CAN_ACCEPT_EVENT, task_can_accept).
-define(TASK_ACCEPTED_EVENT, task_accepted).
-define(TASK_COMPLETED_EVENT, task_completed).
-define(TASK_SUBMIT_EVENT, task_submit).
-define(TASK_FAIL_EVENT, task_fail). 
-define(TASK_ABANDON_EVENT, task_abandon).
-define(HAVE_BAG_ITEM, bag_item).
-define(TAKE_PET, take_pet).
-define(HAVE_MONEY, money).
-define(IN_DUNGEON, in_dungeon).
-define(IN_SCENE, in_scene).
-define(IN_POSITION, in_position).
-define(BATTLE_WIN, battle_win).
-define(BATTLE_WIN_GROUP, battle_win_group).
-define(BATTLE_FAIL, battle_fail).
-define(BATTLE_FAIL_GROUP, battle_fail_group).
-define(PLOT_FINISH, plot_finish).
-define(DUN_TIME_OUT, dun_time_out).
-define(GET_ASSIGN_REWARD, get_assign_reward).
-define(DUN_TIMER_TIMEOUT, timer_timeout).
-define(DUN_POINTS_THRESHOLD, dun_points_threshold).
-define(DUN_MAX_FLOOR, dun_max_floor).
-define(DUN_NOT_MAX_FLOOR, dun_not_max_floor).
-define(DUNGEON_BOSS_KILLED, dungeon_boss_killed).
-define(RAND_BATTLE_WIN, rand_battle_win).
-define(RAND_BATTLE_WIN_GROUP, rand_battle_win_group).

-define(RESUME_HP_MP, resume_hp_mp).
-define(OPEN_PANEL, open_panel).
-define(ADD_BUFF, add_buff).
-define(DEL_BUFF, del_buff).
-define(CONVEY_OUT_DUN, convey_out_dun).
-define(RIDE_DOWN, ride_down).
-define(TRIGGER_BATTLE, trigger_battle).
-define(CONVEY_SCENE, convey_scene).
-define(CONVEY_DUNGEON, convey_dungeon).
-define(PLOT_START,plot_start).
-define(OPEN_TIPS, open_tips). 
-define(CLOSE_TIPS, close_tips).
-define(ADD_TASK, add_task).
-define(FORCE_ADD_TASK, force_add_task).
-define(PUSH_ID, push_id).
-define(POP_ID, pop_id).
-define(ADD_NPC, add_npc).
-define(DEL_NPC, del_npc).
-define(CREATE_MAP, create_map).
-define(CLOSE_DUN, close_dun).
-define(ADD_BLOCK, add_block).
-define(DEL_BLOCK, del_block).
-define(ADD_SCENE_ITEM, add_scene_item).
-define(DEL_SCENE_ITEM, del_scene_item).
-define(ADD_CONVEY, add_convey).
-define(DEL_CONVEY, del_convey).
-define(ADD_SEEMON, add_seemon).
-define(DEL_SEEMON, del_seemon).
-define(SET_DUNGEON_PASS, set_dungeon_pass).
-define(SET_DUNGEON_PASS_2, set_dungeon_pass_2).
-define(SET_FLOOR_PASS, set_floor_pass).
-define(NEXT_FLOOR, next_floor).
-define(CREATE_TOWER_MAP, create_tower_map).
-define(RECLAIM_MAP, reclaim_map).
-define(TOWER_TOP, tower_top).
-define(CLIENT_BATTLE_END, client_battle_end).
-define(KILL_TRAP, kill_dark).
-define(BATTLE_ESCAPE, battle_escape).
-define(ADD_RAND_SEEMON, add_rand_seemon).

-define(PASS_TOWER, pass_tower).

-define(ADD_DUN_TIMER, add_timer).
-define(REFRESH_DUN_SCRIPT, refresh_script).
-define(CLEAR_DUN_POINTS, clear_dun_points).
-define(CHECK_DUN_MAX_FLOOR, check_max_floor).
-define(DUN_NOTIFY_GUILD_FLOOR, dun_notify_guild_floor).
-define(DUN_NOTIFY_GUILD_FAIL, dun_notify_guild_fail).
-define(CLEAR_ALL_MON, clear_all_mon).
-define(CLEAR_ALL_DYNAMIC_NPC, clear_all_dynamic_npc).
-define(ADD_DUNGEON_BOSS, add_dungeon_boss).

-endif.