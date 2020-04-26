%% Author: LDS
%% Created: 2012-3-12
%% Description: 游客注册
-module(pp_visitor_reg).

% %%
% %% Include files
% %%
% -include("record.hrl").
% -include("common.hrl").
% %%
% %% Exported Functions
% %%
% -export([handle/3, check_mail/1, check_reg/4, send_reg_msg/2]).
% -define(REGISTER, "reg").  %%注册ACTION值
% -define(CHECK, "check").   %%检查重名ACTION值
% -define(PLATFORM_URL, "http://web.4399.com/api/reg/gamereg.php").  %%平台url
% -define(MD5_KEY, "34DSD-EW90F-UWELD-23853-LOCSD").   %%游客注册平台MD5 KEY
% -define(GAME_NAME, "ztj").  %%游戏名缩写


% handle(48001, Status, [Name, Password, Mail, Cid]) ->
% 	case get("reg_status") of
% 		undefined ->
% 			put("reg_status", unRegister),
% 			Lname = tool:to_list(Name),
% %% 	Lmail = tool:to_list(Mail),
% %% 	Uname = edoc_lib:escape_uri(Lname),
% %% 	Umail = edoc_lib:escape_uri(Lmail),
% 	%%调用平台接口检查重名
% 	%%用户名检查
% 			NameCheckFlag = tool:md5(lists:concat([?MD5_KEY, Lname])),
% 			Time1 = util:unixtime(),
% 			NameCheck = http_lib:url_encode([{"action", ?CHECK}, {"username", Lname}, {"time", tool:to_list(Time1)}]),
% 			CheckNameUrl = lists:concat([?PLATFORM_URL, "?", NameCheck, "&flag=", NameCheckFlag]),
% 			?TRACE("CheckNameUrl: ~p~n", [CheckNameUrl]),
% 			put("cur_http_request", check_name),
% 			put("name", Name),
% 			put("password", Password),
% 			put("mail", Mail),
% 			put("cid", Cid),
% 			misc:send_http_request(CheckNameUrl);
% 		_ ->
% 			skip
% 	end,
% 	{ok, Status};
	
% %% 	
% %% 	Flag = case misc:get_http_content(CheckNameUrl) of
% %% 		"1" ->
% %% 			%%不重名
% %% 			?TRACE("un chong ming\n"),
% %% 			Time2 = util:unixtime(),
% %% 			MailCheckFlag = tool:md5(lists:concat([?MD5_KEY, Lmail])),
% %% %% 			MailCheckFlag = tool:md5(lists:concat([?MD5_KEY, tool:to_list(Lmail)])),
% %% 			MailCheck = http_lib:url_encode([{"action", ?CHECK}, {"email", Lmail}, {"time", tool:to_list(Time2)}]),
% %% 			CheckMailUrl = lists:concat([?PLATFORM_URL, "?", MailCheck, "&flag=", MailCheckFlag]),
% %% %% 			CheckMailUrl = lists:concat([?PLATFORM_URL, "?action=check&email=", Lmail, "&time=", Time2, "&flag=", MailCheckFlag]),
% %% 			?TRACE("CheckMailUrl: ~p~n", [CheckMailUrl]),
% %% 			case misc:send_http_request(CheckMailUrl) of
% %% 				"1" ->
% %% 					?TRACE("un chong mail\n"),
% %% 					%%邮箱可用
% %% 					%%转送平台验证
% %% 					Time3 = util:unixtime(),
% %% 					RegFlag = tool:md5(lists:concat([?GAME_NAME, Lname, Lmail, ?MD5_KEY, tool:to_list(Time3), tool:to_list(Cid)])),
% %% 					Reg = http_lib:url_encode([{"action", ?REGISTER}, {"username", Lname}, 
% %% 											   {"password", tool:to_list(Password)}, {"cid", tool:to_list(Cid)}, 
% %% 											   {"game", ?GAME_NAME}, {"email", Lmail}, {"time", tool:to_list(Time3)}]),
% %% 					?TRACE("Reg: ~p~n", [Reg]),
% %% 					RegUrl = lists:concat([?PLATFORM_URL, "?", Reg, "&flag=", RegFlag]),
% %% 					?TRACE("RegUrl: ~p~n", [RegUrl]),
% %% 					misc:get_http_content(RegUrl);
% %% 				Other ->
% %% 					Other
% %% 			end;
% %% 		Other ->
% %% 			Other
% %% 	end,
% %% 	%%发送注册状态回客户端
% %% 	?TRACE("Flag:  ~p~n", [Flag]),
% %% 	{ok, BinData} = pt_48:write(48001, Flag),
% %% 	lib_send:send_one(Status#player_status.socket, BinData),
% %% 	{ok, Status};

% handle(_CMD, _Status, _Data) ->
% 	{error, "pp_visitor_reg no_match"}.


% check_mail(Mail) ->
% 	put("reg_status", handleing),
% 	?TRACE("check mail\n"),
% 	put("cur_http_request", check_mail),
% %% 	Lname = tool:to_list(Name),
% 	Lmail = tool:to_list(Mail),
% 	Time2 = util:unixtime(),
% 	MailCheckFlag = tool:md5(lists:concat([?MD5_KEY, Lmail])),
% 	MailCheck = http_lib:url_encode([{"action", ?CHECK}, {"email", Lmail}, {"time", tool:to_list(Time2)}]),
% 	CheckMailUrl = lists:concat([?PLATFORM_URL, "?", MailCheck, "&flag=", MailCheckFlag]),
% 	misc:send_http_request(CheckMailUrl).

% check_reg(Name, Password, Mail, Cid) ->
% 	put("reg_status", handleing),
% 	?TRACE("check reg\n"),
% 	put("cur_http_request", check_reg),
% 	Lname = tool:to_list(Name),
% 	Lmail = tool:to_list(Mail),
% 	Time3 = util:unixtime(),
% 	RegFlag = tool:md5(lists:concat([?GAME_NAME, Lname, Lmail, ?MD5_KEY, tool:to_list(Time3), tool:to_list(Cid)])),
% 	Reg = http_lib:url_encode([{"action", ?REGISTER}, {"username", Lname}, 
% 								{"password", tool:to_list(Password)}, {"cid", tool:to_list(Cid)}, 
% 								{"game", ?GAME_NAME}, {"email", Lmail}, {"time", tool:to_list(Time3)}]),
% 	?TRACE("Reg: ~p~n", [Reg]),
% 	RegUrl = lists:concat([?PLATFORM_URL, "?", Reg, "&flag=", RegFlag]),
% 	misc:send_http_request(RegUrl).

% send_reg_msg(Status, Flag) ->
% 	{ok, BinData} = pt_48:write(48001, Flag),
% 	lib_send:send_one(Status#player_status.socket, BinData).