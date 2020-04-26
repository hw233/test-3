-module(pt_17).

-include("pt_17.hrl").
-include("debug.hrl").
-include("partner.hrl").
-include("skill.hrl").
-include("record/goods_record.hrl").
-include("abbreviate.hrl").

-export([read/2, write/2]).

read(?PT_GET_PARTNER, <<PartnerNo:32>>) ->
	{ok, [PartnerNo]};


read(?PT_SET_PARTNER_STATE, <<PartnerId:64, State:8>>) ->
	{ok, [PartnerId, State]};


read(?PT_OPEN_CARRY_PARTNER_NUM, <<Num:8>>) ->
	{ok, [Num]};


read(?PT_SET_MAIN_PARTNER, <<PartnerId:64>>) ->
	{ok, [PartnerId]};


read(?PT_WASH_PARTNER, <<PartnerId:64, Type:8>>) ->
	{ok, [PartnerId, Type]};


read(?PT_TRAIN_PARTNER, <<PartnerId:64>>) ->
	{ok, [PartnerId]};


read(?PT_FREE_PARTNER, <<PartnerId:64>>) ->
	{ok, [PartnerId]};


read(?PT_PARTNER_RENAME, <<PartnerId:64, NewName/binary>>) ->
	{NewName1, _} = pt:read_string(NewName),
	{ok, [PartnerId, NewName1]};


read(?PT_GET_PARTNER_LIST, _) ->
	{ok, []};


read(?PT_GET_PARTNER_ATTR_INFO, <<PartnerId:64>>) ->
	{ok, [PartnerId]};


read(?PT_GET_PARTNER_ATTR_INFO1, <<PartnerId:64>>) ->
	{ok, [PartnerId]};


read(?PT_GET_PARTNER_EQUIP_LIST, <<PartnerId:64>>) ->
	{ok, [PartnerId]};


read(?PT_GET_PARTNER_NATURE_ATTR, <<PartnerId:64>>) ->
	{ok, [PartnerId]};


% read(?PT_GET_PARTNER_TRAIN_ATTR, <<PartnerId:64>>) ->
% 	{ok, [PartnerId]};

read(?PT_PARTNER_EVOLVE, <<PartnerId:64, GoodsCount:16>>) ->
	{ok, [PartnerId, GoodsCount]};

read(?PT_PARTNER_EVOLVE_INFO, <<PartnerId:64>>) ->
	{ok, [PartnerId]};

read(?PT_PARTNER_CULTIVATE, <<PartnerId:64, Count:8>>) ->
	{ok, [PartnerId, Count]};


read(?PT_GET_NUM_LIMIT, _) ->
	{ok, []};


read(?PT_PARTNER_USE_GOODS, <<PartnerId:64, GoodsId:64, Count:16>>) ->
	{ok, [PartnerId, GoodsId, Count]};


read(?PT_PAR_CHANGE_MOOD, <<PartnerId:64>>) ->
	{ok, [PartnerId]};

read(?PT_GET_CHANGE_MOOD_COUNT, _) ->
	{ok, []};


read(?PT_BATCH_FREE_PARTNER, Bin) ->
	{IdList, _} = pt:read_array(Bin, [u64]),
    {ok, [IdList]};

read(?PT_ONE_KEY_FREE_PARTNER, _) ->
	{ok, []};

read(?PT_PAR_FIND_PAR_INFO, <<Type:8>>) ->
	{ok, [Type]};


read(?PT_PAR_ENTER_HOTEL, <<LvStep:8, EnterType:8>>) ->
	{ok, [LvStep, EnterType]};


read(?PT_PAR_FREE_IN_HOTEL, Bin) ->
	{IdList, _} = pt:read_array(Bin, [u64]),
    {ok, [IdList]};


read(?PT_PAR_ADOPT_IN_HOTEL, Bin) ->
	{IdList, _} = pt:read_array(Bin, [u64]),
    {ok, [IdList]};


read(?PT_PAR_TRANSMIT, <<TargetParId:64, Bin/binary>>) ->
	{IdList, _} = pt:read_array(Bin, [u64]),
    {ok, [TargetParId, IdList]};	


read(?PT_PAR_GET_ATTR_OF_PAR_HOTEL, <<PartnerId:64>>) ->
	{ok, [PartnerId]};


read(?PT_PAR_GET_EQUIP_INFO, <<PartnerId:64>>) ->
	{ok, [PartnerId]};

read(?PT_SET_PARTNER_FOLLOW_STATE, <<PartnerId:64, Follow:8>>) ->
	{ok, [PartnerId, Follow]};

read(?PT_PAR_ADD_SKILL, <<PartnerId:64>>) ->
	{ok, [PartnerId]};

read(?PT_PAR_CHANGE_SKILL_PAGE, <<PartnerId:64, SkillsUse:8>>) ->
	{ok, [PartnerId, SkillsUse]};

read(?PT_PAR_AWAKE, <<PartnerId:64>>) ->
	{ok, [PartnerId]};

read(?PT_PAR_AWAKE_ILLUSION, <<PartnerId:64, AwakeLv:8>>) ->
	{ok, [PartnerId, AwakeLv]};

read(?PT_PAR_FIVE_ELMENT_START, <<Type:8,PartnerId:64>>) ->
	{ok, [Type,PartnerId]};

read(?PT_PAR_FIVE_ELMENT_LV,<<PartnerId:64>>) ->
	{ok, [PartnerId]};

read(?PT_CHANGE_PARTNER_BATTLE_ORDER,<< Bin/binary>>) ->
	{IdList, _} = pt:read_array(Bin, [u64]),
	{ok, [IdList]};


read(?PT_PARTNER_SKILL_SLOT_EXPAND, <<PartnerId:64>>) ->
	{ok, [PartnerId]};


read(?PT_PARTNER_ATTR_REFINE, <<PartnerId:64, AttrCode:16, GoodsNo:32, Count:16>>) ->
	{ok, [PartnerId, AttrCode, GoodsNo, Count]};


read(?PT_PARTNER_FREE, <<PartnerId:64, Type:8>>) ->
	{ok, [PartnerId, Type]};


read(?PT_PAR_ALLOT_FREE_TALENT_POINTS, <<PartnerId:64, Bin/binary>>) ->
    % <<Count:16, BinLeft/binary>> = Bin,
    % case Count > 5 of
    %     true ->
    %         ?ASSERT(false, Count),
    %         {error, msg_illegal};
    %     false ->
            % ExpectedSize = 3 * Count,
            % case byte_size(BinLeft) == ExpectedSize of
            %     false ->
            %         ?ASSERT(false, Bin),
            %         {error, msg_illegal};
                % true ->
                    {ElementList, <<>>} = pt:read_array(Bin, [u8, u16]),
                    {ok, [PartnerId,ElementList]};
            % end;
    % end;


read(?PT_PAR_RESET_FREE_TALENT_POINTS, <<PartnerId:64>>) ->
    {ok, [PartnerId]};


read(?PT_PAR_DEL_SKILL, <<PartnerId:64,SkillId:32>>) ->
    {ok, [PartnerId,SkillId]};


read(_Cmd, _R) ->
	?ASSERT(false, {_Cmd, _R}),
	{error, not_match}.


write(?PT_GET_PARTNER, [Partner_Or_PartnerId]) ->
	X = 
		case is_integer(Partner_Or_PartnerId) of
			true -> lib_partner:get_partner(Partner_Or_PartnerId);
			false -> Partner_Or_PartnerId
		end,
	?ASSERT(is_record(X, partner), Partner_Or_PartnerId),
	NameLen = byte_size(X#partner.name),
	{FiveElement, FiveElementLv} = X#partner.five_element,
	Data =
		<<
			(X#partner.id):64,
			(X#partner.no):32,
			NameLen:16,
			(X#partner.name)/binary,
			(X#partner.quality):8,
			(X#partner.state):8,
			% (X#partner.exp):32,
			% (X#partner.intimacy):32,
			% (X#partner.intimacy_lv):8,
			% (X#partner.life):32,
			(X#partner.position):8,
			(lib_partner:get_hp(X)):32,
			(lib_partner:get_mp(X)):32,
			(lib_partner:get_exp(X)):32,
			(lib_partner:get_hp_lim(X)):32,
			(lib_partner:get_mp_lim(X)):32,
			(lib_partner:get_exp_lim(X#partner.lv)):32,
			(X#partner.lv):16,
			(X#partner.follow):8,
			FiveElement:8,
			FiveElementLv:8
		>>,
	{ok, pt:pack(?PT_GET_PARTNER, Data)};


write(?PT_SET_PARTNER_STATE, [RetCode, PartnerId, State]) ->
	Data = <<RetCode:8, PartnerId:64, State:8>>,
	{ok, pt:pack(?PT_SET_PARTNER_STATE, Data)};


write(?PT_OPEN_CARRY_PARTNER_NUM, [RetCode, CurNum]) ->
	Data = <<RetCode:8, CurNum:8>>,
	{ok, pt:pack(?PT_OPEN_CARRY_PARTNER_NUM, Data)};


write(?PT_SET_MAIN_PARTNER, [RetCode, PartnerId]) ->
	Data = <<RetCode:8, PartnerId:64>>,
	{ok, pt:pack(?PT_SET_MAIN_PARTNER, Data)};


write(?PT_WASH_PARTNER, [Partner]) ->
	Data = pack_partner_info_to_binary(Partner),
	{ok, pt:pack(?PT_WASH_PARTNER, Data)};


write(?PT_TRAIN_PARTNER, []) ->
	Data = <<>>,
	{ok, pt:pack(?PT_TRAIN_PARTNER, Data)};


write(?PT_FREE_PARTNER, [RetCode, PartnerId]) ->
	Data = <<RetCode:8, PartnerId:64>>,
	{ok, pt:pack(?PT_FREE_PARTNER, Data)};


write(?PT_PARTNER_RENAME, [RetCode, PartnerId, NewName]) ->
	Data = <<RetCode:8, PartnerId:64, (byte_size(NewName)):16, NewName/binary>>,
	{ok, pt:pack(?PT_PARTNER_RENAME, Data)};


write(?PT_GET_PARTNER_LIST, [_PlayerId, List]) ->
	Len = length(List),
	% ?DEBUG_MSG("Len :~p, PartnerList:~p~n", [Len, List]),
	F = fun(X) ->
			?ASSERT(is_record(X, partner), X),
			NameLen = byte_size(X#partner.name),
		{FiveElement, FiveElementLv} = X#partner.five_element,
			% ?DEBUG_MSG("id=~p,state:~p~n", [X#partner.id,X#partner.state]),

			% ?DEBUG_MSG("~p~n", [X]),

			% ?DEBUG_MSG("X#partner.name=~p,X#partner.quality=~p,X#partner.position=~p",[X#partner.name,X#partner.quality,X#partner.position]),
			% ?DEBUG_MSG("X#partner.1=~p,X#partner.2=~p,X#partner.3=~p",[lib_partner:get_hp(X),lib_partner:get_mp(X),lib_partner:get_loyalty(X)]),
			% ?DEBUG_MSG("X#partner.4=~p,X#partner.5=~p,X#partner.6=~p",[lib_partner:get_hp_lim(X),lib_partner:get_mp_lim(X),lib_partner:get_loyalty_lim(X)]),

			% ?DEBUG_MSG("X#partner.lv=~p,X#partner.lv=~p",[X#partner.lv,X#partner.follow]),

			<<
				(X#partner.id):64,
				(X#partner.no):32,
				NameLen:16,
				(X#partner.name)/binary,
				(X#partner.quality):8,
				(X#partner.state):8,
				% (X#partner.exp):32,
				% (X#partner.intimacy):32,
				% (X#partner.intimacy_lv):8,
				% (X#partner.life):32,
				(X#partner.position):8,
				(lib_partner:get_hp(X)):32,
				(lib_partner:get_mp(X)):32,
				(lib_partner:get_loyalty(X)):32,
				(lib_partner:get_hp_lim(X)):32,
				(lib_partner:get_mp_lim(X)):32,
				(lib_partner:get_loyalty_lim(X)):32,
				(X#partner.lv):16,
				(X#partner.follow):8,
				FiveElement:8,
				FiveElementLv:8,
				(X#partner.join_battle_order):8,
				(pt:pack_array([{A}||A<- X#partner.art_slot], [u16]))/binary

			>>
		end,
	BinInfo = list_to_binary([F(X) || X <- List]),
	Data = <<Len:16, BinInfo/binary>>,
	{ok, pt:pack(?PT_GET_PARTNER_LIST, Data)};


write(?PT_GET_PARTNER_ATTR_INFO, [Partner]) ->
	Data = pack_partner_info_to_binary(Partner),
	{ok, pt:pack(?PT_GET_PARTNER_ATTR_INFO, Data)};


write(?PT_GET_PARTNER_ATTR_INFO1, [Partner]) ->
	Data = pack_partner_info_to_binary(Partner),
	{ok, pt:pack(?PT_GET_PARTNER_ATTR_INFO1, Data)};


write(?PT_GET_PARTNER_EQUIP_LIST, [PartnerId, List]) ->
	Len = length(List),
	F = fun(X) ->
			<<
				(X#goods.id):64,
				(X#goods.no):32,
				(X#goods.slot):8,
				(X#goods.equip_prop#equip_prop.stren_lv):8,
				(X#goods.bind_state):8
			>>
		end,
	BinInfo = list_to_binary([F(X) || X <- List]),
	Data = <<PartnerId:64, Len:16, BinInfo/binary>>,
	{ok, pt:pack(?PT_GET_PARTNER_EQUIP_LIST, Data)};


write(?PT_GET_PARTNER_NATURE_ATTR, [PartnerId, NatureNo, PhyAtt, PhyDef, MagAtt, MagDef, Life, Speed, Hp]) ->
	Data = <<PartnerId:64, NatureNo:8, PhyAtt:8, MagAtt:8, Speed:8, PhyDef:8, Hp:8, MagDef:8, Life:8>>,
	{ok, pt:pack(?PT_GET_PARTNER_NATURE_ATTR, Data)};


% write(?PT_GET_PARTNER_TRAIN_ATTR, [Partner]) ->
% 	CurLifeAptitude = lib_partner:get_cur_life_aptitude(Partner),     
% 	AddedLifeAptitude = 0,   
% 	MaxLifeAptitude = lib_partner:get_max_life_aptitude(Partner),     
% 	CurMagAptitude = lib_partner:get_cur_mag_aptitude(Partner),      
% 	AddedMagAptitude = 0,    
% 	MaxMagAptitude = lib_partner:get_max_mag_aptitude(Partner),      
% 	CurPhyAttAptitude = lib_partner:get_cur_phy_att_aptitude(Partner),   
% 	AddedPhyAttAptitude = 0, 
% 	MaxCurPhyAttAptitude = lib_partner:get_max_phy_att_aptitude(Partner),
% 	CurMagAttAptitude = lib_partner:get_cur_mag_att_aptitude(Partner),   
% 	AddedMagAttAptitude = 0, 
% 	MaxMagAttAptitude = lib_partner:get_max_mag_att_aptitude(Partner),   
% 	CurPhyDefAptitude = lib_partner:get_cur_phy_def_aptitude(Partner),   
% 	AddedPhyDefAptitude = 0, 
% 	MaxPhyDefAptitude = lib_partner:get_max_phy_def_aptitude(Partner),   
% 	CurMagDefAptitude = lib_partner:get_cur_mag_def_aptitude(Partner),   
% 	AddedMagDefAptitude = 0, 
% 	MaxMagDefAptitude = lib_partner:get_max_mag_def_aptitude(Partner),   
% 	CurSpeedAptitude = lib_partner:get_cur_speed_aptitude(Partner),    
% 	AddedSpeedAptitude = 0,  
% 	MaxSpeedAptitude = lib_partner:get_max_speed_aptitude(Partner),

% 	CurGrow = lib_partner:get_cur_grow(Partner),
% 	AddedGrow = CurGrow - lib_partner:get_base_grow(Partner),    
% 	Data = <<
% 			(lib_partner:get_id(Partner)):64,
% 			(lib_partner:get_intimacy(Partner)):32,
% 			(lib_partner:get_intimacy_lv(Partner)):16,
% 			(lib_partner:get_evolve_lv(Partner)):16,
% 			CurGrow:32,
% 			AddedGrow:32,
% 			(lib_partner:get_cultivate_lv(Partner)):16,
% 			(CurLifeAptitude):32,
% 			(AddedLifeAptitude):32,
% 			(MaxLifeAptitude):32,
% 			(CurMagAptitude):32,
% 			(AddedMagAptitude):32,
% 			(MaxMagAptitude):32,
% 			(CurPhyAttAptitude):32,
% 			(AddedPhyAttAptitude):32,
% 			(MaxCurPhyAttAptitude):32,
% 			(CurMagAttAptitude):32,
% 			(AddedMagAttAptitude):32,
% 			(MaxMagAttAptitude):32,
% 			(CurPhyDefAptitude):32,
% 			(AddedPhyDefAptitude):32,
% 			(MaxPhyDefAptitude):32,
% 			(CurMagDefAptitude):32,
% 			(AddedMagDefAptitude):32,
% 			(MaxMagDefAptitude):32,
% 			(CurSpeedAptitude):32,
% 			(AddedSpeedAptitude):32,
% 			(MaxSpeedAptitude):32,
% 			(lib_partner:get_cultivate(Partner)):32
% 		   >>,

% 	{ok, pt:pack(?PT_GET_PARTNER_TRAIN_ATTR, Data)};


write(?PT_NOTIFY_PARTNER_INFO_CHANGE, [PartnerId, KV_TupleList]) ->
    F = fun({ObjInfoCode, Value}) ->
    		Value2 = lib_attribute:ajust_value_for_send_to_client(ObjInfoCode, Value),
            ?ASSERT(is_integer(Value2),{ObjInfoCode, Value, Value2}),
			     ?DEBUG_MSG("wjctest_pt17 ~p~n",[Value2]),
            <<ObjInfoCode:16, Value2:32>>
        end,
    Bin = list_to_binary([F(X) || X <- KV_TupleList]),
    Bin2 = <<
            (length(KV_TupleList)) : 16,
             Bin / binary
           >>,
    Bin3 = <<PartnerId:64, Bin2/binary>>,
	?DEBUG_MSG("----------------KV_TupleList-------------~p~n", [KV_TupleList]),
    {ok, pt:pack(?PT_NOTIFY_PARTNER_INFO_CHANGE, Bin3)};


write(?PT_PARTNER_EVOLVE, [RetCode, Partner]) ->
	PartnerId = lib_partner:get_id(Partner),
    EvolveLv = lib_partner:get_evolve_lv(Partner),
	Evolve = lib_partner:get_evolve(Partner),

	BinData = <<RetCode:8, PartnerId:64, EvolveLv:16, Evolve:32>>,
	{ok, pt:pack(?PT_PARTNER_EVOLVE, BinData)};


write(?PT_PARTNER_EVOLVE_INFO, [Partner]) ->
	PartnerId = lib_partner:get_id(Partner),
	BattlePower = lib_partner:get_battle_power(Partner),
    EvolveLv = lib_partner:get_evolve_lv(Partner),
    CurGrow = lib_partner:get_cur_grow(Partner),

    Data = data_partner_evolve:get(EvolveLv),

    AddedGrow = Data#partner_evolve.grow_add,

    BattlePower1 = lib_partner:get_battle_power(Partner), %% todo 
	EvolveLv1 = erlang:min(EvolveLv + 1, ?PARTNER_MAX_EVOLVE_LV),
	Data1 = data_partner_evolve:get(EvolveLv1),
	AddedGrow1 = Data1#partner_evolve.grow_add,
	CurGrow1 = lib_partner:get_cur_grow(Partner) + AddedGrow1,     

	?TRACE("pt_17:PT_PARTNER_EVOLVE_INFO, PartnerId:~p, BattlePower:~p, EvolveLv:~p, CurGrow:~p, AddedGrow:~p, BattlePower1:~p, EvolveLv1:~p, CurGrow1:~p, AddedGrow1:~p~n",
		[PartnerId, BattlePower, EvolveLv, CurGrow, AddedGrow, BattlePower1, EvolveLv1, CurGrow1, AddedGrow1]),

	BinData = <<PartnerId:64, BattlePower:32, EvolveLv:16, CurGrow:32, AddedGrow:32, BattlePower1:32, EvolveLv1:16, CurGrow1:32, AddedGrow1:32>>,
	{ok, pt:pack(?PT_PARTNER_EVOLVE_INFO, BinData)};


write(?PT_PARTNER_CULTIVATE, [PartnerId, RetList]) ->
	Partner = lib_partner:get_partner(PartnerId),
	
	Len = length(RetList),
	F = fun({RetCode, AddCultivate}) ->
		<<RetCode:16, AddCultivate:32>>
	end,

	Bin = list_to_binary([F(X) || X <- RetList]),
	Cultivate = lib_partner:get_cultivate(Partner),
	Partner = lib_partner:get_partner(PartnerId), 
	CultivateLv = lib_partner:get_cultivate_lv(Partner),

	Data = <<PartnerId:64, Len:16, Bin/binary, Cultivate:32, CultivateLv:16, (lib_partner:get_cultivate_layer(Partner)):8>>,
	{ok, pt:pack(?PT_PARTNER_CULTIVATE, Data)};


write(?PT_GET_NUM_LIMIT, [CurCarryNum, CurFightNum]) ->
	Data = <<CurCarryNum:8, CurFightNum:8>>,
	{ok, pt:pack(?PT_GET_NUM_LIMIT, Data)};

		
write(?PT_PARTNER_USE_GOODS, [RetCode, Goods, Count]) ->
	Data = <<RetCode:8, (lib_goods:get_id(Goods)):64, Count:16, (lib_goods:get_no(Goods)):32>>,
	{ok, pt:pack(?PT_PARTNER_USE_GOODS, Data)};

write(?PT_PAR_CHANGE_MOOD, [Count]) ->
	Data = <<Count:16>>,
	{ok, pt:pack(?PT_PAR_CHANGE_MOOD, Data)};


write(?PT_GET_CHANGE_MOOD_COUNT, [Count]) ->
	Data = <<Count:16>>,
	{ok, pt:pack(?PT_GET_CHANGE_MOOD_COUNT, Data)};


write(?PT_BATCH_FREE_PARTNER, [RetCode, RetList]) ->
	Len = length(RetList),
	F = fun(PartnerId) ->
		<<PartnerId:64>>
	end,

	Bin = list_to_binary([F(X) || X <- RetList]),
	Data = <<RetCode:16, Len:16, Bin/binary>>,
	{ok, pt:pack(?PT_BATCH_FREE_PARTNER, Data)};

write(?PT_ONE_KEY_FREE_PARTNER, [RetCode, RetList]) ->
	Len = length(RetList),
	F = fun(PartnerId) ->
		<<PartnerId:64>>
	end,

	Bin = list_to_binary([F(X) || X <- RetList]),
	Data = <<RetCode:16, Len:16, Bin/binary>>,
	{ok, pt:pack(?PT_ONE_KEY_FREE_PARTNER, Data)};

write(?PT_PAR_FIND_PAR_INFO, [FindPar]) ->
	case FindPar =:= null of
		true ->
			F1 = fun(Step) ->
				CountCounterCmp = 
					case data_find_par:get(Step) of
			            null -> 
			                ?ASSERT(false, Step),
			                ?PAR_FIND_PURPLE_COUNTER;
			            DataCfg ->
			                DataCfg#find_par_cfg.minimum_count
			        end,
				<<Step:8, CountCounterCmp:8>>
			end,
			BinCounter = list_to_binary([F1(X) || X <- data_find_par:get_all_lv_step_list()]),
			{ok, pt:pack(?PT_PAR_FIND_PAR_INFO, <<0:8, 0:8, 0:32, 0:8, (length(data_find_par:get_all_lv_step_list())):16, BinCounter/binary, 0:16, <<>>/binary>>)};
		false ->
			Len = length(FindPar#find_par.par_list),
			F = fun(X) ->
				?ASSERT(is_record(X, partner), X),
				NameLen = byte_size(X#partner.name),
				<<
					(X#partner.id):64,
					(X#partner.no):32,
					NameLen:16,
					(X#partner.name)/binary,
					(X#partner.quality):8,
					(X#partner.state):8,
					(X#partner.position):8,
					(lib_partner:get_hp(X)):32,
					(lib_partner:get_mp(X)):32,
					(lib_partner:get_loyalty(X)):32,
					(lib_partner:get_hp_lim(X)):32,
					(lib_partner:get_mp_lim(X)):32,
					(lib_partner:get_loyalty_lim(X)):32,
					(X#partner.lv):16
				>>
			end,

			Bin = list_to_binary([F(X) || X <- FindPar#find_par.par_list]),
			F1 = fun(Step) ->
				CountCounterCmp = 
					case data_find_par:get(Step) of
			            null -> 
			                ?ASSERT(false, Step),
			                ?PAR_FIND_PURPLE_COUNTER;
			            DataCfg ->
			                DataCfg#find_par_cfg.minimum_count
			        end,
			    Count = ply_partner:get_counter(count, FindPar, Step),
				<<Step:8, (max(CountCounterCmp - Count, 0)):8>>
			end,
			BinCounter = list_to_binary([F1(X) || X <- data_find_par:get_all_lv_step_list()]),

			Data = <<(FindPar#find_par.enter_type):8, (FindPar#find_par.last_enter_type):8, (FindPar#find_par.last_free_enter_time):32, (FindPar#find_par.lv_step):8, 
			(length(data_find_par:get_all_lv_step_list())):16, BinCounter/binary, Len:16, Bin/binary>>,
			{ok, pt:pack(?PT_PAR_FIND_PAR_INFO, Data)}
	end;
	

write(?PT_PAR_ENTER_HOTEL, [RetCode, EnterType]) ->
	{ok, pt:pack(?PT_PAR_ENTER_HOTEL, <<RetCode:8, EnterType:8>>)};


write(?PT_PAR_FREE_IN_HOTEL, [RetList]) ->
	Len = length(RetList),
	F = fun(PartnerId) ->
		<<PartnerId:64>>
	end,

	Bin = list_to_binary([F(X) || X <- RetList]),
	Data = <<Len:16, Bin/binary>>,
	{ok, pt:pack(?PT_PAR_FREE_IN_HOTEL, Data)};


write(?PT_PAR_ADOPT_IN_HOTEL, [RetList]) ->
	Len = length(RetList),
	F = fun(PartnerId) ->
		<<PartnerId:64>>
	end,

	Bin = list_to_binary([F(X) || X <- RetList]),
	Data = <<Len:16, Bin/binary>>,
	{ok, pt:pack(?PT_PAR_ADOPT_IN_HOTEL, Data)};
	

write(?PT_PAR_TRANSMIT, [TargetParId, RetList]) ->
	Len = length(RetList),
	F = fun(PartnerId) ->
		<<PartnerId:64>>
	end,

	Bin = list_to_binary([F(X) || X <- RetList]),
	Data = <<TargetParId:64, Len:16, Bin/binary>>,
	{ok, pt:pack(?PT_PAR_TRANSMIT, Data)};

write(?PT_PAR_GET_ATTR_OF_PAR_HOTEL, [Partner]) ->
	Data = pack_partner_info_to_binary(Partner),
	{ok, pt:pack(?PT_PAR_GET_ATTR_OF_PAR_HOTEL, Data)};

write(?PT_PAR_GET_EQUIP_INFO, [Partner]) ->
	PlayerId = lib_partner:get_owner_id(Partner),
	PartnerId = lib_partner:get_id(Partner),

	EquipList = mod_equip:get_partner_equip_list(PlayerId, PartnerId),

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

    Data = 
	    <<
	        PartnerId : 64,
	        (lib_partner:get_no(Partner)) : 32,
	        (lib_partner:get_quality(Partner)) : 8,
	        (lib_partner:get_lv(Partner)) : 16,
	        (lib_partner:get_evolve_lv(Partner)) : 8,
	        (lib_partner:get_state(Partner)) : 8,
	        (lib_partner:get_position(Partner)) : 8,
	        (lib_partner:get_battle_power(Partner)) : 32,
	        (byte_size(lib_partner:get_name(Partner))) : 16,
	        (lib_partner:get_name(Partner)) / binary,
	        (lib_partner:get_cultivate_lv(Partner)) : 16,
	        (lib_partner:get_cultivate_layer(Partner)) : 8,
	        Len : 16,
	        Bin / binary
	    >>,
    {ok, pt:pack(?PT_PAR_GET_EQUIP_INFO, Data)};


write(?PT_NOTIFY_PARTNER_SKILL_INFO_CHANGE, [PartnerId, InfoType, SkillId]) ->
	{ok, pt:pack(?PT_NOTIFY_PARTNER_SKILL_INFO_CHANGE, <<PartnerId:64, InfoType:8, SkillId:32>>)};

write(?PT_SET_PARTNER_FOLLOW_STATE, [PartnerId, Follow]) ->
	{ok, pt:pack(?PT_SET_PARTNER_FOLLOW_STATE, <<PartnerId:64, Follow:8>>)};

write(?PT_PAR_CHANGE_SKILL_PAGE, [PartnerId, SkillsUse]) ->
	{ok, pt:pack(?PT_PAR_CHANGE_SKILL_PAGE, <<PartnerId:64, SkillsUse:8>>)};

write(?PT_PAR_AWAKE, [PartnerId, AwakeLv]) ->
	{ok, pt:pack(?PT_PAR_AWAKE, <<PartnerId:64, AwakeLv:8>>)};


write(?PT_PAR_AWAKE_ILLUSION, [PartnerId, AwakeLv]) ->
	{ok, pt:pack(?PT_PAR_AWAKE_ILLUSION, <<PartnerId:64, AwakeLv:8>>)};

write(?PT_PAR_FIVE_ELMENT_START, [LastElements, Element]) ->
	{ok, pt:pack(?PT_PAR_FIVE_ELMENT_START, <<LastElements:8,Element:8>>)};


write(?PT_PAR_FIVE_ELMENT_LV, [Lv]) ->
	{ok, pt:pack(?PT_PAR_FIVE_ELMENT_LV, <<Lv:8>>)};

write(?PT_CHANGE_PARTNER_BATTLE_ORDER, [Code, PartnerIdList]) ->
	BinLen = length(PartnerIdList),
	Bin = list_to_binary([<<X:64>> || X <- PartnerIdList]),
	{ok, pt:pack(?PT_CHANGE_PARTNER_BATTLE_ORDER, <<Code:8,BinLen:16,Bin/binary>>)};

write(?PT_PARTNER_SKILL_SLOT_EXPAND, [PartnerId]) ->
	{ok, pt:pack(?PT_PARTNER_SKILL_SLOT_EXPAND, <<PartnerId:64>>)};


write(?PT_PARTNER_ATTR_REFINE, [PartnerId, AttrValues]) ->
	BinLen = length(AttrValues),
	Bin = list_to_binary([<<AttrCode:16, AttrValue:32>> || {AttrCode, AttrValue} <- AttrValues]),
	{ok, pt:pack(?PT_PARTNER_ATTR_REFINE, <<PartnerId:64, BinLen:16, Bin/binary>>)};


write(?PT_PARTNER_FREE, [PartnerId, Type, GoodsCountList]) ->
	BinLen = length(GoodsCountList),
	Bin = list_to_binary([<<GoodsNo:32, Count:32>> || {GoodsNo, Count} <- GoodsCountList]),
	{ok, pt:pack(?PT_PARTNER_FREE, <<PartnerId:64, Type:8, BinLen:16, Bin/binary>>)};



write(_Cmd, _R) ->
	?ASSERT(false, {_Cmd, _R}),
	%%% {ok, pt:pack(0, <<>>)}.
	{error, not_match}.

%% ------------------------------------------------------------------------------------------------------

pack_partner_info_to_binary(Partner) ->
	PartnerNo = lib_partner:get_no(Partner),
	PartnerData = data_partner:get(PartnerNo),
	PartnerId = lib_partner:get_id(Partner),
	Lv = lib_partner:get_lv(Partner),
	Name = lib_partner:get_name(Partner),
	NameLen = byte_size(Name),
	Quality = lib_partner:get_quality(Partner),
	Exp = lib_partner:get_exp(Partner),
	Hp = lib_partner:get_hp(Partner),
	Mp = lib_partner:get_mp(Partner),
	PhyAtt = lib_partner:get_phy_att(Partner),
	PhyDef = lib_partner:get_phy_def(Partner),
	MagAtt = lib_partner:get_mag_att(Partner),
	MagDef = lib_partner:get_mag_def(Partner),
	ActSpeed = lib_partner:get_act_speed(Partner),
	% ChaosHit = lib_partner:get_chaos_hit(Partner),
	% FrozenHit = lib_partner:get_frozen_hit(Partner),
	% TranceHit = lib_partner:get_trance_hit(Partner),

	% Hit = lib_partner:get_hit(Partner),
	% Crit = lib_partner:get_crit(Partner),
	PhyComboAttProba = Partner#partner.total_attrs#attrs.phy_combo_att_proba,
	StrikebackProba = Partner#partner.total_attrs#attrs.strikeback_proba,
	MagComboAttProba = Partner#partner.total_attrs#attrs.mag_combo_att_proba,
	% PursueAttProba = Partner#partner.total_attrs#attrs.pursue_att_proba,
	%% 封印抗性+冰封抗性=最终冰封抗性
	% ResisFrozen = lib_partner:get_frozen_resis(Partner),
	%% 封印抗性＋昏睡抗性＝最终昏睡抗性
	% ResisTrance = lib_partner:get_trance_resis(Partner),
	%% 封印抗性＋混乱抗性＝最终混乱抗性
	% ResisChaos = lib_partner:get_chaos_resis(Partner),

	SealHit = lib_partner:get_seal_hit(Partner),
	ResisSeal = lib_partner:get_seal_resis(Partner),
	% Ten = lib_partner:get_ten(Partner),
	% Dodge = lib_partner:get_dodge(Partner),       

	SkillsUse = lib_partner:get_skills_use(Partner),
	F = fun(X) ->
			SklCfg = data_skill:get(X#skl_brief.id),
%% 			SkillType = SklCfg#skl_cfg.is_inborn,
			<<	
%% 				(SkillType):8,
				(X#skl_brief.id):32,
				(X#skl_brief.lv):16
			>>
		end,
	BinInfo = list_to_binary([F(X) || X <- Partner#partner.skills]),
	SkillLen = length(Partner#partner.skills),

	BinInfo2 = list_to_binary([F(X) || X <- Partner#partner.skills_two]),
	SkillLen2 = length(Partner#partner.skills_two),
	
	BinInfoE = list_to_binary([F(X) || X <- Partner#partner.skills_exclusive]),
	SkillLenE = length(Partner#partner.skills_exclusive),

	
	Loyalty = lib_partner:get_loyalty(Partner),
	NatureNo = lib_partner:get_nature(Partner),
	HpLim = lib_partner:get_hp_lim(Partner),
	MpLim = lib_partner:get_mp_lim(Partner),

	Intimacy = lib_partner:get_intimacy(Partner),
	IntimacyLv = lib_partner:get_intimacy_lv(Partner),
	EvolveLv = lib_partner:get_evolve_lv(Partner),
	Cultivate = lib_partner:get_cultivate(Partner),
	CultivateLv = lib_partner:get_cultivate_lv(Partner),
	
	AwakeLv = lib_partner:get_awake_lv(Partner),
	AwakeIllusion = lib_partner:get_awake_illusion(Partner),
	

	BaseGrow = lib_partner:get_base_grow(Partner),
	BaseLifeAptitude = lib_partner:get_base_life_aptitude(Partner),
	BaseMagAptitude = lib_partner:get_base_mag_aptitude(Partner),
	BasePhyAttAptitude = lib_partner:get_base_phy_att_aptitude(Partner),
	BaseMagAttAptitude = lib_partner:get_base_mag_att_aptitude(Partner),
	BasePhyDefAptitude = lib_partner:get_base_phy_def_aptitude(Partner),
	BaseMagDefAptitude = lib_partner:get_base_mag_def_aptitude(Partner),
	BaseSpeedAptitude = lib_partner:get_base_speed_aptitude(Partner),
	
	BaseGrowTmp = lib_partner:get_base_grow_tmp(Partner),
	BaseLifeAptitudeTmp = lib_partner:get_base_life_aptitude_tmp(Partner),
	BaseMagAptitudeTmp = lib_partner:get_base_mag_aptitude_tmp(Partner),
	BasePhyAttAptitudeTmp = lib_partner:get_base_phy_att_aptitude_tmp(Partner),
	BaseMagAttAptitudeTmp = lib_partner:get_base_mag_att_aptitude_tmp(Partner),
	BasePhyDefAptitudeTmp = lib_partner:get_base_phy_def_aptitude_tmp(Partner),
	BaseMagDefAptitudeTmp = lib_partner:get_base_mag_def_aptitude_tmp(Partner),
	BaseSpeedAptitudeTmp = lib_partner:get_base_speed_aptitude_tmp(Partner),
	
	MaxPostnatalSkillSlot = lib_partner:get_max_postnatal_skill_slot(Partner),
	Life = lib_partner:get_life(Partner),
	BattlePower = lib_partner:get_battle_power(Partner),
	MoodNo = lib_partner:get_mood_no(Partner),
	Evolve = lib_partner:get_evolve(Partner),
	ParShowEquips = lib_partner:get_showing_equips(Partner),

	PhyCrit = lib_partner:get_phy_crit(Partner),
	MagCrit = lib_partner:get_mag_crit(Partner),
	PhyTen = lib_partner:get_phy_ten(Partner),
	MagTen = lib_partner:get_mag_ten(Partner),
	
	HealValue = lib_partner:get_heal_value(Partner),

	Str = (lib_partner:get_total_str(Partner)),
    Con = (lib_partner:get_total_con(Partner)),
    Sta = (lib_partner:get_total_stam(Partner)),
    Spi = (lib_partner:get_total_spi(Partner)),
    Agi = (lib_partner:get_total_agi(Partner)),
    FeerPoint = (lib_partner:get_free_talent_points(Partner)),

    ?DEBUG_MSG("Str=~p,Con=~p,Sta=~p,Spi=~p,Agi=~p",[Str,Con,Sta,Spi,Agi]),
	{FiveElement, FiveElementLv} = Partner#partner.five_element,
	NeglectPhyDef = util:floor(Partner#partner.total_attrs#attrs.neglect_phy_def ),
	NeglectMagDef = util:floor(Partner#partner.total_attrs#attrs.neglect_mag_def ),
	PhyDamReduceCoef = util:floor(Partner#partner.total_attrs#attrs.be_phy_dam_reduce_coef*1000),
	MagDamReduceCoef =util:floor( Partner#partner.total_attrs#attrs.be_mag_dam_reduce_coef*1000),
	NeglectSealResis = util:floor(Partner#partner.total_attrs#attrs.neglect_seal_resis),
	RetDamProba   = Partner#partner.total_attrs#attrs.ret_dam_proba,
	RetDamCoef  = util:floor(Partner#partner.total_attrs#attrs.ret_dam_coef * 1000 ),
	NeglectRetDamProba = Partner#partner.total_attrs#attrs.neglect_ret_dam,
	DoPhyDamScaling  = util:floor(Partner#partner.total_attrs#attrs.do_phy_dam_scaling * 1000),
	DoMagDamScaling = util:floor(Partner#partner.total_attrs#attrs.do_mag_dam_scaling * 1000),
	PhyCritCoef   =   util:floor(Partner#partner.total_attrs#attrs.phy_crit_coef * 1000),
	MagCritCoef   =   util:floor(Partner#partner.total_attrs#attrs.mag_crit_coef * 1000),
	PursueAttProba =  util:floor(Partner#partner.total_attrs#attrs.pursue_att_proba * 1000),
	AbsorbHpCoef  =   util:floor(Partner#partner.total_attrs#attrs.absorb_hp_coef * 1000),
	?DEBUG_MSG("testnewattrs ~p~n", [{NeglectPhyDef,NeglectMagDef,PhyDamReduceCoef,MagDamReduceCoef,NeglectSealResis,RetDamProba,
		RetDamCoef,NeglectRetDamProba,DoPhyDamScaling,DoMagDamScaling}]),
  ?DEBUG_MSG("testBase ~p~n ", [{BaseGrow , BaseLifeAptitude , BaseMagAptitude , BasePhyAttAptitude ,
		BaseMagAttAptitude , BasePhyDefAptitude , BaseMagDefAptitude , BaseSpeedAptitude}]),
	?DEBUG_MSG("TestPartenr ~p",[{PartnerNo , PartnerId , Lv , NameLen , Name , Quality , Exp , Hp , Mp , PhyAtt , PhyDef ,
		MagAtt , MagDef , ActSpeed , PhyComboAttProba , StrikebackProba , MagComboAttProba ,
		SealHit , ResisSeal , SkillsUse , SkillLen , BinInfo , SkillLen2 , BinInfo2 , SkillLenE , BinInfoE , Loyalty , NatureNo , HpLim , MpLim ,
		Intimacy , IntimacyLv , EvolveLv , Cultivate , CultivateLv , BaseGrow , BaseLifeAptitude , BaseMagAptitude , BasePhyAttAptitude ,
		BaseMagAttAptitude , BasePhyDefAptitude , BaseMagDefAptitude , BaseSpeedAptitude , MaxPostnatalSkillSlot , Life , BattlePower , MoodNo , Evolve ,
		(ParShowEquips#showing_equip.clothes) , (lib_partner:get_cultivate_layer(Partner)) ,PhyCrit ,MagCrit ,PhyTen ,MagTen  ,HealValue
		,Str
		,Con
		,Sta
		,Spi
		,Agi
		,FeerPoint
		,FiveElement
		,FiveElementLv
	}]),


	
	<<PartnerNo:32, PartnerId:64, Lv:16, NameLen:16, Name/binary, Quality:8, Exp:32, Hp:32, Mp:32, PhyAtt:32, PhyDef:32, 
	MagAtt:32, MagDef:32, ActSpeed:32, PhyComboAttProba:32, StrikebackProba:32, MagComboAttProba:32, 
	SealHit:32, ResisSeal:32, SkillsUse:8, SkillLen:16, BinInfo/binary, SkillLen2:16, BinInfo2/binary, SkillLenE:16, BinInfoE/binary, Loyalty:32, NatureNo:32, HpLim:32, MpLim:32, 
	Intimacy:32, IntimacyLv:16, EvolveLv:16, Cultivate:32, CultivateLv:16, 
	
	(util:ceil(BaseGrow*PartnerData#par_born_data.grow)):32, 
    (util:ceil(BaseLifeAptitude*PartnerData#par_born_data.hp_aptitude)):32,
	(util:ceil(BaseMagAptitude*0)):32, 
	(util:ceil(BasePhyAttAptitude*PartnerData#par_born_data.phy_att_aptitude)):32,
	(util:ceil(BaseMagAttAptitude*PartnerData#par_born_data.mag_att_aptitude)):32,
	(util:ceil(BasePhyDefAptitude*PartnerData#par_born_data.phy_def_aptitude)) :32, 
	(util:ceil(BaseMagDefAptitude*PartnerData#par_born_data.mag_def_aptitude)):32,  
	(util:ceil(BaseSpeedAptitude*PartnerData#par_born_data.speed_aptitude)):32, 
	
	(util:ceil(BaseGrowTmp*PartnerData#par_born_data.grow)):32, 
    (util:ceil(BaseLifeAptitudeTmp*PartnerData#par_born_data.hp_aptitude)):32,  
	(util:ceil(BaseMagAptitudeTmp*0)):32, 
	(util:ceil(BasePhyAttAptitudeTmp*PartnerData#par_born_data.phy_att_aptitude)):32,
	(util:ceil(BaseMagAttAptitudeTmp*PartnerData#par_born_data.mag_att_aptitude)):32,
	(util:ceil(BasePhyDefAptitudeTmp*PartnerData#par_born_data.phy_def_aptitude)) :32, 
	(util:ceil(BaseMagDefAptitudeTmp*PartnerData#par_born_data.mag_def_aptitude)):32,  
	(util:ceil(BaseSpeedAptitudeTmp*PartnerData#par_born_data.speed_aptitude)):32, 
	
	MaxPostnatalSkillSlot:8, Life:32, BattlePower:32, MoodNo:16, Evolve:32, AwakeLv:8, AwakeIllusion:8,
	(ParShowEquips#showing_equip.clothes):32, (lib_partner:get_cultivate_layer(Partner)):8,PhyCrit:16,MagCrit:16,PhyTen:16,MagTen:16 ,HealValue:32 
	,Str : 16
	,Con : 16
	,Sta : 16
	,Spi : 16
	,Agi : 16
	,FeerPoint : 16
	,FiveElement :8
	,FiveElementLv :8,
	NeglectPhyDef:32,NeglectMagDef:32,PhyDamReduceCoef:32,MagDamReduceCoef:32,
		NeglectSealResis:32,RetDamProba:32,RetDamCoef:32,NeglectRetDamProba:32,
		DoPhyDamScaling:32,DoMagDamScaling:32,
		PhyCritCoef :32,
	MagCritCoef :32,
	PursueAttProba :32,
	AbsorbHpCoef :32,
		(pt:pack_array([{A}||A<- Partner#partner.art_slot], [u16]))/binary
	>>.



