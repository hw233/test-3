%%%-------------------------------------- 
%%% @Module: pp_partner
%%% @Author: lxl
%%% @Created: 2011-8-29
%%% @Description: 
%%%-------------------------------------- 


-module(pp_partner).


-export([handle/3]).

-include("common.hrl").
-include("pt_17.hrl").
-include("prompt_msg_code.hrl").
-include("partner.hrl").
-include("player.hrl").
-include("sys_code.hrl").
-include("five_elements.hrl").
-include("effect.hrl").
-include("record/goods_record.hrl").
%%--------获取宠物(不包括玩家通过使用宠物蛋获获取的情况，使用宠物蛋服务器会主动通知玩家获得宠物) -------------
handle(?PT_GET_PARTNER, _PS, [_PartnerNo]) ->
    % case ply_partner:player_add_partner(PS, PartnerNo) of
    %     {fail, Reason} ->
    %         lib_send:send_prompt_msg(PS, Reason);
    %     {ok, _PartnerId} ->
    %         skip
    % end;
    skip; %% 目前没有客户端发送协议获得女妖的功能，先注释掉，防止被攻击


%%----------------设置宠物出战、休息、锁定 状态-----------------------------
handle(?PT_SET_PARTNER_STATE, PS, [PartnerId, State]) ->
	case ply_partner:check_partner_home_work_ban(PartnerId) of
		ok ->
			case ply_partner:set_partner_state(PS, PartnerId, State) of
				{fail, Reason} ->
					case Reason =:= ?PM_PAR_PLAYER_LV_LIMIT_FOR_BATTLE of
						true -> skip;
						false -> lib_send:send_prompt_msg(PS, Reason)
					end;
				{ok, PartnerId} ->
					{ok, BinData} = pt_17:write(?PT_SET_PARTNER_STATE, [?RES_OK, PartnerId, State]),
					lib_send:send_to_sock(PS, BinData)
			end;
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason)
	end;


%%----------------开启宠物携带数量 携带数量：（记在人物表）以通过使用道具女妖栏来扩充此数量，最大上限为8个，初始默认为3个-----------------------
handle(?PT_OPEN_CARRY_PARTNER_NUM, PS, [Num]) ->
    case ply_partner:open_carry_partner_num(PS, Num) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        {ok, CurNum} ->
            {ok, BinData} = pt_17:write(?PT_OPEN_CARRY_PARTNER_NUM, [?RES_OK, CurNum]),
            lib_send:send_to_sock(PS, BinData)
    end;


%%----------------设置宠物为主宠-------------------------
handle(?PT_SET_MAIN_PARTNER, PS, [PartnerId]) ->
	case ply_partner:check_partner_home_work_ban(PartnerId) of
		ok ->
			case ply_partner:set_main_partner(PS, PartnerId) of
				{fail, Reason} ->
					lib_send:send_prompt_msg(PS, Reason);
				ok ->
					{ok, BinData} = pt_17:write(?PT_SET_MAIN_PARTNER, [?RES_OK, PartnerId]),
					lib_send:send_to_sock(PS, BinData)
			end;
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason)
	end;


%%-----------------洗髓-----------------------------------
handle(?PT_WASH_PARTNER, PS, [PartnerId, Type]) ->
    case ply_partner:wash_partner(PS, PartnerId, Type) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        ok ->
            {ok, BinData} = pt_17:write(?PT_WASH_PARTNER, [lib_partner:get_partner(PartnerId)]),
            lib_send:send_to_sock(PS, BinData)
    end;


%%-------------------宠物改名 名字的长度最多为6个汉字-------------------------------
handle(?PT_PARTNER_RENAME, PS, [PartnerId, NewName]) ->
    ?DEBUG_MSG("wjcTestParName~p~n",[NewName]),
    case ply_partner:rename(PS, PartnerId, NewName) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        ok ->
            {ok, BinData} = pt_17:write(?PT_PARTNER_RENAME, [?RES_OK, PartnerId, list_to_binary(NewName)]),
            % ?TRACE("PartnerId:~p, NewName:~p ~n", [PartnerId, NewName]),
            lib_send:send_to_sock(PS, BinData)
    end;


%%-------- 获取玩家携带中的武将列表-------------
handle(?PT_GET_PARTNER_LIST, PS, _) ->
    ParList = ply_partner:get_partner_list(PS),
    % ?DEBUG_MSG("parlist=~p",[ParList]),
    {ok, BinData} = pt_17:write(?PT_GET_PARTNER_LIST, [player:get_id(PS), ParList]),
    lib_send:send_to_sock(PS, BinData);
	

%%----------  获取玩家自己的单个武将的属性信息-------
handle(?PT_GET_PARTNER_ATTR_INFO, PS, [PartnerId]) ->
     case lists:member(PartnerId, player:get_partner_id_list(PS)) of
        false -> lib_send:send_prompt_msg(PS, ?PM_PAR_NOT_EXISTS);
        true ->
            case lib_partner:get_partner(PartnerId) of
                null ->
                    ?ASSERT(false),
                    lib_send:send_prompt_msg(PS, ?PM_PAR_NOT_EXISTS);
                Partner ->
                    {ok, BinData} = pt_17:write(?PT_GET_PARTNER_ATTR_INFO, [Partner]),
                    lib_send:send_to_sock(PS, BinData)
            end
    end;


%%----------  获取玩家自己的或者别人的单个武将的属性信息-------
handle(?PT_GET_PARTNER_ATTR_INFO1, PS, [PartnerId]) ->
    case lib_partner:get_partner(PartnerId) of
        null -> lib_send:send_prompt_msg(PS, ?PM_PAR_NOT_EXISTS);
        Partner ->
            {ok, BinData} = pt_17:write(?PT_GET_PARTNER_ATTR_INFO1, [Partner]),
            lib_send:send_to_sock(PS, BinData)
    end;


%%------------ 获取武将的装备列表 ------------------------
handle(?PT_GET_PARTNER_EQUIP_LIST, PS, [PartnerId]) ->
    PartnerEquipL = ply_partner:get_partner_equip_list(PS, PartnerId),
    {ok, BinData} = pt_17:write(?PT_GET_PARTNER_EQUIP_LIST, [PartnerId, PartnerEquipL]),
    lib_send:send_to_sock(PS, BinData);


% handle(?PT_GET_PARTNER_NATURE_ATTR, PS, [PartnerId]) ->
%     NatureLeanL = lib_partner:get_nature_lean(PartnerId),
%     RetL = [PartnerId] ++ NatureLeanL,
%     {ok, BinData} = pt_17:write(?PT_GET_PARTNER_NATURE_ATTR, RetL),
%     lib_send:send_to_sock(PS, BinData);


% handle(?PT_GET_PARTNER_TRAIN_ATTR, PS, [PartnerId]) ->
%     case lib_partner:get_partner(PartnerId) of
%         null ->
%             lib_send:send_prompt_msg(PS, ?PM_PAR_NOT_EXISTS);
%         Partner ->
%             {ok, BinData} = pt_17:write(?PT_GET_PARTNER_TRAIN_ATTR, [Partner]),
%             lib_send:send_to_sock(PS, BinData)
%     end;


%%-----------------请求进化信息-----------------------------------
handle(?PT_PARTNER_EVOLVE_INFO, PS, [PartnerId]) ->
    case lib_partner:get_partner(PartnerId) of
        null ->
            lib_send:send_prompt_msg(PS, ?PM_PAR_NOT_EXISTS);
        Partner ->
            {ok, BinData} = pt_17:write(?PT_PARTNER_EVOLVE_INFO, [Partner]),
            lib_send:send_to_sock(PS, BinData)
    end;


%%-----------------进化-----------------------------------
handle(?PT_PARTNER_EVOLVE, PS, [PartnerId, Count]) ->
    case ply_partner:evolve_partner(PS, PartnerId, Count) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason),
            case lib_partner:get_partner(PartnerId) of
                null -> skip;
                Partner ->
                    {ok, BinData} = pt_17:write(?PT_PARTNER_EVOLVE, [?RES_FAIL, Partner]),
                    lib_send:send_to_sock(PS, BinData)
            end;
        {ok, Partner, InfoType, SkillId, OldQuality} ->
            {ok, BinData} = pt_17:write(?PT_PARTNER_EVOLVE, [?RES_OK, Partner]),
            lib_send:send_to_sock(PS, BinData),

            %% 进化后很多属性发生变化
            lib_partner:notify_cli_info_change(PS, Partner),

            case lib_partner:get_quality(Partner) =:= OldQuality of
                true -> skip;
                false ->
                    {ok, BinData2} = pt_17:write(?PT_NOTIFY_PARTNER_SKILL_INFO_CHANGE, [lib_partner:get_id(Partner), InfoType, SkillId]),
                    lib_send:send_to_sock(PS, BinData2)
            end;
		{ok, null} ->
			ok
    end;


%% 宠物修炼
handle(?PT_PARTNER_CULTIVATE, PS, [PartnerId, Count]) ->
    case Count> 1000 of    %% 不判断数量，做一键功能
        true -> skip; %% 安全检查，防止被攻击
        false ->
			Count2 = case Count == 0 of
						 true ->
							 999999;
						 false ->
							 Count
					 end,
            case lib_partner:get_partner(PartnerId) of
                null -> lib_send:send_prompt_msg(PS, ?PM_PAR_NOT_EXISTS);
                PartnerOld ->
                    OldCultivateLv = lib_partner:get_cultivate_lv(PartnerOld),
                    OldCultivateLayer = lib_partner:get_cultivate_layer(PartnerOld),
                    {RetList, PS1} = ply_partner:cultivate_partner(PS, PartnerId, Count2),
                    {ok, BinData} = pt_17:write(?PT_PARTNER_CULTIVATE, [PartnerId, RetList]),
                    lib_send:send_to_sock(PS1, BinData),

                    case lib_partner:get_partner(PartnerId) of
                        null -> skip;
                        Partner ->
                            CultivateLv = lib_partner:get_cultivate_lv(Partner),
                            CultivateLayer = lib_partner:get_cultivate_layer(Partner),
                            case CultivateLv > OldCultivateLv orelse CultivateLayer > OldCultivateLayer of
                                false -> skip;
                                true ->
                                    mod_partner:db_save_partner(Partner),
                                    case lib_partner:is_follow_partner(Partner) of
                                        false -> skip;
                                        true -> lib_partner:notify_main_partner_info_change_to_AOI(PS, Partner)
                                    end,
                                    ply_partner:notify_when_partner_cultivate_lv_up(PS)
                            end
                    end,
                    ply_attr:recount_battle_power(PS1),
                    case lists:keyfind(0, 1, RetList) of
                        false -> skip;
                        {0, _} -> lib_event:event(cultivate_partner, [], PS)
                    end
            end
    end;


%%-----------------------请求可携带数量可出战数量 当可出战数量发生变化时服务端也主动推送这信息----------------------------
handle(?PT_GET_NUM_LIMIT, PS, _) ->
    CurCarryNum = player:get_partner_capacity(PS),
    CurFightNum = ply_partner:get_can_fight_partner_count(PS),
    {ok, BinData} = pt_17:write(?PT_GET_NUM_LIMIT, [CurCarryNum, CurFightNum]),
    lib_send:send_to_sock(PS, BinData);


%% --------------------宠物使用物品---------------
handle(?PT_PARTNER_USE_GOODS, PS, [PartnerId, GoodsId, Count]) ->
    case mod_inv:find_goods_by_id_from_whole_inv(player:get_id(PS), GoodsId) of
        null -> lib_send:send_prompt_msg(PS, ?PM_GOODS_NOT_EXISTS);
        Goods ->
            case ply_partner:use_goods(PS, PartnerId, Goods, Count) of
                {fail, Reason} ->
                    {ok, BinData} = pt_17:write(?PT_PARTNER_USE_GOODS, [?RES_OK, Goods, Count]),
                    lib_send:send_to_sock(PS, BinData),
                    lib_send:send_prompt_msg(PS, Reason);
                {ok, UseCount} ->
                    GoodsEffNoList = lib_goods:get_effects(Goods),
                    F = fun(EffNo) ->
                        EffData = data_goods_eff:get(EffNo),
                         case EffData#goods_eff.name of
                             add_exp ->
                                 mod_achievement:notify_achi(feed_pet, [], PS);
                             _  -> skip
                         end
                        end,
                    lists:foreach(F, GoodsEffNoList),
                    ply_tips:send_sys_tips(PS, {use_goods, [lib_goods:get_no(Goods), lib_goods:get_quality(Goods), UseCount,lib_goods:get_id(Goods)]}),
                    {ok, BinData} = pt_17:write(?PT_PARTNER_USE_GOODS, [?RES_OK, Goods, Count]),
                    lib_send:send_to_sock(PS, BinData),
                    case lib_goods:get_tpl_data(lib_goods:get_no(Goods)) of
                        #goods_tpl{type = 4, subtype = 4} ->
                            mod_achievement:notify_achi('jineng_chongwu', [], PS);
                        _ ->
                            skip
                    end,
                    ok
            end
    end;


%%-----------------------改变宠物心情----------------------------
handle(?PT_PAR_CHANGE_MOOD, PS, [PartnerId]) ->
    case ply_partner:change_mood(PS, PartnerId) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        {ok, Count} ->
            {ok, BinData} = pt_17:write(?PT_PAR_CHANGE_MOOD, [Count]),
            lib_send:send_to_sock(PS, BinData)
    end;


%%-----------------------获取已经改变宠物心情的次数----------------------------
handle(?PT_GET_CHANGE_MOOD_COUNT, PS, _) ->
    Count = player:get_update_mood_count(PS),
    {ok, BinData} = pt_17:write(?PT_GET_CHANGE_MOOD_COUNT, [Count]),
    lib_send:send_to_sock(PS, BinData);


%% %% 作废2020.02.25 zjy
%% %%------------------批量放生-----------------------------------
%% handle(?PT_BATCH_FREE_PARTNER, PS, [IdList]) ->
%%     case ply_partner:batch_free_partner(PS, IdList) of
%%         {fail, Reason} ->
%%             lib_send:send_prompt_msg(PS, Reason),
%%             {ok, BinData} = pt_17:write(?PT_BATCH_FREE_PARTNER, [Reason, []]),
%%             lib_send:send_to_sock(PS, BinData);
%%         {ok, RetList} ->
%%             ?TRACE("pp_partner:Para IdList:~p, RetList:~p~n", [IdList, RetList]),
%%             {ok, BinData} = pt_17:write(?PT_BATCH_FREE_PARTNER, [?RES_OK, RetList]),
%%             lib_send:send_to_sock(PS, BinData)
%%     end;
%% 
%% %% 作废2020.02.25 zjy
%% %%------------------一键放生-----------------------------------
%% handle(?PT_ONE_KEY_FREE_PARTNER, PS, _) ->
%%     case ply_partner:one_key_free_partner(PS) of
%%         {fail, Reason} ->
%%             lib_send:send_prompt_msg(PS, Reason),
%%             {ok, BinData} = pt_17:write(?PT_ONE_KEY_FREE_PARTNER, [Reason, []]),
%%             lib_send:send_to_sock(PS, BinData);
%%         {ok, RetList} ->
%%             {ok, BinData} = pt_17:write(?PT_ONE_KEY_FREE_PARTNER, [?RES_OK, RetList]),
%%             lib_send:send_to_sock(PS, BinData)
%%     end;
%% 
%% 
%% %% ----------------------进入青楼---------------------------
%% handle(?PT_PAR_ENTER_HOTEL, PS, [LvStep, EnterType]) ->
%%     case ply_sys_open:is_open(PS, ?SYS_FIND_PAR) of
%%         false -> skip;
%%         true ->
%%             ?DEBUG_MSG("LvStep=~p,EnterType=~p",[LvStep, EnterType]),
%%             case ply_partner:enter_hotel(PS, LvStep, EnterType) of
%%                 {fail, Reason} ->
%%                     lib_send:send_prompt_msg(PS, Reason);
%%                 ok ->
%%                     {ok, BinData} = pt_17:write(?PT_PAR_ENTER_HOTEL, [?RES_OK, EnterType]),
%%                     lib_send:send_to_sock(PS, BinData)
%%             end
%%     end;
%% 
%% 
%% 
%% %%------------------放生青楼中自己抽取出来的女妖（包括放生与一键放生）-----------------------------------
%% handle(?PT_PAR_FREE_IN_HOTEL, PS, [IdList]) ->
%%     case ply_partner:free_partner_in_hotel(PS, IdList) of
%%         {fail, Reason} ->
%%             lib_send:send_prompt_msg(PS, Reason);
%%         {ok, RetList} ->
%%             ?TRACE("pp_partner:Para IdList:~p, RetList:~p~n", [IdList, RetList]),
%%             {ok, BinData} = pt_17:write(?PT_PAR_FREE_IN_HOTEL, [RetList]),
%%             lib_send:send_to_sock(PS, BinData)
%%     end;
%% 
%% 
%% %%------------------领养青楼中自己抽取出来的女妖（包括领养与一键领养）-----------------------------------
%% handle(?PT_PAR_ADOPT_IN_HOTEL, PS, [IdList]) ->
%%     case ply_partner:adopt_partner(PS, IdList) of
%%         {fail, Reason} ->
%%             lib_send:send_prompt_msg(PS, Reason);
%%         {ok, RetList} ->
%%             {ok, BinData} = pt_17:write(?PT_PAR_ADOPT_IN_HOTEL, [RetList]),
%%             lib_send:send_to_sock(PS, BinData)
%%     end;
%% 
%% 
%% %% ------------------------获取上次抽取的信息 or 开始寻妖 or 再来一次--------------------------------
%% handle(?PT_PAR_FIND_PAR_INFO, PS, [Type]) ->
%%     case ply_sys_open:is_open(PS, ?SYS_FIND_PAR) of
%%         false -> skip;
%%         true ->
%%             case Type of
%%                 0 ->
%%                     Info = ply_partner:get_find_par_info(player:id(PS)),
%%                     {ok, BinData} = pt_17:write(?PT_PAR_FIND_PAR_INFO, [Info]),
%%                     lib_send:send_to_sock(PS, BinData);
%%                 1 ->
%%                     case ply_partner:find_partner(PS) of
%%                         {fail, Reason} ->
%%                             lib_send:send_prompt_msg(PS, Reason);
%%                         {ok, FindPar} ->
%%                             {ok, BinData} = pt_17:write(?PT_PAR_FIND_PAR_INFO, [FindPar]),
%%                             lib_send:send_to_sock(PS, BinData)
%%                     end;
%%                 2 ->
%%                     case ply_partner:find_partner_again(PS) of
%%                         {fail, Reason} ->
%%                             lib_send:send_prompt_msg(PS, Reason);
%%                         {ok, FindPar} ->
%%                             {ok, BinData} = pt_17:write(?PT_PAR_FIND_PAR_INFO, [FindPar]),
%%                             lib_send:send_to_sock(PS, BinData)
%%                     end;
%%                 _Any ->
%%                     lib_send:send_prompt_msg(PS, ?PM_PARA_ERROR)
%%             end
%%     end;
%% 
%% 
%% %%-----------------获取青楼中自己抽取的女妖详细信息-----------------------------------
%% handle(?PT_PAR_GET_ATTR_OF_PAR_HOTEL, PS, [PartnerId]) ->
%%     case ply_partner:get_find_par_info(player:id(PS)) of
%%         null -> lib_send:send_prompt_msg(PS, ?PM_PAR_NOT_EXISTS);
%%         FindPar ->
%%             case lists:keyfind(PartnerId, #partner.id, FindPar#find_par.par_list) of
%%                 false -> lib_send:send_prompt_msg(PS, ?PM_PAR_NOT_EXISTS);
%%                 Partner ->
%%                     {ok, BinData} = pt_17:write(?PT_PAR_GET_ATTR_OF_PAR_HOTEL, [Partner]),
%%                     lib_send:send_to_sock(PS, BinData)
%%             end
%%     end;


%%------------ 获取宠物的装备面板信息 ------------------------
handle(?PT_PAR_GET_EQUIP_INFO, PS, [PartnerId]) ->
    case lib_partner:get_partner(PartnerId) of
        null -> lib_send:send_prompt_msg(PS, ?PM_PAR_NOT_EXISTS);
        Partner ->
            {ok, BinData} = pt_17:write(?PT_PAR_GET_EQUIP_INFO, [Partner]),
            lib_send:send_to_sock(PS, BinData)
    end;


%%----------------设置宠物为跟随状态-------------------------
handle(?PT_SET_PARTNER_FOLLOW_STATE, PS, [PartnerId, Follow]) ->
    case ply_partner:set_partner_follow_state(PS, PartnerId, Follow) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        ok ->
            {ok, BinData} = pt_17:write(?PT_SET_PARTNER_FOLLOW_STATE, [PartnerId, Follow]),
            lib_send:send_to_sock(PS, BinData)
    end;


%%------------------女妖传功-----------------------------------
handle(?PT_PAR_TRANSMIT, PS, [TargetParId, IdList]) ->
    case ply_partner:parnter_transmit(PS, TargetParId, IdList) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        ok ->
            {ok, BinData} = pt_17:write(?PT_PAR_TRANSMIT, [TargetParId, IdList]),
            lib_send:send_to_sock(PS, BinData)
    end;


%% -----------------使用道具立刻增加后天技能--------------------------
handle(?PT_PAR_ADD_SKILL, PS, [PartnerId]) ->
    case ply_partner:add_postnatal_skill(PS, PartnerId) of
        {fail, Reason} ->
            lib_send:send_prompt_msg(PS, Reason);
        ok ->
%%			mod_achievement:notify_achi(par_active_skill, [], PS),
            skip
    end;

%% 分配自由天赋点（手动加天赋点）
handle(?PT_PAR_ALLOT_FREE_TALENT_POINTS, PS, [TargetParId,AllotInfoList]) ->
    % 检测加点
    case check_allot_free_talent_points(PS, TargetParId,AllotInfoList) of
        ok ->
            % 进行加点
            % Partner = lib_partner:get_partner(TargetParId),
            lib_partner:allot_free_talent_points(PS,TargetParId,AllotInfoList),
            mod_achievement:notify_achi('jiadian_chongwu', [], PS);
        fail ->
            skip
    end,
    void;

handle(?PT_PAR_RESET_FREE_TALENT_POINTS, PS, [TargetParId]) ->
    % 检测加点
    case lib_partner:get_partner(TargetParId) of
        Partner when is_record(Partner,partner) ->
            case lib_partner:get_lv(Partner) > ?FREE_WASH_POINT_LV of
                false ->
                    lib_partner:reset_free_talent_points(PS,TargetParId);
                true ->
                    lib_send:send_prompt_msg(PS, ?PM_FREE_WASH_POINT_LV_LIMIT)
            end;

        fail ->
            skip
    end,
    void;


%% 删除技能(遗忘技能直接遗忘就可以了)
handle(?PT_PAR_DEL_SKILL, PS, [TargetParId,SkillId]) ->
    % 检测加点
    case lib_partner:get_partner(TargetParId) of
        Partner when is_record(Partner,partner) ->
            case ply_partner:del_skill(PS,TargetParId,SkillId) of
                ok ->
                    skip;
                {fail, Reason} ->
                    lib_send:send_prompt_msg(PS, ?PROMPT_MSG_TYPE_WARN, Reason)
            end;
        fail ->
            skip
    end,
    void;


%% 切换宠物技能页
handle(?PT_PAR_CHANGE_SKILL_PAGE, PS, [PartnerId, SkillsUse]) ->
	case ply_partner:change_skill_page(PS, PartnerId, SkillsUse) of
		ok ->
			{ok, BinData} = pt_17:write(?PT_PAR_CHANGE_SKILL_PAGE, [PartnerId, SkillsUse]),
            lib_send:send_to_sock(PS, BinData);
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, ?PROMPT_MSG_TYPE_WARN, Reason)
	end,
    void;
		

%% 宠物觉醒
handle(?PT_PAR_AWAKE, PS, [PartnerId]) ->
	case ply_partner:partner_awake(PS, PartnerId) of
		{ok, AwakeLv} ->
			{ok, BinData} = pt_17:write(?PT_PAR_AWAKE, [PartnerId, AwakeLv]),
			lib_send:send_to_sock(PS, BinData);
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason)
	end;

		

%% 宠物觉醒幻化
handle(?PT_PAR_AWAKE_ILLUSION, PS, [PartnerId, AwakeLv]) ->
	case ply_partner:partner_awake_illusion(PS, PartnerId, AwakeLv) of
		ok ->
			{ok, BinData} = pt_17:write(?PT_PAR_AWAKE_ILLUSION, [PartnerId, AwakeLv]),
			lib_send:send_to_sock(PS, BinData);
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason)
	end;




%%门客五行鉴定，由于策划需求，导致表上杂糅，只能写死，一二级不涉及门客属性数值的变化
handle(?PT_PAR_FIVE_ELMENT_START, PS, [Type,PartnerId]) ->
    case Type of
        1 ->
            NeedCost = data_special_config:get(five_elements_identification),
            case mod_inv:check_batch_destroy_goods(player:get_id(PS), [NeedCost])  of
                ok ->
                    mod_inv:destroy_goods_WNC(player:get_id(PS), [NeedCost], ["pp_partner", "identify"]),
                    FiveElement = random:uniform(6),
                    case lib_partner:get_partner(PartnerId) of
                        null ->  lib_send:send_prompt_msg(player:get_id(PS), ?PM_PAR_STATE_ERROR);
                        Partner ->
                              {_, FiveElementLv} = Partner#partner.five_element,
                              mod_partner:update_partner_to_ets(Partner#partner{five_element = {FiveElement, 1} }),
                              lib_partner:notify_cli_info_change(Partner#partner{five_element = FiveElement }, [{117, FiveElement}]),
                            lib_partner:notify_cli_info_change(Partner#partner{five_element = FiveElement }, [{118, 1}]),
                            {ok, BinData} = pt_17:write(?PT_PAR_FIVE_ELMENT_START, [0,FiveElement]),
                            lib_send:send_to_sock(PS, BinData)

                    end;
                {fail, Reason} ->
                    lib_send:send_prompt_msg(player:get_id(PS), Reason)
            end;
        2 ->
            NeedCost = data_special_config:get(five_elements_replace),
            case mod_inv:check_batch_destroy_goods(player:get_id(PS), [NeedCost])  of
                ok ->
                    mod_inv:destroy_goods_WNC(player:get_id(PS), [NeedCost], ["pp_partner", "identify"]),
                    FiveElement = random:uniform(6),
                    case lib_partner:get_partner(PartnerId) of
                        null ->  lib_send:send_prompt_msg(player:get_id(PS), ?PM_PAR_STATE_ERROR);
                        Partner ->
                            {LastElement, _} = Partner#partner.five_element,
                            mod_partner:update_partner_to_ets(Partner#partner{five_element = {FiveElement, 1} }),
                            %%重算属性
                            Partner1 = lib_partner:recount_total_attrs(Partner#partner{five_element = {FiveElement, 1} }),
                            Partner2 = lib_partner:recount_battle_power(Partner1),
                            mod_partner:update_partner_to_ets(Partner2),
                            case lib_partner:is_fighting(Partner2) of
                                true -> ply_attr:recount_battle_power(PS);
                                false -> skip
                            end,
                            lib_partner:notify_cli_info_change(Partner#partner{five_element = FiveElement }, [{117, FiveElement}]),
                            lib_partner:notify_cli_info_change(Partner#partner{five_element = FiveElement }, [{118, 1}]),
                            {ok, BinData} = pt_17:write(?PT_PAR_FIVE_ELMENT_START, [LastElement,FiveElement]),
                            lib_send:send_to_sock(PS, BinData)

                    end;
                {fail, Reason} ->
                    lib_send:send_prompt_msg(player:get_id(PS), Reason)
            end
    end;

%%一二级不涉及属性变化，有些五级的也不涉及，有些是提升百分比，由于表不统一无法做到随表，只能写死处理
handle(?PT_PAR_FIVE_ELMENT_LV, PS, [PartnerId]) ->

  case lib_partner:get_partner(PartnerId) of
    null ->  lib_send:send_prompt_msg(player:get_id(PS), ?PM_PAR_STATE_ERROR);
    Partner ->
      {FiveElement, FiveElementLv} = Partner#partner.five_element,
      case FiveElementLv >= 5 of  %大于最大的五行等级则发998
        true ->
          lib_send:send_prompt_msg(player:get_id(PS), ?PM_GUILD_CULTIVATE_LV_MAX);
        false ->
          ElementsLevelData = data_five_elements_level:get(FiveElement,FiveElementLv),
          NeedCost =  ElementsLevelData#five_elements_level.expend,
          case mod_inv:check_batch_destroy_goods(player:get_id(PS), NeedCost)  of
            ok ->
              mod_inv:destroy_goods_WNC(player:get_id(PS), NeedCost, ["pp_partner", "element_lv"]),
              mod_partner:update_partner_to_ets(Partner#partner{five_element = {FiveElement, FiveElementLv + 1} }),
              %%重算属性
              Partner1 = lib_partner:recount_total_attrs(Partner#partner{five_element = {FiveElement, FiveElementLv + 1} }),
              Partner2 = lib_partner:recount_battle_power(Partner1),
              mod_partner:update_partner_to_ets(Partner2),
              case lib_partner:is_fighting(Partner2) of
                true -> ply_attr:recount_battle_power(PS);
                false -> skip
              end,
              lib_partner:notify_cli_info_change(Partner#partner{five_element = FiveElement }, [{118,  FiveElementLv + 1}]),
              {ok, BinData} = pt_17:write(?PT_PAR_FIVE_ELMENT_LV, [FiveElementLv + 1]),
              lib_send:send_to_sock(PS, BinData);
            {fail, Reason} ->
              lib_send:send_prompt_msg(player:get_id(PS), Reason)
          end
      end

  end;


%%设置出战顺序（只能更改已出战的门客顺序） 
handle(?PT_CHANGE_PARTNER_BATTLE_ORDER,PS,[PartnerIdList]) ->
    try
         mod_partner:manage_parter_order(PS, PartnerIdList)
    catch
        throw:FailReason ->
            {ok, BinData} = pt_17:write(?PT_CHANGE_PARTNER_BATTLE_ORDER, [FailReason, PartnerIdList]),
            lib_send:send_to_sock(PS, BinData)
    end;




%% 扩展技能格子
handle(?PT_PARTNER_SKILL_SLOT_EXPAND,PS,[PartnerId]) ->
	case lib_partner:get_partner(PartnerId) of
        Partner when is_record(Partner,partner) ->
            case ply_partner:expand_skill_slot(PS,PartnerId) of
                {ok, BinData} ->
%%                     {ok, BinData} = pt_17:write(?PT_PARTNER_SKILL_SLOT_EXPAND, [PartnerId]),
					lib_send:send_to_sock(PS, BinData);
                {fail, Reason} ->
                    lib_send:send_prompt_msg(PS, ?PROMPT_MSG_TYPE_WARN, Reason)
            end;
        fail ->
            skip
    end,
    void;



%% 宠物精炼/请求数据
handle(?PT_PARTNER_ATTR_REFINE, PS, [PartnerId, AttrCode, GoodsNo, Count]) ->
	case ply_partner:partner_refine(PS, PartnerId, AttrCode, GoodsNo, Count) of
		{ok, Partner}->
			PartnerId = lib_partner:get_id(Partner),
			AttrRefine = lib_partner:get_attr_refine(Partner),
			AttrValues = lists:foldl(fun({AttrName, AttrValue}, Acc) ->
											 ObjCode = lib_attribute:attr_name_to_obj_info_code(AttrName),
											 [{ObjCode, AttrValue}|Acc]
									 end, [], AttrRefine),
			{ok, BinData} = pt_17:write(?PT_PARTNER_ATTR_REFINE, [PartnerId, AttrValues]),
			lib_send:send_to_sock(PS, BinData);
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason)
	end;


%% 宠物放生 2020.02.26 zjy
handle(?PT_PARTNER_FREE, PS, [PartnerId, Type]) ->
	case ply_partner:partner_free(PS, PartnerId, Type) of
		{ok, ReturnGoodsNoList} ->
			{ok, BinData} = pt_17:write(?PT_PARTNER_FREE, [PartnerId, Type, ReturnGoodsNoList]),
			lib_send:send_to_sock(PS, BinData);
		{fail, Reason} ->
			lib_send:send_prompt_msg(PS, Reason)
	end;



%% 异常情况
handle(_Cmd, _PS, _) ->
	?DEBUG_MSG("pp_partner no match", []),
    {error, "pp_partner no match"}.


check_allot_free_talent_points(PS, TargetParId,AllotInfoList) ->
    check_allot_free_talent_points__(PS,TargetParId, AllotInfoList, 0).


check_allot_free_talent_points__(PS,TargetParId, [{TalentCode, Points} | T], AccPointsToAllot) ->
    case 0 < TalentCode andalso TalentCode =< 5 of
        false ->
            ?ASSERT(false, TalentCode),
            fail;
        true ->
            check_allot_free_talent_points__(PS, TargetParId,T, AccPointsToAllot + Points)
    end;
check_allot_free_talent_points__(_PS,TargetParId, [], AccPointsToAllot) ->
    Partner = lib_partner:get_partner(TargetParId),
    case Partner == null orelse AccPointsToAllot == 0 orelse AccPointsToAllot > lib_partner:get_free_talent_points(Partner) of
        true ->
            fail;
        false ->
            ok
    end.
