-module(sm_hotup).
-export([hotup_list/0,
         hotup_exec/0,
         hotup_test/0]).
         
hotup_list() ->
        [Node, ListFilename, OldEbin] = init:get_plain_arguments(),

        timer:sleep(500),

        case net_adm:ping(list_to_atom(Node)) of
                pong ->
                        {ok, Fd} = file:open(ListFilename, [write, raw]),

                        {ok, Beams} = file:list_dir("./"),

                        io:format("~n+++ [sm_hotup.erl - hotup_list] begin diff *.beam...~n"),

                        DiffFound = 
                        lists:foldl(fun(Beam, DiffFound2) ->
                                        case string:str(Beam, ".beam") of
                                                0 ->
                                                        DiffFound2;
                                                _Other ->
                                                        % io:format("compare ~s...", [Beam]),

                                                        case beam_lib:cmp(Beam, OldEbin ++ Beam) of
                                                                ok ->
                                                                        % io:format("no diff found.~n"),

                                                                        DiffFound2;
                                                                _Other2 ->
                                                                        io:format("add to list.~n"),

                                                                        file:write(Fd, io_lib:format("~s~n", [Beam])),

                                                                        case DiffFound2 of
                                                                                false ->
                                                                                        true;
                                                                                _Other3 ->
                                                                                        DiffFound2
                                                                        end
                                                        end
                                        end
                                    end, false, Beams),

                        io:format(" [hotup_list] -- done.(~p)~n", [ListFilename]),

                        file:close(Fd),

                        if
                                DiffFound == true ->
                                        erlang:halt(0);
                                true ->
                                        os:cmd("rm " ++ ListFilename),

                                        io:format(" [hotup_list] -- all no diff found, no need to hot update.~n"),

                                        erlang:halt(1)
                        end;
                pang ->
                        io:format("~n Error: [hotup_list] -- cant hot update, service halt.~n"),

                        erlang:halt(1)
        end.

hotup_exec() ->
        [Node, ListFilename] = init:get_plain_arguments(),

        Node2 = list_to_atom(Node),

        case net_adm:ping(Node2) of
                pong ->
                        {ok, Fd} = file:open(ListFilename, [read, raw]),
                        
                        Modules = file2:read_lines(fun(Line) ->
                                                        [Line2, _] = string:tokens(Line, "."),

                                                        list_to_atom(Line2)
                                                   end,
                                                   [], Fd),

                        do_hotup(Node2, Modules);
                pang ->
                        io:format("~n Error: [hotup_exec] -- cant hot update, service halt.~n"),

                        erlang:halt(1)
        end.

do_hotup(_, []) ->
        io:format("~n [do_hotup] -- nothing to hot update.~n"),

        erlang:halt(0);
        
do_hotup(Node, Modules) ->
        io:format("~n [do_hotup] -- hot updating ~p ...~n", [Modules]),

        case rpc:call(Node, sm_hu, check_load, [Modules]) of
                {badrpc, Reason} ->
                        io:format(" [do_hotup] -- error occour ~p.~n", [Reason]),

                        erlang:halt(1);
                {error, Reason} ->
                        io:format(" [do_hotup] -- error occour ~p.~n", [Reason]),

                        erlang:halt(1);
                ok ->
                        io:format(" [do_hotup] -- hot update success.~n"),

                        erlang:halt(0);
                Unknown ->
                        io:format(" [do_hotup] -- unknow error occour ~p.~n", [Unknown]),

                        erlang:halt(1)        
        end.

hotup_test() ->
        hello_hot_update_ok.