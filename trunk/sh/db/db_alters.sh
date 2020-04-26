#!/bin/sh
#Written by skyman

echo "开始数据库的修改..."

# 获取当前路径和目标路径
CurDir=$(pwd)
DstDir=$(cd $(dirname "${0}")/../../sql/alter && pwd)

# 返回当前路径
cd ${CurDir}

Files=$(ls -l ${DstDir} | awk '/^-.*\.sql/{print $NF}' | sort -n | awk '{printf "%s ", $1}')
[[ -z ${Files} ]] && echo "未找到文件，请检查文件是否已经上传！" && exit 1

for File in ${Files}
do
  echo "导入文件'${DstDir}/${File}'..."
  mysql -usmserver -p123456 < ${DstDir}/${File}
  (( "${?}" != 0 )) && echo "数据库修改失败，请检查相关文件！" && exit 1
done

echo  "数据库修改成功。"
