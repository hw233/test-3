#!/bin/sh
#Written by Skyman Wu
NODE=@127.0.0.1
cd ../ebin
erl -hidden -name sm_remsh$RANDOM$NODE -setcookie uc_xproj -remsh simserver$NODE
