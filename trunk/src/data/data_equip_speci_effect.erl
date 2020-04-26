%%%---------------------------------------
%%% @Module  : data_equip_speci_effect
%%% @Author  : dsh
%%% @Email   : 
%%% @Description:  物品
%%%---------------------------------------


-module(data_equip_speci_effect).
-include("common.hrl").
-include("record.hrl").
-include("record/goods_record.hrl").
-compile(export_all).

get_all_no()->
	[4001,4002,4003,4004,4005,4006,4007,4008,4009,4010,4011,4012,4013,4014,4015,4016,4017,4018,4019,4020,4021,4022,4023,4024,4025,4026,4027,4028,4029,4030,4031,4032,4033,4034,4035,4036,4037,4038,4039,4040,4041,4042,4043,4044,4045,4046,4047,4048,4049,4050,4051,4052,4053,4054,4101,4102,4103,4104,4105,4106,4107,4108,4109,4110,4111,4112,4113,4114,4115,4116,4117,4118,4119,4120,4121,4122,4123,4124,4125,4126,4127,4128,4129,4130,4131,4132,4133,4134,4135,4136,4137,4138,4139,4140,4141,4142,4143,4144,4145,4146,4147,4148,4149,4150,4151,4152,4153,4154,4201,4202,4203,4204,4205,4206,4207,4208,4209,4210,4211,4212,4213,4214,4215,4216,4217,4218,4219,4220,4221,4222,4223,4224,4225,4226,4227,4228,4229,4230,4231,4232,4233,4234,4235,4236,4237,4238,4239,4240,4241,4242,4243,4244,4245,4246,4247,4248,4249,4250,4251,4252,4253,4254,4301,4302,4303,4304,4305,4306,4307,4308,4309,4310,4311,4312,4313,4314,4315,4316,4317,4318,4319,4320,4321,4322,4323,4324,4325,4326,4327,4328,4329,4330,4331,4332,4333,4334,4335,4336,4337,4338,4339,4340,4341,4342,4343,4344,4345,4346,4347,4348,4349,4350,4351,4352,4353,4354,4401,4402,4403,4404,4405,4406,4407,4408,4409,4410,4411,4412,4413,4414,4415,4416,4417,4418,4419,4420,4421,4422,4423,4424,4425,4426,4427,4428,4429,4430,4431,4432,4433,4434,4435,4436,4437,4438,4439,4440,4441,4442,4443,4444,4445,4446,4447,4448,4449,4450,4451,4452,4453,4454,4501,4502,4503,4504,4505,4506,4507,4508,4509,4510,4511,4512,4513,4514,4515,4516,4517,4518,4519,4520,4521,4522,4523,4524,4525,4526,4527,4528,4529,4530,4531,4532,4533,4534,4535,4536,4537,4538,4539,4540,4541,4542,4543,4544,4545,4546,4547,4548,4549,4550,4551,4552,4553,4554,9000].

get_type_no(1)->
	[4001,4002,4003,4004,4005,4006,4007,4008,4009,4010,4011,4012,4013,4014,4015,4016,4017,4018,4019,4020,4021,4022,4023,4024,4025,4026,4027,4028,4029,4030,4031,4032,4033,4034,4035,4036,4037,4038,4039,4040,4041,4042,4043,4044,4045,4046,4047,4048,4049,4050,4051,4052,4053,4054,4101,4102,4103,4104,4105,4106,4107,4108,4109,4110,4111,4112,4113,4114,4115,4116,4117,4118,4119,4120,4121,4122,4123,4124,4125,4126,4127,4128,4129,4130,4131,4132,4133,4134,4135,4136,4137,4138,4139,4140,4141,4142,4143,4144,4145,4146,4147,4148,4149,4150,4151,4152,4153,4154,4201,4202,4203,4204,4205,4206,4207,4208,4209,4210,4211,4212,4213,4214,4215,4216,4217,4218,4219,4220,4221,4222,4223,4224,4225,4226,4227,4228,4229,4230,4231,4232,4233,4234,4235,4236,4237,4238,4239,4240,4241,4242,4243,4244,4245,4246,4247,4248,4249,4250,4251,4252,4253,4254,4301,4302,4303,4304,4305,4306,4307,4308,4309,4310,4311,4312,4313,4314,4315,4316,4317,4318,4319,4320,4321,4322,4323,4324,4325,4326,4327,4328,4329,4330,4331,4332,4333,4334,4335,4336,4337,4338,4339,4340,4341,4342,4343,4344,4345,4346,4347,4348,4349,4350,4351,4352,4353,4354,4401,4402,4403,4404,4405,4406,4407,4408,4409,4410,4411,4412,4413,4414,4415,4416,4417,4418,4419,4420,4421,4422,4423,4424,4425,4426,4427,4428,4429,4430,4431,4432,4433,4434,4435,4436,4437,4438,4439,4440,4441,4442,4443,4444,4445,4446,4447,4448,4449,4450,4451,4452,4453,4454,4501,4502,4503,4504,4505,4506,4507,4508,4509,4510,4511,4512,4513,4514,4515,4516,4517,4518,4519,4520,4521,4522,4523,4524,4525,4526,4527,4528,4529,4530,4531,4532,4533,4534,4535,4536,4537,4538,4539,4540,4541,4542,4543,4544,4545,4546,4547,4548,4549,4550,4551,4552,4553,4554,9000];

get_type_no(_Arg) ->
    null.
          
get(4001) ->
	#equip_speci_effect_tpl{
		no = 4001,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 1,
		value = 4001,
		need_broadcast = 0,
		type = 1,
		attribute = 1
};

get(4002) ->
	#equip_speci_effect_tpl{
		no = 4002,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 1,
		value = 4002,
		need_broadcast = 0,
		type = 1,
		attribute = 2
};

get(4003) ->
	#equip_speci_effect_tpl{
		no = 4003,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 1,
		value = 4003,
		need_broadcast = 0,
		type = 1,
		attribute = 3
};

get(4004) ->
	#equip_speci_effect_tpl{
		no = 4004,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 1,
		value = 4004,
		need_broadcast = 0,
		type = 1,
		attribute = 4
};

get(4005) ->
	#equip_speci_effect_tpl{
		no = 4005,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 1,
		value = 4005,
		need_broadcast = 0,
		type = 1,
		attribute = 5
};

get(4006) ->
	#equip_speci_effect_tpl{
		no = 4006,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 1,
		value = 4006,
		need_broadcast = 0,
		type = 1,
		attribute = 6
};

get(4007) ->
	#equip_speci_effect_tpl{
		no = 4007,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 1,
		value = 4008,
		need_broadcast = 0,
		type = 1,
		attribute = 7
};

get(4008) ->
	#equip_speci_effect_tpl{
		no = 4008,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 1,
		value = 4009,
		need_broadcast = 0,
		type = 1,
		attribute = 8
};

get(4009) ->
	#equip_speci_effect_tpl{
		no = 4009,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 1,
		value = 4011,
		need_broadcast = 0,
		type = 1,
		attribute = 9
};

get(4010) ->
	#equip_speci_effect_tpl{
		no = 4010,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 1,
		value = 4012,
		need_broadcast = 0,
		type = 1,
		attribute = 10
};

get(4011) ->
	#equip_speci_effect_tpl{
		no = 4011,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 1,
		value = 4013,
		need_broadcast = 0,
		type = 1,
		attribute = 11
};

get(4012) ->
	#equip_speci_effect_tpl{
		no = 4012,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 1,
		value = 4014,
		need_broadcast = 0,
		type = 1,
		attribute = 12
};

get(4013) ->
	#equip_speci_effect_tpl{
		no = 4013,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 1,
		value = 4015,
		need_broadcast = 0,
		type = 1,
		attribute = 13
};

get(4014) ->
	#equip_speci_effect_tpl{
		no = 4014,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 1,
		value = 4016,
		need_broadcast = 0,
		type = 1,
		attribute = 14
};

get(4015) ->
	#equip_speci_effect_tpl{
		no = 4015,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 1,
		value = 4017,
		need_broadcast = 0,
		type = 1,
		attribute = 15
};

get(4016) ->
	#equip_speci_effect_tpl{
		no = 4016,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 1,
		value = 4018,
		need_broadcast = 0,
		type = 1,
		attribute = 16
};

get(4017) ->
	#equip_speci_effect_tpl{
		no = 4017,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 1,
		value = 4019,
		need_broadcast = 0,
		type = 1,
		attribute = 17
};

get(4018) ->
	#equip_speci_effect_tpl{
		no = 4018,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 1,
		value = 4020,
		need_broadcast = 0,
		type = 1,
		attribute = 18
};

get(4019) ->
	#equip_speci_effect_tpl{
		no = 4019,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 1,
		value = 4021,
		need_broadcast = 0,
		type = 1,
		attribute = 19
};

get(4020) ->
	#equip_speci_effect_tpl{
		no = 4020,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 1,
		value = 4022,
		need_broadcast = 0,
		type = 1,
		attribute = 20
};

get(4021) ->
	#equip_speci_effect_tpl{
		no = 4021,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 1,
		value = 4023,
		need_broadcast = 0,
		type = 1,
		attribute = 21
};

get(4022) ->
	#equip_speci_effect_tpl{
		no = 4022,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 1,
		value = 4024,
		need_broadcast = 0,
		type = 1,
		attribute = 22
};

get(4023) ->
	#equip_speci_effect_tpl{
		no = 4023,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 1,
		value = 4025,
		need_broadcast = 0,
		type = 1,
		attribute = 23
};

get(4024) ->
	#equip_speci_effect_tpl{
		no = 4024,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 1,
		value = 4026,
		need_broadcast = 0,
		type = 1,
		attribute = 24
};

get(4025) ->
	#equip_speci_effect_tpl{
		no = 4025,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 1,
		value = 4027,
		need_broadcast = 0,
		type = 1,
		attribute = 25
};

get(4026) ->
	#equip_speci_effect_tpl{
		no = 4026,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 1,
		value = 4028,
		need_broadcast = 0,
		type = 1,
		attribute = 26
};

get(4027) ->
	#equip_speci_effect_tpl{
		no = 4027,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 1,
		value = 4029,
		need_broadcast = 0,
		type = 1,
		attribute = 27
};

get(4028) ->
	#equip_speci_effect_tpl{
		no = 4028,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 1,
		value = 4030,
		need_broadcast = 0,
		type = 1,
		attribute = 28
};

get(4029) ->
	#equip_speci_effect_tpl{
		no = 4029,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 1,
		value = 4031,
		need_broadcast = 0,
		type = 1,
		attribute = 29
};

get(4030) ->
	#equip_speci_effect_tpl{
		no = 4030,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 1,
		value = 4032,
		need_broadcast = 0,
		type = 1,
		attribute = 30
};

get(4031) ->
	#equip_speci_effect_tpl{
		no = 4031,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 1,
		value = 4033,
		need_broadcast = 0,
		type = 1,
		attribute = 31
};

get(4032) ->
	#equip_speci_effect_tpl{
		no = 4032,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 1,
		value = 4034,
		need_broadcast = 0,
		type = 1,
		attribute = 32
};

get(4033) ->
	#equip_speci_effect_tpl{
		no = 4033,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 1,
		value = 4035,
		need_broadcast = 0,
		type = 1,
		attribute = 33
};

get(4034) ->
	#equip_speci_effect_tpl{
		no = 4034,
		rarity_no = 4,
		eff_name = equip_effect_to_low_level,
		lv = 1,
		value = 40,
		need_broadcast = 0,
		type = 1,
		attribute = 34
};

get(4035) ->
	#equip_speci_effect_tpl{
		no = 4035,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 1,
		value = {201,40},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4036) ->
	#equip_speci_effect_tpl{
		no = 4036,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 1,
		value = {202,40},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4037) ->
	#equip_speci_effect_tpl{
		no = 4037,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 1,
		value = {203,40},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4038) ->
	#equip_speci_effect_tpl{
		no = 4038,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 1,
		value = {204,40},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4039) ->
	#equip_speci_effect_tpl{
		no = 4039,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 1,
		value = {205,40},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4040) ->
	#equip_speci_effect_tpl{
		no = 4040,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 1,
		value = {301,40},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4041) ->
	#equip_speci_effect_tpl{
		no = 4041,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 1,
		value = {302,40},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4042) ->
	#equip_speci_effect_tpl{
		no = 4042,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 1,
		value = {303,40},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4043) ->
	#equip_speci_effect_tpl{
		no = 4043,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 1,
		value = {304,40},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4044) ->
	#equip_speci_effect_tpl{
		no = 4044,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 1,
		value = {305,40},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4045) ->
	#equip_speci_effect_tpl{
		no = 4045,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 1,
		value = {401,40},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4046) ->
	#equip_speci_effect_tpl{
		no = 4046,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 1,
		value = {402,40},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4047) ->
	#equip_speci_effect_tpl{
		no = 4047,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 1,
		value = {403,40},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4048) ->
	#equip_speci_effect_tpl{
		no = 4048,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 1,
		value = {404,40},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4049) ->
	#equip_speci_effect_tpl{
		no = 4049,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 1,
		value = {405,40},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4050) ->
	#equip_speci_effect_tpl{
		no = 4050,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 1,
		value = {501,40},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4051) ->
	#equip_speci_effect_tpl{
		no = 4051,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 1,
		value = {502,40},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4052) ->
	#equip_speci_effect_tpl{
		no = 4052,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 1,
		value = {503,40},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4053) ->
	#equip_speci_effect_tpl{
		no = 4053,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 1,
		value = {504,40},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4054) ->
	#equip_speci_effect_tpl{
		no = 4054,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 1,
		value = {505,40},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4101) ->
	#equip_speci_effect_tpl{
		no = 4101,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 2,
		value = 4101,
		need_broadcast = 0,
		type = 1,
		attribute = 1
};

get(4102) ->
	#equip_speci_effect_tpl{
		no = 4102,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 2,
		value = 4102,
		need_broadcast = 0,
		type = 1,
		attribute = 2
};

get(4103) ->
	#equip_speci_effect_tpl{
		no = 4103,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 2,
		value = 4103,
		need_broadcast = 0,
		type = 1,
		attribute = 3
};

get(4104) ->
	#equip_speci_effect_tpl{
		no = 4104,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 2,
		value = 4104,
		need_broadcast = 0,
		type = 1,
		attribute = 4
};

get(4105) ->
	#equip_speci_effect_tpl{
		no = 4105,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 2,
		value = 4105,
		need_broadcast = 0,
		type = 1,
		attribute = 5
};

get(4106) ->
	#equip_speci_effect_tpl{
		no = 4106,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 2,
		value = 4106,
		need_broadcast = 0,
		type = 1,
		attribute = 6
};

get(4107) ->
	#equip_speci_effect_tpl{
		no = 4107,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 2,
		value = 4108,
		need_broadcast = 0,
		type = 1,
		attribute = 7
};

get(4108) ->
	#equip_speci_effect_tpl{
		no = 4108,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 2,
		value = 4109,
		need_broadcast = 0,
		type = 1,
		attribute = 8
};

get(4109) ->
	#equip_speci_effect_tpl{
		no = 4109,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 2,
		value = 4111,
		need_broadcast = 0,
		type = 1,
		attribute = 9
};

get(4110) ->
	#equip_speci_effect_tpl{
		no = 4110,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 2,
		value = 4112,
		need_broadcast = 0,
		type = 1,
		attribute = 10
};

get(4111) ->
	#equip_speci_effect_tpl{
		no = 4111,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 2,
		value = 4113,
		need_broadcast = 0,
		type = 1,
		attribute = 11
};

get(4112) ->
	#equip_speci_effect_tpl{
		no = 4112,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 2,
		value = 4114,
		need_broadcast = 0,
		type = 1,
		attribute = 12
};

get(4113) ->
	#equip_speci_effect_tpl{
		no = 4113,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 2,
		value = 4115,
		need_broadcast = 0,
		type = 1,
		attribute = 13
};

get(4114) ->
	#equip_speci_effect_tpl{
		no = 4114,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 2,
		value = 4116,
		need_broadcast = 0,
		type = 1,
		attribute = 14
};

get(4115) ->
	#equip_speci_effect_tpl{
		no = 4115,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 2,
		value = 4117,
		need_broadcast = 0,
		type = 1,
		attribute = 15
};

get(4116) ->
	#equip_speci_effect_tpl{
		no = 4116,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 2,
		value = 4118,
		need_broadcast = 0,
		type = 1,
		attribute = 16
};

get(4117) ->
	#equip_speci_effect_tpl{
		no = 4117,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 2,
		value = 4119,
		need_broadcast = 0,
		type = 1,
		attribute = 17
};

get(4118) ->
	#equip_speci_effect_tpl{
		no = 4118,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 2,
		value = 4120,
		need_broadcast = 0,
		type = 1,
		attribute = 18
};

get(4119) ->
	#equip_speci_effect_tpl{
		no = 4119,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 2,
		value = 4121,
		need_broadcast = 0,
		type = 1,
		attribute = 19
};

get(4120) ->
	#equip_speci_effect_tpl{
		no = 4120,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 2,
		value = 4122,
		need_broadcast = 0,
		type = 1,
		attribute = 20
};

get(4121) ->
	#equip_speci_effect_tpl{
		no = 4121,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 2,
		value = 4123,
		need_broadcast = 0,
		type = 1,
		attribute = 21
};

get(4122) ->
	#equip_speci_effect_tpl{
		no = 4122,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 2,
		value = 4124,
		need_broadcast = 0,
		type = 1,
		attribute = 22
};

get(4123) ->
	#equip_speci_effect_tpl{
		no = 4123,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 2,
		value = 4125,
		need_broadcast = 0,
		type = 1,
		attribute = 23
};

get(4124) ->
	#equip_speci_effect_tpl{
		no = 4124,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 2,
		value = 4126,
		need_broadcast = 0,
		type = 1,
		attribute = 24
};

get(4125) ->
	#equip_speci_effect_tpl{
		no = 4125,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 2,
		value = 4127,
		need_broadcast = 0,
		type = 1,
		attribute = 25
};

get(4126) ->
	#equip_speci_effect_tpl{
		no = 4126,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 2,
		value = 4128,
		need_broadcast = 0,
		type = 1,
		attribute = 26
};

get(4127) ->
	#equip_speci_effect_tpl{
		no = 4127,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 2,
		value = 4129,
		need_broadcast = 0,
		type = 1,
		attribute = 27
};

get(4128) ->
	#equip_speci_effect_tpl{
		no = 4128,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 2,
		value = 4130,
		need_broadcast = 0,
		type = 1,
		attribute = 28
};

get(4129) ->
	#equip_speci_effect_tpl{
		no = 4129,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 2,
		value = 4131,
		need_broadcast = 0,
		type = 1,
		attribute = 29
};

get(4130) ->
	#equip_speci_effect_tpl{
		no = 4130,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 2,
		value = 4132,
		need_broadcast = 0,
		type = 1,
		attribute = 30
};

get(4131) ->
	#equip_speci_effect_tpl{
		no = 4131,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 2,
		value = 4133,
		need_broadcast = 0,
		type = 1,
		attribute = 31
};

get(4132) ->
	#equip_speci_effect_tpl{
		no = 4132,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 2,
		value = 4134,
		need_broadcast = 0,
		type = 1,
		attribute = 32
};

get(4133) ->
	#equip_speci_effect_tpl{
		no = 4133,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 2,
		value = 4135,
		need_broadcast = 0,
		type = 1,
		attribute = 33
};

get(4134) ->
	#equip_speci_effect_tpl{
		no = 4134,
		rarity_no = 4,
		eff_name = equip_effect_to_low_level,
		lv = 2,
		value = 60,
		need_broadcast = 0,
		type = 1,
		attribute = 34
};

get(4135) ->
	#equip_speci_effect_tpl{
		no = 4135,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 2,
		value = {201,54},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4136) ->
	#equip_speci_effect_tpl{
		no = 4136,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 2,
		value = {202,54},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4137) ->
	#equip_speci_effect_tpl{
		no = 4137,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 2,
		value = {203,54},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4138) ->
	#equip_speci_effect_tpl{
		no = 4138,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 2,
		value = {204,54},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4139) ->
	#equip_speci_effect_tpl{
		no = 4139,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 2,
		value = {205,54},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4140) ->
	#equip_speci_effect_tpl{
		no = 4140,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 2,
		value = {301,54},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4141) ->
	#equip_speci_effect_tpl{
		no = 4141,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 2,
		value = {302,54},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4142) ->
	#equip_speci_effect_tpl{
		no = 4142,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 2,
		value = {303,54},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4143) ->
	#equip_speci_effect_tpl{
		no = 4143,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 2,
		value = {304,54},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4144) ->
	#equip_speci_effect_tpl{
		no = 4144,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 2,
		value = {305,54},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4145) ->
	#equip_speci_effect_tpl{
		no = 4145,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 2,
		value = {401,54},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4146) ->
	#equip_speci_effect_tpl{
		no = 4146,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 2,
		value = {402,54},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4147) ->
	#equip_speci_effect_tpl{
		no = 4147,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 2,
		value = {403,54},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4148) ->
	#equip_speci_effect_tpl{
		no = 4148,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 2,
		value = {404,54},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4149) ->
	#equip_speci_effect_tpl{
		no = 4149,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 2,
		value = {405,54},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4150) ->
	#equip_speci_effect_tpl{
		no = 4150,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 2,
		value = {501,54},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4151) ->
	#equip_speci_effect_tpl{
		no = 4151,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 2,
		value = {502,54},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4152) ->
	#equip_speci_effect_tpl{
		no = 4152,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 2,
		value = {503,54},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4153) ->
	#equip_speci_effect_tpl{
		no = 4153,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 2,
		value = {504,54},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4154) ->
	#equip_speci_effect_tpl{
		no = 4154,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 2,
		value = {505,54},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4201) ->
	#equip_speci_effect_tpl{
		no = 4201,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 3,
		value = 4201,
		need_broadcast = 0,
		type = 1,
		attribute = 1
};

get(4202) ->
	#equip_speci_effect_tpl{
		no = 4202,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 3,
		value = 4202,
		need_broadcast = 0,
		type = 1,
		attribute = 2
};

get(4203) ->
	#equip_speci_effect_tpl{
		no = 4203,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 3,
		value = 4203,
		need_broadcast = 0,
		type = 1,
		attribute = 3
};

get(4204) ->
	#equip_speci_effect_tpl{
		no = 4204,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 3,
		value = 4204,
		need_broadcast = 0,
		type = 1,
		attribute = 4
};

get(4205) ->
	#equip_speci_effect_tpl{
		no = 4205,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 3,
		value = 4205,
		need_broadcast = 0,
		type = 1,
		attribute = 5
};

get(4206) ->
	#equip_speci_effect_tpl{
		no = 4206,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 3,
		value = 4206,
		need_broadcast = 0,
		type = 1,
		attribute = 6
};

get(4207) ->
	#equip_speci_effect_tpl{
		no = 4207,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 3,
		value = 4208,
		need_broadcast = 0,
		type = 1,
		attribute = 7
};

get(4208) ->
	#equip_speci_effect_tpl{
		no = 4208,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 3,
		value = 4209,
		need_broadcast = 0,
		type = 1,
		attribute = 8
};

get(4209) ->
	#equip_speci_effect_tpl{
		no = 4209,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 3,
		value = 4211,
		need_broadcast = 0,
		type = 1,
		attribute = 9
};

get(4210) ->
	#equip_speci_effect_tpl{
		no = 4210,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 3,
		value = 4212,
		need_broadcast = 0,
		type = 1,
		attribute = 10
};

get(4211) ->
	#equip_speci_effect_tpl{
		no = 4211,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 3,
		value = 4213,
		need_broadcast = 0,
		type = 1,
		attribute = 11
};

get(4212) ->
	#equip_speci_effect_tpl{
		no = 4212,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 3,
		value = 4214,
		need_broadcast = 0,
		type = 1,
		attribute = 12
};

get(4213) ->
	#equip_speci_effect_tpl{
		no = 4213,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 3,
		value = 4215,
		need_broadcast = 0,
		type = 1,
		attribute = 13
};

get(4214) ->
	#equip_speci_effect_tpl{
		no = 4214,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 3,
		value = 4216,
		need_broadcast = 0,
		type = 1,
		attribute = 14
};

get(4215) ->
	#equip_speci_effect_tpl{
		no = 4215,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 3,
		value = 4217,
		need_broadcast = 0,
		type = 1,
		attribute = 15
};

get(4216) ->
	#equip_speci_effect_tpl{
		no = 4216,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 3,
		value = 4218,
		need_broadcast = 0,
		type = 1,
		attribute = 16
};

get(4217) ->
	#equip_speci_effect_tpl{
		no = 4217,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 3,
		value = 4219,
		need_broadcast = 0,
		type = 1,
		attribute = 17
};

get(4218) ->
	#equip_speci_effect_tpl{
		no = 4218,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 3,
		value = 4220,
		need_broadcast = 0,
		type = 1,
		attribute = 18
};

get(4219) ->
	#equip_speci_effect_tpl{
		no = 4219,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 3,
		value = 4221,
		need_broadcast = 0,
		type = 1,
		attribute = 19
};

get(4220) ->
	#equip_speci_effect_tpl{
		no = 4220,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 3,
		value = 4222,
		need_broadcast = 0,
		type = 1,
		attribute = 20
};

get(4221) ->
	#equip_speci_effect_tpl{
		no = 4221,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 3,
		value = 4223,
		need_broadcast = 0,
		type = 1,
		attribute = 21
};

get(4222) ->
	#equip_speci_effect_tpl{
		no = 4222,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 3,
		value = 4224,
		need_broadcast = 0,
		type = 1,
		attribute = 22
};

get(4223) ->
	#equip_speci_effect_tpl{
		no = 4223,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 3,
		value = 4225,
		need_broadcast = 0,
		type = 1,
		attribute = 23
};

get(4224) ->
	#equip_speci_effect_tpl{
		no = 4224,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 3,
		value = 4226,
		need_broadcast = 0,
		type = 1,
		attribute = 24
};

get(4225) ->
	#equip_speci_effect_tpl{
		no = 4225,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 3,
		value = 4227,
		need_broadcast = 0,
		type = 1,
		attribute = 25
};

get(4226) ->
	#equip_speci_effect_tpl{
		no = 4226,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 3,
		value = 4228,
		need_broadcast = 0,
		type = 1,
		attribute = 26
};

get(4227) ->
	#equip_speci_effect_tpl{
		no = 4227,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 3,
		value = 4229,
		need_broadcast = 0,
		type = 1,
		attribute = 27
};

get(4228) ->
	#equip_speci_effect_tpl{
		no = 4228,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 3,
		value = 4230,
		need_broadcast = 0,
		type = 1,
		attribute = 28
};

get(4229) ->
	#equip_speci_effect_tpl{
		no = 4229,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 3,
		value = 4231,
		need_broadcast = 0,
		type = 1,
		attribute = 29
};

get(4230) ->
	#equip_speci_effect_tpl{
		no = 4230,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 3,
		value = 4232,
		need_broadcast = 0,
		type = 1,
		attribute = 30
};

get(4231) ->
	#equip_speci_effect_tpl{
		no = 4231,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 3,
		value = 4233,
		need_broadcast = 0,
		type = 1,
		attribute = 31
};

get(4232) ->
	#equip_speci_effect_tpl{
		no = 4232,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 3,
		value = 4234,
		need_broadcast = 0,
		type = 1,
		attribute = 32
};

get(4233) ->
	#equip_speci_effect_tpl{
		no = 4233,
		rarity_no = 4,
		eff_name = equip_effect_add_skill,
		lv = 3,
		value = 4235,
		need_broadcast = 0,
		type = 1,
		attribute = 33
};

get(4234) ->
	#equip_speci_effect_tpl{
		no = 4234,
		rarity_no = 4,
		eff_name = equip_effect_to_low_level,
		lv = 3,
		value = 80,
		need_broadcast = 0,
		type = 1,
		attribute = 34
};

get(4235) ->
	#equip_speci_effect_tpl{
		no = 4235,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 3,
		value = {201,74},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4236) ->
	#equip_speci_effect_tpl{
		no = 4236,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 3,
		value = {202,74},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4237) ->
	#equip_speci_effect_tpl{
		no = 4237,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 3,
		value = {203,74},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4238) ->
	#equip_speci_effect_tpl{
		no = 4238,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 3,
		value = {204,74},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4239) ->
	#equip_speci_effect_tpl{
		no = 4239,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 3,
		value = {205,74},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4240) ->
	#equip_speci_effect_tpl{
		no = 4240,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 3,
		value = {301,74},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4241) ->
	#equip_speci_effect_tpl{
		no = 4241,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 3,
		value = {302,74},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4242) ->
	#equip_speci_effect_tpl{
		no = 4242,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 3,
		value = {303,74},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4243) ->
	#equip_speci_effect_tpl{
		no = 4243,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 3,
		value = {304,74},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4244) ->
	#equip_speci_effect_tpl{
		no = 4244,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 3,
		value = {305,74},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4245) ->
	#equip_speci_effect_tpl{
		no = 4245,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 3,
		value = {401,74},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4246) ->
	#equip_speci_effect_tpl{
		no = 4246,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 3,
		value = {402,74},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4247) ->
	#equip_speci_effect_tpl{
		no = 4247,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 3,
		value = {403,74},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4248) ->
	#equip_speci_effect_tpl{
		no = 4248,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 3,
		value = {404,74},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4249) ->
	#equip_speci_effect_tpl{
		no = 4249,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 3,
		value = {405,74},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4250) ->
	#equip_speci_effect_tpl{
		no = 4250,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 3,
		value = {501,74},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4251) ->
	#equip_speci_effect_tpl{
		no = 4251,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 3,
		value = {502,74},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4252) ->
	#equip_speci_effect_tpl{
		no = 4252,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 3,
		value = {503,74},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4253) ->
	#equip_speci_effect_tpl{
		no = 4253,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 3,
		value = {504,74},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4254) ->
	#equip_speci_effect_tpl{
		no = 4254,
		rarity_no = 4,
		eff_name = equip_effect_add_skill_lv,
		lv = 3,
		value = {505,74},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4301) ->
	#equip_speci_effect_tpl{
		no = 4301,
		rarity_no = 3,
		eff_name = equip_effect_add_skill,
		lv = 4,
		value = 4301,
		need_broadcast = 0,
		type = 1,
		attribute = 1
};

get(4302) ->
	#equip_speci_effect_tpl{
		no = 4302,
		rarity_no = 3,
		eff_name = equip_effect_add_skill,
		lv = 4,
		value = 4302,
		need_broadcast = 0,
		type = 1,
		attribute = 2
};

get(4303) ->
	#equip_speci_effect_tpl{
		no = 4303,
		rarity_no = 3,
		eff_name = equip_effect_add_skill,
		lv = 4,
		value = 4303,
		need_broadcast = 0,
		type = 1,
		attribute = 3
};

get(4304) ->
	#equip_speci_effect_tpl{
		no = 4304,
		rarity_no = 3,
		eff_name = equip_effect_add_skill,
		lv = 4,
		value = 4304,
		need_broadcast = 0,
		type = 1,
		attribute = 4
};

get(4305) ->
	#equip_speci_effect_tpl{
		no = 4305,
		rarity_no = 3,
		eff_name = equip_effect_add_skill,
		lv = 4,
		value = 4305,
		need_broadcast = 0,
		type = 1,
		attribute = 5
};

get(4306) ->
	#equip_speci_effect_tpl{
		no = 4306,
		rarity_no = 3,
		eff_name = equip_effect_add_skill,
		lv = 4,
		value = 4306,
		need_broadcast = 0,
		type = 1,
		attribute = 6
};

get(4307) ->
	#equip_speci_effect_tpl{
		no = 4307,
		rarity_no = 3,
		eff_name = equip_effect_add_skill,
		lv = 4,
		value = 4308,
		need_broadcast = 0,
		type = 1,
		attribute = 7
};

get(4308) ->
	#equip_speci_effect_tpl{
		no = 4308,
		rarity_no = 3,
		eff_name = equip_effect_add_skill,
		lv = 4,
		value = 4309,
		need_broadcast = 0,
		type = 1,
		attribute = 8
};

get(4309) ->
	#equip_speci_effect_tpl{
		no = 4309,
		rarity_no = 3,
		eff_name = equip_effect_add_skill,
		lv = 4,
		value = 4311,
		need_broadcast = 0,
		type = 1,
		attribute = 9
};

get(4310) ->
	#equip_speci_effect_tpl{
		no = 4310,
		rarity_no = 3,
		eff_name = equip_effect_add_skill,
		lv = 4,
		value = 4312,
		need_broadcast = 0,
		type = 1,
		attribute = 10
};

get(4311) ->
	#equip_speci_effect_tpl{
		no = 4311,
		rarity_no = 3,
		eff_name = equip_effect_add_skill,
		lv = 4,
		value = 4313,
		need_broadcast = 0,
		type = 1,
		attribute = 11
};

get(4312) ->
	#equip_speci_effect_tpl{
		no = 4312,
		rarity_no = 3,
		eff_name = equip_effect_add_skill,
		lv = 4,
		value = 4314,
		need_broadcast = 0,
		type = 1,
		attribute = 12
};

get(4313) ->
	#equip_speci_effect_tpl{
		no = 4313,
		rarity_no = 3,
		eff_name = equip_effect_add_skill,
		lv = 4,
		value = 4315,
		need_broadcast = 0,
		type = 1,
		attribute = 13
};

get(4314) ->
	#equip_speci_effect_tpl{
		no = 4314,
		rarity_no = 3,
		eff_name = equip_effect_add_skill,
		lv = 4,
		value = 4316,
		need_broadcast = 0,
		type = 1,
		attribute = 14
};

get(4315) ->
	#equip_speci_effect_tpl{
		no = 4315,
		rarity_no = 3,
		eff_name = equip_effect_add_skill,
		lv = 4,
		value = 4317,
		need_broadcast = 0,
		type = 1,
		attribute = 15
};

get(4316) ->
	#equip_speci_effect_tpl{
		no = 4316,
		rarity_no = 3,
		eff_name = equip_effect_add_skill,
		lv = 4,
		value = 4318,
		need_broadcast = 0,
		type = 1,
		attribute = 16
};

get(4317) ->
	#equip_speci_effect_tpl{
		no = 4317,
		rarity_no = 3,
		eff_name = equip_effect_add_skill,
		lv = 4,
		value = 4319,
		need_broadcast = 0,
		type = 1,
		attribute = 17
};

get(4318) ->
	#equip_speci_effect_tpl{
		no = 4318,
		rarity_no = 3,
		eff_name = equip_effect_add_skill,
		lv = 4,
		value = 4320,
		need_broadcast = 0,
		type = 1,
		attribute = 18
};

get(4319) ->
	#equip_speci_effect_tpl{
		no = 4319,
		rarity_no = 3,
		eff_name = equip_effect_add_skill,
		lv = 4,
		value = 4321,
		need_broadcast = 0,
		type = 1,
		attribute = 19
};

get(4320) ->
	#equip_speci_effect_tpl{
		no = 4320,
		rarity_no = 3,
		eff_name = equip_effect_add_skill,
		lv = 4,
		value = 4322,
		need_broadcast = 0,
		type = 1,
		attribute = 20
};

get(4321) ->
	#equip_speci_effect_tpl{
		no = 4321,
		rarity_no = 3,
		eff_name = equip_effect_add_skill,
		lv = 4,
		value = 4323,
		need_broadcast = 0,
		type = 1,
		attribute = 21
};

get(4322) ->
	#equip_speci_effect_tpl{
		no = 4322,
		rarity_no = 3,
		eff_name = equip_effect_add_skill,
		lv = 4,
		value = 4324,
		need_broadcast = 0,
		type = 1,
		attribute = 22
};

get(4323) ->
	#equip_speci_effect_tpl{
		no = 4323,
		rarity_no = 3,
		eff_name = equip_effect_add_skill,
		lv = 4,
		value = 4325,
		need_broadcast = 0,
		type = 1,
		attribute = 23
};

get(4324) ->
	#equip_speci_effect_tpl{
		no = 4324,
		rarity_no = 3,
		eff_name = equip_effect_add_skill,
		lv = 4,
		value = 4326,
		need_broadcast = 0,
		type = 1,
		attribute = 24
};

get(4325) ->
	#equip_speci_effect_tpl{
		no = 4325,
		rarity_no = 3,
		eff_name = equip_effect_add_skill,
		lv = 4,
		value = 4327,
		need_broadcast = 0,
		type = 1,
		attribute = 25
};

get(4326) ->
	#equip_speci_effect_tpl{
		no = 4326,
		rarity_no = 3,
		eff_name = equip_effect_add_skill,
		lv = 4,
		value = 4328,
		need_broadcast = 0,
		type = 1,
		attribute = 26
};

get(4327) ->
	#equip_speci_effect_tpl{
		no = 4327,
		rarity_no = 3,
		eff_name = equip_effect_add_skill,
		lv = 4,
		value = 4329,
		need_broadcast = 0,
		type = 1,
		attribute = 27
};

get(4328) ->
	#equip_speci_effect_tpl{
		no = 4328,
		rarity_no = 3,
		eff_name = equip_effect_add_skill,
		lv = 4,
		value = 4330,
		need_broadcast = 0,
		type = 1,
		attribute = 28
};

get(4329) ->
	#equip_speci_effect_tpl{
		no = 4329,
		rarity_no = 3,
		eff_name = equip_effect_add_skill,
		lv = 4,
		value = 4331,
		need_broadcast = 0,
		type = 1,
		attribute = 29
};

get(4330) ->
	#equip_speci_effect_tpl{
		no = 4330,
		rarity_no = 3,
		eff_name = equip_effect_add_skill,
		lv = 4,
		value = 4332,
		need_broadcast = 0,
		type = 1,
		attribute = 30
};

get(4331) ->
	#equip_speci_effect_tpl{
		no = 4331,
		rarity_no = 3,
		eff_name = equip_effect_add_skill,
		lv = 4,
		value = 4333,
		need_broadcast = 0,
		type = 1,
		attribute = 31
};

get(4332) ->
	#equip_speci_effect_tpl{
		no = 4332,
		rarity_no = 3,
		eff_name = equip_effect_add_skill,
		lv = 4,
		value = 4334,
		need_broadcast = 0,
		type = 1,
		attribute = 32
};

get(4333) ->
	#equip_speci_effect_tpl{
		no = 4333,
		rarity_no = 3,
		eff_name = equip_effect_add_skill,
		lv = 4,
		value = 4335,
		need_broadcast = 0,
		type = 1,
		attribute = 33
};

get(4334) ->
	#equip_speci_effect_tpl{
		no = 4334,
		rarity_no = 3,
		eff_name = equip_effect_to_low_level,
		lv = 4,
		value = 100,
		need_broadcast = 0,
		type = 1,
		attribute = 34
};

get(4335) ->
	#equip_speci_effect_tpl{
		no = 4335,
		rarity_no = 3,
		eff_name = equip_effect_add_skill_lv,
		lv = 4,
		value = {201,98},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4336) ->
	#equip_speci_effect_tpl{
		no = 4336,
		rarity_no = 3,
		eff_name = equip_effect_add_skill_lv,
		lv = 4,
		value = {202,98},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4337) ->
	#equip_speci_effect_tpl{
		no = 4337,
		rarity_no = 3,
		eff_name = equip_effect_add_skill_lv,
		lv = 4,
		value = {203,98},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4338) ->
	#equip_speci_effect_tpl{
		no = 4338,
		rarity_no = 3,
		eff_name = equip_effect_add_skill_lv,
		lv = 4,
		value = {204,98},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4339) ->
	#equip_speci_effect_tpl{
		no = 4339,
		rarity_no = 3,
		eff_name = equip_effect_add_skill_lv,
		lv = 4,
		value = {205,98},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4340) ->
	#equip_speci_effect_tpl{
		no = 4340,
		rarity_no = 3,
		eff_name = equip_effect_add_skill_lv,
		lv = 4,
		value = {301,98},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4341) ->
	#equip_speci_effect_tpl{
		no = 4341,
		rarity_no = 3,
		eff_name = equip_effect_add_skill_lv,
		lv = 4,
		value = {302,98},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4342) ->
	#equip_speci_effect_tpl{
		no = 4342,
		rarity_no = 3,
		eff_name = equip_effect_add_skill_lv,
		lv = 4,
		value = {303,98},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4343) ->
	#equip_speci_effect_tpl{
		no = 4343,
		rarity_no = 3,
		eff_name = equip_effect_add_skill_lv,
		lv = 4,
		value = {304,98},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4344) ->
	#equip_speci_effect_tpl{
		no = 4344,
		rarity_no = 3,
		eff_name = equip_effect_add_skill_lv,
		lv = 4,
		value = {305,98},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4345) ->
	#equip_speci_effect_tpl{
		no = 4345,
		rarity_no = 3,
		eff_name = equip_effect_add_skill_lv,
		lv = 4,
		value = {401,98},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4346) ->
	#equip_speci_effect_tpl{
		no = 4346,
		rarity_no = 3,
		eff_name = equip_effect_add_skill_lv,
		lv = 4,
		value = {402,98},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4347) ->
	#equip_speci_effect_tpl{
		no = 4347,
		rarity_no = 3,
		eff_name = equip_effect_add_skill_lv,
		lv = 4,
		value = {403,98},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4348) ->
	#equip_speci_effect_tpl{
		no = 4348,
		rarity_no = 3,
		eff_name = equip_effect_add_skill_lv,
		lv = 4,
		value = {404,98},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4349) ->
	#equip_speci_effect_tpl{
		no = 4349,
		rarity_no = 3,
		eff_name = equip_effect_add_skill_lv,
		lv = 4,
		value = {405,98},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4350) ->
	#equip_speci_effect_tpl{
		no = 4350,
		rarity_no = 3,
		eff_name = equip_effect_add_skill_lv,
		lv = 4,
		value = {501,98},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4351) ->
	#equip_speci_effect_tpl{
		no = 4351,
		rarity_no = 3,
		eff_name = equip_effect_add_skill_lv,
		lv = 4,
		value = {502,98},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4352) ->
	#equip_speci_effect_tpl{
		no = 4352,
		rarity_no = 3,
		eff_name = equip_effect_add_skill_lv,
		lv = 4,
		value = {503,98},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4353) ->
	#equip_speci_effect_tpl{
		no = 4353,
		rarity_no = 3,
		eff_name = equip_effect_add_skill_lv,
		lv = 4,
		value = {504,98},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4354) ->
	#equip_speci_effect_tpl{
		no = 4354,
		rarity_no = 3,
		eff_name = equip_effect_add_skill_lv,
		lv = 4,
		value = {505,98},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4401) ->
	#equip_speci_effect_tpl{
		no = 4401,
		rarity_no = 2,
		eff_name = equip_effect_add_skill,
		lv = 5,
		value = 4401,
		need_broadcast = 0,
		type = 1,
		attribute = 1
};

get(4402) ->
	#equip_speci_effect_tpl{
		no = 4402,
		rarity_no = 2,
		eff_name = equip_effect_add_skill,
		lv = 5,
		value = 4402,
		need_broadcast = 0,
		type = 1,
		attribute = 2
};

get(4403) ->
	#equip_speci_effect_tpl{
		no = 4403,
		rarity_no = 2,
		eff_name = equip_effect_add_skill,
		lv = 5,
		value = 4403,
		need_broadcast = 0,
		type = 1,
		attribute = 3
};

get(4404) ->
	#equip_speci_effect_tpl{
		no = 4404,
		rarity_no = 2,
		eff_name = equip_effect_add_skill,
		lv = 5,
		value = 4404,
		need_broadcast = 0,
		type = 1,
		attribute = 4
};

get(4405) ->
	#equip_speci_effect_tpl{
		no = 4405,
		rarity_no = 2,
		eff_name = equip_effect_add_skill,
		lv = 5,
		value = 4405,
		need_broadcast = 0,
		type = 1,
		attribute = 5
};

get(4406) ->
	#equip_speci_effect_tpl{
		no = 4406,
		rarity_no = 2,
		eff_name = equip_effect_add_skill,
		lv = 5,
		value = 4406,
		need_broadcast = 0,
		type = 1,
		attribute = 6
};

get(4407) ->
	#equip_speci_effect_tpl{
		no = 4407,
		rarity_no = 2,
		eff_name = equip_effect_add_skill,
		lv = 5,
		value = 4408,
		need_broadcast = 0,
		type = 1,
		attribute = 7
};

get(4408) ->
	#equip_speci_effect_tpl{
		no = 4408,
		rarity_no = 2,
		eff_name = equip_effect_add_skill,
		lv = 5,
		value = 4409,
		need_broadcast = 0,
		type = 1,
		attribute = 8
};

get(4409) ->
	#equip_speci_effect_tpl{
		no = 4409,
		rarity_no = 2,
		eff_name = equip_effect_add_skill,
		lv = 5,
		value = 4411,
		need_broadcast = 0,
		type = 1,
		attribute = 9
};

get(4410) ->
	#equip_speci_effect_tpl{
		no = 4410,
		rarity_no = 2,
		eff_name = equip_effect_add_skill,
		lv = 5,
		value = 4412,
		need_broadcast = 0,
		type = 1,
		attribute = 10
};

get(4411) ->
	#equip_speci_effect_tpl{
		no = 4411,
		rarity_no = 2,
		eff_name = equip_effect_add_skill,
		lv = 5,
		value = 4413,
		need_broadcast = 0,
		type = 1,
		attribute = 11
};

get(4412) ->
	#equip_speci_effect_tpl{
		no = 4412,
		rarity_no = 2,
		eff_name = equip_effect_add_skill,
		lv = 5,
		value = 4414,
		need_broadcast = 0,
		type = 1,
		attribute = 12
};

get(4413) ->
	#equip_speci_effect_tpl{
		no = 4413,
		rarity_no = 2,
		eff_name = equip_effect_add_skill,
		lv = 5,
		value = 4415,
		need_broadcast = 0,
		type = 1,
		attribute = 13
};

get(4414) ->
	#equip_speci_effect_tpl{
		no = 4414,
		rarity_no = 2,
		eff_name = equip_effect_add_skill,
		lv = 5,
		value = 4416,
		need_broadcast = 0,
		type = 1,
		attribute = 14
};

get(4415) ->
	#equip_speci_effect_tpl{
		no = 4415,
		rarity_no = 2,
		eff_name = equip_effect_add_skill,
		lv = 5,
		value = 4417,
		need_broadcast = 0,
		type = 1,
		attribute = 15
};

get(4416) ->
	#equip_speci_effect_tpl{
		no = 4416,
		rarity_no = 2,
		eff_name = equip_effect_add_skill,
		lv = 5,
		value = 4418,
		need_broadcast = 0,
		type = 1,
		attribute = 16
};

get(4417) ->
	#equip_speci_effect_tpl{
		no = 4417,
		rarity_no = 2,
		eff_name = equip_effect_add_skill,
		lv = 5,
		value = 4419,
		need_broadcast = 0,
		type = 1,
		attribute = 17
};

get(4418) ->
	#equip_speci_effect_tpl{
		no = 4418,
		rarity_no = 2,
		eff_name = equip_effect_add_skill,
		lv = 5,
		value = 4420,
		need_broadcast = 0,
		type = 1,
		attribute = 18
};

get(4419) ->
	#equip_speci_effect_tpl{
		no = 4419,
		rarity_no = 2,
		eff_name = equip_effect_add_skill,
		lv = 5,
		value = 4421,
		need_broadcast = 0,
		type = 1,
		attribute = 19
};

get(4420) ->
	#equip_speci_effect_tpl{
		no = 4420,
		rarity_no = 2,
		eff_name = equip_effect_add_skill,
		lv = 5,
		value = 4422,
		need_broadcast = 0,
		type = 1,
		attribute = 20
};

get(4421) ->
	#equip_speci_effect_tpl{
		no = 4421,
		rarity_no = 2,
		eff_name = equip_effect_add_skill,
		lv = 5,
		value = 4423,
		need_broadcast = 0,
		type = 1,
		attribute = 21
};

get(4422) ->
	#equip_speci_effect_tpl{
		no = 4422,
		rarity_no = 2,
		eff_name = equip_effect_add_skill,
		lv = 5,
		value = 4424,
		need_broadcast = 0,
		type = 1,
		attribute = 22
};

get(4423) ->
	#equip_speci_effect_tpl{
		no = 4423,
		rarity_no = 2,
		eff_name = equip_effect_add_skill,
		lv = 5,
		value = 4425,
		need_broadcast = 0,
		type = 1,
		attribute = 23
};

get(4424) ->
	#equip_speci_effect_tpl{
		no = 4424,
		rarity_no = 2,
		eff_name = equip_effect_add_skill,
		lv = 5,
		value = 4426,
		need_broadcast = 0,
		type = 1,
		attribute = 24
};

get(4425) ->
	#equip_speci_effect_tpl{
		no = 4425,
		rarity_no = 2,
		eff_name = equip_effect_add_skill,
		lv = 5,
		value = 4427,
		need_broadcast = 0,
		type = 1,
		attribute = 25
};

get(4426) ->
	#equip_speci_effect_tpl{
		no = 4426,
		rarity_no = 2,
		eff_name = equip_effect_add_skill,
		lv = 5,
		value = 4428,
		need_broadcast = 0,
		type = 1,
		attribute = 26
};

get(4427) ->
	#equip_speci_effect_tpl{
		no = 4427,
		rarity_no = 2,
		eff_name = equip_effect_add_skill,
		lv = 5,
		value = 4429,
		need_broadcast = 0,
		type = 1,
		attribute = 27
};

get(4428) ->
	#equip_speci_effect_tpl{
		no = 4428,
		rarity_no = 2,
		eff_name = equip_effect_add_skill,
		lv = 5,
		value = 4430,
		need_broadcast = 0,
		type = 1,
		attribute = 28
};

get(4429) ->
	#equip_speci_effect_tpl{
		no = 4429,
		rarity_no = 2,
		eff_name = equip_effect_add_skill,
		lv = 5,
		value = 4431,
		need_broadcast = 0,
		type = 1,
		attribute = 29
};

get(4430) ->
	#equip_speci_effect_tpl{
		no = 4430,
		rarity_no = 2,
		eff_name = equip_effect_add_skill,
		lv = 5,
		value = 4432,
		need_broadcast = 0,
		type = 1,
		attribute = 30
};

get(4431) ->
	#equip_speci_effect_tpl{
		no = 4431,
		rarity_no = 2,
		eff_name = equip_effect_add_skill,
		lv = 5,
		value = 4433,
		need_broadcast = 0,
		type = 1,
		attribute = 31
};

get(4432) ->
	#equip_speci_effect_tpl{
		no = 4432,
		rarity_no = 2,
		eff_name = equip_effect_add_skill,
		lv = 5,
		value = 4434,
		need_broadcast = 0,
		type = 1,
		attribute = 32
};

get(4433) ->
	#equip_speci_effect_tpl{
		no = 4433,
		rarity_no = 2,
		eff_name = equip_effect_add_skill,
		lv = 5,
		value = 4435,
		need_broadcast = 0,
		type = 1,
		attribute = 33
};

get(4434) ->
	#equip_speci_effect_tpl{
		no = 4434,
		rarity_no = 2,
		eff_name = equip_effect_to_low_level,
		lv = 5,
		value = 130,
		need_broadcast = 0,
		type = 1,
		attribute = 34
};

get(4435) ->
	#equip_speci_effect_tpl{
		no = 4435,
		rarity_no = 2,
		eff_name = equip_effect_add_skill_lv,
		lv = 5,
		value = {201,134},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4436) ->
	#equip_speci_effect_tpl{
		no = 4436,
		rarity_no = 2,
		eff_name = equip_effect_add_skill_lv,
		lv = 5,
		value = {202,134},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4437) ->
	#equip_speci_effect_tpl{
		no = 4437,
		rarity_no = 2,
		eff_name = equip_effect_add_skill_lv,
		lv = 5,
		value = {203,134},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4438) ->
	#equip_speci_effect_tpl{
		no = 4438,
		rarity_no = 2,
		eff_name = equip_effect_add_skill_lv,
		lv = 5,
		value = {204,134},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4439) ->
	#equip_speci_effect_tpl{
		no = 4439,
		rarity_no = 2,
		eff_name = equip_effect_add_skill_lv,
		lv = 5,
		value = {205,134},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4440) ->
	#equip_speci_effect_tpl{
		no = 4440,
		rarity_no = 2,
		eff_name = equip_effect_add_skill_lv,
		lv = 5,
		value = {301,134},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4441) ->
	#equip_speci_effect_tpl{
		no = 4441,
		rarity_no = 2,
		eff_name = equip_effect_add_skill_lv,
		lv = 5,
		value = {302,134},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4442) ->
	#equip_speci_effect_tpl{
		no = 4442,
		rarity_no = 2,
		eff_name = equip_effect_add_skill_lv,
		lv = 5,
		value = {303,134},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4443) ->
	#equip_speci_effect_tpl{
		no = 4443,
		rarity_no = 2,
		eff_name = equip_effect_add_skill_lv,
		lv = 5,
		value = {304,134},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4444) ->
	#equip_speci_effect_tpl{
		no = 4444,
		rarity_no = 2,
		eff_name = equip_effect_add_skill_lv,
		lv = 5,
		value = {305,134},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4445) ->
	#equip_speci_effect_tpl{
		no = 4445,
		rarity_no = 2,
		eff_name = equip_effect_add_skill_lv,
		lv = 5,
		value = {401,134},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4446) ->
	#equip_speci_effect_tpl{
		no = 4446,
		rarity_no = 2,
		eff_name = equip_effect_add_skill_lv,
		lv = 5,
		value = {402,134},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4447) ->
	#equip_speci_effect_tpl{
		no = 4447,
		rarity_no = 2,
		eff_name = equip_effect_add_skill_lv,
		lv = 5,
		value = {403,134},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4448) ->
	#equip_speci_effect_tpl{
		no = 4448,
		rarity_no = 2,
		eff_name = equip_effect_add_skill_lv,
		lv = 5,
		value = {404,134},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4449) ->
	#equip_speci_effect_tpl{
		no = 4449,
		rarity_no = 2,
		eff_name = equip_effect_add_skill_lv,
		lv = 5,
		value = {405,134},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4450) ->
	#equip_speci_effect_tpl{
		no = 4450,
		rarity_no = 2,
		eff_name = equip_effect_add_skill_lv,
		lv = 5,
		value = {501,134},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4451) ->
	#equip_speci_effect_tpl{
		no = 4451,
		rarity_no = 2,
		eff_name = equip_effect_add_skill_lv,
		lv = 5,
		value = {502,134},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4452) ->
	#equip_speci_effect_tpl{
		no = 4452,
		rarity_no = 2,
		eff_name = equip_effect_add_skill_lv,
		lv = 5,
		value = {503,134},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4453) ->
	#equip_speci_effect_tpl{
		no = 4453,
		rarity_no = 2,
		eff_name = equip_effect_add_skill_lv,
		lv = 5,
		value = {504,134},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4454) ->
	#equip_speci_effect_tpl{
		no = 4454,
		rarity_no = 2,
		eff_name = equip_effect_add_skill_lv,
		lv = 5,
		value = {505,134},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4501) ->
	#equip_speci_effect_tpl{
		no = 4501,
		rarity_no = 1,
		eff_name = equip_effect_add_skill,
		lv = 6,
		value = 4501,
		need_broadcast = 0,
		type = 1,
		attribute = 1
};

get(4502) ->
	#equip_speci_effect_tpl{
		no = 4502,
		rarity_no = 1,
		eff_name = equip_effect_add_skill,
		lv = 6,
		value = 4502,
		need_broadcast = 0,
		type = 1,
		attribute = 2
};

get(4503) ->
	#equip_speci_effect_tpl{
		no = 4503,
		rarity_no = 1,
		eff_name = equip_effect_add_skill,
		lv = 6,
		value = 4503,
		need_broadcast = 0,
		type = 1,
		attribute = 3
};

get(4504) ->
	#equip_speci_effect_tpl{
		no = 4504,
		rarity_no = 1,
		eff_name = equip_effect_add_skill,
		lv = 6,
		value = 4504,
		need_broadcast = 0,
		type = 1,
		attribute = 4
};

get(4505) ->
	#equip_speci_effect_tpl{
		no = 4505,
		rarity_no = 1,
		eff_name = equip_effect_add_skill,
		lv = 6,
		value = 4505,
		need_broadcast = 0,
		type = 1,
		attribute = 5
};

get(4506) ->
	#equip_speci_effect_tpl{
		no = 4506,
		rarity_no = 1,
		eff_name = equip_effect_add_skill,
		lv = 6,
		value = 4506,
		need_broadcast = 0,
		type = 1,
		attribute = 6
};

get(4507) ->
	#equip_speci_effect_tpl{
		no = 4507,
		rarity_no = 1,
		eff_name = equip_effect_add_skill,
		lv = 6,
		value = 4508,
		need_broadcast = 0,
		type = 1,
		attribute = 7
};

get(4508) ->
	#equip_speci_effect_tpl{
		no = 4508,
		rarity_no = 1,
		eff_name = equip_effect_add_skill,
		lv = 6,
		value = 4509,
		need_broadcast = 0,
		type = 1,
		attribute = 8
};

get(4509) ->
	#equip_speci_effect_tpl{
		no = 4509,
		rarity_no = 1,
		eff_name = equip_effect_add_skill,
		lv = 6,
		value = 4511,
		need_broadcast = 0,
		type = 1,
		attribute = 9
};

get(4510) ->
	#equip_speci_effect_tpl{
		no = 4510,
		rarity_no = 1,
		eff_name = equip_effect_add_skill,
		lv = 6,
		value = 4512,
		need_broadcast = 0,
		type = 1,
		attribute = 10
};

get(4511) ->
	#equip_speci_effect_tpl{
		no = 4511,
		rarity_no = 1,
		eff_name = equip_effect_add_skill,
		lv = 6,
		value = 4513,
		need_broadcast = 0,
		type = 1,
		attribute = 11
};

get(4512) ->
	#equip_speci_effect_tpl{
		no = 4512,
		rarity_no = 1,
		eff_name = equip_effect_add_skill,
		lv = 6,
		value = 4514,
		need_broadcast = 0,
		type = 1,
		attribute = 12
};

get(4513) ->
	#equip_speci_effect_tpl{
		no = 4513,
		rarity_no = 1,
		eff_name = equip_effect_add_skill,
		lv = 6,
		value = 4515,
		need_broadcast = 0,
		type = 1,
		attribute = 13
};

get(4514) ->
	#equip_speci_effect_tpl{
		no = 4514,
		rarity_no = 1,
		eff_name = equip_effect_add_skill,
		lv = 6,
		value = 4516,
		need_broadcast = 0,
		type = 1,
		attribute = 14
};

get(4515) ->
	#equip_speci_effect_tpl{
		no = 4515,
		rarity_no = 1,
		eff_name = equip_effect_add_skill,
		lv = 6,
		value = 4517,
		need_broadcast = 0,
		type = 1,
		attribute = 15
};

get(4516) ->
	#equip_speci_effect_tpl{
		no = 4516,
		rarity_no = 1,
		eff_name = equip_effect_add_skill,
		lv = 6,
		value = 4518,
		need_broadcast = 0,
		type = 1,
		attribute = 16
};

get(4517) ->
	#equip_speci_effect_tpl{
		no = 4517,
		rarity_no = 1,
		eff_name = equip_effect_add_skill,
		lv = 6,
		value = 4519,
		need_broadcast = 0,
		type = 1,
		attribute = 17
};

get(4518) ->
	#equip_speci_effect_tpl{
		no = 4518,
		rarity_no = 1,
		eff_name = equip_effect_add_skill,
		lv = 6,
		value = 4520,
		need_broadcast = 0,
		type = 1,
		attribute = 18
};

get(4519) ->
	#equip_speci_effect_tpl{
		no = 4519,
		rarity_no = 1,
		eff_name = equip_effect_add_skill,
		lv = 6,
		value = 4521,
		need_broadcast = 0,
		type = 1,
		attribute = 19
};

get(4520) ->
	#equip_speci_effect_tpl{
		no = 4520,
		rarity_no = 1,
		eff_name = equip_effect_add_skill,
		lv = 6,
		value = 4522,
		need_broadcast = 0,
		type = 1,
		attribute = 20
};

get(4521) ->
	#equip_speci_effect_tpl{
		no = 4521,
		rarity_no = 1,
		eff_name = equip_effect_add_skill,
		lv = 6,
		value = 4523,
		need_broadcast = 0,
		type = 1,
		attribute = 21
};

get(4522) ->
	#equip_speci_effect_tpl{
		no = 4522,
		rarity_no = 1,
		eff_name = equip_effect_add_skill,
		lv = 6,
		value = 4524,
		need_broadcast = 0,
		type = 1,
		attribute = 22
};

get(4523) ->
	#equip_speci_effect_tpl{
		no = 4523,
		rarity_no = 1,
		eff_name = equip_effect_add_skill,
		lv = 6,
		value = 4525,
		need_broadcast = 0,
		type = 1,
		attribute = 23
};

get(4524) ->
	#equip_speci_effect_tpl{
		no = 4524,
		rarity_no = 1,
		eff_name = equip_effect_add_skill,
		lv = 6,
		value = 4526,
		need_broadcast = 0,
		type = 1,
		attribute = 24
};

get(4525) ->
	#equip_speci_effect_tpl{
		no = 4525,
		rarity_no = 1,
		eff_name = equip_effect_add_skill,
		lv = 6,
		value = 4527,
		need_broadcast = 0,
		type = 1,
		attribute = 25
};

get(4526) ->
	#equip_speci_effect_tpl{
		no = 4526,
		rarity_no = 1,
		eff_name = equip_effect_add_skill,
		lv = 6,
		value = 4528,
		need_broadcast = 0,
		type = 1,
		attribute = 26
};

get(4527) ->
	#equip_speci_effect_tpl{
		no = 4527,
		rarity_no = 1,
		eff_name = equip_effect_add_skill,
		lv = 6,
		value = 4529,
		need_broadcast = 0,
		type = 1,
		attribute = 27
};

get(4528) ->
	#equip_speci_effect_tpl{
		no = 4528,
		rarity_no = 1,
		eff_name = equip_effect_add_skill,
		lv = 6,
		value = 4530,
		need_broadcast = 0,
		type = 1,
		attribute = 28
};

get(4529) ->
	#equip_speci_effect_tpl{
		no = 4529,
		rarity_no = 1,
		eff_name = equip_effect_add_skill,
		lv = 6,
		value = 4531,
		need_broadcast = 0,
		type = 1,
		attribute = 29
};

get(4530) ->
	#equip_speci_effect_tpl{
		no = 4530,
		rarity_no = 1,
		eff_name = equip_effect_add_skill,
		lv = 6,
		value = 4532,
		need_broadcast = 0,
		type = 1,
		attribute = 30
};

get(4531) ->
	#equip_speci_effect_tpl{
		no = 4531,
		rarity_no = 1,
		eff_name = equip_effect_add_skill,
		lv = 6,
		value = 4533,
		need_broadcast = 0,
		type = 1,
		attribute = 31
};

get(4532) ->
	#equip_speci_effect_tpl{
		no = 4532,
		rarity_no = 1,
		eff_name = equip_effect_add_skill,
		lv = 6,
		value = 4534,
		need_broadcast = 0,
		type = 1,
		attribute = 32
};

get(4533) ->
	#equip_speci_effect_tpl{
		no = 4533,
		rarity_no = 1,
		eff_name = equip_effect_add_skill,
		lv = 6,
		value = 4535,
		need_broadcast = 0,
		type = 1,
		attribute = 33
};

get(4534) ->
	#equip_speci_effect_tpl{
		no = 4534,
		rarity_no = 1,
		eff_name = equip_effect_to_low_level,
		lv = 6,
		value = 160,
		need_broadcast = 0,
		type = 1,
		attribute = 34
};

get(4535) ->
	#equip_speci_effect_tpl{
		no = 4535,
		rarity_no = 1,
		eff_name = equip_effect_add_skill_lv,
		lv = 6,
		value = {201,180},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4536) ->
	#equip_speci_effect_tpl{
		no = 4536,
		rarity_no = 1,
		eff_name = equip_effect_add_skill_lv,
		lv = 6,
		value = {202,180},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4537) ->
	#equip_speci_effect_tpl{
		no = 4537,
		rarity_no = 1,
		eff_name = equip_effect_add_skill_lv,
		lv = 6,
		value = {203,180},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4538) ->
	#equip_speci_effect_tpl{
		no = 4538,
		rarity_no = 1,
		eff_name = equip_effect_add_skill_lv,
		lv = 6,
		value = {204,180},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4539) ->
	#equip_speci_effect_tpl{
		no = 4539,
		rarity_no = 1,
		eff_name = equip_effect_add_skill_lv,
		lv = 6,
		value = {205,180},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4540) ->
	#equip_speci_effect_tpl{
		no = 4540,
		rarity_no = 1,
		eff_name = equip_effect_add_skill_lv,
		lv = 6,
		value = {301,180},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4541) ->
	#equip_speci_effect_tpl{
		no = 4541,
		rarity_no = 1,
		eff_name = equip_effect_add_skill_lv,
		lv = 6,
		value = {302,180},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4542) ->
	#equip_speci_effect_tpl{
		no = 4542,
		rarity_no = 1,
		eff_name = equip_effect_add_skill_lv,
		lv = 6,
		value = {303,180},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4543) ->
	#equip_speci_effect_tpl{
		no = 4543,
		rarity_no = 1,
		eff_name = equip_effect_add_skill_lv,
		lv = 6,
		value = {304,180},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4544) ->
	#equip_speci_effect_tpl{
		no = 4544,
		rarity_no = 1,
		eff_name = equip_effect_add_skill_lv,
		lv = 6,
		value = {305,180},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4545) ->
	#equip_speci_effect_tpl{
		no = 4545,
		rarity_no = 1,
		eff_name = equip_effect_add_skill_lv,
		lv = 6,
		value = {401,180},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4546) ->
	#equip_speci_effect_tpl{
		no = 4546,
		rarity_no = 1,
		eff_name = equip_effect_add_skill_lv,
		lv = 6,
		value = {402,180},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4547) ->
	#equip_speci_effect_tpl{
		no = 4547,
		rarity_no = 1,
		eff_name = equip_effect_add_skill_lv,
		lv = 6,
		value = {403,180},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4548) ->
	#equip_speci_effect_tpl{
		no = 4548,
		rarity_no = 1,
		eff_name = equip_effect_add_skill_lv,
		lv = 6,
		value = {404,180},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4549) ->
	#equip_speci_effect_tpl{
		no = 4549,
		rarity_no = 1,
		eff_name = equip_effect_add_skill_lv,
		lv = 6,
		value = {405,180},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4550) ->
	#equip_speci_effect_tpl{
		no = 4550,
		rarity_no = 1,
		eff_name = equip_effect_add_skill_lv,
		lv = 6,
		value = {501,180},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4551) ->
	#equip_speci_effect_tpl{
		no = 4551,
		rarity_no = 1,
		eff_name = equip_effect_add_skill_lv,
		lv = 6,
		value = {502,180},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4552) ->
	#equip_speci_effect_tpl{
		no = 4552,
		rarity_no = 1,
		eff_name = equip_effect_add_skill_lv,
		lv = 6,
		value = {503,180},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4553) ->
	#equip_speci_effect_tpl{
		no = 4553,
		rarity_no = 1,
		eff_name = equip_effect_add_skill_lv,
		lv = 6,
		value = {504,180},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(4554) ->
	#equip_speci_effect_tpl{
		no = 4554,
		rarity_no = 1,
		eff_name = equip_effect_add_skill_lv,
		lv = 6,
		value = {505,180},
		need_broadcast = 0,
		type = 1,
		attribute = 35
};

get(9000) ->
	#equip_speci_effect_tpl{
		no = 9000,
		rarity_no = 4,
		eff_name = equip_effect_to_low_level,
		lv = 4,
		value = 360,
		need_broadcast = 0,
		type = 1,
		attribute = 34
};

get(_No) ->
	      ?ASSERT(false, _No),
          null.

