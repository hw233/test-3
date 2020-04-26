%%% 排行榜相关协议
%%% 2014.4.11
%%% @author: mo
%%% 分类号：22

%% pt: 表示protocol
%% 排行榜类型对应协议号: 即 1xxx对应 22001, 2xxx对应22002, 类推!
%%-----------查询个人排行*（战力/等级/银子/世界Boss）------------
-define(PT_RANK_ROLE, 22001).

% 协议号：22001
% C >> S:
%     uint16   排行榜类型（1001：战力，1002：等级，1003：银子,
%                          1201:世界Boss伤害 1202:世界Boss击杀）
%     uint8    分页
% S >> C:
%     uint16   排行榜类型
%     uint16   我的排名（0显示未上榜）
%	  uint64      排行字段当前数据
%     uint16   排行榜总数
%     array(
%               uint16     排名
%               uint64     玩家ID
%               string     姓名
%               uint8      性别
%               uint8 	       门派
%               uint64     战力/等级/银子
%               uint16      VIP等级
%            )


%%-----------查询女妖排行*（战力/等级）------------
-define(PT_RANK_PARTNER, 22002).

% 协议号：22002
% C >> S:
%     uint16   排行榜类型（2001：战力，2002：等级）
%     uint8    分页
% S >> C:
%     uint16   排行榜类型
%     uint16   我的排名（0显示未上榜）
%	  uint64      排行字段当前数据
%     uint16   排行榜总数
%     array(
%               uint16     排名
%               uint64     女妖ID
%               string    女妖名字
%               string    玩家名字
%               uint32     战力/等级
%               uint64     玩家ID
%               uint8      VIP等级
%           )


%%-----------查询装备排行*（战力）------------
-define(PT_RANK_EQUIP, 22003).

% 协议号：22003
% C >> S:
%     uint16   排行榜类型（3001：战力）
%     uint8    分页
% S >> C:
%     uint16   排行榜类型
%     uint16   我的排名（0显示未上榜）
%	  uint64      排行字段当前数据
%     uint16   排行榜总数
%     array(
%               uint16     排名
%               uint64     装备ID
%               string    装备名字
%               uint32     战力
%               string    所属玩家
%               uint64     玩家ID
%               uint8      品质
%               uint8      VIP等级
%             )


%%-----------查询比武大会排行*（日/周）------------
-define(PT_RANK_ARENA, 22004).

% 协议号：22001
% C >> S:
%     uint16   排行榜类型（8001:日排 8002:周排）
%     uint8    分页
% S >> C:
%     uint16   排行榜类型
%     uint16   我的排名（0显示未上榜）
%	  uint64      排行字段当前数据
%     uint16   排行榜总数
%     array(
%               uint16     排名
%               uint64     玩家ID
%               string     姓名
%               uint16     胜场数
%               uint32     胜率(*10000)
%               uint8      VIP等级
%            )

%% 通用排行榜协议（5001：帮派战力 5002: 帮派建设(繁荣度)）
-define(PT_RANK_COMMON, 22005).

% 协议号：22005
% C >> S:
%     uint16   排行榜类型（5001：帮派战力 5002: 帮派建设(繁荣度)）
%     uint8    分页
% S >> C:
%     uint16   排行榜类型
%     uint16   我的排名（0显示未上榜）
%	  uint64      排行字段当前数据
%     uint16   排行榜总数
%     array(
%               uint16     排名
%               uint64          排序ID 			(5002--帮派ID)
%               string     名字 				(5002--帮派名字)
%               uint32          排序值 			(5002--帮派建设值)
%               string     参数字符串 		(5002--帮主名字)
%				string 	      参数字符串2		(5002--成员数字符串)
%               uint64          参数1				(5002--帮派等级)
%               uint32     参数2				暂无用
%             )

%%-----------查询3v3比武大会排行*（日/周）------------
-define(PT_RANK_ARENA_3v3, 22006).

% 协议号：22006
% C >> S:
%     uint16   排行榜类型（6001:日排 6002:周排）
%     uint8    分页
% S >> C:
%     uint16   排行榜类型
%     uint16   我的排名（0显示未上榜）
%	  uint64      排行字段当前数据
%     uint16   排行榜总数
%     array(
%               uint16     排名
%               uint64     玩家ID
%               string     姓名
%               uint16     胜场数
%               uint16     负场数
%               uint8      VIP等级
%            )

%%-----------查询坐骑排行*（战力/等级）------------
-define(PT_RANK_MOUNT, 22007).

% 协议号：22007
% C >> S:
%     uint16   排行榜类型（7001：战力，7002：等级）
%     uint8    分页
% S >> C:
%     uint16   排行榜类型
%     uint16   我的排名（0显示未上榜）
%	  uint64      排行字段当前数据
%     uint16   排行榜总数
%     array(
%               uint16     排名
%               uint64     坐骑ID
%               string    坐骑名字
%               string    玩家名字
%               uint32     战力/等级
%               uint64     玩家ID
%               uint8      VIP等级
%           )


%%-----------查询家园豪华度------------
-define(PT_RANK_HOME_DEGREE, 22008).

% 协议号：22008
% C >> S:
%     uint16   排行榜类型（8001：家园豪华度）
%     uint8    分页
% S >> C:
%     uint16   排行榜类型
%     uint16   我的排名（0显示未上榜）
%	  uint64      排行字段当前数据
%     uint16   排行榜总数
%     array(
%               uint16     排名
%               uint64     玩家ID
%               string    姓名
%               uint8      性别
%               uint8 	   门派
%               uint32     豪华度
%               uint8      VIP等级
%            )



%%-----------查询帮派副本排行榜------------
-define(PT_RANK_GUILD_DUNGEON, 22009).

% 协议号：22009
% C >> S:
%     uint16   排行榜类型（9001：采集、   9002：击杀、     9003：伤害值、     9004：贡献值）
%     uint8    分页
% S >> C:
%     uint16   排行榜类型
%     uint16   我的排名（0显示未上榜）
%	  uint64      排行字段当前数据
%     uint16   排行榜总数
%     array(
%               uint16     排名
%               uint64     玩家ID
%               string     姓名
%               uint8      性别
%               string     帮派名
%               uint32     采集/击杀/伤害值/贡献值
%               uint8      VIP等级
%            )





%%-----------查询装备排行*（战力）------------
-define(PT_RANK_EQUIP_DETAIL, 22103).

% 协议号：22003
% C >> S:
%     uint64   装备ID
% S >> C:
%     uint64   装备ID
