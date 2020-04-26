%%%--------------------------------------
%%% @Module   : ply_priv
%%% @Author   : huangjf
%%% @Email    : 
%%% @Created  : 2014.9.15
%%% @Description: 玩家的权限级别
%%%--------------------------------------
-module(ply_priv).
-export([
        can_ban_chat/1,
        can_cancel_ban_chat/1,
        get_priv_lv/1, get_priv_lv_by_id/1,
        set_priv_lv/2,
        is_valid_priv_lv/1,
        is_gm/1,
        is_instructor/1,
        notify_cli_priv_lv_change/2,
        db_update_priv_lv/2
    ]).

-include("record.hrl").
-include("priv.hrl").
-include("debug.hrl").
-include("obj_info_code.hrl").


%% 是否有足够的权限去禁言他人？（true | false）
can_ban_chat(PS) ->
    get_priv_lv(PS) >= ?PRIV_GM.
    
%% 是否有足够的权限去解除他人的禁言？（true | false） 
can_cancel_ban_chat(PS) ->
    can_ban_chat(PS).  % 目前和禁言的权限是一样的判断


%% 获取玩家的权限级别
%% @return: integer()
get_priv_lv(PS) ->
    PS#player_status.priv_lv.


%% 依据玩家id，获取其权限级别
%% @return: integer() | error
get_priv_lv_by_id(PlayerId) when is_integer(PlayerId) ->
    case player:is_online(PlayerId) of
        true ->
            PS = player:get_PS(PlayerId),
            get_priv_lv(PS);
        false ->
            case player:in_tmplogout_cache(PlayerId) of
                true ->
                    PS = ply_tmplogout_cache:get_tmplogout_PS(PlayerId),
                    get_priv_lv(PS);
                false ->
                    db_get_priv_lv(PlayerId)
            end
    end.




%% 设置权限级别
%% @para: PrivLv => 详见priv.hrl中的宏PRIV_XXX
set_priv_lv(PlayerId, PrivLv) when is_integer(PlayerId) ->
    ?ASSERT(is_valid_priv_lv(PrivLv), PrivLv),
    case player:is_online(PlayerId) of
        true ->
            gen_server:cast( player:get_pid(PlayerId), {'set_priv_lv', PrivLv});
        false ->
            case player:in_tmplogout_cache(PlayerId) of
                true ->
                    ply_tmplogout_cache:set_priv_lv(PlayerId, PrivLv);
                false ->
                    db_update_priv_lv(PlayerId, PrivLv)
            end
    end;
set_priv_lv(PS, PrivLv) when is_record(PS, player_status) ->
    set_priv_lv( player:id(PS), PrivLv).




db_update_priv_lv(PlayerId, PrivLv) ->
    db:update(
            PlayerId,
            player,
            ["priv_lv"],
            [PrivLv],
            "id",
            PlayerId
            ).


db_get_priv_lv(PlayerId) ->
    case db:select_one(player, "priv_lv", [{id,PlayerId}]) of
        null ->
            error;
        PrivLv ->
            ?ASSERT(util:is_nonnegative_int(PrivLv), PrivLv),
            PrivLv
    end.


    
is_valid_priv_lv(PrivLv) ->
    PrivLv =:= ?PRIV_NOR_PLAYER
    orelse PrivLv =:= ?PRIV_INSTRUCTOR
    orelse PrivLv =:= ?PRIV_GM.



%% 是否指导员？
is_instructor(PS) ->
    get_priv_lv(PS) == ?PRIV_INSTRUCTOR.
    
%% 是否GM？
is_gm(PS) ->
    get_priv_lv(PS) == ?PRIV_GM.



notify_cli_priv_lv_change(PS, NewPrivLv) ->
    player:notify_cli_info_change(PS, ?OI_CODE_PRIV_LV, NewPrivLv).
