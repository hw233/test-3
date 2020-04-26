#!/bin/sh



echo "this is do_ftp_upload.sh, pwd: $PWD"

echo "local path: $5"

# 导入ftp下载和上传函数
. ./sh_util/trans_helper.sh



# echo "this is do_ftp_upload.sh, pwd: $PWD"

# echo "local path: $5"

ftp_upload $1 $2 $3 $4 $5 $6 $7