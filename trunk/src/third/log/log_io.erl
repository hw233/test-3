-module(log_io).
-export([write_event/2,
         format_event/1,
         format_time/1]).

write_event(Fd, Content) ->
        file:write(Fd, format_event(Content)).

format_event({Time, {error, _GL, {Pid, Format, Args}}}) ->
        T = format_time(Time),

        case catch io_lib:format(add_node(Format, Pid), Args) of
                S when is_list(S) ->
                        io_lib:format(T ++ " " ++ S, []);
                _ ->
                        F = add_node("ERROR: ~p - ~p~n", Pid),

                        io_lib:format(T ++ " " ++ F, [Format, Args])
        end;

format_event({Time, {emulator, _GL, Chars}}) ->
        T = format_time(Time),

        case catch io_lib:format(Chars, []) of
                S when is_list(S) ->
                        io_lib:format(T ++ S, []);
                _ ->
                        io_lib:format(T ++ "ERROR: ~p ~n", [Chars])
        end;

format_event({Time, {info, _GL, {Pid, Info, _}}}) ->
        T = format_time(Time),

        io_lib:format(T ++ add_node("~p~n", Pid), [Info]);

format_event({Time, {error_report, _GL, {Pid, std_error, Rep}}}) ->
        T = format_time(Time),
        S = format_report(Rep),

        io_lib:format(T ++ S ++ add_node("", Pid), []);

format_event({Time, {info_report, _GL, {Pid, std_info, Rep}}}) ->
        T = format_time(Time, "INFO REPORT"),
        S = format_report(Rep),

        io_lib:format(T ++ S ++ add_node("", Pid), []);

format_event({Time, {info_msg, _GL, {Pid, Format, Args}}}) ->
        T = format_time(Time, "INFO REPORT"),

        case catch io_lib:format(add_node(Format, Pid), Args) of
                S when is_list(S) ->
                        io_lib:format(T ++ " " ++ S, []);
                _ ->
                        F = add_node("ERROR: ~p - ~p~n", Pid),

                        io_lib:format(T ++ " " ++ F, [Format, Args])
        end;

format_event(_) ->
        ok.

format_report(Rep) when is_list(Rep) ->
        case string_p(Rep) of
                true ->
                        io_lib:format("~s~n", [Rep]);
                _ ->
                        format_rep(Rep)
        end;

format_report(Rep) ->
        io_lib:format("~p~n", [Rep]).

format_rep([{Tag, Data} | Rep]) ->
        io_lib:format("    ~p: ~p~n", [Tag, Data]) ++ format_rep(Rep);

format_rep([Other|Rep]) ->
        io_lib:format("    ~p~n", [Other]) ++ format_rep(Rep);

format_rep(_) ->
        [].

add_node(X, Pid) when is_atom(X) ->
        add_node(atom_to_list(X), Pid);

add_node(X, Pid) when node(Pid) /= node() ->
        lists:concat([X, "** at node ", node(Pid), " **~n"]);

add_node(X, _) ->
        X.

string_p([]) ->
        false;

string_p(Term) ->
        string_p1(Term).

string_p1([H | T]) when is_integer(H), H >= $\s, H < 255 ->
        string_p1(T);

string_p1([$\n|T]) ->
        string_p1(T);

string_p1([$\r|T]) ->
        string_p1(T);

string_p1([$\t|T]) ->
        string_p1(T);

string_p1([$\v|T]) ->
        string_p1(T);

string_p1([$\b|T]) ->
        string_p1(T);

string_p1([$\f|T]) ->
        string_p1(T);

string_p1([$\e|T]) ->
        string_p1(T);

string_p1([H|T]) when is_list(H) ->
        case string_p1(H) of
                true ->
                        string_p1(T);
                _    ->
                        false
        end;

string_p1([]) ->
        true;

string_p1(_) ->
        false.

format_time(Time) ->
        format_time(Time, "ERROR REPORT").

format_time({{Y, Mo , D}, {H, Mi, S}}, _Type) ->
        io_lib:format("[~w-~.2.0w-~.2.0w ~.2.0w:~.2.0w:~.2.0w]",
                      [Y, Mo, D, H, Mi, S]).