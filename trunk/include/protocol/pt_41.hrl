%%% 雇佣系统相关协议
%%% 2013.12.31
%%% @author: zhangwq
%%% 分类号：41

%% pt: 表示protocol

% -define(FACTION_NONE, 0).       % 无门派
% -define(FACTION_XMD, 1).        % 须弥殿
% -define(FACTION_WJM, 2).        % 万剑门
% -define(FACTION_YHD, 3).        % 烟火岛
% -define(FACTION_YMC, 4).        % 幽冥城
% -define(FACTION_XBG, 5).        % 玄冰谷
% -define(FACTION_JHG, 6).        % 九华宫
% -define(FACTION_MIN, 1).        % 最小门派代号，仅用于程序做判定
% -define(FACTION_MAX, 6).        % 最大门派代号，仅用于程序做判定


%% ----------------获取天将列表信息------------------------
-define(GET_HIRE_LIST, 41001).
%% 协议号：41001

%% C >> S: 
%%     Faction              u8           门派要求
%%     StartIndex           u32          数据起点 从1 开始
%%     EndIndex             u32          数据终点 服务器比较是否超过最大记录数，如果大于最大记录数，则返回最大记录数
%%     SortType             u8           排序规则 1-> 战斗力降序，2->战斗力升序，3->价格降序，4->价格升序

%% S >> C:
%%      RetCode             u8          成功返回0
%%      TotalCount          u32         总数据条数
%%      array(
%%              Id          u64         玩家id
%%              Name        string      玩家名字
%%              Lv          u16
%%              Faction     u8  
%%              BattlePower u32         战斗力
%%              LeftTime    u8          剩余次数
%%              Price       u32         价格：绑银
%%           )


%% ----------------------------雇佣天将-----------------------------
-define(HIRE_PLAYER, 41002).
%% 协议号：41002

%% C >> S:
%%      PlayerId        u64             被雇佣玩家的id
%%      Count           u8              雇佣次数
%%      Price           u32             雇佣单价

%% S >> C:
%%      RetCode         u8              成功返回0；次数不足或次数已经发生变化返回1；雇佣价格已被修改请重新雇佣返回2
%%      PlayerId        u64             被雇佣玩家的id
%%      Count           u8              雇佣次数


%% --------------------获取我的被雇佣信息-------------------------------
-define(GET_PLAYER_HIRED_INFO, 41003).
%% 协议号：41003

%% C >> S:
%%      无

%% S >> C:
%%      IsSignUp        u8              是否已经报名 1 -- 已经报名 0 -- 还没报名
%%      LeftTime        u8              今天剩余次数
%%      Price           u32             我的雇佣价格
%%      SumIncome       u32             税后可以领取的总收益
%%      TaxRate         u8              随率 百分数 如60% 则用60表示
%%		LeftChange		u8				当天剩余修改价格次数
%%      array(
%%              PlayerId    u64         % 雇佣的玩家id
%%              Name        string      % 雇佣的玩家名字%%  
%%              Count       u8          % 雇佣次数
%%              Income      u32         % 收益
%%           )


%%----------------------------报名------------------------------------------------
-define(SIGN_UP, 41004).
%% 协议号：41004

%% C >> S:
%%      Price           u32         单次被雇佣的价格

%% S >> C:
%%      RetCode         u8          0报名成功


%% -----------------------------领取收益-------------------------------------------
-define(GET_INCOME, 41005).
%% 协议号：41005

%% C >> S:
%%      无

%% S >> C:
%%      RetCode         u8          领取成功返回0
%%      Income          u32         领取的数量 绑银


%% ---------------------获取我的天将信息----------------------------------
-define(GET_MY_HIRE, 41006).
%% 协议号：41006

%% C >> S:
%%      无

%% S >> C:
%%      RetCode             u8          0 表示成功
%%      LeftTime            u8          剩余助战次数
%%      IsFight             u8          是否出战 1表示出战
%%      PlayerId            u64         被雇佣的玩家id
%%      PlayerName          string      名字
%%      PlayerLv            u16         等级
%%      Sex                 u8          性别
%%      Faction             u8
%%      Race                u8           
%%      PlayerBattlePower   u32         战力
%%      Weapon              u32         影响玩家外形的装备编号 武器、
%%      Headwear            u32         影响玩家外形的装备编号 头饰, 
%%      Clothes             u32         影响玩家外形的装备编号 服饰、
%%      Backwear            u32         影响玩家外形的装备编号 背饰 
%%		StrenLv 		  	u8 	   		玩家套装最低强化等级，如果没有套装则是0
%%      array(
%%              Id          u64         宠物id
%%              No          u32         宠物编号
%%              Name        string      雇佣的名字%
%%              Lv          u16         等级
%%              BattlePower u32         战力
%%              Weapon      u32         宠物武器
%%              EvolveLv    u8          宠物进化等级
%%				ParQuality  u8 			宠物品质
%%      		ParClothes  u32         宠物画皮
%%				Position 	u8			是否主宠：1表示主宠
%%           )
%%      MagicKey            u32         法宝编号


%% ---------------------出战天将----------------------------------
-define(FIGHT_MY_HIRE, 41007).
%% 协议号：41007

%% C >> S:
%%      无

%% S >> C:
%%      RetCode         u8  0 表示成功


%% ---------------------解雇天将----------------------------------
-define(FIRE_MY_HIRE, 41008).
%% 协议号：41008

%% C >> S:
%%      无

%% S >> C:
%%      RetCode         u8  0 表示成功


%% -----------------服务器主动通知客户端 我的天将 剩余助战次数 发生变化-----------------------
-define(NOTIFY_MY_HIRE_INFO_CHANGE, 41009).
%% 协议号：41009

%% C >> S:
%%      无

%% S >> C:
%%      LeftTime            u8          剩余助战次数


%% --------------------天将修改被雇佣的价格--------------------------
-define(HIRE_CHANGE_PRICE, 41010).
%% 协议号：41010

%% C >> S:
%%      Price               u32

%% S >> C:
%%      RetCode             u8
%%      NewPrice            u32
%%      LeftCount           u8   剩余可修改价格次数


%% ---------------------休息天将----------------------------------
-define(REST_MY_HIRE, 41011).
%% 协议号：41011

%% C >> S:
%%      无

%% S >> C:
%%      RetCode         u8  0 表示成功
