-module(tst_inventory).

-export([add/0, get/0]).

-include("inventory.hrl").
-include("record/goods_record.hrl").
-include("record.hrl").
-include("ets_name.hrl").



	


make_new_goods_list() ->	
	L = lists:seq(1, 70),
	F = fun(Id) ->
			#goods{
				no = Id,
				id = Id,

				base_equip_add = #attrs{phy_att = 100},
				equip_prop = #equip_prop{stren_lv = 2},

				extra = [{key_a, 1}, {key_b, 2}, {key_c, 3}]
			}
	end,
	L2 = [F(X) || X <- L],
	io:format("L2 len: ~p~n", [length(L2)]),
	

	L. % L2
	


add() ->
	NewGoodsList = make_new_goods_list(),

	NewInv1 = #inv{
				player_id = 1,

				eq_goods = NewGoodsList,

				storage_goods = NewGoodsList,

				player_eq_goods = [],

				partner_eq_goods = NewGoodsList

				},

	NewInv2 = #inv{
				player_id = 2,

				eq_goods = NewGoodsList,

				storage_goods = NewGoodsList,

				player_eq_goods = [],

				partner_eq_goods = NewGoodsList

				},

	ets:insert(?ETS_INVENTORY, NewInv1),
	ets:insert(?ETS_INVENTORY, NewInv2).
	



get() ->
	L = lists:seq(1, 10000),

	F2 = fun() ->
			F = fun(SeqNum) ->
					PlayerId1 = 1,
					[Inv1] = ets:lookup(?ETS_INVENTORY, PlayerId1),

					Inv1_New = Inv1#inv{bag_eq_capacity = SeqNum, storage_capacity = SeqNum},

					ets:insert(?ETS_INVENTORY, Inv1_New),

					Inv1

					% PlayerId2 = 2,
					% [Inv2] = ets:lookup(?ETS_INVENTORY, PlayerId2),

					% Inv2
			end,

			lists:foreach(F, L)
		end,

	tst_prof:run(F2, 1).
