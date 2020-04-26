%%%------------------------------------
%%% @Module  : mod_sprd
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2014.8.7
%%% @Description: 推广系统服务
%%%------------------------------------
-module(mod_sprd).
-behaviour(gen_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([
        start_link/0,
        player_req_build_sprd_rela/2,
        on_player_final_logout/1,
        on_player_upgrade/2
        ]).

-include("common.hrl").
-include("sprd.hrl").
-include("reward.hrl").

-record(state, {}).


start_link() ->
    {ok, _Pid} = gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).


player_req_build_sprd_rela(PS, TargetSprdCode) ->
    gen_server:cast(?MODULE, {'player_req_build_sprd_rela', PS, TargetSprdCode}).

on_player_final_logout(PlayerId) ->
    gen_server:cast(?MODULE, {'on_player_final_logout', PlayerId}).

on_player_upgrade(PS, NewLv) ->
    gen_server:cast(?MODULE, {'on_player_upgrade', PS, NewLv}).



%% ===================================================================================================
    
init([]) ->
    process_flag(trap_exit, true),
    do_init_jobs(),
    {ok, #state{}}.


handle_cast({'player_req_build_sprd_rela', PS, TargetSprdCode}, State) ->
    ?TRY_CATCH(ply_sprd:callback_req_build_sprd_rela(PS, TargetSprdCode), ErrReason),
    {noreply, State};

handle_cast({'on_player_final_logout', PlayerId}, State) ->
    ply_sprd:callback_on_player_final_logout(PlayerId),
    {noreply, State};

handle_cast({'on_player_upgrade', PS, NewLv}, State) ->
    ?TRY_CATCH(on_player_upgrade__(PS, NewLv), ErrReason),
    {noreply, State};

handle_cast(_R, State) ->
    ?ASSERT(false, _R),
    {noreply, State}.


handle_call(_R, _From, State) ->
    ?ASSERT(false, _R),
    {reply, ok, State}.


handle_info(_R, State) ->
    {noreply, State}.

terminate(Reason, _State) ->
    case Reason of
        normal -> skip;
        shutdown -> skip;
        {shutdown, _} -> skip;
        _ ->
            ?ERROR_MSG("[~p] !!!!!terminate!!!!! for reason: ~w", [?MODULE, Reason])
    end,
    ok.

code_change(_OldVsn, State, _Extra)->
    {ok, State}.







do_init_jobs() ->
    do_nothing.




on_player_upgrade__(PS, NewLv) ->
    case data_sprd_reward:get(NewLv) of
        null ->
            skip;
        SprdRwd ->
            SprdInfo = ply_sprd:get_sprd_info(PS),
            case SprdInfo#sprd.sprder_id of
                ?INVALID_ID ->
                    skip;
                SprderId ->
                    give_reward_to_player(player:id(PS), SprdRwd#sprd_reward.pkg_to_sprdee),
                    give_reward_to_player(SprderId, SprdRwd#sprd_reward.pkg_to_sprder),

                    %% 添加公告
                    case NewLv of
                        40 -> mod_broadcast:send_sys_broadcast(97, [player:get_name(SprderId), SprderId, player:get_name(PS), player:id(PS)]);
                        50 -> mod_broadcast:send_sys_broadcast(98, [player:get_name(PS), player:id(PS), player:get_name(SprderId), SprderId]);
                        _ -> skip
                    end
            end
    end.


%% 给予玩家推广奖励
give_reward_to_player(_PlayerId, RwdPkgNo) when RwdPkgNo == ?INVALID_NO ->
    skip;
give_reward_to_player(PlayerId, RwdPkgNo) ->
    RewardRd = lib_reward:calc_reward_to_player(PlayerId, RwdPkgNo),
    MailTitle = build_reward_mail_title(),
    MailContent = build_reward_mail_content(),
    lib_mail:send_sys_mail(PlayerId, MailTitle, MailContent, RewardRd#reward_dtl.calc_goods_list, ["friend", "prize"]).



build_reward_mail_title() ->
    <<"邀请好友奖励">>.
    

build_reward_mail_content() ->
    <<"亲爱的玩家，您已达到邀请好友奖励要求，感谢您和您的朋友对游戏的支持。">>.
