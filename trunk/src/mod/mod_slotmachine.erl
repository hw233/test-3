%%%-----------------------------------
%%% @Module  : slotmachine
%%% @Author  : 段世和
%%% @Email   : 
%%% @Created : 2015.10.27
%%% @Description: 老虎机
%%%-----------------------------------


-module(mod_slotmachine).

% include
-include("common.hrl").
-include("slotmachine.hrl").
% -include("goods.hrl").
% -include("record/goods_record.hrl").
-include("abbreviate.hrl").
-include("player.hrl").
-include("ets_name.hrl").
-include("log.hrl").
-include("sys_code_2.hrl").
-include("prompt_msg_code.hrl").
-include("num_limits.hrl").

-include("scene.hrl").

-compile(export_all).

% -export([init/1, handle_cast/2, handle_call/3, handle_info/2, terminate/2, code_change/3]).
% -export([start/0, start_link/0, stop/0]).

% -export([
%     buy1/2,
%     buy2/3
%     ]).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%购买1
buy1(PS,BuyInfo) ->
     case check_buy1(PS, BuyInfo) of
        {fail, Reason} ->
            {fail, Reason};
        ok ->
            do_buy1(PS, BuyInfo)
    end.

check_buy1(PS, BuyInfo) ->
    try check_buy1__(PS, BuyInfo) of
        ok ->
            ok
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

% 检测购买消耗
check_buy1__(PS,BuyInfo) ->    
    F = fun({_Class,Count},Acc) ->
        Acc + Count
    end,

    % 暂时用银子
    Price = lists:foldl(F,0,BuyInfo), 

    % 检测金额是否足够
    RetMoney = player:get_chip(PS),
    ?Ifc (RetMoney < Price)
        throw(?PM_CHIP_LIMIT)
    ?End,

    PlayerId = player:id(PS),

    % 获取玩家信息
    SP = get_slotmachine_player(PlayerId),
    Infos = SP#slotmachine_player.infos,

    case BuyInfo of [
    		{_Class1,_Count1},
        	{_Class2,_Count2},
        	{_Class3,_Count3},
        	{_Class4,_Count4},
        	{_Class5,_Count5},
        	{_Class6,_Count6},
        	{_Class7,_Count7},
        	{_Class8,_Count8}
        	] ->
        		ok;
        	_ -> throw(?PM_PARA_ERROR) 
    end,


    % 检测是否还没下注
    case Infos of
        [#slotmachine_player_info{class = 2,count = 0},
        		#slotmachine_player_info{class = 3,count = 0},
        		#slotmachine_player_info{class = 4,count = 0},
        		#slotmachine_player_info{class = 5,count = 0},
        		#slotmachine_player_info{class = 6,count = 0},
        		#slotmachine_player_info{class = 7,count = 0},
        		#slotmachine_player_info{class = 8,count = 0},
        		#slotmachine_player_info{class = 9,count = 0}] ->
            ok;
        _ ->
           throw(?PM_HAVEBETING1) 
    end.
%---------------------------------------------------------------------------------%
do_buy1(PS, BuyInfo) ->    
    % [AS1,AS2,AS3,AS4,AS5,AS6,AS7,AS8] = BuyInfo,
    F = fun({Class,Count},Acc) ->
        [#slotmachine_player_info{class = Class,count = Count}|Acc]
    end,

    Infos = lists:foldl(F,[],BuyInfo),

    F1 = fun({_Class,Count},Acc) ->
        Acc + Count
    end,

    % 暂时用银子
    Price = lists:foldl(F1,0,BuyInfo), 

    player:cost_chip(PS,Price,[?LOG_SLOTMACHINE, "buy1"]),

    set_slotmachine_player_infos(PS,Infos),    
    ok.

%---------------------------------------------------------------------------------%
buy2(PS,Change,Value) ->
    case check_buy2(PS, Change, Value) of
        {fail, Reason} ->
            {fail, Reason};
        ok ->
            do_buy2(PS, Change, Value)
    end.
check_buy2(PS, Change,Value) ->
    try check_buy2__(PS, Change,Value) of
        ok ->
            ok
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

% 检测购买消耗
check_buy2__(PS,_Change,Value) ->    
    % 暂时用银子
    % PriceType = ?MNY_T_GAMEMONEY,
    Price = Value, 

    % 检测金额是否足够
    RetMoney = player:get_chip(PS),
    ?Ifc (RetMoney < Price)
        throw(?PM_CHIP_LIMIT)
    ?End,

    PlayerId = player:id(PS),
    % 获取玩家信息
    SP = get_slotmachine_player(PlayerId),

    ?DEBUG_MSG("SP=~p",[SP]),
    Change = SP#slotmachine_player.change,

    % 检测是否还没下注购买大小
    case Change of
        0 ->
            ok;
        _ ->
           throw(?PM_HAVEBETING2) 
    end.
%---------------------------------------------------------------------------------%
do_buy2(PS, Change,Value) ->    
    Price = Value, 
    player:cost_chip(PS,Price,[?LOG_SLOTMACHINE, "buy1"]),

    set_slotmachine_player_change(PS,Change),
    set_slotmachine_player_value(PS,Value),
    ok.

%--------------------------------------------------------------------------------------------------------%
% 从ETS获取玩家的购买信息
set_slotmachine_player_infos(PS,Infos) ->
    SP = get_slotmachine_player(player:id(PS)),
    SP1 = SP#slotmachine_player{infos = Infos},
    update_slotmachine_player_to_ets(SP1).

set_slotmachine_player_change(PS,Change) ->
    SP = get_slotmachine_player(player:id(PS)),
    SP1 = SP#slotmachine_player{change = Change},
    update_slotmachine_player_to_ets(SP1).

set_slotmachine_player_value(PS,Value) ->
    SP = get_slotmachine_player(player:id(PS)),
    SP1 = SP#slotmachine_player{value = Value},
    update_slotmachine_player_to_ets(SP1).

get_slotmachine_player(PlayerId) ->
    ?ASSERT(is_integer(PlayerId), PlayerId),
    % ?DEBUG_MSG("get_slotmachine_player ~p,~p",[PlayerId,1]),
    Ret = case ets:lookup(?ETS_SLOTMACHINE_PLAYERS, PlayerId) of
        [#slotmachine_player{} = SP] -> SP;
        _ ->  % 玩家不存在或者下线了
        	Infos = [
        		#slotmachine_player_info{class = 2,count = 0},
        		#slotmachine_player_info{class = 3,count = 0},
        		#slotmachine_player_info{class = 4,count = 0},
        		#slotmachine_player_info{class = 5,count = 0},
        		#slotmachine_player_info{class = 6,count = 0},
        		#slotmachine_player_info{class = 7,count = 0},
        		#slotmachine_player_info{class = 8,count = 0},
        		#slotmachine_player_info{class = 9,count = 0}
        	],
            SP_New = #slotmachine_player{player_id=PlayerId,rounds=get_rounds(),infos = Infos},
            add_slotmachine_player_to_ets(SP_New),
            SP_New
    end,

    % ?DEBUG_MSG("get_slotmachine_player ~p,~p",[PlayerId,Ret]),
    Ret.

% 获取所有的玩家id
get_all_slotmachine_player_ids() ->
    L = ets:tab2list(?ETS_SLOTMACHINE_PLAYERS),
    [X#slotmachine_player.player_id || X <- L].

% 获取所有的玩家id
get_all_slotmachine_player() ->
    ets:tab2list(?ETS_SLOTMACHINE_PLAYERS).

% 获取所有玩家和气来的信息
get_slotmachine_server() ->
    List = get_all_slotmachine_player(),

    % A是当前玩家信息 B累计玩家信息
    F = fun(#slotmachine_player{} = A,#slotmachine_player{} = B) ->

        AInfos = A#slotmachine_player.infos,
        % 累计
        BInfos = B#slotmachine_player.infos,

        % ?DEBUG_MSG("AInfos=~p,BInfos=~p",[AInfos,BInfos]),

        F = fun(G1, G2) -> G1#slotmachine_player_info.class < G2#slotmachine_player_info.class end,

	    AInfos1 = lists:sort(F, AInfos),
	    BInfos1 = lists:sort(F, BInfos),

        [AS1,AS2,AS3,AS4,AS5,AS6,AS7,AS8] = AInfos1,
        [BS1,BS2,BS3,BS4,BS5,BS6,BS7,BS8] = BInfos1,

        #slotmachine_player{infos=[
        	#slotmachine_player_info{class = AS1#slotmachine_player_info.class,count = AS1#slotmachine_player_info.count + BS1#slotmachine_player_info.count},
        	#slotmachine_player_info{class = AS2#slotmachine_player_info.class,count = AS2#slotmachine_player_info.count + BS2#slotmachine_player_info.count},
        	#slotmachine_player_info{class = AS3#slotmachine_player_info.class,count = AS3#slotmachine_player_info.count + BS3#slotmachine_player_info.count},
        	#slotmachine_player_info{class = AS4#slotmachine_player_info.class,count = AS4#slotmachine_player_info.count + BS4#slotmachine_player_info.count},
        	#slotmachine_player_info{class = AS5#slotmachine_player_info.class,count = AS5#slotmachine_player_info.count + BS5#slotmachine_player_info.count},
        	#slotmachine_player_info{class = AS6#slotmachine_player_info.class,count = AS6#slotmachine_player_info.count + BS6#slotmachine_player_info.count},
        	#slotmachine_player_info{class = AS7#slotmachine_player_info.class,count = AS7#slotmachine_player_info.count + BS7#slotmachine_player_info.count},
        	#slotmachine_player_info{class = AS8#slotmachine_player_info.class,count = AS8#slotmachine_player_info.count + BS8#slotmachine_player_info.count}
        ]}
    end,

    % 循环所有玩家
    lists:foldl(F,#slotmachine_player{infos=
    		[
        		#slotmachine_player_info{class = 2,count = 0},
        		#slotmachine_player_info{class = 3,count = 0},
        		#slotmachine_player_info{class = 4,count = 0},
        		#slotmachine_player_info{class = 5,count = 0},
        		#slotmachine_player_info{class = 6,count = 0},
        		#slotmachine_player_info{class = 7,count = 0},
        		#slotmachine_player_info{class = 8,count = 0},
        		#slotmachine_player_info{class = 9,count = 0}
        	]},List).


%% 添加玩家的信息到ETS
add_slotmachine_player_to_ets(SP) when is_record(SP, slotmachine_player) ->
    % case get_slotmachine_player(SP#slotmachine_player.player_id) of 
    %     null ->
    %         ?ERROR_MSG("add_online_player_brief_to_ets ~p",[SP#slotmachine_player.player_id]);
    %     _ ->
    %         ?DEBUG_MSG("add_online_player_brief_to_ets ~p",[SP#slotmachine_player.player_id])
    % end,

    ets:insert(?ETS_SLOTMACHINE_PLAYERS, SP).

%% 删除所有非当前轮次的ETS数据
del_all_not_cur_rounds_data() ->
    % 先保存到数据
    sava_all_slotmachine_player_to_db(),

    List = ets:tab2list(?ETS_SLOTMACHINE_PLAYERS),

    F = fun(SP,Acc) ->
        Rounds = SP#slotmachine_player.rounds,
        PlayerId = SP#slotmachine_player.player_id,
        ?Ifc (Rounds /= get_rounds())
            ets:delete(?ETS_SLOTMACHINE_PLAYERS, PlayerId)
        ?End,

        Acc + 1
    end,

    lists:foldl(F,0,List).

%% 保存数据到数据库
sava_all_slotmachine_player_to_db() ->
    List = get_all_slotmachine_player(),

    F = fun(SP,Acc) ->
        lib_slotmachine:update_or_insert_slotmachine_player_to_db(SP),
        Acc + 1
    end,

    lists:foldl(F,0,List).

    

% %% 更新在线玩家的简要信息到ets
update_slotmachine_player_to_ets(SP)
  when is_record(SP, slotmachine_player) ->
    ets:insert(?ETS_SLOTMACHINE_PLAYERS, SP).
%--------------------------------------------------------------------------------------------------------%


%--------------------------------------------------------------------------------------------------------%
% ETS_SLOTMACHINE_HISTORY
get_slotmachine_history() ->
    ets:tab2list(?ETS_SLOTMACHINE_HISTORY).

add_slotmachine_history_to_ets(SH) when is_record(SH,slotmachine_history) ->
    ets:insert(?ETS_SLOTMACHINE_HISTORY, SH).

% 删除5以外的数据
del_slotmachine_history_from_ets() ->
    List = get_slotmachine_history(),

    F1 = fun(A, B) -> 
        if 
            A#slotmachine_history.rounds > B#slotmachine_history.rounds ->
                true;
            true ->
                false
        end
    end,

    List1 = lists:sort(F1, List),

    F2 = fun(SH,Acc) ->
        Rounds = SH#slotmachine_history.rounds,
        ?Ifc (Acc >= 5)
            ets:delete(?ETS_SLOTMACHINE_HISTORY, Rounds)
        ?End,

        Acc + 1
    end,

    lists:foldl(F2,0,List1).

% 从数据库加载
load_slotmachine_history_by_db() ->
    List = lib_slotmachine:load_slotmachine_history_by_db(),

    F2 = fun(SH,Acc) ->
        add_slotmachine_history_to_ets(SH),
        Acc + 1
    end,

    lists:foldl(F2,0,List).

% 保存历史记录到数据库
sava_slotmachine_history_to_db() ->
    del_slotmachine_history_from_ets(),
    List = get_slotmachine_history(),

    % ?DEBUG_MSG("List = ~p",[List]),
    F = fun(#slotmachine_history{rounds = Rounds,no=No,change=Change}) -> 
        % ?DEBUG_MSG("Rounds = ~p No = ~p Change = ~p",[Rounds,No,Change]),
        lib_slotmachine:sava_history(Rounds,No,Change)
    end,

    lists:foreach(F,List).
%--------------------------------------------------------------------------------------------------------%


% 保存数据
db_save() ->
	% ?DEBUG_MSG("slotmachine sava",[]),
	mod_data:save(?SYS_SLOTMACHINE, #slotmachine_info{rounds=get_rounds(),lefttime=get_lefttime()}),
    sava_all_slotmachine_player_to_db(),
    sava_slotmachine_history_to_db(),
    void.

% 加载数据
db_load() ->
    % 加载回合倒计时信息 如果没有数据则算第一期
    % ?DEBUG_MSG("load mod_data:load(?SYS_SLOTMACHINE)  = ~p",[mod_data:load(?SYS_SLOTMACHINE) ]),
    case mod_data:load(?SYS_SLOTMACHINE) of
        [] ->
            set_rounds(1),
            set_lefttime(?SLOTMACHINE_INTERVAL),
            ok;
        [#slotmachine_info{rounds=Rounds,lefttime=LeftTime}] ->
            set_rounds(Rounds),
            set_lefttime(LeftTime),
            ok;
        _Other ->
            ?ASSERT(false, _Other),
            fail
    end,

    % 加载历史记录
    AllHistory = lib_slotmachine:slotmachine_history_from_load(),
    % ?DEBUG_MSG("AllHistory=~p",[AllHistory]),
    FH = fun(SH, Acc) ->
        add_slotmachine_history_to_ets(SH),
        Acc + 1
    end,
    lists:foldl(FH, 0,AllHistory),
    

    % 加载当前回合的所有玩家购买老虎机信息
    AllPlayerSlot = lib_slotmachine:slotmachine_all_player_from_db_load(get_rounds()),
    % ?DEBUG_MSG("AllPlayerSlot=~p",[AllPlayerSlot]),

    FS = fun(SP, Acc) ->
        add_slotmachine_player_to_ets(SP),
        Acc + 1
    end,
    lists:foldl(FS, 0,AllPlayerSlot),

    void.

    

% 设置当前轮次
set_rounds(Rounds) ->
    ets:insert(?ETS_SLOTMACHINE_INFO, {?SLOTMACHINE_ROUNDS, Rounds}).

%% 获取服务器的开启状态
%% 返回值：open（开启中） | closed（未开启）
get_rounds() ->
    case ets:lookup(?ETS_SLOTMACHINE_INFO, ?SLOTMACHINE_ROUNDS) of
        [] -> 0;
        [{?SLOTMACHINE_ROUNDS,Rounds}] when is_integer(Rounds) ->
            Rounds;
        _Other ->
            % ?DEBUG_MSG("_Other=~p",[_Other]),
            % ?ASSERT(false, _Other),
            0
    end.

% 设置剩余时间
set_lefttime(LeftTime) ->
    ets:insert(?ETS_SLOTMACHINE_INFO, {?SLOTMACHINE_LEFT_TIME, LeftTime}).

%% 获取服务器的开启状态
%% 返回值：open（开启中） | closed（未开启）
get_lefttime() ->
    case ets:lookup(?ETS_SLOTMACHINE_INFO, ?SLOTMACHINE_LEFT_TIME) of
        [] -> 0;
        [{?SLOTMACHINE_LEFT_TIME,LeftTime}] when is_integer(LeftTime) ->
            LeftTime;
        _Other ->
            % ?DEBUG_MSG("_Other=~p",[_Other]),
            % ?ASSERT(false, _Other),
            0
    end.

% 循环检测
loop_check() ->
    case length(mod_svr_mgr:get_all_online_player_ids()) >= ?SLOTMACHINE_NEED_PLAYER_COUNT of
        false -> 
            ?DEBUG_MSG("PlayerCount Not have",[]),
            skip;
        true ->
        LeftTime = get_lefttime(),

        ?Ifc (LeftTime > 0 )
            set_lefttime(LeftTime - 1)
        ?End,

        ?Ifc (LeftTime == 0)
            % 开奖
            lib_slotmachine:open_slotmachine(get_rounds()),
            % 重新设置间隔
            set_lefttime(?SLOTMACHINE_INTERVAL),
            % 轮次加1
            set_rounds(get_rounds() + 1),

            % 删除所有ETS非当前数据
            del_all_not_cur_rounds_data(),

            db_save()
        ?End
    end,
    
    void.

save_to_db() ->
    gen_server:call(?MODULE, save_to_db).

% start
start() ->
    case erlang:whereis(?MODULE) of
        undefined ->
            case supervisor:start_child(
               sm_sup,
               {?MODULE,
                {?MODULE, start_link, []},
                 permanent, ?SLOTMACHINE_TIMER, worker, [?MODULE]}) of
            {ok, Pid} ->
                Pid;
            {error, R} ->
                ?WARNING_MSG("start error:~p~n", [R]),
                undefined
            end;
        Pid ->
            Pid
    end.

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

% stop
stop() ->
    gen_server:call(?MODULE, save_to_db),
    supervisor:terminate_child(sm_sup, ?MODULE).

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

terminate(_Reason, _State) ->
    ok.

% call 同步调用需要等待结构
do_call(save_to_db, _From, State) ->
    %?DEBUG_MSG("business sava 1",[]),
    db_save(),
    %?DEBUG_MSG("business sava 2",[]),
    {reply, ok, State};

% call 同步调用需要等待结构
do_call(_Msg, _From, State) ->
    ?WARNING_MSG("unhandle call ~w", [_Msg]),
    {reply, error, State}.

% 异步调用无需等待
% cast
do_cast(_Msg, State) ->
    ?WARNING_MSG("unhandle cast ~p", [_Msg]),
    {noreply, State}.

%% info
do_info(doloop, State) ->
    loop_check(),
    {noreply, State};

do_info(_Msg, State) ->
    ?WARNING_MSG("unhandle info ~w", [_Msg]),
    {noreply, State}.

init([]) ->
    % 玩家信息ETS
    ets:new(?ETS_SLOTMACHINE_PLAYERS, [{keypos, #slotmachine_player.player_id}, named_table, public, set]),     % 购买信息玩家信息
    % 历史记录ETS
    ets:new(?ETS_SLOTMACHINE_HISTORY, [{keypos, #slotmachine_history.rounds}, named_table, public, set]),       % 历史记录
    % 老虎机信息ETS 轮次 倒计时
    ets:new(?ETS_SLOTMACHINE_INFO, [named_table, public, set]),   % 服务器杂项信息

    db_load(),
    % 每60秒执行一次循环
    mod_timer:reg_loop_msg(self(), ?SLOTMACHINE_TIMER),
    {ok, #state{}}.


% handle
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