%% @author zhengjingyi
%% @doc @todo Add description to lib_tower_ghost.
%% 伏魔塔

-module(lib_tower_ghost).
-include("common.hrl").
-include("tower_ghost.hrl").
-include("dungeon.hrl").
-include("prompt_msg_code.hrl").
-include("record/battle_record.hrl").
-include("log.hrl").
-include("reward.hrl").
-include("goods.hrl").

%% ====================================================================
%% API functions
%% ====================================================================
-export([
		 chanllenge_floor/1, 
		 get_tower_ghost_info/1,
		 get_tower_ghost_data/1, 
		 restore_times/1, 
		 interval_incr_times/1, 
		 interval_incr_times/2, 
		 interval_incr_times_ply/1
		]).


%% 挑战爬塔层怪物
chanllenge_floor(PS) ->
	restore_times(PS),
	case check_chanllenge_floor(PS) of
		{ok, TowerGhost, DungeonData, Floor} ->
			do_chanllenge_floor(PS, Floor, TowerGhost, DungeonData);
		{fail, Reason} ->
			{fail, Reason} 
	end.


check_chanllenge_floor(PS) ->
	case player:is_idle(PS) of
		false ->
			{fail, ?PM_DATA_CONFIG_ERROR};
		true ->
			case get_tower_ghost_data(PS) of
				{ok, TowerGhost} ->
					case TowerGhost#tower_ghost.times > 0 of
						?true ->
							Floor = TowerGhost#tower_ghost.floor + 1,
							case get_dungeon_config(Floor) of
								{ok, DungeonData} ->
									{ok, TowerGhost, DungeonData, Floor};
								null ->
									{fail, ?PM_DATA_CONFIG_ERROR}
							end;
						?false ->
							{fail, ?PM_OFFLINE_ARENA_CHALL_NOT_TIMES}
					end;
				null ->
					%% 没数据
					{fail, ?PM_DATA_CONFIG_ERROR}
			end
	end.
									 


do_chanllenge_floor(PS, Floor) ->
	%% 直接挑战怪物即可
	case get_dungeon_config(Floor) of
		{ok, DungeonData} ->
			case get_tower_ghost_data(PS) of
				{ok, TowerGhost} ->
					do_chanllenge_floor(PS, TowerGhost, Floor, DungeonData);
				null ->
					{fail, ?PM_DATA_CONFIG_ERROR}
			end;
		null ->
			{fail, ?PM_DATA_CONFIG_ERROR}
	end.


do_chanllenge_floor(PS, Floor, TowerGhost, DungeonData) ->
	#dungeon_data{listen_bout_battle = [BMonGroupNo|_]} = DungeonData,
	Fun = fun chanllenge_floor_battle_callback/3,
	Args = [Floor],
	Callback = {Fun, Args},
	mod_battle:start_mf(PS, BMonGroupNo, Callback),
	TowerGhost2 = TowerGhost#tower_ghost{times = TowerGhost#tower_ghost.times - 1},
	update_tower_ghost_data(TowerGhost2),
	mod_achievement:notify_achi('huodong_zhenyaota', [], PS),
	ok.


%% 伏魔塔战斗回调(这里是玩家本进程回调的)
chanllenge_floor_battle_callback(PlayerId, BattleFeedback, Floor) ->
	%% 判断战斗胜利或者失败？
	#btl_feedback{
				  result = Result
				  } = BattleFeedback,
	case Result of
		win ->
			%% 战斗胜利，发奖励，最高层数改变，发消息通知前端
			case get_dungeon_config(Floor) of
				{ok, DungeonData} ->
					#dungeon_data{
								  final_reward = FinalReward,
								  first_reward = FirstReward
								  } = DungeonData,
					case get_tower_ghost_data(PlayerId) of
						{ok, TowerGhost} ->
							Status = player:get_PS(PlayerId),
							give_reward(Status, FinalReward),		
							NewFloor = erlang:max(TowerGhost#tower_ghost.floor, Floor),
							case NewFloor > TowerGhost#tower_ghost.floor of
								?true ->
									give_reward(Status, FirstReward);
								?false ->
									skip
							end,
							TowerGhost2 = TowerGhost#tower_ghost{floor = NewFloor},
							update_tower_ghost_data(TowerGhost2),
							%% 通关更新排行榜
							mod_rank:role_tower_ghost(Status, NewFloor),
							ok;
						null ->
							?ERROR_MSG("error unknown tower ghost data : ~p~n", [{PlayerId, Floor}])
					end;
				null ->
					?ERROR_MSG("error unknown tower ghost Floor : ~p~n", [Floor])
			end;
		_ ->
			ok
	end.


give_reward(_Status, 0) ->
	ok;

give_reward(Status, RewardNo) ->
	GoodsList = 
		case lib_reward:check_bag_space(Status, RewardNo) of
			ok ->
				RewardRd = lib_reward:give_reward_to_player(Status, RewardNo, [?LOG_TOWER_GHOST, "tower_ghost"]),
				RewardRd#reward_dtl.goods_list;
			{fail, _Reason} ->
				%% 发邮件
				RoleId = player:get_id(Status),
				RewardRd = lib_reward:calc_reward_to_player(RoleId, RewardNo),
				case RewardRd#reward_dtl.calc_goods_list =/= [] of
					true ->
						lib_mail:send_sys_mail(RoleId, <<"伏魔塔奖励">>, <<"您的背包已满，奖励通过邮件发送给您。">>, RewardRd#reward_dtl.calc_goods_list, [?LOG_TOWER_GHOST, "tower_ghost"]),
						RewardRd#reward_dtl.calc_goods_list;
					false ->
						[]
				end
		end,
	Datas = lists:foldl(fun({Id, No, Count}, Acc) ->
								[{Id, No, Count, 0, ?BIND_NEVER}|Acc]
						end, [], GoodsList),
	{ok, BinData} = pt_49:write(49007, [Datas]),
	lib_send:send_to_sock(Status, BinData).


%% 回复伏魔塔挑战次数
restore_times(PlayerId) when is_integer(PlayerId) ->
	case get_tower_ghost_data(PlayerId) of
		{ok, TowerGhost} ->
			Unixtime = util:unixtime(),
			SecondsDiff = erlang:abs(Unixtime - TowerGhost#tower_ghost.last_time_restore),
			Tower_ghost_resotre_internal = data_special_config:get('tower_ghost_resotre_internal'),
			Times = SecondsDiff div Tower_ghost_resotre_internal,
			case Times > 0 of
				?true ->
					Tower_ghost_init_times = data_special_config:get('tower_ghost_init_times'),
					TowerGhostTimes = erlang:min(Tower_ghost_init_times, TowerGhost#tower_ghost.times + Times),
					TowerGhost2 = TowerGhost#tower_ghost{times = TowerGhostTimes, last_time_restore = Unixtime},
					update_tower_ghost_data(TowerGhost2);
				?false ->
					ok
			end;
		null ->
			ok
	end;

restore_times(PS) ->
	restore_times(player:id(PS)).
	

%% 前端请求伏魔塔界面数据
get_tower_ghost_info(PlayerId) ->
	case get_tower_ghost_data(PlayerId) of
		{ok, _TowerGhost} ->
			restore_times(PlayerId),
			get_tower_ghost_data(PlayerId);
		null ->
			null
	end.


%% 获取伏魔塔数据
get_tower_ghost_data(PlayerId) when is_integer(PlayerId) ->
	case ets:lookup(?ETS_TOWER_GHOST, PlayerId) of
		[] ->
			case db_select(PlayerId) of
				{ok, TowerGhost} ->
					ets:insert(?ETS_TOWER_GHOST, TowerGhost),
					{ok, TowerGhost};
				null ->
					Tower_ghost_init_times = data_special_config:get('tower_ghost_init_times'),
					TowerGhost = #tower_ghost{player_id = PlayerId, floor = 0, times = Tower_ghost_init_times, last_time_restore = util:unixtime()},
					db_insert(TowerGhost),
					ets:insert(?ETS_TOWER_GHOST, TowerGhost),
					{ok, TowerGhost}
			end;
		[TowerGhost] ->
			{ok, TowerGhost}
	end;

get_tower_ghost_data(Status) ->
	PlayerId = player:id(Status),
	get_tower_ghost_data(PlayerId).
	

%% 更新保存伏魔塔数据
update_tower_ghost_data(TowerGhost) ->
	ets:insert(?ETS_TOWER_GHOST, TowerGhost),
	db_update(TowerGhost),
	ok.


%% 获取配置数据（根据层数获取对应的副本配置数据）
get_dungeon_config(Floor) ->
	Nos = data_dungeon:get_nos(),
	get_dungeon_config(Nos, Floor).

get_dungeon_config([No|Nos], Floor) ->
	case data_dungeon:get(No) of
		#dungeon_data{type = ?DUNGEON_TYPE_TOWER_GHOST, floor = Floor} = DungeonData ->
			{ok, DungeonData};
		_ ->
			get_dungeon_config(Nos, Floor)
	end;

get_dungeon_config([], _Floor) ->
	null.



%% 滴答定时器定时调用的接口让全服在线的玩家定时回复挑战次数
interval_incr_times(LastRestoreTime) ->
	Unixtime = util:unixtime(),
	interval_incr_times(LastRestoreTime, Unixtime).


interval_incr_times(LastRestoreTime, Unixtime) ->
	Tower_ghost_resotre_internal = data_special_config:get('tower_ghost_resotre_internal'),
	case abs(Unixtime - LastRestoreTime) >= Tower_ghost_resotre_internal of
		?true ->
			OnlinePids = mod_svr_mgr:get_all_online_player_id_pid_list(),
			[gen_server:cast(Pid, {apply_cast, ?MODULE, interval_incr_times_ply, [PlayerId]}) || {PlayerId, Pid} <- OnlinePids],
			Unixtime;
		?false ->
			LastRestoreTime
	end.
	
	
interval_incr_times_ply(PlayerId) ->
	restore_times(PlayerId).
	
	


%% ====================================================================
%% Internal functions
%% ====================================================================
%% db select db查询记录
%% @return: {ok, #tower_ghost{}} | null
db_select(PlayerId) ->
	Fields_sql = "`floor`, `times`, `last_time_restore`",
	Where_List = [{player_id, PlayerId}],
	case db:select_row(?TABLE_TOWER_GHOST, Fields_sql, Where_List) of
		[Floor, Times, LastTimeRestore] ->
			TowerGhost = #tower_ghost{player_id = PlayerId, floor = Floor, times = Times, last_time_restore = LastTimeRestore},
			{ok, TowerGhost};
		[] ->
			null
	end.

%% db insert db插入新记录
%% @return: ok
db_insert(TowerGhost) ->
	#tower_ghost{
				 player_id = PlayerId,
				 floor = Floor,
				 times = Times,
				 last_time_restore = LastTimeRestore
				} = TowerGhost,
	Field_Value_List = [
						{player_id, PlayerId}, 
						{floor, Floor}, 
						{times, Times}, 
						{last_time_restore, LastTimeRestore}
					   ],
	db:insert(?TABLE_TOWER_GHOST, Field_Value_List),
	ok.


%% db update db更新记录
%% @return: ok
db_update(TowerGhost) ->
	#tower_ghost{
				 player_id = PlayerId,
				 floor = Floor,
				 times = Times,
				 last_time_restore = LastTimeRestore
				} = TowerGhost,
	Field_Value_List = [{floor, Floor}, 
						{times, Times}, 
						{last_time_restore, LastTimeRestore}],
	Where_List = [{player_id, PlayerId}],
	db:update(?TABLE_TOWER_GHOST, Field_Value_List, Where_List),
	ok.


%% db delete db删除记录
%% @return: ok
%% db_delete(PlayerId) ->
%% 	Where_List = [{player_id, PlayerId}],
%% 	db:delete(?TABLE_TOWER_GHOST, Where_List),
%% 	ok.







