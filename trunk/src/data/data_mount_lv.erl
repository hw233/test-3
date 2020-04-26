%%%---------------------------------------
%%% @Module  : data_mount_lv
%%% @Author  : lf
%%% @Email   : 
%%% @Description:  坐骑相关
%%%---------------------------------------


-module(data_mount_lv).
-include("common.hrl").
-include("record.hrl").
-include("mount.hrl").
-include("num_limits.hrl").
-compile(export_all).


				get_exp_lim(1) -> 258
			;

				get_exp_lim(2) -> 556
			;

				get_exp_lim(3) -> 824
			;

				get_exp_lim(4) -> 1046
			;

				get_exp_lim(5) -> 1285
			;

				get_exp_lim(6) -> 1540
			;

				get_exp_lim(7) -> 1807
			;

				get_exp_lim(8) -> 2087
			;

				get_exp_lim(9) -> 2377
			;

				get_exp_lim(10) -> 2677
			;

				get_exp_lim(11) -> 2986
			;

				get_exp_lim(12) -> 3303
			;

				get_exp_lim(13) -> 3629
			;

				get_exp_lim(14) -> 3962
			;

				get_exp_lim(15) -> 4303
			;

				get_exp_lim(16) -> 4650
			;

				get_exp_lim(17) -> 5004
			;

				get_exp_lim(18) -> 5364
			;

				get_exp_lim(19) -> 5731
			;

				get_exp_lim(20) -> 6103
			;

				get_exp_lim(21) -> 6480
			;

				get_exp_lim(22) -> 6864
			;

				get_exp_lim(23) -> 7252
			;

				get_exp_lim(24) -> 7646
			;

				get_exp_lim(25) -> 8044
			;

				get_exp_lim(26) -> 8447
			;

				get_exp_lim(27) -> 8855
			;

				get_exp_lim(28) -> 9268
			;

				get_exp_lim(29) -> 9685
			;

				get_exp_lim(30) -> 10106
			;

				get_exp_lim(31) -> 10532
			;

				get_exp_lim(32) -> 10962
			;

				get_exp_lim(33) -> 11395
			;

				get_exp_lim(34) -> 11833
			;

				get_exp_lim(35) -> 12275
			;

				get_exp_lim(36) -> 12720
			;

				get_exp_lim(37) -> 13169
			;

				get_exp_lim(38) -> 13622
			;

				get_exp_lim(39) -> 14079
			;

				get_exp_lim(40) -> 14538
			;

				get_exp_lim(41) -> 15002
			;

				get_exp_lim(42) -> 15469
			;

				get_exp_lim(43) -> 15939
			;

				get_exp_lim(44) -> 16412
			;

				get_exp_lim(45) -> 16889
			;

				get_exp_lim(46) -> 17369
			;

				get_exp_lim(47) -> 17852
			;

				get_exp_lim(48) -> 18338
			;

				get_exp_lim(49) -> 18827
			;

				get_exp_lim(50) -> 19319
			;

				get_exp_lim(51) -> 19814
			;

				get_exp_lim(52) -> 20312
			;

				get_exp_lim(53) -> 20813
			;

				get_exp_lim(54) -> 21317
			;

				get_exp_lim(55) -> 21823
			;

				get_exp_lim(56) -> 22332
			;

				get_exp_lim(57) -> 22844
			;

				get_exp_lim(58) -> 23359
			;

				get_exp_lim(59) -> 23877
			;

				get_exp_lim(60) -> 24397
			;

				get_exp_lim(61) -> 24919
			;

				get_exp_lim(62) -> 25445
			;

				get_exp_lim(63) -> 25972
			;

				get_exp_lim(64) -> 26503
			;

				get_exp_lim(65) -> 27035
			;

				get_exp_lim(66) -> 27571
			;

				get_exp_lim(67) -> 28108
			;

				get_exp_lim(68) -> 28649
			;

				get_exp_lim(69) -> 29191
			;

				get_exp_lim(70) -> 29736
			;

				get_exp_lim(71) -> 30283
			;

				get_exp_lim(72) -> 30833
			;

				get_exp_lim(73) -> 31384
			;

				get_exp_lim(74) -> 31939
			;

				get_exp_lim(75) -> 32495
			;

				get_exp_lim(76) -> 33053
			;

				get_exp_lim(77) -> 33614
			;

				get_exp_lim(78) -> 34177
			;

				get_exp_lim(79) -> 34742
			;

				get_exp_lim(80) -> 35310
			;

				get_exp_lim(81) -> 35879
			;

				get_exp_lim(82) -> 36451
			;

				get_exp_lim(83) -> 37024
			;

				get_exp_lim(84) -> 37600
			;

				get_exp_lim(85) -> 38178
			;

				get_exp_lim(86) -> 38757
			;

				get_exp_lim(87) -> 39339
			;

				get_exp_lim(88) -> 39923
			;

				get_exp_lim(89) -> 40509
			;

				get_exp_lim(90) -> 41097
			;

				get_exp_lim(91) -> 41687
			;

				get_exp_lim(92) -> 42278
			;

				get_exp_lim(93) -> 42872
			;

				get_exp_lim(94) -> 43468
			;

				get_exp_lim(95) -> 44065
			;

				get_exp_lim(96) -> 44664
			;

				get_exp_lim(97) -> 45266
			;

				get_exp_lim(98) -> 45869
			;

				get_exp_lim(99) -> 46474
			;

				get_exp_lim(100) -> 47081
			;

				get_exp_lim(101) -> 47689
			;

				get_exp_lim(102) -> 48300
			;

				get_exp_lim(103) -> 48912
			;

				get_exp_lim(104) -> 49526
			;

				get_exp_lim(105) -> 50142
			;

				get_exp_lim(106) -> 50759
			;

				get_exp_lim(107) -> 51378
			;

				get_exp_lim(108) -> 51999
			;

				get_exp_lim(109) -> 52622
			;

				get_exp_lim(110) -> 53247
			;

				get_exp_lim(111) -> 53873
			;

				get_exp_lim(112) -> 54501
			;

				get_exp_lim(113) -> 55130
			;

				get_exp_lim(114) -> 55762
			;

				get_exp_lim(115) -> 56394
			;

				get_exp_lim(116) -> 57029
			;

				get_exp_lim(117) -> 57665
			;

				get_exp_lim(118) -> 58303
			;

				get_exp_lim(119) -> 58943
			;

				get_exp_lim(120) -> 59584
			;

				get_exp_lim(121) -> 60226
			;

				get_exp_lim(122) -> 60871
			;

				get_exp_lim(123) -> 61516
			;

				get_exp_lim(124) -> 62164
			;

				get_exp_lim(125) -> 62813
			;

				get_exp_lim(126) -> 63463
			;

				get_exp_lim(127) -> 64115
			;

				get_exp_lim(128) -> 64769
			;

				get_exp_lim(129) -> 65424
			;

				get_exp_lim(130) -> 66081
			;

				get_exp_lim(131) -> 66739
			;

				get_exp_lim(132) -> 67399
			;

				get_exp_lim(133) -> 68060
			;

				get_exp_lim(134) -> 68723
			;

				get_exp_lim(135) -> 69387
			;

				get_exp_lim(136) -> 70053
			;

				get_exp_lim(137) -> 70720
			;

				get_exp_lim(138) -> 71389
			;

				get_exp_lim(139) -> 72059
			;

				get_exp_lim(140) -> 72730
			;

				get_exp_lim(141) -> 73403
			;

				get_exp_lim(142) -> 74078
			;

				get_exp_lim(143) -> 74753
			;

				get_exp_lim(144) -> 75431
			;

				get_exp_lim(145) -> 76109
			;

				get_exp_lim(146) -> 76789
			;

				get_exp_lim(147) -> 77471
			;

				get_exp_lim(148) -> 78154
			;

				get_exp_lim(149) -> 78838
			;

				get_exp_lim(150) -> 79524
			;

				get_exp_lim(151) -> 80211
			;

				get_exp_lim(152) -> 80899
			;

				get_exp_lim(153) -> 81589
			;

				get_exp_lim(154) -> 82280
			;

				get_exp_lim(155) -> 82972
			;

				get_exp_lim(156) -> 83666
			;

				get_exp_lim(157) -> 84361
			;

				get_exp_lim(158) -> 85058
			;

				get_exp_lim(159) -> 85755
			;

				get_exp_lim(160) -> 86454
			;

				get_exp_lim(161) -> 87155
			;

				get_exp_lim(162) -> 87856
			;

				get_exp_lim(163) -> 88559
			;

				get_exp_lim(164) -> 89264
			;

				get_exp_lim(165) -> 89969
			;

				get_exp_lim(166) -> 90676
			;

				get_exp_lim(167) -> 91384
			;

				get_exp_lim(168) -> 92094
			;

				get_exp_lim(169) -> 92804
			;

				get_exp_lim(170) -> 93516
			;

				get_exp_lim(171) -> 94230
			;

				get_exp_lim(172) -> 94944
			;

				get_exp_lim(173) -> 95660
			;

				get_exp_lim(174) -> 96377
			;

				get_exp_lim(175) -> 97095
			;

				get_exp_lim(176) -> 97814
			;

				get_exp_lim(177) -> 98535
			;

				get_exp_lim(178) -> 99257
			;

				get_exp_lim(179) -> 99980
			;

				get_exp_lim(180) -> 100704
			;

				get_exp_lim(181) -> 101430
			;

				get_exp_lim(182) -> 102156
			;

				get_exp_lim(183) -> 102884
			;

				get_exp_lim(184) -> 103613
			;

				get_exp_lim(185) -> 104344
			;

				get_exp_lim(186) -> 105075
			;

				get_exp_lim(187) -> 105808
			;

				get_exp_lim(188) -> 106542
			;

				get_exp_lim(189) -> 107277
			;

				get_exp_lim(190) -> 108013
			;

				get_exp_lim(191) -> 108750
			;

				get_exp_lim(192) -> 109489
			;

				get_exp_lim(193) -> 110228
			;

				get_exp_lim(194) -> 110969
			;

				get_exp_lim(195) -> 111711
			;

				get_exp_lim(196) -> 112454
			;

				get_exp_lim(197) -> 113198
			;

				get_exp_lim(198) -> 113944
			;

				get_exp_lim(199) -> 114690
			;

				get_exp_lim(200) -> 115438
			;

				get_exp_lim(201) -> 116186
			;

				get_exp_lim(202) -> 116936
			;

				get_exp_lim(203) -> 117687
			;

				get_exp_lim(204) -> 118439
			;

				get_exp_lim(205) -> 119193
			;

				get_exp_lim(206) -> 119947
			;

				get_exp_lim(207) -> 120702
			;

				get_exp_lim(208) -> 121459
			;

				get_exp_lim(209) -> 122216
			;

				get_exp_lim(210) -> 122975
			;

				get_exp_lim(211) -> 123735
			;

				get_exp_lim(212) -> 124495
			;

				get_exp_lim(213) -> 125257
			;

				get_exp_lim(214) -> 126020
			;

				get_exp_lim(215) -> 126784
			;

				get_exp_lim(216) -> 127550
			;

				get_exp_lim(217) -> 128316
			;

				get_exp_lim(218) -> 129083
			;

				get_exp_lim(219) -> 129851
			;

				get_exp_lim(220) -> 130621
			;

				get_exp_lim(221) -> 131391
			;

				get_exp_lim(222) -> 132162
			;

				get_exp_lim(223) -> 132935
			;

				get_exp_lim(224) -> 133708
			;

				get_exp_lim(225) -> 134483
			;

				get_exp_lim(226) -> 135259
			;

				get_exp_lim(227) -> 136035
			;

				get_exp_lim(228) -> 136813
			;

				get_exp_lim(229) -> 137592
			;

				get_exp_lim(230) -> 138371
			;

				get_exp_lim(231) -> 139152
			;

				get_exp_lim(232) -> 139934
			;

				get_exp_lim(233) -> 140717
			;

				get_exp_lim(234) -> 141500
			;

				get_exp_lim(235) -> 142285
			;

				get_exp_lim(236) -> 143071
			;

				get_exp_lim(237) -> 143858
			;

				get_exp_lim(238) -> 144645
			;

				get_exp_lim(239) -> 145434
			;

				get_exp_lim(240) -> 146224
			;

				get_exp_lim(241) -> 147015
			;

				get_exp_lim(242) -> 147806
			;

				get_exp_lim(243) -> 148599
			;

				get_exp_lim(244) -> 149393
			;

				get_exp_lim(245) -> 150187
			;

				get_exp_lim(246) -> 150983
			;

				get_exp_lim(247) -> 151780
			;

				get_exp_lim(248) -> 152577
			;

				get_exp_lim(249) -> 153376
			;

				get_exp_lim(250) -> 154175
			;

				get_exp_lim(_Lv) ->
	?MAX_U32.
		
