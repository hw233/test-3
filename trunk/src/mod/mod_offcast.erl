%%%--------------------------------------
%%% @Module: mod_offcast
%%% @Author: liuzhongzheng2012@gmail.com
%%% @Created: 2014年8月9日
%%% @Description: 离线Cast保存
%%%--------------------------------------

-module(mod_offcast).
-behavour(gen_server).
-export([init/1, handle_cast/2, handle_call/3, handle_info/2, terminate/2, code_change/3]).
-export([start/0, start_link/0]).
-include("common.hrl").

-export([cast/2]).

cast(UID, Info) ->
    gen_server:cast(?MODULE, {UID, Info}).

start() ->
    case erlang:whereis(?MODULE) of
        undefined ->
            case supervisor:start_child(
               sm_sup,
               {?MODULE,
                {?MODULE, start_link, []},
                 permanent, 10000, worker, [?MODULE]}) of
            {ok, Pid} ->
                Pid;
            {error, R} ->
                ?WARNING_MSG("start error:~p~n", [R]),
                undefined
            end;
        Pid ->
            Pid
    end.

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).


init([]) ->
    {ok, {}}.


handle_call(Request, From, State) ->
    try
        do_call(Request, From, State)
    catch
        Err:Reason->
            ?ERROR_MSG("ERR:~p,Reason:~p, Request:~p",[Err,Reason, Request]),
             {reply, error, State}
    end.


handle_cast(Request, State) ->
    try
        do_cast(Request, State)
    catch
        Err:Reason->
            ?ERROR_MSG("ERR:~p,Reason:~p, Request:~p",[Err,Reason, Request]),
             {noreply, State}
    end.



handle_info(Request, State) ->
    try
        do_info(Request, State)
    catch
        Err:Reason->
            ?ERROR_MSG("ERR:~p,Reason:~p, Request:~p",[Err,Reason, Request]),
             {noreply, State}
    end.



code_change(_OldVsn, State, _Extra) ->
    {ok, State}.


terminate(_Reason, _State) ->
    ok.

do_call(_Msg, _From, State) ->
    ?WARNING_MSG("unhandle call ~w", [_Msg]),
    {reply, error, State}.

do_cast({UID, Info}, State) ->
    case db:kv_lookup(offcast, UID) of
        [Casts] ->
            db:kv_insert(offcast, UID, [Info|Casts]);
        [] ->
            db:kv_insert(offcast, UID, [Info])
    end,
    {noreply, State};
do_cast(_Msg, State) ->
    ?WARNING_MSG("unhandle cast ~p", [_Msg]),
    {noreply, State}.


do_info(_Msg, State) ->
    ?WARNING_MSG("unhandle info ~w", [_Msg]),
    {noreply, State}.

