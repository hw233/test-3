

%%% 市场交易相关协议

%% MK: 表示market


%%-------- 挂售物品 -------------
-define(PT_MK_SELL_GOODS,  26001).
%% 协议号:26001
%% c >> s:
%%      GoodsId          u64    物品唯一id
%%      Price            u32    挂售价格 单价
%%      PriceType        u8     挂售价格类型 详见common.hrl 宏定义
%%      SellTime         u8     挂售的持续时间（单位：小时）
%%      StackNum         u16    物品堆叠数量

%% s >> c:
%%      RetCode          u8     挂售成功则返回0
%%      GoodsId          u64    物品唯一id
%%      SellRecordId     u64    该上架物品对应的挂售记录唯一id（挂售失败时为0）
%%      StackNum         u16    物品堆叠数量


%%-------- 挂售货币 -------------
-define(PT_MK_SELL_MONEY,  26002).
%% 协议号:26002
%% c >> s:
%%      MoneyToSell         u32  挂售货币的数量
%%      MoneyToSellType     u8   挂售货币的类型 银子
%%      Price               u32  挂售价格
%%      SellTime            u8   挂售的持续时间（单位：小时）

%% s >> c:
%%      RetCode             u8   挂售成功则返回0
%%      MoneyToSell         u32  挂售货币的数量
%%      MoneyToSellType     u8   挂售货币的类型
%%      SellRecordId        u64  该上架货币对应的挂售记录唯一id


%%-------- 重新挂售过期的上架物品 （续期） -------------
-define(PT_MK_RESELL_EXPIRED_GOODS,  26003).
%% 协议号:26003
%% c >> s:
%%      SellRecordId     u64  挂售记录唯一id
%%      Price            u32  挂售价格
%%      PriceType        u8   挂售价格类型
%%      SellTime         u8   挂售的持续时间（单位：小时）

%% s >> c:
%%      RetCode          u8   取回成功则返回0，否则返回其他值（见下面定义的失败原因宏）
%%      SellRecordId     u64  挂售记录唯一id


%%-------- 取消挂售物品 -------------
-define(PT_MK_CANCEL_SELL,  26004).
%% 协议号:26004
%% c >> s:
%%      SellRecordId     u64  要取消的挂售记录唯一id

%% s >> c:
%%      RetCode          u8   挂售成功则返回0，否则返回其他值（见下面定义的失败原因宏）
%%      SellRecordId     u64  要取消的挂售记录唯一id


%%-------- 查看我的上架物品 -------------
-define(PT_MK_QUERY_MY_SELL_LIST,  26005).
%% 协议号:26005
%% c >> s:
%%		无
		
%% s >> c:
%%   	array(
%%            SellRecordId     u64  挂售记录唯一id
%%            GoodsId          u64  物品唯一id（若是货币，则为0）
%%            GoodsNo          u32  物品编号（若是货币，则为0）
%%			  StackNum         u16  物品堆叠数量（不可堆叠物品固定为1，对于挂售货币，表示所挂售的货币的数量单位是w）
%%            Price            u32  挂售价格
%%            PriceType        u8   挂售价格类型（1：游戏币， 2：人民币）
%%            SellTime         u8   挂售时间（单位：小时）
%%            LeftTime         u32  挂售剩余时间（单位：秒），若为0或负数表示挂售时间已到（负数的绝对值表示过期了多少时间）
%%            Quality          u8   物品品质
%%            Lv               u16   物品等级
%%            GoodsType        u8   物品类型  详见goods.hrl
%%		  	)


%% 查询商家物品 
-define(PT_MK_QUERY_GOODS,  26009).
%% c >> s:
%%      GoodsNo                  u32    物品编号
%%      PageIdx					u16     第几页
%%      SortType                u8      价格正反序

%% s >> c:
%%      PageIdx                u16  第几页
%%      TotalCount             u16  总物品数
%%   	array(            
%%            SellRecordId     u64  挂售记录唯一id
%%            GoodsId          u64  物品唯一id（若是货币，则为0）
%%            GoodsNo          u32  物品编号（若是货币，则为0）
%%            StackNum         u16  物品堆叠数量（不可堆叠物品固定为1，对于挂售货币，表示所挂售的货币的数量）
%%            Price            u32  挂售价格
%%            PriceType        u8   挂售价格类型
%%            SellTime         u8   挂售时间（单位：小时）
%%            LeftTime         u32  挂售剩余时间（单位：秒），若为0或负数表示挂售时间已到（负数的绝对值表示过期了多少时间）
%%            Quality          u8   物品品质
%%            Lv               u16   物品等级
%%            GoodsType        u8   物品类型（货币的物品类型为59）
%%		  	)



%%-------- 搜索上架物品（分页返回搜索结果，目前每页有6条记录） -------------
-define(PT_MK_SEARCH_SELLING_GOODS,  26006).
%% 协议号:26006
%% c >> s:
%%      Type                  u8    物品类型 （没有则为0） 100以下的详见goods.hrl  用 100 表示 消耗品下的其他类包括物品配置表里的3、7大类
%%      SubType               u8    物品子类型 （没有则为0） 详见goods.hrl 另外当type=货币类型的时候，用1,2,3,4分别表示 1万 5万 20万 100万；100表示武器
%%                                  用101表示装备表中subtype为12,13,14（对应前端显示的饰品分类） 用102表示非装备表内subtype=1,2,3,5（对应前端显示 分类 其他道具）
%%      Quality               u8    颜色限定
%%      Race                  u8    种族限定（没有则为0） 当勾选只搜索可用物品时填充自己的种族
%%      LevelMin              u16   等级限定(没有则为0)   当勾选只搜索可用物品时填充自己的等级
%%      LevelMax              u16   等级限定(没有则为0)   当勾选只搜索可用物品时填充自己的等级
%%      PriceMin              u32   价格区间
%%      PriceMax              u32
%%      Sex                   u8    性别 (没有则为0)    当勾选只搜索可用物品时填充自己的性别
%%      PageIdx               u16   页码索引（从0开始）
%%      SortType              u8     排序类型 0(默认或点击名称时)--> (品质-等级-名称-单价),1(点击等级时)--> (等级-品质-名称-单价)，
%%                                            2(点击时间时)--> (时间-品质-等级-名称-单价) 3(点击单价时)--> (单价-品质-等级-名称-时间) 
%%      SearchName            string  名字匹配（没有则为空字符串） 普通搜索只有名字和物品归类
		
%% s >> c:
%%      RetCode                u8   搜索成功返回1，否则返回其他值（见下面定义的失败原因宏）
%%      PageIdx                u16  页码索引(从0开始)
%%      TotalCount             u16  总的搜索结果物品数（客户端据此显示最大页数）
%%   	array(            
%%            SellRecordId     u64  挂售记录唯一id
%%            GoodsId          u64  物品唯一id（若是货币，则为0）
%%            GoodsNo          u32  物品编号（若是货币，则为0）
%%            StackNum         u16  物品堆叠数量（不可堆叠物品固定为1，对于挂售货币，表示所挂售的货币的数量）
%%            Price            u32  挂售价格
%%            PriceType        u8   挂售价格类型
%%            SellTime         u8   挂售时间（单位：小时）
%%            LeftTime         u32  挂售剩余时间（单位：秒），若为0或负数表示挂售时间已到（负数的绝对值表示过期了多少时间）
%%            Quality          u8   物品品质
%%            Lv               u16   物品等级
%%            GoodsType        u8   物品类型（货币的物品类型为59）
%%		  	)



%%-------- 购买上架的物品 -------------
-define(PT_MK_BUY_GOODS,  26007).
%% 协议号:26007
%% c >> s:
%%      SellRecordId     u64  挂售记录唯一id
%%      StackNum         u16  物品堆叠数量（不可堆叠物品固定为1，对于挂售货币，表示所挂售的货币的数量）

%% s >> c:
%%      RetCode          u8   购买成功则返回0
%%      SellRecordId     u64  挂售记录唯一id
%%      StackNum         u16  物品堆叠数量（不可堆叠物品固定为1，对于挂售货币，表示所挂售的货币的数量）


%%-------- 取回过期的上架物品 -------------
-define(PT_MK_GET_BACK_EXPIRED_GOODS,  26008).
%% 协议号:26008
%% c >> s:
%%      SellRecordId     u64  挂售记录唯一id

%% s >> c:
%%      RetCode          u8   取回成功则返回0
%%      SellRecordId     u64  挂售记录唯一id