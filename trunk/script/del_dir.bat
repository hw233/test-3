@echo on  
setlocal enabledelayedexpansion  
  
@REM 设置你想删除的目录  
set WHAT_SHOULD_BE_DELETED=%1
  
for /r . %%a in (!WHAT_SHOULD_BE_DELETED!) do (  
  if exist %%a (  
  echo "删除"%%a   
  rd /s /q "%%a"  
 )  
)