%%%------------------------------------
%%% @Module  : mod_battle_mgr
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2013.7.31
%%% @Description: 战斗管理
%%%------------------------------------
-module(mod_battle_mgr).
-behaviour(gen_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([start_link/0, 
        create_battle/1,
        destroy_battle/2,
        get_battle_pid_by_id/1,
        del_battle_create_log/1,

        on_server_clock_tick/2
        
        ]).

-include("common.hrl").
%%-include("record.hrl").
-include("record/battle_record.hrl").
-include("ets_name.hrl").
-include("server_misc.hrl").
-include("fabao.hrl").
-include("prompt_msg_code.hrl").


-record(state, {auto_id}).

%% 战斗id的起始值
-define(BATTLE_ID_START, 1).


start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).





%% 创建战斗
%% @return: {ok, 新战斗的id，新战斗的进程pid} | fail
create_battle(PlayerId) ->
    {ok, NewBattleId} = gen_server:call(?MODULE, 'get_next_id'),
    {ok, NewBattlePid} = mod_battle:start(NewBattleId),
    %%消耗灵力wjc
    try begin
            case lib_fabao:get_fabao_battle(PlayerId) of
                [] -> [];
                FaBaoId ->
                    case lib_fabao:get_fabao_info(FaBaoId) of
                        [] ->
                            lib_send:send_prompt_msg(PlayerId, ?PM_NO_HAVE_THIS),
                            [];
                        RecordData  ->
                            %%灵力值
                            OldSpValue = RecordData#fabao_info.sp_value,
                            case OldSpValue >= 5 of
                                true ->
                                    {ok,Bin} = pt_45:write( 45007,[RecordData#fabao_info.id, OldSpValue- 5]),
                                    lib_send:send_to_uid(PlayerId, Bin),
                                    lib_fabao:update_fabao_info(RecordData#fabao_info{sp_value = OldSpValue- 5});
                                false ->
                                    skip
                            end,
                            %%如果灵力值小于十五加个998提示灵力值不足将卸下
                            case OldSpValue < 16 of
                                true ->
                                    lib_send:send_prompt_msg(PlayerId,?PM_FABAO_NO_ENOUGH_SP);
                                false ->
                                    skip
                            end
                    end
            end
        end
    catch T: R ->
        ?ERROR_MSG("[mod_battle_mgr] fabao SPValue occur error:~p", [{T, R }])
    end,
    add_battle_create_log(PlayerId, NewBattleId, NewBattlePid),
    {ok, NewBattleId, NewBattlePid}.


%% 清除战斗
destroy_battle(BattleId, Reason) ->
    BattlePid = get_battle_pid_by_id(BattleId),
    ?ASSERT(is_pid(BattlePid), BattlePid),
    mod_battle:stop(BattlePid, Reason),
    del_battle_create_log(BattleId),
    ok.


%% @return: null | 战斗进程pid
get_battle_pid_by_id(BattleId) ->
    case ets:lookup(?ETS_BATTLE_CREATE_LOG, BattleId) of
        [] -> null;
        [R] -> R#btl_create_log.battle_pid
    end.



%% 每隔xx毫秒清理残余的战斗（出现残余战斗其实表明程序有bug！！）
-define(CLEAN_BAD_BATTLE_INTV, (150 * 1000)).


on_server_clock_tick(CurTickCount, _CurUnixTime) ->
    case CurTickCount rem (?CLEAN_BAD_BATTLE_INTV div ?SERVER_CLOCK_TICK_INTV) of
        0 ->
            gen_server:cast(?MODULE, {'on_server_clock_tick', CurTickCount});
        _ ->
            skip
    end.



%% ===================================================================================================
    
init([]) ->
    process_flag(trap_exit, true),
    State = #state{auto_id = ?BATTLE_ID_START},
    {ok, State}.



handle_cast({'on_server_clock_tick', _CurTickCount} , State) ->
    ?TRY_CATCH(check_and_clean_bad_battle(), ErrReason),
    {noreply, State};


handle_cast(_R , State) ->
    ?ASSERT(false, _R),
    {noreply, State}.


%% 获取新战斗的id
handle_call('get_next_id', _From, State) ->
    AutoId = State#state.auto_id,
    {reply, {ok, AutoId}, State#state{auto_id = AutoId + 1}};
    



handle_call(_R , _From, State) ->
    ?ASSERT(false, _R),
    {reply, ok, State}.

% %%todo:查询mid为none的怪物重新启动
% handle_info({'EXIT', _Mid, _Reason}, State) ->
%     {noreply, State};

handle_info(_Reason, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra)->
	{ok, State}.





add_battle_create_log(PlayerId, NewBattleId, NewBattlePid) ->
    R = #btl_create_log{
            battle_id = NewBattleId,
            battle_pid = NewBattlePid,
            create_date = erlang:date(),
            create_time = erlang:time(),
            create_unixtime = svr_clock:get_unixtime(),
            creator = PlayerId
            },
    true = ets:insert_new(?ETS_BATTLE_CREATE_LOG, R).




del_battle_create_log(BattleId) ->
    ets:delete(?ETS_BATTLE_CREATE_LOG, BattleId).



%% 检查并清除残余的战斗（如果有的话）
check_and_clean_bad_battle() ->
    L = ets:tab2list(?ETS_BATTLE_CREATE_LOG),
    TimeNow = svr_clock:get_unixtime(),
    check_and_clean_bad_battle(L, TimeNow).


check_and_clean_bad_battle([BtlCreateLog | T], TimeNow) ->
    do_check_and_clean_one_bad_battle(BtlCreateLog, TimeNow),
    check_and_clean_bad_battle(T, TimeNow);

check_and_clean_bad_battle([], _TimeNow) ->
    done.



-define(MAX_BATTLE_LASTING_TIME, (3600 + 30)).  % 服务端比客户端稍快，故额外加30秒

do_check_and_clean_one_bad_battle(BtlCreateLog, TimeNow) ->
    case (TimeNow - BtlCreateLog#btl_create_log.create_unixtime) > ?MAX_BATTLE_LASTING_TIME of
        true ->
            destroy_battle(BtlCreateLog#btl_create_log.battle_id, normal),
            ?ERROR_MSG("[mod_battle_mgr] residual battle!!! BtlCreateLog:~w", [BtlCreateLog]);
        false ->
            skip
    end.
