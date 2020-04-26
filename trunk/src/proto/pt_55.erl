%%%-------------------------------------- 
%%% @Module: pt_53
%%% @Author: 
%%% @Created: 2012-6-11
%%% @Description: 自动挂机
%%%-------------------------------------- 
-module(pt_55).

-include("common.hrl").

-export([ read/2, write/2 ]).


%%
%% C >> S
%%

%% 自动挂机的怪物数据信息
read(55000, _) ->
    {ok, nothing};

%% 自动挂机的路线
read(55001, _) ->
    {ok, nothing};

%% 请求开始自动挂机
read(55002, _) ->
    {ok, nothing};
    
    
%% 中止自动挂机
read(55003, _) ->
    {ok, nothing};
    

%% desc: 错误处理
read(_Cmd, _Bin) ->
    ?ERROR_MSG("55 read no_match_protocol:~p", [_Cmd]),
    ?ASSERT(false, {_Cmd, _Bin}),
    {error, no_match}.





%%
%% S >> C
%%

%% 自动挂机的怪物数据信息
write(55000, MonList) ->    
    L = length(MonList),
	F = fun(Mid,Name,Type,SceneL) ->
				Len = byte_size(Name),
				L1 = length(SceneL),
				Bin1 = list_to_binary( [<<Sid:32>>||Sid<-SceneL] ),
				<<Mid:32,Len:16,Name/binary,Type:32,L1:16,Bin1/binary>>
		end,
    Bin = list_to_binary( [F(Mid,Name,Type,SceneL)||{Mid,Name,Type,SceneL}<-MonList] ),
    {ok, pt:pack(55000, <<L:16, Bin/binary>>)};

%% 自动挂机的路线信息
write(55001, SceneL) ->    
    L = length(SceneL),
    Bin = list_to_binary( [<<Scene:32>>||Scene<-SceneL] ),
    {ok, pt:pack(55001, <<L:16, Bin/binary>>)};
    
%% 请求开始自动挂机    
write(55002, RetCode) ->
	{ok, pt:pack(55002, <<RetCode:8>>)};


%% desc: 错误处理
write(_Cmd, _Data) ->
    ?ERROR_MSG("55 write no_match_protocol:~p", [_Cmd]),
    ?ASSERT(false, {_Cmd, _Data}),
    {ok, pt:pack(0, <<>>)}.
                
    
    
    
    
    
    
    
