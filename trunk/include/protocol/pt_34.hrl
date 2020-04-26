%% ################################################
%% pt_34.hrl
%% 节日运营活动相关协议
%% ################################################

-define(PT_AD_GET_GOODS, 34000).
%% 通过活动领取物品
%% C >> S :
%%      无
%% S >> C
%%      RetCode     u8      结果码(0 成功，并向对方发送求婚协议)


-define(PT_AD_GIVE_GIFT, 34001).
%% 给好友赠送礼物
%% C >> S :
%%      PlayerId     u64        目标玩家id
%%      BlessingNo   u32        祝福语编号
%%      Type         u8         发送方式（1普通发送；2诚意发送）

%% S >> C
%%      RetCode     u8      结果码(0 成功，并向对方发送求婚协议)
%%      Type        u8         发送方式（1普通发送；2诚意发送）

-define(PT_AD_GET_GIFT, 34002).
%% 领取好友赠送的礼物
%% C >> S :
%%      无
%% S >> C
%%      RetCode     u8      结果码(0 成功，并向对方发送求婚协议)

-define(PT_AD_SHOW_BRESS, 34003).
%% 使用祝福礼包，祝福语提示
%% C >> S:
%%      无
%% S >> C:
%%      BlessingNo      u32        祝福语编号
%%      FromPlayerId    u64        来自玩家id
%%      FromPlayerName  string     来自玩家名字
