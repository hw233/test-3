%%%-------------------------------------- 
%%% @Module: lib_bt_skill
%%% @Author: huangjf
%%% @Created: 2013.12.13
%%% @Description: 战斗中与技能相关的一些业务逻辑
%%%-------------------------------------- 


-module(lib_bt_skill).
-export([
  to_bo_skill_brief/1,
  pack_skill_usable_info/1,
  has_revive_eff/1,
  decide_skill_eff_targets/2,
  filter_skill_eff_targets__/4,
  sort_skill_eff_targets__/4
  ]).
    
-include("common.hrl").
-include("battle.hrl").
-include("effect.hrl").
-include("record/battle_record.hrl").



-import(lib_bt_comm, [
            get_bo_by_id/1,
            is_dead/1,
            is_living/1,
            is_bo_exists/1,
            is_player/1,
            is_partner/1,
            is_monster/1,
            to_enemy_side/1
            ]).








%% 转为bo_skl_brf结构体
to_bo_skill_brief(SkillId) when is_integer(SkillId) ->
    #bo_skl_brf{
        id = SkillId,
        lv = 1   % 默认为1级
        };

to_bo_skill_brief({SkillId, SkillLv}) ->
    #bo_skl_brf{
        id = SkillId,
        lv = SkillLv
        };

to_bo_skill_brief(SkillBrief) when is_record(SkillBrief, skl_brief) ->
    #bo_skl_brf{
        id = SkillBrief#skl_brief.id,
        lv = SkillBrief#skl_brief.lv
        }.

% % 元组转为bo_skl_brf结构体
% to_bo_skill_brief(SrcTuple) ->
%     case SrcTuple of
%         {SkillId, SkillLv} ->
%             #bo_skl_brf{id = SkillId, lv = SkillLv};
%         % {SkillId, SkillLv, Grid} ->
%         %   #bo_skl_brf{id = SkillId, lv = SkillLv, grid = Grid};
%         % {SkillId, SkillLv, Grid, Profi} -> % 武将的技能
%         %   #bo_skl_brf{id = SkillId, lv = SkillLv, grid = Grid, profi = Profi};
%         {SkillId, SkillLv, SkillCD, StartTurn, EveryXXTurn, Proba} -> % 怪物的技能
%             ?ASSERT(SkillId /= 0),
%             ?ASSERT(SkillLv > 0, SkillLv),
%             ?ASSERT(EveryXXTurn > 0, {SkillId, SkillLv, EveryXXTurn}),
%             ?ASSERT(0 =< Proba andalso Proba =< ?PROBABILITY_BASE, Proba),
            
%             #bo_skl_brf{
%                 id = SkillId,
%                 lv = SkillLv,
%                 cd_turn = SkillCD,
%                 start_turn = StartTurn,
%                 every_xx_turn = EveryXXTurn,
%                 proba = Proba
%                 };
%         _ ->
%             ?ERROR_MSG("[BATTLE_ERR]to_bo_skill_brief() arg error: ~w", [SrcTuple]),
%             ?ASSERT(false, SrcTuple),
%             #bo_skl_brf{}
%     end.
    



%% 打包bo的技能可使用信息
pack_skill_usable_info(Bo) ->
    SkillList = lib_bo:get_initiative_skill_list(Bo),
    
    F = fun(X) ->
            SkillId = X#bo_skl_brf.id,
            IsUsable =  case lib_bo:can_use_skill(Bo, SkillId) of
                            true -> true;
                            {false, _Reason} -> false
                        end,

            SklCfg = mod_skill:get_cfg_data(SkillId),
            SkillLv = lib_bt_calc:decide_xinfa_lv_of_actor(Bo, SklCfg,false),
            LeftCDRounds = lib_bo:get_skill_left_cd_rounds(Bo, SkillId),

            <<
                SkillId : 32,
                (util:bool_to_oz(IsUsable)) : 8,
                LeftCDRounds : 8,
                SkillLv : 16
            >>
        end,

    UsableInfo_List = [F(X) || X <- SkillList],
    ?BT_LOG(io_lib:format("pack_skill_usable_info(), BoId=~p, BoType=~p, UsableInfo_List=~w~n", [lib_bo:id(Bo), lib_bo:get_type(Bo), UsableInfo_List])),
    <<  
        (length(UsableInfo_List)) : 16, 
        (list_to_binary(UsableInfo_List)) / binary
    >>.


% %% 打包主宠的技能可使用情况
% pack_skill_usable_info(partner, Bo) ->
%     ?ASSERT(is_partner(Bo), Bo),
%     SkillList = lib_bo:get_skill_list(Bo),
%     CurRound = lib_bt_comm:get_cur_round(),
    
%     F = fun(X) ->
            
%             %%%IsCDing = X#bo_skl_brf.cd_over_round > CurRound,
%             SkillId = X#bo_skl_brf.id,
%             IsUsable = lib_bo:can_use_skill(Bo, SkillId),
%             LeftCDRounds = lib_bo:get_skill_left_cd_rounds(Bo, SkillId),
%             <<
%                 SkillId :32,
%                 (util:bool_to_oz(IsUsable)) : 8,
%                 LeftCDRounds : 8
%             >>
%         end,

%     UsableInfo_List = [F(X) || X <- SkillList],
%     ?BT_LOG(io_lib:format("pack_skill_usable_info(partner, ..), BoId=~p, UsableInfo_List=~w~n", [lib_bo:id(Bo), UsableInfo_List])),
%     <<  
%         (length(UsableInfo_List)) : 16, 
%         (list_to_binary(UsableInfo_List)) / binary
%     >>.






%% 判断某技能效果是否有复活效果
has_revive_eff(SkillEff) ->
    SkillEff#skl_eff.name == ?EN_REVIVE.







%% 判定技能效果的作用目标
%% @return: [] | 目标bo id列表
decide_skill_eff_targets(ActorId, Eff) ->
    ?ASSERT(is_integer(ActorId), ActorId),
    ?ASSERT(is_record(Eff, skl_eff), Eff),
    ?ASSERT(Eff#skl_eff.rules_filter_target /= [], Eff),

    %%Bo = get_bo_by_id(ActorId),

    Actor = get_bo_by_id(ActorId),
    %%case Eff#eff.targets of

    % old:
    % case Eff#skl_eff.rules_decide_target of
    %   [myself] ->
    %       [ActorId];
    %   [{ally_side, all}] ->
    %       L = get_bo_id_list( lib_bo:get_side(Bo) ),
    %       ?ASSERT(lists:member(ActorId, L), {ActorId, L}),
    %       L;
    %   [{enemy_side, all}] ->
    %       L = get_bo_id_list( get_enemy_side(lib_bo:get_side(Bo)) ),
    %       ?ASSERT(not lists:member(ActorId, L), {ActorId, L}),
    %       L;
    %   [cur_att_target] -> % 当前的攻击目标
    %       case lib_bo:get_cur_att_target(Bo) of
    %           ?INVALID_ID ->
    %               [];
    %           CurAttTarget_BoId ->
    %               ?ASSERT(is_integer(CurAttTarget_BoId), CurAttTarget_BoId),
    %               [CurAttTarget_BoId]
    %       end;

    %   [enemy_side, cur_pick_target_first, undead] ->
    %       .....  when back todo here       考虑： 对于多个规则的情况， 是否最好拆开， 一个一个单独做处理，轮流做筛选？

    %   _Any ->
    %       ?ASSERT(false, _Any),
    %       []
    % end.


    TargetBoIdL = decide_skill_eff_targets(here_we_go, Actor, Eff),
    ?ASSERT(is_list(TargetBoIdL), TargetBoIdL),

    % 依据不同的效果类型，进一步细化判定（部分作用目标的判定需要与效果类型挂钩）
    TargetBoIdL2 = case Eff#skl_eff.name of
        ?EN_DO_ATTACK -> % 执行攻击
            more_decide_skill_eff_targets(for_do_attack, TargetBoIdL, Actor, Eff);
        ?EN_ADD_BUFF -> % 施法：加buff
            more_decide_skill_eff_targets(for_add_buff, TargetBoIdL, Actor, Eff);
        % ?EN_HEAL_HP -> % 治疗：加血
        %   more_decide_skill_eff_targets(for_heal_hp, TargetBoIdL, Actor, Eff);
        _ ->
            TargetBoIdL
    end,
    ?ASSERT(is_list(TargetBoIdL2), TargetBoIdL2),

    % 最后，截取个数
    MaxCount = lib_bt_calc:calc_skill_eff_target_count(Actor, Eff),  %%Eff#skl_eff.target_count,
    RetList = lists:sublist(TargetBoIdL2, MaxCount),
    ?TRACE("decide_skill_eff_targets(), RetList:~p, ActorId:~p, Eff:~p~n", [RetList, ActorId, Eff]),
    RetList.

%%这里是主动技能的筛选目标wjc
decide_skill_eff_targets(here_we_go, Actor, Eff) ->
    % 初始选择范围为所有的bo
    AllBoIdList = lib_bt_comm:get_all_bo_id_list(),

    % 先筛选 --增加过滤无敌状态的单位
    RuleList_Filter = lists:merge(Eff#skl_eff.rules_filter_target,[?RDT_NOT_INVINCIBLE]),
    BoIdList_Filtered = filter_skill_eff_targets__(Actor, Eff, RuleList_Filter, AllBoIdList),

    % ?DEBUG_MSG("decide_skill_eff_targets(), BoIdList_Filtered: ~w", [BoIdList_Filtered]),

    % 然后对筛选出的目标做排序
    RuleList_Sort = Eff#skl_eff.rules_sort_target,
    BoIdList_Sorted = sort_skill_eff_targets__(Actor, Eff, RuleList_Sort, BoIdList_Filtered),


    % ?DEBUG_MSG("decide_skill_eff_targets(), BoIdList_Sorted: ~w", [BoIdList_Sorted]),
    % 处理排序规则时可能做了拆分， 故要flatten一下
    lists:flatten(BoIdList_Sorted).



filter_skill_eff_targets__(_Actor, _Eff, [], Src_TargetBoIdList) ->
    Src_TargetBoIdList;
filter_skill_eff_targets__(Actor, Eff, [Rule | T], Src_TargetBoIdList) ->
    case filter_skill_eff_targets_by_rule(Rule, Actor, Eff, Src_TargetBoIdList) of
        [] ->
            [];
        Src_TargetBoIdList_2 ->
            ?ASSERT(is_list(Src_TargetBoIdList_2), {Src_TargetBoIdList_2, Rule}),
            filter_skill_eff_targets__(Actor, Eff, T, Src_TargetBoIdList_2)
    end.

            



sort_skill_eff_targets__(_Actor, _Eff, _RuleList, []) ->
    [];
sort_skill_eff_targets__(_Actor, _Eff, [], Src_TargetBoIdList) ->
    Src_TargetBoIdList;
sort_skill_eff_targets__(Actor, Eff, [Rule | T], Src_TargetBoIdList) ->
    % 注意：返回的Src_TargetBoIdList_2有可能是一个嵌套的列表！
    Src_TargetBoIdList_2 = sort_skill_eff_targets_by_rule(Rule, Actor, Eff, Src_TargetBoIdList),

    % Ret_TargetBoIdList_2 = [L | Ret_TargetBoIdList],

    sort_skill_eff_targets__(Actor, Eff, T, Src_TargetBoIdList_2).




filter_skill_eff_targets_by_rule(Rule, Actor, _Eff, Src_TargetBoIdList) ->
    lib_bt_misc:filter_bo_by_rule(Rule, Actor, Src_TargetBoIdList).







%%!!!!!!! 注意：排序规则处理函数中的参数Src_TargetBoIdList有可能为嵌套的列表，
%%              使用嵌套列表是为了避免后面的排序覆盖掉前面排序的效果，具体可参看战斗系统文档  -- huangjf   !!!!!!!!       
%% 排序：当前选定的目标优先
sort_skill_eff_targets_by_rule(?RDT_CUR_PICK_TARGET_FIRST, Actor, _Eff, Src_TargetBoIdList) ->
    % CurPickTar = lib_bo:get_cur_pick_target(Actor),
    % case lists:member(CurPickTar, Src_TargetBoIdList) of
    %   true ->
    %       L = Src_TargetBoIdList -- [CurPickTar],
    %       [CurPickTar | L];
    %   false ->
    %       Src_TargetBoIdList
    % end;

    F = fun(L) -> % L为bo的id列表
            ?ASSERT(util:is_integer_list(L), {L, Src_TargetBoIdList}),
            CurPickTar = lib_bo:get_cur_pick_target(Actor),
            case lists:member(CurPickTar, L) of
                true ->
                    % 提取出CurPickTar，独立成为一个列表，并放在头部
                    L2 = L -- [CurPickTar],
                    [ [CurPickTar], L2 ];
                false ->
                    L
            end
        end,
    sort_targets(Src_TargetBoIdList, F);





% %% 排序：无HOT类buff者优先
% sort_skill_eff_targets_by_rule(?RDT_HAS_NOT_HOT_BUFF_FIRST, _Actor, _Eff, Src_TargetBoIdList) ->
%   F = fun(L) ->  % L为bo的id列表
%           ?ASSERT(util:is_integer_list(L), {L, Src_TargetBoIdList}),
%           L_HasHotBuff = [BoId || BoId <- L,  begin 
%                                                   Bo = get_bo_by_id(BoId), 
%                                                   ?ASSERT(Bo /= null, {BoId, L}), 
%                                                   lib_bo:has_HOT_buff(Bo) 
%                                               end],

%           L_HasNotHotBuff = L -- L_HasHotBuff,

%           case L_HasNotHotBuff of
%               [] ->
%                   L;
%               _ ->
%                   % 独立出无hot类buff和有hot类buff的bo，并且无hot类buff的放在头部
%                   [L_HasNotHotBuff, L_HasHotBuff]
%           end
%       end,
%   sort_targets(Src_TargetBoIdList, F);


% %% 排序：无DOT类buff者优先
% sort_skill_eff_targets_by_rule(?RDT_HAS_NOT_DOT_BUFF_FIRST, _Actor, _Eff, Src_TargetBoIdList) ->
%   F = fun(L) ->  % L为bo的id列表
%           ?ASSERT(util:is_integer_list(L), {L, Src_TargetBoIdList}),
%           L_HasDotBuff = [BoId || BoId <- L,  begin 
%                                                   Bo = get_bo_by_id(BoId), 
%                                                   ?ASSERT(Bo /= null, {BoId, L}), 
%                                                   lib_bo:has_DOT_buff(Bo) 
%                                               end],

%           L_HasNotDotBuff = L -- L_HasDotBuff,

%           case L_HasNotDotBuff of
%               [] ->
%                   L;
%               _ ->
%                   % 独立出无dot类buff和有dot类buff的bo，并且无dot类buff的放在头部
%                   [L_HasNotDotBuff, L_HasDotBuff]
%           end
%       end,
%   sort_targets(Src_TargetBoIdList, F);



%% 排序：有指定编号的buff者优先
sort_skill_eff_targets_by_rule({?RDT_HAS_SPEC_BUFF_FIRST, BuffNo}, _Actor, _Eff, Src_TargetBoIdList) ->
    ?ASSERT(lib_buff_tpl:is_exists(BuffNo), {BuffNo, _Eff}),

    F = fun(L) ->  % L为bo的id列表
            ?ASSERT(util:is_integer_list(L), {L, Src_TargetBoIdList}),
            L_HasSpecificBuff = [BoId || BoId <- L, begin 
                                                        Bo = get_bo_by_id(BoId), 
                                                        ?ASSERT(Bo /= null, {BoId, L}), 
                                                        lib_bo:has_spec_no_buff(Bo, BuffNo) 
                                                    end],

            L_HasNotSpecificBuff = L -- L_HasSpecificBuff,

            case L_HasSpecificBuff of
                [] ->
                    L;
                _ ->
                    % 独立出有指定编号的buff者和无指定编号的buff者，并且有的放在头部
                    [L_HasSpecificBuff, L_HasNotSpecificBuff]
            end
        end,
    sort_targets(Src_TargetBoIdList, F);



%% 排序：无指定编号的buff者优先
sort_skill_eff_targets_by_rule({?RDT_HAS_NOT_SPEC_BUFF_FIRST, BuffNo}, _Actor, _Eff, Src_TargetBoIdList) ->
    ?ASSERT(lib_buff_tpl:is_exists(BuffNo), {BuffNo, _Eff}),

    F = fun(L) ->  % L为bo的id列表
            ?ASSERT(util:is_integer_list(L), {L, Src_TargetBoIdList}),
            L_HasNotSpecificBuff = [BoId || BoId <- L,  begin 
                                                            Bo = get_bo_by_id(BoId), 
                                                            ?ASSERT(Bo /= null, {BoId, L}), 
                                                            not lib_bo:has_spec_no_buff(Bo, BuffNo) 
                                                        end],

            L_HasSpecificBuff = L -- L_HasNotSpecificBuff,

            case L_HasNotSpecificBuff of
                [] ->
                    L;
                _ ->
                    % 独立出无指定编号的buff者和有指定编号的buff者，并且无的放在头部
                    [L_HasNotSpecificBuff, L_HasSpecificBuff]
            end
        end,
    sort_targets(Src_TargetBoIdList, F);




%% 排序：有指定类别的buff者优先
sort_skill_eff_targets_by_rule({?RDT_HAS_SPEC_CATEGORY_BUFF_FIRST, Category}, _Actor, _Eff, Src_TargetBoIdList) ->
    ?ASSERT(util:is_positive_int(Category), {Category, _Eff}),

    F = fun(L) ->  % L为bo的id列表
            ?ASSERT(util:is_integer_list(L), {L, Src_TargetBoIdList}),
            L_HasSpecificBuff = [BoId || BoId <- L, begin 
                                                        Bo = get_bo_by_id(BoId), 
                                                        ?ASSERT(Bo /= null, {BoId, L}), 
                                                        lib_bo:has_spec_category_buff(Bo, Category) 
                                                    end],

            L_HasNotSpecificBuff = L -- L_HasSpecificBuff,

            case L_HasSpecificBuff of
                [] ->
                    L;
                _ ->
                    % 独立出有指定类别的buff者和无指定类别的buff者，并且有的放在头部
                    [L_HasSpecificBuff, L_HasNotSpecificBuff]
            end
        end,
    sort_targets(Src_TargetBoIdList, F);
    


%% 排序：无指定类别的buff者优先
sort_skill_eff_targets_by_rule({?RDT_HAS_NOT_SPEC_CATEGORY_BUFF_FIRST, Category}, _Actor, _Eff, Src_TargetBoIdList) ->
    ?ASSERT(util:is_positive_int(Category), {Category, _Eff}),

    F = fun(L) ->  % L为bo的id列表
            ?ASSERT(util:is_integer_list(L), {L, Src_TargetBoIdList}),
            L_HasNotSpecificBuff = [BoId || BoId <- L,  begin 
                                                            Bo = get_bo_by_id(BoId), 
                                                            ?ASSERT(Bo /= null, {BoId, L}), 
                                                            not lib_bo:has_spec_category_buff(Bo, Category) 
                                                        end],

            L_HasSpecificBuff = L -- L_HasNotSpecificBuff,

            case L_HasNotSpecificBuff of
                [] ->
                    L;
                _ ->
                    % 独立出无指定类别的buff者和有指定类别的buff者，并且无的放在头部
                    [L_HasNotSpecificBuff, L_HasSpecificBuff]
            end
        end,
    sort_targets(Src_TargetBoIdList, F);



%% 排序：重新乱序目标列表
sort_skill_eff_targets_by_rule(?RDT_RE_DISORDER, _Actor, _Eff, Src_TargetBoIdList) ->
    % L = lists:flatten(Src_TargetBoIdList),
    % L2 = tool:shuffle(L, length(L)),
    % ?BT_LOG(io_lib:format("sort_skill_eff_targets_by_rule(RDT_RE_DISORDER, ..),  L2:~w~n", [L2])),
    % ?ASSERT(is_list(L2), L2),
    % L2;

    F = fun(L) ->  % L为bo的id列表
            ?ASSERT(util:is_integer_list(L), {L, Src_TargetBoIdList}),
            L2 = util:shuffle(L),
            ?BT_LOG(io_lib:format("sort_skill_eff_targets_by_rule(RDT_RE_DISORDER, ..),  L2:~w~n", [L2])),
            ?ASSERT(is_list(L2), L2),
            L2
        end,
    sort_targets(Src_TargetBoIdList, F);



%% 排序：随机集火原则（按本场战斗预安排的随机站位顺序）
sort_skill_eff_targets_by_rule(?RDT_SJJH_PRINCIPLE, _Actor, _Eff, Src_TargetBoIdList) ->
    F = fun(L) -> % L为bo的id列表
            ?ASSERT(util:is_integer_list(L), {L, Src_TargetBoIdList}),
            case L of
                [] ->
                    [];
                [OnlyOneEle] ->
                    [OnlyOneEle];
                _ ->
                    F__ =   fun(BoId) ->
                                Bo = get_bo_by_id(BoId),
                                ?ASSERT(Bo /= null, {BoId, L, Src_TargetBoIdList, _Eff, _Actor}),
                                VirtualPos = lib_bo:calc_virtual_pos_for_sjjh(Bo),
                                {BoId, VirtualPos}
                            end,

                    % VPos: virtual position    
                    BoId_VPos_List = [F__(X) || X <- L],

                    PresetRandPosOrder = lib_bt_dict:get_preset_rand_pos_order(),
                    VPosList_Sorted = [X || X <- PresetRandPosOrder, lists:keyfind(X, 2, BoId_VPos_List) /= false],

                    BoId_VPos_List_Sorted = [lists:keyfind(X, 2, BoId_VPos_List) || X <- VPosList_Sorted],

                    BoIdList_Sorted = [BoId || {BoId, _VPos} <- BoId_VPos_List_Sorted],

                    ?TRACE("RDT_SJJH_PRINCIPLE, BoIdList_Sorted=~p", [BoIdList_Sorted]),
                    BoIdList_Sorted
            end
        end,
    sort_targets(Src_TargetBoIdList, F);


%% 排序：按血量从低到高(ASCE: ascending)
sort_skill_eff_targets_by_rule(?RDT_SORT_BY_HP_ASCE, _Actor, _Eff, Src_TargetBoIdList) ->
    F = fun(L) ->  % L为bo的id列表
            ?ASSERT(util:is_integer_list(L), {L, Src_TargetBoIdList}),
            F__ = fun(BoId_A, BoId_B) ->
                      Bo_A = get_bo_by_id(BoId_A),
                      Bo_B = get_bo_by_id(BoId_B),
                      ?ASSERT(Bo_A /= null, {BoId_A, L}),
                      ?ASSERT(Bo_B /= null, {BoId_B, L}),

                      lib_bo:get_hp(Bo_A) < lib_bo:get_hp(Bo_B)
                  end,
            lists:sort(F__, L)
        end,
    sort_targets(Src_TargetBoIdList, F);


%% 排序：按血量从高到低(DESC: descending)
sort_skill_eff_targets_by_rule(?RDT_SORT_BY_HP_DESC, _Actor, _Eff, Src_TargetBoIdList) ->
    F = fun(L) ->  % L为bo的id列表
            ?ASSERT(util:is_integer_list(L), {L, Src_TargetBoIdList}),
            F__ = fun(BoId_A, BoId_B) ->
                      Bo_A = get_bo_by_id(BoId_A),
                      Bo_B = get_bo_by_id(BoId_B),
                      ?ASSERT(Bo_A /= null, {BoId_A, L}),
                      ?ASSERT(Bo_B /= null, {BoId_B, L}),

                      lib_bo:get_hp(Bo_A) > lib_bo:get_hp(Bo_B)
                  end,
            lists:sort(F__, L)
        end,
    sort_targets(Src_TargetBoIdList, F);


%% 排序：按蓝量从低到高
sort_skill_eff_targets_by_rule(?RDT_SORT_BY_MP_ASCE, _Actor, _Eff, Src_TargetBoIdList) ->
    F = fun(L) ->  % L为bo的id列表
            ?ASSERT(util:is_integer_list(L), {L, Src_TargetBoIdList}),
            F__ = fun(BoId_A, BoId_B) ->
                      Bo_A = get_bo_by_id(BoId_A),
                      Bo_B = get_bo_by_id(BoId_B),
                      ?ASSERT(Bo_A /= null, {BoId_A, L}),
                      ?ASSERT(Bo_B /= null, {BoId_B, L}),

                      lib_bo:get_mp(Bo_A) < lib_bo:get_mp(Bo_B)
                  end,
            lists:sort(F__, L)
        end,
    sort_targets(Src_TargetBoIdList, F);


%% 排序：按蓝量从高到低
sort_skill_eff_targets_by_rule(?RDT_SORT_BY_MP_DESC, _Actor, _Eff, Src_TargetBoIdList) ->
    F = fun(L) ->  % L为bo的id列表
            ?ASSERT(util:is_integer_list(L), {L, Src_TargetBoIdList}),
            F__ = fun(BoId_A, BoId_B) ->
                      Bo_A = get_bo_by_id(BoId_A),
                      Bo_B = get_bo_by_id(BoId_B),
                      ?ASSERT(Bo_A /= null, {BoId_A, L}),
                      ?ASSERT(Bo_B /= null, {BoId_B, L}),

                      lib_bo:get_mp(Bo_A) > lib_bo:get_mp(Bo_B)
                  end,
            lists:sort(F__, L)
        end,
    sort_targets(Src_TargetBoIdList, F);

%% 排序：按速度从低到高
sort_skill_eff_targets_by_rule(?RDT_SORT_BY_ACT_SPEED_ASCE, _Actor, _Eff, Src_TargetBoIdList) ->
    F = fun(L) ->  % L为bo的id列表
            ?ASSERT(util:is_integer_list(L), {L, Src_TargetBoIdList}),
            F__ = fun(BoId_A, BoId_B) ->
                      Bo_A = get_bo_by_id(BoId_A),
                      Bo_B = get_bo_by_id(BoId_B),
                      ?ASSERT(Bo_A /= null, {BoId_A, L}),
                      ?ASSERT(Bo_B /= null, {BoId_B, L}),

                      lib_bo:get_act_speed(Bo_A) < lib_bo:get_act_speed(Bo_B)
                  end,
            lists:sort(F__, L)
        end,
    sort_targets(Src_TargetBoIdList, F);


%% 排序：按速度从高到低
sort_skill_eff_targets_by_rule(?RDT_SORT_BY_ACT_SPEED_DESC, _Actor, _Eff, Src_TargetBoIdList) ->
    F = fun(L) ->  % L为bo的id列表
            ?ASSERT(util:is_integer_list(L), {L, Src_TargetBoIdList}),
            F__ = fun(BoId_A, BoId_B) ->
                      Bo_A = get_bo_by_id(BoId_A),
                      Bo_B = get_bo_by_id(BoId_B),
                      ?ASSERT(Bo_A /= null, {BoId_A, L}),
                      ?ASSERT(Bo_B /= null, {BoId_B, L}),

                      lib_bo:get_act_speed(Bo_A) > lib_bo:get_act_speed(Bo_B)
                  end,
            lists:sort(F__, L)
        end,
    sort_targets(Src_TargetBoIdList, F);



%------------------------------------------------------
%% 排序：按物理攻击从低到高
sort_skill_eff_targets_by_rule(?RDT_SORT_BY_PHY_ATT_ASCE, _Actor, _Eff, Src_TargetBoIdList) ->
    F = fun(L) ->  % L为bo的id列表
            ?ASSERT(util:is_integer_list(L), {L, Src_TargetBoIdList}),
            F__ = fun(BoId_A, BoId_B) ->
                      Bo_A = get_bo_by_id(BoId_A),
                      Bo_B = get_bo_by_id(BoId_B),
                      ?ASSERT(Bo_A /= null, {BoId_A, L}),
                      ?ASSERT(Bo_B /= null, {BoId_B, L}),

                      lib_bo:get_phy_att(Bo_A) < lib_bo:get_phy_att(Bo_B)
                  end,
            lists:sort(F__, L)
        end,
    sort_targets(Src_TargetBoIdList, F);


%% 排序：按物理攻击从高到低
sort_skill_eff_targets_by_rule(?RDT_SORT_BY_PHY_ATT_DESC, _Actor, _Eff, Src_TargetBoIdList) ->
    F = fun(L) ->  % L为bo的id列表
            ?ASSERT(util:is_integer_list(L), {L, Src_TargetBoIdList}),
            F__ = fun(BoId_A, BoId_B) ->
                      Bo_A = get_bo_by_id(BoId_A),
                      Bo_B = get_bo_by_id(BoId_B),
                      ?ASSERT(Bo_A /= null, {BoId_A, L}),
                      ?ASSERT(Bo_B /= null, {BoId_B, L}),

                      lib_bo:get_phy_att(Bo_A) > lib_bo:get_phy_att(Bo_B)
                  end,
            lists:sort(F__, L)
        end,
    sort_targets(Src_TargetBoIdList, F);

%% 排序：按物理防御从低到高
sort_skill_eff_targets_by_rule(?RDT_SORT_BY_PHY_DEF_ASCE, _Actor, _Eff, Src_TargetBoIdList) ->
    F = fun(L) ->  % L为bo的id列表
            ?ASSERT(util:is_integer_list(L), {L, Src_TargetBoIdList}),
            F__ = fun(BoId_A, BoId_B) ->
                      Bo_A = get_bo_by_id(BoId_A),
                      Bo_B = get_bo_by_id(BoId_B),
                      ?ASSERT(Bo_A /= null, {BoId_A, L}),
                      ?ASSERT(Bo_B /= null, {BoId_B, L}),

                      lib_bo:get_phy_def(Bo_A) < lib_bo:get_phy_def(Bo_B)
                  end,
            lists:sort(F__, L)
        end,
    sort_targets(Src_TargetBoIdList, F);


%% 排序：按物理防御从高到低
sort_skill_eff_targets_by_rule(?RDT_SORT_BY_PHY_DEF_DESC, _Actor, _Eff, Src_TargetBoIdList) ->
    F = fun(L) ->  % L为bo的id列表
            ?ASSERT(util:is_integer_list(L), {L, Src_TargetBoIdList}),
            F__ = fun(BoId_A, BoId_B) ->
                      Bo_A = get_bo_by_id(BoId_A),
                      Bo_B = get_bo_by_id(BoId_B),
                      ?ASSERT(Bo_A /= null, {BoId_A, L}),
                      ?ASSERT(Bo_B /= null, {BoId_B, L}),

                      lib_bo:get_phy_def(Bo_A) > lib_bo:get_phy_def(Bo_B)
                  end,
            lists:sort(F__, L)
        end,
    sort_targets(Src_TargetBoIdList, F);



%% 排序：按法术攻击从低到高
sort_skill_eff_targets_by_rule(?RDT_SORT_BY_MAG_ATT_ASCE, _Actor, _Eff, Src_TargetBoIdList) ->
    F = fun(L) ->  % L为bo的id列表
            ?ASSERT(util:is_integer_list(L), {L, Src_TargetBoIdList}),
            F__ = fun(BoId_A, BoId_B) ->
                      Bo_A = get_bo_by_id(BoId_A),
                      Bo_B = get_bo_by_id(BoId_B),
                      ?ASSERT(Bo_A /= null, {BoId_A, L}),
                      ?ASSERT(Bo_B /= null, {BoId_B, L}),

                      lib_bo:get_mag_att(Bo_A) < lib_bo:get_mag_att(Bo_B)
                  end,
            lists:sort(F__, L)
        end,
    sort_targets(Src_TargetBoIdList, F);


%% 排序：按法术攻击从高到低
sort_skill_eff_targets_by_rule(?RDT_SORT_BY_MAG_ATT_DESC, _Actor, _Eff, Src_TargetBoIdList) ->
    F = fun(L) ->  % L为bo的id列表
            ?ASSERT(util:is_integer_list(L), {L, Src_TargetBoIdList}),
            F__ = fun(BoId_A, BoId_B) ->
                      Bo_A = get_bo_by_id(BoId_A),
                      Bo_B = get_bo_by_id(BoId_B),
                      ?ASSERT(Bo_A /= null, {BoId_A, L}),
                      ?ASSERT(Bo_B /= null, {BoId_B, L}),

                      lib_bo:get_mag_att(Bo_A) > lib_bo:get_mag_att(Bo_B)
                  end,
            lists:sort(F__, L)
        end,
    sort_targets(Src_TargetBoIdList, F);




%% 排序：按法术防御从低到高
sort_skill_eff_targets_by_rule(?RDT_SORT_BY_MAG_DEF_ASCE, _Actor, _Eff, Src_TargetBoIdList) ->
    F = fun(L) ->  % L为bo的id列表
            ?ASSERT(util:is_integer_list(L), {L, Src_TargetBoIdList}),
            F__ = fun(BoId_A, BoId_B) ->
                      Bo_A = get_bo_by_id(BoId_A),
                      Bo_B = get_bo_by_id(BoId_B),
                      ?ASSERT(Bo_A /= null, {BoId_A, L}),
                      ?ASSERT(Bo_B /= null, {BoId_B, L}),

                      lib_bo:get_mag_def(Bo_A) < lib_bo:get_mag_def(Bo_B)
                  end,
            lists:sort(F__, L)
        end,
    sort_targets(Src_TargetBoIdList, F);


%% 排序：按法术防御从高到低
sort_skill_eff_targets_by_rule(?RDT_SORT_BY_MAG_DEF_DESC, _Actor, _Eff, Src_TargetBoIdList) ->
    F = fun(L) ->  % L为bo的id列表
            ?ASSERT(util:is_integer_list(L), {L, Src_TargetBoIdList}),
            F__ = fun(BoId_A, BoId_B) ->
                      Bo_A = get_bo_by_id(BoId_A),
                      Bo_B = get_bo_by_id(BoId_B),
                      ?ASSERT(Bo_A /= null, {BoId_A, L}),
                      ?ASSERT(Bo_B /= null, {BoId_B, L}),

                      lib_bo:get_mag_def(Bo_A) > lib_bo:get_mag_def(Bo_B)
                  end,
            lists:sort(F__, L)
        end,
    sort_targets(Src_TargetBoIdList, F);


%% 排序：死亡者优先
sort_skill_eff_targets_by_rule(?RDT_DEAD_FIRST, _Actor, _Eff, Src_TargetBoIdList) ->
    F = fun(L) ->  % L为bo的id列表
            ?ASSERT(util:is_integer_list(L), {L, Src_TargetBoIdList}),
            
            L_Dead = [BoId || BoId <- L, is_dead(BoId)],    
                                            % begin 
                                            %   Bo = get_bo_by_id(BoId),
                                            %   ?ASSERT(Bo /= null, {BoId, L}), 
                                            %   is_dead(Bo) 
                                            % end],
            L_Undead = L -- L_Dead,
            case L_Dead of
                [] ->
                    L;
                _ ->
                    % 独立出已死亡和未死亡的bo，并且已死亡的放在头部
                    [L_Dead, L_Undead]
            end
        end,
    sort_targets(Src_TargetBoIdList, F);




%% 排序：不处于冰冻状态者优先
sort_skill_eff_targets_by_rule(?RDT_NOT_FROZEN_FIRST, _Actor, _Eff, Src_TargetBoIdList) ->
    F = fun(L) ->  % L为bo的id列表
            ?ASSERT(util:is_integer_list(L), {L, Src_TargetBoIdList}),
            
            L_NotFrozen = [BoId || BoId <- L, not lib_bo:is_frozen( get_bo_by_id(BoId))],
            L_Frozen = L -- L_NotFrozen,
            case L_NotFrozen of
                [] ->
                    L;
                _ ->
                    % 独立出非冰冻和冰冻的bo，并且非冰冻的放在头部
                    [L_NotFrozen, L_Frozen]
            end
        end,
    sort_targets(Src_TargetBoIdList, F);

%% 排序：不处于昏睡状态者优先
sort_skill_eff_targets_by_rule(?RDT_NOT_TRANCE_FIRST, _Actor, _Eff, Src_TargetBoIdList) ->
    F = fun(L) ->  % L为bo的id列表
            ?ASSERT(util:is_integer_list(L), {L, Src_TargetBoIdList}),
            
            L_NotFrozen = [BoId || BoId <- L, not lib_bo:is_trance( get_bo_by_id(BoId))],
            L_Frozen = L -- L_NotFrozen,
            case L_NotFrozen of
                [] ->
                    L;
                _ ->
                    % 独立出非冰冻和冰冻的bo，并且非冰冻的放在头部
                    [L_NotFrozen, L_Frozen]
            end
        end,
    sort_targets(Src_TargetBoIdList, F);

%% 排序：指定编号的战斗怪优先
sort_skill_eff_targets_by_rule({?RDT_SPEC_MON_FIRST, BMonNo}, _Actor, _Eff, Src_TargetBoIdList) ->
    ?ASSERT(util:is_positive_int(BMonNo), {BMonNo, _Eff}),
    F = fun(L) ->  % L为bo的id列表
            ?ASSERT(util:is_integer_list(L), {L, Src_TargetBoIdList}),
            
            L_SpecMon = [BoId || BoId <- L, begin 
                                                Bo = get_bo_by_id(BoId), 
                                                ?ASSERT(Bo /= null, {BoId, L}), 
                                                lib_bt_comm:is_monster(Bo) andalso (lib_bo:get_parent_obj_id(Bo) == BMonNo)
                                            end],
            L_NonSpecMon = L -- L_SpecMon,
            case L_SpecMon of
                [] ->
                    L;
                _ ->
                    % 独立出指定的战斗怪bo和非指定的战斗怪bo，并且指定的放在头部
                    [L_SpecMon, L_NonSpecMon]
            end
        end,
    sort_targets(Src_TargetBoIdList, F);


% %% 排序：当前嘲讽我的bo优先
% sort_skill_eff_targets_by_rule(?RDT_HE_WHO_TAUNT_ME_FIRST, Actor, _Eff, Src_TargetBoIdList) ->
%   F = fun(L) ->  % L为bo的id列表
%           ?ASSERT(util:is_integer_list(L), {L, Src_TargetBoIdList}),
            
%           BoId_HeWhoTauntMe = lib_bo:get_he_who_taunt_me(Actor),
%           L_HeWhoTauntMe = [BoId || BoId <- L, BoId == BoId_HeWhoTauntMe],
%           ?ASSERT(length(L_HeWhoTauntMe) =< 1, {L_HeWhoTauntMe, Actor}),  % 断言：最多同时只能有一个人嘲讽我
            
%           case L_HeWhoTauntMe of
%               [] ->
%                   L;
%               _ ->
%                   % 独立出当前嘲讽我的bo和没有嘲讽我的bo，并且当前嘲讽我的bo放在头部
%                   L_HeWhoNotTauntMe = L -- L_HeWhoTauntMe,
%                   [L_HeWhoTauntMe, L_HeWhoNotTauntMe]
%           end
%       end,
%   sort_targets(Src_TargetBoIdList, F);

%% 排序：对我身上释放指定类别buff的bo优先 （buff来源优先）
sort_skill_eff_targets_by_rule({?RDT_SPEC_CATEGORY_BUFF_FROM_FIRST, BuffCategory}, _Actor, _Eff, Src_TargetBoIdList) ->
    F = fun(L) ->  % L为bo的id列表
            ?ASSERT(util:is_integer_list(L), {L, Src_TargetBoIdList}),
            % 得到我身上该类别的所有buff
            SpecBuffs = lib_bo:find_buff_list_by_category(_Actor, BuffCategory),
            % 得到这些buff的来源bo
            SpecBuffFromBoId = [ Buff#bo_buff.from_bo_id || Buff <- SpecBuffs, Buff#bo_buff.from_bo_id=/=?INVALID_ID ],

            L_No_SpecBuffFromBoId = L -- SpecBuffFromBoId,
            L_SpecBuffFromBoId = L -- L_No_SpecBuffFromBoId,
            case L_SpecBuffFromBoId of
                [] ->
                    L;
                _ ->
                    [L_SpecBuffFromBoId, L_No_SpecBuffFromBoId]
            end
        end,
    sort_targets(Src_TargetBoIdList, F);



sort_skill_eff_targets_by_rule(_Rule, _Actor, _Eff, _) ->
    ?ASSERT(false, {_Rule, _Eff, _Actor}),
    [].




%% 排序目标
sort_targets(L, SortFunc) ->
    case L of
        [L1, L2] when is_list(L1), is_list(L2) ->
            [sort_targets(L1, SortFunc), sort_targets(L2, SortFunc)];
        _ ->
            ?ASSERT(util:is_integer_list(L), L),
            SortFunc(L)
    end.





more_decide_skill_eff_targets(for_do_attack, Src_TargetBoIdL, Actor, _Eff) ->
    ActorId = lib_bo:id(Actor),
    % 过滤掉无法攻击的目标
    L = [X || X <- Src_TargetBoIdL, lib_bt_comm:can_attack(ActorId, X)],
    case lib_bo:is_chaos(Actor) of
        true ->
            % 混乱状态下是随机挑选攻击目标，故这里乱序一下
            L2 = tool:shuffle(L, length(L)),
            ?TRACE("more_decide_skill_eff_targets(), L2: ~p~n", [L2]),
            L2;
        false ->
          %%如果是沉默则攻击筛选的第一个对象
            L
    end;

            

more_decide_skill_eff_targets(for_add_buff, Src_TargetBoIdL, _Actor, _Eff) ->
    % TODO:
    % ...
    todo_here,
    Src_TargetBoIdL;

more_decide_skill_eff_targets(_Any, _Src_TargetBoIdL, _Actor, _Eff) ->
    ?ASSERT(false, _Any),
    _Src_TargetBoIdL.


