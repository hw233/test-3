#!/bin/sh
ulimit -SHn 102400
ERL_MAX_PORTS=32000
export ERL_MAX_PORTS

cd flash
echo "starting flash server..."
sh ./flash.sh
echo "start flash server success!"
