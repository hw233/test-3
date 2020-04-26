
%%%------------------------------------
%%% @Module  : mod_ply_asyn (player asynchronous)
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2013.6.7
%%% @Description: 玩家的一些异步操作可以统一委托给本gen_server做处理
%%%------------------------------------
-module(mod_ply_asyn).
-behaviour(gen_server).

-export([start_link/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-export([
		db_save_data_on_heartbeat/2,
		notify_my_login_to_friends/1,
		notify_my_login_to_foes/1
	]).


-include("common.hrl").



start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).


%% 保存玩家数据到DB
db_save_data_on_heartbeat(PlayerId, NewHBCount) ->
	gen_server:cast(?MODULE, {'db_save_player_data_on_heartbeat', PlayerId, NewHBCount}).


%% 上线时通知好友
notify_my_login_to_friends(PlayerId) ->
	gen_server:cast(?MODULE, {'notify_my_login_to_friends', PlayerId}).

%% 上线时通知仇人
notify_my_login_to_foes(PlayerId) ->
	gen_server:cast(?MODULE, {'notify_my_login_to_foes', PlayerId}).
	
%% ------------------------------------------

init([]) ->
    process_flag(trap_exit, true),
    {ok, null}.


	
handle_call(_Request, _From, State) ->
    {reply, State, State}.


%% 保存玩家数据到DB
handle_cast({'db_save_player_data_on_heartbeat', PlayerId, NewHBCount}, State) ->
	case player:get_PS(PlayerId) of
		null ->
			skip;
		PS ->
			% ?TRACE("[mod_ply_asyn] db_save_player_data_on_heartbeat, PlayerId: ~p~n", [PlayerId]),
			
			% 为避免因数据库操作异常而导致本gen_server崩溃，故catch
			?TRY_CATCH(player:db_save_data_on_heartbeat(PS, NewHBCount), ErrReason)
	end,
	{noreply, State};


%% 上线时通知好友
handle_cast({'notify_my_login_to_friends', _PlayerId}, State) ->
	% TODO:
	% ...

	{noreply, State};

%% 上线时通知仇人
handle_cast({'notify_my_login_to_foes', _PlayerId}, State) ->
	% TODO:
	%  ...

	{noreply, State};

    
handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.



%% ================================ Local Functions ==================================

