%%----------------------------------------------------
%% @Description Beam比对工具
%%    使用方法 escript bmdiff.erl 新ebin文件夹 旧ebin文件夹 输出文件夹
%%
%% @author liuzhongzheng2012@gmail.com
%%----------------------------------------------------
-module(bmdiff).
-export([
    main/1
         ]).

-define(ERR(Fmt, Arg), err(?MODULE, ?LINE, Fmt, Arg)).
-define(ERR(Fmt), err(?MODULE, ?LINE, Fmt)).

main([New, Old, Diff]) ->
    diff(New, Old, Diff);
main([New, Old]) ->
    main([New, Old, "diff"]);
main(_) ->
    io:format("Beam diff tool.~n\tUsage: escript bmdiff.erl <NEW_EBIN> <OLD_EBIN> [TARGET]").

diff(New, Old, DiffDir) ->
    case beam_lib:cmp_dirs(New, Old) of
        {Add, Miss, Modify} ->
            ok = mkdir(DiffDir),
            Mods = [Fn || {Fn, _Fnold} <- Modify],
            report(added, Add),
            report(deleted, Miss),
            report(modified, Mods),
            [cp(Fn, DiffDir) || Fn <- Add],
            [cp(Fn, DiffDir) || Fn <- Mods],
            check_release(Add ++ Mods);
        _Err ->
            ?ERR(_Err)
    end.

report(Action, Files) ->
    Len = length(Files),
    io:format("~n ~4w file(s) are ~p:~n", [Len, Action]),
    [io:format("\t~p~n", [filename:basename(Fn) ]) || Fn <- Files].

err(Mod, Line, Msg) ->
    err(Mod, Line, "~p", [Msg]).
err(Mod, Line, Format, Data) ->
    Msg = io_lib:format("~w(~w): " ++ Format, [Mod, Line] ++ Data),
    io:put_chars(standard_error, Msg).

cp(File, Dist) ->
    Fn = filename:basename(File),
    Dfn = filename:join(Dist, Fn),
    case file:copy(File, Dfn) of
        {ok, _} ->
            true;
        _ ->
            ?ERR("Cannot create file ~p~n", [Dfn]),
            false
    end.

mkdir(Folder) ->
    Folder1 =
        case lists:suffix("/", Folder) of
            true ->
                Folder;
            _ ->
                Folder ++ "/"
        end,
    filelib:ensure_dir(Folder1).


check_release(Files) ->
    F = fun(Fn) -> is_release(Fn) orelse io:format("[WARN] ~p is not release version~n", [Fn]) end,
    lists:foreach(F, Files).


is_release(Filename) ->
    case beam_lib:chunks(Filename, [compile_info]) of
        {ok, {_, [{compile_info, Infos}]}} ->
            Options = proplists:get_value(options, Infos),
            not lists:member({d, debug}, Options);
        _ ->
            false
    end.

