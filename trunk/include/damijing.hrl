-ifndef(__DAMIJING_HRL__).
-define(__DAMIJING_HRL__, damijing_hrl).

%%ets  ets_mystery_mon_info
%%     ets_flop_rewards_info
%%     ets_mirage_wait_info

-record(damijing_config,{
    no = 0,
    type = 0,
    degree = 0,
    lv = 0,
    cost = {},
    spawn_mon_type = 0,
    mon_pool_elite = {},
    diamond_card = 0,
    gold_card = 0,
    silver_card = 0,
    copper_card = 0,
    more_card_price = [],
    teammate_card = 0
}).

-record(damijing_mon,{
    no = 0,
    type = 0,
    num = 0,
    mon_group = 0,
    elite_mon_group = 0,
    victory_points = 0
}).

-record(mystery_mon_info,{
    player_id = 0,
    no = 0,                 %% 关卡编号
    type = 0,               %% 关卡类型
    degree = 0,             %% 关卡难度
    level = 0,              %% 当前进度（所在关卡）
    all_level = 0,          %% 总关卡数
    mon_pool_elite = [],    %% 精英关卡
    mon_list = []           %% 怪兽列表
}).

-record(flop_rewards_info,{
    player_id = 0,
    time = 0,
    box = [],
    cost = []
}).

-record(mirage_wait_info,{
    team_id = 0,
    no = 0,
    leader_id = 0,
    player_ids = [],
    player_names = []
}).


-endif.