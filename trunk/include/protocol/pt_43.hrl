%% =========================================================
%% 43 跨服相关
%% =========================================================


% =========================
% 切换跨服/回到原服
-define(PT_CROSS_SERVER, 43001).
% 协议号：43001
% C >> S:
%   type 			 u8		 0:原服 | 1:跨服
% S >> C:
%   type 			 u8		 0:原服 | 1:跨服

% ========================= 跨服3V3 =========================
% 全服3V3排行榜
-define(PT_PVP_CROSS_PLAYER_RANK, 43002).
% 协议号：43002
% C >> S:
%       type            u8		 0:原服 | 1:跨服
%       page            u8       1:返回1-10名，2:返回11-20，3:返回21-30
% S >> C:
%     array(
%     	  playerId      u64     玩家ID
%         name          string  名字
%         rank          u32     排名
%         dan           u8      段位
%         score         u32     分数
%     )

% 个人3V3数据
-define(PT_CROSS_PVP_OTHERS_DATA, 43003).
% C >> S:
%     playerId      u64     玩家ID
% S >> C:
%     playerId      u64     玩家ID
%     faction    	u8          门派
%     sex           u8          性别（1：男，2：女）
%     race          u8      种族
%     name          string      名字
%     win           u32     胜场数
%     lose          u32     负场数
%     escape        u32     逃跑数
%     server_id     u32     服务器ID
%     dan           u8      段位
%     score         u32     分数

% 玩家自己数据
-define(PT_MINE_PVP_DATA, 43004).
% C >> S:
%     无(结合43002发送)
% S >> C:
%     win           u32     胜场数
%     lose          u32     负场数
%     escape        u32     逃跑数
%     dan           u8      段位
%     score         u32     分数
%     rank          u32     排名
%     daytimes      u8      每日参加场数
%     dayreward     u8      每日参与领取奖励

% 创建房间 or 房间修改
-define(PT_PVP_CREATE_ROOM, 43005).
% C >> S:
% S >> C:
%       CaptainId                   u64		    队伍唯一id(这里是用队长ID)
%       array (
%           PlayerId				u64		    房间成员id
%           PlayerName              string      名字
%           Faction    		        u8          门派
%           Sex                     u8          性别（1：男，2：女）
%           Lv                      u16          人物等级
%        	Race                    u8      种族
%        	Weapon                  u32     武器
%        	BackWear                u32     背部装饰
%			StrenLv 		        u8 	    玩家套装最低强化等级，如果没有套装则是0
%		 	Headwear                u32      头饰编号
%		 	Clothes                 u32      服饰编号
%           MagicKey                u32      法宝编号
%           Dan                     u8          段位
%       )
%       troop                       u32         阵法


% 邀请他人加入房间（只能邀请好友和同帮派成员）
% 客户端可以通过43034获取在线好友和在线同帮派成员列表
-define(PT_PVP_3V3_INVITE_TEAMATES,  43006).
%% 协议号：43006
%% c >> s:
%%      ObjPlayerId     int64  被邀请人id

%% s >> c:
%%      RetCode      	u8   发出邀请成功则返回0
%%      ObjPlayerId     int64  被邀请人id

%% 被邀请人收到入队邀请 服务器主动发给队员
-define(PT_PVP_3V3_TEAMATES_GOT_INVITE,  43007).

%% 协议号:43007
%% s >> c:
%%     FromPlayerId        u64     发邀请的玩家id
%%     FromPlayerName      string  发邀请的玩家名字
%%     FromPlayerLv        u16     发邀请的玩家等级
%%  被邀请人同意发43004


%% 踢出房间(队长权限)
-define(PT_PVP_KICK_OUT_TM, 43008).

%% 协议号：43008
%% c >> s:
%%      ObjPlayerId         int64   被踢队员id
%% s >> c:
%%      ObjPlayerId         int64   被踢队员id

%% 玩家主动离队，通知队伍成员：有人离队了（服务端主动通知）
-define(PT_TM_NOTIFY_TEAMATE_OUT_ROOM, 43009).

%% 协议号: 43009
%% c >> s:
%% s >> c:
%%      ObjPlayerId         int64   主动离队id
%% 通知房间成员：有人离线了（服务端主动通知）43009

%% 提升队员为队长（队长权限），需要被提升的队员确认，提升成功后原队长变为普通队员
-define(PT_PVP_PROMOTE_TEAMATE_FOR_CAPTAIN, 43010).

%% 协议号：43010
%% c >> s:
%%     ObjPlayerId   	int64  提升目标id
%% s >> c:
%%     RetCode    		u8   发送提升请求成功返回0

%% 被提升队员确认或拒绝被提升为队长
-define(PT_PVP_HANDLE_PROMOTE_PVP_CAPTAIN, 43011).

%% 协议号：43011
%% c >> s:
%% 		Action 		u8      0为同意，1为拒绝
%%		CaptainId 	u64     发送请求的房主id

%% s >> c: 提升成功后队伍的所有人会收到队长更改的通知43012，如果拒绝则发送 43013

%% 通知队伍：队长换了（服务端主动通知）
-define(PT_PVP_NOTIFY_CAPTAIN_CHANGED, 43012).

%% 协议号：43012
%% s >> c:
%%     	NewLeaderId         int64	  新队长id

% 服务器通知队长：XX拒绝了你的提升队长申请
-define(PT_PVP_NOTIFY_CAPTAIN_RESULT, 43013).
%% 协议号：43013
%% s >> c:
%%		Result 			u8    	0表示同意，1表示拒绝 目前只有拒绝
%%      Name 			string 	发起同意或拒绝动作的玩家名字

%% 队员收到信息：现任队长提升你为新队长，服务器主动发给队员
-define(PT_TM_PROMOTE_YOU_FOR_CAPTAIN, 43014).

%% c >> s:
%%		无

%% s >> c:
%%		CaptainId 			u64

% 显示所有服务器房间列表(点击组队匹配)
-define(PT_PVP_CROSS_ROOMS, 43016).
% 协议号：43016
% c >> S:
%       page            u8       1:返回1-10名，2:返回11-20，3:返回21-30(根据房间创建时间排序)
% s >> c:
%     array(
%           captain_id      u64         队长ID(也是房间ID)
%       	Faction    		u8          门派
%       	Sex             u8          性别（1：男，2：女）
%        	Race            u8          种族
%           name            string      名字
%           dan             u8          段位
%           num             u8          房间人数
%     )

% 申请加入房间
-define(PT_APPLY_JOIN_IN_ROOM, 43017).
%% 协议号： 43017
%% c >> s:
%%		captain_id      u64         队长ID(也是房间ID)

%% s >> c:
%% 		RetCode 		u8		    申请成功返回0

% 队长接收申请
-define(PT_PVP_QRY_APPLY_LIST ,43018).
%% 协议号：43018
%% c >> s:
%% s >> c:
%%		array(
%%           playerId      u64         玩家ID
%%           name          string      名字
%%           dan           u8          段位
%%           serverId      u32         服务器ID
%%      )

% 允许加入房间
-define(PT_ALLOW_JOIN_IN_ROOM, 43019).
%% 协议号：43019
%% c >> s:
%%		PlayerId 		        u64	    允许对象（玩家）的id
%%      serverId      u32         服务器ID

%% s >> c:
%%		向全队发送43005协议, 给队长发43018协议

% 房主拒绝玩家加入房间
-define(PT_REJECT_JOIN_IN_ROOM, 43020).
%% 协议号：43020
%% c >> s:
%%		PlayerId 		            u64	    拒绝对象（玩家）的id

%% s >> c:
%%     CaptainName                  string      拒绝人名字

% 玩家拒绝或同意房主入房邀请,该协议已无用
-define(PT_PVP_3V3_HANDLE_INVITE, 43021).

%% 协议号：43021
%% c >> s:
%%		Action			u8         同意还是拒绝 0表示拒绝，1表示同意
%% 		captain_id      u64         队长ID(也是房间ID)
%% s >> c:
%%		RetCode 		u8
%% 		captain_id      u64         队长ID(也是房间ID)
%% 如果玩家同意，向全队发送43005、43037协议, 给队长发43018协议

%% 服务器通知队长邀请玩家入房结果
-define(PT_PVP_NOTIFY_CAPTAIN_INVITE_RESULT, 43022).

%% 协议号：43022
%% c >> s:
%%		无
%% s >> c:
%%		Result 			u8     0表示拒绝，1表示同意
%% 		Name 			string 玩家名

%% 队长使用阵法
-define(PT_PVP_CAPTAIN_USE_ZF, 43023).
%% 协议号：43023
%% c >> s:
%%      No              u32
%% s >> c:                  使用成功返回当前的阵法编号，失败则通过998返回错误码
%%      No              u32

% 开始匹配，队长开始匹配，广播给全部成员
-define(PT_PVP_MATCHING, 43030).
%% 协议号：43030
%% c >> s:
%%      type                     u8      0: 单人匹配； 1：多人匹配
%% s >> c:
%%      RetCode                  u8      成功返回0

% 取消匹配，队长取消匹配，广播给全部成员
-define(PT_PVP_CANCLE_MATCHING, 43031).
%% 协议号：43031
%% c >> s:
%%      type                     u8      0: 单人匹配； 1：多人匹配
%% s >> c:
%%      RetCode                  u8      成功返回0

-define(PT_ROOM_CHAT, 43032).
% ########### 房间聊天 ##############
% 协议号:43032
% c >> s:
%     CaptainId u64         房间ID(队长ID)
%     Msg       string      内容
% s >> c:
%     Id        u64         用户ID
%     Msg       string      内容
%     vip       u8          vip
%     name      string      名字
%     Race      u8          种族
%     Sex       u8          性别
%     ServerId  u32         服务器ID
%     Dan       u8          玩家段位

-define(PT_3V3_PVP_GET_DAYREWARD, 43033).
% ########### 获取每日参与奖励 ##############
% 协议号:43033
% c >> s:
%       Type            u8         1、5、10
% s >> c:
%       直通43004发送

-define(PT_PVP_CROSS_GET_ONLINE_RELA_PLAYERS, 43034).
%% 协议号：43034
%%	C >> S:
%%      PageSize           u8       每页显示个数
%%      PageIndex          u16      页码编号 从1开始

%% S >> C:
%%      TotalPage           u16     总页数
%%      PageIndex           u16     页码编号 从1开始
%%		array(
%%				PlayerId 	u64
%%              Race        u8          种族
%%              Sex         u8          性别
%%              Faction     u8          门派
%%				Rela 		u8      1 好友；2 同帮派好基友
%%				Name  		string
%%              Lv          u16
%%              Dan         u8
%%			)

-define(PT_PVP_CROSS_ACCEPT_INVITE, 43035).
%% 协议号：43035
% c >> s:
%       CaptainId       u64         房间ID
% S >> C:
%       RetCode          u8         成功返回0
%       通过43005发送房间协议

-define(PT_PVP_CROSS_REFUSE_INVITE, 43036).
%% 协议号：43036
% c >> s:
%       CaptainId        u64            房间ID
% S >> C:
%       name             string         名字
%       RetCode          u8             拒绝返回1

-define(PT_PVP_CROSS_PLAYER_PREPARE, 43037).
%% 协议号：43037
% c >> s:
%   Type                u8               0 准备、 1 未准备
% S >> C:
%   房间成员的准备状态
%	array{
%		PlayerId 		u64			     准备的ID
%		action			u8				 0：不在房间  1：在房间    2、准备
%	}

-define(PT_PVP_CROSS_UPDATE_TEAM, 43038).
%% 协议号：43038
% c >> s:
%   captain_id          u64              队长ID
% S >> C:
%       推送对应43005

% 暂时解决方案
-define(PT_PVP_CROSS_REMOVE_INVITE_LIMIT, 43039).
%% 协议号：43039
% c >> s:
%   captain_id          u64              队长ID
% S >> C:
%       解除房主的邀请限制

%%--------战斗准备界面信息 -------------
-define(PT_READY_CROSS_3V3, 43401).
%% 协议号:43401

%% s >> c:
%% 
%%      己方三个人
%%      array(
%%            name               string   名字
%%            school             u8       门派
%%            sex                u8       性别 
%%            dan                u8       段位
%%            PartnerNo          u32     宠物编号
%%			  Partnerlv	         u16              宠物等级
%%           )
%%      敌方三个人
%%      array(
%%            school          u8       门派
%%            sex             u8       性别 
%%           ) 


%%--------战斗结算界面 -------------
-define(PT_CROSS_3V3_RESULT, 43402).
%% 协议号:43402

%% s >> c:
%% 
%%     
%%            sign               u8      0代表负分/1代表正分数
%%            score              u8      分数
%%            Duan               u8     段位等级

%%-------- 关闭战斗结算界面 -----------
%% 需要房间状态置为0
-define(PT_CLOSE_CROSS_3V3_RESULT, 43403).
%% 协议号:43403
%% C >> S:
%%              type                u8  0：单人    1：多人
%% s >> c:
%%              Retcode             u8

