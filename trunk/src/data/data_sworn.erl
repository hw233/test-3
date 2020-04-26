%%%---------------------------------------
%%% @Module  : data_sworn
%%% @Author  : zwq
%%% @Email   : 
%%% @Description:  结拜随机称号表
%%%---------------------------------------


-module(data_sworn).
-include("common.hrl").
-include("record.hrl").
-include("relation.hrl").
-compile(export_all).

get_all_group_no_list()->
	[1].

get_all_no_list()->
	[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200].

get_no_list_by_group(1)->
	[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200].


				get_prefix(1) -> <<"金兰">>
			;

				get_prefix(2) -> <<"初唐">>
			;

				get_prefix(3) -> <<"孤独">>
			;

				get_prefix(4) -> <<"联盟">>
			;

				get_prefix(5) -> <<"烟雨">>
			;

				get_prefix(6) -> <<"无忌">>
			;

				get_prefix(7) -> <<"如晦">>
			;

				get_prefix(8) -> <<"蝶舞">>
			;

				get_prefix(9) -> <<"绝恋">>
			;

				get_prefix(10) -> <<"缠绵">>
			;

				get_prefix(11) -> <<"星愿">>
			;

				get_prefix(12) -> <<"落霞">>
			;

				get_prefix(13) -> <<"御神">>
			;

				get_prefix(14) -> <<"碎星">>
			;

				get_prefix(15) -> <<"无双">>
			;

				get_prefix(16) -> <<"流风">>
			;

				get_prefix(17) -> <<"残雪">>
			;

				get_prefix(18) -> <<"长生">>
			;

				get_prefix(19) -> <<"绮秀">>
			;

				get_prefix(20) -> <<"穿杨">>
			;

				get_prefix(21) -> <<"天绝">>
			;

				get_prefix(22) -> <<"鬼斧">>
			;

				get_prefix(23) -> <<"识智">>
			;

				get_prefix(24) -> <<"虚空">>
			;

				get_prefix(25) -> <<"缘灭">>
			;

				get_prefix(26) -> <<"除恶">>
			;

				get_prefix(27) -> <<"精通">>
			;

				get_prefix(28) -> <<"金刚">>
			;

				get_prefix(29) -> <<"赤颜">>
			;

				get_prefix(30) -> <<"追梦">>
			;

				get_prefix(31) -> <<"百变">>
			;

				get_prefix(32) -> <<"百晓">>
			;

				get_prefix(33) -> <<"浩然">>
			;

				get_prefix(34) -> <<"踏月">>
			;

				get_prefix(35) -> <<"断肠">>
			;

				get_prefix(36) -> <<"长恨">>
			;

				get_prefix(37) -> <<"绝情">>
			;

				get_prefix(38) -> <<"潇洒">>
			;

				get_prefix(39) -> <<"不败">>
			;

				get_prefix(40) -> <<"健壮">>
			;

				get_prefix(41) -> <<"淡然">>
			;

				get_prefix(42) -> <<"文静">>
			;

				get_prefix(43) -> <<"帅气">>
			;

				get_prefix(44) -> <<"缥缈">>
			;

				get_prefix(45) -> <<"紫萱">>
			;

				get_prefix(46) -> <<"浩瀚">>
			;

				get_prefix(47) -> <<"逐风">>
			;

				get_prefix(48) -> <<"沧澜">>
			;

				get_prefix(49) -> <<"鸿鹄">>
			;

				get_prefix(50) -> <<"如梦">>
			;

				get_prefix(51) -> <<"涟漪">>
			;

				get_prefix(52) -> <<"暖阳">>
			;

				get_prefix(53) -> <<"半夏">>
			;

				get_prefix(54) -> <<"矜柔">>
			;

				get_prefix(55) -> <<"绚烂">>
			;

				get_prefix(56) -> <<"明媚">>
			;

				get_prefix(57) -> <<"迷离">>
			;

				get_prefix(58) -> <<"隐忍">>
			;

				get_prefix(59) -> <<"灼热">>
			;

				get_prefix(60) -> <<"幻灭">>
			;

				get_prefix(61) -> <<"锦瑟">>
			;

				get_prefix(62) -> <<"妖娆">>
			;

				get_prefix(63) -> <<"邪殇">>
			;

				get_prefix(64) -> <<"离殇">>
			;

				get_prefix(65) -> <<"夕颜">>
			;

				get_prefix(66) -> <<"寂寞">>
			;

				get_prefix(67) -> <<"浅唱">>
			;

				get_prefix(68) -> <<"金兰">>
			;

				get_prefix(69) -> <<"初唐">>
			;

				get_prefix(70) -> <<"孤独">>
			;

				get_prefix(71) -> <<"联盟">>
			;

				get_prefix(72) -> <<"烟雨">>
			;

				get_prefix(73) -> <<"无忌">>
			;

				get_prefix(74) -> <<"如晦">>
			;

				get_prefix(75) -> <<"蝶舞">>
			;

				get_prefix(76) -> <<"绝恋">>
			;

				get_prefix(77) -> <<"缠绵">>
			;

				get_prefix(78) -> <<"星愿">>
			;

				get_prefix(79) -> <<"落霞">>
			;

				get_prefix(80) -> <<"御神">>
			;

				get_prefix(81) -> <<"碎星">>
			;

				get_prefix(82) -> <<"无双">>
			;

				get_prefix(83) -> <<"流风">>
			;

				get_prefix(84) -> <<"金兰">>
			;

				get_prefix(85) -> <<"金兰">>
			;

				get_prefix(86) -> <<"金兰">>
			;

				get_prefix(87) -> <<"金兰">>
			;

				get_prefix(88) -> <<"金兰">>
			;

				get_prefix(89) -> <<"金兰">>
			;

				get_prefix(90) -> <<"金兰">>
			;

				get_prefix(91) -> <<"金兰">>
			;

				get_prefix(92) -> <<"金兰">>
			;

				get_prefix(93) -> <<"金兰">>
			;

				get_prefix(94) -> <<"金兰">>
			;

				get_prefix(95) -> <<"金兰">>
			;

				get_prefix(96) -> <<"金兰">>
			;

				get_prefix(97) -> <<"金兰">>
			;

				get_prefix(98) -> <<"金兰">>
			;

				get_prefix(99) -> <<"金兰">>
			;

				get_prefix(100) -> <<"金兰">>
			;

				get_prefix(101) -> <<"金兰">>
			;

				get_prefix(102) -> <<"金兰">>
			;

				get_prefix(103) -> <<"金兰">>
			;

				get_prefix(104) -> <<"金兰">>
			;

				get_prefix(105) -> <<"金兰">>
			;

				get_prefix(106) -> <<"金兰">>
			;

				get_prefix(107) -> <<"金兰">>
			;

				get_prefix(108) -> <<"金兰">>
			;

				get_prefix(109) -> <<"金兰">>
			;

				get_prefix(110) -> <<"金兰">>
			;

				get_prefix(111) -> <<"金兰">>
			;

				get_prefix(112) -> <<"金兰">>
			;

				get_prefix(113) -> <<"金兰">>
			;

				get_prefix(114) -> <<"金兰">>
			;

				get_prefix(115) -> <<"金兰">>
			;

				get_prefix(116) -> <<"金兰">>
			;

				get_prefix(117) -> <<"金兰">>
			;

				get_prefix(118) -> <<"金兰">>
			;

				get_prefix(119) -> <<"金兰">>
			;

				get_prefix(120) -> <<"金兰">>
			;

				get_prefix(121) -> <<"金兰">>
			;

				get_prefix(122) -> <<"金兰">>
			;

				get_prefix(123) -> <<"金兰">>
			;

				get_prefix(124) -> <<"金兰">>
			;

				get_prefix(125) -> <<"金兰">>
			;

				get_prefix(126) -> <<"金兰">>
			;

				get_prefix(127) -> <<"金兰">>
			;

				get_prefix(128) -> <<"金兰">>
			;

				get_prefix(129) -> <<"金兰">>
			;

				get_prefix(130) -> <<"金兰">>
			;

				get_prefix(131) -> <<"金兰">>
			;

				get_prefix(132) -> <<"金兰">>
			;

				get_prefix(133) -> <<"金兰">>
			;

				get_prefix(134) -> <<"金兰">>
			;

				get_prefix(135) -> <<"金兰">>
			;

				get_prefix(136) -> <<"金兰">>
			;

				get_prefix(137) -> <<"金兰">>
			;

				get_prefix(138) -> <<"金兰">>
			;

				get_prefix(139) -> <<"金兰">>
			;

				get_prefix(140) -> <<"金兰">>
			;

				get_prefix(141) -> <<"金兰">>
			;

				get_prefix(142) -> <<"金兰">>
			;

				get_prefix(143) -> <<"金兰">>
			;

				get_prefix(144) -> <<"金兰">>
			;

				get_prefix(145) -> <<"金兰">>
			;

				get_prefix(146) -> <<"金兰">>
			;

				get_prefix(147) -> <<"金兰">>
			;

				get_prefix(148) -> <<"金兰">>
			;

				get_prefix(149) -> <<"金兰">>
			;

				get_prefix(150) -> <<"金兰">>
			;

				get_prefix(151) -> <<"金兰">>
			;

				get_prefix(152) -> <<"金兰">>
			;

				get_prefix(153) -> <<"金兰">>
			;

				get_prefix(154) -> <<"金兰">>
			;

				get_prefix(155) -> <<"金兰">>
			;

				get_prefix(156) -> <<"金兰">>
			;

				get_prefix(157) -> <<"金兰">>
			;

				get_prefix(158) -> <<"金兰">>
			;

				get_prefix(159) -> <<"金兰">>
			;

				get_prefix(160) -> <<"金兰">>
			;

				get_prefix(161) -> <<"金兰">>
			;

				get_prefix(162) -> <<"金兰">>
			;

				get_prefix(163) -> <<"金兰">>
			;

				get_prefix(164) -> <<"金兰">>
			;

				get_prefix(165) -> <<"金兰">>
			;

				get_prefix(166) -> <<"金兰">>
			;

				get_prefix(167) -> <<"金兰">>
			;

				get_prefix(168) -> <<"金兰">>
			;

				get_prefix(169) -> <<"金兰">>
			;

				get_prefix(170) -> <<"金兰">>
			;

				get_prefix(171) -> <<"金兰">>
			;

				get_prefix(172) -> <<"金兰">>
			;

				get_prefix(173) -> <<"金兰">>
			;

				get_prefix(174) -> <<"金兰">>
			;

				get_prefix(175) -> <<"金兰">>
			;

				get_prefix(176) -> <<"金兰">>
			;

				get_prefix(177) -> <<"金兰">>
			;

				get_prefix(178) -> <<"金兰">>
			;

				get_prefix(179) -> <<"金兰">>
			;

				get_prefix(180) -> <<"金兰">>
			;

				get_prefix(181) -> <<"金兰">>
			;

				get_prefix(182) -> <<"金兰">>
			;

				get_prefix(183) -> <<"金兰">>
			;

				get_prefix(184) -> <<"金兰">>
			;

				get_prefix(185) -> <<"金兰">>
			;

				get_prefix(186) -> <<"金兰">>
			;

				get_prefix(187) -> <<"金兰">>
			;

				get_prefix(188) -> <<"金兰">>
			;

				get_prefix(189) -> <<"金兰">>
			;

				get_prefix(190) -> <<"金兰">>
			;

				get_prefix(191) -> <<"金兰">>
			;

				get_prefix(192) -> <<"金兰">>
			;

				get_prefix(193) -> <<"金兰">>
			;

				get_prefix(194) -> <<"金兰">>
			;

				get_prefix(195) -> <<"金兰">>
			;

				get_prefix(196) -> <<"金兰">>
			;

				get_prefix(197) -> <<"金兰">>
			;

				get_prefix(198) -> <<"金兰">>
			;

				get_prefix(199) -> <<"金兰">>
			;

				get_prefix(200) -> <<"金兰">>
			;

				get_prefix(_No) ->
					null.
		

				get_suffix(1) -> <<"之一箭双雕">>
			;

				get_suffix(2) -> <<"之一语双关">>
			;

				get_suffix(3) -> <<"之德艺双馨">>
			;

				get_suffix(4) -> <<"之比翼双飞">>
			;

				get_suffix(5) -> <<"之双栖双宿">>
			;

				get_suffix(6) -> <<"之福无双至">>
			;

				get_suffix(7) -> <<"之智勇双全">>
			;

				get_suffix(8) -> <<"之盖世无双">>
			;

				get_suffix(9) -> <<"之文武双全">>
			;

				get_suffix(10) -> <<"之天下无双">>
			;

				get_suffix(11) -> <<"之才貌双全">>
			;

				get_suffix(12) -> <<"之双宿双飞">>
			;

				get_suffix(13) -> <<"之一矢双穿">>
			;

				get_suffix(14) -> <<"之福禄双全">>
			;

				get_suffix(15) -> <<"之退避三舍">>
			;

				get_suffix(16) -> <<"之入木三分">>
			;

				get_suffix(17) -> <<"之狡兔三窟">>
			;

				get_suffix(18) -> <<"之约法三章">>
			;

				get_suffix(19) -> <<"之垂涎三尺">>
			;

				get_suffix(20) -> <<"之一日三秋">>
			;

				get_suffix(21) -> <<"之行尸走肉">>
			;

				get_suffix(22) -> <<"之金蝉脱壳">>
			;

				get_suffix(23) -> <<"之百里挑一">>
			;

				get_suffix(24) -> <<"之金玉满堂">>
			;

				get_suffix(25) -> <<"之背水一战">>
			;

				get_suffix(26) -> <<"之霸王别姬">>
			;

				get_suffix(27) -> <<"之天上人间">>
			;

				get_suffix(28) -> <<"之不吐不快">>
			;

				get_suffix(29) -> <<"之海阔天空">>
			;

				get_suffix(30) -> <<"之情非得已">>
			;

				get_suffix(31) -> <<"之满腹经纶">>
			;

				get_suffix(32) -> <<"之兵临城下">>
			;

				get_suffix(33) -> <<"之春暖花开">>
			;

				get_suffix(34) -> <<"之插翅难逃">>
			;

				get_suffix(35) -> <<"之黄道吉日">>
			;

				get_suffix(36) -> <<"之天下无双">>
			;

				get_suffix(37) -> <<"之偷天换日">>
			;

				get_suffix(38) -> <<"之两小无猜">>
			;

				get_suffix(39) -> <<"之卧虎藏龙">>
			;

				get_suffix(40) -> <<"之珠光宝气">>
			;

				get_suffix(41) -> <<"之簪缨世族">>
			;

				get_suffix(42) -> <<"之花花公子">>
			;

				get_suffix(43) -> <<"之绘声绘影">>
			;

				get_suffix(44) -> <<"之国色天香">>
			;

				get_suffix(45) -> <<"之相亲相爱">>
			;

				get_suffix(46) -> <<"之八仙过海">>
			;

				get_suffix(47) -> <<"之金玉良缘">>
			;

				get_suffix(48) -> <<"之掌上明珠">>
			;

				get_suffix(49) -> <<"之皆大欢喜">>
			;

				get_suffix(50) -> <<"之逍遥法外">>
			;

				get_suffix(51) -> <<"之画地为牢">>
			;

				get_suffix(52) -> <<"之岁寒三友">>
			;

				get_suffix(53) -> <<"之花花世界">>
			;

				get_suffix(54) -> <<"之纸醉金迷">>
			;

				get_suffix(55) -> <<"之狐假虎威">>
			;

				get_suffix(56) -> <<"之纵横捭阖">>
			;

				get_suffix(57) -> <<"之沧海桑田">>
			;

				get_suffix(58) -> <<"之暴殄天物">>
			;

				get_suffix(59) -> <<"之吃喝玩乐">>
			;

				get_suffix(60) -> <<"之乐不思蜀">>
			;

				get_suffix(61) -> <<"之身不由己">>
			;

				get_suffix(62) -> <<"之小家碧玉">>
			;

				get_suffix(63) -> <<"之文不加点">>
			;

				get_suffix(64) -> <<"之天马行空">>
			;

				get_suffix(65) -> <<"之人来人往">>
			;

				get_suffix(66) -> <<"之千方百计">>
			;

				get_suffix(67) -> <<"之天高地厚">>
			;

				get_suffix(68) -> <<"之争分夺秒">>
			;

				get_suffix(69) -> <<"之如火如荼">>
			;

				get_suffix(70) -> <<"之如痴如醉">>
			;

				get_suffix(71) -> <<"之大智若愚">>
			;

				get_suffix(72) -> <<"之斗转星移">>
			;

				get_suffix(73) -> <<"之七情六欲">>
			;

				get_suffix(74) -> <<"之大禹治水">>
			;

				get_suffix(75) -> <<"之空穴来风">>
			;

				get_suffix(76) -> <<"之九五之尊">>
			;

				get_suffix(77) -> <<"之随心所欲">>
			;

				get_suffix(78) -> <<"之干将莫邪">>
			;

				get_suffix(79) -> <<"之相得益彰">>
			;

				get_suffix(80) -> <<"之借刀杀人">>
			;

				get_suffix(81) -> <<"之浪迹天涯">>
			;

				get_suffix(82) -> <<"之镜花水月">>
			;

				get_suffix(83) -> <<"之黔驴技穷">>
			;

				get_suffix(84) -> <<"之肝胆相照">>
			;

				get_suffix(85) -> <<"之多多益善">>
			;

				get_suffix(86) -> <<"之叱咤风云">>
			;

				get_suffix(87) -> <<"之杞人忧天">>
			;

				get_suffix(88) -> <<"之作茧自缚">>
			;

				get_suffix(89) -> <<"之一飞冲天">>
			;

				get_suffix(90) -> <<"之殊途同归">>
			;

				get_suffix(91) -> <<"之风卷残云">>
			;

				get_suffix(92) -> <<"之因果报应">>
			;

				get_suffix(93) -> <<"之无可厚非">>
			;

				get_suffix(94) -> <<"之赶尽杀绝">>
			;

				get_suffix(95) -> <<"之天长地久">>
			;

				get_suffix(96) -> <<"之飞龙在天">>
			;

				get_suffix(97) -> <<"之桃之夭夭">>
			;

				get_suffix(98) -> <<"之南柯一梦">>
			;

				get_suffix(99) -> <<"之口是心非">>
			;

				get_suffix(100) -> <<"之江山如画">>
			;

				get_suffix(101) -> <<"之风华正茂">>
			;

				get_suffix(102) -> <<"之一叶知秋">>
			;

				get_suffix(103) -> <<"之情不自禁">>
			;

				get_suffix(104) -> <<"之愚公移山">>
			;

				get_suffix(105) -> <<"之魑魅魍魉">>
			;

				get_suffix(106) -> <<"之海市蜃楼">>
			;

				get_suffix(107) -> <<"之高山流水">>
			;

				get_suffix(108) -> <<"之卧薪尝胆">>
			;

				get_suffix(109) -> <<"之壮志凌云">>
			;

				get_suffix(110) -> <<"之金枝玉叶">>
			;

				get_suffix(111) -> <<"之四海一家">>
			;

				get_suffix(112) -> <<"之穿针引线">>
			;

				get_suffix(113) -> <<"之无忧无虑">>
			;

				get_suffix(114) -> <<"之无地自容">>
			;

				get_suffix(115) -> <<"之三位一体">>
			;

				get_suffix(116) -> <<"之落叶归根">>
			;

				get_suffix(117) -> <<"之相见恨晚">>
			;

				get_suffix(118) -> <<"之惊天动地">>
			;

				get_suffix(119) -> <<"之落花流水">>
			;

				get_suffix(120) -> <<"之滔滔不绝">>
			;

				get_suffix(121) -> <<"之相濡以沫">>
			;

				get_suffix(122) -> <<"之万箭穿心">>
			;

				get_suffix(123) -> <<"之水木清华">>
			;

				get_suffix(124) -> <<"之窈窕淑女">>
			;

				get_suffix(125) -> <<"之破釜沉舟">>
			;

				get_suffix(126) -> <<"之天涯海角">>
			;

				get_suffix(127) -> <<"之牛郎织女">>
			;

				get_suffix(128) -> <<"之倾国倾城">>
			;

				get_suffix(129) -> <<"之飘飘欲仙">>
			;

				get_suffix(130) -> <<"之福星高照">>
			;

				get_suffix(131) -> <<"之妄自菲薄">>
			;

				get_suffix(132) -> <<"之永无止境">>
			;

				get_suffix(133) -> <<"之学富五车">>
			;

				get_suffix(134) -> <<"之饮食男女">>
			;

				get_suffix(135) -> <<"之英雄豪杰">>
			;

				get_suffix(136) -> <<"之国士无双">>
			;

				get_suffix(137) -> <<"之塞翁失马">>
			;

				get_suffix(138) -> <<"之万家灯火">>
			;

				get_suffix(139) -> <<"之石破天惊">>
			;

				get_suffix(140) -> <<"之覆雨翻云">>
			;

				get_suffix(141) -> <<"之六道轮回">>
			;

				get_suffix(142) -> <<"之鹰击长空">>
			;

				get_suffix(143) -> <<"之日日夜夜">>
			;

				get_suffix(144) -> <<"之厚德载物">>
			;

				get_suffix(145) -> <<"之亡羊补牢">>
			;

				get_suffix(146) -> <<"之黄金时代">>
			;

				get_suffix(147) -> <<"之出生入死">>
			;

				get_suffix(148) -> <<"之随遇而安">>
			;

				get_suffix(149) -> <<"之千军万马">>
			;

				get_suffix(150) -> <<"之后会无期">>
			;

				get_suffix(151) -> <<"之守株待兔">>
			;

				get_suffix(152) -> <<"之一生一世">>
			;

				get_suffix(153) -> <<"之花好月圆">>
			;

				get_suffix(154) -> <<"之世外桃源">>
			;

				get_suffix(155) -> <<"之韬光养晦">>
			;

				get_suffix(156) -> <<"之画蛇添足">>
			;

				get_suffix(157) -> <<"之青梅竹马">>
			;

				get_suffix(158) -> <<"之风花雪月">>
			;

				get_suffix(159) -> <<"之欣欣向荣">>
			;

				get_suffix(160) -> <<"之时光荏苒">>
			;

				get_suffix(161) -> <<"之好好先生">>
			;

				get_suffix(162) -> <<"之无懈可击">>
			;

				get_suffix(163) -> <<"之随波逐流">>
			;

				get_suffix(164) -> <<"之袖手旁观">>
			;

				get_suffix(165) -> <<"之群雄逐鹿">>
			;

				get_suffix(166) -> <<"之血战到底">>
			;

				get_suffix(167) -> <<"之唯我独尊">>
			;

				get_suffix(168) -> <<"之买椟还珠">>
			;

				get_suffix(169) -> <<"之龙马精神">>
			;

				get_suffix(170) -> <<"之一见钟情">>
			;

				get_suffix(171) -> <<"之喜闻乐见">>
			;

				get_suffix(172) -> <<"之负荆请罪">>
			;

				get_suffix(173) -> <<"之河东狮吼">>
			;

				get_suffix(174) -> <<"之金戈铁马">>
			;

				get_suffix(175) -> <<"之笑逐颜开">>
			;

				get_suffix(176) -> <<"之千钧一发">>
			;

				get_suffix(177) -> <<"之纸上谈兵">>
			;

				get_suffix(178) -> <<"之风和日丽">>
			;

				get_suffix(179) -> <<"之甜言蜜语">>
			;

				get_suffix(180) -> <<"之雷霆万钧">>
			;

				get_suffix(181) -> <<"之浮生若梦">>
			;

				get_suffix(182) -> <<"之大开眼界">>
			;

				get_suffix(183) -> <<"之百鸟朝凤">>
			;

				get_suffix(184) -> <<"之以德服人">>
			;

				get_suffix(185) -> <<"之白驹过隙">>
			;

				get_suffix(186) -> <<"之难兄难弟">>
			;

				get_suffix(187) -> <<"之最佳损友">>
			;

				get_suffix(188) -> <<"之鬼哭神嚎">>
			;

				get_suffix(189) -> <<"之声色犬马">>
			;

				get_suffix(190) -> <<"之指鹿为马">>
			;

				get_suffix(191) -> <<"之龙争虎斗">>
			;

				get_suffix(192) -> <<"之雾里看花">>
			;

				get_suffix(193) -> <<"之未雨绸缪">>
			;

				get_suffix(194) -> <<"之南辕北辙">>
			;

				get_suffix(195) -> <<"之三从四德">>
			;

				get_suffix(196) -> <<"之一丝不挂">>
			;

				get_suffix(197) -> <<"之高屋建瓴">>
			;

				get_suffix(198) -> <<"之诸子百家">>
			;

				get_suffix(199) -> <<"之鬼迷心窍">>
			;

				get_suffix(200) -> <<"之星火燎原">>
			;

				get_suffix(_No) ->
					null.
		
