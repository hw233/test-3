%%%------------------------------------------------
%%% File    : debug.hrl
%%% Author  : huangjf
%%% Created : 2011-12-13
%%% Description: 调试相关的宏
%%%------------------------------------------------

%% 避免头文件多重包含
-ifndef(__DEBUG_H__).
-define(__DEBUG_H__, 0).





% -define(TEST_MSG(Format, Args),
%     logger:test_msg(?MODULE,?LINE,Format, Args)).
% -define(DEBUG_MSG(Format, Args),
%     logger:debug_msg(?MODULE,?LINE,Format, Args)).
% -define(INFO_MSG(Format, Args),
%     logger:info_msg(?MODULE,?LINE,Format, Args)).
% -define(WARNING_MSG(Format, Args),
%     logger:warning_msg(?MODULE,?LINE,Format, Args)).
% -define(ERROR_MSG(Format, Args),
%     logger:error_msg(?MODULE,?LINE,Format, Args)).
% -define(CRITICAL_MSG(Format, Args),
%     logger:critical_msg(?MODULE,?LINE,Format, Args)).

%访问日志

-ifdef(debug).

-define(ACCESS_MSG(Format, Args),
        sys_logger:write_log(access, ?MODULE, ?LINE, "~s"++Format, [misc:get_pid_info()|Args])).
-define(TEST_MSG(Format, Args),
        sys_logger:write_log(test, ?MODULE, ?LINE, "~s"++Format, [misc:get_pid_info()|Args])).
-define(DEBUG_MSG(Format, Args),
        sys_logger:write_log(debug, ?MODULE, ?LINE, "~s"++Format, [misc:get_pid_info()|Args])).
-define(INFO_MSG(Format, Args),
        sys_logger:write_log(info, ?MODULE, ?LINE, "~s"++Format, [misc:get_pid_info()|Args])).

-else.

-define(ACCESS_MSG(Format, Args), void).
-define(TEST_MSG(Format, Args), void).
-define(DEBUG_MSG(Format, Args), void).
-define(INFO_MSG(Format, Args), void).

-endif.

-ifdef(debug).

-define(SEND_BIN(PlayerId, Bin),
	lib_send:send_to_uid(PlayerId, Bin) ).
-else.
-define(SEND_BIN(PlayerId, Bin), void).
-endif.



-define(WARNING_MSG(Format, Args),
        sys_logger:write_log(warning, ?MODULE, ?LINE, "~s"++Format, [misc:get_pid_info()|Args])).
-define(ERROR_MSG(Format, Args),
        sys_logger:write_log(error, ?MODULE, ?LINE, "~s"++Format, [misc:get_pid_info()|Args])).
-define(CRITICAL_MSG(Format, Args),
        sys_logger:write_log(critical, ?MODULE, ?LINE, "~s"++Format, [misc:get_pid_info()|Args])).
%行为日志
-define(ACT_MSG(Format, Args),
        act_logger:write_log(info, ?MODULE, ?LINE, Format, Args)).

% 后台统计日志
-define(ADMIN_MSG(Args), act_logger:write_admin_log(info, Args)).






%% 断言以及打印调试信息宏
-ifdef(debug).

	-define(ASSERT(BoolExpr), ((fun() ->
								  	case (BoolExpr) of
										true -> void;
										__V ->
												?DEBUG_MSG("ASSERT FAILED!!! module=~w line=~w", [?MODULE, ?LINE]),
												erlang:error({assert_failed,
																[{module, ?MODULE},
											       			 	 {line, ?LINE},
											       			 	 {expression, (??BoolExpr)},
											       			 	 {expected, true},
											       			 	 {value, case __V of
											       			 				 false -> __V;
													   				 		 _ -> {not_a_boolean, __V}
												       				 	 end}]
												       		})
								    end
								end)())).

	% 带打印附加表示式的值的断言
	-define(ASSERT(BoolExpr, ExtraExpr), ((fun() ->
								  				case (BoolExpr) of
													true -> void;
													__V ->
															?DEBUG_MSG("ASSERT FAILED!!! module=~w line=~w ExtraExpr=~w", [?MODULE, ?LINE, ExtraExpr]),
															erlang:error({assert_failed,
																			[{module, ?MODULE},
											       			 	 			 {line, ?LINE},
											       			 	 			 {expression, (??BoolExpr)},
											       			 	 			 {expected, true},
											       			 	 			 {value, case __V of
											       			 				 			false -> __V;
													   				 					_ -> {not_a_boolean, __V}
												       				 	 			 end},
												       				 	 	 {extra_expr_val, (ExtraExpr)}]
												       					})
								    			end
										   end)())).



-else.

    -define(ASSERT(BoolExpr), void).
    -define(ASSERT(BoolExpr, ExtraExpr), void).

-endif.





-ifdef(debug_common_trace).

    -define(TRACE(Str), io:format(Str)).
    -define(TRACE(Str, Args), io:format(Str, Args)).
	% unicode版
	-define(TRACE_W(Str), io:format( "~ts", [list_to_binary( io_lib:format(Str, []) )] ) ).
	-define(TRACE_W(Str, Args), io:format( "~ts", [list_to_binary( io_lib:format(Str, Args) )] ) ).

-else.

	-define(TRACE(Str), void).
    -define(TRACE(Str, Args), void).

	-define(TRACE_W(Str), void).
	-define(TRACE_W(Str, Args), void).

-endif.




-ifdef (lds).  % 李大胜的相关调试项
-define(LDS_TRACE(Msg), io:format("~n====================== LDS ===================~ndesc : ~p~ninfo : ~p~n"
                                 "==============================================~n ", ["", Msg])).
-define(LDS_TRACE(Desc, Msg), io:format("~n====================== LDS ===================~ndesc : ~p~ninfo : ~p~n"
                                       "==============================================~n ", [Desc, Msg])).

-define(LDS_DEBUG(Msg), sys_logger:write_log(error, ?MODULE, ?LINE, "~n====================== LDS DEBUG ===================~ndesc : ~p~ninfo : ~p~n"
                                 "==============================================~n ", ["", Msg])).

-define(LDS_DEBUG(Desc, Msg), sys_logger:write_log(error, ?MODULE, ?LINE, "~n====================== LDS DEBUG ===================~ndesc : ~p~ninfo : ~p~n"
                                 "==============================================~n ", [Desc, Msg])).

-define(LDS_DEBUG_W(Desc, Msg), sys_logger:write_log(error, ?MODULE, ?LINE, "~n====================== LDS DEBUG ===================~ndesc : ~p~ninfo : ~w~n"
                                 "==============================================~n ", [Desc, Msg])).

-define(LDS_DEBUG_W(Msg), sys_logger:write_log(error, ?MODULE, ?LINE, "~n====================== LDS DEBUG ===================~ndesc : ~p~ninfo : ~w~n"
                                 "==============================================~n ", ["", Msg])).

-else.
-define(LDS_TRACE(Msg), void).
-define(LDS_TRACE(Desc, Msg), void).

-define(LDS_DEBUG(Msg), void).
-define(LDS_DEBUG(Desc, Msg), void).

-define(LDS_DEBUG_W(Msg), void).
-define(LDS_DEBUG_W(Desc, Msg), void).

-endif.

%% ----------------------------------------------------
%%  严利宏的相关调试项
-ifdef (yanlihong_debug).
-define(ylh_Debug(Msg), io:format("====================== yanlihong: [~p, ~p] : ===================~n"++Msg++"~n", [?MODULE, ?LINE])).
-define(ylh_Debug(Msg, Arg), io:format("====================== yanlihong: [~p, ~p] : ===================~n"++Msg++"~n", [?MODULE, ?LINE]++Arg)).

-else.
-define(ylh_Debug(Msg), void).
-define(ylh_Debug(Desc, Msg), void).

-endif.
%% ----------------------------------------------------





-define(TRAC(X), void).






-endif.  %% __DEBUG_H__
