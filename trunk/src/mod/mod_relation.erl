%%-------------------------------------------------------
%% Created: 2014-4-15
%% Description: TODO: Add description to mod_relation
%%-------------------------------------------------------

-module(mod_relation).
-behaviour(gen_server).
%%
%% Include files
%%
-include("record.hrl").
-include("common.hrl").
-include("relation.hrl").
-include("offline_data.hrl").
-include("ets_name.hrl").
-include("prompt_msg_code.hrl").
-include("reward.hrl").
-include("team.hrl").
-include("log.hrl").
-include("prompt_msg_code.hrl").
-include("sys_code.hrl").
-include("pt_33.hrl").
-include("pt_14.hrl").
-include("obj_info_code.hrl").

-include("goods.hrl").

%%
%% Exported Functions
%%
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([
        start_link/0,
        add_intimacy_between_AB/3,      %% 只用于战斗添加好友度
        weekly_reset/1,
        del_friend/2,
        add_friend/2,
        on_cruise_finish/0,            %% 花车游结束
        set_sworn_info/3,               %% 设置结拜信息
        notify_add_enemy/3,
        notify_intimacy_change/3
        ]).


%% 进程字典的key名
-define(PDKN_COUPLE_COUNT, pdkn_couple_count).          %% 当前服务器夫妇对数
-define(PDKN_SWORN_COUNT, pdkn_sworn_count).          %% 当前服务器结拜数

-record(state,{
    cruise_inst_pid = null,
    sworn_pre_set = undefined   % 全服唯一称号前缀
    }).

start_link() ->
    gen_server:start_link({local, ?RELATION_PROCESS}, ?MODULE, [], []).
    
    
add_friend(PS, IdList) ->
    gen_server:cast(?RELATION_PROCESS, {'add_friend', PS, IdList}).


del_friend(PS, RId) ->
    case ets:lookup(?ETS_RELA, RId) of
        [] -> skip;
        [_R] -> gen_server:cast(?RELATION_PROCESS, {'del_friend', PS, RId})
    end.

weekly_reset(PS) ->
    gen_server:cast(?RELATION_PROCESS, {'weekly_reset', PS}).


add_intimacy_between_AB(IdA, IdB, Add) ->
    gen_server:cast(?RELATION_PROCESS, {'add_intimacy_between_AB', IdA, IdB, Add}).        


on_cruise_finish() ->
    gen_server:cast(?RELATION_PROCESS, {'on_cruise_finish'}).            

set_sworn_info(PlayerId, SwornId, FreeModifySufCnt) ->
    gen_server:cast(?RELATION_PROCESS, {'set_sworn_info', PlayerId, SwornId, FreeModifySufCnt}).    


init([]) ->
    process_flag(trap_exit, true),

    SwornPreSet = sets:new(),
    NewState = 
        case db:select_all(sworn, "prefix", [{prefix_only, 1}]) of
            InfoList_List when is_list(InfoList_List) ->
                F = fun([Prefix], Acc) ->
                    sets:add_element(Prefix, Acc)
                end,
                SwornPreSet1 = lists:foldl(F, SwornPreSet, InfoList_List),
                #state{sworn_pre_set = SwornPreSet1};
            _Any ->
                ?ASSERT(false, _Any),
                ?ERROR_MSG("mod_relation:init error!~p~n", [_Any]),
                #state{}
        end,

    %% 初始化夫妇对数
    DataList = mod_data:load(?SYS_MARRY),
    F1 = fun({Key, Value}) ->
        case Key of
            couple_cnt -> set_couple_cnt(Value);
            _ -> skip
        end
    end,

    DataSwornList = mod_data:load(?SYS_SWORN),
    F2 = fun({Key, Value}) ->
        case Key of
            sworn_cnt -> set_sworn_cnt(Value);
            _ -> skip
        end
    end,

    DataSwornList1 =case DataSwornList =:= [] of
        true -> 
            %% 合服或者新服时，尝试统计夫妻对数
            % case db:select_one(relation_info, "COUNT(*)", [{spouse_id,">",0}], [], [1]) of
            %     null -> skip;
            %     CoupleCnt -> 
            %         % ?DEBUG_MSG("mod_relation:init couple_cnt:~p~n", [util:ceil(CoupleCnt/2)]),
            %         set_sworn_cnt(util:ceil(CoupleCnt/2))
            % end,
            set_sworn_cnt(0),
            [];
        false -> erlang:hd(DataSwornList)
    end,
    
    [F2(X) || X <- DataSwornList1],

    DataList1 = 
        case DataList =:= [] of
            true -> 
                %% 合服或者新服时，尝试统计夫妻对数
                case db:select_one(relation_info, "COUNT(*)", [{spouse_id,">",0}], [], [1]) of
                    null -> skip;
                    CoupleCnt -> 
                        ?DEBUG_MSG("mod_relation:init couple_cnt:~p~n", [util:ceil(CoupleCnt/2)]),
                        set_couple_cnt(util:ceil(CoupleCnt/2))
                end,
                [];
            false -> erlang:hd(DataList)
        end,

    [F1(X) || X <- DataList1],

    {ok, NewState}.


handle_info(Request, State) ->
    try
        handle_info_2(Request, State)
    catch
        Err:Reason->
            ?ERROR_MSG("ERR:~p,Reason:~p",[Err,Reason]),
             {noreply, State}
    end.

handle_info_2({timeout, _TimerRef, {'sworn_ensure', TeamId}}, State) ->
    case get_ensure_list(TeamId) of
        null -> skip;
        {Type, _} ->
            cancel_ensure(TeamId),
            
            do_sworn(Type, TeamId)
    end,
    {noreply, State};

handle_info_2(_Info, State) ->
    {noreply, State}.

terminate(Reason, _State) ->
    case Reason of
        normal -> skip;
        shutdown -> skip;
        _ -> ?ERROR_MSG("[mod_relation] !!!!!terminate!!!!! for reason: ~w", [Reason])
    end,
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.


handle_call(Request, From, State) ->
    try
        handle_call_2(Request, From, State)
    catch
        Err:Reason ->
            ?ERROR_MSG("ERR:~p,Reason:~p",[Err,Reason]),
             {reply, error, State}
    end.

handle_call_2(stop, _From, State) ->
    {stop, normal, stopped, State};

handle_call_2({'modify_sworn_prefix', PS, Choice, Prefix, MoneyBase, MoneyAdd}, _From, State) ->
    NewState = try_modify_sworn_prefix(PS, Choice, Prefix, ?MNY_T_YUANBAO, MoneyBase, MoneyAdd, State),
    {reply, ok, NewState};


handle_call_2({'apply_couple_cruise', PS, Type}, _From, State) ->
    {Ret, NewState} = 
        case State#state.cruise_inst_pid =/= null of
            true ->
                lib_send:send_prompt_msg(PS, ?PM_COUPLE_CRUISE_WAIT),
                {ok, State};
            false ->
                case lib_couple:check_apply_couple_cruise_base(PS, Type) of
                    {fail, Reason} ->
                        {{fail, Reason}, State};
                    ok ->
                        DataCfg = data_couple:get(cruise, Type),
                        lib_couple:cost_money(PS, DataCfg#couple_cfg.need_money, [?LOG_COUPLE, "cruise_car"]),
                        
                        MbIdList = mod_team:get_normal_member_id_list(player:get_team_id(PS)) -- [player:id(PS)],
                        List = [player:id(PS)] ++ MbIdList,
                        case mod_couple_cruise_inst:start(Type, List) of
                            {ok, InstPid} ->
                                {ok, State#state{cruise_inst_pid = InstPid}};
                            Any ->
                                ?ASSERT(false, {Any}),
                                ?ERROR_MSG("[mod_couple_cruise_inst] start instance failed!!! details:~w~n", [Any]),
                                {ok, State}
                        end
                end
        end,

    {reply, Ret, NewState};    

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


handle_cast_2({'add_friend', PS, IdList}, State) ->
    ?TRY_CATCH(try_add_friend(PS, IdList), ErrReason),
    {noreply, State};    

handle_cast_2({'update_rela_list', PlayerId, RelaIdL}, State) ->
    RelaInfoRd = ply_relation:get_rela_info(PlayerId),
    ply_relation:update_rela_info_to_ets(RelaInfoRd#relation_info{rela_list = RelaIdL}),
    {noreply, State};    


handle_cast_2({'clear_dirty_flag', PlayerId}, State) ->
    R = ply_relation:get_rela_info(PlayerId),
    ply_relation:update_rela_info_to_ets(R#relation_info{is_dirty = false}),
    {noreply, State};    

handle_cast_2({'db_save_relation_data', PlayerId}, State) ->
    db_save_relation_data(PlayerId),
    {noreply, State};        

handle_cast_2({'clear_offline_msg', PlayerId}, State) ->
    R = ply_relation:get_rela_info(PlayerId),
    ply_relation:update_rela_info_to_ets(R#relation_info{offline_msg = [], is_dirty = true}),
    {noreply, State};


handle_cast_2({'set_sworn_info', PlayerId, SwornId, FreeModifySufCnt}, State) ->
    R = ply_relation:get_rela_info(PlayerId),
    ply_relation:update_rela_info_to_ets(R#relation_info{sworn_id = SwornId, free_modify_suf_count = FreeModifySufCnt, sworn_suffix = <<"请改后缀">>, is_dirty = true}),
    {noreply, State};       

handle_cast_2({'add_offline_msg', Id, SourceId, NewMsg}, State) ->
    RelaInfo = ply_relation:get_rela_info(Id),
    NewRelaInfo = RelaInfo#relation_info{offline_msg = [{SourceId, NewMsg, svr_clock:get_unixtime()} | RelaInfo#relation_info.offline_msg], is_dirty = true},
    ply_relation:update_rela_info_to_ets(NewRelaInfo),
    {noreply, State};                


handle_cast_2({'init_player_rela_info', PlayerId}, State) ->
    case ets:lookup(?ETS_RELA_INFO, PlayerId) of
        [] ->
            NewRd = #relation_info{id = PlayerId, apply_count_day = ?MAX_APPLY_DAY, is_dirty = true},
            ets:insert(?ETS_RELA_INFO, NewRd);
        [_R] ->
            skip% ?WARNING_MSG("mod_relation:init_player_rela_info Process concurrence!", []) 
    end,
    {noreply, State};


handle_cast_2({'db_try_load_rela_info', PlayerId}, State) ->
    case ets:lookup(?ETS_RELA_INFO, PlayerId) of
        [] -> 
            case db:select_row(relation_info, ?RELA_INFO_SQL, [{id, PlayerId}], [], [1]) of
                [] ->
                    NewRd = #relation_info{id = PlayerId, apply_count_day = ?MAX_APPLY_DAY, is_dirty = true},
                    ets:insert(?ETS_RELA_INFO, NewRd);
                InfoList ->
                    NewRd = ply_relation:to_rela_info_record(PlayerId, InfoList),
                    ets:insert(?ETS_RELA_INFO, NewRd)
            end;
        [_R] -> skip
    end,

    {noreply, State};    


handle_cast_2({'init_rela', RelaList}, State) ->
    F = fun(X) ->
        case ets:lookup(?ETS_RELA, X#relation.id) of
            [] ->
                ets:insert(?ETS_RELA, X);
            [_R] -> skip
        end
    end,
    [F(X) || X <- RelaList],
    {noreply, State};


handle_cast_2({'del_friend', PS, RId}, State) ->
    ?TRY_CATCH(ply_relation:del_friend(PS, RId), ErrReason),
    {noreply, State};    


handle_cast_2({'weekly_reset', PS}, State) ->
    RelaInfo = ply_relation:get_rela_info(player:id(PS)),
    NewRelaInfo = RelaInfo#relation_info{get_intimacy = 0, give_intimacy = 0, is_dirty = true},
    ply_relation:update_rela_info_to_ets(NewRelaInfo),
    mod_rank:role_cool(PS, NewRelaInfo#relation_info.give_intimacy),
    mod_rank:role_charm(PS, NewRelaInfo#relation_info.get_intimacy),
    {noreply, State};        


handle_cast_2({'init_player_rela_info', PlayerId, NewRd}, State) ->
    case ets:lookup(?ETS_RELA_INFO, PlayerId) of
        [] ->
            ets:insert(?ETS_RELA_INFO, NewRd);
        [_R] ->
            skip% ?WARNING_MSG("mod_relation:init_player_rela_info Process concurrence!", [])
    end,
    {noreply, State}; 


handle_cast_2({'update_can_apply_count', PS, Count}, State) ->
    PlayerId = player:id(PS),
    RelaInfo = ply_relation:get_rela_info(PlayerId),
    NewRelaInfo = RelaInfo#relation_info{apply_count_day = Count, is_dirty = true},
    ply_relation:update_rela_info_to_ets(NewRelaInfo),
    {ok, BinData} = pt_14:write(14011, [Count]),
    lib_send:send_to_sock(PS, BinData),
    {noreply, State};


handle_cast_2({'update_can_apply_count', PS, DeductCount, LastApplyTime}, State) ->
    PlayerId = player:id(PS),
    RelaInfo = ply_relation:get_rela_info(PlayerId),
    LeftCount = 
        case RelaInfo#relation_info.apply_count_day - DeductCount >= 0 of
            true -> RelaInfo#relation_info.apply_count_day - DeductCount;
            false -> ?ERROR_MSG("mod_relation:update_can_apply_count error!~n", []), 0
        end,

    NewRelaInfo = RelaInfo#relation_info{apply_count_day = LeftCount, last_apply_time = LastApplyTime, is_dirty = true},
    ply_relation:update_rela_info_to_ets(NewRelaInfo),

    {ok, BinData} = pt_14:write(14011, [LeftCount]),
    lib_send:send_to_sock(PS, BinData),
    {noreply, State};        

handle_cast_2({'init_sworn_relation', NewRd}, State) ->
    case ets:lookup(?ETS_SWORN, NewRd#sworn.id) of
        [] ->
            ets:insert(?ETS_SWORN, NewRd);
        _ -> skip
    end,
    {noreply, State};


handle_cast_2({'try_sworn', PS, Type}, State) ->
    case get_ensure_list(player:get_team_id(PS)) of
        null ->
            ?TRY_CATCH(try_sworn(PS, Type), ErrReason);
        _Any ->
            lib_send:send_prompt_msg(PS, ?PM_RELA_HAVE_TRY_SWORN)
    end,
    {noreply, State};


handle_cast_2({'reply_for_sworn', PS, Type, Choice}, State) ->
    ?TRY_CATCH(reply_for_sworn(PS, Type, Choice), ErrReason),
    {noreply, State};

handle_cast_2({'do_sworn', Team, Type}, State) ->
    ?TRY_CATCH(catch_do_sworn(Team, Type, State), ErrReason),
    {noreply, State};


handle_cast_2({'modify_sworn_prefix', PS, Choice, Prefix}, State) ->
    NewState = try_modify_sworn_prefix(PS, Choice, Prefix, 0, 0, 0, State),
    {noreply, NewState};


handle_cast_2({'modify_sworn_suffix', PS, Suffix}, State) ->
    ?TRY_CATCH(try_modify_sworn_suffix(PS, Suffix), ErrReason),
    {noreply, State};


handle_cast_2({'remove_sworn', PS}, State) ->
    RelaInfo = ply_relation:get_rela_info(player:id(PS)),
    OldSet = State#state.sworn_pre_set,
    NewState = 
    case RelaInfo#relation_info.sworn_id =:= ?INVALID_ID of
        true -> State;
        false ->
            case lib_relation:get_sworn_relation(RelaInfo#relation_info.sworn_id) of
                null ->
                    ?ERROR_MSG("mod_relation:remove_sworn error!~n", []),
                    State;
                Sworn ->
                    Title = <<"解除结拜关系通知">>,
                    case RelaInfo#relation_info.sworn_id =:= player:id(PS) orelse length(Sworn#sworn.members) =< 2 of
                        true ->
                            TitleNo = get_title_no(Sworn#sworn.type, Sworn#sworn.prefix_only),

                            F = fun(Id) ->
                                {NewRelaInfo, Content} = 
                                    case Id =:= player:id(PS) of
                                        true ->
                                            NameList = ply_tips:get_name_list_by_ids(Sworn#sworn.members -- [Id]),
                                            {
                                            RelaInfo#relation_info{sworn_id = 0, free_modify_pre_count = 0, free_modify_suf_count = 0, sworn_suffix = <<>>, is_dirty = true},
                                            list_to_binary(io_lib:format(<<"你解除了和 ~s 的结拜关系，自此之后，兄弟情断，还望你们各自珍重\n你当前结拜称号和结义战斗属性将会失效。找到志向相同的人，前往邯郸城找NPC【刘关张】进行结拜仪式哦！祝游戏愉快！">>, [NameList]))
                                            };
                                        false ->
                                            RelaInfo1 = ply_relation:get_rela_info(Id),
                                            NameList = ply_tips:get_name_list_by_ids(Sworn#sworn.members -- [player:id(PS)]),
                                            {
                                            RelaInfo1#relation_info{sworn_id = 0, free_modify_pre_count = 0, free_modify_suf_count = 0, sworn_suffix = <<>>, is_dirty = true},
                                            list_to_binary(io_lib:format(<<"你的结拜兄弟（姐妹）~s 已经解除了和你 ~s 的结拜关系，自此之后，兄弟情断，还望你们各自珍重\n你当前结拜称号和结义战斗属性将会失效。找到志向相同的人，前往邯郸城找NPC【刘关张】进行结拜仪式哦！祝游戏愉快！">>, [player:get_name(PS), NameList]))
                                            }
                                    end,
                                ply_relation:update_rela_info_to_ets(NewRelaInfo),

                                lib_offcast:cast(Id, {del_title, TitleNo}),
                                lib_team:notify_sworn_info_change(Id, ?INVALID_ID, ?INVALID_NO),
                                lib_mail:send_sys_mail(Id, Title, Content, [], [?LOG_MAIL, ?LOG_UNDEFINED])
                            end,

                            [F(X) || X <- Sworn#sworn.members],
                            lib_relation:del_sworn_relation(RelaInfo#relation_info.sworn_id),
                            NewSet = 
                                case Sworn#sworn.prefix_only =:= 1 of
                                    true ->
                                        sets:del_element(Sworn#sworn.prefix, OldSet);
                                    false -> OldSet
                                end,
                            State#state{sworn_pre_set = NewSet};
                        false ->
                            TitleNo = get_title_no(Sworn#sworn.type, Sworn#sworn.prefix_only),
                                
                            NewSworn = Sworn#sworn{suffix_list = Sworn#sworn.suffix_list -- [RelaInfo#relation_info.sworn_suffix], 
                                members = Sworn#sworn.members -- [player:id(PS)]},
                            lib_relation:update_sworn_relation(NewSworn),
                            NewRelaInfo = RelaInfo#relation_info{sworn_id = 0, free_modify_pre_count = 0, free_modify_suf_count = 0, sworn_suffix = <<>>, is_dirty = true},
                            ply_relation:update_rela_info_to_ets(NewRelaInfo),

                            lib_offcast:cast(player:id(PS), {del_title, TitleNo}),
                            lib_team:notify_sworn_info_change(player:id(PS), ?INVALID_ID, ?INVALID_NO),

                            F = fun(Id) ->
                                Content = 
                                    case Id =:= player:id(PS) of
                                        true ->
                                            NameList = ply_tips:get_name_list_by_ids(Sworn#sworn.members -- [Id]),
                                            list_to_binary(io_lib:format(<<"志不同，道不合，不相为谋，你成功解散了与 ~s 的金兰结义关系！\n当前结拜称号和结义战斗属性将会失效。找到志向相同的人，可以来去邯郸城找【刘关张】进行金兰结义！祝游戏愉快！">>, [NameList]));
                                        false ->
                                            list_to_binary(io_lib:format(<<"志不同，道不合，不相为谋。~s 已经从与你金兰结义关系中脱离。">>, [player:get_name(PS)]))
                                    end,

                                lib_mail:send_sys_mail(Id, Title, Content, [], [?LOG_MAIL, ?LOG_UNDEFINED])
                            end,
                            [F(Id) || Id <- Sworn#sworn.members],
                            State
                    end
            end
    end,

    {ok, BinData} = pt_14:write(14053, [?RES_OK]),
    lib_send:send_to_sock(PS, BinData),

    {noreply, NewState};


handle_cast_2({'give_flower', PS, ObjPS, GoodsObjCntL}, State) ->
    ?TRY_CATCH(try_give_flower(PS, ObjPS, GoodsObjCntL), ErrReason),
    {noreply, State};

% 赠送道具
handle_cast_2({'give_gifts', PS, ObjPS, GoodsObjCntL}, State) ->
    ?TRY_CATCH(try_give_gifts(PS, ObjPS, GoodsObjCntL), ErrReason),
    {noreply, State};


%% 只用于战斗添加好友度
handle_cast_2({'add_intimacy_between_AB', IdA, IdB, Add}, State) ->
    case ply_relation:get_relation_id_between_AB(IdA, IdB) of
        ?INVALID_ID ->
            skip;
        Rid ->
            case ets:lookup(?ETS_RELA, Rid) of
                [] ->
                    ?ASSERT(false),
                    ?ERROR_MSG("mod_relation:add_intimacy_between_AB error!~n", []);
                [R] -> 
                    case R#relation.intimacy_bt >= ?RELA_MAX_INTIMACY_BT of
                        true -> skip;
                        false ->
                            NewRd = R#relation{intimacy = R#relation.intimacy + Add, intimacy_bt = R#relation.intimacy_bt + Add},
                            ets:insert(?ETS_RELA, NewRd),
                            db:update(?DB_SYS, relation, [{intimacy, NewRd#relation.intimacy}, {intimacy_bt, NewRd#relation.intimacy_bt}], [{id, Rid}]),

                            notify_intimacy_change(player:get_PS(IdA), IdB, NewRd#relation.intimacy),
                            notify_intimacy_change(player:get_PS(IdB), IdA, NewRd#relation.intimacy)
                    end
            end
    end,

    {noreply, State};


handle_cast_2({'on_cruise_finish'}, State) ->
    NewState = State#state{cruise_inst_pid = null},
    {noreply, NewState};    


handle_cast_2({'marry_ok', LeaderPS, PS, Type}, State) ->
	Time = util:unixtime(),
    RelaInfoLPS = ply_relation:get_rela_info(player:id(LeaderPS)),
    NRelaInfoLPS = RelaInfoLPS#relation_info{spouse_id = player:id(PS), time_marry = Time, is_dirty = true},
    ply_relation:update_rela_info_to_ets(NRelaInfoLPS),
    db_save_relation_data(player:id(LeaderPS)),

    RelaInfoPS = ply_relation:get_rela_info(player:id(PS)),
    NRelaInfoPS = RelaInfoPS#relation_info{spouse_id = player:id(LeaderPS), time_marry = Time, is_dirty = true},
    ply_relation:update_rela_info_to_ets(NRelaInfoPS),
    db_save_relation_data(player:id(PS)),

    Count = get_couple_cnt() + 1,
    set_couple_cnt(Count),

    DataCfg = data_couple:get(marry, Type),
    BNo = (DataCfg)#couple_cfg.tips_no,
    mod_broadcast:send_sys_broadcast(BNo, [player:get_name(LeaderPS), player:id(LeaderPS), player:get_name(PS), player:id(PS), Count]),

    lib_scene:notify_string_info_change_to_aoi(player:id(PS), [{?OI_CODE_SPOUSE_NAME, player:get_name(LeaderPS)}]),
    lib_scene:notify_string_info_change_to_aoi(player:id(LeaderPS), [{?OI_CODE_SPOUSE_NAME, player:get_name(PS)}]),

    TitleNo = (DataCfg)#couple_cfg.title_no,
    lib_offcast:cast(player:id(LeaderPS), {add_title, TitleNo, util:unixtime()}),
    lib_offcast:cast(player:id(PS), {add_title, TitleNo, util:unixtime()}),

    {ok, BinData} = pt_33:write(?PT_COUPLE_MARRIAGE_BROADCAST, [Type, player:id(LeaderPS), player:id(PS)]),
    lib_send:send_to_uid(player:id(LeaderPS), BinData),
    lib_send:send_to_uid(player:id(PS), BinData),

    TypeFire = DataCfg#couple_cfg.fireworks,
    SceneId = player:get_scene_id(LeaderPS),
    {X, Y} = player:get_xy(LeaderPS),
    lib_couple:show_fireworks({SceneId, X, Y}, TypeFire),

    lib_log:statis_role_action(LeaderPS, [], ?LOG_COUPLE, "marry", [Count, player:id(LeaderPS), player:id(PS), Type]),

    {noreply, State};


handle_cast_2({'devorce_ok', LeaderPS, PS_Or_PlayerId, Devorcetype}, State) ->
	Time = util:unixtime(),
	LastDivorceForce = 
		case Devorcetype of
			2 ->
				1;
			_ ->
				0
		end,
    RelaInfoLPS = ply_relation:get_rela_info(player:id(LeaderPS)),
    NRelaInfoLPS = RelaInfoLPS#relation_info{spouse_id = 0, couple_skill = [], time_divorce = Time, last_divorce_force = LastDivorceForce, is_dirty = true},
    ply_relation:update_rela_info_to_ets(NRelaInfoLPS),
    db_save_relation_data(player:id(LeaderPS)),

    RelaInfoPS = 
        case is_integer(PS_Or_PlayerId) of
            true -> ply_relation:get_rela_info(PS_Or_PlayerId);
            false -> ply_relation:get_rela_info(player:id(PS_Or_PlayerId))
        end,

    NRelaInfoPS = RelaInfoPS#relation_info{spouse_id = 0, couple_skill = [], time_divorce = Time, last_divorce_force = LastDivorceForce, is_dirty = true},
    ply_relation:update_rela_info_to_ets(NRelaInfoPS),
    db_save_relation_data(PS_Or_PlayerId),

    PlayerId = 
        case is_integer(PS_Or_PlayerId) of
            true -> PS_Or_PlayerId;
            false -> player:id(PS_Or_PlayerId)
        end,

    %% 删除称号
    F = fun(TitleId) ->
        lib_offcast:cast(player:id(LeaderPS), {del_title, TitleId}),
        lib_offcast:cast(PlayerId, {del_title, TitleId})
    end,
    [F(X) || X <- data_couple:get_title_no_list_by_key(marry)],

    %% 降低好友度
    Data = data_couple:get(divorce, Devorcetype),
    Rid = ply_relation:get_relation_id_between_AB(player:id(LeaderPS), PlayerId),
    case ets:lookup(?ETS_RELA, Rid) of
        [] ->
            ?ASSERT(false),
            ?ERROR_MSG("mod_relation:devorce_ok error!~n", []);
        [R] -> 
            NewRd = R#relation{intimacy = Data#couple_cfg.intimacy_left},
            ets:insert(?ETS_RELA, NewRd),
            db:update(?DB_SYS, relation, [{intimacy, NewRd#relation.intimacy}, {intimacy_bt, NewRd#relation.intimacy_bt}], [{id, Rid}]),
            notify_intimacy_change(PS_Or_PlayerId, player:id(LeaderPS), NewRd#relation.intimacy),
            notify_intimacy_change(LeaderPS, PlayerId, NewRd#relation.intimacy)
    end,

    %% 邮件通知
    Title = 
        case Devorcetype of
            1 -> <<"离婚通知">>;
            2 -> <<"强制离婚通知">>;
            3 -> <<"离婚通知">>;
            _ -> <<"离婚通知">>
        end,

    F1 = fun(Id) ->
        Content = 
            case Devorcetype of
                1 -> <<"非常遗憾，你们的夫妻关系在今天终结。系统已经回收了你们的夫妻称谓和夫妻技能，同时由于你们二人是协议离婚，所以好友度也将降到500。希望你们在日后的游戏征程里面，能再次找到另一半。">>;
                2 -> 
                    case Id =:= PlayerId of
                        false -> list_to_binary(io_lib:format(<<"非常遗憾，你在今天强制中止了与 ~s 的夫妻关系。系统已经回收了你们的夫妻称谓和夫妻技能，同时由于你们二人是强制离婚，所以好友度也将降到10。希望你们在日后的游戏征程里面，能再次找到另一半。">>, [player:get_name(PlayerId)]));
                        true -> list_to_binary(io_lib:format(<<"非常遗憾，~s 在今天强制中止了与你的夫妻关系。系统已经回收了你们的夫妻称谓和夫妻技能，同时由于你们二人是强制离婚，所以好友度也将降到10。希望你们在日后的游戏征程里面，能再次找到另一半。">>, [player:get_name(LeaderPS)]))
                    end;                        
                3 ->
                    case Id =:= PlayerId of
                        false -> list_to_binary(io_lib:format(<<"非常遗憾，你在今天单方面中止了与 ~s 的夫妻关系。系统已经回收了你们的夫妻称谓和夫妻技能，同时由于你们二人是单方申请离婚，所以好友度也将降到10。希望你们在日后的游戏征程里面，能再次找到另一半。">>, [player:get_name(PlayerId)]));
                        true -> list_to_binary(io_lib:format(<<"非常遗憾，~s 在今天单方面中止了与你的夫妻关系。系统已经回收了你们的夫妻称谓和夫妻技能，同时由于你们二人是单方申请离婚，所以好友度也将降到10。希望你们在日后的游戏征程里面，能再次找到另一半。">>, [player:get_name(LeaderPS)]))
                    end;                                           
                _ -> <<>>
            end,            
        lib_mail:send_sys_mail(Id, Title, Content, [], [?LOG_MAIL, ?LOG_UNDEFINED])
    end,
    [F1(X) || X <- [player:id(LeaderPS), PlayerId]],

    {ok, BinData} = pt_33:write(?PT_COUPLE_DEVORCE_OK, []),
    lib_send:send_to_sock(LeaderPS, BinData),
    lib_send:send_to_uid(PS_Or_PlayerId, BinData),

    lib_scene:notify_string_info_change_to_aoi(player:id(LeaderPS), [{?OI_CODE_SPOUSE_NAME, <<>>}]),
    lib_scene:notify_string_info_change_to_aoi(PlayerId, [{?OI_CODE_SPOUSE_NAME, <<>>}]),

    lib_log:statis_role_action(LeaderPS, [], ?LOG_COUPLE, "devorce", [player:id(LeaderPS), PlayerId, Devorcetype]),

    {noreply, State};    

handle_cast_2({'learn_couple_skill', PlayerId, SkillId}, State) ->
    RelaInfo = ply_relation:get_rela_info(PlayerId),
    NewRelaInfo = RelaInfo#relation_info{couple_skill = [SkillId | RelaInfo#relation_info.couple_skill], is_dirty = true},
    ply_relation:update_rela_info_to_ets(NewRelaInfo),
    {noreply, State};                                    


handle_cast_2(_Msg, State) ->
    {noreply, State}.


%% return NewState
try_modify_sworn_prefix(PS, Choice, Prefix, MoneyType, MoneyBase, MoneyAdd, State) ->
    OldSet = State#state.sworn_pre_set,
    NewState = 
    case sets:is_element(Prefix, OldSet) of
        true ->
            {ok, BinData} = pt_14:write(14055, [?RES_FAIL]),
            lib_send:send_to_sock(PS, BinData),
            State;
        false ->
            case lib_relation:get_sworn_relation(player:id(PS)) of
                null -> %% 两个人结拜时，可能被另一个玩家解除了结拜
                    {ok, BinData} = pt_14:write(14055, [2]),
                    lib_send:send_to_sock(PS, BinData),
                    State;
                Sworn ->
                    PS1 = 
                        case MoneyBase > 0 of
                            true -> player_syn:cost_money(PS, MoneyType, MoneyBase, [?LOG_SWORN, "change"]);
                            false -> PS
                        end,
                    case MoneyAdd > 0 of
                        true -> player_syn:cost_money(PS1, MoneyType, MoneyAdd, [?LOG_SWORN, "only"]);
                        false -> skip
                    end,

                    RelaInfo = ply_relation:get_rela_info(player:id(PS)),
                    NewSworn = Sworn#sworn{prefix = Prefix, prefix_only = Choice},
                    lib_relation:update_sworn_relation(NewSworn),

                    NewRelaInfo = RelaInfo#relation_info{free_modify_pre_count = 0, free_modify_suf_count = 1, is_dirty = true},
                    ply_relation:update_rela_info_to_ets(NewRelaInfo),

                    {ok, BinData0} = pt_14:write(14055, [?RES_OK]),
                    lib_send:send_to_sock(PS, BinData0),

                    F = fun(Id) ->
                        {Suffix, SId} = 
                            case Id =:= player:id(PS) of
                                true -> {RelaInfo#relation_info.sworn_suffix, RelaInfo#relation_info.sworn_id};
                                false ->
                                    Rela = ply_relation:get_rela_info(Id),
                                    NewRela = Rela#relation_info{free_modify_suf_count = 1, is_dirty = true},
                                    ply_relation:update_rela_info_to_ets(NewRela),
                                    {Rela#relation_info.sworn_suffix, Rela#relation_info.sworn_id}
                            end,

                        TitleNo = get_title_no(NewSworn#sworn.type, NewSworn#sworn.prefix_only),

                        %% 尝试删除高级称号
                        case Sworn#sworn.type of
                            1 -> 
                                lib_offcast:cast(Id, {del_title, ?RELA_TITLE_NO_COM}),
                                lib_offcast:cast(Id, {del_title, ?RELA_TITLE_NO_COM_ONLY});
                            2 -> 
                                lib_offcast:cast(Id, {del_title, ?RELA_TITLE_NO_HIGH}),
                                lib_offcast:cast(Id, {del_title, ?RELA_TITLE_NO_HIGH_ONLY})
                        end,

                        lib_offcast:cast(Id, {add_user_def_title, TitleNo, <<Prefix/binary, Suffix/binary>>}),
                        case SId =:= Sworn#sworn.id of
                            false -> skip;
                            true ->
                                {ok, BinData} = pt_14:write(14056, [Sworn#sworn.type, Choice, 0, 1, Prefix, Suffix, Sworn#sworn.id]),
                                lib_send:send_to_uid(Id, BinData)
                        end
                    end,
                    PlayerIdList = Sworn#sworn.members,

                    [F(X) || X <- PlayerIdList],

                    NewSet = 
                        case Sworn#sworn.prefix_only =:= 1 of
                            true ->
                                sets:del_element(Sworn#sworn.prefix, OldSet);
                            false -> OldSet
                        end,
                    NewSet1 = 
                        case Choice =:= 1 of
                            true ->
                                sets:add_element(Prefix, NewSet);
                            false -> NewSet
                        end,
                    State#state{sworn_pre_set = NewSet1}
            end
    end,
    NewState.

reply_for_sworn(PS, Type, Choice) ->
    TeamId = player:get_team_id(PS),
    case Choice of
        0 ->
            cancel_ensure(TeamId),
            Team = mod_team:get_team_info(TeamId),
            {ok, BinData} = pt_14:write(14050, [?RES_FAIL, Type, [{player:id(PS), 3}]]),
            lib_send:send_to_team(Team, BinData);
        1 ->
            del_ensure_list(TeamId, player:id(PS)),
            case get_ensure_list(TeamId) of
                null -> skip;
                {Type, []} ->
                    cancel_ensure(TeamId),
                    do_sworn(Type, TeamId);
                _ -> skip
            end
    end.


do_sworn(Type, TeamId) ->
    PlayerId = mod_team:get_leader_id(TeamId),
    Team = mod_team:get_team_info(TeamId),
    case player:get_pid(PlayerId) of
        null ->
            {ok, BinData} = pt_14:write(14050, [?RES_FAIL, Type, [{PlayerId, 4}]]),
            lib_send:send_to_team(Team, BinData);
        Pid ->
            {MoneyType, MoneyCount} = 
                case Type of
                    ?RELA_SWORN_TYPE_COM -> {?MNY_T_YUANBAO, ?RELA_SWORN_COM_MONEY};
                    ?RELA_SWORN_TYPE_HIGH -> {?MNY_T_YUANBAO, ?RELA_SWORN_HIGH_MONEY}
                end,
            gen_server:cast(Pid, {'do_sworn', Team, Type, MoneyType, MoneyCount})
    end.

try_sworn(PS, Type) ->
    case ply_relation:can_sworn(PS, Type) of
        {fail, RetList} ->
            {ok, BinData} = pt_14:write(14050, [?RES_FAIL, Type, RetList]),
            lib_send:send_to_sock(PS, BinData);
        ok ->
            case mod_team:get_team_info(player:get_team_id(PS)) of
                null -> 
                    ?ERROR_MSG("mod_relation:try_sworn error!~n", []),
                    skip;
                Team ->
                    List = mod_team:get_normal_member_id_list(Team),
                    List1 = List -- [player:id(PS)],
                    set_ensure_list(player:get_team_id(PS), {Type, List1}),

                    F = fun(X) ->
                        {ok, BinData0} = pt_14:write(14051, [Type]),
                        lib_send:send_to_uid(X, BinData0)
                    end,
    
                    [F(X) || X <- List1],

                    erlang:start_timer(?RELA_ENSURE_WAIT_TIME * 1000, self(), {'sworn_ensure', player:get_team_id(PS)})
            end
    end.


try_add_friend(PS, IdList) ->
    F = fun(ObjId) ->
        case player:get_PS(ObjId) of
            null -> skip;
            FriendPS ->
                case ply_relation:check_add_friend(PS, FriendPS) of
                    ok ->
                        RId = ply_relation:add_friend(PS, ObjId),
                        notify_add_friend(PS, ObjId, RId),
                        mod_achievement:notify_achi(add_friend, [{num, 1}], PS),                        
                        mod_achievement:notify_achi(add_friend, [{num, 1}], FriendPS),
                        notify_add_friend(FriendPS, PS, RId);
                    {fail, Reason} ->
                        lib_send:send_prompt_msg(PS, Reason)
                end
        end
    end,
    [F(X) || X <- IdList].


notify_add_friend(PS, ObjId, RId) when is_integer(ObjId) ->
    InfoList = 
        case player:get_PS(ObjId) of
            null ->
                case ply_tmplogout_cache:get_tmplogout_PS(ObjId) of
                    null ->
                        case mod_offline_data:get_offline_role_brief(ObjId) of
                            null -> [RId, ObjId, 0, 0, 0, 0, 0, 0, <<>>];
                            Brief -> [RId, ObjId, 0, Brief#offline_role_brief.lv, Brief#offline_role_brief.race, Brief#offline_role_brief.faction, 
                                        Brief#offline_role_brief.sex, Brief#offline_role_brief.battle_power, Brief#offline_role_brief.name]
                        end;
                    ObjPS ->
                        [RId, player:id(ObjPS), 0, player:get_lv(ObjPS), player:get_race(ObjPS), player:get_faction(ObjPS), player:get_sex(ObjPS), 
                        ply_attr:get_battle_power(ObjPS), player:get_name(ObjPS)]
                end;
            ObjPS ->
                [RId, player:id(ObjPS), 1, player:get_lv(ObjPS), player:get_race(ObjPS), player:get_faction(ObjPS), player:get_sex(ObjPS), 
                ply_attr:get_battle_power(ObjPS), player:get_name(ObjPS)]
        end,
    {ok, BinData} = pt_14:write(14005, InfoList),
    lib_send:send_to_sock(PS, BinData);

notify_add_friend(PS, FriendPS, RId) ->
    InfoList = 
        [RId, player:id(FriendPS), 1, player:get_lv(FriendPS), player:get_race(FriendPS), player:get_faction(FriendPS), player:get_sex(FriendPS), 
        ply_attr:get_battle_power(FriendPS), player:get_name(FriendPS)],

    {ok, BinData} = pt_14:write(14005, InfoList),
    lib_send:send_to_sock(PS, BinData).


notify_add_enemy(PS, ObjId, RId) when is_integer(ObjId) ->
    InfoList = 
        case player:get_PS(ObjId) of
            null ->
                case ply_tmplogout_cache:get_tmplogout_PS(ObjId) of
                    null ->
                        case mod_offline_data:get_offline_role_brief(ObjId) of
                            null -> [RId, ObjId, 0, 0, 0, 0, 0, 0, <<>>];
                            Brief -> [RId, ObjId, 0, Brief#offline_role_brief.lv, Brief#offline_role_brief.race, Brief#offline_role_brief.faction, 
                                        Brief#offline_role_brief.sex, Brief#offline_role_brief.battle_power, Brief#offline_role_brief.name]
                        end;
                    ObjPS ->
                        [RId, player:id(ObjPS), 0, player:get_lv(ObjPS), player:get_race(ObjPS), player:get_faction(ObjPS), player:get_sex(ObjPS), 
                        ply_attr:get_battle_power(ObjPS), player:get_name(ObjPS)]
                end;
            ObjPS ->
                [RId, player:id(ObjPS), 1, player:get_lv(ObjPS), player:get_race(ObjPS), player:get_faction(ObjPS), player:get_sex(ObjPS), 
                ply_attr:get_battle_power(ObjPS), player:get_name(ObjPS)]
        end,
    {ok, BinData} = pt_14:write(?PT_ADD_ENEMY, InfoList),
    lib_send:send_to_sock(PS, BinData);

notify_add_enemy(PS, EnemyPS, RId) ->
    InfoList = 
        [RId, player:id(EnemyPS), 1, player:get_lv(EnemyPS), player:get_race(EnemyPS), player:get_faction(EnemyPS), player:get_sex(EnemyPS), 
        ply_attr:get_battle_power(EnemyPS), player:get_name(EnemyPS)],

    {ok, BinData} = pt_14:write(?PT_ADD_ENEMY, InfoList),
    lib_send:send_to_sock(PS, BinData).

set_ensure_list(TeamId, Info) ->
    erlang:put( {?RELA_TEAM_ENSURE_LIST, TeamId}, Info ).

del_ensure_list(TeamId, Elm) ->
    case get_ensure_list(TeamId) of
        null -> skip;
        {Type, List} ->
            NewList = lists:delete(Elm, List),
            set_ensure_list(TeamId, {Type, NewList})
    end.


get_ensure_list(TeamId) ->
    case erlang:get({?RELA_TEAM_ENSURE_LIST, TeamId}) of
        undefined -> null;
        Rd -> Rd
    end.

cancel_ensure(TeamId) -> 
    erlang:erase({?RELA_TEAM_ENSURE_LIST, TeamId}).


get_prefix(RangeMin, RangeMax, SwornPreSet) ->
    get_prefix(RangeMin, RangeMax, SwornPreSet, 100).

get_prefix(_, _, _SwornPreSet, 0) ->
    <<"请改称号">>;
get_prefix(RangeMin, RangeMax, SwornPreSet, TryCount) ->
    Rand = util:rand(RangeMin, RangeMax),
    Prefix = 
        case data_sworn:get_prefix(Rand) of
            null -> data_sworn:get_prefix(1);
            TPrefix -> TPrefix
        end,

    case sets:is_element(Prefix, SwornPreSet) of
        false -> Prefix;
        true -> get_prefix(RangeMin, RangeMax, SwornPreSet, TryCount - 1)
    end.

get_suffix(RangeMin, RangeMax, SuffixList) ->
    get_suffix(RangeMin, RangeMax, SuffixList, 100).

get_suffix(_, _, _SuffixList, 0) ->
    <<"请改字号">>;

get_suffix(RangeMin, RangeMax, SuffixList, TryCount) ->
    Rand = util:rand(RangeMin, RangeMax),
    Suffix = 
        case data_sworn:get_suffix(Rand) of
            null -> data_sworn:get_suffix(1);
            TSuffix -> TSuffix
        end,
    case lists:member(Suffix, SuffixList) of
        false -> Suffix;
        true -> get_suffix(RangeMin, RangeMax, SuffixList, TryCount - 1)
    end.


get_title_no(Type) ->
    case Type of
        ?RELA_SWORN_TYPE_COM -> ?RELA_TITLE_NO_COM;
        ?RELA_SWORN_TYPE_HIGH -> ?RELA_TITLE_NO_HIGH
    end.

get_title_no(Type, Only) ->
    case Type of
        ?RELA_SWORN_TYPE_COM ->
            case Only of
                0 -> ?RELA_TITLE_NO_COM;
                1 -> ?RELA_TITLE_NO_COM_ONLY
            end;
        ?RELA_SWORN_TYPE_HIGH ->
            case Only of
                0 -> ?RELA_TITLE_NO_HIGH;
                1 -> ?RELA_TITLE_NO_HIGH_ONLY
            end
    end.


catch_do_sworn(Team, Type, State) ->
    GroupNoList = data_sworn:get_all_group_no_list(),
    RandGroup = util:rand(lists:nth(1, GroupNoList), lists:last(GroupNoList)),
    {RangeMin, RangeMax} =
        case data_sworn:get_no_list_by_group(RandGroup) of
            [] -> ?ASSERT(false, RandGroup), {1, 1};
            TList -> {lists:nth(1, TList), lists:last(TList)} 
        end,

    Prefix = get_prefix(RangeMin, RangeMax, State#state.sworn_pre_set),

    MemberList = mod_team:get_normal_member_id_list(Team),
    LeaderId = mod_team:get_leader_id(Team),
    NewRd = #sworn{id = LeaderId, type = Type, prefix = Prefix, members = MemberList},

    TitleNo = get_title_no(Type),
    
    RewardNo = 
        case data_sworn_attr_add:get(Type) of
            null -> ?INVALID_NO;
            Data -> Data#sworn_attr_add.reward_no
        end,
    F0 = fun(Member, Acc) ->
        case length(Acc) =:= length(Team#team.members) - 1 of
            true -> [Member#mb.name | Acc];
            false -> 
                Temp = io_lib:format(<<"、 ~s">>, [Member#mb.name]),
                [Temp | Acc]
        end
    end,

    NameList = lists:foldl(F0, [], Team#team.members),

    Title = <<"结拜成功通知">>,
    Content = 
        case Type of
            ?RELA_SWORN_TYPE_COM ->
                list_to_binary(io_lib:format(<<"祝贺你们，今日与 ~s 义结金兰，今后同心协力，情同手足。\n福禄同享，患难相随，风雨同舟。\n皇天后土，实鉴此心，背义忘恩，天人共戮。\n与金兰结义兄弟姐妹进入战斗时，能获得战斗属性加成，祝游戏愉快！">>, [NameList]));
            ?RELA_SWORN_TYPE_HIGH ->                
                list_to_binary(io_lib:format(<<"祝贺你们，今日与 ~s 义结金兰，今后同心协力，情同手足。\n福禄同享，患难相随，风雨同舟。\n皇天后土，实鉴此心，背义忘恩，天人共戮。\n与金兰结义兄弟姐妹进入战斗时，能获得战斗属性加成，祝游戏愉快！">>, [NameList]))
        end,

    {FreeModifyPreCount, FreeModifySufCount} = 
        case Type of
            ?RELA_SWORN_TYPE_COM -> {0, 0};
            ?RELA_SWORN_TYPE_HIGH -> {1, 1}
        end,

    Count = get_sworn_cnt() + 1,
    set_sworn_cnt(Count),

    F = fun(Id, Acc) ->
        Suffix = get_suffix(RangeMin, RangeMax, Acc),
        RelaInfo = ply_relation:get_rela_info(Id),
        NewRelaInfo = 
            case Id =:= LeaderId of
                true ->
                    RelaInfo#relation_info{
                        sworn_id = LeaderId, 
                        free_modify_pre_count = FreeModifyPreCount, 
                        free_modify_suf_count = FreeModifySufCount, 
                        sworn_suffix = Suffix,
                        is_dirty = true
                        };
                false ->
                    RelaInfo#relation_info{sworn_id = LeaderId, free_modify_suf_count = FreeModifySufCount, sworn_suffix = Suffix, is_dirty = true}
            end,
        ply_relation:update_rela_info_to_ets(NewRelaInfo),
        db_save_relation_data(Id),
        case RewardNo =:= ?INVALID_NO of
            true -> lib_mail:send_sys_mail(Id, Title, Content, [], [?LOG_MAIL, ?LOG_UNDEFINED]);
            false ->
                RewardDtl = lib_reward:calc_reward_to_player(Id, RewardNo),
                lib_mail:send_sys_mail(Id, Title, Content, RewardDtl#reward_dtl.calc_goods_list, [?LOG_MAIL, ?LOG_UNDEFINED])
        end,
        lib_offcast:cast(Id, {add_user_def_title, TitleNo, <<Prefix/binary, Suffix/binary>>}),
        lib_team:notify_sworn_info_change(Id, LeaderId, Type),
        [Suffix | Acc]
    end,
    SuffixList = lists:foldl(F, [], MemberList),
    NewRd1 = NewRd#sworn{suffix_list = SuffixList},
    lib_relation:add_sworn_relation(NewRd1),

    % case Type of
    %     ?RELA_SWORN_TYPE_COM -> skip;
    %     ?RELA_SWORN_TYPE_HIGH ->
    F1 = fun(Member, Acc) ->
        case length(Acc) =:= length(Team#team.members) - 1 of
            true -> [Member#mb.name | Acc];
            false -> 
                Temp = io_lib:format(<<"、 ~s">>, [Member#mb.name]),
                [Temp | Acc]
        end
    end,

    Para = lists:foldl(F1, [], Team#team.members),
    mod_broadcast:send_sys_broadcast(92, [Para,Prefix,Count]),
    % end,

    {ok, BinData} = pt_14:write(14050, [?RES_OK, Type, []]),
    lib_send:send_to_team(Team, BinData).


try_modify_sworn_suffix(PS, Suffix) ->
    RelaInfo = ply_relation:get_rela_info(player:id(PS)),
    case RelaInfo#relation_info.free_modify_suf_count =:= 1 of
        false -> lib_send:send_prompt_msg(PS, ?PM_RELA_NO_MODIFY_COUNT);
        true ->
            case lib_relation:get_sworn_relation(RelaInfo#relation_info.sworn_id) of
                null ->
                    ?ASSERT(false),
                    ?ERROR_MSG("mod_relation:modify_sworn_suffix error!~n", []);
                Sworn ->
                    case lists:member(Suffix, Sworn#sworn.suffix_list) andalso RelaInfo#relation_info.sworn_suffix =/= Suffix of
                        true ->
                            {ok, BinData} = pt_14:write(14057, [?RES_FAIL]),
                            lib_send:send_to_sock(PS, BinData);
                        false ->
                            NewRelaInfo = RelaInfo#relation_info{free_modify_suf_count = 0, sworn_suffix = Suffix, is_dirty = true},
                            ply_relation:update_rela_info_to_ets(NewRelaInfo),

                            NewSworn = Sworn#sworn{suffix_list = [Suffix | Sworn#sworn.suffix_list]},
                            lib_relation:update_sworn_relation(NewSworn),
                            
                            {ok, BinData} = pt_14:write(14057, [?RES_OK]),
                            lib_send:send_to_sock(PS, BinData),

                            % 增加修改称号公告
                            mod_broadcast:send_sys_broadcast(91, [player:get_name(PS),Sworn#sworn.prefix,Suffix]),
                            
                            TitleNo = get_title_no(Sworn#sworn.type, Sworn#sworn.prefix_only),

                            lib_offcast:cast(player:id(PS), {add_user_def_title, TitleNo, <<(Sworn#sworn.prefix)/binary, Suffix/binary>>})
                    end
            end
    end.


try_give_gifts(PS, ObjPS, GoodsObjCntL) ->
    FriendPlayerId = player:id(ObjPS),
    % MyPlayerId = player:id(PS),

    F = fun({Goods, Count}, Sum) ->
        mod_inv:destroy_goods_WNC(player:id(PS), Goods,Count,[?LOG_GOODS, "give_gifts"]),
        Sum ++ {Goods,?BIND_ALREADY, Count}
    end,

    GoodsL = lists:foldl(F, [], GoodsObjCntL),

    Title = <<"好友赠送">>,
    Content = list_to_binary(io_lib:format(<<"~s 给您赠送了一份礼物.">>, [player:get_name(PS)])),
    lib_mail:send_sys_mail(FriendPlayerId, Title, Content, GoodsL, [?LOG_GOODS, "give_gifts"]),

    {ok, BinData} = pt_14:write(14102, [0]),

    lib_send:send_to_sock(PS, BinData).
    


try_give_flower(PS, ObjPS, GoodsObjCntL) ->
    PlayerId = player:id(ObjPS),
    Rid = ply_relation:get_relation_id_between_AB(PS, PlayerId),
    case ets:lookup(?ETS_RELA, Rid) of
        [] ->
            ?ASSERT(false),
            ?ERROR_MSG("mod_relation:give_flower error!~n", []);
        [R] -> 
            F = fun({Goods, Count}, Sum) ->
                Get = 
                    case lib_goods:get_no(Goods) of
                        60191 -> 99 * Count;
                        60192 -> 10 * Count;
                        _ -> ?ASSERT(false), Sum
                    end,

                ply_tips:send_sys_tips(ObjPS, {give_flower, 
                    [
                        player:get_name(PS), player:id(PS), 
                        Count,
                        lib_goods:get_no(Goods), lib_goods:get_quality(Goods), 0 ,0,
                        player:get_name(ObjPS), player:id(ObjPS)

                    ]}),

                mod_achievement:notify_achi(gift, Count, [{no, lib_goods:get_no(Goods)}], PS),
                lib_log:statis_give_flower(PS, lib_goods:get_no(Goods), lib_goods:get_id(Goods), Count, Get, PlayerId),

                Get + Sum
            end,

            Add = lists:foldl(F, 0, GoodsObjCntL),

            NewRd = R#relation{intimacy = R#relation.intimacy + Add},
            ets:insert(?ETS_RELA, NewRd),
            db:update(?DB_SYS, relation, [{intimacy, NewRd#relation.intimacy}], [{id, Rid}]),

            RelaInfo = ply_relation:get_rela_info(PlayerId),
            NewRelaInfo = RelaInfo#relation_info{get_intimacy = RelaInfo#relation_info.get_intimacy + Add, is_dirty = true},
            ply_relation:update_rela_info_to_ets(NewRelaInfo),

            RelaInfo1 = ply_relation:get_rela_info(player:id(PS)),
            NewRelaInfo1 = RelaInfo1#relation_info{give_intimacy = RelaInfo1#relation_info.give_intimacy + Add, is_dirty = true},
            ply_relation:update_rela_info_to_ets(NewRelaInfo1),

            mod_rank:role_cool(PS, NewRelaInfo1#relation_info.give_intimacy),
            mod_rank:role_charm(ObjPS, NewRelaInfo#relation_info.get_intimacy),

            notify_intimacy_change(player:get_PS(PlayerId), player:id(PS), NewRd#relation.intimacy),

            {ok, BinData} = pt_14:write(14100, [Add, PlayerId, player:get_name(PlayerId)]),
            lib_send:send_to_sock(PS, BinData)
    end.

notify_intimacy_change(PlayerId, ObjPlayerId, GetIntimacy) when is_integer(PlayerId) ->
    case player:get_PS(PlayerId) of
        null -> skip;
        PS -> notify_intimacy_change(PS, ObjPlayerId, GetIntimacy)
    end;
notify_intimacy_change(PS, ObjPlayerId, GetIntimacy) ->
    case PS =:= null of
        true -> 
            skip;
        false ->
            {ok, BinData} = pt_14:write(14101, [ObjPlayerId, GetIntimacy]),
            lib_send:send_to_sock(PS, BinData)
    end.

%% RELATION_PROCESS 进程调用
db_save_relation_data(PlayerId) when is_integer(PlayerId) ->
    case ets:lookup(?ETS_RELA_INFO, PlayerId) of
        [] -> 
            skip;
        [R] ->
            case R#relation_info.is_dirty of
                false -> skip;
                true ->
                    ply_relation:db_replace(PlayerId, R),
                    ply_relation:update_rela_info_to_ets(R#relation_info{is_dirty = false})
            end
    end;
db_save_relation_data(PS) ->
    db_save_relation_data(player:id(PS)).

set_couple_cnt(Count) ->
    erlang:put(?PDKN_COUPLE_COUNT, Count),
    mod_data:save(?SYS_MARRY, [{couple_cnt, Count}]).

get_couple_cnt() ->
    case erlang:get(?PDKN_COUPLE_COUNT) of
        undefined -> 0;
        Rd -> Rd
    end.

set_sworn_cnt(Count) ->
    erlang:put(?PDKN_SWORN_COUNT, Count),
    mod_data:save(?SYS_SWORN, [{sworn_cnt, Count}]).

get_sworn_cnt() ->
    case erlang:get(?PDKN_SWORN_COUNT) of
        undefined -> 0;
        Rd -> Rd
    end.


