%%%--------------------------------------
%%% @Module  : lib_times_log
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2012.7.12
%%% @Description: 玩家在单天限定次数的一些游戏玩法中的当前次数记录（比如，当天已进入某组队关卡的次数等）
%%%--------------------------------------
-module(lib_times_log).
% -export([
% 		db_insert_one_record_to_times_log/1,
% 		db_load_one_day_times_log/3,
% 		db_save_one_day_times_log/1,
% 		get_today_enter_team_pass_times/2,
% 		add_today_enter_team_pass_times/2
%     ]).


% -include("common.hrl").
% -include("record.hrl").
% -include("player.hrl").
% -include("abbreviate.hrl").


% %% 插入玩家对应的一条记录到数据库表（以备后续使用）
% db_insert_one_record_to_times_log(PlayerId) ->
% 	case db:select_row(one_day_times_log, "count(*)", [{player_id,PlayerId}]) of
% 		[1] -> % 已插入玩家对应的记录了，跳过（注：正常流程是不会出现此情况的，除非使用了调等级的gm指令）
% 			?TRACE("already insert_one_record_to_times_log, so skip...~n"),
% 			skip;
% 		[0] ->
% 			?TRACE("haven't insert_one_record_to_times_log yet, so insert...~n"),
% 			_SqlRet = db:insert(one_day_times_log, ["player_id"], [PlayerId]),
% 			?ASSERT(_SqlRet =:= 1);
% 		_ -> % db操作出错
% 			?ASSERT(false),
% 			skip	
% 	end.
	
	
			
	
	


% %% 从数据库加载玩家的相关次数记录信息
% db_load_one_day_times_log(PlayerPid, PlayerId, PlayerLv) ->
% 	?Ifc (PlayerLv >= ?LV_FOR_INSERT_RECORD_TO_TIMES_LOG)
% 		case db:select_row(one_day_times_log, "tl_enter_team_pass, date", [{player_id,PlayerId}]) of
% 			[] ->
% 				?ASSERT(false, PlayerId),
% 				skip;
% 			[EnterTeamPassTimes_Str, Date] ->
% 				Today = lib_common:today_date(),
% 				case Today /= Date of
% 					true -> % 隔天则重置次数记录为空
% 						OneDayTimesLog = #role_times_log{date = Today, tl_enter_team_pass = []},
% 						gen_server:cast(PlayerPid, {'SET_ONE_DAY_TIMES_LOG', OneDayTimesLog});
% 					false ->
% 						% 字符串转成列表
%  						TimesLog_EnterTeamPass = 
%  								case util:bitstring_to_term(EnterTeamPassTimes_Str) of
%  									undefined ->
%  										[];
%  									RetList when is_list(RetList) ->
%  										?TRACE("tl, it is list: ~p~n", [RetList]),
%  										RetList;
%  									_ ->
%  										?ASSERT(false),
%  										[]
%  								end,
% 						?TRACE("my EnterTeamPassTimes_Str: ~p, EnterTeamPassTimesLog: ~p...~n", [EnterTeamPassTimes_Str, TimesLog_EnterTeamPass]),
% 						OneDayTimesLog = #role_times_log{
% 											date = Today,
% 											tl_enter_team_pass = TimesLog_EnterTeamPass
% 											},
% 						gen_server:cast(PlayerPid, {'SET_ONE_DAY_TIMES_LOG', OneDayTimesLog})
% 				end;
% 			_Any -> % db操作出错
% 				?ASSERT(false),
% 				skip
% 		end
% 	?End.
	
	
% %% 保存玩家的相关次数记录信息到数据库
% db_save_one_day_times_log(PS) ->
% 	?TRACE("db_save_one_day_times_log()....~n"),
% 	case PS#player_status.lv < ?LV_FOR_INSERT_RECORD_TO_TIMES_LOG of
% 		true -> % 还没到指定等级，则跳过
% 			?TRACE("lv is ~p, no need save one day times log~n", [PS#player_status.lv]),
% 			skip;
% 		false ->
% 			TL =  PS#player_status.times_log,  % TL: times log的缩写
% 			TL_EnterTeamPass = TL#role_times_log.tl_enter_team_pass,
% 			db:update(one_day_times_log,
% 						["date", "tl_enter_team_pass"],
% 						[	
% 							TL#role_times_log.date,
% 							case util:term_to_bitstring(TL_EnterTeamPass) of <<"undefined">> -> <<>>; Any -> Any end
% 						],
% 						"player_id",
% 						PS#player_status.id)
% 	end.
	
	
	
% %% 获取今天已进入指定组队关卡的次数
% %% @para: PassId => 组队关卡id
% get_today_enter_team_pass_times(PS, PassId) when is_record(PS, player_status) ->
% 	TL = PS#player_status.times_log,  % TL: times log的缩写
% 	Date = TL#role_times_log.date,
% 	Today = lib_common:today_date(),
% 	case Date /= Today of
% 		true ->
% 			0;
% 		false ->
% 			TL_EnterTeamPass = TL#role_times_log.tl_enter_team_pass,
% 			case TL_EnterTeamPass of
% 				[] -> 0;
% 				_ -> proplists:get_value(PassId, TL_EnterTeamPass, 0)
% 			end
% 	end;
% get_today_enter_team_pass_times(R, PassId) when is_record(R, ets_online) ->
% 	TL = R#ets_online.times_log,
% 	Date = TL#role_times_log.date,
% 	Today = lib_common:today_date(),
% 	case Date /= Today of
% 		true ->
% 			0;
% 		false ->
% 			TL_EnterTeamPass = TL#role_times_log.tl_enter_team_pass,
% 			case TL_EnterTeamPass of
% 				[] -> 0;
% 				_ -> proplists:get_value(PassId, TL_EnterTeamPass, 0)
% 			end
% 	end.
	
	
	


% %% 今天已进入指定组队关卡的次数加1
% %% @para: PassId => 组队关卡id
% %% return: NewPS（更新后的玩家状态）
% add_today_enter_team_pass_times(PlayerId, PassId) ->
% 	case lib_player:get_local_online_info(PlayerId) of
% 		null ->
% 			?ASSERT(false, PlayerId),
% 			skip;
% 		R ->
% 			?TRACE("add_today_enter_team_pass_times()~n"),
% 			TL = R#ets_online.times_log,  % TL: times log的缩写
% 			Date = TL#role_times_log.date,
% 			TL_EnterTeamPass = TL#role_times_log.tl_enter_team_pass,
% 			Today = lib_common:today_date(),
% 			NewEnterTimes = case Date == Today of
% 								true -> % 还未到第二天，则次数加1
% 									OldTimes = proplists:get_value(PassId, TL_EnterTeamPass, 0),
% 									OldTimes + 1;
% 								false -> % 到了第二天，则重新开始算次数
% 									1
% 							end,
							
% 			?TRACE("NewEnterTimes: ~p~n", [NewEnterTimes]),
						
% 			TL_EnterTeamPass2 = proplists:delete(PassId, TL_EnterTeamPass),
% 			NewTL_EnterTeamPass = TL_EnterTeamPass2 ++ [{PassId, NewEnterTimes}],
% 			NewTL = TL#role_times_log{
% 						date = Today, % 这里勿忘更新设置日期!!
% 						tl_enter_team_pass = NewTL_EnterTeamPass
% 						},
% 			% 通过cast的方式更新到玩家状态
% 			gen_server:cast(R#ets_online.pid, {'SET_ONE_DAY_TIMES_LOG', NewTL})
% 	end.
% 	