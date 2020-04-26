%%%---------------------------------------
%%% @Module  : data_mk_skill_up
%%% @Author  : zhangwq
%%% @Email   : 
%%% @Description: 法宝技能升级
%%%---------------------------------------


-module(data_mk_skill_up).
-include("common.hrl").
-include("record.hrl").
-include("record/goods_record.hrl").
-include("num_limits.hrl").
-compile(export_all).

get(60001) ->
	#mk_skill_up_cfg{
		skill_id = 60001,
		next_id = 60002,
		quality_need = 2,
		consume_role_exp = 7200000
};

get(60002) ->
	#mk_skill_up_cfg{
		skill_id = 60002,
		next_id = 60003,
		quality_need = 4,
		consume_role_exp = 16800000
};

get(60011) ->
	#mk_skill_up_cfg{
		skill_id = 60011,
		next_id = 60012,
		quality_need = 2,
		consume_role_exp = 7200000
};

get(60012) ->
	#mk_skill_up_cfg{
		skill_id = 60012,
		next_id = 60013,
		quality_need = 4,
		consume_role_exp = 16800000
};

get(60021) ->
	#mk_skill_up_cfg{
		skill_id = 60021,
		next_id = 60022,
		quality_need = 2,
		consume_role_exp = 7200000
};

get(60022) ->
	#mk_skill_up_cfg{
		skill_id = 60022,
		next_id = 60023,
		quality_need = 4,
		consume_role_exp = 16800000
};

get(60031) ->
	#mk_skill_up_cfg{
		skill_id = 60031,
		next_id = 60032,
		quality_need = 2,
		consume_role_exp = 7200000
};

get(60032) ->
	#mk_skill_up_cfg{
		skill_id = 60032,
		next_id = 60033,
		quality_need = 4,
		consume_role_exp = 16800000
};

get(60041) ->
	#mk_skill_up_cfg{
		skill_id = 60041,
		next_id = 60042,
		quality_need = 2,
		consume_role_exp = 7200000
};

get(60042) ->
	#mk_skill_up_cfg{
		skill_id = 60042,
		next_id = 60043,
		quality_need = 4,
		consume_role_exp = 16800000
};

get(60051) ->
	#mk_skill_up_cfg{
		skill_id = 60051,
		next_id = 60052,
		quality_need = 2,
		consume_role_exp = 7200000
};

get(60052) ->
	#mk_skill_up_cfg{
		skill_id = 60052,
		next_id = 60053,
		quality_need = 4,
		consume_role_exp = 16800000
};

get(62001) ->
	#mk_skill_up_cfg{
		skill_id = 62001,
		next_id = 62002,
		quality_need = 4,
		consume_role_exp = 7200000
};

get(62002) ->
	#mk_skill_up_cfg{
		skill_id = 62002,
		next_id = 62003,
		quality_need = 6,
		consume_role_exp = 16800000
};

get(62011) ->
	#mk_skill_up_cfg{
		skill_id = 62011,
		next_id = 62012,
		quality_need = 4,
		consume_role_exp = 7200000
};

get(62012) ->
	#mk_skill_up_cfg{
		skill_id = 62012,
		next_id = 62013,
		quality_need = 6,
		consume_role_exp = 16800000
};

get(62021) ->
	#mk_skill_up_cfg{
		skill_id = 62021,
		next_id = 62022,
		quality_need = 4,
		consume_role_exp = 7200000
};

get(62022) ->
	#mk_skill_up_cfg{
		skill_id = 62022,
		next_id = 62023,
		quality_need = 6,
		consume_role_exp = 16800000
};

get(62031) ->
	#mk_skill_up_cfg{
		skill_id = 62031,
		next_id = 62032,
		quality_need = 4,
		consume_role_exp = 7200000
};

get(62032) ->
	#mk_skill_up_cfg{
		skill_id = 62032,
		next_id = 62033,
		quality_need = 6,
		consume_role_exp = 16800000
};

get(62041) ->
	#mk_skill_up_cfg{
		skill_id = 62041,
		next_id = 62042,
		quality_need = 4,
		consume_role_exp = 7200000
};

get(62042) ->
	#mk_skill_up_cfg{
		skill_id = 62042,
		next_id = 62043,
		quality_need = 6,
		consume_role_exp = 16800000
};

get(62051) ->
	#mk_skill_up_cfg{
		skill_id = 62051,
		next_id = 62052,
		quality_need = 4,
		consume_role_exp = 7200000
};

get(62052) ->
	#mk_skill_up_cfg{
		skill_id = 62052,
		next_id = 62053,
		quality_need = 6,
		consume_role_exp = 16800000
};

get(62061) ->
	#mk_skill_up_cfg{
		skill_id = 62061,
		next_id = 62062,
		quality_need = 4,
		consume_role_exp = 7200000
};

get(62062) ->
	#mk_skill_up_cfg{
		skill_id = 62062,
		next_id = 62063,
		quality_need = 6,
		consume_role_exp = 16800000
};

get(62071) ->
	#mk_skill_up_cfg{
		skill_id = 62071,
		next_id = 62072,
		quality_need = 4,
		consume_role_exp = 7200000
};

get(62072) ->
	#mk_skill_up_cfg{
		skill_id = 62072,
		next_id = 62073,
		quality_need = 6,
		consume_role_exp = 16800000
};

get(62081) ->
	#mk_skill_up_cfg{
		skill_id = 62081,
		next_id = 62082,
		quality_need = 4,
		consume_role_exp = 7200000
};

get(62082) ->
	#mk_skill_up_cfg{
		skill_id = 62082,
		next_id = 62083,
		quality_need = 6,
		consume_role_exp = 16800000
};

get(62091) ->
	#mk_skill_up_cfg{
		skill_id = 62091,
		next_id = 62092,
		quality_need = 4,
		consume_role_exp = 7200000
};

get(62092) ->
	#mk_skill_up_cfg{
		skill_id = 62092,
		next_id = 62093,
		quality_need = 6,
		consume_role_exp = 16800000
};

get(62101) ->
	#mk_skill_up_cfg{
		skill_id = 62101,
		next_id = 62102,
		quality_need = 4,
		consume_role_exp = 7200000
};

get(62102) ->
	#mk_skill_up_cfg{
		skill_id = 62102,
		next_id = 62103,
		quality_need = 6,
		consume_role_exp = 16800000
};

get(62111) ->
	#mk_skill_up_cfg{
		skill_id = 62111,
		next_id = 62112,
		quality_need = 4,
		consume_role_exp = 7200000
};

get(62112) ->
	#mk_skill_up_cfg{
		skill_id = 62112,
		next_id = 62113,
		quality_need = 6,
		consume_role_exp = 16800000
};

get(62121) ->
	#mk_skill_up_cfg{
		skill_id = 62121,
		next_id = 62122,
		quality_need = 4,
		consume_role_exp = 7200000
};

get(62122) ->
	#mk_skill_up_cfg{
		skill_id = 62122,
		next_id = 62123,
		quality_need = 6,
		consume_role_exp = 16800000
};

get(62131) ->
	#mk_skill_up_cfg{
		skill_id = 62131,
		next_id = 62132,
		quality_need = 4,
		consume_role_exp = 7200000
};

get(62132) ->
	#mk_skill_up_cfg{
		skill_id = 62132,
		next_id = 62133,
		quality_need = 6,
		consume_role_exp = 16800000
};

get(62141) ->
	#mk_skill_up_cfg{
		skill_id = 62141,
		next_id = 62142,
		quality_need = 4,
		consume_role_exp = 7200000
};

get(62142) ->
	#mk_skill_up_cfg{
		skill_id = 62142,
		next_id = 62143,
		quality_need = 6,
		consume_role_exp = 16800000
};

get(_No) ->
    null.

