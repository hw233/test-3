%%%--------------------------------------
%%% @Module  : ply_tmplogout_cache (ply: player)
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2013.12.31
%%% @Description: 操作临时退出的玩家的缓存数据的相关接口
%%%--------------------------------------
-module(ply_tmplogout_cache).
-behaviour(gen_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([start_link/0]).
-export([
        get_tmplogout_PS/1,
        del_tmplogout_PS/1,

        call_get_tmplogout_PS/1,

        get_tmplogout_PBrf/1,
        del_tmplogout_PBrf/1,
        update_tmplogout_PBrf/1,

        get_prev_pos/1,

        set_position/2,

        set_team_id/2,
        set_leader_flag/2,
        is_in_team/1,

        set_guild_id/2,

        set_dungeon_info/2,

        set_priv_lv/2,

        battle_feedback/2

        
    ]).

-include("common.hrl").
-include("record.hrl").
-include("player.hrl").
-include("record/battle_record.hrl").
-include("log.hrl").
-include("abbreviate.hrl").
-include("relation.hrl").
-include("buff.hrl").
-include("goods.hrl").
-include("drop.hrl").

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).


%% 获取所缓存的临时退出的玩家PS
%% @return: null | player_status结构体
get_tmplogout_PS(PlayerId) ->
    mod_svr_mgr:get_tmplogout_player_status(PlayerId).

%% 删除所缓存的临时退出的玩家PS
del_tmplogout_PS(PlayerId) ->
    mod_svr_mgr:del_tmplogout_player_status_from_ets(PlayerId).


%% 同步获取最新的所缓存的临时退出的玩家PS
%% @return: null | player_status结构体
call_get_tmplogout_PS(PlayerId) ->
    gen_server:call(?MODULE, {'get_tmplogout_PS', PlayerId}).


%% 获取所缓存的临时退出的玩家简要信息（PBrf: player brief）
%% @return: null | plyr_brief结构体
get_tmplogout_PBrf(PlayerId) ->
    mod_svr_mgr:get_tmplogout_player_brief(PlayerId).

%% 删除所缓存的临时退出的玩家简要信息
del_tmplogout_PBrf(PlayerId) ->
    mod_svr_mgr:del_tmplogout_player_brief_from_ets(PlayerId).

%% 更新所缓存的临时退出的玩家简要信息
update_tmplogout_PBrf(PB) ->
    mod_svr_mgr:update_tmplogout_player_brief_to_ets(PB).



%% 获取进入副本前的位置信息
get_prev_pos(PS) ->
    player:get_prev_pos(PS).
    

%% 设置位置信息
set_position(PlayerId, Pos) when is_record(Pos, plyr_pos) ->
    gen_server:cast(?MODULE, {'set_position', PlayerId, Pos}),
    void.


%% 设置队伍id
set_team_id(PS, TeamId) ->
    ?ASSERT(is_integer(TeamId), TeamId),
    gen_server:cast(?MODULE, {'set_team_id', PS, TeamId}),
    void.


%% 设置队长标记
set_leader_flag(PS, Flag) ->
    ?ASSERT(is_boolean(Flag), Flag),
    gen_server:cast(?MODULE, {'set_leader_flag', PS, Flag}),
    void.
    

%% 是否在队伍中
is_in_team(PS) ->
    player:is_in_team(PS).


%% 设置帮派id
set_guild_id(PS, GuildId) ->
    ?ASSERT(is_integer(GuildId), GuildId),
    gen_server:cast(?MODULE, {'set_guild_id', PS, GuildId}),
    void.


%% 设置副本信息
set_dungeon_info(PS, DunInfo) ->
    gen_server:cast(?MODULE, {'set_dungeon_info', PS, DunInfo}),
    void.


%% 设置权限等级
set_priv_lv(PlayerId, PrivLv) ->
    ?ASSERT(is_integer(PlayerId)),
    gen_server:cast(?MODULE, {'set_priv_lv', PlayerId, PrivLv}),
    void.


%% 战斗反馈
battle_feedback(PlayerId, FbInfo) ->
    gen_server:cast(?MODULE, {'battle_feedback', PlayerId, FbInfo}),
    void.

    


    
% 作废！！
% set_rela_list(PS, List) ->
%     ?ASSERT(is_list(List), List),
%     gen_server:cast(?MODULE, {'set_rela_list', PS, List}),
%     void.





%% ---------------------------------------------------------------------------

init([]) ->
    process_flag(trap_exit, true),
    ?TRACE("[ply_tmplogout_cache] init()...~n"),
    {ok, null}.


handle_call({'get_tmplogout_PS', TargetPlayerId}, _From, State) ->
    Ret = get_tmplogout_PS(TargetPlayerId),
    {reply, Ret, State};

handle_call(_Request, _From, State) ->
    ?ASSERT(false, _Request),
    {reply, null, State}.


handle_cast({'set_position', PlayerId, Pos}, State) ->
    player:set_position(PlayerId, Pos),
    {noreply, State};

handle_cast({'set_team_id', PS, TeamId}, State) ->
    PS_Latest = get_tmplogout_PS( player:id(PS)),  % 重新获取所缓存的最新的PS，下同！
    set_team_id__(PS_Latest, TeamId),    
    {noreply, State};

handle_cast({'set_leader_flag', PS, Flag}, State) ->
    PS_Latest = get_tmplogout_PS( player:id(PS)),
    set_leader_flag__(PS_Latest, Flag),    
    {noreply, State};

handle_cast({'set_guild_id', PS, GuildId}, State) ->
    PS_Latest = get_tmplogout_PS( player:id(PS)),
    set_guild_id__(PS_Latest, GuildId),    
    {noreply, State};

handle_cast({'set_dungeon_info', PS, DunInfo}, State) ->
    PS_Latest = get_tmplogout_PS( player:id(PS)),
    ?TRY_CATCH(set_dungeon_info__(PS_Latest, DunInfo), ErrReason), % 有小概率出现PS_Latest为null的情况，故加catch容错！
    {noreply, State};

handle_cast({'set_priv_lv', PlayerId, PrivLv}, State) ->
    ?TRY_CATCH(set_priv_lv__(PlayerId, PrivLv), ErrReason),
    {noreply, State};

handle_cast({'battle_feedback', PlayerId, FbInfo}, State) ->
    ?TRY_CATCH(handle_battle_feedback(PlayerId, FbInfo), ErrReason),
    {noreply, State};


    

% handle_cast({'set_rela_list', PS, List}, State) ->
%     PS_Latest = get_tmplogout_PS( player:id(PS)),
%     set_rela_list__(PS_Latest, List),    
%     {noreply, State};

% %% @doc 处理副本在缓存中退出
% handle_cast({dungeon_logout, RoleId, Dungeon, ScoreLv, Ltime}, State) ->
%     mod_dungeon:publ_handle_tmp_logout_dungeon(RoleId, Dungeon, ScoreLv, Ltime),
%     {noreply, State};

handle_cast(_Msg, State) ->
    ?ASSERT(false, _Msg),
    {noreply, State}.


handle_info(_Info, State) ->
    {noreply, State}.


terminate(Reason, _State) ->
    case Reason of
        normal -> skip;
        shutdown -> skip;
        _ -> ?ERROR_MSG("[ply_tmplogout_cache] !!!!!terminate!!!!! for reason: ~w", [Reason])
    end,
    ok.


code_change(_OldVsn, State, _Extra) ->
    {ok, State}.






%% =======================================================================================


%% 更新临时退出的玩家PS到ets
update_tmplogout_PS(PS_Latest) ->
    mod_svr_mgr:update_tmplogout_player_status_to_ets(PS_Latest).




%% 注意：传入的PS须是最新的，下同！
set_team_id__(PS, TeamId) ->
    PS2 = PS#player_status{team_id = TeamId},
    update_tmplogout_PS(PS2).


set_leader_flag__(PS, Flag) ->
    PS2 = PS#player_status{is_leader = Flag},
    update_tmplogout_PS(PS2).


set_guild_id__(PS, GuildId) ->
    PS2 = PS#player_status{guild_id = GuildId},
    update_tmplogout_PS(PS2).


set_dungeon_info__(PS, DunInfo) ->
    PS2 = PS#player_status{dun_info = DunInfo},
    update_tmplogout_PS(PS2).


% set_rela_list__(PS, List) ->
%     PS2 = PS#player_status{rela_list = List},
%     update_tmplogout_PS(PS2).


set_priv_lv__(PlayerId, PrivLv) ->
    PS = get_tmplogout_PS(PlayerId),
    PS2 = PS#player_status{priv_lv = PrivLv},
    update_tmplogout_PS(PS2),
    ply_priv:db_update_priv_lv(PlayerId, PrivLv).  % 更新到DB


handle_battle_feedback(PlayerId, FbInfo) ->
    ?ASSERT(is_record(FbInfo, btl_feedback)),
    ?ASSERT(FbInfo#btl_feedback.player_id == PlayerId),

    ?DEBUG_MSG("[ply_tmplogout_cache] handle_battle_feedback(), PlayerId:~p, FbInfo:~w", [PlayerId, FbInfo]),

    case lib_bt_comm:is_PVE_battle(FbInfo) of
        true ->
            handle_PVE_battle_feedback(PlayerId, FbInfo);
        false ->
            handle_PVP_battle_feedback(PlayerId, FbInfo)
            % skip
    end.

%% 处理PVP离线的玩家数据
handle_PVP_battle_feedback(PlayerId, FbInfo) ->
    case lib_bt_comm:is_qiecuo_pk_battle(FbInfo) orelse lib_bt_comm:is_1v1_online_arena_battle(FbInfo) orelse lib_bt_comm:is_3v3_online_arena_battle(FbInfo) of
        true ->
            ?DEBUG_MSG("handle_PVP_battle_feedback(), it is qiecuo~n",[]),
            skip;
        false ->
            case player:get_pid(PlayerId) of
                null ->
                    case get_tmplogout_PS(PlayerId) of
                        PS when is_record(PS,player_status) -> 
                            maybe_kill_trigger(PS, FbInfo),
                            maybe_teleport_after_battle(PlayerId, FbInfo),
                            maybe_add_pk_protect_buff(PlayerId, FbInfo),
                            maybe_send_player_tips(PlayerId, FbInfo);
                        _ ->
                            % 完全掉线并且是偷袭PVP 则标记为逃兵
                            Result = FbInfo#btl_feedback.result,
                            ?Ifc ( Result == lose )
                                lib_player_ext:try_update_data(PlayerId,pvp_flee,1)
                            ?End

                    end;
                _PlayerPid ->
                    mod_player:battle_feedback(PlayerId, FbInfo)
            end
    end.


%% 被杀
maybe_kill_trigger1(PS,Feedback) ->
    Result = Feedback#btl_feedback.result,
    IsForcePk = lib_bt_comm:is_force_pk_battle(Feedback),
    IsStartBattler = lib_bt_comm:is_start_battle_side(Feedback),
    ?DEBUG_MSG("Result=~p,IsForcePk=~p,IsStartBattler=~p",[Result,IsForcePk,IsStartBattler]),
    % 战斗结果失败 并是强制PK
    ?Ifc ( Result == lose andalso IsForcePk)
        ?DEBUG_MSG("ConsExp=~p",[util:ceil(player:get_exp(PS) * ?KILL_SUB_EXT_COEF)]),
        % 自己发起PK或者自己是红名
        Coef = case IsStartBattler orelse player:get_popular(PS) >= ?RED_NAME_POPULAR   of 
            true -> ?KILL_SUB_EXT_COEF * 2;
            false -> ?KILL_SUB_EXT_COEF
        end,

        List = Feedback#btl_feedback.oppo_player_id_list,
        % Len = length(List),
        
        F = fun(Pid,Acc) ->
            % 添加仇人
            ply_relation:add_friend(player:id(PS),Pid,?ENEMY),

            case player:get_PS(Pid) of
                PPS when is_record(PPS,player_status) ->
                    case not player:is_in_team(PPS) orelse player:is_leader(PPS) of
                        true ->
                            PPS;
                        false ->
                            Acc
                    end;
                _ ->
                    Acc
            end
        end,

        Killer = lists:foldl(F, null,List),

        case Killer of 
            null ->
                skip;
            Killer_ when is_record(Killer_,player_status) ->    
                % 广播公告
                mod_broadcast:send_sys_broadcast(175, [
                    player:get_name(Killer)
                    ,player:id(Killer)
                    ,player:get_scene_no(Killer)
                    ,player:get_name(PS)
                    ,player:id(PS)
                    ]),

                % 广播公告通知帮派被杀
                ply_tips:send_sys_tips(PS, {guild_player_be_kill, [
                    player:get_name(PS)
                    ,player:id(PS)
                    ,player:get_scene_no(Killer)
                    ,player:get_name(Killer)
                    ,player:id(Killer)
                    ]}),

                skip;
            _ -> skip
        end,
        % player:cost_exp(player:id(PS), util:ceil(player:get_exp(player:id(PS)) * Coef), [?LOG_FORCE_PK, "be killed"])

        update_tmplogout_PS(PS#player_status{exp = util:ceil(erlang:max(player:get_exp(PS) - player:get_exp(PS) * Coef,0))})
    ?End,
    void.

% 处理玩家死亡传送问题
maybe_teleport_after_battle(PlayerId, Feedback) ->
    Result = Feedback#btl_feedback.result,
    LeftHp = Feedback#btl_feedback.left_hp,
	if 
		Result == lose andalso LeftHp == 0 ->% 玩家为输的一方
			IsNormalMf = lib_bt_comm:is_normal_mf_battle(Feedback),
			IsForcePk = lib_bt_comm:is_force_pk_battle(Feedback),
			IsGuildPk = lib_bt_comm:is_guild_pk_battle(Feedback),
			if 
				IsNormalMf orelse IsForcePk ->% 普通打怪和强行pk的处理
					PS = get_tmplogout_PS(PlayerId),
        			ply_scene:teleport_after_die(PS);
				IsGuildPk ->
					PS = get_tmplogout_PS(PlayerId),
					lib_guild_battle:enter_to_0(PS);
				true ->
					skip
			end;
		true ->
			skip
	end.
%%     ?Ifc ( Result == lose andalso LeftHp == 0 andalso (lib_bt_comm:is_normal_mf_battle(Feedback) orelse lib_bt_comm:is_force_pk_battle(Feedback)) )
%%         PS = get_tmplogout_PS(PlayerId),
%%         ply_scene:teleport_after_die(PS)
%%     ?End.


maybe_add_pk_protect_buff(PlayerId, Feedback) ->
    Result = Feedback#btl_feedback.result,
    LeftHp = Feedback#btl_feedback.left_hp,
    ?Ifc ( Result == lose andalso LeftHp == 0 andalso lib_bt_comm:is_force_pk_battle(Feedback) )
        lib_buff:player_add_buff(PlayerId, ?BNO_PK_PROTECT)
    ?End.

maybe_send_player_tips(PlayerId, Feedback) ->
    case lib_bt_comm:is_force_pk_battle(Feedback)
    orelse lib_bt_comm:is_1v1_online_arena_battle(Feedback) 
    orelse lib_bt_comm:is_3v3_online_arena_battle(Feedback) of
        true ->
            Result = Feedback#btl_feedback.result,
            LeftHp = Feedback#btl_feedback.left_hp,
            case length(Feedback#btl_feedback.oppo_player_id_list) > 1 of
                true -> 
                    ?Ifc ( LeftHp =:= 0 )
                        NameList = ply_tips:get_name_list_by_ids(Feedback#btl_feedback.oppo_player_id_list),

                         Content1 = io_lib:format(<<
                            "击杀您的凶手是~s">>, 
                            [
                                NameList
                            ]),

                        lib_mail:send_sys_mail(PlayerId
                          ,<<"您被人杀了">>
                          ,Content1
                          ,[]
                          ,[?LOG_FORCE_PK, lose]
                        )

                    ?End;
                false ->
                    [OppoPlayerId] = Feedback#btl_feedback.oppo_player_id_list,
                    case player:get_PS(OppoPlayerId) of
                        null ->
                            skip;
                        OppoPS ->
                            ?Ifc ( LeftHp =:= 0 )
                                Content2 = io_lib:format(<<"您在野外被~s击杀了">>, 
                                [
                                    player:get_name(OppoPS)
                                ]),

                                lib_mail:send_sys_mail(PlayerId
                                  ,<<"您被人杀了">>
                                  ,Content2
                                  ,[]
                                  ,[?LOG_FORCE_PK, lose]
                                )
                            ?End,

                            ?Ifc ( Result =:= win )
                                Content3 = io_lib:format(<<"您在野外击杀了~s">>, 
                                [
                                    player:get_name(OppoPS)
                                ]),

                                lib_mail:send_sys_mail(PlayerId
                                  ,<<"您杀人了">>
                                  ,Content3
                                  ,[]
                                  ,[?LOG_FORCE_PK, win]
                                )
                            ?End
                    end
            end;
        false ->
            skip
    end.


%% 主动杀人
maybe_kill_trigger2(PS,Feedback) ->
    Result = Feedback#btl_feedback.result,
    IsForcePk = lib_bt_comm:is_force_pk_battle(Feedback),
    IsStartBattler = lib_bt_comm:is_start_battle_side(Feedback),
    ?DEBUG_MSG("Result=~p,IsForcePk=~p,IsStartBattler=~p",[Result,IsForcePk,IsStartBattler]),
    % 战斗结果是胜利 并是强制PK 且自己是发起者
    ?Ifc ( Result == win andalso IsForcePk andalso IsStartBattler)
        List = Feedback#btl_feedback.oppo_player_id_list,
        
        F = fun(PlayerId) ->
            case player:get_PS(PlayerId) of
                PSOth when is_record(PSOth,player_status) ->
                    player:get_popular(PSOth) < ?RED_NAME_POPULAR ;
                _ -> false
            end
        end,

        % 过滤只算非红名单位
        List1 = [X || X <- List, F(X)],

        KillCount = erlang:max(length(List1),1),
        ?DEBUG_MSG("KillCount=~p",[KillCount]),
        player:set_popular(player:id(PS),player:get_popular(player:id(PS)) + KillCount*?KILL_ONE_SUB_POPULAR),
        ?DEBUG_MSG("get_popular=~p",[player:get_popular(player:id(PS))])
    ?End,

    void.

% 杀人触发
maybe_kill_trigger(PS,Feedback) ->
    % ?DEBUG_MSG("Result=~p,IsForcePk=~p,IsStartBattleEr=~p",[Result,IsForcePk,IsStartBattler]),
    PlayerId = player:id(PS),
    maybe_kill_trigger1(PS,Feedback),
    PS2 = player:get_PS(PlayerId),
    maybe_kill_trigger2(PS2,Feedback),
    void.


%% 暂时只处理怪物掉落给玩家
handle_PVE_battle_feedback(PlayerId, FbInfo) ->
    PS = get_tmplogout_PS(PlayerId),
    Result = FbInfo#btl_feedback.result,
    
    case lib_bt_comm:is_mf_battle(FbInfo) andalso (Result == win) of
        true ->
            handle_mf_drop_for_player(PS, FbInfo);
        false ->
            skip
    end.
    
handle_mf_drop_for_player(PS, FbInfo) ->
    PlayerId = player:id(PS),
    case player:get_pid(PlayerId) of
        null ->
            handle_mf_drop(PS, FbInfo);
        _PlayerPid ->
            mod_player:battle_feedback(PlayerId, FbInfo)
    end.


%% 处理离线玩家怪物掉落
%% return GoodsList 格式 [{GoodsId, GoodsNo, GoodsCount}]
handle_mf_drop(PS, BtlFeedback) ->
    ShuffledTeamMbList = BtlFeedback#btl_feedback.shuffled_team_mb_list,

    F0 = fun({PartnerId, _Hp, _Mp}, AccList) ->
            [PartnerId | AccList]
        end,
    ParIdList = lists:foldl(F0, [], BtlFeedback#btl_feedback.partner_info_list),

    %% 处理玩家获得的掉落（这里只给物品）
    F1 = fun(BMonNo, Drop) ->
            lib_drop:give_drop_to_player(Drop, PS, BMonNo, ShuffledTeamMbList, [?LOG_BATTLE, BtlFeedback#btl_feedback.bmon_group_no])
        end,

    F2 = fun({BMonNo, Count}, Drop) ->
            L = lists:duplicate(Count, BMonNo),
            lists:foldl(F1, Drop, L)
        end,
    SpawnBMonList = BtlFeedback#btl_feedback.spawned_bmon_list,
    DropDtl = lists:foldl(F2, #drop_dtl{}, SpawnBMonList),

    %% 给玩家加经验 和 钱 
    Fply = fun(VGoodsNo, AccPS) ->
        case lists:keyfind(VGoodsNo, 2, DropDtl#drop_dtl.goods_list) of
            false -> AccPS;
            {_, _, GoodsCount} when GoodsCount > 0 -> 
                if
                    VGoodsNo =:= ?VGOODS_EXP ->
                        add_exp(AccPS, GoodsCount, [?LOG_BATTLE, BtlFeedback#btl_feedback.bmon_group_no]);
                    true ->
                        MoneyType =
                            case VGoodsNo of
                                ?VGOODS_GAMEMONEY -> ?MNY_T_GAMEMONEY;
                                ?VGOODS_YB -> ?MNY_T_YUANBAO;
                                ?VGOODS_BIND_GAMEMONEY -> ?MNY_T_BIND_GAMEMONEY;
                                ?VGOODS_BIND_YB   -> ?MNY_T_BIND_YUANBAO;
								?VGOODS_INTEGRAL   -> ?MNY_T_INTEGRAL
                            end,
                        add_money(AccPS, MoneyType, GoodsCount, [?LOG_BATTLE, BtlFeedback#btl_feedback.bmon_group_no])
                end;
            _ -> AccPS
        end
    end,

    NewPS = lists:foldl(Fply, PS, [?VGOODS_EXP, ?VGOODS_GAMEMONEY, ?VGOODS_YB, ?VGOODS_BIND_GAMEMONEY, ?VGOODS_BIND_YB]),
    update_tmplogout_PS(NewPS),

    %% 处理宠物获得的掉落
    Fpar = fun(PartnerId, Acc) ->
        F3 = fun(BMonNo, Drop) ->
                lib_drop:calc_drop_to_partner(Drop, PS, PartnerId, BMonNo)
            end,

        F4 = fun({BMonNo, Count}, Drop) ->
                L = lists:duplicate(Count, BMonNo),
                lists:foldl(F3, Drop, L)
            end,

        DropDtlPar = lists:foldl(F4, #drop_dtl{}, BtlFeedback#btl_feedback.spawned_bmon_list),

        case lists:keyfind(?VGOODS_PAR_EXP, 2, DropDtlPar#drop_dtl.goods_list) of
            false -> Acc;
            {_, _GoodsNo2, GoodsCount2} when GoodsCount2 > 0 ->
                case lib_partner:get_partner(PartnerId) of
                    null -> Acc;
                    Partner ->
                        lib_partner:add_exp(Partner, GoodsCount2, PS, [?LOG_BATTLE, BtlFeedback#btl_feedback.bmon_group_no]),
                        Acc + GoodsCount2
                end;
            _ -> Acc
        end
    end,

    TotalParExp = lists:foldl(Fpar, 0, ParIdList),

    [{?INVALID_ID, ?VGOODS_PAR_EXP, TotalParExp} | DropDtl#drop_dtl.goods_list].


%% return NewPS 需要上层函数updatePS
add_exp(PS, Value, LogInfo) ->
    NewExp = util:minmax(player:get_exp(PS) + Value, 0, ?MAX_U32), % 避免数据溢出
    Value1 = NewExp - player:get_exp(PS),
    case Value1 > 0 of
        true ->
            lib_log:statis_produce_currency(PS, ?MNY_T_EXP, Value1, LogInfo);
        false ->
            lib_log:statis_consume_currency(PS, ?MNY_T_EXP, -Value1, LogInfo)
    end,
    PS#player_status{exp = NewExp}.


%% 升级（同步）
% do_upgrade__(PS_Latest) ->
%     CurExp = player:get_exp(PS_Latest),
%     ExpLim = player:get_exp_lim(PS_Latest),
%     NewLv = player:get_lv(PS_Latest) + 1,
%     LeftExp = max(CurExp - ExpLim, 0),   % 扣去相应经验后的剩余经验。 这里做max矫正，是为了防止：万一出bug的话，玩家会得到一个数值很大的经验值
%     PS_Latest2 = PS_Latest#player_status{lv=NewLv}
%     PS_Latest3 = PS_Latest2#player_status{exp = NewVal},

%     % 处理天赋属性点
%     handle_talent_points_on_upgrade(PS_Latest3, NewLv).


% %% 升级时处理天赋属性点，返回更新后的PS
% handle_talent_points_on_upgrade(PS, NewLv) ->
%     % 每提升一级各个天赋点都增加一点（体质和耐力除外，是0.5），
%     % 另外有额外5点给玩家自己任意加（10级前则自动帮玩家加）
%     AddPoint_Con0 = case util:is_odd(NewLv) of  % 体质每级加0.5，等价于每两级加1，下面的耐力同理
%                         true -> 1;
%                         false -> 0
%                     end,
%     AddPoint_Stam0 = case util:is_odd(NewLv) of
%                         true -> 1;
%                         false -> 0
%                     end,
%     AddPoint_Str0 = 1,
%     AddPoint_Spi0 = 1,
%     AddPoint_Agi0 = 1,

%     {AddPoint_Con, AddPoint_Stam, AddPoint_Str, AddPoint_Spi , AddPoint_Agi} =
%         case data_lv_break:get(NewLv-1) of
%             #lv_break{
%                 reward_con = BKcon,
%                 reward_sta = BKsta,
%                 reward_str = BKstr,
%                 reward_spi = BKspi,
%                 reward_agi = BKagi} ->
%                     {AddPoint_Con0 + BKcon,
%                     AddPoint_Stam0 + BKsta,
%                     AddPoint_Str0 + BKstr,
%                     AddPoint_Spi0 + BKspi,
%                     AddPoint_Agi0 + BKagi};
%             _ ->
%                 {AddPoint_Con0,
%                 AddPoint_Stam0,
%                 AddPoint_Str0,
%                 AddPoint_Spi0,
%                 AddPoint_Agi0}
%         end,

%     NewPS = case NewLv < ?MANUAL_ALLOT_FREE_TALENT_POINTS_START_LV of
%                 true ->
%                     case player:get_race(PS) of
%                         ?RACE_REN ->  % 人族：额外5点的自动分配规则———— 4力量1耐力
%                             PS#player_status{base_attrs = PS#player_status.base_attrs#attrs{
%                                 talent_str = player:get_base_str(PS) + 4,
%                                 talent_con = player:get_base_con(PS) + AddPoint_Con,
%                                 talent_sta = get_base_stam(PS) + 1,
%                                 talent_spi = get_base_spi(PS) + AddPoint_Spi,
%                                 talent_agi = get_base_agi(PS) + AddPoint_Agi
%                                 }};
%                         ?RACE_MO ->  % 魔族：额外5点的自动分配规则———— 4力量1耐力
%                             PS#player_status{base_attrs = PS#player_status.base_attrs#attrs{
%                                 talent_str = player:get_base_str(PS) + 4,
%                                 talent_con = player:get_base_con(PS) + AddPoint_Con,
%                                 talent_sta = get_base_stam(PS) + 1,
%                                 talent_spi = get_base_spi(PS) + AddPoint_Spi,
%                                 talent_agi = get_base_agi(PS) + AddPoint_Agi
%                                 }};
%                         ?RACE_XIAN -> % 仙族：额外5点的自动分配规则———— 4力量1耐力
%                             PS#player_status{base_attrs = PS#player_status.base_attrs#attrs{
%                                 talent_str = player:get_base_str(PS) + 4,
%                                 talent_con = player:get_base_con(PS) + AddPoint_Con,
%                                 talent_sta = get_base_stam(PS) + 1,
%                                 talent_spi = get_base_spi(PS) + AddPoint_Spi,
%                                 talent_agi = get_base_agi(PS) + AddPoint_Agi
%                                 }};
%                         ?RACE_YAO ->
%                             ?ASSERT(false),
%                             PS   % 待定
%                     end;
%                 false ->
%                     PS#player_status{base_attrs = PS#player_status.base_attrs#attrs{
%                                 talent_str = player:get_base_str(PS) + AddPoint_Str,
%                                 talent_con = player:get_base_con(PS) + AddPoint_Con,
%                                 talent_sta = get_base_stam(PS) + AddPoint_Stam,
%                                 talent_spi = get_base_spi(PS) + AddPoint_Spi,
%                                 talent_agi = get_base_agi(PS) + AddPoint_Agi,
%                                 free_talent_points = player:get_free_talent_points(PS) + 5
%                                 }}
%             end,

%     NewPS.


add_money(PS_Latest, MoneyType, Value, LogInfo) ->
    lib_log:statis_produce_currency(PS_Latest, MoneyType, Value, LogInfo),
    PS_Latest1 = 
        case MoneyType of
            ?MNY_T_GAMEMONEY ->
                NewValue = erlang:min( player:get_gamemoney(PS_Latest) + Value, ?MAX_U64),  % 稳妥起见，做范围矫正，以免越界，下同
                PS_Latest#player_status{gamemoney = NewValue};
            ?MNY_T_BIND_GAMEMONEY ->
                NewValue = erlang:min( player:get_bind_gamemoney(PS_Latest) + Value, ?MAX_U64),
                PS_Latest#player_status{bind_gamemoney = NewValue};
            ?MNY_T_YUANBAO ->
                NewValue = erlang:min( player:get_yuanbao(PS_Latest) + Value, ?MAX_U32),
                PS_Latest#player_status{yuanbao = NewValue};
            ?MNY_T_BIND_YUANBAO ->
                NewValue = erlang:min( player:get_bind_yuanbao(PS_Latest) + Value, ?MAX_U32),
                PS_Latest#player_status{bind_yuanbao = NewValue};
            ?MNY_T_INTEGRAL ->
                NewValue = erlang:min( player:get_integral(PS_Latest) + Value, ?MAX_U32),
                PS_Latest#player_status{integral = NewValue};
            ?MNY_T_FEAT ->
                NewValue = erlang:min( player:get_feat(PS_Latest) + Value, ?MAX_U32),
                PS_Latest#player_status{feat = NewValue};
            ?MNY_T_LITERARY ->
                NewValue = erlang:min( player:get_literary(PS_Latest) + Value, ?MAX_U32),
                PS_Latest#player_status{literary = NewValue};
            _ ->
                ?ERROR_MSG("ply_tmplogout_cache add_money error!MoneyType:~p~n", [MoneyType])
        end,

    PS_Latest1.