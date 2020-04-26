%%%------------------------------------
%%% @Module  : mod_hire_mgr
%%% @Author  : zhangwq
%%% @Email   :
%%% @Created : 2014.9.12
%%% @Description: 雇佣管理 主要是处理一些并发问题
%%%------------------------------------


-module(mod_hire_mgr).
-behaviour(gen_server).
-export([start_link/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-export([
        sign_up/2,
        on_job_schedule/0                       %% 定时清空天将与雇佣信息
    ]).


-include("hire.hrl").
-include("prompt_msg_code.hrl").
-include("ets_name.hrl").
-include("debug.hrl").
-include("abbreviate.hrl").
-include("common.hrl").
-include("goods.hrl").
-include("log.hrl").
-include("record.hrl").
-include("pt_41.hrl").

on_job_schedule() ->
    gen_server:cast(?HIRE_MGR_PROCESS, 'on_job_schedule').


sign_up(PS, Price) ->
    gen_server:cast(?HIRE_MGR_PROCESS, {'sign_up', PS, Price}).    

% -------------------------------------------------------------------------

start_link() ->
    gen_server:start_link({local, ?HIRE_MGR_PROCESS}, ?MODULE, [], []).


init([]) ->
    process_flag(trap_exit, true),
    
    mod_hire:init(),

    {ok, none}.


handle_call(Request, From, State) ->
    try
        handle_call_2(Request, From, State)
    catch
        Err:Reason ->
            ?ERROR_MSG("ERR:~p,Reason:~p",[Err,Reason]),
             {reply, error, State}
    end.


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


handle_cast_2('on_job_schedule', State) ->
    ?TRY_CATCH(mod_hire:on_job_schedule(), Err_Reason),
    {noreply, State};


handle_cast_2({'sign_up', PS, Price}, State) ->
    ?TRY_CATCH(try_sign_up(PS, Price), Err_Reason),
    {noreply, State};

handle_cast_2(_Msg, State) ->
    {noreply, State}.


handle_info(_Info, State) ->
    {noreply, State}.

terminate(Reason, _State) ->
    case Reason of
        normal -> skip;
        shutdown -> skip;
        _ -> ?ERROR_MSG("[mod_hire_mgr] !!!!!terminate!!!!! for reason: ~w", [Reason])
    end,
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

% %%-------------------------------------------------------------------------------------------------


try_sign_up(PS, Price) ->
    case ply_hire:sign_up(PS, Price) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        ok ->
            {ok, BinData} = pt_41:write(?SIGN_UP, [?RES_OK]),
            lib_send:send_to_sock(PS, BinData)
    end.