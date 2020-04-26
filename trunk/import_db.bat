
::创建、初始化数据库
mysql -usimserver -p123456 < sql/create_game_db.sql
mysql -usimserver -p123456 < sql/db.sql

::调整auto_increment
mysql -usimserver -p123456 < sql/alter_auto_increment.sql



::执行所有的后期修改
::call sql/apply_all_alter.bat

::执行后台数据库所有的后期修改
::call sql/apply_all_bg_alter.bat

pause
