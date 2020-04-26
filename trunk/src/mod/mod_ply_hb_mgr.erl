%%%-------------------------------------- 
%%% @Module: mod_ply_hb_mgr (player's heartbeat manager)
%%% @Author: huangjf
%%% @Created: 2013.6.19
%%% @Description: 玩家的心跳管理（注意：玩家的心跳间隔比较久）
%%%-------------------------------------- 
-module(mod_ply_hb_mgr).
-behaviour(gen_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([
		start_link/0,
		on_server_clock_tick/2
    ]).

-include("common.hrl").
-include("server_misc.hrl").
-include("debug.hrl").


% 玩家心跳的时间间隔（单位：毫秒），目前是420秒
% 出于性能考虑，玩家心跳时间间隔至少60秒！！
-define(HB_TIME_INTV,  (420 * 1000)).

% 玩家每XX个时钟滴答才心跳一次
-define(HB_TICK_COUNT_INTV, (?HB_TIME_INTV div ?SERVER_CLOCK_TICK_INTV)).  



%% 开启玩家心跳管理
start_link() ->
	?ASSERT(?HB_TIME_INTV >= 60000),
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).



%% 服务器时钟滴答时做对应处理
on_server_clock_tick(CurTickCount, _CurUnixTime) ->
	case CurTickCount rem ?HB_TICK_COUNT_INTV of
		0 ->
			gen_server:cast(?MODULE, {'trigger_heartbeat', CurTickCount});
		_ ->   % 未过指定间隔，不做处理
			skip
	end.


%%
%% ========================================================================
%%
 
init([]) ->
    process_flag(trap_exit, true),
    ?TRACE("mod_ply_hb_mgr init()...~n"),
    {ok, null}.


handle_call(_Msg, _From, State) ->
    {noreply, State}.


%% 触发玩家心跳
%% @para: TickCountThen => 投递消息当时的时钟滴答计数
handle_cast({'trigger_heartbeat', TickCountThen}, State) ->
			CurTickCount = svr_clock:get_tick_count(),
			case TickCountThen /= CurTickCount of
				true ->  % 若trigger_heartbeat()的处理所花的总时间比心跳间隔长，则可能执行到此分支
					?TRACE("~n~n~n!!!!!!!!!!!!!!!!!!!!![mod_ply_hb_mgr] trigger_heartbeat error!!!!!!!!!!!!!!! TickCountThen:~p, CurTickCount:~p~n", [TickCountThen, CurTickCount]),
					?WARNING_MSG("[mod_ply_hb_mgr] trigger_heartbeat error!!! TickCountThen:~p, CurTickCount:~p", [TickCountThen, CurTickCount]),
					skip;
				false ->
					case mod_svr_mgr:get_all_online_player_pids() of
						[] ->
							% ?TRACE("[mod_ply_hb_mgr] no players in server...~n"),
							skip;
						PidList ->
							PlayerCount = mod_svr_mgr:get_total_online_num(), 
							?TRACE("[mod_ply_hb_mgr] trigger heartbeat, TickCountThen:~p, CurTickCount:~p, PlayerCount:~p...~n", [TickCountThen, CurTickCount, PlayerCount]),
							
							% ?TRACE("[mod_ply_hb_mgr] trigger_heartbeat, PlayerCount: ~p...~n", [PlayerCount]),
							TimeForHandleHB_Each = (?HB_TIME_INTV - 15*1000) div PlayerCount,  % 预留了15秒
							?ASSERT(TimeForHandleHB_Each >= 0),
							trigger_heartbeat(PidList, TimeForHandleHB_Each)
					end
			end,		
	{noreply, State};			

handle_cast(_Msg, State) ->
    {noreply, State}.



  

handle_info(_Msg, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ?TRACE("[mod_ply_hb_mgr] terminate!!!! reason:~p~n", [_Reason]),
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.



%% 
%% ============================== Local Functions ================================= 
%%



%% 触发玩家的心跳
trigger_heartbeat([], _TimeForHandleHB_Each) ->
	ok;
trigger_heartbeat([PlayerPid | T], TimeForHandleHB_Each) ->
	gen_server:cast(PlayerPid, 'heartbeat'),
	timer:sleep(TimeForHandleHB_Each),   % 为避免集中处理心跳，故这里sleep一下!
	trigger_heartbeat(T, TimeForHandleHB_Each).

