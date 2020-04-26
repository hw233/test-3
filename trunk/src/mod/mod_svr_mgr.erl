%%%------------------------------------
%%% @Module  : mod_svr_mgr
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2013.6.5
%%% @Description: 全服相关的一些接口
%%%------------------------------------

-module(mod_svr_mgr).
-export([
		add_map_of_accname_to_online_player/1,
		del_map_of_accname_to_online_player/1,
		find_online_player_by_accname/1,
		
		get_online_player_status/1,
		add_online_player_status_to_ets/1,
		update_online_player_status_to_ets/1,
		del_online_player_status_from_ets/1,
		

		get_tmplogout_player_status/1,
		add_tmplogout_player_status_to_ets/1,
		del_tmplogout_player_status_from_ets/1,
		update_tmplogout_player_status_to_ets/1,

		shift_player_status/2,

		% get_offline_player_status/1,
		% add_offline_player_status_to_ets/1,
		% del_offline_player_status_from_ets/1,
		% update_offline_player_status/1,
		

		get_online_player_brief/1,
		add_online_player_brief_to_ets/1,
		del_online_player_brief_from_ets/1,
		update_online_player_brief_to_ets/1,

		get_tmplogout_player_brief/1,
		add_tmplogout_player_brief_to_ets/1,
		del_tmplogout_player_brief_from_ets/1,
		update_tmplogout_player_brief_to_ets/1,

		shift_player_brief/2,
		

		get_all_online_player_sendpids/0,
		get_all_online_player_pids/0,
		get_all_player_ids/0,
		get_all_online_player_ids/0,
		get_all_online_player_id_pid_list/0,

		cleanup_residual_player_proc/2,

		open_recharge_accum_activity/1,
		open_recharge_one_activity/1,
		open_recharge_accum_day_activity/1,
		close_recharge_accum_activity/0,
		close_recharge_one_activity/0,
		close_recharge_accum_day_activity/0,
		check_recharge_accum_activity_open/1,
		check_recharge_one_activity_open/1,
		check_recharge_accum_day_activity_open/1,

		open_consume_activity/1,
		close_consume_activity/1,
		check_consume_activity_open/2,

		open_role_admin_activity/1,
		close_role_admin_activity/1,
		check_role_admin_activity_open/2,

		set_global_sys_var/1,
		set_global_sys_var_cache/1,
		get_global_sys_var/1,
		get_server_reward_multi/1,

		get_total_online_num/0
	]).

-include("common.hrl").
-include("record.hrl").
-include("ets_name.hrl").
-include("player.hrl").
-include("admin_activity.hrl").


%% @doc 查询服务器相关系统的奖励倍率
%% @Sys : 策划在节日活动表中配置的节日活动对应系统的No
%% @return : integer()
get_server_reward_multi(Sys) ->
	case mod_admin_activity:get_admin_sys_set(Sys) of
		null -> 1;
		[{multi_reward, Multi}] when is_integer(Multi) andalso Multi > 0 -> Multi;
		_ -> 1
	end.


%% @doc 开启全服充值累积活动
open_recharge_accum_activity(Activity) ->
	ets:delete_all_objects(?ETS_RECHARGE_ACCUM),
	ets:insert(?ETS_RECHARGE_ACCUM, #recharge_accum{id = Activity#admin_sys_activity.order_id, 
		start_time = Activity#admin_sys_activity.timestamp, end_time = Activity#admin_sys_activity.end_time,
		content = Activity#admin_sys_activity.content}),
	ok.

%% @doc 开启全服单笔充值活动
open_recharge_one_activity(Activity) ->
	ets:delete_all_objects(?ETS_RECHARGE_ONE),
	ets:insert(?ETS_RECHARGE_ONE, #recharge_one{id = Activity#admin_sys_activity.order_id, 
		start_time = Activity#admin_sys_activity.timestamp, end_time = Activity#admin_sys_activity.end_time,
		content = Activity#admin_sys_activity.content}),
	ok.

%% @doc 开启全服每日充值累积活动
open_recharge_accum_day_activity(Activity) ->
	ets:delete_all_objects(?ETS_RECHARGE_ACCUM_DAY),
	ets:insert(?ETS_RECHARGE_ACCUM_DAY, #recharge_accum_day{id = Activity#admin_sys_activity.order_id, 
		start_time = Activity#admin_sys_activity.timestamp, end_time = Activity#admin_sys_activity.end_time,
		content = Activity#admin_sys_activity.content}),
	ok.

%% @doc 关闭全服充值累积活动
close_recharge_accum_activity() -> 
	?LDS_DEBUG("del recharge_accum"),
	ets:delete_all_objects(?ETS_RECHARGE_ACCUM),
	ok.

%% @doc 关闭全服充值累积活动
close_recharge_one_activity() -> 
	?DEBUG_MSG("del recharge_one~n", []),
	ets:delete_all_objects(?ETS_RECHARGE_ONE),
	ok.

%% @doc 关闭全服每日充值累积活动
close_recharge_accum_day_activity() -> 
	?LDS_DEBUG("del recharge_accum_day"),
	ets:delete_all_objects(?ETS_RECHARGE_ACCUM_DAY),
	ok.

%% @return : false | {true, #recharge_accum{}}
check_recharge_accum_activity_open(Timestamp) ->
	case ets:tab2list(?ETS_RECHARGE_ACCUM) of
		[] -> false;
		[Activity | _] when is_record(Activity, recharge_accum) ->
			case Activity#recharge_accum.start_time > Timestamp of
				true -> false;
				false -> 
					case Activity#recharge_accum.end_time > Timestamp of
						true -> {true, Activity};
						false -> 
							close_recharge_accum_activity(),
							false
					end
			end
	end.

%% @return : false | {true, #recharge_one{}}
check_recharge_one_activity_open(Timestamp) ->
	case ets:tab2list(?ETS_RECHARGE_ONE) of
		[] -> false;
		[Activity | _] when is_record(Activity, recharge_one) ->
			case Activity#recharge_one.start_time > Timestamp of
				true -> false;
				false -> 
					case Activity#recharge_one.end_time > Timestamp of
						true -> {true, Activity};
						false -> 
							close_recharge_one_activity(),
							false
					end
			end
	end.

%% @return : false | {true, #recharge_accum{}}
check_recharge_accum_day_activity_open(Timestamp) ->
	case ets:tab2list(?ETS_RECHARGE_ACCUM_DAY) of
		[] -> false;
		[Activity | _] when is_record(Activity, recharge_accum_day) ->
			case Activity#recharge_accum_day.start_time > Timestamp of
				true -> false;
				false -> 
					case Activity#recharge_accum_day.end_time > Timestamp of
						true -> {true, Activity};
						false -> 
							close_recharge_accum_day_activity(),
							false
					end
			end
	end.

%% @doc 开启全服消费活动统计
%% @return : boolean()
open_consume_activity(Activity) when is_record(Activity, admin_sys_activity) ->
	?LDS_DEBUG(open_consume_activity, Activity),
	ets:insert(?ETS_CONSUME_ACTIVITY, #consume_activity{no = Activity#admin_sys_activity.sys, 
		start_time = Activity#admin_sys_activity.timestamp, end_time = Activity#admin_sys_activity.end_time,
		content = Activity#admin_sys_activity.content}),
	true;
open_consume_activity(_) -> false.


%% @doc 关闭全服消费活动统计
close_consume_activity(No) ->
	ets:delete(?ETS_CONSUME_ACTIVITY, No).


%% @doc 查询活动是否开启
%% @return : false | {true, #consume_activity{}}
check_consume_activity_open(No, Timestamp) ->
	case ets:lookup(?ETS_CONSUME_ACTIVITY, No) of
		[Activity | _] when is_record(Activity, consume_activity) -> 
			case Activity#consume_activity.end_time > Timestamp of
				true -> 
					case Activity#consume_activity.start_time > Timestamp of
						true -> false;
						false -> {true, Activity}
					end;
				false -> close_consume_activity(No), false
			end;
		_ -> false
	end.


%% @doc 开启玩家-后台活动
%% 同一时间不可重复配置的活动
open_role_admin_activity(Activity) when is_record(Activity, admin_sys_activity) ->
	ets:insert(?ETS_ADMIN_ACTIVITY_QUERY, #admin_activity_query{
		id = Activity#admin_sys_activity.sys			
		,start_time = Activity#admin_sys_activity.timestamp
		,end_time = Activity#admin_sys_activity.end_time
		,content = Activity#admin_sys_activity.content
		}),
	true.


close_role_admin_activity(Activity) when is_record(Activity, admin_sys_activity) ->
	ets:delete(?ETS_ADMIN_ACTIVITY_QUERY, Activity#admin_sys_activity.sys),
	ok.


check_role_admin_activity_open(Type, Timestamp) ->
	case ets:lookup(?ETS_ADMIN_ACTIVITY_QUERY, Type) of
		[Activity | _] when is_record(Activity, admin_activity_query) ->
			case Activity#admin_activity_query.end_time > Timestamp of
				true -> 
					case Activity#admin_activity_query.start_time > Timestamp of
						true -> false;
						false -> {true, Activity}
					end;
				false -> close_role_admin_activity(Activity), false
			end;
		_ -> false
	end.


%% @doc 添加全局变量设置
%% @return : boolean()
set_global_sys_var(Var) when is_record(Var, global_sys_var) ->
	try
		true = ets:insert(?ETS_GLOBAL_SYS_VAR, Var),
		db:replace(global_sys_var, 
			[{sys, Var#global_sys_var.sys}, 
			 {var, util:term_to_bitstring(Var#global_sys_var.var)}]
		),
		true
	catch
		_T:_E ->
			?ERROR_MSG("set_global_sys_var error = ~p~n", [{_T, _E}]),
			false
	end;
set_global_sys_var(_) -> false.


set_global_sys_var_cache(Var) when is_record(Var, global_sys_var) ->
	true = ets:insert(?ETS_GLOBAL_SYS_VAR, Var);
set_global_sys_var_cache(_) -> false.


%% @return : null | term()
get_global_sys_var(Sys) ->
	case ets:lookup(?ETS_GLOBAL_SYS_VAR, Sys) of
		[Rd | _] when is_record(Rd, global_sys_var) -> Rd#global_sys_var.var;
		_ -> null
	end.



%% 添加映射：账户名 -> 账户下当前在线的角色，
%% 仅仅是为了方便通过账户名查找对应的在线角色（角色进入游戏的流程中用到）
add_map_of_accname_to_online_player(PS) ->
    AccName = player:get_accname(PS),
    FromServerId = player:get_from_server_id(PS),
    PlayerId = player:id(PS),
    ?ASSERT(get_map_of_accname_to_online_player({AccName, FromServerId}) == null, {AccName, PlayerId}),
    ets:insert(?ETS_MAP_OF_ACCNAME_TO_ONLINE_PLAYER, {{AccName, FromServerId}, PlayerId}).

%% 删除映射
del_map_of_accname_to_online_player(PS) when is_record(PS, player_status) ->
	AccName = player:get_accname(PS),
	FromServerId = player:get_from_server_id(PS),
	%%%?ASSERT(get_map_of_accname_to_online_player(AccName) /= null, {AccName, PS}),  % 断言已不再适用，故注释掉！
    ets:delete(?ETS_MAP_OF_ACCNAME_TO_ONLINE_PLAYER, {AccName, FromServerId});
del_map_of_accname_to_online_player({AccName, FromServerId}) ->
	?ASSERT(is_list(AccName), AccName),
    ets:delete(?ETS_MAP_OF_ACCNAME_TO_ONLINE_PLAYER, {AccName, FromServerId}).

	


%% 获取映射
get_map_of_accname_to_online_player({AccName, FromServerId}) ->
	case ets:lookup(?ETS_MAP_OF_ACCNAME_TO_ONLINE_PLAYER, {AccName, FromServerId}) of
		[] ->
			null;
		[{{AccName, FromServerId}, PlayerId}] ->
			{{AccName, FromServerId}, PlayerId}
	end.


%% 通过账户名查找账户下当前在线的角色
%% @return: null | 玩家结构体
find_online_player_by_accname({AccName, FromServerId}) ->
	case get_map_of_accname_to_online_player({AccName, FromServerId}) of
		null ->
			null;
		{{AccName, FromServerId}, PlayerId} ->
			?ASSERT(player:is_online(PlayerId), PlayerId),
			get_online_player_status(PlayerId)

			% case player:is_online(PlayerId) of
			% 	true ->
			% 		PS = player:get_PS(PlayerId),
			% 		?ASSERT(PS /= null),
			% 		PS;
			% 	false ->
			% 		null
			% end
	end.



% ----------------------------------------------------------------------------------------------------------
% %% 获取在线玩家结构体
% %% @return: null | player_status结构体
% get_online_player_status(PlayerId) ->
% 	?ASSERT(is_integer(PlayerId), PlayerId),
% 	case ets:lookup(?MY_ETS_ONLINE(PlayerId), PlayerId) of
% 		[] ->  % 玩家不存在或者下线了
% 			null;
% 		[PlayerStatus] ->
% 			PlayerStatus
% 	end.

% %% 添加在线玩家到ets
% add_online_player_status_to_ets(PS)
%   when is_record(PS, player_status) ->
%   	% ?ASSERT(get_online_player_status(player:id(PS)) == null, PS),
%   	case get_online_player_status(player:id(PS)) of
%   		null -> 
%   			?DEBUG_MSG("online plauer_status not exists add ~p",[player:id(PS)]);
%   		_ ->
%   			?DEBUG_MSG("online plauer_status already exists update  ~p",[player:id(PS)])
%   	end,
%     ets:insert(?MY_ETS_ONLINE(PS), PS).
    
% %% 更新在线玩家到ets
% update_online_player_status_to_ets(PS_Latest)
%   when is_record(PS_Latest, player_status) ->
% 	?ASSERT(get_online_player_status(player:id(PS_Latest)) /= null, PS_Latest),
%     ets:insert(?MY_ETS_ONLINE(PS_Latest), PS_Latest).

% %% 从ets删除在线玩家
% del_online_player_status_from_ets(PlayerId) ->
% 	?ASSERT(is_integer(PlayerId)),
% 	?ASSERT(get_online_player_status(PlayerId) /= null, PlayerId),
% 	?TRACE("del_online_player_status_from_ets(), PlayerId:~p~n", [PlayerId]),
% 	ets:delete(?MY_ETS_ONLINE(PlayerId), PlayerId).





% %% 获取缓存的临时退出的玩家结构体，目前的设计详见mod_login模块的开头说明
% %% @return: null | player_status结构体
% get_tmplogout_player_status(PlayerId) ->
% 	?ASSERT(is_integer(PlayerId), PlayerId),
% 	case ets:lookup(?ETS_TMPLOGOUT_PLAYER_STATUS, PlayerId) of
% 		[] ->
% 			null;
% 		[PlayerStatus] ->
% 			PlayerStatus
% 	end.


% %% 添加临时退出的玩家到ets
% add_tmplogout_player_status_to_ets(PS)
%   when is_record(PS, player_status) ->
%   	% ?ASSERT(get_tmplogout_player_status(player:id(PS)) == null, PS),
%   	case get_tmplogout_player_status(player:id(PS)) of
%   		null -> 
%   			?DEBUG_MSG("tmplogout player_status not exists add ~p",[player:id(PS)]);
%   		_ ->
%   			?DEBUG_MSG("tmplogout player_status already exists update ~p",[player:id(PS)])
%   	end,

%     ets:insert(?ETS_TMPLOGOUT_PLAYER_STATUS, PS).


% % add_tmplogout_player_status_to_ets(PS_Latest)
% %   when is_record(PS_Latest, player_status) ->
% % 	add_online_player_status_to_ets(PS_Latest).

% %% 从ets删除缓存的临时退出的玩家结构体
% del_tmplogout_player_status_from_ets(PlayerId) ->
% 	% del_online_player_status_from_ets(PlayerId).
% 	?ASSERT(is_integer(PlayerId), PlayerId),
% 	?ASSERT(get_tmplogout_player_status(PlayerId) /= null, PlayerId),
% 	ets:delete(?ETS_TMPLOGOUT_PLAYER_STATUS, PlayerId).


% %% 更新缓存的临时退出的玩家结构体到ets
% update_tmplogout_player_status_to_ets(PS_Latest)
%   when is_record(PS_Latest, player_status) ->
% 	%%% update_online_player_status_to_ets(PS_Latest).
% 	% ?ASSERT(get_tmplogout_player_status(player:id(PS_Latest)) /= null, PS_Latest),
% 	case get_tmplogout_player_status(player:id(PS_Latest)) of
%     	null -> ?ASSERT(false, PS_Latest), skip;
%     	_ -> ets:insert(?ETS_TMPLOGOUT_PLAYER_STATUS, PS_Latest)
%     end.

	

% % %% ets表之间转移玩家结构体（在线 -> 临时退出），目前的设计详见mod_login模块的开头说明
% % shift_player_status(from_online_to_tmplogout, PS_Latest) when is_record(PS_Latest, player_status) ->
% % 	old: 	
% % 	PlayerId = player:id(PS_Latest),
% % 	del_online_player_status_from_ets(PlayerId);
% % 	add_tmplogout_player_status_to_ets(PS_Latest);

% % 	% update_online_player_status_to_ets(PS_Latest);

% %% ets之间转移玩家结构体（临时退出 -> 在线）
% shift_player_status(from_tmplogout_to_online, PS_Latest) when is_record(PS_Latest, player_status) ->
	
% 	PlayerId = player:id(PS_Latest),
% 	del_tmplogout_player_status_from_ets(PlayerId),
% 	add_online_player_status_to_ets(PS_Latest).

% 	% update_online_player_status_to_ets(PS_Latest).

% ---------------------------------------------------------------------------------------------------
%% 获取在线玩家结构体
%% @return: null | player_status结构体
get_online_player_status(PlayerId) ->
	?ASSERT(is_integer(PlayerId), PlayerId),
	case ets:lookup(?MY_ETS_ONLINE(PlayerId), PlayerId) of
		[] ->  % 玩家不存在或者下线了
			null;
		[PlayerStatus] ->
			PlayerStatus
	end.

%% 添加在线玩家到ets
add_online_player_status_to_ets(PS)
  when is_record(PS, player_status) ->
  	?ASSERT(get_online_player_status(player:id(PS)) == null, PS),
    ets:insert(?MY_ETS_ONLINE(PS), PS).
    
%% 更新在线玩家到ets
update_online_player_status_to_ets(PS_Latest)
  when is_record(PS_Latest, player_status) ->
	?ASSERT(get_online_player_status(player:id(PS_Latest)) /= null, PS_Latest),
    ets:insert(?MY_ETS_ONLINE(PS_Latest), PS_Latest).

%% 从ets删除在线玩家
del_online_player_status_from_ets(PlayerId) ->
	?ASSERT(is_integer(PlayerId)),
	?ASSERT(get_online_player_status(PlayerId) /= null, PlayerId),
	?TRACE("del_online_player_status_from_ets(), PlayerId:~p~n", [PlayerId]),
	ets:delete(?MY_ETS_ONLINE(PlayerId), PlayerId).


%% 获取缓存的临时退出的玩家结构体，目前的设计详见mod_login模块的开头说明
%% @return: null | player_status结构体
get_tmplogout_player_status(PlayerId) ->
	?ASSERT(is_integer(PlayerId), PlayerId),
	case ets:lookup(?ETS_TMPLOGOUT_PLAYER_STATUS, PlayerId) of
		[] ->
			null;
		[PlayerStatus] ->
			PlayerStatus
	end.

%% 添加临时退出的玩家到ets
add_tmplogout_player_status_to_ets(PS)
  when is_record(PS, player_status) ->
  	?ASSERT(get_tmplogout_player_status(player:id(PS)) == null, PS),
    ets:insert(?ETS_TMPLOGOUT_PLAYER_STATUS, PS).


% add_tmplogout_player_status_to_ets(PS_Latest)
%   when is_record(PS_Latest, player_status) ->
% 	add_online_player_status_to_ets(PS_Latest).

%% 从ets删除缓存的临时退出的玩家结构体
del_tmplogout_player_status_from_ets(PlayerId) ->
	% del_online_player_status_from_ets(PlayerId).
	?ASSERT(is_integer(PlayerId), PlayerId),
	?ASSERT(get_tmplogout_player_status(PlayerId) /= null, PlayerId),
	ets:delete(?ETS_TMPLOGOUT_PLAYER_STATUS, PlayerId).


%% 更新缓存的临时退出的玩家结构体到ets
update_tmplogout_player_status_to_ets(PS_Latest)
  when is_record(PS_Latest, player_status) ->
	%%% update_online_player_status_to_ets(PS_Latest).
	% ?ASSERT(get_tmplogout_player_status(player:id(PS_Latest)) /= null, PS_Latest),
	case get_tmplogout_player_status(player:id(PS_Latest)) of
    	null -> ?ASSERT(false, PS_Latest), skip;
    	_ -> ets:insert(?ETS_TMPLOGOUT_PLAYER_STATUS, PS_Latest)
    end.

	

% %% ets表之间转移玩家结构体（在线 -> 临时退出），目前的设计详见mod_login模块的开头说明
% shift_player_status(from_online_to_tmplogout, PS_Latest) when is_record(PS_Latest, player_status) ->
% 	old: 	
% 	PlayerId = player:id(PS_Latest),
% 	del_online_player_status_from_ets(PlayerId);
% 	add_tmplogout_player_status_to_ets(PS_Latest);

% 	% update_online_player_status_to_ets(PS_Latest);

%% ets之间转移玩家结构体（临时退出 -> 在线）
shift_player_status(from_tmplogout_to_online, PS_Latest) when is_record(PS_Latest, player_status) ->
	
	PlayerId = player:id(PS_Latest),
	del_tmplogout_player_status_from_ets(PlayerId),
	add_online_player_status_to_ets(PS_Latest).


	

% 暂时没用，故注释掉！
% get_offline_player_status(PlayerId) ->
% 	?ASSERT(is_integer(PlayerId)),
% 	case ets:lookup(?ETS_OFFLINE, PlayerId) of
% 		[] -> null;
% 		[PlayerStatus] -> PlayerStatus
% 	end.


% %% 添加玩家到ets_offline
% add_offline_player_status_to_ets(PS)
% 	when is_record(PS, player_status) ->
%     ets:insert(?ETS_OFFLINE, PS).


% %% 从ets_offline删除玩家
% del_offline_player_status_from_ets(PlayerId) ->
% 	?ASSERT(is_integer(PlayerId)),
% 	ets:delete(?ETS_OFFLINE, PlayerId).


% update_offline_player_status(PS_Latest) ->
% 	?ASSERT(is_record(PS_Latest, player_status)),
% 	ets:insert(?ETS_OFFLINE, PS_Latest).






%% 依据玩家id获取在线玩家的简要信息
%% @return: null | player_brief结构体
get_online_player_brief(PlayerId) ->
	?ASSERT(is_integer(PlayerId), PlayerId),
	case ets:lookup(?ETS_ONLINE_PLAYER_BRIEF, PlayerId) of
		[] ->  % 玩家不存在或者下线了
			null;
		[PlayerBrf] ->
			PlayerBrf
	end.

%% 添加在线玩家的简要信息到ets
add_online_player_brief_to_ets(PlayerBrf)
  when is_record(PlayerBrf, plyr_brief) ->
  	% ?ASSERT(get_online_player_brief(PlayerBrf#plyr_brief.id) == null, PlayerBrf),
  	case get_online_player_brief(PlayerBrf#plyr_brief.id) of 
  		null ->
  			?DEBUG_MSG("the brief not exists add ~p",[PlayerBrf#plyr_brief.id]);
  		_ ->
  			?DEBUG_MSG("the brief already exists update~p",[PlayerBrf#plyr_brief.id])
  	end,

	ets:insert(?ETS_ONLINE_PLAYER_BRIEF, PlayerBrf).

%% 从ets删除在线玩家简要信息
del_online_player_brief_from_ets(PlayerId) ->
	?ASSERT(is_integer(PlayerId), PlayerId),
	?ASSERT(get_online_player_brief(PlayerId) /= null, PlayerId),
	ets:delete(?ETS_ONLINE_PLAYER_BRIEF, PlayerId).

%% 更新在线玩家的简要信息到ets
update_online_player_brief_to_ets(PlayerBrf)
  when is_record(PlayerBrf, plyr_brief) ->
  	ets:insert(?ETS_ONLINE_PLAYER_BRIEF, PlayerBrf).




%% 获取缓存的临时退出的玩家的简要信息
get_tmplogout_player_brief(PlayerId) ->
	?ASSERT(is_integer(PlayerId), PlayerId),
	case ets:lookup(?ETS_TMPLOGOUT_PLAYER_BRIEF, PlayerId) of
		[] ->
			null;
		[PlayerBrf] ->
			PlayerBrf
	end.

%% 添加临时退出的玩家的简要信息到ets
add_tmplogout_player_brief_to_ets(PlayerBrf)
  when is_record(PlayerBrf, plyr_brief) ->
  	% ?ASSERT(get_tmplogout_player_brief(PlayerBrf#plyr_brief.id) == null, PlayerBrf),

  	case get_tmplogout_player_brief(PlayerBrf#plyr_brief.id) of 
  		null ->
  			?DEBUG_MSG("brief not exists add ~p",[PlayerBrf#plyr_brief.id]);
  		_ ->
  			?DEBUG_MSG("brief already exists update ~p",[PlayerBrf#plyr_brief.id])
  	end,

	ets:insert(?ETS_TMPLOGOUT_PLAYER_BRIEF, PlayerBrf).

%% 从ets删除临时退出的玩家的简要信息
del_tmplogout_player_brief_from_ets(PlayerId) ->
	?ASSERT(is_integer(PlayerId), PlayerId),
	?ASSERT(get_tmplogout_player_brief(PlayerId) /= null, PlayerId),
	ets:delete(?ETS_TMPLOGOUT_PLAYER_BRIEF, PlayerId).


%% 更新临时退出的玩家的简要信息到ets
update_tmplogout_player_brief_to_ets(PlayerBrf) 
  when is_record(PlayerBrf, plyr_brief) ->
	case get_tmplogout_player_brief(PlayerBrf#plyr_brief.id) of
    	null -> ?ASSERT(false, PlayerBrf), skip;
    	_ -> ets:insert(?ETS_TMPLOGOUT_PLAYER_BRIEF, PlayerBrf)
    end.




%% ets之间转移玩家的简要信息（在线 -> 临时退出）
shift_player_brief(from_online_to_tmplogout, PlayerBrf) ->
	PlayerId = PlayerBrf#plyr_brief.id,
	del_online_player_brief_from_ets(PlayerId),
	add_tmplogout_player_brief_to_ets(PlayerBrf);

%% ets之间转移玩家的简要信息（临时退出 -> 在线）
shift_player_brief(from_tmplogout_to_online, PlayerBrf) ->
	PlayerId = PlayerBrf#plyr_brief.id,
	del_tmplogout_player_brief_from_ets(PlayerId),
	add_online_player_brief_to_ets(PlayerBrf).





%% 获取所有在线玩家的sendpid，返回对应的列表
get_all_online_player_sendpids() ->
	L = ets:tab2list(?ETS_ONLINE_PLAYER_BRIEF),
	[X#plyr_brief.sendpid || X <- L].


%% 获取所有在线玩家的进程pid，返回对应的列表
get_all_online_player_pids() ->
	L = ets:tab2list(?ETS_ONLINE_PLAYER_BRIEF),
	[X#plyr_brief.pid || X <- L].


%% 获取所有玩家（在线玩家 + 缓存的临时退出的玩家）的id，返回对应的列表
get_all_player_ids() ->
	L1 = ets:tab2list(?ETS_ONLINE_PLAYER_BRIEF),
	L2 = ets:tab2list(?ETS_TMPLOGOUT_PLAYER_BRIEF),
	[X#plyr_brief.id || X <- L1] ++ [X#plyr_brief.id || X <- L2].


%% 获取所有在线玩家的id，返回对应的列表
get_all_online_player_ids() ->
	L = ets:tab2list(?ETS_ONLINE_PLAYER_BRIEF),
	[X#plyr_brief.id || X <- L].


%% 获取所有在线玩家的{Id，Pid}列表
get_all_online_player_id_pid_list() ->
	L = ets:tab2list(?ETS_ONLINE_PLAYER_BRIEF),
	[{X#plyr_brief.id, X#plyr_brief.pid} || X <- L].


%% 清理残余的玩家进程
cleanup_residual_player_proc(PlayerId, PlayerPid) ->
	case erlang:is_process_alive(PlayerPid) of
		true ->
			?CRITICAL_MSG("[mod_svr_mgr] cleanup_residual_player_proc(), player proc(~p) not exit yet, so kill it!!!", [PlayerPid]),
			before_kill_player_proc(PlayerId, PlayerPid),
			erlang:exit(PlayerPid, kill);
		false ->
			% ?DEBUG_MSG("mod_svr_mgr, cleanup_residual_player_proc(), player proc(~p) already exit!", [PlayerPid]),
			skip
	end. 



%% ------------------------------- 人数统计 -----------------------------------

%% 获取在线人数
get_total_online_num() ->
	ets:info(?ETS_ONLINE_PLAYER_BRIEF, size).


% get_online_ip_num() ->
% 	IpList = ets:match(?ETS_ONLINE, #ets_online{last_login_ip = '$1', _ = '_'}),
% 	Set = sets:from_list(IpList),
% 	sets:size(Set).

% get_battle_num() ->
%     BattlePlayerL = ets:match(?ETS_ONLINE, #ets_online{id = '$1', cur_state = ?PS_BATTLING, _='_'}),
%     length(BattlePlayerL).

% get_scene_num(SceneId) ->
%     ScenePlayerL = ets:match(?ETS_ONLINE, #ets_online{id = '$1', scene = SceneId, _='_'}),
%     length(ScenePlayerL).

% get_scene_line_num(SceneId, LineId) ->
%     SceneLinePlayerL = lib_scene_line:get_scene_line_pos_data(LineId, SceneId),
%     length(SceneLinePlayerL).
%% ------------------------------------------------------------------------------





before_kill_player_proc(PlayerId, _PlayerPid) ->
	case player:get_PS(PlayerId) of
		null ->
			skip;
		PS ->
			del_map_of_accname_to_online_player(PS)
	end.

			
