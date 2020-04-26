%%%--------------------------------------
%%% @Module: lib_vip
%%% @Author: liuzhongzheng2012@gmail.com
%%% @Created: 2014-05-15
%%% @Description: VIP功能
%%%--------------------------------------

-module(lib_vip).

%%
-export([
          check_expire/1,
          vip_rec/4,
          lv/1,
          exp/1,
          active_time/1,
          expire_time/1,
          welfare/2,
          active/1,
          experience/3,
          is_experience/1,
          add_exp/2,
          pay/2,
          info_vip/1,
          send_daily_mail/1
        ]).

-include("common.hrl").
-include("player.hrl").
-include("pt_13.hrl").
-include("record.hrl").
-include("buff.hrl").
-include("obj_info_code.hrl").
-include("log.hrl").

-define(VIP_BROADCAST_ID, 50).   % VIP走马灯ID
-define(MAX_VIP_LV, 15).   % VIP最高等级

check_expire(#player_status{vip=#vip{expire_time=0}}=PS) ->
    PS;
check_expire(#player_status{vip=#vip{expire_time=ExpireTime}}=PS) ->
    Now = util:unixtime(),
    case Now >= ExpireTime of
        ?true ->
            vip_expire(PS);
        _ ->
            PS
    end.


vip_rec(Lv, Exp, ActiveTime, ExpireTime) ->
    #vip{lv=Lv, exp=Exp, active_time=ActiveTime, expire_time=ExpireTime}.

%% 取VIP等级
lv(#player_status{vip=Vip}) ->
    Now = util:unixtime(),
    case Vip#vip.expire_time of
        0 -> % 正式VIP
            Vip#vip.lv;
        ExpireTime when Now =< ExpireTime -> % 体验VIP
            Vip#vip.lv;
        _ ->
            0
    end.

%% 取VIP经验
exp(#player_status{vip=Vip}) ->
    Vip#vip.exp.


%% 取VIP激活时间
active_time(#player_status{vip=Vip}) ->
    Vip#vip.active_time.

%% 取VIP过期时间
expire_time(#player_status{vip=Vip}) ->
    Now = util:unixtime(),
    case Vip#vip.expire_time of
        ExpireTime when ExpireTime > Now ->
            ExpireTime;
        _ ->
            0
    end.

%% 获取VIP特权
welfare(Type, PS) ->
    Lv = lv(PS),
    data_vip_welfare:get(Type, Lv).

%% 激活VIP(用道具)
active(PS) ->
    active(0, PS).

%% 体验(等级, 时长)
experience(Lv, Duration, #player_status{}=PS) ->
    case lv(PS) of
        0 ->
            ID = player:id(PS),
            Expire = util:unixtime() + Duration,
            Vip = #vip{lv=Lv, expire_time=Expire},
            PS1 = PS#player_status{vip=Vip},
            info_actived(PS1),
            info_vip(PS1),
            do_db_save(ID, Vip),
            PS1;
        _ ->
            PS
    end.

vip_expire(#player_status{vip=#vip{expire_time=0}}=PS) ->
    PS;
vip_expire(#player_status{vip=Vip}=PS) ->
    ID = player:id(PS),
    Vip1 = Vip#vip{expire_time=0, lv=0},
    PS1 = PS#player_status{vip=Vip1},
    {ok, Bin2} = pt_13:write(?PT_PLYR_VIP_EXPERIENCE, [0]),
    lib_send:send_to_uid(ID, Bin2),
    info_vip(PS1),
    do_db_save(ID, Vip1),
    PS1.


is_experience(#player_status{vip=Vip}) ->
    is_experience(Vip);
is_experience(#vip{lv=Lv, expire_time=ExpireTime}) ->
    Lv > 0 andalso ExpireTime > 0.

%% 激活VIP
active(YuanBao, #player_status{vip=Vip}=PS) ->
    UID = player:id(PS),
    lib_buff:player_del_buff(UID, ?BFN_VIP_EXPERIENCE),
    Exp = yuanbao_to_exp(YuanBao),
	VipLevel = 3,
    Vip1 = Vip#vip{lv=VipLevel, active_time=util:unixtime(), expire_time=0},
    PS1 = PS#player_status{vip=Vip1},
    PS2 = add_exp(Exp, PS1, ?true),
    info_actived(PS2), % 客户端要求返回激活第一次的等级, 故先加经验
    PS2;
active(_, PS) ->
    PS.


%% 元宝折算Vip经验
yuanbao_to_exp(YuanBao) ->
    round(YuanBao * ?VIP_YUANBAO_EXP_RATIO).

pay(YuanBao, #player_status{vip=#vip{expire_time=ExpireTime}}=PS) when ExpireTime > 0 ->
    % 体验期间激活VIP
    PS1 = active(YuanBao, PS),
    PS1;
pay(YuanBao, #player_status{vip=#vip{lv=0}}=PS) -> % 首充激活VIP
    PS1 = active(YuanBao, PS),
    PS1;
pay(YuanBao, PS) ->
    Exp = yuanbao_to_exp(YuanBao),
    PS1 = add_exp(Exp, PS),
    PS1.

add_exp(Exp, PS) ->
    add_exp(Exp, PS, ?false).

%% 加VIP经验, 并存盘
add_exp(Exp, PS, IsFirst) ->
    PS1 = do_add_exp(Exp, PS, IsFirst),
    PS2 = db_save(PS1),
    PS2.

do_add_exp(0, PS, ?false) ->
    PS;
do_add_exp(_Exp, #player_status{vip=#vip{lv=0}}=PS, _IsFirstActive) ->
    PS; %% VIP等级为0不累计成长值 2014年6月18日 鲁衡
do_add_exp(Exp, #player_status{vip=Vip}=PS, IsFirstActive) ->
    #vip{exp=OldExp}=Vip,
    Vip1 = Vip#vip{exp=OldExp + Exp},
    Vip2 = check_vip_lv(Vip1),
    Lv1 = ?IF(IsFirstActive, 0, Vip#vip.lv), % 首充前为VIP 0级
    Lv2 = Vip2#vip.lv,
    PS1 = PS#player_status{vip=Vip2},
    PS2 = lists:foldl(fun on_upgrade/2, PS1, lists:seq(Lv1+1, Lv2)),
    PS3 =
        case IsFirstActive orelse Lv2 > Lv1 of
            ?true ->
                mod_rank:vip_up(PS2),
                bcast_upgrade(Vip2, PS2),
                send_daily_mail(PS2),
                ply_hire:on_vip_lv_up(PS#player_status{vip=Vip#vip{lv=Lv1}}, PS2), % 要求传入升级前后的PS
                PS2;
            _ ->
                PS2
        end,
    ?IF(Exp > 0, ply_tips:send_sys_tips(PS, {add_vip_exp, [Exp]}), skip),
    info_vip(PS3),
    PS3.



check_vip_lv(#vip{lv=0}=Vip) -> %% 非VIP只累积经验, 不激活
    Vip;
check_vip_lv(#vip{lv=?MAX_VIP_LV}=Vip) ->
    Vip;
check_vip_lv(#vip{lv=Lv, exp=Exp}=Vip) ->
    case data_vip:get(Lv) of
        #vip_cfg{exp=NeedExp} when Exp >= NeedExp ->
            check_vip_lv(Vip#vip{lv=Lv+1});
        _ ->
            Vip
    end.

%% 升级福利
on_upgrade(Lv, PS) ->
    PS1 = upgrade_mail(Lv, PS),
    mod_guild_mgr:try_update_battle_power(PS1),
    PS1.

%% 发送升级邮件
upgrade_mail(Lv, PS) ->
    Title = data_vip_welfare:get(upgrade_mail_title, Lv),
    case Title of
        null ->
            PS;
        _ ->
			%% 20191217 zjy 暂时不需要发奖励
%%             ID = player:id(PS),
%%             Content = data_vip_welfare:get(upgrade_mail_content, Lv),
%%             Goods = data_vip_welfare:get(upgrade_mail_goods, Lv),
%%             Goods1 = ?IF(is_list(Goods), Goods, []),
%%             lib_mail:send_sys_mail(ID, Title, Content, Goods1, [?LOG_MAIL, "recv_vipup"]),
            PS
    end.

info_actived(PS) ->
    ID = player:id(PS),
    Lv = lv(PS),
    {ok, Bin} = pt_13:write(?PT_PLYR_VIP_ACTIVED, [Lv]),
    lib_send:send_to_uid(ID, Bin).

info_vip(#player_status{}=PS) ->
    ID = player:id(PS),
    Lv = lv(PS),
    Exp = exp(PS),
    {ok, Bin} = pt_13:write(?PT_PLYR_NOTIFY_VIP, [Lv, Exp]),
    lib_scene:notify_int_info_change_to_aoi(player, ID, [{?OI_CODE_VIP_LV, Lv}]), % AOI
    lib_send:send_to_uid(ID, Bin).


bcast_upgrade(#vip{lv=Lv}, PS) ->
    UID = player:get_id(PS),
    Name = player:get_name(PS),
    case Lv > 1 of
        ?true -> % 2014年6月28日 高敏要求1级不发走马灯
            LvBin = util:to_binary(Lv),
            mod_broadcast:send_sys_broadcast(?VIP_BROADCAST_ID, [Name, UID, LvBin]); % 走马灯
        _ ->
            ok
    end.

send_daily_mail(PS) ->
    IsExperience = is_experience(PS),
    Lv = lv(PS),
    Title = data_vip_welfare:get(daily_mail_title, Lv),
    case Title of
        null ->
            skip;
        _ when IsExperience -> % 体验不发邮件
            skip;
        _ ->
			ok
%%             ID = player:id(PS),
%%             Content = data_vip_welfare:get(daily_mail_content, Lv),
%%             Goods = data_vip_welfare:get(daily_mail_goods, Lv),
%%             Goods1 = ?IF(is_list(Goods), Goods, []),
%%             lib_mail:send_sys_mail(ID, Title, Content, Goods1, [?LOG_MAIL, "recv_vipbag"])
    end,
    ok.


db_save(#player_status{}=PS) ->
    PlayerId = player:id(PS),
    PS1 = check_expire(PS),
    do_db_save(PlayerId, PS1#player_status.vip),
    PS1.

do_db_save(PlayerId, #vip{lv=Lv, exp=Exp, active_time=ActiveTime, expire_time=ExpireTime}) ->
    db:update(PlayerId, player,
                ["vip_lv",
                "vip_exp",
                "vip_active_time",
                "vip_expire_time"],
                [Lv,
                 Exp,
                 ActiveTime,
                 ExpireTime],
                "id",
                PlayerId).