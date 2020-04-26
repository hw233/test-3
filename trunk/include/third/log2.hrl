-ifndef(__LOG2_H__).
-define(__LOG2_H__, 0).

%%日志信息
-define(LOG_PATH, "./logs/").
-define(LOG_TEMP_PATH, ?LOG_PATH ++ "temp/").
-define(LOG_PERF_PATH, ?LOG_PATH ++ "perf/").

-define(SYS_LOG_LEVELS, [{0, none,     error,    "NONE"},       %空白等级
                         {1, critical, error,    "CRITICAL"},   %严重等级
                         {2, error,    error,    "ERROR"},      %错误等级
                         {3, warning,  error,    "WARNING"},    %警告等级
                         {4, info,     info_msg, "INFO"},       %信息等级
                         {5, debug,    info_msg, "DEBUG"},      %调试等级
                         {6, test,     info_msg, "TEST"},       %测试等级
                         {7, access,   info_msg, "ACCESS"}]).   %访问等级

-define(SYS_LOG_LEVEL, app_opt:get_env(sys_log_level, 7)). %系统日志等级

-define(ACT_LOG_LEVELS, [{0, none, error,    "NONE"},    %空白等级
                         {1, info, info_msg, "INFO"}]).  %信息等级

-define(ACT_LOG_LEVEL, 1). %行为日志等级

-define(ACCESS_LOG(Format, Args),
        sys_logger:write_log(access, ?MODULE, ?LINE, Format, Args)).
-define(TEST_LOG(Format, Args),
        sys_logger:write_log(test, ?MODULE, ?LINE, Format, Args)).
-define(DEBUG_LOG(Format, Args),
        sys_logger:write_log(debug, ?MODULE, ?LINE, Format, Args)).
-define(INFO_LOG(Format, Args),
        sys_logger:write_log(info, ?MODULE, ?LINE, Format, Args)).
-define(WARNING_LOG(Format, Args),
        sys_logger:write_log(warning, ?MODULE, ?LINE, Format, Args)).
-define(ERROR_LOG(Format, Args),
        sys_logger:write_log(error, ?MODULE, ?LINE, Format, Args)).
-define(CRITICAL_LOG(Format, Args),
        sys_logger:write_log(critical, ?MODULE, ?LINE, Format, Args)).
-define(ACT_LOG(Format, Args),
        act_logger:write_log(info, ?MODULE, ?LINE, Format, Args)).

-define(ACT_CHIP_INTERVAL, 60 * 60).

-define(WEB_ACCESS_LOG(Env, Format, Args), 
        sys_logger:write_log_for_web(Env, access, ?MODULE, ?LINE, Format, Args)).

-ifdef(debug).
-define(TRACE_LOG(Content), io:format(log_io:format_event(Content))).
-else.
-define(TRACE_LOG(_Content), pass).
-endif.

-define(STAT_PROC_INTV, app_opt:get_env(stat_proc_intv, 1200)).

-endif.