%%%-------------------------------------- 
%%% @Module: lib_send
%%% @Author: lxl
%%% @Created: 2011-8-21
%%% @Modified: 2013.6.1 -- huangjf
%%% @Description: 发送消息给客户端的相关接口
%%%-------------------------------------- 
-module(lib_send).

-include("record.hrl").
-include("common.hrl").
-include("ets_name.hrl").
-include("less_used_hack.hrl").
-include("player.hrl").
-include("pt_comm.hrl").
-include("team.hrl").
-include("ets_name.hrl").
-include("pvp.hrl").

-export([
        send_to_sock/2,
        send_to_sock/3,
        send_to_sid/2,
        send_to_all/1,
        send_to_uid/2,
		send_to_uid/3,
		send_to_uid_for_cross/2,
		send_to_uid_for_cross/3,
        send_to_scene/2,
        send_to_AOI/2,
        send_to_AOI_except_me/2,
        send_to_AOI_by_scene_line_or_team_except_me/3,
        
        send_to_guild/2,
        send_to_team/2,
        send_to_room/2,
        send_to_online_friends/2,
		send_prompt_msg/2,
        send_to_faction/2,
		send_prompt_msg/3
       ]).





%% 发送提示信息给客户端
%% @para: MsgCode => 消息代号（定义在prompt_msg.hrl）
send_prompt_msg(PlayerId, MsgCode) when is_integer(PlayerId) ->
    send_prompt_msg(PlayerId, ?PROMPT_MSG_TYPE_TIPS, MsgCode);

send_prompt_msg(PS, MsgCode) when is_record(PS, player_status) ->
    send_prompt_msg(PS, ?PROMPT_MSG_TYPE_TIPS, MsgCode).


% %% 用于提示类似“你的等级不够xx级”的情况，参数ExtraInfo_Int表示具体是多少级，
% %%	至于其他更复杂的提示，以后再想怎么做 -- huangjf
% send_prompt_msg(_PlayerId, _MsgCode, _ExtraInfo_Int) ->
%     todo_here.

send_prompt_msg(PlayerId, Type, MsgCode) when is_integer(PlayerId) ->
    BinData = pt:pack(?PT_SEND_PROMPT_MSG, <<Type:8, MsgCode:32>>),
    send_to_uid(PlayerId, BinData);

send_prompt_msg(PS, Type, MsgCode) ->
    BinData = pt:pack(?PT_SEND_PROMPT_MSG, <<Type:8, MsgCode:32>>),
    send_to_sock(PS, BinData).


%% 发送消息给客户端（直接通过socket发送）
%% @para: Bin => 要发送的二进制数据
send_to_sock(Ident, Bin) ->
    send_to_sock(Ident, Bin, false).
    
%% @para: Force => 是否强行立即发送给客户端（true | false）
send_to_sock(PS, Bin, Force) when is_record(PS, player_status) ->
	% gen_tcp:send( player:get_socket(PS), Bin),
    send_socket(player:get_socket(PS), Bin, Force),
    void;
send_to_sock(Socket, Bin, Force) when is_port(Socket) ->
	send_socket(Socket, Bin, Force),
    void;
send_to_sock(_Other, _Bin, _Force) ->
    void.

send_socket(Socket, Bin, Force) ->
    % <<Cmd:16, _/binary>> = Bin,
    % ?LDS_TRACE("ALL PROTAL", [Cmd]),
    %gen_tcp:send(Socket, Bin).

    case nosql:get(sock_writer_map, Socket) of
        undef ->
            ?DEBUG_MSG("[lib_send] send_socket(), send process lost! Bin:~w", [Bin]),
            skip;
        SendPid ->
            SendPid ! {send, Bin, Force}
    end.

%% 发送信息给客户端（委托给专用于发送消息给客户端的进程）
%% @para: SendPid => 专用于发送消息给客户端的进程pid
%%        Bin => 二进制数据
%% @return: 无用
send_to_sid(PS, Bin) when is_record(PS, player_status), is_binary(Bin) ->  % delegate to send pid
    SendPid = player:get_sendpid(PS),
    case is_pid(SendPid) of
        true ->
            SendPid ! {send, Bin, false};
        false ->
            skip
    end,
    void;
send_to_sid(SendPid, Bin) when is_pid(SendPid), is_binary(Bin) ->  % delegate to send pid
    %%?ASSERT(is_pid(SendPid), SendPid),
    SendPid ! {send, Bin, false},
    void;

%% 这里扩展一个跨服通信的接口，假定pid字段格式是 {ServerId, PlayerId} ? 委托跨服通信进程cross_server发送消息到ServerId的通讯进程
%% send_to_sid({ServerId, PlayerId}, Bin) when erlang:is_integer(ServerId) andalso erlang:is_integer(PlayerId) ->
%% 	sm_cross_server:send

send_to_sid(_SendPid, _Other) ->
    ?ASSERT(false, {_SendPid, _Other}),
    void.




%% 发送消息给客户端（依据玩家id）
%% @para: Uid => 玩家id
%%        Bin => 二进制数据
send_to_uid(PlayerId, Bin) ->
	send_to_uid(PlayerId, Bin, false).


send_to_uid(PlayerId, Bin, Force) when is_binary(Bin) ->
	case player:get_sendpid(PlayerId) of
		null ->
            % ?ASSERT(false, PlayerId),
            % 调试代码，后面需屏蔽掉
            %%<<Cmd:16, _Compress:8, Body/binary>> = Bin,
            %%?DEBUG_MSG("!!!!!!!!!!!!!!!!!!!send_to_uid() error!!!  PlayerId=~p, Cmd=~p, Body=~w, stacktrace:~w", [PlayerId, Cmd, Body, erlang:get_stacktrace()]),

			skip;
		SendPid ->
            % 调试代码：
            % <<Cmd:16, _Compress:8, Body/binary>> = Bin,
            % ?DEBUG_MSG("!!!!!!!!send_tu_uid(),  PlayerId=~p, Cmd=~p, Body=~w, stacktrace=~w~n", [PlayerId, Cmd, Body, erlang:get_stacktrace()]),

%% 			send_to_sid(SendPid, Bin)
			SendPid ! {send, Bin, Force},
    		void
	end;

send_to_uid(_PlayerId, _Bin, _Force) ->
	?ASSERT(false, {_PlayerId, _Bin, _Force}),
	void.


	
   

%% 跨服节点专用给源服务器玩家rpc
send_to_uid_for_cross(PlayerId, Bin) ->
	send_to_uid_for_cross(PlayerId, Bin, false).


send_to_uid_for_cross(PlayerId, Bin, Force) when is_binary(Bin) ->
	case player:get_sendpid(PlayerId) of
		null ->
            % ?ASSERT(false, PlayerId),
            % 调试代码，后面需屏蔽掉
            %%<<Cmd:16, _Compress:8, Body/binary>> = Bin,
            %%?DEBUG_MSG("!!!!!!!!!!!!!!!!!!!send_to_uid() error!!!  PlayerId=~p, Cmd=~p, Body=~w, stacktrace:~w", [PlayerId, Cmd, Body, erlang:get_stacktrace()]),

			skip;
		SendPid ->
            % 调试代码：
            % <<Cmd:16, _Compress:8, Body/binary>> = Bin,
            % ?DEBUG_MSG("!!!!!!!!send_tu_uid(),  PlayerId=~p, Cmd=~p, Body=~w, stacktrace=~w~n", [PlayerId, Cmd, Body, erlang:get_stacktrace()]),

%% 			send_to_sid(SendPid, Bin)
			SendPid ! {send_for_cross, Bin, Force},
    		void
	end;

send_to_uid_for_cross(_PlayerId, _Bin, _Force) ->
	?ASSERT(false, {_PlayerId, _Bin, _Force}),
	void.

    
%% 发送消息给场景内的所有玩家客户端
%% @para: SceneId => 场景唯一id
send_to_scene(SceneId, Bin) ->
    L = lib_scene:get_scene_player_ids(SceneId),
    F = fun(Id) ->
    		send_to_uid(Id, Bin)
		end,
	lists:foreach(F, L).


    
    

%% 发送消息给帮派成员的客户端
%% GuildId:帮派ID
%% Bin:数据
send_to_guild(GuildId, Bin) when is_integer(GuildId) ->
    MemberIdList = mod_guild:get_member_id_list(GuildId),
    [send_to_uid(Id, Bin) || Id <- MemberIdList, player:is_online(Id)];
send_to_guild(Status, Bin) when is_record(Status, player_status) ->
    MemberIdList = mod_guild:get_member_id_list(player:get_guild_id(Status)),
    [send_to_uid(Id, Bin) || Id <- MemberIdList, player:is_online(Id)];
send_to_guild(Guild, Bin) ->
    MemberIdList = mod_guild:get_member_id_list(Guild),
    [send_to_uid(Id, Bin) || Id <- MemberIdList, player:is_online(Id)].

% %% 发送消息给队伍成员的客户端
% %% Bin: 数据
send_to_team(Team, Bin) when is_record(Team, team) ->
    MbIdList = [Mb#mb.id || Mb <- Team#team.members],
    F = fun(Id) ->
            case player:is_online(Id) of
                false -> skip;
                true -> send_to_uid(Id, Bin)
            end
        end,
    lists:foreach(F, MbIdList);
send_to_team(Status, Bin) when is_record(Status, player_status) ->
    MyId = player:id(Status),
    TeamId = player:get_team_id(MyId),
    MemberIdList = mod_team:get_all_member_id_list(TeamId),
    [send_to_uid(Id, Bin) || Id <- MemberIdList, player:is_online(Id)];    
send_to_team(_, _) -> ?ASSERT(false), error.

% %% 发送消息给房间成员的客户端（这里需要改为跨服）
% %% Bin: 数据
send_to_room(Room, Bin) when is_record(Room, room) ->
    MbIdList = [Room#room.captain] ++ Room#room.teammates,
    F = fun(Id) ->
            case player:is_online(Id) of
                false -> skip;
                true -> send_to_uid(Id, Bin)
            end
        end,
    lists:foreach(F, MbIdList).

send_to_faction(Status, Bin) ->
    Faction = player:get_faction(Status),
    PlayerList = ply_faction:get_faction_player_list(Faction),
    F = fun(Id) -> send_to_uid(Id, Bin) end,
    lists:foreach(F, PlayerList).    



%% 发送消息给玩家对应的AOI范围内的所有客户端（九宫格区域）
% send_to_AOI(PlayerPos, Bin) when is_record(PlayerPos, plyr_pos) ->
%     ?ASSERT(is_binary(Bin), Bin),
%     mod_go:send_to_AOI(PlayerPos, Bin);

send_to_AOI(PlayerId, Bin) when is_integer(PlayerId) ->
    ?ASSERT(is_binary(Bin), Bin),
    case player:get_position(PlayerId) of
        null ->
            ?ASSERT(false, {PlayerId, Bin}),
            skip;
        Pos ->
            %%%%send_to_AOI(Pos, Bin);
            mod_go:send_to_AOI(Pos#plyr_pos.scene_id, PlayerId, Bin)
    end;

%% 发送消息给指定位置对应的AOI范围内的所有客户端（九宫格区域）
send_to_AOI({SceneId, X, Y}, Bin) ->
    ?ASSERT(is_binary(Bin), Bin),
    mod_go:send_to_AOI({SceneId, X, Y}, Bin).


    





%% 发送消息给玩家对应的AOI范围内的客户端（九宫格区域），排除掉玩家自己！
send_to_AOI_except_me(MyId, Bin) ->
    ?ASSERT(is_binary(Bin), Bin),
    case player:get_position(MyId) of
        null ->
            ?ASSERT(false, MyId),
            skip;
        Pos ->
            %%% send_to_AOI_except_me(MyId, Pos, Bin)
            mod_go:send_to_AOI_except_me(Pos#plyr_pos.scene_id, MyId, Bin)
    end.

% %% 发送消息给指定位置对应的AOI范围内的客户端（九宫格区域），排除掉玩家自己！
% send_to_AOI_except_me(MyId, Pos, Bin) ->
%     ?ASSERT(is_record(Pos, plyr_pos), Pos),
%     ?ASSERT(is_binary(Bin), Bin),
%     mod_go:send_to_AOI_except_me(MyId, Pos, Bin).


    



%% 发送消息给玩家对应的AOI，但只发给指定场景分线的玩家和队友
send_to_AOI_by_scene_line_or_team_except_me(MyId, SceneLine, Bin) ->
    ?ASSERT(is_binary(Bin), Bin),
    case player:get_position(MyId) of
        null ->
            ?ASSERT(false, MyId),
            skip;
        Pos ->
            mod_go:send_to_AOI_by_scene_line_or_team_except_me(Pos#plyr_pos.scene_id, MyId, SceneLine, Bin)
    end.


    


    


% %% 发送消息给AOI，但只发给指定场景分线的玩家和队友（TOL：tolerant，表示此函数是包含了容错处理的版本）
% send_to_AOI_by_scene_line_or_team_except_me_TOL(MyId, Pos, SceneLine, Bin) ->
%     ?ASSERT(is_record(Pos, plyr_pos), Pos),
%     ?ASSERT(is_binary(Bin), Bin),
%     mod_go:send_to_AOI_by_scene_line_or_team_except_me_TOL(MyId, Pos, SceneLine, Bin).





%% 发送信息给在线好友
send_to_online_friends(_PS, _Bin) ->
    todo_here.

 	




%% 发送信息给所有在线客户端（典型例子：世界聊天）
send_to_all(Bin) ->
    SendPidList = mod_svr_mgr:get_all_online_player_sendpids(),
    F = fun(SendPid) ->
        	?ASSERT(is_pid(SendPid), SendPid),
    		SendPid ! {send, Bin}       % 这里的循环次数比较多，为了稍高效点，直接发送给SendPid，而不调用send_to_sid()
    	end,
    lists:foreach(F, SendPidList).
    




% %% 根据等级发送到世界
% send_to_all_by_level(Bin, MinLv, MaxLv) ->
% 	L = ets:match(?ETS_ONLINE, #ets_online{sid='$1', lv='$2', _='_'}),
% 	F = fun([Sid, Lv], Ids) ->
% 				X = tool:to_integer(Lv),
% 				if
% 					(X < 1 orelse X < MinLv orelse X > MaxLv) andalso MaxLv > 0 ->
% 						Ids;
% 					true ->
% 						Ids ++ [[Sid]]
% 				end
% 		end,
% 	SuitList = lists:foldl(F, [], L),
% 	do_broadcast(SuitList, Bin).

% %% 从世界节点发送信息到所有server节点
% send_to_all_by_level_from_world(Bin, MinLv, MaxLv) ->
%     gen_server:cast({global, ?GLOBAL_AFFICHE}, {apply_cast, lib_send, send_to_all_by_level, [Bin, MinLv, MaxLv]}).


% %% 对列表中的所有socket进行广播
% do_broadcast(L, Bin) ->
%     F = fun([S]) ->
%         send_to_sid(S, Bin)
%     end,
%     [F(D) || D <- L].

% %% 对列表中的所有I进行广播
% do_id_broadcast(L, Bin) ->
%     F = fun(Id) ->
%         send_to_uid(Id, Bin)
%     end,
%     [F(D) || D <- L].

% rand_to_process([H|_]) ->
% 	H.
