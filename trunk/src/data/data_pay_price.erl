%%%-------------------------------------- 
%%% @Module: data_pay_price
%%% @Author: 
%%% @Created: 
%%% @Description: 
%%%-------------------------------------- 
-module(data_pay_price).
-export([
		     get_price/1
		  ]).



%% %% desc: 获取物品价格
%% %% {money_gold, original_rmb, money_rmb, money_special}
%%  get_price(100102001) -> [{o_gold, 100000}, {gold, 100}];       
%% 商城物品
get_price(110100001) -> [{o_gold, 20 }, {gold, 8  }];
get_price(110100002) -> [{o_gold, 100}, {gold, 48 }];
get_price(110100003) -> [{o_gold, 200}, {gold, 98 }];
get_price(110200002) -> [{o_gold, 150}, {gold, 20 }];
get_price(110200003) -> [{o_gold, 150}, {gold, 20 }];
get_price(120100001) -> [{o_gold, 50 }, {gold, 10 }];
get_price(120100002) -> [{o_gold, 100}, {gold, 48 }];
get_price(120100003) -> [{o_gold, 200}, {gold, 98 }];
get_price(120100004) -> [{o_gold, 10 }, {gold, 3  }];
get_price(120100005) -> [{o_gold, 20 }, {gold, 8  }];
get_price(120200001) -> [{o_gold, 200}, {gold, 48 }];
get_price(120300001) -> [{o_gold, 200}, {gold, 48 }];
%% NPC 道具商人
get_price(200100001) -> [{coin, 30}]; 
get_price(200100002) -> [{coin, 50}]; 
get_price(200100003) -> [{coin, 80}]; 
%% NPC 装备商人
get_price(100102001) -> [{coin, 100 }];
get_price(100104001) -> [{coin, 100 }];
get_price(100105001) -> [{coin, 100 }];
get_price(100108001) -> [{coin, 100 }];
get_price(100200001) -> [{coin, 150 }];
get_price(100300001) -> [{coin, 150 }];
get_price(100400001) -> [{coin, 150 }];
get_price(100500001) -> [{coin, 150 }];
get_price(100102002) -> [{coin, 300 }];
get_price(100104002) -> [{coin, 300 }];
get_price(100105002) -> [{coin, 300 }];
get_price(100108002) -> [{coin, 200 }];
get_price(100200002) -> [{coin, 250 }];
get_price(100300002) -> [{coin, 250 }];
get_price(100400002) -> [{coin, 250 }];
get_price(100500002) -> [{coin, 250 }];
get_price(100102003) -> [{coin, 1000}];
get_price(100104003) -> [{coin, 1000}];
get_price(100105003) -> [{coin, 1000}];
get_price(100108003) -> [{coin, 1000}];
get_price(100200003) -> [{coin, 1100}];
get_price(100300003) -> [{coin, 1100}];
get_price(100400003) -> [{coin, 1100}];
get_price(100500003) -> [{coin, 1100}];
 


get_price(100102004) -> [{coin,	5000 }];
get_price(100102005) -> [{coin,	10000}];
get_price(100102006) -> [{coin,	20000}];
get_price(100102007) -> [{coin,	50000}];
get_price(100104004) -> [{coin,	5000 }];
get_price(100104005) -> [{coin,	10000}];
get_price(100104006) -> [{coin,	20000}];
get_price(100104007) -> [{coin,	50000}];
get_price(100105004) -> [{coin,	5000 }];
get_price(100105005) -> [{coin,	10000}];
get_price(100105006) -> [{coin,	20000}];
get_price(100105007) -> [{coin,	50000}];
get_price(100108004) -> [{coin,	3000 }];
get_price(100108005) -> [{coin,	8000 }];
get_price(100108006) -> [{coin,	12000}];
get_price(100108007) -> [{coin,	18000}];
get_price(100200004) -> [{coin,	3200 }];
get_price(100200005) -> [{coin,	8400 }];
get_price(100200006) -> [{coin,	12500}];
get_price(100200007) -> [{coin,	19000}];
get_price(100300004) -> [{coin,	3200 }];
get_price(100300005) -> [{coin,	8400 }];
get_price(100300006) -> [{coin,	12500}];
get_price(100300007) -> [{coin,	19000}];
get_price(100400004) -> [{coin,	3200 }];
get_price(100400005) -> [{coin,	8400 }];
get_price(100400006) -> [{coin,	12500}];
get_price(100400007) -> [{coin,	19000}];
get_price(100500004) -> [{coin,	3200 }];
get_price(100500005) -> [{coin,	8400 }];
get_price(100500006) -> [{coin,	12500}];
get_price(100500007) -> [{coin,	19000}];

get_price(110301001) -> [{gold, 10  }, {o_gold, 10000}];
get_price(110301002) -> [{gold, 25  }, {o_gold, 10000}];
get_price(110301003) -> [{gold, 50  }, {o_gold, 10000}];
get_price(110303001) -> [{gold, 10  }, {o_gold, 10000}];
get_price(110303002) -> [{gold, 25  }, {o_gold, 10000}];
get_price(110303003) -> [{gold, 50  }, {o_gold, 10000}];
get_price(110304001) -> [{gold, 10  }, {o_gold, 10000}];
get_price(110304002) -> [{gold, 25  }, {o_gold, 10000}];
get_price(110304003) -> [{gold, 50  }, {o_gold, 10000}];
get_price(110305001) -> [{gold, 10  }, {o_gold, 10000}];
get_price(110305002) -> [{gold, 25  }, {o_gold, 10000}];
get_price(110305003) -> [{gold, 50  }, {o_gold, 10000}];
get_price(110306001) -> [{gold, 10  }, {o_gold, 10000}];
get_price(110306002) -> [{gold, 25  }, {o_gold, 10000}];
get_price(110306003) -> [{gold, 50  }, {o_gold, 10000}];
get_price(110307001) -> [{gold, 10  }, {o_gold, 10000}];
get_price(110307002) -> [{gold, 25  }, {o_gold, 10000}];
get_price(110307003) -> [{gold, 50  }, {o_gold, 10000}];
get_price(110308001) -> [{gold, 10  }, {o_gold, 10000}];
get_price(110308002) -> [{gold, 25  }, {o_gold, 10000}];
get_price(110308003) -> [{gold, 50  }, {o_gold, 10000}];
get_price(110309001) -> [{gold, 10  }, {o_gold, 10000}];
get_price(110309002) -> [{gold, 25  }, {o_gold, 10000}];
get_price(110309003) -> [{gold, 50  }, {o_gold, 10000}];
get_price(110310001) -> [{gold, 10  }, {o_gold, 10000}];
get_price(110310002) -> [{gold, 25  }, {o_gold, 10000}];
get_price(110310003) -> [{gold, 50  }, {o_gold, 10000}];
get_price(110311001) -> [{gold, 10  }, {o_gold, 10000}];
get_price(110311002) -> [{gold, 25  }, {o_gold, 10000}];
get_price(110311003) -> [{gold, 50  }, {o_gold, 10000}];
get_price(130100001) -> [{gold, 15  }, {o_gold, 10000}];
get_price(130100002) -> [{gold, 20  }, {o_gold, 10000}];
get_price(130100003) -> [{gold, 60  }, {o_gold, 10000}];
get_price(130200001) -> [{gold, 15  }, {o_gold, 10000}];
get_price(130200002) -> [{gold, 20  }, {o_gold, 10000}];
get_price(130200003) -> [{gold, 60  }, {o_gold, 10000}];
get_price(130300001) -> [{gold, 20  }, {o_gold, 10000}];
get_price(130300002) -> [{gold, 40  }, {o_gold, 10000}];
get_price(130300003) -> [{gold, 80  }, {o_gold, 10000}];
get_price(130400001) -> [{gold, 20  }, {o_gold, 10000}];
get_price(130400002) -> [{gold, 40  }, {o_gold, 10000}];
get_price(130400003) -> [{gold, 80  }, {o_gold, 10000}];
get_price(600100001) -> [{gold, 30  }, {o_gold, 10000}];
get_price(600200001) -> [{gold, 1   }, {o_gold, 10000}];
get_price(600200002) -> [{gold, 1   }, {o_gold, 10000}];
get_price(600200003) -> [{gold, 1   }, {o_gold, 10000}];
get_price(600200004) -> [{gold, 1   }, {o_gold, 10000}];

get_price(100102012) -> [{bcoin, 1000}];
get_price(100102013) -> [{bcoin, 1000}];
get_price(100102014) -> [{bcoin, 1000}];
get_price(100102018) -> [{bcoin, 1000}];
get_price(100102019) -> [{bcoin, 1000}];
get_price(100102020) -> [{bcoin, 1000}];
get_price(100102021) -> [{bcoin, 1000}];
get_price(100104011) -> [{bcoin, 1000}];
get_price(100104012) -> [{bcoin, 1000}];
get_price(100104013) -> [{bcoin, 1000}];
get_price(100104014) -> [{bcoin, 1000}];
get_price(100104018) -> [{bcoin, 1000}];
get_price(100104019) -> [{bcoin, 1000}];
get_price(100104020) -> [{bcoin, 1000}];
get_price(100104021) -> [{bcoin, 1000}];
get_price(100105011) -> [{bcoin, 1000}];
get_price(100105012) -> [{bcoin, 1000}];
get_price(100105013) -> [{bcoin, 1000}];
get_price(100105014) -> [{bcoin, 1000}];
get_price(100105018) -> [{bcoin, 1000}];
get_price(100105019) -> [{bcoin, 1000}];
get_price(100105020) -> [{bcoin, 1000}];
get_price(100105021) -> [{bcoin, 1000}];
get_price(100108011) -> [{bcoin, 1000}];
get_price(100108012) -> [{bcoin, 1000}];
get_price(100108013) -> [{bcoin, 1000}];
get_price(100108014) -> [{bcoin, 1000}];
get_price(100108018) -> [{bcoin, 1000}];
get_price(100108019) -> [{bcoin, 1000}];
get_price(100108020) -> [{bcoin, 1000}];
get_price(100108021) -> [{bcoin, 1000}];
get_price(100200011) -> [{bcoin, 1000}];
get_price(100200012) -> [{bcoin, 1000}];
get_price(100200013) -> [{bcoin, 1000}];
get_price(100200014) -> [{bcoin, 1000}];
get_price(100200018) -> [{bcoin, 1000}];
get_price(100200019) -> [{bcoin, 1000}];
get_price(100200020) -> [{bcoin, 1000}];
get_price(100200021) -> [{bcoin, 1000}];
get_price(100200025) -> [{bcoin, 1000}];
get_price(100200026) -> [{bcoin, 1000}];
get_price(100200027) -> [{bcoin, 1000}];
get_price(100200028) -> [{bcoin, 1000}];
get_price(100300011) -> [{bcoin, 1000}];
get_price(100300012) -> [{bcoin, 1000}];
get_price(100300013) -> [{bcoin, 1000}];
get_price(100300014) -> [{bcoin, 1000}];
get_price(100300018) -> [{bcoin, 1000}];
get_price(100300019) -> [{bcoin, 1000}];
get_price(100300020) -> [{bcoin, 1000}];
get_price(100300021) -> [{bcoin, 1000}];
get_price(100300025) -> [{bcoin, 1000}];
get_price(100300026) -> [{bcoin, 1000}];
get_price(100300027) -> [{bcoin, 1000}];
get_price(100300028) -> [{bcoin, 1000}];
get_price(100400011) -> [{bcoin, 1000}];
get_price(100400012) -> [{bcoin, 1000}];
get_price(100400013) -> [{bcoin, 1000}];
get_price(100400014) -> [{bcoin, 1000}];
get_price(100400018) -> [{bcoin, 1000}];
get_price(100400019) -> [{bcoin, 1000}];
get_price(100400020) -> [{bcoin, 1000}];
get_price(100400021) -> [{bcoin, 1000}];
get_price(100400025) -> [{bcoin, 1000}];
get_price(100400026) -> [{bcoin, 1000}];
get_price(100400027) -> [{bcoin, 1000}];
get_price(100400028) -> [{bcoin, 1000}];
get_price(100500011) -> [{bcoin, 1000}];
get_price(100500012) -> [{bcoin, 1000}];
get_price(100500013) -> [{bcoin, 1000}];
get_price(100500014) -> [{bcoin, 1000}];
get_price(100500018) -> [{bcoin, 1000}];
get_price(100500019) -> [{bcoin, 1000}];
get_price(100500020) -> [{bcoin, 1000}];
get_price(100500021) -> [{bcoin, 1000}];
get_price(100500025) -> [{bcoin, 1000}];
get_price(100500026) -> [{bcoin, 1000}];
get_price(100500027) -> [{bcoin, 1000}];
get_price(100500028) -> [{bcoin, 1000}];
get_price(100600001) -> [{bcoin, 1000}];
get_price(100600002) -> [{bcoin, 1000}];
get_price(100600003) -> [{bcoin, 1000}];
get_price(100600004) -> [{bcoin, 1000}];
get_price(100600005) -> [{bcoin, 1000}];
get_price(100600006) -> [{bcoin, 1000}];
get_price(100600007) -> [{bcoin, 1000}];
get_price(100600011) -> [{bcoin, 1000}];
get_price(100600012) -> [{bcoin, 1000}];
get_price(100600013) -> [{bcoin, 1000}];
get_price(100600014) -> [{bcoin, 1000}];
get_price(100600018) -> [{bcoin, 1000}];
get_price(100600019) -> [{bcoin, 1000}];
get_price(100600020) -> [{bcoin, 1000}];
get_price(100600021) -> [{bcoin, 1000}];
get_price(100700001) -> [{bcoin, 1000}];
get_price(100700002) -> [{bcoin, 1000}];
get_price(100700003) -> [{bcoin, 1000}];
get_price(100700004) -> [{bcoin, 1000}];
get_price(100700005) -> [{bcoin, 1000}];
get_price(100700006) -> [{bcoin, 1000}];
get_price(100700007) -> [{bcoin, 1000}];
get_price(100700011) -> [{bcoin, 1000}];
get_price(100700012) -> [{bcoin, 1000}];
get_price(100700013) -> [{bcoin, 1000}];
get_price(100700014) -> [{bcoin, 1000}];
get_price(100700018) -> [{bcoin, 1000}];
get_price(100700019) -> [{bcoin, 1000}];
get_price(100700020) -> [{bcoin, 1000}];
get_price(100700021) -> [{bcoin, 1000}];
get_price(100800001) -> [{bcoin, 1000}];
get_price(100800002) -> [{bcoin, 1000}];
get_price(100800003) -> [{bcoin, 1000}];
get_price(100800004) -> [{bcoin, 1000}];
get_price(100800005) -> [{bcoin, 1000}];
get_price(100800006) -> [{bcoin, 1000}];
get_price(100800007) -> [{bcoin, 1000}];
get_price(100800011) -> [{bcoin, 1000}];
get_price(100800012) -> [{bcoin, 1000}];
get_price(100800013) -> [{bcoin, 1000}];
get_price(100800014) -> [{bcoin, 1000}];
get_price(100800018) -> [{bcoin, 1000}];
get_price(100800019) -> [{bcoin, 1000}];
get_price(100800020) -> [{bcoin, 1000}];
get_price(100800021) -> [{bcoin, 1000}];
get_price(100800025) -> [{bcoin, 1000}];
get_price(100800026) -> [{bcoin, 1000}];
get_price(100800027) -> [{bcoin, 1000}];
get_price(100800028) -> [{bcoin, 1000}];
get_price(100800029) -> [{bcoin, 1000}];
get_price(100800030) -> [{bcoin, 1000}];
get_price(100800031) -> [{bcoin, 1000}];
get_price(100800035) -> [{bcoin, 1000}];
get_price(100800036) -> [{bcoin, 1000}];
get_price(100800037) -> [{bcoin, 1000}];
get_price(100800038) -> [{bcoin, 1000}];
get_price(100800042) -> [{bcoin, 1000}];
get_price(100800043) -> [{bcoin, 1000}];
get_price(100800044) -> [{bcoin, 1000}];
get_price(100800045) -> [{bcoin, 1000}];
get_price(140200001) -> [{bcoin, 1000}];
get_price(140200002) -> [{bcoin, 1000}];
get_price(140200003) -> [{bcoin, 1000}];
get_price(140200004) -> [{bcoin, 1000}];
get_price(140200005) -> [{bcoin, 1000}];
get_price(140200006) -> [{bcoin, 1000}];
get_price(140200007) -> [{bcoin, 1000}];



get_price(100102011) -> [{gold, 1000}];

get_price(_) -> [{o_gold,999999}, {gold, 999999}].














		