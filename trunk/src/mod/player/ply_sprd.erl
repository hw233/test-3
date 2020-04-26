%%%--------------------------------------
%%% @Module  : ply_sprd
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2014.8.6
%%% @Description: 玩家与推广（spread）系统相关的业务逻辑
%%%--------------------------------------
-module(ply_sprd).
-export([
		db_init_sprd_code/2,
		get_sprd_info/1,
		req_build_sprd_rela/2,  callback_req_build_sprd_rela/2,
		on_player_final_logout/1, callback_on_player_final_logout/1,
		on_player_upgrade/2
    ]).

-include("common.hrl").
-include("record.hrl").
-include("debug.hrl").
-include("sprd.hrl").
-include("ets_name.hrl").
-include("prompt_msg_code.hrl").
-include("pt_35.hrl").
-include("abbreviate.hrl").


db_init_sprd_code(PlayerId, SprdCode) ->
	db:insert(sprd, ["player_id", "code"], [PlayerId, SprdCode]).


%% 获取玩家的推广信息
%% @return: null | #sprd{}
get_sprd_info(PS) when is_record(PS, player_status) ->
	get_sprd_info(player:id(PS));

get_sprd_info(PlayerId) when is_integer(PlayerId) ->
	case get_sprd_info_from_ets(PlayerId) of
		null ->
			% 懒初始化加载
			case db_load_sprd_info(PlayerId) of
				null ->
					?ASSERT(false, PlayerId),
					null;
				SprdInfo ->
					add_sprd_info_to_ets(SprdInfo),
					SprdInfo
			end;
		SprdInfo ->
			SprdInfo
	end.


%% 请求与他人建立推广关系（自己是作为被推广人的身份）
req_build_sprd_rela(PS, TargetSprdCode) ->
	% 为避免并发问题，统一委托到sprd进程做处理
	mod_sprd:player_req_build_sprd_rela(PS, TargetSprdCode).


callback_req_build_sprd_rela(PS, TargetSprdCode) ->
	case check_req_build_sprd_rela(PS, TargetSprdCode) of
		{fail, unknown_err} ->
			?ASSERT(false),
			skip;
		{fail, req_illegal} ->
			skip;
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason);
		{ok, TargetPlayerId} ->
			build_new_sprd_rela(TargetPlayerId, player:id(PS))
	end.




on_player_final_logout(PlayerId) ->
	?ASSERT(is_integer(PlayerId)),
	% 为避免并发问题，统一委托到sprd进程做处理
	mod_sprd:on_player_final_logout(PlayerId).


callback_on_player_final_logout(PlayerId) ->
	del_sprd_info_from_ets(PlayerId).




on_player_upgrade(PS, NewLv) ->
	mod_sprd:on_player_upgrade(PS, NewLv).








%% -----------------------------------------------------------------------------

check_req_build_sprd_rela(PS, TargetSprdCode) ->
	case player:get_lv(PS) > ?SPRD_LV_LIMIT of
		true ->
			{fail, ?PM_SPRD_FAIL_LV_LIMIT};
		false ->
			case get_sprd_info(PS) of
				null ->
					?ASSERT(false),
					{fail, unknown_err};
				MySprdInfo ->
					case MySprdInfo#sprd.sprder_id /= ?INVALID_ID of
						true ->
							{fail, req_illegal};
						false ->
							case db_find_player_by_sprd_code(TargetSprdCode) of
								null ->
									{fail, ?PM_INVALID_SPRD_CODE};  % 推广码无效
								TargetPlayerId ->
									MyId = player:id(PS),
									case TargetPlayerId == MyId of
										true ->
											{fail, ?PM_SELF_SPRD_CODE};
										false ->
											case get_sprd_info(TargetPlayerId) of
												null ->
													?ASSERT(false),
													{fail, unknown_err};
												TargetSprdInfo ->
													case length(TargetSprdInfo#sprd.sprdee_list) >= ?MAX_SPRDEE_COUNT of
														true ->
															{fail, ?PM_TARGET_SPRD_RELA_FULL};  % 对方的推广关系列表满了，不再接受与他人建立推广关系
														false ->
															{ok, TargetPlayerId}
													end
											end
									end
							end
					end
			end
	end.

			

					
%% 建立新的推广关系
%% @para: SprderId => 推广人的id
%%        SprdeeId => 被推广人的id
build_new_sprd_rela(SprderId, SprdeeId) ->
	Info_Sprder = get_sprd_info(SprderId),
	Info_Sprdee = get_sprd_info(SprdeeId),

	Info_Sprder2 = Info_Sprder#sprd{
								sprdee_list = Info_Sprder#sprd.sprdee_list ++ [SprdeeId]
								},
	Info_Sprdee2 = Info_Sprdee#sprd{
								sprder_id = SprderId
								},

	update_sprd_info_to_ets(Info_Sprder2),
	update_sprd_info_to_ets(Info_Sprdee2),

	db_save_sprd_info(Info_Sprder2),
	db_save_sprd_info(Info_Sprdee2),

	notify_cli_new_sprd_rela_builded(SprderId, SprdeeId).


notify_cli_new_sprd_rela_builded(SprderId, SprdeeId) ->
	{ok, Bin} = pt_35:write(?PT_NOTIFY_NEW_SPRD_RELA_BUILDED, [SprderId, SprdeeId]),

	?Ifc (player:is_online(SprderId))
		lib_send:send_to_uid(SprderId, Bin)
	?End,

	?Ifc (player:is_online(SprdeeId))
		lib_send:send_to_uid(SprdeeId, Bin)
	?End.




%% @return: null | #sprd{}
get_sprd_info_from_ets(PlayerId) ->
	?ASSERT(is_integer(PlayerId)),
	case ets:lookup(?ETS_PLAYER_SPRD, PlayerId) of
		[] ->
			null;
		[SprdInfo] ->
			?ASSERT(is_record(SprdInfo, sprd), SprdInfo),
			SprdInfo
	end.

add_sprd_info_to_ets(SprdInfo) when is_record(SprdInfo, sprd) ->
	ets:insert(?ETS_PLAYER_SPRD, SprdInfo),
	?ASSERT(get_sprd_info_from_ets(SprdInfo#sprd.player_id) /= null),
	void.

update_sprd_info_to_ets(SprdInfo) when is_record(SprdInfo, sprd) ->
	?ASSERT(get_sprd_info_from_ets(SprdInfo#sprd.player_id) /= null),
	ets:insert(?ETS_PLAYER_SPRD, SprdInfo),
	void.

del_sprd_info_from_ets(PlayerId) ->
	?ASSERT(is_integer(PlayerId)),
	ets:delete(?ETS_PLAYER_SPRD, PlayerId),
	?ASSERT(get_sprd_info_from_ets(PlayerId) =:= null),
	void.





%% 从DB加载玩家的推广信息
%% @return: null | #sprd{}
db_load_sprd_info(PlayerId) ->
	case db:select_row(sprd, "code, sprdee_list, sprder_id", [{player_id, PlayerId}]) of
        [] ->
        	% todo:  容错：重新初始化数据库中玩家的推广信息。。。
        	null;
        [Code_BS, SprdeeList_BS, SprderId] ->
        	?ASSERT(is_binary(Code_BS), Code_BS),
        	?ASSERT(is_integer(SprderId), SprderId),
        	% ?DEBUG_MSG("db_load_sprd_info(), PlayerId:~p, Code_BS:~p, SprdeeList_BS:~p, SprderId:~p", [PlayerId, Code_BS, SprdeeList_BS, SprderId]),
            RetSprd = #sprd{
		            	player_id = PlayerId,
		            	code = binary_to_list(Code_BS),
		                sprdee_list = tuple_to_list( util:bitstring_to_term(SprdeeList_BS) ),  % 因存储时转为了tuple格式，故这里转换回list！
		                sprder_id = SprderId
		                },

		    case RetSprd#sprd.code == ?CDK_8_AFTER_MERGE_SERVER of
		    	true ->
		    		% （合服后）重新生成
		    		{ok, CDK8} = mod_cdk:gen_cdk_8(),
		    		db_update_sprd_code(PlayerId, CDK8),
		    		?DEBUG_MSG("db_load_sprd_info(), PlayerId:~p, old cdk:~p, new cdk:~p", [PlayerId, RetSprd#sprd.code, CDK8]),
		    		RetSprd#sprd{code = CDK8};
		    	false ->
		    		RetSprd
		    end
    end.


db_update_sprd_code(PlayerId, SprdCode) ->
	db:update(
			PlayerId,
			sprd,
			["code"],
			[SprdCode],
			"player_id",
			PlayerId
			).


%% 保存玩家的推广信息到DB
db_save_sprd_info(SprdInfo) ->
	PlayerId = SprdInfo#sprd.player_id,
	SprdeeList_TupBS = util:term_to_bitstring( list_to_tuple(SprdInfo#sprd.sprdee_list) ),  % 转为tuple格式再存
	db:update(PlayerId, sprd,
			  ["sprdee_list", "sprder_id"],
			  [SprdeeList_TupBS, SprdInfo#sprd.sprder_id],
			  "player_id",
			  PlayerId
			).



%% 从DB查找推广码对应的玩家
%% @return: null | 玩家id
db_find_player_by_sprd_code(SprdCode) ->
	case db:select_one(sprd, "player_id", [{code, SprdCode}], [], [1]) of
        null ->
            null;
        PlayerId ->
            ?ASSERT(is_integer(PlayerId), PlayerId),
            PlayerId
    end.
