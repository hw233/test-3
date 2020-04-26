%%%------------------------------------
%%% @Module  : mod_mon_active
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2011.05.12
%%% @Description: 怪物活动状态
%%%------------------------------------
-module(mod_mon_active).
% -behaviour(gen_fsm).
% -export([
%         start/1,
% 		add_battle_mon/2, 
        
% 		enter_battle/2,
% 		world_boss_enter_battle/2,
% 		set_global_name/2,
% 		set_level_mon/2,
%         sleep/2, 
%         trace/2,
% 		battle/2,
% 		battling/2,
%         revive/2,
%         back/2,
%         ready_start_team_boss_battle/2
%     ]).
% -export([init/1, handle_event/3, handle_sync_event/4, handle_info/3, terminate/3, code_change/4]).

% %% -export([
% %% 		 start_trace/1,
% %% 		 start_one/1
% %% 		 ]).
% -include("common.hrl").
% -include("record.hrl").
% -include("battle.hrl").
% -include("monster.hrl").

% %%-define(RETIME, 5000). %回血时间
% -define(MOVE_TIME, 5000). %自动移动时间

% %% To-Do: state里不应保存玩家数据，要重构一下


% %%开启一个怪物活动进程
% %%每个怪物一个进程
% start(M)->
%     gen_fsm:start_link(?MODULE, M, []).



% %% 设置怪物或普通boss进入战斗
% enter_battle(MonObj, Atter) ->
% 	ets:insert(?ETS_MON, MonObj#ets_mon{is_battling = true}), % 更新为在战斗中
% 	Pid = MonObj#ets_mon.aid,
% 	Pid ! {'ENTER_BATTLE', Atter}.

% %% 设置世界boss进入战斗（注意：因多个玩家可以同时和世界boss打，所以不设置世界boss的is_battling标记为true）
% world_boss_enter_battle(Pid, Atter) ->
% 	Pid ! {'WORLD_BOSS_ENTER_BATTLE', Atter}.

% %% 设置怪物对应的世界BOSS全局名
% set_global_name(Minfo, Name) ->
% 	Pid = Minfo#ets_mon.aid,
% 	Pid ! {'SET_GLOBAL_NAME', Name}.

% %% 设置怪物对应的世界BOSS 自适应怪的id
% set_level_mon(Minfo, Id) ->
% 	Pid = Minfo#ets_mon.aid,
% 	Pid ! {'SET_LEVEL_MON', Id}.
	
% %% 修改战斗怪进程字典中的计数
% add_battle_mon(Pid, Num) ->
% 	Pid ! {'MON_ADD',Num}.

	
			
	


% %% start_one(Scene) ->
% %% 	case lib_scene:get_scene_mon_left(Scene) of
% %% 		none ->
% %% 			skip;
% %% 		Minfo ->
% %% 			start_trace(Minfo)
% %% 	end.
% %% 
% %% start_trace(Minfo) ->
% %% 	Minfo#ets_mon.aid ! {'START_TRACE'}.


% 	%% para: [State#state.auto_id, MonId, Scene, X, Y, Type,PassFinish]

% init([Id , MonId, Scene, X, Y, Type,PassFinish])->
% 	init([Id , MonId, Scene, X, Y, Type,PassFinish,?MAX_PRE_DIFINE_LINE_COUNT]);
% init([Id , MonId, Scene, X, Y, Type,PassFinish,Line])->
% 	case data_mon:get(MonId) of
% 		[] ->
% 			{stop, normal, 0};
% 		M ->
% 			% 打开战斗进程
% 			{ok, Bid} = mod_battle:start_link(),
% 			M1 = M#ets_mon{
% 						   id = Id,
% 						   scene = Scene,
% 						   x = X,
% 						   y = Y,
% 						   d_x = X,       % 默认出生X
% 						   d_y = Y,       % 默认出生Y
% 						   type = Type,   % 怪物类型（0被动，1主动,2 boss）
% 						   aid = self(),  % 怪物活动进程
% 						   bid = Bid,     % 战斗进程
% 						   pass_finish = PassFinish,
% 						   line_id = Line
% 						  },
% 			%% 通知场景中已经存在的玩家这个怪物的创建
% 			{ok, BinData} = pt_12:write(12007, M1),   % 改为调用 mod_scene:add_char_to_scene()， 或者名字为add_char_obj(?CHAR_MON, ...)
% 			lib_send:send_to_scene(M1#ets_mon.scene, M1#ets_mon.line_id, BinData),  % 改为：按需只发给附近玩家
% 			ets:insert(?ETS_MON, M1),
% 			case ets:lookup(?ETS_SCENE, Scene) of
% 				[] ->
% 					skip; %% 如果是load_mon操作则走这条路线
% 				[SInfo] ->
% 					ets:insert(?ETS_SCENE, SInfo#ets_scene{mon = [Id|SInfo#ets_scene.mon]})
% 			end,
% 			reset_alive_bmon_num(M1),
% 			{ok, sleep, [[], M1], 1000}
% 	end.

% handle_event(_Event, StateName, Status) ->
%     {next_state, StateName, Status}.

% handle_sync_event(_Event, _From, StateName, Status) ->
%     Reply = ok,
%     {reply, Reply, StateName, Status}.

% handle_info('FORCE_KILL',  _StateName, [Att, Minfo]) ->
% 	%% 	mon_dead(Att, Minfo),
% 	gen_server:cast(Att#player_status.pid, {'MON_KILLED',Minfo}),
% 	ets:delete(?ETS_MON, Minfo#ets_mon.id),	
% 	case ets:lookup(?ETS_SCENE, Minfo#ets_mon.scene) of
% 		[] ->
% 			skip;
% 		[SInfo] ->
% 			ets:insert(?ETS_SCENE, SInfo#ets_scene{mon = lists:delete(Minfo#ets_mon.id,SInfo#ets_scene.mon)})
% 	end,
% 	mod_dungeon:kill_npc(Att, [Minfo#ets_mon.mid]),
% 	{ok, BinData} = pt_12:write(12101, Minfo#ets_mon.id),
% 	lib_send:send_to_scene(Minfo#ets_mon.scene,Minfo#ets_mon.line_id,BinData),
% 	%% 	start_one(Minfo#ets_mon.scene),
% 	{stop, normal, [Att, Minfo]};


% %% @para: InitialHp => 刚进战斗时的血量， RemainHp => 当前剩余的血量
% handle_info({'BATTLE', [PlayerId, _MonId, InitialHp, RemainHp, _Anger, HpRatio, TurnNum, ComboNum]},  StateName, [Att0, Minfo]) ->
% 	?DEBUG_MSG("mon recv battle finish, monid:~p, playerid:~p", [_MonId, PlayerId]),
% 	%% to-do 正式的确认伤害来源
% 	if Minfo#ets_mon.type == ?BMON_WORLD_BOSS ->
% 		   %% 		   [Att|T] = Att0, 
% 		   case lib_player:get_user_info_by_id(PlayerId) of
% 			   Att when is_record(Att,player_status) ->
% 				   gen_server:cast({global, Minfo#ets_mon.global_name}, {'mon_world_hurt', InitialHp - RemainHp, Att});
% 			   _ ->
% 				   F = fun(Af) ->
% 							   Af#player_status.id == PlayerId
% 					   end,
% 				   case [A||A<-Att0, F(A)] of
% 					   [Att|_] ->
% 						   gen_server:cast({global, Minfo#ets_mon.global_name}, {'mon_world_hurt', InitialHp - RemainHp, Att});
% 					   _ ->
% 						   Att = Att0
% 				   end
% 		   end;
% 	   Minfo#ets_mon.type == ?BMON_WORLD_MON ->
% 		   case RemainHp == 0 andalso get(alive_bmon_num) -1 =< 0 of
% 			   true ->
% 				   case Minfo#ets_mon.event of
% 					   [_Mid, Hp] ->
% 						   gen_server:cast({global, Minfo#ets_mon.global_name}, {'mon_world_hurt', Hp, Att0});
% 					   _ ->
% 						   skip
% 				   end;
% 			   false ->
% 				   ?TRACE("mod_mon_active ###~p~n",[?LINE]),
% 				   skip
% 		   end,
% 		   Att = Att0;
% 	   true ->
% 		   Att = Att0
% 	end,
% 	case RemainHp == 0 of
% 		true -> % 战斗怪死了
% 			Alive_bmon_num = get(alive_bmon_num),
% 			?TRACE("#########Alive_bmon_num:~p#######~n", [Alive_bmon_num]),
% 			Alive_bmon_num2 = Alive_bmon_num - 1,
% 			if	Alive_bmon_num2 == 0 -> % 战斗怪全死了
% 					case is_record(Att,player_status) of
% 						true ->
% 							mod_dungeon:kill_npc(Att, [Minfo#ets_mon.mid]),               % 副本杀怪
% 							SoulPower = Minfo#ets_mon.soul_power,
% 							mod_dungeon:battle_over(Att, HpRatio, TurnNum, ComboNum, SoulPower),               % 副本杀怪
% 							case lib_player:is_in_team(Att) of
% 								false ->
% 									%% 							mon_dead(Att, Minfo);
% 									gen_server:cast(Att#player_status.pid, {'MON_KILLED',Minfo#ets_mon{soul_power = SoulPower}});
% 								true ->
% 									SID = lib_scene:get_res_id(Minfo#ets_mon.scene),
% 									case  lib_scene:is_guild_dungeon(SID) of %小灵界中会进行任务、掉落的判定
% 										true ->
% 											case length(ets:match_object(?ETS_MON, #ets_mon{  scene = Minfo#ets_mon.scene,  _='_' })) == 1 of
% 												true->
% 													gen_server:cast({global, ?GLOBAL_GUILD_WAR_PROCESS}, {apply_cast, lib_guild_war, war_to_star, [Att#player_status.guild_id,SID]});
% 												false ->
% 													skip
% 											end;
% 										false ->
% 											skip
% 									end,
% 									case mod_team_new:get_team_info(Att#player_status.pid_team) of
% 										TeamInfo when is_record(TeamInfo, team) ->
% 											MemberL = mod_team_new:get_team_member_list(TeamInfo),
% 											PSList = [lib_player:get_user_info_by_id(Mb#mb.id) || Mb <- MemberL],
% 											[gen_server:cast(PSone#player_status.pid, {'MON_KILLED',Minfo#ets_mon{soul_power = SoulPower}}) || PSone<-PSList];
% 										_ ->
% 											?ERROR_MSG("mod_mon_active TeamPid error:~w", [PlayerId, Att#player_status.pid_team])
% 									end
% 							end;
% 						false ->
% 							skip
% 					end,
% 					% 通知客户端删除这个怪
% 					?TRACE("notify client destroy one monster from scene^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^~n"),
% 					{ok, BinData} = pt_12:write(12101, Minfo#ets_mon.id),
% 					lib_send:send_to_scene(Minfo#ets_mon.scene,Minfo#ets_mon.line_id,BinData),
					
% 					if Minfo#ets_mon.revive == 1 ->
% 						   {next_state, revive, [[],Minfo], 1000};
% 					   true ->
% 						   ets:delete(?ETS_MON, Minfo#ets_mon.id),	
% 						   case ets:lookup(?ETS_SCENE, Minfo#ets_mon.scene) of
% 							   [] ->
% 								   skip;
% 							   [SInfo] ->
% 								   ets:insert(?ETS_SCENE, SInfo#ets_scene{mon = lists:delete(Minfo#ets_mon.id,SInfo#ets_scene.mon)})
% 						   end,
% 						   %% 						   start_one(Minfo#ets_mon.scene),
% 						   {stop, normal, [Att, Minfo]}
% 					end;
% 				true ->
% 					put(alive_bmon_num, Alive_bmon_num2),
% 					{next_state, StateName, [Att, Minfo]}
% 			end;
% 		false -> % 战斗怪未死
% 			if
% 				Minfo#ets_mon.scene == 0 -> 	% 创建专门用来做一场战斗的怪物在取胜之后进行回收
% 					ets:delete(?ETS_MON, Minfo#ets_mon.id),	
% 					{stop, normal, [Att, Minfo]};
% 				Minfo#ets_mon.type == ?BMON_WORLD_BOSS ->
% 					{next_state, StateName, [[], Minfo], 16000};
% 				StateName == battling ->
% 					mon_win(Att, Minfo),
% 					reset_alive_bmon_num(Minfo),
					
% 					?DEBUG_MSG("mon win ,  reset attr ing ....", []),
% 					NewMonInfo = Minfo#ets_mon{
% 									is_battling = false,  % 更新为不在战斗中
% 									% 稳妥起见，这里重置下面两个字段
% 									is_readying_battle = false,
% 									enemy_player_list = []
% 									}, 
% 					ets:insert(?ETS_MON, NewMonInfo),
% 					{next_state, back, [[], NewMonInfo], 16000}; % 这里timeout设置为16秒，是想让怪物不要那么快开始巡逻
% 				true ->
% 					{next_state, StateName, [Att, Minfo], 16000} % 这里timeout设置为16秒，是想让怪物不要那么快开始巡逻
% 			end
% 	end;

% %% 清除进程
% handle_info(clear, _StateName, [Att, MonInfo]) ->
% 	?TRACE("CLEAR MON: ~p...~n", [MonInfo#ets_mon.id]),
%     ets:delete(?ETS_MON, MonInfo#ets_mon.id),
% 	{ok, BinData} = pt_12:write(12101, MonInfo#ets_mon.id),
% 	lib_send:send_to_scene(MonInfo#ets_mon.scene,MonInfo#ets_mon.line_id,BinData),
% %% 	start_one(MonInfo#ets_mon.scene),
%     {stop, normal, [Att, MonInfo]};

% %%怪进入战斗
% handle_info({'ENTER_BATTLE', Atter}, _StateName, [_Att, Minfo]) ->
%     {next_state, battling, [Atter, Minfo]};

% %% 修改进程字典中战斗怪数量
% handle_info({'MON_ADD',Num}, StateName, [Att, Minfo]) ->
% 	CurrentNum = get(alive_bmon_num),
% 	put(alive_bmon_num, CurrentNum + Num),
%     {next_state, StateName, [Att, Minfo]};
    
% %% 世界BOSS进入战斗
% handle_info({'WORLD_BOSS_ENTER_BATTLE', Atter}, _StateName, [Att, Minfo]) ->
%     {next_state, battling, [[Atter|Att], Minfo]};

% %% 记录下怪物对应的世界BOSS进程名
% handle_info({'SET_GLOBAL_NAME', Name}, StateName, [Att, Minfo]) ->
%     {next_state, StateName, [Att, Minfo#ets_mon{global_name = Name}]};

% %% 记录下怪物对应的自适应怪id
% handle_info({'SET_LEVEL_MON', Id}, StateName, [Att, Minfo]) ->
%     {next_state, StateName, [Att, Minfo#ets_mon{level_mon = Id}]};
    
    
    
    

	
   



	

% %%怪进入巡逻
% %% handle_info({'START_TRACE'}, StateName, [Att, Minfo]) ->
% %%  	?TRACE("trace start!!!!!!!!!!!!!!!!!!~p~n~p~n",[Minfo,StateName]),
% %% 	Minfo1 = Minfo#ets_mon{start_trace = 1},
% %% 	ets:insert(?ETS_MON, Minfo1),
% %%     {next_state, StateName, [Att, Minfo1], 100};

% handle_info(_Info, StateName, Status) ->
%     {next_state, StateName, Status}.

% terminate(_Reason, _StateName, _Status) ->
% %    gen_server:cast(Minfo#ets_mon.pid, {'RESET', Minfo#ets_mon.id}),
% 	%%?TRACE("mon active proc end........~n"),
%     ok.

% code_change(_OldVsn, StateName, Status, _Extra) ->
%     {ok, StateName, Status}.

% %% =========处理怪物所有状态=========

% %%复活
% revive(timeout, [[], Minfo]) ->
% 	 Status1 = Minfo#ets_mon{
% 							 x = Minfo#ets_mon.d_x,
% 							 y = Minfo#ets_mon.d_y
% 							},
% 	 reset_alive_bmon_num(Minfo),

% 	%%通知客户端我已经重生了
% 	{ok, Bin_data} = pt_12:write(12007, Status1),
% 	lib_send:send_to_scene(Status1#ets_mon.scene, Status1#ets_mon.line_id, Bin_data),

% 	ets:insert(?ETS_MON, Status1),
% 	{next_state, sleep, [[], Status1], 100};

% revive(_R, [[], Minfo]) ->
%     {next_state, revive, [[], Minfo], 100}.

% %%静止状态并回血
% sleep(timeout, [[], Minfo]) ->
% %% 	if Minfo#ets_mon.scene > 100000 ->
% %% 	?TRACE("trace !!!!!!!!!!!!!!!!!!~p~n",[[Minfo#ets_mon.start_trace,Minfo#ets_mon.d_x]]);
% %% 	   true ->
% %% 		   skip
% %% 	end,
% %% 	if Minfo#ets_mon.start_trace == 1 ->
% 	% 服务端怪物取消掉主动攻击，改为由客户端来主动攻击
% 		   case Minfo#ets_mon.type of
% 			   1 -> % 主动怪
% 				   auto_move(Minfo, ?MOVE_TIME, 2);
% %% 				   case get_user_for_battle(Minfo#ets_mon.scene, Minfo#ets_mon.line_id, Minfo#ets_mon.x, Minfo#ets_mon.y, 3) of
% %% 					   none ->
% %% 						   auto_move(Minfo, ?MOVE_TIME, 2);
% %% 					   Pid ->
% %% 						   {next_state, trace, [Pid, Minfo], 100}
% %% 				   end;
% 			   2 -> % Boss
% 				   auto_move(Minfo, ?MOVE_TIME, 2);
% %% 				   case get_user_for_battle(Minfo#ets_mon.scene, Minfo#ets_mon.line_id,  Minfo#ets_mon.x, Minfo#ets_mon.y, 3) of
% %% 					   none ->
% %% 						   {next_state, sleep, [[], Minfo], 3000};
% %% 					   Pid ->
% %% 						   {next_state, trace, [Pid, Minfo], 100}
% %% 				   end;
% 			   0 -> % 不动怪
% 				   {next_state, sleep, [[], Minfo], 3000};
% 			   3 -> % 世界BOSS
% 				   {next_state, sleep, [[], Minfo], 30000};
% 			   5 -> % 第1个副本的机关怪
% 				   ?ASSERT(Minfo#ets_mon.mid == 9001), % To-Do：目前只允许第1个副本的牢笼旁边的怪是机关怪，后面会确定正式的机关怪实现方式（可能会放到客户端来实现）
% 				   auto_move(Minfo, ?MOVE_TIME, 2);
% %% 				   case get_user_for_battle(Minfo#ets_mon.scene, Minfo#ets_mon.line_id, Minfo#ets_mon.x, Minfo#ets_mon.y, 5) of
% %% 					   none ->
% %% 						   auto_move(Minfo, 1000, 2);
% %% 					   Pid ->
% %% 						   {next_state, trace, [Pid, Minfo], 100}
% %% 				   end;
% 			   _ -> % 被动怪
% 				   auto_move(Minfo, ?MOVE_TIME, 2)
% 		   end;
% %% 	   true ->
% %% 		   {next_state, sleep, [[], Minfo], 3000}
% %% 	end;

% sleep(repeat, Status) ->
%     sleep(timeout, Status);

% sleep(_R, Status) ->
%     sleep(timeout, Status).

% %%跟踪目标
% trace(timeout, [Pid, Minfo]) when is_pid(Pid) ->
%     case catch gen:call(Pid, '$gen_call', 'PLAYER') of
%         {'EXIT', _} ->
%             {next_state, sleep, [[], Minfo], 1000};
%         {ok, Player} ->
%             X = Player#player_status.x,
%             Y = Player#player_status.y,
%             Hp = Player#player_status.hp,
%             case Hp > 0 of
%                 true ->
%                     case can_attack(Minfo, X, Y) of
%                         attack -> % 可以进行攻击了
% 							{next_state, battle, [Player, Minfo], 100};
% 							% {next_state, back, [[], Minfo], 2000}; % To-Do：暂时改为back，即怪不主动打人
%                         trace -> % 还不能进行攻击就追踪他
%                             case trace_line(Minfo#ets_mon.x, Minfo#ets_mon.y, X, Y, Minfo#ets_mon.att_area) of
%                                 {X1, Y1} ->
%                                     move(X1, Y1, [Pid, Minfo]);
%                                 true ->
%                                     {next_state, back, [[], Minfo], 2000}
%                             end;
%                         back -> %停止追踪
%                             {next_state, back, [[], Minfo], 1000}
%                     end;
%                 false ->
%                     {next_state, back, [[], Minfo], 1000}
%             end
%     end;

% trace(repeat, Status) ->
%     trace(timeout, Status);

% trace(_R, Status) ->
%     trace(timeout, Status).

% %%发动战斗
% battle(timeout, [Player, Minfo]) ->
% 	  case Player of
% 		  [] ->
% 			    {next_state, back, [[], Minfo], 5000};
% 		  Player -> 
% 			  		case lib_player:is_in_battle(Player) of
% 						false ->
% 			  					% 设置参战双方的当前状态为战斗状态
% 			  					enter_battle(Minfo, Player),
% 								case lib_player:is_in_team(Player) of
% 									true ->
% 										%%PlayerList = gen_server:call(Player#player_status.pid_team, {'ENTER_BATTLE', Minfo#ets_mon.bid, true}),
% 										%%mod_battle:battle_team_pve(Minfo#ets_mon.bid, [PlayerList, Minfo]);
										
% 										TeamPid = Player#player_status.pid_team,
% 										case mod_team_new:get_team_info(TeamPid) of
% 											null ->
% 												?ASSERT(false),
% 												{next_state, back, [[], Minfo], 3000};
% 											TeamInfo ->
% 												mod_player:enter_battle(Player#player_status.pid, Minfo#ets_mon.bid),
% 												mod_battle:team_mf(Minfo#ets_mon.bid, [Player, Minfo], TeamInfo),
% 												{next_state, battling, [Player, Minfo]}
% 										end;
% 									false ->
% 									  	mod_player:enter_battle(Player#player_status.pid, Minfo#ets_mon.bid),
% 										mod_battle:single_mf(Minfo#ets_mon.bid, [Player, Minfo], ?BAT_SUB_T_NORMAL_MF),
% 										{next_state, battling, [Player, Minfo]}
% 								end;
% 						true -> % 在战斗中
% 							{next_state, back, [[], Minfo], 3000}
% 					end
%       end.
% %%战斗中
% battling(timeout, [Att, Minfo]) ->
% 	?TRACE("mon timeout...~n"),
%     {next_state, battling, [Att, Minfo]};
% battling(repeat, Status) ->
%     {next_state, battling, Status}.
    


    
    
    

% %%返回默认出生点
% back(timeout, [[], Minfo]) ->
% %% 	?TRACE("***** back timeout~n"),
%     Status1 = Minfo#ets_mon{
%             x = Minfo#ets_mon.d_x,
%             y = Minfo#ets_mon.d_y
%         },
%     lib_scene:mon_move(Status1#ets_mon.d_x, Status1#ets_mon.d_y, Status1#ets_mon.id, Status1#ets_mon.scene, Status1#ets_mon.line_id),
%     ets:insert(?ETS_MON, Status1),
%     {next_state, sleep, [[], Status1], 1000};
% %    case trace_line(Minfo#ets_mon.x, Minfo#ets_mon.y, Minfo#ets_mon.d_x, Minfo#ets_mon.d_y) of
% %        {X1, Y1} ->
% %            Status1 = Minfo#ets_mon{
% %                    x = X1,
% %                    y = Y1
% %                },
% %            lib_scene:mon_move(X1, Y1, Status1#ets_mon.id, Status1#ets_mon.scene, Status1#ets_mon.line_id),
% %            ets:insert(?ETS_MON, Status1),
% %            {next_state, back, [[], Status1], 500};
% %        true ->
% %            {next_state, sleep, [[], Minfo], 1000}
% %    end;

% back(_R, Status) ->
%     sleep(timeout, Status).

% %% 判断距离是否可以发动攻击了
% can_attack(Status, X, Y) ->
%     D_x = abs(Status#ets_mon.x - X),
%     D_y = abs(Status#ets_mon.y - Y),
%     Att_area = Status#ets_mon.att_area,
%     case Att_area>= D_x of
%                 true ->
%                     case Att_area>= D_y of
%                         true ->
%                             attack;
%                         false ->
%                             trace_area(Status, X, Y)
%                     end;
%                 false ->
%                     trace_area(Status, X, Y)
%     end.


% %% 追踪区域
% trace_area(Status, X,_Y) ->
%     Trace_area = Status#ets_mon.trace_area,
%     D_x = abs(Status#ets_mon.d_x - X),
%     %不在攻击范围内了停止追踪
%     case  Trace_area >= D_x of
%         true ->
%             trace; % 只考虑x坐标
%         false ->
%             back
%     end.

% %%先进入曼哈顿距离遇到障碍物再转向A*
% %%每次移动2格
% trace_line(X1, Y1, X2, Y2, AttArea) ->
%     MoveArea = 2,
%    %先判断方向
%    if 
%        %目标在正下方
%        X2 == X1 andalso Y2 - Y1 > 0 ->
%             Y = Y2 - Y1,
%             if 
%                 Y < MoveArea ->
%                     {X1, Y2-AttArea};
%                 true ->
%                     {X1, Y1+MoveArea}
%             end;

%       %目标在正上方
%        X2 == X1 andalso Y2 - Y1 < 0 ->
%             Y = abs(Y2 - Y1),
%             if 
%                 Y < MoveArea ->
%                     {X1, Y2+AttArea};
%                 true ->
%                     {X1, Y1-MoveArea}
%             end;

%        %目标在正左方
%        X2 - X1 < 0 andalso Y2 == Y1 ->
%             X = abs(X2 - X1),
%             if 
%                 X < MoveArea ->
%                     {X2+AttArea, Y1};
%                 true ->
%                     {X1-MoveArea, Y1}
%             end; 

%        %目标在正右方
%        X2 - X1 > 0 andalso Y2 == Y1 ->
%             X = X2 - X1,
%             if 
%                 X < MoveArea ->
%                     {X2-AttArea, Y1};
%                 true ->
%                     {X1+MoveArea, Y1}
%             end; 

%        %目标在左上方
%        X2 - X1 < 0 andalso Y2 - Y1 < 0 ->
%             Y = abs(Y2 - Y1),
%             X = abs(X2 - X1),
%             if 
%                 Y < MoveArea ->
%                     if 
%                         X < MoveArea -> {X2+AttArea, Y2+AttArea};
%                         true -> {X1-MoveArea, Y2+AttArea}
%                     end;
%                 true ->
%                     if
%                         X < MoveArea -> {X2+AttArea, Y1-MoveArea};
%                         true -> {X1-MoveArea, Y1-MoveArea}
%                     end
%             end;

%        %目标在左下方
%        X2 - X1 < 0 andalso Y2 - Y1 > 0 ->
%             Y = Y2 - Y1,
%             X = abs(X2 - X1),
%             if 
%                 Y < MoveArea ->
%                     if
%                         X < MoveArea -> {X2+AttArea, Y2-AttArea};
%                         true -> {X1-MoveArea, Y2-AttArea}
%                     end;
%                 true ->
%                     if
%                         X < MoveArea -> {X2+AttArea, Y1+MoveArea};
%                         true -> {X1-MoveArea, Y1+MoveArea}
%                     end
%             end;

%        %目标在右上方
%        X2 - X1 > 0 andalso Y2 - Y1 < 0 ->
%             Y = abs(Y2 - Y1),
%             X = X2 - X1,
%             if 
%                 Y < MoveArea ->
%                     if
%                         X < MoveArea -> {X2-AttArea, Y2+AttArea};
%                         true -> {X1+MoveArea, Y2+AttArea}
%                     end;
%                 true ->
%                     if
%                         X < MoveArea -> {X2-AttArea, Y1-MoveArea};
%                         true -> {X1+MoveArea, Y1-MoveArea}
%                     end
%             end;

%        %目标在右下方
%        X2 - X1 > 0 andalso Y2 - Y1 > 0 ->
%             Y = Y2 - Y1,
%             X = X2 - X1,
%             if 
%                 Y < MoveArea ->
%                     if
%                         X < MoveArea -> {X2-AttArea, Y2-AttArea};
%                         true -> {X1+MoveArea, Y2-AttArea}
%                     end;
%                 true ->
%                     if
%                         X < MoveArea -> {X2-AttArea, Y1+MoveArea};
%                         true -> {X1+MoveArea, Y1+MoveArea}
%                     end
%             end;

%        true ->
%             true
%     end.

% %%怪物移动 
% move(X, Y, [Pid, Minfo]) ->
%     %判断是否障碍物
%     case lib_scene:is_blocked(Minfo#ets_mon.scene, [X, Y]) of
%         true -> %无障碍物
%             Status1 = Minfo#ets_mon{
%                     x = X,
%                     y = Y
%                 },
%             lib_scene:mon_move(X, Y, Status1#ets_mon.id, Status1#ets_mon.scene, Status1#ets_mon.line_id),
%             ets:insert(?ETS_MON, Status1),
%             %继续追踪
%             Time = round(40 * 2000 / Status1#ets_mon.speed) ,
%             gen_fsm:send_event_after(Time, repeat),
%             {next_state, trace, [Pid, Status1]};
%         false -> %有障碍物
%             {next_state, back, [[], Minfo], 1000}
%     end.

% %%随机移动
% auto_move(Minfo, MoveTime, MoveRadius) ->
% %%     Rand = random:uniform(4),
% 	Rand = util:rand(1,4),
%     if
%         Rand == 1 ->       % 向右
%             X = Minfo#ets_mon.x + MoveRadius,
%             Y = Minfo#ets_mon.y;
%         Rand == 2 ->       % 向下
%             X = Minfo#ets_mon.x,
%             Y = Minfo#ets_mon.y+MoveRadius;
%         Rand == 3 ->       % 向左
%             X = abs(Minfo#ets_mon.x - MoveRadius),
%             Y = Minfo#ets_mon.y;
%         Rand == 4 ->       % 向上
%             X = Minfo#ets_mon.x,
%             Y = abs(Minfo#ets_mon.y - MoveRadius)
%     end,
%     %判断是否障碍物
%     case lib_scene:is_blocked(Minfo#ets_mon.scene, [X, Y]) of
%         true ->
%             Status1 = Minfo#ets_mon{
%                     x = X,
%                     y = Y
%                 },
%             lib_scene:mon_move(X, Y, Status1#ets_mon.id, Status1#ets_mon.scene, Status1#ets_mon.line_id),
%             ets:insert(?ETS_MON, Status1),
			
% 			if 
% 				erlang:abs(X - Minfo#ets_mon.d_x) > Minfo#ets_mon.trace_area ->
% 					{next_state, back, [[], Minfo], MoveTime};
% 			    true ->
%             		{next_state, sleep, [[], Minfo], MoveTime}
% 			end;
%         false -> %有障碍物
%             {next_state, sleep, [[], Minfo], MoveTime}
%     end.

% %%获取范围内的玩家（获取离怪物最近并且是未死亡的玩家）
% get_user_for_battle(Q, Line, X, Y, Area) ->
% 	X1 = X + Area,
% 	X2 = X - Area,
% 	Y1 = Y + Area,
% 	Y2 = Y - Area,
% 	%%     AllUser = ets:match(?ETS_ONLINE, #ets_online{pid = '$1', x='$2', y='$3', hp='$4', scene = Q, _='_'}),
% 	AllUser = lib_scene_line:get_scene_line_pos_data(Line, Q),
% 	F = fun(Idf, Xf, Yf) ->
% 				case ets:lookup(?ETS_ONLINE, Idf) of
% 					[] ->
% 						[];
% 					[Userf] ->
% 						[Userf#ets_online.pid, Xf, Yf, Userf#ets_online.hp]
% 				end
% 		end,
% 	AllUser1 = [F(Id, X0, Y0) || [Id, X0, Y0] <- AllUser, X0 >= X2 andalso X0 =< X1, Y0 >= Y2 andalso Y0 =< Y1],
% 	get_user_for_battlle_near(AllUser1, [X, Y], 1000000, none).

% %% 获取一个最近的玩家
% get_user_for_battlle_near([], _, _, N) ->
%     N;
% get_user_for_battlle_near([[Pid, X0, Y0, Hp]| T], [X, Y], L, N) ->
%     L0 = abs(X0 - X) + abs(Y0 - Y),
%     [L1, N1] = if
%         L0 < L andalso Hp > 0 -> % 只有活的玩家才怪物才会trace过去
%             [L0, Pid];
%         true ->
%             [L, N]
%     end,
%     get_user_for_battlle_near(T, [X, Y], L1, N1).


% %% 怪物战胜了玩家
% mon_win(_Att, _Minfo) -> skip.
% %% 	SID = lib_scene:get_res_id(Minfo#ets_mon.scene).
% 	%小灵界中不会进行任何任务、掉落的判定

% %% 计算怪物产出的战魂力
% %% compute_soul_power(Minfo, _Combo) ->
% %% 	PassId = mod_dungeon:get_passid_by_dungeonid(lib_scene:get_res_id(Minfo#ets_mon.scene)),
% %% 	Bmon_group = data_bmon_group:get(Minfo#ets_mon.bmon_group),
% %% 	case Bmon_group#rd_bmon_group.battle_mon_list of
% %% 			[]-> 0;
% %% 			BattleMonList -> 
% %% 				util:ceil(length(BattleMonList) * Minfo#ets_mon.lv * (PassId rem 10)  + 2)
% %% 	end.

				
% %% 重置战斗怪数目alive_bmon_num
% reset_alive_bmon_num(Minfo) ->
% 	Bmon_group = data_bmon_group:get(Minfo#ets_mon.bmon_group),
% 	Battle_mon_list = Bmon_group#rd_bmon_group.battle_mon_list,
% 	put(alive_bmon_num, length(Battle_mon_list)).
	
	
	

