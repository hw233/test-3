%%%--------------------------------------
%%% @Module  : ply_comm
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2013.6.5
%%% @Description: 玩家相关的通用接口
%%%--------------------------------------
-module(ply_comm).
-export([
		should_add_game_logic_reconn_timeout_job_sch/1,
		notify_cli_enter_game_result/2,
		notify_cli_server_timestamp/1,
		notify_new_day_comes_to_all/0,
		notify_cli_will_be_force_disconn_soon/2,
		create_locolId_playerId_map/2,
		get_global_uni_id_by_local_id/1
    ]).

-include("common.hrl").
-include("pt_10.hrl").
-include("ets_name.hrl").



%% 下线时是否需要添加游戏逻辑（如：队伍，副本等）重连超时的作业计划
%% @return: true | false
should_add_game_logic_reconn_timeout_job_sch(PS) ->
	Bool1 = player:is_in_team(PS),
	Bool2 = case player:is_in_dungeon(PS) of
				{true, _DungeonPid} -> true;
				false -> false
			end,

	Bool1 orelse Bool2.



%% 通知客户端：进入游戏的结果
notify_cli_enter_game_result(Socket, [RetCode, RoleId]) ->
	% ?DEBUG_MSG("[ply_comm] notify_cli_enter_game_result(), RetCode:~p, RoleId:~p", [RetCode, RoleId]),
	{ok, BinData} = pt_10:write(?PT_ENTER_GAME, [RetCode, RoleId]),
	lib_send:send_to_sock(Socket, BinData, true).


%% 通知客户端：服务器的unix时间戳
notify_cli_server_timestamp(PS) ->
	{ok, BinData} = pt_10:write(?PT_QUERY_SERVER_TIMESTAMP, [util:unixtime()]),
    lib_send:send_to_sock(PS, BinData).



%% 通知所有在线玩家的进程：新的一天到了
notify_new_day_comes_to_all() ->
	spawn(fun() -> do_notify_new_day_comes_to_all() end).


do_notify_new_day_comes_to_all() ->
	L = mod_svr_mgr:get_all_online_player_pids(),
	do_notify_new_day_comes_to_all__(L).


-define(NOTIFY_NEW_DAY_COMES_INTV, 40).

do_notify_new_day_comes_to_all__([]) ->
	?DEBUG_MSG("[ply_comm] do_notify_new_day_comes_to_all__(), done!! Unixtime:~p", [util:unixtime()]),
	done;
do_notify_new_day_comes_to_all__([PlayerPid | T]) ->
	?DEBUG_MSG("[ply_comm] do_notify_new_day_comes_to_all__(), PlayerPid:~p, Unixtime:~p", [PlayerPid, util:unixtime()]),
	gen_server:cast(PlayerPid, 'new_day_comes'),
	timer:sleep(?NOTIFY_NEW_DAY_COMES_INTV),    % 为避免集中处理，故稍sleep
	do_notify_new_day_comes_to_all__(T).




%% 通知客户端：即将被服务器强行断开
notify_cli_will_be_force_disconn_soon(PS, Reason) ->
	?DEBUG_MSG("notify_cli_will_be_force_disconn_soon(), PlayerId:~p, self:~w", [player:id(PS), self()]),
	ReasonCode = to_force_disconn_reason_code(Reason),
	{ok, BinData} = pt_10:write(?PT_NOTIFY_WILL_BE_FORCE_DISCONN_SOON, [ReasonCode]),
	lib_send:send_to_sock(PS, BinData, true).


to_force_disconn_reason_code(conn_heartbeat_freq_too_high) ->  % 心跳包频率太高（涉嫌使用加速外挂）
	1;
to_force_disconn_reason_code(_) ->
	?ASSERT(false),
	0.





%% 玩家的服务器内部流水id的最大值
% -define(MAX_PLAYER_LOCAL_ID, (100000000000 - 1)).


%% 创建local_id player_id 映射表
create_locolId_playerId_map(LocalId, PlayerId) ->
	ets:insert(?ETS_LOCALID_PLAYERID_MAP, {LocalId, PlayerId}).
	


%% 依据玩家的服务器内部流水id，获取其对应的全局唯一id
%% @return : integer() | null
get_global_uni_id_by_local_id(LocalId) ->
	case ets:lookup(?ETS_LOCALID_PLAYERID_MAP, LocalId) of
		{LocalId, PlayerId} when is_integer(PlayerId) -> PlayerId;
		_ -> 
			case db:select_one(player, "id", [{local_id, LocalId}]) of
				PlayerId when is_integer(PlayerId) -> 
					create_locolId_playerId_map(LocalId, PlayerId),
					PlayerId;
				_ -> null
			end
	end.


