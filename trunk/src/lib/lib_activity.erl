-module(lib_activity).

-include("common.hrl").
-include("record.hrl").
-include("prompt_msg_code.hrl").
-include("log.hrl").
-include("activity.hrl").
-include("activity_degree_sys.hrl").
-include("ets_name.hrl").

-compile(export_all).
-export([]).

%% ======================
%% 答题相关
%% ======================

%% @doc 登录加载
answer_login(_Status, role_in_cache) ->
    % login_correct_literary(Status, util:unixtime()),
    skip;
answer_login(Status, _) ->
    % login_correct_literary(Status, util:unixtime()),
    case can_join_answer(Status) of
        true ->
            RoleId = player:id(Status),
            case db:select_row(answer, "*", [{role_id, RoleId}]) of
                [] -> 
                    Answer = #answer{role_id = RoleId},
                    set_answer_info(Answer);

                [_, JoinTime, CurQu, CurIndex, Correct, HisCorrect, Literary, Exp, RewardInfo, AcepackInfo, QuInfo, Score] ->
                    update_answer_info(#answer{
                        role_id = RoleId
                        ,join_time = JoinTime          
                        ,cur_question = CurQu      
                        ,cur_index = CurIndex         
                        ,correct_num = Correct       
                        ,his_cor_num = HisCorrect        
                        ,literary = Literary          
                        ,exp = Exp               
                        ,reward_info = util:bitstring_to_term(RewardInfo)       
                        ,acepack_info = util:bitstring_to_term(AcepackInfo)         
                        ,questions_info = util:bitstring_to_term(QuInfo)       
                        ,score_streak = Score     
                        })
            end;
        false -> skip
    end.


%% @doc 登录根据当前时间和上次下线时间来修正学分
% -define(DEVIATION, 60).     % 误差秒数
login_correct_literary(Status, NowTime) -> 
    ClearTime = Status#player_status.literary_clear_time,
    MondayStamp = util:get_week_assign_day_dawn_timestamp(NowTime, 1),     % 周一凌晨时间戳
    case ClearTime < MondayStamp of
        true ->  reset_literary(Status, NowTime, 0);
        false -> skip
    end.


%% @doc 每天凌晨活动重置通知
notify_refresh(_Status, _Timestamp) ->
    % 重置学分
    % reset_literary(Status, Timestamp),
    ok.


%% @doc 周一重置学分
reset_literary(Status, Timestamp) ->
    {Date, _} = calendar:now_to_local_time(util:get_now_by_timestamp(Timestamp)),
    case calendar:day_of_the_week(Date) =:= 1 of
        true -> reset_literary(Status, Timestamp, 0);
        false -> skip
    end.


reset_literary(Status, Timestamp, NewLiterary) ->
    gen_server:cast(player:get_pid(Status), {'reset_literary', Timestamp, NewLiterary}).


%% 升级通知答题
upgrade_notify_answer(Status) ->
    case player:get_lv(Status) =:= ?ANSWER_OPEN_LV of
        true -> notify_open_answer(Status);
        false -> skip
    end.


%% @doc 通知玩家是否要开启答题
%% @return : boolean()
notify_open_answer(Status) ->
    RoleId = player:id(Status),
    case can_join_answer(Status) andalso is_in_answer_activity() of
        true ->
            case get_answer_info(RoleId) of
                Answer when is_record(Answer, answer) ->
                    case is_in_current_activity(util:unixtime(), Answer#answer.join_time) of
                        true -> 
                            case Answer#answer.cur_index >= get_max_question_num() andalso Answer#answer.cur_question =:= 0 of
                                true -> false;
                                false ->
                                    case Answer#answer.cur_index =:= 0 of
                                        true -> notify_open_answer_to_client(RoleId, 0), true;
                                        false -> notify_open_answer_to_client(RoleId, 1), true
                                    end
                            end;
                        false -> notify_open_answer_to_client(RoleId, 0), true
                    end;
                null -> notify_open_answer_to_client(RoleId, 0), true;
                _ -> ?ASSERT(false), fasle
            end;
        false -> fasle
    end.


notify_open_answer_to_client(RoleId, State) ->
    {ok, BinData} = pt_31:write(31001, [State]),
    lib_send:send_to_uid(RoleId, BinData).


answer_logout(Status) ->
    RoleId = player:id(Status),
    case get_answer_info(RoleId) of
        Answer when is_record(Answer, answer) ->
            db:update(RoleId, answer, 
                [
                {join_time, Answer#answer.join_time}         
                ,{cur_question, Answer#answer.cur_question}      
                ,{cur_index, Answer#answer.cur_index}         
                ,{correct_num, Answer#answer.correct_num}       
                ,{his_cor_num, Answer#answer.his_cor_num}        
                ,{literary, Answer#answer.literary}          
                ,{exp, Answer#answer.exp}               
                ,{reward_info, util:term_to_bitstring(Answer#answer.reward_info)} 
                ,{acepack_info, util:term_to_bitstring(Answer#answer.acepack_info)}
                ,{questions_info, util:term_to_bitstring(Answer#answer.questions_info)}  
                ,{score_streak, Answer#answer.score_streak} 
                ], [{role_id, RoleId}]),
            ets:delete(?ETS_ANSWER, RoleId);
        _ -> skip
    end.


%% @doc 是否在答题活动时间内
%% @return : boolean()
is_in_answer_activity() ->
    true.
    % is_in_activity_open_time(?AD_EXAM).
    % {Hour, Min, _Sec} = erlang:time(),
    % OpenTime = get_activity_open_time(?AD_EXAM),
    % is_in_section(Hour, Min, OpenTime).


%% @doc 是否在活动时间内
%% @return : boolean()
is_in_activity_open_time(Sys) ->
    {Hour, Min, _Sec} = erlang:time(),
    OpenTime = get_activity_open_time(Sys),
    is_in_section(Hour, Min, OpenTime).


%% @doc 判断区间
is_in_section(_, _, []) -> false;
is_in_section(Hour, Min, [{{StartH, StartM}, {EndH, EndM}} | Left]) ->
    if  Hour > StartH andalso Hour < EndH -> true;
        Hour =:= StartH andalso Hour =:= EndH andalso Min >= StartM andalso Min < EndM -> true;
        Hour =:= StartH andalso Hour < EndH andalso Min >= StartM -> true;
        Hour > StartH andalso Hour =:= EndH andalso Min < EndM -> true;
        true -> is_in_section(Hour, Min, Left)
    end.


%% @doc 通知所有符合资格玩家答题活动开启
notify_enter_answer_activity() ->
    Now = util:unixtime(),
    F = fun(RoleId) -> 
        case can_join_answer(player:get_PS(RoleId)) of
            true ->
                reset_answer_info(RoleId, Now),
                {ok, BinData} = pt_31:write(31001, [0]),
                lib_send:send_to_uid(RoleId, BinData);
            _ -> skip
        end
    end,
    lists:foreach(F, mod_svr_mgr:get_all_online_player_ids()).


%% @doc 重置答题记录
reset_answer_info(RoleId, Now) ->
    case get_answer_info(RoleId) of
        Answer when is_record(Answer, answer) ->
            case is_in_current_activity(Now, Answer#answer.join_time) of
                true -> skip;
                false ->
                    update_answer_info(#answer{role_id = Answer#answer.role_id, join_time = Now, his_cor_num = Answer#answer.his_cor_num})
            end;
        _ -> skip
    end.


%% @doc 是否符合参与答题资格
%% @return : boolean()
can_join_answer(Status) when is_record(Status, player_status) ->
    player:get_lv(Status) >= ?ANSWER_OPEN_LV;
can_join_answer(_) -> ?ASSERT(false), false.


%% @doc 取得并广播答题活动信息
get_client_answer_activity_info(Status) ->
    RoleId = player:id(Status),
    case lib_activity:is_in_answer_activity() of
        false -> lib_send:send_prompt_msg(Status, ?PM_ACTIVITY_ANSWER_NOT_OPEN);
        true ->
            Now = util:unixtime(),
            case get_answer_info(RoleId) of
                null -> 
                    % 创建新答题数据
                    NewRd = #answer{role_id = RoleId, join_time = Now},
                    NewAnswer = select_next_question(NewRd),
                    set_answer_info(NewAnswer),
                    pack_answer_activity_info(Status, NewAnswer);
                Rd when is_record(Rd, answer) -> 
                    case is_in_current_activity(Now, Rd#answer.join_time) of
                        true ->
                            case Rd#answer.cur_question =:= 0 andalso Rd#answer.cur_index =:= 0 of
                                true -> 
                                    % ?ERROR_MSG("get_client_answer_activity_info error", []),
                                    NewAnswer = select_next_question(Rd),
                                    update_answer_info(NewAnswer),
                                    pack_answer_activity_info(Status, NewAnswer);
                                false -> pack_answer_activity_info(Status, Rd)
                            end;
                            % pack_answer_activity_info(Status, Rd);
                        false -> 
                            NewRd = #answer{role_id = Rd#answer.role_id, join_time = Now, his_cor_num = Rd#answer.his_cor_num},
                            NewAnswer = select_next_question(NewRd),
                            update_answer_info(NewAnswer),
                            pack_answer_activity_info(Status, NewAnswer)
                    end;
                _ -> 
                    lib_send:send_prompt_msg(Status, ?PM_UNKNOWN_ERR),
                    ?ASSERT(false, [RoleId])
            end
    end.


pack_answer_activity_info(Status, Answer) when is_record(Answer, answer) ->
    MaxQuNum = get_max_question_num(),
    State = ?BIN_PRED(Answer#answer.cur_index >= MaxQuNum andalso Answer#answer.cur_question =:= 0,
        0, 1),
    StreakList = lists:foldl(fun(Streak, Sum) ->
                                case lists:keyfind(Streak, 1, get_streak_reward_info(Answer#answer.reward_info)) of
                                    false -> [{Streak, ?ANSWER_STREAK_TYPE, 0} | Sum];
                                    {Streak, Stimes} -> [{Streak, ?ANSWER_STREAK_TYPE, Stimes} | Sum]
                                end
                            end, [], ?SCORE_STREAK_LIST),

    CorrectList = lists:foldl(fun(Streak, Sum) ->
                                case lists:keyfind(Streak, 1, get_correct_reward_info(Answer#answer.reward_info)) of
                                    false -> [{Streak, ?ANSWER_CORRECT_TYPE, 0} | Sum];
                                    {Streak, Stimes} -> [{Streak, ?ANSWER_STREAK_TYPE, Stimes} | Sum]
                                end
                            end, [], ?SCORE_CORRECT_LIST),
    RwdList = CorrectList ++ StreakList,
    AceList = lists:foldl(fun(AcePack, Sum) ->
                                AceTimes = get_max_acepack_times(Status, AcePack),
                                case lists:keyfind(AcePack, 1, Answer#answer.acepack_info) of
                                    false -> [{AcePack, AceTimes, 0} | Sum];
                                    {_, Times, Qu, _} -> [{AcePack, ?BIN_PRED(AceTimes > Times, AceTimes - Times, 0), Qu} | Sum]
                                end
                            end, [], ?ACEPACK_LIST),
    {ok, BinData} = pt_31:write(31002, [State, Answer#answer.cur_index, MaxQuNum, Answer#answer.correct_num, get_answer_over_time(util:unixtime()),
        Answer#answer.his_cor_num, Answer#answer.literary, Answer#answer.exp, Answer#answer.cur_question, RwdList, AceList, player:get_literary(Status)]),
    % ?LDS_TRACE(31002, [State, Answer#answer.cur_index, MaxQuNum, Answer#answer.correct_num, get_answer_over_time(util:unixtime()),
    %     Answer#answer.his_cor_num, Answer#answer.literary, Answer#answer.exp, Answer#answer.cur_question, RwdList, AceList, player:get_literary(Status)]),
    lib_send:send_to_uid(player:id(Status), BinData).


get_answer_over_time(_Timestamp) ->
    0.

%% 获取 / 设置 奖励相关信息
get_streak_reward_info(RwdInfo) when is_list(RwdInfo) ->
    case lists:keyfind(streak, 1, RwdInfo) of
        false -> [];
        {streak, Info} -> Info
    end;
get_streak_reward_info(_) -> ?ASSERT(false), [].

set_streak_reward_info(RwdInfo, SetInfo) when is_list(RwdInfo) andalso is_list(SetInfo) ->
    case lists:keyfind(streak, 1, RwdInfo) of
        false -> [{streak, SetInfo} | RwdInfo];
        _Other -> lists:keyreplace(streak, 1, RwdInfo, {streak, SetInfo})
    end;
set_streak_reward_info(RwdInfo, _) -> ?ASSERT(false), RwdInfo.


get_correct_reward_info(RwdInfo) when is_list(RwdInfo) ->
    case lists:keyfind(correct, 1, RwdInfo) of
        false -> [];
        {correct, Info} -> Info
    end;
get_correct_reward_info(_) -> ?ASSERT(false), [].

set_correct_reward_info(RwdInfo, SetInfo) when is_list(RwdInfo) andalso is_list(SetInfo) ->
    case lists:keyfind(correct, 1, RwdInfo) of
        false -> [{correct, SetInfo} | RwdInfo];
        _Other -> lists:keyreplace(correct, 1, RwdInfo, {correct, SetInfo})
    end;
set_correct_reward_info(RwdInfo, _) -> ?ASSERT(false), RwdInfo.


%% @doc 答题
%% @No::题号  @Option::答案选项
answer_question(Status, No, Option) ->
    RoleId = player:id(Status),
    case get_answer_info(RoleId) of
        Answer when is_record(Answer, answer) ->
            Question = Answer#answer.cur_question,
            case No =/= Question of
                true -> lib_send:send_prompt_msg(Status, ?PM_ACTIVITY_ANSWER_QU_NOMATCH);
                false ->

                    case Answer#answer.cur_index =:= 0 of
                        true -> lib_send:send_prompt_msg(Status, ?PM_ACTIVITY_ANSWER_OVER);
                        false -> 
                            ?BIN_PRED(Answer#answer.cur_index =:= get_max_question_num(), lib_activity_degree:publ_add_sys_activity_times(?AD_EXAM, Status), skip),
                            Correct = get_correct_answer(Question),
                            {NewAnswer, Exp, Literary} = 
                                case catch send_answer_value_reward(Status, Answer, Correct, Option) of
                                    {A, B, C} -> {A, B, C};
                                    _ -> {Answer, 0, 0}
                                end,
                            %% 生成下一题
                            NewAnswer1 =
                                case catch select_next_question(NewAnswer) of
                                    Result when is_record(Result, answer) -> Result;
                                    _ -> Answer#answer{cur_index = get_max_question_num()}
                                end,
                            % ?LDS_TRACE(answer_question, [Correct, NewAnswer1#answer.cur_question]),
                            update_answer_info(NewAnswer1),
                            case Answer#answer.cur_index =:= 1 of
                                true ->
                                    mod_achievement:notify_achi('huodong_dati', [], Status);
                                false ->
                                    skip
                            end,
                            %% 通知日志统计
                            lib_log:statis_answer(Status, Correct == Option),
                            %% 通知活动是否结束
                            case NewAnswer1#answer.cur_index >= get_max_question_num() andalso NewAnswer1#answer.cur_question =:= 0 of
                                true -> mod_activity:notify_close_activity([RoleId], ?AD_EXAM);
                                false -> skip
                            end,
                            %答题全对通知成就
                            case NewAnswer1#answer.cur_index >= get_max_question_num() andalso NewAnswer1#answer.correct_num =:= get_max_question_num() of
                                true ->
                                    mod_achievement:notify_achi(dati_all_right, [], Status);
                                false ->
                                    skip
                            end,
                            % %答题超过10题通知成就
                            % case NewAnswer1#answer.cur_index >= get_max_question_num() andalso NewAnswer1#answer.correct_num >= 10 of
                            %     true ->
                            %         mod_achievement:notify_achi(dati_10_right, [], Status);
                            %     false ->
                            %         skip
                            % end,
                            CorrectReward = get_correct_reward_info(Answer#answer.reward_info),
                            IsGet = case lists:keyfind(?SCORE_CORRECT_1, 1, CorrectReward) of
                                        {_No, GetState} ->
                                            case GetState =:= 2 of
                                                true -> 1;
                                                false -> 0
                                            end;
                                        false -> 0
                                    end,
                            {ok, BinData} = pt_31:write(31003, [Answer#answer.cur_index, Literary, Exp, NewAnswer1#answer.cur_question, IsGet]),
                            lib_send:send_to_uid(RoleId, BinData)
                    end
            end;
        _ -> lib_send:send_prompt_msg(Status, ?PM_UNKNOWN_ERR)
    end.


%% @doc 生成下一题
%% @return : NewAnswer::#answer{}
select_next_question(Answer) ->
    MaxQuNum = get_max_question_num(),
    case Answer#answer.cur_index >= MaxQuNum of
        true -> Answer#answer{cur_question = 0, cur_index = MaxQuNum};
        false ->
            RandTypes = util:random_list(get_question_types()),
            case random_question(RandTypes, Answer#answer.questions_info) of
                {Qu, Info} when is_integer(Qu) ->
                    Answer#answer{cur_question = Qu, cur_index = Answer#answer.cur_index + 1, questions_info = Info};
                {_, _} ->
                    ?ASSERT(false),
                    Answer#answer{cur_question = 0, cur_index = MaxQuNum}
            end
    end.


%% @doc 根据已经随机出来的题目历史， 随机出新的题目
%% @return {null | Question::integer(), NewInfo}
random_question([], Info) -> {null, Info};
random_question([Type | Left], Info) ->
    case get_question_type_info(Type) of
        {MaxNum, [StartIndex, EndIndex]} ->
            case lists:keyfind(Type, 1, Info) of
                false -> 
                    Qu = util:rand(StartIndex, EndIndex),
                    {Qu, [{Type, 1} | Info]};
                {Type, Num} ->
                    case MaxNum > Num of
                        true -> 
                            Qu = util:rand(StartIndex, EndIndex),
                            {Qu, lists:keyreplace(Type, 1, Info, {Type, (Num + 1)})};
                        false ->
                            random_question(Left, Info)
                    end;
                _ -> ?ASSERT(false), {null, Info}
            end;
        _ -> ?ASSERT(false), {null, Info}
    end.


%% 发放数值奖励，并设置答题相关数据
%% @return : NewAnswer::{#answer{}, exp::integer(), literary::integer()}
send_answer_value_reward(Status, AnswerTmp, Correct, Correct) ->
    RoleId = player:id(Status),
    NewStreak = AnswerTmp#answer.score_streak + 1, 
    NewCorrect = AnswerTmp#answer.correct_num + 1,
    Answer = AnswerTmp#answer{correct_num = NewCorrect, his_cor_num = AnswerTmp#answer.his_cor_num + 1, score_streak = NewStreak},
    case get_answer_reward_info(Status) of
        AswRwd when is_record(AswRwd, answer_reward) ->
            {AddExp, AddLiterary} = case is_use_double_price_acepack(Answer) of
                true -> get_correct_reward(Status, AswRwd, double);
                false -> get_correct_reward(Status, AswRwd, single)
            end,
			%答题超过10题通知成就
            mod_achievement:notify_achi(dati_10_right, [], Status),
            NewAnswer = 
                case lists:member(NewCorrect, ?SCORE_CORRECT_LIST) of
                    true -> 
                        ?LDS_TRACE(answer_right, 1),
                        {ok, BinData1} = pt_31:write(31005, [1,[{NewCorrect, ?ANSWER_CORRECT_TYPE}]]),
                        CorrectReward = get_correct_reward_info(Answer#answer.reward_info),
                        NewCorrectReward = case lists:keyfind(NewCorrect, 1, CorrectReward) of
                            false -> 
                                ?LDS_TRACE(answer_right, 2),
                                lib_send:send_to_uid(RoleId, BinData1), 
                                [{NewCorrect, 1} | CorrectReward];
                            {_, 2} -> CorrectReward;
                            _ -> lists:keyreplace(NewCorrect, 1, CorrectReward, {NewCorrect, 1})
                        end,
                        %答题超过10题通知成就
                        mod_achievement:notify_achi(dati_10_right, [], Status),
                        Answer#answer{reward_info = set_correct_reward_info(Answer#answer.reward_info, NewCorrectReward)};
                    false -> Answer
                end,

            case get_score_streak_reward(NewStreak, AswRwd) of
                null -> {NewAnswer#answer{exp = NewAnswer#answer.exp + AddExp,
                                        literary = NewAnswer#answer.literary + AddLiterary
                                        }, AddExp, AddLiterary};
                _ ->
                    CorrectReward2 = get_correct_reward_info(Answer#answer.reward_info),
                    IsGet = case lists:keyfind(?SCORE_CORRECT_1, 1, CorrectReward2) of
                                {_No, GetState} ->
                                    case GetState =:= 2 of
                                        true -> 1;
                                        false -> 0
                                    end;
                                false -> 0
                            end,
                    {ok, BinData} = pt_31:write(31005, [IsGet,[{NewStreak, ?ANSWER_STREAK_TYPE}]]),
                    StreakReward = get_streak_reward_info(NewAnswer#answer.reward_info),
                    NewStreakReward = case lists:keyfind(NewStreak, 1, StreakReward) of
                        false -> 
                            lib_send:send_to_uid(RoleId, BinData), 
                            [{NewStreak, 1} | StreakReward];
                        {_, 2} -> StreakReward;
                        _ -> lists:keyreplace(NewStreak, 1, StreakReward, {NewStreak, 1})
                    end,
                    {NewAnswer#answer{reward_info = set_streak_reward_info(NewAnswer#answer.reward_info, NewStreakReward), 
                        exp = NewAnswer#answer.exp + AddExp, 
                        literary = NewAnswer#answer.literary + AddLiterary}, AddExp, AddLiterary}
            end;
        _ -> 
            ?ASSERT(false),
            {Answer, 0, 0}
    end;

send_answer_value_reward(Status, Answer, _, _) ->
    % RoleId = player:id(Status),
    case get_answer_reward_info(Status) of
        AswRwd when is_record(AswRwd, answer_reward) ->
            {AddExp, AddLiterary} = case is_use_double_price_acepack(Answer) of
                true -> get_wrong_reward(Status, AswRwd, double);
                false -> get_wrong_reward(Status, AswRwd, single)
            end,
            {Answer#answer{score_streak = 0, exp = Answer#answer.exp + AddExp, literary = Answer#answer.literary + AddLiterary}, 
                AddExp, AddLiterary};
        _ ->
            ?ASSERT(false),
            {Answer, 0, 0}
    end.


%% @doc 判断是否使用了双倍奖励锦囊
%% @return : boolean()
is_use_double_price_acepack(Answer) ->
    case lists:keyfind(1, 1, Answer#answer.acepack_info) of
        false -> false;
        {_, _, AceIndex, _} -> Answer#answer.cur_index =:= AceIndex
    end.


%% @doc 给予玩家回答题目奖励
%% @return : {Exp, Literary}
get_correct_reward(Status, AswRwd, single) when is_record(AswRwd, answer_reward) ->
    get_value_reward(Status, AswRwd#answer_reward.r_exp, AswRwd#answer_reward.r_b_silver, AswRwd#answer_reward.r_literary),
    {AswRwd#answer_reward.r_exp, AswRwd#answer_reward.r_literary};
get_correct_reward(Status, AswRwd, double) when is_record(AswRwd, answer_reward) ->
    get_value_reward(Status, AswRwd#answer_reward.r_exp * 2, AswRwd#answer_reward.r_b_silver * 2, AswRwd#answer_reward.r_literary * 2),
    {AswRwd#answer_reward.r_exp * 2, AswRwd#answer_reward.r_literary * 2};
get_correct_reward(_, _, _) -> ?ASSERT(false), {0, 0}.


get_wrong_reward(Status, AswRwd, single) when is_record(AswRwd, answer_reward) ->
    get_value_reward(Status, AswRwd#answer_reward.w_exp, AswRwd#answer_reward.w_b_silver, AswRwd#answer_reward.w_literary),
    {AswRwd#answer_reward.w_exp, AswRwd#answer_reward.w_literary};
get_wrong_reward(Status, AswRwd, double) when is_record(AswRwd, answer_reward) ->
    get_value_reward(Status, AswRwd#answer_reward.w_exp * 2, AswRwd#answer_reward.w_b_silver * 2, AswRwd#answer_reward.w_literary * 2),
    {AswRwd#answer_reward.w_exp * 2, AswRwd#answer_reward.w_literary * 2};
get_wrong_reward(_, _, _) -> ?ASSERT(false), {0, 0}.


get_value_reward(Status, Exp, BondSilver, Literary) ->
    Multi = mod_svr_mgr:get_server_reward_multi(17),
    player:add_all_exp(Status, util:floor(Exp * Multi), [?LOG_ANSWER, "prize"]),
    player:add_bind_gamemoney(Status, util:floor(BondSilver * Multi), [?LOG_ANSWER, "prize"]),
    player:add_literary(Status, Literary, [?LOG_ANSWER, "prize"]).


%% @doc 玩家领取答题奖励
recv_answer_reward(Status, Streak, Type) ->
    RoleId = player:id(Status),
    case get_answer_info(RoleId) of
        Answer when is_record(Answer, answer) ->
            RwdList = case Type of 
                ?ANSWER_STREAK_TYPE -> get_streak_reward_info(Answer#answer.reward_info);
                ?ANSWER_CORRECT_TYPE -> get_correct_reward_info(Answer#answer.reward_info);
                _ -> ?ASSERT(false, [Type]), []
            end,
            case lists:keyfind(Streak, 1, RwdList) of
                false -> recv_answer_reward_fail(Status, Streak, Type), lib_send:send_prompt_msg(Status, ?PM_ACTIVITY_ANSWER_REWARD_ERROR1);
                {_, 0} -> recv_answer_reward_fail(Status, Streak, Type), lib_send:send_prompt_msg(Status, ?PM_ACTIVITY_ANSWER_REWARD_ERROR1);
                {_, 2} -> recv_answer_reward_fail(Status, Streak, Type), lib_send:send_prompt_msg(Status, ?PM_ACTIVITY_ANSWER_REWARD_ERROR2);
                {_, 1} -> 
                    case get_answer_reward_info(Status) of
                        AswRwd when is_record(AswRwd, answer_reward) ->
                            case get_score_reward(Streak, AswRwd, Type) of
                                {RwdNo, State} ->
                                    case mod_inv:check_batch_add_goods(RoleId, [{RwdNo, 1}]) of
                                        ok -> 
                                            % NewRwdInfo = lists:keyreplace(Streak, 1, Answer#answer.reward_info, {Streak, 2}),
                                            NewInfo = lists:keyreplace(Streak, 1, RwdList, {Streak, 2}),
                                            NewRwdInfo = case Type of
                                                ?ANSWER_STREAK_TYPE -> set_streak_reward_info(Answer#answer.reward_info, NewInfo);
                                                ?ANSWER_CORRECT_TYPE -> set_correct_reward_info(Answer#answer.reward_info, NewInfo);
                                                _ -> Answer#answer.reward_info
                                            end,
                                            update_answer_info(Answer#answer{reward_info = NewRwdInfo}),
                                            Multi = mod_svr_mgr:get_server_reward_multi(17),
                                            mod_inv:batch_smart_add_new_goods(RoleId, 
                                                [{RwdNo, util:floor(Multi)}], [{bind_state, State}], [?LOG_ANSWER, "prize"]),
                                            {ok, BinData} = pt_31:write(31007, [Streak, Type, 0]),
                                            lib_send:send_to_uid(player:id(Status), BinData);
                                        _ -> recv_answer_reward_fail(Status, Streak, Type), lib_send:send_prompt_msg(Status, ?PM_US_BAG_FULL)
                                    end;
                                _ -> recv_answer_reward_fail(Status, Streak, Type), lib_send:send_prompt_msg(Status, ?PM_UNKNOWN_ERR)
                            end;
                        _ -> recv_answer_reward_fail(Status, Streak, Type), lib_send:send_prompt_msg(Status, ?PM_ACTIVITY_ANSWER_REWARD_ERROR1)
                    end;
                Other -> 
                    recv_answer_reward_fail(Status, Streak, Type), 
                    ?ERROR_MSG("[answer] recv_answer_reward keyfind error = ~p~n", [Other]),
                    lib_send:send_prompt_msg(Status, ?PM_UNKNOWN_ERR)
            end;
        _ -> recv_answer_reward_fail(Status, Streak, Type), lib_send:send_prompt_msg(Status, ?PM_UNKNOWN_ERR)
    end.

recv_answer_reward_fail(Status, Streak, Type) ->
    {ok, BinData} = pt_31:write(31007, [Streak, Type, 1]),
    lib_send:send_to_uid(player:id(Status), BinData).

%% @doc 使用锦囊
%% 锦囊::{锦囊编号::integer(), 使用次数::integer(), 对应题目进度号::integer(), 附属属性::lists()}
use_acepack(Status, PackIndex, QuIndex) when is_integer(PackIndex) andalso is_integer(QuIndex) ->
    RoleId = player:id(Status),
    case get_answer_info(RoleId) of
        Rd when is_record(Rd, answer) ->
            case check_acepack(Status, Rd, PackIndex, QuIndex) of
                {true, Answer} -> 
                    NewAnswer = use_acepack_effect(Status, Answer, PackIndex),
                    update_answer_info(NewAnswer),
                    {ok, BinData} = pt_31:write(31004, [PackIndex, QuIndex, 0]),
                    lib_send:send_to_uid(RoleId, BinData);
                {false, ErrCode} -> 
                    lib_send:send_prompt_msg(Status, ErrCode),
                    {ok, BinData} = pt_31:write(31004, [PackIndex, QuIndex, 1]),
                    lib_send:send_to_uid(player:id(Status), BinData)
            end;
        _ -> lib_send:send_prompt_msg(Status, ?PM_UNKNOWN_ERR)
    end;
use_acepack(Status, _, _) -> 
    ?ASSERT(false),
    lib_send:send_prompt_msg(Status, ?PM_UNKNOWN_ERR),
    {ok, BinData} = pt_31:write(31004, [0, 0, 1]),
    lib_send:send_to_uid(player:id(Status), BinData).


%% @doc 使用锦囊效果
%% @return : NewAnswer::#answer{}
use_acepack_effect(Status, Answer, 2) ->
    Question = Answer#answer.cur_question,
    Correct = get_correct_answer(Question),
    List = lists:delete(Correct, ?OPTIONS),
    Rand = util:rand(1, 3),
    Options = lists:delete(Rand, List),
    AcepackList = Answer#answer.acepack_info,
    case lists:keyfind(2, 1, AcepackList) of
        false -> ?ASSERT(false, [Answer, 2]), Answer;
        {_, Times, _, _} ->
            NewAcepack = lists:keyreplace(2, 1, AcepackList, {2, Times + 1, Answer#answer.cur_index, Options}),
            {ok, BinData} = pt_31:write(31006, [Answer#answer.cur_index, Options]),
            lib_send:send_to_uid(player:id(Status), BinData),
            Answer#answer{acepack_info = NewAcepack}
    end;
use_acepack_effect(_, Answer, PackIndex) when is_integer(PackIndex) ->
    AcepackList = Answer#answer.acepack_info,
    case lists:keyfind(PackIndex, 1, AcepackList) of
        false -> ?ASSERT(false, [Answer, 2]), Answer;
        {_, Times, _, _} -> 
            NewAcepack = lists:keyreplace(PackIndex, 1, AcepackList, {PackIndex, Times + 1, Answer#answer.cur_index, []}),
            Answer#answer{acepack_info = NewAcepack}
    end;
use_acepack_effect(_, Answer, _P) -> ?ASSERT(false, [_P]), Answer.


%% @doc 检查锦囊是否合法并可使用, 并检测是否有新锦囊加入，添加玩家新锦囊数据
%% @return {true, NewAnswer} | {false, ErrCode}
check_acepack(Status, Answer, PackIndex, QuIndex) ->
    case lists:member(PackIndex, ?ACEPACK_LIST) of
        true -> 
            case lib_activity:is_in_answer_activity() of
                false -> {false, ?PM_ACTIVITY_ANSWER_NOT_OPEN};
                true ->
                    case Answer#answer.cur_question =:= 0 of
                        true -> {false, ?PM_ACTIVITY_ANSWER_OVER};
                        false ->
                            case Answer#answer.cur_index =:= QuIndex of
                                false -> {false, ?PM_ACTIVITY_ANSWER_QU_NOMATCH};
                                true ->
                                    AcepackList = Answer#answer.acepack_info,
                                    CurIndex = Answer#answer.cur_index,
                                    case lists:keyfind(CurIndex, 3, AcepackList) of
                                        false -> 
                                            case lists:keyfind(PackIndex, 1, AcepackList) of
                                                false -> {true, Answer#answer{acepack_info = [{PackIndex, 0, 0, []} | AcepackList]}};
                                                {PackIndex, Times, _, _} ->
                                                    case get_max_acepack_times(Status, PackIndex) > Times of
                                                        true -> {true, Answer};
                                                        false -> {false, ?PM_ACTIVITY_ANSWER_ACEPACK_RUNOUT}
                                                    end
                                            end;
                                        _ -> {false, ?PM_ACTIVITY_ANSWER_ACEPACK_USED}
                                    end
                            end
                    end
            end;
        false -> {false, ?PM_ACTIVITY_ANSWER_UNKNOW_ACEPACK}   
    end.

%% @doc 取得玩家锦囊最大使用次数
%% @return : integer()
get_max_acepack_times(Status, PackIndex) ->
    lib_vip:welfare(?ANSWER_ACEPACK_NAME(PackIndex), Status).


%% @doc 取得玩家答题活动信息
%% @return : null | #answer{}
get_answer_info(RoleId) ->
    case ets:lookup(?ETS_ANSWER, RoleId) of
        [] -> null;
        [Answer] when is_record(Answer, answer) -> Answer;
        _ -> ?ASSERT(false), null
    end.


%% @doc 设置答题活动信息
set_answer_info(Answer) when is_record(Answer, answer) ->
    ets:insert(?ETS_ANSWER, Answer),
    db:insert(Answer#answer.role_id, answer, 
            [
            {role_id, Answer#answer.role_id}
            ,{join_time, Answer#answer.join_time}         
            ,{cur_question, Answer#answer.cur_question}      
            ,{cur_index, Answer#answer.cur_index}         
            ,{correct_num, Answer#answer.correct_num}       
            ,{his_cor_num, Answer#answer.his_cor_num}        
            ,{literary, Answer#answer.literary}          
            ,{exp, Answer#answer.exp}               
            ,{reward_info, util:term_to_bitstring(Answer#answer.reward_info)} 
            ,{acepack_info, util:term_to_bitstring(Answer#answer.acepack_info)}
            ,{questions_info, util:term_to_bitstring(Answer#answer.questions_info)}  
            ,{score_streak, Answer#answer.score_streak} 
            ]);
set_answer_info(_Arg) -> ?ASSERT(false, [_Arg]), skip.


%% @doc 更新答题信息
update_answer_info(Answer) when is_record(Answer, answer) ->
    ets:insert(?ETS_ANSWER, Answer);
update_answer_info(_Arg) -> ?ASSERT(false, [_Arg]), skip.

%% @doc 清除答题信息
clear_all_answer_info() ->
    ets:delete(?ETS_ANSWER).


%% @doc 取得题目总数
%% @return : integer()
get_max_question_num() ->
    case data_answer:get_question_info(all) of
        Result when is_integer(Result) -> Result;
        _ -> ?ASSERT(false), 0
    end.

 
%% @doc 取得题目类型
%% @return : list()
get_question_types() ->
    case data_answer:get_question_info(types) of
        Result when is_list(Result) -> Result;
        _ -> ?ASSERT(false), []
    end.


%% @doc 取得题目类型信息
%% @return : {MaxNum, [StartIndex, EndIndex]}::tuple() | null
get_question_type_info(Type) when is_integer(Type) ->
    case data_answer:get_question_info(Type) of
        Result when is_tuple(Result) -> Result;
        _ -> ?ASSERT(false), null
    end. 


%% @doc 取得答题奖励信息
%% @return : null | #answer_reward{}
get_answer_reward_info(Status) ->
    Lv = player:get_lv(Status),
    LvGap = lists:sort(data_answer:get_lv_gap()),
    % ?ERROR_MSG("get_answer_reward_info ~p~n", [{Lv, LvGap}]),
    case get_lv_in_gap(LvGap, Lv) of
        null -> ?ASSERT(false), null;
        Section ->
            case data_answer:get_reward(Section) of
                AnswerReward when is_record(AnswerReward, answer_reward) -> AnswerReward;
                _ -> ?ASSERT(false), null
            end
    end.


%% @doc 取得等级段
%% @return : null | integer()
get_lv_in_gap([], _Lv) -> null;
get_lv_in_gap([Section], _Lv) -> Section;
get_lv_in_gap([Down, Upper | Left], Lv) ->
    case Lv >= Down andalso Lv < Upper of
        true -> Down;
        false -> get_lv_in_gap([Upper | Left], Lv)
    end;
get_lv_in_gap(_, _) -> ?ASSERT(false), null.



%% @doc 取得连对奖励礼包
%% @return : null | {rewardId::integer(), State}
get_score_streak_reward(Streak, AswRwd) when is_record(AswRwd, answer_reward) ->
    if
        % Streak =:= ?SCORE_STREAK_1 -> AswRwd#answer_reward.streak_reward_1;
        Streak =:= ?SCORE_STREAK_2 -> AswRwd#answer_reward.streak_reward_2;
        true -> null
    end;
get_score_streak_reward(_, _) -> ?ASSERT(false), null.
    

%% @doc 取得奖励礼包
%% @return : null | {rewardId::integer(), State}
get_score_reward(Score, AswRwd, ?ANSWER_CORRECT_TYPE) when is_record(AswRwd, answer_reward) ->
    case Score >= ?SCORE_CORRECT_1 of
        true -> AswRwd#answer_reward.streak_reward_1;
        false -> null
    end;
get_score_reward(Score, AswRwd, ?ANSWER_STREAK_TYPE) when is_record(AswRwd, answer_reward) ->
    case Score >= ?SCORE_STREAK_2 of
        true -> AswRwd#answer_reward.streak_reward_2;
        false -> null
    end;
get_score_reward(_, _, _) -> ?ASSERT(false), null.


%% @doc 取得题目答案
%% @return : null | integer()
get_correct_answer(0) -> null;
get_correct_answer(Question) when is_integer(Question) ->
    data_answer:get_correct_answer(Question).


%% @doc 取得答题活动开闭时间
%% @return : [{{StartH, StartM}, {EndH, EndM}} | _]
get_activity_open_time(Sys) ->
    case data_activity_degree:get_actual_time_script(Sys) of
        List when is_list(List) -> 
            F = fun({_, _, {Hour, Min}, Duration}, Count) ->
                DurM = Duration rem 60,
                DurH = Duration div 60,
                [{{Hour, Min}, {Hour + DurH, Min + DurM}} | Count]
            end,
            lists:foldl(F, [], List);
        _ -> ?ASSERT(false), []
    end.


%% @doc 判断答题记录是否在当前答题活动内生效
%% @return : boolean()
is_in_current_activity(Now, EverTime) ->
    {NowDate, {_NowH, _NowM, _}} = util:get_datetime_by_timestamp(Now),
    {EverDate, {_EverH, _EverM, _}} = util:get_datetime_by_timestamp(EverTime),
    case NowDate =:= EverDate of
        false -> false;
        true -> true
            % TimeList = get_activity_open_time(?AD_EXAM),
            % is_in_current_activity_1({NowH, NowM}, {EverH, EverM}, TimeList)
    end.

is_in_current_activity_1(_, _, []) -> false;
is_in_current_activity_1({NowH, NowM}, {EverH, EverM}, [Section | Left]) ->
    case is_in_section(EverH, EverM, [Section]) of
        true -> 
            case is_in_section(NowH, NowM, [Section]) of
                true -> true;
                false -> false
            end;
        false ->  is_in_current_activity_1({NowH, NowM}, {EverH, EverM}, Left)
    end.



