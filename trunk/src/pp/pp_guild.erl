%%%-------------------------------------- 
%%% @Module: pp_guild
%%% @Author: zhangwq
%%% @Created: 2013-9-24
%%% @Description: 帮会功能处理接口

%%%-------------------------------------- 
-module(pp_guild).

-include("record.hrl").
-include("guild.hrl").
-include("player.hrl").
-include("pt_40.hrl").
-include("common.hrl").
-include("prompt_msg_code.hrl").
-include("record/guild_record.hrl").
-include("sys_code.hrl").
-include("player.hrl").
-include("log.hrl").

-export([handle/3, handle_cmd/3]).


%% desc: 等级检查
handle(Cmd, PS, Data) ->
    case ply_sys_open:is_open(PS, ?SYS_GUILD) of
        true -> handle_cmd(Cmd, PS, Data);
        false -> 
            lib_send:send_prompt_msg(PS, ?PM_LV_LIMIT),
            skip
    end.

%% desc: 创建帮会 
handle_cmd(?PT_CREATE_GUILD, PS, [GuildName, Brief]) ->
    mod_achievement:notify_achi(apply_join_guild, [], PS),
    ply_guild:create_guild(PS, GuildName, Brief);


%% desc: 解散帮会
handle_cmd(?PT_DISBAND_GUILD, PS, [GuildId]) ->
    ply_guild:disband_guild(PS, GuildId);



%% desc: 申请加入帮派
handle_cmd(?PT_APPLY_JOIN_GUILD, PS, [GuildId,Type]) ->
    mod_achievement:notify_achi(apply_join_guild, [], PS),
    case ply_guild:check_apply_join_guild(PS, GuildId) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        _Any ->
            gen_server:cast(?GUILD_PROCESS, {'apply_join_guild', PS, GuildId, Type})
    end;


%% desc: 审批本帮会申请人员
handle_cmd(?PT_HANDLE_APPLY, PS, [PlayerId, Choise]) ->
    ply_guild:handle_apply(PS, PlayerId, Choise);


%% desc: 邀请他人加入帮派  
handle_cmd(?PT_INVITE_JOIN_GUILD, PS, [ObjPlayerId]) ->
    case ply_guild:invite_join(PS, ObjPlayerId) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        ok ->
            {ok, BinData} = pt_40:write(?PT_INVITE_JOIN_GUILD, [?RES_OK]),
            lib_send:send_to_sock(PS, BinData)
    end;    


%% desc: 回复帮会邀请
handle_cmd(?PT_REPLY_INVITE, PS, [GuildId, Choise]) ->
    ply_guild:reply_invite(PS, GuildId, Choise);


%% desc: 开除帮会成员     
handle_cmd(?PT_KICK_OUT_FROM_GUILD, PS, [GuildId, PlayerId]) ->
    case player:get_id(PS) =:= PlayerId of
        true ->
            skip;
        false ->
            ply_guild:kick_out_from_guild(PS, GuildId, PlayerId)
    end;


%% desc: 退出帮派
handle_cmd(?PT_QUIT_GUILD, PS, [GuildId]) ->
    ply_guild:quit_guild(PS, GuildId);
        


%% desc: 获取帮会列表
handle_cmd(?PT_GET_GUILD_LIST, PS, [PageSize, PageNum]) ->
    AllGuildList = mod_guild:get_guild_list(),
    Temp = length(AllGuildList) div PageSize,
    TotalPage = 
    case length(AllGuildList) rem PageSize of
        0 -> Temp;
        _ -> Temp + 1
    end,

    IndexStart = (PageNum - 1) * PageSize + 1,
    IndexEnd = IndexStart + PageSize - 1,
    GuildList = ply_guild:get_guild_list(order_by_rank_inc, IndexStart, IndexEnd, AllGuildList),
    {ok, BinData} = pt_40:write(?PT_GET_GUILD_LIST, [?RES_OK, TotalPage, PageNum, GuildList]),
    lib_send:send_to_sock(PS, BinData);


%% desc: 获取帮派成员列表
handle_cmd(?PT_GET_GUILD_MB_LIST, PS, [GuildId, PageSize, PageNum, SortType]) ->
    AllMemberL = mod_guild:get_member_info_list(GuildId),
    MemberCount = length(AllMemberL),
    Temp = MemberCount div PageSize,
    TotalPage = 
    case MemberCount rem PageSize of
        0 -> Temp;
        _ -> Temp + 1
    end,
    IndexStart = (PageNum - 1) * PageSize + 1,
    IndexEnd = IndexStart + PageSize - 1,
    OnlineCount = mod_guild:get_online_member_count(AllMemberL),
    MemberList = ply_guild:get_member_info_list(SortType, GuildId, IndexStart, IndexEnd, AllMemberL),
    
    {ok, BinData} = pt_40:write(?PT_GET_GUILD_MB_LIST, [GuildId, MemberCount, OnlineCount, TotalPage, PageNum, MemberList]),
    lib_send:send_to_sock(PS, BinData);


%% desc: 获取帮会申请列表
handle_cmd(?PT_GET_REQ_JOIN_LIST, PS, [GuildId, PageSize, PageNum]) ->
    AllList = mod_guild:get_req_join_list(GuildId),
    Temp = length(AllList) div PageSize,
    TotalPage = 
    case length(AllList) rem PageSize of
        0 -> Temp;
        _ -> Temp + 1
    end,
    IndexStart = (PageNum - 1) * PageSize + 1,
    IndexEnd = IndexStart + PageSize - 1,
    ReqList = ply_guild:get_req_join_list(order_by_time_inc, GuildId, IndexStart, IndexEnd, AllList),
    {ok, BinData} = pt_40:write(?PT_GET_REQ_JOIN_LIST, [?RES_OK, TotalPage, PageNum, ReqList]),
    lib_send:send_to_sock(PS, BinData);


%% desc: 获取帮派基本信息
handle_cmd(?PT_BASE_GUILD_INFO, PS, [GuildId]) ->
    case ply_guild:get_general_info(GuildId) of
        [] ->
            lib_send:send_prompt_msg(PS, ?PM_GUILD_NOT_EXISTS);
        InfoList ->
            {ok, BinData} = pt_40:write(?PT_BASE_GUILD_INFO, InfoList),
            lib_send:send_to_sock(PS, BinData)
    end;


%% desc: 修改帮派公告
handle_cmd(?MODIFY_GUILD_TENET, PS, [GuildId, Tenet]) ->
    ply_guild:modify_guild_tenet(PS, GuildId, Tenet);


%% desc: 帮会授予官职
handle_cmd(?APPOINT_GUILD_POSITION, PS, [PlayerId, Position]) ->
    ply_guild:appoint_position(PS, PlayerId, Position);


handle_cmd(?PT_GET_PLAYER_GUILD_INFO, PS, _) ->
    case mod_guild:get_member_info(player:get_id(PS)) of
        null ->
            lib_send:send_prompt_msg(PS, ?PM_NOT_IN_GUILD);
        Member ->
            {ok, BinData} = pt_40:write(?PT_GET_PLAYER_GUILD_INFO, [Member]),
            lib_send:send_to_sock(PS, BinData)
    end;


%% desc: 搜索帮会列表
handle_cmd(?PT_SEARCH_GUILD_LIST, PS, [PageSize, PageNum, NotFull, SearchName]) ->
    TimeNow = util:longunixtime(),
    % 检查搜索的时间间隔，以避免玩家搜索太频繁
    case (TimeNow - get_last_search_guild_time()) > ?SEARCH_GUILD_CD_TIME of
        false ->
            ?TRACE("search guild lists is cooling down!!!!!!!!!!!~n~n~n"),
            skip;
        true ->
            AllGuildList = 
                case NotFull =:= 0 andalso SearchName =:= [] of
                    true -> mod_guild:get_guild_list();
                    false -> mod_guild:search_guild_list(NotFull, SearchName)
                end,

            Temp = length(AllGuildList) div PageSize,
            TotalPage = 
            case length(AllGuildList) rem PageSize of
                0 -> Temp;
                _ -> Temp + 1
            end,

            IndexStart = (PageNum - 1) * PageSize + 1,
            IndexEnd = IndexStart + PageSize - 1,
            GuildList = ply_guild:get_guild_list(order_by_rank_inc, IndexStart, IndexEnd, AllGuildList),
            {ok, BinData} = pt_40:write(?PT_SEARCH_GUILD_LIST, [?RES_OK, player:id(PS), TotalPage, PageNum, GuildList]),
            lib_send:send_to_sock(PS, BinData),

            % 记录上次搜索的时间
            set_last_search_guild_time(TimeNow)
    end;


handle_cmd(?PT_GET_GUILD_POS_INFO, PS, [GuildId]) ->
    case mod_guild:get_info(GuildId) of
        null ->
            lib_send:send_prompt_msg(PS, ?PM_GUILD_NOT_EXISTS);
        Guild ->
            {ok, BinData} = pt_40:write(?PT_GET_GUILD_POS_INFO, [Guild]),
            lib_send:send_to_sock(PS, BinData)
    end;
            

handle_cmd(?PT_QUERY_GUILD_PAY, PS, _) ->
    case mod_guild:get_member_info(player:id(PS)) of
        null ->
            lib_send:send_prompt_msg(PS, ?PM_NOT_IN_GUILD);
        GuildMb ->
            {ok, BinData} = pt_40:write(?PT_QUERY_GUILD_PAY, GuildMb#guild_mb.pay_today),
            lib_send:send_to_sock(PS, BinData)
    end;    


handle_cmd(?PT_GET_GUILD_PAY, PS, [Type]) ->
    case ply_guild:check_get_guild_pay(PS, Type) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        {ok, _} ->
            gen_server:cast(?GUILD_PROCESS, {'get_guild_pay', PS, Type})
    end;


handle_cmd(?PT_GUILD_ADD_DISHES, PS, [DishesNo]) ->
    case ply_guild:add_guild_dishes(PS, DishesNo) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        ok ->
            {ok, BinData} = pt_40:write(?PT_GUILD_ADD_DISHES, [?RES_OK]),
            lib_send:send_to_sock(PS, BinData)
    end;



handle_cmd(?PT_GUILD_GET_DISHES, PS, []) ->
    GuildParty = lib_guild:get_party_from_ets(player:get_guild_id(PS)),

    case GuildParty =:= null orelse GuildParty#guild_party.start_time =:= 0 of
        true ->
            skip;
            % lib_send:send_prompt_msg(PS, ?PM_GUILD_PARTY_NOT_OPENED);
        false ->
            {ok, BinData} = pt_40:write(?PT_GUILD_GET_DISHES, [GuildParty#guild_party.dishes_no]),
            lib_send:send_to_sock(PS, BinData)
    end;


handle_cmd(?PT_GUILD_DUNGEON_ENTER, PS, _) ->
    case ply_guild:enter_guild_dungeon(PS) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        {ok, GuildLv} ->
            {ok, BinData} = pt_40:write(?PT_GUILD_DUNGEON_ENTER, [?RES_OK, GuildLv]),
            lib_send:send_to_sock(PS, BinData)
    end;


handle_cmd(?PT_GUILD_DUNGEON_COLLECT, PS, [NpcId]) ->
    case ply_guild:collect_in_guild_dungeon(PS, NpcId) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        ok ->
            {ok, BinData} = pt_40:write(?PT_GUILD_DUNGEON_COLLECT, [?RES_OK]),
            lib_send:send_to_sock(PS, BinData)
    end;    


handle_cmd(?PT_GUILD_GET_DUNGEON_INFO, PS, _) ->
    case player:get_guild_id(PS) of
        ?INVALID_ID ->
            lib_send:send_prompt_msg(PS, ?PM_NOT_JOIN_GUILD_YET);
        GuildId ->
            lib_guild:notify_dungeon_info_change(GuildId)
    end;


handle_cmd(?PT_GUILD_CULTIVATE, PS, [ObjInfoCode, Count, Type]) ->
    case Count > 1000 orelse (not lists:member(Type, [1, 2])) of
        true -> skip;   %% 防止被攻击，进入死循环
        false ->
            case ply_guild:cultivate(PS, ObjInfoCode, Count, Type) of
                {fail, Reason} ->
                    lib_send:send_prompt_msg(PS, Reason);
                {RetList, PS1} ->
                    AttrName = lib_attribute:obj_info_code_to_attr_name(ObjInfoCode),
                    {Cultivate, CultivateLv} = 
                        case lists:keyfind(AttrName, 1, player:get_guild_attrs(PS1)) of
                            false -> {0, 0};
                            {_, Lv, Value} -> {Value, Lv}
                        end,
                    player:db_save_guild_attrs(PS1),
                    {ok, BinData} = pt_40:write(?PT_GUILD_CULTIVATE, [RetList, Cultivate, CultivateLv, ObjInfoCode, Type]),
                    lib_send:send_to_sock(PS1, BinData),
                    ply_attr:recount_base_and_total_attrs(PS1),

                    %帮派点修通知成就
                    InfoList = [[{cultivate_lv, 1},{lv, CurtLv}] || {_AttrName, CurtLv, _Value} <-  player:get_guild_attrs(PS1)],
                    mod_achievement:notify_achi(guild_cultivate, InfoList, PS1),

                    % F = fun({_, CurtLv, _}) ->
                    %         mod_achievement:notify_achi(guild_cultivate, [{cultivate_lv, CurtLv}], PS1).
                    % end,
                    % lists:foreach(F, player:get_guild_attrs(PS1)),

                    {ok, PS1}
            end
    end;


handle_cmd(?PT_GUILD_USE_GOODS, PS, [ObjInfoCode, GoodsNo, Count]) ->
    case ply_guild:use_goods_for_cultivate(PS, ObjInfoCode, GoodsNo, Count) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        {ok, PS1} ->
            AttrName = lib_attribute:obj_info_code_to_attr_name(ObjInfoCode),
            {Cultivate, CultivateLv} = 
                case lists:keyfind(AttrName, 1, player:get_guild_attrs(PS1)) of
                    false -> ?ASSERT(false, {AttrName, player:get_guild_attrs(PS1)}), {0, 0};
                    {_, Lv, Value} -> {Value, Lv}
                end,
            {ok, BinData} = pt_40:write(?PT_GUILD_USE_GOODS, [Cultivate, CultivateLv, ObjInfoCode]),
            lib_send:send_to_sock(PS1, BinData),
            player:db_save_guild_attrs(PS1),
            ply_attr:recount_base_and_total_attrs(PS1),

            %帮派点修通知成就
            InfoList = [[{cultivate_lv, 1},{lv, CurtLv}] || {_AttrName, CurtLv, _Value} <-  player:get_guild_attrs(PS1)],
            mod_achievement:notify_achi(guild_cultivate, InfoList, PS1),

            % F = fun({_, CurtLv, _}) ->
            %         mod_achievement:notify_achi(guild_cultivate, [{cultivate_lv, CurtLv}], PS1).
            % end,
            % lists:foreach(F, player:get_guild_attrs(PS1)),
            {ok, PS1}
    end;

%%查询需要消耗多少洗髓
handle_cmd(?PT_GUILD_GET_WASH_CONS, PS, []) ->
    NeedGameMoney = ply_guild:get_wash_need_gamemoney(PS),
    {ok, BinData} = pt_40:write(?PT_GUILD_GET_WASH_CONS, [NeedGameMoney]),
    lib_send:send_to_sock(PS, BinData);

%%进行洗髓操作
handle_cmd(?PT_GUILD_DO_WASH, PS, []) ->
    case ply_guild:check_wash(PS) of
        {fail, Reason} ->
            ?DEBUG_MSG("Reason ~p",[Reason]),
            %{ok, BinData} = pt_40:write(?PT_GUILD_DO_WASH, [?RES_FAIL]),
            lib_send:send_prompt_msg(PS, Reason);
            %lib_send:send_to_sock(PS, BinData);
        ok ->
            ?DEBUG_MSG("OK ~p",[PS]),
            ply_guild:do_wash(PS),
            {ok, BinData} = pt_40:write(?PT_GUILD_DO_WASH, [?RES_OK]),
            lib_send:send_to_sock(PS, BinData)
    end;


handle_cmd(?PT_GUILD_DONATE, PS, [Contri]) ->
    case ply_guild:check_donate(PS, Contri) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        {ok, _, _} ->
            case catch gen_server:call(?GUILD_PROCESS, {'donate', PS, Contri}) of
                {'EXIT', Reason} ->
                    ?ERROR_MSG("pp_guild:handle_cmd(?PT_GUILD_DONATE, exit for reason: ~w~n", [Reason]),
                    ?ASSERT(false, Reason),
                    lib_send:send_prompt_msg(PS, ?PM_MK_FAIL_SERVER_BUSY);
                {fail, Reason} ->
                    lib_send:send_prompt_msg(PS, Reason);
                {ok, AddProsper, NewPS}  ->
                    {ok, BinData} = pt_40:write(?PT_GUILD_DONATE, [Contri, AddProsper]),
                    lib_send:send_to_sock(PS, BinData),
                    {ok, NewPS};
                _Any ->
                    ?ERROR_MSG("pp_guild:handle_cmd(?PT_GUILD_DONATE, error!: ~w~n", [_Any]),
                    lib_send:send_prompt_msg(PS, ?PM_UNKNOWN_ERR)
            end
    end;


handle_cmd(?PT_GUILD_GET_CULTIVATE_INFO, PS, _) ->
    case mod_guild:get_info(player:get_guild_id(PS)) of
        null -> 
            lib_send:send_prompt_msg(PS, ?PM_GUILD_NOT_EXISTS);
        Guild ->
            case mod_guild:get_member_info(player:id(PS)) of
                null -> 
                    lib_send:send_prompt_msg(PS, ?PM_NOT_IN_GUILD);
                GuildMb ->
                    GuildLv = mod_guild:get_lv(Guild),
                    Contri = GuildMb#guild_mb.left_contri,
                    {ok, BinData} = pt_40:write(?PT_GUILD_GET_CULTIVATE_INFO, [PS, GuildLv, Contri]),
                    lib_send:send_to_sock(PS, BinData)
            end
    end;

handle_cmd(?PT_GUILD_GET_DONATE_INFO, PS, _) ->
    case mod_guild:get_info(player:get_guild_id(PS)) of
        null -> 
            lib_send:send_prompt_msg(PS, ?PM_GUILD_NOT_EXISTS);
        Guild ->
            case mod_guild:get_member_info(player:id(PS)) of
                null -> 
                    lib_send:send_prompt_msg(PS, ?PM_NOT_IN_GUILD);
                GuildMb ->
                    {ok, BinData} = pt_40:write(?PT_GUILD_GET_DONATE_INFO, [GuildMb, Guild]),
                    lib_send:send_to_sock(PS, BinData)
            end
    end;

handle_cmd(?PT_GUILD_BID_FOR_BATTLE, PS, [Money]) ->
    case ply_guild:check_bid_for_guild_war(PS, Money) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        _ ->
            case catch gen_server:call(?GUILD_PROCESS, {'bid_for_guild_war', PS, Money}) of
                {'EXIT', Reason} ->
                    ?ERROR_MSG("pp_guild:handle_cmd(?PT_GUILD_BID_FOR_BATTLE, exit for reason: ~w~n", [Reason]),
                    ?ASSERT(false, Reason),
                    lib_send:send_prompt_msg(PS, ?PM_MK_FAIL_SERVER_BUSY);
                {fail, Reason} ->
                    lib_send:send_prompt_msg(PS, Reason);
                ok  ->
                    {ok, BinData} = pt_40:write(?PT_GUILD_BID_FOR_BATTLE, [?RES_OK]),
                    lib_send:send_to_sock(PS, BinData);
                _Any ->
                    ?ERROR_MSG("pp_guild:handle_cmd(?PT_GUILD_BID_FOR_BATTLE, error!: ~w~n", [_Any]),
                    lib_send:send_prompt_msg(PS, ?PM_UNKNOWN_ERR)
            end
    end;            

handle_cmd(?PM_GUILD_GET_BID_LIST, PS, _) ->
    case mod_guild:get_info(player:get_guild_id(PS)) of
        null -> 
            lib_send:send_prompt_msg(PS, ?PM_GUILD_NOT_EXISTS);
        Guild ->
            case mod_guild:get_member_info(player:id(PS)) of
                null -> 
                    lib_send:send_prompt_msg(PS, ?PM_NOT_IN_GUILD);
                GuildMb ->
                    gen_server:cast(?GUILD_PROCESS, {'get_guild_mb_bid_list', PS, Guild, GuildMb})
            end
    end;


handle_cmd(?PT_GUILD_START_WAR_PK, PS, [ObjPlayerId]) ->
    case mod_guild_war:check_start_pk(PS, ObjPlayerId) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        {ok, HandlePid} ->
            gen_server:cast(HandlePid, {'start_pk', PS, ObjPlayerId})
    end;


handle_cmd(?PM_GUILD_SIGN_IN_FOR_GB, PS, _) ->
    case mod_guild_war:check_enter_war_pre_dungeon(PS) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        {ok, HandlePid} ->
            gen_server:cast(HandlePid, {'enter_war_pre_dungeon', PS, ply_misc:get_player_misc(player:id(PS))})
    end;    


handle_cmd(?PM_GUILD_QUIT_PRE_WAR, PS, _) ->
    case lib_dungeon:is_in_guild_prepare_dungeon(PS) of
        false ->
            {ok, BinData} = pt_40:write(?PM_GUILD_QUIT_PRE_WAR, [?RES_OK]),
            lib_send:send_to_sock(PS, BinData);
        true ->
            case lib_guild:get_guild_war_from_ets(player:get_guild_id(PS)) of
                null ->
                    ply_scene:goto_born_place(PS),
                    {ok, BinData} = pt_40:write(?PM_GUILD_QUIT_PRE_WAR, [?RES_OK]),
                    lib_send:send_to_sock(PS, BinData);
                GuildWar ->
                    TeamId = player:get_team_id(PS),
                    case player:is_leader(PS) andalso length(mod_team:get_normal_member_id_list(TeamId)) >= 2 of
                        true ->
                            lib_send:send_prompt_msg(PS, ?PM_TM_LEAVE_TEAM_FIRST);
                        false ->
                            case mod_guild_mgr:is_pid_ok(GuildWar#guild_war.war_pre_dun_pid) of
                                true ->
                                    gen_server:cast(GuildWar#guild_war.war_handle_pid, {'leave_war_pre_dungeon', PS});
                                false -> 
                                    ply_scene:goto_born_place(PS)
                            end
                    end
            end
    end;


handle_cmd(?PM_GUILD_QUIT_WAR, PS, _) ->
    case lib_dungeon:is_in_guild_battle_dungeon(PS) of
        false ->
            {ok, BinData} = pt_40:write(?PM_GUILD_QUIT_WAR, [?RES_OK]),
            lib_send:send_to_sock(PS, BinData);
        true ->
            case lib_guild:get_guild_war_from_ets(player:get_guild_id(PS)) of
                null ->
                    ply_scene:goto_born_place(PS),
                    {ok, BinData} = pt_40:write(?PM_GUILD_QUIT_WAR, [?RES_OK]),
                    lib_send:send_to_sock(PS, BinData);
                GuildWar ->
                    TeamId = player:get_team_id(PS),
                    case player:is_leader(PS) andalso length(mod_team:get_normal_member_id_list(TeamId)) >= 2 of
                        true ->
                            lib_send:send_prompt_msg(PS, ?PM_TM_LEAVE_TEAM_FIRST);
                        false ->
                            case mod_guild_mgr:is_pid_ok(GuildWar#guild_war.war_dun_pid) of
                                true ->
                                    gen_server:cast(GuildWar#guild_war.war_handle_pid, {'leave_war_dungeon', PS});
                                false ->
                                    ply_scene:goto_born_place(PS)
                            end
                    end
            end
    end;


handle_cmd(?PM_GUILD_GET_INFO_IN_GB, PS, _) ->
    ?INFO_MSG("pp_guild:get_guild_war_info begin...~n", []),
    case lib_dungeon:is_in_guild_battle_dungeon(PS) of
        false ->
            skip;
        true ->
            case lib_guild:get_guild_war_from_ets(player:get_guild_id(PS)) of
                null ->
                    skip;
                GuildWar ->
                    gen_server:cast(GuildWar#guild_war.war_handle_pid, {'get_guild_war_info', PS})
            end
    end;


handle_cmd(?PM_GUILD_GET_INFO_BEFORE_GB, PS, _) ->
    case lib_dungeon:is_in_guild_prepare_dungeon(PS) of
        false ->
            skip;
        true ->
            case lib_guild:get_guild_war_from_ets(player:get_guild_id(PS)) of
                null ->
                    skip;
                GuildWar ->
                    gen_server:cast(GuildWar#guild_war.war_handle_pid, {'get_pre_guild_war_info', PS})
            end
    end;    


handle_cmd(?PM_GUILD_BATTLE_GROUP, PS, _) ->
    case mod_guild:get_info(player:get_guild_id(PS)) of
        null -> 
            lib_send:send_prompt_msg(PS, ?PM_GUILD_NOT_EXISTS);
        _Guild ->
            case mod_guild:get_member_info(player:id(PS)) of
                null -> 
                    lib_send:send_prompt_msg(PS, ?PM_NOT_IN_GUILD);
                _GuildMb ->
                    gen_server:cast(?GUILD_PROCESS, {'get_guild_war_group', PS})
            end
    end;


handle_cmd(?PM_GUILD_QRY_SIGE_IN_STATE, PS, _) ->
    case mod_guild:get_info(player:get_guild_id(PS)) of
        null -> 
            lib_send:send_prompt_msg(PS, ?PM_GUILD_NOT_EXISTS);
        _Guild ->
            case mod_guild:get_member_info(player:id(PS)) of
                null -> 
                    lib_send:send_prompt_msg(PS, ?PM_NOT_IN_GUILD);
                _GuildMb ->
                    gen_server:cast(?GUILD_PROCESS, {'query_sign_in_state', PS})
            end
    end;    


handle_cmd(?PT_MODIFY_GUILD_NAME, PS, [GoodsId, Name]) ->
    case mod_guild_mgr:check_modify_guild_name(PS, GoodsId, Name) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        ok ->
            mod_inv:destroy_goods_by_id_WNC(player:id(PS), [{GoodsId, 1}], [?LOG_GOODS, "use"]),
            gen_server:cast(?GUILD_PROCESS, {'modify_guild_name', Name, PS})
    end;


handle_cmd(?PT_GUILD_SKILL_LEVEL_UP, PS, [No]) ->
    case ply_guild:skill_level_up(PS, No) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
%%         {ok, Lv} ->
		{ok, _PS2, NoLvL} ->
            %及时保存数据
			lists:foreach(fun({No, Lv}) ->
								  {ok, BinData} = pt_40:write(?PT_GUILD_SKILL_LEVEL_UP, [No, Lv]),
								  lib_send:send_to_sock(PS, BinData)
						  end, NoLvL)
            % 重新计算属性
            % ply_attr:recount_base_and_total_attrs(PS1),
%%             {ok, Lv}
    end;  


handle_cmd(?PT_CULTIVATE_SKILL_LEVEL_UP, PS, [No,Count]) ->
    case ply_guild:cultivate_level_up(PS, No,Count) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        {ok, Lv,Point} ->
            {ok, BinData} = pt_40:write(?PT_CULTIVATE_SKILL_LEVEL_UP, [No, Lv,Point]),
            lib_send:send_to_sock(PS, BinData),
            {ok, Lv,Point}
    end;  


handle_cmd(?PT_GUILD_CULTIVATE_USE_GOODS, PS, [No,Count]) ->
    case ply_guild:cultivate_use_goods(PS, No,Count) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        {ok, Lv,Point} ->
            mod_achievement:notify_achi(guild_skill, [{guild_skill_lv,{ Lv,1}}], PS),
            {ok, BinData} = pt_40:write(?PT_GUILD_CULTIVATE_USE_GOODS, [No, Lv,Point]),
            lib_send:send_to_sock(PS, BinData),
            {ok, Lv,Point}
    end;  


handle_cmd(?PT_GUILD_SKILL_USE, PS, [No]) ->
    case ply_guild:guild_skill_use(PS, No) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
         GoodsId ->
            {ok, BinData} = pt_40:write(?PT_GUILD_SKILL_USE, [No, GoodsId]),
            lib_send:send_to_sock(PS, BinData),
            {ok, GoodsId}
    end;  

handle_cmd(?PT_GUILD_GET_ALL_SKILL, PS, _) ->
    {ok, BinData} = pt_40:write(?PT_GUILD_GET_ALL_SKILL, [PS]),
    lib_send:send_to_sock(PS, BinData);


handle_cmd(?PT_GET_ALL_CULTIVATE_SKILL, PS, _) ->
    {ok, BinData} = pt_40:write(?PT_GET_ALL_CULTIVATE_SKILL, [PS]),
    lib_send:send_to_sock(PS, BinData);

handle_cmd(?PT_JOIN_GUILD_ZHUXIAN_TASK, PS, _) ->
    mod_achievement:notify_achi(apply_join_guild, [], PS);

handle_cmd(?PT_GUILD_JOIN_CONTROLLER, PS, [Guild, Type]) ->
    case ply_guild:modify_control(PS, Guild, Type) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        ok ->
            {ok, BinData} = pt_40:write(?PT_GUILD_JOIN_CONTROLLER, [?RES_OK]),
            lib_send:send_to_sock(PS, BinData)
    end;

handle_cmd(?PT_GUILD_QUERY_DYNAMIC_GOODS_IN_SHOP, PS, [GuildId]) ->
    case ply_guild:guild_shop(PS, GuildId) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        {ok, GuildShop} ->
            {ok, BinData} = pt_40:write(?PT_GUILD_QUERY_DYNAMIC_GOODS_IN_SHOP, [GuildShop]),
            lib_send:send_to_sock(PS, BinData)
    end;

handle_cmd(?PT_GUILD_SHOP_BUY, PS, [GuildId, ShopId, Count]) ->
    case ply_guild:purchase_guild_shop(PS, GuildId, ShopId, Count) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        {ok, NumLimit} ->
            {ok, BinData} = pt_40:write(?PT_GUILD_SHOP_BUY, [?RES_OK, ShopId, NumLimit]),
            lib_send:send_to_sock(PS, BinData)
    end;


%% desc: 容错
handle_cmd(_Cmd, _Status, _Data) ->
    ?DEBUG_MSG("pp_guild no match", []),
    {error, "pp_guild no match"}.

get_last_search_guild_time() ->
    case erlang:get(?PDKN_LAST_SEARCH_GUILD_TIME) of
        undefined ->
            0;
        Time ->
            Time
    end.

set_last_search_guild_time(Time) ->
    erlang:put(?PDKN_LAST_SEARCH_GUILD_TIME, Time).


