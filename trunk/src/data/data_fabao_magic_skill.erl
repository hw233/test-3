%%%---------------------------------------
%%% @Module  : data_fabao_magic_skill
%%% @Author  : lzx
%%% @Email   : 
%%% @Description: 法宝神通技能表
%%%---------------------------------------


-module(data_fabao_magic_skill).
-compile(export_all).
-include("fabao.hrl").
-include("debug.hrl").


    get(1, 60001) -> 
        #fabao_magic_skill{
        no = 1,
		fabao_no = 60001,
		advance_no = 1,
	    magic_skill_no = 1,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(2, 60001) -> 
        #fabao_magic_skill{
        no = 2,
		fabao_no = 60001,
		advance_no = 1,
	    magic_skill_no = 2,
		learn_condition = [],
		magic_skill = [{2, {hp_lim, 0, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(3, 60001) -> 
        #fabao_magic_skill{
        no = 3,
		fabao_no = 60001,
		advance_no = 1,
	    magic_skill_no = 3,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(4, 60001) -> 
        #fabao_magic_skill{
        no = 4,
		fabao_no = 60001,
		advance_no = 1,
	    magic_skill_no = 4,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(5, 60001) -> 
        #fabao_magic_skill{
        no = 5,
		fabao_no = 60001,
		advance_no = 1,
	    magic_skill_no = 5,
		learn_condition = [],
		magic_skill = [{1, [500001]}],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(6, 60001) -> 
        #fabao_magic_skill{
        no = 6,
		fabao_no = 60001,
		advance_no = 2,
	    magic_skill_no = 6,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(7, 60001) -> 
        #fabao_magic_skill{
        no = 7,
		fabao_no = 60001,
		advance_no = 2,
	    magic_skill_no = 7,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(8, 60001) -> 
        #fabao_magic_skill{
        no = 8,
		fabao_no = 60001,
		advance_no = 2,
	    magic_skill_no = 8,
		learn_condition = [],
		magic_skill = [{2, {mp_lim, 0, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(9, 60001) -> 
        #fabao_magic_skill{
        no = 9,
		fabao_no = 60001,
		advance_no = 2,
	    magic_skill_no = 9,
		learn_condition = [{8, 5}],
		magic_skill = [{2, {heal_value, 1, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(10, 60001) -> 
        #fabao_magic_skill{
        no = 10,
		fabao_no = 60001,
		advance_no = 2,
	    magic_skill_no = 10,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(11, 60001) -> 
        #fabao_magic_skill{
        no = 11,
		fabao_no = 60001,
		advance_no = 3,
	    magic_skill_no = 11,
		learn_condition = [],
		magic_skill = [{2, {phy_def, 2, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(12, 60001) -> 
        #fabao_magic_skill{
        no = 12,
		fabao_no = 60001,
		advance_no = 3,
	    magic_skill_no = 12,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(13, 60001) -> 
        #fabao_magic_skill{
        no = 13,
		fabao_no = 60001,
		advance_no = 3,
	    magic_skill_no = 13,
		learn_condition = [{8, 5}],
		magic_skill = [{1, [500002]}],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(14, 60001) -> 
        #fabao_magic_skill{
        no = 14,
		fabao_no = 60001,
		advance_no = 3,
	    magic_skill_no = 14,
		learn_condition = [{9, 5}],
		magic_skill = [{2, {hp_lim, 2, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(15, 60001) -> 
        #fabao_magic_skill{
        no = 15,
		fabao_no = 60001,
		advance_no = 3,
	    magic_skill_no = 15,
		learn_condition = [{5, 0}],
		magic_skill = [{2, {mp_lim, 2, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(16, 60001) -> 
        #fabao_magic_skill{
        no = 16,
		fabao_no = 60001,
		advance_no = 4,
	    magic_skill_no = 16,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(17, 60001) -> 
        #fabao_magic_skill{
        no = 17,
		fabao_no = 60001,
		advance_no = 4,
	    magic_skill_no = 17,
		learn_condition = [{2, 5}],
		magic_skill = [{1, [500004]}],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(18, 60001) -> 
        #fabao_magic_skill{
        no = 18,
		fabao_no = 60001,
		advance_no = 4,
	    magic_skill_no = 18,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(19, 60001) -> 
        #fabao_magic_skill{
        no = 19,
		fabao_no = 60001,
		advance_no = 4,
	    magic_skill_no = 19,
		learn_condition = [{14, 5}],
		magic_skill = [{2, {heal_value, 2, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(20, 60001) -> 
        #fabao_magic_skill{
        no = 20,
		fabao_no = 60001,
		advance_no = 4,
	    magic_skill_no = 20,
		learn_condition = [{15, 3}],
		magic_skill = [{2, {phy_crit,4, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(21, 60001) -> 
        #fabao_magic_skill{
        no = 21,
		fabao_no = 60001,
		advance_no = 5,
	    magic_skill_no = 21,
		learn_condition = [{11, 5}],
		magic_skill = [{2, {mag_def, 2, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(22, 60001) -> 
        #fabao_magic_skill{
        no = 22,
		fabao_no = 60001,
		advance_no = 5,
	    magic_skill_no = 22,
		learn_condition = [{17, 0}],
		magic_skill = [{2, {phy_att, 2, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(23, 60001) -> 
        #fabao_magic_skill{
        no = 23,
		fabao_no = 60001,
		advance_no = 5,
	    magic_skill_no = 23,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(24, 60001) -> 
        #fabao_magic_skill{
        no = 24,
		fabao_no = 60001,
		advance_no = 5,
	    magic_skill_no = 24,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(25, 60001) -> 
        #fabao_magic_skill{
        no = 25,
		fabao_no = 60001,
		advance_no = 5,
	    magic_skill_no = 25,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(26, 60001) -> 
        #fabao_magic_skill{
        no = 26,
		fabao_no = 60001,
		advance_no = 6,
	    magic_skill_no = 26,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(27, 60001) -> 
        #fabao_magic_skill{
        no = 27,
		fabao_no = 60001,
		advance_no = 6,
	    magic_skill_no = 27,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(28, 60001) -> 
        #fabao_magic_skill{
        no = 28,
		fabao_no = 60001,
		advance_no = 6,
	    magic_skill_no = 28,
		learn_condition = [],
		magic_skill = [{2, {phy_ten,4, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(29, 60001) -> 
        #fabao_magic_skill{
        no = 29,
		fabao_no = 60001,
		advance_no = 6,
	    magic_skill_no = 29,
		learn_condition = [{19, 5}, {30, 0}],
		magic_skill = [{2, {act_speed,2, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(30, 60001) -> 
        #fabao_magic_skill{
        no = 30,
		fabao_no = 60001,
		advance_no = 6,
	    magic_skill_no = 30,
		learn_condition = [{20, 10}],
		magic_skill = [{1, [500003]}],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(31, 60001) -> 
        #fabao_magic_skill{
        no = 31,
		fabao_no = 60001,
		advance_no = 7,
	    magic_skill_no = 31,
		learn_condition = [{21, 5}, {32, 8}],
		magic_skill = [{1, [500007]}],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(32, 60001) -> 
        #fabao_magic_skill{
        no = 32,
		fabao_no = 60001,
		advance_no = 7,
	    magic_skill_no = 32,
		learn_condition = [{22, 5}],
		magic_skill = [{2, {seal_resis,3, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(33, 60001) -> 
        #fabao_magic_skill{
        no = 33,
		fabao_no = 60001,
		advance_no = 7,
	    magic_skill_no = 33,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(34, 60001) -> 
        #fabao_magic_skill{
        no = 34,
		fabao_no = 60001,
		advance_no = 7,
	    magic_skill_no = 34,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(35, 60001) -> 
        #fabao_magic_skill{
        no = 35,
		fabao_no = 60001,
		advance_no = 7,
	    magic_skill_no = 35,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(36, 60001) -> 
        #fabao_magic_skill{
        no = 36,
		fabao_no = 60001,
		advance_no = 8,
	    magic_skill_no = 36,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(37, 60001) -> 
        #fabao_magic_skill{
        no = 37,
		fabao_no = 60001,
		advance_no = 8,
	    magic_skill_no = 37,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(38, 60001) -> 
        #fabao_magic_skill{
        no = 38,
		fabao_no = 60001,
		advance_no = 8,
	    magic_skill_no = 38,
		learn_condition = [{28, 8}],
		magic_skill = [{2, {mag_ten,4, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(39, 60001) -> 
        #fabao_magic_skill{
        no = 39,
		fabao_no = 60001,
		advance_no = 8,
	    magic_skill_no = 39,
		learn_condition = [{29, 5}],
		magic_skill = [{2, {mag_att,2, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(40, 60001) -> 
        #fabao_magic_skill{
        no = 40,
		fabao_no = 60001,
		advance_no = 8,
	    magic_skill_no = 40,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(41, 60001) -> 
        #fabao_magic_skill{
        no = 41,
		fabao_no = 60001,
		advance_no = 9,
	    magic_skill_no = 41,
		learn_condition = [{31, 0}],
		magic_skill = [{2, {seal_hit, 3, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(42, 60001) -> 
        #fabao_magic_skill{
        no = 42,
		fabao_no = 60001,
		advance_no = 9,
	    magic_skill_no = 42,
		learn_condition = [{32, 8}, {41, 5}],
		magic_skill = [{1, [500006]}],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(43, 60001) -> 
        #fabao_magic_skill{
        no = 43,
		fabao_no = 60001,
		advance_no = 9,
	    magic_skill_no = 43,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(44, 60001) -> 
        #fabao_magic_skill{
        no = 44,
		fabao_no = 60001,
		advance_no = 9,
	    magic_skill_no = 44,
		learn_condition = [{39, 8}],
		magic_skill = [{1, [500005]}],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(45, 60001) -> 
        #fabao_magic_skill{
        no = 45,
		fabao_no = 60001,
		advance_no = 9,
	    magic_skill_no = 45,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(46, 60001) -> 
        #fabao_magic_skill{
        no = 46,
		fabao_no = 60001,
		advance_no = 10,
	    magic_skill_no = 46,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(47, 60001) -> 
        #fabao_magic_skill{
        no = 47,
		fabao_no = 60001,
		advance_no = 10,
	    magic_skill_no = 47,
		learn_condition = [{42, 0}],
		magic_skill = [{2, {do_phy_dam_scaling,3, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(48, 60001) -> 
        #fabao_magic_skill{
        no = 48,
		fabao_no = 60001,
		advance_no = 10,
	    magic_skill_no = 48,
		learn_condition = [{38, 10}, {47, 3}],
		magic_skill = [{2, {be_mag_dam_reduce_coef,5, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(49, 60001) -> 
        #fabao_magic_skill{
        no = 49,
		fabao_no = 60001,
		advance_no = 10,
	    magic_skill_no = 49,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(50, 60001) -> 
        #fabao_magic_skill{
        no = 50,
		fabao_no = 60001,
		advance_no = 10,
	    magic_skill_no = 50,
		learn_condition = [{30, 0}, {48, 3}],
		magic_skill = [{2, {be_phy_dam_reduce_coef,5, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(1, 60002) -> 
        #fabao_magic_skill{
        no = 51,
		fabao_no = 60002,
		advance_no = 1,
	    magic_skill_no = 1,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(2, 60002) -> 
        #fabao_magic_skill{
        no = 52,
		fabao_no = 60002,
		advance_no = 1,
	    magic_skill_no = 2,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(3, 60002) -> 
        #fabao_magic_skill{
        no = 53,
		fabao_no = 60002,
		advance_no = 1,
	    magic_skill_no = 3,
		learn_condition = [],
		magic_skill = [{2, {heal_value, 1, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(4, 60002) -> 
        #fabao_magic_skill{
        no = 54,
		fabao_no = 60002,
		advance_no = 1,
	    magic_skill_no = 4,
		learn_condition = [],
		magic_skill = [{1, [500054]}],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(5, 60002) -> 
        #fabao_magic_skill{
        no = 55,
		fabao_no = 60002,
		advance_no = 1,
	    magic_skill_no = 5,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(6, 60002) -> 
        #fabao_magic_skill{
        no = 56,
		fabao_no = 60002,
		advance_no = 2,
	    magic_skill_no = 6,
		learn_condition = [],
		magic_skill = [{2, {hp_lim, 0, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(7, 60002) -> 
        #fabao_magic_skill{
        no = 57,
		fabao_no = 60002,
		advance_no = 2,
	    magic_skill_no = 7,
		learn_condition = [],
		magic_skill = [{2, {phy_def,1, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(8, 60002) -> 
        #fabao_magic_skill{
        no = 58,
		fabao_no = 60002,
		advance_no = 2,
	    magic_skill_no = 8,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(9, 60002) -> 
        #fabao_magic_skill{
        no = 59,
		fabao_no = 60002,
		advance_no = 2,
	    magic_skill_no = 9,
		learn_condition = [{4, 0}],
		magic_skill = [{2, {phy_att,1, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(10, 60002) -> 
        #fabao_magic_skill{
        no = 60,
		fabao_no = 60002,
		advance_no = 2,
	    magic_skill_no = 10,
		learn_condition = [],
		magic_skill = [{2, {seal_hit,1, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(11, 60002) -> 
        #fabao_magic_skill{
        no = 61,
		fabao_no = 60002,
		advance_no = 3,
	    magic_skill_no = 11,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(12, 60002) -> 
        #fabao_magic_skill{
        no = 62,
		fabao_no = 60002,
		advance_no = 3,
	    magic_skill_no = 12,
		learn_condition = [{7, 5}],
		magic_skill = [{2, {mag_def, 1, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(13, 60002) -> 
        #fabao_magic_skill{
        no = 63,
		fabao_no = 60002,
		advance_no = 3,
	    magic_skill_no = 13,
		learn_condition = [{3, 5}],
		magic_skill = [{1, [500052]}],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(14, 60002) -> 
        #fabao_magic_skill{
        no = 64,
		fabao_no = 60002,
		advance_no = 3,
	    magic_skill_no = 14,
		learn_condition = [{9, 5}],
		magic_skill = [{2, {mag_att, 1, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(15, 60002) -> 
        #fabao_magic_skill{
        no = 65,
		fabao_no = 60002,
		advance_no = 3,
	    magic_skill_no = 15,
		learn_condition = [{10, 5}],
		magic_skill = [{2, {seal_resis,1, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(16, 60002) -> 
        #fabao_magic_skill{
        no = 66,
		fabao_no = 60002,
		advance_no = 4,
	    magic_skill_no = 16,
		learn_condition = [{6, 5}],
		magic_skill = [{2, {mp_lim, 0, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(17, 60002) -> 
        #fabao_magic_skill{
        no = 67,
		fabao_no = 60002,
		advance_no = 4,
	    magic_skill_no = 17,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(18, 60002) -> 
        #fabao_magic_skill{
        no = 68,
		fabao_no = 60002,
		advance_no = 4,
	    magic_skill_no = 18,
		learn_condition = [{13, 0}],
		magic_skill = [{2, {heal_value,2, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(19, 60002) -> 
        #fabao_magic_skill{
        no = 69,
		fabao_no = 60002,
		advance_no = 4,
	    magic_skill_no = 19,
		learn_condition = [{18, 5}],
		magic_skill = [{1, [500051]}],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(20, 60002) -> 
        #fabao_magic_skill{
        no = 70,
		fabao_no = 60002,
		advance_no = 4,
	    magic_skill_no = 20,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(21, 60002) -> 
        #fabao_magic_skill{
        no = 71,
		fabao_no = 60002,
		advance_no = 5,
	    magic_skill_no = 21,
		learn_condition = [{16, 5}],
		magic_skill = [{2, {hp_lim, 2, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(22, 60002) -> 
        #fabao_magic_skill{
        no = 72,
		fabao_no = 60002,
		advance_no = 5,
	    magic_skill_no = 22,
		learn_condition = [{12, 5}],
		magic_skill = [{2, {phy_def,2, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(23, 60002) -> 
        #fabao_magic_skill{
        no = 73,
		fabao_no = 60002,
		advance_no = 5,
	    magic_skill_no = 23,
		learn_condition = [{18, 5},{22, 5}],
		magic_skill = [{1, [500053]}],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(24, 60002) -> 
        #fabao_magic_skill{
        no = 74,
		fabao_no = 60002,
		advance_no = 5,
	    magic_skill_no = 24,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(25, 60002) -> 
        #fabao_magic_skill{
        no = 75,
		fabao_no = 60002,
		advance_no = 5,
	    magic_skill_no = 25,
		learn_condition = [{15, 5}],
		magic_skill = [{2, {act_speed,1, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(26, 60002) -> 
        #fabao_magic_skill{
        no = 76,
		fabao_no = 60002,
		advance_no = 6,
	    magic_skill_no = 26,
		learn_condition = [{21, 8},{27, 5}],
		magic_skill = [{1, [500055]}],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(27, 60002) -> 
        #fabao_magic_skill{
        no = 77,
		fabao_no = 60002,
		advance_no = 6,
	    magic_skill_no = 27,
		learn_condition = [{22, 5}],
		magic_skill = [{2, {mag_def,2, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(28, 60002) -> 
        #fabao_magic_skill{
        no = 78,
		fabao_no = 60002,
		advance_no = 6,
	    magic_skill_no = 28,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(29, 60002) -> 
        #fabao_magic_skill{
        no = 79,
		fabao_no = 60002,
		advance_no = 6,
	    magic_skill_no = 29,
		learn_condition = [],
		magic_skill = [{2, {phy_crit,4, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(30, 60002) -> 
        #fabao_magic_skill{
        no = 80,
		fabao_no = 60002,
		advance_no = 6,
	    magic_skill_no = 30,
		learn_condition = [{25, 5},{29, 5}],
		magic_skill = [{2, {seal_hit,3, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(31, 60002) -> 
        #fabao_magic_skill{
        no = 81,
		fabao_no = 60002,
		advance_no = 7,
	    magic_skill_no = 31,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(32, 60002) -> 
        #fabao_magic_skill{
        no = 82,
		fabao_no = 60002,
		advance_no = 7,
	    magic_skill_no = 32,
		learn_condition = [{27, 5}],
		magic_skill = [{1, [500056]}],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(33, 60002) -> 
        #fabao_magic_skill{
        no = 83,
		fabao_no = 60002,
		advance_no = 7,
	    magic_skill_no = 33,
		learn_condition = [{23, 0}],
		magic_skill = [{2, {mag_ten,4, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(34, 60002) -> 
        #fabao_magic_skill{
        no = 84,
		fabao_no = 60002,
		advance_no = 7,
	    magic_skill_no = 34,
		learn_condition = [{29, 5},{33, 5}],
		magic_skill = [{2, {mag_crit,4, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(35, 60002) -> 
        #fabao_magic_skill{
        no = 85,
		fabao_no = 60002,
		advance_no = 7,
	    magic_skill_no = 35,
		learn_condition = [{30, 5}],
		magic_skill = [{2, {seal_resis,3, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(36, 60002) -> 
        #fabao_magic_skill{
        no = 86,
		fabao_no = 60002,
		advance_no = 8,
	    magic_skill_no = 36,
		learn_condition = [{26, 0}],
		magic_skill = [{2, {do_phy_dam_scaling,3, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(37, 60002) -> 
        #fabao_magic_skill{
        no = 87,
		fabao_no = 60002,
		advance_no = 8,
	    magic_skill_no = 37,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(38, 60002) -> 
        #fabao_magic_skill{
        no = 88,
		fabao_no = 60002,
		advance_no = 8,
	    magic_skill_no = 38,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(39, 60002) -> 
        #fabao_magic_skill{
        no = 89,
		fabao_no = 60002,
		advance_no = 8,
	    magic_skill_no = 39,
		learn_condition = [{34, 8},{40, 0}],
		magic_skill = [{2, {do_mag_dam_scaling,3, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(40, 60002) -> 
        #fabao_magic_skill{
        no = 90,
		fabao_no = 60002,
		advance_no = 8,
	    magic_skill_no = 40,
		learn_condition = [{35, 5}],
		magic_skill = [{1, [500057]}],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(41, 60002) -> 
        #fabao_magic_skill{
        no = 91,
		fabao_no = 60002,
		advance_no = 9,
	    magic_skill_no = 41,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(42, 60002) -> 
        #fabao_magic_skill{
        no = 92,
		fabao_no = 60002,
		advance_no = 9,
	    magic_skill_no = 42,
		learn_condition = [{32, 0}],
		magic_skill = [{2, {be_phy_dam_reduce_coef,5, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(43, 60002) -> 
        #fabao_magic_skill{
        no = 93,
		fabao_no = 60002,
		advance_no = 9,
	    magic_skill_no = 43,
		learn_condition = [{33, 8},{42, 3}],
		magic_skill = [{2, {be_mag_dam_reduce_coef,5, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(44, 60002) -> 
        #fabao_magic_skill{
        no = 94,
		fabao_no = 60002,
		advance_no = 9,
	    magic_skill_no = 44,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(45, 60002) -> 
        #fabao_magic_skill{
        no = 95,
		fabao_no = 60002,
		advance_no = 9,
	    magic_skill_no = 45,
		learn_condition = [{40, 0}],
		magic_skill = [{2, {phy_ten,4, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(46, 60002) -> 
        #fabao_magic_skill{
        no = 96,
		fabao_no = 60002,
		advance_no = 10,
	    magic_skill_no = 46,
		learn_condition = [{36, 0}],
		magic_skill = [{2, {phy_crit_coef,4, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(47, 60002) -> 
        #fabao_magic_skill{
        no = 97,
		fabao_no = 60002,
		advance_no = 10,
	    magic_skill_no = 47,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(48, 60002) -> 
        #fabao_magic_skill{
        no = 98,
		fabao_no = 60002,
		advance_no = 10,
	    magic_skill_no = 48,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(49, 60002) -> 
        #fabao_magic_skill{
        no = 99,
		fabao_no = 60002,
		advance_no = 10,
	    magic_skill_no = 49,
		learn_condition = [{39, 5}],
		magic_skill = [{2, {mag_crit_coef,4, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(50, 60002) -> 
        #fabao_magic_skill{
        no = 100,
		fabao_no = 60002,
		advance_no = 10,
	    magic_skill_no = 50,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(1, 60003) -> 
        #fabao_magic_skill{
        no = 101,
		fabao_no = 60003,
		advance_no = 1,
	    magic_skill_no = 1,
		learn_condition = [],
		magic_skill = [{2, {phy_att,1, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(2, 60003) -> 
        #fabao_magic_skill{
        no = 102,
		fabao_no = 60003,
		advance_no = 1,
	    magic_skill_no = 2,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(3, 60003) -> 
        #fabao_magic_skill{
        no = 103,
		fabao_no = 60003,
		advance_no = 1,
	    magic_skill_no = 3,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(4, 60003) -> 
        #fabao_magic_skill{
        no = 104,
		fabao_no = 60003,
		advance_no = 1,
	    magic_skill_no = 4,
		learn_condition = [],
		magic_skill = [{2, {hp_lim, 0, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(5, 60003) -> 
        #fabao_magic_skill{
        no = 105,
		fabao_no = 60003,
		advance_no = 1,
	    magic_skill_no = 5,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(6, 60003) -> 
        #fabao_magic_skill{
        no = 106,
		fabao_no = 60003,
		advance_no = 2,
	    magic_skill_no = 6,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(7, 60003) -> 
        #fabao_magic_skill{
        no = 107,
		fabao_no = 60003,
		advance_no = 2,
	    magic_skill_no = 7,
		learn_condition = [],
		magic_skill = [{1, [500013]}],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(8, 60003) -> 
        #fabao_magic_skill{
        no = 108,
		fabao_no = 60003,
		advance_no = 2,
	    magic_skill_no = 8,
		learn_condition = [{7, 0}],
		magic_skill = [{2, {seal_resis,1, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(9, 60003) -> 
        #fabao_magic_skill{
        no = 109,
		fabao_no = 60003,
		advance_no = 2,
	    magic_skill_no = 9,
		learn_condition = [{4, 5}],
		magic_skill = [{2, {heal_value, 1, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(10, 60003) -> 
        #fabao_magic_skill{
        no = 110,
		fabao_no = 60003,
		advance_no = 2,
	    magic_skill_no = 10,
		learn_condition = [{9, 5}],
		magic_skill = [{2, {act_speed,1, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(11, 60003) -> 
        #fabao_magic_skill{
        no = 111,
		fabao_no = 60003,
		advance_no = 3,
	    magic_skill_no = 11,
		learn_condition = [{1, 5}],
		magic_skill = [{2, {mag_att, 1, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(12, 60003) -> 
        #fabao_magic_skill{
        no = 112,
		fabao_no = 60003,
		advance_no = 3,
	    magic_skill_no = 12,
		learn_condition = [{7, 0}],
		magic_skill = [{2, {mag_def, 1, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(13, 60003) -> 
        #fabao_magic_skill{
        no = 113,
		fabao_no = 60003,
		advance_no = 3,
	    magic_skill_no = 13,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(14, 60003) -> 
        #fabao_magic_skill{
        no = 114,
		fabao_no = 60003,
		advance_no = 3,
	    magic_skill_no = 14,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(15, 60003) -> 
        #fabao_magic_skill{
        no = 115,
		fabao_no = 60003,
		advance_no = 3,
	    magic_skill_no = 15,
		learn_condition = [{10, 5}],
		magic_skill = [{1, [500011]}],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(16, 60003) -> 
        #fabao_magic_skill{
        no = 116,
		fabao_no = 60003,
		advance_no = 4,
	    magic_skill_no = 16,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(17, 60003) -> 
        #fabao_magic_skill{
        no = 117,
		fabao_no = 60003,
		advance_no = 4,
	    magic_skill_no = 17,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(18, 60003) -> 
        #fabao_magic_skill{
        no = 118,
		fabao_no = 60003,
		advance_no = 4,
	    magic_skill_no = 18,
		learn_condition = [{8, 5},{19, 5}],
		magic_skill = [{1, [500015]}],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(19, 60003) -> 
        #fabao_magic_skill{
        no = 119,
		fabao_no = 60003,
		advance_no = 4,
	    magic_skill_no = 19,
		learn_condition = [{9, 5}],
		magic_skill = [{2, {hp_lim, 2, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(20, 60003) -> 
        #fabao_magic_skill{
        no = 120,
		fabao_no = 60003,
		advance_no = 4,
	    magic_skill_no = 20,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(21, 60003) -> 
        #fabao_magic_skill{
        no = 121,
		fabao_no = 60003,
		advance_no = 5,
	    magic_skill_no = 21,
		learn_condition = [{11, 10}],
		magic_skill = [{2, {phy_att,2, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(22, 60003) -> 
        #fabao_magic_skill{
        no = 122,
		fabao_no = 60003,
		advance_no = 5,
	    magic_skill_no = 22,
		learn_condition = [{12, 5}],
		magic_skill = [{2, {phy_def,1, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(23, 60003) -> 
        #fabao_magic_skill{
        no = 123,
		fabao_no = 60003,
		advance_no = 5,
	    magic_skill_no = 23,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(24, 60003) -> 
        #fabao_magic_skill{
        no = 124,
		fabao_no = 60003,
		advance_no = 5,
	    magic_skill_no = 24,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(25, 60003) -> 
        #fabao_magic_skill{
        no = 125,
		fabao_no = 60003,
		advance_no = 5,
	    magic_skill_no = 25,
		learn_condition = [{15, 0}],
		magic_skill = [{2, {act_speed,2, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(26, 60003) -> 
        #fabao_magic_skill{
        no = 126,
		fabao_no = 60003,
		advance_no = 6,
	    magic_skill_no = 26,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(27, 60003) -> 
        #fabao_magic_skill{
        no = 127,
		fabao_no = 60003,
		advance_no = 6,
	    magic_skill_no = 27,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(28, 60003) -> 
        #fabao_magic_skill{
        no = 128,
		fabao_no = 60003,
		advance_no = 6,
	    magic_skill_no = 28,
		learn_condition = [{18, 0}],
		magic_skill = [{2, {phy_ten,4, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(29, 60003) -> 
        #fabao_magic_skill{
        no = 129,
		fabao_no = 60003,
		advance_no = 6,
	    magic_skill_no = 29,
		learn_condition = [{19, 5},{28, 5}],
		magic_skill = [{2, {mag_ten,4, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(30, 60003) -> 
        #fabao_magic_skill{
        no = 130,
		fabao_no = 60003,
		advance_no = 6,
	    magic_skill_no = 30,
		learn_condition = [{25, 5}],
		magic_skill = [{1, [500012]}],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(31, 60003) -> 
        #fabao_magic_skill{
        no = 131,
		fabao_no = 60003,
		advance_no = 7,
	    magic_skill_no = 31,
		learn_condition = [{21, 5}],
		magic_skill = [{1, [500014]}],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(32, 60003) -> 
        #fabao_magic_skill{
        no = 132,
		fabao_no = 60003,
		advance_no = 7,
	    magic_skill_no = 32,
		learn_condition = [{22, 10},{33, 5}],
		magic_skill = [{2, {phy_def,2, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(33, 60003) -> 
        #fabao_magic_skill{
        no = 133,
		fabao_no = 60003,
		advance_no = 7,
	    magic_skill_no = 33,
		learn_condition = [{28, 5}],
		magic_skill = [{2, {seal_hit,3, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(34, 60003) -> 
        #fabao_magic_skill{
        no = 134,
		fabao_no = 60003,
		advance_no = 7,
	    magic_skill_no = 34,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(35, 60003) -> 
        #fabao_magic_skill{
        no = 135,
		fabao_no = 60003,
		advance_no = 7,
	    magic_skill_no = 35,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(36, 60003) -> 
        #fabao_magic_skill{
        no = 136,
		fabao_no = 60003,
		advance_no = 8,
	    magic_skill_no = 36,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(37, 60003) -> 
        #fabao_magic_skill{
        no = 137,
		fabao_no = 60003,
		advance_no = 8,
	    magic_skill_no = 37,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(38, 60003) -> 
        #fabao_magic_skill{
        no = 138,
		fabao_no = 60003,
		advance_no = 8,
	    magic_skill_no = 38,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(39, 60003) -> 
        #fabao_magic_skill{
        no = 139,
		fabao_no = 60003,
		advance_no = 8,
	    magic_skill_no = 39,
		learn_condition = [{29, 5}],
		magic_skill = [{1, [500017]}],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(40, 60003) -> 
        #fabao_magic_skill{
        no = 140,
		fabao_no = 60003,
		advance_no = 8,
	    magic_skill_no = 40,
		learn_condition = [{30, 0},{39, 0}],
		magic_skill = [{2, {phy_crit,4, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(41, 60003) -> 
        #fabao_magic_skill{
        no = 141,
		fabao_no = 60003,
		advance_no = 9,
	    magic_skill_no = 41,
		learn_condition = [],
		magic_skill = [{1, [500016]}],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(42, 60003) -> 
        #fabao_magic_skill{
        no = 142,
		fabao_no = 60003,
		advance_no = 9,
	    magic_skill_no = 42,
		learn_condition = [{32, 5}],
		magic_skill = [{2, {mag_def,2, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(43, 60003) -> 
        #fabao_magic_skill{
        no = 143,
		fabao_no = 60003,
		advance_no = 9,
	    magic_skill_no = 43,
		learn_condition = [{33, 5}],
		magic_skill = [{2, {seal_resis,3, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(44, 60003) -> 
        #fabao_magic_skill{
        no = 144,
		fabao_no = 60003,
		advance_no = 9,
	    magic_skill_no = 44,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(45, 60003) -> 
        #fabao_magic_skill{
        no = 145,
		fabao_no = 60003,
		advance_no = 9,
	    magic_skill_no = 45,
		learn_condition = [{40, 5}],
		magic_skill = [{2, {do_phy_dam_scaling,3, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(46, 60003) -> 
        #fabao_magic_skill{
        no = 146,
		fabao_no = 60003,
		advance_no = 10,
	    magic_skill_no = 46,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(47, 60003) -> 
        #fabao_magic_skill{
        no = 147,
		fabao_no = 60003,
		advance_no = 10,
	    magic_skill_no = 47,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(48, 60003) -> 
        #fabao_magic_skill{
        no = 148,
		fabao_no = 60003,
		advance_no = 10,
	    magic_skill_no = 48,
		learn_condition = [{43, 5}],
		magic_skill = [{2, {phy_crit_coef,4, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(49, 60003) -> 
        #fabao_magic_skill{
        no = 149,
		fabao_no = 60003,
		advance_no = 10,
	    magic_skill_no = 49,
		learn_condition = [{39, 0},{48, 3}],
		magic_skill = [{2, {be_mag_dam_reduce_coef,5, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(50, 60003) -> 
        #fabao_magic_skill{
        no = 150,
		fabao_no = 60003,
		advance_no = 10,
	    magic_skill_no = 50,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(1, 60004) -> 
        #fabao_magic_skill{
        no = 151,
		fabao_no = 60004,
		advance_no = 1,
	    magic_skill_no = 1,
		learn_condition = [],
		magic_skill = [{2, {phy_def,1, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(2, 60004) -> 
        #fabao_magic_skill{
        no = 152,
		fabao_no = 60004,
		advance_no = 1,
	    magic_skill_no = 2,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(3, 60004) -> 
        #fabao_magic_skill{
        no = 153,
		fabao_no = 60004,
		advance_no = 1,
	    magic_skill_no = 3,
		learn_condition = [],
		magic_skill = [{1, [500031]}],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(4, 60004) -> 
        #fabao_magic_skill{
        no = 154,
		fabao_no = 60004,
		advance_no = 1,
	    magic_skill_no = 4,
		learn_condition = [],
		magic_skill = [{2, {phy_att,1, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(5, 60004) -> 
        #fabao_magic_skill{
        no = 155,
		fabao_no = 60004,
		advance_no = 1,
	    magic_skill_no = 5,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(6, 60004) -> 
        #fabao_magic_skill{
        no = 156,
		fabao_no = 60004,
		advance_no = 2,
	    magic_skill_no = 6,
		learn_condition = [{1, 5}],
		magic_skill = [{2, {mag_def, 1, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(7, 60004) -> 
        #fabao_magic_skill{
        no = 157,
		fabao_no = 60004,
		advance_no = 2,
	    magic_skill_no = 7,
		learn_condition = [{6, 5}],
		magic_skill = [{2, {hp_lim, 0, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(8, 60004) -> 
        #fabao_magic_skill{
        no = 158,
		fabao_no = 60004,
		advance_no = 2,
	    magic_skill_no = 8,
		learn_condition = [{3, 0}],
		magic_skill = [{2, {mp_lim, 0, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(9, 60004) -> 
        #fabao_magic_skill{
        no = 159,
		fabao_no = 60004,
		advance_no = 2,
	    magic_skill_no = 9,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(10, 60004) -> 
        #fabao_magic_skill{
        no = 160,
		fabao_no = 60004,
		advance_no = 2,
	    magic_skill_no = 10,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(11, 60004) -> 
        #fabao_magic_skill{
        no = 161,
		fabao_no = 60004,
		advance_no = 3,
	    magic_skill_no = 11,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(12, 60004) -> 
        #fabao_magic_skill{
        no = 162,
		fabao_no = 60004,
		advance_no = 3,
	    magic_skill_no = 12,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(13, 60004) -> 
        #fabao_magic_skill{
        no = 163,
		fabao_no = 60004,
		advance_no = 3,
	    magic_skill_no = 13,
		learn_condition = [{8, 5}],
		magic_skill = [{1, [500032]}],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(14, 60004) -> 
        #fabao_magic_skill{
        no = 164,
		fabao_no = 60004,
		advance_no = 3,
	    magic_skill_no = 14,
		learn_condition = [{4, 5},{15, 5}],
		magic_skill = [{2, {mag_att, 1, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(15, 60004) -> 
        #fabao_magic_skill{
        no = 165,
		fabao_no = 60004,
		advance_no = 3,
	    magic_skill_no = 15,
		learn_condition = [],
		magic_skill = [{2, {heal_value, 1, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(16, 60004) -> 
        #fabao_magic_skill{
        no = 166,
		fabao_no = 60004,
		advance_no = 4,
	    magic_skill_no = 16,
		learn_condition = [{6, 5}],
		magic_skill = [{2, {phy_def,2, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(17, 60004) -> 
        #fabao_magic_skill{
        no = 167,
		fabao_no = 60004,
		advance_no = 4,
	    magic_skill_no = 17,
		learn_condition = [{7, 5}],
		magic_skill = [{2, {seal_hit,1, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(18, 60004) -> 
        #fabao_magic_skill{
        no = 168,
		fabao_no = 60004,
		advance_no = 4,
	    magic_skill_no = 18,
		learn_condition = [{13, 0},{17, 5}],
		magic_skill = [{1, [500033]}],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(19, 60004) -> 
        #fabao_magic_skill{
        no = 169,
		fabao_no = 60004,
		advance_no = 4,
	    magic_skill_no = 19,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(20, 60004) -> 
        #fabao_magic_skill{
        no = 170,
		fabao_no = 60004,
		advance_no = 4,
	    magic_skill_no = 20,
		learn_condition = [{15, 8}],
		magic_skill = [{2, {heal_value,2, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(21, 60004) -> 
        #fabao_magic_skill{
        no = 171,
		fabao_no = 60004,
		advance_no = 5,
	    magic_skill_no = 21,
		learn_condition = [{16, 5}],
		magic_skill = [{2, {mag_def,2, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(22, 60004) -> 
        #fabao_magic_skill{
        no = 172,
		fabao_no = 60004,
		advance_no = 5,
	    magic_skill_no = 22,
		learn_condition = [{17, 5}],
		magic_skill = [{2, {seal_resis,1, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(23, 60004) -> 
        #fabao_magic_skill{
        no = 173,
		fabao_no = 60004,
		advance_no = 5,
	    magic_skill_no = 23,
		learn_condition = [{18, 0},{22, 5}],
		magic_skill = [{1, [500034]}],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(24, 60004) -> 
        #fabao_magic_skill{
        no = 174,
		fabao_no = 60004,
		advance_no = 5,
	    magic_skill_no = 24,
		learn_condition = [{14, 5}],
		magic_skill = [{2, {phy_att,2, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(25, 60004) -> 
        #fabao_magic_skill{
        no = 175,
		fabao_no = 60004,
		advance_no = 5,
	    magic_skill_no = 25,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(26, 60004) -> 
        #fabao_magic_skill{
        no = 176,
		fabao_no = 60004,
		advance_no = 6,
	    magic_skill_no = 26,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(27, 60004) -> 
        #fabao_magic_skill{
        no = 177,
		fabao_no = 60004,
		advance_no = 6,
	    magic_skill_no = 27,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(28, 60004) -> 
        #fabao_magic_skill{
        no = 178,
		fabao_no = 60004,
		advance_no = 6,
	    magic_skill_no = 28,
		learn_condition = [{23, 0}],
		magic_skill = [{2, {mp_lim, 2, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(29, 60004) -> 
        #fabao_magic_skill{
        no = 179,
		fabao_no = 60004,
		advance_no = 6,
	    magic_skill_no = 29,
		learn_condition = [{24, 5},{28, 5}],
		magic_skill = [{2, {mag_att,2, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(30, 60004) -> 
        #fabao_magic_skill{
        no = 180,
		fabao_no = 60004,
		advance_no = 6,
	    magic_skill_no = 30,
		learn_condition = [{20, 5}],
		magic_skill = [{2, {hp_lim, 2, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(31, 60004) -> 
        #fabao_magic_skill{
        no = 181,
		fabao_no = 60004,
		advance_no = 7,
	    magic_skill_no = 31,
		learn_condition = [{21, 5}],
		magic_skill = [{2, {phy_ten,4, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(32, 60004) -> 
        #fabao_magic_skill{
        no = 182,
		fabao_no = 60004,
		advance_no = 7,
	    magic_skill_no = 32,
		learn_condition = [{22, 5},{33, 0}],
		magic_skill = [{2, {seal_hit,3, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(33, 60004) -> 
        #fabao_magic_skill{
        no = 183,
		fabao_no = 60004,
		advance_no = 7,
	    magic_skill_no = 33,
		learn_condition = [{28, 5}],
		magic_skill = [{1, [500035]}],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(34, 60004) -> 
        #fabao_magic_skill{
        no = 184,
		fabao_no = 60004,
		advance_no = 7,
	    magic_skill_no = 34,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(35, 60004) -> 
        #fabao_magic_skill{
        no = 185,
		fabao_no = 60004,
		advance_no = 7,
	    magic_skill_no = 35,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(36, 60004) -> 
        #fabao_magic_skill{
        no = 186,
		fabao_no = 60004,
		advance_no = 8,
	    magic_skill_no = 36,
		learn_condition = [{31, 5}],
		magic_skill = [{2, {mag_ten,4, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(37, 60004) -> 
        #fabao_magic_skill{
        no = 187,
		fabao_no = 60004,
		advance_no = 8,
	    magic_skill_no = 37,
		learn_condition = [{32, 5}],
		magic_skill = [{2, {seal_resis,3, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(38, 60004) -> 
        #fabao_magic_skill{
        no = 188,
		fabao_no = 60004,
		advance_no = 8,
	    magic_skill_no = 38,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(39, 60004) -> 
        #fabao_magic_skill{
        no = 189,
		fabao_no = 60004,
		advance_no = 8,
	    magic_skill_no = 39,
		learn_condition = [{29, 5}],
		magic_skill = [{2, {phy_crit,4, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(40, 60004) -> 
        #fabao_magic_skill{
        no = 190,
		fabao_no = 60004,
		advance_no = 8,
	    magic_skill_no = 40,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(41, 60004) -> 
        #fabao_magic_skill{
        no = 191,
		fabao_no = 60004,
		advance_no = 9,
	    magic_skill_no = 41,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(42, 60004) -> 
        #fabao_magic_skill{
        no = 192,
		fabao_no = 60004,
		advance_no = 9,
	    magic_skill_no = 42,
		learn_condition = [{37, 5}],
		magic_skill = [{1, [500037]}],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(43, 60004) -> 
        #fabao_magic_skill{
        no = 193,
		fabao_no = 60004,
		advance_no = 9,
	    magic_skill_no = 43,
		learn_condition = [{33, 0},{42, 0}],
		magic_skill = [{2, {do_phy_dam_scaling,3, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(44, 60004) -> 
        #fabao_magic_skill{
        no = 194,
		fabao_no = 60004,
		advance_no = 9,
	    magic_skill_no = 44,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(45, 60004) -> 
        #fabao_magic_skill{
        no = 195,
		fabao_no = 60004,
		advance_no = 9,
	    magic_skill_no = 45,
		learn_condition = [{30, 10}],
		magic_skill = [{2, {be_phy_dam_reduce_coef,5, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(46, 60004) -> 
        #fabao_magic_skill{
        no = 196,
		fabao_no = 60004,
		advance_no = 10,
	    magic_skill_no = 46,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(47, 60004) -> 
        #fabao_magic_skill{
        no = 197,
		fabao_no = 60004,
		advance_no = 10,
	    magic_skill_no = 47,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(48, 60004) -> 
        #fabao_magic_skill{
        no = 198,
		fabao_no = 60004,
		advance_no = 10,
	    magic_skill_no = 48,
		learn_condition = [{43, 3}],
		magic_skill = [{2, {phy_crit_coef,4, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(49, 60004) -> 
        #fabao_magic_skill{
        no = 199,
		fabao_no = 60004,
		advance_no = 10,
	    magic_skill_no = 49,
		learn_condition = [{39, 5}],
		magic_skill = [{1, [500036]}],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(50, 60004) -> 
        #fabao_magic_skill{
        no = 200,
		fabao_no = 60004,
		advance_no = 10,
	    magic_skill_no = 50,
		learn_condition = [{45, 3},{49, 0}],
		magic_skill = [{2, {be_mag_dam_reduce_coef,5, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(1, 60005) -> 
        #fabao_magic_skill{
        no = 201,
		fabao_no = 60005,
		advance_no = 1,
	    magic_skill_no = 1,
		learn_condition = [],
		magic_skill = [{2, {heal_value, 1, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(2, 60005) -> 
        #fabao_magic_skill{
        no = 202,
		fabao_no = 60005,
		advance_no = 1,
	    magic_skill_no = 2,
		learn_condition = [],
		magic_skill = [{2, {mp_lim, 0, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(3, 60005) -> 
        #fabao_magic_skill{
        no = 203,
		fabao_no = 60005,
		advance_no = 1,
	    magic_skill_no = 3,
		learn_condition = [{2, 5}],
		magic_skill = [{2, {mag_att, 1, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(4, 60005) -> 
        #fabao_magic_skill{
        no = 204,
		fabao_no = 60005,
		advance_no = 1,
	    magic_skill_no = 4,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(5, 60005) -> 
        #fabao_magic_skill{
        no = 205,
		fabao_no = 60005,
		advance_no = 1,
	    magic_skill_no = 5,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(6, 60005) -> 
        #fabao_magic_skill{
        no = 206,
		fabao_no = 60005,
		advance_no = 2,
	    magic_skill_no = 6,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(7, 60005) -> 
        #fabao_magic_skill{
        no = 207,
		fabao_no = 60005,
		advance_no = 2,
	    magic_skill_no = 7,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(8, 60005) -> 
        #fabao_magic_skill{
        no = 208,
		fabao_no = 60005,
		advance_no = 2,
	    magic_skill_no = 8,
		learn_condition = [{3, 5}],
		magic_skill = [{1, [500021]}],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(9, 60005) -> 
        #fabao_magic_skill{
        no = 209,
		fabao_no = 60005,
		advance_no = 2,
	    magic_skill_no = 9,
		learn_condition = [{8, 0}],
		magic_skill = [{2, {mag_crit,4, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(10, 60005) -> 
        #fabao_magic_skill{
        no = 210,
		fabao_no = 60005,
		advance_no = 2,
	    magic_skill_no = 10,
		learn_condition = [],
		magic_skill = [{2, {act_speed,1, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(11, 60005) -> 
        #fabao_magic_skill{
        no = 211,
		fabao_no = 60005,
		advance_no = 3,
	    magic_skill_no = 11,
		learn_condition = [{1, 5}],
		magic_skill = [{2, {hp_lim, 0, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(12, 60005) -> 
        #fabao_magic_skill{
        no = 212,
		fabao_no = 60005,
		advance_no = 3,
	    magic_skill_no = 12,
		learn_condition = [{2, 5}],
		magic_skill = [{2, {mp_lim, 2, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(13, 60005) -> 
        #fabao_magic_skill{
        no = 213,
		fabao_no = 60005,
		advance_no = 3,
	    magic_skill_no = 13,
		learn_condition = [{8, 0}],
		magic_skill = [{1, [500022]}],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(14, 60005) -> 
        #fabao_magic_skill{
        no = 214,
		fabao_no = 60005,
		advance_no = 3,
	    magic_skill_no = 14,
		learn_condition = [{9, 5}],
		magic_skill = [{2, {phy_crit,4, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(15, 60005) -> 
        #fabao_magic_skill{
        no = 215,
		fabao_no = 60005,
		advance_no = 3,
	    magic_skill_no = 15,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(16, 60005) -> 
        #fabao_magic_skill{
        no = 216,
		fabao_no = 60005,
		advance_no = 4,
	    magic_skill_no = 16,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(17, 60005) -> 
        #fabao_magic_skill{
        no = 217,
		fabao_no = 60005,
		advance_no = 4,
	    magic_skill_no = 17,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(18, 60005) -> 
        #fabao_magic_skill{
        no = 218,
		fabao_no = 60005,
		advance_no = 4,
	    magic_skill_no = 18,
		learn_condition = [{13, 0}],
		magic_skill = [{2, {mag_def, 1, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(19, 60005) -> 
        #fabao_magic_skill{
        no = 219,
		fabao_no = 60005,
		advance_no = 4,
	    magic_skill_no = 19,
		learn_condition = [{14, 5}],
		magic_skill = [{2, {mag_att,2, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(20, 60005) -> 
        #fabao_magic_skill{
        no = 220,
		fabao_no = 60005,
		advance_no = 4,
	    magic_skill_no = 20,
		learn_condition = [{10, 5}],
		magic_skill = [{1, [500025]}],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(21, 60005) -> 
        #fabao_magic_skill{
        no = 221,
		fabao_no = 60005,
		advance_no = 5,
	    magic_skill_no = 21,
		learn_condition = [{11, 5}],
		magic_skill = [{2, {heal_value,2, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(22, 60005) -> 
        #fabao_magic_skill{
        no = 222,
		fabao_no = 60005,
		advance_no = 5,
	    magic_skill_no = 22,
		learn_condition = [{21, 5}],
		magic_skill = [{2, {phy_def,1, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(23, 60005) -> 
        #fabao_magic_skill{
        no = 223,
		fabao_no = 60005,
		advance_no = 5,
	    magic_skill_no = 23,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(24, 60005) -> 
        #fabao_magic_skill{
        no = 224,
		fabao_no = 60005,
		advance_no = 5,
	    magic_skill_no = 24,
		learn_condition = [{19, 5}],
		magic_skill = [{2, {seal_hit,3, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(25, 60005) -> 
        #fabao_magic_skill{
        no = 225,
		fabao_no = 60005,
		advance_no = 5,
	    magic_skill_no = 25,
		learn_condition = [{20, 0},{24, 5}],
		magic_skill = [{1, [500024]}],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(26, 60005) -> 
        #fabao_magic_skill{
        no = 226,
		fabao_no = 60005,
		advance_no = 6,
	    magic_skill_no = 26,
		learn_condition = [{21, 8}],
		magic_skill = [{1, [500023]}],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(27, 60005) -> 
        #fabao_magic_skill{
        no = 227,
		fabao_no = 60005,
		advance_no = 6,
	    magic_skill_no = 27,
		learn_condition = [{22, 5}],
		magic_skill = [{2, {phy_def,2, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(28, 60005) -> 
        #fabao_magic_skill{
        no = 228,
		fabao_no = 60005,
		advance_no = 6,
	    magic_skill_no = 28,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(29, 60005) -> 
        #fabao_magic_skill{
        no = 229,
		fabao_no = 60005,
		advance_no = 6,
	    magic_skill_no = 29,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(30, 60005) -> 
        #fabao_magic_skill{
        no = 230,
		fabao_no = 60005,
		advance_no = 6,
	    magic_skill_no = 30,
		learn_condition = [{25, 0}],
		magic_skill = [{2, {act_speed,2, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(31, 60005) -> 
        #fabao_magic_skill{
        no = 231,
		fabao_no = 60005,
		advance_no = 7,
	    magic_skill_no = 31,
		learn_condition = [{26, 0}],
		magic_skill = [{1, [500026]}],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(32, 60005) -> 
        #fabao_magic_skill{
        no = 232,
		fabao_no = 60005,
		advance_no = 7,
	    magic_skill_no = 32,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(33, 60005) -> 
        #fabao_magic_skill{
        no = 233,
		fabao_no = 60005,
		advance_no = 7,
	    magic_skill_no = 33,
		learn_condition = [{18, 5}],
		magic_skill = [{2, {mag_def,2, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(34, 60005) -> 
        #fabao_magic_skill{
        no = 234,
		fabao_no = 60005,
		advance_no = 7,
	    magic_skill_no = 34,
		learn_condition = [{24, 5}],
		magic_skill = [{2, {mag_ten,4, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(35, 60005) -> 
        #fabao_magic_skill{
        no = 235,
		fabao_no = 60005,
		advance_no = 7,
	    magic_skill_no = 35,
		learn_condition = [{30, 5},{34, 3}],
		magic_skill = [{2, {phy_ten,4, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(36, 60005) -> 
        #fabao_magic_skill{
        no = 236,
		fabao_no = 60005,
		advance_no = 8,
	    magic_skill_no = 36,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(37, 60005) -> 
        #fabao_magic_skill{
        no = 237,
		fabao_no = 60005,
		advance_no = 8,
	    magic_skill_no = 37,
		learn_condition = [{27, 5}],
		magic_skill = [{2, {seal_resis,3, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(38, 60005) -> 
        #fabao_magic_skill{
        no = 238,
		fabao_no = 60005,
		advance_no = 8,
	    magic_skill_no = 38,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(39, 60005) -> 
        #fabao_magic_skill{
        no = 239,
		fabao_no = 60005,
		advance_no = 8,
	    magic_skill_no = 39,
		learn_condition = [{34, 5}],
		magic_skill = [{1, [500027]}],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(40, 60005) -> 
        #fabao_magic_skill{
        no = 240,
		fabao_no = 60005,
		advance_no = 8,
	    magic_skill_no = 40,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(41, 60005) -> 
        #fabao_magic_skill{
        no = 241,
		fabao_no = 60005,
		advance_no = 9,
	    magic_skill_no = 41,
		learn_condition = [{31, 0}],
		magic_skill = [{2, {phy_att,2, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(42, 60005) -> 
        #fabao_magic_skill{
        no = 242,
		fabao_no = 60005,
		advance_no = 9,
	    magic_skill_no = 42,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(43, 60005) -> 
        #fabao_magic_skill{
        no = 243,
		fabao_no = 60005,
		advance_no = 9,
	    magic_skill_no = 43,
		learn_condition = [{33, 5}],
		magic_skill = [{2, {be_phy_dam_reduce_coef,5, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(44, 60005) -> 
        #fabao_magic_skill{
        no = 244,
		fabao_no = 60005,
		advance_no = 9,
	    magic_skill_no = 44,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(45, 60005) -> 
        #fabao_magic_skill{
        no = 245,
		fabao_no = 60005,
		advance_no = 9,
	    magic_skill_no = 45,
		learn_condition = [{35, 5}],
		magic_skill = [{2, {do_mag_dam_scaling,3, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(46, 60005) -> 
        #fabao_magic_skill{
        no = 246,
		fabao_no = 60005,
		advance_no = 10,
	    magic_skill_no = 46,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(47, 60005) -> 
        #fabao_magic_skill{
        no = 247,
		fabao_no = 60005,
		advance_no = 10,
	    magic_skill_no = 47,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(48, 60005) -> 
        #fabao_magic_skill{
        no = 248,
		fabao_no = 60005,
		advance_no = 10,
	    magic_skill_no = 48,
		learn_condition = [{43, 5}],
		magic_skill = [{2, {be_mag_dam_reduce_coef,5, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(49, 60005) -> 
        #fabao_magic_skill{
        no = 249,
		fabao_no = 60005,
		advance_no = 10,
	    magic_skill_no = 49,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(50, 60005) -> 
        #fabao_magic_skill{
        no = 250,
		fabao_no = 60005,
		advance_no = 10,
	    magic_skill_no = 50,
		learn_condition = [{45, 5}],
		magic_skill = [{2, {mag_crit_coef,4, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(1, 60006) -> 
        #fabao_magic_skill{
        no = 251,
		fabao_no = 60006,
		advance_no = 1,
	    magic_skill_no = 1,
		learn_condition = [],
		magic_skill = [{1, [500042]}],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(2, 60006) -> 
        #fabao_magic_skill{
        no = 252,
		fabao_no = 60006,
		advance_no = 1,
	    magic_skill_no = 2,
		learn_condition = [{1, 0}],
		magic_skill = [{2, {mag_att, 1, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(3, 60006) -> 
        #fabao_magic_skill{
        no = 253,
		fabao_no = 60006,
		advance_no = 1,
	    magic_skill_no = 3,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(4, 60006) -> 
        #fabao_magic_skill{
        no = 254,
		fabao_no = 60006,
		advance_no = 1,
	    magic_skill_no = 4,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(5, 60006) -> 
        #fabao_magic_skill{
        no = 255,
		fabao_no = 60006,
		advance_no = 1,
	    magic_skill_no = 5,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(6, 60006) -> 
        #fabao_magic_skill{
        no = 256,
		fabao_no = 60006,
		advance_no = 2,
	    magic_skill_no = 6,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(7, 60006) -> 
        #fabao_magic_skill{
        no = 257,
		fabao_no = 60006,
		advance_no = 2,
	    magic_skill_no = 7,
		learn_condition = [{2, 5}],
		magic_skill = [{2, {phy_att,1, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(8, 60006) -> 
        #fabao_magic_skill{
        no = 258,
		fabao_no = 60006,
		advance_no = 2,
	    magic_skill_no = 8,
		learn_condition = [],
		magic_skill = [{2, {mp_lim, 0, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(9, 60006) -> 
        #fabao_magic_skill{
        no = 259,
		fabao_no = 60006,
		advance_no = 2,
	    magic_skill_no = 9,
		learn_condition = [],
		magic_skill = [{2, {hp_lim, 0, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(10, 60006) -> 
        #fabao_magic_skill{
        no = 260,
		fabao_no = 60006,
		advance_no = 2,
	    magic_skill_no = 10,
		learn_condition = [],
		magic_skill = [{2, {heal_value, 1, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(11, 60006) -> 
        #fabao_magic_skill{
        no = 261,
		fabao_no = 60006,
		advance_no = 3,
	    magic_skill_no = 11,
		learn_condition = [{1, 0}],
		magic_skill = [{1, [500041]}],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(12, 60006) -> 
        #fabao_magic_skill{
        no = 262,
		fabao_no = 60006,
		advance_no = 3,
	    magic_skill_no = 12,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(13, 60006) -> 
        #fabao_magic_skill{
        no = 263,
		fabao_no = 60006,
		advance_no = 3,
	    magic_skill_no = 13,
		learn_condition = [{8, 5}],
		magic_skill = [{2, {mag_def, 1, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(14, 60006) -> 
        #fabao_magic_skill{
        no = 264,
		fabao_no = 60006,
		advance_no = 3,
	    magic_skill_no = 14,
		learn_condition = [{9, 5}],
		magic_skill = [{2, {phy_def,1, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(15, 60006) -> 
        #fabao_magic_skill{
        no = 265,
		fabao_no = 60006,
		advance_no = 3,
	    magic_skill_no = 15,
		learn_condition = [{10, 5}],
		magic_skill = [{2, {seal_resis,1, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(16, 60006) -> 
        #fabao_magic_skill{
        no = 266,
		fabao_no = 60006,
		advance_no = 4,
	    magic_skill_no = 16,
		learn_condition = [{11, 0}],
		magic_skill = [{2, {mag_crit,4, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(17, 60006) -> 
        #fabao_magic_skill{
        no = 267,
		fabao_no = 60006,
		advance_no = 4,
	    magic_skill_no = 17,
		learn_condition = [{7, 5}],
		magic_skill = [{2, {act_speed,1, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(18, 60006) -> 
        #fabao_magic_skill{
        no = 268,
		fabao_no = 60006,
		advance_no = 4,
	    magic_skill_no = 18,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(19, 60006) -> 
        #fabao_magic_skill{
        no = 269,
		fabao_no = 60006,
		advance_no = 4,
	    magic_skill_no = 19,
		learn_condition = [{14, 5}],
		magic_skill = [{2, {hp_lim, 2, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(20, 60006) -> 
        #fabao_magic_skill{
        no = 270,
		fabao_no = 60006,
		advance_no = 4,
	    magic_skill_no = 20,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(21, 60006) -> 
        #fabao_magic_skill{
        no = 271,
		fabao_no = 60006,
		advance_no = 5,
	    magic_skill_no = 21,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(22, 60006) -> 
        #fabao_magic_skill{
        no = 272,
		fabao_no = 60006,
		advance_no = 5,
	    magic_skill_no = 22,
		learn_condition = [{17, 5}],
		magic_skill = [{1, [500045]}],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(23, 60006) -> 
        #fabao_magic_skill{
        no = 273,
		fabao_no = 60006,
		advance_no = 5,
	    magic_skill_no = 23,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(24, 60006) -> 
        #fabao_magic_skill{
        no = 274,
		fabao_no = 60006,
		advance_no = 5,
	    magic_skill_no = 24,
		learn_condition = [{19, 5}],
		magic_skill = [{2, {phy_def,2, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(25, 60006) -> 
        #fabao_magic_skill{
        no = 275,
		fabao_no = 60006,
		advance_no = 5,
	    magic_skill_no = 25,
		learn_condition = [{15, 5}],
		magic_skill = [{2, {heal_value,2, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(26, 60006) -> 
        #fabao_magic_skill{
        no = 276,
		fabao_no = 60006,
		advance_no = 6,
	    magic_skill_no = 26,
		learn_condition = [{16, 5}],
		magic_skill = [{1, [500044]}],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(27, 60006) -> 
        #fabao_magic_skill{
        no = 277,
		fabao_no = 60006,
		advance_no = 6,
	    magic_skill_no = 27,
		learn_condition = [{22, 0}],
		magic_skill = [{2, {seal_hit,1, [1, 30]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{10,5}, {20,15}],
		money = [{1,1000000}]
	    }
    ;

    get(28, 60006) -> 
        #fabao_magic_skill{
        no = 278,
		fabao_no = 60006,
		advance_no = 6,
	    magic_skill_no = 28,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(29, 60006) -> 
        #fabao_magic_skill{
        no = 279,
		fabao_no = 60006,
		advance_no = 6,
	    magic_skill_no = 29,
		learn_condition = [{24, 5}],
		magic_skill = [{2, {mag_def,2, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(30, 60006) -> 
        #fabao_magic_skill{
        no = 280,
		fabao_no = 60006,
		advance_no = 6,
	    magic_skill_no = 30,
		learn_condition = [{25, 8}],
		magic_skill = [{2, {seal_resis,3, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(31, 60006) -> 
        #fabao_magic_skill{
        no = 281,
		fabao_no = 60006,
		advance_no = 7,
	    magic_skill_no = 31,
		learn_condition = [{26, 0}],
		magic_skill = [{2, {mag_att,2, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(32, 60006) -> 
        #fabao_magic_skill{
        no = 282,
		fabao_no = 60006,
		advance_no = 7,
	    magic_skill_no = 32,
		learn_condition = [{27, 8}],
		magic_skill = [{2, {seal_hit,3, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(33, 60006) -> 
        #fabao_magic_skill{
        no = 283,
		fabao_no = 60006,
		advance_no = 7,
	    magic_skill_no = 33,
		learn_condition = [{13, 5}],
		magic_skill = [{2, {phy_crit,4, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(34, 60006) -> 
        #fabao_magic_skill{
        no = 284,
		fabao_no = 60006,
		advance_no = 7,
	    magic_skill_no = 34,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(35, 60006) -> 
        #fabao_magic_skill{
        no = 285,
		fabao_no = 60006,
		advance_no = 7,
	    magic_skill_no = 35,
		learn_condition = [{30, 5}],
		magic_skill = [{1, [500043]}],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(36, 60006) -> 
        #fabao_magic_skill{
        no = 286,
		fabao_no = 60006,
		advance_no = 8,
	    magic_skill_no = 36,
		learn_condition = [{31, 5}],
		magic_skill = [{1, [500047]}],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(37, 60006) -> 
        #fabao_magic_skill{
        no = 287,
		fabao_no = 60006,
		advance_no = 8,
	    magic_skill_no = 37,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(38, 60006) -> 
        #fabao_magic_skill{
        no = 288,
		fabao_no = 60006,
		advance_no = 8,
	    magic_skill_no = 38,
		learn_condition = [{33, 5},{39, 5}],
		magic_skill = [{1, [500046]}],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(39, 60006) -> 
        #fabao_magic_skill{
        no = 289,
		fabao_no = 60006,
		advance_no = 8,
	    magic_skill_no = 39,
		learn_condition = [{29, 5}],
		magic_skill = [{2, {phy_ten,4, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(40, 60006) -> 
        #fabao_magic_skill{
        no = 290,
		fabao_no = 60006,
		advance_no = 8,
	    magic_skill_no = 40,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(41, 60006) -> 
        #fabao_magic_skill{
        no = 291,
		fabao_no = 60006,
		advance_no = 9,
	    magic_skill_no = 41,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(42, 60006) -> 
        #fabao_magic_skill{
        no = 292,
		fabao_no = 60006,
		advance_no = 9,
	    magic_skill_no = 42,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(43, 60006) -> 
        #fabao_magic_skill{
        no = 293,
		fabao_no = 60006,
		advance_no = 9,
	    magic_skill_no = 43,
		learn_condition = [{38, 0},{44, 5}],
		magic_skill = [{2, {be_mag_dam_reduce_coef,5, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(44, 60006) -> 
        #fabao_magic_skill{
        no = 294,
		fabao_no = 60006,
		advance_no = 9,
	    magic_skill_no = 44,
		learn_condition = [{39, 5}],
		magic_skill = [{2, {mag_ten,4, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(45, 60006) -> 
        #fabao_magic_skill{
        no = 295,
		fabao_no = 60006,
		advance_no = 9,
	    magic_skill_no = 45,
		learn_condition = [{35, 0},{44, 5}],
		magic_skill = [{2, {be_phy_dam_reduce_coef,5, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(46, 60006) -> 
        #fabao_magic_skill{
        no = 296,
		fabao_no = 60006,
		advance_no = 10,
	    magic_skill_no = 46,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(47, 60006) -> 
        #fabao_magic_skill{
        no = 297,
		fabao_no = 60006,
		advance_no = 10,
	    magic_skill_no = 47,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(48, 60006) -> 
        #fabao_magic_skill{
        no = 298,
		fabao_no = 60006,
		advance_no = 10,
	    magic_skill_no = 48,
		learn_condition = [{43, 5}],
		magic_skill = [{2, {do_mag_dam_scaling,3, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(49, 60006) -> 
        #fabao_magic_skill{
        no = 299,
		fabao_no = 60006,
		advance_no = 10,
	    magic_skill_no = 49,
		learn_condition = [{44, 5},{48, 3}],
		magic_skill = [{2, {mag_crit_coef,4, [1, 15]}}],
		skill_point_cost = 5,
		skill_point_extra_cost = [{5,5}, {10,10}],
		money = [{1,1000000}]
	    }
    ;

    get(50, 60006) -> 
        #fabao_magic_skill{
        no = 300,
		fabao_no = 60006,
		advance_no = 10,
	    magic_skill_no = 50,
		learn_condition = [],
		magic_skill = [],
		skill_point_cost = 0,
		skill_point_extra_cost = [],
		money = []
	    }
    ;

    get(_Arg1, _Arg2) ->
        ?ASSERT(false, [_Arg1, _Arg2]), null.
    
