%%%-------------------------------------- 
%%% @Module: ply_hire
%%% @Author: zwq
%%% @Created: 2013.12.30
%%% @Description: 玩家雇佣天将 （存在并发问题的都统一放到 mod_hire_mgr 进程完成 todo）
%%%-------------------------------------- 

-module(ply_hire).

-export([
        get_hire_list/5,                    %% 获取天将列表
        employ_hire/4,
        get_hired_info/1,                   %% 获取自己的被雇佣情况
        sign_up/2,
        get_income/1,
        get_my_hire/1,                      %% 获取我的天将信息
        get_my_hire_time/1,                 %% 获取我的天将的助战次数 如果没有天将返回0
        fight_my_hire/1,
        rest_my_hire/1,
        fire_my_hire/1,
        change_price/2,                     %% 修改价格
        update_info/1,                      %% 更新天将信息

        has_fighting_hired_player/1,        %% 是否有出战的天将
        get_fighting_hired_player_id/1,     %% 获取我的天将id

        has_hired_player/1,                 %% 是否雇佣了天将
        has_been_hire/1,                    %% 是否是天将了

        db_try_save_hirer/1,

        on_vip_lv_up/2,                     %% vip等级上升
        try_update_hired_player/1,          %% 更新玩家的雇佣信息
        battle_feedback/1                   %% 玩家战斗反馈
    ]).

-include("hire.hrl").
-include("prompt_msg_code.hrl").
-include("hire.hrl").
-include("ets_name.hrl").
-include("common.hrl").
-include_lib("stdlib/include/ms_transform.hrl").
-include("record/battle_record.hrl").
-include("pt_41.hrl").
-include("abbreviate.hrl").
-include("faction.hrl").
-include("log.hrl").
-include("sys_code.hrl").


%% return {Len, L} 
get_hire_list(PS, Faction, StartIndex, EndIndex, SortType) ->
    case check_get_hire_list(PS, Faction, StartIndex, EndIndex, SortType) of
        {fail, _Reason} ->
            {0, []};
        ok ->
            do_get_hire_list(PS, Faction, StartIndex, EndIndex, SortType)
    end.


employ_hire(PS, ObjPlayerId, Count, Price) ->
    case check_employ_hire(PS, ObjPlayerId, Count, Price) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, Hire} ->
            do_employ_hire(PS, Hire, Count)
    end.


get_hired_info(PS) ->
    case check_get_hired_info(PS) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, Hire} ->
            do_get_hired_info(PS, Hire)
    end.


sign_up(PS, Price) ->
    case check_sign_up(PS, Price) of
        {fail, Reason} ->
            {fail, Reason};
        ok ->
            do_sign_up(PS, Price)
    end.


get_income(PS) ->
    case check_get_income(PS) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, Hire, CanGet, SumTime} ->
            do_get_income(PS, Hire, CanGet, SumTime)
    end.


% return {fail, Reason} | {ok, Hirer}
get_my_hire(PS) ->
    case check_get_my_hire(PS) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, Hirer} ->
            do_get_my_hire(PS, Hirer)
    end.


get_my_hire_time(PS) ->
    case get_my_hire(PS) of
        {fail, _Reason} -> 0;
        {ok, Hirer} -> Hirer#hirer.left_time
    end.

fight_my_hire(PS) ->
    case check_fight_my_hire(PS) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, Hirer} ->
            do_fight_my_hire(PS, Hirer)
    end.


rest_my_hire(PS) ->
    case check_rest_my_hire(PS) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, Hirer} ->
            do_rest_my_hire(PS, Hirer)
    end.


fire_my_hire(PS) ->
    case check_fire_my_hire(PS) of
        {fail, Reason} ->
            {fail, Reason};
        ok ->
            do_fire_my_hire(PS)
    end.

%% 传入最新的PS
update_info(PS) ->
    case mod_hire:get_hire_from_ets(player:get_id(PS)) of
        null -> skip;
        Hire ->
            NewHire = Hire#hire{
                    name = player:get_name(PS)
                    },

            mod_hire:update_hire_to_ets(NewHire),
            mod_hire:db_save_hire(NewHire),
            db_update_role_offline_bo_for_hire(PS)
    end.


change_price(PS, Price) ->
    case Price > 0 andalso Price =< 100000 of
        false -> 
            {fail, ?PM_PARA_ERROR};
        true ->
            case mod_hire:get_hire_from_ets(player:get_id(PS)) of
                null ->
                    {fail, ?PM_HAVE_NOT_SIGN_UP};
                Hire ->
                    case Hire#hire.change_price_count >= ?CHANGE_PRICE_COUNT_DAY of
                        true ->
                            {fail, ?PM_PRICE_CHANGE_COUNT_LIMIT};
                        false ->
                            F = fun(X, Acc) ->
                                Partner = lib_partner:get_partner(X),
                                NewParBrief = 
                                    #par_brief{
                                        id = X,
                                        no = lib_partner:get_no(Partner),
                                        name = lib_partner:get_name(Partner),
                                        lv = lib_partner:get_lv(Partner),
                                        position = lib_partner:get_position(Partner),
                                        battle_power = lib_partner:get_battle_power(Partner)
                                    },

                                case lists:keyfind(X, 1, Acc) of
                                    false -> [NewParBrief | Acc];
                                    _ -> lists:keyreplace(X, 1, Acc, NewParBrief)
                                end
                            end,

                            NewHire = Hire#hire{
                                price = Price, 
                                change_price_count = Hire#hire.change_price_count + 1, 
                                battle_power = ply_attr:get_battle_power(PS),
                                faction = player:get_faction(PS),   %修改门派信息
                                par_list = lists:foldl(F, Hire#hire.par_list, player:get_partner_id_list(PS))
                                },

                            mod_hire:update_hire_to_ets(NewHire),
                            mod_hire:db_save_hire(NewHire),
                            db_update_role_offline_bo_for_hire(PS),
                            {ok, ?CHANGE_PRICE_COUNT_DAY - NewHire#hire.change_price_count}
                    end
            end
    end.

%% return true | false
has_fighting_hired_player(PS) when is_record(PS, player_status) ->
    case get_my_hire(PS) of
        {fail, _Reason} ->
            false;
        {ok, Hirer} ->
            Hirer#hirer.is_fight =:= ?FIGHT_STATE andalso Hirer#hirer.left_time > 0
    end.

%% return PlayerId | ?INVALID_ID
get_fighting_hired_player_id(PS) when is_record(PS, player_status) ->
    case get_my_hire(PS) of
        {fail, _Reason} ->
            ?INVALID_ID;
        {ok, Hirer} ->
            case Hirer#hirer.is_fight =:= ?FIGHT_STATE andalso Hirer#hirer.left_time > 0 of
                true -> Hirer#hirer.hire_id;
                false -> ?INVALID_ID
            end
    end.


%% return true | false
has_hired_player(PS) ->
    case get_my_hire(PS) of
        {fail, _Reason} -> false;
        {ok, _Hirer} -> true
    end.

%% return true | false
has_been_hire(PS) ->
    case mod_hire:get_hire_from_ets(player:get_id(PS)) of
        null -> false;
        _Any -> true
    end.


battle_feedback(Feedback) ->
    ?ASSERT(is_record(Feedback, btl_feedback)),
    case Feedback#btl_feedback.hired_player_id of
        ?INVALID_ID -> skip;
        _ -> try_update_hired_player(Feedback#btl_feedback.player_id)
    end.


try_update_hired_player(PlayerId) ->
    case mod_hire:get_hirer_from_ets(PlayerId) of
        null ->
            skip;
        Hirer ->
            case (Hirer#hirer.is_fight =:= ?REST_STATE orelse Hirer#hirer.hire_id =:= ?INVALID_ID) of
                true ->
                    skip;
                false ->
                    ?ASSERT(Hirer#hirer.left_time >= 1),
                    LeftTime = Hirer#hirer.left_time - 1,
                    
                    case LeftTime =:= 0 of
                        false ->
                            NewHirer = Hirer#hirer{left_time = LeftTime},
                            mod_hire:update_hirer_to_ets(NewHirer),
                            mod_hire:db_save_hirer(NewHirer);
                        true ->
                            do_fire_my_hire(PlayerId)
                    end,
                    
                    {ok, BinData} = pt_41:write(?NOTIFY_MY_HIRE_INFO_CHANGE, [LeftTime]),
                    case player:get_PS(PlayerId) of
                        null -> skip;
                        PS -> lib_send:send_to_sock(PS, BinData)
                    end
            end
    end.

%% 作废！！
% on_player_logout(PS) ->
%     case mod_hire:get_hirer_from_ets(player:id(PS)) of
%         null ->
%             skip;
%         Hirer ->
%             mod_hire:db_save_hirer(Hirer)
%     end.


db_try_save_hirer(PlayerId) ->
    case mod_hire:get_hirer_from_ets(PlayerId) of
        null ->
            skip;
        Hirer ->
            mod_hire:db_save_hirer(Hirer)
    end.


on_vip_lv_up(PS_Old, PS_New) ->
    % ?DEBUG_MSG("ply_hire:on_vip_lv_up:~n begin...", []),
    case mod_hire:get_hire_from_ets(player:id(PS_New)) of
        null -> 
            {ok, BinData} = pt_41:write(?GET_PLAYER_HIRED_INFO, [PS_New, null]),
            lib_send:send_to_sock(PS_New, BinData);
        Hire ->
            MaxTimeOld = 
                case lib_vip:welfare(max_hirer_times, PS_Old) of
                    null -> ?ASSERT(false), 1;
                    Time1 when is_integer(Time1) -> Time1
                end,
            MaxTimeNew = 
                case lib_vip:welfare(max_hirer_times, PS_New) of
                    null -> ?ASSERT(false), 1;
                    Time2 when is_integer(Time2) -> Time2
                end,
            AddTime = MaxTimeNew - MaxTimeOld,
            ?ASSERT(AddTime >= 0, AddTime),
            % ?DEBUG_MSG("ply_hire:on_vip_lv_up:~p,~p", [MaxTimeOld, MaxTimeNew]),
            NewHire = Hire#hire{left_time = Hire#hire.left_time + AddTime},
            mod_hire:update_hire_to_ets(NewHire),
            {ok, BinData} = pt_41:write(?GET_PLAYER_HIRED_INFO, [PS_New, NewHire]),
            lib_send:send_to_sock(PS_New, BinData)
    end.

    
%% -----------------------------------------Local Fun------------------------------------------------------

check_fire_my_hire(PS) ->
    case mod_hire:get_hirer_from_ets(player:get_id(PS)) of
        null -> {fail, ?PM_HAVE_NO_HIRE};
        _Hirer ->
            ok
    end.


do_fire_my_hire(PlayerId) when is_integer(PlayerId) ->
    mod_hire:del_hirer_from_ets(PlayerId),
    mod_hire:db_delete_hirer(PlayerId),
    ok;
do_fire_my_hire(PS) ->
    mod_hire:del_hirer_from_ets(player:get_id(PS)),
    mod_hire:db_delete_hirer(player:get_id(PS)),
    ok.


check_fight_my_hire(PS) ->
    case mod_hire:get_hirer_from_ets(player:get_id(PS)) of
        null -> {fail, ?PM_HAVE_NO_HIRE};
        Hirer ->
            case Hirer#hirer.left_time =< 0 of
                true -> {fail, ?PM_LEFT_TIME_LIMIT};
                false -> {ok, Hirer}
            end
    end.


do_fight_my_hire(_PS, Hirer) ->
    NewHirer = Hirer#hirer{is_fight = ?FIGHT_STATE},
    mod_hire:update_hirer_to_ets(NewHirer),
    % mod_hire:db_save_hirer(NewHirer),
    ok.


check_rest_my_hire(PS) ->
    case mod_hire:get_hirer_from_ets(player:get_id(PS)) of
        null -> {fail, ?PM_HAVE_NO_HIRE};
        Hirer ->
            {ok, Hirer}
    end.


do_rest_my_hire(_PS, Hirer) ->
    NewHirer = Hirer#hirer{is_fight = ?REST_STATE},
    mod_hire:update_hirer_to_ets(NewHirer),
    % mod_hire:db_save_hirer(NewHirer),
    ok.



check_get_my_hire(PS) ->
    case mod_hire:get_hirer_from_ets(player:get_id(PS)) of
        null -> {fail, ?PM_HAVE_NO_HIRE};
        Hirer ->
            {ok, Hirer}
    end.


do_get_my_hire(_PS, Hirer) ->
    {ok, Hirer}.


check_get_income(PS) ->
    case mod_hire:get_hire_from_ets(player:get_id(PS)) of
        null -> {fail, ?PM_HAVE_NOT_SIGN_UP};
        Hire ->
            F = fun({_PlayerId, _Name, Time, Income}, {SumI, SumT}) -> {Income + SumI, Time + SumT} end,
            {TSumIncomeAll, SumTime} = lists:foldl(F, {0, 0}, Hire#hire.hire_history),
            SumIncomeAll = TSumIncomeAll - Hire#hire.get_income,
            SumIncome = SumIncomeAll - util:ceil(SumIncomeAll * (?TAX_RATE/100)),
            case SumIncome =< 0 of
                true -> {fail, ?PM_NO_INCOME};
                false ->
                    {ok, Hire, SumIncome, SumTime}
            end
    end.


do_get_income(PS, Hire, CanGet, SumTime) ->
    GetIncome = util:ceil(CanGet / (1 - (?TAX_RATE/100))), %% 税是玩家承担
    NewHire = Hire#hire{get_income = Hire#hire.get_income + GetIncome},
    mod_hire:update_hire_to_ets(NewHire),
    mod_hire:db_save_hire(NewHire),
    player:add_gamemoney(PS, CanGet, [?LOG_HIRE, "employee"]),
    lib_log:statis_hire_get_pay(PS, SumTime, CanGet),
    {ok, CanGet}.


check_sign_up(PS, Price) ->
    case mod_hire:get_hire_from_ets(player:get_id(PS)) of
        null ->
            case Price > 0 andalso Price =< 100000 of
                false -> {fail, ?PM_PARA_ERROR};
                true -> 
                    case player:get_lv(PS) < ply_sys_open:get_sys_open_lv(?SYS_HIRE) of
                        true -> {fail, ?PM_LV_LIMIT};
                        false -> ok
                    end
            end;
        _Hire ->
            {fail, ?PM_HAVE_SIGN_UP}
    end.


do_sign_up(PS, Price) ->
    F = fun(X) ->
        Partner = lib_partner:get_partner(X),
        #par_brief{
            id = X,
            no = lib_partner:get_no(Partner),
            name = lib_partner:get_name(Partner),
            lv = lib_partner:get_lv(Partner),
            position = lib_partner:get_position(Partner),
            battle_power = lib_partner:get_battle_power(Partner)
        }
    end,
    LeftTime = 
        case lib_vip:welfare(max_hirer_times, PS) of
            null -> ?ASSERT(false), 1;
            Time when is_integer(Time) -> Time
        end,
    Hire = #hire{
            id = player:get_id(PS),
            name = player:get_name(PS),
            lv = player:get_lv(PS),
            faction = player:get_faction(PS),
            battle_power = ply_attr:get_battle_power(PS),
            left_time = LeftTime,
            price = Price,
            par_list = [F(X) || X <- player:get_partner_id_list(PS)],
            hire_history = [],
            get_income = 0,
            sex = player:get_sex(PS)
    },
    mod_hire:add_hire_to_ets(Hire),
    mod_hire:db_insert_new_hire(Hire),
    
    mod_offline_data:db_replace_role_offline_bo(PS, ?SYS_HIRE),
    
    lib_log:statis_hire_sign_up(PS, LeftTime, Price * LeftTime),
    mod_achievement:notify_achi(hire, [], PS),
    lib_event:event(be_hired, [], PS),
    ok.


check_get_hired_info(PS) ->
    case player:get_lv(PS) < ply_sys_open:get_sys_open_lv(?SYS_HIRE) of
        true ->
            {fail, ?PM_LV_LIMIT};
        false ->
            case mod_hire:get_hire_from_ets(player:get_id(PS)) of
                null -> {fail, ?PM_HAVE_NOT_SIGN_UP};
                Hire -> {ok, Hire}
            end
    end.


do_get_hired_info(_PS, Hire) ->
    Hire.


check_employ_hire(PS, ObjPlayerId, Count, Price) ->
    try check_employ_hire__(PS, ObjPlayerId, Count, Price) of
        {ok, Hire} ->
            {ok, Hire}
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.


check_employ_hire__(PS, ObjPlayerId, Count, Price) ->
    ?Ifc (Count =< 0)
        throw(?PM_PARA_ERROR)
    ?End,

    ?Ifc (player:id(PS) =:= ObjPlayerId)
        throw(?PM_PARA_ERROR)
    ?End,

    Hire = mod_hire:get_hire_from_ets(ObjPlayerId),
    ?Ifc (Hire =:= null)
        throw(?PM_HIRE_NOT_EXISTS)
    ?End,

    ?Ifc (Hire#hire.left_time < Count)
        throw(?PM_HIRE_COUNT_LIMIT)
    ?End,

    ?Ifc (Hire#hire.price /= Price)
        throw(?PM_PRICE_CHANGE_TRY_AGAIN)
    ?End,

    ?Ifc (Hire#hire.id =:= player:get_id(PS))
        throw(?PM_CANT_HIRE_ONESELF)
    ?End,

    ?Ifc (not player:has_enough_gamemoney(PS, Count * Hire#hire.price))
        throw(?PM_GAMEMONEY_LIMIT)
    ?End,

    ?Ifc (mod_hire:get_hirer_from_ets(player:get_id(PS)) /= null)
        throw(?PM_HAVE_HIRE)
    ?End,

    {ok, Hire}.


do_employ_hire(PS, Hire, Count) ->
    player:cost_gamemoney(PS, Count * Hire#hire.price, [?LOG_HIRE, "employer"]),

    NewHire = Hire#hire{
            left_time = Hire#hire.left_time - Count,
            hire_history = [{player:id(PS), player:get_name(PS), Count, Count * Hire#hire.price} | Hire#hire.hire_history]
            },

    mod_hire:update_hire_to_ets(NewHire),
    mod_hire:db_save_hire(NewHire),

    Hirer = #hirer{
            id = player:get_id(PS),
            hire_id = Hire#hire.id,
            hire_name = Hire#hire.name,
            hire_lv = Hire#hire.lv,
            hire_battle_power = Hire#hire.battle_power,
            left_time = Count,
            hire_par_list = Hire#hire.par_list,
            is_fight = ?REST_STATE,
            hire_sex = Hire#hire.sex,
            hire_faction = Hire#hire.faction
    },
    mod_hire:add_hirer_to_ets(Hirer),
    mod_hire:db_insert_new_hirer(Hirer),
    notify_my_hired_info_change(NewHire),
    
    lib_event:event(hire, [], PS),
    lib_log:statis_hire(PS, Hire#hire.id, Hire#hire.lv, Hire#hire.faction, Hire#hire.battle_power, Count, Count * Hire#hire.price),
    ok.


check_get_hire_list(PS, Faction, StartIndex, EndIndex, SortType) ->
    case player:get_lv(PS) < ply_sys_open:get_sys_open_lv(?SYS_HIRE) of
        true ->
            {fail, ?PM_LV_LIMIT};
        false ->
            case util:in_range(Faction, ?FACTION_NONE, ?FACTION_MAX) of
                false ->
                    {fail, ?PM_PARA_ERROR};
                true ->
                    case StartIndex >= 1 andalso EndIndex >= 1 andalso StartIndex =< EndIndex  andalso lists:member(SortType, [1,2,3,4]) of
                        false ->
                            {fail, ?PM_PARA_ERROR};
                        true ->
                            ok
                    end
            end
    end.


get_lv_region(Lv) ->
    if 
        10 =< Lv andalso Lv =< 19 ->
            {1, 29};
        20 =< Lv andalso Lv =< 29 ->
            {1, 29};
        30 =< Lv andalso Lv =< 49 ->
            {20, 49};
        50 =< Lv andalso Lv =< 69 ->
            {40, 69};
        70 =< Lv andalso Lv =< 89 ->
            {60, 89};
        90 =< Lv andalso Lv =< 109 ->
            {90, 109};
        true ->
            {110, 150}
    end.


do_get_hire_list(PS, Faction, StartIndex, EndIndex, SortType) ->
    ?TRACE("ply_hire:do_get_hire_list Faction:~p StartIndex:~p,EndIndex:~p ~n", [Faction, StartIndex, EndIndex]),
    Lv = player:get_lv(PS),
    {LvMin, LvMax} = get_lv_region(Lv),
    PlayerId = player:id(PS),
    Ms =
        case Faction =:= 0 of
            true ->
                ets:fun2ms(fun(T) when LvMin =< T#hire.lv andalso T#hire.lv =< LvMax andalso T#hire.left_time > 0 andalso T#hire.id /= PlayerId -> T end);
            false ->
                ets:fun2ms(fun(T) when LvMin =< T#hire.lv andalso T#hire.lv =< LvMax andalso Faction =:= T#hire.faction 
                    andalso T#hire.left_time > 0 andalso T#hire.id /= PlayerId -> T end)
        end,
    L = ets:select(?ETS_HIRE, Ms),
    Len = length(L),

    F1 = fun(H1, H2) -> H1#hire.battle_power > H2#hire.battle_power end,
    F2 = fun(H1, H2) -> H1#hire.battle_power < H2#hire.battle_power end,
    F3 = fun(H1, H2) -> H1#hire.price > H2#hire.price end,
    F4 = fun(H1, H2) -> H1#hire.price < H2#hire.price end,

    SortL = 
        case SortType of
            1 -> lists:sort(F1, L);
            2 -> lists:sort(F2, L);
            3 -> lists:sort(F3, L);
            4 -> lists:sort(F4, L)
        end,

    % 用sublist()截取StartIndex到EndIndex之间的成员信息，然后返回
    case StartIndex > length(SortL) orelse EndIndex - StartIndex + 1 < 0 of
        true -> {Len, []};
        false -> {Len, lists:sublist(SortL, StartIndex, EndIndex - StartIndex + 1)}
    end.


notify_my_hired_info_change(Hire) ->
    case player:get_PS(Hire#hire.id) of
        null ->
            skip;
        PS ->
            {ok, BinData} = pt_41:write(?GET_PLAYER_HIRED_INFO, [PS, Hire]),
            lib_send:send_to_sock(PS, BinData)
    end.

db_update_role_offline_bo_for_hire(PS) ->
    mod_offline_data:db_update_role_offline_bo(PS, ?SYS_HIRE),
    F = fun(X) ->
        case lib_partner:get_partner(X) of
            null -> skip;
            Partner -> mod_offline_data:db_replace_partner_offline_bo(Partner, ?SYS_HIRE)
        end
    end,
    lists:foreach(F, player:get_partner_id_list(PS)).