%% =============================================
%% @Module     : mod_world_lv.erl
%% @Author     : lidasheng
%% @Mail       : lidasheng17@gmail.com
%% @CreateDate : 2014-12-02
%% @Encoding   : UTF-8
%% @Desc       : 世界等级功能
%% =============================================

-module(mod_world_lv). 
-behaviour(gen_server).

-include("record.hrl").
-include("common.hrl").
-include("ets_name.hrl").
-include("global_sys_var.hrl").
-include("world_lv.hrl").

-export([
    open_world_lv/1
    ,add_exp/2
    ,login_init/1
    ,world_lv_init/0
    ,notify_refresh_daily/0
    ,start_link/0
    ,add_sys_slot_exp/1
    ,get_cur_world_lv/0
    ,get_open_world_lv_time/0
    ,get_next_lv_time/2
    ,cal_par_exp/2
    ]).


-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
         
-record(state, {}).

%% ====================================================================
%% External functions 
%% ====================================================================

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).


%% ====================================================================
%% Behavioural functions 
%% ====================================================================

%% init/1
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:init-1">gen_server:init/1</a>
-spec init(Args :: term()) -> Result when
    Result :: {ok, State}
            | {ok, State, Timeout}
            | {ok, State, hibernate}
            | {stop, Reason :: term()}
            | ignore,
    State :: term(),
    Timeout :: non_neg_integer() | infinity.
%% ====================================================================
init([]) -> 
    process_flag('trap_exit', true),
    world_lv_init(),
    {ok, #state{}}.
    

%% handle_call/3
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:handle_call-3">gen_server:handle_call/3</a>
-spec handle_call(Msg :: term(), From :: {pid(), Tag :: term()}, State :: term()) -> Result when
    Result :: {reply, Reply, NewState}
            | {reply, Reply, NewState, Timeout}
            | {reply, Reply, NewState, hibernate}
            | {noreply, NewState}
            | {noreply, NewState, Timeout}
            | {noreply, NewState, hibernate}
            | {stop, Reason, Reply, NewState}
            | {stop, Reason, NewState},
    Reply :: term(),
    NewState :: term(),
    Timeout :: non_neg_integer() | infinity,
    Reason :: term().
%% ====================================================================
handle_call(Msg, From, State) ->
    try
        do_call(Msg, From, State)
    catch
        Err:Reason ->
            ?ERROR_MSG("[~p] do_call error! Msg = ~p, From = ~p, Err = ~p, Reason = ~p~n", [?MODULE, Msg, From, Err, Reason]),
            {reply, error, State}
    end.


%% handle_cast/2
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:handle_cast-2">gen_server:handle_cast/2</a>
-spec handle_cast(Msg :: term(), State :: term()) -> Result when
    Result :: {noreply, NewState}
            | {noreply, NewState, Timeout}
            | {noreply, NewState, hibernate}
            | {stop, Reason :: term(), NewState},
    NewState :: term(),
    Timeout :: non_neg_integer() | infinity.
%% ====================================================================
handle_cast(Msg, State) ->
    try
        do_cast(Msg, State)
    catch
        Err:Reason ->
            ?ERROR_MSG("[~p] do_cast error! Msg = ~p, Err = ~p, Reason = ~p~n", [?MODULE, Msg, Err, Reason]),
            {noreply, State}
    end.    


%% handle_info/2
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:handle_info-2">gen_server:handle_info/2</a>
-spec handle_info(Msg :: timeout | term(), State :: term()) -> Result when
    Result :: {noreply, NewState}
            | {noreply, NewState, Timeout}
            | {noreply, NewState, hibernate}
            | {stop, Reason :: term(), NewState},
    NewState :: term(),
    Timeout :: non_neg_integer() | infinity.
%% ====================================================================
handle_info(Msg, State) ->
    try
        do_info(Msg, State)
    catch
        Err:Reason ->
            ?ERROR_MSG("[~p] do_info error! Msg = ~p, Err = ~p, Reason = ~p~n", [?MODULE, Msg, Err, Reason]),
            {noreply, State}
    end. 


%% terminate/2
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:terminate-2">gen_server:terminate/2</a>
-spec terminate(Reason, State :: term()) -> Any :: term() when
    Reason :: normal
            | shutdown
            | {shutdown, term()}
            | term().
%% ====================================================================
terminate(_Reason, _State) ->
    ok.


%% code_change/3
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:code_change-3">gen_server:code_change/3</a>
-spec code_change(OldVsn, State :: term(), Extra :: term()) -> Result when
    Result :: {ok, NewState :: term()} | {error, Reason :: term()},
    OldVsn :: Vsn | {down, Vsn},
    Vsn :: term().
%% ====================================================================
code_change(_OldVsn, State, _Extra) ->
    {ok, State}.


%% ====================================================================
%% Internal functions
%% ====================================================================


do_call(_Msg, _From, State) ->
    throw({nomatch, do_call, _Msg}),
    {reply, error, State}.


do_cast('daily_set_world_lv', State) ->
    set_world_lv(),
    lists:foreach(
        fun(Pid) -> gen_server:cast(Pid, 'add_sys_slot_exp') end, 
        mod_svr_mgr:get_all_online_player_pids()),
    {noreply, State};

do_cast(_Msg, State) -> 
    throw({nomatch, do_cast, _Msg}),
    {noreply, State}.


do_info(_Msg, State) ->
    throw({nomatch, do_info, _Msg}),
    {noreply, State}.



%% =============================================
%% API FUNCTION
%% =============================================

%% @doc 每天凌晨通知
notify_refresh_daily() ->
    gen_server:cast(?MODULE, 'daily_set_world_lv').


%% @doc 开启世界等级功能
%% @return : boolean()
open_world_lv(Timestamp) ->
    case util:unixtime() > Timestamp of
        true ->
            {_, Time} = util:get_datetime_by_timestamp(Timestamp),
            MidSec = calendar:time_to_seconds(Time),
            case mod_svr_mgr:set_global_sys_var(#global_sys_var{sys = ?WORLD_LV, var = (Timestamp - MidSec)}) of
                true -> set_world_lv();
                false -> false
            end;
        false -> false
    end.


%% @doc 取得开启世界等级时间
%% @return : null | Timestamp::integer()
get_open_world_lv_time() ->
    case mod_svr_mgr:get_global_sys_var(?WORLD_LV) of
        Int when is_integer(Int) andalso Int > 0 -> Int;
        _ -> null
    end.


%% @doc 取得当前世界等级
%% @return : null | Lv::integer()
get_cur_world_lv() ->
    case mod_svr_mgr:get_global_sys_var(?WORLD_LV_CUR_LV) of 
        Int when is_integer(Int) andalso Int >= 0 -> Int;
        _ -> null
    end.

%% @doc 取得当前世界生效等级
%% @return : null | Lv::integer()
get_effect_world_lv() ->
    case mod_svr_mgr:get_global_sys_var(?WORLD_LV_EFFECT_LV) of 
        Int when is_integer(Int) andalso Int >= 0 -> Int;
        _ -> null
    end.


%% !!! 必须在玩家进程执行  涉及PS数据操作
%% @return : {RoleExp::integer(), SlotExp::integer(), NewPS::#player_status()}
add_exp(Status, Exp) when is_integer(Exp) andalso Exp > 0 ->
    RoleLv = player:get_lv(Status),
    case get_cur_world_lv() of
        null -> {Exp, 0, Status};
        WorldLv -> 
            case RoleLv >= WorldLv of
                true -> 
                    {DelExp, NewStatus} = cal_del_extra_exp(Status, Exp, (RoleLv - WorldLv)),
                    {?BIN_PRED(Exp > DelExp, Exp - DelExp, 0), DelExp, NewStatus};
                false ->
                    {AddExp, NewStatus} = cal_add_extra_exp(Status, Exp),
                    {Exp + AddExp, AddExp, NewStatus}
            end
    end;
add_exp(Status, Exp) -> 
    {Exp, 0, Status}.



% @return : SlotExp::integer()
cal_par_exp(Status, Val) ->
    {RoleExp, SlotExp, _} = add_exp(Status, Val),
    case RoleExp > Val of
        true -> ?BIN_PRED(SlotExp > 0, SlotExp, 0);
        false -> 0
    end.


%% @doc 玩家登陆初始化
login_init(Status) -> 
    gen_server:cast(player:get_pid(Status), 'add_sys_slot_exp').


%% @doc 开服初始化
world_lv_init() -> 
    case db:select_all(global_sys_var, "var", [{sys, ?WORLD_LV}]) of
        [[Var1] | _] -> 
            ?LDS_DEBUG(1, Var1),
            T1 = tool:to_integer(util:bitstring_to_term(Var1)), 
            mod_svr_mgr:set_global_sys_var_cache(#global_sys_var{sys = ?WORLD_LV, var = T1});
        _ -> skip
    end,
    case db:select_all(global_sys_var, "var", [{sys, ?WORLD_LV_CUR_LV}]) of
        [[Var2] | _] -> 
            T2 = tool:to_integer(util:bitstring_to_term(Var2)), 
            mod_svr_mgr:set_global_sys_var_cache(#global_sys_var{sys = ?WORLD_LV_CUR_LV, var = T2});
        _ -> skip
    end,
    case db:select_all(global_sys_var, "var", [{sys, ?WORLD_LV_EFFECT_LV}]) of
        [[Var3] | _] -> 
            T3 = tool:to_integer(util:bitstring_to_term(Var3)), 
            mod_svr_mgr:set_global_sys_var_cache(#global_sys_var{sys = ?WORLD_LV_EFFECT_LV, var = T3});
        _ -> skip
    end,
    set_world_lv().




%% @return : integer()
get_next_lv_time(Stamp, 0) ->
    [NxtLv | _] = data_world_lv:get_lv_list(),
    Day = data_world_lv:get_open_day_by_lv(NxtLv),
    {_, Time} = util:get_datetime_by_timestamp(Stamp),
    MidSec = calendar:time_to_seconds(Time),
    Stamp + 86400 * Day - MidSec;
get_next_lv_time(Stamp, CurLv) ->
    case get_next_world_lv(CurLv) of
        null -> 0;
        NxtLv ->
            Day = data_world_lv:get_open_day_by_lv(NxtLv),
            {_, Time} = util:get_datetime_by_timestamp(Stamp),
            MidSec = calendar:time_to_seconds(Time),
            Stamp + 86400 * Day - MidSec
    end.




%% =============================================
%% INTERVAL FUNCTION
%% =============================================

%% @return : {Extra_extra_exp::integer(), NewPS::#player_status()}
cal_add_extra_exp(Status, Exp) ->
    Coef = get_buff_coef(),
    AddExpTmp = util:floor(Exp * Coef),
    AddExp = ?BIN_PRED(AddExpTmp > 0, AddExpTmp, 0),
    {Lv, SlotExp} = Status#player_status.exp_slot,
    case SlotExp > AddExp of
        true -> {AddExp, Status#player_status{exp_slot = {Lv, SlotExp - AddExp}}};
        false -> {SlotExp, Status#player_status{exp_slot = {Lv, 0}}}
    end.


%% @return : {Extra_extra_exp::integer(), NewPS::#player_status()}
cal_del_extra_exp(Status, Exp, DifLv) ->
    DebuffCoef = get_debuff_coef(DifLv),
    SoltExpTmp = util:floor(Exp * (1 - DebuffCoef)),
    SoltExp = ?BIN_PRED(SoltExpTmp > 0, SoltExpTmp, 0),
    ?LDS_TRACE(cal_del_extra_exp, {DebuffCoef, SoltExp}),
    {Lv, OriExp} = Status#player_status.exp_slot,
    ?ylh_Debug("cal_del_extra_exp Lv=~p, OriExp=~p, SoltExp=~p ~n", [Lv, OriExp, SoltExp]),
    {SoltExp, Status#player_status{exp_slot = {Lv, OriExp + SoltExp}}}.
    

%% @return : NewPS::#player_status()
add_sys_slot_exp(Status) ->
    case get_effect_world_lv() of
        null -> Status;
        WorldLv ->
            {Lv, Exp} = Status#player_status.exp_slot,
            case Lv < WorldLv of
                true ->
                    LvList = get_effect_lv_list(),
                    List = get_gap_list_from_list(Lv, WorldLv, LvList),
                    F = fun(Elm, Sum) -> Sum + get_exp_by_lv(Elm) end,
                    SumExp = lists:foldl(F, 0, List),
                    Status#player_status{exp_slot = {WorldLv, Exp + SumExp}};
                false -> Status
            end
    end.



%% @doc 设置世界等级 以及生效等级
%% @return : boolean()
set_world_lv() ->
    case get_open_world_lv_time() of
        Timestamp when is_integer(Timestamp) ->
            Now = util:unixtime(),
            Day = ((Now - Timestamp) div 86400) + 1,
            set_cur_world_lv(Day),
            set_effect_world_lv(Day),
            true;
        _ -> false
    end.

set_cur_world_lv(Day) ->
    DayList = data_world_lv:get_open_day_list(),
    case get_gap_from_list(Day, DayList) of
        CfgDay when is_integer(CfgDay) ->
            NewLv = data_world_lv:get_lv_by_open_day(CfgDay),
            CurLv = mod_svr_mgr:get_global_sys_var(?WORLD_LV_CUR_LV),
            ?BIN_PRED(NewLv =:= CurLv, skip, 
                mod_svr_mgr:set_global_sys_var(#global_sys_var{sys = ?WORLD_LV_CUR_LV, var = NewLv}));
        _ -> skip
    end.

set_effect_world_lv(Day) ->
    DayList = data_world_lv:get_effect_day_list(),
    case get_gap_from_list(Day, DayList) of
        CfgDay when is_integer(CfgDay) ->
            NewLv = data_world_lv:get_lv_by_effect_day(CfgDay),
            CurLv = mod_svr_mgr:get_global_sys_var(?WORLD_LV_EFFECT_LV),
            ?BIN_PRED(NewLv =:= CurLv, skip, 
                mod_svr_mgr:set_global_sys_var(#global_sys_var{sys = ?WORLD_LV_EFFECT_LV, var = NewLv}));
        _ -> skip
    end.


%% @return : null | term()
get_gap_from_list(_, []) -> null;
get_gap_from_list(_, [Elm]) -> Elm;
get_gap_from_list(Elm, [Elm1, Elm2 | Left]) ->
    case Elm < Elm1 of
        true -> null;
        false ->
            case Elm >= Elm1 andalso Elm < Elm2 of
                true -> Elm1;
                false -> get_gap_from_list(Elm, [Elm2 | Left])
            end
    end.

%% @return : list()
get_gap_list_from_list(_, _, []) -> [];
get_gap_list_from_list(Pre, Nxt, [Elm | Left]) ->
    case Pre < Elm andalso Nxt >= Elm of
        true -> [Elm | get_gap_list_from_list(Pre, Nxt, Left)];
        false -> []
    end.



get_buff_coef() -> 
    data_world_lv:get_buff_coef().


%% @return : integer()
get_debuff_coef(DifLv) ->
    List = data_world_lv:get_dif_lv_list(),
    Lv = get_gap_from_list(DifLv, List),
    case data_world_lv:get_debuff_coef(Lv) of
        null ->
            ?ERROR_MSG("[world_lv] get_debuff_coef DifLv = ~p, data = ~p~n", [DifLv, null]),
            0;
        Int -> Int
    end.


get_exp_by_lv(Elm) ->
    data_world_lv:get_lv_exp(Elm).


get_effect_lv_list() ->
    data_world_lv:get_lv_list().



% @return : null | integer()
get_next_world_lv(WorldLv) ->
    get_next_world_lv(WorldLv, data_world_lv:get_lv_list()).

get_next_world_lv(_, []) -> null;
get_next_world_lv(WorldLv, [Lv]) ->
    ?BIN_PRED(WorldLv < Lv, Lv, null);
get_next_world_lv(WorldLv, [Lv1, Lv2 | Left]) ->
    case WorldLv >= Lv1 andalso WorldLv < Lv2 of
        true -> Lv2;
        false -> get_next_world_lv(WorldLv, [Lv2 | Left])
    end.