%%%-------------------------------------- 
%%% @Module: mod_hire
%%% @Author: zwq
%%% @Created: 2013.12.30
%%% @Description: 玩家雇佣天将
%%%-------------------------------------- 

-module(mod_hire).

-export([
        init/0,
        get_hire_from_ets/1,       %% 获取天将信息
        add_hire_to_ets/1,
        update_hire_to_ets/1,
        del_hire_from_ets/1,

        get_hirer_from_ets/1,       %% 获取雇主信息
        add_hirer_to_ets/1,
        update_hirer_to_ets/1,
        del_hirer_from_ets/1,

        db_save_hire/1,             %% 保存可以供雇佣的天将数据
        db_insert_new_hire/1,
        db_delete_hire/1,

        db_save_hirer/1,            %% 保存雇主雇佣情况信息数据
        db_insert_new_hirer/1,
        db_delete_hirer/1,

        db_load_hirer_info/1,
        db_load_hire_info/0,

        set_job_schedule/0,         %% 设置作业计划 
        on_job_schedule/0           %% 0点处理作业计划：数据清空 以及投递下一个作业计划
    ]).


-include("hire.hrl").
-include("ets_name.hrl").
-include("debug.hrl").
-include("job_schedule.hrl").
-include("common.hrl").
-include("sys_code.hrl").
-include("pt_41.hrl").

init() ->
    db_load_hire_info(),
    set_job_schedule().
    

add_hire_to_ets(Hire) when is_record(Hire, hire) ->
    true = ets:insert_new(?ETS_HIRE, Hire).


get_hire_from_ets(PlayerId) ->
    case ets:lookup(?ETS_HIRE, PlayerId) of
          [] ->
               null;
          [Hire] ->
               Hire
     end.


update_hire_to_ets(Hire) when is_record(Hire, hire) ->
    ets:insert(?ETS_HIRE, Hire).


del_hire_from_ets(PlayerId) ->
    ets:delete(?ETS_HIRER, PlayerId).


get_hirer_from_ets(PlayerId) ->
    case ets:lookup(?ETS_HIRER, PlayerId) of
        [] ->
            null;
        [Hirer] ->
            Hirer
    end.
    

add_hirer_to_ets(Hire) when is_record(Hire, hirer) ->
    ets:insert(?ETS_HIRER, Hire).


update_hirer_to_ets(Hire) when is_record(Hire, hirer) ->
    ets:insert(?ETS_HIRER, Hire).


del_hirer_from_ets(PlayerId) ->
    ets:delete(?ETS_HIRER, PlayerId).


db_save_hire(Hire) ->
    % BS:表示bitstring
    HireHistory_BS = util:term_to_bitstring(Hire#hire.hire_history),

    db:update(?DB_SYS, hire, ["left_time", "price", "hire_history", "get_income"], 
                     [Hire#hire.left_time, Hire#hire.price, HireHistory_BS, Hire#hire.get_income],
                    "id",
                    Hire#hire.id
            ).

db_insert_new_hire(Hire) ->
    % BS:表示bitstring
    ParList_BS = util:term_to_bitstring(Hire#hire.par_list),
    HireHistory_BS = util:term_to_bitstring(Hire#hire.hire_history),

    db:insert_get_id(hire, ["id", "name", "lv", "faction", "battle_power", "left_time", "price", "par_list", "hire_history", "get_income", "sex"],
                     [Hire#hire.id, Hire#hire.name, Hire#hire.lv, Hire#hire.faction, Hire#hire.battle_power, Hire#hire.left_time, 
                      Hire#hire.price, ParList_BS, HireHistory_BS, Hire#hire.get_income, Hire#hire.sex]
                    ).


db_delete_hire(PlayerId) ->
    db:delete(?DB_SYS, hire, [{id, PlayerId}]).


db_delete_all_hire() ->
    db:delete(?DB_SYS, hire, []).


db_save_hirer(Hirer) ->
    db:update(Hirer#hirer.id, hirer, ["left_time", "is_fight"], 
                     [Hirer#hirer.left_time, Hirer#hirer.is_fight],
                    "id",
                    Hirer#hirer.id
            ).


db_insert_new_hirer(Hirer) ->
    % BS:表示bitstring
    HireParList_BS = util:term_to_bitstring(Hirer#hirer.hire_par_list),

    db:insert_get_id(hirer, ["id", "hire_id", "hire_name", "hire_lv", "hire_battle_power", "left_time", "hire_par_list", "is_fight", "hire_sex", "hire_faction"],
                     [Hirer#hirer.id, Hirer#hirer.hire_id, Hirer#hirer.hire_name, Hirer#hirer.hire_lv, Hirer#hirer.hire_battle_power, Hirer#hirer.left_time, 
                      HireParList_BS, Hirer#hirer.is_fight, Hirer#hirer.hire_sex, Hirer#hirer.hire_faction]
                    ).


db_delete_hirer(PlayerId) ->
    db:delete(PlayerId, hirer, [{id, PlayerId}]).


db_delete_all_hirer() ->
    db:delete(?DB_SYS, hirer, []).


db_load_hire_info() ->
    case db:select_all(hire, "id, name, lv, faction, battle_power, left_time, price, par_list, hire_history, get_income, sex", []) of
        InfoList_List when is_list(InfoList_List) ->
            F = fun(InfoList) ->
                    Hire = to_hire_record(InfoList),
                    add_hire_to_ets(Hire)
                end,
            lists:foreach(F, InfoList_List);
        _Any ->
            ?ASSERT(false, _Any),
            []
    end.


set_job_schedule() ->
    DelayTime = 24*3600 - (svr_clock:get_unixtime() - util:calc_today_0_sec()) + 45,
    mod_ply_jobsch:add_schedule(?JSET_CLEAR_HIRE_DATA, DelayTime, []).


set_job_schedule(DelayTime) ->
    mod_ply_jobsch:add_schedule(?JSET_CLEAR_HIRE_DATA, DelayTime, []).


on_job_schedule() ->
    ?CRITICAL_MSG("[mod_hire] on_job_schedule...", []),
    set_job_schedule(24*3600),
    HireList = ets:tab2list(?ETS_HIRE),
    HirerList = ets:tab2list(?ETS_HIRER),

    db_delete_all_hire(),
    db_delete_all_hirer(),

    ets:delete_all_objects(?ETS_HIRE),
    ets:delete_all_objects(?ETS_HIRER),

    %% 推送信息
    F = fun(X) ->
        mod_offline_data:db_del_offline_bo(X#hire.id, ?OBJ_PLAYER, ?SYS_HIRE),
        [mod_offline_data:db_del_offline_bo(Y#par_brief.id, ?OBJ_PARTNER, ?SYS_HIRE) || Y <- X#hire.par_list],
        %% 推送信息
        case player:get_PS(X#hire.id) of
            null -> skip;
            PS ->
                {ok, BinData} = pt_41:write(?GET_PLAYER_HIRED_INFO, [PS, null]),
                lib_send:send_to_sock(PS, BinData)
        end
    end,
    lists:foreach(F, HireList),

    F1 = fun(X) ->
        case player:get_PS(X#hirer.id) of
            null -> skip;
            PS ->
                {ok, BinData} = pt_41:write(?FIRE_MY_HIRE, [?RES_OK]),
                lib_send:send_to_sock(PS, BinData)
        end
    end,
    lists:foreach(F1, HirerList).
    

%% -----------------------------------------------------------------------Local fun -----------------------------------------


db_load_hirer_info(PlayerId) ->
    case db:select_row(hirer, "id, hire_id, hire_name, hire_lv, hire_battle_power, left_time, hire_par_list, is_fight, hire_sex, hire_faction", 
    [{id, PlayerId}], [], [1]) of
        InfoList when is_list(InfoList) ->
            case InfoList /= [] of
                true ->
                    Hirer = to_hirer_record(InfoList),
                    add_hirer_to_ets(Hirer);
                false ->
                    skip
            end;
        _Any ->
            ?ASSERT(false, _Any),
            []
    end.


to_hire_record(InfoList) ->
    [Id, Name, Lv, Faction, BattlePower, LeftTime, Price, ParList_BS, HireHistory_BS, GetIncome, Sex] = InfoList,
    #hire{
        id = Id,
        name = Name,
        lv = Lv,
        faction = Faction,
        battle_power = BattlePower,
        left_time = LeftTime,
        price = Price,
        par_list = case util:bitstring_to_term(ParList_BS) of undefined -> []; ParList -> ParList end,
        hire_history = case util:bitstring_to_term(HireHistory_BS) of undefined -> []; HireHistory -> HireHistory end,
        get_income = GetIncome, 
        sex = Sex
    }.


to_hirer_record(InfoList) ->
    [Id, HireId, HireName, HireLv, HireBattlePower, LeftTime, HireParList_BS, IsFight, HireSex, HireFaction] = InfoList,
    #hirer{
        id = Id,
        hire_id = HireId, 
        hire_name = HireName,
        hire_lv = HireLv,
        hire_battle_power = HireBattlePower,
        left_time = LeftTime,
        hire_par_list = case util:bitstring_to_term(HireParList_BS) of undefined -> []; HireParList -> HireParList end,
        is_fight = IsFight, 
        hire_sex = HireSex, 
        hire_faction = HireFaction
    }.