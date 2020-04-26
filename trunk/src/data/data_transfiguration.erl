%%%---------------------------------------
%%% @Module  : data_transfiguration
%%% @Author  : dsh
%%% @Email   : 
%%% @Description:  老虎机
%%%---------------------------------------


-module(data_transfiguration).

-include("transfiguration.hrl").
-include("debug.hrl").
-compile(export_all).

get(1) ->
	#transfiguration_config{
		no = 1,
		add_attr = [{phy_att,0,0.08},{mag_att,0,-0.05},{phy_def,0,0.03},{mag_def,0,-0.03},{hp_lim,0,-0.05},{act_speed,0,0.02},{seal_hit,0,0},{seal_resis,0,0},{phy_crit,100,0},{phy_ten,0,0},{phy_crit_coef,0,0},{mag_crit,0,0},{mag_ten,0,0},{mag_crit_coef,0,0},{heal_value,0,0},{do_mag_dam_scaling,0,0},{do_phy_dam_scaling,0.1,0},{be_phy_dam_reduce_coef,0,0},{be_mag_dam_reduce_coef,0,0},{revive_heal_coef,0,0},{ret_dam_proba,0,0},{ret_dam_coef,0,0}]
};

get(2) ->
	#transfiguration_config{
		no = 2,
		add_attr = [{phy_att,0,-0.05},{mag_att,0,0.08},{phy_def,0,-0.03},{mag_def,0,0.03},{hp_lim,0,-0.05},{act_speed,0,0.02},{seal_hit,0,0},{seal_resis,0,0},{phy_crit,0,0},{phy_ten,0,0},{phy_crit_coef,0,0},{mag_crit,100,0},{mag_ten,0,0},{mag_crit_coef,0,0},{heal_value,0,0},{do_mag_dam_scaling,0,0},{do_phy_dam_scaling,0,0},{be_phy_dam_reduce_coef,0,0},{be_mag_dam_reduce_coef,0,0},{revive_heal_coef,0,0},{ret_dam_proba,0,0},{ret_dam_coef,0,0}]
};

get(3) ->
	#transfiguration_config{
		no = 3,
		add_attr = [{phy_att,0,-0.05},{mag_att,0,-0.05},{phy_def,0,0.03},{mag_def,0,0.03},{hp_lim,0,0.1},{act_speed,0,-0.06},{seal_hit,0,0},{seal_resis,0,0},{phy_crit,0,0},{phy_ten,100,0},{phy_crit_coef,0,0},{mag_crit,0,0},{mag_ten,100,0},{mag_crit_coef,0,0},{heal_value,0,0},{do_mag_dam_scaling,0,0},{do_phy_dam_scaling,0,0},{be_phy_dam_reduce_coef,0.05,0},{be_mag_dam_reduce_coef,0.05,0},{revive_heal_coef,0,0},{ret_dam_proba,0,0},{ret_dam_coef,0,0}]
};

get(4) ->
	#transfiguration_config{
		no = 4,
		add_attr = [{phy_att,0,-0.08},{mag_att,0,0.12},{phy_def,0,0.03},{mag_def,0,0.03},{hp_lim,0,0},{act_speed,0,-0.1},{seal_hit,0,0},{seal_resis,0,0},{phy_crit,0,0},{phy_ten,0,0},{phy_crit_coef,0,0},{mag_crit,50,0},{mag_ten,0,0},{mag_crit_coef,0,0},{heal_value,0,0},{do_mag_dam_scaling,0.1,0},{do_phy_dam_scaling,0,0},{be_phy_dam_reduce_coef,0,0},{be_mag_dam_reduce_coef,0,0},{revive_heal_coef,0,0},{ret_dam_proba,0,0},{ret_dam_coef,0,0}]
};

get(5) ->
	#transfiguration_config{
		no = 5,
		add_attr = [{phy_att,0,-0.05},{mag_att,0,0.08},{phy_def,0,0},{mag_def,0,0.03},{hp_lim,0,-0.01},{act_speed,0,-0.05},{seal_hit,0,0},{seal_resis,0,0},{phy_crit,0,0},{phy_ten,0,0},{phy_crit_coef,0,0},{mag_crit,0,0},{mag_ten,0,0},{mag_crit_coef,0,0},{heal_value,0,0},{do_mag_dam_scaling,0.08,0},{do_phy_dam_scaling,0,0},{be_phy_dam_reduce_coef,0.08,0},{be_mag_dam_reduce_coef,0.05,0},{revive_heal_coef,0,0},{ret_dam_proba,0,0},{ret_dam_coef,0,0}]
};

get(6) ->
	#transfiguration_config{
		no = 6,
		add_attr = [{phy_att,0,0.1},{mag_att,0,-0.1},{phy_def,0,0.03},{mag_def,0,0.03},{hp_lim,0,-0.02},{act_speed,0,-0.04},{seal_hit,0,0},{seal_resis,0,0},{phy_crit,0,0},{phy_ten,0,0},{phy_crit_coef,0.15,0},{mag_crit,0,0},{mag_ten,0,0},{mag_crit_coef,0,0},{heal_value,0,0},{do_mag_dam_scaling,0,0},{do_phy_dam_scaling,0.08,0},{be_phy_dam_reduce_coef,0,0},{be_mag_dam_reduce_coef,0,0},{revive_heal_coef,0,0},{ret_dam_proba,0,0},{ret_dam_coef,0,0}]
};

get(7) ->
	#transfiguration_config{
		no = 7,
		add_attr = [{phy_att,0,0.12},{mag_att,0,-0.1},{phy_def,0,0.02},{mag_def,0,0.02},{hp_lim,0,-0.04},{act_speed,0,-0.02},{seal_hit,0,0},{seal_resis,0,0},{phy_crit,120,0},{phy_ten,0,0},{phy_crit_coef,0,0},{mag_crit,0,0},{mag_ten,0,0},{mag_crit_coef,0,0},{heal_value,0,0},{do_mag_dam_scaling,0,0},{do_phy_dam_scaling,0.05,0},{be_phy_dam_reduce_coef,0,0},{be_mag_dam_reduce_coef,0,0},{revive_heal_coef,0,0},{ret_dam_proba,0,0},{ret_dam_coef,0,0}]
};

get(8) ->
	#transfiguration_config{
		no = 8,
		add_attr = [{phy_att,0,0.08},{mag_att,0,-0.08},{phy_def,0,0.02},{mag_def,0,0.02},{hp_lim,0,0.06},{act_speed,0,-0.1},{seal_hit,150,0},{seal_resis,150,0},{phy_crit,0,0},{phy_ten,0,0},{phy_crit_coef,0,0},{mag_crit,0,0},{mag_ten,0,0},{mag_crit_coef,0,0},{heal_value,0,0},{do_mag_dam_scaling,0,0},{do_phy_dam_scaling,0,0},{be_phy_dam_reduce_coef,0,0},{be_mag_dam_reduce_coef,0,0},{revive_heal_coef,0,0},{ret_dam_proba,0,0},{ret_dam_coef,0,0}]
};

get(9) ->
	#transfiguration_config{
		no = 9,
		add_attr = [{phy_att,0,-0.1},{mag_att,0,0.12},{phy_def,0,0},{mag_def,0,0.03},{hp_lim,0,0.05},{act_speed,0,-0.1},{seal_hit,0,0},{seal_resis,0,0},{phy_crit,0,0},{phy_ten,0,0},{phy_crit_coef,0,0},{mag_crit,30,0},{mag_ten,0,0},{mag_crit_coef,0,0},{heal_value,0,0},{do_mag_dam_scaling,0.05,0},{do_phy_dam_scaling,0,0},{be_phy_dam_reduce_coef,0,0},{be_mag_dam_reduce_coef,0,0},{revive_heal_coef,0,0},{ret_dam_proba,300,0},{ret_dam_coef,0.3,0}]
};

get(10) ->
	#transfiguration_config{
		no = 10,
		add_attr = [{phy_att,0,-0.1},{mag_att,0,-0.1},{phy_def,0,0.03},{mag_def,0,0.03},{hp_lim,0,0.06},{act_speed,0,0.08},{seal_hit,0,0},{seal_resis,0,0},{phy_crit,0,0},{phy_ten,0,0},{phy_crit_coef,0,0},{mag_crit,0,0},{mag_ten,0,0},{mag_crit_coef,0,0},{heal_value,0,0},{do_mag_dam_scaling,0,0},{do_phy_dam_scaling,0,0},{be_phy_dam_reduce_coef,0,0},{be_mag_dam_reduce_coef,0,0},{revive_heal_coef,0,0},{ret_dam_proba,400,0},{ret_dam_coef,0.4,0}]
};

get(11) ->
	#transfiguration_config{
		no = 11,
		add_attr = [{phy_att,0,-0.12},{mag_att,0,0.12},{phy_def,0,0},{mag_def,0,0},{hp_lim,0,0},{act_speed,0,0},{seal_hit,0,0},{seal_resis,0,0},{phy_crit,0,0},{phy_ten,75,0},{phy_crit_coef,0,0},{mag_crit,0,0},{mag_ten,120,0},{mag_crit_coef,0,0},{heal_value,0,0},{do_mag_dam_scaling,0.03,0},{do_phy_dam_scaling,0,0},{be_phy_dam_reduce_coef,0.1,0},{be_mag_dam_reduce_coef,0.1,0},{revive_heal_coef,0,0},{ret_dam_proba,0,0},{ret_dam_coef,0,0}]
};

get(12) ->
	#transfiguration_config{
		no = 12,
		add_attr = [{phy_att,0,0.12},{mag_att,0,-0.12},{phy_def,0,0},{mag_def,0,0},{hp_lim,0,0},{act_speed,0,0},{seal_hit,0,0},{seal_resis,0,0},{phy_crit,0,0},{phy_ten,120,0},{phy_crit_coef,0.1,0},{mag_crit,0,0},{mag_ten,75,0},{mag_crit_coef,0,0},{heal_value,0,0},{do_mag_dam_scaling,0,0},{do_phy_dam_scaling,0,0},{be_phy_dam_reduce_coef,0,0},{be_mag_dam_reduce_coef,0,0},{revive_heal_coef,0,0},{ret_dam_proba,0,0},{ret_dam_coef,0,0}]
};

get(13) ->
	#transfiguration_config{
		no = 13,
		add_attr = [{phy_att,0,0.12},{mag_att,0,-0.12},{phy_def,0,-0.03},{mag_def,0,-0.03},{hp_lim,0,-0.06},{act_speed,0,0.12},{seal_hit,0,0},{seal_resis,0,0},{phy_crit,100,0},{phy_ten,0,0},{phy_crit_coef,0.2,0},{mag_crit,0,0},{mag_ten,0,0},{mag_crit_coef,0,0},{heal_value,0,0},{do_mag_dam_scaling,0,0},{do_phy_dam_scaling,0,0},{be_phy_dam_reduce_coef,-0.05,0},{be_mag_dam_reduce_coef,-0.05,0},{revive_heal_coef,0,0},{ret_dam_proba,0,0},{ret_dam_coef,0,0}]
};

get(14) ->
	#transfiguration_config{
		no = 14,
		add_attr = [{phy_att,0,0.14},{mag_att,0,-0.12},{phy_def,0,0.01},{mag_def,0,0.01},{hp_lim,0,-0.01},{act_speed,0,-0.03},{seal_hit,0,0},{seal_resis,0,0},{phy_crit,70,0},{phy_ten,0,0},{phy_crit_coef,0.3,0},{mag_crit,0,0},{mag_ten,0,0},{mag_crit_coef,0,0},{heal_value,0,0},{do_mag_dam_scaling,0,0},{do_phy_dam_scaling,0,0},{be_phy_dam_reduce_coef,0,0},{be_mag_dam_reduce_coef,0,0},{revive_heal_coef,0,0},{ret_dam_proba,0,0},{ret_dam_coef,0,0}]
};

get(15) ->
	#transfiguration_config{
		no = 15,
		add_attr = [{phy_att,0,-0.14},{mag_att,0,0.14},{phy_def,0,0.01},{mag_def,0,0.01},{hp_lim,0,0.01},{act_speed,0,-0.03},{seal_hit,0,0},{seal_resis,0,0},{phy_crit,0,0},{phy_ten,0,0},{phy_crit_coef,0,0},{mag_crit,70,0},{mag_ten,0,0},{mag_crit_coef,0.3,0},{heal_value,0,0},{do_mag_dam_scaling,0,0},{do_phy_dam_scaling,0,0},{be_phy_dam_reduce_coef,0,0},{be_mag_dam_reduce_coef,0,0},{revive_heal_coef,0,0},{ret_dam_proba,0,0},{ret_dam_coef,0,0}]
};

get(16) ->
	#transfiguration_config{
		no = 16,
		add_attr = [{phy_att,0,-0.12},{mag_att,0,0.15},{phy_def,0,0},{mag_def,0,0},{hp_lim,0,0.08},{act_speed,0,-0.11},{seal_hit,0,0},{seal_resis,0,0},{phy_crit,0,0},{phy_ten,0,0},{phy_crit_coef,0,0},{mag_crit,0,0},{mag_ten,0,0},{mag_crit_coef,0,0},{heal_value,0,0},{do_mag_dam_scaling,0.08,0},{do_phy_dam_scaling,0,0},{be_phy_dam_reduce_coef,0,0},{be_mag_dam_reduce_coef,0,0},{revive_heal_coef,0,0},{ret_dam_proba,0,0},{ret_dam_coef,0,0}]
};

get(17) ->
	#transfiguration_config{
		no = 17,
		add_attr = [{phy_att,0,0.1},{mag_att,0,-0.1},{phy_def,0,-0.03},{mag_def,0,-0.03},{hp_lim,0,0.06},{act_speed,0,0},{seal_hit,180,0},{seal_resis,200,0},{phy_crit,0,0},{phy_ten,0,0},{phy_crit_coef,0,0},{mag_crit,0,0},{mag_ten,0,0},{mag_crit_coef,0,0},{heal_value,0,0},{do_mag_dam_scaling,0,0},{do_phy_dam_scaling,0,0},{be_phy_dam_reduce_coef,0,0},{be_mag_dam_reduce_coef,0,0},{revive_heal_coef,0,0},{ret_dam_proba,0,0},{ret_dam_coef,0,0}]
};

get(18) ->
	#transfiguration_config{
		no = 18,
		add_attr = [{phy_att,0,-0.13},{mag_att,0,0.12},{phy_def,0,-0.02},{mag_def,0,-0.02},{hp_lim,0,0.02},{act_speed,0,0.03},{seal_hit,180,0},{seal_resis,200,0},{phy_crit,0,0},{phy_ten,0,0},{phy_crit_coef,0,0},{mag_crit,0,0},{mag_ten,0,0},{mag_crit_coef,0,0},{heal_value,0,0},{do_mag_dam_scaling,0,0},{do_phy_dam_scaling,0,0},{be_phy_dam_reduce_coef,0,0},{be_mag_dam_reduce_coef,0,0},{revive_heal_coef,0,0},{ret_dam_proba,0,0},{ret_dam_coef,0,0}]
};

get(19) ->
	#transfiguration_config{
		no = 19,
		add_attr = [{phy_att,0,0.15},{mag_att,0,-0.15},{phy_def,0,-0.03},{mag_def,0,-0.03},{hp_lim,0,0},{act_speed,0,0.06},{seal_hit,0,0},{seal_resis,0,0},{phy_crit,120,0},{phy_ten,0,0},{phy_crit_coef,0.1,0},{mag_crit,0,0},{mag_ten,0,0},{mag_crit_coef,0,0},{heal_value,0,0},{do_mag_dam_scaling,0,0},{do_phy_dam_scaling,0.03,0},{be_phy_dam_reduce_coef,0,0},{be_mag_dam_reduce_coef,0,0},{revive_heal_coef,0,0},{ret_dam_proba,0,0},{ret_dam_coef,0,0}]
};

get(20) ->
	#transfiguration_config{
		no = 20,
		add_attr = [{phy_att,0,-0.14},{mag_att,0,0.14},{phy_def,0,0.01},{mag_def,0,0.01},{hp_lim,0,-0.02},{act_speed,0,0},{seal_hit,0,0},{seal_resis,0,0},{phy_crit,0,0},{phy_ten,150,0},{phy_crit_coef,0,0},{mag_crit,0,0},{mag_ten,150,0},{mag_crit_coef,0,0},{heal_value,0,0},{do_mag_dam_scaling,0.05,0},{do_phy_dam_scaling,0,0},{be_phy_dam_reduce_coef,0,0},{be_mag_dam_reduce_coef,0,0},{revive_heal_coef,0,0},{ret_dam_proba,0,0},{ret_dam_coef,0,0}]
};

get(21) ->
	#transfiguration_config{
		no = 21,
		add_attr = [{phy_att,0,0.14},{mag_att,0,-0.14},{phy_def,0,0.03},{mag_def,0,0.03},{hp_lim,0,0.08},{act_speed,0,-0.14},{seal_hit,0,0},{seal_resis,0,0},{phy_crit,0,0},{phy_ten,120,0},{phy_crit_coef,0,0},{mag_crit,0,0},{mag_ten,120,0},{mag_crit_coef,0,0},{heal_value,200,0},{do_mag_dam_scaling,0,0},{do_phy_dam_scaling,0,0},{be_phy_dam_reduce_coef,0.03,0},{be_mag_dam_reduce_coef,0.03,0},{revive_heal_coef,0,0},{ret_dam_proba,0,0},{ret_dam_coef,0,0}]
};

get(22) ->
	#transfiguration_config{
		no = 22,
		add_attr = [{phy_att,0,-0.15},{mag_att,0,-0.15},{phy_def,0,0.05},{mag_def,0,0.05},{hp_lim,0,0.1},{act_speed,0,0.1},{seal_hit,0,0},{seal_resis,0,0},{phy_crit,0,0},{phy_ten,0,0},{phy_crit_coef,0,0},{mag_crit,0,0},{mag_ten,0,0},{mag_crit_coef,0,0},{heal_value,0,0},{do_mag_dam_scaling,0,0},{do_phy_dam_scaling,0,0},{be_phy_dam_reduce_coef,0.1,0},{be_mag_dam_reduce_coef,0.1,0},{revive_heal_coef,3000,0},{ret_dam_proba,300,0},{ret_dam_coef,0.4,0}]
};

get(23) ->
	#transfiguration_config{
		no = 23,
		add_attr = [{phy_att,0,0.15},{mag_att,0,-0.15},{phy_def,0,-0.03},{mag_def,0,-0.03},{hp_lim,0,-0.07},{act_speed,0,0.13},{seal_hit,0,0},{seal_resis,0,0},{phy_crit,250,0},{phy_ten,0,0},{phy_crit_coef,0.3,0},{mag_crit,0,0},{mag_ten,0,0},{mag_crit_coef,0,0},{heal_value,0,0},{do_mag_dam_scaling,0,0},{do_phy_dam_scaling,0,0},{be_phy_dam_reduce_coef,0,0},{be_mag_dam_reduce_coef,0,0},{revive_heal_coef,0,0},{ret_dam_proba,0,0},{ret_dam_coef,0,0}]
};

get(24) ->
	#transfiguration_config{
		no = 24,
		add_attr = [{phy_att,0,-0.15},{mag_att,0,0.15},{phy_def,0,-0.03},{mag_def,0,-0.03},{hp_lim,0,-0.07},{act_speed,0,0.13},{seal_hit,0,0},{seal_resis,0,0},{phy_crit,0,0},{phy_ten,0,0},{phy_crit_coef,0,0},{mag_crit,250,0},{mag_ten,0,0},{mag_crit_coef,0.3,0},{heal_value,0,0},{do_mag_dam_scaling,0,0},{do_phy_dam_scaling,0,0},{be_phy_dam_reduce_coef,0,0},{be_mag_dam_reduce_coef,0,0},{revive_heal_coef,0,0},{ret_dam_proba,0,0},{ret_dam_coef,0,0}]
};

get(25) ->
	#transfiguration_config{
		no = 25,
		add_attr = [{phy_att,0,0.18},{mag_att,0,-0.18},{phy_def,0,0.02},{mag_def,0,0.01},{hp_lim,0,0.09},{act_speed,0,-0.12},{seal_hit,300,0},{seal_resis,300,0},{phy_crit,0,0},{phy_ten,0,0},{phy_crit_coef,0,0},{mag_crit,0,0},{mag_ten,0,0},{mag_crit_coef,0,0},{heal_value,0,0},{do_mag_dam_scaling,0,0},{do_phy_dam_scaling,0,0},{be_phy_dam_reduce_coef,0,0},{be_mag_dam_reduce_coef,0,0},{revive_heal_coef,0,0},{ret_dam_proba,300,0},{ret_dam_coef,0.4,0}]
};

get(26) ->
	#transfiguration_config{
		no = 26,
		add_attr = [{phy_att,0,0.18},{mag_att,0,-0.18},{phy_def,0,-0.03},{mag_def,0,-0.03},{hp_lim,0,-0.08},{act_speed,0,0.14},{seal_hit,120,0},{seal_resis,120,0},{phy_crit,0,0},{phy_ten,0,0},{phy_crit_coef,0,0},{mag_crit,0,0},{mag_ten,0,0},{mag_crit_coef,0,0},{heal_value,300,0},{do_mag_dam_scaling,0,0},{do_phy_dam_scaling,0,0},{be_phy_dam_reduce_coef,0,0},{be_mag_dam_reduce_coef,0,0},{revive_heal_coef,0,0},{ret_dam_proba,0,0},{ret_dam_coef,0,0}]
};

get(27) ->
	#transfiguration_config{
		no = 27,
		add_attr = [{phy_att,0,-0.18},{mag_att,0,0.18},{phy_def,0,0},{mag_def,0,0},{hp_lim,0,0.1},{act_speed,0,-0.1},{seal_hit,0,0},{seal_resis,0,0},{phy_crit,0,0},{phy_ten,0,0},{phy_crit_coef,0,0},{mag_crit,0,0},{mag_ten,0,0},{mag_crit_coef,0.2,0},{heal_value,0,0},{do_mag_dam_scaling,0.1,0},{do_phy_dam_scaling,0,0},{be_phy_dam_reduce_coef,0,0},{be_mag_dam_reduce_coef,0,0},{revive_heal_coef,0,0},{ret_dam_proba,300,0},{ret_dam_coef,0.3,0}]
};

get(28) ->
	#transfiguration_config{
		no = 28,
		add_attr = [{phy_att,0,0.18},{mag_att,0,-0.2},{phy_def,0,0},{mag_def,0,0},{hp_lim,0,-0.03},{act_speed,0,0.05},{seal_hit,0,0},{seal_resis,0,0},{phy_crit,130,0},{phy_ten,0,0},{phy_crit_coef,0.2,0},{mag_crit,0,0},{mag_ten,0,0},{mag_crit_coef,0,0},{heal_value,0,0},{do_mag_dam_scaling,0,0},{do_phy_dam_scaling,0.09,0},{be_phy_dam_reduce_coef,0,0},{be_mag_dam_reduce_coef,0,0},{revive_heal_coef,0,0},{ret_dam_proba,0,0},{ret_dam_coef,0,0}]
};

get(29) ->
	#transfiguration_config{
		no = 29,
		add_attr = [{phy_att,0,0.18},{mag_att,0,-0.2},{phy_def,0,-0.02},{mag_def,0,-0.02},{hp_lim,0,-0.04},{act_speed,0,0.1},{seal_hit,0,0},{seal_resis,0,0},{phy_crit,200,0},{phy_ten,0,0},{phy_crit_coef,0,0},{mag_crit,0,0},{mag_ten,0,0},{mag_crit_coef,0,0},{heal_value,0,0},{do_mag_dam_scaling,0,0},{do_phy_dam_scaling,0,0},{be_phy_dam_reduce_coef,0,0},{be_mag_dam_reduce_coef,0,0},{revive_heal_coef,3800,0},{ret_dam_proba,0,0},{ret_dam_coef,0,0}]
};

get(30) ->
	#transfiguration_config{
		no = 30,
		add_attr = [{phy_att,0,0.18},{mag_att,0,-0.2},{phy_def,0,0.01},{mag_def,0,0.01},{hp_lim,0,0},{act_speed,0,0},{seal_hit,0,0},{seal_resis,0,0},{phy_crit,200,0},{phy_ten,0,0},{phy_crit_coef,0,0},{mag_crit,0,0},{mag_ten,0,0},{mag_crit_coef,0,0},{heal_value,0,0},{do_mag_dam_scaling,0,0},{do_phy_dam_scaling,0.1,0},{be_phy_dam_reduce_coef,0,0},{be_mag_dam_reduce_coef,0,0},{revive_heal_coef,0,0},{ret_dam_proba,0,0},{ret_dam_coef,0,0}]
};

get(31) ->
	#transfiguration_config{
		no = 31,
		add_attr = [{phy_att,0,0.16},{mag_att,0,-0.2},{phy_def,0,0.02},{mag_def,0,0.02},{hp_lim,0,0.08},{act_speed,0,-0.08},{seal_hit,0,0},{seal_resis,0,0},{phy_crit,0,0},{phy_ten,0,0},{phy_crit_coef,0.3,0},{mag_crit,0,0},{mag_ten,0,0},{mag_crit_coef,0,0},{heal_value,0,0},{do_mag_dam_scaling,0,0},{do_phy_dam_scaling,0,0},{be_phy_dam_reduce_coef,0.2,0},{be_mag_dam_reduce_coef,0.2,0},{revive_heal_coef,0,0},{ret_dam_proba,0,0},{ret_dam_coef,0,0}]
};

get(32) ->
	#transfiguration_config{
		no = 32,
		add_attr = [{phy_att,0,-0.14},{mag_att,0,0.2},{phy_def,0,-0.02},{mag_def,0,-0.02},{hp_lim,0,-0.02},{act_speed,0,0},{seal_hit,0,0},{seal_resis,0,0},{phy_crit,0,0},{phy_ten,0,0},{phy_crit_coef,0,0},{mag_crit,200,0},{mag_ten,0,0},{mag_crit_coef,0.2,0},{heal_value,0,0},{do_mag_dam_scaling,0.08,0},{do_phy_dam_scaling,0,0},{be_phy_dam_reduce_coef,0,0},{be_mag_dam_reduce_coef,0,0},{revive_heal_coef,0,0},{ret_dam_proba,0,0},{ret_dam_coef,0,0}]
};

get(33) ->
	#transfiguration_config{
		no = 33,
		add_attr = [{phy_att,0,0.09},{mag_att,0,-0.2},{phy_def,0,0},{mag_def,0,0},{hp_lim,0,-0.04},{act_speed,0,0.15},{seal_hit,120,0},{seal_resis,120,0},{phy_crit,120,0},{phy_ten,120,0},{phy_crit_coef,0.1,0},{mag_crit,0,0},{mag_ten,0,0},{mag_crit_coef,0,0},{heal_value,300,0},{do_mag_dam_scaling,0,0},{do_phy_dam_scaling,0,0},{be_phy_dam_reduce_coef,0,0},{be_mag_dam_reduce_coef,0,0},{revive_heal_coef,0,0},{ret_dam_proba,0,0},{ret_dam_coef,0,0}]
};

get(34) ->
	#transfiguration_config{
		no = 34,
		add_attr = [{phy_att,0,-0.2},{mag_att,0,0.17},{phy_def,0,0.01},{mag_def,0,0.01},{hp_lim,0,0.09},{act_speed,0,-0.08},{seal_hit,0,0},{seal_resis,0,0},{phy_crit,0,0},{phy_ten,200,0},{phy_crit_coef,0,0},{mag_crit,0,0},{mag_ten,200,0},{mag_crit_coef,0,0},{heal_value,400,0},{do_mag_dam_scaling,0,0},{do_phy_dam_scaling,0,0},{be_phy_dam_reduce_coef,0.15,0},{be_mag_dam_reduce_coef,0.15,0},{revive_heal_coef,3000,0},{ret_dam_proba,300,0},{ret_dam_coef,0.3,0}]
};

get(35) ->
	#transfiguration_config{
		no = 35,
		add_attr = [{phy_att,0,0.04},{mag_att,0,0.04},{phy_def,0,-0.05},{mag_def,0,-0.05},{hp_lim,0,-0.08},{act_speed,0,0.1},{seal_hit,0,0},{seal_resis,0,0},{phy_crit,150,0},{phy_ten,0,0},{phy_crit_coef,0,0},{mag_crit,150,0},{mag_ten,0,0},{mag_crit_coef,0,0},{heal_value,0,0},{do_mag_dam_scaling,0.1,0},{do_phy_dam_scaling,0.1,0},{be_phy_dam_reduce_coef,0,0},{be_mag_dam_reduce_coef,0,0},{revive_heal_coef,0,0},{ret_dam_proba,0,0},{ret_dam_coef,0,0}]
};

get(_No) ->
	      ?ASSERT(false, _No),
          null.

