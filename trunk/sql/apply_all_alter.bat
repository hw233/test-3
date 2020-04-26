@echo off

echo 开始数据库的修改...

:获取当前路径和目标路径
SET CurDir=%CD%
cd /d %~dp0\..\sql\alter
SET DstDir=%CD%

:返回当前路径
cd /d %CurDir%

FOR /f "tokens=* delims=" %%i in ('dir /a-d /b /o:n %DstDir%\*.sql') DO (
    echo 导入文件'%DstDir%\%%i'...
    mysql -usimserver -p123456 < %DstDir%\%%i
)

echo 数据库修改成功。

