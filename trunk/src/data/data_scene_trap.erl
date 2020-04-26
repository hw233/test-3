%%%---------------------------------------
%%% @Module  : data_scene_trap
%%% @Author  : huangjf
%%% @Email   : 
%%% @Description: 场景的暗雷配置数据
%%%---------------------------------------


-module(data_scene_trap).
-export([get/1]).
-include("monster.hrl").
-include("debug.hrl").

get(1307) ->
	[
		#trap{
			no = 1, 
			type = 1, 
			bmon_group_no = 400001, 
			conditions = [{lv, 10}]
			}
	];


get(1201) ->
	[
		#trap{
			no = 2, 
			type = 1, 
			bmon_group_no = 400002, 
			conditions = [{lv, 20}]
			}
	];


get(1206) ->
	[
		#trap{
			no = 3, 
			type = 1, 
			bmon_group_no = 400003, 
			conditions = [{lv, 24}]
			}
	];


get(1211) ->
	[
		#trap{
			no = 4, 
			type = 1, 
			bmon_group_no = 400004, 
			conditions = [{lv, 27}]
			}
	];


get(1308) ->
	[
		#trap{
			no = 5, 
			type = 1, 
			bmon_group_no = 400005, 
			conditions = [{lv, 30}]
			}
	];


get(1202) ->
	[
		#trap{
			no = 6, 
			type = 1, 
			bmon_group_no = 400006, 
			conditions = [{lv, 30}]
			}
	];


get(1207) ->
	[
		#trap{
			no = 7, 
			type = 1, 
			bmon_group_no = 400007, 
			conditions = [{lv, 34}]
			}
	];


get(1212) ->
	[
		#trap{
			no = 8, 
			type = 1, 
			bmon_group_no = 400008, 
			conditions = [{lv, 37}]
			}
	];


get(1202) ->
	[
		#trap{
			no = 9, 
			type = 1, 
			bmon_group_no = 400009, 
			conditions = [{lv, 40}]
			}
	];


get(1207) ->
	[
		#trap{
			no = 10, 
			type = 1, 
			bmon_group_no = 400010, 
			conditions = [{lv, 44}]
			}
	];


get(1212) ->
	[
		#trap{
			no = 11, 
			type = 1, 
			bmon_group_no = 400011, 
			conditions = [{lv, 47}]
			}
	];


get(13081) ->
	[
		#trap{
			no = 12, 
			type = 1, 
			bmon_group_no = 400012, 
			conditions = [{lv, 40}]
			}
	];


get(1203) ->
	[
		#trap{
			no = 13, 
			type = 1, 
			bmon_group_no = 400013, 
			conditions = [{lv, 50}]
			}
	];


get(1208) ->
	[
		#trap{
			no = 14, 
			type = 1, 
			bmon_group_no = 400014, 
			conditions = [{lv, 54}]
			}
	];


get(1213) ->
	[
		#trap{
			no = 15, 
			type = 1, 
			bmon_group_no = 400015, 
			conditions = [{lv, 57}]
			}
	];


get(1309) ->
	[
		#trap{
			no = 16, 
			type = 1, 
			bmon_group_no = 400016, 
			conditions = [{lv, 50}]
			}
	];


get(1310) ->
	[
		#trap{
			no = 17, 
			type = 1, 
			bmon_group_no = 400020, 
			conditions = [{lv, 60}]
			}
	];


get(1204) ->
	[
		#trap{
			no = 18, 
			type = 1, 
			bmon_group_no = 400017, 
			conditions = [{lv, 60}]
			}
	];


get(1209) ->
	[
		#trap{
			no = 19, 
			type = 1, 
			bmon_group_no = 400018, 
			conditions = [{lv, 64}]
			}
	];


get(1214) ->
	[
		#trap{
			no = 20, 
			type = 1, 
			bmon_group_no = 400019, 
			conditions = [{lv, 67}]
			}
	];


get(1205) ->
	[
		#trap{
			no = 21, 
			type = 1, 
			bmon_group_no = 1025, 
			conditions = [{lv, 65}]
			}
	];


get(1210) ->
	[
		#trap{
			no = 22, 
			type = 1, 
			bmon_group_no = 1026, 
			conditions = [{lv, 65}]
			}
	];


get(1215) ->
	[
		#trap{
			no = 23, 
			type = 1, 
			bmon_group_no = 1027, 
			conditions = [{lv, 65}]
			}
	];


get(1311) ->
	[
		#trap{
			no = 24, 
			type = 1, 
			bmon_group_no = 1024, 
			conditions = [{lv, 65}]
			}
	];


get(1312) ->
	[
		#trap{
			no = 25, 
			type = 1, 
			bmon_group_no = 1028, 
			conditions = [{lv, 75}]
			}
	];


get(1216) ->
	[
		#trap{
			no = 26, 
			type = 1, 
			bmon_group_no = 1029, 
			conditions = [{lv, 75}]
			}
	];


get(1217) ->
	[
		#trap{
			no = 27, 
			type = 1, 
			bmon_group_no = 1030, 
			conditions = [{lv, 75}]
			}
	];


get(1218) ->
	[
		#trap{
			no = 28, 
			type = 1, 
			bmon_group_no = 1031, 
			conditions = [{lv, 75}]
			}
	];


get(_No) ->
	%%?ASSERT(false, _No),
	[].

