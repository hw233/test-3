#!/bin/sh

#发布目录
#PUBLISH_DIR="dbtest@10.16.139.194:9922/home/dbtest/publish"
PUBLISH_DIR="depot@115.28.180.15:6622/home/depot/xqs"

#gtools版本号
GTOOLS_VERSION="alpha-1.0.28"

install_erl()
{
        sudo apt-get install libncurses-dev
        sudo apt-get install libssl-dev
        sudo apt-get install unixODBC unixODBC-dev

        wget http://www.erlang.org/download/otp_src_R16B03-1.tar.gz
        tar -zxvf otp_src_R16B03-1.tar.gz
        cd otp_src_R16B03-1
        ./configure
        make
        sudo make install
        cd ..
        rm -rf otp_src_R16B03-1
        rm otp_src_R16B03-1.tar.gz
}

install_gtools()
{
        gtools_name="pygtools-$GTOOLS_VERSION"
        gtools_tar_gz="$gtools_name.tar.gz"

        publish_port=`echo $PUBLISH_DIR|cut -d ":" -f2`
        publish_port=`echo $publish_port|cut -d "/" -f1`
        publish_host=`echo $PUBLISH_DIR|cut -d ":" -f1`
        publish_path=`echo $PUBLISH_DIR|cut -d "/" -f 2-`
        publish_dir=$publish_host:/$publish_path

        scp -P $publish_port $publish_dir/$gtools_tar_gz ./
        tar -zxvf $gtools_tar_gz
        cd $gtools_name
        sudo python setup.py install
        cd ..
        rm -rf $gtools_name
        rm -rf $gtools_tar_gz
}

if [ $# = 0 ]; then
        install_erl
else
        if [ $1 = "-r" ]; then
                install_erl
        elif [ $1 = "-d" ]; then
                install_erl
                install_gtools
        elif [ $1 = "-du" ] ; then
                install_gtools
        fi
fi