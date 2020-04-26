%%%------------------------------------
%%% @Module  : mod_home
%%% @Author  : 
%%% @Email   : 
%%% @Created : 2018.5.24  -- zhengjy
%%% @Description: 家园进程
%%%------------------------------------
-module(mod_home).
-behaviour(gen_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3,handle_steal_feedback/2]).
-export([
        start_link/0,
        create_home/1,
		add_home_timer/4,
		add_home_timer/5,
		add_mon_timer/5,
		handle_battle_road_feedback/2
        ]).

-include("common.hrl").
-include("record.hrl").
-include("scene.hrl").
-include("monster.hrl").
-include("ets_name.hrl").
-include("npc.hrl").
-include("road.hrl").
-include("pt_12.hrl").
-include("pt_38.hrl").
-include("abbreviate.hrl").
-include("home.hrl").
-include("record/battle_record.hrl").
-include("goods.hrl").
-include("log.hrl").
-include("prompt_msg_code.hrl").
-include("pt_37.hrl").



-record(state, {
				timer_home = [],			%% 需要定时检查刷怪的家园场景
				timer_monster = []			%% 检查怪物消失时偷菜？
				}).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).
    


%% 创建家园进程TODO：在这里处理场景的创建和回收？
%% @para: SceneNo => 场景编号
%% @return：fail | {ok, NewSceneId}
create_home(PlayerId) ->
    case catch gen_server:call(?MODULE, {'create_home', PlayerId}) of
        {'EXIT', Reason} ->
            ?ERROR_MSG("[mod_home_mgr] create_home failed!! PlayerId :~p, Reason: ~w", [PlayerId, Reason]),
            ?ASSERT(false, {PlayerId, Reason}),
            fail;
        fail ->
            fail;
        {ok, NewSceneId} when is_integer(NewSceneId) ->
            {ok, NewSceneId}
    end.


%% 加入定时检查队列
add_home_timer(PlayerId, Type, No, RipeUnixtime) ->
	add_home_timer(PlayerId, Type, No, RipeUnixtime, 0).


add_home_timer(PlayerId, Type, No, RipeUnixtime, AbandonUnixtime) ->
	gen_server:cast(?MODULE, {add_home_timer, PlayerId, Type, No, RipeUnixtime, AbandonUnixtime}).



add_mon_timer(PlayerId, Type, No, MonId, RipeUnixtime) ->
	gen_server:cast(?MODULE, {add_mon_timer, PlayerId, Type, No, MonId, RipeUnixtime}).



%% ===================================================================================================================

init([]) ->
    ?TRACE("[mod_scene_mgr] init()...~n"),
    process_flag(trap_exit, true),
	lib_home:server_start_init(),
	start_timer(),
    State = #state{timer_home = []},
    {ok, State}.

handle_call(Request, From, State) ->
	try
		do_handle_call(Request, From, State)
	catch 
		Error:Reason ->
			?ERROR_MSG("{Error, Reason, erlang:get_stacktrace()} : ~p~n", [{Error, Reason, erlang:get_stacktrace()}]),
			{reply, State, State}
	end.
	

%% 创建家园进程
do_handle_call({'create_home', PlayerId}, _From, State) ->
	%% 再判断一次场景是否已存在
	case lib_home:check_home_scnene_exits(PlayerId) of
		?false ->
			SceneNo = data_special_config:get(home_map),
			case mod_scene:create_scene(SceneNo) of
				fail ->
					?ASSERT(false, SceneNo),
					{reply, fail, State};
				{ok, SceneId} ->
					ets:update_element(?MY_ETS_HOME(PlayerId), PlayerId, [{#home.scene_id, SceneId}]),
					ets:insert(?ETS_HOME_SCENE, {SceneId, PlayerId}),
					{reply, {ok, SceneId}, State#state{}}
			end;
		?true ->
			[#home{scene_id = SceneId}] = ets:lookup(?MY_ETS_HOME(PlayerId), PlayerId),
			{reply, {ok, SceneId}, State}
	end;


do_handle_call(_Request, _From, State) ->
    {reply, State, State}.

% %% 统一模块+过程调用(cast)
% do_handle_cast({apply_cast, Module, Method, Args}, State) ->
% 	case (catch apply(Module, Method, Args)) of
% 		 {'EXIT', Info} ->	
% 			 ?WARNING_MSG("mod_scene__apply_cast error: Module=~p, Method=~p, Reason=~p",[Module, Method, Info]),
% 			 error;
% 		 _ -> skip
% 	end,
%     {noreply, State};


handle_cast(Request, State) ->
	try
		do_handle_cast(Request, State)
	catch 
		Error:Reason ->
			?ERROR_MSG("{Error, Reason, erlang:get_stacktrace()} : ~p~n", [{Error, Reason, erlang:get_stacktrace()}]),
			{noreply, State}
	end.


do_handle_cast({add_home_timer, PlayerId, Type, No, RipeUnixtime, AbandonUnixtime}, #state{timer_home = TimerHome} = State) ->
	Key = {PlayerId, Type, No},
	NewTimerHome = 
		case lists:keytake(RipeUnixtime, 1, TimerHome) of
			{value, {RipeUnixtime, PlayerIds}, TimerHome2} ->
				PlayerIds2 = [Key|lists:delete(Key, PlayerIds)],
				[{RipeUnixtime, PlayerIds2}|TimerHome2];
			false ->
				[{RipeUnixtime, [Key]}|TimerHome]
		end,
	NewTimerHome3 = 
		case lists:keytake(AbandonUnixtime, 1, NewTimerHome) of
			{value, {AbandonUnixtime, APlayerIds}, NewTimerHome2} ->
				APlayerIds2 = lists:delete(Key, APlayerIds),
				[{AbandonUnixtime, APlayerIds2}|NewTimerHome2];
			false ->
				NewTimerHome
		end,
	{noreply, State#state{timer_home = NewTimerHome3}};


%% 加入到点检查怪物
do_handle_cast({add_mon_timer, PlayerId, Type, No, MonId, RipeUnixtime}, #state{timer_monster = TimerMonster} = State) ->
	Key = {PlayerId, Type, No, MonId},
	NewTimerMonster = 
		case lists:keytake(RipeUnixtime, 1, TimerMonster) of
			{value, {RipeUnixtime, PlayerIds}, TimerMonster2} ->
				PlayerIds2 = [Key|lists:delete(Key, PlayerIds)],
				[{RipeUnixtime, PlayerIds2}|TimerMonster2];
			false ->
				[{RipeUnixtime, [Key]}|TimerMonster]
		end,
	{noreply, State#state{timer_monster = NewTimerMonster}};

do_handle_cast({'steal_home', HomeId, Stealer }, State) ->

	gen_server:cast(player:get_pid(Stealer), {v, HomeId}),
	
	{noreply, State};


do_handle_cast({'steal_feedback', HomeId, Result, PlayerId}, State) ->
    try
        case Result of
            win ->  handle_steal_win(HomeId, PlayerId);
			_ -> Home_id = lib_home:get_home_id_from_ets(PlayerId),
				 Home_Id_C = Home_id#home_id{battle_result=0},
				 lib_home:add_home_id_to_ets(Home_Id_C)
        end
    catch 
        _:_ -> ?ERROR_MSG("[mod_home] steal_feedback error", [])
    end,
    {noreply, State};

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
				true ->mod_achievement:notify_achi(pass_qujing, [{num, 10}], player:get_PS(PlayerId)), mod_broadcast:send_sys_broadcast(393, [player:get_name(PlayerId)]);
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
	{ok, Bin} = pt_38:write(?PT_START_BATTLE, [1]),
	lib_send:send_to_sock(player:get_PS(PlayerId), Bin),
	db:update(PlayerId, road, [ {now_point,RoadData2#road_info.now_point} ,{now_battle_partner,util:term_to_bitstring(RoadData2#road_info.now_battle_partner)},
								{partner_info,util:term_to_bitstring(RoadData2#road_info.partner_info)} , 
								{pk_info,util:term_to_bitstring(PkInfo) }], 
			  [{player_id, PlayerId}]),
	{noreply, State};



do_handle_cast(_Msg, State) ->
    {noreply, State}.


handle_info(Request, State) ->
	try
		do_handle_info(Request, State)
	catch 
		Error:Reason ->
			?ERROR_MSG("{Error, Reason} : ~p~n", [{erlang:get_stacktrace(), Error, Reason}]),
			{reply, State, State}
	end.

%%定时刷怪
do_handle_info({timeout, _TimerRef, timer}, #state{timer_home = TimerHome, timer_monster = TimerMonster} = State) ->
	start_timer(),
%% 	io:format("TimerHome : ~p~n", [{TimerHome, ?LINE}]),
	TimeNow = util:unixtime(),
	Fun = fun({RipeUnixtime, PlayerIds}, {AccDo, AccLack}) ->
				  case RipeUnixtime =< TimeNow of
					  true ->
						  {lists:append(AccDo, PlayerIds), AccLack};
					  false ->
						  {AccDo, [{RipeUnixtime, PlayerIds}|AccLack]}
				  end
		  end,
	State2 = 
		case lists:foldl(Fun, {[], []}, TimerHome) of
			{[], _} ->
				State;
			{DealPlayerIds, TimerHome2} ->
				refresh_mon(DealPlayerIds, TimeNow),
				State#state{timer_home = TimerHome2}
		end,
	case lists:foldl(Fun, {[], []}, TimerMonster) of
		{[], _} ->
			{noreply, State2};
		{DealPlayerIdsM, TimerMonster2} ->?DEBUG_MSG("TimerMonster:~p~n",[{TimerMonster,DealPlayerIdsM, TimerMonster2}]),
			mon_steal(DealPlayerIdsM, TimeNow),
	        {noreply, State2#state{timer_monster = TimerMonster2}}
	end;

do_handle_info(Info, State) ->
    {noreply, State}.


handle_steal_win(HomeId, PlayerId) ->
	case lib_home:get_home(HomeId) of
		{ok, _} ->
			Home_id = lib_home:get_home_id_from_ets(PlayerId),
			Type = Home_id#home_id.type,
			No = Home_id#home_id.no,
			Home_Id_C = Home_id#home_id{battle_result=1},
			lib_home:add_home_id_to_ets(Home_Id_C),
			case lib_home:get_home_data(HomeId, Type, No) of
				{ok, HomeData} ->
					case HomeData#home_data.is_steal =:= 0 of
						true ->
							case lib_home:check_grid_state(HomeData) of
								{ok, ?HOME_DATA_STATE_RIPE} ->
									RewardGoodsNo = 
										case HomeData#home_data.reward_lvlup of
											0 ->
												HomeData#home_data.goods_no;
											_ ->
												HomeData#home_data.reward_lvlup
										end, 
									Fun = fun(E) -> E =:= HomeId end,
									L = lists:filter(Fun,ply_relation:get_friend_id_list(player:get_PS(PlayerId))),%不为空表示双方为好友
									Count = case HomeData#home_data.reward_multi > 0 of
												true -> 
                                                    case L of
														[_L] ->
													         util:ceil(HomeData#home_data.reward_multi * (data_home_production:get(HomeData#home_data.goods_no))#home_production.production_num * 0.4);
												        []  ->util:ceil(HomeData#home_data.reward_multi * (data_home_production:get(HomeData#home_data.goods_no))#home_production.production_num * 0.2)
													end;
												false ->
													case L of
														[_L] ->
													        util:ceil( (data_home_production:get(HomeData#home_data.goods_no))#home_production.production_num *0.4 );
												        []  ->util:ceil( (data_home_production:get(HomeData#home_data.goods_no))#home_production.production_num *0.2 )
													end
													
											end,
									mod_inv:batch_smart_add_new_goods(PlayerId, [{RewardGoodsNo, Count}], [{bind_state, ?BIND_ALREADY}], [?LOG_HOME, "harvest"]),
									NewHomeData = HomeData#home_data{ is_steal =1},
									lib_home:update_home_data(HomeData,NewHomeData);

								_ ->
									{fail, ?PM_HOME_GRID_DO_BAN}
							end;
								false ->
									{fail,?PM_HOME_GOODS_IS_STEAL}
							end;
						false ->
							{fail, ?PM_HOME_GRID_DO_BAN}
					end;
				false ->
					{fail, ?PM_HOME_NOT_YET}
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



start_timer() ->
	erlang:start_timer(1000, self(), timer).


refresh_mon(DealPlayerIds, TimeNow) ->
	Fun = fun({PlayerId, Type, No}) ->
				  lib_home:refresh_mon(PlayerId, Type, No, TimeNow)
		  end,
	lists:foreach(Fun, DealPlayerIds).

handle_steal_feedback(Hijacker, FeedBack) ->
    case FeedBack#btl_feedback.oppo_player_id_list of
        [] -> error;
        [TargetId | _] -> gen_server:cast(?MODULE, {'steal_feedback', TargetId, FeedBack#btl_feedback.result, Hijacker})
    end.

handle_battle_road_feedback(ChallengerID, FeedBack) ->
    case FeedBack#btl_feedback.oppo_player_id_list of
        [] -> error;
        [TargetId | _] -> gen_server:cast(?MODULE, {'road_feedback', TargetId, FeedBack#btl_feedback.result, ChallengerID})
    end.




mon_steal(DealPlayerIds, TimeNow) ->
	Fun = fun({PlayerId, Type, No, MonId}) ->?DEBUG_MSG("DealPlayerIds:~p~n",[DealPlayerIds]),
				  lib_home:mon_steal(PlayerId, Type, No, MonId, TimeNow)
		  end,
	lists:foreach(Fun, DealPlayerIds).





