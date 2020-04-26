# #!/bin/sh
# #Written by huangjf
# CurDir=$(pwd)
# DstDir=$(cd $(dirname "${0}")/../../sql && pwd)
# cd ${CurDir}
# echo "开始导入配置表数据到数据库..."
# mysql -usmserver -p123456 < ${DstDir}/active_code/phone_ano.sql
# mysql -usmserver -p123456 < ${DstDir}/active_code/media_ano.sql
# echo  "导入激活码表数据成功"
