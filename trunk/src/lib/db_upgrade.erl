%%%-------------------------------------------------------------------
%%% @author ningwenbin
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%     数据库升级
%%%     按版本号递增+1
%%% @end
%%% Created : 22. 2月 2020 14:11
%%%-------------------------------------------------------------------
-module(db_upgrade).
-author("ningwenbin").
-include("db.hrl").
-include("debug.hrl").

-define(VERSION,        1).     % 最新版本号，+1递增

%% API
-export([
    upgrade/0
]).

upgrade() ->
    Version =
        case db:select_one('db_version', "version", [{'id', 1}]) of
            null -> 0;
            Version0 -> Version0
        end,
    lists:foreach(
        fun(CurV) ->
            try
                version(CurV),
                db:replace('db_version', [{'id', 1},{'version',CurV}])
            catch
                Type:Err  ->
                    ?ASSERT(false, [CurV, Type, Err])
            end
        end, lists:seq(Version+1, ?VERSION)),

    ok.

%% @doc 例子
version(1) ->
    excute_sql("../sql/update_sql/db_up_2020_02_25.sql").

excute_sql(FileDir) ->
    {ok,Sql} = file:read_file(FileDir),
    SqlList = string:tokens(binary_to_list(Sql), ";"),
    lists:foreach(fun(Cmd) ->
        case Cmd of
            [] -> skip;
            _ ->
                mysql:fetch(?DB, Cmd, 60*5*1000)
        end
                  end, SqlList).

