%%%------------------------------------
%%% @author 严利宏 <542430172@qq.com>
%%% @copyright UCweb 2014.12.10
%%% @doc 女妖结婚系统.
%%% @end
%%%------------------------------------

-module(pp_couple).
-export([handle/3]).

-include("common.hrl").
-include("record.hrl").
-include("player.hrl").
-include("relation.hrl").
-include("prompt_msg_code.hrl").
-include("log.hrl").
-include("ets_name.hrl").
-include("protocol/pt_33.hrl").

%% 申请结婚 
handle(?PT_COUPLE_APPLY_MARRIAGE, PS, [Type]) ->
    ?ylh_Debug("apply_merriage ~p~n", [player:id(PS)]),
    case lib_couple:apply_marriage(PS, Type) of
        {error, ErrCode} ->
            lib_send:send_prompt_msg(PS, ErrCode);
        ok ->
            {ok, BinData} = pt_33:write(?PT_COUPLE_APPLY_MARRIAGE, [?RES_OK]),
            lib_send:send_to_sock(PS, BinData)
    end;

%% 回应求婚
handle(?PT_COUPLE_RESPOND_MARRIAGE, PS, [Respond]) ->
    ?ylh_Debug("respond_merriage ~p~n", [[player:id(PS), Respond]]),
    ?ASSERT(lists:member(Respond, [1,2]), {player:id(PS), Respond}),
    case lib_couple:respond_marriage(PS, Respond) of
        {error, ErrCode} ->
            lib_send:send_prompt_msg(PS,ErrCode);
        ok ->
            skip
    end;


handle(?PT_COUPLE_QUERY_SKILL_INFO, PS, _) ->
    {ok, BinData} = pt_33:write(?PT_COUPLE_QUERY_SKILL_INFO, [player:id(PS)]),
    lib_send:send_to_sock(PS, BinData);


handle(?PT_COUPLE_LEARN_SKILL, PS, [SkillId]) ->
    case lib_couple:learn_skill(PS, SkillId) of
        {fail, ErrCode} ->
            lib_send:send_prompt_msg(PS, ErrCode);
        ok ->
            {ok, BinData} = pt_33:write(?PT_COUPLE_LEARN_SKILL, [?RES_OK]),
            lib_send:send_to_sock(PS, BinData)
    end;


handle(?PT_COUPLE_FIREWORKS, PS, _) ->
    case util:unixtime() - get_last_fireworks_time() >= 3 of
        false ->
            lib_send:send_prompt_msg(PS, ?PM_COUPLE_FIREWORKS_CD);
        true ->
            Type = mod_couple_cruise_inst:get_type(),
			DataCfig = data_couple:get(cruise,Type),
            RetMoney = lib_couple:check_money(PS, DataCfig#couple_cfg.fire_price),
            case RetMoney =:= 0 of
                false ->
                    lib_send:send_prompt_msg(PS, RetMoney);
                true ->
                    case erlang:whereis(?COUPLE_CRUISE_PROCESS) of
                        undefined -> 
                            lib_send:send_prompt_msg(PS, ?PM_COUPLE_CRUISE_FINISHED);
                        _Pid -> 
                            lib_couple:cost_money(PS, DataCfig#couple_cfg.fire_price, [?LOG_COUPLE, "cruise_fire"]),
                            gen_server:cast(?COUPLE_CRUISE_PROCESS, {'fireworks', PS}),
                            set_last_fireworks_time(util:unixtime())
                    end
            end
    end;


handle(?PT_COUPLE_REQ_JOIN_CRUISE, PS, _) ->
    case player:is_idle(PS) of
        false ->
            lib_send:send_prompt_msg(PS, ?PM_BUSY_NOW);
        true ->
            case player:get_lv(PS) < ?RELA_JOIN_COUPLE_LV of
                true ->
                    lib_send:send_prompt_msg(PS, ?PM_LV_LIMIT);
                false ->
                    case player:is_in_team(PS) of
                        true -> lib_send:send_prompt_msg(PS, ?PM_TM_LEAVE_TEAM_FIRST);
                        false ->
                            case player:is_in_dungeon(PS) of
                                {true, _Pid} ->
                                    lib_send:send_prompt_msg(PS, ?PM_DUNGEON_PLEASE_LEAVE);
                                false ->
                                    case erlang:whereis(?COUPLE_CRUISE_PROCESS) of
                                        undefined -> 
                                            lib_send:send_prompt_msg(PS, ?PM_COUPLE_CRUISE_FINISHED);
                                        _Pid -> 
                                            gen_server:cast(?COUPLE_CRUISE_PROCESS, {'req_join_couple_cruise', PS})
                                    end
                            end
                    end
            end
    end;


handle(?PT_COUPLE_REQ_STOP_CRUISE, PS, _) ->
    case erlang:whereis(?COUPLE_CRUISE_PROCESS) of
        undefined -> 
            player:mark_idle(PS),
            lib_send:send_prompt_msg(PS, ?PM_COUPLE_CRUISE_FINISHED);
        _Pid -> 
            gen_server:cast(?COUPLE_CRUISE_PROCESS, {'req_stop_couple_cruise', PS})
    end;


handle(?PT_COUPLE_APPLY_CRUISE, PS, [Type]) ->
    case lib_couple:check_apply_couple_cruise_base(PS, Type) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        ok ->
            case erlang:whereis(?COUPLE_CRUISE_PROCESS) of
                undefined -> 
                    case catch gen_server:call(?RELATION_PROCESS, {'apply_couple_cruise', PS, Type}) of
                        {'EXIT', Reason} ->
                            ?ERROR_MSG("mod_relation:apply_couple_cruise(), exit for reason: ~w~n", [Reason]),
                            ?ASSERT(false, Reason),
                            {fail, ?PM_MK_FAIL_SERVER_BUSY};
                        {fail, Reason} ->
                            lib_send:send_prompt_msg(PS, Reason);
                        ok ->
                            skip;
                        _Any ->
                            ?ERROR_MSG("mod_relation:apply_couple_cruise(), error!: ~w~n", [_Any]),
                            {fail, ?PM_UNKNOWN_ERR}
                    end;
                _Pid -> 
                    lib_send:send_prompt_msg(PS, ?PM_COUPLE_CRUISE_WAIT)
            end
    end;


%% 申请离婚
handle(?PT_COUPLE_APPLY_DEVORCE, PS, [Devorcetype]) ->
    ?ylh_Debug("apply_devorce ~p~n", [[player:id(PS), Devorcetype]]),
    case lib_couple:check_apply_devorce(PS, Devorcetype) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        ok ->
            lib_couple:do_apply_devorce(PS, Devorcetype)
    end;


handle(?PT_COUPLE_RESPOND_DEVORCE, PS, [Respond]) ->
    case lib_couple:respond_devorce(PS, Respond) of
        {error, ErrCode} ->
            lib_send:send_prompt_msg(PS, ErrCode);
        ok ->
            skip
    end;


handle(?PT_COUPLE_CAR_POS, PS, _) ->
    gen_server:cast(?COUPLE_CRUISE_PROCESS, {'req_cruise_car_pos', PS});


handle(_Msg, _PS, _) ->
    ?WARNING_MSG("unknown handle ~p", [_Msg]),
    error.



get_last_fireworks_time() ->
    case get(fireworks_time) of
        undefined -> 0;
        Rd -> Rd
    end.

set_last_fireworks_time(TimeStamp) ->
    put(fireworks_time, TimeStamp).