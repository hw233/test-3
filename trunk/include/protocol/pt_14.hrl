% ================ 玩家间信息 =================
% 分类号：14
% 描述：好友信息，黑名单信息


% ########### 好友列表 ##############
% 协议号：14000
% c >> s:
%     无
% s >> c:
%       arrary(
%           Id                  u64     记录号
%           PlayerId            u64     好友id
%           Online              u8      1表示在线，0表示不在线
%%          Lv                  u16      等级
%%          Race                u8      种族
%%          Faction             u8      门派
%%          Sex                 u8      性别
%%          BattlePower         u32     战斗力
%           Name                string  名字
%%          Intimacy            u32     好友度
%       )
%       arrary(
%           Id                  u64     记录号
%           PlayerId            u64     好友id
%           Online              u8      1表示在线，0表示不在线
%%          Lv                  u16      等级
%%          Race                u8      种族
%%          Faction             u8      门派
%%          Sex                 u8      性别
%%          BattlePower         u32     战斗力
%           Name                string  名字
%%          Intimacy            u32     好友度
%       )
%       arrary(
%           Id                  u64     记录号
%           PlayerId            u64     好友id
%           Online              u8      1表示在线，0表示不在线
%%          Lv                  u16      等级
%%          Race                u8      种族
%%          Faction             u8      门派
%%          Sex                 u8      性别
%%          BattlePower         u32     战斗力
%           Name                string  名字
%%          Intimacy            u32     好友度
%       )


% ########### 发送添加好友请求 ##############
% 协议号：14001
% c >> s:
%%      array(
%               Id                        u64 接收方用户ID
%             )

% s >> c:
%%     array(
%%          RetCode         u16 0表示成功   30 -- 对方不在线  3000 -- 好友人数达到上限 3006 -- 对方拒绝加为好友  3001 -- 对方已经是你的好友
%%          Id              u64 接收方用户ID
%%          )
    

% ########### 回应添加好友请求 ##############
% 协议号：14002
% c >> s:
%       Choice              u8  拒绝/接受请求 0 => 拒绝 1 => 接受
%%      array(
%           Id                  u64 发起者用户ID
%%           )

% s >> c:
%%      失败用998协议返回错误代码，成功直接返回14005
%%      


% ########### 删除好友 当好友被删除时，服务端也主动通过此协议通知玩家 ##############
% 协议号：14003
% c >> s:
%       Id          u64     记录号
% s >> c:
%       Id          u64     记录号


% ########### 添加黑名单 (暂时不做) ##############
% 协议号: 14004
% c >> s:
%       Id          u64     记录号
% s >> c:
%       RetCode     u8 
%       Id          u64     记录号
        

%% 服务器主动通知成功添加好友
%% 协议号：14005
%% s >> c:
%       Id                  u64     记录号
%       PlayerId            u64     好友id
%       Online              u8      1表示在线，0表示不在线
%%      Lv                  u16      等级
%%      Race                u8      种族
%%      Faction             u8      门派
%%      Sex                 u8      性别
%%      BattlePower         u32     战斗力
%       Name                string  名字


%% 服务器主动通知收到加好友请求
%% 协议号：14006
%% s >> c:
%     Id                  u64       发送方玩家ID
%%    Lv                  u16       等级
%%    Race                u8        种族
%%    Faction             u8        门派
%%    VipLv               u8        vip等级
%%    BattlePower         u32       战斗力
%     Name                string    发送方角色名


% ########### 移动好友到别的分组 （暂时没有这个功能）#############
% 协议号：14009
% c >> s:
%     int:32 记录号
%     int:16 移动到的分组序号
% s >> c:
%     int:16 
%         0 => 失败
%         1 => 成功

% ########### 查找角色 模糊搜索 ####################
% 协议号：14010
% c >> s:
%%      PageSize           u8       每页个数
%%      PageNum            u16      所在页码编号 从1开始
%       Name        string 角色名称
% s >> c:
%%      TotalPage          u16      总页数
%%      PageNum            u16      所在页码编号 从1开始
%       array(
%             PlayerId    u64 角色id
%             Lv          u16
%%            Race        u8      种族
%%            Faction     u8      门派
%%            Sex         u8      性别
%%            BattlePower u32     战斗力
%%            VipLv               u8        vip等级
%             Name        string 角色名字
%             )


%% 获取当天剩余申请添加好友的次数，当次数发送变化时，服务端主动通知
% 协议号：14011
% c >> s:
%       无
% s >> c:
%%      LeftCount       u8



% ########### 发送私聊 ##############
% 协议号:14012
% c >> s:
%     Id        u64         接受方用户ID
%     Msg       string      内容

% s >> c: %% 返回给发送方
%     Id        u64         接受方用户ID
%     Msg       string      内容


%% 推送 或 获取 离线消息
% 协议号:14013
% c >> s
%%		无

% s >> c:
%		array(
%     		Id        u64         发送用户ID
%     		Msg       string      内容
%     		Timestamp u32
%   		)


% ########### 好友上下线通知 ############
% 协议号：14030
% s >> c:
%       Action      u8   0表示下线 1 表示上线
%       PlayerId    u64 上线好友id


% ########### 最近联系人列表 (暂时没有要求这个功能) ############
% 协议号：14032
% s >> c:
%         array(
%           PlayerId            u64     好友id
%           Online              u8      1表示在线，0表示不在线
%%          Lv                  u16      等级
%%          Race                u8      种族
%%          Faction             u8      门派
%%          Sex                 u8      性别
%           Name                string  名字
%         )


        
% ########### 好友升级通知 （根据需要添加）############
% 协议号：14036
% s >> c:
%           PlayerId            u64     好友id
%%          Lv                  u16     等级


%% -----------------------------------------结拜相关协议--------------------------------------------

%% 发起结拜
% 协议号：14050
% c >> s:
%%		Type 			u8 		结拜类型  1 普通结拜，2，生死结拜
%% s >> c:
%%		RetCode 		u8 		0表示成功 1表示失败
%%		Type 			u8 		结拜类型  1 普通结拜，2，生死结拜
%%		array(
%%				Id 		u64
%%				Code 	u8 		1 已经有结拜关系 2 还没组队 3 不同意结拜  4 队长掉线了  5 队长金钱不足 6 不是队长 7 队员非在队在线状态 8 一个人不能结拜
%%			)

%% 发送结拜确认给所有队员
% 协议号：14051
% c >> s:
%%		无
%% s >> c:
%%		Type 			u8 		结拜类型  1 普通结拜，2，生死结拜

%% 队员回复是否结拜
% 协议号：14052
% c >> s:
%%		Type 			u8 		结拜类型  1 普通结拜，2，生死结拜
%%		Choice 			u8   	0否1是
%% s >> c:
%%		无

%% 删除结拜关系
% 协议号：14053
% c >> s:
%%		无
%% s >> c:
%%		RetCode 		u8 0 表示成功，其他通过998返回


%% 队长确认、修改称号前缀
% 协议号：14055
% c >> s:
%%		Choice 			u8   	是否使称号前缀唯一 0否1是
%		Prefix 			string  称号
%% s >> c:
%%		RetCode 		u8 		0表示成功 1表示前缀已经被占用 2 结拜关系已被解除了

%% 向全队广播队长确认了称号前缀
% 协议号：14056
% c >> s:
%		无
%% s >> c:
%%		Type 				u8 		结拜类型  0没有结拜，1 普通结拜，2，生死结拜
%%		Choice 				u8   	是否使称号前缀唯一 0否1是
%%		PreFreeCount 		u8 		剩余免费修改前缀次数 队长专用
%%		SufFreeCount 		u8 		剩余免费修改后缀次数
%%		Prefix 				string  当前称号前缀
%%		Suffix 				string  当前称号后缀
%%      SwornId 			u64      结拜id


%% 队员领取称号  队长修改称号时，队员修改也通过此协议修改
% 协议号：14057
% c >> s:
%		Suffix 			string  称号后缀
%% s >> c:
%%		RetCode 		u8  0表示成功，1表示后缀重复

%% 获取称号前缀信息
% 协议号：14058
% c >> s:
%		Param   u8
%% s >> c:
%%		Type 				u8 		结拜类型  0没有结拜，1 普通结拜，2，生死结拜
%%		Choice 				u8   	是否使称号前缀唯一 0否1是
%%		PreFreeCount 		u8 		剩余免费修改前缀次数 队长专用
%%		SufFreeCount 		u8 		剩余免费修改后缀次数
%%		Prefix 				string  当前称号前缀
%%		Suffix 				string  当前称号后缀
%%      Param   			u8 		 客户端用
%%      SwornId 			u64      结拜id


%% 通知组队同结拜成员等待队长修改前缀
% 协议号：14059
% c >> s:
%%		无
%% s >> c:
%%		无


%% -------------------------------------------好友度相关协议---------------------------------------------

% 协议号：14100
%% C >> S:
%%      PlayerId        u64          目标玩家id
%%      array(
%%              GoodsId         u64          花的id
%%              Count           u16          花的数量
%%          )
%% S >> C:
%%      GetIntimacy     u32          获得好友度
%%      PlayerId        u64          目标玩家id
%%      PlayerName      String       目标玩家名字

%% 服务端通知玩家之间的好友度变化
% 协议号：14101
%% S >> C:
%%      ObjPlayerId         u64
%%      CurIntimacy         u32          当前好友度



%% 赠送药品等道具

-define(PT_GIVE_GIFTS,  14102).

% 协议号：14102
%% C >> S:
%%      PlayerId        u64          目标玩家id
%%      array(
%%              GoodsId         u64          物品id
%%              Count           u16          物品数量
%%          )

%% S >> C:
%%      Code     u8          成功或者失败

%% 赠送药品等道具

-define(PT_ADD_ENEMY,  14103).

% 协议号：14102
%% C >> S:
%%      PlayerId        u64          目标玩家id
%%      array(
%%              GoodsId         u64          物品id
%%              Count           u16          物品数量
%%          )

%% S >> C:
%%      Code     u8          成功或者失败


-define(PT_CHANGE_NAME,  14037).

% 14037
% s >> c:
%           PlayerId            u64     好友id
%%          Name                 string      名字