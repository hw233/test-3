-module(proc_log_svr).
-behaviour(gen_server).
-export([start_link/0,
         state/0,
         info_handler/0,
         terminator/0,
         init/1,
         handle_call/3,
         handle_cast/2,
         handle_info/2,
         handle_info2/2,
         terminate/2,
         terminate2/2,
         code_change/3,
         gen_log_filename/0,
         stat_process/1,
         new_day_come/1,
         get_log_file_prefix/0,
         init_log_file/0]).

-record(state2, {fd}).
-record(state, {state2,
                module,
                handle_info_method,
                terminate_method}).
-record(proc_info, {owner,
                    msg_q,
                    status,
                    curr_fun,
                    dict_len,
                    heap_size,
                    links,
                    msg_inc_count,
                    dict_inc_count,
                    heap_inc_count}).

-include("global2.hrl").
-include("log2.hrl").

-define(INC_WARN_COUNT, 5).
-define(MSGQ_WARN_LEN,  10000).
-define(DICT_WARN_LEN,  10000).
-define(HEAP_WARN_SIZE, 100000000).

start_link()->
        {ok, Pid} = gen_server:start_link(?MODULE, dummy, []),

        set_log_svr_pid(Pid),

        {ok, Pid}.

state()->
        Fd = init_log_file(),

        simple_timer:set_timer(?STAT_PROC_INTV * 1000, 0, ?MODULE, stat_process, []),

        #state2{fd = Fd}.

info_handler()->
        handle_info2.

terminator()->
        terminate2.

init(_Dummy)->
        {ok, #state{state2 = state(),
                    module = ?MODULE, 
                    handle_info_method = info_handler(),
                    terminate_method = terminator()}}.

handle_call(_Request,_From,State)->
        {reply, ok, State}.

get_proc_value(Pid, dictionary_len) ->
        case erlang:process_info(Pid, dictionary) of
                undefined ->
                        0;
                {_Key, Dictionary} ->
                        length(Dictionary)
        end;

get_proc_value(Pid, Key) ->
        case erlang:process_info(Pid, Key) of
                undefined ->
                        case Key of
                                message_queue_len ->
                                        0;
                                status ->
                                        unknown;
                                current_function ->
                                        {unknown, unknown, 0};
                                total_heap_size ->
                                        0;
                                _Other ->
                                        unknown
                        end;
                {Key, Value} ->
                        Value
        end.

init_proc(Type, Pid) ->
        case is_process_alive(Pid) of
                true ->
                        ProcInfo = #proc_info{msg_q = get_proc_value(Pid, message_queue_len),
                                              status = get_proc_value(Pid, status),
                                              curr_fun = get_proc_value(Pid, current_function),
                                              dict_len = get_proc_value(Pid, dictionary_len),
                                              heap_size = get_proc_value(Pid, total_heap_size),
                                              links = hash_dict:new(),
                                              msg_inc_count = 0,
                                              dict_inc_count = 0,
                                              heap_inc_count = 0},

                        nosql:set(Type, Pid, ProcInfo),

                        true;
                false ->
                        false
        end.

add_plink(Type, Pid, LinkType, LinkPid) ->
        case is_process_alive(Pid) and is_process_alive(LinkPid) of
                true ->
                        ProcInfo = nosql:get(Type, Pid),

                        Links = ProcInfo#proc_info.links,

                        nosql:set(Type, Pid, ProcInfo#proc_info{links = hash_dict:set(Links, LinkType, LinkPid)}),

                        true;
                false ->
                        false
        end.

handle_cast2({add_reader, ReaderPid}, State)->
        init_proc(procs_reader, ReaderPid),

        {noreply, State};

handle_cast2({add_recver, ReaderPid, RecverPid}, State) ->
        init_proc(procs_recver, RecverPid),
        add_plink(procs_reader, ReaderPid, procs_recver, RecverPid),

        {noreply, State};

handle_cast2({add_sender, ReaderPid, SenderPid}, State) ->
        init_proc(procs_sender, SenderPid),
        add_plink(procs_reader, ReaderPid, procs_sender, SenderPid),

        {noreply, State};

handle_cast2({add_player, ReaderPid, PlayerPid, AccName}, State) ->
        Ret  = init_proc(procs_player, PlayerPid),
        Ret2 = add_plink(procs_reader, ReaderPid, procs_player, PlayerPid),
        Ret3 = add_plink(procs_player, PlayerPid, procs_reader, ReaderPid),

        if 
                Ret == true, Ret2 == true, Ret3 == true ->
                        ReaderPids =    
                        case nosql:get(accounts, AccName) of
                                undef ->
                                        nosql:set(accounts, AccName, hash_dict:new()),

                                        hash_dict:new();
                                Other ->
                                        ?WARNING_LOG("proc_log_svr:add_account: account(~p) has 2 or more readers(~w).", [AccName, Other]),

                                        Other
                        end,

                        nosql:set(accounts, AccName, hash_dict:set(ReaderPids, ReaderPid, 0)),

                        ReaderInfo = nosql:get(procs_reader, ReaderPid),

                        nosql:set(procs_reader, ReaderPid, ReaderInfo#proc_info{owner = AccName});
                true ->
                        pass
        end,

        {noreply, State};

handle_cast2({del_player, PlayerPid}, State) ->
        nosql:del(procs_player, PlayerPid),

        {noreply, State};

handle_cast2({del_reader, ReaderPid}, State) ->
        case nosql:get(procs_reader, ReaderPid) of
                undef ->
                        pass;
                ReaderInfo ->
                        AccName = ReaderInfo#proc_info.owner,

                        Links = ReaderInfo#proc_info.links,

                        hash_dict:foreach(fun(LinkType, LinkPid) ->
                                                case LinkType of
                                                        procs_player ->
                                                                pass;
                                                        _Other ->
                                                                nosql:del(LinkType, LinkPid)
                                                end 
                                          end, Links),

                        nosql:del(procs_reader, ReaderPid),

                        case AccName of
                                undefined ->
                                        pass;
                                _Other ->
                                        ReaderPids = nosql:get(accounts, AccName),

                                        ReaderPids2 = hash_dict:del(ReaderPids, ReaderPid),

                                        case hash_dict:size(ReaderPids2) of
                                                0 ->
                                                        nosql:del(accounts, AccName);
                                                _Other2 ->
                                                        nosql:set(accounts, AccName, ReaderPids2)
                                        end
                        end
        end,

        {noreply, State};

handle_cast2(_Msg,State)->
        {noreply, State}.

handle_cast(Msg,State)->
        case ?TRY_CATCH(handle_cast2(Msg, State)) of
                {noreply, State2} ->
                        {noreply, State2};
                _Other ->
                        {noreply, State}
        end.

handle_info(Info,State)->
        State2 = timer_dist:dispatch(Info, State#state.state2, State#state.module, State#state.handle_info_method),

        {noreply, State#state{state2 = State2}}.
        
handle_info2(_Info, State) ->
        {ok, State}.

terminate(Reason,State)->
        apply(State#state.module, State#state.terminate_method, [Reason, State#state.state2]),

        simple_timer:clear_timer_refs(?TIMER_TYPE_MP),
        simple_timer:clear_timer_refs(?TIMER_TYPE_SP),

        simple_timer:clear_seeds(?TIMER_TYPE_MP),
        simple_timer:clear_seeds(?TIMER_TYPE_SP),

        ok.

terminate2(_Reason,State)->
        file:close(State#state2.fd).

code_change(_OldVsn,State,_Extra)->
        {ok, State}.

gen_log_filename()->
        AppName = nosql:get(system, app),

        ?LOG_PERF_PATH ++ AppName ++ "-" ++ get_log_file_prefix() ++ time:date_day_str() ++ ".log".

format_info(ProcInfo) ->
        my_eapi:sprintf("        msg_q:~p~n        status:~p~n        links:~p~n        curr_fun:~p~n        dict_len:~p~n        heap_size:~p~n        msg_inc_count:~p~n        dict_inc_count:~p~n        heap_inc_count:~p",
                        [ProcInfo#proc_info.msg_q,
                         ProcInfo#proc_info.status,
                         lists:sublist(hash_dict:to_list_dict(ProcInfo#proc_info.links), 2, 3),
                         ProcInfo#proc_info.curr_fun,
                         ProcInfo#proc_info.dict_len,
                         ProcInfo#proc_info.heap_size,
                         ProcInfo#proc_info.msg_inc_count,
                         ProcInfo#proc_info.dict_inc_count,
                         ProcInfo#proc_info.heap_inc_count]).

check_process(Type, Pid, ProcInfo, State) ->
        case erlang:is_process_alive(Pid) of
                true ->
                        ProcInfo2 = ProcInfo#proc_info{msg_q = get_proc_value(Pid, message_queue_len),
                                                       status = get_proc_value(Pid, status),
                                                       curr_fun = get_proc_value(Pid, current_function),
                                                       dict_len = length(get_proc_value(Pid, dictionary)),
                                                       heap_size = get_proc_value(Pid, total_heap_size)},

                        MsgIncCount = 
                        case ProcInfo2#proc_info.msg_q > ProcInfo#proc_info.msg_q of
                                true ->
                                        ProcInfo#proc_info.msg_inc_count + 1;
                                false ->
                                        0
                        end,

                        DictIncCount = 
                        case ProcInfo2#proc_info.dict_len > ProcInfo#proc_info.dict_len of
                                true ->
                                        ProcInfo#proc_info.dict_inc_count + 1;
                                false ->
                                        0
                        end,

                        HeapIncCount = 
                        case ProcInfo2#proc_info.heap_size > ProcInfo#proc_info.heap_size of
                                true ->
                                        ProcInfo#proc_info.heap_inc_count + 1;
                                false ->
                                        0
                        end,

                        ProcInfo3 = ProcInfo2#proc_info{msg_inc_count = MsgIncCount,
                                                        dict_inc_count = DictIncCount,
                                                        heap_inc_count = HeapIncCount},

                        file:write(State#state2.fd, my_eapi:sprintf("process_info(~p) => ~p:~n" ++ format_info(ProcInfo3) ++ "~n", [Type, Pid])),

                        nosql:set(Type, Pid, ProcInfo3),

                        case MsgIncCount > ?INC_WARN_COUNT of
                                true ->
                                        ?WARNING_LOG("proc_log_svr:check_process: type:~p Pid:~p MsgIncCount:~p MsgQ:~p always increase.", 
                                                     [Type, Pid, MsgIncCount, ProcInfo2#proc_info.msg_q]);
                                false ->
                                        pass
                        end,

                        case ProcInfo#proc_info.msg_q > ?MSGQ_WARN_LEN of
                                true ->
                                        ?WARNING_LOG("proc_log_svr:check_process: type:~p Pid:~p MsgQ:~p too large.", 
                                                     [Type, Pid, ProcInfo2#proc_info.msg_q]);
                                false ->
                                        pass
                        end,

                        case DictIncCount > ?INC_WARN_COUNT of
                                true ->
                                        ?WARNING_LOG("proc_log_svr:check_process: type:~p Pid:~p DictIncCount:~p DictLen:~p always increase.", 
                                                     [Type, Pid, DictIncCount, ProcInfo2#proc_info.dict_len]);
                                false ->
                                        pass
                        end,

                        case ProcInfo#proc_info.dict_len > ?DICT_WARN_LEN of
                                true ->
                                        ?WARNING_LOG("proc_log_svr:check_process: type:~p Pid:~p DictLen:~p too large.", 
                                                     [Type, Pid, ProcInfo2#proc_info.dict_len]);
                                false ->
                                        pass
                        end,

                        case HeapIncCount > ?INC_WARN_COUNT of
                                true ->
                                        ?WARNING_LOG("proc_log_svr:check_process: type:~p Pid:~p HeapIncCount:~p DictLen:~p always increase.", 
                                                     [Type, Pid, HeapIncCount, ProcInfo2#proc_info.heap_size]);
                                false ->
                                        pass
                        end,

                        case ProcInfo#proc_info.heap_size > ?HEAP_WARN_SIZE of
                                true ->
                                        ?WARNING_LOG("proc_log_svr:check_process: type:~p Pid:~p HeapSize:~p too large.", 
                                                     [Type, Pid, ProcInfo2#proc_info.heap_size]);
                                false ->
                                        pass
                        end;
                false ->
                        file:write(State#state2.fd, my_eapi:sprintf("process_info(~p) => ~p:dead", [Type, Pid]))
        end.

stat_process(State) ->
        file:write(State#state2.fd, my_eapi:sprintf(log_io:format_time(erlang:localtime()) ++ " process_info:~n", [])),

        nosql:foldl(fun(ReaderPid, ReaderInfo, null) ->
                        AccName = ReaderInfo#proc_info.owner,

                        file:write(State#state2.fd, my_eapi:sprintf("=======================account(~p)=======================~n", [AccName])),

                        check_process(procs_reader, ReaderPid, ReaderInfo, State),

                        Links = ReaderInfo#proc_info.links,

                        hash_dict:foreach(fun(LinkType, LinkPid) ->
                                                LinkProcInfo = nosql:get(LinkType, LinkPid),

                                                check_process(LinkType, LinkPid, LinkProcInfo, State)
                                          end,
                                          Links),

                        case erlang:is_process_alive(ReaderPid) of
                                true ->
                                        case AccName of
                                                undef ->
                                                        normal;
                                                _Other ->
                                                        case hash_dict:get(Links, player) of
                                                                undef ->
                                                                        pass;
                                                                        %?WARNING_LOG("proc_log_svr:stat_process: reader(~p)<alive> may has error (player:undef)<unborn>. (acc:~p)", 
                                                                        %             [ReaderPid, AccName]);
                                                                PlayerPid ->
                                                                        case erlang:is_process_alive(PlayerPid) of
                                                                                true ->
                                                                                        normal;
                                                                                false ->
                                                                                        ?WARNING_LOG("proc_log_svr:stat_process: reader(~p)<alive> may memory leak (player:~p)<dead>. (acc:~p)", 
                                                                                                     [ReaderPid, PlayerPid, AccName])
                                                                        end
                                                        end
                                        end;
                                false ->
                                        case hash_dict:get(Links, player) of
                                                undef ->
                                                        pass;
                                                PlayerPid ->
                                                        case erlang:is_process_alive(PlayerPid) of 
                                                                true ->
                                                                        ?WARNING_LOG("proc_log_svr:stat_process: reader(~p)<dead> may memory leak (player:~p)<alive>. (acc:~p)", 
                                                                                     [ReaderPid, PlayerPid, AccName]);
                                                                false ->
                                                                        pass
                                                        end       
                                        end
                        end,

                        file:write(State#state2.fd, my_eapi:sprintf("=============================end=============================~n~n", [])),

                        null
                    end,
                    null, procs_reader),

        RmPlayers = 
        nosql:foldl(fun(PlayerPid, PlayerInfo, RmPlayers2) ->
                        {MemLeak, RmPlayers3} = 
                        case hash_dict:get(PlayerInfo#proc_info.links, procs_reader) of
                                undef ->
                                        {erlang:is_process_alive(PlayerPid), lists:append(RmPlayers2, [PlayerPid])};
                                ReaderPid ->
                                        case erlang:is_process_alive(ReaderPid) of
                                                true ->
                                                        {false, RmPlayers2};
                                                false ->
                                                        {erlang:is_process_alive(PlayerPid), lists:append(RmPlayers2, [PlayerPid])}
                                        end
                        end,

                        if 
                                MemLeak == true ->
                                        ?WARNING_LOG("proc_log_svr:stat_process: unexpected player process ~p.", [PlayerPid]),

                                        exit(PlayerPid, kill);
                                true ->
                                        pass
                        end,

                        RmPlayers3  
                    end, 
                    [], procs_player),

        lists:foreach(fun(PlayerPid) ->
                        nosql:del(procs_player, PlayerPid)
                      end,
                      RmPlayers).

new_day_come(State)->
        file:close(State#state2.fd),

        {ok, State#state2{fd = init_log_file()}}.

set_log_svr_pid(Pid)->
        nosql:set(log, proc_log_svr, Pid).

get_log_file_prefix()->
        "proc-".

init_log_file()->
        FileName = gen_log_filename(),

        {ok, Fd} = file:open(FileName, [append, raw]),

        simple_timer:set_timer(time:newday_countdown() * 1000, 1, ?MODULE, new_day_come, []),

        Fd.