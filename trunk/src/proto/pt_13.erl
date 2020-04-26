%%%-----------------------------------
%%% @Module  : pt_13
%%% @Author  :
%%% @Email   :
%%% @Created : 2011.04.29
%%% @Description: 13角色信息
%%%-----------------------------------
-module(pt_13).
-export([read/2, write/2]).
-include("common.hrl").
-include("pt_13.hrl").
-include("attribute.hrl").
-include("player.hrl").
-include("goods.hrl").
-include("buff.hrl").
-include("record/goods_record.hrl").
-include("record.hrl").
-include("pt.hrl").
-include("xinfa.hrl").
-include("mount.hrl").
-include("fabao.hrl").
-include("equip.hrl").

% %%
% %%客户端 -> 服务端 ----------------------------
% %%

%% 获取玩家自己的简要信息
read(?PT_PLYR_GET_MY_BRIEF, _) ->
    {ok, dummy};

%% 获取指定玩家的信息详情（只支持获取在线的玩家）
read(?PT_PLYR_GET_INFO_DETAILS, <<TargetId:64>>) ->
    {ok, TargetId};


read(?PT_PLYR_RESET_FREE_TALENT_POINTS, <<>>) ->
    {ok, dummy};
    
read(?PT_PLYR_ALLOT_FREE_TALENT_POINTS, Bin) ->
    <<Count:16, BinLeft/binary>> = Bin,
    case Count > ?TOTAL_TALENT_COUNT of
        true ->
            ?ASSERT(false, Count),
            {error, msg_illegal};
        false ->
            ExpectedSize = 3 * Count,
            case byte_size(BinLeft) == ExpectedSize of
                false ->
                    ?ASSERT(false, Bin),
                    {error, msg_illegal};
                true ->
                    {ElementList, <<>>} = pt:read_array(Bin, [u8, u16]),
                    {ok, ElementList}
            end
    end;


%基金
read(?PT_PLYR_CHECK_FUND, _) ->
    {ok, []};


read(?PT_PLYR_GET_FUND, <<Type:8,Lv:16>>) ->
    {ok, [Type,Lv]};


% --------------------------------经脉------------------------------- %
read(?PT_PLYR_JINGMAI_EXCHANGE, <<Count:8>>) ->
    {ok, [Count]};

read(?PT_SOARING, _) ->
    {ok, []};

read(?PT_PLYR_RESET_JINGMAI_POINT, _) ->
    {ok, []};

read(?PT_PLYR_GET_JINGMAI, _) ->
    {ok, []};

read(?PT_PLYR_SET_JINGMAI, Bin) ->
    <<Count:16, BinLeft/binary>> = Bin,

    ExpectedSize = 3 * Count,
    case byte_size(BinLeft) == ExpectedSize of
        false ->
            ?ASSERT(false, Bin),
            {error, msg_illegal};
        true ->
            {ElementList, <<>>} = pt:read_array(Bin, [u8, u16]),
            {ok, ElementList}
    end;
% ------------------------------------------------------------------ %


%% 手动升级
read(?PT_PLYR_MANUAL_UPGRADE, _) ->
    {ok, dummy};

read(?PT_PLYR_JOIN_FACTION, <<Faction:8>>) ->
    {ok, [Faction]};

read(?PT_PLYR_TRANSFORM_FACTION, <<Faction:8,Sex:8,Race:8>>) ->
    {ok, [Faction,Sex,Race]};

read(?PT_PLYR_GET_LAST_TRANSFORM_TIME,_) ->
    {ok, []};   

read(?PT_PLYR_QUERY_OL_STATE, <<PlayerId:64>>) ->
    {ok, [PlayerId]};


read(?PT_PLYR_GET_EQUIP_INFO, <<PlayerId:64>>) ->
    {ok, [PlayerId]};

read(?PT_PLYR_GET_STOR_HP_MP, _) ->
    {ok, []};

read(?PT_PLYR_SET_AUTO_ADD_HP_MP_STATE, <<Type:8, State:8>>) ->
    {ok, [Type, State]};

read(?PT_PLYR_SET_BUFF_STATE, <<BuffNo:32, OpenState:8>>) ->
    {ok, [BuffNo, OpenState]};

read(?PT_PLYR_SIGN_IN, _) ->
    {ok, []};

read(?PT_PLYR_GET_SIGN_IN_INFO, _) ->
    {ok, []};

read(?PT_PLYR_ASK_FOR_SIGN_IN_REWARD, <<No:32>>) ->
    {ok, [No]};

read(?PT_PLYR_GET_ONLINE_REWARD_INFO, _) ->
    {ok, []};

read(?PT_PLYR_GET_ONLINE_REWARD, <<CurNo:32>>) ->
    {ok, [CurNo]};

read(?PT_PLYR_GET_SEVEN_DAY_REWARD_INFO, _) ->
    {ok, []};

read(?PT_PLYR_GET_LV_REWARD_INFO, _) ->
    {ok, []};    

read(?PT_PLYR_GET_LV_REWARD, <<No:8>>) ->
    {ok, [No]};        

read(?PT_PLYR_GET_SEVEN_DAY_REWARD, <<CurNo:32>>) ->
    {ok, [CurNo]};

read(?PT_PLYR_QRY_MY_OPENED_SYS_LIST, _) ->
    {ok, dummy};

read(?PT_PLYR_SET_CAN_BE_LEADER_STATE, <<State:8>>) ->
    {ok, [State]};

read(?PT_PLYR_SET_TEAM_INVITE_STATE, <<State:8>>) ->
    {ok, [State]};

read(?PT_PLYR_SET_RELA_STATE, <<State:8>>) ->
    {ok, [State]};

read(?PT_PLYR_SET_ACCEPT_PK_STATE, <<State:8>>) ->
    {ok, [State]};

read(?PT_PLYR_SET_SHOWING_EQUIP, <<Type:8, State:8>>) ->
    {ok, [Type, State]};

read(?PT_PLYR_SET_PAODIAN_TYPE, <<Type:32>>) ->
    {ok, [Type]};

read(?PT_PLYR_GET_PAODIAN_TYPE, _) ->
    {ok, []};

read(?PT_PLYR_CHECK_MONTH_CARD, _) ->
    {ok, []};


read(?PT_PLYR_REWARD_MONTH_CARD, <<Type:8>>) ->
    {ok, [Type]};



read(?PT_PLYR_GET_SYS_SET, _) ->
    {ok, []};

read(?PT_PLYR_NOTIFY_VIP, _) ->
    {ok, []};

read(?PT_PLYR_OFFLINE_AWARD_INFO, <<>>) ->
    {ok, []};

read(?PT_PLYR_OFFLINE_AWARD_BEGIN, <<>>) ->
    {ok, []};

read(?PT_PLYR_OFFLINE_AWARD_END, <<UseMoney:8>>) ->
    {ok, [UseMoney]};

read(?PT_PLYR_RECHARGE_STATE, _) ->
    {ok, []};

read(?PT_PLYR_RECHARGE_REWARD_STATE, _) ->
    {ok, []};

read(?PT_PLYR_RECHARGE_REWARD, _) ->
    {ok, []};


read(?PT_PLYR_REQ_JOIN_CRUISE, _) ->
    {ok, dummy};

read(?PT_PLYR_STOP_CRUISE, _) ->
    {ok, dummy};

read(?PT_PLYR_ALL_TITLE, _) ->
    {ok, []};

read(?PT_PLYR_USE_TITLE, <<Title:32>>) ->
    {ok, [Title]};

read(?PT_PLYR_NO_USE_TITLE, <<Title:32>>) ->
    {ok, [Title]};

read(?PT_PLYR_DISPLAY_TITLE, <<Title:32>>) ->
    {ok, [Title]};

read(?PT_PLYR_NO_DISPLAY_TITLE, <<Title:32>>) ->
    {ok, [Title]};


read(?PT_PLYR_C2S_NOTIFY_CRUISE_QUIZ_RES, <<Result:8>>) ->
    {ok, Result};

read(?PT_PLYR_C2S_LOG_PLOT, <<State:8, _/binary>>) ->
    {ok, [?PT_PLYR_C2S_LOG_PLOT, State]};

read(?PT_PLYR_GET_ACCUM_RECHARGE, <<Type:8, _/binary>>) ->
    {ok, [Type]};

read(?PT_PLYR_WORLD_LV_INFO, _) ->
    {ok, []};

read(?PT_PLYR_ALL_ZF, _) ->
    {ok, []};

read(?PT_PLYR_LEARN_ZF, <<No:32>>) ->
    {ok, [No]};

read(?PT_CAN_USE_CASH_COUPON, <<RechargeMon:16, VouchersNo:32>>) ->
    {ok, [RechargeMon, VouchersNo]};

read(?PT_CAN_NOT_USE_CASH_COUPON, <<>>) ->
    {ok, []};

read(?PT_RECHARGE_SUM, <<>>) ->
    {ok, []};

read(?PT_FIRST_RECHARGE_REWARD_ALREADY, <<>>) ->
    {ok, []};


read(?PT_FIRST_RECHARGE_REWARD, <<Money:32>>) ->
    {ok, [Money]};


read(?PT_LOGIN_REWARD, <<>>) ->
    {ok, []};


read(?PT_LOGIN_REWARD_GET, <<>>) ->
    {ok, []};

read(?PT_INFINITE_RESOURCES, <<>>) ->
    {ok, []};

read(?PT_INFINITE_RESOURCES_SUPPLEMENT, <<Type:16, Value:8>>) ->
    {ok, [Type, Value]};


read(?PT_PLYR_CREATE_ROLE_REWARD, <<Type:8>>) ->
    {ok, [Type]};


read(?PT_PLYR_RECHARGE_ACCUMULATED, <<Args:32>>) ->
    {ok, [Args]};


read(?PT_CUSTOM_TITLE_RESET, <<TitleNo:32>>) ->
    {ok, [TitleNo]};


read(?PT_CUSTOM_TITLE_START, <<No:32, Bin/binary>>) ->
    {AttrList, _} = pt:read_array(Bin, [u8]),
    {ok, [No, AttrList]};


read(_Cmd, _R) ->
    ?ASSERT(false, {_Cmd, _R}),
    {error, not_match}.



% %%
% %%服务端 -> 客户端 ------------------------------------
% %%

% 发送自己的加点信息
write(?PT_PLYR_GET_MY_BRIEF, PS) ->
    Bin = build_player_info_brief(PS),
    {ok, pt:pack(?PT_PLYR_GET_MY_BRIEF, Bin)};

% 经脉分配点兑换
write(?PT_PLYR_JINGMAI_EXCHANGE, [Code, Count]) ->
    Bin = <<Code:8, Count:8>>,
    {ok, pt:pack(?PT_PLYR_JINGMAI_EXCHANGE, Bin)};

write(?PT_SOARING, [Code,SoaringLv]) ->
    Bin = <<Code:8,SoaringLv:16>>,
    {ok, pt:pack(?PT_SOARING, Bin)};


write(?PT_PLYR_TRANSFIGURATION, No) ->
    Bin = <<No:32>>,
    {ok, pt:pack(?PT_PLYR_TRANSFIGURATION, Bin)};


    

% 经脉分配点洗点
write(?PT_PLYR_RESET_JINGMAI_POINT, Code) ->
    Bin = <<Code:8>>,
    {ok, pt:pack(?PT_PLYR_RESET_JINGMAI_POINT, Bin)};

% 自己的经脉信息封装
write(?PT_PLYR_GET_JINGMAI, PS) ->
    % 这里要封装
    Bin = build_my_jingmai_infos(PS),
    {ok, pt:pack(?PT_PLYR_GET_JINGMAI, Bin)};

% 经脉分配点洗点
write(?PT_PLYR_SET_JINGMAI, Code) ->
    Bin = <<Code:8>>,
    {ok, pt:pack(?PT_PLYR_SET_JINGMAI, Bin)};


%基金
write(?PT_PLYR_CHECK_FUND, [Datas]) ->
	Len = length(Datas),
	F = fun({Type,L},Acc) ->
      StateLen = length(L),
	  StateBin = 
		  list_to_binary([<<Lv:16,
						  State:8>> || {Lv,State} <- L]),
	  TBin = 
		  <<Type:8,StateLen:16,StateBin/binary>>,
	  [TBin | Acc]
	end,
	BinInfo = list_to_binary(lists:foldl(F, [], Datas)),
    {ok, pt:pack(?PT_PLYR_CHECK_FUND, <<Len:16, BinInfo/binary>>)};

write(?PT_PLYR_GET_FUND, [State]) ->
    {ok, pt:pack(?PT_PLYR_GET_FUND, <<State:8>>)};


write(?PT_PLYR_GET_INFO_DETAILS, PS) ->
    Bin = build_player_info_details(PS),
    {ok, pt:pack(?PT_PLYR_GET_INFO_DETAILS, Bin)};

write(?PT_PLYR_NOTIFY_UPGRADE, [PlayerId, NewLv]) ->
    Bin = <<PlayerId:64, NewLv:16>>,
    {ok, pt:pack(?PT_PLYR_NOTIFY_UPGRADE, Bin)};

write(?PT_PLYR_NOTIFY_MONEY_CHANGE, [MoneyType, NewNum]) ->
    Bin = <<MoneyType:8, NewNum:64>>,
    {ok, pt:pack(?PT_PLYR_NOTIFY_MONEY_CHANGE, Bin)};

write(?PT_PLYR_NOTIFY_INFO_CHANGE, KV_TupleList) ->
    F = fun({ObjInfoCode, Value}) ->
            Value2 = lib_attribute:ajust_value_for_send_to_client(ObjInfoCode, Value),
            ?ASSERT(is_integer(Value2),{ObjInfoCode, Value, Value2}),
            <<ObjInfoCode:16, Value2:32>>
        end,
    Bin = list_to_binary([F(X) || X <- KV_TupleList]),
    Bin2 = <<
            (length(KV_TupleList)) : 16,
             Bin / binary
           >>,
    {ok, pt:pack(?PT_PLYR_NOTIFY_INFO_CHANGE, Bin2)};


write(?PT_PLYR_NOTIFY_INFO_CHANGE_2, KV_TupleList) ->
    F = fun({ObjInfoCode, Value}) ->
            Value2 = lib_attribute:ajust_value_for_send_to_client(ObjInfoCode, Value),
            ?ASSERT(is_integer(Value2),{ObjInfoCode, Value, Value2}),
            <<ObjInfoCode:8, Value2:64>>
        end,
    Bin = list_to_binary([F(X) || X <- KV_TupleList]),
    Bin2 = <<
            (length(KV_TupleList)) : 16,
             Bin / binary
           >>,
    {ok, pt:pack(?PT_PLYR_NOTIFY_INFO_CHANGE_2, Bin2)};


write(?PT_PLYR_JOIN_FACTION, [RetCode, Faction]) ->
    Bin = <<RetCode:8, Faction:8>>,
    {ok, pt:pack(?PT_PLYR_JOIN_FACTION, Bin)};

write(?PT_PLYR_TRANSFORM_FACTION, [RetCode, Faction]) ->
    Bin = <<RetCode:8, Faction:8>>,
    {ok, pt:pack(?PT_PLYR_TRANSFORM_FACTION, Bin)};

write(?PT_PLYR_GET_LAST_TRANSFORM_TIME, [LastTransformTime]) ->
    Bin = <<LastTransformTime:32>>,
    {ok, pt:pack(?PT_PLYR_GET_LAST_TRANSFORM_TIME, Bin)};

    

write(?PT_PLYR_NOTIFY_GAIN_ITEM, [Type, Id, No, Count]) ->
    Bin = <<Type:8, Id:64, No:32, Count:32>>,
    {ok, pt:pack(?PT_PLYR_NOTIFY_GAIN_ITEM, Bin)};


write(?PT_PLYR_NOTIFY_GAIN_MONEY, [Type, Count]) ->
    Bin = <<Type:8, Count:32>>,
    {ok, pt:pack(?PT_PLYR_NOTIFY_GAIN_MONEY, Bin)};


write(?PT_PLYR_QUERY_OL_STATE, [PlayerId, OLState]) ->
    Bin = <<PlayerId:64, OLState:8>>,
    {ok, pt:pack(?PT_PLYR_QUERY_OL_STATE, Bin)};


write(?PT_PLYR_GET_EQUIP_INFO, PS) ->
    Bin = build_player_equip_info(PS),
    {ok, pt:pack(?PT_PLYR_GET_EQUIP_INFO, Bin)};


write(?PT_PLYR_GET_STOR_HP_MP, [PS]) ->
    IsAutoAddHpMp =
        case ply_setting:is_auto_add_store_hp_mp(player:id(PS)) of
            false -> 0;
            true -> 1
        end,
    StoreHp = player:get_store_hp(PS),
    StoreMp = player:get_store_mp(PS),
    StoreHpMpMax = ?STORE_HP_MP_LIM,

    IsAutoAddParHpMp =
        case ply_setting:is_auto_add_store_par_hp_mp(player:id(PS)) of
            false -> 0;
            true -> 1
        end,
    StoreParHp = player:get_store_par_hp(PS),
    StoreParMp = player:get_store_par_mp(PS),
    StoreParHpMpMax = ?STORE_PAR_HP_MP_LIM,
    Bin = <<IsAutoAddHpMp:8, StoreHp:32, StoreMp:32, StoreHpMpMax:32, IsAutoAddParHpMp:8, StoreParHp:32, StoreParMp:32, StoreParHpMpMax:32>>,
    {ok, pt:pack(?PT_PLYR_GET_STOR_HP_MP, Bin)};


write(?PT_PLYR_SET_AUTO_ADD_HP_MP_STATE, [Type, State]) ->
    {ok, pt:pack(?PT_PLYR_SET_AUTO_ADD_HP_MP_STATE, <<Type:8, State:8>>)};


write(?PT_PLYR_BUFF_CHANGE, [BuffNo, LeftTime, OpenState]) ->
    {ok, pt:pack(?PT_PLYR_BUFF_CHANGE, <<BuffNo:32, LeftTime:32, OpenState:8>>)};


write(?PT_PLYR_SET_BUFF_STATE, [RetCode, BuffNo, OpenState]) ->
    {ok, pt:pack(?PT_PLYR_SET_BUFF_STATE, <<RetCode:8, BuffNo:32, OpenState:8>>)};


write(?PT_PLYR_SIGN_IN, [RetCode]) ->
    {ok, pt:pack(?PT_PLYR_SIGN_IN, <<RetCode:8>>)};

write(?PT_PLYR_GET_SIGN_IN_INFO, [SignInfo, RewardInfo]) ->
    {ok, pt:pack(?PT_PLYR_GET_SIGN_IN_INFO, <<SignInfo:32, RewardInfo:32>>)};

write(?PT_PLYR_ASK_FOR_SIGN_IN_REWARD, [RetCode, No]) ->
    {ok, pt:pack(?PT_PLYR_ASK_FOR_SIGN_IN_REWARD, <<RetCode:8, No:32>>)};

write(?PT_PLYR_GET_ONLINE_REWARD_INFO, [CurNo, LastGetTime]) ->
    {ok, pt:pack(?PT_PLYR_GET_ONLINE_REWARD_INFO, <<CurNo:32, LastGetTime:32>>)};

write(?PT_PLYR_GET_ONLINE_REWARD, [RetCode, NextNo, LastGetTime]) ->
    {ok, pt:pack(?PT_PLYR_GET_ONLINE_REWARD, <<RetCode:8, NextNo:32, LastGetTime:32>>)};

write(?PT_PLYR_GET_SEVEN_DAY_REWARD_INFO, [Day, SevenDayReward]) ->
    {ok, pt:pack(?PT_PLYR_GET_SEVEN_DAY_REWARD_INFO, <<Day:8, SevenDayReward:8>>)};

write(?PT_PLYR_GET_SEVEN_DAY_REWARD, [RetCode, SevenDayReward]) ->
    {ok, pt:pack(?PT_PLYR_GET_SEVEN_DAY_REWARD, <<RetCode:8, SevenDayReward:8>>)};

write(?PT_PLYR_GET_LV_REWARD_INFO, [NoList]) ->
    F = fun(X) ->
        <<X:8>>
    end,
    Len = length(NoList),
    Bin = list_to_binary( [F(X) || X <- NoList] ),
    {ok, pt:pack(?PT_PLYR_GET_LV_REWARD_INFO, <<Len:16, Bin/binary>>)};

write(?PT_PLYR_GET_LV_REWARD, [No]) ->
    {ok, pt:pack(?PT_PLYR_GET_LV_REWARD, <<No:8>>)};    

write(?PT_PLYR_NOTIFY_BTL_FEEDBACK, [PlayerId, WinState, MonId, MonLeftCanBeKilledTimes, RewardList]) ->
    F = fun({GoodsId, GoodsNo, GoodsNum}) ->
        GoodsQua =
            case GoodsId =:= ?INVALID_ID of
                true -> 0;
                false -> mod_inv:get_goods_quality_by_id(PlayerId, GoodsId)
            end,
        <<GoodsId:64, GoodsNo:32, GoodsNum:32, GoodsQua:8>>
    end,
    Bin = list_to_binary( [F(X) || X <- RewardList] ),
    Bin2 = <<
                WinState : 8,
                MonId : 32,
                MonLeftCanBeKilledTimes : 16,
                (length(RewardList)) : 16,
                Bin / binary
           >>,
    {ok, pt:pack(?PT_PLYR_NOTIFY_BTL_FEEDBACK, Bin2)};

write(?PT_PLYR_QRY_MY_OPENED_SYS_LIST, SysCodeList) ->
    Bin = list_to_binary( [<<X:8>> || X <- SysCodeList] ),
    ?TRACE("PT_PLYR_QRY_MY_OPENED_SYS_LIST, Bin:~w~n", [Bin]),
    Bin2 = <<
                (length(SysCodeList)) : 16,
                Bin / binary
           >>,
    {ok, pt:pack(?PT_PLYR_QRY_MY_OPENED_SYS_LIST, Bin2)};

write(?PT_PLYR_NOTIFY_NEW_SYS_OPEN, SysCode) ->
    Bin = <<SysCode:8>>,
    {ok, pt:pack(?PT_PLYR_NOTIFY_NEW_SYS_OPEN, Bin)};


write(?PT_PLYR_SET_CAN_BE_LEADER_STATE, [State]) ->
    Bin = <<State:8>>,
    {ok, pt:pack(?PT_PLYR_SET_CAN_BE_LEADER_STATE, Bin)};


write(?PT_PLYR_SET_TEAM_INVITE_STATE, [State]) ->
    Bin = <<State:8>>,
    {ok, pt:pack(?PT_PLYR_SET_TEAM_INVITE_STATE, Bin)};


write(?PT_PLYR_SET_RELA_STATE, [State]) ->
    Bin = <<State:8>>,
    {ok, pt:pack(?PT_PLYR_SET_RELA_STATE, Bin)};


write(?PT_PLYR_SET_ACCEPT_PK_STATE, [State]) ->
    Bin = <<State:8>>,
    {ok, pt:pack(?PT_PLYR_SET_ACCEPT_PK_STATE, Bin)};

write(?PT_PLYR_SET_SHOWING_EQUIP, [Type, State]) ->
    {ok, pt:pack(?PT_PLYR_SET_SHOWING_EQUIP, <<Type:8, State:8>>)};

    
write(?PT_PLYR_SET_PAODIAN_TYPE, [Type]) ->
    Bin = <<Type:32>>,
    {ok, pt:pack(?PT_PLYR_SET_PAODIAN_TYPE, Bin)};



write(?PT_PLYR_GET_SYS_SET, InfoList) ->
    F = fun({Type, State}) ->
        <<Type:8, State:8>>
    end,
    Bin = list_to_binary( [F(X) || X <- InfoList] ),
    Bin2 = <<
                (length(InfoList)) : 16,
                Bin / binary
           >>,
    {ok, pt:pack(?PT_PLYR_GET_SYS_SET, Bin2)};

write(?PT_PLYR_NOTIFY_VIP, [VipLv, VipExp]) ->
    Bin = <<VipLv:8, VipExp:32>>,
    {ok, pt:pack(?PT_PLYR_NOTIFY_VIP, Bin)};


write(?PT_PLYR_VIP_ACTIVED, [VipLv]) ->
    {ok, pt:pack(?PT_PLYR_VIP_ACTIVED, <<VipLv:8>>)};

write(?PT_PLYR_VIP_EXPERIENCE, [XP]) ->
    {ok, pt:pack(?PT_PLYR_VIP_EXPERIENCE, <<XP:8>>)};

write(?PT_PLYR_OFFLINE_AWARD_STATE, [State, Second, PlayerExp, PartnerExp, Cost]) ->
    Bin = <<State:8, Second:32, PlayerExp:32, PartnerExp:32, Cost:32>>,
    {ok, pt:pack(?PT_PLYR_OFFLINE_AWARD_STATE, Bin)};

write(?PT_PLYR_RECHARGE_STATE, [ListAlr, List]) ->
    LenAlr = erlang:length(ListAlr),
    BinAlr = << <<No:16>> || No <- ListAlr >>,

    Len = erlang:length(List),
    Bin = << <<No:16, State:8, Days:16>> || {No, State, Days} <- List >>,

    ?DEBUG_MSG("ListAlr=~p,LenAlr=~p,BinAlr=~p",[ListAlr,LenAlr,BinAlr]),

    {ok, pt:pack(?PT_PLYR_RECHARGE_STATE, <<LenAlr:16,BinAlr/binary, Len:16, Bin/binary>>)};

write(?PT_PLYR_RECHARGE_REWARD_STATE, [State]) ->
    {ok, pt:pack(?PT_PLYR_RECHARGE_REWARD_STATE, <<State:8>>)};

% write(?PT_PLYR_RECHARGE_REWARD, [])


write(?PT_PLYR_REQ_JOIN_CRUISE, [RetCode, DiffTime]) ->
    Bin = <<RetCode:8, DiffTime:16>>,
    {ok, pt:pack(?PT_PLYR_REQ_JOIN_CRUISE, Bin)};

write(?PT_PLYR_STOP_CRUISE, [RetCode]) ->
    Bin = <<RetCode:8>>,
    {ok, pt:pack(?PT_PLYR_STOP_CRUISE, Bin)};

write(?PT_PLYR_NOTIFY_CRUISE_FINISH, _) ->
    Bin = <<>>,
    {ok, pt:pack(?PT_PLYR_NOTIFY_CRUISE_FINISH, Bin)};


write(?PT_PLYR_NOTIFY_CRUISE_EVENT_TRIGGERED, [NpcId, EventNo, QuestionNo, X, Y]) ->
    Bin = <<NpcId:32, EventNo:16, QuestionNo:16, X:16, Y:16>>,
    {ok, pt:pack(?PT_PLYR_NOTIFY_CRUISE_EVENT_TRIGGERED, Bin)};

write(?PT_PLYR_RECHARGE_REWARD, [State]) ->
    {ok, pt:pack(?PT_PLYR_RECHARGE_REWARD, <<State:8>>)};

write(?PT_PLYR_ALL_TITLE, [IDs, UserDefs, DiyTitles]) ->
    Len0 = length(IDs),
    BinTail0 =
        lists:foldl(
            fun({Id, Et, Al}, Ba) ->
                Ba2 = <<Id:32, Et:32>>,
                Len01 = erlang:length(Al),
                Ba3 = lists:foldl(
                    fun(Ar1, Bincc) ->
                        Bincc2 = <<Ar1:8>>,
                        <<Bincc/binary, Bincc2/binary>>
                    end, <<Len01:16>>, Al),
                <<Ba/binary,Ba2/binary,Ba3/binary>>
            end, <<Len0:16>>, IDs),
    Len1 = length(UserDefs),
    Bin1 = list_to_binary([<<I:32, ?P_BITSTR(S)>> || {I, S} <- UserDefs]),
    Len2 = erlang:length(DiyTitles),
    BinTail =
        lists:foldl(
            fun({No, AttrList}, BinAcc) ->
                BinAcc2 = <<No:16>>,
                Len3 = erlang:length(AttrList),
                BinAcc3 = lists:foldl(
                    fun({Name, Attr1, Attr2}, BinInsideAcc) ->
                        Name1 = atom_to_list(Name),
                        Name2 = list_to_binary(Name1),
                        L = byte_size(Name2),
                        Attr3 = util:ceil(Attr1*1000),
                        Attr4 = util:ceil(Attr2*1000),
                        BinInsideAcc2 = << L:16, Name2/binary, Attr3:32, Attr4:32>>,
                        <<BinInsideAcc/binary, BinInsideAcc2/binary>>
                    end, <<Len3:16>>, AttrList),
                <<BinAcc/binary,BinAcc2/binary,BinAcc3/binary>>
            end, <<Len2:16>>, DiyTitles),
    {ok, pt:pack(?PT_PLYR_ALL_TITLE, <<BinTail0/binary, Len1:16, Bin1/binary, BinTail/binary>>)};

write(?PT_PLYR_CHECK_MONTH_CARD, [Datas]) ->
	Len = length(Datas),
    Bin = list_to_binary([<<Type:8, Day:32, State:8>> || {Type, Day, State} <- Datas]),
    {ok, pt:pack(?PT_PLYR_CHECK_MONTH_CARD, <<Len:16, Bin/binary>>)};

write(?PT_PLYR_REWARD_MONTH_CARD, [State]) ->
    {ok, pt:pack(?PT_PLYR_REWARD_MONTH_CARD, <<State:8>>)};


write(?PT_PLYR_GET_ACCUM_RECHARGE, [Type, Num]) ->
    {ok, pt:pack(?PT_PLYR_GET_ACCUM_RECHARGE, <<Type:8, Num:32>>)};


write(?PT_PLYR_WORLD_LV_INFO, [CurLv, OpenStamp, Exp]) ->
    {ok, pt:pack(?PT_PLYR_WORLD_LV_INFO, <<CurLv:16, OpenStamp:32, Exp:64>>)};

write(?PT_PLYR_ALL_ZF, [ZFs]) ->
    Len = length(ZFs), 
    Bin = list_to_binary([<<ZF:32>> || ZF <- ZFs]),
    {ok, pt:pack(?PT_PLYR_ALL_ZF, <<Len:16, Bin/binary>>)};

write(?PT_PLYR_LEARN_ZF, [RetCode, No]) ->
    Bin = <<RetCode:8, No:32>>,
    {ok, pt:pack(?PT_PLYR_LEARN_ZF, Bin)};

write(?PT_CAN_USE_CASH_COUPON, [RetCode]) ->
    Bin = <<RetCode:8>>,
    {ok, pt:pack(?PT_CAN_USE_CASH_COUPON, Bin)};

write(?PT_RECHARGE_SUM, [Money]) ->
    Bin = <<Money:32>>,
    {ok, pt:pack(?PT_RECHARGE_SUM, Bin)};

write(?PT_FIRST_RECHARGE_REWARD_ALREADY, [RewardList]) ->
    Len = length(RewardList),
    Bin = list_to_binary([<<Money:32, Day:8, LastUnixtime:32>> || {Money, Day, LastUnixtime} <- RewardList]),
    {ok, pt:pack(?PT_FIRST_RECHARGE_REWARD_ALREADY, <<Len:16, Bin/binary>>)};

write(?PT_FIRST_RECHARGE_REWARD, [Money]) ->
    Bin = <<Money:32>>,
    {ok, pt:pack(?PT_FIRST_RECHARGE_REWARD, Bin)};

write(?PT_LOGIN_REWARD, [Days, Unixtime]) ->
    Bin = <<Days:32, Unixtime:32>>,
    {ok, pt:pack(?PT_LOGIN_REWARD, Bin)};

write(?PT_LOGIN_REWARD_GET, [Days, Unixtime]) ->
    Bin = <<Days:32, Unixtime:32>>,
    {ok, pt:pack(?PT_LOGIN_REWARD_GET, Bin)};

write(?PT_PLYR_NOTIFY_PEAK_UPGRADE, [PlayerId, NewLv]) ->
    Bin = <<PlayerId:64, NewLv:16>>,
    {ok, pt:pack(?PT_PLYR_NOTIFY_PEAK_UPGRADE, Bin)};

write(?PT_INFINITE_RESOURCES, [Data]) ->
    MoneyType0 = data_special_config:get(unlimit_money_type),
    MoneyType = tuple_to_list(MoneyType0),


    F = fun(X , Acc) ->
        case lists:member(X, Data) of
            true ->
                [<<X:16, 1:8>>| Acc];
            false ->
                [<<X:16, 0:8>>| Acc]
        end
        end,
    Bin0 = lists:foldl(F, [] , MoneyType),
    Len = length(Bin0),
    Bin = list_to_binary(Bin0),
    {ok, pt:pack(?PT_INFINITE_RESOURCES,  <<Len:16, Bin/binary>>)};

write(?PT_PLYR_CREATE_ROLE_REWARD, [State]) ->
  {ok, pt:pack(?PT_PLYR_CREATE_ROLE_REWARD,  <<State:8>>)};


write(?PT_CUSTOM_TITLE_RESET, [State,Ig]) ->
	{ok, pt:pack(?PT_CUSTOM_TITLE_RESET,  <<State:8,Ig:32>>)};


write(?PT_PLYR_RECHARGE_ACCUMULATED, [Moneys]) ->
	Len = length(Moneys),
    Bin = list_to_binary([<<Money:32>> || Money <- Moneys]),
    {ok, pt:pack(?PT_PLYR_RECHARGE_ACCUMULATED, <<Len:16, Bin/binary>>)};


write(?PT_CUSTOM_TITLE_START, [Count,No,Difficult]) ->
    Len = erlang:length(Difficult),
    F = fun(State) ->
        <<State:8>>
        end,
    BinData = list_to_binary([F(X) || X <- Difficult]),
    {ok, pt:pack(?PT_CUSTOM_TITLE_START, <<Count:8, No:32, Len:16, BinData/binary >>)};


write(_Cmd, _R) ->
	?ASSERT(false, {_Cmd, _R}),
    {error, not_match}.



%% ================================ Local Functions ======================================
%% 构造玩家的经脉信息
build_my_jingmai_infos(PS) ->
    % PlayerId = player:get_id(PS),
    JingmaiInfos = player:get_jingmai_infos(PS),
    JingmaiPoint = player:get_jingmai_point(PS),

    F = fun({No,Point},Acc) ->
        [<<No:8,Point:16>> | Acc]
    end,

    F1 = fun({_No,Point},Acc) ->
        Point + Acc
    end,

    % 使用的点数
    UsePoint = lists:foldl(F1,0,JingmaiInfos),

    % 封装
    JingmaiInfosList = lists:foldl(F,[],JingmaiInfos),
    JingmaiInfosBin = list_to_binary(JingmaiInfosList),

    JingmaiInfosBin1 = <<(length(JingmaiInfos)):16, JingmaiInfosBin/binary>>,

    <<
        JingmaiPoint:16,
        (JingmaiPoint - UsePoint):16,
        JingmaiInfosBin1/binary
    >>.



%% 构造玩家的简要信息
build_player_info_brief(PS) ->
    PlayerId = player:get_id(PS),
    Pos = player:get_position(PlayerId),
    SceneId = Pos#plyr_pos.scene_id,
    ?ASSERT(lib_scene:is_exists(SceneId), {PlayerId, SceneId}),
    SceneNo = lib_scene:get_no_by_id(SceneId),
    GuildName = ply_guild:get_guild_name(PS),
    GuildChiefId = ply_guild:get_guild_chief_id(PS),

    GraphTitle = player:get_graph_title(PS),
    TextTitle = player:get_text_title(PS),
    UserDefTitle = player:get_user_def_title(PS),

    ?ASSERT(is_binary(GuildName)),

    ShowEquips = player:get_showing_equips(PS),
    BackWear = ShowEquips#showing_equip.backwear,
    Weapon = ShowEquips#showing_equip.weapon,
    Headwear = ShowEquips#showing_equip.headwear,
    Clothes = ShowEquips#showing_equip.clothes,
    MagicKey = ShowEquips#showing_equip.magic_key,
    % 妖将信息
    PartnerId = mod_partner:get_main_partner_id(PS),
    Partner = lib_partner:get_partner(PartnerId),

    {PartnerNo, ParWeapon, EvolveLv, ParName, CultivateLv, CultivateLayer, ParQuality, ParClothes, ParAwakeIllusiond} =
    case Partner =:= null of
        true -> {?INVALID_NO, ?INVALID_NO, 0, <<>>, 0, 0, ?QUALITY_INVALID, ?INVALID_NO, ?INVALID_NO};
        false ->
            ParShowEquips = lib_partner:get_showing_equips(Partner),
            {
            lib_partner:get_no(Partner),
            ParShowEquips#showing_equip.weapon,
            lib_partner:get_evolve_lv(Partner),
            lib_partner:get_name(Partner),
            lib_partner:get_cultivate_lv(Partner),
            lib_partner:get_cultivate_layer(Partner),
            lib_partner:get_quality(Partner),
            ParShowEquips#showing_equip.clothes,
			lib_partner:get_awake_illusion(Partner)
            }
    end,

    %% 跟随女妖的信息
    {FPartnerNo, FParWeapon, FParEvolveLv, FParName, FParCultivateLv, FParCultivateLayer, FParQuality, FParClothes, FParAwakeIllusiond} =
    case player:get_follow_partner_id(PS) of
        ?INVALID_ID -> {?INVALID_NO, ?INVALID_NO, 0, <<>>, 0, 0, ?QUALITY_INVALID, ?INVALID_NO, ?INVALID_NO};
        FParId ->
            case lib_partner:get_partner(FParId) of
                null -> {?INVALID_NO, ?INVALID_NO, 0, <<>>, 0, 0, ?QUALITY_INVALID, ?INVALID_NO, ?INVALID_NO};
                FPartner ->
                    FParShowEquips = lib_partner:get_showing_equips(FPartner),
                    {
                    lib_partner:get_no(FPartner),
                    FParShowEquips#showing_equip.weapon,
                    lib_partner:get_evolve_lv(FPartner),
                    lib_partner:get_name(FPartner),
                    lib_partner:get_cultivate_lv(FPartner),
                    lib_partner:get_cultivate_layer(FPartner),
                    lib_partner:get_quality(FPartner),
                    case ply_setting:is_par_clothes_hide(PlayerId) of
                        true -> ?INVALID_NO;
                        false -> FParShowEquips#showing_equip.clothes
                    end,
					lib_partner:get_awake_illusion(FPartner)
                    }
            end
    end,

    BuffList = mod_buff:get_buff_list(player, PlayerId),
    F = fun(X) ->
        <<(X#buff.no):32, (X#buff.left_time):32, (X#buff.open_state):8>>
    end,
    BuffBin = list_to_binary([F(X) || X <- BuffList]),
    BuffBin1 = <<(length(BuffList)):16, BuffBin/binary>>,
    ?TRACE("PartnerNo:~p, ParWeapon:~p, EvolveLv:~p, BuffList:~p~n", [PartnerNo, ParWeapon, EvolveLv, BuffList]),
    % GuildContri = ply_guild:get_player_cur_contri(PS),
    GuildContri = player:get_guild_contri(PS),

	CurBattleId = 
		case lib_cross:check_is_remote() of
			?false ->
				case player:get_cur_battle_pid(PS) of
					null ->
						?INVALID_ID;
					BattlePid when is_pid(BattlePid) ->
						case erlang:is_process_alive(BattlePid) of
							true -> player:get_cur_battle_id(PS);
							false -> ?INVALID_ID
						end;
					_Any ->
						?ASSERT(false, {_Any, PS}),
						?INVALID_ID
				end;
			?true ->
				player:get_cur_battle_id(PS)
		end,
    IsLeader =
        case player:is_leader(PS) of
            true -> 1;
            false -> 0
        end,
    SpouseId = ply_relation:get_spouse_id(PlayerId),
    SpouseName = case SpouseId =:= ?INVALID_ID of true -> <<>>; false -> player:get_name(SpouseId) end,

    {MountNo, MountStep} = 
        case player:get_mount(PS) of
            ?INVALID_ID -> {?INVALID_NO, ?INVALID_NO};
            MountId ->
                case lib_mount:get_mount(MountId) of
                    null -> {?INVALID_NO, ?INVALID_NO};
                    Mount -> {Mount#ets_mount.no, Mount#ets_mount.step}
                end
        end,
    SkinInfo = lib_mount:get_skins(PlayerId),
    SkinNo = SkinInfo#mount_skin_info.wear_skin_no,
	HasHome = case lib_home:has_home(PS) of
				  ?true ->
					  1;
				  ?false ->
					  0
			  end,
	CrossState = 
		case lib_cross:check_is_remote() of
			?true ->
				?CROSS_STATE_REMOTE;
			?false ->
				?CROSS_STATE_LOCAL
		end,
    WingNo =lib_wing:get_use_wing_no(PlayerId),
    ExpLim = case player:get_peak_lv(PS) > 0 of
                 true -> player:get_peak_exp_lim(PS);
                 false -> player:get_exp_lim(PS)
             end,
    PlayerMisc = ply_misc:get_player_misc(PlayerId),
    FabaoDisplayer =  PlayerMisc#player_misc.fabao_displayer,
    FabaoDegree =  PlayerMisc#player_misc.fabao_degree,
    SpecialNos = PlayerMisc#player_misc.fabao_special,
    SpecialNosLen = length(SpecialNos),
    SpecialNosFun = fun(SpecialNo) ->
        <<SpecialNo:32>>
                    end,
    FaBaoBattleNo = case lib_fabao:get_fabao_battle(PlayerId) of
                        [] -> 0;
                        FaBaoId ->
                            case lib_fabao:get_fabao_info(FaBaoId) of
                                [] -> 0;
                                FaBaoInfo -> FaBaoInfo#fabao_info.no
                            end
                    end,
    SpecialNosBin = list_to_binary([SpecialNosFun(SpecialNoX) || SpecialNoX <- SpecialNos]),
    FashionInfo = mod_strengthen:get_fashions(PlayerId),
    FashionNo = FashionInfo#equip_fashion_info.wear_fashion_no,
    <<
        SceneId : 32,
        SceneNo : 32,
        (Pos#plyr_pos.x) : 16,
        (Pos#plyr_pos.y) : 16,
        (player:get_hp_lim(PS)) : 32,
        (player:get_hp_lim(PS)) : 32,
        (player:get_mp(PS)) : 32,
        (player:get_mp_lim(PS)) : 32,
        (player:get_exp(PS)) : 32,
        (ExpLim) : 32,
        (player:get_yuanbao(PS)) : 32,
        (player:get_bind_yuanbao(PS)) : 32,
        (player:get_gamemoney(PS)) : 64,
        (player:get_bind_gamemoney(PS)) : 32,
        (player:get_feat(PS)) : 32,
        (player:get_move_speed(PS)) : 16,
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
        EvolveLv:8,
        CultivateLv:8,
        CultivateLayer:8,
        ParQuality:8,
        ParClothes:32,
		ParAwakeIllusiond:8,
        BuffBin1/binary,
        GuildContri:32,
        (byte_size(ParName)) : 16,
        ParName / binary,
        CurBattleId : 32,
        (player:get_vip_lv(PS)) : 8,
        (player:get_literary(PS)) : 32,
        IsLeader : 8,
        (player:get_team_id(PS)) : 32,
        FPartnerNo : 32,
        FParWeapon : 32,
        FParEvolveLv : 8,
        FParCultivateLv : 8,
        FParCultivateLayer : 8,
        FParQuality : 8,
        (byte_size(FParName)) : 16,
        FParName / binary,
        FParClothes : 32,
		FParAwakeIllusiond:8,
        (ply_priv:get_priv_lv(PS)) : 8,
        GuildChiefId : 64,
        (SpouseId) : 64,
        (byte_size(SpouseName)) : 16,
        SpouseName / binary,
        (lib_equip:get_free_stren_cnt(PS)) : 8,
        (player:get_contri(PS)) : 32,
        MagicKey : 32,
        MountNo : 32,
        SkinNo : 16,
        MountStep : 8,
        (player:get_copper(PS)) : 32,
        (player:get_vitality(PS)) : 32,
        (player:get_chivalrous(PS)) :32,
        (player:get_popular(PS)):32,
        (player:get_chip(PS)):32,
        (player:get_soaring(PS)) : 16,
        (player:get_transfiguration_no(PS)) : 32,
		(player:get_integral(PS)) : 32,
        (ply_setting:get_paodian_type(PlayerId)) : 32,
		HasHome : 8,
        (player:get_jingwen(PS)) :32,
		CrossState : 8,
        (player:get_dan(PS)):8,
        WingNo:32,
        (player:get_mijing(PS)) : 32,
        (player:get_huanjing(PS)) : 32,
        (player:get_reincarnation(PS)) : 32,
        (player:get_peak_lv(PS)) : 16,
        FabaoDisplayer: 32 ,
        FabaoDegree:32,
        SpecialNosLen:16,
        SpecialNosBin/binary,
        FaBaoBattleNo:32,
        (ply_title:get_show_graph_title(PlayerId)) : 32,
        (ply_title:get_show_text_title(PlayerId)) : 32,
        FashionNo: 16
    >>.


%% 构造玩家的详细信息
build_player_info_details(PS) ->
    PlayerId = player:get_id(PS),

    % Phy_crit = (player:get_phy_crit(PS)),
    % Phy_ten = (player:get_phy_ten(PS)),
    % Mag_crit = (player:get_mag_crit(PS)),
    % Mag_ten = (player:get_mag_ten(PS)),
    % Phy_crit_coef = (player:get_phy_crit_coef(PS)),
    % Mag_crit_coef = (player:get_mag_crit_coef(PS)),

    % ?DEBUG_MSG("ps=~p,Phy_crit=~p,Phy_ten=~p,Mag_crit=~p,Mag_ten=~p,Phy_crit_coef=~p,Mag_crit_coef=~p",[PS,Phy_crit,Phy_ten,Mag_crit,Mag_ten,Phy_crit_coef,Mag_crit_coef]),

    % ?DEBUG_MSG("(player:get_phy_att(PS)) : ~p,
    %     (player:get_mag_att(PS)) : ~p,
    %     (player:get_phy_def(PS)) : ~p,
    %     (player:get_mag_def(PS)) : ~p,
    %     ",[player:get_phy_att(PS),player:get_mag_att(PS),player:get_phy_def(PS),player:get_mag_def(PS)]),

    % ?DEBUG_MSG("(player:get_seal_hit(PS)) : ~p, 
    %     (player:get_seal_resis(PS)) : ~p,
    %     (player:get_act_speed(PS)) : ~p,
    %     ,player:get_heal_value(PS) : ~p
    %     ",[player:get_seal_hit(PS),player:get_seal_resis(PS),player:get_act_speed(PS),player:get_heal_value(PS)]),


    % ?DEBUG_MSG("(player:get_phy_crit(PS)) : ~p,
    %     (player:get_phy_ten(PS)) : ~p,
    %     (player:get_mag_crit(PS)) : ~p,
    %     (player:get_mag_ten(PS)) : ~p,
    %     (player:get_phy_crit_coef(PS)) : ~p,
    %     (player:get_mag_crit_coef(PS)) : ~p,
    %     ",[
    %     player:get_phy_crit(PS),player:get_phy_ten(PS),player:get_mag_crit(PS),player:get_mag_ten(PS)
    %     ,player:get_phy_crit_coef(PS),player:get_mag_crit_coef(PS)]),
    ExpLim = case player:get_peak_lv(PS) > 0 of
                 true -> player:get_peak_exp_lim(PS);
                 false -> player:get_exp_lim(PS)
             end,

    ?DEBUG_MSG("wjcTestpt_13 ~p~n",[{PlayerId,(player:get_race(PS)),(player:get_faction(PS)),(player:get_sex(PS)),(player:get_lv(PS)),(player:get_exp(PS)),(ExpLim),(player:get_hp(PS)),(player:get_hp_lim(PS)),(player:get_mp(PS)),(player:get_mp_lim(PS)),
        (player:get_phy_att(PS)),(player:get_mag_att(PS)),(player:get_phy_def(PS)),(player:get_mag_def(PS)),(player:get_hit(PS)),(player:get_dodge(PS)),(player:get_crit(PS)),(player:get_ten(PS)),
        (player:get_anger(PS)),(player:get_anger_lim(PS)),(player:get_luck(PS)),(player:get_act_speed(PS)),(player:get_move_speed(PS)),(player:get_total_str(PS)),(player:get_total_con(PS)),(player:get_total_stam(PS)),(player:get_total_spi(PS)),(player:get_total_agi(PS)),
        (player:get_free_talent_points(PS)),(ply_attr:get_battle_power(PS)),(player:get_guild_id(PS)),(player:get_seal_hit(PS)),(player:get_seal_resis(PS)),(player:get_contri(PS)),(player:get_frozen_hit(PS)),
        (player:get_frozen_resis(PS)),(player:get_chaos_hit(PS)),(player:get_chaos_resis(PS)),(player:get_trance_hit(PS)),(player:get_trance_resis(PS)),(player:get_phy_crit(PS)),(player:get_phy_ten(PS)),
        (player:get_mag_crit(PS)),(player:get_mag_ten(PS)),(player:get_phy_crit_coef(PS)),(player:get_mag_crit_coef(PS)),(player:get_heal_value(PS)),(player:get_popular(PS))}]),

    <<
        PlayerId : 64,
        (player:get_race(PS)) : 8,
        (player:get_faction(PS)) : 8,
        (player:get_sex(PS)) : 8,
        (player:get_lv(PS)) : 16,
        (player:get_exp(PS)) : 32,
        (ExpLim) : 32,

        (player:get_hp_lim(PS)) : 32,
        (player:get_hp_lim(PS)) : 32,
        (player:get_mp(PS)) : 32,
        (player:get_mp_lim(PS)) : 32,

        (player:get_phy_att(PS)) : 32,
        (player:get_mag_att(PS)) : 32,
        (player:get_phy_def(PS)) : 32,
        (player:get_mag_def(PS)) : 32,

        (player:get_hit(PS)) : 32,
        (player:get_dodge(PS)) : 32,
        (player:get_crit(PS)) : 32,
        (player:get_ten(PS)) : 32,

        (player:get_anger(PS)) : 32,
        (player:get_anger_lim(PS)) : 32,
        (player:get_luck(PS)) : 32,
        (player:get_act_speed(PS)) : 32,
        (player:get_move_speed(PS)) : 16,

        (util:ceil(player:get_base_str(PS))) : 16,
        (util:ceil(player:get_base_con(PS))) : 16,
        (util:ceil(player:get_base_stam(PS))) : 16,
        (util:ceil(player:get_base_spi(PS))) : 16,
        (util:ceil(player:get_base_agi(PS))) : 16,

        (player:get_free_talent_points(PS)) : 16,
        (ply_attr:get_battle_power(PS)) : 32,
        (player:get_guild_id(PS)) : 64,
        (player:get_seal_hit(PS)) : 32,
        (player:get_seal_resis(PS)) : 32,
        (player:get_contri(PS)) : 32,
        (player:get_frozen_hit(PS)) : 32,
        (player:get_frozen_resis(PS)) : 32,
        (player:get_chaos_hit(PS)) : 32,
        (player:get_chaos_resis(PS)) : 32,
        (player:get_trance_hit(PS)) : 32,
        (player:get_trance_resis(PS)) : 32,
        (util:ceil(player:get_phy_crit(PS))) : 32,
        (util:ceil(player:get_phy_ten(PS))) : 32,
        (util:ceil(player:get_mag_crit(PS))) : 32,
        (util:ceil(player:get_mag_ten(PS))) : 32,
        (player:get_phy_crit_coef(PS)) : 32,
        (player:get_mag_crit_coef(PS)) : 32,
        (player:get_popular(PS)) : 32,
        (util:floor(PS#player_status.total_attrs#attrs.phy_combo_att_proba)) : 32,
        (util:floor(PS#player_status.total_attrs#attrs.strikeback_proba)) : 32,
        (util:floor(PS#player_status.total_attrs#attrs.mag_combo_att_proba)) : 32,
        (util:floor(PS#player_status.total_attrs#attrs.neglect_phy_def)) : 32,
        (util:floor(PS#player_status.total_attrs#attrs.neglect_mag_def)) : 32,
        (util:floor(PS#player_status.total_attrs#attrs.be_phy_dam_reduce_coef*1000)) : 32,
        (util:floor( PS#player_status.total_attrs#attrs.be_mag_dam_reduce_coef*1000)) : 32,
        (util:floor(PS#player_status.total_attrs#attrs.neglect_seal_resis)) : 32,
        (util:floor(PS#player_status.total_attrs#attrs.ret_dam_proba)) : 32,
        (util:floor(PS#player_status.total_attrs#attrs.ret_dam_coef * 1000 )) : 32,
        (util:floor(PS#player_status.total_attrs#attrs.neglect_ret_dam)) : 32,
        (util:floor(PS#player_status.total_attrs#attrs.do_phy_dam_scaling * 1000)) : 32,
        (util:floor(PS#player_status.total_attrs#attrs.do_mag_dam_scaling * 1000)) : 32,
        (util:floor(PS#player_status.total_attrs#attrs.pursue_att_proba * 1000)) : 32,
        (util:floor(PS#player_status.total_attrs#attrs.absorb_hp_coef * 1000)) : 32
        
    >>.


build_player_equip_info(PS) ->
    PlayerId = player:get_id(PS),
    EquipList = mod_equip:get_player_equip_list(PlayerId),

    F = fun(Goods) ->
        <<
            (lib_goods:get_id(Goods)) : 64,
            (lib_goods:get_no(Goods)) : 32,
            (lib_goods:get_slot(Goods)) : 8,
            (lib_goods:get_bind_state(Goods)) : 8,
            (lib_goods:get_quality(Goods)) : 8,
            ( (lib_goods:get_equip_prop(Goods))#equip_prop.stren_lv ) : 8
        >>
    end,
    List = lists:map(F, EquipList),
    Len = length(List),
    Bin = list_to_binary(List),

    ParIdList = player:get_partner_id_list(PS),
    LenPar = length(ParIdList),
    ListPar = lists:map(fun(Id) -> <<Id:64>> end, ParIdList),
    BinParId = list_to_binary(ListPar),

    XinfaList = ply_xinfa:get_player_xinfa_brief_list(player:id(PS)),
    LenXinfa = length(XinfaList),
    BinXinfa = list_to_binary(lists:map(fun(XinfaBrief) -> <<(XinfaBrief#xinfa_brief.id):32, (XinfaBrief#xinfa_brief.lv):8>> end, XinfaList)),

    <<
        PlayerId : 64,
        (player:get_lv(PS)) : 16,
        (player:get_race(PS)) : 8,
        (player:get_sex(PS)) : 8,
        (player:get_faction(PS)) : 8,
        (ply_attr:get_battle_power(PS)) : 32,
        (byte_size(player:get_name(PS))) : 16,
        (player:get_name(PS)) / binary,
        Len : 16,
        Bin / binary,
        LenPar : 16,
        BinParId / binary,
        LenXinfa : 16,
        BinXinfa / binary
    >>.