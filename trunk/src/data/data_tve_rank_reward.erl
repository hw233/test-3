%%%---------------------------------------
%%% @Module  : data_tve_rank_reward
%%% @Author  : zwq
%%% @Email   : 
%%% @Description:  守护三界排名奖励
%%%---------------------------------------


-module(data_tve_rank_reward).
-include("common.hrl").
-include("record.hrl").
-include("tve.hrl").
-compile(export_all).

get_rank_list_by_no(1)->
	[1,2,3,4,5,6,7,8,9,10].

get(1,1) ->
	#rank_reward{
		no = 1,
		lv_range = [50,max],
		rank = 1,
		goods_list = [{10066,500}],
		mail_title = <<"1">>,
		mail_content = <<"1">>
};

get(1,2) ->
	#rank_reward{
		no = 1,
		lv_range = [50,max],
		rank = 2,
		goods_list = [{10066,400}],
		mail_title = <<"1">>,
		mail_content = <<"1">>
};

get(1,3) ->
	#rank_reward{
		no = 1,
		lv_range = [50,max],
		rank = 3,
		goods_list = [{10066,300}],
		mail_title = <<"1">>,
		mail_content = <<"1">>
};

get(1,4) ->
	#rank_reward{
		no = 1,
		lv_range = [50,max],
		rank = 4,
		goods_list = [{10066,200}],
		mail_title = <<"1">>,
		mail_content = <<"1">>
};

get(1,5) ->
	#rank_reward{
		no = 1,
		lv_range = [50,max],
		rank = 5,
		goods_list = [{10066,100}],
		mail_title = <<"1">>,
		mail_content = <<"1">>
};

get(1,6) ->
	#rank_reward{
		no = 1,
		lv_range = [50,max],
		rank = 6,
		goods_list = [{10066,90}],
		mail_title = <<"1">>,
		mail_content = <<"1">>
};

get(1,7) ->
	#rank_reward{
		no = 1,
		lv_range = [50,max],
		rank = 7,
		goods_list = [{10066,80}],
		mail_title = <<"1">>,
		mail_content = <<"1">>
};

get(1,8) ->
	#rank_reward{
		no = 1,
		lv_range = [50,max],
		rank = 8,
		goods_list = [{10066,70}],
		mail_title = <<"1">>,
		mail_content = <<"1">>
};

get(1,9) ->
	#rank_reward{
		no = 1,
		lv_range = [50,max],
		rank = 9,
		goods_list = [{10066,60}],
		mail_title = <<"1">>,
		mail_content = <<"1">>
};

get(1,10) ->
	#rank_reward{
		no = 1,
		lv_range = [50,max],
		rank = 10,
		goods_list = [{10066,50}],
		mail_title = <<"1">>,
		mail_content = <<"1">>
};

get(_No, _Rank) ->
          null.

