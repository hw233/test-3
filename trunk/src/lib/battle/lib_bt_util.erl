%%%-------------------------------------- 
%%% @Module: lib_bt_util
%%% @Author: huangjf
%%% @Created: 2013.12.5
%%% @Description: 战斗系统相关的工具性的函数
%%%-------------------------------------- 


-module(lib_bt_util).
-export([
        test_proba/1,

        open_battle_log_file/1,
        close_battle_log_file/0,
        write_battle_log_file/1,

        dbg_check_phy_dam_details/1,
        dbg_check_mag_dam_details/1

        
    ]).
    
-include("common.hrl").
-include("battle.hrl").
-include("record/battle_record.hrl").









%% 测试一次概率
%% @para： Proba => 注意是放大了1000倍的整数
%% @return: success | fail
test_proba(Proba) when Proba > ?PROBABILITY_BASE ->  % 容错
    ?ERROR_MSG("[lib_bt_util] test_proba() error!! Proba:~p", [Proba]),
    success;
test_proba(Proba) when Proba < 0 ->  % 容错
    fail;
test_proba(Proba) ->
    ?ASSERT(util:is_nonnegative_int(Proba), Proba),
    Proba2 = Proba / ?PROBABILITY_BASE,
    case util:decide_proba_once(Proba2) of
        success -> success;
        fail -> fail
    end.








-define(BATTLE_LOG_BASE_DIR, "e:/__battle_log__/").


get_today_battle_log_dir() ->
    {Y, M, D} = erlang:date(),
    YMD = "__" ++ integer_to_list(Y) ++ "_" ++ integer_to_list(M) ++ "_" ++ integer_to_list(D) ++ "__",
    ?BATTLE_LOG_BASE_DIR ++ YMD ++ "/".


%% 打开战斗日志文件，注意：目前只适用于windows平台！
%% 注意：限战斗进程内调用
%% @return: ok | error
open_battle_log_file(BattleId) ->
    Dir = get_today_battle_log_dir(),
    ?TRACE("~n~n~n!!!!!!!!!!Dir: ~p~n~n~n", [Dir]),
    MakeDirRes = file:make_dir(Dir),
    case MakeDirRes == ok orelse MakeDirRes == {error, eexist} of
        false ->
            ?DEBUG_MSG("open_battle_log_file(), make dir failed!!! BattleId=~p, Error=~w", [BattleId, MakeDirRes]),
            error;
        true ->
            FileName = Dir ++ "battle_log_" ++ integer_to_list(BattleId),
            case file:open(FileName, [append, raw]) of
                {ok, FileDesc} ->
                    lib_bt_dict:set_battle_log_file_fd(FileDesc),
                    ok;
                _Error ->
                    ?DEBUG_MSG("open_battle_log_file(), open file failed!!! BattleId=~p, Error=~w", [BattleId, _Error]),
                    error
            end
    end.

            


%% 关闭战斗日志文件
%% 注意：限战斗进程内调用
close_battle_log_file() ->
    Fd = lib_bt_dict:get_battle_log_file_fd(),
    file:close(Fd).

% open() ->
%     {ok, FileDesc} = open_file("e:/battle.log"),
%     put(file_desc, FileDesc),
%     {ok, FileDesc}.



%% 写战斗日志文件
%% 注意：限战斗进程内调用
write_battle_log_file(String) ->
    Fd = lib_bt_dict:get_battle_log_file_fd(),
    file:write(Fd, String).





 
-ifdef(debug).
    
    %% debug版本下通过断言来检测物理伤害详情是否有错
    dbg_check_phy_dam_details(DamDtl) ->
        ?ASSERT(DamDtl#phy_dam_dtl.atter_hp_left >= 0, DamDtl),
        ?ASSERT(DamDtl#phy_dam_dtl.defer_hp_left >= 0, DamDtl),
        ?ASSERT(DamDtl#phy_dam_dtl.protector_hp_left >= 0, DamDtl),
        case DamDtl#phy_dam_dtl.atter_hp_left == 0 of
            true ->
                ?ASSERT(DamDtl#phy_dam_dtl.atter_die_status /= ?DIE_STATUS_LIVING, DamDtl);
            false ->
                ?ASSERT(DamDtl#phy_dam_dtl.atter_die_status == ?DIE_STATUS_LIVING, DamDtl)
        end,

        case DamDtl#phy_dam_dtl.defer_hp_left == 0 of
            true ->
                ?ASSERT(DamDtl#phy_dam_dtl.defer_die_status /= ?DIE_STATUS_LIVING, DamDtl);
            false ->
                ?ASSERT(DamDtl#phy_dam_dtl.defer_die_status == ?DIE_STATUS_LIVING, DamDtl)
        end,

        case (DamDtl#phy_dam_dtl.protector_id /= ?INVALID_ID) andalso (DamDtl#phy_dam_dtl.protector_hp_left == 0) of
            true ->
                ?ASSERT(DamDtl#phy_dam_dtl.protector_die_status /= ?DIE_STATUS_LIVING, DamDtl);
            false ->
                ?ASSERT(DamDtl#phy_dam_dtl.protector_die_status == ?DIE_STATUS_LIVING, DamDtl)
        end.

    %% debug版本下通过断言来检测法术伤害详情是否有错
    dbg_check_mag_dam_details(DamDtl) ->
        ?ASSERT(DamDtl#mag_dam_dtl.atter_hp_left >= 0, DamDtl),
        ?ASSERT(DamDtl#mag_dam_dtl.defer_hp_left >= 0, DamDtl),
        case DamDtl#mag_dam_dtl.atter_hp_left == 0 of
            true ->
                ?ASSERT(DamDtl#mag_dam_dtl.atter_die_status /= ?DIE_STATUS_LIVING, DamDtl);
            false ->
                ?ASSERT(DamDtl#mag_dam_dtl.atter_die_status == ?DIE_STATUS_LIVING, DamDtl)
        end,

        case DamDtl#mag_dam_dtl.defer_hp_left == 0 of
            true ->
                ?ASSERT(DamDtl#mag_dam_dtl.defer_die_status /= ?DIE_STATUS_LIVING, DamDtl);
            false ->
                ?ASSERT(DamDtl#mag_dam_dtl.defer_die_status == ?DIE_STATUS_LIVING, DamDtl)
        end.

-else.

    dbg_check_phy_dam_details(_DamDtl) ->  do_nothing.
    dbg_check_mag_dam_details(_DamDtl) ->  do_nothing.

-endif.




