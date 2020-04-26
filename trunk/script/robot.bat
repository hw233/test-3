cd ../app_cfg
erl -pa ../ebin  +P 1024000 -smp disable -env ERL_MAX_PORTS 4096
pause