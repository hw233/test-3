%% Author: LDS
%% Created: 2012-3-12
%% Description: 游客注册
-module(pt_48).

% %%
% %% Include files
% %%

% %%
% %% Exported Functions
% %%
% -export([read/2, write/2]).

% read(48001, <<Cid:16, BinData/binary>>) ->
% 	{Name, Ret1} = pt:read_string(BinData),
% 	{Password, Ret2} = pt:read_string(Ret1),
% 	{Mail, _} = pt:read_string(Ret2),
% 	{ok, [Name, Password, Mail, Cid]};

% read(_CMD, _BinData) ->
% 	{error, no_match}.

% write(48001, Flag) ->
% 	IntFlag = tool:to_integer(Flag),
% 	{ok, pt:pack(48001, <<IntFlag:8>>)};

% write(_CMD, _Data) ->
% 	{ok, pt:pack(0, <<>>)}.

