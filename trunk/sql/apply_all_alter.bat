@echo off

echo ��ʼ���ݿ���޸�...

:��ȡ��ǰ·����Ŀ��·��
SET CurDir=%CD%
cd /d %~dp0\..\sql\alter
SET DstDir=%CD%

:���ص�ǰ·��
cd /d %CurDir%

FOR /f "tokens=* delims=" %%i in ('dir /a-d /b /o:n %DstDir%\*.sql') DO (
    echo �����ļ�'%DstDir%\%%i'...
    mysql -usimserver -p123456 < %DstDir%\%%i
)

echo ���ݿ��޸ĳɹ���

