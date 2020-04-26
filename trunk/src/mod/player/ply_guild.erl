%%%------------------------------------
%%% @Module  : ply_guild
%%% @Author  :
%%% @Email   :
%%% @Created :
%%% @Description: 玩家帮派操作相关接口，如：创建帮派，解散帮派等等；
%%%------------------------------------

-module(ply_guild).

-include("ets_name.hrl").
-include("debug.hrl").
-include("record/guild_record.hrl").
-include("prompt_msg_code.hrl").
-include("abbreviate.hrl").
-include("guild.hrl").
-include("goods.hrl").
-include("record.hrl").
-include("pt_40.hrl").
-include("player.hrl").
-include("prompt_msg_code.hrl").
-include("obj_info_code.hrl").
-include("log.hrl").
-include("event.hrl").
-include("record/battle_record.hrl").
-include("num_limits.hrl").
-include("business.hrl").

-export([
        create_guild/3,                   %% 创建帮派
        disband_guild/2,                  %% 解散帮派
        check_apply_join_guild/2,
        apply_join_guild/2,               %% 申请加入帮会
        handle_apply/3,                   %% 处理玩家入会申请
        invite_join/2,                    %% 邀请玩家加入帮派
        reply_invite/3,                   %% 回复帮会邀请
        kick_out_from_guild/3,            %% 开除帮会成员
        quit_guild/2,                     %% 退出帮会
        get_guild_list/4,                 %% 获取帮会列表
        get_req_join_list/5,              %% 获取申请入帮派的玩家列表
        modify_guild_tenet/3,             %% 修改帮派宗旨（公告）
        appoint_position/3,               %% 帮会授予官职 任命
        check_bid_for_guild_war/2,        %% 检查是否投标帮派争夺战

        db_maybe_load_guild_info/2,       %% 从DB加载帮派信息（插入到ETS_GUILD）， 然后顺带加载帮派成员列表的信息（成员信息插入到ETS_GUILD_MEMBER）。
        get_general_info/1,               %% 帮会基本信息
        get_member_info_list/5,           %% 获取帮派的成员信息列表（依据帮派贡献度做降序排序， 并且截取出IndexStart到IndexEnd之间的成员信息）
        add_guild_dishes/2,
        enter_guild_dungeon/1,
        collect_in_guild_dungeon/2,       %% 在帮派副本采集
        cultivate/4,
        use_goods_for_cultivate/4,
        check_donate/2,
        donate/2,
        battle_feedback/2,

        get_wash_need_gamemoney/1,      %%获取洗髓需要的货币数量
        check_wash/1,                   %%检测洗髓
        do_wash/1,                      %%洗髓

        get_guild_name/1,                 %% 获取帮派名字
        get_guild_chief_id/1,
        get_contri/1,
        get_left_contri/1,
        get_player_cur_contri/1,          %% 获取帮派当前贡献度，非累计
        on_player_finish_guild_task/2,    %% 玩家完成帮派任务回调
        try_teleport_to_guild_scene/3,    %% 尝试传说入帮派地图
        try_change_guild_buff/1,          %% 尝试添加删除玩家战斗外buff
        check_get_guild_pay/2,
        try_notify_player_apply_join/1,   %% 尝试通知玩家有人申请加入帮派
        get_guild_pay/2,                  %% 领取帮派工资
        cache_map_of_guild_id_to_guild_name/2,
        guild_skill_use/2,
        cultivate_level_up/3,
		cultivate_level_up_onekey/2,
        skill_level_up/2,                  %%帮派技能升级
        cultivate_use_goods/3,
        try_fast_get_guild_name/1,
        modify_control/3,
    refresh_guild_shop/0,
guild_shop/2,
purchase_guild_shop/4,
refresh_one_guild_shop/2,
        test/0
    ]).


%% 创建帮派
create_guild(PS, GuildName, Brief) ->
    mod_guild_mgr:create_guild(PS, GuildName, Brief).


%%  解散帮派
disband_guild(PS, GuildId) ->
	case lib_scene:is_guild_dungeon_scene(player:get_scene_id(PS)) of
		true ->
			lib_send:send_prompt_msg(PS, ?PM_DUNGEON_PLEASE_LEAVE);
		false ->
			 gen_server:cast(?GUILD_PROCESS, {'disband_guild', PS, GuildId})
	end.
   


%% 申请加入帮会
apply_join_guild(PS, GuildId) ->
    case check_apply_join_guild(PS, GuildId) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, Guild, Type} ->
            case Type of
                1 ->
                    try_join_guild(PS, Guild);
                2 ->
                    do_apply_join_guild(PS, Guild);
                _ -> ok
            end
    end.

try_join_guild(PS, Guild) ->
    try check_try_join_guild__(PS, Guild) of
        {ok, Guild} ->
            do_join_guild(PS, Guild)
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.


check_try_join_guild__(PS, Guild) ->
    PlayerId = player:get_id(PS),

    ?Ifc (Guild =:= null)
        throw(?PM_GUILD_NOT_EXISTS)
    ?End,
    Lv = mod_guild:get_lv(Guild),

    % 该帮会人数已满
    ?Ifc (mod_guild:get_guild_member_count(Guild) >= mod_guild:get_capacity_by_guild_lv(Lv))
        throw(?PM_GUILD_MEMBER_COUNT_LIMIT)
    ?End,

    % 玩家已有帮会
    ?Ifc (PlayerId /= 0 andalso player:is_online(PlayerId) andalso player:is_in_guild(PlayerId))
        ReqJoinList = lists:keydelete(PlayerId, #join_guild_req.id, Guild#guild.request_joining_list),
        NewGuild = Guild#guild{request_joining_list = ReqJoinList},
        mod_guild:update_guild_to_ets(NewGuild),
        throw(?PM_HAVE_IN_GUILD)
    ?End,

    ?Ifc (mod_guild:get_member_info(PlayerId) =/= null)
        throw(?PM_HAVE_IN_GUILD)
    ?End,

    {ok, Guild}.


do_join_guild(PS, Guild) ->
    PlayerId = player:get_id(PS),

    NewMember = mod_guild:to_member_record([PlayerId, Guild#guild.id, player:get_name(PS), player:get_lv(PS),
        player:get_vip_lv(PS), player:get_sex(PS), player:get_race(PS), player:get_faction(PS),
        svr_clock:get_unixtime(), 0, ply_attr:get_battle_power(PS), 0, 0, 0, 0, 0,0,0,[], 0]),

    MemberIdList =
        case lists:member(PlayerId, Guild#guild.member_id_list) of
            true -> Guild#guild.member_id_list;
            false -> Guild#guild.member_id_list ++ [PlayerId]
        end,

    ReqJoinList = lists:keydelete(PlayerId, #join_guild_req.id, Guild#guild.request_joining_list),
    NewGuild = Guild#guild{request_joining_list = ReqJoinList, member_id_list = MemberIdList},
    NewGuild1 = NewGuild#guild{battle_power = mod_guild:calc_battle_power(NewGuild)},

    mod_guild:update_guild_to_ets(NewGuild1),
    mod_guild:add_member_info_to_ets(NewMember),

    mod_guild:db_save_guild(NewGuild1),
    mod_guild:db_insert_new_member(NewMember),

    mod_guild:db_save_guild_id(PlayerId, Guild#guild.id),

    lib_event:event(had_guild, [], PS),
    player:set_guild_id(PlayerId, Guild#guild.id),

    NowTime = util:unixtime(),
    player:set_enter_guild_time(PS,NowTime),

    ply_tips:send_sys_tips(PS, {join_guild, [
        player:get_name(PS),
        PlayerId
    ]}),

    mod_achievement:notify_achi(apply_join_guild, [], PS),
    lib_scene:notify_string_info_change_to_aoi(PlayerId, [{?OI_CODE_GUILDNAME, Guild#guild.name}]),

    mod_guild:notify_player_join_guild(NewGuild, player:get_name(PS)),
    lib_offcast:cast(PlayerId, {add_title, ?GUILD_TITLE_NO_NORMAL_MEMBER, svr_clock:get_unixtime()}),
    {ok, 1}.


%% 处理玩家入会申请
handle_apply(PS, PlayerId, Choise) ->
    mod_guild_mgr:handle_guild_apply(PS, PlayerId, Choise).


%% 邀请玩家加入帮派
invite_join(PS, ObjPlayerId) ->
    ?TRACE("try to invite player:~p join guild ~n", [ObjPlayerId]),
    case check_invite_join(PS, ObjPlayerId) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, Guild} ->
            do_invite_join(PS, ObjPlayerId, Guild)
    end.


%% 回复帮会邀请
reply_invite(PS, GuildId, Choise) ->
    mod_guild_mgr:reply_invite(PS, GuildId, Choise).


%% 开除帮会成员
kick_out_from_guild(PS, GuildId, ObjPlayerId) ->
    mod_guild_mgr:kick_out_from_guild(PS, GuildId, ObjPlayerId).


%% 退出帮会
quit_guild(PS, GuildId) ->
	case lib_scene:is_guild_dungeon_scene(player:get_scene_id(PS)) of
		true ->
			lib_send:send_prompt_msg(PS, ?PM_DUNGEON_PLEASE_LEAVE);
		false ->
			mod_guild_mgr:quit_guild(PS, GuildId)
	end.
			

    


%% 现在帮派自身信息开服时已经全部加载 现在只是尝试加载帮派成员列表的信息（成员信息插入到ETS_GUILD_MEMBER）。
%% 如果已经加载过，则不做任何处理。
%% 玩家登录游戏时，如果其已经加入了帮派，则会直接或间接调用此接口以加载其所属帮派的信息。
db_maybe_load_guild_info(PlayerId, GuildId) ->
    ?TRACE("try to load guild memberInfo,guildId=~p~n", [GuildId]),
    case GuildId =< 0 of
        true ->
            skip;
        false ->
            case already_load_guild_member_info(PlayerId) of
                true ->
                    mod_guild:try_record_login_player(PlayerId, GuildId);
                false ->
                    gen_server:cast(?GUILD_PROCESS, {'db_maybe_load_guild_info', PlayerId, GuildId})
            end
    end.


%% 帮会基本信息，以列表返回相关信息
get_general_info(GuildId) ->
    case mod_guild:get_info(GuildId) of
        null ->
            % ?ASSERT(false, GuildId),
            [];
        Guild ->
            ?TRACE("get Guild: ~p~n", [Guild]),
            GuildName = Guild#guild.name,
            Lv = Guild#guild.lv,
            Notice = Guild#guild.brief,
            ChiefId = Guild#guild.chief_id,
            Member = mod_guild:get_member_info(ChiefId),
            ?ASSERT(Member /= null),
            ChiefName = 
                case Member =:= null of
                    false -> Member#guild_mb.name;
                    true -> player:get_name(ChiefId)
                end,
            
            Rank = Guild#guild.rank,
            CurMbCount = length(Guild#guild.member_id_list),
            MbCapacity = mod_guild:get_capacity_by_guild_lv(Lv),
            F = fun(Id, AccContri) ->
                AccContri + get_contri(Id)
            end,
            Contri = lists:foldl(F, 0, mod_guild:get_member_id_list(Guild)),

            CurProsper = mod_guild:get_prosper(Guild),
            MaxProsper = 
                case Guild#guild.lv + 1 > lists:last(data_guild_lv:get_all_lv_list()) of
                    false -> (data_guild_lv:get(Guild#guild.lv + 1))#guild_lv_data.need_prosper;
                    true -> (data_guild_lv:get(Guild#guild.lv))#guild_lv_data.need_prosper
                end,
            Fund = Guild#guild.fund,
            State = Guild#guild.state,
            Liveness = Guild#guild.liveness,
            BattlePower = Guild#guild.battle_power,
            Type = Guild#guild.join_control,
            [GuildId, GuildName, Lv, Notice, ChiefId, ChiefName, Rank, CurMbCount, MbCapacity, Contri, CurProsper, MaxProsper, Fund, State, Liveness, BattlePower, Type]
    end.


%% 获取帮派的成员信息列表（依据帮派贡献度做降序排序， 并且截取出IndexStart到IndexEnd之间的成员信息）
%% 排序类型：10/11--> Position; 20/21-->Contri; 30/31-->Lv; 40/41-->BattlePower;  50/51-->VipLv; 60/61--> Faction; 70/71-->Race;80/81 -->Online
%%           90 --> 按帮贡降序排列
%% @return: [] | guild_mb结构体列表
get_member_info_list(SortType, _GuildId, IndexStart, IndexEnd, MemberInfoL) ->
    F10 = fun(Mb1, Mb2) -> Mb1#guild_mb.position > Mb2#guild_mb.position end,
    F11 = fun(Mb1, Mb2) -> Mb1#guild_mb.position < Mb2#guild_mb.position end,

    F20 = fun(Mb1, Mb2) -> Mb1#guild_mb.contri < Mb2#guild_mb.contri end,
    F21 = fun(Mb1, Mb2) -> Mb1#guild_mb.contri > Mb2#guild_mb.contri end,

    F30 = fun(Mb1, Mb2) -> 
        Lv1 = player:get_lv(Mb1#guild_mb.id),
        Lv2 = player:get_lv(Mb2#guild_mb.id),
        Lv1 < Lv2 
    end,

    F31 = fun(Mb1, Mb2) ->  
        Lv1 = player:get_lv(Mb1#guild_mb.id),
        Lv2 = player:get_lv(Mb2#guild_mb.id),
        Lv1 > Lv2 
    end,

    F40 = fun(Mb1, Mb2) -> 
        BattlePower1 = ply_attr:get_battle_power(Mb1#guild_mb.id),
        BattlePower2 = ply_attr:get_battle_power(Mb2#guild_mb.id),
        BattlePower1 < BattlePower2
    end,

    F41 = fun(Mb1, Mb2) -> 
        BattlePower1 = ply_attr:get_battle_power(Mb1#guild_mb.id),
        BattlePower2 = ply_attr:get_battle_power(Mb2#guild_mb.id),
        BattlePower1 > BattlePower2
    end,

    F50 = fun(Mb1, Mb2) -> Mb1#guild_mb.vip_lv < Mb2#guild_mb.vip_lv end,
    F51 = fun(Mb1, Mb2) -> Mb1#guild_mb.vip_lv > Mb2#guild_mb.vip_lv end,

    F60 = fun(Mb1, Mb2) -> Mb1#guild_mb.faction < Mb2#guild_mb.faction end,
    F61 = fun(Mb1, Mb2) -> Mb1#guild_mb.faction > Mb2#guild_mb.faction end,

    F70 = fun(Mb1, Mb2) -> Mb1#guild_mb.race < Mb2#guild_mb.race end,
    F71 = fun(Mb1, Mb2) -> Mb1#guild_mb.race > Mb2#guild_mb.race end,

    F80 = fun(Mb1, Mb2) ->
        Online1 =
        case player:is_online(Mb1#guild_mb.id) of
            true -> 1;
            false -> 0
        end,
        Online2 =
        case player:is_online(Mb2#guild_mb.id) of
            true -> 1;
            false -> 0
        end,
        Online1 < Online2 end,
    F81 = fun(Mb1, Mb2) ->
        Online1 =
        case player:is_online(Mb1#guild_mb.id) of
            true -> 1;
            false -> 0
        end,
        Online2 =
        case player:is_online(Mb2#guild_mb.id) of
            true -> 1;
            false -> 0
        end,
        Online1 > Online2 end,

    F90 = fun(Mb1, Mb2) -> Mb1#guild_mb.contri_today > Mb2#guild_mb.contri_today end,

    MemberInfoSortL =
        case SortType of
            10 -> lists:sort(F10, MemberInfoL);
            11 -> lists:sort(F11, MemberInfoL);
            20 -> lists:sort(F20, MemberInfoL);
            21 -> lists:sort(F21, MemberInfoL);
            30 -> lists:sort(F30, MemberInfoL);
            31 -> lists:sort(F31, MemberInfoL);
            40 -> lists:sort(F40, MemberInfoL);
            41 -> lists:sort(F41, MemberInfoL);
            50 -> lists:sort(F50, MemberInfoL);
            51 -> lists:sort(F51, MemberInfoL);
            60 -> lists:sort(F60, MemberInfoL);
            61 -> lists:sort(F61, MemberInfoL);
            70 -> lists:sort(F70, MemberInfoL);
            71 -> lists:sort(F71, MemberInfoL);
            80 -> lists:sort(F80, MemberInfoL);
            81 -> lists:sort(F81, MemberInfoL);
            90 -> lists:sort(F90, MemberInfoL);
            _Any ->
                ?ASSERT(false, SortType),
                []
        end,

    % 用sublist()截取IndexStart到IndexEnd之间的成员信息，然后返回
    case IndexStart > length(MemberInfoSortL) orelse IndexEnd - IndexStart + 1 < 0 of
        true -> [];
        false ->
            lists:sublist(MemberInfoSortL, IndexStart, IndexEnd - IndexStart + 1)
    end.


%% return guild结构体列表(依据排名升序排序， 并且截取出IndexStart到IndexEnd之间的帮派信息)
get_guild_list(order_by_rank_inc, IndexStart, IndexEnd, AllGuildList) ->
    F = fun(G1, G2) -> G1#guild.rank < G2#guild.rank end,
    GuildSort = lists:sort(F, AllGuildList),
    case IndexStart > length(GuildSort) orelse IndexEnd - IndexStart + 1 < 0 of
        true -> [];
        false ->
            lists:sublist(GuildSort, IndexStart, IndexEnd - IndexStart + 1)
    end.


%% return join_guild_req结构体列表(依据申请时间升序排序， 并且截取出IndexStart到IndexEnd之间的帮派信息)
get_req_join_list(order_by_time_inc, _GuildId, IndexStart, IndexEnd, AllList) ->
    F = fun(R1, R2) -> R1#join_guild_req.time < R2#join_guild_req.time end,
    ReqListSort = lists:sort(F, AllList),
    case IndexStart > length(ReqListSort) orelse IndexEnd - IndexStart + 1 < 0 of
        true -> [];
        false ->
            lists:sublist(ReqListSort, IndexStart, IndexEnd - IndexStart + 1)
    end.


%% 修改帮派宗旨
modify_guild_tenet(PS, GuildId, Tenet) ->
    gen_server:cast(?GUILD_PROCESS, {'modify_guild_tenet', PS, GuildId, Tenet}).


%% 帮会授予官职
appoint_position(PS, ObjPlayerId, Position) ->
    gen_server:cast(?GUILD_PROCESS, {'appoint_position', PS, ObjPlayerId, Position}).


check_bid_for_guild_war(PS, Money) ->
    try check_bid_for_guild_war__(PS, Money) of
        {ok, Guild, GuildMb} -> 
            {ok, Guild, GuildMb}
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

check_bid_for_guild_war__(PS, Money) ->
    ?Ifc (Money =< 0)
        throw(?PM_PARA_ERROR)
    ?End,

    GuildId = player:get_guild_id(PS),
    ?Ifc (GuildId =:= ?INVALID_ID)
        throw(?PM_NOT_IN_GUILD)
    ?End,

    Guild = mod_guild:get_info(GuildId),
    ?Ifc (Guild =:= null)
        throw(?PM_GUILD_NOT_EXISTS)
    ?End,

    ?Ifc (not player:has_enough_money(PS, ?MNY_T_BIND_GAMEMONEY, Money))
        throw(?PM_GAMEMONEY_LIMIT)
    ?End,

    GuildMb = mod_guild:get_member_info(player:id(PS)),
    ?Ifc (GuildMb =:= null)
        throw(?PM_NOT_IN_GUILD)
    ?End,
    
    %% 周一到周四报名
    ?Ifc (util:get_week() >= 5)
        throw(?PM_GUILD_NOT_SIGN_IN_TIME)
    ?End,

    {ok, Guild, GuildMb}.


on_player_finish_guild_task(PS, _TaskId) ->
    case player:get_guild_id(PS) of
        ?INVALID_ID ->
            skip;
        GuildId ->
            Guild = mod_guild:get_info(GuildId),
            AddValue = (data_guild_lv:get(Guild#guild.lv))#guild_lv_data.prospe_add_per_task,
            mod_guild_mgr:add_prosper(GuildId, AddValue),
            % mod_guild:add_guild_member_contri(PS, ?GUILD_CONTRI_PER_TASK, [?LOG_TASK, TaskId]),%策划配置在奖励表了
            mod_guild_mgr:add_liveness(GuildId, ?GUILD_LIVENESS_PER_TASK)
    end.


% return ok | {fail, Reason}
add_guild_dishes(PS, DishesNo) ->
    case check_add_guild_dishes(PS, DishesNo) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, Guild} ->
            do_add_guild_dishes(PS, DishesNo, Guild)
    end.


enter_guild_dungeon(PS) ->
    case player:is_in_dungeon(PS) of
        {true, _} ->
            ?DEBUG_MSG("ply_guild:is_in_dungeon!~n", []),
            {fail, ?PM_DUNGEON_INSIDE};
        _ ->
            GuildId = player:get_guild_id(PS),
            case lib_guild:get_guild_dungeon_rd(GuildId) of
                null -> 
                    ?DEBUG_MSG("ply_guild:PM_GUILD_DUNGEON_NOT_OPENED!~n", []),
                    {fail, ?PM_GUILD_DUNGEON_NOT_OPENED};
                Dungeon ->
                    DunPid = Dungeon#guild_dungeon.dungeon_pid,
                    case is_pid(DunPid) andalso is_process_alive(DunPid) of
                        false -> 
                            ?ERROR_MSG("ply_guild:enter_guild_dungeon():Guild DunPid error!~n", []),
                            {fail, ?PM_GUILD_DUNGEON_NOT_OPENED};
                        true ->
                            case data_guild_dungeon:get(Dungeon#guild_dungeon.floor) of
                                null -> 
                                    ?DEBUG_MSG("ply_guild:PM_DATA_CONFIG_ERROR!~n", []),
                                    {fail, ?PM_DATA_CONFIG_ERROR};
                                DataCfg ->
                                    PlayerMisc = ply_misc:get_player_misc(player:id(PS)),
                                    case util:is_same_week(PlayerMisc#player_misc.guild_dungeon_time) andalso GuildId =/= PlayerMisc#player_misc.guild_dungeon_id of
                                        true -> 
                                            ?DEBUG_MSG("ply_guild:enter_guild_dungeon not allow!~n", []),
                                            {fail, ?PM_GUILD_HAVE_JOIN_DUNGEON};
                                        false ->
                                            ?ASSERT(DataCfg#guild_dungeon_cfg.enter_point =/= null),
                                            MapNo = element(1, DataCfg#guild_dungeon_cfg.enter_point),
                                            X = element(2, DataCfg#guild_dungeon_cfg.enter_point),
                                            Y = element(3, DataCfg#guild_dungeon_cfg.enter_point),
                                            ?DEBUG_MSG("ply_guild:enter_guild_dungeon begin...~n", []),
                                            lib_dungeon:enter_public_dungeon(DunPid, player:id(PS), svr_clock:get_unixtime(), MapNo, X, Y),
                                            ply_misc:update_player_misc(PlayerMisc#player_misc{guild_dungeon_time = util:unixtime(), guild_dungeon_id = GuildId}),
                                            {ok, mod_guild:get_lv(GuildId)}
                                    end
                            end
                    end
            end
    end.


collect_in_guild_dungeon(PS, NpcId) ->
    case lib_guild:get_guild_dungeon_info(PS) of
        null -> {fail, ?PM_GUILD_DUNGEON_NOT_OPENED};
        Dungeon ->
            DunPid = Dungeon#guild_dungeon.dungeon_pid,
            case is_pid(DunPid) of
                false -> {fail, ?PM_GUILD_DUNGEON_NOT_OPENED};
                true ->
                    case data_guild_dungeon:get(Dungeon#guild_dungeon.floor) of
                        null -> {fail, ?PM_DATA_CONFIG_ERROR};
                        DataCfg ->
                            case mod_npc:get_obj(NpcId) of
                                null -> {fail, ?PM_GUILD_DUNGEON_HAVE_COLLECTED};
                                _NpcObj ->
                                    %% 通知获得副本点数
                                    lib_event:event(?DUN_POINTS_THRESHOLD, [DataCfg#guild_dungeon_cfg.point_npc], PS),
                                    lib_guild:notify_dungeon_cellect(Dungeon#guild_dungeon.guild_id, 1),
                                    mod_scene:clear_dynamic_npc_from_scene_WNC(NpcId),
                                    ok
                            end
                    end
            end
    end.


battle_feedback(PS, Feedback) ->
    case Feedback#btl_feedback.result of
        win ->
            case Feedback#btl_feedback.mon_no =:= ?INVALID_NO of
                true -> skip;
                false ->
                    case lib_guild:get_guild_dungeon_info(PS) of
                        null -> skip;
                        Dungeon ->
                            case data_guild_dungeon:get(Dungeon#guild_dungeon.floor) of
                                null -> ?ASSERT(false, Dungeon#guild_dungeon.floor), skip;
                                DataCfg ->
                                    %% 通知获得副本点数
                                    lib_event:event(?DUN_POINTS_THRESHOLD, [DataCfg#guild_dungeon_cfg.point_mon], PS),
                                    lib_guild:notify_add_dungeon_kill_mon(Dungeon#guild_dungeon.guild_id, 1)
                            end
                    end
            end;
        _ -> skip
    end.


% 执行技能升级，这里不做实际扣除和升级保存，返回新PS和累计扣除值在外面最终执行实际扣除操作
do_skill_level_up(PS, No) ->
%%     SkillConfig = data_guild_skill_config:get(No),
    
    CurLv = case lists:keyfind(No, 1, player:get_guild_attrs(PS)) of
        false -> 0;
        {No, Lv} ->  Lv
    end,

    NextLv = CurLv + 1,
	mod_achievement:notify_achi(guild_skill,  [[{guild_skill_lv, NextLv}, {num, 1}]], PS),
    
%%     ConsConfig = data_guild_skill_up_cons_config:get(NextLv),
%%     ConsRatio = SkillConfig#guild_skill_config.cons_ratio,

%%     PriceType = ConsConfig#guild_skill_up_cons_config.price_type,
%%     Price = util:ceil(ConsConfig#guild_skill_up_cons_config.price * ConsRatio), 
%% 
%%     PriceType1 = ?MNY_T_GUILD_CONTRI,
%%     Price1 = util:ceil(ConsConfig#guild_skill_up_cons_config.need_contri * ConsRatio), 

    % 扣除游戏币
%%     player:cost_money(PS, PriceType, Price, [?LOG_GOODS, "guild_skill_lv_up"]),
%%     player:cost_money(PS, PriceType1, Price1, [?LOG_GOODS, "guild_skill_lv_up"]),

    PS1 = set_guild_skill_level(PS,No,NextLv),
%%     player_syn:update_PS_to_ets(PS1),
%%     % ?DEBUG_MSG("do_skill_level_up = ~p",[PS1]),
%%     player:db_save_guild_attrs(PS1),
%%     ply_attr:recount_base_and_total_attrs(PS1), 

%% 	PriceTypeValueL2 =
%% 		lists:foldl(fun({PriceType0, Price0}, PriceTypeValueLAcc) ->
%% 							case lists:keytake(PriceType0, 1, PriceTypeValueLAcc) of
%% 								{value, {PriceType0, PriceVal}, PriceTypeValueLAcc2} ->
%% 									[{PriceType0, PriceVal + Price0}|PriceTypeValueLAcc2];
%% 								?false ->
%% 									[{PriceType0, Price0}|PriceTypeValueLAcc]
%% 							end
%% 					end, PriceTypeValueL, [{PriceType, Price}, {PriceType1, Price1}]),
    {PS1, NextLv}.

% 技能使用
guild_skill_use(PS, No) ->
    case check_guild_skill_use(PS, No) of
        {fail, Reason} ->
            {fail, Reason};
        ok ->
            do_guild_skill_use(PS, No)
    end.

check_guild_skill_use(PS,No) ->
    try check_guild_skill_use__(PS, No) of
        ok ->
            ok
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

% 检测技能升级相关
check_guild_skill_use__(PS, No) ->
    SkillConfig = data_guild_skill_config:get(No),

    CurLv = case lists:keyfind(No, 1, player:get_guild_attrs(PS)) of
        false -> 0;
        {No, Lv} ->  Lv
    end,

    ?Ifc(SkillConfig =:= null)
        throw(?PM_PARA_ERROR)
    ?End,

    ?Ifc(not is_record(SkillConfig, guild_skill_config))
        throw(?PM_PARA_ERROR)
    ?End,

    {InitValue,LvValue} = SkillConfig#guild_skill_config.vitality,

    Price = util:ceil(InitValue + CurLv * LvValue),
    PriceType = ?MNY_T_VITALITY,

    % 金钱是否足够
    RetMoney = player:check_need_price(PS,PriceType,Price),

    ?Ifc (RetMoney =/= ok)
        throw(RetMoney)
    ?End,

    PlayerId = player:id(PS),
    % 判断是否有空格子
    BagFull2 = mod_inv:is_bag_usable_full(PlayerId),
    BagFull3 = mod_inv:is_bag_unusable_full(PlayerId),

    ?Ifc (BagFull2 orelse BagFull3)
        if
            BagFull2 -> throw(?PM_US_BAG_FULL);
            true -> throw(?PM_UNUS_BAG_FULL)
        end
    ?End,

    ok.

% 执行技能使用
do_guild_skill_use(PS, No) ->
    SkillConfig = data_guild_skill_config:get(No),
    
    CurLv = case lists:keyfind(No, 1, player:get_guild_attrs(PS)) of
        false -> 0;
        {No, Lv} ->  Lv
    end,

    {InitValue,LvValue} = SkillConfig#guild_skill_config.vitality,

    Price = util:ceil(InitValue + CurLv * LvValue),
    PriceType = ?MNY_T_VITALITY,

    GoodsList2 = SkillConfig#guild_skill_config.goods_list,
    ?DEBUG_MSG("util:floor(CurLv/10)*10 =~p",[util:floor(CurLv/10)*10 ]),
    % 过滤1
    F1 = fun({Lv,GoodsNo, Widget},List) ->
        case util:floor(CurLv/10)*10 of
            Lv ->
                [{Lv,GoodsNo, Widget}];
            _->
                List
        end
    end,

    % ?DEBUG_MSG("(~p),~p)",[lists:member(SkillConfig#guild_skill_config.type, [minor_build,minor_tailor,minor_alchemy]),SkillConfig#guild_skill_config.type]),

    % 如果属于
    GoodsList = 
    case lists:member(SkillConfig#guild_skill_config.skill_name, [minor_build,minor_tailor,minor_alchemy]) of 
        true -> lists:foldl(F1, [], GoodsList2);
        _ -> GoodsList2
    end,

    ?DEBUG_MSG("GoodsList=~p",[GoodsList]),

    F = fun({Lv,GoodsNo, Widget},List) ->
        if 
            CurLv >= Lv -> 
                List ++ [{Lv,GoodsNo, Widget}];
            true ->
                List
        end
    end,

    GoodsList1 = lists:foldl(F, [], GoodsList),

    GoodsNo = lib_guild:get_random_make_goods_no(GoodsList1),

    Min = util:ceil(CurLv / 2) + 1,
    Max = CurLv + Min,

    QualityLv = case lists:member(SkillConfig#guild_skill_config.skill_name, [minor_build,minor_tailor,minor_alchemy]) of 
        true -> 0;
        _ -> util:rand(Min,Max)
    end,


    % 扣除游戏币
    player:cost_money(PS, PriceType, Price, [?LOG_GOODS, "guild_skill_lv_use"]),
    mod_inv:add_new_goods_to_bag_by_guild_use(player:id(PS), GoodsNo, 1, QualityLv,[{bind_state,?BIND_ON_USE}]).


% 修炼技能升级 一键升级为0
cultivate_level_up(PS, No, 0) ->
	%% 这里做成异步循环通知调用
	%% 正常调用一次然后执行异步同步回调
	case check_cultivate_level_up(PS, No, 1) of
		{fail, Reason} ->
			{fail, Reason};
		ok ->
			case do_cultivate_level_up(PS, No, 1) of
				{ok, Lv,Point} ->
					cultivate_level_up_onekey(player:get_id(PS), No),
					{ok, Lv,Point};
				{fail, Reason} ->
					{fail, Reason}
			end
	end;

cultivate_level_up(PS, No,Count) ->
    case check_cultivate_level_up(PS, No,Count) of
        {fail, Reason} ->
            {fail, Reason};
        ok ->
            case do_cultivate_level_up(PS, No,Count) of
				{ok, Lv,Point} ->
					{ok, Lv,Point};
				{fail, Reason} ->
					{fail, Reason}
			end
    end.

cultivate_level_up_onekey(PlayerId, No) ->
	PS = player:get_PS(PlayerId),
	case check_cultivate_level_up(PS, No, 1) of
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason);
		ok ->
			case do_cultivate_level_up(player:get_PS(PlayerId), No, 1) of
				{ok, Lv,Point} ->
					{ok, BinData} = pt_40:write(?PT_CULTIVATE_SKILL_LEVEL_UP, [No, Lv,Point]),
					lib_send:send_to_sock(player:get_socket(PS), BinData),
					gen_server:cast(player:get_pid(PS), {apply_cast, ?MODULE, cultivate_level_up_onekey, [PlayerId, No]});
				{fail, Reason} ->
					lib_send:send_prompt_msg(PS, Reason)
			end
	end.

%% 	Key = lists:concat(["cultivate_lvlup_", Uid]),
%% 	case erlang:get(Key) of
%% 		?undefined ->
%% 			%% 开始执行，存入Key
%% 			erlang:put(Key, true),
%% 			gen_server:cast(Uid, {apply_cast, ?MODULE, add_sys_activity_times, [Uid, No]});
%% 		true ->
%% 			case do_cultivate_level_up(PS, No,Count) of
%% 				{ok, Lv,Point} ->
%% 					gen_server:cast(Uid, {apply_cast, ?MODULE, add_sys_activity_times, [Uid, No]}),
%% 					{ok, Lv,Point};
%% 				{fail, Reason} ->
%% 					erlang:put(Key, false),
%% 					{fail, Reason}
%% 			end;
%% 		false ->
%% 			erlang:erase(Key)
%% 	end.
    

%% cultivate_level_up_after(PS2) ->
%% 	player_syn:update_PS_to_ets(PS2),
%% 	player:db_save_cultivate_attrs(PS2),
%% 	ply_attr:recount_base_and_total_attrs(PS2),
%% 	% 成就判断
%% 	case player:get_cultivate_attrs(PS2) of
%% 		List when is_list(List) ->
%% 			
%% 			%扩展通知成就
%% 			F1 = fun(Q, Acc) ->
%% 						 F2 = fun({CNo, CLv, _CPoint}, Sum) ->
%% 									  case CLv =:= Q of
%% 										  true -> Sum + 1;
%% 										  false -> Sum
%% 									  end
%% 							  end,
%% 						 Num = lists:foldl(F2, 0, List),
%% 						 [[{lv, Q}, {num, Num}] | Acc]
%% 				 end,
%% 			InfoList = lists:foldl(F1, [], [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]),
%% 			mod_achievement:notify_achi(cultivate_new, InfoList, PS2);
%% 		
%% 		_ ->
%% 			skip
%% 	end.
	

check_cultivate_level_up(PS,No,Count) ->
    try check_cultivate_level_up__(PS, No,Count) of
        ok ->
            ok
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

calc_cultivate_lv_limit(PS) ->
    Lv = player:get_lv(PS),
    if 
		Lv >= 80 -> 30;
        Lv >= 70 -> 20;
        Lv >= 65 -> 16;
        Lv >= 60 -> 8;
        Lv >= 55 -> 4;
        Lv >= 50 -> 2;
        Lv >= 45 -> 1;
        true -> 0
    end.


%% 	ok.
% 检测技能升级相关
check_cultivate_level_up__(PS, No,Count) ->
    SkillConfig = data_guild_cultivate_learn_config:get(No),

    {CurLv,CurPoint} = case lists:keyfind(No, 1, player:get_cultivate_attrs(PS)) of
        false -> {0,0};
        {No, Lv, Point} ->  {Lv,Point}
    end,

    ?Ifc(SkillConfig =:= null)
        throw(?PM_PARA_ERROR)
    ?End,

    %点修结构体
    ?Ifc(not is_record(SkillConfig, guild_cultivate_learn_cfg))
        throw(?PM_PARA_ERROR)
    ?End,

    NextLv = CurLv + 1,

    ?Ifc(NextLv > ?GUILD_MAX_CULTIVATE_LV orelse NextLv > calc_cultivate_lv_limit(PS))
        throw(?PM_GUILD_CULTIVATE_LV_MAX)
    ?End, 

    ConsConfig = data_guild_cultivate_config:get(NextLv),

    % 技能升级消耗配置是否存在
    ?Ifc(ConsConfig =:= null)
        throw(?PM_PARA_ERROR)
    ?End, 

    % 是否是正确配置
    ?Ifc(not is_record(ConsConfig, guild_cultivate_lv_cfg))
        throw(?PM_PARA_ERROR)
    ?End,    

    PriceType = ConsConfig#guild_cultivate_lv_cfg.price_type,
    Price = util:ceil(ConsConfig#guild_cultivate_lv_cfg.price * Count), 

    RetMoney = player:check_need_price(PS,PriceType,Price),
    ?Ifc (RetMoney =/= ok)
        throw(RetMoney)
    ?End,

    ok.

% 计算升级后
calc_new_lv(PS,No,CurLv,Point) ->
    SkillConfig = data_guild_cultivate_learn_config:get(No),
    ConsRatio = SkillConfig#guild_cultivate_learn_cfg.cons_ratio,

    MaxLv = calc_cultivate_lv_limit(PS),

    if 
        CurLv >= MaxLv ->
            {CurLv,0,Point};
        true ->
            NextLv = CurLv + 1,
            ConsConfig = data_guild_cultivate_config:get(NextLv),
            NeedPoint = util:ceil(ConsConfig#guild_cultivate_lv_cfg.need_point * ConsRatio),

            if 
                Point >= NeedPoint ->         
                    NewPoint = Point - NeedPoint,
                    calc_new_lv(PS,No,NextLv,NewPoint);
                true ->
                    {CurLv,Point,0}
            end            
    end.

do_cultivate_level_up(PS, No, Count) ->
    SkillConfig = data_guild_cultivate_learn_config:get(No),
    
    {CurLv,CurPoint} = case lists:keyfind(No, 1, player:get_cultivate_attrs(PS)) of
        false -> {0,0};
        {No, Lv, Point} ->  {Lv,Point}
    end,

    NextLv = CurLv + 1,

    ConsConfig = data_guild_cultivate_config:get(NextLv),
    PriceType = ConsConfig#guild_cultivate_lv_cfg.price_type,
    Price = util:ceil(ConsConfig#guild_cultivate_lv_cfg.price * Count), 

    % 扣除游戏币, 有循环调用的情况，改成syn的方式
%%     player:cost_money(PS, PriceType, Price, [?LOG_GOODS, "guild_cultivate"]),
	PS1 = player_syn:cost_money(PS, PriceType, Price, [?LOG_GOODS, "guild_cultivate"]),

    AddPoint = Count * ?GUILD_CULTIVATE_ADD_ONCE,

    {NewLv,NewPoint,_LeftPoint} = calc_new_lv(PS,No,CurLv,AddPoint + CurPoint),

    PS2 = set_cultivate_attrs(PS1,No,NewLv,NewPoint),

    player_syn:update_PS_to_ets(PS2),
    player:db_save_cultivate_attrs(PS2),

    ply_attr:recount_base_and_total_attrs(PS2),
	
    % 成就判断
    cultivate_achievement(PS2),

    {ok,NewLv,NewPoint}.





% 使用道具增加帮派修炼进度
cultivate_use_goods(PS, No, Count) ->
    case check_cultivate_use_goods(PS, No, Count) of
        {fail, Reason} ->
            {fail, Reason};
        ok ->
            do_cultivate_use_goods(PS, No, Count)
    end.


check_cultivate_use_goods(PS, No, Count) ->
    try check_cultivate_use_goods__(PS, No,Count) of
        ok -> ok
    catch
        throw: Reason ->
            {fail, Reason}
    end.

check_cultivate_use_goods__(PS, No,Count) ->
    SkillConfig = data_guild_cultivate_learn_config:get(No),
    GoodsNo = SkillConfig#guild_cultivate_learn_cfg.goods_no,

    {CurLv,CurPoint} = case lists:keyfind(No, 1, player:get_cultivate_attrs(PS)) of
        false -> {0,0};
        {No, Lv, Point} ->  {Lv,Point}
    end,

    ?Ifc(SkillConfig =:= null)
        throw(?PM_PARA_ERROR)
    ?End,

    %点修结构体
    ?Ifc(not is_record(SkillConfig, guild_cultivate_learn_cfg))
        throw(?PM_PARA_ERROR)
    ?End,

    NextLv = CurLv + 1,

    ?Ifc(NextLv > ?GUILD_MAX_CULTIVATE_LV orelse NextLv > calc_cultivate_lv_limit(PS))
        throw(?PM_GUILD_CULTIVATE_LV_MAX)
    ?End, 

    ConsConfig = data_guild_cultivate_config:get(NextLv),
    AddPoint = Count * ?GUILD_CULTIVATE_GOODS_ADD_ONCE,

    % {NewLv,NewPoint,LeftPoint} = calc_new_lv(PS,No,CurLv,AddPoint + CurPoint),

    % %%需要返还的道具数量
    % ReturnBackGoodsCount = util:ceil(LeftPoint / ?GUILD_CULTIVATE_ADD_USE_GOODS),

    % CanAddGoods = case mod_inv:check_batch_add_goods(player:id(PS), [{GoodsNo, ReturnBackGoodsCount}]) of        
    %     {fail, FailReason} -> FailReason;
    %     ok -> ok
    % end,

    % ?Ifc (CanAddGoods =/= ok)
    %     throw(CanAddGoods)
    % ?End,

    % 技能升级消耗配置是否存在
    ?Ifc(ConsConfig =:= null)
        throw(?PM_PARA_ERROR)
    ?End, 

    ?Ifc (mod_inv:get_goods_count_in_bag_by_no(player:get_id(PS), GoodsNo) < Count)
        throw(?PM_PAR_ALCHEMY_LIMIT)
    ?End,

    ok.

do_cultivate_use_goods(PS, No, Count) ->
    SkillConfig = data_guild_cultivate_learn_config:get(No),

    GoodsNo = SkillConfig#guild_cultivate_learn_cfg.goods_no,
    
    {CurLv,CurPoint} = case lists:keyfind(No, 1, player:get_cultivate_attrs(PS)) of
        false -> {0,0};
        {No, Lv, Point} ->  {Lv,Point}
    end,

    NextLv = CurLv + 1,

    ConsConfig = data_guild_cultivate_config:get(NextLv),

    AddPoint = Count * ?GUILD_CULTIVATE_GOODS_ADD_ONCE,

    {NewLv,NewPoint,LeftPoint} = calc_new_lv(PS,No,CurLv,AddPoint + CurPoint),

    ReturnBackGoodsCount = util:floor(LeftPoint/?GUILD_CULTIVATE_GOODS_ADD_ONCE),

    mod_inv:destroy_goods_WNC(player:get_id(PS), [{GoodsNo, Count - ReturnBackGoodsCount}], [?LOG_GUILD, "cultivate"]),

    ?DEBUG_MSG("NewLv=~p,NewPoint=~p,ReturnBackGoodsCount=~p",[NewLv,NewPoint,ReturnBackGoodsCount]),

    % %添加道具
    % case mod_inv:batch_smart_add_new_goods(player:id(PS), [{?GUILD_CULTIVATE_GOODS_NO, ReturnBackGoodsCount}], [{bind_state, ?BIND_ON_GET}], [?LOG_GUILD, "cultivate"]) of
    %     {fail, Reason} ->
    %         ?ERROR_MSG("Add Goods Error,PlayerId:~p,Reason:~p~n", [player:id(PS), Reason]);
    %     {ok, _GoodsList} ->  void
    % end,

    PS1 = set_cultivate_attrs(PS,No,NewLv,NewPoint),

    player_syn:update_PS_to_ets(PS1),
    player:db_save_cultivate_attrs(PS1),

    ply_attr:recount_base_and_total_attrs(PS1), 
	cultivate_achievement(PS1),
    {ok,NewLv,NewPoint}.



cultivate_achievement(PS) ->
	case player:get_cultivate_attrs(PS) of
		List when is_list(List) ->
			
			%扩展通知成就 [[{cultivate_lv, 10}, {num, 3}] | Acc]
			F1 = fun(Q, Acc) ->
						 F2 = fun({_CNo, CLv, _CPoint}, Sum) ->
									  case CLv =:= Q of
										  true -> Sum + 1;
										  false -> Sum
									  end
							  end,
						 Num = lists:foldl(F2, 0, List),
						 [[{lv, Q}, {num, Num}] | Acc]
				 end,
			InfoList = lists:foldl(F1, [], [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]),
			mod_achievement:notify_achi(cultivate_new, InfoList, PS);
		_ ->
			skip
	end.

%% 技能升级
%% @return {ok, PS, [{No, Lv}]} | {fail, Reason}
% 技能升级, 一键升级
skill_level_up(PS, 0) ->% 一键升级
	skill_level_up_onekey(PS, ?true, [], []);
	
%% 特定技能升级，普通单次升级
skill_level_up(PS, No) ->
    case check_skill_level_up(PS, No, []) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, PriceTypeValueL} ->
            {PS1, Lv} = do_skill_level_up(PS, No),
			%% 做实际扣除和保存
			% 修改为同步扣钱
			PS2 = 
				lists:foldl(fun({PriceType, Price}, PSAcc) ->
									player_syn:cost_money(PSAcc, PriceType, Price, [?LOG_ROLE, "guild_skill_up"])
							end, PS1, PriceTypeValueL),
			player_syn:update_PS_to_ets(PS2),
			player_syn:update_PS_to_ets(PS2),
			player:db_save_guild_attrs(PS2),
			ply_attr:recount_base_and_total_attrs(PS2), 
			{ok, PS2, [{No, Lv}]}
			
    end.

%% 一键升级的话先模拟升？在最后不满足条件的时候再做扣除升级处理？
skill_level_up_onekey(PS, IsFirst, PriceTypeValueL, NoLvL) ->
	case get_lowest_guild_skill(PS) of
		{SkillNo, _} ->
			case check_skill_level_up(PS, SkillNo, PriceTypeValueL) of
				{ok, PriceTypeValueL2} ->
					{PS2, Lv} = do_skill_level_up(PS, SkillNo),
					NoLvL3 = 
						case lists:keytake(SkillNo, 1, NoLvL) of
							{value, {SkillNo, _}, NoLvL2} ->
								[{SkillNo, Lv}|NoLvL2];
							?false ->
								[{SkillNo, Lv}|NoLvL]
						end,
					skill_level_up_onekey(PS2, ?false, PriceTypeValueL2, NoLvL3);
				{fail, Reason} ->
					case IsFirst of
						?true ->
							%% 第一次就不满足了
							{fail, Reason};
						?false ->
							%% 做实际扣除和保存
							% 修改为同步扣钱
							PS2 = 
								lists:foldl(fun({PriceType, Price}, PSAcc) ->
													player_syn:cost_money(PSAcc, PriceType, Price, [?LOG_ROLE, "guild_skill_up"])
											end, PS, PriceTypeValueL),
							player_syn:update_PS_to_ets(PS2),
							player_syn:update_PS_to_ets(PS2),
							player:db_save_guild_attrs(PS2),
							ply_attr:recount_base_and_total_attrs(PS2), 
							{ok, PS2, NoLvL}
					end
			end;
		_ ->
			%% 没有技能？
			{ok, PS, NoLvL}
	end.

%% 获取最低等级的技能
get_lowest_guild_skill(PS) ->
	SkillL0 = player:get_guild_attrs(PS),
	Nos = data_guild_skill_config:get_nos(),
	case lists:foldl(fun(No, SkillLAcc) ->
							 case lists:keymember(No, 1, SkillL0) of
								 ?true ->
									 SkillLAcc;
								 ?false ->
									 [{No, 0}|SkillLAcc]
							 end
					 end, SkillL0, Nos) of
		[] ->
			null;
		SkillL ->
			{_, Lv} = erlang:hd(SkillL),
			case lists:all(fun({_, LvAcc}) ->
								   LvAcc == Lv
						   end, SkillL) of
				?true ->
					erlang:hd(lists:keysort(1, SkillL));
				?false ->
					Fun = fun({No, Lv} = Skill, {NoAcc, LvAcc} = Acc) ->
								  case Lv < LvAcc of
									  ?true ->
										  Skill;
									  ?false ->
										  case Lv == LvAcc andalso No < NoAcc of
											  ?true ->
												  Skill;
											  ?false ->
												  Acc
										  end
								  end;
							 (Skill, _Acc) ->
								  Skill
						  end,
					lists:foldl(Fun, null, SkillL)
			end
	end.

check_skill_level_up(PS, No, PriceTypeValueL) ->
    try check_skill_level_up__(PS, No, PriceTypeValueL) of
        {ok, PriceTypeValueL2} ->
            {ok, PriceTypeValueL2}
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

%% 在外面带一个累计值进来
%% @return {ok, PriceTypeValueL} | RetCode
check_cost_for_skill_level_up(PS, Data,ConsRatio, PriceTypeValueL) ->
    PriceType = Data#guild_skill_up_cons_config.price_type,
    Price = util:ceil(Data#guild_skill_up_cons_config.price * ConsRatio), 

	PriceTypeContri = ?MNY_T_GUILD_CONTRI,
    PriceContri = util:ceil(Data#guild_skill_up_cons_config.need_contri * ConsRatio), 
	
	PriceTypeValueL2 =
		lists:foldl(fun({PriceType0, Price0}, PriceTypeValueLAcc) ->
							case lists:keytake(PriceType0, 1, PriceTypeValueLAcc) of
								{value, {PriceType0, PriceVal}, PriceTypeValueLAcc2} ->
									[{PriceType0, PriceVal + Price0}|PriceTypeValueLAcc2];
								?false ->
									[{PriceType0, Price0}|PriceTypeValueLAcc]
							end
					end, PriceTypeValueL, [{PriceType, Price}, {PriceTypeContri, PriceContri}]),
	
	Ret = check_cost_for_skill_level_up(PS, PriceTypeValueL2),
	{Ret, PriceTypeValueL2}.

check_cost_for_skill_level_up(_PS, []) ->
	ok;

check_cost_for_skill_level_up(PS, [{PriceType, Price}|PriceTypeValueL]) ->
	case player:check_need_price(PS,PriceType,Price) of
		ok ->
			check_cost_for_skill_level_up(PS, PriceTypeValueL);
		Ret ->
			Ret
	end.

% 检测技能升级相关
check_skill_level_up__(PS, No, PriceTypeValueL) ->
    SkillConfig = data_guild_skill_config:get(No),

    CurLv = case lists:keyfind(No, 1, player:get_guild_attrs(PS)) of
        false -> 0;
        {No, Lv} ->  Lv
    end,

    ?Ifc(SkillConfig =:= null)
        throw(?PM_PARA_ERROR)
    ?End,

    ?Ifc(not is_record(SkillConfig, guild_skill_config))
        throw(?PM_PARA_ERROR)
    ?End,

    NextLv = CurLv + 1,

    MaxLv = player:get_player_max_lv(PS),

	ConsConfig = data_guild_skill_up_cons_config:get(NextLv),

    ?Ifc(not is_record(ConsConfig, guild_skill_up_cons_config))
        throw(?PM_PARA_ERROR)
    ?End,

    % 是否超过上限等级, 修改限制为消耗配置表的need_lv字段
%%     ?Ifc(NextLv > (player:get_lv(PS) + 10) orelse NextLv > MaxLv )
%%         throw(?PM_GUILD_LEVEL_IS_MAX)
%%     ?End,
	?Ifc(  (player:get_lv(PS) < ConsConfig#guild_skill_up_cons_config.need_lv ) orelse NextLv > MaxLv )
        throw(?PM_GUILD_LEVEL_IS_MAX)
    ?End,

	% 技能升级消耗配置是否存在
    ?Ifc(ConsConfig =:= null)
        throw(?PM_PARA_ERROR)
    ?End, 

    ?DEBUG_MSG("ConsConfig=~p",[ConsConfig]),

    ConsRatio = SkillConfig#guild_skill_config.cons_ratio,
    % 金钱是否足够
    {RetMoney, PriceTypeValueL2} = check_cost_for_skill_level_up(PS, ConsConfig,ConsRatio, PriceTypeValueL),

    ?Ifc (RetMoney =/= ok)
        throw(RetMoney)
    ?End,

    {ok, PriceTypeValueL2}.


cultivate(PS, ObjInfoCode, Count, Type) ->
    cultivate(PS, ObjInfoCode, Count, Type, [], 0, 0).


cultivate(PS, _ObjInfoCode, 0, Type, RetList, AccMoney, AccContri) ->
    PS1 = 
        case AccMoney > 0 of
            true -> 
                case Type =:= 1 of
                    true ->
                        player_syn:cost_money(PS, ?MNY_T_GAMEMONEY, AccMoney, [?LOG_GUILD, "cultivate"]);
                    false ->
                        player_syn:cost_exp(PS, AccMoney, [?LOG_GUILD, "cultivate"])
                end;
            false -> PS
        end,
    % case mod_guild_mgr:cost_member_contri(PS, AccContri, [?LOG_GUILD, "cultivate"]) of
    case player:cost_guild_contri(PS, AccContri, [?LOG_GUILD, "cultivate"]) of
        ok -> skip;
        {fail, _Reason} -> ?ERROR_MSG("ply_guild:cultivate() cost_member_contri error!~p~n", [_Reason])
    end,
    {RetList, PS1};

cultivate(PS, ObjInfoCode, Count, Type, RetList, AccMoney, AccContri) when Count > 0 ->
    case check_cultivate(PS, ObjInfoCode, Type, AccMoney, AccContri) of
        {fail, Reason} ->
            PS1 = 
                case AccMoney > 0 of
                    true -> 
                        case Type =:= 1 of
                            true ->
                                player_syn:cost_money(PS, ?MNY_T_GAMEMONEY, AccMoney, [?LOG_GUILD, "cultivate"]);
                            false ->
                                player_syn:cost_exp(PS, AccMoney, [?LOG_GUILD, "cultivate"])
                        end;
                    false -> PS
                end,
            % case mod_guild_mgr:cost_member_contri(PS, AccContri, [?LOG_GUILD, "cultivate"]) of
            case player:cost_guild_contri(PS, AccContri, [?LOG_GUILD, "cultivate"]) of
            
                ok -> skip;
                {fail, Reason} -> ?ERROR_MSG("ply_guild:cultivate() cost_member_contri error!~n", [])
            end,
            {RetList ++ [{Reason, 0}], PS1}; %% {结果代码, 本次获得修炼值}
        ok ->
            GuildAttr = player:get_guild_attrs(PS),
            AttrName = lib_attribute:obj_info_code_to_attr_name(ObjInfoCode),
            CultivateLv = 
                case lists:keyfind(AttrName, 1, GuildAttr) of
                    false -> 0;
                    {_, Lv, _Value} -> Lv
                end,

            DataCultivate = data_guild_cultivate:get(CultivateLv),
            AccMoney1 = 
                case Type =:= 1 of
                    true -> AccMoney + DataCultivate#guild_cultivate_cfg.need_gamemoney;
                    false -> AccMoney + DataCultivate#guild_cultivate_cfg.need_exp
                end,

            AccContri1 = 
                case Type =:= 1 of
                    true -> AccContri + DataCultivate#guild_cultivate_cfg.need_contri;
                    false -> AccContri + DataCultivate#guild_cultivate_cfg.need_contri_2
                end,
            
            RandNum = util:rand(1, 100),
            {RetCode, GetCultivate} = 
                case 1 =< RandNum andalso RandNum =< 2 of
                    true -> {1, 100};
                    false -> {0, 50}
                end,

            PS2 = add_cultivate(PS, AttrName, GetCultivate),
            RetList1 = RetList ++ [{RetCode, GetCultivate}],
            cultivate(PS2, ObjInfoCode, Count - 1, Type, RetList1, AccMoney1, AccContri1)
    end.

use_goods_for_cultivate(PS, ObjInfoCode, GoodsNo, Count) ->
    case check_use_goods_for_cultivate(PS, ObjInfoCode, GoodsNo, Count) of
        {fail, Reason} ->
            {fail, Reason};
        ok ->
            do_use_goods_for_cultivate(PS, ObjInfoCode, GoodsNo, Count)
    end.


donate(PS, Contri) ->
    case check_donate(PS, Contri) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, Guild, GuildMb} ->
            do_donate(PS, Contri, Guild, GuildMb)
    end.


try_notify_player_apply_join(PS) ->
    case player:get_guild_id(PS) of
        ?INVALID_ID -> skip;
        GuildId ->
            case mod_guild:get_info(GuildId) of
                null -> skip;
                Guild ->
                    case Guild#guild.request_joining_list =:= [] of
                        true -> skip;
                        false ->
                            PlayerId = player:id(PS),
                            case mod_guild:decide_guild_pos(PlayerId, Guild) of
                                ?GUILD_POS_CHIEF -> notify_player_apply_join([PS]);
                                ?GUILD_POS_COUNSELLOR -> notify_player_apply_join([PS]);
                                _ -> skip
                            end
                    end
            end
    end.


%% ------------------------------------------------Local Funciotns------------------------------------------------------


do_donate(PS, Contri, Guild, GuildMb) ->
    NeedGameMoney = util:ceil(Contri / 2 * 15000),
    NewPS = player_syn:cost_money(PS, ?MNY_T_GAMEMONEY, NeedGameMoney, [?LOG_GUILD, "donate"]),
    GetProsper = util:ceil(Contri / 2 * 5),

    GuildMb_Latest = 
        case mod_guild:add_guild_member_contri(PS, Contri, []) of
            {ok, NewGuildMb} ->
                {ok, NewGuildMb1} = mod_guild:add_guild_member_donate(NewGuildMb, NeedGameMoney),
                NewGuildMb1;
            _ -> GuildMb
        end,

    case mod_guild:add_prosper(Guild, GetProsper) of
        {ok, NewGuild} ->
            may_change_donate_rank(NewGuild, GuildMb_Latest),
            {ok, GetProsper, NewPS};
        _ ->
            may_change_donate_rank(Guild, GuildMb_Latest), 
            {ok, 0, NewPS}
    end.


check_donate(PS, Contri) ->
    try check_donate__(PS, Contri) of
        {ok, Guild, GuildMb} -> 
            {ok, Guild, GuildMb}
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.


check_donate__(PS, Contri) ->
    ?Ifc (Contri =< 0)
        throw(?PM_PARA_ERROR)
    ?End,
    
    GuildId = player:get_guild_id(PS),
    ?Ifc (GuildId =:= ?INVALID_ID)
        throw(?PM_NOT_IN_GUILD)
    ?End,

    Guild = mod_guild:get_info(GuildId),
    ?Ifc (Guild =:= null)
        throw(?PM_GUILD_NOT_EXISTS)
    ?End,

    CanDonateMax = 
        case mod_guild:decide_guild_pos(player:id(PS), Guild) of
            ?GUILD_POS_CHIEF -> lib_vip:welfare(max_donate_money_chief, PS);
            ?GUILD_POS_COUNSELLOR -> lib_vip:welfare(max_donate_money_junshi, PS);
            ?GUILD_POS_SHAOZHANG -> lib_vip:welfare(max_donate_money_tangzhu, PS);
            ?GUILD_POS_NORMAL_MEMBER -> lib_vip:welfare(max_donate_money_normal, PS)
        end,

    GuildMb = mod_guild:get_member_info(player:id(PS)),
    ?Ifc (GuildMb =:= null)
        throw(?PM_NOT_IN_GUILD)
    ?End,

    DonateToday = mod_guild:get_mb_donate_today(GuildMb),

    %% 兑换比例为：15000银子=2点帮派贡献度+5点帮派繁荣度
    NeedGameMoney = util:ceil(Contri / 2 * 15000),
    ?Ifc (not player:has_enough_gamemoney(PS, NeedGameMoney))
        throw(?PM_GAMEMONEY_LIMIT)
    ?End,

    ?Ifc (DonateToday + NeedGameMoney > CanDonateMax)
        throw(?PM_GUILD_DONATE_TODAY_LIMIT)
    ?End,

    {ok, Guild, GuildMb}.


check_use_goods_for_cultivate(PS, ObjInfoCode, GoodsNo, Count) ->
    try check_use_goods_for_cultivate__(PS, ObjInfoCode, GoodsNo, Count) of
        ok -> ok
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

% 设置为新等级
set_guild_skill_level(PS, No, Level) ->
    GuildAttr = player:get_guild_attrs(PS),

    GuildAttr1 = 
        case lists:keyfind(No, 1, GuildAttr) of
            false -> [{No, 1} | GuildAttr];
            { No, _CurLv} -> lists:keyreplace(No, 1, GuildAttr, {No, Level})
        end,

    PS#player_status{guild_attrs = GuildAttr1}.


% 设置为新等级
set_cultivate_attrs(PS, No, Lv,Point) ->
    CultivateAttr = player:get_cultivate_attrs(PS),

    CultivateAttr1 = 
        case lists:keyfind(No, 1, CultivateAttr) of
            false -> [{No, Lv, Point} | CultivateAttr];
            { No, _Lv,_Point} -> lists:keyreplace(No, 1, CultivateAttr, {No, Lv,Point})
        end,
    PS#player_status{cultivate_attrs = CultivateAttr1}.



add_cultivate(PS, AttrName, GetCultivate) ->
    GuildAttr = player:get_guild_attrs(PS),
    {NowLv, NowVaule} = 
        case lists:keyfind(AttrName, 1, GuildAttr) of
            false -> {0, 0};
            {_, Lv, Value} -> {Lv, Value}
        end,
    DataCultivate = data_guild_cultivate:get(NowLv),
    {NewLv, NewValue} = 
        case NowVaule + GetCultivate < DataCultivate#guild_cultivate_cfg.need_point_next_lv of
            true ->
                {NowLv, NowVaule + GetCultivate};
            false ->
                change_cultivate_lv_by_cultivate(NowLv, NowVaule + GetCultivate)
        end,
    GuildAttr1 = 
        case lists:keyfind(AttrName, 1, GuildAttr) of
            false -> [{AttrName, NewLv, NewValue} | GuildAttr];
            {_, _Lv, _Value} -> lists:keyreplace(AttrName, 1, GuildAttr, {AttrName, NewLv, NewValue})
        end,
    PS#player_status{guild_attrs = GuildAttr1}.

%% 执行洗点操作
do_wash(PS) ->
    ?DEBUG_MSG("Begin",PS),

    Point = calculate_return_back_goods_count(PS),
    NeedGameMoney = calculate_wash_cons(Point),

    ?DEBUG_MSG("Point = ~p, NeedGameMoney = ~p",[Point,NeedGameMoney]),

    %%需要返还的道具数量
    ReturnBackGoodsCount = util:floor(Point / ?GUILD_CULTIVATE_ADD_USE_GOODS),
    ?DEBUG_MSG("PS = ~p",[PS]),
    %扣钱
    PS1 = player_syn:cost_money(PS, ?MNY_T_GAMEMONEY, NeedGameMoney, [?LOG_GUILD, "wash"]),
    %点修重置
    PS2 = PS1#player_status{guild_attrs = []},

    %添加道具
    case mod_inv:batch_smart_add_new_goods(player:id(PS2), [{?GUILD_CULTIVATE_GOODS_NO, ReturnBackGoodsCount}], [{bind_state, ?BIND_ON_GET}], [?LOG_GUILD, "wash"]) of
        {fail, Reason} ->
            ?ERROR_MSG("Add Goods Error,PlayerId:~p,Reason:~p~n", [player:id(PS2), Reason]);
        {ok, _GoodsList} ->  void
    end,

    player_syn:update_PS_to_ets(PS2),
    ?DEBUG_MSG("PS2 = ~p",[PS2]),
    player:db_save_guild_attrs(PS2),
    ply_attr:recount_base_and_total_attrs(PS2),    
void.

%% 检测能否进行洗点
check_wash(PS) ->
    %%判断格子是否足够
    try check_wash_cons__(PS) of
            ok -> ok
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

%% 获取需要消耗的银子
get_wash_need_gamemoney(PS) ->
    Point = calculate_return_back_goods_count(PS),
    NeedGameMoney = calculate_wash_cons(Point),

    NeedGameMoney.

%% 检测是否足够消耗
check_wash_cons__(PS) ->
    Point = calculate_return_back_goods_count(PS),
    NeedGameMoney = calculate_wash_cons(Point),
    %%需要返还的道具数量
    ReturnBackGoodsCount = util:ceil(Point / ?GUILD_CULTIVATE_ADD_USE_GOODS),

    CanAddGoods = case mod_inv:check_batch_add_goods(player:id(PS), [{?GUILD_CULTIVATE_GOODS_NO, ReturnBackGoodsCount}]) of        
            {fail, FailReason} -> FailReason;
            ok -> ok
    end,

    ?Ifc (CanAddGoods =/= ok)
        throw(CanAddGoods)
    ?End,

    GuildId = player:get_guild_id(PS),
    ?Ifc (GuildId =:= ?INVALID_ID)
        throw(?PM_NOT_IN_GUILD)
    ?End,

    Guild = mod_guild:get_info(GuildId),
    ?Ifc (Guild =:= null)
        throw(?PM_GUILD_NOT_EXISTS)
    ?End,

    ?Ifc (not player:has_enough_gamemoney(PS, NeedGameMoney))
        throw(?PM_GAMEMONEY_LIMIT)
    ?End,

    ok.


%%计算洗点消耗
calculate_wash_cons(Point) ->
    Point * 15.

%% 计算需要返还的点修点数
calculate_return_back_goods_count(PS) ->
    GuildAttr = player:get_guild_attrs(PS),
    calculate_return_back_goods_count_(GuildAttr,0).


calculate_return_back_goods_count_([],Point) -> 
    Point;

%%计算返还神功丸
calculate_return_back_goods_count_([H | T],Point) ->
    {_, Lv, Value} = H,
    NewPoint = Point + calculate_point_by_lv(Lv - 1,Value),
    calculate_return_back_goods_count_(T,NewPoint).

%%计算N级需要多少的点修值
calculate_point_by_lv(Lv,Point) when is_integer(Lv) ->
    LastLv = Lv - 1,

    NewPoint = Point + case data_guild_cultivate:get(Lv) of
        null -> 0;
        DataCultivate -> DataCultivate#guild_cultivate_cfg.need_point_next_lv
    end,

    if
        LastLv >= 0 ->
            calculate_point_by_lv(LastLv,NewPoint);
        true ->
           NewPoint 
    end.



change_cultivate_lv_by_cultivate(Lv, Cultivate) ->
    CultivateLim = 
        case data_guild_cultivate:get(Lv) of
            null -> ?MAX_U32;
            DataCultivate -> DataCultivate#guild_cultivate_cfg.need_point_next_lv
        end,
    case Cultivate < CultivateLim of
        true ->
            {Lv, Cultivate};
        _ ->
            change_cultivate_lv_by_cultivate(Lv + 1, Cultivate - CultivateLim)
    end.

check_use_goods_for_cultivate__(PS, ObjInfoCode, GoodsNo, Count) ->
    ?Ifc (Count =< 0)
        throw(?PM_PARA_ERROR)
    ?End,

    GuildId = player:get_guild_id(PS),
    ?Ifc (GuildId =:= ?INVALID_ID)
        throw(?PM_NOT_IN_GUILD)
    ?End,

    Guild = mod_guild:get_info(GuildId),
    ?Ifc (Guild =:= null)
        throw(?PM_GUILD_NOT_EXISTS)
    ?End,

    Lv = mod_guild:get_lv(Guild),

    Data = data_guild_lv:get(Lv),
    ?Ifc (Data =:= null)
        throw(?PM_DATA_CONFIG_ERROR)
    ?End,

    AttrName = lib_attribute:obj_info_code_to_attr_name(ObjInfoCode),
    ?Ifc (AttrName =:= null)
        throw(?PM_PARA_ERROR)
    ?End,

    ?Ifc (not lists:member(AttrName, Data#guild_lv_data.repair_attrs))
        throw(?PM_GUILD_ATTR_NOT_OPENED_YET)
    ?End,

    GuildAttr = player:get_guild_attrs(PS),
    CultivateLv = 
        case lists:keyfind(AttrName, 1, GuildAttr) of
            false -> 0;
            {_, CLv, _Value} -> CLv
        end,

    ?Ifc (CultivateLv >= Data#guild_lv_data.point_repair_max)
        throw(?PM_GUILD_CULTIVATE_LV_LIMIT)
    ?End,

    ?Ifc (mod_inv:get_goods_count_in_bag_by_no(player:get_id(PS), GoodsNo) < Count)
        throw(?PM_PAR_ALCHEMY_LIMIT)
    ?End,
    ok.


do_use_goods_for_cultivate(PS, ObjInfoCode, GoodsNo, Count) ->
    AttrName = lib_attribute:obj_info_code_to_attr_name(ObjInfoCode),
    mod_inv:destroy_goods_WNC(player:get_id(PS), [{GoodsNo, Count}], [?LOG_GUILD, "cultivate"]),

    PS2 = add_cultivate(PS, AttrName, ?GUILD_CULTIVATE_ADD_USE_GOODS * Count),
    {ok, PS2}.


check_cultivate(PS, ObjInfoCode, Type, AccMoney, AccContri) ->
    try check_cultivate__(PS, ObjInfoCode, Type, AccMoney, AccContri) of
        ok -> ok
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.


check_cultivate__(PS, ObjInfoCode, Type, AccMoney, AccContri) ->
    ?Ifc (not lists:member(Type, [1, 2]))
        throw(?PM_PARA_ERROR)
    ?End,

    GuildId = player:get_guild_id(PS),
    ?Ifc (GuildId =:= ?INVALID_ID)
        throw(?PM_NOT_IN_GUILD)
    ?End,

    Guild = mod_guild:get_info(GuildId),
    ?Ifc (Guild =:= null)
        throw(?PM_GUILD_NOT_EXISTS)
    ?End,

    Lv = mod_guild:get_lv(Guild),

    Data = data_guild_lv:get(Lv),
    ?Ifc (Data =:= null)
        throw(?PM_DATA_CONFIG_ERROR)
    ?End,

    AttrName = lib_attribute:obj_info_code_to_attr_name(ObjInfoCode),
    ?Ifc (AttrName =:= null)
        throw(?PM_PARA_ERROR)
    ?End,

    ?Ifc (not lists:member(AttrName, Data#guild_lv_data.repair_attrs))
        throw(?PM_GUILD_ATTR_NOT_OPENED_YET)
    ?End,

    GuildAttr = player:get_guild_attrs(PS),
    CultivateLv = 
        case lists:keyfind(AttrName, 1, GuildAttr) of
            false -> 0;
            {_, CLv, _Value} -> CLv
        end,

    ?Ifc (CultivateLv >= Data#guild_lv_data.point_repair_max)
        throw(?PM_GUILD_CULTIVATE_LV_LIMIT)
    ?End,

    DataCultivate = data_guild_cultivate:get(CultivateLv),
    ?Ifc (DataCultivate =:= null)
        throw(?PM_DATA_CONFIG_ERROR)
    ?End,

    case Type =:= 1 of
        true ->
            ?Ifc (not player:has_enough_gamemoney(PS, DataCultivate#guild_cultivate_cfg.need_gamemoney + AccMoney))
                throw(?PM_GAMEMONEY_LIMIT)
            ?End,
            ?Ifc (get_left_contri(player:id(PS)) < DataCultivate#guild_cultivate_cfg.need_contri + AccContri)
                throw(?PM_GUILD_CONTRI_LIMIT)
            ?End;
        false ->
            ?Ifc (player:get_exp(PS) < DataCultivate#guild_cultivate_cfg.need_exp + AccMoney)
                throw(?PM_EXP_LIMIT) 
            ?End,
            ?Ifc (get_left_contri(player:id(PS)) < DataCultivate#guild_cultivate_cfg.need_contri_2 + AccContri)
                throw(?PM_GUILD_CONTRI_LIMIT)
            ?End
    end,
    ok.


check_add_guild_dishes(PS, DishesNo) ->
    try check_add_guild_dishes__(PS, DishesNo) of
        {ok, Guild} -> {ok, Guild}
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.


check_add_guild_dishes__(PS, DishesNo) ->
    Data = data_guild_dishes:get(DishesNo),
    ?Ifc (Data =:= null)
        throw(?PM_PARA_ERROR)
    ?End,

    ?Ifc (player:get_vip_lv(PS) < Data#guild_dishes.vip_lv)
        throw(?PM_VIP_LV_LIMIT)
    ?End,

    ?Ifc (not player:has_enough_yuanbao(PS, Data#guild_dishes.need_yuanbao))
        throw(?PM_YB_LIMIT)
    ?End,

    GuildParty = lib_guild:get_party_from_ets(player:get_guild_id(PS)),
    ?Ifc (GuildParty =:= null)
        throw(?PM_GUILD_PARTY_NOT_OPENED)
    ?End,

    ?Ifc (GuildParty#guild_party.start_time =:= 0)
        throw(?PM_GUILD_PARTY_NOT_OPENED)
    ?End,        

    ?Ifc (lists:member(DishesNo, GuildParty#guild_party.dishes_no))
        throw(?PM_GUILD_PARTY_HAVE_THE_DISHES)
    ?End,

    Guild = mod_guild:get_info(player:get_guild_id(PS)),
    ?Ifc (Guild =:= null)
        throw(?PM_NOT_IN_GUILD)
    ?End,
    {ok, Guild}.


do_add_guild_dishes(PS, DishesNo, Guild) ->
    Data = data_guild_dishes:get(DishesNo),
    player:cost_yuanbao(PS, Data#guild_dishes.need_yuanbao, [?LOG_GUILD, "party"]),
    case Guild#guild.scene_id =:= ?INVALID_ID of
        true -> 
            ?ASSERT(false),
            skip;
        false ->
            case data_guild_dishes:get(DishesNo) of
                null -> skip;
                DishesCfg ->
                    ?ASSERT(is_tuple(DishesCfg#guild_dishes.npc), DishesCfg#guild_dishes.npc),

                    % 给予奖励包
                    case DishesCfg#guild_dishes.reward_id of
                        0 -> skip;
                        RewardId ->
                            case lib_reward:check_bag_space(PS, RewardId) of
                                ok -> 
                                    lib_reward:give_reward_to_player(PS, RewardId, [?LOG_GUILD, "party"]),
                                    true;
                                {fail, Reason} -> 
                                    lib_send:send_prompt_msg(PS, Reason),
                                    false
                            end
                    end,

                    case mod_scene:spawn_dynamic_npc_to_scene_WNC(element(1, DishesCfg#guild_dishes.npc), Guild#guild.scene_id, 
                        element(2, DishesCfg#guild_dishes.npc), element(3, DishesCfg#guild_dishes.npc)) of
                        fail -> 
                            ?ERROR_MSG("ply_guild:do_add_guild_dishes error!~n", []);
                        {ok, NewDynamicNpcId} ->
                            case lib_guild:get_party_from_ets(Guild#guild.id) of
                                null ->
                                    ?ASSERT(false),
                                    skip;
                                GuildParty ->
                                    % 判断是否需要公告
                                    case DishesCfg#guild_dishes.broadcast_id of
                                        0 -> skip;
                                        BId when is_integer(BId) ->
                                            mod_broadcast:send_sys_broadcast(BId, [player:get_name(PS), player:id(PS), Guild#guild.name])
                                    end,

                                    lib_log:statis_guild_party(player:id(PS), player:get_lv(PS), Guild#guild.id, Guild#guild.lv, DishesNo),
                                    DelayTime = lib_guild:get_party_last_time() - (svr_clock:get_unixtime() - GuildParty#guild_party.start_time),
                                    mod_guild_party:player_add_guild_buff(Guild#guild.id, Guild#guild.scene_id, DishesCfg#guild_dishes.buff_no, DelayTime, NewDynamicNpcId, DishesNo)
                            end                                    
                    end
            end
    end,
    ok.


check_apply_join_guild(PS, GuildId) ->
    try check_apply_join_guild__(PS, GuildId) of
        {ok, Guild, Type} ->
            {ok, Guild, Type}
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.


check_apply_join_guild__(PS, GuildId) ->
    LeaveGuildTime = player:get_leave_guild_time(PS),
    ?Ifc ( (LeaveGuildTime + data_special_config:get('quit_guild_join_cd')) > svr_clock:get_unixtime() )
        throw(?PM_GUILD_MB_JOIN_CD)
    ?End,
    % 玩家已有帮会
    ?Ifc (player:is_in_guild(PS))
        throw(?PM_HAVE_IN_GUILD)
    ?End,

    Guild = mod_guild:get_info(GuildId),
    ?Ifc (Guild =:= null)
        throw(?PM_GUILD_NOT_EXISTS)
    ?End,

    Type = Guild#guild.join_control,
    ?Ifc (Type =:= 3)
        throw(?PM_GUILD_PROHIBIT_MB_JOIN)
    ?End,

    ?Ifc (lists:keyfind(player:get_id(PS), #join_guild_req.id, Guild#guild.request_joining_list) /= false)
        throw(?PM_HAVE_APPLIED_THE_GUILD)
    ?End,

    % 该帮会人数已满
    GuildLv = mod_guild:get_lv(Guild),
    ?Ifc (mod_guild:get_guild_member_count(Guild) >= mod_guild:get_capacity_by_guild_lv(GuildLv))
        throw(?PM_GUILD_MEMBER_COUNT_LIMIT)
    ?End,

    % 申请数量已达上限
    ?Ifc (mod_guild:get_guild_apply_count(Guild) >= ?GUILD_APPLY_CAPACITY)
        throw(?PM_GUILD_APPLY_COUNT_LIMIT)
    ?End,
    {ok, Guild, Type}.


do_apply_join_guild(PS, Guild) ->
    ?ASSERT(Guild /= null),
    ApplyData = #join_guild_req{
            id = player:get_id(PS),
            name = player:get_name(PS),
            lv = player:get_lv(PS),
            vip_lv = player:get_vip_lv(PS),
            sex = player:get_sex(PS),
            race = player:get_race(PS),
            faction = player:get_faction(PS),
            battle_power = ply_attr:get_battle_power(PS),
            time = svr_clock:get_unixtime()
            },

    ReqJoinList = Guild#guild.request_joining_list ++ [ApplyData],
    NewGuild = Guild#guild{request_joining_list = ReqJoinList},
    mod_guild:update_guild_to_ets(NewGuild),
    mod_achievement:notify_achi(apply_join_guild, [], PS),
    notify_player_apply_join([NewGuild#guild.chief_id | NewGuild#guild.counsellor_id_list] ++ NewGuild#guild.shaozhang_id_list),
    ok.

try_apply_join_guild(PS, [H | T]) ->
    case apply_join_guild(PS, H) of
        {fail, _Reason} ->
            try_apply_join_guild(PS, T);
        ok ->
            try_apply_join_guild(PS, T);
        {ok, _} ->
            ok
    end;
try_apply_join_guild(_PS, []) ->
    ok.

check_invite_join(PS, ObjPlayerId) ->
    try check_invite_join__(PS, ObjPlayerId) of
        {ok, Guild} ->
            {ok, Guild}
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

check_invite_join__(PS, ObjPlayerId) ->
    ?Ifc (not player:is_online(ObjPlayerId))
        throw(?PM_TARGET_PLAYER_NOT_ONLINE)
    ?End,

    ?Ifc (player:is_in_guild(ObjPlayerId))
        throw(?PM_HAVE_IN_GUILD)
    ?End,

    GuildId = player:get_guild_id(PS),
    Guild = mod_guild:get_info(GuildId),
    ?Ifc (Guild =:= null)
        throw(?PM_GUILD_NOT_EXISTS)
    ?End,

    CounsellorList = mod_guild:get_counsellor_id_list(Guild),
    ShaoZhangList = mod_guild:get_shaozhang_id_list(Guild),

    ?Ifc ( (not mod_guild:is_chief(PS)) andalso (not lists:member(player:get_id(PS), CounsellorList)) andalso (not lists:member(player:get_id(PS), ShaoZhangList)) )
        throw(?PM_GUILD_POWER_LIMIT)
    ?End,

    % 该帮会人数已满
    ?Ifc (mod_guild:get_guild_member_count(Guild) >= mod_guild:get_capacity_by_guild_lv(mod_guild:get_lv(Guild)))
        throw(?PM_GUILD_MEMBER_COUNT_LIMIT)
    ?End,

    TPS = player:get_PS(ObjPlayerId),
    ?Ifc (TPS =:= null orelse player:is_offline_guaji(TPS))
        throw(?PM_PLAYER_STATE_OFFLINE_GUAJI)
    ?End,
    {ok, Guild}.


do_invite_join(PS, ObjPlayerId, Guild) ->
    {ok, BinData} = pt_40:write(?PT_GOT_INVITE, [player:get_id(PS), player:get_name(PS), Guild]),
    lib_send:send_to_sock(player:get_PS(ObjPlayerId), BinData),
    ok.


%% 是否已经加载过指定帮派的信息了？（true | false）
% already_load_guild_info(GuildId) ->
%      mod_guild:get_info(GuildId) /= null.


%% 是否已经加载过指定帮派成员的信息了？（true | false）
already_load_guild_member_info(PlayerId) ->
    mod_guild:get_member_info(PlayerId) /= null.


%% 检查帮会宗旨是否合法
%% @return: true | {false, Reason}
% is_tenet_valid(Tenet) ->
%     ?ASSERT(is_list(Tenet)),
%     case asn1rt:utf8_binary_to_list(list_to_binary(Tenet)) of
%         {ok, CharList} ->
%             Len = string_width(CharList),
%             case Len < ?GUILD_TENET_MAX_LEN + 1 of
%                 true ->
%                     true;
%                 false ->
%                     {false, len_error}
%             end;
%         {error, _Reason} ->
%             % 非法字符
%             {false, char_illegal}
%     end.


%% 获取成员的贡献度
get_contri(PlayerId) ->
    MbInfo = mod_guild:get_member_info(PlayerId),
    % ?ASSERT(MbInfo /= null, {PlayerId, MbInfo}),
    case MbInfo =:= null of %% 容错，避免多进程并发导致报错问题
        true -> 0;
        false -> MbInfo#guild_mb.contri
    end.


%% 获取成员的贡献度
get_left_contri(PlayerId) ->
    case mod_guild:get_member_info(PlayerId) of
        null -> 0;
        MbInfo -> MbInfo#guild_mb.left_contri
    end.


%% 获取帮派名字
%% @return: binary类型的帮派名，如果没有加入帮派，则返回空binary
get_guild_name(PlayerId) when is_integer(PlayerId) ->
    case player:get_PS(PlayerId) of
        null -> <<"">>;
        PS -> get_guild_name(PS)
    end;
    
get_guild_name(PS) ->
    case player:is_in_guild(PS) of
        false ->
            <<"">>;
        true ->
            GuildId = player:get_guild_id(PS),
            case try_fast_get_guild_name(GuildId) of  % 处理AOI时会获取玩家的帮派名，故这里尝试快速获取！
                {ok, GuildName} ->
                    ?ASSERT(is_binary(GuildName), GuildName),
                    GuildName;
                fail ->
                    case mod_guild:get_info(GuildId) of
                        null ->
                            ?ASSERT(false, {player:id(PS), player:get_guild_id(PS)}),
                            <<"">>;
                        Guild ->
                            cache_map_of_guild_id_to_guild_name(GuildId, Guild#guild.name),
                            Guild#guild.name
                    end
            end
    end.

get_guild_chief_id(PS) ->
    case player:get_guild_id(PS) of
        ?INVALID_ID ->
            ?INVALID_ID;
        GuildId ->
            case mod_guild:get_info(GuildId) of
                null ->
                    ?INVALID_ID;
                Guild ->
                    Guild#guild.chief_id
            end
    end.


%% 缓存帮派id到帮派名的映射，以便于以后可以快速依据帮派id获取帮派名
cache_map_of_guild_id_to_guild_name(GuildId, GuildName) ->
    ?ASSERT(is_binary(GuildName), GuildName),
    ets:insert(?ETS_MAP_OF_GUILD_ID_TO_GUILD_NAME, {GuildId, GuildName}).


%% 尝试快速获取帮派名（依据帮派名）
%% @return: fail | {ok, 帮派名}
try_fast_get_guild_name(GuildId) ->
    case ets:lookup(?ETS_MAP_OF_GUILD_ID_TO_GUILD_NAME, GuildId) of
        [] ->
            fail;
        [{GuildId, GuildName}] ->
            {ok, GuildName}
    end.




get_player_cur_contri(PS) ->
    case player:is_in_guild(PS) of
        false -> 0;
        true ->
            case mod_guild:get_member_info(player:id(PS)) of
                null -> ?ASSERT(false, player:id(PS)), 0;
                GuildMb -> GuildMb#guild_mb.left_contri
            end
    end.


try_teleport_to_guild_scene(PS, SceneNo, {X, Y}) ->
    case player:get_guild_id(PS) of
        ?INVALID_ID ->
            {fail, ?PM_NOT_IN_GUILD};
        GuildId ->
            % 是否已经在帮派场景中了？
            case player:is_in_guild_scene(PS) of
                true ->
                    {fail, ?PM_ALRDY_IN_GUILD_SCENE};
                false ->
                    case player:is_in_team(PS) of
                        true ->
                            TeamId = player:get_team_id(PS),
                            List = mod_team:get_all_member_id_list(TeamId),

                            F = fun(PlayerId,Acc) ->
                                    case player:get_PS(PlayerId) of 
                                        TPS when is_record(TPS,player_status) ->
                                            player:get_guild_id(TPS) == player:get_guild_id(PS) andalso Acc;
                                        _ ->
											Acc
%% 											false
                                    end
                            end,

                            AllMember = lists:foldl(F,true,List),

                            case AllMember of
                                true ->
                                    case mod_guild:get_guild_scene_id(GuildId) of
                                        ?INVALID_ID ->
                                            case mod_guild:get_info(GuildId) of % 容错，避免多进程同步引发问题
                                                null -> {fail, ?PM_NOT_IN_GUILD};
                                                Guild ->
                                                    case mod_guild:create_guild_scene(SceneNo, Guild#guild.lv, Guild#guild.id) of
                                                        fail ->
                                                            {fail, ?PM_MK_FAIL_SERVER_BUSY};
                                                        {ok, NewSceneId} ->
                                                            ply_scene:do_teleport(PS, NewSceneId, X, Y),
                                                            ok
                                                    end
                                            end;
                                        SceneId ->
                                            ply_scene:do_teleport(PS, SceneId, X, Y),
                                            ok
                                    end;
                                false ->
                                    {fail, ?PM_CANT_ENTER_GUILD_SCENE_WHEN_IN_TEAM}
                            end;
                        false ->
                            case mod_guild:get_guild_scene_id(GuildId) of
                                ?INVALID_ID ->
                                    case mod_guild:get_info(GuildId) of % 容错，避免多进程同步引发问题
                                        null -> {fail, ?PM_NOT_IN_GUILD};
                                        Guild ->
                                            case mod_guild:create_guild_scene(SceneNo, Guild#guild.lv, Guild#guild.id) of
                                                fail ->
                                                    {fail, ?PM_MK_FAIL_SERVER_BUSY};
                                                {ok, NewSceneId} ->
                                                    ply_scene:do_teleport(PS, NewSceneId, X, Y),
                                                    ok
                                            end
                                    end;
                                SceneId ->
                                    ply_scene:do_teleport(PS, SceneId, X, Y),
                                    ok
                            end
                    end
            end
    end.


get_guild_pay(PS, Type) ->
    case check_get_guild_pay(PS, Type) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, GuildMb} ->
            do_get_guild_pay(PS, Type, GuildMb)
    end.


try_change_guild_buff(PS) ->
    % ?INFO_MSG("ply_guild:try_change_guild_buff() begin~n", []),
    case player:get_guild_id(PS) of
        ?INVALID_ID -> skip;
        GuildId ->
            case lib_guild:get_party_from_ets(GuildId) of
                null -> skip;
                GuildParty ->
                    case GuildParty#guild_party.start_time =:= 0 of
                        true -> skip;
                        false ->
                            F = fun(No, Acc) ->
                                case data_guild_dishes:get(No) of
                                    null -> Acc;
                                    DataDishes -> [DataDishes#guild_dishes.buff_no | Acc]
                                end
                            end,
                            BuffNoList = lists:foldl(F, [], GuildParty#guild_party.dishes_no),
                            % ?INFO_MSG("ply_guild:try_change_guild_buff() in guild scene ?~n", []),
                            case player:is_in_guild_scene(PS) of
                                true ->
                                    DelayTime = lib_guild:get_party_last_time() - (svr_clock:get_unixtime() - GuildParty#guild_party.start_time),
                                    % ?INFO_MSG("ply_guild:try_change_guild_buff() add buff,DelayTime=~p~n", [DelayTime]),
                                    F1 = fun(BuffNo) ->
                                        case mod_buff:has_buff(player, player:id(PS), BuffNo) of
                                            true -> skip;
                                            false -> 
                                                lib_buff:player_add_buff(player:id(PS), BuffNo, DelayTime)
                                        end
                                    end,
                                    [F1(BuffNo) || BuffNo <- BuffNoList];
                                false ->
                                    % ?INFO_MSG("ply_guild:try_change_guild_buff() del buff~n", []),
                                    [lib_buff:player_del_buff(player:id(PS), BuffNo) || BuffNo <- BuffNoList]
                            end
                    end
            end
    end.


check_get_guild_pay(PS, Type) ->
    try check_get_guild_pay__(PS, Type) of
        {ok, GuildMb} ->
            {ok, GuildMb}
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.


check_get_guild_pay__(PS, Type) ->
    ?Ifc (not util:in_range(Type, 1, 4))
        throw(?PM_PARA_ERROR)
    ?End,

    GuildMb = mod_guild:get_member_info(player:id(PS)),
    ?Ifc (GuildMb =:= null)
        throw(?PM_NOT_IN_GUILD)
    ?End,

    ?Ifc (GuildMb#guild_mb.pay_today =:= [])
        throw(?PM_NO_GUILD_PAY_CAN_GET)
    ?End,

    case Type of
        1 ->
            case element(2, lists:nth(1, GuildMb#guild_mb.pay_today)) of
                1 -> throw(?PM_HAVE_GOT_THE_PAY);
                0 ->
                    case element(1, lists:nth(1, GuildMb#guild_mb.pay_today)) =< 0 of
                        true -> throw(?PM_NO_GUILD_PAY_CAN_GET);
                        false -> {ok, GuildMb}
                    end;
                _Any -> ?ASSERT(false, GuildMb#guild_mb.pay_today)
            end;
        2 ->
            case element(2, lists:nth(2, GuildMb#guild_mb.pay_today)) of
                1 -> throw(?PM_HAVE_GOT_THE_PAY);
                0 ->
                    case element(1, lists:nth(2, GuildMb#guild_mb.pay_today)) =< 0 of
                        true -> throw(?PM_NO_GUILD_PAY_CAN_GET);
                        false -> {ok, GuildMb}
                    end;
                _Any -> ?ASSERT(false, GuildMb#guild_mb.pay_today)
            end;
        3 ->
            case element(2, lists:nth(3, GuildMb#guild_mb.pay_today)) of
                1 -> throw(?PM_HAVE_GOT_THE_PAY);
                0 ->
                    case element(1, lists:nth(3, GuildMb#guild_mb.pay_today)) =< 0 of
                        true -> throw(?PM_NO_GUILD_PAY_CAN_GET);
                        false -> {ok, GuildMb}
                    end;
                _Any -> ?ASSERT(false, GuildMb#guild_mb.pay_today)
            end;
        4 ->
            case element(2, lists:nth(4, GuildMb#guild_mb.pay_today)) of
                1 -> throw(?PM_HAVE_GOT_THE_PAY);
                0 ->
                    case element(1, lists:nth(4, GuildMb#guild_mb.pay_today)) =< 0 of
                        true -> throw(?PM_NO_GUILD_PAY_CAN_GET);
                        false -> {ok, GuildMb}
                    end;
                _Any -> ?ASSERT(false, GuildMb#guild_mb.pay_today)
            end
    end.


do_get_guild_pay(PS, Type, GuildMb) ->
    NewPay =
        case Type of
            1 ->
                [{element(1, lists:nth(1, GuildMb#guild_mb.pay_today)), 1},
                 {element(1, lists:nth(2, GuildMb#guild_mb.pay_today)), element(2, lists:nth(2, GuildMb#guild_mb.pay_today))},
                 {element(1, lists:nth(3, GuildMb#guild_mb.pay_today)), element(2, lists:nth(3, GuildMb#guild_mb.pay_today))},
                 {element(1, lists:nth(4, GuildMb#guild_mb.pay_today)), element(2, lists:nth(4, GuildMb#guild_mb.pay_today))}
                ];
            2 ->
                [{element(1, lists:nth(1, GuildMb#guild_mb.pay_today)), element(2, lists:nth(1, GuildMb#guild_mb.pay_today))},
                 {element(1, lists:nth(2, GuildMb#guild_mb.pay_today)), 1},
                 {element(1, lists:nth(3, GuildMb#guild_mb.pay_today)), element(2, lists:nth(3, GuildMb#guild_mb.pay_today))},
                 {element(1, lists:nth(4, GuildMb#guild_mb.pay_today)), element(2, lists:nth(4, GuildMb#guild_mb.pay_today))}
                ];
            3 ->
                [{element(1, lists:nth(1, GuildMb#guild_mb.pay_today)), element(2, lists:nth(1, GuildMb#guild_mb.pay_today))},
                 {element(1, lists:nth(2, GuildMb#guild_mb.pay_today)), element(2, lists:nth(2, GuildMb#guild_mb.pay_today))},
                 {element(1, lists:nth(3, GuildMb#guild_mb.pay_today)), 1},
                 {element(1, lists:nth(4, GuildMb#guild_mb.pay_today)), element(2, lists:nth(4, GuildMb#guild_mb.pay_today))}
                ];
            4 ->
                [{element(1, lists:nth(1, GuildMb#guild_mb.pay_today)), element(2, lists:nth(1, GuildMb#guild_mb.pay_today))},
                 {element(1, lists:nth(2, GuildMb#guild_mb.pay_today)), element(2, lists:nth(2, GuildMb#guild_mb.pay_today))},
                 {element(1, lists:nth(3, GuildMb#guild_mb.pay_today)), element(2, lists:nth(3, GuildMb#guild_mb.pay_today))},
                 {element(1, lists:nth(4, GuildMb#guild_mb.pay_today)), 1}
                ]
        end,
    NewGuildMb = GuildMb#guild_mb{pay_today = NewPay},
    mod_guild:update_member_to_ets(player:id(PS), NewGuildMb),
    mod_guild:db_save_member(NewGuildMb),
    GetPay =
        case Type of
            1 -> element(1, lists:nth(1, GuildMb#guild_mb.pay_today));
            2 -> element(1, lists:nth(2, GuildMb#guild_mb.pay_today));
            3 -> element(1, lists:nth(3, GuildMb#guild_mb.pay_today));
            4 -> element(1, lists:nth(4, GuildMb#guild_mb.pay_today))
        end,
    ?ASSERT(GetPay > 0, GetPay),
    player:add_bind_gamemoney(PS, GetPay, [?LOG_GUILD, "pay"]),
    ok.


may_change_donate_rank(Guild, GuildMb) ->
    F = fun(M1, M2) -> element(2, M1) > element(2, M2) end,
    DonateRank = Guild#guild.donate_rank,
    case length(DonateRank) < 10 of
        true -> 
            DonateRank1 = 
                case lists:keyfind(GuildMb#guild_mb.name, 1, DonateRank) of
                    false -> [{GuildMb#guild_mb.name, GuildMb#guild_mb.donate_total} | DonateRank];
                    {_Name, _Donate} -> lists:keyreplace(GuildMb#guild_mb.name, 1, DonateRank, {GuildMb#guild_mb.name, GuildMb#guild_mb.donate_total})
                end,
            NewDonateRank = lists:sort(F, DonateRank1),
            Guild1 = Guild#guild{donate_rank = NewDonateRank},
            mod_guild:update_guild_to_ets(Guild1);
        false ->
            {Name, Donate} = lists:last(DonateRank),
            case GuildMb#guild_mb.donate_total > Donate of
                true -> 
                    DonateRank2 = 
                        case lists:keyfind(GuildMb#guild_mb.name, 1, DonateRank) of
                            false ->
                                DonateRank1 = DonateRank -- [{Name, Donate}],
                                DonateRank1 ++ [{GuildMb#guild_mb.name, GuildMb#guild_mb.donate_total}];
                            {_Name, _Donate} ->
                                lists:keyreplace(GuildMb#guild_mb.name, 1, DonateRank, {GuildMb#guild_mb.name, GuildMb#guild_mb.donate_total})
                        end,
                    NewDonateRank = lists:sort(F, DonateRank2),
                    Guild1 = Guild#guild{donate_rank = NewDonateRank},
                    mod_guild:update_guild_to_ets(Guild1);
                false ->
                    skip
            end
    end.


notify_player_apply_join(List) ->
    {ok, BinData} = pt_40:write(?PT_GUILD_NOTIFY_PLAYER_APPLY, []),
    F = fun(X) ->
        case is_integer(X) of
            true ->
                case player:get_PS(X) of
                    null -> skip;
                    PS -> lib_send:send_to_sock(PS, BinData)
                end;
            false ->
                lib_send:send_to_sock(X, BinData)
        end
    end,
    [F(X) || X <- List].

modify_control(PS, GuildId, Type) ->
    case check_modify_control(PS, GuildId, Type) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, Guild} ->
            do_modify_control(PS, Guild, Type)
    end.

check_modify_control(PS, GuildId, Type) ->
    try check_modify_control__(PS, GuildId, Type) of
        {ok, Guild} ->
            {ok, Guild}
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

check_modify_control__(PS, GuildId, Type) ->
    ?Ifc (not lists:member(Type, [1, 2, 3]))
        throw(?PM_PARA_ERROR)
    ?End,

    % 玩家没有帮会
    ?Ifc (not player:is_in_guild(PS))
        throw(?PM_NOT_IN_GUILD)
    ?End,

    PlayerGuildId = player:get_guild_id(PS),

    ?Ifc (PlayerGuildId =/= GuildId)
        throw(?PM_PARA_ERROR)
    ?End,

    Guild = mod_guild:get_info(GuildId),
    ?Ifc (Guild =:= null)
        throw(?PM_GUILD_NOT_EXISTS)
    ?End,

    CounsellorList = mod_guild:get_counsellor_id_list(Guild),

    ?Ifc ( (not mod_guild:is_chief(PS)) andalso (not lists:member(player:get_id(PS), CounsellorList)) )
        throw(?PM_GUILD_POWER_LIMIT)
    ?End,

    {ok, Guild}.

do_modify_control(PS, Guild, Type) ->
    ?ASSERT(Guild /= null),
    NewGuild = Guild#guild{join_control = Type},

    mod_guild:update_guild_to_ets(NewGuild),

    InfoList = ply_guild:get_general_info(Guild#guild.id),
    {ok, BinData} = pt_40:write(?PT_BASE_GUILD_INFO, InfoList),
    lib_send:send_to_sock(PS, BinData),

    ok.


test() ->
    PlayerId = 1000100000000477,
    PS = player:get_PS(PlayerId),
    io:format("djkldsnadkklj ==== ~p~n",[PS]),
    io:format("Linux === ~p~n",[PlayerId]),
    io:format("dsfdsfs==~p~n",[PS#player_status.guild_id]),
    refresh_guild_shop(),
    skip.

guild_shop(PS, GuildId) ->
    case mod_guild:get_info(GuildId) of
        null ->
            {fail, ?PM_GUILD_NOT_EXISTS};
        _Guild ->
            case GuildId =:= PS#player_status.guild_id of
                false ->
                    {fail, ?PM_GUILD_POWER_LIMIT};
                true ->
                    case mod_guild:get_info(PS#player_status.guild_id) of
                        null ->
                            {fail, ?PM_NOT_IN_GUILD};
                        Guild ->
                            ?DEBUG_MSG("Guild === ~p~n",[Guild#guild.guild_shop]),
                            {ok, Guild#guild.guild_shop}
                    end
            end
    end.

purchase_guild_shop(PS, GuildId, ShopId, Count) ->
    case mod_guild:get_info(GuildId) of
        null ->
            {fail, ?PM_GUILD_NOT_EXISTS};
        _Guild ->
            case GuildId =:= PS#player_status.guild_id of
                false ->
                    {fail, ?PM_GUILD_POWER_LIMIT};
                true ->
                    case mod_guild:get_info(PS#player_status.guild_id) of
                        null ->
                            {fail, ?PM_NOT_IN_GUILD};
                        Guild ->
                            LeaveGuildTime = PS#player_status.leave_guild_time,
                            MemberInfo = mod_guild:get_member_info(player:get_id(PS)),
                            JoinGuildTime = MemberInfo#guild_mb.join_time,
                            case (LeaveGuildTime =:= 0) orelse (JoinGuildTime + data_special_config:get('guild_shop_buy_join_time_limit')) > util:unixtime() of
                                false ->
                                    {fail, ?PM_GUILD_SHOP_PURVHARE_CD};
                                true ->
                                    GuildShop = Guild#guild.guild_shop,
                                    case lists:keyfind(ShopId, 1, GuildShop) of
                                        {_Id, _No, NumLimit} ->
                                            case NumLimit >= Count of
                                                true ->
                                                    ShopInfo = data_guild_shop:get(ShopId),
                                                    [{MoneyType, CostNum}] = ShopInfo#data_guild_shop.price,
                                                    case player:has_enough_money(PS, MoneyType, CostNum*Count) of
                                                        true ->
                                                            case mod_inv:check_batch_add_goods(player:get_id(PS), [{ShopInfo#data_guild_shop.goods_no, Count}]) of
                                                                {fail, _Reason} ->
                                                                    {fail, ?PM_US_BAG_FULL} ;
                                                                _ ->
                                                                    player:cost_money(PS, MoneyType, CostNum, ["ply_guild","purchase_guild_shop"]),
                                                                    mod_inv:batch_smart_add_new_goods(player:get_id(PS), [{ShopInfo#data_guild_shop.goods_no, Count}],
                                                                        [{bind_state, 1}], ["ply_guild", "purchase_guild_shop"]),

                                                                    NewGuildShop = lists:keyreplace(ShopId, 1, GuildShop, {ShopId, _No, NumLimit - Count}),
                                                                    NewGuild = Guild#guild{guild_shop = NewGuildShop},
                                                                    mod_guild:update_guild_to_ets(NewGuild),
                                                                    {ok, NumLimit - Count}
                                                            end;
                                                        false ->
                                                            {fail, ?PM_MONEY_LIMIT}
                                                    end;
                                                false ->
                                                    {fail ,?PM_NOT_STOCK}
                                            end;
                                        false ->
                                            {fail, ?PM_GOODS_NOT_EXISTS}
                                    end
                            end
                    end
            end
    end.

refresh_guild_shop() ->
    GuildList = mod_guild:get_guild_list(),
    F = fun(GuildId) ->
        case mod_guild:get_info(GuildId) of
            null ->
                skip;
            Guild ->
                GuildLv = mod_guild:get_lv(Guild),
                IdList = data_guild_shop:get_ids(),
                GoodsList = lib_guild:get_range_shop_goods(GuildLv, IdList),
                NewGoodsList = lists:sublist(GoodsList, 12),
                NewGuild = Guild#guild{guild_shop = NewGoodsList},
                mod_guild:db_save_guild(NewGuild),
                mod_guild:update_guild_to_ets(NewGuild),
                MemberList = mod_guild:get_member_id_list(NewGuild),
                {ok, BinData} = pt_40:write(?PT_GUILD_QUERY_DYNAMIC_GOODS_IN_SHOP, [NewGoodsList]),
                [lib_send:send_to_uid(PlayerId, BinData) || PlayerId <- MemberList, player:is_online(PlayerId)],
                ?DEBUG_MSG("refresh_guild_shop  :  ~p~n",[NewGoodsList])
        end
    end,
    [F(Guild#guild.id) || Guild <- GuildList, Guild#guild.id =/= ?INVALID_NO].

refresh_one_guild_shop(GuildId, PlayerId) ->
    case mod_guild:get_info(GuildId) of
        null ->
            skip;
        Guild ->
            GuildLv = mod_guild:get_lv(Guild),
            IdList = data_guild_shop:get_ids(),
            GoodsList = lib_guild:get_range_shop_goods(GuildLv, IdList),
            NewGoodsList = lists:sublist(GoodsList, 12),
            NewGuild = Guild#guild{guild_shop = NewGoodsList},
            mod_guild:db_save_guild(NewGuild),
            mod_guild:update_guild_to_ets(NewGuild),
            {ok, BinData} = pt_40:write(?PT_GUILD_QUERY_DYNAMIC_GOODS_IN_SHOP, [NewGoodsList]),
            lib_send:send_to_uid(PlayerId, BinData),
            ?DEBUG_MSG("refresh_guild_shop  :  ~p~n",[NewGoodsList])
    end.