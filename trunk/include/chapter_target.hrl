-ifndef(__CHAPTER_TARGET_HRL__).
-define(__CHAPTER_TARGET_HRL__, chapter_target_hrl).

-record(chapter_target, {
    id = 0                      % 玩家ID
    ,reward_info = []           % 章节奖励信息[{no, flag}]
    ,chapter_achievement = []   % 章节成就达成  [{no, flag}]
    ,buy_and_recharge = []      % 章节每日福利 [{no,flag1,falg2,unixtime}]
    ,finish_chapter = []        % 完成的章节
    }).

-record(chapter_data, {
    no = 0
    ,lv = 0
    ,reward_id = 0
    ,target = []
    }).

-record(lilian_sys_open, {
    no,
    type,
    reward
    }).

-record(lilian_task_no, {
    no,
    type,
    num
    }).


-record(chapter_no, {
		no ,
		sex ,
		lv,
		reward_id ,
		target = [],
		buy_pkg ,
		buy_count ,
		price_type ,
		discount_price ,
		discount ,
		recharge_pkg ,
		recharge_count ,
		recharge_amount ,
		recharge_discount 
    }).

-define(CT_RWD_NOT_GET, 0).     % 章节奖励尚未领取
-define(CT_RWD_HAD_GET, 1).     % 章节奖励已经领取


-define(CT_UN_FINISH, 1).   % 成就未完成
-define(CT_FINISH_BUT_NOT_RWD, 2).  % 成就完成，奖励未领取
-define(CT_GET_RWD, 3).     % 成就完成，奖励领取


-endif.