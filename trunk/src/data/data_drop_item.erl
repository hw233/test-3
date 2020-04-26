%%%---------------------------------------
%%% @Module  : data_player
%%% @Author  : LDS
%%% @Email   : 
%%% @Created : 2012-09-17  17:44:38
%%% @Description:  自动生成
%%%---------------------------------------

-module(data_drop_item).
-export([
		 get/1,
		 get_item_name/1,
		 get_drop_mon/1
		]).
-include("common.hrl").
-include("record.hrl").

get(1057) ->
	[{1036,80}];
get(1059) ->
	[{1037,80}];
get(1062) ->
	[{1038,80}];
get(1065) ->
	[{1039,80}];
get(1082) ->
	[{1042,30}];
get(1083) ->
	[{1043,30}];
get(1086) ->
	[{1044,30}];
get(1095) ->
	[{1045,60}];
get(1097) ->
	[{1046,60}];
get(1098) ->
	[{1047,60}];
get(1100) ->
	[{1048,60}];
get(1114) ->
	[{1052,60}];
get(1118) ->
	[{1053,80}];
get(1121) ->
	[{1054,80}];
get(1122) ->
	[{1055,60}];
get(1123) ->
	[{1055,60}];
get(5108) ->
	[{1032,100}];
get(5109) ->
	[{1033,100}];
get(5110) ->
	[{1034,100}];
get(5111) ->
	[{1040,60}];
get(5112) ->
	[{1041,60}];
get(5113) ->
	[{1035,100}];
get(5117) ->
	[{1056,100}];
get(5118) ->
	[{1049,100}];
get(5119) ->
	[{1051,100}];
get(5120) ->
	[{1050,100}];

get(_)->
	[].
	
get_item_name(1032)->
	<<"勇气之证">>;
get_item_name(1033)->
	<<"运气之证">>;
get_item_name(1034)->
	<<"毅力之证">>;
get_item_name(1035)->
	<<"神木">>;
get_item_name(1036)->
	<<"机关零件">>;
get_item_name(1037)->
	<<"祭坛晶核">>;
get_item_name(1038)->
	<<"银鳞">>;
get_item_name(1039)->
	<<"紫甲">>;
get_item_name(1040)->
	<<"天之锁">>;
get_item_name(1041)->
	<<"黑暗之心">>;
get_item_name(1042)->
	<<"刀锋">>;
get_item_name(1043)->
	<<"止战之戟（上）">>;
get_item_name(1044)->
	<<"止战之戟（下）">>;
get_item_name(1045)->
	<<"水晶魔方">>;
get_item_name(1046)->
	<<"地晶魔方">>;
get_item_name(1047)->
	<<"火晶魔方">>;
get_item_name(1048)->
	<<"风晶魔方">>;
get_item_name(1049)->
	<<"陪葬品">>;
get_item_name(1050)->
	<<"血精石">>;
get_item_name(1051)->
	<<"火焰玦">>;
get_item_name(1052)->
	<<"黄金面具">>;
get_item_name(1053)->
	<<"混沌结晶">>;
get_item_name(1054)->
	<<"毒虫甲壳">>;
get_item_name(1055)->
	<<"神格碎片">>;
get_item_name(1056)->
	<<"地灵之源">>;
get_item_name(_)->
	<<"">>.
	
get_drop_mon(1032)->
	[5108];
get_drop_mon(1033)->
	[5109];
get_drop_mon(1034)->
	[5110];
get_drop_mon(1035)->
	[5113];
get_drop_mon(1036)->
	[1057];
get_drop_mon(1037)->
	[1059];
get_drop_mon(1038)->
	[1062];
get_drop_mon(1039)->
	[1065];
get_drop_mon(1040)->
	[5111];
get_drop_mon(1041)->
	[5112];
get_drop_mon(1042)->
	[1082];
get_drop_mon(1043)->
	[1083];
get_drop_mon(1044)->
	[1086];
get_drop_mon(1045)->
	[1095];
get_drop_mon(1046)->
	[1097];
get_drop_mon(1047)->
	[1098];
get_drop_mon(1048)->
	[1100];
get_drop_mon(1049)->
	[5118];
get_drop_mon(1050)->
	[5120];
get_drop_mon(1051)->
	[5119];
get_drop_mon(1052)->
	[1114];
get_drop_mon(1053)->
	[1118];
get_drop_mon(1054)->
	[1121];
get_drop_mon(1055)->
	[1122, 1123];
get_drop_mon(1056)->
	[5117];
get_drop_mon(_)->
	[].
