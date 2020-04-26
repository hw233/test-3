-ifndef(__REF_ATTR_HRL__).
-define(__REF_ATTR_HRL__, ref_attr_hrl).


-record(ref_attr,	{
		id = 100006,
		hp_lim = 49330,
	  hp  =49330,
		mp_lim = 9866,
	  mp  =9866,
		phy_att = 9866,
		mag_att = 9866,
		phy_def = 5920,
		mag_def = 5920,
		act_speed = 789,
		seal_hit = 987,
		seal_resis = 987,
		heal_value = 0,
		do_phy_dam_scaling = 0,
		do_mag_dam_scaling = 0,
		be_phy_dam_reduce_coef = 0,
		be_mag_dam_reduce_coef = 0,
		be_heal_eff_coef = 0,
		crit = 20,
		ten = 20,
		crit_coef = 2,
		revive_heal_coef = 0,
		phy_crit = 0,
		phy_ten = 0,
		mag_crit = 0,
		mag_ten = 0,
		phy_crit_coef = 0,
		mag_crit_coef = 0,
		neglect_phy_def = 0,
		neglect_mag_def = 0,
		neglect_seal_resis = 0,
		absorb_hp_coef = 0,
		qugui_coef = 1,
		be_phy_dam_shrink = 0,
		be_mag_dam_shrink = 0,
		talent_str = 0,
		talent_con = 0,
		talent_sta = 0,
		talent_spi = 0,
		talent_agi = 0,
		be_chaos_att_team_paoba = 0,
		be_chaos_att_team_phy_dam = 0,
		phy_dam_to_partner = 0,
		mag_dam_to_partner = 0,
		phy_dam_to_speed_1 = 0,
		phy_dam_to_speed_2 = 0,
		mag_dam_to_speed_1 = 0,
		mag_dam_to_speed_2 = 0,
		seal_hit_to_speed = 0,
		be_chaos_round_repair = 0,
		chaos_round_repair = 0,
		be_froze_round_repair = 0,
		froze_round_repair = 0
}).




















-endif.