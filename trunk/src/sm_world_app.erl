%%%-----------------------------------
%%% @Module  : sm_world_app
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2011.11.30
%%% @Description: 打包程序
%%%-----------------------------------
-module(sm_world_app).
-behaviour(application).
-export([start/2, stop/1]).
-include("ets_name.hrl").

start(normal, []) ->
	db:init_db(world),
	util:conn_logger_node(world),
	util:conn_gateway_node(world),
	loglevel:set(logger_h:log_level()),
	
	ets:new(?ETS_STAT_DB, [set, public, named_table]), %%数据库访问统计
	
    {ok, SupPid} =sm_sup:start_link(),
    sm_networking:start_world(),
    {ok, SupPid}.
  
stop(_State) ->   
    void.