-module(data_partner_training).
-export([get_coin/1, get_training_position_limit/0, get_exp/2, expand_position_gold/0]).

get_exp(Time, Lv) ->
	case Lv < 20 of
		true ->
			0;
		_ ->
			X = util:floor((Lv - 20)/10) + 1,
			Result = 0.006 * math:pow(X, 4) + 1500 * math:pow(X, 3) + 1875 * math:pow(X, 2) - 9750 * X + 9750,
			util:floor(util:floor(Result / 1000) * 1000 / 60 * Time)
	end.
	

get_training_position_limit() ->
	10.

expand_position_gold() ->
	200.
	
get_coin([1,10]) ->
	{0, 0, 0};
	
get_coin([11,20]) ->
	{0, 0, 0};
	
get_coin([21,30]) ->
	{4500, 9000, 18000};
	
get_coin([31,40]) ->
	{6000, 12000, 24000};
	
get_coin([41,50]) ->
	{9000, 18000, 36000};
	
get_coin([51,60]) ->
	{12000, 24000, 48000};
	
get_coin([61,70]) ->
	{16500, 33000, 66000};
	
get_coin([71,80]) ->
	{22500, 45000, 90000};
	
get_coin([81,90]) ->
	{30000, 60000, 120000};
	
get_coin([91,100]) ->
	{45000, 90000, 180000};
	

get_coin(_) ->
	{0, 0, 0}.
