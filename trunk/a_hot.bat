
:: ���ŷ������������˫���Ľű������ȸ��޸Ĺ���erl�ļ���ע������ڵ�����cookie�����ö�Ӧ��������

:: ����ű��ܿ죬����ȱ���Ǹ���.hrl�ļ��Ļ��Ǳ��벻���ġ�

:: ����ͷ�ļ���Ҫ�ȸ��Ļ����������sm_hu:h() �ĳ� sm_hu:hh()


cd ebin
erl -name hot@127.0.0.1 -setcookie uc_xproj -eval "case net_adm:ping('simserver@127.0.0.1') of pang-> halt(1);_->ok end" -eval "sm_hu:h(),halt(1)"

pause