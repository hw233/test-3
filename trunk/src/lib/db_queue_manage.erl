-module (db_queue_manage).
-behaviour (gen_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-export([
    start_link/0
    ,db_insert/3
    ,db_update/3
    ,db_replace/3
    ,db_delete/3
    ,db_exec_sql/3
    ,mark_tmp_logout_done/1
    ,mark_final_logout_done/1
    ]).

-include("common.hrl").
-include("debug.hrl").
-include("proc_name.hrl").

-record(state, {timeout_count = 0}).

-define(PRIVATE_NUM, 3).    % 玩家私人数据库进程数 数据库连接数=50时，设置为5

% -define(DB_PUBLIC_SYS, sys).

%% 封装数据库函数调用
db_insert(DB, Sql, Arg) ->
    gen_server:cast(get_db_proc_name(Arg), {db, DB, Sql, Arg}).

db_update(DB, Sql, Arg) ->
    gen_server:cast(get_db_proc_name(Arg), {db, DB, Sql, Arg}).

db_replace(DB, Sql, Arg) ->
    gen_server:cast(get_db_proc_name(Arg), {db, DB, Sql, Arg}).

db_delete(DB, Sql, Arg) ->
    gen_server:cast(get_db_proc_name(Arg), {db, DB, Sql, Arg}).

db_exec_sql(DB, Sql, Arg) ->
    gen_server:cast(get_db_proc_name(Arg), {db, DB, Sql, Arg}).


mark_tmp_logout_done(PlayerId) ->
    gen_server:cast(get_db_proc_name(PlayerId), {'mark_tmp_logout_done', PlayerId}).


mark_final_logout_done(PlayerId) ->
    gen_server:cast(get_db_proc_name(PlayerId), {'mark_final_logout_done', PlayerId}).



%% ============================================
%% gen_server faction
%% ============================================
init([Args]) ->
    put(proc_name, Args),
    process_flag('trap_exit', true),
    case Args =:= ?PUBLIC_DB_PROC of
        true ->
            %% init 玩家私人数据库进程
            case is_integer(?PRIVATE_NUM) andalso ?PRIVATE_NUM > 0 of
                true ->
                    List = [get_db_proc_name(Num) || Num <- lists:seq(1, ?PRIVATE_NUM)],
                    [gen_server:start_link({local, Name}, ?MODULE, [Name], []) || Name <- List];
                false -> skip
            end,
            {ok, #state{}};
        _ -> {ok, #state{}}
    end.


handle_call(_Request, _From, State) ->
    {reply, no_match, State}.


%% 处理数据库操作
handle_cast({db, DB, Sql, Arg}, State) ->
    % ?LDS_TRACE(get(proc_name), Sql),
    try db_esql:execute(DB, Sql) of
        _R -> {noreply, State}
    catch
        %% todo
        _:{timeout, _} -> 
            handle_timeout(DB, Sql, Arg),
            Count = State#state.timeout_count + 1,
            {noreply, State#state{timeout_count = Count}};
        Type:Error -> 
            ?ERROR_MSG("[~p, ~p] RoleId = ~p ErrorType = ~p, Error = ~p, sql = ~10000p ~n", [?MODULE, get(proc_name), Arg, Type, Error, Sql]),   %% todo 数据库执行错误，是否需要通知上层逻辑？
            {noreply, State}
    end;

handle_cast({notify, Pid, Msg}, State) ->
    Pid ! Msg,
    {noreply, State};

handle_cast({'mark_tmp_logout_done', PlayerId}, State) ->
    % ?DEBUG_MSG("db queue, handle_cast, mark_tmp_logout_done, PlayerId:~p", [PlayerId]),
    mod_lginout_TSL:do_mark_tmp_logout_done(PlayerId),
    {noreply, State};

handle_cast({'mark_final_logout_done', PlayerId}, State) ->
    % ?DEBUG_MSG("db queue, handle_cast, mark_final_logout_done, PlayerId:~p", [PlayerId]),
    mod_lginout_TSL:do_mark_final_logout_done(PlayerId),
    {noreply, State};

handle_cast(_Msg, State) ->
    {noreply, State}.


handle_info(_Info, State) ->
    {noreply, State}.


terminate(_Reason, _State) ->
    ok.


code_change(_OldVsn, State, _Extra) ->
    {ok, State}.


start_link() ->
    % List = [?PUBLIC_DB_PROC | [list_to_atom(?PRIVATE_DB_PROC ++ Num) || Num <- ?PRIVATE_NUM]],
    % [gen_server:start_link({local, Name}, ?MODULE, [], []) || Name <- List].

    gen_server:start_link({local, ?PUBLIC_DB_PROC}, ?MODULE, [?PUBLIC_DB_PROC], []).


%% doc 处理DB timeout操作
%% 投递回self()进程继续尝试Write db
handle_timeout(DB, Sql, Arg) ->
    ?ERROR_MSG("[~p] timeout RoleId = ~p DB = ~p, Sql = ~10000p~n", [?MODULE, Arg, DB, Sql]),
    skip.
    % gen_server:cast(self(), {db, DB, Sql}).


%% 取得数据库进程名
%% return: atom()
get_db_proc_name(?DB_SYS) -> ?PUBLIC_DB_PROC;
get_db_proc_name(Num) when is_integer(Num) ->
    list_to_atom(?PRIVATE_DB_PROC ++ integer_to_list(Num rem ?PRIVATE_NUM)).


