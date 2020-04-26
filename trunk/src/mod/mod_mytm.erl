%%%------------------------------------
%%% @Module  : mod_mytm (my time)
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2012.3.5
%%% @Modified: 2014.3.21
%%% @Description: 自定义时间模块（用于辅助方便测试定时处理之类的功能），
%%%				  如果希望借助此模块来方便测试定时处理之类的功能，则写代码时：
%%%				  用mod_mytm:date()代替erlang:date()，
%%%               用mod_mytm:time()代替erlang:time()，
%%%               用mod_mytm:unixtime()代替util:unixtime()和svr_clock:get_unixtime()
%%%------------------------------------
-module(mod_mytm).


-ifdef(debug).

	-behaviour(gen_server).
	-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
	-export([start_link/0]).

-endif.


-export([
			unixtime/0,
			time/0,
			date/0,
			set_time/1,
			set_date/1,
			normalize_time/0
		]).

-include("common.hrl").


%% 无效的当前时间
-define(INVALID_CUR_TIME, {0, 0, 0}).
%% 无效的当前日期
-define(INVALID_CUR_DATE, {0, 0, 0}).
%% 无效的unix时间戳
-define(INVALID_UNIXTIME, 0).
    

%% ==================================================================================
 
%% ================== debug版本的函数定义 ========================
-ifdef(debug).

	-record(mytm_state, {
			diff_time = 0 % 差值：真实的unix时间戳 - 自己设置的时间所对应的unix时间戳， 单位：秒
			}).

	-define(MYTIME_PROCESS_NAME, ?MODULE).

	% 开启server
	start_link() ->
		?TRACE("[mod_mytm] this is debug version's start_link()...~n"),
    	gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

	%% 获取当前unix时间戳
	%% @return: 无效unix时间戳 | UnixTime
	unixtime() ->
		?TRACE("[mod_mytm] this is debug version's unixtime()...~n"),
		case catch gen_server:call(?MYTIME_PROCESS_NAME, {'GET_UNIXTIME'}) of
    	    {'EXIT', _Reason} ->
    	        ?ASSERT(false, _Reason),
    	        ?INVALID_UNIXTIME;
    	    UnixTime ->
    	        UnixTime
    	end.
	
	%% 获取当前时间
	%% @return: 无效当前时间 | {时，分，秒}
	time() ->
		case catch gen_server:call(?MYTIME_PROCESS_NAME, {'GET_CUR_TIME'}) of
    	    {'EXIT', _Reason} ->
    	        ?ASSERT(false, _Reason),
    	        ?INVALID_CUR_TIME;
    	    {Hour, Min, Sec} ->
    	        {Hour, Min, Sec}
    	end.
	
	%% 获取当前日期
	%% @return: 无效当前日期 | {年，月，日}
	date() ->
		case catch gen_server:call(?MYTIME_PROCESS_NAME, {'GET_CUR_DATE'}) of
    	    {'EXIT', _Reason} ->
    	    	?ASSERT(false, _Reason),
    	        ?INVALID_CUR_DATE;
    	    {Year, Month, Day} ->
    	        {Year, Month, Day}
    	end.
	
	%% 设置当前时间
	%% return: fail | ok
	set_time({Hour, Min, Sec}) ->
		case catch gen_server:call(?MYTIME_PROCESS_NAME, {'SET_CUR_TIME', {Hour, Min, Sec}}) of
    	    {'EXIT', _Reason} ->
    	    	?DEBUG_MSG("mod_mytm:set_time(), exit for reason: ~w", [_Reason]),
    	        fail;
    	    ok ->
    	        ok
    	end.
	
	%% 设置当前日期
	%% return: fail | ok
	set_date({Year, Month, Day}) ->
		case catch gen_server:call(?MYTIME_PROCESS_NAME, {'SET_CUR_DATE', {Year, Month, Day}}) of
    	    {'EXIT', _Reason} ->
    	    	?DEBUG_MSG("mod_mytm:set_time(), exit for reason: ~w", [_Reason]),
    	        fail;
    	    ok ->
    	        ok
    	end.
    	
    %% 使时间和日期恢复正常
    %% return: fail | ok
	normalize_time() ->
		case catch gen_server:call(?MYTIME_PROCESS_NAME, {'normalize_time'}) of
    	    {'EXIT', _Reason} ->
    	    	?DEBUG_MSG("mod_mytm:normalize_time(), exit for reason: ~w", [_Reason]),
    	        fail;
    	    ok ->
    	        ok
    	end.

%% ================== release版本的函数定义 ========================
-else.

	%% 等同于util:unixtime()
	unixtime() ->
		%%io:format("[mod_mytm] this is release version's unixtime()...~n", []),
		util:unixtime().
		
	%% 等同于erlang标准库的time()
	time() ->
		erlang:time().
		
	%% 等同于erlang标准库的date()
	date() ->
		erlang:date().
	
	%% release版本中此函数无效
	set_time({_Hour, _Min, _Sec}) ->
		void.
	
	%% release版本中此函数无效
	set_date({_Year, _Month, _Day}) ->
		void.
		
	%% release版本中此函数无效
	normalize_time() ->
		void.
		
-endif.

%% ========================================================================================





-ifdef(debug).

	init([]) ->
	    process_flag(trap_exit, true),
		%%misc:register(global, ?GLOBAL_MYTIME_PROCESS, self()),  -- 不再注册为全局进程，而是只作为本地进程，故注释掉！
		InitState = #mytm_state{diff_time = 0},
		{ok, InitState}.
		
		
	%% 获取当前unix时间戳（仅用于debug版本）
	handle_call({'GET_UNIXTIME'}, _From, State) ->
		DiffTime = State#mytm_state.diff_time,
		UnixTime = case DiffTime == 0 of
					   true -> util:unixtime();
					   false -> util:unixtime() - DiffTime
				   end,
		{reply, UnixTime, State};
		

	%% 获取当前时间（仅用于debug版本）
	handle_call({'GET_CUR_TIME'}, _From, State) ->
		CurTime = case State#mytm_state.diff_time == 0 of
					  true -> erlang:time();
					  false -> get_cur_time(State)
				  end,
		{reply, CurTime, State};
	    
	%% 设置当前时间（仅用于debug版本）
	handle_call({'SET_CUR_TIME', {Hour, Min, Sec}}, _From, State) ->
		{Year, Mon, Day} = 	case State#mytm_state.diff_time == 0 of
								true -> erlang:date();
								false -> get_cur_date(State)
				  			end,
		% 计算新的差值
		NewDiffTime = util:unixtime() - util:date_to_stamp({{Year, Mon, Day}, {Hour, Min, Sec}}),
		?TRACE("[mod_mytm] SET_CUR_TIME, new diff time: ~p!!!~n", [NewDiffTime]),
		NewState = State#mytm_state{diff_time = NewDiffTime},
	    {reply, ok, NewState};
	    
	    
	%% 获取当前日期（仅用于debug版本）
	handle_call({'GET_CUR_DATE'}, _From, State) ->
		CurDate = case State#mytm_state.diff_time == 0 of
					  true -> erlang:date();
					  false -> get_cur_date(State)
				  end,
		{reply, CurDate, State};
	    
	%% 设置当前日期（仅用于debug版本）
	handle_call({'SET_CUR_DATE', {Year, Mon, Day}}, _From, State) ->
		{Hour, Min, Sec} = 	case State#mytm_state.diff_time == 0 of
								true -> erlang:time();
								false -> get_cur_time(State)
				  			end,
		% 计算新的差值
		NewDiffTime = util:unixtime() - util:date_to_stamp({{Year, Mon, Day}, {Hour, Min, Sec}}),
		?TRACE("[mod_mytm] SET_CUR_DATE, new diff time: ~p!!!~n", [NewDiffTime]),
		NewState = State#mytm_state{diff_time = NewDiffTime},
	    {reply, ok, NewState};
	    
	    
	%% 使时间和日期恢复正常（仅用于debug版本）
	handle_call({'normalize_time'}, _From, _State) ->
		NewState = #mytm_state{diff_time = 0},
	    {reply, ok, NewState};

	handle_call(_Request, _From, State) ->
		?ASSERT(false),
	    {reply, State, State}.
	    

	handle_cast(_Msg, State) ->
		?ASSERT(false),
	    {noreply, State}.
		
	handle_info(_Info, State) ->
	    {noreply, State}.

	terminate(_Reason, _State) ->
	    ok.

	code_change(_OldVsn, State, _Extra) ->
	    {ok, State}.
	    
	    
	    
	%% =================== Local Functions For Debug Version ================================================

	%% 动态获取自己设置的当前日期
	%% @return: {年，月，日}
	get_cur_date(MyTimeState) ->
		DiffTime = MyTimeState#mytm_state.diff_time,
		MyUnixTime = util:unixtime() - DiffTime,
		% 时间戳转为日期和时间
		{{Year, Mon, Day}, {_Hour, _Min, _Sec}} = util:stamp_to_date(MyUnixTime, 5),
		{Year, Mon, Day}.


	%% 动态获取自己设置的当前时间
	%% @return: {时，分，秒}
	get_cur_time(MyTimeState) ->
		DiffTime = MyTimeState#mytm_state.diff_time,
		MyUnixTime = util:unixtime() - DiffTime,
		% 时间戳转为日期和时间
		{{_Year, _Mon, _Day}, {Hour, Min, Sec}} = util:stamp_to_date(MyUnixTime, 5),
		{Hour, Min, Sec}.

-endif.