
::��������ʼ�����ݿ�
mysql -usimserver -p123456 < sql/create_game_db.sql
mysql -usimserver -p123456 < sql/db.sql

::����auto_increment
mysql -usimserver -p123456 < sql/alter_auto_increment.sql



::ִ�����еĺ����޸�
::call sql/apply_all_alter.bat

::ִ�к�̨���ݿ����еĺ����޸�
::call sql/apply_all_bg_alter.bat

pause
