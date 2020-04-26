# -*- coding: utf8 -*-

import os

import third.pack_flow as pack_flow
import third.file_util as file_util
import third.str_util  as str_util

class Pack(pack_flow.CPackFlow):
        def work(self, tmp_dir, ident):
                os.system("mkdir %s/ebin" % (tmp_dir,))

                #清理beam文件
                os.system("rm ebin/*.beam")

                #make
                os.chdir("sh")
                if ident == "alpha":
                        ret = os.system("sh up_mk.sh") >> 8
                else:
                        ret = os.system("sh up_mk.sh -r") >> 8
                os.chdir("..")

                if ret == 1:
                        print "make fail."

                        os.system("rm -rf %s" % (tmp_dir))

                        return False

                #导出到tmp目录
                os.system("cp ebin/*.beam %s/ebin" % (tmp_dir,))
                os.system("svn export app_cfg %s/app_cfg" % (tmp_dir,))
                os.system("svn export sh %s/sh" % (tmp_dir,))
                os.system("cp -R sh/db/gtools %s/sh/db/" % (tmp_dir,))
                os.system("svn export sql %s/sql" % (tmp_dir,))

                if ident != "alpha":
                        server_config = "%s/app_cfg/server.config" % (tmp_dir,)

                        content = file_util.read_file(server_config)

                        content = str_util.str_repl("\{\s*can_use_gm_cmd,\s*\d+\s*\}", content, "{can_use_gm_cmd, 0}")
                        content = str_util.str_repl("\{\s*sys_log_level,\s*\d+\s*\}", content, "{sys_log_level, 3}")
                        #content = str_util.str_repl("\{\s*min_play_ol_num,\s*\d+\s*\}", content, "{min_play_ol_num, 500}")
                        #content = str_util.str_repl("\{\s*nor_play_ol_num,\s*\d+\s*\}", content, "{nor_play_ol_num, 1200}")
                        #content = str_util.str_repl("\{\s*max_play_ol_num,\s*\d+\s*\}", content, "{max_play_ol_num, 2000}")
                        #content = str_util.str_repl("\{\s*max_wait_ol_num,\s*\d+\s*\}", content, "{max_wait_ol_num, 1000}")
                        content = str_util.str_repl("\{\s*check_heartbeat_timeout,\s*\d+\s*\}", content, "{check_heartbeat_timeout, 1}")
                        #content = str_util.str_repl("\{\s*sasl_error_logger,\s*\w+\s*\}", content, "{sasl_error_logger, false}")
                        content = str_util.str_repl("\{\s*check_admin_security,\s*\d+\s*\}", content, "{check_admin_security, 1}")

                        file_util.write_file(server_config, content)

                #增加可执行权限
                os.system("chmod a+x -R %s/sh" % (tmp_dir,))

                return True

if __name__ == "__main__":
        flow = Pack(__file__)   # __file__为本模块名，即："pack.py"

        flow.pack()