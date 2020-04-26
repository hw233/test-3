-module(time).
-export([now/0, now_ms/0, 
         newday_countdown/0,
         newhour_countdown/0,
         date_str/0, date_str/1, 
         date_day_str/0, date_day_str/1,
         date_min_str/0, date_min_str/1]).

now() ->
        {MegaSecs, Secs, _MicroSecs} = os:timestamp(),

        1000000 * MegaSecs + Secs.

now_ms() ->
        {MegaSecs, Secs, MicroSecs} = os:timestamp(),

        1000000000 * MegaSecs + Secs * 1000 + MicroSecs div 1000.

newday_countdown() ->
        {{_Year, _Month, _Day}, {Hour, Minute, Second}} = erlang:localtime(),

        (24 - Hour) * 3600 - Minute * 60 - Second.

newhour_countdown() ->
        {{_Year, _Month, _Day}, {_Hour, Minute, Second}} = erlang:localtime(),

        (60 - Minute) * 60 - Second.

date_str() ->
        date_str(erlang:localtime()).

date_str({{Year, Month, Day}, {Hour, Minute, Second}}) ->
        lists:flatten(io_lib:format("~4..0B~2..0B~2..0B-~2..0B~2..0B~2..0B",
                                    [Year, Month, Day, Hour, Minute, Second])).

date_day_str() ->
        date_day_str(erlang:localtime()).

date_day_str({{Year, Month, Day}, {_Hour, _Minute, _Second}}) ->
        lists:flatten(io_lib:format("~4..0B~2..0B~2..0B", [Year, Month, Day])).

date_min_str() ->
        date_min_str(erlang:localtime()).

date_min_str({{Year, Month, Day}, {Hour, Minute, _Second}}) ->
        lists:flatten(io_lib:format("~4..0B~2..0B~2..0B-~2..0B~2..0B", 
                                    [Year, Month, Day, Hour, Minute])).