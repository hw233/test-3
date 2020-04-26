#!/bin/sh
# Written by Skyman Wu

#echo "开始更新SVN..."
cd ..

makefile_prefix="Emakefile"
makefile_suffix="_d"

if [ $# \> 0 ] && [ $1 = "-r" ]; then
        makefile_suffix="_r"
fi

cp $makefile_prefix$makefile_suffix $makefile_prefix

echo "开始编译代码..."
echo "是否增量编译？（输入y表示增量编译；输入n表示重新编译）："
read Y_OR_N

if [ "$Y_OR_N" = "y" ] || [ "$Y_OR_N" = "Y" ]; then
        echo "开始增量编译..."
		erl -pa ebin -eval "case make:files([\"./tools/mmake/mmake.erl\"], [{outdir, \"ebin\"}]) of error -> halt(1); _ -> ok end" -eval "case mmake:all(8) of up_to_date -> halt(0); error -> halt(1) end."

else
        echo "开始重新编译..."
        rm -f ./ebin/*.beam
        erl -pa ebin -eval "case make:files([\"./tools/mmake/mmake.erl\"], [{outdir, \"ebin\"}]) of error -> halt(1); _ -> ok end" -eval "case mmake:all(8) of up_to_date -> halt(0); error -> halt(1) end."

fi

rm $makefile_prefix
cp Emakefile_d Emakefile

echo "编译代码完毕！"
#sh sh/write_svn_ver.sh
