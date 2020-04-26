%%%------------------------------------
%%% @Module   : mod_player
%%% @Author   :
%%% @Email    :
%%% @Created  : 2011.04.29
%%% @Modified : 2013.6.4  -- huangjf
%%% @Description: 玩家进程的主模块
%%%------------------------------------
-module(mod_player).
-behaviour(gen_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([
		start/1,
		stop/1, stop/2,
		routing/3,
		battle_feedback/2
	]).

-export([		
		 cross_apply_cast/4,
		exchange_jingmai_point/2,
		wash_jingmai_point/1,
		do_set_jingmai_point/2,
		up_soaring/1
		,transfiguration/2
		,handle_mf_drop_local/2
		,check_chat_state/1
		,start_timer/2
		,upgrade_cross/2
	]).


-include("common.hrl").
-include("record.hrl").
-include("attribute.hrl").
-include("ets_name.hrl").
-include("abbreviate.hrl").
-include("job_schedule.hrl").
-include("pt_comm.hrl").
-include("pt_12.hrl").
-include("obj_info_code.hrl").
-include("record/battle_record.hrl").
-include("prompt_msg_code.hrl").
-include("num_limits.hrl").
-include("event.hrl").
-include("offline_arena.hrl").
-include("mail.hrl").
-include("pt_26.hrl").
-include("log.hrl").
-include("goods.hrl").
-include("drop.hrl").
-include("pt_13.hrl").
-include("sys_code.hrl").
-include("scene.hrl").
-include("buff.hrl").
-include("relation.hrl").
-include("faction.hrl").
-include("activity_degree_sys.hrl").
-include("player.hrl").
-include("guild_battle.hrl").
-include("jingmai.hrl").
-include("transfiguration.hrl").
-include("guild_battle.hrl").
-include("guild_dungeon.hrl").
-include("global_sys_var.hrl").
-include("task.hrl").
-include("pt_10.hrl").
-include("pt_11.hrl").
-include("pt_32.hrl").
-include("pt_37.hrl").
-include("pt_40.hrl").
-include("pt_53.hrl").
-include("pt_15.hrl").
-include("dungeon.hrl").
-include("reward.hrl").

%% 玩家进程的内部状态
-record(state, {
		id = ?INVALID_ID,  % 玩家id
		accname = "",
		from_server_id = ?INVALID_ID,
		socket = null,
		reader_pid = null,
		cross_state = ?CROSS_STATE_LOCAL
	}).

-define(GC_INTV, 600).


%% api
cross_apply_cast(Pid, Module, Function, Args) ->
	gen_server:cast(Pid, {cross_apply_cast, Module, Function, Args}).


%% 开启玩家进程
start(PlayerId) ->
    gen_server:start(?MODULE, [PlayerId], []).

init([_PlayerId]) ->
    process_flag(priority, max),

	% 心跳包时间检测
	put(?PDKN_DETECT_HEART_TIME, [0, 0]),
    put(?PDKN_LAST_GC_TIMESTAMP, util:unixtime()),

	% 状态初始为null，但角色进入游戏成功后会重新初始化状态，详见针对'init_internal_state'的处理
	{ok, null}.



%% 终止玩家进程
stop(Pid) when is_pid(Pid) ->
    stop(Pid, normal).

stop(Pid, Reason) when is_pid(Pid) ->
	?TRACE("[mod_player] stop(), Reason:~p~n", [Reason]),
	gen_server:cast(Pid, {'stop', Reason}).



%% 战斗反馈
battle_feedback(PlayerId, FeedbackInfo) ->
	case player:get_pid(PlayerId) of
		null ->
			?TRACE("[mod_player] battle_feedback(), pid is null!!!!!!~n"),
			skip;
		PlayerPid ->
			gen_server:cast(PlayerPid, {'battle_feedback', FeedbackInfo})
	end.


%% 终止玩家进程（处理退出游戏）
terminate(Reason, State) ->
	?TRY_CATCH(do_terminate(Reason, State)).

do_terminate(Reason, State) ->
	?TRACE("[mod_player] terminate()!!!!!!!  State:~w, Reason:~w~n", [State, Reason]),
	?Ifc (Reason /= normal andalso Reason /= {shutdown, server_stop})
		?ERROR_MSG("[mod_player] State=~w, !!!!!terminate!!!!! for reason:~w~nstacktrace:~w", [State, Reason, erlang:get_stacktrace()]),
		case State of
			null ->
				skip;
			_ ->
				mod_login:before_disconnect(State#state.accname, State#state.from_server_id, State#state.id),
				(State#state.reader_pid) ! {player_proc_crash, State#state.id, self()}
		end
	?End,
	case State of
		null ->
			skip;   % 这里是否需要做相关处理（比如关闭tcp连接）？---- 目前认为不需要!
		_ ->
			PlayerId = State#state.id,
			ReaderPid = State#state.reader_pid,
			?ASSERT(is_pid(ReaderPid), State),

        	proc_logger:del_player(self()),

			% 稳妥起见，主动发一条消息给reader进程，使其退出，以避免进程残余
			ReaderPid ! {player_proc_terminate, PlayerId, self()},

			PS = player:get_PS(PlayerId),
			?ASSERT(is_record(PS, player_status), {PlayerId, PS}),

			?LDS_TRACE("terminate delay", [player:get_final_logout_delay()]),

			FinalLogoutDelay = 	case Reason of
									{shutdown, server_stop} -> ?TRACE("[mod_player] player terminate for server_stop, Id:~p~n", [PlayerId]), false;
									_ -> player:get_final_logout_delay()
								end,
			mod_login:tmp_logout(PS, FinalLogoutDelay),

			% 针对进入游戏失败（未完全初始化成功）的情况做容错处理
			case is_init_for_enter_game_done__() of
				true -> skip;
				false -> player:force_mark_not_in_tmplogout_cache(PlayerId)
			end
	end,
    ok.



%% 统一模块+过程调用(cast)
handle_cast({apply_cast, Module, Method, Args}, State) ->
%%	?TRACE("mod_player, apply cast, ~p, ~p, ~p~n", [Module, Method, Args]),
    case (catch apply(Module, Method, Args)) of
        {'EXIT', Info} ->
            ?WARNING_MSG("mod_player_apply_cast error: Module=~p, Method=~p, Reason=~w",[Module, Method,Info]),
            error;
        _ -> ok
    end,
    {noreply, State};

%% 统一模块+过程调用(cast)，供跨服服务器rpc
handle_cast({cross_apply_cast, Module, Function, Args}, #state{cross_state = CrossState} = State) ->
	case CrossState of
		?CROSS_STATE_REMOTE ->
			?TRY_CATCH(erlang:apply(Module, Function, Args), ErrReason),
			ok;
		_ ->
			skip
	end,
	{noreply, State};



%% 准备触发mf战斗
handle_cast({'ready_to_start_mf', DoStartBattleFunc, Para}, State) when is_function(DoStartBattleFunc) ->
	PS = player:get_PS(State#state.id),
	case player:is_idle(PS) of  % 为避免重复触发战斗，故判断！
		true ->
			{ok, NewBattleId} = DoStartBattleFunc(Para),
			?ASSERT(is_integer(NewBattleId) andalso NewBattleId /= ?INVALID_ID, NewBattleId),
			ply_battle:set_last_battle_start_time(util:unixtime()),
			player_syn:mark_battling(PS, NewBattleId);
		false ->
			skip
	end,
    {noreply, State};


%% 玩家从战斗中逃跑后的处理
handle_cast({'after_escape_from_battle', Feedback}, State) ->
	PlayerId = State#state.id,
	?TRY_CATCH(handle_after_escape_from_battle(PlayerId, Feedback), ErrReason),

	% 重置为空闲
	player:mark_idle(PlayerId),
	ply_scene:notify_bhv_state_changed_to_aoi(PlayerId, ?BHV_IDLE),
   	{noreply, State};



%% 宠物从战斗中逃跑后的处理
handle_cast({'after_my_partner_escape_from_battle', PartnerId}, State) ->
	?TRY_CATCH(ply_partner:on_escape_from_battle(PartnerId), ErrReason),
   	{noreply, State};



%% 雇佣玩家从战斗中逃跑后的处理
handle_cast({'after_my_hired_player_escape_from_battle'}, State) ->
	PlayerId = State#state.id,
	ply_hire:try_update_hired_player(PlayerId),
   	{noreply, State};


%% 战斗进程发过来的反馈
%% @para:  FeedBackInfo => 战斗的反馈信息
handle_cast({'battle_feedback', Feedback}, State) ->
	player:mark_idle(State#state.id),
	?ASSERT(is_record(Feedback, btl_feedback), Feedback),
	PlayerId = State#state.id,

	% 为避免因战斗反馈处理有bug而导致玩家进程崩溃，故catch
	?TRY_CATCH(handle_battle_feedback(PlayerId, Feedback), ErrReason),

	% 重置为空闲
	player:mark_idle(PlayerId),
	ply_scene:notify_bhv_state_changed_to_aoi(PlayerId, ?BHV_IDLE),

	ply_battle:set_last_battle_finish_time(svr_clock:get_unixtime()),

   	{noreply, State};



%% 标记为空闲
handle_cast('mark_idle', State) ->
	PS = player:get_PS(State#state.id),
	player_syn:mark_idle(PS),
   	{noreply, State};


%% 标记为战斗中
handle_cast({'mark_battling', BattleId}, State) ->
	PS = player:get_PS(State#state.id),
	player_syn:mark_battling(PS, BattleId),
    {noreply, State};

handle_cast({'set_cur_bhv_state', CurBhvState}, State) ->
	PS = player:get_PS(State#state.id),
	player_syn:set_cur_bhv_state(PS, CurBhvState),
	ply_scene:notify_bhv_state_changed_to_aoi( player:id(PS), CurBhvState), % 顺带通知aoi
	{noreply, State};	

handle_cast({'reset_literary', Timestamp, NewLiterary}, State) ->
	Status = player:get_PS(State#state.id),
	player_syn:set_literary(Status, NewLiterary, Timestamp),
	{noreply, State};


handle_cast('reset_dun_info', State) ->
	Status = player:get_PS(State#state.id),
	player_syn:update_PS_to_ets(Status#player_status{dun_info = ?DEF_DUN_INFO}),
	{noreply, State};

handle_cast({'reset_dun_info', DunInfo, Pos}, State) ->
	Status = player:get_PS(State#state.id),
	player_syn:update_PS_to_ets(Status#player_status{dun_info = DunInfo, prev_pos = Pos}),
	{noreply, State};


% 废弃！！
% %% 移动后尝试触发暗雷
% handle_cast({'try_trigger_trap_after_move', PS_Then, NewPos}, State) ->
% 	%%?TRACE("~n~n~n !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!mod_player  try_trigger_trap_after_move!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!~n~n~n~n"),

%     case player:is_in_team(PS_Then)
%     andalso (not player:is_leader(PS_Then))
%     andalso (not player:is_tmp_leave_team(PS_Then)) of
%         true ->
%             skip;
%         false ->
%             ?TRY_CATCH(ply_scene:try_trigger_trap(PS_Then, NewPos), ErrReason)
%     end,
%    	{noreply, State};



%% 停止游戏进程
handle_cast({'stop', Reason}, State) ->
	?TRACE("~n********* [mod_player] handle_cast('stop', State)***************~n"),
    {stop, Reason, State};




%% 通知客户端更新我的上架物品列表
%% 注： 暂时不添加针对此通知的协议，而是重新发整个列表给客户端  ---- huangjf
handle_cast('notify_my_sell_list_changed', State) ->
	MyId = State#state.id,
	PS = player:get_PS(MyId),
	?TRACE("handle cast, notify_my_sell_list_changed...id: ~p~n", [MyId]),
    pp_market:handle(?PT_MK_QUERY_MY_SELL_LIST, PS, dummy_arg),
    {noreply, State};



%% 重算基础属性和总属性
handle_cast('recount_base_and_total_attrs', State) ->
	MyId = State#state.id,
	PS = player:get_PS(MyId),
	ply_attr:recount_base_and_total_attrs(imme, PS),
	{noreply, State};

%% 重算装备的加成属性和总属性
handle_cast('recount_equip_add_and_total_attrs', State) ->
	MyId = State#state.id,
	PS = player:get_PS(MyId),
	ply_attr:recount_equip_add_and_total_attrs(imme, PS),
	{noreply, State};


%% 重算心法的加成属性和总属性
handle_cast('recount_xinfa_add_and_total_attrs', State) ->
	MyId = State#state.id,
	PS = player:get_PS(MyId),
	ply_attr:recount_xinfa_add_and_total_attrs(imme, PS),
	{noreply, State};

%% 重算所有属性（基础属性，装备、心法的加成属性等等，以及总属性）
handle_cast('recount_all_attrs', State) ->
	MyId = State#state.id,
	PS = player:get_PS(MyId),
	ply_attr:recount_all_attrs(imme, PS),
	{noreply, State};



%% 通知客户端：天赋点数改了（包括通知自由天赋点数）
handle_cast('notify_cli_talents_change', State) ->
	MyId = State#state.id,
	PS = player:get_PS(MyId),
	KV_TupleList = [
						{?OI_CODE_TALENT_STR, player:get_total_str(PS)},
						{?OI_CODE_TALENT_CON, player:get_total_con(PS)},
						{?OI_CODE_TALENT_STA, player:get_total_stam(PS)},
						{?OI_CODE_TALENT_SPI, player:get_total_spi(PS)},
						{?OI_CODE_TALENT_AGI, player:get_total_agi(PS)},
						{?OI_FREE_TALENT_POINTS, player:get_free_talent_points(PS)}
					],
	?TRACE("handle_cast, notify_cli_talents_change, KV_TupleList=~p~n", [KV_TupleList]),
	player:notify_cli_info_change(PS, KV_TupleList),
	{noreply, State};


%% 保存天赋信息到DB
handle_cast('db_save_talents', State) ->
	MyId = State#state.id,
	PS = player:get_PS(MyId),
	player:db_save_talents(imme, PS),
	{noreply, State};


handle_cast('db_save_guild_attrs', State) ->
	MyId = State#state.id,
	PS = player:get_PS(MyId),
	player:db_save_guild_attrs(imme, PS),
	{noreply, State};

handle_cast('db_save_jingmai', State) ->
	MyId = State#state.id,
	PS = player:get_PS(MyId),
	player:db_save_jingmai(imme, PS),
	{noreply, State};


handle_cast('db_save_cultivate_attrs', State) ->
	MyId = State#state.id,
	PS = player:get_PS(MyId),
	player:db_save_cultivate_attrs(imme, PS),
	{noreply, State};


%% 添加基础天赋：力量（若Value为负数，表示减力量）
handle_cast({'add_base_str', Value}, State) when is_integer(Value) ->
	PS = player:get_PS(State#state.id),
	NewValue = util:minmax(player:get_base_str(PS) + Value, 0, ?MAX_TALENT_POINTS),
	?TRACE("[mod_player] add_base_str, OldValue:~p, AddValue:~p, NewValue:~p~n", [player:get_base_str(PS), Value, NewValue]),
	PS_Latest = player_syn:set_base_str(PS, NewValue),
	ply_attr:recount_base_and_total_attrs(imme, PS_Latest),
	player:db_save_talents(imme, PS_Latest),
	player:notify_cli_talents_change(PS_Latest),
	{noreply, State};


%% 添加基础天赋：体质（若Value为负数，表示减体质）
handle_cast({'add_base_con', Value}, State) when is_integer(Value) ->
	PS = player:get_PS(State#state.id),
	NewValue = util:minmax(player:get_base_con(PS) + Value, 0, ?MAX_TALENT_POINTS),
	PS_Latest = player_syn:set_base_con(PS, NewValue),
	ply_attr:recount_base_and_total_attrs(imme, PS_Latest),
	player:db_save_talents(imme, PS_Latest),
	player:notify_cli_talents_change(PS_Latest),
	{noreply, State};


%% 添加基础天赋：耐力（若Value为负数，表示减耐力）
handle_cast({'add_base_stam', Value}, State) when is_integer(Value) ->
	PS = player:get_PS(State#state.id),
	NewValue = util:minmax(player:get_base_stam(PS) + Value, 0, ?MAX_TALENT_POINTS),
	PS_Latest = player_syn:set_base_stam(PS, NewValue),
	ply_attr:recount_base_and_total_attrs(imme, PS_Latest),
	player:db_save_talents(imme, PS_Latest),
	player:notify_cli_talents_change(PS_Latest),
	{noreply, State};


%% 添加基础天赋：灵力（若Value为负数，表示减灵力）
handle_cast({'add_base_spi', Value}, State) when is_integer(Value) ->
	PS = player:get_PS(State#state.id),
	NewValue = util:minmax(player:get_base_spi(PS) + Value, 0, ?MAX_TALENT_POINTS),
	PS_Latest = player_syn:set_base_spi(PS, NewValue),
	ply_attr:recount_base_and_total_attrs(imme, PS_Latest),
	player:db_save_talents(imme, PS_Latest),
	player:notify_cli_talents_change(PS_Latest),
	{noreply, State};


%% 添加基础天赋：敏捷（若Value为负数，表示减敏捷）
handle_cast({'add_base_agi', Value}, State) when is_integer(Value) ->
	PS = player:get_PS(State#state.id),
	NewValue = util:minmax(player:get_base_agi(PS) + Value, 0, ?MAX_TALENT_POINTS),
	PS_Latest = player_syn:set_base_agi(PS, NewValue),
	ply_attr:recount_base_and_total_attrs(imme, PS_Latest),
	player:db_save_talents(imme, PS_Latest),
	player:notify_cli_talents_change(PS_Latest),
	{noreply, State};



%% 设置当前血量
handle_cast({'set_hp', Value}, State) when is_integer(Value) ->
	PS = player:get_PS(State#state.id),
	player_syn:set_hp(PS, Value),
	{noreply, State};


%% 加血（若Value为负数，表示扣血）
handle_cast({'add_hp', Value}, State) when is_integer(Value) ->
	PS = player:get_PS(State#state.id),
	Value2 = player:get_hp(PS) + Value,
	player_syn:set_hp(PS, Value2),
	{noreply, State};



%% 设置当前魔法
handle_cast({'set_mp', Value}, State) when is_integer(Value) ->
	PS = player:get_PS(State#state.id),
	player_syn:set_mp(PS, Value),
	{noreply, State};

%% 加魔法（若Value为负数，表示扣魔法）
handle_cast({'add_mp', Value}, State) when is_integer(Value) ->
	PS = player:get_PS(State#state.id),
	Value2 = player:get_mp(PS) + Value,
	player_syn:set_mp(PS, Value2),
	{noreply, State};



%% 设置当前hp和mp
handle_cast({'set_hp_mp', HpVal, MpVal}, State) when is_integer(HpVal), is_integer(MpVal)  ->
	PS = player:get_PS(State#state.id),
	player_syn:set_hp_mp(PS, HpVal, MpVal),
	{noreply, State};


%% 加玩家血库（若Value为负数，表示扣）
handle_cast({'add_store_hp', Value}, State) when is_integer(Value) ->
	PS = player:get_PS(State#state.id),
	Value2 = player:get_store_hp(PS) + Value,
	player_syn:set_store_hp(PS, Value2),
	{noreply, State};


%% 加玩家魔法库（若Value为负数，表示扣）
handle_cast({'add_store_mp', Value}, State) when is_integer(Value) ->
	PS = player:get_PS(State#state.id),
	Value2 = player:get_store_mp(PS) + Value,
	player_syn:set_store_mp(PS, Value2),
	{noreply, State};


%% 加玩家宠物专用气血库（若Value为负数，表示扣）
handle_cast({'add_store_par_hp', Value}, State) when is_integer(Value) ->
	PS = player:get_PS(State#state.id),
	Value2 = player:get_store_par_hp(PS) + Value,
	player_syn:set_store_par_hp(PS, Value2),
	{noreply, State};

%% 加玩家宠物专用魔法库（若Value为负数，表示扣）
handle_cast({'add_store_par_mp', Value}, State) when is_integer(Value) ->
	PS = player:get_PS(State#state.id),
	Value2 = player:get_store_par_mp(PS) + Value,
	player_syn:set_store_par_mp(PS, Value2),
	{noreply, State};

handle_cast({'add_partner_capacity', Value}, State) when is_integer(Value) ->
	PS = player:get_PS(State#state.id),
	Value2 = player:get_partner_capacity(PS) + Value,
	PS2 = player_syn:set_partner_capacity(PS, Value2),
	ply_partner:notify_partner_capacity_change(PS2),
	{noreply, State};


%% 设置为满血满魔
handle_cast('set_full_hp_mp', State) ->
	PS = player:get_PS(State#state.id),
	HpLim = player:get_hp_lim(PS),
	MpLim = player:get_mp_lim(PS),
	player_syn:set_hp_mp(PS, HpLim, MpLim),
    {noreply, State};


%% 玩家补血补篮
handle_cast('adjust_player_hp_mp', State) ->
	PS = player:get_PS(State#state.id),
	{NewHp, NewMp} = adjust_hp_mp_after_battle(PS, player:get_hp(PS), player:get_mp(PS)),
	player:set_hp_mp(PS, NewHp, NewMp),
	{noreply, State};


%% 宠物补血补篮
handle_cast({'adjust_partner_hp_mp', Partner}, State) ->
	PS = player:get_PS(State#state.id),
	{NewHp, NewMp} = ply_partner:adjust_hp_mp_after_battle(PS, Partner, lib_partner:get_hp(Partner), lib_partner:get_mp(Partner)),
	Partner1 = lib_partner:set_hp_mp(Partner, NewHp, NewMp),
	mod_partner:update_partner_to_ets(Partner1),
	{noreply, State};


%% 加怒气（若Value为负数，表示扣怒气）
handle_cast({'add_anger', Value}, State) when is_integer(Value) ->
    PS = player:get_PS(State#state.id),
    Value2 = player:get_anger(PS) + Value,
    player_syn:set_anger(PS, Value2),
    {noreply, State};


handle_cast({'add_free_talent_points', AddNum}, State) ->
	PS = player:get_PS(State#state.id),
	NewValue = player:get_free_talent_points(PS) + AddNum,
	PS_Latest = player_syn:set_free_talent_points(PS, NewValue),
	player:db_save_talents(imme, PS_Latest),
	player:notify_cli_talents_change(PS_Latest),
	{noreply, State};

handle_cast({'set_contri', AddNum}, State) ->
	PS = player:get_PS(State#state.id),
	% NewValue = player:get_contri(PS) + AddNum,
	NewValue = AddNum,
	PS_Latest = player_syn:set_contri(PS, NewValue),
	player:db_save_contri(imme, PS_Latest),
	player:notify_cli_contri_change(PS_Latest),
	{noreply, State};

%% 保存成就战绩信息到DB
handle_cast('db_save_contri', State) ->
	MyId = State#state.id,
	PS = player:get_PS(MyId),
	player:db_save_contri(imme, PS),
	{noreply, State};

%% 通知客户端:成就战绩修改了
handle_cast('notify_cli_contri_change', State) ->
	MyId = State#state.id,
	PS = player:get_PS(MyId),
	KV_TupleList = [
						{?OI_CODE_CONTRI, player:get_contri(PS)}
					],
	?TRACE("handle_cast, notify_cli_contri_change, KV_TupleList=~p~n", [KV_TupleList]),
	player:notify_cli_info_change(PS, KV_TupleList),
	{noreply, State};

%%设置坐骑
handle_cast({'set_mount', Value}, State) ->
	PS = player:get_PS(State#state.id),
	PS_Latest = player_syn:set_mount(PS, Value),
	player:db_save_mount(imme, PS_Latest),
	player:notify_cli_mount_change(PS_Latest),
	{noreply, State};

%% 保存成就战绩信息到DB
handle_cast('db_save_mount', State) ->
	MyId = State#state.id,
	PS = player:get_PS(MyId),
	player:db_save_mount(imme, PS),
	{noreply, State};

%% 通知客户端:坐骑修改了
handle_cast('notify_cli_mount_change', State) ->
	MyId = State#state.id,
	PS = player:get_PS(MyId),
	KV_TupleList = [
						{?OI_CODE_MOUNT, player:get_mount(PS)}
					],
	?TRACE("handle_cast, notify_cli_mount_change, KV_TupleList=~p~n", [KV_TupleList]),
	player:notify_cli_info_change(PS, KV_TupleList),
	{noreply, State};

%% 加钱（Value须为正整数）
handle_cast({'add_money', MoneyType, Value}, State) when is_integer(Value), Value > 0 ->
	PS = player:get_PS(State#state.id),
	case MoneyType of
		guild_contri ->
			NewValue = erlang:min( player:get_guild_contri(PS) + Value, ?MAX_U32),  % 稳妥起见，做范围矫正，以免越界，下同
    		player_syn:set_guild_contri(PS, NewValue),
    		player:notify_cli_money_change(PS, ?MNY_T_GUILD_CONTRI, NewValue),
    		ply_tips:notify_gain_item(PS, ?MNY_T_GUILD_CONTRI, NewValue - player:get_guild_contri(PS)),
    		ply_tips:send_sys_tips(PS, {add_guild_contri, [NewValue - player:get_guild_contri(PS)]});
		guild_feat ->
			NewValue = erlang:min( player:get_guild_feat(PS) + Value, ?MAX_U32),  % 稳妥起见，做范围矫正，以免越界，下同
    		player_syn:set_guild_feat(PS, NewValue),
    		player:notify_cli_money_change(PS, ?MNY_T_GUILD_FEAT, NewValue),
    		ply_tips:notify_gain_item(PS, ?MNY_T_GUILD_FEAT, NewValue - player:get_guild_feat(PS)),
    		ply_tips:send_sys_tips(PS, {add_guild_feat, [NewValue - player:get_guild_feat(PS)]});

		gamemoney ->
			NewValue = erlang:min( player:get_gamemoney(PS) + Value, ?MAX_U64),  % 稳妥起见，做范围矫正，以免越界，下同
    		player_syn:set_gamemoney(PS, NewValue),
    		player:notify_cli_money_change(PS, ?MNY_T_GAMEMONEY, NewValue),
    		ply_tips:notify_gain_item(PS, ?MNY_T_GAMEMONEY, NewValue - player:get_gamemoney(PS)),
    		ply_tips:send_sys_tips(PS, {add_gamemoney, [NewValue - player:get_gamemoney(PS)]});
    	bind_gamemoney ->
    		NewValue = erlang:min( player:get_bind_gamemoney(PS) + Value, ?MAX_U32),
    		player_syn:set_bind_gamemoney(PS, NewValue),
    		player:notify_cli_money_change(PS, ?MNY_T_BIND_GAMEMONEY, NewValue),
    		ply_tips:notify_gain_item(PS, ?MNY_T_BIND_GAMEMONEY, NewValue - player:get_bind_gamemoney(PS)),
    		ply_tips:send_sys_tips(PS, {add_bind_gamemoney, [NewValue - player:get_bind_gamemoney(PS)]});
    		% NewValue = erlang:min( player:get_gamemoney(PS) + Value, ?MAX_U64),  % 稳妥起见，做范围矫正，以免越界，下同
    		% player_syn:set_gamemoney(PS, NewValue),
    		% player:notify_cli_money_change(PS, ?MNY_T_GAMEMONEY, NewValue),
    		% ply_tips:notify_gain_item(PS, ?MNY_T_GAMEMONEY, NewValue - player:get_gamemoney(PS)),
    		% ply_tips:send_sys_tips(PS, {add_gamemoney, [NewValue - player:get_gamemoney(PS)]});
    	yuanbao ->
    		NewValue = erlang:min( player:get_yuanbao(PS) + Value, ?MAX_U32),
    		player_syn:set_yuanbao(PS, NewValue),
    		player:notify_cli_money_change(PS, ?MNY_T_YUANBAO, NewValue),
    		player:db_save_yuanbao(PS, NewValue),  % 对于元宝，即时存到DB
    		ply_tips:notify_gain_item(PS, ?MNY_T_YUANBAO, NewValue - player:get_yuanbao(PS)),
    		ply_tips:send_sys_tips(PS, {add_yuanbao, [NewValue - player:get_yuanbao(PS)]});
    	bind_yuanbao ->
    		NewValue = erlang:min( player:get_bind_yuanbao(PS) + Value, ?MAX_U32),
    		player_syn:set_bind_yuanbao(PS, NewValue),
    		player:notify_cli_money_change(PS, ?MNY_T_BIND_YUANBAO, NewValue),
    		player:db_save_bind_yuanbao(PS, NewValue),  % 对于绑定元宝，即时存到DB
    		ply_tips:notify_gain_item(PS, ?MNY_T_BIND_YUANBAO, NewValue - player:get_bind_yuanbao(PS)),
    		ply_tips:send_sys_tips(PS, {add_bind_yuanbao, [NewValue - player:get_bind_yuanbao(PS)]});
    	integral ->
    		NewValue = erlang:min( player:get_integral(PS) + Value, ?MAX_U32),
			player_syn:update_PS_to_ets(PS#player_status{integral = NewValue}),
			player:db_save_integral(PS, NewValue),  % 对于积分，即时存到DB
			player:notify_cli_money_change(PS, ?MNY_T_INTEGRAL, NewValue),
			ply_tips:notify_gain_item(PS, ?MNY_T_INTEGRAL, NewValue - player:get_integral(PS)),
			ply_tips:send_sys_tips(PS, {add_integral, [NewValue - player:get_integral(PS)]});
		feat ->
    		NewValue = erlang:min( player:get_feat(PS) + Value, ?MAX_U32),
			player_syn:update_PS_to_ets(PS#player_status{feat = NewValue}),
			player:notify_cli_money_change(PS, ?MNY_T_FEAT, NewValue),
			ply_tips:notify_gain_item(PS, ?MNY_T_FEAT, NewValue - player:get_feat(PS)),
			ply_tips:send_sys_tips(PS, {add_feat, [NewValue - player:get_feat(PS)]});
		literary ->
			NewValue = erlang:min( player:get_literary(PS) + Value, ?MAX_U32),
			player_syn:update_PS_to_ets(PS#player_status{literary = NewValue}),
			player:notify_cli_money_change(PS, ?MNY_T_LITERARY, NewValue),
			ply_tips:notify_gain_item(PS, ?MNY_T_LITERARY, NewValue - player:get_literary(PS)),
			ply_tips:send_sys_tips(PS, {add_literary, [NewValue - player:get_literary(PS)]});
		vitality ->
			InitLimit = 480 + 20 * player:get_lv(PS),
			NewValue = erlang:min( player:get_vitality(PS) + Value, InitLimit),
			player_syn:update_PS_to_ets(PS#player_status{vitality = NewValue}),
			player:notify_cli_money_change(PS, ?MNY_T_VITALITY, NewValue),
			ply_tips:send_sys_tips(PS, {add_vitality, [NewValue - player:get_vitality(PS)]});
		jingwen ->
			NewValue = erlang:min( player:get_jingwen(PS) + Value, ?MAX_U32),  %经文值
    		player_syn:set_jingwen(PS, NewValue),
    		player:notify_cli_money_change(PS, ?MNY_T_QUJING, NewValue),
    		ply_tips:notify_gain_item(PS, ?MNY_T_QUJING, NewValue - player:get_jingwen(PS)),
    		ply_tips:send_sys_tips(PS, {add_jingwen, [NewValue - player:get_jingwen(PS)]});
		mijing ->
			NewValue = erlang:min( player:get_mijing(PS) + Value, ?MAX_U32),  %秘境点
			player_syn:set_mijing(PS, NewValue),
			player:notify_cli_money_change(PS, ?MNY_T_MYSTERY, NewValue),
			ply_tips:notify_gain_item(PS, ?MNY_T_MIRAGE, NewValue - player:get_mijing(PS)),
			ply_tips:send_sys_tips(PS, {add_mijing, [NewValue - player:get_mijing(PS)]});
		huanjing ->
			NewValue = erlang:min( player:get_huanjing(PS) + Value, ?MAX_U32),  %幻境点
			player_syn:set_huanjing(PS, NewValue),
			player:notify_cli_money_change(PS, ?MNY_T_MIRAGE, NewValue),
			ply_tips:notify_gain_item(PS, ?MNY_T_MIRAGE, NewValue - player:get_huanjing(PS)),
			ply_tips:send_sys_tips(PS, {add_huanjing, [NewValue - player:get_huanjing(PS)]});
		reincarnation ->
			NewValue = erlang:min( player:get_reincarnation(PS) + Value, ?MAX_U32),  %转生点
			player_syn:set_reincarnation(PS, NewValue),
			player:notify_cli_money_change(PS, ?MNY_T_REINCARNATION, NewValue),
			ply_tips:notify_gain_item(PS, ?MNY_T_REINCARNATION, NewValue - player:get_reincarnation(PS)),
			ply_tips:send_sys_tips(PS, {add_reincarnation, [NewValue - player:get_reincarnation(PS)]});
			


		% 筹码
		chip ->
			NewValue = player:get_chip(PS) + Value,
			% player_syn:update_PS_to_ets(PS#player_status{vitality = NewValue}),
			% player:notify_cli_money_change(PS, ?MNY_T_VITALITY, NewValue),
			% ply_tips:send_sys_tips(PS, {add_vitality, [NewValue - player:get_vitality(PS)]});
			ply_tips:send_sys_tips(PS, {add_chip, [Value]}),
			player:set_chip(PS,NewValue);

		chivalrous -> 
			NewValue = erlang:min( player:get_chivalrous(PS) + Value, ?MAX_U32),  %侠义值
    		player_syn:set_chivalrous(PS, NewValue),
    		player:notify_cli_money_change(PS, ?MNY_T_CHIVALROUS, NewValue),
    		ply_tips:notify_gain_item(PS, ?MNY_T_CHIVALROUS, NewValue - player:get_chivalrous(PS)),
    		ply_tips:send_sys_tips(PS, {add_chivalrous, [NewValue - player:get_chivalrous(PS)]});
		copper ->
			NewValue = erlang:min( player:get_copper(PS) + Value, ?MAX_U32),  % 稳妥起见，做范围矫正，以免越界，下同
    		player_syn:set_copper(PS, NewValue),
    		player:notify_cli_money_change(PS, ?MNY_T_COPPER, NewValue),
    		ply_tips:notify_gain_item(PS, ?MNY_T_COPPER, NewValue - player:get_copper(PS)),
    		ply_tips:send_sys_tips(PS, {add_copper, [NewValue - player:get_copper(PS)]})
	end,
	{noreply, State};


%% 扣钱（CostNum须为正整数）
%% @para: MoneyType => 钱的类型代号（为整数，详见common.hrl）
handle_cast({'cost_money', MoneyType, CostNum, LogInfo}, State) when is_integer(CostNum), CostNum > 0 ->
	PS = player:get_PS(State#state.id),
	% case MoneyType of
	% 	gamemoney ->
	% 		?ASSERT( player:get_gamemoney(PS) >= CostNum),
 %    		NewNum = erlang:max( player:get_gamemoney(PS) - CostNum, 0),  % 稳妥起见，做范围矫正，以免越界，下同
 %    		set_gamemoney__(PS, NewNum),
 %    		player:notify_cli_money_change(PS, ?MNY_T_GAMEMONEY, NewNum);
 %    	bind_gamemoney ->
 %    		?ASSERT( player:get_bind_gamemoney(PS) + player:get_gamemoney(PS) >= CostNum),
 %    		OwnedBindGamemoney = player:get_bind_gamemoney(PS),
	% 		case OwnedBindGamemoney >= CostNum of
	% 			true ->
	% 				NewNum = OwnedBindGamemoney - CostNum,
 %    				set_bind_gamemoney__(PS, NewNum),
 %    				player:notify_cli_money_change(PS, ?MNY_T_BIND_GAMEMONEY, NewNum);
	% 			false ->
	% 				% 扣光绑定的游戏币
	% 				NewNum = 0,
	% 				set_bind_gamemoney__(PS, NewNum),
 %    				player:notify_cli_money_change(PS, ?MNY_T_BIND_GAMEMONEY, NewNum),
	% 				% 差额用非绑定的游戏币来补
	% 				gen_server:cast( self(), {'cost_money', gamemoney, CostNum - OwnedBindGamemoney})
	% 		end;
	% 	yuanbao ->
	% 		?ASSERT( player:get_yuanbao(PS) >= CostNum),
 %    		NewNum = erlang:max( player:get_yuanbao(PS) - CostNum, 0),
 %    		set_yuanbao__(PS, NewNum),
 %    		player:notify_cli_money_change(PS, ?MNY_T_YUANBAO, NewNum),
 %    		player:db_save_yuanbao(PS, NewNum);  % 对于元宝，即时存到DB
 %    	bind_yuanbao ->
 %    		?ASSERT( player:get_bind_yuanbao(PS) + player:get_yuanbao(PS) >= CostNum),
 %    		OwnedBindYB = player:get_bind_yuanbao(PS),
	% 		case OwnedBindYB >= CostNum of
	% 			true ->
	% 				NewNum = OwnedBindYB - CostNum,
 %    				set_bind_yuanbao__(PS, NewNum),
 %    				player:notify_cli_money_change(PS, ?MNY_T_BIND_YUANBAO, NewNum),
 %    				player:db_save_bind_yuanbao(PS, NewNum);  % 对于绑定元宝，即时存到DB
	% 			false ->
	% 				% 扣光绑定的元宝
	% 				NewNum = 0,
	% 				set_bind_yuanbao__(PS, NewNum),
 %    				player:notify_cli_money_change(PS, ?MNY_T_BIND_YUANBAO, NewNum),
 %    				player:db_save_bind_yuanbao(PS, NewNum),  % 对于绑定元宝，即时存到DB
	% 				% 差额用非绑定的元宝来补
	% 				gen_server:cast( self(), {'cost_money', yuanbao, CostNum - OwnedBindYB})
	% 		end
	% end,

	player_syn:cost_money(PS, MoneyType, CostNum, LogInfo),

	{noreply, State};




%% 执行传送，会处理跟随的队员
handle_cast({'do_teleport', NewSceneId, NewX, NewY}, State) ->
	PS = player:get_PS(State#state.id),
	ply_scene:do_teleport(PS, NewSceneId, NewX, NewY),
    {noreply, State};


%% 执行单人传送，不处理跟随的队员
handle_cast({'do_single_teleport', NewSceneId, NewX, NewY}, State) ->
	PS = player:get_PS(State#state.id),
	ply_scene:do_single_teleport(PS, NewSceneId, NewX, NewY),
    {noreply, State};


%% 升级
handle_cast('do_upgrade', State) ->
	PS = player:get_PS(State#state.id),
	?TRY_CATCH(do_upgrade__(PS), ErrReason),
    {noreply, State};
handle_cast({'gm_set_lv',Lv}, State) ->
	PS = player:get_PS(State#state.id),
	?TRY_CATCH(gm_do_upgrade__(PS, Lv), ErrReason),
	{noreply, State};

%% 巅峰等级首次升级
handle_cast('start_peak_upgrade', State) ->
	PS = player:get_PS(State#state.id),
	start_peak_upgrade(PS),
	{noreply, State};



%% 加经验（若是扣经验，则Value传入负值） 不要直接使用该接口， 使用player:add_exp接口
handle_cast({'add_exp', Value}, State) when is_integer(Value) ->
	OldPS = player:get_PS(State#state.id),

	% 计算世界等级经验
	{RoleExp, _SlotExp, PS} = mod_world_lv:add_exp(OldPS, Value),

	NewExp = util:minmax(player:get_exp(PS) + RoleExp, 0, ?MAX_U32), % 避免数据溢出
	Value1 = NewExp - player:get_exp(PS),
    ExpLim = player:get_exp_lim(PS),
    Lv = player:get_lv(PS),

    MaxLv = Lv >= player:get_player_max_lv(OldPS),
    if
        ExpLim > NewExp orelse MaxLv ->  % 未能升级，或者玩家已达到了10级
        	player_syn:set_exp(PS, NewExp),
        	player:notify_cli_exp_change(PS, NewExp);
        true ->  % 前10级自动升级
            PS2 = player_syn:set_exp(PS, NewExp),
            ?ASSERT(self() =:= player:get_pid(PS)),
            do_upgrade__(PS2)
    end,
    case Value1 >= 0 of
    	true -> ply_tips:send_sys_tips(PS, {add_exp, [Value1]});
    	false -> ply_tips:send_sys_tips(PS, {cost_exp, [-Value1]})
    end,
	{noreply, State};


handle_cast({'add_exp', Value, LogInfo}, State) when is_integer(Value) ->
	OldPS = player:get_PS(State#state.id),

	% 计算世界等级经验
	{RoleExp, _SlotExp, PS} = mod_world_lv:add_exp(OldPS, Value),
	?LDS_TRACE(add_exp, {RoleExp, _SlotExp, PS#player_status.exp_slot}),

	NewExp = util:minmax(player:get_exp(PS) + RoleExp, 0, ?MAX_U32), % 避免数据溢出
	Value1 = NewExp - player:get_exp(PS),
    ExpLim = player:get_exp_lim(PS),
    Lv = player:get_lv(PS),
	MaxLv = Lv >= player:get_player_max_lv(OldPS),

	%% 巅峰经验等级
	PeakLv = player:get_peak_lv(PS),
	case PeakLv =:= 0 of
		true ->
			if
				(ExpLim > NewExp orelse MaxLv) ->  % 未能升级，或者玩家已达到了10级
					player_syn:set_exp(PS, NewExp),
					player:notify_cli_exp_change(PS, NewExp);
				true ->  % 前10级自动升级
					PS2 = player_syn:set_exp(PS, NewExp),
					?ASSERT(self() =:= player:get_pid(PS)),
					do_upgrade__(PS2)
			end;
		false ->
			PeakExpLim = player:get_peak_exp_lim(PS),
			PeaKMaxLv = PeakLv >= player:get_player_peak_max_lv(),
			if
				(PeakExpLim > NewExp orelse PeaKMaxLv) ->  % 未能升级，或者玩家已达到了10级
					player_syn:set_exp(PS, NewExp),
					player:notify_cli_exp_change(PS, NewExp);
				true ->  % 前10级自动升级
					PS2 = player_syn:set_exp(PS, NewExp),
					?ASSERT(self() =:= player:get_pid(PS)),
					do_peak_upgrade__(PS2)
			end
	end,
    case Value1 > 0 of
    	true ->
    		lib_log:statis_produce_currency(PS, ?MNY_T_EXP, Value1, LogInfo),
    		if
    			Value1 =:= Value ->
    				ply_tips:send_sys_tips(PS, {add_exp, [Value1]});
    			RoleExp > Value ->
    				ply_tips:send_sys_tips(PS, {add_exp_1, [Value1, _SlotExp]});
    			RoleExp < Value ->
    				ply_tips:send_sys_tips(PS, {add_exp_2, [Value1, _SlotExp]});
    			true -> skip
    		end;
    	false ->
    		case -Value1 > 0 of
    			true ->
    				lib_log:statis_consume_currency(PS, ?MNY_T_EXP, -Value1, LogInfo),
    				ply_tips:send_sys_tips(PS, {cost_exp, [-Value1]});
    			false -> skip
    		end
    end,
	{noreply, State};


handle_cast({'add_exp_to_main_par', AddVal, LogInfo}, State) ->
	PS = player:get_PS(State#state.id),
	case player:get_main_partner_id(PS) of
		?INVALID_ID -> skip;
		MainParId ->
			case lib_partner:get_partner(MainParId) of
				null ->
					?ASSERT(false, MainParId),
					?ERROR_MSG("mod_player:add_exp_to_main_par error!~p~n", [MainParId]),
					skip;
				Partner ->
					case lib_partner:is_fighting(Partner) of
						true ->
							lib_partner:add_exp(Partner, AddVal, PS, LogInfo);
						false ->
							skip
					end
			end
	end,
	{noreply, State};	


handle_cast({'add_exp_to_fighting_deputy_pars', AddVal, LogInfo}, State) ->
	PS = player:get_PS(State#state.id),
	F = fun(X) ->
            case lib_partner:get_partner(X) of
                null ->
                	?ASSERT(false, X),
                	?ERROR_MSG("mod_player:add_exp_to_fighting_deputy_pars error!~p~n", [X]),
                    skip;
                Partner ->
                    case lib_partner:is_fighting(Partner) andalso (not lib_partner:is_main_partner(Partner)) of
                        true ->
                            lib_partner:add_exp(Partner, AddVal, PS, LogInfo);
                        false ->
                            skip
                    end
            end     
        end,

    ParIdList = player:get_partner_id_list(PS),
    [F(X) || X <- ParIdList],
	{noreply, State};		


handle_cast({'add_par_skill', PartnerId, SkillId}, State) ->
	Skill = #skl_brief{id = SkillId},
	case lib_partner:get_partner(PartnerId) of
		null -> skip;
		Partner ->
			OldSkillList = lib_partner:get_skill_list(Partner),
		    case lists:keyfind(SkillId, #skl_brief.id, OldSkillList) of
		    	false ->
				    NewSkillList = [Skill] ++ OldSkillList,
				    Partner1 = lib_partner:set_skill_list(Partner, NewSkillList),
				    % Partner2 = lib_partner:recount_passi_eff_attrs(Partner1),
				    Partner3 = lib_partner:recount_total_attrs(Partner1),
				    Partner4 = lib_partner:recount_battle_power(Partner3),
				    
				    mod_partner:update_partner_to_ets(Partner4),
				    mod_partner:db_save_partner(Partner4);
				_ -> skip
			end
	end,

	{noreply, State};			


%% （升级后）主动推送玩家的信息详情给客户端
handle_cast('notify_info_details_to_client', State) ->
	PlayerId = State#state.id,
	PS = player:get_PS(PlayerId),
	ply_attr:notify_my_info_details_to_client(PS),
    {noreply, State};



%% 更新玩家结构体的字段到ets
handle_cast({'update_PS_fields', FieldValueList}, State) ->
	?ASSERT(is_list(FieldValueList), FieldValueList),

	PlayerId = State#state.id,

	F = fun({Field, NewValue}, PS__) ->
			case Field of

				?PSF_FACTION ->
					player_syn:set_faction(PS__, NewValue);
				?PSF_SEX ->
					player_syn:set_sex(PS__, NewValue);
				?PSF_RACE ->
					player_syn:set_race(PS__, NewValue);

				?PSF_SOARING ->
					player_syn:set_soaring(PS__, NewValue);

				?PSF_TRANSFIGURATION_NO ->
					player_syn:set_transfiguration_no(PS__, NewValue);

				% ?PSF_REPU ->
				% 	player_syn:set_repu(PS__, NewValue);
                ?PSF_PHY_POWER ->
                    player_syn:set_phy_power(PS__, NewValue);

				?PSF_IS_LEADER ->  % 队长标记
					player_syn:set_leader_flag(PS__, NewValue);
				?PSF_TEAM_ID ->    % 队伍id
					player_syn:set_team_id(PS__, NewValue);
				?PSF_TEAM_TAGET_TYPE ->
					player_syn:set_team_target_type(PS__, NewValue);
				?PSF_TEAM_CONDITION1 ->
					player_syn:set_team_condition1(PS__, NewValue);
				?PSF_TEAM_CONDITION2 ->
                    player_syn:set_team_condition2(PS__, NewValue);
                ?PSF_TEAM_LV_RANGE ->
                	{MinLv,MaxLv} = case NewValue of
						{_Min,_Max} -> {_Min,_Max};
						_ -> {0,100}
					end,

                	player_syn:set_team_lv_range(PS__, MinLv, MaxLv);

				?PSF_GUILD_ID -> % 帮派id
					player_syn:set_guild_id(PS__, NewValue);
				?PSF_LEAVE_GUILD_TIME -> % 离帮时间
					player_syn:set_leave_guild_time(PS__, NewValue);
				?PSF_GUILD_ATTRS ->
					player_syn:set_guild_attrs(PS__, NewValue);

				?PSF_JINGMAI_POINT ->
					player_syn:set_jingmai_point(PS__, NewValue);
				?PSF_JINGMAI_INFOS ->
					player_syn:set_jingmai_infos(PS__, NewValue);

				?PSF_CULTIVATE_ATTRS ->
					player_syn:set_cultivate_attrs(PS__, NewValue);

				?PSF_FREE_TALENT_POINTS ->
					player_syn:set_free_talent_points(PS__, NewValue);

				?PSF_POPULAR ->
					player_syn:set_popular(PS__, NewValue);

				?PSF_KILL_NUM ->
					player_syn:set_kill_num(PS__, NewValue);
				?PSF_BE_KILL_NUM ->
					player_syn:set_be_kill_num(PS__, NewValue);

				?PSF_ENTER_GUILD_TIME ->
					player_syn:set_enter_guild_time(PS__, NewValue);

				?PSF_CHIP ->
					player_syn:set_chip(PS__, NewValue);

				?PSF_CUR_BHV_STATE ->
					player_syn:set_cur_bhv_state(PS__, NewValue);
				?PSF_CUR_BATTLE_ID ->
					player_syn:set_cur_battle_id(PS__, NewValue);

				?PSF_PARTNER_ID_LIST ->
					player_syn:set_partner_id_list(PS__, NewValue);
				?PSF_PARTNER_CAPACITY ->
					player_syn:set_partner_capacity(PS__, NewValue);
				?PSF_MAIN_PARTNER_ID ->
					player_syn:set_main_partner_id(PS__, NewValue);
				?PSF_FOLLOW_PARTNER_ID ->
					player_syn:set_follow_partner_id(PS__, NewValue);
				?PSF_FIGHT_PAR_CAPACITY ->
					%% 处理数据容错：因其他系统出错，导致需要修改宠物的出战状态
					case player:get_fight_par_capacity(PS__) > NewValue of
						false -> skip;
						true -> 
							% ?DEBUG_MSG("NewValue~p",[NewValue]),
							ply_partner:adjust_partner_fight_state(PS__, NewValue)
					end,
					player_syn:set_fight_par_capacity(PS__, NewValue);

                ?PSF_VIP_LV ->
                	player_syn:set_vip_lv(PS__, NewValue);
                ?PSF_SHOWING_EQUIPS ->
                	player_syn:set_showing_equips(PS__, NewValue);
                ?PSF_UPDATE_MOOD_COUNT ->
                	player_syn:set_update_mood_count(PS__, NewValue);
				?PSF_LAST_UPDATE_MOOD_TIME ->
					player_syn:set_last_update_mood_time(PS__, NewValue);
				?PSF_RELA_LIST ->
					player_syn:set_rela_list(PS__, NewValue);

				?PSF_LAST_DAILY_RESET_TIME ->
					player_syn:set_last_daily_reset_time(PS__, NewValue);
				?PSF_LAST_WEEKLY_RESET_TIME ->
					player_syn:set_last_weekly_reset_time(PS__, NewValue);

				?PSF_VIP_INFO ->
					player_syn:set_vip_info(PS__, NewValue);
				?PSF_SUIT_NO ->
					player_syn:set_suit_no(PS__, NewValue);
				?PSF_XS_TASK_ISSUE_NUM ->
					player_syn:set_xs_task_issue_num(PS__, NewValue);
				?PSF_XS_TASK_LEFT_ISSUE_NUM ->
					player_syn:set_xs_task_left_issue_num(PS__, NewValue);
				?PSF_XS_TASK_RECEIVE_NUM ->
					player_syn:set_xs_task_receive_num(PS__, NewValue);
				?PSF_ZF_STATE ->
					player_syn:set_zf_state(PS__, NewValue);
				?PSF_MOUNT_ID_LIST ->
					player_syn:set_mount_id_list(PS__, NewValue);
				?PSF_LAST_TRANSFORM_FACTION_TIME ->
					player_syn:set_last_transform_time(PS__, NewValue);
				?PSF_DAY_TRANSFORM_FACTION_TIMES ->
					player_syn:set_day_transform_times(PS__, NewValue);
				% 其他..。
				% ....

				_ ->
					?ASSERT(false, Field),
					?ERROR_MSG("[mod_player] update_PS_fields error!! Field:~p, PS__:~w", [Field, PS__]),
					PS__
			end
		end,

	PS = player:get_PS(PlayerId),
	_PS2 = lists:foldl(F, PS, FieldValueList),
	?ASSERT(is_record(_PS2, player_status), FieldValueList),
	{noreply, State};



%% （角色进入游戏成功后）初始化内部状态
handle_cast({'init_internal_state', PS, [ReaderPid, PhoneInfo, FromServerId]}, _State) ->
	%% 跨服复用，暂不断言
%% 	?ASSERT(_State == null, _State),

	PlayerId = player:id(PS),

	% 标识本进程为玩家进程
	erlang:put(?PDKN_PLAYER_PROC_FLAG, #ply_proc_flg{id = PlayerId, pid = self()}),
	erlang:put(?PDKN_PLAYER_ID, PlayerId),

	init_heartbeat_count__(),
	ply_phone:set_phone_info(PhoneInfo),
	NewState = #state{
					id = PlayerId,
					accname = player:get_accname(PS),
					from_server_id = FromServerId,
					socket = player:get_socket(PS),
					reader_pid = ReaderPid
				},
    {noreply, NewState};




%% 心跳处理（目前主要是用于定时存玩家数据到DB）
% 注意：玩家心跳的间隔比较久（30秒以上）， 对于一些要求时间比较精确的处理，应该投递消息到mod_ply_jobsch并交由它做处理!!!
handle_cast('heartbeat', State) ->
	NewHBCount = incr_heartbeat_count__(),
	PlayerId = State#state.id,

	case lib_comm:is_now_nearby_midnight() of
		true -> skip;  % 午夜0点整左右有比较多的业务逻辑处理，为了减轻服务器压力，此段时间内不处理定时保存数据到DB
		false -> mod_ply_asyn:db_save_data_on_heartbeat(PlayerId, NewHBCount)
	end,

    NowTs = util:unixtime(),
    case NowTs >= get(?PDKN_LAST_GC_TIMESTAMP) + ?GC_INTV of
        true ->
            erlang:garbage_collect(),
            put(?PDKN_LAST_GC_TIMESTAMP, NowTs);
        false ->
            skip
    end,

    {noreply, State};



%% 作业计划（mod_ply_jobsch模块）的反馈（有点“回调”的意思）
handle_cast({'job_sche_feedback', JobSch}, State) ->
	?ASSERT(JobSch#job_sche.player_id == State#state.id),
	?TRY_CATCH(handle_job_sche_feedback(JobSch#job_sche.event_type, JobSch)),
    {noreply, State};


handle_cast({'post_allot_free_talent_points', OldHpLim, OldMpLim}, State) ->
    PlayerId = State#state.id,
    PS = player:get_PS(PlayerId),

    AddHp = player:get_hp_lim(PS) - OldHpLim,
    AddMp = player:get_mp_lim(PS) - OldMpLim,
    ?ASSERT(AddHp >= 0 andalso AddMp >= 0, {AddHp, AddMp}),

    NewHp = player:get_hp(PS) + AddHp,
    NewMp = player:get_mp(PS) + AddMp,
    player_syn:set_hp_mp(PS, NewHp, NewMp),
    {noreply, State};


handle_cast({'player_add_buff', BuffNo, DelayTime}, State) ->
	PlayerId = State#state.id,
	lib_buff:player_add_buff(PlayerId, BuffNo, DelayTime),
	{noreply, State};

handle_cast({'player_del_buff', BuffNo}, State) ->
	PlayerId = State#state.id,
	lib_buff:player_del_buff(PlayerId, BuffNo),
	{noreply, State};

%% 角色进入游戏时的进一步初始化工作
%% @para: IfRoleInCache => role_in_cache | role_not_in_cache
handle_cast({'more_init_for_enter_game', IfRoleInCache}, State) ->
	% ?LDS_TRACE("login_success_start"),
	PlayerId = State#state.id,
	?ASSERT(PlayerId /= ?INVALID_ID),

	PS = player:get_PS(PlayerId),
	?ASSERT(PS /= null),

	% 领取世界等级经验
	mod_world_lv:login_init(PS),
	% 成就初始化
	mod_achievement:login(PlayerId, IfRoleInCache),
	% 任务初始化
	lib_task:login_load_task(PS, IfRoleInCache),
	lib_chat:login_chat(PlayerId, IfRoleInCache),
	% 副本初始化,必须放在任务初始化后
	lib_dungeon:dungeon_login(PS, IfRoleInCache),
    lib_offline_arena:login(PS, IfRoleInCache),
    lib_activity_degree:login(PlayerId, IfRoleInCache),
	lib_jingyan:login(PS, IfRoleInCache),
    lib_mail:login(PS),
    lib_activity:answer_login(PS, IfRoleInCache),
    mod_dungeon_plot:login(PlayerId, IfRoleInCache),
    mod_admin_activity:login_check_admin_activity(PlayerId, IfRoleInCache),

    lib_transport:login_init(PS, IfRoleInCache),

    % 修复有问题的内功
    lib_train:login_update_art_data(PlayerId),
    % 初始化内功系统
    lib_train:login_init(PlayerId),
	% 初始化法宝系统
	mod_fabao:load_player_data(PlayerId),


	% 如果是进跨服标记下？
	case lib_cross:check_is_remote() of
		?false ->
			
			skip;
		_ ->
			gen_server:cast(self(), {apply_cast, lib_cross, login_init_cross, [PlayerId]})
	end,
 	% 进入场景并标记为在线
	ply_scene:enter_scene_on_login(PS),
	player:set_online(PlayerId, true),

	% 回归队伍时会通知进入队友的AOI，故将此操作放在进入场景操作的后面
	% mod_team:on_player_login(PS), 改到客户端加载完毕才处理了


	% 创建locolId-playerID映射表
	ply_comm:create_locolId_playerId_map(player:local_id(PS), PlayerId),


	% 处理充值新订单
	player:notify_player_recharge(PS),

	% 处理订单首充反馈
	%player:send_first_recharge_reward(PS),
	?LDS_TRACE("login_success_init"),
	% 日志记录玩家登陆
	lib_log:login(PS),

	ply_relation:on_player_login(PS),

	lib_offcast:on_login(PS),

    % 女妖选美-抽奖活动登陆处理
    lib_beauty_contest:login(PS),

    % 商会信息登录处理
    lib_business:login(PS),

    % % 玩家拓展信息登录处理
    % lib_player_ext:login(PS),

    % 女妖乱斗登陆处理
    lib_melee:login(PS),

	  %初始化翅膀
  	lib_wing:init_all_wing(PlayerId),


	% 把没有过期的回购物品添加到作业计划
    ply_trade:on_player_login(PlayerId),

    % 重新检测系统开放（有些系统是上线后才添加的，如运镖，故需重新检测）
    ply_sys_open:check_and_handle_sys_open(PS),

    mod_tve_mgr:on_player_login(PlayerId),

    % 重算属性
    gen_server:cast(self(), 'recount_all_attrs'),

    mod_lginout_TSL:mark_enter_game_done(PlayerId),

	ply_comm:notify_cli_enter_game_result(State#state.socket, [?RES_OK, PlayerId]),

	ply_partner:on_player_login(PS),

	% 每日/每周重置
    ply_reset:on_player_login(PS),
	
	mod_rank:notify_all_info(PS),

	% 幸运转盘初始化
	lib_ernie:login(PlayerId, IfRoleInCache),
	lib_mount:check_data(PS),

	% 初始化家园数据
	lib_home:on_player_login(PS),
	
	% 判断帮派副本的位置
	lib_guild_dungeon:on_scene_login(PS),


	% 通知好友自己已经上线了
	FS = ply_relation:get_online_friend_list(PS),
	ES = ply_relation:get_online_enemy_list(PS),

	% ?DEBUG_MSG("ES=~p",[ES]),

	F = fun(FPS) ->
		ply_tips:send_sys_tips(FPS,{online_tips_friend,[player:get_name(PS),PlayerId,player:get_scene_no(PS)]})
		% skip
	end,

	F1 = fun(FPS) ->
		ply_tips:send_sys_tips(FPS,{online_tips_enemy,[player:get_name(PS),PlayerId,player:get_scene_no(PS)]})
		% skip
	end,

	% 判断是否需要赠送改名道具
	case lib_player_ext:try_load_data(PlayerId,can_change_count) of
    	fail ->
    		skip;
    	{ok,Count} ->
    		case Count > 0 of
    			true ->
    				lib_player_ext:try_update_data(PlayerId,can_change_count,Count - 1),
    				lib_mail:send_sys_mail(PlayerId, <<"合服赠送角色更名卡">>, 
                                <<"由于您之前的名字跟其他玩家重复，所以赠送您一个角色更名卡！">>, 
                                [{10052,1}], ["mail", "change_name"]);

    			false ->
    				skip
    		end
    end,

	lists:foreach(F,FS),
	lists:foreach(F1,ES),

	% 判断是否有战斗中逃跑的记录有的话扣除经验值60%
	player:cost_exp_by_flee(PS), 

	% 最后才标记已初始化完毕
	gen_server:cast(self(), 'mark_init_for_enter_game_done'),
	
	% 初始化手机号禁言
	mod_chat:init_ban_phone(player:get_accname(PS), self()),

	{noreply, State};



handle_cast({'do_sworn', Team, Type, MoneyType, MoneyCount}, State) ->
	PS = player:get_PS(State#state.id),
	case player:has_enough_money(PS, MoneyType, MoneyCount) of
		false ->
			{ok, BinData} = pt_14:write(14050, [?RES_FAIL, Type, [{player:id(PS), 5}]]),
            lib_send:send_to_team(Team, BinData);
        true ->
        	player:cost_money(PS, MoneyType, MoneyCount, [?LOG_SWORN, "sworn"]),
        	gen_server:cast(?RELATION_PROCESS, {'do_sworn', Team, Type})
    end,
    {noreply, State};


%% =========================================
%% 任务
%% =========================================

%% 检查自动领取任务触发
handle_cast('check_auto_task', State) ->
	Status = player:get_PS(State#state.id),
	lib_task:auto_task_event(Status),
	{noreply, State};


%% 任务事件处理
handle_cast({'task_event', [EventType, Args]}, State) ->
	Status = player:get_PS(State#state.id),
	lib_task:accept_handle_apply(EventType, Args, Status),
	{noreply, State};


%% 每天凌晨通知在线玩家刷新事件
handle_cast('task_refresh_daily', State) ->
	Status = player:get_PS(State#state.id),
	% ?DEBUG_MSG("task_refresh_daily", []),
	lib_tower:reset_close_tower(Status),
	lib_hardtower:reset_close_tower(Status),
	Now = util:unixtime(),
	lib_task:send_trigger_msg_no_compare(Status),
	lib_activity_degree:notify_refresh(Status),
	%player:send_first_recharge_reward(Status),
	lib_activity:notify_refresh(Status, Now),
	{noreply, State};

%% 每小时刷新任务
handle_cast('task_refresh_hourly', State) ->
	Status = player:get_PS(State#state.id),
	lib_task:send_trigger_msg_no_compare(Status),
	{noreply, State};

handle_cast('send_trigger_msg', State) ->
	Status = player:get_PS(State#state.id),
	lib_task:send_trigger_msg(Status),
	{noreply, State};

handle_cast('send_trigger_msg_no_compare', State) ->
	Status = player:get_PS(State#state.id),
	lib_task:send_trigger_msg_no_compare(Status),
	{noreply, State};

handle_cast({'accept_task_event', Task}, State) ->
    Status = player:get_PS(State#state.id),
    lib_task:accept_task_event(Task, Status),
    {noreply, State};


handle_cast({'force_accept_task', TaskId}, State) ->
    lib_task:force_accept(TaskId, player:get_PS(State#state.id)),
    {noreply, State};

handle_cast({'auto_accept_task', TaskId}, State) ->
	util:sleep(200),
	Status = player:get_PS(State#state.id),
	case lib_task:check_cross_accept(TaskId) of
		{ok, 0} ->
			case player:is_leader(Status) of
				true -> lib_task:team_captain_accept(TaskId, Status);
				false -> lib_task:accept(data_task:get(TaskId), Status,1)  %%目前默认1需要推送新协议给前端
				% {ok, BinData} = pt_30:write(30003, [TaskId, Flag]),
				%    lib_send:send_to_sock(Status#player_status.socket, BinData)
			end,
			ok;
		{ok, 1} ->
			%% 跨服任务
			PlayerId = player:get_id(Status),
			lib_task:accept_task_cross(PlayerId, TaskId),
			ok;
		{fail, MsgCode} ->
			lib_send:send_prompt_msg(Status, MsgCode)
	end,
	{noreply, State};


handle_cast({'force_submit_task', TaskId, ItemIdList}, State) ->
    Status = player:get_PS(State#state.id),
    case lib_task:is_task_accepted(TaskId) of
    	true -> lib_task:submit(TaskId, ItemIdList, Status);
    	false -> skip
    end,
    {noreply, State};

%% =========================================
%% 副本
%% =========================================

%% 通知进入副本
handle_cast({'enter_dungeon', _DunId, _DunNo}, State) ->
	redo,
	{noreply, State};


%% 退出副本
handle_cast({'quit_dungeon', Flag}, State) ->
    lib_dungeon:send_quit_dungeon_msg(State#state.id, Flag),
    lib_task:trigger(player:get_PS(State#state.id)),
    {noreply, State};


%% 退出副本并退出队伍
handle_cast({'quit_dungeon_team', Flag}, State) ->
    lib_dungeon:send_quit_dungeon_msg(State#state.id, Flag),
    Status = player:get_PS(State#state.id),
    mod_team:quit_team(Status),
    {noreply, State};


%% 副本通关奖励
handle_cast({'send_dungeon_pass', Info}, State) ->
    lib_dungeon:set_dungeon_pass_mem(Info),
    lib_dungeon:send_dungeon_pass(State#state.id, Info),
    {noreply, State};

%% 通知进入爬塔
handle_cast('notify_enter_tower', State) ->
    Status = player:get_PS(State#state.id),
    lib_tower:open_tower_system(Status),
    {noreply, State};

%% 通知爬塔界面信息
handle_cast('notify_tower_info', State) ->
	Status = player:get_PS(State#state.id),
	lib_tower:get_tower_dungeon_info(Status),
	{noreply, State};

%% 通知进入爬塔
handle_cast('notify_enter_hardtower', State) ->
    Status = player:get_PS(State#state.id),
    lib_hardtower:open_tower_system(Status),
    {noreply, State};

%% 通知噩梦爬塔界面信息
handle_cast('notify_hardtower_info', State) ->
	Status = player:get_PS(State#state.id),
	lib_hardtower:get_tower_dungeon_info(Status),
	{noreply, State};


%% 通知副本通关
handle_cast({notify_dungeon_pass, DunNo}, State) ->
	Status = player:get_PS(State#state.id),
	mod_dungeon_plot:notify_dungeon_pass(DunNo, Status),
	{noreply, State};


%% =========================================
%% 离线竞技场
%% =========================================

%% 通知进入竞技场
handle_cast('notify_enter_offline_arena', State) ->
    Status = player:get_PS(State#state.id),
    % ?LDS_TRACE(notify_enter_offline_arena, [player:get_lv(Status)]),
    lib_offline_arena:enter_arena_group(Status),
    {noreply, State};

%% 刷新个人竞技场信息
handle_cast('refresh_offline_arena', State) ->
    Status = player:get_PS(State#state.id),
    pp_offline_arena:handle(23000, Status, []),
    {noreply, State};

%% 挑战玩家反馈
handle_cast({'challenge_warrior'}, State) ->
    Status = player:get_PS(State#state.id),
    {ok, BinData} = pt_30:write(23010, [?OA_ERROR]),
    lib_send:send_to_sock(Status#player_status.socket, BinData),
    {noreply, State};

%% 开始挑战玩家
handle_cast({'offline_arena_battle', TargetId}, State) ->
    RoleId = State#state.id,
    Status = player:get_PS(State#state.id),
    case lib_offline_arena:get_offline_arena_rd(RoleId) of
        Arena when is_record(Arena, offline_arena) ->
            lib_offline_arena:update_offline_arena(Arena#offline_arena{challange_times = Arena#offline_arena.challange_times + 1}),
            case player:is_online(TargetId) of
                true ->
                    redo;
                false ->
                    % _Bo = mod_offline_data:get_offline_bo(TargetId, ?OBJ_PLAYER, ?SYS_OFFLINE_ARENA),
                    redo
            end,
            {ok, BinData} = pt_30:write(23010, [?OA_SUCCESS]),
            lib_send:send_to_sock(Status#player_status.socket, BinData);
        _ -> ?ASSERT(false)
    end,
    {noreply, State};


%% 修正后的战斗反馈
% handle_cast({'currect_battle_feekback', InivRoleId, InivRank, NewInivRank, PasiRoleId, PasiRank, NewPasiRank, Group}, State) ->
%     lib_offline_arena:currect_battle_feekback(InivRoleId, InivRank, NewInivRank, PasiRoleId,
%         PasiRank, NewPasiRank, Group, player:get_PS(State#state.id)),
%     {noreply, State};

handle_cast('notify_fix_ranking_error', State) ->
	case player:get_PS(State#state.id) of
		Status when is_record(Status, player_status) ->
			pp_offline_arena:handle(23000, Status, []);
		_ -> skip
	end,
	{noreply, State};


%% 通知占坑状态
handle_cast({occupy_ranking, Ranking, Flag}, State) ->
	% ?LDS_TRACE({occupy_ranking, Flag}),
	case Flag =:= ?OA_SUCCESS of
		true ->
			Status = player:get_PS(State#state.id),
			lib_offline_arena:handle_occupy_scuess(Status, Ranking);
		false -> skip
	end,
	{noreply, State};


handle_cast('offline_arena_change', State) -> 
	Status = player:get_PS(State#state.id),
	lib_offline_arena:get_self_base_info(Status),
	catch lib_offline_arena:get_self_combat_info(Status),
    lib_offline_arena:get_arena_ranking_info(Status),
	{noreply, State};


handle_cast({'update_offline_arena_rd', NewArena}, State) when is_record(NewArena, offline_arena) ->
	case lib_offline_arena:get_offline_arena_rd(State#state.id) of
		Arena when is_record(Arena, offline_arena) ->
			lib_offline_arena:update_offline_arena(Arena#offline_arena{rank = NewArena#offline_arena.rank, group = NewArena#offline_arena.group});
		_ -> lib_offline_arena:update_offline_arena(NewArena)
	end,
	{noreply, State};


handle_cast({'update_offline_arena_data', Ranking, Bh}, State) ->
	case lib_offline_arena:get_offline_arena_rd(State#state.id) of
		Arena when is_record(Arena, offline_arena) ->
			lib_offline_arena:update_offline_arena(Arena#offline_arena{rank = Ranking, 
                battle_history = lib_offline_arena:add_bh(Arena#offline_arena.battle_history, Bh)});
		_ -> skip
	end,
	{noreply, State};

handle_cast({'update_offline_arena_data_win', Ranking, Bh}, State) ->
	% Status = player:get_PS(State#state.id),
	case lib_offline_arena:get_offline_arena_rd(State#state.id) of
		Arena when is_record(Arena, offline_arena) ->
			%% 日志统计
            % catch lib_log:statis_offline_arena(Status, Arena#offline_arena.group, Ranking),
			lib_offline_arena:update_offline_arena(Arena#offline_arena{rank = Ranking, 
				winning_streak = Arena#offline_arena.winning_streak + 1, 
                battle_history = lib_offline_arena:add_bh(Arena#offline_arena.battle_history, Bh)});
		_ -> skip
	end,
	{noreply, State};

handle_cast({'update_offline_arena_data_lose', Ranking, Bh}, State) ->
	% Status = player:get_PS(State#state.id),
	case lib_offline_arena:get_offline_arena_rd(State#state.id) of
		Arena when is_record(Arena, offline_arena) ->
			%% 日志统计
            % catch lib_log:statis_offline_arena(Status, Arena#offline_arena.group, Ranking),
			lib_offline_arena:update_offline_arena(Arena#offline_arena{rank = Ranking, 
				winning_streak = 0, 
                battle_history = lib_offline_arena:add_bh(Arena#offline_arena.battle_history, Bh)});
		_ -> skip
	end,
	{noreply, State};


%% =========================================
%% 世界等级
%% =========================================
handle_cast('add_sys_slot_exp', State) ->
	case player:get_PS(State#state.id) of
		Status when is_record(Status, player_status) ->
			?LDS_TRACE(add_sys_slot_exp, {State#state.id}),
			NewStatus = mod_world_lv:add_sys_slot_exp(Status),
			player_syn:update_PS_to_ets(NewStatus);
		_ -> skip
	end,
	{noreply, State};


%% =========================================
%% 押镖
%% =========================================
handle_cast({'start_hijack', TargetId}, State) ->
	case player:get_PS(State#state.id) of
		Status when is_record(Status, player_status) ->
			case mod_offline_data:get_offline_bo(TargetId, ?OBJ_PLAYER, ?SYS_TRANSPORT) of
                null -> lib_send:send_prompt_msg(State#state.id, ?PM_UNKNOWN_ERR);
                Bo -> mod_battle:start_hijack(Status, Bo, fun mod_transport:handle_hijack_feedback/2)
            end;
			% case player:is_online(TargetId) of
   %              true -> mod_battle:start_hijack(Status, player:get_PS(TargetId), fun mod_transport:handle_hijack_feedback/2);
   %              false ->
   %                  case mod_offline_data:get_offline_bo(TargetId, ?OBJ_PLAYER, ?SYS_OFFLINE_ARENA) of
   %                      null -> lib_send:send_prompt_msg(State#state.id, ?PM_UNKNOWN_ERR);
   %                      Bo -> mod_battle:start_hijack(Status, Bo, fun mod_transport:handle_hijack_feedback/2)
   %                  end
   %          end;
        _ -> error
    end,
    {noreply, State};


%% =========================================
%%取经之路
%% =========================================

handle_cast({'road_battle', OpponentId,RoadData}, State) ->
	case player:get_PS(State#state.id) of
		Status when is_record(Status, player_status) ->
			case mod_offline_data:get_offline_bo(OpponentId, ?OBJ_PLAYER, ?SYS_OFFLINE_ARENA) of  %这里使用了取经之路的战斗离线BO
                null -> 
                    lib_road:refresh_data(State#state.id, RoadData),
					lib_send:send_prompt_msg(State#state.id, ?PM_SYSTEM_TEST_QUJING_ERRO);
                Bo -> 
					Fun = fun mod_home:handle_battle_road_feedback/2,
					mod_battle:start_road(Status, Bo, Fun)
            end;
        _ -> error
    end,
    {noreply, State};





handle_cast({'start_steal', TargetId}, State) ->
	case player:get_PS(State#state.id) of
		Status when is_record(Status, player_status) ->
			case mod_offline_data:get_offline_bo(TargetId, ?OBJ_PLAYER, ?SYS_OFFLINE_ARENA) of  %这里使用了竞技场的战斗离线BO
                null -> lib_send:send_prompt_msg(State#state.id, ?PM_UNKNOWN_ERR);
                Bo -> 
					Fun = fun mod_home:handle_steal_feedback/2,
					mod_battle:start_steal(Status, Bo, Fun)
            end;
        _ -> error
    end,
    {noreply, State};


%% =========================================
%% 运营活动
%% =========================================
handle_cast({'trigger_admin_activity', ActiveId}, State) ->
	ExistList = mod_admin_activity:get_role_order_id_list(State#state.id),
	mod_admin_activity:check_role_admin_activity(State#state.id, ExistList, [ActiveId]),
	{noreply, State};


%% =========================================
%% 充值
%% =========================================
handle_cast('handle_recharge', State) ->
	player:recharge(player:get_PS(State#state.id)),
	{noreply, State};

handle_cast('first_recharge_reward', State) ->
	case player:get_PS(State#state.id) of
		Status when is_record(Status, player_status) ->
			Now = util:unixtime(), 
			F = fun({No, Origin, LastStamp}, {Count, Acc}) ->
				case data_recharge:get_data_by_no(No) of
					Recharge when is_record(Recharge, recharge) ->
						case Recharge#recharge.is_first of 
							1 ->
								IsFirstRechargeTime = case  mod_svr_mgr:get_global_sys_var(?SEND_FIRST_RECHARGE) of
														  null ->0;
														  _  -> mod_svr_mgr:get_global_sys_var(?SEND_FIRST_RECHARGE)
													  end,
								SendDay = case LastStamp =:= 0 of
											  true -> 0;
											  false -> util:get_differ_days_by_timestamp(LastStamp, Origin) + 1
										  end,
								case Recharge#recharge.first_feekback_num > 0 andalso SendDay >= 0 of
									true ->
										case IsFirstRechargeTime >=LastStamp orelse
												  LastStamp =:= 0 orelse
												 (SendDay < Recharge#recharge.first_feekback_day andalso Now > LastStamp andalso Now >= Origin andalso
																				  (not util:is_timestamp_same_day(Now, LastStamp))) of
											true ->
												Days = case LastStamp =:= 0 of
														   true ->
															   DayFix = util:get_differ_days_by_timestamp(Now, Origin) + 1,
															   ?BIN_PRED(DayFix > Recharge#recharge.first_feekback_day, Recharge#recharge.first_feekback_day, DayFix);
														   false ->
															   DayFix = util:get_differ_days_by_timestamp(Now, LastStamp),
															   ?BIN_PRED(DayFix + SendDay > Recharge#recharge.first_feekback_day,
																		 Recharge#recharge.first_feekback_day - SendDay, DayFix)
													   end,
												send_mail_recharge_feekback(Status, No, Recharge),
												{Count + 1, [{No, Now, Now} | Acc]};
											_ -> {Count, [{No, Origin, LastStamp} | Acc]}
										end;
									false -> {Count, [{No, Origin, LastStamp} | Acc]}
								end;
							_ -> {Count, [{No, Origin, LastStamp} | Acc]}
						end;
					_ -> {Count, [{No, Origin, LastStamp} | Acc]}
				end
			end,
			{Flag, NewRechargeState} = lists:foldl(F, {0, []}, Status#player_status.recharge_state),

			case Flag =/= 0 of
				true ->
					db:update(State#state.id, player,
							  [{recharge_state, util:term_to_bitstring(NewRechargeState)}],
							  [{id, State#state.id}]),
					player_syn:update_PS_to_ets(Status#player_status{recharge_state = NewRechargeState});
				false -> skip
			end;
			

		_T -> ?ERROR_MSG("[recharge] first_recharge_reward get PS error = ~p~n", [_T])
	end,
	{noreply, State};


handle_cast({'after_recharge', Amount}, State) ->
	case player:get_PS(State#state.id) of
		Status when is_record(Status, player_status) ->
			YuanBao = case data_recharge:get_data_by_money(Amount) of
						  #recharge{yuanbao = YuanBao0} ->
							  YuanBao0;
						  _ ->
							  Amount
					  end,
		
			Status1 = lib_vip:pay(YuanBao, Status),
					
			Status2 = Status1#player_status{yuanbao_acc = (Status1#player_status.yuanbao_acc + YuanBao)},
			NewPS = case Status2#player_status.first_recharge_reward_state =:= 0 of
				true ->
					db:update(State#state.id, player, [{first_recharge_reward_state, 1}], [{id, State#state.id}]),
					{ok, BinData} = pt_13:write(?PT_PLYR_RECHARGE_REWARD_STATE, [1]),
		    		lib_send:send_to_uid(State#state.id, BinData),
					Status2#player_status{first_recharge_reward_state = 1};
				false -> Status2
			end,
			player_syn:update_PS_to_ets(NewPS);
		_T ->
			?ERROR_MSG("[recharge] get PS error = ~p~n", [_T])
	end,
	{noreply, State};


%% 充值返还
handle_cast('recharge_feedback', State) ->
	% ?LDS_DEBUG(start_recharge_feedback, os:timestamp()),
	case player:get_PS(State#state.id) of
		Status when is_record(Status, player_status) ->
			?DEBUG_MSG("recharge_feedback handle_cast Accname~p",[player:get_accname(Status)]),
			case db:select_all(recharge_feedback, "order_id, amount, order_type", [{accname, player:get_accname(Status)}, {state, 0}]) of
				[] -> skip;
				List when is_list(List) ->
					RoleId = player:id(Status),
					% {NormalList, TotalList} = lists:partition(fun([_, _, Type]) -> Type =:= 0 end, List),
					% % Perfix = "slef_" ++ tool:to_list(config:get_server_id()) ++ "_",
					% % ?LDS_DEBUG(recharge_feedback_1, os:timestamp()),
					% % handle_normal_recharge_order(NormalList, player:id(Status), "self_"),

					% case check_total_order(TotalList) of
					% 	{true, TotalOrder} ->
					% 		NewStatus = handle_total_recharge_order(TotalOrder, Status),
					% 		player_syn:update_PS_to_ets(NewStatus);
					% 	false -> skip
					% end,

					% F = fun() ->
					% 	handle_normal_recharge_order(NormalList, RoleId, "self_"),
					% 	player:notify_player_recharge(RoleId)
					% end,
					% spawn(F)

					?DEBUG_MSG("List=~p",[List]),
					handle_normal_recharge_order(List, RoleId, "self_"),
					player:notify_player_recharge(RoleId),

					F = fun([_, Amount, _],Acc) ->
						% 充值操作						
						Acc + Amount
					end,

					% 累计充值金额
					TotalAmount = lists:foldl(F,0,List),
%% 					handle_total_recharge_order_duan(TotalAmount,Status),

					void
			end;
		_T -> ?ERROR_MSG("[recharge_feedback] get PS error = ~p~n", [_T])
	end,
	% ?LDS_DEBUG(end_recharge_feedback, os:timestamp()),
	{noreply, State};


handle_cast({'set_recharge_accum', {Num, Timestamp, ActId}}, State) ->
	case player:get_PS(State#state.id) of
		Status when is_record(Status, player_status) ->
			player_syn:update_PS_to_ets(Status#player_status{recharge_accum = {Num, Timestamp, ActId}});
		_ -> skip
	end,
	{noreply, State};

%单笔充值
handle_cast({'set_recharge_accum_day', {Num, Timestamp, ActId}}, State) ->
	case player:get_PS(State#state.id) of
		Status when is_record(Status, player_status) ->
			player_syn:update_PS_to_ets(Status#player_status{recharge_accum_day = {Num, Timestamp, ActId}});
		_ -> skip
	end,
	{noreply, State};


handle_cast({'clear_consume_accum', MoneyType}, State) ->
	case player:get_PS(State#state.id) of
		Status when is_record(Status, player_status) ->
			player_syn:update_PS_to_ets(Status#player_status{consume_state = lists:keydelete(MoneyType, 1, Status#player_status.consume_state)});
		_ -> skip
	end,
	{noreply, State};


%% @doc 活动结束时通知玩家
handle_cast('activity_over_notify', State) ->
	% ?LDS_DEBUG("[activity] 'activity_over_notify'"),
	mod_activity:login_check_activity_open(player:get_PS(State#state.id)),
	{noreply, State};


%% =========================================
%% 副本行为
%% =========================================

% %% 恢复所有蓝血
% handle_cast('resume_hp_mp', State) ->
% 	Status = player:get_PS(State#state.id),
% 	player:set_hp(Status, player:get_hp_lim(Status)),
% 	player:set_mp(Status, player:get_mp_lim(Status)),
% 	{noreply, State};

% %% 打开一个特定界面
% handle_cast({'open_penal', _PanelId}, State) ->
% 	redo,
% 	{noreply, State};

% %% 添加一个指定ID的BUFF
% handle_cast({'add_buff', BuffId}, State) ->
% 	lib_buff:player_add_buff(State#state.id, BuffId),
% 	{noreply, State};

% %% 删除一个指定ID的BUFF
% handle_cast({'del_buff', BuffId}, State) ->
% 	lib_buff:player_del_buff(State#state.id, BuffId),
% 	{noreply, State};

% %% 传送出副本
% handle_cast({'convey_out_dun', Dungeon}, State) ->
% 	Status = player:get_PS(State#state.id),
% 	lib_dungeon:convey_out_dun(Dungeon, Status),
% 	{noreply, State};

% %% 传送出副本指定地点
% handle_cast({'convey_out_dun', SceneID, {X, Y}}, State) ->
% 	Status = player:get_PS(State#state.id),
% 	lib_dungeon:convey_out_dun(Dungeon, Status, {SceneID, {X, Y}}),
% 	{noreply, State};

% %% 强制接取任务
% handle_cast({'forc_add_task', TaskId}, State) ->
% 	Status = player:get_PS(State#state.id),
% 	lib_task:force_accept(TaskId, Status),
% 	{noreply, State};


%% =================================================
%% mail
%% =================================================
handle_cast({'del_old_mail', Type}, State) ->
	RoleId = State#state.id,
    MailBrief = lib_mail:get_mail_brief(RoleId, Type),
    MaxCount = lib_mail:get_mail_count(Type),
    case erlang:length(MailBrief#mail_brief.mails) > MaxCount of
        true ->
            {List, DelList} = lists:split(MaxCount, MailBrief#mail_brief.mails),
            ?LDS_TRACE(del_old_mail, [DelList, MailBrief#mail_brief.mails]),
            [lib_mail:delete_mail(MailId) || {MailId, _} <- DelList],
            lib_mail:update_mail_brief(MailBrief#mail_brief{mails = List}),
            [lib_mail:notify_del_mail(RoleId, MailId) || {MailId, _}  <- DelList];
        false -> skip
    end,
    {noreply, State};


%% 反馈雪球数
handle_cast({'snowman_num', Num}, State) ->
	?LDS_TRACE('snowman_num', Num),
	{ok, BinData} = pt_29:write(29101, [Num]),
	lib_send:send_to_uid(State#state.id, BinData),
	{noreply, State};

%% =================================================
%% @doc 后台相关操作
%% =================================================

%% @doc 设置权限级别
handle_cast({'set_priv_lv', PrivLv}, State) ->
	PlayerId = State#state.id,
	PS = player:get_PS(PlayerId),
	player_syn:set_priv_lv(PS, PrivLv),
	ply_priv:db_update_priv_lv(PlayerId, PrivLv),   % 更新到DB
	ply_priv:notify_cli_priv_lv_change(PS, PrivLv), % 通知客户端
    {noreply, State};

%% @doc 在线禁言
handle_cast({'ban_chat', EndTime, Reason}, State) ->
    case EndTime =:= ?CANCEL_BAN_TIME of
        true -> erase(?BAN_CHAT);
        false -> put(?BAN_CHAT, {EndTime, Reason})
    end,
    player:offline_ban_chat(State#state.id, EndTime, Reason),
    {noreply, State};


%% @doc 立即踢下线
handle_cast({'kick_role_offline_immediate', FromPid}, State) ->
	player:set_admin_callback_pid(FromPid),
    player:set_final_logout_delay(false),
    player:kick_role_offline(State#state.id),
    {noreply, State};



handle_cast({'clear_goods_dirty_flag', GoodsId}, State) ->
    PlayerId = State#state.id,
    case mod_inv:find_goods_by_id_from_whole_inv(PlayerId, GoodsId) of
        null -> skip;
        Goods -> mod_inv:clear_dirty_flag(PlayerId, Goods)
    end,
    {noreply, State};


handle_cast({'destroy_goods_WNC', Goods, DestroyCount}, State) ->
	PlayerId = State#state.id,
	?DEBUG_MSG("[mod_player] destroy_goods_WNC, DestroyCount:~p, Goods:~w", [DestroyCount, Goods]),
	mod_inv:destroy_goods_WNC(PlayerId, Goods, DestroyCount, [?LOG_GOODS, "use"]),
    {noreply, State};


handle_cast({'adjust_goods', GoodsList, PlayerId}, State) ->
	?TRY_CATCH(try_adjust_goods(PlayerId, GoodsList), ErrorReason),
    {noreply, State};


%% 新的一天到了（到了第二天的0点整）
handle_cast('new_day_comes', State) ->
	PS = player:get_PS(State#state.id),
	ply_reset:try_reset(PS),
    {noreply, State};


%% 奖励玩家
handle_cast({'reward_player', RewardPkgNo}, State) ->
	PS = player:get_PS(State#state.id),
	?TRY_CATCH(reward_player(PS, RewardPkgNo), ErrorReason),
	{noreply, State};


%% 奖励玩家 带日志
handle_cast({'reward_player', RewardPkgNo, LogInfo}, State) ->
	PS = player:get_PS(State#state.id),
	?TRY_CATCH(reward_player(PS, RewardPkgNo, LogInfo), ErrorReason),
	{noreply, State};


%% 奖励玩家 带日志和奖励倍数
handle_cast({'reward_player', RewardPkgNo, LogInfo, RewardMulti}, State) ->
	PS = player:get_PS(State#state.id),
	?TRY_CATCH(reward_player(PS, RewardPkgNo, LogInfo, RewardMulti), ErrorReason),
	{noreply, State};


%%		GoodsList => [ {GoodsNo1, Count1, Quality1, BindState1}, {GoodsNo2, Count2, Quality2, BindState2} ... ]
%%		MailFlag => 背包满时，是否放邮箱，true表示放邮箱
%%		FromPid => 	消息来源进程 null表示不需要返回
handle_cast({'reward_player', GoodsList, LogInfo, MailFlag, FromPid}, State) ->
	case MailFlag of
		true -> erlang:put(reward_player_to_mail_when_bag_full, {MailFlag, LogInfo});
		false -> skip
	end,

	F = fun({GoodsNo, GoodsCount, Quality, BindState}) ->
		mod_inv:batch_smart_add_new_goods(State#state.id, [{GoodsNo, GoodsCount}], [{bind_state, BindState}, {quality, Quality}], LogInfo)
	end,
	[F(X) || X <- GoodsList],
	erlang:erase(reward_player_to_mail_when_bag_full),
	case FromPid =/= null of
		true -> gen_server:cast(FromPid, {'reward_player_ok', State#state.id});
		false -> skip
	end,
	{noreply, State};	


%% GoodsList -> [{GoodsNo, Count} | T]
handle_cast({'destroy_goods_WNC', GoodsList, LogInfo, FromPid}, State) ->
	PlayerId = State#state.id,
	RetBool = mod_inv:destroy_goods_WNC(PlayerId, GoodsList, LogInfo),
	case FromPid =/= null of
		true -> gen_server:cast(FromPid, {'destroy_goods_ret', State#state.id, RetBool});
		false -> skip
	end,
	
	{noreply, State};

%% MoneyList [{MoneyType, Count} | T] 只支持把金 和 银一起扣 不支持银子和绑银一起扣，金子类似
handle_cast({'cost_money', MoneyList, LogInfo, FromPid}, State) ->
	PS = player:get_PS(State#state.id),
	F = fun({MoneyType, Count}, Acc) ->
		case player:has_enough_money(PS, MoneyType, Count) of
        	false -> Acc;
        	true -> Acc + 1
        end
    end,
    case lists:foldl(F, 0, MoneyList) =:= length(MoneyList) of
    	false ->
    		case FromPid =/= null of
				true -> gen_server:cast(FromPid, {'cost_money_ret', State#state.id, false});
				false -> skip
			end;
		true ->
			F1 = fun({MoneyType, Count}, PSAcc) ->
				player_syn:cost_money(PSAcc, MoneyType, Count, LogInfo)
		    end,
		    
		    NewPS = lists:foldl(F1, PS, MoneyList),
		    case FromPid =/= null of
				true -> gen_server:cast(FromPid, {'cost_money_ret', NewPS, true});
				false -> skip
			end
	end,
	
	{noreply, State};


handle_cast({'confirm_add_tm_mb', PS}, State) ->
	LeaderId = State#state.id,
	mod_team:on_leader_confirm(PS, LeaderId),
	{noreply, State};	


handle_cast({'update_tve_data', ProbList}, State) ->
	mod_tve:set_player_tve_data(State#state.id, ProbList),
	{noreply, State};


%% 更新活动数据
handle_cast({'update_act_data', ActNo, ProbList}, State) ->
	PlayerId = State#state.id,
	case ActNo of
		?AD_BRESS ->
			lib_festival_act:update_act_data(PlayerId, ProbList);
		_ ->
			?WARNING_MSG("mod_player:update_act_data error!:ActNo~p~n", [ActNo])
	end,

	{noreply, State};			 

handle_cast('mark_init_for_enter_game_done', State) ->
	mark_init_for_enter_game_done__(),
	{noreply, State};

%% PS : 秘籍使用，开发服服务端单独测试协议号
handle_cast({"TEST_CMD", Cmd, Data}, PlayerStatus) ->
    {reply, _Reply, NewPlayerStatus} = mod_player:handle_call({'SOCKET_EVENT', Cmd, Data}, null, PlayerStatus),
    {noreply, NewPlayerStatus};	


handle_cast(Request, State) ->
    try
        do_cast(Request, State)
    catch
        Err:Reason->
            ?ERROR_MSG("ERR:~p,Reason:~p, Request:~p",[Err,Reason, Request]),
            {noreply, State}
    end.

%% cast处理协议
do_cast({'SOCKET_EVENT', Cmd, Data}, PlayerStatus) ->
	{reply, _Reply, NewPlayerStatus} = mod_player:handle_call({'SOCKET_EVENT', Cmd, Data}, null, PlayerStatus),
    {noreply, NewPlayerStatus};	


%% 发称号
do_cast({add_title, Title, AddTime}, #state{id=UID}=State) ->
	ply_title:add_title(UID, Title, AddTime),
	{noreply, State};

%% 发自定义称号
do_cast({add_user_def_title, TitleID, String}, #state{id=UID}=State) ->
	ply_title:add_user_def_title(UID, TitleID, String),
	{noreply, State};

%% 删称号
do_cast({del_title, TitleID}, #state{id=UID}=State) ->
	ply_title:del_title(UID, TitleID),
	{noreply, State};

%% 更新玩家杂项信息
do_cast({'update_player_misc_for_guild_war', Turn}, State) ->
	PlayerMisc = ply_misc:get_player_misc(State#state.id),
	PS = player:get_PS(State#state.id),
	ply_misc:update_player_misc(PlayerMisc#player_misc{guild_war_id = player:get_guild_id(PS), guild_war_turn = Turn}),
	{noreply, State};	


do_cast(set_cross_local, State) ->
	erlang:put(?PDKN_CROSS_STATE, ?CROSS_STATE_LOCAL),
	{noreply, State#state{cross_state = ?CROSS_STATE_LOCAL}};

do_cast(set_cross_remote, State) ->
	erlang:put(?PDKN_CROSS_STATE, ?CROSS_STATE_REMOTE),
	{noreply, State#state{cross_state = ?CROSS_STATE_REMOTE}};

do_cast(set_cross_mirror, State) ->
	erlang:put(?PDKN_CROSS_STATE, ?CROSS_STATE_MIRROR),
	{noreply, State#state{cross_state = ?CROSS_STATE_MIRROR}};

do_cast({ban_chat_phone, Result}, State) ->
	erlang:put(?BAN_PHONE, Result),
	{noreply, State};

%% 更新排行榜当前数据
do_cast({rank_data_current, RankID, Data}, State) ->
	PlayerMisc = ply_misc:get_player_misc(State#state.id),
	RankDataCurrent2 = 
		case lists:keytake(RankID, 1, PlayerMisc#player_misc.rank_data_current) of
			{value, {RankID, _Value}, RankDataCurrent} ->
				[{RankID, Data}|RankDataCurrent];
			?false ->
				[{RankID, Data}|PlayerMisc#player_misc.rank_data_current]
		end,
	PlayerMisc2 = PlayerMisc#player_misc{rank_data_current = RankDataCurrent2},
	ply_misc:update_player_misc(PlayerMisc2),
	{noreply, State};
	
do_cast(_Event, State) ->
	?WARNING_MSG("unhandle cast ~p", [_Event]),
	?ASSERT(false, _Event),
    {noreply, State}.




%% 统一模块+过程调用(call)
handle_call({apply_call, Module, Method, Args}, _From, State) ->
	Reply  =
	case (catch apply(Module, Method, Args)) of
		 {'EXIT', Info} ->
			 ?WARNING_MSG("mod_player_apply_call error: Module=~p, Method=~p, Reason=~w",[Module, Method,Info]),
			 error;
		 DataRet ->
             DataRet
	end,
    {reply, Reply, State};


%%处理socket协议
%%Cmd：协议号
%%Data：已经解析过的协议所附带的数据
handle_call({'SOCKET_EVENT', Cmd, Data}, _From, State) ->
%% 	io:format("{mod_player, Cmd} : ~p~n", [{?MODULE, ?LINE, Cmd, Data}]),
	%% 有几种情况，如果是跨服状态的话，也有一些协议在本服也是禁用的
	PlayerId = State#state.id,
	FunLocal = fun() ->
					   case Cmd of
						   ?PT_PLAYER_MOVE ->
							   handle_player_move_cmd(PlayerId, Data);
						   _ ->
							   case player:get_PS(PlayerId) of
								   PS when is_record(PS, player_status) ->
									   case routing(Cmd, PS, Data) of
										   {ok, PS2} when is_record(PS2, player_status) ->
											   %%?TRACE("Cmd: ~p~n", [Cmd]),
											   player_syn:update_PS_to_ets(PS2);
										   _Any ->
											   skip
									   end;
								   Other ->
									   ?ERROR_MSG("[mod_player] SOCKET_EVENT get PS failed!! PS:~p, State:~w, Cmd:~p, LastCmd:~p, InitDone:~p~n", [Other, State, Cmd, erlang:get(?PDKN_LAST_PROTO), is_init_for_enter_game_done__()]),
									   stop(self(), 'get_PS_failed')
							   end
					   end
			   end,
	case State#state.cross_state =:= ?CROSS_STATE_REMOTE of
		?false ->
			%% 不在跨服
			FunLocal();
		?true ->
			%% 跨服状态
			case check_cross_proto_ban(Cmd) of
				?true ->% 禁止的协议
					%% 当前是跨服状态，且协议使禁用的，提示玩家返回原服再操作
					lib_send:send_prompt_msg(PlayerId, ?PM_CROSS_BAN_PROTO);
				?false ->
					case check_cross_proto_both_local(Cmd) of
						?true ->
							%% 玩家镜像在跨服服务器，转发协议数据到跨服服务器
							FunLocal(),
							sm_cross_server:rpc_proto_data_cast(PlayerId, Cmd, Data);
						?false ->
							case check_cross_proto(Cmd) of
								?true ->
									sm_cross_server:rpc_proto_data_cast(PlayerId, Cmd, Data);
								?false ->
									FunLocal()
							end
					end
			end
			
	end,

	erlang:put(?PDKN_LAST_PROTO, Cmd),
	{reply, ok, State};




% 废弃！
% %% 重连进入游戏时检查角色是否在临时退出缓存中？
% %% 注意： 如果角色在缓存中，并且当前不处于最终退出游戏的状态中，则会同时更新玩家的当前行为状态为“正在重连进入游戏中”，
% %%        这个是为了避免：如果同时执行重连进入游戏与重连超时对应的处理，则可能会引发同步问题！
% handle_call({'check_if_role_in_cache_for_reconnect', RoleId}, _From, State) ->
% 	Ret = case player:in_tmplogout_cache(RoleId) of
% 		false ->
% 			false;
% 		true ->
% 			PS = mod_svr_mgr:get_tmplogout_player_status(RoleId),
% 			?ASSERT(PS /= null),
% 			case player:get_cur_bhv_state(PS) of
% 				?BHV_FINAL_LOGOUTING ->
% 					{true, but_final_logouting};  % 在缓存，但正处于最终退出游戏的状态中
% 				_ ->
% 					PS2 = PS#player_status{cur_bhv_state = ?BHV_RECONNECT_ENTERING_GAME},
% 					mod_svr_mgr:update_tmplogout_player_status_to_ets(PS2),

% 					{true, not_final_logouting} % 在缓存，并且不处于最终退出游戏的状态中
% 			end
% 	end,
% 	{reply, Ret, State};

%% ======================================
%% @doc 后台操作
%% ======================================

%% 查询封禁状态
%% @retrun {banChatTime, banRoleTime}

handle_call('kick_role_offline_immediate', From, State) ->
	player:set_admin_callback_pid(From),
	player:set_final_logout_delay(false),
    player:kick_role_offline(State#state.id),
    {reply, ok, State};


%% 强制接取任务
handle_call({'forc_add_task', TaskId}, _, State) ->
	Status = player:get_PS(State#state.id),
	lib_task:force_accept(TaskId, Status),
	{reply, ok, State};

%% GoodsList -> [{GoodsNo, Count} | T]
handle_call({'destroy_goods_WNC', PlayerId, GoodsList}, _From, State) ->
	Ret =
		case PlayerId =:= State#state.id of
			false -> false;
			true ->
				mod_inv:destroy_goods_WNC(PlayerId, GoodsList, [?LOG_ADMIN, "gm_action"])
		end,
	{reply, Ret, State};

handle_call(_Event, _From, State) ->
	?ASSERT(false, _Event),
    {reply, ok, State}.



%%子进程有退出
%handle_info({'EXIT', _Pid, _Reason}, Status) ->
%    {noreply, Status};




handle_info({timeout, _TimerRef, 'timing_save_task'}, State) ->
	Status = player:get_PS(State#state.id),
	lib_task:timing_save(Status),
	{noreply, State};



% handle_info({timeout, _TimerRef, 'timer_mail'}, State) ->
% 	lib_mail:start_mail_timer(player:get_PS(State#state.id)),
% 	lib_mail:save(),
% 	{noreply, State};


handle_info({timeout, _TimerRef, {timer_task, TaskId, TimeStamp}}, State) ->
    Status = player:get_PS(State#state.id),
    lib_task:handle_task_timeout(TaskId, TimeStamp, Status),
    {noreply, State};


% 邮件计时
handle_info({timeout, _TimerRef, 'timer_mail'}, State) ->
	case lib_comm:is_now_nearby_midnight() of
		true -> skip;
		false -> lib_mail:save()
	end,
	lib_mail:start_mail_timer(player:get_PS(State#state.id)),
	{noreply, State};


handle_info({timeout, _TimerRef, {'dungeon_ensure', _TeamList}}, State) ->
    Status = player:get_PS(State#state.id),
    case lib_dungeon:get_ensure_list() of
        null -> skip;
        {_, []} -> lib_dungeon:cancel_ensure();
        {_, List} ->
            lib_dungeon:cancel_ensure(),
            {ok, BinData} = pt_57:write(57004, [0, [{Id, 1} || Id <- List]]),
            lib_send:send_to_sock(Status#player_status.socket, BinData)
    end,
    {noreply, State};

handle_info({test_tower, PlayerId, Floor}, State) ->
	lib_dungeon:enter_tower_dungeon(PlayerId,Floor,0),
	{noreply, State};




handle_info({dungeon_ensure, RoleId, Flag}, State) ->
    Status = player:get_PS(State#state.id),
    case Flag =:= 0 orelse Flag =:= 2 of
        true ->
            case lib_dungeon:get_ensure_list() of
                null -> skip;
                _ ->
                    lib_dungeon:cancel_ensure(),
                    % TeamId = player:get_team_id(Status),
                    % TeamList = mod_team:get_can_fight_member_id_list(TeamId),
                    {ok, BinData} = pt_57:write(57004, [0, [{RoleId, ?BIN_PRED(Flag =:= 2, Flag, 1)}]]),
                    lib_send:send_to_uid(State#state.id, BinData)
                    % [lib_send:send_to_uid(Id, BinData) || Id <- TeamList]
            end;
        false ->
            case lib_dungeon:get_ensure_list() of
                null -> skip;
                {DunNo, List} ->
                    NewList = lists:delete(RoleId, List),
                    case NewList =:= [] of
                        true ->
                            {ok, BinData} = pt_57:write(57004, [1, []]),
                            lib_send:send_to_sock(Status#player_status.socket, BinData),
                            lib_dungeon:cancel_ensure(),
                            case lib_dungeon:can_create_dungeon(DunNo, util:unixtime(), Status) of
                            	{true, _TeamList} ->
																 %% lib_dungeon:cost_dungeon_props(Status, DunNo)
		                            case true of
		                            	true -> lib_dungeon:create_dungeon(DunNo, Status);
		                            	{false, Code} ->
		                            		{ok, BinDataC} = pt_57:write(57001, [DunNo, Code]),
		                                    lib_send:send_to_uid(RoleId, BinDataC)
		                            end;
		                        {false, Code} ->
		                        	{ok, BinDataC} = pt_57:write(57001, [DunNo, Code]),
                                    lib_send:send_to_sock(Status#player_status.socket, BinDataC)
                            end;
                        false ->
                            lib_dungeon:set_ensure_list(DunNo, NewList)
                    end
            end
    end,
    {noreply, State};


handle_info({'return_cal_ranking_state', RankState}, State) ->
	Status = player:get_PS(State#state.id),
	case RankState  of
		false -> lib_send:send_prompt_msg(Status, ?PM_OFFLINE_ARENA_RANKING_CALING);
		_ -> lib_offline_arena:ensure_to_send_reward(Status)
	end,
	{noreply, State};


%% 组队进入某个活动，成员确认超时处理
handle_info({timeout, _TimerRef, {'team_ensure', ActNo, LvStep, _TeamList}}, State) ->
    PS = player:get_PS(State#state.id),
    case lib_team:get_ensure_list(ActNo) of
        null -> skip;	
        {ActNo, List} ->
            lib_team:cancel_ensure(ActNo),
            %% 根据某个活动的模块通知进入活动失败
            case List =:= [] of
            	true ->
            		case ActNo of
            			?AD_TVE ->
            				mod_tve:notify_enter_result(PS, ?RES_OK, [], 1, LvStep),
            				mod_tve_mgr:handle_enter(PS, LvStep);
            			_ -> skip
            		end;
            	false ->
		            case ActNo of
		            	?AD_TVE ->
		            		mod_tve:notify_enter_result(PS, ?RES_FAIL, List, 1, LvStep);
		            	_Any ->
		            		skip
		            end
		    end
    end,
    {noreply, State};


%% 组队进入某个活动，成员选择确认
handle_info({team_ensure, ActNo, LvStep, PlayerId, Flag}, State) ->
	?DEBUG_MSG("mod_player: team_ensure begin,{ActNo, LvStep, Flag}:~w~n", [{ActNo, LvStep, Flag}]),
    PS = player:get_PS(State#state.id),
    case Flag =:= 0 orelse Flag =:= 2 of %% 0->点否 1->使用物品 2->不使用物品
        true ->
            case lib_team:get_ensure_list(ActNo) of
                null -> skip;
                {_ActNo, List} ->
                	case lists:member(PlayerId, List) of
                		false -> skip;
                		true ->
		                    lib_team:cancel_ensure(ActNo),
		                    case ActNo of
				            	?AD_TVE -> mod_tve:notify_enter_result(PS, ?RES_FAIL, [PlayerId], Flag, LvStep);
				            	_Any -> skip
		            		end
		            end
            end;
        false ->
            case lib_team:get_ensure_list(ActNo) of
                null -> skip;
                {ActNo, List} ->
                    NewList = lists:delete(PlayerId, List),
                    case NewList =:= [] of
                        true ->
                            lib_team:cancel_ensure(ActNo),
                            case ActNo of
                            	?AD_TVE ->
                            		mod_tve:notify_enter_result(PS, ?RES_OK, [], 1, LvStep),
                            		mod_tve_mgr:handle_enter(PS, LvStep);
                            	_ -> skip
                            end;
                        false ->
                            lib_team:set_ensure_list(ActNo, NewList)
                    end
            end
    end,
    {noreply, State};

%%定时洗炼
handle_info({timeout, _TimerRef, recast_timer}, State) ->
	case get(?PDKN_RECAST_TIMER) of
		undefined ->
			void;
		{RecastArgs, _, IsAttention} ->
			case IsAttention =:= 0 of
				true ->
					PS = player:get_PS(State#state.id),
					start_timer(RecastArgs, IsAttention),
					pp_goods:handle(?PT_EQ_NEW_RECAST, PS, RecastArgs);
				false ->
					erlang:erase(?PDKN_RECAST_TIMER)
			end
	end
	,
	{noreply, State};

%% 测试跨服
handle_info({test_cross, ServerId}, State) ->
	
	{noreply, State};

  

handle_info(_Info, State) ->
    {noreply, State}.

code_change(_oldvsn, State, _extra) ->
    {ok, State}.

%%
%% ======================================== Local Functions ===========================================
%%
%% 发送邮件通知玩家充值返利
send_mail_recharge_feekback(Status, _No, Recharge) ->
	Content = io_lib:format(<<"这是您的~p额度首次充值奖励，谢谢支持！">>, [Recharge#recharge.money]),
	Title = io_lib:format(<<"额度首次奖励">>, []),
	lib_mail:send_sys_mail(player:id(Status), tool:to_binary(Title), tool:to_binary(Content), Recharge#recharge.first_feekback_num, [?LOG_MAIL, "recv_paybag"]).


%% 发送月卡反馈邮件
send_mail_month_card_feekback(Status, _No, _MoneyType, Count, LeftDays, ShowDays) ->
	Content = io_lib:format(<<"月卡返利，一共~p绑金已经自动放入包包，月卡剩余天数还有~p天">>, [Count, LeftDays]),
	Title = io_lib:format(<<"月卡返利">>, []),
	lib_mail:send_sys_mail(player:id(Status), tool:to_binary(Title), tool:to_binary(Content), [], [?LOG_MAIL, "recv_paybag"]),
	case LeftDays =< ShowDays of
		true ->
			lib_mail:send_sys_mail(player:id(Status), <<"月卡续期">>,
				<<"主人的月卡快要到期啦，赶快去商城续费吧">>, [], [?LOG_MAIL, "recv_paybag"]);
		false -> skip
	end.


%% 调试版本：发送报错信息给客户端
dbg_notify_cli_error_msg(PlayerId, ErrMsg) ->
	?ASSERT(is_list(ErrMsg)),
	ErrMsg_Bin = tool:to_binary(ErrMsg),
	Len = byte_size(ErrMsg_Bin),
	Data = <<Len:16, ErrMsg_Bin/binary>>,
	Data2 = pt:pack(?PT_DEBUG_ERR_MSG_ECHO, Data),
	lib_send:send_to_uid(PlayerId, Data2).


start_timer(RecastInfo, IsAttention) ->
	TimerRef = erlang:start_timer(1500, self(), recast_timer),
    ?DEBUG_MSG("this is ref ~p", [TimerRef]),
	RecastTime = {RecastInfo, TimerRef, IsAttention},
	put(?PDKN_RECAST_TIMER, RecastTime).



%% 路由
%% Cmd:协议号
%% Data: 已经解析过的协议所附带的数据
-ifdef(debug).
	routing(Cmd, Status, Data) ->
		try
			routing2(Cmd, Status, Data)
		catch
			Err:Reason ->
				?ERROR_MSG("[mod_player] routing() ERROR!!! PlayerId:~p, Cmd=~p, details=~w", [erlang:get(?PDKN_PLAYER_ID), Cmd, {Err, Reason, erlang:get_stacktrace()}]),
				ErrMsg = io_lib:format("handle cmd [~p] ERROR: ~w", [Cmd, {Err, Reason, erlang:get_stacktrace()}]),
				?LDS_TRACE("ERROR!!!", [{protol, Cmd}, "\n", ErrMsg]),
				dbg_notify_cli_error_msg( player:id(Status), ErrMsg),
				{error, handle_cmd_error}
		end.
-else.
	routing(Cmd, Status, Data) ->
		try
			routing2(Cmd, Status, Data)
		catch
			Err:Reason ->
				?ERROR_MSG("[mod_player] routing() ERROR!!! PlayerId:~p, Cmd=~p, details=~w", [erlang:get(?PDKN_PLAYER_ID), Cmd, {Err, Reason, erlang:get_stacktrace()}]),
				{error, handle_cmd_error}
		end.
-endif.

% 协议
routing2(Cmd, Status, Data) ->
	%%?TRACE("routing2, cmd: ~p, Bin: ~p~n", [Cmd, Bin]),
    %% io:format("recv:~p~n",[Cmd]),
    %%取前面二位区分功能类型
    [H1, H2, _, _, _] = integer_to_list(Cmd),
    case [H1, H2] of
        "10" -> pp_base:handle(Cmd, Status, Data);  % 游戏基础功能处理
        "11" -> chat(Cmd, Status, Data);
        "12" -> pp_scene:handle(Cmd, Status, Data);
        "13" -> pp_player:handle(Cmd, Status, Data);
        "14" -> pp_relation:handle(Cmd, Status, Data);
        "15" -> pp_goods:handle(Cmd, Status, Data);
        "16" -> pp_tve:handle(Cmd, Status, Data);
        "17" -> pp_partner:handle(Cmd, Status, Data);
        "18" -> pp_mount:handle(Cmd, Status, Data);
        "19" -> pp_mail:handle(Cmd, Status, Data);
        "20" -> pp_battle:handle(Cmd, Status, Data);
        "21" -> pp_xinfa:handle(Cmd, Status, Data);
        "22" -> pp_rank:handle(Cmd, Status, Data);
        "23" -> pp_offline_arena:handle(Cmd, Status, Data);
        "24" -> pp_team:handle(Cmd, Status, Data);
        "26" -> pp_market:handle(Cmd, Status, Data);
        "27" -> pp_arena:handle(Cmd, Status, Data);
        "28" -> pp_melee:handle(Cmd, Status, Data);
        "29" -> pp_christmas:handle(Cmd, Status, Data);
		%%"29" -> pp_antirevel:handle(Cmd, Status, Data);
        "30" -> pp_task:handle(Cmd, Status, Data);
        "31" -> pp_activity:handle(Cmd, Status, Data);
        "32" -> pp_npc:handle(Cmd, Status, Data);
        "35" -> pp_sprd:handle(Cmd, Status, Data);
        "33" -> pp_couple:handle(Cmd, Status, Data);
        "37" -> pp_home:handle(Cmd, Status, Data);
		"39" -> pp_train:handle(Cmd, Status, Data);
        "38" -> pp_road:handle(Cmd, Status, Data);
        "40" -> pp_guild:handle(Cmd, Status, Data);
        "41" -> pp_hire:handle(Cmd, Status, Data);
		%%"48" -> pp_visitor_reg:handle(Cmd, Status, Data);
		"42" -> pp_transport:handle(Cmd, Status, Data);
        "43" -> pp_cross:handle(Cmd, Status, Data);
		"44" -> pp_wing:handle(Cmd, Status, Data);
		"45" -> pp_fabao:handle(Cmd,Status,Data);
		"49" -> pp_tower:handle(Cmd, Status, Data);
		% "49" -> skip;
		"50" -> pp_mystery:handle(Cmd, Status,Data);
		"51" -> pp_diy:handle(Cmd, Status,Data);
		"52" -> pp_trade:handle(Cmd, Status, Data);
		"53" -> pp_guild_dungeon:handle(Cmd, Status, Data);
		"54" -> pp_luck:handle(Cmd, Status, Data);
        "57" -> pp_dungeon:handle(Cmd, Status, Data);
		"56" -> pp_limit_task:handle(Cmd, Status, Data);
        "58" -> pp_activity_degree:handle(Cmd, Status, Data);
        "59" -> pp_chapter_target:handle(Cmd, Status, Data);
        %%"60" -> pp_gateway:handle(Cmd, Status, Data);
        "36" -> pp_newyear_banquet:handle(Cmd, Status, Data);
        "34" -> pp_activity:handle(Cmd, Status, Data);
        "62" -> pp_hardtower:handle(Cmd, Status, Data);
        "63" -> pp_business:handle(Cmd, Status, Data);
        "64" -> pp_slotmachine:handle(Cmd, Status, Data);
        "65" -> pp_guild_battle:handle(Cmd, Status, Data);
        _Any ->
            %%?ERROR_MSG("[mod_player] routing2() ERROR!!! Cmd=~p", [Cmd]),
            ?ASSERT(false, Cmd),
            {error, routing_failed}
    end.



%% 跨服状态只转发到跨服节点的协议
%% 目前考虑协议大模块，是否需要精确到协议号有待商榷，还有就是这个判断是否适用于sm_writer里跨服服务器转发给原来服务器的协议）
check_cross_proto(Cmd) ->
	[H1, H2, _, _, _] = integer_to_list(Cmd),
	ListMod = [
			   "12",  % 场景相关协议
			   "20",  % 战斗
			   "24",  % 组队
			   "28",  % 泡点/乱斗
			   "43",  % 跨服
			   "54"
			  ],
	ListProto = [?PT_GET_ROLE_INFO, 			%% 获取玩家聊天相关信息 ##############
%% 				 ?PT_PLYR_GET_MY_BRIEF, 		%% 获取玩家自己的简要信息（角色进入游戏成功后，客户端通过发此协议来查询角色的简要信息） 
%% 				 ?PT_PLYR_GET_INFO_DETAILS, 	%% 获取指定玩家的信息详情（只支持获取在线的玩家） ------------
				 ?PT_PLYR_QUERY_OL_STATE, 		%% 查询某个玩家是否在线 ------------
				 ?PT_PLYR_SET_PAODIAN_TYPE,  	%% 设置泡点方式
%% 				 30008,							%% 取得某一NPC task data (个人认为不需要在跨服节点处理)
				 30010,							%% 查询任务怪物位置
%% 				 ?PT_QRY_NPC_FUNC_LIST,  		%% 查询npc的功能列表 (涉及到任务相关，考虑在本服处理)
				 ?PT_QRY_NPC_TEACH_SKILL_LIST,  %% 查询npc的教授技能列表  
				 ?PT_START_MF_BY_TALK_TO_NPC,  	%% 通过对话NPC直接打指定编号的怪物组
				 ?PT_TALK_TO_MON 				%% 对话明雷怪
				],
	lists:member([H1, H2], ListMod) orelse lists:member(Cmd, ListProto).

%% 跨服状态下本地和跨服都需要处理的协议
check_cross_proto_both_local(Cmd) ->
	[H1, H2, _, _, _] = integer_to_list(Cmd),
	ListMod = [
			  ],
	ListProto = [
				 ?PT_C2S_NOTIFY_INIT_DONE		%% 客户端通知服务端：客户端已初始化完毕
				],
	lists:member([H1, H2], ListMod) orelse lists:member(Cmd, ListProto).
 

%% 跨服状态禁止的协议
check_cross_proto_ban(Cmd) ->
	[H1, H2, _, _, _] = integer_to_list(Cmd),
	ListMod = [
			   "38",  % 取经
			   "42",  % 运镖
			   "65"	  % 帮战
			  ],
	ListProto = [
%% 				 ?PT_REQ_TELEPORT,  			%% 请求传送 
				 23010,  						%% 离线竞技挑战玩家
				 ?PT_HOME_ENTER_SCENE, 			%% 进入家园
				 ?PT_GUILD_DUNGEON_ENTER, 		%% 进入帮派副本
				 49003,							%% 进入爬塔副本
				 ?PT_ENTER_DUNGEON,				%% 进入帮派副本
				 57001,							%% 创建并进入副本
			     62003							%% 进入爬塔副本
				],
	lists:member([H1, H2], ListMod) orelse lists:member(Cmd, ListProto).


%% 处理玩家移动
-ifdef(debug).
	handle_player_move_cmd(PlayerId, Data) ->
		try
			pp_scene:handle(?PT_PLAYER_MOVE, PlayerId, Data)
		catch
			Err:Reason ->
				% ?ERROR_MSG("处理消息[~p]出异常：~w", [Cmd, {Err, Reason, erlang:get_stacktrace()}]),
				?ERROR_MSG("[mod_player] handle_player_move_cmd() ERROR!!! InitDone:~p, details=~10000p", [is_init_for_enter_game_done__(), {Err, Reason, erlang:get_stacktrace()}]),
				ErrMsg = io_lib:format("handle cmd PT_PLAYER_MOVE ERROR: ~w", [{Err, Reason, erlang:get_stacktrace()}]),
				dbg_notify_cli_error_msg(PlayerId, ErrMsg),
				{error, "handle cmd error"}
		end.
-else.
	handle_player_move_cmd(PlayerId, Data) ->
		try
			pp_scene:handle(?PT_PLAYER_MOVE, PlayerId, Data)
		catch
			Err:Reason ->
				% ?ERROR_MSG("处理消息[~p]出异常：~w", [Cmd, {Err, Reason, erlang:get_stacktrace()}]),
				?ERROR_MSG("[mod_player] handle_player_move_cmd() ERROR!!! InitDone:~p, details=~10000p", [is_init_for_enter_game_done__(), {Err, Reason, erlang:get_stacktrace()}]),
				{error, "handle cmd error"}
		end.
-endif.


%% 初始化玩家的心跳计数为0
init_heartbeat_count__() ->
	put(?PDKN_PLAYER_HEARTBEAT_COUNT, 0).

%% 自增玩家的心跳计数，返回最新的心跳计数
incr_heartbeat_count__() ->
	NewCount = get(?PDKN_PLAYER_HEARTBEAT_COUNT) + 1,
	put(?PDKN_PLAYER_HEARTBEAT_COUNT, NewCount),
	NewCount.





% %% 处理怪物被杀死
% mon_killed(_PS, _MonInfo) ->
% 	todo_here.





handle_after_escape_from_battle(PlayerId, Feedback) ->
   	?TRACE("[mod_player] after_escape_from_battle...~n"),

   	ply_scene:reset_step_counter(PlayerId),

	mod_team:on_escape_from_battle(PlayerId),

	PS = player:get_PS(PlayerId),

	% 逃跑后补血功能，需要完善战斗逃跑反馈才可以开放
	% LeftHp = Feedback#btl_feedback.left_hp,
	% LeftMp = Feedback#btl_feedback.left_mp,

	% {NewHp, NewMp} = adjust_hp_mp_after_battle(PS, LeftHp, LeftMp),
	% player:set_hp_mp(PS, NewHp, NewMp),

	% 通知战斗逃跑事件
	lib_event:event(?BATTLE_ESCAPE, [], PS),

	% 通知离线竞技场
	case lib_bt_comm:is_offline_arena_battle(Feedback) of
    	true ->
    		[EnemyId] = Feedback#btl_feedback.oppo_player_id_list,
    		case EnemyId =/= ?INVALID_ID of
    			% true -> lib_offline_arena:battle_feekback(PlayerId, EnemyId, lose, PS);
    			true -> mod_offline_arena:battle_feekback(PlayerId, EnemyId, lose);
    			false -> skip
    		end;
    	false ->
    		skip
    end,

    mod_dungeon:feekback_boss_dungeon_escape(PS),

    battle_callback(PlayerId, Feedback).




handle_battle_feedback(PlayerId, Feedback) ->
	?ASSERT(is_record(Feedback, btl_feedback)),
	?ASSERT(Feedback#btl_feedback.player_id == PlayerId),

	?TRACE("[mod_player] handle_battle_feedback()...~n~n"),

	?TRACE("Feedback, oppo_player_id_list:~p, hired_player_id=~p, mon_id:~p, mon_no:~p, bmon_group_no:~p~n",
										[
										Feedback#btl_feedback.oppo_player_id_list,
										Feedback#btl_feedback.hired_player_id,
										Feedback#btl_feedback.mon_id,
										Feedback#btl_feedback.mon_no,
										Feedback#btl_feedback.bmon_group_no
										]),

	% 日志统计
	case player:get_PS(PlayerId) of
		Status when is_record(Status, player_status) ->
			lib_log:statis_battle(Status, Feedback);
		_ -> skip
	end,

	case lib_bt_comm:is_PVE_battle(Feedback) of
		true ->
			handle_PVE_battle_feedback(PlayerId, Feedback);
		false ->
			handle_PVP_battle_feedback(PlayerId, Feedback)
	end,
	battle_callback(PlayerId, Feedback).


handle_PVE_battle_feedback(PlayerId, Feedback) ->
	PS = player:get_PS(PlayerId),

	mod_dungeon:notify_battle_feekback(Feedback, PS),
	Result = Feedback#btl_feedback.result,

	%%拿出的玩家数据
	{Floor,DungeonNo,TowerBmon} =
		case get('tower') of
			undefined ->
				{0,0,0};
			TowerData ->
				erase('tower'),
				TowerData
		end,
	?DEBUG_MSG("TowerbattleFeedback ~p Mon_no ~p~n",[{Floor,TowerBmon},Feedback#btl_feedback.bmon_group_no]),
	
	case Feedback#btl_feedback.mon_no of
		35171 ->
			BossLeftHp = Feedback#btl_feedback.guild_boss_hp,
			DataDungeon = data_guild_new_dungeon:get(7),
			InitBossHp = DataDungeon#guild_new_dungeon.boss_hp,
			
			PlayerId = player:get_id(PS),
			GuildPerson = mod_guild_dungeon:get_guild_person_from_ets(PlayerId),
			GuildId = player:get_guild_id(PlayerId),
			Point = GuildPerson#guild_person.doing_point,				
			GuildWeek = list_to_integer(lists:concat([GuildId,Point])) ,
			GuildPoint = mod_guild_dungeon:get_guild_dungeon_point_from_ets(GuildWeek),

			DValue2= InitBossHp - GuildPoint#guild_dungeon_point.boss_hp - BossLeftHp,
			DValue = case DValue2 < 0 of
						 true ->   0;
						 false -> DValue2
					 end,

			lib_guild_dungeon:cal_boss_hp(PS,DValue);
		_ ->
			skip
		end,
	case Feedback#btl_feedback.bmon_group_no of
		TowerBmon ->
			case Result of
				win ->
					%%发送奖励
					DungeonData = data_dungeon:get(DungeonNo),
					TowerReward =
						case DungeonData#dungeon_data.had_pass_reward of
							0 ->
								[];
							1 ->
								case data_dungeon:get_pass_reward_no(DungeonNo) of
									null -> [];
									Rno when is_integer(Rno) andalso Rno > 0 ->
										RewardDtl = lib_reward:give_reward_to_player(dungeon, 1, PS, Rno, [?LOG_DUNGEON, DungeonNo]),
										RewardDtl#reward_dtl.goods_list;
									_ -> []
								end
						end,
					TowerReward2 =
						case DungeonData#dungeon_data.first_reward > 0 of
							true ->
								RewardDtl2 = lib_reward:give_reward_to_player(dungeon, 1, PS, DungeonData#dungeon_data.first_reward, [?LOG_DUNGEON, DungeonNo]),
								RewardDtl2#reward_dtl.goods_list;
							false ->
								[]
						end,
					TowerReward3 = TowerReward ++ TowerReward2,
					List = [{Id, No, Num, mod_inv:get_goods_quality_by_id(PlayerId, Id), mod_inv:get_goods_bind_state_by_id(Id)}
						|| {Id, No, Num} <- TowerReward3 ],
					lib_tower:notify_tower_reward(PS, List),
					lib_tower:set_next_floor(PlayerId, Floor),
					lib_tower:back_event(PS),
					%%再发一边49001给前端刷新信息
					lib_tower:get_tower_info(PS);
				lose ->
					lib_tower:notify_tower_battle_lost(PS)
			end;
		_ -> skip
	end,

	case Result of
		win ->
			F = fun({BMonNo, Count}) -> % {战斗怪编号，数量}
				?TRACE("calling lib_event:event(kill, ..) , ~p~n", [{BMonNo, Count}]),
				lib_event:event(?KILL_SUCCESS, [BMonNo, Count], PS)
					end,
			SpawnedBMonList = Feedback#btl_feedback.spawned_bmon_list,
			lists:foreach(F, SpawnedBMonList),

			%帮派副本采集怪物处理 写死处理，怪物编号只用于帮派副本  LeftHp = Feedback#btl_feedback.left_hp,
			case Feedback#btl_feedback.mon_no of
				35166 ->  %第二关
					lib_guild_dungeon:kill_count(PS,Feedback#btl_feedback.mon_no);
				35168 ->
					lib_guild_dungeon:kill_count(PS,Feedback#btl_feedback.mon_no);
				35169 ->
					lib_guild_dungeon:drop_count(PS,Feedback#btl_feedback.mon_no,1);
				35167 ->
					lib_guild_dungeon:kill_count(PS,Feedback#btl_feedback.mon_no);
				35172 ->
					lib_guild_dungeon:drop_count(PS,Feedback#btl_feedback.mon_no,2);
				35170 ->
					lib_guild_dungeon:kill_boss_count(PS);

				_ -> skip
			end,

			?BIN_PRED(Feedback#btl_feedback.mon_no =:= ?INVALID_NO, skip,
				lib_event:event(?BATTLE_WIN, [Feedback#btl_feedback.mon_no], PS)),
			?BIN_PRED(Feedback#btl_feedback.bmon_group_no =:= ?INVALID_NO, skip,
				lib_event:event(?BATTLE_WIN_GROUP, [Feedback#btl_feedback.bmon_group_no], PS)),
			?BIN_PRED(Feedback#btl_feedback.mon_no =:= ?INVALID_NO, skip,
				lib_event:event(?RAND_BATTLE_WIN, [Feedback#btl_feedback.mon_no], PS)),
			?BIN_PRED(Feedback#btl_feedback.bmon_group_no =:= ?INVALID_NO, skip,
				lib_event:event(?RAND_BATTLE_WIN_GROUP, [Feedback#btl_feedback.bmon_group_no], PS)),
			?BIN_PRED(Feedback#btl_feedback.mon_no =:= ?INVALID_NO, skip,
				mod_achievement:notify_achi(kill_mon, [{no, Feedback#btl_feedback.mon_no}], PS)),

			mod_team:try_del_mon(PS,Feedback#btl_feedback.mon_id );
		lose ->
			?BIN_PRED(Feedback#btl_feedback.mon_no =:= ?INVALID_NO, skip,
				lib_event:event(?BATTLE_FAIL, [Feedback#btl_feedback.mon_no], PS)),
			?BIN_PRED(Feedback#btl_feedback.bmon_group_no =:= ?INVALID_NO, skip,
				lib_event:event(?BATTLE_FAIL_GROUP, [Feedback#btl_feedback.bmon_group_no], PS)),
			%战斗失败过通知成就
			?BIN_PRED(Feedback#btl_feedback.mon_no =:= ?INVALID_NO, skip,
				mod_achievement:notify_achi(battle_lose, [], PS));
		_ ->
			skip
	end,

	?BIN_PRED(Result =/= win, lib_hardtower:notify_tower_battle_lost(PS), skip),


	% 重置计步器
	ply_scene:reset_step_counter(PlayerId),

	% LeftHp = max(Feedback#btl_feedback.left_hp, 1),  % 至少保留1点血
	LeftHp = Feedback#btl_feedback.left_hp,
	LeftMp = Feedback#btl_feedback.left_mp,
	?TRACE("battle feedback, LeftHp=~p, LeftMp=~p~n", [LeftHp, LeftMp]),

	{NewHp, NewMp} = adjust_hp_mp_after_battle(PS, LeftHp, LeftMp),

	player:set_hp_mp(PS, NewHp, NewMp),


	case lib_bt_comm:is_mf_battle(Feedback) andalso (Result == win) of
		true ->
			case lib_cross:check_is_mirror() of
				?true ->
					sm_cross_server:rpc_cast(player:get_server_id(PS), lib_cross, player_apply_call, [PlayerId, ?MODULE, handle_mf_drop_local, [PlayerId, Feedback]]);
				?false ->
					GoodsList = handle_mf_drop(PS, Feedback),  % 处理掉落
					notify_cli_battle_feedback(PS, Result =:= win, Feedback#btl_feedback.mon_id, Feedback#btl_feedback.mon_left_can_be_killed_times, GoodsList)
			end;
		false ->
			notify_cli_battle_feedback(PS, Result =:= win, Feedback#btl_feedback.mon_id, Feedback#btl_feedback.mon_left_can_be_killed_times, [])
	end,

	ply_partner:battle_feedback(Feedback),
	ply_hire:battle_feedback(Feedback),
	ply_guild:battle_feedback(PS, Feedback),
	mod_dungeon:feekback_boss_dungeon(PS, Feedback#btl_feedback.world_boss_mf_info),

	% % 处理爬塔越级传送
	% maybe_teleport_next_tower_battle(PS, Feedback),
	% 处理死亡传送
	case lists:member(Feedback#btl_feedback.mon_no, [35166, 35169,35167,35168,35172,35170,35171]) of
		true -> skip; % 帮派新副本不传送
		false ->maybe_teleport_after_battle(PS, Feedback)
	end,


	void.

handle_PVP_battle_feedback(PlayerId, Feedback) ->
	PS = player:get_PS(PlayerId),

	% 是否是切磋战斗
	case lib_bt_comm:is_qiecuo_pk_battle(Feedback) orelse lib_bt_comm:is_1v1_online_arena_battle(Feedback) orelse lib_bt_comm:is_3v3_online_arena_battle(Feedback)
			 orelse lib_bt_comm:is_cross_3v3_battle_robot(Feedback) orelse lib_bt_comm:is_cross_3v3_battle(Feedback) of
		true ->
			?DEBUG_MSG("handle_PVP_battle_feedback(), it is qiecuo~n",[]),
			skip;
		false ->
			?DEBUG_MSG("handle_PVP_battle_feedback(), it is not qiecuo~n",[]),
			% 是否是离线竞技场战斗
		    case lib_bt_comm:is_offline_arena_battle(Feedback) of
		    	true ->
                    mod_achievement:notify_achi(offline_arena, [{num, 1}], PS),
		    		[OA_OppoPlayerId] = Feedback#btl_feedback.oppo_player_id_list,
		    		case OA_OppoPlayerId =/= ?INVALID_ID of
		    			true ->
		    				lib_event:event(offline_arena_battle, [], PS),
		    				mod_offline_arena:battle_feekback(PlayerId, OA_OppoPlayerId, Feedback#btl_feedback.result);
		    			false ->
		    				skip
		    		end;
		    	false ->
		    		skip
		    end,

		    % 尝试处理
			maybe_teleport_after_battle(PS, Feedback),

			% 强制PK战斗BUFF
			maybe_add_pk_protect_buff(PS, Feedback),

			{Scene1,_,_} =  ?GUILD_ENTER1_CONFIG,
		    {Scene2,_,_} =  ?GUILD_ENTER2_CONFIG,
		    {Scene3,_,_} =  ?GUILD_ENTER3_CONFIG,
			% 判断是否在帮战场景
			case lists:member(player:get_scene_id(PS) ,[Scene1,Scene2,Scene3]) of
                true ->
                    skip;
                false ->
                    maybe_kill_trigger(PS,Feedback)	
            end,

			% 战斗通知
			maybe_send_player_tips(PS, Feedback)
	end,
	void.



%% 这里扩展一下战斗回调，允许透传参数的情况, 透传参数跟在后面2020/01/02 zjy
battle_callback(PlayerId, #btl_feedback{callback=F}=Feedback) when is_function(F, 2) ->
	F(PlayerId, Feedback);
battle_callback(PlayerId, #btl_feedback{callback = {Fun, A}} = Feedback) when is_function(Fun) ->
	Args = [PlayerId, Feedback|A],
	erlang:apply(Fun, Args);
battle_callback(_PlayerId, _Feedback) ->
	skip.


%% 被杀
maybe_kill_trigger1(PS,Feedback) ->
	Result = Feedback#btl_feedback.result,
	IsForcePk = lib_bt_comm:is_force_pk_battle(Feedback),
	IsStartBattler = lib_bt_comm:is_start_battle_side(Feedback),
	?DEBUG_MSG("Result=~p,IsForcePk=~p,IsStartBattleEr=~p",[Result,IsForcePk,IsStartBattler]),
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
			ply_relation:add_friend(PS,Pid,?ENEMY),
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

		player:cost_exp(PS, util:ceil(player:get_exp(PS) * Coef), [?LOG_FORCE_PK, "be killed"])
	?End,
	void.


%% 主动杀人
maybe_kill_trigger2(PS,Feedback) ->
	Result = Feedback#btl_feedback.result,
	IsForcePk = lib_bt_comm:is_force_pk_battle(Feedback),
	IsStartBattler = lib_bt_comm:is_start_battle_side(Feedback),
	?DEBUG_MSG("Result=~p,IsForcePk=~p,IsStartBattleEr=~p",[Result,IsForcePk,IsStartBattler]),
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
		player:set_popular(PS,player:get_popular(PS) + KillCount*?KILL_ONE_SUB_POPULAR),
		?DEBUG_MSG("get_popular=~p",[player:get_popular(PS)])
	?End,

	case player:get_popular(PS) >= ?PRISON_POPULAR of
		true -> ply_scene:teleport_after_die(PS); %进入小黑屋
		false -> void
	end,
	
	void.

% 杀人触发
maybe_kill_trigger(PS,Feedback) ->
	% ?DEBUG_MSG("Result=~p,IsForcePk=~p,IsStartBattleEr=~p",[Result,IsForcePk,IsStartBattler]),
	PlayerId = player:id(PS),
	maybe_kill_trigger1(PS,Feedback),
	PS2 = player:get_PS(PlayerId),
	maybe_kill_trigger2(PS2,Feedback),
	void.

% % 处理进入爬塔下一层 可能跳层
% maybe_teleport_next_tower_battle(PS, Feedback) ->
% 	Result = Feedback#btl_feedback.result,

% 	Rounds = Feedback#btl_feedback.lasting_rounds ,   % 战斗持续的回合数
%     Time = Feedback#btl_feedback.lasting_time ,     % 战斗持续的时间（单位：秒）
%     GroupNo = Feedback#btl_feedback.bmon_group_no,    % 所打的战斗怪物组编号，如果不是打怪，则为INVALID_NO

%     case Result of
%     	win ->
%     		if 
%     			% 判断是否是爬塔怪物组
%     			GroupNo >= 4395 orelse  GroupNo =< 4720 -> 
%     				% 这里判断回合数以及时间进行创建跳层的入口
%     				skip;
%     			true -> skip
%     		end;

%     	_ ->
%     		skip
%     end.



% 处理玩家死亡传送问题
maybe_teleport_after_battle(PS, Feedback) ->
	Result = Feedback#btl_feedback.result,
	LeftHp = Feedback#btl_feedback.left_hp,
	?Ifc ( Result == lose andalso LeftHp == 0 andalso (lib_bt_comm:is_normal_mf_battle(Feedback) orelse lib_bt_comm:is_force_pk_battle(Feedback)) )
		% 如果玩家在副本中则不处理
		case player:is_in_dungeon(PS) of
			{true, _DunPid} -> skip;
			false ->
				case lib_bt_comm:is_normal_mf_battle(Feedback) of
					true ->

						MonList = Feedback#btl_feedback.spawned_bmon_list,
						MonIdx = util:rand(1,length(MonList)),
						{MonNo,_} = lists:nth(MonIdx,MonList),

						case util:rand(1,50) of
							1 ->

								% 广播公告通知帮派被杀
								ply_tips:send_sys_tips(PS, {guild_player_be_mf_kill, [
									player:get_name(PS)
						            ,player:id(PS)
						            ,MonNo
									]});
							_ ->
								skip
						end;

					false ->
						skip
				end,

				SceneType = mod_scene_tpl:get_scene_type(player:get_scene_no(PS)),
				if
					% 如果玩家在帮战地图则不处理
					SceneType =:= ?SCENE_T_GUILD ->
						skip;
					true ->
						% 处理角色死亡传送点
						ply_scene:teleport_after_die(PS)
				end
		end
	?End.

maybe_add_pk_protect_buff(PS, Feedback) ->
	Result = Feedback#btl_feedback.result,
	LeftHp = Feedback#btl_feedback.left_hp,
	?Ifc ( Result == lose andalso LeftHp == 0 andalso lib_bt_comm:is_force_pk_battle(Feedback) )
		lib_buff:player_add_buff(player:id(PS), ?BNO_PK_PROTECT)
	?End.

maybe_send_player_tips(PS, Feedback) ->
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
						ply_tips:send_sys_tips(PS, {pk_fail_team, [NameList]})
					?End;
				false ->
					[OppoPlayerId] = Feedback#btl_feedback.oppo_player_id_list,
					case player:get_PS(OppoPlayerId) of
						null ->
							skip;
						OppoPS ->
							?Ifc ( LeftHp =:= 0 )
								ply_tips:send_sys_tips(PS, {pk_fail, [player:get_name(OppoPS), OppoPlayerId]})
							?End,
							?Ifc ( Result =:= win )
								ply_tips:send_sys_tips(PS, {pk_success, [player:get_name(OppoPS), OppoPlayerId]})
							?End
					end
			end;
		false ->
			skip
	end.



notify_cli_battle_feedback(PS, WinState, MonId, MonLeftCanBeKilledTimes, GoodsList) ->
	?TRACE("mod_player:notify_cli_battle_feedback():MonId=~p, MonLeftCanBeKilledTimes=~p, GoodsList:=~p~n", [MonId, MonLeftCanBeKilledTimes, GoodsList]),
	case MonId =:= ?INVALID_ID of
		true -> skip;
		false ->
			State =
				case WinState of
					true -> 1;
					false -> 0
				end,
			{ok, BinData} = pt_13:write(?PT_PLYR_NOTIFY_BTL_FEEDBACK, [player:id(PS), State, MonId, MonLeftCanBeKilledTimes, GoodsList]),
			lib_send:send_to_sock(PS, BinData)
	end.


%% return {NewHp, NewMp}
adjust_hp_mp_after_battle(PS, LeftHp, LeftMp) ->
	NewHp =
		case LeftHp < player:get_hp_lim(PS) of
			false -> player:get_hp_lim(PS);
			true ->
				?DEBUG_MSG("adjust_hp_mp_after_battle ~p,~p,~p",[ player:get_lv(PS) =< 30, player:get_lv(PS) , 30]),
				case true of
					true ->
						player:get_hp_lim(PS);
					false ->

						NeedAddHp = player:get_hp_lim(PS) - LeftHp,
						case player:get_store_hp(PS) > NeedAddHp of
							true ->
								player:add_store_hp(PS, 0 - NeedAddHp),
								player:get_hp_lim(PS);
							false ->
								StoreHp = player:get_store_hp(PS),
								player:add_store_hp(PS, 0 - StoreHp),
								case ply_setting:is_auto_add_store_hp_mp(player:id(PS)) of
									false -> skip;
									true -> mod_inv:auto_use_goods_for_add_store_hp(PS)
								end,
								max(LeftHp + StoreHp, 1) % 至少保留1点血
						end
				end
		end,

	NewMp =
		case LeftMp < player:get_mp_lim(PS) of
			false -> player:get_mp_lim(PS);
			true ->
				case true of
					true ->
						player:get_mp_lim(PS);
					false ->
						NeedAddMp = player:get_mp_lim(PS) - LeftMp,
						case player:get_store_mp(PS) > NeedAddMp of
							true ->
								player:add_store_mp(PS, 0 - NeedAddMp),
								player:get_mp_lim(PS);
							false ->
								StoreMp = player:get_store_mp(PS),
								player:add_store_mp(PS, 0 - StoreMp),
								case ply_setting:is_auto_add_store_hp_mp(player:id(PS)) of
									false -> skip;
									true -> mod_inv:auto_use_goods_for_add_store_mp(PS)
								end,
								LeftMp + StoreMp
						end
				end
		end,
	{NewHp, NewMp}.


%% 升级（同步）
do_upgrade__(PS_Latest) ->
	CurExp = player:get_exp(PS_Latest),
	ExpLim = player:get_exp_lim(PS_Latest),
	NewLv = player:get_lv(PS_Latest) + 1,

	MaxLv = player:get_player_max_lv(PS_Latest),

	% 如果玩家等级大于最高等级则不要
	case NewLv =< MaxLv of
		false ->
			skip;
		true ->

			% ?DEBUG_MSG("do_upgrade__(), NewLv:~p, PlayerId:~p", [NewLv, player:id(PS_Latest)]),
		    LeftExp = max(CurExp - ExpLim, 0),   % 扣去相应经验后的剩余经验。 做max矫正是为了防止：万一出bug的话，玩家会得到一个数值很大的经验值
		    PS_Latest2 = player_syn:set_lv(PS_Latest, NewLv),
		    PS_Latest3 = player_syn:set_exp(PS_Latest2, LeftExp),

			% 处理天赋属性点
			PS_Latest4 = handle_talent_points_on_upgrade(PS_Latest3, NewLv),
			?ASSERT(is_record(PS_Latest4, player_status), PS_Latest4),

			% 通知客户端
			player:notify_cli_upgrade(PS_Latest, NewLv),
			ply_tips:send_sys_tips(PS_Latest, {lv_up, [NewLv]}),

			post_upgrade__(PS_Latest4),
			%%当经验满的时候自动升级
			player:add_exp(PS_Latest4, 0),
			
			%% 对于跨服的玩家，就目前的跨服设计，其镜像等级需要在这里手动同步过去跨服节点，有空再重新设计跨服，使用erlang进程分布式的特性来做
			case lib_cross:check_is_remote() of
				?false ->
					ok;
				?true ->
					PlayerId = player:get_id(PS_Latest4),
					sm_cross_server:rpc_cast(lib_cross, player_apply_call_with_PS, [PlayerId, ?MODULE, upgrade_cross, [NewLv]])
			end
	end.

gm_do_upgrade__(PS_Latest, NewLv) ->
	PS_Latest2 = player_syn:set_lv(PS_Latest, NewLv),
	PS_Latest3 = player_syn:set_exp(PS_Latest2, 0),

	% 处理天赋属性点
	PS_Latest4 = handle_talent_points_on_upgrade(PS_Latest3, NewLv),
	?ASSERT(is_record(PS_Latest4, player_status), PS_Latest4),

	% 通知客户端
	player:notify_cli_upgrade(PS_Latest, NewLv),
	ply_tips:send_sys_tips(PS_Latest, {lv_up, [NewLv]}),

	post_upgrade__(PS_Latest4),
	%%当经验满的时候自动升级
	player:add_exp(PS_Latest4, 0),

	%% 对于跨服的玩家，就目前的跨服设计，其镜像等级需要在这里手动同步过去跨服节点，有空再重新设计跨服，使用erlang进程分布式的特性来做
	case lib_cross:check_is_remote() of
		?false ->
			ok;
		?true ->
			PlayerId = player:get_id(PS_Latest4),
			sm_cross_server:rpc_cast(lib_cross, player_apply_call_with_PS, [PlayerId, ?MODULE, upgrade_cross, [NewLv]])
	end.


upgrade_cross(PS, NewLv) ->
	PS_Latest2 = player_syn:set_lv(PS, NewLv),
	% 通知客户端
	player:notify_cli_upgrade(PS_Latest2, NewLv),
	ply_tips:send_sys_tips(PS_Latest2, {lv_up, [NewLv]}),
	mod_team:on_player_upgrade(PS_Latest2),
%% 	post_upgrade__(PS_Latest2),
	ok.


%% 首充转生
start_peak_upgrade(PS) ->
	%% 系统300级满级
	case player:get_lv(PS) =:= 300 of
		false -> skip;
		true ->
			NewLv = 1,
			PS1 = player_syn:set_peak_lv(PS, NewLv),

			% 处理天赋属性点
			PS2 = handle_talent_points_on_peak_upgrade(PS1, NewLv),
			?ASSERT(is_record(PS2, player_status), PS2),

			% 通知客户端
			player:notify_cli_peak_upgrade(PS, NewLv),
			ply_tips:send_sys_tips(PS, {peak_lv_up, [player:get_name(PS)]}),
			post_peak_upgrade__(PS2),
			%%当经验满的时候自动升级
			player:add_exp(PS2, 0)
	end.

%% 巅峰等级升级（同步）
do_peak_upgrade__(PS_Latest) ->
	CurExp = player:get_exp(PS_Latest),
	ExpLim = player:get_peak_exp_lim(PS_Latest),
	NewLv = player:get_peak_lv(PS_Latest) + 1,

	MaxLv = player:get_player_peak_max_lv(),

	% 如果玩家等级大于最高等级则不要
	case NewLv =< MaxLv of
		false ->
			skip;
		true ->

			% ?DEBUG_MSG("do_upgrade__(), NewLv:~p, PlayerId:~p", [NewLv, player:id(PS_Latest)]),
			LeftExp = max(CurExp - ExpLim, 0),   % 扣去相应经验后的剩余经验。 做max矫正是为了防止：万一出bug的话，玩家会得到一个数值很大的经验值
			PS_Latest2 = player_syn:set_peak_lv(PS_Latest, NewLv),
			PS_Latest3 = player_syn:set_exp(PS_Latest2, LeftExp),

			% 处理天赋属性点
			PS_Latest4 = handle_talent_points_on_peak_upgrade(PS_Latest3, NewLv),
			?ASSERT(is_record(PS_Latest4, player_status), PS_Latest4),

			% 通知客户端
			player:notify_cli_peak_upgrade(PS_Latest, NewLv),
%%            ply_tips:send_sys_tips(PS_Latest, {peak_lv_up, [NewLv]}),

			post_peak_upgrade__(PS_Latest4),
			%%当经验满的时候自动升级
			player:add_exp(PS_Latest4, 0)
	end.

%% 转生（同步）
% do_rein(PS,ReinLv,Faction,Race,Sex) ->

	% ply_faction:transform_faction_by_rein(PS,Faction)

check_exchange_jingmai_point__(PS, Count) ->
	JingmaiPoint = player:get_jingmai_point(PS),

	case data_jingmai_exchange:get(JingmaiPoint+1) of
    	Config when is_record(Config,jingmai_exchange_config) ->
			F = fun(X, Y) ->
					{Num, CostList} = Y,
					case data_jingmai_exchange:get(JingmaiPoint+X) of
						Data when is_record(Data, jingmai_exchange_config) ->
							Cost = Data#jingmai_exchange_config.cost,
							NewCost = Cost ++ CostList,
							case mod_inv:check_batch_destroy_goods(PS, NewCost) of
								{fail, Reason} ->
									throw(Reason);
								ok ->
									{X, NewCost}
							end;
						null ->
							{Num, CostList}
					end
				end,
			lists:foldl(F, {1, []}, lists:seq(1, Count));
    	null ->
    		% 已经满级
    		throw(?PM_JINGMAI_POINT_MAX_LIMIT)
    end.
check_exchange_jingmai_point(PS, Count) ->
    try check_exchange_jingmai_point__(PS, Count) of
		{Num, CostList} ->
			{Num, CostList}
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

% 兑换
exchange_jingmai_point(PS, Count) ->
	case check_exchange_jingmai_point(PS, Count) of
        {fail, Reason} ->
            {fail, Reason};
		{Num, CostList} ->
            do_exchange_jingmai_point(PS, {Num, CostList})
    end.
% ------------------------------
% ------------------------------
check_soaring__(PS) ->
	Soaring = player:get_soaring(PS),

	NextSoaring = Soaring + 1,

	case data_soaring_config:get(NextSoaring) of
    	Config when is_record(Config,soaring_config) ->
    		case Config#soaring_config.need_lv =< player:get_lv(PS) of
    			true ->
		    		case mod_inv:check_batch_destroy_goods(PS, Config#soaring_config.goods) of
				        {fail, Reason} ->
				            throw(Reason);
				        ok ->
				           ok
				    end;
				false ->
					throw(?PM_LV_LIMIT)
			end;
    	null ->
    		% 已经满级
    		throw(?PM_JINGMAI_POINT_MAX_LIMIT)
    end,

    ok.

check_soaring(PS) ->
    try check_soaring__(PS) of
        ok ->
            ok
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.


% 飞升
up_soaring(PS) ->
	case check_soaring(PS) of
        {fail, Reason} ->
            {fail, Reason};
        ok ->
            do_soaring(PS)
    end.

%% 飞升
do_soaring(PS) ->
	Soaring = player:get_soaring(PS),

	NextSoaring = Soaring + 1,

	case data_soaring_config:get(NextSoaring) of
    	Config when is_record(Config,soaring_config) ->
    		% 消耗道具
    		mod_inv:destroy_goods_WNC(player:id(PS), Config#soaring_config.goods, [?LOG_ROLE, "soaring"]),

    		player:set_soaring(PS,NextSoaring),
			mod_achievement:notify_achi(feisheng, [{num, NextSoaring}], PS),
			player:db_save_soaring(player:id(PS),NextSoaring),
			0;
    	null ->
    		1
    end.

%  变身
check_transfiguration__(PS,No) ->
	case data_transfiguration:get(No) of
		null -> throw(?PM_DATA_CONFIG_ERROR);
		Data when is_record(Data,transfiguration_config) ->
			ok;
		_ -> throw(?PM_DATA_CONFIG_ERROR)
	end.

check_transfiguration(PS,No) ->
	try check_transfiguration__(PS,No) of
        ok ->
            ok
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.

transfiguration(PS,No) ->
	case check_transfiguration(PS,No) of
        {fail, Reason} ->
            {fail, Reason};
        ok ->
            do_transfiguration(PS,No)
    end.

do_transfiguration(PS,No) ->
	% ply_attr:recount_all_attrs(imme, PS),
	PS2 = player_syn:set_transfiguration_no(PS,No),
	lib_scene:notify_int_info_change_to_aoi(player, player:get_id(PS), [{?OI_TRANSFIGURATION_NO, No}]),

	PS3 = ply_attr:recount_all_attrs(imme,PS2), 
	player_syn:update_PS_to_ets(PS3),

	{ok, BinData} = pt_13:write(?PT_PLYR_TRANSFIGURATION, No),
	lib_send:send_to_sid(PS3, BinData),		    		
	
	No.


% ------------------------------
check_wash_jingmai_point__(PS) ->
	JingmaiPoint = player:get_jingmai_point(PS),

	case data_jingmai_exchange:get(JingmaiPoint) of
    	Config when is_record(Config,jingmai_exchange_config) ->
			[{MoneyType, CostNum}] = Config#jingmai_exchange_config.wash_price,
    		RetMoney = player:check_need_price(PS, MoneyType, CostNum),
    		
    		% 金钱不足
    		?Ifc (RetMoney =/= ok)
			    throw(RetMoney)
			?End,

			void;
    	null ->
    		% 已经满级
    		throw(?PM_JINGMAI_POINT_MAX_LIMIT)
    end,

    ok.

check_wash_jingmai_point(PS) ->
    try check_wash_jingmai_point__(PS) of
        ok ->
            ok
    catch
        throw: FailReason ->
            {fail, FailReason}
    end.


% 洗点
wash_jingmai_point(PS) ->
	case check_wash_jingmai_point(PS) of
        {fail, Reason} ->
            {fail, Reason};
        ok ->
            do_wash_jingmai_point(PS)
    end.


%% 兑换分配点
do_exchange_jingmai_point(PS, {Num, CostList}) ->
	% JingmaiInfos = player:get_jingmai_infos(PS),
    JingmaiPoint = player:get_jingmai_point(PS),

    Ret = case data_jingmai_exchange:get(JingmaiPoint+Num) of
    	Config when is_record(Config,jingmai_exchange_config) ->
%%			Cost = Config#jingmai_exchange_config.cost,
    		% 删除道具
    		mod_inv:destroy_goods_WNC(player:get_id(PS), CostList, [?LOG_JINGMAI, "exchange"]),

    		% 进行点数增加
    		player:set_jingmai_point(PS,JingmaiPoint + Num,now),
    		0;
    	null ->
    		1
    end,

    PS2 = player:get_PS(player:id(PS)),
    player:db_save_jingmai(PS2),

    % 重新计算属性
    ply_attr:recount_base_and_total_attrs(PS2), 

    Ret.

%% 重置分配点
do_wash_jingmai_point(PS) ->
	% JingmaiInfos = player:get_jingmai_infos(PS),
    JingmaiPoint = player:get_jingmai_point(PS),

    % 扣除货币
    Ret = case data_jingmai_exchange:get(JingmaiPoint) of
    	Config when is_record(Config,jingmai_exchange_config) ->
    		% 判断是否有足够的道具
			[{MoneyType, CostNum}] = Config#jingmai_exchange_config.wash_price,
    		player_syn:cost_money(PS, MoneyType, CostNum, [?LOG_JINGMAI, "wash"]),

    		% 进行重置
    		player:set_jingmai_infos(PS,[{1,0},{2,0},{3,0},{4,0},{5,0},{6,0},{7,0}],now),
    		0;
    		% player:set_jingmai_point(JingmaiPoint);
    	null ->
    		1
    end,

    PS2 = player:get_PS(player:id(PS)),
    player:db_save_jingmai(PS2),

    % 重新计算属性
    ply_attr:recount_base_and_total_attrs(PS2), 

    Ret.

%% 分配点经脉
do_set_jingmai_point(PS, Dists) ->
	JingmaiInfos = player:get_jingmai_infos(PS),
    JingmaiPoint = player:get_jingmai_point(PS),

    F = fun({No,Lv},Acc) ->
        Lv + Acc
    end,

    % 使用的点数
    UsePoint = lists:foldl(F,0,JingmaiInfos),
    % 预增加点数
    AddPointPlan = lists:foldl(F,0,Dists),

    % 
    [{1,OPoint1},{2,OPoint2},{3,OPoint3},{4,OPoint4},{5,OPoint5},{6,OPoint6},{7,OPoint7}] = 
    case JingmaiInfos of 
    	[] ->
    		[{1,0},{2,0},{3,0},{4,0},{5,0},{6,0},{7,0}];
    	_ -> JingmaiInfos
    end,

    [{1,Point1},{2,Point2},{3,Point3},{4,Point4},{5,Point5},{6,Point6},{7,Point7}] = Dists,

    HisPoint = ((UsePoint + AddPointPlan) =< JingmaiPoint),
    Ret = 
    case HisPoint of
    	true ->
    		player:set_jingmai_infos(PS,[{1,OPoint1+Point1},{2,OPoint2+Point2},{3,OPoint3+Point3},{4,OPoint4+Point4},{5,OPoint5+Point5},{6,OPoint6+Point6},{7,OPoint7+Point7}],now),
    		0;
    	false ->
    		% 点数不足
    		1
    end,

    PS2 = player:get_PS(player:id(PS)),
    player:db_save_jingmai(PS2),

    % 重新计算属性
    ply_attr:recount_base_and_total_attrs(PS2), 

    Ret.



%% 升级时处理天赋属性点，返回更新后的PS
handle_talent_points_on_upgrade(PS, NewLv) ->
	% 每提升一级各个天赋点都增加一点（体质和耐力除外，是0.5），
	% 另外有额外5点给玩家自己任意加（10级前则自动帮玩家加）
	AddPoint_Con = 1,
	AddPoint_Stam = 1,
	AddPoint_Str = 1,
	AddPoint_Spi = 1,
	AddPoint_Agi = 1,

	NewPS = case NewLv < ?MANUAL_ALLOT_FREE_TALENT_POINTS_START_LV of
				true ->
					case data_faction:get(player:get_faction(PS)) of
						#faction_base{recommand_point = [AddCon,AddSpi,AddStr,AddStam,AddAgi]} ->
							%% [AddCon,AddSpi,AddStr,AddStam,AddAgi] =    (data_faction:get(player:get_faction(PS)))#faction_base.recommand_point,
							PS2 = player_syn:add_base_str(PS, AddPoint_Str + AddStr),
							PS3 = player_syn:add_base_con(PS2, AddPoint_Con + AddCon),
							PS4 = player_syn:add_base_stam(PS3, AddPoint_Stam + AddStam),
							PS5 = player_syn:add_base_spi(PS4, AddPoint_Spi + AddSpi),	
							player_syn:add_base_agi(PS5, AddPoint_Agi + AddAgi);
						_ ->
							PS
					end;

				false ->
					PS2 = player_syn:add_base_str(PS, AddPoint_Str),
					PS3 = player_syn:add_base_con(PS2, AddPoint_Con),
					PS4 = player_syn:add_base_stam(PS3, AddPoint_Stam),
					PS5 = player_syn:add_base_spi(PS4, AddPoint_Spi),
					PS6 = player_syn:add_base_agi(PS5, AddPoint_Agi),
					player_syn:add_free_talent_points(PS6, 5)
			end,

	NewPS.


%% 巅峰等级升级时处理天赋属性点，返回更新后的PS
handle_talent_points_on_peak_upgrade(PS, NewLv) ->
	% 有额外5点给玩家自己任意加
	NewPS = case (NewLv =/= 0) andalso (player:get_player_peak_max_lv() >= NewLv) of
				true ->
					player_syn:add_free_talent_points(PS, 5);
				false ->
					PS
			end,
	NewPS.



%% 升级后的后续处理
post_upgrade__(PS_Latest) ->
	
	% 保存相关信息到DB
	player:db_save_for_upgrade(PS_Latest),
	
    % 检测和处理系统开放
    ply_sys_open:check_and_handle_sys_open(PS_Latest),

	% 重算基础属性，然后再重算总属性
	ply_attr:recount_base_and_total_attrs(imme, PS_Latest),

	?ASSERT(self() =:= player:get_pid(PS_Latest)),
	% 升级后设为满血
	gen_server:cast( self(), 'set_full_hp_mp'),

	gen_server:cast( self(), 'notify_info_details_to_client'),

    % 通知进入离线竞技场
    gen_server:cast(self(), 'notify_enter_offline_arena'),

    % 通知爬塔
    gen_server:cast(self(), 'notify_enter_tower'),

    % 通知噩梦爬塔
    gen_server:cast(self(), 'notify_enter_hardtower'),

	% 通知任务系统
	gen_server:cast( self(), 'send_trigger_msg'),

	% 通知组队系统
	mod_team:on_player_upgrade(PS_Latest),
	

    % 通知成就系统
    mod_achievement:notify_achi(lv, [{num, player:get_lv(PS_Latest)}], PS_Latest),

    % 通知答题
    lib_activity:upgrade_notify_answer(PS_Latest),

    % 通知活动系统
    mod_activity:upgrade_notify_activity(PS_Latest),

    % 通知运镖系统
    lib_transport:open_transport_system(PS_Latest),

	% 升级解锁门派技能
	ply_faction:levelup_unlock_faction_skill(PS_Latest),


    ?DEBUG_MSG("---------- notify_lilian Accepted----------~p~n", [(lib_task:get_unrepeat_completed(0))#completed_unrepeat.id]),
    mod_chapter_target:notify_lilian(PS_Latest, (lib_task:get_unrepeat_completed(0))#completed_unrepeat.id, lv),


    ply_sprd:on_player_upgrade(PS_Latest, player:get_lv(PS_Latest)),

    ply_relation:notify_frds_lv_up(PS_Latest).

	% TODO: 按需补充其他处理
	% ...


%% 巅峰等级升级后的后续处理
post_peak_upgrade__(PS_Latest) ->

	% 保存相关信息到DB
	player:db_save_for_peak_upgrade(PS_Latest),

	% 检测和处理系统开放
	ply_sys_open:check_and_handle_sys_open(PS_Latest),

	% 重算基础属性，然后再重算总属性
	ply_attr:recount_base_and_total_attrs(imme, PS_Latest),

	?ASSERT(self() =:= player:get_pid(PS_Latest)),
	% 升级后设为满血
	gen_server:cast( self(), 'set_full_hp_mp'),

	gen_server:cast( self(), 'notify_info_details_to_client'),

	% 通知进入离线竞技场
	gen_server:cast(self(), 'notify_enter_offline_arena'),

	% 通知爬塔
	gen_server:cast(self(), 'notify_enter_tower'),

	% 通知噩梦爬塔
	gen_server:cast(self(), 'notify_enter_hardtower'),

	% 通知任务系统
	gen_server:cast( self(), 'send_trigger_msg'),

	% 通知组队系统
	mod_team:on_player_upgrade(PS_Latest).




handle_mf_drop_local(PlayerId, BtlFeedback) ->
	PS = player:get_PS(PlayerId),
	GoodsList = handle_mf_drop(PS, BtlFeedback),
	notify_cli_battle_feedback(PS, BtlFeedback#btl_feedback.result =:= win, BtlFeedback#btl_feedback.mon_id, BtlFeedback#btl_feedback.mon_left_can_be_killed_times, GoodsList).





%% 处理怪物掉落，函数暂时放在这里，这里需要考虑跨服的情况，把东西给回本服玩家
%% return GoodsList 格式 [{GoodsId, GoodsNo, GoodsCount}]
handle_mf_drop(PS, BtlFeedback) ->
	ShuffledTeamMbList = BtlFeedback#btl_feedback.shuffled_team_mb_list,
	PlayerId = player:id(PS),

	% ?DEBUG_MSG("handle_mf_drop(), PlayerId=~p~n", [PlayerId]),
	F0 = fun({PartnerId, _Hp, _Mp}, AccList) ->
			[PartnerId | AccList]
		end,
	ParIdList = lists:foldl(F0, [], BtlFeedback#btl_feedback.partner_info_list),

	%% 处理玩家获得的掉落 （这里只给物品）
	F1 = fun(BMonNo, Drop) ->
			lib_drop:give_drop_to_player(Drop, PS, BMonNo, ShuffledTeamMbList, [?LOG_BATTLE, BtlFeedback#btl_feedback.bmon_group_no])
		end,

	F2 = fun({BMonNo, Count}, Drop) ->
			L = lists:duplicate(Count, BMonNo),
			?TRACE("handle_mf_drop(), PlayerId=~p, BMonNoList=~p~n", [PlayerId, L]),
			lists:foldl(F1, Drop, L)
		end,
	SpawnBMonList = BtlFeedback#btl_feedback.spawned_bmon_list,
	DropDtl = lists:foldl(F2, #drop_dtl{}, SpawnBMonList),

	%% 给玩家加经验 和 钱 
    Fply = fun(VGoodsNo) ->
        case lists:keyfind(VGoodsNo, 2, DropDtl#drop_dtl.goods_list) of
            false -> skip;
            {_, _, GoodsCount} when GoodsCount > 0 -> 
                if
                    VGoodsNo =:= ?VGOODS_EXP ->
                        player:add_exp(PS, GoodsCount, [?LOG_BATTLE, BtlFeedback#btl_feedback.bmon_group_no]);
                    true ->
                        MoneyType =
                            case VGoodsNo of
                                ?VGOODS_GAMEMONEY -> ?MNY_T_GAMEMONEY;
                                ?VGOODS_COPPER -> ?MNY_T_COPPER;
                                ?VGOODS_YB -> ?MNY_T_YUANBAO;
                                ?VGOODS_CHIVALROUS -> ?MNY_T_CHIVALROUS;
                                ?VGOODS_BIND_GAMEMONEY -> ?MNY_T_BIND_GAMEMONEY;
                                ?VGOODS_BIND_YB   -> ?MNY_T_BIND_YUANBAO;
								?VGOODS_INTEGRAL  -> ?MNY_T_INTEGRAL;
								?VGOODS_QUJING    -> ?MNY_T_QUJING
                            end,
                        player:add_money(PS, MoneyType, GoodsCount, [?LOG_BATTLE, BtlFeedback#btl_feedback.bmon_group_no])
                end;
            _ -> skip
        end
    end,
    [Fply(X) || X <- [?VGOODS_CHIVALROUS, ?VGOODS_EXP, ?VGOODS_GAMEMONEY, ?VGOODS_YB, ?VGOODS_BIND_GAMEMONEY, ?VGOODS_BIND_YB ,?VGOODS_COPPER,?VGOODS_QUJING]],

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

	BagFull1 = mod_inv:is_bag_eq_full(PlayerId),
	BagFull2 = mod_inv:is_bag_usable_full(PlayerId),
	BagFull3 = mod_inv:is_bag_unusable_full(PlayerId),
	?Ifc (BagFull1 orelse BagFull2 orelse BagFull3)
		if
			BagFull1 -> lib_send:send_prompt_msg(PS, ?PM_EQ_BAG_FULL_PLZ_ARRANGE_TIMELY);
			BagFull2 -> lib_send:send_prompt_msg(PS, ?PM_US_BAG_FULL_PLZ_ARRANGE_TIMELY);
			true -> lib_send:send_prompt_msg(PS, ?PM_UNUS_BAG_FULL_PLZ_ARRANGE_TIMELY)
		end
    ?End,

    [{?INVALID_ID, ?VGOODS_PAR_EXP, TotalParExp} | DropDtl#drop_dtl.goods_list].




%% 这里判断聊天的状态，目前好友私聊的协议是在好友模块，需要同样的判定，将判断函数抽出来
chat(Cmd, Status, Bin) ->
	%%?TRACE("**** chat -> ban_time is ~p~n", [Status#player_status.end_ban_time]),

	% todo：临时屏蔽禁言的检查
	% ChatBannedEndTime = player:get_chat_banned_end_time(Status),
	% if
	%    ChatBannedEndTime == 0 ->
	% 	   ?TRACE("****CAN SPEAK\n"),
	% 	   pp_chat:handle(Cmd, Status, Bin);
	%    ChatBannedEndTime > 0 ->
	% 	   ?TRACE("****CAN NOT SPEAK\n"),
	% 	   lib_chat:notify_cli_chat_banned( player:id(Status), 1);  %%todo:大于0则客户端显示禁言
	% 	true ->
	% 		 ?ASSERT(false),
	% 		 error
	% end.
	case lists:member(Cmd, ?EXCEPTION_CHAT_PROTOL) of
		true ->
			pp_chat:handle(Cmd, Status, Bin);
		false ->
			case check_chat_state(Status) of
				{ok, chat} ->
					pp_chat:handle(Cmd, Status, Bin);
				_ ->
					skip
			end
	end.
	
%@return boolean
check_chat_state(Status) ->
	case get(?BAN_CHAT) of
		undefined ->
			check_chat_state2(Status);
		{?FORVER_BAN_TIME, Reason} ->
			lib_chat:ban_chat(0, Reason, Status);
		{?CANCEL_BAN_TIME, _} ->
			erase(?BAN_CHAT),
			check_chat_state2(Status);
		{Time, Reason} ->
			Now = util:unixtime(),
			case Now >= Time of
				true ->
					erase(?BAN_CHAT),
					check_chat_state2(Status);
				false ->
					lib_chat:ban_chat(Time - Now, Reason, Status)
			end
	end.


check_chat_state2(Status) ->
	case get(?BAN_PHONE) of
		1 ->%% 绑定了被禁言的手机号
			Reason = "账号禁言，请联系客服",
			lib_chat:ban_chat(0, Reason, Status);
		_ ->
			{ok, chat}
	end.


%% 废弃！
% %% 处理作业计划的反馈: 重连超时
% handle_job_sche_feedback(?JSET_RECONNECT_TIMEOUT, JobSch) ->
% 	PlayerId = JobSch#job_sche.player_id,
% 	PS = mod_svr_mgr:get_tmplogout_player_status(PlayerId),
% 	?ASSERT(PS /= null, PlayerId),
% 	?ASSERT(player:get_pid(PS) =:= self()),

% 	% 如果当前正在重连进入游戏，则不做处理，否则，最终退出游戏
% 	case player:get_cur_bhv_state(PS) of
% 		?BHV_RECONNECT_ENTERING_GAME ->
% 			skip;
% 		_ ->
% 			% 标记为当前正在最终退出游戏中，原因参见针对'check_if_role_in_cache_for_reconnect'消息的处理
% 			PS2 = PS#player_status{cur_bhv_state = ?BHV_FINAL_LOGOUTING},
% 			mod_svr_mgr:update_tmplogout_player_status_to_ets(PS2),

% 			% 最终退出
% 			mod_login:final_logout( player:get_pid(PS))
% 	end;


%% 处理作业计划的反馈: 取消buff
handle_job_sche_feedback(?JSET_CANCEL_BUFF, JobSch) ->
	PlayerId = JobSch#job_sche.player_id,
	PartnerId = JobSch#job_sche.extra#js_extra.partner_id,
	BuffNo = JobSch#job_sche.extra#js_extra.buff_no,
	case PartnerId of
		0 -> lib_buff:sys_del_player_buff(PlayerId, BuffNo);
		_ -> lib_buff:partner_del_buff(PlayerId, PartnerId, BuffNo)
	end;

%% 处理作业计划的反馈: 时效物品过期
handle_job_sche_feedback(?JSET_GOODS_EXPIRE, JobSch) ->
	PlayerId = JobSch#job_sche.player_id,
	GoodsId = JobSch#job_sche.extra#js_extra.goods_id,
	mod_inv:handle_goods_expired(PlayerId, GoodsId);

handle_job_sche_feedback(?JSET_BUY_BACK_GOODS_EXPIRE, JobSch) ->
	PlayerId = JobSch#job_sche.player_id,
	GoodsId = JobSch#job_sche.extra#js_extra.goods_id,
	ply_trade:handle_buy_back_goods_expired(PlayerId, GoodsId);

handle_job_sche_feedback(?JSET_UPDATE_PAR_MOOD, JobSch) ->
	PlayerId = JobSch#job_sche.player_id,
	case player:get_PS(PlayerId) of
		null -> skip;
		PS -> ply_partner:update_mood(PS)
	end;

handle_job_sche_feedback(mfa, #job_sche{extra={M, F, A}}) ->
	erlang:apply(M, F, A);

handle_job_sche_feedback(mfa, #job_sche{extra=Func}) when is_function(Func, 0) ->
	Func();


handle_job_sche_feedback(_EventType, _JobSche) ->
	?WARNING_MSG("Invalid job sche ~w", [_EventType]),
	?ASSERT(false, _JobSche),
	skip.




reward_player(PS, RewardPkgNo) ->
	lib_reward:give_reward_to_player(common, PS, RewardPkgNo, [], []).


reward_player(PS, RewardPkgNo, LogInfo) ->
	lib_reward:give_reward_to_player(common, PS, RewardPkgNo, [], LogInfo).

reward_player(PS, RewardPkgNo, LogInfo, RewardMulti) ->
	lib_reward:give_reward_to_player(common, PS, RewardPkgNo, [], LogInfo, RewardMulti).


check_total_order([]) ->
	?ERROR_MSG("[recharge_feedback] total recharge order = 0, total order = ~p", [null]),
	false;
check_total_order([Elm]) ->
	{true, Elm};
check_total_order([Elm | Left]) ->
	?ERROR_MSG("[recharge_feedback] total recharge order > 1, total order = ~p", [[Elm | Left]]),
	{true, Elm}.


handle_normal_recharge_order([], _, _) -> skip;
handle_normal_recharge_order([[Id, Amount, _] | Left], RoleId, Perfix) ->
	OrderId = Perfix ++ tool:to_list(Id),
	case db:select_row(recharge_order, "order_id", [{order_id, OrderId}]) of
		[] ->
			db:delete(recharge_feedback, [{order_id, Id}]);
			% 如果需要按照正常流程返还则使用下面这句
			% db:insert(recharge_order, [{order_id, OrderId}, {role_id, RoleId}, {amount, Amount}, {timestamp, util:unixtime()}, {state, ?RECHARGE_UN_DEAL}]);
		_ ->
			?ERROR_MSG("[recharge_feedback] order repeat id = ~p~n", [Id]),
			db:update(recharge_feedback, [{state, 1}], [{order_id, Id}])
	end,
	handle_normal_recharge_order(Left, RoleId, Perfix).


%% 处理总订单
%% @return : NewStatus
handle_total_recharge_order([Id, Amount, _], Status) ->
	try db:delete(recharge_feedback, [{order_id, Id}]) of
		_ ->
			% Num = erlang:trunc(Amount * ?RECHARGE_FEEKBACK_COEF),
			Num = 
				if  Amount =< 9990  -> erlang:trunc(Amount * 0.05);
					Amount =< 49990  -> erlang:trunc(Amount * 0.1);
					true -> erlang:trunc(Amount * 0.2)
				end,

			NewStatus = player:recharge_feedback_add_money(Status, Num),
			NewStatus
	catch
		Type:Err ->
			?ERROR_MSG("[recharge_feedback] delete order db error, type = ~p, error = ~p~n", [Type, Err]),
			Status
	end.


%% 处理总订单
%% @return : NewStatus
handle_total_recharge_order_duan(TotalAmount, Status) ->
	?DEBUG_MSG("TotalAmount=~p",[TotalAmount]),

	Content = io_lib:format(<<"嘿！少侠！我们又见面了，有没有想夫人呀？感谢你在封测期间一共充值了~p水玉，现在你获得了双倍的水玉返还，一共是~p，请保管好。">>, [TotalAmount,util:ceil(TotalAmount * ?RECHARGE_FEEKBACK_COEF)]),
	Title = io_lib:format(<<"封测充值返还水玉">>, []),
	lib_mail:send_sys_mail(player:id(Status), tool:to_binary(Title), tool:to_binary(Content), [{?VGOODS_YB, 1, util:ceil(TotalAmount * ?RECHARGE_FEEKBACK_COEF)}], [?LOG_MAIL, "recharge_feedback"]),

	case TotalAmount >= 500000 of
		true ->
			% 累计充值5W赠送道具
			% 62143
			Content1 = io_lib:format(<<"嘿！少侠！我们又见面了，有没有想夫人呀？感谢你在封测期间对梦幻加强版的支持，鉴于你的封测充值记录，夫人送你装备啦，请保管好。!">>, []),
			Title1 = io_lib:format(<<"封测充值返还装备">>, []),
			lib_mail:send_sys_mail(player:id(Status), tool:to_binary(Title1), tool:to_binary(Content1), [{62143, 1, 1}], [?LOG_MAIL, "recharge_feedback"]);
		false ->
			skip
	end,

	case TotalAmount >= 200000 of
		true ->
			% 累计充值2W赠送道具
			% 62142
			Content2 = io_lib:format(<<"嘿！少侠！我们又见面了，有没有想夫人呀？感谢你在封测期间对梦幻加强版的支持，鉴于你的封测充值记录，夫人送你装备啦，请保管好。!">>, []),
			Title2 = io_lib:format(<<"封测充值返还装备">>, []),
			lib_mail:send_sys_mail(player:id(Status), tool:to_binary(Title2), tool:to_binary(Content2), [{62142, 1, 1}], [?LOG_MAIL, "recharge_feedback"]);
		false ->
			skip
	end,

	case TotalAmount >= 100000 of
		true ->
			% 累计充值1W赠送道具
			% 62141
			Content3 = io_lib:format(<<"嘿！少侠！我们又见面了，有没有想夫人呀？感谢你在封测期间对梦幻加强版的支持，鉴于你的封测充值记录，夫人送你装备啦，请保管好。!">>, []),
			Title3 = io_lib:format(<<"封测充值返还装备">>, []),
			lib_mail:send_sys_mail(player:id(Status), tool:to_binary(Title3), tool:to_binary(Content3), [{62141, 1, 1}], [?LOG_MAIL, "recharge_feedback"]);
		false ->
			skip
	end,

	case TotalAmount >= 50000 of
		true ->
			% 累计充值5000赠送道具
			% 62140
			Content4 = io_lib:format(<<"嘿！少侠！我们又见面了，有没有想夫人呀？感谢你在封测期间对梦幻加强版的支持，鉴于你的封测充值记录，夫人送你装备啦，请保管好。!">>, []),
			Title4 = io_lib:format(<<"封测充值返还装备">>, []),
			lib_mail:send_sys_mail(player:id(Status), tool:to_binary(Title4), tool:to_binary(Content4), [{62140, 1, 1}], [?LOG_MAIL, "recharge_feedback"]);
		false ->
			skip
	end,

	case TotalAmount >= 20000 of
		true ->
			% 累计充值2000赠送道具
			% 62139
			Content5 = io_lib:format(<<"嘿！少侠！我们又见面了，有没有想夫人呀？感谢你在封测期间对梦幻加强版的支持，鉴于你的封测充值记录，夫人送你装备啦，请保管好。!">>, []),
			Title5 = io_lib:format(<<"封测充值返还装备">>, []),
			lib_mail:send_sys_mail(player:id(Status), tool:to_binary(Title5), tool:to_binary(Content5), [{62139, 1, 1}], [?LOG_MAIL, "recharge_feedback"]);
		false ->
			skip
	end,

	case TotalAmount >= 10000 of
		true ->
			% 累计充值1000赠送道具
			% 62138
			Content6 = io_lib:format(<<"嘿！少侠！我们又见面了，有没有想夫人呀？感谢你在封测期间对梦幻加强版的支持，鉴于你的封测充值记录，夫人送你装备啦，请保管好。!">>, []),
			Title6 = io_lib:format(<<"封测充值返还装备">>, []),
			lib_mail:send_sys_mail(player:id(Status), tool:to_binary(Title6), tool:to_binary(Content6), [{62138, 1, 1}], [?LOG_MAIL, "recharge_feedback"]);
		false ->
			skip
	end,

	void.


%% 标记进游戏流程的初始化工作已处理完毕
mark_init_for_enter_game_done__() ->
	erlang:put(?PDKN_INIT_FOR_ENTER_GAME_DONE, true).


is_init_for_enter_game_done__() ->
	case erlang:get(?PDKN_INIT_FOR_ENTER_GAME_DONE) of
		true ->
			true;
		_ ->
			false
	end.

%% 调整宝石位置错乱代码，现在已经废弃
% try_adjust_goods(PlayerId, GoodsList) ->
% 	?DEBUG_MSG("[mod_player] adjust_goods, PlayerId:~p, GoodsList:~w~n", [PlayerId, GoodsList]),
% 	F = fun(Goods) ->
% 		Goods1 = lib_goods:set_slot(Goods, ?INVALID_NO),
% 		Goods2 = lib_goods:set_location(Goods1, lib_goods:decide_bag_location(Goods1)),
%         mod_inv:smart_add_goods(PlayerId, Goods2)
%     end,
%     lists:foreach(F, GoodsList).

%% 纠正物品id为长id
try_adjust_goods(PlayerId, GoodsList) ->
	?DEBUG_MSG("[mod_player] adjust_goods, PlayerId:~p, GoodsList:~w~n", [PlayerId, GoodsList]),
	F = fun(Goods) ->
		mod_inv:mark_dirty_flag(PlayerId, Goods)
    end,
    lists:foreach(F, GoodsList).
