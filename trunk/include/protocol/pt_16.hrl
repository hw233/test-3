
%%% =======================================
%%% pve兵临城下相关的协议
%%% 分类号:16
%%%
%%% ======================================


%%% PT: 表示protocol


%% --------------- 进入三界-------------------------
-define(PT_TVE_ENTER, 16000).

%% 协议号:16000
%% c >> s:
%%		LvStep 	     u8		等级段  1.30-50级 2.50-70级 3.70以上级

%% s >> c:
%%		array(
%%      		RetCode      u8       成功则返回0；1:物品不足；2：等级不足; 3: 进入次数达到上限; 4:已经在副本中
%%				PlayerName   string   玩家名字
%%			)


% 显示进入三界确认
-define(PT_TVE_SHOW_TIPS, 16001).

% 协议号：16001
% S >> C:
%%		LvStep 	     u8		等级段  1.30-50级 2.50-70级 3.70以上级
%   	State        u8     是否要使用物品  0:是 1:否 服务端判断


% 进入三界确认
-define(PT_TVE_REPLY, 16002).

% 协议号：16002
% C >> S:
%%		LvStep 	     u8		   等级段  1.30-50级 2.50-70级 3.70以上级
%   	Flag         u8        0->点否 1-> 使用物品 2->不使用物品

% S >> C:  (服务端发给所有队伍成员)
%%      LvStep       u8        等级段  1.30-50级 2.50-70级 3.70以上级
%   	RetCode      u8        0->成功 1->失败
%   	array(
%       	Id  	u64       点否的玩家id
%   		State   u8        0->点否 1-> 使用物品 2->不使用物品
%   	)	 


%% 刷新奖励
-define(PT_TVE_REFRESH_REWARD, 16003).
% 协议号：16003
% C >> S:
%%		无
	
%% S >> C:
%%		MoneyType 	u8 							刷新奖励需要的金钱类型
%%		MoneyCount  u32							刷新奖励需要的金钱数量
%%		array(
%%			GoodsNo 				u32  		物品编号 详见goods.hrl
%%			GoodsCount 				u32 		数量
%%			Quality					u8			品质
%%			BindState				u8			绑定状态
%%          Flag                    u8          物品标识：0 表示普通的；1表示vip特有；2表示最后一波怪额外奖励
%%			)


%%挑战结算信息
-define(PT_TVE_SHOW_RESULT, 16004).
% 协议号：16004
% S >> C:
%%		无

%% S >> C:
%%		Win 		u8        					打怪胜利波数
%%		Rounds      u8        					回合总数
%%		MoneyType 	u8 							刷新奖励需要的金钱类型
%%		MoneyCount  u32							刷新奖励需要的金钱数量
%%		array(
%%			GoodsNo 				u32  		物品编号 详见goods.hrl
%%			GoodsCount 				u32 		数量
%%			Quality					u8			品质
%%			BindState				u8			绑定状态
%%          Flag                    u8          物品标识：0 表示普通的；1表示vip特有；2表示最后一波怪额外奖励
%%			)


%% 获取兵临城下排名信息
-define(PT_TVE_GET_RANK, 16005).
% 协议号：16005
% S >> C:
%%		LvStep 	     u8		等级段  1.30-50级 2.50-70级 3.70以上级
%%		RankCount 	 u8		排名个数

%% S >> C:
%%		LvStep 	     u8		等级段  1.30-50级 2.50-70级 3.70以上级
%%		array(
%%				Rank 						u8
%%				LeaderName					string
%%				Win							u8				打怪胜利波数
%%				Rounds						u16 			回合总数
%%				LeaderVipLv 				u8				队长vip等级
%%				array(										参与者门派列表
%%					Faction 			u8				
%%					)
%%			)


%% 获取玩家当天已经进入副本的次数 次数发生变化时服务器主动推送
-define(PT_TVE_GET_ENTER_TIMES, 16006).
% 协议号：16006
% S >> C:
%%		无

%% S >> C:
%%		Times 			u8   次数


%% 领取奖励
-define(PT_TVE_GET_REWARD, 16007).
% 协议号：16007
% S >> C:
%%		无

%% S >> C:
%%		RetCode 			u8  0 表示成功



%% ---------- 玩家触发战斗：所打的怪物组编号 -----------------
-define(PT_TVE_START_MF, 16008).

%% 协议号: 16008
%% c >> s:
%%     BMonGroupNo    u32    所打的怪物组编号
