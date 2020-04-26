%% Author: Skyman Wu
%% Created: 2012-5-29
%% Modify: zhangwq 2013.08.21
%% Description: 测试db模块
-module(tst_db_test).

%%
%% Include files
%%
-include("common.hrl").
-include("db.hrl").
%%
%% Exported Functions
%%
-compile(export_all).

%% 直接在server节点上调用下列函数测试

%% API Functions
%%

create_db() ->
	PoolId = ?DB,
	Sql = <<"drop table if exists test">>,
	db_esql:execute(PoolId, Sql),
	Sql1 = io_lib:format(<<"create table test (id int not null auto_increment,row varchar(50) not null,r int not null, primary key (id)) engine = ~p">>, [innodb]),
	db_esql:execute(PoolId, Sql1),
	ok.


%% 插入数据表，获得id
test_insert_get_id() ->
	Table_name = test, 
	FieldList = [row, r],
	ValueList = ["test111", 1],
	_Result = db:insert_get_id(Table_name, FieldList, ValueList),
	?TRACE("Result: ~p~n", [_Result]).


%% 插入数据表
test_insert() ->
	Table_name = test, 
	FieldList = [row, r], 
	ValueList = ["test111", 1],
	_Result = db:insert(Table_name, FieldList, ValueList),
	?TRACE("Result: ~p~n", [_Result]),

	Field_Value_List = [{row,"test111"}, {r,2}],
	_Result1 = db:insert(Table_name, Field_Value_List),
	?TRACE("Result: ~p~n", [_Result1]).


%% 修改数据表(replace方式)
test_replace() ->
	Table_name = test, 
	Field_Value_List = [{id,1}, {row,"test222"}, {r,1}],
	_Result = db:replace(Table_name, Field_Value_List),
	?TRACE("Result: ~p~n", [_Result]).


%% 修改数据表(update方式)
test_update() ->
	Table_name = test, 
	Field = ["row"],
	Data = ["test333"],
	Key = "id",
	Value = 1,
	db:update(Table_name, Field, Data, Key, Value),
	
	Field_Value_List = [{row,"test333"}],
	Where_List = [{id,2}],
	db:update(Table_name, Field_Value_List, Where_List).

	%db:update(test, [{r,3,add}], [{id,2}]),
	%db:update(test, [{r,2,sub}], [{id,2}]).

test_select_one() ->
	Table_name = test, 
	Fields_sql = "row", 
	Where_List = [{row,"test333"}], 
	Order_List = [{r,desc}], 
	Limit_num = [1],
	io:format("select_one 1: ~p~n", [db:select_one(Table_name, Fields_sql, Where_List, Order_List, Limit_num)]),

	Where_List1 = [{id,1}],
	io:format("select_one 2: ~p~n", [db:select_one(Table_name, Fields_sql, Where_List1)]),

	Where_List2 = [{id, "<>", 1}],
	io:format("select_one 3: ~p~n", [db:select_one(Table_name, Fields_sql, Where_List2)]).
	    	

test_select_row() ->
	Table_name = test, 
	Fields_sql = "*", 
	Where_List = [{row,"test333"}], 
	Order_List = [{r,desc}],
	Limit_num = [1],
	io:format("select_row 1: ~p~n", [db:select_row(Table_name, Fields_sql, Where_List, Order_List, Limit_num)]),

	io:format("select_row 2: ~p~n", [db:select_row(test, "id,row", [{row,"test333"}], [{r,desc}], [1])]),
	
	Where_List1 = [{id,1}],
	io:format("select_row 3: ~p~n", [db:select_row(Table_name, Fields_sql, Where_List1)]),

	io:format("select_row 4: ~p~n", [db:select_row(test, "row,r", [{id,1}])]),
	
	io:format("select_row 5: ~p~n", [db:select_row(test, "max(id)", [])]).


%% 获取记录个数 
test_select_count() ->
	Table_name = test,
	Where_List = [{row,"test333"}],
	io:format("select_count: ~p~n", [db:select_count(Table_name, Where_List)]).


%% 获取所有数据
test_select_all() ->
	Table_name = test, 
	Fields_sql = "*", 
	Where_List = [{row,"test333"}], 
	Order_List = [{r,desc}],
	Limit_num = [],
	io:format("select_all 1: ~p~n", [db:select_all(Table_name, Fields_sql, Where_List, Order_List, Limit_num)]),

	Fields_sql1 = "row,r",
	Where_List1 = [{r,2}],
	io:format("select_all 2: ~p~n", [db:select_all(Table_name, Fields_sql1, Where_List1)]),

	io:format("select_all 3: ~p~n", [db:select_all(test, "row,r", [])]),

	io:format("select_all 4: ~p~n", [db:select_all(test, "`row`,`r`", [])]),

	io:format("select_all 5: ~p~n", [db:select_all(test, "*", [{row," like ","%est%"}])]).


%% 删除数据
test_delete() ->
	Table_name = test,
	Where_List = [{id,1}],
	db:delete(Table_name, Where_List).

%%
%% Local Functions
%%

