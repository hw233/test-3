%% =========================================================
%% 63  商会协议
%% =========================================================



% % =========================
% 获取商会信息
-define(PT_GET_BUSINESS_ALL_INFO, 63001).
% 协议号： 63001
% C >> S:
%		Type                 	u8
%		SubType					u32
% S >> C:
%		Type                 	u8
%		SubType					u32
%     Array (
%        No				        u32                      %  配置no
%        SellCount				u32                      %  当前版本出售了多少个
%        BuyCount				u32                      %  当前版本回收了多少个
%        TotalSellCount			u32	                   	%  累计出售了多少个
%        TotalBuyCount			u32	                    %  累计回收了多少个
%        Stock				    u32                      %  当前库存
%     )
%     Array (
%       No                      u32         %  配置no
%       SellCount               u32         %  当前版本出售了多少个
%       BuyCount                u32         %  当前版本回收了多少个
%     )
    

% % =========================
% 购买物品
-define(PT_BUY_BUSINESS_GOODS, 63002).
% 协议号： 63002
% C >> S:
%     No      u32      配置编号
%	  Count   u32	  购买数量
% S >> C:
%     Code    u8      成功失败

  
 % % =========================
% 出售物品
-define(PT_SELL_BUSINESS_GOODS, 63003).
% 协议号： 63003
% C >> S:
%     GoodsId      u64      配置Id
%	  Count   u32	  出售数量
% S >> C:
%     Code    u8      成功失败


% % =========================
% 获取商会信息
-define(PT_GET_BUSINESS_SINGLE_INFO, 63004).
% 协议号： 63004
% C >> S:
%     No      u32      配置编号
% S >> C:
%     Array (
%        No				        u32                      %  配置no
%        SellCount				u32                      %  当前版本出售了多少个
%        BuyCount				u32                      %  当前版本回收了多少个
%        TotalSellCount			u32	                   	%  累计出售了多少个
%        TotalBuyCount			u32	                    %  累计回收了多少个
%        Stock				    u32                      %  当前库存
%     )
%     Array (
%       No                      u32         %  配置no
%       SellCount               u32         %  当前版本出售了多少个
%       BuyCount                u32         %  当前版本回收了多少个
%     )

% 宝石转换
-define(PT_DIAMOND_TRANSFER_INFO, 63005).
% 协议号： 63005
% C >> S:
%     CostId      u64      需要消耗的宝石编号
%     Count       u32      要转换的数量
%     GetNo       u32      要得的宝石编号

% S >> C:
%     Code        u8       成功返回1，失败返回相应的998

    
  