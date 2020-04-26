%%%---------------------------------------------
%%% @Module  : mysql_test
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2011.05.10
%%% @Description: mysql测试 -- 这个是旧文件，不再适合新项目， 但仍保留以做参考。 --huangjf
%%% @Resule  : 
%%%---------------------------------------------
-module(tst_mysql_test).
-export([conn_db_log_node/2,
		 create_db/2, test_read/1, test_write/1, test_concur_insert/1,
		 test_gen_account_id/2]).

-include("common.hrl").

conn_db_log_node(DB_node, Logger_node) ->
	% db
	ets:new(tbl_db_node, [named_table, public, set, {read_concurrency, true}]), % 并发读 
	ets:insert(tbl_db_node, {DB_node}),
	net_adm:ping(DB_node),
	
	Registered_names = rpc:call(DB_node, global, registered_names, []),
	F = fun(Name) ->
				Pid = rpc:call(DB_node, global, whereis_name, [Name]),
				global:register_name(Name, Pid)
		end,
	[F(Name) || Name <- Registered_names],
	
	% log
	net_adm:ping(Logger_node),
	Registered_names2 = rpc:call(Logger_node, global, registered_names, []),
	F2 = fun(Name) ->
				Pid = rpc:call(Logger_node, global, whereis_name, [Name]),
				global:register_name(Name, Pid)
		end,
	[F2(Name) || Name <- Registered_names2],
	
	loglevel:set(logger_h:log_level()),
	
    ok.
%% --------------------------------------------------------------------------------------------------------------------
%% 创建数据库
%% Db_engine: myisam|innodb
%% Record_num: 记录数
create_db(Db_engine, Record_num) ->
	io:format("--- db engine: ~p, record num: ~p ---~n", [Db_engine, Record_num]),
	db_esql:execute(<<"drop table if exists test">>),
	db_esql:execute(io_lib:format(<<"create table test (id int not null auto_increment,row varchar(50) not null,r int not null, primary key (id)) engine = ~p">>, [Db_engine])),
	
	%db_esql:execute(<<"begin">>),
    F = fun(I) ->
        db_esql:execute(io_lib:format(<<"insert into  `test` (`row`,`r`) values ('~s',~p)">>,["我是来测试性能的",I]))
    end,
	
	if
		Record_num > 0 ->
    		tst_prof:run_index(F, Record_num);
		true ->
			skip
	end,
    %db_esql:execute(<<"commit">>),
	ok.

%% Db_engine: myisam|innodb
test_gen_account_id(Db_engine, Num) ->
	db_esql:execute(<<"drop table if exists account">>),
	db_esql:execute(io_lib:format(<<"create table account (id int unsigned not null auto_increment, stub char(1) not null default '', primary key (id), unique key (stub)) engine = ~p">>, [Db_engine])),
	io:format("create table success~n"),

	F = fun() ->
			Id = db:replace_get_id(account, [{stub,"a"}]),
			Id
			%io:format("id = ~p~n", [Id])
		end,
	tst_prof:run(F, Num).

test_concur_insert(Num) ->
	[spawn(fun()-> db:insert(test, [row, r], ["test111", 1]) end) || _ <- lists:duplicate(Num, 0)].


%% --------------------------------------------------------------------------------------------------------------------

%% test_read() ->
%% 	F = fun() ->
%%         db_esql:get_row(io_lib:format(<<"select * from  `test` where id = ~p">>,[1]))
%%     end,
%% 	io:format("*** read time: ~n"),
%%     tst_prof:run(F, 10000),
%% ok.

%% 测试并发读
%% M: 读进程数
test_read(M) ->
	put(mytime, 0),
	put(mycnt, 0),

	F = fun(I, Pid) ->
				 spawn(
        			fun() -> 
						statistics(wall_clock),
%% 						io:format("+++ I: ~p~n", [I]),
%% 						io:format("+++ select~n"),
            			db_esql:get_row(io_lib:format(<<"select * from  `test` where id = ~p">>,[I])),
						{_, T1} = statistics(wall_clock),
						io:format("+++ T1:~p~n", [T1]),
						Pid ! {time, T1}
        			end
					  )
		 end,
	
	tst_prof:run_index_arg(F, M, self()),

	do_receive_read(M),
	ok.

do_receive_read(M) ->
	receive
		{time, T} ->
%% 			io:format("--- T: ~p~n", [T]),
			put(mytime, get(mytime) + T),
			put(mycnt, get(mycnt) + 1),
			case get(mycnt) == M of
				true ->
					io:format("*** read time=~p~n",[get(mytime)]);
%% 					test_read(M); % 打开该行则循环读
				false ->
					do_receive_read(M)
			end;
		_Any ->
				do_receive_read(M)
	end.

%% 测试并发写
%% M: 写进程数
test_write(M) ->
	put(mytime, 0),
	put(mycnt, 0),

	F = fun(I, Pid) ->
				 spawn(
        			fun() -> 
						statistics(wall_clock),
%% 						io:format("+++ I: ~p~n", [I]),
%% 						io:format("+++ update~n"),
            			db_esql:execute(io_lib:format(<<"update  `test` set  `row` = '~s' where id = ~p">>,["for test2",I])),
						{_, T1} = statistics(wall_clock),
%% 						io:format("+++ T1:~p~n", [T1]),
						Pid ! {time, T1}
        			end
					  )
		 end,
	
	tst_prof:run_index_arg(F, M, self()),

	do_receive_write(M),
	ok.

do_receive_write(M) ->
	receive
		{time, T} ->
%% 			io:format("--- T: ~p~n", [T]),
			put(mytime, get(mytime) + T),
			put(mycnt, get(mycnt) + 1),
			case get(mycnt) == M of
				true ->
					io:format("*** write time=~p~n",[get(mytime)]);
%% 					test_write(M); % 打开该行则循环写
				false ->
					do_receive_write(M)
			end;
		_Any ->
				do_receive_write(M)
	end.

