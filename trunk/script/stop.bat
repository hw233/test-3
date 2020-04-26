cd ../app_cfg
::erl -pa ../ebin -name sm_stop@127.0.0.1 -setcookie tnztflash -s sm_stop stop_cluster -extra sm_flash@127.0.0.1
::erl -pa ../ebin -name sm_stop@127.0.0.1 -setcookie tnzt -s sm_stop stop_cluster -extra sm_gateway@127.0.0.1 sm_server1@127.0.0.1 sm_world@127.0.0.1

erl -pa ../ebin -name simstop@127.0.0.1 -setcookie uc_xproj -s sm_stop stop_cluster -extra simserver@127.0.0.1

echo Í£Ö¹¼¯ÈºÍê±Ï
pause