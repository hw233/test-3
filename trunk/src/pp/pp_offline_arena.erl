%%%-----------------------------------
%%% @Module  : pp_offline_arena
%%% @Author  : lds
%%% @Email   :
%%% @Created : 2013.12
%%% @Description: 离线竞技场
%%%-----------------------------------
-module (pp_offline_arena).

-include("common.hrl").
-include("record.hrl").
-include("offline_arena.hrl").
-include("prompt_msg_code.hrl").

-export([handle/3]).

%% @doc 加载排行榜信息
handle(23000, Status, []) ->
    case player:get_lv(Status) >= ?OA_OPEN_LV of
        false ->
            {ok, BinData} = pt_23:write(23000, [?OA_ERROR]),
            lib_send:send_to_sock(Status#player_status.socket, BinData);
        true ->
            lib_offline_arena:get_self_base_info(Status),
            catch lib_offline_arena:get_self_combat_info(Status),
            % lib_offline_arena:get_self_reward_info(Status),
            lib_offline_arena:get_arena_ranking_info(Status),
            {ok, BinData} = pt_23:write(23000, [?OA_SUCCESS]),
            lib_send:send_to_sock(Status#player_status.socket, BinData)
    end;

%% @doc 加载个人排名信息
handle(23001, Status, []) ->
    lib_offline_arena:get_self_base_info(Status),
    ok;

%% @doc 加载战报
handle(23002, Status, []) ->
    catch lib_offline_arena:get_self_combat_info(Status),
    ok;

%% @doc 加载奖励信息
% handle(23004, Status, []) ->
%     lib_offline_arena:get_self_reward_info(Status),
%     ok;

%% @doc 加载排名信息
handle(23005, Status, []) ->
    lib_offline_arena:get_arena_ranking_info(Status),
    ok;

%% @doc JJC英雄榜
handle(23006, Status, [Group]) ->
    lib_offline_arena:get_hero_ranking_info_broadcast(Group, ?RANKING_LEADER, Status);

% @doc 领取连胜/战斗场数奖励
handle(23007, Status, [Type, Index]) ->
    case Type of
        1 -> lib_offline_arena:get_winning_streak_reward(Status, Index);
        2 -> lib_offline_arena:get_challange_times_reward(Status, Index);
        _ -> skip
    end,
    ok;

%% @doc 领取排名奖励
handle(23008, Status, []) ->
    lib_offline_arena:get_ranking_reward(Status),
    ok;

%% @doc 刷新排名
handle(23009, Status, []) ->
    lib_offline_arena:refresh_ranking_list(Status),
    ok;

%% @doc 挑战玩家
handle(23010, Status, [RoleId, Rank]) ->
    case player:id(Status) =:= RoleId of
        true -> skip;
        false ->
            case player:is_in_team(Status) of
                 true -> lib_send:send_prompt_msg(Status, ?PM_OFFLINE_ARENA_TEAM_LIMIT);
                 false -> 
                    case player:is_idle(Status) andalso 
                         ( not lib_scene:is_melee_scene(player:get_scene_id(Status)) ) % 新增在女妖乱斗场景不能操作竞技场
                         andalso (not lib_tower:is_in_tower(Status) ) % 新增在爬塔中不能操作竞技场
                         andalso (not lib_hardtower:is_in_tower(Status)) of %新增在噩梦爬塔中不能操作竞技场
                        true ->
                            lib_offline_arena:handle_challenge_warrior_request(RoleId, Rank, Status);
                        false -> 
                            lib_send:send_prompt_msg(Status, ?PM_BUSY_NOW)
                    end
            end
    end,
    ok;

%% 取消挑战CD
handle(23012, Status, []) ->
    lib_offline_arena:cancel_challenge_cd(Status),
    ok;

%%　购买挑战次数
handle(23013, Status, []) ->
    lib_offline_arena:buy_challenge_times(Status),
    ok;


handle(_Cmd, _, _) ->
    ?ASSERT(false, [_Cmd]),
    no_match.