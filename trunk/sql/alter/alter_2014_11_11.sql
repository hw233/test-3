
use simserver;


ALTER TABLE `player_misc` ADD COLUMN `buy_goods_from_op_shop` blob NOT NULL COMMENT '运营后台商店某些物品的购买列表，格式如：[{GoodsNo, Count,LastBuyTime}, ...]';
