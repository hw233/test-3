-ifndef(__CHIBANG_INFO_HRL__).
-define(__CHIBANG_INFO_HRL__, chibang_info_hrl).


-record(player_wing, {
	player_id = 0,
	use_wing  = 0,
	wing_id = 0,
	all_wing_id = []
}).


-record(wing_info, {
	player_key ={0,0},
	wing_no = 0,
	type = 0,
	lv = 0,
	exp = 0,
	attrs = []
}).



-record(chibang_info, {
	id =0,
	type = 0,
	train_goods1 = {},
	train_goods2 ={},
	train_goods3 = {}

}).




-record(data_chibang, {
	id =0,
	train_goods1 = 0,
	train_goods2 = 0
}).




















-endif.