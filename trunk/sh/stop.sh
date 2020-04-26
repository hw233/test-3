#!/bin/sh
NODE=@127.0.0.1
cd ../app_cfg
erl -pa ../ebin -noshell -name simstop$NODE -setcookie uc_xproj -s sm_stop stop_cluster -extra simserver$NODE

##echo "stop game server done!"
