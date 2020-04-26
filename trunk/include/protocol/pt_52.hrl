%%% 商城相关协议
%%% 2014.2.17
%%% @author: zhangwq
%%% 分类号：52

%% pt: 表示protocol


%%-----------商店--向商城购买物品---------
-define(PT_BUY_GOODS_FROM_SHOP, 52001).

%% 协议号: 52001
%% C >> S:
%%      GoodsNo              u32     购买物品编号
%%      Count                u16     数量

%%  S >> C:
%%      RetCode              u8      若成功则返回0，1--该物品已经卖光，2--超过限制的购买数量
%%      GoodsNo              u32     购买物品编号
%%      Count                u16     数量


%%-----------查询可以购买的动态物品列表---------
-define(PT_QUERY_DYNAMIC_GOODS_IN_SHOP, 52002).

%% 协议号: 52002
%% C >> S:

%% s >> c:
%%      array(
%%            GoodsNo        u32
%%            Quality        u8     品质
%%            PriceType      u8     1.银子 2.金子 3.绑银 4.绑金
%%            Price          u32
%%            DiscountPrice  u32    
%%            BuyLimit       u8     1 -- 限购的 0 -- 不限购 
%%            NumberLimit    u32    当 BuyLimit = 1 且物品是终身限购时表示玩家限制购买该物品的个数
%%            GoodsType      u8     0：表示普通商品 1：表示限时物品，无限个物品x时间下架 2：表示限量物品，上架x个; 3：某个时间段内限制购买的商品
%%            LeftCount      u32    当GoodsType=2时表示：该编号的物品当前剩余个数；当GoodsType=3时表示：这个时间段玩家还可以购买多少个
%%            ExpireTime     u32    到期时间
%%            BindState      u8     绑定状态
%%           )


%%-----------商店--在运营后台商城购买物品---------
-define(PT_BUY_GOODS_FROM_OP_SHOP, 52003).

%% 协议号: 52003
%% C >> S:
%%      GoodsNo              u32     购买物品编号
%%      Count                u16     数量

%%  S >> C:
%%      RetCode              u8      若成功则返回0，1--该物品已经卖光，2--超过限制的购买数量
%%      GoodsNo              u32     购买物品编号
%%      Count                u16     数量


%%-----------查询可以购买的动态物品列表---------
-define(PT_QUERY_GOODS_IN_OP_SHOP, 52004).

%% 协议号: 52004
%% C >> S:

%% s >> c:
%%      array(
%%            GoodsNo        u32
%%            Quality        u8     品质
%%            PriceType      u8     1.银子 2.金子 3.绑银 4.绑金
%%            Price          u32
%%            Discount       u8     折扣率
%%            GoodsType      u8     0：表示普通商品 1：表示限时物品，无限个物品x时间下架 2：表示限量物品，上架x个; 3：某个时间段内限制购买的商品
%%            LeftCount      u32    当GoodsType=2时表示：该编号的物品当前剩余个数；当GoodsType=3时表示：这个时间段玩家还可以购买多少个
%%            ExpireTime     u32    到期时间
%%            BindState      u8     绑定状态
%%           )