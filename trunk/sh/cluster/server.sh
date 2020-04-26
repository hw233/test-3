#!/bin/sh
cd ../../app_cfg
erl +P 1024000 +K true +Q 102400 -detached -pa ../ebin -name simserver@127.0.0.1 -setcookie uc_xproj -boot start_sasl                          -config server -s sm server_start

#windows bat:
#erl +P 1024000        +Q 102400           -pa ../ebin -name simserver@127.0.0.1 -setcookie uc_xproj -boot start_sasl -eval "debugger:start()" -config server -s sm server_start
