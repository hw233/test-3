%%%-----------------------------------
%%% @Module  : ply_arena_1v1
%%% @Author  : liuzhongzheng2012@gmail.com
%%% @Email   :
%%% @Created : 2014.6.10
%%% @Description: 在线1v1竞技场(玩家进程)
%%%-----------------------------------

-module(ply_arena_1v1).

-include("battle.hrl").
-include("record.hrl").
-include("record/battle_record.hrl").
-include("common.hrl").
-include("arena_1v1.hrl").
-include("activity_degree_sys.hrl").
-include("rank.hrl").
-include("pt_27.hrl").
-include("char.hrl").
-include("log.hrl").
-include("prompt_msg_code.hrl").

-export([
	join/1,
    leave/1,
    start_pk/1,
    daily_reset/1,
    weekly_reset/1,
    send_info/1,
    send_report/1,
    send_week_top/1,
    award/2,
    on_player_tmp_logout/1,
    arena_1v1_close/0
	]).

-define(ACTID, ?AD_ARENA_1V1).
-define(BCAST_ID, 59).

% 活动结束回调
arena_1v1_close() ->
    mod_arena_1v1:arena_1v1_close().

%% 参加比武
join(PS) ->
    UID = player:id(PS),
    IsActOn = mod_activity:publ_is_activity_alive(?ACTID),
    IsIdle = player:is_idle(PS),
    IsLvOK = player:get_lv(PS) >= ?MIN_LV,
    IsInTeam = player:is_in_team(PS),
    IsCanTry =
        case get_arena(UID) of
            #arena1{day_wins=Wins, day_all=All}
                        when All >= ?MAX_DAY_WIN ->
                        % orelse All - Wins >= ?MAX_DAY_LOST ->
                ?false;
            _ ->
                ?true
        end,
    case IsActOn
    andalso IsLvOK
    andalso IsIdle
    andalso IsCanTry
    andalso (not IsInTeam) of
        ?true ->
            init_arena(PS),
            do_join(PS);
        _ ->
            lib_send:send_prompt_msg(PS, ?PM_ARARE_REASON),
            ?WARNING_MSG("Cannot join, ~p", [[IsActOn, IsLvOK, IsIdle, IsCanTry]])
    end.

do_join(PS) ->
    Waiter = build_waiter(PS),
    player:set_cur_bhv_state(PS, ?BHV_ARENA_1V1_WAITING),
    mod_arena_1v1:join(Waiter).

init_arena(PS) ->
    UID = player:id(PS),
    case get_arena(UID) of
        null ->
            set_arena(UID, #arena1{id=UID});
        _ ->
            ok
    end.

%% 离开比武
leave(PS) ->
    case player:get_cur_bhv_state(PS) of
        ?BHV_ARENA_1V1_WAITING ->
            player:set_cur_bhv_state(PS, ?BHV_IDLE),
            Waiter = build_waiter(PS),
            mod_arena_1v1:leave(Waiter);
        %% 玩家已经匹配，准备战斗状态
        ?BHV_ARENA_1V1_READY ->
            ?ylh_Debug("BHV_ARENA_1V1_READY ~n"),
            arena_count_add(player:id(PS)),
            player:set_cur_bhv_state(PS, ?BHV_IDLE),
            Waiter = build_waiter(PS),
            mod_arena_1v1:leave(Waiter),
            % OppoID = erlang:get({ply_arena_1v1, player:id(PS)}),
            OppoID = lib_arena_1v1:get_lib_arena_1v1_cache(player:id(PS)),
            ?ylh_Debug("leave ply_arena_1v1 OppoID= ~p ~n",[OppoID]),
            lib_log:statis_arena_1v1(player:id(PS), "lose", OppoID), %% 后台统计
            case OppoID of
                null ->
                    skip;
                _ ->
                    player:set_cur_bhv_state(player:get_PS(OppoID), ?BHV_ARENA_1V1_WAITING)
            end;
        _ ->
            ok
    end.

%% 发送周榜首
send_week_top(PS) ->
    MyID = player:id(PS),
    {UID, Name} = mod_arena_1v1:get_week_top(),
    {ok, Bin} = pt_27:write(?PT_ARENA_1V1_WEEK_TOP, [UID, Name]),
    lib_send:send_to_uid(MyID, Bin).


build_waiter(PS) ->
    UID = player:id(PS),
    Lv = player:get_lv(PS),
    Name = player:get_name(PS),
    Race = player:get_race(PS),
    Sex = player:get_sex(PS),
    Rand = util:rand(1, 1000000),
    Waiter = #waiter{id=UID, name=Name, race=Race, lv=Lv, rand=Rand, sex=Sex},
    case get_arena(UID) of
        #arena1{day_wins=Wins}=Arena ->
            WinRate = calc_win_rate(Arena),
            Waiter#waiter{win=Wins, win_rate=WinRate};
        _ ->
            Waiter#waiter{win=0, win_rate=0}
    end.

%% 日重置
daily_reset(PS) ->
    UID = player:id(PS),
    case get_arena(UID) of
        #arena1{}=Arena ->
            Arena1 = Arena#arena1{day_wins=0, day_all=0},
            set_arena(UID, Arena1);
        _ ->
            pass
    end,
    ok.

%% 周重置
weekly_reset(PS) ->
    UID = player:id(PS),
    case get_arena(UID) of
        #arena1{}=Arena ->
            Arena1 = Arena#arena1{week_wins=0, week_all=0, recs=[]},
            set_arena(UID, Arena1);
        _ ->
            pass
    end,
    ok.

%% 战斗中掉线的补丁...
on_player_tmp_logout(PS) ->
    leave(PS),
    ok.

%% 向客户端发胜负情况
send_info(PS) ->
    UID = player:id(PS),
    Arena = get_arena(UID),
    send_info(UID, Arena).

send_info(UID, #arena1{day_wins=DW,
                    day_all=DA,
                    week_wins=WW,
                    week_all=WA
                    }) ->
    DL = DA - DW,
    WL = WA - WW,
    {ok, Bin} = pt_27:write(?PT_ARENA_1V1_INFO, [DW, DL, WW, WL]),
    lib_send:send_to_uid(UID, Bin);
send_info(UID, _) ->
    {ok, Bin} = pt_27:write(?PT_ARENA_1V1_INFO, [0, 0, 0, 0]),
    lib_send:send_to_uid(UID, Bin).

%% 向客户端发个人战报
send_report(PS) ->
    UID = player:id(PS),
    Arena = get_arena(UID),
    send_report(UID, Arena).

send_report(UID, #arena1{recs=Recs}) ->
    {ok, Bin} = pt_27:write(?PT_ARENA_1V1_REPORTS, [1, Recs]),
    lib_send:send_to_uid(UID, Bin);
send_report(UID, _) ->
    {ok, Bin} = pt_27:write(?PT_ARENA_1V1_REPORTS, [1, []]),
    lib_send:send_to_uid(UID, Bin).

%% 开始PK
start_pk({ID1, ID2}) ->
    PS1 = player:get_PS(ID1),
    PS2 = player:get_PS(ID2),
    case is_record(PS1, player_status) andalso
         is_record(PS2, player_status) andalso
         player:is_online(player:id(PS1)) andalso
         player:is_online(player:id(PS2)) andalso
         player:is_arena_1v1_ready(PS1) andalso
         player:is_arena_1v1_ready(PS2) of
         true ->
            %恢复玩家为等待状态
            player:set_cur_bhv_state(PS1, ?BHV_ARENA_1V1_WAITING),
            player:set_cur_bhv_state(PS2, ?BHV_ARENA_1V1_WAITING),
            arena_count_add(ID1),
            arena_count_add(ID2),
            mod_achievement:notify_achi(join_arena_1v1, [], ID1),
            mod_achievement:notify_achi(join_arena_1v1, [], ID2),
            mod_arena_1v1:set_battle_flag(ID1),
            mod_arena_1v1:set_battle_flag(ID2),
            mod_battle:start_1v1_online_arena_pk(PS1, PS2, fun pk_callback/2);
        false ->
            case player:get_cur_bhv_state(PS1) of
                %%有玩家离开
                ?BHV_ARENA_1V1_READY ->
                    ?ylh_Debug("start_pk ~n"),
                    player:set_cur_bhv_state(PS1, ?BHV_ARENA_1V1_WAITING);
                _ ->
                    ok
            end,
            case player:get_cur_bhv_state(PS2) of
                %%有玩家离开
                ?BHV_ARENA_1V1_READY ->
                    ?ylh_Debug("start_pk ~n"),
                    player:set_cur_bhv_state(PS2, ?BHV_ARENA_1V1_WAITING);
                _ ->
                    ok
            end,
            ?ERROR_MSG("ply_arena_1v1 start_pk error ~n", []),
            skip
    end.

%% 处理PK结果
pk_callback(UID, Feedback) ->
    case get_arena(UID) of
        #arena1{day_wins=Wins, day_all=All}=Arena
                    when All =< ?MAX_DAY_WIN ->
                    %andalso All - Wins =< ?MAX_DAY_LOST ->
                        % 因类all是一进入就加的, 因此这里要允许等号
            Rec = make_rec(Feedback),
            Arena1 = update_arena(UID, Rec, Arena),
            report(UID, Rec, Arena1),
            bcast(UID, Arena1),
            % 修改为统一活动结束后才发奖，去掉失败3场或赢最大10场发放奖励
            % award(UID, Arena1, Feedback), 
            award_exp(UID, Feedback),
            mod_rank:arena_1v1(Arena1),
            set_arena(UID, Arena1);
        _ ->
            ?WARNING_MSG("arena_1v1 battle too many times", [])
    end.


%% 生成战报
make_rec(#btl_feedback{player_id=UID, oppo_player_id_list=OppoPlayerIdList, result=win}) ->
    [TID] = OppoPlayerIdList,
    Rec = #rec{winer=UID, loser=TID, time=util:unixtime()},
    mod_achievement:notify_achi(win_arena_1v1, [], UID),
    lib_log:statis_arena_1v1(UID, "win", TID), %% 后台统计
    make_rec_name(Rec);
make_rec(#btl_feedback{player_id=UID, oppo_player_id_list=OppoPlayerIdList}) ->
    [TID] = OppoPlayerIdList,
    Rec = #rec{winer=TID, loser=UID, time=util:unixtime()},
    lib_log:statis_arena_1v1(UID, "lose", TID), %% 后台统计
    make_rec_name(Rec). % 平当双输

make_rec_name(#rec{winer=WID, loser=LID}=Rec) ->
    WName = player:get_name(WID),
    LName = player:get_name(LID),
    Rec#rec{winer_name=WName, loser_name=LName}.

arena_count_add(UID) ->
    Arena = get_arena(UID),
    Arena1 = arena_count_add_1(Arena),
    set_arena(UID, Arena1).
arena_count_add_1(#arena1{day_all=DA, week_all=WA}=Arena) ->
    Arena#arena1{day_all=DA+1, week_all=WA+1}.

update_arena(UID,
             #rec{winer=UID}=Rec,
             #arena1{day_wins=DWins, week_wins=WWins, recs=Recs}=Arena) ->
    Arena#arena1{day_wins=DWins+1, week_wins=WWins+1, recs=[Rec|Recs]};
update_arena(_UID,
             Rec,
             #arena1{recs=Recs}=Arena) ->
    Arena#arena1{recs=[Rec|Recs]};
update_arena(UID, Rec, _NotArena) ->
    update_arena(UID, Rec, #arena1{id=UID}).

%% 系统公告
bcast(UID, #arena1{day_wins=10}) ->
    Name = player:get_name(UID),
    mod_broadcast:send_sys_broadcast(?BCAST_ID, [Name, UID]); % 走马灯
bcast(_UID, _) ->
    ok.

%% 向竞技场进程发战报
report(UID, #rec{winer=UID}=Rec, #arena1{day_wins=DWins}) -> % 胜方发战报
    Rec1 = Rec#rec{winer_wins=DWins},
    mod_arena_1v1:report(Rec1);
report(_, _, _) ->
    ok.

%%% 发奖 版本1 -- 每次战斗后都发奖励
%award(UID, #arena1{day_wins=Wins}, #btl_feedback{result=win}) ->
%    award(UID, Wins);
%award(UID, _, _) ->
%    award(UID, 0).

%% 发奖 版本2 -- 奖励发放方式为玩家达到3负或者10胜时，发放一次奖励
% 已经10胜
award(UID, #arena1{day_wins=?MAX_DAY_WIN}, #btl_feedback{result=win}) ->
    award(UID, ?MAX_DAY_WIN); 
% 已经打够10场
award(UID, #arena1{day_wins=Wins, day_all=All}, _) when All=:=10 ->
    award(UID, Wins);
award(_UID, _Arena1, _BtlFeedback) ->
    skip.

award(UID, Wins) ->
    % 统一到mod_arena_1v1进程结算奖励
    mod_arena_1v1:award(UID, Wins).

% 经验奖励 (每次战斗后都发)
% 胜利
award_exp(UID, #btl_feedback{result=win}) -> 
    WinExpAdd = data_arena_1v1:get_win_exp(player:get_lv(UID)),
    player:add_exp(player:get_PS(UID), WinExpAdd, [?LOG_ARENA_1V1, "battle_1"]);
% 失败或者平手
award_exp(UID, _) ->
    LoseExpAdd = data_arena_1v1:get_lose_exp(player:get_lv(UID)),
    player:add_exp(player:get_PS(UID), LoseExpAdd, [?LOG_ARENA_1V1, "battle_0"]).

calc_win_rate(#arena1{day_wins=0}) ->
    0;
calc_win_rate(#arena1{day_all=0}) ->
    10000;
calc_win_rate(#arena1{day_wins=Wins, day_all=All}) ->
    round(Wins/All*10000).

get_arena(UID) ->
	ply_activity:get(UID, ?ACTID).

set_arena(UID, Data) ->
	ply_activity:set(UID, ?ACTID, Data).

