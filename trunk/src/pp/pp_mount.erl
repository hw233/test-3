%%%-------------------------------------- 
%%% @Module: pp_mount
%%% @Author: lf
%%% @Created: 2015.5.5
%%% @Modify:  
%%% @Description: 坐骑系统
%%%--------------------------------------

-module(pp_mount).

-export ([handle/3]).

-include("common.hrl").
-include("pt_18.hrl").
-include("prompt_msg_code.hrl").
-include("mount.hrl").
-include("sys_code.hrl").
-include("log.hrl").

%%-------打开坐骑界面-----
handle(?PT_GET_MOUNT, PS, []) ->
    case ply_sys_open:is_open(PS, ?SYS_MOUNT) of
        false ->
            lib_send:send_prompt_msg(PS, ?PM_OPEN_MOUNT_LIMIT);
        true ->
            MountList = lib_mount:get_all_mount(player:id(PS)),
            {ok, BinData} = pt_18:write(?PT_GET_MOUNT, [length(MountList),MountList]),
            lib_send:send_to_sock(PS, BinData)
    end;

%%------坐骑骑乘或卸下-------
handle(?PT_ONOFF_MOUNT, PS, [MountId, IsOn]) ->
    Mount = lib_mount:get_mount(MountId),
    case Mount == [] of
        true ->
            lib_send:send_prompt_msg(PS, ?PM_MOUNT_OFF_ERR);
        _ ->
            OldMountId = case IsOn of
                            0 ->
                                lib_mount:off_mount(PS, Mount);
                            1 -> 
                                lib_mount:on_mount(PS, Mount)    
                        end,
            {ok, BinData} = pt_18:write(?PT_ONOFF_MOUNT, [IsOn, OldMountId, MountId]),
            lib_send:send_to_sock(PS, BinData)
    end; 

%%------坐骑改名---------
handle(?PT_RENAME_MOUNT, PS, [MountId, NewName]) ->
    case lib_mount:rename_mount(PS, MountId, NewName) of
        [0, _, _] ->
            lib_send:send_prompt_msg(PS, ?PM_MOUNT_RENAME_ERR);
        [1, _, _] ->
            {ok, BinData} = pt_18:write(?PT_RENAME_MOUNT, [?RES_OK, MountId, list_to_binary(NewName)]),
            ?TRACE("MountId:~p, NewName:~p ~n", [MountId, NewName]),
            lib_send:send_to_sock(PS, BinData)
    end;

%%------坐骑重修---------
handle(?PT_RESET_ATTR_MOUNT, PS, [MountId, ResetType, Times]) ->
    ?ASSERT(lists:member(Times, [1,5]), Times),
    case lib_mount:reset_attr_mount(PS, MountId, ResetType, Times) of
        {false, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        {ok, AttrList} ->
            Len = length(AttrList),
            {ok, BinData} = pt_18:write(?PT_RESET_ATTR_MOUNT, [MountId, Len, AttrList]),
            lib_send:send_to_sock(PS, BinData)
    end;

%%-----重修替换------------
handle(?PT_SET_ATTR_MOUNT, PS, [MountId, AttributeNo1, AttributeNo2, AttributeNo3, AttributeAddRatio1, AttributeAddRatio2, AttributeSubRatio]) ->
    case lib_mount:set_attr_mount(PS, MountId, AttributeNo1, AttributeNo2, AttributeNo3, AttributeAddRatio1, AttributeAddRatio2, AttributeSubRatio) of
        {false, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        {ok, BattlePower} ->
            {ok, BinData} = pt_18:write(?PT_SET_ATTR_MOUNT, [0,MountId, AttributeNo1, AttributeNo2, AttributeNo3, AttributeAddRatio1, AttributeAddRatio2, AttributeSubRatio, BattlePower]),
            lib_send:send_to_sock(PS, BinData)
    end;

%%--------喂养-------------
handle(?PT_FEED_MOUNT, PS, [MountId, FeedGoodsNo, FeedCount]) ->
    ?DEBUG_MSG("FeedCount=~p",[FeedCount]),

    HasCostGoodsNum = mod_inv:get_goods_count_in_bag_by_no(player:id(PS), FeedGoodsNo),
    case HasCostGoodsNum >= FeedCount of
        true ->
            case lib_mount:feed_mount(PS, MountId, FeedGoodsNo, FeedCount) of
                {false, Reason} ->
                    lib_send:send_prompt_msg(PS, Reason);
                {ok, {Level, Exp, BattlePower}} ->
                    mod_inv:destroy_goods_WNC(player:id(PS), [{FeedGoodsNo, FeedCount}], [?LOG_MOUNT, "feed_mount"]),
                    {ok, BinData} = pt_18:write(?PT_FEED_MOUNT, [MountId, Level, Exp, BattlePower]),
                    lib_send:send_to_sock(PS,BinData)
            end;
        false ->
            lib_send:send_prompt_msg(PS, ?PM_GOODS_NOT_ENOUGH)
    end;

%%--------传承-------------
handle(?PT_INHERITANCE_MOUNT, PS, [_Type,_LeftMountId, _RightMountId]) ->    
    case _Type of
        1 -> 
            case lib_mount:toll_inheritance_mount(PS,_LeftMountId, _RightMountId) of
            {false, Reason} ->
                lib_send:send_prompt_msg(PS, Reason);
            {ok, {Type,LeftMountId,LeftFeedTimes, LeftLevel, LeftExp, LeftBattlePower,
                            RightMountId,RightFeedTimes, RightLevel, RightExp, RightBattlePower}} ->

                player_syn:cost_money(PS, ?MNY_T_YUANBAO, ?INHERITANCE_NEED_COUNT, [?LOG_MOUNT, "inheritance_mount"]),

                {ok, BinData} = pt_18:write(?PT_INHERITANCE_MOUNT, [Type,LeftMountId,LeftFeedTimes, LeftLevel, LeftExp, LeftBattlePower,RightMountId,RightFeedTimes, RightLevel, RightExp, RightBattlePower]),
                lib_send:send_to_sock(PS,BinData)
            end;
        _ ->
            case lib_mount:inheritance_mount(PS,_LeftMountId, _RightMountId) of
            {false, Reason} ->
                lib_send:send_prompt_msg(PS, Reason);

            %%  {ok,{2,1000100000000006,10,30,2270,1650,1000100000000009,10,1,0,242}}
            %%  {ok,{2,1000100000000012,41,30,3070,1008,1000100000000011,41,1,0,642}}
            {ok, {Type,LeftMountId,LeftFeedTimes, LeftLevel, LeftExp, LeftBattlePower,
                            RightMountId,RightFeedTimes, RightLevel, RightExp, RightBattlePower}} ->

                {ok, BinData} = pt_18:write(?PT_INHERITANCE_MOUNT, [Type,LeftMountId,LeftFeedTimes, LeftLevel, LeftExp, LeftBattlePower,RightMountId,RightFeedTimes, RightLevel, RightExp, RightBattlePower]),
                lib_send:send_to_sock(PS,BinData);
            __ ->
                ?DEBUG_MSG("ERROR ~p",[__]),
                void
            end
    end;
        

%%---------进阶----------
handle(?PT_STREN_MOUNT, PS, [MountId, GoodsId, Num]) ->
    GoodsNo = lib_goods:get_no_by_id(GoodsId),
    HasCostGoodsNum = mod_inv:get_goods_count_in_bag_by_no(player:id(PS), GoodsNo),
    case HasCostGoodsNum >= Num of
        true ->
            case lib_mount:stren_mount(PS, MountId, GoodsNo, Num) of
                {false, Reason} -> 
                    lib_send:send_prompt_msg(PS, Reason);
                {NewStep, NewStepValue, CostNum, BattlePower} ->
                    mod_inv:destroy_goods_WNC(player:id(PS), [{GoodsNo, CostNum}], [?LOG_MOUNT, "stren_mount"]),
                    {ok, BinData} = pt_18:write(?PT_STREN_MOUNT, [MountId, NewStep, NewStepValue, BattlePower]),
                    lib_send:send_to_sock(PS, BinData)
            end;
        false ->
            skip
    end;

%%----------打开技能---------------
handle(?PT_OPEN_MOUNT_SKILL, PS, [MountId, Order]) ->
    case lib_mount:open_mount_skill(PS, MountId, Order) of
        {false, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        {ok, SkillIdList} ->
			mod_achievement:notify_achi(mount_skill, [], PS),
            {ok, BinData} = pt_18:write(?PT_OPEN_MOUNT_SKILL, [MountId, Order, SkillIdList]),
            lib_send:send_to_sock(PS, BinData)
    end;

%%---------删除技能----------------------
handle(?PT_DELETE_MOUNT_SKILL, PS, [MountId, Order]) ->
    case lib_mount:del_mount_skill(PS, MountId, Order) of
        {false, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        {ok} ->
            {ok, BinData} = pt_18:write(?PT_DELETE_MOUNT_SKILL, [0, MountId, Order]),
            lib_send:send_to_sock(PS, BinData)
    end;



%%---------觉醒技能----------------------
handle(?PT_LERAN_MOUNT_SKILL, PS, [MountId, SkillId, Order]) ->
    case lib_mount:learn_mount_skill(PS, MountId, SkillId, Order) of
        {false, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        ok ->
            {ok, BinData} = pt_18:write(?PT_LERAN_MOUNT_SKILL, [0, MountId, SkillId, Order]),
            lib_send:send_to_sock(PS, BinData)
    end;

%%---------升级技能----------------
handle(?PT_UP_MOUNT_SKILL, PS, [MountId, SkillId, Order]) ->
    case lib_mount:up_mount_skill(PS, MountId, SkillId, Order) of
        {false, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        {ok, GoodsNo, NeedNum, NewSkillId} ->
            mod_inv:destroy_goods_WNC(PS, [{GoodsNo, NeedNum}], [?LOG_MOUNT, "up_mount_skill"]),
            {ok, BinData} = pt_18:write(?PT_UP_MOUNT_SKILL, [MountId, Order, NewSkillId]),
            lib_send:send_to_sock(PS, BinData)
    end;

%%---------关联/取消关联宠物-----------------
handle(?PT_CONNECT_PARTNER, PS, [MountId, PartnerId, IsConnect]) ->
    Ressult = case IsConnect of
        1 -> lib_mount:connect_partner(PS, MountId, PartnerId, IsConnect);
        0 -> lib_mount:concel_connect_partner(PS, MountId, PartnerId, IsConnect)
    end,
    case Ressult of
        {false, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        ok ->
            {ok, BinData} = pt_18:write(?PT_CONNECT_PARTNER, [IsConnect, MountId, PartnerId]),
            lib_send:send_to_sock(PS,BinData)
    end;

handle(?PT_ACTIVE_MOUNT, PS, [MountNo]) ->
    case lib_mount:player_add_mount(PS, MountNo) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        {ok, MountId} ->
            {ok, BinData} = pt_18:write(?PT_ACTIVE_MOUNT, [?RES_OK, MountNo, MountId]),
            lib_send:send_to_sock(PS, BinData),
            case length(lib_mount:get_all_mount(player:get_id(PS))) =:= 1 of
                true ->
                    Mount = lib_mount:get_mount(MountId),
                    lib_mount:on_mount(PS, Mount),
                    {ok, BinData1} = pt_18:write(?PT_ONOFF_MOUNT, [1, 0, MountId]),
                    lib_send:send_to_sock(PS, BinData1),
                    PartnerId = player:get_main_partner_id(PS),
                    case PartnerId =/= 0 of
                        true ->
                            Ressult = lib_mount:connect_partner(PS, MountId, PartnerId, 1),
                            case Ressult of
                                {false, Reason1} ->
                                    lib_send:send_prompt_msg(PS, Reason1);
                                ok ->
                                    {ok, BinData2} = pt_18:write(?PT_CONNECT_PARTNER, [1, MountId, PartnerId]),
                                    lib_send:send_to_sock(PS,BinData2)
                            end;
                        false -> skip
                    end;
                false -> skip
            end
    end;

handle(?PT_ACTIVE_MOUNT_SKIN, PS, [No, GoodsNo]) ->
    case lib_mount:player_add_mount_skin(PS, No, GoodsNo) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        ok ->
            {ok, BinData} = pt_18:write(?PT_ACTIVE_MOUNT_SKIN, [?RES_OK, No]),
            lib_send:send_to_sock(PS, BinData)
    end;

handle(?PT_CHANGE_MOUNT_SKIN, PS, [No]) ->
    case lib_mount:player_change_skin(PS, No) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        ok ->
            {ok, BinData} = pt_18:write(?PT_CHANGE_MOUNT_SKIN, [?RES_OK, No]),
            lib_send:send_to_sock(PS, BinData)
    end;

handle(?PT_MOUNT_SKIN_INFO, PS, []) ->
    List = lib_mount:get_skin_remain_time(PS),
    {ok, BinData} = pt_18:write(?PT_MOUNT_SKIN_INFO, [List]),
    lib_send:send_to_sock(PS, BinData);

handle(?PT_TRANSFORM_MOUNT_SKILL, PS, [MountId, OldSkillId, NewSkillId, Order]) ->
    case lib_mount:transform_mount_skill(PS, MountId, OldSkillId, NewSkillId, Order) of
        {false, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        {ok, MoneyType, UseNum, NewSkillId1} ->
            player:cost_money(PS, MoneyType, UseNum, [?LOG_MOUNT, "transform_mount_skill"]),
            {ok, BinData} = pt_18:write(?PT_TRANSFORM_MOUNT_SKILL, [MountId, OldSkillId, NewSkillId1, Order]),
            lib_send:send_to_sock(PS, BinData)
    end;

handle(_Msg, _PS, _) ->
    ?WARNING_MSG("unknown handle ~p", [_Msg]),
    error.
    