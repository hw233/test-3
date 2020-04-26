%%%-----------------------------------
%%% @Module  : mod_login
%%% @Author  :
%%% @Email   :
%%% @Created : 2011.04.29
%%% @Modified: 2013.6.3   -- huangjf
%%% @Description: 角色进入、退出游戏
%%%-----------------------------------

%% ---------------------------------------------------------------------------------------------------
%% 注：本模块中提到的“缓存”，如果没有特别指出，都是指角色临时退出后，并没有立即将其相关数据从内存清掉，
%%     而是继续缓存一段时间，当角色重连超时时，才最终将其相关数据从内存清掉。
%%     目前缓存临时退出的玩家的做法是：
%%       玩家临时退出后，
%%       1. 玩家进程会终止，
%%       2. 玩家的简要信息会从表ets_online_player_brief转移到表ets_tmplogout_player_brief，
%%       3. 玩家的PS(player_status结构体)会从表ets_online_xx转移到表ets_tmplogout_player_status，
%%       4. 玩家进程字典中的数据（比如任务数据）会按需拷贝存储到ets，作为缓存，
%%       5. 玩家的其他数据则仍然继续存储在ets中。
%% ---------------------------------------------------------------------------------------------------

-module(mod_login).
-export([
		enter_game/2,
%% 		enter_game_cross/2,
%% 		enter_game_cross/9,
		get_cross_player_data/1,
		init_ets_data_for_enter_game/2,
		force_disconnect/4,
		before_disconnect/3,
		tmp_logout/2,
		final_logout/1,
		disconnect_all/1,
		make_player_brief/1
		]).

-include("common.hrl").
-include("record.hrl").
-include("player.hrl").
-include("job_schedule.hrl").
-include("abbreviate.hrl").
-include("pt_10.hrl").
-include("scene.hrl").
-include("dungeon.hrl").
-include("goods.hrl").
-include("char.hrl").
-include("chapter_target.hrl").

-include("partner.hrl").
-include("phone.hrl").

-include("inventory.hrl").


%% 角色进入游戏
%% @para: Socket  => socket连接
%%        RoleId  => 角色id
%%        AccName => 角色对应的账户名
%% @return: {ok, PlayerPid} | fail | {fail, server_busy}
enter_game(Socket, [RoleId, AccName, ReaderPid, PhoneInfo, FromServerId]) ->
	?TRACE("[mod_login] enter_game(), is online: ~p~n", [player:is_online(RoleId)]),
	% ?DEBUG_MSG("enter_game(), RoleId:~p, self:~w", [RoleId, self()]),

	% 若同账户下已经有角色在线，则先踢掉
	OldPS = find_player_to_kick(AccName, FromServerId),
	%% zhengjy 20180403 目前登录流程没有用单玩家消息队列方式来处理玩家别处登录问题存在隐患，并发抢占登录会触发回档的bug?,在ets表中记录玩家登录时间戳，忽略短期内的大量抢占登录请求可行吗？
	%% 或者在队列服务那里做限制？在将要进入游戏的时候先判断上次登录时间？然后这里就不再处理？但等待玩家退出的时候会产生超时情况，如何解决？
 	case OldPS of
		null ->
			case OldPS of
				null ->
					?TRACE("NO same account old online player, RoleId:~p~n", [RoleId]),
					%%?DEBUG_MSG("[mod_login] enter_game(), NO same account old online player, RoleId:~p", [RoleId]),
					
					OldRoleId = ?INVALID_ID,
					skip;
				_ ->  % 注意：OldPS的id可能就是对应RoleId
					?TRACE("same account old online player, RoleId:~p~n", [RoleId]),
					
					OldRoleId = player:id(OldPS),
					
					?TRACE("SAME account old online player, OldRoleId:~p~n", [OldRoleId]),
					%%?DEBUG_MSG("[mod_login] enter_game(), SAME account old online player, RoleId:~p, OldRoleId:~p", [RoleId, OldRoleId]),
					?ASSERT(player:is_online(OldRoleId), {RoleId, AccName, OldRoleId, OldPS}),
					
					% 通知客户端账户在别处登录
					notify_cli_account_relogin(OldPS), 
					
					%%timer:sleep(1000),
					
					force_disconnect(AccName, FromServerId, OldRoleId, player:get_pid(OldPS))
			end,
			
			?ASSERT(begin
						case RoleId /= OldRoleId of
							true -> not player:is_online(RoleId);
							false -> true
						end
					end, {RoleId, AccName, OldRoleId, OldPS}),
			%%%%%%%%%%%%%%%%%%%%%%%%%%%% 这里会出问题  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
			% 角色自身有可能正在执行tmp logout或final logout的处理，故tsl同步一下！
			case mod_lginout_TSL:tsl(t_is_logouting, sl_entering_game, [RoleId]) of
				true ->
					% 等待完成退出
					case wait_until_logout_done(RoleId) of
						ok ->
							?TRACE("wait_until_logout_done() ok!! RoleId:~p~n", [RoleId]),
							?ASSERT(not player:is_online(RoleId), {RoleId, AccName, OldRoleId, OldPS}),
							enter_game__(Socket, [RoleId, AccName, ReaderPid, PhoneInfo, FromServerId]);
						timeout ->
							?ERROR_MSG("[mod_login] wait_until_logout_done() timeout!!!!! RoleId:~p, OldRoleId:~p, IsOldRoleOnline:~p, IsOldRoleInTmpLogoutCache:~p, OldPS:~w", [RoleId, OldRoleId, player:is_online(OldRoleId), player:in_tmplogout_cache(OldRoleId), OldPS]),
							
							% todo: 补救措施？？...
							% 为什么会timeout？等待原角色退出超时，但前面又强制断开了原角色，这时候接来下的登录请求怎么处理？
							
							{fail, server_busy}
					end;
				false ->
					?ASSERT(not player:is_online(RoleId), {RoleId, AccName, OldRoleId, OldPS}),
					
					% 角色有可能正在处理游戏逻辑（如：队伍，副本等）重连超时，故tsl同步一下！
					case mod_lginout_TSL:tsl(t_is_handling_game_logic_reconn_timeout, sl_entering_game, [RoleId]) of
						true ->
							% 等待完成处理
							case wait_until_handle_game_logic_reconn_timeout_done(RoleId) of
								ok ->
									enter_game__(Socket, [RoleId, AccName, ReaderPid, PhoneInfo, FromServerId]);
								timeout ->
									?ERROR_MSG("[mod_login] wait_until_handle_game_logic_reconn_timeout_done() timeout!!!!! RoleId:~p, OldRoleId:~p, IsOldRoleOnline:~p, IsOldRoleInTmpLogoutCache:~p, OldPS:~w", [RoleId, OldRoleId, player:is_online(OldRoleId), player:in_tmplogout_cache(OldRoleId), OldPS]),
									{fail, server_busy}
							end;
						false ->
							?TRACE("mod_lginout_TSL, not logouting, so enter game, RoleId:~p~n", [RoleId]),
							enter_game__(Socket, [RoleId, AccName, ReaderPid, PhoneInfo, FromServerId])
					end
 			end;
 		_ ->
 			{fail, server_busy}
	end.


%% 跨服玩家进入游戏并初始化数据和进程，rpc通道把跨服玩家数据发过来开启玩家镜像进程
%% 初次开启玩家进程？需要判断是否已存在吗，由于镜像进程会挂掉，具体原因需要排查，目前处理方案是玩家进程由跨服节点主动建立
%% enter_game_cross(ServerId, PlayerId) ->
%% 	case sm_cross_server:rpc_call(ServerId, ?MODULE, get_cross_player_data, [PlayerId]) of
%% 		{ok, {PS, Titles, OpenSysList, Inv, GoodsList, MountList, PartnerList, PlyXfInfo, PB}} ->
%% 			enter_game_cross(PS, Titles, OpenSysList, Inv, GoodsList, MountList, PartnerList, PlyXfInfo, PB),
%% 			ok;
%% 		{fail, _} ->
%% 			%% 超时，提示玩家重试
%% 			ok
%% 	end.
%% 		
%% enter_game_cross(PS, Titles, OpenSysList, Inv, GoodsList, MountList, PartnerList, PlyXfInfo, PB) ->
%% 	ServerId = player:get_server_id(PS),
%% 	PlayerId = player:id(PS),
%% 	Socket = player:get_socket(PS),
%% 	%% 开启mod_player进程
%% 	PidOld = player:get_pid(PlayerId),
%% 	PlayerPid = 
%% 		case is_pid(PidOld) == true andalso is_process_alive(PidOld) of
%% 			?true ->
%% 				PidOld;
%% 			_ ->
%% 				{ok, PlayerPid0} = mod_player:start(PlayerId),
%% 				PlayerPid0
%% 		end,
%% 	SendPidOld = player:get_sendpid(PlayerId),
%% 	SendPid = 
%% 		case is_pid(SendPidOld) andalso is_process_alive(SendPidOld) of
%% 			?true ->
%% 				SendPidOld;
%% 			_ ->
%% 				{ok, SendPid0} = sm_writer:start_link_cross(ServerId, PlayerId),
%% 				SendPid0
%% 		end,
%% 	nosql:set(sock_writer_map, Socket, SendPid),
%% 	PS2 = PS#player_status{pid = PlayerPid, sendpid = SendPid},
%% 	init_ets_data_for_enter_game(PS2, role_not_in_cache),
%% 	PhoneInfo = #phone_info{},
%% 	% 初始化玩家进程的内部状态
%%     gen_server:cast(PlayerPid, {'init_internal_state', PS2, [self(), PhoneInfo, ServerId]}),
%% 	
%% 	% 添加到门派的玩家列表
%%     ply_faction:on_player_login(PS),
%% 
%% 	ply_title:set_titles(Titles),
%% 
%% 	ply_sys_open:set_opened_sys_list(PlayerId, OpenSysList),
%% 	
%% 	[lib_mount:update_mount(Mount) || Mount <- MountList],
%% 	[mod_partner:add_partner_to_ets(Partner) || Partner <- PartnerList],
%% 	ply_xinfa:add_player_xinfa_info_to_ets(PlyXfInfo),
%% 	mod_svr_mgr:add_online_player_brief_to_ets(PB#plyr_brief{pid = PlayerPid, socket = null, sendpid = SendPid, is_online = true}),
%% 	
%% 	mod_inv:add_inventory_to_ets(Inv),
%% 	[mod_inv:add_goods_to_ets(Goods) || Goods <- GoodsList],
%% 
%%     % 进一步初始化，放最后
%%     ?LDS_TRACE("LDS ~n login_success_init~n"),
%% 	% 初始化具体位置
%% 	SceneId = player:get_scene_id(PS2),
%% 	{X, Y} = case player:get_position(PS) of
%% 			#plyr_pos{x = X0, y = Y0} ->
%% 				{X0, Y0};
%% 			_ ->
%% 				{0, 0}
%% 		end,
%%     player:init_position(PlayerId, {SceneId, X, Y}),
%% 	
%% 	ply_scene:enter_scene_on_login(PS),
%% 	player:set_online(PlayerId, true),
%% 	
%% 	void.



get_cross_player_data(PlayerId) ->
	PS = player:get_PS(PlayerId),
	Inv = mod_inv:get_inventory(PlayerId),
	GoodsList = lists:foldl(fun(GoodsId, Acc) ->
									case mod_inv:get_goods_from_ets(GoodsId) of
										null -> Acc;
										Goods ->
											[Goods|Acc]
									end
							end, [], Inv#inv.player_eq_goods ++ Inv#inv.partner_eq_goods),
	Titles = ply_title:get_titles(PlayerId),
	OpenSysList = ply_sys_open:get_opened_sys_list(PlayerId),
	MountList = lib_mount:get_all_mount(PlayerId),
	PartnerList = ply_partner:get_partner_list(PlayerId),
	PlyXfInfo = ply_xinfa:get_player_xinfa_info(PlayerId),
	PB = mod_svr_mgr:get_online_player_brief(PlayerId),
	{PS#player_status{server_id = config:get_server_id()}, Titles, OpenSysList, Inv, GoodsList, MountList, PartnerList, PlyXfInfo, PB}.


find_player_to_kick(AccName, FromServerId) ->
	mod_svr_mgr:find_online_player_by_accname({AccName, FromServerId}).



%% 为避免因意外而导致死循环等待，故设定最大等待次数
-define(MAX_WAIT, 4).

%% 等待角色完成tmp logout或final logout
%% @return: ok | timeout
wait_until_logout_done(RoleId) ->
	wait_until_logout_done__(RoleId, 0).

wait_until_logout_done__(_RoleId, ?MAX_WAIT) ->
	timeout;
wait_until_logout_done__(RoleId, AccWaitTimes) ->
	?TRACE("$$$$$ wait_until_logout_done__(), RoleId=~p, AccWaitTimes=~p $$$$$~n", [RoleId, AccWaitTimes]),
	%%?DEBUG_MSG("$$$$$ wait_until_logout_done__(), RoleId=~p, AccWaitTimes=~p $$$$$", [RoleId, AccWaitTimes]),
	timer:sleep(2000),%% 这里最多8秒钟
	case mod_lginout_TSL:tsl_2(t_is_logout_done, sl_entering_game, [RoleId]) of
		true ->
			ok;
		false ->
			wait_until_logout_done__(RoleId, AccWaitTimes + 1)
	end.





%% 等待完成游戏逻辑重连超时的处理
%% @return: ok | timeout
wait_until_handle_game_logic_reconn_timeout_done(RoleId) ->
	wait_until_handle_game_logic_reconn_timeout_done__(RoleId, 0).

wait_until_handle_game_logic_reconn_timeout_done__(_RoleId, ?MAX_WAIT) ->
	timeout;
wait_until_handle_game_logic_reconn_timeout_done__(RoleId, AccWaitTimes) ->
	?TRACE("$$$$$ wait_until_handle_game_logic_reconn_timeout_done__(), RoleId=~p, AccWaitTimes=~p $$$$$~n", [RoleId, AccWaitTimes]),
	%%?DEBUG_MSG("$$$$$ wait_until_handle_game_logic_reconn_timeout_done__(), RoleId=~p, AccWaitTimes=~p $$$$$", [RoleId, AccWaitTimes]),
	timer:sleep(1800),
	case mod_lginout_TSL:tsl_2(t_handle_game_logic_reconn_timeout_done, sl_entering_game, [RoleId]) of
		true ->
			ok;
		false ->
			wait_until_handle_game_logic_reconn_timeout_done__(RoleId, AccWaitTimes + 1)
	end.






enter_game__(Socket, [RoleId, AccName, ReaderPid, PhoneInfo, FromServerId]) ->
	case player:in_tmplogout_cache(RoleId) of
		false ->
			do_enter_game(role_not_in_cache, Socket, [RoleId, AccName, ReaderPid, PhoneInfo, FromServerId]);
		true ->
			% TODO: 优化：两个remove操作合为一个
			mod_ply_jobsch:remove_sch_reconnect_timeout(RoleId), % 移除角色重连超时的作业计划（异步）
			mod_ply_jobsch:remove_sch_game_logic_reconn_timeout(RoleId), % 移除游戏逻辑重连超时的作业计划（异步）
			% ?ASSERT(mod_ply_jobsch:dbg_find_schs(RoleId, ?JSET_RECONNECT_TIMEOUT) == []),
			% ?ASSERT(mod_ply_jobsch:dbg_find_schs(RoleId, ?JSET_GAME_LOGIC_RECONN_TIMEOUT) == []),
			do_enter_game(role_in_cache, Socket, [RoleId, AccName, ReaderPid, PhoneInfo, FromServerId])
	end.



-define(DISCONNECT_PLAYER_INTV, 15). % 断开各玩家的间隔，单位：毫秒

%% 强行断开所有在线玩家
disconnect_all(Reason) ->
    L = mod_svr_mgr:get_all_online_player_id_pid_list(),  
    do_disconnect_all(L, Reason).

do_disconnect_all([], _Reason) ->
    ok;
do_disconnect_all([{PlayerId, Pid} | T], Reason) ->
	force_disconnect("", ?INVALID_ID, PlayerId, Pid, Reason),
	timer:sleep(?DISCONNECT_PLAYER_INTV),  % sleep一下，避免玩家瞬间集中下线而给数据库带来太高的压力
    do_disconnect_all(T, Reason).






%% 强行断开玩家
%% tips: 更好的做法是发送特定消息给reader进程，reader进程收到消息后做相关处理然后退出。 后面做新项目时再改进！ -- huangjf
force_disconnect(AccName, FromServerId, PlayerId, Pid) ->
	force_disconnect(AccName, FromServerId, PlayerId, Pid, normal).

force_disconnect(AccName, FromServerId, PlayerId, Pid, Reason) ->
	?ASSERT(is_integer(PlayerId)),
	?ASSERT(is_pid(Pid), Pid),
    ?TRACE("~n~n[mod_login] force_disconnect(), AccName=~p, FromServerId=~p, PlayerId=~p, Pid=~p, is proc alive:~p~n~n", [AccName, FromServerId, PlayerId, Pid, is_process_alive(Pid)]),

	%% 这里有疑问，如果这里将角色在线状态设置为下线，那下次的进入游戏直接忽略另一边已经登录的进程？
    before_disconnect(AccName, FromServerId, PlayerId),
    mod_player:stop(Pid, Reason),
    ok.


%% 断开前的处理
before_disconnect(AccName, FromServerId, PlayerId) ->
	player:set_online(PlayerId, false),  % 标记为非在线，这里标记很重要，会影响后来登录的玩家可以直接进入游戏而不需要理会是否原角色是否还在?
	mod_svr_mgr:del_map_of_accname_to_online_player({AccName, FromServerId}),  % 删除映射，以避免客户端重连时误判当前账号下仍然已有角色在线
	mod_lginout_TSL:mark_tmp_logouting(PlayerId).  % 标记为临时退出中



%% 临时退出（玩家断线后会执行此处理），作为玩家进程终止（terminate）时的“回调”
%% 注意：断线后，玩家的数据会缓存在内存中，当玩家重连超时或FinalLogoutDelay参数传入false时，才执行final_logout()将其数据从内存清掉
%% @para: FinalLogoutDelay => 是否需要延迟执行final_logout()
tmp_logout(PS, FinalLogoutDelay) ->
	?TRY_CATCH(tmp_logout__(PS, FinalLogoutDelay), ErrReason),

	PlayerId = player:id(PS),
	mod_lginout_TSL:mark_tmp_logout_done(PlayerId),

	?BIN_PRED(FinalLogoutDelay, skip, final_logout(PlayerId, player:get_admin_callback_pid())).



tmp_logout__(PS, FinalLogoutDelay) ->
	?TRACE("~n~n[mod_login] tmp_logout__() begin, FinalLogoutDelay:~p, Time=~p, PlayerId=~p, PlayerPid=~p, is pid alive:~p~n~n", [FinalLogoutDelay, util:unixtime(), player:id(PS), player:get_pid(PS), is_process_alive(player:get_pid(PS))]),
	?ASSERT(is_record(PS, player_status), PS),
	PlayerId = player:id(PS),

	TimeNow = svr_clock:get_unixtime(),

	% 离开场景
	?TRY_CATCH(ply_scene:leave_scene_on_logout(PS), ErrReason_LeaveScene),

	% 移除相关的所有作业计划
	?TRY_CATCH(mod_ply_jobsch:remove_all_schs(PlayerId), ErrReason_RemoveSch),

	% 添加游戏逻辑重连超时的作业计划
	case ply_comm:should_add_game_logic_reconn_timeout_job_sch(PS) of
		true -> ?TRY_CATCH(mod_ply_jobsch:add_sch_game_logic_reconn_timeout(PlayerId), ErrReason_AddGameLgReconnTimeoutSch);
		false -> skip
	end,

	% 添加角色重连超时的作业计划
	case FinalLogoutDelay of
		true -> ?TRY_CATCH(mod_ply_jobsch:add_sch_reconnect_timeout(PlayerId), ErrReason_AddReconnTimeoutSch);
		false -> skip
	end,

	% 处理组队
	?TRY_CATCH(mod_team:on_player_tmp_logout(PS), ErrReason_Team),

    % 删除交易系统的相关作业计划
    ?TRY_CATCH(ply_trade:on_player_tmp_logout(PlayerId), ErrReason_Trade),

    % 通知battle judger
    ?TRY_CATCH(mod_battle_judger:on_player_logout(PS), ErrReason_BattleJudger),

	% 若在战斗中则通知战斗进程
	CurBattlePid = player:get_cur_battle_pid(PS),
	?Ifc (CurBattlePid /= null)
		?ASSERT(is_pid(CurBattlePid), {CurBattlePid, PlayerId}),
		?TRY_CATCH(mod_battle:on_player_logout(PS, CurBattlePid), ErrReason_Battle)
	?End,

    % 更新内存数据并移除作业计划(玩家下线需要马上停止buff的计时)
    ?TRY_CATCH(lib_buff:on_player_tmp_logout(PlayerId, player:get_partner_id_list(PS)), ErrReason_Buff),

	% todo: 下线通知好友与仇人（如有必要的话）...

	% 保存聊天相关数据
	?TRY_CATCH(lib_chat:tmp_logout_chat(PlayerId), ErrReason_Chat),

	% 保存任务数据
	?TRY_CATCH(lib_task:tmp_logout_out(PlayerId), ErrReason_Task),

	% 保存邮件数据
	?TRY_CATCH(lib_mail:logout(PlayerId), ErrReason_Mail),

	% 保存活跃度信息
	?TRY_CATCH(lib_activity_degree:tmp_logout(PlayerId), ErrReason_AD),

	% 保存找回经验信息
	?TRY_CATCH(lib_jingyan:tmp_logout(PlayerId), ErrReason_JY),

	% 通知副本处理
	?TRY_CATCH(lib_dungeon:temp_logout(PS), ErrReason_Dun),

	% 通知成就处理
	?TRY_CATCH(mod_achievement:tmp_logout(PlayerId), ErrReason_Achi),

	% 从门派的玩家列表移除
	?TRY_CATCH(ply_faction:on_player_tmp_logout(PS), ErrReason_Faction),

	% 宠物系统相关
    ?TRY_CATCH(ply_partner:on_player_tmp_logout(PS), ErrReason_Par),

    ?TRY_CATCH(ply_relation:on_player_logout(PS), ErrReason_Rela),

    ?TRY_CATCH(ply_cruise:on_player_tmp_logout(PS), ErrReason_Cruise),

    ?TRY_CATCH(ply_arena_1v1:on_player_tmp_logout(PS)),

    ?TRY_CATCH(ply_arena_3v3:on_player_tmp_logout(PS), ErrReason_Arena_3v3),

    % 女妖选美-抽奖活动相关
    ?TRY_CATCH(lib_beauty_contest:tmp_logout(PS), ErrReason_Beautycontest),

    % 商会信息相关
    ?TRY_CATCH(lib_business:tmp_logout(PS), ErrReason_Business),

    % % 玩家拓展信息信息相关
    ?TRY_CATCH(lib_player_ext:tmp_logout(PS), ErrReason_PlayerExt),

    ?TRY_CATCH(mod_guild_war:on_player_logout(PS), ErrReason_GuildWar),

    % 通知幸运轮盘处理
	?TRY_CATCH(lib_ernie:tmp_logout(PlayerId), ErrReason_Ernie),

	% 通知家园处理
	?TRY_CATCH(lib_home:tmp_logout(PS), ErrReason_Home),
	
	% 跨服处理
	?TRY_CATCH(lib_cross:tmp_logout(PlayerId), ErrReason_Cross),

	% 处理房间
	?TRY_CATCH(lib_pvp:on_pvp_player_tmp_logout(PS), ErrReason_PVP_3V3),

    PS2 = offline_sys_on_logout(PS),

	% 添加PS到临时退出的玩家ets，当做缓存
	mod_svr_mgr:add_tmplogout_player_status_to_ets(PS2#player_status{
		last_logout_time = TimeNow % 更新last_logout_time，勿忘！
	}),

	% 从在线玩家ets中删除PS
	mod_svr_mgr:del_online_player_status_from_ets(PlayerId),

	% 简要信息从在线转移到临时退出
	PB0 = mod_svr_mgr:get_online_player_brief(PlayerId),
	?ASSERT(PB0 /= null, PlayerId),
	PB = 
		case lib_cross:check_is_remote() of
			?true ->
				PB0#plyr_brief{cross_state = ?CROSS_STATE_REMOTE};
			?false ->
				PB0#plyr_brief{cross_state = ?CROSS_STATE_LOCAL}
		end,
	mod_svr_mgr:shift_player_brief(from_online_to_tmplogout, PB),

    % 处理幻境组队问题
    ?TRY_CATCH(mod_team:on_mirage_tmp_logout(PS), ErrReason_Mirage),

	% 日志记录玩家退出
	?TRY_CATCH(lib_log:logout(PS2), ErrReason_LogLogout),

	%%?DEBUG_MSG("~n~n[mod_login] tmp_logout__() ends!!!!! Time:~p, PlayerId:~p, is pid alive:~p~n~n", [util:unixtime(), PlayerId, is_process_alive(player:get_pid(PS))]),
	ok.





%% （玩家断线后因超时未重新连接而导致）最终退出
final_logout(PlayerId) ->
	final_logout(PlayerId, null).

final_logout(PlayerId, AdminCallbackPid) ->
	?ASSERT(is_integer(PlayerId)),
	% 交由logout server做处理
	mod_lgout_svr:final_logout(PlayerId, AdminCallbackPid).



%% ======================================================== Local Functions =============================================================================


offline_sys_on_logout(PS) ->
	case catch lib_offline:logout(PS) of
		RetPS when is_record(RetPS, player_status) ->
			RetPS;
		Other ->
			?ERROR_MSG("lib_offline:logout() error!! details:~w", [Other]),
			?ASSERT(false, Other),
			PS
  	end.



%% 通知客户端：账户在别处登录了
notify_cli_account_relogin(PS) ->
	?DEBUG_MSG("notify_cli_account_relogin(), PlayerId:~p, self:~w", [player:id(PS), self()]),
	{ok, BinData} = pt_10:write(?PT_NOTIFY_ACC_RELOGIN, []),
	lib_send:send_to_sock(PS, BinData, true).


reinit_pos_for_reconnect(PS) ->
	PlayerId = player:id(PS),
	Race = player:get_race(PS),
	Lv = player:get_lv(PS),
	case player:get_position(PlayerId) of
		null ->  % 矫正位置以容错
			?ASSERT(false, PlayerId),
			?ERROR_MSG("[mod_login] reinit_pos_for_reconnect() error!! pos is null! PlayerId:~p", [PlayerId]),
    		player:init_position(PlayerId, ply_scene:get_adjusted_pos(Race, Lv));
		Pos ->
			case lib_scene:is_bad_pos(Pos#plyr_pos.scene_id, Pos#plyr_pos.x, Pos#plyr_pos.y) of
				true ->  % 矫正位置以容错
					?ERROR_MSG("[mod_login] reinit_pos_for_reconnect() error!! bad pos! PlayerId:~p, Pos:~w", [PlayerId, Pos]),
					case player:is_in_dungeon(PS) of
						{true, Pid} ->
							gen_server:cast(Pid, {'quit_dungeon', PS});
						false ->
							% 尝试就近找一个合法位置
							case lib_scene:find_nearby_legal_pos(Pos#plyr_pos.scene_id, Pos#plyr_pos.x, Pos#plyr_pos.y) of
								{ok, {NearbyX, NearbyY}} ->
									?WARNING_MSG("adjust to nearby pos! PlayerId:~p, OldPos:~p, NearbyX:~p, NearbyY:~p", [PlayerId, Pos, NearbyX, NearbyY]),
									player:init_position(PlayerId, {Pos#plyr_pos.scene_id, NearbyX, NearbyY});
								fail ->
									player:init_position(PlayerId, ply_scene:get_adjusted_pos(Race, Lv))
							end		
					end;
				false ->
					skip
			end
	end.


%% 重连进入游戏时判定行为状态
decide_bhv_state_for_reconnect(PS) ->
	CurBbhvState = player:get_cur_bhv_state(PS),
	if
		CurBbhvState =:= ?BHV_COUPLE_HIDE ->
			CurBbhvState;
		true ->
			?BHV_IDLE
	end.
	% case player:is_battling(PS) of
	% 	false ->
	% 		player:get_cur_bhv_state(PS);  % 行为状态不变
	% 	true ->
	% 		BattlePid = player:get_cur_battle_pid(PS),
	% 		case is_pid(BattlePid) andalso is_process_alive(BattlePid) of
 %                true ->
 %            		player:get_cur_bhv_state(PS);  % 行为状态不变
 %            	false ->
 %            		?BHV_IDLE  % 重置为空闲
 %            end
	% end.



%% 重连进入游戏时重新初始化玩家结构体
%% @return: 重新初始化后的玩家结构体
reinit_player_for_reconnect(OldPS, [NewPid, NewSocket]) ->
	PlayerId = player:id(OldPS),
	reinit_pos_for_reconnect(OldPS),
	ply_scene:reset_step_counter(PlayerId), % 重置计步器
    NewPS = OldPS#player_status{
					pid           = NewPid,               		% 重新绑定进程
					socket        = NewSocket,            		% 重新绑定socket
					cur_bhv_state = decide_bhv_state_for_reconnect(OldPS),
					sendpid       = erlang:get(send_pid),
					login_ip      = misc:get_ip(NewSocket),     % 更新本次的登录IP
					login_time    = svr_clock:get_unixtime(),   % 更新本次的登录时间
					is_leader 	  = false
					},
	NewPS2 = lib_offline:login(NewPS),
    nosql:set(sock_user_map, NewSocket, NewPS2#player_status.sendpid),
    NewPS2.


%% 重连进入游戏（角色数据在缓存中）
%% @return: {ok, PlayerPid} | fail
do_enter_game(role_in_cache, Socket, [RoleId, _AccName, ReaderPid, PhoneInfo, FromServerId]) ->
	?TRACE("do_enter_game(role_in_cache,...), RoleId:~p~n", [RoleId]),
	%%?DEBUG_MSG("do_enter_game(role_in_cache,...), RoleId:~p~n", [RoleId]),
	{ok, NewPid} = mod_player:start(RoleId),
	% 这里判断下临时缓存里的跨服状态是否为跨服中，如果是就发消息给mod_player进程处理把玩家送回跨服去?
	case ply_tmplogout_cache:get_tmplogout_PBrf(RoleId) of
		#plyr_brief{cross_state = ?CROSS_STATE_REMOTE} ->% 离线前是跨服状态，标记mod_player为remote状态，待初始化化时做相应处理
			player:mark_cross_remote(NewPid);
		_ ->
			skip
	end,
	try
		PS = ply_tmplogout_cache:call_get_tmplogout_PS(RoleId),  % 须同步获取！
		?ASSERT(PS /= null, RoleId),
		?ASSERT(not is_process_alive(player:get_pid(PS)), RoleId),
		PS2 = reinit_player_for_reconnect(PS, [NewPid, Socket]),
		do_more_enter_game(role_in_cache, PS2, [ReaderPid, PhoneInfo, FromServerId]),
		{ok, NewPid}
	catch
		_: Reason ->
			?CRITICAL_MSG("[mod_login] do_enter_game(role_in_cache, ...) failed: RoleId=~p, Reason=~w~n stack=~w", [RoleId, Reason, erlang:get_stacktrace()]),
			mod_player:stop(NewPid),

			?ASSERT(false, Reason),
			fail
	end;

%% 全新进入游戏（角色数据不在缓存中）
%% @return: {ok, PlayerPid} | fail
do_enter_game(role_not_in_cache, Socket, [RoleId, AccName, ReaderPid, PhoneInfo, FromServerId]) ->
	?TRACE("do_enter_game(role_not_in_cache,...), RoleId:~p~n", [RoleId]),
	%%?DEBUG_MSG("do_enter_game(role_not_in_cache,...), RoleId:~p~n", [RoleId]),
	% ?ASSERT(mod_ply_jobsch:dbg_find_schs(RoleId, ?JSET_RECONNECT_TIMEOUT) == []),
	% ?ASSERT(mod_ply_jobsch:dbg_find_schs(RoleId, ?JSET_GAME_LOGIC_RECONN_TIMEOUT) == []),
	{ok, NewPid} = mod_player:start(RoleId),
	try
		PS = db_load_and_init_player(Socket, [RoleId, AccName, FromServerId], NewPid),
		do_more_enter_game(role_not_in_cache, PS, [ReaderPid, PhoneInfo, FromServerId]),

		% 20151124新增登录后从新计算宠物属性
		ParList = ply_partner:get_partner_list(PS),

		F = fun(Par, Sum) ->
			Partner = lib_partner:recount_equip_add_and_total_attrs(RoleId, Par#partner.id),
			mod_partner:update_partner_to_ets(Partner),
	        Sum
	    end,

		lists:foldl(F,0,ParList),

		{ok, NewPid}
	catch
		_: Reason ->
			?CRITICAL_MSG("[mod_login] do_enter_game(role_not_in_cache, ...) failed: RoleId=~p, Reason=~w~n stack=~w", [RoleId, Reason, erlang:get_stacktrace()]),
			mod_player:stop(NewPid),

			% 进入游戏失败，则断言在线玩家表里没有该玩家数据
			?ASSERT(player:get_PS(RoleId) == null),
			?ASSERT(false, Reason),

			fail
	end.


% old:
% %% 等玩家进程完全退出（每1秒轮询1次）
% %% TODO: 改为通过id去调player:is_online()来判断是否完全退出
% %%      另外， 注意：为了杜绝函数递归的死循环，应该定一个wait的次数上限，递归超过该上限，则直接返回fail
% wait_player_logout(Pid) ->
% 	?TRACE("$$$$$ wait_player_logout:pid=~p $$$$$~n", [Pid]),
% 	timer:sleep(1000),
% 	case is_pid(Pid) andalso erlang:is_process_alive(Pid) of
% 		true ->
% 			wait_player_logout(Pid);
% 		false ->
% 			skip
% 	end.




% %% 为避免因意外而导致死循环等待，故设定最大等待次数
% -define(MAX_WAIT, 15).

% %% 等待原角色完成临时退出
% %% @return: ok | timeout
% wait_until_tmp_logout_done(RoleId) ->
% 	wait_until_tmp_logout_done__(RoleId, 0).

% wait_until_tmp_logout_done__(_RoleId, ?MAX_WAIT) ->
% 	timeout;
% wait_until_tmp_logout_done__(RoleId, AccWaitTimes) ->
% 	?TRACE("$$$$$ wait_until_tmp_logout_done__(), RoleId=~p, AccWaitTimes=~p $$$$$~n", [RoleId, AccWaitTimes]),
% 	timer:sleep(500),
% 	case tmp_logout_done(RoleId) of
% 		true ->
% 			ok;
% 		false ->
% 			wait_until_tmp_logout_done__(RoleId, AccWaitTimes + 1)
% 	end.


% %% 是否已完成临时退出的处理？
% tmp_logout_done(RoleId) ->
% 	case player:in_tmplogout_cache(RoleId) of
% 		false ->
% 			false;
% 		true ->
% 			PB = mod_svr_mgr:get_tmplogout_player_brief(RoleId),
% 			PB#plyr_brief.is_tmplogout_done
% 	end.




% %% 等待角色完成最终退出
% wait_until_final_logout_done(RoleId) ->
% 	wait_until_final_logout_done__(RoleId, 0).

% wait_until_final_logout_done__(_RoleId, ?MAX_WAIT) ->
% 	done;
% wait_until_final_logout_done__(RoleId, AccWaitTimes) ->
% 	?TRACE("$$$$$ wait_until_final_logout_done__(), RoleId=~p, AccWaitTimes=~p $$$$$~n", [RoleId, AccWaitTimes]),
% 	timer:sleep(500),
% 	case final_logout_done(RoleId) of
% 		true ->
% 			done;
% 		false ->
% 			wait_until_final_logout_done__(RoleId, AccWaitTimes + 1)
% 	end.


% %% 是否已完成最终退出的处理？
% final_logout_done(RoleId) ->
% 	not player:in_tmplogout_cache(RoleId).



do_more_enter_game(IfRoleInCache, PS, [ReaderPid, PhoneInfo, FromServerId]) ->
	PlayerId = player:id(PS),
	% 先处理ets的数据
	init_ets_data_for_enter_game(PS, IfRoleInCache),

	PlayerPid = player:get_pid(PS),
	?ASSERT(is_pid(PlayerPid), PlayerPid),

	% 初始化玩家进程的内部状态
    gen_server:cast(PlayerPid, {'init_internal_state', PS, [ReaderPid, PhoneInfo, FromServerId]}),


    % TODO： 确定----下面这些处理是否要统一移到mod_player模块的handle_cast('more_init_for_enter_game', ..)中？

    %?DEBUG_MSG("total online num:~p ==> process:~p~n",[mod_svr_mgr:get_total_online_num(), erlang:system_info(process_count)]),

    % todo: 如果必要，重新添加相关的job schedule
    % ...

    % 添加到门派的玩家列表
    ply_faction:on_player_login(PS),

    % 从DB加载玩家自己和宠物的buff
    lib_buff:on_player_login(PS, IfRoleInCache),

    % ply_partner:on_player_login(PS),

    %% 检验帮派数据是否一致，以便容错
	mod_guild_mgr:check_player_guild_info(PS, player:get_guild_id(PS)),

	PlayerId = player:id(PS),

	ply_title:on_login(PlayerId),

	mod_guild_war:on_player_login(PS),
    % 进一步初始化，放最后
    ?LDS_TRACE("LDS ~n login_success_init~n"),
    gen_server:cast(PlayerPid, {'more_init_for_enter_game', IfRoleInCache}).

init_ets_data_for_enter_game(PS_Latest, IfRoleInCache) ->
	NewPlayerBrf = make_player_brief(PS_Latest),
	case IfRoleInCache of
		role_in_cache ->
			?ASSERT(mod_svr_mgr:get_tmplogout_player_status(player:id(PS_Latest)) /= null),
			?ASSERT(mod_svr_mgr:get_tmplogout_player_brief(player:id(PS_Latest)) /= null),
			% 从临时退出转移到在线
			mod_svr_mgr:shift_player_brief(from_tmplogout_to_online, NewPlayerBrf),
			mod_svr_mgr:shift_player_status(from_tmplogout_to_online, PS_Latest);
		role_not_in_cache ->
			?ASSERT(mod_svr_mgr:get_tmplogout_player_status(player:id(PS_Latest)) == null),
			?ASSERT(mod_svr_mgr:get_tmplogout_player_brief(player:id(PS_Latest)) == null),
%% 			?ASSERT(mod_svr_mgr:get_online_player_status(player:id(PS_Latest)) == null),
%% 			?ASSERT(mod_svr_mgr:get_online_player_brief(player:id(PS_Latest)) == null),
			% 直接添加
			mod_svr_mgr:add_online_player_brief_to_ets(NewPlayerBrf),
			mod_svr_mgr:add_online_player_status_to_ets(PS_Latest)
	end,
	?ASSERT(mod_svr_mgr:find_online_player_by_accname({player:get_accname(PS_Latest), player:get_from_server_id(PS_Latest)}) == null),
	% 添加映射：账户名 -> 账户下当前在线的角色
	mod_svr_mgr:add_map_of_accname_to_online_player(PS_Latest).
	% NewPlayerBrf = make_player_brief(PS_Latest),
	% case IfRoleInCache of
	% 	role_in_cache ->
	% 		?ASSERT(mod_svr_mgr:get_tmplogout_player_status(player:id(PS_Latest)) /= null),
	% 		?ASSERT(mod_svr_mgr:get_tmplogout_player_brief(player:id(PS_Latest)) /= null),

	% 		?Ifc (mod_svr_mgr:get_tmplogout_player_status(player:id(PS_Latest)) == null)
	% 			?ERROR_MSG("mod_svr_mgr:get_tmplogout_player_status playerid=~p",[player:id(PS_Latest)])
	% 		?End,
			
	% 		?Ifc (mod_svr_mgr:get_tmplogout_player_brief(player:id(PS_Latest)) == null)
	% 			?ERROR_MSG("mod_svr_mgr:get_tmplogout_player_brief playerid=~p",[player:id(PS_Latest)])
	% 		?End,

	% 		% 从临时退出转移到在线
	% 		mod_svr_mgr:shift_player_brief(from_tmplogout_to_online, NewPlayerBrf),
	% 		mod_svr_mgr:shift_player_status(from_tmplogout_to_online, PS_Latest);
	% 	role_not_in_cache ->
	% 		?Ifc (mod_svr_mgr:get_tmplogout_player_status(player:id(PS_Latest)) /= null)
	% 			?ERROR_MSG("mod_svr_mgr:get_tmplogout_player_status playerid=~p",[player:id(PS_Latest)])
	% 		?End,
			
	% 		?Ifc (mod_svr_mgr:get_tmplogout_player_brief(player:id(PS_Latest)) /= null)
	% 			?ERROR_MSG("mod_svr_mgr:get_tmplogout_player_brief playerid=~p",[player:id(PS_Latest)])
	% 		?End,

	% 		?Ifc (mod_svr_mgr:get_online_player_status(player:id(PS_Latest)) /= null)
	% 			?ERROR_MSG("mod_svr_mgr:get_online_player_status playerid=~p",[player:id(PS_Latest)])
	% 		?End,

	% 		?Ifc (mod_svr_mgr:get_online_player_brief(player:id(PS_Latest)) /= null)
	% 			?ERROR_MSG("mod_svr_mgr:get_online_player_brief playerid=~p",[player:id(PS_Latest)])
	% 		?End,

	% 		% % 直接添加
	% 		mod_svr_mgr:add_online_player_brief_to_ets(NewPlayerBrf),
	% 		mod_svr_mgr:add_online_player_status_to_ets(PS_Latest)
	% end,
	% ?ASSERT(mod_svr_mgr:find_online_player_by_accname({player:get_accname(PS_Latest), player:get_from_server_id(PS_Latest)}) == null),
	% % 添加映射：账户名 -> 账户下当前在线的角色
	% mod_svr_mgr:add_map_of_accname_to_online_player(PS_Latest).


make_player_brief(PS) ->
	#plyr_brief{
		id = player:id(PS),
		pid = player:get_pid(PS),
		socket = player:get_socket(PS),
		sendpid = player:get_sendpid(PS),
		is_online = false  % 默认为false，进入游戏的处理流程到最后一步时，才标记玩家为在线 -- huangjf
		}.


%% 对位置进行检测和纠正（如果有必要的话），以免玩家处于非法位置
adjust_position(PlayerId, SceneType0, SceneId0, X0, Y0, PrevPos, [Race, GuildId, Lv]) ->
    {SceneId, X, Y} = 	case lib_scene:is_copy_scene(SceneId0)
    					andalso (not lib_scene:is_reserve_scene(SceneId0)) of
				    		false ->
				    			{SceneId0, X0, Y0};
				    		true ->
				    			{PreSceneId, {PreX, PreY}} = PrevPos,
				    			case SceneType0 of
				    				?SCENE_T_GUILD -> % 如果下线时在帮派场景(所有帮派成员可以进入做任务的)，则需要进入帮派场景
				    					GuildSceneId = mod_guild:get_guild_scene_id(GuildId),
				    					{GuildSceneId, X0, Y0};
				    				_ ->
				    					{PreSceneId, PreX, PreY}
				    			end
				    	end,

    % 判断
    case (SceneType0 == ?SCENE_T_INVALID)
    orelse lib_scene:is_bad_pos(SceneId, X, Y) of
    	true -> % 容错：矫正到正常的地点
    		% ?ERROR_MSG("[mod_login] bad position!!! PlayerId:~p, SceneType0:~p, SceneId0:~p, X0:~p, Y0:~p, SceneId:~p, X:~p, Y:~p, PrevPos:~w, Race:~p, GuildId:~p~n",
    								% [PlayerId, SceneType0, SceneId0, X0, Y0, SceneId, X, Y, PrevPos, Race, GuildId]),
    		{AdjustedSceneNo, AdjustedX, AdjustedY} = ply_scene:get_adjusted_pos(Race, Lv),
    		{AdjustedSceneNo, AdjustedX, AdjustedY};
    	false ->
    		?TRACE("[mod_login] adjust_position(), SceneType0:~p, SceneId0:~p, X0:~p, Y0:~p, SceneId:~p, X:~p, Y:~p, PrevPos:~w, Race:~p, GuildId:~p~n",
    								[SceneType0, SceneId0, X0, Y0, SceneId, X, Y, PrevPos, Race, GuildId]),
    		{SceneId, X, Y}
    end.



%% （全新进入游戏时）加载并初始化玩家数据
%% @return: player_status结构体
db_load_and_init_player(Socket, [PlayerId, AccName, FromServerId], PlayerPid) ->
	TimeNow = svr_clock:get_unixtime(),
    [
		_AccName_BS,
		Nickname_BS,
		SceneType0,
		SceneId0,
		X0,
		Y0,

		PrivLv,

		Race,
		Faction,
		Sex,
		Lv,
		Exp,

		CurHp,
		CurMp,
		Yuanbao,
		BindYuanbao,
		GameMoney,
		BindGameMoney,
		Integral,
		Copper,
        Jingwen,
		Dan,
		Mijing,
		Huanjing,
		Chivalrous,
		Vitality,

		BagEQCapacity,
		BagUSCapacity,
		BagUNUSCapacity,
		StorageCapacity,
		TGuildId,
		GuildAttrs_BS,
		CultivateAttrs_BS,

		BaseTalents_BS,
		FreeTalentPoints,
		%%NewbieGuideStep,
		LastLogoutTime,

		VipLv,
		VipExp,
		VipActive,
		VipExpire,
		LastDailyResetTime,
		LastWeeklyResetTime,

		TeamTargetType,
		TeamCon1,
		TeamCon2,
		PartnerCapacity,
		FightParCapacity,

		PrevPos_BS,
		DunInfo,
		Feat,
		StoreHp,
		StoreMp,
		StoreParHp,
		StoreParMp,

		CreateTime,
		UpdateMoodCount,
		LastUpdateMoodTime,
		AccumOlTime,
		Literary,
		LiteraryClearTime,
		RechargeState,
		MonthCardState,
		RechargeRewardState,
		RechargeAccum,
		ConsumeState,
		RoleAdminAct,
		YuanbaoAcc,
		SlotExp,
		LocalId,
		OpenedSys_BS,
		XS_TaskIssueNum,
		XS_TaskLeftIssueNum,
		XS_TaskReceiveNum,
		OneRechargeReward,
		ZF_BS,
		Contri,
		RechargeAccumDay,
		Mount,
		LastTransfromTime,
		DayTransfromTimes,
		JingmaiInfos_BS,
		JingmaiPoint,
		FirstRechargeReward,
		LoginRewardDay,
		LoginRewardTime,
		LeaveGuildTime,
		PeakLv,
		Reincarnation,
		UnlimitedResource,
		FactionSkills
      ] = lib_account:db_load_player_base_info(PlayerId),

    %%%?ASSERT(binary_to_list(_AccName_BS) =:= AccName, {_AccName_BS, AccName}), % 目前mysql不区分大小写，故"abc"和"ABC"都表示同一账号，
    																		% 因此，内部测试时可能出现这种情况：_AccName_BS为<<"abc">>, AccName为"ABC"，
    																		% 因此本断言不一定成立，屏蔽掉！
    																		% 注：对于正式上线后的外服，因为平台的账号名都是一串数字，不会包含字母，故不需担心这个问题。
    																		%     ---- huangjf


    ply_sys_open:init_opened_sys_list(PlayerId, OpenedSys_BS),

    % 初始化物品栏
    mod_inv:init_inventory(PlayerId, PlayerPid, [BagEQCapacity, BagUSCapacity, BagUNUSCapacity, StorageCapacity]),

    PrevPos = 	case util:bitstring_to_term(PrevPos_BS) of
    				undefined ->
    					{SceneId0, {X0, Y0}};
    				_Pre -> _Pre
    			end,

    GuildId = case lib_account:is_global_uni_id(TGuildId) of true -> TGuildId; false -> lib_account:to_global_uni_id(TGuildId) end,

    % 按需矫正位置
    {SceneId, X, Y} = adjust_position(PlayerId, SceneType0, SceneId0, X0, Y0, PrevPos, [Race, GuildId, Lv]),

    % 初始化具体位置
    player:init_position(PlayerId, {SceneId, X, Y}),

    % 从DB加载玩家的坐骑
	lib_mount:on_login(PlayerId),
    MountIdList = lib_mount:init_login(PlayerId),

    % 从DB加载玩家的宠物
    ParIdList = ply_partner:db_load_partner_data(PlayerId),

		mod_strengthen:on_login(PlayerId),
    % 尝试加载帮派相关信息
    ply_guild:db_maybe_load_guild_info(PlayerId, GuildId),
    % 初始化心法（从DB加载心法数据）
    ply_xinfa:init_xinfa(PlayerId, Lv),

    % L = lib_player_ext:try_load_data(PlayerId),
    % ?DEBUG_MSG("lib_player_ext:try_load_data(PlayerId)={~p}",lib_player_ext:try_load_data(PlayerId,popular)),
    Popular = case lib_player_ext:try_load_data(PlayerId,popular) of
    	fail ->
    		0;
    	{ok,PValue} ->
    		PValue
    end,

    Chip = case lib_player_ext:try_load_data(PlayerId,chip) of
    	fail ->
    		0;
    	{ok,Chipalue} ->
    		Chipalue
    end,

    % 飞升次数
    Soaring = case lib_player_ext:try_load_data(PlayerId,soaring) of
    	fail ->
    		0;
    	{ok,SoaringValue} ->
    		SoaringValue
    end,

    % 杀人数
    KillNum = case lib_player_ext:try_load_data(PlayerId,kill_num) of
    	fail ->
    		0;
    	{ok,KillNum_} ->
    		KillNum_
    end,
    % 被杀数
    BeKillNum = case lib_player_ext:try_load_data(PlayerId,be_kill_num) of
    	fail ->
    		0;
    	{ok,BeKillNum_} ->
    		BeKillNum_
    end,

    % 被杀数
    PvpFlee = case lib_player_ext:try_load_data(PlayerId,pvp_flee) of
    	fail ->
    		0;
    	{ok,PvpFlee_} ->
    		PvpFlee_
    end,

    ?DEBUG_MSG("PvpFlee=~p",[PvpFlee]),

    % 帮派贡献度
    GuildContri = case lib_player_ext:try_load_data(PlayerId,guild_contri) of
    	fail ->
    		0;
    	{ok,GuildContri_} ->
    		GuildContri_
    end,

    % 帮派战功
    GuildFeat = case lib_player_ext:try_load_data(PlayerId,guild_feat) of
    	fail ->
    		0;
    	{ok,GuildFeat_} ->
    		GuildFeat_
    end,

    % 初始化我的天将数据
    mod_hire:db_load_hirer_info(PlayerId),
	ShowingEqs = mod_equip:build_player_showing_equips(PlayerId),
	Vip = lib_vip:vip_rec(VipLv, VipExp, VipActive, VipExpire),	
	ply_relation:db_try_load_rela_info(PlayerId),
	ply_relation:db_get_relation_id_list(PlayerId),

    PS0 = #player_status{
				id                    = PlayerId,
				local_id			  = LocalId,
				server_id			  = config:get_server_id(),
				accname               = AccName,
				nickname              = Nickname_BS,   % nickname不转为list类型！ 直接用binary

				from_server_id        = FromServerId, 

				pid                   = PlayerPid,    % 玩家进程pid
				socket                = Socket,
				sendpid               = erlang:get(send_pid),

				create_time           = CreateTime,
				login_time            = TimeNow,
				login_ip              = misc:get_ip(Socket), % 当前登录的IP地址
				last_logout_time      = LastLogoutTime,

				priv_lv 			  = PrivLv,

				race                  = Race,
				faction               = Faction,
				sex                   = Sex,
				lv                    = Lv,
				exp                   = Exp,

				recharge_state   	  = case util:bitstring_to_term(RechargeState) of undefined -> ?ASSERT(false), []; RechargeS -> RechargeS end,
				month_card_state	  = case util:bitstring_to_term(MonthCardState) of undefined -> ?ASSERT(false), []; MonthCardS -> MonthCardS end,
				first_recharge_reward_state = RechargeRewardState,
				recharge_accum		  = case util:bitstring_to_term(RechargeAccum) of undefined -> ?ASSERT(false), []; RechargeA -> RechargeA end,
				consume_state 		  = case util:bitstring_to_term(ConsumeState) of undefined -> ?ASSERT(false), []; ConsumeS -> ConsumeS end,
				admin_acitvity_state  = case util:bitstring_to_term(RoleAdminAct) of undefined -> ?ASSERT(false), []; Aas -> Aas end,
				exp_slot = case util:bitstring_to_term(SlotExp) of undefined -> ?ASSERT(false), {0, 0}; [] -> {0, 0}; SlEp -> SlEp end,

				free_talent_points    = FreeTalentPoints,

				cur_bhv_state         = ?BHV_IDLE,

				move_speed            = ?BASE_MOVE_SPEED,
				%%% att_distance          = ?PLAYER_ATT_DISTANCE,

				yuanbao               = Yuanbao,
				bind_yuanbao          = BindYuanbao,
				gamemoney             = GameMoney,
				bind_gamemoney        = BindGameMoney,
				integral			  = Integral, 
				copper				  = Copper,
				popular               = Popular,
				chip                  = Chip,
				jingwen               = Jingwen,
				dan					  = Dan,
				mijing                = Mijing,
				huanjing              = Huanjing,
				chivalrous			  = Chivalrous,
				vitality			  = Vitality,
				feat                  = Feat,
				literary 			  = Literary,
				literary_clear_time	  = LiteraryClearTime,
				yuanbao_acc 		  = YuanbaoAcc,

				guild_contri		  = GuildContri,
				guild_feat			  = GuildFeat,


				guild_id              = GuildId,
				guild_attrs 		  = case util:bitstring_to_term(GuildAttrs_BS) of undefined -> []; GuildAttrs -> GuildAttrs end,
				cultivate_attrs       = case util:bitstring_to_term(CultivateAttrs_BS) of undefined -> []; CultivateAttrs -> CultivateAttrs end, 

				jingmai_infos		  = case util:bitstring_to_term(JingmaiInfos_BS) of undefined -> []; JingmaiInfos -> JingmaiInfos end,
				jingmai_point		  = JingmaiPoint,
				
				% newbie_guide_step     = NewbieGuideStep,

				vip                   = Vip,
				last_daily_reset_time 	  = LastDailyResetTime,
				last_weekly_reset_time 	  = LastWeeklyResetTime,
				team_target_type      = TeamTargetType,
				team_condition1       = TeamCon1,
				team_condition2       = TeamCon2,

				partner_capacity      = PartnerCapacity,
				fight_par_capacity    = FightParCapacity,
				partner_id_list       = ParIdList,
				main_partner_id       = mod_partner:find_main_partner_id(ParIdList),
				follow_partner_id 	  = mod_partner:find_follow_partner_id(ParIdList),
				dun_info              = case util:bitstring_to_term(DunInfo) of undefined -> ?DEF_DUN_INFO; Dun -> lib_dungeon:tranform_dun_info_to_load(Dun) end,
				% dun_info            = ?DEF_DUN_INFO,
				prev_pos              = PrevPos,
				showing_equips        = ShowingEqs,
				suit_no 			  = mod_equip:decide_player_suit_no(PlayerId),
				store_hp              = StoreHp,
				store_mp              = StoreMp,
				store_par_hp          = StoreParHp,
				store_par_mp          = StoreParMp,
				update_mood_count     = UpdateMoodCount,
				last_update_mood_time = LastUpdateMoodTime,
				accum_online_time     = AccumOlTime,
				xs_task_issue_num 	  = XS_TaskIssueNum,
				xs_task_left_issue_num= XS_TaskLeftIssueNum,
				xs_task_receive_num   = XS_TaskReceiveNum,
				one_recharge_reward   = case util:bitstring_to_term(OneRechargeReward) of undefined -> ?ASSERT(false), []; OneRechargeRewardL -> OneRechargeRewardL end,
				zf_state			  = case util:bitstring_to_term(ZF_BS) of undefined -> ply_zf:init_zf(); ZFL when ZFL =/= [] -> ZFL; _ -> ply_zf:init_zf() end,
				contri  			  = Contri,
				recharge_accum_day	  = case util:bitstring_to_term(RechargeAccumDay) of undefined -> ?ASSERT(false), []; RechargeDayA -> RechargeDayA end,
				mount 				  = Mount,
				mount_id_list         = MountIdList,
				last_transform_time   = LastTransfromTime,
				day_transform_times   = DayTransfromTimes
				
				,be_kill_num = BeKillNum
				,kill_num = KillNum
				,pvp_flee = PvpFlee
				,soaring = Soaring
				,first_recharge_reward = case util:bitstring_to_term(FirstRechargeReward) of undefined -> ?ASSERT(false), []; FirstRechargeRewardL -> FirstRechargeRewardL end
				,login_reward_day = LoginRewardDay
				,login_reward_time = LoginRewardTime
				,leave_guild_time = LeaveGuildTime
				,peak_lv = PeakLv
				,reincarnation = Reincarnation
				,unlimited_resources = util:bitstring_to_term(UnlimitedResource)
				,faction_skills = util:bitstring_to_term(FactionSkills)
    			},

    nosql:set(sock_user_map, Socket, PS0#player_status.sendpid),

    ?LDS_TRACE("db_load_and_init_player", [DunInfo, PS0#player_status.dun_info,
    	(case util:bitstring_to_term(DunInfo) of undefined -> ?DEF_DUN_INFO; Dun1 -> Dun1 end)]),

	% BaseTalents_Tup: {力量，体质，耐力，灵力，敏捷}
	BaseTalents_Tup = util:bitstring_to_term(BaseTalents_BS),
	BaseTalents = lib_attribute:to_talents_record(BaseTalents_Tup),

	% 初始化基础属性
	PS1 = init_base_attrs(PS0, BaseTalents, CurHp, CurMp),

	PS2 = lib_offline:login(PS1),
	PS3 = ply_activity:init(PS2),
	PS4 = lib_vip:check_expire(PS3),

    PS4.



init_base_attrs(PS0, BaseTalents, CurHp, CurMp) ->
	Race = player:get_race(PS0),
	% 依据种族和天赋，计算基础属性
	InitBaseAttrs = ply_attr:calc_base_attrs(Race, BaseTalents),

	% 赋值基础天赋信息
	InitBaseAttrs2 = InitBaseAttrs#attrs{
						talent_str = BaseTalents#talents.str,
						talent_con = BaseTalents#talents.con,
						talent_sta = BaseTalents#talents.sta,
						talent_spi = BaseTalents#talents.spi,
						talent_agi = BaseTalents#talents.agi
						},

	InitTotalAttrs = InitBaseAttrs2#attrs{hp = CurHp, mp = CurMp}, % 设置当前的hp和mp
	?TRACE("[mod_login] init_base_attrs(), InitBaseAttrs2=~w, CurHp=~p, CurMp=~p~n", [InitBaseAttrs2, CurHp, CurMp]),

	% 赋值，返回新结构体
	PS0#player_status{
		base_attrs = InitBaseAttrs2,
		total_attrs = InitTotalAttrs
		}.


% init_attrs(PS0, BaseTalents, CurHp, CurMp) ->
% 	PlayerId = player:get_id(PS0),
% 	Race = player:get_race(PS0),

% 	% 计算装备的属性加成
% 	EquipAddAttrs = ply_attr:calc_equip_add_attrs(PlayerId),

% 	% 计算总天赋
% 	EquipAddTalents = lib_attribute:to_talents_record(EquipAddAttrs),
% 	TalentsList = [BaseTalents, EquipAddTalents],
% 	TotalTalents = lib_attribute:sum_talents(TalentsList),

% 	% 依据种族和总天赋，计算基础属性
% 	BaseAttrs = ply_attr:calc_base_attrs(Race, TotalTalents),

% 	% 赋值基础天赋信息
% 	BaseAttrs2 = BaseAttrs#attrs{
% 					talent_str = BaseTalents#talents.str,
% 					talent_con = BaseTalents#talents.con,
% 					talent_sta = BaseTalents#talents.sta,
% 					talent_spi = BaseTalents#talents.spi,
% 					talent_agi = BaseTalents#talents.agi
% 					},

% 	% 最后计算总属性
% 	AttrsList = [BaseAttrs2, EquipAddAttrs],
% 	TotalAttrs = lib_attribute:sum_attrs(AttrsList),
% 	TotalAttrs2 = lib_attribute:adjust_attrs(TotalAttrs),  % 勿忘做矫正！
% 	TotalAttrs3 = TotalAttrs2#attrs{hp = CurHp, mp = CurMp}, % 设置当前的hp和mp

% 	% 赋值，返回新结构体
% 	PS0#player_status{
% 		base_attrs = BaseAttrs2,
% 		equip_add_attrs = EquipAddAttrs,
% 		total_attrs = TotalAttrs3
% 		}.







% %% desc：检查禁言有无到期
% check_ban_chat(Pid, EndBanTime) ->
% 	if
% 		EndBanTime > 0 ->
% 			?TRACE("**** Login EndBanTime > 0 \n"),
% 			gen_server:cast({global, ?GLOBAL_TIMER}, {'un_ban_chat', Pid, ?START_NOW, (EndBanTime - util:unixtime())*1000, 1});
% 		true ->
% 			skip
% 	end.
