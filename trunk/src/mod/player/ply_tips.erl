%%%--------------------------------------
%%% @Module   : ply_tips 
%%% @Author   : zhagnwq
%%% @Email    : 
%%% @Created  : 2014.1.14
%%% @ 玩家系统提示 个人和队伍以及全服提示都是通过这个统一的接口调用
%% 发送参数说明：
%%      {player} 需要顺序发送 玩家名字和玩家id
%%      {pet}    需要顺序发送 女妖名字 女妖id 女妖品质
%%      {item}   需要顺序发送 物品编号 物品品质 物品数量
%%      {str}    直接发送要显示的内容
%%%--------------------------------------

-module(ply_tips).
-export([
        get_name_list_by_ids/1,
        send_sys_tips/2,
        send_sys_tips/3,
        notify_gain_item/3,
        notify_gain_item/5
    ]).

-include("common.hrl").
-include("goods.hrl").
-include("player.hrl").
-include("pt_13.hrl").
-include("pt_11.hrl").
-include("record.hrl").
-include("broadcast.hrl").
-include("record/guild_record.hrl").
-include("offline_data.hrl").

%% 发送目标
% 1. 玩家自己
% 2. 帮派全员
% 3. 队伍全员
% 4. 全服玩家
send_sys_tips(PlayerId, {OpName, ParaList}) when is_integer(PlayerId) ->
    case player:get_PS(PlayerId) of
        null -> skip;
        PS -> send_sys_tips(PS, {OpName, ParaList})
    end;
send_sys_tips(PS, {OpName, ParaList}) when is_record(PS, player_status) orelse PS =:= null ->
    case OpName of
        add_exp -> send_sys_tips(PS, 35, ParaList);
        add_exp_1 -> send_sys_tips(PS, 124, ParaList);
        add_exp_2 -> send_sys_tips(PS, 126, ParaList);
        cost_exp -> send_sys_tips(PS, 34, ParaList);
        par_add_exp -> send_sys_tips(PS, 37, ParaList);
        par_add_exp_1 -> send_sys_tips(PS, 125, ParaList);
        par_add_exp_2 -> send_sys_tips(PS, 127, ParaList);
        buy_goods -> send_sys_tips(PS, 33, ParaList);
        sell_goods -> send_sys_tips(PS, 36, ParaList);
        use_goods -> send_sys_tips(PS, 32, ParaList);
        cost_goods -> send_sys_tips(PS, 288, ParaList);
        get_goods -> send_sys_tips(PS, 31, ParaList);
        get_goods_quality -> skip;%send_sys_tips(PS, 20, ParaList); 公告停用
        get_goods_quality_gift -> send_sys_tips(PS, 21, ParaList);
        lv_up -> send_sys_tips(PS, 30, ParaList);
        add_yuanbao -> send_sys_tips(PS, 29, ParaList);
        add_bind_yuanbao -> send_sys_tips(PS, 27, ParaList);
        add_bind_gamemoney -> send_sys_tips(PS, 23, ParaList);
        add_gamemoney -> send_sys_tips(PS, 25, ParaList);
        cost_gamemoney -> send_sys_tips(PS, 24, ParaList);
        cost_bind_gamemoney -> send_sys_tips(PS, 22, ParaList);
        cost_yuanbao -> send_sys_tips(PS, 28, ParaList);
        cost_bind_yuanbao -> send_sys_tips(PS, 26, ParaList);
		add_integral -> send_sys_tips(PS, 315, ParaList);
        cost_integral -> send_sys_tips(PS, 314, ParaList);
        xinfa_lv_up -> send_sys_tips(PS, 38, ParaList);
        add_activity_times -> send_sys_tips(PS, 40, ParaList);
        use_goods_time_over -> send_sys_tips(PS, 43, ParaList);

        cost_guild_contri -> send_sys_tips(PS, 190, ParaList);
        add_guild_contri -> send_sys_tips(PS, 191, ParaList);
        cost_guild_feat -> send_sys_tips(PS, 192, ParaList);
        add_guild_feat -> send_sys_tips(PS, 193, ParaList);

        use_exp_buff_goods_left_time -> send_sys_tips(PS, 42, ParaList);
        use_ghost_exp_buff_goods_left_time -> send_sys_tips(PS, 320, ParaList);
        tower_pass_floor -> send_sys_tips(PS, 44, ParaList); 
        tower_pass_floor_20 -> skip; %send_sys_tips(PS, 45, ParaList); 公告停用
        tower_pass_floor_30 -> send_sys_tips(PS, 46, ParaList);
        tower_pass_floor_40 -> send_sys_tips(PS, 51, ParaList);
        tower_pass_floor_50 -> send_sys_tips(PS, 100, ParaList);
        tower_pass_floor_60 -> send_sys_tips(PS, 101, ParaList);
        tower_pass_floor_70 -> send_sys_tips(PS, 102, ParaList);
        tower_pass_floor_80 -> send_sys_tips(PS, 103, ParaList);
        tower_pass_floor_90 -> send_sys_tips(PS, 104, ParaList);
        tower_pass_floor_100 -> send_sys_tips(PS, 105, ParaList);
        par_join_battle -> send_sys_tips(PS, 47, ParaList);
        add_guild_dishes_2 -> send_sys_tips(PS, 53, ParaList);
        add_guild_dishes_3 -> send_sys_tips(PS, 54, ParaList);
        add_guild_dishes_4 -> send_sys_tips(PS, 55, ParaList);
        arena_top_1 -> send_sys_tips(PS, 57, ParaList);
        arena_win_last_10 -> send_sys_tips(PS, 58, ParaList);
        add_vip_exp -> send_sys_tips(PS, 60, ParaList);
        pk_fail -> send_sys_tips(PS, 80, ParaList);
        pk_fail_team -> send_sys_tips(PS, 99, ParaList);
        pk_success -> send_sys_tips(PS, 81, ParaList);
        find_par -> send_sys_tips(PS, 73, ParaList);
        find_par_orange -> send_sys_tips(PS, 151, ParaList);
        compose_gem_5 -> send_sys_tips(PS, 67, ParaList);
        compose_gem_6 -> send_sys_tips(PS, 68, ParaList);
        compose_gem_7 -> send_sys_tips(PS, 69, ParaList);
        compose_gem_8 -> send_sys_tips(PS, 70, ParaList);
        compose_gem_9 -> send_sys_tips(PS, 71, ParaList);
        compose_gem_10 -> send_sys_tips(PS, 72, ParaList);
        strenthen_equip_10 -> send_sys_tips(PS, 61, ParaList);
        strenthen_equip_15 -> send_sys_tips(PS, 62, ParaList);
        strenthen_equip_17 -> send_sys_tips(PS, 63, ParaList);
        strenthen_equip_20 -> send_sys_tips(PS, 64, ParaList);
        strenthen_equip_30 -> send_sys_tips(PS, 316, ParaList);
        strenthen_equip_40 -> send_sys_tips(PS, 317, ParaList);
        strenthen_equip_50 -> send_sys_tips(PS, 318, ParaList);
        % strenthen_equip_18 -> send_sys_tips(PS, 65, ParaList);
        % strenthen_equip_20 -> send_sys_tips(PS, 66, ParaList);
        add_partner -> send_sys_tips(PS, 86, ParaList);
        use_add_bind_gamemoney_goods_left_time -> send_sys_tips(PS, 87, ParaList);
        use_add_exp_goods_left_time -> send_sys_tips(PS, 88, ParaList);
        extend_par_capacity -> send_sys_tips(PS, 89, ParaList);
        evolve_partner_purple -> send_sys_tips(PS, 93, ParaList);
        evolve_partner_orange -> send_sys_tips(PS, 94, ParaList);
        evolve_partner_red -> send_sys_tips(PS, 95, ParaList);
        par_add_evolve -> send_sys_tips(PS, 96, ParaList);
        give_flower -> send_sys_tips(PS, 263, ParaList);
        guild_war_win -> send_sys_tips(PS, 112, ParaList);
        guild_war_lose -> send_sys_tips(PS, 113, ParaList);
        add_feat -> send_sys_tips(PS, 116, ParaList);
        cost_feat -> send_sys_tips(PS, 117, ParaList);
        add_contri -> send_sys_tips(PS, 114, ParaList);
        cost_contri -> send_sys_tips(PS, 115, ParaList);
        get_goods_quality_tve -> send_sys_tips(PS, 74, ParaList);
        % issue_xs_task -> send_sys_tips(PS, 134, ParaList);
        % newyear_banquet_add_dish -> send_sys_tips(PS, 135, ParaList);
        % newyear_banquet_open -> send_sys_tips(PS, 136, ParaList);
        % newyear_banquet_sys -> send_sys_tips(PS, 141, ParaList);
        % newyear_banquet_reward -> send_sys_tips(PS, 142, ParaList);
        % newyear_banquet_get_special_goods -> send_sys_tips(PS, 150, ParaList);
        mount_stren -> send_sys_tips(PS, 153, ParaList);
        mount_skill -> send_sys_tips(PS, 152, ParaList);
        add_mount -> send_sys_tips(PS, 154, ParaList);

        cost_copper -> send_sys_tips(PS, 155, ParaList);
        add_copper -> send_sys_tips(PS, 156, ParaList);
        cost_vitality -> send_sys_tips(PS, 157, ParaList);
        add_vitality -> send_sys_tips(PS, 158, ParaList);

        cost_chivalrous-> send_sys_tips(PS, 159, ParaList);
        add_chivalrous-> send_sys_tips(PS, 160, ParaList);

        cost_chip-> send_sys_tips(PS, 161, ParaList);
        add_chip-> send_sys_tips(PS, 162, ParaList);

        set_popular-> send_sys_tips(PS, 163, ParaList);

        open_slotmachine1 -> send_sys_tips(PS, 164, ParaList);
        open_slotmachine2 -> send_sys_tips(PS, 165, ParaList);

        online_tips_friend -> send_sys_tips(PS, 174, ParaList);
        online_tips_enemy -> send_sys_tips(PS, 176, ParaList);

        % open_slotmachine3 -> send_sys_tips(PS, 170, ParaList);
        % open_slotmachine4 -> send_sys_tips(PS, 171, ParaList);

        join_guild ->    send_sys_tips(PS, 177, ParaList);
        partner_add_skill ->    send_sys_tips(PS, 179, ParaList);
        partner_add_skill1 ->    send_sys_tips(PS, 303, ParaList);
        partner_add_skill2 ->    send_sys_tips(PS, 304, ParaList);
        partner_change_skill -> send_sys_tips(PS, 178, ParaList);
        guild_player_be_kill -> send_sys_tips(PS, 180, ParaList);        
        % 被怪物杀死
        guild_player_be_mf_kill -> send_sys_tips(PS, 181, ParaList);

        task_max_limit -> send_sys_tips(PS, 271, ParaList);
		
		
        % 
        % 182 #bd9d65帮派战已结开始
        % 183 #bd9d65帮派战即将开始最后10分钟
        % 184 #bd9d65帮派战即将开始
        % 185 #bd9d65帮派战进入决战期
        % 186 #bd9d65帮派战决战期间剩余玩家
        % 187 #bd9d65帮派战即将进入决战期
        % 188 #bd9d65帮派正在进行

        guild_battle_begin -> send_sys_tips(PS, 182, ParaList);
        guild_battle_soon_begin2 -> send_sys_tips(PS, 183, ParaList);
        guild_battle_soon_begin -> send_sys_tips(PS, 184, ParaList);
        guild_battle_enter_decisive_battle -> send_sys_tips(PS, 185, ParaList);
        guild_battle_decisive_battle_left -> send_sys_tips(PS, 186, ParaList);
        guild_battle_soon_decisive_battle -> send_sys_tips(PS, 187, ParaList);
        guild_battle_opening -> send_sys_tips(PS, 188, ParaList); 
		add_jingwen    ->    send_sys_tips(PS, 392, ParaList); 
		cost_jingwen -> send_sys_tips(PS, 391, ParaList);
        add_mijing    ->    send_sys_tips(PS, 409, ParaList);
        cost_mijing -> send_sys_tips(PS, 408, ParaList);
        add_huanjing    ->    send_sys_tips(PS, 411, ParaList);
        cost_huanjing -> send_sys_tips(PS, 410, ParaList);
        add_reincarnation    ->    send_sys_tips(PS, 414, ParaList);
        cost_reincarnation -> send_sys_tips(PS, 415, ParaList);

        guild_battle_takeing -> send_sys_tips(PS, 272, ParaList); 
		
		ernie -> send_sys_tips(PS, 319, ParaList);

        peak_lv_up -> send_sys_tips(PS, 413, ParaList);


        add_literary    ->    send_sys_tips(PS, 514, ParaList);
        cost_literary -> send_sys_tips(PS, 515, ParaList);
		
        _Any -> ?ASSERT(false, _Any)
    end;
send_sys_tips(Guild, {OpName, ParaList}) when is_record(Guild, guild) ->
    case OpName of
        guild_lv_up -> send_sys_tips(Guild, 52, ParaList);
        get_guild_dungeon_top -> send_sys_tips(Guild, 56, ParaList);
        _Any -> ?ASSERT(false, _Any)
    end.


send_sys_tips(PS, No, ParaList) when is_record(PS, player_status) orelse PS =:= null ->
    Cfg = data_broadcast:get(No),
    Target = Cfg#sys_broadcast.target,
    {ok, BinData} = pt_11:write(?PT_SEND_SYS_BROADCAST, [No, ParaList]),
    case Target of
        1 ->
            case PS =:= null of
                false -> 
                    lib_send:send_to_sock(PS, BinData);
                true -> ?ASSERT(false, No), skip
            end;
        2 ->
            case PS =:= null of
                false -> 
                    lib_send:send_to_guild(PS, BinData);
                true -> ?ASSERT(false, No), skip
            end;
        3 ->
            case PS =:= null of
                false -> 
                    lib_send:send_to_team(PS, BinData);
                true -> ?ASSERT(false, No), skip
            end;
        4 -> mod_broadcast:send_sys_broadcast(No, ParaList);
        _Any -> ?ASSERT(false, _Any)
    end;
send_sys_tips(Guild, No, ParaList) when is_record(Guild, guild) ->
    Cfg = data_broadcast:get(No),
    Target = Cfg#sys_broadcast.target,
    {ok, BinData} = pt_11:write(?PT_SEND_SYS_BROADCAST, [No, ParaList]),
    case Target of
        2 -> lib_send:send_to_guild(Guild, BinData);
        4 -> mod_broadcast:send_sys_broadcast(No, ParaList);
        _Any -> ?ASSERT(false, _Any)
    end.

%%获得物品/货币/显示
notify_gain_item(_PS, _Type, Count) when Count == 0 ->
    skip;

notify_gain_item(PS, Type, Count) when is_record(PS, player_status) ->
    {ok, BinData} = pt_13:write(?PT_PLYR_NOTIFY_GAIN_MONEY, [Type, Count]),
    lib_send:send_to_sock(PS, BinData);

notify_gain_item(PlayerId, Type, Count) when is_integer(PlayerId) ->
    {ok, BinData} = pt_13:write(?PT_PLYR_NOTIFY_GAIN_MONEY, [Type, Count]),
    lib_send:send_to_uid(PlayerId, BinData);

notify_gain_item(_Other, _Type, _Count) ->
    skip.

notify_gain_item(_PS, _Type, _Id, _No, Count) when Count == 0 ->
    skip;

notify_gain_item(PS, Type, Id, No, Count) when is_record(PS, player_status) ->
    {ok, BinData} = pt_13:write(?PT_PLYR_NOTIFY_GAIN_ITEM, [Type, Id, No, Count]),
    lib_send:send_to_sock(PS, BinData);

notify_gain_item(PlayerId, Type, Id, No, Count) when is_integer(PlayerId) ->
    {ok, BinData} = pt_13:write(?PT_PLYR_NOTIFY_GAIN_ITEM, [Type, Id, No, Count]),
    lib_send:send_to_uid(PlayerId, BinData);

notify_gain_item(_Other, _Type, _Id, _No, _Count) ->
    skip.


get_name_list_by_ids(IdList) ->
    F0 = fun(Id, Acc) ->
        Name = 
            case player:get_PS(Id) of
                null ->
                    case ply_tmplogout_cache:get_tmplogout_PS(Id) of
                        null ->
                            case mod_offline_data:get_offline_role_brief(Id) of
                                null -> <<>>;
                                OfflineRoleBrief -> OfflineRoleBrief#offline_role_brief.name
                            end;
                        TPS ->
                            player:get_name(TPS)
                    end;
                PS ->
                    player:get_name(PS)
            end,

        case length(Acc) =:= length(IdList) - 1 of
            true -> 
                [Name | Acc];
            false -> 
                Temp = io_lib:format(<<"、 ~s">>, [Name]),
                [Temp | Acc]
        end
    end,
    lists:foldl(F0, [], IdList).