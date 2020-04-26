%%%-----------------------------------
%%% @Module  : pt_10
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2011.04.29
%%% @Description: 10帐户信息
%%%-----------------------------------
-module(pt_10).
-export([read/2, write/2]).

-include("common.hrl").
-include("pt_10.hrl").

%%
%%客户端 -> 服务端 ----------------------------
%%

%%请求登录
read(?PT_LOGIN_REQ, <<TimeStamp:32, Bin/binary>>) ->
    ?TRACE("PT_LOGIN_REQ, Bin: ~p~n", [Bin]),
    {AccName, Bin1} = pt:read_string(Bin),
    {Md5AuthStr, Bin2} = pt:read_string(Bin1),
    {PhoneModelStr, Bin3} = pt:read_string(Bin2),
    {PhoneMAC_Str, Bin4} = pt:read_string(Bin3),
    <<FromServerId:32>> = Bin4,

	%io:format("=== PT_LOGIN_REQ: Infant=~p, AccName=~s, TimeStamp=~p, Md5AuthStr=~s ===~n", [Infant, AccName, TimeStamp, Md5AuthStr]),
    ?TRACE("[pt_10] read PT_LOGIN_REQ: TimeStamp=~p, AccName=~p, Md5AuthStr=~p, PhoneModelStr=~p, PhoneMAC_Str:~p, FromServerId:~p~n", [TimeStamp, AccName, Md5AuthStr, PhoneModelStr, PhoneMAC_Str, FromServerId]),
    {ok, ?PT_LOGIN_REQ, [TimeStamp, AccName, Md5AuthStr, PhoneModelStr, PhoneMAC_Str, FromServerId]};

%%退出游戏
% read(10001, _) ->
%     ?ASSERT(false),
%     {ok, logout};
    

%%获取账户下的角色列表
read(?PT_GET_ACC_ROLE_LIST, _R) ->
    {ok, ?PT_GET_ACC_ROLE_LIST, dummy};

%%创建角色
read(?PT_CREATE_ROLE, <<Race:8, Sex:8, Bin/binary>>) ->
    % TODO: 考虑这里需要提前对Bin的合法性（例如：长度检测）做检测？？-- 目前认为没必要 huangjf
    {Name, _} = pt:read_string(Bin),
    {ok, ?PT_CREATE_ROLE, [Race, Sex, Name]};
    

%%选择角色进入游戏
read(?PT_ENTER_GAME, <<Id:64>>) ->
    {ok, ?PT_ENTER_GAME, Id};


read(?PT_CHECK_ROLE_NAME_REPEAT, Bin) ->
    {Name, _} = pt:read_string(Bin),
    {ok, ?PT_CHECK_ROLE_NAME_REPEAT, [Name]};

%%删除角色
read(?PT_DISCARD_ROLE, <<TargetRoleId:64>>) ->
    {ok, TargetRoleId};   % 注意：现在删除角色不是在登录流程中删除，而是在进入游戏后通过对话npc删除，故这里须返回{ok, XXX}的形式！
                          % 详见sm_reader中的do_parse_packet()函数

%%心跳包
read(?PT_CONNECTION_HEARTBEAT, _) ->
    {ok, heartbeat};        % 注意：这里有点不同，必须返回 {ok, XXX}的形式! 因为进入游戏后客户端也会发心跳包，而进入游戏后routing()的结果须是{ok, XXX}的形式才认为是合法的，
                            % 详见sm_reader中的do_parse_packet()函数
    
% %% 游客模式：按照accid创建一个角色，或自动分配一个角色(accid=0)
% read(10010, <<Accid:32, Sex:8, Career:8, Bin/binary>>) ->
% 	case config:get_guest_mode() of
% 		1 ->
% 			{Name1, _} = pt:read_string(Bin),
% 			{ok, new_role, [Accid, Sex, Career, Name1]};
% 		0 ->
% 			{error, guest_mode_close}
% 	end;

read(?PT_QUERY_SERVER_TIMESTAMP, _) ->
    {ok, dummy};


read(?PT_C2S_NOTIFY_INIT_DONE, _) ->
    {ok, dummy};


read(?PT_MODIFY_ROLE_NAME, <<GoodsId:64, Bin/binary>>) ->
    {Name, _} = pt:read_string(Bin),
    {ok, [GoodsId, Name]};


read(?PT_ACCOUNT_BIND_STATE, <<>>) ->
	{ok, []};


read(?PT_ACCOUNT_BIND_PHONE_SMS, BinMsg) ->
	{Mobile, _Left} = pt:read_string(BinMsg),
	{ok, [Mobile]};


read(?PT_ACCOUNT_BIND_PHONE_CONFIRM, BinMsg) ->
	{Mobile, BinMsg2} = pt:read_string(BinMsg),
	<<Code:32>> = BinMsg2,
	{ok, [Mobile, Code]};     


read(?PT_FEEDBACK, <<Type:8, Bin/binary>>) ->
    {Opinion, _} = pt:read_string(Bin),
    {ok, [Type, Opinion]};
	 

read(_Cmd, _R) ->
    ?ASSERT(false, {_Cmd, _R}),
    {error, not_match}.

%%
%%服务端 -> 客户端 ------------------------------------
%%

%%网关登陆
write(9999, [Host, Port]) ->
    HL = byte_size(Host),
    Data = <<HL:16, Host/binary, Port:16>>,
    {ok, pt:pack(9999, Data)};

%%玩家请求登录
write(?PT_LOGIN_REQ, RetCode) ->
    Data = <<RetCode:8>>,
    {ok, pt:pack(?PT_LOGIN_REQ, Data)};

% %%退出游戏
% write(10001, _) ->
%     ?ASSERT(false),
%     Data = <<>>,
%     {ok, pt:pack(10001, Data)};

%% 打包角色列表
write(?PT_GET_ACC_ROLE_LIST, [RetCode, []]) ->
    N = 0,
    LB = <<>>,
    {ok, pt:pack(?PT_GET_ACC_ROLE_LIST, <<RetCode:8, N:16, LB/binary>>)};
write(?PT_GET_ACC_ROLE_LIST, [RetCode, L]) ->
    N = length(L),

    %  "id, local_id, is_banned, vip_lv, vip_expire_time, nickname, race, faction, sex, lv", 
    F = fun([RoleId, RoleLocalId, _FromServerId, IsBanned, _VipLv, _VipExpireTime, Name, Race, Faction, Sex, Lv]) ->
            ?TRACE("write PT_GET_ACC_ROLE_LIST, Name:~p~n", [Name]),
            NameLen = byte_size(Name),
            <<RoleId:64, RoleLocalId:32, IsBanned:8, Race:8, Faction:8, Sex:8, Lv:16, NameLen:16, Name/binary>>
        end,
    LB = list_to_binary([F(X) || X <- L]),
    {ok, pt:pack(?PT_GET_ACC_ROLE_LIST, <<RetCode:8, N:16, LB/binary>>)};

%%创建角色
write(?PT_CREATE_ROLE, [RetCode, NewRoleId, NewRoleLocalId, Race, Sex, Name]) ->
    ?ASSERT(is_list(Name)),
    NameBin = list_to_binary(Name),
    Data = <<RetCode : 8,
            NewRoleId : 64,
            NewRoleLocalId : 32,
            Race: 8,
            Sex: 8,
            (byte_size(NameBin)): 16,
            NameBin / binary
            >>,
    {ok,  pt:pack(?PT_CREATE_ROLE, Data)};

%%选择角色进入游戏
write(?PT_ENTER_GAME, [RetCode, RoleId]) ->
    Data = <<RetCode:8, RoleId:64>>,
    ?TRACE("resp PT_ENTER_GAME: RetCode=~p RoleId=~p!!!!!~n", [RetCode, RoleId]),
    {ok, pt:pack(?PT_ENTER_GAME, Data)};

%%删除角色
write(?PT_DISCARD_ROLE, [RetCode, TargetRoleId]) ->
    Data = <<RetCode:8, TargetRoleId:64>>,
    {ok, pt:pack(?PT_DISCARD_ROLE, Data)};

%%心跳包
write(?PT_CONNECTION_HEARTBEAT, _) ->
    Data = <<>>,
    {ok, pt:pack(?PT_CONNECTION_HEARTBEAT, Data)};

%% 通知客户端：账户在别处登录了
write(?PT_NOTIFY_ACC_RELOGIN, _) ->
    Data = <<>>,
    {ok, pt:pack(?PT_NOTIFY_ACC_RELOGIN, Data)};

% %% 游客模式， 返回：按照accid创建一个角色，或自动分配一个角色(accid=0)
% write(10010, [NewAccid, RoleId, NewRolename, Code]) ->
%     Rolename1 = tool:to_binary(NewRolename),
%     NLen = byte_size(Rolename1),	
%     Data = <<NewAccid:32,
% 			 RoleId:32,
% 			 NLen:16, 
% 			 Rolename1/binary,
% 			 Code:16>>,	
%     {ok, pt:pack(10010, Data)};

write(?PT_QUERY_SERVER_TIMESTAMP, [TimeStamp]) ->
    {ok, pt:pack(?PT_QUERY_SERVER_TIMESTAMP, <<TimeStamp:32>>)};


write(?PT_NOTIFY_WILL_BE_FORCE_DISCONN_SOON, [ReasonCode]) ->
    {ok, pt:pack(?PT_NOTIFY_WILL_BE_FORCE_DISCONN_SOON, <<ReasonCode:8>>)};


write(?PT_MODIFY_ROLE_NAME, [RetCode, Name]) ->
    {ok, pt:pack(?PT_MODIFY_ROLE_NAME, <<RetCode:8, (byte_size(Name)):16, Name/binary>>)};    


write(?PT_CHECK_ROLE_NAME_REPEAT, [RetCode]) ->
	{ok, pt:pack(?PT_CHECK_ROLE_NAME_REPEAT, <<RetCode:8>>)};    

write(?PT_ACCOUNT_BIND_STATE, [Ret]) ->
	{ok, pt:pack(?PT_ACCOUNT_BIND_STATE, <<Ret:8>>)};


write(?PT_ACCOUNT_BIND_PHONE_SMS, []) ->
	{ok, pt:pack(?PT_ACCOUNT_BIND_PHONE_SMS, <<>>)};


write(?PT_ACCOUNT_BIND_PHONE_CONFIRM, []) ->
	{ok, pt:pack(?PT_ACCOUNT_BIND_PHONE_CONFIRM, <<>>)};


write(?PT_FEEDBACK, []) ->
	{ok, pt:pack(?PT_FEEDBACK, <<>>)};


write(_Cmd, _R) ->
    ?ASSERT(false, {_Cmd, _R}),
    {error, not_match}.