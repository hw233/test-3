%% @author wjc


-module(pp_wing).

-include("pt_44.hrl").
-include("common.hrl").
-include("chibang.hrl").
-include("obj_info_code.hrl").


-export([handle/3]).

handle(?PT_GET_WING,PS, []) ->
	lib_wing:get_all_wing(player:get_id(PS));

handle(?PT_USE_OR_UNUSE_WING,PS, [WingId, WingNo, Num]) ->
	PlayerId = player:get_id(PS),
	%Num = 0为使用， 1表示不使用
	case Num of
		0 ->
			case ets:lookup(ets_player_wing, PlayerId) of
				[] ->
					skip;
				[R] ->
					lib_scene:notify_int_info_change_to_aoi(player, player:get_id(PS), [{?OI_CODE_WING_SHOW, WingNo}]),
					ets:insert(ets_player_wing, R#player_wing{use_wing = WingNo, wing_id = WingId}),
					db:update(wing, [{use_state, 0}], [{player_id, player:get_id(PS)}, {use_state, 1}]),
					db:update(wing, [{use_state, 1}], [{player_id, player:get_id(PS)}, {wing_id, WingId}]),
					lib_wing:get_all_wing(PlayerId)
			end;
		1 ->
			case ets:lookup(ets_player_wing, PlayerId) of
				[] ->
					skip;
				[R] ->
					lib_scene:notify_int_info_change_to_aoi(player, player:get_id(PS), [{?OI_CODE_WING_SHOW, 0}]),
					ets:insert(ets_player_wing, R#player_wing{use_wing = 0, wing_id = 0}),
					db:update(wing, [{use_state, 0}], [{player_id, player:get_id(PS)}, {wing_id, WingId}]),
					lib_wing:get_all_wing(PlayerId)
			end
	end;

%喂养
handle(?PT_TRAIN_WING,PS, [WingId, WingNo, Feed, Count]) ->
	lib_wing:feed_wing(player:get_id(PS),WingId,WingNo,Count,Feed);

%%handle(?PT_NOW_USE_WING,PS, []) ->
%%	%初始化翅膀
%%	;


handle(_Cmd, _, _) ->
    ?ASSERT(false, [_Cmd]),
    not_match.

	
	
	

	
	


