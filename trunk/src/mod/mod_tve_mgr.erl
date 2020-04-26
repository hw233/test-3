%%%------------------------------------
%%% @Module  : mod_tve_mgr
%%% @Author  : zhangwq
%%% @Email   :
%%% @Created : 2014.11.22
%%% @Description: 守护三届管理 
%%%------------------------------------


-module(mod_tve_mgr).
-behaviour(gen_server).
-export([start_link/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-export([
        handle_enter/2,
        tve_mf_callback/1,
        daily_reset/1,                    %% 玩家数据日重置
        on_player_login/1,                %% 给玩家补发奖励（组队通关发奖励异常）
        on_job_schedule/0,
        tst_set_enter_cnt/2,
        tst_set_enter_cnt_single/2,
        tst_prob/2
    ]).


-include("tve.hrl").
-include("prompt_msg_code.hrl").
-include("ets_name.hrl").
-include("debug.hrl").
-include("abbreviate.hrl").
-include("common.hrl").
-include("goods.hrl").
-include("log.hrl").
-include("record.hrl").
-include("pt_16.hrl").
-include("record/battle_record.hrl").
-include("faction.hrl").



%% 进程字典的key名
-define(PDKN_PLAYER_REWARD, {pdkn_player_reward, player_id}).                        %% 玩家挑战奖励
-define(PDKN_PLAYER_BT_RET, {pdkn_player_bt_ret, player_id}).                        %% 玩家战斗结果
-define(PDKN_PLAYER_ENTER_LV_STEP, {pdkn_player_enter_lv_step, player_id}).          %% 玩家进入的等级段
-define(PDKN_PLAYER_GETTING_REWARD, {pdkn_player_getting_reward, player_id}).        %% 玩家正在领取挑战奖励
-define(PDKN_PLAYER_REFRESH_REWARD_CNT, {pdkn_player_refresh_reward_cnt, player_id}).%% 本次战斗刷新奖励次数

on_job_schedule() ->
    gen_server:cast(?TVE_MGR_PROCESS, 'on_job_schedule').
 

%% 每日重置 玩家进程调用
daily_reset(PS) ->
    case mod_tve:get_player_tve_data(player:id(PS)) of
        null -> skip;
        Data ->
            Data2 = Data#player_tve_data{enter_time = 0, enter_time_single = 0},
            mod_tve:set_player_tve_data(player:id(PS), Data2)
    end.


on_player_login(PlayerId) ->
    gen_server:cast(?TVE_MGR_PROCESS, {'on_player_login', PlayerId}).    

%% 队伍战斗，反馈给队伍
tve_mf_callback(Feedback) ->
    ?DEBUG_MSG("mod_tve_mgr: tve_mf_callback begin,Feedback:~w~n", [Feedback]),
    gen_server:cast(?TVE_MGR_PROCESS, {'tve_mf_callback', Feedback}).

%% ps为队长的ps 队长进程调用
handle_enter(PS, LvStep) ->
    case data_tve:get(LvStep) of
        null ->
            ?ERROR_MSG("mod_tve_mgr:handle_enter error!LvStep:~p~n", [LvStep]);
        Data ->
            GoodsList = get_cost_goods_list(player:id(PS), LvStep),
            case GoodsList =/= [] of
                true ->
                    case mod_inv:destroy_goods_WNC(player:id(PS), GoodsList, []) of
                        true ->
                            lib_dungeon:create_dungeon(Data#tve_cfg.dungeon_no, PS),
                            ?DEBUG_MSG("mod_tve_mgr:handle_enter begin ... LvStep:~p, dungeon_no:~p~n", [LvStep, Data#tve_cfg.dungeon_no]),
                            
                            gen_server:cast(?TVE_MGR_PROCESS, {'handle_enter', PS, LvStep});
                        false -> %% 通知成员，进入失败
                            F = fun(Id) ->
                                {ok, BinData} = pt_16:write(?PT_TVE_ENTER, [{1, player:get_name(PS)}]),
                                lib_send:send_to_uid(Id, BinData)
                            end,
                            [F(X) || X <- mod_team:get_normal_member_id_list(player:get_team_id(PS))]
                    end;
                false ->
                    lib_dungeon:create_dungeon(Data#tve_cfg.dungeon_no, PS),
                    ?DEBUG_MSG("mod_tve_mgr:handle_enter begin ... LvStep:~p, dungeon_no:~p~n", [LvStep, Data#tve_cfg.dungeon_no]),
                    
                    gen_server:cast(?TVE_MGR_PROCESS, {'handle_enter', PS, LvStep})
            end
    end.

tst_prob(LvStep, WinWave) ->
    GoodsL = mk_new_goods_list(LvStep, [], WinWave, 0),
    ?DEBUG_MSG("mod_tve_mgr:tst_prob ... GoodsList:~w~n", [GoodsL]),
    F = fun(X) ->
        {ok, BinData} = pt_16:write(?PT_TVE_SHOW_RESULT, [WinWave, 10, ?MNY_T_YUANBAO, 100, GoodsL]),
        lib_send:send_to_uid(X, BinData)
    end,
    [F(X) || X <- mod_svr_mgr:get_all_online_player_ids()].


tst_set_enter_cnt(PS, Cnt) ->
    gen_server:cast(?TVE_MGR_PROCESS, {'tst_set_enter_cnt', PS, Cnt}).

tst_set_enter_cnt_single(PS, Cnt) ->
    gen_server:cast(?TVE_MGR_PROCESS, {'tst_set_enter_cnt_single', PS, Cnt}).


% -------------------------------------------------------------------------

start_link() ->
    gen_server:start_link({local, ?TVE_MGR_PROCESS}, ?MODULE, [], []).


init([]) ->
    process_flag(trap_exit, true),
    
    case mod_tve:init() of
        true -> {ok, none};
        false -> {fail, ?PM_DATA_CONFIG_ERROR}
    end.

handle_call(Request, From, State) ->
    try
        handle_call_2(Request, From, State)
    catch
        Err:Reason ->
            ?ERROR_MSG("ERR:~p,Reason:~p,~w",[Err, Reason, erlang:get_stacktrace()]),
            {reply, error, State}
    end.


handle_call_2(_Request, _From, State) ->
    {reply, State, State}.


handle_cast(Request, State) ->
    try
        handle_cast_2(Request, State)
    catch
        Err:Reason ->
            ?ERROR_MSG("ERR:~p,Reason:~p,~w",[Err,Reason,erlang:get_stacktrace()]),
            {noreply, State}
    end.


handle_cast_2('on_job_schedule', State) ->
    ?TRY_CATCH(mod_tve:on_job_schedule(), Err_Reason),
    {noreply, State};


handle_cast_2({'tst_set_enter_cnt', PS, Cnt}, State) ->
    case mod_tve:get_player_tve_data(player:id(PS)) of
%%         null -> skip;
        #player_tve_data{} = Data ->
            Data2 = Data#player_tve_data{enter_time = Cnt},
            mod_tve:set_player_tve_data(player:id(PS), Data2);
		_ ->
			skip
    end,
    {noreply, State};


handle_cast_2({'tst_set_enter_cnt_single', PS, Cnt}, State) ->
    case mod_tve:get_player_tve_data(player:id(PS)) of
%%         null -> skip;
        #player_tve_data{} = Data ->
            Data2 = Data#player_tve_data{enter_time_single = Cnt},
            mod_tve:set_player_tve_data(player:id(PS), Data2);
		_ ->
			skip
    end,
    {noreply, State};

%% 扣物品，记录相关信息
handle_cast_2({'handle_enter', PS, LvStep}, State) ->
    %% 扣队长以外玩家的物品（cast消息到玩家进程）
    %% 因为有非组队情况，所以做下判断
    MbIdList = case mod_team:get_normal_member_id_list(player:get_team_id(PS)) of
				   [] ->
					   [player:id(PS)];
				   MbIdList0 ->
					   MbIdList0
			   end,

    F0 = fun(Id) ->
        case player:get_PS(Id) of
            null ->
                ?ERROR_MSG("mod_tve_mgr:handle_enter fail, PlayerId:~p~n", [Id]);
            TPS ->
                GoodsList = get_cost_goods_list(Id, LvStep),
                gen_server:cast(player:get_pid(TPS), {'destroy_goods_WNC', GoodsList, [?LOG_DUNGEON, "tve"], ?TVE_MGR_PROCESS})
        end
    end,
    [F0(X) || X <- MbIdList -- [player:id(PS)]],

    F = fun(Id) ->
        set_player_enter_lv_step(Id, LvStep)
    end,

	[F(X) || X <- MbIdList],
    {noreply, State};    


%% 玩家扣物品返回，扣失败，则把玩家推出副本
handle_cast_2({'destroy_goods_ret', PlayerId, RetBool}, State) ->
    case RetBool of
        false ->
            ?ERROR_MSG("mod_tve_mgr:destroy_goods_ret fail, PlayerId:~p~n", [PlayerId]),
            case player:get_PS(PlayerId) of
                null -> skip;
                PS ->
                    case player:is_leader(PS) of
                        true -> skip;
                        false -> 
                            mod_team_mgr:sys_kick_out_member(player:get_team_id(PS), PS)
                    end
            end;
        true ->
            skip
    end,

    {noreply, State};        


handle_cast_2({'refresh_reward', PS}, State) ->
    case get_player_reward(player:id(PS)) of
        null -> skip;
        _GoodsList ->
            {MoneyType, MoneyCount} = mk_refresh_money(player:id(PS)),
            case player:has_enough_money(PS, MoneyType, MoneyCount) of
                false ->
                    lib_send:send_prompt_msg(PS, ?PM_YB_LIMIT);
                true ->
                    gen_server:cast(player:get_pid(PS), {'cost_money', [{MoneyType, MoneyCount}], [?LOG_DUNGEON, "tve"], ?TVE_MGR_PROCESS})
            end
    end,
    {noreply, State};


handle_cast_2({'cost_money_ret', PS, RetBool}, State) ->
    case RetBool of
        false ->
            lib_send:send_prompt_msg(PS, ?PM_YB_LIMIT);
        true -> %% 扣钱成功，刷新奖励
            NewGoodsL = mk_new_goods_list(player:id(PS)),
            set_player_reward(player:id(PS), NewGoodsL),
            
            set_player_refresh_reward_cnt(player:id(PS), get_player_refresh_reward_cnt(player:id(PS)) + 1),

            {MoneyType1, MoneyCount1} = mk_refresh_money(player:id(PS)),
            {ok, BinData} = pt_16:write(?PT_TVE_REFRESH_REWARD, [MoneyType1, MoneyCount1, NewGoodsL]),
            lib_send:send_to_sock(PS, BinData)
    end,
    {noreply, State};


handle_cast_2({'get_reward', PS}, State) ->
    ?DEBUG_MSG("mod_tve_mgr:get_reward begin...PlayerId:~p~n", [player:id(PS)]),
    case get_player_reward(player:id(PS)) of
        null -> skip;
        GoodsList ->
            case is_player_getting_reward(player:id(PS)) of
                true ->
                    lib_send:send_prompt_msg(PS, ?PM_TVE_GIVING_REWARD);
                false ->
                    GoodsList1 = [{GoodsNo, GoodsCount, Quality, BindState} || {GoodsNo, GoodsCount, Quality, BindState, _Flag} <- GoodsList],
                    case player:get_pid(PS) of
                        null ->
                            GoodsList2 = adust_goods_list_for_mail(GoodsList),

                            lib_mail:send_sys_mail(player:id(PS), <<"兵临城下奖励">>, <<"主人，您掉线了，兵临城下系统通过邮件发送奖励给您，请查收！">>, GoodsList2, [?LOG_DUNGEON, "tve"]),
                            erase_player_reward(player:id(PS)),
                            erase_player_bt_ret(player:id(PS)),
                            erase_player_enter_lv_step(player:id(PS)),
                            erase_player_refresh_reward_cnt(player:id(PS));
                        Pid ->
                            set_player_getting_reward(player:id(PS), true),
                            gen_server:cast(Pid, {'reward_player', GoodsList1, [?LOG_DUNGEON, "tve"], true, ?TVE_MGR_PROCESS})
                    end
            end
    end,
    {noreply, State}; 
    

%% 玩家进程反馈，发奖成功
handle_cast_2({'reward_player_ok', PlayerId}, State) ->
    ?DEBUG_MSG("mod_tve_mgr:reward_player_ok,PlayerId:~p~n", [PlayerId]),
    try_send_tips(PlayerId),
    erase_player_reward(PlayerId),
    erase_player_bt_ret(PlayerId),
    erase_player_enter_lv_step(PlayerId),
    erase_player_refresh_reward_cnt(PlayerId),
    {ok, BinData} = pt_16:write(?PT_TVE_GET_REWARD, [?RES_OK]),
    lib_send:send_to_uid(PlayerId, BinData),
    {noreply, State}; 


handle_cast_2({'on_player_login', PlayerId}, State) ->
    case get_player_reward(PlayerId) of
        null -> skip;
        GoodsList ->
            GoodsList1 = adust_goods_list_for_mail(GoodsList),
            case GoodsList1 =:= [] of
                true -> skip;
                false -> lib_mail:send_sys_mail(PlayerId, <<"兵临城下奖励">>, <<"主人，您掉线了，兵临城下系统通过邮件发送奖励给您，请查收！">>, GoodsList1, [?LOG_DUNGEON, "tve"])
            end,
            erase_player_reward(PlayerId),
            erase_player_bt_ret(PlayerId),
            erase_player_enter_lv_step(PlayerId)
    end,
    {noreply, State};     

handle_cast_2({'tve_mf_callback', Feedback}, State) ->
	LvStep = get_player_enter_lv_step(Feedback#btl_feedback.player_id),            
	List = [Feedback#btl_feedback.player_id | Feedback#btl_feedback.teammate_id_list],
    TeamId = pick_team_id(List),
    GetList = case mod_team:get_all_member_id_list(TeamId) of
				  [] ->
					  [Feedback#btl_feedback.player_id];
				  GetList0 ->
					  GetList0
			  end,
    ?DEBUG_MSG("mod_tve_mgr:tve_mf_callback:PlayerIdList:~w~n", [List]),
    Rounds = Feedback#btl_feedback.lasting_rounds,
    WinWave = 
        case Feedback#btl_feedback.result of
            win -> Feedback#btl_feedback.nth_wave_bmon_group;
            _ -> Feedback#btl_feedback.nth_wave_bmon_group - 1
        end,

    %% 获取现在的队长
    LeaderId = case mod_team:get_leader_id(TeamId) of
				   0 ->
					   Feedback#btl_feedback.player_id;
				   LeaderId0 ->
					   LeaderId0
			   end,
    F = fun(Id, Acc) ->
        case lists:member(Id, GetList) of 
            false -> Acc;
            true ->
                case mod_tve:get_player_tve_data(Id) of
                    null ->
                        ?ERROR_MSG("mod_tve_mgr:get_player_tve_data error!~n", []);
                    _PlayerTveData ->
                        set_player_refresh_reward_cnt(Id, 0),
						TypeTime = case mod_tve:is_team_tve(LvStep) of
									   true ->
										   inc_enter_time;
									   false ->
										   inc_enter_time_single
								   end,
                        lib_offcast:cast(Id, {'update_tve_data', [{TypeTime, 1}]})
                end,

                set_player_bt_ret(Id, {WinWave, Rounds}),

                GoodsL = mk_new_goods_list(Id),
                %% 尝试发送上一轮的奖励
                try_give_last_reward(Id),
                set_player_reward(Id, GoodsL),
                erase_player_getting_reward(Id),
                case player:get_PS(Id) of
                    null ->
                        GoodsList1 = adust_goods_list_for_mail(GoodsL),
                        case GoodsList1 =:= [] of
                            true -> skip;
                            false ->
								{Title, Content, Log} =
									case mod_tve:is_team_tve(LvStep) of
										true ->
											{<<"兵临城下奖励">>, <<"主人，您掉线了，兵临城下系统通过邮件发送奖励给您，请查收！">>, "tve"};
										false ->
											{<<"试炼之地奖励">>, <<"主人，您掉线了，试炼之地系统通过邮件发送奖励给您，请查收！">>, "tve_single"}
									end,
								lib_mail:send_sys_mail(Id, Title, Content, GoodsList1, [?LOG_DUNGEON, Log])
                        end,
                        erase_player_reward(Id),
                        erase_player_bt_ret(Id),
                        % erase_player_enter_lv_step(Id), %% 目前战斗模块如果全部人一起掉线，则认为战斗失败，但队伍还在副本中，可以继续战斗，故不能erase掉进入等级段
                        [?FACTION_XMD | Acc];
                    PS ->
                        case Id =:= LeaderId of
                            true -> lib_dungeon:quit_dungeon(PS);
                            false -> skip
                        end,

                        {MoneyType, MoneyCount} = mk_refresh_money(Id),
                        ?DEBUG_MSG("mod_tve_mgr:PT_TVE_SHOW_RESULT:{WinWave, Rounds, MoneyType, MoneyCount, GoodsL}:~w~n", [{WinWave, Rounds, MoneyType, MoneyCount, GoodsL}]),
                        {ok, BinData} = pt_16:write(?PT_TVE_SHOW_RESULT, [WinWave, Rounds, MoneyType, MoneyCount, GoodsL]),
                        lib_send:send_to_sock(PS, BinData),
                        [player:get_faction(PS) | Acc]
                end
        end
    end,

    FactionL = lists:foldl(F, [], List),
    LeaderPS = 
        case player:get_PS(Feedback#btl_feedback.player_id) of
            null -> ply_tmplogout_cache:get_tmplogout_PS(Feedback#btl_feedback.player_id);
            TPS -> TPS
        end,

    update_rank(LeaderPS, GetList, FactionL, WinWave, Rounds),
    
    {noreply, State};     



handle_cast_2(_Msg, State) ->
    {noreply, State}.


handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

% %%-------------------------------------------------------------------------------------------------


%% return [] | List | null
get_player_reward(PlayerId) ->
    case erlang:get({?PDKN_PLAYER_REWARD, PlayerId}) of
        undefined -> null;
        Rd -> Rd
    end.

set_player_reward(PlayerId, List) ->
    erlang:put({?PDKN_PLAYER_REWARD, PlayerId}, List).


erase_player_reward(PlayerId) ->
    erlang:erase({?PDKN_PLAYER_REWARD, PlayerId}).


%% return {win, rounds}
get_player_bt_ret(PlayerId) ->
    case erlang:get({?PDKN_PLAYER_BT_RET, PlayerId}) of
        undefined -> null;
        Rd -> Rd
    end.

set_player_bt_ret(PlayerId, Info) ->
    erlang:put({?PDKN_PLAYER_BT_RET, PlayerId}, Info).


erase_player_bt_ret(PlayerId) ->
    erlang:erase({?PDKN_PLAYER_BT_RET, PlayerId}).


get_player_enter_lv_step(PlayerId) ->
    case erlang:get({?PDKN_PLAYER_ENTER_LV_STEP, PlayerId}) of
        undefined -> ?INVALID_NO;
        Rd -> Rd
    end.

set_player_enter_lv_step(PlayerId, Info) ->
    erlang:put({?PDKN_PLAYER_ENTER_LV_STEP, PlayerId}, Info).


erase_player_enter_lv_step(PlayerId) ->
    erlang:erase({?PDKN_PLAYER_ENTER_LV_STEP, PlayerId}).


get_player_refresh_reward_cnt(PlayerId) ->
    case erlang:get({?PDKN_PLAYER_REFRESH_REWARD_CNT, PlayerId}) of
        undefined -> ?INVALID_NO;
        Rd -> Rd
    end.

set_player_refresh_reward_cnt(PlayerId, Info) ->
    erlang:put({?PDKN_PLAYER_REFRESH_REWARD_CNT, PlayerId}, Info).


erase_player_refresh_reward_cnt(PlayerId) ->
    erlang:erase({?PDKN_PLAYER_REFRESH_REWARD_CNT, PlayerId}).



is_player_getting_reward(PlayerId) ->
    case erlang:get({?PDKN_PLAYER_GETTING_REWARD, PlayerId}) of
        undefined -> false;
        Rd -> Rd
    end.

set_player_getting_reward(PlayerId, Info) ->
    erlang:put({?PDKN_PLAYER_GETTING_REWARD, PlayerId}, Info).


erase_player_getting_reward(PlayerId) ->
    erlang:erase({?PDKN_PLAYER_GETTING_REWARD, PlayerId}).
    

%% return [{GoodsNo, GoodsCount, Quality, BindState, Flag} ...] | []
mk_new_goods_list(PlayerId) ->
    case get_player_bt_ret(PlayerId) of
        null -> 
            ?ERROR_MSG("mod_tve_mgr:mk_new_goods_list error!~n", []),
            [];
        {WinWave, _Rounds} ->
            LvStep = get_player_enter_lv_step(PlayerId),
            case data_tve:get(LvStep) of
                null ->
                    ?ERROR_MSG("mod_tve_mgr:mk_new_goods_list data cfg error!LvStep:~p~n", [LvStep]),
                    [];
                DataCfg ->
                    PS = 
                        case player:get_PS(PlayerId) of
                            null -> ply_tmplogout_cache:get_tmplogout_PS(PlayerId);
                            TPS -> TPS
                        end,

                    ExtraCount = 
                        case PS =:= null of
                            true -> 0;
                            false ->
                                case lib_vip:welfare(tve_extra_reward_time, PS) of
                                    null -> 0;
                                    TTime -> TTime
                                end
                        end,

                    case WinWave =:= DataCfg#tve_cfg.max_wave of
                        true ->
							mod_achievement:notify_achi(pass_binglin, [{num, WinWave}], PS),
                            mk_new_goods_list(LvStep, [], WinWave, 0) ++ rand_get_goods_list(DataCfg#tve_cfg.goods_extra, 2) ++ mk_new_goods_list(LvStep, [], ExtraCount, 1);
                        false ->
                            case WinWave =:= 0 of
                                true -> [];
                                false -> mk_new_goods_list(LvStep, [], WinWave, 0) ++ mk_new_goods_list(LvStep, [], ExtraCount, 1)
                            end
                    end
            end
    end.

mk_new_goods_list(_LvStep, RetList, 0, _Flag) ->
    RetList;
mk_new_goods_list(LvStep, RetList, Count, Flag) ->
    case data_tve:get(LvStep) of
        null ->
            ?ERROR_MSG("mod_tve_mgr:mk_new_goods_list data cfg error!~n", []),
            [];
        DataCfg ->
            Type = rand_get_reward_type(DataCfg),
            OneList = 
                if
                    Type =:= null ->
                        [];
                    Type =:= bind_gamemoney ->
                        rand_get_goods_list(DataCfg#tve_cfg.bind_gamemoney, Flag);
                    Type =:= gamemoney ->
                        rand_get_goods_list(DataCfg#tve_cfg.gamemoney, Flag);
                    Type =:= goods ->
                        rand_get_goods_list(DataCfg#tve_cfg.goods, Flag);
                    Type =:= exp ->
                        rand_get_goods_list(DataCfg#tve_cfg.exp, Flag);
                    Type =:= par_exp ->
                        rand_get_goods_list(DataCfg#tve_cfg.par_exp, Flag);
                    true -> []
                end,
            mk_new_goods_list(LvStep, RetList ++ OneList, Count-1, Flag)
    end.



%% return [{GoodsNo, Count, Quality, BindState, Flag}]
rand_get_goods_list(ProbList, Flag) ->
    F = fun({_GoodsNo, _Count, Prob}, Sum) ->
        Sum + Prob
    end,
    Range = lists:foldl(F, 0, ProbList),
    RandNum = util:rand(1, Range),
    rand_get_goods_list(ProbList, RandNum, 0, Flag).


rand_get_goods_list([], _, _, _Flag) ->
    [];
rand_get_goods_list([{GoodsNo, Count, Prob} | T], RandNum, SumToCompare, Flag) ->
    SumToCompare_2 = Prob + SumToCompare,
    case RandNum =< SumToCompare_2 of
        true -> 
            [{GoodsNo, Count, lib_goods:get_quality(lib_goods:get_tpl_data(GoodsNo)), ?BIND_ALREADY, Flag}];
        false ->
            rand_get_goods_list(T, RandNum, SumToCompare_2, Flag)
    end.


rand_get_reward_type(DataCfg) ->
    F = fun({_Type, Prob}, Sum) ->
        Sum + Prob
    end,
    Range = lists:foldl(F, 0, DataCfg#tve_cfg.reward_type),
    RandNum = util:rand(1, Range),
    rand_get_reward_type(DataCfg#tve_cfg.reward_type, RandNum, 0).


rand_get_reward_type([], _, _) ->
    null;
rand_get_reward_type([{Type, Prob} | T], RandNum, SumToCompare) ->
    SumToCompare_2 = Prob + SumToCompare,
    case RandNum =< SumToCompare_2 of
        true -> 
            ?DEBUG_MSG("mod_tve_mgr:rand_get_reward_type RandNum:~p,Type:~p~n", [RandNum, Type]),
            Type;
        false -> rand_get_reward_type(T, RandNum, SumToCompare_2)
    end.


mk_refresh_money(PlayerId) ->
    case get_player_enter_lv_step(PlayerId) of
        null ->
            ?ERROR_MSG("mod_tve_mgr:get_player_enter_lv_step error!~n", []),
            {?MNY_T_YUANBAO, 40 + 1*20};
        LvStep ->
            case LvStep =:= ?INVALID_NO of
                true ->
                    ?ERROR_MSG("mod_tve_mgr:mk_refresh_money error! PlayerId:~p~n", [PlayerId]),
                    {?MNY_T_YUANBAO, 40 + 1*20};
                false ->   
                    Count = get_player_refresh_reward_cnt(PlayerId),
                    {?MNY_T_YUANBAO, util:ceil((data_tve:get(LvStep))#tve_cfg.base + (data_tve:get(LvStep))#tve_cfg.coef * Count)}
            end
    end.


update_rank(LeaderPS, MbIdList, FactionL, WinWave, Rounds) ->
    LvStep = get_player_enter_lv_step(player:id(LeaderPS)),
    TveRank = #tve_rank{
        leader_name = player:get_name(LeaderPS),
        leader_vip_lv = player:get_vip_lv(LeaderPS),
        faction_list = FactionL,
        id_list = MbIdList,
        win = WinWave,
        rounds = Rounds
        },

    case mod_tve:get_tve_from_ets(LvStep) of
        null ->
            NewTve = #tve{lv_step = LvStep, rank = [TveRank]},
            ?DEBUG_MSG("mod_tve_mgr:add_tve_to_ets...~n", []),
            mod_tve:add_tve_to_ets(NewTve);
        TveRd ->
            F = fun(R1, R2) ->
                if
                    R1#tve_rank.win > R2#tve_rank.win -> true;
                    R1#tve_rank.win < R2#tve_rank.win -> false;
                    true -> R1#tve_rank.rounds < R2#tve_rank.rounds
                end
            end,

            RankL = TveRd#tve.rank,
            case length(RankL) <   10 of
                true ->
                    RankL1 = 
                        case lists:keyfind(TveRank#tve_rank.leader_name, 1, RankL) of
                            false -> [TveRank | RankL];
                            OldTveRank -> 
                                case mb_same(TveRank#tve_rank.id_list, OldTveRank#tve_rank.id_list) of
                                    true -> %% 所有成员一样
                                        case (TveRank#tve_rank.win > OldTveRank#tve_rank.win) orelse 
                                            (TveRank#tve_rank.win =:= OldTveRank#tve_rank.win andalso TveRank#tve_rank.rounds < OldTveRank#tve_rank.rounds) of
                                            true ->
                                                lists:keyreplace(TveRank#tve_rank.leader_name, 1, RankL, TveRank);
                                            false -> RankL
                                        end;
                                    false -> %% 参加成员不一样
                                        [TveRank | RankL]
                                end
                        end,

                    NewRank = lists:sort(F, RankL1),
                    TveRd1 = TveRd#tve{rank = NewRank},
                    mod_tve:update_tve_to_ets(TveRd1);
                false ->
                    LastRank = lists:last(RankL),
                    RankL1 = 
                        case (TveRank#tve_rank.win > LastRank#tve_rank.win) orelse 
                            (TveRank#tve_rank.win =:= LastRank#tve_rank.win andalso TveRank#tve_rank.rounds < LastRank#tve_rank.rounds) of
                            true -> %% 需要插入或者更新某个排名的信息
                                case lists:keyfind(TveRank#tve_rank.leader_name, 1, RankL) of
                                    false ->
                                        TRankL = RankL -- [LastRank],
                                        [TveRank | TRankL];
                                    OldTveRank ->
                                        case mb_same(TveRank#tve_rank.id_list, OldTveRank#tve_rank.id_list) of
                                            true -> %% 所有成员一样
                                                lists:keyreplace(TveRank#tve_rank.leader_name, 1, RankL, TveRank);
                                            false ->
                                                TRankL = RankL -- [LastRank],
                                                [TveRank | TRankL]
                                        end
                                end;
                            false ->
                                RankL
                        end,

                    NewRank = lists:sort(F, RankL1),
                    TveRd1 = TveRd#tve{rank = NewRank},
                    mod_tve:update_tve_to_ets(TveRd1)
            end
    end.


get_cost_goods_list(PlayerId, LvStep) ->
    EnterTime = mod_tve:get_player_enter_time(PlayerId),
    Data = data_tve:get(LvStep),
    FreeTime = Data#tve_cfg.times,
    GoodsNo = Data#tve_cfg.use_goods_no,
    case EnterTime >= FreeTime of
        true -> [{GoodsNo, 1}];
        false -> []
    end.


mb_same(IdL1, IdL2) ->
    case length(IdL1) =:= length(IdL2) of
        false -> false;
        true -> lists:sort(IdL1) =:= lists:sort(IdL2)
    end.

%% GoodsList : {GoodsNo, GoodsCount, Quality, BindState, Flag}
adust_goods_list_for_mail(GoodsList) ->
    GoodsList2 = [{GoodsNo, GoodsCount, BindState} || {GoodsNo, GoodsCount, _Quality, BindState, _Flag} <- GoodsList],
    GoodsList3 = mod_inv:arrange_goods_list(GoodsList2),
    [{GoodsNo, BindState, GoodsCount} || {GoodsNo, GoodsCount, BindState} <- GoodsList3].

pick_team_id([]) ->
    ?INVALID_ID;
pick_team_id([PlayerId | T]) ->
    case player:get_PS(PlayerId) of
        null ->
            pick_team_id(T);
        PS ->
            case player:get_team_id(PS) =:= ?INVALID_ID of
                false -> player:get_team_id(PS);
                true -> pick_team_id(T)
            end
    end.


try_give_last_reward(PlayerId) ->
    case get_player_reward(PlayerId) of
        null ->
            skip;
        GoodsL ->
            case is_player_getting_reward(PlayerId) of
                true -> skip;
                false ->
                    GoodsList1 = adust_goods_list_for_mail(GoodsL),
                    case GoodsList1 =:= [] of
                        true -> skip;
                        false -> lib_mail:send_sys_mail(PlayerId, <<"兵临城下奖励">>, <<"主人，您没有手动领取上轮兵临城下系统奖励，通过邮件发送给您，请查收！">>, GoodsList1, [?LOG_DUNGEON, "tve"])
                    end
            end
    end.

try_send_tips(PlayerId) ->
    case get_player_reward(PlayerId) of
        null -> skip;
        GoodsL ->
            case player:get_PS(PlayerId) of
                null -> skip;
                PS ->
                    [
                        ply_tips:send_sys_tips(PS, {get_goods_quality_tve, [player:get_name(PS), player:id(PS), GoodsNo, Quality, GoodsCount , 0]})
                        || 
                        {GoodsNo, GoodsCount, Quality, _BindState, _Flag} <- GoodsL, Quality >= ?QUALITY_PURPLE
                    ]
            end
    end.