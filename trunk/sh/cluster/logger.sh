#!/bin/sh
cd ../../app_cfg
erl +P 1024000 +K true -smp disable -hidden -detached -pa ../ebin -name sm_logger@127.0.0.1 -setcookie uc_xproj -boot start_sasl -config log -s sm logger_start


#windows bat:
#erl +P 1024000        -smp disable -hidden           -pa ../ebin -name sm_logger@127.0.0.1 -setcookie uc_xproj -boot start_sasl -config log -s sm logger_start

