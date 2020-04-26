%%----------------------------------------------------
%% Erlang模块热更新到所有线路（包括server的回调函数，如果对state有影响时慎用）
%%
%% 检查：sm_hu:c()                %% 列出前5分钟内编译过的文件
%%       sm_hu:c(N)               %% 列出前N分钟内编译过的文件
%%
%% 更新：sm_hu:u()                %% 更新前5分钟内编译过的文件
%%       sm_hu:u(N)               %% 更新前N分钟内编译过的文件
%%       sm_hu:u([mod_xx, ...])   %% 指定模块（不带后缀名）
%%       sm_hu:u(m)               %% 编译并加载文件
%%
%% Tips: u - update, c - check
%%
%%----------------------------------------------------

-module(sm_hu).

-export([
    c/0,
    c/1,
    admin/0,
    u/0,
    u/1,
    load/1,
    l/1,
    m/1,
    check_load/1,
    h/0,
    hh/0
    ]).
-include_lib("kernel/include/file.hrl").
-include("common.hrl").
-include("record.hrl").

c() ->
    c(5).
c(S) when is_integer(S) ->
	c:cd("../ebin"),
    case file:list_dir(".") of
        {ok, FileList} ->
            Files = get_new_file(FileList, S * 60),
            info("---------check modules---------~n~w~n=========check modules=========", [Files]);
        Any -> info("Error Dir: ~w", [Any])
    end;
c([S]) when is_atom(S) ->
	S1 = tool:to_integer(tool:to_list(S)),
	case is_integer(S1) of
		true  ->
			c:cd("../ebin"),
    		case file:list_dir(".") of
				{ok, FileList} ->
            		Files = get_new_file(FileList, S * 60),
            		info("---------check modules---------~n~w~n=========check modules=========", [Files]);
        		Any -> info("Error Dir: ~w", [Any])
    		end;
		_ ->
			info("ERROR======> Badarg ~p/~p ~n", [S, S1])
	end;
c(S) -> info("ERROR======> Badarg ~p ~n", [S]).

admin()->
    spawn(fun()->u(m) end),
    ok.

u() ->
    u(5).
u(m) ->
    StartTime = util:unixtime(),
    info("----------makes----------", []),
    c:cd("../"),
    make:all(),
    c:cd("ebin"),
    EndTime = util:unixtime(),
    Time = EndTime - StartTime,
    info("Make Time : ~w s", [Time]),
    u(Time / 60);
u(S) when is_number(S) ->
    case file:list_dir(".") of
        {ok, FileList} ->
            Files = get_new_file(FileList, util:ceil(S * 60) + 3),
            AllZone = mod_disperse:server_list(),
            info("---------modules---------~n~w~n----------nodes----------", [Files]),
            load(Files),
            loads(AllZone, Files);
        Any -> info("Error Dir: ~w", [Any])
    end;
u(Files) when is_list(Files) ->
    AllZone = mod_disperse:server_list(),
    info("---------modules---------~n~w~n----------nodes----------", [Files]),
    load(Files),
    loads(AllZone, Files);
u(_) -> info("ERROR======> Badarg", []).

%% m(['src/data/*','src/lib/lib_goods.erl'])
m(Files) when is_list(Files) ->
    StartTime = util:unixtime(),
    info("----------makes----------~n~w~n", [Files]),
    c:cd("../"),
    Res = make:files(Files, [debug_info,{i, "include"},{outdir, "ebin"}]),
    c:cd("ebin"),
    EndTime = util:unixtime(),
    Time = EndTime - StartTime,
    info("Make Time : ~w s", [Time]),
    Res.

info(V, P) ->
    io:format(V ++ "~n", P).

%% 更新到所有线路
loads([], _Files) -> ok;
loads([H | T], Files) ->
    info("[~w]", [H#server.node]),
    rpc:cast(H#server.node, sm_hu, load, [Files]),
    loads(T, Files).

get_new_file(Files, S) ->
    get_new_file(Files, S, []).
get_new_file([], _S, Result) -> Result;
get_new_file([H | T], S, Result) ->
    NewResult = case string:tokens(H, ".") of
        [Left, Right] when Right =:= "beam" ->
            case file:read_file_info(H) of
                {ok, FileInfo} ->
                    Now = calendar:local_time(),
                    case calendar:time_difference(FileInfo#file_info.mtime, Now) of
                        {Days, Times} ->
                            Seconds = calendar:time_to_seconds(Times),
                            case Days =:= 0 andalso Seconds < S of
                                true ->
                                    FileName = list_to_atom(Left),
                                    [FileName | Result];
                                false -> Result
                            end;
                        _ -> Result
                    end;
                _ -> Result
            end;
        _ -> Result
    end,
    get_new_file(T, S, NewResult).

load([]) -> ok;
load([FileName | T]) ->
    c:l(FileName),
    info("loaded: ~w", [FileName]),
    load(T).

l(Mods) when is_list(Mods) ->
	[l(Mod) || Mod <- Mods];
l(Mod) ->
	case code:soft_purge(Mod) of
        true ->
            case code:load_file(Mod) of
                {module, _} ->
                    io:format("loaded: ~w~n", [Mod]),
                    ok;
                {error, What} -> io:format("ERROR======> loading: ~w (~w)~n", [Mod, What])
            end;
        false ->
			%io:format("ERROR======> Processes lingering : ~w [zone ~w] ", [Mod, srv_kernel:zone_id()])
			io:format("soft_purge fail~n")
    end.


get_file_path(Mod) when is_atom(Mod) ->
    Filename = atom_to_list(Mod) ++ ".beam",
    case erl_prim_loader:get_file(Filename) of
        {ok, _Bin, FullFilename} ->
            FullFilename;
        _ ->
            error
    end.



%% 检查是否为release版, 以{d, debug}为标志
check_release(Mod) ->
    case code:is_loaded(Mod) of
        ?false ->
            ok;
        _ ->
            CurModInfo = Mod:module_info(compile),
            CurOptions = proplists:get_value(options, CurModInfo),
            CurIsDebug = lists:member({d, debug}, CurOptions),

            Filename = get_file_path(Mod),
            case beam_lib:chunks(Filename, [compile_info]) of
                {ok, {Mod, [{compile_info, Infos}]}} ->
                    Options = proplists:get_value(options, Infos),
                    IsDebug = lists:member({d, debug}, Options),
                    case CurIsDebug =:= IsDebug of
                        ?true ->
                            ok;
                        ?false ->
                            {error, release_not_match}
                    end;
                _ ->
                    {error, no_compile_info}
            end
    end.

soft_purge(Mod) ->
    case code:soft_purge(Mod) of
        ?true ->
            ok;
        _ ->
            {error, cannot_purge}
    end.

load_file(Mod) ->
    case code:load_file(Mod) of
        {module, Mod} ->
            ok;
        _ ->
            {error, cannot_load}
    end.

%% 检查并load, 全部成功返ok
-spec check_load(Mod) -> ok|{error, Reason} when
    Mod :: atom(),
    Reason :: atom().

check_load(Mod) when is_atom(Mod) ->
    check_load([Mod]);
check_load(Mods) when is_list(Mods)->
    R1 = all_ok(fun check_release/1, ok, Mods),
    R2 = all_ok(fun soft_purge/1, R1, Mods),
    R3 = all_ok(fun load_file/1, R2, Mods),

    sys_logger:fix(),
    act_logger:fix(),

    R3.


all_ok(Func, ok, [H|T]) ->
    case Func(H) of
        ok ->
            all_ok(Func, ok, T);
        Err ->
            io:format("Error on ~p: ~p~n", [H, Err]),
            Err
    end;
all_ok(_Func, Result, _List) ->
    Result.


%%%------------------------------------
%%% @author 严利宏 <542430172@qq.com>
%%% @copyright UCweb 2014.10.1
%%% @doc hot.
%%% @end
%%%------------------------------------
% 热更 
% ==== u:h()  % 编译加载有改动过的erl文件（注意：修改了头文件的话请用下面一条）
%      u:hh()
h() ->
    ErlFileList = filelib:wildcard("../src/**/*.erl"),
    F = fun([$., $., $/ | ErlFile__] = ErlFile) ->
            case file:read_file_info(ErlFile) of            
                {ok, #file_info{mtime=ErlTime}} ->
                    BeamName = lists:concat(["../ebin/", filename:basename(ErlFile, ".erl"), code:objfile_extension()]),
                    case file:read_file_info(BeamName) of
                        {ok, #file_info{mtime=BeamTime}} when ErlTime > BeamTime ->
                            ErlFile__;
                        {ok, _} -> 
                            skip;
                        _E ->  
                            ErlFile__
                    end;
                _ -> 
                    skip
            end
    end,
    CompileFiles = [Y || Y <- [F(X) || X <- ErlFileList], Y=/=skip ],

    StartTime = util:unixtime(),
    info("----------makes----------~n~p~n", [CompileFiles]),
    c:cd("../"),
    Res = make:files(CompileFiles, [netload]),
    c:cd("ebin"),
    EndTime = util:unixtime(),
    info("Make result = ~p~nMake Time : ~p s", [Res, EndTime-StartTime]),

    ok.

hh() ->
    StartTime = util:unixtime(),
    c:l(mmake),
    info("----------makes----------~n", []),
    c:cd("../"),
    Res = ( catch mmake:all(8, [netload]) ),
    c:cd("ebin"),
    EndTime = util:unixtime(),
    info("MMake result = ~p~nMMake Time : ~p s", [Res, EndTime-StartTime]),
    ok.



