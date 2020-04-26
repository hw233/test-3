%% Author: Administrator
%% Created: 2011-12-23
%% Description: TODO: Add description to lib_gm_erlang
-module(lib_gm_dynamic).      %% 本文件已作废！！

% -include("common.hrl").
% -include("record.hrl"). 
% -include("player.hrl").
% -include("arena.hrl").
% -include("trea_house.hrl").
% -include("protocol/pt_17.hrl").

% %%
% %% Exported Functions
% %%
% -export([
% 		 gm_execute/1
% 		 ]).

% %%
% %% API Functions
% %%
% gm_execute(String)->
% 	try
%         {Mod,Code} = dynamic_compile:from_string(input_src(String)),
% 		code:load_binary(Mod, "gm_dynamic.erl", Code),
% 		success
%     catch
%         _Type:_Error -> 
% 					  fail
%     end.

% %%
% %% Local Functions
% %%
% input_src(String) ->
% "-module(gm_dynamic).
%     -export([run/0]).
%    run() -> " ++ String ++ "
% ".


