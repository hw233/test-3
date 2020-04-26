#!/bin/sh
# @Author: weiyg
# @Date:   2014-12-02 11:50:50
# @Last Modified by:   weiyg
# @Last Modified time: 2014-12-02 14:21:35
# @Doc: FTP上传下载函数，跨文件调用先source 当前文件，相当于C语言的include

##set -x

MSG="MSG==>> "
ERROR="ERROR==>> "

## FTP上传
ftp_upload()
{
    HOST=$1             # IP
    PORT=$2             # 端口
    USER=$3             # 用户名
    PASS=$4             # 密码
    LOCAL_OATH=$5       # 本地目录（保存目录）
    REMOTE_PATH=$6      # 远程目录
    FILE=$7             # 上传的文件

    ## 以下内容不允许缩进，重定向内容
    ftp -p -v -n <<END
open $HOST $PORT
user $USER $PASS
binary
prompt
cd $REMOTE_PATH
lcd $LOCAL_OATH
put $FILE $FILE
close
bye
END
    ## 以上内容不允许缩进，重定向内容
    if [ $? -ne 0 ];then
        echo $ERROR'upload from ftp fail'
        exit 122
    fi
}

## FTP下载
ftp_download()
{
    HOST=$1             # IP
    PORT=$2             # 端口
    USER=$3             # 用户名
    PASS=$4             # 密码
    LOCAL_OATH=$5       # 本地目录（保存目录）
    REMOTE_PATH=$6      # 远程目录
    FILE=$7             # 下载文件

    ## 以下内容不允许缩进，重定向内容
    ftp -p -v -n <<END
open $HOST $PORT
user $USER $PASS
binary
prompt
cd $REMOTE_PATH
lcd $LOCAL_OATH
get $FILE $FILE
close
bye
END
    ## 以上内容不允许缩进，重定向内容
    if [ $? -ne 0 ];then
        echo $ERROR'download from ftp fail'
        exit 123
    fi
    if [ ! -f "$LOCAL_OATH/$FILE" ];then
        echo $ERROR'file by download is not exist---- '$LOCAL_OATH/$FILE
        exit 101
    fi
}

# 测试
# ftp_upload 10.1.42.16 22 stest dbstest test/ x2_server/ start.sh
# ftp_download 10.1.42.16 22 stest dbstest test/ x2_server/ start.sh