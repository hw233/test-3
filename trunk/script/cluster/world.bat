cd ../../app_cfg
erl +P 1024000 -smp disable -pa ../ebin -name simworld@127.0.0.1 -setcookie tnzt -boot start_sasl -config world -s sm world_start
exit
