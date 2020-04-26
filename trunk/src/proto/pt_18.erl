-module(pt_18).

-include("pt_18.hrl").
-include("debug.hrl").
-include("mount.hrl").
-include("skill.hrl").
-include("record/goods_record.hrl").
-include("abbreviate.hrl").

-export([read/2, write/2]).

read(?PT_GET_MOUNT, _) ->
	{ok, []};

read(?PT_ONOFF_MOUNT, <<MountId:64, IsOn:8>>) ->
	{ok, [MountId, IsOn]};

read(?PT_RENAME_MOUNT, <<MountId:64, NewName/binary>>) ->
	{NewName1, _} = pt:read_string(NewName),
	{ok, [MountId, NewName1]};

read(?PT_RESET_ATTR_MOUNT, <<MountId:64, ResetType:8, Times:8>>) ->
	{ok, [MountId, ResetType, Times]};

read(?PT_SET_ATTR_MOUNT, <<MountId:64, AttributeNo1:8, AttributeNo2:8,AttributeNo3:8, AttributeAddRatio1:16, AttributeAddRatio2:16, AttributeSubRatio:16>>) ->
	{ok, [MountId, AttributeNo1, AttributeNo2, AttributeNo3, AttributeAddRatio1, AttributeAddRatio2, AttributeSubRatio]};

read(?PT_FEED_MOUNT, <<MountId:64, Feed:32,FeedCount:32>>) ->
	{ok, [MountId, Feed,FeedCount]};

read(?PT_INHERITANCE_MOUNT, <<Type:8, LeftMountId:64, RightMountId:64>>) ->
	{ok, [Type, LeftMountId, RightMountId]};

read(?PT_STREN_MOUNT, <<MountId:64, GoodsNo:64, Num:16>>) ->
	{ok, [MountId, GoodsNo, Num]};

read(?PT_OPEN_MOUNT_SKILL, <<MountId:64, Order:8>>) ->
	{ok, [MountId, Order]};

read(?PT_DELETE_MOUNT_SKILL, <<MountId:64, Order:8>>) ->
	{ok, [MountId, Order]};

read(?PT_LERAN_MOUNT_SKILL, <<MountId:64, SkillId:32, Order:8>>) ->
	{ok, [MountId, SkillId, Order]};

read(?PT_UP_MOUNT_SKILL, <<MountId:64, SkillId:32, Order:8>>) ->
	{ok, [MountId, SkillId, Order]};

read(?PT_CONNECT_PARTNER, <<MountId:64, PartnerId:64, IsConnect:8>>) ->
	{ok, [MountId, PartnerId, IsConnect]};

read(?PT_ACTIVE_MOUNT, <<MountNo:32>>) ->
	{ok, [MountNo]};

read(?PT_ACTIVE_MOUNT_SKIN, <<No:16, GoodsNo:16>>) ->
	{ok, [No,GoodsNo]};

read(?PT_CHANGE_MOUNT_SKIN, <<No:16>>) ->
	{ok, [No]};

read(?PT_MOUNT_SKIN_INFO, _) ->
	{ok, []};

read(?PT_TRANSFORM_MOUNT_SKILL, <<MountId:64, OldSkillId:32, NewSkillId:32, Order:8>>) ->
	{ok, [MountId, OldSkillId, NewSkillId, Order]};

read(_Cmd, _R) ->
	?ASSERT(false, {_Cmd, _R}),
	{error, not_match}.


%%----------------打开坐骑界面------------------
write(?PT_GET_MOUNT, [MountNum, List]) ->
	Len = length(List),
	?TRACE("Len :~p, MountList:~p~n", [Len, List]),
	F = fun(X) ->
			?ASSERT(is_record(X, ets_mount), X),
			NameLen = byte_size(X#ets_mount.name),
			F1 = fun(X1) ->
					% SklCfg = data_skill:get(X#skl_brief.id),
					% SkillType = SklCfg#skl_cfg.is_inborn,
					% <<	
					% 	(SkillType):8,
					% 	(X#skl_brief.id):32,
					% 	(X#skl_brief.lv):16
					% >>
					<<X1:32>>
				end,
        	Level_ = X#ets_mount.level,    
            No = X#ets_mount.no,
			Type = X#ets_mount.custom_type,

            {QualityRatio,Level} = 
		    case data_mount:get_mount_info(No) of
		        MountInfo when is_record(MountInfo, mount_info) ->
		            Step = X#ets_mount.step,
		            {QualityRatio_} = lists:nth(Step, MountInfo#mount_info.quality_ratio),
		            {QualityRatio_,Level_};
		        _ -> ?ASSERT(false, No), {1,Level_}
		    end,

			SkillBinInfo = list_to_binary([F1(X1) || X1 <- util:bitstring_to_term(X#ets_mount.skill)]),
			SkillLen = length(util:bitstring_to_term(X#ets_mount.skill)),
			F2 = fun({AttributeNo1,AttributeNo2,AttributeNo3, AttributeAddRatio1,AttributeAddRatio2,AttributeSubRatio}) ->
					BattlePower = lib_mount:calc_mount_battle_pow(lib_mount:get_mount_attribute(Type,Level,QualityRatio,AttributeNo1,AttributeNo2,AttributeNo3,AttributeAddRatio1,AttributeAddRatio2,AttributeSubRatio)),

					<<AttributeNo1:8,
					AttributeNo2:8,
					AttributeNo3:8,
					AttributeAddRatio1:16,
					AttributeAddRatio2:16,
					AttributeSubRatio:16,
					BattlePower:32
					>>
				end,
			AttrBinInfo = list_to_binary([F2(X2) || X2 <- util:bitstring_to_term(X#ets_mount.attributeList)]),
			AttrLen = length(util:bitstring_to_term(X#ets_mount.attributeList)),
			<<
				(X#ets_mount.id):64,
				(X#ets_mount.no):32,
				NameLen:16,
				(X#ets_mount.name)/binary,
				(X#ets_mount.type):8,
				(X#ets_mount.quality):8,
				(X#ets_mount.level):16,
				(X#ets_mount.exp):16,
				(X#ets_mount.skillNum):8,
				SkillLen:16, SkillBinInfo/binary,
				(X#ets_mount.attribute_1):8,
				(X#ets_mount.attribute_2):8,
				(X#ets_mount.attribute_3):8,
				(X#ets_mount.attribute_add1):16,
				(X#ets_mount.attribute_add2):16,
				(X#ets_mount.attribute_sub):16,
				AttrLen:16, AttrBinInfo/binary,
				(X#ets_mount.step):8,
				(X#ets_mount.step_value):16,
				(X#ets_mount.status):8,
				(X#ets_mount.partner_num):8,
				(X#ets_mount.partner1):64,
				(X#ets_mount.partner2):64,
				(X#ets_mount.partner3):64,
				(X#ets_mount.partner4):64,
				(X#ets_mount.partner5):64,
				(X#ets_mount.feed):32,
				(X#ets_mount.feed_timestamp):32,
				(lib_mount:calc_mount_battle_pow(X)):32,
				(X#ets_mount.custom_type):8,
				(X#ets_mount.partner_maxnum):8
			>>
		end,
	BinInfo = list_to_binary([F(X) || X <- List]),
	Data = <<MountNum:8, Len:16, BinInfo/binary>>,
	{ok, pt:pack(?PT_GET_MOUNT, Data)};

%%------------坐骑骑乘-----------
write(?PT_ONOFF_MOUNT, [Code,OldMountId, MountId]) ->
	Data = <<Code:8, OldMountId:64, MountId:64>>,
	{ok, pt:pack(?PT_ONOFF_MOUNT, Data)};

%%------------坐骑改名------------
write(?PT_RENAME_MOUNT, [RetCode, MountId, NewName]) ->
	Data = <<RetCode:8, MountId:64, (byte_size(NewName)):16, NewName/binary>>,
	{ok, pt:pack(?PT_RENAME_MOUNT, Data)};

%%-----------坐骑重修-------------
write(?PT_RESET_ATTR_MOUNT, [MountId, Len, List]) ->
	{QualityRatio,Level,Type} = case lib_mount:get_mount(MountId) of
        Mount when is_record(Mount, ets_mount) ->    
        	Level_ = Mount#ets_mount.level,    
            No = Mount#ets_mount.no,
			Type_ = Mount#ets_mount.custom_type,
		    case data_mount:get_mount_info(No) of
		        MountInfo when is_record(MountInfo, mount_info) ->
		            Step = Mount#ets_mount.step,
		            {QualityRatio_} = lists:nth(Step, MountInfo#mount_info.quality_ratio),
		            {QualityRatio_,Level_,Type_};
		        _ -> ?ASSERT(false, No), {1,Level_,0}
		    end;
        _ -> {1,1,0}
    end,

	F = fun({AttributeNo1, AttributeNo2, AttributeNo3, AttributeAddRatio1, AttributeAddRatio2, AttributeSubRatio}) ->
		BattlePower = lib_mount:calc_mount_battle_pow(lib_mount:get_mount_attribute(Type,Level,QualityRatio,AttributeNo1,AttributeNo2,AttributeNo3,AttributeAddRatio1,AttributeAddRatio2,AttributeSubRatio)),
		<<AttributeNo1:8, AttributeNo2:8, AttributeNo3:8, AttributeAddRatio1:16, AttributeAddRatio2:16, AttributeSubRatio:16,BattlePower:32>>
	end,
	BinInfo = list_to_binary([F(X) || X <- List]),
	ListLen = length(List),
	Data = <<MountId:64, Len:8, ListLen:16, BinInfo/binary>>,
	{ok, pt:pack(?PT_RESET_ATTR_MOUNT, Data)};

%%----------重修替换-------------
write(?PT_SET_ATTR_MOUNT, [Code, MountId, AttributeNo1, AttributeNo2, AttributeNo3, AttributeAddRatio1,AttributeAddRatio2, AttributeSubRatio,BattlePower]) ->
	Data = <<Code:8, MountId:64, AttributeNo1:8, AttributeNo2:8, AttributeNo3:8, AttributeAddRatio1:16,AttributeAddRatio2:16, AttributeSubRatio:16, BattlePower:32>>,
	{ok, pt:pack(?PT_SET_ATTR_MOUNT, Data)};

%%---------喂养----------------
write(?PT_FEED_MOUNT, [MountId, Level, Exp, BattlePower]) ->
	Data = <<MountId:64, Level:16, Exp:32, BattlePower:32>>,
	{ok, pt:pack(?PT_FEED_MOUNT, Data)};

%%传承
write(?PT_INHERITANCE_MOUNT, [Type , MountId, RemainFeed, Level, Exp, BattlePower, BMountId, BRemainFeed, BLevel, BExp, BBattlePower]) ->
	Data = <<Type:8, MountId:64, RemainFeed:8, Level:16, Exp:32, BattlePower:32,BMountId:64, BRemainFeed:8, BLevel:16, BExp:32, BBattlePower:32>>,
	{ok, pt:pack(?PT_INHERITANCE_MOUNT, Data)};	

%%----------进阶-----------------
write(?PT_STREN_MOUNT, [MountId, Step, StepValue, BattlePower]) ->
	Data = <<MountId:64, Step:8, StepValue:16, BattlePower:32>>,
	{ok, pt:pack(?PT_STREN_MOUNT, Data)};

%%----------打开技能--------------
write(?PT_OPEN_MOUNT_SKILL, [MountId, Order, List]) ->
	Len = length(List),
	F = fun(SkillId) ->
		<<SkillId:32>>
	end,
	BinInfo = list_to_binary([F(X) || X <- List]),
	Data = <<MountId:64, Order:8, Len:16, BinInfo/binary>>,
	{ok, pt:pack(?PT_OPEN_MOUNT_SKILL, Data)};

%%----------删除技能-------------
write(?PT_DELETE_MOUNT_SKILL, [Code, MountId, Order]) ->
	Data = <<Code:8, MountId:64, Order:8>>,
	{ok, pt:pack(?PT_DELETE_MOUNT_SKILL, Data)};

%%----------选择觉醒技能-------------
write(?PT_LERAN_MOUNT_SKILL, [Code, MountId, SkillId, Order]) ->
	Data = <<Code:8, MountId:64, SkillId:32, Order:8>>,
	{ok, pt:pack(?PT_LERAN_MOUNT_SKILL, Data)};

%%----------升级技能-------------
write(?PT_UP_MOUNT_SKILL, [MountId, Order, NewSkillId]) ->
	Data = <<MountId:64, Order:8, NewSkillId:32>>,
	{ok, pt:pack(?PT_UP_MOUNT_SKILL, Data)};

%%----------关联宠物-------------
write(?PT_CONNECT_PARTNER, [IsConnect, MountId, PartnerId]) ->
	Data = <<IsConnect:8, MountId:64, PartnerId:64>>,
	{ok, pt:pack(?PT_CONNECT_PARTNER, Data)};

%%----------激活坐骑-------------
write(?PT_ACTIVE_MOUNT, [Retcode, MountNo, MountId]) ->
	Data = <<Retcode:8, MountNo:32, MountId:64>>,
	{ok, pt:pack(?PT_ACTIVE_MOUNT, Data)};

%%----------激活坐骑皮肤-------------
write(?PT_ACTIVE_MOUNT_SKIN, [Retcode, No]) ->
	Data = <<Retcode:8, No:16>>,
	{ok, pt:pack(?PT_ACTIVE_MOUNT_SKIN, Data)};

%%----------切换坐骑皮肤-------------
write(?PT_CHANGE_MOUNT_SKIN, [Retcode, No]) ->
	Data = <<Retcode:8, No:16>>,
	{ok, pt:pack(?PT_CHANGE_MOUNT_SKIN, Data)};

write(?PT_MOUNT_SKIN_INFO, [List]) ->
	F = fun({No, RemainTime}) ->
		<<No:16, RemainTime:32>>
		end,
	BinInfo = list_to_binary([F(X) || X <- List]),
	ListLen = length(List),
	Data = <<ListLen:16, BinInfo/binary>>,
	{ok, pt:pack(?PT_MOUNT_SKIN_INFO, Data)};

write(?PT_TRANSFORM_MOUNT_SKILL, [MountId, OldSkillId, NewSkillId, Order]) ->
	Data = <<MountId:64, OldSkillId:32, NewSkillId:32, Order:8>>,
	{ok, pt:pack(?PT_TRANSFORM_MOUNT_SKILL, Data)};

write(_Cmd, _R) ->
	?ASSERT(false, {_Cmd, _R}),
	{error, not_match}.