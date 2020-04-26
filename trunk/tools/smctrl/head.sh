##### 定义服务器编号, 启动线路和域名 #####
SERVER_NUM=1        # 服务器编号

### 下面三个域名仅需开启一个
DOMAIN="192.168.21.128"
CORE_DOMAIN=${DOMAIN}

##### 定义平台标识, 生成cookie和节点名前缀 #####
##COOKIE=s${SERVER_NUM}wmyQ5.WUta4wFGvHcm # erlang节点通讯cookie,仅第一服需要修改
# 因为代码中写死了节点名是simserver开头，所以LOGO必须以simserver开头
LOGO=simserver_
COOKIE_NUM=$SERVER_NUM	
if [ "$COOKIE_NUM" -gt 0 ] && [ "$COOKIE_NUM" -lt 10  ] ; then	
        COOKIE_NUM="00$SERVER_NUM"	
elif [ "$COOKIE_NUM" -gt 9 ] && [ "$COOKIE_NUM" -lt 100  ] ; then	
        COOKIE_NUM="0$SERVER_NUM"	
fi	
#COOKIE=${LOGO}s${COOKIE_NUM}JbA26js.YQuw98kzxyPro	
COOKIE=uc_xproj
NODE_NAME="${LOGO}s${COOKIE_NUM}"

##### 生成启动命令 #####
DIR_SERVER=`dirname $0`/../.. # server所在目录(该脚本放在sh/smctrl/下面)
#COMMON_PORT_START=9200
ERL=/usr/local/bin/erl  # erlang主程序所在目录
ERL_PORT_MIN=40001      # erl节点间通讯端口
ERL_PORT_MAX=40500      # erl节点间通讯端口
DELAY=3                 # 节点启动延时
ERL_OPTION=" -kernel inet_dist_listen_min ${ERL_PORT_MIN} -kernel inet_dist_listen_max ${ERL_PORT_MAX} +P 1024000 +K true +Q 102400 -smp disable"
ERL_OPTION_SMP=" -kernel inet_dist_listen_min ${ERL_PORT_MIN} -kernel inet_dist_listen_max ${ERL_PORT_MAX} +P 1024000 +K true +Q 102400 -smp enable"

################  系统参数
par1=$1
par2=$2
par3=$3

##是否是真实启动模式 1 是，其它否
is_real_run=1
####################
