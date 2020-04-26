#!/bin/sh
NODE=@127.0.0.1
cd ../ebin

if [ $1 = "list" ]; then
        erl -pa ./ -noshell -name simhotup$NODE -setcookie uc_xproj -s sm_hotup hotup_list -extra simserver$NODE $2 $3
elif [ $1 = "exec" ]; then
        erl -pa ./ -noshell -name simhotup$NODE -setcookie uc_xproj -s sm_hotup hotup_exec -extra simserver$NODE $2
fi