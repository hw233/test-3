%%%------------------------------------
%%% @Module  : mod_mon
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2013.6.16
%%% @Description: （内存中的）明雷怪对象
%%%------------------------------------
-module(mod_mon).
-export([
        create_mon/1,
        clear_mon/1,
        
        battle_feedback/2,

        get_obj/1,
        is_exists/1,

        get_id/1,
        get_no/1,
        get_name/1,
        get_type/1,
        get_scene_id/1,
        get_xy/1,
        get_lv/1,
        get_trigger_battle_condi/1,

        get_bhv_state/1,

        get_can_be_killed_times/1,
        get_acc_be_killed_times/1,
        get_left_can_be_killed_times/1,

        has_owner/1,
        get_owner_id/1,
        set_owner_id/2,

        has_team/1,
        get_team_id/1,
        set_team_id/2,

        mark_idle/1,
        mark_battling/1,
        is_battling/1,
        is_existing_time_forever/1,
        is_expired/1,
        is_residual/1,

        need_cleared_after_die/1,
        can_concurrent_battle/1,
        is_visible_to_all/1,

        is_world_boss/1,

        can_move/1,

        % is_auto_respawn/1,

        add_mon_to_ets/1,
        del_mon_from_ets/1,
        update_mon_to_ets/1,

        get_bmon_group_no_list/1

        
	]).

-include("common.hrl").
-include("record.hrl").
-include("ets_name.hrl").
-include("monster.hrl").
-include("scene.hrl").
-include("char.hrl").



% -compile({inline,[
%                 get_id/1, get_no/1, get_xy/1, get_team_id/1
%                 ]}).



%% 创建明雷怪对象
%% @return: {ok, 新创建的明雷怪对象} | fail
create_mon([MonNo, SceneId, X, Y]) ->
    case mod_mon_tpl:get_tpl_data(MonNo) of
        null ->
            ?ASSERT(false, MonNo),
            fail;
        MonTpl ->
            NewMonId = mod_id_alloc:next_comm_id(),
                
            % NewMon2 = further_init_mon(NewMon),
            % lib_mon:update_mon_to_ets(NewMon2),
            % {ok, lib_mon:get_id(NewMon)}

            ExpireTime = case MonTpl#mon_tpl.existing_time of
                            0 -> 0;  % 表示永久存在
                            ExistingTime -> svr_clock:get_unixtime() + ExistingTime
                        end,
            NewMon = #mon{
                        id = NewMonId,
                        no = MonTpl#mon_tpl.no,
                        % name = MonTpl#mon_tpl.name,
                        type = MonTpl#mon_tpl.type,
                        lv = MonTpl#mon_tpl.lv,
                        
                        scene_id = SceneId,
                        born_x = X,
                        born_y = Y,
                        x = X,
                        y = Y,

                        is_combative = MonTpl#mon_tpl.is_combative,

                        is_visible_to_all = MonTpl#mon_tpl.is_visible_to_all,

                        bhv_state = ?BHV_IDLE,

                        % bmon_group_no_list = MonTpl#mon_tpl.bmon_group_no_list,



                        % conditions = MonTpl#mon_tpl.conditions,

                        can_be_killed_times = MonTpl#mon_tpl.can_be_killed_times,
                        need_cleared_after_die = MonTpl#mon_tpl.need_cleared_after_die,
                        existing_time = MonTpl#mon_tpl.existing_time,
                        expire_time = ExpireTime,

                        owner_id = ?INVALID_ID,  % 初始化为不属于任何玩家
                        team_id = ?INVALID_ID    % 初始化为不属于任何队伍
                        },
            
            {ok, NewMon}
    end.



            



%% 清除明雷怪
clear_mon(MonId) ->
    ?ASSERT(is_exists(MonId), MonId),

    % 做一些必要的清理工作，目前暂时没有
    % 。。。

    % 为避免并发问题，统一cast到怪物管理进程做处理
    mod_mon_mgr:do_clear_mon(MonId).







%% 废弃!!
% further_init_mon(NewMon) ->
%     % TODO: 
%     % ...如有必要，做进一步的初始化
%     % ...
%     NewMon.





%% 彻底死亡后是否消失？
need_cleared_after_die(Mon) ->
    Mon#mon.need_cleared_after_die == 1.


%% 是否可以同时和多个玩家触发战斗？
can_concurrent_battle(Mon) ->
    MonNo = get_no(Mon),
    MonTpl = mod_mon_tpl:get_tpl_data(MonNo),
    mod_mon_tpl:can_concurrent_battle(MonTpl).


%% 是否对所有玩家都可见？
is_visible_to_all(Mon) ->
    Mon#mon.is_visible_to_all == 1.



is_world_boss(Mon) ->
    get_type(Mon) == ?MON_WORLD_BOSS.




%% 战斗结束后的反馈
battle_feedback(MonId, FeedbackInfo) ->
    mod_mon_mgr:battle_feedback(MonId, FeedbackInfo).













%% 从ets获取怪物对象
%% @para: MonId => 怪物唯一id
%% @return: null | mon结构体
get_obj(MonId) ->
    case ets:lookup(?ETS_MON, MonId) of
        [] -> null;
        [Mon] -> Mon
    end.


%% 明雷怪对象是否存在？
is_exists(MonId) ->
    ets:member(?ETS_MON, MonId).  %%%%get_obj(MonId) /= null.


%% 获取唯一id
get_id(Mon) -> Mon#mon.id.

%% 获取编号
get_no(Mon) -> Mon#mon.no.

% %% 获取资源id
% get_res_id(Mon) -> Mon#mon.res_id.

%% 获取所在场景的id
get_scene_id(Mon) -> Mon#mon.scene_id.

%% 获取所在位置的坐标
get_xy(Mon) -> {Mon#mon.x, Mon#mon.y}.



%% 是否有主人（即是否属于某一指定的玩家或队伍）？
has_owner(Mon) ->
    get_owner_id(Mon) /= ?INVALID_ID.


%% 获取所属玩家的id
get_owner_id(Mon) ->
    Mon#mon.owner_id.


%% 设置所属玩家的id（设置后，只有该玩家能见到它）
set_owner_id(MonId, PlayerId) ->
    ?ASSERT(is_exists(MonId), MonId),
    Mon = get_obj(MonId),
    Mon2 = Mon#mon{owner_id = PlayerId},
    update_mon_to_ets(Mon2).




%% 是否有队伍（即是否属于某一指定的队伍）？
has_team(Mon) ->
    get_team_id(Mon) /= ?INVALID_ID.
    
%% 获取所属队伍的id
get_team_id(Mon) -> Mon#mon.team_id.


%% 设置所属队伍的id（设置后，只有该队伍的玩家能见到它）
set_team_id(MonId, TeamId) ->
    ?ASSERT(is_exists(MonId), MonId),
    Mon = get_obj(MonId),
    Mon2 = Mon#mon{team_id = TeamId},
    update_mon_to_ets(Mon2).



%% 获取名字
get_name(MonId) when is_integer(MonId) ->
    case get_obj(MonId) of
        Mon when is_record(Mon, mon) ->
            get_name(Mon);
        _Any ->
            ?ASSERT(false, {MonId, _Any}),
            <<"">>
    end;
get_name(Mon) when is_record(Mon, mon) ->
    MonNo = get_no(Mon),
    MonTpl = mod_mon_tpl:get_tpl_data(MonNo),
    mod_mon_tpl:get_name(MonTpl).

get_type(Mon) -> Mon#mon.type.

get_lv(Mon) -> Mon#mon.lv.


%% 获取触发战斗的条件列表
get_trigger_battle_condi(Mon) ->
    MonNo = get_no(Mon),
    MonTpl = mod_mon_tpl:get_tpl_data(MonNo),
    mod_mon_tpl:get_trigger_battle_condi(MonTpl).

    

%% 获取当前累计已被杀死的次数
get_acc_be_killed_times(Mon) ->
    Mon#mon.acc_be_killed_times.


%% 获取剩余可被杀死的次数
%% @return: infinite（表示不限次数） | 具体的次数    
get_left_can_be_killed_times(Mon) ->
    case get_can_be_killed_times(Mon) of
        infinite ->
            infinite;
        _ ->
            RetTimes = get_can_be_killed_times(Mon) - get_acc_be_killed_times(Mon),
            ?ASSERT(util:is_nonnegative_int(RetTimes), {RetTimes, Mon}),
            RetTimes
    end.
     

%% 获取可被杀次的次数
%% @return: infinite（表示不限次数） | 具体的次数
get_can_be_killed_times(Mon) ->
    case Mon#mon.can_be_killed_times == 0 of
        true ->
            infinite;
        false ->
            Mon#mon.can_be_killed_times
    end.





% %% 尝试标记为空闲
% try_mark_idle(MonId) ->
%     case get_obj(MonId) of
%         null ->
%             skip;
%         Mon ->
%             mark_idle(Mon)
%     end.



get_bhv_state(Mon) ->
    Mon#mon.bhv_state.

    

%% 标记为空闲
mark_idle(MonId) when is_integer(MonId) ->
    Mon = get_obj(MonId),
    Mon2 = Mon#mon{bhv_state = ?BHV_IDLE},
    update_mon_to_ets(Mon2),
    Mon2;
mark_idle(Mon) ->
    Mon2 = Mon#mon{bhv_state = ?BHV_IDLE},
    update_mon_to_ets(Mon2),
    Mon2.
    



%% 标记为战斗中
mark_battling(MonId) when is_integer(MonId) ->
    Mon = get_obj(MonId),
    Mon2 = Mon#mon{bhv_state = ?BHV_BATTLING},
    update_mon_to_ets(Mon2);
mark_battling(Mon) ->
    Mon2 = Mon#mon{bhv_state = ?BHV_BATTLING},
    update_mon_to_ets(Mon2).





%% 是否在战斗中？
is_battling(Mon) ->
    Mon#mon.bhv_state == ?BHV_BATTLING.



%% 刷出后的持续时间是否为永久？
is_existing_time_forever(Mon) ->
    Mon#mon.existing_time == 0.


%% 判断明雷怪对象是否已过期
is_expired(Mon) ->
    case is_existing_time_forever(Mon) of
        true ->
            false;
        false ->
            svr_clock:get_unixtime() >= Mon#mon.expire_time
    end.


%% 判断是否为残余的明雷怪对象？
is_residual(Mon) ->
    % 过期？
    Bool1 = is_expired(Mon),

    % 彻底死亡后会消失，并且已经彻底被杀死了？
    Bool2 = need_cleared_after_die(Mon) 
            andalso (get_can_be_killed_times(Mon) /= infinite)
            andalso (get_left_can_be_killed_times(Mon) =< 0),

    Bool1 orelse Bool2.



%% 是否可以走动？ --TODO： 暂时固定返回false！
can_move(MonId) when is_integer(MonId) ->
    false;
can_move(Mon) when is_record(Mon, mon) ->
    false.


% %% 是否死亡后自动重新刷出
% is_auto_respawn(Mon) when is_record(Mon, mon) ->
%     Mon#mon.is_auto_respawn == 1.


    




%% 获取明雷怪对应的战斗怪物组编号(bmon: battle mon)
get_bmon_group_no_list(Mon) ->
    MonNo = get_no(Mon),
    MonTpl = mod_mon_tpl:get_tpl_data(MonNo),
    mod_mon_tpl:get_bmon_group_no_list(MonTpl).









%% 添加明雷怪对象到ets
add_mon_to_ets(NewMon) when is_record(NewMon, mon) ->
    case ets:insert_new(?ETS_MON, NewMon) of
        true ->
            mod_mon_mgr:add_to_mon_id_set( get_id(NewMon)),
            ok;
        false ->
            ?ERROR_MSG("[mod_mon] add_mon_to_ets() error!!! stacktrace: ~w~n NewMon: ~w~n ets_mon:~w", [erlang:get_stacktrace(), NewMon, ets:tab2list(?ETS_MON)]),
            ?ASSERT(false),
            fail
    end.


%% 从ets删除明雷怪对象
del_mon_from_ets(MonId) ->
    ?ASSERT(is_integer(MonId), MonId),
    mod_mon_mgr:del_from_mon_id_set(MonId),
    ets:delete(?ETS_MON, MonId).



%% 更新明雷怪对象到ets
update_mon_to_ets(Mon_Latest) 
  when is_record(Mon_Latest, mon) ->
    ets:insert(?ETS_MON, Mon_Latest).







% %% 判断是否处于准备战斗状态（目前仅boss才有准备战斗状态）
% is_readying_battle(Mon) ->
%   Mon#mon.is_readying_battle.
    

% %% 获取处于准备战斗状态的剩余时间（目前仅boss才有准备战斗状态）
% %% @return： 剩余时间（秒），如果不在准备战斗状态，则固定返回0
% get_ready_battle_left_time(Mon) ->
%   case is_readying_battle(Mon) of
%       true ->
%           LeftTime = ?MAX_BOSS_READY_BATTLE_TIME - (util:unixtime() - Mon#mon.ready_battle_start_time),
%           max(LeftTime, 0);
%       false ->
%           0
%   end.
                                


% %%找到mon对应的副本id列表
% get_dungeon_by_mon_id(MonId,Type)->
%     SceneList = data_scene:get_id_list(),
%     [Sid|| Sid<-SceneList,check_mon_exist(Sid,MonId,Type)].   

% %%检测走动怪是否在场景数据中存在
% check_mon_exist(Sid,MonId,move)->
%     Sinfo = data_scene:get(Sid),
%     case Sinfo#scene.mons of
%          [] ->
%               false;
%          MonList ->
%                case [M||[M|_]<-MonList,M=:=MonId] of
%                     []->
%                          false;
%                   MonL ->
%                        ?TRACE("MonList1:~p~n",[MonL]),
%                        true
%               end
%   end;

% %%检测战斗怪是否在场景数据中存在
% check_mon_exist(Sid,BMonId,battle)->
%     Sinfo = data_scene:get(Sid),
%     case Sinfo#scene.mons of
%          [] ->
%               false;
%          MonList ->
%                case [M||[M|_]<-MonList,check_battle_mon_exist(M,BMonId)] of
%                     []->
%                          false;
%                   MonL ->
%                        ?TRACE("MonList2:~p~n",[MonL]),
%                        true
%               end
%   end.

% check_battle_mon_exist(M,BMonId)->
%   case data_mon:get(M) of
%       [] -> false;
%       MonInfo ->
%               case data_bmon_group:get(MonInfo#mon.bmon_group) of
%                   Bmon_group when is_record(Bmon_group, rd_bmon_group) ->
%                       length([1 || {Id,_X,_Y} <- Bmon_group#rd_bmon_group.battle_mon_list,BMonId=:=Id]) > 0;
%                   [] ->
%                       false
%               end
%   end.


