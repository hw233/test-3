#!/bin/sh
cd ../../app_cfg
erl +P 1024000 +K true -smp disable -detached -pa ../ebin -name simworld@127.0.0.1 -setcookie tnztjser -boot start_sasl -config world -s sm world_start
