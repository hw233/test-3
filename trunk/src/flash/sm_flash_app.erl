%%%-----------------------------------
%%% @Module  : sm_flash_app
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2011.04.15
%%% @Description: 打包程序
%%%-----------------------------------
-module(sm_flash_app).
-behaviour(application).
-export([start/2, stop/1]).  
-include("common.hrl").
-include("ets_name.hrl").

start(_Type, _Args) ->
	% 端口
    [Port] = init:get_plain_arguments(),
	
	% ets:new(?ETS_STAT_SOCKET, [named_table, public, set]), %%输出socket统计
	% ets:new(?ETS_STAT_COMPRESS, [named_table, public, set]), %%socket压缩统计
	
    sm_flash_sup:start_link([list_to_integer(Port)]).
  
stop(_State) ->   
    void.
