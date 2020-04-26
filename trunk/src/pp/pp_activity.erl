-module(pp_activity).

-include("common.hrl").
-include("record.hrl").
-include("prompt_msg_code.hrl").
-include("pt_34.hrl").
-include("activity_degree_sys_2.hrl").
-include("ets_name.hrl").
-include("activity.hrl").

-export([handle/3]).


%% ======================
%% 答题相关
%% ======================
handle(31001, Status, _) ->
    lib_activity:notify_open_answer(Status),
    ok;

handle(31002, Status, []) ->
    case lib_activity:can_join_answer(Status) of
        true -> lib_activity:get_client_answer_activity_info(Status);
        false -> lib_send:send_prompt_msg(Status, ?PM_ACTIVITY_ANSWER_LV_NO_ENOUGH)
    end,
    ok;

handle(31003, Status, [No, Index]) ->
    case lib_activity:is_in_answer_activity() of
        false -> lib_send:send_prompt_msg(Status, ?PM_ACTIVITY_ANSWER_NOT_OPEN);
        true -> 
            case lib_activity:can_join_answer(Status) of
                true -> lib_activity:answer_question(Status, No, Index);
                false -> lib_send:send_prompt_msg(Status, ?PM_ACTIVITY_ANSWER_LV_NO_ENOUGH)
            end
    end,
    ok;

handle(31004, Status, [Index, Question]) ->
    case lib_activity:can_join_answer(Status) of 
        true -> lib_activity:use_acepack(Status, Index, Question);
        false -> lib_send:send_prompt_msg(Status, ?PM_ACTIVITY_ANSWER_LV_NO_ENOUGH)
    end,
    ok;


handle(31007, Status, [No, Type]) ->
    lib_activity:recv_answer_reward(Status, No, Type),
    ok;


%% 运营活动
handle(31050, Status, _) ->
    mod_admin_activity:fetch_admin_activity_list(Status),
    ok;

handle(31051, Status, [ActivityId]) -> 
    mod_admin_activity:fetch_admin_activity(ActivityId, Status),
    ok;

handle(31060, Status, _) ->
    mod_admin_activity:fetch_admin_sys_activity_list(Status),
    ok;

handle(31061, Status, [ActivityId]) -> 
    mod_admin_activity:fetch_admin_sys_activity(ActivityId, Status),
    ok;

handle(31063, Status, [ActivityId, Value]) ->
    mod_admin_activity:get_reward_admin_sys_activity(Status, Value, ActivityId),
    ok;

handle(31070, Status, _) ->
    mod_admin_activity:fetch_festival_activity(Status),
    ok;

handle(31071, Status, [Data]) ->
    mod_admin_activity:fetch_assign_festival_activity(Status, Data),
    ok;

%% =========================
%% 女妖选美 抽奖活动 相关
%% =========================
% 获取抽奖面板信息
handle(31100, Status, []) ->
    lib_beauty_contest:beauty_contest_info(Status);

% 抽奖
handle(31101, Status, [CostType]) ->
    case check_cmd_cd(31101, 2) of
        false -> skip;
        true ->
            lib_beauty_contest:beauty_contest_gamble(Status, CostType)
    end;

% 重置抽奖面板
handle(31102, Status, []) ->
    case check_cmd_cd(31102, 1) of
        false -> 
            % 客户端要求CD中告诉一下他 0.0
            {ok, ErrBinData} = pt_31:write(31102, [4]),
            lib_send:send_to_sid(Status, ErrBinData),
            skip;
        true ->
            lib_beauty_contest:beauty_contest_reset(Status)
    end;

% 请求竞猜活动题目数据(所有)
handle(31201, Status, []) ->
	List = ets:tab2list(?ETS_GUESS_QUESTION),
	TimeNow = util:unixtime(),
	Pred = fun(#guess_question{time_show_begin = TimeShowBegin, time_show_end = TimeShowEnd}) ->
				   TimeNow >= TimeShowBegin andalso TimeNow =< TimeShowEnd
		   end,
	List2 = lists:filter(Pred, List),
	{ok, BinData} = pt_31:write(31201, [List2]),
	lib_send:send_to_sid(Status, BinData);


% 请求竞猜活动题目数据(所有)
handle(31202, Status, [Id, Option, Rmb, Cup]) ->
	lib_guess:guess_bet(Status, Id, Option, Rmb, Cup);


%% =========================
%% 春节活动 相关
%% =========================

handle(?PT_AD_GET_GOODS, PS, _) ->
    case lib_festival_act:get_year_goods(PS) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        ok ->
            {ok, BinData} = pt_34:write(?PT_AD_GET_GOODS, [?RES_OK]),
            lib_send:send_to_sock(PS, BinData)
    end;


handle(?PT_AD_GIVE_GIFT, PS, [PlayerId, BlessingNo, Type]) ->
    case lib_festival_act:give_gift(PS, PlayerId, BlessingNo, Type) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        ok ->
            {ok, BinData} = pt_34:write(?PT_AD_GIVE_GIFT, [?RES_OK, Type]),
            lib_send:send_to_sock(PS, BinData)
    end;


handle(?PT_AD_GET_GIFT, PS, _) ->
    case lib_festival_act:get_gift(PS) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        ok ->
            {ok, BinData} = pt_34:write(?PT_AD_GET_GIFT, [?RES_OK]),
            lib_send:send_to_sock(PS, BinData)
    end;


handle(_CMD, _, _) ->
    ?ASSERT(false, [_CMD]),
    no_match.

%% 协议CD限制
check_cmd_cd(Cmd, Interval) ->
    Now = util:unixtime(),
    Ret = 
    case get({check_cmd_cd, Cmd}) of
        undefined -> true;
        Time ->
            Time + Interval < Now
    end,
    case Ret of
        true -> put({check_cmd_cd, Cmd}, Now);
        false -> skip
    end,
    Ret.
