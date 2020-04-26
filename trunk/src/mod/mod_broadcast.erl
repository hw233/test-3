%%%------------------------------------
%%% @Module  : mod_broadcast
%%% @Author  : zhangwq
%%% @Email   :
%%% @Created : 2014.2.25
%%% @Description: 广播管理与发送模块
%%%------------------------------------


-module(mod_broadcast).
-behaviour(gen_server).
-export([start_link/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-export([
        to_broadcast_record/1,            %% 生成公告结构体
        add_or_update_broadcast/1,        %% 增加，修改后台运营公告
        del_broadcast/1,                  %% 删除后台运营公告

        send_sys_broadcast/2,             %% 发送系统公告

        get_broadcast_id_list/0,
        get_broadcast_list_by_id_list/1
    ]).


-include("broadcast.hrl").
-include("prompt_msg_code.hrl").
-include("ets_name.hrl").
-include("debug.hrl").
-include("abbreviate.hrl").
-include("common.hrl").
-include("pt_11.hrl").

to_broadcast_record([Id, Type, Priority, Content, Interval, StartTime, EndTime, OpType]) ->
    #broadcast{
        id = Id,
        type = Type,
        priority = case Priority =:= 0 of true -> 1; false -> Priority end,
        content = case is_list(Content) of true -> list_to_binary(Content); false -> Content end,
        interval = Interval,
        start_time = StartTime,
        end_time = EndTime,
        op_type = OpType
    }.


get_broadcast_id_list() ->
    BroadcastList = ets:tab2list(?ETS_BROADCAST),
    CurUnixTime = svr_clock:get_unixtime(),
    F = fun(Broadcast, AccList) ->
        case (CurUnixTime >= Broadcast#broadcast.end_time andalso Broadcast#broadcast.type =/= 3) of
            true ->
                AccList;
            false ->
                [Broadcast#broadcast.id | AccList]
        end
    end,
    lists:foldl(F, [], BroadcastList).


get_broadcast_list_by_id_list(IdList) ->
    F = fun(X, AccList) ->
        case lists:member(X#broadcast.id, IdList) of
            true ->
                [X | AccList];
            false ->
                AccList
        end
    end,
    lists:foldl(F, [], ets:tab2list(?ETS_BROADCAST)).


add_or_update_broadcast(Broadcast) ->
    case catch gen_server:call(?BROADCAST_PROCESS, {'add_or_update_broadcast', Broadcast}) of
        {'EXIT', Reason} ->
            ?ERROR_MSG("add_or_update_broadcast(), exit for reason: ~p~n", [Reason]),
            ?ASSERT(false, Reason),
            {fail, Reason};
        {fail, Reason} ->
            ?ERROR_MSG("add_or_update_broadcast(), exit for reason: ~p~n", [Reason]),
            {fail, Reason};
        ok ->
            ok
    end.


del_broadcast(Id) ->
    case catch gen_server:call(?BROADCAST_PROCESS, {'del_broadcast', Id}) of
        {'EXIT', Reason} ->
            ?ERROR_MSG("del_broadcast(), exit for reason: ~p~n", [Reason]),
            ?ASSERT(false, Reason),
            {fail, Reason};
        {fail, Reason} ->
            ?ERROR_MSG("add_or_update_broadcast(), exit for reason: ~p~n", [Reason]),
            {fail, Reason};
        ok ->
            ok
    end.

%% para: No 公告编号  ParaList -> 公告参数列表 参考 ply_tips 模块说明
send_sys_broadcast(No, ParaList) ->
    gen_server:cast(?BROADCAST_PROCESS, {'send_sys_broadcast', No, ParaList}).


% -------------------------------------------------------------------------

start_link() ->
    gen_server:start_link({local, ?BROADCAST_PROCESS}, ?MODULE, [], []).


init([]) ->
    process_flag(trap_exit, true),
    
    %% 把还没有过期的公告加载到服务器
    init_broadcast_from_db(),

    % 定时清除内存中已经过期的公告
    erlang:send_after(?CLEAR_OUTDATED_BROADCAST_INTV, self(), {'clear_outdated_broadcast', 0}),
    {ok, none}.


handle_call(Request, From, State) ->
    try
        handle_call_2(Request, From, State)
    catch
        Err:Reason ->
            ?ERROR_MSG("ERR:~p,Reason:~p",[Err,Reason]),
             {reply, error, State}
    end.

handle_call_2({'add_or_update_broadcast', Broadcast}, _From, State) ->
    ?ASSERT(is_record(Broadcast, broadcast)),
    case Broadcast#broadcast.op_type of
        1 ->
            Id = db_save_broadcast(Broadcast),
            case Broadcast#broadcast.interval =/= 0 orelse Broadcast#broadcast.type =:= 3 of
                true ->
                    ets:insert(?ETS_BROADCAST, Broadcast#broadcast{id = Id});
                false ->
                    skip
            end,

            {ok, BinData} = pt_11:write(?PT_ADD_BROADCAST, [Broadcast#broadcast{id = Id}]),
            AllIdList = mod_svr_mgr:get_all_online_player_ids(),
            [lib_send:send_to_uid(PlayerId, BinData) || PlayerId <- AllIdList];
        2 ->
            OldId = Broadcast#broadcast.id,
            db_delete_broadcast(Broadcast#broadcast.id),

            case ets:lookup(?ETS_BROADCAST, Broadcast#broadcast.id) of
                [] ->
                    skip;
                [_Broadcast] ->
                    ets:delete(?ETS_BROADCAST, Broadcast#broadcast.id)
            end,

            NewId = db_save_broadcast(Broadcast),
            case Broadcast#broadcast.interval =/= 0 orelse Broadcast#broadcast.type =:= 3 of
                true ->
                    ets:insert(?ETS_BROADCAST, Broadcast#broadcast{id = NewId});
                false ->
                    skip
            end,

            {ok, BinData} = pt_11:write(?PT_DEL_BROADCAST, [OldId]),
            AllIdList = mod_svr_mgr:get_all_online_player_ids(),
            [lib_send:send_to_uid(PlayerId, BinData) || PlayerId <- AllIdList],

            {ok, BinData1} = pt_11:write(?PT_ADD_BROADCAST, [Broadcast#broadcast{id = NewId}]),
            [lib_send:send_to_uid(Id, BinData1) || Id <- AllIdList];
        _Any ->
            ?ASSERT(false, Broadcast)
    end,
    {reply, ok, State};


handle_call_2({'del_broadcast', Id}, _From, State) ->
    db_delete_broadcast(Id),
    case ets:lookup(?ETS_BROADCAST, Id) of
        [] ->
            skip;
        [_Broadcast] ->
            ets:delete(?ETS_BROADCAST, Id)
    end,

    {ok, BinData} = pt_11:write(?PT_DEL_BROADCAST, [Id]),
    AllIdList = mod_svr_mgr:get_all_online_player_ids(),
    [lib_send:send_to_uid(PlayerId, BinData) || PlayerId <- AllIdList],
    {reply, ok, State};


handle_call_2(_Request, _From, State) ->
    {reply, State, State}.


handle_cast(Request, State) ->
    try
        handle_cast_2(Request, State)
    catch
        Err:Reason ->
            ?ERROR_MSG("ERR:~p,Reason:~p",[Err,Reason]),
            {noreply, State}
    end.


handle_cast_2({'send_sys_broadcast', No, ParaList}, State) ->
    ?TRY_CATCH(try_send_sys_broadcast(No, ParaList), ErrReason),
    {noreply, State};


handle_cast_2(_Msg, State) ->
    {noreply, State}.



handle_info(Request, State) ->
    try
        handle_info_2(Request, State)
    catch
        Err:Reason->
            ?ERROR_MSG("ERR:~p,Reason:~p",[Err,Reason]),
             {noreply, State}
    end.

handle_info_2({'clear_outdated_broadcast', CurTick}, State) ->
    CurUnixTime = svr_clock:get_unixtime(),
    BroadcastList = ets:tab2list(?ETS_BROADCAST),
    F = fun(Broadcast) ->
        case CurUnixTime > Broadcast#broadcast.end_time andalso Broadcast#broadcast.type =/= 3 of
            true ->
                ets:delete(?ETS_BROADCAST, Broadcast#broadcast.id);
            false ->
                skip
        end
    end,
    [F(X) || X <- BroadcastList],

    erlang:send_after(?CLEAR_OUTDATED_BROADCAST_INTV, self(), {'clear_outdated_broadcast', CurTick + 1}),
    {noreply, State};


handle_info_2(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

% %%-------------------------------------------------------------------------------------------------

init_broadcast_from_db() ->
    Now = svr_clock:get_unixtime(),
    case db:select_all(t_broadcast, "id, type, priority, content, interval_time, start_time, end_time, op_type", [{end_time, ">", Now}]) of
        InfoList_List when is_list(InfoList_List) ->
            BroadcastList = [to_broadcast_record(InfoList) || InfoList <- InfoList_List],
            [ets:insert(?ETS_BROADCAST, Broadcast) || Broadcast <- BroadcastList];
        _Any ->
            ?ERROR_MSG("[mod_broadcast] init_broadcast_from_db() error!", []),
            ?ASSERT(false, _Any),
            []
    end,
    case db:select_all(t_broadcast, "id, type, priority, content, interval_time, start_time, end_time, op_type", [{type, 3}]) of
        InfoList_List1 when is_list(InfoList_List1) ->
            BroadcastList1 = [to_broadcast_record(InfoList) || InfoList <- InfoList_List1],
            [ets:insert(?ETS_BROADCAST, Broadcast) || Broadcast <- BroadcastList1];
        _Any1 ->
            ?ERROR_MSG("[mod_broadcast] init_broadcast_from_db() error!", []),
            ?ASSERT(false, _Any1),
            []
    end.

db_save_broadcast(Broadcast) ->
    db:insert_get_id(t_broadcast, ["type", "priority", "start_time", "end_time", "interval_time", "content", "op_type"], 
        [Broadcast#broadcast.type, Broadcast#broadcast.priority, Broadcast#broadcast.start_time, Broadcast#broadcast.end_time, Broadcast#broadcast.interval,
        Broadcast#broadcast.content, Broadcast#broadcast.op_type]
        ).


db_delete_broadcast(Id) ->
    db:delete(?DB_SYS, t_broadcast, [{id, Id}]).


try_send_sys_broadcast(No, ParaList) ->
    {ok, BinData} = pt_11:write(?PT_SEND_SYS_BROADCAST, [No, ParaList]),
    lib_send:send_to_all(BinData).