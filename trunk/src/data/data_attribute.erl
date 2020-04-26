%%%-------------------------------------- 
%%% @Module: data_attribute
%%% @Author: 
%%% @Created: 2012-8-12
%%% @Description: 战斗力影响因素
%%%-------------------------------------- 
-module(data_attribute).

% -include("record.hrl").
% -export([get_battcapa_factor/1]).

% get_battcapa_factor(0) -> 
% 	#attrs{
% 		hp_lim = 153,
% 		phy_att = 711,
% 		spr_att = 236,
% 		phy_def = 115,
% 		mag_def = 196,
% 		spr_def = 90,
% 		hit = 7,
% 		dodge = 12,
% 		crit = 33,
% 		block = 8,
% 		mag_att = 711,
% 		pro_sword = 20,
% 		pro_bow = 20,
% 		pro_spear = 20,
% 		pro_mag = 20,
% 		resis_sword = 31,
% 		resis_bow = 31,
% 		resis_spear = 31,
% 		resis_mag = 31
% 	};
% get_battcapa_factor(1) -> 
% 	#attrs{
% 		hp_lim = 158,
% 		phy_att = 733,
% 		spr_att = 244,
% 		phy_def = 119,
% 		mag_def = 202,
% 		spr_def = 93,
% 		hit = 8,
% 		dodge = 13,
% 		crit = 34,
% 		block = 9,
% 		mag_att = 733,
% 		pro_sword = 21,
% 		pro_bow = 21,
% 		pro_spear = 21,
% 		pro_mag = 21,
% 		resis_sword = 32,
% 		resis_bow = 32,
% 		resis_spear = 32,
% 		resis_mag = 32
% 	};
% get_battcapa_factor(2) -> 
% 	#attrs{
% 		hp_lim = 163,
% 		phy_att = 755,
% 		spr_att = 251,
% 		phy_def = 123,
% 		mag_def = 208,
% 		spr_def = 96,
% 		hit = 8,
% 		dodge = 13,
% 		crit = 36,
% 		block = 9,
% 		mag_att = 755,
% 		pro_sword = 22,
% 		pro_bow = 22,
% 		pro_spear = 22,
% 		pro_mag = 22,
% 		resis_sword = 33,
% 		resis_bow = 33,
% 		resis_spear = 33,
% 		resis_mag = 33
% 	};
% get_battcapa_factor(3) -> 
% 	#attrs{
% 		hp_lim = 168,
% 		phy_att = 777,
% 		spr_att = 258,
% 		phy_def = 126,
% 		mag_def = 215,
% 		spr_def = 99,
% 		hit = 8,
% 		dodge = 14,
% 		crit = 37,
% 		block = 9,
% 		mag_att = 777,
% 		pro_sword = 22,
% 		pro_bow = 22,
% 		pro_spear = 22,
% 		pro_mag = 22,
% 		resis_sword = 34,
% 		resis_bow = 34,
% 		resis_spear = 34,
% 		resis_mag = 34
% 	};
% get_battcapa_factor(4) -> 
% 	#attrs{
% 		hp_lim = 173,
% 		phy_att = 801,
% 		spr_att = 266,
% 		phy_def = 130,
% 		mag_def = 221,
% 		spr_def = 102,
% 		hit = 8,
% 		dodge = 14,
% 		crit = 38,
% 		block = 10,
% 		mag_att = 801,
% 		pro_sword = 23,
% 		pro_bow = 23,
% 		pro_spear = 23,
% 		pro_mag = 23,
% 		resis_sword = 35,
% 		resis_bow = 35,
% 		resis_spear = 35,
% 		resis_mag = 35
% 	};
% get_battcapa_factor(5) -> 
% 	#attrs{
% 		hp_lim = 178,
% 		phy_att = 825,
% 		spr_att = 274,
% 		phy_def = 134,
% 		mag_def = 228,
% 		spr_def = 105,
% 		hit = 9,
% 		dodge = 14,
% 		crit = 39,
% 		block = 10,
% 		mag_att = 825,
% 		pro_sword = 24,
% 		pro_bow = 24,
% 		pro_spear = 24,
% 		pro_mag = 24,
% 		resis_sword = 36,
% 		resis_bow = 36,
% 		resis_spear = 36,
% 		resis_mag = 36
% 	};
% get_battcapa_factor(6) -> 
% 	#attrs{
% 		hp_lim = 183,
% 		phy_att = 849,
% 		spr_att = 282,
% 		phy_def = 138,
% 		mag_def = 235,
% 		spr_def = 108,
% 		hit = 9,
% 		dodge = 15,
% 		crit = 40,
% 		block = 10,
% 		mag_att = 849,
% 		pro_sword = 24,
% 		pro_bow = 24,
% 		pro_spear = 24,
% 		pro_mag = 24,
% 		resis_sword = 38,
% 		resis_bow = 38,
% 		resis_spear = 38,
% 		resis_mag = 38
% 	};
% get_battcapa_factor(7) -> 
% 	#attrs{
% 		hp_lim = 189,
% 		phy_att = 875,
% 		spr_att = 291,
% 		phy_def = 142,
% 		mag_def = 242,
% 		spr_def = 111,
% 		hit = 9,
% 		dodge = 15,
% 		crit = 41,
% 		block = 10,
% 		mag_att = 875,
% 		pro_sword = 25,
% 		pro_bow = 25,
% 		pro_spear = 25,
% 		pro_mag = 25,
% 		resis_sword = 39,
% 		resis_bow = 39,
% 		resis_spear = 39,
% 		resis_mag = 39
% 	};
% get_battcapa_factor(8) -> 
% 	#attrs{
% 		hp_lim = 194,
% 		phy_att = 901,
% 		spr_att = 299,
% 		phy_def = 146,
% 		mag_def = 249,
% 		spr_def = 115,
% 		hit = 9,
% 		dodge = 16,
% 		crit = 42,
% 		block = 11,
% 		mag_att = 901,
% 		pro_sword = 26,
% 		pro_bow = 26,
% 		pro_spear = 26,
% 		pro_mag = 26,
% 		resis_sword = 40,
% 		resis_bow = 40,
% 		resis_spear = 40,
% 		resis_mag = 40
% 	};
% get_battcapa_factor(9) -> 
% 	#attrs{
% 		hp_lim = 200,
% 		phy_att = 928,
% 		spr_att = 308,
% 		phy_def = 151,
% 		mag_def = 256,
% 		spr_def = 118,
% 		hit = 10,
% 		dodge = 16,
% 		crit = 44,
% 		block = 11,
% 		mag_att = 928,
% 		pro_sword = 27,
% 		pro_bow = 27,
% 		pro_spear = 27,
% 		pro_mag = 27,
% 		resis_sword = 41,
% 		resis_bow = 41,
% 		resis_spear = 41,
% 		resis_mag = 41
% 	};
% get_battcapa_factor(_) -> #attrs{}.
