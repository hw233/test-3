%%% 帮会相关协议
%%% 2013.9.25
%%% @author: zhangwq
%%% 分类号：40

%% pt: 表示protocol

%% 帮派职位（pos： 表示position ）
% -define(GUILD_POS_INVALID,          0).        % 无效职位（用于程序做非法判定）
% -define(GUILD_POS_CHIEF,            1).        % 帮主
% -define(GUILD_POS_COUNSELLOR,       2).        % 军师
% -define(GUILD_POS_SHAOZHANG,        3).        % 哨长
% -define(GUILD_POS_NORMAL_MEMBER,    4).        % 喽啰 普通成员


%%----------- 帮会创建 ------------
-define(PT_CREATE_GUILD, 40001).

%% 协议号：40001

%% C >> S:
%%     GuildName            string      帮派名称
%%     Brief                string      帮派宣言

%% S >> C: 
%%      RetCode             u8          创建成功返回0
%%      GuildId             u64         帮会ID
%%      GuildName           string


%%---------------申请解散帮会---------------
-define(PT_DISBAND_GUILD, 40002).
%% 协议号: 40002
%% C >> S:
%%      GuildId         u64    申请帮会的ID

%%S >> C:
%%      RetCode         u8


%%---------------申请加入帮会---------------
-define(PT_APPLY_JOIN_GUILD, 40003).

%% 协议号: 40003
%% C >> S:
%%      GuildId         u64    申请帮会的ID
%%		Index			u8	   0为一键申请,1为单次申请

%% S >> C:
%%      RetCode         u8     返回结果：0--成功


%%---------------审批处理本帮会申请人员---------------
-define(PT_HANDLE_APPLY, 40004).

%% 协议号: 40004
%% C >> S:
%%      PlayerId        int64       玩家ID，如果是批量操作统一发0
%%      Choise          u8          选择结果：0-拒绝，1-允许，2-全部拒绝，3-全部允许

%% S >> C:
%%      RetCode         u8          成功返回0
%%      Choise          u8          选择结果：0-拒绝，1-允许，2-全部拒绝，3-全部允许


%%---------------邀请加入帮派---------------
-define(PT_INVITE_JOIN_GUILD, 40005).

%% 协议号: 40005
%% C >> S:
%%      PlayerId        int64       邀请对象

%% S >> C:
%%      RetCode         u8    返回结果：0-成功


%%---------------回复帮会邀请---------------
-define(PT_REPLY_INVITE, 40006).

%% 协议号: 40006
%% C >> S:
%%      GuildId          u64    帮派ID
%%      Choise           u8     选择： 0-拒绝，1-同意

%% S >> C:
%%      RetCode          u8     返回结果：0-成功 表示已经加入帮派了


%%---------------开除帮会成员---------------
-define(PT_KICK_OUT_FROM_GUILD, 40007).

%% 协议号: 40007
%% C >> S:
%%      GuildId          u64    帮派ID
%%      PlayerId         u64  角色ID

%% S >> C:
%%      RetCode          u8   返回结果：0-成功
                                            

%%---------------退出帮派---------------
-define(PT_QUIT_GUILD, 40008).

%% 协议号: 40008
%% C >> S:
%%      GuildId           u64   帮派ID

%% S >> C:
%%      RetCode           u8   返回结果：0成功
                                              

%%---------------获取帮会列表---------------（此协议不用，用40017代替）------------
-define(PT_GET_GUILD_LIST, 40009).

%% 协议号: 40009
%% C >> S:
%%      PageSize           u8       帮会每页个数
%%      PageNum            u16      帮会所在页码编号 从1开始

%% S >> C:
%%      RetCode             u8      返回结果：0成功
%%      TotalPage           u16     帮会总页数
%%      PageNum             u16     帮会所在页码编号 从1开始
%%      array(
%%              GuildId     u64     帮会ID
%%              GuildName   string  帮会名称
%%              Lv          u16     帮会等级
%%              ChiefId     u64   帮主ID
%%              ChiefName   string  帮主名称
%%              Rank        u16     帮会排名
%%              CurMbCount  u16     当前帮会人数
%%              MbCapacity  u16     帮会人数容纳上限
%%              Brief       string  帮会简介
%%            )                                               


%%---------------获取帮会成员列表---------------
-define(PT_GET_GUILD_MB_LIST, 40010).

%% 协议号: 40010
%% C >> S:
%%      GuildId             u64     帮派ID
%%      PageSize            u8      帮会成员每页个数
%%      PageNum             u16     帮会成员所在页码编号 从1开始
%%      SortType            u8      排序类型：10/11--> Position; 20/21-->Contri; 30/31-->Lv; 40/41-->BattlePower;  50/51-->VipLv; 60/61--> Faction; 70/71-->Race;80/81 -->Online
                                    %% 10/11 分别表示按降序和升序排序，其他的表示升序和降序
%% S >> C:
%%      GuildId             u64     帮会ID
%%      MemberCount         u32     帮会总人数
%%      OnlineCount         u32     帮会在线人数
%%      TotalPage           u16     帮会成员总页数
%%      PageNum             u16     帮会成员所在页码编号 从1开始
%%      array(
%%              PlayerId    int64                   玩家ID
%%              Name        string                  玩家名称
%%              Lv          u16                     玩家等级
%%              Sex         u8                      性别
%%              Race        u8                      玩家种族
%%              Faction     u8                      玩家门派
%%              Contri      u32                     贡献度
%%              title_id    u8                      帮派称号id
%%              Position    u8                      官职    见文件头部
%%              BattlePower u32                     战斗力
%%              Online      u8                      是否在线 1--在线，0--不在线
%%              VipLv       u8                      vip等级
%%           )


%%---------------获取帮会的申请列表---------------
-define(PT_GET_REQ_JOIN_LIST, 40011).

%% 协议号: 40011
%% C >> S:
%%      GuildId             u64     帮派ID
%%      PageSize            u8      帮会申请列表每页个数
%%      PageNum             u16     帮会所在页码编号 从1开始

%% S >> C:
%%      RetCode             u8      返回结果：0-成功
%%      TotalPage           u16     帮会总页数
%%      PageNum             u16     帮会所在页码编号 从1开始
%%      array(
%%              PlayerId    int64           玩家ID
%%              Name        string          玩家姓名
%%              Lv          u16             玩家等级
%%              Sex         u8              玩家性别
%%              Race        u8              玩家种族
%%              Faction     u8              玩家门派
%%              BattlePower u32             战斗力
%%              VipLv       u8              vip等级
%%              Time        u32             入帮申请时间
%%           )


%%---------------帮会基本信息---------------
-define(PT_BASE_GUILD_INFO, 40012).

%% 协议号: 40012
%% C >> S:
%%      GuildId              u64            帮会ID

%% S >> C:
%%      GuildId              u64            帮会ID
%%      GuildName            string         帮会名称
%%      Lv                   u16            帮会等级
%%      Notice               string         帮会公告(简述)
%%      ChiefId              int64          帮主ID
%%      ChiefName            string         帮主名称
%%      Rank                 u16            帮会排名
%%      CurMbCount           u16            当前帮会人数
%%      MbCapacity           u16            帮会人数容纳上限
%%      Contri               u32            帮会贡献
%%      CurProsper           u32            当前繁荣度
%%      MaxProsper           u32            当前等级帮派繁荣度上限
%%      Fund                 u32            资金
%%      State                u8             状态 % 帮派状态 0 --> 正常状态  1-->非活跃状态  2-->冻结状态 
%%      array(                              %% 当天贡献值前三的玩家名字 当天贡献度  是否vip 当vipLv是0表示非vip
%%              PlayerName   string
%%              ContriToday  u32
%%              VipLv        u8        
%%          )
%%      Liveness             u32            当日活跃度
%%      LivenesSD            u32            当日标准活跃度
%%		BattlePower 		 u32 			帮派战力
%%      Type     		     u8             1无需审核入帮,2需要审核入帮,3禁止玩家加入


%%---------------修改帮派宗旨(公告)---------------
-define(MODIFY_GUILD_TENET, 40013).

%% 协议号: 40013
%% C >> S:
%%      GuildId             u64             帮会ID
%%      Tenet               string          帮会宗旨

%% S >> C:
%%      RetCode             u8              返回结果：0-成功
       

%%---------------帮会授予官职---------------
-define(APPOINT_GUILD_POSITION, 40014).

%% 协议号: 40014
%% C >> S:
%%      PlayerId             int64          玩家ID
%%      Position             u8             授予的官职

%% S >> C:
%%      RetCode              u8  返回结果：0-成功
%%      PlayerId             int64          玩家ID
%%      Position             u8             授予的官职
                                              

%%------------------ 被邀请人收到加入帮派的邀请 服务器主动发给玩家------------
-define(PT_GOT_INVITE,  40015).

%% 协议号:40015
%% s >> c:
%%     FromPlayerId       int64   发邀请的玩家id
%%     FromPlayerName     string  发邀请的玩家名字
%%     GuildId            u64     帮派ID
%%     GuildName          string  帮派名字
%%     Lv                 u16     帮会等级


%%---------------个人帮会信息---------------
-define(PT_GET_PLAYER_GUILD_INFO, 40016).

%% 协议号：40016
%% C >> S:
%%      无

%% S >> C:
%%      Position             u8             授予的官职
%%      LeftContri           u32            当前剩余贡献度
%%      TotalContri          u32            累计贡献度


%%---------------搜索帮会列表---------------
-define(PT_SEARCH_GUILD_LIST, 40017).

%% 协议号: 40017
%% C >> S:
%%      PageSize           u8       帮会每页个数
%%      PageNum            u16      帮会所在页码编号 从1开始
%%      NotFull            u8       1表示显示未满帮派，0表示没有限制
%%      SearchName         string   名字匹配（没有则为空字符串）

%% S >> C:
%%      RetCode             u8      返回结果：0成功
%%      TotalPage           u16     帮会总页数
%%      PageNum             u16     帮会所在页码编号 从1开始
%%      array(
%%              GuildId     u64     帮会ID
%%              GuildName   string  帮会名称
%%              Lv          u16     帮会等级
%%              ChiefId     int64   帮主ID
%%              ChiefName   string  帮主名称
%%              Rank        u16     帮会排名
%%              CurMbCount  u16     当前帮会人数
%%              MbCapacity  u16     帮会人数容纳上限
%%              Brief       string  帮会简介
%%              HasApplied  u8      获取列表的玩家是否已经申请加入该帮派 0 表示没有申请，1表示已经申请
%%              VipLv       u8      帮主vip等级
%%            )    


%%---------------获取帮会各个职位当前人数和最大人数---------------
-define(PT_GET_GUILD_POS_INFO, 40018).

%% 协议号: 40018
%% C >> S:
%%      GuildId              u64            帮会ID

%% S >> C:
%%      GuildId              u64            帮会ID
%%      array(
%%              Position     u8             官职 详见 guild.hrl 宏定义
%%              CurNum       u8             该职位当前人数
%%              MaxNum       u8             该职位允许的人数
%%          )


%% ------------加入帮派 通知所有帮派成员，包括帮主-------------------
-define(PT_NOTIFY_JOINED_GUILD, 40019).

%% 协议号: 40019
%% C >> S:
%%      无
%% S >> C:
%%      GuildId         u64
%%      PlayerName      string    加入的玩家名字
%%      GuildName       string    帮派名字


%% ------------------解散帮派，通知所有帮派成员，包括帮主-----------------
-define(PT_NOTIFY_GUILD_DISBANDED, 40020).      
%% 协议号: 40020
%% C >> S:
%%      无
%% S >> C:
%%      GuildId         u64
%%      PlayerName      string    寨主名字
%%      GuildName       string    帮派名字

%% -----------------任命，通知所有帮派成员----------------
% 【职位】【操作者名】将【被操作者名】从【前职位】提升到【现职位】
% 【职位】【操作者名】将【被操作者名】从【前职位】降职到【现职位】
-define(PT_NOTIFY_MEMBER_POS_CHANGE, 40021).

%% 协议号: 40021
%% C >> S:
%%      无
%% S >> C:
%%      OpPos           u8        操作者职位
%%      OpName          string    操作者名字
%%      OpedName        string    被操作者名字
%%      OpedPrePos      u8        被操作者前职位
%%      OpedNowPos      u8        被操作者现在职位


%% ------------退出帮派 通知所有帮派成员，包括帮主 不包括主动退出的成员 -------------------
-define(PT_NOTIFY_QUIT_GUILD, 40022).

%% 协议号: 40022
%% C >> S:
%%      无
%% S >> C:
%%      GuildId         u64
%%      PlayerName      string    退出的玩家名字
%%      GuildName       string    帮派名字


%% ------------踢出帮派 通知所有帮派成员，包括帮主 -------------------
-define(PT_NOTIFY_KICK_OUT_GUILD, 40023).

%% 协议号: 40023
%% C >> S:
%%      无
%% S >> C:
%%      GuildId         u64
%%      OpPos           u8        操作者职位
%%      OpName          string    操作者名字
%%      OpedName        string    被操作者名字


%%-----------------------查询自己的帮派工资-----------------------------
-define(PT_QUERY_GUILD_PAY, 40024).

%% 协议号: 40024
%% C >> S:
%%      无
%% S >> C:
%%      array(
%%            Type      u8  1,2,3,4 分别表示：基本工资, 职位薪资, 贡献度薪资, 贡献度排行薪资
%%            State     u8  1已经领取,0还没有领取
%%            Count     u32 工资数量
%%            )


%%-----------------------领取自己的帮派工资-----------------------------
-define(PT_GET_GUILD_PAY, 40025).

%% 协议号: 40025
%% C >> S:
%%      Type      u8  1,2,3,4 分别表示：基本工资, 职位薪资, 贡献度薪资, 贡献度排行薪资
%% S >> C:
%%      RetCode   u8  0-->成功返回0
%%      Type      u8  1,2,3,4 分别表示：基本工资, 职位薪资, 贡献度薪资, 贡献度排行薪资


%%----------- 通知客户端：更新帮派一个或多个信息 ------------
-define(PT_NOTIFY_GUILD_INFO_CHANGE,  40026).

%% 协议号：40026
%% s >> c:
%%      array(
%%          Key        u8   信息代号  1--帮派等级
%%          NewValue   u32  当前的新值
%%          )


% % =========================
% % 帮派每一层副本结束发送客户端的相关信息
-define(PT_GUILD_NOTIFY_DUNGEON_RET, 40027).
% % 协议号：40027
% S >> C:
%       WinState        u8          0 表示失败，1表示成功
%       array(                                奖励
%           GoodsId     u64
%           GoodsNo     u32
%           GoodsNum    u32
%           GoodsQua    u8
%           BindState   u8
%           )


%% 查询副本内界面信息
-define(PT_GUILD_GET_DUNGEON_INFO, 40028).
% % 协议号：40028
%% C >> S:
%%      无
%% S >> C:
%%      Floor          u16      当前层数
%%      LeftTime       u32      通关剩余时间，单位是s
%%      CurPoint       u32      当前总副本点数
%%      NeedPoint      u32      通关需要总副本点数  当前进度 = CurPoint / NeedPoint
%%      Collect        u32      当前资源采集数
%%      KillMon        u32      当前杀怪数


%% 帮派副本进入
-define(PT_GUILD_DUNGEON_ENTER, 40029).
% % 协议号：40029
%% C >> S:
%%      无
%% S >> C:
%%      RetCode  成功返回0，失败通过998返回
%%		GuildLv 	  u8


%% 帮派宴会加菜
-define(PT_GUILD_ADD_DISHES, 40030).
% % 协议号：40030
%% C >> S:
%%      DishesNo        u8      菜的编号

%% S >> C:
%%      RetCode  u8 成功返回0，失败通过998返回

%% 推送帮派加菜信息变化
-define(PT_GUILD_GET_DISHES, 40060).
% % 协议号：40060
%% C >> S:
%% S >> C:
%%      array(
%              No    u32   加菜编号
%%            )

%% 玩家主动退出帮派副本  此协议没用，现在退出副本用退出普通副本协议
-define(PT_GUILD_DUNGEON_QUIT, 40031).
% % 协议号：40031
%% C >> S:
%%      无
%% S >> C:
%%      RetCode  u8 成功返回0，失败通过998返回


%% 玩家在帮派副本采集资源
-define(PT_GUILD_DUNGEON_COLLECT, 40032).
% % 协议号：40032
%% C >> S:
%%      NpcId    u32
%% S >> C:
%%      RetCode  u8 成功返回0，失败通过998返回


%%-----------------修炼-----------------------------------

-define(PT_GUILD_CULTIVATE, 40033).

%% 协议号:40033
%% c >> s:
%%      ObjInfoCode     u8          属性代号 根据 obj_info_code.hrl 文件
%%      Count           u8          修炼次数
%%      Type            u8          1表示使用银子和帮贡；2表示使用人物经验和帮贡

%% s >> c:
%%      array(
%%             RetCode         u16  % 0--成功，1--成功暴击  其他如： 见prompt_msg_code.hrl
%              AddCultivate    u32   本次增加的值
%%            )
%%      Cultivate              u32  最后的修炼值
%%      CultivateLv            u16  最后的修炼等级
%%      ObjInfoCode            u8   属性代号 根据 obj_info_code.hrl 文件
%%      Type            u8          1表示使用银子和帮贡；2表示使用人物经验和帮贡


%% 使用神功丸
-define(PT_GUILD_USE_GOODS, 40034).

%% 协议号:40034
%% c >> s:
%%      ObjInfoCode     u8          属性代号 根据 obj_info_code.hrl 文件
%%      GoodsNo         u32         物品编号
%%      Count           u8          数量

%% s >> c:
%%      Cultivate       u32  最后的修炼值
%%      CultivateLv     u16  最后的修炼等级
%%      ObjInfoCode     u8   属性代号 根据 obj_info_code.hrl 文件


-define(PT_GUILD_DONATE, 40035).
%% 协议号:40035
%% c >> s:
%%      Contri          u32          帮派贡献度数量

%% s >> c:
%%      Contri          u32          帮派贡献度数量
%%      AddProsper      u32          帮派获得XXXX点繁荣度


%% 获取点修信息
-define(PT_GUILD_GET_CULTIVATE_INFO, 40036).
%% 协议号:40036
%% c >> s:
%%      无

%% s >> c:
%%      GuildLv         u8           所在帮派的等级
%%      Contri          u32          玩家可用贡献度数量
%%      array(
%%            ObjInfoCode     u8          属性代号 根据 obj_info_code.hrl 文件
%%            Lv              u8          该属性点修等级
%%            Value           u32         该属性点修值
%%          )


%% 获取捐献信息
-define(PT_GUILD_GET_DONATE_INFO, 40037).
%% 协议号:40037
%% c >> s:
%%      无

%% s >> c:
%%      GuildLv         u8                  所在帮派的等级
%%      Contri          u32                 玩家可用贡献度数量
%%      Prosper         u32                 帮派繁荣度
%%		Position 		u8 					玩家的帮派职位
%%      DonateToday     u32                 玩家当天捐献的数量
%%      array(                              %% 捐献排名信息
%%            Name     string               玩家名字
%%            Value    u32                  捐献的银子数量
%%          )


%% 服务端通知大当家和军师有人申请加入帮派，收到此信息后，如果玩家点击这个消息则请求帮派申请列表信息
-define(PT_GUILD_NOTIFY_PLAYER_APPLY, 40038).
%% 协议号:40038
%% c >> s:
%%      无
%% s >> c:
%%		无

%% 帮派战报名
-define(PT_GUILD_BID_FOR_BATTLE, 40039).
%% 协议号:40039
%% c >> s:
%%      Money       u32
%% s >> c:
%%      RetCode     u8   0表示成功，其他通过998协议返回

%% 获取成员投标帮派战列表
-define(PM_GUILD_GET_BID_LIST, 40040).
%% 协议号:40040
%% c >> s:
%%      无
%% s >> c:
%%      TotalMoney              u32         总投标价格
%%      MinNeedMoney            u32         中标至少投标值（金钱） 上一次比赛第四名帮派总出价的一半 
%%      array(
%%          PlayerId            u64
%%          Pos                 u8          职位
%%          Money               u32         总投标金额
%%          Name                string      玩家名字
%%      )

%% 获取帮派争夺站分组规则
-define(PM_GUILD_BATTLE_GROUP, 40041).
%% 协议号：40041
%% C >> S:
%%      无
%% S >> C:
%%      Round               u8          下场比赛轮数（总共4轮）当处于报名阶段则为0
%%      array(
%%              Round       u8
%%              StartTime   u32         开始时间戳
%%          )
%%      FirstGuildName      string      上届冠军
%%      array(
%%          Slot            u8          赛场格子编号
%%          GuildId         u64         帮派id   如果该赛场没有帮派参加，则为0
%%          GuildName       string      帮派名字
%%      )

%%签到 帮派争夺战签到即进入：帮派战准备区
-define(PM_GUILD_SIGN_IN_FOR_GB, 40042).
%% 协议号:40042
%% c >> s:
%%      无
%% s >> c:
%%      RetCode     u8   0表示成功，其他通过998协议返回

%% 获取 在 帮派争夺战准备副本里面自己的信息，进入时，玩家自己请求，有变化时，服务端推送
-define(PM_GUILD_GET_INFO_BEFORE_GB, 40043).
%% 协议号:40043
%% c >> s:
%%      无
%% s >> c:
%%      CurPhyPower     u32     当前体力
%%      AllPhyPower     u32     总体力
%%      CurPlayer       u32     当前到场人数
%%      StartTime       u32     开始时间戳


%% 获取 在 帮派争夺战战斗副本里面自己的信息，进入时，玩家自己请求，有变化时，服务端推送
-define(PM_GUILD_GET_INFO_IN_GB, 40044).
%% 协议号:40044
%% c >> s:
%%      无
%% s >> c:
%%      CurPhyPower     u32     当前体力
%%      AllPhyPower     u32     总体力
%%      SelfPlayer      u32     本方人数
%%      OtherPlayer     u32     对方人数
%%      LeftTime        u32     剩余时间（单位s）
%%      OtherGuildName  string  对方帮派名字


% % 帮派战结束发送客户端的相关信息
-define(PT_GUILD_NOTIFY_GB_RET, 40045).
% % 协议号：40045
% S >> C:
%       WinState                  u8          0 表示失败，1表示成功
%       array(                                奖励
%           GoodsId     u64
%           GoodsNo     u32
%           GoodsNum    u32
%           GoodsQua    u8
%           )


%% 在帮派争夺战中向其他玩家发起挑战
-define(PT_GUILD_START_WAR_PK, 40046).
%% 协议号：40046
%% C >> S:
%%      ObjPlayerId
%% S >> C:
%%      无

%% 退出：帮派战准备区
-define(PM_GUILD_QUIT_PRE_WAR, 40047).
%% 协议号:40047
%% c >> s:
%%      无
%% s >> c:
%%      RetCode     u8   0表示成功，其他通过998协议返回


%% 获取当前是否能够报名帮派争霸赛
-define(PM_GUILD_QRY_SIGE_IN_STATE, 40048).
%% 协议号:40048
%% c >> s:
%%      无
%% s >> c:
%%      CanSignIn       u8          1表示可以报名，其他不可以报名


%% 退出：帮派战战斗区
-define(PM_GUILD_QUIT_WAR, 40049).
%% 协议号:40049
%% c >> s:
%%      无
%% s >> c:
%%      RetCode     u8   0表示成功，其他通过998协议返回

%% 服务端通知 每个参赛成员 比赛结果
-define(PM_GUILD_WAR_RET, 40050).
%% 协议号:40050
%% c >> s:
%%      无
%% s >> c:
%%      RetCode     u8   0表示胜利，1表示失败


%% --------------- 修改帮派名字 -------------------------
-define(PT_MODIFY_GUILD_NAME,  40051).

%% 协议号:40051
%% c >> s:
%%      GoodsId     u64      消耗的物品id
%%      Name        string   名字

%% s >> c:
%%      PT_NOTIFY_PLAYER_AOI_INFO_CHANGE2 (12018协议)

%% --------------- 查看帮派洗点价格 -------------------------
-define(PT_GUILD_GET_WASH_CONS, 40052).
%% 协议号:40052
%% c >> s:

%% s >> c:
%%      NeedGameMoney          u32          需要的金额

%% --------------- 帮派点修洗点 -------------------------
-define(PT_GUILD_DO_WASH, 40053).
%% 协议号:40053
%% c >> s:

%% s >> c:
%%      RetCode          u8          0表示成功，1表示失败



%% --------------- 帮派技能升级 -------------------------
-define(PT_GUILD_SKILL_LEVEL_UP, 40054).
%% 协议号:40054
%% c >> s:
%%      No     			u32         技能编号  （0：一键升级 | 技能编号）

%% s >> c:
%%      No     u32
%%      Lv     u32     

%% 获取技能信息
-define(PT_GUILD_GET_ALL_SKILL, 40055).
%% 协议号:40055
%% c >> s:
%%      无

%% s >> c:
%%      array(
%%            No     u32          
%%            Lv     u32          
%%          )

%% --------------- 帮派技能使用 -------------------------
-define(PT_GUILD_SKILL_USE, 40056).
%% 协议号:40056
%% c >> s:
%%      No     			u32         技能编号

%% s >> c:
%%      No     		u32
%%      GoodsId     u64   


%% 获取技能信息
-define(PT_GET_ALL_CULTIVATE_SKILL, 40057).
%% 协议号:40057
%% c >> s:
%%      无

%% s >> c:
%%      array(
%%            No     u32          
%%            Lv     u32         
%%			  Point  u32 
%%          )


%% --------------- 点修技能升级 -------------------------
-define(PT_CULTIVATE_SKILL_LEVEL_UP, 40058).
%% 协议号:40054
%% c >> s:
%%      No     			u32         技能编号
%% 		Count           u8

%% s >> c:
%%      No     u32
%%      Lv     u32    
%%      Point  u32  

%% --------------- 帮派技能升级 -------------------------
-define(PT_GUILD_CULTIVATE_USE_GOODS, 40059).
%% 协议号:40054
%% c >> s:
%%      No     			u32         技能编号
%%      Count     		u32         使用几个

%% s >> c:
%%      No     u32
%%      Lv     u32   
%%      Point  u32  

%% --------------- 帮派入帮控制 -------------------------
-define(PT_GUILD_JOIN_CONTROLLER, 40061).
%% 协议号:40061
%% c >> s:
%%      GuildId     	u64         帮派Id
%%      Type     		u8         1无需审核入帮,2需要审核入帮,3禁止玩家加入

%% s >> c:
%%      RetCode         u8         成功返回0， 失败发998

%%-----------查询可以购买的帮派商店动态物品列表---------
-define(PT_GUILD_QUERY_DYNAMIC_GOODS_IN_SHOP, 40070).

%% 协议号: 40070
%% C >> S:
%%      GuildId     		 u64        帮派Id
%% s >> c:
%%      array(
%%            Id             u16    商品表id
%%            NumberLimit    u32    可购买该物品的个数
%%           )

%% --------------- 帮派商店购买 -------------------------
-define(PT_GUILD_SHOP_BUY, 40071).
%% 协议号:40071
%% c >> s:
%%      Guild     			u64        帮派Id
%%      ShopId     		    u16        购买物品的编号
%%      Count     			u32        购买物品的数量
%% s >> c:
%%      RetCode         	u8         成功返回0， 失败发998
%%      ShopId              u16        购买物品的编号
%%      NumberLimit         u32        剩余可购买数量

%% --------------- 完成主线任务的加入帮派 -------------------------
-define(PT_JOIN_GUILD_ZHUXIAN_TASK, 40080).
%% 协议号:40080
%% c >> s:
%%收到协议完成任务
