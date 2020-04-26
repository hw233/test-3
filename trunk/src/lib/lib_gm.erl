%%%--------------------------------------
%%% @Module: lib_gm
%%% @Author: huangjf
%%% @Created: 2011-12-13
%%% @Description: gm指令
%%%--------------------------------------
-module(lib_gm).

-export([
    handle_chat_msg_as_gm_cmd/2,
    change_os_time/3
  ]).


-include("common.hrl").
-include("record.hrl").
-include("player.hrl").
% -include("arena.hrl").
-include("guild.hrl").
-include("goods.hrl").
% -include("battle_record.hrl").
-include("abbreviate.hrl").
-include("attribute.hrl").
-include("scene.hrl").
% -include("gs_stati.hrl").
-include("skill.hrl").
-include("log.hrl").
-include("dungeon.hrl").
-include("record/guild_record.hrl").
-include("task.hrl").
-include("dungeon.hrl").
-include("pt_12.hrl").
-include("pt.hrl").
-include("obj_info_code.hrl").
-include("pt_40.hrl").
-include("road.hrl").
-include("activity.hrl").
-include("partner.hrl").

%% 把世界聊天信息当成gm指令
handle_chat_msg_as_gm_cmd(PS, Msg) when is_binary(Msg) ->
    {ChatMsg, _} = pt:read_string(Msg),
    handle_chat_msg_as_gm_cmd(PS, string:tokens(ChatMsg, "\n"));
handle_chat_msg_as_gm_cmd(_PS, []) -> ok;
handle_chat_msg_as_gm_cmd(PS, [ChatMsg0|T]) ->
    ChatMsg = string:tokens(ChatMsg0, " "),
    F = fun(CM)->  % 将字符串解码、解码失败的保持原样。特别备注——中文名和英语名可能会有不同的结果
                Reply = util:string_to_term(CM),
                if CM == "undefined" ->
                       undefined;
                   Reply =/= undefined ->
                       Reply;
                   true ->
                       CM
                end
        end,
    ChatMsg1 = [F(CM) || CM <- ChatMsg],
    ?LDS_TRACE(handle_chat_msg_as_gm_cmd, ChatMsg1),

    ?DEBUG_MSG("ChatMsg1 = ~p",[ChatMsg1]),
    Ret = 
    case ChatMsg1 of
        ["@add_exp", ExpToAdd] -> handle_gm_cmd(add_exp, PS, ExpToAdd), ok;
        ["@cost_exp", ExpToCost] -> handle_gm_cmd(cost_exp, PS, ExpToCost), ok;
        ["@set_yuanbao", NewValue] -> handle_gm_cmd(set_yuanbao, PS, NewValue), ok;
        ["@set_rein", NewValue] -> handle_gm_cmd(set_rein, PS, NewValue), ok;
        ["@set_chip", NewValue] -> handle_gm_cmd(set_chip, PS, NewValue), ok;
        ["@set_gamemoney", NewValue] -> handle_gm_cmd(set_gamemoney, PS, NewValue), ok;
        ["@set_integral", NewValue] -> handle_gm_cmd(set_integral, PS, NewValue), ok;
        ["@set_copper", NewValue] -> handle_gm_cmd(set_copper, PS, NewValue), ok;
        ["@set_xiayizhi", NewValue] -> handle_gm_cmd(set_xiayizhi, PS, NewValue), ok;
        ["@set_huoli", NewValue] -> handle_gm_cmd(set_vitality, PS, NewValue), ok;
        ["@set_bind_yuanbao", NewValue] -> handle_gm_cmd(set_bind_yuanbao, PS, NewValue), ok;
        ["@set_bind_gamemoney", NewValue] -> handle_gm_cmd(set_bind_gamemoney, PS, NewValue), ok;
        ["@cost_bind_gamemoney", Value] -> handle_gm_cmd(cost_bind_gamemoney, PS, Value), ok;
        ["@cost_bind_yuanbao", Value] -> handle_gm_cmd(cost_bind_yuanbao, PS, Value), ok;
		["@cost_integral", Value] -> handle_gm_cmd(cost_integral, PS, Value), ok;

        ["@upgrade"] -> handle_gm_cmd(upgrade, PS, dummy), ok;
        % ["@set_lv", NewLv] -> handle_gm_cmd(set_lv, PS, NewLv);
        ["@set_hp", NewHp] -> handle_gm_cmd(set_hp, PS, NewHp), ok;
        ["@set_mp", NewMp] -> handle_gm_cmd(set_mp, PS, NewMp), ok;
        ["@add_goods", GoodsNo] -> handle_gm_cmd(add_goods, PS, {GoodsNo, 1}), ok;
        ["@add_goods", GoodsNo, Count] -> handle_gm_cmd(add_goods, PS, {GoodsNo, Count}), ok;
        ["@add_goods", GoodsNo, Count, Quality] -> handle_gm_cmd(add_goods, PS, {GoodsNo, Count, Quality}), ok;
        ["@add_bind_goods", GoodsNo, Count, BindState] -> handle_gm_cmd(add_bind_goods, PS, {GoodsNo, Count, BindState}), ok;
        ["@trigger_mf", BMonGroupNo] -> handle_gm_cmd(trigger_mf, PS, BMonGroupNo), ok;
        ["@task_pass", TaskId] -> handle_gm_cmd(task_pass, PS, TaskId), ok;
        ["@task_pass"] -> handle_gm_cmd(task_pass, PS, []), ok;
        ["@task_pass", Start, End] -> handle_gm_cmd(task_pass, PS, [Start, End]), ok;
        ["@set_task", TaskId, State] -> handle_gm_cmd(set_task, PS, [TaskId, State]), ok;
        ["@task", TaskId] -> handle_gm_cmd(task, PS, [TaskId]), ok;
        ["@del_goods", GoodsNo, Count] -> handle_gm_cmd(del_goods, PS, {GoodsNo, Count}), ok;

        ["@join_faction", Faction] -> handle_gm_cmd(join_faction, PS, Faction), ok;
        ["@change_faction", Faction] -> handle_gm_cmd(change_faction, PS, Faction), ok;
        ["@clear_bag"] ->   handle_gm_cmd(clear_bag, PS, dummy), ok;
        ["@add_intimacy", Intimacy] -> handle_gm_cmd(add_intimacy, PS, Intimacy), ok;
        ["@add_skill", SkillNo] -> TmpSkill = PS#player_status.tmp_skill,
            NewTmpSkill = sets:to_list(sets:from_list([SkillNo|TmpSkill])),
            player_syn:update_PS_to_ets(PS#player_status{tmp_skill = NewTmpSkill}), ok;
        ["@del_skill", SkillNo] -> TmpSkill = PS#player_status.tmp_skill,
            NewTmpSkill = TmpSkill -- [SkillNo],
            player_syn:update_PS_to_ets(PS#player_status{tmp_skill = NewTmpSkill}), ok;
        % 设置天赋
        ["@set_str", NewVal] -> handle_gm_cmd(set_str, PS, NewVal), ok;  % 设置力量
        ["@set_con", NewVal] -> handle_gm_cmd(set_con, PS, NewVal), ok;  % 设置体质
        ["@set_stam", NewVal] -> handle_gm_cmd(set_stam, PS, NewVal), ok;  % 设置耐力
        ["@set_spi", NewVal] -> handle_gm_cmd(set_spi, PS, NewVal), ok;  % 设置灵力
        ["@set_agi", NewVal] -> handle_gm_cmd(set_agi, PS, NewVal), ok;  % 设置敏捷

        ["@idle"] -> handle_gm_cmd(set_idle, PS, dummy), ok;  % 设置为空闲状态
        ["@busy"] -> handle_gm_cmd(set_busy, PS, dummy), ok;  % 设置为忙状态

        % 战斗系统相, ok;
        ["@force_win_battle"] -> handle_gm_cmd(force_win_battle, PS, dummy), ok;
        ["@force_lose_battle"] -> handle_gm_cmd(force_lose_battle, PS, dummy), ok;
        ["@loop_win_mf", BMonGroupNo, Times] -> handle_gm_cmd(loop_win_mf, PS, [BMonGroupNo, Times]), ok;
        ["@bt_set_phy_att", Val] -> handle_gm_cmd(bt_set_phy_att, PS, Val), ok;
        ["@bt_set_phy_def", Val] -> handle_gm_cmd(bt_set_phy_def, PS, Val), ok;
        ["@bt_set_mag_att", Val] -> handle_gm_cmd(bt_set_mag_att, PS, Val), ok;
        ["@bt_set_mag_def", Val] -> handle_gm_cmd(bt_set_mag_def, PS, Val), ok;
        ["@bt_set_act_speed", Val] -> handle_gm_cmd(bt_set_act_speed, PS, Val), ok;
        ["@bt_set_do_fix_dam", FixDamVal] -> handle_gm_cmd(bt_set_do_fix_dam, PS, FixDamVal), ok;
        ["@bt_normalize_dam"] -> handle_gm_cmd(bt_normalize_dam, PS, dummy), ok;
        ["@bt_set_mp", Val] -> handle_gm_cmd(bt_set_mp, PS, Val), ok;
        ["@bt_get_buff_info", Val] -> handle_gm_cmd(bt_get_buff_info, PS, Val), ok;
        ["@fast_kill_mon"] -> handle_gm_cmd(bt_fast_kill_mon, PS, dummy), ok;

        ["@add_partner", PartnerNo] -> handle_gm_cmd(add_partner, PS, PartnerNo), ok;

        % 刷出对象（明雷怪/动态npc/动态传送点）到场景、从场景清除对象
        ["@spawn_mon", MonNo, SceneId, X, Y] -> handle_gm_cmd(spawn_mon, PS, {MonNo, SceneId, X, Y}), ok;
        ["@clear_mon", MonId] -> handle_gm_cmd(clear_mon, PS, MonId), ok;
        ["@spawn_dynamic_npc", NpcNo, SceneId, X, Y] -> handle_gm_cmd(spawn_dynamic_npc, PS, {NpcNo, SceneId, X, Y}), ok;
        ["@clear_dynamic_npc", NpcId] -> handle_gm_cmd(clear_dynamic_npc, PS, NpcId), ok;
        ["@spawn_dynamic_teleporter", TeleportNo, SceneId, X, Y] -> handle_gm_cmd(spawn_dynamic_teleporter, PS, {TeleportNo, SceneId, X, Y}), ok;
        ["@clear_dynamic_teleporter", TeleportNo, SceneId, X, Y] -> handle_gm_cmd(clear_dynamic_teleporter, PS, {TeleportNo, SceneId, X, Y}), ok;

        ["@add_par_exp", ParExp] -> handle_gm_cmd(add_par_exp, PS, ParExp), ok;
        ["@add_par_hp", Value] -> handle_gm_cmd(add_par_hp, PS, Value), ok;
        ["@add_evolve", Value] -> handle_gm_cmd(add_evolve, PS, Value), ok;
        ["@dungeon", DunNo] -> pp_dungeon:handle(57001, PS, [DunNo]), ok;
        ["@tower", Floor] -> lib_tower:gm_enter_tower(Floor, player:id(PS)), ok;
        ["@hardtower",TowerNo, Floor] -> lib_tower:gm_enter_tower(TowerNo, Floor, player:id(PS)), ok;
        ["@reset_tower"] -> lib_tower:reset_tower_rd(PS), ok;
        ["@reset_hardtower"] -> lib_hardtower:reset_tower_rd(PS), ok;
        ["@reset_answer"] -> handle_gm_cmd(reset_answer, PS, dummy), ok;
        ["@goto", SceneId, X, Y] -> handle_gm_cmd(goto, PS, {SceneId, X, Y}), ok;
        ["@goto", X, Y] -> handle_gm_cmd(goto, PS, {X, Y}), ok;
        ["@get_reward", RewardNo] -> handle_gm_cmd(get_reward, PS, RewardNo), ok;
        ["@get_reward", RewardNo,Count] -> handle_gm_cmd(get_reward, PS, {RewardNo,Count}), ok;
        ["@set_loyalty", Loyalty] -> handle_gm_cmd(set_loyalty, PS, Loyalty), ok;
        ["@add_par_skill", SkillId] -> handle_gm_cmd(add_par_skill, PS, SkillId), ok;
        ["@lv", Lv] -> handle_gm_cmd(lv, PS, Lv), ok;
        ["@set_lv", Lv] -> handle_gm_cmd(set_lv, PS, Lv), ok;
        ["@sys_mail", Content, ItemList] -> handle_gm_cmd(send_mail, PS, [Content, ItemList]), ok;
        ["@del_par_skill", SkillId] -> handle_gm_cmd(del_par_skill, PS, SkillId), ok;
        ["@del_par_skill"] -> handle_gm_cmd(del_par_skill, PS, dummy), ok;
        ["@add_feat", Num] -> player:add_feat(PS, Num), ok;
        ["@add_ad", Sys, Num] -> lib_activity_degree:publ_add_sys_activity_times(Sys, Num, PS), ok;
        ["@send_broadcast", Content] -> handle_gm_cmd(send_broadcast, PS, [Content]), ok;
		["@tower_times"] ->  pp_dungeon:handle(57009, PS, [100]), ok;
        ["@mail", Num] -> handle_gm_cmd(send_mail, PS, [Num]), ok;
        ["@position"] -> handle_gm_cmd(get_position, PS, []), ok;
        ["@sign_in", Day] -> handle_gm_cmd(sign_in, PS, [Day]), ok;
        ["@add_prosper", Prosper] -> handle_gm_cmd(add_prosper, PS, [Prosper]), ok;
        ["@sys_broadcast", No, ParaList] -> handle_gm_cmd(sys_broadcast, PS, [No, ParaList]), ok;

        ["@set_time", Hour, Min, Sec] -> handle_gm_cmd(set_time, PS, {Hour, Min, Sec}), ok;  % 设置当前时间
        ["@set_date", Year, Month, Day] -> handle_gm_cmd(set_date, PS, {Year, Month, Day}), ok;  % 设置当前日期
        ["@get_time"] -> handle_gm_cmd(get_time, PS, dummy), ok;  % 获取当前时间
        ["@get_date"] -> handle_gm_cmd(get_date, PS, dummy), ok;  % 获取当前日期
        ["@normalize_time"] -> handle_gm_cmd(normalize_time, PS, dummy), ok; % 使日期和时间回归正常

        ["@get_online_num"] -> handle_gm_cmd(get_online_num, PS, dummy), ok;  % 获取当前的在线人数
        ["@add_liveness", Liveness] -> handle_gm_cmd(add_liveness, PS, [Liveness]), ok; % 设置帮派活跃度
        ["@add_guild_con", GuildCon] -> handle_gm_cmd(add_guild_con, PS, [GuildCon]), ok; % 增加帮派贡献度
        ["@task_1", TaskId] -> pp_task:handle(30003, PS, [TaskId]), ok;
        ["@task_submit_all"] -> handle_gm_cmd(task_submit_all, PS, []), ok; % 提交所有已完成任务

        ["@rank_all"] -> handle_gm_cmd(rank_all, PS, []), ok;
        ["@rank_title"] -> handle_gm_cmd(rank_title, PS, []), ok;
        ["@msgq_test"] -> handle_gm_cmd(msgq_test, PS, []), ok;
        ["@dead_loop_test"] -> handle_gm_cmd(dead_loop_test, PS, []), ok;
        ["@reds_test"] -> handle_gm_cmd(reds_test, PS, []), ok;
        ["@kill_bdist_test"] -> handle_gm_cmd(kill_bdist_test, PS, []), ok;
        ["@offaw"] -> handle_gm_cmd(offaw, PS, []), ok;
        ["@reward_pool", No] -> handle_gm_cmd(reward_pool, PS, [No]), ok;
        ["@dig", No] -> handle_gm_cmd(dig, PS, [No]), ok;
        ["@dig", No, GoodsNo] -> handle_gm_cmd(dig, PS, [No, GoodsNo]), ok;
        ["@p"] -> handle_gm_cmd(p, PS, []), ok;
        ["@p", Item] -> handle_gm_cmd(p, PS, [Item]), ok;
        ["@e", Table] -> handle_gm_cmd(e, PS, [Table]), ok;
        ["@pass_achi", No, Num] -> handle_gm_cmd(pass_achi, PS, [No, Num]), ok;

        ["@prompt", Code] -> handle_gm_cmd(prompt, PS, [Code]), ok;
        ["@vip_exp", Exp] -> handle_gm_cmd(vip_exp, PS, [Exp]), ok;
        ["@daily_reset"] -> handle_gm_cmd(daily_reset, PS, []), ok;
        ["@no_reset"] -> handle_gm_cmd(no_reset, PS, []), ok;


        ["@open_all_sys"] -> handle_gm_cmd(open_all_sys, PS, dummy), ok;
        ["@create_guild_dun"] -> handle_gm_cmd(create_guild_dun, PS, dummy), ok;
        ["@guild_party_begin", Interval] -> handle_gm_cmd(guild_party_begin, PS, [Interval]), ok;
        ["@guild_party_end"] -> handle_gm_cmd(guild_party_end, PS, []), ok;
        ["@add_literary", Num] -> player:add_literary(PS, Num, []), ok;
        ["@recharge", Num] -> handle_gm_cmd(recharge, PS, [Num]), mod_achievement:notify_achi(involve_recharge, [], PS), sm_admin:rebate_function(player:get_id(PS), Num), ok;
        ["@guild_lv", Lv] -> handle_gm_cmd(guild_lv, PS, Lv), ok;
        ["@del_prosper", Prosper] -> handle_gm_cmd(del_prosper, PS, [Prosper]), ok;
		["@close_molong"] -> gen_server:cast(dungeon_manage, {'dungeon_close',1000 , ?BOSS_DUNGEON_NO_MOLONG}), ok;
		["@close_yijie"] -> gen_server:cast(dungeon_manage, {'dungeon_close',1000 , ?BOSS_DUNGEON_NO_YIJUN}), ok;
        ["@open_molong"] -> gen_server:cast(dungeon_manage, {'create_boss_dungeon', ?BOSS_DUNGEON_NO_MOLONG, util:unixtime()}), ok;
        ["@open_yijie"] -> gen_server:cast(dungeon_manage, {'create_boss_dungeon', ?BOSS_DUNGEON_NO_YIJUN, util:unixtime()}), ok;
        ["@poke_boss", No] -> handle_gm_cmd(poke_boss, PS, [No]), ok;
        ["@dun_info"] -> handle_gm_cmd(dun_info, PS, []), ok;
        ["close_dun", No] -> gen_server:cast(dungeon_manage, {'publ_close_dungeon', No}), ok;
        ["@achi"] -> ?LDS_DEBUG(mod_achievement:get_achievement(player:id(PS))), ok;
        ["@reset_luck", Type] -> handle_gm_cmd(reset_luck, PS, [Type]), ok;
        ["@chapter_no", No] -> handle_gm_cmd(chapter_no, PS, [No]), ok;

        ["@chapter_no", StartNo,EndNo] -> handle_gm_cmd(chapter_no, PS, [StartNo,EndNo]), ok;

        ["@open_cruise"] -> handle_gm_cmd(open_cruise, PS, dummy), ok;
        ["@dun_point", Point] -> handle_gm_cmd(dun_point, PS, [Point]), ok;
        ["@guild_dun"] -> handle_gm_cmd(guild_dun, PS, dummy), ok;
        ["@guild_job"] -> handle_gm_cmd(guild_job, PS, dummy), ok;

        ["@guild_battle_start"] -> handle_gm_cmd(guild_battle_start, PS, dummy), ok;
        ["@guild_battle_open"] -> handle_gm_cmd(guild_battle_open, PS, dummy), ok;
        ["@guild_battle_end"] -> handle_gm_cmd(guild_battle_end, PS, dummy), ok;
        ["@guild_battle_end1"] -> handle_gm_cmd(guild_battle_end1, PS, dummy), ok;

        ["@g1"] -> handle_gm_cmd(guild_battle_start, PS, dummy), ok;
        ["@g2"] -> handle_gm_cmd(guild_battle_open, PS, dummy), ok;
        ["@g3"] -> handle_gm_cmd(guild_battle_end, PS, dummy), ok;
        ["@g4"] -> handle_gm_cmd(guild_battle_end1, PS, dummy), ok;

        ["@add_title", Title] -> handle_gm_cmd(add_title, PS, Title), ok;
        ["@add_utitle", ID, Text] -> handle_gm_cmd(add_utitle, PS, [ID, Text]), ok;
        ["@span_tower", Floor] -> pp_tower:handle(49003, PS, [Floor, 1]), ok;
        ["@span_hardtower", Floor] -> pp_hardtower:handle(49003, PS, [Floor, 1]), ok;
        ["@add_truck"] -> pp_transport:handle(42006, PS, []), ok;
        ["@set_priv", PrivLv] ->handle_gm_cmd (set_priv, PS, PrivLv), ok;
        ["@cmd", Cmd, Args] -> gen_server:cast(player:get_pid(PS), {apply_cast, tst_test:module(Cmd), handle, [Cmd, PS, Args]}), ok;
        [cmd, Cmd, Args] -> 
            io:format("********** lib_gm [cmd ~p ~p] **********~n", [Cmd, Args]),
            gen_server:cast(player:get_pid(PS), {"TEST_CMD", Cmd, Args}), ok;        

        ["@time", Year, Mon, Day, Hour, Min, Sec] -> change_os_time(Year, Mon, Day, Hour, Min, Sec), ok;
        ["@time", Year, Mon, Day] -> change_os_time(Year, Mon, Day), ok;
        ["@showtime"] -> handle_gm_cmd(showtime, PS, []), ok;

        ["@guild_war"] -> handle_gm_cmd(guild_war, PS, dummy), ok;
        ["@guild_war_group"] -> handle_gm_cmd(guild_war_group, PS, dummy), ok;
        ["@pre_war_begin"] -> handle_gm_cmd(pre_war_begin, PS, dummy), ok;
        ["@pre_war_end"] -> handle_gm_cmd(pre_war_end, PS, dummy), ok;
        ["@war_begin"] -> handle_gm_cmd(war_begin, PS, dummy), ok;
        ["@war_end"] -> handle_gm_cmd(war_end, PS, dummy), ok;
        ["@guild_war_info"] -> handle_gm_cmd(guild_war_info, PS, dummy) , ok;
        ["@war_dun_info"] -> handle_gm_cmd(war_dun_info, PS, dummy), ok;
        ["@clear_war"] -> handle_gm_cmd(clear_war, PS, dummy), ok;
        ["@bid_war", Money] -> handle_gm_cmd(bid_war, PS, [Money]), ok;
        ["@pass_round"] -> handle_gm_cmd(pass_round, PS, dummy), ok;
        ["@pre_dun"] -> pp_guild:handle(?PM_GUILD_SIGN_IN_FOR_GB, PS, dummy), ok;
        ["@melee_open"] -> sm_cross_server:rpc_cast(lib_melee, melee_open, []), ok; 
%% 				lib_melee:melee_open(), ok;
        ["@melee_close"] -> lib_melee:melee_close(), ok;
        ["@world_lv", Time] -> mod_world_lv:open_world_lv(Time), ok;
        ["@set_tve_cnt", NewValue] -> handle_gm_cmd(set_tve_cnt, PS, NewValue), ok;
        ["@start_snowman", Time] -> mod_global_collection:open_snowman_activity(util:unixtime(), util:unixtime() + Time), ok;
        % ["@end_snowman"] -> mod_global_collection:close_snowman_activity();
        ["@horse_race_open"] -> mod_horse_race:horse_race_open(1,[]), ok;
        ["@horse_race_close"] -> mod_horse_race:horse_race_close(1,[]), ok;
        ["@set_horse_gamble_time", NewValue] -> lib_horse_race:set_horse_gamble_time(PS, NewValue), ok;
        ["@set_attr", Key, NewValue] -> ply_attr:tst_add_attrs(PS, [{Key, NewValue}]), ok;
        ["@newyear_start"] -> 
            lib_newyear_banquet:create_newyear_banquet_scene(),
            mod_newyear_banquet:start(),
            mod_newyear_banquet:newyear_banquet_open(1, 1), ok;
        ["@newyear_end"] ->
            mod_newyear_banquet:newyear_banquet_close(1, 1),
            mod_newyear_banquet:stop(),
            lib_newyear_banquet:close_newyear_banquet_scene(), ok;
        ["@newyear_setexp", NewValue] -> mod_newyear_banquet:set_newyear_banquet_exp(NewValue), ok;
        ["@newyear_set", Key, Value] -> mod_newyear_banquet:set_newyear_banquet_times(PS, Key, Value), ok;
        ["@newyear_reset"] ->
            %重置奖励池
            mod_reward_pool:tst_reset_pool(20004), 
            mod_reward_pool:tst_reset_pool(20005), 
            mod_newyear_banquet:set_newyear_banquet_all_times(), ok;
        % ["@reset_faction_task"] ->
        ["@exe_st", No] -> mod_admin_activity:exec_script_for_act(No), ok;
        ["@reset_act"] -> lib_festival_act:daily_reset(PS), ok;
        ["@set_gived_cnt", Type, Cnt] -> lib_festival_act:tst_set_gived_cnt(PS, Type, Cnt), ok;
        ["@drop_prob_expand", Value] -> lib_drop:tst_set_drop_prob_expand(Value), ok;
        ["@drop_goods", DropPkg] -> lib_drop:tst_send_goods_by_drop_no(PS, DropPkg), ok;
        ["@set_contri", Value] -> player:set_contri(PS, Value), ok;
        ["@set_mk_skill", SkillId] -> mod_equip:tst_add_magic_key_skill(player:id(PS), SkillId), ok;
        ["@add_anger", Value] -> gen_server:cast(player:get_cur_battle_pid(PS), {'dbg_add_anger', PS, Value}), ok;
%%         ["@add_ernie", Value] -> lib_ernie:add_ernie_gm(player:id(PS), Value), ok;
        ["@ernie_open"] -> mod_ernie:ernie_open(1, 1), ok;
        ["@ernie_close"] -> mod_ernie:ernie_close(1, 1), ok;
        ["@clear_arena3v3"] -> mod_arena_3v3:clear_arena_3v3_state(), ok;
        ["@arena_3v3_close"] -> mod_arena_3v3:arena_3v3_close(), ok;
        ["@add_mount", MountNo] -> lib_mount:player_add_mount(PS, MountNo), ok;
        ["@set_mount_feed", Value] -> lib_mount:set_mount_feed_times(PS, Value), ok;
        ["@add_home", Value] -> lib_home:add_degree(PS, Value), ok;
        ["@open_tower"] ->lib_tower:open_tower_system(PS),ok ;
		["@reset_qujing"] ->  R0 = mod_road:get_road_from_ets(player:id(PS)),  R = R0#road_info{reset_times=1},  mod_road:update_road_to_ets(R),    ok;
		["@reset_guild_dungeon"] -> lib_guild_dungeon:refresh_data(),  ok;
		["@collect", Point,Value] -> lib_guild_dungeon:gm_collect_point(PS, Point, Value) ,ok;
		["@kill", Point,Value] -> lib_guild_dungeon:gm_kill_count(PS, Point, Value) , ok;
		["@drop", Point,Value] -> lib_guild_dungeon:gm_drop_count(PS, Point, Value) ,ok;
		["@score", Value] -> sm_cross_server:rpc_call(lib_pvp, set_score, [player:get_id(PS), Value]), ok;
        ["@chess_reset"] -> lib_luck:rich_info_reset(), ok;
        ["@mystery_reset"] -> lib_mystery:reset_gm(player:get_id(PS)), ok;
        ["@mystery_level", NewVal] -> handle_gm_cmd(set_mystery, PS, NewVal), ok;
        ["@mirage_level", NewVal] -> handle_gm_cmd(set_mirage, PS, NewVal), ok;
		["@par_add_skill", ParNo, NewVal] -> handle_gm_cmd(par_add_skill, PS, [ParNo, NewVal]), ok;
        ["@par_del_skill", ParNo, NewVal] -> handle_gm_cmd(par_del_skill, PS, [ParNo, NewVal]), ok;
        ["@role_add_skill", NewVal] -> handle_gm_cmd(role_add_skill, PS, NewVal), ok;
        ["@role_del_skill", NewVal] -> handle_gm_cmd(role_del_skill, PS, NewVal), ok;
		["@exe_script", No] -> mod_activity:exec_script(mod_activity:get_activity_script(No)), ok;
        [Other] ->
            try string:substr(Other,1,1) of
                "@" -> ok;
                _ -> fail
            catch
                _:_ -> fail
            end      
    end,

    Ret.

 % handle_chat_msg_as_gm_cmd(PS, T).


handle_gm_cmd(showtime, Status, []) ->
    {{Y, M, D}, {H, Min, S}} = erlang:localtime(),
    Time = tool:to_binary(io_lib:format("当前服务器时间 ： ~p-~p-~p   ~p:~p:~p~n", [Y, M, D, H, Min, S])),
    Msg = <<(byte_size(Time)):16, Time/binary>>,
    ?LDS_TRACE(Time),
    {ok, BinData} = pt_11:write(11001, [player:id(Status), Msg, 
        lib_chat:get_identify(Status), player:get_name(Status), ply_priv:get_priv_lv(Status),player:get_race(Status),player:get_sex(Status)]),
    access_queue_svr:broadcast(BinData),
    ok;


handle_gm_cmd(recharge, Status, [Num]) ->
     OrderId = db:select_count(recharge_order, []) + 1,
	 player:admin_recharge(player:id(Status), Num, Num, "order_id_" ++ tool:to_list(OrderId), util:unixtime());
%%      player:admin_recharge(player:id(Status), 0, Num, "order_id_" ++ tool:to_list(OrderId), util:unixtime());


handle_gm_cmd(dun_info, Status, []) ->
    case player:is_in_dungeon(Status) of
        {true, Pid} -> gen_server:cast(Pid, 'info');
        _ -> skip
    end;

handle_gm_cmd(poke_boss, Status, [No]) ->
    case player:is_in_dungeon(Status) of
        {true, Pid} ->
            TeamList =
                case player:is_in_team(Status) of
                    true -> mod_team:get_normal_member_id_list(player:get_team_id(Status));
                    false -> [player:id(Status)]
                end,
            Pid ! {'boss_battle_feekback', No, 100, util:rand(0, 100), TeamList, TeamList};
        _ -> skip
    end;


handle_gm_cmd(chapter_no, Status, [No]) ->
    mod_achievement:chapter_gm_to_finish(No,player:get_id(Status));

handle_gm_cmd(reset_luck, Status, [Type]) ->
    lib_luck:refresh_luck(player:get_id(Status), Type);

%% 秘境关卡
handle_gm_cmd(set_mystery, PS, Level) when is_integer(Level), Level > 0 ->
    ?TRACE("handle_gm_cmd(), set_mystery, Level=~p~n", [Level]),
    lib_mystery:set_mystery(player:get_id(PS),Level);

%% 幻境关卡
handle_gm_cmd(set_mirage, PS, Level) when is_integer(Level), Level > 0 ->
    ?TRACE("handle_gm_cmd(), set_mystery, Level=~p~n", [Level]),
    lib_mystery:set_mirage(player:get_id(PS),Level);

handle_gm_cmd(chapter_no, Status, [StartNo,End]) ->
	SeqLists = lists:seq(StartNo, End),
	Fun = fun(X) ->
				  mod_achievement:chapter_gm_to_finish(X,player:get_id(Status))
		  end,
	lists:foreach(Fun, SeqLists);


% 设置成就
handle_gm_cmd(pass_achi, Status, [No, Num]) ->
    case mod_achievement:get_achievement(player:id(Status)) of
        null -> skip;
        List ->
            case lists:keyfind(No, 1, List) of
                false -> skip;
                {No, OriNum, Limit} ->
                    NewList = lists:keyreplace(No, 1, List, {No, OriNum + Num, Limit}),
                    mod_achievement:set_achievement(player:id(Status), NewList)
            end
    end;

% 设置成就
handle_gm_cmd(prompt, PS, [Code]) ->
    lib_send:send_prompt_msg(PS, Code);

% 加VIP经验
handle_gm_cmd(vip_exp, PS, [Exp]) ->
    PS1 = lib_vip:active(PS),
    PS2 = lib_vip:add_exp(Exp, PS1),
    player_syn:update_PS_to_ets(PS2);

% 每日重置
handle_gm_cmd(daily_reset, PS, []) ->
    ply_reset:do_daily_reset(PS,player:get_last_daily_reset_time(PS)),
    put(reset_task,1),
    ?DEBUG_MSG("daily_reset1 ~p~n",[get(reset_task)]),
    ply_reset:gm_reset(player:get_id(PS));

% 取消任务重置
handle_gm_cmd(no_reset, PS, []) ->
    erase(reset_task);


% 提交所有已接任务
handle_gm_cmd(task_submit_all, Status, []) ->
    handle_gm_cmd(task_pass, Status, []),
    List = lib_task:get_accepted_list(),
    [lib_task:force_submit(TaskId, Status) || TaskId <- List];

%% 重置爬塔进入次数
% handle_gm_cmd(tower_times, PS) ->
%     handle(57009, PS, [100001]).

handle_gm_cmd(get_position, Status, []) ->
    Pos = player:get_position(Status),
    SceneId = Pos#plyr_pos.scene_id,
    X = Pos#plyr_pos.x,
    Y = Pos#plyr_pos.y,
    Msg = util:term_to_bitstring({SceneId, {X, Y}}),
    Len = byte_size(Msg),
    {ok, BinData} = pt_11:write(11001, [player:id(Status), <<Len:16, Msg/binary>>,
                                lib_chat:get_identify(Status), player:get_name(Status), ply_priv:get_priv_lv(Status),player:get_race(Status),player:get_sex(Status)]),

    % {ok, BinData} = pt_11:write(11001, [player:id(Status), Msg, 
        

    lib_send:send_to_all(BinData);


handle_gm_cmd(send_mail, Status, [Content, ItemList]) ->
    ?LDS_TRACE("GM_send_mail", [tool:to_list(ItemList)]),
    lib_mail:send_sys_mail(player:id(Status), tool:to_binary(<<"sys">>), tool:to_binary(Content), tool:to_list(ItemList), []);
handle_gm_cmd(send_mail, _Status, [0]) -> ok;
handle_gm_cmd(send_mail, Status, [Num]) ->
    lib_mail:send_mail(player:id(Status), <<"Gm">>, <<"hello">>, 2, [], player:id(Status), player:get_name(Status)),
    handle_gm_cmd(send_mail, Status, [Num - 1]);

%% 升级到指定的等级
handle_gm_cmd(set_lv, Status, Lv) ->
    OldLv = player:get_lv(Status),
    case Lv /= OldLv of
        true ->
            gen_server:cast(Status#player_status.pid, {'gm_set_lv', Lv});
        false ->
            skip
    end;
handle_gm_cmd(lv,Status , Lv0) ->
    Lv = erlang:min(Lv0, player:get_player_max_lv(Status)),
    OldLv = player:get_lv(Status),
    case Lv - OldLv > 0 of
        true ->
            % F1 = fun(TmpLv, Sum) -> Sum + data_exp:get(TmpLv) end,
            % Exp = lists:foldl(F1, 0, lists:seq(OldLv, Lv - 1)),
            % PS2 = Status#player_status{exp = Status#player_status.exp + Exp},
            % player_syn:update_PS_to_ets(PS2),
            % % player:add_exp(Status, Exp),
            % Pid = player:get_pid(Status),
            % F = fun(_) -> timer:sleep(200), gen_server:cast(Pid, 'do_upgrade') end,
            % Gap =
            %     case OldLv < ?MANUAL_UPGRADE_START_LV of
            %         true ->
            %             case OldLv + 1 < Lv of
            %                 true -> lists:seq(OldLv + 2, Lv);
            %                 false -> lists:seq(OldLv + 1, Lv)
            %             end;
            %         false -> lists:seq(OldLv + 1, Lv)
            %     end,
            % spawn(lists, foreach, [F, Gap]);
            % % lists:foreach(F, Gap);

            F = fun(CurLv) ->
                    NeedExp = data_exp:get(CurLv),
                    player:add_exp(Status, NeedExp),

%%                    MaxLv = Lv >= player:get_player_max_lv(Status),
%%                    case MaxLv of
%%                        true ->
%%                            skip;
%%                        false ->
%%                            player:do_upgrade(Status)
%%                    end,
                    timer:sleep(300)
                end,
            L = lists:seq(OldLv, Lv - 1),
            spawn(lists, foreach, [F, L]);
            % [F(X) || X <- L];

        false ->
            skip
    end;

handle_gm_cmd(task, Status, [TaskId]) ->
    case catch data_task:get(TaskId) of
        Task when is_record(Task, task) ->
            case lib_task:publ_is_accepted(TaskId, player:id(Status)) of
                true -> skip;
                false ->
                    lib_task:force_accept(TaskId, Status),
                    % lib_task:refresh_task(TaskId, Status),
                    gen_server:cast( player:get_pid(Status), 'send_trigger_msg_no_compare'),
                    lib_task:send_trigger_msg_no_compare(Status)
            end;
        _ -> skip
    end;

handle_gm_cmd(set_task, Status, [TaskId, State]) ->
    pp_task:handle(30901, Status, [TaskId, State]),
    lib_task:refresh_task(TaskId, Status);


handle_gm_cmd(task_pass, Status, [Start, End]) when Start =< End ->
    List = lists:seq(Start, End),
    ?LDS_TRACE(task_pass, [List]),
    [lib_task:set_finish(Id, Status) || Id <- List, is_integer(Id)],
    gen_server:cast( player:get_pid(Status), 'send_trigger_msg_no_compare'),
    lib_task:send_trigger_msg_no_compare(Status);

%% 直接完成任务

handle_gm_cmd(task_pass, Status, []) ->
    List = lib_task:get_accepted_list(),
    F = fun(TaskId) ->
        lib_task:set_task_state(TaskId, 23),
        lib_task:refresh_task(TaskId, Status)
    end,
    lists:foreach(F, List);
    % [lib_task:set_task_state(TaskId, 23) || TaskId <- List];

handle_gm_cmd(task_pass, Status, TaskId) ->
    lib_task:set_task_state(TaskId, 23),
    lib_task:refresh_task(TaskId, Status);


%% 加经验
handle_gm_cmd(add_exp, PS, ExpToAdd) when is_integer(ExpToAdd), ExpToAdd > 0 ->
    ?TRACE("handle_gm_cmd(), add_exp, ExpToAdd=~p~n", [ExpToAdd]),
    player:add_exp(PS, ExpToAdd, [?LOG_GM]);


%% 扣经验
handle_gm_cmd(cost_exp, PS, ExpToCost) when is_integer(ExpToCost), ExpToCost > 0 ->
    ?TRACE("handle_gm_cmd(), cost_exp, ExpToCost=~p~n", [ExpToCost]),
    player:cost_exp(PS, ExpToCost, [?LOG_GM]);


%% 设置元宝
handle_gm_cmd(set_yuanbao, PS, NewValue) when is_integer(NewValue), NewValue >= 0 ->
    ?TRACE("handle_gm_cmd(), set_yuanbao, NewValue=~p~n", [NewValue]),
    OldValue = player:get_yuanbao(PS),
    if
        OldValue > NewValue ->
            Diff = OldValue - NewValue,
            player:cost_yuanbao(PS, Diff, [?LOG_GM]);
        OldValue < NewValue ->
            Diff = NewValue - OldValue,
            player:add_yuanbao(PS, Diff, [?LOG_GM]);
        true ->
            skip
    end;

%% 设置转生币
handle_gm_cmd(set_rein, PS, NewValue) when is_integer(NewValue), NewValue >= 0 ->
    ?TRACE("handle_gm_cmd(), set_reincarnation, NewValue=~p~n", [NewValue]),
    OldValue = player:get_reincarnation(PS),
    if
        OldValue > NewValue ->
            Diff = OldValue - NewValue,
            player:cost_reincarnation(PS, Diff, [?LOG_GM]);
        OldValue < NewValue ->
            Diff = NewValue - OldValue,
            player:add_reincarnation(PS, Diff, [?LOG_GM]);
        true ->
            skip
    end;

handle_gm_cmd(set_chip, PS, NewValue) when is_integer(NewValue), NewValue >= 0 ->
    ?TRACE("handle_gm_cmd(), set_chip, NewValue=~p~n", [NewValue]),
    OldValue = player:get_chip(PS),
    if
        OldValue > NewValue ->
            Diff = OldValue - NewValue,
            player:cost_chip(PS, Diff, [?LOG_GM]);
        OldValue < NewValue ->
            Diff = NewValue - OldValue,
            player:add_chip(PS, Diff, [?LOG_GM]);
        true ->
            skip
    end;

%% 设置游戏币
handle_gm_cmd(set_gamemoney, PS, NewValue) when is_integer(NewValue), NewValue >= 0 ->
    ?TRACE("handle_gm_cmd(), set_gamemoney, NewValue=~p~n", [NewValue]),
    OldValue = player:get_gamemoney(PS),
    if
        OldValue > NewValue ->
            Diff = OldValue - NewValue,
            player:cost_gamemoney(PS, Diff, [?LOG_GM]);
        OldValue < NewValue ->
            Diff = NewValue - OldValue,
            player:add_gamemoney(PS, Diff, [?LOG_GM]);
        true ->
            skip
    end;

%% 设置积分
handle_gm_cmd(set_integral, PS, NewValue) when is_integer(NewValue), NewValue >= 0 ->
    ?TRACE("handle_gm_cmd(), set_integral, NewValue=~p~n", [NewValue]),
    OldValue = player:get_integral(PS),
    if
        OldValue > NewValue ->
            Diff = OldValue - NewValue,
            player:cost_integral(PS, Diff, [?LOG_GM]);
        OldValue < NewValue ->
            Diff = NewValue - OldValue,
            player:add_integral(PS, Diff, [?LOG_GM]);
        true ->
            skip
    end;

%% 设置游戏币
handle_gm_cmd(set_vitality, PS, NewValue) when is_integer(NewValue), NewValue >= 0 ->
    ?TRACE("handle_gm_cmd(), set_vitality, NewValue=~p~n", [NewValue]),

    ?DEBUG_MSG("handle_gm_cmd(), set_vitality, NewValue=~p~n", [NewValue]),
    OldValue = player:get_vitality(PS),
    if
        OldValue > NewValue ->
            Diff = OldValue - NewValue,
            player:cost_vitality(PS, Diff, [?LOG_GM]);
        OldValue < NewValue ->
            Diff = NewValue - OldValue,
            player:add_vitality(PS, Diff, [?LOG_GM]);
        true ->
            skip
    end;


%% 设置游戏币
handle_gm_cmd(set_copper, PS, NewValue) when is_integer(NewValue), NewValue >= 0 ->
    ?TRACE("handle_gm_cmd(), set_copper, NewValue=~p~n", [NewValue]),
    OldValue = player:get_copper(PS),
    if
        OldValue > NewValue ->
            Diff = OldValue - NewValue,
            player:cost_copper(PS, Diff, [?LOG_GM]);
        OldValue < NewValue ->
            Diff = NewValue - OldValue,
            player:add_copper(PS, Diff, [?LOG_GM]);
        true ->
            skip
    end;

%% 设置侠义值
handle_gm_cmd(set_xiayizhi, PS, NewValue) when is_integer(NewValue), NewValue >= 0 ->
    ?TRACE("handle_gm_cmd(), set_xiayizhi, NewValue=~p~n", [NewValue]),
    OldValue = player:get_chivalrous(PS),
    if
        OldValue > NewValue ->
            Diff = OldValue - NewValue,
            player:cost_chivalrous(PS, Diff, [?LOG_GM]);
        OldValue < NewValue ->
            Diff = NewValue - OldValue,
            player:add_chivalrous(PS, Diff, [?LOG_GM]);
        true ->
            skip
    end;

%% 设置绑定的元宝
handle_gm_cmd(set_bind_yuanbao, PS, NewValue) when is_integer(NewValue), NewValue >= 0 ->
    ?TRACE("handle_gm_cmd(), set_bind_yuanbao, NewValue=~p~n", [NewValue]),
    OldValue = player:get_bind_yuanbao(PS),
    if
        OldValue > NewValue ->
            Diff = OldValue - NewValue,
            player:cost_bind_yuanbao(PS, Diff, [?LOG_GM]);
        OldValue < NewValue ->
            Diff = NewValue - OldValue,
            player:add_bind_yuanbao(PS, Diff, [?LOG_GM]);
        true ->
            skip
    end;


%% 设置绑定的游戏币
handle_gm_cmd(set_bind_gamemoney, PS, NewValue) when is_integer(NewValue), NewValue >= 0 ->
    ?TRACE("handle_gm_cmd(), set_bind_gamemoney, NewValue=~p~n", [NewValue]),
    OldValue = player:get_bind_gamemoney(PS),
    if
        OldValue > NewValue ->
            Diff = OldValue - NewValue,
            player:cost_bind_gamemoney(PS, Diff, [?LOG_GM]);
        OldValue < NewValue ->
            Diff = NewValue - OldValue,
            player:add_bind_gamemoney(PS, Diff, [?LOG_GM]);
        true ->
            skip
    end;


%% 消耗绑定的游戏币
handle_gm_cmd(cost_bind_gamemoney, PS, Value) when is_integer(Value), Value > 0 ->
    ?TRACE("handle_gm_cmd(), cost_bind_gamemoney, Value=~p~n", [Value]),
    player:cost_bind_gamemoney(PS);

%% 消耗绑定的元宝
handle_gm_cmd(cost_bind_yuanbao, PS, Value) when is_integer(Value), Value > 0 ->
    ?TRACE("handle_gm_cmd(), cost_bind_yuanbao, Value=~p~n", [Value]),
    player:cost_bind_yuanbao(PS);

%% 消耗积分
handle_gm_cmd(cost_integral, PS, Value) when is_integer(Value), Value > 0 ->
    ?TRACE("handle_gm_cmd(), integral, Value=~p~n", [Value]),
    player:cost_integral(PS);


%% 升级（升一级）
handle_gm_cmd(upgrade, PS, _) ->
    ?TRACE("handle_gm_cmd(), upgrade~n"),
    MaxLv = mod_player:get_player_max_lv(PS),
    
    case player:get_lv(PS) of
        MaxLv ->
            skip;
        OldLv ->
            Exp = player:get_exp(PS),
            ExpLim = player:get_exp_lim(PS),
            ExpToAdd = ExpLim - Exp,

            ?Ifc (ExpToAdd > 0)
                player:add_exp(PS, ExpToAdd, [?LOG_GM])
            ?End,

            ?Ifc (OldLv >= ?MANUAL_UPGRADE_START_LV)
                player:do_upgrade(PS)  %%gen_server:cast( player:get_pid(PS), 'gm_cmd_manual_upgrade')
            ?End
    end;



% %% 设置等级   % TODO：目前只是简单的更新lv字段，没有做其他对应的调整（如天赋点），有待完善
% handle_gm_cmd(set_lv, PS, NewLv) when is_integer(NewLv) ->
%     NewLv2 = util:minmax(NewLv, 1, ?PLAYER_MAX_LV),
%     ?TRACE("handle_gm_cmd(), set_lv, NewLv=~p~n", [NewLv2]),
%     player:set_lv(PS, NewLv2),
%     player:notify_cli_upgrade(PS, NewLv2),
%     db:update(player, ["lv"], [NewLv2], "id", player:id(PS));


%% 设置hp
handle_gm_cmd(set_hp, PS, NewHp) when is_integer(NewHp) ->
    NewValue = util:minmax(NewHp, 0, player:get_hp_lim(PS)),
    OldValue = player:get_hp(PS),
    Diff = NewValue - OldValue,
    player:add_hp(PS, Diff);



%% 设置mp
handle_gm_cmd(set_mp, PS, NewMp) when is_integer(NewMp) ->
    NewValue = util:minmax(NewMp, 0, player:get_mp_lim(PS)),
    OldValue = player:get_mp(PS),
    Diff = NewValue - OldValue,
    player:add_mp(PS, Diff);


%% 获得物品
handle_gm_cmd(add_goods, PS, {GoodsNo, Count}) when is_integer(GoodsNo) ->
    ?TRACE("handle_gm_cmd(), add_goods, GoodsNo:~p,Count:~p~n", [GoodsNo, Count]),
    mod_inv:batch_smart_add_new_goods(player:get_id(PS), [{GoodsNo, Count}]);


handle_gm_cmd(add_goods, PS, {GoodsNo, Count, Quality}) ->
    ?TRACE("handle_gm_cmd(), add_goods, GoodsNo:~p,Quality:~p,Count:~p~n", [GoodsNo, Quality, Count]),
    mod_inv:batch_smart_add_new_goods(player:get_id(PS), [{GoodsNo, Count}], [{quality, Quality}], []);

handle_gm_cmd(add_bind_goods, PS, {GoodsNo, Count, BindState}) ->
    mod_inv:batch_smart_add_new_goods(player:get_id(PS), [{GoodsNo, Count}], [{bind_state, BindState}], []);

%% 触发战斗（打指定编号的怪物组）
handle_gm_cmd(trigger_mf, PS, BMonGroupNo) when is_integer(BMonGroupNo) ->
    ?LDS_TRACE("trigger_mf"),
    case lib_bmon_group:is_valid(BMonGroupNo) of
        false ->
            ?TRACE("[lib_gm] trigger_mf, BMonGroupNo is invalid!!~n"),
            skip;
        true ->
            case player:is_idle(PS) of
                false ->
                    ?TRACE("[lib_gm] trigger_mf, Not idle!!~n"),
                    skip;
                true ->
                    mod_battle:start_mf(PS, BMonGroupNo, null)
            end
    end;


%% 设置力量
handle_gm_cmd(set_str, PS, NewVal) when is_integer(NewVal) ->
    NewVal2 = util:minmax(NewVal, 0, ?MAX_TALENT_POINTS),
    OldVal = player:get_base_str(PS),
    Diff = NewVal2 - OldVal,
    player:add_base_str(PS, Diff),
    ply_attr:recount_base_and_total_attrs(PS),
    player:db_save_talents(PS);


%% 设置体质
handle_gm_cmd(set_con, PS, NewVal) when is_integer(NewVal) ->
    NewVal2 = util:minmax(NewVal, 0, ?MAX_TALENT_POINTS),
    OldVal = player:get_base_con(PS),
    Diff = NewVal2 - OldVal,
    player:add_base_con(PS, Diff),
    ply_attr:recount_base_and_total_attrs(PS),
    player:db_save_talents(PS);


%% 设置耐力
handle_gm_cmd(set_stam, PS, NewVal) when is_integer(NewVal) ->
    NewVal2 = util:minmax(NewVal, 0, ?MAX_TALENT_POINTS),
    OldVal = player:get_base_stam(PS),
    Diff = NewVal2 - OldVal,
    player:add_base_stam(PS, Diff),
    ply_attr:recount_base_and_total_attrs(PS),
    player:db_save_talents(PS);


%% 设置灵力
handle_gm_cmd(set_spi, PS, NewVal) when is_integer(NewVal) ->
    NewVal2 = util:minmax(NewVal, 0, ?MAX_TALENT_POINTS),
    OldVal = player:get_base_spi(PS),
    Diff = NewVal2 - OldVal,
    player:add_base_spi(PS, Diff),
    ply_attr:recount_base_and_total_attrs(PS),
    player:db_save_talents(PS);


%% 设置敏捷
handle_gm_cmd(set_agi, PS, NewVal) when is_integer(NewVal) ->
    NewVal2 = util:minmax(NewVal, 0, ?MAX_TALENT_POINTS),
    OldVal = player:get_base_agi(PS),
    Diff = NewVal2 - OldVal,
    player:add_base_agi(PS, Diff),
    ply_attr:recount_base_and_total_attrs(PS),
    player:db_save_talents(PS);

%% 设置为空闲状态
handle_gm_cmd(set_idle, PS, _) ->
    ?TRACE("lib_gm: set_idle~n"),
    player:mark_idle(PS);

%% 设置为忙状态
handle_gm_cmd(set_busy, PS, _) ->
    player:mark_busy(PS);

%% 直接结束战斗并获得战斗的胜利
handle_gm_cmd(force_win_battle, PS, _) ->
    case player:get_cur_battle_pid(PS) of
        null ->
            ?TRACE("[lib_gm] force_win_battle, not battling!!~n"),
            skip;
        CurBattlePid ->
            mod_battle:dbg_force_win_battle(PS, CurBattlePid)
    end;


%% 直接结束战斗并获得战斗的失败
handle_gm_cmd(force_lose_battle, PS, _) ->
    case player:get_cur_battle_pid(PS) of
        null ->
            ?TRACE("[lib_gm] force_lose_battle, not battling!!~n"),
            skip;
        CurBattlePid ->
            mod_battle:dbg_force_lose_battle(PS, CurBattlePid)
    end;


%% 循环打怪Times次（每次都是强行胜利）
handle_gm_cmd(loop_win_mf, PS, [BMonGroupNo, Times]) ->
    case lib_bmon_group:is_valid(BMonGroupNo) of
        false ->
            skip;
        true ->
            spawn(fun() -> loop_win_mf(player:id(PS), BMonGroupNo, Times) end)
    end;



%% 战斗中设置物理攻击
handle_gm_cmd(bt_set_phy_att, PS, NewVal) ->
    case player:get_cur_battle_pid(PS) of
        null ->
            ?TRACE("[lib_gm] bt_set_phy_att, not battling!!~n"),
            skip;
        CurBattlePid ->
            NewVal2 = max(NewVal, 0),
            mod_battle:dbg_force_set_attr(?ATTR_PHY_ATT, PS, CurBattlePid, NewVal2)
    end;


%% 战斗中设置物理防御
handle_gm_cmd(bt_set_phy_def, PS, NewVal) ->
    case player:get_cur_battle_pid(PS) of
        null ->
            ?TRACE("[lib_gm] bt_set_phy_def, not battling!!~n"),
            skip;
        CurBattlePid ->
            NewVal2 = max(NewVal, 0),
            mod_battle:dbg_force_set_attr(?ATTR_PHY_DEF, PS, CurBattlePid, NewVal2)
    end;


%% 战斗中设置法术攻击
handle_gm_cmd(bt_set_mag_att, PS, NewVal) ->
    case player:get_cur_battle_pid(PS) of
        null ->
            ?TRACE("[lib_gm] bt_set_mag_att, not battling!!~n"),
            skip;
        CurBattlePid ->
            NewVal2 = max(NewVal, 0),
            mod_battle:dbg_force_set_attr(?ATTR_MAG_ATT, PS, CurBattlePid, NewVal2)
    end;


%% 战斗中设置法术防御
handle_gm_cmd(bt_set_mag_def, PS, NewVal) ->
    case player:get_cur_battle_pid(PS) of
        null ->
            ?TRACE("[lib_gm] bt_set_mag_def, not battling!!~n"),
            skip;
        CurBattlePid ->
            NewVal2 = max(NewVal, 0),
            mod_battle:dbg_force_set_attr(?ATTR_MAG_DEF, PS, CurBattlePid, NewVal2)
    end;


%% 战斗中设置出手速度
handle_gm_cmd(bt_set_act_speed, PS, NewVal) ->
    case player:get_cur_battle_pid(PS) of
        null ->
            ?TRACE("[lib_gm] bt_set_act_speed, not battling!!~n"),
            skip;
        CurBattlePid ->
            NewVal2 = max(NewVal, 0),
            mod_battle:dbg_force_set_attr(?ATTR_ACT_SPEED, PS, CurBattlePid, NewVal2)
    end;



%% 战斗中设置所造成的伤害值是一个固定值
handle_gm_cmd(bt_set_do_fix_dam, PS, FixDamVal) ->
    case player:get_cur_battle_pid(PS) of
        null ->
            ?TRACE("[lib_gm] bt_set_do_fix_dam, not battling!!~n"),
            skip;
        CurBattlePid ->
            FixDamVal2 = max(FixDamVal, 1),
            mod_battle:dbg_force_set_do_fix_dam(PS, CurBattlePid, FixDamVal2)
    end;


%% 战斗中使伤害计算回归正常（用于取消原先所用的bt_set_do_fix_dam之类的gm指令）
handle_gm_cmd(bt_normalize_dam, PS, _) ->
    case player:get_cur_battle_pid(PS) of
        null ->
            ?TRACE("[lib_gm] bt_normalize_dam, not battling!!~n"),
            skip;
        CurBattlePid ->
            mod_battle:dbg_normalize_dam(PS, CurBattlePid)
    end;


%% 战斗中设置MP
handle_gm_cmd(bt_set_mp, PS, Val) ->
    case player:get_cur_battle_pid(PS) of
        null ->
            ?TRACE("[lib_gm] bt_set_mp, not battling!!~n"),
            skip;
        CurBattlePid ->
            Val2 = max(Val, 0),
            mod_battle:dbg_set_mp(PS, CurBattlePid, Val2)
    end;

handle_gm_cmd(bt_get_buff_info, PS, Val) ->
    case player:get_cur_battle_pid(PS) of
        null ->
            ?TRACE("[lib_gm] bt_get_buff_info, not battling!!~n"),
            skip;
        CurBattlePid ->
            BuffInfoList = mod_battle:dbg_get_buff_info(PS, CurBattlePid, Val),
            Msg = io_lib:format(<<"buff: ~w">>, [BuffInfoList]),
            send_prompt_to(PS, Msg)
    end;

handle_gm_cmd(bt_fast_kill_mon, PS, _) ->
    case player:get_cur_battle_pid(PS) of
        null ->
            ?TRACE("[lib_gm] bt_fast_kill_mon, not battling!!~n"),
            skip;
        CurBattlePid ->
            mod_battle:dbg_fast_kill_mon(PS, CurBattlePid),
            send_prompt_to(PS, "fast kill mon ok")
    end;


handle_gm_cmd(del_goods, PS, {GoodsNo, Count}) ->
    ?TRACE("handle_gm_cmd(), del_goods, GoodsNo:~p,Count:~p~n", [GoodsNo, Count]),
    mod_inv:destroy_goods_WNC(player:get_id(PS), [{GoodsNo, Count}]);


%% 加入门派
handle_gm_cmd(join_faction, PS, Faction) ->
    ?TRACE("handle_gm_cmd(), join_faction, Faction:~p~n", [Faction]),
    case lib_comm:is_valid_faction(Faction) of
        false -> skip;
        true ->
            case player:is_in_faction(PS) of
                true -> skip;
                false ->
                    ply_faction:join_faction(PS, Faction)
            end
    end;


handle_gm_cmd(change_faction, PS, Faction) ->
    ply_faction:transform_faction_for_gmorder(PS,Faction);


handle_gm_cmd(clear_bag, PS, _) ->
    BagGoodsList = mod_inv:get_goods_list(player:get_id(PS), ?LOC_BAG_EQ),
    F = fun(Goods) ->
        mod_inv:destroy_goods_WNC(player:get_id(PS), Goods, lib_goods:get_count(Goods))
    end,
    lists:foreach(F, BagGoodsList),

    BagGoodsList1 = mod_inv:get_goods_list(player:get_id(PS), ?LOC_BAG_USABLE),
    lists:foreach(F, BagGoodsList1),

    BagGoodsList2 = mod_inv:get_goods_list(player:get_id(PS), ?LOC_BAG_UNUSABLE),
    lists:foreach(F, BagGoodsList2);


handle_gm_cmd(add_intimacy, PS, Intimacy) ->
    F = fun(PartnerId) ->
        lib_partner:add_intimacy(PartnerId, Intimacy, PS)
    end,
    lists:foreach(F, player:get_partner_id_list(PS));


handle_gm_cmd(add_partner, PS, PartnerNo) ->
    ply_partner:player_add_partner(PS, PartnerNo);




%% 刷出明雷怪到场景
handle_gm_cmd(spawn_mon, _PS, {MonNo, SceneId, X, Y}) ->
    ?TRACE("lib_gm, spawn_mon~n"),
    mod_scene:spawn_mon_to_scene_WNC(MonNo, SceneId, X, Y);


%% 从场景清除明雷怪
handle_gm_cmd(clear_mon, _PS, MonId) ->
    ?TRACE("lib_gm, clear_mon~n"),
    mod_scene:clear_mon_from_scene_WNC(MonId);


%% 刷出动态npc到场景
handle_gm_cmd(spawn_dynamic_npc, _PS, {NpcNo, SceneId, X, Y}) ->
    ?TRACE("lib_gm, spawn_dynamic_npc~n"),
    mod_scene:spawn_dynamic_npc_to_scene_WNC(NpcNo, SceneId, X, Y);


%% 从场景清除动态npc
handle_gm_cmd(clear_dynamic_npc, _PS, NpcId) ->
    ?TRACE("lib_gm, clear_dynamic_npc~n"),
    mod_scene:clear_dynamic_npc_from_scene_WNC(NpcId);


%% 刷出动态传送点到场景
handle_gm_cmd(spawn_dynamic_teleporter, _PS, {TeleportNo, SceneId, X, Y}) ->
    ?TRACE("lib_gm, spawn_dynamic_teleporter~n"),
    mod_scene:spawn_dynamic_teleporter_to_scene_WNC(TeleportNo, SceneId, X, Y);


%% 从场景删除动态传送点
handle_gm_cmd(clear_dynamic_teleporter, _PS, {TeleportNo, SceneId, X, Y}) ->
    ?TRACE("lib_gm, clear_dynamic_teleporter~n"),
    Teleporter = #teleporter{
                    teleport_no = TeleportNo,   % 对应的传送编号
                    scene_id = SceneId,      % 所在的场景id
                    x = X,             % 所在的X坐标
                    y = Y
                    },
    mod_scene:clear_dynamic_teleporter_from_scene_WNC(Teleporter);


handle_gm_cmd(add_par_exp, PS, ParExp) ->
    F = fun(PartnerId) ->
        lib_partner:add_exp(PartnerId, ParExp, PS, [?LOG_GM, ?LOG_UNDEFINED])
    end,
    lists:foreach(F, player:get_partner_id_list(PS));

handle_gm_cmd(add_par_hp, PS, Value) ->
    F = fun(PartnerId) ->
        Partner = lib_partner:get_partner(PartnerId),
        Partner1 = lib_partner:add_hp(Partner, Value),
        mod_partner:update_partner_to_ets(Partner1)
    end,
    lists:foreach(F, player:get_partner_id_list(PS));    


handle_gm_cmd(add_evolve, PS, Value) ->
    F = fun(PartnerId) ->
        case lib_partner:get_partner(PartnerId) of
            null -> skip;
            Partner -> lib_partner:add_evolve(PS, Partner, Value)
        end
    end,
    lists:foreach(F, player:get_partner_id_list(PS));

handle_gm_cmd(goto, PS, {SceneId, X, Y}) ->
    ?TRACE("lib_gm, goto ...~n"),
    case lib_scene:get_obj(SceneId) of
        null ->
            send_prompt_to(PS, "目标场景不存在");
        SceneObj ->
            case lib_scene:is_xy_valid(SceneObj, X, Y) of
                false ->
                    send_prompt_to(PS, "坐标不合法");
                true ->
                    do_goto(PS, SceneId, X, Y)
            end
    end;


handle_gm_cmd(goto, PS, {X, Y}) ->
    ?TRACE("lib_gm, goto ..~n"),
    CurSceneId = player:get_scene_id(PS),
    do_goto(PS, CurSceneId, X, Y);




handle_gm_cmd(get_reward, PS, RewardNo) when is_integer(RewardNo) ->
    ?DEBUG_MSG("RewardNo=~p",[RewardNo]),
    lib_reward:give_reward_to_player(PS, RewardNo, [?LOG_GM]);

handle_gm_cmd(get_reward, PS, {RewardNo,0}) ->
    skip;

handle_gm_cmd(get_reward, PS, {RewardNo,Count}) ->
    lib_reward:give_reward_to_player(PS, RewardNo, [?LOG_GM]),
    handle_gm_cmd(get_reward, PS, {RewardNo,Count -1});


handle_gm_cmd(set_loyalty, PS, Loyalty) ->
    F = fun(PartnerId) ->
        Partner = lib_partner:get_partner(PartnerId),
        Partner1 = lib_partner:set_loyalty(Partner, Loyalty),
        mod_partner:update_partner_to_ets(Partner1)
    end,
    lists:foreach(F, player:get_partner_id_list(PS));


handle_gm_cmd(add_par_skill, PS, SkillId) ->
        PartnerId =  player:get_main_partner_id(PS),
        Partner = lib_partner:get_partner(PartnerId),
        SkillList = lib_partner:get_skill_list(Partner),
        AddSkill = #skl_brief{id = SkillId},
        NewSkillList = [AddSkill | SkillList],
        Partner1 = lib_partner:set_skill_list(Partner, NewSkillList),
        % Partner2 = lib_partner:recount_passi_eff_attrs(Partner1),
        Partner3 = lib_partner:recount_total_attrs(Partner1),
        Partner4 = lib_partner:recount_battle_power(Partner3),
        
        mod_partner:update_partner_to_ets(Partner4),
        mod_partner:db_save_partner(Partner4),
        lib_partner:notify_cli_info_change(Partner4, [{?OI_CODE_PAR_ADD_SKILL, AddSkill#skl_brief.id}]);


handle_gm_cmd(del_par_skill, PS, SkillId) when is_integer(SkillId) ->
        PartnerId =  player:get_main_partner_id(PS),
        Partner = lib_partner:get_partner(PartnerId),
        SkillList = lib_partner:get_skill_list(Partner),
        NewSkillList = lists:keydelete(SkillId, #skl_brief.id, SkillList),
        Partner1 = lib_partner:set_skill_list(Partner, NewSkillList),
        % Partner2 = lib_partner:recount_passi_eff_attrs(Partner1),
        Partner3 = lib_partner:recount_total_attrs(Partner1),
        Partner4 = lib_partner:recount_battle_power(Partner3),
        mod_partner:update_partner_to_ets(Partner4),
        mod_partner:db_save_partner(Partner4),
        lib_partner:notify_cli_info_change(Partner4, [{?OI_CODE_PAR_DEL_SKILL, SkillId}]);


handle_gm_cmd(del_par_skill, PS, _) ->
    F = fun(PartnerId) ->
        Partner = lib_partner:get_partner(PartnerId),
        SkillList = lib_partner:get_skill_list(Partner),
        [handle_gm_cmd(del_par_skill, PS, Skill#skl_brief.id) || Skill <- SkillList]
    end,
    lists:foreach(F, player:get_partner_id_list(PS));
    

handle_gm_cmd(send_broadcast, _PS, [Content]) ->
    Broadcast = mod_broadcast:to_broadcast_record([0, 1, 1, tool:to_binary(Content), 0, 0, 0, 1]),
    mod_broadcast:add_or_update_broadcast(Broadcast);


handle_gm_cmd(sign_in, PS, [Day]) ->
    ply_day_reward:gm_do_sign_in(PS, Day);


handle_gm_cmd(add_prosper, PS, [Prosper]) ->
    case player:get_guild_id(PS) of
        ?INVALID_ID -> skip;
        GuildId -> mod_guild_mgr:add_prosper(GuildId, Prosper)
    end;

handle_gm_cmd(sys_broadcast, _PS, [No, ParaList]) ->
    mod_broadcast:send_sys_broadcast(No, ParaList);

handle_gm_cmd(set_time, PS, {Hour, Min, Sec}) ->
    case check_time_format({Hour, Min, Sec}) of
        fail ->
            send_prompt_to(PS, "时间错误，正确格式：set_time 时 分 秒，如：set_time 0 0 0");
        ok ->
            % {CurHour, CurMin, CurSec} = mod_mytm:time(),
            % case cmp_time({Hour, Min, Sec}, {CurHour, CurMin, CurSec}) of
            %     earlier ->
            %         send_prompt_to(PS, "不允许把时间调回到以前，请重新设置");
            %     equal ->
            %         send_prompt_to(PS, "设置时间成功");
            %     later ->
                    case mod_mytm:set_time({Hour, Min, Sec}) of
                        fail ->
                            send_prompt_to(PS, "设置时间失败，请重试");
                        ok ->
                            send_prompt_to(PS, "设置时间成功")
                    end
            % end
    end;

handle_gm_cmd(set_date, PS, {Year, Month, Day}) ->
    case check_date_format({Year, Month, Day}) of
        fail ->
            send_prompt_to(PS, "日期错误，正确格式：set_date 年 月 日，如：set_date 2014 1 1");
        ok ->
            case mod_mytm:set_date({Year, Month, Day}) of
                fail ->
                    send_prompt_to(PS, "设置日期失败，请重试");
                ok ->
                    send_prompt_to(PS, "设置日期成功")
            end
    end;

handle_gm_cmd(get_time, PS, _) ->
    CurTime = mod_mytm:time(),
    Msg = io_lib:format(<<"当前时间：~p">>, [CurTime]),
    send_prompt_to(PS, Msg);

handle_gm_cmd(get_date, PS, _) ->
    ?TRACE("lib_gm: get_date~n"),
    CurDate = mod_mytm:date(),
    Msg = io_lib:format(<<"当前日期：~p">>, [CurDate]),
    send_prompt_to(PS, Msg);

handle_gm_cmd(normalize_time, PS, _) ->
    case mod_mytm:normalize_time() of
        fail ->
            send_prompt_to(PS, "恢复失败，请重试");
        ok ->
            send_prompt_to(PS, "时间和日期已恢复正常")
    end;

handle_gm_cmd(get_online_num, PS, _) ->
    Num = mod_svr_mgr:get_total_online_num(),
    Msg = io_lib:format(<<"当前在线人数：~p">>, [Num]),
    send_prompt_to(PS, Msg);

handle_gm_cmd(add_liveness, PS, [Liveness]) ->
    case player:get_guild_id(PS) of
        ?INVALID_ID -> skip;
        GuildId -> mod_guild_mgr:add_liveness(GuildId, Liveness)
    end;

handle_gm_cmd(add_guild_con, PS, [GuildCon]) ->
    case player:get_guild_id(PS) of
        ?INVALID_ID -> skip;
        _GuildId -> mod_guild:add_guild_member_contri(PS, GuildCon, [])
    end;

handle_gm_cmd(rank_all, _PS, []) ->
    gen_server:cast(mod_rank, release_rank);

handle_gm_cmd(rank_title, _PS, []) ->
    mod_rank_gift:daily_title();

handle_gm_cmd(msgq_test, _PS, []) ->
    mod_sys_checker:msgq_test();

handle_gm_cmd(dead_loop_test, _PS, []) ->
    mod_sys_checker:dead_loop_test();

handle_gm_cmd(reds_test, _PS, []) ->
    mod_sys_checker:reds_test();

handle_gm_cmd(kill_bdist_test, _PS, []) ->
    mod_sys_checker:kill_bdist_test();

handle_gm_cmd(offaw, PS, []) ->
    PS1 = mod_offline_guaji:start(PS),
    player_syn:update_PS_to_ets(PS1);

handle_gm_cmd(reward_pool, PS, [No]) ->
    mod_reward_pool:reward(No, PS, []);

handle_gm_cmd(dig, PS, [No]) ->
    mod_dig_treasure:test_dig(No, PS);

handle_gm_cmd(dig, PS, [No, GoodsNo]) ->
    mod_dig_treasure:test_dig(No, GoodsNo, PS);

handle_gm_cmd(p, _PS, []) ->
    _RI = record_info(fields, player_status),
    ?TRAC(util:rec_to_pl(_RI, _PS));

handle_gm_cmd(p, PS, [Item]) ->
    RI = record_info(fields, player_status),
    PL = util:rec_to_pl(RI, PS),
    Info = list_to_binary(io_lib:format("~p: ~p", [Item, proplists:get_value(Item, PL)])),
    InfoBin = << ?P_BITSTR(Info) >>,
    UID = player:id(PS),
    {ok, Bin} = pt_11:write(11001, [UID, InfoBin, 0, "DEBUG"]),
    lib_send:send_to_uid(UID, Bin),
    ?TRAC(Info);

handle_gm_cmd(e, PS, [Table]) ->
    UID = player:id(PS),
    Info = ets:lookup(Table, UID),
    InfoStr = util:term_to_bitstring(Info),
    InfoBin = << ?P_BITSTR(InfoStr) >>,
    UID = player:id(PS),
    {ok, Bin} = pt_11:write(11001, [UID, InfoBin, 0, "DEBUG"]),
    lib_send:send_to_uid(UID, Bin),
    ?TRAC(Info);

%% 开放所有系统
handle_gm_cmd(open_all_sys, PS, _) ->
    ?TRACE("lib_gm, open_all_sys...~n"),
    ply_sys_open:dbg_force_open_all_sys(PS);

handle_gm_cmd(create_guild_dun, PS, _) ->
    case player:get_guild_id(PS) of
        ?INVALID_ID -> skip;
        GuildId ->
            case mod_guild:get_info(GuildId) of
                null -> skip;
                Guild ->
                    Lv = mod_guild:get_lv(Guild),
                    Data = data_guild_lv:get(Lv),
                    ?DEBUG_MSG("lib_gm:create_guild_dun~n", []),
                    lib_dungeon:create_guild_dungeon(?GUILD_DUNGEON_NO, svr_clock:get_unixtime(), lists:nth(1, Data#guild_lv_data.layer),
                    lists:nth(2, Data#guild_lv_data.layer), GuildId)
            end
    end;

handle_gm_cmd(guild_dun, PS, dummy) ->
    case player:get_guild_id(PS) of
        ?INVALID_ID -> skip;
        _GuildId ->
            ?DEBUG_MSG("lib_gm:guild_dun~n", []),
            ply_guild:enter_guild_dungeon(PS)
    end;

handle_gm_cmd(guild_party_begin, PS, [Interval]) ->
    case player:get_guild_id(PS) of
        ?INVALID_ID -> skip;
        _GuildId -> mod_guild_mgr:guild_party_begin(Interval)
    end;

handle_gm_cmd(guild_party_end, _PS, _) ->
    mod_guild_mgr:guild_party_end();


handle_gm_cmd(guild_lv, PS, Lv) ->
    case mod_guild:get_info(player:get_guild_id(PS)) of
        null ->
            skip;
        Guild ->
            Guild1 = Guild#guild{lv = Lv},
            mod_guild:update_guild_to_ets(Guild1),
            mod_guild:db_save_guild(Guild1),
            spawn(fun() -> mod_guild:notify_guild_info_change(Guild1, [{guild_lv, Guild1#guild.lv}]) end),
            case Lv >= 7 of
                false -> skip;
                true -> ply_tips:send_sys_tips(Guild, {guild_lv_up, [Guild#guild.name, Lv]})
            end
    end;


handle_gm_cmd(del_prosper, PS, [Prosper]) ->
    case player:get_guild_id(PS) of
        ?INVALID_ID -> skip;
        GuildId -> mod_guild:del_prosper(mod_guild:get_info(GuildId), Prosper)
    end;



handle_gm_cmd(open_cruise, _PS, _) ->
    ?TRACE("lib_gm, open_cruise...~n"),
    mod_cruise:dbg_force_open_activity();

handle_gm_cmd(dun_point, PS, [Point]) ->
    lib_event:event(?DUN_POINTS_THRESHOLD, [Point], PS);


handle_gm_cmd(guild_job, PS, dummy) ->
    case player:get_guild_id(PS) of
        ?INVALID_ID -> skip;
        _GuildId ->
            mod_guild_mgr:on_guild_job_schedule()
    end;

handle_gm_cmd(guild_battle_start, PS, dummy) ->
    mod_guild_battle:guild_battle_begin();
handle_gm_cmd(guild_battle_open, PS, dummy) ->
    mod_guild_battle:guild_battle_open();

    

handle_gm_cmd(guild_battle_end, PS, dummy) ->
    case player:get_guild_id(PS) of
        ?INVALID_ID -> skip;
        GuildId ->
            mod_guild_battle:guild_battle_end(GuildId,player:id(PS))
    end;

handle_gm_cmd(guild_battle_end1, PS, dummy) ->
    mod_guild_battle:guild_battle_end();



handle_gm_cmd(add_title, PS, Title) ->
    UID = player:id(PS),
    ply_title:add_title(UID, Title);


handle_gm_cmd(add_utitle, PS, [ID, Text]) ->
    UID = player:id(PS),
    Bin = util:to_binary(Text),
    ply_title:add_user_def_title(UID, ID, Bin);


handle_gm_cmd (set_priv, PS, PrivLv) ->
    case ply_priv:is_valid_priv_lv(PrivLv) of
        true ->
            ply_priv:set_priv_lv(PS, PrivLv),
            send_prompt_to(PS, "set priv succeed!");
        false ->
            send_prompt_to(PS, "invalid priv lv!")
    end;


handle_gm_cmd(guild_war, PS, dummy) ->
    case player:get_guild_id(PS) of
        ?INVALID_ID -> skip;
        _GuildId ->
            mod_guild_mgr:test_enter_war_dun(PS)
    end;


handle_gm_cmd(guild_war_group, PS, dummy) ->
    case player:get_guild_id(PS) of
        ?INVALID_ID -> skip;
        _GuildId ->
            mod_guild_mgr:decide_guild_war_group()
    end;    

handle_gm_cmd(pre_war_begin, PS, dummy) ->
    case player:get_guild_id(PS) of
        ?INVALID_ID -> skip;
        _GuildId ->
            mod_guild_mgr:notify_guild_pre_war_begin()
    end;   

handle_gm_cmd(pre_war_end, PS, dummy) ->
    case player:get_guild_id(PS) of
        ?INVALID_ID -> skip;
        _GuildId ->
            mod_guild_mgr:notify_guild_pre_war_end()
    end;       

handle_gm_cmd(war_begin, PS, dummy) ->
    case player:get_guild_id(PS) of
        ?INVALID_ID -> skip;
        _GuildId ->
            mod_guild_mgr:notify_guild_war_begin()
    end;   

handle_gm_cmd(war_end, PS, dummy) ->
    case player:get_guild_id(PS) of
        ?INVALID_ID -> skip;
        _GuildId ->
            mod_guild_mgr:notify_guild_war_end()
    end;        

handle_gm_cmd(guild_war_info, _PS, dummy) ->
    mod_guild_mgr:test_get_war_info();


handle_gm_cmd(war_dun_info, PS, dummy) ->
    mod_guild_war:test_get_info(PS);

handle_gm_cmd(clear_war, PS, dummy) ->
    case player:get_guild_id(PS) of
        ?INVALID_ID -> skip;
        _GuildId ->
            mod_guild_mgr:test_clear_war()
    end;

handle_gm_cmd(bid_war, PS, [Money]) ->
    case player:get_guild_id(PS) of
        ?INVALID_ID -> skip;
        _GuildId ->
            pp_guild:handle(?PT_GUILD_BID_FOR_BATTLE, PS, [Money])
    end;

%% 自动过帮派争霸赛当前轮的比赛
handle_gm_cmd(pass_round, PS, dummy) ->
    handle_gm_cmd(pre_war_begin, PS, dummy),
    timer:sleep(10),
    handle_gm_cmd(war_begin, PS, dummy),
    timer:sleep(10),
    handle_gm_cmd(pre_war_end, PS, dummy),
    timer:sleep(10),
    handle_gm_cmd(war_end, PS, dummy);

handle_gm_cmd(set_tve_cnt, PS, NewValue) ->
    mod_tve_mgr:tst_set_enter_cnt(PS, NewValue);

handle_gm_cmd(set_tve_cnt_single, PS, NewValue) ->
    mod_tve_mgr:tst_set_enter_cnt_single(PS, NewValue);


handle_gm_cmd(reset_answer, PS, dummy) ->
    case lib_activity:get_answer_info(player:id(PS)) of
        Answer when is_record(Answer, answer) ->
            lib_activity:update_answer_info(#answer{role_id = Answer#answer.role_id, join_time = util:unixtime(), his_cor_num = Answer#answer.his_cor_num}),
            {ok, BinData} = pt_31:write(31001, [0]),
            lib_send:send_to_uid(player:id(PS), BinData);
        _ -> skip
    end;

handle_gm_cmd(par_add_skill, PS, [ParNo, NewVal]) ->
	PartnerList = ply_partner:get_partner_list(PS),
	case lists:keyfind(ParNo, #partner.no, PartnerList) of
		Partner when is_record(Partner, partner) ->
			skip;
		_ ->
			o
	end;

handle_gm_cmd(par_del_skill, PS, [ParNo, NewVal]) ->
	skip;

handle_gm_cmd(role_add_skill, PS, NewVal) ->
	skip;

handle_gm_cmd(role_del_skill, PS, NewVal) ->
	skip;



handle_gm_cmd(_Cmd, _PS, _Args) ->
    do_nothing.









do_goto(PS, SceneId, X, Y) ->
    ply_scene:do_teleport(PS, SceneId, X, Y),
    pp_scene:handle(?PT_GET_SCENE_DYNAMIC_NPC_LIST, PS, SceneId),
    pp_scene:handle(?PT_GET_SCENE_AOI_INFO, PS, SceneId).



loop_win_mf(PlayerId, BMonGroupNo, Times) ->
    F = fun(_CurSeqNum) ->
            PS = player:get_PS(PlayerId),
            handle_gm_cmd(trigger_mf, PS, BMonGroupNo),
            timer:sleep(4500),

            PS2 = player:get_PS(PlayerId),
            handle_gm_cmd(force_win_battle, PS2, dummy),
            timer:sleep(2000)
        end,
    L = lists:seq(1, Times),
    lists:foreach(F, L).



% %% 把世界聊天信息当成gm指令
% handle_chat_msg_as_gm_cmd(PS, []) ->
% 	{ok, PS};
% handle_chat_msg_as_gm_cmd(PS, [ChatMsg0|T]) ->
%     ChatMsg = string:tokens(ChatMsg0, " "),
%     F = fun(CM)->%将字符串解码、解码失败的保持原样。特别备注——中文名和英语名可能会有不同的结果
%                 Reply = util:string_to_term(CM),
%                 if CM == "undefined" ->
%                        undefined;
%                    Reply =/= undefined ->
%                        Reply;
%                    true ->
%                        CM
%                 end
%         end,
%     ChatMsg1 = [F(CM) || CM <- ChatMsg],
%     Reply =
%         case ChatMsg1 of
%             ["@star_score", Cell] ->
%                 handle_gm_cmd(star_score, {PS, Cell});
%             ["/who"] -> % 获得总人数
%                 handle_gm_cmd(get_online_num, PS);
% 			["@get_speed"] -> % 获取速度
%                 handle_gm_cmd(get_speed, PS);
% 			["@set_speed", NewSpeed] -> % 设置速度
%                 handle_gm_cmd(set_speed, {PS, NewSpeed});
%             ["@get_time"] -> % 获取当前时间
%                 handle_gm_cmd(get_time, PS);
%             ["@get_id", Name] -> % 获取当然人物ID
%                 handle_gm_cmd(get_role_id, {PS, Name});
%             ["@get_date"] -> % 获取当前日期
%                 handle_gm_cmd(get_date, PS);
%             ["@set_time", Hour, Min, Sec] -> % 设置当前时间
%                 handle_gm_cmd(set_time, {PS, {Hour, Min, Sec}});
%             ["@set_date", Year, Month, Day] -> % 设置当前日期
%                 handle_gm_cmd(set_date, {PS, {Year, Month, Day}});
%             ["@normalize_time"] -> % 使时间和日期恢复正常
%                 handle_gm_cmd(normalize_time, PS);
%             ["@skill", SkillId, Lv] ->     % 设置当前技能
%                 handle_gm_cmd(add_skill, {PS, [SkillId], Lv});
%             ["@allskill"] ->  % 学习自身拥用的所有技能
%                 handle_gm_cmd(add_all_skill, {PS, 10});
%             ["@allskill", Lv] ->  % 学习自身拥用的所有技能
%                 handle_gm_cmd(add_all_skill, {PS, Lv});

%             ["@clear_one_day_times_log"] ->  % 清除玩家在单天限制次数的一些游戏玩法中的次数记录
%                 handle_gm_cmd(clear_one_day_times_log, PS);
% %% ---------- 物品操作 ------------------
%             %% 给与物品操作
%             ["@bindgoods", GoodsId] ->  % 加绑定物品(没有指定数量，将默认为1)
%                 handle_gm_cmd(add_bindgoods, {PS, GoodsId, 1});
%             ["@bindgoods", GoodsId, GoodsNum] ->  % 加绑定物品(指定了数量)
%                 handle_gm_cmd(add_bindgoods, {PS, GoodsId, GoodsNum});
%             ["@goods", GoodsId] ->  % 加物品(没有指定数量，将默认为1)
%                 handle_gm_cmd(add_goods, {PS, GoodsId, 1});
%             ["@goods", GoodsId, GoodsNum] ->  % 加物品(指定了数量)
%                 handle_gm_cmd(add_goods, {PS, GoodsId, GoodsNum});
%             ["@give_goods", GoodsId,  PlayerId] ->  % 加物品(没有指定数量，将默认为1)
%                 case gm_get_player_status(PlayerId, PS) of
%                     [] ->          send_prompt(PS, "玩家选择错误");
%                     ToPS ->      handle_gm_cmd(give_goods, {PS, ToPS, GoodsId, 1})
%                 end;
%             ["@give_goods", GoodsId, GoodsNum,  PlayerId] ->
%                 case gm_get_player_status(PlayerId, PS) of
%                     [] ->         send_prompt(PS, "玩家选择错误");
%                     ToPS ->     handle_gm_cmd(give_goods, {PS, ToPS, GoodsId, GoodsNum})
%                 end;
%             ["@give_bindgoods", GoodsId, PlayerId] ->
%                 case gm_get_player_status(PlayerId, PS) of
%                     [] ->         send_prompt(PS, "玩家选择错误");
%                     ToPS ->     handle_gm_cmd(give_bindgoods, {PS, ToPS, GoodsId, 1})
%                 end;
%             ["@give_bindgoods", GoodsId, GoodsNum,  PlayerId] ->
%                 case gm_get_player_status(PlayerId, PS) of
%                     [] ->         send_prompt(PS, "玩家选择错误");
%                     ToPS ->     handle_gm_cmd(give_bindgoods, {PS, ToPS, GoodsId, GoodsNum})
%                 end;
%             %% 改变物品绑定状态
%             ["@bind", GoodsId, State] ->
%                 handle_gm_cmd(bind, {PS, GoodsId, State});
%             %% 获取物品唯一ID，通过背包格子编号(仅限背包)
%             ["@goods_id", Cell] ->
%                 handle_gm_cmd(get_goods_id, {PS, Cell});
%             %% 打印背包所有物品信息{Id, Tid, Cell}
%             ["@baginfo"] ->
%                 handle_gm_cmd(baginfo, PS);
%             %% 通过物品名称，搜索对应的类型ID
%             ["@search_item", Str] ->
%                 handle_gm_cmd(search_item, {PS, Str});

%             ["@repu", NewRepu] ->     % 设置声望值
%                 handle_gm_cmd(set_repu, {PS, NewRepu});
%             %% 给予货币操作
%             ["@coin", Coin] ->     % 增加当前游戏币
%                 handle_gm_cmd(add_coin, {PS, Coin, coin});
%             ["@coin", PlayerId, Coin] ->     % 增加别人游戏币
%                 case gm_get_player_status(PlayerId, PS) of
%                     [] ->
%                         send_prompt(PS, "玩家选择错误");
%                     PS1 ->
%                         handle_gm_cmd(add_coin, {PS, PS1, Coin, coin})
%                 end;
%             ["@ubcoin", Coin] ->   % 增加非绑定金币
%                 handle_gm_cmd(add_ubcoin, {PS, Coin, ubcoin});
%             ["@gold", Coin] ->     % 增加当前元宝
%                 handle_gm_cmd(add_coin, {PS, Coin, gold});
%             ["@gold", PlayerId, Coin] ->     % 增加别人游戏币
%                 case gm_get_player_status(PlayerId, PS) of
%                     [] ->
%                         send_prompt(PS, "玩家选择错误");
%                     PS1 ->
%                         handle_gm_cmd(add_coin, {PS, PS1, Coin, gold})
%                 end;
%             ["@bcoin", Coin] ->     % 增加当前战天币
%                 handle_gm_cmd(add_coin, {PS, Coin, bcoin});
%             ["@bcoin", PlayerId, Coin] ->     % 增加别人游戏币
%                 case gm_get_player_status(PlayerId, PS) of
%                     [] ->
%                         send_prompt(PS, "玩家选择错误");
%                     PS1 ->
%                         handle_gm_cmd(add_coin, {PS, PS1, Coin, bcoin})
%                 end;
%             ["@contrib", Value] ->     % 增加战功值
%                 handle_gm_cmd(add_contrib, {PS, Value});

%             ["@gongxun", Value] ->     % 增加功勋值
%                 handle_gm_cmd(add_gongxun, {PS, Value});

%             %% 清空背包
%             ["@clear_bag"] ->
%                 handle_gm_cmd(clear_bag, PS);
%             %% 向自己邮箱发送物品
%             ["@mail_goods", GoodsTid] ->
%                 handle_gm_cmd(mail_goods, {PS, GoodsTid, 1});
%             ["@mail_goods", GoodsTid, GoodsNum] ->
%                 handle_gm_cmd(mail_goods, {PS, GoodsTid, GoodsNum});

%             %% 铸造测试gm指令
%             ["@casting"] ->
%                 handle_gm_cmd(casting_test, PS);


% %% ---------- 战斗相关操作 ------------------
%             %% 设置当前武将的技能
%             ["@par_skl", Name, SklIdOrName, SklLv] ->
%                 handle_gm_cmd(par_skl, {PS, Name, SklIdOrName, SklLv});
%             ["@player_skl", SklIdOrName, SklLv] ->
%                 handle_gm_cmd(player_skl, {PS, SklIdOrName, SklLv});

% %% ---------- 礼包操作 ------------------
%             %% 修改日常礼包状态为未领取
%             ["@dgift_get"] ->
%                 handle_gm_cmd(daily_gift_get, PS);
%             %% 设置今天为第N天连续登录
%             ["@dgift_con", Days] ->
%                 handle_gm_cmd(daily_gift_condays, {PS, Days});
%             %% 设置昨天未登录过游戏
%             ["@dgift_nologin"] ->
%                 handle_gm_cmd(daily_gift_nologin, PS);
%             %% 修改在线礼包冷却时间置0
%             ["@ogift_cd"] ->
%                 handle_gm_cmd(online_gift_cd, PS);
%             %% 今日领取在线礼包次数清0
%             ["@ogift_get"] ->
%                 handle_gm_cmd(online_gift_get, PS);
%             %% 设置已注册天数
%             ["@logift_days", Days] ->
%                 handle_gm_cmd(login_gift_days, {PS, Days});
%             %% 登录礼包设置为从未领取过
%             ["@logift_get"] ->
%                 handle_gm_cmd(login_gift_get, PS);
%             %% 重置等级礼包为未领取过
%             ["@lvgift_get"] ->
%                 handle_gm_cmd(lv_gift_get, PS);
%             %% 充值元宝
%             ["@gift_charge", Gold] ->
%                 handle_gm_cmd(gift_charge, {PS, Gold});
%             %% 签到
%             ["@gift_sign", Day] ->
%                 handle_gm_cmd(gift_sign, {PS, Day});
%             %% 清除签到
%             ["@gift_sign_clear", Day] ->
%                 handle_gm_cmd(gift_sign_clear, {PS, Day});
%             %% 签到(上月)
%             ["@gift_sign_lastmonth", Day] ->
%                 handle_gm_cmd(gift_sign_lastmonth, {PS, Day});
%             %% 清除签到(上月)
%             ["@gift_sign_clear_lastmonth", Day] ->
%                 handle_gm_cmd(gift_sign_clear_lastmonth, {PS, Day});
%             %% 离线经验
%             ["@gift_offline_exp", Exp] ->
%                 handle_gm_cmd(gift_offline_exp, {PS, Exp});
%             %% 重置返还
%             ["@gift_ret"] ->
%                 handle_gm_cmd(gift_ret, PS);

% %% ---------- buff操作 ------------------
%             %% 增加buff
%             ["@add_buff", BuffTid] ->
%                 handle_gm_cmd(add_buff, {PS, BuffTid});
%             %% 删除buff
%             ["@del_buff", BuffTid] ->
%                 handle_gm_cmd(del_buff, {PS, BuffTid});

% %% ---------- 神秘商店操作 ---------------
%             %% 修改剩余刷新时间(分钟为单位)
%             ["@sec_cd", Min] ->
%                 handle_gm_cmd(mystery_cd, {PS, Min});

% %% ---------- 神秘商店操作 ---------------
%             %% 全服公告滚动
%             ["@rolling_anno", Type] ->
%                 handle_gm_cmd(rolling_anno, {PS, Type});

%             %% 全服公告闪现
%             ["@flash_anno", Type] ->
%                 handle_gm_cmd(flash_anno, {PS, Type});

% %% ---------- 排行榜功能操作 ------------------
%             %% 刷新某一类型的排行榜
%             ["@refresh_rank", Type] ->
%                 handle_gm_cmd(refresh_rank, {PS, Type});
%             %% 刷新一次总数的排行
%             ["@rank", Type] ->
%                 handle_gm_cmd(rank, {PS, Type});
%             %% 刷新副本排行榜
%             ["@refresh_dungeon_rank"] ->
%                 handle_gm_cmd(refresh_dungeon_rank, PS);

% %% ---------- 称号系统功能操作 ------------------
% 			%% 刷新称号列表
%             ["@refresh_title"] ->
%                 handle_gm_cmd(refresh_title, PS);


% %% ---------- 通缉令功能操作 --------------------
%             %% 清除追缉玩家及怪的次数
%             ["@clear_pvp"] ->
%                 handle_gm_cmd(clear_pvp, {PS, 0});


% %% ---------- 帮会基础功能操作 ------------------
%             %% 设置帮会贡献
%             ["@guild_contr", Val] ->
%                 handle_gm_cmd(set_guild_contr, {PS, Val});
%             %% 将自己设置为已入帮会12小时
%             ["@join_guild"] ->
%                 handle_gm_cmd(join_guild_time, PS);
%             %% 设置自己帮会等级
%             ["@guildlv", Lv]->
%                 handle_gm_cmd(guildlv, {PS, Lv});

% %% ---------- 战斗相关指令 --------------------- 0未开启；1开启
%             %% 杀死敌方全部的怪
%             ["@smash"] ->
%                 handle_gm_cmd(battle_smash, {PS, 0, 0});
%             %% 杀死某个坐标的怪
%             ["@smash", X, Y] ->
%                 handle_gm_cmd(battle_smash, {PS, X, Y});
%             %% 将自己设为不死状态
%             ["@inv", X] ->   % 0 取消无敌，1 开启无敌
%                 handle_gm_cmd(battle_invincible, [PS, X]);
%             %% 和某人(在线)进行PK
%             ["@online_pk", Name] ->
%                 handle_gm_cmd(battle_online_pk, [PS, Name]);
%             ["@offline_pk", Name] ->
%                 handle_gm_cmd(battle_offline_pk, [PS, Name]);
%             ["@battle_anger", Val] ->
%                 handle_gm_cmd(battle_set_anger, [PS, Val]);
%             ["@battle_arousal", Val] ->
%                 handle_gm_cmd(battle_set_arousal, [PS, Val]);
%             ["@battle_trace", Num] when Num =:= 0; Num =:= 1 ->
%                 handle_gm_cmd(battle_set_trace, [PS, Num]);


% %% ---------- 帮会大战功能操作 ------------------
%             %% 开启帮派大战
%             ["@npvp"]->
%                 case handle_gm_cmd(notice_guild_pvp, PS) of
%                     {false, Msg} ->
%                         send_prompt(PS, Msg);
%                     true ->
%                         send_prompt(PS, "通知帮派PVP马上开始!");
%                     _ ->
%                         send_prompt(PS, "异常错误！")
%                 end;

%             ["@guildarea", Val]->
%                 case handle_gm_cmd(guildarea, {PS, Val, 0}) of
%                     {false, Reason} ->
%                         send_prompt(PS, Reason);
%                     true ->
%                         send_prompt(PS, "设置帮会区域成功");
%                     _ ->
%                         send_prompt(PS, "异常错误！")
%                 end;
%             ["@guildarea", Val1, Val2]->
%                 case handle_gm_cmd(guildarea, {PS, Val1, Val2}) of
%                     {false, Reason} ->
%                         send_prompt(PS, Reason);
%                     true ->
%                         send_prompt(PS, "设置帮会区域成功");
%                     _ ->
%                         send_prompt(PS, "异常错误！")
%                 end;

%             ["@gwarwin", Val]->
%                 case handle_gm_cmd(g_war_to_floor, {PS, Val}) of
%                     {false, no_guild} ->
%                         send_prompt(PS, "请先建帮会或入帮会！");
%                     {false, lv_err} ->
%                         send_prompt(PS, "帮会等级有误！");
%                     true ->
%                         send_prompt(PS, "帮会完成到该层");
%                     _ ->
%                         send_prompt(PS, "异常错误！")
%                 end;
%             ["@gwarlost"]->
%                 case handle_gm_cmd(g_war_lost, PS) of
%                     {false, no_guild} ->
%                         send_prompt(PS, "请先建帮会或入帮会！");
%                     {false, no_war} ->
%                         send_prompt(PS, "没发起征战!");
%                     true ->
%                         send_prompt(PS, "设置帮会征战失败成功!");
%                     _ ->
%                         send_prompt(PS, "异常错误！")
%                 end;

%             ["@cleargwar"]->
%                 case handle_gm_cmd(clear_g_war, PS) of
%                     {false, Msg} ->
%                         send_prompt(PS, Msg);
%                     true ->
%                         send_prompt(PS, "清除帮会征战成功，今日可再次征战!");
%                     Err ->
%                         ?TRACE("clear_guild_war_err:~p~n", [Err]),
%                         send_prompt(PS, "异常错误！")
%                 end;

% %% ---------- 诸神战声功能操作 ------------------
%             %% 开启诸神战场
%             ["@begin_zc"]->
%                 case handle_gm_cmd(start_gods_pvp, PS) of
%                     {false, Msg} ->
%                         send_prompt(PS, Msg);
%                     true ->
%                         send_prompt(PS, "猪神战场马上开启!");
%                     _ ->
%                         send_prompt(PS, "异常错误！")
%                 end;

%             %% 停止诸神战场
%             ["@stop_zc"]->
%                 case handle_gm_cmd(end_gods_pvp, PS) of
%                     {false, Reason} ->
%                         send_prompt(PS, Reason);
%                     true ->
%                         send_prompt(PS, "猪神战场已结束");
%                     _ ->
%                         send_prompt(PS, "异常错误！")
%                 end;

%             %% 清理诸神战场
%             ["@clear_zc"]->
%                 case handle_gm_cmd(clear_gods_pvp, PS) of
%                     {false, Reason} ->
%                         send_prompt(PS, Reason);
%                     true ->
%                         send_prompt(PS, "猪神战场已清理");
%                     _ ->
%                         send_prompt(PS, "异常错误！")
%                 end;


% %% ---------- 在线竞技场能操作 ------------------
%             %% 开启竞技场
%             ["@start_arena"]->
%                 case handle_gm_cmd(start_online_arena, PS) of
%                     {false, Msg} ->
%                         send_prompt(PS, Msg);
%                     true ->
%                         send_prompt(PS, "在线竞技场马上开启!");
%                     _ ->
%                         send_prompt(PS, "异常错误！")
%                 end;

%             %% 关闭竞技场
%             ["@stop_arena"]->
%                 case handle_gm_cmd(stop_online_arena, PS) of
%                     {false, Reason} ->
%                         send_prompt(PS, Reason);
%                     true ->
%                         send_prompt(PS, "在线竞技场已结束");
%                     _ ->
%                         send_prompt(PS, "异常错误！")
%                 end;

%             %% 清理竞技场
%             ["@clear_arena"]->
%                 case handle_gm_cmd(clear_online_arena, PS) of
%                     {false, Reason} ->
%                         send_prompt(PS, Reason);
%                     true ->
%                         send_prompt(PS, "在线竞技场已清理");
%                     _ ->
%                         send_prompt(PS, "异常错误！")
%                 end;
% %% ---------- 灵木操作 ------------------
%             ["@tree_init"] ->
%                 handle_gm_cmd(tree_init, PS);
%             ["@tree_times", Num] ->
%                 handle_gm_cmd(tree_times, {PS, Num});
%             ["@tree_water", Type, Num] ->
%                 handle_gm_cmd(tree_water, {PS, Type, Num});

%             ["@lv", NewLv] ->  % 设置等级
%                 handle_gm_cmd(set_lv, {PS, PS, NewLv, 0});
%             ["@lv", NewLv, PlayerId]  ->  % 设置等级
%                 case gm_get_player_status(PlayerId, PS) of
%                     [] ->
%                         send_prompt(PS, "玩家选择错误");
%                     PS1 ->
%                         handle_gm_cmd(set_lv, {PS, PS1, NewLv, 0})
%                 end;
%             ["@exp", Exp] ->   % 加经验
%                 handle_gm_cmd(add_exp, {PS, Exp});
%             ["@hp", Hp] ->     % 设置当前气血
%                 handle_gm_cmd(hp, {PS, Hp});
%             ["@partner", ParTypeId, ParLv] ->  % 获得武将
%                 handle_gm_cmd(get_partner, {PS, ParTypeId, ParLv});
%             ["@set_par_lv", ParTypeId, NewLv] ->  % 设置指定武将的等级
%                 handle_gm_cmd(set_partner_lv, {PS, ParTypeId, NewLv});
% 			["@par_exp", ParTypeId, Exp] ->
% 				handle_gm_cmd(par_exp, {PS, ParTypeId, Exp});
%             ["@troop", TroopTypeId, TroopLv] ->  % 学习阵法
%                 handle_gm_cmd(learn_troop, {PS, TroopTypeId, TroopLv});

%             ["@get_gs_stati"] ->  % 获取全服的一些统计数据
%                 handle_gm_cmd(get_gs_stati, PS);

%             ["@get_zt_mat_drop_rate", GoodsTypeId] ->  % 获取战天材料的掉落概率
%                 handle_gm_cmd(get_zt_mat_drop_rate, {PS, GoodsTypeId});
%             ["@get_th_state"] ->  % 获取藏宝阁状态
%                 handle_gm_cmd(get_trea_house_state, PS);
%             ["@add_th_acc_points", AddPoints] ->  % 添加藏宝阁的积分
%                 handle_gm_cmd(add_trea_house_acc_points, {PS, AddPoints});
%             ["@clear_th_buy_logs"] ->  % 清除藏宝阁的购买记录
%                 handle_gm_cmd(clear_trea_house_buy_logs, PS);
%             ["@set_ar_acc_points", AccPoints] ->  % 设置竞技场的积分
%                 handle_gm_cmd(set_ar_acc_points, {PS, AccPoints});
%             ["@clear_ar_already_chal_times"] ->  % 清零竞技场当天已挑战的次数
%                 handle_gm_cmd(clear_ar_already_chal_times, PS);

%             ["@trea_goods", Num] ->   % 向淘宝仓库增加Num个格子的物品
%                 handle_gm_cmd(trea_goods, {PS, Num});

%             ["@getname", PlayerId] ->
%                 case lib_player:get_role_name_by_id(PlayerId) of
%                     [] ->
%                         send_prompt(PS, "玩家id错误");
%                     Name ->
%                         send_prompt(PS, Name)
%                 end;
%             ["@getid", PlayerName] ->
%                 Name = tool:to_list(PlayerName),
%                 send_prompt(PS, lib_player:get_role_id_by_name(Name));
%             ["@setname", PlayerId, PlayerName]->
%                 Name = tool:to_list(PlayerName),
%                 case pp_account:validate_name(Name) of
%                     true ->
%                         %直接修改数据库
%                         case lib_player:rename(PlayerId, Name) of
%                             0 ->
%                                 send_prompt(PS, "玩家选择错误");
%                             _R ->
%                                 ok
%                         end,
%                         %如果玩家在线的话更新缓存
%                         case gm_get_player_status(PlayerId, PS) of
%                             [] ->
%                                 skip;
%                             PS1 ->
%                                 handle_gm_cmd(rename, {PS, PS1, Name})
%                         end,
%                         send_prompt(PS, "修改成功");
%                     {false, Msg} ->
%                         send_prompt(PS, Msg)
%                 end;
%             ["@setpos", PlayerId]->
%                 case gm_get_player_status(PlayerId, PS) of
%                     [] ->
%                         send_prompt(PS, "玩家不存在");
%                     PS1 ->
%                         handle_gm_cmd(move_scene, {PS, PS1})
%                 end;
%             ["@goto", Sid]->
%                 handle_gm_cmd(move_scene, {goto, PS, Sid});
%             ["@gotoout"]->
%                 handle_gm_cmd(move_scene, {gotoout, PS});
%             ["@stren_goods", GoodsTId, Stren] ->
%                 handle_gm_cmd(stren_goods, {PS, GoodsTId, Stren});
%             ["@kickout", PlayerId]->
%                 case gm_get_player_status(PlayerId, PS) of
%                     [] ->
%                         send_prompt(PS, "玩家不存在");
%                     PS1 ->
%                         mod_login:logout(PS1#player_status.pid)
%                 end;
%             ["@passfinish", PlayerId]->
%                 case gm_get_player_status(PlayerId, PS) of
%                     [] ->
%                         handle_gm_cmd(pass_finish, PlayerId);
%                     PS1 ->
%                         handle_gm_cmd(pass_finish, PS1)
%                 end,
%                 send_prompt(PS, "操作已响应");
%             ["@passfinish"]->
%                 handle_gm_cmd(pass_finish, PS),
%                 send_prompt(PS, "操作已响应");
%             ["@passinit", PlayerId]->
%                 case gm_get_player_status(PlayerId, PS) of
%                     [] ->
%                         handle_gm_cmd(pass_init, PlayerId);
%                     PS1 ->
%                         handle_gm_cmd(pass_init, PS1)
%                 end,
%                 send_prompt(PS, "操作已响应");
%             ["@passinit"]->
%                 handle_gm_cmd(pass_init, PS),
%                 send_prompt(PS, "操作已响应");
%             ["@passreset"]->
%                 handle_gm_cmd(pass_reset, PS),
%                 send_prompt(PS, "操作已响应");


%             ["@ms", Val]->
%                 handle_gm_cmd(immediate_kill_mon, {PS, Val});
%             ["@task", Tid]->
%                 handle_gm_cmd(task, {PS, Tid});
%             ["@task_giveup", Tid]->
%                 handle_gm_cmd(task_giveup, {PS, Tid});
%             ["@task_init"]->
%                 handle_gm_cmd(task_init, PS);
%             ["@task_trigger", Tid]->
%                 handle_gm_cmd(task_trigger, {PS, Tid});
%             ["@get_task_state"] ->
%                 handle_gm_cmd(get_task_state, PS);
%             ["@fresh", State] ->
%                 handle_gm_cmd(fresh_meat, {PS, State});
%             ["@startgwar"]->
%                 case handle_gm_cmd(start_ghost_war, PS) of
%                     {false, no_guild} ->
%                         send_prompt(PS, "请先建帮会或入帮会！");
%                     {false, area_lv_too_small} ->
%                         send_prompt(PS, "帮会领域没在青铜区以上,无法开始!");
%                     true ->
%                         send_prompt(PS, "开始妖魔反攻!");
%                     _ ->
%                         send_prompt(PS, "异常错误！")
%                 end;
%             ["@stopgwar"]->
%                 case handle_gm_cmd(stop_ghost_war, PS) of
%                     {false, no_guild} ->
%                         send_prompt(PS, "请先建帮会或入帮会！");
%                     {false, area_lv_too_small} ->
%                         send_prompt(PS, "帮会领域没在青铜区以上,无法开始!");
%                     true ->
%                         send_prompt(PS, "停止妖魔反攻!");
%                     _ ->
%                         send_prompt(PS, "异常错误！")
%                 end;
%             ["@soulpower", Val] -> % 修改战魂值
%                 handle_gm_cmd(change_soul_power, {PS, Val});
%             ["@power", Val] -> % 修改体力值
%                 handle_gm_cmd(change_power, {PS, Val});
%             ["@anger", Val] -> % 修改怒气值
%                 handle_gm_cmd(change_anger, {PS, Val});
%             ["@arousal", Val] -> % 修改觉醒值
%                 handle_gm_cmd(change_arousal, {PS, Val});
%             ["@bo_info", BattleObjId] -> % 查看战斗对象的信息（战斗中使用）
%                 handle_gm_cmd(query_bo_info, {PS, BattleObjId});
%             ["@battle", MonId] -> % 查看战斗对象的信息（战斗中使用）
%                 handle_gm_cmd(battle, {PS, MonId});

%             ["@nbpvp"]->
%                 case handle_gm_cmd(notice_broadcast_pvp, PS) of
%                     {false, Msg} ->
%                         send_prompt(PS, Msg);
%                     true ->
%                         send_prompt(PS, "每分钟全服通知PVP一次准备成功!");
%                     _ ->
%                         send_prompt(PS, "异常错误！")
%                 end;
%             ["@spvp"]->
%                 case handle_gm_cmd(start_guild_pvp, PS) of
%                     {false, Msg} ->
%                         send_prompt(PS, Msg);
%                     true ->
%                         send_prompt(PS, "开始帮派PVP!");
%                     _ ->
%                         send_prompt(PS, "异常错误！")
%                 end;
%             ["@rbpvp"]->
%                 case handle_gm_cmd(refresh_guild_pvp_buff, PS) of
%                     {false, Msg} ->
%                         send_prompt(PS, Msg);
%                     true ->
%                         send_prompt(PS, "刷新帮派PVP中BUFF成功!");
%                     _ ->
%                         send_prompt(PS, "异常错误！")
%                 end;
%             ["@nepvp"]->
%                 case handle_gm_cmd(notice_end_guild_pvp, PS) of
%                     {false, Msg} ->
%                         send_prompt(PS, Msg);
%                     true ->
%                         send_prompt(PS, "通知还有5分钟结束PVP成功!");
%                     _ ->
%                         send_prompt(PS, "异常错误！")
%                 end;
%             ["@epvp"]->
%                 case handle_gm_cmd(stop_guild_pvp, PS) of
%                     {false, Msg} ->
%                         send_prompt(PS, Msg);
%                     true ->
%                         send_prompt(PS, "停止帮派PVP!");
%                     _ ->
%                         send_prompt(PS, "异常错误！")
%                 end;
%             ["@cpvp"]->
%                 case handle_gm_cmd(clear_guild_pvp, PS) of
%                     {false, Msg} ->
%                         send_prompt(PS, Msg);
%                     true ->
%                         send_prompt(PS, "清除帮派PVP所有信息!");
%                     _ ->
%                         send_prompt(PS, "异常错误！")
%                 end;

%             ["@nrpvp"]->
%                 case handle_gm_cmd(notice_ready_guild_pvp, PS) of
%                     {false, Msg} ->
%                         send_prompt(PS, Msg);
%                     true ->
%                         send_prompt(PS, "通知准备帮派PVP成功!");
%                     _ ->
%                         send_prompt(PS, "异常错误！")
%                 end;

%             ["@power_buff", Val] -> % 增加体力buff
%                 handle_gm_cmd(power_buff, {PS, Val});

%             ["@get_line"] -> % 获得当前场景分线
%                 handle_gm_cmd(get_line, PS);

%             ["@set_line", Val] -> % 设置当前场景分线
%                 handle_gm_cmd(set_line, {PS, Val});
%             ["@refresh_shop"] -> % 商城特价区物品刷新
%                 handle_gm_cmd(refresh_shop, PS);
%             ["@change_b_num", Type, Num] -> % 商城特价区物品数量改变
%                 handle_gm_cmd(change_b_num, {PS, Type, Num});

%             ["@change_g_pres", Val] -> % 设置帮会声望
%                 handle_gm_cmd(change_g_pres, {PS, Val});

%             ["@sign_cl"] -> % 今日签到记录清除
%                 handle_gm_cmd(sign_cl, PS);
%             ["@collect_cl"] -> % 今日采集次数恢复清零
%                 handle_gm_cmd(collect_cl, PS);
%             ["@change_wood", Val] -> % 改变当前帮会木材数量
%                 handle_gm_cmd(change_wood, {PS, Val});
%             ["@change_stone", Val] -> % 改变当前帮会石料数量
%                 handle_gm_cmd(change_stone, {PS, Val});
%             ["@impeach", ChiefName] -> % 将下线帮主改为可以弹劾状态
%                 handle_gm_cmd(impeach_chief, {PS, ChiefName});
%             ["@distime", Val] -> % 帮会解散剩余时间
%                 handle_gm_cmd(distime, {PS, Val});
%             ["@sxyc"] -> % 开始许愿池
%                 handle_gm_cmd(sxyc, PS);
%             ["@txyc"] -> % 停止许愿池
%                 handle_gm_cmd(txyc, PS);
% 			["@trevi_xcoin", Num] -> %设置许愿池星币个数
% 				handle_gm_cmd(trevi_xcoin, {PS, Num});
% 			["@rich", Val] ->
%                 handle_gm_cmd(rich, {PS, Val});
% 			["@richcount"] ->
%                 handle_gm_cmd(richcount, PS);
% 			["@achi", Val] ->
%                 handle_gm_cmd(achi, {PS, Val});
% 			["@openrwalk", Val] ->
%                 handle_gm_cmd(rich_walk, {PS, Val});
% 			["@rwalk", Val] ->
%                 handle_gm_cmd(rich_walk1, {PS, Val});
%             ["@socket", Cmd, Bin] -> % 协议测试
%                 handle_gm_cmd(socket, {PS, Cmd, Bin});
% 			["@clear_group", Time] ->  %群成员清理
% 				handle_gm_cmd(group, {Time});
% 			["@guild_boss_start"] ->  %帮派boss开启
% 				handle_gm_cmd(guild_boss_start, PS);
% 			["@world_boss_start"] ->  %世界boss开启
% 				handle_gm_cmd(world_boss_start, PS);
% 			["@world_boss_hp", Hp] ->  %世界boss血量调整
% 				handle_gm_cmd(world_boss_hp, {PS,Hp});
% 			["@guild_boss_hp", Hp] ->  %帮派boss血量调整
% 				handle_gm_cmd(guild_boss_hp, {PS,Hp});
% 			["@world_boss_hurt", Hp] ->  %世界boss伤害
% 				handle_gm_cmd(world_boss_hurt, {PS,Hp});
% 			["@guild_boss_hurt", Hp] ->  %帮派boss伤害
% 				handle_gm_cmd(guild_boss_hurt, {PS,Hp});
% 			["@skill_book", PartnerId, BookId] ->  %学习武将技能书
% 				pp_skill:handle(21100, PS, [BookId, PartnerId]);

% 			["@ven_lv", Lv] ->  %改变灵穴等级
% 				handle_gm_cmd(ven_lv, {PS, Lv});
% 			["@ven_rank", Rank] ->  %改变灵穴等级
% 				handle_gm_cmd(ven_rank, {PS, Rank});

% 			["@single", Time] ->  %设置单修时间
% 				handle_gm_cmd(single, {PS, Time});
% 			["@ring", Num] ->
% 				handle_gm_cmd(ring, {PS, Num});
% 			["@t_boss", Num] ->
% 				handle_gm_cmd(t_boss, {PS, Num});
% 			["@cyc", Id] ->
% 				handle_gm_cmd(cyc, {PS, Id});

% 			["@p_e", PartnerId, Num] ->
% 				handle_gm_cmd(energy, {PS, PartnerId, Num});
% 			["@b_e", PartnerId] ->
% 				handle_gm_cmd(battle_energy, {PS, PartnerId});
% 			["@recharge", Num] ->  %% 充值
% 				handle_gm_cmd(recharge, {PS, Num});
% 			["@identity", Num] ->  %% 设置身份
% 				handle_gm_cmd(identity, {PS, Num});
% 			["@set_skill_point", Num] ->  %% 设置技能点
% 				handle_gm_cmd(set_skill_point, {PS, Num});
% 			["@affiche", Content, Type, Times, Interval] ->  %% 即时公告
% 				handle_gm_cmd(affiche, {PS, Content, Type, Times,  Interval});
% 			["@affiche", Content, Type, Interval, Time1, Time2] ->  %% 定时公告
% 				handle_gm_cmd(affiche, {PS, Content, Type, Interval, Time1, Time2});
%             _ ->
%                 ?TRACE("other msg ;;;~p~n", [ChatMsg]),
%                 skip
%         end,
%     case Reply of
%         {ok, PS2} when is_record(PS2, player_status) ->
%             handle_chat_msg_as_gm_cmd(PS2, T);
%         _ ->
%             handle_chat_msg_as_gm_cmd(PS, T)
%     end.

% %%公告
% handle_gm_cmd(affiche, {PS, Content, Type, Interval, Time1, Time2}) ->
% 	Now = util:unixtime(),
% 	T1 = Now + Time1,
% 	T2 = T1 + Time2,
% 	Bin = tool:to_binary(Content),
% 	MsgId = db:insert_get_id(t_broadcast,
% 					 [type, msg_type, start_time, end_time, times, interval, content, min_lv, max_lv, admin_name, update_time],
% 					 [Type, 1, T1, T2, 0, Interval, Bin, 0, 0, "", Now]),
% 	Pid = misc:whereis_name({global, ?GLOBAL_AFFICHE}),
% 	Pid ! {'add_affiche', MsgId},
% 	send_prompt(PS, <<"设置成功">>);

% handle_gm_cmd(affiche, {PS, Content, Type, Times, Interval}) ->
% 	Now = util:unixtime(),
% 	Bin = tool:to_binary(Content),
% 	MsgId = db:insert_get_id(t_broadcast,
% 					 [type, msg_type, start_time, end_time, times, interval, content, min_lv, max_lv, admin_name, update_time],
% 					 [Type, 0, 0, 0, Times, Interval, Bin, 0, 0, "", Now]),
% 	Pid = misc:whereis_name({global, ?GLOBAL_AFFICHE}),
% 	Pid ! {'add_affiche', MsgId},
% 	send_prompt(PS, <<"设置成功">>);


% %%设置剩余技能点
% handle_gm_cmd(set_skill_point, {PS, Num}) ->
% 	if Num >=0 ->
% 		   send_prompt(PS, <<"设置成功">>),
% 		   NewStatus = PS#player_status{skill_point = Num},
% 		   pp_skill:handle(21001,NewStatus,[]),
% 		   {ok, NewStatus};
% 	   true ->
% 		   send_prompt(PS, <<"失败, 不能设为负数">>)
% 	end;

% %%设置身份
% handle_gm_cmd(identity, {PS, Num}) ->
% 	if Num > 2 orelse Num < 0 -> send_prompt(PS, <<"没有该身份值">>);
% 	   true -> F = fun() -> db:update(player, [{identity, 1}], [{id, PS#player_status.id}]) end,
% 			   spawn(F),
% 			   gen_server:cast(PS#player_status.pid, {'set_fresher_leader', 1}),
% 			   send_prompt(PS, <<"设置成功">>)
% 	end;

% %%充值
% handle_gm_cmd(recharge, {PS, Num}) ->
% 	Seed = util:rand(1000, 999999),
% 	case db:select_row(recharge, "order_id", [{order_id, Seed}]) of
% 		[] ->
% 			db:insert(recharge, [{order_id, Seed},
% 								 {role_id, PS#player_status.id},
% 								 {recharge, util:ceil(Num)}]),
% 			gen_server:cast(PS#player_status.pid, 'recharge');
% 		_ -> handle_gm_cmd(recharge, {PS, Num})
% 	end;

% %%设置战斗后武将精力
% handle_gm_cmd(battle_energy, {PS, PartnerId}) ->
% 	List = lib_partner:get_my_alive_partner_list(PS),
% 	F = fun(Par, R) ->
% 				if Par#ets_partner.par_type_id == PartnerId -> Par;
% 				   true -> R
% 				end
% 		end,
% 	Result = lists:foldl(F, [], List),
% 	lib_partner:battle_set_partner_energy(PS, [Result#ets_partner.id]),
% 	send_prompt(PS, <<"设置成功">>);

% %%设置武将精力值
% handle_gm_cmd(energy, {PS, PartnerId, Num}) ->
% 	if Num > 100 -> send_prompt(PS, <<"精力值不大于100">>);
% 	   true ->
% 			List = lib_partner:get_my_alive_partner_list(PS),
% 			F = fun(Par, R) ->
% 						if Par#ets_partner.par_type_id == PartnerId -> Par;
% 				   		true -> R
% 						end
% 				end,
% 			Result = lists:foldl(F, [], List),
% 			case Result of
% 				[] -> send_prompt(PS, <<"不存在该武将">>);
% 				_ -> ets:insert(?ETS_PARTNER_ALIVE, Result#ets_partner{energy_cur = Num}),
% 			 		send_prompt(PS, <<"设置成功">>)
% 			end
% 	end;

% %%指定循环任务
% handle_gm_cmd(cyc, {PS, Id}) ->
% 	case Id > 14 of
% 		true -> send_prompt(PS, <<"任务类型错误">>);
% 		_ -> lib_task_cyc:gm_create_task_cyc_ts_by_type(PS#player_status.id, PS#player_status.lv, Id),
% 			 send_prompt(PS, <<"设置成功">>)
% 	end;

% %%开启许愿池BOSS
% handle_gm_cmd(t_boss, {PS, Num}) ->
% 	Pid = misc:whereis_name({global, ?GLOBAL_TREVI_PROCESS}),
% 	case Num > 0 of
% 		true -> Pid ! 'make_boss';
% 		_ -> Pid ! 'prepare_boss',
% 			 Pid ! 'make_boss'
% 	end,
% 	send_prompt(PS, <<"设置成功">>);



% %%设置单修时间
% handle_gm_cmd(single, {PS, Time}) ->
% 	case PS#player_status.start_single_train_time of
% 		0 -> send_prompt(PS, <<"玩家没有进入单修状态">>);
% 		_ -> send_prompt(PS, <<"设置单修时间成功">>),
% 			 TrainTime = lib_shuangxiu:get_single_train_time(PS#player_status.vip),
% 			 NewTime = TrainTime - PS#player_status.start_single_train_time + Time,
% 			 {ok, PS#player_status{start_single_train_time = NewTime}}
% 	end;

% %% desc: 今日签到记录清除
% handle_gm_cmd(sign_cl, PS) ->
%     gen_server:cast({global, guild_p_100}, {apply_cast, guild_util, sign_cl, [PS]}),
%     send_prompt(PS, <<"签到清零指令已执行">>);

% %% desc: 今日采集次数恢复清零
% handle_gm_cmd(collect_cl, PS) ->
%     gen_server:cast({global, guild_p_100}, {apply_cast, guild_util, collect_cl, [PS]}),
%     send_prompt(PS, <<"采集清零指令已执行">>);

% %% desc: 改变木材数量
% handle_gm_cmd(change_wood, {PS, Val}) ->
%     gen_server:cast({global, guild_p_100}, {apply_cast, guild_util, change_wood_num, [PS, Val]}),
%     send_prompt(PS, <<"改变木材指令已执行">>);

% %% desc: 改变石料数量
% handle_gm_cmd(change_stone, {PS, Val}) ->
%     gen_server:cast({global, guild_p_100}, {apply_cast, guild_util, change_stone_num, [PS, Val]}),
%     send_prompt(PS, <<"改变石料指令已执行">>);

% %% desc: 将离线帮主改为可弹劾状态
% handle_gm_cmd(impeach_chief, {PS, ChiefName}) ->
%     guild_util:gm_impeach_offline_cheif_state(ChiefName),
% %%     gen_server:cast({global, guild_p_96}, {apply_cast, guild_util, gm_impeach_offline_cheif_state, [PS, ChiefName]}),
%     send_prompt(PS, <<"将离线帮主改为可弹劾状态指令已执行">>);

% %% desc: 修改帮会剩余解散时间
% handle_gm_cmd(distime, {PS, Val}) ->
%     gen_server:cast({global, guild_p_96}, {apply_cast, guild_util, gm_set_distime, [PS#player_status.guild_id, Val]}),
%     send_prompt(PS, <<"修改帮会剩余解散时间指令已执行">>);

% handle_gm_cmd(get_role_id, {PS, Name}) ->
%     ?TRACE("get_role_id:~p~n", [Name]),
%     case lib_player:get_role_id_by_name(Name) of
%         null ->
%             send_prompt(PS, <<"没有此人">>);
%         Id ->
%             send_prompt(PS, io_lib:format(<<"~s 的ID为:~p">>, [Name, Id]))
%     end;

% handle_gm_cmd(get_speed, PS) ->
% 	PromptMsg = io_lib:format(<<"当前速度：~p">>, [PS#player_status.speed]),
% 	send_prompt(PS, PromptMsg);

% handle_gm_cmd(set_speed, {PS, NewSpeed}) ->
% 	case is_integer(NewSpeed) andalso NewSpeed > 0 of
% 		false ->
% 			send_prompt(PS, "速度只能为大于0的整数");
% 		true ->
% 			send_prompt(PS, "设置速度成功，玩家默认速度为200，有必要记得改回来哦"),
% 			%% 广播
% 			NewPS = PS#player_status{speed = NewSpeed},
%     		{ok, BinData1} = pt_12:write(12010, [NewPS#player_status.id, NewPS#player_status.speed, NewPS#player_status.mount]),
%     		lib_send:send_to_area_scene(NewPS#player_status.scene, NewPS#player_status.line_id, NewPS#player_status.x, NewPS#player_status.y, BinData1),
% 			{ok, NewPS}
% 	end;

% handle_gm_cmd(get_time, PS) ->
% 	CurTime = mod_mytime:time(),
% 	PromptMsg = io_lib:format(<<"当前时间：~p">>, [CurTime]),
% 	send_prompt(PS, PromptMsg);

% handle_gm_cmd(get_online_num, PS) ->
%     Num = lib_player:get_online_num(),
%     PromptMsg = io_lib:format(<<"当前总人数：~p">>, [Num]),
% 	send_prompt(PS, PromptMsg);

% handle_gm_cmd(get_date, PS) ->
% 	CurDate = mod_mytime:date(),
% 	PromptMsg = io_lib:format(<<"当前日期：~p">>, [CurDate]),
% 	send_prompt(PS, PromptMsg);




% handle_gm_cmd(set_time, {PS, {Hour, Min, Sec}}) ->
% 	case check_time_format({Hour, Min, Sec}) of
% 		error ->
% 			send_prompt(PS, "时间错误，正确格式：set_time 时 分 秒，如：set_time 0 0 0");
% 		ok ->
% 			case mod_mytime:set_time({Hour, Min, Sec}) of
% 				fail ->
% 					send_prompt(PS, "设置时间失败，请重试");
% 				ok ->
% 					% 处理所有的定时计划任务
% 					retrigger_all_time_schedule(),
% 					send_prompt(PS, "设置时间成功")
% 			end
% 	end;

% handle_gm_cmd(set_date, {PS, {Year, Month, Day}}) ->
% 	case check_date_format({Year, Month, Day}) of
% 		error ->
% 			send_prompt(PS, "日期错误，正确格式：set_date 年 月 日，如：set_date 2012 1 1");
% 		ok ->
% 			case mod_mytime:set_date({Year, Month, Day}) of
% 				fail ->
% 					send_prompt(PS, "设置日期失败，请重试");
% 				ok ->
% 					% 处理所有的定时计划任务
% 					retrigger_all_time_schedule(),
% 					send_prompt(PS, "设置日期成功")
% 			end
% 	end;

% handle_gm_cmd(normalize_time, PS) ->
% 	case mod_mytime:normalize_time() of
% 		fail ->
% 			send_prompt(PS, "恢复失败，请重试");
% 		ok ->
% 			send_prompt(PS, "时间和日期已恢复正常")
% 	end;


% handle_gm_cmd(add_skill, {PS, [], _}) ->
% 	{ok, PS};
% handle_gm_cmd(add_skill, {PS, [SkillId|T], SkillLv}) ->
% 	SkillInfo = data_skill:get(SkillId, SkillLv),
% 	SkillList = data_skill:get_skill_ids(PS#player_status.career),
% 	CanStudy = lists:member(SkillId, SkillList),
% 	if
% 		SkillInfo =:= [] ->
% 			send_prompt(PS, "没有这个技能");
% 		CanStudy =:= false ->
% 			send_prompt(PS, "该玩家没这个技能!");
% 		true ->
%             NewSLv = case SkillInfo#ets_skill.data =:= [] of
%                 true -> lib_skill:get_max_lv(SkillId);
%                 false -> SkillLv
%             end,
% 			NewPS = case lists:keyfind(SkillId, 1, PS#player_status.skill) of
% 						false ->
% 							% 未学过，添加
% 							add_new_skill(SkillInfo, PS, NewSLv),
% 							NewSkill = [{SkillId, NewSLv, 0} | PS#player_status.skill],
% 							PS#player_status{skill = NewSkill};
% 						{_Id, _Lv, Equip} ->
% 							lib_skill:update_skill_lv(SkillId, PS#player_status.id, NewSLv),
% 							NewSkill = lists:keyreplace(SkillId, 1, PS#player_status.skill, {SkillId, NewSLv, Equip}),
% 							PS#player_status{skill = NewSkill};
% 						_ ->
% 							PS
% 					end,
% 			%% 更新玩家状态
% 			send_prompt(PS, "技能增加技能 " ++ binary_to_list(SkillInfo#ets_skill.name) ++ " 成功!"),
% 			%% 通知客户端更新
% %			{ok,Bdata} = pt_21:write(21002, [1, SkillId, PS#player_status.coin, PS#player_status.soul_power]),
% %			lib_send:send_one(PS#player_status.socket,Bdata),
% 			%% 自动安装技能
% %			Equip1 = lib_skill:get_cell(PS#player_status.career, SkillId),
% %			{ok, NewPS1} = pp_skill:handle(21003, NewPS, [SkillId, Equip1]),
% 			%% 刷新客户端
% %        	{ok, NewPS2} = pp_skill:handle(21001,NewPS,[]),
% 			handle_gm_cmd(add_skill, {NewPS, T, SkillLv})
% 	end;

% %% 学习自身拥用的所有技能
% handle_gm_cmd(add_all_skill,{PS, Lv} ) ->
%     Skills = data_skill:get_skill_ids(PS#player_status.career),
%     handle_gm_cmd(add_skill, {PS, Skills, Lv});



% %% 清除玩家在单天限制次数的一些游戏玩法中的次数记录（比如：当天进入组队关卡的次数记录）
% handle_gm_cmd(clear_one_day_times_log, PS) ->
%     NewPS = PS#player_status{times_log = #role_times_log{}},
%     send_prompt(PS, "清除成功"),
%     {ok, NewPS};


% %% internal
% %% desc: 杀死战斗中指定的怪（目前对组队无效）
% handle_gm_cmd(battle_smash, {PS, X, Y}) ->
%     case lib_player:is_in_battle(PS) of
%         true -> % 玩家用自己的战斗进程
%             case is_integer(X) andalso is_integer(Y) andalso X >= 0 andalso Y >= 0 of
%                 true ->
%                     BattlePid = PS#player_status.cur_bid,
%                     gen_server:cast(BattlePid, {'GM_CMD_SMASH', PS, X, Y}),
%                     send_prompt(PS, "该指令在下一个倒计时时生效");
%                 false ->
%                     send_prompt(PS, "本次使用的指令无效: X Y 输入有误")
%             end;
%         false ->
%             send_prompt(PS, "本次使用的指令无效: 目前该指令对   非战斗中   无效")
%     end,
%     {ok, PS};

% %% internal
% %% desc: 将自己设为无敌状态，即最后一点血保持固定，显示掉血状态按正常流程
% handle_gm_cmd(battle_invincible, [PS, X]) ->
%     case lib_player:is_in_battle(PS) andalso lists:member(X, [0, 1]) of
%         true ->
%             BattlePid = PS#player_status.cur_bid,   % 查询当前战斗用的进程pid
%             gen_server:cast(BattlePid, {'GM_CMD_INVINCIBLE', PS#player_status.id, X}),
%             send_prompt(PS, "该指令已生效");
%         false ->
%             send_prompt(PS, "本次使用的指令无效: 目前该指令对   非战斗中  无效")
%     end,
%     {ok, PS};

% %% internal
% %% @desc: 和在线的某人进行pk
% handle_gm_cmd(battle_online_pk, [PS, Name]) ->
%     case lib_player:get_role_id_by_name(Name) of
%         Id when is_integer(Id), Id > 0 ->
%             NewDict =
%                 case lib_battle:get_dict_gm_before_battle() of
%                     undefined -> #gm_before_battle{pk_state = ?TURN_ON};
%                     Dict -> Dict#gm_before_battle{pk_state = ?TURN_ON}
%                 end,
%             lib_battle:set_dict_gm_before_battle(NewDict),
%             pp_battle:handle(20002, PS, Id);
%         _ ->
%             send_prompt(PS, "该玩家不存在或不在线")
%     end;
% handle_gm_cmd(battle_offline_pk, [PS, Name]) ->
%     case lib_player:get_role_id_by_name(Name) of
%         TargetId when is_integer(TargetId), TargetId > 0 ->
%             Target =
%             case mod_arena:rpc_get_player_from_global_cache(TargetId) of
%                 null ->
%                     case lib_player:db_load_offline_player_to_cache(TargetId) of   % 从离线缓存取数据
%                         {ok, TargetState} ->        TargetState;
%                         {fail} ->                        []
%                     end;
%                 TargetState -> TargetState
%             end,
%             mod_battle:pk_offline(PS#player_status.bid, [PS, Target], ?BAT_SUB_T_WANTED_PK_OFFLINE),
%             NewStatus = lib_player:enter_battle(PS, PS#player_status.bid),
%             {ok, NewStatus};
%         _ ->
%             send_prompt(PS, "该玩家不存在或不在线")
%     end;
% handle_gm_cmd(battle_set_hp, {PS, X, Y, Hp}) ->
%     case lib_player:is_in_battle(PS) andalso lib_player:is_in_team(PS) == false of
%         true ->
%             BattlePid = PS#player_status.cur_bid,
%             gen_server:cast(BattlePid, {'GM_SET_HP', PS, X, Y, Hp}),
%             send_prompt(PS, "该指令在下一个倒计时时生效");
%         false ->
%             send_prompt(PS, "本次使用的指令无效: 目前该指令对   非战斗中   和对   组队   无效")
%     end;

% handle_gm_cmd(battle_set_trace, [PS, Num]) ->
%     case lib_player:is_in_battle(PS) of
%         true ->
%             BattlePid = PS#player_status.cur_bid,
%             Type = case Num of
%                          1 -> on;
%                          _ -> off
%                      end,
%             BattlePid ! {'GM_CMD_SET_BATTLE_TRACE', Type, PS#player_status.sid},
%             send_prompt(PS, "该指令在下一个倒计时时生效");
%         false ->
%             send_prompt(PS, "本次使用的指令无效: 目前该指令对   非战斗中   无效")
%     end;


% %% 完成指定关卡
% handle_gm_cmd(pass_finish, Id) when is_integer(Id)->
% 	LevelL = lists:seq(1000, 2700, 100),%%如果关卡列表变化了这里也需要做相应的变化
% 	PL = lists:flatten([data_pass:get_id_list(L)||L<-LevelL]),
% 	F = fun(PassId)->
% 		db:insert(pass, [player_id, pass_id, times], [Id, PassId, 0])
% 	end,
% 	lists:foreach(F, PL);

% handle_gm_cmd(pass_finish, PS) when is_record(PS, player_status)->
% 	F0 = fun(PassId)->
% 				 gen_server:call(PS#player_status.pass_pid, {'UpdatePass', PassId,0,0,0, PS})
% 		 end,
% 	F = fun(LevelId)->
% 				PL = data_pass:get_id_list(LevelId),
% 				lists:foreach(F0,PL)
% 		end,
% 	LevelL = lists:seq(1000, 2700, 100),%%如果关卡列表变化了这里也需要做相应的变化
% 	lists:map(F, LevelL);

% %% 初始化所有关卡
% handle_gm_cmd(pass_init, Id) when is_integer(Id)->
% 	lib_pass:delete_all_pass(Id);
% handle_gm_cmd(pass_init, PS) when is_record(PS, player_status)->
% 	gen_server:call(PS#player_status.pass_pid, {'InitPass', PS});


% %% 重置购买次数
% handle_gm_cmd(pass_reset, PS)->
% 	{ok, PS#player_status{pass_reset = {0,0}}};


% %% desc: 清除追缉玩家次
% handle_gm_cmd(clear_pvp, {PS, 0}) ->
%     case catch gen_server:call(pp_wanted:rand_pid(), {apply_call, wanted_util, clear_pve_times, [PS]}) of
%         true -> skip;
%         _ERR -> send_prompt(PS, "清PVE操作失败")
%     end,
%     case wanted_util:clear_pvp_times(PS) of
%         true -> send_prompt(PS, "操作成功");
%         false -> send_prompt(PS, "找不到追缉记录")
%     end;


% %% desc: 设置帮会贡献
% handle_gm_cmd(set_guild_contr, {PS, Val}) ->
%     case is_integer(Val) andalso Val > 0 of
%         true ->
%             case PS#player_status.guild_id > 0 of
%                 true ->
%                     gen_server:cast({global, guild_p_100}, {apply_cast, guild_util, gm_set_guild_contr, [PS, Val]}),
%                     send_prompt(PS, "操作已经响应");
%                 false ->
%                     send_prompt(PS, "您当前尚未加入帮会")
%             end;
%         false ->
%             send_prompt(PS, "请输入大于0的整数")
%     end;

% %% desc: 将自己设置为已入帮会12小时
% handle_gm_cmd(join_guild_time, PS) ->
%     case PS#player_status.guild_id > 0 of
%         false -> send_prompt(PS, "您当前尚未加入帮会");
%         true ->
%             case guild_util:gm_change_join_time(PS) of
%                 fail -> send_prompt(PS, "修改失败");
%                 ok -> send_prompt(PS, "修改成功")
%             end
%     end;

% %% desc: 设置自己的帮会等级
% handle_gm_cmd(guildlv, {PS, Lv}) ->
%     case PS#player_status.guild_id > 0 of
%         false -> send_prompt(PS, "您当前尚未加入帮会");
%         true ->
%             if
%                 is_integer(Lv) =:= false orelse Lv > 5 orelse Lv =< 0 ->
%                     send_prompt(PS, "输入的帮会等级不正确，请输入1-5的整数");
%                 true ->
%                     guild_util:gm_set_guild_lv(PS, Lv),
%                     send_prompt(PS, "操作已响应")
%             end
%     end;

% %% 帮派BOSS开战
% handle_gm_cmd(guild_boss_start, PS) ->
% 	mod_guild_boss:gm_start_boss(),
% 	send_prompt(PS, "操作已响应");

% %% 世界BOSS开战
% handle_gm_cmd(world_boss_start, PS) ->
% 	mod_mon_world_timer:gm_start_boss(),
% 	send_prompt(PS, "操作已响应");

% %% 世界BOSS血量调整
% handle_gm_cmd(world_boss_hp, {PS, Hp}) ->
% 	Name = ?G_MON_WORLD,
% 	mod_mon_world:gm_boss_hp(PS,Hp,Name),
% 	send_prompt(PS, "操作已响应");

% %% 帮派BOSS血量调整
% handle_gm_cmd(guild_boss_hp, {PS,Hp}) ->
% 	Name = misc:create_process_name(guild_boss, [PS#player_status.guild_id]),
% 	mod_mon_world:gm_boss_hp(PS,Hp,Name),
% 	send_prompt(PS, "操作已响应");

% %% 世界BOSS伤害
% handle_gm_cmd(world_boss_hurt, {PS,Hp}) ->
% 	Name = ?G_MON_WORLD,
% 	mod_mon_world:gm_boss_hurt(PS,Hp,Name),
% 	send_prompt(PS, "操作已响应");

% %% 帮派BOSS伤害
% handle_gm_cmd(guild_boss_hurt, {PS,Hp}) ->
% 	Name = misc:create_process_name(guild_boss, [PS#player_status.guild_id]),
% 	mod_mon_world:gm_boss_hurt(PS,Hp,Name),
% 	send_prompt(PS, "操作已响应");

% %% 设置帮会区域
% handle_gm_cmd(guildarea, {PS, Val1, Val2}) when is_record(PS, player_status)->
% 	gen_server:call({global, guild_p_100}, {apply_call, lib_gm, set_guild_area, [PS, Val1, Val2]});

% %% 帮战完成到第几层
% handle_gm_cmd(g_war_to_floor, {PS, _Val}) when is_record(PS, player_status)->
%     skip;
% %% 	gen_server:call({global, guild_p_100}, {apply_call, lib_gm, guild_war_to_floor, [PS, Val]});

% %% 帮战失败
% handle_gm_cmd(g_war_lost, PS) when is_record(PS, player_status)->
% 	gen_server:call({global, ?GLOBAL_GUILD_WAR_PROCESS}, {apply_call, lib_gm, g_war_lost, [PS]});

% %% 清除帮战系统
% handle_gm_cmd(clear_g_war, PS) when is_record(PS, player_status)->
% 	gen_server:call({global, guild_p_100}, {apply_call, lib_gm, clear_g_war, [PS]});

% %% 帮战完成到第几层
% handle_gm_cmd(start_ghost_war, PS) when is_record(PS, player_status)->
% 	gen_server:call({global, guild_p_100}, {apply_call, lib_gm, start_ghost_war, [PS]});

% %% 帮战完成到第几层
% handle_gm_cmd(stop_ghost_war, PS) when is_record(PS, player_status)->
% 	gen_server:call({global, guild_p_100}, {apply_call, lib_gm, stop_ghost_war, [PS]});

% %% 通知帮会PVP
% handle_gm_cmd(notice_guild_pvp, PS) when is_record(PS, player_status)->
% 	gen_server:call(mod_guild_pvp:rand_pid(), {apply_call, lib_gm, notice_guild_pvp, [PS]});

% %% 通知广播帮会PVP
% handle_gm_cmd(notice_broadcast_pvp, PS) when is_record(PS, player_status)->
% 	gen_server:call(mod_guild_pvp:rand_pid(), {apply_call, lib_gm, notice_broadcast_pvp, [PS]});

% %% 开启诸神战场
% handle_gm_cmd(start_gods_pvp, PS) when is_record(PS, player_status)->
% 	gen_server:call(mod_gods_pvp:rand_pid(), {apply_call, lib_gm, start_gods_pvp, [PS]});

% %% 清理诸神战场
% handle_gm_cmd(end_gods_pvp, PS) when is_record(PS, player_status)->
% 	gen_server:call(mod_gods_pvp:rand_pid(), {apply_call, lib_gm, end_gods_pvp, [PS]});

% %% 停止诸神战场
% handle_gm_cmd(clear_gods_pvp, PS) when is_record(PS, player_status)->
% 	gen_server:call(mod_gods_pvp:rand_pid(), {apply_call, lib_gm, clear_gods_pvp, [PS]});

% %% 开启在线竞技场
% handle_gm_cmd(start_online_arena, PS) when is_record(PS, player_status)->
% 	gen_server:call({global,?GLOBAL_ONLINE_ARENA_PROCESS}, {apply_call, lib_gm, start_online_arena, [PS]});

% %% 清理在线竞技场
% handle_gm_cmd(clear_online_arena, PS) when is_record(PS, player_status)->
% 	gen_server:call({global,?GLOBAL_ONLINE_ARENA_PROCESS}, {apply_call, lib_gm, clear_online_arena, [PS]});

% %% 停止在线竞技场
% handle_gm_cmd(stop_online_arena, PS) when is_record(PS, player_status)->
% 	gen_server:call({global,?GLOBAL_ONLINE_ARENA_PROCESS}, {apply_call, lib_gm, stop_online_arena, [PS]});

% handle_gm_cmd(sxyc, PS) ->
%     gen_server:call({global, ?GLOBAL_TREVI_PROCESS}, {apply_call, lib_gm, start_trevi, [PS]}),
%     send_prompt(PS, <<"开始许愿池成功!">>);

% handle_gm_cmd(txyc, PS) ->
%     gen_server:call({global, ?GLOBAL_TREVI_PROCESS}, {apply_call, lib_gm, stop_trevi, [PS]}),
%     send_prompt(PS, <<"停止许愿池成功!">>);

% handle_gm_cmd(trevi_xcoin, {PS, Num}) ->
%     gen_server:call({global, ?GLOBAL_TREVI_PROCESS}, {apply_call, lib_gm, trevi_xcoin, [{PS, Num}]}),
%     send_prompt(PS, <<"设置许愿池星币成功!">>);

% handle_gm_cmd(socket, {PS, Cmd, Bin}) ->
%     mod_player:routing(Cmd, PS, Bin),
%     send_prompt(PS, <<"协议测试发送成功!">>);

% %% 开始帮会PVP
% handle_gm_cmd(start_guild_pvp, PS) when is_record(PS, player_status)->
% 	gen_server:call(mod_guild_pvp:rand_pid(), {apply_call, lib_gm, start_guild_pvp, [PS]});

% %% 刷新帮会PVP 中的BUFF成功
% handle_gm_cmd(refresh_guild_pvp_buff, PS) when is_record(PS, player_status)->
% 	gen_server:call(mod_guild_pvp:rand_pid(), {apply_call, lib_gm, refresh_guild_pvp_buff, [PS]});

% %% 通知PVP快结束了
% handle_gm_cmd(notice_end_guild_pvp, PS) when is_record(PS, player_status)->
% 	gen_server:call(mod_guild_pvp:rand_pid(), {apply_call, lib_gm, notice_end_guild_pvp, [PS]});

% %% 停止帮会PVP
% handle_gm_cmd(stop_guild_pvp, PS) when is_record(PS, player_status)->
% 	gen_server:call(mod_guild_pvp:rand_pid(), {apply_call, lib_gm, stop_guild_pvp, [PS]});

% %% 清除帮会PVP
% handle_gm_cmd(clear_guild_pvp, PS) when is_record(PS, player_status)->
% 	gen_server:call(mod_guild_pvp:rand_pid(), {apply_call, lib_gm, clear_guild_pvp, [PS]});

% %% 通知准备帮会PVP
% handle_gm_cmd(notice_ready_guild_pvp, PS) when is_record(PS, player_status)->
% 	gen_server:call(mod_guild_pvp:rand_pid(), {apply_call, lib_gm, notice_ready_guild_pvp, [PS]});

% %% 秒杀怪
% handle_gm_cmd(immediate_kill_mon, {PS, Val}) when is_record(PS, player_status)->
% 	case Val of
% 		0 ->
% 			send_prompt(PS, "设置成功"),
% 			{ok,PS#player_status{immediate_kill_mon = false}};
% 		1 ->
% 			send_prompt(PS, "设置成功"),
% 			{ok,PS#player_status{immediate_kill_mon = true}};
% 		_ ->
% 			send_prompt(PS, "参数格式不对，应为0或1")
% 	end;

% % 设置当前气血
% handle_gm_cmd(hp, {PS, Hp}) ->
% 	case is_integer(Hp) of
%         false ->
%         	send_prompt(PS, "血量不对");
%         true ->
%         	if
% 				Hp =< 0 ->
% 					send_prompt(PS, "血量不能为0或负数");
% 				true ->
% 					case lib_player:is_in_battle(PS) of
% 						true ->
% 							PS#player_status.cur_bid ! {'GM_CMD_SET_HP', PS#player_status.id, Hp},
% 							send_prompt(PS, "操作成功");
% 						false ->
% 							NewHp = case Hp > PS#player_status.hp_lim of
% 								true -> PS#player_status.hp_lim;
% 								false -> Hp
% 							end,
% 							NewStatus = PS#player_status{hp = NewHp},
% 							%%% 更新玩家状态
% 							%%gen_server:cast(PS#player_status.pid, {'SET_PLAYER', NewPS}),
% 							%%% 通知客户端更新
% 							%%lib_player:refresh_client(PS#player_status.id, ?REFRESH_ROLE_ATTRI),
% 							%%  广播给附近玩家
%     						{ok, BinData} = pt_12:write(12009, [NewStatus#player_status.id, NewStatus#player_status.hp, NewStatus#player_status.hp_lim, NewStatus#player_status.battle_capacity]),
%     						lib_send:send_to_area_scene(NewStatus#player_status.scene, NewStatus#player_status.line_id, NewStatus#player_status.x, NewStatus#player_status.y, BinData),
% 							send_prompt(NewStatus, "操作成功"),
% 							{ok, NewStatus}
% 					end
% 			end
% 	end;

% %%更新玩家的名字缓存
% %%PS是GM、PS1是被改名的人
% handle_gm_cmd(rename, {PS, PS1, Name})->
% 	case is_list(Name) of
% 		false ->
% 			send_prompt(PS, "名字输入有误");
% 		true ->
% 			gen_server:cast(PS1#player_status.pid, {'Name', Name})
% 	end,
% 	lib_player:refresh_client(PS1#player_status.id, ?REFRESH_ROLE_ATTRI);

% %% desc: 改变玩家淘宝仓库格子数
% handle_gm_cmd(trea_goods, {PS, Num}) ->
%     GoodsStatus = gen_server:call(?GET_GOODS_PID(PS), {'STATUS'}),
%     GoodsList = lists:duplicate(Num, {100102001, 1}),
%     NewGoodsStatus = goods_util:give_goods(?LOCATION_TREA, GoodsList, GoodsStatus),
%     gen_server:cast(?GET_GOODS_PID(PS), {'SET_STATUS', NewGoodsStatus }),
%     send_prompt(PS, "操作成功"),
%     pp_goods:handle(15010, PS, ?LOCATION_TREA);


% %% 设置声望值
% handle_gm_cmd(set_repu, {PS, NewRepu}) ->
% 	case is_integer(NewRepu) of
%         false ->
%         	send_prompt(PS, "声望值不对，须为整数");
%         true ->
%         	% 范围暂时限定为：0~2000000
%         	case util:is_in_range(NewRepu, 0, 2000000) of
%         		false ->
%         			send_prompt(PS, "声望值不对，范围应该是：0~2000000");
%         		true ->
%         			NewPS = PS#player_status{repu = NewRepu},
%         			lib_player:notify_player_attr_changed(NewPS),
%         			send_prompt(PS, "设置声望成功！"),
%             		{ok, NewPS}
%         	end
% 	end;


% %% 加钱
% handle_gm_cmd(add_coin, {PS0, PS, Val, Type}) ->
% 	case is_integer(Val) of
%         false ->
%         	send_prompt(PS0, "数量不对");
%         true ->
%             NewPS = case Type of
%                 coin ->
%                     lib_money:add_coin(PS, Val);  %%PS#player_status{coin = Val + PS#player_status.coin};
%                 gold ->
%                     lib_money:add_gold(PS, Val);  %%PS#player_status{gold = Val + PS#player_status.gold};
%                 bcoin ->
%                     lib_money:add_zt_money(PS, Val)  %%PS#player_status{bcoin = Val + PS#player_status.bcoin}
%             end,
%             send_prompt(PS0, "增加成功！"),
%             gen_server:cast(PS#player_status.pid, {'SET_PLAYER', NewPS})
% 	end;

% %% 加钱
% handle_gm_cmd(add_coin, {PS, Val, Type}) ->
% 	case is_integer(Val) of
%         false ->
%         	send_prompt(PS, "数量不对");
%         true ->
%             NewPS = case Type of
%                 coin ->
%                     lib_money:add_coin(PS, Val);  %%PS#player_status{coin = Val + PS#player_status.coin};
%                 gold ->
%                     lib_money:add_gold(PS, Val);  %%PS#player_status{gold = Val + PS#player_status.gold};
%                 bcoin ->
%                     lib_money:add_zt_money(PS, Val)  %%PS#player_status{bcoin = Val + PS#player_status.bcoin}
%             end,
%             send_prompt(PS, "增加成功！"),
%             %%lib_player:refresh_client(PS#player_status.id, ?REFRESH_BAG),
% 			{ok,NewPS}
% 	end;

% %% 加钱
% handle_gm_cmd(add_ubcoin, {PS, Val, Type}) ->
%     case is_integer(Val) of
%         false ->
%             send_prompt(PS, "数量不对");
%         true ->
%             NewPS = case Type of
%                         ubcoin ->
%                             lib_money:add_ubcoin(PS, Val);
%                         coin ->
%                             lib_money:add_coin(PS, Val);  %%PS#player_status{coin = Val + PS#player_status.coin};
%                         gold ->
%                             lib_money:add_gold(PS, Val);  %%PS#player_status{gold = Val + PS#player_status.gold};
%                         bcoin ->
%                             lib_money:add_zt_money(PS, Val)  %%PS#player_status{bcoin = Val + PS#player_status.bcoin}
%                     end,
%             send_prompt(PS, "增加成功！"),
%             %%lib_player:refresh_client(PS#player_status.id, ?REFRESH_BAG),
%             {ok,NewPS}
%     end;

% %% 加经验
% handle_gm_cmd(add_exp, {PS, ExpToAdd}) ->
% 	case is_integer(ExpToAdd) of
%         false ->
%         	send_prompt(PS, "经验不对");
%         true ->
%         	?ASSERT(is_integer(ExpToAdd)),
% 			if
% 				ExpToAdd =:= 0 ->
% 					send_prompt(PS, "经验不能为0");
% 				true ->
% 					CurLv_ExpLim = data_exp:get(PS#player_status.lv),
% 					NewExpToAdd = case ExpToAdd > CurLv_ExpLim of
% 						true -> CurLv_ExpLim;
% 						false -> ExpToAdd
% 					end,
% 					NewPS = lib_player:add_exp(PS, NewExpToAdd),
% 					%%lib_chat:send_sys_msg_one(PS#player_status.socket, RespMsg)
% 					lib_player:refresh_client(PS#player_status.id, ?REFRESH_ROLE_ATTRI),
% 					send_prompt(PS, "经验已增加"),
% 					{ok,NewPS}
% 			end
% 	end;

% %% 加战功值
% handle_gm_cmd(add_contrib, {PS, Val}) ->
%     case is_integer(Val) of
%         false ->
%             send_prompt(PS, "数量不对");
%         true ->
%             NewPS = lib_player:add_battle_contrib(PS, Val),
%             lib_player:notify_player_attr_changed(NewPS),
%             send_prompt(PS, "战功增加成功！"),
%             {ok,NewPS}
%     end;

% %% 加功勋值
% handle_gm_cmd(add_gongxun, {PS, Val}) ->
%     case is_integer(Val) of
%         false ->
%             send_prompt(PS, "数量不对");
%         true ->
%             NewPS = lib_player:add_gongxun(PS, Val),
%             lib_player:notify_player_attr_changed(NewPS),
%             send_prompt(PS, "功值增加成功！"),
%             {ok,NewPS}
%     end;


% %% 玩家0给玩家1设置等级
% handle_gm_cmd(set_lv, {PS0, PS, NewLv, _Task}) ->
% 	case is_integer(NewLv) of
%         false ->
%         	send_prompt(PS0, "等级不对");
%         true ->
%         	?ASSERT(is_integer(NewLv)),
% 			if
% 				NewLv =< 0 ->
% 					send_prompt(PS0, "等级不能为0或负数");
% 				NewLv > 99 ->  % 暂时限定不能超过99级
% 					send_prompt(PS0, "等级不能超过99级");
% 				true ->
% 					?TRACE("new lv: ~p~n", [NewLv]),

% 					case NewLv =:= 1 of
% 						true ->
% 							% TODO: 设置为1级时，需做不同的处理，暂时不支持设置为1级  ---- huangjf
% 							% todo here...

% 							send_prompt(PS0, "等级不能设置为1级");
% 						false ->
% 							NewPS = PS#player_status{lv = NewLv - 1, exp = 1},
% 							ExpToAdd = data_exp:get(NewLv - 1),
% 							NewPS2 = lib_player:add_exp(NewPS, ExpToAdd),

% 							% 如果超过可开放藏宝阁的等级，并且还没有开放藏宝阁给玩家，则开放给玩家
% 							?IFC (NewLv > ?START_TREA_HOUSE_NEED_LV)
% 								lib_player:open_trea_house_to_player(NewPS2)
% 							?END,
% 							% 如果超过可开放离线pk功能的等级，并且还没有开放给玩家，则开放给玩家
% 							?IFC (NewLv > ?MIN_LV_TO_OPEN_PK_OFFLINE)
% 								lib_player:open_pk_offline_to_player(NewPS2)
% 							?END,
% 							% 如果超过可开放竞技场的等级，并且还没有开放竞技场给玩家，则开放给玩家
% 							?IFC (NewLv > ?START_ARENA_NEED_LV)
% 								lib_player:open_arena_to_player(NewPS2)
% 							?END,
% 							% 如果超过可开放自动挂机功能的等级，并且还没开放给玩家，则开放给玩家
% 							?IFC (NewLv > ?START_AUTO_MF_NEED_LV)
% 								lib_hang:open_auto_mf_to_player(NewPS2)
% 							?END,

% 							% 超过指定等级则在one_day_tiems_log表插入一条记录
% 							?IFC (NewLv > ?LV_FOR_INSERT_RECORD_TO_TIMES_LOG)
% 								lib_times_log:db_insert_one_record_to_times_log(NewPS2#player_status.id)
% 							?END,

% 							% 更新状态
% 							send_prompt(PS0, "设置等级成功！"),

% 							lib_player:refresh_client(NewPS2#player_status.id, ?REFRESH_ROLE_ATTRI),
% 							%%lib_player:notify_player_attr_changed(NewPS2)
% 							{ok, NewPS2}
% 					end
% 			end
% 	end;


% %% 清空背包
% handle_gm_cmd(clear_bag, PS) ->
% 	MyTotalGoodsList = goods_util:get_goods_list(PS, ?LOCATION_BAG),
% 	F = fun(Goods) ->
% 			GoodsId = Goods#goods.id,	% 唯一id
% 			GoodsNum = Goods#goods.num, % 堆叠数量
% 			pp_goods:handle(15051, PS, [GoodsId, GoodsNum])
% 		end,
% 	lists:foreach(F, MyTotalGoodsList),
% 	send_prompt(PS, "清空成功（不可丢弃的物品会保留）");

% %% 获取背包中的物品唯一ID， 通过格子编号
% handle_gm_cmd(get_goods_id, {PS, Cell}) ->
%     Pattern = #goods{player_id = PS#player_status.id, location = ?LOCATION_BAG, cell = Cell, id = '$1', _ = '_'},
%     case ets:match(?ETS_GOODS_ONLINE(PS), Pattern) of
%         [[Id]] ->
%             send_prompt(PS, "背包中格子编号为：" ++ erlang:integer_to_list(Cell) ++ " 的物品对应的唯一ID为：" ++ erlang:integer_to_list(Id));
%         _ ->
%             send_prompt(PS, "该格子对应物品ID不存在")
%     end;
% handle_gm_cmd(baginfo, PS) ->
%     case goods_util:get_goods_list(PS, ?LOCATION_BAG) of
%         [] ->
%             send_prompt(PS, "背包现在没有东西");
%         List ->
%             NewList = lib_goods:sort(List, cell),
%             F = fun(Info, Str) ->
%                         Str ++ "\n" ++ "物品所在格子编号:" ++ integer_to_list(Info#goods.cell) ++ ", 唯一ID:" ++ integer_to_list(Info#goods.id) ++ ", 配置ID: " ++ integer_to_list(Info#goods.goods_id)
%                 end,
%             RetStr = lists:foldl(F, "", NewList),
%             send_prompt(PS, "背包内物品信息：{唯一ID, 配置ID, 物品所在格子编号}" ++ RetStr)
%     end;

% handle_gm_cmd(search_item, {PS, Name}) ->
%     Str = "%" ++ lib_common:make_sure_list(Name) ++ "%",
%     case db:select_all(base_goods, "goods_id", [{goods_name, "like", Str}]) of
%         TidList when is_list(TidList), TidList =/= []->
%             FunGetStr =
%                 fun([Tid], Res) ->

%                         NameList =
%                             case goods_convert:is_game_tid(Tid) of
%                                 true ->   "\n非绑定" ++ lib_common:make_sure_list( lib_goods:get_goods_name(Tid) );
%                                 false ->  "\n绑定" ++ lib_common:make_sure_list( lib_goods:get_goods_name(Tid) )
%                             end,
%                         NameList ++ "，对应物品类型ID：" ++ integer_to_list(Tid) ++ Res
%                 end,
%             Strlist = lists:foldl(FunGetStr, [], TidList),
%             send_prompt(PS, Strlist);
%         _ ->
%             send_prompt(PS, "查询失败")
%     end;


% %% PS给ToPS加物品
% handle_gm_cmd(add_bindgoods, {PS, GoodsTid, GoodsNum}) ->
%     case goods_util:check_add_condition(PS, GoodsTid, GoodsNum) of
%         can_add ->
%             do_give_bind(GoodsTid, GoodsNum, PS),
%             send_prompt(PS, "给予物品成功");
%         _ ->
%             skip
%     end;
% handle_gm_cmd(add_goods, {PS, GoodsTid, GoodsNum}) ->
%     case goods_util:check_add_condition(PS, GoodsTid, GoodsNum) of
%         can_add ->
%             do_give(GoodsTid, GoodsNum, PS),
%             send_prompt(PS, "给予物品成功");
%         _ ->
%             skip
%     end;
% handle_gm_cmd(give_goods, {PS, ToPS, GoodsTid, GoodsNum}) ->
%     case goods_util:check_add_condition(ToPS, GoodsTid, GoodsNum) of
%         can_add ->
%             do_give(GoodsTid, GoodsNum, ToPS),
%             send_prompt(PS, "给予物品成功");
%         _ ->
%             skip
%     end;
% handle_gm_cmd(give_bindgoods, {PS, ToPS, GoodsTid, GoodsNum}) ->
%     case goods_util:check_add_condition(ToPS, GoodsTid, GoodsNum) of
%         can_add ->
%             do_give_bind(GoodsTid, GoodsNum, ToPS),
%             send_prompt(PS, "给予物品成功");
%         _ ->
%             skip
%     end;

% %%
% handle_gm_cmd(par_skl, {PS, Name, SklName, SklLv}) when is_list(SklName) ->
%     SklIdList = lists:foldl(fun(C, L) -> data_skill:get_partner_skill_ids(C) ++ L end, [], [1,2,3,4]),

%     F1 = fun(Id1) ->
%                  SkillData = data_skill:get(Id1, 1),
%                  is_record(SkillData, ets_skill) andalso SkillData#ets_skill.name == lib_common:make_sure_binary(SklName)
%          end,
%     case lists:filter(F1, SklIdList) of
%         [] ->   skip;
%         [SklId | _] ->   handle_gm_cmd(par_skl, {PS, Name, SklId, SklLv})
%     end;
% handle_gm_cmd(par_skl, {PS, Name, SklId, SklLv}) ->
%     BattleList = lib_partner:get_battler_par_id_list(PS),
%     F = fun(Id) ->
%                 Par = lib_partner:get_alive_partner(Id),
%                 case Par =/= null andalso Par#ets_partner.name == lib_common:make_sure_binary(Name) of
%                     false -> skip;
%                     true ->
%                         SklData = data_skill:get(SklId, SklLv),
%                         case is_record(SklData, ets_skill) of
%                             true when (SklData#ets_skill.data) == [] -> skip;
%                             true ->
%                                 ets:insert(?ETS_PARTNER_ALIVE, Par#ets_partner{eq_skills = [{SklId, SklLv, 1, 1}], skills = [{SklId, SklLv, 1, 1}]}),
%                                 send_prompt(PS, "设置成功, 当前武将技能为: " ++ lib_common:make_sure_list(SklData#ets_skill.name));
%                             false ->
%                                 skip
%                         end
%                 end
%         end,
%     lists:foreach(F, BattleList);

% %%
% handle_gm_cmd(player_skl, {PS, SklIdOrName, SklLv}) when is_list(SklIdOrName) ->
%     SklIdList = lists:foldl(fun(C, L) -> data_skill:get_skill_ids(C) ++ L end, [], [1,2,3,4]),
%     F1 = fun(Id1) ->
%                  SkillData = data_skill:get(Id1, 1),
%                  is_record(SkillData, ets_skill) andalso SkillData#ets_skill.name == lib_common:make_sure_binary(SklIdOrName)
%          end,
%     case lists:filter(F1, SklIdList) of
%         [] ->   skip;
%         [SklId | _] ->   handle_gm_cmd(player_skl, {PS, SklId, SklLv})
%     end;
% handle_gm_cmd(player_skl, {PS, SklId, SklLv}) ->
%     SklData = data_skill:get(SklId, SklLv),
%     case is_record(SklData, ets_skill) of
%         true ->
%             send_prompt(PS, "设置成功, 当前主角技能为: " ++ lib_common:make_sure_list(SklData#ets_skill.name)),
%             NewPS = PS#player_status{eq_skill = [{SklId, SklLv, 0} | PS#player_status.eq_skill]},
%             {ok, NewPS};
%         false ->
%             skip
%     end;



% %% 铸造测试gm指令
% handle_gm_cmd(casting_test, PS) ->
%     BindList = [110100001, 110100002, 110100003, 110200002, 110200003],
%     UnbindList = [100102012, 100102013, 100200012, 100200031, 100600013] ++ % 装备列表
%                      [110301001, 110306001, 110200004, 110400002, 110500001, 110500002, 110600001, 110600002,
%                       120100004, 120100005, 120100006, 120200001, 120300001, 120500001],
%     BindFunc = fun(GoodsTid) ->
%                        case goods_util:check_add_condition(PS, GoodsTid, 99) of
%                            can_add ->   do_give_bind(GoodsTid, 99, PS);
%                            _ ->           skip
%                        end
%                end,
%     UnBindFunc = fun(GoodsTid) ->
%                        case goods_util:check_add_condition(PS, GoodsTid, 99) of
%                            can_add ->   do_give(GoodsTid, 99, PS);
%                            _ ->           skip
%                        end
%                end,
%     lists:foreach(BindFunc, BindList),
%     lists:foreach(UnBindFunc, UnbindList),
%     send_prompt(PS, "操作已执行");

% %% 像自己的邮箱发送物品
% handle_gm_cmd(mail_goods, {PS, GoodsTid, GoodsNum}) ->
%     case goods_util:check_add_condition(PS, GoodsTid, GoodsNum) of
%         can_add ->
%             do_give_to_mail(GoodsTid, GoodsNum, PS),
%             send_prompt(PS, "给予物品成功");
%         _ ->
%             skip
%     end;

% %% desc: 添加积分
% handle_gm_cmd(star_score, {PS, Num}) ->
%     if
%         is_integer(Num) =:= true andalso Num > 0 ->
%             NewPS = lib_fate:change_fate_score_data(PS, Num),
%             mod_fate:handle_query_fate_score(NewPS),
%             send_prompt(NewPS, "操作成功"),
%             {ok, NewPS};
%         true ->
%             send_prompt(PS, "操作失败")
%     end;

% %% 学习阵法
% handle_gm_cmd(learn_troop, {PS, TroopTypeId, TroopLv}) ->
% 	case is_integer(TroopTypeId) of
%         false ->
%         	send_prompt(PS, "阵法类型id不对");
%         true ->
%         	case is_integer(TroopLv) of
%         		false ->
%         			send_prompt(PS, "阵法等级不对");
%         		true ->
%         			?ASSERT(is_integer(TroopLv)),
%         			case catch data_troop:get(TroopTypeId, TroopLv) of
%         				{'EXIT', _Reason} ->
%         					send_prompt(PS, "不存在该阵法");
%         				assert_failed ->
%         					send_prompt(PS, "不存在该阵法*");
%         				TroopData ->
%         					%%?TRACE("~p~n", [ParData]),
%         					?ASSERT(is_record(TroopData, ets_troop)),

% 							if
% 								TroopLv =:= 0 ->
% 									send_prompt(PS, "等级不能为0");
% 								TroopLv > 8 ->  % 阵法的最大等级目前暂时为8级，以后可能会调整
% 									send_prompt(PS, "等级不能超过8级");
% 								true ->
% 									?TRACE("do learn troop;;;~n"),
% 									{ok, NewPS} = lib_troop:learn_troop(PS, TroopTypeId, TroopLv, not_need_cost_money),
% 									PromptMsg = binary_to_list(list_to_binary([<<"学习阵法">>, TroopData#ets_troop.name, <<"成功">>])),
% 									send_prompt(PS, PromptMsg),
% 									{ok, NewPS}
% 							end
%         			end
%         	end
% 	end;



% %% 获取全服的一些统计数据
% handle_gm_cmd(get_gs_stati, PS) ->
% 	GsStati = mod_gs_stati:debug_get_gs_stati_data(),
% 	Str = io_lib:format("
% 			统计数据是否有效: ~p~n
% 			前一天全服的平均在线人数: ~p~n
% 			前一天全服活跃玩家的平均战天币剩余量: ~p~n
% 			前一天全服消费元宝的人数: ~p~n
% 			前一天全服的元宝消费总额: ~p~n",
% 						[
% 							GsStati#gs_stati.is_valid,
% 							GsStati#gs_stati.yesterday_avg_online_num,
% 							GsStati#gs_stati.yesterday_avg_zt_money,
% 							GsStati#gs_stati.yesterday_use_RMB_player_num,
% 							GsStati#gs_stati.yesterday_total_use_RMB
%             			]),
%     send_prompt(PS, Str);


% %% 获取战天材料的掉落概率
% handle_gm_cmd(get_zt_mat_drop_rate, {PS, GoodsTypeId}) ->
% 	DropRate = mod_trea_house:get_zt_mat_drop_rate(GoodsTypeId),
% 	Str = io_lib:format("zt mat(~p) today drop rate: ~p", [GoodsTypeId, DropRate]),
%     send_prompt(PS, Str);


% %% 获取藏宝阁状态
% handle_gm_cmd(get_trea_house_state, PS) ->
% 	ThState = mod_trea_house:debug_get_trea_house_state(),
% 	Str = io_lib:format("
% 			yest_lim_goods_sales_at_RMB_shop: ~p~n
% 			today_lim_goods_refresh: ~p",
% 						[
% 							ThState#th_state.yest_lim_goods_sales_at_RMB_shop,
% 							ThState#th_state.today_lim_goods_refresh
%             			]),
%     send_prompt(PS, Str);


% %% 清除藏宝阁的购买记录
% handle_gm_cmd(clear_trea_house_buy_logs, PS) ->
%     TreaHouseInfo = PS#player_status.trea_house,
%     NewTreaHouseInfo = TreaHouseInfo#role_th{buy_logs = []},
%     NewPS = PS#player_status{trea_house = NewTreaHouseInfo},
%     ?TRACE("new th buy logs: ~p~n", [NewTreaHouseInfo#role_th.buy_logs]),
%     send_prompt(PS, "清除成功"),
%     {ok, NewPS};


% % 改变物品绑定状态
% handle_gm_cmd(bind, {PS, GoodsId, State}) ->
%     if
%         State >= 3 orelse State < 0 ->
%             send_prompt(PS, "输入的绑定类型不正确：0-不可绑定，1-未绑定，2-已绑定");
%         true ->
%             Pattern = #goods{id = GoodsId, _ = '_'},
%             case lib_common:get_ets_info(?ETS_GOODS_ONLINE(PS), Pattern) of
%                 Info when is_record(Info, goods) ->
% 					db:update(goods, ["bind"], [State], "id", GoodsId),
%                     ets:insert(?ETS_GOODS_ONLINE(PS), Info#goods{bind = State}),
%                     pp_goods:handle(15000, PS, [GoodsId, Info#goods.location]);
%                 _ ->
%                     send_prompt(PS, "物品不存在")
%             end
%     end;

% %% 设置竞技场的积分
% handle_gm_cmd(set_ar_acc_points, {PS, AccPoints}) ->
% 	case is_integer(AccPoints) of
%         false ->
%         	send_prompt(PS, "积分不对");
%         true ->
%         	NewAccPoints = case AccPoints < 0 of
%         						true -> 0;
%         						false -> AccPoints
%         				   end,
%         	case mod_arena:rpc_query_my_arena_info(PS) of
%         		{fail} ->
%         			send_prompt(PS, "设置失败，可能因为你的等级不够");
%         		{ok, MyArInfo} ->
%         			NewArInfo = MyArInfo#arena{acc_points = NewAccPoints},
%         			mod_arena:rpc_update_arena_info_to_global_cache(NewArInfo),
%         			lib_arena:notify_my_arena_info_changed(local_node, NewArInfo),
%         			send_prompt(PS, "设置成功")
%         	end
% 	end;

% %% 设置竞技场当天剩余可挑战次数
% handle_gm_cmd(clear_ar_already_chal_times, PS) ->
% 	mod_arena:rpc_clear_already_chal_times(PS#player_status.id),
% 	send_prompt(PS, "清空成功");


% %% 离开特殊场景
% handle_gm_cmd(move_scene, {gotoout, PS})->
% 	PS1 = lib_scene:leave_special_scene(PS),
% 	{ok, PS1};

% %%把玩家移动到101场景
% handle_gm_cmd(move_scene, {_PS, PS1})->
% 	SceneId = 101,
% 	Scene = data_scene:get(SceneId),
% 	case lib_player:is_in_dungeon(PS1) of
% 		true ->
% 			case mod_dungeon:get_outside_scene(PS1#player_status.scene) of
% 				false ->
% 					?ASSERT(false),
% 					skip;
% 				[_Scene, _X, _Y] ->
% 					mod_dungeon:quit_dungeon(PS1, quit_single),
% 					void
% 			end;
% 		false ->
% 			skip
% 	end,
% 	{X2,Y2} = lib_scene:get_bus_station(Scene),
% 	PS2 =
% 		if SceneId == PS1#player_status.scene ->
% 			   lib_scene:revive_to_scene(PS1, PS1#player_status{scene = SceneId, x = X2, y = Y2});
% 		   true ->
% 			   lib_scene:change_scene(PS1, {SceneId, SceneId, Scene#ets_scene.name, X2, Y2})
% 		end,
% 	gen_server:cast(PS2#player_status.pid, {'SET_PLAYER', PS2});

% %%移动到指定场景
% handle_gm_cmd(move_scene, {goto, PS,SceneId})->
% 	case lib_player:is_in_dungeon(PS) of
% 		true ->
% 			case mod_dungeon:get_outside_scene(PS#player_status.scene) of
% 				false ->
% 					?ASSERT(false),
% 					skip;
% 				[_Scene, _X, _Y] ->
% 					mod_dungeon:quit_dungeon(PS, quit_single),
% 					void
% 			end;
% 		false ->
% 			skip
% 	end,
% 	Scene = data_scene:get(SceneId),
% 	if Scene =/= [] andalso (Scene#ets_scene.type == ?SCENE_T_SAFE orelse
% 						 Scene#ets_scene.type == ?SCENE_T_GUILD_PVP orelse
% 										 Scene#ets_scene.type == ?SCENE_T_WORLD_MON orelse Scene#ets_scene.type == ?SCENE_T_BEACH orelse
% 														 Scene#ets_scene.type == ?SCENE_T_TREVI) ->
% 		   {X,Y} = lib_scene:get_bus_station(Scene),
% 		   PS1 =
% 			   if PS#player_status.scene == SceneId ->
% 					  lib_scene:revive_to_scene(PS, PS#player_status{scene = SceneId, x = X, y = Y});
% 				  true ->
% 					  lib_scene:change_scene(PS, {SceneId, SceneId, Scene#ets_scene.name, X, Y})
% 			   end,
% 		   {ok, PS1};
% 	   true ->
% 		   send_prompt(PS, "id不对")
% 	end;

% %%任务触发
% handle_gm_cmd(task_trigger, {PS, Tid}) ->
% 	case is_integer(Tid) of
%         false ->
%         	send_prompt(PS, "id不对");
% 		true ->
% 			Reply = lib_task:gm_trigger({task_id,Tid}, PS),
% 			send_prompt(PS, "触发成功"),
% 			Reply
% 	end;

% %%更新新手引导节点
% handle_gm_cmd(fresh_meat, {PS, State}) ->
% 	case is_integer(State) andalso State >= 0 of
%         false ->
%         	send_prompt(PS, "数值不对");
% 		true ->
% 			db:update(player, ["task_state"], [State], "id", PS#player_status.id),
% 			{ok, BinData} = pt_30:write(30026, State),
% 	   		lib_send:send_one(PS#player_status.socket, BinData),
% 			send_prompt(PS, "设置成功"),
% 			{ok,PS#player_status{task_state = State}}
% 	end;

% %%获取当前的新手引导节点
% handle_gm_cmd(get_task_state, PS) ->
% 	CurTaskState = PS#player_status.task_state,
% 	Str = io_lib:format("当前新手引导状态值：~p", [CurTaskState]),
% 	send_prompt(PS, Str),
% 	void;


% %%清除所有任务
% handle_gm_cmd(task_init, PS) ->
% 	Reply = pp_task:handle(30200, PS, []),
% 	lib_task:refresh_task(PS),
% 	send_prompt(PS, "修改成功"),
% 	Reply;

% %%放弃任务
% handle_gm_cmd(task_giveup, {PS, Tid}) ->
% 	case lib_task:abnegate(Tid, PS) of
% 		true ->
% 			lib_task:refresh_task(PS),
% 			send_prompt(PS, "修改成功");
% 		_ ->
% 			skip
% 	end;


% %% desc: 强化一件装备
% handle_gm_cmd(stren_goods, {PS, GoodsTId, Stren}) ->
%     case Stren > 0 of
%         true ->
%             goods_util:send_stren_goods(PS, [{GoodsTId, 1, Stren}], gm),
%             send_prompt(PS, "获取强化物品成功"),
%             lib_player:refresh_client(PS, ?REFRESH_BAG);
%         false ->
%             send_prompt(PS, "获取强化物品失败")
%     end;


% %% 获得武将
% handle_gm_cmd(get_partner, {PS, ParTypeId, ParLv}) ->
% 	case is_integer(ParTypeId) of
%         false ->
%         	send_prompt(PS, "武将类型id不对");
%         true ->
%         	case is_integer(ParLv) of
%         		false ->
%         			send_prompt(PS, "武将等级不对");
%         		true ->
%         			case catch data_partner:get(ParTypeId) of
%         				{'EXIT', _Reason} ->
%         					send_prompt(PS, "不存在该类型的武将");
%         				assert_failed ->
%         					send_prompt(PS, "不存在该类型的武将*");
%         				ParData ->
%         					%%?TRACE("~p~n", [ParData]),
%         					?ASSERT(is_record(ParData, par_born_data)),
%         					AlreadyHave = lib_partner:has_this_type_of_partner(PS, ParTypeId),
% 							if  ParLv =< 0 ->
% 									send_prompt(PS, "等级不能为0或负数");
% 								ParLv > 60 ->  % 暂时限定不能超过60级
% 									send_prompt(PS, "等级不能超过60级");
% 								AlreadyHave =:= true ->
% 									send_prompt(PS, "你已经有该类型的武将了");
% 								true ->
% 									?TRACE("do get Partner;;;~n"),
% 									% 给武将（放在客栈）
% 									{ok, NewPS} = lib_partner:give_partner_to_player(PS, ParTypeId),
% 									% 获取刚给的武将的唯一id
% 									%%Pattern = #ets_partner{player_id = PS#player_status.id, par_type_id = ParTypeId, _ = '_'},
% 									%%[ParInfo] = ets:match_object(?ETS_PARTNER_HOTEL, Pattern),

% 									ParInfo = lib_partner:get_my_hotel_partner_by_type_id(NewPS, ParTypeId),
% 									?ASSERT(ParInfo /= null),
% 									ParId = ParInfo#ets_partner.id,

% 									% 从客栈招募（先给足游戏币、声望和所需物品，然后再招募）
% 									TmpNewPS = lib_money:add_coin(NewPS, ParData#par_born_data.recruit_need_coin),
% 									TmpNewPS2 = lib_player:add_repu(TmpNewPS, ParData#par_born_data.recruit_need_repu),
% 									{NeedGoodsTypeId, NeedGoodsNum} = ParData#par_born_data.recruit_need_goods,
% 									?IFC (NeedGoodsTypeId /= 0)
% 										?ASSERT(NeedGoodsNum > 0, ParTypeId),
% 										do_give(NeedGoodsTypeId, NeedGoodsNum, TmpNewPS2),
% 										timer:sleep(200)  % sleep一下，以等待给物品成功
% 									?END,

% 									{ok, NewPS2, ParTypeId} = lib_partner:recruit_partner_from_hotel(TmpNewPS2, ParId),
% 									% 重设武将等级
% 									case ParLv =:= 1 of
% 										true -> % 默认给的就是1级，故跳过不做额外处理
% 											skip;
% 										false -> % 重设等级
% 											NewParInfo = lib_partner:get_alive_partner(ParId),
% 											?ASSERT(NewParInfo /= null),
% 											NewParInfo2 = NewParInfo#ets_partner{lv = ParLv - 1},
% 											% 先更新到ets
% 											ets:insert(?ETS_PARTNER_ALIVE, NewParInfo2),
% 											ExpLim = lib_partner:get_exp_lim(ParLv - 1, ParInfo#ets_partner.quality),
% 											% 加经验使其升级到指定等级
% 											{ok, NewParInfo3} = lib_partner:add_exp(ParId, ExpLim, NewPS2),
% 											% 设置当前气血为满血
% 											NewParInfo4 = NewParInfo3#ets_partner{hp = NewParInfo3#ets_partner.hp_lim},
% 											% 再次更新到ets
% 											ets:insert(?ETS_PARTNER_ALIVE, NewParInfo4)
% 									end,

% 									PromptMsg = binary_to_list(list_to_binary([<<"获得武将">>, ParInfo#ets_partner.name, <<"成功">>])),
% 									send_prompt(PS, PromptMsg),
% 									% 通知客户端更新
% 									pp_troop:handle(?PT_GET_ALIVE_PARTNER_LIST, NewPS2, NewPS2#player_status.id),
% 									{ok, NewPS2}
% 							end
%         			end
%         	end
% 	end;

% %% 设置武将等级
% handle_gm_cmd(set_partner_lv, {PS, ParTypeId, NewLv}) ->
% 	case is_integer(ParTypeId) of
%         false ->
%         	send_prompt(PS, "武将类型id不对");
%         true ->
%         	case is_integer(NewLv) of
%         		false ->
%         			send_prompt(PS, "武将等级不对");
%         		true ->
%         			case catch data_partner:get(ParTypeId) of
%         				{'EXIT', _Reason} ->
%         					send_prompt(PS, "不存在该类型的武将");
%         				null ->
%         					send_prompt(PS, "不存在该类型的武将*");
%         				_ParData ->
%         					%%?TRACE("~p~n", [ParData]),
%         					?ASSERT(is_record(_ParData, par_born_data)),
%         					Partner = lib_partner:get_my_alive_partner_by_type_id(PS, ParTypeId),
% 							if  NewLv =< 0 orelse NewLv == 1 ->  % TODO：暂时不支持设为1级，以后补上
% 									send_prompt(PS, "等级不能为0级、1级或负数");
% 								NewLv > 60 ->  % 暂时限定不能超过60级
% 									send_prompt(PS, "等级不能超过60级");
% 								Partner =:= null ->
% 									send_prompt(PS, "你没有携带该类型的武将");
% 								true -> % 设置等级
% 									NewParInfo = Partner#ets_partner{lv = NewLv - 1},
% 									% 先更新到ets
% 									ets:insert(?ETS_PARTNER_ALIVE, NewParInfo),
% 									ExpLim = lib_partner:get_exp_lim(NewLv - 1, Partner#ets_partner.quality),
% 									% 加经验使其升级到指定等级
% %% 									FightingParIdList = lib_partner:get_battler_par_id_list(PS),
% 									{ok, NewParInfo2} = lib_partner:add_exp(NewParInfo#ets_partner.id, ExpLim, PS),
% 									% 再次更新到ets
% 									ets:insert(?ETS_PARTNER_ALIVE, NewParInfo2),
% 									% 通知客户端更新
% 									lib_partner:notify_partner_attr_changed(PS, NewParInfo2),
% 									PromptMsg = "设置成功",
% 									send_prompt(PS, PromptMsg)
% 							end
%         			end
%         	end
% 	end;

% %%武将加经验
% handle_gm_cmd(par_exp, {PS, ParTypeId, Exp}) ->
% 	case lib_partner:get_my_alive_partner_by_type_id(PS, ParTypeId) of
% 		null -> send_prompt(PS, "不存在次类型武将");
% 		Partner ->
% 			case lib_partner:add_exp(Partner#ets_partner.id, Exp, PS) of
% 				{ok, _} -> send_prompt(PS, "成功");
% 				_ -> send_prompt(PS, "加经验失败")
% 			end
% 	end;

% %% desc: 修改玩家战魂值
% handle_gm_cmd(change_soul_power, {PS, Val}) ->
%     case is_integer(Val) andalso Val >= 0 of
%         true ->
% 			db:update(player, ["soul_power"], [Val], "id", PS#player_status.id),

% 			OldVal = PS#player_status.soul_power,
% 			NewPS = case OldVal < Val of
% 						true ->
% 							lib_player:add_soul_powner(PS, Val - OldVal);
% 						false ->
% 							lib_player:sub_soul_powner(PS, OldVal - Val)
% 					end,
%             {ok, Bin} = pt_37:write(37002, [1, 0, 0, NewPS#player_status.soul_power, NewPS#player_status.coin]),
%             lib_send:send_one(PS#player_status.socket, Bin),
%             send_prompt(PS, "操作成功！"),
% 			{ok, NewPS};
%         false ->
%             send_prompt(PS, "操作失败，战魂值必须为>=0的整数")
%     end;

% %% desc: 给玩家增加一个体力buff
% handle_gm_cmd(power_buff, {PS, Val}) ->
%     case is_integer(Val) of
%         true ->
%             lib_buff:add_power_buff(PS, Val),
%             send_prompt(PS, "操作成功！");
%         false ->
%             send_prompt(PS, "操作失败，体力buff值必须为>=0的整数")
%     end;

% %% desc: 修改玩家体力值
% handle_gm_cmd(change_power, {PS, Val}) ->
%     case is_integer(Val) andalso Val >= 0 of
%         true ->
% 			db:update(player, ["power"], [Val], "id", PS#player_status.id),
%             NewPS = PS#player_status{power = Val},
%             buff_util:refresh_power_line(NewPS),
%             send_prompt(NewPS, "操作成功！"),
% 			{ok, NewPS};
%         false ->
%             send_prompt(PS, "操作失败，体力值必须为>=0的整数")
%     end;

% %% desc: 修改玩家怒气值
% handle_gm_cmd(change_anger, {PS, Val}) ->
%     case is_integer(Val) andalso Val >= 0 andalso Val =< 100 of
%         true ->
% 			db:update(player, ["anger"], [Val], "id", PS#player_status.id),
%             NewPS = case lib_player:is_in_battle(PS) of
%             			false ->
%             				PS#player_status{anger = Val};
%             			true ->
%             				PS#player_status.cur_bid ! {'GM_CMD_SET_ANGER', PS#player_status.id, Val},
%             				PS
%             		end,
%             send_prompt(PS, "操作成功！"),
% 			{ok, NewPS};
%         false ->
%             send_prompt(PS, "操作失败，怒气值的范围为0～100")
%     end;

% %% desc: 修改玩家的觉醒值
% handle_gm_cmd(change_arousal, {PS, Val}) ->
%     case is_integer(Val) andalso Val >= 0 andalso Val =< 100 of
%         true ->
%             case lib_player:is_in_battle(PS) of
%             	false ->
%             		NewPS = PS#player_status{arousal = Val},
%             		send_prompt(PS, "设置觉醒值成功！"),
%             		{ok, NewPS};
%             	true ->
%             		PS#player_status.cur_bid ! {'GM_CMD_SET_AROUSAL', PS#player_status.id, Val},
%             		send_prompt(PS, "设置觉醒值成功！")
%             end;
%         false ->
%             send_prompt(PS, "设置失败，觉醒值的范围为0～100")
%     end;


% %% desc: 直接打怪
% handle_gm_cmd(battle, {PS, MonId}) ->
% 	Scene = 0,
% 	Type = 0,
% 	Id = mod_mon_create:create_mon([MonId, Scene, 0, 0, Type, 0]),
% 	pp_battle:handle(20001, PS, Id);

% %% desc: 查看战斗对象的信息（战斗中使用）
% handle_gm_cmd(query_bo_info, {PS, BattleObjId}) ->
%     case is_integer(BattleObjId) andalso BattleObjId > 0 of
%         true ->
%             case lib_player:is_in_battle(PS) of
%             	false ->
%             		send_prompt(PS, "当前不在战斗中，操作无效！");
%             	true ->
%             		case is_pid(PS#player_status.cur_bid) of
%             			false ->
%             				send_prompt(PS, "is_pid(PS#player_status.cur_bid) returns false!!!");
%             			true ->
%             				case gen_server:call(PS#player_status.cur_bid, {'GET_BO_INFO', BattleObjId}) of
%             					null ->
%             						send_prompt(PS, "战斗对象不存在！");
%             					Bo ->
%             						Str = io_lib:format("bo_id: ~p, bo_type: ~p, hp_lim:~p, hp: ~p, ~nanger: ~p, arousal:~p",
%             											[
%             												Bo#battle_obj.bo_id,
%             												Bo#battle_obj.sign,
%             												Bo#battle_obj.hp_lim,
%             												Bo#battle_obj.hp,
%             												Bo#battle_obj.anger,
%             												Bo#battle_obj.arousal
%             											 ]),
%             						send_prompt(PS, Str)
%             				end
%             		end
%             end;
%         false ->
%             send_prompt(PS, "查看失败，战斗对象id错误！")
%     end;

% %% desc: 设置帮会声望
% handle_gm_cmd(change_g_pres, {PS, Val}) ->
%     NewPS = PS#player_status{guild_prestige = Val},

%     db:update(player, ["guild_prestige"], [NewPS#player_status.guild_prestige], "id", NewPS#player_status.id),
% 	lib_guild:keep_prestige_same(change_mem, server, NewPS),
%     gen_server:cast(PS#player_status.pid, {'SET_PLAYER', NewPS}),
%     send_prompt(NewPS, "操作已响应");

% %% desc: 刷新某一类型的排行榜
% handle_gm_cmd(refresh_rank, {PS, Type}) ->
%     case Type >= 0 andalso is_integer(Type) of
%         true ->
%             rank_util:refresh_rank(Type),
%             send_prompt(PS, "操作已响应");
%         false ->
%             send_prompt(PS, "操作失败")
%     end;

% %% 刷新一次总数的排行
% handle_gm_cmd(rank, {PS, Type}) ->
%     if
%         arena =:= Type ->
%             mod_rank:event_arena(PS),
%             send_prompt(PS, "操作已响应");
%         be_wanted =:= Type ->
%             mod_rank:event_be_wanted(PS#player_status.id),
%             send_prompt(PS, "操作已响应");
%         true ->
%             send_prompt(PS, "操作失败")
%     end;

% %% 刷新副本排行榜
% handle_gm_cmd(refresh_dungeon_rank, PS) ->
%     lists:foreach
%     (
%         fun(S) ->
%                 rank_util:refresh_dungeon_rank(S)
%         end,
%         data_chaos:get_rank_dungeon()
%     ),

%     send_prompt(PS, "操作已响应");

% %% 刷新称号列表
% handle_gm_cmd(refresh_title, PS) ->
%     % 刷新竞技场第一
%     lib_title:refresh_arena(),
%     % 刷新个人战力排行榜
%     lib_title:refresh_fighting(),
%     % 刷新个人等级排行榜
%     lib_title:refresh_level(),
% 	% 刷新个人个人财富排行榜
%     lib_title:refresh_riches(),

%     send_prompt(PS, "操作已响应");

% %% desc: 获得当前场景分线
% handle_gm_cmd(get_line, PS) ->
% 	send_prompt(PS, PS#player_status.line_id);

% %% desc: 设置当前场景分线
% handle_gm_cmd(set_line, {PS, Val}) ->
%     case is_integer(Val) andalso Val >= 0 of
%         true ->
%             NewPS = PS#player_status{line_id = Val},
%             send_prompt(PS, "操作成功！"),
% 			{ok, NewPS};
%         false ->
%             send_prompt(PS, "操作失败，场景分线Id必须为>=0的整数")
%     end;

% %% desc: 刷新商城特价区出售物品
% handle_gm_cmd(refresh_shop, _PS) ->
%     skip;
% %%     gen_server:cast({global, ?GLOBAL_SHOP_PROC}, refresh_bargain),
% %%     pp_goods:handle(15012, PS, none),
% %%     send_prompt(PS, "商城特价区刷新成功, 祝您购物愉快~");

% %% desc: 更改商城特价区物品数量
% handle_gm_cmd(change_b_num, {_PS, _Type, _Num}) ->
%     skip;
% %%     gen_server:cast({global, ?GLOBAL_SHOP_PROC}, {'change_b_num', Type, Num}),
% %%     pp_goods:handle(15012, PS, none),
% %%     send_prompt(PS, "商城特价区刷新成功, 祝您购物愉快~");

% %% desc: 修改日常礼包状态为未领取
% handle_gm_cmd(daily_gift_get, PS) ->
%     lib_gift:gm_daily_gift_get(PS),
%     pp_gift:handle(38001, PS, daily_gift),
%     send_prompt(PS, "修改成功");

% %% desc: 设置今天为第N天连续登录
% handle_gm_cmd(daily_gift_condays, {PS, Days}) ->
%     case is_integer(Days) of
%         true ->
%             if
%                 Days =< 60 andalso Days > 0 ->
%                     lib_gift:gm_daily_gift_condays(PS, Days),
%                     pp_gift:handle(38001, PS, daily_gift),
%                     send_prompt(PS, "修改成功");
%                 true ->
%                     send_prompt(PS, "天数值应在 1~60 范围")
%             end;
%         false ->
%             send_prompt(PS, "天数应为 整数")
%     end;

% %% desc: 设置昨天未登录过游戏
% handle_gm_cmd(daily_gift_nologin, PS) ->
%     lib_gift:gm_daily_gift_nologin(PS),
%     pp_gift:handle(38001, PS, daily_gift),
%     send_prompt(PS, "修改成功");

% %% desc: 修改在线礼包冷却时间置0
% handle_gm_cmd(online_gift_cd, PS) ->
%     lib_gift:gm_online_gift_cd(PS),
%     pp_gift:handle(38002, PS, online_gift),
%     send_prompt(PS, "修改成功");

% %% desc: 今日领取在线礼包次数清0
% handle_gm_cmd(online_gift_get, PS) ->
%     lib_gift:gm_online_gift_get(PS),
%     pp_gift:handle(38002, PS, online_gift),
%     send_prompt(PS, "修改成功");

% %% desc: 设置已注册天数
% handle_gm_cmd(login_gift_days, {PS, Days}) ->
%     case is_integer(Days) of
%         true ->
%             if
%                 Days > 0 ->
%                     lib_gift:gm_login_gift_days(PS, Days - 1),
%                     pp_gift:handle(38006, PS, login_gift),
%                     send_prompt(PS, "修改成功");
%                 true ->
%                     send_prompt(PS, "天数应为正整数")
%             end;
%         false ->
%             send_prompt(PS, "天数应为 整数")
%     end;

% %% desc: 登录礼包设置为从未领取过
% handle_gm_cmd(login_gift_get, PS) ->
%     lib_gift:gm_login_gift_get(PS),
%     pp_gift:handle(38006, PS, login_gift),
%     send_prompt(PS, "修改成功");

% %% desc: 重置等级礼包为未领取过
% handle_gm_cmd(lv_gift_get, PS) ->
%     lib_gift:gm_lv_gift_get(PS),
%     pp_gift:handle(38008, PS, lv_gift),
%     send_prompt(PS, "修改成功");

% %% 签到
% handle_gm_cmd(gift_sign, {PS, Day}) ->
%     mod_p2_activity:handle_gm_debug(gift_sign, {PS, Day}),
%     send_prompt(PS, "修改成功");

% %% 清除签到
% handle_gm_cmd(gift_sign_clear, {PS, Day}) ->
%     mod_p2_activity:handle_gm_debug(gift_sign_clear, {PS, Day}),
%     send_prompt(PS, "修改成功");

% %% 签到(上月)
% handle_gm_cmd(gift_sign_lastmonth, {PS, Day}) ->
%     mod_p2_activity:handle_gm_debug(gift_sign_lastmonth, {PS, Day}),
%     send_prompt(PS, "修改成功");

% %% 清除签到(上月)
% handle_gm_cmd(gift_sign_clear_lastmonth, {PS, Day}) ->
%     mod_p2_activity:handle_gm_debug(gift_sign_clear_lastmonth, {PS, Day}),
%     send_prompt(PS, "修改成功");

% %% 离线经验
% handle_gm_cmd(gift_offline_exp, {PS, Hour}) ->
%     mod_p2_activity:handle_gm_debug(gift_offline_exp, {PS, Hour}),
%     send_prompt(PS, "修改成功");

% %% 重置返还
% handle_gm_cmd(gift_ret, PS) ->
%     mod_p2_activity:handle_gm_debug(gift_ret, PS),
%     send_prompt(PS, "修改成功");

% %% desc: 充值元宝
% handle_gm_cmd(gift_charge, {PS, Gold}) ->
%     mod_p2_activity:handle_gm_debug(gift_charge, {PS, Gold}),
%     send_prompt(PS, "修改成功");

% %% 增加buff
% handle_gm_cmd(add_buff, {PS, BuffTid}) ->
%     buff_util:buff_effect(PS, BuffTid, 1),
%     PS1 = lib_attribute:order_calc_player_attri([buff], PS),
%     lib_attribute:recalc_battle_par_attri([buff], PS1),
%     PS2 = lib_hp:add_battler_hp(PS1),
%     buff_util:handle_refresh_buff(PS2),
%     lib_player:notify_player_attr_changed(PS2),
%     send_prompt(PS2, "添加成功"),
%     {ok, PS2};
% %% 删除buff
% handle_gm_cmd(del_buff, {PS, BuffTid}) ->
%     lib_buff:del_appoint_buff(PS#player_status.id, BuffTid),
%     PS1 = lib_attribute:order_calc_player_attri([buff], PS),
%     lib_attribute:recalc_battle_par_attri([buff], PS1),
%     PS2 = lib_hp:add_battler_hp(PS1),
%     buff_util:handle_refresh_buff(PS2),
%     lib_player:notify_player_attr_changed(PS2),
%     send_prompt(PS2, "删除成功"),
%     {ok, PS2};

% %% 修改剩余刷新时间(分钟为单位)
% handle_gm_cmd(mystery_cd, {PS, Min}) when is_integer(Min), Min > 0 ->
%     case lib_common:get_ets_info(?ETS_MYSTERY_SHOP, PS#player_status.id) of
%         {} ->
%             send_prompt(PS, "操作失败");
%         Info ->
%             NewInfo = Info#mystery_shop{nextime = Min * 60 + util:unixtime()},
%             lib_shop:update_mystery_data(NewInfo),
%             mod_shop:handle_get_mystery_infos(PS),
%             send_prompt(PS, "操作成功")
%     end;

% handle_gm_cmd(tree_init, PS) ->
% 	case lib_tree:get_data(PS#player_status.id) of
% 		[] ->
% 			skip;
% 		Info ->
% 			lib_tree:init_ets_tree(Info, PS),
% 			{ok, BinData} = pt_34:write(34015,  ?TREE_DATA_A),
% 			lib_send:send_one(PS#player_status.socket, BinData),
% 			send_prompt(PS, "初始化成功")
% 	end;

% handle_gm_cmd(rolling_anno, {_PS, Type}) ->
%     lib_chat:send_to_all_rolling(Type, []);

% handle_gm_cmd(flash_anno, {_PS, Type}) ->
%     lib_chat:send_to_all_flash(Type, []);

% handle_gm_cmd(tree_times, {PS, Num}) ->
% 	case lib_tree:get_data(PS#player_status.id) of
% 		[] ->
% 			skip;
% 		TreeInfo ->
% 		%^	WaterBuy = Num,
% 			TreeInfo1 = TreeInfo#ets_tree{water = Num,
% 										  watered = Num,
% 										  water_other = Num,
% 										  water_buy = Num,
% 										  water_record = []
% 										 },
% 			if TreeInfo =/= TreeInfo1 ->
% 				   db:update(tree, ["water",
% 									"water_buy",
% 									"watered",
% 									"water_other",
% 									"water_record"],
% 							 		[TreeInfo1#ets_tree.water,
% 									 TreeInfo1#ets_tree.water_buy,
% 									 TreeInfo1#ets_tree.watered,
% 									 TreeInfo1#ets_tree.water_other,
% 									 util:term_to_bitstring(TreeInfo1#ets_tree.water_record)], "id", TreeInfo1#ets_tree.id),
% 				   ets:insert(?ETS_TREE,TreeInfo1),
% 				   {ok, BinData} = pt_34:write(34015,  ?TREE_DATA_A),
% 				   lib_send:send_one(PS#player_status.socket, BinData);
% 			   true ->
% 				   skip
% 			end,
% 			send_prompt(PS, "操作成功")
% 	end;

% handle_gm_cmd(tree_water, {PS, Type, Num}) when is_integer(Num)->
% 	case lib_tree:get_data(PS#player_status.id) of
% 		[] ->
% 			skip;
% 		TreeInfo ->
% 			if Num >= 0 ->
% 				   TreeInfo1 =
% 					   case Type of
% 						   1 ->	% water
% 							   TreeInfo#ets_tree{water = Num};
% 						   2 ->	% watered
% 							   TreeInfo#ets_tree{watered = Num};
% 						   3 ->	% water_other
% 							   TreeInfo#ets_tree{water_other = Num, water_record = []};
% 						   4 ->	% water_buy
% 							   TreeInfo#ets_tree{water_buy = Num}
% 					   end,
% 				   if TreeInfo =/= TreeInfo1 ->
% 						  db:update(tree, [water,
% 										   water_buy,
% 										   watered,
% 										   water_other,
% 										   water_record],
% 										  [TreeInfo1#ets_tree.water,
% 											TreeInfo1#ets_tree.water_buy,
% 											TreeInfo1#ets_tree.watered,
% 											TreeInfo1#ets_tree.water_other,
% 											util:term_to_bitstring(TreeInfo1#ets_tree.water_record)], "id", TreeInfo1#ets_tree.id),
% 						  ets:insert(?ETS_TREE,TreeInfo1),
% 						  {ok, BinData} = pt_34:write(34015,  ?TREE_DATA_A),
% 						  lib_send:send_one(PS#player_status.socket, BinData);
% 					  true ->
% 						  skip
% 				   end,
% 				   send_prompt(PS, "操作成功");
% 			   true ->
% 				   skip
% 			end
% 	end;

% handle_gm_cmd(achi,{PS, Val}) ->
% 	case lib_achievement:gm_finish(Val, PS) of
%         [] ->
% 			send_prompt(PS, "操作失败"),
%             skip;
%         _ ->
% 			send_prompt(PS, "操作成功")
%     end,
% 	skip;

% handle_gm_cmd(rich,{PS, Val}) ->
% 	case lib_player:is_in_rich(PS) of
%         true ->
%             Pid = PS#player_status.pid_rich,
%             Pid ! {'rich_obj_change', Val, PS},
% 			send_prompt(PS, "操作成功");
%         false ->
% 			send_prompt(PS, "操作失败"),
%             skip
%     end,
% 	skip;

% handle_gm_cmd(richcount,PS) ->
% 	gen_server:cast({global, ?GLOBAL_RICH_PROCESS}, {rich_count, PS}),
% 	send_prompt(PS, "操作成功");

% handle_gm_cmd(rich_walk,{PS, Val}) ->
% 	case lib_player:is_in_rich(PS) of
%         true ->
%             Pid = PS#player_status.pid_rich,
%             Pid ! {'rich_walk', Val, PS},
% 			send_prompt(PS, "操作成功");
%         false ->
% 			send_prompt(PS, "操作失败"),
%             skip
%     end,
% 	skip;

% handle_gm_cmd(rich_walk1,{PS, Val}) ->
% 	case lib_player:is_in_rich(PS) of
%         true ->
%             Pid = PS#player_status.pid_rich,
%             Pid ! {shake_dice_gm, PS#player_status.id, Val, false},
% 			send_prompt(PS, "操作成功");
%         false ->
% 			send_prompt(PS, "操作失败"),
%             skip
%     end,
% 	skip;

% handle_gm_cmd(group, {Time}) ->
% 	gen_server:cast({global, ?GLOBAL_GROUP}, {apply_cast, lib_gm, clear_group, [Time]});

% handle_gm_cmd(ven_lv, {PS, Lv}) ->
% 	NewPS = PS#player_status{vena_hp_lim_lv = Lv,
% 					 vena_phy_def_lv = Lv,
%                      vena_mag_def_lv = Lv,
%                      vena_phy_att_lv = Lv,
%                      vena_spr_def_lv = Lv,
%                      vena_spr_att_lv = Lv,
%                      vena_hit_lv = Lv,
%                      vena_crit_lv = Lv,
%                      vena_block_lv = Lv,
%                      vena_dodge_lv = Lv},
% 	{ok, NewPS};

% handle_gm_cmd(ven_rank, {PS, Rank}) ->
% 	NewPS = PS#player_status{vena_hp_lim_rank = Rank,
% 					 vena_phy_def_rank = Rank,
%                      vena_mag_def_rank = Rank,
%                      vena_phy_att_rank = Rank,
%                      vena_spr_def_rank = Rank,
%                      vena_spr_att_rank = Rank,
%                      vena_hit_rank = Rank,
%                      vena_crit_rank = Rank,
%                      vena_block_rank = Rank,
%                      vena_dodge_rank = Rank},
% 	{ok, NewPS};

% handle_gm_cmd(_Event,_Val) ->
% 	skip.

% %% clear_group(Time) ->
% %% 	self() ! {'clear_group', Time}.

% gm_get_player_status(PlayerId, PS)->
% 	if PlayerId == PS#player_status.id ->
% 			PS;
% 	   true ->
% 			lib_player:get_user_info_by_id(PlayerId)
% 	end.

% send_prompt(PS, RespMsg) ->
% 	{ok, BinData} = pt_11:write(11009, RespMsg),
% 	lib_send:send_one(PS#player_status.socket, BinData).




send_prompt_to(PS, Msg) ->
    ?TRACE("send_prompt_to(), Msg:~p~n", [Msg]),
    MsgBin = list_to_binary(Msg),
    %%Id = player:id(PS),
    %%{ok, BinData} = pt_11:write(11001, [Id, MsgBin, 0, <<"系统">>]),
    %%lib_send:send_to_sock(PS, BinData).

    pp_chat:handle(11001, PS, [<<(byte_size(MsgBin)):16, MsgBin/binary>>]).


% add_new_skill(SkillInfo, PlayerStatus, SkillLv) ->
%     PlayerId = PlayerStatus#player_status.id,
%     SkillId = SkillInfo#ets_skill.id,

% 	db:insert(skill, [id, skill_id, lv, equip], [PlayerId, SkillId, SkillLv, 0]).

% set_guild_lv(PS, Lv) ->
%     ?TRACE("set_guild_lv.~n", []),
%     if
%         PS#player_status.guild_id =:= 0 ->
%             {false, no_guild};
%         not is_integer(Lv) ->
%             {false, lv_err};
%         true ->
%             Pattern = #ets_guild{guild_id = PS#player_status.guild_id, _ = '_'},
%             Guild = util:match_one(?ETS_GUILD, Pattern),
%             ?ASSERT(Guild =/= []),
%             NewGuild = Guild#ets_guild{guild_level = Lv},
%             ets:insert(?ETS_GUILD, NewGuild),

% 			db:update(guild, ["guild_level"], [Lv], "guild_id", NewGuild#ets_guild.guild_id),
%             true
%     end.

% set_guild_area(PS, Val1, Val2) ->
%     ?TRACE("set_guild_area~n", []),
%     if
%         PS#player_status.guild_id =:= 0 ->
%             {false, "请先建帮会或入帮会！"};
%         (not is_integer(Val1)) orelse (not is_integer(Val2)) ->
%             {false, "错误:参数必须为整数!"};
%         (Val1 > 4) orelse (Val1 =< 0) orelse (Val2 > 12) ->
%             {false, "参数超出范围!"};
%         true ->
%             Pattern = #ets_guild{guild_id = PS#player_status.guild_id, _ = '_'},
%             Guild = util:match_one(?ETS_GUILD, Pattern),
%             ?ASSERT(Guild =/= []),
%             NewGuild = case Val2 < 1 of
%                 true ->
%                     Guild#ets_guild{area = Val1};
%                 false ->
%                     Guild#ets_guild{area = Val1, star = Val2}
%             end,
%             lib_guild_ghost:load_guild_to_ghost_war(NewGuild),
%             ets:insert(?ETS_GUILD, NewGuild),

% 			db:update(guild, ["area", "star"], [Val1, NewGuild#ets_guild.star], "guild_id", NewGuild#ets_guild.guild_id),
%             true
%     end.
% %%
% %% guild_war_to_floor(PS, Val) ->
% %%     if
% %%         PS#player_status.guild_id =:= 0 ->
% %%             {false, no_guild};
% %%         not is_integer(Val) ->
% %%             {false, lv_err};
% %%         true ->
% %%             lib_guild_war:war_to_star(PS#player_status.guild_id, Val),
% %%             true
% %%     end.

% g_war_lost(PS) ->
%     if
%         PS#player_status.guild_id =:= 0 ->
%             {false, no_guild};
%         true ->
%             Pattern = #ets_guild_war{guild_id = PS#player_status.guild_id, _ = '_'},
%             case util:match_one(?ETS_GUILD_WAR, Pattern) of
%                 [] ->
%                     {false, no_war};
%                 _GuildWar ->
% %%                     lib_guild_war:war_lost(PS#player_status.guild_id),
%                     true
%              end
%     end.

% clear_g_war(PS) ->
%     if
%         PS#player_status.guild_id =:= 0 ->
%             {false, "请先建帮会或入帮会！"};
%         true ->
%             case guild_util:get_guild_war_info(PS#player_status.guild_id) of
%                 {} ->
%                     {false, "今日还没发起征战呢!"};
%                 GuildWar ->
%                     NewGuildWar = GuildWar#ets_guild_war{date = 0, finish = false, state = 0},
%                     ets:insert(?ETS_GUILD_WAR, NewGuildWar),
%                     true
%              end
%     end.

% %% 开始妖魔反攻战
% start_ghost_war(PS) ->
%     if
%         PS#player_status.guild_id =:= 0 ->
%             {false, no_guild};
%         true ->
%             Pattern = #ets_guild_ghost_war{guild_id = PS#player_status.guild_id, _ = '_'},
%             GhostWar = util:match_one(?ETS_GUILD_GHOST_WAR, Pattern),
%             if
%                 GhostWar =:= [] ->
%                     {false, area_lv_too_small};
%                 true ->
%                     self() ! {'start_ghost_war', GhostWar},
%                     true
%             end
%     end.

% %% 停止妖魔反攻战
% stop_ghost_war(PS) ->
%     if
%         PS#player_status.guild_id =:= 0 ->
%             {false, no_guild};
%         true ->
%             Pattern = #ets_guild_ghost_war{guild_id = PS#player_status.guild_id, _ = '_'},
%             GhostWar = util:match_one(?ETS_GUILD_GHOST_WAR, Pattern),
%             if@
%                 GhostWar =:= [] ->
%                     {false, area_lv_too_small};
%                 true ->
%                     self() ! {'stop_ghost_war', GhostWar},
%                     true
%             end
%     end.

% %% 通知GUILD_PVP
% notice_guild_pvp(_PS) ->
%     self() ! {'notice_guild_pvp'},
%     true.

% %% 通知广播GUILD_PVP
% notice_broadcast_pvp(_PS) ->
%     self() ! {'notice_broadcast_guild_pvp'},
%     true.

% %% 开启诸神战场
% start_gods_pvp(_PS) ->
%     ?TRACE("call start_gods_pvp ~n", []),
%     self() ! {'start_gods_pvp'},
%     true.

% %% 停止诸神战场
% end_gods_pvp(_PS) ->
%     ?TRACE("call end_gods_pvp ~n",[]),
%     self() ! {'end_gods_pvp'},
%     true.

% %% 停止诸神战场
% clear_gods_pvp(_PS) ->
%     ?TRACE("call clear_gods_pvp ~n", []),
%     self() ! {'clear_gods_pvp'},
%     true.

% start_online_arena(_PS) ->
%     ?TRACE("call start_online_arena ~n", []),
%     self() ! {'start_online_arena'},
%     true.

% clear_online_arena(_PS) ->
%     ?TRACE("call clear_online_arena ~n", []),
%     self() ! {'clear_online_arena'},
%     true.

% stop_online_arena(_PS) ->
%     ?TRACE("call stop_online_arena ~n", []),
%     self() ! {'stop_online_arena'},
%     true.

% start_trevi(_PS) ->
%     self() ! {'start_game', true}.
% stop_trevi(_PS) ->
%     self() ! {'over_game'}.
% trevi_xcoin({_PS, Num}) ->
% 	self() ! {trevi_set_xcoin, Num}.

% %% 通知GUILD_PVP
% start_guild_pvp(_PS) ->
%     self() ! {'start_guild_pvp'},
%     true.

% %% 刷新帮会中BUFF
% refresh_guild_pvp_buff(_PS) ->
%     self() ! {'refresh_pvp_buff'},
%     self() ! {'refresh_pvp_flag'},
%     true.

% %% 通知GUILD_PVP
% notice_end_guild_pvp(_PS) ->
%     self() ! {'notice_end_guild_pvp'},
%     true.

% %% 通知GUILD_PVP
% stop_guild_pvp(_PS) ->
%     self() ! {'end_guild_pvp'},
%     true.

% %% 通知GUILD_PVP
% clear_guild_pvp(_PS) ->
%     self() ! {'clear_guild_pvp'},
%     true.

% %% 通知准备PVP
% notice_ready_guild_pvp(_PS) ->
%     self() ! {'start_time_pvp'},
%     true.



% %% ========================================= Local Functions ===============================================

%% 检查时间是否合法
check_time_format({Hour, Min, Sec}) ->
    Bool =  is_integer(Hour)
            andalso is_integer(Min)
            andalso is_integer(Sec)
            andalso Hour >= 0
            andalso Hour =< 23
            andalso Min >= 0
            andalso Min =< 59
            andalso Sec >= 0
            andalso Sec =< 59,

    case Bool of
        true -> ok;
        false -> fail
    end.


	% case Hour < 0 orelse Hour > 23 of
 %        true ->
	% 		error;
	% 	false ->
	% 		case Min < 0 orelse Min > 59 of
 %                true ->
	% 				error;
	% 			false ->
	% 				case Sec < 0 orelse Sec > 59 of
 %                        true ->
	% 						error;
	% 					false ->
	% 						ok
	% 				end
	% 		end
	% end.


%% 检查日期是否合法
check_date_format({Year, Month, Day}) ->
    case is_integer(Year) andalso Year > 0 of
        false ->
            fail;
        true ->
            MonthDays = case calendar:is_leap_year(Year) of
                            true ->
                                [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
                            false ->
                                [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
                        end,
            Bool =  is_integer(Month)
                    andalso is_integer(Day)
                    andalso Month >= 1
                    andalso Month =< 12
                    andalso Day >= 1
                    andalso (Day =< lists:nth(Month, MonthDays)),

            case Bool of
                true -> ok;
                false -> fail
            end
    end.

	% if	Year =< 0 ->
	% 		error;
	% 	true ->
	% 		if	Month =< 0 orelse Month > 12 ->
	% 				error;
	% 			true ->
	% 				if	Day =< 0 orelse Day > 31 ->
	% 						error;
	% 					true ->
	% 						ok
	% 				end
	% 		end
	% end.



% %% internal
% %% desc: 用叠加上限限制物品数量
% adjust_num(GoodsTid, GoodsNum) ->
%     MaxOverlap = lib_goods:get_goods_overlap(GoodsTid),
%     lists:min([MaxOverlap, GoodsNum]).

% %% internal
% %% desc: 给物品操作
% do_give(GoodsTid, GoodsNum, ToPS) ->
%     NewNum = adjust_num(GoodsTid, GoodsNum),  % 数量被该物品叠加上限所限制
%     goods_util:send_goods_to_role(?LOCATION_BAG, [{GoodsTid, NewNum}], ToPS),
%     lib_player:refresh_client(ToPS#player_status.id, ?REFRESH_BAG).
% do_give_bind(GoodsTid, GoodsNum, ToPS) ->
%     NewNum = adjust_num(GoodsTid, GoodsNum),  % 数量被该物品叠加上限所限制
%     goods_util:send_goods_to_role([{GoodsTid, NewNum}], ToPS),
%     lib_player:refresh_client(ToPS#player_status.id, ?REFRESH_BAG).
% do_give_to_mail(GoodsTid, GoodsNum, PS) ->
%     NewNum = adjust_num(GoodsTid, GoodsNum),  % 数量被该物品叠加上限所限制
%     goods_util:send_goods_to_role(?BIND_NOTYET, ?LOCATION_MAIL, [{GoodsTid, NewNum}], PS),
%     lib_player:refresh_client(PS#player_status.id, ?REFRESH_BAG).


% %% 重新触发所有的定时计划任务
% retrigger_all_time_schedule() ->
% 	mod_gs_stati:gm_cmd_trigger_time_schedule().	% 处理全服统计数据的定时计划任务
% 	% TODO: 根据需要，在此添加重新触发其他模块的定时计划任务
% 	% ...
% 	% ...
change_os_time(Year, Mon, Day) ->
    {Hour, Min, Sec} = time(),
    change_os_time(Year, Mon, Day, Hour, Min, Sec).


change_os_time(Year, Mon, Day, Hour, Min, Sec) ->
    case os:type() of
        {win32, _} ->
            %% windows系统修改时间
            change_win_os_time(Year, Mon, Day, Hour, Min, Sec);
        {unix, _} ->
            %% unix类系统修改时间
			change_unix_os_time(Year, Mon, Day, Hour, Min, Sec);
%%             redo;
        _ -> skip
    end.

change_win_os_time(Year, Mon, Day, Hour, Min, Sec) ->
    DateCmd = "date " ++ tool:to_list(Year) ++ "-" ++ tool:to_list(Mon) ++ "-" ++ tool:to_list(Day),
    TimeCmd = "time " ++ tool:to_list(Hour) ++ ":" ++ tool:to_list(Min) ++ ":" ++ tool:to_list(Sec),
    os:cmd(DateCmd),
    os:cmd(TimeCmd).


% change_unix_os_time(Year, Mon, Day, Hour, Min, Sec) -> redo.
change_unix_os_time(Year, Mon, Day, Hour, Min, Sec) ->%%redo.%% 线上环境是unix，为避免误操作，不处理 
	DateCmd = lists:concat(["date -s \"",Year,"-",Mon,"-",Day," ",Hour,":",Min,":",Sec,"\""]),
	os:cmd(DateCmd).

