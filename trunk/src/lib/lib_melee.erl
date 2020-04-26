%%%------------------------------------
%%% @author 严利宏 <542430172@qq.com>
%%% @copyright UCweb 2014.11.5
%%% @doc 女妖乱斗函数库.
%%% @end
%%%------------------------------------

-module(lib_melee).

-include("abbreviate.hrl").
-include("buff.hrl").
-include("record/battle_record.hrl").
-include("common.hrl").
-include("record.hrl").
-include("player.hrl").
-include("monster.hrl").
-include("prompt_msg_code.hrl").
-include("log.hrl").
-include("ets_name.hrl").
-include("battle.hrl").
-include("melee.hrl").
-include("pt_28.hrl").

-compile(export_all).

%% --------------------------------
%% 玩家登陆
%% --------------------------------
login(PS) ->
    PlayerId = player:id(PS),
    case get_melee_ply_info(PlayerId) of
        null -> % 无玩家乱斗信息则尝试从数据库加载
            case db:select_row(role_melee_info, "status, ball_num, scene_no, create_time", [{id, PlayerId}]) of
                [] -> skip;
                [Status, BallNum, SceneNo, CreateTime] -> 
                    set_melee_ply_info(#ets_melee_ply_info{id=PlayerId, status=Status, ball_num=BallNum, create_time=CreateTime, scene_no=SceneNo})
            end,
            ok;
        _ -> skip
    end.
%% --------------------------------
%% 玩家最终退出操作---写数据库
%% --------------------------------
final_logout(PS) ->
    PlayerId = player:id(PS),
    case get_melee_ply_info(PlayerId) of
        null -> skip;
        PlyInfo when is_record(PlyInfo, ets_melee_ply_info) ->
            case db:replace(role_melee_info, [{id, PlayerId}
                                             ,{status, PlyInfo#ets_melee_ply_info.status}
                                             ,{ball_num, PlyInfo#ets_melee_ply_info.ball_num}
                                             ,{create_time, PlyInfo#ets_melee_ply_info.create_time}
                                             ,{scene_no, PlyInfo#ets_melee_ply_info.scene_no}
                                         ]) of
                1 -> % 执行成功
                    %del_melee_ply_info(PlayerId),
                    ok;
                _ -> 
                    skip
            end
    end.    

%% -------------------------
% 活动开启 （活动管理调用）
%% -------------------------
melee_open() ->
    spawn(fun() ->
        case get_melee_status() of
            MeleeStatus when MeleeStatus#ets_melee_status.open_status =:= 1  -> skip;
            _ ->
                % 初始化话玩家信息表
                ets:delete_all_objects(?ETS_MELEE_PLY_INFO),
                MeleeInfoList = db:select_all(role_melee_info, "id, status, ball_num, scene_no, create_time", []),
                [set_melee_ply_info(#ets_melee_ply_info{id = Id
                                                       ,status = Status
                                                       ,ball_num = BallNum
                                                       ,scene_no = SceneNo
                                                       ,create_time = CreateTime
                                                   }) || [Id, Status, BallNum, SceneNo, CreateTime] <- MeleeInfoList],
                % 创建活动场景
                F = fun({MinLv, MaxLv, SceneNo}) ->
                        case mod_scene:create_scene(SceneNo) of
                            {ok, SceneId} ->
                                #melee_scene{min_lv = MinLv
                                            ,max_lv = MaxLv
                                            ,scene_id = SceneId
                                            ,scene_no = SceneNo
                                        };
                            _ -> 
                                ?ERROR_MSG("melee open create scene [~p] fail!!! ", [SceneNo]),
                                skip
                        end
                end,
                SceneList = [S || S <- [F(C) || C <- get_melee_scene_no_config()] , S=/=skip],
                % 开启刷怪进程
                mod_melee:start_link(SceneList),
                % 保存活动数据
                ets:insert(?ETS_MELEE_STATUS, #ets_melee_status{open_status=1, act_data=[], scene_list=SceneList}),
                ok
        end
    end).

%% -------------------------
% 活动结束 （活动管理调用）
%% -------------------------
melee_close() ->
    spawn(fun() ->
        case get_melee_status() of
            null -> skip;
            MeleeStatus ->
                % 结算场景中玩家的龙珠
                [begin 
%%                     set_melee_ply_info(PlyInfo#ets_melee_ply_info{status=?MELEE_PLY_INFO_STATUS_FINISH}),
                    
					send_melee_email_reward(PlyInfo, player:get_PS(PlyInfo#ets_melee_ply_info.id), ?SUBMIT_BALL_T_SYS),
					
                    case player:get_PS(PlyInfo#ets_melee_ply_info.id) of
                        PS when is_record(PS, player_status) ->
                            case player:is_in_melee(PS) of
                                true ->
                                    % 结束战斗进程
									mod_battle:force_end_battle_no_win_side(PS),
									ServerId = player:get_server_id(PS),
									PlayerId = player:get_id(PS),
									% 脱离队伍
									mod_team:quit_team(PS),
									% 退出场景
									?TRY_CATCH(ply_scene:leave_scene_on_logout(PS), ErrReason_LeaveScene),
									{ok, BinData} = pt_28:write(?PT_MELEE_LEAVE_SCENE, [0]),
									lib_send:send_to_sid(PS, BinData),
									
									sm_cross_server:rpc_cast(ServerId, ?MODULE, local_exit_cross, [PlayerId]),
									
                                    % 踢出场景                                  
%%                                     {SceneId, X, Y} = {mod_global_data:get_main_city_scene_no(), 163, 135},
%%                                     gen_server:cast(player:get_pid(PS), {'do_single_teleport', SceneId, X, Y}),
                                    ok;
                                false -> skip
                            end;
                        _ -> 
                            skip
                    end,
                    ok
                 end || PlyInfo <- ets:tab2list(?ETS_MELEE_PLY_INFO)],
%%                  end || PlyInfo <- ets:tab2list(?ETS_MELEE_PLY_INFO), PlyInfo#ets_melee_ply_info.status=:=?MELEE_PLY_INFO_STATUS_APPLY],
                % 关闭刷怪进程
                mod_melee:stop(),
                % 清除活动场景
                [mod_scene:clear_scene(S#melee_scene.scene_id) || S <- MeleeStatus#ets_melee_status.scene_list],
                % 删除活动数据
                db:delete(role_melee_info, []),
                ets:delete_all_objects(?ETS_MELEE_PLY_INFO),
                ets:delete_all_objects(?ETS_MELEE_STATUS),
                ok
        end
    end).


%% 获取场景id
get_melee_scene_id() ->
	case get_melee_status() of
		null ->
			null;
		MeleeStatus ->
			case MeleeStatus#ets_melee_status.scene_list of
				[#melee_scene{scene_id = SceneId}|_] ->
					SceneId;
				_ ->
					null
			end
	end.


%% 泡点通知玩家定时加经验
interval_add_paodian_exp(PlayerId, PaodianType, BallNum) ->
	case player:get_pid(PlayerId) of
		Pid when is_pid(Pid) ->
			mod_player:cross_apply_cast(Pid, ?MODULE, do_interval_add_paodian_exp, [PlayerId, PaodianType, BallNum]);
		_ ->
			ok
	end.


do_interval_add_paodian_exp(PlayerId, PaodianType, BallNum) ->
	PS = player:get_PS(PlayerId),
	PaodianConfig = data_paodian:get(PaodianType),
	case player:check_need_price(PS,PaodianConfig#paodian_config.price_type,PaodianConfig#paodian_config.price) of
		ok ->
			player:cost_money(PS, PaodianConfig#paodian_config.price_type,PaodianConfig#paodian_config.price, [?LOG_GM,"paodian"]),
			add_paodian_exp(PS,PaodianConfig#paodian_config.exp, BallNum);
		_ ->
			% 金钱不足设置为默认泡点
			ply_setting:set_paodian_type(PS,0),
			% 每分钟获经验值
			lib_melee:add_paodian_exp(PS,?POPULAR_PAODIAN_ADD)
	end.



%% local_exit_cross
%% 退出跨服状态，并且回到主城
local_exit_cross(PlayerId) ->
	gen_server:cast(player:get_pid(PlayerId), {apply_cast, ?MODULE, do_local_exit_cross, [PlayerId]}).

do_local_exit_cross(PlayerId) ->
	player:mark_cross_local(PlayerId),
	% 脱离队伍
	PS = player:get_PS(PlayerId),
	mod_team:quit_team(PS),
	% 传回原场景
	{SceneId, X, Y} = 
		case get('melee_prev_pos') of
			undefined -> ply_scene:get_adjusted_pos(player:get_race(PS), player:get_lv(PS));
			_D ->_D
		end,
	gen_server:cast(player:get_pid(PS), {'do_single_teleport', SceneId, X, Y}).
%% 	{ok, BinData} = pt_28:write(?PT_MELEE_LEAVE_SCENE, [0]),
%% 	lib_send:send_to_sid(PS, BinData).

%%=========================================================================
%% 内部接口函数
%%=========================================================================

%% 检查参加活动是否合法,也是rpc到远程节点去检查？
check_join_melee(PS) ->
	lib_melee:melee_open(),
	case sm_cross_server:rpc_call(?MODULE, get_melee_status, []) of
%%     case get_melee_status() of
        {ok, MeleeStatus} when MeleeStatus#ets_melee_status.open_status=:=1 ->
            TeamFlag = 
                case player:is_in_team(PS) of
                    true ->
                        case player:is_leader(PS) of
                            false -> % 在队伍中但是不是队长
                                {false, ?PM_MELEE_ERROR_APPLY_NOT_LEADER};
                            true ->
                                TeamId = player:get_team_id(PS),
                                case mod_team:is_all_member_in_normal_state(TeamId) of
                                    false -> % 队伍中有队员状态异常
                                        {false, ?PM_MELEE_ERROR_TM_NO_RETURN};
                                    true ->
                                        LvLimitList = get_melee_lv_limit_list(),
                                        case mod_team:is_all_member_in_lv_limit(TeamId, LvLimitList) of
                                            false -> % 队伍中有队员等级不符合
                                                {false, ?PM_MELEE_ERROR_APPLY_TEAM_LV_LIMIT};
                                            true -> {true, mod_team:get_all_member_id_list(TeamId)}
                                        end
                                end
                        end;
                    false -> {true, [player:id(PS)]}
            end,
            case TeamFlag of
                {false, ErrCode} -> {false, ErrCode};
                {true, JoinIdList} ->
                    case check_melee_info_status_finish(JoinIdList) of
                        {false, ErrCode} -> {false, ErrCode};
                        true -> {true, JoinIdList}
                    end
            end;
        _ -> % 活动未开启
			sm_cross_server:rpc_cast(lib_melee, melee_open, []),
            {false, ?PM_MELEE_ERROR_NO_OPEN}
    end.

% 检查是否有人已经完成比赛
check_melee_info_status_finish([]) -> true;
check_melee_info_status_finish([PlayerId | JoinIdRest]) ->
	true.
%%     case get_melee_ply_info(PlayerId) of
%%         PlyInfo when is_record(PlyInfo, ets_melee_ply_info),PlyInfo#ets_melee_ply_info.status=:=?MELEE_PLY_INFO_STATUS_FINISH ->
%%             {false, ?PM_MELEE_ERROR_ALREADY_FINISH};
%%         _ -> check_melee_info_status_finish(JoinIdRest)
%%     end.
% 检查是否有人已经报名比赛
check_melee_info_status_already_apply([]) -> true;
check_melee_info_status_already_apply([PlayerId | JoinIdRest]) ->
	true.
%%     case get_melee_ply_info(PlayerId) of
%%         PlyInfo when PlyInfo#ets_melee_ply_info.status=:=?MELEE_PLY_INFO_STATUS_APPLY ->
%%             {false, ?PM_MELEE_ERROR_ALREADY_APPLY};
%%         PlyInfo when PlyInfo#ets_melee_ply_info.status=:=?MELEE_PLY_INFO_STATUS_FINISH ->
%%             {false, ?PM_MELEE_ERROR_ALREADY_FINISH};
%%         _ ->
%%             check_melee_info_status_already_apply(JoinIdRest)
%%     end.
% 检查是否有人没有报名比赛
check_melee_info_status_no_apply([]) -> true;
check_melee_info_status_no_apply([PlayerId | JoinIdRest]) ->
	true.
%%     case get_melee_ply_info(PlayerId) of
%%         null -> 
%%             {false, ?PM_MELEE_ERROR_NO_APPLY};
%%         PlyInfo when PlyInfo#ets_melee_ply_info.status=:=?MELEE_PLY_INFO_STATUS_NO_APPLY ->
%%             {false, ?PM_MELEE_ERROR_NO_APPLY};
%%         PlyInfo when PlyInfo#ets_melee_ply_info.status=:=?MELEE_PLY_INFO_STATUS_FINISH -> 
%%             {false, ?PM_MELEE_ERROR_ALREADY_FINISH};
%%         _ -> 
%%             check_melee_info_status_no_apply(JoinIdRest)
%%     end.
% 报名,在跨服节点去处理，rpc过去
melee_apply(PlayerId) ->
    case get_melee_ply_info(PlayerId) of
        null ->
            PlyMeleeInfo = #ets_melee_ply_info{id=PlayerId
                                              ,status=1
                                              ,create_time=util:unixtime()
                                          },
            ets:insert(?ETS_MELEE_PLY_INFO, PlyMeleeInfo),
            ok;
        _ -> skip
    end.

%% --------------------------------
%% 进入乱斗场景
%% --------------------------------
enter_melee_scene(PS) ->
    MeleeStatus = get_melee_status(),  
    case select_melee_enter_scene(MeleeStatus#ets_melee_status.scene_list, player:get_lv(PS)) of
        null -> 
            lib_send:send_prompt_msg(PS, ?PM_MELEE_ERROR_LV_LIMIT);
        EnterScene ->
            % 记录进入的场景编号（写日志的时候要用）
            set_melee_ply_info_scene_no(PS, EnterScene#melee_scene.scene_no),
            % 设置原来位置
            PrevPos = case player:get_position(player:id(PS)) of
                null -> ply_scene:get_born_place(PS);
                Pos -> {Pos#plyr_pos.scene_id, Pos#plyr_pos.x, Pos#plyr_pos.y}
            end,
            put('melee_prev_pos', PrevPos),
            % 传送进活动场景
            {X, Y} = get_melee_born_place_config(EnterScene#melee_scene.scene_no),
            gen_server:cast(player:get_pid(PS), {'do_teleport', EnterScene#melee_scene.scene_id, X, Y}),
			%% 通知玩家服务器将玩家从场景剔除，等玩家在远程服务器退出的时候再把玩家放回主城
			PlayerId = player:get_id(PS),
			sm_cross_server:rpc_cast(player:get_server_id(PS), ?MODULE, notice_local_enter_melee, [PlayerId]),
			ok
    end.


%% notice_local_enter_melee
notice_local_enter_melee(PlayerId) ->
	gen_server:cast(player:get_pid(PlayerId), {apply_cast, ?MODULE, do_notice_local_enter_melee, [PlayerId]}).

do_notice_local_enter_melee(PlayerId) ->
	%% 远程已经进入场景了，本地记录位置，并且在本地场景隐藏玩家，标记玩家进程状态为跨服，转发跨服相关的协议到跨服服务器
	% 设置原来位置
	PS = player:get_PS(PlayerId),
	PrevPos = case player:get_position(player:id(PS)) of
				  null -> ply_scene:get_born_place(PS);
				  Pos -> {Pos#plyr_pos.scene_id, Pos#plyr_pos.x, Pos#plyr_pos.y}
			  end,
	put('melee_prev_pos', PrevPos),
	%% 
	player:mark_cross_remote(PS),
	%% 离开本服场景
	?TRY_CATCH(ply_scene:leave_scene_on_logout(PS), ErrReason_LeaveScene),
	ok.

% 抽出该进入的活动场景唯一Id
select_melee_enter_scene(SceneList, Lv) ->
    case [S || S <- SceneList, S#melee_scene.min_lv =< Lv, Lv =< S#melee_scene.max_lv] of
        [] -> null;
        [Scene | _] -> Scene
    end.

%% --------------------------------
%% 退出乱斗场景 （上缴龙珠也发这条），通知远程服务器让玩家回到主城
%% --------------------------------
melee_leave_scene(PS, Type) ->
	
    ?ylh_Debug("leave_scene ~p~n", [player:id(PS)]),
    % 场景类型判断 
    case lib_scene:is_melee_scene(player:get_scene_id(player:get_id(PS))) of
        false -> skip;
        true ->
            case get_melee_ply_info(PS) of
                PlyInfo -> %%when PlyInfo#ets_melee_ply_info.status=:=?MELEE_PLY_INFO_STATUS_APPLY ->
                    % 上缴龙珠
%%                     set_melee_ply_info(PlyInfo#ets_melee_ply_info{status=?MELEE_PLY_INFO_STATUS_FINISH}),
%%                     set_melee_ply_info(PlyInfo),
                    
					send_melee_email_reward(PlyInfo, PS, ?SUBMIT_BALL_T_NORMAL),
					
					case Type of
						1 ->
							ServerId = player:get_server_id(PS),
							PlayerId = player:get_id(PS),
							% 脱离队伍
							mod_team:quit_team(PS),
							% 退出场景
							?TRY_CATCH(ply_scene:leave_scene_on_logout(PS), ErrReason_LeaveScene),
							%% 设置pos信息为0
							Pos = player:get_position(PS),
                    		player:set_position(PlayerId, Pos#plyr_pos{scene_id = 0}),
%% 							{SceneId, X, Y} = 
%% 								case get('melee_prev_pos') of
%% 									undefined -> ply_scene:get_adjusted_pos(player:get_race(PS), player:get_lv(PS));
%% 									_D ->_D
%% 								end,
%% 							gen_server:cast(player:get_pid(PS), {'do_single_teleport', SceneId, X, Y}),
							{ok, BinData} = pt_28:write(?PT_MELEE_LEAVE_SCENE, [0]),
							lib_send:send_to_sid(PS, BinData),
							
							sm_cross_server:rpc_cast(ServerId, ?MODULE, local_exit_cross, [PlayerId]),
							
							
							ok;
						_ ->
							skip
					end;
                _Err -> 
                    ?ASSERT(false, {player:id(PS), _Err}),
                    error
            end
    end,
    ok.

% 获得泡点经验
add_paodian_exp(PS,Exp,BallNum) ->
%%     case get_melee_ply_info(PS) of
%%         PlyInfo when PlyInfo#ets_melee_ply_info.status=:=?MELEE_PLY_INFO_STATUS_APPLY ->
%%         PlyInfo when erlang:is_record(PlyInfo, ets_melee_ply_info) ->
            % 上缴龙珠
%%             BallNum = PlyInfo#ets_melee_ply_info.ball_num,
            GoodsNum = get_melee_reward_num(BallNum),
            BeiLv = get_melee_paodian(GoodsNum),
            AddExp = util:ceil(Exp * BeiLv),
            player:add_exp(PS, AddExp , [?LOG_GM,"paodian"]),
            ok.
%%         _Err -> 
%%             ?ASSERT(false, {player:id(PS), _Err}),
%%             error
%%     end.

% 统一邮件发送奖励 
% Type : 1-正常提交龙珠 2-系统主动提交龙珠
send_melee_email_reward(PlyInfo, PS, Type) ->
	case PlyInfo#ets_melee_ply_info.ball_num of
		0 ->
			ok;
		_BallNum ->
%% 			GoodsNum = get_melee_reward_num(BallNum),
%% 			{EmailTitle, EmailContent1, EmailContent2, GoodsNo} = get_email_config(BallNum, GoodsNum),
%% 			EmailContent = 
%% 				case BallNum =:= 0 of
%% 					true -> EmailContent2;
%% 					false -> EmailContent1
%% 				end,
%% 			LogInfo = case Type of
%% 						  ?SUBMIT_BALL_T_NORMAL -> "prize";
%% 						  ?SUBMIT_BALL_T_SYS -> "prize"
%% 					  end,
%% 			lib_mail:send_sys_mail(PlyInfo#ets_melee_ply_info.id 
%% 								   ,EmailTitle
%% 								   ,EmailContent
%% 								   ,[{GoodsNo, 1, GoodsNum}]
%% 								   ,[?LOG_MELEE, LogInfo]
%% 								  ),
			set_melee_ball_num(PlyInfo#ets_melee_ply_info.id, 0),
			ServerId = player:get_server_id(PS),
			PlayerId = player:get_id(PS),
			sm_cross_server:rpc_cast(ServerId, ?MODULE, send_melee_email_reward_local, [PlayerId, PlyInfo, Type])
	end.
%% 	lib_log:statis_melee(PS
%% 						 ,PlyInfo#ets_melee_ply_info.ball_num
%% 						 ,util:unixtime() - PlyInfo#ets_melee_ply_info.create_time
%% 						 ,PlyInfo#ets_melee_ply_info.scene_no
%% 						).

send_melee_email_reward_local(PlayerId, PlyInfo, Type) ->
 	BallNum = PlyInfo#ets_melee_ply_info.ball_num,
	GoodsNum = get_melee_reward_num(BallNum),
	{EmailTitle, EmailContent1, EmailContent2, GoodsNo} = get_email_config(BallNum, GoodsNum),
	EmailContent = 
				case BallNum =:= 0 of
					true -> EmailContent2;
					false -> EmailContent1
				end,
	LogInfo = case Type of
						  ?SUBMIT_BALL_T_NORMAL -> "prize";
						  ?SUBMIT_BALL_T_SYS -> "prize"
					  end,
	PS = player:get_PS(PlayerId),
	lib_mail:send_sys_mail(PlyInfo#ets_melee_ply_info.id 
								   ,EmailTitle
								   ,EmailContent
								   ,[{GoodsNo, 1, GoodsNum}]
								   ,[?LOG_MELEE, LogInfo]
								  ),
	lib_log:statis_melee(PS
						 ,PlyInfo#ets_melee_ply_info.ball_num
						 ,util:unixtime() - PlyInfo#ets_melee_ply_info.create_time
						 ,PlyInfo#ets_melee_ply_info.scene_no
						).

%% send_melee_email_reward(PlyInfo, PS, Type) ->
%%     BallNum = PlyInfo#ets_melee_ply_info.ball_num,
%%     GoodsNum = get_melee_reward_num(BallNum),
%%     {EmailTitle, EmailContent1, EmailContent2, GoodsNo} = get_email_config(BallNum, GoodsNum),
%%     EmailContent = 
%%         case BallNum =:= 0 of
%%             true -> EmailContent2;
%%             false -> EmailContent1
%%         end,
%%     LogInfo = case Type of
%%         ?SUBMIT_BALL_T_NORMAL -> "prize";
%%         ?SUBMIT_BALL_T_SYS -> "prize"
%%     end,
%%     lib_mail:send_sys_mail(PlyInfo#ets_melee_ply_info.id 
%%                           ,EmailTitle
%%                           ,EmailContent
%%                           ,[{GoodsNo, 1, GoodsNum}]
%%                           ,[?LOG_MELEE, LogInfo]
%%                       ),
%%     lib_log:statis_melee(PS
%%                         ,PlyInfo#ets_melee_ply_info.ball_num
%%                         ,util:unixtime() - PlyInfo#ets_melee_ply_info.create_time
%%                         ,PlyInfo#ets_melee_ply_info.scene_no
%%                     ),
%%     ok.


%% --------------------------------
%% 决斗前获取对方队伍信息（龙珠数量）
%% --------------------------------
get_pk_force_pre_info(PS, TargetId) ->
    % 场景类型判断 
    case lib_scene:is_melee_scene(player:get_scene_id(PS)) of
        false -> skip;
        true ->
            PlayerId = player:id(PS),
            % 我方信息
            MyBallNum = get_melee_ball_num(PlayerId),
            MyTeamMbNum = 
                case player:is_in_team(PS) of
                    true -> mod_team:get_member_count(player:get_team_id(PS));
                    false -> 1
                end,
            case player:get_PS(TargetId) of
                null -> skip;
                TargetPS ->
                    case player:is_in_team(TargetPS) andalso (not player:is_tmp_leave_team(TargetPS)) of
                        true -> % 对方在队伍中
                            MemberIdList = mod_team:get_can_fight_member_id_list(player:get_team_id(TargetPS)),
                            TargetBallNumList = [get_melee_ball_num(Id) || Id <- MemberIdList],
                            RateList = [get_plunder_ball_rate(MyBallNum, TargetBallNum) / MyTeamMbNum || TargetBallNum <- TargetBallNumList],
                            Rate = min(erlang:round( (1 - calc_melee_plunder_rate(RateList)) * 100 ), 100),
                            ?ylh_Debug("get_pk_force_pre_info  111 ~p~n", [{player:id(PS),MyBallNum,MyTeamMbNum, TargetId, MemberIdList, TargetBallNumList, RateList, Rate}]),
                            {ok, BinData} = pt_28:write(?PT_MELEE_GET_PK_FORCE_PRE_INFO, [TargetId, TargetBallNumList, Rate]),
                            lib_send:send_to_sid(PS, BinData),
                            ok;
                        false -> % 对方不在队伍中, 或者暂离了
                            ?ylh_Debug("get_pk_force_pre_info ~p~n", [{player:id(PS), TargetId}]),
                            TargetBallNum = get_melee_ball_num(TargetId),
                            Rate = min(erlang:round( (get_plunder_ball_rate(MyBallNum, TargetBallNum) / MyTeamMbNum) * 100 ), 100),
                            {ok, BinData} = pt_28:write(?PT_MELEE_GET_PK_FORCE_PRE_INFO, [TargetId, [TargetBallNum], Rate]),
                            lib_send:send_to_sid(PS, BinData),
                            ok
                    end
            end
    end,
    ok.

calc_melee_plunder_rate(RateList) ->
    calc_melee_plunder_rate__(RateList, 1).

calc_melee_plunder_rate__([], Return) -> Return;
calc_melee_plunder_rate__([Rate | Rest], Return) -> calc_melee_plunder_rate__(Rest, Return*(1-Rate)).

%% --------------------------------
%% 战斗结束结算 （上层已经做了乱斗场景判断）
%% --------------------------------
% 对明雷怪胜利
battle_feedback(?HOST_SIDE, HostIdList, [], State) -> melee_mf_battle_end(HostIdList, State#btl_state.bmon_group_no);
% 对明雷怪失败
battle_feedback(?GUEST_SIDE, _HostIdList, [], _State) -> skip;
% 对玩家PK主方胜利
battle_feedback(?HOST_SIDE, HostIdList, GuestIdList, _State) -> melee_pk_battle_end(HostIdList, GuestIdList);
% 对玩家PK客方胜利
battle_feedback(?GUEST_SIDE, HostIdList, GuestIdList, _State) -> melee_pk_battle_end(GuestIdList, HostIdList);
% 打平
battle_feedback(?NO_SIDE, _HostIdList, _GuestIdList, _State) -> skip;
% 容错
battle_feedback(_WinSide, _HostIdList, _GuestIdList, _State) ->
    ?ASSERT(false, {_WinSide, _HostIdList, _GuestIdList, _State}),
    ?ERROR_MSG("battle_feedback error!!! ~p~n", [{_WinSide, _HostIdList, _GuestIdList}]),
    error.

% pk掠夺的结算
melee_pk_battle_end(WinIdList, LoseIdList) -> 
    WinList = [P || Id <- WinIdList, (P=get_melee_ply_info(Id))=/=null],
    LoseList = [P || Id <- LoseIdList, (P=get_melee_ply_info(Id))=/=null],
    NewLoseList = melee_pk_battle_end__(WinList, length(WinList), LoseList),
    F = fun(LPlyInfo) ->
            % 保存数据
            set_melee_ply_info(LPlyInfo),
            % 同步客户端龙珠数量
            LoseId = LPlyInfo#ets_melee_ply_info.id,
            OldLPlyInfo = lists:keyfind(LoseId, #ets_melee_ply_info.id, LoseList),
            ChangeBallNum = OldLPlyInfo#ets_melee_ply_info.ball_num - LPlyInfo#ets_melee_ply_info.ball_num,
            case ChangeBallNum =:= 0 of
                true -> skip;
                false ->
                    notify_plunder_ball_num(LoseId, 2, ChangeBallNum)
            end,
            ok
    end,
    [F(Lose) || Lose <- NewLoseList],
    ok.

melee_pk_battle_end__([], _WinLen, LoseList) -> LoseList;
melee_pk_battle_end__([WPlyInfo | WinList], WinLen, LoseList) ->
    WBallNum = WPlyInfo#ets_melee_ply_info.ball_num,

    F = fun(LPlyInfo, {AccWBallNum, AccLoseList}) ->
            LBallNum = LPlyInfo#ets_melee_ply_info.ball_num,
            Rate = erlang:round( (get_plunder_ball_rate(AccWBallNum, LBallNum)/WinLen) * 100),
            Rand = util:rand(1,100),
            case Rand < Rate andalso AccWBallNum<?MAX_BALL_NUM of
                false -> % 掠夺失败
                    {AccWBallNum, [set_melee_ball_num(LPlyInfo, LBallNum) | AccLoseList]};
                true ->  % 掠夺成功
                    {AccWBallNum+1, [set_melee_ball_num(LPlyInfo, LBallNum-1) | AccLoseList]}
            end
    end,
    {NewWBallNum, NewLoseList} = lists:foldl(F, {WBallNum, []}, LoseList),
    % 保存数据
    NewWPlyInfo = set_melee_ball_num(WPlyInfo, NewWBallNum),
    set_melee_ply_info(NewWPlyInfo),
    % 同步客户端龙珠数量
    ChangeBallNum = NewWPlyInfo#ets_melee_ply_info.ball_num - WBallNum,
    case ChangeBallNum =:= 0 of
        true -> skip;
        false ->
            notify_plunder_ball_num(NewWPlyInfo#ets_melee_ply_info.id, 1, ChangeBallNum)
    end,
    melee_pk_battle_end__(WinList, WinLen, NewLoseList).



%% 打明雷怪结束的结算
%melee_mf_battle_end(WinIdList, BMonGroupNo) -> 
%    BMonGroup = lib_bmon_group:get_cfg_data(BMonGroupNo),
%    AllocBallNum = length(BMonGroup#bmon_group.mon_pool_fixed),
%    WinList = [ P || Id <- WinIdList, (P=get_melee_ply_info(Id))=/=null],
%    % 分配龙珠, 一场战斗中一个玩家可能获得多个
%    F1 = fun(_, WinListAcc) ->
%            % 过滤掉龙珠数大于7的玩家
%            WinListLess7 = [P || P<- WinListAcc, P#ets_melee_ply_info.ball_num<?MAX_BALL_NUM ], 
%            case WinListLess7 of
%                [] -> WinListAcc; % 大家都超过7个龙珠了，就不分配了
%                _ ->
%                    % 随机一个龙珠数少于7的玩家分配给一个龙珠
%                    PickOne = list_util:rand_pick_one(WinListLess7),
%                    NewPlyInfo = set_melee_ball_num(PickOne, PickOne#ets_melee_ply_info.ball_num+1),
%                    lists:keyreplace(PickOne#ets_melee_ply_info.id, #ets_melee_ply_info.id, WinListAcc, NewPlyInfo)
%            end
%    end,
%    NewWinList = lists:foldl(F1, WinList, lists:seq(1, AllocBallNum)),
%    % 同步数据
%    F2 = fun(PlyInfo) ->
%            % 保存数据
%            set_melee_ply_info(PlyInfo),
%            % 同步客户端龙珠数量
%            OldLPlyInfo = lists:keyfind(PlyInfo#ets_melee_ply_info.id, #ets_melee_ply_info.id, WinList),
%            ChangeBallNum = PlyInfo#ets_melee_ply_info.ball_num - OldLPlyInfo#ets_melee_ply_info.ball_num,
%            case ChangeBallNum =:= 0 of
%                true -> skip;
%                false ->
%                    notify_plunder_ball_num(PlyInfo#ets_melee_ply_info.id, 3, ChangeBallNum)
%            end,
%            ok
%    end,
%    lists:foreach(F2, NewWinList),
%    ok.
%% 打明雷怪结束的结算 （第二版）
% 击败野怪获取龙珠规则改变，掠夺规则不变
% 新规则：击败任意野怪队伍（无论几个龙珠宝宝），都给全队每人一颗龙珠。
% 新规则2：当玩家龙珠数量达到4颗，即无法通过刷怪继续获得龙珠了，打怪胜利后上浮文本提示：打宝宝最多获取4颗龙珠。
melee_mf_battle_end(WinIdList, _BMonGroupNo) -> 
    WinList = [ P || Id <- WinIdList, (P=get_melee_ply_info(Id))=/=null],
            % 当前玩家龙珠数量小于4颗
	DragonBallLimit = data_special_config:get(dragonball_limit),
    F = fun(PlyInfo) when PlyInfo#ets_melee_ply_info.ball_num < DragonBallLimit ->
            NewPlyInfo = set_melee_ball_num(PlyInfo, PlyInfo#ets_melee_ply_info.ball_num+1),
            % 保存数据
            set_melee_ply_info(NewPlyInfo),
            % 同步客户端龙珠数量
            notify_plunder_ball_num(NewPlyInfo#ets_melee_ply_info.id, 3, 1),
            ok;
        % 当前玩家龙珠数量大于等于4颗，则不分配
        (PlyInfo) ->
            lib_send:send_prompt_msg(PlyInfo#ets_melee_ply_info.id, ?PM_MELEE_ERROR_BALL_NUM_ENOUGH)
    end,
    lists:foreach(F, WinList),
    ok.


%% 掠夺龙珠数量通知
notify_plunder_ball_num(PlayerId, Type, Num) ->
    {ok, BinData} = pt_28:write(?PT_MELEE_PLUNDER_BALL_NUM, [PlayerId, Type, Num]),
    lib_send:send_to_AOI(PlayerId, BinData).

%% --------------------------------
%% 乱斗场景 战斗结束回调函数
%% --------------------------------
% pk战斗回调
melee_pk_callback(PlayerId, Feedback) ->
    Result = Feedback#btl_feedback.result,
	LeftHp = Feedback#btl_feedback.left_hp,
    % 死亡复活
    ?Ifc ( LeftHp =:= 0 )
        PS = player:get_PS(PlayerId),
        teleport_after_die(PS)
    ?End,
    % 加保护60s时间
	?Ifc ( Result == lose andalso LeftHp == 0 )
		lib_buff:player_add_buff(PlayerId, ?BNO_PK_PROTECT, 60)
	?End,
    ok.

% 怪物战斗回调
melee_mf_callback(PlayerId, Feedback) ->
    _Result = Feedback#btl_feedback.result,
	LeftHp = Feedback#btl_feedback.left_hp,
    % 死亡复活
    ?Ifc ( LeftHp =:= 0 )
        PS = player:get_PS(PlayerId),
        teleport_after_die(PS)
    ?End,
%    % 加保护10s时间
%	?Ifc ( Result == lose andalso LeftHp == 0 )
%		lib_buff:player_add_buff(PlayerId, ?BNO_PK_PROTECT, 10)
%	?End,
    ok.

%% --------------------------------
%% 乱斗场景死亡
%% --------------------------------
teleport_after_die(PS) ->
    ?ylh_Debug("teleport after die ~p~n", [player:id(PS)]),
    SceneId = player:get_scene_id(PS),
    SceneNo = player:get_scene_no(PS),
    {X, Y} = get_melee_reborn_place_config(SceneNo),
    case player:is_in_team_but_not_leader(PS) andalso (not player:is_tmp_leave_team(PS)) of
        true -> skip;
        false ->
            ply_scene:do_teleport(PS, SceneId, X, Y)
    end,
    ok.

%% --------------------------------
%% 乱斗相关buff操作
%% --------------------------------
% 离队后1分钟内无法发起决斗
add_leave_team_buff(PS) ->
    case player:is_in_melee(PS) of
        false -> skip;
        true ->
            lib_buff:player_add_buff(player:id(PS), ?BNO_MELEE_LEAVE_TEAM, 60)
    end,
    ok.

% 踢出队员后1分钟内无法发起决斗
add_tick_out_member_buff(PS) ->
    case player:is_in_melee(PS) of
        false -> skip;
        true ->
            IdList = [player:id(PS) | lib_team:get_teammate_id_list(PS)],
            [lib_buff:player_add_buff(Id, ?BNO_MELEE_TICK_OUT_MEMBER, 60) || Id<-IdList],
            ok
    end,
    ok.


%% --------------------------------
%% 乱斗数据操作函数
%% --------------------------------
get_melee_status() ->
    case ets:lookup(?ETS_MELEE_STATUS, ?MS_KEY) of
        [MeleeStatus] when is_record(MeleeStatus, ets_melee_status) -> MeleeStatus;
        _ -> null
    end.

get_melee_ply_info(PS) when is_record(PS, player_status) -> get_melee_ply_info(player:id(PS));
get_melee_ply_info(PlayerId) ->
    case ets:lookup(?ETS_MELEE_PLY_INFO, PlayerId) of
        [MeleePlyInfo] when is_record(MeleePlyInfo, ets_melee_ply_info) -> MeleePlyInfo;
        _ -> null 
    end.

set_melee_ply_info(PlyInfo) when is_record(PlyInfo, ets_melee_ply_info) ->
    ets:insert(?ETS_MELEE_PLY_INFO, PlyInfo);
set_melee_ply_info(_PlyInfo) ->
    ?ASSERT(false, {_PlyInfo}),
    error.

set_melee_ply_info_scene_no(PS, SceneNo) ->
    case get_melee_ply_info(PS) of
        null -> skip;
        PlyInfo ->
            set_melee_ply_info(PlyInfo#ets_melee_ply_info{scene_no=SceneNo})
    end.

del_melee_ply_info(PlayerId) ->
    ets:delete(?ETS_MELEE_PLY_INFO, PlayerId).


get_melee_ball_num(PlayerId) ->
    case get_melee_ply_info(PlayerId) of
        null ->
            ?ASSERT(false, {PlayerId}),
            0;
        PlyInfo -> PlyInfo#ets_melee_ply_info.ball_num
    end.

set_melee_ball_num(PlyInfo, Num) when is_record(PlyInfo, ets_melee_ply_info) ->
    PlyInfo#ets_melee_ply_info{ball_num=min(max(0, Num), ?MAX_BALL_NUM)};
set_melee_ball_num(PlayerId, Num) ->
    case get_melee_ply_info(PlayerId) of
        null ->
            ?ASSERT(false, {PlayerId, Num}),
            error;
        PlyInfo -> 
            NewPlyInfo = set_melee_ball_num(PlyInfo, Num),
            set_melee_ply_info(NewPlyInfo),
            ok
    end.

%% --------------------------------
%% 配置信息函数
%% --------------------------------
% 乱斗场景配置
get_melee_scene_no_config() -> [{1,9999,9002}].
%% get_melee_scene_no_config() -> [{1,9999,9002}]. 
get_melee_lv_limit_list() ->
    [{MinLv, MaxLv} || {MinLv, MaxLv, _} <- get_melee_scene_no_config()].

% 出生点配置
%% get_melee_born_place_config(9002) -> {53, 77};
%% get_melee_born_place_config(9002) -> {5,4};
get_melee_born_place_config(9002) -> 
	X = data_special_config:get(paodian_born_x),
	Y = data_special_config:get(paodian_born_y),
	{X,Y};
	
get_melee_born_place_config(1305) -> {144,61};
get_melee_born_place_config(1303) -> {141,56};
get_melee_born_place_config(_) -> error.
% 重生点配置
%% get_melee_reborn_place_config(9002) -> list_util:rand_pick_one([ {24, 137},{17, 116},{46, 120},{78, 119},{28, 96},{55, 96},{87, 96},{16, 71},{81, 73},{64, 38},{35, 52},{15, 28} ]);
get_melee_reborn_place_config(9002) ->
	list_util:rand_pick_one(data_special_config:get('paodian_reborn'));
get_melee_reborn_place_config(1305) -> list_util:rand_pick_one([ {175,62}, {186,34}, {176,11}, {153,31}, {122,19}, {107,64}, {78,70}, {38,72}, {17,43}, {33,15}, {73,21} ]);
get_melee_reborn_place_config(1303) -> list_util:rand_pick_one([ {158,41}, {131,40}, {110,53}, {60,67}, {61,36}, {84,56}, {145,17}, {174,14}, {113,17}, {73,16}, {34,19} ]);
get_melee_reborn_place_config(_) -> {0,0}.

% 掠夺概率配置 W=Win L=Lose
%% get_plunder_ball_rate(_W, 0) -> 0;              % 对方无龙珠则掠夺成功率为0
%% get_plunder_ball_rate(?MAX_BALL_NUM, _) -> 0;   % 我龙珠数已经最大则掠夺成功率为0
%% get_plunder_ball_rate(W, L) ->
%% 	get_plunder_ball_rate(W - L).
%% 
%% get_plunder_ball_rate(Diff) ->
%% 	NoL = data_paodian_rob_rate:get_id_list(),
%% 	do_get_plunder_ball_rate(NoL, Diff).
%% 
%% do_get_plunder_ball_rate([No|L], Diff) ->
%% 	#paodian_rob_rate_config{min = Min, max = Max, rob_rate = RobRate} = data_paodian_rob_rate:get(No),
%% 	case Diff >= Min andalso Diff < Max of
%% 		true ->
%% 			RobRate;
%% 		false ->
%% 			do_get_plunder_ball_rate(L, Diff)
%% 	end;
%% 
%% do_get_plunder_ball_rate([], _Diff) ->
%% 	0.
			
	
get_plunder_ball_rate(_W, 0) -> 0;              % 对方无龙珠则掠夺成功率为0
get_plunder_ball_rate(?MAX_BALL_NUM, _) -> 0;   % 我龙珠数已经最大则掠夺成功率为0
get_plunder_ball_rate(W, L) when W-L > 2 -> 0.1;
get_plunder_ball_rate(W, L) when W-L =:= 2 -> 0.3;
get_plunder_ball_rate(W, L) when W-L =:= 1 -> 0.7;
get_plunder_ball_rate(W, L) when W-L =:= 0 -> 1.0;
get_plunder_ball_rate(W, L) when W-L =:= -1 -> 1.5;
get_plunder_ball_rate(W, L) when W-L < -1 -> 2.0;
get_plunder_ball_rate(_W, _L) -> 0.

%5- 奖励调整
%0颗-1牌子
%1颗-5牌子
%2颗-10牌子
%3颗-15牌子
%4颗-20牌子
%5颗-30牌子
%6颗-40牌子
%7颗-50牌子
get_melee_reward_num(0) -> 1;
get_melee_reward_num(1) -> 120;
get_melee_reward_num(2) -> 240;
get_melee_reward_num(3) -> 360;
get_melee_reward_num(4) -> 480;
get_melee_reward_num(5) -> 600;
get_melee_reward_num(6) -> 720;
get_melee_reward_num(_) -> 840.


% 泡点倍率
get_melee_paodian(0) -> 1;
get_melee_paodian(1) -> 1.1;
get_melee_paodian(2) -> 1.15;
get_melee_paodian(3) -> 1.2;
get_melee_paodian(4) -> 1.25;
get_melee_paodian(5) -> 1.3;
get_melee_paodian(6) -> 1.35;
get_melee_paodian(_) -> 1.4.


% 获取明雷怪编号 
get_seemon_no(9002) -> list_util:rand_pick_one([35100,35101,35102,35103,35104, 35105, 35106, 35107]);
get_seemon_no(1305) -> list_util:rand_pick_one([10001, 10001, 10001]);
get_seemon_no(1303) -> list_util:rand_pick_one([10001, 10001, 10001]);
get_seemon_no(_) -> 0.


% 单场景刷怪数量 改成动态计算:1+场景内珠子没满玩家数*0.05
%get_refresh_seemon_num() -> 10. 
get_refresh_seemon_num(SceneId) ->
    IdList = lib_scene:get_scene_player_ids(SceneId),
    IdList_Less7 = [Id || Id<-IdList, (get_melee_ply_info(Id))#ets_melee_ply_info.ball_num<?MAX_BALL_NUM],
    erlang:round(1+length(IdList_Less7)*0.05).

% 邮件信息配置
get_email_config(BallNum, GoodsNum) ->
	Title = util:to_binary(data_special_config:get(paodian_mail_title)),
    Content = data_special_config:get(paodian_mail_content),
    {Title % 邮件题目
	,io_lib:format(Content, [BallNum, GoodsNum])  % 正常邮件
    ,io_lib:format("主人在女妖乱斗活动中没有收集到龙珠。作为对您辛苦的肯定，龙宫向您发放~p个奖章。下次活动再加油吧。奖章可以在长安城的南海龙王处兑换丰厚奖励。", [get_melee_reward_num(0)])      % 0龙珠邮件
    ,89010 % 奖章物品编号
    }.






