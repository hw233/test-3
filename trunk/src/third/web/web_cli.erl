-module(web_cli).
-export([urlopen/1,
         urlopen_async/1]).

-include("log2.hrl").

-define(CONNECT_TIMEOUT,    5000).
-define(INACTIVITY_TIMEOUT, 5000).
-define(MAX_SESSIONS,       1000000).
-define(MAX_PIPELINE_SIZE,  1000000).

-define(RETRY_INTV, 200).

-define(MAX_RETRY_NUM, 10).

urlopen(Url, RetryCount) ->
        case ibrowse:send_req(Url, [], get, [], [{connect_timeout, ?CONNECT_TIMEOUT}, 
                                                 {inactivity_timeout, ?INACTIVITY_TIMEOUT},
                                                 {max_sessions, ?MAX_SESSIONS},
                                                 {max_pipeline_size, ?MAX_PIPELINE_SIZE}]) of
                {ok, "200", _, Ret} ->
                        case list_to_binary(Ret) of
                                <<Compressed:8, Ret2/binary>> ->
                                        case Compressed of
                                                0 ->
                                                        binary_to_list(Ret2);
                                                1 ->
                                                        case catch zlib:uncompress(Ret2) of
                                                                {'EXIT', _Reason} ->
                                                                        Ret;
                                                                Data ->
                                                                        binary_to_list(Data)
                                                        end;
                                                _Other ->
                                                        Ret
                                        end;
                                _Other2 ->
                                        Ret
                        end;
                {ok, Code, _, Ret} ->
                        ?ERROR_LOG("web_cli:urlopen, url:~s, code:~p, ret:~p, retry:~p", [Url, Code, Ret, RetryCount]),
                        
                        case RetryCount == ?MAX_RETRY_NUM of
                                true ->
                                        undef;
                                false ->
                                        timer:sleep(?RETRY_INTV),
                                        
                                        urlopen(Url, RetryCount + 1)           
                        end;
                {error, Reason} ->
                        ?ERROR_LOG("web_cli:urlopen, url:~s, exception:~p, retry:~p", [Url, Reason, RetryCount]),

                        case RetryCount == ?MAX_RETRY_NUM of
                                true ->
                                        undef;
                                false ->
                                        timer:sleep(?RETRY_INTV),

                                        urlopen(Url, RetryCount + 1)           
                        end;
                Other ->
                        ?ERROR_LOG("web_cli:urlopen, url:~s, unknown:~p, retry:~p", [Url, Other, RetryCount]),

                        case RetryCount == ?MAX_RETRY_NUM of
                                true ->
                                        undef;
                                false ->
                                        timer:sleep(?RETRY_INTV),

                                        urlopen(Url, RetryCount + 1)           
                        end   
        end.

urlopen(Url) ->
        urlopen(Url, 0).

urlopen_async(Url, RetryCount) ->
        case ibrowse:send_req(Url, [], get, [], [{connect_timeout, ?CONNECT_TIMEOUT}, 
                                                 {inactivity_timeout, ?INACTIVITY_TIMEOUT},
                                                 {max_sessions, ?MAX_SESSIONS},
                                                 {max_pipeline_size, ?MAX_PIPELINE_SIZE}, 
                                                 {stream_to, nosql:get(web, istream)}]) of
                {ibrowse_req_id, _} ->
                        true;
                {error, Reason} ->
                        ?ERROR_LOG("web_cli:urlopen_async, url:~s, exception:~p, retry:~p", [Url, Reason, RetryCount]),

                        case RetryCount == ?MAX_RETRY_NUM of
                                true ->
                                        false;
                                false ->
                                        timer:sleep(?RETRY_INTV),

                                        urlopen_async(Url, RetryCount + 1)           
                        end;
                Other ->
                        ?ERROR_LOG("web_cli:urlopen_async, url:~s, unknown:~p, retry:~p", [Url, Other, RetryCount]),

                        case RetryCount == ?MAX_RETRY_NUM of
                                true ->
                                        false;
                                false ->
                                        timer:sleep(?RETRY_INTV),

                                        urlopen_async(Url, RetryCount + 1)           
                        end 
        end.

urlopen_async(Url) ->
        urlopen_async(Url, 0).