%%%------------------------------------
%%% @author 严利宏 542430172@qq.com
%%% @copyright UCweb 2014.1.1
%%% @doc 跑马场配置信息.
%%% @end
%%%------------------------------------


-module(data_horse_race).
-include("common.hrl").
-include("record.hrl").
-compile(export_all).


			config(min_lv) -> 30
		;

			config(goods_no) -> 80059
		;

			config(base_yuanbao) -> 10
		;

			config(reward_goods) -> [{1,3}, {5,15}, {20,60}, {100,300}]
		;

			config(reward_bgamemoney) -> [{1,5000}, {5,25000}, {20,100000}, {100,500000}]
		;

			config(event_ratio) -> [{1,10},{2,10},{3,10},{4,10},{5,0.1}]
		;

			config(max_gamble_times) -> 10
		;

			config(max_use_prop_time) -> 10
		;

			config(_Key) ->
	?ASSERT(false, _Key),
	null.
		
