cd ../../app_cfg
erl +P 1024000 -smp disable -pa ../ebin -name sm_gateway@127.0.0.1 -setcookie uc_xproj -boot start_sasl -config gateway -s sm gateway_start
exit