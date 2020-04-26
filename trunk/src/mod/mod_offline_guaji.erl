%%%--------------------------------------
%%% @Module: mod_offline_guaji
%%% @Author: liuzhongzheng2012@gmail.com
%%% @Created: 2014-05-20
%%% @Description: 离线挂机
%%%--------------------------------------

-module(mod_offline_guaji).

-export([
            login/1,
            logout/1,
            stop/2,

            send_info/1
        ]).

-include("common.hrl").
-include("record.hrl").
-include("player.hrl").
-include("buff.hrl").
-include("pt_13.hrl").
-include("prompt_msg_code.hrl").
-include("char.hrl").
-include("sys_code.hrl").
-include("log.hrl").
-include("goods.hrl").


-define(CONST_OFFLINE_AWARD_DAN_FACTOR, 1). % 用经验丹系数
-define(CONST_OFFLINE_AWARD_MONEY_FACTOR, 5). % 花钱涨经验系数
-define(CONST_OFFLINE_AWARD_XIUYAO, 30). % N分钟可得一个藏宝图
-define(CONST_OFFLINE_AWARD_AFTER, 300). % 线下5分钟后开始计算

-define(CONST_XIUYAO_ID, 10043). % 藏宝图ID


login(#player_status{}=PS) ->
    case lib_offline:get_value(PS, guaji_state, ?undefined) of
        ?BHV_OFFLINE_GUAJI ->
            case valid_second(PS) of
                Sec when Sec > 60 ->
                    PS#player_status{cur_bhv_state=?BHV_OFFLINE_GUAJI};
                _ ->
                    PS2 = clear_state(PS),
                    PS2
            end;
        _ ->
            PS
    end.

logout(#player_status{cur_bhv_state=?BHV_OFFLINE_GUAJI}=PS) ->
    PS;
logout(PS) ->
    PS1 = do_start(PS),
    PS1.

do_start(PS) ->
    UID = player:id(PS),
    case ply_sys_open:is_open(UID, ?SYS_OFFLINE_GUAJI) of
        ?true ->
            Now = util:unixtime(),
            DanSecond = mod_buff:get_buff_left_time_by_name(player, UID, ?BFN_ADD_EXP),
            DanMinute = max((DanSecond - ?CONST_OFFLINE_AWARD_AFTER) div 60, 0),
            PS1 = lib_offline:set_value(PS, guaji_start_time, Now + ?CONST_OFFLINE_AWARD_AFTER),
            PS2 = lib_offline:set_value(PS1, guaji_dan_remain, DanMinute),
            PS3 = lib_offline:set_value(PS2, guaji_state, ?BHV_OFFLINE_GUAJI),
            PS3;
        _ ->
            PS
    end.

%% 停止离线挂机
stop(UseMoney, #player_status{cur_bhv_state=?BHV_OFFLINE_GUAJI}=PS) ->
    case award(UseMoney, PS) of
        {?true, PS1} ->
            PS2 = clear_state(PS1),
            PS3 = PS2#player_status{cur_bhv_state=?BHV_IDLE},
            send_info(PS3),
            PS3;
        _ ->
            ?DEBUG_MSG("stop offline award fail", []),
            PS
    end;
stop(_UseMoney, #player_status{}=PS) ->
    % ID = player:id(PS),
    % ?WARNING_MSG("Player not in offline guaji, ~p", [ID]),
    send_info(PS),
    PS;
stop(_UseMoney, PS) ->
    ?WARNING_MSG("Invalid PS: ~p", [PS]),
    PS.

clear_state(#player_status{}=PS) ->
    Keys = [guaji_state, guaji_start_time, guaji_dan_remain],
    PS1 = lib_offline:del_keys(PS, Keys),
    PS1;
clear_state(PS) ->
    PS.

award(1=_UseMoney, PS) -> % 用钱提高经验
    {_Minute, Exp, MPE, Cost} = calc_min_exp_cost(PS),
    Exp1 = util:floor(Exp * data_special_config:get('offline_award_exp')),
    MPE1 = util:floor(MPE * data_special_config:get('offline_award_exp')),
    case mod_inv:check_batch_destroy_goods(PS, Cost) of
        ok ->
            mod_inv:destroy_goods_WNC(PS, Cost, [?LOG_GUAJI, "off-line"]),
            PS2 = exp_award(Exp1, MPE1, PS),
            {?true, PS2};
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason),
            {?false, PS}
    end;
award(_UseMoney, PS) ->
    {_Minute, Exp, MPE, _Cost} = calc_min_exp_cost(PS),
    PS1 = exp_award(Exp, MPE, PS),
    {?true, PS1}.

exp_award(Exp, MPE, PS) ->
    case mod_partner:get_main_partner_id(PS) of
        ?INVALID_ID -> skip;
        PartnerId ->
            lib_partner:add_exp(PartnerId, MPE, PS, [?LOG_GUAJI, "off-line"])
    end,
    player:add_exp(PS, Exp, [?LOG_GUAJI, "off-line"]),
    PS.


%% 有效离线挂机时间
valid_second(PS) ->
    Now = util:unixtime(),
    StartTime = lib_offline:get_value(PS, guaji_start_time, Now),
%%    MaxSecond = lib_vip:welfare(offline_guaji_max_minute, PS) * 60,
    MaxSecond = data_special_config:get('offline_acc_time_lim'),
    min(Now - StartTime, MaxSecond).

%% 计算可获经验和需花费的物品数量
calc_min_exp_cost(#player_status{cur_bhv_state=?BHV_OFFLINE_GUAJI}=PS) ->
    Lv = player:get_lv(PS),
%%    DanMinute = lib_offline:get_value(PS, guaji_dan_remain, 0), % 离线时四倍经验剩余时间

    Minute = valid_second(PS) div 60,
    calc_min_exp_cost(Lv, Minute).

calc_min_exp_cost(_Lv, Minute) when Minute =< 0 ->
    {0, 0, 0, []};
calc_min_exp_cost(Lv, Minute)  ->
    case data_offline_award:get(Lv) of
        #data_offline_award{exp=Exp,
                            cost=Cost,
                            main_pet_exp=MPE} ->
            Exp1 = round( Exp * Minute ),
            MPE1 = round( MPE * Minute ),
            {GoodsNo, Num} = Cost,
            NewCost = [{GoodsNo, Num * Minute}],
            {Minute, Exp1, MPE1, NewCost};
        _ ->
            {Minute, 0, 0, []}
    end.


send_info(#player_status{cur_bhv_state=?BHV_OFFLINE_GUAJI}=PS) ->
    Second = valid_second(PS),
    {_Minute, Exp, MPE, Cost} = calc_min_exp_cost(PS),
    send_info(1, Second, Exp, MPE, Cost, PS);
send_info(PS) ->
    send_info(0, 0, 0, 0, 0, PS).


send_info(State, Second, Exp, MPE, Cost, #player_status{id=UID}=_PS) ->
    CostNum = case Cost of
                  [] -> 0;
                  [{_ , Num}] -> Num;
                  _ -> 0
              end,
    {ok, Bin} = pt_13:write(?PT_PLYR_OFFLINE_AWARD_STATE, [State, Second, Exp, MPE, CostNum]),
    lib_send:send_to_uid(UID, Bin).
