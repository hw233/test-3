%%%--------------------------------------
%%% @Module: lib_mount
%%% @Author: lf
%%% @Created: 2015.05.06
%%% @Description: 坐骑的相关函数
%%%--------------------------------------
-module(lib_mount).

-export([
        update_mount/1,
        get_all_rest_mount/1,
        get_out_mount/1,
        get_mount/1,get_mount/2,
        delete_mount/1,delete_all_mount/1,
        init_login/1,init_mount/1, load_all_mount/1,
        load_mount_into_ets/1,
        player_add_mount/2,
        player_add_mount/3,
		player_add_mount_offline/2,
        player_add_mount_offline/3,
        db_insert_mount/1,
        do_player_add_mount/3,        get_all_mount/1,
        off_mount/2,
        on_mount/2,
        rename_mount/3,
        reset_attr_mount/4,
        get_rand_3/1,
        set_attr_mount/8,
        feed_mount/4,
        inheritance_mount/3,
        toll_inheritance_mount/3,
        stren_mount/4,
        open_mount_skill/3,
        learn_mount_skill/4,
        del_mount_skill/3,
        up_mount_skill/4,
        connect_partner/4,
        concel_connect_partner/4,
        get_mount_skill/1,
        get_mount_attribute/1,
        get_mount_attribute/9,
        set_mount_feed_times/2,
        check_data/1,
        check_player_add_mount/2,
        calc_mount_battle_pow/1,
		mount_attr_to_no/1,
        get_mount_nos/1,
        player_add_mount_skin/3,
        on_login/1,
        on_logout/1,
        del_expire_skin/2,
        find_skin/2,
        get_skins/1,
		set_skins/1,
        get_mount_skin_attr/1,
        player_change_skin/2,
        get_skin_remain_time/1,
        transform_mount_skill/5,
        test/0
        ]).


-include("record.hrl").
-include("mount.hrl").
-include("ets_name.hrl").
-include("pt_18.hrl").
-include("record/goods_record.hrl").
-include("prompt_msg_code.hrl").
-include("attribute.hrl").
-include("obj_info_code.hrl").
-include("skill.hrl").
-include("bo.hrl").
-include("prompt_msg_code.hrl").
-include("common.hrl").
-include("buff.hrl").
-include("effect.hrl").
-include("xinfa.hrl").
-include("goods.hrl").
-include("abbreviate.hrl").
-include("pt_12.hrl").
-include("num_limits.hrl").
-include("log.hrl").
-include("diy.hrl").
-include("partner.hrl").

-define(MOUNT_ATTR_DATA, {mount_attr, data}). %保存上次刷出来的重修值

%%公用接口
lookup_one(Table, Key) ->
    Record = ets:lookup(Table, Key),
    if  Record =:= [] ->
            null;
        true ->
            [R] = Record,
            R
    end.

lookup_all(Table, Key) ->
    ets:lookup(Table, Key).

match_one(Table, Pattern) ->
    Record = ets:match_object(Table, Pattern),
    if  Record =:= [] ->
            null;
        true ->
            [R|_] = Record,
            R
    end.

match_all(Table, Pattern) ->
    ets:match_object(Table, Pattern).

%%更新坐骑
update_mount(Mount) ->
    ets:insert(?ETS_MOUNT, Mount).

%%查找角色所有休息状态的坐骑
get_all_rest_mount(PlayerId) ->
   match_all(?ETS_MOUNT, #ets_mount{player_id=PlayerId,status=0, _='_'}).

%%查看出战坐骑
get_out_mount(PlayerId) ->
    match_one(?ETS_MOUNT,#ets_mount{player_id = PlayerId,status = 1,_='_'}).

get_mount(PlayerId, MountId) ->
    match_one(?ETS_MOUNT, #ets_mount{id=MountId, player_id=PlayerId, _='_'}).

get_mount(MountId) ->
    lookup_one(?ETS_MOUNT, MountId).

%%删除坐骑
delete_mount(MountId) ->
    ets:delete(?ETS_MOUNT, MountId).

delete_all_mount(PlayerId) ->
    ets:match_delete(?ETS_MOUNT, #ets_mount{player_id=PlayerId, _='_'}).


%%玩家上线加载坐骑信息
init_login(PlayerId) ->
    init_mount(PlayerId).

init_mount(PlayerId) ->
    load_all_mount(PlayerId).

load_all_mount(PlayerId) ->
    % 获取所有的坐骑并插入ets
    case db:select_all(mount, ?SQL_GET_MOUNT_INFO, [{player_id, PlayerId}]) of
        [] -> % 没有
            ?TRACE("sizeof partner: 0~n"),
            [];
        InfoList when is_list(InfoList) ->
            lists:map(fun(MountInfo) -> load_mount_into_ets(MountInfo) end, InfoList),
            MountList = get_all_mount(PlayerId),
            [X#ets_mount.id || X <- MountList];
        _ -> % db读取出错
            ?ASSERT(false),
            []
    end.

load_mount_into_ets(MountInfo) ->
    Mount = list_to_tuple([ets_mount] ++ MountInfo),
    %%防止因断线后原ets信息仍在
    ets:delete(?ETS_MOUNT, Mount#ets_mount.id),
    update_mount(Mount).


%玩家通过物品获得坐骑
player_add_mount(PS, MountNo) ->
	player_add_mount(PS, MountNo, []).


player_add_mount(PlayerId, MountNo, ExtraInfo) when is_integer(PlayerId) ->
	PS = player:get_PS(PlayerId),
	player_add_mount(PS, MountNo, ExtraInfo);

player_add_mount(PS, MountNo, ExtraInfo) ->
    case check_player_add_mount(PS, MountNo) of
        {fail, Reason} ->
            {fail, Reason};
        ok ->
			PlayerId = player:get_id(PS),
			NewMount = do_player_add_mount(PlayerId, MountNo, ExtraInfo),
			PS1 = 
				case lists:member(NewMount#ets_mount.id, PS#player_status.mount_id_list) of
					true ->
						?ASSERT(false),
						?ERROR_MSG("ply_partner:do_player_add_mount error!", []),
						PS;
					false ->
						PS#player_status{mount_id_list = [NewMount#ets_mount.id | PS#player_status.mount_id_list]}
				end,
			DataMountInfo = data_mount:get_mount_info(MountNo),
            mod_inv:destroy_goods_WNC(PlayerId, DataMountInfo#mount_info.goods_list, ["lib_mount","add_mount"]),
			ply_tips:send_sys_tips(PS1, {add_mount, [DataMountInfo#mount_info.name]}),
			player_syn:update_PS_to_ets(PS1),
            {ok, NewMount#ets_mount.id}
    end.

%% 离线给玩家添加坐骑
player_add_mount_offline(PlayerId, MountNo) ->
	player_add_mount_offline(PlayerId, MountNo, []).

player_add_mount_offline(PlayerId, MountNo, ExtraInfo) ->
	MountNoList = 
		case db:select_all(mount, "no", [{player_id, PlayerId}]) of
			[] -> % 没有
				?TRACE("sizeof partner: 0~n"),
				[];
			NoList when is_list(NoList) ->
				NoList;
			_ -> % db读取出错
				?ASSERT(false),
				[]
		end,
	case data_mount:get_mount_info(MountNo) of
		null ->
			?ASSERT(false, MountNo),
			{fail, ?PM_DATA_CONFIG_ERROR};
		_Any -> 
			case lists:member(MountNo,MountNoList) of
				true ->
					{fail, ?PM_YOU_HAVE_MOUNT};
				false ->
					do_player_add_mount(PlayerId, MountNo, ExtraInfo),
					ok
			end                
	end. 
	

% 获取玩家的所有坐骑编号
get_mount_nos(PS) ->
    MountList = get_all_mount(player:id(PS)),
    [X#ets_mount.no || X <- MountList].

% 增加获得坐骑的判断
check_player_add_mount(PS, MountNo) ->
    MaxMountCount = data_special_config:get('mount_num'),
    case length(player:get_mount_id_list(PS)) >= MaxMountCount of
        true -> {fail, ?PM_MOUNT_OVER_MAX_COUNT};
        false ->
            % ?ylh_Debug("check_player_add_mount id_list=~p~n", [player:get_mount_id_list(PS)]),
            NoList = lib_mount:get_mount_nos(PS),
            case data_mount:get_mount_info(MountNo) of
                null ->
                    ?ASSERT(false, MountNo),
                    {fail, ?PM_DATA_CONFIG_ERROR};
                MountInfo ->
                    case lists:member(MountNo,NoList) of
                        true ->
                            {fail, ?PM_YOU_HAVE_MOUNT};
                        false ->
                            case mod_inv:check_batch_destroy_goods(PS, MountInfo#mount_info.goods_list) of
                                {fail, Reason} ->
                                    {fail, Reason};
                                ok ->
                                    ok
                            end
                    end                
            end
    end.

db_insert_mount(Mount) when is_record(Mount, ets_mount) ->     
    NewId = db:insert_get_id(mount, 
        [no, player_id, name, type, quality, level, exp, skillNum, skill, attribute_1, attribute_2, attribute_3, attribute_add1, attribute_add2, attribute_sub, 
        attributeList, step, step_value, status, partner_num, partner1, partner2, partner3, partner4, partner5, feed, feed_timestamp, battle_power, custom_type, partner_maxnum],
        [Mount#ets_mount.no, Mount#ets_mount.player_id, Mount#ets_mount.name, Mount#ets_mount.type, Mount#ets_mount.quality, Mount#ets_mount.level,
         Mount#ets_mount.exp, Mount#ets_mount.skillNum, Mount#ets_mount.skill, Mount#ets_mount.attribute_1, Mount#ets_mount.attribute_2, Mount#ets_mount.attribute_3,
         Mount#ets_mount.attribute_add1, Mount#ets_mount.attribute_add2, Mount#ets_mount.attribute_sub, Mount#ets_mount.attributeList, Mount#ets_mount.step, Mount#ets_mount.step_value,
         Mount#ets_mount.status, Mount#ets_mount.partner_num, Mount#ets_mount.partner1, Mount#ets_mount.partner2, Mount#ets_mount.partner3, Mount#ets_mount.partner4,
         Mount#ets_mount.partner5, Mount#ets_mount.feed, Mount#ets_mount.feed_timestamp, Mount#ets_mount.battle_power, Mount#ets_mount.custom_type, Mount#ets_mount.partner_maxnum]),
    NewId1 = 
        case lib_account:is_global_uni_id(NewId) of 
            true -> NewId; 
            false -> 
                GlobalId = lib_account:to_global_uni_id(NewId),
                db:update(Mount#ets_mount.player_id, mount, ["id"], [GlobalId], "id", NewId), 
                GlobalId
        end,
    Mount#ets_mount{id = NewId1}.


%% 这个函数不处理PS的更新，扩展在线离线通用的添加坐骑接口
do_player_add_mount(PlayerId, MountNo, ExtraInfo) ->
    DataMountInfo = data_mount:get_mount_info(MountNo),
    {AttributeNo1, AttributeNo2, AttributeNo3} = get_rand_3(length(data_mount:get_attr(1))),
    AttributeAddRatio1 = util:rand(?MOUNT_ADD_RANCE_MIN, ?MOUNT_ADD_RANCE_MAX),
    AttributeAddRatio2 = util:rand(?MOUNT_ADD_RANCE_MIN, ?MOUNT_ADD_RANCE_MAX),
    AttributeSubRatio = util:rand(?MOUNT_SUB_RANCE_MIN, ?MOUNT_SUB_RANCE_MAX),

    ?DEBUG_MSG("(~p)(~p)(~p)",
        [
            util:get_server_first_open_stamp(),
            util:get_nth_day_from_time_to_now(util:get_server_first_open_stamp())-1,
            erlang:min( (util:get_nth_day_from_time_to_now(util:get_server_first_open_stamp())-1) * ?INIT_FEED_TIMES,?MAX_FEED_TIMES)
        ]
    ),

    MountList = get_all_mount(PlayerId),
    {Level, Exp} = case MountList =:= [] of
                       false ->
                           case erlang:hd(MountList) of
                               #ets_mount{level = Level1, exp = Exp1} ->
                                   {Level1, Exp1};
                               _ ->
                                   {1, 0}
                           end;
                       true->
                            {1, 0}
                   end,

    NewFeedTimes = erlang:max(?DAY_FEED_TIMES,erlang:min( (util:get_nth_day_from_time_to_now(util:get_server_first_open_stamp())-1) * ?INIT_FEED_TIMES,?MAX_FEED_TIMES)),
    %% 扩展定制需求，判断额外参数处理特别定制功能
	Mount0 = #ets_mount{
						id = 0
						,no = MountNo
						,player_id = PlayerId
						,name = DataMountInfo#mount_info.name
						,type = DataMountInfo#mount_info.type
						,quality = 1
						,level = Level
						,exp = Exp
						,skillNum = DataMountInfo#mount_info.skill_num
						,skill = <<"[0,0,0,0]">>
						,attribute_1 = AttributeNo1     
						,attribute_2 = AttributeNo2     
						,attribute_3 = AttributeNo3
						,attribute_add1 = AttributeAddRatio1 
						,attribute_add2 = AttributeAddRatio2
						,attribute_sub = AttributeSubRatio
						,attributeList = <<"[]">> 
						,step = 1          
						,step_value = 0   
						,status = 0        
						,partner_num = 0   
						,partner1 = 0
						,partner2 = 0
                        ,partner3 = 0
                        ,partner4 = 0
                        ,partner5 = 0
						,feed = NewFeedTimes
						,feed_timestamp = util:unixtime()
						,battle_power = 0
                        ,custom_type = 0
                        ,partner_maxnum = 2
					   },
	Mount = lists:foldl(fun({lv, Lv}, MountAcc) ->
								MountAcc#ets_mount{level = Lv};
						   ({degree, Degree}, MountAcc) ->
								MountAcc#ets_mount{step = Degree};
						   ({attribute_1, Attribute}, MountAcc) ->
                                case is_integer(Attribute) andalso Attribute > 0 of
                                    true -> MountAcc#ets_mount{attribute_1 = Attribute};
                                    false ->
                                        case mount_attr_to_no(Attribute) of
                                            0 ->
                                                MountAcc;
                                            AttributeNoExtra ->
                                                MountAcc#ets_mount{attribute_1 = AttributeNoExtra}
                                        end
                                end;
						   ({attribute_2, Attribute}, MountAcc) ->
                                case is_integer(Attribute) andalso Attribute > 0 of
                                    true -> MountAcc#ets_mount{attribute_2 = Attribute};
                                    false ->
                                        case mount_attr_to_no(Attribute) of
                                            0 ->
                                                MountAcc;
                                            AttributeNoExtra ->
                                                MountAcc#ets_mount{attribute_2 = AttributeNoExtra}
                                        end
                                end;
						   ({attribute_3, Attribute}, MountAcc) ->
                                case is_integer(Attribute) andalso Attribute > 0 of
                                    true -> MountAcc#ets_mount{attribute_3 = Attribute};
                                    false ->
                                        case mount_attr_to_no(Attribute) of
                                            0 ->
                                                MountAcc;
                                            AttributeNoExtra ->
                                                MountAcc#ets_mount{attribute_3 = AttributeNoExtra}
                                        end
                                end;
						   ({attribute_add1, AttributeAdd}, MountAcc) when AttributeAdd > 0 ->
								MountAcc#ets_mount{attribute_add1 = AttributeAdd};
						   ({attribute_add2, AttributeAdd}, MountAcc) when AttributeAdd > 0 ->
								MountAcc#ets_mount{attribute_add2 = AttributeAdd};
						   ({attribute_sub, AttributeAdd}, MountAcc) when AttributeAdd > 0 ->
								MountAcc#ets_mount{attribute_sub = AttributeAdd};
                           ({custom_type, CustomType}, MountAcc) when CustomType > 0 ->
                                MountAcc#ets_mount{custom_type = CustomType};
                           ({partner_maxnum, PartnerMaxNum}, MountAcc) when PartnerMaxNum > 0 ->
                                MountAcc#ets_mount{partner_maxnum = PartnerMaxNum};
						   (UnHandle, MountAcc) ->
								?ERROR_MSG("UnHandle Field : ~p~n", [UnHandle]),
								MountAcc
						end, Mount0, ExtraInfo),
    NewMount = db_insert_mount(Mount),
    update_mount(NewMount),
    % mod_rank:mount_clv(NewMount),
    calc_mount_battle_pow(NewMount),
	NewMount.


mount_attr_to_no(Field) when is_binary(Field) ->
	FieldAtom = binary_to_atom(Field, utf8),
	mount_attr_to_no(FieldAtom);


mount_attr_to_no(Field) when is_list(Field) ->
	FieldAtom = list_to_atom(Field),
	mount_attr_to_no(FieldAtom);

mount_attr_to_no(Field) ->
	AttrList = data_mount:get_attr(1),
	mount_attr_to_no(AttrList, Field, 1).

mount_attr_to_no([{Field, _, _}|_], Field, N) ->
	N;

mount_attr_to_no([{_, _, _}|AttrList], Field, N) ->
	mount_attr_to_no(AttrList, Field, N + 1);

mount_attr_to_no([], Field, _N) ->
	?ERROR_MSG("Unknown Field : ~p~n", [Field]),
	0.


%%查询玩家所有的坐骑
get_all_mount(PlayerId) ->
    MountList = match_all(?ETS_MOUNT, #ets_mount{player_id=PlayerId, _='_'}),
    MountList.

%%坐骑卸下
off_mount(PS, Mount) ->
    NewMount = Mount#ets_mount{status = 0},
    update_mount(NewMount),
    db:update(NewMount#ets_mount.id, mount, [{status, 0}], [{id, NewMount#ets_mount.id}]),
    %%从玩家身上拿下坐骑
    OldMountId = player:get_mount(PS),
    if NewMount#ets_mount.id == OldMountId ->
            player:set_mount(PS, 0);
        true -> skip
    end,

    lib_scene:notify_int_info_change_to_aoi(player, player:get_id(PS), [{?OI_CODE_MOUNT_NO, 0},{?OI_CODE_MOUNT_STEP, 0}]),
    NewMount#ets_mount.id.

%%坐骑出战
on_mount(PS, Mount) ->
    OldMountId = case get_out_mount(player:id(PS)) of
        OldMount when is_record(OldMount, ets_mount) ->
            off_mount(PS, OldMount),
            OldMount#ets_mount.id;
        _ ->
            0
    end,
    NewMount = Mount#ets_mount{status = 1}, 
    update_mount(NewMount),

    db:update(NewMount#ets_mount.id, mount, [{status, 1}], [{id, NewMount#ets_mount.id}]),
    player:set_mount(PS, NewMount#ets_mount.id),

    lib_scene:notify_int_info_change_to_aoi(player, player:get_id(PS), [{?OI_CODE_MOUNT_NO, NewMount#ets_mount.no},{?OI_CODE_MOUNT_STEP, NewMount#ets_mount.step}]),
    
    mod_rank:mount_clv(NewMount),
    mod_rank:mount_battle_power(NewMount),
    
    OldMountId.

 %%坐骑改名
 rename_mount(PS, MountId, NewName) ->
    Mount = lib_mount:get_mount(MountId),
    if Mount == null ->
        [0, MountId, NewName];
        true ->
            NewMount = Mount#ets_mount{name = list_to_binary(NewName)},
            update_mount(NewMount),

            case player:get_mount(PS) == NewMount#ets_mount.id of
                true ->
                    mod_rank:mount_clv(NewMount),
                    mod_rank:mount_battle_power(NewMount),
                    true;
                false -> skip
            end,

            db:update(NewMount#ets_mount.id, mount, [{name, NewName}], [{id, NewMount#ets_mount.id}]),
            [1, MountId, NewName]
    end.

%%坐骑重修
reset_attr_mount(PS, MountId, ResetType, Times) ->
    Mount = lib_mount:get_mount(MountId),
    if Mount == null ->
        {false, ?PM_MOUNT_RESET_ATTR_ERR};
        true ->
            case lists:keyfind(ResetType, 1, data_special_config:get('mount_attr_reset_cost')) of
                {_, MoneyType, CostNum} ->
                  case mod_inv:check_batch_destroy_goods(player:get_id(PS), [{MoneyType, CostNum * Times}])  of
                    ok ->
                      %得到该坐骑等级相应的属性列表
                      Type = Mount#ets_mount.custom_type,
                      AttriList = case Type =:= 0 of
                                      true ->
                                          AttributeList = data_mount:get_attr(Mount#ets_mount.level),
                                          get_on_mount_att(ResetType, Times, length(AttributeList));
                                      false ->
                                          DiyMountAttr = data_diy_mount_attr:get((Type-1)*100+Mount#ets_mount.level),
                                          AttributeList = DiyMountAttr#diy_mount_attr.attr,
                                          get_on_diy_mount_att(ResetType, Times, length(AttributeList), Type)
                                  end,
                      NewMount = Mount#ets_mount{attributeList = util:term_to_bitstring(AttriList)},
                      update_mount(NewMount),

                      case player:get_mount(PS) == NewMount#ets_mount.id of
                          true ->
                              mod_rank:mount_clv(NewMount),
                              mod_rank:mount_battle_power(NewMount),
                              true;
                          false -> skip
                      end,

                      db:update(NewMount#ets_mount.id, mount, [{attributeList, util:term_to_bitstring(AttriList)}], [{id, NewMount#ets_mount.id}]),
                      mod_inv:destroy_goods_WNC(player:get_id(PS), [{MoneyType, CostNum * Times}], ["1", "2"]),
                        mod_achievement:notify_achi('xilian_zuoqi', Times, [], PS),
                      {ok, AttriList};
                    {fail, Reason} ->
                      {false, Reason}
                  end;
                false ->
                    {false, ?PM_DATA_CONFIG_ERROR}
            end
    end.

%得到三个不同的值
get_rand_3(Max) ->
    List1 = lists:seq(1, Max),
    No1 = util:rand(1, Max),
    AttributeNo1 = lists:nth(No1, List1),
    List2 = List1 -- [AttributeNo1],
    No2 = util:rand(1, length(List2)),
    AttributeNo2 = lists:nth(No2, List2),
    List3 = List2 -- [AttributeNo2],
    No3 = util:rand(1, length(List3)),
    AttributeNo3 = lists:nth(No3, List3),
    {AttributeNo1, AttributeNo2, AttributeNo3}.

get_on_mount_att(ResetType, Times, MaxAttrLen) ->
    case ResetType of
        0 ->
            F = fun(_X, Acc0) ->
                %得到属性编号 
                {AttributeNo1, AttributeNo2, AttributeNo3} = get_rand_3(MaxAttrLen),        
                %得到属性增益比率
                AttributeAdd1 = util:rand(?MOUNT_ADD_RANCE_MIN, ?MOUNT_ADD_RANCE_MAX),
                %得到属性增益比率
                AttributeAdd2 = util:rand(?MOUNT_ADD_RANCE_MIN, ?MOUNT_ADD_RANCE_MAX),
                %%得到属性减益比率
                AttributeSub = util:rand(?MOUNT_SUB_RANCE_MIN, ?MOUNT_SUB_RANCE_MAX),
                [{AttributeNo1, AttributeNo2, AttributeNo3, AttributeAdd1, AttributeAdd2, AttributeSub}|Acc0]
            end,
            lists:foldl(F, [], lists:seq(1, Times));
        1 ->
           F = fun(_X, Acc0) ->
                %得到属性编号 
                {AttributeNo1, AttributeNo2, AttributeNo3} = get_rand_3(MaxAttrLen), 
                %得到属性增益比率
                AttributeAdd1 = util:rand(?MOUNT_ADD_RANCE_MIN_HIGHT, ?MOUNT_ADD_RANCE_MAX_HIGHT),
                %得到属性增益比率
                AttributeAdd2 = util:rand(?MOUNT_ADD_RANCE_MIN_HIGHT, ?MOUNT_ADD_RANCE_MAX_HIGHT),
                %%得到属性减益比率
                AttributeSub = util:rand(?MOUNT_SUB_RANCE_MIN, ?MOUNT_SUB_RANCE_MAX),
                [{AttributeNo1, AttributeNo2, AttributeNo3, AttributeAdd1, AttributeAdd2, AttributeSub}|Acc0]
            end,
            lists:foldl(F, [], lists:seq(1, Times))
    end.

get_on_diy_mount_att(ResetType, Times, MaxAttrLen, Type) ->
    DiyMountConfig = data_diy_mount_config:get(Type),
    case ResetType of
        0 ->
            F = fun(_X, Acc0) ->
                %得到属性编号
                {AttributeNo1, AttributeNo2, AttributeNo3} = get_rand_3(MaxAttrLen),
                %得到属性增益比率
                AttributeAdd1 = util:rand(DiyMountConfig#diy_mount_config.gamemoney_reset_attr_min1, DiyMountConfig#diy_mount_config.gamemoney_reset_attr_max1),
                %得到属性增益比率
                AttributeAdd2 = util:rand(DiyMountConfig#diy_mount_config.gamemoney_reset_attr_min2, DiyMountConfig#diy_mount_config.gamemoney_reset_attr_max2),
                %%得到属性减益比率
                AttributeSub = util:rand(DiyMountConfig#diy_mount_config.gamemoney_reset_attr_min3, DiyMountConfig#diy_mount_config.gamemoney_reset_attr_max3),
                [{AttributeNo1, AttributeNo2, AttributeNo3, AttributeAdd1, AttributeAdd2, AttributeSub}|Acc0]
                end,
            lists:foldl(F, [], lists:seq(1, Times));
        1 ->
            F = fun(_X, Acc0) ->
                %得到属性编号
                {AttributeNo1, AttributeNo2, AttributeNo3} = get_rand_3(MaxAttrLen),
                %得到属性增益比率
                AttributeAdd1 = util:rand(DiyMountConfig#diy_mount_config.shuiyu_reset_attr_min1, DiyMountConfig#diy_mount_config.shuiyu_reset_attr_max1),
                %得到属性增益比率
                AttributeAdd2 = util:rand(DiyMountConfig#diy_mount_config.shuiyu_reset_attr_min2, DiyMountConfig#diy_mount_config.shuiyu_reset_attr_max2),
                %%得到属性减益比率
                AttributeSub = util:rand(DiyMountConfig#diy_mount_config.shuiyu_reset_attr_min3, DiyMountConfig#diy_mount_config.shuiyu_reset_attr_max3),
                [{AttributeNo1, AttributeNo2, AttributeNo3, AttributeAdd1, AttributeAdd2, AttributeSub}|Acc0]
                end,
            lists:foldl(F, [], lists:seq(1, Times))
    end.

%%重修替换
set_attr_mount(PS, MountId, AttributeNo1, AttributeNo2, AttributeNo3, AttributeAddRatio1, AttributeAddRatio2, AttributeSubRatio) ->
    %得到之前刷新出来的属性
    Mount = lib_mount:get_mount(MountId),
    AttriList = util:bitstring_to_term(Mount#ets_mount.attributeList),
    case is_list(AttriList) andalso AttriList =/= [] of 
        true ->
            F = fun({No1, No2, No3, AddRatio1,AddRatio2, SubRatio}) ->
                    if No1 == AttributeNo1 andalso No2 == AttributeNo2 andalso No3 == AttributeNo3 andalso AddRatio1 == AttributeAddRatio1 
                        andalso AddRatio2 == AttributeAddRatio2 andalso SubRatio == AttributeSubRatio ->
                         true;
                    true -> false
                    end
            end,
            %查找是否在之前刷新出来的属性中一条
            Res = lists:any(F, AttriList),
            case Res of
                false ->
                    {false, ?PM_MOUNT_SET_ATTR_ERR};
                true ->
                    Mount = lib_mount:get_mount(MountId),
                    %设置属性
                    NewMount = Mount#ets_mount{attribute_1 = AttributeNo1, attribute_2 = AttributeNo2, attribute_3 = AttributeNo3,
                                                attribute_add1 = AttributeAddRatio1, attribute_add2 = AttributeAddRatio2, attribute_sub = AttributeSubRatio,
                                                attributeList = <<"[]">>},
                    update_mount(NewMount),
                    db:update(NewMount#ets_mount.id, mount, [{attribute_1, AttributeNo1},{attribute_2, AttributeNo2},{attribute_3, AttributeNo3}, {attribute_add1, AttributeAddRatio1}, {attribute_add2, AttributeAddRatio2}, {attribute_sub, AttributeSubRatio},{attributeList, <<"[]">>}],[{id, NewMount#ets_mount.id}]),
                    %%通知关联的宠物，属性值的变化
                    case Mount#ets_mount.partner1 =/= 0 of
                        true ->
                            Par1 = lib_partner:get_partner(Mount#ets_mount.partner1),
                            mod_partner:update_partner_to_ets(Par1),
                            lib_partner:on_attr_change(PS, Mount#ets_mount.partner1);
                        false ->
                            skip
                    end,
                    case Mount#ets_mount.partner2 =/= 0 of
                        true ->
                            Par2 = lib_partner:get_partner(Mount#ets_mount.partner2),
                            mod_partner:update_partner_to_ets(Par2),
                            lib_partner:on_attr_change(PS, Mount#ets_mount.partner2);
                        false ->
                            skip
                    end,
                    case Mount#ets_mount.partner3 =/= 0 of
                        true ->
                            Par3 = lib_partner:get_partner(Mount#ets_mount.partner3),
                            mod_partner:update_partner_to_ets(Par3),
                            lib_partner:on_attr_change(PS, Mount#ets_mount.partner3);
                        false ->
                            skip
                    end,
                    case Mount#ets_mount.partner4 =/= 0 of
                        true ->
                            Par4 = lib_partner:get_partner(Mount#ets_mount.partner4),
                            mod_partner:update_partner_to_ets(Par4),
                            lib_partner:on_attr_change(PS, Mount#ets_mount.partner4);
                        false ->
                            skip
                    end,
                    case Mount#ets_mount.partner5 =/= 0 of
                        true ->
                            Par5 = lib_partner:get_partner(Mount#ets_mount.partner5),
                            mod_partner:update_partner_to_ets(Par5),
                            lib_partner:on_attr_change(PS, Mount#ets_mount.partner5);
                        false ->
                            skip
                    end,
                    %重新计算战斗力
                    BattlePower = calc_mount_battle_pow(NewMount),
                    {ok, BattlePower}
            end;
        false -> {false, ?PM_MOUNT_SET_ATTR_ERR} 
    end.

%付费传承 将右边的经验等级转移到左边 并将右边的喂养次数也同步
toll_inheritance_mount(PS,LeftMountId,RightMountId) ->
    %%获取左边的坐骑对象
    LeftMount = lib_mount:get_mount(LeftMountId),
    %%获取右边的坐骑对象
    RightMount = lib_mount:get_mount(RightMountId),

    if
        not is_record(LeftMount,ets_mount) orelse not is_record(RightMount,ets_mount) ->
            {false,?PM_UNKNOWN_ERR};
        true ->
            %%级别
            LeftLevel = LeftMount#ets_mount.level,
            RightLevel = RightMount#ets_mount.level,

            %%经验
            %LeftExp = LeftMount#ets_mount.exp,
            RightExp = RightMount#ets_mount.exp,

            %%剩余喂养次数
            RightFeedTimes = case util:is_timestamp_same_day(RightMount#ets_mount.feed_timestamp, util:unixtime()) of
                true -> RightMount#ets_mount.feed;
                false -> ?MAX_FEED_TIMES
            end, 

            MoneyHas = player:has_enough_yuanbao(PS, ?INHERITANCE_NEED_COUNT),

            if 
                LeftLevel > RightLevel ->
                    {false,?PM_MOUNT_LEFT_LV_MORE_RIGHT};
                LeftLevel >= ?MAX_INHERITANCE_LV ->
                    {false,?PM_MOUNT_LEFT_LV_TOO};
                RightLevel < ?MAX_INHERITANCE_LV -> 
                    {false,?PM_MOUNT_RIGHT_LV_NOT};
                not MoneyHas  ->
                    {false,?PM_YB_LIMIT};
                RightMount#ets_mount.partner1 =/= 0 orelse RightMount#ets_mount.partner2 =/= 0 orelse RightMount#ets_mount.partner3 =/= 0 orelse RightMount#ets_mount.partner4 =/= 0 orelse RightMount#ets_mount.partner5 =/= 0 ->
                    {false,?PM_MOUNT_WORKING};
                true ->     
                    CurTime = util:unixtime(),
                    %%继承的只有经验、等级、培养次数、培养时间
                    NewLeftMount = LeftMount#ets_mount{level = RightLevel, exp = RightExp, feed = RightFeedTimes, feed_timestamp = CurTime},
                    update_mount(NewLeftMount),

                    NewRightMount = RightMount#ets_mount{level = 1, exp = 0, feed = RightFeedTimes, feed_timestamp = CurTime, skill = <<"[0,0,0,0]">>},
                    update_mount(NewRightMount),

                    db:update(NewLeftMount#ets_mount.id, mount, [{level, RightLevel}, {exp, RightExp},{feed, RightFeedTimes}, {feed_timestamp, CurTime}], [{id, NewLeftMount#ets_mount.id}]),
                    db:update(NewRightMount#ets_mount.id, mount, [{level, 1}, {exp, 0},{feed, RightFeedTimes}, {feed_timestamp, CurTime},{skill, "[0,0,0,0]"}], [{id, NewRightMount#ets_mount.id}]),
                    
                    %%数据库修改被传承的坐骑的玩家ID为不存在
                    %db:update(RightMount#ets_mount.id, mount, [{player_id, 0}],[{id, RightMount#ets_mount.id}]),
                    %%ETS删除右边的坐骑
                    %delete_mount(RightMountId),

                    %%关联宠物
                    case NewLeftMount#ets_mount.partner1 =/= 0 of
                        true ->
                            Par1 = lib_partner:get_partner(NewLeftMount#ets_mount.partner1),
                            mod_partner:update_partner_to_ets(Par1),
                            lib_partner:on_attr_change(PS, NewLeftMount#ets_mount.partner1);
                        false ->
                            skip
                    end,

                    case NewLeftMount#ets_mount.partner2 =/= 0 of
                        true ->
                            Par2 = lib_partner:get_partner(NewLeftMount#ets_mount.partner2),
                            mod_partner:update_partner_to_ets(Par2),
                            lib_partner:on_attr_change(PS, NewLeftMount#ets_mount.partner2);
                        false ->
                            skip
                    end,

                    case NewLeftMount#ets_mount.partner3 =/= 0 of
                        true ->
                            Par3 = lib_partner:get_partner(NewLeftMount#ets_mount.partner3),
                            mod_partner:update_partner_to_ets(Par3),
                            lib_partner:on_attr_change(PS, NewLeftMount#ets_mount.partner3);
                        false ->
                            skip
                    end,

                    case NewLeftMount#ets_mount.partner4 =/= 0 of
                        true ->
                            Par4 = lib_partner:get_partner(NewLeftMount#ets_mount.partner4),
                            mod_partner:update_partner_to_ets(Par4),
                            lib_partner:on_attr_change(PS, NewLeftMount#ets_mount.partner4);
                        false ->
                            skip
                    end,

                    case NewLeftMount#ets_mount.partner5 =/= 0 of
                        true ->
                            Par5 = lib_partner:get_partner(NewLeftMount#ets_mount.partner5),
                            mod_partner:update_partner_to_ets(Par5),
                            lib_partner:on_attr_change(PS, NewLeftMount#ets_mount.partner5);
                        false ->
                            skip
                    end,

                    %%通知排行榜变化
                    % mod_rank:mount_clv(NewLeftMount),
                    % mod_rank:mount_clv(NewRightMount),

                    %%新的战斗力
                    LeftBattlePower = calc_mount_battle_pow(NewLeftMount),
                    RightBattlePower = calc_mount_battle_pow(NewRightMount),

                    {ok, {1,LeftMountId,RightFeedTimes, RightLevel, RightExp, LeftBattlePower,
                            RightMountId,RightFeedTimes,1,0,RightBattlePower}}
            end

    end.

%免费传承 将右边的经验等级转移到左边 并将右边的喂养次数也同步
inheritance_mount(PS,LeftMountId,RightMountId) ->
    %%获取左边的坐骑对象
    LeftMount = lib_mount:get_mount(LeftMountId),
    %%获取右边的坐骑对象
    RightMount = lib_mount:get_mount(RightMountId),

    if
        not is_record(LeftMount,ets_mount) orelse not is_record(RightMount,ets_mount) ->
            {false,?PM_UNKNOWN_ERR};
        true ->
            %%级别
            LeftLevel = LeftMount#ets_mount.level,
            RightLevel = RightMount#ets_mount.level,

            %%经验
            %LeftExp = LeftMount#ets_mount.exp,
            RightExp = RightMount#ets_mount.exp,

            %%剩余喂养次数
            RightFeedTimes = case util:is_timestamp_same_day(RightMount#ets_mount.feed_timestamp, util:unixtime()) of
                true -> RightMount#ets_mount.feed;
                false -> ?MAX_FEED_TIMES
            end, 

            if 
                LeftLevel > RightLevel ->
                    {false,?PM_MOUNT_LEFT_LV_MORE_RIGHT};
                LeftLevel >= ?MAX_INHERITANCE_LV ->
                    {false,?PM_MOUNT_LEFT_LV_TOO};
                RightLevel < ?MAX_INHERITANCE_LV -> 
                    {false,?PM_MOUNT_RIGHT_LV_NOT};
                RightMount#ets_mount.partner1 =/= 0 orelse RightMount#ets_mount.partner2 =/= 0 orelse RightMount#ets_mount.partner3 =/= 0 orelse RightMount#ets_mount.partner4 =/= 0 orelse RightMount#ets_mount.partner5 =/= 0 ->
                    {false,?PM_MOUNT_WORKING};
                true ->     
                    CurTime = util:unixtime(),
                    %%继承的只有经验、等级、培养次数、培养时间
                    NewLeftMount = LeftMount#ets_mount{level = RightLevel, exp = RightExp, feed = RightFeedTimes, feed_timestamp = CurTime},
                    update_mount(NewLeftMount),
                    db:update(NewLeftMount#ets_mount.id, mount, [{level, RightLevel}, {exp, RightExp},{feed, RightFeedTimes}, {feed_timestamp, CurTime}], [{id, NewLeftMount#ets_mount.id}]),
                    
                    NewRightMount = RightMount#ets_mount{level = 1, exp = 0, feed = RightFeedTimes, feed_timestamp = CurTime, skill = <<"[0,0,0,0]">>},
                    update_mount(NewRightMount),
                    %%数据库修改被传承的坐骑的玩家ID为不存在
                    db:update(NewRightMount#ets_mount.id, mount, [{player_id, 0},{level, 1}, {exp, 0},{feed, RightFeedTimes}, {feed_timestamp, CurTime},{skill, "[0,0,0,0]"}], [{id, NewRightMount#ets_mount.id}]),

                    %%关联宠物
                    case NewLeftMount#ets_mount.partner1 =/= 0 of
                        true ->
                            Par1 = lib_partner:get_partner(NewLeftMount#ets_mount.partner1),
                            mod_partner:update_partner_to_ets(Par1),
                            lib_partner:on_attr_change(PS, NewLeftMount#ets_mount.partner1);
                        false ->
                            skip
                    end,

                    case NewLeftMount#ets_mount.partner2 =/= 0 of
                        true ->
                            Par2 = lib_partner:get_partner(NewLeftMount#ets_mount.partner2),
                            mod_partner:update_partner_to_ets(Par2),
                            lib_partner:on_attr_change(PS, NewLeftMount#ets_mount.partner2);
                        false ->
                            skip
                    end,

                    case NewLeftMount#ets_mount.partner3 =/= 0 of
                        true ->
                            Par3 = lib_partner:get_partner(NewLeftMount#ets_mount.partner3),
                            mod_partner:update_partner_to_ets(Par3),
                            lib_partner:on_attr_change(PS, NewLeftMount#ets_mount.partner3);
                        false ->
                            skip
                    end,

                    case NewLeftMount#ets_mount.partner4 =/= 0 of
                        true ->
                            Par4 = lib_partner:get_partner(NewLeftMount#ets_mount.partner4),
                            mod_partner:update_partner_to_ets(Par4),
                            lib_partner:on_attr_change(PS, NewLeftMount#ets_mount.partner4);
                        false ->
                            skip
                    end,

                    case NewLeftMount#ets_mount.partner5 =/= 0 of
                        true ->
                            Par5 = lib_partner:get_partner(NewLeftMount#ets_mount.partner5),
                            mod_partner:update_partner_to_ets(Par5),
                            lib_partner:on_attr_change(PS, NewLeftMount#ets_mount.partner5);
                        false ->
                            skip
                    end,

                    %%通知排行榜变化
                    % mod_rank:mount_clv(NewLeftMount),
                    % mod_rank:mount_clv(NewRightMount),

                    %%新的战斗力
                    LeftBattlePower = calc_mount_battle_pow(NewLeftMount),
                    RightBattlePower = calc_mount_battle_pow(NewRightMount),

                    %%ETS删除右边的坐骑
                    delete_mount(NewRightMount#ets_mount.id),

                    {ok, {2,LeftMountId,RightFeedTimes, RightLevel, RightExp, LeftBattlePower,
                            RightMountId,RightFeedTimes,1,0,RightBattlePower}}
            end

    end.    
    

%%喂养坐骑
feed_mount(PS, MountId, FeedGoodsNo, FeedCount) ->
    case lists:keyfind(FeedGoodsNo, 1, data_special_config:get('mount_level_exp')) of
        {_, GoodsExp} ->
            Mount = lib_mount:get_mount(MountId),
            %判断是否大于最大等级
            Level = Mount#ets_mount.level,
            Exp = Mount#ets_mount.exp,
            AddExp = GoodsExp * FeedCount,

            case Level >= ?MOUNT_MAX_LV of
                true -> {false, ?PM_MOUNT_OVER_MAX_LV};
                false ->
                    %得到最新的等级和剩下经成长值
                    F = fun(X, {CurLv, CurExp}) ->
                        %% 计算升级时判断等级是否已达到最大
                        case X >= CurLv andalso CurExp >= data_mount_lv:get_exp_lim(X) andalso CurLv < ?MOUNT_MAX_LV  of
                            true -> {CurLv + 1, CurExp - data_mount_lv:get_exp_lim(X)};
                            false -> {CurLv, CurExp}
                        end
                        end,
                    {NewLevel0, NewExp0} = lists:foldl(F, {Level, Exp+AddExp}, lists:seq(1, ?MOUNT_MAX_LV)),
                    NewLevel = erlang:min(NewLevel0, ?MOUNT_MAX_LV),
                    NewExp = erlang:min(NewExp0, data_mount_lv:get_exp_lim(NewLevel)),
                    NewMount = Mount#ets_mount{level = NewLevel, exp = NewExp},

                    MountList = get_all_mount(player:get_id(PS)),
                    F1 = fun(MountInfo) ->
                            Id = MountInfo#ets_mount.id,
                            NewMountInfo = MountInfo#ets_mount{level = NewLevel, exp = NewExp},
                            update_mount(NewMountInfo),
                            db:update(Id, mount, [{level, NewLevel}, {exp, NewExp}], [{id, Id}])
                        end,
                    lists:foreach(F1, MountList),

                    %重新计算战斗力
                    BattlePower = case Level == NewLevel of
                                      true -> NewMount#ets_mount.battle_power;
                                      false ->
                                        mod_achievement:notify_achi(feed_mount, [{num, NewLevel}], PS),
                                          %%通知关联的宠物，属性值的变化
                                          case Mount#ets_mount.partner1 =/= 0 of
                                              true ->
                                                  Par1 = lib_partner:get_partner(Mount#ets_mount.partner1),
                                                  mod_partner:update_partner_to_ets(Par1),
                                                  lib_partner:on_attr_change(PS, Mount#ets_mount.partner1);
                                              false ->
                                                  skip
                                          end,
                                          case Mount#ets_mount.partner2 =/= 0 of
                                              true ->
                                                  Par2 = lib_partner:get_partner(Mount#ets_mount.partner2),
                                                  mod_partner:update_partner_to_ets(Par2),
                                                  lib_partner:on_attr_change(PS, Mount#ets_mount.partner2);
                                              false ->
                                                  skip
                                          end,
                                          case Mount#ets_mount.partner3 =/= 0 of
                                              true ->
                                                  Par3 = lib_partner:get_partner(Mount#ets_mount.partner3),
                                                  mod_partner:update_partner_to_ets(Par3),
                                                  lib_partner:on_attr_change(PS, Mount#ets_mount.partner3);
                                              false ->
                                                  skip
                                          end,
                                          case Mount#ets_mount.partner4 =/= 0 of
                                              true ->
                                                  Par4 = lib_partner:get_partner(Mount#ets_mount.partner4),
                                                  mod_partner:update_partner_to_ets(Par4),
                                                  lib_partner:on_attr_change(PS, Mount#ets_mount.partner4);
                                              false ->
                                                  skip
                                          end,
                                          case Mount#ets_mount.partner5 =/= 0 of
                                              true ->
                                                  Par5 = lib_partner:get_partner(Mount#ets_mount.partner5),
                                                  mod_partner:update_partner_to_ets(Par5),
                                                  lib_partner:on_attr_change(PS, Mount#ets_mount.partner5);
                                              false ->
                                                  skip
                                          end,

                                          case player:get_mount(PS) == NewMount#ets_mount.id of
                                              true ->
                                                  mod_rank:mount_clv(NewMount),
                                                  mod_rank:mount_battle_power(NewMount),
                                                  true;
                                              false -> skip
                                          end,

                                          % mod_rank:mount_clv(NewMount),
                                          calc_mount_battle_pow(NewMount)
                                  end,
                    {ok, {NewLevel, NewExp, BattlePower}}
            end;
        false ->
            {false, ?PM_MOUNT_SYS_ERR}
    end.
          
%%坐骑进化--------------------------
stren_mount(PS, MountId, GoodsNo, Num) ->
    Mount = lib_mount:get_mount(MountId),
    if Mount == null -> {false, ?PM_MOUNT_SYS_ERR};
       true ->
            Step = Mount#ets_mount.step,
            case Step >= ?MAX_STEP of
                true -> {false, ?PM_MOUNT_OVER_MAX_STEP_LV};
                false ->
                    MountNo = Mount#ets_mount.no,
                    {StepNeed, StepNeedGoods} = case data_mount:get_mount_info(MountNo) of
                                    MountInfo when is_record(MountInfo, mount_info) ->
                                        {MountInfo#mount_info.step_need, MountInfo#mount_info.step_need_goods};
                                    _ -> {null,null}
                                end,
                    case StepNeed of
                        null -> {false, ?PM_MOUNT_DATA_SYS_ERR};
                        _ ->
                            case StepNeedGoods of
                                null -> {false, ?PM_MOUNT_DATA_SYS_ERR};
                                _ -> 
                                    case lists:member(GoodsNo, StepNeedGoods) of
                                        false -> {false, ?PM_MOUNT_DATA_SYS_ERR};
                                        true ->
                                            StepValue = Mount#ets_mount.step_value,

                                            AddStepValue = case lists:keyfind(GoodsNo, 1, data_special_config:get('mount_step_exp')) of
                                                                {_, Vaule} -> Vaule * Num;
                                                                false -> ?ASSERT(false), Num
                                                            end,
                                            F = fun(X, {Step1, StepValue1}) ->
                                                case X >= Step1 andalso StepValue1 >= lists:nth(X, StepNeed) of
                                                    true -> {Step1 + 1, StepValue1 - lists:nth(X, StepNeed)};
                                                    false -> {Step1, StepValue1}
                                                end
                                            end,
                                            {NewStep, NewStepValue} = lists:foldl(F, {Step, StepValue+AddStepValue}, lists:seq(1, ?MAX_STEP-1)),
                                            io:format("Step==~p,StepValue==~p,AddStepValue==~p,NewStep==~p,NewStepValue==~p~n",
                                                [Step,StepValue,AddStepValue,NewStep,NewStepValue]),
                                            {CostNum, NewStepValue1} = case NewStep =:= ?MAX_STEP of
                                                                           true ->
                                                                                AddValue = AddStepValue div Num,
                                                                                AddNum = NewStepValue div AddValue,
                                                                                {Num - AddNum, NewStepValue - AddValue * AddNum};
                                                                           false ->
                                                                                {Num, NewStepValue}
                                                                       end,
                                            NewMount = Mount#ets_mount{step = NewStep, step_value = NewStepValue1},
                                            update_mount(NewMount),

                                            case player:get_mount(PS) == NewMount#ets_mount.id of
                                                true ->
                                                    mod_rank:mount_clv(NewMount),
                                                    mod_rank:mount_battle_power(NewMount),
                                                    true;
                                                false -> skip
                                            end,

                                            db:update(NewMount#ets_mount.id, mount, [{step, NewStep},{step_value, NewStepValue1}], [{id, NewMount#ets_mount.id}]),
                                            BattlePower = case Step == NewStep of
                                                true -> NewMount#ets_mount.battle_power;
                                                false ->
                                                    %%通知关联的宠物，属性值的变化
                                                    case Mount#ets_mount.partner1 =/= 0 of
                                                        true ->
                                                            Par1 = lib_partner:get_partner(Mount#ets_mount.partner1),
                                                            mod_partner:update_partner_to_ets(Par1),
                                                            lib_partner:on_attr_change(PS, Mount#ets_mount.partner1);
                                                        false ->
                                                            skip
                                                    end,
                                                    case Mount#ets_mount.partner2 =/= 0 of
                                                        true ->
                                                            Par2 = lib_partner:get_partner(Mount#ets_mount.partner2),
                                                            mod_partner:update_partner_to_ets(Par2),
                                                            lib_partner:on_attr_change(PS, Mount#ets_mount.partner2);
														false ->
															skip
													end,
                                                    case Mount#ets_mount.partner3 =/= 0 of
                                                        true ->
                                                            Par3 = lib_partner:get_partner(Mount#ets_mount.partner3),
                                                            mod_partner:update_partner_to_ets(Par3),
                                                            lib_partner:on_attr_change(PS, Mount#ets_mount.partner3);
                                                        false ->
                                                            skip
                                                    end,
                                                    case Mount#ets_mount.partner4 =/= 0 of
                                                        true ->
                                                            Par4 = lib_partner:get_partner(Mount#ets_mount.partner4),
                                                            mod_partner:update_partner_to_ets(Par4),
                                                            lib_partner:on_attr_change(PS, Mount#ets_mount.partner4);
                                                        false ->
                                                            skip
                                                    end,
                                                    case Mount#ets_mount.partner5 =/= 0 of
                                                        true ->
                                                            Par5 = lib_partner:get_partner(Mount#ets_mount.partner5),
                                                            mod_partner:update_partner_to_ets(Par5),
                                                            lib_partner:on_attr_change(PS, Mount#ets_mount.partner5);
                                                        false ->
                                                            skip
                                                    end,
													mod_achievement:notify_achi(mount_step_up, [], PS),
                                                    %全服通知
                                                    ply_tips:send_sys_tips(PS, {mount_stren, [player:get_name(PS),player:get_id(PS), NewStep]}),
                                                    lib_scene:notify_int_info_change_to_aoi(player, player:get_id(PS), [{?OI_CODE_MOUNT_NO, NewMount#ets_mount.no},{?OI_CODE_MOUNT_STEP, NewMount#ets_mount.step}]), 
                                                    calc_mount_battle_pow(NewMount)      
                                            end,
                                            {NewStep, NewStepValue1, CostNum, BattlePower}
                                    end
                            end    
                    end   
            end
    end.

%%打开技能界面--------------------------
open_mount_skill(_PS, MountId, Order) ->
    Mount = lib_mount:get_mount(MountId),
    if Mount == null -> {false, ?PM_MOUNT_SYS_ERR};
        true -> 
            %判断当前觉醒的技能是否大于最大格子数
            case Order > Mount#ets_mount.skillNum of
                true -> {false, ?PM_MOUNT_SKILL_NUM_LIMIT};
                false -> 
                    case data_mount:get_mount_skill(Order) of
                        MountSkill when is_record(MountSkill, mount_skill) ->
                            case MountSkill#mount_skill.limit_lv > Mount#ets_mount.level of
                                true -> {false, ?PM_MOUNT_OPEN_LIMIT_LV};
                                false ->
                                   SkillIds = MountSkill#mount_skill.mount_skill_id,
                                   SkillIdList = [X || {X} <- SkillIds],
                                   {ok, SkillIdList}
                            end;
                        _ ->
                            {false, ?PM_MOUNT_DATA_SYS_ERR}
                    end
            end
    end.

%% 删除技能
del_mount_skill(PS,MountId,Order) ->
    Mount = lib_mount:get_mount(MountId),
    if Mount == null -> {false, ?PM_MOUNT_SYS_ERR};
        true -> 
        case Order > Mount#ets_mount.skillNum of
            true -> {false, ?PM_MOUNT_SKILL_NUM_LIMIT};
            
            false ->
                CurSkill = util:bitstring_to_term(Mount#ets_mount.skill),

                F = fun(X, Acc0) ->
                    case X == Order of
                        true -> [0|Acc0];
                        false -> [case length(CurSkill) >= X of
									  true ->
										  lists:nth(X, CurSkill);
									  false ->
										  0
								  end|Acc0]
                    end
                end,

                NewCurSkill = lists:reverse(lists:foldl(F, [], lists:seq(1, ?MAX_SKILL_NUM))),
                NewMount = Mount#ets_mount{skill = util:term_to_bitstring(NewCurSkill)},
                update_mount(NewMount),

                case player:get_mount(PS) == NewMount#ets_mount.id of
                    true ->
                        mod_rank:mount_clv(NewMount),
                        mod_rank:mount_battle_power(NewMount),
                        true;
                    false -> skip
                end,

                db:update(NewMount#ets_mount.id, mount, [{skill, NewMount#ets_mount.skill}], [{id, NewMount#ets_mount.id}]),
                lib_partner:on_attr_change(PS, NewMount#ets_mount.partner1),
                lib_partner:on_attr_change(PS, NewMount#ets_mount.partner2),
                lib_partner:on_attr_change(PS, NewMount#ets_mount.partner3),
                lib_partner:on_attr_change(PS, NewMount#ets_mount.partner4),
                lib_partner:on_attr_change(PS, NewMount#ets_mount.partner5),
                {ok}
        end
    end.

%%觉醒技能----------------------------
learn_mount_skill(PS, MountId, SkillId, Order) ->
    Mount = lib_mount:get_mount(MountId),
    if Mount == null -> {false, ?PM_MOUNT_SYS_ERR};
        true ->
            %判断当前觉醒的技能是否大于最大格子数
            case Order > Mount#ets_mount.skillNum of
                true -> {false, ?PM_MOUNT_SKILL_NUM_LIMIT};
                false -> 
                    case data_mount:get_mount_skill(Order) of
                        MountSkill when is_record(MountSkill, mount_skill) ->
                            %判断技能所需要的坐骑等级
                            case MountSkill#mount_skill.limit_lv > Mount#ets_mount.level of
                                true -> {false, ?PM_MOUNT_OPEN_LIMIT_LV};
                                false ->
                                    SkillIds = MountSkill#mount_skill.mount_skill_id,
                                    %判断所学技能是否在初学技能表中
                                    case lists:member({SkillId}, SkillIds) of
                                        false -> {false, ?PM_MOUNT_DATA_SYS_ERR};
                                        true ->
                                            CurSkill = util:bitstring_to_term(Mount#ets_mount.skill),
                                            %%判断当前技能id是否在已学习的技能中
                                            CurSkillList = [(X - X rem 10 + 1) || X <- CurSkill],
                                            case lists:member(SkillId, CurSkillList) of
                                                true -> {false, ?PM_MOUNT_ALREADY_LEARN};
                                                false ->

                                                    case (Order =< erlang:length(CurSkill) andalso lists:nth(Order, CurSkill) == 0) orelse Order =< ?MAX_SKILL_NUM of
                                                         true ->
                                                            %判断技能是否在技能配置表中
                                                            case data_skill:get(SkillId) of
                                                                DataSkill when is_record(DataSkill, skl_cfg) ->
                                                                    F = fun(X, Acc0) ->
                                                                            case X == Order of
                                                                                true -> [SkillId|Acc0];
                                                                                false ->
                                                                                    [case length(CurSkill) >= X of
                                                                                        true ->
                                                                                            lists:nth(X, CurSkill);
                                                                                        false ->
                                                                                            0
                                                                                    end|Acc0]
                                                                            end
                                                                        end,
                                                                    NewCurSkill = lists:reverse(lists:foldl(F, [], lists:seq(1, ?MAX_SKILL_NUM))),
                                                                    NewMount = Mount#ets_mount{skill = util:term_to_bitstring(NewCurSkill)},
                                                                    update_mount(NewMount),

                                                                    case player:get_mount(PS) == NewMount#ets_mount.id of
                                                                        true ->
                                                                            mod_rank:mount_clv(NewMount),
                                                                            mod_rank:mount_battle_power(NewMount),
                                                                            true;
                                                                        false -> skip
                                                                    end,

                                                                    db:update(NewMount#ets_mount.id, mount, [{skill, NewMount#ets_mount.skill}], [{id, NewMount#ets_mount.id}]),
                                                                    lib_partner:on_attr_change(PS, NewMount#ets_mount.partner1),
                                                                    lib_partner:on_attr_change(PS, NewMount#ets_mount.partner2),
                                                                    lib_partner:on_attr_change(PS, NewMount#ets_mount.partner3),
                                                                    lib_partner:on_attr_change(PS, NewMount#ets_mount.partner4),
                                                                    lib_partner:on_attr_change(PS, NewMount#ets_mount.partner5),
                                                                    ok;
                                                                _ ->
                                                                    {false, ?PM_MOUNT_DATA_SYS_ERR}
                                                            end;
                                                        false ->
                                                            {false, ?PM_MOUNT_ALREADY_LEARN}
                                                    end
                                            end
                                    end
                            end;
                        _ ->
                            {false, ?PM_MOUNT_DATA_SYS_ERR}
                    end
            end       
    end.

%%升级技能------------------
up_mount_skill(PS, MountId, SkillId, Order) ->
    Mount = lib_mount:get_mount(MountId),
    if Mount == null -> {false, ?PM_MOUNT_SYS_ERR};
        true ->
            %判断当前觉醒的技能是否大于最大格子数
            case Order > Mount#ets_mount.skillNum of
                true -> {false, ?PM_MOUNT_SKILL_NUM_LIMIT};
                false -> 
                    case data_mount:get_mount_skill(Order) of
                        MountSkill when is_record(MountSkill, mount_skill) ->
                            UpSkillLimit = MountSkill#mount_skill.up_skill_limit,
                            MaxSkillLv = MountSkill#mount_skill.max_skill_lv,
                            %得到当前技能等级（余数为等级）
                            CurSkillLv = SkillId rem 10, 
                            case CurSkillLv >= MaxSkillLv of
                                true -> {false, ?PM_MOUNT_OVER_SKILL_LV};
                                false ->
                                    {_,LimitLv, {GoodsNo, NeedNum}} = lists:nth(CurSkillLv, UpSkillLimit),
                                    if LimitLv > Mount#ets_mount.level -> {false, ?PM_MOUNT_OPEN_LIMIT_LV};
                                        true ->
                                            case mod_inv:check_batch_destroy_goods(PS, [{GoodsNo, NeedNum}])  of
                                                ok ->
                                                    NewSkillId = SkillId + 1,
                                                    CurSkill = util:bitstring_to_term(Mount#ets_mount.skill),
                                                    case data_skill:get(NewSkillId) of
                                                        DataSkill when is_record(DataSkill, skl_cfg) ->
                                                            F = fun(X, Acc0) ->
                                                                    case X == Order of
                                                                        true -> [NewSkillId|Acc0];
																		false -> [case length(CurSkill) >= X of
																					  true ->
																						  lists:nth(X, CurSkill);
																					  false ->
																						  0
																				  end|Acc0]
                                                                    end
                                                                end,
                                                            NewCurSkill = lists:reverse(lists:foldl(F, [], lists:seq(1, ?MAX_SKILL_NUM))),
                                                            NewMount = Mount#ets_mount{skill = util:term_to_bitstring(NewCurSkill)},
                                                            update_mount(NewMount),

                                                            case player:get_mount(PS) == NewMount#ets_mount.id of
                                                                true ->
                                                                    mod_rank:mount_clv(NewMount),
                                                                    mod_rank:mount_battle_power(NewMount),
                                                                    true;
                                                                false -> skip
                                                            end,

                                                            db:update(NewMount#ets_mount.id, mount, [{skill, NewMount#ets_mount.skill}], [{id, NewMount#ets_mount.id}]),

                                                            lib_partner:on_attr_change(PS, NewMount#ets_mount.partner1),
                                                            lib_partner:on_attr_change(PS, NewMount#ets_mount.partner2),
                                                            lib_partner:on_attr_change(PS, NewMount#ets_mount.partner3),
                                                            lib_partner:on_attr_change(PS, NewMount#ets_mount.partner4),
                                                            lib_partner:on_attr_change(PS, NewMount#ets_mount.partner5),

                                                            %全服通知
                                                            NewSkillLv = CurSkillLv + 1,
                                                            case NewSkillLv >= 3 of
                                                                false -> skip;
                                                                true ->
                                                                    ply_tips:send_sys_tips(PS, {mount_skill, [player:get_name(PS), player:get_id(PS), SkillId, NewSkillId]})
                                                            end,
                                                            {ok, GoodsNo, NeedNum, NewSkillId};
                                                        _ -> {false, ?PM_MOUNT_DATA_SYS_ERR}
                                                    end;
                                                {fail, Reason} ->
                                                    {false, Reason}
                                            end
                                    end
                            end;
                        _ -> {false, ?PM_MOUNT_DATA_SYS_ERR}
                    end
            end
    end.

%%关联宠物-----------------
connect_partner(PS, MountId, PartnerId, _IsConnect) ->
    Mount = lib_mount:get_mount(MountId),
    if Mount == null -> {false, ?PM_MOUNT_SYS_ERR};
        true ->
            PartnerNum = Mount#ets_mount.partner_num,
            PartnerMaxNum = case Mount#ets_mount.custom_type =:= 0 of
                                true -> ?MAX_CONNECT_PARTNERS;
                                false -> Mount#ets_mount.partner_maxnum
                            end,
            case PartnerNum >= PartnerMaxNum of
                true -> {false, ?PM_MOUNT_MAX_CONNECT_PARTNER};
                false -> 
                    PartnerIdList = player:get_partner_id_list(PS),
                    ?ylh_Debug("PartnerId=~p, PartnerIdList=~p~n", [PartnerId, PartnerIdList]),
                    case lists:member(PartnerId, PartnerIdList) of
                        false -> {false, ?PM_MOUNT_DATA_SYS_ERR};
                        true ->
                            %判断宠物已经关联了坐骑（下周再写）
                            case lib_partner:get_mount_id(lib_partner:get_partner(PartnerId)) == 0 of 
                                false ->
                                        %线上出现某个宠物不能关联任何坐骑的问题
                                        MountIdList = player:get_mount_id_list(PS),
                                        ConnectMountId = lib_partner:get_mount_id(lib_partner:get_partner(PartnerId)),
                                        case lists:member(ConnectMountId, MountIdList) of
                                            true ->
                                                {false, ?PM_MOUNT_CONNET_PRTNER_ALREADY};
                                            false ->
                                                NewMount = 
                                                    if Mount#ets_mount.partner1 == 0 -> Mount#ets_mount{partner1 = PartnerId, partner_num = PartnerNum + 1};
                                                       Mount#ets_mount.partner2 == 0 -> Mount#ets_mount{partner2 = PartnerId, partner_num = PartnerNum + 1};
                                                       Mount#ets_mount.partner3 == 0 -> Mount#ets_mount{partner3 = PartnerId, partner_num = PartnerNum + 1};
                                                       Mount#ets_mount.partner4 == 0 -> Mount#ets_mount{partner4 = PartnerId, partner_num = PartnerNum + 1};
                                                       Mount#ets_mount.partner5 == 0 -> Mount#ets_mount{partner5 = PartnerId, partner_num = PartnerNum + 1};
                                                       true -> ?ASSERT(false), Mount
                                                    end,
                                                update_mount(NewMount),
                                                db:update(NewMount#ets_mount.id, mount, [{partner_num, NewMount#ets_mount.partner_num},{partner1, NewMount#ets_mount.partner1}, {partner2, NewMount#ets_mount.partner2},
                                                    {partner3, NewMount#ets_mount.partner3}, {partner4, NewMount#ets_mount.partner4}, {partner5, NewMount#ets_mount.partner5}], [{id, NewMount#ets_mount.id}]),
                                                %通知设置宠物已关联坐骑
                                                ParNew = lib_partner:set_mount_id(PartnerId, MountId),
                                                mod_partner:update_partner_to_ets(ParNew),
                                                lib_partner:on_attr_change(PS, PartnerId),
                                                ok 
                                         end; 
                                true ->
                                    NewMount = 
                                        if Mount#ets_mount.partner1 == 0 -> Mount#ets_mount{partner1 = PartnerId, partner_num = PartnerNum + 1};
                                           Mount#ets_mount.partner2 == 0 -> Mount#ets_mount{partner2 = PartnerId, partner_num = PartnerNum + 1};
                                           Mount#ets_mount.partner3 == 0 -> Mount#ets_mount{partner3 = PartnerId, partner_num = PartnerNum + 1};
                                           Mount#ets_mount.partner4 == 0 -> Mount#ets_mount{partner4 = PartnerId, partner_num = PartnerNum + 1};
                                           Mount#ets_mount.partner5 == 0 -> Mount#ets_mount{partner5 = PartnerId, partner_num = PartnerNum + 1};
                                           true -> ?ASSERT(false), Mount
                                        end,
                                    update_mount(NewMount),
                                    db:update(NewMount#ets_mount.id, mount, [{partner_num, NewMount#ets_mount.partner_num},{partner1, NewMount#ets_mount.partner1}, {partner2, NewMount#ets_mount.partner2},
                                        {partner3, NewMount#ets_mount.partner3}, {partner4, NewMount#ets_mount.partner4}, {partner5, NewMount#ets_mount.partner5}], [{id, NewMount#ets_mount.id}]),
                                    %通知设置宠物已关联坐骑
                                    ParNew = lib_partner:set_mount_id(PartnerId, MountId),
                                    mod_partner:update_partner_to_ets(ParNew),
                                    lib_partner:on_attr_change(PS, PartnerId),
                                    ok  
                                end           
                    end
            end
    end.

%%取消关联宠物-----------------
concel_connect_partner(PS, MountId, PartnerId, _IsConnect) ->
    Mount = lib_mount:get_mount(MountId),
    if Mount == null -> {false, ?PM_MOUNT_SYS_ERR};
        true ->
            %得到宠物关联的坐骑id(下周再实现这个功能)
            % OldMountId = lib_partner:get_mount_id(lib_partner:get_partner(PartnerId)),
            % case OldMountId == MountId of
            %     false -> {false, ?PM_MOUNT_SYS_ERR};
            %     true ->
            NewMount = 
                if Mount#ets_mount.partner1 == PartnerId -> Mount#ets_mount{partner1 = 0, partner_num = max(0, Mount#ets_mount.partner_num - 1)};
                   Mount#ets_mount.partner2 == PartnerId -> Mount#ets_mount{partner2 = 0, partner_num = max(0, Mount#ets_mount.partner_num - 1)};
                   Mount#ets_mount.partner3 == PartnerId -> Mount#ets_mount{partner3 = 0, partner_num = max(0, Mount#ets_mount.partner_num - 1)};
                   Mount#ets_mount.partner4 == PartnerId -> Mount#ets_mount{partner4 = 0, partner_num = max(0, Mount#ets_mount.partner_num - 1)};
                   Mount#ets_mount.partner5 == PartnerId -> Mount#ets_mount{partner5 = 0, partner_num = max(0, Mount#ets_mount.partner_num - 1)};
                   true -> ?ASSERT(false), Mount
               end,
            update_mount(NewMount),
            db:update(NewMount#ets_mount.id, mount, [{partner_num, NewMount#ets_mount.partner_num},{partner1, NewMount#ets_mount.partner1}, {partner2, NewMount#ets_mount.partner2},
                {partner3, NewMount#ets_mount.partner3}, {partner4, NewMount#ets_mount.partner4}, {partner5, NewMount#ets_mount.partner5}], [{id, NewMount#ets_mount.id}]),
            %通知宠物已取消关联坐骑
            ParNew = lib_partner:set_mount_id(PartnerId, 0),
            mod_partner:update_partner_to_ets(ParNew),
            lib_partner:on_attr_change(PS, PartnerId),
            ok
            % end
    end.


calc_mount_battle_pow(Attrs) when is_record(Attrs,attrs) ->
    Coef = data_formula:get(mount_cal_battle_power),

    BattlePower = 
    Coef#formula.hp_lim * Attrs#attrs.hp_lim +
    Coef#formula.mp_lim * Attrs#attrs.mp_lim +
    Coef#formula.phy_att * Attrs#attrs.phy_att +
    Coef#formula.mag_att * Attrs#attrs.mag_att +
    Coef#formula.phy_def * Attrs#attrs.phy_def +
    Coef#formula.mag_def * Attrs#attrs.mag_def +
    Coef#formula.talent_str * Attrs#attrs.talent_str +
    Coef#formula.talent_con * Attrs#attrs.talent_con +
    Coef#formula.talent_sta * Attrs#attrs.talent_sta +
    Coef#formula.talent_spi * Attrs#attrs.talent_spi +
    Coef#formula.talent_agi * Attrs#attrs.talent_agi +
    Coef#formula.act_speed * Attrs#attrs.act_speed +
    Coef#formula.seal_hit * Attrs#attrs.seal_hit +
    Coef#formula.seal_resis * Attrs#attrs.seal_resis +
    Coef#formula.do_phy_dam_scaling * Attrs#attrs.do_phy_dam_scaling +
    Coef#formula.do_mag_dam_scaling * Attrs#attrs.do_mag_dam_scaling +
    Coef#formula.be_heal_eff_coef * Attrs#attrs.be_heal_eff_coef +
    Coef#formula.be_phy_dam_reduce_coef * Attrs#attrs.be_phy_dam_reduce_coef +
    Coef#formula.be_mag_dam_reduce_coef * Attrs#attrs.be_mag_dam_reduce_coef +
    Coef#formula.be_phy_dam_shrink * Attrs#attrs.be_phy_dam_shrink +
    Coef#formula.be_mag_dam_shrink * Attrs#attrs.be_mag_dam_shrink +
    Coef#formula.phy_crit * Attrs#attrs.phy_crit +
    Coef#formula.phy_ten * Attrs#attrs.phy_ten +
    Coef#formula.mag_crit * Attrs#attrs.mag_crit +
    Coef#formula.mag_ten * Attrs#attrs.mag_ten +
    Coef#formula.phy_crit_coef * Attrs#attrs.phy_crit_coef +
    Coef#formula.mag_crit_coef * Attrs#attrs.mag_crit_coef +
    Coef#formula.heal_value * Attrs#attrs.heal_value +
    Coef#formula.be_chaos_att_team_paoba * Attrs#attrs.be_chaos_att_team_paoba +
    Coef#formula.be_chaos_att_team_phy_dam * Attrs#attrs.be_chaos_att_team_phy_dam +
    Coef#formula.seal_hit_to_partner * Attrs#attrs.seal_hit_to_partner +
    Coef#formula.seal_hit_to_mon * Attrs#attrs.seal_hit_to_mon +
    Coef#formula.phy_dam_to_partner * Attrs#attrs.phy_dam_to_partner +
    Coef#formula.phy_dam_to_mon * Attrs#attrs.phy_dam_to_mon +
    Coef#formula.mag_dam_to_partner * Attrs#attrs.mag_dam_to_partner +
    Coef#formula.mag_dam_to_mon * Attrs#attrs.mag_dam_to_mon +
    Coef#formula.be_chaos_round_repair * Attrs#attrs.be_chaos_round_repair +
    Coef#formula.chaos_round_repair * Attrs#attrs.chaos_round_repair +
    Coef#formula.be_froze_round_repair * Attrs#attrs.be_froze_round_repair +
    Coef#formula.froze_round_repair * Attrs#attrs.froze_round_repair +
    Coef#formula.neglect_phy_def * Attrs#attrs.neglect_phy_def +
    Coef#formula.neglect_mag_def * Attrs#attrs.neglect_mag_def +
    Coef#formula.neglect_seal_resis * Attrs#attrs.neglect_seal_resis +
    Coef#formula.phy_dam_to_speed_1 * Attrs#attrs.phy_dam_to_speed_1 +
    Coef#formula.phy_dam_to_speed_2 * Attrs#attrs.phy_dam_to_speed_2 +
    Coef#formula.mag_dam_to_speed_1 * Attrs#attrs.mag_dam_to_speed_1 +
    Coef#formula.mag_dam_to_speed_2 * Attrs#attrs.mag_dam_to_speed_2 +
    Coef#formula.seal_hit_to_speed * Attrs#attrs.seal_hit_to_speed,

    erlang:max(util:ceil(BattlePower),0);

%%计算坐骑战斗力
calc_mount_battle_pow(Mount) when is_record(Mount, ets_mount) -> 
    Attrs = lib_attribute:sum_two_attrs(#attrs{}, get_mount_attribute(Mount)),
    BattlePower = calc_mount_battle_pow(Attrs),

    update_mount(Mount#ets_mount{battle_power =  erlang:max(util:ceil(BattlePower),0)}),

    BattlePower;

calc_mount_battle_pow(MountId) ->
    case lib_mount:get_mount(MountId) of
        Mount when is_record(Mount, ets_mount) ->
            calc_mount_battle_pow(Mount);
        _ -> 0 
    end.

%%获得坐骑技能[技能格子1的技能id,技能格子2的技能id,技能格子2的技能id,技能格子2的技能id] || 0
get_mount_skill(Mount) when is_record(Mount, ets_mount) ->
    util:bitstring_to_term(Mount#ets_mount.skill);
get_mount_skill(MountId) ->
    case lib_mount:get_mount(MountId) of
        Mount when is_record(Mount, ets_mount) ->
            get_mount_skill(Mount);
        _ -> 0
    end.

get_mount_skin_attr(PlayerId) ->
    case get_skins(PlayerId) of
        #mount_skin_info{all_skin = AllSkin} ->
            F = fun(#mount_skin{no = No}, AccAttr) ->
                    case data_mount_skin:get(No) of
                        #data_mount_skin{add_attr = Add} ->
                            Add ++ AccAttr;
                        _ ->
                            AccAttr
                    end
                end,
            lists:foldl(F, [], AllSkin);
        _ ->
            []
    end.

% 获得属性
get_mount_attribute(Type,Level,QualityRatio,AttributeNo1,AttributeNo2,AttributeNo3,AttributeAdd1,AttributeAdd2,AttributeAdd3) ->
    case case Type =:= 0 of
             true -> data_mount:get_attr(Level);
             false ->
                 DiyMountAttr = data_diy_mount_attr:get((Type-1)*100+Level),
                 DiyMountAttr#diy_mount_attr.attr
         end of
        AttriList when is_list(AttriList) andalso AttriList =/= [] ->
            ?DEBUG_MSG("AttriList=~p",[AttriList]),

            {Key1, Value1,_} = lists:nth(AttributeNo1, AttriList),
            NewValue1 = util:ceil((Value1 * QualityRatio * AttributeAdd1) div 1000000),

            {Key2, Value2,_} = lists:nth(AttributeNo2, AttriList),
            NewValue2 = util:ceil((Value2 * QualityRatio * AttributeAdd2) div 1000000),

            {Key3, Value3,_} = lists:nth(AttributeNo3, AttriList),
            NewValue3 = util:ceil((Value3 * QualityRatio * AttributeAdd3) div 1000000),
            % NewValue3 = 0 ,
            lib_attribute:attr_bonus(#attrs{},[{Key1,NewValue1}, {Key2, NewValue2}, {Key3,NewValue3}]);
        _ -> ?ASSERT(false, "get_mount_attribute error"), #attrs{}
    end.

%%获得坐骑三个属性
get_mount_attribute(Mount) when is_record(Mount, ets_mount) ->
    Level = Mount#ets_mount.level,
    No = Mount#ets_mount.no,

    ?DEBUG_MSG("Level=~p",[Level]),

    case data_mount:get_mount_info(No) of
        MountInfo when is_record(MountInfo, mount_info) ->
            Step = Mount#ets_mount.step,
            {QualityRatio} = lists:nth(Step, MountInfo#mount_info.quality_ratio),
            AttributeNo1 = Mount#ets_mount.attribute_1,
            AttributeNo2 = Mount#ets_mount.attribute_2,
            AttributeNo3 = Mount#ets_mount.attribute_3,
            AttributeAdd1 = Mount#ets_mount.attribute_add1,
            AttributeAdd2 = Mount#ets_mount.attribute_add2,
            AttributeSub = Mount#ets_mount.attribute_sub,
            Type = Mount#ets_mount.custom_type,
            
            get_mount_attribute(Type,Level,QualityRatio,AttributeNo1,AttributeNo2,AttributeNo3,AttributeAdd1,AttributeAdd2,AttributeSub);

        _ -> ?ASSERT(false, No), []
    end;

get_mount_attribute(MountId) ->
    case lib_mount:get_mount(MountId) of
        Mount when is_record(Mount, ets_mount) ->
            get_mount_attribute(Mount);
        _ -> ?ASSERT(false, MountId), []
    end.

%%GM设置坐骑喂养次数
set_mount_feed_times(PS, Value) ->
    MountIdList =  player:get_mount_id_list(PS),
    F = fun(MountId) ->
            Mount = lib_mount:get_mount(MountId),
            NewMount = Mount#ets_mount{feed = Value},
            update_mount(NewMount),
            db:update(NewMount#ets_mount.id, mount, [{feed, Value}], [{id, NewMount#ets_mount.id}])
        end,
    [F(X) || X <- MountIdList].


check_data(PS) ->
    List = player:get_mount_id_list(PS),
    F = fun(MountId) ->
        case lib_mount:get_mount(MountId) of
            null -> skip;
            Mount ->
                {NewMount, SaveFlag} = 
                    case Mount#ets_mount.partner1 =/= 0 andalso lib_partner:get_partner(Mount#ets_mount.partner1) =:= null of
                        true -> {Mount#ets_mount{partner1 = 0, partner_num = max(0, Mount#ets_mount.partner_num - 1)}, true};
                        _ -> {Mount, false}
                    end,
                {NewMount1, SaveFlag1} = 
                    case NewMount#ets_mount.partner2 =/= 0 andalso lib_partner:get_partner(NewMount#ets_mount.partner2) =:= null of
                        true -> {NewMount#ets_mount{partner2 = 0, partner_num = max(0, NewMount#ets_mount.partner_num - 1)}, true};
                        _ -> {NewMount, false}
                    end,
                {NewMount2, SaveFlag2} =
                    case NewMount1#ets_mount.partner3 =/= 0 andalso lib_partner:get_partner(NewMount1#ets_mount.partner3) =:= null of
                        true -> {NewMount1#ets_mount{partner3 = 0, partner_num = max(0, NewMount1#ets_mount.partner_num - 1)}, true};
                        _ -> {NewMount1, false}
                    end,
                {NewMount3, SaveFlag3} =
                    case NewMount2#ets_mount.partner4 =/= 0 andalso lib_partner:get_partner(NewMount2#ets_mount.partner4) =:= null of
                        true -> {NewMount2#ets_mount{partner4 = 0, partner_num = max(0, NewMount2#ets_mount.partner_num - 1)}, true};
                        _ -> {NewMount2, false}
                    end,
                {NewMount4, SaveFlag4} =
                    case NewMount3#ets_mount.partner5 =/= 0 andalso lib_partner:get_partner(NewMount3#ets_mount.partner5) =:= null of
                        true -> {NewMount3#ets_mount{partner5 = 0, partner_num = max(0, NewMount3#ets_mount.partner_num - 1)}, true};
                        _ -> {NewMount3, false}
                    end,

                case SaveFlag =:= false andalso SaveFlag1 =:= false andalso SaveFlag2 =:= false andalso SaveFlag3 =:= false andalso SaveFlag4 =:= false of
                    true -> skip;
                    false ->
                        update_mount(NewMount4),
                        db:update(NewMount4#ets_mount.id, mount, [{partner_num, NewMount4#ets_mount.partner_num}, {partner1, NewMount4#ets_mount.partner1},
                        {partner2, NewMount4#ets_mount.partner2}, {partner3, NewMount4#ets_mount.partner3},
                        {partner4, NewMount4#ets_mount.partner4}, {partner5, NewMount4#ets_mount.partner5}], [{id, NewMount4#ets_mount.id}])
                end
        end
    end,
    [F(X) || X <- List].

player_add_mount_skin(PS, No, GoodsNo) ->
    case check_player_add_mount_skin(PS, No, GoodsNo) of
        {fail, Reason} ->
            {fail, Reason};
        {ok, SkinNo, Second} ->
            add_skin(player:get_id(PS), SkinNo, Second),
            ok
    end.


check_player_add_mount_skin(PS, SkinNo, GoodsNo) ->
    case data_mount_skin:get(SkinNo) of
        null ->
            ?ASSERT(false, SkinNo),
            {fail, ?PM_DATA_CONFIG_ERROR};
        MountSkin ->
            case lists:keyfind(GoodsNo, 1, MountSkin#data_mount_skin.goods_list) of
                {_GoodsNo, Num} ->
                    case mod_inv:check_batch_destroy_goods(PS, [{GoodsNo, Num}]) of
                        {fail, Reason} ->
                            {fail, Reason};
                        ok ->
                            NoList = get_mount_nos(PS),
                            case NoList =:= [] of
                                true ->
                                    {fail, ?PM_YOU_NOT_HAVE_MOUNT};
                                false ->
                                    case find_skin(player:get_id(PS), SkinNo) of
                                        #mount_skin{no = SkinNo} ->
                                            {fail, ?PM_YOU_HAVE_MOUNT_SKIN};
                                        false ->
                                            [Effect] = (data_goods:get(GoodsNo))#goods_tpl.effects,
                                            {_SkinNo, Second} = (data_goods_eff:get(Effect))#goods_eff.para,
                                            {ok, SkinNo, Second}
                                    end
                            end
                    end;
                false ->
                    {fail, ?PM_DATA_CONFIG_ERROR}
            end
    end.

add_skin(UID, SkinNo, AddTime) ->
    SkinInfo = get_skins(UID),
    SkinInfo1 = do_add_skin(SkinNo, AddTime, SkinInfo),
    set_skin_info(SkinInfo1),
    lib_scene:notify_int_info_change_to_aoi(player, UID, [{?OI_CODE_MOUNT_SKIN, SkinNo}]), % AOI
    PS = player:get_PS(UID),

    List = lib_mount:get_skin_remain_time(PS),
    {ok, BinData} = pt_18:write(?PT_MOUNT_SKIN_INFO, [List]),
    lib_send:send_to_sock(PS, BinData),

    PartnerIdList = player:get_partner_id_list(PS),
    F = fun(PartnerId) ->
            case PartnerId =:= ?INVALID_ID of
                true -> skip;
                false ->
                    case lib_partner:get_partner(PartnerId) of
                        null -> skip;
                        Partner ->
                            case Partner#partner.mount_id =:= ?INVALID_ID of
                                true -> skip;
                                false ->
                                    Partner1 = lib_partner:recount_total_attrs(Partner),
                                    Partner2 = lib_partner:recount_battle_power(Partner1),
                                    mod_partner:update_partner_to_ets(Partner2)
                            end
                    end
            end
        end,
    lists:foreach(F, PartnerIdList),
    ply_attr:recount_all_attrs(PS),
    io:format("you are use skin").

test() ->
    PlayerId = 1000100000000456,
    PS = player:get_PS(PlayerId),
    MountList = get_all_mount(player:get_id(PS)),

    case MountList =:=[] of
        true ->
            Attr = ply_attr:calc_base_attrs(PS, MountList),
            case lists:keyfind(PlayerId, 1, MountList) of
                {_, _, AttrNo} ->
                    ply_attr:recount_all_attrs(Attr, data_fabao_diagrams_attr:get(AttrNo));
                _ ->
                    ?DEBUG_MSG("MountList === ~p~n",[Attr])
            end;
        false ->
            []
    end,

    io:format("MountList === ~p~n",[MountList]),

    skip.

%% AddTime是加Title的时间, 因为存在补发的情况
do_add_skin(SkinNo, AddTime, #mount_skin_info{uid = UID, all_skin = AllSkin, wear_skin_no = WearNo} = SkinInfo) ->
    case data_mount_skin:get(SkinNo) of
        null ->
            ?ASSERT(false, SkinInfo),
            SkinInfo;
        _DataSkin ->
            Expire = ?IF(AddTime > 0, AddTime + util:unixtime(), 0),
            NewSkin = #mount_skin{no = SkinNo, expire = Expire},
            schedule_one_timeout(UID, NewSkin),
            AllSkin2 = lists:keystore(SkinNo, #mount_skin.no, AllSkin, NewSkin),
            SkinInfo1 = case WearNo =:= 0 of
                            true ->
                                SkinInfo#mount_skin_info{all_skin = AllSkin2, wear_skin_no = SkinNo};
                            false ->
                                SkinInfo#mount_skin_info{all_skin = AllSkin2}
                        end,
            SkinInfo1
    end.

on_login(UID) ->
    MountSkin =
        case ets:lookup(?ETS_MOUNT_SKIN, UID) of
            [] ->
                db_load(UID);
            [T] ->
                T
        end,
    MountSkin1 = filter_expire(MountSkin),
    schedule_all_timeout(MountSkin1),
    ets:insert(?ETS_MOUNT_SKIN, MountSkin1).

on_logout(UID) ->
    SkinInfo = get_skins(UID),
    db:kv_insert(mount_skin, UID, SkinInfo),
    ets:delete(?ETS_MOUNT_SKIN, UID).

db_load(UID) ->
    case db:kv_lookup(mount_skin, UID) of
        [] ->
            new_mount_skin(UID);
        [MountSkin] ->
            MountSkin
    end.

new_mount_skin(UID) ->
    #mount_skin_info{
        uid=UID,
        wear_skin_no = 0,
        all_skin = []
    }.

filter_expire(#mount_skin_info{all_skin = All} = AllSkin) ->
    Now = util:unixtime(),
    F = fun(#mount_skin{expire= 0 }, T) -> T;
        (#mount_skin{no=No, expire=Expire}, T) when Expire =< Now->
            do_del_skin(No, T);
        (_, T) -> T
        end,
    AllSkin1 = lists:foldl(F, AllSkin, All),
    AllSkin1.

schedule_all_timeout(#mount_skin_info{uid = UID, all_skin = All}) ->
    F = fun(T) -> schedule_one_timeout(UID, T) end,
    lists:foreach(F, All).

schedule_one_timeout(UID, #mount_skin{no = SkinNo, expire = Expire}) when Expire > 0 ->
    Now = util:unixtime(),
    mod_ply_jobsch:add_mfa_schedule(UID, Expire - Now, {?MODULE, del_expire_skin, [UID, SkinNo]});
schedule_one_timeout(_, _) ->
    ok.

do_del_skin(No, #mount_skin_info{all_skin = AllSkin, wear_skin_no = SkinNo} = SkinInfo) ->
    AllSkin1 = lists:keydelete(No, #mount_skin.no, AllSkin),
    SkinInfo1 = SkinInfo#mount_skin_info{all_skin = AllSkin1},
    SkinInfo2 = case No =:= SkinNo of
                  true ->
                      SkinInfo1#mount_skin_info{wear_skin_no = 0};
                  false ->
                      SkinInfo1
                end,
    SkinInfo2.

del_expire_skin(UID, SkinNo) ->
    Now = util:unixtime(),
    case find_skin(UID, SkinNo) of
        #mount_skin{expire = 0} ->
            ok;
        #mount_skin{expire = Expire} when Expire =< Now ->
            del_skin(UID, SkinNo);
        _ ->
            ok
    end.

find_skin(UID, SkinNo) ->
    #mount_skin_info{all_skin = AllSkin} = get_skins(UID),
    lists:keyfind(SkinNo, #mount_skin.no, AllSkin).

get_skins(UID) ->
    [SkinInfo] = ets:lookup(?ETS_MOUNT_SKIN, UID),
    SkinInfo.

set_skins(SkinInfo) ->
	ets:insert(?ETS_MOUNT_SKIN, SkinInfo).

del_skin(UID, SkinNo) ->
    SkinInfo = get_skins(UID),
    SkinInfo1 = do_del_skin(SkinNo, SkinInfo),
    SkinInfo2 = case SkinInfo#mount_skin_info.wear_skin_no =:= SkinNo of
                    true ->
                        SkinInfo1#mount_skin_info{wear_skin_no = 0};
                    false ->
                        SkinInfo1
                end,
    set_skin_info(SkinInfo2),
    lib_scene:notify_int_info_change_to_aoi(player, UID, [{?OI_CODE_MOUNT_SKIN, SkinInfo2#mount_skin_info.wear_skin_no}]), % AOI

    List = get_skin_remain_time(player:get_PS(UID)),
    {ok, BinData} = pt_18:write(?PT_MOUNT_SKIN_INFO, [List]),
    lib_send:send_to_sock(player:get_PS(UID), BinData),

    ?DEBUG_MSG("del_skin   :   ~p, SkinInfo2 = ~p~n",[SkinNo,SkinInfo2]),
    PS = player:get_PS(UID),
    ply_attr:recount_all_attrs(PS).

set_skin_info(SkinInfo) when is_record(SkinInfo, mount_skin_info) ->
    ets:insert(?ETS_MOUNT_SKIN, SkinInfo).

player_change_skin(PS, SkinNo) ->
    case get_skins(player:get_id(PS)) of
        #mount_skin_info{all_skin = AllSkin} = SkinInfo ->
            case SkinNo =:= 0 of
                true ->
                    SkinInfo1 = SkinInfo#mount_skin_info{wear_skin_no = SkinNo},
                    set_skin_info(SkinInfo1),
                    lib_scene:notify_int_info_change_to_aoi(player, player:get_id(PS), [{?OI_CODE_MOUNT_SKIN, SkinNo}]), % AOI
                    ok;
                false ->
                    case lists:keyfind(SkinNo, #mount_skin.no, AllSkin) of
                        #mount_skin{no = SkinNo} ->
                            SkinInfo2 = SkinInfo#mount_skin_info{wear_skin_no = SkinNo},
                            set_skin_info(SkinInfo2),
                            lib_scene:notify_int_info_change_to_aoi(player, player:get_id(PS), [{?OI_CODE_MOUNT_SKIN, SkinNo}]), % AOI
                            ok;
                        false ->
                            {fail, ?PM_DATA_CONFIG_ERROR}
                    end
            end;
        _ ->
            {fail, ?PM_DATA_CONFIG_ERROR}
    end.

get_skin_remain_time(PS) ->
    SkinInfo = get_skins(player:get_id(PS)),
    F = fun(X, Acc) ->
            No = X#mount_skin.no,
            Expire = X#mount_skin.expire,
            [{No, Expire} | Acc]
        end,
    lists:foldl(F, [], SkinInfo#mount_skin_info.all_skin).

transform_mount_skill(PS, MountId, OldSkillId, NewSkillId, Order) ->
    Mount = lib_mount:get_mount(MountId),
    if Mount == null -> {false, ?PM_MOUNT_SYS_ERR};
        true ->
            %判断当前觉醒的技能是否大于最大格子数
            case Order > Mount#ets_mount.skillNum of
                true -> {false, ?PM_MOUNT_SKILL_NUM_LIMIT};
                false ->
                    case data_mount:get_mount_skill(Order) of
                        MountSkill when is_record(MountSkill, mount_skill) ->
                            %判断技能所需要的坐骑等级
                            case MountSkill#mount_skill.limit_lv > Mount#ets_mount.level of
                                true -> {false, ?PM_MOUNT_OPEN_LIMIT_LV};
                                false ->
                                    CurSkillLv = OldSkillId rem 10,
                                    {_, MoneyType, UseNum} = lists:nth(CurSkillLv, data_special_config:get('mount_transform_cost')),
                                    case player:has_enough_money(PS, MoneyType, UseNum) of
                                        true ->
                                            SkillIds = MountSkill#mount_skill.mount_skill_id,
                                            %判断所学技能是否在初学技能表中
                                            case lists:member({NewSkillId}, SkillIds) of
                                                false -> {false, ?PM_MOUNT_DATA_SYS_ERR};
                                                true ->
                                                    CurSkill = util:bitstring_to_term(Mount#ets_mount.skill),
                                                    %%判断当前技能id是否在已学习的技能中
                                                    CurSkillList = [(X - X rem 10 + 1) || X <- CurSkill],
                                                    io:format("OldSkillId === ~p,NewSkillId === ~p,CurSkill==~p,CurSkillList==~p,SkillIds === ~p~n",
                                                        [OldSkillId,NewSkillId,CurSkill,CurSkillList,SkillIds]),
                                                    case lists:member(OldSkillId, CurSkill) of
                                                        true ->
                                                            NewSkillId1 = NewSkillId + CurSkillLv - 1,
                                                            case lists:member(NewSkillId1, CurSkillList) of
                                                                true -> {false, ?PM_MOUNT_ALREADY_LEARN};
                                                                false ->
                                                                    case (Order =< erlang:length(CurSkill) andalso lists:nth(Order, CurSkill) == 0) orelse Order =< ?MAX_SKILL_NUM of
                                                                        true ->
                                                                            %判断技能是否在技能配置表中
                                                                            case data_skill:get(NewSkillId1) of
                                                                                DataSkill when is_record(DataSkill, skl_cfg) ->
                                                                                    F = fun(X, Acc0) ->
                                                                                        case X == Order of
                                                                                            true -> [NewSkillId1|Acc0];
                                                                                            false ->
                                                                                                [case length(CurSkill) >= X of
                                                                                                     true ->
                                                                                                         lists:nth(X, CurSkill);
                                                                                                     false ->
                                                                                                         0
                                                                                                 end|Acc0]
                                                                                        end
                                                                                        end,
                                                                                    NewCurSkill = lists:reverse(lists:foldl(F, [], lists:seq(1, ?MAX_SKILL_NUM))),
                                                                                    NewMount = Mount#ets_mount{skill = util:term_to_bitstring(NewCurSkill)},
                                                                                    update_mount(NewMount),

                                                                                    case player:get_mount(PS) == NewMount#ets_mount.id of
                                                                                        true ->
                                                                                            mod_rank:mount_clv(NewMount),
                                                                                            mod_rank:mount_battle_power(NewMount),
                                                                                            true;
                                                                                        false -> skip
                                                                                    end,

                                                                                    db:update(NewMount#ets_mount.id, mount, [{skill, NewMount#ets_mount.skill}], [{id, NewMount#ets_mount.id}]),
                                                                                    lib_partner:on_attr_change(PS, NewMount#ets_mount.partner1),
                                                                                    lib_partner:on_attr_change(PS, NewMount#ets_mount.partner2),
                                                                                    lib_partner:on_attr_change(PS, NewMount#ets_mount.partner3),
                                                                                    lib_partner:on_attr_change(PS, NewMount#ets_mount.partner4),
                                                                                    lib_partner:on_attr_change(PS, NewMount#ets_mount.partner5),
                                                                                    {ok, MoneyType, UseNum, NewSkillId1};
                                                                                _ ->
                                                                                    {false, ?PM_MOUNT_DATA_SYS_ERR}
                                                                            end;
                                                                        false ->
                                                                            {false, ?PM_MOUNT_ALREADY_LEARN}
                                                                    end
                                                            end;
                                                        false ->
                                                            {false, ?PM_NOT_HAVE_TRANSFORM_SKILL}
                                                    end
                                            end;
                                        false ->
                                            {false, ?PM_MONEY_LIMIT}
                                    end
                            end;
                        _ ->
                            {false, ?PM_MOUNT_DATA_SYS_ERR}
                    end
            end
    end.
