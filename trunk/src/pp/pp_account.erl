%%%--------------------------------------
%%% @Module  : pp_account
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2011.05.10
%%% @Description:用户账户以及登录 （此文件已经作废！！！）
%%%--------------------------------------
-module(pp_account).
% -export([handle/3
% 		 %%validate_name/1
% 		]).


% -include("common.hrl").
% -include("pt_10.hrl").

% %%登陆验证
% handle(?PT_LOGIN_REQ, [], Data) ->
% 	% case config:need_md5_login_auth() of
% 	% 	false ->
% 	% 		true;
% 	% 	true ->
% 	% 		try is_bad_pass(Data) of
% 	% 			true -> true;
% 	% 			false -> false
% 	% 		catch
% 	% 			_:_ -> false
% 	% 		end
% 	% end;
% 	void;

% %% 获取角色列表
% handle(?PT_GET_ACC_ROLE_LIST, Socket, Accname) 
%  when is_list(Accname) ->
%  %    L = lib_account:get_role_list(Accname),
% 	% case L of
% 	% 	[] ->
% 	% 		put(is_no_role, true),
% 	% 		%%服务端返回角色列表,客户端判断列表为空则认为没有角色,自动进入创建角色页面,所以在这里记录进入创角页面记录(尚未创角成功,只记录进入创角页面状态)
% 	% 		log:log_create_page(Accname, misc:get_ip(Socket));
% 	% 	_ ->
% 	% 		skip
% 	% end,
%  %    {ok, BinData} = pt_10:write(10002, L),
%  %    lib_send:send_one(Socket, BinData);
%  	void;

% %% 创建角色
% handle(?PT_CREATE_ROLE, Socket, [Accid, Accname, Career, Sex, Name]) ->
% % when is_list(Accname), is_list(Name)->
% % 	case get(is_no_role) of %% 确认是否无角色
% % 		true ->
% % 			case validate_name(Name) of  %% 角色名合法性检测
% % 				{false, Msg} ->
% % 					{ok, BinData} = pt_10:write(10003, Msg),
% % 					lib_send:send_one(Socket, BinData);
% % 				true ->
% % 					case lib_account:create_role(Accid, Accname, Name, Realm, Career, Sex) of
% % 						{true, Id} ->
% % 							put(is_no_role, false),
% % 							%%创建角色成功
% % 							{ok, BinData} = pt_10:write(10003, 1),
% % 							lib_send:send_one(Socket, BinData),
% % 							%%记录创角日志
% % 							Ip = misc:get_ip(Socket),
% % 							log:log_register(Id, Name, Accname, Sex, Career, Ip);
% % 						false ->
% % 							%%角色创建失败
% % 							{ok, BinData} = pt_10:write(10003, 0),
% % 							lib_send:send_one(Socket, BinData)
% % 					end
% % 			end;
% % 		_ ->
% % 			?ERROR_MSG("invalid create role: accid=~p", [Accid]),
% % 			skip
% % 	end;
% 	void;

% %% 删除角色
% handle(?PT_DESTROY_ROLE, Socket, [Pid, Accname]) ->
%     % case lib_account:delete_role(Pid, Accname) of
%     %     true ->
%     %         {ok, BinData} = pt_10:write(10005, 1),
%     %         lib_send:send_one(Socket, BinData);
%     %     false ->
%     %         {ok, BinData} = pt_10:write(10005, 0),
%     %         lib_send:send_one(Socket, BinData)
%     % end;
%     void;

% %%心跳包
% handle(?PT_CONNECTION_HEARTBEAT, Socket, _) ->
%     % {ok, BinData} = pt_10:write(?PT_CONNECTION_HEARTBEAT, []),
%     % lib_send:send_one(Socket, BinData);
%     ?ASSERT(false),
%     void;

% % %% 按照accid创建一个角色，或自动分配一个角色
% % handle(10010, Socket, [Accid, Sex, Career, Name]) when is_list(Name)->
% % 	PlayerInfo = 
% % 		case Accid =:= 0 of
% % 			true -> 
% % 				[];
% % 			false -> 
% % 				db:select_row(player, "id, accname, nickname", [{accid,Accid}], [], [1])
% % 		end,
% % 	case PlayerInfo of
% % 		[Id, Accname, Nickname]->
% % 			{true, Accid, Id, binary_to_list(Accname), binary_to_list(Nickname)};
% % 		[]->
% % 			Accid2 = lib_account:get_account_id(),
% % 			Accname2 = integer_to_list(Accid2),
			
% % 			lib_account:add_user_info_guest(Accid2, Accname2),
			
% % 			%%游客模式跳过创角页面,默认已经访问过创角页面,记录访问创角页面日志
% % 			Ip = misc:get_ip(Socket),
% % 			log:log_create_page(Accname2, Ip),
% % 			Name2 = case validate_name(Name) of  %% 角色名合法性检测
% % 						{false, _} ->
% % 							lists:concat(["战天-",Accid2]);
% % 						true ->
% % 							Name
% % 					end,
% % 			case lib_account:create_role(Accid2, Accname2, Name2, 0, Career, Sex) of
% %                 {true, RoleId} -> % 创建角色成功
% % 					%%记录创角成功日志
% % 					log:log_register(Name2, Accname2, Sex, Career, Ip),
% % 					{true, Accid2, RoleId, Accname2, Name2};
% %                 false -> % 创建角色失败
% %                     {true, 0, 0, [], []}
% %             end
% % 	end;

% handle(_Cmd, _Status, _Data) ->
% 	?ASSERT(false, _Cmd),
%     %%?DEBUG_MSG("handle_account no match", []),
%     {error, "handle_account no match"}.



% % %%通行证验证
% % %%To-Do：临时关闭超时验证
% % is_bad_pass([TimeStamp, Accname, Ticket]) ->
% % %% 		Time = util:unixtime(),
% % %% 		if
% % %% 			erlang:abs(Time - TimeStamp) =< ?LOGIN_TIMEOUT ->
% % 				Md5 = Accname ++ integer_to_list(TimeStamp) ++ ?TICKET, %% ++ integer_to_list(Infant_state),
% % 				Hex = util:md5(Md5),
% % 				%%?DEBUG_MSG("~p~n~p~n", [Md5, Hex]),
% % 				Hex == Ticket.
% % %% 			true ->
% % %% 				false
% % %% 		end.





% % %% 角色名合法性检测
% % validate_name(Name) ->
% %     validate_name(len, Name).

% % %% 角色名合法性检测:长度
% % validate_name(len, Name) ->
% %     case asn1rt:utf8_binary_to_list(list_to_binary(Name)) of
% %         {ok, CharList} ->
% %             Len = string_width(CharList),    
% %             case Len < 13 andalso Len > 1 of
% %                 true ->
% %                     validate_name(existed, Name);
% %                 false ->
% %                     %%角色名称长度为1~6个汉字
% %                     {false, 5}
% %             end;
% %         {error, _Reason} ->
% %             %%非法字符
% %             {false, 4}
% %     end; 

% % %%判断角色名是否已经存在
% % %%Name:角色名
% % validate_name(existed, Name) ->
% %     case lib_player:is_exists(Name) of
% %         true ->
% %             %角色名称已经被使用
% %             {false, 3};    
% %         false ->
% %             true
% %     end;

% % validate_name(_, _Name) ->
% %     {false, 2}.

% % %% 字符宽度，1汉字=2单位长度，1数字字母=1单位长度
% % string_width(String) ->
% %     string_width(String, 0).
% % string_width([], Len) ->
% %     Len;
% % string_width([H | T], Len) ->
% %     case H > 255 of
% %         true ->
% %             string_width(T, Len + 2);
% %         false ->
% %             string_width(T, Len + 1)
% %     end.
