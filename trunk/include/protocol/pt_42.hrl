%% =========================================================
%% 42 运镖协议
%% =========================================================


% =========================
% 查询护送界面信息
% 协议号：42001
% C >> S:
% S >> C:
%   array(
%        role_id     u64    
%        role_name   string
%        role_lv     u16     人物等级 
%        truck_lv    u8      镖车等级
%        employ      u8      0:无雇佣 1:雇佣
%        cur_hijack  u8      当前劫镖次数
%        max_hijack  u8      最大劫镖次数
%        stage       u8      阶段(0-3)
%        stage_time  u32     阶段开始时间
%        array(
%            event       u8      事件
%            )
%    )
%   array(
%        news       u8       新闻类型
%        timestamp  u32
%        role_id    u64
%        name       string
%    )
%   array(
%        event      u8      事件
%    )
%   cur_hijack      u8      % 当前劫镖次数
%   max_hijack      u8      % 最大劫镖次数 
%   cur_transp      u8      % 当前运镖次数
%   max_transp      u8      % 最大运镖次数


% =========================
% 新闻推送
% 协议号：42002
% S >> C:
%        news       u8       新闻类型
%        timestamp  u32
%        role_id    u64
%        name       string


% =========================
% 事件推送
% 协议号：42003
% S >> C:
%   array(
%        event      u8      事件
%    )


% =========================
% 查询单辆车信息
% 协议号：42004
% C >> S:
%        role_id     u64
% S >> C:
%        role_id     u64    
%        role_name   string
%        role_lv     u16     人物等级 
%        truck_lv    u8      镖车等级
%        employ      u8      0:无雇佣 1:雇佣
%        cur_hijack  u8      当前劫镖次数
%        max_hijack  u8      最大劫镖次数
%        stage       u8      阶段(0-3)
%        stage_time  u32     阶段开始时间
%        array(
%            event       u8      事件
%            )


% =========================
% 查询选择信息
% 协议号：42005
% C >> S:
% S >> C:
%   cur_trunk       u8      % 当前镖车等级
%   cur_transp      u8      % 当前运镖次数
%   max_transp      u8      % 最大运镖次数
%   book_num        u32     % 镖书数量
%   state           u8      % 0：正常 1：正在押镖


% =========================
% 开始押镖
% 协议号：42006
% C >> S:
% S >> C:
%   state       u8      % 0:失败 1:成功


% =========================
% 金钱进阶
% 协议号：42007
% C >> S:
% S >> C:
%   state       u8      0:进阶失败 1:进阶成功 


% =========================
% 物品进阶
% 协议号：42008
% C >> S:
% S >> C:
%   state       u8      0:进阶失败 1:进阶成功 


% =========================
% 直接召唤
% 协议号：42009
% C >> S:
% S >> C:
%   state       u8      0:进阶失败 1:进阶成功 


% =========================
% 劫镖
% 协议号：42010
% C >> S:
%        role_id     u64


% =========================
% 刷新镖车
% 协议号：42011
% C >> S:
% S >> C:
%   array(
%        role_id     u64    
%        role_name   string
%        role_lv     u16     人物等级 
%        truck_lv    u8      镖车等级
%        employ      u8      0:无雇佣 1:雇佣
%        cur_hijack  u8      当前劫镖次数
%        max_hijack  u8      最大劫镖次数
%        stage       u8      阶段(0-3)
%        stage_time  u32     阶段开始时间
%        array(
%            event       u8      事件
%            )
%    )
%   array(
%        news       u8       新闻类型
%        timestamp  u32
%        role_id    u64
%        name       string
%    )
%   array(
%        event      u8      事件
%    )
%   cur_hijack      u8      % 当前劫镖次数
%   max_hijack      u8      % 最大劫镖次数
%   cur_transp      u8      % 当前运镖次数
%   max_transp      u8      % 最大运镖次数

% =========================
% 免费进阶
% 协议号：42012
% C >> S:
% S >> C:
%   state       u8      0:进阶失败 1:进阶成功 