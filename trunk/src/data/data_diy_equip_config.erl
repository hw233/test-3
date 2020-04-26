%%%---------------------------------------
%%% @Module  : data_diy_equip_config
%%% @Author  : lzx
%%% @Email   : 
%%% @Description: 定制装备配置表
%%%---------------------------------------


-module(data_diy_equip_config).
-compile(export_all).

-include("diy.hrl").
-include("debug.hrl").

get(1) ->
	#diy_equip_config{
		no = 1,
		type = 1,
		equip_no = [284107,284157,284207,284257,284307,284357,281007,281057,282007,282057,283007,286007,285007],
		equip_add_attr_num = 3,
		equip_add_attr = [{talent_str,30},{talent_con,30},{talent_sta,30},{talent_spi,30},{talent_agi,30},{phy_crit,80},{phy_ten,80},{mag_crit,80},{mag_ten,80},{phy_crit_coef,80},{mag_crit_coef,80},{revive_heal_coef,3000},{heal_value,300},{seal_hit_to_partner,3000},{seal_hit_to_mon,3000},{phy_dam_to_partner,3000},{phy_dam_to_mon,3000},{mag_dam_to_partner,3000},{mag_dam_to_mon,3000},{be_chaos_round_repair,2500},{chaos_round_repair,2500},{be_froze_round_repair,2500},{froze_round_repair,2500},{neglect_phy_def,500},{neglect_mag_def,500},{neglect_seal_resis,500},{phy_dam_to_speed_1,2000},{phy_dam_to_speed_2,1000},{mag_dam_to_speed_1,2000},{mag_dam_to_speed_2,1000},{seal_hit_to_speed,1200}],
		equip_effect_num = 1,
		equip_effect_no = [1,2,3,4,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52],
		equip_skill_num = 1,
		equip_skill_no = [90011,90012,90013,90014,90017,90019,90020,90021,90022,90023,90024,90025,90026,90027,90029,90030,90031,90032,90033,90034,90035,90048,90049,92001,92002,92003,92004,92005,92006,92007,92008,92009,92010,92011,92012,92013,92014,92015,92016,92017,92018,92019,92020,92021,92022,92023,92024,92025,92026],
		cost = [{89318,1},{89324,50}]
};

get(2) ->
	#diy_equip_config{
		no = 2,
		type = 2,
		equip_no = [284108,284158,284208,284258,284308,284358,281008,281058,282008,282058,283008,286008,285008],
		equip_add_attr_num = 3,
		equip_add_attr = [{talent_str,35},{talent_con,35},{talent_sta,35},{talent_spi,35},{talent_agi,35},{phy_crit,100},{phy_ten,100},{mag_crit,100},{mag_ten,100},{phy_crit_coef,100},{mag_crit_coef,100},{revive_heal_coef,4000},{heal_value,400},{seal_hit_to_partner,3500},{seal_hit_to_mon,3500},{phy_dam_to_partner,3500},{phy_dam_to_mon,3500},{mag_dam_to_partner,3500},{mag_dam_to_mon,3500},{be_chaos_round_repair,3000},{chaos_round_repair,3000},{be_froze_round_repair,3000},{froze_round_repair,3000},{neglect_phy_def,650},{neglect_mag_def,650},{neglect_seal_resis,600},{phy_dam_to_speed_1,2500},{phy_dam_to_speed_2,1200},{mag_dam_to_speed_1,2500},{mag_dam_to_speed_2,1200},{seal_hit_to_speed,1500}],
		equip_effect_num = 1,
		equip_effect_no = [1,2,3,4,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68],
		equip_skill_num = 1,
		equip_skill_no = [90011,90012,90013,90014,90017,90019,90020,90021,90022,90023,90024,90025,90026,90027,90029,90030,90031,90032,90033,90034,90035,90048,90049,92001,92002,92003,92004,92005,92006,92007,92008,92009,92010,92011,92012,92013,92014,92015,92016,92017,92018,92019,92020,92021,92022,92023,92024,92025,92026],
		cost = [{89319,1},{89324,200}]
};

get(3) ->
	#diy_equip_config{
		no = 3,
		type = 3,
		equip_no = [284109,284159,284209,284259,284309,284359,281009,281059,282009,282059,283009,286009,285009],
		equip_add_attr_num = 3,
		equip_add_attr = [{talent_str,40},{talent_con,40},{talent_sta,40},{talent_spi,40},{talent_agi,40},{phy_crit,120},{phy_ten,120},{mag_crit,120},{mag_ten,120},{phy_crit_coef,120},{mag_crit_coef,120},{revive_heal_coef,4500},{heal_value,450},{seal_hit_to_partner,3800},{seal_hit_to_mon,3800},{phy_dam_to_partner,3800},{phy_dam_to_mon,3800},{mag_dam_to_partner,3800},{mag_dam_to_mon,3800},{be_chaos_round_repair,3500},{chaos_round_repair,3500},{be_froze_round_repair,3500},{froze_round_repair,3500},{neglect_phy_def,800},{neglect_mag_def,800},{neglect_seal_resis,700},{phy_dam_to_speed_1,3000},{phy_dam_to_speed_2,1400},{mag_dam_to_speed_1,3000},{mag_dam_to_speed_2,1400},{seal_hit_to_speed,1800}],
		equip_effect_num = 1,
		equip_effect_no = [1,2,3,4,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116],
		equip_skill_num = 1,
		equip_skill_no = [90011,90012,90013,90014,90017,90019,90020,90021,90022,90023,90024,90025,90026,90027,90029,90030,90031,90032,90033,90034,90035,90048,90049,92001,92002,92003,92004,92005,92006,92007,92008,92009,92010,92011,92012,92013,92014,92015,92016,92017,92018,92019,92020,92021,92022,92023,92024,92025,92026],
		cost = [{89320,1},{89324,500}]
};

get(4) ->
	#diy_equip_config{
		no = 4,
		type = 4,
		equip_no = [284110,284160,284210,284260,284310,284360,281010,281060,282010,282060,283010,286010,285010],
		equip_add_attr_num = 3,
		equip_add_attr = [{talent_str,45},{talent_con,45},{talent_sta,45},{talent_spi,45},{talent_agi,45},{phy_crit,150},{phy_ten,150},{mag_crit,150},{mag_ten,150},{phy_crit_coef,150},{mag_crit_coef,150},{revive_heal_coef,5000},{heal_value,500},{seal_hit_to_partner,4200},{seal_hit_to_mon,4200},{phy_dam_to_partner,4200},{phy_dam_to_mon,4200},{mag_dam_to_partner,4200},{mag_dam_to_mon,4200},{be_chaos_round_repair,4000},{chaos_round_repair,4000},{be_froze_round_repair,4000},{froze_round_repair,4000},{neglect_phy_def,1000},{neglect_mag_def,1000},{neglect_seal_resis,800},{phy_dam_to_speed_1,3500},{phy_dam_to_speed_2,1600},{mag_dam_to_speed_1,3500},{mag_dam_to_speed_2,1600},{seal_hit_to_speed,2100}],
		equip_effect_num = 1,
		equip_effect_no = [1,2,3,4,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100],
		equip_skill_num = 1,
		equip_skill_no = [90011,90012,90013,90014,90017,90019,90020,90021,90022,90023,90024,90025,90026,90027,90029,90030,90031,90032,90033,90034,90035,90048,90049,92001,92002,92003,92004,92005,92006,92007,92008,92009,92010,92011,92012,92013,92014,92015,92016,92017,92018,92019,92020,92021,92022,92023,92024,92025,92026],
		cost = [{89321,1},{89324,900}]
};

get(5) ->
	#diy_equip_config{
		no = 5,
		type = 5,
		equip_no = [284111,284161,284211,284261,284311,284361,281011,281061,282011,282061,283011,286011,285011],
		equip_add_attr_num = 3,
		equip_add_attr = [{talent_str,50},{talent_con,50},{talent_sta,50},{talent_spi,50},{talent_agi,50},{phy_crit,180},{phy_ten,180},{mag_crit,180},{mag_ten,180},{phy_crit_coef,180},{mag_crit_coef,180},{revive_heal_coef,6000},{heal_value,600},{seal_hit_to_partner,5000},{seal_hit_to_mon,5000},{phy_dam_to_partner,5000},{phy_dam_to_mon,5000},{mag_dam_to_partner,5000},{mag_dam_to_mon,5000},{be_chaos_round_repair,4500},{chaos_round_repair,4500},{be_froze_round_repair,4500},{froze_round_repair,4500},{neglect_phy_def,1200},{neglect_mag_def,1200},{neglect_seal_resis,900},{phy_dam_to_speed_1,4500},{phy_dam_to_speed_2,1800},{mag_dam_to_speed_1,4500},{mag_dam_to_speed_2,1800},{seal_hit_to_speed,2400}],
		equip_effect_num = 1,
		equip_effect_no = [1,2,3,4,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84],
		equip_skill_num = 1,
		equip_skill_no = [90011,90012,90013,90014,90017,90019,90020,90021,90022,90023,90024,90025,90026,90027,90029,90030,90031,90032,90033,90034,90035,90048,90049,92001,92002,92003,92004,92005,92006,92007,92008,92009,92010,92011,92012,92013,92014,92015,92016,92017,92018,92019,92020,92021,92022,92023,92024,92025,92026],
		cost = [{89322,1},{89324,1500}]
};

get(_No) ->
	?ASSERT(false, {_No}),
    null.

