%%%-----------------------------------
%%% @Module  : pt_12
%%% @Author  :
%%% @Email   :
%%% @Created : 2011.04.29
%%% @Modified : 2013.6.17 -- huangjf
%%% @Description: 场景相关的协议
%%%-----------------------------------
-module(pt_12).
-export([read/2
        ,write/2
    ]).
-include("record.hrl").
-include("common.hrl").
-include("scene.hrl").
-include("player.hrl").
-include("pt_12.hrl").
-include("goods.hrl").
-include("buff.hrl").
-include("aoi.hrl").
-include("monster.hrl").
-include("npc.hrl").
-include("title.hrl").
-include("pt.hrl").
-include("mount.hrl").
-include("chibang.hrl").

% %%
% %%客户端 -> 服务端 ----------------------------
% %%

%% 玩家走动
read(?PT_PLAYER_MOVE, <<SceneId:32, NewX:16, NewY:16>>) ->
    {ok, [SceneId, NewX, NewY]};

read(?PT_REQ_LEAVE_BLOCKED_POS, _) ->
    {ok, dummy};

read(?PT_FORCE_TELEPORT, <<SceneId:32, X:16, Y:16>>) ->
    {ok, [SceneId, X, Y]};

read(?PT_REQ_TELEPORT, <<TeleportNo:32>>) ->
    {ok, TeleportNo};

%% 请求普通场景之间跳转（从一个普通场景请求进入另一个普通场景）
read(?PT_SWITCH_BETWEEN_NORMAL_SCENES, <<NewSceneId:32>>) ->
    {ok, NewSceneId};


read(?PT_GET_SCENE_DYNAMIC_NPC_LIST, <<SceneId:32>>) ->
    {ok, SceneId};


read(?PT_GET_SCENE_DYNAMIC_TELEPORTER_LIST, <<SceneId:32>>) ->
    {ok, SceneId};


%% 加载场景：获取场景AOI范围的信息
read(?PT_GET_SCENE_AOI_INFO, <<SceneId:32>>) ->
    {ok, SceneId};



%% 作废！！
% %% 仅用于调试
% read(?PT_DBG_SPAWN_MON_TO_SCENE_FOR_PLAYER_WNC, <<MonNo:32, SceneId:32>>) ->
%     {ok, [MonNo, SceneId]};


%% 仅调试用的协议：获取场景内的明雷怪列表
read(?PT_DBG_GET_SCENE_MON_LIST, <<SceneId:32>>) ->
    {ok, SceneId};

read(_Cmd, _R) ->
    ?ASSERT(false, {_Cmd, _R}),
    {error, not_match}.



% %%
% %%服务端 -> 客户端 ------------------------------------
% %%

%% 玩家移动
write(?PT_PLAYER_MOVE, [PlayerId, NewX, NewY]) ->
    Data = <<PlayerId:64, NewX:16, NewY:16>>,
    {ok, pt:pack(?PT_PLAYER_MOVE, Data)};



%% npc移动
write(?PT_NOTIFY_OBJ_MOVE, [npc, NpcId, NewX, NewY]) ->
    Data = <<?OBJ_NPC:8, NpcId:32, NewX:16, NewY:16>>,
    {ok, pt:pack(?PT_NOTIFY_OBJ_MOVE, Data)};


%% 怪物移动
write(?PT_NOTIFY_OBJ_MOVE, [mon, MonId, NewX, NewY]) ->
    Data = <<?OBJ_MONSTER:8, MonId:32, NewX:16, NewY:16>>,
    {ok, pt:pack(?PT_NOTIFY_OBJ_MOVE, Data)};


%% 作废！！
% %%加场景信息
% write(12002, {User, Mon, Elem, Npc,LevelList,ItemList}) ->
%     Data1 = pack_elem_list(Elem),
%     Data2 = pack_player_info_list_for_AOI(User),
%     Data3 = pack_scene_mon_list(Mon),
%     Data4 = pack_scene_npc_list(Npc),
%     Data5 = pack_elem_list(LevelList), % 关卡列表形式跟出入口一致
%     Data6 = pack_item_list(ItemList),
%     Data = << Data1/binary, Data2/binary, Data3/binary, Data4/binary,Data5/binary,Data6/binary>>,
%     {ok, pt:pack(12002, Data)};




%% 通知场景玩家：有玩家进入了我的AOI
write(?PT_NOTIFY_PLAYERS_ENTER_MY_AOI, PlayerIdList) when is_list(PlayerIdList) ->
	?ASSERT(PlayerIdList /= []),
	Bin = pack_player_info_list_for_AOI(PlayerIdList),
    {ok, pt:pack(?PT_NOTIFY_PLAYERS_ENTER_MY_AOI, Bin)};

write(?PT_NOTIFY_PLAYERS_ENTER_MY_AOI, PS) when is_record(PS, player_status) ->
    Bin =   case pack_one_player_info_for_AOI(PS) of
                null ->
                    <<0:16>>;
                Bin0 ->
                    <<1:16, Bin0/binary>>
            end,
    {ok, pt:pack(?PT_NOTIFY_PLAYERS_ENTER_MY_AOI, Bin)};



%% 通知场景玩家：有玩家离开了我的AOI
write(?PT_NOTIFY_PLAYERS_LEAVE_MY_AOI, PlayerIdList) ->
	?ASSERT(PlayerIdList /= []),
    Bin = list_to_binary([<<Id:64>> || Id <- PlayerIdList]),
    Bin2 = <<(length(PlayerIdList)):16, Bin/binary>>,
    {ok, pt:pack(?PT_NOTIFY_PLAYERS_LEAVE_MY_AOI, Bin2)};






write(?PT_NOTIFY_OBJS_ENTER_MY_AOI, {mon, MonIdList}) when is_list(MonIdList) ->
    ?ASSERT(MonIdList /= []),
    Bin = pack_obj_info_list_for_AOI(mon, MonIdList),
    {ok, pt:pack(?PT_NOTIFY_OBJS_ENTER_MY_AOI, Bin)};

write(?PT_NOTIFY_OBJS_ENTER_MY_AOI, {mon, MonObj}) when is_record(MonObj, mon) ->
    Bin =   case pack_one_obj_info_for_AOI(mon, MonObj) of
                null ->
                    <<0:16>>;
                Bin0 ->
                    <<1:16, Bin0/binary>>
            end,
    {ok, pt:pack(?PT_NOTIFY_OBJS_ENTER_MY_AOI, Bin)};

write(?PT_NOTIFY_OBJS_ENTER_MY_AOI, {npc, NpcIdList}) when is_list(NpcIdList) ->
    ?ASSERT(NpcIdList /= []),
    Bin = pack_obj_info_list_for_AOI(npc, NpcIdList),
    {ok, pt:pack(?PT_NOTIFY_OBJS_ENTER_MY_AOI, Bin)};

write(?PT_NOTIFY_OBJS_ENTER_MY_AOI, {npc, NpcObj}) when is_record(NpcObj, npc) ->
    Bin =   case pack_one_obj_info_for_AOI(npc, NpcObj) of
                null ->
                    <<0:16>>;
                Bin0 ->
                    <<1:16, Bin0/binary>>
            end,
    {ok, pt:pack(?PT_NOTIFY_OBJS_ENTER_MY_AOI, Bin)};




write(?PT_NOTIFY_OBJS_LEAVE_MY_AOI, {mon, MonIdList}) ->
    ?ASSERT(MonIdList /= []),
    Bin = list_to_binary([<<?OBJ_MONSTER:8, Id:32>> || Id <- MonIdList]),
    Bin2 = <<(length(MonIdList)):16, Bin/binary>>,
    {ok, pt:pack(?PT_NOTIFY_OBJS_LEAVE_MY_AOI, Bin2)};

write(?PT_NOTIFY_OBJS_LEAVE_MY_AOI, {npc, NpcIdList}) ->
    ?ASSERT(NpcIdList /= []),
    Bin = list_to_binary([<<?OBJ_NPC:8, Id:32>> || Id <- NpcIdList]),
    Bin2 = <<(length(NpcIdList)):16, Bin/binary>>,
    {ok, pt:pack(?PT_NOTIFY_OBJS_LEAVE_MY_AOI, Bin2)};







write(?PT_NOTIFY_SWITCH_TO_NEW_SCENE, [SceneId, SceneNo, NewX, NewY]) ->
    Bin = <<SceneId:32, SceneNo:32, NewX:16, NewY:16>>,
    {ok, pt:pack(?PT_NOTIFY_SWITCH_TO_NEW_SCENE, Bin)};


write(?PT_GET_SCENE_DYNAMIC_NPC_LIST, DynNpcIdList) ->
    Bin = pack_scene_dynamic_npc_list(DynNpcIdList),
    {ok, pt:pack(?PT_GET_SCENE_DYNAMIC_NPC_LIST, Bin)};



write(?PT_GET_SCENE_DYNAMIC_TELEPORTER_LIST, [SceneId, TeleporterList]) ->
    Bin = pack_scene_dynamic_teleporter_list(SceneId, TeleporterList),
    {ok, pt:pack(?PT_GET_SCENE_DYNAMIC_TELEPORTER_LIST, Bin)};



write(?PT_NOTIFY_OBJ_SPAWNED, {npc, NpcId}) when is_integer(NpcId) ->
    Bin = pack_obj_info_list_for_AOI(npc, [NpcId]),
    {ok, pt:pack(?PT_NOTIFY_OBJ_SPAWNED, Bin)};


write(?PT_NOTIFY_OBJ_SPAWNED, {npc, NpcObj}) when is_record(NpcObj, npc) ->
    Bin = case pack_one_obj_info_for_AOI(npc, NpcObj) of
                null ->
                    <<0:16>>;
                Bin0 ->
                    <<1:16, Bin0/binary>>
        end,
    {ok, pt:pack(?PT_NOTIFY_OBJ_SPAWNED, Bin)};


write(?PT_NOTIFY_OBJ_SPAWNED, {npc, NpcObj, X, Y}) ->  % 指定了X，Y坐标
    Bin = pack_one_obj_info_for_AOI(npc, NpcObj, X, Y),
    Bin2 = <<1:16, Bin/binary>>,
    {ok, pt:pack(?PT_NOTIFY_OBJ_SPAWNED, Bin2)};


write(?PT_NOTIFY_OBJ_SPAWNED, {mon, MonId}) ->
    Bin = pack_obj_info_list_for_AOI(mon, [MonId]),
    {ok, pt:pack(?PT_NOTIFY_OBJ_SPAWNED, Bin)};




write(?PT_NOTIFY_OBJ_CLEARED, {npc, NpcId}) ->
    Bin = <<?OBJ_NPC:8, NpcId:32>>,
    {ok, pt:pack(?PT_NOTIFY_OBJ_CLEARED, Bin)};

write(?PT_NOTIFY_OBJ_CLEARED, {mon, MonId}) ->
    Bin = <<?OBJ_MONSTER:8, MonId:32>>,
    {ok, pt:pack(?PT_NOTIFY_OBJ_CLEARED, Bin)};



write(?PT_NOTIFY_DYNAMIC_TELEPORTER_SPAWNED, Teleporter) ->
    Bin = <<
            (Teleporter#teleporter.scene_id) : 32,
            (Teleporter#teleporter.teleport_no) : 32,
            (Teleporter#teleporter.x) : 16,
            (Teleporter#teleporter.y) : 16
        >>,
    {ok, pt:pack(?PT_NOTIFY_DYNAMIC_TELEPORTER_SPAWNED, Bin)};




write(?PT_NOTIFY_DYNAMIC_TELEPORTER_CLEARED, Teleporter) ->
    Bin = <<
            (Teleporter#teleporter.scene_id) : 32,
            (Teleporter#teleporter.teleport_no) : 32,
            (Teleporter#teleporter.x) : 16,
            (Teleporter#teleporter.y) : 16
        >>,
    {ok, pt:pack(?PT_NOTIFY_DYNAMIC_TELEPORTER_CLEARED, Bin)};



write(?PT_NOTIFY_OBJ_AOI_INFO_CHANGE1, [ObjType, ObjId, KV_TupleList]) ->
    F = fun({ObjInfoCode, NewValue}) ->
            <<ObjInfoCode:32, NewValue:32>>
        end,
    Bin = list_to_binary([F(X) || X <- KV_TupleList]),
    Bin2 = <<
            (length(KV_TupleList)) : 16,
             Bin / binary
           >>,
    Bin3 = <<ObjType:8, ObjId:64, Bin2/binary>>,
    {ok, pt:pack(?PT_NOTIFY_OBJ_AOI_INFO_CHANGE1, Bin3)};


write(?PT_NOTIFY_PLAYER_AOI_INFO_CHANGE2, [PlayerId, KV_TupleList]) ->
    F = fun({ObjInfoCode, NewValue}) ->
            <<ObjInfoCode:8, (byte_size(NewValue)):16, NewValue/binary>>
        end,
    Bin = list_to_binary([F(X) || X <- KV_TupleList]),
    Bin2 = <<
            (length(KV_TupleList)) : 16,
             Bin / binary
           >>,
    Bin3 = <<PlayerId:64, Bin2/binary>>,
    {ok, pt:pack(?PT_NOTIFY_PLAYER_AOI_INFO_CHANGE2, Bin3)};


write(?PT_NOTIFY_MAIN_PAR_CHANGE, [PlayerId, PartnerNo, ParWeapon, EvolveLv, CultivateLv, CultivateLayer, ParQuality, Name, ParClothes, ParAwakeIllusion]) ->
    Bin = <<PlayerId:64, PartnerNo:32, ParWeapon:32, EvolveLv:8, CultivateLv:8, CultivateLayer:8, ParQuality:8, (byte_size(Name)):16, Name/binary, ParClothes:32, ParAwakeIllusion:8>>,
    {ok, pt:pack(?PT_NOTIFY_MAIN_PAR_CHANGE, Bin)};


write(?PT_NOTIFY_PLAYER_BUFF_VANISH, [PlayerId, BuffNo]) ->
    Bin = <<PlayerId:64, BuffNo:32>>,
    {ok, pt:pack(?PT_NOTIFY_PLAYER_BUFF_VANISH, Bin)};

write(?PT_NOTIFY_SERVER_ALL_PLAYER, [RetCode]) ->
    Bin = <<RetCode:8>>,
    {ok, pt:pack(?PT_NOTIFY_SERVER_ALL_PLAYER, Bin)};


% %% 请求进入普通场景
% write(?PT_ENTER_SCENE_REQ, [Id, X, Y, Name, Sid]) ->
%     Len = byte_size(Name),
%     Data = <<Id:32, X:16, Y:16, Len:16, Name/binary, Sid:32, 0:32, 0:32>>,
%     {ok, pt:pack(12005, Data)};

% %%切换场景
% write(12005, [Id, X, Y, Name, Sid, EnterEvent, EndEvent]) ->
%     Len = byte_size(Name),
%     Data = <<Id:32, X:16, Y:16, Len:16, Name/binary, Sid:32, EnterEvent:32, EndEvent:32>>,
%     {ok, pt:pack(12005, Data)};


% %%通知场景玩家：怪物重生了
% write(12007, Info) ->
%     Name1 = Info#mon.name,
%     Len = byte_size(Name1),
%     X = Info#mon.x,
%     Y = Info#mon.y,
%     Id = Info#mon.id,
%     Mid = Info#mon.mid,
%     Lv = Info#mon.lv,
%     Speed = Info#mon.speed,
%     Icon = Info#mon.icon,
% 	Talk = pack_mon_talk_list([T||T<-[Info#mon.talk_1,Info#mon.talk_2], T =/= <<>>]),
% 	PassFinish = Info#mon.pass_finish,
% 	ReadyBattleLeftTime = lib_mon:get_ready_battle_left_time(Info),
% 	AttArea = Info#mon.att_area,
%     Data = <<X:16, Y:16, Id:32, Mid:32, Lv:16, Len:16, Name1/binary, Speed:16, Icon:32, Talk/binary, PassFinish:32, ReadyBattleLeftTime:16, AttArea:16>>,
%     {ok, pt:pack(12007, Data)};

% %%怪物移动
% write(12008, [X, Y, Id]) ->
%     Data = <<X:16, Y:16, Id:32>>,
%     {ok, pt:pack(12008, Data)};




% %% 改变NPC状态图标
% write(12020, []) ->
%     {ok, pt:pack(12020, <<>>)};
% write(12020, [NpcList]) ->
%     NL = length(NpcList),
%     Bin = list_to_binary([<<Id:32, Ico:8>> || [Id, Ico] <- NpcList]),
%     Data = <<NL:16, Bin/binary>>,
%     {ok, pt:pack(12020, Data)};






% %% 添加场景交互对象
% write(12098,  ItemL)->
%     Bin = pack_item_list(ItemL),
%     {ok, pt:pack(12098, <<Bin/binary>>)};

% %% 删除场景的交互对象
% write(12099,  {ItemId, X, Y})->
% 	write(12099,{ItemId, X, Y, [], 0});
% write(12099,  {ItemId, X, Y, ItemL, Id})->
% 	L = length(ItemL),
% 	Bin = list_to_binary([<<TypeId:32,Num:32>>||{TypeId, Num}<-ItemL]),
%     {ok, pt:pack(12099, <<ItemId:32,X:32,Y:32, L:16, Bin/binary, Id:32>>)};

% %% 删除场景的怪物
% write(12101,  Id)->
%     {ok, pt:pack(12101, <<Id:32>>)};

% %% 交互对象被占用
% write(12103,  {Id, Item, X, Y})->
%     {ok, pt:pack(12103, <<Id:32, Item:32, X:32, Y:32>>)};

% %% 占用的交互对象状态转为空闲
% write(12104,  {Item, X, Y})->
%     {ok, pt:pack(12104, <<Item:32, X:32, Y:32>>)};

% %% 播放剧情
% write(12105,  Id)->
%     {ok, pt:pack(12105, <<Id:32>>)};

% %% 场景中的npc列表数据
% write(12106,  ReplyL)->
% 	Bin = pack_dungeon_npc_list(ReplyL),
%     {ok, pt:pack(12106, <<Bin/binary>>)};

% write(12118, [Id, Pose]) ->
% 	{ok, pt:pack(12118, <<Id:32, Pose:8>>)};

% %% 通知护送的美女的变化
% write(12120, [Id, NpcId, NpcName, NpcIcon]) ->
% 	?TRACE("12120-------------------------~n"),
% 	{ok, pt:pack(12120, <<Id:32, NpcId:32, (byte_size(NpcName)):16, NpcName/binary, NpcIcon:32>>)};

write(_Cmd, _R) ->
	?ASSERT(false, {_Cmd, _R}),
    %%%{ok, pt:pack(0, <<>>)}.
    {error, not_match}.


% %% 打包一个关卡中的所有npc的信息
% pack_dungeon_npc_list([]) ->
% 	<<0:16, <<>>/binary>>;
% pack_dungeon_npc_list(ReplyL) ->
% 	Len = length(ReplyL),
% 	F = fun([Nid, Name,X,Y]) ->
% 				L = byte_size(Name),
% 				<<Nid:32, L:16, Name/binary, X:32, Y:32 >>
% 		end,
% 	F1 = fun(Sid, NpcL) ->
% 				 Len1 = length(NpcL),
% 				 Bin1 = list_to_binary([F([Nid, Name,X,Y]) || [Nid, Name,X,Y] <- NpcL]),
% 				 <<Sid:32, Len1:16, Bin1/binary>>
% 		 end,
% 	Bin = list_to_binary([F1(Sid, NpcL) || {Sid,NpcL} <- ReplyL]),
% 	<<Len:16, Bin/binary>>.

% %% 打包元素列表
% pack_elem_list([]) ->
%     <<0:16, <<>>/binary>>;
% pack_elem_list(Elem) ->
%     Rlen = length(Elem),
%     F = fun([Sid, Name, X, Y,Type]) ->
%             Len = byte_size(Name),
%             <<Sid:32, Len:16, Name/binary, X:16, Y:16,Type:8>>
%     end,
%     RB = list_to_binary([F(D) || D <- Elem]),
%     <<Rlen:16, RB/binary>>.

% %% 打包场景交互对象列表
% pack_item_list([]) ->
%     <<0:16, <<>>/binary>>;
% pack_item_list(Item) ->
%     Rlen = length(Item),
%     F = fun([ResId, Name, Type, X, Y,Icon,Use,_Ex]) ->
%             Len = byte_size(Name),
% 			[{OpenStyle, Num},Task,Require] =
% 				case data_scene_item:get(ResId) of
% 					Info when is_record(Info, scene_item) ->
% 						[Info#scene_item.type, Info#scene_item.task, Info#scene_item.req];
% 					_ ->
% 						[{2,1},0,0]
% 				end,
% %%             << ResId:32, Type:32, Len:16, Name/binary , X:32, Y:32, Icon:32,Use:32, OpenStyle:32, Num:32>>
%             << ResId:32, Type:32, Len:16, Name/binary , X:32, Y:32, Icon:32,Use:32, OpenStyle:32, Num:32,Task:32,Require:32>>
%     end,
%     RB = list_to_binary([F(D) || D <- Item]),
%     <<Rlen:16, RB/binary>>.

% %% 打包关卡列表准入、禁入原因
% pack_level_list([]) ->
%     <<0:16, <<>>/binary>>;
% pack_level_list(PassReasList)->
%     Rlen = length(PassReasList),
%     F = fun({Id,Com,Reason})->
%             Len = byte_size(Reason),
%             <<Id:32,Com:32,Len:16,Reason/binary>>
%     end,
%     RB = list_to_binary([F(D) || D <- PassReasList]),
%     <<Rlen:16,RB/binary>>.


%% 打包玩家信息列表（用于场景AOI）
pack_player_info_list_for_AOI(PlayerIdList) ->
    ?ASSERT(PlayerIdList /= []),
    F = fun(Id) ->
    		case player:get_PS(Id) of
    			null ->
                    %%%%?ASSERT(false, Id),  % TODO： 构思----此断言确定有必要？？ 已经没必要了！
    				null;
    			PS ->
                    pack_one_player_info_for_AOI(PS)
    		end
    	end,

    BinInfoL = [Bin || X <- PlayerIdList, begin Bin = F(X), Bin /= null end],
    RespBin = list_to_binary(BinInfoL),
    <<(length(BinInfoL)):16, RespBin/binary>>.





pack_one_player_info_for_AOI(PS) ->
                    Id = player:id(PS),
                    % 稳妥起见，这里同样判断pos是否为null
                    case lib_aoi:get_player_pos(Id) of  %%player:get_position(Id) of
                        null ->
                            ?ASSERT(false, Id),
                            null;
                        Pos ->
                            % ?DEBUG_MSG("pack_player_info_list_for_AOI(), PlayerId=~p, Pos=~p~n", [Id, Pos]),

                            PlayerName = player:get_name(PS),
                            GuildName = ply_guild:get_guild_name(PS),

                            Titles = ply_title:get_titles(Id),
                            GraphTitle = Titles#titles.graph_title,
                            TextTitle = Titles#titles.text_title,
                            UserDefTitle = Titles#titles.user_def_title,

                            ShowEquips = player:get_showing_equips(PS),
                            BackWear = 
                                case ply_setting:is_backwear_hide(Id) of
                                    false -> ShowEquips#showing_equip.backwear;
                                    true -> ?INVALID_NO
                                end,
                            Weapon = ShowEquips#showing_equip.weapon,
                            Headwear = 
                                case ply_setting:is_headwear_hide(Id) of
                                    false -> ShowEquips#showing_equip.headwear;
                                    true -> ?INVALID_NO
                                end,
                            Clothes =   
                                case ply_setting:is_clothes_hide(Id) of
                                    false -> ShowEquips#showing_equip.clothes;
                                    true -> ?INVALID_NO
                                end,
                            MagicKey = ShowEquips#showing_equip.magic_key,
                            % PartnerNo = mod_partner:get_main_partner_no(PS),
                            PartnerId = player:get_follow_partner_id(PS),

                            {ParWeapon, ParEvolveLv, ParName, PartnerNo, CultivateLv, CultivateLayer, ParQuality, ParClothes, ParAwakeIllusion} =
                            case PartnerId == ?INVALID_ID of
                                true ->
                                    {?INVALID_NO, ?INVALID_NO, <<"">>, ?INVALID_NO, 0, ?INVALID_NO, ?QUALITY_INVALID, ?INVALID_NO, ?INVALID_NO};
                                false ->
                                    case lib_partner:get_partner(PartnerId) of
                                        null ->
                                            {?INVALID_NO, ?INVALID_NO, <<"">>, ?INVALID_NO, 0, ?INVALID_NO, ?QUALITY_INVALID, ?INVALID_NO, ?INVALID_NO};
                                        Partner ->
                                            ParShowEquips = lib_partner:get_showing_equips(Partner),
                                            TParClothes = 
                                                case ply_setting:is_par_clothes_hide(Id) of
                                                    true -> ?INVALID_NO;
                                                    false -> ParShowEquips#showing_equip.clothes
                                                end,
                                            {
                                            ParShowEquips#showing_equip.weapon, 
                                            lib_partner:get_evolve_lv(Partner),
                                            lib_partner:get_name(Partner),
                                            lib_partner:get_no(Partner),
                                            lib_partner:get_cultivate_lv(Partner),
                                            lib_partner:get_cultivate_layer(Partner),
                                            lib_partner:get_quality(Partner),
                                            TParClothes,
											lib_partner:get_awake_illusion(Partner)
                                            }
                                    end
                            end,

                            BuffList = mod_buff:get_buff_list(player, Id),
                            F = fun(X) ->
                                <<(X#buff.no):32>>
                            end,
                            BuffBin = list_to_binary([F(X) || X <- BuffList]),
                            BuffBin1 = <<(length(BuffList)):16, BuffBin/binary>>,
                            % ?TRACE("PartnerNo:~p, BuffList:~p~n", [PartnerNo, BuffList]),
                            IsLeader =
                                case player:is_leader(PS) of
                                    true -> 1;
                                    false -> 0
                                end,

                            SpouseName = 
                                case ply_relation:get_spouse_id(PS) of
                                    ?INVALID_ID -> <<>>;
                                    SpouseId -> player:get_name(SpouseId)
                                end,
                            {MountNo, MountStep} = 
                                case player:get_mount(PS) of
                                    ?INVALID_ID -> {?INVALID_NO, ?INVALID_NO};
                                    MountId ->
                                        case lib_mount:get_mount(MountId) of
                                            null -> {?INVALID_NO, ?INVALID_NO};
                                            Mount -> {Mount#ets_mount.no, Mount#ets_mount.step}
                                        end
                                end,
                            SkinInfo = lib_mount:get_skins(Id),
                            SkinNo = SkinInfo#mount_skin_info.wear_skin_no,
							WingNo = case ets:lookup(ets_player_wing, Id) of
										 [] -> 0;
										 [WingR] -> WingR#player_wing.use_wing
									 end,

                            % 必要的基本信息
                            NecessaryBin = <<
                                Id : 64,
                                (Pos#aoi_pos.x) : 16,
                                (Pos#aoi_pos.y) : 16,
                                (player:get_race(PS)) : 8,
                                (player:get_faction(PS)) : 8,
                                (player:get_lv(PS)) : 16,
                                (player:get_sex(PS)) : 8,
                                (byte_size(PlayerName)) : 16,
                                PlayerName / binary,
                                (byte_size(GuildName)) : 16,
                                GuildName / binary,

                                GraphTitle : 32,
                                TextTitle : 32,
                                ?P_BITSTR(UserDefTitle),

                                BackWear:32,
                                Weapon:32,
                                Headwear : 32,
                                Clothes : 32,
                                PartnerNo :32,
                                ParWeapon:32,
                                ParEvolveLv:8,
                                CultivateLv:8,
                                CultivateLayer:8,
                                ParQuality:8,
                                (byte_size(ParName)) : 16,
                                ParName/binary,
                                ParClothes:32,
								ParAwakeIllusion:8,
                                (player:get_cur_bhv_state(PS)):8,
                                (player:get_vip_lv(PS)):8,
                                IsLeader : 8,
                                (player:get_team_id(PS)) : 32,
                                (player:get_suit_no(PS)) : 8,
                                BuffBin1/binary,
                                (byte_size(SpouseName)) : 16,
                                SpouseName / binary,
                                MagicKey : 32,
                                MountNo : 32,
                                SkinNo : 16,
                                MountStep : 8,
                                (player:get_popular(PS)) : 32,
                                (player:get_transfiguration_no(PS)) : 32,
                                (ply_setting:get_paodian_type(player:id(PS))) : 32,
								WingNo:32
                            >>,

                            % todo: 添加其他可选信息
                            % ...
                            % OptBin = <<>>,  % 暂时固定为空
                            % <<NecessaryBin/binary, (byte_size(OptBin)):16, OptBin/binary>>

                            NecessaryBin

                    end.





%% 打包明雷怪信息列表（用于场景AOI）
pack_obj_info_list_for_AOI(mon, MonIdList) ->
    ?ASSERT(MonIdList /= []),
    % ?TRACE("~n~n~n********************* MonIdList: ~p~n", [MonIdList]),
    F = fun(Id) ->
            case mod_mon:get_obj(Id) of
                null ->
                    null;
                MonObj ->
                    pack_one_obj_info_for_AOI(mon, MonObj)
            end
        end,
    BinInfoL = [Bin || X <- MonIdList, begin Bin = F(X), Bin /= null end],
    RespBin = list_to_binary(BinInfoL),
    <<(length(BinInfoL)):16, RespBin/binary>>;


%% 打包（动态）NPC信息列表（用于场景AOI）
pack_obj_info_list_for_AOI(npc, NpcIdList) ->
    ?ASSERT(NpcIdList /= []),
    F = fun(Id) ->
            case mod_npc:get_obj(Id) of
                null ->
                    null;
                NpcObj ->
                    pack_one_obj_info_for_AOI(npc, NpcObj)
            end
        end,
    BinInfoL = [Bin || X <- NpcIdList, begin Bin = F(X), Bin /= null end],
    RespBin = list_to_binary(BinInfoL),
    <<(length(BinInfoL)):16, RespBin/binary>>.





pack_one_obj_info_for_AOI(mon, MonObj) ->
    Id = mod_mon:get_id(MonObj),
    case lib_aoi:get_mon_pos(Id) of
        null ->
            ?ASSERT(false, MonObj),
            null;
        Pos ->
            X = Pos#aoi_pos.x,
            Y = Pos#aoi_pos.y,
            pack_one_obj_info_for_AOI(mon, MonObj, X, Y)
    end;

pack_one_obj_info_for_AOI(npc, NpcObj) ->
    Id = mod_npc:get_id(NpcObj),
    case lib_aoi:get_npc_pos(Id) of
        null ->
            ?ASSERT(false, NpcObj),
            null;
        Pos ->
            X = Pos#aoi_pos.x,
            Y = Pos#aoi_pos.y,
            pack_one_obj_info_for_AOI(npc, NpcObj, X, Y)
    end.



pack_one_obj_info_for_AOI(mon, MonObj, X, Y) ->  % 指定了X，Y坐标
    LeftCanBeKilledTimes =
        case mod_mon:get_left_can_be_killed_times(MonObj) of
            infinite -> ?INFINITE_CAN_BE_KILLED_TIMES;
            Times -> Times
        end,
    <<
        ?OBJ_MONSTER : 8,
        (mod_mon:get_id(MonObj)) : 32,
        (mod_mon:get_no(MonObj)) : 32,
        X : 16,
        Y : 16,
        (mod_mon:get_team_id(MonObj)) : 32,
        (mod_mon:get_owner_id(MonObj)) : 64,
        LeftCanBeKilledTimes : 16,
        (mod_mon:get_bhv_state(MonObj)) : 8,
        0 : 16,
        <<>>/binary,
        0 : 16,
        <<>>/binary
    >>;

pack_one_obj_info_for_AOI(npc, NpcObj, X, Y) ->  % 指定了X，Y坐标
    ExtraInitInfo = mod_npc:get_extra(NpcObj),
    TeamId = %%对于npc来说目前表示称号id
        case lists:keyfind(title_no, 1, ExtraInitInfo) of
            false -> ?INVALID_ID;
            {_, TitleNo} -> TitleNo
        end,

    String1 = 
        case lists:keyfind(string_1, 1, ExtraInitInfo) of
            false -> <<>>;
            {_, TString1} -> TString1
        end,
    String2 = 
        case lists:keyfind(string_2, 1, ExtraInitInfo) of
            false -> <<>>;
            {_, TString2} -> TString2
        end,

    <<
        ?OBJ_NPC : 8,
        (mod_npc:get_id(NpcObj)) : 32,
        (mod_npc:get_no(NpcObj)) : 32,
        X : 16,
        Y : 16,
        TeamId : 32,    % 无队伍，固定为0
        0 : 64,         % 目前npc无所属玩家，固定为0
        0 : 16,         % 无剩余可被杀死的次数，固定为0
        (mod_npc:get_bhv_state(NpcObj)) : 8,
        (byte_size(String1)):16,
        String1/binary,
        (byte_size(String2)):16,
        String2/binary
    >>.




% %% 打包场景中的普通NPC列表
% pack_scene_normal_npc_list(NorNpcIdList) ->
%     F = fun(Id) ->
%             case lib_npc:get_obj(Id) of
%                 null ->
%                     null;
%                 Npc ->
%                     {X, Y} = lib_npc:get_xy(Npc),
%                     <<
%                         Id : 32,
%                         (lib_npc:get_no(Npc)) : 32,
%                         X : 16,
%                         Y : 16
%                     >>
%             end
%         end,
%     BinInfoL = [Bin || X <- NorNpcIdList, begin Bin = F(X), Bin /= null end],
%     RespBin = list_to_binary(BinInfoL),
%     <<(length(BinInfoL)):16, RespBin/binary>>.



%% 打包场景中的动态NPC列表
pack_scene_dynamic_npc_list(DynNpcIdList) ->
    F = fun(Id) ->
            case mod_npc:get_obj(Id) of
                null ->
                    null;
                Npc ->
                    {X, Y} = mod_npc:get_xy(Npc),
                    <<
                        Id : 32,
                        (mod_npc:get_no(Npc)) : 32,
                        X : 16,
                        Y : 16
                    >>
            end
        end,
    BinInfoL = [Bin || X <- DynNpcIdList, begin Bin = F(X), Bin /= null end],
    RespBin = list_to_binary(BinInfoL),
    <<(length(BinInfoL)):16, RespBin/binary>>.





%% 打包场景中的动态传送点列表
pack_scene_dynamic_teleporter_list(SceneId, TeleporterList) ->
    F = fun(Telep) ->
            ?ASSERT(Telep#teleporter.scene_id == SceneId, {SceneId, Telep}),
            <<
                (Telep#teleporter.teleport_no) : 32,
                (Telep#teleporter.x) : 16,
                (Telep#teleporter.y) : 16
            >>
        end,
    BinInfoL = [F(X) || X <- TeleporterList],
    RespBin = list_to_binary(BinInfoL),
    <<
        SceneId : 32,
        (length(TeleporterList)) : 16,
        RespBin / binary
    >>.




% %% 打包场景怪物列表
% pack_scene_mon_list([]) ->
%     <<0:16, <<>>/binary>>;
% pack_scene_mon_list(MonIdList) ->
%     F = fun(Id) ->
%     		% 稳妥起见，这里判断返回值是否为null
%     		case lib_mon:get_obj(Id) of
%     			null ->
%     				<<>>;
%     			Mon ->
%     				Name = lib_mon:get_name(Mon),
%     				NameLen = byte_size(Name),
%     				No = lib_mon:get_no(Mon),
%     				{X, Y} = lib_mon:get_xy(Mon),
% 					%%Talk = pack_mon_talk_list([T||T<-[Talk1,Talk2], T =/= <<>>]),
%         			<<Id:32, No:32, NameLen:16, Name/binary, X:16, Y:16>>
%     		end
%         end,
%     Mons = [Bin || X <- MonIdList, begin Bin = F(X), Bin /= <<>> end],
%     RespBin = list_to_binary(Mons),
%     <<(length(Mons)):16, RespBin/binary>>.




% %% 打包怪物对话
% pack_mon_talk_list([]) ->
% 	<<0:16, <<>>/binary>>;
% pack_mon_talk_list(MonT) ->
% 	F = fun(Talk) ->
% 				L = byte_size(Talk),
% 				<<L:16, Talk/binary>>
% 		end,
% 	Len = length(MonT),
% 	Bin = list_to_binary([F(T)||T<-MonT]),
% 	<<Len:16, Bin/binary>>.




% %% 打包元素列表
% pack_leave_list([]) ->
%     <<0:16, <<>>/binary>>;
% pack_leave_list(PlayerIdList) ->
%     Rlen = length(User),
%     RB = list_to_binary([<<Id:32>> || Id <- PlayerIdList]),
%     <<Rlen:16, RB/binary>>.


% trans_to_12040(Status) ->
%     [Status#player_status.id
%         ,Status#player_status.guild_star
%         ,Status#player_status.guild_area
%         ,Status#player_status.guild_id
%         ,tool:to_binary(Status#player_status.guild_name)
%     ].

% trans_to_12041(Status) ->
%     CDTime = lib_guild_pvp:get_cd_time(Status#player_status.pvp_cd_tick),
%     InBattle = case lib_player:is_in_battle(Status) of
%         true -> 1;
%         false -> 0
%     end,
%     [Status#player_status.id
%         ,list_to_binary(integer_to_list(Status#player_status.pvp_flag))
%         ,CDTime
%         ,InBattle
%         ,Status#player_status.pvp_camp
%     ].

% % trans_to_12042(Status) ->
% %     [
% %      Status#player_status.id,
% %      Status#player_status.vip,
% %      Status#player_status.current_title
% %     ].
