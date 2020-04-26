%% -------------------------------------------------------------------
%%% Author  : Administrator
%%% Description :
%%%
%%% Created : 2011-11-23
%%% Modify: zhangwq 2013.08.26
%%% Attention: 进入副本功能需要屏蔽的网络消息：15091（刷新客户端buff），13011（更新玩家的属性信息），12094（刷新玩家体力值）
%%%            打怪功能要屏幕的网络消息：12008（怪物移动），因为12008协议会发得太频繁，会挡住其他消息的接收
%%%            进副本要屏蔽副本进入条件的检查
%%% -------------------------------------------------------------------
-module(robot).

-behaviour(gen_fsm).
%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------

%% --------------------------------------------------------------------
%% External exports
-export([start/1, % 机器人登录服务器随机移动
         sleep/1,
         sleep/2,
         % prop_lv/2,
         % prop_skill/2,
         % prop_partner/2,
         % prop_troop/2,
         walk/2,                %% 状态函数:  行走
         % walk_to_dest/2,
         % speak/2,
         % scene_102/2,
         scene/2,               %% 状态函数：切换场景
         scene_loop/2           %% 状态函数：不断切换场景
         % enter_dungeon/2,
         % leave_dungeon/2,
         % battle_mon/2
        ]).

%% gen_fsm callbacks
-export([init/1,  state_name/3, handle_event/3,
     handle_sync_event/4, handle_info/3, terminate/3, code_change/4]).

-include("common.hrl").
-include("record.hrl").
-include("scene.hrl").
-include("pt_10.hrl").
-include("pt_12.hrl").
-include("debug.hrl").
-include("player.hrl").

-define(ROBOT_LOGIN_MODE, normal).     % 登录模式：normal|guest （普通|游客）
-define(HEADER_LENGTH, 2).             %
-define(HEART_TIMEOUT, 60*1000).       % 心跳包超时时间
-define(HEART_TIMEOUT_TIME, 0).        % 心跳包超时次数
-define(TCP_TIMEOUT, 1000).            % 解析协议超时时间
-define(SERVER_HOST, "192.168.23.176"). % 服务器地址 ztj0_ser.me4399.com

-define(BORN_X, 18).
-define(BORN_Y, 15).
%% 服务器地址和端口
-define(HOST, "localhost").
-define(PORT, 8765).
%% PDKN: process dict key name(进程字典的key名)
-define(PDKN_CONN_SOCKET, pdkn_conn_socket).

-define(SWITCH_TO_SCENE_NO, 1102).     %% 场景切换时跳转到的场景编号

-define(TCP_OPTS, [
        binary,
        {packet, 0},       % no packaging
        {reuseaddr, true}, % allow rebind without waiting
        {nodelay, false},
        {active, false},
        {delay_send, true}
    ]).

-define(TCP_OPTS2, [
        binary,
        {packet, 2},       % 2 byte packaging
        {reuseaddr, true}, % allow rebind without waiting
        {nodelay, false},
        {active, false},
        {delay_send, true}
    ]).


-record(state, {
				index = 0,			        %%机器人编号
                id = 0,                     %%玩家Id
                next = sleep,               %%FSM下一个状态
                scene = ?BORN_SCENE_NO,     %%
                dungeon = 11021,            %%风语森林
                is_in_dungeon = false,      
                dir = 0,        
                x = ?BORN_X,                %%x坐标
                y = ?BORN_Y,                %%y坐标
                dest,                       %%目标的位置
                socket,                     %%socket
                eleml,                      %%场景切换点
                userl,                      %%玩家id列表
                monl,                       %%怪物id列表
                npcl,                       %%npc的id列表
                bo_id = 0,                  %%主角战斗对象Id
                skilll                      %%技能列表（格式：{SkillId, SkillLv, Grid}）
                }).

%% ====================================================================
%% External functions
%% ====================================================================
%%开启一个robot活动进程
%%每个robot一个进程
% start([Accid, Accname])->
%     gen_fsm:start_link(?MODULE, [Accid, Accname], []).

start([Host, Port, AccName, PlayerId])->
    gen_fsm:start_link(?MODULE, [Host, Port, AccName, PlayerId], []).

init([Host, Port, AccName, PlayerId]) ->
    process_flag(trap_exit, true),

    ?TRACE("##### RobotId:~p, AccName: ~p #####~n", [PlayerId, AccName]),
    {ok, Socket} = test_client_base:connect_server(Host, Port),
    sleep(100),
    test_client_base:login(AccName),
    sleep(100),
    test_client_base:get_role_list(),
    sleep(100),

    Race = rand(1, 3),
    Sex = rand(1, 2),
    RoleName = lists:concat([robot_, PlayerId]),
    test_client_base:create_role(Race, Sex, RoleName),
    sleep(100),
    test_client_base:enter_game(PlayerId),
    sleep(100),

    {ok, sleep, #state{
                   index = PlayerId,
                   id = PlayerId,
                   socket = Socket
                  }, 1000}.


%% (进入游戏后)玩家随机移动，起点为坐标{X, Y}
rand_move(State) ->
    timer:sleep(2000),
    Dir = rand(0, 7),
    {X1, Y1} = next_xy(Dir, State#state.x, State#state.y),

    %io:format("Player:~p send: move_to (~p,~p)~n", [State#state.id, X1, Y1]),

    Data = <<X1:16, Y1:16>>,
    gen_tcp:send(State#state.socket, test_client_base:pack(?PT_PLAYER_MOVE, Data)),
    {X1, Y1}.

%% --------------------------------------------------------------------
%% Func: StateName/2
%% Returns: {next_state, NextStateName, NextStateData}          |
%%          {next_state, NextStateName, NextStateData, Timeout} |
%%          {stop, Reason, NewStateData}
%% --------------------------------------------------------------------
%%状态函数: sleep状态，每次唤醒切换到State#state.next状态.
sleep(timeout, State) ->
    %io:format("back  to sleep ~n"),
    {next_state, State#state.next, State, 500}.


%%状态函数: 进入场景函数
scene(timeout, State) ->
    change_scene(State, scene).

%%状态函数: 不断场景切换
scene_loop(timeout, State) ->
    change_scene(State, scene_loop).

%%状态函数: 进入副本, 进入后返回sleep状态
% enter_dungeon(timeout, State) ->
%     if
%         State#state.is_in_dungeon == false andalso State#state.scene == 101 ->  
%             change_dungeon(State, State#state.dungeon, true);
%         true ->
%             {next_state, sleep, State#state{next = sleep}, 5000}
%     end.

% %%状态函数: 离开副本, 返回sleep状态
% leave_dungeon(timeout, State) ->
%     if
%         State#state.is_in_dungeon == true ->
%             io:format("--- leave dungeon ---~n"),
%             gen_tcp:send(State#state.socket, <<12092:16, 0:8>>),    %是否属于通关后退出副本的情况（1：是，0：否）
%             rec(State#state.socket, State),
%             {ElemL, UserL, MonL, NpcL, _LevelL} = load_scene(State),
%             {next_state, sleep, State#state{next = sleep, is_in_dungeon = false, eleml = ElemL, userl = UserL, monl = MonL, npcl = NpcL}, 5000};
%         true ->
%             {next_state, sleep, State#state{next = sleep, is_in_dungeon = false}, 5000}
%     end.

%%状态函数:  属性
% prop_lv(timeout, State) ->
%     gm_cmd(State#state.socket, "@lv 20"),
%     %rec(State#state.socket, State),
%     msg_loop(State, 11009),
%     {next_state, sleep, State#state{next = sleep}, 100}.

% %%状态函数:  设置技能
% prop_skill(timeout, State) ->
%     gm_cmd(State#state.socket, "@skill 11001 1"),
%     %rec(State#state.socket, State),
%     msg_loop(State, 11009),
%     {next_state, sleep, State#state{next = sleep}, 100}.

% %%状态函数: 设置武将
% prop_partner(timeout, State) ->
%     gm_cmd(State#state.socket, "@partner 1013 1"),
%     %rec(State#state.socket, State),
%     msg_loop(State, 11009),
%     {next_state, sleep, State#state{next = sleep}, 100}.

% %%状态函数: 阵法
% prop_troop(timeout, State) ->
%     % 获取携带的武将
%     Id = State#state.id,
%     io:format("prop_troop_id: ~p~n", [Id]),
%     gen_tcp:send(State#state.socket, <<17051:16, Id:32>>),
%     %partner_troop(State),
%     msg_loop(State, 17051),
%     {next_state, sleep, State#state{next = sleep}, 100}.

%%状态函数:  行走
walk(timeout, State) ->
    %NewState = walk_xy(State),
    {X, Y} = rand_move(State),
    NewState = State#state{x = X, y = Y},
    {next_state, sleep, NewState, 10000}. % {next_state,NextStateName,NewStateData,Timeout} Timeout为下一个状态设置超时时间

%%状态函数: 聊天
% speak(timeout, State) ->
%     speak(State),
% %%       io:format("start to speak ~n"),
%     {next_state, sleep, State,10000}.

% %%状态函数: 行走
% walk_to_dest(timeout, State) ->
%     NewState = walk_dest(State),
%     {next_state, sleep, NewState, 100}.

% %%状态函数: 打怪 
% battle_mon(timeout, State) ->
%     NewState = battle_mon(State),
%     {next_state, sleep, NewState, 6000}.

%% --------------------------------------------------------------------
%% Func: StateName/3
%% Returns: {next_state, NextStateName, NextStateData}            |
%%          {next_state, NextStateName, NextStateData, Timeout}   |
%%          {reply, Reply, NextStateName, NextStateData}          |
%%          {reply, Reply, NextStateName, NextStateData, Timeout} |
%%          {stop, Reason, NewStateData}                          |
%%          {stop, Reason, Reply, NewStateData}
%% --------------------------------------------------------------------
state_name(_Event, _From, StateData) ->
    Reply = ok,
    {reply, Reply, state_name, StateData}.

%% --------------------------------------------------------------------
%% Func: handle_event/3
%% Returns: {next_state, NextStateName, NextStateData}          |
%%          {next_state, NextStateName, NextStateData, Timeout} |
%%          {stop, Reason, NewStateData}
%% --------------------------------------------------------------------
handle_event(_Event, StateName, StateData) ->
    {next_state, StateName, StateData}.

%% --------------------------------------------------------------------
%% Func: handle_sync_event/4
%% Returns: {next_state, NextStateName, NextStateData}            |
%%          {next_state, NextStateName, NextStateData, Timeout}   |
%%          {reply, Reply, NextStateName, NextStateData}          |
%%          {reply, Reply, NextStateName, NextStateData, Timeout} |
%%          {stop, Reason, NewStateData}                          |
%%          {stop, Reason, Reply, NewStateData}
%% --------------------------------------------------------------------
handle_sync_event(_Event, _From, StateName, StateData) ->
    Reply = ok,
    {reply, Reply, StateName, StateData}.

%% --------------------------------------------------------------------
%% Func: handle_info/3
%% Returns: {next_state, NextStateName, NextStateData}          |
%%          {next_state, NextStateName, NextStateData, Timeout} |
%%          {stop, Reason, NewStateData}
%% --------------------------------------------------------------------
handle_info({walk_to_dest,X,Y}, _StateName, State) ->
    {next_state, walk_to_dest, State#state{next = walk_to_dest, dest = {X,Y}}, 100};


%% 机器人控制台发送改变状态消息给机器人
handle_info({change_state, Next}, StateName, State) ->
    ?TRACE("Robot:~p begin change_state:~p ~p ~p---~n", [State#state.id, Next, StateName, State#state.index]),
    {next_state, StateName, State#state{next = Next}, 100};


handle_info(stop, _StateName, State) ->
    ?TRACE("Robot:~p stop ~n", [State#state.index]),
	{stop, normal, State};

handle_info(move, _StateName, State) ->
    {move, normal, State};


%% 机器人登录游戏成功，收到消息
handle_info({enter_game_success, _PlayerId, NewSceneId, NewX, NewY}, StateName, State) ->
    ?TRACE("Robot:~p enter_game_success:~p ~p ~p ok ~n", [State#state.id, NewSceneId, NewX, NewY]),
    {next_state, StateName, State#state{scene = NewSceneId, x = NewX, y = NewY}, 10000};


%% 切换场景成功,继续设置为切换场景状态
handle_info({change_scene_ok, NewSceneId, NewX, NewY}, StateName, State) ->
    ?TRACE("Robot:~p change_scene:~p ~p ~p ok ~n", [State#state.id, NewSceneId, NewX, NewY]),
    {next_state, StateName, State#state{scene = NewSceneId, x = NewX, y = NewY, next = scene_loop}, 10000};

handle_info(Event, StateName, StateData) ->
    {ok, FileDesc} = test_client_base:open_file("e:/handle_info.dbg_log"),
    file:write(FileDesc, io_lib:format("handle_info:Event=~p,StateName=~p,StateData=~p ~n", [Event, StateName, StateData])),
    {next_state, StateName, StateData, 100}.

%% --------------------------------------------------------------------
%% Func: terminate/3
%% Purpose: Shutdown the fsm
%% Returns: any
%% --------------------------------------------------------------------
terminate(_Reason, _StateName, State) ->
    ?TRACE("$$$$$ tcp close terminate~n"),
    gen_tcp:close(State#state.socket),
    ok.

%% --------------------------------------------------------------------
%% Func: code_change/4
%% Purpose: Convert process state when code is changed
%% Returns: {ok, NewState, NewStateData}
%% --------------------------------------------------------------------
code_change(_OldVsn, StateName, StateData, _Extra) ->
    {ok, StateName, StateData}.


% %%登陆（普通模式）
% login(normal, Socket, Accid, Accname) ->
%     send_10000(Socket, Accid, Accname),
%     RoleId = player_list(Socket),
    
%     if RoleId == 0 ->
%            create(Socket, Accname),
%            player_list(Socket);
%        true ->
%            RoleId
%     end;

% %%登陆（游客模式）
% login(guest, Socket, _Accid, Accname) ->
%     Sex = rand(1, 2),
%     Career = rand(1, 3),
%     Accn_bin = list_to_binary(Accname),
%     Accn_len = byte_size(Accn_bin),
    
%     io:format("send 10010~n"),
%     gen_tcp:send(Socket, <<10010:16, 0:32, Sex:8, Career:8, Accn_len:16, Accn_bin/binary>>),
%     rec(Socket, 0).

%%发送认证, 协议:10000
% send_10000(Socket, _Accid, Accname) ->
%     Tstamp = 1273027133,
%     Infant = 1,
%     Md5 = Accname ++ integer_to_list(Tstamp) ++ ?TICKET ++ integer_to_list(Infant),
%     Ts = util:md5(Md5),
%     Accnb = list_to_binary(Accname),
%     Tsb = list_to_binary(Ts),
%     Lacc = byte_size(Accnb),
%     Lts = byte_size(Tsb),
%     io:format("send 10000: Accname=~s~n", [Accname]),
% %%  gen_tcp:send(Socket, <<L:16,10000:16,2:32,1273027133:32,3:16,"htc",32:16,"b33d9ace076ca0ac7a8afa56923a03a4">>),
%     gen_tcp:send(Socket, <<10000:16,Infant:8,Tstamp:32,Lacc:16,Accnb/binary,Lts:16,Tsb/binary>>),
%     rec(Socket, 0).

% %%创建角色
% create(Socket, Accname) -> 
%     % 因为name:random_name生成的名字有可能服务器检查为非法字符（返回码4），所以用帐号名作为角色名
%     % Name = name:random_name(),
%     Nameb = list_to_binary(Accname),
%     L1 = byte_size(Nameb),

%     gen_tcp:send(Socket, <<10003:16, 1:8, 1:8, 1:8, L1:16, Nameb/binary>>),
% %%     io:format("send 10003~n"),
%     case rec(Socket, 0) of
%         {10003, 1} -> 
%             true;
%         _ ->
%             io:format("Not return create role msg!~n") % create1(Socket)
%     end.

% %%玩家列表
% player_list(Socket) ->
%     gen_tcp:send(Socket, <<10002:16,1:16>>),  
%     case rec(Socket, 0) of
%         {10002, 0} ->
%             0;
%         {10002, L} when is_list(L) ->
%             [Id | _T] = L,
%             Id;
%         _ ->
%             0
%     end.

% %%选择角色进入
% enter(Socket, Id) ->
%     io:format("send 10004~n"),
%     gen_tcp:send(Socket, <<10004:16, Id:32>>),
%     rec(Socket, 0).

%%加载场景
% load_scene(State) ->
%     io:format("~p send:12002~n", [self()]),
%     gen_tcp:send(State#state.socket, <<12002:16>>), 
%     load_scene_loop(State).

% load_scene_loop(State) ->
%     case rec(State#state.socket, State) of
%         {12002, Reply} ->
%             Reply;
%         error ->
%             {[], [], [], [], []};
%         _ ->
%             load_scene_loop(State)
%     end.

%%用户信息
% load_player(Socket) ->
% %%     io:format("~p send:13001~n", [self()]),
%     gen_tcp:send(Socket, <<13001:16>>),     
%     case rec(Socket, 0) of
%         {13001, Reply} ->
%             Reply;
%         _ ->
%             load_player(Socket)
%     end.

% msg_loop(State, Cmd) ->
%     case rec(State#state.socket, State) of
%         {ok, Cmd} ->
%             skip;
%         _ ->
%             msg_loop(State, Cmd)
%     end.

%%
%%partner_troop(State) ->
%%    case rec(State#state.socket, State) of
%%        {ok, 17051} ->
%%            skip;
%%        _ ->
%%            partner_troop(State)
%%    end.

%%切换场景——目前支持在101和100之间切换
change_scene(State, _StateName) ->
    % ?TRACE("change_scene: Current State: ~p, StateName: ~p~n", [State, StateName]),
    % timer:sleep(5000), % 间隔5000ms
    NewSceneId =
    if State#state.scene == ?BORN_SCENE_NO ->
           ?SWITCH_TO_SCENE_NO;
       true ->
           ?BORN_SCENE_NO
    end,
    % ?TRACE("begin change...", []),
    glt_scene:switch_between_normal_scenes(NewSceneId),

    %% 发送完切换场景协议后设置为睡眠状态
    {next_state, sleep, State#state{next = sleep}, 1000}.

%%进入副本或退出副本
% change_dungeon(State, SceneId, Is_enter_dungeon) ->
%     io:format("+++ change_dungeon: SceneId=~p, Is_enter_dungeon=~p +++~n", [SceneId, Is_enter_dungeon]),
%     NewState = new_scene(State, SceneId),
%     NewS = if 
%                erlang:is_record(NewState, state) ->
%                    NewState;
%                true ->
%                    State
%            end,
%     {ElemL, UserL, MonL, NpcL, _LevelL} = load_scene(NewS),
%     {next_state, sleep, NewS#state{next = sleep, is_in_dungeon = Is_enter_dungeon, eleml = ElemL, userl = UserL, monl = MonL, npcl = NpcL}, 5000}. %临时让切换场景之后的为停止状态

%%切换场景——目前支持在101和102之间切换
% new_scene(State) ->
%     Scene =
%     if State#state.scene == 101 ->
%            102;
%        true ->
%            101
%     end,
%     gen_tcp:send(State#state.socket, <<12005:16, Scene:32>>),
%     NewState = rec(State#state.socket, State),
%     NewState.

%%切换到副本场景——目前支持在102和10011之间切换
% new_scene(State, Did) ->
%     if 
%         State#state.scene == 101->
%             io:format("send 12005, scene: ~p~n", [Did]),
%             gen_tcp:send(State#state.socket, <<12005:16, Did:32>>),
%             State2 = rec(State#state.socket, State),
%             State2;
%         true ->
%             State
%     end.

% %%打怪
% battle_mon(State) ->
%     MonL = State#state.monl,
% 	%io:format("+++ MonL=~p +++~n", [MonL]),
%     MonId = lists:nth(random:uniform(length(MonL)), MonL),
%     gen_tcp:send(State#state.socket, <<20001:16, MonId:32>>),
%     case rec_battle(State#state.socket, State) of
%         ok -> State#state{next = sleep};
%         skip -> State#state{next = battle_mon}
%     end.

% %%获取任务
% get_task(Socket) ->
%     io:format("send:30000~n"),
%     gen_tcp:send(Socket, <<30000:16>>),
%     get_task_loop(Socket).

% get_task_loop(Socket) ->
%     case rec(Socket, 0) of
%         {ok, 30000} ->
%             30000;
%         _ ->
%             get_task_loop(Socket)
%     end.

% %%获取系统设置
% get_sys_config(Socket) ->
%     io:format("send:33000~n"),
%     gen_tcp:send(Socket, <<33000:16>>),
%     get_sys_loop(Socket).

% get_sys_loop(Socket) ->
%     case rec(Socket, 0) of
%         {ok, 33000} ->
%             33000;
%         _ ->
%             get_sys_loop(Socket)
%     end.

% speak(State) ->
%     Chat_List = get_chat_list(),
%     A1 = lists:nth(random:uniform(length(Chat_List)), Chat_List), 
%     L1 = byte_size(A1),
%     gen_tcp:send(State#state.socket, <<11001:16,0:8,L1:16,A1/binary>>).

% %随机走路, 根据场景作一些限制，以免跑到场景外
% walk_xy(State) ->
%     NewState1 = reset_to_valid(State),
%     NewState = get_valid_next_xy(NewState1),
%     X = NewState#state.x,
%     Y = NewState#state.y,
%     io:format("send 12001  X=~p, Y=~p ~n", [X, Y]),
%     gen_tcp:send(NewState#state.socket, << 12001:16, X:16, Y:16 >>),
%     NewState.

% %% 获取下一个有效的XY座标
% get_valid_next_xy(State) ->
%   {X, Y} = next_xy(State#state.dir, State#state.x, State#state.y),
%   case is_xy_valid(State, X, Y) of
%       true ->  State#state{x = X, y = Y};
%       false -> NewDir = random:uniform(7),
%                get_valid_next_xy(State#state{dir = (State#state.dir + NewDir) rem 8})
%   end.

%%获取当前方向下一个座标
next_xy(Dir, X, Y) ->
    {X1, Y1} = 
     case Dir of
         0 ->   {X+1, Y}    ;%%left stay
         1 ->   {X+1, Y-1}  ;%%left down
         2 ->   {X,   Y-1}  ;%%stay down
         3 ->   {X-1, Y-1}  ;%%right down
         4 ->   {X-1, Y  }  ;%%right stay
         5 ->   {X-1, Y+1}  ;%%right up
         6 ->   {X,   Y+1}  ;%%stay  up 
         7 ->   {X+1, Y+1}   %%left  up
     end,

     Dir1 = rand(0, 7),
     Scene = data_scene:get(101),
     if
         X1 < 1 orelse X1 > Scene#scene.width orelse Y1 < 1 orelse Y1 > Scene#scene.height ->
            next_xy(Dir1, X1, Y1);
        true ->
            {X1, Y1}
     end.


%%是否可以行走的的XY座标
% is_xy_valid(State, X, Y) ->
%     SceneId = State#state.scene,
%     Scene = data_scene:get(SceneId),
%     {Width, Height} = {Scene#scene.width,  Scene#scene.height},
%     Mask1 = data_mask:get(SceneId),
%     F = fun(EE, R) -> 
%             case EE of
%                 48 -> [EE | R];  %%"0"
%                 49 -> [EE | R];  %%"1"
%                 _  -> R
%             end
%     end,
%     Mask = lists:foldr(F, [], Mask1),
%     if Y > Height orelse X > Width ->
%           false;
%       Y < 0 orelse X < 0 ->
%           false;
%       true -> 
%           Index = Y * Width + X + 1,
%           if Index > length(Mask) ->
%                 false;
%           true ->
%               Mark = list_to_integer([lists:nth(Index,Mask)]), 
%               Mark =:= 0
%           end
%     end.

% %%如果当前XY不是有效的，
% %%复位到可以行走的首个XY座标
% reset_to_valid(State) ->
%     X = State#state.x, 
%     Y = State#state.y,
%     case is_xy_valid(State, X, Y) of
%         true -> State;
%         false -> Scene = data_scene:get(State#state.scene),
%                  {Width, _Height} = {Scene#scene.width, Scene#scene.height},
%                  Mask1 = data_mask:get(State#state.scene),
%                  F = fun(EE, R) -> case EE of
%                                      48 -> [EE | R];
%                                      49 -> [EE | R];
%                                      _  -> R
%                                   end
%                  end,
%                  Mask = lists:foldr(F, [], Mask1),
%                  Index = first_valid(Mask, 1),
%                  YY = floor(Index/Width),
%                  XX = Index - YY * Width,
%                  io:format("Reset X,Y to ~p, ~p ~n", [XX, YY]),
%                  State#state{x=XX, y=YY}
%     end.

% %%搜索第一个有效的XY
% first_valid([], Index) ->
%     Index;
% first_valid([E|T], Index) ->
%     case list_to_integer([E]) =:= 0 of
%          false -> first_valid(T,Index+1);
%          true  -> Index
%     end.

%%向下取整
% floor(X) ->
%     T = trunc(X),
%     case (X < T) of
%         true -> T - 1;
%         _ -> T
%     end.

%%%朝目的地走
% walk_dest(State) ->
%     X = State#state.x,
%     Y = State#state.y,
%     {Dx,Dy} = State#state.dest,
    
%     Xdir = 
%     if State#state.x > Dx ->
%            left;
%        State#state.x == Dx ->
%            stay;
%        State#state.x < Dx ->
%            right
%     end,
%     Ydir = 
%     if State#state.y > Dy ->
%            up;
%        State#state.y == Dy ->
%            stay;
%        State#state.y < Dy ->
%            down
%     end,
    
%     {DDx, DDy} =
%     case {Xdir, Ydir} of
%         {left, down} ->
%             {-1, 1};
%         {left, up} ->
%             {-1, -1};
%         {left, stay} ->
%             {get_max(-2, Dx - State#state.x), 0};
%         {right, down} ->
%             {1, 1};
%         {right, up} ->
%             {1, -1};
%         {right, stay} ->
%             {get_min(2, Dx - State#state.x), 0};
%         {stay, down} ->
%             {0, get_min(2, Dy - State#state.y)};
%         {stay, up} ->
%             {0, get_max(-2, Dy - State#state.y)}
%     end,
    
%     NewState = State#state{x = X + DDx, y = Y + DDy},
%     Nx = NewState#state.x,
%     Ny = NewState#state.y,
%     Next =
%     if Nx == Dx andalso Ny == Dy ->
%            sleep;
%        true ->
%            walk_to_dest
%     end,
%     io:format("send 12001~n"),
%     gen_tcp:send(State#state.socket, <<12001:16, Nx:16, Ny:16>>),
%     NewState#state{next = Next}.
    
% %Socket接收,异步
% rec(Socket,State) ->
%     Ref = async_recv(Socket, 0, ?HEART_TIMEOUT),
%     receive
%         {inet_async, Socket, Ref, {ok, <<Binary/binary>>}} ->
%             rec1(Binary, {Socket,State});
%         Other1 ->
%             io:format("Other1 ~p~n",[Other1])
%     end.

%Socket消息处理
% rec1(Data, {Socket,State}) ->
%     case Data of
%         <<"<cross-domain-policy><allow-access-from domain='*' to-ports='*' /></cross-domain-policy>">> -> 
%             io:format("rec : flash_file~n");
        
%         <<10010:16, _IsCompress:8, _Accid:32, RoleId:32, _Bin/binary>> -> 
%             io:format("rec 10010~n"),
%             RoleId;
        
%         <<10003:16, _IsCompress:8, Bin:16>> -> 
%             io:format("rec 10003 Bin:~p~n",[Bin]),
%             {10003,Bin};

%         %%角色列表
%         <<10002:16, _IsCompress:8, Times:16, Bin/binary>> -> 
%             io:format("rec 10002 Times:~p~n",[Times]),
%             F = fun({PL, Binf}) ->
%                         <<Id:32, _Status:16, _Career:16, _Sex:16, _Lv:16, Binf1/binary>> = Binf,
%                         {_Name, Binf2} = read_string(Binf1),
%                         {[Id | PL], Binf2}
%                 end,
%             {Reply, _Bin1} =
%                 case Times of
%                     0 ->
%                         {0, <<>>};
%                     Times ->
%                         for(0, Times, F, {[],Bin})
%                 end,
%             %% io:format("----------------------Reply:~p~n",[Reply]),
%             {10002, Reply};

%         %%用户信息
%         <<13001:16, _IsCompress:8, Scene:32, X:16, Y:16, _Id:32, _Hp:32, _Hp_lim:32, _Mp:32, _Mp_lim:32,_Sex:16, _Lv:16, _Bin/binary>> -> 
%             %{Nick, _} = read_string(Bin),
%             %io:format("~p revc 13001:~p~n",[self(), [Scene,X,Y,Id,Hp,Hp_lim,Mp,Mp_lim,Sex,Lv,Nick]]),
%             io:format("~p revc 13001, scene: ~p~n",[self(), [Scene]]),
%             {13001, {Scene,X,Y}};
        
%         %%场景
%         <<12002:16, IsCompress:8, Bin/binary>> -> 
%             io:format("recv 12002, IsCompress:~p~n", [IsCompress]),
%             Bin0 = case IsCompress of
%                        1 ->
%                            zlib:uncompress(Bin);
%                        0 ->
%                            Bin
%                    end,

%             <<L:16, Bin1/binary>> = Bin0,
%             %% if _L < 1456 ->
%             F = fun({ElemL, Binf}) ->
%                         <<Sid:32, Binf1/binary>> = Binf,
%                         {Nick1, Binf2} = read_string(Binf1),
%                         << X:16, Y:16, Type:8, Binf3/binary >> = Binf2,
%                         %io:format("revc scene user online :~p~n",[[Sid,Nick1,X,Y,Type]]),
%                         {[{Sid,Nick1,X,Y,Type} | ElemL], Binf3}
%                 end,
%             {ElemL,Bin2} = for(0, L, F, {[],Bin1}),
%             %io:format("ElemL:~p~n",[ElemL]),
            
%             <<L2:16, Bin22/binary>> = Bin2,
%             F2 = fun({UL,Binf}) ->
%                          <<_X:16, _Y:16, Uid:32, _Hp:32, _Power:32, _Hp_lim:32, _P_lim:32, _Lv:16, _Career:8, Binf1/binary>> = Binf,
%                          {_Nick1, Binf2} = read_string(Binf1),
%                          << _Speed:16, _E1:32, _E2:32, _E4:32, _WingShow:32, _E3:32, _Sex:8, _Leader:8, _MountTypeId:32, 
%                             _Battle_capacity:32, _Star:32, _Area:32, _GuildId:32, Binf3/binary>> = Binf2,
%                          {_GuildName, Binf4} = read_string(Binf3),
% 						 {_PvpFlagNum, Binf44} = read_string(Binf4),
%                          << _PvpCdTime:32, _CurState1:16, _Vip:8, _CurrentTitle:32, Binf5/binary >> = Binf44,
%                          <<ParLen:16, Binf6/binary>> = Binf5,
%                          F22 = fun(Binff) ->
%                                        <<_ParId:32, Binff1/binary>> = Binff,
%                                        {_ParName, Binff2} = read_string(Binff1),
%                                        <<_ParTypeId:32, Binff3/binary>> = Binff2,
%                                         Binff3
%                                end,
%                          Binf7 = for(0, ParLen, F22, Binf6),
% 						 <<_Single:32, _Double:32, _PvpCamp:32, _WingStren:32, _WingFlyState:8, _Pose:8, _BeautyId:32, Binf8/binary>> = Binf7,
%                          {_BeautyName, Binf9} = read_string(Binf8),
% 						 <<_BeautyIcon:32, Binf10/binary>> = Binf9,
% 						{[Uid|UL],Binf10}
%                  end,
%             {UserL,Bin3} = for(0, L2, F2, {[],Bin22}),
%             %%io:format("L2:~p,UL:~p~n",[L2,UserL]),
            
%             <<L3:16, Bin33/binary>> = Bin3,
%             F3 = fun({ML,Binf}) ->
%                          <<_X:16, _Y:16, Id:32, _Mid:32, _Lv:16, Binf1/binary>> = Binf,
%                          {_Name, Binf2} = read_string(Binf1),
%                          <<_Speed:16, _Icon:32, TalkCount:16, Binf3/binary>> = Binf2,
%                          %io:format("### TalkCount=~p~n", [TalkCount]),
%                          F4 = fun(BinTalk) ->
%                                   read_string(BinTalk)
%                               end,
% 						 Binf4 = if
% 									 TalkCount == 0 ->
% 										 Binf3;
% 									 true ->
% 										 {_TalkL, Binf44} = for(0, TalkCount, F4, Binf3),
% 										 Binf44
% 								 end,
%                          <<_PassFinish:32, _ReadyBattleLeftTime:16, _AttArea:16, Binf5/binary>> = Binf4,
%                          {[Id|ML],Binf5}
%                  end,
%             {MonL,Bin4} = for(0, L3, F3, {[],Bin33}),
%             %io:format("### Mon List:~p ###~n",[MonL]),
            
%             <<L4:16, Bin44/binary>> = Bin4,
%             %% io:format("Bin-4:~p->~p->~p->~p->~p~n",[byte_size(Bin),byte_size(Bin1),byte_size(Bin2),byte_size(Bin3),byte_size(Bin4)]),
%             %% io:format("L4:~p~n",[L4]),
%             F4 = fun({NL,Binf}) ->
%                          %%                          io:format("NL:~p~n",[NL]),
%                          <<Id:32, _Nid:32, Binf1/binary>> = Binf,
%                          %%                          io:format("1~n"),
%                          {_Name, Binf2} = read_string(Binf1),
%                          %%                          io:format("2~n"),
%                          <<_X:16, _Y:16, _Icon:32, _Func:32, Binf3/binary>> = Binf2,
%                          %%                          io:format("3~n"),
%                          %%                          io:format("binf3~p~n",[{byte_size(Binf3),Binf3}]),
% 						 {_FuncDesc, Binf4} = read_string(Binf3),
%                          {[Id|NL],Binf4}
%                  end,
%             {NpcL, Bin5} = for(0, L4, F4, {[],Bin44}),
%             %%io:format("L4:~p NpcL:~p~n",[L4,NpcL]),
            
%             <<L5:16, Bin55/binary>> = Bin5,
%             F5 = fun({LevelL, Binf}) ->
%                          <<Sid:32, Binf1/binary>> = Binf,
%                          {Nick1, Binf2} = read_string(Binf1),
%                          << X:16, Y:16, Type:8, Binf3/binary >> = Binf2,
%                          %io:format("revc scene user online :~p~n",[[Sid,Nick1,X,Y,Type]]),
%                          {[{Sid,Nick1,X,Y,Type} | LevelL], Binf3}
%                  end,
%             {LevelL,_Bin6} = for(0, L5, F5, {[],Bin55}),
%             %%io:format("LeveL:~p~n",[LevelL]),
            
%             {12002, {ElemL, UserL, MonL, NpcL, LevelL}};
%         %%            true ->
%         %%                io:format("!!!!!!!!!!!!!!!!!_L:~p~n",[_L]),
%         %%                F = fun({ElemL, Binf}) ->
%         %%                     <<Sid:32, Binf1/binary>> = Binf,
%         %%                     {Nick1, Binf2} = read_string(Binf1),
%         %%                     << X:16, Y:16, Type:8, Binf3/binary >> = Binf2,
%         %%                     %io:format("revc scene user online :~p~n",[[Sid,Nick1,X,Y,Type]]),
%         %%                     {[{Sid,Nick1,X,Y,Type} | ElemL], Binf3}
%         %%                     end,
%         %%                 {ElemL,_Bin2} = for(0, L, F, {[],Bin1}),
%         %%                    {12002,{ElemL,[],[],[10101,10102,10104,10105,10109],[{1000,<<"关卡列表1">>,16,11,1}]}}
%         %%             end;

%         %%切换场景回应
%         <<12005:16, _IsCompress:8, Id:32, X:16, Y:16, Bin/binary>> -> 
%             io:format("~p rec 12005(change scene): ~p~n",[self(),[Id,X,Y]]),
%             {_Name, Bin1} = read_string(Bin),
%             << Sid:32, _Bin2/binary>> = Bin1,
%             {12005, State#state{x = X, y = Y, scene = Sid}};
        
%         %战斗获取NPC
%         <<32000:16, _IsCompress:8, Bin/binary>> ->
%             io:format("rev 32000 : ~p~n", [Bin]),
%             {ok, 32000};
        
%         %任务
%         <<30000:16, _IsCompress:8, _Bin/binary>> ->
%             io:format("rev 30000~n", []),
%             {ok, 30000};
        
%         %系统设置
%         <<33000:16, _IsCompress:8, _Bin/binary>> ->
%             io:format("rev 33000~n", []),
%             {ok, 33000};
        
%         %战斗结果
%         %<< _Cmd:16, _IsCompress:8, Id:32, Hp:32, Mp:32,Id2:32, Hp2:32, Mp2:32,S1:32, S2:16>> ->
%         %    io:format("revc battle: ~p,~p,~p,~p,~p,~p,~p,~p~n", [Id, Id2, Hp, Hp2, Mp, Mp2, S1, S2]),
%         %    rec(Socket, 0);
 
%         %%获取携带的武将
%         <<17051:16, _IsCompress:8, PartnerCount:16, Bin/binary>> -> 
%             io:format("17051: PartnerCount=~p~n",[PartnerCount]),
%             <<ParType:32, ParId:32, _Bin2/binary>> = Bin,
%             % 排兵布阵
%             io:format("17051: ParType=~p ParId=~p~n",[ParType,ParId]),
%             Id = State#state.id,
%             TroopDataB = <<2:8, Id:32, 3:8>>,                                        
%             gen_tcp:send(Socket, <<17004:16, 10011:32, 1:16, TroopDataB/binary>>),   % 10011：
%             sleep(500),
%             % 启用阵法
%             gen_tcp:send(Socket, <<17003:16, 10011:32>>),
%             {ok, 17051};
        
%        <<11009:16, _IsCompress:8, _Bin/binary>> -> 
%             %io:format("~p rec cmd 11009~n", [self()]),
%             {ok, 11009};
          
%         R ->
%             <<Cmd:16, _IsCompress:8, _Bin/binary>> = R,
%             if
%                 Cmd >= 10000 ->
%                     %io:format("~p other network cmd:~p~n", [self(), Cmd]),
%                     {ok, Cmd};
%                 true ->
%                     io:format("~p OPT:~p nothing: ~p~n", [self(), inet:getopts(Socket, [recbuf, packet_size]), R]),
%                     io:format("------~n"),
%                     io:format("STAT:~p~n", [inet:getstat(Socket)]),
%                     error
%             end
%     end.

%%接收战斗时Socket消息
% rec_battle(Socket,State) ->
%     Ref = async_recv(Socket, 0, ?HEART_TIMEOUT),
%     receive
%         {inet_async, Socket, Ref, {ok, <<Binary/binary>>}} ->
%             handle_battle_msg(Binary, {Socket,State}),
%             ok;
%         Other1 ->
%             io:format("rec_battle: Other ~p~n",[Other1]),
%             skip
%     end.

% %%战斗Socket消息处理
% handle_battle_msg(Data, {Socket, State}) ->
%     case Data of
%           %%战场初始化
%           <<20007:16, _IsCompress:8, _BattleType:8, _BattleSubType:8, _Is_reverse:8, _Is_att_side:8, SkillListLen:16, Bin/binary>> -> 
%             F = fun({SL, Bin1}) ->
%                     <<SkillId:32, SkillLv:16, Grid:16, _CanUse:8, _Round:8, _CfgRound:8, Bin2/binary>> = Bin1,
%                     {[{SkillId, SkillLv, Grid}|SL], Bin2}
%                 end,
%             {SkillL, Rest} = for(0, SkillListLen, F, {[],Bin}),
%             <<Bo_id:32, _Rest2/binary>> = Rest,
%             %io:format("rec 20007: BoId:~p, SkillList:~p~n", [Bo_id, SkillL]),
%             sleep(1000),
%             select_skill(Socket, Bo_id, SkillL),
%             sleep(50),
%             rec_battle(Socket, State#state{bo_id = Bo_id, skilll = SkillL});

%          %战斗报告
%          <<20008:16, _IsCompress:8, _Bin/binary>> ->
%             %io:format("rec 20008: battle report data~n"),
%             sleep(1000),
%             %select_skill(Socket, State#state.bo_id, State#state.skilll),
%             %sleep(50),
%             rec_battle(Socket, State);

%         <<20009:16, _IsCompress:8, _Bin/binary>> ->
%             %io:format("rec 20009: select skills~n"),
%             %select_skill(Socket, State#state.bo_id, State#state.skilll),
%             sleep(50),
%             rec_battle(Socket, State);

%         %%战斗结果
%         <<20010:16, _IsCompress:8, _Result:32>> ->
%             %io:format("rec 20010: battle result(1:win, 0:lost): ~p~n", [Result]),
%             % 补满血
% 			gm_cmd(Socket, "@hp 10000"),
%     		msg_loop(State, 11009),
% 			% 打怪
% 			battle_mon(State),
%             State;

%         <<20050:16, _IsCompress:8>> ->
%             %io:format("rec 20050: count down ~n"),
% 			select_skill(Socket, State#state.bo_id, State#state.skilll),
% 			sleep(50),
%             rec_battle(Socket, State);

%         %<<12008, _IsCompress:8, _X:16, _Y:16, _Id:32, _Bin/binary>> ->
%         %     io:format("rec 12008: mon moveing~n"),
%         %     rec_battle(Socket, State);

%         <<_Cmd:16, _IsCompress:8, _Bin/binary>> ->
%             %io:format("--- other message=~p ---~n", [Cmd]),
%             rec_battle(Socket, State);

%         Any ->
%             io:format("+++ unkown message:~p +++~n", [Any]),
%             rec_battle(Socket, State)
%     end.

% %%发送技能
% select_skill(Socket, Bo_id, SkillL) ->
%     [{SkillId0, SkillLv0, Grid0}|_T] = SkillL,
%     %io:format("### select_skill: ~p ~p ~p ###~n", [SkillId0, SkillLv0, Grid0]),
%     gen_tcp:send(Socket, <<20009:16, Bo_id:32, SkillId0:32, SkillLv0:16, Grid0:16>>).

% %%发送GM
% gm_cmd(Socket, Cmd) ->
%     io:format("--- gm_cmd:~s ---~n", [Cmd]),
%     BinCmd = list_to_binary(Cmd),
%     Len = byte_size(BinCmd),
%     gen_tcp:send(Socket, <<11009:16, 0:32, Len:16, BinCmd/binary>>).


%%写字符串
%% write_string(Bin) ->
%%     Binb = list_to_binary(Bin),
%%     Len = byte_size(Binb),
%%     <<Len:16, Binb/binary>>.

sleep(T) ->
    receive
    after T -> ok
    end.

% get_max(X,Y) ->
%     if X >= Y ->
%            X;
%        true ->
%            Y
%     end.

% get_min(X,Y) ->
%     if X >= Y ->
%            Y;
%        true ->
%            X
%     end.

%% 产生一个介于Min到Max之间的随机整数
rand(Same, Same) -> Same;
rand(Min, Max) ->
    random:seed(os:timestamp()),
    M = Min - 1,
    random:uniform(Max - M) + M.

%% 接收信息
% async_recv(Sock, Length, Timeout) when is_port(Sock) ->
%     case prim_inet:async_recv(Sock, Length, Timeout) of
%         {error, Reason} -> throw({Reason});
%         {ok, Res}       -> Res;
%         Res             -> Res
%     end.

%%模拟对白
% get_chat_list() ->
%     [
%         <<"伟大的中国共产党">>,
%         <<"跟随失败,队长不能自己跟随自己.">>,
%         <<"石家庄在下雪">>,
%         <<"是鹅毛大雪">>,
%         <<"像是宰了一群鹅">>,
%         <<"拔了好多鹅毛">>,
%         <<"也不装进袋子里">>,
%         <<"像是羽绒服破了">>,
%         <<"也不缝上">>,
%         <<"北京也在下雪">>,
%         <<"不是鹅毛大雪">>,
%         <<"是白沙粒">>,
%         <<"有些像白砂糖">>,
%         <<"有些像碘盐">>,
%         <<"廊坊夹在石家庄和北京之间">>,
%         <<"廊坊什么雪也不下">>,
%         <<"看不到鹅毛">>,
%         <<"也看不到白砂糖和碘盐">>,
%         <<"廊坊只管阴着天">>,
%         <<"像一个女人吊着脸">>,
%         <<"说话尖酸、刻薄">>,
%         <<"还冷飕飕的">>,
%         <<"汉皇①重色思倾国，御宇②多年求不得。杨家有女初长成，养在深闺人未识。">>, 
%         <<"天生丽质难自弃，一朝选在君王侧。回眸一笑百媚生，六宫粉黛无颜色。 ">>,
%         <<"春寒赐浴华清池，温泉水滑洗凝脂。侍儿扶起娇无力，始是新承恩泽时。 ">>,
%         <<"云鬓花颜金步摇，芙蓉帐暖度春宵。春宵苦短日高起，从此君王不早朝。 ">>,
%         <<"承欢侍宴无闲暇，春从春游夜专夜。 后宫佳丽三千人，三千宠爱在一身。 ">>,
%         <<"金屋妆成娇侍夜，玉楼宴罢醉和春。姊妹弟兄皆列土，可怜光彩生门户③。">>,
%         <<"遂令天下父母心，不重生男重生女。骊宫高处入青云，仙乐风飘处处闻。 ">>,
%         <<"缓歌谩舞凝丝竹，尽日君王看不足。渔阳鼙鼓④动地来，惊破霓裳羽衣曲。">>,
%         <<"九重城阙烟尘生，千乘万骑西南行。翠华摇摇行复止，西出都门百余里。 ">>,
%         <<"六军不发无奈何，宛转蛾眉马前死。花钿委地无人收，翠翘金雀玉搔头。 ">>,
%         <<"君王掩面救不得，回看血泪相和流。黄埃散漫风萧索，云栈萦纡登剑阁。 ">>,
%         <<"峨嵋山下少人行，旌旗无光日色薄⑤。蜀江水碧蜀山青，圣主朝朝暮暮情。 ">>,
%         <<"行宫见月伤心色，夜雨闻铃肠断声。 天旋地转回龙驭，到此踌躇不能去。 ">>,
%         <<"马嵬坡下泥土中，不见玉颜空死处。君臣相顾尽沾衣，东望都门信⑥马归。">>,
%         <<"归来池苑皆依旧，太液芙蓉未央柳。芙蓉如面柳如眉，对此如何不泪垂。 ">>,
%         <<"春风桃李花开日，秋雨梧桐叶落时。 西宫南内多秋草，落叶满阶红不扫。 ">>,
%         <<"梨园弟子白发新，椒房阿监青娥老。夕殿萤飞思悄然，孤灯挑尽未成眠。 ">>,
%         <<"迟迟钟鼓初长夜，耿耿星河欲曙天。 鸳鸯瓦冷霜华重，翡翠衾寒谁与共。 ">>,
%         <<"悠悠生死别经年，魂魄不曾来入梦。 临邛道士鸿都客，能以精诚致魂魄。 ">>,
%         <<"为感君王辗转思，遂教方士殷勤觅。排空驭气奔如电，升天入地求之遍。 ">>,
%         <<"上穷碧落⑦下黄泉，两处茫茫皆不见。忽闻海上有仙山，山在虚无缥渺间。 ">>,
%         <<"楼阁玲珑五云起，其中绰约多仙子。中有一人字太真，雪肤花貌参差是。 ">>,
%         <<"金阙西厢叩玉扃⑧，转教小玉报双成。闻道汉家天子使，九华帐里梦魂惊。 ">>,
%         <<"揽衣推枕起徘徊，珠箔银屏迤逦开⑨。云鬓半偏新睡觉，花冠不整下堂来。 ">>,
%         <<"风吹仙袂飘飘举，犹似霓裳羽衣舞。玉容寂寞泪阑干⑩，梨花一枝春带雨。">>,
%         <<"含情凝睇谢君王，一别音容两渺茫。昭阳殿里恩爱绝，蓬莱宫中日月长。 ">>,
%         <<"回头下望人寰处，不见长安见尘雾。惟将旧物表深情，钿合金钗寄将去。 ">>,
%         <<"钗留一股合一扇，钗擘黄金合分钿。但教心似金钿坚，天上人间会相见。 ">>,
%         <<"临别殷勤重寄词，词中有誓两心知。 七月七日长生殿，夜半无人私语时。 ">>,
%         <<"在天愿作比翼鸟，在地愿为连理枝。 天长地久有时尽，此恨绵绵无绝期。">>,
%         <<"明年上国富春光">>,
%         <<"朝廷自昔选才良">>,
%         <<"时平空山老壮士">>,
%         <<"代言直似汉文章">>,
%         <<"生来自秀培来秀">>,
%         <<"日移花影上窗香">>,
%         <<"快意一时荷叶雨">>,
%         <<"乐来一顾遇孙阳">>,
%         <<"メールアドレス">>,
%         <<"バックアップファイルのパスを入力して下さい">>,
%         <<"項目を埋めて Jabber User を検索して下さい">>,
%         <<"ユーザー統計の取得">>,
%         <<"は提携が変更されたためキックされました">>,
%         <<"该点不可行走！">>
%     ].
