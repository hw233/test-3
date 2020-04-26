%%%--------------------------------------
%%% @Module  : pp_arena
%%% @Author  : huangjf
%%% @Email   :
%%% @Created : 2012.1.15
%%% @Description: 竞技场
%%%--------------------------------------
-module(pp_arena).
-export([handle/3]).

-include("common.hrl").
-include("pt_27.hrl").
-include("char.hrl").


handle(?PT_ARENA_1V1_INFO, PS, []) ->
    ply_arena_1v1:send_info(PS);

handle(?PT_ARENA_1V1_JOIN, PS, []) ->
    ply_arena_1v1:join(PS);

handle(?PT_ARENA_1V1_LEAVE, PS, []) ->
    ply_arena_1v1:leave(PS);

handle(?PT_ARENA_1V1_REPORTS, PS, [1=_Type]) ->
    ply_arena_1v1:send_report(PS);
handle(?PT_ARENA_1V1_REPORTS, PS, [2=_Type]) ->
    mod_arena_1v1:send_reports(PS);

handle(?PT_ARENA_1V1_WEEK_TOP, PS, []) ->
    ply_arena_1v1:send_week_top(PS);

%%===============================================
%%3V3比武大会
%%===============================================
% handle(?PT_ARENA_3V3_INFO, PS, []) ->
%     lib_arena_3v3:get_info(PS);

% handle(?PT_ARENA_3V3_JOIN, PS, []) ->
%     case lib_arena_3v3:arena_3v3_join(PS) of
%             {false, Reason}->
%                lib_send:send_prompt_msg(PS, Reason);
%             {true, TeamId, AvgPower} ->
%                 ArenaTeam = #arena_3v3_team{id = player:id(PS), teamid = TeamId, team_name = mod_team:get_team_name(TeamId), team_power = AvgPower},
%                 player:set_cur_bhv_state(PS, ?BHV_ARENA_3V3_WAITING),
%                 mod_arena_3v3:arena_3v3_join(ArenaTeam),
%                 F = fun
%                     (PlayerId) ->
%                         {ok, Bin} = pt_27:write(?PT_ARENA_3V3_JOIN, 0),
%                         lib_send:send_to_uid(PlayerId, Bin)
%                 end,
%                 [F(X) || X <- mod_team:get_all_member_id_list(TeamId)]
%     end; 

handle(?PT_ARENA_3V3_INFO, PS, []) ->
    ply_arena_3v3:send_info(PS);

handle(?PT_ARENA_3V3_JOIN, PS, []) ->
    ply_arena_3v3:join(PS);

handle(?PT_ARENA_3V3_LEAVE, PS, []) ->
    case player:get_cur_bhv_state(PS) of
        ?BHV_ARENA_3V3_READY -> skip;
         _ -> ply_arena_3v3:leave(PS)
    end;

handle(?PT_ARENA_3V3_REPORTS, PS, [1=_Type]) ->
    ply_arena_3v3:send_report(PS);
handle(?PT_ARENA_3V3_REPORTS, PS, [2=_Type]) ->
    mod_arena_3v3:send_reports(PS);

handle(?PT_ARENA_3V3_WEEK_TOP, PS, []) ->
    ply_arena_3v3:send_week_top(PS);  

handle(_Msg, _PS, _) ->
    ?WARNING_MSG("unknown handle ~p", [_Msg]),
    error.