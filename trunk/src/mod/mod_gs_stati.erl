%%%------------------------------------
%%% @Module  : mod_gs_stati
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2012.7.19
%%% @Description: 全服的一些数据统计
%%%				  模块名说明: gs => global server, stati => statistic
%%%------------------------------------


-module(mod_gs_stati).
% -behaviour(gen_server).
% -export([start_link/0]).
% -export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

% -export([
% 			gm_cmd_trigger_time_schedule/0,
% 			get_gs_stati_data/0,
% 			log_player_use_RMB/2
% 		]).


% -include("common.hrl").
% -include("gs_stati.hrl").
% %%-include("trea_house.hrl").
% -include("abbreviate.hrl").



% %% 进程字典的key名
% -define(KEY_NAME_GS_STATI, gs_statistic).





% %% 获取全服的一些统计数据
% %% @return: {fail} | {ok, gs_stati结构体}
% get_gs_stati_data() ->
% 	case catch gen_server:call(?MODULE, {'GET_GS_STATI_DATA'}) of
% 		{'EXIT', Reason} ->
% 			?ERROR_MSG("[GS_STATI]get_gs_stati_data() failed!! Reason: ~p", [Reason]),
% 			?ASSERT(false, Reason),
% 			{fail};
% 		GsStati ->
% 			?ASSERT(is_record(GsStati, gs_stati)),
% 			{ok, GsStati}
% 	end.
	

% %% 获取前一天全服活跃玩家的平均战天币剩余量
% %% @return: {fail} | {ok, 平均战天币剩余量}
% %%get_yesterday_avg_zt_money() ->
% %%	case catch gen_server:call(?MODULE, {'GET_YESTERDAY_AVG_ZT_MONEY'}) of
% %%		{'EXIT', Reason} ->
% %%			?ERROR_MSG("[GS_STATI]get_yesterday_avg_zt_money() failed!! Reason: ~p", [Reason]),
% %%			?ASSERT(false, Reason),
% %%			{fail};
% %%		AvgZtMoney ->
% %%			?ASSERT(is_integer(AvgZtMoney) andalso AvgZtMoney >= 0, AvgZtMoney),
% %%			{ok, AvgZtMoney}
% %%	end.
	


% %% 记录玩家消费元宝
% log_player_use_RMB(PlayerId, UseNum) ->
% 	gen_server:cast(?MODULE, {'LOG_PLAYER_USE_RMB', PlayerId, UseNum}). 
		


	
% %% 通过gm指令触发定时处理
% gm_cmd_trigger_time_schedule() ->
% 	?MODULE ! {'GM_CMD_TRIGGER_TIME_SCHEDULE'}.
		
	
% %% -------------------------------------------------------------------------
% start_link() ->
%     gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

% init([]) ->
%     process_flag(trap_exit, true),
%     do_init_jobs(),
%     {ok, null}.




% %% 获取全服统计的数据（返回gs_stati结构体）
% handle_call({'GET_GS_STATI_DATA'}, _From, State) ->
% 	GsStati = get(?KEY_NAME_GS_STATI),
% 	?ASSERT(is_record(GsStati, gs_stati), GsStati),
%     {reply, GsStati, State};




% %% 获取前一天全服活跃玩家的平均战天币剩余量
% %%handle_call({'GET_YESTERDAY_AVG_ZT_MONEY'}, _From, State) ->
% %%	GsStati = get(?KEY_NAME_GS_STATI),
% %%	?ASSERT(is_record(GsStati, gs_stati), GsStati),
% %%    {reply, GsStati#gs_stati.yesterday_avg_zt_money, State};

	
% handle_call(_Msg, _From, State) ->
% 	?ASSERT(false, _Msg),
%     {reply, null, State}.
    



% %% 记录玩家消费元宝    
% handle_cast({'LOG_PLAYER_USE_RMB', PlayerId, UseNum}, State) ->
% 	db_log_player_use_RMB(PlayerId, UseNum),
%     {noreply, State};
    




	
	
	
		
	    
    
% handle_cast(_Msg, State) ->
% 	?ASSERT(false, _Msg),
%     {noreply, State}.




	
% %% 通过gm指令触发定时处理	
% handle_info({'GM_CMD_TRIGGER_TIME_SCHEDULE'}, State) ->
% 	% 投递下一个整点的定时处理
% 	{_Hour, Minute, Second} = mod_mytime:time(),
% 	Intv = (60 - Minute) * 60 - Second, % 距离下一个整点的秒数
% 	?TRACE("GM_CMD_TRIGGER_TIME_SCHEDULE... intv: ~p~n", [Intv]),
% 	erlang:send_after(Intv*1000, self(), {'HANDLE_TIMER_PER_HOUR'}),
% 	{noreply, State};
		
	

% %% 每整点的定时处理： 1. 如果是到了隔天的0点，则做更新处理， 2.记录当前的在线人数到db
% handle_info({'HANDLE_TIMER_PER_HOUR'}, State) ->
% 	{Hour, Minute, Second} = mod_mytime:time(),
	
% 	?TRACE("[GS_STATI]HANDLE_TIMER_PER_HOUR, time now: ~p~n gs_stati: ~p~n", [{Hour, Minute, Second}, get(?KEY_NAME_GS_STATI)]),
% 	?DEBUG_MSG("[GS_STATI]HANDLE_TIMER_PER_HOUR, time now: ~p~n gs_stati: ~p", [{Hour, Minute, Second}, get(?KEY_NAME_GS_STATI)]),
	
% 	% 隔天0点时，做更新
% 	?IFC (Hour == 0)
% 		%%timer:sleep(500 + random:uniform(500)),  % sleep一下，以稍错开和其他系统在0点的更新处理（但注意不应sleep太久），有必要？？
% 		do_update_jobs_for_new_day()
% 	?END,
	
% 	% 记录当前在线人数到db
% 	CurOnlineNum = ets:info(?ETS_ONLINE, size),
% 	db:update(one_day_online_num, ["online_num"], [CurOnlineNum], "hour", Hour),
	
% 	% 继续投递下一个整点的定时处理
% 	Intv = (60 - Minute) * 60 - Second, % 距离下一个整点的秒数
% 	erlang:send_after(Intv*1000, self(), {'HANDLE_TIMER_PER_HOUR'}),
	
% 	{noreply, State};
	
	
	
	
	
	
	
	
% handle_info(_Msg, State) ->
%     {noreply, State}.

% terminate(_Reason, _State) ->
%     ok.

% code_change(_OldVsn, State, _Extra) ->
%     {ok, State}.



% %% ============================================== Local Functions ==============================================

	
	
	
	


% %% 记录消费元宝的玩家到db
% db_log_player_use_RMB(PlayerId, UseNum) ->
% 	Today = lib_common:today_date(),
	
% 	case db:select_row(log_use_rmb_player, "count(*)", [{date,Today}, {player_id, PlayerId}]) of
% 		[0] ->
% 			_SqlRet = db:insert(log_use_rmb_player, ["date", "player_id", "use_RMB_num"], [Today, PlayerId, UseNum]),
% 			?ASSERT(_SqlRet =:= 1);
% 		[1] ->
% 			Sql_Upd = io_lib:format(<<"UPDATE log_use_rmb_player SET use_RMB_num = use_RMB_num + ~p WHERE date=~p AND player_id=~p">>,
% 										[UseNum, Today, PlayerId]),
% 			_SqlRet = db:update(log_use_rmb_player, Sql_Upd),
% 			?ASSERT(_SqlRet =:= 1);
% 		_Any ->
% 			?ASSERT(false, _Any),
% 			skip
% 	end.
	


% %% 更新当天服务器的元宝消费总额到db
% %%db_update_total_use_RMB(NewTotalUseRMB) ->
% %%	Today = lib_common:today_date(),
% %%	%%Sql = io_lib:format(<<"UPDATE `gs_stati_for_zt_money` SET today_total_use_RMB=~p WHERE date=~p">>, [NewTotalUseRMB, Today]),
% %%	%%_SqlRet = db:update(gs_stati_for_zt_money, Sql),
% %%	_SqlRet = db:update(gs_stati_for_zt_money, ["total_use_RMB"], [NewTotalUseRMB], "date", Today),
% %%	?DEBUG_MSG("db_update_total_use_RMB(), _SqlRet: ~p~n", [_SqlRet]).
	
	
	

% %% 隔天0点则插入一条新记录到gs_stati_for_zt_money表，用于存储新一天的相关统计数据
% db_insert_new_record_to_gs_stati() ->
% 	Today = lib_common:today_date(),
% 	% 考虑到内部测试时有可能通过gm指令回退时间，为了避免这种情况下出错，故这里用replace，而不用insert
% 	db:replace(gs_stati_for_zt_money, [{date, Today}]).
	


% %% 隔天0点时，做更新处理
% do_update_jobs_for_new_day() ->
% 	% 1. 插入一条新记录到gs_stati_for_zt_money表，用于准备存储新一天的相关统计数据
% 	db_insert_new_record_to_gs_stati(),
	
% 	% 2. 统计前一天的平均在线人数，然后更新到进程字典和db
% 	case db:select_all(one_day_online_num, "hour, online_num", []) of
% 		[] ->
% 			?ERROR_MSG("[GS_STATI]db get one_day_online_num, no record!!", []),
% 			?ASSERT(false),
% 			skip;
% 		InfoList when is_list(InfoList) ->
% 			?DEBUG_MSG("db get one_day_online_num returns: ~p", [InfoList]),
% 			Yest_AvgOnlineNum = calc_avg_online_num(InfoList),
% 			% 更新到进程字典和db
% 			update_yesterday_avg_online_num(Yest_AvgOnlineNum),
			
% 			% 3. 清零原先采样记录的在线人数
% 			Sql = io_lib:format(<<"UPDATE `one_day_online_num` SET online_num=0 WHERE true">>, []),
% 			db:update(one_day_online_num, Sql);
% 		_ ->
% 			?ERROR_MSG("[GS_STATI]db get one_day_online_num error!!", []),
% 			?ASSERT(false),
% 			skip
% 	end,
	
% 	% 4. 统计前一天全服活跃玩家的平均战天币剩余量，然后更新到进程字典和db
% 	%    活跃玩家的定义：现在距离玩家上次退出游戏的时间 < 3天
% 	ThreeDaySec = 24 * 3600 * 3, % 3天的秒数
% 	TimeNow = mod_mytime:unixtime(),
	
	
% 	Sql2 = io_lib:format(<<"SELECT avg(zt_money) FROM `player` WHERE lv>~p AND (~p - logout_time)<~p">>, 
% 								[?START_TREA_HOUSE_NEED_LV, TimeNow, ThreeDaySec]),
% 	case db:select_row(player, Sql2) of
% 		[] ->
% 			?ERROR_MSG("[GS_STATI]db get avg zt money failed!!", []),
% 			?ASSERT(false),
% 			skip;
% 		[Yest_AvgZtMoney] ->
% 			% 注意：需要做矫正
% 			Yest_AvgZtMoney2 = 	case Yest_AvgZtMoney of
% 									undefined -> % 表明符合where子句条件的行数为0，因此avg(zt_money)的结果为NULL，对应到erlang的term，就是undefined
% 										?TRACE("it is undefined avg(zt_money)...~n"),
% 										0;
% 									_ ->
% 										?TRACE("Yest_AvgZtMoney avg(zt_money): ~p...~n", [Yest_AvgZtMoney]),
% 										?ASSERT(is_float(Yest_AvgZtMoney), Yest_AvgZtMoney),
% 										% 向上取整
% 										util:ceil(Yest_AvgZtMoney)
% 								end,
% 			% 更新到进程字典和db
% 			update_yesterday_avg_zt_money(Yest_AvgZtMoney2);
% 		_ ->
% 			?ERROR_MSG("[GS_STATI]db get avg zt money error!!", []),
% 			?ASSERT(false),
% 			skip
% 	end,
	
% 	Yesterday = lib_common:yesterday_date(),
	
% 	% 5. 统计前一天全服消费元宝的人数以及元宝消费总额，然后更新到进程字典和db
% 	case db:select_row(log_use_rmb_player, "count(*), sum(use_RMB_num)", [{date, Yesterday}]) of
% 		[PlayerNum, TotalUseRMB] ->
% 			TotalUseRMB2 = 	case TotalUseRMB of
% 								undefined -> % 表明log_use_rmb_player表为空表，数据行数为0，因此sum(use_RMB_num)的结果为NULL，对应到erlang的term，就是undefined
% 									?TRACE("it is undefined sum(use_RMB_num)...~n"),
% 									0;
% 								_ ->
% 									?TRACE("TotalUseRMB sum(use_RMB_num): ~p...~n", [TotalUseRMB]),
% 									?ASSERT(is_integer(TotalUseRMB), TotalUseRMB),
% 									TotalUseRMB
% 							end,
% 			% 更新到进程字典和db
% 			update_yesterday_use_RMB_info(PlayerNum, TotalUseRMB2);
% 		_ ->
% 			?ERROR_MSG("[GS_STATI]db get log_use_RMB_player error!!!!!!", []),
% 			?ASSERT(false),
% 			skip
% 	end,
	
% 	% 6. 标记统计数据为有效（更新到进程字典）
% 	CurGsStati = get(?KEY_NAME_GS_STATI),
% 	NewGsStati = CurGsStati#gs_stati{
% 						is_valid = true
% 						},
% 	put(?KEY_NAME_GS_STATI, NewGsStati),
	
% 	% 7. 标记数据库中前一天的统计数据为有效（更新到db）
% 	db:update(gs_stati_for_zt_money, ["is_valid"], [1], "date", Yesterday),
	
% 	% 8. 通知藏宝阁更新战天币的掉落概率
% 	mod_trea_house ! {'DO_UPDATE_JOBS_FOR_NEW_DAY'}.
	
	
	

% %% 计算平均在线人数
% %% para: InfoList => [[整点数，在线人数], ...]
% calc_avg_online_num(InfoList) ->
% 	% 过滤掉人数为0的记录
% 	InfoList2 = [[Hour, OnlineNum] || [Hour, OnlineNum] <- InfoList, OnlineNum /= 0],
	
% 	case InfoList2 == [] of
% 		true ->
% 			0;
% 		false ->
% 			F = fun([_Hour, OnlineNum], AccNum) ->
% 					AccNum + OnlineNum
% 				end,
% 			Total = lists:foldl(F, 0, InfoList2),
% 			util:ceil(Total / length(InfoList2))
% 	end.
			
	
	
	
	

% %% 从db加载全服的一些统计数据
% %% return: gs_stati结构体
% db_load_gs_stati() ->
% 	Yesterday = lib_common:yesterday_date(),
	
% 	% 从数据库load前一天的统计数据
% 	Sql = io_lib:format("SELECT is_valid, avg_online_num, avg_zt_money, use_RMB_player_num, total_use_RMB "
% 						" FROM `gs_stati_for_zt_money` WHERE date=~p", [Yesterday]),
	
% 	InitGsStati = 		
% 		case db:select_row(gs_stati_for_zt_money, Sql) of
% 			[] -> % 没有记录，表明上次停服超过1天
% 				?TRACE("[GS_STATI]do_init_jobs(), db get yesterday info, no record!! target date:~p~n", [Yesterday]),
% 				% 标记为无效！
% 				#gs_stati{is_valid = false};
% 			[IsValid, Yest_AvgOnlineNum, Yest_AvgZtMoney, Yest_UseRMBPlayerNum, Yest_TotalUseRMB] ->
% 				case IsValid == 1 of
% 					false -> % 表明上次0点没有做更新，或者更新失败了
% 						?TRACE("[GS_STATI] yesterday ~p is invalid!!!!~n", [Yesterday]),
% 						% 标记为无效！
% 						#gs_stati{is_valid = false};
% 					true ->
% 						?TRACE("[GS_STATI] yesterday ~p is valid..~n", [Yesterday]),
						
% 						% 对数值范围做断言的判定
% 						?ASSERT(Yest_AvgOnlineNum >= 0, Yesterday),
% 						% ...
						
% 						#gs_stati{
% 							is_valid = true,    % 标记为有效
% 							yesterday_avg_online_num = Yest_AvgOnlineNum,
% 							yesterday_avg_zt_money = Yest_AvgZtMoney,
% 							yesterday_use_RMB_player_num = Yest_UseRMBPlayerNum,   % 前一天服务器中消费元宝的人数
% 							yesterday_total_use_RMB = Yest_TotalUseRMB   % 前一天服务器的元宝消费总额
% 							}
% 				end;
% 			_ ->
% 				?ERROR_MSG("[GS_STATI]do_init_jobs(), db get yesterday info from gs_stati_for_zt_money error!! target date:~p", [Yesterday]),
% 				?ASSERT(false),
% 				% 标记为无效！
% 				#gs_stati{is_valid = false}
% 		end,
% 	InitGsStati.




% %% 模块启动时，做一些初始化工作
% do_init_jobs() ->
% 	timer:sleep(1000),  % debug版本下，因下面的处理会call世界节点的mod_mytime，故这里sleep一下，否则开服时会报no proc的错误
	
% 	Today = lib_common:today_date(),
	
% 	case db:select_row(gs_stati_for_zt_money, "count(*)", [{date, Today}]) of
% 		[0] -> % 说明上次凌晨0点没有做更新（停服维护等原因导致）
% 			?TRACE("do_init_jobs(), today gs_stati_for_zt_money count is 0, Today: ~p~n", [Today]),
% 			% 插入一条新记录到gs_stati_for_zt_money表，用于准备存储当天的相关统计数据
% 			db_insert_new_record_to_gs_stati();
% 		[1] -> % 已经有记录，跳过
% 			skip;
% 		_ ->
% 			?ASSERT(false),
% 			skip
% 	end,
	
% 	InitGsStati = db_load_gs_stati(),
% 	?ASSERT(is_record(InitGsStati, gs_stati), InitGsStati),
% 	% put到进程字典
% 	put(?KEY_NAME_GS_STATI, InitGsStati),
	
% 	% 如果是第一次开服，则初始化one_day_online_num表：固定插入24行记录（对应一天的24小时）
% 	case db:select_row(one_day_online_num, "count(*)", []) of
% 		[0] ->
% 			?TRACE("no record in one_day_online_num table, so init it...~n"),
% 			db_init_tbl_one_day_online_num();
% 		_Any ->
% 			?TRACE("select count(*) from one_day_online_num, ret: ~p~n", [_Any]),
% 			skip
% 	end,
	
% 	% 删掉数据库的log_use_rmb_player表的15天以前的记录（以免积压太多的记录）
% 	HalfMonthAgoDate = lib_common:half_month_ago_date(),
% 	?TRACE("[GS_STATI]half month ago date: ~p~n", [HalfMonthAgoDate]),
% 	db:delete(log_use_rmb_player, [{date, "<", HalfMonthAgoDate}]),
	
% 	% 投递下一个整点的定时处理
% 	{_Hour, Minute, Second} = mod_mytime:time(),
% 	Intv = (60 - Minute) * 60 - Second, % 距离下一个整点的秒数
% 	erlang:send_after(Intv*1000, self(), {'HANDLE_TIMER_PER_HOUR'}).
	
	

% %% 更新前一天的平均在线人数到进程字典和db
% update_yesterday_avg_online_num(AvgNum) ->
% 	?DEBUG_MSG("update_yesterday_avg_online_num(), new avg num: ~p", [AvgNum]),
	
% 	% 更新到进程字典
% 	CurGsStati = get(?KEY_NAME_GS_STATI),
% 	NewGsStati = CurGsStati#gs_stati{yesterday_avg_online_num = AvgNum},
% 	put(?KEY_NAME_GS_STATI, NewGsStati),
% 	% 更新到db
% 	%%Sql = io_lib:format(<<"UPDATE `gs_stati_for_zt_money` SET yesterday_avg_online_num=~p WHERE date=~p">>, [AvgNum, Today]),
% 	%%db:update(gs_stati_for_zt_money, Sql).
% 	Yesterday = lib_common:yesterday_date(),
% 	db:update(gs_stati_for_zt_money,
% 				["avg_online_num"],
% 				[AvgNum],
% 				"date",
% 				Yesterday).
	
	
	
% %% 更新前一天的全服活跃玩家的平均战天币剩余量到进程字典和db
% update_yesterday_avg_zt_money(AvgNum) ->
% 	?ASSERT(is_integer(AvgNum), AvgNum),
	
% 	?TRACE("update_yesterday_avg_zt_money(),  avg num: ~p~n", [AvgNum]),
% 	?DEBUG_MSG("update_yesterday_avg_zt_money(),  avg num: ~p", [AvgNum]),
	
% 	% 更新到进程字典
% 	CurGsStati = get(?KEY_NAME_GS_STATI),
% 	NewGsStati = CurGsStati#gs_stati{yesterday_avg_zt_money = AvgNum},
% 	put(?KEY_NAME_GS_STATI, NewGsStati),
% 	% 更新到db
% 	%%Sql = io_lib:format(<<"UPDATE `gs_stati_for_zt_money` SET yesterday_avg_zt_money=~p WHERE date=~p">>, [AvgNum, Today]),
% 	%%db:update(gs_stati_for_zt_money, Sql).
% 	Yesterday = lib_common:yesterday_date(),
% 	db:update(gs_stati_for_zt_money,
% 				["avg_zt_money"],
% 				[AvgNum],
% 				"date",
% 				Yesterday).
	
	
% %% 更新前一天全服消费元宝的人数以及元宝消费总额到进程字典和db
% update_yesterday_use_RMB_info(PlayerNum, TotalUseRMB) ->
% 	?DEBUG_MSG("update_yesterday_use_RMB_info(), new num: ~p, TotalUseRMB: ~p", [PlayerNum, TotalUseRMB]),
	
% 	% 更新到进程字典
% 	CurGsStati = get(?KEY_NAME_GS_STATI),
% 	NewGsStati = CurGsStati#gs_stati{
% 					yesterday_use_RMB_player_num = PlayerNum,
% 					yesterday_total_use_RMB = TotalUseRMB
% 					},
% 	put(?KEY_NAME_GS_STATI, NewGsStati),
% 	% 更新到db
% 	%%Sql = io_lib:format(<<"UPDATE `gs_stati_for_zt_money` SET yesterday_use_RMB_player_num=~p WHERE date=~p">>, [PlayerNum, Today]),
% 	%%db:update(gs_stati_for_zt_money, Sql).
% 	Yesterday = lib_common:yesterday_date(),
% 	db:update(gs_stati_for_zt_money,
% 				["use_RMB_player_num", "total_use_RMB"],
% 				[PlayerNum, TotalUseRMB],
% 				"date",
% 				Yesterday).
	
	

% %% 更新前一天、重置今天的服务器中消费元宝的总额到进程字典（今天的变为昨天的，然后今天的重置为0）	
% %%update_yest_and_today_total_use_RMB() ->
% %%	%%Today = lib_common:today_date(),
% %%	
% %%	CurGsStati = get(?KEY_NAME_GS_STATI),
% %%	New_YestTotalUseRMB = CurGsStati#gs_stati.today_total_use_RMB,
% %%	
% %%	?DEBUG_MSG("update_yest_and_today_total_use_RMB(), New_YestTotalUseRMB: ~p", [New_YestTotalUseRMB]),
% %%	NewGsStati = CurGsStati#gs_stati{
% %%						yesterday_total_use_RMB = New_YestTotalUseRMB,
% %%						today_total_use_RMB = 0
% %%						},
% %%	% 更新到进程字典
% %%	put(?KEY_NAME_GS_STATI, NewGsStati),
% %%	
% %%	% 因消费元宝的总额是即时存到db的，故这里不需做更新db的处理
% %%	not_need_update_db.
	
% 	% 更新到db
% 	%%Sql_UpdTotalUseRMB = io_lib:format(<<"UPDATE `gs_stati_for_zt_money` SET yesterday_total_use_RMB=~p, "
% 	%%									"today_total_use_RMB=0 WHERE date=~p">>, [New_YestTotalUseRMB, Today]),
% 	%%db:update(gs_stati_for_zt_money, Sql_UpdTotalUseRMB).
	
% 	%%db:update(gs_stati_for_zt_money,
% 	%%			["total_use_RMB", "today_total_use_RMB"],
% 	%%			[New_YestTotalUseRMB, 0],
% 	%%			"date",
% 	%%			Today).
	
	
% %% 初始化one_day_online_num表：固定插入24行记录（对应一天的24小时）
% db_init_tbl_one_day_online_num() ->
% 	% 整点数列表
% 	L = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23],
% 	F = fun(Hour) ->
% 			_SqlRet = db:insert(one_day_online_num, ["hour", "online_num"], [Hour, 0]),
% 			?ASSERT(_SqlRet == 1)
% 		end,
% 	lists:foreach(F, L).