%%%------------------------------------
%%% @Module  : mod_guild_mgr
%%% @Author  : zhangwq
%%% @Email   :
%%% @Created : 2014.3.28
%%% @Description: server 用于同步处理审批成员入会 、创建帮派、同意加入帮派 和 帮派排名等比较耗时的操作 以及处理帮派宴会
%%%------------------------------------


-module(mod_guild_mgr).
-behaviour(gen_server).
-export([start_link/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-export([
        create_guild/3,
        handle_guild_apply/3,
        reply_invite/3,
        quit_guild/2,
        kick_out_from_guild/3,

        add_member_contri/3,
        cost_member_contri/3,
        add_prosper/2,
        add_liveness/2,
        update_guild_rank/0,
        try_update_battle_power/1,      

        guild_party_begin/0,            %% 活动模块通知帮派宴会开始
        guild_party_begin/1,            %% gm模块通知帮派宴会开始 测试用
        guild_party_end/0,              %% 活动模块通知帮派宴会结束
        refresh_script/2,               %% 为帮派活动执行脚本，例如刷怪等

        add_guild_buff/0,               %% 作业计划模块反馈添加帮派宴会buff
        add_guild_buff/1,               %% 活动模块通知帮派宴会加buff以及加buff的时间间隔
        syn_guild_scene/2,              %% 同步保存帮派场景id
        notify_guild_dungeon_begin/0,

        notify_guild_pre_war_begin/0,
        notify_guild_pre_war_end/0,
        notify_guild_war_begin/0,
        notify_guild_war_end/0,

        on_guild_war_dun_create/2,

        decide_guild_war_group/0,           %% 周五0点决定帮派争夺战比赛分组
        get_guild_war_round/0,
        set_guild_war_round/1,
        get_guild_war_counter/0,
        db_save_guild_war/0,
        war_allow_disband/1,                %% 判断帮派争霸赛是否允许解散帮派
        is_pid_ok/1,
        refund_to_player/2,
        notify_guild_disband/1,

        give_reward_for_activity/1,         %% 运营后台搞帮派活动发奖励
        adjust_guild_war_time/1,             %% 根据活动脚本开始时间，矫正帮派争霸赛显示时间
        check_player_guild_info/2,
        check_modify_guild_name/3,
        reset_counter_and_round/0,

        test_enter_war_dun/1,
        test_get_war_info/0,
        test_clear_war/0,
        on_guild_job_schedule/0
    ]).


-include("guild.hrl").
-include("prompt_msg_code.hrl").
-include("ets_name.hrl").
-include("debug.hrl").
-include("abbreviate.hrl").
-include("common.hrl").
-include("log.hrl").
-include("pt_40.hrl").
-include("record/guild_record.hrl").
-include("obj_info_code.hrl").
-include("job_schedule.hrl").
-include("scene.hrl").
-include("dungeon.hrl").
-include("activity_degree_sys.hrl").
-include("sys_code.hrl").
-include("guild_dungeon.hrl").

%% 帮派进程的内部状态
-record(state, {
        party_open = 0,         % 0表示宴会没有开启，时间戳表示宴会开始时间
        add_buff_interval = 0   % 帮派宴会添加buff的时间间隔
    }).


%% 进程字典的key名
-define(PDKN_GUILD_WAR_TURN, pdkn_guild_war_turn).          %% 帮派争夺战当前届数（每届4轮）
-define(PDKN_GUILD_WAR_MIN_BID, pdkn_guild_war_min_bid).    %% 当前帮派有机会入选争霸赛最低投标值
-define(PDKN_GUILD_WAR_ROUND, pdkn_guild_war_round).        %% 帮派争夺战当前的轮数 每周一0点且当计数器=0的时候清0，开启报名
-define(PDKN_GUILD_WAR_TIME, pdkn_guild_war_time).          %% 帮派争夺战当前的轮数时间 [{Round, UnixTime},...]
-define(PDKN_GUILD_WAR_COUNTER, pdkn_guild_war_counter).    %% 帮派争夺战活动计数器 当计数器=轮数，则活动开始，否则不开始，此轮没有比赛
-define(PDKN_GUILD_WAR_OBJ_GUILD, pdkn_guild_war_obj_guild).%% 帮派争夺战对手帮派id
-define(PDKN_GUILD_WAR_LAST_RANK, pdkn_guild_war_last_rank).%% 帮派争夺战上届排名 [{Rank, GuildId, TotalBid, GuildName},...]
-define(PDKN_GUILD_WAR_GROUP, pdkn_guild_war_group).        %% 帮派争夺战比赛分组 [{Slot, GuildId, GuildName}, ...] Slot 为 赛场格子编号


create_guild(PS, GuildName, Brief) ->
    gen_server:cast(?GUILD_PROCESS, {'create_guild', PS, GuildName, Brief}).

handle_guild_apply(PS, PlayerId, Choise) ->
    gen_server:cast(?GUILD_PROCESS, {'handle_guild_apply', PS, PlayerId, Choise}).


reply_invite(PS, GuildId, Choise) ->
    gen_server:cast(?GUILD_PROCESS, {'reply_invite', PS, GuildId, Choise}).    

on_guild_job_schedule() ->
    gen_server:cast(?GUILD_PROCESS, 'on_guild_job_schedule').

update_guild_rank() ->
    gen_server:cast(?GUILD_PROCESS, 'update_guild_rank').    

refresh_script(ScriptList, sys) ->
    gen_server:cast(?GUILD_PROCESS, {'refresh_script', ScriptList, sys}).        


guild_party_begin() ->
    gen_server:cast(?GUILD_PROCESS, 'guild_party_begin').


guild_party_begin(Interval) ->
    gen_server:cast(?GUILD_PROCESS, {'guild_party_begin', Interval}).


guild_party_end() ->
    gen_server:cast(?GUILD_PROCESS, 'guild_party_end').

add_guild_buff(Interval) ->
    gen_server:cast(?GUILD_PROCESS, {'add_guild_buff', Interval}).

add_guild_buff() ->
    gen_server:cast(?GUILD_PROCESS, 'add_guild_buff').

quit_guild(PS, GuildId) ->
    gen_server:cast(?GUILD_PROCESS, {'quit_guild', PS, GuildId}).


kick_out_from_guild(PS, GuildId, ObjPlayerId) ->
    gen_server:cast(?GUILD_PROCESS, {'kick_out_from_guild', PS, GuildId, ObjPlayerId}).


check_player_guild_info(PS, GuildId) ->
    gen_server:cast(?GUILD_PROCESS, {'check_player_guild_info', PS, GuildId}).    

try_update_battle_power(PS) ->
    case player:get_guild_id(PS) of
        ?INVALID_ID -> skip;
        GuildId ->
            gen_server:cast(?GUILD_PROCESS, {'update_battle_power', GuildId})
    end.


notify_guild_dungeon_begin() ->
    ?INFO_MSG("mod_guild_mgr:notify_guild_dungeon_begin~n", []),
    gen_server:cast(?GUILD_PROCESS, 'guild_dungeon_begin').
   
add_member_contri(PS, Contribute, LogInfo) ->
    gen_server:cast(?GUILD_PROCESS, {'add_member_contri', PS, Contribute, LogInfo}).     

add_prosper(GuildId, AddValue) ->
    gen_server:cast(?GUILD_PROCESS, {'add_prosper', GuildId, AddValue}).     

add_liveness(GuildId, AddValue) ->
    gen_server:cast(?GUILD_PROCESS, {'add_liveness', GuildId, AddValue}). 


decide_guild_war_group() ->
    gen_server:cast(?GUILD_PROCESS, {'decide_guild_war_group'}).


notify_guild_pre_war_begin() ->
    gen_server:cast(?GUILD_PROCESS, {'notify_guild_pre_war_begin'}).

notify_guild_pre_war_end() ->
    gen_server:cast(?GUILD_PROCESS, {'notify_guild_pre_war_end'}).

notify_guild_war_begin() ->
    gen_server:cast(?GUILD_PROCESS, {'notify_guild_war_begin'}).

notify_guild_war_end() ->
    gen_server:cast(?GUILD_PROCESS, {'notify_guild_war_end'}).


on_guild_war_dun_create(GuildId, [DungeonPid, DungeonNo]) ->
    gen_server:cast(?GUILD_PROCESS, {'on_guild_war_dun_create', GuildId, DungeonPid, DungeonNo}).


test_enter_war_dun(PS) ->
    gen_server:cast(?GUILD_PROCESS, {'test_enter_war_dun', PS}). 


test_get_war_info() ->
    gen_server:cast(?GUILD_PROCESS, {'test_get_war_info'}).   


test_clear_war() ->
    gen_server:cast(?GUILD_PROCESS, {'test_clear_war'}).

reset_counter_and_round() ->
    gen_server:cast(?GUILD_PROCESS, {'reset_counter_and_round'}).    

give_reward_for_activity([Lv, GoodsList, MailTitle, MailContent]) ->
    spawn(fun() -> give_reward_for_activity__([Lv, GoodsList, MailTitle, MailContent]) end);
give_reward_for_activity(_) ->
    ?ERROR_MSG("mod_guild_mgr:give_reward_for_activity error!~n", []),
    skip.

cost_member_contri(PS, Contribute, LogInfo) ->
    case Contribute =< 0 of
        true -> ok;
        false ->
            case catch gen_server:call(?GUILD_PROCESS, {'cost_member_contri', PS, Contribute, LogInfo}) of
                {'EXIT', Reason} ->
                    ?ERROR_MSG("mod_guild_mgr:cost_member_contri(), exit for reason: ~w~n", [Reason]),
                    ?ASSERT(false, Reason),
                    {fail, ?PM_MK_FAIL_SERVER_BUSY};
                ok ->
                    ok;
                _Any ->
                    ?ERROR_MSG("mod_guild_mgr:cost_member_contri(), error!: ~w~n", [_Any]),
                    {fail, ?PM_MK_FAIL_SERVER_BUSY}
            end
    end.

syn_guild_scene(GuildId, NewSceneId) ->
    case catch gen_server:call(?GUILD_PROCESS, {'syn_guild_scene', GuildId, NewSceneId}) of
        {'EXIT', Reason} ->
            ?ERROR_MSG("mod_guild_mgr:syn_guild_scene(), exit for reason: ~w~n", [Reason]),
            ?ASSERT(false, Reason), fail;
        ok ->
            ok;
        _Any ->
            ?ERROR_MSG("mod_guild_mgr:syn_guild_scene(), error!: ~w~n", [_Any]), fail
    end.


%% 调整帮派争霸赛每场次的时间戳
%% OffsetTime 是偏移时间，单位是秒
adjust_guild_war_time(OffsetTime) ->
    gen_server:cast(?GUILD_PROCESS, {'adjust_guild_war_time', OffsetTime}).


% -------------------------------------------------------------------------

start_link() ->
    gen_server:start_link({local, ?GUILD_PROCESS}, ?MODULE, [], []).


init([]) ->
    process_flag(trap_exit, true),

    mod_guild:set_job_schedule(),
    mod_guild:db_load_all_guild_info(),
    update_rank(),

    %% 初始化帮派争霸赛数据
    init_guild_war(),
    %% 检查寨主是否被删除，若删除则解散他的帮派
   % sys_try_disband_guild(),
    NewState = #state{
                    party_open = 0
                },
    {ok, NewState}.


handle_call(Request, From, State) ->
    try
        handle_call_2(Request, From, State)
    catch
        Err:Reason ->
            ?ERROR_MSG("ERR:~p,Reason:~p",[Err,Reason]),
             {reply, error, State}
    end.


handle_call_2({'syn_guild_scene', GuildId, NewSceneId}, _From, State) ->
    case State#state.party_open of
        0 -> skip;
        StartTime -> mod_guild_party:add_first_dishes(GuildId, NewSceneId, StartTime)
    end,
    case mod_guild:get_info(GuildId) of
        null -> skip;
        Guild -> mod_guild:update_guild_to_ets(Guild#guild{scene_id = NewSceneId})
    end,
    {reply, ok, State};


handle_call_2({'cost_member_contri', PS, Contribute, LogInfo}, _From, State) ->
    mod_guild:cost_guild_member_contri(PS, Contribute, LogInfo),
    {reply, ok, State};


handle_call_2({'donate', PS, Contri}, _From, State) ->
    Ret = try_donate(PS, Contri),
    {reply, Ret, State};


handle_call_2({'bid_for_guild_war', PS, Money}, _From, State) ->
    Ret = 
    case ply_guild:check_bid_for_guild_war(PS, Money) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, Guild, GuildMb} ->
            case get_guild_war_round() =:= 0 of
                false ->
                    {fail, ?PM_GUILD_NOT_SIGN_IN_TIME};
                true ->
                    player:cost_money(PS, ?MNY_T_BIND_GAMEMONEY, Money, [?LOG_GUILD_BATTLE, "sign"]),
                    NewGuild = Guild#guild{total_bid = Guild#guild.total_bid + Money, bid_id_list = sets:to_list(sets:from_list([player:id(PS) | Guild#guild.bid_id_list]))},
                    mod_guild:update_guild_to_ets(NewGuild),
                    mod_guild:db_save_guild(NewGuild),

                    NewGuildMb = GuildMb#guild_mb{bid = GuildMb#guild_mb.bid + Money},
                    mod_guild:update_member_to_ets(player:id(PS), NewGuildMb),
                    mod_guild:db_save_member(NewGuildMb),

                    case lib_guild:get_guild_war_from_ets(Guild#guild.id) of
                        null ->
                            GuildWar = #guild_war{
                                guild_id = Guild#guild.id, name = Guild#guild.name, total_bid = Money, battle_power = mod_guild:get_battle_power(NewGuild),
                                bid_id_list = [player:id(PS)]
                                },
                            lib_guild:add_guild_war_to_ets(GuildWar);
                        GuildWar ->
                            NewGuildWar = GuildWar#guild_war
                                {
                                total_bid = GuildWar#guild_war.total_bid + Money, 
                                battle_power = mod_guild:get_battle_power(NewGuild),
                                bid_id_list = sets:to_list(sets:from_list([player:id(PS) | GuildWar#guild_war.bid_id_list]))
                                },
                            lib_guild:update_guild_war_to_ets(NewGuildWar)
                    end,
                    ok
            end
    end,
    {reply, Ret, State};    


handle_call_2(_Request, _From, State) ->
    {reply, State, State}.

handle_cast(Request, State) ->
    try
        handle_cast_2(Request, State)
    catch
        Err:Reason ->
            ?ERROR_MSG("ERR:~p,Reason:~p, ~w",[Err, Reason, erlang:get_stacktrace()]),
            {noreply, State}
    end.


handle_cast_2({'create_guild', PS, GuildName, Brief}, State) ->
    ?TRY_CATCH(try_create_guild(PS, GuildName, Brief), ErrReason),
    {noreply, State};


handle_cast_2({'handle_guild_apply', PS, PlayerId, Choise}, State) ->
    ?TRY_CATCH(do_handle_guild_apply(PS, PlayerId, Choise), ErrReason),
    {noreply, State};


handle_cast_2({'reply_invite', PS, GuildId, Choise}, State) ->
    ?TRY_CATCH(try_reply_invite(PS, GuildId, Choise), ErrReason),
    {noreply, State};


handle_cast_2('on_guild_job_schedule', State) ->
    ?CRITICAL_MSG("[mod_guild_mgr] on_job_schedule... ~n", []),
    ?TRY_CATCH(mod_guild:on_job_schedule(), ErrReason),
    {noreply, State};


handle_cast_2('update_guild_rank', State) ->
    ?TRY_CATCH(update_rank(), ErrReason),
    {noreply, State};    

handle_cast_2({'refresh_script', ScriptList, sys}, State) ->
    % ?INFO_MSG("[mod_guild_mgr] refresh_script... ~n", []),
    case State#state.party_open =:= 0 of
        true -> 
            ?ERROR_MSG("[mod_guild_mgr] refresh_script, but Party is not opened! ~n", []),
            skip;
        false -> 
            GuildList = mod_guild:get_guild_list(),
            F = fun(Guild, Acc) ->
                case Guild#guild.scene_id =:= ?INVALID_ID of
                    true -> Acc;
                    false -> [{Guild#guild.id, Guild#guild.scene_id} | Acc]
                end
            end,
            InfoList = lists:foldl(F, [], GuildList),
            mod_guild_party:refresh_script(ScriptList, InfoList)
    end,

    {noreply, State};    


handle_cast_2('guild_party_begin', State) ->
    ?INFO_MSG("mod_guild_mgr:guild_party_begin() ... ~n", []),
    Now = svr_clock:get_unixtime(),

    mod_guild_party:start_link(Now),

    GuildList = mod_guild:get_guild_list(),

    [mod_guild_party:add_first_dishes(Guild#guild.id, Guild#guild.scene_id, Now) || Guild <- GuildList],

    {noreply, State#state{party_open = Now}};  


%% 测试用
handle_cast_2({'guild_party_begin', Interval}, State) ->
    GuildList = mod_guild:get_guild_list(),
    Now = svr_clock:get_unixtime(),
    mod_guild_party:start_link(Now),

    [mod_guild_party:add_first_dishes(Guild#guild.id, Guild#guild.scene_id, Now) || Guild <- GuildList],

    [mod_guild_party:add_guild_reward_to_player(Guild, true) || Guild <- GuildList],

    mod_sys_jobsch:add_schedule(?JSET_ADD_GUILD_BUFF, Interval, []),

    {noreply, State#state{party_open = Now, add_buff_interval = Interval}};
          

handle_cast_2('guild_party_end', State) ->
    GuildList = mod_guild:get_guild_list(),    
    [mod_guild_party:del_guild_dishes_and_mons(Guild#guild.id, Guild#guild.scene_id) || Guild <- GuildList],

    mod_guild_party:stop(),

    {noreply, State#state{party_open = 0}};  


handle_cast_2({'add_guild_buff', Interval}, State) ->
    case State#state.party_open =:= 0 of
        true -> 
            skip;
        false -> 
            GuildList = mod_guild:get_guild_list(),
            [mod_guild_party:add_guild_reward_to_player(Guild, true) || Guild <- GuildList],
            mod_sys_jobsch:add_schedule(?JSET_ADD_GUILD_BUFF, Interval, [])
    end,
    {noreply, State#state{add_buff_interval = Interval}};


handle_cast_2('add_guild_buff', State) ->
    case State#state.party_open =:= 0 of
        true -> 
            skip;
        false -> 
            GuildList = mod_guild:get_guild_list(),
            [mod_guild_party:add_guild_reward_to_player(Guild, false) || Guild <- GuildList],
            case State#state.add_buff_interval > 0 of
                true -> mod_sys_jobsch:add_schedule(?JSET_ADD_GUILD_BUFF, State#state.add_buff_interval, []);
                false -> skip
            end
    end,
    {noreply, State};


handle_cast_2('guild_dungeon_begin', State) ->
    GuildList = mod_guild:get_guild_list(),
    ets:delete_all_objects(?ETS_GUILD_DUNGEON),
    [create_guild_dungeon(Guild) || Guild <- GuildList, Guild#guild.lv >= ?GUILD_DUNGEON_OPEN_LV],
    {noreply, State};    

handle_cast_2({'quit_guild', PS, GuildId}, State) ->
    ?TRY_CATCH(try_quit_guild(PS, GuildId), ErrReason),
    {noreply, State};  

handle_cast_2({'kick_out_from_guild', PS, GuildId, ObjPlayerId}, State) ->
    ?TRY_CATCH(try_kick_out_from_guild(PS, GuildId, ObjPlayerId), ErrReason),
    {noreply, State};      


handle_cast_2({'modify_guild_tenet', PS, GuildId, Tenet}, State) ->
    ?TRY_CATCH(try_modify_guild_tenet(PS, GuildId, Tenet), ErrReason),
    {noreply, State};


handle_cast_2({'appoint_position', PS, ObjPlayerId, Position}, State) ->
    ?TRY_CATCH(try_appoint_position(PS, ObjPlayerId, Position), ErrReason),
    {noreply, State};    


handle_cast_2({'disband_guild', PS, GuildId}, State) ->
    ?TRY_CATCH(try_disband_guild(PS, GuildId), ErrReason),
    {noreply, State};  


handle_cast_2({'get_guild_pay', PS, Type}, State) ->
    ?TRY_CATCH(try_get_guild_pay(PS, Type), ErrReason),
    {noreply, State};

handle_cast_2({'add_member_contri', PS, Contribute, LogInfo}, State) ->
    mod_guild:add_guild_member_contri1(PS, Contribute, LogInfo),
    {noreply, State};    

handle_cast_2({'add_prosper', GuildId, AddValue}, State) ->
    mod_guild:add_prosper(GuildId, AddValue),
    {noreply, State};  

handle_cast_2({'add_liveness', GuildId, AddValue}, State) ->
    mod_guild:add_liveness(GuildId, AddValue),
    {noreply, State};        

%% 帮派战一个轮回的第一周周五0点确定比赛分组和比赛时间
handle_cast_2({'decide_guild_war_group'}, State) ->
    ?INFO_MSG("mod_guild_mgr：msg: decide_guild_war_group begin~n", []),
    case get_guild_war_round() =:= 0 of
        false -> 
            ?ASSERT(false),
            ?ERROR_MSG("mod_guild_mgr：msg: decide_guild_war_group begin error!~n", []);
        true ->
            Fs = fun(G1, G2) -> 
                if
                    G1#guild_war.total_bid > G2#guild_war.total_bid ->
                        true;
                    G1#guild_war.total_bid < G2#guild_war.total_bid ->
                        false;
                    true ->
                        B1 = mod_guild:get_battle_power(G1#guild_war.guild_id),
                        B2 = mod_guild:get_battle_power(G2#guild_war.guild_id),
                        B1 >= B2
                end
            end,

            TGuildList = lists:sort(Fs, ets:tab2list(?ETS_GUILD_WAR)),
            GuildList = lists:sublist(TGuildList, 10),
            case length(GuildList) < 4 of
                true -> 
                    refund_to_player(GuildList, guild_cnt_limit),
                    reset_guild_bid_data();
                false ->
                    MinBid = get_guild_war_min_bid(),
                    F = fun(Guildwar, Acc) ->
                        case Guildwar#guild_war.total_bid >= MinBid of
                            true -> [Guildwar | Acc];
                            false -> Acc
                        end
                    end,
                    JoinList = lists:foldl(F, [], GuildList),
                    case length(JoinList) < 4 of
                        true -> 
                            refund_to_player(TGuildList, guild_cnt_limit),
                            reset_guild_bid_data();
                        false ->
                            set_guild_war_group(mk_guild_war_group(JoinList)),
                            decide_guild_war_round(),
                            decide_guild_war_time(),
                            set_guild_war_counter(0),
                            set_guild_war_min_bid(mk_war_min_bid()),
                            db_save_guild_war(),

                            %% 记录日志
                            statis_guild_bid_ok_log(JoinList),

                            %% 返回没有中标的
                            refund_to_player(TGuildList -- JoinList, bid_cnt_limit)
                            % reset_guild_mb_bid_data(JoinList)  %% 改成比赛结束 或者没有比赛时清空 
                    end
            end
    end,

    {noreply, State};            


handle_cast_2({'apply_join_guild', PS, GuildId, Type}, State) ->
    ?TRY_CATCH(try_apply_join_guild(PS, GuildId, Type), ErrReason),
    {noreply, State};    

handle_cast_2({'record_login_player', PlayerId, GuildId}, State) ->
    case mod_guild:get_info(GuildId) of
        null -> skip;
        Guild ->
            case lists:member(PlayerId, Guild#guild.login_id_list) of
                true -> skip;
                false ->
                    NewLoginList = [PlayerId | Guild#guild.login_id_list],
                    NewGuild = Guild#guild{login_id_list = NewLoginList},
                    mod_guild:update_guild_to_ets(NewGuild)
            end
    end,
    {noreply, State};  


handle_cast_2({'db_maybe_load_guild_info', PlayerId, GuildId}, State) ->
    case mod_guild:get_member_info(PlayerId) =:= null of
        false -> skip;
        true ->
            mod_guild:db_load_members_info(GuildId),
            mod_guild:try_record_login_player(PlayerId, GuildId)
    end,
    {noreply, State};      


handle_cast_2({'check_player_guild_info', PS, GuildId}, State) ->
    GuildId1 = mod_guild:correct_guild_id(player:id(PS), GuildId),
    case GuildId =:= GuildId1 of
        true -> skip;
        false -> 
            ?WARNING_MSG("mod_guild_mgr:check_player_guild_info find guild data error and correct, PlayerId:~p, GuildId:~p, GuildId1:~p~n", [player:id(PS), GuildId, GuildId1]),
            player:set_guild_id(PS, GuildId1)
    end,

    %% 同步玩家等级到帮派成员数据
    case GuildId1 =:= ?INVALID_ID of
        true -> skip;
        false ->
            case mod_guild:get_member_info(player:id(PS)) of
                null -> skip;
                GuildMb ->
                    case GuildMb#guild_mb.lv =:= player:get_lv(PS) andalso GuildMb#guild_mb.name =:= player:get_name(PS) of
                        true -> skip;
                        false ->
                            mod_guild:update_member_to_ets(player:id(PS), GuildMb#guild_mb{lv = player:get_lv(PS), name = player:get_name(PS), is_dirty = true})
                    end
            end
    end,

    {noreply, State};


handle_cast_2({'modify_mb_name', PS}, State) ->
    case player:get_guild_id(PS) of
        ?INVALID_ID -> skip;
        GuildId ->
            case mod_guild:get_member_info(player:id(PS)) of
                null -> skip;
                GuildMb -> 
                    mod_guild:update_member_to_ets(player:id(PS), GuildMb#guild_mb{name = player:get_name(PS), is_dirty = true}),
                    case mod_guild:get_info(GuildId) of
                        null -> skip;
                        Guild ->
                            DonateRank = Guild#guild.donate_rank,
                            case lists:keyfind(GuildMb#guild_mb.name, 1, DonateRank) of
                                false -> skip;
                                {_Name, _Donate} -> 
                                    DonateRank1 = lists:keyreplace(GuildMb#guild_mb.name, 1, DonateRank, {player:get_name(PS), GuildMb#guild_mb.donate_total}),
                                    Guild1 = Guild#guild{donate_rank = DonateRank1},
                                    mod_guild:update_guild_to_ets(Guild1)
                            end
                    end
            end
    end,

    {noreply, State};    
    

handle_cast_2({'update_battle_power', GuildId}, State) ->
    ?TRY_CATCH(do_update_battle_power(GuildId), ErrReason),
    {noreply, State};          


handle_cast_2({'get_guild_war_group', PS}, State) ->
    Round = get_guild_war_round(),
    FirstGuildName = 
        case lists:keyfind(1, 1, get_guild_war_last_rank()) of
            false -> <<>>;
            {_Rank, _GuildId, _TotalBid, GuildName} -> GuildName
        end,

    {ok, BinData} = pt_40:write(?PM_GUILD_BATTLE_GROUP, [Round, get_guild_war_time(), FirstGuildName, get_guild_war_group()]),
    lib_send:send_to_sock(PS, BinData),
    {noreply, State};              


handle_cast_2({'query_sign_in_state', PS}, State) ->
    Round = get_guild_war_round(),
    CanSignIn = 
        case Round =:= 0 andalso util:get_week() =< 4 of
            true -> 1;
            false -> 0
        end,
    ?DEBUG_MSG("query_sign_in_state:~p~n", [CanSignIn]),
    {ok, BinData} = pt_40:write(?PM_GUILD_QRY_SIGE_IN_STATE, [CanSignIn]),
    lib_send:send_to_sock(PS, BinData),
    {noreply, State};


handle_cast_2({'get_guild_mb_bid_list', PS, Guild, GuildMb}, State) ->
    {ok, BinData} = pt_40:write(?PM_GUILD_GET_BID_LIST, [Guild, GuildMb, get_guild_war_min_bid()]),
    lib_send:send_to_sock(PS, BinData),
    {noreply, State};              


handle_cast_2({'notify_guild_pre_war_begin'}, State) ->
    Counter = get_guild_war_counter(),
    Round = get_guild_war_round(),
    Turn = get_guild_war_turn(),
    ?CRITICAL_MSG("mod_guild_mgr:activity notify pre war begin:{Counter,Round,Turn}:~w~n", [{Counter,Round,Turn}]),
    case Counter + 1 =:= Round of
        true -> 
            case util:is_same_day(get_guild_war_time_by_round(Round)) of
                false ->
                    ?ERROR_MSG("mod_guild_mgr:guild war begin time error!Round:~p, WarTime:~p~n", [Round, get_guild_war_time_by_round(Round)]);
                true -> skip
            end,

            GuildIdList = get_join_guild_by_round(Round),
            F = fun({Slot1, GuildId, Slot2, ObjGuildId}) ->
                GuildWar = lib_guild:get_guild_war_from_ets(GuildId),
                ObjGuildWar = lib_guild:get_guild_war_from_ets(ObjGuildId),
                Name = 
                    case GuildWar =:= null of
                        true -> 
                            ?ERROR_MSG("mod_guild_mgr:get_guild_war_from_ets error,GuildId:~p~n", [GuildId]),
                            <<>>;
                        false -> GuildWar#guild_war.name
                    end,
                ObjName = 
                    case ObjGuildWar =:= null of
                        true -> 
                            ?ERROR_MSG("mod_guild_mgr:get_guild_war_from_ets error,ObjGuildId:~p~n", [ObjGuildId]),
                            <<>>;
                        false -> ObjGuildWar#guild_war.name
                    end,

                {ok, Pid} = mod_guild_war:start([Turn, Round, Slot1, GuildId, Name, mod_guild:get_battle_power(GuildId),
                    Slot2, ObjGuildId, ObjName, mod_guild:get_battle_power(ObjGuildId)]),

                case GuildWar =:= null of
                    true ->
                        skip;   %% 此分支正常，当比赛轮回过程，解散了帮派，则可能出现
                    false -> 
                        lib_guild:update_guild_war_to_ets(GuildWar#guild_war{war_handle_pid = Pid, finish = 0})
                end,
                case ObjGuildWar =:= null of
                    true ->
                        skip;
                    false -> 
                        lib_guild:update_guild_war_to_ets(ObjGuildWar#guild_war{war_handle_pid = Pid, finish = 0})
                end,
                ?DEBUG_MSG("create_guild_prepare_dungeon:~p:~p~n", [GuildId, ObjGuildId]),          
                mod_dungeon_manage:create_guild_prepare_dungeon(?DUN_GUILD_PREPAR, GuildId),
                mod_dungeon_manage:create_guild_prepare_dungeon(?DUN_GUILD_PREPAR, ObjGuildId)
            end,
            [F(X) || X <- GuildIdList];
        false -> %% 这轮不用打
            skip
    end,

    set_guild_war_counter(Counter + 1),
    db_save_guild_war(),
    {noreply, State};    


handle_cast_2({'notify_guild_pre_war_end'}, State) ->
    ?INFO_MSG("mod_guild_mgr:activity notify pre war end...~n", []),
    GuildIdList = get_join_guild_by_round(get_guild_war_round()),
    F = fun({_, GuildId, _, ObjGuildId}) ->
        CheckFinish = 
        case lib_guild:get_guild_war_from_ets(GuildId) of
            null ->
                false;
            GuildWar -> 
                case is_pid_ok(GuildWar#guild_war.war_pre_dun_pid) of
                    true ->
                        lib_dungeon:close_dungeon(GuildWar#guild_war.war_pre_dun_pid);
                    false ->
                        skip
                end,

                %% 检查战斗副本是否该结束，针对签到过期了，判断胜负
                case is_pid_ok(GuildWar#guild_war.war_handle_pid) of
                    true ->
                        gen_server:cast(GuildWar#guild_war.war_handle_pid, {'check_finish_war'}),
                        true;
                    false ->
                        false
                end
        end,
        case lib_guild:get_guild_war_from_ets(ObjGuildId) of
            null ->
                skip;
            ObjGuildWar -> 
                case is_pid_ok(ObjGuildWar#guild_war.war_pre_dun_pid) of
                    true ->
                        lib_dungeon:close_dungeon(ObjGuildWar#guild_war.war_pre_dun_pid);
                    false ->
                        skip
                end,
                case CheckFinish of
                    true -> skip;
                    false -> 
                        case is_pid_ok(ObjGuildWar#guild_war.war_handle_pid) of
                            false -> skip;
                            true ->
                                gen_server:cast(ObjGuildWar#guild_war.war_handle_pid, {'check_finish_war'})
                        end
                end
        end
    end,

    [F(X) || X <- GuildIdList],
    {noreply, State};        


handle_cast_2({'notify_guild_war_begin'}, State) ->
    ?INFO_MSG("mod_guild_mgr:activity notify  war begin...~n", []),
    Counter = get_guild_war_counter(),
    case Counter =:= get_guild_war_round() of
        true -> 
            GuildIdList = get_join_guild_by_round(get_guild_war_round()),
            ?DEBUG_MSG("get_join_guild_by_round:~w~n", [GuildIdList]),
            F = fun({_, GuildId, _, ObjGuildId}) ->
                ?DEBUG_MSG("create_guild_battle_dungeon:~p~n", [GuildId]),   
                mod_dungeon_manage:create_guild_battle_dungeon(?DUN_GUILD_BATTLE, GuildId),
                set_guild_war_obj_guild(GuildId, ObjGuildId),
                set_guild_war_obj_guild(ObjGuildId, GuildId)
            end,
            [F(X) || X <- GuildIdList];
        false ->
            skip
    end,
    {noreply, State};            


%% 强制结束比赛，轮数管理
handle_cast_2({'notify_guild_war_end'}, State) ->
    ?INFO_MSG("mod_guild_mgr:activity notify  war end...~n", []),
    Round = get_guild_war_round(),
    GuildIdList = get_join_guild_by_round(Round),
    ?DEBUG_MSG("get_join_guild_by_round:~w~n", [GuildIdList]),
    F = fun({_, GuildId, _, _ObjGuildId}) ->
        case lib_guild:get_guild_war_from_ets(GuildId) of
            null ->
                skip;
            GuildWar -> 
                ?DEBUG_MSG("GuildWar#guild_war.finish:~p~n", [GuildWar#guild_war.finish]),
                case GuildWar#guild_war.finish =:= 1 of
                    true ->
                        case is_pid_ok(GuildWar#guild_war.war_dun_pid) of
                            true ->
                                lib_dungeon:close_dungeon(GuildWar#guild_war.war_dun_pid);
                            false ->
                                skip
                        end;
                    false ->
                        case is_pid_ok(GuildWar#guild_war.war_handle_pid) of
                            true ->
                                gen_server:cast(GuildWar#guild_war.war_handle_pid, {'force_finish_war'});
                            false ->
                                skip
                        end
                end
        end
    end,

    [F(X) || X <- GuildIdList],

    %% 上届因条件不足，没有开启比赛，经过周六周日,需要重新清空计算器
    case get_guild_war_counter() >= 1 andalso get_guild_war_round() =:= 0 of
        true -> set_guild_war_counter(0);
        false -> skip
    end,

    db_save_guild_war(),

    {noreply, State};                


handle_cast_2({'on_guild_war_dun_create', GuildId, DungeonPid, DungeonNo}, State) ->
    ?INFO_MSG("mod_guild_mgr: on_guild_war_dun_create GuildId:~p, DungeonPid:~p, DungeonNo:~p", [GuildId, DungeonPid, DungeonNo]),
    ?ASSERT(is_pid(DungeonPid), DungeonPid),
    case lib_guild:get_guild_war_from_ets(GuildId) of
        null ->
            skip;
        GuildWar ->
            case DungeonNo of
                ?DUN_GUILD_PREPAR ->
                    lib_guild:update_guild_war_to_ets(GuildWar#guild_war{war_pre_dun_pid = DungeonPid});
                ?DUN_GUILD_BATTLE ->
                    lib_guild:update_guild_war_to_ets(GuildWar#guild_war{war_dun_pid = DungeonPid}),
                    ObjGuildId = get_guild_war_obj_guild(GuildId),
                    case lib_guild:get_guild_war_from_ets(ObjGuildId) of
                        null ->
                            skip;
                        ObjGuildWar ->
                            lib_guild:update_guild_war_to_ets(ObjGuildWar#guild_war{war_dun_pid = DungeonPid})
                    end,
                    mod_guild_war:batch_enter_war_dun(GuildWar#guild_war.war_handle_pid, GuildId, ObjGuildId)
            end
    end,

    {noreply, State};                


handle_cast_2({'test_enter_war_dun', PS}, State) ->
    case lib_guild:get_guild_war_from_ets(player:get_guild_id(PS)) of
        null ->
            ?ASSERT(false),
            ?ERROR_MSG("mod_guild_mgr:error!~n", []);
        GuildWar ->
            gen_server:cast(GuildWar#guild_war.war_handle_pid, {'try_enter_war_dungeon', PS})
    end,

    {noreply, State};                    


handle_cast_2({'test_get_war_info'}, State) ->
    io:format("get_guild_war_turn:~w~n", [get_guild_war_turn()]),
    io:format("get_guild_war_group:~w~n", [get_guild_war_group()]),
    io:format("get_guild_war_last_rank:~w~n", [get_guild_war_last_rank()]),
    io:format("get_guild_war_round:~w~n", [get_guild_war_round()]),
    io:format("get_guild_war_counter:~w~n", [get_guild_war_counter()]),
    io:format("get_guild_war_time:~w~n", [get_guild_war_time()]),
    io:format("get_guild_war_min_bid:~p~n", [get_guild_war_min_bid()]),
    
    ?DEBUG_MSG("get_guild_war_turn:~w~n", [get_guild_war_turn()]),
    ?DEBUG_MSG("get_guild_war_group:~w~n", [get_guild_war_group()]),
    ?DEBUG_MSG("get_guild_war_last_rank:~w~n", [get_guild_war_last_rank()]),
    ?DEBUG_MSG("get_guild_war_round:~w~n", [get_guild_war_round()]),
    ?DEBUG_MSG("get_guild_war_counter:~w~n", [get_guild_war_counter()]),
    ?DEBUG_MSG("get_guild_war_time:~w~n", [get_guild_war_time()]),
    ?DEBUG_MSG("get_guild_war_min_bid:~p~n", [get_guild_war_min_bid()]),

    {noreply, State};                    

handle_cast_2({'test_clear_war'}, State) ->
    set_guild_war_counter(0),
    set_guild_war_round(0),
    set_guild_war_group([]),
    set_guild_war_time([]),
    set_guild_war_turn(1),
    db_save_guild_war(),
    {noreply, State};                    


handle_cast_2({'reset_counter_and_round'}, State) ->
    set_guild_war_counter(0),
    set_guild_war_round(0),
    db_save_guild_war(),
    {noreply, State};


handle_cast_2({'war_result', WinGuildId, WinSlot}, State) ->
    handle_war_result(WinGuildId, WinSlot),

    {noreply, State};      


handle_cast_2({'adjust_guild_war_time', OffsetTime}, State) ->
    F = fun({Round, Time}, Acc) ->
        [{Round, Time + OffsetTime} | Acc]
    end,
    TimeL = lists:foldl(F, [], get_guild_war_time()),
    set_guild_war_time(TimeL),
    db_save_guild_war(),
    {noreply, State};          


handle_cast_2({'modify_guild_name', Name, PS}, State) ->
    GuildId = player:get_guild_id(PS),
    case mod_guild:get_info(GuildId) of
        null -> skip;
        Guild ->
            Guild1 = Guild#guild{name = list_to_binary(Name)},
            mod_guild:update_guild_to_ets(Guild1),
            mod_guild:db_save_guild(Guild1),
            ply_guild:cache_map_of_guild_id_to_guild_name(GuildId, Guild1#guild.name),
            
            mod_broadcast:send_sys_broadcast(132, [player:get_name(PS), player:id(PS), Guild#guild.name, Guild1#guild.name]),
            spawn(fun() -> notify_to_all(Guild1#guild.member_id_list, Guild#guild.name, Guild1#guild.name) end)
    end,

    {noreply, State};


handle_cast_2(_Msg, State) ->
    {noreply, State}.


handle_info(Request, State) ->
    try
        handle_info_2(Request, State)
    catch
        Err:Reason->
            ?ERROR_MSG("ERR:~p,Reason:~p",[Err,Reason]),
             {noreply, State}
    end.

handle_info_2(_Info, State) ->
    {noreply, State}.

terminate(Reason, _State) ->
    case Reason of
        normal -> skip;
        shutdown -> skip;
        _ -> ?ERROR_MSG("[mod_guild_mgr] !!!!!terminate!!!!! for reason: ~w", [Reason])
    end,
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

% %%-------------------------------------------------------------------------------------------------

do_update_battle_power(GuildId) ->
    case mod_guild:get_info(GuildId) of
        null -> skip;
        Guild ->
            Guild1 = Guild#guild{battle_power = mod_guild:calc_battle_power(Guild)},
            mod_guild:update_guild_to_ets(Guild1)
    end.


try_apply_join_guild(PS, GuildId, Type) ->
    case ply_guild:apply_join_guild(PS, GuildId) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        ok ->
            {ok, BinData} = pt_40:write(?PT_APPLY_JOIN_GUILD, [Type]),
            lib_send:send_to_sock(PS, BinData);
        {ok, _} ->
            ok
    end.

try_donate(PS, Contri) ->
    case ply_guild:donate(PS, Contri) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, AddProsper, NewPS} ->
            {ok, AddProsper, NewPS}
    end.


try_get_guild_pay(PS, Type) ->
    case ply_guild:get_guild_pay(PS, Type) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        ok ->
            {ok, BinData} = pt_40:write(?PT_GET_GUILD_PAY, [?RES_OK, Type]),
            lib_send:send_to_sock(PS, BinData)
    end.

try_disband_guild(PS, GuildId) ->
    case check_disband_guild(PS, GuildId) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        {ok, Guild} ->
            do_disband_guild(PS, Guild),
            {ok, BinData} = pt_40:write(?PT_DISBAND_GUILD, [?RES_OK]),
            lib_send:send_to_sock(PS, BinData)
    end.


check_disband_guild(PS, GuildId) ->
    case mod_guild:get_info(GuildId) of
        null ->
            {fail, ?PM_GUILD_NOT_EXISTS};
        Guild ->
            case Guild#guild.chief_id =:= player:get_id(PS) of
                false ->
                    {fail, ?PM_GUILD_POWER_LIMIT};
                true ->
                    case war_allow_disband(GuildId) of
                        true ->
                            {ok, Guild};
                        false ->
                            {fail, ?PM_GUILD_WAR_ING}
                    end
            end
    end.

%% 已经中标的帮派暂时不允许解散
war_allow_disband(GuildId) ->
    case lib_guild:get_guild_war_from_ets(GuildId) of
        null -> 
            ?DEBUG_MSG("mod_guild_mgr:war_allow_disband not sign..~n", []),
            true;
        _Guildwar ->
            Round = get_guild_war_round(),
            case lists:keyfind(19, 1, get_guild_war_group()) of
                false -> 
                    ?DEBUG_MSG("mod_guild_mgr:war_allow_disband not have group..~n", []),
                    true;
                {_, GuildId_1, _} -> 
                    case GuildId_1 =:= ?INVALID_ID of
                        false -> 
                            ?DEBUG_MSG("mod_guild_mgr:war_allow_disband turn over..~n", []),
                            true;
                        true -> 
                            F = fun(X, AccL) ->
                                lists:foldl(fun({_, Id1, _, Id2}, Acc) -> [Id1, Id2] ++ Acc end, [], get_join_guild_by_round(X)) ++ AccL
                            end,
                            GuildIdL = lists:foldl(F, [], lists:seq(Round, 4)),
                            ?DEBUG_MSG("mod_guild_mgr:war_allow_disband GuildId:~p, GuildIdL:~w ~n", [GuildId, GuildIdL]),
                            case lists:member(GuildId, GuildIdL) of
                                true -> false;
                                false -> true
                            end
                    end
            end
    end.


%% 解散帮派
do_disband_guild(PS, Guild) ->
    %% 优先返还相关的投标信息
    case lib_guild:get_guild_war_from_ets(Guild#guild.id) of
        null -> skip;
        Guildwar -> 
            refund_to_player([Guildwar], guild_disband),
            lib_guild:del_guild_war_from_ets(Guild#guild.id)
    end,

    % 清除内存数据
    mod_guild:clear_guild_id_of_member(Guild),

    mod_guild:del_member_from_ets_by_guild(Guild),
    mod_guild:del_guild_from_ets(Guild#guild.id),
    % 清除数据库数据
    mod_guild:db_delete_guild(Guild#guild.id),
    mod_guild:db_delete_guild_member_by_guild_id(Guild#guild.id),

    notify_guild_disband(Guild),

    %% 全部在帮派地图成员应该会立即传送出地图;
    %% 所有成员应该移除自身身上所有拥有的帮派任务 ??
    SceneCfg = mod_scene_tpl:get_tpl_data(?GUILD_ENTER_SCENE_NO),
    NpcList = mod_scene_tpl:get_cfg_static_npc_list(SceneCfg),
    {ToX, ToY} =
        case lists:keyfind(?GUILD_ENTER_NPC_NO, 1, NpcList) of
            false -> %% 容错
                ?ASSERT(false, {?GUILD_ENTER_NPC_NO, NpcList}),
                {10, 20};
            {_SceneNo, TX, TY} ->
                {TX, TY}
        end,

    F = fun(Id) ->
        case player:get_PS(Id) of
            null -> skip;
            TargetPS ->
			    case lib_scene:is_guild_dungeon_scene(player:get_scene_id(TargetPS)) of
					true ->
						GuildSceneId = player:get_scene_id(TargetPS),
						GuildIdList = lib_scene:get_scene_player_ids(GuildSceneId),
						F2 = fun(X2) ->
									 case player:is_battling(player:get_PS(X2)) of
										 true -> catch mod_battle:force_end_battle(player:get_PS(X2));
										 false -> skip
									 end,
									 lib_dungeon:quit_dungeon(player:get_PS(X2))
							 end,
						lists:foreach(F2,GuildIdList ),
						mod_scene:clear_scene(GuildSceneId);
					false ->
						skip
				end,
				mod_guild_dungeon:del_guild_person_from_ets(Id),
				%更新玩家帮派副本个人数据
				db:update(guild_dungeon_data, 
						  [{guild_id,0}, {contribution, util:term_to_bitstring([])}, {collection, 0},
						   {kill_count,0}, {damage_value, 0} ] , [{player_id, Id }] ),
				db:delete(guild_dungeon, [{guild_id,Guild#guild.id}]),
                NowScenNo = player:get_scene_no(TargetPS),
                case mod_scene_tpl:get_scene_type(NowScenNo) =:= ?SCENE_T_GUILD of
                    true ->
                        ply_scene:do_teleport(TargetPS, ?GUILD_ENTER_SCENE_NO, ToX, ToY);
                    false ->
                        skip
                end
        end
    end,
    [F(X) || X <- Guild#guild.member_id_list, player:is_online(X)],
	
	SQL = "UPDATE guild_dungeon_data SET guild_id = 0 ,contribution = '[]',collection = 0,kill_count=0,damage_value = 0 WHERE guild_id = " 
			  ++ Guild#guild.id,
	db:update(guild_dungeon_data, SQL),
	
    %% 清除帮派场景
    case Guild#guild.scene_id =:= ?INVALID_ID of
        true -> skip;
        false ->
            case lib_scene:get_obj(Guild#guild.scene_id) of
                null ->
                    ?ASSERT(false, Guild#guild.scene_id);
                _SceneObj ->
                    mod_scene:clear_scene(Guild#guild.scene_id)
            end
    end,

    mod_guild_mgr:update_guild_rank(),
    lib_log:statis_guild_diss(player:id(PS), player:get_lv(PS), Guild#guild.id, Guild#guild.lv),
    ok.


try_modify_guild_tenet(PS, GuildId, Tenet) ->
    case check_modify_guild_tenet(PS, GuildId, Tenet) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        {ok, Guild} ->
            do_modify_guild_tenet(PS, Guild, Tenet),
            {ok, BinData} = pt_40:write(?MODIFY_GUILD_TENET, [?RES_OK]),
            lib_send:send_to_sock(PS, BinData)
    end.


check_modify_guild_tenet(PS, GuildId, Tenet) ->
    case mod_guild:get_info(GuildId) of
        null ->
            {fail, ?PM_GUILD_NOT_EXISTS};
        Guild ->
            CounsellorList = mod_guild:get_counsellor_id_list(Guild),
            case (not mod_guild:is_chief(PS)) andalso (not lists:member(player:get_id(PS), CounsellorList)) of
                true ->
                    {fail, ?PM_GUILD_POWER_LIMIT};
                false ->
                    case mod_guild:is_guild_brief_valid(Tenet) of
                        {false, len_error} ->
                            {fail, ?PM_GUILD_BRIEF_LEN_ERROR};
                        {false, char_illegal} ->
                            {fail, ?PM_GUILD_BRIEF_CHAR_ILLEGEL};
                        true ->
                            {ok, Guild}
                    end
            end
    end.


do_modify_guild_tenet(_PS, Guild, Tenet) ->
    ?ASSERT(Guild /= null),
    NewGuild = Guild#guild{brief = list_to_binary(Tenet)},
    mod_guild:update_guild_to_ets(NewGuild),
    % mod_guild:db_save_guild(NewGuild),
    ok.


try_appoint_position(PS, ObjPlayerId, Position) ->
    case check_appoint_position(PS, ObjPlayerId, Position) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        {ok, Guild, ObjGuildMb} ->
            do_appoint_position(PS, ObjPlayerId, Position, Guild, ObjGuildMb),
            {ok, BinData} = pt_40:write(?APPOINT_GUILD_POSITION, [?RES_OK, ObjPlayerId, Position]),
            lib_send:send_to_sock(PS, BinData)  
    end.


check_appoint_position(PS, ObjPlayerId, Position) ->
    try check_appoint_position__(PS, ObjPlayerId, Position) of
        {ok, Guild, ObjGuildMb} ->
            {ok, Guild, ObjGuildMb}
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.


check_appoint_position__(PS, ObjPlayerId, Position) ->
    GuildId = player:get_guild_id(PS),
    Guild = mod_guild:get_info(GuildId),
    ?Ifc (Guild =:= null)
        throw(?PM_GUILD_NOT_EXISTS)
    ?End,

    GuildLv = mod_guild:get_lv(Guild),
    SelfPos = mod_guild:get_guild_pos(PS),

    ObjPlayerPos = mod_guild:get_guild_pos(ObjPlayerId),

    ?Ifc (GuildId =:= 0)
        throw(?PM_NOT_IN_GUILD)
    ?End,

    ?Ifc (ObjPlayerPos =:= Position)
        throw(?PM_GUILD_APPOINT_POSITION_OK)
    ?End,

    ObjGuildMb = mod_guild:get_member_info(ObjPlayerId),
    ?Ifc (ObjGuildMb =:= null)
        throw(?PM_NOT_IN_GUILD)
    ?End,

    ?Ifc(ObjPlayerPos < SelfPos)
        throw(?PM_GUILD_POWER_LIMIT)
    ?End,

    ?Ifc (SelfPos /= ?GUILD_POS_CHIEF andalso SelfPos /= ?GUILD_POS_COUNSELLOR)
        throw(?PM_GUILD_POWER_LIMIT)
    ?End,


    %% 操作者不可以将 被设置者 设置成高于或者同于自身职位 帮主禅让职位除外 注意：Position越小职位越高
    ?Ifc (Position =< SelfPos andalso SelfPos =/= ?GUILD_POS_CHIEF)
        throw(?PM_GUILD_POWER_LIMIT)
    ?End,

    ?Ifc (player:is_online(ObjPlayerId) andalso (not player:is_in_guild(ObjPlayerId)))
        throw(?PM_NOT_IN_GUILD)
    ?End,

    Data = data_guild_lv:get(GuildLv),
    ?Ifc (Position =:= ?GUILD_POS_COUNSELLOR andalso mod_guild:get_member_count_of_pos(GuildId, Position) >= Data#guild_lv_data.counsellor_max)
        throw(?PM_POS_MEMBER_COUNT_LIMIT)
    ?End,

    ?Ifc (Position =:= ?GUILD_POS_SHAOZHANG andalso mod_guild:get_member_count_of_pos(GuildId, Position) >= Data#guild_lv_data.shaozhang_max)
        throw(?PM_POS_MEMBER_COUNT_LIMIT)
    ?End,
    {ok, Guild, ObjGuildMb}.


do_appoint_position(PS, ObjPlayerId, Position, Guild, ObjGuildMb) ->
    ?ASSERT(Guild /= null),
    NewGuild =
    case Position of
        ?GUILD_POS_CHIEF ->
            Chiefame = ObjGuildMb#guild_mb.name,
            lib_offcast:cast(player:id(PS), {del_title, ?GUILD_TITLE_NO_CHIEF}),
            lib_offcast:cast(player:id(PS), {add_title, ?GUILD_TITLE_NO_NORMAL_MEMBER, svr_clock:get_unixtime()}),
            case lists:member(ObjPlayerId, Guild#guild.counsellor_id_list) of
                true ->
                    Guild#guild{chief_id = ObjPlayerId, chief_name = Chiefame, 
                    counsellor_id_list = sets:to_list(sets:from_list(Guild#guild.counsellor_id_list -- [ObjPlayerId]))};
                false ->
                    case lists:member(ObjPlayerId, Guild#guild.shaozhang_id_list) of
                        true ->
                            Guild#guild{chief_id = ObjPlayerId, chief_name = Chiefame, 
                            shaozhang_id_list = sets:to_list(sets:from_list(Guild#guild.shaozhang_id_list -- [ObjPlayerId]))};
                        false ->
                            Guild#guild{chief_id = ObjPlayerId, chief_name = Chiefame}
                    end
            end;
        ?GUILD_POS_COUNSELLOR ->
            case lists:member(ObjPlayerId, Guild#guild.shaozhang_id_list) of
                false ->
                    Guild#guild{counsellor_id_list = sets:to_list(sets:from_list([ObjPlayerId] ++ Guild#guild.counsellor_id_list))};
                true ->
                    Guild#guild{counsellor_id_list = sets:to_list(sets:from_list([ObjPlayerId] ++ Guild#guild.counsellor_id_list)), 
                    shaozhang_id_list = sets:to_list(sets:from_list(Guild#guild.shaozhang_id_list -- [ObjPlayerId]))}
            end;
        ?GUILD_POS_SHAOZHANG ->
            case lists:member(ObjPlayerId, Guild#guild.counsellor_id_list) of
                false ->
                    Guild#guild{shaozhang_id_list = sets:to_list(sets:from_list([ObjPlayerId] ++ Guild#guild.shaozhang_id_list))};
                true ->
                    Guild#guild{shaozhang_id_list = sets:to_list(sets:from_list([ObjPlayerId] ++ Guild#guild.shaozhang_id_list)), 
                    counsellor_id_list = sets:to_list(sets:from_list(Guild#guild.counsellor_id_list -- [ObjPlayerId]))}
            end;
        ?GUILD_POS_NORMAL_MEMBER ->
            case lists:member(ObjPlayerId, Guild#guild.counsellor_id_list) of
                true ->
                    Guild#guild{counsellor_id_list = sets:to_list(sets:from_list(Guild#guild.counsellor_id_list -- [ObjPlayerId]))};
                false ->
                    case lists:member(ObjPlayerId, Guild#guild.shaozhang_id_list) of
                        true ->
                            Guild#guild{shaozhang_id_list = sets:to_list(sets:from_list(Guild#guild.shaozhang_id_list -- [ObjPlayerId]))};
                        false ->
                            Guild
                    end
            end
    end,
    mod_guild:update_guild_to_ets(NewGuild),
    mod_guild:db_save_guild(NewGuild),
    mod_guild:update_member_to_ets(ObjPlayerId, ObjGuildMb#guild_mb{position = Position}),

    case Position =:= ?GUILD_POS_CHIEF of %% 禅让帮主
        false -> skip;
        true ->
            case mod_guild:get_member_info(player:id(PS)) of
                null -> skip;
                OldChiefMb -> mod_guild:update_member_to_ets(player:id(PS), OldChiefMb#guild_mb{position = ?GUILD_POS_NORMAL_MEMBER})
            end
    end,

    OpPos = mod_guild:decide_guild_pos(player:id(PS), Guild),
    OpName = player:get_name(PS),
    OpedName = ObjGuildMb#guild_mb.name,
    OpedPrePos = mod_guild:decide_guild_pos(ObjPlayerId, Guild),
    OpedNowPos = mod_guild:decide_guild_pos(ObjPlayerId, NewGuild),

    case OpedPrePos of
        ?GUILD_POS_CHIEF -> skip;
        ?GUILD_POS_COUNSELLOR -> lib_offcast:cast(ObjPlayerId, {del_title, ?GUILD_TITLE_NO_COUNSELLOR});
        ?GUILD_POS_SHAOZHANG -> lib_offcast:cast(ObjPlayerId, {del_title, ?GUILD_TITLE_NO_SHAOZHANG});
        ?GUILD_POS_NORMAL_MEMBER -> skip
    end,

    TitleNo = 
        case Position of
            ?GUILD_POS_CHIEF ->
                ?GUILD_TITLE_NO_CHIEF;
            ?GUILD_POS_COUNSELLOR ->
                ?GUILD_TITLE_NO_COUNSELLOR;
            ?GUILD_POS_SHAOZHANG ->
                ?GUILD_TITLE_NO_SHAOZHANG;
            ?GUILD_POS_NORMAL_MEMBER ->
                ?GUILD_TITLE_NO_NORMAL_MEMBER;
            _ -> ?ASSERT(false)
        end,

    lib_offcast:cast(ObjPlayerId, {add_title, TitleNo, svr_clock:get_unixtime()}),

    notify_guild_member_pos_change(Guild, OpPos, OpName, OpedName, OpedPrePos, OpedNowPos),
    case Position =:= ?GUILD_POS_CHIEF of
        true ->
            F = fun(X) ->
                case player:get_PS(X) of
                    null -> skip;
                    TPS -> player:notify_cli_info_change_2(TPS, ?OI_CODE_GUILD_CHIEF_ID, ObjPlayerId)
                end
            end,
            [F(X) || X <- Guild#guild.member_id_list];
        false -> skip
    end,
    ok.



try_kick_out_from_guild(PS, GuildId, ObjPlayerId) ->
    case check_kick_out_from_guild(PS, GuildId, ObjPlayerId) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        {ok, Guild} ->
            do_kick_out_from_guild(PS, Guild, ObjPlayerId),
            {ok, BinData} = pt_40:write(?PT_KICK_OUT_FROM_GUILD, [?RES_OK]),
            lib_send:send_to_sock(PS, BinData)
    end.


check_kick_out_from_guild(PS, GuildId, ObjPlayerId) ->
    try check_kick_out_from_guild__(PS, GuildId, ObjPlayerId) of
        {ok, Guild} ->
            {ok, Guild}
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.


check_kick_out_from_guild__(PS, GuildId, ObjPlayerId) ->
    Guild = mod_guild:get_info(GuildId),
    ?Ifc (Guild =:= null)
        throw(?PM_GUILD_NOT_EXISTS)
    ?End,

    ?Ifc (player:get_guild_id(PS) /= GuildId)
        throw(?PM_PARA_ERROR)
    ?End,

    ?Ifc (Guild#guild.chief_id =:= ObjPlayerId andalso ObjPlayerId =/= player:id(PS))
        throw(?PM_GUILD_POWER_LIMIT)
    ?End,

    CounsellorList = mod_guild:get_counsellor_id_list(Guild),
    ?Ifc ( (not mod_guild:is_chief(PS)) andalso (not lists:member(player:get_id(PS), CounsellorList)) )
        throw(?PM_GUILD_POWER_LIMIT)
    ?End,

    ObjPS = player:get_PS(ObjPlayerId),
    ?Ifc (player:is_online(ObjPlayerId) andalso not player:is_in_guild(ObjPS))
        throw(?PM_NOT_IN_GUILD)
    ?End,

    ?Ifc (ObjPS =/= null andalso lib_dungeon:is_in_guild_prepare_dungeon(ObjPS))
        throw(?PM_GUILD_IN_WAR)
    ?End,

    ?Ifc (ObjPS =/= null andalso lib_dungeon:is_in_guild_battle_dungeon(ObjPS))
        throw(?PM_GUILD_IN_WAR)
    ?End,

    case mod_guild:get_member_info(ObjPlayerId) of
        null -> throw(?PM_UNKNOWN_ERR);
        _Mb -> {ok, Guild}
    end.


do_kick_out_from_guild(PS, Guild, ObjPlayerId) ->
    ?ASSERT(Guild /= null),
    Mb = mod_guild:get_member_info(ObjPlayerId),
    NewMemberList = Guild#guild.member_id_list -- [ObjPlayerId],

    OldTitleNo = 
        case mod_guild:decide_guild_pos(ObjPlayerId, Guild) of
            ?GUILD_POS_CHIEF -> ?GUILD_TITLE_NO_CHIEF;
            ?GUILD_POS_COUNSELLOR -> ?GUILD_TITLE_NO_COUNSELLOR;
            ?GUILD_POS_SHAOZHANG -> ?GUILD_TITLE_NO_SHAOZHANG;
            ?GUILD_POS_NORMAL_MEMBER -> ?GUILD_TITLE_NO_NORMAL_MEMBER;
            _ -> ?ASSERT(false), ?INVALID_NO
        end,

    %% 去除职位
    NewCounsellorIdL =
        case lists:member(ObjPlayerId, Guild#guild.counsellor_id_list) of
            true -> Guild#guild.counsellor_id_list -- [ObjPlayerId];
            false -> Guild#guild.counsellor_id_list
        end,
    NewShaozhangIdL =
        case lists:member(ObjPlayerId, Guild#guild.shaozhang_id_list) of
            true -> Guild#guild.shaozhang_id_list -- [ObjPlayerId];
            false -> Guild#guild.shaozhang_id_list
        end,

    NewGuild = Guild#guild{member_id_list = NewMemberList, counsellor_id_list = NewCounsellorIdL, shaozhang_id_list = NewShaozhangIdL},
    NewGuild1 = NewGuild#guild{battle_power = mod_guild:calc_battle_power(NewGuild)},

    NewGuild2 = handle_bid_for_leave_guild(NewGuild1, ObjPlayerId),

    mod_guild:update_guild_to_ets(NewGuild2),
    mod_guild:db_save_guild(NewGuild2),

    mod_guild:del_member_from_ets_by_mb_id(ObjPlayerId),
    mod_guild:db_delete_guild_member_by_mb_id(ObjPlayerId),

    mod_guild:db_save_guild_id(ObjPlayerId, ?INVALID_ID),
    case player:is_online(ObjPlayerId) of
        true ->
            player:set_guild_id(ObjPlayerId, ?INVALID_ID);
        false -> % 改变离线玩家数据
            case player:in_tmplogout_cache(ObjPlayerId) of
                false -> skip;
                true ->
                    TmpLogoutPS = ply_tmplogout_cache:get_tmplogout_PS(ObjPlayerId),
                    ply_tmplogout_cache:set_guild_id(TmpLogoutPS, ?INVALID_ID)
            end
    end,
    OpPos = mod_guild:decide_guild_pos(player:id(PS), Guild),
    OpName = player:get_name(PS),
    OpedName = Mb#guild_mb.name,

    lib_offcast:cast(ObjPlayerId, {del_title, ?GUILD_TITLE_NO_NORMAL_MEMBER}),
    lib_offcast:cast(ObjPlayerId, {del_title, ?GUILD_TITLE_NO_FIRST_GUILD}),
	
	
	case player:is_online(ObjPlayerId) of
		true ->
			TargetPS = player:get_PS(ObjPlayerId),
			case lib_scene:is_guild_dungeon_scene(player:get_scene_id(TargetPS)) of
				true ->

				
					case player:is_battling(TargetPS) of
						true -> catch mod_battle:force_end_battle(TargetPS);
						false -> skip
					end,
					lib_dungeon:quit_dungeon(TargetPS),
					mod_guild_dungeon:del_guild_person_from_ets(ObjPlayerId);
				false ->
					mod_guild_dungeon:del_guild_person_from_ets(ObjPlayerId)
			end;
		false ->
			skip
	end,

	%更新玩家帮派副本个人数据
	db:update(guild_dungeon_data, 
			  [{guild_id,0}, {contribution, util:term_to_bitstring([])}, {collection, 0},
			   {kill_count,0}, {damage_value, 0} ] , [{player_id, ObjPlayerId }] ),
	
    case OldTitleNo =:= ?GUILD_TITLE_NO_NORMAL_MEMBER of
        true -> skip;
        false ->
            case OldTitleNo =:= ?INVALID_NO of
                true -> skip;
                false -> 
                    lib_offcast:cast(ObjPlayerId, {del_title, OldTitleNo})
            end
    end,

    notify_guild_member_kicked_out(Guild, OpPos, OpName, OpedName),
    ok.



try_quit_guild(PS, GuildId) ->
    case check_quit_guild(PS, GuildId) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        {ok, Guild} ->
            do_quit_guild(PS, Guild),
            {ok, BinData} = pt_40:write(?PT_QUIT_GUILD, [?RES_OK]),
            lib_send:send_to_sock(PS, BinData)
    end.


check_quit_guild(PS, GuildId) ->
    try check_quit_guild__(PS, GuildId) of
        {ok, Guild} ->
            {ok, Guild}
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.


check_quit_guild__(PS, GuildId) ->
    Guild = mod_guild:get_info(GuildId),
    ?Ifc (Guild =:= null)
        throw(?PM_GUILD_NOT_EXISTS)
    ?End,

    ?Ifc (not player:is_in_guild(PS))
        throw(?PM_NOT_IN_GUILD)
    ?End,

    ?Ifc (lib_dungeon:is_in_guild_prepare_dungeon(PS))
        throw(?PM_GUILD_IN_WAR)
    ?End,

    ?Ifc (lib_dungeon:is_in_guild_battle_dungeon(PS))
        throw(?PM_GUILD_IN_WAR)
    ?End,

    {ok, Guild}.


do_quit_guild(PS, Guild) ->
    ?ASSERT(Guild /= null),
    NewMemberList = Guild#guild.member_id_list -- [player:get_id(PS)],

    OldTitleNo = 
        case mod_guild:decide_guild_pos(player:id(PS), Guild) of
            ?GUILD_POS_CHIEF -> ?GUILD_TITLE_NO_CHIEF;
            ?GUILD_POS_COUNSELLOR -> ?GUILD_TITLE_NO_COUNSELLOR;
            ?GUILD_POS_SHAOZHANG -> ?GUILD_TITLE_NO_SHAOZHANG;
            ?GUILD_POS_NORMAL_MEMBER -> ?GUILD_TITLE_NO_NORMAL_MEMBER;
            _ -> ?ASSERT(false), ?INVALID_NO
        end,

    %% 去除职位
    NewCounsellorIdL =
        case lists:member(player:id(PS), Guild#guild.counsellor_id_list) of
            true -> Guild#guild.counsellor_id_list -- [player:id(PS)];
            false -> Guild#guild.counsellor_id_list
        end,
    NewShaozhangIdL =
        case lists:member(player:id(PS), Guild#guild.shaozhang_id_list) of
            true -> Guild#guild.shaozhang_id_list -- [player:id(PS)];
            false -> Guild#guild.shaozhang_id_list
        end,
    NewGuild = Guild#guild{member_id_list = NewMemberList, counsellor_id_list = NewCounsellorIdL, shaozhang_id_list = NewShaozhangIdL},
    NewGuild1 = NewGuild#guild{battle_power = mod_guild:calc_battle_power(NewGuild)},

    %% 更新投标信息 返还帮派投标绑银
    NewGuild2 = handle_bid_for_leave_guild(NewGuild1, player:id(PS)),

    mod_guild:update_guild_to_ets(NewGuild2),
    mod_guild:db_save_guild(NewGuild2),

    mod_guild:del_member_from_ets_by_mb_id(player:get_id(PS)),
    mod_guild:db_delete_guild_member_by_mb_id(player:get_id(PS)),

    mod_guild:db_save_guild_id(player:get_id(PS), ?INVALID_ID),
    player:set_guild_id(PS, ?INVALID_ID),

    LeaveTime = util:unixtime(),
    player:set_leave_guild_time(PS, LeaveTime),

    notify_guild_member_quit(NewGuild, player:get_name(PS)),

    gen_server:cast(player:get_pid(PS), {del_title, ?GUILD_TITLE_NO_NORMAL_MEMBER}),
    gen_server:cast(player:get_pid(PS), {del_title, ?GUILD_TITLE_NO_FIRST_GUILD}),

    SceneType = case lib_scene:get_obj(player:get_scene_id(PS)) of
        null -> ?SCENE_T_INVALID;
        SceneObj -> lib_scene:get_type(SceneObj)
    end,

    % 离开帮派 将踢出帮派场景 以及 如果在帮派场景还要离开队伍
    case SceneType of
        ?SCENE_T_GUILD ->
            mod_team:quit_team(PS),
            ply_scene:teleport_after_die(PS);
        _ ->
            skip
    end,
	
	mod_guild_dungeon:del_guild_person_from_ets(player:get_id(PS)),
	%更新玩家帮派副本个人数据
	db:update(guild_dungeon_data, 
			  [{guild_id,0}, {contribution, util:term_to_bitstring([])}, {collection, 0},
								   {kill_count,0}, {damage_value, 0} ] , [{player_id,player:get_id(PS)}] ),
 
    case OldTitleNo =:= ?GUILD_TITLE_NO_NORMAL_MEMBER of
        true -> skip;
        false ->
            case OldTitleNo =:= ?INVALID_NO of
                true -> skip;
                false -> 
                    gen_server:cast(player:get_pid(PS), {del_title, OldTitleNo})
            end
    end,

    ok.


try_create_guild(PS, GuildName, Brief) ->
    case check_create_guild(PS, GuildName, Brief) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        ok ->
            {ok, GuildId} = do_create_guild(PS, GuildName, Brief),
            lib_log:statis_guild_create(player:id(PS), player:get_lv(PS), GuildId, 1),
            mod_achievement:notify_achi(apply_join_guild, [], PS),
            lib_event:event(had_guild, [], PS),

            lib_offcast:cast(player:id(PS), {add_title, ?GUILD_TITLE_NO_CHIEF, svr_clock:get_unixtime()}),

            {ok, BinData} = pt_40:write(?PT_CREATE_GUILD, [?RES_OK, GuildId, GuildName]),
            lib_send:send_to_sock(PS, BinData)
    end.


check_modify_guild_name(PS, GoodsId, Name) ->
    try 
        check_modify_guild_name__(PS, GoodsId, Name)
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.


check_modify_guild_name__(PS, GoodsId, GuildName) ->
    ?Ifc (not mod_guild:is_chief(PS))
        throw(?PM_GUILD_POWER_LIMIT)
    ?End,

    Ret = mod_inv:check_batch_destroy_goods_by_id(player:id(PS), [GoodsId]),
    ?Ifc (Ret =/= ok)
        throw(?PM_GOODS_NOT_ENOUGH)
    ?End,

    Pattern = #guild{name = list_to_binary(GuildName), _ = '_'},
    ?Ifc (ets:match_object(?ETS_GUILD, Pattern) /= [])
        throw(?PM_GUILD_NAME_OCCUPIED)
    ?End,

    case is_guild_name_valid(GuildName) of
        {false, len_error} ->
            throw(?PM_GUILD_NAME_LEN_ERROR);
        {false, char_illegal} ->
            throw(?PM_GUILD_NAME_CHAR_ILLEGEL);
        true ->
            ok
    end.

check_create_guild(PS, GuildName, Brief) ->
    try check_create_guild__(PS, GuildName, Brief) of
        ok -> ok
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.


check_create_guild__(PS, GuildName, Brief) ->
    ?Ifc (PS =:= null)
        throw(?PM_UNKNOWN_ERR)
    ?End,

    % 玩家已有帮会
    ?Ifc (player:is_in_guild(PS))
        throw(?PM_HAVE_IN_GUILD)
    ?End,

    ?Ifc (mod_guild:get_member_info(player:id(PS)) =/= null)
        throw(?PM_HAVE_IN_GUILD)
    ?End,

    Pattern = #guild{name = list_to_binary(GuildName), _ = '_'},
    ?Ifc (ets:match_object(?ETS_GUILD, Pattern) /= [])
        throw(?PM_GUILD_NAME_OCCUPIED)
    ?End,

    {MoneyType, CostNum} = data_special_config:get('create_guild_cost'),
    ?Ifc (not player:has_enough_money(PS, MoneyType, CostNum))
        throw(?PM_MONEY_LIMIT)
    ?End,

    % 帮会名字非法
    case is_guild_name_valid(GuildName) of
        {false, len_error} ->
            throw(?PM_GUILD_NAME_LEN_ERROR);
        {false, char_illegal} ->
            throw(?PM_GUILD_NAME_CHAR_ILLEGEL);
        true ->
            case mod_guild:is_guild_brief_valid(Brief) of
                {false, len_error} ->
                    throw(?PM_GUILD_BRIEF_LEN_ERROR);
                {false, char_illegal} ->
                    throw(?PM_GUILD_BRIEF_CHAR_ILLEGEL);
                true ->
                    ok
            end
    end.


is_guild_name_valid(GuildName) ->
    ?ASSERT(is_list(GuildName)),
    case asn1rt:utf8_binary_to_list(list_to_binary(GuildName)) of
        {ok, CharList} ->
            Len = util:string_width(CharList),
            case Len > ?GUILD_NAME_MAX_LEN orelse Len < ?GUILD_NAME_MIN_LEN of
                true ->
                    {false, len_error};
                false ->
                    case util:has_illegal_char(CharList) of % 是否包含非法字符（如：空格，反斜杠）
                        true ->
                            {false, char_illegal};
                        false ->
                            true
                    end
            end;
        {error, _Reason} ->
            {false, char_illegal}
    end.


%% return {ok, GuildId}
do_create_guild(PS, GuildName, Brief) ->
    ?TRACE("try create guild: ~p", [GuildName]),

%%    BriefList = data_special_config:get('guild_slogan'),
%%    Brief = list_util:rand_pick_one(BriefList),

    {MoneyType, CostNum} = data_special_config:get('create_guild_cost'),
    player:cost_money(PS, MoneyType, CostNum, ["mod_guild_mgr","do_create_guild"]),

    NewGuild = #guild{
                    name = list_to_binary(GuildName),
                    brief = list_to_binary(Brief),
                    lv = 1,
                    chief_id = player:get_id(PS),
                    chief_name = player:get_name(PS),
                    create_time = svr_clock:get_unixtime(),
                    rank = 0,
                    member_id_list = [player:get_id(PS)],
                    request_joining_list = [],
                    scene_id = ?INVALID_ID %% 帮派地图在进入的时候动态创建
                },
    
    TId = mod_guild:db_insert_new_guild(NewGuild),

    Id = 
        case lib_account:is_global_uni_id(TId) of 
            true -> TId; 
            false -> 
                GlobalId = lib_account:to_global_uni_id(TId),
                db:update(?DB_SYS, guild, ["id"], [GlobalId], "id", TId), 
                GlobalId
        end,

    ?ASSERT(util:is_positive_int(Id), Id),
    NewGuild1 = NewGuild#guild{id = Id},
    NewGuild2 = NewGuild1#guild{battle_power = mod_guild:calc_battle_power(NewGuild1)},
    mod_guild:add_guild_to_ets(NewGuild2),

    %% 更新排名
    update_guild_rank(),

    NewMember = #guild_mb{
        id = player:get_id(PS),
        guild_id = Id,
        name = player:get_name(PS),
        lv = player:get_lv(PS),
        vip_lv = player:get_vip_lv(PS),
        sex = player:get_sex(PS),
        race = player:get_race(PS),
        faction = player:get_faction(PS),
        contri = 0,
        title_id = 0, %% 暂时写
        battle_power = ply_attr:get_battle_power(PS),
        position = ?GUILD_POS_CHIEF
    },

    mod_guild:add_member_info_to_ets(NewMember),
    mod_guild:db_insert_new_member(NewMember),

    player:set_guild_id(PS, Id),
    mod_guild:db_save_guild_id(player:id(PS), Id),
    lib_scene:notify_string_info_change_to_aoi(player:id(PS), [{?OI_CODE_GUILDNAME, list_to_binary(GuildName)}]),
    player:notify_cli_info_change_2(PS, ?OI_CODE_GUILD_CHIEF_ID, player:id(PS)),
    ply_guild:refresh_one_guild_shop(Id,player:get_id(PS)),
    {ok, Id}.


try_reply_invite(PS, GuildId, Choise) ->
    case check_reply_invite(PS, GuildId, Choise) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        {ok, Guild} ->
            do_reply_invite(PS, Guild, Choise),
            {ok, BinData} = pt_40:write(?PT_REPLY_INVITE, [?RES_OK]),
            lib_send:send_to_sock(PS, BinData)
    end.

check_reply_invite(PS, GuildId, Choise) ->
    try check_reply_invite__(PS, GuildId, Choise) of
        {ok, Guild} -> 
            {ok, Guild}
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

check_reply_invite__(PS, GuildId, Choise) ->
    ?Ifc (player:is_in_guild(PS))
        throw(?PM_HAVE_IN_GUILD)
    ?End,

    ?Ifc (PS =:= null)
        throw(?PM_UNKNOWN_ERR)
    ?End,
    
    Guild = mod_guild:get_info(GuildId),
    ?Ifc (Guild =:= null)
        throw(?PM_GUILD_NOT_EXISTS)
    ?End,

    ?Ifc ((Choise =:= 1) andalso (mod_guild:get_guild_member_count(Guild) >= mod_guild:get_capacity_by_guild_lv(mod_guild:get_lv(Guild))))
        throw(?PM_GUILD_MEMBER_COUNT_LIMIT)
    ?End,

    ?Ifc (Choise =:= 1 andalso mod_guild:get_member_info(player:id(PS)) =/= null)
        ?ASSERT(false),
        throw(?PM_HAVE_IN_GUILD)
    ?End,
    
    {ok, Guild}.


do_reply_invite(PS, Guild, Choise) ->
    case Choise of
        0 -> %% 拒绝加入帮派
            ok;
        1 -> %% 同意加入帮派
            GuildId = mod_guild:get_id(Guild),
            NewMember = mod_guild:to_member_record([player:get_id(PS), GuildId, player:get_name(PS), player:get_lv(PS), player:get_vip_lv(PS),
                        player:get_sex(PS), player:get_race(PS), player:get_faction(PS), svr_clock:get_unixtime(), 0, ply_attr:get_battle_power(PS), 0, 0, 0, 0, 0,0,0,[], 0]),

            MemberIdList = 
                case lists:member(player:get_id(PS), Guild#guild.member_id_list) of
                    true -> Guild#guild.member_id_list;
                    false -> Guild#guild.member_id_list ++ [player:get_id(PS)]
                end,

            NewGuild = Guild#guild{member_id_list = MemberIdList},
            NewGuild1 = NewGuild#guild{battle_power = mod_guild:calc_battle_power(NewGuild)},

            mod_guild:update_guild_to_ets(NewGuild1),
            mod_guild:add_member_info_to_ets(NewMember),

            mod_guild:db_save_guild(NewGuild1),
            mod_guild:db_insert_new_member(NewMember),

            player:set_guild_id(PS, GuildId),
            mod_guild:db_save_guild_id(player:id(PS), GuildId),
            mod_guild:notify_player_join_guild(NewGuild1, player:get_name(PS)),
            mod_achievement:notify_achi(apply_join_guild, [], PS),
            lib_event:event(had_guild, [], PS),
            lib_offcast:cast(player:id(PS), {add_title, ?GUILD_TITLE_NO_NORMAL_MEMBER, svr_clock:get_unixtime()}),
            lib_scene:notify_string_info_change_to_aoi(player:id(PS), [{?OI_CODE_GUILDNAME, NewGuild1#guild.name}]),
            ok
    end.


do_handle_guild_apply(PS, PlayerId, Choise) ->
    case check_handle_apply(PS, PlayerId, Choise) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        {ok, Guild} ->
            do_handle_apply(PS, PlayerId, Choise, Guild),
            {ok, BinData} = pt_40:write(?PT_HANDLE_APPLY, [?RES_OK, Choise]),
            lib_send:send_to_sock(PS, BinData)
    end.

check_handle_apply(PS, PlayerId, Choise) ->
    try check_handle_apply__(PS, PlayerId, Choise) of
        {ok, Guild} -> 
            {ok, Guild}
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.


check_handle_apply__(PS, PlayerId, Choise) ->
    ?Ifc (not lists:member(Choise, [0, 1, 2, 3]))
        throw(?PM_PARA_ERROR)
    ?End,

    Guild = mod_guild:get_info(player:get_guild_id(PS)),
    Lv = mod_guild:get_lv(Guild),
    ?Ifc (Guild =:= null)
        throw(?PM_GUILD_NOT_EXISTS)
    ?End,
    %% 不是帮主 或 军师 没有权限
    CounsellorList = mod_guild:get_counsellor_id_list(Guild),
    ShaoZhang = mod_guild:get_shaozhang_id_list(Guild),
    ?Ifc ( (not mod_guild:is_chief(PS)) andalso (not lists:member(player:get_id(PS), CounsellorList)) andalso (not lists:member(player:get_id(PS), ShaoZhang)) )
        throw(?PM_GUILD_POWER_LIMIT)
    ?End,

    % 该帮会人数已满
    ?Ifc (Choise =:= 1 andalso mod_guild:get_guild_member_count(Guild) >= mod_guild:get_capacity_by_guild_lv(Lv))
        throw(?PM_GUILD_MEMBER_COUNT_LIMIT)
    ?End,

    % 玩家已有帮会
    ?Ifc (Choise =:= 1 andalso PlayerId /= 0 andalso player:is_online(PlayerId) andalso player:is_in_guild(PlayerId))
        ReqJoinList = lists:keydelete(PlayerId, #join_guild_req.id, Guild#guild.request_joining_list),
        NewGuild = Guild#guild{request_joining_list = ReqJoinList},
        mod_guild:update_guild_to_ets(NewGuild),
        throw(?PM_HAVE_IN_GUILD)
    ?End,

    % 离线玩家是否有帮派的判断
    ?Ifc (Choise =:= 1 andalso PlayerId /= 0 andalso (not player:is_online(PlayerId)) andalso mod_guild:db_get_guild_id_by_player_id(PlayerId) /= ?INVALID_ID)
        ReqJoinList1 = lists:keydelete(PlayerId, #join_guild_req.id, Guild#guild.request_joining_list),
        NewGuild1 = Guild#guild{request_joining_list = ReqJoinList1},
        mod_guild:update_guild_to_ets(NewGuild1),
        throw(?PM_HAVE_IN_GUILD)
    ?End,

    ?Ifc (Choise =:= 1 andalso PlayerId /= 0 andalso lists:keyfind(PlayerId, #join_guild_req.id, Guild#guild.request_joining_list) =:= false)
        throw(?PM_NOT_APPLY_THE_GUILD)
    ?End,

    % 该帮会人数已满
    ?Ifc (Choise =:= 3 andalso mod_guild:get_guild_member_count(Guild) + length(Guild#guild.request_joining_list) > mod_guild:get_capacity_by_guild_lv(Lv))
        throw(?PM_GUILD_MEMBER_COUNT_LIMIT)
    ?End,

    ?Ifc (Choise =:= 1 andalso mod_guild:get_member_info(PlayerId) =/= null)
        throw(?PM_HAVE_IN_GUILD)
    ?End,

    {ok, Guild}.


do_handle_apply(PS, PlayerId, Choise, Guild) ->
    case Choise of
        0 -> %% 拒绝入会
            ReqJoinList = lists:keydelete(PlayerId, #join_guild_req.id, Guild#guild.request_joining_list),
            NewGuild = Guild#guild{request_joining_list = ReqJoinList},

            mod_guild:update_guild_to_ets(NewGuild),
            % mod_guild:db_save_guild(NewGuild),
            ok;
        1 -> %% 允许入会
            ApplyData = lists:keyfind(PlayerId, #join_guild_req.id, Guild#guild.request_joining_list),
            ?ASSERT(ApplyData /= false),
            NewMember = mod_guild:to_member_record([PlayerId, player:get_guild_id(PS), ApplyData#join_guild_req.name, ApplyData#join_guild_req.lv,
                ApplyData#join_guild_req.vip_lv, ApplyData#join_guild_req.sex, ApplyData#join_guild_req.race, ApplyData#join_guild_req.faction, 
                svr_clock:get_unixtime(), 0, ApplyData#join_guild_req.battle_power, 0, 0, 0, 0, 0,0,0,[], 0]),

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

            mod_guild:db_save_guild_id(PlayerId, player:get_guild_id(PS)),
            case player:get_PS(PlayerId) of
                null -> 
                    case player:in_tmplogout_cache(PlayerId) of
                        false -> skip;
                        true ->
                            TmpLogoutPS = ply_tmplogout_cache:get_tmplogout_PS(PlayerId),
                            NowTime = util:unixtime(),
                            lib_player_ext:try_update_data(PlayerId,enter_guild_time,NowTime),

                            ply_tips:send_sys_tips(PS, {join_guild, [
                                player:get_name(TmpLogoutPS),
                                PlayerId
                            ]}),
                            ply_tmplogout_cache:set_guild_id(TmpLogoutPS, player:get_guild_id(PS))
                    end;
                TargetPS -> 
                    lib_event:event(had_guild, [], TargetPS),
                    player:set_guild_id(PlayerId, player:get_guild_id(PS)),

                    NowTime = util:unixtime(),
                    player:set_enter_guild_time(TargetPS,NowTime),
                    
                    ply_tips:send_sys_tips(PS, {join_guild, [
                        player:get_name(TargetPS),
                        PlayerId
                    ]}),

                    lib_scene:notify_string_info_change_to_aoi(PlayerId, [{?OI_CODE_GUILDNAME, Guild#guild.name}])
            end,

            mod_guild:notify_player_join_guild(NewGuild, ApplyData#join_guild_req.name),
            lib_offcast:cast(PlayerId, {add_title, ?GUILD_TITLE_NO_NORMAL_MEMBER, svr_clock:get_unixtime()}),
            ok;
        2 ->    %% 全部拒绝
            NewGuild = Guild#guild{request_joining_list = []},

            mod_guild:update_guild_to_ets(NewGuild),
            % mod_guild:db_save_guild(NewGuild),
            ok;
        3 -> %% 全部同意
            F = fun(ApplyData, AccList) ->
                JoinSuccess = 
                    case player:is_online(ApplyData#join_guild_req.id) of
                        false ->
                            case mod_guild:db_get_guild_id_by_player_id(ApplyData#join_guild_req.id) =/= ?INVALID_ID of
                                true -> false;
                                false -> true
                            end;
                        true ->
                            case player:is_in_guild(ApplyData#join_guild_req.id) of
                                true -> false;
                                false -> true
                            end
                    end,
                %% 进一步判断玩家是否已经加入帮派
                JoinSuccess1 = 
                    case JoinSuccess of
                        true ->
                            case mod_guild:get_member_info(ApplyData#join_guild_req.id) =/= null of
                                true -> false;
                                false -> JoinSuccess
                            end;
                        false -> JoinSuccess
                    end,

                case JoinSuccess1 of
                    false -> AccList;
                    true ->
                        NewMember = mod_guild:to_member_record([ApplyData#join_guild_req.id, player:get_guild_id(PS), ApplyData#join_guild_req.name, ApplyData#join_guild_req.lv,
                            ApplyData#join_guild_req.vip_lv, ApplyData#join_guild_req.sex, ApplyData#join_guild_req.race, ApplyData#join_guild_req.faction, 
                            svr_clock:get_unixtime(), 0, ApplyData#join_guild_req.battle_power, 0, 0, 0, 0, 0,0,0,[], 0]),

                        mod_guild:add_member_info_to_ets(NewMember),
                        mod_guild:db_insert_new_member(NewMember),

                        mod_guild:db_save_guild_id(ApplyData#join_guild_req.id, player:get_guild_id(PS)),
                        case player:get_PS(ApplyData#join_guild_req.id) of
                            null -> 
                                case player:in_tmplogout_cache(PlayerId) of
                                    false -> skip;
                                    true ->
                                        TmpLogoutPS = ply_tmplogout_cache:get_tmplogout_PS(PlayerId),
                                        ply_tmplogout_cache:set_guild_id(TmpLogoutPS, player:get_guild_id(PS))
                                end;
                            TargetPS -> 
                                lib_event:event(had_guild, [], TargetPS),
                                player:set_guild_id(ApplyData#join_guild_req.id, player:get_guild_id(PS)),
                                lib_scene:notify_string_info_change_to_aoi(ApplyData#join_guild_req.id, [{?OI_CODE_GUILDNAME, Guild#guild.name}])
                        end,
                        lib_offcast:cast(ApplyData#join_guild_req.id, {add_title, ?GUILD_TITLE_NO_NORMAL_MEMBER, svr_clock:get_unixtime()}),
                        [{ApplyData#join_guild_req.id, ApplyData#join_guild_req.name} | AccList]
                end
            end,
            AddIdNameList = lists:foldl(F, [], Guild#guild.request_joining_list),
            
            F1 = fun({Id, _Name}) ->
                Id
            end,

            AddIdList = [F1(X) || X <- AddIdNameList],
            NewGuild = Guild#guild{request_joining_list = [], member_id_list = sets:to_list(sets:from_list(Guild#guild.member_id_list ++ AddIdList))},
            NewGuild1 = NewGuild#guild{battle_power = mod_guild:calc_battle_power(NewGuild)},
            mod_guild:update_guild_to_ets(NewGuild1),
            mod_guild:db_save_guild(NewGuild1),

            F2 = fun({_Id, Name}) ->
                Name
            end,

            AddNameList = [F2(X) || X <- AddIdNameList],
            [mod_guild:notify_player_join_guild(NewGuild, JoinName) || JoinName <- AddNameList],
            ok;
        _Any ->
            ?ASSERT(false),
            ok
    end.


update_rank() ->
    F = fun(G1, G2) -> 
        Lv1 = G1#guild.lv,
        Lv2 = G2#guild.lv,
        Prosper1 = G1#guild.prosper, 
        Prosper2 = G2#guild.prosper,
        MbCount1 = length(G1#guild.member_id_list),
        MbCount2 = length(G2#guild.member_id_list),
        Time1 = G1#guild.create_time,
        Time2 = G2#guild.create_time,
        if 
            Lv1 > Lv2 -> true;
            Lv1 < Lv2 -> false;
            Prosper1 > Prosper2 -> true;
            Prosper1 < Prosper2 -> false;
            MbCount1 > MbCount2 -> true;
            MbCount1 < MbCount2 -> false;
            Time1 > Time2 -> false;
            Time1 < Time2 -> true;
            true -> true
        end
    end,

    SortGuildList = lists:sort(F, mod_guild:get_guild_list()),

    update_rank(SortGuildList, 1).

update_rank([], _Rank) ->
    void;
update_rank([Guild | T], Rank) ->
    mod_guild:update_guild_to_ets(Guild#guild{rank = Rank}),
    update_rank(T, Rank + 1).


create_guild_dungeon(Guild) ->
    Lv = mod_guild:get_lv(Guild),
    case data_guild_lv:get(Lv) of
        null -> 
            ?ASSERT(false, Lv),
            ?ERROR_MSG("mod_guild_mgr:cfg data error!~p ~n", [Lv]),
            skip;
        Data ->
            case length(Data#guild_lv_data.layer) =:= 2 of
                false -> 
                    ?ASSERT(false, Data#guild_lv_data.layer),
                    ?ERROR_MSG("mod_guild_mgr:cfg data error!~p ~n", [Data#guild_lv_data.layer]),
                    skip;
                true ->
                    case data_guild_dungeon:get(lists:nth(1, Data#guild_lv_data.layer)) =/= null andalso 
                        data_guild_dungeon:get(lists:nth(2, Data#guild_lv_data.layer)) =/= null of
                        false ->
                            ?ERROR_MSG("mod_guild_mgr:cfg data error!~p ~n", [Data#guild_lv_data.layer]);
                        true ->
                            lib_dungeon:create_guild_dungeon(?GUILD_DUNGEON_NO, svr_clock:get_unixtime(), lists:nth(1, Data#guild_lv_data.layer), 
                            lists:nth(2, Data#guild_lv_data.layer), Guild#guild.id)
                    end
            end
    end.


notify_guild_member_quit(Guild, PlayerName) ->
    {ok, BinData} = pt_40:write(?PT_NOTIFY_QUIT_GUILD, [Guild#guild.id, PlayerName, Guild#guild.name]),
    MemberList = mod_guild:get_member_id_list(Guild),
    [lib_send:send_to_uid(PlayerId, BinData) || PlayerId <- MemberList, player:is_online(PlayerId)].


notify_guild_member_kicked_out(Guild, OpPos, OpName, OpedName) ->
    {ok, BinData} = pt_40:write(?PT_NOTIFY_KICK_OUT_GUILD, [Guild#guild.id, OpPos, OpName, OpedName]),
    MemberList = mod_guild:get_member_id_list(Guild),
    [lib_send:send_to_uid(PlayerId, BinData) || PlayerId <- MemberList, player:is_online(PlayerId)].



notify_guild_member_pos_change(Guild, OpPos, OpName, OpedName, OpedPrePos, OpedNowPos) ->
    {ok, BinData} = pt_40:write(?PT_NOTIFY_MEMBER_POS_CHANGE, [OpPos, OpName, OpedName, OpedPrePos, OpedNowPos]),
    MemberList = mod_guild:get_member_id_list(Guild),
    [lib_send:send_to_uid(PlayerId, BinData) || PlayerId <- MemberList, player:is_online(PlayerId)].


notify_guild_disband(Guild) ->
    {ok, BinData} = pt_40:write(?PT_NOTIFY_GUILD_DISBANDED, [Guild#guild.id, player:get_name(Guild#guild.chief_id), Guild#guild.name]),
    MemberList = mod_guild:get_member_id_list(Guild),
    
    %% 通知排行榜
    mod_rank:guild_battle_power({Guild#guild.id, Guild#guild.name, Guild#guild.lv, 0}),
	CurMbCount = length(Guild#guild.member_id_list),
	MbCapacity = mod_guild:get_capacity_by_guild_lv(Guild#guild.lv),
	MemberStr = util:to_binary(lists:concat([CurMbCount, "/",MbCapacity])),
    mod_rank:guild_battle_prosper({Guild#guild.id, Guild#guild.name, Guild#guild.lv, player:get_name(Guild#guild.chief_id), MemberStr, Guild#guild.prosper}),
    F = fun(X) ->
        case player:get_PS(X) of
            null -> skip;
            TPS -> 
                lib_send:send_to_sock(TPS, BinData),
                player:notify_cli_info_change_2(TPS, ?OI_CODE_GUILD_CHIEF_ID, ?INVALID_ID)
        end
    end,
    [F(X) || X <- MemberList].


give_reward_for_activity__([Lv, GoodsList, MailTitle, MailContent]) ->
    GuildList = mod_guild:get_guild_list(),
    give_reward_for_activity__(GuildList, Lv, GoodsList, MailTitle, MailContent).


give_reward_for_activity__([], _Lv, _GoodsList, _MailTitle, _MailContent) ->
    skip;
give_reward_for_activity__([Guild | T], Lv, GoodsList, MailTitle, MailContent) ->
    case Guild#guild.lv >= Lv of
        false -> skip;
        true ->
            ChiefGoods = [lists:nth(1, GoodsList)],
            CounsellorGoods = [lists:nth(2, GoodsList)],
            ShaozhangGoods = [lists:nth(3, GoodsList)],
            NormalGoods = [lists:nth(4, GoodsList)],
            F = fun(Id) ->
                case mod_guild:decide_guild_pos(Id, Guild) of
                    ?GUILD_POS_CHIEF ->
                        lib_mail:send_sys_mail(Id, MailTitle, MailContent, ChiefGoods, [?LOG_MAIL, "recv_guild"]);
                    ?GUILD_POS_COUNSELLOR ->
                        lib_mail:send_sys_mail(Id, MailTitle, MailContent, CounsellorGoods, [?LOG_MAIL, "recv_guild"]);
                    ?GUILD_POS_SHAOZHANG ->
                        lib_mail:send_sys_mail(Id, MailTitle, MailContent, ShaozhangGoods, [?LOG_MAIL, "recv_guild"]);
                    ?GUILD_POS_NORMAL_MEMBER ->
                        lib_mail:send_sys_mail(Id, MailTitle, MailContent, NormalGoods, [?LOG_MAIL, "recv_guild"]);
                    _Any ->
                        ?ERROR_MSG("mod_guild_mgr:give_reward_for_activity__ error!~p~n", [_Any]),
                        skip
                end
            end,
            [F(X) || X <- mod_guild:get_member_id_list(Guild)]
    end,
    give_reward_for_activity__(T, Lv, GoodsList, MailTitle, MailContent).



% get_war_min_bid() ->
%     case get_guild_war_last_rank() of
%         [] -> ?GUILD_WAR_MIN_BID;
%         RankList ->
%             get_war_min_bid(RankList)
%     end.

% get_war_min_bid([]) ->
%     ?ERROR_MSG("mod_guild_mgr:get_war_min_bid error!~n", []),
%     ?GUILD_WAR_MIN_BID;
% get_war_min_bid([H | T]) ->
%     {Rank, _GuildId, TotalBid, _} = H,
%     case Rank =:= 4 of
%         true -> util:ceil(TotalBid/2);
%         false -> get_war_min_bid(T)
%     end.

get_old_first_guild_id() ->
    case get_guild_war_last_rank() of
        [] -> ?INVALID_ID;
        RankList ->
            get_old_first_guild_id(RankList)
    end.

get_old_first_guild_id([]) ->
    ?ERROR_MSG("mod_guild_mgr:get_old_first_guild_id error!~n", []),
    ?INVALID_ID;
get_old_first_guild_id([H | T]) ->
    {Rank, GuildId, _TotalBid, _} = H,
    case Rank =:= 1 of
        true -> GuildId;
        false -> get_old_first_guild_id(T)
    end.

mk_war_min_bid() ->
    F0 = fun({_, Id1, _, Id2}, Acc) -> 
        if
            Id1 =:= ?INVALID_ID andalso Id2 =:= ?INVALID_ID ->
                Acc;
            Id1 =:= ?INVALID_ID ->
                [Id2 | Acc];
            Id2 =:= ?INVALID_ID ->
                [Id1 | Acc];
            true ->
                [Id1, Id2] ++ Acc
        end
    end,

    F = fun(X, AccL) ->
        lists:foldl(F0, [], get_join_guild_by_round(X)) ++ AccL
    end,
    GuildIdL = lists:foldl(F, [], lists:seq(get_guild_war_round(), 3)),
    ?DEBUG_MSG("mk_war_min_bid:JoinIdList:~w~n", [GuildIdL]),

    F1 = fun(Id1, Id2) -> 
        GuildWar1 = lib_guild:get_guild_war_from_ets(Id1),
        GuildWar2 = lib_guild:get_guild_war_from_ets(Id2),
        if
            GuildWar1 =:= null orelse GuildWar2 =:= null ->
                false;
            GuildWar1#guild_war.total_bid > GuildWar2#guild_war.total_bid ->
                true;
            true ->
                false
        end
    end,
    GuildIdSortL = lists:sort(F1, GuildIdL),
    % F2 = fun(Id) ->
    %     case lib_guild:get_guild_war_from_ets(Id) of
    %         null -> skip;
    %         TGuildWar -> ?DEBUG_MSG("{Id:~p, Bid:~p}~n", [Id, TGuildWar#guild_war.total_bid])
    %     end
    % end,
    % [F2(X) || X <- GuildIdSortL],

    case length(GuildIdSortL) < 4 of
        true -> ?GUILD_WAR_MIN_BID;
        false ->
            case lib_guild:get_guild_war_from_ets(lists:nth(4, GuildIdSortL)) of
                null -> ?GUILD_WAR_MIN_BID;
                GuildWar -> util:ceil(GuildWar#guild_war.total_bid/2)
            end
    end.


get_guild_war_group() ->
    case erlang:get(?PDKN_GUILD_WAR_GROUP) of
        undefined -> [];
        Rd -> Rd
    end.
set_guild_war_group(Value) ->
    erlang:put(?PDKN_GUILD_WAR_GROUP, Value).


get_guild_war_last_rank() ->
    case erlang:get(?PDKN_GUILD_WAR_LAST_RANK) of
        undefined -> [];
        Rd -> Rd
    end.
set_guild_war_last_rank(Value) ->
    erlang:put(?PDKN_GUILD_WAR_LAST_RANK, Value).


set_guild_war_round(Round) ->
    erlang:put(?PDKN_GUILD_WAR_ROUND, Round).
get_guild_war_round() ->
    case erlang:get(?PDKN_GUILD_WAR_ROUND) of
        undefined -> 0;
        Rd -> Rd
    end.

set_guild_war_turn(Turn) ->
    erlang:put(?PDKN_GUILD_WAR_TURN, Turn).
%% 从第一届开始算
get_guild_war_turn() ->
    case erlang:get(?PDKN_GUILD_WAR_TURN) of
        undefined -> 1;
        Rd -> Rd
    end.

get_guild_war_min_bid() ->
    case erlang:get(?PDKN_GUILD_WAR_MIN_BID) of
        undefined -> ?GUILD_WAR_MIN_BID;
        Rd -> Rd
    end.    

set_guild_war_min_bid(Bid) ->
    erlang:put(?PDKN_GUILD_WAR_MIN_BID, Bid).

get_guild_war_time() ->
    case erlang:get(?PDKN_GUILD_WAR_TIME) of
        undefined -> [];
        Rd -> Rd
    end.
set_guild_war_time(Value) ->
    erlang:put(?PDKN_GUILD_WAR_TIME, Value).


get_guild_war_time_by_round(Round) ->
    case lists:keyfind(Round, 1, get_guild_war_time()) of
        false ->
            0;
        {_, Time} ->
            Time
    end.


set_guild_war_counter(Counter) ->
    erlang:put(?PDKN_GUILD_WAR_COUNTER, Counter).
get_guild_war_counter() ->
    case erlang:get(?PDKN_GUILD_WAR_COUNTER) of
        undefined -> 0;
        Rd -> Rd
    end.

set_guild_war_obj_guild(GuildId, ObjGuildId) ->
    erlang:put( {?PDKN_GUILD_WAR_OBJ_GUILD, GuildId}, ObjGuildId ).
get_guild_war_obj_guild(GuildId) ->
    case erlang:get({?PDKN_GUILD_WAR_OBJ_GUILD, GuildId}) of
        undefined -> 0;
        Rd -> Rd
    end.


%% 13 和 15 位分别是左右两边的种子帮派，19是冠军位置
mk_guild_war_group(GuildWarList) ->
    ?ASSERT(length(GuildWarList) >= 4, GuildWarList),
    F = fun(Index, Acc) ->
        [{Index, 0, <<>>} | Acc]
    end,

    LeftList = lists:foldl(F, [], [1,2,3,4,9,10,13,14,17]),
    RightList = lists:foldl(F, [], [5,6,7,8,11,12,15,16,18]),

    JoinList = lists:sort(fun(G1, G2) -> G1#guild_war.total_bid > G2#guild_war.total_bid end, GuildWarList),
    Rand = util:rand(1, 2),

    SeedL = lists:nth(Rand, JoinList),
    SeedR = 
        case Rand =:= 1 of
            true -> lists:nth(2, JoinList);
            false -> lists:nth(1, JoinList)
        end,

    LeftList1 = lists:keyreplace(13, 1, LeftList, {13, SeedL#guild_war.guild_id, SeedL#guild_war.name}),
    RightList1 = lists:keyreplace(15, 1, RightList, {15, SeedR#guild_war.guild_id, SeedR#guild_war.name}),

    JoinList1 = util:shuffle(lists:sublist(JoinList, 3, length(JoinList) - 2)),
    SplitIndex = util:ceil(length(JoinList1) / 2),

    {L1, L2} = lists:split(SplitIndex, JoinList1),

    mk_left(LeftList1, L1) ++ mk_right(RightList1, L2) ++ [{19, 0, <<>>}].


mk_left(LeftList, []) ->
    LeftList;
mk_left(LeftList, L) ->
    case length(L) of
        1 ->
            GuildWar = lists:nth(1, L),
            lists:keyreplace(14, 1, LeftList, {14, GuildWar#guild_war.guild_id, GuildWar#guild_war.name});
        2 ->
            GuildWar1 = lists:nth(1, L),
            GuildWar2 = lists:nth(2, L),
            LeftList1 = lists:keyreplace(9, 1, LeftList, {9, GuildWar1#guild_war.guild_id, GuildWar1#guild_war.name}),
            lists:keyreplace(10, 1, LeftList1, {10, GuildWar2#guild_war.guild_id, GuildWar2#guild_war.name});
        3 ->
            GuildWar1 = lists:nth(1, L),
            GuildWar2 = lists:nth(2, L),
            GuildWar3 = lists:nth(3, L),
            LeftList1 = lists:keyreplace(1, 1, LeftList, {1, GuildWar1#guild_war.guild_id, GuildWar1#guild_war.name}),
            LeftList2 = lists:keyreplace(2, 1, LeftList1, {2, GuildWar2#guild_war.guild_id, GuildWar2#guild_war.name}),
            lists:keyreplace(10, 1, LeftList2, {10, GuildWar3#guild_war.guild_id, GuildWar3#guild_war.name});
        4 ->
            GuildWar1 = lists:nth(1, L),
            GuildWar2 = lists:nth(2, L),
            GuildWar3 = lists:nth(3, L),
            GuildWar4 = lists:nth(4, L),
            LeftList1 = lists:keyreplace(1, 1, LeftList, {1, GuildWar1#guild_war.guild_id, GuildWar1#guild_war.name}),
            LeftList2 = lists:keyreplace(2, 1, LeftList1, {2, GuildWar2#guild_war.guild_id, GuildWar2#guild_war.name}),
            LeftList3 = lists:keyreplace(3, 1, LeftList2, {3, GuildWar3#guild_war.guild_id, GuildWar3#guild_war.name}),
            lists:keyreplace(4, 1, LeftList3, {4, GuildWar4#guild_war.guild_id, GuildWar4#guild_war.name});
        _ ->
            ?ASSERT(false),
            ?ERROR_MSG("mod_guild_mgr:error!~n", [])
    end.

mk_right(RightList, []) ->
    RightList;
mk_right(RightList, L) ->
    case length(L) of
        1 ->
            GuildWar = lists:nth(1, L),
            lists:keyreplace(16, 1, RightList, {16, GuildWar#guild_war.guild_id, GuildWar#guild_war.name});
        2 ->
            GuildWar1 = lists:nth(1, L),
            GuildWar2 = lists:nth(2, L),
            RightList1 = lists:keyreplace(11, 1, RightList, {11, GuildWar1#guild_war.guild_id, GuildWar1#guild_war.name}),
            lists:keyreplace(12, 1, RightList1, {12, GuildWar2#guild_war.guild_id, GuildWar2#guild_war.name});
        3 ->
            GuildWar1 = lists:nth(1, L),
            GuildWar2 = lists:nth(2, L),
            GuildWar3 = lists:nth(3, L),
            RightList1 = lists:keyreplace(5, 1, RightList, {5, GuildWar1#guild_war.guild_id, GuildWar1#guild_war.name}),
            RightList2 = lists:keyreplace(6, 1, RightList1, {6, GuildWar2#guild_war.guild_id, GuildWar2#guild_war.name}),
            lists:keyreplace(12, 1, RightList2, {12, GuildWar3#guild_war.guild_id, GuildWar3#guild_war.name});
        4 ->
            GuildWar1 = lists:nth(1, L),
            GuildWar2 = lists:nth(2, L),
            GuildWar3 = lists:nth(3, L),
            GuildWar4 = lists:nth(4, L),
            RightList1 = lists:keyreplace(5, 1, RightList, {5, GuildWar1#guild_war.guild_id, GuildWar1#guild_war.name}),
            RightList2 = lists:keyreplace(6, 1, RightList1, {6, GuildWar2#guild_war.guild_id, GuildWar2#guild_war.name}),
            RightList3 = lists:keyreplace(7, 1, RightList2, {7, GuildWar3#guild_war.guild_id, GuildWar3#guild_war.name}),
            lists:keyreplace(8, 1, RightList3, {8, GuildWar4#guild_war.guild_id, GuildWar4#guild_war.name});
        _ ->
            ?ASSERT(false),
            ?ERROR_MSG("mod_guild_mgr:error!~n", [])
    end.

check_nth_round(_, []) ->
    false;
check_nth_round(List, [H | T]) ->
    case lists:keyfind(H, 1, List) of
        false ->
            check_nth_round(List, T);
        {_, GuildId, _} ->
            case GuildId =:= ?INVALID_ID of
                true -> 
                    check_nth_round(List, T);
                false ->
                    true
            end
    end.

decide_guild_war_round() ->
    List = get_guild_war_group(),
    case check_nth_round(List, lists:seq(1, 8)) of
        true -> set_guild_war_round(1);
        false ->
            case check_nth_round(List, lists:seq(9, 12)) of
                true ->
                    set_guild_war_round(2);
                false ->
                    case check_nth_round(List, lists:seq(13, 16)) of
                        true ->
                            set_guild_war_round(3);
                        false ->
                            ?ERROR_MSG("mod_guild_mgr:decide_guild_war_round!~n", [])
                    end
            end
    end.

%% 一个轮回的第一周的周五0点调用
decide_guild_war_time() ->
    Round = get_guild_war_round(),

    [{Hour, Min} | _T] = mod_activity:publ_get_activity_open_time(?AD_GUILD_WAR),

    %% 第一轮开始时间
    Time = 24*3600 + util:calc_today_0_sec() + 3600*Hour + Min * 60,

    WarTimeL = 
        if
            Round =:= 1 ->
                [{Round, Time}, {Round+1, Time+3600*24}, {Round+2, Time+3600*24*7}, {Round+3, Time+3600*24*8}];
            Round =:= 2 ->
                [{Round, Time+3600*24}, {Round+1, Time+3600*24*7}, {Round+2, Time+3600*24*8}];
            Round =:= 3 ->
                [{Round, Time+3600*24*7}, {Round + 1, Time+3600*24*8}];
            true ->
                []
        end,
    set_guild_war_time(WarTimeL).


%% return [{Slot1, GuildId, Slot2, ObjGuildId}]
get_join_guild_by_round(Round) ->
    GroupList = get_guild_war_group(),
    F = fun(Index, Acc) ->
        case lists:keyfind(Index, 1, GroupList) of
            false -> Acc;
            {Slot1, GuildId, _Name} ->
                case GuildId =:= ?INVALID_ID of
                    true -> Acc;
                    false ->
                        case lists:keyfind(Index + 1, 1, GroupList) of
                            false ->
                                ?ASSERT(false),
                                ?ERROR_MSG("mod_guild_mgr:get_join_guild_by_round error!Index:~p~n", [Index]),
                                Acc;
                            {Slot2, ObjGuildId, _} ->
                                case ObjGuildId =:= ?INVALID_ID of
                                    true -> %% 该轮的左边 或者 右边 没有比赛
                                        [{Slot1, GuildId, Slot2, ObjGuildId} | Acc];
                                    false ->
                                        [{Slot1, GuildId, Slot2, ObjGuildId} | Acc]
                                end
                        end
                end
        end
    end,
    Ret = 
    if
        Round =:= 1 ->
            lists:foldl(F, [], [1, 3]) ++ lists:foldl(F, [], [5, 7]);
        Round =:= 2 ->
            lists:foldl(F, [], [9]) ++ lists:foldl(F, [], [11]);
        Round =:= 3 ->
            lists:foldl(F, [], [13]) ++ lists:foldl(F, [], [15]);
        Round =:= 4 ->
            lists:foldl(F, [], [17]);
        true ->
            []
    end,
    ?DEBUG_MSG("get_join_guild_by_round: Round:~p, [{Slot1,Id1,Slot2,Id2}]:~w~n", [Round, Ret]),
    Ret.


%% 目前生成前4名的排名
get_guild_id_by_rank(GroupList, Rank) ->
    if
        Rank =:= 1 ->
            case lists:keyfind(19, 1, GroupList) of
                false ->
                    ?ERROR_MSG("mod_guild_mgr: group slot 19 error!~n", []),
                    ?INVALID_ID;
                {_, GuildId, _} ->
                    GuildId
            end;
        Rank =:= 2 ->
            case lists:keyfind(17, 1, GroupList) of
                false ->
                    ?ERROR_MSG("mod_guild_mgr: group slot 17 error!~n", []),
                    ?INVALID_ID;
                {_, GuildId, _} ->
                    case GuildId =:= get_guild_id_by_rank(GroupList, 1) of
                        false ->
                            GuildId;
                        true ->
                            case lists:keyfind(18, 1, GroupList) of
                                false ->
                                    ?ERROR_MSG("mod_guild_mgr: group slot 18 error!~n", []),
                                    ?INVALID_ID;
                                {_, GuildId2, _} ->
                                    GuildId2
                            end
                    end
            end;
        Rank =:= 3 -> %% 第三 名 和 第四名 是 除了1、2名外，在 13 14 15 16 的格子随机选择
            GuildId1 = get_guild_id_by_rank(GroupList, 1),
            GuildId2 = get_guild_id_by_rank(GroupList, 2),
            case lists:keyfind(13, 1, GroupList) of
                false ->
                    ?ERROR_MSG("mod_guild_mgr: error group slot 13 !~n", []),
                    ?INVALID_ID;
                {_, GuildId, _} ->
                    case GuildId =:= GuildId1 orelse GuildId =:= GuildId2 of
                        false -> GuildId;
                        true ->
                            case lists:keyfind(14, 1, GroupList) of
                                false ->
                                    ?ERROR_MSG("mod_guild_mgr: group slot 14 error!~n", []),
                                    ?INVALID_ID;
                                {_, GuildId3, _} ->
                                    GuildId3
                            end
                    end
            end;
        Rank =:= 4 ->
            GuildId1 = get_guild_id_by_rank(GroupList, 1),
            GuildId2 = get_guild_id_by_rank(GroupList, 2),
            case lists:keyfind(15, 1, GroupList) of
                false ->
                    ?ERROR_MSG("mod_guild_mgr: group slot 15 error!~n", []),
                    ?INVALID_ID;
                {_, GuildId, _} ->
                    case GuildId =:= GuildId1 orelse GuildId =:= GuildId2 of
                        false -> GuildId;
                        true ->
                            case lists:keyfind(16, 1, GroupList) of
                                false ->
                                    ?ERROR_MSG("mod_guild_mgr: group slot 16 error!~n", []),
                                    ?INVALID_ID;
                                {_, GuildId4, _} ->
                                    GuildId4
                            end
                    end
            end;
        true ->
            ?INVALID_ID
    end.


mk_guild_war_rank() ->
    case get_guild_war_group() of
        [] ->
            [];
        GroupList ->
            F = fun(Rank, Acc) ->
                GuildId = get_guild_id_by_rank(GroupList, Rank),
                case lib_guild:get_guild_war_from_ets(GuildId) of
                    null ->
                        Acc;
                    GuildWar ->
                        [{Rank, GuildId, GuildWar#guild_war.total_bid, GuildWar#guild_war.name} | Acc]
                end
            end,

            lists:foldl(F, [], lists:seq(1, 4))
    end.

handle_war_result(WinGuildId, WinSlot) ->
    GroupList = get_guild_war_group(),
    Round = get_guild_war_round(),

    NewGroupList = 
    case lists:keyfind(WinSlot, 1, GroupList) of
        false ->
            ?ERROR_MSG("mod_guild_mgr: find win guild id error!~n", []),
            GroupList;
        {_, GuildId, Name} ->
            case GuildId =:= WinGuildId of
                false ->
                    ?ERROR_MSG("mod_guild_mgr: guild id not same!~n", []),
                    GroupList;
                true ->
                    if
                        Round =:= 1 ->
                            case WinSlot of
                                1 -> lists:keyreplace(9, 1, GroupList, {9, WinGuildId, Name});
                                2 -> lists:keyreplace(9, 1, GroupList, {9, WinGuildId, Name});
                                3 -> lists:keyreplace(10, 1, GroupList, {10, WinGuildId, Name});
                                4 -> lists:keyreplace(10, 1, GroupList, {10, WinGuildId, Name});

                                5 -> lists:keyreplace(11, 1, GroupList, {11, WinGuildId, Name});
                                6 -> lists:keyreplace(11, 1, GroupList, {11, WinGuildId, Name});
                                7 -> lists:keyreplace(12, 1, GroupList, {12, WinGuildId, Name});
                                8 -> lists:keyreplace(12, 1, GroupList, {12, WinGuildId, Name});
                                _ ->
                                    ?ASSERT(false),
                                    GroupList
                            end;
                        Round =:= 2 ->
                            case lists:member(WinSlot, [9, 10]) of
                                true ->
                                    lists:keyreplace(14, 1, GroupList, {14, WinGuildId, Name});
                                false ->
                                    ?ASSERT(WinSlot =:= 11 orelse WinSlot =:= 12, WinSlot),
                                    lists:keyreplace(16, 1, GroupList, {16, WinGuildId, Name})
                            end;
                        Round =:= 3 ->
                            case lists:member(WinSlot, [13, 14]) of
                                true ->
                                    lists:keyreplace(17, 1, GroupList, {17, WinGuildId, Name});
                                false ->
                                    ?ASSERT(WinSlot =:= 15 orelse WinSlot =:= 16, WinSlot),
                                    lists:keyreplace(18, 1, GroupList, {18, WinGuildId, Name})
                            end;
                        Round =:= 4 ->
                            ?ASSERT(WinSlot =:= 17 orelse WinSlot =:= 18, WinSlot),
                            lists:keyreplace(19, 1, GroupList, {19, WinGuildId, Name});
                        true ->
                            GroupList
                    end
            end
    end,

    %% 设置新的分组
    set_guild_war_group(NewGroupList),

    %% 标记比赛结束
    case lib_guild:get_guild_war_from_ets(WinGuildId) of
        null ->
            skip;
        WinGuildWar ->
            case is_pid_ok(WinGuildWar#guild_war.war_dun_pid) of
                true ->
                    lib_dungeon:close_dungeon(WinGuildWar#guild_war.war_dun_pid);
                false ->
                    skip
            end,
            lib_guild:update_guild_war_to_ets(WinGuildWar#guild_war{finish = 1}),
            mod_guild_war:stop(WinGuildWar#guild_war.war_handle_pid)
    end,
    case lib_guild:get_guild_war_from_ets(get_guild_war_obj_guild(WinGuildId)) of
        null ->
            skip;
        LoseGuildWar ->
            case is_pid_ok(LoseGuildWar#guild_war.war_dun_pid) of
                true ->
                    lib_dungeon:close_dungeon(LoseGuildWar#guild_war.war_dun_pid);
                false ->
                    skip
            end,
            mod_guild_war:stop(LoseGuildWar#guild_war.war_handle_pid),
            lib_guild:update_guild_war_to_ets(LoseGuildWar#guild_war{finish = 1})
    end,

    case check_the_round_all_finish() of
        false -> skip;
        true -> 
            %% 设置下一轮数据（注意：轮数不能马上清零，因为需要看比赛结果）
            case Round =:= 4 of
                true -> %% 一个轮回结束，生成排名，重置数据
                    RankList = mk_guild_war_rank(),

                    %% 发放和回收称号
                    NewFirstGuildId = get_guild_id_by_rank(get_guild_war_group(), 1),
                    OldFirstGuildId = get_old_first_guild_id(),

                    spawn(fun() -> handle_title(NewFirstGuildId, OldFirstGuildId) end),

                    set_guild_war_last_rank(RankList),

                    set_guild_war_counter(0),

                    %% 届数加1
                    set_guild_war_turn(get_guild_war_turn() + 1),

                    %% 清空帮派投标数据
                    reset_guild_bid_data();
                false ->
                    set_guild_war_round(Round + 1)
            end
    end,
    db_save_guild_war().


%% 帮派管理进程调用
db_save_guild_war() ->
    mod_data:save(?SYS_GUILD, [
        {w_turn, get_guild_war_turn()},
        {w_roud, get_guild_war_round()}, 
        {w_time, get_guild_war_time()}, 
        {w_counter, get_guild_war_counter()}, 
        {w_last_rank, get_guild_war_last_rank()},
        {w_group, get_guild_war_group()},
        {w_min_bid, get_guild_war_min_bid()}
    ]).


init_guild_war() ->
    DataList = mod_data:load(?SYS_GUILD),
    F = fun({Key, Value}) ->
        ?INFO_MSG("mod_guild_mgr:init_guild_war:Key:~p, Value:~w~n", [Key, Value]),
        case Key of
            w_turn -> set_guild_war_turn(Value);
            w_roud -> set_guild_war_round(Value);
            w_time -> set_guild_war_time(Value);
            w_counter -> set_guild_war_counter(Value);
            w_last_rank -> set_guild_war_last_rank(Value);
            w_group -> set_guild_war_group(Value);
            w_min_bid -> set_guild_war_min_bid(Value)
        end
    end,
    DataList1 = 
        case DataList =:= [] of
            true -> [];
            false -> erlang:hd(DataList)
        end,

    [F(X) || X <- DataList1].

    %% 帮派争霸赛过程，(系统)解散了帮派，为方便处理，做容错
    % F2 = fun(X) ->
    %     GuildSIList = get_join_guild_by_round(X),
    %     F1 = fun({_, GuildId, _, ObjGuildId}) ->
    %         case lib_guild:get_guild_war_from_ets(GuildId) of
    %             null ->
    %                 GuildWar = #guild_war{guild_id = GuildId, name = <<"未知帮派">>},
    %                 lib_guild:add_guild_war_to_ets(GuildWar);
    %             _ -> skip
    %         end,

    %         case lib_guild:get_guild_war_from_ets(ObjGuildId) of
    %             null ->
    %                 ObjGuildWar = #guild_war{guild_id = ObjGuildId, name = <<"未知帮派">>},
    %                 lib_guild:add_guild_war_to_ets(ObjGuildWar);
    %             _ -> skip
    %         end
    %     end,

    %     [F1(Para) || Para <- GuildSIList]
    % end,
    % Round = get_guild_war_round(),
    % [F2(X) || X <- lists:seq(Round, 3)].



%% 帮派管理进程调用
refund_to_player(GuildWarL, Flag) ->
    ?INFO_MSG("mod_guild_mgr:refund_to_player begin!...~n", []),
    Content = 
        case Flag of
            guild_cnt_limit -> <<"主人，因为帮派争霸参赛的帮派不足4个，故这届帮派争霸赛将取消，这里是退回来的盘缠，请主人查收。">>;
            bid_cnt_limit -> <<"主人，我们的出价未进入帮派总出价的前十名，无法进入帮派争霸赛，这里是退回来的盘缠，请主人查收。">>;
            guild_disband -> <<"主人，因您所在的帮派已解散，无法参加此界帮派争霸赛，这里是退回来的盘缠，请主人查收。">>
        end,

    F = fun(GuildWar) ->
        lib_log:statis_guild_war(GuildWar#guild_war.guild_id, mod_guild:get_lv(GuildWar#guild_war.guild_id), "sign_0"),

        F0 = fun(Id) ->
            case mod_guild:get_member_info(Id) of
                null -> %% 玩家退出帮派时已经返还过
                    skip;
                GuildMb ->
                    case GuildMb#guild_mb.bid > 0 of
                        false -> skip;
                        true ->
                            case Flag =:= guild_disband of
                                true -> skip;
                                false -> mod_guild:update_member_to_ets(Id, GuildMb#guild_mb{bid = 0, is_dirty = true})
                            end,
                            lib_mail:send_sys_mail(Id, <<"帮派争霸通知">>, Content, [{89001, max(GuildMb#guild_mb.bid, 0)}], [?LOG_GUILD_BATTLE, "sign_back"])
                    end
            end
        end,
        [F0(X) || X <- GuildWar#guild_war.bid_id_list],

        case Flag =:= guild_disband of
            true -> skip;
            false ->
                case mod_guild:get_info(GuildWar#guild_war.guild_id) of
                    null ->
                        skip;
                    Guild ->
                        NewGuild = Guild#guild{total_bid = 0, bid_id_list = []},
                        mod_guild:update_guild_to_ets(NewGuild)
                end
        end
    end,
    [F(X) || X <- GuildWarL].


%% 需要在帮派管理进程调用
reset_guild_bid_data() ->
    ?INFO_MSG("mod_guild_mgr:reset_guild_bid_data begin!...~n", []),
    F = fun(GuildWar) ->
        case mod_guild:get_info(GuildWar#guild_war.guild_id) of
            null ->
                skip;
            Guild ->
                NewGuild = Guild#guild{total_bid = 0, bid_id_list = []},
                mod_guild:update_guild_to_ets(NewGuild),
                mod_guild:db_save_guild(NewGuild)
        end,

        F0 = fun(Id) ->
            case mod_guild:get_member_info(Id) of
                null ->
                    skip; %% 
                    % ?ERROR_MSG("mod_guild_mgr:get_member_info error~n", []);
                GuildMb ->
                    mod_guild:update_member_to_ets(Id, GuildMb#guild_mb{bid = 0, is_dirty = true})
            end
        end,
        [F0(X) || X <- GuildWar#guild_war.bid_id_list]
    end,
    [F(X) || X <- ets:tab2list(?ETS_GUILD_WAR)],
    ets:delete_all_objects(?ETS_GUILD_WAR).


%% 中标的帮派，所有成员不能返回投标值
% reset_guild_mb_bid_data(JoinGuildWarL) ->
%     F = fun(GuildWar) ->
%         F0 = fun(Id) ->
%             case mod_guild:get_member_info(Id) of
%                 null -> %% 玩家退出帮派时已经返还过
%                     skip;
%                 GuildMb ->
%                     ?ASSERT(GuildMb#guild_mb.bid > 0, GuildMb#guild_mb.bid),
%                     mod_guild:update_member_to_ets(Id, GuildMb#guild_mb{bid = 0, is_dirty = true})
%             end
%         end,
%         [F0(X) || X <- GuildWar#guild_war.bid_id_list]
%     end,

%     [F(X) || X <- JoinGuildWarL].


check_the_round_all_finish() ->
    GuildIdList = get_join_guild_by_round(get_guild_war_round()),
    F = fun({_, GuildId, _, _ObjGuildId}, Acc) ->
        case lib_guild:get_guild_war_from_ets(GuildId) of
            null -> Acc;
            GuildWar ->
                case GuildWar#guild_war.finish =:= 1 of
                    true -> Acc + 1;
                    false -> Acc
                end
        end
    end,
    lists:foldl(F, 0, GuildIdList) =:= length(GuildIdList).


statis_guild_bid_ok_log(JoinList) ->
    F = fun(GuildWar) when is_record(GuildWar, guild_war) ->
        GuildId = GuildWar#guild_war.guild_id,
        lib_log:statis_guild_war(GuildId, mod_guild:get_lv(GuildId), "sign_1");
        (_) -> error
    end,

    [F(X) || X <- JoinList].


is_pid_ok(Pid) ->
    is_pid(Pid) andalso is_process_alive(Pid).


handle_title(NewFirstGuildId, OldFirstGuildId) ->
    case OldFirstGuildId =:= ?INVALID_ID of
        true -> skip;
        false ->
            case mod_guild:get_info(OldFirstGuildId) of
                null -> skip;
                OldGuild ->
                    F1 = fun(Id) ->
                        case Id =:= OldGuild#guild.chief_id of
                            true ->
                                lib_offcast:cast(Id, {del_title, ?GUILD_TITLE_NO_FIRST_CHIEF});
                            false ->
                                lib_offcast:cast(Id, {del_title, ?GUILD_TITLE_NO_FIRST_GUILD})
                        end
                    end,
                    [F1(X) || X <- OldGuild#guild.member_id_list]
            end
    end,

    case mod_guild:get_info(NewFirstGuildId) of
        null -> skip;
        NewGuild ->
            F2 = fun(Id) ->
                case Id =:= NewGuild#guild.chief_id of
                    true ->
                        lib_offcast:cast(Id, {add_title, ?GUILD_TITLE_NO_FIRST_CHIEF, util:unixtime()});
                    false ->
                        lib_offcast:cast(Id, {add_title, ?GUILD_TITLE_NO_FIRST_GUILD, util:unixtime()})
                end
            end,
            [F2(X) || X <- NewGuild#guild.member_id_list]
    end.


%% 需要上层保持数据库
handle_bid_for_leave_guild(Guild, PlayerId) ->
    case lib_guild:get_guild_war_from_ets(Guild#guild.id) of
        null ->
            Guild;
        GuildWar ->
            case lists:member(PlayerId, GuildWar#guild_war.bid_id_list) of
                false -> Guild;
                true ->
                    case mod_guild:get_member_info(PlayerId) of
                        null ->
                            ?ASSERT(false),
                            ?ERROR_MSG("mod_guild_mgr:get_member_info error~n", []),
                            NewGuild = Guild#guild{bid_id_list = Guild#guild.bid_id_list -- [PlayerId]},
                            lib_guild:update_guild_war_to_ets(GuildWar#guild_war{bid_id_list = GuildWar#guild_war.bid_id_list -- [PlayerId]}),
                            NewGuild;
                        GuildMb ->
                            case GuildMb#guild_mb.bid > 0 of
                                false -> Guild;
                                true -> 
                                    NewGuild = Guild#guild{bid_id_list = Guild#guild.bid_id_list -- [PlayerId], total_bid = Guild#guild.total_bid - GuildMb#guild_mb.bid},

                                    lib_guild:update_guild_war_to_ets(GuildWar#guild_war{total_bid = GuildWar#guild_war.total_bid - GuildMb#guild_mb.bid, 
                                    bid_id_list = GuildWar#guild_war.bid_id_list -- [PlayerId]}),

                                    case war_allow_disband(Guild#guild.id) of
                                        true ->
                                            lib_mail:send_sys_mail(PlayerId, <<"帮派争霸通知">>, <<"离开帮派，返还你的金额">>, 
                                                [{89001, max(GuildMb#guild_mb.bid, 0)}], []);
                                        false -> skip %% 退出已经中标的帮派 不能返回
                                    end,

                                    NewGuild
                            end
                    end
            end
    end.


notify_to_all(MbIdList, OldName, NewName) ->
    Title = <<"帮派改名通知">>,
    Content = list_to_binary(io_lib:format(<<"官人，您的帮派 #f01870 ~s #7a4a19 已经改名为 #f01870 ~s #7a4a19 了">>, [OldName, NewName])),
    F = fun(X) ->
        lib_mail:send_sys_mail(X, Title, Content, [], [?LOG_MAIL, "recv_guild"]),
        case player:is_online(X) of
            false -> skip;
            true -> lib_scene:notify_string_info_change_to_aoi(X, [{?OI_CODE_GUILDNAME, NewName}])
        end
    end,
    [F(X) || X <- MbIdList].


sys_try_disband_guild() ->
    GuildList = mod_guild:get_guild_list(),
    F = fun(Guild) ->
        case mod_global_data:is_player_deleted(mod_guild:get_chief_id(Guild)) of
            false -> skip;
            true -> mod_guild:sys_disband_guild(Guild)
        end
    end,
    [F(X) || X <- GuildList].