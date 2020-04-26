%%%-----------------------------------
%%% @Module  : mod_tve  t代表team
%%% @Author  : zwq
%%% @Email   :
%%% @Created : 2014.6.17
%%% @Description: 组队兵临城下 外围函数接口
%%%-----------------------------------

-module(mod_tve).


-export([
		init/0,
        get_tve_from_ets/1,
        add_tve_to_ets/1,
        update_tve_to_ets/1,

		db_save_all_tve_data/0,           %% 关服保存数据库
		get_tve_rank/1,
		notify_enter_result/5,            %% 通知进入副本结果
        get_player_tve_data/1,
        get_player_enter_time/1,          %% 获取玩家今天进入的次数
        set_player_tve_data/2,            %% 玩家进程调用
        is_in_tve_dungeon/1,
        check_start_tve_mf/1,             %% 检查能否触发战斗 次数 是否队长等
        tst_rank_reward/0,
		on_job_schedule/0,
		is_team_tve/1
	]).

-include("tve.hrl").
-include("debug.hrl").
-include("ets_name.hrl").
-include("job_schedule.hrl").
-include("common.hrl").
-include("pt_16.hrl").
-include("log.hrl").
-include("activity_degree_sys.hrl").
-include("dungeon.hrl").
-include("abbreviate.hrl").
-include("prompt_msg_code.hrl").


%% TVE_MGR_PROCESS 进程字典的key名
-define(PDKN_GET_RANK_REWARD_TIME, {pdkn_get_rank_reward_time, player_id}).          %% 玩家领取排名奖励时间


init() ->
    db_load_tve_data(),
    set_job_schedule(),
    ?AD_TVE =:= ?ACT_TVE_NO.


%% 由 mod_tve_mgr 进程处理
on_job_schedule() ->
    % 添加一个一周的任务调度
    set_job_schedule(7*24*3600),
    %% 发放排名奖励
    give_rank_reward(),

    db_delete_all_tve_data(),

    ets:delete_all_objects(?ETS_TVE).


-define(DB_SAVE_TVE_DATA_INTV, 20). % 保存各等级段排名数据到DB的间隔，单位：毫秒 

db_save_all_tve_data() ->
    List = ets:tab2list(?ETS_TVE),
    F = fun(Tve) ->
    	db:replace(?DB_SYS, tve_data, [{lv_step, Tve#tve.lv_step}, {data, util:term_to_bitstring(Tve#tve.rank)}]),
        timer:sleep(?DB_SAVE_TVE_DATA_INTV)   % 为避免瞬间集中存储，稍sleep一下！
    end,
    lists:foreach(F, List),
    ok.

%% return [] | tve_rank结构体列表
get_tve_rank(LvStep) ->
	case get_tve_from_ets(LvStep) of
		null -> [];
		Tve -> Tve#tve.rank
	end.

%% Flag %% 0->点否 1->使用物品 2->不使用物品
%% State 0 表示成功；1 表示失败
notify_enter_result(PS, State, PlayerIdList, Flag, LvStep) ->
	?ASSERT(Flag =:= 1 orelse Flag =:= 2 orelse Flag =:= 0, Flag),
    F = fun(X) ->
    	{ok, BinData} = pt_16:write(?PT_TVE_REPLY, [LvStep, State, [{Id, Flag} || Id <- PlayerIdList]]),
        lib_send:send_to_uid(X, BinData)
    end,
    [F(X) || X <- mod_team:get_normal_member_id_list(player:get_team_id(PS))].


%% [{enter_time,5},{enter_time_single,0}]  return null | player_tve_data 结构体 mod_tve:get_player_tve_data(1000300000047261).
get_player_tve_data(PlayerId) ->
	case  ets:lookup(?ETS_ACTIVITY_DATA, PlayerId) of
		[] ->
			#player_tve_data{};
		[PlobList] ->
			{_, Info} = PlobList ,
			case lists:keyfind(23, 1,Info ) of
				false ->
					#player_tve_data{};
				{23,ChangeValue} ->
					{enter_time,RealValue} = lists:keyfind(enter_time, 1  ,ChangeValue),
					#player_tve_data{ enter_time = RealValue}
			end
	end.


%% 统一由玩家进程调用  mod_tve:get_player_enter_time(1000300000047261).
set_player_tve_data(PlayerId, Data) when is_record(Data, player_tve_data) ->
    RecInfo = record_info(fields, player_tve_data),
    PlobLData = util:rec_to_pl(RecInfo, Data),
    ?DEBUG_MSG("mod_tve:set_player_tve_data Ret:~w~n", [PlobLData]),
	ply_activity:set(PlayerId, ?ACT_TVE_NO, PlobLData); %% 需要用宏


set_player_tve_data(PlayerId, ProbData) ->
	
	 try 
        PlayerTveData =  check_set_player_data(PlayerId, ProbData),
		set_player_tve_data(PlayerId, PlayerTveData)
    catch
        _: _ ->
            ?DEBUG_MSG("mod_tve:set_player_tve_data error ~n", [])
%% 			set_player_tve_data(PlayerId, ProbData#player_tve_data{enter_time = []})
			
    end .



%兼容数据错误的玩家，目前不清楚什么原因导致
check_set_player_data(PlayerId, ProbData) ->
	F = fun({Act, Value}, Acc) ->
				case lists:keytake(Act, 1, Acc#player_tve_data.enter_time) of
					false ->
						OldList = Acc#player_tve_data.enter_time,
						Acc#player_tve_data{enter_time = [{Act, 1}|OldList]};
					{value,NeeChangeData,SurplusData} ->
						{MyAct , Counter} = NeeChangeData,
						NewData = {MyAct , Counter + Value} ,
						Acc#player_tve_data{enter_time = [NewData | SurplusData]};
					_ ->
						Acc
				end
    end,
   lists:foldl(F, get_player_tve_data(PlayerId), ProbData).


get_player_enter_time(PlayerId) when is_integer(PlayerId) ->
    case get_player_tve_data(PlayerId) of
        null -> [];
        PlayerTveData -> PlayerTveData#player_tve_data.enter_time
    end;
get_player_enter_time(PS) ->
    get_player_enter_time(player:id(PS)).


check_start_tve_mf(PS) ->
    try 
        check_start_tve_mf__(PS)
    catch 
        throw: FailReason ->
            {fail, FailReason}
    end.


%% ---------------------------------------------------Local -----------------------------------------------

check_start_tve_mf__(PS) ->
    % 若在队伍中，则只能由队长操作
    ?Ifc (player:is_in_team_but_not_leader(PS) andalso (not player:is_tmp_leave_team(PS)))
        throw(cli_msg_illegal)
    ?End,

    % 玩家当前是否空闲？
    ?Ifc (not player:is_idle(PS))
        throw(?PM_BUSY_NOW)
    ?End,

    DunNo = player:get_dungeon_no(PS),
    ?Ifc (DunNo =:= null)
        throw(?PM_DUNGEON_OUSIDE)
    ?End,

    LvStep = get_lv_step_by_dun_no(DunNo),

    Data = data_tve:get(LvStep),
    ?Ifc (Data =:= null)
        throw(?PM_DATA_CONFIG_ERROR)
    ?End,

    MbList = mod_team:get_normal_member_id_list(player:get_team_id(PS)),

    ?Ifc (length(MbList) <  Data#tve_cfg.mb_limit)
        throw(?PM_RELA_MEMBER_NOT_ENOUGTH)
    ?End,

%%    ?Ifc (length(MbList) =/= length(mod_team:get_all_member_id_list(player:get_team_id(PS))))
%%        throw(?PM_DUNGEON_TEAM_STATUS)
%%    ?End,

    % FreeTime = Data#tve_cfg.times,
    % F = fun(Id, Sum) ->
    %     Time = mod_tve:get_player_enter_time(Id),
    %     case Time >= FreeTime of
    %         true -> Sum + 1;
    %         false -> Sum
    %     end
    % end,
    % Counter = lists:foldl(F, 0, MbList),
    % ?Ifc (Counter > 0)
    %     throw(?PM_TVE_MB_FREE_TIME_OVER)
    % ?End,

    ok.

tst_rank_reward() ->
    RankData = ets:tab2list(?ETS_TVE),
    give_rank_reward(RankData).

give_rank_reward() ->
    case mod_admin_activity:is_festival_activity_alive(12) of
        false -> skip;
        true ->
	       RankData = ets:tab2list(?ETS_TVE),
	       give_rank_reward(RankData)
    end.

give_rank_reward([]) ->
	skip;
give_rank_reward([H | T]) ->
	LvStep = H#tve.lv_step,
	give_rank_reward_for_step(LvStep, H#tve.rank, 1),
	give_rank_reward(T).


give_rank_reward_for_step(_, [], _) ->
	skip;
give_rank_reward_for_step(LvStep, [H | T], Rank) ->
	case Rank > 10 of
		true -> skip;
		false ->
			case data_tve_rank_reward:get(LvStep, Rank) of
				null ->
                    ?ERROR_MSG("mod_tve:cfg error! LvStep:~p, Rank:~p~n", [LvStep, Rank]),
					give_rank_reward_for_step(LvStep, T, Rank + 1);
				Cfg ->
					Title = Cfg#rank_reward.mail_title,
					Content = Cfg#rank_reward.mail_content,
					Now = util:unixtime(),
					F = fun(Id) ->
                        case Now - get_rank_reward_time(Id) > 60 * 5 of
                            true -> 
                                lib_mail:send_sys_mail(Id, Title, Content, Cfg#rank_reward.goods_list, [?LOG_DUNGEON, "tve"]),
                                set_rank_reward_time(Id, Now);
                            false -> skip
                        end
					end,
					[F(Id) || Id <- H#tve_rank.id_list],
					give_rank_reward_for_step(LvStep, T, Rank + 1)
			end
	end.


db_delete_all_tve_data() ->
    db:delete(?DB_SYS, tve_data, []).

db_load_tve_data() ->
	case db:select_all(tve_data, "lv_step, data", []) of
        InfoList_List when is_list(InfoList_List) ->
            F = fun([LvStep, Data]) ->
                    Tve = #tve{lv_step = LvStep, rank = case util:bitstring_to_term(Data) of undefined -> []; List -> List end},
                    add_tve_to_ets(Tve)
                end,
            lists:foreach(F, InfoList_List);
        _Any ->
            ?ASSERT(false, _Any),
            []
    end.


add_tve_to_ets(Tve) when is_record(Tve, tve) ->
    ets:insert(?ETS_TVE, Tve).


update_tve_to_ets(Tve) when is_record(Tve, tve) ->
    ets:insert(?ETS_TVE, Tve).

get_tve_from_ets(LvStep) ->
	case ets:lookup(?ETS_TVE, LvStep) of
          [] ->
               null;
          [R] ->
               R
     end.


%% return true | false
is_in_tve_dungeon(PS) ->
    DunNo = player:get_dungeon_no(PS),
    case DunNo =:= null of
        false ->
            DunType = lib_dungeon:get_dungeon_type(DunNo),
            DunType =:= ?DUNGEON_TYPE_TVE;
        true -> false
    end.


%% return true | false 
is_team_tve(No) ->
	 #tve_cfg{mb_limit = MbLimit} = data_tve:get(No),
	 MbLimit =/= 0.


set_job_schedule() ->
    % 根据本周剩余时间添加计时器
	DelayTime = (util:calc_week_left()) - 1*60, %% 23:59分结算
    mod_sys_jobsch:add_schedule(?JSET_GIVE_TVE_RANK_REWARD, DelayTime, []).

set_job_schedule(DelayTime) ->
    mod_sys_jobsch:add_schedule(?JSET_GIVE_TVE_RANK_REWARD, DelayTime, []).    

get_rank_reward_time(PlayerId) ->
    case erlang:get({?PDKN_GET_RANK_REWARD_TIME, PlayerId}) of
        undefined -> 0;
        Rd -> Rd
    end.

set_rank_reward_time(PlayerId, Info) ->
    erlang:put({?PDKN_GET_RANK_REWARD_TIME, PlayerId}, Info).


get_lv_step_by_dun_no(DunNo) ->
    get_lv_step_by_dun_no(data_tve:get_all_lv_step_no_list(), DunNo).

get_lv_step_by_dun_no([], _) ->
    ?INVALID_NO;
get_lv_step_by_dun_no([H | T], DunNo) ->
    case data_tve:get(H) of
        null ->
            get_lv_step_by_dun_no(T, DunNo);
        Data ->
            case Data#tve_cfg.dungeon_no =:= DunNo of
                true -> H;
                false -> get_lv_step_by_dun_no(T, DunNo)
            end
    end.