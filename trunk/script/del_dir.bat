@echo on  
setlocal enabledelayedexpansion  
  
@REM ��������ɾ����Ŀ¼  
set WHAT_SHOULD_BE_DELETED=%1
  
for /r . %%a in (!WHAT_SHOULD_BE_DELETED!) do (  
  if exist %%a (  
  echo "ɾ��"%%a   
  rd /s /q "%%a"  
 )  
)