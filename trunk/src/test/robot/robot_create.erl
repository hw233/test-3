%% Author: Dream
%% Created: 2011-11-23
%% Description: TODO: Add description to robot_create
-module(robot_create).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([
		 start/4
		 ]).

-include("debug.hrl").

%%
%% API Functions
%%

start(Host, Port, Num, Id) ->
	F = fun({PLf, Idf})->
				robot:sleep(100), % 每隔100ms创建一个robot，以隔开
				start_robot(Host, Port, PLf, Idf)
		end,
	_RL = for(0, Num, F, {[], Id}).


start_robot(Host, Port, PidList, SeqNum) ->
	% case robot:start([N + 10000, robot_encode(N + 10000,[])]) of
	% 	{ok, Pid} ->
	% 		{[Pid | PidList], N + 1};
	% 	Error ->
	% 		io:format("error start robot~p~n",[Error]),
	% 		{PidList, N + 1}
	% end.
	AccName = lists:concat([uc_robot_, SeqNum]),
	case robot:start([Host, Port, AccName, SeqNum]) of
		{ok, Pid} ->
			{[Pid | PidList], SeqNum + 1};
		_Error ->
			?TRACE("error start robot~p~n",[_Error]),
			{PidList, SeqNum + 1}
	end.


% robot_encode(0,Result) ->
% 	Result;
% robot_encode(Num, Rt) ->
% 	Rtnew = [(Num rem 10 + 97) | Rt],
% 	robot_encode(Num div 10, Rtnew).


for(Max, Max, _F, X) ->
    X;
for(Min, Max, F, X) ->
    X1 = F(X),
    for(Min+1, Max, F, X1).