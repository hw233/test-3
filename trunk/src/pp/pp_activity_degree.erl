%%%--------------------------------------
%%% @Module  : pp_activity_degree
%%% @Author  : LDS
%%% @Email   : 
%%% @Created : 2014.2
%%% @Description:  活跃度系统  pt  58
%%%--------------------------------------
-module(pp_activity_degree).

-include("common.hrl").
-include("record.hrl").
-include("activity_degree.hrl").
-include("prompt_msg_code.hrl").
-include("protocol/pt_58.hrl").

-export([handle/3]).


handle(58001, Status, []) ->
    Data = lib_activity_degree:get_activity_info(Status),
    % ?LDS_TRACE(58001, Data),
    {ok, BinData} = pt_58:write(58001, [Data]),
    lib_send:send_to_sock(Status#player_status.socket, BinData),
    ok;

handle(58002, Status, []) ->
    Data = lib_activity_degree:get_reward_info(Status),
    % ?LDS_TRACE(58002, Data),
    {ok, BinData} = pt_58:write(58002, [Data]),
    lib_send:send_to_sock(Status#player_status.socket, BinData),
    ok;

handle(58003, Status, [RewardIndex]) ->
	case lib_activity_degree:get_reward(RewardIndex, Status) of
		true ->case RewardIndex == 5 of
				   true ->  mod_achievement:notify_achi(get_reward, [{no, 41124}], Status);
				   false ->
					   skip
			   end, handle(58002, Status, []);
		_ -> skip
	end,
	ok;

handle(58005, Status, _) ->
    mod_activity:login_check_activity_open(Status),
    ok;


handle(?PT_ACT_JINGYAN, Status, _) ->
    lib_jingyan:send_panel(Status),
    ok;

handle(?PT_ACT_JINGYAN_AWARD, Status, [Sys, Type]) ->
    lib_jingyan:get_award(Sys, Status, Type),
    ok;

handle(?PT_ACT_JINGYAN_RESET, Status, []) ->
    lib_jingyan:get_first_login_flag(Status),
    ok;


handle(_Cmd, _, _Arg) ->
    ?ASSERT(false, [_Cmd, _Arg]),
    error.