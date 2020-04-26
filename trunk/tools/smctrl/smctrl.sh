#!/bin/sh
. `dirname $0`/head.sh
echo ${DIR_SERVER}
#####################################

# 开启游戏节点
fun_start(){
        file=${DIR_SERVER}/sh/cluster/server_start.sh     
        cat > ${file} <<EOF
#!/bin/bash
ulimit -SHn  100000
cd ${DIR_SERVER}/app_cfg
echo ${DIR_SERVER}/app_cfg
${ERL} ${ERL_OPTION} -name ${NODE_NAME}@${DOMAIN} -setcookie ${COOKIE} -boot start_sasl -pa ../ebin -boot start_sasl -config server -s sm server_start    

EOF
 
        echo "正在启动节点 ${NODE_NAME}@${DOMAIN} ..."
		chmod +x ${file}
		echo "screen -dmS ${NODE_NAME}_svr -s ${file}"
		if [ "$is_real_run" = "1" ]; then
			screen -dmS ${NODE_NAME}_svr -s ${file}
			sleep ${DELAY}
		else 
			grep erl "${file}"
			echo -e "\n"
		fi 
		
}


# 关闭游戏节点
fun_stop() {
    if [ "${is_real_run}" = "1"  ]; then
        cd ${DIR_SERVER}/app_cfg
        
        ${ERL} -pa ../ebin -noshell -name ${NODE_NAME}_simstop@${DOMAIN} -setcookie ${COOKIE} -s sm_stop stop_cluster -extra ${NODE_NAME}@${DOMAIN}
        sleep ${DELAY}
    fi

# 不自动杀进程	
#    ps aux | grep beam |grep -v 'grep' | grep "${NODE_NAME}@" | awk '{print $2}' | while read pid
#        do
#            func_kill_pid $pid
#        done

}

func_kill_pid(){
        if [ "${is_real_run}" = "1" ] ; then
                kill -9 $1
        else 
                echo "kill -9 $1"
        fi

}


# 重启server
fun_restart(){
    fun_stop
    fun_start
}

# 持续热更
fun_keephot(){
    cd ${DIR_SERVER}/ebin
    if [ "$is_real_run" = "1" ]; then
        screen -dmS ${NODE_NAME}_keephot watch "${ERL} -name ${NODE_NAME}_keephot@${DOMAIN} -setcookie ${COOKIE} -eval \"case net_adm:ping('${NODE_NAME}@${DOMAIN}') of pang-> halt(1);_->ok end\" -eval \"sm_hu:h(),halt(1)\" "
    else
    	echo screen -dmS ${NODE_NAME}_keephot watch "${ERL} -name ${NODE_NAME}_keephot@${DOMAIN} -setcookie ${COOKIE} -eval \"case net_adm:ping('${NODE_NAME}@${DOMAIN}') of pang-> halt(1);_->ok end\" -eval \"sm_hu:h(),halt(1)\" " 
    fi   
}

# 停止持续热更
fun_stop_keephot(){
    ps aux | grep watch |grep -v 'grep' | grep -v 'SCREEN' | grep "${NODE_NAME}_keephot@" | awk '{print $2}' | while read pid
	do
	    func_kill_pid $pid
	done
}

#显示所有的screen 
fun_show_screen(){
    screen -ls
}


#用screen进入server界面
fun_into_server(){
    screen -x ${NODE_NAME}_svr
}

#用screen进入keephot界面
fun_into_keephot(){
    screen -x ${NODE_NAME}_keephot
}

####################################################################################
## 测试模式
if [ "${par1}" = "-t" ] || [ "$par2" = "-t" ] || [ "$par3" = "-t" ] ; then
        echo  -e "\n  ############### 测试模式，仅显示，不执行 ################# \n"
        is_real_run=0
fi

## 系统判断
if [ -z "$DOMAIN" ];then
        echo "域名未配置 " && exit 1
fi


case $par1 in
    start) fun_start;; 		     # 启动游戏节点
    stop) fun_stop;; 		     # 关闭游戏节点
    restart) fun_restart;; 	     # 重启server
    keephot) fun_keephot;;           # 持续热更（开发调试使用）
    stop_keephot) fun_stop_keephot;; # 停止持续热更
    show_screen) fun_show_screen;;   # 显示所有的screen
    into_server) fun_into_server;;   # 用screen进入server界面
    into_keephot) fun_into_keephot;; # 用screen进入keephot界面
    #make) fun_make;; 		     # 编译server
    *)
        echo "  start            #启动游戏节点"
        echo "  stop             #关闭游戏节点"
        echo "  restart          #重启server"
	echo "  keephot          #持续热更（开发调试使用）"
	echo "  stop_keephot     #停止持续热更"
 	echo "  show_screen      #显示所有的screen"
	echo "  into_server      #用screen进入server界面"
	echo "  into_keephot     #用screen进入keephot界面"
        echo "  最后的参数加 -t ，则启用测试模式.例如: sdctrl.sh start_all -t"
        exit 1
        ;;
esac

#wait # 等待脚本执行完成
echo "-------------------------------------------"
echo " ${par1} done"
echo "-------------------------------------------"
