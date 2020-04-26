
%% MySQL result record
-record(mysql_result, {
		fieldinfo = [],
		rows = [],
		affectedrows = 0,
		insertid = 0,
		error = "",    % error reason | error message
		errcode = 0,
		errsqlstate = ""
		}).



-define(DEFAULT_CALL_GENSRV_TIMEOUT, 5000).


%% 用于存储mysql连接断开时未处理的sql操作消息
-define(ETS_UNHANDLED_SQL_QUERIES_MSG, ets_unhandled_sql_queries_msg).