%%%-----------------------------------
%%% @Module  : sm_logger_app
%%% @Author  : Skyman Wu
%%% @Email   : 
%%% @Created : 2011.11.22
%%% @Description: 打包程序
%%%-----------------------------------
-module(sm_logger_app).
-behaviour(application).

-export([start/2, stop/1]).

start(_Type, _StartArgs) ->
	sm_logger_sup:start_link([config:get_log_file(), config:get_log_level()]).
	
stop(_State) ->
	void.