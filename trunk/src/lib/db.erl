%%%--------------------------------------
%%% @Module  : db
%%% @Author  :
%%% @Created : 2012.5.29
%%% @Description: mysql 数据库操作
%%%--------------------------------------
-module(db).

-export([
    init_db/1,

	 	insert_get_id/3,
	 	insert/3,
		insert/2,

		insert_or_update/3,

		replace/2,
		replace_get_id/2,
		update/5,
		update/3,

		update/2,

		select_one/5,
		select_one/3,
		select_row/5,
		select_row/3,

		select_row/2,

    select_count/1,
		select_count/2,
		select_all/5,
		select_all/3,

		select_all/2,

		delete/2,

    foldl/3,

    kv_insert/3,  kv_insert/5,
    kv_lookup/2,
    kv_foldl/3,

		%% 通过数据库队列存储 ===========
		insert/4,
		replace/3,
		update/4,
		update/6,
		delete/3,

		%% ===========

    dump_db_op_stat/0
    
    ]).


-include("common.hrl").
-include("record.hrl").
-include("ets_name.hrl").
-include("db.hrl").

-define(RECORD_CUR_TIME, Now = os:timestamp(),).
-define(STAT_DB_ACCESS(Table_name, Operation), stat_db_access_new(Table_name, Operation, Now),).

-define(USE_MYSQL_CACHE, app_opt:get_env(use_mysql_cache, false)).
-define(FOLD_ACC_NUM, 5000).

%% 初始化db
init_db(App) ->
    % 游戏db
    DB_Host1 = config:get_db_host(App),    DB_Port1 = config:get_db_port(App),
    DB_User = config:get_db_user(App),     DB_Password = config:get_db_password(App),
    DB_Name = config:get_db_name(App),
    ?TRACE("DB_Host1: ~p(is list: ~p), DB_Port1: ~p(is int: ~p)~n", [DB_Host1, is_list(DB_Host1), DB_Port1, is_integer(DB_Port1)]),
    ?TRACE("DB_User: ~p(is list: ~p), DB_Password: ~p(is list: ~p)~n", [DB_User, is_list(DB_User), DB_Password, is_list(DB_Password)]),
    ?TRACE("DB_Name: ~p(is list: ~p)~n", [DB_Name, is_list(DB_Name)]),

    mysql:start_link(?DB, DB_Host1, DB_Port1, DB_User, DB_Password, DB_Name, fun(_, _, _, _) -> ok end, ?DB_ENCODE),
    F1 = fun() -> mysql:connect(?DB, DB_Host1, DB_Port1, DB_User, DB_Password, DB_Name, ?DB_ENCODE, true) end,
    [F1() || _ <- lists:duplicate(config:get_db_conn_num(App) - 1, dummy)],  % mysql:start_link()中连了一次，所以这里减1

    % % 后台db
    % Db_host2 = config:get_bg_db_host(App),    Db_port2 = config:get_bg_db_port(App),
    % F2 = fun() -> mysql:connect(?DB_BG, Db_host2, Db_port2, ?DB_USER_BG, ?DB_PASS_BG, ?DB_NAME_BG, ?DB_ENCODE_BG, true) end,
    % [F2() || _ <- lists:duplicate(config:get_bg_db_conn_num(App), dummy)],

    ok.

% 插入或者更新
insert_or_update(Table_name, FieldList, ValueList) ->
	?RECORD_CUR_TIME  
	Sql = db_esql:make_insert_or_update_sql(Table_name, FieldList, ValueList),
	% ?DEBUG_MSG("insert_or_update SQL = ~p",[Sql]),
	db_esql:execute(?DB, Sql),
	?STAT_DB_ACCESS(Table_name, insert_or_update)
	ok.

%% 插入数据表，获得id
insert_get_id(Table_name, FieldList, ValueList) ->
  ?RECORD_CUR_TIME
  Result =
  case ?USE_MYSQL_CACHE of
    true ->
      mysql_cache:insert_get_id(Table_name, FieldList, ValueList);
    false ->
      Sql = db_esql:make_insert_sql(Table_name, FieldList, ValueList),
      db_esql:update_get_id(?DB, Sql)
  end,
  ?STAT_DB_ACCESS(Table_name, insert_get_id)
  Result.

%% 插入数据表
%% 通过数据库队列存储
%% @para: DbFlag => 如果是属于玩家自己的数据库操作，则传入玩家id，否则，传入?DB_SYS宏
insert(DbFlag, Table_name, Field_Value_List) when is_integer(DbFlag) ->
  ?RECORD_CUR_TIME
  case ?USE_MYSQL_CACHE of
    true ->
      mysql_cache:insert(Table_name, Field_Value_List);
    false ->
      Sql = db_esql:make_insert_sql(Table_name, Field_Value_List),
      db_queue_manage:db_insert(?DB, Sql, DbFlag)
  end,
  ?STAT_DB_ACCESS(Table_name, insert)
  ok;

insert(Table_name, FieldList, ValueList) ->
  ?RECORD_CUR_TIME
  Result =
  case ?USE_MYSQL_CACHE of
    true ->
      mysql_cache:insert(Table_name, FieldList, ValueList);
    false ->
      Sql = db_esql:make_insert_sql(Table_name, FieldList, ValueList),
      % ?DEBUG_MSG("SQL1=~p",Sql),

      db_esql:execute(?DB, Sql)
  end,
  ?STAT_DB_ACCESS(Table_name, insert)
  Result.

%% 通过数据库队列存储
insert(DbFlag, Table_name, FieldList, ValueList) ->
  ?RECORD_CUR_TIME
  case ?USE_MYSQL_CACHE of
    true ->
      mysql_cache:insert(Table_name, FieldList, ValueList);
    false ->
      Sql = db_esql:make_insert_sql(Table_name, FieldList, ValueList),
      db_queue_manage:db_insert(?DB, Sql, DbFlag)
  end,
  ?STAT_DB_ACCESS(Table_name, insert)
  ok.

insert(Table_name, Field_Value_List) ->
  ?RECORD_CUR_TIME
  Result =
  case ?USE_MYSQL_CACHE of
    true ->
      mysql_cache:insert(Table_name, Field_Value_List);
    false ->
      Sql = db_esql:make_insert_sql(Table_name, Field_Value_List),
      db_esql:execute(?DB, Sql)
  end,
  ?STAT_DB_ACCESS(Table_name, insert)
  Result.

%% 修改数据表(replace方式)
replace(Table_name, Field_Value_List) ->
	?RECORD_CUR_TIME
  Result =
  case ?USE_MYSQL_CACHE of
    true ->
      mysql_cache:replace(Table_name, Field_Value_List);
    false ->
      Sql = db_esql:make_replace_sql(Table_name, Field_Value_List),
      db_esql:execute(?DB, Sql)
  end,
	?STAT_DB_ACCESS(Table_name, replace)
	Result.

%% 通过数据库队列存储
replace(DbFlag, Table_name, Field_Value_List) ->
	?RECORD_CUR_TIME
  case ?USE_MYSQL_CACHE of
    true ->
      mysql_cache:replace(Table_name, Field_Value_List);
    false ->
    	Sql = db_esql:make_replace_sql(Table_name, Field_Value_List),
    	db_queue_manage:db_replace(?DB, Sql, DbFlag)
  end,
	?STAT_DB_ACCESS(Table_name, replace)
	ok.

%% 修改数据表，获得id
replace_get_id(Table_name, Field_Value_List) ->
	?RECORD_CUR_TIME
  Result =
  case ?USE_MYSQL_CACHE of
    true ->
      mysql_cache:replace_get_id(Table_name, Field_Value_List);
    false ->
      Sql = db_esql:make_replace_sql(Table_name, Field_Value_List),
      db_esql:execute(?DB, Sql)
  end,
	?STAT_DB_ACCESS(Table_name, replace_get_id)
	Result.

%% 修改数据表(update方式)
update(Table_name, Field, Data, Key, Value) ->
	?RECORD_CUR_TIME
  Result =
  case ?USE_MYSQL_CACHE of
    true ->
      mysql_cache:update(Table_name, Field, Data, Key, Value);
    false ->
      Sql = db_esql:make_update_sql(Table_name, Field, Data, Key, Value),
      db_esql:execute(?DB, Sql)
  end,
	?STAT_DB_ACCESS(Table_name, update)
	Result.
update(Table_name, Field_Value_List, Where_List) when is_atom(Table_name) ->
	?RECORD_CUR_TIME
  Result =
  case ?USE_MYSQL_CACHE of
    true ->
      mysql_cache:update(Table_name, Field_Value_List, Where_List);
    false ->
      Sql = db_esql:make_update_sql(Table_name, Field_Value_List, Where_List),
      % ?DEBUG_MSG("SQL2=~p",[Sql]),
      db_esql:execute(?DB, Sql)
  end,
	?STAT_DB_ACCESS(Table_name, update)
	Result;
%% 通过数据库队列存储，不支持 USE_MYSQL_CACHE 注意：Sql是完整的sql语句，而Table_name是用来标识是哪个表的，Table_name和Sql语句里的表名要一样
update(DbFlag, Table_name, Sql) when is_integer(DbFlag) ->
    ?RECORD_CUR_TIME
  case ?USE_MYSQL_CACHE of
    true ->
        skip;
    false ->
      db_queue_manage:db_update(?DB, Sql, DbFlag)
  end,
  ?STAT_DB_ACCESS(Table_name, update)
  ok.

%% 通过数据库队列存储
update(DbFlag, Table_name, Field, Data, Key, Value) ->
	?RECORD_CUR_TIME
  case ?USE_MYSQL_CACHE of
    true ->
      mysql_cache:update(Table_name, Field, Data, Key, Value);
    false ->
    	Sql = db_esql:make_update_sql(Table_name, Field, Data, Key, Value),
    	db_queue_manage:db_update(?DB, Sql, DbFlag)
  end,
	?STAT_DB_ACCESS(Table_name, update)
	ok.
%% 通过数据库队列存储
update(DbFlag, Table_name, Field_Value_List, Where_List) ->
	?RECORD_CUR_TIME
  case ?USE_MYSQL_CACHE of
    true ->
      mysql_cache:update(Table_name, Field_Value_List, Where_List);
    false ->
    	Sql = db_esql:make_update_sql(Table_name, Field_Value_List, Where_List),
    	db_queue_manage:db_update(?DB, Sql, DbFlag)
  end,
	?STAT_DB_ACCESS(Table_name, update)
	ok.

%% 警告：只用于特殊复杂的sql语句，其他禁用！！！
%% 注意：Sql是完整的sql语句，而Table_name是用来标识是哪个表的，Table_name和Sql语句里的表名要一样
update(Table_name, Sql) ->
	?RECORD_CUR_TIME
	Result = db_esql:execute(?DB, Sql),
	?STAT_DB_ACCESS(Table_name, update)
	Result.

%% 获取一个数据字段
select_one(Table_name, Fields_sql, Where_List, Order_List, Limit_num) ->
	?RECORD_CUR_TIME
  Result =
  case ?USE_MYSQL_CACHE of
    true ->
      case mysql_cache:select(Table_name, Fields_sql, Where_List, Order_List, Limit_num) of
        [[R|_]|_] ->
          R;
        _Other ->
          null
      end;
    false ->
      Sql = db_esql:make_select_sql(Table_name, Fields_sql, Where_List, Order_List, Limit_num),
      db_esql:get_one(?DB, Sql)
  end,
	?STAT_DB_ACCESS(Table_name, select)
	Result.
select_one(Table_name, Fields_sql, Where_List) ->
	?RECORD_CUR_TIME
  Result =
  case ?USE_MYSQL_CACHE of
    true ->
      case mysql_cache:select(Table_name, Fields_sql, Where_List) of
        [[R|_]|_] ->
          R;
        _Other ->
          null
      end;
    false ->
      Sql = db_esql:make_select_sql(Table_name, Fields_sql, Where_List),
      db_esql:get_one(?DB, Sql)
  end,
	?STAT_DB_ACCESS(Table_name, select)
	Result.

%% 获取一条数据记录
select_row(Table_name, Fields_sql, Where_List, Order_List, Limit_num) ->
	?RECORD_CUR_TIME
  Result =
  case ?USE_MYSQL_CACHE of
    true ->
      case mysql_cache:select(Table_name, Fields_sql, Where_List, Order_List, Limit_num) of
        [R|_] ->
          R;
        _Other ->
          []
      end;
    false ->
      Sql = db_esql:make_select_sql(Table_name, Fields_sql, Where_List, Order_List, Limit_num),
      db_esql:get_row(?DB, Sql)
  end,
	?STAT_DB_ACCESS(Table_name, select)
	Result.
select_row(Table_name, Fields_sql, Where_List) ->
	?RECORD_CUR_TIME
  Result =
  case ?USE_MYSQL_CACHE of
    true ->
      case mysql_cache:select(Table_name, Fields_sql, Where_List) of
        [R|_] ->
          R;
        _Other ->
          []
      end;
    false ->
      Sql = db_esql:make_select_sql(Table_name, Fields_sql, Where_List),
      db_esql:get_row(?DB, Sql)
  end,
	?STAT_DB_ACCESS(Table_name, select)
	Result.

%% 警告：只用于特殊复杂的sql语句，其他禁用！！！
%% 注意：Sql是完整的sql语句，而Table_name是用来标识是哪个表的，Table_name和Sql语句里的表名要一样
select_row(Table_name, Sql) ->
	?RECORD_CUR_TIME
	Result = db_esql:get_row(?DB, Sql),
	?STAT_DB_ACCESS(Table_name, select)
	Result.

%% 获取表大小
select_count(Table_name) ->
  [Count] = select_row(Table_name, lists:concat(["SELECT COUNT(*) FROM `", Table_name, "`"])),
  Count.

%% 获取记录个数
select_count(Table_name, Where_List) ->
	[Count] = select_row(Table_name, "count(1)", Where_List),
  Count.

%% 获取所有数据
select_all(Table_name, Fields_sql, Where_List, Order_List, Limit_num) ->
	?RECORD_CUR_TIME
  Result =
  case ?USE_MYSQL_CACHE of
    true ->
      mysql_cache:select(Table_name, Fields_sql, Where_List, Order_List, Limit_num);
    false ->
      Sql = db_esql:make_select_sql(Table_name, Fields_sql, Where_List, Order_List, Limit_num),
      db_esql:get_all(?DB, Sql)
  end,
	?STAT_DB_ACCESS(Table_name, select)
	Result.
select_all(Table_name, Fields_sql, Where_List) ->
	?RECORD_CUR_TIME
  Result =
  case ?USE_MYSQL_CACHE of
    true ->
      mysql_cache:select(Table_name, Fields_sql, Where_List);
    false ->
      Sql = db_esql:make_select_sql(Table_name, Fields_sql, Where_List),
      % ?DEBUG_MSG("Sql=~p",[Sql]),
      db_esql:get_all(?DB, Sql)
  end,
	?STAT_DB_ACCESS(Table_name, select)
	Result.

%% 警告：只用于特殊复杂的sql语句，其他禁用！！！
%% 注意：Sql是完整的sql语句，而Table_name是用来标识是哪个表的，Table_name和Sql语句里的表名要一样
select_all(Table_name, Sql) ->
	?RECORD_CUR_TIME
	Result = db_esql:get_all(?DB, Sql),
	?STAT_DB_ACCESS(Table_name, select)
	Result.

%% 删除数据
delete(Table_name, Where_List) ->
	?RECORD_CUR_TIME
  Result =
  case ?USE_MYSQL_CACHE of
    true ->
      mysql_cache:delete(Table_name, Where_List);
    false ->
      Sql = db_esql:make_delete_sql(Table_name, Where_List),
      db_esql:execute(?DB, Sql)
  end,
	?STAT_DB_ACCESS(Table_name, delete)
	Result.

%% 通过数据库队列存储
delete(DbFlag, Table_name, Where_List) ->
	?RECORD_CUR_TIME
  case ?USE_MYSQL_CACHE of
    true ->
      mysql_cache:delete(Table_name, Where_List);
    false ->
    	Sql = db_esql:make_delete_sql(Table_name, Where_List),
    	db_queue_manage:db_delete(?DB, Sql, DbFlag)
  end,
	?STAT_DB_ACCESS(Table_name, delete)
	ok.


%% --------------------------------------------------------------------------

%% dump数据库操作统计信息到文件
dump_db_op_stat() ->
    case open_db_op_stat_log_file() of
        {error, Error} ->
            io:format("dump_db_op_stat() failed!! open_db_op_stat_log_file Error:~p", [Error]),
            skip;
        {ok, Fd} ->
            BlankLines = io_lib:format("\n\n\n\n\n\n\n\n\n\n", []),
            file:write(Fd, BlankLines),

            {Year, Month, Day} = erlang:date(),
            {Hour, Minute, Second} = erlang:time(),
            DateTime = io_lib:format("=============== ~p-~p-~p   ~p:~p:~p ================\n\n", [Year, Month, Day, Hour, Minute, Second]),
            file:write(Fd, DateTime),

            write_db_op_stat_info(Fd),

            file:close(Fd)
    end.
  

open_db_op_stat_log_file() ->
    filelib:ensure_dir("./logs/db_op_stat/"),

    {Year, Month, Day} = erlang:date(),
    YMD = integer_to_list(Year) ++ "_" ++ integer_to_list(Month) ++ "_" ++ integer_to_list(Day),
    File = lists:concat(["./logs/db_op_stat/", YMD, ".log"]),

    case file:open(File, [write, raw, append]) of
        {ok, Fd} ->
            {ok, Fd};
        Error ->
            {error, Error}
    end.
  

write_db_op_stat_info(Fd) ->
    L = ets:tab2list(?ETS_STAT_DB),
    write_db_op_stat_info__(L, Fd).


write_db_op_stat_info__([], _Fd) ->
    done;
write_db_op_stat_info__([Item | T], Fd) ->
    Str = build_db_op_stat_info_str(Item),
    file:write(Fd, Str),
    write_db_op_stat_info__(T, Fd).


build_db_op_stat_info_str(Item) ->
    io_lib:format("~-40s ~-28s ~-16s ~-25s ~-15s ~-16s ~-16s ~-16s ~s\n",
                        [
                        Item#db_op_stat.key,
                        Item#db_op_stat.tbl_name,
                        Item#db_op_stat.op_type,
                        io_lib:format("~w", [Item#db_op_stat.first_op_time]),
                        integer_to_list(Item#db_op_stat.op_times),
                        integer_to_list(Item#db_op_stat.min_op_cost_time),
                        integer_to_list(Item#db_op_stat.max_op_cost_time),
                        integer_to_list(Item#db_op_stat.sum_op_cost_time),
                        integer_to_list(Item#db_op_stat.avg_op_cost_time)
                        ]).
    

%% --------------------------------------------------------------------------
%%统计数据表操作次数和频率
% stat_db_access(Table_name, Operation, Begin_sql_time) ->
% 	try
% 		Now = os:timestamp(),
% 		SqlTime = timer:now_diff(Now, Begin_sql_time),
% 		Key = lists:concat([Table_name, "/", Operation]),
% 		[NowBeginTime, NowCount, NowSqlTime] =
%     		case ets:match(?ETS_STAT_DB,{Key, Table_name, Operation , '$4', '$5', '$6'}) of
%     			[[OldBeginTime, OldCount, OldSqlTime]] ->
%     				[OldBeginTime, OldCount+1, erlang:max(SqlTime, OldSqlTime)];
%     			_ ->
%     				[Now,1,SqlTime]
%     		end,
% 		ets:insert(?ETS_STAT_DB, {Key, Table_name, Operation, NowBeginTime, NowCount, NowSqlTime}),
% 		ok
% 	catch
% 		_:_ -> no_stat
% 	end.


% 新版本的统计数据表操作次数和频率
stat_db_access_new(Table_name, Operation, Begin_sql_time) ->
    try
        Now = os:timestamp(),
        CostTime = timer:now_diff(Now, Begin_sql_time),
        Key = lists:concat([Table_name, "/", Operation]),
        
        R2 =
            case ets:lookup(?ETS_STAT_DB, Key) of
              [R] ->
                  SumOpCostTime = R#db_op_stat.sum_op_cost_time + CostTime,
                  OpTimes = R#db_op_stat.op_times + 1,
                  R#db_op_stat{
                      op_times = OpTimes,
                      min_op_cost_time = erlang:min(CostTime, R#db_op_stat.min_op_cost_time),
                      max_op_cost_time = erlang:max(CostTime, R#db_op_stat.max_op_cost_time),
                      sum_op_cost_time = SumOpCostTime,
                      avg_op_cost_time = SumOpCostTime div OpTimes
                      };
              [] ->
                  #db_op_stat{
                      key = Key,
                      tbl_name = Table_name,
                      op_type = Operation,
                      first_op_time = Now,
                      op_times = 1,
                      min_op_cost_time = CostTime,
                      max_op_cost_time = CostTime,
                      sum_op_cost_time = CostTime,
                      avg_op_cost_time = CostTime
                      }
            end,
        ets:insert(?ETS_STAT_DB, R2),
        ok
    catch
        _:_ -> no_stat
    end.

%% --------------------------------------------------------------------------
%%统计某个表的各操作的次数
%%使用示例：stat_table_op_count(Table_name, player, Field_Value_List)
% stat_table_op_count(Table_name, Stat_table_name, Op) ->
% 	if
% 		Table_name == Stat_table_name ->
% 			case ets:info(ets_stat_sql_table_op) of
% 				undefined ->
% 					ets:new(ets_stat_sql_table_op, [set, public, named_table]);
% 				_ ->
% 					skip
% 			end,
% 			case ets:lookup(ets_stat_sql_table_op, Op) of
% 				[] ->
% 					ets:insert(ets_stat_sql_table_op,{Op, 1});
% 				[{_, Count}] ->
% 					ets:insert(ets_stat_sql_table_op,{Op, Count+1})
% 			end;
% 		true ->
% 			skip
% 	end.



select_seq(Table, Fields, Offset) ->
    Limit = lists:concat([Offset, ",", ?FOLD_ACC_NUM]),
    select_all(Table, Fields, [], [], [Limit]).

foldl(Fun, Acc0, {Table, Fields}) ->
    foldl(Fun, Acc0, {Table, Fields}, 0).

foldl(Fun, Acc0, {Table, Fields}, Offset) ->
    case select_seq(Table, Fields, Offset) of
        [] ->
            Acc0;
        Data ->
            Acc1 = lists:foldl(Fun, Acc0, Data),
            foldl(Fun, Acc1, {Table, Fields}, Offset + ?FOLD_ACC_NUM)
    end.

kv_insert(Table, Key, Value) ->
    KeyBin = mysql:encode(Key),
    ValueBin = mysql:encode(term_to_binary(Value)),
    Sql = lists:concat(["INSERT INTO ", Table,  " (id, data) VALUES (", KeyBin,
        ",", ValueBin, ") ON DUPLICATE KEY UPDATE data=VALUES(data)"]),
    db_esql:execute(?DB, Sql),
    case Table of
        title ->
            DiyTitle = ply_title:get_diytitles(Key),
            db:update(title, [{diy_title, util:term_to_bitstring(DiyTitle)}], [{id, Key}]);
        _ -> skip
    end.

%% 通过数据库队列存储（参数q表示queue）
kv_insert(q, DbFlag, Table, Key, Value) ->
    KeyBin = mysql:encode(Key),
    ValueBin = mysql:encode(term_to_binary(Value)),
    Sql = lists:concat(["INSERT INTO ", Table,  " (id, data) VALUES (", KeyBin,
        ",", ValueBin, ") ON DUPLICATE KEY UPDATE data=VALUES(data)"]),
    db_queue_manage:db_exec_sql(?DB, Sql, DbFlag).


kv_lookup(Table, Key) ->
    Data = select_row(Table, "data", [{id, Key}]),
    [binary_to_term(D) || D <- Data].

kv_foldl(Fun, Acc0, Table) ->
    Fun2 = fun([Elem], Acc) -> Fun(binary_to_term(Elem), Acc) end,
    foldl(Fun2, Acc0, {Table, "data"}).



%%
%% Tests
%%
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").

kv_test() ->
    try
        db_esql:execute(?DB, "CREATE TABLE sm_db_test (id int, data blob)"),
        timer:sleep(200),
        [kv_insert(sm_db_test, I, I + 1) || I <- lists:seq(0, 50)],
        ?assertEqual([14], kv_lookup(sm_db_test, 13)),
        ?assertEqual([], kv_lookup(sm_db_test, 1000))
    after
        db_esql:execute(?DB, "DROP TABLE sm_db_test")
    end.

-endif.
