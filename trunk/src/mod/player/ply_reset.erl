%%%--------------------------------------
%%% @Module: ply_reset
%%% @Author: liuzhongzheng2012@gmail.com
%%% @Created: 2014-05-20
%%% @Description: 玩家的每日/每周重置（重置活动次数等）
%%%--------------------------------------

-module(ply_reset).

-export([
            on_player_login/1,
            try_reset/1,
            do_daily_reset/2,
            do_weekly_reset/1,gm_reset/1
        ]).

-include("common.hrl").
-include("record.hrl").
-include("activity.hrl").



%% 登录时的处理
on_player_login(PS) ->
    try_reset(PS).




try_reset(PS) ->
    try_daily_reset(PS),
    try_weekly_reset(PS),
    ok.



try_daily_reset(PS) ->
    Time = player:get_last_daily_reset_time(PS),
    case util:is_same_day(Time) of
        ?false ->
            do_daily_reset(PS, Time);
        ?true ->
            skip
    end.

%% 执行日重置 日常 重置 
do_daily_reset(PS, LastTime) ->
    lib_vip:send_daily_mail(PS),
    ply_arena_1v1:daily_reset(PS),
    ply_arena_3v3:daily_reset(PS),
    ply_cruise:daily_reset(PS),
    mod_tve_mgr:daily_reset(PS),
    lib_xs_task:daily_reset(PS, LastTime),
    lib_festival_act:daily_reset(PS),
    lib_equip:reset_free_stren_cnt(PS),
    lib_jingyan:daily_reset(PS),
    
    % 在此处添加其他所需的每日重置
    % ...
    player:set_last_daily_reset_time(PS, util:unixtime()),
    ok.

gm_reset(PlayerId) ->
    case lib_activity:get_answer_info(PlayerId) of
        Answer when is_record(Answer, answer) ->
            lib_activity:update_answer_info(#answer{role_id = Answer#answer.role_id, join_time = util:unixtime(), his_cor_num = Answer#answer.his_cor_num});
        _ ->
            skip
    end,
    Pid = player:get_pid(PlayerId),
    gen_server:cast(Pid, 'task_refresh_daily'),
    lib_dungeon:reset_all_dungeon(PlayerId).




try_weekly_reset(PS) ->
    Time = player:get_last_weekly_reset_time(PS),
    case util:is_same_week(Time) of
        ?false ->
            do_weekly_reset(PS);
        ?true ->
            skip
    end.


%% 执行周重置
do_weekly_reset(PS) ->
    ply_arena_1v1:weekly_reset(PS),
    ply_arena_3v3:weekly_reset(PS),
    mod_relation:weekly_reset(PS),
    
    % 在此处添加其他所需的每周重置
    % ...

    player:set_last_weekly_reset_time(PS, util:unixtime()),
    ok.


