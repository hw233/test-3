#!/bin/sh
cd ../../app_cfg
erl +P 1024000 +K true -smp disable -detached -pa ../ebin -name sm_flash@127.0.0.1 -setcookie tnztjflashser -boot start_sasl -config log -s sm flash_start -extra 843
