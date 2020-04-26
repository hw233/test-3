%%%-------------------------------------------------------------------
%%% @author wujiancheng
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 17. 六月 2019 18:01
%%%-------------------------------------------------------------------
-author("wujiancheng").

-record(five_elements, {
  no = 0,
  restraint = [],
  berestraint = [],
  re_num = 0,
  be_num = 0
}).

-record(five_elements_level, {
  effect = phy_att_add,
  effect_num = 0,
  expend = []
}).
