#!/bin/sh
SERVER=simserver
NODE=@127.0.0.1
LINE_NUM=20
INTERV=2
ACCU=false
TRACE=off

if [ "$1" = "-h" ]; then
    echo "etop.sh [runtime|memory|reductions|msg_q]"
    exit
fi

if [ -z "$1" ]; then
    SORT="runtime"
else
    SORT=$1
fi
erl -hidden -name etop$RANDOM$NODE -setcookie uc_xproj -s etop -s erlang halt -output text -lines $LINE_NUM -sort $SORT -interval $INTERV -accumulate $ACCU -tracing $TRACE -node $SERVER$NODE
