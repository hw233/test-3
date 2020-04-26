%%%------------------------------------
%%% @Module  : mod_data_checker
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2014.2.7
%%% @Description: 数据检查
%%%------------------------------------
-module(mod_data_checker).
-export([
        check_cfg_data/0    
    ]).

-include("common.hrl").
-include("faction.hrl").



%% 检查配置数据的正确性
check_cfg_data() ->
    check_xinfa_cfg_data(),
    check_skill_cfg_data(),
    ?TRACE("[mod_data_checker] check_cfg_data() ok!~n").






%% 检查心法配置数据的正确性
check_xinfa_cfg_data() ->
    F = fun(Faction) ->
            FacBase = data_faction:get(Faction),

            F__ =   fun(XinfaId) ->
                        case mod_xinfa:get_cfg_data(XinfaId) of
                            null ->
                                ?ASSERT(false, {Faction, XinfaId}),
                                ?ERROR_MSG("[mod_data_checker] check_xinfa_cfg_data() error!!! Faction:~p, XinfaId:~p", [Faction, XinfaId]);
                            XinfaCfg ->
                                case mod_xinfa:get_faction(XinfaCfg) of
                                    Faction ->
                                        ok;
                                    _ ->
                                        ?ERROR_MSG("[mod_data_checker] check_xinfa_cfg_data() error!!! Faction:~p, XinfaId:~p", [Faction, XinfaId]),
                                        ?ASSERT(false, {faction, XinfaId})                                   
                                end
                        end
                    end,

            case FacBase#faction_base.xinfa_list of
                [] ->
                    ?ASSERT(false, Faction),
                    ?ERROR_MSG("[mod_data_checker] check_xinfa_cfg_data() error!!! Faction:~p", [Faction]);
                _ ->
                    lists:foreach(F__, FacBase#faction_base.xinfa_list)
            end       
        end,

    lists:foreach(F, ?FACTION_LIST).



%% 检查技能配置数据的正确性
check_skill_cfg_data() ->    
    L = data_skill:get_all_skill_id_list(),

    F = fun(SklId) ->
            SklCfg = mod_skill:get_cfg_data(SklId),
            case mod_skill:get_faction(SklCfg) of     
                ?FACTION_NONE ->
                    skip;
                Faction ->
                    % 对应的门派代号是否合法？
                    case lib_comm:is_valid_faction(Faction) of
                        true ->
                            ok;
                        false ->
                            ?ASSERT(false, SklId),
                            ?ERROR_MSG("[mod_data_checker] check_skill_cfg_data() error!!! SklId:~p", [SklId])
                    end

                    % 对应所属心法是否存在？
%%                     OwnerXfId = mod_skill:get_owner_xinfa_id(SklCfg),
%%                     OwnerXf = mod_xinfa:get_cfg_data(OwnerXfId),
%%                     case OwnerXf of
%%                         null ->
%%                             ?ASSERT(false, {SklId, OwnerXfId}),
%%                             ?ERROR_MSG("[mod_data_checker] check_skill_cfg_data() error!!! SklId:~p, OwnerXfId:~p", [SklId, OwnerXfId]);
%%                         _ ->
%%                             ok
%%                     end,

                    % 对应所属心法的关联技能是否包含SklId？
%%                     RelatedSklList = mod_xinfa:get_related_skill_list(OwnerXf),
%%                     case lists:member(SklId, RelatedSklList) of
%%                         true ->
%%                             ok;
%%                         false ->
%%                             ?ASSERT(false, {SklId, OwnerXfId}),
%%                             ?ERROR_MSG("[mod_data_checker] check_skill_cfg_data() error!!! SklId:~p, OwnerXfId:~p", [SklId, OwnerXfId])
%%                     end,

                    % 对应所属心法的门派是否为Faction？
%                    case mod_xinfa:get_faction(OwnerXf) of
                        %Faction ->
                         %   ok;
                        %_ ->
                         %   ?ERROR_MSG("[mod_data_checker] check_skill_cfg_data() error!!! SklId:~p, OwnerXfId:~p", [SklId, OwnerXfId]),
                          %  ?ASSERT(false, {SklId, OwnerXfId})                            
                    %end
            end
        end,

    lists:foreach(F, L).

