%%%---------------------------------------
%%% @Module  : data_addi_equip_add
%%% @Author  : huangjf
%%% @Email   : 
%%% @Created : 2013-07-07  20:11:25
%%% @Description:  装备的附加属性加成的基数表，
%%%                自动生成（模板：addi_equip_add.tpl.php）
%%%---------------------------------------

-module(data_addi_equip_add).

-export([get/2]).

-include("record.hrl").
-include("debug.hrl").



get(0, 1) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 3,
		talent_spi = 3,
		talent_str = 3,
		talent_sta = 3,
		talent_agi = 3
		};

get(10, 1) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 6,
		talent_spi = 6,
		talent_str = 6,
		talent_sta = 6,
		talent_agi = 6
		};

get(20, 1) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 9,
		talent_spi = 9,
		talent_str = 9,
		talent_sta = 9,
		talent_agi = 9
		};

get(30, 1) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 12,
		talent_spi = 12,
		talent_str = 12,
		talent_sta = 12,
		talent_agi = 12
		};

get(40, 1) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 15,
		talent_spi = 15,
		talent_str = 15,
		talent_sta = 15,
		talent_agi = 15
		};

get(50, 1) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 18,
		talent_spi = 18,
		talent_str = 18,
		talent_sta = 18,
		talent_agi = 18
		};

get(60, 1) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 21,
		talent_spi = 21,
		talent_str = 21,
		talent_sta = 21,
		talent_agi = 21
		};

get(70, 1) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 24,
		talent_spi = 24,
		talent_str = 24,
		talent_sta = 24,
		talent_agi = 24
		};

get(80, 1) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 27,
		talent_spi = 27,
		talent_str = 27,
		talent_sta = 27,
		talent_agi = 27
		};

get(90, 1) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 30,
		talent_spi = 30,
		talent_str = 30,
		talent_sta = 30,
		talent_agi = 30
		};

get(100, 1) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 33,
		talent_spi = 33,
		talent_str = 33,
		talent_sta = 33,
		talent_agi = 33
		};

get(110, 1) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 36,
		talent_spi = 36,
		talent_str = 36,
		talent_sta = 36,
		talent_agi = 36
		};

get(120, 1) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 39,
		talent_spi = 39,
		talent_str = 39,
		talent_sta = 39,
		talent_agi = 39
		};

get(130, 1) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 42,
		talent_spi = 42,
		talent_str = 42,
		talent_sta = 42,
		talent_agi = 42
		};

get(140, 1) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 45,
		talent_spi = 45,
		talent_str = 45,
		talent_sta = 45,
		talent_agi = 45
		};

get(150, 1) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 48,
		talent_spi = 48,
		talent_str = 48,
		talent_sta = 48,
		talent_agi = 48
		};

get(0, 5) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 2,
		talent_spi = 2,
		talent_str = 2,
		talent_sta = 2,
		talent_agi = 2
		};

get(10, 5) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 5,
		talent_spi = 5,
		talent_str = 5,
		talent_sta = 5,
		talent_agi = 5
		};

get(20, 5) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 7,
		talent_spi = 7,
		talent_str = 7,
		talent_sta = 7,
		talent_agi = 7
		};

get(30, 5) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 9,
		talent_spi = 9,
		talent_str = 9,
		talent_sta = 9,
		talent_agi = 9
		};

get(40, 5) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 11,
		talent_spi = 11,
		talent_str = 11,
		talent_sta = 11,
		talent_agi = 11
		};

get(50, 5) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 14,
		talent_spi = 14,
		talent_str = 14,
		talent_sta = 14,
		talent_agi = 14
		};

get(60, 5) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 16,
		talent_spi = 16,
		talent_str = 16,
		talent_sta = 16,
		talent_agi = 16
		};

get(70, 5) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 18,
		talent_spi = 18,
		talent_str = 18,
		talent_sta = 18,
		talent_agi = 18
		};

get(80, 5) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 20,
		talent_spi = 20,
		talent_str = 20,
		talent_sta = 20,
		talent_agi = 20
		};

get(90, 5) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 23,
		talent_spi = 23,
		talent_str = 23,
		talent_sta = 23,
		talent_agi = 23
		};

get(100, 5) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 25,
		talent_spi = 25,
		talent_str = 25,
		talent_sta = 25,
		talent_agi = 25
		};

get(110, 5) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 27,
		talent_spi = 27,
		talent_str = 27,
		talent_sta = 27,
		talent_agi = 27
		};

get(120, 5) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 29,
		talent_spi = 29,
		talent_str = 29,
		talent_sta = 29,
		talent_agi = 29
		};

get(130, 5) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 32,
		talent_spi = 32,
		talent_str = 32,
		talent_sta = 32,
		talent_agi = 32
		};

get(140, 5) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 34,
		talent_spi = 34,
		talent_str = 34,
		talent_sta = 34,
		talent_agi = 34
		};

get(150, 5) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 36,
		talent_spi = 36,
		talent_str = 36,
		talent_sta = 36,
		talent_agi = 36
		};

get(0, 7) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 2,
		talent_spi = 2,
		talent_str = 2,
		talent_sta = 2,
		talent_agi = 2
		};

get(10, 7) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 5,
		talent_spi = 5,
		talent_str = 5,
		talent_sta = 5,
		talent_agi = 5
		};

get(20, 7) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 7,
		talent_spi = 7,
		talent_str = 7,
		talent_sta = 7,
		talent_agi = 7
		};

get(30, 7) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 9,
		talent_spi = 9,
		talent_str = 9,
		talent_sta = 9,
		talent_agi = 9
		};

get(40, 7) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 11,
		talent_spi = 11,
		talent_str = 11,
		talent_sta = 11,
		talent_agi = 11
		};

get(50, 7) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 14,
		talent_spi = 14,
		talent_str = 14,
		talent_sta = 14,
		talent_agi = 14
		};

get(60, 7) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 16,
		talent_spi = 16,
		talent_str = 16,
		talent_sta = 16,
		talent_agi = 16
		};

get(70, 7) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 18,
		talent_spi = 18,
		talent_str = 18,
		talent_sta = 18,
		talent_agi = 18
		};

get(80, 7) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 20,
		talent_spi = 20,
		talent_str = 20,
		talent_sta = 20,
		talent_agi = 20
		};

get(90, 7) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 23,
		talent_spi = 23,
		talent_str = 23,
		talent_sta = 23,
		talent_agi = 23
		};

get(100, 7) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 25,
		talent_spi = 25,
		talent_str = 25,
		talent_sta = 25,
		talent_agi = 25
		};

get(110, 7) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 27,
		talent_spi = 27,
		talent_str = 27,
		talent_sta = 27,
		talent_agi = 27
		};

get(120, 7) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 29,
		talent_spi = 29,
		talent_str = 29,
		talent_sta = 29,
		talent_agi = 29
		};

get(130, 7) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 32,
		talent_spi = 32,
		talent_str = 32,
		talent_sta = 32,
		talent_agi = 32
		};

get(140, 7) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 34,
		talent_spi = 34,
		talent_str = 34,
		talent_sta = 34,
		talent_agi = 34
		};

get(150, 7) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 36,
		talent_spi = 36,
		talent_str = 36,
		talent_sta = 36,
		talent_agi = 36
		};

get(0, 3) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 2,
		talent_spi = 2,
		talent_str = 2,
		talent_sta = 2,
		talent_agi = 2
		};

get(10, 3) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 3,
		talent_spi = 3,
		talent_str = 3,
		talent_sta = 3,
		talent_agi = 3
		};

get(20, 3) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 5,
		talent_spi = 5,
		talent_str = 5,
		talent_sta = 5,
		talent_agi = 5
		};

get(30, 3) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 6,
		talent_spi = 6,
		talent_str = 6,
		talent_sta = 6,
		talent_agi = 6
		};

get(40, 3) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 8,
		talent_spi = 8,
		talent_str = 8,
		talent_sta = 8,
		talent_agi = 8
		};

get(50, 3) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 9,
		talent_spi = 9,
		talent_str = 9,
		talent_sta = 9,
		talent_agi = 9
		};

get(60, 3) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 11,
		talent_spi = 11,
		talent_str = 11,
		talent_sta = 11,
		talent_agi = 11
		};

get(70, 3) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 12,
		talent_spi = 12,
		talent_str = 12,
		talent_sta = 12,
		talent_agi = 12
		};

get(80, 3) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 14,
		talent_spi = 14,
		talent_str = 14,
		talent_sta = 14,
		talent_agi = 14
		};

get(90, 3) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 15,
		talent_spi = 15,
		talent_str = 15,
		talent_sta = 15,
		talent_agi = 15
		};

get(100, 3) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 17,
		talent_spi = 17,
		talent_str = 17,
		talent_sta = 17,
		talent_agi = 17
		};

get(110, 3) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 18,
		talent_spi = 18,
		talent_str = 18,
		talent_sta = 18,
		talent_agi = 18
		};

get(120, 3) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 20,
		talent_spi = 20,
		talent_str = 20,
		talent_sta = 20,
		talent_agi = 20
		};

get(130, 3) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 21,
		talent_spi = 21,
		talent_str = 21,
		talent_sta = 21,
		talent_agi = 21
		};

get(140, 3) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 23,
		talent_spi = 23,
		talent_str = 23,
		talent_sta = 23,
		talent_agi = 23
		};

get(150, 3) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 24,
		talent_spi = 24,
		talent_str = 24,
		talent_sta = 24,
		talent_agi = 24
		};

get(0, 6) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 2,
		talent_spi = 2,
		talent_str = 2,
		talent_sta = 2,
		talent_agi = 2
		};

get(10, 6) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 3,
		talent_spi = 3,
		talent_str = 3,
		talent_sta = 3,
		talent_agi = 3
		};

get(20, 6) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 5,
		talent_spi = 5,
		talent_str = 5,
		talent_sta = 5,
		talent_agi = 5
		};

get(30, 6) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 6,
		talent_spi = 6,
		talent_str = 6,
		talent_sta = 6,
		talent_agi = 6
		};

get(40, 6) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 8,
		talent_spi = 8,
		talent_str = 8,
		talent_sta = 8,
		talent_agi = 8
		};

get(50, 6) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 9,
		talent_spi = 9,
		talent_str = 9,
		talent_sta = 9,
		talent_agi = 9
		};

get(60, 6) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 11,
		talent_spi = 11,
		talent_str = 11,
		talent_sta = 11,
		talent_agi = 11
		};

get(70, 6) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 12,
		talent_spi = 12,
		talent_str = 12,
		talent_sta = 12,
		talent_agi = 12
		};

get(80, 6) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 14,
		talent_spi = 14,
		talent_str = 14,
		talent_sta = 14,
		talent_agi = 14
		};

get(90, 6) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 15,
		talent_spi = 15,
		talent_str = 15,
		talent_sta = 15,
		talent_agi = 15
		};

get(100, 6) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 17,
		talent_spi = 17,
		talent_str = 17,
		talent_sta = 17,
		talent_agi = 17
		};

get(110, 6) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 18,
		talent_spi = 18,
		talent_str = 18,
		talent_sta = 18,
		talent_agi = 18
		};

get(120, 6) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 20,
		talent_spi = 20,
		talent_str = 20,
		talent_sta = 20,
		talent_agi = 20
		};

get(130, 6) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 21,
		talent_spi = 21,
		talent_str = 21,
		talent_sta = 21,
		talent_agi = 21
		};

get(140, 6) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 23,
		talent_spi = 23,
		talent_str = 23,
		talent_sta = 23,
		talent_agi = 23
		};

get(150, 6) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 24,
		talent_spi = 24,
		talent_str = 24,
		talent_sta = 24,
		talent_agi = 24
		};

get(0, 4) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 2,
		talent_spi = 2,
		talent_str = 2,
		talent_sta = 2,
		talent_agi = 2
		};

get(10, 4) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 3,
		talent_spi = 3,
		talent_str = 3,
		talent_sta = 3,
		talent_agi = 3
		};

get(20, 4) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 5,
		talent_spi = 5,
		talent_str = 5,
		talent_sta = 5,
		talent_agi = 5
		};

get(30, 4) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 6,
		talent_spi = 6,
		talent_str = 6,
		talent_sta = 6,
		talent_agi = 6
		};

get(40, 4) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 8,
		talent_spi = 8,
		talent_str = 8,
		talent_sta = 8,
		talent_agi = 8
		};

get(50, 4) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 9,
		talent_spi = 9,
		talent_str = 9,
		talent_sta = 9,
		talent_agi = 9
		};

get(60, 4) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 11,
		talent_spi = 11,
		talent_str = 11,
		talent_sta = 11,
		talent_agi = 11
		};

get(70, 4) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 12,
		talent_spi = 12,
		talent_str = 12,
		talent_sta = 12,
		talent_agi = 12
		};

get(80, 4) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 14,
		talent_spi = 14,
		talent_str = 14,
		talent_sta = 14,
		talent_agi = 14
		};

get(90, 4) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 15,
		talent_spi = 15,
		talent_str = 15,
		talent_sta = 15,
		talent_agi = 15
		};

get(100, 4) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 17,
		talent_spi = 17,
		talent_str = 17,
		talent_sta = 17,
		talent_agi = 17
		};

get(110, 4) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 18,
		talent_spi = 18,
		talent_str = 18,
		talent_sta = 18,
		talent_agi = 18
		};

get(120, 4) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 20,
		talent_spi = 20,
		talent_str = 20,
		talent_sta = 20,
		talent_agi = 20
		};

get(130, 4) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 21,
		talent_spi = 21,
		talent_str = 21,
		talent_sta = 21,
		talent_agi = 21
		};

get(140, 4) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 23,
		talent_spi = 23,
		talent_str = 23,
		talent_sta = 23,
		talent_agi = 23
		};

get(150, 4) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 24,
		talent_spi = 24,
		talent_str = 24,
		talent_sta = 24,
		talent_agi = 24
		};

get(0, 2) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 2,
		talent_spi = 2,
		talent_str = 2,
		talent_sta = 2,
		talent_agi = 2
		};

get(10, 2) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 3,
		talent_spi = 3,
		talent_str = 3,
		talent_sta = 3,
		talent_agi = 3
		};

get(20, 2) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 5,
		talent_spi = 5,
		talent_str = 5,
		talent_sta = 5,
		talent_agi = 5
		};

get(30, 2) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 6,
		talent_spi = 6,
		talent_str = 6,
		talent_sta = 6,
		talent_agi = 6
		};

get(40, 2) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 8,
		talent_spi = 8,
		talent_str = 8,
		talent_sta = 8,
		talent_agi = 8
		};

get(50, 2) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 9,
		talent_spi = 9,
		talent_str = 9,
		talent_sta = 9,
		talent_agi = 9
		};

get(60, 2) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 11,
		talent_spi = 11,
		talent_str = 11,
		talent_sta = 11,
		talent_agi = 11
		};

get(70, 2) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 12,
		talent_spi = 12,
		talent_str = 12,
		talent_sta = 12,
		talent_agi = 12
		};

get(80, 2) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 14,
		talent_spi = 14,
		talent_str = 14,
		talent_sta = 14,
		talent_agi = 14
		};

get(90, 2) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 15,
		talent_spi = 15,
		talent_str = 15,
		talent_sta = 15,
		talent_agi = 15
		};

get(100, 2) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 17,
		talent_spi = 17,
		talent_str = 17,
		talent_sta = 17,
		talent_agi = 17
		};

get(110, 2) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 18,
		talent_spi = 18,
		talent_str = 18,
		talent_sta = 18,
		talent_agi = 18
		};

get(120, 2) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 20,
		talent_spi = 20,
		talent_str = 20,
		talent_sta = 20,
		talent_agi = 20
		};

get(130, 2) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 21,
		talent_spi = 21,
		talent_str = 21,
		talent_sta = 21,
		talent_agi = 21
		};

get(140, 2) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 23,
		talent_spi = 23,
		talent_str = 23,
		talent_sta = 23,
		talent_agi = 23
		};

get(150, 2) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 24,
		talent_spi = 24,
		talent_str = 24,
		talent_sta = 24,
		talent_agi = 24
		};

get(0, 8) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 2,
		talent_spi = 2,
		talent_str = 2,
		talent_sta = 2,
		talent_agi = 2
		};

get(10, 8) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 5,
		talent_spi = 5,
		talent_str = 5,
		talent_sta = 5,
		talent_agi = 5
		};

get(20, 8) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 7,
		talent_spi = 7,
		talent_str = 7,
		talent_sta = 7,
		talent_agi = 7
		};

get(30, 8) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 9,
		talent_spi = 9,
		talent_str = 9,
		talent_sta = 9,
		talent_agi = 9
		};

get(40, 8) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 11,
		talent_spi = 11,
		talent_str = 11,
		talent_sta = 11,
		talent_agi = 11
		};

get(50, 8) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 14,
		talent_spi = 14,
		talent_str = 14,
		talent_sta = 14,
		talent_agi = 14
		};

get(60, 8) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 16,
		talent_spi = 16,
		talent_str = 16,
		talent_sta = 16,
		talent_agi = 16
		};

get(70, 8) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 18,
		talent_spi = 18,
		talent_str = 18,
		talent_sta = 18,
		talent_agi = 18
		};

get(80, 8) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 20,
		talent_spi = 20,
		talent_str = 20,
		talent_sta = 20,
		talent_agi = 20
		};

get(90, 8) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 23,
		talent_spi = 23,
		talent_str = 23,
		talent_sta = 23,
		talent_agi = 23
		};

get(100, 8) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 25,
		talent_spi = 25,
		talent_str = 25,
		talent_sta = 25,
		talent_agi = 25
		};

get(110, 8) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 27,
		talent_spi = 27,
		talent_str = 27,
		talent_sta = 27,
		talent_agi = 27
		};

get(120, 8) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 29,
		talent_spi = 29,
		talent_str = 29,
		talent_sta = 29,
		talent_agi = 29
		};

get(130, 8) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 32,
		talent_spi = 32,
		talent_str = 32,
		talent_sta = 32,
		talent_agi = 32
		};

get(140, 8) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 34,
		talent_spi = 34,
		talent_str = 34,
		talent_sta = 34,
		talent_agi = 34
		};

get(150, 8) ->  % 参数表示装备所属的等级段和装备的部位
	#attrs{
		talent_con = 36,
		talent_spi = 36,
		talent_str = 36,
		talent_sta = 36,
		talent_agi = 36
		};
	
get(_LvStep, _Race) ->
	?ASSERT(false, {_LvStep, _Race}),
    null.
