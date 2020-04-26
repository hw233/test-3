%%%------------------------------------
%%% @Module  : mod_troop
%%% @Author  : Skyman Wu
%%% @Email   : 
%%% @Created : 2011.08.21
%%% @Description: 阵法管理
%%%------------------------------------
-module(mod_troop).
% -behaviour(gen_server).
% -export([start_link/0]).
% -export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

% -export([
% 			handle_player_logout/1
% 		]).


% -include("common.hrl").
% -include("record.hrl").
% -include("ets_name.hrl").


% %% 玩家下线时从ets清除玩家的阵法
% handle_player_logout(PlayerId) ->
% 	% TODO: 确认这里的cast是否有问题（和对应玩家的进程销毁需要考虑时间上的同步关系么？）
% 	gen_server:cast(?MODULE, {'handle_player_logout', PlayerId}).
	
% %% -------------------------------------------------------------------------
% start_link() ->
%     gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

% init([]) ->
%     process_flag(trap_exit, true),
%     {ok, none}.


	
% handle_call(_Request, _From, State) ->
%     {reply, State, State}.
    
% %% 玩家下线时从ets清除玩家的阵法
% handle_cast({'handle_player_logout', PlayerId}, State) ->
% 	?TRACE("mod_troop: handle_player_logout, player id :~p~n", [PlayerId]),
% 	Pattern = #ets_player_troop{player_id = PlayerId, _ = '_'},
%     ets:match_delete(?ETS_PLAYER_TROOP, Pattern),
% 	{noreply, State};
    
% handle_cast(_Msg, State) ->
%     {noreply, State}.

% handle_info(_Info, State) ->
%     {noreply, State}.

% terminate(_Reason, _State) ->
%     ok.

% code_change(_OldVsn, State, _Extra) ->
%     {ok, State}.



% %%-------------------------------------------------------------------------------------------------


