%%%-----------------------------------
%%% @Module  : lib_scene_line
%%% @Author  : Skyman Wu
%%% @Email   : 
%%% @Created : 2012.04.03
%%% @Description: 场景分线信息
%%% 分线Id从1开始，最大值为999
%%%-----------------------------------
-module(lib_scene_line).   % --- 文件已作废！！！

% %%
% %% Include files
% %%
% -include("common.hrl").
% -include("record.hrl").
% -include("ets_name.hrl").

% -define(FIRST_SCENE_LINE, 1). % 场景第1分线Id
% %%
% %% Exported Functions
% %%
% -export([init_ets/0,
% 		 get_candi_scene_line/1,
% 		 update_scene_line_player_num/3,
% 		 add_player_line_pos_data/5,
% 		 del_player_line_pos_data/3,
% 		 update_player_line_pos_data/5,
% 		 get_scene_line_pos_data/2]).

% %%
% %% API Functions
% %%

% init_ets() ->
% 	% 分线场景信息
% 	ets:new(?ETS_SCENE_LINE, [{keypos, #ets_scene_line.scene_line_id}, named_table, public, set]),
% 	% 每条线的玩家同步信息({{scene,id}, x, y})
% 	F = fun(Id) ->
% 				Tab = list_to_atom([Id]),
% 				ets:new(Tab, [named_table, public, ordered_set])
% 		end,
% 	[F(Id) || Id <- lists:seq(1, ?MAX_PRE_DIFINE_LINE_COUNT)].	
	
% %% 获得候选场景线
% get_candi_scene_line(SceneId) ->
% 	Base = SceneId * 1000,
% 	find_candi_scene_line(Base, ?FIRST_SCENE_LINE).

% %% 更新场景分线的玩家人数
% update_scene_line_player_num(SceneId, LineId, Offset) ->
% %% 	?TRACE("=== update_scene_line_player_num: SceneId=~p,LineId=~p,Offset=~p ===~n", [SceneId, LineId, Offset]),
% 	Id = SceneId * 1000 + LineId,
% 	Line2 = case ets:lookup(?ETS_SCENE_LINE, Id) of
% 				[] ->
% 					?ASSERT(Offset > 0),
% 					#ets_scene_line{scene_line_id = Id, player_num = Offset};
% 				[Line] ->
% 					Line#ets_scene_line{player_num = Line#ets_scene_line.player_num + Offset}		
% 			end,

% 	ets:insert(?ETS_SCENE_LINE, Line2).

% add_player_line_pos_data(LineId, Scene, PlayerId, X, Y) ->
% 	Tab = list_to_atom([LineId]),
% 	case ets:info(Tab) of
% 		undefined ->
% 			mod_kernel:create_new_scene_line_pos_ets({LineId, Scene, PlayerId, X, Y});
% 		_ ->
% 			ets:insert(Tab, {{Scene, PlayerId}, X, Y})
% 	end.

% del_player_line_pos_data(LineId, Scene, PlayerId) ->
% 	Tab = list_to_atom([LineId]),
% 	ets:delete(Tab, {Scene, PlayerId}).

% update_player_line_pos_data(LineId, Scene, PlayerId, NewX, NewY) ->
% 	Tab = list_to_atom([LineId]),
% 	ets:insert(Tab, {{Scene, PlayerId}, NewX, NewY}).

% %% 返回值格式：[[PlayerId1,X1,Y1], [PlayerId2,X12,Y2], [PlayerId3,X3,Y3], ...]
% get_scene_line_pos_data(LineId, Scene) ->
% 	Tab = list_to_atom([LineId]),
% 	ets:select(Tab, [{{{Scene, '$1'}, '$2', '$3'}, [], ['$$']}]).

% %%
% %% Local Functions
% %%
% find_candi_scene_line(_Base, 999) ->
% 	999;
% find_candi_scene_line(Base, Index) ->
% 	case ets:lookup(?ETS_SCENE_LINE, Base + Index) of
% 		[] ->
% 			Index;
% 		[Line] ->
% 			if
% 				Line#ets_scene_line.player_num < ?MAX_PLAYER_NUM_PER_LINE ->
% 					Index;
% 				true ->
% 					find_candi_scene_line(Base, Index + 1)
% 			end
% 	end.
