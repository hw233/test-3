% %%%---------------------------------------
% %%% @Module  : data_scene_item
% %%% @Author  : LDS
% %%% @Email   : 
% %%% @Created : 2012-09-27  14:49:56
% %%% @Description:  自动生成
% %%%---------------------------------------

-module(data_scene_item).
% -export([get/1, get_id_list/0]).
% -include("record.hrl").

% get_id_list() ->
% [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,84,64,65,66,85,67,68,69,86,70,71,72,87,73,74,75,76,77,78,79,80,81,88,82,	83].
			
% 	get(1) ->
% 		#scene_item{ 
% 					item_id = 1,
% 	   			name = <<"神器残剑">>,
% 	   			type = {1,1},
% 	   			icon = 14,
% 	   			req = 0,
% 	   			repeat = 1,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [{100,3,9000}],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(2) ->
% 		#scene_item{ 
% 					item_id = 2,
% 	   			name = <<"晶矿">>,
% 	   			type = {1,1},
% 	   			icon = 21,
% 	   			req = 0,
% 	   			repeat = 1,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(3) ->
% 		#scene_item{ 
% 					item_id = 3,
% 	   			name = <<"水晶球">>,
% 	   			type = {1,1},
% 	   			icon = 12,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 1006,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(4) ->
% 		#scene_item{ 
% 					item_id = 4,
% 	   			name = <<"旗子">>,
% 	   			type = {1,1},
% 	   			icon = 10,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(5) ->
% 		#scene_item{ 
% 					item_id = 5,
% 	   			name = <<"糖葫芦">>,
% 	   			type = {1,1},
% 	   			icon = 20,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [{30,1,[901,902,903,904,905,906,907,908,909]},{70,2,[37,38,39,40,41,42,43,44,45]}],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(6) ->
% 		#scene_item{ 
% 					item_id = 6,
% 	   			name = <<"大炮">>,
% 	   			type = {1,1},
% 	   			icon = 15,
% 	   			req = 600900001,
% 	   			repeat = 1,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [[5020,10000],[5021,20000],[5022,30000],[5023,40000],[5024,50000],[5025,60000],[5026,70000],[5027,80000]],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(7) ->
% 		#scene_item{ 
% 					item_id = 7,
% 	   			name = <<"20级关卡木箱">>,
% 	   			type = {2,5},
% 	   			icon = 30,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = [1]
% 					};
% 	get(8) ->
% 		#scene_item{ 
% 					item_id = 8,
% 	   			name = <<"30级关卡木箱">>,
% 	   			type = {2,5},
% 	   			icon = 30,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = [3]
% 					};
% 	get(9) ->
% 		#scene_item{ 
% 					item_id = 9,
% 	   			name = <<"40级关卡木箱">>,
% 	   			type = {2,5},
% 	   			icon = 30,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = [5]
% 					};
% 	get(10) ->
% 		#scene_item{ 
% 					item_id = 10,
% 	   			name = <<"20级副本木箱">>,
% 	   			type = {2,5},
% 	   			icon = 30,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = [9,10]
% 					};
% 	get(11) ->
% 		#scene_item{ 
% 					item_id = 11,
% 	   			name = <<"30级副本木箱">>,
% 	   			type = {2,5},
% 	   			icon = 30,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = [9,10]
% 					};
% 	get(12) ->
% 		#scene_item{ 
% 					item_id = 12,
% 	   			name = <<"40级副本木箱">>,
% 	   			type = {2,5},
% 	   			icon = 30,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = [11,12]
% 					};
% 	get(13) ->
% 		#scene_item{ 
% 					item_id = 13,
% 	   			name = <<"灵碑">>,
% 	   			type = {1,1},
% 	   			icon = 16,
% 	   			req = 0,
% 	   			repeat = 1,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(14) ->
% 		#scene_item{ 
% 					item_id = 14,
% 	   			name = <<"牢笼开关">>,
% 	   			type = {1,1},
% 	   			icon = 13,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 1004,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(15) ->
% 		#scene_item{ 
% 					item_id = 15,
% 	   			name = <<"冰雕">>,
% 	   			type = {1,1},
% 	   			icon = 17,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 1014,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [{100,3,1017}],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(16) ->
% 		#scene_item{ 
% 					item_id = 16,
% 	   			name = <<"冰壁">>,
% 	   			type = {1,1},
% 	   			icon = 18,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(17) ->
% 		#scene_item{ 
% 					item_id = 17,
% 	   			name = <<"神火结晶">>,
% 	   			type = {1,1},
% 	   			icon = 19,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 1024,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(18) ->
% 		#scene_item{ 
% 					item_id = 18,
% 	   			name = <<"能量晶石">>,
% 	   			type = {1,1},
% 	   			icon = 22,
% 	   			req = 0,
% 	   			repeat = 1,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(19) ->
% 		#scene_item{ 
% 					item_id = 19,
% 	   			name = <<"宝箱">>,
% 	   			type = {1,1},
% 	   			icon = 23,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 1,
% 	   			goods = [13,14]
% 					};
% 	get(20) ->
% 		#scene_item{ 
% 					item_id = 20,
% 	   			name = <<"救生舟">>,
% 	   			type = {1,1},
% 	   			icon = 24,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 1036,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(21) ->
% 		#scene_item{ 
% 					item_id = 21,
% 	   			name = <<"船炮">>,
% 	   			type = {1,1},
% 	   			icon = 25,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 1038,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(22) ->
% 		#scene_item{ 
% 					item_id = 22,
% 	   			name = <<"钓鱼">>,
% 	   			type = {1,1},
% 	   			icon = 26,
% 	   			req = 0,
% 	   			repeat = 1,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(23) ->
% 		#scene_item{ 
% 					item_id = 23,
% 	   			name = <<"海盗宝藏">>,
% 	   			type = {1,1},
% 	   			icon = 28,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 1046,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = [17]
% 					};
% 	get(24) ->
% 		#scene_item{ 
% 					item_id = 24,
% 	   			name = <<"符文">>,
% 	   			type = {1,1},
% 	   			icon = 27,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 1055,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(25) ->
% 		#scene_item{ 
% 					item_id = 25,
% 	   			name = <<"愿望宝箱">>,
% 	   			type = {1,1},
% 	   			icon = 23,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = [15,16]
% 					};
% 	get(26) ->
% 		#scene_item{ 
% 					item_id = 26,
% 	   			name = <<"绿旗">>,
% 	   			type = {1,1},
% 	   			icon = 31,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 1,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 30,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(27) ->
% 		#scene_item{ 
% 					item_id = 27,
% 	   			name = <<"蓝旗">>,
% 	   			type = {1,1},
% 	   			icon = 32,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 2,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 60,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(28) ->
% 		#scene_item{ 
% 					item_id = 28,
% 	   			name = <<"紫旗">>,
% 	   			type = {1,1},
% 	   			icon = 33,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 3,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 180,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(29) ->
% 		#scene_item{ 
% 					item_id = 29,
% 	   			name = <<"红旗">>,
% 	   			type = {1,1},
% 	   			icon = 34,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 4,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 300,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(30) ->
% 		#scene_item{ 
% 					item_id = 30,
% 	   			name = <<"黄旗">>,
% 	   			type = {1,1},
% 	   			icon = 35,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 5,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 600,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(31) ->
% 		#scene_item{ 
% 					item_id = 31,
% 	   			name = <<"圣者之泉">>,
% 	   			type = {1,1},
% 	   			icon = 36,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(32) ->
% 		#scene_item{ 
% 					item_id = 32,
% 	   			name = <<"机关一">>,
% 	   			type = {1,1},
% 	   			icon = 37,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [{100,3,1057}],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(33) ->
% 		#scene_item{ 
% 					item_id = 33,
% 	   			name = <<"机关二">>,
% 	   			type = {1,1},
% 	   			icon = 38,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = [3]
% 					};
% 	get(34) ->
% 		#scene_item{ 
% 					item_id = 34,
% 	   			name = <<"机关三">>,
% 	   			type = {1,1},
% 	   			icon = 39,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [{100,3,1060}],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(35) ->
% 		#scene_item{ 
% 					item_id = 35,
% 	   			name = <<"水晶头骨">>,
% 	   			type = {1,1},
% 	   			icon = 40,
% 	   			req = 0,
% 	   			repeat = 1,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(36) ->
% 		#scene_item{ 
% 					item_id = 36,
% 	   			name = <<"千年棺木">>,
% 	   			type = {1,1},
% 	   			icon = 41,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 1097,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [{100,3,1069}],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(37) ->
% 		#scene_item{ 
% 					item_id = 37,
% 	   			name = <<"动力装置">>,
% 	   			type = {1,1},
% 	   			icon = 42,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 1102,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(38) ->
% 		#scene_item{ 
% 					item_id = 38,
% 	   			name = <<"七灵珠（上）">>,
% 	   			type = {1,1},
% 	   			icon = 43,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(39) ->
% 		#scene_item{ 
% 					item_id = 39,
% 	   			name = <<"神光普照">>,
% 	   			type = {1,1},
% 	   			icon = 44,
% 	   			req = 0,
% 	   			repeat = 1,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(40) ->
% 		#scene_item{ 
% 					item_id = 40,
% 	   			name = <<"水能晶">>,
% 	   			type = {1,1},
% 	   			icon = 45,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [{70,3,1089}],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = [5]
% 					};
% 	get(41) ->
% 		#scene_item{ 
% 					item_id = 41,
% 	   			name = <<"地能晶">>,
% 	   			type = {1,1},
% 	   			icon = 46,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [{80,3,1091}],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = [5]
% 					};
% 	get(42) ->
% 		#scene_item{ 
% 					item_id = 42,
% 	   			name = <<"火能晶">>,
% 	   			type = {1,1},
% 	   			icon = 47,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [{90,3,1092}],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = [5]
% 					};
% 	get(43) ->
% 		#scene_item{ 
% 					item_id = 43,
% 	   			name = <<"风能晶">>,
% 	   			type = {1,1},
% 	   			icon = 48,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [{100,3,1094}],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = [5]
% 					};
% 	get(44) ->
% 		#scene_item{ 
% 					item_id = 44,
% 	   			name = <<"月华女神像">>,
% 	   			type = {1,1},
% 	   			icon = 49,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(45) ->
% 		#scene_item{ 
% 					item_id = 45,
% 	   			name = <<"星咏女神像">>,
% 	   			type = {1,1},
% 	   			icon = 50,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(46) ->
% 		#scene_item{ 
% 					item_id = 46,
% 	   			name = <<"光阳女神像">>,
% 	   			type = {1,1},
% 	   			icon = 51,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(47) ->
% 		#scene_item{ 
% 					item_id = 47,
% 	   			name = <<"七灵珠（下）">>,
% 	   			type = {1,1},
% 	   			icon = 52,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(48) ->
% 		#scene_item{ 
% 					item_id = 48,
% 	   			name = <<"铁塔">>,
% 	   			type = {1,1},
% 	   			icon = 53,
% 	   			req = 0,
% 	   			repeat = 1,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(49) ->
% 		#scene_item{ 
% 					item_id = 49,
% 	   			name = <<"绿旗">>,
% 	   			type = {1,1},
% 	   			icon = 31,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 11,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 10,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(50) ->
% 		#scene_item{ 
% 					item_id = 50,
% 	   			name = <<"蓝旗">>,
% 	   			type = {1,1},
% 	   			icon = 32,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 12,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 20,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(51) ->
% 		#scene_item{ 
% 					item_id = 51,
% 	   			name = <<"紫旗">>,
% 	   			type = {1,1},
% 	   			icon = 33,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 13,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 40,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(52) ->
% 		#scene_item{ 
% 					item_id = 52,
% 	   			name = <<"红旗">>,
% 	   			type = {1,1},
% 	   			icon = 34,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 14,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 80,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(53) ->
% 		#scene_item{ 
% 					item_id = 53,
% 	   			name = <<"黄旗">>,
% 	   			type = {1,1},
% 	   			icon = 35,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 15,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 160,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(54) ->
% 		#scene_item{ 
% 					item_id = 54,
% 	   			name = <<"法老王棺木">>,
% 	   			type = {1,1},
% 	   			icon = 55,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 1146,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [{100,3,1111}],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(55) ->
% 		#scene_item{ 
% 					item_id = 55,
% 	   			name = <<"暗室机关">>,
% 	   			type = {1,1},
% 	   			icon = 56,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 1155,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [{100,3,1115}],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(56) ->
% 		#scene_item{ 
% 					item_id = 56,
% 	   			name = <<"灵界结印">>,
% 	   			type = {1,1},
% 	   			icon = 57,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 1161,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(57) ->
% 		#scene_item{ 
% 					item_id = 57,
% 	   			name = <<"活力之源">>,
% 	   			type = {1,1},
% 	   			icon = 58,
% 	   			req = 0,
% 	   			repeat = 1,
% 	   			task = 1173,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(58) ->
% 		#scene_item{ 
% 					item_id = 58,
% 	   			name = <<"宝箱">>,
% 	   			type = {1,1},
% 	   			icon = 28,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 1005,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = [1]
% 					};
% 	get(59) ->
% 		#scene_item{ 
% 					item_id = 59,
% 	   			name = <<"龙骸宝珠">>,
% 	   			type = {1,1},
% 	   			icon = 59,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 9801,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(60) ->
% 		#scene_item{ 
% 					item_id = 60,
% 	   			name = <<"战神雕像">>,
% 	   			type = {1,1},
% 	   			icon = 54,
% 	   			req = 0,
% 	   			repeat = 1,
% 	   			task = 4000,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [{100,7,101}],
% 	   			revive = 0,
% 	   			disappear = 1,
% 	   			goods = []
% 					};
% 	get(61) ->
% 		#scene_item{ 
% 					item_id = 61,
% 	   			name = <<"一重小宝箱">>,
% 	   			type = {1,2},
% 	   			icon = 66,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = [18,19,20,21,22,23,24,25,26,27,28]
% 					};
% 	get(62) ->
% 		#scene_item{ 
% 					item_id = 62,
% 	   			name = <<"一重中宝箱">>,
% 	   			type = {1,2},
% 	   			icon = 66,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = [29]
% 					};
% 	get(63) ->
% 		#scene_item{ 
% 					item_id = 63,
% 	   			name = <<"一重大宝箱1">>,
% 	   			type = {1,2},
% 	   			icon = 66,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = [31,32,33,34,35,36,37,38,39,40,41]
% 					};
% 	get(84) ->
% 		#scene_item{ 
% 					item_id = 84,
% 	   			name = <<"一重大宝箱2">>,
% 	   			type = {1,2},
% 	   			icon = 66,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = [30]
% 					};
% 	get(64) ->
% 		#scene_item{ 
% 					item_id = 64,
% 	   			name = <<"二重小宝箱">>,
% 	   			type = {1,2},
% 	   			icon = 66,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = [42,43,44,45,46,47,48,49,50,51,52]
% 					};
% 	get(65) ->
% 		#scene_item{ 
% 					item_id = 65,
% 	   			name = <<"二重中宝箱">>,
% 	   			type = {1,2},
% 	   			icon = 66,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = [53]
% 					};
% 	get(66) ->
% 		#scene_item{ 
% 					item_id = 66,
% 	   			name = <<"二重大宝箱1">>,
% 	   			type = {1,2},
% 	   			icon = 66,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = [55,56,57,58,59,60,61,62,63,64,65]
% 					};
% 	get(85) ->
% 		#scene_item{ 
% 					item_id = 85,
% 	   			name = <<"二重大宝箱2">>,
% 	   			type = {1,2},
% 	   			icon = 66,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = [54]
% 					};
% 	get(67) ->
% 		#scene_item{ 
% 					item_id = 67,
% 	   			name = <<"三重小宝箱">>,
% 	   			type = {1,2},
% 	   			icon = 66,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = [66,67,68,69,70,71,72,73,74,75,76]
% 					};
% 	get(68) ->
% 		#scene_item{ 
% 					item_id = 68,
% 	   			name = <<"三重中宝箱">>,
% 	   			type = {1,2},
% 	   			icon = 66,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = [77]
% 					};
% 	get(69) ->
% 		#scene_item{ 
% 					item_id = 69,
% 	   			name = <<"三重大宝箱1">>,
% 	   			type = {1,2},
% 	   			icon = 66,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = [79,80,81,82,83,84,85,86,87,88,89]
% 					};
% 	get(86) ->
% 		#scene_item{ 
% 					item_id = 86,
% 	   			name = <<"三重大宝箱2">>,
% 	   			type = {1,2},
% 	   			icon = 66,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = [78]
% 					};
% 	get(70) ->
% 		#scene_item{ 
% 					item_id = 70,
% 	   			name = <<"四重小宝箱">>,
% 	   			type = {1,2},
% 	   			icon = 66,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = [90,91,92,93,94,95,96,97,98,99,100]
% 					};
% 	get(71) ->
% 		#scene_item{ 
% 					item_id = 71,
% 	   			name = <<"四重中宝箱">>,
% 	   			type = {1,2},
% 	   			icon = 66,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = [101]
% 					};
% 	get(72) ->
% 		#scene_item{ 
% 					item_id = 72,
% 	   			name = <<"四重大宝箱1">>,
% 	   			type = {1,2},
% 	   			icon = 66,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = [103,104,105,106,107,108,109,110,111,112,113]
% 					};
% 	get(87) ->
% 		#scene_item{ 
% 					item_id = 87,
% 	   			name = <<"四重大宝箱2">>,
% 	   			type = {1,2},
% 	   			icon = 66,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = [102]
% 					};
% 	get(73) ->
% 		#scene_item{ 
% 					item_id = 73,
% 	   			name = <<"恶魔卵">>,
% 	   			type = {1,2},
% 	   			icon = 60,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [{12,6,118},{28,6,117},{60,6,116}],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(74) ->
% 		#scene_item{ 
% 					item_id = 74,
% 	   			name = <<"恶魔蛋">>,
% 	   			type = {1,2},
% 	   			icon = 61,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [{100,6,118}],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(75) ->
% 		#scene_item{ 
% 					item_id = 75,
% 	   			name = <<"学院宝箱">>,
% 	   			type = {1,2},
% 	   			icon = 62,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 101,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [{40,4,900}],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(76) ->
% 		#scene_item{ 
% 					item_id = 76,
% 	   			name = <<"海湾宝箱">>,
% 	   			type = {1,2},
% 	   			icon = 63,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 102,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [{50,4,900}],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(77) ->
% 		#scene_item{ 
% 					item_id = 77,
% 	   			name = <<"天穹宝箱">>,
% 	   			type = {1,2},
% 	   			icon = 64,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 103,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [{60,4,900}],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(78) ->
% 		#scene_item{ 
% 					item_id = 78,
% 	   			name = <<"恒古宝箱">>,
% 	   			type = {1,2},
% 	   			icon = 65,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 104,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [{70,4,900}],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = []
% 					};
% 	get(79) ->
% 		#scene_item{ 
% 					item_id = 79,
% 	   			name = <<"五重小宝箱">>,
% 	   			type = {1,2},
% 	   			icon = 66,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = [114,115,116,117,118,119,120,121,122,123,124]
% 					};
% 	get(80) ->
% 		#scene_item{ 
% 					item_id = 80,
% 	   			name = <<"五重中宝箱">>,
% 	   			type = {1,2},
% 	   			icon = 66,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = [125]
% 					};
% 	get(81) ->
% 		#scene_item{ 
% 					item_id = 81,
% 	   			name = <<"五重大宝箱1">>,
% 	   			type = {1,2},
% 	   			icon = 66,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = [127,128,129,130,131,132,133,134,135,136,137]
% 					};
% 	get(88) ->
% 		#scene_item{ 
% 					item_id = 88,
% 	   			name = <<"五重大宝箱2">>,
% 	   			type = {1,2},
% 	   			icon = 66,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = [126]
% 					};
% 	get(82) ->
% 		#scene_item{ 
% 					item_id = 82,
% 	   			name = <<"50级关卡木箱">>,
% 	   			type = {2,5},
% 	   			icon = 30,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = [138,139]
% 					};
% 	get(83) ->
% 		#scene_item{ 
% 					item_id = 83,
% 	   			name = <<"50级副本木箱">>,
% 	   			type = {2,5},
% 	   			icon = 30,
% 	   			req = 0,
% 	   			repeat = 0,
% 	   			task = 0,
% 	   			flag = 0,
% 	   			hurt = [],
% 	   			event = [],
% 	   			revive = 0,
% 	   			disappear = 0,
% 	   			goods = [140,141]
% 					};


% get(_Id) ->
%   []. 


