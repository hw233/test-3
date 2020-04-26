-ifndef(__GLOBAL2_H__).
-define(__GLOBAL2_H__, 0).

-include("log2.hrl").

%%监控参数
-define(SUP_MAX,    10).
-define(SUP_WITHIN, 10).

%%定义监控重启方法
-ifdef(debug).
-define(SUP_HOW_RESTART, temporary).
-else.
-define(SUP_HOW_RESTART, transient).
-endif.

%%定时器ID范围
-define(TIMER_ID_RANGE, 10000).

-define(TIMER_TYPE_MP, mp). %多进程定时器
-define(TIMER_TYPE_SP, sp). %单进程定时器

%%调用守护进程超时时间,100ms
-define(CALL_DAEMON_TIMEOUT, 100).

%%消息处理器模块后缀
-define(MSG_HANDLER_SUFFIX, "_mHandler").

%% 断言以及打印调试信息宏
-ifdef(debug).

-define(ASSERT(BoolExpr), ((fun() ->
                               case (BoolExpr) of
                                        true -> 
                                                void;
                                        _Other ->  
                                                ?ERROR_LOG("ASSERT FAILED! module=~p line=~p~n", [?MODULE, ?LINE]),
                                                erlang:error({
                                                                        assert_failed,
                                                                        [
                                                                                {module, ?MODULE},
                                                                                {line, ?LINE},
                                                                                {expression, (??BoolExpr)},
                                                                                {expected, true},
                                                                                {value, case _Other of
                                                                                                false -> 
                                                                                                        _Other;
                                                                                                _Other2 -> 
                                                                                                        {not_a_boolean, _Other}
                                                                                        end}
                                                                        ]
                                                             })
                                end
                            end)())).

% 带打印附加表示式的值的断言
-define(ASSERT(BoolExpr, ExtraExpr), ((fun() ->
                                        case (BoolExpr) of
                                                true -> 
                                                        void;
                                                _Other ->       
                                                        ?ERROR_LOG("ASSERT FAILED! module=~p line=~p ExtraExpr=~p~n", [?MODULE, ?LINE, ExtraExpr]),
                                                        erlang:error({
                                                                                assert_failed,
                                                                                [
                                                                                        {module, ?MODULE},
                                                                                        {line, ?LINE},
                                                                                        {expression, (??BoolExpr)},
                                                                                        {expected, true},
                                                                                        {value, case _Other of
                                                                                                        false -> 
                                                                                                                _Other;
                                                                                                        _Other2 -> 
                                                                                                                {not_a_boolean, _Other}
                                                                                        end},
                                                                                        {extra_expr_val, (ExtraExpr)}
                                                                                ]
                                                                      })
                                        end
                                       end)())).

-define(TRACE(Str), io:format(Str ++ "~n")).
-define(TRACE(Str, Args), io:format(Str ++ "~n", Args)).

-define(TRACE2(Str), io:format(Str)).
-define(TRACE2(Str, Args), io:format(Str, Args)).

-define(TRACE_W(Str), io:format( "~ts~n", [list_to_binary( io_lib:format(Str, []) )] ) ).
-define(TRACE_W(Str, Args), io:format( "~ts~n", [list_to_binary( io_lib:format(Str, Args) )] ) ).

-else.

-define(ASSERT(BoolExpr), void).
-define(ASSERT(BoolExpr, ExtraExpr), void).

-define(TRACE(Str), void).
-define(TRACE(Str, Args), void).

-define(TRACE2(Str), void).
-define(TRACE2(Str, Args), void).

-define(TRACE_W(Str), void).
-define(TRACE_W(Str, Args), void).

-endif.

%%异常捕获相关宏定义
-ifdef(debug).

-define(TRY_CATCH_WITH_TIP(Expression, Tip, ErrReason), Expression).
-define(TRY_CATCH_WITH_CALL(Expression, CallModule, CallMethod), Expression).
-define(TRY_CATCH_WITH_KERNEL(Expression, ErrReason), Expression).
-define(TRY_CATCH_WITH_REASON(Expression, ErrReason), Expression).
-define(TRY_CATCH(Expression), Expression).
-define(TRY_CATCH(Expression, Tip), Expression).

-else.

-define(TRY_CATCH_WITH_TIP(Expression, Tip, ErrReason), try
                                                                Expression
                                                        catch 
                                                                _Any:ErrReason ->
                                                                        ?ERROR_LOG("~s, Catch exception: Reason:~p, Stacktrace:~p~n", [Tip, ErrReason, erlang:get_stacktrace()])
                                                        end).
-define(TRY_CATCH_WITH_CALL(Expression, CallModule, CallMethod), try
                                                                        Expression
                                                                 catch
                                                                        _Any:ErrReason ->
                                                                                apply(CallModule, CallMethod, [error, ?MODULE, ?LINE, "Catch exception: Reason:~p, Stacktrace:~p", [ErrReason, erlang:get_stacktrace()]])
                                                                 end).
-define(TRY_CATCH_WITH_KERNEL(Expression, ErrReason),   try
                                                                Expression
                                                        catch 
                                                                _Any:ErrReason ->
                                                                        error_logger:error_msg("Catch exception: Reason:~p, Stacktrace:~p~n", [ErrReason, erlang:get_stacktrace()])
                                                        end).
-define(TRY_CATCH_WITH_REASON(Expression, ErrReason),   try
                                                                Expression
                                                        catch 
                                                                _Any:ErrReason ->
                                                                        ?ERROR_LOG("Catch exception: Reason:~p, Stacktrace:~p~n", [ErrReason, erlang:get_stacktrace()])
                                                        end).
-define(TRY_CATCH(Expression), ?TRY_CATCH_WITH_REASON(Expression, _ErrReason)).
-define(TRY_CATCH(Expression, Tip), ?TRY_CATCH_WITH_TIP(Expression, Tip, _ErrReason)).

-endif.

-endif.