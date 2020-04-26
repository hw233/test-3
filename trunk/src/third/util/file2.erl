-module(file2).
-export([read_lines/3]).

read_lines(Fun, Lines, Fd) ->
        case file:read_line(Fd) of
                {ok, Data} ->
                        read_lines(Fun, lists:append(Lines, [Fun(Data)]), Fd);
                _Other ->
                        Lines
        end.