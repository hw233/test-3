%%%--------------------------------------
%%% @Module:
%%% @Author: liuzhongzheng2012@gmail.com
%%% @Created: 2014-05-08
%%% @Description: 奖励池
%%%--------------------------------------

-module(mod_reward_pool).
-behavour(gen_server).
-export([init/1, handle_cast/2, handle_call/3, handle_info/2, terminate/2, code_change/3]).
-export([start/0, start_link/0, stop/0]).


-export([
        reward/3,
        query_pool/0,
        set_pool_stock/2,
        calc_reward/2,
        save_to_db/0,
        tst_reset_pool/1
        ]).

-include("common.hrl").
-include("record.hrl").
-include("reward.hrl").
-include("ets_name.hrl").
-include("sys_code.hrl").

-record(state, {}).
-record(now, {date, time, week, day}).

-define(PERIOD_HOURLY, 1).
-define(PERIOD_DAILY, 2).
-define(PERIOD_WEEKLY, 3).
-define(PERIOD_MONTHLY, 4).
-define(PERIOD_CYCLE, 5). %% 周期更新时：[15]其中15表示每15分钟更新


tst_reset_pool(No) ->
    RewardPool = new_reward_pool(No),
    ets:insert(?ETS_REWARD_POOL, RewardPool).


% 返回#reward_dtl结构
calc_reward(No, PS) ->
    case data_reward_pool:get(No) =:= null of
        true -> 
            ?WARNING_MSG("mod_reward_pool:calc_reward error!~p~n", [No]),
            #reward_dtl{};
        false ->
            #data_reward_pool{prob=Prob, reward_bag=Pkg} = data_reward_pool:get(No),
            case util:rand() of
                P when P =< Prob ->
                    case ets:update_counter(?ETS_REWARD_POOL, No, -1) of
                        Stock when Stock >= 0 ->
                            calc_pool_reward(No, PS);
                        _ ->
                            calc_default_reward(Pkg, PS)
                    end;
                _ ->
                    calc_default_reward(Pkg, PS)
            end
    end.

% 
calc_pool_reward(No, _PS) ->
    [#reward_pool{gid=GID,
                  bind_state=Bind,
                  quality=Quality,data_reward_goods_id=GPID}] = ets:lookup(?ETS_REWARD_POOL, No),


    ?DEBUG_MSG("GPID=~p",[GPID]),
    
    #data_reward_goods{good_no=GoodsNo,
       quality=Quality,
       bind_state=Bind,
       limit=_Limit,
       need_broadcast = NeedBroadcast
       } = data_reward_goods:get(GPID),

    ?DEBUG_MSG("NeedBroadcast~p",[NeedBroadcast]),
    #reward_dtl{calc_goods_list=[{GoodsNo, 1, Quality, Bind,NeedBroadcast}]}.

calc_default_reward(Pkg, PS) ->
    case Pkg =< 0 of
        true -> #reward_dtl{};
        false -> lib_reward:calc_reward_to_player(PS, Pkg)
    end.

% 返回#reward_dtl结构
reward(No, PS, Reason) ->
    #data_reward_pool{prob=Prob, reward_bag=Pkg} = data_reward_pool:get(No),
    case util:rand() of
        P when P =< Prob ->
            case ets:update_counter(?ETS_REWARD_POOL, No, -1) of
                Stock when Stock >= 0 ->
                    pool_reward(No, PS, Reason);
                _ ->
                    default_reward(Pkg, PS, Reason)
            end;
        _ ->
            default_reward(Pkg, PS, Reason)
    end.

pool_reward(No, PS, Reason) ->
    [#reward_pool{gid=GID,
                  bind_state=Bind,
                  quality=Quality}] = ets:lookup(?ETS_REWARD_POOL, No),
    UID = player:get_id(PS),
    {ok, List} = mod_inv:batch_smart_add_new_goods(UID,
                                      [{GID, 1}],
                                      [{quality, Quality}, {bind_state, Bind}],
                                      Reason),
    #reward_dtl{goods_list=List}.

default_reward(Pkg, PS, Reason) ->
    lib_reward:give_reward_to_player(PS, Pkg, Reason).

%% 后台查询接口
query_pool() ->
    F = fun(#reward_pool{no=No,
                         stock=Stock,
                         gid=Gid,
                         period=Period,
                         next=Next,
                         data_reward_goods_id=GPID}, Acc) ->
            #data_reward_pool{prob=Prob} = data_reward_pool:get(No),
            #data_reward_goods{limit=Total} = data_reward_goods:get(GPID),
            S = lists:flatten(io_lib:format("{\"no\":~p,\"stock\":~p,\"gid\":~p,\"period\":~p,\"next\":\"~p\",\"prob\":~p,\"total\":~p}",
                                        [No, Stock, Gid, Period, Next, Prob, Total])),
            [S|Acc]
        end,
    Strs = ets:foldl(F, [], ?ETS_REWARD_POOL),
    "[" ++ string:join(Strs, ",") ++ "]".

%% 后台设置接口
set_pool_stock(No, Stock) ->
    ets:update_element(?ETS_REWARD_POOL, No, {#reward_pool.stock, Stock}).


save_to_db() ->
    gen_server:call(?MODULE, save_to_db).

start() ->
    case erlang:whereis(?MODULE) of
        undefined ->
            case supervisor:start_child(
               sm_sup,
               {?MODULE,
                {?MODULE, start_link, []},
                 permanent, 10000, worker, [?MODULE]}) of
            {ok, Pid} ->
                Pid;
            {error, R} ->
                ?WARNING_MSG("start error:~p~n", [R]),
                undefined
            end;
        Pid ->
            Pid
    end.

stop() ->
    gen_server:call(?MODULE, save_to_db),
    supervisor:terminate_child(sm_sup, ?MODULE).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).


init([]) ->
    mod_timer:reg_loop_msg(self(), 60000),
    do_init(),
    {ok, #state{}}.


handle_call(Request, From, State) ->
    try
        do_call(Request, From, State)
    catch
        Err:Reason->
            ?ERROR_MSG("ERR:~p,Reason:~p, Request:~p",[Err,Reason, Request]),
             {reply, error, State}
    end.


handle_cast(Request, State) ->
    try
        do_cast(Request, State)
    catch
        Err:Reason->
            ?ERROR_MSG("ERR:~p,Reason:~p, Request:~p",[Err,Reason, Request]),
             {noreply, State}
    end.



handle_info(Request, State) ->
    try
        do_info(Request, State)
    catch
        Err:Reason->
            ?ERROR_MSG("ERR:~p,Reason:~p, Request:~p",[Err,Reason, Request]),
             {noreply, State}
    end.



code_change(_OldVsn, State, _Extra) ->
    {ok, State}.


terminate(_Reason, _State) ->
    ok.

do_call(save_to_db, _From, State) ->
    db_save(),
    {reply, ok, State};
do_call(_Msg, _From, State) ->
    ?WARNING_MSG("unhandle call ~w", [_Msg]),
    {reply, error, State}.


do_cast(_Msg, State) ->
    ?WARNING_MSG("unhandle cast ~p", [_Msg]),
    {noreply, State}.



%% 每分钟检测一遍
do_info(doloop, State) ->
    loop_check(),
    {noreply, State};
do_info(_Msg, State) ->
    ?WARNING_MSG("unhandle info ~w", [_Msg]),
    {noreply, State}.

do_init() ->
    db_load(),
    Nos = data_reward_pool:get_ids(),
    lists:foreach(fun init_item/1, Nos).

init_item(No) ->
    case ets:lookup(?ETS_REWARD_POOL, No) of
        [#reward_pool{}] ->
            skip;
        _ ->
            RewardPool = new_reward_pool(No),
            ets:insert(?ETS_REWARD_POOL, RewardPool)
    end.

new_reward_pool(No) ->
    #data_reward_pool{goods_pools=GPs,
                      period=Period,
                      renews=Refs} = data_reward_pool:get(No),
                      
    Next = list_rand(Refs),
    GPID = weight_list_rand(GPs),

    % ?DEBUG_MSG("GPID=~p,GPs=~p",[GPID,GPs]),
    #data_reward_goods{good_no=GID,
                       quality=Quality,
                       bind_state=Bind,
                       limit=Limit
                       % ,need_broadcast = NeedBroadcast
                       } = data_reward_goods:get(GPID),

    RewardPool = #reward_pool{no=No,
                              stock=Limit,
                              gid=GID,
                              quality=Quality,
                              bind_state=Bind,
                              period=Period,
                              data_reward_goods_id=GPID,
                              next=Next
                              },
    RewardPool.

loop_check() ->
    Now = build_now(),
    ets:foldl(fun loop_check/2, Now, ?ETS_REWARD_POOL),
    db_save().

build_now() ->
    Date = date(),
    Time = time(),
    Week = calendar:iso_week_number(),
    Day = calendar:day_of_the_week(Date),
    Now = #now{date=Date, time=Time, week=Week, day=Day},
    Now.

loop_check(#reward_pool{charged=Charged, period=Period}=RewardPool, Now) ->
    case charged_time(Period, Now) of
        Charged ->
            skip;
        _ ->
            case is_should_charge(RewardPool, Now) of
                ?true ->
                    charge(RewardPool, Now);
                _ ->
                    skip
            end
    end,
    Now.

charge(#reward_pool{no=No, period=Period}, Now) ->
    Charged = charged_time(Period, Now),
    RewardPool = new_reward_pool(No),
    RewardPool1 = RewardPool#reward_pool{charged=Charged},
    ets:insert(?ETS_REWARD_POOL, RewardPool1).


is_should_charge(#reward_pool{period=?PERIOD_HOURLY, next=MM},
             #now{time={_HH, MM, _}}) ->
    ?true;
is_should_charge(#reward_pool{period=?PERIOD_DAILY, next={HH, MM}},
             #now{time={HH, MM, _}}) ->
    ?true;
is_should_charge(#reward_pool{period=?PERIOD_WEEKLY, next={Day, HH, MM}},
             #now{day=Day, time={HH, MM, _}}) ->
    ?true;
is_should_charge(#reward_pool{period=?PERIOD_MONTHLY, next={D, HH, MM}},
             #now{date={_Y, _M, D}, time={HH, MM, _}}) ->
    ?true;
is_should_charge(#reward_pool{period=?PERIOD_CYCLE, next=M, no = _No},
             #now{time={_HH, MM, _}}) ->
    case MM rem M of
        0 ->
            ?DEBUG_MSG("mod_reward_pool:is_should_charge poolNo:~p, period:~p~n", [_No, M]), 
            ?true;
        _ -> ?false
    end;
is_should_charge(_, _) ->
    ?false.


charged_time(?PERIOD_HOURLY, #now{date={Y,M,D}, time={HH, _, _}}) ->
    {Y, M, D, HH};
charged_time(?PERIOD_DAILY, #now{date=Date}) ->
    Date;
charged_time(?PERIOD_WEEKLY, #now{week=Week}) ->
    Week;
charged_time(?PERIOD_MONTHLY, #now{date={Y,M,_}}) ->
    {Y, M};
charged_time(?PERIOD_CYCLE, #now{time={_HH, MM, _}}) ->
    MM.

db_save() ->
    All = ets_to_list(),
    mod_data:save(?SYS_REWARD_POOL, All).

db_load() ->
    case mod_data:load(?SYS_REWARD_POOL) of
        [] ->
            ok;
        [All] ->
            ets:insert(?ETS_REWARD_POOL, All)
    end.

ets_to_list() ->
    ets:foldl(fun(I, A) -> [I|A] end, [], ?ETS_REWARD_POOL).

list_rand(List) ->
    case length(List) of
        0 -> 0;
        _ ->
            N = util:rand(1, length(List)),
            lists:nth(N, List)
    end.

% 这个代码用几率
% weight_list_rand([{ID, _}]) -> ID;
% weight_list_rand(List) ->
%     Sum = lists:foldl(fun({_, W}, A) -> A+W end, 0, List),
%     P = util:rand() * Sum,
%     weight_list_rand(List, P).

% weight_list_rand([{ID, Prob}|_], P) when P =< Prob -> ID;
% weight_list_rand([{_, Prob}|T], P) -> weight_list_rand(T, P-Prob).

% 下面这个用权重
weight_list_rand(List) ->    
    Range = lists:foldl(fun({_, W}, A) -> A+W end, 0, List),
    RandNum = util:rand(1, Range),

    weight_list_rand(List,RandNum).


% 获取随机特效信息
weight_list_rand(List, RandNum) ->
    weight_list_rand(List, RandNum, 0).

weight_list_rand([H | T], RandNum, SumToCompare) ->
    {ID, Widget} = H,
    SumToCompare_2 = Widget + SumToCompare,

    case RandNum =< SumToCompare_2 of
        true -> 
            ID;
        false ->
            weight_list_rand(T, RandNum, SumToCompare_2)
    end;

weight_list_rand([], _RandNum, _SumToCompare) ->
    0.
