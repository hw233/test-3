%%%-----------------------------------
%%% @Module  : sm_logger_sup
%%% @Author  : Skyman Wu
%%% @Email   : 
%%% @Created : 2011.11.22
%%% @Description: 监控树
%%%-----------------------------------
-module(sm_logger_sup).
-behaviour(supervisor).
-include("common.hrl").

-export([start_link/1 ,init/1]).

start_link([Log_file, Log_level]) ->
	supervisor:start_link({local, ?MODULE}, ?MODULE, [Log_file, Log_level]).

init([Log_file, Log_level]) ->
	{ok, {{one_for_one, 10, 10}, [
		{?LOGMODULE, {logger_h, start_link, [Log_file, Log_level]}, permanent, 5000, worker, dynamic}
	]}}.
