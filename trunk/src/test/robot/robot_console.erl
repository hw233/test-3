%%% -------------------------------------------------------------------
%%% Author  : Administrator
%%% Description :
%%%
%%% Created : 2011-11-29
%%%
%%% 打怪调用过程: 大林树 -> 副本 风语森林 然后退出副本
%%%     robot_console:start().
%%%     robot_console:create_robots(N).
%%%     robot_console:enter_dungeon(1).
%%%     robot_console:leave_dungeon(1).
%%% 
%%% -------------------------------------------------------------------
-module(robot_console).

-behaviour(gen_server).
%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------

%% --------------------------------------------------------------------
%% External exports
-export([
		 start/0,				%% 启动机器人控制台进程
		 create_robots/3, 		%% 指定机器人个数,创建机器人
		 create_robots2/4,		%% 创建机器人（指定组Id，每组机器人个数,如每组为500个机器人）
		 % prop_lv/1,
		 % prop_skill/1,
		 % prop_partner/1,
		 % prop_troop/1,
		 walk/1,
		 sleep/1,
		 stop_robot/1,			%% 关闭指定组id的机器人
	     logout_login/1,		%% 先退出指定组id的机器人,等全部下线完毕后,重新登录,然后下线,重复登录与退出
		 % speak/1,
		 % scene_102/1,
		 change_scene/2			%% 切换场景
		 % enter_dungeon/1,
		 % leave_dungeon/1,
		 % battle_mon/1
		 ]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-include("debug.hrl").

-record(console, {
				  auto_id = 1,
				  group_id = 1,
				  group = [] %每个元组为: group_id 通过group_id的进程字典来存放当前组的机器人pid列表
				 }).

-define(RATIO, 2). 									%% 系数，通常为机器人个数的五十分之一较为合理，通过压力测试发现
-define(TIME_BEFORE_RELOGIN, 6*1000*?RATIO).	 	%% 从首个机器人退出到首个机器人再登录的时间间隔
-define(TIME_BEFORE_RELOGOUT, 12*1000*?RATIO).		%% 从首个机器人重新登录到首个机器人再退出的时间间隔

%% ====================================================================
%% External functions
%% ====================================================================
start() ->
	gen_server:start_link({local,?MODULE}, ?MODULE, [], []).

%% 指定机器人个数,创建机器人
create_robots(Host, Port, Num) ->
	?MODULE ! {create,Host, Port, Num}.

%% 创建机器人（指定组Id，每组机器人个数,默认每组为500个机器人）
create_robots2(Host, Port, GroupId, GroupRobotNum) ->
	?MODULE ! {create2, Host, Port, GroupId, GroupRobotNum}.

%% 设置lv
% prop_lv(GroupId) ->
% 	?MODULE ! {change_state, GroupId, prop_lv}.

% %% 设置技能
% prop_skill(GroupId) ->
% 	?MODULE ! {change_state, GroupId, prop_skill}.

% %% 设置武将
% prop_partner(GroupId) ->
% 	?MODULE ! {change_state, GroupId, prop_partner}.

% %% 设置阵法
% prop_troop(GroupId) ->
% 	?MODULE ! {change_state, GroupId, prop_troop}.

%% 行走
walk(GroupId) ->
	?MODULE ! {change_state, GroupId, walk}.
	%%timer:sleep(4000),
	%%walk(GroupId).

%% 休息
sleep(GroupId) ->
	?MODULE ! {change_state, GroupId, sleep}.

%% 关闭指定组id的机器人
stop_robot(GroupId) ->
	?MODULE ! {stop_robot, GroupId}.

%% 先退出指定组id的机器人,等全部下线完毕后,重新登录,然后下线,重复登录与退出
logout_login(GroupId) ->
	GroupRobotNum = 
	case catch gen:call(?MODULE, '$gen_call', {'get_robot_num', GroupId}) of
		{ok, Res} ->
			Res;
		_Any ->
			?TRACE("get_robot_num error!~p~n", [_Any])
	end,

	?MODULE ! {stop_robot, GroupId},

	spawn(fun() -> relogin_out(?MODULE, GroupId, GroupRobotNum) end).


%% 说话
% speak(GroupId) ->
% 	?MODULE ! {change_state, GroupId, speak}.

% %%转到102场景（若已在则不转）,转102场景需要10级以上，可能会不成功。
% scene_102(GroupId) ->
%    ?MODULE ! {change_state, GroupId, scene_102}.

%% 切换场景
%% 参数: IsLoop: true|false（是否一直来回切换）
change_scene(GroupId, IsLoop) ->
	case IsLoop of
		true ->
			?MODULE ! {change_state, GroupId, scene_loop};
		false ->
			?MODULE ! {change_state, GroupId, scene}
	end.

%% 进入副本
% enter_dungeon(GroupId) ->
% 	?MODULE ! {change_state, GroupId, enter_dungeon}.

% %% 离开副本
% leave_dungeon(GroupId) ->
% 	?MODULE ! {change_state, GroupId, leave_dungeon}.

% %% 打怪
% battle_mon(GroupId) ->
% 	?MODULE ! {change_state, GroupId, battle_mon}.

%% ====================================================================
%% Server functions
%% ====================================================================

%% --------------------------------------------------------------------
%% Function: init/1
%% Description: Initiates the server
%% Returns: {ok, State}          |
%%          {ok, State, Timeout} |
%%          ignore               |
%%          {stop, Reason}
%% --------------------------------------------------------------------
init([]) ->
	process_flag(trap_exit, true),
    {ok, #console{}}.

%% --------------------------------------------------------------------
%% Function: handle_call/3
%% Description: Handling call messages
%% Returns: {reply, Reply, State}          |
%%          {reply, Reply, State, Timeout} |
%%          {noreply, State}               |
%%          {noreply, State, Timeout}      |
%%          {stop, Reason, Reply, State}   | (terminate/2 is called)
%%          {stop, Reason, State}            (terminate/2 is called)
%% --------------------------------------------------------------------

handle_call({'get_robot_num', GroupId}, _From, State) ->
	GroupRobotNum = 
	case get(GroupId) of
		undefined ->
			0;
		RobotPidL ->
			length(RobotPidL)
	end,
	{reply, GroupRobotNum, State};

handle_call(_Request, _From, State) ->
    Reply = ok,
    {reply, Reply, State}.

%% --------------------------------------------------------------------
%% Function: handle_cast/2
%% Description: Handling cast messages
%% Returns: {noreply, State}          |
%%          {noreply, State, Timeout} |
%%          {stop, Reason, State}            (terminate/2 is called)
%% --------------------------------------------------------------------
handle_cast(_Msg, State) ->
    {noreply, State}.

%% --------------------------------------------------------------------
%% Function: handle_info/2
%% Description: Handling all non call/cast messages
%% Returns: {noreply, State}          |
%%          {noreply, State, Timeout} |
%%          {stop, Reason, State}            (terminate/2 is called)
%% --------------------------------------------------------------------
handle_info({create, Host, Port, Num}, State) ->
    {RobotList, _} = robot_create:start(Host, Port, Num, State#console.auto_id),
	put(State#console.group_id, RobotList),
	?TRACE("[Group Id: ~p, robot num: ~p]~n", [State#console.group_id, length(RobotList)]),
	NewState = State#console{
							 auto_id = State#console.auto_id + Num,
							 group_id = State#console.group_id + 1,
							 group = [State#console.group_id | State#console.group]
							 },
    {noreply, NewState};

handle_info({create2, Host, Port, GroupId, GroupRobotNum}, State) ->
	AutoId = (GroupId - 1) * GroupRobotNum + 1,
    {RobotList, _} = robot_create:start(Host, Port, GroupRobotNum, AutoId),
	put(GroupId, RobotList),
	?TRACE("[Group Id: ~p, robot num: ~p]~n", [GroupId, length(RobotList)]),
	NewState = State#console{
							 auto_id = AutoId,
							 group_id = GroupId,
							 group = [State#console.group_id | State#console.group]
							 },
    {noreply, NewState};

handle_info({change_state, Gid, Next}, State) ->%没有检查要改变到的状态是否合法
	case State#console.group of
		[]->
			 [];
		_GL ->
			case get(Gid) of
				undefined ->
					 [];
				RobotPidL ->
					[send(change_state, Pid, Next) || Pid <- RobotPidL]
			end
	end,
	{noreply,  State };

handle_info({stop_robot, Gid}, State) ->
	case State#console.group of
		[]->
			 [];
		_GL ->
			case get(Gid) of
				undefined ->
					 [];
				RobotPidL ->
					?TRACE("stop_robot [Group Id: ~p, robot num: ~p]~n", [Gid, length(RobotPidL)]),
					[send(stop_robot, Pid) || Pid <- RobotPidL]
			end
	end,
	{noreply,  State};

handle_info(_Info, State) ->
    {noreply, State}.

%% --------------------------------------------------------------------
%% Function: terminate/2
%% Description: Shutdown the server
%% Returns: any (ignored by gen_server)
%% --------------------------------------------------------------------
terminate(_Reason, _State) ->
    ok.

%% --------------------------------------------------------------------
%% Func: code_change/3
%% Purpose: Convert process state when code is changed
%% Returns: {ok, NewState}
%% --------------------------------------------------------------------
code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%% --------------------------------------------------------------------
%%% Internal functions
%% --------------------------------------------------------------------

send(change_state, Pid, Next) ->
	if
		Next == scene_loop ->
			robot:sleep(1000); % 间隔1000ms
		true ->
			robot:sleep(650) % 间隔650ms		
	end,
	
	Pid ! {change_state, Next}.

send(stop_robot, Pid) ->
	robot:sleep(500), % 间隔500ms
	Pid ! stop.

%% 先登录然后退出,重复登录与退出
relogin_out(Pid, GroupId, GroupRobotNum) ->
	erlang:send_after(?TIME_BEFORE_RELOGIN, Pid, {create2, GroupId, GroupRobotNum}),
	erlang:send_after(?TIME_BEFORE_RELOGIN + ?TIME_BEFORE_RELOGOUT, Pid, {stop_robot, GroupId}),
	timer:sleep(60000),
	relogin_out(Pid, GroupId, GroupRobotNum).