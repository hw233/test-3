%%%-------------------------------------- 
%%% @Module: lib_bt_rela
%%% @Author: huangjf
%%% @Created: 2014.10.17
%%% @Description: 战场中bo之间的关系信息
%%%-------------------------------------- 
-module(lib_bt_rela).
-export([
        init_intimacy_info_for_all_bo/0,
        init_couple_info_for_all_bo/0,
        get_protect_proba_by_intimacy/2,
        get_intimacy/2,
        set_intimacy/3
    ]).
    
-include("battle.hrl").
-include("record/battle_record.hrl").
-include("debug.hrl").

%% 初始化好友度信息
init_intimacy_info_for_all_bo() ->
	init_intimacy_info_for_side(?HOST_SIDE),
	init_intimacy_info_for_side(?GUEST_SIDE).



init_intimacy_info_for_side(Side) ->
	% 目前只有同一方的玩家之间才有好友度
    L = lib_bt_comm:get_online_player_bo_id_list_except_hired_player(Side),
    case length(L) > 1 of
    	true ->
    		init_intimacy_info_for_bos(L, L);
    	false ->
    		skip
    end.
    


init_intimacy_info_for_bos([], _SrcBoIdList) ->
	done;
init_intimacy_info_for_bos([BoId | T], SrcBoIdList) ->
	init_intimacy_info_for_one_bo(BoId, SrcBoIdList),
	init_intimacy_info_for_bos(T, SrcBoIdList).




init_intimacy_info_for_one_bo(BoId, SrcBoIdList) ->
	OtherBoIdList = SrcBoIdList -- [BoId],
	Bo = lib_bt_comm:get_bo_by_id(BoId),
	do_init_intimacy_info_for_one_bo(Bo, OtherBoIdList).


do_init_intimacy_info_for_one_bo(_Bo, []) ->
	done;
do_init_intimacy_info_for_one_bo(Bo, [OtherBoId | T]) ->
	OtherBo = lib_bt_comm:get_bo_by_id(OtherBoId),
	init_intimacy_info_between_two_bos(Bo, OtherBo),
	do_init_intimacy_info_for_one_bo(Bo, T).



init_intimacy_info_between_two_bos(A, B) ->
	?ASSERT(lib_bt_comm:is_player(A)),
	?ASSERT(lib_bt_comm:is_player(B)),
	PlayerId_A = lib_bo:get_parent_obj_id(A),
	PlayerId_B = lib_bo:get_parent_obj_id(B),
	IntimacyVal = ply_relation:get_intimacy_between_AB(PlayerId_A, PlayerId_B),
	set_intimacy(A, B, IntimacyVal).




%% 初始化配偶信息（包括夫妻技能）
init_couple_info_for_all_bo() ->
	init_couple_info_for_side(?HOST_SIDE),
	init_couple_info_for_side(?GUEST_SIDE).


init_couple_info_for_side(Side) ->
    case lib_bt_comm:get_online_player_bo_id_list_except_hired_player(Side) of
    	[] ->
    		skip;
    	L ->
    		init_couple_info_for_bos(L, L)
    end.
    

init_couple_info_for_bos([], _SrcBoIdList) ->
	done;
init_couple_info_for_bos([BoId | T], SrcBoIdList) ->
	init_couple_info_for_one_bo(BoId, SrcBoIdList),
	init_couple_info_for_bos(T, SrcBoIdList).


init_couple_info_for_one_bo(BoId, SrcBoIdList) ->
	OtherBoIdList = SrcBoIdList -- [BoId],
	Bo = lib_bt_comm:get_bo_by_id(BoId),
	do_init_couple_info_for_one_bo(Bo, OtherBoIdList).


do_init_couple_info_for_one_bo(Bo, OtherBoIdList) ->
	MyPlayerId = lib_bo:get_parent_obj_id(Bo),

	CoupleSkillList = ply_skill:get_couple_skill_list(MyPlayerId),
	?BT_LOG(io_lib:format("do_init_couple_info_for_one_bo(), BoId:~p, MyPlayerId:~p, CoupleSkillList:~p", 
								[lib_bo:id(Bo), MyPlayerId, CoupleSkillList])),

	InitiativeCoupleSkillList = [X || X <- CoupleSkillList, mod_skill:is_initiative(X#skl_brief.id)],
	PassiCoupleSkillList      = [X || X <- CoupleSkillList, mod_skill:is_passive(X#skl_brief.id)],

	Bo2 = Bo#battle_obj{
				couple_skill_list = [lib_bt_skill:to_bo_skill_brief(X) || X <- CoupleSkillList],
				% 夫妻技能附加到主动技能或被动技能列表中
				initiative_skill_list = Bo#battle_obj.initiative_skill_list ++ [lib_bt_skill:to_bo_skill_brief(X) || X <- InitiativeCoupleSkillList],
				passi_skill_list      = Bo#battle_obj.passi_skill_list ++ [lib_bt_skill:to_bo_skill_brief(X) || X <- PassiCoupleSkillList]
				},

	IntimacyWithSpouse = case ply_relation:get_spouse_id(MyPlayerId) of
							?INVALID_ID ->
								0;
							SpousePlayerId ->
								ply_relation:get_intimacy_between_AB(MyPlayerId, SpousePlayerId)
						end,

	Bo3 = Bo2#battle_obj{intimacy_with_spouse = IntimacyWithSpouse},

	Bo4 = 	case find_spouse_from(Bo, OtherBoIdList) of
				null ->
					Bo3#battle_obj{spouse_bo_id = ?INVALID_ID};
				SpouseBo ->
					Bo3#battle_obj{spouse_bo_id = lib_bo:id(SpouseBo)}
			end,

	?BT_LOG(io_lib:format("do_init_couple_info_for_one_bo(), BoId:~p, MyPlayerId:~p, SpouseBoId:~p, IntimacyWithSpouse:~p", 
												[lib_bo:id(Bo), MyPlayerId, lib_bo:get_spouse_bo_id(Bo4), IntimacyWithSpouse])),

	lib_bt_comm:update_bo(Bo4).


%% 从OtherBoIdList中查找Bo的配偶
%% @return: null | #battle_obj{}
find_spouse_from(_Bo, OtherBoIdList) when OtherBoIdList == [] ->
	null;
find_spouse_from(Bo, OtherBoIdList) ->
	PlayerId = lib_bo:get_parent_obj_id(Bo),
	case ply_relation:get_spouse_id(PlayerId) of
		?INVALID_ID ->
			null;
		SpousePlayerId ->
			loop_find_spouse_from(SpousePlayerId, OtherBoIdList)
	end.

loop_find_spouse_from(_SpousePlayerId, []) ->
	null;
loop_find_spouse_from(SpousePlayerId, [OtherBoId | T]) ->
	OtherBo = lib_bt_comm:get_bo_by_id(OtherBoId),
	case lib_bo:get_parent_obj_id(OtherBo) == SpousePlayerId of
		true ->
			OtherBo;
		false ->
			loop_find_spouse_from(SpousePlayerId, T)
	end.


	




%% 好友度达到多少之后，即达到了触发保护的概率的上限
-define(BASE_INTIMACY_FOR_MAX_PROTE_PROBA, 10000).


%% 依据两个bo之前的好友度，获取触发保护的概率
get_protect_proba_by_intimacy(A, B) ->
	IntimacyVal = min(get_intimacy(A, B), ?BASE_INTIMACY_FOR_MAX_PROTE_PROBA),
	Segment = (IntimacyVal div 10) * 10,
	case data_intimacy_and_protect_proba:get(Segment) of
		null ->  % 容错，返回0
			?ASSERT(false, {IntimacyVal, Segment, A, B}),
			0;
		R ->
			R#prote_proba_by_intimacy.protect_proba / 100
	end.

		



%% 获取两个bo之间的好友度
get_intimacy(A, B) ->
	BoId_A = lib_bo:get_id(A),
	BoId_B = lib_bo:get_id(B),
	case erlang:get({?KN_INTIMACY_BETWEEN, BoId_A, BoId_B}) of
		undefined ->
			0;
		Val ->
			Val
	end.

%% 设置两个bo之间的好友度
set_intimacy(A, B, IntimacyVal) ->
	?ASSERT(util:is_nonnegative_int(IntimacyVal), IntimacyVal),
	BoId_A = lib_bo:get_id(A),
	BoId_B = lib_bo:get_id(B),
	erlang:put({?KN_INTIMACY_BETWEEN, BoId_A, BoId_B}, IntimacyVal).
