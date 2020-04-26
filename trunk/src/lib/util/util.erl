%%%-----------------------------------
%%% @Module  : util
%%% @Author  :
%%% @Email   :
%%% @Created : 2011.04.15
%%% @Description: 公共函数
%%%-----------------------------------
-module(util).
-export([
        unixtime/0,
        unixtime_record/0,
        unixtime_record/1,
        longunixtime/0,
        md5/1,
        rand/0,
        rand/2,
        rand_by_weight/2,
        rand_by_weight/3,
        rand_by_weight2/2,
        rand_list_n/2,
        decide_proba_once/1, decide_proba_once/2,
		ceil/1,
		avg/1,
        floor/1,
        thousand_floor/1,
		minmax/3,
        sleep/1,
        sleep/2,
        get_list/2,
        implode/2,
        implode/3,
        explode/2,
        explode/3,
        for/3,
        for/4,
        string_to_term/1,
        bitstring_to_term/1,
        term_to_string/1,
        term_to_bitstring/1,
        utf8_list_to_binary/1,
        utf8_binary_to_list/1,
        match_one/2,
        match_all/2,

		conn_logger_node/1,
		conn_gateway_node/1,
		stamp_to_date/0,
		stamp_to_date/1,
		stamp_to_date/2,
		date_to_stamp/1,
    get_days_by_timestamp/1,

        today_date/0,
        yesterday_date/0,
        half_month_ago_date/0,
        one_month_ago_date/0,
        date_to_int/1,

        actin_new_proc/3,
        bool_to_oz/1,
        oz_to_bool/1,

        calc_manhattan_distance/4,

        in_range/3,
        calc_today_0_sec/0,
        calc_week_left/0,
        get_monday/0,
        is_even/1,
        is_odd/1,

        is_positive_int/1,
        is_nonnegative_int/1,
        is_percent/1,
        is_probability/1,
        is_integer_list/1,
        is_tuple_list/1,
        is_numeric_tuple/1,
        is_numeric_list/1,

        is_refresh_daily_hour/3,
        get_datetime_by_timestamp/1,
        get_timestamp_by_datetime/1,
        get_now_days/0,

        get_server_first_open_time/0,
        get_server_first_open_stamp/0,
        set_server_first_open_stamp/1,

        get_unixtime_next_month_begin/0,

        is_binary_list/1,
        sum_tuple/1,
        get_server_open_stamp/0,
        get_server_open_time/0,
        list_member/2,
        get_server_open_nth_day/0,
        get_nth_day_from_time_to_now/1,
        get_month/0,
        get_day/0,
        get_hour/0,
        get_week/0,
        get_week/1,
        get_year/0,
        is_same_day/1,
        is_same_week/1,
        is_same_month/1,
        has_illegal_char/1,

        is_string/1,
        json_parse/1,
        json_pack/2,
        json_pack/1,
        string_width/1,
        string_width_1/1,
        random_list/1,

        get_week_assign_day_dawn_timestamp/2,
        get_day_dawn_timestamp/1,
        get_now_by_timestamp/1,
        is_timestamp_same_day/2,
        is_timestamp_same_week/2,
        get_differ_days_by_timestamp/2,
        get_seconds_from_midnight/0,
        get_seconds_from_midnight/1,

        to_binary/1,
        rec_to_pl/2,
        pl_to_rec/3,
        record_to_proplist/2,
        r2p/2,
        duplicate_key_sum_value/1,

        index_of/2,

        shuffle/1,

        rand_pick_one_by_weight/2,
        dbg_test_rand_pick_one_by_weight/3, % 仅仅用于测试！

        get_value/3,
        get_call_stack/0,
        empty_stacktrace/0,
		
		request_get/2,
		request_post/2
    ]).


-compile({inline, [oz_to_bool/1, bool_to_oz/1] }).


-include("common.hrl").
-include("record.hrl").

% 随机从列表获取N个元素
rand_list_n(List, N) ->
    case length(List) >= N of
        true ->
            rand_list_n(List, N, []);
        false ->
            List
    end.

rand_list_n([], _N, Acc) ->
    Acc;
rand_list_n(_List, 0, Acc) ->
    Acc;
rand_list_n(List, N, Acc) ->
    Nth = util:rand(1, N),
    Ele = lists:nth(Nth, List),
    NewList = lists:delete(Ele, List),
    rand_list_n(NewList, N-1, [Ele|Acc]).

%% 判断一个整数是否偶数
is_even(Number) -> (Number rem 2) == 0.

%% 判断一个整数是否奇数
is_odd(Number) -> (Number rem 2) /= 0.

%% 判断Num是否在指定的范围内
in_range(Num, Min, Max) ->
    Min =< Num andalso Num =< Max.





%% 是否为正整数？
is_positive_int(Num) ->
    is_integer(Num) andalso Num > 0.


%% 是否为非负整数？
is_nonnegative_int(Num) ->
    is_integer(Num) andalso Num >= 0.


%% 是否为百分比？
is_percent(Num) ->
    Num == 0
    orelse Num == 1
    orelse (is_float(Num) andalso Num > 0 andalso Num < 1).


%% 判断某数是否为概率值
is_probability(Num) ->
    Num == 0 orelse Num == 1 orelse (is_float(Num) andalso Num > 0 andalso Num < 1).


%% 判断列表里的元素是否都为整型，空列表的情况规定返回true
is_integer_list([H | T]) when is_integer(H) ->
    is_integer_list(T);
is_integer_list([]) -> true;
is_integer_list(_) -> false.


%% 判断某Term是否为元组列表，注：对于空列表的情况，返回true
is_tuple_list(Term) ->
    case is_list(Term) of
        true -> is_tuple_list__(Term);
        false -> false
    end.

is_tuple_list__([H | T]) ->
    case is_tuple(H) of
        true -> is_tuple_list__(T);
        false -> false
    end;
is_tuple_list__([]) ->
    true.


%% 判断元组里的元素是否都为数值类型，空元组的情况返回true
is_numeric_tuple({}) ->
    true;
is_numeric_tuple(Tuple) ->
    is_numeric_list(tuple_to_list(Tuple)).


%% 判断列表里的元素是否都为数值类型，空列表的情况返回true
is_numeric_list([H | T]) when is_number(H) ->
    is_numeric_list(T);
is_numeric_list([]) -> true;
is_numeric_list(_) -> false.





%% 判断列表里的元素是否都为整型，空列表的情况返回true
is_binary_list([H | T]) when is_binary(H) ->
    is_binary_list(T);
is_binary_list([]) -> true;
is_binary_list(_) -> false.


%% 对元组中的元素（都为数值）求和
sum_tuple(Tuple) ->
    lists:sum(tuple_to_list(Tuple)).




%% desc: 获取1970至本周星期一凌晨0点0分0秒的秒数
get_monday() ->
    NowTime = unixtime(),
    Week  = calendar:day_of_the_week(date()),
    % 计算周日23：59是多少秒
    TodaySeconds = calendar:time_to_seconds(time()),
    NowTime - (Week - 1) * ?ONE_DAY_SECONDS - TodaySeconds.

%% true转为数字1，false转为数字0， oz表示one zero
bool_to_oz(Boolean) ->
	case Boolean of
		true -> 1;
		false -> 0
	end.

%% 数字1转为true，0转为false， oz表示one zero
oz_to_bool(Num) ->
	case Num of
		1 -> true;
		0 -> false
	end.


%% 计算曼哈顿距离
calc_manhattan_distance(X1, Y1, X2, Y2) ->
    abs(X2 - X1) + abs(Y2 - Y1).



%% 获取今天的日期（整数格式）
%% @return: 转为整数格式的日期
today_date() ->
    date_to_int(erlang:date()).


%% 获取昨天的日期（整数格式）
%% @return: 转为整数格式的日期
yesterday_date() ->
    TimeNow = unixtime(),
    Diff = 24* 3600,  % 24小时的秒数
    % 时间戳转为日期和时间
    {{Year, Mon, Day}, {_Hour, _Min, _Sec}} = stamp_to_date(TimeNow - Diff, 5),
    ?ASSERT({Year, Mon, Day} /= erlang:date(), {Year, Mon, Day}),
    date_to_int({Year, Mon, Day}).


%% 获取半个月前（15天前）的日期
%% @return: 转为整数格式的日期
half_month_ago_date() ->
    TimeNow = unixtime(),
    Diff = 15 * 24* 3600,  % 15天的秒数
    % 时间戳转为日期和时间
    {{Year, Mon, Day}, {_Hour, _Min, _Sec}} = stamp_to_date(TimeNow - Diff, 5),
    date_to_int({Year, Mon, Day}).


%% 获取一个月前（30天前）的日期
%% @return: 转为整数格式的日期
one_month_ago_date() ->
    TimeNow = unixtime(),
    Diff = 30 * 24* 3600,  % 30天的秒数
    % 时间戳转为日期和时间
    {{Year, Mon, Day}, {_Hour, _Min, _Sec}} = stamp_to_date(TimeNow - Diff, 5),
    date_to_int({Year, Mon, Day}).



%% 日期转为整数
date_to_int({Year, Month, Day}) ->
    Year*10000 + Month*100 + Day.





%% @desc: 将秒数转化成记录体
%% @spec: unixtime_record() -> #unixtime{}
unixtime_record() ->
    unixtime_record( util:unixtime() ).
%% @spec: unixtime_record(Unixtime) -> #unixtime{}
%% 因为有时差的关系，所以简单起见、这里直接调用BIF函数和calendar模块的函数(误差范围不大于1秒)
unixtime_record(Unixtime) ->

    MS = Unixtime div 1000000,
    S = Unixtime - MS * 1000000,
    TimeTuple = {MS, S, 0},   % todo--精确度，秒，以后可以进一步修改 ，其实参数 unixtime 只是精确到秒

    {{Year, Month, Day}, {Hours, Minutes, Seconds}} = calendar:now_to_local_time(TimeTuple),

    DayOfWeek = calendar:day_of_the_week({Year, Month, Day}),

    Fun = fun(M, Sum) ->  Sum + calendar:last_day_of_the_month(Year, M)  end,
    MList = case Month == 1 of
                true -> [];
                false -> lists:seq(1, Month - 1)
            end,
    DayOfYear = lists:foldl(Fun, 0, MList) + Day,

    WeekOfYear = (DayOfYear - DayOfWeek) div 7 + 1,   % 按惯例，以周一为一周的开始

    TodayZeroToNow = calendar:time_to_seconds({Hours, Minutes, Seconds}),

    % return
    #unixtime{
              year = Year,
              month = Month,
              week = WeekOfYear,
              day = Day,

              day_of_year = DayOfYear,
              day_of_month = Day,
              day_of_week = DayOfWeek,

              last_day_of_month = calendar:last_day_of_the_month(Year, Month),
              last_day_of_year = case calendar:is_leap_year(Year) of true -> 366; false -> 365 end,

              hour = Hours,
              minute = Minutes,
              seconds = Seconds,

              seconds_since_midnight = TodayZeroToNow,
              seconds_since_week_midnight = TodayZeroToNow + (DayOfWeek - 1) * 24 * 60 * 60
              }.

%% 在List中的每两个元素之间插入一个分隔符
%% e.g. implode("-", [2, 3, 4])  ->  ["2", "-", "3", "-", "4"]
implode(_S, [])->
	[<<>>];
implode(S, L) when is_list(L) ->
    implode(S, L, []).
implode(_S, [H], NList) ->
    lists:reverse([thing_to_list(H) | NList]);
implode(S, [H | T], NList) ->
    L = [thing_to_list(H) | NList],
    implode(S, T, [S | L]).

%% 字符->列
%% e.g. explode("-", "2-3-4")  ->  ["2", "-", "3", "-", "4"]
explode(S, B)->
    re:split(B, S, [{return, list}]).
explode(S, B, int) ->
    [list_to_integer(Str) || Str <- explode(S, B), length(Str) > 0].

thing_to_list(X) when is_integer(X) -> integer_to_list(X);
thing_to_list(X) when is_float(X)   -> float_to_list(X);
thing_to_list(X) when is_atom(X)    -> atom_to_list(X);
thing_to_list(X) when is_binary(X)  -> binary_to_list(X);
thing_to_list(X) when is_list(X)    -> X.

%% 取得当前的unix时间戳
%% 单位：秒
unixtime() ->
    {M, S, _} = os:timestamp(),
    M * 1000000 + S.
%% 单位：毫秒
longunixtime() ->
    {M, S, Ms} = os:timestamp(),
    M * 1000000000 + S*1000 + Ms div 1000.

%% 转换成HEX格式的md5
md5(S) ->
    lists:flatten([io_lib:format("~2.16.0b",[N]) || N <- binary_to_list(erlang:md5(S))]).


%% 产生一个介于Min到Max之间的随机整数
rand(Same, Same) -> Same;

% 计算小数随机
rand(Min1, Max1) when is_float(Min1) ->
    Min = erlang:round(Min1*10000),
    Max = erlang:round(Max1*10000),
    before_rand__(),
    M = Min - 1,
    Ret = random:uniform(Max - M) + M,
    Ret1 = case random:uniform(2) of  % 为了稍缓解概率密集，故有一半的概率再uniform一次  -- huangjf
        1 ->
            Ret;
        2 ->
            random:uniform(Max - M) + M
    end,

    % 就还原成小数
    Ret1/10000;

rand(Min, Max) ->
    before_rand__(),
    M = Min - 1,
    Ret = random:uniform(Max - M) + M,
    case random:uniform(2) of  % 为了稍缓解概率密集，故有一半的概率再uniform一次  -- huangjf
        1 ->
            Ret;
        2 ->
            random:uniform(Max - M) + M
    end.

%% Returns a random float uniformly distributed between 0.0 and 1.0
rand() ->
    before_rand__(),
    Ret = random:uniform(),
    case random:uniform(2) of
        1 ->
            Ret;
        2 ->
            random:uniform()
    end.


before_rand__() ->
    case erlang:get("__rand_seed__") of
        undefined ->
            RandSeed = mod_rand:make_seed(), %%old: mod_rand:get_seed(),
            random:seed(RandSeed),
            erlang:put("__rand_seed__", RandSeed);
        _ -> skip
    end.



%% 把列表中的元素随机打乱, 列表较大时慎用！
random_list([]) -> [];
random_list(List)->
    random_list_1(List, 0, erlang:length(List)).

random_list_1([], _, _) -> [];
random_list_1(_, Step, Max) when Step >= Max -> [];
random_list_1(List, Step, Max) ->
    Len = erlang:length(List),
    Elem = lists:nth(rand(1, Len), List),
    [Elem | random_list_1(lists:delete(Elem, List), Step + 1, Max)].




%% 判定一次概率是否成功
%% @return：success => 成功
%%          fail => 失败
decide_proba_once(0) -> fail;
decide_proba_once(1) -> success;
decide_proba_once(Proba) when is_float(Proba) ->
    Expand = lib_drop:tst_get_drop_prob_expand(),
    Proba1 = Proba * Expand,
    case Proba1 >= 1 of
        true -> success;
        false -> do_decide_proba_once(Proba1)
    end.



%% 判定一次概率是否成功，概率基数由参数指定（要求不小于100）
%% @return：success => 成功
%%          fail => 失败
decide_proba_once(0, _) -> fail;
decide_proba_once(1, _) -> success;
decide_proba_once(Proba, ProbaBase) when is_float(Proba), is_integer(ProbaBase), ProbaBase >= 100 ->
    case rand(1, ProbaBase) =< (Proba * ProbaBase) of
        true ->
            success;
        false ->
            fail
    end.



do_decide_proba_once(Proba) ->
    case rand(1, 10000000) =< (Proba * 10000000) of  % 放大1000万倍再比较
        true ->
            success;
        false ->
            fail
    end.

%% 取平均值
avg(NS) ->
	ASum = lists:foldl(fun(N, Sum) -> N + Sum end, 0, NS),
	ASum / length(NS).

%%%%向下取整
%%ceil(N) ->
%%  T = trunc(N),
%%  case N == T of
%%    true  -> T;
%%    false -> 1 + T
%%  end.

%%向下取整
ceil(X) ->
  T = trunc(X),
  case (X < T) of
    true -> T - 1;
    _ -> T
  end.

%%向下取整
floor(X) ->
    T = trunc(X),
    case (X < T) of
        true -> T - 1;
        _ -> T
    end.

%% 千位向下取整
thousand_floor(X) when X =< 1000 ->
    trunc(X);
thousand_floor(X) ->
    trunc(X / 1000) * 1000.


%%返回X在[Min, Max]区间内的值
minmax(X, Min, Max) ->
	min(max(X, Min), Max).

 sleep(T) ->
    receive
    after T -> ok
    end.

 sleep(T, F) ->
    receive
    after T -> F()
    end.

get_list([], _) ->
    [];
get_list(X, F) ->
    F(X).

%% for循环
for(Max, Max, F) ->
    F(Max);
for(I, Max, F)   ->
    F(I),
    for(I+1, Max, F).

%% 带返回状态的for循环
%% @return {ok, State}
for(Max, Min, _F, State) when Min<Max -> {ok, State};
for(Max, Max, F, State) -> F(Max, State);
for(I, Max, F, State)   -> {ok, NewState} = F(I, State), for(I+1, Max, F, NewState).

%% term序列化，term转换为string格式，e.g., [{a},1] => "[{a},1]"
term_to_string(Term) ->
    binary_to_list(list_to_binary(io_lib:format("~p", [Term]))).

%% term序列化，term转换为bitstring格式，e.g., [{a},1] => <<"[{a},1]">>
term_to_bitstring(Term) ->
    erlang:list_to_bitstring(io_lib:format("~p", [Term])).

%% term反序列化，string转换为term，e.g., "[{a},1]"  => [{a},1]
string_to_term(String) ->
    case erl_scan:string(String++".") of
        {ok, Tokens, _} ->
            case erl_parse:parse_term(Tokens) of
                {ok, Term} -> Term;
                _Err -> undefined
            end;
        _Error ->
            undefined
    end.

%% term反序列化，bitstring转换为term，e.g., <<"[{a},1]">>  => [{a},1]
bitstring_to_term(undefined) -> undefined;
bitstring_to_term(<<>>) -> undefined;
bitstring_to_term(BitString) ->
    string_to_term(binary_to_list(BitString)).


%% unicode list转换成utf8 binary
utf8_list_to_binary(List) when is_list(List) ->
    case asn1rt:utf8_list_to_binary(List) of
        {ok, Bin} -> Bin;
        {error, Reason} ->
            ?ASSERT(false, [Reason]),
            ?ERROR_MSG("utf8_list_to_binary error, Arg = ~p, Reason = ~p~n", [List, Reason]),
            undefined
    end;
utf8_list_to_binary(_Arg) ->
    ?ASSERT(false, [_Arg]),
    undefined.

%% utf8 binary转换成 unicode list
utf8_binary_to_list(Bin) when is_binary(Bin) ->
    case asn1rt:utf8_binary_to_list(Bin) of
        {ok, List} -> List;
        {error, Reason} ->
            ?ASSERT(false, [Reason]),
            ?ERROR_MSG("utf8_binary_to_list error, Arg = ~p, Reason = ~p~n", [Bin, Reason]),
            undefined
    end;
utf8_binary_to_list(_Arg) ->
    ?ASSERT(false, [_Arg]),
    undefined.



%% ETS匹配操作
match_one(Table, Pattern) ->
    Record = ets:match_object(Table, Pattern),
    if  Record =:= [] ->
            [];
        true ->
            [R] = Record,
            R
    end.

match_all(Table, Pattern) ->
    ets:match_object(Table, Pattern).

%% 计算本周剩余时间
calc_week_left() ->
    Unixtime = unixtime_record(),
    (7 * 24 * 60 * 60) - Unixtime#unixtime.seconds_since_week_midnight.

%% desc: 1970到今天凌晨0点0分0秒的秒数
calc_today_0_sec() ->
    unixtime() - calendar:time_to_seconds(time()).

%%标准unix时间戳转为日期和时间
stamp_to_date()  ->
    stamp_to_date(0, 0).
stamp_to_date(Time)  ->
    stamp_to_date(Time, 0).
stamp_to_date(Time, Type)  ->
    if Time =:= 0   ->
            Nlocal = calendar:local_time(),
            Ntime  = calendar:datetime_to_gregorian_seconds(Nlocal);
        true    ->
            Dlocal= calendar:universal_time_to_local_time({{1970, 1, 1},{0,0,0}}),
            D1970 = calendar:datetime_to_gregorian_seconds(Dlocal),
            Ntime = D1970 + (if is_list(Time) ->
                                    list_to_integer(Time);
                                true ->
                                    Time
                            end)
    end,
    {{Y2,M2,D2},{H2,I2,S2}} = calendar:gregorian_seconds_to_datetime(Ntime),
    {{Y, M, D}, {H, I, S}}  = {{date_format(Y2),date_format(M2),date_format(D2)},{date_format(H2),date_format(I2),date_format(S2)}},
    case Type of
        1   ->
            Date = Y++"年"++M++"月"++D++"日 "++H++"时"++I++"分"++S++"秒",
			list_to_binary(Date);
        2   ->
            Date = Y++"年"++M++"月"++D++"日",
			list_to_binary(Date);
        3   ->
            Date = Y++"-"++M++"-"++D,
			list_to_binary(Date);
        4   ->
            Date = Y++M++D,
			list_to_binary(Date);
		5   -> % 返回元组格式：{{年，月，日}，{时，分，秒}}
			{{Y2,M2,D2},{H2,I2,S2}};
        _   ->
            Date = Y++"-"++M++"-"++D++" "++H++":"++I++":"++S,
			list_to_binary(Date)
    end.

date_format(M)   ->
    if M < 10   ->
       N = "0" ++ integer_to_list(M);
       true ->
           N = integer_to_list(M)
    end,
    N.

%% 指定日期和时间转为标准unix时间戳
%% para: Datetime => 和erlang:localtime()返回的格式一致，即{{年，月，日}, {时，分，秒}}
date_to_stamp(Datetime) when is_tuple(Datetime) ->
	{{Year, Month, Day},{Hour, Minute, Second}} = Datetime,
	Seconds=calendar:datetime_to_gregorian_seconds({{Year, Month, Day}, {Hour, Minute, Second}}),
    Dlocal= calendar:universal_time_to_local_time({{1970, 1, 1},{0,0,0}}),  %当地1970年
    D1970 = calendar:datetime_to_gregorian_seconds(Dlocal),
    Seconds-D1970;

%% para: Datetime => "Y-M-D h:m:s", 每位时间数为双位,如:2012-01-01 08:05:09
date_to_stamp(Datetime) ->
	BinDatetime = tool:to_binary(Datetime),
	{Date, TimeTemp}= split_binary(BinDatetime,10),
    {_, Time} = split_binary(TimeTemp,1),
    [Y,M,D] = case string:tokens(binary_to_list(Date), "-") of
        [BY,BM,BD] ->
            [list_to_integer(BY),list_to_integer(BM),list_to_integer(BD)];
        _ ->
            [1970,1,1]
    end,
    [H,I,S] = case string:tokens(binary_to_list(Time), ":") of
        [BH,BI,BS] ->
            [list_to_integer(BH),list_to_integer(BI),list_to_integer(BS)];
        [BH,BI] ->
            [list_to_integer(BH),list_to_integer(BI),0];
        [BH] ->
            [list_to_integer(BH),0,0];
        _ ->
            [0,0,0]
    end,
    Seconds=calendar:datetime_to_gregorian_seconds({{Y, M, D}, {H, I, S}}),
    Dlocal= calendar:universal_time_to_local_time({{1970, 1, 1},{0,0,0}}),  %当地1970年
    D1970 = calendar:datetime_to_gregorian_seconds(Dlocal),
    Seconds-D1970.



%% 连接logger节点
conn_logger_node(App) ->
	Logger_node = config:get_logger_node(App),
	net_adm:ping(Logger_node),
	sync_registered_names(Logger_node),
    ok.

%% 连接gateway节点
conn_gateway_node(App) ->
	Gateway_node = config:get_gateway_node(App),
	net_adm:ping(Gateway_node).

%% 同步节点Node的注册进程名到本地节点（用于Node节点是hidden节点的情况）
sync_registered_names(Node) ->
	Registered_names = rpc:call(Node, global, registered_names, []),
	F = fun(Name) ->
				Pid = rpc:call(Node, global, whereis_name, [Name]),
				global:register_name(Name, Pid)
		end,
	[F(Name) || Name <- Registered_names].


get_server_open_stamp() ->
    case ets:lookup(?ETS_SERVER_OPEN_TIME, stamp) of
        [] -> ?ASSERT(false), error;
        [Record] -> Record
    end.

get_server_open_time() ->
    case ets:lookup(?ETS_SERVER_OPEN_TIME, time) of
        [] -> ?ASSERT(false), error;
        [Record] -> Record
    end.


%% 取服务器首次开服时间
%% @return : timestamp::integer() | null
get_server_first_open_stamp() ->
    case ets:lookup(?ETS_SERVER_OPEN_TIME, first_time) of
        [{first_time, {Date, Time}}] -> get_timestamp_by_datetime({Date, Time});
        _ -> null
    end.

%% @return : {date(), time()} | null
get_server_first_open_time() ->
    case ets:lookup(?ETS_SERVER_OPEN_TIME, first_time) of
        [{first_time, {Date, Time}}] -> {Date, Time};
        _ -> null
    end.


%% @doc 设置首次开服时间
%% @Timestamp::integer()
set_server_first_open_stamp(Timestamp) ->
    ets:insert(?ETS_SERVER_OPEN_TIME, {first_time, util:get_datetime_by_timestamp(Timestamp)}),
    db:update(first_open_server_time, [{first_timestamp, Timestamp}], []),
    ok.


actin_new_proc(Mod, Func, Args) ->
    Fun = fun() ->
                  case catch apply(Mod, Func, Args) of
                      {'EXIT', Reason} ->
                          ?ERROR_MSG("actin_new_proc failed, Mod:~p, Func:~p, Reason:~w", [Mod, Func, Reason]);
                      _ ->
                          skip
                  end
          end,
    spawn(Fun).


list_member([], _) -> true;
list_member([Elm | Left], List) ->
    case lists:member(Elm, List) of
        true -> list_member(Left, List);
        false -> false
    end.

%% 获取开服第几天，开服当天算开服第一天
get_server_open_nth_day() ->
    Time =
        case get_server_first_open_stamp() of
            null -> unixtime();
            TTime -> TTime
        end,

    Now = unixtime(),
    case is_same_day(Time) of
        true -> 1;
        false ->
            TimeDelta =
                case Now > Time of
                    true -> Now - Time;
                    false -> Time - Now
                end,
            WholeDay = floor(TimeDelta / (3600 * 24)),
            if
                Now > Time ->
                    TempTime = Time + WholeDay * (3600 * 24),
                    case is_same_day(TempTime) of
                        true -> WholeDay + 1;
                        false -> WholeDay + 2
                    end;
                true ->
                    TempTime = Now + WholeDay * (3600 * 24),
                    case is_same_day(TempTime) of
                        true -> WholeDay + 1;
                        false -> WholeDay + 2
                    end
            end
    end.


%% 以某个时间戳为起点，判断从这个时间点到现在，是第几天，如果Timestamp与今天是同一天，则返回1，依次类推
get_nth_day_from_time_to_now(Time) ->
    Now = unixtime(),
    case is_same_day(Time) of
        true -> 1;
        false ->
            TimeDelta =
                case Now > Time of
                    true -> Now - Time;
                    false -> Time - Now
                end,
            WholeDay = floor(TimeDelta / (3600 * 24)),
            if
                Now > Time ->
                    TempTime = Time + WholeDay * (3600 * 24),
                    case is_same_day(TempTime) of
                        true -> WholeDay + 1;
                        false -> WholeDay + 2
                    end;
                true ->
                    TempTime = Now + WholeDay * (3600 * 24),
                    case is_same_day(TempTime) of
                        true -> WholeDay + 1;
                        false -> WholeDay + 2
                    end
            end
    end.


%% 获取当前月份
get_month() ->
    Unixtime = unixtime_record(),
    Unixtime#unixtime.month.

%% 获取当前月的日
get_day() ->
    Unixtime = unixtime_record(),
    Unixtime#unixtime.day.

%% 获取当天几点
get_hour() ->
    Unixtime = unixtime_record(),
    Unixtime#unixtime.hour.

%% 获取星期几
get_week() ->
    Unixtime = unixtime_record(),
    Unixtime#unixtime.day_of_week.

get_week(Timestamp) ->
    Unixtime = unixtime_record(Timestamp),
    Unixtime#unixtime.day_of_week.


get_year() ->
    Unixtime = unixtime_record(),
    Unixtime#unixtime.year.

%% 获取下个月1号0点的时间戳
get_unixtime_next_month_begin() ->
    Unixtime = unixtime_record(),
    unixtime() + ( Unixtime#unixtime.last_day_of_month - get_day() ) * 3600 * 24 + calc_today_0_sec().

%% 判断一个时间戳与今天是否是同一天
is_same_day(0) ->
    false;
is_same_day(Time) ->
    is_timestamp_same_day(unixtime(), Time).
    %% 以下的实现方法会因为时区设置导致判断不准确
    % {{Year, Mon, Day}, {_Hour, _Min, _Sec}} = stamp_to_date(Time, 5),
    % today_date() =:= date_to_int({Year, Mon, Day}).

%% -----------------------------------------------------------------
%% 根据1970年以来的秒数获得日期
%% -----------------------------------------------------------------
seconds_to_localtime(Seconds) ->
    DateTime = calendar:gregorian_seconds_to_datetime(Seconds+?DIFF_SECONDS_0000_1900),
    calendar:universal_time_to_local_time(DateTime).

%% 判断某个时间戳与现在是否在同一个星期内
is_same_week(Timestamp) ->
    is_same_week(Timestamp, unixtime()).

%% 判断两个时间戳是否在同一个星期内
is_same_week(Timestamp1, Timestamp2) ->
    {Date1, _} = seconds_to_localtime(Timestamp1),
    {Date2, _} = seconds_to_localtime(Timestamp2),
    calendar:iso_week_number(Date1) =:= calendar:iso_week_number(Date2).

is_same_month(Timestamp) ->
    MonthNow = get_month(),
    {{_Y, M, _D}, _} = util:stamp_to_date(Timestamp, 5),
    MonthNow =:= M.

%% @doc 判断是否每日指定小时刷新
%% @Part::hour()
%% @return  boolean() :: true -> refresh; false -> no refresh
is_refresh_daily_hour(NewStamp, OldStamp, Part) when NewStamp > OldStamp ->
    case OldStamp + ?ONE_DAY_SECONDS < NewStamp of
        true -> true;
        false ->
            {{_, _, NewDay}, {NewHour, _, _}} = get_datetime_by_timestamp(NewStamp),
            {{_, _, OldDay}, {OldHour, _, _}} = get_datetime_by_timestamp(OldStamp),
            case NewDay =:= OldDay of
                true ->
                    case OldHour >= Part of
                        true -> false;
                        false -> NewHour >= Part
                    end;
                false -> NewHour >= Part
            end
    end;
is_refresh_daily_hour(_, _, _) -> false.

%% @doc 判断两个时间戳是否同一天
%% @return : boolean()
is_timestamp_same_day(Stamp1, Stamp2) ->
    {Date1, _} = get_datetime_by_timestamp(Stamp1),
    {Date2, _} = get_datetime_by_timestamp(Stamp2),
    Date1 == Date2.

%% @doc 判断两个时间戳是否同一周
%% @return : boolean()
is_timestamp_same_week(Stamp1, Stamp2) ->
    {Date1, _} = get_datetime_by_timestamp(Stamp1),
    {Date2, _} = get_datetime_by_timestamp(Stamp2),
    calendar:iso_week_number(Date1) =:= calendar:iso_week_number(Date2).


%% @doc 返回两个时间戳相差的天数
%% @return : integer()
get_differ_days_by_timestamp(Newer, Older) ->
    {NewDate, _} = get_datetime_by_timestamp(Newer),
    {OldDate, _} = get_datetime_by_timestamp(Older),
    Diff = calendar:date_to_gregorian_days(NewDate) - calendar:date_to_gregorian_days(OldDate),
    ?BIN_PRED(Diff >= 0, Diff, (0 - Diff)).


%% 通过时间戳返回日期
%% @return : {{date()}, {time()}}
get_datetime_by_timestamp(Timestamp) ->
    calendar:now_to_local_time(get_now_by_timestamp(Timestamp)).


%% 通过日期返回时间戳
%% @return : integer()
-define(UTC_1900_TO_1970_SECONDS, 62167248000).
get_timestamp_by_datetime({Date, Time}) ->
    calendar:datetime_to_gregorian_seconds({Date, Time}) - ?UTC_1900_TO_1970_SECONDS.


%% 通过时间戳返回now() / os:timestamp() 的返回格式， 只精确到秒
%% @return : {MegaSecs, Secs, 0}
get_now_by_timestamp(Timestamp) ->
    {Timestamp div 1000000, Timestamp rem 1000000, 0}.



%% @doc 取得公元1年到当前的天数
%% @end
get_now_days() ->
    get_now_days(date()).

get_now_days(Data) ->
    calendar:date_to_gregorian_days(Data).

%% @doc 根据时间戳获取公元1年到当前的天数
get_days_by_timestamp(TimeStamp) ->
    {Date,_} = get_datetime_by_timestamp(TimeStamp),
    get_now_days(Date).

%% -----------------------------------------------------------------
%% 获取当天0点到现在的秒数
%% -----------------------------------------------------------------
get_seconds_from_midnight() ->
    NowTime  = unixtime(),
    {{_Year, _Month, _Day}, Time} = seconds_to_localtime(NowTime),
    calendar:time_to_seconds(Time).

get_seconds_from_midnight(Seconds) ->
    {{_Year, _Month, _Day}, Time} = seconds_to_localtime(Seconds),
    calendar:time_to_seconds(Time).


%% 检测字符串是否包含非法字符
%% @return: true | false
has_illegal_char([]) ->
    false;
has_illegal_char([H | T]) ->
    case H of
        $\\ ->     % 反斜杠
            true;
        32 ->   % 空格
            true;
        0 ->    % 空白
            true ;
        _ ->
            has_illegal_char(T)
    end.

-define(PROTOAL, "protol").
-define(ARGS, "args").
%% @doc 解释json协议
%% @return {ok, Protoal, Args, Remainder} | {error, Reason}
json_parse(Data) ->
    case rfc4627:decode(Data) of
        {ok, {obj, List}, Remainder} ->
            case lists:keyfind(?PROTOAL, 1, List) of
                false -> {error, no_protol};
                {_, Protoal} ->
                    case lists:keyfind(?ARGS, 1, List) of
                        {_, <<>>} ->
                            {ok, Protoal, [], Remainder};
                        {_, {obj, Args}} ->
                            {ok, Protoal, Args, Remainder};
                        {_, SubObj} ->
                            case rfc4627:decode(SubObj) of
                                {ok, {obj, SubList}, _} ->
                                    {ok, Protoal, SubList, Remainder};
                                _T ->
                                    {error, wrong_protol_format}
                            end
                    end
            end;
        {error, Reason} ->
            % ?ASSERT(false, [Reason]),
            {error, Reason};
        _Other ->
            ?LDS_TRACE("jason other", [_Other]),
            % ?ASSERT(false, [_Other]),
            {error, wrong_protol_format}
    end.


%% @doc 封装json协议
%% @return json()
% json_pack([Data | Left]) when is_integer(Data) ->
%     ?LDS_TRACE(sdf),
%     rfc4627:encode([Data | Left]);
% json_pack([Data | Left]) ->
%     ?LDS_TRACE(aaasdf),
%     rfc4627:encode({obj, [json_pack(Data) | json_parse(Left)]});
% json_pack(Data) ->
%     rfc4627:encode(Data).

%% 判断是否字符串
is_string([]) -> false;
is_string(Str) when is_list(Str) ->
    is_string_1(Str);
is_string(_) -> false.

is_string_1([]) -> true;
is_string_1([Elm | Left]) ->
    case is_integer(Elm) of
        true -> is_string_1(Left);
        false -> false
    end.

% json_pack([Data | Left]) when is_integer(Data) ->
%     case Left =:= [] of
%         true -> rfc4627:encode([Data | Left]);
%         false -> rfc4627:encode([Data | json_pack(Left)])
%     end;
% json_pack([Data | Left]) when is_list(Data) ->
%     case Left =:= [] of
%         true ->  rfc4627:encode({obj, [json_pack(Data)]});
%         false -> rfc4627:encode({obj, [json_pack(Data) | json_parse(Left)]})
%     end;
% json_pack([Data | Left]) ->
%     case Left =:= [] of
%         true -> rfc4627:encode({obj, [Data]});
%         false -> rfc4627:encode({obj, [Data | json_parse(Left)]})
%     end;
% json_pack(Data) ->
%     rfc4627:encode(Data).

json_pack(List) when is_list(List) ->
    json_pack({obj, List});
json_pack(Data) -> rfc4627:encode(Data).

json_pack(Protoal, List) ->
    rfc4627:encode({obj, [{?PROTOAL, Protoal} | List]}).

% info : ["{\"args\":{\"content\":\"test\",\"endTime\":\"1393322556\",\"id\":0,\"intervalTime\":1,\"opType\":1,\"priority\":0,\"startTime\":\"1391421753\",\"type\":0},\"protol\":1001}"]

% 字符宽度，1汉字=2单位长度，1数字字母=1单位长度
% para: String--> asn1rt:utf8_binary_to_list 的返回值
string_width(String) ->
   string_width(String, 0).
string_width([], Len) ->
   Len;
string_width([H | T], Len) ->
   case H > 255 of
       true ->
           string_width(T, Len + 2);
       false ->
           string_width(T, Len + 1)
   end.

% 字符宽度，1汉字=1单位长度，1数字字母=1单位长度
% para: String--> asn1rt:utf8_binary_to_list 的返回值
string_width_1(String) ->
   string_width_1(String, 0).
string_width_1([], Len) ->
   Len;
string_width_1([_H | T], Len) ->
    string_width_1(T, Len + 1).


to_binary(Msg) when is_binary(Msg) ->
    Msg;
to_binary(Msg) when is_atom(Msg) ->
    list_to_binary(atom_to_list(Msg));
to_binary(Msg) when is_list(Msg) ->
    list_to_binary(Msg);
to_binary(Msg) when is_integer(Msg) ->
    list_to_binary(integer_to_list(Msg)).

r2p(A, B) -> record_to_proplist(A, B).
%% 显示record 
%% 用法 : record_to_proplist(#ets_online{}, record_info(fields, ets_online)).    
record_to_proplist(Record, Fields) ->
    record_to_proplist(Record, Fields, '__record').

record_to_proplist(Record, Fields, TypeKey)
  when tuple_size(Record) - 1 =:= length(Fields) ->
    lists:zip([TypeKey | Fields], tuple_to_list(Record)).

% record转proplists
rec_to_pl(RecInfo, Record) ->
    rec_to_pl(RecInfo, Record, 2, []).
rec_to_pl([H|T], Record, N, Acc) ->
    Acc1 = [{H, erlang:element(N, Record)}|Acc],
    rec_to_pl(T, Record, N+1, Acc1);
rec_to_pl([], _Record, _N, Acc) ->
    lists:reverse(Acc).

%% proplists转record
pl_to_rec(List, RecInfo, EmptyRecord) ->
    pl_to_rec(List, RecInfo, EmptyRecord, [], 2).

pl_to_rec(List, [H|T], EmptyRecord, Acc, N) ->
    Elem = proplists:get_value(H, List, erlang:element(N, EmptyRecord)),
    pl_to_rec(List, T, EmptyRecord, [Elem|Acc], N+1);
pl_to_rec(_List, [], EmptyRecord, Acc, _N) ->
    Acc1 = lists:reverse(Acc),
    Tag = erlang:element(1, EmptyRecord),
    list_to_tuple([Tag|Acc1]).

%% 查找在列表中的位置
index_of(Item, List) -> index_of(Item, List, 1).

index_of(_, [], _)  -> not_found;
index_of(Item, [Item|_], Index) -> Index;
index_of(Item, [_|Tl], Index) -> index_of(Item, Tl, Index+1).


%% 取得时间戳所在周的指定日的0点时间戳
%% AssignDay : 周几::integer()
%% @return : timestamp::integer()
get_week_assign_day_dawn_timestamp(Timestamp, AssignDay) ->
    {Date, {H, M, S}} = calendar:now_to_local_time(get_now_by_timestamp(Timestamp)),
    DayOfWeek = calendar:day_of_the_week(Date),
    if
        AssignDay =:= DayOfWeek -> Timestamp - (H * 3600 + M * 60 + S);
        AssignDay < DayOfWeek   -> Timestamp - ((DayOfWeek - AssignDay) * 3600 * 24) - (H * 3600 + M * 60 + S);
        true -> Timestamp + ((AssignDay - DayOfWeek) * 3600 * 24) - (H * 3600 + M * 60 + S)
    end.


%% 取得时间戳所在日的凌晨时间戳
%% @return : timestamp::integer()
get_day_dawn_timestamp(Timestamp) ->
    {_, {H, M, S}} = calendar:now_to_local_time(get_now_by_timestamp(Timestamp)),
    Timestamp - (H * 3600 + M * 60 + S).

%% 列表乱序(洗牌)
shuffle(L) when is_list(L) ->
    [X || {_,X} <- lists:sort( [{random:uniform(), N} || N <- L])].

%% 依据权重，从元组列表中随机挑选N个元素，返回被抽中的元组
rand_by_weight(Tuples, Index, PickNum) when PickNum>=0 ->
    rand_N_by_weight__(Tuples, Index, PickNum, []).

rand_N_by_weight__(_Tuples, _Index, 0, Ret) -> Ret;
rand_N_by_weight__([], _Index, _PickNum, Ret) -> Ret;
rand_N_by_weight__(Tuples, Index, PickNum, Ret) ->
    PickOne =  rand_by_weight(Tuples, Index),
    LeftTuples = lists:delete(PickOne, Tuples),
    rand_N_by_weight__(LeftTuples, Index, PickNum-1, [PickOne|Ret]).


%% 依据权重，从元组列表中随机挑选一个元素，返回被抽中的元组，
%%           如果没有对应的元素，则抛出异常
%%           N是权重所在的位置
rand_by_weight([], _Index) ->
    error(badargs);
rand_by_weight(Tuples, Index) ->
    Sum = lists:sum([element(Index,Tuple) || Tuple <- Tuples]),
    P = rand() * Sum,
    rand_one_by_weight__(Tuples, Index, P).

rand_one_by_weight__([Tuple], _, _) ->
    Tuple;
rand_one_by_weight__([Tuple|T], Index, P) ->
    case element(Index, Tuple) of
        Weight when P =< Weight ->
            Tuple;
        Weight ->
            rand_one_by_weight__(T, Index, P-Weight)
    end.


%% 依据权重，从元组列表中随机挑选一个元素，返回被抽中的元组，
%%           如果没有对应的元素，则抛出异常
%%           N是权重所在的位置
rand_by_weight2([], _Index) ->
    error(badargs);
rand_by_weight2(Tuples0, Index) ->
	Tuples = Tuples0,%%random_list(Tuples0),
%%     Sum = lists:sum([element(Index,Tuple) || Tuple <- Tuples]),
    {Tuples2, Sum} = 
		lists:foldl(fun(Tuple, {TuplesAcc, SumAcc}) ->
							SumAcc2 = erlang:element(Index, Tuple) + SumAcc,
							Tuple2 = erlang:setelement(Index, Tuple, SumAcc2),
							{[Tuple2|TuplesAcc], SumAcc2}
					end, {[], 0}, Tuples),
	Tuples3 = lists:reverse(Tuples2),
    P = rand() * Sum,
	rand_one_by_weight2__(Tuples3, Index, P).

rand_one_by_weight2__([Tuple], _, _) ->
    Tuple;
rand_one_by_weight2__([Tuple|T], Index, P) ->
    case element(Index, Tuple) of
        Weight when P =< Weight ->
            Tuple;
        _Weight ->
            rand_one_by_weight2__(T, Index, P)
    end.



%% 依据权重，从列表中随机挑选一个元素，返回该元素对应的顺序（顺序从1开始算起），
%%           如果没有对应的元素，则返回-1
%% @para: L => 权重列表（整数列表）
%%        TotalWeight => 总权重（整数，通常为L的元素之和）
%%        比如：调用rand_pick_one_by_weight([10, 40, 20, 30], 100)，则有10%的概率返回1，40%的概率返回2， 20%的概率返回3，30%的概率返回4
%%              调用rand_pick_one_by_weight([10, 40, 20, 30], 1000)，则有千分之10的概率返回1，千分之40的概率返回2， 千分之20的概率返回3，千分之30的概率返回4，千分之900的概率返回-1
%%              如果L传入空列表，则固定返回-1
rand_pick_one_by_weight(L, TotalWeight) when TotalWeight >= 1 ->
    ?ASSERT(util:is_integer_list(L), L),
    case L of
        [] ->
            -1;
        _ ->
            RandWeight = util:rand(1, TotalWeight),
            rand_pick_one_by_weight__(RandWeight, L, 1, 0)
    end.



rand_pick_one_by_weight__(_RandWeight, [], _Nth, _AccSumWeight) ->
    -1;
rand_pick_one_by_weight__(RandWeight, [CurCmpEle | T], Nth, AccSumWeight) ->
    case RandWeight =< (AccSumWeight + CurCmpEle) of
        true ->
            Nth;
        false ->
            rand_pick_one_by_weight__(RandWeight, T, Nth + 1, AccSumWeight + CurCmpEle)
    end.

%%wujiancheng:传入[{key,value},...] 相同的key的value会累加，最终返回list不会有重复的key
duplicate_key_sum_value(List) ->
    List2  =  proplists:get_keys(List),
    F = fun(Key, Acc) ->
        List3 = proplists:lookup_all(Key,List),
        case length(List3) > 1 of
            true ->
                F2 = fun({_Key, Value2},Acc2) ->
                    Acc2 + Value2
                     end,
                Acc ++ [{Key,lists:foldl(F2, 0, List3)}];
            false ->

                Acc ++ List3
        end
        end,
    lists:foldl(F, [], List2).


%% 仅仅用于测试！
dbg_test_rand_pick_one_by_weight(L, _TotalWeight, 0) ->
    SeqList = lists:seq(1, length(L)),
    F = fun(_Seq) ->
            ?DEBUG_MSG("Seq: ~p,  Times: ~p", [_Seq, erlang:get(_Seq)])
        end,
    [F(X) || X <- SeqList],
    ?DEBUG_MSG("Seq: -1,  Times: ~p", [erlang:get(-1)]),
    done;

dbg_test_rand_pick_one_by_weight(L, TotalWeight, TestTimes) ->
    Res = rand_pick_one_by_weight(L, TotalWeight),

    OldTimes = case erlang:get(Res) of
        undefined -> 0;
        Val -> Val
    end,
    erlang:put(Res, OldTimes + 1),

    dbg_test_rand_pick_one_by_weight(L, TotalWeight, TestTimes - 1).










%% 约等于proplists:get_value/3
get_value(Key, PropList, Default) ->
    case lists:keyfind(Key, 1, PropList) of
        {_, Value} -> Value;
        _ -> Default
    end.

get_call_stack() ->
    try
        throw(get_call_stack)
    catch
        get_call_stack ->
            Trace1 =
                case erlang:get_stacktrace() of
                    [_|Trace] -> Trace;
                    Trace -> Trace
                end,
            empty_stacktrace(),
            Trace1
    end.

empty_stacktrace() ->
    try
        erlang:raise(throw, clear, [])
    catch
        _ ->
            ok
    end.


%% 请求http
request_get(Url,Arguments)->
	case Arguments of
		[] ->
			Url2 = Url;
		_ ->
			Arguments2 = map(fun({K,V})->to_list(K)++"="++to_list(V) end, Arguments),
			Arguments3 = list_to_string(Arguments2, [], "&", []),
			case lists:member($?,Url) of
				?true ->
					Url2 = Url ++"&"++Arguments3;
				?false ->
					Url2 = Url ++"?"++Arguments3
			end
	end,
	httpc:request(get, {Url2, []}, [], []).

request_post(Url, Arguments) ->
	Arguments2 = map(fun({K,V})->to_list(K)++"="++to_list(V) end, Arguments),
	Arguments3 = list_to_string(Arguments2, [], "&", []),
	httpc:request(post, {Url, [], "application/x-www-form-urlencoded", Arguments3}, [], []).
	
	
%% map 结果是倒序的
map(F, L) -> map(F, L, []).
map(_, [], R) -> R;
map(F, [H|T], R) -> map( F, T, [F(H)|R] ).


%% list
to_list(Msg) when is_list(Msg) -> 
    Msg;
to_list(Msg) when is_atom(Msg) -> 
    atom_to_list(Msg);
to_list(Msg) when is_binary(Msg) -> 
    binary_to_list(Msg);
to_list(Msg) when is_integer(Msg) -> 
    integer_to_list(Msg);
to_list(Msg) when is_float(Msg) -> 
    float_to_list(Msg);
to_list(_) ->
    [].



%% 数组转成字符串
%% List -> String 
%% H 附加在开头
%% M 夹在中间
%% T 附加在尾部
list_to_string([],_H,_M,_T) -> [];
list_to_string([HList|TList], H, M,T)     -> list_to_string(TList,H,M,T,H++to_list(HList)).
list_to_string([],           _H,_M,T,Str) -> Str++T;
list_to_string([HList|TList], H, M,T,Str) -> list_to_string(TList,H,M,T,Str++M++to_list(HList)).


