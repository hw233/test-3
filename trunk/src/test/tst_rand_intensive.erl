-module(tst_rand_intensive).
-compile(export_all).


-include("debug.hrl").


test(Times, Proba) ->
	RandSeed = mod_rand:make_seed(),
	?DEBUG_MSG("randseed:~p~n", [RandSeed]),
	random:seed(RandSeed),

	put(success_times, 0),
	put(fail_times, 0),
    test__(Times, Proba).


test2(Times, Proba) ->
	RandSeed = mod_rand:make_seed(),
	?DEBUG_MSG("randseed:~p~n", [RandSeed]),
	random:seed(RandSeed),

	put(success_times, 0),
	put(fail_times, 0),
    test2__(Times, Proba).




test__(0, _) ->
	?DEBUG_MSG("success:~p, fail:~p", [get(success_times), get(fail_times)]),
    done;
test__(Times, Proba) ->
	% RandNum = case BaseNum of
	% 	0 ->
	% 		random:uniform();
	% 	_ ->
	% 		random:uniform(BaseNum)
	% end,
	% io:format("~p~n", [RandNum]),

	Res = util:decide_proba_once(Proba),
	?DEBUG_MSG("~p", [Res]),


	case Res of
		success -> put(success_times, get(success_times) + 1);
		fail -> put(fail_times, get(fail_times) + 1)
	end,

	test__(Times -1, Proba).
    




test2__(0, _) ->
	?DEBUG_MSG("success:~p, fail:~p", [get(success_times), get(fail_times)]),
    done;
test2__(Times, Proba) ->
	
	Res = case random:uniform() =< Proba of
				true -> success;
				false -> fail
		  end,

	?DEBUG_MSG("~p", [Res]),


	case Res of
		success -> put(success_times, get(success_times) + 1);
		fail -> put(fail_times, get(fail_times) + 1)
	end,

	test2__(Times -1, Proba).