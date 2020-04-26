cd ../../app_cfg
erl +P 1024000 +Q 102400 -pa ../ebin -name simserv21212er@127.0.0.1 -setcookie uc_xproj  -eval "debugger:start()" -config server -s sm server_start

