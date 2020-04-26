%%%--------------------------------------
%%% @Module  : pp_player
%%% @Author  :
%%% @Email   :
%%% @Created : 2011.05.12
%%% @Modified: 2013.8 -- huangjf
%%% @Description:  玩家信息相关协议
%%%--------------------------------------
-module(pp_player).
-export([handle/3]).

-include("common.hrl").
-include("record.hrl").
-include("player.hrl").
-include("pt_13.hrl").
-include("prompt_msg_code.hrl").
-include("reward.hrl").
-include("log.hrl").
-include("ets_name.hrl").
-include("goods.hrl").

%% 获取玩家自己的简要信息
handle(?PT_PLYR_GET_MY_BRIEF, PS, _) ->
    {ok, BinData} = pt_13:write(?PT_PLYR_GET_MY_BRIEF, PS),
    lib_send:send_to_sock(PS, BinData);


%% 获取指定玩家的属性详情（只支持获取在线的玩家）
handle(?PT_PLYR_GET_INFO_DETAILS, PS, TargetId) ->
	?TRACE("got cmd: PT_PLYR_GET_ATTR_DETAILS...~n"),
    MyId = player:id(PS),
    TargetPS =  case TargetId of
                    MyId -> PS;
                    _ -> player:get_PS(TargetId)
                end,
    case TargetPS of
        null ->
            skip;
        _ ->
            {ok, BinData} = pt_13:write(?PT_PLYR_GET_INFO_DETAILS, TargetPS),
            lib_send:send_to_sock(PS, BinData)
    end;


%% 分配自由天赋点（手动加天赋点）
handle(?PT_PLYR_ALLOT_FREE_TALENT_POINTS, PS, AllotInfoList) ->
    case check_allot_free_talent_points(PS, AllotInfoList) of
        ok ->
            ply_attr:allot_free_talent_points(PS, AllotInfoList),
            gen_server:cast(player:get_pid(PS), {'post_allot_free_talent_points', player:get_hp_lim(PS), player:get_mp_lim(PS)}),
            mod_achievement:notify_achi('jiadian_renwu', [], PS);
        fail ->
            skip
    end,
    void;


handle(?PT_PLYR_RESET_FREE_TALENT_POINTS, PS, _) ->
    case player:get_lv(PS) > ?FREE_WASH_POINT_LV of
        false ->
            NowLv = player:get_lv(PS),
            DeltaLv = NowLv - ?PLAYER_BORN_LV,
            FreePoint = DeltaLv * 5,

            player:add_base_con(PS, 0 - player:get_base_con(PS) + NowLv),      %% 体质
            player:add_base_stam(PS, 0 - player:get_base_stam(PS) + NowLv),    %% 耐力
            player:add_base_spi(PS, 0 - player:get_base_spi(PS) + NowLv),      %% 灵力
            player:add_base_agi(PS, 0 - player:get_base_agi(PS) + NowLv),      %% 敏捷
            player:add_base_str(PS, 0 - player:get_base_str(PS) + NowLv),      %% 力量

            player:add_free_talent_points(PS, 0 -player:get_free_talent_points(PS) + FreePoint);
        true ->
            lib_send:send_prompt_msg(PS, ?PM_FREE_WASH_POINT_LV_LIMIT)
    end,
    void;
	
%% 请求月卡周卡终身卡活动数据
handle(?PT_PLYR_CHECK_MONTH_CARD, PS, _) ->
	player:query_month_card_data(PS),
%%     {ok, BinData} = pt_13:write(?PT_PLYR_RECHARGE_REWARD_STATE, [PS#player_status.first_recharge_reward_state]),
%%     lib_send:send_to_uid(player:id(PS), BinData),
    void;


%% 领取月卡奖励 
handle(?PT_PLYR_REWARD_MONTH_CARD, PS, [Type]) ->
	case player:reward_month_card(PS, Type) of
		ok ->
			void;
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason)
	end;


%% 查询成长基金的数据
handle(?PT_PLYR_CHECK_FUND, PS, _) ->

	player:query_growth_fund_data(PS),
%%     {ok, BinData} = pt_13:write(?PT_PLYR_RECHARGE_REWARD_STATE, [PS#player_status.first_recharge_reward_state]),
%%     lib_send:send_to_uid(player:id(PS), BinData),
    void;






%% 领取成长基金奖励 
handle(?PT_PLYR_GET_FUND, PS, [Type,Lv]) ->
 
	case player:reward_growth_fund(PS, Type,Lv) of
		ok ->
			void;
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason)
	end;




%% --------------------------------------------------------------------------- %%
% 兑换分配点
handle(?PT_PLYR_JINGMAI_EXCHANGE, PS, [Count]) ->
    Ret = case mod_player:exchange_jingmai_point(PS, Count) of
        R when is_integer(R) -> R;
        {fail,Reason} -> 
            lib_send:send_prompt_msg(PS, Reason),
            1;
        _ -> 1
    end,

    % 获取最新的PS
    PS2 = player:get_PS(player:id(PS)),

    {ok, BinData} = pt_13:write(?PT_PLYR_JINGMAI_EXCHANGE, [Ret, Count]),
    lib_send:send_to_sock(PS, BinData),

    % 前面做一系列操作
    handle(?PT_PLYR_GET_JINGMAI, PS2, []),
    void;



% 飞升
handle(?PT_SOARING, PS, _) ->
    CurLv = player:get_soaring(PS),
    Ret = case mod_player:up_soaring(PS) of
        R when is_integer(R) -> R;
        {fail,Reason} -> 
            lib_send:send_prompt_msg(PS, Reason),
            1;
        _ -> 1
    end,

    % 获取最新的PS
    PS2 = player:get_PS(player:id(PS)),

    {ok, BinData} = pt_13:write(?PT_SOARING, [Ret ,CurLv + 1]),
    lib_send:send_to_sock(PS, BinData),
    void;


% 重置分配点
handle(?PT_PLYR_RESET_JINGMAI_POINT, PS, _) ->

    Ret = case mod_player:wash_jingmai_point(PS) of
        R when is_integer(R) -> R;
        {fail,Reason} -> 
            lib_send:send_prompt_msg(PS, Reason),
            1;
        _ -> 1
    end,

    % 获取最新的PS
    PS2 = player:get_PS(player:id(PS)),

    {ok, BinData} = pt_13:write(?PT_PLYR_RESET_JINGMAI_POINT, Ret),
    lib_send:send_to_sock(PS, BinData),

    % 前面做一系列操作
    handle(?PT_PLYR_GET_JINGMAI, PS2, []),
    void;

% 获取经脉分配详情
handle(?PT_PLYR_GET_JINGMAI, PS, _) ->
    {ok, BinData} = pt_13:write(?PT_PLYR_GET_JINGMAI, PS),
    lib_send:send_to_sock(PS, BinData),
    void;

% 进行分配
handle(?PT_PLYR_SET_JINGMAI, PS, AddInfos) ->
    Ret = mod_player:do_set_jingmai_point(PS,AddInfos),

    {ok, BinData} = pt_13:write(?PT_PLYR_SET_JINGMAI, Ret),
    lib_send:send_to_sock(PS, BinData),

    % 获取最新的PS
    PS2 = player:get_PS(player:id(PS)),
    % 前面做一系列操作
    handle(?PT_PLYR_GET_JINGMAI, PS2, []),
    void;



%% --------------------------------------------------------------------------- %%
%% 手动升级
handle(?PT_PLYR_MANUAL_UPGRADE, PS, _) ->
    case player:can_upgrade(PS) of
        false ->
            skip;
        true ->
            player:do_upgrade(PS)
    end,
    void;


handle(?PT_PLYR_JOIN_FACTION, PS, [Faction]) ->
    case ply_faction:can_join_faction(PS, Faction) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason),
            {ok, BinData} = pt_13:write(?PT_PLYR_JOIN_FACTION, [?RES_FAIL, Faction]),
            lib_send:send_to_sock(PS, BinData);
        ok ->
            ply_faction:join_faction(PS, Faction),
            {ok, BinData} = pt_13:write(?PT_PLYR_JOIN_FACTION, [?RES_OK, Faction]),
            lib_send:send_to_sock(PS, BinData)
    end;

handle(?PT_PLYR_TRANSFORM_FACTION, PS, [Faction,Sex,Race]) ->
    ?DEBUG_MSG("PT_PLYR_TRANSFORM_FACTION: ~p.", [Faction]),
    ?DEBUG_MSG("PS: ~p.", [PS]),

    case ply_faction:check_can_transform_faction(PS) of
        {fail, Reason} ->
           lib_send:send_prompt_msg(PS, Reason),
           {ok, BinData} = pt_13:write(?PT_PLYR_TRANSFORM_FACTION, [?RES_FAIL, Faction]),
           lib_send:send_to_sock(PS, BinData);
        ok ->
            ply_faction:transform_faction(PS, Faction,Sex,Race),
            {ok, BinData} = pt_13:write(?PT_PLYR_TRANSFORM_FACTION, [?RES_OK, Faction]),
            lib_send:send_to_sock(PS, BinData)
        % Ret ->
        %     ?DEBUG_MSG("Ret: ~p.", [Ret]),
        %     void
    end;

handle(?PT_PLYR_GET_LAST_TRANSFORM_TIME, PS, []) ->
    LastTansformTime = player:get_last_transform_time(PS),
    {ok, BinData} = pt_13:write(?PT_PLYR_GET_LAST_TRANSFORM_TIME, [LastTansformTime]),
    lib_send:send_to_sock(PS, BinData);


handle(?PT_PLYR_QUERY_OL_STATE, PS, [PlayerId]) ->
    OLState =
        case player:id(PS) =:= PlayerId of
            true -> 1;
            false ->
                case player:is_online(PlayerId) of
                    true -> 1;
                    false -> 0
                end
        end,
    {ok, BinData} = pt_13:write(?PT_PLYR_QUERY_OL_STATE, [PlayerId, OLState]),
    lib_send:send_to_sock(PS, BinData);


handle(?PT_PLYR_GET_EQUIP_INFO, PS, [TargetId]) ->
    ?TRACE("got cmd: PT_PLYR_GET_EQUIP_INFO...~n"),
    MyId = player:id(PS),
    TargetPS =  case TargetId of
                    MyId -> PS;
                    _ -> player:get_PS(TargetId)
                end,
    case TargetPS of
        null ->
            skip;
        _ ->
            {ok, BinData} = pt_13:write(?PT_PLYR_GET_EQUIP_INFO, TargetPS),
            lib_send:send_to_sock(PS, BinData)
    end;


handle(?PT_PLYR_GET_STOR_HP_MP, PS, []) ->
    {ok, BinData} = pt_13:write(?PT_PLYR_GET_STOR_HP_MP, [PS]),
    lib_send:send_to_sock(PS, BinData);


handle(?PT_PLYR_SET_AUTO_ADD_HP_MP_STATE, PS, [Type, State]) ->
    case (Type =/= 1 andalso Type =/= 2) orelse (State =/= 0 andalso State =/= 1) of
        true ->
            lib_send:send_prompt_msg(PS, ?PM_PARA_ERROR);
        false ->
            case Type of
                1 -> ply_setting:set_auto_add_store_hp_mp(player:id(PS), State);
                2 -> ply_setting:set_auto_add_store_par_hp_mp(player:id(PS), State)
            end,
            {ok, BinData} = pt_13:write(?PT_PLYR_SET_AUTO_ADD_HP_MP_STATE, [Type, State]),
            lib_send:send_to_sock(PS, BinData)
    end;


handle(?PT_PLYR_SET_BUFF_STATE, PS, [BuffNo, OpenState]) ->
    case lib_buff:set_buff_state(player:id(PS), BuffNo, OpenState) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        ok ->
            {ok, BinData} = pt_13:write(?PT_PLYR_SET_BUFF_STATE, [?RES_OK, BuffNo, OpenState]),
            lib_send:send_to_sock(PS, BinData)
    end;


handle(?PT_PLYR_SIGN_IN, PS, _) ->
    case ply_day_reward:sign_in(PS) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        ok ->
            {ok, BinData} = pt_13:write(?PT_PLYR_SIGN_IN, [?RES_OK]),
            lib_send:send_to_sock(PS, BinData)
    end;


handle(?PT_PLYR_GET_SIGN_IN_INFO, PS, _) ->
    case ply_day_reward:get_day_sign_in_info(PS) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        DayReward ->
            {SignInfo, RewardInfo} =
                case DayReward of
                    null -> {0, 0};
                    _Any -> {DayReward#day_reward.sign_info, DayReward#day_reward.sign_reward_info}
                end,
            {ok, BinData} = pt_13:write(?PT_PLYR_GET_SIGN_IN_INFO, [SignInfo, RewardInfo]),
            lib_send:send_to_sock(PS, BinData)
    end;


handle(?PT_PLYR_ASK_FOR_SIGN_IN_REWARD, PS, [No]) ->
    case ply_day_reward:get_sign_in_reward(PS, No) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        ok ->
            {ok, BinData} = pt_13:write(?PT_PLYR_ASK_FOR_SIGN_IN_REWARD, [?RES_OK, No]),
            lib_send:send_to_sock(PS, BinData)
    end;


handle(?PT_PLYR_GET_ONLINE_REWARD_INFO, PS, _) ->
    case ply_day_reward:get_online_reward_info(PS) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        DayReward ->
            {ok, BinData} = pt_13:write(?PT_PLYR_GET_ONLINE_REWARD_INFO, [DayReward#day_reward.cur_no, DayReward#day_reward.last_get_reward_time]),
            lib_send:send_to_sock(PS, BinData)
    end;


handle(?PT_PLYR_GET_ONLINE_REWARD, PS, [CurNo]) ->
    case ply_day_reward:get_online_reward(PS, CurNo) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        {ok, DayReward} ->
            {ok, BinData} = pt_13:write(?PT_PLYR_GET_ONLINE_REWARD, [?RES_OK, DayReward#day_reward.cur_no, DayReward#day_reward.last_get_reward_time]),
            lib_send:send_to_sock(PS, BinData)
    end;


handle(?PT_PLYR_GET_SEVEN_DAY_REWARD_INFO, PS, _) ->
    case ply_day_reward:get_seven_day_reward_info(PS) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        DayReward ->
            CreateTime = player:get_create_time(PS),
            DeltaDay = util:get_nth_day_from_time_to_now(CreateTime),
            Day =
                case DeltaDay > 7 of
                    true -> 0;
                    false -> DeltaDay
                end,

            {ok, BinData} = pt_13:write(?PT_PLYR_GET_SEVEN_DAY_REWARD_INFO, [Day, DayReward#day_reward.seven_day_reward]),
            lib_send:send_to_sock(PS, BinData)
    end;


handle(?PT_PLYR_GET_SEVEN_DAY_REWARD, PS, [CurNo]) ->
    case ply_day_reward:get_seven_day_reward(PS, CurNo) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        {ok, DayReward} ->
            {ok, BinData} = pt_13:write(?PT_PLYR_GET_SEVEN_DAY_REWARD, [?RES_OK, DayReward#day_reward.seven_day_reward]),
            lib_send:send_to_sock(PS, BinData)
    end;

handle(?PT_PLYR_GET_LV_REWARD_INFO, PS, _) ->
    DayReward = ply_day_reward:get_lv_reward_info(PS),
    {ok, BinData} = pt_13:write(?PT_PLYR_GET_LV_REWARD_INFO, [DayReward#day_reward.lv_reward_no_list]),
    lib_send:send_to_sock(PS, BinData);

handle(?PT_PLYR_GET_LV_REWARD, PS, [No]) ->
    case ply_day_reward:get_lv_reward(PS, No) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        ok ->
            {ok, BinData} = pt_13:write(?PT_PLYR_GET_LV_REWARD, [No]),
            lib_send:send_to_sock(PS, BinData)
    end;            


handle(?PT_PLYR_QRY_MY_OPENED_SYS_LIST, PS, _) ->
    L = ply_sys_open:get_opened_sys_list(PS),
    ?TRACE("PT_PLYR_QRY_MY_OPENED_SYS_LIST, L:~p~n", [L]),
    {ok, Bin} = pt_13:write(?PT_PLYR_QRY_MY_OPENED_SYS_LIST, L),
    lib_send:send_to_sock(PS, Bin);



handle(?PT_PLYR_SET_CAN_BE_LEADER_STATE, PS, [State]) ->
    case State =/= 1 andalso State =/= 0 of
        true -> lib_send:send_prompt_msg(PS, ?PM_PARA_ERROR);
        false ->
            ply_setting:set_can_be_leader_state(player:id(PS), State),
            {ok, BinData} = pt_13:write(?PT_PLYR_SET_CAN_BE_LEADER_STATE, [State]),
            lib_send:send_to_sock(PS, BinData)
    end;


handle(?PT_PLYR_SET_TEAM_INVITE_STATE, PS, [State]) ->
    case State =/= 1 andalso State =/= 0 of
        true -> lib_send:send_prompt_msg(PS, ?PM_PARA_ERROR);
        false ->
            ply_setting:set_accept_team_invite_state(player:id(PS), State),
            {ok, BinData} = pt_13:write(?PT_PLYR_SET_TEAM_INVITE_STATE, [State]),
            lib_send:send_to_sock(PS, BinData)
    end;


handle(?PT_PLYR_SET_RELA_STATE, PS, [State]) ->
    case State =/= 1 andalso State =/= 0 of
        true -> lib_send:send_prompt_msg(PS, ?PM_PARA_ERROR);
        false ->
            ply_setting:set_accept_friend_state(player:id(PS), State),
            {ok, BinData} = pt_13:write(?PT_PLYR_SET_RELA_STATE, [State]),
            lib_send:send_to_sock(PS, BinData)
    end;


handle(?PT_PLYR_SET_ACCEPT_PK_STATE, PS, [State]) ->
    case State =/= 1 andalso State =/= 0 of
        true -> lib_send:send_prompt_msg(PS, ?PM_PARA_ERROR);
        false ->
            ply_setting:set_accept_pk_state(player:id(PS), State),
            {ok, BinData} = pt_13:write(?PT_PLYR_SET_ACCEPT_PK_STATE, [State]),
            lib_send:send_to_sock(PS, BinData)
    end;

handle(?PT_PLYR_SET_SHOWING_EQUIP, PS, [Type, State]) ->
    case lists:member(Type, [5, 6, 7, 8]) of
        false -> lib_send:send_prompt_msg(PS, ?PM_PARA_ERROR);
        true ->
            case State =/= 1 andalso State =/= 0 of
                true -> lib_send:send_prompt_msg(PS, ?PM_PARA_ERROR);
                false ->
                    case Type of
                        5 -> ply_setting:set_par_clothes_hide(PS, State);
                        6 -> ply_setting:set_headwear_hide(PS, State);
                        7 -> ply_setting:set_clothes_hide(PS, State);
                        8 -> ply_setting:set_backwear_hide(PS, State);
                        _Any -> ?ASSERT(false, _Any)
                    end,

                    {ok, BinData} = pt_13:write(?PT_PLYR_SET_SHOWING_EQUIP, [Type, State]),
                    lib_send:send_to_sock(PS, BinData)
            end
    end;

handle(?PT_PLYR_SET_PAODIAN_TYPE, PS, [Type]) ->
        ply_setting:set_paodian_type(PS, Type),
        {ok, BinData} = pt_13:write(?PT_PLYR_SET_PAODIAN_TYPE, [Type]),
        lib_send:send_to_sock(PS, BinData);

handle(?PT_PLYR_GET_PAODIAN_TYPE, PS, _) ->
        {ok, BinData} = pt_13:write(?PT_PLYR_SET_PAODIAN_TYPE, [ply_setting:get_paodian_type(player:id(PS))]),
        lib_send:send_to_sock(PS, BinData);


handle(?PT_PLYR_GET_SYS_SET, PS, _) ->
    PlayerId = player:id(PS),
    LeaderState =
        case ply_setting:is_cant_be_leader(PlayerId) of
            true -> 0;
            false -> 1
        end,
    JoinTeamState =
        case ply_setting:accept_team_invite(PlayerId) of
            true -> 0;
            false -> 1
        end,

    AcceptFriendState =
        case ply_setting:accept_friend_invite(PlayerId) of
            true -> 0;
            false -> 1
        end,

    AcceptPKState =
        case ply_setting:accept_pk(PlayerId) of
            true -> 0;
            false -> 1
        end,

    IsParClothesHide =
        case ply_setting:is_par_clothes_hide(PlayerId) of
            true -> 1;
            false -> 0
        end,

    IsHeadwearHide =
        case ply_setting:is_headwear_hide(PlayerId) of
            true -> 1;
            false -> 0
        end,

    IsBackwearHide =
        case ply_setting:is_backwear_hide(PlayerId) of
            true -> 1;
            false -> 0
        end,

    IsClothesHide =
        case ply_setting:is_clothes_hide(PlayerId) of
            true -> 1;
            false -> 0
        end,

    InfoList = [{1, LeaderState}, {2, JoinTeamState}, {3, AcceptFriendState}, {4, AcceptPKState}, {5, IsParClothesHide}, {6, IsHeadwearHide}, {7, IsClothesHide}, {8, IsBackwearHide}],
    {ok, BinData} = pt_13:write(?PT_PLYR_GET_SYS_SET, InfoList),
    lib_send:send_to_sock(PS, BinData);


handle(?PT_PLYR_NOTIFY_VIP, PS, _) ->
    lib_vip:info_vip(PS);

handle(?PT_PLYR_OFFLINE_AWARD_INFO, PS, _) ->
    mod_offline_guaji:send_info(PS);

handle(?PT_PLYR_OFFLINE_AWARD_BEGIN, PS, _) ->
    PS2 = mod_offline_guaji:start(PS),
    {ok, PS2};

handle(?PT_PLYR_OFFLINE_AWARD_END, PS, [UseMoney]) ->
    PS2 = mod_offline_guaji:stop(UseMoney, PS),
    {ok, PS2};


handle(?PT_PLYR_RECHARGE_STATE, PS, _) ->
    player:notify_recharge_state(PS),
    ok;


handle(?PT_PLYR_RECHARGE_REWARD_STATE, PS, _) ->
    {ok, BinData} = pt_13:write(?PT_PLYR_RECHARGE_REWARD_STATE, [PS#player_status.first_recharge_reward_state]),
    lib_send:send_to_uid(player:id(PS), BinData),
    ok;


handle(?PT_PLYR_RECHARGE_REWARD, PS, _) ->
%%     player:give_first_recharge_reward(PS),
    ok;


handle(?PT_PLYR_REQ_JOIN_CRUISE, PS, _) ->
    ply_cruise:req_join_cruise(PS),
    void;


handle(?PT_PLYR_STOP_CRUISE, PS, _) ->
    ply_cruise:stop_cruise(PS, stop_by_player),
    void;


handle(?PT_PLYR_C2S_NOTIFY_CRUISE_QUIZ_RES, PS, Result) ->
    case Result of
        1 -> ply_cruise:c2s_notify_quiz_pass(PS);
        0 -> skip;
        _ -> ?ASSERT(false, Result), skip
    end,
    void;


handle(?PT_PLYR_C2S_LOG_PLOT, PS, [_, State]) ->
    lib_log:plot_skip_record(player:id(PS), State),
    ok;

handle(?PT_PLYR_ALL_TITLE, PS, _) ->
    UID = player:id(PS),
    ply_title:send_all_titles(UID),
    ok;

handle(?PT_PLYR_USE_TITLE, PS, [Title]) ->
    UID = player:id(PS),
    ply_title:use_title(UID, Title),
    ok;

handle(?PT_PLYR_NO_USE_TITLE, PS, [Title]) ->
    UID = player:id(PS),
    ply_title:no_use_title(UID, Title),
    ok;

handle(?PT_PLYR_DISPLAY_TITLE, PS, [Title]) ->
    UID = player:id(PS),
    ply_title:display_title(UID, Title),
    ok;

handle(?PT_PLYR_NO_DISPLAY_TITLE, PS, [Title]) ->
    UID = player:id(PS),
    ply_title:no_display_title(UID, Title),
    ok;

% 阵法相关
handle(?PT_PLYR_ALL_ZF, PS, _) ->
    ZFs = player:get_zf_state(PS),
    {ok, BinData} = pt_13:write(?PT_PLYR_ALL_ZF, [ZFs]),
    lib_send:send_to_uid(player:id(PS), BinData),
    ok;

handle(?PT_PLYR_LEARN_ZF, PS, [No]) ->
    case ply_zf:learn_zf(PS, No) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        ok ->
            {ok, BinData} = pt_13:write(?PT_PLYR_LEARN_ZF, [?RES_OK, No]),
            lib_send:send_to_uid(player:id(PS), BinData)
    end,
    ok;


handle(?PT_PLYR_GET_ACCUM_RECHARGE, PS, [Type]) ->
    Amount = player:query_accum_activity_amount(PS, Type),
    {ok, BinData} = pt_13:write(?PT_PLYR_GET_ACCUM_RECHARGE, [Type, Amount]),
    lib_send:send_to_uid(player:id(PS), BinData),
    ok;


handle(?PT_PLYR_WORLD_LV_INFO, PS, _) ->
    {_Lv, Exp} = PS#player_status.exp_slot,
    case mod_world_lv:get_open_world_lv_time() of
        null -> 
            {ok, BinData} = pt_13:write(?PT_PLYR_WORLD_LV_INFO, [0, 0, Exp]),
            lib_send:send_to_uid(player:id(PS), BinData);
        Stamp ->
            CurLvTmp = mod_world_lv:get_cur_world_lv(),
            CurLv = ?BIN_PRED(is_integer(CurLvTmp) andalso CurLvTmp > 0, CurLvTmp, 0),
            NxtStamp = mod_world_lv:get_next_lv_time(Stamp, CurLv),
            {ok, BinData} = pt_13:write(?PT_PLYR_WORLD_LV_INFO, [CurLv, NxtStamp, Exp]),
            lib_send:send_to_uid(player:id(PS), BinData)
    end,
    ok;

handle(?PT_CAN_USE_CASH_COUPON, PS, [RechargeMon, VouchersNo]) ->
    PlayerId = player:get_id(PS),

    case mod_inv:has_goods_in_bag_by_no(PlayerId, VouchersNo) of
        false ->
            lib_send:send_prompt_msg(PS, ?PM_VOUCHERS_NOT_EXISTS);
        true ->
            VouchersCon = (data_cash_coupon_use_condition:get(VouchersNo))#cash_coupon_use_condition.condition,
            case RechargeMon >= VouchersCon of
                true ->
                    ets:insert(?ETS_PLAYER_VOUCHERS_INFO, #player_vouchers_info{player_id = PlayerId, vouchers_no = VouchersNo,
                        step_num = RechargeMon}),
                    {ok, BinData} = pt_13:write(?PT_CAN_USE_CASH_COUPON, [?RES_OK]),
                    lib_send:send_to_sock(PS, BinData);
                false ->
                    lib_send:send_prompt_msg(PS, ?PM_VOUCHERS_CANNOT_USE)
            end
    end,
    ok;

handle(?PT_CAN_NOT_USE_CASH_COUPON, PS, []) ->
    ets:delete(?ETS_PLAYER_VOUCHERS_INFO, player:get_id(PS));

handle(?PT_RECHARGE_SUM, PS, _) ->
	player:notify_recharge_sum(PS),
    ok;

%% 屏蔽多档首冲
%% handle(?PT_FIRST_RECHARGE_REWARD_ALREADY, PS, []) ->
%% 	player:notice_first_recharge(PS),
%%     ok;


handle(?PT_FIRST_RECHARGE_REWARD, PS, [Money]) ->
	case player:first_recharge_reward(PS, Money) of
		ok ->
			{ok, BinData} = pt_13:write(?PT_FIRST_RECHARGE_REWARD, [Money]),
			lib_send:send_to_sock(PS, BinData),
			ok;
		{fail, ReasonCode} ->
			lib_send:send_prompt_msg(PS, ReasonCode)
	end;


handle(?PT_LOGIN_REWARD, PS, []) ->
	Days = PS#player_status.login_reward_day,
	Unixtime = PS#player_status.login_reward_time,
	{ok, BinData} = pt_13:write(?PT_LOGIN_REWARD, [Days, Unixtime]),
	lib_send:send_to_sock(PS, BinData),
    ok;


handle(?PT_LOGIN_REWARD_GET, PS, []) ->
	case player:login_reward_day(PS) of
		{ok, PS2} ->
			Days = PS2#player_status.login_reward_day,
			Unixtime = PS2#player_status.login_reward_time,
			{ok, BinData} = pt_13:write(?PT_LOGIN_REWARD_GET, [Days, Unixtime]),
			lib_send:send_to_sock(PS, BinData),
			ok;
		{fail, ReasonCode} ->
			lib_send:send_prompt_msg(PS, ReasonCode)
	end;

handle(?PT_INFINITE_RESOURCES, PS, []) ->
    player:get_unlimited_data(PS);


handle(?PT_INFINITE_RESOURCES_SUPPLEMENT, PS, [Type , Value]) ->
    player:buy_unlimited_resource(PS, Type , Value);


handle(?PT_PLYR_CREATE_ROLE_REWARD, PS, [Type]) ->
    case player:create_role_reward(PS, Type) of
		{ok, State} ->
			{ok, BinData} = pt_13:write(?PT_PLYR_CREATE_ROLE_REWARD, [State]),
			lib_send:send_to_sock(PS, BinData);
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason)
	end;


handle(?PT_CUSTOM_TITLE_RESET, PS, [No]) ->
    case ply_title:title_reset(PS, No) of
		ok ->
        {ok, BinData} = pt_13:write(?PT_CUSTOM_TITLE_RESET, [?RES_OK,No]),
        lib_send:send_to_sock(PS, BinData);
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason)
	end;

handle(?PT_CUSTOM_TITLE_START, PS, [No,NoList]) ->
    case ply_title:title_start(PS, No, NoList) of
        ok ->
            {ok, BinData} = pt_13:write(?PT_CUSTOM_TITLE_START, [?RES_OK, No, NoList]),
            lib_send:send_to_sock(PS, BinData);
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason)
    end;

handle(_Cmd, _Status, _Data) ->
    ?ASSERT(false, {_Cmd, _Data}),
    ?WARNING_MSG("unhandle ~w", [_Cmd]),
    {error, "pp_player no match"}.




check_allot_free_talent_points(PS, AllotInfoList) ->
    check_allot_free_talent_points__(PS, AllotInfoList, 0).


check_allot_free_talent_points__(PS, [{TalentCode, Points} | T], AccPointsToAllot) ->
    case 0 < TalentCode andalso TalentCode =< ?TOTAL_TALENT_COUNT of
        false ->
            ?ASSERT(false, TalentCode),
            fail;
        true ->
            check_allot_free_talent_points__(PS, T, AccPointsToAllot + Points)
    end;
check_allot_free_talent_points__(PS, [], AccPointsToAllot) ->
    case AccPointsToAllot == 0 orelse AccPointsToAllot > player:get_free_talent_points(PS) of
        true ->
            %%?ASSERT(false, AccPointsToAllot),
            fail;
        false ->
            ok
    end.



