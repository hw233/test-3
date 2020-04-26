%% Author: huangjf
%% Created: 2014.4.9
%% Description: 测试lists:concat()以及list_to_atom()的效率
-module(tst_list_concat_and_to_atom).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([
		test/0,
		test2/0,
		test3/1
	]).

%%
%% API Functions
%%
test() ->
	tst_prof:run(fun list_concat_and_to_atom/0, 1).


test2() ->
	tst_prof:run(fun cmp_and_get/0, 1).






-define(LOOP_TIMES, 1000000).



list_concat_and_to_atom() ->
	list_concat_and_to_atom__(1).

list_concat_and_to_atom__(SeqNum) when SeqNum >= ?LOOP_TIMES ->
	%%io:format("list_concat_and_to_atom__(), SeqNum: ~p~n", [SeqNum]),
	done;
list_concat_and_to_atom__(SeqNum) ->
	_Atom = list_to_atom( lists:concat([ets_online_, SeqNum]) ),
	list_concat_and_to_atom__(SeqNum + 1).



cmp_and_get() ->
	cmp_and_get__(1).

cmp_and_get__(SeqNum) when SeqNum >= ?LOOP_TIMES ->
	%%io:format("cmp_and_get__(), SeqNum: ~p~n", [SeqNum]),
	done;
cmp_and_get__(SeqNum) ->
	Remainder = SeqNum rem 100,

	_Atom = 
	case Remainder < 64 of
		true ->
			case Remainder < 32 of
				true->
					case Remainder < 16 of
						true ->
							case Remainder of
								0 -> ets_online_1;
								1 -> ets_online_2;
								2 -> ets_online_3;
								3 -> ets_online_4;
								4 -> ets_online_5;
								5 -> ets_online_6;
								6 -> ets_online_7;
								7 -> ets_online_8;
								8 -> ets_online_9;
								9 -> ets_online_10;
								10 -> ets_online_11;
								11 -> ets_online_12;
								12 -> ets_online_13;
								13 -> ets_online_14;
								14 -> ets_online_15;
								15 -> ets_online_16
							end;
						false ->
							case Remainder of
								16 -> ets_online_17;
								17 -> ets_online_18;
								18 -> ets_online_19;
								19 -> ets_online_20;
								20 -> ets_online_21;
								21 -> ets_online_22;
								22 -> ets_online_23;
								23 -> ets_online_24;
								24 -> ets_online_25;
								25 -> ets_online_26;
								26 -> ets_online_27;
								27 -> ets_online_28;
								28 -> ets_online_29;
								29 -> ets_online_30;
								30 -> ets_online_31;
								31 -> ets_online_32
							end
					end;
				false ->
					case Remainder < 48 of
						true ->
							case Remainder of
								32 -> ets_online_33;
								33 -> ets_online_34;
								34 -> ets_online_35;
								35 -> ets_online_36;
								36 -> ets_online_37;
								37 -> ets_online_38;
								38 -> ets_online_39;
								39 -> ets_online_40;
								40 -> ets_online_41;
								41 -> ets_online_42;
								42 -> ets_online_43;
								43 -> ets_online_44;
								44 -> ets_online_45;
								45 -> ets_online_46;
								46 -> ets_online_47;
								47 -> ets_online_48
							end;
						false ->
							case Remainder of
								48 -> ets_online_49;
								49 -> ets_online_50;
								50 -> ets_online_51;
								51 -> ets_online_52;
								52 -> ets_online_53;
								53 -> ets_online_54;
								54 -> ets_online_55;
								55 -> ets_online_56;
								56 -> ets_online_57;
								57 -> ets_online_58;
								58 -> ets_online_59;
								59 -> ets_online_60;
								60 -> ets_online_61;
								61 -> ets_online_62;
								62 -> ets_online_63;
								63 -> ets_online_64
							end
					end
			end;
		false ->


			case Remainder < 96 of
				true->
					case Remainder < 80 of
						true ->
							case Remainder of
								64 -> ets_online_65;
								65 -> ets_online_66;
								66 -> ets_online_67;
								67 -> ets_online_68;
								68 -> ets_online_69;
								69 -> ets_online_70;
								70 -> ets_online_71;
								71 -> ets_online_72;
								72 -> ets_online_73;
								73 -> ets_online_74;
								74 -> ets_online_75;
								75 -> ets_online_76;
								76 -> ets_online_77;
								77 -> ets_online_78;
								78 -> ets_online_79;
								79 -> ets_online_80
							end;
						false ->
							case Remainder of
								80 -> ets_online_81;
								81 -> ets_online_82;
								82 -> ets_online_83;
								83 -> ets_online_84;
								84 -> ets_online_85;
								85 -> ets_online_86;
								86 -> ets_online_87;
								87 -> ets_online_88;
								88 -> ets_online_89;
								89 -> ets_online_90;
								90 -> ets_online_91;
								91 -> ets_online_92;
								92 -> ets_online_93;
								93 -> ets_online_94;
								94 -> ets_online_95;
								95 -> ets_online_96
							end
					end;
				false ->
					case Remainder < 112 of
						true ->
							case Remainder of
								96 -> ets_online_97;
								97 -> ets_online_98;
								98 -> ets_online_99;
								99 -> ets_online_100;
								100 -> ets_online_101;
								101 -> ets_online_102;
								102 -> ets_online_103;
								103 -> ets_online_104;
								104 -> ets_online_105;
								105 -> ets_online_106;
								106 -> ets_online_107;
								107 -> ets_online_108;
								108 -> ets_online_109;
								109 -> ets_online_110;
								110 -> ets_online_111;
								111 -> ets_online_112
							end;
						false ->
							case Remainder of
								112 -> ets_online_113;
								113 -> ets_online_114;
								114 -> ets_online_115;
								115 -> ets_online_116;
								116 -> ets_online_117;
								117 -> ets_online_118;
								118 -> ets_online_119;
								119 -> ets_online_120;
								120 -> ets_online_121;
								121 -> ets_online_122;
								122 -> ets_online_123;
								123 -> ets_online_124;
								124 -> ets_online_125;
								125 -> ets_online_126;
								126 -> ets_online_127;
								127 -> ets_online_128
							end
					end
			end

	end,

	cmp_and_get__(SeqNum + 1).








test3(N) ->
	test3__(1, N).


test3__(SeqNum, N) when SeqNum > N ->
	done;

test3__(SeqNum, N) ->
	TblName = player:my_ets_online(SeqNum),
	io:format("SeqNum:~p, TblName:~p~n", [SeqNum, TblName]),
	test3__(SeqNum + 1, N).




%%
%% Local Functions
%%

