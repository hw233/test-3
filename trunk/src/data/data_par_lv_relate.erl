%%%---------------------------------------
%%% @Module  : data_par_lv_relate
%%% @Author  : zwq
%%% @Email   : 
%%% @Description:  宠物相关
%%%---------------------------------------


-module(data_par_lv_relate).
-include("common.hrl").
-include("record.hrl").
-include("partner.hrl").
-include("num_limits.hrl").
-compile(export_all).


				get_exp_lim(1) -> 1088
			;

				get_exp_lim(2) -> 1286
			;

				get_exp_lim(3) -> 1519
			;

				get_exp_lim(4) -> 1776
			;

				get_exp_lim(5) -> 2053
			;

				get_exp_lim(6) -> 2348
			;

				get_exp_lim(7) -> 2658
			;

				get_exp_lim(8) -> 2981
			;

				get_exp_lim(9) -> 3317
			;

				get_exp_lim(10) -> 3664
			;

				get_exp_lim(11) -> 4022
			;

				get_exp_lim(12) -> 4390
			;

				get_exp_lim(13) -> 4767
			;

				get_exp_lim(14) -> 5153
			;

				get_exp_lim(15) -> 5547
			;

				get_exp_lim(16) -> 5949
			;

				get_exp_lim(17) -> 6359
			;

				get_exp_lim(18) -> 6776
			;

				get_exp_lim(19) -> 7200
			;

				get_exp_lim(20) -> 7631
			;

				get_exp_lim(21) -> 8068
			;

				get_exp_lim(22) -> 8512
			;

				get_exp_lim(23) -> 8962
			;

				get_exp_lim(24) -> 9418
			;

				get_exp_lim(25) -> 9879
			;

				get_exp_lim(26) -> 10346
			;

				get_exp_lim(27) -> 10818
			;

				get_exp_lim(28) -> 11296
			;

				get_exp_lim(29) -> 11779
			;

				get_exp_lim(30) -> 12267
			;

				get_exp_lim(31) -> 12759
			;

				get_exp_lim(32) -> 14583
			;

				get_exp_lim(33) -> 15135
			;

				get_exp_lim(34) -> 15693
			;

				get_exp_lim(35) -> 16255
			;

				get_exp_lim(36) -> 16822
			;

				get_exp_lim(37) -> 17394
			;

				get_exp_lim(38) -> 17971
			;

				get_exp_lim(39) -> 18552
			;

				get_exp_lim(40) -> 19138
			;

				get_exp_lim(41) -> 19728
			;

				get_exp_lim(42) -> 20323
			;

				get_exp_lim(43) -> 20921
			;

				get_exp_lim(44) -> 21524
			;

				get_exp_lim(45) -> 22131
			;

				get_exp_lim(46) -> 22743
			;

				get_exp_lim(47) -> 23358
			;

				get_exp_lim(48) -> 23977
			;

				get_exp_lim(49) -> 24600
			;

				get_exp_lim(50) -> 25227
			;

				get_exp_lim(51) -> 25857
			;

				get_exp_lim(52) -> 26491
			;

				get_exp_lim(53) -> 27129
			;

				get_exp_lim(54) -> 27771
			;

				get_exp_lim(55) -> 28416
			;

				get_exp_lim(56) -> 29065
			;

				get_exp_lim(57) -> 29717
			;

				get_exp_lim(58) -> 30372
			;

				get_exp_lim(59) -> 31031
			;

				get_exp_lim(60) -> 31694
			;

				get_exp_lim(61) -> 32359
			;

				get_exp_lim(62) -> 33028
			;

				get_exp_lim(63) -> 33701
			;

				get_exp_lim(64) -> 37501
			;

				get_exp_lim(65) -> 38241
			;

				get_exp_lim(66) -> 38985
			;

				get_exp_lim(67) -> 39732
			;

				get_exp_lim(68) -> 40483
			;

				get_exp_lim(69) -> 41236
			;

				get_exp_lim(70) -> 41993
			;

				get_exp_lim(71) -> 42754
			;

				get_exp_lim(72) -> 43517
			;

				get_exp_lim(73) -> 44284
			;

				get_exp_lim(74) -> 45054
			;

				get_exp_lim(75) -> 45827
			;

				get_exp_lim(76) -> 46603
			;

				get_exp_lim(77) -> 47382
			;

				get_exp_lim(78) -> 48164
			;

				get_exp_lim(79) -> 48949
			;

				get_exp_lim(80) -> 49737
			;

				get_exp_lim(81) -> 50529
			;

				get_exp_lim(82) -> 51323
			;

				get_exp_lim(83) -> 56463
			;

				get_exp_lim(84) -> 57330
			;

				get_exp_lim(85) -> 58199
			;

				get_exp_lim(86) -> 59072
			;

				get_exp_lim(87) -> 59948
			;

				get_exp_lim(88) -> 60826
			;

				get_exp_lim(89) -> 61708
			;

				get_exp_lim(90) -> 62593
			;

				get_exp_lim(91) -> 63481
			;

				get_exp_lim(92) -> 64371
			;

				get_exp_lim(93) -> 65265
			;

				get_exp_lim(94) -> 66161
			;

				get_exp_lim(95) -> 67061
			;

				get_exp_lim(96) -> 73191
			;

				get_exp_lim(97) -> 74165
			;

				get_exp_lim(98) -> 75143
			;

				get_exp_lim(99) -> 76124
			;

				get_exp_lim(100) -> 77107
			;

				get_exp_lim(101) -> 78094
			;

				get_exp_lim(102) -> 79083
			;

				get_exp_lim(103) -> 80076
			;

				get_exp_lim(104) -> 81071
			;

				get_exp_lim(105) -> 82069
			;

				get_exp_lim(106) -> 89004
			;

				get_exp_lim(107) -> 90079
			;

				get_exp_lim(108) -> 91158
			;

				get_exp_lim(109) -> 92239
			;

				get_exp_lim(110) -> 93324
			;

				get_exp_lim(111) -> 94412
			;

				get_exp_lim(112) -> 95502
			;

				get_exp_lim(113) -> 96595
			;

				get_exp_lim(114) -> 97692
			;

				get_exp_lim(115) -> 105377
			;

				get_exp_lim(116) -> 106552
			;

				get_exp_lim(117) -> 107731
			;

				get_exp_lim(118) -> 108913
			;

				get_exp_lim(119) -> 110097
			;

				get_exp_lim(120) -> 111285
			;

				get_exp_lim(121) -> 112475
			;

				get_exp_lim(122) -> 120773
			;

				get_exp_lim(123) -> 122044
			;

				get_exp_lim(124) -> 137827
			;

				get_exp_lim(125) -> 139255
			;

				get_exp_lim(126) -> 140686
			;

				get_exp_lim(127) -> 142120
			;

				get_exp_lim(128) -> 143558
			;

				get_exp_lim(129) -> 145000
			;

				get_exp_lim(130) -> 146444
			;

				get_exp_lim(131) -> 147892
			;

				get_exp_lim(132) -> 149344
			;

				get_exp_lim(133) -> 150798
			;

				get_exp_lim(134) -> 152256
			;

				get_exp_lim(135) -> 153718
			;

				get_exp_lim(136) -> 155182
			;

				get_exp_lim(137) -> 164894
			;

				get_exp_lim(138) -> 166443
			;

				get_exp_lim(139) -> 167994
			;

				get_exp_lim(140) -> 169549
			;

				get_exp_lim(141) -> 171108
			;

				get_exp_lim(142) -> 172670
			;

				get_exp_lim(143) -> 174235
			;

				get_exp_lim(144) -> 175803
			;

				get_exp_lim(145) -> 177374
			;

				get_exp_lim(146) -> 178949
			;

				get_exp_lim(147) -> 180527
			;

				get_exp_lim(148) -> 191214
			;

				get_exp_lim(149) -> 192878
			;

				get_exp_lim(150) -> 194545
			;

				get_exp_lim(151) -> 196215
			;

				get_exp_lim(152) -> 197889
			;

				get_exp_lim(153) -> 199566
			;

				get_exp_lim(154) -> 201246
			;

				get_exp_lim(155) -> 202930
			;

				get_exp_lim(156) -> 204617
			;

				get_exp_lim(157) -> 216131
			;

				get_exp_lim(158) -> 217905
			;

				get_exp_lim(159) -> 219682
			;

				get_exp_lim(160) -> 221463
			;

				get_exp_lim(161) -> 223247
			;

				get_exp_lim(162) -> 225034
			;

				get_exp_lim(163) -> 226825
			;

				get_exp_lim(164) -> 228619
			;

				get_exp_lim(165) -> 240890
			;

				get_exp_lim(166) -> 242772
			;

				get_exp_lim(167) -> 244658
			;

				get_exp_lim(168) -> 246547
			;

				get_exp_lim(169) -> 248440
			;

				get_exp_lim(170) -> 250336
			;

				get_exp_lim(171) -> 252235
			;

				get_exp_lim(172) -> 265187
			;

				get_exp_lim(173) -> 267176
			;

				get_exp_lim(174) -> 269168
			;

				get_exp_lim(175) -> 271164
			;

				get_exp_lim(176) -> 273163
			;

				get_exp_lim(177) -> 275165
			;

				get_exp_lim(178) -> 288720
			;

				get_exp_lim(179) -> 290813
			;

				get_exp_lim(180) -> 292909
			;

				get_exp_lim(181) -> 295009
			;

				get_exp_lim(182) -> 297113
			;

				get_exp_lim(183) -> 299220
			;

				get_exp_lim(184) -> 313384
			;

				get_exp_lim(185) -> 315582
			;

				get_exp_lim(186) -> 317784
			;

				get_exp_lim(187) -> 319989
			;

				get_exp_lim(188) -> 322199
			;

				get_exp_lim(189) -> 336889
			;

				get_exp_lim(190) -> 339190
			;

				get_exp_lim(191) -> 341495
			;

				get_exp_lim(192) -> 343804
			;

				get_exp_lim(193) -> 346116
			;

				get_exp_lim(194) -> 361337
			;

				get_exp_lim(195) -> 363742
			;

				get_exp_lim(196) -> 366151
			;

				get_exp_lim(197) -> 368564
			;

				get_exp_lim(198) -> 384229
			;

				get_exp_lim(199) -> 386736
			;

				get_exp_lim(200) -> 389246
			;

				get_exp_lim(201) -> 391760
			;

				get_exp_lim(202) -> 407874
			;

				get_exp_lim(203) -> 410482
			;

				get_exp_lim(204) -> 413095
			;

				get_exp_lim(205) -> 415711
			;

				get_exp_lim(206) -> 432275
			;

				get_exp_lim(207) -> 434986
			;

				get_exp_lim(208) -> 437702
			;

				get_exp_lim(209) -> 440421
			;

				get_exp_lim(210) -> 457439
			;

				get_exp_lim(211) -> 460254
			;

				get_exp_lim(212) -> 463073
			;

				get_exp_lim(213) -> 480455
			;

				get_exp_lim(214) -> 483370
			;

				get_exp_lim(215) -> 486289
			;

				get_exp_lim(216) -> 504037
			;

				get_exp_lim(217) -> 507054
			;

				get_exp_lim(218) -> 510074
			;

				get_exp_lim(219) -> 528190
			;

				get_exp_lim(220) -> 531307
			;

				get_exp_lim(221) -> 534429
			;

				get_exp_lim(222) -> 552914
			;

				get_exp_lim(223) -> 556134
			;

				get_exp_lim(224) -> 559358
			;

				get_exp_lim(225) -> 578214
			;

				get_exp_lim(226) -> 581537
			;

				get_exp_lim(227) -> 584864
			;

				get_exp_lim(228) -> 604093
			;

				get_exp_lim(229) -> 607519
			;

				get_exp_lim(230) -> 627027
			;

				get_exp_lim(231) -> 630552
			;

				get_exp_lim(232) -> 634082
			;

				get_exp_lim(233) -> 653966
			;

				get_exp_lim(234) -> 657596
			;

				get_exp_lim(235) -> 677761
			;

				get_exp_lim(236) -> 681491
			;

				get_exp_lim(237) -> 701939
			;

				get_exp_lim(238) -> 705770
			;

				get_exp_lim(239) -> 726500
			;

				get_exp_lim(240) -> 730432
			;

				get_exp_lim(241) -> 751448
			;

				get_exp_lim(242) -> 755481
			;

				get_exp_lim(243) -> 776781
			;

				get_exp_lim(244) -> 780916
			;

				get_exp_lim(245) -> 802502
			;

				get_exp_lim(246) -> 806740
			;

				get_exp_lim(247) -> 828613
			;

				get_exp_lim(248) -> 832953
			;

				get_exp_lim(249) -> 855113
			;

				get_exp_lim(250) -> 859556
			;

				get_exp_lim(251) -> 882005
			;

				get_exp_lim(252) -> 886552
			;

				get_exp_lim(253) -> 909290
			;

				get_exp_lim(254) -> 932219
			;

				get_exp_lim(255) -> 936968
			;

				get_exp_lim(256) -> 960188
			;

				get_exp_lim(257) -> 983600
			;

				get_exp_lim(258) -> 988553
			;

				get_exp_lim(259) -> 1012257
			;

				get_exp_lim(260) -> 1036154
			;

				get_exp_lim(261) -> 1041312
			;

				get_exp_lim(262) -> 1065502
			;

				get_exp_lim(263) -> 1089886
			;

				get_exp_lim(264) -> 1095250
			;

				get_exp_lim(265) -> 1119929
			;

				get_exp_lim(266) -> 1144802
			;

				get_exp_lim(267) -> 1169871
			;

				get_exp_lim(268) -> 1175542
			;

				get_exp_lim(269) -> 1200907
			;

				get_exp_lim(270) -> 1226467
			;

				get_exp_lim(271) -> 1252224
			;

				get_exp_lim(272) -> 1278177
			;

				get_exp_lim(273) -> 1284260
			;

				get_exp_lim(274) -> 1310512
			;

				get_exp_lim(275) -> 1336960
			;

				get_exp_lim(276) -> 1363607
			;

				get_exp_lim(277) -> 1390451
			;

				get_exp_lim(278) -> 1417493
			;

				get_exp_lim(279) -> 1444733
			;

				get_exp_lim(280) -> 1472172
			;

				get_exp_lim(281) -> 1499810
			;

				get_exp_lim(282) -> 1527648
			;

				get_exp_lim(283) -> 1534662
			;

				get_exp_lim(284) -> 1562802
			;

				get_exp_lim(285) -> 1612358
			;

				get_exp_lim(286) -> 1640995
			;

				get_exp_lim(287) -> 1669833
			;

				get_exp_lim(288) -> 1698871
			;

				get_exp_lim(289) -> 1728111
			;

				get_exp_lim(290) -> 1757553
			;

				get_exp_lim(291) -> 1787196
			;

				get_exp_lim(292) -> 1817041
			;

				get_exp_lim(293) -> 1847089
			;

				get_exp_lim(294) -> 1899426
			;

				get_exp_lim(295) -> 1929976
			;

				get_exp_lim(296) -> 1960730
			;

				get_exp_lim(297) -> 1991688
			;

				get_exp_lim(298) -> 2022849
			;

				get_exp_lim(299) -> 2076788
			;

				get_exp_lim(300) -> 2108455
			;

				get_exp_lim(301) -> 2140328
			;

				get_exp_lim(302) -> 2195272
			;

				get_exp_lim(303) -> 2227653
			;

				get_exp_lim(304) -> 2283303
			;

				get_exp_lim(305) -> 2316194
			;

				get_exp_lim(306) -> 2349291
			;

				get_exp_lim(307) -> 2405953
			;

				get_exp_lim(308) -> 2439562
			;

				get_exp_lim(309) -> 2496934
			;

				get_exp_lim(310) -> 2531056
			;

				get_exp_lim(311) -> 2589140
			;

				get_exp_lim(312) -> 2647629
			;

				get_exp_lim(313) -> 2682574
			;

				get_exp_lim(314) -> 2741778
			;

				get_exp_lim(315) -> 2801390
			;

				get_exp_lim(316) -> 2837160
			;

				get_exp_lim(317) -> 2897489
			;

				get_exp_lim(318) -> 2958227
			;

				get_exp_lim(319) -> 3019374
			;

				get_exp_lim(320) -> 3080932
			;

				get_exp_lim(321) -> 3118153
			;

				get_exp_lim(322) -> 3180432
			;

				get_exp_lim(323) -> 3243124
			;

				get_exp_lim(324) -> 3306227
			;

				get_exp_lim(325) -> 3369743
			;

				get_exp_lim(326) -> 3433673
			;

				get_exp_lim(327) -> 3498016
			;

				get_exp_lim(328) -> 3562773
			;

				get_exp_lim(329) -> 3653494
			;

				get_exp_lim(330) -> 3719182
			;

				get_exp_lim(331) -> 3785286
			;

				get_exp_lim(332) -> 3851807
			;

				get_exp_lim(333) -> 3944696
			;

				get_exp_lim(334) -> 4012152
			;

				get_exp_lim(335) -> 4080027
			;

				get_exp_lim(336) -> 4174575
			;

				get_exp_lim(337) -> 4243388
			;

				get_exp_lim(338) -> 4339078
			;

				get_exp_lim(339) -> 4408833
			;

				get_exp_lim(340) -> 4505669
			;

				get_exp_lim(341) -> 4576368
			;

				get_exp_lim(342) -> 4674352
			;

				get_exp_lim(343) -> 4772962
			;

				get_exp_lim(344) -> 4845132
			;

				get_exp_lim(345) -> 4944895
			;

				get_exp_lim(346) -> 5045286
			;

				get_exp_lim(347) -> 5146306
			;

				get_exp_lim(348) -> 5247956
			;

				get_exp_lim(349) -> 5350237
			;

				get_exp_lim(350) -> 5453149
			;

				get_exp_lim(351) -> 5556693
			;

				get_exp_lim(352) -> 5660870
			;

				get_exp_lim(353) -> 5765680
			;

				get_exp_lim(354) -> 5899216
			;

				get_exp_lim(355) -> 6005399
			;

				get_exp_lim(356) -> 6112217
			;

				get_exp_lim(357) -> 6248073
			;

				get_exp_lim(358) -> 6356268
			;

				get_exp_lim(359) -> 6493709
			;

				get_exp_lim(360) -> 6631995
			;

				get_exp_lim(361) -> 6742314
			;

				get_exp_lim(362) -> 6882191
			;

				get_exp_lim(363) -> 7022916
			;

				get_exp_lim(364) -> 7164491
			;

				get_exp_lim(365) -> 7306916
			;

				get_exp_lim(366) -> 7450192
			;

				get_exp_lim(367) -> 7594321
			;

				get_exp_lim(368) -> 7739303
			;

				get_exp_lim(369) -> 7885140
			;

				get_exp_lim(370) -> 8031832
			;

				get_exp_lim(371) -> 8209231
			;

				get_exp_lim(372) -> 8357741
			;

				get_exp_lim(373) -> 8507109
			;

				get_exp_lim(374) -> 8687501
			;

				get_exp_lim(375) -> 8868963
			;

				get_exp_lim(376) -> 9021120
			;

				get_exp_lim(377) -> 9204620
			;

				get_exp_lim(378) -> 9389192
			;

				get_exp_lim(379) -> 9574838
			;

				get_exp_lim(380) -> 9761559
			;

				get_exp_lim(381) -> 9949357
			;

				get_exp_lim(382) -> 10169236
			;

				get_exp_lim(383) -> 10359296
			;

				get_exp_lim(384) -> 10550436
			;

				get_exp_lim(385) -> 10773976
			;

				get_exp_lim(386) -> 10967385
			;

				get_exp_lim(387) -> 11193409
			;

				get_exp_lim(388) -> 11420729
			;

				get_exp_lim(389) -> 11649346
			;

				get_exp_lim(390) -> 11879263
			;

				get_exp_lim(391) -> 12110480
			;

				get_exp_lim(392) -> 12342999
			;

				get_exp_lim(393) -> 12576821
			;

				get_exp_lim(394) -> 12844220
			;

				get_exp_lim(395) -> 13080759
			;

				get_exp_lim(396) -> 13351090
			;

				get_exp_lim(397) -> 13622943
			;

				get_exp_lim(398) -> 13863622
			;

				get_exp_lim(399) -> 14138417
			;

				get_exp_lim(400) -> 14414738
			;

				get_exp_lim(401) -> 14725604
			;

				get_exp_lim(402) -> 15005090
			;

				get_exp_lim(403) -> 15286107
			;

				get_exp_lim(404) -> 15601995
			;

				get_exp_lim(405) -> 15919632
			;

				get_exp_lim(406) -> 16239019
			;

				get_exp_lim(407) -> 16560158
			;

				get_exp_lim(408) -> 16883052
			;

				get_exp_lim(409) -> 17207701
			;

				get_exp_lim(410) -> 17534109
			;

				get_exp_lim(411) -> 17896364
			;

				get_exp_lim(412) -> 18260596
			;

				get_exp_lim(413) -> 18592503
			;

				get_exp_lim(414) -> 18960586
			;

				get_exp_lim(415) -> 19330653
			;

				get_exp_lim(416) -> 19737330
			;

				get_exp_lim(417) -> 20111476
			;

				get_exp_lim(418) -> 20522453
			;

				get_exp_lim(419) -> 20935637
			;

				get_exp_lim(420) -> 21315971
			;

				get_exp_lim(421) -> 21768635
			;

				get_exp_lim(422) -> 22188454
			;

				get_exp_lim(423) -> 22610488
			;

				get_exp_lim(424) -> 23070234
			;

				get_exp_lim(425) -> 23532417
			;

				get_exp_lim(426) -> 23997040
			;

				get_exp_lim(427) -> 24464106
			;

				get_exp_lim(428) -> 24933616
			;

				get_exp_lim(429) -> 25441610
			;

				get_exp_lim(430) -> 25952272
			;

				get_exp_lim(431) -> 26429350
			;

				get_exp_lim(432) -> 26981609
			;

				get_exp_lim(433) -> 27500290
			;

				get_exp_lim(434) -> 28058230
			;

				get_exp_lim(435) -> 28582379
			;

				get_exp_lim(436) -> 29146013
			;

				get_exp_lim(437) -> 29749461
			;

				get_exp_lim(438) -> 30319017
			;

				get_exp_lim(439) -> 30928613
			;

				get_exp_lim(440) -> 31541342
			;

				get_exp_lim(441) -> 32157207
			;

				get_exp_lim(442) -> 32776212
			;

				get_exp_lim(443) -> 33435927
			;

				get_exp_lim(444) -> 34099007
			;

				get_exp_lim(445) -> 34765456
			;

				get_exp_lim(446) -> 35435277
			;

				get_exp_lim(447) -> 36146482
			;

				get_exp_lim(448) -> 36861285
			;

				get_exp_lim(449) -> 37579691
			;

				get_exp_lim(450) -> 38301702
			;

				get_exp_lim(451) -> 39065773
			;

				get_exp_lim(452) -> 39833678
			;

				get_exp_lim(453) -> 40644092
			;

				get_exp_lim(454) -> 41419786
			;

				get_exp_lim(455) -> 42238218
			;

				get_exp_lim(456) -> 43060720
			;

				get_exp_lim(457) -> 43926411
			;

				get_exp_lim(458) -> 44796402
			;

				get_exp_lim(459) -> 45670696
			;

				get_exp_lim(460) -> 46549298
			;

				get_exp_lim(461) -> 47471772
			;

				get_exp_lim(462) -> 48398785
			;

				get_exp_lim(463) -> 49370122
			;

				get_exp_lim(464) -> 50346230
			;

				get_exp_lim(465) -> 51327112
			;

				get_exp_lim(466) -> 52312772
			;

				get_exp_lim(467) -> 53343444
			;

				get_exp_lim(468) -> 54419467
			;

				get_exp_lim(469) -> 55460278
			;

				get_exp_lim(470) -> 56546672
			;

				get_exp_lim(471) -> 57678992
			;

				get_exp_lim(472) -> 58816789
			;

				get_exp_lim(473) -> 59960069
			;

				get_exp_lim(474) -> 61149849
			;

				get_exp_lim(475) -> 62345346
			;

				get_exp_lim(476) -> 63546564
			;

				get_exp_lim(477) -> 64794860
			;

				get_exp_lim(478) -> 66090575
			;

				get_exp_lim(479) -> 67350904
			;

				get_exp_lim(480) -> 68700575
			;

				get_exp_lim(481) -> 70014870
			;

				get_exp_lim(482) -> 71419195
			;

				get_exp_lim(483) -> 72788155
			;

				get_exp_lim(484) -> 74247834
			;

				get_exp_lim(485) -> 75672160
			;

				get_exp_lim(486) -> 77145530
			;

				get_exp_lim(487) -> 78668288
			;

				get_exp_lim(488) -> 80198190
			;

				get_exp_lim(489) -> 81777945
			;

				get_exp_lim(490) -> 83407900
			;

				get_exp_lim(491) -> 85002540
			;

				get_exp_lim(492) -> 86690665
			;

				get_exp_lim(493) -> 88386645
			;

				get_exp_lim(494) -> 90090488
			;

				get_exp_lim(495) -> 91888971
			;

				get_exp_lim(496) -> 93652287
			;

				get_exp_lim(497) -> 95510939
			;

				get_exp_lim(498) -> 97378164
			;

				get_exp_lim(499) -> 99253971
			;

				get_exp_lim(500) -> 101182320
			;

				get_exp_lim(_Lv) ->
	?MAX_U32.
		

				get_transmit_money(1) -> 10000
			;

				get_transmit_money(2) -> 20000
			;

				get_transmit_money(3) -> 30000
			;

				get_transmit_money(4) -> 40000
			;

				get_transmit_money(5) -> 50000
			;

				get_transmit_money(6) -> 60000
			;

				get_transmit_money(7) -> 70000
			;

				get_transmit_money(8) -> 80000
			;

				get_transmit_money(9) -> 90000
			;

				get_transmit_money(10) -> 100000
			;

				get_transmit_money(11) -> 110000
			;

				get_transmit_money(12) -> 120000
			;

				get_transmit_money(13) -> 130000
			;

				get_transmit_money(14) -> 140000
			;

				get_transmit_money(15) -> 150000
			;

				get_transmit_money(16) -> 160000
			;

				get_transmit_money(17) -> 170000
			;

				get_transmit_money(18) -> 180000
			;

				get_transmit_money(19) -> 190000
			;

				get_transmit_money(20) -> 200000
			;

				get_transmit_money(21) -> 210000
			;

				get_transmit_money(22) -> 220000
			;

				get_transmit_money(23) -> 230000
			;

				get_transmit_money(24) -> 240000
			;

				get_transmit_money(25) -> 250000
			;

				get_transmit_money(26) -> 260000
			;

				get_transmit_money(27) -> 270000
			;

				get_transmit_money(28) -> 280000
			;

				get_transmit_money(29) -> 290000
			;

				get_transmit_money(30) -> 300000
			;

				get_transmit_money(31) -> 310000
			;

				get_transmit_money(32) -> 320000
			;

				get_transmit_money(33) -> 330000
			;

				get_transmit_money(34) -> 340000
			;

				get_transmit_money(35) -> 350000
			;

				get_transmit_money(36) -> 360000
			;

				get_transmit_money(37) -> 370000
			;

				get_transmit_money(38) -> 380000
			;

				get_transmit_money(39) -> 390000
			;

				get_transmit_money(40) -> 400000
			;

				get_transmit_money(41) -> 410000
			;

				get_transmit_money(42) -> 420000
			;

				get_transmit_money(43) -> 430000
			;

				get_transmit_money(44) -> 440000
			;

				get_transmit_money(45) -> 450000
			;

				get_transmit_money(46) -> 460000
			;

				get_transmit_money(47) -> 470000
			;

				get_transmit_money(48) -> 480000
			;

				get_transmit_money(49) -> 490000
			;

				get_transmit_money(50) -> 500000
			;

				get_transmit_money(51) -> 510000
			;

				get_transmit_money(52) -> 520000
			;

				get_transmit_money(53) -> 530000
			;

				get_transmit_money(54) -> 540000
			;

				get_transmit_money(55) -> 550000
			;

				get_transmit_money(56) -> 560000
			;

				get_transmit_money(57) -> 570000
			;

				get_transmit_money(58) -> 580000
			;

				get_transmit_money(59) -> 590000
			;

				get_transmit_money(60) -> 600000
			;

				get_transmit_money(61) -> 610000
			;

				get_transmit_money(62) -> 620000
			;

				get_transmit_money(63) -> 630000
			;

				get_transmit_money(64) -> 640000
			;

				get_transmit_money(65) -> 650000
			;

				get_transmit_money(66) -> 660000
			;

				get_transmit_money(67) -> 670000
			;

				get_transmit_money(68) -> 680000
			;

				get_transmit_money(69) -> 690000
			;

				get_transmit_money(70) -> 700000
			;

				get_transmit_money(71) -> 710000
			;

				get_transmit_money(72) -> 720000
			;

				get_transmit_money(73) -> 730000
			;

				get_transmit_money(74) -> 740000
			;

				get_transmit_money(75) -> 750000
			;

				get_transmit_money(76) -> 760000
			;

				get_transmit_money(77) -> 770000
			;

				get_transmit_money(78) -> 780000
			;

				get_transmit_money(79) -> 790000
			;

				get_transmit_money(80) -> 800000
			;

				get_transmit_money(81) -> 810000
			;

				get_transmit_money(82) -> 820000
			;

				get_transmit_money(83) -> 830000
			;

				get_transmit_money(84) -> 840000
			;

				get_transmit_money(85) -> 850000
			;

				get_transmit_money(86) -> 860000
			;

				get_transmit_money(87) -> 870000
			;

				get_transmit_money(88) -> 880000
			;

				get_transmit_money(89) -> 890000
			;

				get_transmit_money(90) -> 900000
			;

				get_transmit_money(91) -> 910000
			;

				get_transmit_money(92) -> 920000
			;

				get_transmit_money(93) -> 930000
			;

				get_transmit_money(94) -> 940000
			;

				get_transmit_money(95) -> 950000
			;

				get_transmit_money(96) -> 960000
			;

				get_transmit_money(97) -> 970000
			;

				get_transmit_money(98) -> 980000
			;

				get_transmit_money(99) -> 990000
			;

				get_transmit_money(100) -> 1000000
			;

				get_transmit_money(101) -> 1010000
			;

				get_transmit_money(102) -> 1020000
			;

				get_transmit_money(103) -> 1030000
			;

				get_transmit_money(104) -> 1040000
			;

				get_transmit_money(105) -> 1050000
			;

				get_transmit_money(106) -> 1060000
			;

				get_transmit_money(107) -> 1070000
			;

				get_transmit_money(108) -> 1080000
			;

				get_transmit_money(109) -> 1090000
			;

				get_transmit_money(110) -> 1100000
			;

				get_transmit_money(111) -> 1110000
			;

				get_transmit_money(112) -> 1120000
			;

				get_transmit_money(113) -> 1130000
			;

				get_transmit_money(114) -> 1140000
			;

				get_transmit_money(115) -> 1150000
			;

				get_transmit_money(116) -> 1160000
			;

				get_transmit_money(117) -> 1170000
			;

				get_transmit_money(118) -> 1180000
			;

				get_transmit_money(119) -> 1190000
			;

				get_transmit_money(120) -> 1200000
			;

				get_transmit_money(121) -> 1210000
			;

				get_transmit_money(122) -> 1220000
			;

				get_transmit_money(123) -> 1230000
			;

				get_transmit_money(124) -> 1240000
			;

				get_transmit_money(125) -> 1250000
			;

				get_transmit_money(126) -> 1260000
			;

				get_transmit_money(127) -> 1270000
			;

				get_transmit_money(128) -> 1280000
			;

				get_transmit_money(129) -> 1290000
			;

				get_transmit_money(130) -> 1300000
			;

				get_transmit_money(131) -> 1310000
			;

				get_transmit_money(132) -> 1320000
			;

				get_transmit_money(133) -> 1330000
			;

				get_transmit_money(134) -> 1340000
			;

				get_transmit_money(135) -> 1350000
			;

				get_transmit_money(136) -> 1360000
			;

				get_transmit_money(137) -> 1370000
			;

				get_transmit_money(138) -> 1380000
			;

				get_transmit_money(139) -> 1390000
			;

				get_transmit_money(140) -> 1400000
			;

				get_transmit_money(141) -> 1410000
			;

				get_transmit_money(142) -> 1420000
			;

				get_transmit_money(143) -> 1430000
			;

				get_transmit_money(144) -> 1440000
			;

				get_transmit_money(145) -> 1450000
			;

				get_transmit_money(146) -> 1460000
			;

				get_transmit_money(147) -> 1470000
			;

				get_transmit_money(148) -> 1480000
			;

				get_transmit_money(149) -> 1490000
			;

				get_transmit_money(150) -> 1500000
			;

				get_transmit_money(151) -> 1510000
			;

				get_transmit_money(152) -> 1520000
			;

				get_transmit_money(153) -> 1530000
			;

				get_transmit_money(154) -> 1540000
			;

				get_transmit_money(155) -> 1550000
			;

				get_transmit_money(156) -> 1560000
			;

				get_transmit_money(157) -> 1570000
			;

				get_transmit_money(158) -> 1580000
			;

				get_transmit_money(159) -> 1590000
			;

				get_transmit_money(160) -> 1600000
			;

				get_transmit_money(161) -> 1610000
			;

				get_transmit_money(162) -> 1620000
			;

				get_transmit_money(163) -> 1630000
			;

				get_transmit_money(164) -> 1640000
			;

				get_transmit_money(165) -> 1650000
			;

				get_transmit_money(166) -> 1660000
			;

				get_transmit_money(167) -> 1670000
			;

				get_transmit_money(168) -> 1680000
			;

				get_transmit_money(169) -> 1690000
			;

				get_transmit_money(170) -> 1700000
			;

				get_transmit_money(171) -> 1710000
			;

				get_transmit_money(172) -> 1720000
			;

				get_transmit_money(173) -> 1730000
			;

				get_transmit_money(174) -> 1740000
			;

				get_transmit_money(175) -> 1750000
			;

				get_transmit_money(176) -> 1760000
			;

				get_transmit_money(177) -> 1770000
			;

				get_transmit_money(178) -> 1780000
			;

				get_transmit_money(179) -> 1790000
			;

				get_transmit_money(180) -> 1800000
			;

				get_transmit_money(181) -> 1810000
			;

				get_transmit_money(182) -> 1820000
			;

				get_transmit_money(183) -> 1830000
			;

				get_transmit_money(184) -> 1840000
			;

				get_transmit_money(185) -> 1850000
			;

				get_transmit_money(186) -> 1860000
			;

				get_transmit_money(187) -> 1870000
			;

				get_transmit_money(188) -> 1880000
			;

				get_transmit_money(189) -> 1890000
			;

				get_transmit_money(190) -> 1900000
			;

				get_transmit_money(191) -> 1910000
			;

				get_transmit_money(192) -> 1920000
			;

				get_transmit_money(193) -> 1930000
			;

				get_transmit_money(194) -> 1940000
			;

				get_transmit_money(195) -> 1950000
			;

				get_transmit_money(196) -> 1960000
			;

				get_transmit_money(197) -> 1970000
			;

				get_transmit_money(198) -> 1980000
			;

				get_transmit_money(199) -> 1990000
			;

				get_transmit_money(200) -> 2000000
			;

				get_transmit_money(201) -> 2010000
			;

				get_transmit_money(202) -> 2020000
			;

				get_transmit_money(203) -> 2030000
			;

				get_transmit_money(204) -> 2040000
			;

				get_transmit_money(205) -> 2050000
			;

				get_transmit_money(206) -> 2060000
			;

				get_transmit_money(207) -> 2070000
			;

				get_transmit_money(208) -> 2080000
			;

				get_transmit_money(209) -> 2090000
			;

				get_transmit_money(210) -> 2100000
			;

				get_transmit_money(211) -> 2110000
			;

				get_transmit_money(212) -> 2120000
			;

				get_transmit_money(213) -> 2130000
			;

				get_transmit_money(214) -> 2140000
			;

				get_transmit_money(215) -> 2150000
			;

				get_transmit_money(216) -> 2160000
			;

				get_transmit_money(217) -> 2170000
			;

				get_transmit_money(218) -> 2180000
			;

				get_transmit_money(219) -> 2190000
			;

				get_transmit_money(220) -> 2200000
			;

				get_transmit_money(221) -> 2210000
			;

				get_transmit_money(222) -> 2220000
			;

				get_transmit_money(223) -> 2230000
			;

				get_transmit_money(224) -> 2240000
			;

				get_transmit_money(225) -> 2250000
			;

				get_transmit_money(226) -> 2260000
			;

				get_transmit_money(227) -> 2270000
			;

				get_transmit_money(228) -> 2280000
			;

				get_transmit_money(229) -> 2290000
			;

				get_transmit_money(230) -> 2300000
			;

				get_transmit_money(231) -> 2310000
			;

				get_transmit_money(232) -> 2320000
			;

				get_transmit_money(233) -> 2330000
			;

				get_transmit_money(234) -> 2340000
			;

				get_transmit_money(235) -> 2350000
			;

				get_transmit_money(236) -> 2360000
			;

				get_transmit_money(237) -> 2370000
			;

				get_transmit_money(238) -> 2380000
			;

				get_transmit_money(239) -> 2390000
			;

				get_transmit_money(240) -> 2400000
			;

				get_transmit_money(241) -> 2410000
			;

				get_transmit_money(242) -> 2420000
			;

				get_transmit_money(243) -> 2430000
			;

				get_transmit_money(244) -> 2440000
			;

				get_transmit_money(245) -> 2450000
			;

				get_transmit_money(246) -> 2460000
			;

				get_transmit_money(247) -> 2470000
			;

				get_transmit_money(248) -> 2480000
			;

				get_transmit_money(249) -> 2490000
			;

				get_transmit_money(250) -> 2500000
			;

				get_transmit_money(251) -> 2510000
			;

				get_transmit_money(252) -> 2520000
			;

				get_transmit_money(253) -> 2530000
			;

				get_transmit_money(254) -> 2540000
			;

				get_transmit_money(255) -> 2550000
			;

				get_transmit_money(256) -> 2560000
			;

				get_transmit_money(257) -> 2570000
			;

				get_transmit_money(258) -> 2580000
			;

				get_transmit_money(259) -> 2590000
			;

				get_transmit_money(260) -> 2600000
			;

				get_transmit_money(261) -> 2610000
			;

				get_transmit_money(262) -> 2620000
			;

				get_transmit_money(263) -> 2630000
			;

				get_transmit_money(264) -> 2640000
			;

				get_transmit_money(265) -> 2650000
			;

				get_transmit_money(266) -> 2660000
			;

				get_transmit_money(267) -> 2670000
			;

				get_transmit_money(268) -> 2680000
			;

				get_transmit_money(269) -> 2690000
			;

				get_transmit_money(270) -> 2700000
			;

				get_transmit_money(271) -> 2710000
			;

				get_transmit_money(272) -> 2720000
			;

				get_transmit_money(273) -> 2730000
			;

				get_transmit_money(274) -> 2740000
			;

				get_transmit_money(275) -> 2750000
			;

				get_transmit_money(276) -> 2760000
			;

				get_transmit_money(277) -> 2770000
			;

				get_transmit_money(278) -> 2780000
			;

				get_transmit_money(279) -> 2790000
			;

				get_transmit_money(280) -> 2800000
			;

				get_transmit_money(281) -> 2810000
			;

				get_transmit_money(282) -> 2820000
			;

				get_transmit_money(283) -> 2830000
			;

				get_transmit_money(284) -> 2840000
			;

				get_transmit_money(285) -> 2850000
			;

				get_transmit_money(286) -> 2860000
			;

				get_transmit_money(287) -> 2870000
			;

				get_transmit_money(288) -> 2880000
			;

				get_transmit_money(289) -> 2890000
			;

				get_transmit_money(290) -> 2900000
			;

				get_transmit_money(291) -> 2910000
			;

				get_transmit_money(292) -> 2920000
			;

				get_transmit_money(293) -> 2930000
			;

				get_transmit_money(294) -> 2940000
			;

				get_transmit_money(295) -> 2950000
			;

				get_transmit_money(296) -> 2960000
			;

				get_transmit_money(297) -> 2970000
			;

				get_transmit_money(298) -> 2980000
			;

				get_transmit_money(299) -> 2990000
			;

				get_transmit_money(300) -> 3000000
			;

				get_transmit_money(301) -> 3010000
			;

				get_transmit_money(302) -> 3020000
			;

				get_transmit_money(303) -> 3030000
			;

				get_transmit_money(304) -> 3040000
			;

				get_transmit_money(305) -> 3050000
			;

				get_transmit_money(306) -> 3060000
			;

				get_transmit_money(307) -> 3070000
			;

				get_transmit_money(308) -> 3080000
			;

				get_transmit_money(309) -> 3090000
			;

				get_transmit_money(310) -> 3100000
			;

				get_transmit_money(311) -> 3110000
			;

				get_transmit_money(312) -> 3120000
			;

				get_transmit_money(313) -> 3130000
			;

				get_transmit_money(314) -> 3140000
			;

				get_transmit_money(315) -> 3150000
			;

				get_transmit_money(316) -> 3160000
			;

				get_transmit_money(317) -> 3170000
			;

				get_transmit_money(318) -> 3180000
			;

				get_transmit_money(319) -> 3190000
			;

				get_transmit_money(320) -> 3200000
			;

				get_transmit_money(321) -> 3210000
			;

				get_transmit_money(322) -> 3220000
			;

				get_transmit_money(323) -> 3230000
			;

				get_transmit_money(324) -> 3240000
			;

				get_transmit_money(325) -> 3250000
			;

				get_transmit_money(326) -> 3260000
			;

				get_transmit_money(327) -> 3270000
			;

				get_transmit_money(328) -> 3280000
			;

				get_transmit_money(329) -> 3290000
			;

				get_transmit_money(330) -> 3300000
			;

				get_transmit_money(331) -> 3310000
			;

				get_transmit_money(332) -> 3320000
			;

				get_transmit_money(333) -> 3330000
			;

				get_transmit_money(334) -> 3340000
			;

				get_transmit_money(335) -> 3350000
			;

				get_transmit_money(336) -> 3360000
			;

				get_transmit_money(337) -> 3370000
			;

				get_transmit_money(338) -> 3380000
			;

				get_transmit_money(339) -> 3390000
			;

				get_transmit_money(340) -> 3400000
			;

				get_transmit_money(341) -> 3410000
			;

				get_transmit_money(342) -> 3420000
			;

				get_transmit_money(343) -> 3430000
			;

				get_transmit_money(344) -> 3440000
			;

				get_transmit_money(345) -> 3450000
			;

				get_transmit_money(346) -> 3460000
			;

				get_transmit_money(347) -> 3470000
			;

				get_transmit_money(348) -> 3480000
			;

				get_transmit_money(349) -> 3490000
			;

				get_transmit_money(350) -> 3500000
			;

				get_transmit_money(351) -> 3510000
			;

				get_transmit_money(352) -> 3520000
			;

				get_transmit_money(353) -> 3530000
			;

				get_transmit_money(354) -> 3540000
			;

				get_transmit_money(355) -> 3550000
			;

				get_transmit_money(356) -> 3560000
			;

				get_transmit_money(357) -> 3570000
			;

				get_transmit_money(358) -> 3580000
			;

				get_transmit_money(359) -> 3590000
			;

				get_transmit_money(360) -> 3600000
			;

				get_transmit_money(361) -> 3610000
			;

				get_transmit_money(362) -> 3620000
			;

				get_transmit_money(363) -> 3630000
			;

				get_transmit_money(364) -> 3640000
			;

				get_transmit_money(365) -> 3650000
			;

				get_transmit_money(366) -> 3660000
			;

				get_transmit_money(367) -> 3670000
			;

				get_transmit_money(368) -> 3680000
			;

				get_transmit_money(369) -> 3690000
			;

				get_transmit_money(370) -> 3700000
			;

				get_transmit_money(371) -> 3710000
			;

				get_transmit_money(372) -> 3720000
			;

				get_transmit_money(373) -> 3730000
			;

				get_transmit_money(374) -> 3740000
			;

				get_transmit_money(375) -> 3750000
			;

				get_transmit_money(376) -> 3760000
			;

				get_transmit_money(377) -> 3770000
			;

				get_transmit_money(378) -> 3780000
			;

				get_transmit_money(379) -> 3790000
			;

				get_transmit_money(380) -> 3800000
			;

				get_transmit_money(381) -> 3810000
			;

				get_transmit_money(382) -> 3820000
			;

				get_transmit_money(383) -> 3830000
			;

				get_transmit_money(384) -> 3840000
			;

				get_transmit_money(385) -> 3850000
			;

				get_transmit_money(386) -> 3860000
			;

				get_transmit_money(387) -> 3870000
			;

				get_transmit_money(388) -> 3880000
			;

				get_transmit_money(389) -> 3890000
			;

				get_transmit_money(390) -> 3900000
			;

				get_transmit_money(391) -> 3910000
			;

				get_transmit_money(392) -> 3920000
			;

				get_transmit_money(393) -> 3930000
			;

				get_transmit_money(394) -> 3940000
			;

				get_transmit_money(395) -> 3950000
			;

				get_transmit_money(396) -> 3960000
			;

				get_transmit_money(397) -> 3970000
			;

				get_transmit_money(398) -> 3980000
			;

				get_transmit_money(399) -> 3990000
			;

				get_transmit_money(400) -> 4000000
			;

				get_transmit_money(401) -> 4010000
			;

				get_transmit_money(402) -> 4020000
			;

				get_transmit_money(403) -> 4030000
			;

				get_transmit_money(404) -> 4040000
			;

				get_transmit_money(405) -> 4050000
			;

				get_transmit_money(406) -> 4060000
			;

				get_transmit_money(407) -> 4070000
			;

				get_transmit_money(408) -> 4080000
			;

				get_transmit_money(409) -> 4090000
			;

				get_transmit_money(410) -> 4100000
			;

				get_transmit_money(411) -> 4110000
			;

				get_transmit_money(412) -> 4120000
			;

				get_transmit_money(413) -> 4130000
			;

				get_transmit_money(414) -> 4140000
			;

				get_transmit_money(415) -> 4150000
			;

				get_transmit_money(416) -> 4160000
			;

				get_transmit_money(417) -> 4170000
			;

				get_transmit_money(418) -> 4180000
			;

				get_transmit_money(419) -> 4190000
			;

				get_transmit_money(420) -> 4200000
			;

				get_transmit_money(421) -> 4210000
			;

				get_transmit_money(422) -> 4220000
			;

				get_transmit_money(423) -> 4230000
			;

				get_transmit_money(424) -> 4240000
			;

				get_transmit_money(425) -> 4250000
			;

				get_transmit_money(426) -> 4260000
			;

				get_transmit_money(427) -> 4270000
			;

				get_transmit_money(428) -> 4280000
			;

				get_transmit_money(429) -> 4290000
			;

				get_transmit_money(430) -> 4300000
			;

				get_transmit_money(431) -> 4310000
			;

				get_transmit_money(432) -> 4320000
			;

				get_transmit_money(433) -> 4330000
			;

				get_transmit_money(434) -> 4340000
			;

				get_transmit_money(435) -> 4350000
			;

				get_transmit_money(436) -> 4360000
			;

				get_transmit_money(437) -> 4370000
			;

				get_transmit_money(438) -> 4380000
			;

				get_transmit_money(439) -> 4390000
			;

				get_transmit_money(440) -> 4400000
			;

				get_transmit_money(441) -> 4410000
			;

				get_transmit_money(442) -> 4420000
			;

				get_transmit_money(443) -> 4430000
			;

				get_transmit_money(444) -> 4440000
			;

				get_transmit_money(445) -> 4450000
			;

				get_transmit_money(446) -> 4460000
			;

				get_transmit_money(447) -> 4470000
			;

				get_transmit_money(448) -> 4480000
			;

				get_transmit_money(449) -> 4490000
			;

				get_transmit_money(450) -> 4500000
			;

				get_transmit_money(451) -> 4510000
			;

				get_transmit_money(452) -> 4520000
			;

				get_transmit_money(453) -> 4530000
			;

				get_transmit_money(454) -> 4540000
			;

				get_transmit_money(455) -> 4550000
			;

				get_transmit_money(456) -> 4560000
			;

				get_transmit_money(457) -> 4570000
			;

				get_transmit_money(458) -> 4580000
			;

				get_transmit_money(459) -> 4590000
			;

				get_transmit_money(460) -> 4600000
			;

				get_transmit_money(461) -> 4610000
			;

				get_transmit_money(462) -> 4620000
			;

				get_transmit_money(463) -> 4630000
			;

				get_transmit_money(464) -> 4640000
			;

				get_transmit_money(465) -> 4650000
			;

				get_transmit_money(466) -> 4660000
			;

				get_transmit_money(467) -> 4670000
			;

				get_transmit_money(468) -> 4680000
			;

				get_transmit_money(469) -> 4690000
			;

				get_transmit_money(470) -> 4700000
			;

				get_transmit_money(471) -> 4710000
			;

				get_transmit_money(472) -> 4720000
			;

				get_transmit_money(473) -> 4730000
			;

				get_transmit_money(474) -> 4740000
			;

				get_transmit_money(475) -> 4750000
			;

				get_transmit_money(476) -> 4760000
			;

				get_transmit_money(477) -> 4770000
			;

				get_transmit_money(478) -> 4780000
			;

				get_transmit_money(479) -> 4790000
			;

				get_transmit_money(480) -> 4800000
			;

				get_transmit_money(481) -> 4810000
			;

				get_transmit_money(482) -> 4820000
			;

				get_transmit_money(483) -> 4830000
			;

				get_transmit_money(484) -> 4840000
			;

				get_transmit_money(485) -> 4850000
			;

				get_transmit_money(486) -> 4860000
			;

				get_transmit_money(487) -> 4870000
			;

				get_transmit_money(488) -> 4880000
			;

				get_transmit_money(489) -> 4890000
			;

				get_transmit_money(490) -> 4900000
			;

				get_transmit_money(491) -> 4910000
			;

				get_transmit_money(492) -> 4920000
			;

				get_transmit_money(493) -> 4930000
			;

				get_transmit_money(494) -> 4940000
			;

				get_transmit_money(495) -> 4950000
			;

				get_transmit_money(496) -> 4960000
			;

				get_transmit_money(497) -> 4970000
			;

				get_transmit_money(498) -> 4980000
			;

				get_transmit_money(499) -> 4990000
			;

				get_transmit_money(500) -> 5000000
			;

				get_transmit_money(_Lv) ->
	?MAX_U32.
		
