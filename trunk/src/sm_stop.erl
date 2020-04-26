%%%--------------------------------------
%%% @Module  : sm_stop
%%% @Author  : Skyman Wu
%%% @Email   :
%%% @Created : 2011.12.29
%%% @Description:  集群停止
%%%--------------------------------------
-module(sm_stop).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([stop_cluster/0]).

%%
%% API Functions
%%
stop_cluster() ->
	erlang:put(exit_code, 0),

	NodeList = init:get_plain_arguments(),
	F = fun(StrNode) ->
				 Node = list_to_atom(StrNode),
				 net_adm:ping(Node),

				 % case string:str(StrNode, "sm_flash") == 1 of
					%  true ->
					% 	 io:format("Stopping flash server...~n"),
					% 	 rpc:call(Node, sm, flash_stop, []);
					%  false ->
					% 	 skip
				 % end,

				 % case string:str(StrNode, "sm_logger") == 1 of
					%  true ->
					% 	 io:format("Stopping logger server...~n"),
					% 	 rpc:call(Node, sm, logger_stop, []);
					%  false ->
					% 	 skip
				 % end,

				 % case string:str(StrNode, "sm_gateway") == 1 of
					%  true ->
					% 	 io:format("Stopping gateway server...~n"),
					% 	 rpc:call(Node, sm, gateway_stop, []);
					%  false ->
					% 	 skip
				 % end,

				 case string:str(StrNode, "simworld") == 1 of  % 世界节点
					true ->
						io:format("Stopping world server...~n"),
						rpc:call(Node, sm, world_stop, []);
					false ->
						skip
				 end,

				 case string:str(StrNode, "simserver") == 1 of % 游戏服节点
					 true ->
						io:format("Stopping game server...~n"),
						case catch rpc:call(Node, sm, server_stop, []) of
                                {'EXIT', Reason} ->
                                        io:format("Error: reason:~p~n", [Reason]),
                                        erlang:put(exit_code, 1);
                                0 ->
                                        pass;
                                _ ->
                                        erlang:put(exit_code, 1)
                        end,

                        rpc:call(Node, sm, server_shutdown, []);
					 false ->
						 skip
				 end
		 end,

	[F(StrNode) || StrNode <- NodeList],
	erlang:halt( erlang:get(exit_code) ).






%%
%% Local Functions
%%

