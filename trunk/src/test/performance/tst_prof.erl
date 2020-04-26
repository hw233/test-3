%%%---------------------------------------------
%%% @Module  : prof
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2011.05.03
%%% @Description: 性能测试工具
%%%---------------------------------------------
-module(tst_prof).
-compile(export_all).

%%性能测试
%%Fun:函数
%%Loop:执行次数
run(Fun, Loop) -> 
    statistics(wall_clock),
    for(1, Loop, Fun),
    {_, T1} = statistics(wall_clock),
    io:format("~p loops, using time: ~pms~n", [Loop, T1]),
    ok.

for(Max, Max , Fun) ->
    Fun();
for(I, Max, Fun) -> 
    Fun(), for(I + 1, Max, Fun).

run_index(Fun, Loop) ->
    statistics(wall_clock),
    for2(1, Loop, Fun),
    {_, T1} = statistics(wall_clock),
    io:format("~p loops, using time: ~pms~n", [Loop, T1]),
    ok.

for2(Max, Max , Fun) ->
    Fun(Max);
for2(I, Max, Fun) -> 
    Fun(I), for2(I + 1, Max, Fun).

run_arg(Fun, Loop, Arg) ->
    statistics(wall_clock),
    for3(1, Loop, Fun, Arg),
    {_, T1} = statistics(wall_clock),
    io:format("~p loops, using time: ~pms~n", [Loop, T1]),
    ok.

for3(Max, Max , Fun, Arg) ->
    Fun(Arg);
for3(I, Max, Fun, Arg) -> 
    Fun(Arg), for3(I + 1, Max, Fun, Arg).
    
run_index_arg(Fun, Loop, Arg) ->
    statistics(wall_clock),
    for4(1, Loop, Fun, Arg),
    {_, T1} = statistics(wall_clock),
    io:format("~p loops, using time: ~pms~n", [Loop, T1]),
    ok.

for4(Max, Max , Fun, Arg) ->
    Fun(Max, Arg);
for4(I, Max, Fun, Arg) -> 
    Fun(I, Arg), for4(I + 1, Max, Fun, Arg).
