-module(access_queue_svr).
-behaviour(gen_server).
-export([start_link/0, 
         init/1, 
         handle_call/3, 
         handle_cast/2, 
         handle_info/2, 
         terminate/2, 
         code_change/3,
         access/4,
         exit/2,
         query_index/1,
         set_max_play_ol_num/2,
         query_online_info/1,
         broadcast/1,
         bcast_restart/0,
         bcast_dist/3,
         bcast_loop/1]).

-record(state, {bdist_pid, dync_tune_max_ol}).

-include("global2.hrl").
-include("log2.hrl").
-include("access_queue.hrl").
-include("pt_10.hrl").
-include("pt_61.hrl").

%-define(WRITE_LOG(Format, Args), ?DEBUG_LOG(Format, Args)).
-define(WRITE_LOG(_Format, _Args), pass).

-define(BCAST_USE_ETS, app_opt:get_env(bcast_use_ets, false)).

-define(BCAST_PROCS_NUM, app_opt:get_env(bcast_procs_num, 100)).

start_link() ->
        {ok, Pid} = gen_server:start_link({local, ?MODULE}, ?MODULE, dummy, []),

        nosql:set(system, access_queue, Pid),

        {ok, Pid}.

init(_Dummy) ->
        process_flag(trap_exit, true),
        
        load_data(),
        
        case nosql:exists(access_queue, dync_tune_max_ol) of
                true ->
                        pass;
                false ->
                        nosql:set(access_queue, dync_tune_max_ol, ?ACC_QUEUE_DYNC_TUNE)
        end,

        DyncTuneMaxOl = nosql:get(access_queue, dync_tune_max_ol),

        case nosql:exists(access_queue, max_play_ol_num) of
                true ->
                        pass;
                false ->
                        case DyncTuneMaxOl of
                                true ->
                                        nosql:set(access_queue, max_play_ol_num, ?MIN_PLAY_OL_NUM);
                                false ->
                                        nosql:set(access_queue, max_play_ol_num, ?NOR_PLAY_OL_NUM)
                        end
        end,

        PlayOlDict = 
        case nosql:get(access_queue, play_ol_dict) of
                undef ->
                        nosql:set(access_queue, play_ol_dict, hash_dict:new()),

                        hash_dict:new();
                Other ->
                        Other
        end,

        mod_timer:reg_loop_msg(self(), ?ACC_QUEUE_TUNE_INTV),

        BcastPids = 
        lists:foldl(fun(_, State) ->
                        BcastPid = spawn_link(fun() -> bcast_loop(PlayOlDict) end),

                        lists:append(State, [BcastPid])
                    end, 
                    [], lists:duplicate(?BCAST_PROCS_NUM, 0)),

        BdistPid = spawn_link(fun() ->
                                bcast_dist(PlayOlDict, BcastPids, BcastPids)
                              end),

        catch register(access_queue_svr_bdist, BdistPid),

        {ok, #state{bdist_pid = BdistPid,
                    dync_tune_max_ol = DyncTuneMaxOl}}.

handle_call(_Request, _From, State) -> 
        {reply, ok, State}.

%%进入处理
handle_cast({access, Sock, SockAlias, Reader, AccIdent, AccArgs}, State) ->
        PlayOlNum = get(play_ol_num),

        WaitQueue = get(wait_queue),

        WaitNum = length(WaitQueue),

        MaxPlayOlNum = nosql:get(access_queue, max_play_ol_num),

        case PlayOlNum < MaxPlayOlNum of
                true ->
					%% 消息队列服务这里需要对抢占登录做个请求限制，丢弃掉5秒内的do_enter_game请求？
					case check_enter_often(AccIdent, AccArgs) of
						false ->
							[AccArgs2] = AccArgs,
							Key = {do_enter_game, AccArgs2},
							Ts = util:unixtime(),
							erlang:put(Key, Ts),
							%% 在进程字典里判断进入游戏时间戳，丢弃5秒内的请求
							Reader ! {login_lost, [?PT_ENTER_GAME, {error, server_busy}]},
							
							?ERROR_LOG("[access_queue] login ignore too often AccIdent : ~p AccArgs : ~p", [AccIdent, AccArgs]);
						true ->
%% 						_ ->
							Reader ! {AccIdent, AccArgs},
							
							PlayOlNum2 = PlayOlNum + 1,
							
							put(play_ol_num, PlayOlNum2),
							
							State#state.bdist_pid ! {enter, Sock},
							
							?WRITE_LOG("[access_queue] client(~p) access success. (current online: ~p/~p, current wait: ~p/~p)", 
									   [SockAlias, PlayOlNum2, MaxPlayOlNum, WaitNum, ?MAX_WAIT_OL_NUM])
					end;
                false ->
                        case WaitNum < ?MAX_WAIT_OL_NUM of
                                true ->
                                        put(wait_queue, lists:append(WaitQueue, [{Sock, SockAlias, WaitNum + 1, {Reader, AccIdent, AccArgs}}])),

                                        WaitNum2 = WaitNum + 1,

                                        send_msg(Sock, ?PT_ACC_QUEUE_START_WAIT, [WaitNum2, PlayOlNum]),

                                        ?WRITE_LOG("[access_queue] client(~p) put in wait_queue. (current online: ~p/~p, current wait: ~p/~p)", 
                                                    [SockAlias, PlayOlNum, MaxPlayOlNum, WaitNum2, ?MAX_WAIT_OL_NUM]);
                                false ->
                                        send_msg(Sock, ?PT_ACC_QUEUE_SERVER_FULL, null, true),

                                        Reader ! {login_lost, [?PT_ENTER_GAME, {error, server_full}]},

                                        ?WRITE_LOG("[access_queue] client(~p) kicked because server full. (current online: ~p/~p, current wait: ~p/~p)", 
                                                    [SockAlias, PlayOlNum, MaxPlayOlNum, WaitNum, ?MAX_WAIT_OL_NUM])
                        end
        end,

        {noreply, State};

%%退出处理
handle_cast({exit, Sock, _SockAlias}, State) ->
        WaitQueue = get(wait_queue),

        WaitNum = length(WaitQueue),

        PlayOlNum = get(play_ol_num),

        _MaxPlayOlNum = nosql:get(access_queue, max_play_ol_num),

        RmIndex = 
        case lists:keyfind(Sock, 1, WaitQueue) of
                false ->
                        State#state.bdist_pid ! {leave, Sock},

                        nosql:del(sock_user_map, Sock), 

                        case WaitNum > 0 of
                                true ->
                                        {Sock2, _SockAlias2, 1, {Reader, AccIdent, AccArgs}} = lists:nth(1, WaitQueue),

                                        Reader ! {AccIdent, AccArgs},

                                        State#state.bdist_pid ! {enter, Sock2},

                                        ?WRITE_LOG("[access_queue] client(~p) access because client(~p) exit. (current online: ~p/~p, current wait: ~p/~p)", 
                                                    [_SockAlias2, _SockAlias, PlayOlNum, _MaxPlayOlNum, WaitNum, ?MAX_WAIT_OL_NUM]),

                                        1;
                                false ->
                                        PlayOlNum2 = PlayOlNum - 1,

                                        put(play_ol_num, PlayOlNum2),

                                        ?WRITE_LOG("[access_queue] client(~p) exit. (current online: ~p/~p, current wait: ~p/~p)", 
                                                    [_SockAlias, PlayOlNum2, _MaxPlayOlNum, WaitNum, ?MAX_WAIT_OL_NUM]),

                                        0
                        end;
                {_Sock3, _SockAlias3, Index, _Detail} ->
                        ?WRITE_LOG("[access_queue] client(~p) exit from wait_queue. (current online: ~p/~p, current wait: ~p/~p)", 
                                    [_SockAlias3, PlayOlNum, _MaxPlayOlNum, WaitNum, ?MAX_WAIT_OL_NUM]),

                        Index
        end,

        case RmIndex == 0 of
                true ->
                        pass;
                false ->
                        WaitQueue2 = 
                        my_eapi:lists_foreach(WaitQueue, 
                                              fun({Sock4, SockAlias4, Index2, Detail2}, WaitQueue3) ->
                                                WaitQueue4 = 
                                                case Index2 < RmIndex of
                                                        true ->
                                                                lists:append(WaitQueue3, [{Sock4, SockAlias4, Index2, Detail2}]);
                                                        false ->
                                                                case Index2 == RmIndex of
                                                                        true ->
                                                                                WaitQueue3;
                                                                        false ->
                                                                                lists:append(WaitQueue3, [{Sock4, SockAlias4, Index2 - 1, Detail2}])
                                                                end
                                                end,

                                                WaitQueue4
                                              end,
                                              []),

                        put(wait_queue, WaitQueue2),

                        ?WRITE_LOG("[access_queue] wait_queue reconstruct. (current online: ~p/~p, current wait: ~p/~p)", 
                                    [PlayOlNum, _MaxPlayOlNum, length(WaitQueue2), ?MAX_WAIT_OL_NUM])
        end,

        {noreply, State};
        
%%查询索引
handle_cast({query_index, Sock}, State) ->
        WaitQueue = get(wait_queue),

        case lists:keyfind(Sock, 1, WaitQueue) of
                false ->
                        pass;
                {_Sock2, _SockAlias, Index, _Detail} ->
                        PlayOlNum = get(play_ol_num),
                        
                        send_msg(Sock, ?PT_ACC_QUEUE_QUERY_INDEX, [Index, PlayOlNum])
        end,

        {noreply, State};

%%修改上限
handle_cast({set_max_play_ol_num, _Sock, 0}, State) ->
        nosql:set(access_queue, dync_tune_max_ol, true),

        {noreply, State#state{dync_tune_max_ol = true}};

handle_cast({set_max_play_ol_num, Sock, MaxPlayOlNum}, State) ->
        OldMaxPlayOlNum = nosql:get(access_queue, max_play_ol_num),

        PlayOlNum = get(play_ol_num),

        SysMaxPlayOlNum = ?MAX_PLAY_OL_NUM,

        case (MaxPlayOlNum >= PlayOlNum) and (MaxPlayOlNum =< SysMaxPlayOlNum) of
                true ->
                        nosql:set(access_queue, max_play_ol_num, MaxPlayOlNum),

                        ReleaseNum = MaxPlayOlNum - OldMaxPlayOlNum,

                        WaitQueue = get(wait_queue),
                                        
                        WaitNum = length(WaitQueue),

                        case (ReleaseNum > 0) and (WaitNum > 0) of
                                true ->
                                        ?WRITE_LOG("[access_queue] will release ~p clients from wait_queue. (current online: ~p/~p, current wait: ~p/~p)", 
                                                    [ReleaseNum, PlayOlNum, MaxPlayOlNum, WaitNum, ?MAX_WAIT_OL_NUM]),

                                        WaitQueue = get(wait_queue),

                                        {WaitQueue2, _} = 
                                        my_eapi:lists_foreach(WaitQueue, 
                                                              fun({Sock2, SockAlias, Index, {Reader, AccIdent, AccArgs}}, {WaitQueue3, PlayOlNum2}) ->
                                                                case Index =< ReleaseNum of
                                                                        true ->
                                                                                Reader ! {AccIdent, AccArgs},

                                                                                PlayOlNum3 = PlayOlNum2 + 1,

                                                                                put(play_ol_num, PlayOlNum3),

                                                                                State#state.bdist_pid ! {enter, Sock2},

                                                                                ?WRITE_LOG("[access_queue] client(~p) access by wait_queue pop(~p). (current online: ~p/~p, current wait: ~p/~p)", 
                                                                                           [SockAlias, Index, PlayOlNum3, MaxPlayOlNum, WaitNum, ?MAX_WAIT_OL_NUM]),

                                                                                {WaitQueue3, PlayOlNum3};
                                                                        false ->
                                                                                {lists:append(WaitQueue3, [{Sock2, SockAlias, Index - ReleaseNum, {Reader, AccIdent, AccArgs}}]), PlayOlNum2}
                                                                end
                                                              end,
                                                              {[], PlayOlNum}),

                                        put(wait_queue, WaitQueue2),

                                        ?WRITE_LOG("[access_queue] wait_queue reconstruct. (current online: ~p/~p, current wait: ~p/~p)", 
                                                    [get(play_ol_num), MaxPlayOlNum, length(WaitQueue2), ?MAX_WAIT_OL_NUM]);
                                false ->
                                        pass
                        end;
                false ->
                        pass
        end,

        case Sock of
                null ->
                        {noreply, State};
                _Other ->
                        send_msg(Sock, ?PT_ACC_QUEUE_GET_OL_INFO, 
                                 [get(play_ol_num), nosql:get(access_queue, max_play_ol_num), 
                                  length(get(wait_queue)), ?MAX_WAIT_OL_NUM]),

                        nosql:set(access_queue, dync_tune_max_ol, false),

                        {noreply, State#state{dync_tune_max_ol = false}}
        end;

handle_cast({query_online_info, Sock}, State) ->
        PlayOlNum = get(play_ol_num),
        MaxPlayOlNum = nosql:get(access_queue, max_play_ol_num),

        WaitQueue = get(wait_queue),
        WaitNum = length(WaitQueue),

        send_msg(Sock, ?PT_ACC_QUEUE_GET_OL_INFO, [PlayOlNum, MaxPlayOlNum, WaitNum, ?MAX_WAIT_OL_NUM]),

        {noreply, State};

handle_cast({bcast, Data}, State) ->
        State#state.bdist_pid ! {bcast, Data},

        {noreply, State};

handle_cast(restart_bcast, State) ->
        case catch restart_bcast(State) of
                {'EXIT', Reason} ->
                        ?ERROR_LOG("access_queue_svr:handle_cast restart error:~p", [Reason]),

                        {noreply, State};
                State2 ->
                        {noreply, State2}
        end;

handle_cast(Msg, State) ->
        {reply, _Reply, State2} = handle_call(Msg, unknown, State),

        {noreply, State2}.

handle_info(doloop, #state{dync_tune_max_ol = true} = State) ->
        PlayOlNum = get(play_ol_num),

        WaitQueue = get(wait_queue),
        WaitNum = length(WaitQueue),

        MinPlayOlNum = ?MIN_PLAY_OL_NUM,

        WaitCval = ?CALC_WAIT_CVAL(PlayOlNum),
        PlayCval = ?CALC_PLAY_CVAL(nosql:get(access_queue, max_play_ol_num)),

        ?WRITE_LOG("[access_queue] doloop dync_tune_max_ol wait_num:~p, wait_cval:~p, play_cval:~p", [WaitNum, WaitCval, PlayCval]),

        if 
                WaitNum >= WaitCval ->
                        NewMaxPlayOlNum = ?CALC_ADD_MAX_OL(PlayOlNum, WaitNum),

                        ?WRITE_LOG("[access_queue] doloop dync_tune_max_ol case:0, value:~p", [NewMaxPlayOlNum]),

                        handle_cast({set_max_play_ol_num, null, NewMaxPlayOlNum}, State);
                WaitNum == 0, PlayOlNum > MinPlayOlNum, PlayOlNum =< PlayCval ->
                        _NewMaxPlayOlNum = ?CALC_SUB_MAX_OL(PlayOlNum),

                        ?WRITE_LOG("[access_queue] doloop dync_tune_max_ol case:1, value:~p", [_NewMaxPlayOlNum]),

                        handle_cast({set_max_play_ol_num, null, ?CALC_SUB_MAX_OL(PlayOlNum)}, State);
                true ->
                        ?WRITE_LOG("[access_queue] doloop dync_tune_max_ol case:2", []),

                        pass
        end,

        {noreply, State};

handle_info(_Info, State) ->
        {noreply, State}.

terminate(_Reason, State) ->
        State#state.bdist_pid ! exit,

        save_data(),

        ok.

code_change(_OldVsn, State, _Extra) ->
        {ok, State}.

restart_bcast(State) ->
        PlayOlDict = 
        nosql:foldl(fun(Sock, _, PlayOlDict2) ->
                        hash_dict:set(PlayOlDict2, Sock, 0)
                    end,
                    hash_dict:new(), sock_user_map),

        BcastPids = 
        lists:foldl(fun(_, State2) ->
                        BcastPid = spawn_link(fun() -> bcast_loop(PlayOlDict) end),

                        lists:append(State2, [BcastPid])
                    end, 
                    [], lists:duplicate(?BCAST_PROCS_NUM, 0)),

        BdistPid = spawn_link(fun() ->
                                bcast_dist(PlayOlDict, BcastPids, BcastPids)
                              end),

        catch unregister(access_queue_svr_bdist),

        catch register(access_queue_svr_bdist, BdistPid),

        State#state{bdist_pid = BdistPid}.

%%保存数据
save_data() ->
        nosql:set(access_queue, play_ol_num, get(play_ol_num)),
        nosql:set(access_queue, wait_queue, get(wait_queue)).

%%读取数据
load_data() ->
        case nosql:get(access_queue, play_ol_num) of
                undef ->
                        put(play_ol_num, 0);
                PlayOlNum ->
                        put(play_ol_num, PlayOlNum) 
        end,

        case nosql:get(access_queue, wait_queue) of
                undef ->
                        put(wait_queue, []);
                WaitQueue ->
                        put(wait_queue, WaitQueue)
        end.

%%发送数据
send_msg(Sock, PtID, Content, Force) ->
        {ok, Data} = pt_61:write(PtID, Content),

        case nosql:get(sock_writer_map, Sock) of
                undef ->
                        pass;
                SendPid ->
                        SendPid ! {send, Data, Force}
        end.

send_msg(Sock, PtID, Content) ->
        send_msg(Sock, PtID, Content, true).

access(Sock, SockAlias, AccIdent, AccArgs) ->
        AccessQueue = nosql:get(system, access_queue),
        
        gen_server:cast(AccessQueue, {access, Sock, SockAlias, self(), AccIdent, AccArgs}).

exit(Sock, SockAlias) ->
        AccessQueue = nosql:get(system, access_queue),

        gen_server:cast(AccessQueue, {exit, Sock, SockAlias}).

query_index(Sock) ->
        AccessQueue = nosql:get(system, access_queue),

        gen_server:cast(AccessQueue, {query_index, Sock}).

set_max_play_ol_num(Sock, MaxPlayOlNum) ->
        AccessQueue = nosql:get(system, access_queue),

        gen_server:cast(AccessQueue, {set_max_play_ol_num, Sock, MaxPlayOlNum}).

query_online_info(Sock) ->
        AccessQueue = nosql:get(system, access_queue),

        gen_server:cast(AccessQueue, {query_online_info, Sock}).

broadcast(Data) ->
        AccessQueue = nosql:get(system, access_queue),

        gen_server:cast(AccessQueue, {bcast, Data}).

bcast_restart() ->
        AccessQueue = nosql:get(system, access_queue),

        gen_server:cast(AccessQueue, restart_bcast).

bcast_dist(PlayOlDict, BcastPids, []) ->
        ?MODULE:bcast_dist(PlayOlDict, BcastPids, BcastPids);

bcast_dist(PlayOlDict, BcastPids, [WuseBcastPid | RestBcastPids]) ->
        receive
                {enter, Sock} ->
                        Exit = false,
                        PlayOlDict2 = hash_dict:set(PlayOlDict, Sock, 0),
                        RestBcastPids2 = [WuseBcastPid | RestBcastPids],

                        case ?BCAST_USE_ETS of
                                true ->
                                        nosql:set(access_queue, play_ol_dict, PlayOlDict2);
                                false ->
                                        lists:foreach(fun(BcastPid) ->
                                                        BcastPid ! {enter, Sock}  
                                                      end, BcastPids)
                        end;
                {leave, Sock} ->
                        Exit = false,
                        PlayOlDict2 = hash_dict:del(PlayOlDict, Sock),
                        RestBcastPids2 = [WuseBcastPid | RestBcastPids],

                        case ?BCAST_USE_ETS of
                                true ->
                                        nosql:set(access_queue, play_ol_dict, PlayOlDict2);
                                false ->
                                        lists:foreach(fun(BcastPid) ->
                                                        BcastPid ! {leave, Sock}  
                                                      end, BcastPids)
                        end;
                {bcast, Data} ->
                        Exit = false,
                        PlayOlDict2 = PlayOlDict,
                        RestBcastPids2 = RestBcastPids,

                        WuseBcastPid ! {bcast, Data};
                exit ->
                        Exit = true,
                        PlayOlDict2 = PlayOlDict,
                        RestBcastPids2 = [WuseBcastPid | RestBcastPids],

                        cache:set(access_queue, play_ol_dict, PlayOlDict),

                        lists:foreach(fun(BcastPid) ->
                                        BcastPid ! exit
                                      end, BcastPids);
                _Other ->
                        Exit = false,
                        PlayOlDict2 = PlayOlDict,
                        RestBcastPids2 = [WuseBcastPid | RestBcastPids]
        end,

        case Exit of
                true ->
                        pass;
                false ->
                        ?MODULE:bcast_dist(PlayOlDict2, BcastPids, RestBcastPids2)        
        end.

bcast_loop(PlayOlDict) ->
        receive
                {enter, Sock} ->
                        Exit = false,
                        PlayOlDict2 = hash_dict:set(PlayOlDict, Sock, 0);
                {leave, Sock} ->
                        Exit = false,
                        PlayOlDict2 = hash_dict:del(PlayOlDict, Sock);
                {bcast, Data} ->
                        Exit = false,
                        PlayOlDict2 = PlayOlDict,

                        case ?BCAST_USE_ETS of
                                true ->
                                        hash_dict:foreach(fun(Sock, _) ->
                                                                case nosql:get(sock_user_map, Sock) of
                                                                        undef ->
                                                                                pass;
                                                                        SendPid ->
                                                                                SendPid ! {send, Data}
                                                                end
                                                          end, 
                                                          nosql:get(access_queue, play_ol_dict));
                                false ->
                                        hash_dict:foreach(fun(Sock, _) ->
                                                                case nosql:get(sock_user_map, Sock) of
                                                                        undef ->
                                                                                pass;
                                                                        SendPid ->
                                                                                SendPid ! {send, Data}
                                                                end
                                                          end, 
                                                          PlayOlDict)
                        end;
                exit ->
                        Exit = true,
                        PlayOlDict2 = PlayOlDict;
                _Other ->
                        Exit = false,
                        PlayOlDict2 = PlayOlDict
        end,

        case Exit of
                true ->
                        pass;
                false ->
                        ?MODULE:bcast_loop(PlayOlDict2) 
        end.


%% return : boolean()
check_enter_often(do_enter_game, [RoleId]) ->
	Key = {do_enter_game, RoleId},
	Ts = util:unixtime(),
	OldVal = erlang:get(Key),
	case OldVal of
		undefined ->
			erlang:put(Key, Ts),
			true;
		LastTs ->
			case Ts - LastTs > 5 of
				true ->
					%% 大于5秒，ok
					erlang:put(Key, Ts),
					true;
				false ->
					false
			end
	end;

check_enter_often(_AccIdent, _AccArgs) ->
	true.
			
	










