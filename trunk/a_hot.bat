
:: 开着服务器的情况下双击改脚本可以热更修改过的erl文件（注意下面节点名和cookie的配置对应服务器）

:: 这个脚本很快，不过缺点是改了.hrl文件的话是编译不到的。

:: 改了头文件需要热更的话，把下面的sm_hu:h() 改成 sm_hu:hh()


cd ebin
erl -name hot@127.0.0.1 -setcookie uc_xproj -eval "case net_adm:ping('simserver@127.0.0.1') of pang-> halt(1);_->ok end" -eval "sm_hu:h(),halt(1)"

pause