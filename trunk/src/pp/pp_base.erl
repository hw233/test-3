%%%--------------------------------------
%%% @Module  : pp_base
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2011.04.29
%%% @Description:  基础功能
%%%--------------------------------------
-module(pp_base).
-export([handle/3]).

-include("common.hrl").
-include("record.hrl").
-include("pt_10.hrl").
-include("player.hrl").
-include("prompt_msg_code.hrl").

% %%退出游戏
% handle(10001, Status, _) ->
% 	?ASSERT(false),
%     gen_server:cast(Status#player_status.pid, 'LOGOUT'),
%     {ok, BinData} = pt_10:write(10001, []),
%     lib_send:send_one(Status#player_status.socket, BinData);

%%心跳包
handle(?PT_CONNECTION_HEARTBEAT, PS, _) ->
	Now = util:unixtime(),
	[PreTime, Num] = erlang:get(?PDKN_DETECT_HEART_TIME),
	DiffTime = Now - PreTime,
    ?DEBUG_MSG("wujiancheng HEARTBEAT ~p ~n", [DiffTime]),
	VipLv =player:get_vip_lv(PS) ,
	NewNum = 
		if 
			 VipLv > 2 andalso VipLv < 5  ->
				case DiffTime > 24 of
					true ->
						0;
					false ->
						Num + 1	
				end;
			VipLv =:= 5 ->
				case DiffTime > 16 of
					true ->
						0;
					false ->
						Num + 1	
				end;
			 VipLv =:= 6 ->
				 case DiffTime > 12 of
					true ->
						0;
					false ->
						Num + 1	
				end;
			true ->				
				case DiffTime > 45 of
					true ->
						0;
					false ->
						Num + 1	
				end
		end,
			   
	 
	erlang:put(?PDKN_DETECT_HEART_TIME, [Now, NewNum]),
	case NewNum >= 3 of
		true ->
			% 涉嫌使用外挂
 			% {ok, BinData} = pt_11:write(11082, "您涉嫌使用非法软件，现在被踢下线。"),
 			% lib_send:send_to_sock(PS, BinData),
			%%lib_log:log_kick_off(PS, 1, Now),

			ply_comm:notify_cli_will_be_force_disconn_soon(PS, conn_heartbeat_freq_too_high),			
 			timer:sleep(100),
 			?WARNING_MSG("PT_CONNECTION_HEARTBEAT freq too high!! PlayerId:~p", [player:id(PS)]),
			mod_login:force_disconnect(player:get_accname(PS), player:get_from_server_id(PS), player:id(PS), player:get_pid(PS));
		false ->
			ply_comm:notify_cli_server_timestamp(PS)
	end,
	void;


%% 查询服务器的时间戳
handle(?PT_QUERY_SERVER_TIMESTAMP, PS, _) ->
	ply_comm:notify_cli_server_timestamp(PS),
	void;

    

%% 客户端通知服务端：客户端已初始化完毕
handle(?PT_C2S_NOTIFY_INIT_DONE, PS, _) ->
    % Now = util:unixtime(),
    % lib_tower:handle_tower_login(Now, PS),

    % 处理充值反馈
    ?DEBUG_MSG("act=~p",["PT_C2S_NOTIFY_INIT_DONE"]),
    player:recharge_feedback(PS),

    mod_team:on_player_login(PS),
    ply_guild:try_notify_player_apply_join(PS),
    mod_couple_cruise_inst:on_player_login(PS),
    void;
    

    %%todo:测试数据而已
    %% 通过心跳包回血回蓝
%%     case Status#player_status.hp >0 andalso (Status#player_status.hp < Status#player_status.hp_lim orelse Status#player_status.mp < Status#player_status.mp_lim) of
%%         true ->
%%             Hp = if
%%                 Status#player_status.hp + 50 > Status#player_status.hp_lim ->
%%                     Status#player_status.hp_lim;
%%                 true ->
%%                     Status#player_status.hp + 50
%%             end,
%%             Mp = if
%%                 Status#player_status.mp + 50 > Status#player_status.mp_lim ->
%%                     Status#player_status.mp_lim;
%%                 true ->
%%                     Status#player_status.mp + 50
%%             end,
%%             Status1 = Status#player_status{hp = Hp},
%%             {ok, BinData1} = pt_12:write(12009, [Status1#player_status.id, Status1#player_status.hp, Status1#player_status.hp_lim, Status1#player_status.battle_capacity]),
%%             lib_send:send_to_area_scene(Status1#player_status.scene, Status1#player_status.line_id, Status1#player_status.x, Status1#player_status.y, BinData1),
%%             {ok, Status1};
%%         false ->
%%             ok
%%     end;
    
    %{ok, BinData2} = pt_10:write(10006, []),
    %lib_send:send_one(Status#player_status.socket, BinData2)



%% 删除角色
handle(?PT_DISCARD_ROLE, PS, TargetRoleId) ->
    ply_account:discard_role(PS, TargetRoleId),
    void;

handle(?PT_MODIFY_ROLE_NAME, PS, [GoodsId, Name]) ->
    Now = util:unixtime(),
    case Now - get_last_modify_nickname_time() > 3 of
        true ->
            case ply_account:modify_nickname(PS, GoodsId, Name) of
                {fail, Reason} ->
                    RetCode = 
                        case Reason of
                            ?CR_FAIL_ROLE_LIST_FULL -> ?PM_CR_FAIL_ROLE_LIST_FULL;
                            ?CR_FAIL_NAME_EMPTY -> ?PM_CR_FAIL_NAME_EMPTY;
                            ?CR_FAIL_NAME_TOO_SHORT -> ?PM_CR_FAIL_NAME_TOO_SHORT;
                            ?CR_FAIL_NAME_TOO_LONG -> ?PM_CR_FAIL_NAME_TOO_LONG;
                            ?CR_FAIL_CHAR_ILLEGAL -> ?PM_CR_FAIL_CHAR_ILLEGAL;
                            ?CR_FAIL_NAME_CONFLICT -> ?PM_CR_FAIL_NAME_CONFLICT;
                            _ -> ?PM_UNKNOWN_ERR
                        end,
                    lib_send:send_prompt_msg(PS, RetCode);
                {ok, RetName} -> 
                    {ok, BinData} = pt_10:write(?PT_MODIFY_ROLE_NAME, [?RES_OK, RetName]),
                    lib_send:send_to_sock(PS, BinData),
                    set_last_modify_nickname_time(Now)
            end;
        false -> lib_send:send_prompt_msg(PS, ?PM_MK_FAIL_SERVER_BUSY)
    end;


handle(?PT_ACCOUNT_BIND_STATE, PS, []) ->
	Ret = 
		case ply_account:check_account_bind_phone(PS) of
			true ->
				0;
			false ->
				1
		end,
	{ok, BinData} = pt_10:write(?PT_ACCOUNT_BIND_STATE, [Ret]),
	lib_send:send_to_sock(PS, BinData);


handle(?PT_ACCOUNT_BIND_PHONE_SMS, PS, [Mobile]) ->
	case ply_account:mobile_bind_sms_code(PS, Mobile) of
		ok ->
			{ok, BinData} = pt_10:write(?PT_ACCOUNT_BIND_PHONE_SMS, []),
			lib_send:send_to_sock(PS, BinData),
			ok;
		{fail, MsgCode} ->
			lib_send:send_prompt_msg(PS, MsgCode)
	end;


handle(?PT_ACCOUNT_BIND_PHONE_CONFIRM, PS, [Mobile, Code]) ->
	case ply_account:account_bind_mobile(PS, Mobile, Code) of
		ok ->
			{ok, BinData} = pt_10:write(?PT_ACCOUNT_BIND_PHONE_CONFIRM, []),
			lib_send:send_to_sock(PS, BinData),
			ok;
		{fail, MsgCode} ->
			lib_send:send_prompt_msg(PS, MsgCode)
	end;


%% 反馈意见
handle(?PT_FEEDBACK, PS, [Type, Feedback]) ->
	case ply_account:feedback(PS, Type, Feedback) of
		ok ->
			{ok, BinData} = pt_10:write(?PT_FEEDBACK, []),
			lib_send:send_to_sock(PS, BinData);
		{fail, MsgCode} ->
			lib_send:send_prompt_msg(PS, MsgCode)
	end;


handle(_Cmd, _PS, _Data) ->
	?ASSERT(false, _Cmd),
    %%?DEBUG_MSG("pp_base no match", []),
    {error, not_match}.



get_last_modify_nickname_time() ->
    case erlang:get(last_modify_nickname_time) of
        undefined ->
            0;
        Time ->
            Time
    end.  

set_last_modify_nickname_time(Time) ->
    erlang:put(last_modify_nickname_time, Time).