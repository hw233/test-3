cd ../../app_cfg
erl +P 1024000 -smp disable -hidden -pa ../ebin -name sm_logger@127.0.0.1 -setcookie uc_xproj -boot start_sasl -config log -s sm logger_start
exit