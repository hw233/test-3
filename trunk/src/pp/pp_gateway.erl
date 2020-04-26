%%%--------------------------------------
%%% @Module  : pp_gateway
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2011.05.10
%%% @Description:网关
%%%--------------------------------------
-module(pp_gateway).
% -export([handle/3]).
% -include("common.hrl").
% -include("record.hrl").

% %%登陆验证
% handle(60000, Status, _) ->
% %% 	io:format("~npp gamtway  60000~n"),
%     List = get_server_list(),
%     {ok, Data} = pt_60:write(60000, List),
%     lib_send:send_one(Status#player_status.socket, Data);

% handle(_Cmd, _Status, _Data) ->
%     {error, "pp_gateway no match"}.

% %% 获取服务器列表
% get_server_list() ->
%     case mod_disperse:server_list() of
%         [] ->
%             [];
%         Server ->
%             F = fun(S) ->
%                     [State, Num] = case rpc:call(S#server.node, mod_kernel, scene_and_online_state, []) of
%                                 {badrpc, _} ->
%                                     [[], 4, 0];
%                                 N ->
%                                     N
%                             end,
%                     [S#server.id, S#server.ip, S#server.port, State, Num]
%                 end,
%             [F(S) || S <- Server]
%     end.