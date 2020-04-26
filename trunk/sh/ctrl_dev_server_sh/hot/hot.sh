#!/bin/sh
echo "hot begin"

# 执行前需要切换到ebin目录（不能-pa ebin哦）
cd /data/nvyao/server/smserver/ebin
# 改一下下面的 hot@127.0.0.1 节点名，防止冲突（cookie和对应的热更节点也要改）
erl -name hot@127.0.0.1 -setcookie uc_xproj -eval "case net_adm:ping('simserver@127.0.0.1') of pang-> halt(1);_->ok end" -eval "sm_hu:h(),halt(1)"

