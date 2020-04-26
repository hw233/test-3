

%%%================ 组队系统协议 ===================

%% PT: protocol
%% TM: team


%%----------------- 创建or修改队伍 -----------------------
-define(PT_TM_CREATE,  24000).

%% 协议号：24000
%% c >> s:
%%		TeamId				u32		队伍唯一id,创建新队伍默认发送0,修改队伍发送队伍id
%% 		SceneNo     		u32     场景的编号,即 战斗地图 0--任意
%%      TeamActivityType    u8		队伍活动类型：0:任意, 1:任务，2：副本，3：日常，4：活动
%%      Condition1		    u8		条件1 任务类型 (【任意】:0, 捕星:1, 【帮派】:2、【挂机】:3)  或  副本难度 (0:任意，1：简单， 2：普通， 3：困难) 编号 
%%      Condition2          u32     条件2 怪物等级 （0:任意，1:0~9级，2:10~19级，3:20~29级，4:30~39级，5:40~49，6:50~59，7:60~69，8:70~79，9:80~89，10:90~99） 或 副本编号 
%%      TeamMinLv           u32     队伍最低等级要求
%%      TeamMaxLv           u32     队伍最高等级要求
%%		TeamName			string	队伍名字


%% s >> c:  当是修改队伍的情况，则向所有队伍成员广播24030协议
%%      RetCode             u8   	创建成功返回0
%%		TeamId				u32		队伍唯一id
%% 		SceneNo             u32     场景的编号,即 战斗地图
%%      TeamActivityType    u8		队伍活动类型：0:任意, 1:任务，2：副本，3：日常，4：活动
%%      Condition1          u8      条件1
%%      Condition2          u32     条件2
%%      InitPos             u8   	队长在阵型中的初始位置
%%      CurUseTroop         u32  	队伍当前启用的阵法编号
%%      TeamMinLv           u32     队伍最低等级要求
%%      TeamMaxLv           u32     队伍最高等级要求
%%		TeamName			string
%%      array(                      当前队伍可用的阵法编号列表
%%              No          u32
%%          )



%%-------队长交换两个队员的位置---------------------------
-define(PT_TM_CHANGE_POS, 24001).

%% 协议号：24001
%% c >> s:
%%		PlayerId1			int64
%%		PlayerId2			int64

%% s >> c:
%%		通过24002协议通知交换了站位


%% -----------------服务器主动通知所有队员更新某两个队员的站位-------------------
-define(PT_TM_NOTIFY_MEMBER_CHANGE_POS, 24002).

%% 协议号：24002
%% c >> s:
%%		无

%% s >> c:
%%		PlayerId1			int64
%%		PlayerId2			int64


%% -----------------服务器主动通知所有队员某个队员暂离队伍-------------------
-define(PT_TM_NOTIFY_MEMBER_TEMP_LEAVE, 24003).

%% 协议号：24003
%% c >> s:
%%		无

%% s >> c:
%%		PlayerId			int64
%%		SwornType 			u8  	  队伍 结拜类型  0没有结拜，1 普通结拜，2，生死结拜 (此字段暂时没用)


%%------------------ 暂离队伍 -----------------------
-define(PT_TM_TEM_LEAVE,  24004).

%% 协议号：24004
%% c >> s:
%%     无
%% s >> c:
%%     返回 -define(PT_TM_NOTIFY_MEMBER_TEMP_LEAVE, 24003).


%%------------------ 退出队伍 -----------------------
%% 注：退出成功后，如果队伍还有人: 则服务端会向队伍的人发送有人离队的通知（即24011协议），
%%                                 若是队长退出，则还会向队伍余下的人发送队长已更改的通知（即24012协议）;
-define(PT_TM_QUIT,  24005).

%% 协议号：24005
%% c >> s:
%%     无
%% s >> c:
%%     通过 24011 PT_TM_NOTIFY_MEMBER_QUIT 


%%------------------ 邀请他人加入队伍 -----------------------
-define(PT_TM_INVITE_OTHERS,  24006).

%% 协议号：24006
%% c >> s:
%%      ObjPlayerId     int64  被邀请人id

%% s >> c:
%%      RetCode      	u8   发出邀请成功则返回0
%%      ObjPlayerId     int64  被邀请人id


%%------------------ 被邀请人收到入队邀请 服务器主动发给队员------------
-define(PT_TM_GOT_INVITE,  24007).

%% 协议号:24007
%% s >> c:
%%     FromPlayerId        u64     发邀请的玩家id
%%     FromPlayerName      string  发邀请的玩家名字
%%     FromPlayerLv        u16     发邀请的玩家等级
%%     TeamActivityType    u8      队伍活动类型：0:任意, 1:任务，2：副本，3：日常，4：活动
%%     SceneNo             u32     场景的编号,即 战斗地图 0--任意
%%     Condition1          u8      条件1
%%     Condition2          u32     条件2


%%--------------------- 踢出队伍（队长权限） --------------------------
%% 注：踢出成功后，会向队伍的所有人（包括被踢的人）发送有人离队的通知（即24024协议）
-define(PT_TM_KICK_OUT, 24009).

%% 协议号：24009
%% c >> s: 
%%     ObjPlayerId     int64  被踢队员id
%% s >> c: 
%%     无


%%----------------- 查询自己所在队伍的信息 -------------------

-define(PT_TM_QRY_MY_TEAM_INFO, 24010).

%% 协议号：24010
%% c >> s:
%% 		无
%% s >> c:  需要添加 显示玩家的 头饰、下身、还有 ?
%%      TeamId              u32     队伍id
%%      array(	                    
%%        		Id        		u64     队员id
%%        		Level     		u16     队员等级
%%        		Name      		string  队员名字
%%        		TroopPos       	u8      在队伍阵型中的位置(1~9)
%%		  		TrainPos		u8      拖火车位置 当该值是1表示是队长
%%        		Faction    		u8      门派
%%        		Sex             u8      性别（1：男，2：女）
%%        		SceneId         u32     场景id
%%        		State           u8      玩家状态：1 暂离，2 在队在线 3 在队离线
%%        		SceneNo         u32     场景编号
%%        		Race            u8      种族
%%        		Weapon          u32     武器
%%        		BackWear        u32     背部装饰
%%				SwornId 		u64 	结拜唯一标识
%%				SwornType 		u8 		队伍 结拜类型  0没有结拜，1 普通结拜，2，生死结拜
%%				StrenLv 		u8 	    玩家套装最低强化等级，如果没有套装则是0
%%		 		Headwear       u32      头饰编号
%%		 		Clothes        u32      服饰编号
%%              MagicKey       u32      法宝编号
%%              BtPower        u32      战斗力
%%          )
%%        TeamName          string
%%        TeamActivityType  u8      队伍活动类型：
%%        Condition1        u8      条件1
%%        Condition2        u32     条件2
%%      TeamMinLv           u32     队伍最低等级要求
%%      TeamMaxLv           u32     队伍最高等级要求
%%        array(                      当前队伍可用的阵法编号列表
%%              No          u32
%%          )
%%        CurUseTroop         u32     队伍当前启用的阵法编号
%%        NeedAudit           u8      入队申请是否需要审核



%%------------------ 玩家主动离队，通知队伍成员：有人离队了（服务端主动通知） ------------------
-define(PT_TM_NOTIFY_MEMBER_QUIT, 24011).

%% 协议号: 24011
%% s >> c:
%%     	PlayerId        int64     离队队员id
%%		NewLeaderId		int64	  新队长id，如果队长没有变化则为0
%%		SwornType 		u8  	  队伍 结拜类型  0没有结拜，1 普通结拜，2，生死结拜 (此字段暂时没用)


%%------------------ 提升队员为队长（队长权限），需要被提升的队员确认，提升成功后原队长变为普通队员 ----------------
%% 注：提升成功后队伍的所有人会收到队长更改的通知（即协议24012）
-define(PT_TM_PROMOTE_MEMBER, 24012).

%% 协议号：24012
%% c >> s:
%%     ObjPlayerId   	int64  提升目标id
%% s >> c:
%%     RetCode    		u8   发送提升请求成功返回0


%% 被提升队员确认或拒绝被提升为队长
-define(PT_TM_HANDLE_PROMOTE, 24013).

%% 协议号：24013
%% c >> s:
%% 		Action 		u8   0为同意，1为拒绝
%%      TeamId   	u32
%%		LeaderId 	u64   发送请求的队长id

%% s >> c: 如果队长换了则发送协议24014，如果拒绝则发送 24025


%%------------------ 通知队伍：队长换了（服务端主动通知） --------------------
-define(PT_TM_NOTIFY_LEADER_CHANGED, 24014).

%% 协议号：24014
%% s >> c:
%%     	NewLeaderId         int64	  新队长id


%% 队员收到信息：现任队长提升你为新队长，服务器主动发给队员
-define(PT_TM_PROMOTE_YOU, 24015).

%% c >> s:
%%		无

%% s >> c:
%%		TeamId 				u32
%%		LeaderId 			u64

 
%% --------------------服务器主动发送：XXX申请成为队长 给队长--------------------------
-define(PT_TM_MEM_APPLY_FOR_LEADER, 24016).

%% c >> s:
%%		无

%% s >> c:
%% 		PlayerId 			int64     申请玩家Id
%% 		Name 				string    玩家名


%% 邀请玩家加入队伍时，获取落单玩家信息列表
-define(PT_TM_GET_ALONE_PLAYER_LIST, 24017).

%% 协议号: 24017
%% c >> s:
%% 		无
%% s >> c:
%%     RetCode   u8  返回0表示成功
%%	   array(
%%			PlayerId            int64	
%%			Sex                 u8		
%%			Name                string 	
%%			Lv                  u16      
%%			Faction             u8		      门派
%%			GuildName           string		  帮派
%%          SceneNo             u32           场景的编号,即 战斗地图
%%          TeamActivityType    u8            队伍活动类型：0:任意, 1:任务，2：副本，3：日常，4：活动
%%          Condition1          u8            条件1
%%          Condition2          u32           条件2
%%          VipLv               u8            Vip等级
%%          Power     	        u32      	 战斗力
%%		)

%%-------------------------玩家申请当队长-------------------------
-define(PT_TM_APPLY_FOR_LEADER, 24018).

%% 协议号：24018
%% c >> s:
%%		无
%% s >> c:
%% 		RetCode 	u8  返回0表示成功


%% -------------------队长同意或拒绝队员申请为队长的请求-----------------
-define(PT_TM_HANDLE_APPLY_FOR, 24019).

%% 协议号：
%% c >> s:
%%      Action          u8      同意还是拒绝 0表示拒绝，1表示同意
%%      ObjPlayerId     int64   同意或拒绝目标玩家id
%% s >> c:
%%      RetCode         u8 拒绝成功返回0,同意则返回 PT_TM_NOTIFY_LEADER_CHANGED 协议


%---------------------落单玩家同意或者拒绝队长的入队邀请--------------------------
-define(PT_TM_HANDLE_INVITE, 24021).

%% 协议号：24021
%% c >> s:
%%		Action			u8         同意还是拒绝 0表示拒绝，1表示同意
%% 		LeaderId 		int64      队长id，即担任队长的玩家id
%% s >> c:
%%		RetCode 		u8
%% 		LeaderId 		int64

%% ------------------------服务器通知队长邀请玩家入队结果-------------------
-define(PT_TM_NOTIFY_LEADER_INVITE_RESULT, 24022).

%% 协议号：24022
%% c >> s:
%%		无
%% s >> c:
%%		Result 			u8     0表示拒绝，1表示同意
%% 		Name 			string 玩家名



%%----------------- 目前是有人新加入队伍后，服务端会主动通知队伍信息给队伍的所有人（包括新加入的人） -------------------
-define(PT_TM_NOTIFY_MEMBER_JOIN, 24023).

%% 协议号：24023
%% c >> s:
%% 		无
%% s >> c: 
%%       PlayerId       int64   队员id
%%       Level     		u16   	队员等级
%%       Name      		string  队员名字
%%       TroopPos       u8    	在队伍阵型中的位置(1~9)
%%		 TrainPos       u8		在地图拖火车位置
%%       Faction    	u8    	门派
%%       Sex            u8    	性别（1：男，2：女）
%%       SceneId        u32    	场景id
%%       State          u8      玩家状态：1 暂离，2 在队在线 3 在队离线
%%       SceneNo        u32     场景编号
%%       Race           u8      种族
%%       Weapon         u32     武器
%%       BackWear       u32     背部装饰
%%		 SwornId 		u64 	结拜唯一标识
%%		 SwornType 		u8 		队伍 结拜类型  0没有结拜，1 普通结拜，2，生死结拜
%%		 StrenLv 		u8 	    玩家套装最低强化等级，如果没有套装则是0
%%		 Headwear       u32      头饰编号
%%		 Clothes        u32      服饰编号
%%       MagicKey       u32      法宝编号
%%       BtPower        u32      战斗力

%%------------------ 通知队伍成员：有人被请离队了（服务端主动通知） ------------------
-define(PT_TM_NOTIFY_KICK_OUT_MEMBER, 24024).

%% 协议号: 24024
%% s >> c:
%%     	PlayerId        int64     离队队员id
%%		SwornType 		u8  	  队伍 结拜类型  0没有结拜，1 普通结拜，2，生死结拜 (此字段暂时没用)


%--------------------服务器通知队长：XX拒绝了你的提升队长申请-------------------------
-define(PT_TM_NOTIFY_PROMOTE_RESULT, 24025).
%% 协议号：24025
%% s >> c:
%%		Result 			u8    	0表示同意，1表示拒绝 目前只有拒绝
%%      Name 			string 	发起同意或拒绝动作的玩家名字


%%------------------ 通知队伍成员：有人归队了（服务端主动通知） ------------------
-define(PT_TM_NOTIFY_MEMBER_RETURN, 24026).

%% 协议号: 24026
%% s >> c:
%%     	PlayerId        int64     归队队员id
%%		SwornType 		u8  	  队伍 结拜类型  0没有结拜，1 普通结拜，2，生死结拜 (此字段暂时没用)


%%------------------ 通知队伍成员：有人离线了（服务端主动通知） ------------------
-define(PT_TM_NOTIFY_MEMBER_OFFLINE, 24027).

%% 协议号: 24027
%% s >> c:
%%     	PlayerId        int64     离线队员id
%%		SwornType 		u8  	  队伍 结拜类型  0没有结拜，1 普通结拜，2，生死结拜 (此字段暂时没用)


%% ----------------玩家设置组队目的------------------------------
-define(PT_TM_SET_JOIN_AIM, 24028).

%% 协议号：24028
%% c >> s:
%%      TeamActivityType        u8      队伍活动类型：0:任意, 1:任务，2：副本，3：日常，4：活动
%%      Condition1              u8      条件1
%%      Condition2              u32     条件2
%%      TeamMinLv           u32     队伍最低等级要求
%%      TeamMaxLv           u32     队伍最高等级要求


%% s >> c:
%%      RetCode                 u8
%%      TeamActivityType        u8      队伍活动类型：0:任意, 1:任务，2：副本，3：日常，4：活动
%%      Condition1              u8      条件1
%%      Condition2              u32      条件2
%%      TeamMinLv           u32     队伍最低等级要求
%%      TeamMaxLv           u32     队伍最高等级要求


%% ------------------玩家查询获取自己的组队目的--------------------
-define(PT_TM_GET_JOIN_AIM, 24029).

%% 协议号：24029
%% c >> s:
%%      无

%% s >> c:
%%      TeamActivityType    u8      队伍活动类型：0:任意, 1:任务，2：副本，3：日常，4：活动
%%      Condition1          u8      条件1
%%      Condition2          u32     条件2
%%      TeamMinLv           u32     队伍最低等级要求
%%      TeamMaxLv           u32     队伍最高等级要求

%% -------------------------服务器通知所有队员（包括队长）队伍信息发生变化:如队伍名字等------------------------
-define(PT_TM_NOTIFY_TEAM_INFO_CHANGE, 24030).
%% s >> c:
%%      TeamId              u32     队伍唯一id
%%      SceneNo             u32     场景的编号,即 战斗地图
%%      TeamActivityType    u8      队伍活动类型：
%%      Condition1          u8      条件1
%%      Condition2          u32     条件2
%%      TeamMinLv           u32     队伍最低等级要求
%%      TeamMaxLv           u32     队伍最高等级要求
%%      CurUseTroop         u32     队伍当前启用的阵法编号
%%      TeamName            string
%%      array(                      当前队伍可用的阵法编号列表
%%              No          u32
%%          )


%% 获取在线好友和在线同帮派成员列表
-define(PT_TM_GET_ONLINE_RELA_PLAYERS, 24031).

%% 协议号：24031
%%	C >> S:
%%      PageSize           u8       每页显示个数
%%      PageIndex          u16      页码编号 从1开始

%% S >> C:
%%      TotalPage           u16     总页数
%%      PageIndex           u16     页码编号 从1开始
%%		array(
%%				PlayerId 	u64
%%				Faction  	u8
%%				Lv 			u16
%%				Rela 		u8      1 好友；2 同帮派好基友
%%				VipLv 		u8
%%				Name  		string
%%        sex       u8
%%        power     u32
%%			)


%%------------------ 查询场景中的队伍列表 -----------------------
-define(PT_TM_QRY_TEAM_LIST,  24050).

%% 协议号：24050
%% c >> s:
%%      PageSize           u8       每页显示个数
%%      PageIndex          u16      页码编号 从1开始
%%      TeamActivityType   u8       队伍活动类型：0:任意, 1:任务，2：副本，3：日常，4：活动
%%      Condition1         u8       队伍条件限制1
%%      Condition2         u32      队伍条件限制2

%% s >> c:
%%      TotalPage           u16     总页数
%%      PageIndex           u16     页码编号 从1开始
%%      array(
%%			  TeamId 				u32		队伍唯一id
%%            MemberCount      		u8    	队伍人数
%%            LeaderId         		int64   队长id
%%      	  TeamActivityType   	u8		队伍活动类型：
%%      	  Condition1            u8      条件1
%%            Condition2            u32     条件2
%%      	TeamMinLv           u32     队伍最低等级要求
%%      	TeamMaxLv           u32     队伍最高等级要求
%%			  SceneNo            	u32     队伍所属普通场景编号
%%			  TeamName				string	队伍名字
%%            LeaderName       		string  队长名字
%%            LeaderVipLv           u8      队长vip等级
%%          array(
%%        		Id        		u64     队员id
%%        		Level     		u16     队员等级
%%        		Name      		string  队员名字
%%        		Faction    		u8      门派
%%        		Sex             u8      性别（1：男，2：女）
%%              )
%%          )



%%------------------ 申请加入队伍 -----------------------
% 申请加入队伍
-define(PT_TM_APPLY_JOIN, 24051).

%% 协议号： 24051
%% c >> s:
%%		LeaderId 		u64		队长唯24056   一id

%% s >> c:
%% 		RetCode 		u8		申请成功返回0


% 允许加入队伍
-define(PT_TM_ALLOW_JOIN, 24052).

%% 协议号：24052
%% c >> s:
%%		PlayerId 		int64	允许对象（玩家）的id
%%		TeamId 			u32 	允许加入的队伍id

%% s >> c:
%%		向全队发送PT_TM_NOTIFY_MEMBER_JOIN协议


% 玩家归队
-define(PT_TM_RETURN_TEAM, 24053).

%% 协议号：24053
%% c >> s:
%%		TeamId 			u32 	允许加入的队伍id

%% s >> c:
%%		RetCode         u8  0--成功 其他失败


%% 队长邀请玩家归队
-define(PT_TM_INVITE_RETURN, 24054).

%% 协议号：24054
%% c >> s:
%%		PlayerId 		int64	邀请对象（玩家）的id

%% s >> c:
%%		RetCode 		u8		成功返回0


%%------------------- 队长拒绝玩家加入队伍 -------------
-define(PT_TM_REFUSE_JOIN, 24055).

%% 协议号: 24055
%% c >> s:
%%	   ObjPlayerId		  int64   拒绝目标玩家id
%% s >> c:
%%     RetCode            u8    成功返回0
%%	   ObjPlayerId		  int64   拒绝目标玩家id


%%------------------- 查询队伍的申请列表----------------------
-define(PT_TM_QRY_APPLY_LIST, 24056).

%% 协议号: 24077
%% c >> s:
%%     	TeamId 			u32		
%% s >> c:
%%     	array(
%%             PlayerId 	int64    申请玩家id
%%             Name      	string   申请玩家姓名
%%             Lv           u16      等级
%%			   Race	        u8		 职业
%%             Sex          u8       性别（1：男，2：女）
%%             Faction      u8       门派
%%             Weapon       u32      武器
%%             BackWear     u32      背部装饰
%%			   StrenLv 		u8 	     玩家套装最低强化等级，如果没有套装则是0
%%		 	   Headwear     u32      头饰编号
%%		 	   Clothes      u32      服饰编号
%%             MagicKey     u32      法宝编号
%%             Power     u32      	 战斗力
%%          )


%------------------------服务器向玩家发送归队信息--------------------------
-define(PT_TM_INVITE_YOU_RETURN, 24057).

%% 协议号：24057
%% c >> s:
%%		无
%% s >> c:
%%		TeamId 				u32


%%------------------- 队长清空队伍的申请列表----------------------
-define(PT_TM_CLEAR_APPLY_LIST, 24058).
%% 协议号: 24077
%% c >> s:
%%     	TeamId 			u32
%% s >> c:
%%     	RetCode         u8    成功返回0
%%     	TeamId 			u32


%% 查询队伍成员（不包括玩家自己）的位置信息
-define(PT_TM_GET_MEMBER_POS, 24059).

%% 协议号: 24059
%% c >> s:
%%      无
%% s >> c:
%%      array(
%%             PlayerId     int64    玩家id
%%             SceneNo      u32      场景编号
%%             X            u32      所在场景的坐标x
%%             Y            u32      所在场景的坐标y
%%          )


%% 查询队长的位置信息
-define(PT_TM_GET_LEADER_POS, 24060).

%% 协议号: 24060
%% c >> s:
%%      无
%% s >> c:
%%       PlayerId     int64    玩家id
%%       SceneNo      u32      场景编号
%%       X            u32      所在场景的坐标x
%%       Y            u32      所在场景的坐标y


%%----------- 通知队伍成员：更新玩家的一个或多个信息 ------------
-define(PT_TM_NOTIFY_MB_INFO_CHANGE,  24061).

%% 协议号：24061
%% s >> c:
%%      PlayerId        u64
%%      array(
%%          Key        u8   信息代号 1-->等级
%%          NewValue   u32  当前的新值
%%          )


%%----------------- 查询某个队伍的简要信息 -------------------

-define(PT_TM_QRY_TEAM_BRIEF_INFO, 24062).

%% 协议号：24062
%% c >> s:
%%      TeamId              u32     队伍id
%% s >> c:  
%%      TeamId              u32     队伍id
%%      TeamName          	string
%%		LeaderId 			u64
%%      array(	                    
%%        		Id        		u64     队员id
%%        		State           u8      玩家状态：1 暂离，2 在队在线 3 在队离线
%%        		Name      		string  队员名字
%%           )

%% 通知队伍玩家自己的结拜信息变化
-define(PT_TM_NOTIFY_SWORN_INFO_CHANGE, 24063).
%% 协议号：24063
%% c >> s:
%%      无
%% s >> c:
%%		PlayerId 		u64
%%		SwornId 		u64
%%		SwornType 		u8  

%% 队长使用阵法
-define(PT_TM_USE_ZF, 24064).
%% 协议号：24064
%% c >> s:
%%      No              u32
%% s >> c:                  使用成功返回当前的阵法编号，失败则通过998返回错误码
%%      No              u32

%% 队长设置阵法位置
-define(PT_TM_SET_ZF_POS, 24065).
%% 协议号：24065
%% c >> s:
%%      array(
%%              PlayerId    u64
%%              Pos         u8 (1到5)
%%              )
%% s >> c: 广播给所有队员                  
%%      array(
%%              PlayerId    u64
%%              Pos         u8 (1到5)
%%              )

%设置是否需要审核入队
-define(PT_TM_IS_EXAM, 24066).
%% 协议号：24066
%% c >> s:
%%      No              u8  是否需要标记  (1表示开启审核，0表示不需要审核)
%% s >> c:
%%      No              u8  返回（0表示成功开启不需要审核，返回1表示成功开启需要审核）
