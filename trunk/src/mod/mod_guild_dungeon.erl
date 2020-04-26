%%%-------------------------------------- 
%%% @Module: mod_guild_dungeon
%%% @Author: wujc
%%% @Created: 2018.8.23
%%% @Description: 帮派副本
%%%--------------------------------------



-module(mod_guild_dungeon).
-behaviour(gen_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([
		  start_link/0,
		
		  del_guild_dungeon_point_from_ets/1,
		  del_guild_person_from_ets/1,
		  
		  get_guild_dungeon_point_from_ets/1,
		  get_guild_person_from_ets/1,
		  
		  add_guild_dungeon_point_to_ets/1,
		  add_guild_person_to_ets/1,
		  
		  update_guild_dungeon_point_to_ets/1,
		  update_guild_person_to_ets/1,
		  start_timer/1,
		  refresh_mon/1,
		  refresh_boss/1,
		  finish_boss/1,
		  quit_boss/1,
		  challage_guild_dungeon_boss/3,
		  for_list_count/5,
	      handle_fight_callback/2
		]).
-compile(export_all).


-include("record.hrl"). 
-include("ets_name.hrl").
-include("debug.hrl").
-include("common.hrl").
-include("guild_dungeon.hrl").
-include("prompt_msg_code.hrl").
-include("record/battle_record.hrl").
-include("monopoly.hrl").
-include("damijing.hrl").


-record(state, {}).

start_link() ->
	 gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init([]) ->
    ?TRACE("[mod_guild_dungeon] init()...~n"),
    process_flag(trap_exit, true),
	State = #state{},
	lib_guild_dungeon:server_start_init(),
    {ok, State}.


handle_call(Request, From, State) ->
	try
		do_handle_call(Request, From, State)
	catch 
		Error:Reason ->
			?ERROR_MSG("{Error, Reason, .erlang:get_stacktrace()} : ~p~n", [{Error, Reason, erlang:get_stacktrace()}]),
			{reply, State, State}
	end.


%% 创建帮派副本场景进程
do_handle_call({'create_point_scene', GuildWeek,Point}, _From, State) ->
	%% 再判断一次场景是否已存在
	case lib_guild_dungeon:check_point_scnene_exits(GuildWeek) of
		?false ->
			
			SceneNo = (data_guild_new_dungeon:get(Point))#guild_new_dungeon.map_no , %帮派副本表 
			case mod_scene:create_scene(SceneNo) of
				fail ->
					?ASSERT(false, SceneNo),
					{reply, fail, State};
				{ok, SceneId} ->
					#guild_new_dungeon{
					 target = Target,
					 position = Position} = data_guild_new_dungeon:get(Point),
					case Point =:= 7 of
						true ->
							{ok, PointData} = lib_guild_dungeon:get_point(GuildWeek),
							KillCount = PointData#guild_dungeon_point.kill_count,
							case KillCount =:= 20 of
								true ->
									GuildDungeonData = data_guild_new_dungeon:get(Point),
									{X,Y}  = GuildDungeonData#guild_new_dungeon.boss_position,
									mod_scene:spawn_mon_to_scene_for_public_WNC(35171,SceneId, X, Y);
								false ->
									F = fun({Type, Mon, Count}) ->
												case Mon =/= 35171  of %Boss要特殊处理
													true ->
														for_list_count(Type,Count,Mon,SceneId,Position);
													false -> skip
												end
										end,
									lists:foreach(F, Target)
							end;
						false ->
							
									
							F = fun({Type, Mon, Count}) ->
										case Mon =/= 35171  of %Boss要特殊处理
											true ->
												for_list_count(Type,Count,Mon,SceneId,Position);
											false -> skip
										end
								end,
							lists:foreach(F, Target)
					end,
					%刷怪出来
					ets:update_element(?ETS_GUILD_POINT_INFO, GuildWeek, [{#guild_dungeon_point.guild_scene_id, SceneId}]),
					ets:insert(?ETS_GUILD_DUNGEON_SCENE, {SceneId, GuildWeek}),
					{reply, {ok, SceneId}, State#state{}}
			end;
		?true ->
			[#guild_dungeon_point{guild_scene_id = SceneId}] = ets:lookup(?ETS_GUILD_POINT_INFO, GuildWeek),
			{reply, {ok, SceneId}, State}
	end;

do_handle_call(_Request, _From, State) ->
    {reply, State, State}.


for_list_count(_Type,0,_MonNo,_SceneId,_Position) ->
	skip;

for_list_count(Type,Count,MonNo,SceneId, Position1) ->
	{X,Y} = list_util:rand_pick_one(Position1),
	Position = lists:keydelete(X, 1, Position1),
	case Type of
		2 ->
			
			case mod_scene:spawn_mon_to_scene_for_public_WNC(MonNo, SceneId, X, Y) of
				{_, MonId} ->
					for_list_count(Type,Count-1,MonNo,SceneId,Position),
					{ok, MonId};
				fail ->
					?ERROR_MSG("refresh mon error {MonNo, SceneId, X, Y}: ~p~n", [{MonNo, SceneId, X, Y}])
			end;
		1->
			case mod_scene:spawn_dynamic_npc_to_scene_WNC(MonNo, SceneId, X, Y) of
				{_, MonId} ->
					for_list_count(Type,Count-1,MonNo,SceneId,Position),
					{ok, MonId};
				fail ->
					?ERROR_MSG("refresh mon error {MonNo, SceneId, X, Y}: ~p~n", [{MonNo, SceneId, X, Y}])
			end
	end.

	
	


handle_cast(Request, State) ->
	try
		do_handle_cast(Request, State)
	catch 
		Error:Reason ->
			?ERROR_MSG("{Error, Reason, erlang:get_stacktrace()} : ~p~n", [{Error, Reason, erlang:get_stacktrace()}]),
			{noreply, State}
	end.


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

do_handle_info({timeout, _TimerRef, {point,SceneId,GuildWeek}}, State) ->
	IdList = lib_scene:get_scene_player_ids(SceneId),
	F2 = fun(X) ->
				 case player:is_battling(player:get_PS(X)) of
					 true -> catch mod_battle:force_end_battle(player:get_PS(X));
					 false -> skip
				 end,
				 lib_dungeon:quit_dungeon(player:get_PS(X))
		end,
	lists:foreach(F2,IdList ),
	mod_scene:clear_scene(SceneId),
	ets:update_element(?ETS_GUILD_POINT_INFO, GuildWeek, [{#guild_dungeon_point.guild_scene_id, 0}]),
	{noreply, State};

do_handle_info({timeout, _TimerRef, {refresh,Type,No,Point,SceneId}}, State) ->
	GuildDungeonData = data_guild_new_dungeon:get(Point),
	{X,Y}  = list_util:rand_pick_one(GuildDungeonData#guild_new_dungeon.position),	
	case Type of
		1 ->mod_scene:spawn_dynamic_npc_to_scene_WNC(No, SceneId, X, Y);
		_ ->mod_scene:spawn_mon_to_scene_for_public_WNC(No,SceneId, X, Y)
	end,

	{noreply, State};

do_handle_info({timeout, _TimerRef, { boss, No,Point ,SceneId} }, State) ->
	GuildDungeonData = data_guild_new_dungeon:get(Point),
	{X,Y}  = GuildDungeonData#guild_new_dungeon.boss_position,
	mod_scene:spawn_mon_to_scene_for_public_WNC(No,SceneId, X, Y),
	{noreply, State};

do_handle_info({timeout, _TimerRef, { finishboss ,SceneId} }, State) ->
	IdList = lib_scene:get_scene_player_ids(SceneId),
	F2 = fun(X) ->
				 case player:is_battling(player:get_PS(X)) of
					 true -> catch mod_battle:force_end_battle(player:get_PS(X));
					 false -> skip
				 end
		end,
	lists:foreach(F2,IdList ),
	{noreply, State};

do_handle_info({timeout, _TimerRef, { quitboss ,SceneId, GuildWeek} }, State) ->
	IdList = lib_scene:get_scene_player_ids(SceneId),
	F2 = fun(X) ->
				 case player:is_battling(player:get_PS(X)) of
					 true -> catch mod_battle:force_end_battle(player:get_PS(X));
					 false -> skip
				 end,
				 lib_dungeon:quit_dungeon(player:get_PS(X))
		end,
	lists:foreach(F2,IdList ),
	mod_scene:clear_scene(SceneId),
	ets:update_element(?ETS_GUILD_POINT_INFO, GuildWeek, [{#guild_dungeon_point.guild_scene_id, 0}]),
	{noreply, State};
	
do_handle_info(_Info, State) ->
    {noreply, State}.


terminate(Reason, _State) ->
    ?TRACE("[mod_guild_dungeon] terminate for reason: ~w~n", [Reason]),
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





del_guild_dungeon_point_from_ets(GuildWeek) ->
    ets:delete(?ETS_GUILD_POINT_INFO, GuildWeek).

del_guild_person_from_ets(PlayerId) ->
    ets:delete(?ETS_GUILD_PERSON_INFO, PlayerId).
   



get_guild_dungeon_point_from_ets(GuildWeek) ->
    case ets:lookup(?ETS_GUILD_POINT_INFO, GuildWeek) of
        [] -> 
            null;
        [R] ->
            R
    end.


get_guild_person_from_ets(PlayerId) ->
    case ets:lookup(?ETS_GUILD_PERSON_INFO, PlayerId) of
        [] -> 
            null;
        [R] ->
            R
    end.





add_guild_dungeon_point_to_ets(GDP) when is_record(GDP, guild_dungeon_point) ->
    ets:insert(?ETS_GUILD_POINT_INFO, GDP).

add_guild_person_to_ets(GP) when is_record(GP, guild_person) ->
    ets:insert(?ETS_GUILD_PERSON_INFO, GP).






update_guild_dungeon_point_to_ets(GDP) when is_record(GDP, guild_dungeon_point) ->
    ets:insert(?ETS_GUILD_POINT_INFO, GDP).

update_guild_person_to_ets(GP) when is_record(GP, guild_person) ->
    ets:insert(?ETS_GUILD_PERSON_INFO, GP).

%% 挑战帮派副本BOSS
challage_guild_dungeon_boss(_BossNo, BossId, Status) ->
	PlayerId = player:get_id(Status),
	GuildId = player:get_guild_id(PlayerId),
	GuildPoint = list_to_integer(lists:concat([GuildId,7]) ),
	GuildData = data_guild_new_dungeon:get(7),
	InitHp = GuildData#guild_new_dungeon.boss_hp,
	{ok,GuildInfo} = lib_guild_dungeon:get_point(GuildPoint),
	CurHp = InitHp - GuildInfo#guild_dungeon_point.boss_hp,
	case CurHp =:= 0 of
		true ->
			lib_send:send_prompt_msg(Status, ?PM_BT_TARGET_BO_ALRDY_DEAD);
		false ->mod_battle:start_guild_dungeon_boss(Status, mod_mon:get_obj(BossId), CurHp)
	end.



start_timer(Msg) ->
	erlang:start_timer(1000 * 40, ?MODULE, Msg).

refresh_mon(Msg) ->
	erlang:start_timer(1000 * 1, ?MODULE, Msg).

refresh_boss(Msg) ->
	erlang:start_timer(1000 * 5, ?MODULE, Msg).

finish_boss(Msg) ->
	erlang:start_timer(1000 * 1, ?MODULE, Msg).

quit_boss(Msg) ->
	erlang:start_timer(1000 * 60, ?MODULE, Msg).



%% @para: 帮派副本场景
%% @return：fail | {ok, NewSceneId}
create_point_scene(GuildWeek,Point) ->
    case catch gen_server:call(?MODULE, {'create_point_scene', GuildWeek,Point}) of
        {'EXIT', Reason} ->
            ?ERROR_MSG("[mod_guild_dungeon_mgr] create_home failed!! GuildWeek :~p, Reason: ~w", [GuildWeek, Reason]),
            ?ASSERT(false, {GuildWeek, Reason}),
            fail;
        fail ->
            fail;
        {ok, NewSceneId} when is_integer(NewSceneId) ->
            {ok, NewSceneId}
    end.

%%大富翁玩法战斗回调
handle_fight_callback(Player,FeedBack) ->
%%    RewardList = FeedBack#btl_feedback.shuffled_team_mb_list,
	Goods =  data_monopoly_monreward:get(FeedBack#btl_feedback.bmon_group_no),
	Rewards = lists:nth(1,Goods#monopoly_monreward.reward),
	RewardNum = lists:nth(2,Goods#monopoly_monreward.reward),
	BindState = lists:nth(3,Goods#monopoly_monreward.reward),
	io:format("Player====~p~n",[Player]),
	%%战斗胜利发放奖励，失败无奖励
    case FeedBack#btl_feedback.result of
        win ->
				mod_inv:batch_smart_add_new_goods(Player, [{Rewards,RewardNum}], [{bind_state, BindState}], ["lib_luck", "rich_fight_reward"]),
				{ok, Bin} =pt_54:write(54108, [ Rewards , RewardNum]),
				lib_send:send_to_sock(player:get_PS(Player), Bin);
        _   ->
            skip
    end.

%%大秘境玩法战斗回调
handle_mystery_callback(Player,FeedBack) ->
%%    RewardList = FeedBack#btl_feedback.shuffled_team_mb_list,
	io:format("Player====~p~n",[Player]),
	%%战斗胜利发放奖励，失败无奖励
	case FeedBack#btl_feedback.result of
		win ->
			lib_mystery:mystery_fight_callback(Player);
		_   ->
			PlyMisc = ply_misc:get_player_misc(Player),
			MonInfo = PlyMisc#player_misc.mijing_record,
			%% 是否重置
			case MonInfo of
				[] ->
					case player:is_in_team(Player) of
						true ->
							case player:is_leader(Player) of
								true ->
									{ok, Bin} =pt_50:write(50021, [ 1 ]),
									lib_send:send_to_sock(player:get_PS(Player), Bin);
								false ->skip
							end;
						false ->
							{ok, Bin} =pt_50:write(50021, [ 1 ]),
							lib_send:send_to_sock(player:get_PS(Player), Bin)
					end;
				_  ->
					Level = MonInfo#mystery_mon_info.level,
					{ok, Bin} =pt_50:write(50004, [ Level, 0, 0, MonInfo#mystery_mon_info.no]),
					lib_send:send_to_sock(player:get_PS(Player), Bin)
			end
	end.

%%大秘境玩法战斗回调
handle_mirage_callback(Player,FeedBack) ->
	%%战斗胜利发放奖励，失败无奖励
	case FeedBack#btl_feedback.result of
		win ->
			lib_mystery:mirage_fight_callback(Player);
		_   ->
			PlyMisc = ply_misc:get_player_misc(Player),
			MonInfo = PlyMisc#player_misc.huanjing_record,
			%% 是否重置
			case MonInfo of
				[] ->
					case player:is_in_team(Player) of
						true ->
							case player:is_leader(Player) of
								true ->
									{ok, Bin} =pt_50:write(50021, [ 2 ]),
									lib_send:send_to_sock(player:get_PS(Player), Bin);
								false ->skip
							end;
						false ->
							{ok, Bin} =pt_50:write(50021, [ 2 ]),
							lib_send:send_to_sock(player:get_PS(Player), Bin)
					end;
				_  ->
					Level = MonInfo#mystery_mon_info.level,
					{ok, Bin} =pt_50:write(50014, [ Level, 0, 0, MonInfo#mystery_mon_info.no]),
					lib_send:send_to_sock(player:get_PS(Player), Bin)
			end
	end.

%% load_road_info_from_db(PlayerId) ->
%% 	case db:select_row(road, "now_point, get_point, reset_times,now_battle_partner,partner_info,player_power,pk_info,unix_time", [{player_id, PlayerId}], [], [1]) of
%% 		[] -> skip;
%%         [NowPoint,GetPoint,ResetTimes,NowBattlePartner0,PartnerInfo0,PlayerPower,PkInfo0,UnixTime] ->
%% 			      NowBattlePartner = util:bitstring_to_term(NowBattlePartner0),
%% 				  PartnerInfo = util:bitstring_to_term(PartnerInfo0),	  		
%% 				  PkInfo = util:bitstring_to_term(PkInfo0), %十个对手
%% 			      Road = #road_info{player_id = PlayerId,now_point=NowPoint,get_point =util:bitstring_to_term(GetPoint),
%% 									reset_times =ResetTimes, partner_info = PartnerInfo,now_battle_partner = NowBattlePartner,
%% 									player_power = PlayerPower, pk_info = PkInfo,unix_time = UnixTime },
%% 				  update_road_to_ets(Road),
%%                   [NowPoint,ResetTimes,util:bitstring_to_term(GetPoint) ,UnixTime]
%% 	end.

%% handle_battle_road_feedback(ChallengerID, FeedBack) ->
%%     case FeedBack#btl_feedback.oppo_player_id_list of
%%         [] -> error;
%%         [TargetId | _] -> gen_server:cast(?MODULE, {'road_feedback', TargetId, FeedBack#btl_feedback.result, ChallengerID})
%%     end.

