%%%--------------------------------------
%%% @Module: mod_rank
%%% @Author: liuzhongzheng2012@gmail.com
%%% @Created: 2014-05-08
%%% @Description: 排行榜
%%%--------------------------------------

-module(mod_rank).
-behavour(gen_server).
-export([init/1, handle_cast/2, handle_call/3, handle_info/2, terminate/2, code_change/3]).
-export([start/0, start_link/0, on_server_stop/0]).


-export([
            exe/2,
            send_rank/3,
            role_RMB/2,
            role_battle_power/1,
            role_lv/1,
            role_money/1,
            role_tower/2,
			role_tower_ghost/2,
            role_charm/2,
            role_cool/2,
			role_home_degree/2,
            partner_clv/1,
            partner_battle_power/1,
            equip_battle_power/1,
            arena_1v1/1,
            arena_3v3/1,
            world_boss/2,
            world_boss_kill/2,
            guild_battle_power/1,
			guild_battle_prosper/1,
            notify_all_info/1,          % 玩家上线通知所有排行榜相关信息，应对合服的情况

            vip_up/1,

            daily_reset/0,
            weekly_reset/0,
            release/1,
            reset_board/1,
            save_as_history/1,

            get_equip_detail/2,
            mount_clv/1,
            mount_battle_power/1,
			role_dungeon_col_degree/2,
		    role_dungeon_kill_degree/2,
		    role_dungeon_damage_degree/2,
            role_dungeon_contri_degree/2,
			send_rank_goods/1
        ]).

-include("common.hrl").
-include("record.hrl").

-include("rank.hrl").
-include("protocol/pt_22.hrl").

-include("goods.hrl").
-include("partner.hrl").
-include("record/goods_record.hrl").
-include("arena_1v1.hrl").
-include("mount.hrl").

-record(state, {}).


notify_all_info(PS) ->
    role_lv(PS),
    role_battle_power(PS),
    role_money(PS),
    %坐骑
    % F = fun(MountId) ->
    case lib_mount:get_mount(player:get_mount(PS)) of
        Mount when is_record(Mount, ets_mount) ->
            mount_clv(Mount),
            mount_battle_power(Mount);
        _ -> skip
    end,
        % end,
    % [F(X) || X <- player:get_mount_id_list(PS)],    
    case mod_partner:get_main_partner_obj(PS) of
        null -> skip;
        Partner -> 
            partner_clv(Partner),
            partner_battle_power(Partner)
    end.


%% 对指定榜单执行操作
exe(RankID, Func) ->
    gen_server:cast(?MODULE, {exe, RankID, Func}).

role_battle_power(#player_status{}=PS) ->
    RankID = ?RANK_ROLE_BATTLE_POWER,
    Ranker = lib_rank:data_to_ranker(RankID, PS),
    request_enter(RankID, Ranker),
    case player:get_faction(PS) of
        0 ->
            skip;
        Faction ->
            RankID2 = 1020 + Faction,
            Ranker2 = lib_rank:data_to_ranker(RankID2, PS),
            request_enter(RankID2, Ranker2)
    end.

role_lv(#player_status{}=PS) ->
    RankID = ?RANK_ROLE_LV,
    Ranker = lib_rank:data_to_ranker(RankID, PS),
    request_enter(RankID, Ranker).

role_money(#player_status{}=PS) ->
    RankID = ?RANK_ROLE_MONEY,
    Ranker = lib_rank:data_to_ranker(RankID, PS),
    request_enter(RankID, Ranker).

role_tower(PS, Lv) ->
    RankID = ?RANK_ROLE_TOWER,
    Ranker = lib_rank:data_to_ranker(RankID, {PS, Lv}),
    request_enter(RankID, Ranker).


role_tower_ghost(PS, Lv) ->
    RankID = ?RANK_TOWER_GHOST,
    Ranker = lib_rank:data_to_ranker(RankID, {PS, Lv}),
    request_enter(RankID, Ranker).


%土豪榜
role_RMB(PS,Number) ->
    RankID = ?RANK_ROLE_RMB,
    Ranker = lib_rank:data_to_ranker(RankID, {PS, Number}),
    request_enter(RankID, Ranker).

% 魅力
role_charm(PS, Charm) ->
    RankID = ?RANK_ROLE_CHARM,
    Ranker = lib_rank:data_to_ranker(RankID, {PS, Charm}),
    request_enter(RankID, Ranker).

% 风度
role_cool(PS, Cool) ->
    RankID = ?RANK_ROLE_COOL,
    Ranker = lib_rank:data_to_ranker(RankID, {PS, Cool}),
    request_enter(RankID, Ranker).


% 家园豪华度
role_home_degree(PS, Degree) ->
    RankID = ?RANK_HOME_LUXURY,
    Ranker = lib_rank:data_to_ranker(RankID, {PS, Degree}),
    request_enter(RankID, Ranker).

%帮派副本采集
role_dungeon_col_degree(PS, Value) ->
    RankID = ?RANK_GUILD_COLLECT,
    Ranker = lib_rank:data_to_ranker(RankID, {PS, Value}),
    request_enter(RankID, Ranker).

%帮派副本击杀
role_dungeon_kill_degree(PS, Value) ->
    RankID = ?RANK_GUILD_KILL,
    Ranker = lib_rank:data_to_ranker(RankID, {PS, Value}),
    request_enter(RankID, Ranker).
%帮派副本伤害值

role_dungeon_damage_degree(PS, Value) ->
    RankID = ?RANK_GUILD_DAMAGE,
    Ranker = lib_rank:data_to_ranker(RankID, {PS, Value}),
    request_enter(RankID, Ranker).

%帮派副本贡献值
role_dungeon_contri_degree(PS, Value) ->
    RankID = ?RANK_GUILD_CONTRIBUTION,
    Ranker = lib_rank:data_to_ranker(RankID, {PS, Value}),
    request_enter(RankID, Ranker).


partner_clv(#partner{}=Partner) ->
    RankID = ?RANK_PARTNER_LV,
    Ranker = lib_rank:data_to_ranker(RankID, Partner),
    request_enter(RankID, Ranker).

partner_battle_power(#partner{}=Partner) ->
    RankID = ?RANK_PARTNER_BATTLE_POWER,
    Ranker = lib_rank:data_to_ranker(RankID, Partner),
    request_enter(RankID, Ranker).

mount_clv(#ets_mount{}=Mount) ->
    RankID = ?RANK_MOUNT_LV,
    Ranker = lib_rank:data_to_ranker(RankID, Mount),
    request_enter(RankID, Ranker).

mount_battle_power(#ets_mount{}=Mount) ->
    RankID = ?RANK_MOUNT_BATTLE_POWER,
    Ranker = lib_rank:data_to_ranker(RankID, Mount),
    request_enter(RankID, Ranker).

equip_battle_power(#goods{}=Goods) ->
%%     RankID = ?RANK_EQUIP_BATTLE_POWER,
%%     Ranker = lib_rank:data_to_ranker(RankID, Goods),
%%     request_enter(RankID, Ranker),
	%% 装备要做分类排行榜
	case rank_equip_type(Goods) of
		{ok, RankID2} ->
			Ranker = lib_rank:data_to_ranker(RankID2, Goods),
			request_enter(RankID2, Ranker);
		_ ->
			ok
	end.

rank_equip_type(Goods) ->
	case lib_goods:is_weapon(Goods) of
		true -> {ok, ?RANK_EQUIP_WUQI};  % 武器
		false ->
			case lib_goods:get_subtype(Goods) of
				?EQP_T_BRACER        -> {ok, ?RANK_EQUIP_TOUKUI};            % 护腕
				?EQP_T_BARDE       ->   {ok, ?RANK_EQUIP_YIFU};             % 铠甲
				?EQP_T_SHOES         -> {ok, ?RANK_EQUIP_XIEZI};             % 鞋子
				?EQP_T_NECKLACE     ->  {ok, ?RANK_EQUIP_XIANGLIAN};          % 项链
				?EQP_T_WAISTBAND    ->  {ok, ?RANK_EQUIP_YAODAI};         % 腰带
				_ ->
					skip
			end
	end.


arena_1v1(#arena1{}=Arena) ->
    DayRanker = lib_rank:data_to_ranker(?RANK_ARENA_1V1_DAY, Arena),
    WeekRanker = lib_rank:data_to_ranker(?RANK_ARENA_1V1_WEEK, Arena),
    request_enter(?RANK_ARENA_1V1_DAY, DayRanker),
    request_enter(?RANK_ARENA_1V1_WEEK, WeekRanker).

arena_3v3(#arena1{}=Arena) ->
    DayRanker = lib_rank:data_to_ranker(?RANK_ARENA_3V3_DAY, Arena),
    WeekRanker = lib_rank:data_to_ranker(?RANK_ARENA_3V3_WEEK, Arena),
    request_enter(?RANK_ARENA_3V3_DAY, DayRanker),
    request_enter(?RANK_ARENA_3V3_WEEK, WeekRanker).

%% 帮派战力排行榜, 格式:{GuildID, Name, Lv, BattlePower}
guild_battle_power(Data) ->
    RankID = ?RANK_GUILD_BATTLE_POWER,
    Ranker = lib_rank:data_to_ranker(RankID, Data),
    request_enter(RankID, Ranker).

%% 帮派建设（繁荣度）排行榜, 格式:{GuildID, GuildName, GuildLv, MasterName, MemberStr, Prosper}
guild_battle_prosper(Data) ->
    RankID = ?RANK_GUILD_BATTLE_PROSPER,
    Ranker = lib_rank:data_to_ranker(RankID, Data),
    request_enter(RankID, Ranker).


%% 世界Boss伤害
world_boss(PS, Score) ->
    RankID = ?RANK_ROLE_WORLD_BOSS,
    Ranker = lib_rank:data_to_ranker(RankID, {PS, Score}),
    request_enter(RankID, Ranker).
%% 世界Boss击杀
world_boss_kill(PS, Score) ->
    RankID = ?RANK_ROLE_WORLD_BOSS_KILL,
    Ranker = lib_rank:data_to_ranker(RankID, {PS, Score}),
    request_enter(RankID, Ranker).

request_enter(_RankID, ?undefined) ->
    ok;
request_enter(RankID, Ranker) ->
    gen_server:cast(?MODULE, {enter, RankID, Ranker}).

send_rank(#player_status{id=UID}, RankID, Page) ->
    gen_server:cast(?MODULE, {send_rank, UID, RankID, Page}).

send_rank_goods(RankID) ->
    gen_server:cast(?MODULE, {send_rank_goods, RankID}).



get_equip_detail(#player_status{id=UID}, GoodsID) ->
    gen_server:cast(?MODULE, {get_equip_detail, UID, GoodsID}).

vip_up(#player_status{id=UID}=PS) ->
    VipLv = lib_vip:lv(PS),
    gen_server:cast(?MODULE, {vip_up, UID, VipLv}).

daily_reset() ->
	ok.
%%     reset_board(?RANK_ARENA_1V1_DAY),
%%     reset_board(?RANK_ARENA_3V3_DAY).
%%     reset_board(?RANK_ROLE_TOWER),
%% 	reset_board(?RANK_TOWER_GHOST).

weekly_reset() ->
	ok.
%%     reset_board(?RANK_ROLE_COOL),
%%     reset_board(?RANK_ROLE_CHARM).


reset_board(RankID) ->
    gen_server:cast(?MODULE, {reset, RankID}).

release(RankID) ->
    gen_server:cast(?MODULE, {release_rank, RankID}).

save_as_history(RankID) ->
    gen_server:cast(?MODULE, {save_as_history, RankID}).

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

on_server_stop() ->
    gen_server:call(?MODULE, save_board_to_db, 30000).
    %%%supervisor:terminate_child(sm_sup, ?MODULE).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).


init([]) ->
    gen_server:cast(self(), init),
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
            ?ERROR_MSG("ERR:~p,Reason:~p, Request:~p, stacktrace:~w",[Err,Reason, Request, erlang:get_stacktrace()]),
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


terminate(Reason, _State) ->
    case Reason of
        normal -> skip;
        shutdown -> skip;
        {shutdown, _} -> skip;
        _ ->
            ?ERROR_MSG("[~p] !!!!!terminate!!!!! for reason: ~w", [?MODULE, Reason])
    end,
    ok.

do_call(save_board_to_db, _From, State) ->
    R = lib_rank:save_board_to_db(),
    {reply, R, State};

do_call(get_max_lv, _From, State) ->
    R = lib_rank:get_max_lv(1002),
    {reply, R, State};

do_call(_Msg, _From, State) ->
    ?WARNING_MSG("unhandle call ~w", [_Msg]),
    {reply, error, State}.



do_cast(init, State) ->
    ?TRY_CATCH(lib_rank:init_rank(), ErrReason),
    mod_timer:reg_loop_msg(self(), 60000),
    {noreply, State};

do_cast(release_rank, State) ->
    lib_rank:release_rank(),
    {noreply, State};

do_cast({enter, RankID, Ranker}, State) ->
    lib_rank:enter(RankID, Ranker),
    {noreply, State};

do_cast({send_rank, UID, RankID, Page}, State) ->
    lib_rank:send_rank(UID, RankID, Page),
    {noreply, State};

do_cast({send_rank_goods, RankID}, State) ->
    lib_rank:send_rank_goods(RankID),
    {noreply, State};



do_cast({release_rank, RankID}, State) ->
    lib_rank:release_rank(RankID),
    {noreply, State};

do_cast({save_as_history, RankID}, State) ->
    lib_rank:save_as_history(RankID),
    {noreply, State};

do_cast({get_equip_detail, UID, GoodsID}, State) ->
    lib_rank:send_equip_detail(UID, GoodsID),
    {noreply, State};

do_cast({vip_up, UID, Lv}, State) ->
    lib_rank:vip_up(UID, Lv),
    {noreply, State};

do_cast({reset, RankID}, State) ->
    lib_rank:reset_board(RankID),
    {noreply, State};

	
do_cast({get_RMB_rank_name, RankID}, State) ->
    lib_rank:send_all_rmb_rank(RankID),
    {noreply, State};

do_cast({exe, RankID, Func}, State) ->
    lib_rank:exe(RankID, Func),
    {noreply, State};

do_cast(_Msg, State) ->
    ?WARNING_MSG("unhandle cast ~p", [_Msg]),
    {noreply, State}.



%% 每分钟检测一遍
do_info(doloop, State) ->
    % ?DEBUG_MSG("this is mod_rank, doloop...", []),
    {_, Min, _} = erlang:time(),
    lib_rank:check_refresh(),
    case Min rem 15 of
        0 ->
            % 避开午夜0点左右的数据库繁忙时刻
            case lib_comm:is_now_nearby_midnight() of
                true ->
                    skip;
                false ->
                    lib_rank:save_board_to_db()
            end;
        _ ->
            skip
    end,
    {noreply, State};
do_info(_Msg, State) ->
    ?WARNING_MSG("unhandle info ~w", [_Msg]),
    {noreply, State}.

