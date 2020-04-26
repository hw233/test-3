%%%------------------------------------
%%% @Module  : mod_cdk
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2014.8.5
%%% @Description: cd key（激活码）
%%%------------------------------------
-module(mod_cdk).
-behaviour(gen_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([
        start_link/0,
        gen_cdk_8/0
        ]).

-include("debug.hrl").

-record(state, {}).



start_link() ->
    {ok, _Pid} = gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).


%% 生成8位激活码
%% @return: {ok, Cdk} | fail
gen_cdk_8() ->
    case catch gen_server:call(?MODULE, {'gen_cdk_8'}) of
        {'EXIT', Reason} ->
            ?ERROR_MSG("gen_cdk_8() failed!! Reason:~w", [Reason]),
            ?ASSERT(false, Reason),
            fail;
        {ok, Cdk} ->
            ?ASSERT(is_list(Cdk) andalso length(Cdk) == 8),
            {ok, Cdk};
        fail ->
            fail
    end.



%% ===================================================================================================
    
init([]) ->
    process_flag(trap_exit, true),
    do_init_jobs(),
    {ok, #state{}}.



handle_cast(_R, State) ->
    ?ASSERT(false, _R),
    {noreply, State}.


handle_call({'gen_cdk_8'}, _From, State) ->
    RetVal = try
                Cdk = lib_cdk:gen_cdk_8(),
                {ok, Cdk}
            catch
                _:Reason ->
                    ?ERROR_MSG("lib_cdk:gen_cdk_8() failed!!! Reason:~w", [Reason]),
                    fail
            end,
    {reply, RetVal, State};

handle_call(_R, _From, State) ->
    ?ASSERT(false, _R),
    {reply, ok, State}.


handle_info(_R, State) ->
    {noreply, State}.

terminate(Reason, _State) ->
    case Reason of
        normal -> skip;
        shutdown -> skip;
        {shutdown, _} -> skip;
        _ ->
            ?ERROR_MSG("[~p] !!!!!terminate!!!!! for reason: ~w", [?MODULE, Reason])
    end,
    ok.

code_change(_OldVsn, State, _Extra)->
    {ok, State}.







do_init_jobs() ->
    lib_cdk:init().