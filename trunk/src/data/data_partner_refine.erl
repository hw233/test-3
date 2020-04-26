%%%---------------------------------------
%%% @Module  : data_partner_refine
%%% @Author  : zjy
%%% @Email   : 
%%% @Description: 宠物精炼
%%%---------------------------------------


-module(data_partner_refine).
-export([get/2]).
-include("partner.hrl").
-include("debug.hrl").

get(50370,phy_att) ->
	#partner_refine{
		no = 50370,
		attr_name = phy_att,
		add_range = {26,26},
		add_top = 460000
};

get(50371,phy_att) ->
	#partner_refine{
		no = 50371,
		attr_name = phy_att,
		add_range = {133,133},
		add_top = 460000
};

get(50372,phy_att) ->
	#partner_refine{
		no = 50372,
		attr_name = phy_att,
		add_range = {1334,1334},
		add_top = 460000
};

get(50370,mag_att) ->
	#partner_refine{
		no = 50370,
		attr_name = mag_att,
		add_range = {26,26},
		add_top = 460000
};

get(50371,mag_att) ->
	#partner_refine{
		no = 50371,
		attr_name = mag_att,
		add_range = {133,133},
		add_top = 460000
};

get(50372,mag_att) ->
	#partner_refine{
		no = 50372,
		attr_name = mag_att,
		add_range = {1334,1334},
		add_top = 460000
};

get(50370,phy_def) ->
	#partner_refine{
		no = 50370,
		attr_name = phy_def,
		add_range = {54,54},
		add_top = 280000
};

get(50371,phy_def) ->
	#partner_refine{
		no = 50371,
		attr_name = phy_def,
		add_range = {270,270},
		add_top = 280000
};

get(50372,phy_def) ->
	#partner_refine{
		no = 50372,
		attr_name = phy_def,
		add_range = {2706,2706},
		add_top = 280000
};

get(50370,mag_def) ->
	#partner_refine{
		no = 50370,
		attr_name = mag_def,
		add_range = {54,54},
		add_top = 280000
};

get(50371,mag_def) ->
	#partner_refine{
		no = 50371,
		attr_name = mag_def,
		add_range = {270,270},
		add_top = 280000
};

get(50372,mag_def) ->
	#partner_refine{
		no = 50372,
		attr_name = mag_def,
		add_range = {2706,2706},
		add_top = 280000
};

get(50370,hp_lim) ->
	#partner_refine{
		no = 50370,
		attr_name = hp_lim,
		add_range = {266,266},
		add_top = 2300000
};

get(50371,hp_lim) ->
	#partner_refine{
		no = 50371,
		attr_name = hp_lim,
		add_range = {1334,1334},
		add_top = 2300000
};

get(50372,hp_lim) ->
	#partner_refine{
		no = 50372,
		attr_name = hp_lim,
		add_range = {13340,13340},
		add_top = 2300000
};

get(50370,act_speed) ->
	#partner_refine{
		no = 50370,
		attr_name = act_speed,
		add_range = {10,10},
		add_top = 37000
};

get(50371,act_speed) ->
	#partner_refine{
		no = 50371,
		attr_name = act_speed,
		add_range = {53,53},
		add_top = 37000
};

get(50372,act_speed) ->
	#partner_refine{
		no = 50372,
		attr_name = act_speed,
		add_range = {536,536},
		add_top = 37000
};

get(50370,seal_resis) ->
	#partner_refine{
		no = 50370,
		attr_name = seal_resis,
		add_range = {26,26},
		add_top = 92000
};

get(50371,seal_resis) ->
	#partner_refine{
		no = 50371,
		attr_name = seal_resis,
		add_range = {133,133},
		add_top = 92000
};

get(50372,seal_resis) ->
	#partner_refine{
		no = 50372,
		attr_name = seal_resis,
		add_range = {1334,1334},
		add_top = 92000
};

get(_No, _Attr_name) ->
	      ?ASSERT(false, _No),
          null.

