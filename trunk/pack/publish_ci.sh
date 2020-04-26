#!/bin/sh

# 调用方式：
# sh publish_ci.sh  alpha(包名前缀)  包版本号(如 222-333)  配置数据版本(对应‘freeala.com/svn/X1-Docs/打包数据/1.7.x’的1.7.x)  ftp/scp
# 如：sh publish_ci.sh  alpha  222-333  1.7.1 ftp

# 打包服务器最终拉下来的svn文件结构如下：
# smserver 
# cfg_data
# 	-- 1.5.x
#          -- include
#          -- data
# 	-- 1.6.x
#          -- include
#          -- data 




# 导入ftp下载和上传函数
. ./sh_util/trans_helper.sh

####################################################

# game info
GAME_ALIAS="sm_game"
GAME_GENERATION=1   # 主版本号目前固定为1

# FTP host info
#FTP_HOST="v0.ftp.upyun.com"
#FTP_PORT=21
#FTP_USER="hcxq/fortemp"
#FTP_PASSWORD="hcxqhcxqhcxq"
#FTP_PATH="xqs/"
FTP_HOST="ftperl.jinkehc.com"
FTP_PORT=21
FTP_USER="ftperl"
FTP_PASSWORD="TcCYy7t2SjwHvXoJkk5brZe2adhMcKyI"
FTP_PATH="."

# gtools版本号
GTOOLS_VERSION="alpha-1.0.28"  # "alpha-1.0.638"

# smserver的路径
SMSERVER_DIR=`echo $PWD/..`
echo "SMSERVER_DIR: $SMSERVER_DIR"

####################################################


gtools_name="pygtools-$GTOOLS_VERSION"
gtools_tar_gz="$gtools_name.tar.gz"

# 从ftp下载gtools压缩包到tmp目录
if [ ! -f "tmp/$gtools_tar_gz" ]; then
        echo "download gtools..."
        ftp_download $FTP_HOST $FTP_PORT $FTP_USER $FTP_PASSWORD ./tmp/ $FTP_PATH $gtools_tar_gz
        echo "download done"
fi
 
# 解压并拷贝gtools到smserver的sh/db目录
cd tmp
tar -zxvf $gtools_tar_gz
cd $gtools_name

mkdir $SMSERVER_DIR/sh/db/gtools
cp -R gtools/* $SMSERVER_DIR/sh/db/gtools/

cd ..
rm -rf $gtools_name
cd ..




version_ident=$1   # 版本标识： alpha | beta
svn_revision_1=`echo $2|cut -d "-" -f1`
svn_revision_2=`echo $2|cut -d "-" -f2`
svn_revision_info="$svn_revision_1$svn_revision_2"
cfg_data_version=$3
is_release=$5

if [ "$version_ident" != "alpha" ] && [ "$version_ident" != "beta" ]; then
	echo "unknown version ident: $version_ident"
	exit 1
fi

echo "version_ident: $version_ident"
echo "svn_revision_1: $svn_revision_1"
echo "svn_revision_2: $svn_revision_2"
echo "svn_revision_info: $svn_revision_info"
echo "cfg_data_version: $cfg_data_version"


# # 同步配置数据
# echo "copy cfg data to smserver..."
# ## rm -rf $SMSERVER_DIR/src/data/         # 删除旧数据文件（不需删除，故注释掉）
# cp -R $SMSERVER_DIR/../cfg_data/$cfg_data_version/data/*  $SMSERVER_DIR/src/data/
# cp -R $SMSERVER_DIR/../cfg_data/$cfg_data_version/include/*  $SMSERVER_DIR/include/
# echo "copy cfg data to smserver done"

if [ "$is_release" != "release" ]; then
    # 同步配置数据
    echo "copy cfg data to smserver..."
    ## rm -rf $SMSERVER_DIR/src/data/         # 删除旧数据文件（不需删除，故注释掉）
    cp -R $SMSERVER_DIR/../cfg_data/$cfg_data_version/data/*  $SMSERVER_DIR/src/data/
    cp -R $SMSERVER_DIR/../cfg_data/$cfg_data_version/include/*  $SMSERVER_DIR/include/
    echo "copy cfg data to smserver done"
else
    echo "publish for release"
fi


# 打包并上传
python publish_ci.py $version_ident $svn_revision_info $cfg_data_version $SMSERVER_DIR $GAME_ALIAS $GAME_GENERATION $FTP_HOST $FTP_PORT $FTP_USER $FTP_PASSWORD $FTP_PATH



exit 0
