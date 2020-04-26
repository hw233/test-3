#!/bin/sh

#发布目录
#PUBLISH_DIR="dbtest@10.16.139.194:9922/home/dbtest/publish"
PUBLISH_DIR="depot@115.28.180.15:6622/home/depot/xqs"

#gtools版本号
GTOOLS_VERSION="alpha-1.0.28"  # last used version: 590

gtools_name="pygtools-$GTOOLS_VERSION"
gtools_tar_gz="$gtools_name.tar.gz"

publish_port=`echo $PUBLISH_DIR|cut -d ":" -f2`
publish_port=`echo $publish_port|cut -d "/" -f1`
publish_host=`echo $PUBLISH_DIR|cut -d ":" -f1`
publish_path=`echo $PUBLISH_DIR|cut -d "/" -f 2-`
publish_dir=$publish_host:/$publish_path

if [ ! -f "tmp/$gtools_tar_gz" ]; then
        scp -P $publish_port $publish_dir/$gtools_tar_gz tmp/
fi

cd tmp
tar -zxvf $gtools_tar_gz
cd $gtools_name
cp -R gtools ../../../sh/db/
cd ..
rm -rf $gtools_name
cd ..


if [ $# \> 0 ] && [ $1 = "-beta" ]; then  # "$#"表示传给脚本的参数个数，"$1"表示传递给脚本的第一个参数
		echo "force beta!"
        python pack.py sm_game 1 $PUBLISH_DIR force_beta   # 强行打一个beta包
else
		python pack.py sm_game 1 $PUBLISH_DIR not_force_beta
fi


exit 0
