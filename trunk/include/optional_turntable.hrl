

-record (optional_turntable,{
  no = 13,
trigger_prob = 1,
partition = 1,
goods_type = 1,
reward = [{62319,30,0,3}],
notice = 0
}).


-record (player_optional_data,{
  player_id = 0,
  total_rate = 0,
  optional_list = []  %% {no,rate}
}).


