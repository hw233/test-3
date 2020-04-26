-module(sm_writer).
-behaviour(gen_server).
-export([start_link/1,
		 start_link_cross/2,
		 stop_cast/1,
		 init/1,
		 handle_call/3,
		 handle_cast/2,
		 handle_info/2,
		 terminate/2,
		 code_change/3]).

-record(state, {sock, pending, bad_count, player_id = 0, is_cross = 0, server_id = 0}).

-include("global2.hrl").
-include("log2.hrl").

%% 个人觉得半秒钟检查一次即可
%% -define(MAYBE_FLUSH_INTV, 500).
-define(MAYBE_FLUSH_INTV, 45). %% 这个45是否是写错了？

-define(FLUSH_THRESHOLD, 4096).

%% -define(HIGH_WATERMARK, 65536).  % 65536: 64K
%% -define(LOW_WATERMARK,  32768).  % 32768: 32K

-define(HIGH_WATERMARK, 131072).  % 131072: 128K
-define(LOW_WATERMARK,  65536).  % 65536: 64K

-define(MAX_BAD_LIMIT, 10).


start_link(Socket) ->
	gen_server:start_link(?MODULE, Socket, []).

start_link_cross(ServerId, PlayerId) ->
	gen_server:start(?MODULE, [ServerId, PlayerId], []).

stop_cast(Pid) ->
	gen_server:cast(Pid, stop).


%% 跨服玩家镜像进程的send_pid，不需要socket，直接通过跨服rpc转发给源服务器
init([ServerId, PlayerId]) ->
	process_flag(trap_exit, true),
	{ok, #state{bad_count = 0, player_id = PlayerId, is_cross = 1, server_id = ServerId}};

init(Socket) ->
	process_flag(trap_exit, true),
	
	inet:setopts(Socket, [{high_watermark, ?HIGH_WATERMARK}, {low_watermark, ?LOW_WATERMARK}]),
	
	mod_timer:reg_loop_msg(self(), ?MAYBE_FLUSH_INTV),
	
	{ok, #state{sock = Socket, pending = [], bad_count = 0, is_cross = 0}}.

stop() ->
	gen_server:cast(self(), stop).

handle_call(_Request, _From, State) ->
	{reply, ok, State}.

handle_cast(stop, State) ->
	{stop, normal, State};

handle_cast(_Msg, State) ->
	{noreply, State}.

%% 考虑到跨服的情况，判断is_cross字段直接将数据转发到rpc通道，给远程节点响应的玩家send进程处理，还要考虑state不是state的情况？
handle_info2({send, Bin, Force}, #state{is_cross = 0} = State) ->
	Pending = State#state.pending,
	Len = byte_size(Bin),
	State2 = maybe_flush(State#state{pending = [<<Len:16, Bin/binary>> | Pending]}, Force),
																 
	{noreply, State2};

handle_info2({send, Bin, Force}, #state{player_id = PlayerId, server_id = ServerId} = State) ->
	sm_cross_server:rpc_cast(ServerId, lib_send, send_to_uid_for_cross, [PlayerId, Bin, Force]),
	{noreply, State};


handle_info2({send, Bin}, State) ->
	handle_info2({send, Bin, false}, State);


handle_info2({send_for_cross, Bin, Force}, State) ->
	Pending = State#state.pending,
	Len = byte_size(Bin),
	{noreply, maybe_flush(State#state{pending = [<<Len:16, Bin/binary>> | Pending]}, Force)};


handle_info2(doloop, State) ->
	State2 = maybe_flush(State, true),
	
	{noreply, State2};

handle_info2({SendRef, true}, State) when is_reference(SendRef) ->
	{noreply, State#state{bad_count = 0}};

handle_info2({SendRef, false}, State) when is_reference(SendRef) ->
	{noreply, check_bad_count(unknown, State)};

handle_info2({SendRef, Error}, State) when is_reference(SendRef) ->
	{noreply, check_bad_count(Error, State)};

handle_info2(_Info, State) ->
	{noreply, State}.

handle_info(Info, State) ->
	?TRY_CATCH(handle_info2(Info, State)).

terminate(Reason, _State) ->
	case Reason of
		normal -> skip;
		shutdown -> skip;
		{shutdown, _} -> skip;
		_ ->
			?ERROR_LOG("[~p] !!!!!terminate!!!!! for reason: ~w", [?MODULE, Reason])
	end,
	ok.

code_change(_OldVsn, State, _Extra) ->
	{ok, State}.


maybe_flush(State, Force) ->
	PendingSize = iolist_size(State#state.pending),
	
	case PendingSize >= ?LOW_WATERMARK of
		true ->
			?ERROR_LOG("sm_writer:maybe_flush: pending too large, process terminate. (~p > low_watermark)", [PendingSize]),
			
			stop(),  % 优化： 这里的stop实际上是异步的，目前觉得改为立即stop会更好  -- huangjf  2015.3.2
			
			State;
		false ->
			case Force of
				true ->
					procs_flush(State);
				false ->
					case PendingSize >= ?FLUSH_THRESHOLD of
						true ->
							procs_flush(State);
						false ->
							State        
					end         
			end
	end.

procs_flush(State = #state{pending = []}) ->
	State;

procs_flush(State = #state{sock = Sock, pending = Pending}) ->
	case catch erts_internal:port_command(Sock, lists:reverse(Pending), [force, nosuspend]) of
		true ->
			State#state{pending = [], bad_count = 0};
		false ->
			check_bad_count(unknown, State);
		Ref when is_reference(Ref) ->
			State#state{pending = []};
		Error ->
			check_bad_count(Error, State)
	end.

check_bad_count(Error, State = #state{bad_count = ?MAX_BAD_LIMIT}) ->
	?ERROR_LOG("sm_writer:procs_flush: error:~w, bad_count:~p/~p, process terminate.", [Error, ?MAX_BAD_LIMIT, ?MAX_BAD_LIMIT]),
	
	stop(),
	
	State;

check_bad_count(Error, State = #state{bad_count = BadCount}) ->
	?ERROR_LOG("sm_writer:procs_flush: error:~w, bad_count:~p/~p.", [Error, BadCount, ?MAX_BAD_LIMIT]),
	
	State#state{bad_count = BadCount + 1}.