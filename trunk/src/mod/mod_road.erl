%%%-------------------------------------- 
%%% @Module: mod_road
%%% @Author: wujc
%%% @Created: 2018.7.4
%%% @Description: 取经之路
%%%--------------------------------------

-module(mod_road).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).


-export([
		 start_link/0,
		 get_road_from_ets/1,
		 add_road_to_ets/1,
		 update_road_to_ets/1,
		 del_road_from_ets/1,
		 load_road_info_from_db/1,
		 handle_battle_road_feedback/2
		
		]).
-compile(export_all).


-include("record.hrl"). 
-include("road.hrl").
-include("ets_name.hrl").
-include("debug.hrl").
-include("common.hrl").
-include("record/battle_record.hrl").

-record(state, {
				}).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).


init([]) ->
    process_flag(trap_exit, true),
    State = #state{},
    {ok, State}.


handle_call(_Request, _From, State) ->
    {reply, State, State}.

handle_info(_Info, State) ->
    {noreply, State}.

handle_cast(Request, State) ->
	try
		do_handle_cast(Request, State)
	catch 
		Error:Reason ->
			?ERROR_MSG("{Error, Reason, erlang:get_stacktrace()} : ~p~n", [{Error, Reason, erlang:get_stacktrace()}]),
			{noreply, State}
	end.


do_handle_cast({'road_feedback', _TargetId, Result, PlayerId}, State) ->
    RoadData = mod_road:get_road_from_ets(PlayerId),	
	PartnerInfo = RoadData#road_info.partner_info,
	PkInfo = RoadData#road_info.pk_info,

	case Result of
		win -> 
			LastPoint = RoadData#road_info.now_point ,
			RoadData2 =
		    case RoadData#road_info.now_point =:= 4 orelse RoadData#road_info.now_point =:= 7   of
				true ->db:update(PlayerId, road, [{player_power,0}], 
									  [{player_id, PlayerId }]),		
					RoadData#road_info{now_point = (LastPoint + 1), player_power = 0};
						
				
				false ->  RoadData#road_info{ now_point = (LastPoint + 1) }
			end,
			
			case LastPoint =:= 10 of
				true ->mod_broadcast:send_sys_broadcast(393, [player:get_name(PlayerId)]);
				false -> skip
			end,
			
			mod_road:update_road_to_ets(RoadData2);
		_ -> 
			MyNowBattlePar = RoadData#road_info.now_battle_partner,
			
			F = fun(X) ->
						{Id,_Hp,_Mp,MaxHp,MaxMp,IsMain} = X,
						{Id, 0, 0,MaxHp,MaxMp,IsMain}
				end,
			NewMyNowBattlePar = [F(X) || X <- MyNowBattlePar ],
			
			
	        F2 = fun({Id2,Hp2,Mp2,MaxHp2,MaxMp2,_IsMain},Acc2) ->
						 lists:keyreplace(Id2, 1, Acc2, {Id2,Hp2,Mp2,MaxHp2,MaxMp2})
				 end,
						 
	        NewPartnerInfo=  lists:foldl(F2, PartnerInfo, NewMyNowBattlePar),
			
			RoadData2 = RoadData#road_info{ now_battle_partner = NewMyNowBattlePar,partner_info = NewPartnerInfo},
			mod_road:update_road_to_ets(RoadData2)
	end,
	{ok, Bin} = pt_38:write(38002, [1]),
	lib_send:send_to_sock(player:get_PS(PlayerId), Bin),
	db:update(PlayerId, road, [ {now_point,RoadData2#road_info.now_point} ,{now_battle_partner,util:term_to_bitstring(RoadData2#road_info.now_battle_partner)},
								{partner_info,util:term_to_bitstring(RoadData2#road_info.partner_info)} , 
								{pk_info,util:term_to_bitstring(PkInfo) }], 
			  [{player_id, PlayerId}]),
	{noreply, State};



do_handle_cast(_Msg, State) ->
    {noreply, State}.

handle_battle_road_feedback(ChallengerID, FeedBack) ->
    case FeedBack#btl_feedback.oppo_player_id_list of
        [] -> error;
        [TargetId | _] -> gen_server:cast(?MODULE, {'road_feedback', TargetId, FeedBack#btl_feedback.result, ChallengerID})
    end.


terminate(Reason, _State) ->
    ?TRACE("[mod_scene_mgr] terminate for reason: ~w~n", [Reason]),
    case Reason of
        normal -> skip;
        shutdown -> skip;
        {shutdown, _} -> skip;
        _ ->
            ?ERROR_MSG("[~p] !!!!!terminate!!!!! for reason: ~w", [?MODULE, Reason])
    end,
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.


del_road_from_ets(PlayerId) ->
    ets:delete(?ETS_ROAD_INFO, PlayerId).
    
    
get_road_from_ets(PlayerId) ->
    case ets:lookup(?ETS_ROAD_INFO, PlayerId) of
        [] -> 
            null;
        [R] ->
            R
    end.



add_road_to_ets(RoadEts) when is_record(RoadEts, road_info) ->
    ets:insert(?ETS_ROAD_INFO, RoadEts).


update_road_to_ets(RoadEts) when is_record(RoadEts, road_info) ->
    ets:insert(?ETS_ROAD_INFO, RoadEts).

load_road_info_from_db(PlayerId) ->
	case db:select_row(road, "now_point, get_point, reset_times,now_battle_partner,partner_info,player_power,pk_info,unix_time", [{player_id, PlayerId}], [], [1]) of
		[] -> skip;
        [NowPoint,GetPoint,ResetTimes,NowBattlePartner0,PartnerInfo0,PlayerPower,PkInfo0,UnixTime] ->
			      NowBattlePartner = util:bitstring_to_term(NowBattlePartner0),
				  PartnerInfo = util:bitstring_to_term(PartnerInfo0),	  		
				  PkInfo = util:bitstring_to_term(PkInfo0), %十个对手
			      Road = #road_info{player_id = PlayerId,now_point=NowPoint,get_point =util:bitstring_to_term(GetPoint),
									reset_times =ResetTimes, partner_info = PartnerInfo,now_battle_partner = NowBattlePartner,
									player_power = PlayerPower, pk_info = PkInfo,unix_time = UnixTime },
				  update_road_to_ets(Road),
                  [NowPoint,ResetTimes,util:bitstring_to_term(GetPoint) ,UnixTime]
	end.



