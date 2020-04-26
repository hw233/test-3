%%%--------------------------------------
%%% @Module: mod_vip
%%% @Author: liuzhongzheng2012@gmail.com
%%% @Created: 2014-05-15
%%% @Description: VIP功能
%%%--------------------------------------

-module(mod_vip).

%%
-export([
          active/1,
          add_exp/2,
          pay/2,
          experience/3,
          vip_expire/1
        ]).

-include("record.hrl").

%% 激活VIP
active(PS) ->
    PS1 = lib_vip:active(PS),
    % 为避免并发问题，统一异步更新
    player:set_vip_info(PS, PS1#player_status.vip).


add_exp(Exp, PS) ->
    PS1 = lib_vip:add_exp(Exp, PS),
    player:set_vip_info(PS, PS1#player_status.vip).

%% 现金充值元宝
pay(YuanBao, PS) ->
    PS1 = lib_vip:pay(YuanBao, PS),
    player:set_vip_info(PS, PS1#player_status.vip).

%% 体验VIP(等级, 时长)
experience(Lv, Duration, PS) ->
    PS1 = lib_vip:experience(Lv, Duration, PS),
    player:set_vip_info(PS, PS1#player_status.vip).

%% vip过期
vip_expire(PlayerID) ->
    PS = player:get_PS(PlayerID),
    PS1 = lib_vip:check_expire(PS),
    player:set_vip_info(PS, PS1#player_status.vip).