%%%----------------------------------------
%%% @Module  : misc_admin
%%% @Author  : lds
%%% @Created : 
%%% @Description: 系统状态管理和查询
%%%----------------------------------------
-module(misc_admin).
% %%
% %% Include files
% %%
% -include("common.hrl").
% -include("record.hrl").
% -include_lib("stdlib/include/ms_transform.hrl").

% %%
% %% Exported Functions
% %%
% -compile(export_all).

% -define(RECV_TIMEOUT, 5000).

% %%后台命令
% -define(KICKUSER,   1002).  %%踢玩家下线
% -define(BACKHOME,   1003).  %%送玩家回新手村
% -define(BROADMSG,   1014).  %%系统公告
% -define(BANTALK,    1016).  %%禁止发言/解除禁止
% -define(GMFEEKBACK, 1055).  %%GM反馈回复
% -define(GIVE_GOODS, 1018).  %%赠送物品
% -define(GET_ONLINE_NUM, 1056). %%从内存中获得实时在线数
% -define(GIVE_MONEY, 1009).   %%赠送元宝和金钱
% -define(MSG_RECHARGE, 1033).	%%充值
% -define(SEND_ALL_MAIL_BY_LV, 1057).	%%根据等级给该等级内所有玩家(包括不在线)发送邮件

% -define(SET_FRESHER_LEADER, 1038).  %%设置新手引导员
% -define(MD5KEY, "463ec174a69004dc9ec130f8a8331a26").  %%md5加密key

% %% 处理http请求【需加入身份验证或IP验证】
% treat_http_request(Socket, MsgLen) ->
% 	?TRACE("treat_http_request \n"),
% 	case gen_tcp:recv(Socket, MsgLen, ?RECV_TIMEOUT) of     %%读取MsgLen长度的数据
% 		{ok, Packet} -> 
% 			<<StampLen:16, Stamp:StampLen/binary-unit:8, SummaryLen:16, Summary:SummaryLen/binary-unit:8, RestData/binary>> = 
% 				tool:to_binary(Packet),
% 			?TRACE("stamp is ~p , Summary is ~p~n", [Stamp, Summary]),
% 			case check_command(Stamp, Summary) of
% 				true ->
% 					?TRACE_W("合法指令\n"),
% 					check_http_command(Socket, tool:to_binary(RestData));
% 				false ->
% 					?TRACE_W("非法指令\n"),
% 					?INFO_MSG("非法网关指令, 指令IP来源: ~p~n", [misc:get_ip(Socket)]),
% 					skip
% 			end,
% 			{http_request,  ok};
% %% 			?TRACE("The Http request is ~p~n", [Packet]),
% %% 			case check_ip(Socket) of
% %% 				true ->
% %% %% 					P = lists:concat([Packet0, tool:to_list(Packet)]),
% %% 					?TRACE("pass IP check\n"),
% %% 					check_http_command(Socket, tool:to_binary(Packet)),
% %% 					{http_request,  ok};
% %% 				_ ->
% %% 					?TRACE(" IP error!\n"),
% %% 					gen_tcp:send(Socket,  <<"no_right">>),
% %% 					{http_request,  no_right}	
% %% 			end;
% 		{error, Reason} -> 
% 			?TRACE("gen_tcp:recv error \n"),
% 			{http_request,  Reason}
% 	end.

% %%验证命令来源合法性,采用MD5摘要解析
% check_command(Stamp, Summary) ->
% 	Bin = <<(tool:to_binary(Stamp))/binary, (tool:to_binary(?MD5KEY))/binary>>,
% 	Str = binary_to_list(Bin),
% 	?TRACE("the md5 str is ~s~n", [Str]),
% 	SummaryServer = tool:md5(Str),
% 	?TRACE("md5 : ~p~n", [SummaryServer]),
% 	tool:to_list(Summary) == tool:to_list(SummaryServer).

% %% 加入http来源IP验证 
% check_ip(Socket) ->
% 	MyIp = misc:get_ip(Socket),
% 	?TRACE("MyIp is ~p~n", [MyIp]),
% 	Http_ips = config:get_http_ips(gateway),
% 	?TRACE("Http_ips is ~p~n", [Http_ips]),
% 	lists:any(fun(Ip) ->tool:to_binary(MyIp)=:=tool:to_binary(Ip) end, config:get_http_ips(gateway)).

% get_cmd_parm(Packet) ->
% 	Packet_list = string:to_lower(tool:to_list(Packet)),
% 	try
% 		case string:str(Packet_list, " ") of
% 			0 -> ?TRACE("no_cmd\n"),
% 				 no_cmd;
% 			N -> CM = string:substr(Packet_list,2,N-2),
% 				 case string:str(CM, "?") of
% 					 0 -> [CM, ""];
% 				 	N1 -> [string:substr(CM,1,N1-1),  string:substr(CM, N1+1)]
% 				 end
% 		end
% 	catch
% 		_:_ -> no_cmd
% 	end.


% %% 检查分析并处理http指令
% check_http_command(Socket, Packet) ->
% 	<<Cmd:16, Data/binary>> = Packet,
% 	?TRACE("the cmd is ~p~n", [Cmd]),
% 	case Cmd of
% 		?KICKUSER ->        %%踢玩家下线
% 			?TRACE("KICKUSER \n"),
% 			<<Id:32, _/binary>> = Data,
% 			operate_to_player(misc_admin, kickuser, [tool:to_integer(Id)]),
% 			BinData = pt_admin:pack(?KICKUSER, <<1:8>>),
% 			gen_tcp:send(Socket, BinData),
% 			ok;	
% 		?BACKHOME ->        %%送玩家会新手村
% 			<<Id:32, _/binary>> = Data,
% 			operate_to_player(misc_admin, backhome, [tool:to_integer(Id)]),
% 			BinData = pt_admin:pack(?BACKHOME, <<1:8>>),
% 			gen_tcp:send(Socket, BinData),
% 			ok;
% 		?BROADMSG ->		%%系统公告
% 			<<MsgId:32, Flag:8, _Rest/binary>> = Data,
% %% 			<<Content:Len/binary-unit:8, _/binary>> = Rest,
% 			?TRACE("Msgid=~p~n", [MsgId]),
% 			Key = ets:first(?ETS_SERVER),
% 			[Server] = ets:lookup(?ETS_SERVER, Key),
% 			Pid = rpc:call(Server#server.node, misc, whereis_name, [{global, ?GLOBAL_AFFICHE}]),
% 			?TRACE("Pid=~p~n", [Pid]),
% 			Msg = case tool:to_integer(Flag) of
% 					  1 ->
% 						  {'add_affiche', MsgId};
% 					  _ ->
% 						  {'delete_affiche', MsgId}
% 				  end,
% 			Pid ! Msg,
% 			BinData = pt_admin:pack(?BROADMSG, <<1:8>>),
% 			?TRACE("BROADMSG OVER\n"),
% 			gen_tcp:send(Socket, BinData),
% 			ok;
% 		?BANTALK ->  %%玩家禁言
% 			<<Id:32, BanTime:32, _/binary>> = Data,
% 			?TRACE("ban chat and ban time is ~p~n", [BanTime]),
% 			operate_to_player(misc_admin, ban_chat, [tool:to_integer(Id), tool:to_integer(BanTime)]),
% 			BinData = pt_admin:pack(?BANTALK, <<1:8>>),
% 			gen_tcp:send(Socket, BinData),
% 			ok;
% 		?GMFEEKBACK ->  %%GM反馈
% 			<<Id:32, _/binary>> = Data,
% 			Flag = case db:select_row(feedback, "role_id, title, reply_content", [{id, Id}]) of
% 				[RoleId, Title, Reply] ->
% 					NewTitle = <<(tool:to_binary("回复: "))/binary, (tool:to_binary(Title))/binary>>,
% 					case lib_mail:send_sys_mail_by_id([RoleId], NewTitle, Reply, 0, 0, 0, 0) of
% 						{ok, _} ->
% 							1;
% 						_ ->
% 							0
% 					end;
% 				_ ->
% 					0
% 			end,
% 			BinData = pt_admin:pack(?GMFEEKBACK, <<Flag:8>>),
% 			gen_tcp:send(Socket, BinData),
% 			ok;
% 		?GIVE_GOODS ->
% 			<<PlayerNum:16, Data1/binary>> = Data,
% 			List = get_name_lists(PlayerNum, Data1),
% 			RetData = lists:last(List),
% 			NameList = lists:delete(RetData, List),
% 			{Title, Ret1} = pt:read_string(RetData),
% 			{Reply, Ret2} = pt:read_string(Ret1),
% 			<<GoodsId:32, GoodsNum:16, Coin:16 ,StrenLv:8, _/binary>> = Ret2,
% 			%%redo: 只在单节点情况下适用 (待修改)
% 			[Server|_] = ets:tab2list(?ETS_SERVER),
% 			SendFailList = rpc:call(Server#server.node, lib_mail, bg_send_sys_mail_by_base_goods_id, [NameList, Title, Reply, GoodsId, GoodsNum, Coin, 0, StrenLv]),
% 			F = fun(Name) -> 
% 						case Name of
% 							[] ->
% 								false;
% 							_  ->
% 								true
% 						end
% 				end,
% 			{FailNameList, _} = lists:partition(F, SendFailList),
% 			{ok, BinData} = pt_admin:write(?GIVE_GOODS, FailNameList),
% %% 			BinData = pt:pack(?GIVE_GOODS_GOLD, <<1:8>>),
% 			gen_tcp:send(Socket, BinData),
% 			ok;
% 		?GET_ONLINE_NUM ->
% 			%%redo: 只在单节点情况下适用 (待修改)
% 			[Server|_] = ets:tab2list(?ETS_SERVER),
% 			{Num, Ip} = rpc:call(Server#server.node, misc_admin, get_online_num, []),
% 			?TRACE("num is : ~p , ip is ~p~n", [Num, Ip]),
% 			BinData = pt_admin:pack(?GET_ONLINE_NUM, <<Num:32, Ip:32>>),
% 			gen_tcp:send(Socket, BinData),
% 			ok;
% 		?GIVE_MONEY ->
% 			<<PlayerNum:16, Data1/binary>> = Data,
% 			List = get_name_lists(PlayerNum, Data1),
% 			RetData = lists:last(List),
% 			NameList = lists:delete(RetData, List),
% 			{Title, Ret1} = pt:read_string(RetData),
% 			{Reply, Ret2} = pt:read_string(Ret1),
% 			<<Gold:32, Coin:32 , _/binary>> = Ret2,
% 			[Server|_] = ets:tab2list(?ETS_SERVER),
% 			SendFailList = case rpc:call(Server#server.node, lib_mail, send_sys_mail, [NameList, Title, Reply, 0, 0, Coin, Gold]) of
% 							   {error, _} ->
% 								   NameList;
% 							   {ok, InvalidList} ->
% 								   InvalidList
% 						   end,
% 			F = fun(Name) -> 
% 						case Name of
% 							[] ->
% 								false;
% 							_  ->
% 								true
% 						end
% 				end,
% 			{FailNameList, _} = lists:partition(F, SendFailList),
% 			{ok, BinData} = pt_admin:write(?GIVE_MONEY, FailNameList),
% 			gen_tcp:send(Socket, BinData),
% 			ok;
% 		?MSG_RECHARGE ->
% 			?TRACE("handle recharge\n"),
% 			handle_recharge(Data),
% 			BinData = pt_admin:pack(?MSG_RECHARGE, <<1:8>>),
% 			gen_tcp:send(Socket, BinData),
% 			ok;
% 		?SEND_ALL_MAIL_BY_LV ->
% 			handle_send_all_mail_by_lv(Data),
% 			BinData = pt_admin:pack(?SEND_ALL_MAIL_BY_LV, <<1:8>>),
% 			gen_tcp:send(Socket, BinData),
% 			ok;
% 		?SET_FRESHER_LEADER ->
% 			?TRACE("handle set fresher leeder"),
% 			handle_set_fresher_leader(Data),
% 			BinData = pt_admin:pack(?SET_FRESHER_LEADER, <<1:8>>),
% 			gen_tcp:send(Socket, BinData),
% 			ok;
		
% 		_ -> 
% 			BinData = pt_admin:pack(0, <<0:8>>),
% 			gen_tcp:send(Socket, BinData)
% 	end.
	


% %% 获取节点列表
% get_node_info_list() ->
% 	L = lists:usort(mod_disperse:server_list()),
% 	Info_list =
% 		lists:map(
% 	  		fun(S) ->
% 				{Node_status, Node_name, User_count} = 
% 			  		case rpc:call(S#server.node, mod_disperse, online_state, []) of
% 						{badrpc, _} ->
%                               {fail, S#server.node, 0};
%                        [_State, Num, _] ->
%                               {ok,   S#server.node, Num}
% 					end,	
% 				Node_info = 
% 					try 
% 					case rpc:call(S#server.node, misc_admin, node_info, []) of
% 				  		{ok, Node_info_0} ->
% 							Node_info_0;
% 						_ ->
% 							error
% 					end
% 					catch
% 						_:_ -> error
% 					end,							
% 				{Node_status, Node_name, User_count, Node_info}
% 			end,
% 	  		L),
% 	{ok, Gateway_node_info} = misc_admin:node_info(),
% 	Info_list_1 = Info_list ++ [{0, node(), 0, Gateway_node_info}],
% 	{ok, Info_list_1}.



% %% ===================针对玩家的各类操作=====================================
% operate_to_player(Module, Method, Args) ->
%     F = fun(S)->  
% 			?TRACE("node__/~p/ ~n",[[S, Module, Method, Args]]),	
% 			rpc:cast(S#server.node, Module, Method, Args)
%     	end,
%     [F(S) || S <- ets:tab2list(?ETS_SERVER)],
% 	ok.

% %% 取得本节点的角色状态
% get_player_info_local(Id) ->
% %% 	case ets:lookup(?ETS_ONLINE, Id) of
% %%    		[] -> [];
% %%    		[R] ->
% %%        		case misc:is_process_alive(R#ets_online.pid) of
% %%            		false -> [];		
% %%            		true -> R
% %%        		end
% %% 	end.
% 	%%modify by LDS
% 	?TRACE("get_player_info_local and id is ~p~n", [Id]),
% 	case lib_player:get_user_info_by_id(Id) of
% 		[] -> [];
% 		Status ->
% 			?TRACE("the Status is ~p~n", [Status]),
% 			case misc:is_process_alive(Status#player_status.pid) of
% 				false -> [];
% 				true -> Status
% 			end
% 	end.

% %%根据等级给全服玩家发送邮件
% handle_send_all_mail_by_lv(Data) ->
% 	gen_server:cast({global, ?GLOBAL_MAIL}, {'bg_send_all_mail_by_lv', Data}).

% %%处理充值
% handle_recharge(Data) ->
% 	<<PlayerId:32, _/binary>> = Data,
% 	?TRACE("player id = ~p~n", [PlayerId]),
% 	case lib_player:get_player_pid(PlayerId) of
% 		[] -> skip;
% 		Pid -> gen_server:cast(Pid, 'recharge')
% 	end.

% %%设置新手引导员
% handle_set_fresher_leader(Data) ->
% 	<<PlayerId:32, Value:8, _/binary>> = Data,
% 	F = fun() -> db:update(player, [{identity, Value}], [{id, PlayerId}]) end,
% 	spawn(F),
% 	case lib_player:get_player_pid(PlayerId) of
% 		[] -> skip;
% 		Pid -> gen_server:cast(Pid, {'set_fresher_leader', Value})
% 	end.
	

% %% 设置禁言 或 解除禁言
% ban_chat(Id, BanTime) ->
% 	?TRACE("*** BAN CHAT and ban time is ~p~n", [BanTime]),
% 	Pid = lib_player:get_online_pid(Id),
% 	if BanTime >0 ->
% 		   %%取得当前的时间戳
% 			NowTimeStamp = util:unixtime(),
% 			%%结束禁言的时间戳
% 			EndBanTime = NowTimeStamp + BanTime,
% 			%%更新玩家状态
% 			if
% 				is_pid(Pid) ->
% %% 					Status = gen_server:call(Pid, 'PLAYER'),   
% %% 					NewStatus = Status#player_status{end_ban_time = EndBanTime},
% %% 					gen_server:cast(Pid, {'SET_PLAYER', NewStatus});
% 					gen_server:cast(Pid, {'set_ban_chat', BanTime});
% 				true ->
% 					ok
% 			end,
% 			gen_server:cast({global, ?GLOBAL_TIMER}, {'un_ban_chat', Pid, ?START_NOW, BanTime*1000, 1}),
% 			?TRACE("**** set a timer and banTime is ~p~n", [BanTime]),
% 			%%写入DB
% 			db:delete(ban_chat, [{player_id, Id}]),
% 			db:insert(ban_chat, [player_id, end_ban_time], [Id, EndBanTime]);
			
% 	   BanTime == 0 ->
% 		   db:delete(ban_chat, [{player_id, Id}]),
% 			if
% 				is_pid(Pid) ->
% %% 					Status = gen_server:call(Pid, 'PLAYER'),   
% %% 					NewStatus = Status#player_status{end_ban_time = 0},
% %% 					gen_server:cast(Pid, {'SET_PLAYER', NewStatus});
% 					gen_server:cast(Pid, {'set_ban_chat', BanTime});
% 				true ->
% 					ok
% 			end;
% 	   true ->
% 		   	error
% 	end.
% 	%%发送玩家被禁言/解禁消息
% %% 	lib_chat:ban_chat(Id, BanTime).

% %% %% 踢人下线
% kickuser(Id) ->
% 	?TRACE("Come to kickout \n"),
% 	case get_player_info_local(Id) of
% 		[] -> no_action;
% 		Status ->	
% 			Cmd = string:concat("@kickout ", integer_to_list(Id)),
% %% 			Cmd1 = string:tokens(Cmd, " "),
% %% 			?TRACE("The Cmd is ~p~n", [Cmd1]),
% 			lib_gm:handle_chat_msg_as_gm_cmd(Status, [Cmd])
% 	end.

% %%送玩家回新手村
% backhome(Id) ->
% 	?TRACE("Come to backhome \n"),
% 	case get_player_info_local(Id) of
% 		[] -> no_action;
% 		Status ->	
% 			Cmd = string:concat("@setpos ", integer_to_list(Id)),
% %% 			Cmd1 = string:tokens(Cmd, " "),
% 			lib_gm:handle_chat_msg_as_gm_cmd(Status, [Cmd])
% 	end.
	
% %%系统公告
% broadMsg(Content) ->
% 	?TRACE("boradMsg \n"),
% 	lib_chat:broadcast_sys_msg(tool:to_list(Content)).

% %%查看玩家实时在线人数和IP数
% %%@return: {人数, IP数}
% get_online_num() ->
% 	Num = lib_player:get_online_num(),
% 	Ip = lib_player:get_online_ip_num(),
% 	{Num, Ip}.

% %% 安全退出游戏服务器
% safe_quit(Node) ->
% 	yg_gateway:server_stop(),
% 	case Node of
% 		[] -> 
% 			mod_disperse:stop_game_server(ets:tab2list(?ETS_SERVER));
% 		_ ->
% 			rpc:cast(tool:to_atom(Node), yg, server_stop, [])
% 	end,
% 	ok.


% %%获取所有进程的cpu 内存 队列
% get_nodes_cmq(_Node,Type)->
% 	L = mod_disperse:server_list(),
% 	Info_list0 =
% 		if
% 			L == [] ->
% 				[];
% 			true ->
% 					lists:map(
% 					  fun(S)  ->
% 								  case rpc:call(S#server.node,mod_disperse,get_nodes_cmq,[Type]) of
% 									  {badrpc,_}->
% 										  [];
% 									  GetList ->
% 										  GetList
% 								  end
% 					  end
% 					  ,L)
% 		end,
	
% 	try
% 		Info_list = lists:flatten(Info_list0),
% 		F_sort = fun(A,B)->					
% 						 {_,_,{_K1,V1}}=A,
% 						 {_,_,{_K2,V2}}=B,
% 						 V1 > V2
% 				 end,
% 		Sort_list = lists:sort(F_sort,Info_list),
% 		F_print = fun(Ls,Str) ->
% 			lists:concat([Str,tuple_to_list(Ls)])
% 		end,
% 		lists:foldl(F_print,[],Sort_list)
% 	catch _e:_e2 ->
% 			 %%file:write_file("get_nodes_cmq_err.txt",_e2)
% 			 ?TRACE("_GET_NODES_CMQ_ERR:~p",[[_e,_e2]])
% 	end.

% %%查进程信息	
% get_porcess_info(Pid_list) ->
% 	L = mod_disperse:server_list(),
% 	Info_list0 =
% 		if
% 			L == [] ->
% 				[];
% 			true ->
% 				lists:map(
% 				  fun(S) ->
% 						  case rpc:call(S#server.node,mod_disperse,get_process_info,[Pid_list]) of
% 							  {badrpc,_} ->
% 								  [];
% 							  GetList ->
% 								  GetList
% 						  end
% 				  end
% 						 ,
% 				  L						 
% 				  )
% 		end,
% 	file:write_file("info_1.txt",Info_list0),
% 	Info_list = lists:flatten(Info_list0),
% 	F_print = fun(Ls,Str) ->
% 					  lists:concat([Str,Ls])
% 			  end,
% 	lists:foldl(F_print, [],Info_list).

% close_nodes(Type) ->
% 	case Type of
% 		2 ->
% 			safe_quit([]);
% 		_ ->
% 			nodes()
% 	end.
% get_name_lists(0, Data) ->
% 	[Data];
% get_name_lists(Count, Data) ->
% 	{Name, Ret} = pt:read_string(Data),
% 	[Name] ++ get_name_lists(Count - 1, Ret).

% %% 获取socket的统计信息
% %% 参数: SortType: freq|max_size|avg_size - 按什么类型排行（频率|最大大小|平均大小）
% %% 参数：DisplayCount - 显示的个数
% get_socket_stat_info(SortType, DisplayCount) -> 
% 	Info_stat_socket =
% 		try
% 			case ets:info(?ETS_STAT_SOCKET) of
% 				undefined ->
% 					[];
% 				_ ->
% 					Stat_list_socket_out = ets:match(?ETS_STAT_SOCKET,{'$1', socket_out , '$3','$4','$5','$6','$7','$8'}),
% 					Stat_list_socket_out_1 = case SortType of
% 												 freq ->
% 													 lists:sort(fun([_,_,_,Count1,_,_,_],[_,_,_,Count2,_,_,_]) -> Count1 > Count2 end, Stat_list_socket_out);
% 												 max_size ->
% 													 lists:sort(fun([_,_,_,_,_,MaxSize1,_],[_,_,_,_,_,MaxSize2,_]) -> MaxSize1 > MaxSize2 end, Stat_list_socket_out);
% 												 avg_size ->
% 													 lists:sort(fun([_,_,_,Count1,_,_,SumSize1],[_,_,_,Count2,_,_,SumSize2]) -> round(SumSize1 / Count1) > round(SumSize2 / Count2) end, Stat_list_socket_out);
% 												 _Other -> % 如果没指定正确，则默认为按频率来排行
% 													 lists:sort(fun([_,_,_,Count1,_,_,_],[_,_,_,Count2,_,_,_]) -> Count1 > Count2 end, Stat_list_socket_out)
% 											 end,
% 					Stat_list_socket_out_2 = lists:sublist(Stat_list_socket_out_1, DisplayCount),
% 					Stat_info_socket_out = 
% 					lists:map( 
% 	  					fun(Stat_data) ->
% 							case Stat_data of				
% 								[Cmd, BeginTime, EndTime, Count, MinSize, MaxSize, SumSize] ->
% 									TimeDiff = timer:now_diff(EndTime, BeginTime)/(1000*1000)+1,
% 									lists:concat(['        ','Cmd:[', Cmd, 
% 												'], packet_avg/sec:[', Count, '/',round(TimeDiff),' = ',round(Count / TimeDiff),
% 												'], MinSize:[', MinSize,
% 												'], MaxSize:[', MaxSize,
% 												'], AvgSize:[', round(SumSize / Count), ']\t\n']);
% 								_->
% 									''
% 							end 
% 	  					end, 
% 						Stat_list_socket_out_2),
% 					if length(Stat_info_socket_out) > 0 ->
% 						lists:concat(['    Socket packet_out statistic_top', DisplayCount, ':\t\n', Stat_info_socket_out]);
% 			   		   true ->
% 				   		[]
% 					end			
% 			end
% 		catch
% 			_:_ -> []
% 		end,
	
% 	io:format("~s~n", [Info_stat_socket]).

% %% 获取socket数据包的压缩信息
% get_socket_compress_info() ->
% 	Info_stat_compress =
% 		try
% 			case ets:info(?ETS_STAT_COMPRESS) of
% 				undefined ->
% 					[];
% 				_ ->
% 					Stat_list_socket_compress = ets:match(?ETS_STAT_COMPRESS,{'$1', socket_compress , '$3','$4','$5','$6'}),
					
% 					Stat_info_socket_compress = 
% 					lists:map( 
% 						fun(Stat_data) ->
% 								case Stat_data of				
% 									[Cmd, MinOrgSize, MinComSize, MaxOrgSize, MaxComSize] ->
% 										io_lib:format("        Cmd:[~p], MinOrgSize:[~p],MinComSize:[~p],MinComRate:[~.3f], MaxOrgSize:[~p],MaxComSize:[~p],MaxComRate:[~.3f]~n",
% 													  [Cmd, MinOrgSize,MinComSize,MinComSize / MinOrgSize, MaxOrgSize,MaxComSize,MaxComSize / MaxOrgSize]);
% 									_->
% 										''
% 								end 
% 						end, 
% 						Stat_list_socket_compress),
% 					if length(Stat_info_socket_compress) > 0 ->
% 						lists:concat(['    Socket packet_compress statistic:\t\n', Stat_info_socket_compress]);
% 			   		   true ->
% 				   		[]
% 					end			
% 			end
% 		catch
% 			_:_ -> []
% 		end,
	
% 	io:format("~s~n", [Info_stat_compress]).

% %% 获取数据库访问统计信息
% %% 参数: SortType: freq|time - 按什么类型排行（频率|耗时）
% %% 参数：DisplayCount - 显示的个数
% get_db_stat_info(SortType, DisplayCount) ->
% 	Info_stat_db = 
% 		try
% 			case ets:info(?ETS_STAT_DB) of
% 				undefined ->
% 					[];
% 				_ ->
% 					Stat_list_db = ets:match(?ETS_STAT_DB,{'$1', '$2', '$3', '$4', '$5', '$6'}),
% 					Stat_list_db_1 = case SortType of
% 										 freq ->
% 											 lists:sort(fun([_,_,_,_,Count1,_],[_,_,_,_,Count2,_]) -> Count1 > Count2 end, Stat_list_db);
% 										 time ->
% 											 lists:sort(fun([_,_,_,_,_,SqlTime1],[_,_,_,_,_,SqlTime2]) -> SqlTime1 > SqlTime2 end, Stat_list_db)
% 									 end,
% 					Stat_list_db_2 = lists:sublist(Stat_list_db_1, DisplayCount), 
% 					Stat_info_db = 
% 					lists:map( 
% 	  					fun(Stat_data) ->
% 							case Stat_data of				
% 								[_Key, Table, Operation, BeginTime, Count, SqlTime] ->
% 									TimeDiff = timer:now_diff(erlang:now(), BeginTime)/(1000*1000)+1,
% 									lists:concat(['        ','Table:[', lists:duplicate(30-length(tool:to_list(Table))," "), Table, 
% 												'], op:[', Operation,
% 												'], avg/sec:[', Count, '/',round(TimeDiff),' = ',round(Count / TimeDiff),
% 												'], time:[', SqlTime, ' us]\t\n']);
% 								_->
% 									''
% 							end 
% 	  					end, 
% 						Stat_list_db_2),
% 					if length(Stat_info_db) > 0 ->
% 						lists:concat(['    Table operation statistic_top', DisplayCount, ':\t\n', Stat_info_db]);
% 			   		   true ->
% 				   		[]
% 					end			
% 			end
% 		catch
% 			_:_ -> []
% 		end,
	
% 	io:format("~s~n", [Info_stat_db]).

% get_task_ets_info() ->
% 	[
% 	 {ets_role_task,ets:info(ets_role_task,size)}, 
% 	 {ets_role_task_chalg,ets:info(ets_role_task_chalg,size)}, 
% 	 {ets_role_task_log,ets:info(ets_role_task_log,size)},
% 	 {ets_task_query_cache,ets:info(ets_task_query_cache,size)},
% 	 {ets_task_cache,ets:info(ets_task_cache,size)}
% 	].

% get_achi_ets_info() ->
% 	[
% 	 {ets_achi_cache,ets:info(ets_achi_cache,size)},
% 	 {ets_role_achi,ets:info(ets_role_achi,size)},
% 	 {ets_role_achi_log,ets:info(ets_role_achi_log,size)}
% 	 ].


% %% 类似于inet:i()
% %% 参数：Type: size - 发送和接收的消息包大小（字节）
% %%			   count - 发送和接收的消息包数目
% %%			   pend -> 待发送数据大小（字节）
% %%		 TcpPort：监控的tcp端口（server节点是6668）
% %%		 DisplayCount: 显示的行数：all - 全部显示；N - 显示N行
% %% 注意：get_inet_info/2里的pend是只统计>0的；而get_inet_info/3里的pend是统计所有的！
% get_inet_info(Type, DisplayCount) ->
% 	Ss = if
% 			 Type == pend ->
% 				 port_list2("tcp_inet");
% 			 true ->
% 			 	 port_list("tcp_inet")
% 		 end,
% 	get_inet_info2(Ss, Type, DisplayCount).
% get_inet_info(Type, TcpPort, DisplayCount) ->
% 	Ss = port_list("tcp_inet", TcpPort),
% 	get_inet_info2(Ss, Type, DisplayCount).

	
% get_inet_info2(Ss, Type, DisplayCount) ->
% 	Fs = case Type of
% 			 size -> [port, recv, sent, owner, local_address, foreign_address, state];
% 			 count -> [port, recv_c, sent_c, owner, local_address, foreign_address, state];
% 			 pend -> [port, send_pend, owner, local_address, foreign_address, state]
% 		 end,
			 
% 	LLs0 = [h_line(Fs) | info_lines(Ss, Fs, tcp, Type)],
	
% 	LLs = if
% 			  is_integer(DisplayCount) andalso DisplayCount > 0 ->
% 				  lists:sublist(LLs0, DisplayCount);
% 			  true ->
% 				  LLs0
% 		  end,
%     Maxs = lists:foldl(
% 	     fun(Line,Max0) -> smax(Max0,Line) end, 
% 	     lists:duplicate(length(Fs),0),LLs),
%     Fmt = lists:append(["~-" ++ integer_to_list(N) ++ "s " || N <- Maxs]) ++ "\n",
%     lists:foreach(fun(Line) -> io:format(Fmt, Line) end, LLs).

% smax([Max|Ms], [Str|Strs]) ->
%     N = length(Str),
%     [if N > Max -> N; true -> Max end | smax(Ms, Strs)];
% smax([], []) -> [].

% info_lines(Ss, Fs, Proto, SortBy) -> 
% 	L = [i_line(S, Fs,Proto) || S <- Ss],
% 	case SortBy of
% 		size ->
% 			lists:sort(fun([_, Recv1, _, _, _, _, _], [_, Recv2, _, _, _, _, _]) -> list_to_integer(Recv1) > list_to_integer(Recv2) end, L);
% 		count ->
% 			lists:sort(fun([_, Recv_c1, _, _, _, _, _], [_, Recv_c2, _, _, _, _, _]) -> list_to_integer(Recv_c1) > list_to_integer(Recv_c2) end, L);
% 		pend ->
% 			lists:sort(fun([_, Recv_pend1, _, _, _, _], [_, Recv_pend2, _, _, _, _]) -> list_to_integer(Recv_pend1) > list_to_integer(Recv_pend2) end, L)
% 	end.

% i_line(S, Fs, Proto)      -> [info(S, F, Proto) || F <- Fs].

% h_line(Fs) -> [h_field(atom_to_list(F)) || F <- Fs].

% h_field([C|Cs]) -> [upper(C) | hh_field(Cs)].

% hh_field([$_,C|Cs]) -> [$\s,upper(C) | hh_field(Cs)];
% hh_field([C|Cs]) -> [C|hh_field(Cs)];
% hh_field([]) -> [].

% upper(C) when C >= $a, C =< $z -> (C-$a) + $A;
% upper(C) -> C.

    
% info(S, F, Proto) ->
%     case F of
% 	owner ->
% 	    case erlang:port_info(S, connected) of
% 		{connected, Owner} -> pid_to_list(Owner);
% 		_ -> " "
% 	    end;
% 	port ->
% 	    case erlang:port_info(S,id) of
% 		{id, Id}  -> integer_to_list(Id);
% 		undefined -> " "
% 	    end;
% 	sent ->
% 	    case prim_inet:getstat(S, [send_oct]) of
% 		{ok,[{send_oct,N}]} -> integer_to_list(N);
% 		_ -> " "
% 	    end;
% 	recv ->
% 	    case  prim_inet:getstat(S, [recv_oct]) of
% 		{ok,[{recv_oct,N}]} -> integer_to_list(N);
% 		_ -> " "
% 	    end;
% 	sent_c ->
% 		case prim_inet:getstat(S, [send_cnt]) of
% 		{ok,[{send_cnt,N}]} -> integer_to_list(N);
% 		_ -> " "
% 	    end;
% 	recv_c ->
% 	    case  prim_inet:getstat(S, [recv_cnt]) of
% 		{ok,[{recv_cnt,N}]} -> integer_to_list(N);
% 		_ -> " "
% 	    end;
% 	send_pend ->
% 		case prim_inet:getstat(S, [send_pend]) of
% 		{ok,[{send_pend,N}]} -> integer_to_list(N);
% 		_ -> " "
% 	    end;
% 	local_address ->
% 	    fmt_addr(prim_inet:sockname(S), Proto);
% 	foreign_address ->
% 	    fmt_addr(prim_inet:peername(S), Proto);
% 	state ->
% 	    case prim_inet:getstatus(S) of
% 		{ok,Status} -> fmt_status(Status);
% 		_ -> " "
% 	    end
%     end.

% %% Possible flags: (sorted)
% %% [accepting,bound,busy,connected,connecting,listen,listening,open]
% %%
% fmt_status(Flags) ->
%     case lists:sort(Flags) of
% 	[accepting | _]               -> "ACCEPTING";
% 	[bound,busy,connected|_]      -> "CONNECTED*";
% 	[bound,connected|_]           -> "CONNECTED";
% 	[bound,listen,listening | _]  -> "LISTENING";
% 	[bound,listen | _]            -> "LISTEN";
% 	[bound,connecting | _]        -> "CONNECTING";
% 	[bound,open]                  -> "BOUND";
% 	[open]                        -> "IDLE";
% 	[]                            -> "CLOSED";
% 	_                             -> "????"
%     end.

% fmt_addr({error,enotconn}, _) -> "*:*";
% fmt_addr({error,_}, _)        -> " ";
% fmt_addr({ok,Addr}, Proto) ->
%     case Addr of
% 	%%Dialyzer {0,0}            -> "*:*";
% 	{{0,0,0,0},Port} -> "*:" ++ fmt_port(Port, Proto);
% 	{{0,0,0,0,0,0,0,0},Port} -> "*:" ++ fmt_port(Port, Proto);
% 	{{127,0,0,1},Port} -> "localhost:" ++ fmt_port(Port, Proto);
% 	{{0,0,0,0,0,0,0,1},Port} -> "localhost:" ++ fmt_port(Port, Proto);
% 	{IP,Port} -> inet_parse:ntoa(IP) ++ ":" ++ fmt_port(Port, Proto)
%     end.

% fmt_port(N, Proto) ->
%     case inet:getservbyport(N, Proto) of
% 	{ok, Name} -> Name;
% 	_ -> integer_to_list(N)
%     end.

% %% Return all ports having the name 'Name'
% port_list(Name) ->
%     lists:filter(
%       fun(Port) ->
% 	      case erlang:port_info(Port, name) of
% 		  {name, Name} -> true;
% 		  _ -> false
% 	      end
%       end, erlang:ports()).
% %% Return all ports having the name 'Name' and the tcp port is 'TcpPort'
% port_list(Name, TcpPort) ->
% 	lists:filter(
% 	  fun(Port) ->
% 			  case erlang:port_info(Port, name) of
% 				  {name, Name} -> 
% 					  case get_tcp_port(Port) of
% 						  TcpPort ->
% 							  true;
% 						  _ ->
% 							  false
% 					  end;
% 				  _ -> 
% 					  false
% 			  end
% 	  end, erlang:ports()).
% %% Return all ports having the name 'Name' and send_pend is larger than zero
% port_list2(Name) ->
% 	lists:filter(
% 	  fun(Port) ->
% 			  case erlang:port_info(Port, name) of
% 				  {name, Name} -> 
% 					  	case prim_inet:getstat(Port, [send_pend]) of
% 							{ok,[{send_pend,N}]} when N >0 -> true;
% 							_ -> false
% 	    				end;
% 				  _ -> 
% 					  false
% 			  end
% 	  end, erlang:ports()).

% get_tcp_port(S) ->
% 	case prim_inet:sockname(S) of 
% 		{ok, {_IP, Port}} ->
% 			Port;
% 		{error, _Err} -> 
% 			-1
% 	end.