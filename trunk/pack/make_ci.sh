#!/bin/sh
# by huangjf
# 用于内部开发持续集成的编译， ci表示持续集成

cd ..

makefile_prefix="Emakefile"
makefile_suffix="_d"

if [ $# \> 0 ] && [ $1 = "-r" ]; then
        makefile_suffix="_r"
fi

cp $makefile_prefix$makefile_suffix $makefile_prefix

echo "start make..."

# 在ssh子shell里启动erlang节点，会显示“*** Terminating erlang”，然后节点退出。解决方法是启动时加上-noshell标记，官方文档的说明：
# -noshell
# Starts an Erlang runtime system with no shell. This flag makes it possible to have the Erlang runtime system as a component in a series of UNIX pipes.
erl -noshell -pa ebin -eval "case make:files([\"./tools/mmake/mmake.erl\"], [{outdir, \"ebin\"}]) of error -> halt(1); _ -> ok end" -eval "case mmake:all(1) of up_to_date -> halt(0); error -> halt(1) end."


rm $makefile_prefix
cp Emakefile_d Emakefile

sleep 4
echo "make done"
