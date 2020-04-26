%% @author wujiancheng
%% 多进程编译,有效提高编译的速度.

-module(make2).

-export([all/1]).

-include_lib("kernel/include/file.hrl").


%%ProcessNumber为要开启的进程数
all(ProcessNumber) ->
	case read_emakefile('Emakefile') of
        Files when is_list(Files) ->
            process(ProcessNumber,Files);
        error ->
            error
    end.

%%Emakefile的内容需要是一个元组类型，例如
%%    { ['src/*',
%%		 'src/lib/*',
%%       'src/mod/*',],
%%      [debug_info,
%% 		 {i, "include"},
%% 		 {d, debug},
%% 		 {outdir, "ebin"}] }
read_emakefile(Emakefile) ->
    case file:consult(Emakefile) of
	{ok, Emake} ->
		
	    transform(Emake);
	{error,enoent} -> 
	    Mods = [filename:rootname(F) ||  F <- filelib:wildcard("*.erl")],
	    [{Mods}];
	{error,Other} ->
	    io:format("make: Trouble reading 'Emakefile':~n~p~n",[Other]),
	    error
    end.

%%Emakefile文件中，得到元组第一个元素所有目录的*.erl文件名，返回ModFiles（省略 erl 后缀名）的列表 ++ Optionslist编译配置选项
transform([{Mod,ModOpts}]) ->
    case expand(Mod) of
	[] -> 
	    [];
	Mods -> 
		[{Mods,ModOpts}]
    end.


expand(Mods) when is_list(Mods), not is_integer(hd(Mods)) ->
    lists:concat([expand(Mod) || Mod <- Mods]);
expand(Mod2) ->
	Mod = atom_to_list(Mod2),
    %*表示目录下可能有多个文件
	case lists:member($*,Mod) of
		true -> 
			Fun = fun(F,Acc) ->
						  M = filename:rootname(F),
						  [M|Acc]			  
				  end,
			%查找 erl  结尾的文件
			lists:foldl(Fun, [], filelib:wildcard(Mod++".{erl}"));
		false ->
			Mod2 = filename:rootname(Mod, ".erl"),
			[Mod2]
	
	end.


process(ProcessNumber,[{[], _Options }|Rest]) ->
	process(ProcessNumber, Rest);

process( ProcessNumber, [{L, Options }|Rest]) ->
	Len = length(L),
	ProcessNumber2 = erlang:min(Len, ProcessNumber),
	%开启多进程编译, Options的作用是为了对比hrl文件变化是否影响到与该hrl相关的erl文件
	case  do_worker(ProcessNumber2, L,Options) of
		error ->		
			error;
		finish -> 
			process(ProcessNumber, Rest)
	end;
	

process(_ProcessNumber,[]) ->
    up_to_date.

%% 多进程进行编译
do_worker(ProcessNumber,L,Options) ->
    WorkerList = do_split_list(L, ProcessNumber),
	Pids =
	[ start_worker(E,Options,self())
	   || E <- WorkerList],
	io:format("Pids :~p~n",[length(Pids)]),
	do_wait_worker(length(Pids)).

%% 进程走完，表示编译完成
do_wait_worker(0) ->
    finish;
do_wait_worker(N) ->
    receive
        {success} ->
            do_wait_worker(N - 1);
        {error} ->
			error;
        _Other ->
            io:format("receive unknown msg:~p~n", [_Other])
    end.

	

	

start_worker(Mods,Options,Parent) ->
	
	Fun= fun() ->
				 [begin
					  case check_recompile(Mod,Options) of
						  error ->
							  io:format("Moudle ~p Recompile Error: \n",[Mod]),
							  Parent ! {error};
						  {'ok', Module}  ->
							  io:format("Recompile load: ~p\n",[Module]);
						  _ ->
							  skip
					  end 
				  end
				  || Mod <- Mods ],
				 
		 Parent ! {success}
		 
		 end,
	
	spawn(Fun).




%% 将L分割成最多包含N个子列表的列表
do_split_list(L, N) ->
    Len = length(L), 
    % 每个列表最多含有的元素数
    Len2 = Len / N,
	
	%向上取整，保证分成N个进程执行
	T = trunc(Len2),
	Len3 =
		case Len2 == T of
			true  -> T;
			false -> 1 + T
		end,
   
    do_split_list(L, Len3, []).

do_split_list([], _N, Acc) ->
    lists:reverse(Acc);
do_split_list(L, N, Acc) ->
    {L2, L3} = lists:split(erlang:min(length(L), N), L),
    do_split_list(L3, N, [L2 | Acc]).

check_recompile(ModFile,Options) ->
	ObjName = lists:append(filename:basename(ModFile),
			   ".beam"),
	
	% xx.erl的在 yy/xx.beam 文件名
    ObjFile = 
		case lists:keysearch(outdir,1,Options) of
			{value,{outdir,OutDir}} ->
				filename:join([OutDir,ObjName]);
			false ->
				ObjName
		end,

	% xx.beam是否存在，存在则需要对比创建时间和hrl修改时间，从而决定xx.erl是否需要编译
	case file:read_file_info(ObjFile) of
	{ok, _} ->
	    check_recompile1(ModFile, Options, ObjFile);
	_ ->
        c:c(ModFile, Options)
    end.

check_recompile1(ModFile, Options, ObjFile) ->
	
    {ok, Erl} = file:read_file_info(lists:append(ModFile, ".erl")),
    {ok, Obj} = file:read_file_info(ObjFile),
	%文件的大小，创建时间，最后修改时间
	

	check_recompile1(Erl, Obj, ModFile, Options).

%相关的hrl文件修改时间大于已经存在的beam文件的修改时间，需要重新编译
check_recompile1(#file_info{mtime=Te},
	    #file_info{mtime=To}, ModFile , Options) when Te>To ->
    c:c(ModFile, Options);
check_recompile1(_Erl, #file_info{mtime=To}, ModFile , Options) ->
    check_recompile2(To, ModFile,  Options).

check_recompile2(BeamMTime, ModFile, Options) ->
    IncludePath = include_opt(Options),
    case check_includes(lists:append(ModFile, ".erl"), IncludePath, BeamMTime) of
	true ->
		c:c(ModFile, Options);
	false ->
		io:format("~p  No need to compile~n",[lists:append(ModFile, ".erl")])
    end.

%% 例如从EmakeFile拿出内容，如下
%% ['include/protocol',
%%  'include/third',
%%  'include']
include_opt([{i,Path}|Rest]) ->
    [Path|include_opt(Rest)];
include_opt([_First|Rest]) ->
    include_opt(Rest);
include_opt([]) ->
    [].

%%% If you an include file is found with a modification
%%% time larger than the modification time of the object
%%% file, return true. Otherwise return false.
check_includes(ErlFile, IncludePath, ObjMTime) ->
	%打开用于预处理的文件
    case epp:open(ErlFile, IncludePath, []) of
	{ok, Epp} ->
		
	    check_includes2(Epp, ErlFile, ObjMTime);
	_Error ->
	    false
    end.


%判断ObjMTime与xx.hrl相关的erl文件的beam文件修改时间
check_includes2(Epp, File, ObjMTime) ->
	
    case epp:parse_erl_form(Epp) of
	{ok, {attribute, 1, file, {File, 1}}} ->
	    check_includes2(Epp, File, ObjMTime);
	{ok, {attribute, 1, file, {IncFile, 1}}} ->

	    case file:read_file_info(IncFile) of
		{ok, #file_info{mtime=MTime}} when MTime > ObjMTime ->
		    epp:close(Epp),
		    true;
		{ok, _} ->
		    check_includes2(Epp, File, ObjMTime)
	    end;
	{ok, _} ->
	    check_includes2(Epp, File, ObjMTime);
	{eof, _} ->
	    epp:close(Epp),
	    false;
	{error, _Error} ->
	    check_includes2(Epp, File, ObjMTime)
    end.

	
	

