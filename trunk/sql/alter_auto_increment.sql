
use simserver;

-- 注意：此文件只有在新部署服务器时才会被执行，如果在已有服务器添加有类似需求的表，为安全起见，需要也建议让DBA手动执行，部署工具sql对比功能不支持对比出下面的语句
-- AUTO_INCREMENT前三位数表示平台号，后续4位数表示平台内的服务器编号，最后的11位数字表示服务器内的流水号（注：数字是十进制的）
-- 下面的insert语句是适应mysql5.6版本AUTO_INCREMENT的bug(http://bugs.mysql.com/bug.php?id=74112)

alter table `partner` AUTO_INCREMENT=001000100000000001;
insert into `partner` () values ();

alter table `partner_hotel` AUTO_INCREMENT=001000100000000001;
insert into `partner_hotel` () values ();

alter table `guild` AUTO_INCREMENT=001000100000000001;
insert into `guild` (member_list, request_joining_list, login_id_list, bid_id_list) values ('', '', '', '');

alter table `goods` AUTO_INCREMENT=001000100000000001;
insert into `goods` () values ();

alter table `market_selling` AUTO_INCREMENT=001000100000000001;
insert into `market_selling` () values ();

alter table `mail` AUTO_INCREMENT=001000100000000001;
insert into `mail` (title,content,attach) values ('','','');

alter table `relation` AUTO_INCREMENT=001000100000000001;
insert into `relation` () values ();

alter table `recharge_feedback` AUTO_INCREMENT=001000100000000001;
insert into `recharge_feedback` () values ();

alter table `mount` AUTO_INCREMENT=001000100000000001;
insert into `mount` () values ();