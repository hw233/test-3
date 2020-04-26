%%%------------------------------------
%%% @author 严利宏 <542430172@qq.com>
%%% @copyright UCweb 2014.12.10
%%% @doc 女妖结婚系统函数库.
%%% @end
%%%------------------------------------

-module(lib_couple).

-include("abbreviate.hrl").
-include("buff.hrl").
-include("record/battle_record.hrl").
-include("common.hrl").
-include("record.hrl").
-include("player.hrl").
-include("monster.hrl").
-include("prompt_msg_code.hrl").
-include("log.hrl").
-include("ets_name.hrl").
-include("couple.hrl").
-include("pt_33.hrl").
-include("relation.hrl").

-compile(export_all).

%%------------------------------------------
%% 申请结婚
%%------------------------------------------
apply_marriage(PS, Type) ->
    case catch check_apply_marriage(PS, Type) of
        {error, ErrCode} -> {error, ErrCode};
        {ok, MemberPS} ->
            % 设置求婚标识（回应求婚时做判断）
            put(apply_marriage, {true, player:id(MemberPS), Type}),
            % 对伴侣发送求婚协议
            {ok, BinData} = pt_33:write(?PT_COUPLE_ASK_MARRIAGE, [player:get_name(PS)]),
            lib_send:send_to_uid(player:id(MemberPS), BinData),
            ok
    end.

% 检查申请条件
check_apply_marriage(PS, Type) ->
    % 必须组队才能申请结婚
    ?Ifc (not player:is_in_team(PS))
        throw({error, ?PM_COUPLE_ERROR_MARRIAGE_NO_TEAM})
    ?End,

    % 必须队长才能申请结婚
    ?Ifc (not player:is_leader(PS))
        throw({error, ?PM_COUPLE_ERROR_MARRIAGE_NOT_LEADER})
    ?End,

    TeamId = player:get_team_id(PS),
    % 伴侣必须归队
    ?Ifc (not mod_team:is_all_member_in_normal_state(TeamId))
        throw({error, ?PM_COUPLE_ERROR_MARRIAGE_NO_RETURN})
    ?End,

    % 队伍人数只能是夫妻二人
    TeamMemberCount = mod_team:get_normal_member_count(TeamId),
    ?Ifc (not (TeamMemberCount =:= 2))
        throw({error, ?PM_COUPLE_ERROR_MARRIAGE_TOO_MANY_MEMBER})
    ?End,

    [MemberId] = mod_team:get_all_member_id_list(TeamId)--[player:id(PS)],
    MemberPS = player:get_PS(MemberId),
    ?ASSERT(is_record(MemberPS, player_status), {MemberId, MemberPS}),

    ?Ifc (MemberPS =:= null)
        throw({error, ?PM_TARGET_PLAYER_NOT_ONLINE})
    ?End,

    Data = data_couple:get(marry, Type),
    ?Ifc (Data =:= null)
        throw({error, ?PM_DATA_CONFIG_ERROR})
    ?End,

    MinLv = Data#couple_cfg.lv_limit,

    % 等级判断
    ?Ifc (player:get_lv(PS) < MinLv)
        throw({error, ?PM_COUPLE_ERROR_MARRIAGE_MY_LV_LIMIT})
    ?End,
    ?Ifc (player:get_lv(MemberPS) < MinLv)
        throw({error, ?PM_COUPLE_ERROR_MARRIAGE_MEMBER_LV_LIMIT})
    ?End,

    %% 性别判断
    ?Ifc (player:get_sex(PS) =:= player:get_sex(MemberPS))
        throw({error, ?PM_COUPLE_ERROR_MARRIAGE_SAME_SEX})
    ?End,

    %% 判断是否已经结婚
    ?Ifc (ply_relation:get_spouse_id(PS) =/= ?INVALID_ID) 
        throw({error, ?PM_COUPLE_ERROR_MARRIAGE_YOU_HAVE_SPOUSE})
    ?End,

    ?Ifc(ply_relation:get_spouse_id(MemberPS) =/= ?INVALID_ID)
        throw({error, ?PM_COUPLE_ERROR_MARRIAGE_MEMBER_HAVE_SPOUSE})
    ?End,

	%% 上次是强制离婚的必须要三天后才能结婚
	RelaInfo = ply_relation:get_rela_info(player:id(PS)),
	RelaInfoMember = ply_relation:get_rela_info(MemberId),
	Pred = fun(#relation_info{time_divorce = TimeDivorce, last_divorce_force = LastDivorceForce}) ->
				LastDivorceForce == 1 andalso util:get_nth_day_from_time_to_now(TimeDivorce) =< 3
		   end,
	?Ifc ( Pred(RelaInfo) orelse Pred(RelaInfoMember) )
        throw({error, ?PM_COUPLE_CANT_DEVORCE_LAST_THREE_DAYS})
    ?End,

    Intimacy = ply_relation:get_intimacy_between_AB(player:id(PS), player:id(MemberPS)),
    MinIntimacy = Data#couple_cfg.intimacy_limit,
    % 活跃度判断
    ?Ifc ( Intimacy < MinIntimacy )
        throw({error, ?PM_COUPLE_ERROR_MARRIAGE_INTIMACY_LIMIT})
    ?End,

    CostMoney = Data#couple_cfg.need_money,
    RetMoney = check_money(PS, CostMoney),

    ?Ifc (RetMoney =/= 0)
        throw({error, RetMoney})
    ?End,

    {ok, MemberPS}.



check_money(_PS, []) ->
    0;
check_money(PS, [{MoneyType, Count} | T]) ->
    case player:has_enough_money(PS, MoneyType, Count) of
        false ->
            case MoneyType of
                ?MNY_T_GAMEMONEY -> ?PM_GAMEMONEY_LIMIT;
                ?MNY_T_YUANBAO -> ?PM_YB_LIMIT;
                ?MNY_T_BIND_GAMEMONEY -> ?PM_BIND_GAMEMONEY_LIMIT;
                ?MNY_T_BIND_YUANBAO -> ?PM_BIND_YB_LIMIT
            end;
        true -> check_money(PS, T)
    end;
check_money(_PS, _) ->
    ?PM_DATA_CONFIG_ERROR.

%%------------------------------------------
%% 回应求婚
%%------------------------------------------
% 拒绝结婚
respond_marriage(PS, ?YOU_ARE_A_GOOD_PERSON) ->
    % 回复队长拒绝求婚
    case mod_team:get_team_by_id(player:get_team_id(PS)) of
        null -> skip;%%{error, ?PM_COUPLE_ERROR_SYS};
        Team ->
            LeaderId = mod_team:get_leader_id(Team),
            case player:id(PS)=/=LeaderId of
                true ->
                    lib_send:send_prompt_msg(LeaderId, ?PM_COUPLE_ERROR_RESPOND_MEMBER_REFUSE),
                    ok;
                false -> % 队长变成了我？对方逃婚了？
                    {error, ?PM_COUPLE_ERROR_RESPOND_SOMEONE_ESCAPE}
            end
    end;
% 答应求婚
respond_marriage(PS, ?YES_I_DO) ->
    case catch check_respond_marriage(PS) of
        {error, ErrCode} -> {error, ErrCode};
        {ok, LeaderPS} ->
            % 通知队长处理答应求婚
            case catch gen_server:call(player:get_pid(LeaderPS), {apply_call, ?MODULE, handle_respond_yes_I_do_by_leader, [player:id(LeaderPS), player:id(PS)]}) of
                {error, ErrCode} -> {error, ErrCode};
                {ok, Type} ->
                    % 设置配偶信息
                    gen_server:cast(?RELATION_PROCESS, {'marry_ok', LeaderPS, PS, Type}),
                    ok;
                _ -> {error, ?PM_COUPLE_ERROR_SYS}
            end
    end.

check_respond_marriage(PS) ->
    % 必须组队才能 答应求婚
    ?Ifc (not player:is_in_team(PS))
        throw({error, ?PM_COUPLE_ERROR_RESPOND_NO_TEAM})
    ?End,

    TeamId = player:get_team_id(PS),
    LeaderId = mod_team:get_leader_id(TeamId),
    % 队长变成了我？对方逃婚了？
    ?Ifc (player:id(PS) =:= LeaderId)
        throw({error, ?PM_COUPLE_ERROR_RESPOND_SOMEONE_ESCAPE})
    ?End,
    
    % 队伍人数只能是夫妻二人
    TeamMemberCount = mod_team:get_member_count(TeamId),
    ?Ifc (not (TeamMemberCount =:= 2))
        throw({error, ?PM_COUPLE_ERROR_RESPOND_TOO_MANY_MEMBER})
    ?End,

    % 队长不在线？又逃婚？
    LeaderPS = player:get_PS(LeaderId),
    ?Ifc (not is_record(LeaderPS, player_status))
        throw({error, ?PM_COUPLE_ERROR_RESPOND_SOMEONE_ESCAPE})
    ?End,

    ?Ifc (ply_relation:get_spouse_id(PS) =/= ?INVALID_ID) 
        throw({error, ?PM_COUPLE_ERROR_MARRIAGE_YOU_HAVE_SPOUSE})
    ?End,

    ?Ifc(ply_relation:get_spouse_id(LeaderPS) =/= ?INVALID_ID)
        throw({error, ?PM_COUPLE_ERROR_MARRIAGE_MEMBER_HAVE_SPOUSE})
    ?End,
    % 其他条件在求婚者求婚的时候做判断了

    {ok, LeaderPS}.

% 队长处理答应离婚 (在队长进程执行)
handle_respond_devorce(LeaderId, MemberId) ->
    PS = player:get_PS(LeaderId),
    case catch check_handle_respond_devorce(PS, MemberId) of
        {error, ErrCode} -> 
            lib_send:send_prompt_msg(MemberId, ErrCode),
            {error, ErrCode};
        {ok, Devorcetype} ->
            %% 扣钱
            DataCfg = data_couple:get(divorce, 1),
            cost_money(PS, DataCfg#couple_cfg.need_money, [?LOG_COUPLE, "devorce"]),
            
            {ok, Devorcetype}
    end.

check_handle_respond_devorce(PS, MemberId) -> 
    % 检查是否有发出求婚
    Flag = get(apply_devorce),
    ?Ifc (Flag =:= undefined)
        throw({error, ?PM_COUPLE_PULL_BACK_DEVORCE})
    ?End,

    {Id, _Devorcetype, TimeStamp} = Flag,

    ?Ifc (Id =/= MemberId)
        throw({error, ?PM_UNKNOWN_ERR})
    ?End,

    ?Ifc (util:unixtime() - TimeStamp > 70)
        throw({error, ?PM_COUPLE_PULL_BACK_DEVORCE})
    ?End,

    Data = data_couple:get(divorce, 1),
    ?Ifc (Data =:= null)
        throw({error, ?PM_DATA_CONFIG_ERROR})
    ?End,

    RetMoney = check_money(PS, Data#couple_cfg.need_money),

    ?Ifc (RetMoney =/= 0)
        throw({error, RetMoney})
    ?End,

    {ok, _Devorcetype}.

% 队长处理答应求婚 (在队长进程执行)
handle_respond_yes_I_do_by_leader(LeaderId, MemberId) ->
    PS = player:get_PS(LeaderId),
    case catch check_handle_respond_yes_I_do(PS, MemberId) of
        {error, ErrCode} ->
            lib_send:send_prompt_msg(LeaderId, ErrCode),
            {error, ErrCode};
        {ok, Type} ->
            %% 扣钱
            DataCfg = data_couple:get(marry, Type),
            cost_money(PS, DataCfg#couple_cfg.need_money, [?LOG_COUPLE, "marry"]),
            
            {ok, Type}
    end.

check_handle_respond_yes_I_do(PS, MemberId) -> 
    % 检查是否有发出求婚
    {true, ObjId, Type} = get(apply_marriage),
    ?Ifc (not (ObjId =:= MemberId) )
        throw({error, ?PM_COUPLE_ERROR_RESPOND_NOT_APPLY_MARRIAGE})
    ?End,

    Data = data_couple:get(marry, Type),
    ?Ifc (Data =:= null)
        throw({error, ?PM_DATA_CONFIG_ERROR})
    ?End,

    RetMoney = check_money(PS, Data#couple_cfg.need_money),

    ?Ifc (RetMoney =/= 0)
        throw({error, RetMoney})
    ?End,

    {ok, Type}.



learn_skill(PS, SkillId) ->
    case check_learn_skill(PS, SkillId) of
        {fail, Reason} ->
            {fail, Reason};
        ok ->
            do_learn_skill(PS, SkillId)
    end.

check_learn_skill(PS, SkillId) ->
    try 
        check_learn_skill__(PS, SkillId)
    catch 
        throw: FailReason ->
            FailReason
    end.

check_learn_skill__(PS, SkillId) ->
    SpouseId = ply_relation:get_spouse_id(PS),
    ?Ifc (SpouseId =:= ?INVALID_ID) 
        throw({fail, ?PM_COUPLE_NO_SPOUSE})
    ?End,

    Data = data_couple:get(learn_skill, SkillId),
    ?Ifc (Data =:= null)
        throw({fail, ?PM_DATA_CONFIG_ERROR})
    ?End,

    ?Ifc (ply_relation:get_intimacy_between_AB(player:id(PS), SpouseId) < Data#couple_cfg.intimacy_limit)
        throw({fail, ?PM_COUPLE_INTIMACY_LIMIT_FOR_SKILL})
    ?End,
    ok.

do_learn_skill(PS, SkillId) ->
    gen_server:cast(?RELATION_PROCESS, {'learn_couple_skill', player:id(PS), SkillId}).

%% return | {fail, Reason}
check_apply_couple_cruise_base(PS, Type) ->
    try 
        check_apply_couple_cruise_base__(PS, Type)
    catch 
        throw: FailReason ->
            FailReason
    end.

check_apply_couple_cruise_base__(PS, Type) ->
    SpouseId = ply_relation:get_spouse_id(PS),
    ?Ifc (SpouseId =:= ?INVALID_ID) 
        throw({fail, ?PM_COUPLE_NO_SPOUSE})
    ?End,

    Data = data_couple:get(cruise, Type),
    ?Ifc (Data =:= null)
        throw({fail, ?PM_DATA_CONFIG_ERROR})
    ?End,

    % 必须组队才能申请结婚
    ?Ifc (not player:is_in_team(PS))
        throw({fail, ?PM_COUPLE_ERROR_MARRIAGE_NO_TEAM})
    ?End,

    % 必须队长才能申请结婚
    ?Ifc (not player:is_leader(PS))
        throw({fail, ?PM_COUPLE_ERROR_MARRIAGE_NOT_LEADER})
    ?End,

    TeamId = player:get_team_id(PS),
    % 伴侣必须归队
    ?Ifc (not mod_team:is_all_member_in_normal_state(TeamId))
        throw({fail, ?PM_COUPLE_ERROR_MARRIAGE_NO_RETURN})
    ?End,

    % 队伍人数只能是夫妻二人
    TeamMemberCount = mod_team:get_normal_member_count(TeamId),
    ?Ifc (not (TeamMemberCount =:= 2))
        throw({fail, ?PM_COUPLE_APPLY_WITH_SPOUSE})
    ?End,

    [MemberId] = mod_team:get_all_member_id_list(TeamId)--[player:id(PS)],
    MemberPS = player:get_PS(MemberId),
    ?ASSERT(is_record(MemberPS, player_status), {MemberId, MemberPS}),

    ?Ifc (MemberPS =:= null)
        throw({fail, ?PM_TARGET_PLAYER_NOT_ONLINE})
    ?End,

    ?Ifc (SpouseId =/= MemberId)
        throw({fail, ?PM_COUPLE_OBJ_NOT_YOUR_SPOUSE})
    ?End,

    RetMoney = check_money(PS, Data#couple_cfg.need_money),

    ?Ifc (RetMoney =/= 0)
        throw({fail, RetMoney})
    ?End,

    ok.

check_apply_devorce(PS, Devorcetype) ->
    try 
        check_apply_devorce__(PS, Devorcetype)
    catch 
        throw: FailReason ->
            FailReason
    end.

check_apply_devorce__(PS, Devorcetype) ->
    ?Ifc (not lists:member(Devorcetype, [1, 2, 3]))
        throw({fail, ?PM_PARA_ERROR})
    ?End,

    Data = data_couple:get(divorce, Devorcetype),
    ?Ifc (Data =:= null)
        throw({fail, ?PM_DATA_CONFIG_ERROR})
    ?End,

    RetMoney = check_money(PS, Data#couple_cfg.need_money),

    ?Ifc (Devorcetype =:= 2 andalso RetMoney =/= 0)
        throw({fail, RetMoney})
    ?End,

    % 必须组队才能申请结婚
    ?Ifc (Devorcetype =:= 1 andalso (not player:is_in_team(PS)))
        throw({fail, ?PM_COUPLE_ERROR_MARRIAGE_NO_TEAM})
    ?End,

    SpouseId = ply_relation:get_spouse_id(PS),
    ?Ifc(SpouseId =:= ?INVALID_ID)
        throw({fail, ?PM_COUPLE_NOT_MARRY})
    ?End,

    TeamId = player:get_team_id(PS),
    % 队伍人数只能是夫妻二人
    ?Ifc (Devorcetype =:= 1 andalso not (mod_team:get_normal_member_count(TeamId) =:= 2))
        throw({fail, ?PM_COUPLE_APPLY_WITH_SPOUSE})
    ?End,

	%% 必须要结婚三天后才能离婚
	RelaInfo = ply_relation:get_rela_info(player:id(PS)),
	?Ifc ( util:get_nth_day_from_time_to_now(RelaInfo#relation_info.time_marry) =< 3 )
        throw({fail, ?PM_COUPLE_CANT_DEVORCE_THREE_DAYS})
    ?End,

    TimeCmp = 
        case player:get_PS(SpouseId) of
            null -> 
                case ply_tmplogout_cache:get_tmplogout_PS(SpouseId) of
                    null -> player:get_last_logout_time(SpouseId);
                    _TPS -> util:unixtime()
                end;
            _PS -> util:unixtime()
        end,

    ?Ifc (Devorcetype =:= 3 andalso TimeCmp =:= 0)
        throw({fail, ?PM_COUPLE_CANT_DEVORCE_NOW})
    ?End,

    ?Ifc (Devorcetype =:= 3 andalso TimeCmp =/= 0 andalso util:get_nth_day_from_time_to_now(TimeCmp) =< 7)
        throw({fail, ?PM_COUPLE_CANT_DEVORCE_NOW})
    ?End,

    case Devorcetype =:= 1 of
        true ->
            case TeamId =/= ?INVALID_ID of
                true ->
                    MbList = mod_team:get_all_member_id_list(TeamId)--[player:id(PS)],
                    ?Ifc (length(MbList) =/= 1)
                        throw({fail, ?PM_COUPLE_APPLY_WITH_SPOUSE})
                    ?End,

                    ?Ifc (SpouseId =/= erlang:hd(MbList))
                        throw({fail, ?PM_COUPLE_OBJ_NOT_YOUR_SPOUSE})
                    ?End;
                false -> throw({fail, ?PM_COUPLE_ERROR_MARRIAGE_NO_TEAM})
            end;
        false -> skip 
    end,
    ok.


do_apply_devorce(PS, Devorcetype) ->
    MemberId = 
        case player:get_team_id(PS) of
            ?INVALID_ID -> 
                ?INVALID_ID;
            TeamId ->
                L = mod_team:get_normal_member_id_list(TeamId) -- [player:id(PS)],
                case L =:= [] of
                    true -> ?INVALID_ID;
                    false -> erlang:hd(L)
                end
        end,

    % 设置求离婚标识（回应时做判断）
    case Devorcetype =:= 1 of
        false ->
            DataCfg = data_couple:get(divorce, Devorcetype),
            cost_money(PS, DataCfg#couple_cfg.need_money, [?LOG_COUPLE, "devorce"]),
            
            gen_server:cast(?RELATION_PROCESS, {'devorce_ok', PS, ply_relation:get_spouse_id(PS), Devorcetype});
        true -> 
            put(apply_devorce, {MemberId, Devorcetype, util:unixtime()}),
            % 对伴侣发送求离婚协议
            {ok, BinData} = pt_33:write(?PT_COUPLE_ASK_DEVORCE, [player:get_name(PS)]),
            lib_send:send_to_uid(MemberId, BinData)
    end,
    ok.


% 拒绝离婚
respond_devorce(PS, ?YOU_ARE_A_GOOD_PERSON) ->
    % 回复队长拒绝求婚
    case mod_team:get_team_by_id(player:get_team_id(PS)) of
        null -> {error, ?PM_COUPLE_ERROR_SYS};
        Team ->
            LeaderId = mod_team:get_leader_id(Team),
            case player:id(PS) =/= LeaderId of
                true ->
                    lib_send:send_prompt_msg(LeaderId, ?PM_COUPLE_RESPOND_MEMBER_REFUSE_DEVORCE),
                    ok;
                false -> % 队长变成了我？对方逃婚了？
                    {error, ?PM_COUPLE_PULL_BACK_DEVORCE}
            end
    end;
% 答应离婚
respond_devorce(PS, ?YES_I_DO) ->
    case catch check_respond_devorce(PS) of
        {error, ErrCode} -> {error, ErrCode};
        {ok, LeaderPS} ->
            % 通知队长处理答应离婚
            case catch gen_server:call(player:get_pid(LeaderPS), {apply_call, ?MODULE, handle_respond_devorce, [player:id(LeaderPS), player:id(PS)]}) of
                {error, ErrCode} -> {error, ErrCode};
                {ok, Devorcetype} ->
                    % 设置配偶信息
                    gen_server:cast(?RELATION_PROCESS, {'devorce_ok', LeaderPS, PS, Devorcetype}),
                    ok;
                _ -> {error, ?PM_COUPLE_ERROR_SYS}
            end
    end.

check_respond_devorce(PS) ->
    % 必须组队才能 答应离婚
    ?Ifc (not player:is_in_team(PS))
        throw({error, ?PM_COUPLE_ERROR_RESPOND_NO_TEAM})
    ?End,

    TeamId = player:get_team_id(PS),
    LeaderId = mod_team:get_leader_id(TeamId),
    % 队长变成了我？对方逃婚了？
    ?Ifc (player:id(PS) =:= LeaderId)
        throw({error, ?PM_COUPLE_PULL_BACK_DEVORCE})
    ?End,
    
    % 队伍人数只能是夫妻二人
    TeamMemberCount = mod_team:get_member_count(TeamId),
    ?Ifc (not (TeamMemberCount =:= 2))
        throw({error, ?PM_COUPLE_APPLY_WITH_SPOUSE})
    ?End,

    % 队长不在线？又逃婚？
    LeaderPS = player:get_PS(LeaderId),
    ?Ifc (not is_record(LeaderPS, player_status))
        throw({error, ?PM_COUPLE_PULL_BACK_DEVORCE})
    ?End,

    % 其他条件在求婚者求婚的时候做判断了

    {ok, LeaderPS}.


show_fireworks({SceneId, X, Y}, Type) ->
    {ok, BinData} = pt_33:write(?PT_COUPLE_SHOW_FIREWORKS, [Type, SceneId, X, Y]),
    lib_send:send_to_AOI({SceneId, X, Y}, BinData).


%% 通知夫妻双方处于巡游状态
notify_cruising_state(PS) ->
    {ok, BinData} = pt_33:write(?PT_COUPLE_CRUISE_STATE, []),
    lib_send:send_to_sock(PS, BinData).



cost_money(PS, MoneyList, LogInfo) ->
    case length(MoneyList) of
        0 -> skip;
        1 ->
            {MoneyType1, Money1} = lists:nth(1, MoneyList),
            player:cost_money(PS, MoneyType1, Money1, LogInfo);
        2 ->
            {MoneyType1, Money1} = lists:nth(1, MoneyList),
            {MoneyType2, Money2} = lists:nth(2, MoneyList),
            player:cost_money(PS, MoneyType1, Money1, LogInfo),
            player:cost_money(PS, MoneyType2, Money2, LogInfo)
    end.