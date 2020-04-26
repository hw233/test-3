-module (mod_achievement).

-include("common.hrl").
-include("record.hrl").
-include("achievement.hrl").
-include("ets_name.hrl").
-include("goods.hrl").
-include("log.hrl").
-include("reward.hrl").

-export([
    login/2
    ,tmp_logout/1
    ,final_logout/1
    ,notify_achi/3
    ,notify_achi/4
    ,handle_notify_achi/4
    ,get_achievement/1
    ,set_achievement/2
    ,attr_bonus/1
    ,set_contri/2
	,chapter_gm_to_finish/2,
    check_achievement_task/2
    ]).

% publ_notify_event(EventType, Args, Status) ->
%     gen_server:cast(player:get_pid(Status), )


%% @doc 对外通知接口, 根据玩家行为更新成就数据
%% @Args::{AddNum, [args]}
notify_achi(EventType, Args, Status) when is_list(Args) ->
    % ?LDS_TRACE(notify_achi, [EventType, Args]),
    notify_achi(EventType, 1, Args, Status).
notify_achi(EventType, Num, Condition, Status) when is_record(Status, player_status) ->
    gen_server:cast(player:get_pid(Status), {apply_cast, ?MODULE, handle_notify_achi, [EventType, Num, Condition, player:id(Status)]});
notify_achi(EventType, Num, Condition, RoleId) when is_integer(RoleId) ->
    gen_server:cast(player:get_pid(RoleId), {apply_cast, ?MODULE, handle_notify_achi, [EventType, Num, Condition, RoleId]});
notify_achi(_, _, _, _) -> skip.


% notify_achi(EventType, Args, Status) when is_list(Args) ->
%     ?LDS_TRACE(notify_achi, [EventType, Args]),
%     notify_achi(EventType, 1, Args, Status).
handle_notify_achi(EventType, Num, Condition, RoleId) ->
    % ?LDS_TRACE("[mod_achievement]", [EventType, Num, Condition, RoleId]),
    % _Args = [{Num, Condition}],
    % Condition = case lists:keyfind(num, 1, Cond) of
    %     false -> [{num, 1} | Cond];
    %     _ -> Cond
    % end,
    case translate_event_to_no(EventType) of
        null -> skip;
        Nos when is_list(Nos) ->
            F = fun(No) ->
                case get_achievement(RoleId) of
                    null -> skip;
                    List when is_list(List) ->
                        case lists:keyfind(No, 1, List) of
                            false -> ?ASSERT(false, [No, List]);
                            {No, OriNum, Limit} ->
                                % ?LDS_TRACE("find achi success ", [Condition, No]),
                                case Limit =/= 0 andalso OriNum >= Limit of
                                    true -> skip;
                                    false ->
                                        case check_condition(No, Condition) of
                                            true ->
                                                ?DEBUG_MSG("no=~p,~p[~p,~p,~p]",[No,Condition,OriNum,Num,Limit]),
                                                % ?LDS_TRACE(check_condition, {true, Num}),
                                                AddNum = OriNum + Num,
                                                NewNum = ?BIN_PRED(Limit =:= 0, AddNum, ?BIN_PRED(AddNum >= Limit, Limit, AddNum)),
                                                NewList = lists:keyreplace(No, 1, List, {No, NewNum, Limit}),
                                                update_achievement(RoleId, NewList),
                                                mod_chapter_target:get_all_chapter_info(player:get_PS(RoleId)),
                                                %处理是否推送已完成成就给前端
                                                Data = data_achievement:get_achievement(No),
                                                Type = Data#achievement.type,

                                                mod_chapter_target:get_redpoint_chapter(RoleId),

                                                % 类型
                                                case Type of
                                                    %是章节目标
                                                    0 ->
                                                        case AddNum >= Limit of
                                                            false -> skip; %未达成
                                                            true ->
                                                                %%检测完成任务？wjc新2019.12.21
                                                                lib_event:event(reach_achievement, [No,AddNum], player:get_PS(RoleId)),
                                                                %发送奖励
                                                                send_reward_by_email(RoleId,No),
                                                                ?DEBUG_MSG("=============handle_notify_achi=== No=~p~n", [No]),

                                                                {ok, BinData} = pt_59:write(59004, [No]),
                                                                lib_send:send_to_sock(player:get_PS(RoleId), BinData)
                                                        end;
                                                    % 每日任务类型
                                                    2 ->
                                                        skip;
                                                    3 ->
                                                        skip;
                                                    1 -> %是成就
                                                        case AddNum >= Limit of
                                                            false -> skip; %未达成
                                                            true ->
                                                                %发送奖励
                                                                send_reward_by_email(RoleId,No),
                                                                ?ylh_Debug("=============handle_notify_achi=== No=~p~n", [No]),
                                                                {ok, BinData} = pt_59:write(59004, [No]),
                                                                lib_send:send_to_sock(player:get_PS(RoleId), BinData)
                                                        end;
                                                    _ ->    % 没有类型
                                                        skip
                                                end;
                                            false -> skip
                                        end
                                end
                        end;
                    _ -> skip
                end
                end,
            lists:foreach(F, Nos);
        _ -> ?ASSERT(false)
    end.


chapter_gm_to_finish(No, RoleId) ->
	List = get_achievement(RoleId),
	{No, OriNum, Limit} = lists:keyfind(No, 1, List),
	AddNum = OriNum + 1000,
	NewNum = ?BIN_PRED(Limit =:= 0, AddNum, ?BIN_PRED(AddNum >= Limit, Limit, AddNum)),
	NewList = lists:keyreplace(No, 1, List, {No, NewNum, Limit}),
	update_achievement(RoleId, NewList),
	mod_chapter_target:get_all_chapter_info(player:get_PS(RoleId)),
	%处理是否推送已完成成就给前端
	Data = data_achievement:get_achievement(No), 
	Type = Data#achievement.type, 
	
	mod_chapter_target:get_redpoint_chapter(RoleId),
	
	% 类型
	case Type of
		%是章节目标
		0 -> 
			case AddNum >= Limit of
				false -> skip; %未达成
				true ->
					%发送奖励
					send_reward_by_email(RoleId,No),
					?DEBUG_MSG("=============handle_notify_achi=== No=~p~n", [No]),
					
					{ok, BinData} = pt_59:write(59004, [No]),
					lib_send:send_to_sock(player:get_PS(RoleId), BinData)
			end;
		% 每日任务类型
		2 -> 
			skip;
		3 ->
			skip;
		1 -> %是成就
			case AddNum >= Limit of
				false -> skip; %未达成
				true ->
					%发送奖励
					send_reward_by_email(RoleId,No),
					?ylh_Debug("=============handle_notify_achi=== No=~p~n", [No]),
					{ok, BinData} = pt_59:write(59004, [No]),
					lib_send:send_to_sock(player:get_PS(RoleId), BinData)
			end;
		_ ->    % 没有类型
			skip
	end.

%发送奖励给玩家
send_reward_by_email(RoleId, No) ->
    ?ylh_Debug("send_reward_by_email RoleId=~p, No=~p~n", [RoleId, No]), 
    case data_achievement:get_achievement(No) of
        Achi when is_record(Achi, achievement) ->
            %给玩家增加属性点
            ?ylh_Debug("attr_bonus No=~p  Achi#achievement.add_attr=~p~n", [No, Achi#achievement.add_attr]),
            case erlang:length(Achi#achievement.add_attr) == 1 of
                true ->
                    [{AttrType, AddNum, _}] = Achi#achievement.add_attr,
                    case AttrType == free_talent_points of
                        true ->
                            ?ylh_Debug("add_free_talent_points AddNum=~p~n", [AddNum]),
                            player:add_free_talent_points(player:get_PS(RoleId), AddNum),
                            player:notify_cli_talents_change(player:get_PS(RoleId));
                        false ->
                            skip
                    end;
                false ->
                    skip
            end,

            RewardNo = Achi#achievement.reward,
            RewardRd = lib_reward:calc_reward_to_player(RoleId, RewardNo),
            case RewardRd#reward_dtl.calc_goods_list =/= [] of
                true ->

                    Content = io_lib:format(
                    <<"您的七日盛典目标(~s)达成，给您奖励">>, 
                    [  
                        Achi#achievement.name             
                    ]),

                    lib_mail:send_sys_mail(RoleId, <<"七日盛典">>, 
                        Content, 
                        RewardRd#reward_dtl.calc_goods_list, [?LOG_MAIL, "achievement"]);
                false -> skip
            end;            


            % Content = list_to_binary(io_lib:format(<<"主人恭喜您达成了<text color=0.98 0.259 0.494> ~s </text>成就">>, [Achi#achievement.name])),
            % case BindGamemoneyValue > 0 of
            %     true ->
            %         lib_mail:send_sys_mail(RoleId
            %               ,<<"成就达成">>
            %               ,Content
            %               ,[{?VGOODS_BIND_GAMEMONEY, BindGamemoneyValue}]
            %               ,["achievement", No]
            %         );
            %     false ->
            %         lib_mail:send_sys_mail(RoleId
            %               ,<<"成就达成">>
            %               ,Content
            %               ,[]
            %               ,["achievement", No]
            %         )
            % end;
        _ ->
            skip
    end.


%% @doc 转换成就事件类型为编号
%% @return: null | list()
translate_event_to_no(EventType) ->
    case data_achievement:get_achievement_no(EventType) of
        null -> null;
        No when is_list(No) -> No;
        _ -> null
    end.


%% @doc 检查事件条件是否符合
%% @return: true | false
check_condition(No, Args) ->
    case data_achievement:get_achievement(No) of
        Achi when is_record(Achi, achievement) ->
            Condition = Achi#achievement.condition,
            case No == 181 of
                true ->
                    ?ylh_Debug("check_condition No=~p,Args=~p Condition=~p~n", [No, Args, Condition]),
                    ?ylh_Debug("erlang:length=~p~n", [erlang:length(Condition)]);
                false ->
                    skip
            end,
           
            case lists:keyfind(num, 1, Condition) =/= false andalso erlang:length(Condition) =:= 2 of
                true -> 
                    case check_condition_complex(Condition, Args) of
                        true -> true;
                        false -> false
                    end;
                false ->
                    %扩展对成就3条件的判断
                    case lists:keyfind(lv, 1, Condition) =/= false andalso erlang:length(Condition) =:= 3 of
                        true ->
                            % ?ylh_Debug("check_condition_complex_ex Args=~p~n", [Args]),
                            case check_condition_complex_ex(Condition, Args, 0) of
                                true ->
                                    true;
                                false -> 
                                    false
                            end;
                        false ->
                            case check_condition_1(Condition, Args) of
                                true -> true;
                                false -> false
                            end
                    end
            end;
        _ -> false
    end.


%% @Condition :: config data condition; @Args :: program arg 
%% @return: boolean()
check_condition_1([], []) -> true;
check_condition_1(_, []) -> false;
check_condition_1(Condition, [{_, _} | _] = Args) ->
    check_condition_2(Condition, Args);
check_condition_1(Condition, [L | _] = Args) when is_list(L) ->
    check_condition_3(Condition, Args);
check_condition_1(_, _) -> ?ASSERT(false), false.



%% @return: boolean()
check_condition_2([], _Args) -> true;
check_condition_2([{Condition, {Int, Type}} | Left], Args) ->
    % ?LDS_TRACE("check_condition_2", [{Condition, {Int, Type}} | Left]),
    case lists:keyfind(Condition, 1, Args) of
        false -> false;
        {Condition, Num} ->
            % ?LDS_TRACE(check_condition_2, [Condition, Num]),
            case check_condition_num(Type, Int, Num) of
                true -> check_condition_2(Left, Args);
                false -> false
            end
    end;
check_condition_2([{Condition, Val} | Left], Args) when is_list(Val) ->
    % ?LDS_TRACE("check_condition_2_2", [{Condition, Val} | Left]),
    case lists:keyfind(Condition, 1, Args) of
        false -> false;
        {Condition, Id} ->
            case lists:member(Id, Val) of
                true -> check_condition_2(Left, Args);
                false -> false
            end
    end;
check_condition_2(_, _) -> false.


check_condition_3(_Condition, []) -> false;
check_condition_3(Condition, [Args | Left]) ->
    % ?LDS_TRACE("check_condition_3", [Condition, Args]),
    case check_condition_2(Condition, Args) of
        true -> true;
        false -> check_condition_3(Condition, Left)
    end.


check_condition_num(0, Int, Int) -> true;
check_condition_num(0, _, _) -> false;
check_condition_num(1, Int, Num) when Num >= Int -> true;
check_condition_num(_, _, _) -> false.


check_condition_complex(_, []) -> false;
check_condition_complex([{Con, {ConNum, _ConType}}, {num, {Num, _NumType}}] = Condition, [[{Con, CurConNum}, {num, CurNum}] | Left]) ->
    case Con of
        world_boss ->
            case CurConNum =< ConNum of
                true -> 
                    case CurNum >= Num of
                        true -> true;
                        false -> check_condition_complex([{Con, {ConNum, _ConType}}, {num, {Num - CurNum, _NumType}}], Left)
                    end;
                false -> 
                    check_condition_complex(Condition, Left)
            end;
        _ ->
            case CurConNum >= ConNum of
                true -> 
                    case CurNum >= Num of
                        true -> true;
                        false -> check_condition_complex([{Con, {ConNum, _ConType}}, {num, {Num - CurNum, _NumType}}], Left)
                    end;
                false -> 
                    check_condition_complex(Condition, Left)
            end
    end;
check_condition_complex(Condition, [_ | Left]) -> check_condition_complex(Condition, Left).

%成就判断
check_condition_complex_ex([{_Con, {_ConNum, _ConType}}, {lv, {_LvNum, _LvType}}, {num, {Num, _NumType}}] = _Condition, [], Sum) -> 
    % ?ylh_Debug("Sum=~p~n", [Sum]),
    case Sum >= Num of
        true -> true;
        false -> false
     end;
check_condition_complex_ex([{Con, {ConNum, _ConType}}, {lv, {LvNum, _LvType}}, {num, {_Num, _NumType}}] = Condition, [[{Con, CurConNum}, {lv, CurLvNum}] | Left], Sum) ->
    % ?ylh_Debug("CurLvNum=~p, LvNum=~p, CurConNum=~p, ConNum=~p~n", [CurLvNum, LvNum, CurConNum, ConNum]),
    case CurLvNum >= LvNum of
        true ->
            case CurConNum >= ConNum of
                true -> 
                        Sum1 = Sum + 1,
                        check_condition_complex_ex(Condition, Left, Sum1);
                false -> 
                    check_condition_complex_ex(Condition, Left, Sum)
            end;
        false ->
            check_condition_complex_ex(Condition, Left, Sum)
    end;
check_condition_complex_ex(Condition, [_|Left], Sum) -> 
    check_condition_complex_ex(Condition, Left, Sum).

%% =========================================
%% login/logout
%% =========================================
login(RoleId, role_in_cache) ->
    tmp_login(RoleId);
login(RoleId, _) ->
    init_login(RoleId).
    % ?LDS_TRACE(achievement, role_in_cache2).


%% 加载成就数据
load_achievement(RoleId) ->
    case db:select_row(achievement_data, "`achievement`", [{role_id, RoleId}]) of
        [] -> 
            Achi = init_achievement(),
            db:insert(RoleId, achievement_data, [{role_id, RoleId}, {achievement, util:term_to_bitstring(Achi)}]),
            set_achievement(RoleId, Achi);
        [Achievement] ->
            Achi = util:bitstring_to_term(Achievement),
            % ?LDS_TRACE(load_achievement, util:bitstring_to_term(Achievement)),
            ?ylh_Debug("load_achievement ~p~n", [util:bitstring_to_term(Achievement)]),
            CorAchi = correct_achi(Achi),
            set_achievement(RoleId, CorAchi)
    end.


%% @doc 初始化上线
init_login(RoleId) ->
    load_achievement(RoleId),
    %% 加载章节目标
    mod_chapter_target:login_load(RoleId).

%% @doc 临时上线
tmp_login(RoleId) ->
    % ?LDS_TRACE(achievement, tmp_login),
    transfer_data_to_dict(RoleId).


%% @doc 临时退出
tmp_logout(RoleId) ->
    % ?LDS_TRACE(achievement, tmp_logout),
    transfer_data(RoleId).


%% @doc 最终退出
final_logout(RoleId) ->
    % ?LDS_TRACE(achievement, final_logout),
    save_transfer_data(RoleId),
    %% 章节目标退出处理
    mod_chapter_target:final_logout(RoleId).


%% @doc 初始化成就数据
init_achievement() ->
    AchiNos = data_achievement:get_nos(),
    F = fun(No, Sum) ->
        case data_achievement:get_achievement(No) of
            null -> ?ASSERT(false, [No]), Sum;
            Achi -> [{No, 0, Achi#achievement.num_limit} | Sum]
        end
    end,
    lists:foldl(F, [], AchiNos).


%% @doc 矫正成就数据
correct_achi(Achi) ->
    InitData = init_achievement(),
    correct_achi_1(InitData, Achi).

correct_achi_1(DataList, []) -> DataList;
correct_achi_1(DataList, [{No, Num, _} | Left]) ->
    NewData = 
        case lists:keyfind(No, 1, DataList) of
            false -> DataList;
            {No, _, Limit} -> lists:keyreplace(No, 1, DataList, {No, Num, Limit})
        end,
    correct_achi_1(NewData, Left).


%% =========================================
%% data
%% =========================================

%% 设置玩家功绩值
set_contri(RoleId, List) when is_list(List) ->
    F = fun({No, Num, Limit}, Sum) ->
            case Num >= Limit of
                true ->
                    case data_achievement:get_achievement(No) of
                        null -> ?ASSERT(false, [No]), Sum;
                        Achi when Achi#achievement.type =:= 1 -> Sum + Achi#achievement.contri;
                        _ -> Sum
                    end;
                false ->
                    Sum
            end     
        end,
    NewContriValue = lists:foldl(F, 0, List),
    OldContriValue = player:get_contri(player:get_PS(RoleId)),
    case NewContriValue =/= OldContriValue of
        true ->
            % AddValue = NewContriValue - OldContriValue,
            AddValue = NewContriValue,
            ?ylh_Debug("set_contri NewContriValue=~p, OldContriValue=~p, AddValue=~p~n", [NewContriValue, OldContriValue, AddValue]),
            player:set_contri(player:get_PS(RoleId), AddValue),
            player:notify_cli_contri_change(player:get_PS(RoleId));
        false ->
            skip
    end;
set_contri(_, _) -> skip.

%% @doc 设置成就数据
%% @List:: [{No, Num, Limit}]
set_achievement(_RoleId, List) when is_list(List) ->
    %% TODO 重要注释，之前不知为何会重算属性，经策划确认，屏蔽掉
%%    ply_attr:recount_all_attrs(player:get_PS(_RoleId)),
    % ?ylh_Debug("set_achievement List=~p~n", [List]),
    set_contri(_RoleId, List),
    put(?ACHIEVENT_DATA, List);
set_achievement(_, _) -> skip.

%% @doc 清除成就数据
del_achievement(_RoleId) ->
    erase(?ACHIEVENT_DATA).

%% @doc 取得成就数据
%% @return null | list():: [{No, Num, Limit}]
get_achievement(_RoleId) ->
    case get(?ACHIEVENT_DATA) of
        Achi when is_list(Achi) -> Achi;
        _ -> null
    end.

%% @doc 更新成就数据
update_achievement(_RoleId, {No, Num}) ->
    List = get_achievement(_RoleId),
    case lists:keyfind(No, 1, List) of
        false -> ?ASSERT(false, [No, List]);
        {No, OriNum, Limit} ->
            case OriNum >= Limit of
                true -> skip;
                false ->
                    AddNum = OriNum + Num,
                    NewNum = ?BIN_PRED(Limit =:= 0, AddNum, ?BIN_PRED(AddNum >= Limit, Limit, AddNum)),
                    set_achievement(_RoleId, lists:keyreplace(No, 1, List, {No, NewNum, Limit}))
            end
    end;
update_achievement(_RoleId, List) when is_list(List) ->
    set_achievement(_RoleId, List);
update_achievement(_, _) -> ?ASSERT(false).

%%检查成就任务是否通过 mod_achievement:get_achievement( 1000100000000169).
check_achievement_task(RoleId,[Object|T]) ->
    case mod_achievement:get_achievement(RoleId) of
        null ->
            false;
        AchievementList ->
            case lists:keyfind(Object, 1, AchievementList) of
                false ->
                    ?ASSERT(false,check_achievement_task),
                    false;
                {Object,FinishNum,ConditionNum} ->
                    case  FinishNum >= ConditionNum of
                        true ->
                            check_achievement_task(RoleId,T);
                        false ->
                            false
                    end

            end
    end;

%%检查成就任务是否通过
check_achievement_task(RoleId,[]) ->
    true.




%% 需要增加的属性列表
attr_bonus(RoleId) ->
    List = get_achievement(RoleId),
    F = fun({No, Num, Limit}, Acc) when Limit > 0 ->
            Data = data_achievement:get_achievement(No),
            Type = Data#achievement.type, 
            case Type == 0 of
                true -> Acc; %章节目标
                false ->     %成就
                    case Num >= Limit of
                        true ->
                            case data_achievement:get_achievement(No) of
                                Data when is_record(Data, achievement) -> 
                                    case erlang:length(Data#achievement.add_attr) == 1 of
                                        true ->
                                            [{AttrType, _AddNum, _}] = Data#achievement.add_attr,
                                            case AttrType == free_talent_points of
                                                true ->
                                                    Acc;
                                                false ->
                                                    Data#achievement.add_attr ++ Acc
                                            end;
                                        false ->
                                            Data#achievement.add_attr ++ Acc
                                    end;
                                    % 如果配置成就加潜能点和属性在一起的话始[{free_talent_points,5,0},{hp_lim,800}]用下面这个
                                    % [{AttrType, AddNum, A1}| Acc || {AttrType, AddNum, A1} <- Data#achievement.add_attr , AttrType =/= free_talent_points];
                                _ -> ?WARNING_MSG("Not have achievement ~w", [No]), Acc
                            end;
                        false ->
                            Acc
                    end
            end;
            ({_, _, Limit}, Acc) when Limit =:= 0 ->
                        Acc;
            (_, Acc) ->
                        Acc 
    end,
    AddAttr = lists:foldl(F, [], List),
    % ?ylh_Debug("AddAttr=~p ~p~n", [AddAttr, RoleId]),
    AddAttr.


%% @doc 转移数据到ets
transfer_data(RoleId) ->
    case get_achievement(RoleId) of
        null -> skip;
        List when is_list(List) ->
            update_db_achievement(RoleId, List),
            ets:insert(?ETS_ACHIEVEMENT_TMP_CACHE, {RoleId, List}),
            del_achievement(RoleId);
        _ -> ?ASSERT(false)
    end.


%% @doc 转移数据到dict
transfer_data_to_dict(RoleId) ->
    case ets:lookup(?ETS_ACHIEVEMENT_TMP_CACHE, RoleId) of
        [] -> load_achievement(RoleId);
        [{RoleId, List}] when is_list(List) -> set_achievement(RoleId, List);
        _ -> ?ASSERT(false)
    end.


%% @doc 保存被转移的数据
save_transfer_data(RoleId) ->
    case ets:lookup(?ETS_ACHIEVEMENT_TMP_CACHE, RoleId) of
        [] -> ?ASSERT(false, [RoleId]), skip;
        [{RoleId, List}] when is_list(List) ->
            update_db_achievement(RoleId, List),
            ets:delete(?ETS_ACHIEVEMENT_TMP_CACHE, RoleId);
        _ -> ets:delete(?ETS_ACHIEVEMENT_TMP_CACHE, RoleId)
    end.

%% @doc 更新成就数据
update_db_achievement(RoleId, List) when is_list(List) ->
    db:update(RoleId, achievement_data, [{achievement, util:term_to_bitstring(List)}], [{role_id, RoleId}]).


% %% @doc 取得成就编号列表
% %% @return : list()
% get_achievement_nos(_RoleId) ->
%     case get(?ACHIEVENT_NOS) of
%         List when is_list(List) -> List;
%         _ -> []
%     end.

% %% @doc 添加成就编号
% add_achievement_no(_RoleId, No) ->
%     List = get_achievement_nos(_RoleId),
%     case lists:member(No, List) of
%         true -> skip;
%         false -> set_achievement_nos([No | List])
%     end.

% %% @doc 删除成就编号
% del_achievement_no(_RoleId, No) ->
%     List = get_achievement_nos(_RoleId),
%     set_achievement_nos(lists:delete(No, List)).

% %% @doc 设置成就编号列表
% set_achievement_nos(_RoleId, List) when is_list(List) ->
%     put(?ACHIEVENT_NOS, List).