%%%---------------------------------------
%%% @Module  : data_newbie_guide
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2012-08-23  14:35:57
%%% @Description: 新手引导相关，自动生成（模板：newhand_guide_erl.tpl.php）
%%%---------------------------------------

-module(data_newbie_guide).

% -export([
% 		get_task_id_list/0,
% 		get_trigger_show_icon_event_id/1,
% 		get_guide_event_id/1
% 		]).

% -include("common.hrl").
% -include("newbie.hrl").



% %% 新手引导涉及的任务id列表（依据引导的先后顺序排列）
% get_task_id_list() ->
% 	[8002, 1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009, 1010, 1011, 8014, 1012, 1013, 1014, 1015, 1016, 1017, 1018, 1019, 1020, 1021, 1022, 1023, 1024, 1026, 1029, 1030, 1031, 1032, 1033, 8043, 1035, 1036, 1037, 1038, 1039, 1040, 1041, 1042, 1043, 1044, 1045, 1046, 1047, 1048, 1049, 1050, 1051, 1052, 1053, 1054, 1055, 1056, 1057, 1058, 1059, 1060, 1061, 1062, 1063, 1064, 1065, 8059].



% %% 获取触发客户端初次显示xx图标的引导事件id
% %% @para: 图标代号（表示阵法图标，或铸造图标，或生产图标等）
% get_trigger_show_icon_event_id(2) ->
% 	130;
	
% get_trigger_show_icon_event_id(1) ->
% 	197;
	
% get_trigger_show_icon_event_id(3) ->
% 	256;
	
% get_trigger_show_icon_event_id(_IconCode) ->
% 	?ASSERT(false, _IconCode),
% 	?INVALID_GUIDE_EVENT_ID.




% %% 依据任务id获取对应的引导事件id
% get_guide_event_id(8002) ->
% 	0;
	
% get_guide_event_id(1001) ->
% 	3;
	
% get_guide_event_id(1002) ->
% 	7;
	
% get_guide_event_id(1003) ->
% 	11;
	
% get_guide_event_id(1004) ->
% 	14;
	
% get_guide_event_id(1005) ->
% 	23;
	
% get_guide_event_id(1006) ->
% 	28;
	
% get_guide_event_id(1007) ->
% 	32;
	
% get_guide_event_id(1008) ->
% 	39;
	
% get_guide_event_id(1009) ->
% 	42;
	
% get_guide_event_id(1010) ->
% 	45;
	
% get_guide_event_id(1011) ->
% 	48;
	
% get_guide_event_id(8014) ->
% 	52;
	
% get_guide_event_id(1012) ->
% 	57;
	
% get_guide_event_id(1013) ->
% 	63;
	
% get_guide_event_id(1014) ->
% 	68;
	
% get_guide_event_id(1015) ->
% 	72;
	
% get_guide_event_id(1016) ->
% 	76;
	
% get_guide_event_id(1017) ->
% 	79;
	
% get_guide_event_id(1018) ->
% 	82;
	
% get_guide_event_id(1019) ->
% 	85;
	
% get_guide_event_id(1020) ->
% 	88;
	
% get_guide_event_id(1021) ->
% 	91;
	
% get_guide_event_id(1022) ->
% 	94;
	
% get_guide_event_id(1023) ->
% 	100;
	
% get_guide_event_id(1024) ->
% 	104;
	
% get_guide_event_id(1026) ->
% 	108;
	
% get_guide_event_id(1029) ->
% 	113;
	
% get_guide_event_id(1030) ->
% 	116;
	
% get_guide_event_id(1031) ->
% 	120;
	
% get_guide_event_id(1032) ->
% 	123;
	
% get_guide_event_id(1033) ->
% 	127;
	
% get_guide_event_id(8043) ->
% 	130;
	
% get_guide_event_id(1035) ->
% 	135;
	
% get_guide_event_id(1036) ->
% 	141;
	
% get_guide_event_id(1037) ->
% 	145;
	
% get_guide_event_id(1038) ->
% 	149;
	
% get_guide_event_id(1039) ->
% 	153;
	
% get_guide_event_id(1040) ->
% 	157;
	
% get_guide_event_id(1041) ->
% 	160;
	
% get_guide_event_id(1042) ->
% 	163;
	
% get_guide_event_id(1043) ->
% 	167;
	
% get_guide_event_id(1044) ->
% 	170;
	
% get_guide_event_id(1045) ->
% 	173;
	
% get_guide_event_id(1046) ->
% 	180;
	
% get_guide_event_id(1047) ->
% 	184;
	
% get_guide_event_id(1048) ->
% 	188;
	
% get_guide_event_id(1049) ->
% 	191;
	
% get_guide_event_id(1050) ->
% 	194;
	
% get_guide_event_id(1051) ->
% 	197;
	
% get_guide_event_id(1052) ->
% 	201;
	
% get_guide_event_id(1053) ->
% 	206;
	
% get_guide_event_id(1054) ->
% 	212;
	
% get_guide_event_id(1055) ->
% 	217;
	
% get_guide_event_id(1056) ->
% 	221;
	
% get_guide_event_id(1057) ->
% 	225;
	
% get_guide_event_id(1058) ->
% 	228;
	
% get_guide_event_id(1059) ->
% 	231;
	
% get_guide_event_id(1060) ->
% 	234;
	
% get_guide_event_id(1061) ->
% 	240;
	
% get_guide_event_id(1062) ->
% 	244;
	
% get_guide_event_id(1063) ->
% 	247;
	
% get_guide_event_id(1064) ->
% 	250;
	
% get_guide_event_id(1065) ->
% 	253;
	
% get_guide_event_id(8059) ->
% 	256;
	
% get_guide_event_id(_TaskId) ->
% 	?INVALID_GUIDE_EVENT_ID.
	
