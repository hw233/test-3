%%%------------------------------------
%%% @Module  : mod_offline_bo
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2013.12.30
%%% @Description: 离线bo（battle obj）的相关接口
%%%------------------------------------

-module(mod_offline_bo).
-export([
		is_player/1,
		is_partner/1,
		is_main_partner/1,

		get_id/1,
		get_name/1,
		get_race/1,
		get_faction/1,
		get_sex/1,
		get_lv/1,
		get_attrs/1,
		get_xinfa_brief_list/1,
		get_skill_list/1,
		get_initiative_skill_list/1,
		get_passive_skill_list/1,
		get_AI_list/1,
		get_partner_id_list/1,
		get_showing_equips/1,



		get_par_no/1,
		get_par_loyalty/1,
		get_par_quality/1,
		get_par_cultivate_lv/1,
		get_par_cultivate_layer/1,
		get_par_evolve_lv/1,
		get_par_nature/1,
		get_par_awake_illusion/1,
		is_par_fighting/1,
		can_par_goto_fight_once/1



    ]).

-include("common.hrl").
-include("offline_data.hrl").
-include("partner.hrl").
-include("skill.hrl").


is_player(OfflineBo) ->
	get_type(OfflineBo) == ?OBJ_PLAYER.


is_partner(OfflineBo) ->
	get_type(OfflineBo) == ?OBJ_PARTNER.


is_main_partner(OfflineBo) ->
	is_partner(OfflineBo)
	andalso (OfflineBo#offline_bo.par_property#par_prop.is_main_par).
	


get_type(OfflineBo) ->
	{_Id, BoType, _SysType} = OfflineBo#offline_bo.key,
	BoType.



get_id(OfflineBo) ->
	{Id, _BoType, _SysType} = OfflineBo#offline_bo.key,
	Id.

get_name(OfflineBo) ->
	OfflineBo#offline_bo.name.

get_race(OfflineBo) ->
	OfflineBo#offline_bo.race.

get_faction(OfflineBo) ->
	OfflineBo#offline_bo.faction.

get_sex(OfflineBo) ->
	OfflineBo#offline_bo.sex.

get_lv(OfflineBo) ->
	OfflineBo#offline_bo.lv.

get_attrs(OfflineBo) ->
	OfflineBo#offline_bo.attrs.




get_xinfa_brief_list(OfflineBo) ->
	OfflineBo#offline_bo.xinfa.


%% 获取技能列表（主动技 + 被动技）如果是玩家，法宝技能也添加在里面了
%% @return: [] | skl_brief结构体列表
get_skill_list(OfflineBo) ->
	case get_type(OfflineBo) of
		?OBJ_PLAYER ->
			XfBriefList = get_xinfa_brief_list(OfflineBo),
            lib_skill:derive_skill_list_from(XfBriefList) ++ OfflineBo#offline_bo.skills;
		_ ->
			OfflineBo#offline_bo.skills
	end.


%% 获取主动技列表
%% @return: [] | skl_brief结构体列表 
get_initiative_skill_list(OfflineBo) ->
	L = get_skill_list(OfflineBo),
	[X || X <- L, mod_skill:is_initiative(X#skl_brief.id)].


%% 获取被动技列表
%% @return: [] | skl_brief结构体列表 
get_passive_skill_list(OfflineBo) ->
	L = get_skill_list(OfflineBo),
	[X || X <- L, mod_skill:is_passive(X#skl_brief.id)].
	

	
get_AI_list(OfflineBo) ->
	case get_skill_list(OfflineBo) of
        [] ->
            [];
        SklBriefList ->
            lib_skill:build_AI_list_from(SklBriefList)
    end.


get_partner_id_list(OfflineBo) ->
	OfflineBo#offline_bo.partners.


get_showing_equips(OfflineBo) ->
	OfflineBo#offline_bo.showing_equips.


%% 离线宠物bo的编号
get_par_no(OfflineBo) ->
	?ASSERT(is_partner(OfflineBo)),
	OfflineBo#offline_bo.par_property#par_prop.no.


%% 离线宠物bo的忠诚度
get_par_loyalty(OfflineBo) ->
	?ASSERT(is_partner(OfflineBo)),
	OfflineBo#offline_bo.par_property#par_prop.loyalty.


%% 离线宠物bo的品质
get_par_quality(OfflineBo) ->
	?ASSERT(is_partner(OfflineBo)),
	OfflineBo#offline_bo.par_property#par_prop.quality.


%% 离线宠物bo的修炼等级
get_par_cultivate_lv(OfflineBo) ->
	?ASSERT(is_partner(OfflineBo)),
	OfflineBo#offline_bo.par_property#par_prop.cultivate_lv.


%% 离线宠物bo的修炼层数
get_par_cultivate_layer(OfflineBo) ->
	?ASSERT(is_partner(OfflineBo)),
	OfflineBo#offline_bo.par_property#par_prop.cultivate_layer.


%% 离线宠物bo的进化等级
get_par_evolve_lv(OfflineBo) ->
	?ASSERT(is_partner(OfflineBo)),
	OfflineBo#offline_bo.par_property#par_prop.evolve_lv.


%% 离线宠物bo的性格
get_par_nature(OfflineBo) ->
	?ASSERT(is_partner(OfflineBo)),
	OfflineBo#offline_bo.par_property#par_prop.nature.


%% 离线宠物的觉醒等级（幻化）
get_par_awake_illusion(OfflineBo) ->
	?ASSERT(is_partner(OfflineBo)),
	OfflineBo#offline_bo.par_property#par_prop.awake_illusion.

%% 离线宠物bo是否设为出战
is_par_fighting(OfflineBo) ->
	?ASSERT(is_partner(OfflineBo), OfflineBo),
	OfflineBo#offline_bo.par_property#par_prop.is_fighting.


%% 判定一次离线宠物是否可以实际出战？
can_par_goto_fight_once(OfflineBo) ->
	?ASSERT(is_partner(OfflineBo), OfflineBo),
    TmpDummyPar = #partner{
                    loyalty = mod_offline_bo:get_par_loyalty(OfflineBo),
                    quality = mod_offline_bo:get_par_quality(OfflineBo)
                    },
    lib_partner:can_goto_fight_once(TmpDummyPar).



% %% 获取离线bo
% %% @para: Id => 玩家id或宠物id
% %%        BoType => bo类型（玩家？还是宠物？），详见common.hrl中的OBJ_XXX宏
% %%        SysType => 对应的系统类型（如： 天梯系统，雇佣天降系统等）
% %% @return: null | offline_bo结构体
% get_offline_bo(Id, BoType, SysType) ->
% 	% 采用懒初始化(lazy initialization)的方式： 
% 	% 先从ets中查找， 如果没有，则再调用db_load_offline_bo()尝试从数据库加载
% 	case ets:lookup(?ETS_OFFLINE_BO, to_offline_bo_key(Id, BoType, SysType)) of
% 		[] ->
% 			case db_load_offline_bo(Id, BoType, SysType) of
% 				null ->
% 					null;
% 				OfflineBo ->
% 					add_offline_bo_to_cache(OfflineBo), % 添加到ets当做缓存，下次获取时便可以直接从ets中获取
% 					OfflineBo
% 			end;
% 		[OfflineBo] ->
% 			OfflineBo
% 	end.

	

% %% 更新离线玩家bo到ets（如果ets中原先没有对应的离线bo，则直接插入）
% %% @para: PS_Latest => 玩家当前对应的最新的PS
% %%        SysType => 对应的系统类型（如： 天梯系统，雇佣天降系统等）
% update_offline_bo_to_cache(PS_Latest, SysType) when is_record(PS_Latest, player_status) ->
% 	% 依据PS_Latest构造出新的offline_bo结构体， 然后插入ets以代替旧数据
% 	NewOfflineBo = build_offline_bo_rd(PS_Latest, SysType),
% 	ets:insert(?ETS_OFFLINE_BO, NewOfflineBo);

% %% 更新离线宠物bo到ets
% update_offline_bo_to_cache(Partner, SysType) when is_record(Partner, partner) ->
% 	% 同上做类似的处理
% 	todo_here.
	





% %% 添加离线bo到ets
% %% @para: OfflineBo => 离线bo（offline_bo结构体）
% add_offline_bo_to_cache(OfflineBo) ->
% 	true = ets:insert_new(?ETS_OFFLINE_BO, OfflineBo).



% %% 从ets删除某离线bo
% del_offline_bo_from_cache(OfflineBo) ->
% 	todo_here.




% %% 根据PS，构造玩家对应的offline_bo结构体
% %% @return: offline_bo结构体
% build_offline_bo_rd(PS, SysType) when is_record(PS, player_status) ->
% 	todo_here;

% %% 根据Partner，构造宠物对应的offline_bo结构体
% build_offline_bo_rd(Partner, SysType) when is_record(Partner, partner) ->
% 	todo_here.






% %% 从数据库加载离线bo
% %% @return: null | offline_bo结构体
% db_load_offline_bo(Id, BoType, SysType) ->
% 	% 从数据库的offline_bo表查找对应的数据，如果没有，则返回null， 
% 	% 否则，把所得的数据构造成offline_bo结构体并返回它
% 	todo_here.




% %% 保存玩家对应的离线bo数据到数据库的offline_bo表
% db_save_offline_bo(PS_Latest, SysType) when is_record(PS_Latest, player_status) ->
% 	todo_here;

% %% 保存宠物对应的离线bo数据到数据库的offline_bo表
% db_save_offline_bo(Partner, SysType) when is_record(Partner, partner) ->
% 	todo_here.







% %% 转为离线bo的key：{玩家id或宠物id，对象类型，所对应的系统类型}
% to_offline_bo_key(Id, BoType, SysType) ->
% 	{Id, BoType, SysType}.