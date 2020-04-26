:: 并行编译，编译速度比较快

erl -pa ebin -eval "{M, S, _} = os:timestamp(),case make:files([\"./tools/mmake/make2.erl\"], [{outdir, \"ebin\"}]) of error -> halt(1); _ -> ok end, case make2:all(8) of up_to_date -> io:format(\"success~n\"), {M2, S2, _} = os:timestamp(),io:format(\"Spend time:~p second ~n\",[(M2 -M) * 1000000 + S2-S]),halt(0); error ->io:format(\"fail~n\"), halt(1) end."


pause