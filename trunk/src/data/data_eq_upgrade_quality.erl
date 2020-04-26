%%%---------------------------------------
%%% @Module  : data_eq_upgrade_quality
%%% @Author  : zwq
%%% @Email   : 
%%% @Description:  
%%%---------------------------------------


-module(data_eq_upgrade_quality).
-include("common.hrl").
-include("record.hrl").
-include("record/goods_record.hrl").
-compile(export_all).

get(60,2) ->
	#upgrade_quality_cfg{
		lv = 60,
		quality = 2,
		money = [{9,10000}],
		goods_list = [{70051,60},{70052,60}]
};

get(60,3) ->
	#upgrade_quality_cfg{
		lv = 60,
		quality = 3,
		money = [{9,20000}],
		goods_list = [{70052,60},{70053,60}]
};

get(60,4) ->
	#upgrade_quality_cfg{
		lv = 60,
		quality = 4,
		money = [{9,40000}],
		goods_list = [{70053,60},{70054,60}]
};

get(60,5) ->
	#upgrade_quality_cfg{
		lv = 60,
		quality = 5,
		money = [{9,80000}],
		goods_list = [{70054,60},{70055,60}]
};

get(60,6) ->
	#upgrade_quality_cfg{
		lv = 60,
		quality = 6,
		money = [{9,160000}],
		goods_list = [{70055,60},{70056,60}]
};

get(120,2) ->
	#upgrade_quality_cfg{
		lv = 120,
		quality = 2,
		money = [{9,10000}],
		goods_list = [{70051,60},{70052,60}]
};

get(120,3) ->
	#upgrade_quality_cfg{
		lv = 120,
		quality = 3,
		money = [{9,20000}],
		goods_list = [{70052,60},{70053,60}]
};

get(120,4) ->
	#upgrade_quality_cfg{
		lv = 120,
		quality = 4,
		money = [{9,40000}],
		goods_list = [{70053,60},{70054,60}]
};

get(120,5) ->
	#upgrade_quality_cfg{
		lv = 120,
		quality = 5,
		money = [{9,80000}],
		goods_list = [{70054,60},{70055,60}]
};

get(120,6) ->
	#upgrade_quality_cfg{
		lv = 120,
		quality = 6,
		money = [{9,160000}],
		goods_list = [{70055,60},{70056,60}]
};

get(140,2) ->
	#upgrade_quality_cfg{
		lv = 140,
		quality = 2,
		money = [{9,10000}],
		goods_list = [{70051,60},{70052,60}]
};

get(140,3) ->
	#upgrade_quality_cfg{
		lv = 140,
		quality = 3,
		money = [{9,20000}],
		goods_list = [{70052,60},{70053,60}]
};

get(140,4) ->
	#upgrade_quality_cfg{
		lv = 140,
		quality = 4,
		money = [{9,40000}],
		goods_list = [{70053,60},{70054,60}]
};

get(140,5) ->
	#upgrade_quality_cfg{
		lv = 140,
		quality = 5,
		money = [{9,80000}],
		goods_list = [{70054,60},{70055,60}]
};

get(140,6) ->
	#upgrade_quality_cfg{
		lv = 140,
		quality = 6,
		money = [{9,160000}],
		goods_list = [{70055,60},{70056,60}]
};

get(160,2) ->
	#upgrade_quality_cfg{
		lv = 160,
		quality = 2,
		money = [{9,10000}],
		goods_list = [{70051,80},{70052,80}]
};

get(160,3) ->
	#upgrade_quality_cfg{
		lv = 160,
		quality = 3,
		money = [{9,20000}],
		goods_list = [{70052,80},{70053,80}]
};

get(160,4) ->
	#upgrade_quality_cfg{
		lv = 160,
		quality = 4,
		money = [{9,40000}],
		goods_list = [{70053,80},{70054,80}]
};

get(160,5) ->
	#upgrade_quality_cfg{
		lv = 160,
		quality = 5,
		money = [{9,80000}],
		goods_list = [{70054,80},{70055,80}]
};

get(160,6) ->
	#upgrade_quality_cfg{
		lv = 160,
		quality = 6,
		money = [{9,160000}],
		goods_list = [{70055,80},{70056,80}]
};

get(180,2) ->
	#upgrade_quality_cfg{
		lv = 180,
		quality = 2,
		money = [{9,10000}],
		goods_list = [{70051,100},{70052,100}]
};

get(180,3) ->
	#upgrade_quality_cfg{
		lv = 180,
		quality = 3,
		money = [{9,20000}],
		goods_list = [{70052,100},{70053,100}]
};

get(180,4) ->
	#upgrade_quality_cfg{
		lv = 180,
		quality = 4,
		money = [{9,40000}],
		goods_list = [{70053,100},{70054,100}]
};

get(180,5) ->
	#upgrade_quality_cfg{
		lv = 180,
		quality = 5,
		money = [{9,80000}],
		goods_list = [{70054,100},{70055,100}]
};

get(180,6) ->
	#upgrade_quality_cfg{
		lv = 180,
		quality = 6,
		money = [{9,160000}],
		goods_list = [{70055,100},{70056,100}]
};

get(200,2) ->
	#upgrade_quality_cfg{
		lv = 200,
		quality = 2,
		money = [{9,10000}],
		goods_list = [{70051,200},{70052,200}]
};

get(200,3) ->
	#upgrade_quality_cfg{
		lv = 200,
		quality = 3,
		money = [{9,20000}],
		goods_list = [{70052,200},{70053,200}]
};

get(200,4) ->
	#upgrade_quality_cfg{
		lv = 200,
		quality = 4,
		money = [{9,40000}],
		goods_list = [{70053,200},{70054,200}]
};

get(200,5) ->
	#upgrade_quality_cfg{
		lv = 200,
		quality = 5,
		money = [{9,80000}],
		goods_list = [{70054,200},{70055,200}]
};

get(200,6) ->
	#upgrade_quality_cfg{
		lv = 200,
		quality = 6,
		money = [{9,160000}],
		goods_list = [{70055,200},{70056,200}]
};

get(220,2) ->
	#upgrade_quality_cfg{
		lv = 220,
		quality = 2,
		money = [{9,10000}],
		goods_list = [{70051,300},{70052,300}]
};

get(220,3) ->
	#upgrade_quality_cfg{
		lv = 220,
		quality = 3,
		money = [{9,20000}],
		goods_list = [{70052,300},{70053,300}]
};

get(220,4) ->
	#upgrade_quality_cfg{
		lv = 220,
		quality = 4,
		money = [{9,40000}],
		goods_list = [{70053,300},{70054,300}]
};

get(220,5) ->
	#upgrade_quality_cfg{
		lv = 220,
		quality = 5,
		money = [{9,80000}],
		goods_list = [{70054,300},{70055,300}]
};

get(220,6) ->
	#upgrade_quality_cfg{
		lv = 220,
		quality = 6,
		money = [{9,160000}],
		goods_list = [{70055,300},{70056,300}]
};

get(250,2) ->
	#upgrade_quality_cfg{
		lv = 250,
		quality = 2,
		money = [{9,10000}],
		goods_list = [{70051,400},{70052,400}]
};

get(250,3) ->
	#upgrade_quality_cfg{
		lv = 250,
		quality = 3,
		money = [{9,20000}],
		goods_list = [{70052,400},{70053,400}]
};

get(250,4) ->
	#upgrade_quality_cfg{
		lv = 250,
		quality = 4,
		money = [{9,40000}],
		goods_list = [{70053,400},{70054,400}]
};

get(250,5) ->
	#upgrade_quality_cfg{
		lv = 250,
		quality = 5,
		money = [{9,80000}],
		goods_list = [{70054,400},{70055,400}]
};

get(250,6) ->
	#upgrade_quality_cfg{
		lv = 250,
		quality = 6,
		money = [{9,160000}],
		goods_list = [{70055,400},{70056,400}]
};

get(300,2) ->
	#upgrade_quality_cfg{
		lv = 300,
		quality = 2,
		money = [{9,10000}],
		goods_list = [{70051,500},{70052,500}]
};

get(300,3) ->
	#upgrade_quality_cfg{
		lv = 300,
		quality = 3,
		money = [{9,20000}],
		goods_list = [{70052,500},{70053,500}]
};

get(300,4) ->
	#upgrade_quality_cfg{
		lv = 300,
		quality = 4,
		money = [{9,40000}],
		goods_list = [{70053,500},{70054,500}]
};

get(300,5) ->
	#upgrade_quality_cfg{
		lv = 300,
		quality = 5,
		money = [{9,80000}],
		goods_list = [{70054,500},{70055,500}]
};

get(300,6) ->
	#upgrade_quality_cfg{
		lv = 300,
		quality = 6,
		money = [{9,160000}],
		goods_list = [{70055,500},{70056,500}]
};

get(_, _) ->
          null.

