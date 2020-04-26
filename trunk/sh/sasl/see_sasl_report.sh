#!/bin/sh
cd ../../app_cfg
erl -smp disable -hidden -pa ../ebin -name sm_sasl_report@127.0.0.1 -setcookie tnztjser -boot start_sasl -config log
