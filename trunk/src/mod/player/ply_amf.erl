%%%--------------------------------------
%%% @Module  : ply_amf (amf: auto MF, 自动打怪，引申为挂机的意思)
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2014.1.15
%%% @Description: 玩家的与自动挂机相关的业务逻辑
%%%--------------------------------------
-module(ply_amf).
-export([
        get_AI_list/1
    ]).

-include("common.hrl").
-include("skill.hrl").





%% 获取玩家的ai列表
%% @return：[] | ai编号列表
get_AI_list(PlayerId) ->
    case ply_skill:get_skill_list(PlayerId) of
        [] ->
            [];
        SklBriefList ->
            lib_skill:build_AI_list_from(SklBriefList)
    end.


