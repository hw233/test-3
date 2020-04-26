%% Author: Skyman Wu
%% Created: 2012-5-29
%% Description: 测试db模块
-module(tst_db_compress_test).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([start_test/1, start_random_test/2]).


%测试步骤： 开启服务器，然后不要连接任务客户端
%           连接Mysql清除表: task_bag:    delete from task_bag;
%           在Server运行:  db_compress_test:start_test().
%           根据最后输出查看数据库是否匹配
start_test(Id) -> 
    io:format("~n--------------Test1--------------~n"),
    add_task(Id, 1),
    update_task(Id,1),
    delete_task(Id,1),
    logout(Id),
    show_db(Id),

    io:format("~n--------------Test2--------------~n"),
    add_task(Id, 1),
    F11 = fun( _TT) -> update_task(Id,1) end,
    for(1,100, F11, 0),
    logout(Id),
    show_db(Id),

    io:format("~n--------------Test3--------------~n"),
    add_task(Id, 2),
    update_task(Id,2),
    update_task(Id,2),
    delete_task(Id,2),
    delete_task(Id,1),
    F22 = fun(_TT) ->
    add_task(Id, 1),
    update_task(Id,1),
    update_task(Id,1),
    delete_task(Id,1)
    end,
    for(1,20, F22, 0),
    logout(Id),
    show_db(Id),

    %复杂情况
    io:format("~n--------------Test4--------------~n"),
    add_task(Id, 3),
    add_task(Id, 2),
    update_task(Id,3),
    logout(Id),
    delete_task(Id,3),
    delete_task(Id,2),
    add_task(Id, 1),
    add_task(Id, 3),
    add_task(Id, 2),
    update_task(Id,3),
    update_task(Id,2),
    update_task(Id,1),
    update_task(Id,3),
    update_task(Id,2),
    delete_task(Id,2),
    delete_task(Id,3),
    delete_task(Id,1),
    add_task(Id, 4),
    add_task(Id, 5),
    add_task(Id, 6),
    update_task(Id,3),
    delete_task(Id,5),
    update_task(Id,2),
    update_task(Id,1),
    add_task(Id, 5),
    update_task(Id,3),
    update_task(Id,2),
    delete_task(Id,5),
    delete_task(Id,4),
    delete_task(Id,6),
    logout(Id),
    show_db(Id).

%测试步骤： 开启服务器，然后不要连接任务客户端
%           连接Mysql清除表: task_bag:    delete from task_bag;
%           在Server运行:  db_compress_test:start_random_test(Id, Num).
%           根据最后输出查看数据库是否匹配
%           Id 为玩家ID，任意。 Num为随机操作次数。
start_random_test(Id, Num) ->
    io:format("~n--------------Random DB Compress Test--------------~n"),
    TidList = lists:seq(1,5),
    F33 = fun(_X, {RemainList, AddedList, DeleteList}) ->
            Ops = random:uniform(4),
            case Ops of 
                %%new_insert
                1 ->  Length = length(RemainList),
                     if Length >= 1 -> 
                              Index = random:uniform(Length),
                              Tid = lists:nth(Index, RemainList),
                              add_task(Id, Tid),
                              {RemainList -- [Tid], AddedList ++ [Tid],  DeleteList};
                         true -> {RemainList, AddedList, DeleteList}
                      end;

                %%update
                2 ->  Length = length(AddedList),
                     if Length >= 1 ->
                         Index = random:uniform(Length),
                         Tid = lists:nth(Index, AddedList),
                         update_task(Id, Tid);
                      true -> skip
                      end,
                      {RemainList, AddedList, DeleteList};

                %%delete
                3 ->  Length = length(AddedList),
                      if Length >= 1 ->
                         Index = random:uniform(Length),
                         Tid = lists:nth(Index, AddedList),
                         delete_task(Id, Tid),
                         {RemainList, AddedList -- [Tid], DeleteList ++ [Tid]};
                      true -> {RemainList, AddedList, DeleteList}
                      end;

               %%re_insert
               4 ->   Length = length(DeleteList),
                      if Length >= 1 ->
                         Index = random:uniform(Length),
                         Tid = lists:nth(Index, DeleteList),
                         add_task(Id, Tid),
                         {RemainList, AddedList ++ [Tid], DeleteList -- [Tid]};
                      true -> {RemainList, AddedList, DeleteList}
                      end
            end
    end,

    RunTimes = lists:seq(1,Num),
    {NewRemainList, NewAddedList, NewDeleteList} = lists:foldr(F33, {TidList, [], []}, RunTimes),
    logout(Id),
    io:format("~n--------------Random DB Compress Check--------------~n"),
    io:format("Remain TaskId not used for Test, could be foun in below two line:  ~p~n", [NewRemainList]),
    io:format("Tasks Added to database, must be found in Database:  ~p~n", [NewAddedList]),
    io:format("Tasks Deleted, can not be found in database:  ~p~n", [NewDeleteList]),
    show_db(Id).

add_task(Id, Tid) ->
    io:format("add_task: Id =~p, TaskId = ~p~n", [Id, Tid]),
    {T1, T2, _} = erlang:now(),
    TriggerTime = T1 * 1000000 + T2,
    mod_task:add_trigger(Id, Tid, TriggerTime, 0, 0, 0, util:term_to_bitstring("testtask")).

update_task(Id, Tid) ->
    io:format("update_task: Id =~p, TaskId = ~p~n", [Id, Tid]),
    mod_task:upd_trigger(Id, Tid, 0, util:term_to_bitstring("updatetask")).

delete_task(Id, Tid) -> 
    io:format("delete_task: Id =~p, TaskId = ~p~n", [Id, Tid]),
    mod_task:del_trigger(Id, Tid).

%%logout
logout(Id) ->
    io:format("logout: Id =~p, write_back~n", [Id]),
    gen_server:cast(mod_task, {'write_back',Id}),
    sleep(10000).

show_db(Id) ->
    io:format("------------------Tasks From Database----------------~n", []),
    TaskList = db:select_all(task_bag, "*", [{role_id, Id}]),
    io:format("--------------------------------------~n", []),
    F = fun(X, _) -> io:format("Task: ~p~n", [X]) end,
    lists:foldr(F, [], TaskList),
    io:format("--------------------------------------~n", []).

for(Max, Max, _F, X) ->
    X;
for(Min, Max, F, X) ->
    F(X),
    for(Min+1, Max, F, X).

sleep(T) ->
    receive
    after T -> ok
    end.

