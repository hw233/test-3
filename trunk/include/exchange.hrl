%%%-------------------------------------------------------------------
%%% @author wujiancheng
%%% @copyright (C) 2019, <wujiancheng>
%%% @doc
%%%
%%% @end
%%% Created : 31. 七月 2019 20:27
%%%-------------------------------------------------------------------
-author("wujiancheng").

-record(exchange, {
  id = 1,
  goods_id = 10047,
  price_type = 2,
  expend = [{60177,1},{60178,1},{60179,1},{60180,1},{60181,1}],
  num = []
}).

-record(credit_shop, {
  id = 1,
  goods_no = 20003,
  price = [{6,100}]
}).
