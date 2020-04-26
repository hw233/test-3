-module(pt_41).

-include("pt_41.hrl").
-include("debug.hrl").
-include("hire.hrl").
-include("common.hrl").
-include("offline_data.hrl").
-include("sys_code.hrl").

-export([read/2, write/2]).

read(?GET_HIRE_LIST, <<Faction:8, StartIndex:32, EndIndex:32, SortType:8>>) ->
	{ok, [Faction, StartIndex, EndIndex, SortType]};


read(?HIRE_PLAYER, <<PlayerId:64, Count:8, Price:32>>) ->
	{ok, [PlayerId, Count, Price]};


read(?GET_PLAYER_HIRED_INFO, _) ->
	{ok, []};


read(?SIGN_UP, <<Price:32>>) ->
	{ok, [Price]};


read(?GET_INCOME, _) ->
	{ok, []};


read(?GET_MY_HIRE, _) ->
	{ok, []};


read(?FIGHT_MY_HIRE, _) ->
	{ok, []};


read(?FIRE_MY_HIRE, _) ->
	{ok, []};


read(?HIRE_CHANGE_PRICE, <<Price:32>>) ->
	{ok, [Price]};


read(?REST_MY_HIRE, _) ->
	{ok, []};


read(_Cmd, _R) ->
	?ASSERT(false, {_Cmd, _R}),
	{error, no_match}.


write(?GET_HIRE_LIST, [RetCode, TotalCount, List]) ->
	F = fun(X) ->
			<<
				(X#hire.id): 64,
				(byte_size(X#hire.name)) : 16,
				(X#hire.name)/binary,
				(X#hire.lv) :16,
				(X#hire.faction):8,
				(X#hire.battle_power):32,
				(X#hire.left_time):8,
				(X#hire.price):32
			>>
		end,
	Len = length(List),
	BinInfo = list_to_binary([F(X) || X <- List]),
	Data = <<RetCode:8, TotalCount:32, Len:16, BinInfo/binary>>,
	{ok, pt:pack(?GET_HIRE_LIST, Data)};


write(?HIRE_PLAYER, [RetCode, PlayerId, Count]) ->
	Data = <<RetCode:8, PlayerId:64, Count:8>>,
	{ok, pt:pack(?HIRE_PLAYER, Data)};


write(?GET_PLAYER_HIRED_INFO, [PS, Hire]) ->
	{IsSignUp, LeftTime, Price, SumIncome, TaxRate, LeftChange} = 
		case Hire =:= null of
			true -> 
				TLeftTime = 
			        case lib_vip:welfare(max_hirer_times, PS) of
			            null -> 1; %%?ASSERT(false), 1;
			            T when is_integer(T) -> T
			        end,
				{0, TLeftTime, 0, 0, ?TAX_RATE, ?CHANGE_PRICE_COUNT_DAY};
			false ->
				F = fun({_PlayerId, _Name, _Time, Income}, Sum) -> Income + Sum end,
				SumIncomeAll = lists:foldl(F, 0, Hire#hire.hire_history) - Hire#hire.get_income,
				{
					1,
					Hire#hire.left_time,
					Hire#hire.price,
					SumIncomeAll - util:ceil(SumIncomeAll * (?TAX_RATE/100)),
					?TAX_RATE,
					max(?CHANGE_PRICE_COUNT_DAY - Hire#hire.change_price_count, 0)
				}
		end,

	F1 = fun({PlayerId, Name, Time, Income}) ->
			<<
				PlayerId:64,
				(byte_size(Name)):16,
				Name/binary,
				Time : 8,
				Income : 32
			>>
		end,
	{Len, BinInfo} = 
	case Hire =:= null of
		true ->
 			{0, list_to_binary([])};
 		false ->
 			{length(Hire#hire.hire_history), list_to_binary([F1(X) || X <- Hire#hire.hire_history])}
 	end,
	
	Data = <<IsSignUp:8, LeftTime:8, Price:32, SumIncome:32, TaxRate:8, LeftChange:8, Len:16, BinInfo/binary>>,
	{ok, pt:pack(?GET_PLAYER_HIRED_INFO, Data)};


write(?SIGN_UP, [RetCode]) ->
	Data = <<RetCode:8>>,
	{ok, pt:pack(?SIGN_UP, Data)};


write(?GET_INCOME, [RetCode, Income]) ->
	Data = <<RetCode:8, Income:32>>,
	{ok, pt:pack(?GET_INCOME, Data)};


write(?GET_MY_HIRE, [RetCode, Hirer]) ->
	LeftTime = Hirer#hirer.left_time, 
	IsFight = Hirer#hirer.is_fight, 
	PlayerId = Hirer#hirer.hire_id, 
	PlayerName = Hirer#hirer.hire_name, 
	PlayerLv = Hirer#hirer.hire_lv, 
	Sex = Hirer#hirer.hire_sex, 
	Faction = Hirer#hirer.hire_faction, 
	PlayerBattlePower = Hirer#hirer.hire_battle_power,
	{Weapon, Headwear, Clothes, Backwear, Race, SuitNo, MagicKey} = 
		case mod_offline_data:get_offline_bo(PlayerId, ?OBJ_PLAYER, ?SYS_HIRE) of
			null ->
				?ERROR_MSG("pt_41 failed!! PlayerId:~p~n", [PlayerId]),
				{?INVALID_NO, ?INVALID_NO, ?INVALID_NO, ?INVALID_NO, ?RACE_REN, ?INVALID_NO};
			OPlayerBo ->
				case is_record(OPlayerBo#offline_bo.showing_equips, showing_equip) of
					false -> %% 容错
						{?INVALID_NO, ?INVALID_NO, ?INVALID_NO, ?INVALID_NO, ?RACE_REN, ?INVALID_NO};
					true ->
						{
						OPlayerBo#offline_bo.showing_equips#showing_equip.weapon,
						OPlayerBo#offline_bo.showing_equips#showing_equip.headwear,
						OPlayerBo#offline_bo.showing_equips#showing_equip.clothes,
						OPlayerBo#offline_bo.showing_equips#showing_equip.backwear,
						OPlayerBo#offline_bo.race,
						OPlayerBo#offline_bo.showing_equips#showing_equip.suit_no,
						OPlayerBo#offline_bo.showing_equips#showing_equip.magic_key
						}
				end
		end,

	F = fun(X) ->
		{ParWeapon, EvolveLv, ParQuality, ParClothes} = 
			case mod_offline_data:get_offline_bo(X#par_brief.id, ?OBJ_PARTNER, ?SYS_HIRE) of
				null -> 
					{?INVALID_NO, 0, ?INVALID_NO, ?INVALID_NO};
				OParBo -> 
					case is_record(OParBo#offline_bo.showing_equips, showing_equip) of
						false -> 
							{?INVALID_NO, 0, ?INVALID_NO, ?INVALID_NO};
						true ->
							{
							OParBo#offline_bo.showing_equips#showing_equip.weapon, 
							OParBo#offline_bo.par_property#par_prop.evolve_lv,
							OParBo#offline_bo.par_property#par_prop.quality,
							OParBo#offline_bo.showing_equips#showing_equip.clothes
							}
					end
			end,
		<<
			(X#par_brief.id):64,
			(X#par_brief.no):32,
			(byte_size(X#par_brief.name)):16,
			(X#par_brief.name)/binary,
			(X#par_brief.lv):16,
			(X#par_brief.battle_power):32,
			ParWeapon : 32,
			EvolveLv : 8,
			ParQuality : 8,
			ParClothes : 32,
			(X#par_brief.position):8
		>>
	end,
	BinInfo = list_to_binary([F(X) || X <- Hirer#hirer.hire_par_list]),
	Len = length(Hirer#hirer.hire_par_list),
	Data = <<RetCode:8, LeftTime:8, IsFight:8, PlayerId:64, (byte_size(PlayerName)):16, PlayerName/binary, PlayerLv:16, Sex:8, Faction:8, Race:8,
	PlayerBattlePower:32, Weapon:32, Headwear:32, Clothes:32, Backwear:32, SuitNo:8, Len:16, BinInfo/binary, MagicKey:32>>,
	{ok, pt:pack(?GET_MY_HIRE, Data)};


write(?FIGHT_MY_HIRE, [RetCode]) ->
	Data = <<RetCode:8>>,
	{ok, pt:pack(?FIGHT_MY_HIRE, Data)};


write(?FIRE_MY_HIRE, [RetCode]) ->
	Data = <<RetCode:8>>,
	{ok, pt:pack(?FIRE_MY_HIRE, Data)};


write(?NOTIFY_MY_HIRE_INFO_CHANGE, [LeftTime]) ->
	{ok, pt:pack(?NOTIFY_MY_HIRE_INFO_CHANGE, <<LeftTime:8>>)};


write(?HIRE_CHANGE_PRICE, [RetCode, NewPrice, LeftCount]) ->
	{ok, pt:pack(?HIRE_CHANGE_PRICE, <<RetCode:8, NewPrice:32, LeftCount:8>>)};


write(?REST_MY_HIRE, [RetCode]) ->
	Data = <<RetCode:8>>,
	{ok, pt:pack(?REST_MY_HIRE, Data)};


write(_Cmd, _R) ->
	?ASSERT(false, {_Cmd, _R}),
	{ok, pt:pack(0, <<>>)}.
