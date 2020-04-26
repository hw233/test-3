#!/bin/sh
NODE=@127.0.0.1
cd ../app_cfg
erl -pa ../ebin -name sm_stop$NODE -setcookie tnztjflashser -s sm_stop stop_cluster -extra sm_flash$NODE
echo "stop flash server success!"
