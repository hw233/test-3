%% Author: Administrator
%% Created: 2012-3-21
%% Description: TODO: Add description to pt_admin
-module(pt_admin).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([write/2, pack/2]).

write(1018, Data) ->
	LData = tool:to_list(Data),
	Len = length(LData),
	F = fun(Name) -> 
				Bname = tool:to_binary(Name),
				BLen = byte_size(Bname),
				<<BLen:16, Bname/binary>>
		end,
	BinData = tool:to_binary([F(X) || X <- LData]), 
	{ok, pack(1018, <<Len:16, BinData/binary>>)};

write(1009, Data) ->
	LData = tool:to_list(Data),
	Len = length(LData),
	F = fun(Name) -> 
				Bname = tool:to_binary(Name),
				BLen = byte_size(Bname),
				<<BLen:16, Bname/binary>>
		end,
	BinData = tool:to_binary([F(X) || X <- LData]), 
	{ok, pack(1009, <<Len:16, BinData/binary>>)};

write(_Cmd, _Data) ->
	{error, no_match}.

pack(Cmd, Bdata) ->
	BinData = tool:to_binary(pt:pack(Cmd,Bdata)),
	Len = byte_size(BinData) + 2,
	<<Len:16, BinData/binary>>.

