%% =========================================================
%% %%% 限时任务
%%% 2019.04.16
%%% @author: jiangbin wujiancheng
%%% 分类号：56
%% =========================================================
%%--------获取限时任务主界面信息 -------------
-define(PT_ENTER_LIMIT_TASK,56001).
%% 协议号:56001
%% c >> s:
%%

%% s >> c:
%%      point           u32     		玩家分数
%%      array{
%%          key            u8           唯一值
%%      	  level          u8  		      难度
%%          content        string       挑战描述
%%          point          u32          分数
%%          goodsno        u32          物品编号
%%		}
%%      remain         	   u8      		剩余次数
%%      reset_times		   u8           今天已经重置的次数

%%--------战斗结束发送 -------------
-define(PT_LT_UPDATE_MAIN_DATA, 56002).
%% 协议号:56002

%% s >> c:
%%      point           u32     		玩家分数
%%      remain         	u8      		剩余次数

%%--------进入挑战 -------------
-define(PT_LT_ENTER_TASK, 56003).
%% 协议号:56003
%% c >> s:
%%    	key			    u8 			   挑战编号
%% s >> c:
%%      成功则进入战斗，失败则发998

%%--------购买挑战次数 -------------
-define(PT_LT_BUY_TIMES,56004).
%% 协议号:56004
%% c >> s:
%% s >> c:
%%      remain         	   u8      	  剩余次数
%%      reset_times		     u8         今天已经重置的次数

%%--------获取累积奖励和排名奖励的内容 -------------
-define(PT_LT_POINT_REWARD,56005).
%% c >> s:
%% 协议号:56005

%% s >> c:
%%      array{
%%        index      u8           奖励编号
%%			  point		   u32		    	所需分数
%%		    goods_no   u32			    物品编号
%%        count      u8           物品数量
%%        is_get     u8           当前是否已领取 0是未领取/1是已领取
%%		}

%%    array{
%       rankfirst      16       排名开始
%%			rankend		     u8			  排名结束
%%			goods_no       u32			奖励包编号
%%      count          u8       物品数量
%%      point          u32      所需分数
%%		}




%%--------领取累积奖励 -------------
-define(PT_LT_GET_REWARD,56007).
%% 协议号:56007
%% c >> s:
%%		index				u8			奖励编号
%% s >> c:

%%        is_get     u8   奖励编号发过去的代表已领取



%%--------排行榜数据 -------------
-define(PT_LT_RANK_DATA,56008).
%% 协议号:56008
%% c >> s:
%%      index     u8        1代表前十条，2代表11-20
%% s >> c:
%%      array{
%%			rank		   u8		   	排名
%%			name		   string		名字
%%			point		   u32			分数
%%			time		   u32			到达的时间戳
%%		}
%%		rank		   u8			我的排名 0为榜外

%%--------额外奖励列表 -------------
-define(PT_LT_EXTRA_REWARD,56009).
%% 协议号:56009
%% c >> s:
%% s >> c:
%%      array{
%%          Index          u8       奖励编号
%%			    point		       u32			所需分数
%%          goods_no       u32			奖励包编号
%%          count          u8       物品数量
%%          is_get         u8       当前是否已领取 0是未领取/1是已领取
%%		}

%%--------购买额外奖励资格-------------
-define(PT_LT_BUY_EXTRA,56010).
%% 协议号:56010
%% c >> s:
%% s >> c:
%%      result				u8			0成功 其他失败

%%--------领取额外奖励 -------------
-define(PT_LT_GET_EXTRA_REWARD,56011).
%% 协议号:56011
%% c >> s:
%%		index				u8			奖励编号
%% s >> c:

%%    is_get     u8           奖励编号发过去的代表已领取


%%--------额外奖励资格 -------------
-define(PT_LT_EXTRA_LICENCE,56012).
%% 协议号:56012
%% c >> s:
%% s >> c:
%%      result				u8			0已购买 其他 未购买

