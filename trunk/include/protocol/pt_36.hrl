%%% 年夜饭相关协议
%%% 2015.01.07
%%% @author: liufang
%%% 分类号：36

%% pt: 表示protocol

-define(PT_NEWYEAR_BANQUET_ENTER_SCENE, 36001).
%% 进入新年宴会场景
%% C >> S :
%%      仅发协议号

-define(PT_NEWYEAR_BANQUET_LEAVE_SCENE, 36002).
%% 退出新年宴会场景
%% C >> S :
%%      仅发协议号

%%-----------年夜宴会信息------------
-define(PT_GET_NEWYEAR_BANQUET, 36003).
% 协议号：36003
% C >> S: 
% S >> C:
%    banquet_lv       u8        宴会档次（最大为5）
%    banquet_exp      u32       宴会当前经验值
%    refresh_time     u32       最近刷新时间   
%    my_dish_num1     u8        [粗茶淡饭]已经加菜次数
%    my_dish_num2     u8        [大鱼大肉]已经加菜次数
%    my_dish_num3     u8        [鲍参翅肚]已经加菜次数
%    array( 加菜排行榜
%        playerId        int64           玩家id
%        name        string         玩家名字
%        dish1_num       u8        [粗茶淡饭]已经加菜次数
%        dish2_num       u8        [大鱼大肉]已经加菜次数
%        dish3_num       u8        [鲍参翅肚]已经加菜次数
%    )
%    array( 加菜列表
%        playerId        int64           玩家id
%        name        string  玩家名字
%        dish_no     u8     加菜类型（1粗茶淡饭 2大鱼大肉 3鲍参翅肚）
%    )                          

%% 年夜宴会加菜
-define(PT_ADD_NEWYEAR_DISHES, 36004).
% % 协议号：36004
%% C >> S:
%%      DishesNo        u8      菜的编号
%%      Num             u16     数量

%% S >> C:
%%      banquet_lv       u8        宴会档次（最大为5）
%%      banquet_exp      u32       宴会当前经验值

% 通知前端已刷新可加菜次数
-define(PT_NEWYEAR_BANQUET_REFRESH_ADD_DISH, 36005).
%% 协议号：36005
%% S >> C :
%%      


%% 日常充值幸运转盘活动协议
% 幸运转盘信息
-define(PT_ERNIE_INFO, 36100).
%% 协议号：36100
%% C >> S:
%% S << C:
%%      ernie_times   u8     幸运转盘次数
%%      array(
%%          playerId      int64    玩家id
%%          name          string   玩家名字
%%          goods_no      u32      物品编号
%%          num           u32      物品数量
%%          quality       u8       物品品质
%%          bind          u8       是否绑定（1.已绑定 2.永不绑定 3.获取即绑定4.使用后绑定）    
%%      )
%%      array( 抽奖项信息
%%        no          u8          位置（唯一标识）
%%        goods_no    u32         物品ID
%%        num         u32         数量
%%        quality     u8          物品品质
%%        bind        u8          是否绑定（1.已绑定 2.永不绑定 3.获取即绑定4.使用后绑定）
%%		  gain		  u8	                  是否已获得
%%     )

% 幸运转盘抽奖
-define(PT_ERNIE_GET, 36101).
%% 协议号：36101
%% C >> S：
%% S << C：
%%    code    u8  结果 (0成功 1活动未开放 2系统错误 3抽奖过快, 4背包满, 5次数不足)
%%    no      u8  位置（唯一标识）

% 通知前端有幸运转盘抽奖次数
-define(PT_ERNIE_NOTIFY, 36102).
%% 协议号：36102
%% C >> S：
%% S << C：
%%      ernie_times     u8   幸运转盘次数

-define(PT_ENTER_LUCKY_DRAW, 36103).
%% 协议号:36103
%% c >> s:
%%      Type                            u8          操作类型：0--免费 1--购买一次 2--购买10次 []->表示进入
%% s >> c:
%%      LastFreeEnterTime               u32         上次免费抽奖的时间戳
%%      Token                           u32         点券
%%      Ranking                         u16         排名
%%      array(
%%          Step                        u32          宝箱编号
%%      )


-define(PT_GET_LOTTERY_REWARD, 36104).
%% 协议号:36104
%% c >> s:
%%		step                    u32		宝箱档位
%% s >> c:
%%      RetCode                 u8      0：成功；1：失败


-define(PT_LUCKY_PLAYER_RANK, 36106).
%% 协议号:36106
%% c >> s:  
%%    Type                         u8       1:返回1-10名，2:返回11-20，3:返回21-30 ···

%% s >> c:
%     array{
%     Rank                      u8       玩家排名
%     Name                      string   玩家名字
%     Token                     u32       点卷
%     }
%%  


-define(PT_LUCKY_RANK_AWARD, 36107).
%% 协议号:36107
%% c >> s:  
%% 

%% s >> c:
%     array{
%     Start                     u8      起始排名
%     End                       u8      结尾排名
%     Token                     u32     点卷数目
%     array{
%      
%             GoodNo            u32     物品编号
%             Count             u32     数量
%            
%           }
%     }
%% 
