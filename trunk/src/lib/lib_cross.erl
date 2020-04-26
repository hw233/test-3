%% @author Administrator
%% @doc @todo Add description to lib_cross.
%% @doc 跨服玩家数据处理模块


-module(lib_cross).
-include("common.hrl").
-include("ets_name.hrl").
-include("player.hrl").
-include("record.hrl").
-include("phone.hrl").
-include("inventory.hrl").
-include("scene.hrl").
-include("xinfa.hrl").
-include("pt_43.hrl").
-include("prompt_msg_code.hrl").
-include("team.hrl").

-compile(export_all).
%% ====================================================================
%% API functions
%% ====================================================================
-export([]).	


%% 这个函数通常给远程调用的时候需要玩家进程mod_player进行apply call的封装
player_apply_call(PlayerId, Module, Function, Args) ->
	Reply = case player:get_pid(PlayerId) of
		Pid when is_pid(Pid) ->
			gen_server:call(Pid, {apply_call, Module, Function, Args}, 2000);
		_ ->
			?ERROR_MSG("Err : ~p~n", [{PlayerId, Module, Function, Args}]),
			error
	end,
	Reply.


player_apply_call_with_PS(PlayerId, Module, Function, Args) ->
	Reply = case player:get_pid(PlayerId) of
		Pid when is_pid(Pid) ->
			PS = player:get_PS(PlayerId),
			gen_server:call(Pid, {apply_call, Module, Function, [PS|Args]}, 2000);
		_ ->
			?ERROR_MSG("Err : ~p~n", [{PlayerId, Module, Function, Args}]),
			error
	end,
	Reply.


%% 给玩家进程发消息
player_msg_cast(PlayerId, Request) ->
	case player:get_pid(PlayerId) of
		Pid when is_pid(Pid) ->
			gen_server:cast(Pid, Request);
		_ ->
			ok
	end.

%% 检查是否跨服状态，需mod_player进程调用
check_is_remote() ->
	check_cross_state(?CROSS_STATE_REMOTE).

check_is_local() ->
	check_cross_state(?CROSS_STATE_LOCAL).

check_is_mirror() ->
	check_cross_state(?CROSS_STATE_MIRROR).


%% 检查跨服状态
check_cross_state(State) ->
	erlang:get(?PDKN_CROSS_STATE) == State.


%% 获取跨服状态
get_cross_state() ->
	erlang:get(?PDKN_CROSS_STATE).


%% 玩家登陆时初始化跨服跳转
login_init_cross(PlayerId) when is_integer(PlayerId) ->
	PS = player:get_PS(PlayerId),
	ServerId = config:get_server_id(),
	{SceneNo, X, Y} = 
		case init_cross(PS) of
			{ok, PlysPos} when is_record(PlysPos, plyr_pos) andalso
								  PlysPos#plyr_pos.scene_id =/= 0 ->
				{PlysPos#plyr_pos.scene_id, PlysPos#plyr_pos.x, PlysPos#plyr_pos.y};
			_ ->
				SceneNo0 = player:get_scene_no(PS),
				{X0, Y0} = player:get_xy(PlayerId),
				{SceneNo0, X0, Y0}
		end,
	sync_cross_data(PS),
	%% 这里一但进入场景就会把状态重置，将导致无法回到战场，判断是否战斗状态？
	sm_cross_server:rpc_cast(?MODULE, enter_cross_remote, [config:get_server_id(), PlayerId, SceneNo, X, Y]),
	sm_cross_server:rpc_cast(?MODULE, player_apply_call, [PlayerId, ?MODULE, login_init_cross_remote, [ServerId, PlayerId]]).

login_init_cross_remote(ServerId, PlayerId) ->
	mod_ply_jobsch:remove_sch_reconnect_timeout(PlayerId), % 移除角色重连超时的作业计划（异步）
	mod_ply_jobsch:remove_sch_game_logic_reconn_timeout(PlayerId), % 移除游戏逻辑重连超时的作业计划（异步）
	sm_cross_server:rpc_cast(ServerId, ?MODULE, enter_cross_local, [PlayerId]),
	ok.


%% 同步跨服数据回本服
sync_cross_data(PlayerId) when is_integer(PlayerId) ->
	PS = player:get_PS(PlayerId),
	sync_cross_data(PS);

sync_cross_data(PS) ->	
	PlayerId = player:id(PS),
	PsPosL = [#player_status.cur_battle_id],
	case sm_cross_server:rpc_call(?MODULE, sync_cross_data_remote, [PlayerId, PsPosL]) of
		{ok, PosValL} ->
			PS = player:get_PS(PlayerId),
			PS_Latest = lists:foldl(fun({Pos, Val}, PSAcc) ->
											erlang:setelement(Pos, PSAcc, Val)
									end, PS, PosValL),
			player_syn:update_PS_to_ets(PS_Latest);
		_ ->
			ok
	end.

sync_cross_data_remote(PlayerId, PsPosL) ->
	case case player:get_PS(PlayerId) of
			 null ->
				 case ply_tmplogout_cache:get_tmplogout_PS(PlayerId) of
					 null -> null;
					 TPS -> TPS
				 end;
			 PSOld ->
				 PSOld
		 end of
		#player_status{} = PS ->
			lists:foldl(fun(#player_status.cur_battle_id = Pos, Acc) ->
								CurBattleId = %% player:get_cur_battle_id(PS),io:format("fffffffffffffff : ~p~n", [{?MODULE, ?LINE, CurBattleId}]),
									case player:get_cur_battle_pid(PS) of
										null ->
											?INVALID_ID;
										BattlePid when is_pid(BattlePid) ->
											case erlang:is_process_alive(BattlePid) of
												true -> player:get_cur_battle_id(PS);
												false -> ?INVALID_ID
											end;
										_Any ->
											?ASSERT(false, {_Any, PS}),
											?INVALID_ID
									end,
								case CurBattleId > 0 of
									?true ->
										[{Pos, CurBattleId}|Acc];
									?false ->
										Acc
								end;
						   (Pos, Acc) ->
								[{Pos, erlang:element(Pos, PS)}|Acc]
						end, [], PsPosL);
		_ ->
			[]
	end.


%% 断线处理，暂时处理方案是断线即退出跨服
tmp_logout(PlayerId) ->
	case check_is_remote() of
		?true ->
			sm_cross_server:rpc_cast(?MODULE, cross_logout, [PlayerId]);
		_ ->
			ok
	end.
	
%% 这里要考虑下要不要直接在这里销毁镜像数据和进程
cross_logout(PlayerId) ->
	case player:get_PS(PlayerId) of
		PS when is_record(PS, player_status) ->
			%% 断线或者退出游戏跨服的时候执行
			Pid = player:get_pid(PS),
			Socket = player:get_socket(PS),
			FromServerId = player:get_from_server_id(PS),
			AccName = player:get_accname(PS),
			mod_login:force_disconnect(AccName, FromServerId, PlayerId, Pid),
			% 添加作业计划：检测玩家进程是否alive，如果alive，则kill之
			% ?DEBUG_MSG("[sm_reader] do_lost(), before add cleanup residual player proc sch, PlayerId:~p, PlayerPid:~p", [Client#client.cur_role_id, Client#client.player_pid]),
			mod_sys_jobsch:add_sch_cleanup_residual_player_proc(PlayerId, Pid, 30),
			nosql:del(sock_writer_map, Socket);
		_ ->
			ok
	end.



%% 从本服进入跨服服务器，在上层保证当前玩家未在跨服状态？
enter_cross(PlayerId) when is_integer(PlayerId) ->
	enter_cross(player:get_PS(PlayerId));

enter_cross(PS) ->
	ServerId = config:get_server_id(),
	PlayerId = player:get_id(PS),
	SceneNo = player:get_scene_no(PS),
	SceneType = mod_scene_tpl:get_scene_type(SceneNo),
	if 
		SceneType == ?SCENE_T_CITY orelse SceneType == ?SCENE_T_WILD orelse SceneType == ?SCENE_T_FACTION ->
			init_cross(PS),
			{X, Y} = player:get_xy(PlayerId),
			sm_cross_server:rpc_cast(?MODULE, enter_cross_remote, [config:get_server_id(), PlayerId, SceneNo, X, Y]),
			sm_cross_server:rpc_cast(?MODULE, player_apply_call, [PlayerId, ?MODULE, login_init_cross_remote, [ServerId, PlayerId]]),
			ok;
		true ->
			%% 当前位置不可操作
			lib_send:send_prompt_msg(PS, ?PM_SCENE_SWITCH_CROSS_BAN),
			false
	end.


enter_cross(PS,Type) ->
	ServerId = config:get_server_id(),
	PlayerId = player:get_id(PS),
	SceneNo = player:get_scene_no(PS),
	SceneType = mod_scene_tpl:get_scene_type(SceneNo),
	if
		SceneType == ?SCENE_T_CITY orelse SceneType == ?SCENE_T_WILD orelse SceneType == ?SCENE_T_FACTION ->
			init_cross(PS,Type),
			{X, Y} = player:get_xy(PlayerId),
			sm_cross_server:rpc_cast(?MODULE, enter_cross_remote, [config:get_server_id(), PlayerId, SceneNo, X, Y]),
			sm_cross_server:rpc_cast(?MODULE, player_apply_call, [PlayerId, ?MODULE, login_init_cross_remote, [ServerId, PlayerId]]),
			ok;
		true ->
			%% 当前位置不可操作
			lib_send:send_prompt_msg(PS, ?PM_SCENE_SWITCH_CROSS_BAN),
			false
	end.

enter_cross_remote(ServerId, PlayerId, SceneNo, X, Y) ->
	PS = player:get_PS(PlayerId),
	ply_scene:enter_scene_on_login(PS),
	case player:is_battling(PlayerId) of
		?false ->
			gen_server:cast(player:get_pid(PlayerId), {'do_teleport', SceneNo, X, Y});
		?true ->
			skip
	end,
	sm_cross_server:rpc_cast(ServerId, ?MODULE, enter_cross_local, [PlayerId]).

enter_cross_local(PlayerId) ->
	PS = player:get_PS(PlayerId),
	mod_team_mgr:do_quit_team2(PS),
	player:mark_cross_remote(PS),
	%% 离开本服场景
	?TRY_CATCH(ply_scene:leave_scene_on_logout(PS), ErrReason_LeaveScene),
	{ok, BinData} = pt_43:write(?PT_CROSS_SERVER, [1]),
	lib_send:send_to_sock(PS, BinData).


%% 离开跨服，回到原服
leave_cross(PlayerId) when is_integer(PlayerId) ->
	leave_cross(player:get_PS(PlayerId));

leave_cross(PS) ->
	PlayerId = player:get_id(PS),
	ServerId = player:get_server_id(PS),
	case player:get_scene_no(PS) of
		SceneNo when SceneNo > 0 ->
			SceneType = mod_scene_tpl:get_scene_type(SceneNo),
			if 
				SceneType == ?SCENE_T_CITY orelse SceneType == ?SCENE_T_WILD orelse SceneType == ?SCENE_T_FACTION ->
					%% 离开本服场景
					% 脱离队伍
					mod_team:quit_team(PS),
					player_syn:update_PS_to_ets(PS#player_status{team_id = 0}),
					util:sleep(200),
%% 					?TRY_CATCH(ply_scene:leave_scene_on_logout(PS), ErrReason_LeaveScene),
					cross_logout(PlayerId),
					{X, Y} = player:get_xy(PlayerId),
					sm_cross_server:rpc_cast(ServerId, ?MODULE, leave_cross_local, [PlayerId, SceneNo, X, Y]);
				true ->
					%% 当前位置不可操作
					lib_send:send_prompt_msg(PS, ?PM_SCENE_SWITCH_CROSS_BAN)
			end;
		_ ->
			mod_team:quit_team(PS),
			player_syn:update_PS_to_ets(PS#player_status{team_id = 0}),
			util:sleep(200),
			cross_logout(PlayerId),
%% 			?TRY_CATCH(ply_scene:leave_scene_on_logout(PS), ErrReason_LeaveScene),
			sm_cross_server:rpc_cast(ServerId, ?MODULE, player_apply_call, [PlayerId, ?MODULE, leave_cross_local, [PlayerId]])
	end.

leave_cross_local(PlayerId) ->
	PS = player:get_PS(PlayerId),
	ply_scene:enter_scene_on_login(PS),
	player:mark_cross_local(PS),
	{ok, BinData} = pt_43:write(?PT_CROSS_SERVER, [0]),
	lib_send:send_to_sock(PS, BinData).


leave_cross_local(PlayerId, SceneNo, X, Y) ->
	PS = player:get_PS(PlayerId),
	gen_server:cast(player:get_pid(PS), {'do_teleport', SceneNo, X, Y}),
	player:mark_cross_local(PS),
	{ok, BinData} = pt_43:write(?PT_CROSS_SERVER, [0]),
	lib_send:send_to_sock(PS, BinData).

check_cross_cd() ->
	LastCrossInit = erlang:get(last_cross_init),
	UnixtimeNow = util:unixtime(),
	erlang:put(last_cross_init, UnixtimeNow),
	case LastCrossInit of
		?undefined ->
			?true;
		Unixtime ->
			UnixtimeNow - Unixtime > 5
	end.

%% 跨服节点的玩家mod_player进程及sm_writer进程初始化, 跨服的时候调用这个接口进行初始化？
init_cross(PlayerId) when is_integer(PlayerId) ->
	PS = player:get_PS(PlayerId),
	init_cross(PS,0);
init_cross(PS) ->
	init_cross(PS,0).

%% 这里用阻塞的方式来传送，返回跨服当前的场景和位置，在上线重连的时候要用到
init_cross(PS,Type) ->
	%% 短时间内不重复初始化，主要是要传输较大数据到跨服节点，暂定5秒内不重复?
	case check_cross_cd() orelse Type ==1  of
		?true ->
			PlayerId = player:get_id(PS),
			Inv = mod_inv:get_inventory(PlayerId),
			%% 只需要把身上装备同步过去就可以了，只有战斗用到
			GoodsList = lists:foldl(fun(GoodsId, Acc) ->
											case mod_inv:get_goods_from_ets(GoodsId) of
												null -> Acc;
												Goods ->
													[Goods|Acc]
											end
									end, [], Inv#inv.player_eq_goods ++ Inv#inv.partner_eq_goods),
			Titles = ply_title:get_titles(PlayerId),
			OpenSysList = ply_sys_open:get_opened_sys_list(PlayerId),
			%% 还有坐骑，门客，技能，心法
			MountList = lib_mount:get_all_mount(PlayerId),
			MountSkin = lib_mount:get_skins(PlayerId),
			PartnerList = ply_partner:get_partner_list(PlayerId),
			PlyXfInfo = ply_xinfa:get_player_xinfa_info(PlayerId),
			% 队伍信息

			% 简要信息
			sm_cross_server:rpc_call(?MODULE, init_data_inv, 		[Inv, GoodsList]),
			sm_cross_server:rpc_call(?MODULE, init_data_titles, 	[Titles]),
			sm_cross_server:rpc_call(?MODULE, init_data_partner, 	[PartnerList]),
			sm_cross_server:rpc_call(?MODULE, init_data_mount, 		[MountList]),
			sm_cross_server:rpc_call(?MODULE, init_data_mount_skin, [MountSkin]),
			sm_cross_server:rpc_call(?MODULE, init_data_opensys, 	[PlayerId, OpenSysList]),
			sm_cross_server:rpc_call(?MODULE, init_data_xinfa, 		[PlyXfInfo]),
			ReturnValue = case sm_cross_server:rpc_call(?MODULE, init_cross_proc, [PS]) of
				{ok, PlysPos} when is_record(PlysPos, plyr_pos) ->
					{ok, PlysPos};
				_ ->
					null
			end,

			{Team,IsLeader} =
				case player:is_leader(PS) of
					false ->
						case  player:is_in_team(PS) of
							true ->
								TeamId = player:get_team_id(PS),
								{mod_team:get_team_by_id(TeamId),false};
							false ->
								{null,false}
						end;
					true ->
						TeamId = player:get_team_id(PS),
						%%让队员也跨服
						Team2 = mod_team:get_team_by_id(TeamId),
						Members = Team2#team.members,
						%%将在线的玩家带过去跨服
						OnlinePlayers = [Men#mb.id || Men <- Members,Men#mb.state =:= 2, Men#mb.id =/= player:id(PS)],
						?DEBUG_MSG("TestCrosswjc ~p~n",[{Members,OnlinePlayers}]),
						F = fun(X) ->
							CrossFun = fun() ->
								lib_cross:enter_cross(player:get_PS(X),1)
												 end,
							spawn(CrossFun)
								end,
						lists:foreach(F,OnlinePlayers),
						%%将暂离的踢出去
						NewMen = [Men || Men <- Members, Men#mb.state == 2],
						{Team2#team{members = NewMen },true}
				end,

			sm_cross_server:rpc_call(?MODULE, init_data_team, [Team,IsLeader,PlayerId]),
			ReturnValue;
		?false ->
			null
	end.

%%初始化队伍2019.11.4
init_data_team(Team,IsLeader,PlayerId) ->
	case Team of
		null ->
			skip;
		_ ->
			case IsLeader of
				true ->
					mod_team:add_team_to_ets(Team),
					player:set_team_id(PlayerId, Team#team.team_id),
					PS = player:get_PS(PlayerId),
					player_syn:update_PS_to_ets(PS#player_status{team_id = Team#team.team_id}),
					?DEBUG_MSG("testcrosswjc ~p~n",[player:get_team_id(player:get_PS(PlayerId))]),
					player:mark_leader_flag(PlayerId);
%%					MemberIdList = [MB#mb.id|| MB <- Team#team.members,MB#mb.id =/= PlayerId],
%%					F = fun(X) ->  mod_team:return_team(player:get_PS(1000100000000107), 14)
%%						lib_team:notify_member_return(player:get_team_id(player:get_PS(1000100000000108)), 1000100000000107)
%%						end,
%%					lists:foreach(F,MemberIdList);
				false ->
					player:set_team_id(PlayerId, Team#team.team_id),
					F = fun() ->
						%%如果立即传过去，由于场景都还没生成，此时会报错的，故只能由后端sleep一段时间或者前端请求
						util:sleep(1500),
					mod_team:do_return_team(player:get_PS(PlayerId), Team#team.team_id)
							end,
					spawn(F)
			end
	end.

%% 初始化物品栏数据，跨服主要是装备物品，战斗会用到，其余目前没需求
init_data_inv(Inv, GoodsList) ->
	mod_inv:add_inventory_to_ets(Inv),
	[mod_inv:add_goods_to_ets(Goods) || Goods <- GoodsList].

%% 初始化称号数据
init_data_titles(Titles) ->
	ply_title:set_titles(Titles).

%% 初始化门客数据
init_data_partner(PartnerList) ->
	[mod_partner:add_partner_to_ets(Partner) || Partner <- PartnerList].

%% 初始化坐骑数据
init_data_mount(MountList) ->
	[lib_mount:update_mount(Mount) || Mount <- MountList].

init_data_mount_skin(MountSkin) ->
	lib_mount:set_skins(MountSkin).

%% 初始化系统开放数据
init_data_opensys(PlayerId, OpenSysList) ->
	ply_sys_open:set_opened_sys_list(PlayerId, OpenSysList).

%初始化离线竞技场数据
init_offline_bo(PS) ->
	mod_offline_data:cache_player_offline_bo(PS).

%% 初始化心法数据
init_data_xinfa(PlyXfInfo) when is_record(PlyXfInfo, ply_xinfa) ->
	ply_xinfa:add_player_xinfa_info_to_ets(PlyXfInfo);

init_data_xinfa(_) ->
	ok.
	
%% 初始化镜像进程
init_cross_proc(PS0) ->
	SyncPosL = [
				#player_status.cur_bhv_state,
				#player_status.dungeon_id,
				#player_status.is_auto_battle,
				#player_status.cur_battle_id,
				#player_status.dun_info,
				#player_status.prev_pos,
				#player_status.off_state,
				#player_status.team_id
			   ],
	PlayerId = player:get_id(PS0),
	

	PSCross = 
		case player:get_PS(PlayerId) of
			null ->
				case ply_tmplogout_cache:get_tmplogout_PS(PlayerId) of
					null -> #player_status{};
					TPS -> TPS
				end;
			PSOld ->
				PSOld
		end,
	
	PS = case PSCross of
			 #player_status{} ->
				 lists:foldl(fun(Pos, PSAcc) ->
									 erlang:setelement(Pos, PSAcc, erlang:element(Pos, PSCross))
							 end, PS0, SyncPosL);
			 _ ->
				 PS0
		 end,
	ServerId = player:get_server_id(PS),
	Socket = player:get_socket(PS),
	%% 开启mod_player进程
	PidOld = player:get_pid(PlayerId),
	PlayerPid = 
		case is_pid(PidOld) andalso is_process_alive(PidOld) of
			?true ->
				PidOld;
			%% 			mod_player:stop(PidOld);
			_ ->
				{ok, PlayerPid0} = mod_player:start(PlayerId),
				PlayerPid0
		end,
	SendPidOld = player:get_sendpid(PlayerId),
	SendPid = 
		case is_pid(SendPidOld) andalso is_process_alive(SendPidOld) of
			?true ->
				SendPidOld;
			_ ->
				{ok, SendPid0} = sm_writer:start_link_cross(ServerId, PlayerId),
				SendPid0
		end,
	nosql:set(sock_writer_map, Socket, SendPid),
	PS2 = PS#player_status{pid = PlayerPid, sendpid = SendPid},
	
	PlayerBrf = mod_login:make_player_brief(PS2),
	mod_svr_mgr:add_online_player_brief_to_ets(PlayerBrf#plyr_brief{pid = PlayerPid, socket = Socket, sendpid = SendPid, is_online = true}),
	ets:insert(?MY_ETS_ONLINE(PS2), PS2),
	% 添加映射：账户名 -> 账户下当前在线的角色
	AccName = player:get_accname(PS),
    FromServerId = player:get_from_server_id(PS),
    ets:insert(?ETS_MAP_OF_ACCNAME_TO_ONLINE_PLAYER, {{AccName, FromServerId}, PlayerId}),
	
%% 	mod_login:init_ets_data_for_enter_game(PS2, role_not_in_cache),
	
	PhoneInfo = #phone_info{},
	% 初始化玩家进程的内部状态
    gen_server:cast(PlayerPid, {'init_internal_state', PS2, [self(), PhoneInfo, ServerId]}),
	
	% 添加到门派的玩家列表
    ply_faction:on_player_login(PS2),

    % 进一步初始化，放最后
    ?LDS_TRACE("LDS ~n login_success_init~n"),
	% 初始化具体位置，获取上次的
	SceneId = player:get_scene_id(PS2),
	{X, Y} = case player:get_position(PS) of
			#plyr_pos{x = X0, y = Y0} ->
				{X0, Y0};
			_ ->
				{0, 0}
		end,
    player:init_position(PlayerId, {SceneId, X, Y}),
%% 	ply_scene:enter_scene_on_login(PS),
	player:set_online(PlayerId, true),
	player:mark_cross_mirror(PS2),
	PlysPos = player:get_position(PlayerId),
	{PlysPos, PS2#player_status.cur_battle_id}.


%% 
%% %% 跨服节点的玩家镜像数据与进程销毁, 离开跨服要调用这个接口清理数据，要在跨服节点调用
%% destroy_cross(PlayerId) when is_integer(PlayerId) ->
%% 	PS = player:get_PS(PlayerId),
%% 	destroy_cross(PS);
%% 
%% destroy_cross(PS) ->
%% %% 	%% 短时间内不重复初始化，比较是要传输较大数据到跨服节点，暂定5秒内不重复?
%% %% 	case check_cross_cd() of
%% %% 		?true ->
%% 	PlayerId = player:get_id(PS),
%% 	Inv = mod_inv:get_inventory(PlayerId),
%% 	GoodsList = lists:foldl(fun(GoodsId, Acc) ->
%% 									case mod_inv:get_goods_from_ets(GoodsId) of
%% 										null -> Acc;
%% 										Goods ->
%% 											[Goods|Acc]
%% 									end
%% 							end, [], Inv#inv.player_eq_goods ++ Inv#inv.partner_eq_goods),
%% 	Titles = ply_title:get_titles(PlayerId),
%% 	OpenSysList = ply_sys_open:get_opened_sys_list(PlayerId),
%% 	%% 还有坐骑，门客，技能，心法
%% 	MountList = lib_mount:get_all_mount(PlayerId),
%% 	PartnerList = ply_partner:get_partner_list(PlayerId),
%% 	PlyXfInfo = ply_xinfa:get_player_xinfa_info(PlayerId),
%% 	% 简要信息
%% 	sm_cross_server:rpc_cast(?MODULE, destroy_cross_data, [PlayerId]),
%% 	ok.
%% %% 		?false ->
%% %% 			skip
%% %% 	end.

%% 跨服节点的玩家镜像数据与进程销毁, 离开跨服要调用这个接口清理数据，要在跨服节点调用
destroy_cross_data(PlayerId) ->
	PS = player:get_PS(PlayerId),
	mod_inv:del_goods_from_ets_by_player_id(PlayerId),
	ply_title:delete_title_cache(PlayerId),
	ply_partner:del_all_my_partners_from_ets(PS),
	lib_mount:delete_all_mount(PlayerId),
	ply_sys_open:del_opened_sys_list_info_from_ets(PlayerId),
	ply_xinfa:del_player_xinfa_info_from_ets(PlayerId),
	
	Socket = player:get_socket(PS),
	Pid = player:get_pid(PlayerId),
	SendPid = player:get_sendpid(PS),
	nosql:del(sock_writer_map, Socket),
	mod_player:stop(Pid),
	ok.

	
%% 初始化镜像进程
destroy_cross_proc(PlayerId) ->
	PS = player:get_PS(PlayerId),
	ServerId = player:get_server_id(PS),
	Socket = player:get_socket(PS),
	%% 开启mod_player进程
	PidOld = player:get_pid(PlayerId),
	PlayerPid = 
		case is_pid(PidOld) == true andalso is_process_alive(PidOld) of
			?true ->
				PidOld;
			_ ->
				{ok, PlayerPid0} = mod_player:start(PlayerId),
				PlayerPid0
		end,
	SendPidOld = player:get_sendpid(PlayerId),
	SendPid = 
		case is_pid(SendPidOld) andalso is_process_alive(SendPidOld) of
			?true ->
				SendPidOld;
			_ ->
				{ok, SendPid0} = sm_writer:start_link_cross(ServerId, PlayerId),
				SendPid0
		end,
	nosql:set(sock_writer_map, Socket, SendPid),
	PS2 = PS#player_status{pid = PlayerPid, sendpid = SendPid},
	mod_login:init_ets_data_for_enter_game(PS2, role_not_in_cache),
	PhoneInfo = #phone_info{},
	% 初始化玩家进程的内部状态
    gen_server:cast(PlayerPid, {'init_internal_state', PS2, [self(), PhoneInfo, ServerId]}),
	
	% 添加到门派的玩家列表
    ply_faction:on_player_login(PS),
	
	
	PB = mod_svr_mgr:get_online_player_brief(PlayerId),
			
	mod_svr_mgr:add_online_player_brief_to_ets(PB#plyr_brief{pid = PlayerPid, socket = null, sendpid = SendPid, is_online = true}),

    % 进一步初始化，放最后
    ?LDS_TRACE("LDS ~n login_success_init~n"),
	% 初始化具体位置
	SceneId = player:get_scene_id(PS2),
	{X, Y} = case player:get_position(PS) of
			#plyr_pos{x = X0, y = Y0} ->
				{X0, Y0};
			_ ->
				{0, 0}
		end,
    player:init_position(PlayerId, {SceneId, X, Y}),
	ply_scene:enter_scene_on_login(PS),
	player:set_online(PlayerId, true),
	void.





%% 	case player:get_PS(PlayerId) of
%% 		PS when is_record(PS, player_status) ->
%% 			case player:is_in_melee(PS) of
%% 				_ ->
%% %% 				true ->
%% 					% 结束战斗进程，离开场景
%% 					mod_battle:force_end_battle_no_win_side(PS),
%% 					?TRY_CATCH(ply_scene:leave_scene_on_logout(PS), ErrReason_LeaveScene);
%% 				false ->
%% 					ok
%% 			end;
%% 		_ ->
%% 			ok
%% 	end.


%% ====================================================================
%% Internal functions
%% ====================================================================


	
	
	
