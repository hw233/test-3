%%%-------------------------------------------------
%%% @Module  : mod_lgout_svr (logout server)
%%% @Author  : huangjf
%%% @Email   :
%%% @Created : 2014.3.17
%%% @Description: 专门处理玩家下线的server
%%%-------------------------------------------------
-module(mod_lgout_svr).
-behaviour(gen_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([start_link/1]).

-export([
        handle_game_logic_reconn_timeout/1,
        final_logout/2
    ]).

-include("common.hrl").
-include("record.hrl").
-include("lginout.hrl").


start_link(SeqNum) ->
	ServerName = list_to_atom("mod_lgout_svr" ++ "_" ++ integer_to_list(SeqNum)),
	% ?TRACE("logout server name: ~p~n", [ServerName]),
    gen_server:start_link({local, ServerName}, ?MODULE, [], []).






% tmp_logout(PS, Delay) ->
%     PlayerId = player:id(PS),
%     PidName = to_logout_server_proc_name(PlayerId),
%     ?ASSERT(is_logout_server_alive(PidName), {PidName, PlayerId}),
%     gen_server:cast(PidName, {'tmp_logout', PS, Delay}).



% -define(PRE_CAST(PS),   PlayerId = player:id(PS),
%                         PidName = to_logout_server_proc_name(PlayerId),
%                         ?ASSERT(is_logout_server_alive(PidName), {PidName, PlayerId})
%                         ).



% db_save_base_data(PS) ->
%     ?PRE_CAST(PS),
%     gen_server:cast(PidName, {'db_save_base_data', PS}).



% db_save_inventory(PlayerId) ->
%     ?ASSERT(is_integer(PlayerId)),
%     PidName = to_logout_server_proc_name(PlayerId),
%     ?ASSERT(is_logout_server_alive(PidName), {PidName, PlayerId}),
%     gen_server:cast(PidName, {'db_save_inventory', PlayerId}).


% mark_tmp_logout_done(PlayerId) ->
%     ?ASSERT(is_integer(PlayerId)),
%     PidName = to_logout_server_proc_name(PlayerId),
%     ?ASSERT(is_logout_server_alive(PidName), {PidName, PlayerId}),
%     gen_server:cast(PidName, {'mark_tmp_logout_done', PlayerId}).




%% 把没有及时重连的玩家从队伍中踢掉
handle_game_logic_reconn_timeout(PS) ->
    PlayerId = player:id(PS),
    PidName = to_logout_server_proc_name(PlayerId),
    ?ASSERT(is_logout_server_alive(PidName), {PidName, PS}),
    gen_server:cast(PidName, {'handle_game_logic_reconn_timeout', PS}).



%% 因重连超时而最终退出游戏
final_logout(PlayerId, AdminCallbackPid) ->
    ?ASSERT(is_integer(PlayerId)),
    PidName = to_logout_server_proc_name(PlayerId),
    case is_logout_server_alive(PidName) of
        true -> skip;
        false -> ?WARNING_MSG("logout server not alive!!! PidName:~p, PlayerId:~p", [{PidName, PlayerId}])
    end,
    gen_server:cast(PidName, {'final_logout', PlayerId, AdminCallbackPid}).

% 作废！！
% %% 通用处理
% common_handle(PlayerId, Module, Func, Args) ->
%     ?ASSERT(is_integer(PlayerId), PlayerId),
%     PidName = to_logout_server_proc_name(PlayerId),
%     ?ASSERT(is_logout_server_alive(PidName), {PidName, PlayerId}),
%     gen_server:cast(PidName, {'apply_MFA', Module, Func, Args}).


%% ---------------------------------------------------------------------------

init([]) ->
    process_flag(trap_exit, true),
    {ok, null}.




handle_call(_Request, _From, State) ->
	?ASSERT(false, _Request),
    {reply, State, State}.


% handle_cast({'tmp_logout', PS, Delay}, State) ->
%     {noreply, State};



% handle_cast({'db_save_base_data', PS}, State) ->
%     % 为避免本server崩溃，故加catch，下同！
%     ?TRY_CATCH(player:db_save_base_data(PS), ErrReason),
%     {noreply, State};


% handle_cast({'db_save_inventory', PlayerId}, State) ->
%     ?TRY_CATCH(mod_inv:db_save_inventory(PlayerId), ErrReason),
%     {noreply, State};


% handle_cast({'db_save_buff', PlayerId, PartnerIdList}, State) ->
%     ?TRY_CATCH(mod_buff:db_save_buff(PlayerId, PartnerIdList), ErrReason),
%     {noreply, State};


% handle_cast({'mark_tmp_logout_done', PlayerId}, State) ->
%     ?TRY_CATCH(mod_lginout_TSL:mark_tmp_logout_done(PlayerId), ErrReason),
%     {noreply, State};

handle_cast({'handle_game_logic_reconn_timeout', PS}, State) ->
    ?TRY_CATCH(handle_game_logic_reconn_timeout__(PS), ErrReason),
    {noreply, State};

handle_cast({'final_logout', PlayerId, AdminCallbackPid}, State) ->
    ?TRY_CATCH(final_logout__(PlayerId, AdminCallbackPid), ErrReason),
    {noreply, State};


% handle_cast({'apply_MFA', Module, Func, Args}, State) ->
%     case (catch apply(Module, Func, Args)) of
%         {'EXIT', Reason} ->
%             ?ERROR_MSG("[mod_lgout_svr] apply_MFA error!!! Module:~p, Func:~p, Args:~w, Reason:~w",[Module, Func, Args, Reason]),
%             error;
%         _ -> ok
%     end,
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
		_ -> ?ERROR_MSG("[mod_lgout_svr] !!!!!terminate!!!!! for reason: ~w", [Reason])
	end,
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.





%%========================================== Local Functions ===============================================

to_logout_server_proc_name(PlayerId) ->
    ?ASSERT(is_integer(PlayerId), PlayerId),
    Remainder = PlayerId rem ?MAX_LOGOUT_SERVER_COUNT,
    case Remainder of
        0 -> mod_lgout_svr_1;
        1 -> mod_lgout_svr_2;
        2 -> mod_lgout_svr_3;
        3 -> mod_lgout_svr_4;
        4 -> mod_lgout_svr_5;
        5 -> mod_lgout_svr_6;
        6 -> mod_lgout_svr_7;
        7 -> mod_lgout_svr_8;
        8 -> mod_lgout_svr_9;
        9 -> mod_lgout_svr_10;
        10 -> mod_lgout_svr_11;
        11 -> mod_lgout_svr_12;
        12 -> mod_lgout_svr_13;
        13 -> mod_lgout_svr_14;
        14 -> mod_lgout_svr_15;
        15 -> mod_lgout_svr_16;
        16 -> mod_lgout_svr_17;
        17 -> mod_lgout_svr_18;
        18 -> mod_lgout_svr_19;
        19 -> mod_lgout_svr_20;
        20 -> mod_lgout_svr_21;
        21 -> mod_lgout_svr_22;
        22 -> mod_lgout_svr_23;
        23 -> mod_lgout_svr_24;
        24 -> mod_lgout_svr_25;
        25 -> mod_lgout_svr_26;
        26 -> mod_lgout_svr_27;
        27 -> mod_lgout_svr_28;
        28 -> mod_lgout_svr_29;
        29 -> mod_lgout_svr_30;
        30 -> mod_lgout_svr_31;
        31 -> mod_lgout_svr_32
    end.

is_logout_server_alive(PidName) ->
    Pid = erlang:whereis(PidName),
    is_pid(Pid) andalso is_process_alive(Pid).



handle_game_logic_reconn_timeout__(PS) ->
    PlayerId = player:id(PS),
    case mod_lginout_TSL:tsl(t_is_entering_game_or_enter_game_done, sl_handling_game_logic_reconn_timeout, [PlayerId]) of
        true -> % 表明角色及时重连并且正在进入游戏或已经进入了游戏，不做处理
            skip;
        false ->
            % 处理队伍重连超时
            handle_team_reconn_timeout__(PS),

            % 处理副本重连超时
            handle_dungeon_reconn_timeout__(PS)
    end.



final_logout__(PlayerId, AdminCallbackPid) ->
    case mod_lginout_TSL:tsl(t_is_entering_game_or_enter_game_done, sl_final_logouting, [PlayerId]) of
        true -> % 表明角色及时重连并且正在进入游戏或已经进入了游戏，不做处理
            skip;
        false ->
            do_final_logout__(PlayerId, AdminCallbackPid),
            % 标记final logout已完成！
            mod_lginout_TSL:mark_final_logout_done(PlayerId)
    end.







%%（因超时未重新连接而导致）最终退出游戏
%% 主要处理是：保存玩家的相关数据到数据库，然后把玩家的相关数据从内存清掉
do_final_logout__(PlayerId, AdminCallbackPid) ->
    ?TRACE("~n~n[mod_lgout_svr] do_final_logout__(), PlayerId=~p~n~n", [PlayerId]),

    ?ASSERT(player:get_PS(PlayerId) == null, PlayerId),

    PS = ply_tmplogout_cache:get_tmplogout_PS(PlayerId),
    ?ASSERT(is_record(PS, player_status), {PlayerId, PS}),

    case PS of
        null ->  % 判断，容错
            ?ERROR_MSG("[mod_lgout_svr] do_final_logout__() error!!! can't find player! PlayerId:~p", [PlayerId]),
            ?ASSERT(false),
            skip;
        _ ->
            % 保存基础数据
            ?TRY_CATCH(player:db_save_base_data(PS), ErrReason_DBSaveBaseData),
            % 处理活动数据
            ?TRY_CATCH(ply_activity:on_player_final_logout(PS), ErrReason_PlyActivity),
            % 保存物品栏数据
            ?TRY_CATCH(mod_inv:db_save_inventory(PlayerId), ErrReason_DBSaveInv),
            % 保存宠物数据
            ?TRY_CATCH(ply_partner:db_save_all_partners(PS), ErrReason_DBSaveAllPar),
            % 保存天将数据
            ?TRY_CATCH(ply_hire:db_try_save_hirer(PlayerId), ErrReason_DBTrySaveHirer),
            % 保存系统设置
            ?TRY_CATCH(ply_setting:db_save_player_setting(PlayerId), ErrReason_DBSaveSetting),
            % 保存每日奖励
            ?TRY_CATCH(mod_day_reward:db_save_player_day_reward(PlayerId), ErrReason_DBSaveDayReward),

            % 清除坐骑皮肤数据
            ?TRY_CATCH(lib_mount:on_logout(PlayerId), ErrReason_MountSkin),

            % 通知爬塔保存数据
            ?TRY_CATCH(lib_tower:logout(PS), ErrReason_Tower),
            % 通知噩梦爬塔保存数据
            ?TRY_CATCH(lib_hardtower:logout(PS), ErrReason_Hardtower),
            % 保存任务数据
            ?TRY_CATCH(lib_task:final_logout_out(PlayerId), ErrReason_Task),

            % 保存活跃度信息
            ?TRY_CATCH(lib_activity_degree:final_logout(PlayerId), ErrReason_AD),

            % 保存找回经验信息
            ?TRY_CATCH(lib_jingyan:final_logout(PlayerId), ErrReason_JY),

            % 更新离线数据
            ?TRY_CATCH(mod_offline_data:update_offline_role_brief(PS), ErrReason_OD),

            % 保存聊天相关信息
            ?TRY_CATCH(lib_chat:final_logout(PlayerId), ErrReason_Chat),

            % 成就处理
            ?TRY_CATCH(mod_achievement:final_logout(PlayerId), ErrReason_Achi),

            % 答题处理
            ?TRY_CATCH(lib_activity:answer_logout(PS), ErrReason_Answer),

            % 运镖处理
            ?TRY_CATCH(lib_transport:final_logout(PS), ErrReason_Transport),

            %% 保存战斗外buff信息
            ?TRY_CATCH(mod_buff:db_save_buff(PlayerId, player:get_partner_id_list(PS)), ErrReason_DBBuff),

            % 保存寻妖数据
            ?TRY_CATCH(ply_partner:db_save_find_par_info(PlayerId), ErrReason_DBSaveFindPar),

            % 删除剧情目标数据
            ?TRY_CATCH(mod_dungeon_plot:final_logout(PlayerId), ErrReason_DUN_PLOT),

            % 竞技场保存数据和离线数据
            % 删除离线竞技场数据
            ?TRY_CATCH(lib_offline_arena:logout(PS), ErrReason_OA),

            ?TRY_CATCH(ply_relation:db_save_relation_data(PlayerId), ErrReason_DBRela),

            ?TRY_CATCH(ply_misc:db_save_player_misc(PlayerId), ErrReason_DBMisc),

            ?TRY_CATCH(mod_fabao:db_save_player_fabao(PlayerId), ErrReason_DBFaBao),

            ?TRY_CATCH(mod_inv:del_goods_from_temp_bag(PlayerId), ErrReason_DelTempGoods),

            % 从内存删除对应的物品数据
            ?TRY_CATCH(mod_inv:del_goods_from_ets_by_player_id(PlayerId), ErrReason_DelGoods),
            ?TRY_CATCH(mod_inv:del_inventory_from_ets(PlayerId), ErrReason_DelInv),
            % 从内存删除宠物数据
            ?TRY_CATCH(ply_partner:del_all_my_partners_from_ets(PS), ErrReason_DelPar),
            % 从内存删除位置信息
            ?TRY_CATCH(player:delete_position(PlayerId), ErrReason_DelPos),
            % 从内存删除心法数据
            ?TRY_CATCH(ply_xinfa:on_player_final_logout(PlayerId), ErrReason_DelXinfa),
            % 从内存删除天将数据
            ?TRY_CATCH(mod_hire:del_hirer_from_ets(PlayerId), ErrReason_DelHirer),
            % 从内存删除系统设置
            ?TRY_CATCH(ply_setting:del_sys_setting_from_ets(PlayerId), ErrReason_DelSysSetting),
            % 从内存删除每日奖励数据
            ?TRY_CATCH(mod_day_reward:del_day_reward_from_ets(PlayerId), ErrReason_DelDayReward),

            %% 从内存删除buff
            ?TRY_CATCH(mod_buff:del_player_buff_from_ets(PS), ErrReason_DelBuff),

            % ?TRY_CATCH(ply_relation:del_relation_info_from_ets(PlayerId), ErrReason_DelRela),

            ?TRY_CATCH(ply_misc:del_player_misc_from_ets(PlayerId), ErrReason_DelMisc),

            % 从内存删除玩家的系统开放信息
            ?TRY_CATCH(ply_sys_open:del_opened_sys_list_info_from_ets(PlayerId), ErrReason_DelOpenedSys),

            % 从内存删除玩家寻妖信息
            ?TRY_CATCH(ply_partner:del_find_par_info_from_ets(PlayerId), ErrReason_DelFindPar),

            ?TRY_CATCH(mod_admin_activity:logout_handle(PlayerId), ErrReason_Admin_Activity),

            % 清除title数据
            ?TRY_CATCH(ply_title:on_logout(PlayerId), ErrReason_Title),

            % 清除推广信息
            ?TRY_CATCH(ply_sprd:on_player_final_logout(PlayerId), ErrReason_Sprd),

            % 清除女妖选美-抽奖活动信息
            ?TRY_CATCH(lib_beauty_contest:final_logout(PS), ErrReason_Belautycontest),

            % 商会信息退出处理
            ?TRY_CATCH(lib_business:final_logout(PS), ErrReason_Business),

            % % 玩家拓展信息退出处理
            ?TRY_CATCH(player:db_save_popular(PS,player:get_popular(PS)), ErrReason_Popular),

            % 清除女妖乱斗玩家信息
            ?TRY_CATCH(lib_melee:final_logout(PS), ErrReason_Melee),

            % 幸运转盘处理
            ?TRY_CATCH(lib_ernie:final_logout(PlayerId), ErrReason_Ernie),

            ?TRY_CATCH(mod_strengthen:on_logout(PlayerId), ErrReason_Fashion),

			% 家园处理
			?TRY_CATCH(lib_home:final_logout(PS), ErrReason_Home),

            %% -------- 最后的处理 -----------
            % 从内存删除玩家结构体
            ?ASSERT(ply_tmplogout_cache:get_tmplogout_PS(PlayerId) /= null, PlayerId),
            ply_tmplogout_cache:del_tmplogout_PS(PlayerId),
            % 从内存删除玩家简要信息
            ?ASSERT(ply_tmplogout_cache:get_tmplogout_PBrf(PlayerId) /= null, PlayerId),
            ply_tmplogout_cache:del_tmplogout_PBrf(PlayerId)
    end,

    %% ------------ 通知管理后台 -------------------
    case AdminCallbackPid of
        null -> skip;
        Pid when is_pid(Pid) -> Pid ! ok;
        _ -> skip
    end,
    ?LDS_TRACE("handle final_logout done"),

    ok.



%% 处理队伍重连超时
handle_team_reconn_timeout__(PS) ->
    mod_team:team_reconn_timeout(PS).



%% 处理副本重连超时
handle_dungeon_reconn_timeout__(PS) ->
    ?TRACE("handle_dungeon_reconn_timeout__(), PlayerId:~p~n", [player:id(PS)]),
    lib_dungeon:dungeon_reconn_timeout(PS).
