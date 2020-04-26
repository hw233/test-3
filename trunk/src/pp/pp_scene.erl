%%%--------------------------------------
%%% @Module  : pp_scene
%%% @Author  :
%%% @Email   :
%%% @Created : 2011.05.09
%%% @Modified: 2013.6
%%% @Description:  场景相关的协议
%%%--------------------------------------
-module(pp_scene).
-export([handle/3]).

-include("common.hrl").
-include("record.hrl").
-include("protocol/pt_12.hrl").
-include("ets_name.hrl").
-include("scene.hrl").
-include("player.hrl").
-include("prompt_msg_code.hrl").
-include("aoi.hrl").
% -include("log.hrl").


%% 玩家移动（注意：第二个参数是玩家id！ 因为针对玩家移动协议做了单独的处理，详见mod_player模块）
handle(?PT_PLAYER_MOVE, PlayerId, [SceneId, NewX, NewY]) ->
    case check_player_move(PlayerId, SceneId, NewX, NewY) of
        fail ->
            skip;

        {fail, skip_scene_grid, OldPos, SceneTpl} ->  % 容错
            {AccSteps, MaxSteps} = OldPos#plyr_pos.step_counter,
            StepsMoved = 3,  % 固定认为是3步

            NewAccSteps = min(AccSteps + StepsMoved, MaxSteps),
            NewStepCounter = {NewAccSteps, MaxSteps},
            NewPos = OldPos#plyr_pos{x = NewX, y = NewY, step_counter = NewStepCounter},
            player:set_position(PlayerId, NewPos),

            % 累计步数是否已达最大值？
            case NewAccSteps >= MaxSteps of
                false ->
                    skip;
                true ->
                    try_trigger_trap(SceneTpl, player:get_PS(PlayerId), NewPos)
            end;

        {ok, OldPos, SceneTpl} ->

            OldX = OldPos#plyr_pos.x,   % 原x坐标
            OldY = OldPos#plyr_pos.y,   % 原y坐标
            %%OldGridIdx = OldPos#plyr_pos.scene_grid_index,

            {AccSteps, MaxSteps} = OldPos#plyr_pos.step_counter,

            % 是否需要调整为在暗雷区走动时，才计步？？
            StepsMoved = util:calc_manhattan_distance(OldX, OldY, NewX, NewY),

            NewAccSteps = min(AccSteps + StepsMoved, MaxSteps),

            NewStepCounter = {NewAccSteps, MaxSteps},

            NewPos = OldPos#plyr_pos{x = NewX, y = NewY, step_counter = NewStepCounter},


            PS = player:get_PS(PlayerId),

            mod_go:player_move(PS, SceneId, OldPos, NewPos),

            player:set_position(PlayerId, NewPos),


            % 累计步数是否已达最大值？
            case NewAccSteps >= MaxSteps of
                false ->
                    skip;
                true ->
                    %%gen_server:cast( self(), {'try_trigger_trap_after_move', PS, NewPos})

                    try_trigger_trap(SceneTpl, PS, NewPos)
            end
    end,
    void;




%% 请求逃离阻挡位置
handle(?PT_REQ_LEAVE_BLOCKED_POS, PS, _) ->
    case player:is_in_dungeon(PS) of
        {true, Pid} -> gen_server:cast(Pid, {'quit_dungeon', PS});
        false -> ply_scene:goto_born_place(PS)
    end,
    void;


%% 直接传送到目标位置
handle(?PT_FORCE_TELEPORT, PS, [SceneId, X, Y]) ->
    % case lib_vip:welfare(map_jump, PS)  of
        % false ->
        %     skip;
        % true ->
            case lib_scene:is_bad_pos(SceneId, X, Y) of
                true ->
                    lib_send:send_prompt_msg(PS, ?PM_BAD_POSITION);
                false ->
                    ply_scene:do_teleport(PS, SceneId, X, Y)
            end,
    % end,
    void;


%% 请求传送
handle(?PT_REQ_TELEPORT, PS, TeleportNo) ->
    % case ply_scene:check_teleport(PS, TeleportNo) of
    %     ok ->
    %         ply_scene:do_teleport(PS, TeleportNo);
    %     {fail, ?PM_UNKNOWN_ERR} ->
    %         ?ASSERT(false),
    %         skip;
    %     {fail, Reason} ->
    %         lib_send:send_prompt_msg(PS, Reason)
    % end,
	case lib_cross:check_is_mirror() andalso TeleportNo == 202 of
		?true ->
			lib_send:send_prompt_msg(PS, ?PM_CROSS_BAN_PROTO);
		_ ->
			case player:is_in_dungeon(PS) of
				{true, DunPid} ->
					gen_server:cast(DunPid, {'dungeon_tp', PS, TeleportNo});
				false ->
					TelepCfg = ply_scene:get_teleport_cfg_data(TeleportNo),
					SceneType = mod_scene_tpl:get_scene_type(TelepCfg#teleport.target_scene_no),
					if
						SceneType =:= ?SCENE_T_GUILD ->
							case ply_guild:try_teleport_to_guild_scene(PS, TelepCfg#teleport.target_scene_no, TelepCfg#teleport.target_xy) of
								ok -> done;
								{fail, Reason} -> lib_send:send_prompt_msg(PS, Reason)
							end;
						true ->
							TimeNow = util:unixtime(),
							case (TimeNow - ply_battle:get_last_battle_start_time()) < 4 of  % 目前定4秒
								true ->  % 避免：同时发生触发暗雷战斗和跳转场景
									?TRACE("cannot teleport, battling ...~n"),
									skip;
								false ->
									case ply_scene:try_teleport(PS, TeleportNo) of
										ok -> done;
										{fail, Reason} -> lib_send:send_prompt_msg(PS, Reason)
									end
							end     
					end
			end
	end;


%% 玩家在普通场景之间跳转
handle(?PT_SWITCH_BETWEEN_NORMAL_SCENES, PS, NewSceneId) ->
	OldPos = player:get_position( player:get_id(PS)),  % 原位置
	case NewSceneId =:= OldPos#plyr_pos.scene_id of
		true ->
            ?ASSERT(false),
			skip;
		false ->
			case lib_scene:is_normal_scene(NewSceneId) of
				false ->
                    ?ASSERT(false),
                    skip;
				true ->
                    case ply_scene:switch_between_normal_scenes(PS, NewSceneId) of
                        {fail, Reason} -> lib_send:send_prompt_msg(PS, Reason);
                        ok -> void
                    end
			end
	end;

% 废弃！因为客户端现在自带场景内普通npc的配置信息
% %% 加载场景：获取场景中的普通npc列表
% handle(?PT_GET_SCENE_NORMAL_NPC_LIST, PS, __SceneId) ->
% 	CurPos = player:get_position(player:get_id(PS)),
%     SceneId = CurPos#plyr_pos.scene_id,
%     ?ASSERT(__SceneId =:= SceneId, {__SceneId, SceneId}),  % 客户端发的场景id只是用来做调试验证的！
%     case lib_scene:get_obj(SceneId) of
%         null ->
% 			?ASSERT(false, SceneId),
%             skip;
%         SceneObj ->
%             NorNpcIdList = lib_scene:get_scene_static_npc_ids(SceneId),
%             {ok, BinData} = pt_12:write(?PT_GET_SCENE_NORMAL_NPC_LIST, NorNpcIdList),
%             lib_send:send_to_sock(PS, BinData)
%     end;


%% 加载场景：获取场景中的动态npc列表（不包括巡逻npc!!）
handle(?PT_GET_SCENE_DYNAMIC_NPC_LIST, PS, TargetSceneId) ->
    CurPos = player:get_position(player:get_id(PS)),
    CurSceneId = CurPos#plyr_pos.scene_id,
    %%%?ASSERT(__SceneId =:= SceneId, {__SceneId, SceneId}),  % 客户端发的场景id只是用来做调试验证的！
    case TargetSceneId /= CurSceneId of
        true ->
            skip;
        false ->
            case lib_scene:is_exists(CurSceneId) of
                false ->
                    ?ASSERT(false, CurSceneId),
                    skip;
                true ->
                    DynNpcIdList = lib_scene:get_scene_dynamic_npc_ids(CurSceneId),

                    % 过滤掉可移动的npc
                    DynNpcIdList2 = [X || X <- DynNpcIdList, not mod_npc:is_moveable(X)],

                    {ok, BinData} = pt_12:write(?PT_GET_SCENE_DYNAMIC_NPC_LIST, DynNpcIdList2),
                    lib_send:send_to_sock(PS, BinData)
            end
    end,
    void;





%%
handle(?PT_GET_SCENE_DYNAMIC_TELEPORTER_LIST, PS, TargetSceneId) ->
    CurPos = player:get_position(player:get_id(PS)),
    CurSceneId = CurPos#plyr_pos.scene_id,
    %%%%?ASSERT(__SceneId =:= SceneId, {__SceneId, SceneId}),  % 客户端发的场景id只是用来做调试验证的！
    case TargetSceneId /= CurSceneId of
        true ->
            skip;
        false ->
            case lib_scene:is_exists(CurSceneId) of
                false ->
                    ?ASSERT(false, CurSceneId),
                    skip;
                true ->
                    case lib_scene:get_dynamic_teleporter_list(CurSceneId) of
                        [] ->
                            ?TRACE("PT_GET_SCENE_DYNAMIC_TELEPORTER_LIST, none... CurSceneId=~p~n", [CurSceneId]),
                            skip;
                        TeleporterList ->
                            {ok, BinData} = pt_12:write(?PT_GET_SCENE_DYNAMIC_TELEPORTER_LIST, [CurSceneId, TeleporterList]),
                            lib_send:send_to_sock(PS, BinData)
                    end
            end
    end,
    void;





%% 加载场景：获取场景AOI范围的信息
handle(?PT_GET_SCENE_AOI_INFO, PS, TargetSceneId) ->
    CurPos = player:get_position(player:id(PS)),
    case TargetSceneId /= CurPos#plyr_pos.scene_id of
        true ->
            skip;
        false ->
            %%% ?ASSERT(__SceneId =:= CurPos#plyr_pos.scene_id, {__SceneId, CurPos#plyr_pos.scene_id}),
            mod_go:notify_AOI_info_to_player(PS, CurPos)
    end,
    void;








% 作废！！
% %% 仅用于调试！
% handle(?PT_DBG_SPAWN_MON_TO_SCENE_FOR_PLAYER_WNC, PS, [MonNo, SceneId]) ->
%     mod_scene:spawn_mon_to_scene_for_player_WNC(PS, MonNo, SceneId);








%% 仅调试用的协议：获取场景内的明雷怪列表
handle(?PT_DBG_GET_SCENE_MON_LIST, PS, SceneId) ->
    MonIdList = lib_scene:get_scene_mon_ids(SceneId),
    F = fun(MonId) ->
            case mod_mon:get_obj(MonId) of
                null ->
                    ?ASSERT(false),
                    null;
                Mon ->
                    {X, Y} = mod_mon:get_xy(Mon),
                    NameBin = mod_mon:get_name(Mon),
                    <<
                        MonId : 32,
                        (mod_mon:get_no(Mon)) : 32,
                        X : 16,
                        Y : 16,
                        (mod_mon:get_lv(Mon)) : 8,
                        0 : 32, %%(mod_mon:get_bmon_group_no(Mon)) : 32,
                        (byte_size(NameBin)) : 16,
                        NameBin /binary
                    >>
            end
        end,
    Bin = list_to_binary([F(X) || X <- MonIdList]),
    Bin2 = <<SceneId:32, (length(MonIdList)):16, Bin/binary>>,
    Bin3 = pt:pack(?PT_DBG_GET_SCENE_MON_LIST, Bin2),
    lib_send:send_to_sock(PS, Bin3);







handle(_Cmd, _PS, _Data) ->
    ?ASSERT(false, {_Cmd, _Data}),
    {error, "pp_scene no match"}.







%% =============================================================================================




%% 做走路的合法性检测
%% @return: ok | fail
check_player_move(PlayerId, TargetSceneId, TargetX, TargetY) ->
    case player:get_position(PlayerId) of
        null ->
            ?ASSERT(false, {PlayerId, TargetSceneId, TargetX, TargetY}),
            fail;
        OldPos ->
            CurSceneId = OldPos#plyr_pos.scene_id,
            case TargetSceneId /= CurSceneId of % 注意：队员跟随队长跳转场景时，可能会因并发的原因导致TargetSceneId和CurSceneId不相同，故这里做判断！ -- huangjf
                true ->
                    %%?DEBUG_MSG("PT_PLAYER_MOVE, not same scene id!! PlayerId=~p, SceneId=~p, NewX=~p, NewY=~p, CurSceneId=~p, CurX=~p, CurY=~p~n",
                    %%                [PlayerId, SceneId, NewX, NewY, CurSceneId, OldPos#plyr_pos.x, OldPos#plyr_pos.y]),
                    ?DEBUG_MSG("check_player_move() failed, PlayerId:~p, TargetSceneId:~p, CurSceneId:~p", [PlayerId, TargetSceneId, CurSceneId]),
                    fail;
                false ->
                    case (OldPos#plyr_pos.x == TargetX)
                    andalso (OldPos#plyr_pos.y == TargetY) of
                        true ->
                            %%?ASSERT(false, {TargetX, TargetY}),
                            % ?TRACE("check_player_move(), same pos and skip...~n"),
                            % ?ASSERT(false, {OldPos, TargetSceneId, TargetX, TargetY}),
                            fail;
                        false ->
                            % 场景对象是否存在？
                            case lib_scene:is_exists(TargetSceneId) of
                                false ->
                                    % ?ERROR_MSG("[pp_scene] check_player_move() error!! scene not exists! OldPos:~w, TargetSceneId:~p, TargetX:~p, TargetY:~p",
                                    %                         [OldPos, TargetSceneId, TargetX, TargetY]),
                                    fail;
                                true ->
                                    SceneNo = player:fast_get_my_cur_scene_no(CurSceneId),
                                    % ?TRACE("check_player_move(), CurSceneId:~p, SceneNo:~p~n", [CurSceneId, SceneNo]),
                                    SceneTpl = mod_scene_tpl:get_tpl_data(SceneNo),  %%%data_scene:get(SceneNo),
                                    % 坐标是否合法？
                                    case mod_scene_tpl:is_xy_valid(SceneTpl, TargetX, TargetY) of
                                        false ->
                                            ?ASSERT(false, {TargetX, TargetY, SceneTpl}),
                                            fail;
                                        true ->
                                            % 是否跳越九宫格？（跳越是指：不是在同一个九宫格内移动，并且也不是移动到相邻的九宫格，而是直接移动到相邻的九宫格以外的其他格子）
                                            DiffX = abs(TargetX - OldPos#plyr_pos.x),
                                            DiffY = abs(TargetY - OldPos#plyr_pos.y),
                                            case (DiffX > ?GRID_WIDTH) orelse (DiffY > ?GRID_HEIGHT) of
                                                true ->
                                                    %%?ASSERT(false, {OldPos, TargetSceneId, TargetX, TargetY}),
                                                    ?DEBUG_MSG("player leap over grid! OldPos:~w, TargetSceneId:~p, TargetX:~p, TargetY:~p", [OldPos, TargetSceneId, TargetX, TargetY]),
                                                    {fail, skip_scene_grid, OldPos, SceneTpl};
                                                false ->
                                                    {ok, OldPos, SceneTpl}
                                            end
                                    end
                            end
                    end
            end
    end.



%% 尝试触发暗雷
try_trigger_trap(SceneTpl, PS, NewPos) ->
    case player:is_in_team(PS)
    andalso (not player:is_leader(PS))
    andalso (not player:is_tmp_leave_team(PS)) of
        true ->
            skip;
        false ->
            % ?TRACE("~n~n................player move and try_trigger_trap.............~n~n"),
            ply_scene:try_trigger_trap(SceneTpl, PS, NewPos)
    end.
    




%%
%%
%% %% 更新场景cell信息到ets
%% update_scene_cell_to_ets(SceneCell_Latest) ->
%%     ets:insert(?ETS_SCENE_CELL, SceneCell_Latest).
%%
%%
%%
%% %% 玩家离开原场景cell
%% leave_old_scene_cell(player, PlayerId, OldSceneCellKey) ->
%%     SceneCell = get_scene_cell_from_ets(OldSceneCellKey),
%%     ?ASSERT(lists:member(PlayerId, SceneCell#scene_cell.player_ids)),  % 断言原场景cell中有该玩家的记录
%%
%%     NewPlayerIds = SceneCell#scene_cell.player_ids -- [PlayerId],
%%     update_scene_cell_to_ets(SceneCell#scene_cell{player_ids = NewPlayerIds});
%%
%% %% 怪物离开原场景cell
%% leave_old_scene_cell(mon, MonId, OldSceneCellKey) ->
%%     SceneCell = get_scene_cell_from_ets(OldSceneCellKey),
%%     ?ASSERT(lists:member(MonId, SceneCell#scene_cell.mon_ids)),  % 断言原场景cell中有该怪物的记录
%%
%%     NewMonIds = SceneCell#scene_cell.mon_ids -- [MonId],
%%     update_scene_cell_to_ets(SceneCell#scene_cell{mon_ids = NewMonIds});
%%
%% %% 会走动的智能npc离开原场景cell
%% leave_old_scene_cell(npc, NpcId, OldSceneCellKey) ->
%%     SceneCell = get_scene_cell_from_ets(OldSceneCellKey),
%%     ?ASSERT(lists:member(NpcId, SceneCell#scene_cell.npc_ids)),  % 断言原场景cell中有该npc的记录
%%
%%     NewNpcIds = SceneCell#scene_cell.npc_ids -- [NpcId],
%%     update_scene_cell_to_ets(SceneCell#scene_cell{npc_ids = NewNpcIds}).
%%
%%
%%
%%
%% %% 玩家进入新场景cell
%% enter_new_scene_cell(player, PlayerId, NewSceneCellKey) ->
%%     SceneCell = get_scene_cell_from_ets(NewSceneCellKey),
%%     ?ASSERT(not lists:member(PlayerId, SceneCell#scene_cell.player_ids)),  % 断言新场景cell中没有该玩家的记录
%%
%%     NewPlayerIds = [PlayerId | SceneCell#scene_cell.player_ids],
%%     update_scene_cell_to_ets(SceneCell#scene_cell{player_ids = NewPlayerIds});
%%
%% %% 怪物进入新场景cell
%% enter_new_scene_cell(mon, MonId, NewSceneCellKey) ->
%%     SceneCell = get_scene_cell_from_ets(NewSceneCellKey),
%%     ?ASSERT(not lists:member(MonId, SceneCell#scene_cell.mon_ids)),  % 断言新场景cell中没有该怪物的记录
%%
%%     NewMonIds = [MonId | SceneCell#scene_cell.mon_ids],
%%     update_scene_cell_to_ets(SceneCell#scene_cell{mon_ids = NewMonIds});
%%
%% %% 会走动的智能npc进入新场景cell
%% enter_new_scene_cell(npc, NpcId, NewSceneCellKey) ->
%%     SceneCell = get_scene_cell_from_ets(NewSceneCellKey),
%%     ?ASSERT(not lists:member(NpcId, SceneCell#scene_cell.npc_ids)),  % 断言新场景cell中没有该npc的记录
%%
%%     NewNpcIds = [NpcId | SceneCell#scene_cell.npc_ids],
%%     update_scene_cell_to_ets(SceneCell#scene_cell{npc_ids = NewNpcIds}).
%%
%%

% ********************************************************************




































% %%加载场景
% handle(12002, Status, load_scene) ->
% 	?TRACE("handle 12002 ~n"),
%     case ets:lookup(?ETS_SCENE, Status#player_status.scene_id) of
%         [] ->
%             skip;
%         [Scene] ->
%             %当前场景玩家信息
%             SceneUser = lib_scene:get_broadcast_user(Status#player_status.scene_id, Status#player_status.line_id, Status#player_status.x, Status#player_status.y),
% 			?TRACE("handle get_broadcast_user ~n"),
%             %当前怪物信息
%             SceneMon = lib_scene:get_scene_mon_ids(Status#player_status.scene_id),
% 			?TRACE("handle SceneMon ~n"),
%             %当前元素信息
%             SceneElem = Scene#ets_scene.elem,
%             %当前npc信息
%             SceneNpc = lib_scene:get_scene_npc_ids(Status#player_status.scene_id),
% 			%%当前关卡列表信息
% 			SceneLevelList = Scene#ets_scene.level_list,
% 			%%当前场景中的交互信息
% 			SceneItemList = lib_scene:get_scene_item(Status#player_status.id, Scene#ets_scene.item),
%             {ok, BinData} = pt_12:write(12002, {SceneUser, SceneMon, SceneElem, SceneNpc,SceneLevelList,SceneItemList}),
%             lib_send:send_one(Status#player_status.socket, BinData),

%             % NPC状态
%             lib_scene:refresh_npc_ico(Status),
%             ok
%     end;



% %%切换场景
% %% @para: Id => 新场景的id
% handle(12005, _Status, _Id0) ->
% %     ?TRACE("12005, change scene: Id: ~p, SceneId: ~p~n", [Status#player_status.id, Id0]),
% % 	OldScene = Status#player_status.scene_id, % 切换时玩家原先所在的场景
% % 	% 从帮派驻地退出需要特殊处理
% % 	GuildScene =
% % 		Id0 == 101 andalso Status#player_status.guild_id =/= 0 andalso
% %         ((lib_scene:get_res_id(OldScene) == ?GUILD_SCENE_RES_ID orelse
% %           lib_scene:get_res_id(OldScene) == ?GUILD_PVP_SCENE_RES_ID orelse
% %           lib_scene:get_res_id(OldScene) == ?GUILD_BOSS_SCENE)),
% % 	CheckOut = lib_scene:is_special_scene1(OldScene),
% % 	Id =
% % 		if GuildScene ->
% % 			   handle(12092, Status, 0),
% % 			   false;
% % 		   CheckOut ->
% % 			   [OScene,_X,_Y] = Status#player_status.out,
% % 			   OScene;
% % 		   true ->
% % 			   Id0
% % 		end,
% % 	case Id of
% % 		false ->
% % 			skip;
% % 		OldScene ->
% % 			{Plot,Status1} = lib_scene:plot(Id,Status),
% % 			{ok, BinData} = pt_12:write(12005, [Id, Status#player_status.x, Status#player_status.y, <<>>, Id, Plot, 0]),
% % 			lib_send:send_one(Status#player_status.socket, BinData),
% % 			{ok, no_save_online, Status1};
% % 		_ ->
% % 			case lib_scene:check_enter(Status, Id) of
% % 				skip ->
% % 					?TRACE("pp_scene: 12005 check_enter return skip.............~n"),
% % 					skip;
% % 				{false, _, _, _, Msg, _, _} ->
% %                     ?TRACE("pp_scene: 12005: check_enter return false.............~n"),
% % 					{ok, BinData} = pt_12:write(12005, [0, 0, 0, Msg, Id]),
% % 					lib_send:send_one(Status#player_status.socket, BinData);
% % 				{true, Id1, X, Y, Name, Sid, Status0} ->
% % 					?TRACE("pp_scene: 12005: check_enter return true. SceneId: ~p~n",[{Id1, X, Y,Sid}]),
% % 					{Plot,Status1} = lib_scene:plot(Sid,Status0),
% % 					% 切换场景成功
% % 					case lib_player:is_in_team(Status1)
% % 							 andalso lib_scene:is_dungeon_scene(Id1)
% % 							 andalso (not lib_scene:is_dungeon_scene(OldScene)) of
% % 						true ->   % 队伍从副本外进入副本
% % 							mod_team_new:enter_dungeon(Status1#player_status.pid_team, {Id1, X, Y, Name, Sid});
% % 						false ->  % 其他情况（包括队伍进副本后，队员在副本各个子场景之间切换的情况）
% % 							{Plot1, Plot2} =
% % 								if Plot == 0 -> get_plot(Sid, Status1);
% % 								   true ->
% % 									   {Plot,0}
% % 								end,
% % %% 							if Plot1 =/= 0 ->
% % %% 							?TRACE("PLOT         ------------------- ~p~n",[Plot1]);
% % %% 							   true ->
% % %% 								   skip
% % %% 							end,
% % 							%告诉原来场景玩家你已经离开
% % 							Status3 = lib_scene:change_scene(Status1, {Id1, Sid, Name, X, Y, Plot1, Plot2}),

% %                             %%通知玩家离开或进入帮派大战准备或战斗场景
% %                             lib_scene:notify_pvp_scene_change(Status3, OldScene, Status3#player_status.scene_id),
% % 							{ok, Status3}
% % 					end
% % 			end
% % 	end;
% 	todo_here;








% %% 获得剧情
% get_plot(_Sid, _Status1)->
% 	% case lib_scene:is_guild_dungeon(Sid) of
% 	% 	true ->
% 	% 		{0,0};
% 	% 	false ->
% 	% 		case lib_dungeon:get_config_data(mod_dungeon:get_dungeon_id(Sid)) of
% 	% 			[] ->
% 	% 				{0,0};
% 	% 			Dinfo ->
% 	% 				PassId = Dinfo#dungeon.pass_id,
% 	% 				[{Reply1,Task1},{Reply2,Task2}] = data_plot:get(Sid),
% 	% 				Reply = {Reply1,Reply2},

% 	% 				if Reply == {0,0} ->
% 	% 					   Reply;
% 	% 				   true ->
% 	% 					   try lists:member(PassId, Status1#player_status.pass_finish) of
% 	% 						   false ->
% 	% 							   ReplyFa1 =
% 	% 								   if Task1 == 0 ->
% 	% 										  0;
% 	% 									  true ->
% 	% 										  case (Reply1 == 0 orelse lib_task:in_trigger( Task1, Status1)) of
% 	% 											  true ->
% 	% 												  Reply1;
% 	% 											  false ->
% 	% 												  0
% 	% 										  end
% 	% 								   end,
% 	% 							   ReplyFa2 =
% 	% 								   if Task2 == 0 ->
% 	% 										  0;
% 	% 									  true ->
% 	% 										  case (Reply2 == 0 orelse lib_task:in_trigger( Task2, Status1)) of
% 	% 											  true ->
% 	% 												  Reply2;
% 	% 											  false ->
% 	% 												  0
% 	% 										  end
% 	% 								   end,
% 	% 							   {ReplyFa1,ReplyFa2};
% 	% 						   true ->
% 	% 							   ReplyOk1 =
% 	% 								   case (Reply1 == 0 orelse lib_task:in_trigger( Task1, Status1)) of
% 	% 									   true ->
% 	% 										   Reply1;
% 	% 									   false ->
% 	% 										   0
% 	% 								   end,
% 	% 							   ReplyOk2 = case(Reply2 == 0 orelse lib_task:in_trigger(Task2, Status1)) of
% 	% 											  true ->
% 	% 												  Reply2;
% 	% 											  false ->
% 	% 												  0
% 	% 										  end,
% 	% 							   %% 									?TRACE("Replyfgdagdagag2 ~p~n",[{ReplyOk1, ReplyOk2}]),
% 	% 							   {ReplyOk1, ReplyOk2}
% 	% 					   catch
% 	% 						   T:Err ->
% 	% 							   ?ERROR_MSG("-------mod_pass error :Type:~p, Err:~p", [T, Err]),
% 	% 							   ?TRACE("Replyfgdagdagag3 ~p~n",[Err]),
% 	% 							   {0,0}
% 	% 					   end
% 	% 				%% 						   ?TRACE("Replyfgdagdagag4 ~p~n",[Reply3]),
% 	% 				%% 						   Reply3
% 	% 				end
% 	% 		end
% 	% end.
% 	todo_here.
