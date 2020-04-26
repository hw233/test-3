-ifndef(__ACHIEVEMENT_HRL__).
-define(__ACHIEVEMENT_HRL__, achievement_hrl).

-record(achievement, {
    no = 0                  % 成就编号
    ,name = 0               % 成就名称
    ,type = 0               % 成就类型
    ,event_type = 0         % 事件类型
    ,condition = []         % 事件条件 [{condition, Val},...]
    ,num_limit = 1          % 数据记录上限， 0:无限
    ,add_attr = []          % 属性加成
    ,reward = []            % 奖励
    ,contri = 0             % 功绩点
    }).

-define(ACHIEVENT_DATA, {achievement, data}).

-endif.