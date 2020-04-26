%%%---------------------------------------
%%% @Module  : data_couple_be_protect_buff_rounds_and_intimacy
%%% @Author  : huangjf
%%% @Email   : 
%%% @Description: 夫妻技能相关配置表: 受保护buff回合数与好友度关联配置表
%%%---------------------------------------


-module(data_couple_be_protect_buff_rounds_and_intimacy).
-export([get_round_count_list/0, get/1]).
-include("debug.hrl").

get_round_count_list()->
	[1,2,3,4,5,6,7,8,9].


				get(1) -> 1
			;

				get(2) -> 1000
			;

				get(3) -> 2500
			;

				get(4) -> 5000
			;

				get(5) -> 10000
			;

				get(6) -> 20000
			;

				get(7) -> 40000
			;

				get(8) -> 65000
			;

				get(9) -> 100000
			;

				get(_RoundCount) -> ?ASSERT(false, _RoundCount), error.
		
