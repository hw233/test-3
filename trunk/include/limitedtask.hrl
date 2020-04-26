%%限时任务


-record(limited_time_player , {
  player_id = 0,
  index = 0,  %玩家当前进入的任务，用于通过之后发奖
  point = 0,  %分数
  remain = 0,  %免费的次数
  cost_remain = 0,  %购买剩余的次数
  times = 0 ,  %累计购买的次数
  extra_valid = 0 , %0为没资格，1为有资格
  extra_reward = [] , %已经领取的额外奖励
  get_reward = [],  %已经领取的奖励
  unix_time = 0  %分数更新的时间戳
}).



%%[{"degree":"1","taskArg":"5566","taskGoodsNo":"89002","taskGoodsNum1":"5",
%%"taskGoodsNum2":"10","taskMon":"1024","taskScore":"10","taskTitle":"打死他",
%%"taskType":"timebattle"},{"degree":"2","taskArg":"7788","taskGoodsNo":"89020",
%%"taskGoodsNum1":"10","taskGoodsNum2":"20","taskMon":"2048","taskScore":
%%"15","taskTitle":"弄死他","taskType":"battle"}],"type":"16"}
-record(limited_time_data , {
  key  = 0 ,
  task_title = <<"blank">>, %任务描述
  level = 0,            %难度，
  arg = 0   ,           % 任务参数
  end_time = 0,
  task_goods = {0,0,0}, %通关奖励和数量  {GoodsNo,  MinNum, MaxNum}
  task_Mon = 0 ,        %怪物组
  task_score = 0 ,      %通关分数
  task_type  = 0        %战斗类型
}).

%%"attach":"[{20,89005,3,1,''},{50,89006,2,2,''}]","btnSet":"1","eattach":"[{30,89003,3,1,''},{50,89004,3,2,''}]"
-record(limited_time_attach , {
  key = attach,
  end_time = 0,
  lists = []  %奖励列表
}
).

-record(limited_time_eattach , {
  key = eattach,
  end_time = 0,
  lists = []  %奖励列表
}
).

