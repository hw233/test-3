%%%------------------------------------
%%% @Module  : mod_guild_party
%%% @Author  : zhangwq
%%% @Email   :
%%% @Created : 2014.3.28
%%% @Description: server 用于同步处理帮派宴会
%%%------------------------------------


-module(mod_guild_party).
-behaviour(gen_server).
-export([start_link/1]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-export([
        stop/0,
        refresh_script/2,               %% 为帮派活动执行脚本，例如刷怪等
        del_guild_dishes_and_mons/2,
        add_guild_reward_to_player/2,   %% 给在帮派宴会的玩家添加奖励buff，包括经验和钱
        add_first_dishes/3,             %% 给已经创建的帮派地图添加第一道菜
        player_add_guild_buff/6         %% 玩家给帮派成员加菜，添加玩家buff
    ]).


-include("guild.hrl").
-include("prompt_msg_code.hrl").
-include("ets_name.hrl").
-include("debug.hrl").
-include("abbreviate.hrl").
-include("common.hrl").
-include("log.hrl").
-include("pt_40.hrl").
-include("record/guild_record.hrl").
-include("obj_info_code.hrl").
-include("job_schedule.hrl").
-include("scene.hrl").

%% 帮派进程的内部状态 暂时没用
-record(state, {
        party_open = 0         % 0表示宴会没有开启，时间戳表示宴会开始时间
    }).


stop() ->
    gen_server:cast(?GUILD_PARTY_PROCESS, {'stop'}).


add_guild_reward_to_player(Guild, FirstAdd) ->
    Pid = erlang:whereis(?GUILD_PARTY_PROCESS),
    case is_pid(Pid) andalso is_process_alive(Pid) of
        false ->
            ?ASSERT(false),
            ?ERROR_MSG("mod_guild_party:error!~n", []);
        true ->
            gen_server:cast(?GUILD_PARTY_PROCESS, {'add_guild_reward_to_player', Guild, FirstAdd})
    end.


refresh_script(ScriptList, InfoList) ->
    Pid = erlang:whereis(?GUILD_PARTY_PROCESS),
    case is_pid(Pid) andalso is_process_alive(Pid) of
        false ->
            ?ASSERT(false),
            ?ERROR_MSG("mod_guild_party:error!~n", []);
        true ->
            gen_server:cast(?GUILD_PARTY_PROCESS, {'refresh_script', ScriptList, InfoList})
    end.


add_first_dishes(GuildId, SceneId, StartTime) ->
    Pid = erlang:whereis(?GUILD_PARTY_PROCESS),
    case is_pid(Pid) andalso is_process_alive(Pid) of
        false ->
            ?ASSERT(false),
            ?ERROR_MSG("mod_guild_party:error!~n", []);
        true ->
            gen_server:cast(?GUILD_PARTY_PROCESS, {'add_first_dishes', GuildId, SceneId, StartTime})
    end.


del_guild_dishes_and_mons(GuildId, SceneId) ->
    Pid = erlang:whereis(?GUILD_PARTY_PROCESS),
    case is_pid(Pid) andalso is_process_alive(Pid) of
        false ->
            ?ASSERT(false),
            ?ERROR_MSG("mod_guild_party:error!~n", []);
        true ->
            gen_server:cast(?GUILD_PARTY_PROCESS, {'del_guild_dishes_and_mons', GuildId, SceneId})
    end.


player_add_guild_buff(GuildId, SceneId, BuffNo, DelayTime, NewDynamicNpcId, DishesNo) ->
    Pid = erlang:whereis(?GUILD_PARTY_PROCESS),
    case is_pid(Pid) andalso is_process_alive(Pid) of
        false ->
            ?ASSERT(false),
            ?ERROR_MSG("mod_guild_party:error!~n", []);
        true ->
            gen_server:cast(?GUILD_PARTY_PROCESS, {'player_add_guild_buff', GuildId, SceneId, BuffNo, DelayTime, NewDynamicNpcId, DishesNo})
    end.


% -------------------------------------------------------------------------

start_link(TimeStamp) ->
    gen_server:start_link({local, ?GUILD_PARTY_PROCESS}, ?MODULE, [TimeStamp], []).


init([TimeStamp]) ->
    process_flag(trap_exit, true),

    NewState = #state{
                    party_open = TimeStamp
                },
    {ok, NewState}.


handle_call(Request, From, State) ->
    try
        handle_call_2(Request, From, State)
    catch
        Err:Reason ->
            ?ERROR_MSG("ERR:~p,Reason:~p",[Err,Reason]),
             {reply, error, State}
    end.



handle_call_2(_Request, _From, State) ->
    {reply, State, State}.

handle_cast(Request, State) ->
    try
        handle_cast_2(Request, State)
    catch
        Err:Reason ->
            ?ERROR_MSG("ERR:~p,Reason:~p",[Err,Reason]),
            {noreply, State}
    end.




handle_cast_2({'refresh_script', ScriptList, InfoList}, State) ->
    ?TRY_CATCH(refresh_script_for_guild(ScriptList, InfoList), ErrReason),
    {noreply, State};    


handle_cast_2({'add_first_dishes', GuildId, SceneId, StartTime}, State) ->
    ?TRY_CATCH(try_add_first_dishes(GuildId, SceneId, StartTime), ErrReason),
    {noreply, State};  


handle_cast_2({'add_guild_reward_to_player', Guild, FirstAdd}, State) ->
    ?TRY_CATCH(spawn(fun() -> add_reward_to_player(Guild, FirstAdd) end), ErrReason),
    {noreply, State};
          

handle_cast_2({'del_guild_dishes_and_mons', GuildId, SceneId}, State) ->
    % ?INFO_MSG("mod_guild_mgr:guild_party_end() ... ~n", []),
    ?TRY_CATCH(try_del_guild_dishes_and_mons(GuildId, SceneId), ErrReason),
    {noreply, State};  


handle_cast_2({'player_add_guild_buff', GuildId, SceneId, BuffNo, DelayTime, NewDynamicNpcId, DishesNo}, State) ->
    spawn(fun() -> try_player_add_guild_buff(SceneId, BuffNo, DelayTime) end),

    case lib_guild:get_party_from_ets(GuildId) of
        null ->
            ?ERROR_MSG("mod_guild_party:get_party_from_ets error!~n", []),
            skip;
        GuildParty ->
            NewDishnoList = 
                case lists:member(DishesNo, GuildParty#guild_party.dishes_no) of
                    true -> GuildParty#guild_party.dishes_no;
                    false -> [DishesNo | GuildParty#guild_party.dishes_no]
                end,
            lib_guild:update_party_to_ets(GuildParty#guild_party{dishes_no = NewDishnoList, dishes_npc = [NewDynamicNpcId | GuildParty#guild_party.dishes_npc]})
    end,
    {noreply, State};        

handle_cast_2({'stop'}, State) ->
    {stop, normal, State};


handle_cast_2(_Msg, State) ->
    {noreply, State}.


handle_info(Request, State) ->
    try
        handle_info_2(Request, State)
    catch
        Err:Reason->
            ?ERROR_MSG("ERR:~p,Reason:~p",[Err,Reason]),
             {noreply, State}
    end.

handle_info_2(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

% %%-------------------------------------------------------------------------------------------------


add_reward_to_player(Guild, FirstAdd) ->
    case Guild#guild.scene_id =:= ?INVALID_ID of
        true -> skip;
        false ->
            PlayerIds = lib_scene:get_scene_player_ids(Guild#guild.scene_id),
            F = fun(No, {Sum1, Sum2}) ->
                case No =:= ?GUILD_PARTY_DISHES_NO_1 of
                    true -> {Sum1, Sum2};
                    false ->
                        case data_guild_dishes:get(No) of
                            null -> {Sum1, Sum2};
                            Data -> {Sum1 + Data#guild_dishes.gamemoney_add, Sum2 + Data#guild_dishes.exp_add}
                        end
                end
            end,
            GuildParty = lib_guild:get_party_from_ets(Guild#guild.id),
            DishesNo = 
                case GuildParty =:= null of
                    true -> ?ASSERT(false), [];
                    false -> GuildParty#guild_party.dishes_no
                end,
            {RateMoney, RateExp} = lists:foldl(F, {0,0}, DishesNo),
            
            BuffNo = 
                case data_guild_dishes:get(?GUILD_PARTY_DISHES_NO_1) of
                    null -> ?INVALID_NO;
                    DataDishes -> DataDishes#guild_dishes.buff_no
                end,

            Now = svr_clock:get_unixtime(),
            F1 = fun(X) ->
                case player:get_PS(X) of
                    null -> skip;
                    PS ->
                        case FirstAdd of
                            false -> skip;
                            true -> 
                                case BuffNo =:= ?INVALID_NO of
                                    true -> skip;
                                    false -> 
                                        DelayTime = lib_guild:get_party_last_time() - (Now - GuildParty#guild_party.start_time),
                                        case DelayTime =< 0 of
                                            true -> skip;
                                            false -> gen_server:cast(player:get_pid(PS), {'player_add_buff', BuffNo, DelayTime})
                                        end
                                end
                        end,

                        {MoneyBase, ExpBase} = 
                            case data_guild_dishes:get(1) of
                                null -> {0, 0};
                                Cfg ->
                                    TMoneyBase = 
                                        case Cfg#guild_dishes.gamemoney_add of
                                            {1, TValueMoney} -> TValueMoney;
                                            _ -> 
                                                ?ASSERT(false, Cfg#guild_dishes.gamemoney_add),
                                                0
                                        end,
                                    TExpBase = 
                                        case Cfg#guild_dishes.exp_add of
                                            {1, TValueExp} -> TValueExp;
                                            {2, ConList} -> 
                                                case is_list(ConList) andalso length(ConList) > 0 of
                                                    true -> erlang:hd(ConList) * player:get_lv(PS);
                                                    false -> ?ASSERT(false, Cfg#guild_dishes.exp_add), 0
                                                end
                                        end,
                                    {TMoneyBase, TExpBase}
                            end,

                        MoneyAdd = util:ceil(MoneyBase * (1 + RateMoney/100))*mod_svr_mgr:get_server_reward_multi(18),
                        ExpAdd = util:ceil(ExpBase * (1 + RateExp/100))*mod_svr_mgr:get_server_reward_multi(18),

                        player:add_all_exp(PS, ExpAdd, [?LOG_GUILD, "party"]),
                        player:add_bind_gamemoney(PS, MoneyAdd, [?LOG_GUILD, "party"])
                end
            end,

            [F1(X) || X <- PlayerIds]
    end.


try_player_add_guild_buff(SceneId, BuffNo, DelayTime) ->
    PlayerIds = lib_scene:get_scene_player_ids(SceneId),
    F1 = fun(X) ->
        case player:get_PS(X) of
            null -> skip;
            PS ->
                gen_server:cast(player:get_pid(PS), {'player_add_buff', BuffNo, DelayTime})
        end
    end,

    [F1(X) || X <- PlayerIds].


try_add_first_dishes(GuildId, SceneId, StartTime) ->
    case SceneId =:= ?INVALID_ID of
        true -> skip;
        false ->
            case data_guild_dishes:get(?GUILD_PARTY_DISHES_NO_1) of
                null -> skip;
                DishesCfg ->
                    ?ASSERT(is_tuple(DishesCfg#guild_dishes.npc), DishesCfg#guild_dishes.npc),
                    NpcNo = element(1, DishesCfg#guild_dishes.npc),
                    X = element(2, DishesCfg#guild_dishes.npc),
                    Y = element(3, DishesCfg#guild_dishes.npc),
                    case mod_scene:spawn_dynamic_npc_to_scene_WNC(NpcNo, SceneId, X, Y) of
                        fail ->
                            ?ASSERT(false),
                            ?ERROR_MSG("mod_guild_mgr:try_add_guild_buff_npc error!~n", []);
                        {ok, NewDynamicNpcId} ->
                            lib_guild:add_party_to_ets(#guild_party{guild_id = GuildId, start_time = StartTime, 
                                dishes_npc = [NewDynamicNpcId], dishes_no = [?GUILD_PARTY_DISHES_NO_1]})
                    end
            end
    end.


try_del_guild_dishes_and_mons(GuildId, SceneId) ->
    case lib_guild:get_party_from_ets(GuildId) of
        null -> skip;
        GuildParty -> 
            % ?INFO_MSG("mod_guild_mgr:try_del_guild_dishes_and_mons!~w~n", [GuildParty]),
            PlayerIds = lib_scene:get_scene_player_ids(SceneId),
            F = fun(PlayerId) ->
                case player:get_PS(PlayerId) of
                    null ->
                        skip;
                    PS ->
                        F0 = fun(No, Acc) ->
                            case data_guild_dishes:get(No) of
                                null -> Acc;
                                Data -> [Data#guild_dishes.buff_no | Acc]
                            end
                        end,
                        BuffNoList = lists:foldl(F0, [], GuildParty#guild_party.dishes_no),
                        [gen_server:cast(player:get_pid(PS), {'player_del_buff', BuffNo}) || BuffNo <- BuffNoList]
                end
            end,
            [F(PlayerId) || PlayerId <- PlayerIds],

            [mod_scene:clear_dynamic_npc_from_scene_WNC(NpcId) || NpcId <- GuildParty#guild_party.dishes_npc],
            [mod_scene:clear_mon_from_scene_WNC(MonId) || MonId <- GuildParty#guild_party.mon_id],
            lib_guild:del_party_from_ets(GuildId)
    end.


refresh_script_for_guild(ScriptList, InfoList) ->
    F = fun({GuildId, SceneId}) ->
        MonList = lib_guild:refresh_script(ScriptList, sys, SceneId),
        % ?INFO_MSG("[mod_guild_mgr] refresh_script MonList：~p ~n", [MonList]),
        F0 = fun({Id, _No}, Acc) ->
            case Id =:= ?INVALID_ID of
                true -> Acc;
                false -> [Id | Acc]
            end
        end,
        MonIdlist = lists:foldl(F0, [], MonList),
        ?ASSERT(is_list(MonIdlist), {MonIdlist, MonList}),
        case lib_guild:get_party_from_ets(GuildId) of
            null ->
                ?ASSERT(false),
                ?ERROR_MSG("[mod_guild_party] refresh_script error! ~n", []);
            GuildParty ->
                lib_guild:update_party_to_ets(GuildParty#guild_party{mon_id = GuildParty#guild_party.mon_id ++ MonIdlist})
        end
    end,
    [F(Para) || Para <- InfoList].