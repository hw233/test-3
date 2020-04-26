cd ../../app_cfg
erl +P 1024000 -smp disable -pa ../ebin -name sm_flash@127.0.0.1 -setcookie tnztflash -boot start_sasl -config log -s sm flash_start -extra 843
exit